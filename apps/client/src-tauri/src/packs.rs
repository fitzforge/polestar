//! Community guide packs from polestar.guide: the signed pack index, what is
//! installed, and installing, updating and removing packs safely.
//!
//! The index (`/api/v1/packs/index.json`) is trusted only with its detached
//! ed25519 signature (`index.json.sig`) from a key pinned below, over the exact
//! bytes received; an index older than the last one accepted (a rollback) or
//! past its `expires` is refused. A pack's zip must match the index's SHA-256
//! and size, hold only the folders the index lists (`PolestarPack_<id>` and
//! `PolestarPack_<id>_<locale>`) with addon files in them, and carry its id in
//! each TOC. A pack only ever writes or removes its own folders: ones that do
//! not exist yet or already carry the same id. Polestar's own folders and every
//! other addon are never touched. The swap itself is the Addons page's
//! (addons.rs): staged, backed up, put back on failure.

use std::fs;
use std::io::{self, Read};
use std::path::{Component, Path};

use base64::Engine as _;
use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};

use crate::addons::{fresh_dir, hex, newer, safe_component, swap, toc_field, Progress, STAGING};

/// The community site in release builds; Settings > Advanced can point elsewhere.
pub const DEFAULT_BASE: &str = "https://polestar.guide";
const INDEX_PATH: &str = "/api/v1/packs/index.json";
const INSTALLS_PATH: &str = "/api/v1/installs";
/// The largest pack zip, and the most it may unpack to.
pub const MAX_ZIP: u64 = 20 * 1024 * 1024;
const MAX_UNPACKED: u64 = 100 * 1024 * 1024;
const MAX_ENTRIES: usize = 10_000;
/// The index is a list of short entries: anything near this is not one.
const MAX_INDEX: usize = 8 * 1024 * 1024;
const WEEK_MS: i64 = 7 * 24 * 3600 * 1000;
/// The main folder's TOC names its pack; a locale folder's names the pack its texts belong to.
const PACK_FIELD: &str = "X-Polestar-Pack";
const TEXTS_FIELD: &str = "X-Polestar-Texts";
const FOLDER_PREFIX: &str = "PolestarPack_";
/// What a pack folder may hold besides LICENSE* and README* texts.
const FILE_KINDS: [&str; 6] = ["toc", "lua", "xml", "tga", "blp", "png"];

/// A public key the index may be signed with.
pub struct PinnedKey {
	pub id: &'static str,
	pub key: [u8; 32],
}

/// The production signing keys (the current one and the next, for rotation). Empty until the
/// production key is made: until then a release build pointed at polestar.guide has no
/// community packs and says so.
pub const RELEASE_KEYS: &[PinnedKey] = &[];

/// The development site's key (polestar-site's `.env.local`), trusted only by debug builds or
/// when the configured site is on this PC.
pub const DEV_KEYS: &[PinnedKey] = &[PinnedKey {
	id: "polestar-dev-1",
	key: [
		0x78, 0x93, 0x23, 0x59, 0xa5, 0xda, 0x15, 0x57, 0xc4, 0xb5, 0xa7, 0x16, 0x0e, 0xb9, 0x26, 0xaa, 0xeb, 0xce, 0x67, 0x94, 0x39, 0xd6, 0x02, 0xab, 0xf2, 0xec, 0xc9, 0x05, 0x2f, 0x6b, 0x52, 0x17,
	],
}];

/// Is this address on this PC (`http://localhost:3100`)?
pub fn is_local(url: &str) -> bool {
	tauri::Url::parse(url).is_ok_and(|u| matches!(u.host_str(), Some("localhost" | "127.0.0.1" | "[::1]")))
}

/// The keys an index from `base` may be signed with.
pub fn keys_for(base: &str) -> Vec<&'static PinnedKey> {
	let dev = cfg!(debug_assertions) || is_local(base);
	RELEASE_KEYS.iter().chain(DEV_KEYS.iter().filter(|_| dev)).collect()
}

/// `^[a-z0-9][a-z0-9-]{1,31}$`
pub fn valid_id(id: &str) -> bool {
	let b = id.as_bytes();
	(2..=32).contains(&b.len()) && (b[0].is_ascii_lowercase() || b[0].is_ascii_digit()) && b.iter().all(|&c| c.is_ascii_lowercase() || c.is_ascii_digit() || c == b'-')
}

/// A WoW locale: `deDE`, `ptBR`, `zhCN`.
fn valid_locale(locale: &str) -> bool {
	let b = locale.as_bytes();
	b.len() == 4 && b[..2].iter().all(u8::is_ascii_lowercase) && b[2..].iter().all(u8::is_ascii_uppercase)
}

pub fn main_folder(id: &str) -> String {
	format!("{FOLDER_PREFIX}{id}")
}

/// What a pack folder name says: its pack and, for a locale folder, its locale.
fn parse_folder(name: &str) -> Option<(&str, Option<&str>)> {
	let rest = name.strip_prefix(FOLDER_PREFIX)?;
	// Ids hold no `_`, so the first one starts the locale.
	let (id, locale) = match rest.split_once('_') {
		Some((id, locale)) => (id, Some(locale)),
		None => (rest, None),
	};
	(valid_id(id) && locale.is_none_or(valid_locale)).then_some((id, locale))
}

/// The pack a folder in AddOns belongs to, by its TOC (`X-Polestar-Pack` in the main folder,
/// `X-Polestar-Texts` in a locale folder); `None` when it carries no such id.
fn folder_owner(folder: &Path, locale: bool) -> Option<String> {
	toc_field(folder, if locale { TEXTS_FIELD } else { PACK_FIELD })
}

// ---------------------------------------------------------------------------------------------
// The index

#[derive(Deserialize, Serialize, Clone, Debug, PartialEq)]
pub struct Download {
	pub url: String,
	pub sha256: String,
	pub size: u64,
}

#[derive(Deserialize, Serialize, Clone, Debug, PartialEq)]
#[serde(rename_all = "camelCase")]
pub struct Entry {
	pub id: String,
	pub addon: Vec<String>,
	pub title: String,
	pub author: String,
	pub version: String,
	pub channel: String,
	pub download: Download,
	pub toc: u32,
	#[serde(default)]
	pub min_polestar: Option<String>,
	#[serde(default)]
	pub homepage: Option<String>,
	#[serde(default)]
	pub changelog: String,
	#[serde(default)]
	pub official: bool,
}

#[derive(Clone, Debug)]
pub struct Index {
	/// `generated`, epoch milliseconds: an index older than the last accepted one is refused.
	pub generated: i64,
	pub expires: i64,
	pub packs: Vec<Entry>,
}

impl Index {
	pub fn get(&self, id: &str) -> Option<&Entry> {
		self.packs.iter().find(|p| p.id == id)
	}
}

#[derive(Deserialize)]
struct RawIndex {
	schema: u32,
	generated: String,
	expires: String,
	packs: Vec<serde_json::Value>,
}

#[derive(Deserialize)]
#[serde(rename_all = "camelCase")]
struct Signature {
	key_id: String,
	alg: String,
	sig: String,
	sha256: String,
}

/// `2026-10-27T16:41:44.877Z` in epoch milliseconds (UTC only, as the site writes it).
pub fn parse_time(text: &str) -> Option<i64> {
	let b = text.as_bytes();
	if b.len() < 20 || b[4] != b'-' || b[7] != b'-' || b[10] != b'T' || b[13] != b':' || b[16] != b':' || *b.last()? != b'Z' {
		return None;
	}
	let num = |r: std::ops::Range<usize>| text.get(r).filter(|s| s.bytes().all(|c| c.is_ascii_digit())).and_then(|s| s.parse::<i64>().ok());
	let (y, mo, d, h, mi, s) = (num(0..4)?, num(5..7)?, num(8..10)?, num(11..13)?, num(14..16)?, num(17..19)?);
	let frac = &text[19..text.len() - 1];
	let ms = match frac.strip_prefix('.') {
		None if frac.is_empty() => 0,
		Some(digits) if !digits.is_empty() && digits.len() <= 9 && digits.bytes().all(|c| c.is_ascii_digit()) => format!("{digits:0<3}")[..3].parse::<i64>().ok()?,
		_ => return None,
	};
	if !(1..=12).contains(&mo) || !(1..=31).contains(&d) || h > 23 || mi > 59 || s > 60 {
		return None;
	}
	// Days from the civil date (Howard Hinnant's algorithm).
	let y = if mo <= 2 { y - 1 } else { y };
	let era = y.div_euclid(400);
	let yoe = y - era * 400;
	let mp = (mo + 9) % 12;
	let doy = (153 * mp + 2) / 5 + d - 1;
	let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
	let days = era * 146_097 + doe - 719_468;
	Some(((days * 24 + h) * 60 + mi) * 60_000 + s * 1000 + ms)
}

/// Checks the signature and the index it signs: a pinned key (by `keyId`), the SHA-256 of the
/// exact bytes, the ed25519 signature, the schema, not expired, not older than `last` (the
/// `generated` of the last index accepted from this site). Entries that break the contract are
/// left out (and said on stderr); the rest stands.
pub fn verify_index(bytes: &[u8], sig: &[u8], keys: &[&PinnedKey], base: &str, now: i64, last: Option<i64>) -> Result<Index, String> {
	let sig: Signature = serde_json::from_slice(sig).map_err(|e| format!("The community index's signature is unreadable ({e})."))?;
	if sig.alg != "ed25519" {
		return Err(format!("The community index is signed with {}, which Polestar Client does not accept.", sig.alg));
	}
	let key = keys.iter().find(|k| k.id == sig.key_id).ok_or_else(|| format!("The community index is signed with a key Polestar Client doesn't know ({}); not using it.", sig.key_id))?;
	if !hex(&Sha256::digest(bytes)).eq_ignore_ascii_case(sig.sha256.trim()) {
		return Err("The community index doesn't match its signature (another copy was signed); not using it.".to_owned());
	}
	let signature = base64::engine::general_purpose::STANDARD.decode(sig.sig.trim()).map_err(|_| "The community index's signature is unreadable.".to_owned())?;
	ring::signature::UnparsedPublicKey::new(&ring::signature::ED25519, key.key)
		.verify(bytes, &signature)
		.map_err(|_| "The community index's signature is not valid; not using it.".to_owned())?;
	let raw: RawIndex = serde_json::from_slice(bytes).map_err(|e| format!("The community index is unreadable ({e})."))?;
	if raw.schema != 1 {
		return Err(format!("The community index is in a newer format ({}); update Polestar Client to use it.", raw.schema));
	}
	let generated = parse_time(&raw.generated).ok_or("The community index has no valid date.")?;
	let expires = parse_time(&raw.expires).ok_or("The community index has no valid expiry date.")?;
	if expires <= generated || expires - generated > WEEK_MS {
		return Err("The community index's expiry date is not one week after its date; not using it.".to_owned());
	}
	if now >= expires {
		return Err("The community index has expired: polestar.guide hasn't renewed it. Try again later.".to_owned());
	}
	if let Some(last) = last.filter(|&last| generated < last) {
		return Err(format!("This community index is older than one already seen ({} < {last}); an old copy is being replayed, so it is not used.", generated));
	}
	let mut packs: Vec<Entry> = Vec::with_capacity(raw.packs.len());
	for value in raw.packs {
		match serde_json::from_value::<Entry>(value).map_err(|e| e.to_string()).and_then(|e| check_entry(e, base)) {
			Ok(entry) if packs.iter().any(|p| p.id == entry.id) => eprintln!("community index: {} is listed twice; the first stands", entry.id),
			Ok(entry) => packs.push(entry),
			Err(e) => eprintln!("community index: an entry left out: {e}"),
		}
	}
	Ok(Index { generated, expires, packs })
}

/// An index entry as the contract has it; `None`-able bits normalised (a homepage that is not
/// https is dropped).
fn check_entry(mut e: Entry, base: &str) -> Result<Entry, String> {
	if !valid_id(&e.id) {
		return Err(format!("bad id {:?}", e.id));
	}
	let main = main_folder(&e.id);
	if !e.addon.contains(&main) {
		return Err(format!("{}: its folders don't include {main}", e.id));
	}
	for (i, folder) in e.addon.iter().enumerate() {
		if parse_folder(folder).is_none_or(|(id, _)| id != e.id) || e.addon[..i].contains(folder) {
			return Err(format!("{}: folder {folder:?} is not one of its own", e.id));
		}
	}
	if e.channel != "stable" {
		return Err(format!("{}: channel {}", e.id, e.channel));
	}
	let text_ok = |s: &str, max: usize| !s.trim().is_empty() && s.chars().count() <= max && !s.chars().any(char::is_control);
	if !text_ok(&e.title, 80) || !text_ok(&e.author, 64) || !text_ok(&e.version, 32) {
		return Err(format!("{}: title, author or version missing or too long", e.id));
	}
	let url = tauri::Url::parse(&e.download.url).map_err(|_| format!("{}: download is not an address", e.id))?;
	let local = matches!(url.host_str(), Some("localhost" | "127.0.0.1" | "[::1]"));
	if !(url.scheme() == "https" || (url.scheme() == "http" && local && is_local(base))) {
		return Err(format!("{}: download is not https", e.id));
	}
	if e.download.sha256.len() != 64 || !e.download.sha256.bytes().all(|c| c.is_ascii_hexdigit()) {
		return Err(format!("{}: bad sha256", e.id));
	}
	e.download.sha256.make_ascii_lowercase();
	if e.download.size == 0 || e.download.size > MAX_ZIP {
		return Err(format!("{}: size {} is outside 1 byte to 20 MB", e.id, e.download.size));
	}
	if e.min_polestar.as_deref().is_some_and(|v| v.is_empty() || v.len() > 32) {
		e.min_polestar = None;
	}
	if e.homepage.as_deref().is_some_and(|h| !h.starts_with("https://") || tauri::Url::parse(h).is_err()) {
		e.homepage = None;
	}
	e.changelog = e.changelog.chars().take(20_000).collect();
	Ok(e)
}

/// The id of the index in an ETag (`"6-1793119304877"`): the signature to ask for.
pub fn snapshot_id(etag: &str) -> Option<&str> {
	let tag = etag.trim().trim_start_matches("W/").trim_matches('"');
	let id = tag.split('-').next()?;
	(!id.is_empty() && id.bytes().all(|c| c.is_ascii_digit())).then_some(id)
}

pub enum Fetched {
	/// 304: the index held is still the current one.
	NotModified,
	New { body: Vec<u8>, sig: Vec<u8>, etag: Option<String> },
}

/// Fetches the index (with the ETag of the one held, when there is one) and its signature.
pub async fn fetch_index(http: &reqwest::Client, base: &str, etag: Option<&str>) -> Result<Fetched, String> {
	let failed = |e: reqwest::Error| format!("Could not reach {}: {e}", host(base));
	let mut request = http.get(format!("{base}{INDEX_PATH}"));
	if let Some(etag) = etag {
		request = request.header("If-None-Match", etag);
	}
	let response = request.send().await.map_err(failed)?;
	if response.status() == reqwest::StatusCode::NOT_MODIFIED {
		return Ok(Fetched::NotModified);
	}
	if !response.status().is_success() {
		return Err(format!("{} answered {} for the community index.", host(base), response.status()));
	}
	let etag = response.headers().get("etag").and_then(|v| v.to_str().ok()).map(str::to_owned);
	let body = read_capped(response, MAX_INDEX).await.map_err(|e| format!("Reading the community index failed: {e}"))?;
	let sig_url = match etag.as_deref().and_then(snapshot_id) {
		Some(id) => format!("{base}{INDEX_PATH}.sig?for={id}"),
		None => format!("{base}{INDEX_PATH}.sig"),
	};
	let response = http.get(sig_url).send().await.map_err(failed)?;
	if !response.status().is_success() {
		return Err(format!("{} has no signature for its community index yet ({}). Try again later.", host(base), response.status()));
	}
	let sig = read_capped(response, 4096).await.map_err(|e| format!("Reading the community index's signature failed: {e}"))?;
	Ok(Fetched::New { body, sig, etag })
}

async fn read_capped(mut response: reqwest::Response, max: usize) -> Result<Vec<u8>, String> {
	let mut out = Vec::new();
	while let Some(chunk) = response.chunk().await.map_err(|e| e.to_string())? {
		out.extend_from_slice(&chunk);
		if out.len() > max {
			return Err("far bigger than expected".to_owned());
		}
	}
	Ok(out)
}

/// `polestar.guide` from `https://polestar.guide`.
pub fn host(base: &str) -> String {
	tauri::Url::parse(base).ok().and_then(|u| u.host_str().map(|h| u.port().map_or_else(|| h.to_owned(), |p| format!("{h}:{p}")))).unwrap_or_else(|| base.to_owned())
}

/// Says an install to the site (opt-in, Settings): `{pack, version}`, nothing else.
pub async fn report_install(http: &reqwest::Client, base: &str, id: &str, version: &str) {
	let body = serde_json::json!({ "pack": id, "version": version });
	if let Err(e) = http.post(format!("{base}{INSTALLS_PATH}")).json(&body).send().await.and_then(|r| r.error_for_status()) {
		eprintln!("Could not count the install of {id}: {e}");
	}
}

// ---------------------------------------------------------------------------------------------
// Compatibility

/// The TOC Interface number of a game version: `1.60.1.62345` -> 16001.
pub fn interface_of(game_version: &str) -> Option<u32> {
	let mut parts = game_version.split('.').map(|p| p.parse::<u32>().ok());
	let (a, b, c) = (parts.next()??, parts.next()??, parts.next()??);
	(b < 100 && c < 100).then_some(a * 10_000 + b * 100 + c)
}

fn interface_name(interface: u32) -> String {
	format!("{}.{}.{}", interface / 10_000, interface / 100 % 100, interface % 100)
}

/// Why this pack can't go into this game now, or `None` when it can: the game must be the
/// version it was made for, and Polestar at least the version it needs.
pub fn blocked(entry: &Entry, interface: Option<u32>, polestar: Option<&str>) -> Option<String> {
	match interface {
		None => return Some("Polestar Client couldn't read your game's version, so it can't tell whether this guide fits it.".to_owned()),
		Some(have) if have != entry.toc => {
			return Some(format!("Made for game version {}; your game is {}.", interface_name(entry.toc), interface_name(have)));
		}
		_ => {}
	}
	let need = entry.min_polestar.as_deref()?;
	match polestar {
		None => Some(format!("Needs Polestar {need} or newer. Install Polestar on the Addons page first.")),
		Some(have) if newer(need, have) => Some(format!("Needs Polestar {need} or newer; you have {have}. Update it on the Addons page.")),
		_ => None,
	}
}

// ---------------------------------------------------------------------------------------------
// What is installed

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Installed {
	pub id: String,
	pub version: Option<String>,
	pub title: Option<String>,
	pub author: Option<String>,
	/// The main folder first, then its locale folders.
	pub folders: Vec<String>,
}

/// The packs in `addons`: every `PolestarPack_<id>` folder whose TOC says it is pack `<id>`,
/// with the locale folders that say they belong to it.
pub fn installed(addons: &Path) -> Vec<Installed> {
	let Ok(entries) = fs::read_dir(addons) else { return Vec::new() };
	let mut names: Vec<String> = entries.filter_map(|e| e.ok()).filter(|e| e.file_type().is_ok_and(|t| t.is_dir())).filter_map(|e| e.file_name().into_string().ok()).filter(|n| n.starts_with(FOLDER_PREFIX)).collect();
	names.sort();
	let mut packs: Vec<Installed> = Vec::new();
	for name in names.iter() {
		let Some((id, None)) = parse_folder(name) else { continue };
		let dir = addons.join(name);
		if folder_owner(&dir, false).as_deref() != Some(id) {
			continue;
		}
		let title = toc_field(&dir, "Title").map(|t| t.strip_prefix("Polestar Community: ").map(str::to_owned).unwrap_or(t));
		packs.push(Installed { id: id.to_owned(), version: toc_field(&dir, "Version"), title, author: toc_field(&dir, "Author"), folders: vec![name.clone()] });
	}
	for name in names.iter() {
		let Some((id, Some(_))) = parse_folder(name) else { continue };
		if let Some(pack) = packs.iter_mut().find(|p| p.id == id) {
			if folder_owner(&addons.join(name), true).as_deref() == Some(id) {
				pack.folders.push(name.clone());
			}
		}
	}
	packs
}

/// Every listed folder must be free or already this pack's.
fn check_ownership(addons: &Path, entry: &Entry) -> Result<(), String> {
	for folder in &entry.addon {
		let path = addons.join(folder);
		let Ok(meta) = fs::symlink_metadata(&path) else { continue };
		let locale = parse_folder(folder).is_some_and(|(_, l)| l.is_some());
		let owner = meta.is_dir().then(|| folder_owner(&path, locale)).flatten();
		if owner.as_deref() != Some(entry.id.as_str()) {
			let whose = owner.map_or_else(|| "something else".to_owned(), |o| format!("the guide {o}"));
			return Err(format!("AddOns already has a {folder} that belongs to {whose}, not to {}; Polestar Client leaves it alone. Move it away to install this guide.", entry.title));
		}
	}
	Ok(())
}

// ---------------------------------------------------------------------------------------------
// Installing and removing

/// Downloads the pack's zip, at most its listed size, telling `progress` the bytes so far.
async fn download(http: &reqwest::Client, entry: &Entry, progress: &(dyn Fn(u64, Option<u64>) + Sync)) -> Result<Vec<u8>, String> {
	let size = entry.download.size;
	let failed = |e: reqwest::Error| format!("Downloading {} failed: {e}", entry.title);
	let mut response = http.get(&entry.download.url).send().await.map_err(failed)?;
	if !response.status().is_success() {
		return Err(format!("Downloading {} failed: the site answered {}.", entry.title, response.status()));
	}
	if response.content_length().is_some_and(|n| n > size) {
		return Err(format!("{}'s download is bigger than the index says; not installing it.", entry.title));
	}
	let mut bytes = Vec::with_capacity(size as usize);
	while let Some(chunk) = response.chunk().await.map_err(failed)? {
		bytes.extend_from_slice(&chunk);
		if bytes.len() as u64 > size {
			return Err(format!("{}'s download is bigger than the index says; not installing it.", entry.title));
		}
		progress(bytes.len() as u64, Some(size));
	}
	Ok(bytes)
}

/// The zip is the one the signed index names: its size and SHA-256.
fn verify_zip(entry: &Entry, bytes: &[u8]) -> Result<(), String> {
	if bytes.len() as u64 != entry.download.size {
		return Err(format!("{}'s download is {} bytes, not the {} the index says; not installing it.", entry.title, bytes.len(), entry.download.size));
	}
	if hex(&Sha256::digest(bytes)) != entry.download.sha256 {
		return Err(format!("{}'s download doesn't match the checksum in the signed index; not installing it.", entry.title));
	}
	Ok(())
}

fn allowed_file(name: &str) -> bool {
	let (stem, ext) = match name.rsplit_once('.') {
		Some((stem, ext)) => (stem, ext.to_ascii_lowercase()),
		None => (name, String::new()),
	};
	if FILE_KINDS.contains(&ext.as_str()) && !stem.is_empty() {
		return true;
	}
	let upper = stem.to_ascii_uppercase();
	(upper.starts_with("LICENSE") || upper.starts_with("README")) && matches!(ext.as_str(), "" | "txt" | "md")
}

/// Unpacks a pack zip into `staging`; returns the folders it held. Everything must be inside the
/// entry's folders, of an allowed kind, within the size caps, and stay inside the folder
/// (zip slip): one thing out of place fails the whole zip.
fn unpack(bytes: &[u8], staging: &Path, entry: &Entry) -> Result<Vec<String>, String> {
	let bad = |what: String| format!("{}'s download {what}; not installing it.", entry.title);
	let mut archive = zip::ZipArchive::new(io::Cursor::new(bytes)).map_err(|e| bad(format!("is not a usable zip ({e})")))?;
	if archive.len() > MAX_ENTRIES {
		return Err(bad("holds too many files".to_owned()));
	}
	let mut folders: Vec<String> = Vec::new();
	let mut total: u64 = 0;
	for i in 0..archive.len() {
		let mut file = archive.by_index(i).map_err(|e| bad(format!("is not a usable zip ({e})")))?;
		let name = file.name().to_owned();
		let Some(path) = file.enclosed_name() else { return Err(bad(format!("has an unsafe path ({name})"))) };
		if path.components().any(|c| !matches!(c, Component::Normal(n) if n.to_str().is_some_and(safe_component))) {
			return Err(bad(format!("has an unsafe path ({name})")));
		}
		if file.is_symlink() {
			return Err(bad(format!("holds a link ({name})")));
		}
		let mut parts = path.components();
		let Some(Component::Normal(top)) = parts.next() else { continue };
		let top = top.to_str().ok_or_else(|| bad("has a folder name that is not text".to_owned()))?.to_owned();
		let inner = parts.as_path();
		if inner.as_os_str().is_empty() && !file.is_dir() {
			return Err(bad(format!("has a file outside its folders ({name})")));
		}
		if !entry.addon.contains(&top) {
			return Err(bad(format!("holds a folder that isn't this guide's ({top})")));
		}
		if !folders.contains(&top) {
			folders.push(top.clone());
		}
		let target = staging.join(&path);
		if file.is_dir() {
			fs::create_dir_all(&target).map_err(|e| e.to_string())?;
			continue;
		}
		let file_name = inner.file_name().and_then(|n| n.to_str()).unwrap_or("");
		if !allowed_file(file_name) {
			return Err(bad(format!("holds a file guides may not hold ({name})")));
		}
		let room = MAX_UNPACKED - total;
		if file.size() > room {
			return Err(bad("unpacks to more than 100 MB".to_owned()));
		}
		let mut data = Vec::with_capacity(file.size() as usize);
		// Never more than the cap, whatever the zip's header claims.
		(&mut file).take(room + 1).read_to_end(&mut data).map_err(|e| bad(format!("is not a usable zip ({e})")))?;
		total += data.len() as u64;
		if total > MAX_UNPACKED {
			return Err(bad("unpacks to more than 100 MB".to_owned()));
		}
		if let Some(parent) = target.parent() {
			fs::create_dir_all(parent).map_err(|e| e.to_string())?;
		}
		fs::write(&target, data).map_err(|e| e.to_string())?;
	}
	folders.sort();
	Ok(folders)
}

/// Every listed folder came, each with its TOC naming this pack.
fn check(staging: &Path, entry: &Entry, folders: &[String]) -> Result<(), String> {
	let bad = |what: String| Err(format!("{}'s download {what}; not installing it.", entry.title));
	for folder in &entry.addon {
		if !folders.contains(folder) {
			return bad(format!("has no {folder} folder"));
		}
		let locale = parse_folder(folder).is_some_and(|(_, l)| l.is_some());
		let toc = staging.join(folder).join(format!("{folder}.toc"));
		if !toc.is_file() {
			return bad(format!("has no {folder}.toc"));
		}
		if folder_owner(&staging.join(folder), locale).as_deref() != Some(entry.id.as_str()) {
			let field = if locale { TEXTS_FIELD } else { PACK_FIELD };
			return bad(format!("doesn't say it is {} in {folder}.toc (## {field}: {})", entry.id, entry.id));
		}
	}
	Ok(())
}

/// Downloads, checks and installs (or updates) a pack, telling `report` how far it has got;
/// returns the folders installed.
pub async fn install(http: &reqwest::Client, entry: &Entry, addons: &Path, report: &(dyn Fn(Progress) + Sync)) -> Result<Vec<String>, String> {
	check_ownership(addons, entry)?;
	let bytes = download(http, entry, &|done, total| report(Progress { phase: "download", done, total })).await?;
	report(Progress::step("verify"));
	verify_zip(entry, &bytes)?;
	report(Progress::step("install"));
	let (addons, entry) = (addons.to_owned(), entry.clone());
	tauri::async_runtime::spawn_blocking(move || install_zip(&bytes, &entry, &addons)).await.map_err(|e| e.to_string())?
}

/// Unpacks a checked zip and swaps it in (the blocking half of [`install`]).
fn install_zip(bytes: &[u8], entry: &Entry, addons: &Path) -> Result<Vec<String>, String> {
	fs::create_dir_all(addons).map_err(|e| format!("Could not create {}: {e}", addons.display()))?;
	let staging = fresh_dir(addons, STAGING).map_err(|e| format!("Could not prepare the install: {e}"))?;
	let result = unpack(bytes, &staging, entry).and_then(|folders| {
		check(&staging, entry, &folders)?;
		// Again, now: nothing may have taken a folder since the download started.
		check_ownership(addons, entry)?;
		// An update also clears this pack's locale folders the new version no longer has.
		let obsolete: Vec<String> = installed(addons).into_iter().filter(|p| p.id == entry.id).flat_map(|p| p.folders).filter(|f| !folders.contains(f)).collect();
		swap(addons, &staging, &folders, &obsolete)?;
		Ok(folders)
	});
	let _ = fs::remove_dir_all(&staging);
	result
}

/// Removes a pack's own folders (and nothing else); returns them.
pub fn uninstall(id: &str, addons: &Path) -> Result<Vec<String>, String> {
	let folders: Vec<String> = installed(addons).into_iter().filter(|p| p.id == id).flat_map(|p| p.folders).collect();
	if folders.is_empty() {
		return Ok(folders);
	}
	let staging = fresh_dir(addons, STAGING).map_err(|e| format!("Could not prepare the removal: {e}"))?;
	let result = swap(addons, &staging, &[], &folders).map(|()| folders);
	let _ = fs::remove_dir_all(&staging);
	result
}

// ---------------------------------------------------------------------------------------------
// Links

/// The pack a `polestar://install?pack=<id>` link asks for. Other parameters (a future
/// `version=`) are ignored.
pub fn parse_link(link: &str) -> Result<String, String> {
	let url = tauri::Url::parse(link.trim()).map_err(|_| "That link isn't one Polestar Client can open.".to_owned())?;
	let action = url.host_str().map(str::to_owned).unwrap_or_else(|| url.path().trim_matches('/').to_owned());
	if url.scheme() != "polestar" || !action.eq_ignore_ascii_case("install") || !matches!(url.path(), "" | "/") && url.host_str().is_some() {
		return Err("That link isn't one Polestar Client can open. Links from polestar.guide install a Community Guide.".to_owned());
	}
	let pack = url.query_pairs().find(|(k, _)| k == "pack").map(|(_, v)| v.into_owned()).ok_or("That install link doesn't say which guide to install.")?;
	if !valid_id(&pack) {
		let shown: String = pack.chars().take(40).collect();
		return Err(format!("\"{shown}\" isn't a guide name: they are 2 to 32 lowercase letters, digits and dashes. Copy the link from the guide's page on polestar.guide again."));
	}
	Ok(pack)
}

#[cfg(test)]
mod tests {
	use super::*;
	use std::io::Write;

	use ring::signature::KeyPair;

	const NOW: i64 = 1_793_119_304_877 + 1000;

	fn temp(name: &str) -> std::path::PathBuf {
		let dir = std::env::temp_dir().join(format!("polestar-packs-test-{name}-{}", std::process::id()));
		let _ = fs::remove_dir_all(&dir);
		fs::create_dir_all(&dir).unwrap();
		dir
	}

	fn zip_of(files: &[(&str, &[u8])]) -> Vec<u8> {
		let mut out = io::Cursor::new(Vec::new());
		let mut w = zip::ZipWriter::new(&mut out);
		for (name, body) in files {
			w.start_file(*name, zip::write::SimpleFileOptions::default()).unwrap();
			w.write_all(body).unwrap();
		}
		w.finish().unwrap();
		out.into_inner()
	}

	fn entry(id: &str, zip: &[u8]) -> Entry {
		Entry {
			id: id.to_owned(),
			addon: vec![main_folder(id)],
			title: format!("Pack {id}"),
			author: "Tester".to_owned(),
			version: "1.0.0".to_owned(),
			channel: "stable".to_owned(),
			download: Download { url: format!("https://polestar.guide/api/v1/packs/{id}/1.0.0/download"), sha256: hex(&Sha256::digest(zip)), size: zip.len() as u64 },
			toc: 16001,
			min_polestar: Some("0.2.5".to_owned()),
			homepage: None,
			changelog: String::new(),
			official: false,
		}
	}

	fn toc(id: &str, version: &str) -> String {
		format!("## Interface: 16001\n## Title: Polestar Community: Pack {id}\n## Author: Tester\n## Version: {version}\n## X-Polestar-Pack: {id}\n")
	}

	/// A signed index made with a fresh key, and that key pinned as `test-1`.
	struct Signer {
		pair: ring::signature::Ed25519KeyPair,
		pinned: PinnedKey,
	}

	impl Signer {
		fn new() -> Signer {
			let rng = ring::rand::SystemRandom::new();
			let pkcs8 = ring::signature::Ed25519KeyPair::generate_pkcs8(&rng).unwrap();
			let pair = ring::signature::Ed25519KeyPair::from_pkcs8(pkcs8.as_ref()).unwrap();
			let key: [u8; 32] = pair.public_key().as_ref().try_into().unwrap();
			Signer { pair, pinned: PinnedKey { id: "test-1", key } }
		}

		fn sign(&self, body: &[u8], key_id: &str) -> Vec<u8> {
			let sig = base64::engine::general_purpose::STANDARD.encode(self.pair.sign(body).as_ref());
			serde_json::to_vec(&serde_json::json!({ "keyId": key_id, "alg": "ed25519", "sig": sig, "sha256": hex(&Sha256::digest(body)) })).unwrap()
		}
	}

	fn index_body(generated: &str, expires: &str) -> Vec<u8> {
		let pack = serde_json::json!({
			"id": "emberway", "addon": ["PolestarPack_emberway"], "title": "Emberway Routes", "author": "Ashka", "version": "1.0.0",
			"channel": "stable", "download": { "url": "https://polestar.guide/api/v1/packs/emberway/1.0.0/download", "sha256": "76eca11a179b9fd32c2798f6b9bd7eeab0c5c4c7f50f4732f0b99362cc55d618", "size": 10251 },
			"toc": 16001, "minPolestar": "0.2.5", "homepage": null, "changelog": "First release."
		});
		let bad = serde_json::json!({ "id": "Bad_Id", "addon": ["PolestarPack_Bad_Id"], "title": "x", "author": "x", "version": "1", "channel": "stable", "download": { "url": "https://x/y", "sha256": "00", "size": 1 }, "toc": 16001 });
		format!("{}\n", serde_json::to_string_pretty(&serde_json::json!({ "schema": 1, "generated": generated, "expires": expires, "packs": [pack, bad] })).unwrap()).into_bytes()
	}

	#[test]
	fn the_pinned_dev_key_verifies_the_dev_site() {
		assert_eq!(base64::engine::general_purpose::URL_SAFE_NO_PAD.decode("eJMjWaXaFVfEtacWDrkmquvOZ5Q51gKr8uzJBS9rUhc").unwrap(), DEV_KEYS[0].key);
		let body = include_bytes!("fixtures/dev-index.json");
		let sig = include_bytes!("fixtures/dev-index.json.sig");
		let index = verify_index(body, sig, &keys_for("http://localhost:3100"), "http://localhost:3100", NOW, None).unwrap();
		assert_eq!(index.packs.len(), 6);
		assert!(index.get("emberway").is_some());
		// Release builds trust the dev key only for a site on this PC.
		assert!(cfg!(debug_assertions) || keys_for(DEFAULT_BASE).is_empty());
		assert!(keys_for("http://127.0.0.1:3100").iter().any(|k| k.id == "polestar-dev-1"));
	}

	#[test]
	fn signatures_are_checked() {
		let signer = Signer::new();
		let keys = [&signer.pinned];
		let body = index_body("2026-10-27T16:41:44.877Z", "2026-11-03T16:41:44.877Z");
		// Good: the bad entry is left out, the good one stands.
		let index = verify_index(&body, &signer.sign(&body, "test-1"), &keys, DEFAULT_BASE, NOW, None).unwrap();
		assert_eq!(index.packs.iter().map(|p| p.id.as_str()).collect::<Vec<_>>(), ["emberway"]);
		assert_eq!(index.generated, NOW - 1000);
		// One byte changed after signing.
		let sig = signer.sign(&body, "test-1");
		let mut tampered = body.clone();
		let at = tampered.iter().position(|&b| b == b'A').unwrap();
		tampered[at] = b'B';
		assert!(verify_index(&tampered, &sig, &keys, DEFAULT_BASE, NOW, None).unwrap_err().contains("doesn't match"));
		// The hash fixed up too: the signature itself fails.
		let mut forged: serde_json::Value = serde_json::from_slice(&sig).unwrap();
		forged["sha256"] = hex(&Sha256::digest(&tampered)).into();
		assert!(verify_index(&tampered, &serde_json::to_vec(&forged).unwrap(), &keys, DEFAULT_BASE, NOW, None).unwrap_err().contains("not valid"));
		// A key nobody pinned.
		assert!(verify_index(&body, &signer.sign(&body, "someone-else"), &keys, DEFAULT_BASE, NOW, None).unwrap_err().contains("doesn't know"));
		// A pinned id with the wrong key behind it.
		let other = Signer::new();
		assert!(verify_index(&body, &other.sign(&body, "test-1"), &keys, DEFAULT_BASE, NOW, None).unwrap_err().contains("not valid"));
	}

	#[test]
	fn rollback_and_expiry_are_refused() {
		let signer = Signer::new();
		let keys = [&signer.pinned];
		let body = index_body("2026-10-27T16:41:44.877Z", "2026-11-03T16:41:44.877Z");
		let sig = signer.sign(&body, "test-1");
		let generated = parse_time("2026-10-27T16:41:44.877Z").unwrap();
		// The same index again is fine; an older one than the last accepted is a replay.
		assert!(verify_index(&body, &sig, &keys, DEFAULT_BASE, NOW, Some(generated)).is_ok());
		assert!(verify_index(&body, &sig, &keys, DEFAULT_BASE, NOW, Some(generated + 1)).unwrap_err().contains("older"));
		// Past its expiry.
		let week = 7 * 24 * 3600 * 1000;
		assert!(verify_index(&body, &sig, &keys, DEFAULT_BASE, generated + week, None).unwrap_err().contains("expired"));
		// An expiry further out than a week.
		let long = index_body("2026-10-27T16:41:44.877Z", "2027-10-27T16:41:44.877Z");
		assert!(verify_index(&long, &signer.sign(&long, "test-1"), &keys, DEFAULT_BASE, NOW, None).unwrap_err().contains("one week"));
	}

	#[test]
	fn times_parse() {
		assert_eq!(parse_time("1970-01-01T00:00:00Z"), Some(0));
		assert_eq!(parse_time("2026-10-27T16:41:44.877Z"), Some(1_793_119_304_877));
		assert_eq!(parse_time("2000-03-01T00:00:00.5Z"), Some(951_868_800_500));
		assert_eq!(parse_time("2026-10-27 16:41:44Z"), None);
		assert_eq!(parse_time("2026-10-27T16:41:44+02:00"), None);
	}

	#[test]
	fn zips_are_checked() {
		let dir = temp("zip");
		let main = toc("ember", "1.0.0");
		let unpack_one = |files: &[(&str, &[u8])], entry: Option<&Entry>| {
			let zip = zip_of(files);
			let staging = fresh_dir(&dir, STAGING).unwrap();
			let e = entry.cloned().unwrap_or_else(|| entry_of(&zip));
			unpack(&zip, &staging, &e).and_then(|folders| check(&staging, &e, &folders))
		};
		fn entry_of(zip: &[u8]) -> Entry {
			entry("ember", zip)
		}
		// The good one.
		unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes()), ("PolestarPack_ember/Guides.lua", b"x"), ("PolestarPack_ember/LICENSE-DATA.txt", b"cc"), ("PolestarPack_ember/Art/map.blp", b"b")], None).unwrap();
		// A folder the index doesn't list.
		let err = unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes()), ("Questie/Questie.toc", b"x")], None).unwrap_err();
		assert!(err.contains("isn't this guide's (Questie)"), "{err}");
		// A file of the wrong kind.
		let err = unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes()), ("PolestarPack_ember/run.exe", b"MZ")], None).unwrap_err();
		assert!(err.contains("may not hold"), "{err}");
		assert!(unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes()), ("PolestarPack_ember/notes.txt", b"x")], None).is_err());
		// Zip slip.
		let err = unpack_one(&[("PolestarPack_ember/../../evil.lua", b"x")], None).unwrap_err();
		assert!(err.contains("unsafe path"), "{err}");
		assert!(unpack_one(&[("/etc/evil.lua", b"x")], None).is_err());
		// Names Windows would open as a device or an alternate data stream.
		for bad in ["PolestarPack_ember/COM1.lua", "PolestarPack_ember/nul.lua", "PolestarPack_ember/a.lua:x.lua", "PolestarPack_ember/x.lua."] {
			let err = unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes()), (bad, b"x")], None).unwrap_err();
			assert!(err.contains("unsafe path"), "{bad}: {err}");
		}
		// A file beside the folders.
		assert!(unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes()), ("README.txt", b"x")], None).unwrap_err().contains("outside its folders"));
		// No X-Polestar-Pack, or another pack's.
		let err = unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", b"## Interface: 16001\n## Version: 1.0.0\n")], None).unwrap_err();
		assert!(err.contains("X-Polestar-Pack: ember"), "{err}");
		assert!(unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", toc("other", "1").as_bytes())], None).is_err());
		// A locale folder must say whose texts it holds.
		let zip = zip_of(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes()), ("PolestarPack_ember_deDE/PolestarPack_ember_deDE.toc", b"## X-Polestar-Pack: ember\n")]);
		let mut with_locale = entry("ember", &zip);
		with_locale.addon.push("PolestarPack_ember_deDE".to_owned());
		let staging = fresh_dir(&dir, STAGING).unwrap();
		let folders = unpack(&zip, &staging, &with_locale).unwrap();
		assert!(check(&staging, &with_locale, &folders).unwrap_err().contains("X-Polestar-Texts"));
		// The size cap, on what the zip unpacks to.
		let big = vec![b'-'; (MAX_UNPACKED + 1) as usize];
		let err = unpack_one(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes()), ("PolestarPack_ember/Big.lua", &big)], None).unwrap_err();
		assert!(err.contains("100 MB"), "{err}");
		// And on the download: the index never lists more than 20 MB, and the bytes must match it.
		let zip = zip_of(&[("PolestarPack_ember/PolestarPack_ember.toc", main.as_bytes())]);
		let e = entry("ember", &zip);
		assert!(verify_zip(&e, &zip).is_ok());
		let mut longer = zip.clone();
		longer.push(0);
		assert!(verify_zip(&e, &longer).is_err());
		let mut flipped = zip.clone();
		flipped[10] ^= 1;
		assert!(verify_zip(&e, &flipped).unwrap_err().contains("checksum"));
		let mut huge = e.clone();
		huge.download.size = MAX_ZIP + 1;
		assert!(check_entry(huge, DEFAULT_BASE).is_err());
		let _ = fs::remove_dir_all(&dir);
	}

	#[test]
	fn installs_update_and_remove_only_its_own_folders() {
		let addons = temp("own");
		for (dir, body) in [("Polestar", "## Author: Polestar\n## Version: 0.2.6\n".to_owned()), ("Questie", "## Author: Aero\n".to_owned()), ("PolestarPack_taken", toc("someone", "1.0.0")), ("PolestarPack_ember_frFR", "## X-Polestar-Texts: ember\n".to_owned())] {
			fs::create_dir_all(addons.join(dir)).unwrap();
			fs::write(addons.join(dir).join(format!("{dir}.toc")), body).unwrap();
		}
		// 1.0.0 with a French folder, then 1.1.0 without it.
		let v1 = zip_of(&[("PolestarPack_ember/PolestarPack_ember.toc", toc("ember", "1.0.0").as_bytes()), ("PolestarPack_ember_frFR/PolestarPack_ember_frFR.toc", b"## X-Polestar-Texts: ember\n")]);
		let mut e1 = entry("ember", &v1);
		e1.addon.push("PolestarPack_ember_frFR".to_owned());
		install_zip(&v1, &e1, &addons).unwrap();
		let have = installed(&addons);
		assert_eq!(have.len(), 1);
		assert_eq!(have[0].version.as_deref(), Some("1.0.0"));
		assert_eq!(have[0].folders, ["PolestarPack_ember", "PolestarPack_ember_frFR"]);
		assert_eq!(have[0].title.as_deref(), Some("Pack ember"));
		let v2 = zip_of(&[("PolestarPack_ember/PolestarPack_ember.toc", toc("ember", "1.1.0").as_bytes())]);
		install_zip(&v2, &entry("ember", &v2), &addons).unwrap();
		assert_eq!(installed(&addons)[0].version.as_deref(), Some("1.1.0"));
		assert!(!addons.join("PolestarPack_ember_frFR").exists());
		// A folder that carries another pack's id is never overwritten.
		let taken = zip_of(&[("PolestarPack_taken/PolestarPack_taken.toc", toc("taken", "1.0.0").as_bytes())]);
		let err = install_zip(&taken, &entry("taken", &taken), &addons).unwrap_err();
		assert!(err.contains("belongs to the guide someone"), "{err}");
		assert_eq!(fs::read_to_string(addons.join("PolestarPack_taken/PolestarPack_taken.toc")).unwrap(), toc("someone", "1.0.0"));
		// Nor one with no id at all.
		fs::create_dir_all(addons.join("PolestarPack_plain")).unwrap();
		let plain = zip_of(&[("PolestarPack_plain/PolestarPack_plain.toc", toc("plain", "1").as_bytes())]);
		assert!(install_zip(&plain, &entry("plain", &plain), &addons).unwrap_err().contains("something else"));
		// Removing takes only the pack's folders.
		assert_eq!(uninstall("ember", &addons).unwrap(), ["PolestarPack_ember"]);
		let mut left: Vec<String> = fs::read_dir(&addons).unwrap().map(|e| e.unwrap().file_name().into_string().unwrap()).collect();
		left.sort();
		assert_eq!(left, ["Polestar", "PolestarPack_plain", "PolestarPack_taken", "Questie"]);
		assert!(uninstall("someone", &addons).unwrap().is_empty(), "someone's pack is in a folder not named for it");
		let _ = fs::remove_dir_all(&addons);
	}

	#[test]
	fn compatibility_and_names() {
		let e = entry("ember", b"z");
		assert_eq!(interface_of("1.60.1.62345"), Some(16001));
		assert_eq!(interface_of("1.15.8.62345"), Some(11508));
		assert_eq!(interface_of("x"), None);
		assert_eq!(blocked(&e, Some(16001), Some("0.2.6")), None);
		assert!(blocked(&e, Some(11508), Some("0.2.6")).unwrap().contains("Made for game version 1.60.1; your game is 1.15.8"));
		assert!(blocked(&e, Some(16001), Some("0.2.4")).unwrap().contains("you have 0.2.4"));
		assert!(blocked(&e, Some(16001), None).unwrap().contains("Install Polestar"));
		assert!(blocked(&e, None, Some("0.2.6")).is_some());
		assert!(valid_id("emberway") && valid_id("a1") && valid_id("durotar-dash"));
		assert!(!valid_id("a") && !valid_id("-ab") && !valid_id("Ember") && !valid_id("a_b") && !valid_id(&"a".repeat(33)));
		assert_eq!(parse_folder("PolestarPack_ember_deDE"), Some(("ember", Some("deDE"))));
		assert_eq!(parse_folder("PolestarPack_ember_de"), None);
		assert_eq!(parse_folder("Polestar_Guides"), None);
		assert_eq!(snapshot_id("\"6-1793119304877\""), Some("6"));
		assert_eq!(snapshot_id("W/\"12-1\""), Some("12"));
		assert_eq!(snapshot_id("\"abc\""), None);
	}

	#[test]
	fn links_parse() {
		assert_eq!(parse_link("polestar://install?pack=emberway").unwrap(), "emberway");
		assert_eq!(parse_link("polestar://install/?pack=emberway&version=1.2.0&utm=x").unwrap(), "emberway");
		assert_eq!(parse_link("polestar:install?pack=emberway").unwrap(), "emberway");
		assert!(parse_link("polestar://install?pack=Ember_Way").unwrap_err().contains("isn't a guide name"));
		assert!(parse_link("polestar://install").unwrap_err().contains("which guide"));
		assert!(parse_link("polestar://uninstall?pack=emberway").is_err());
		assert!(parse_link("https://polestar.guide/packs/emberway").is_err());
	}
}
