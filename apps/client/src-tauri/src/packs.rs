//! Community guide packs from polestar.guide: the signed pack index, what is
//! installed, and installing, updating, turning off and removing packs safely.
//!
//! The index (`/api/v1/packs/index.json`) is trusted only with its detached
//! ed25519 signature (`index.json.sig`) from a key pinned below, over the exact
//! bytes received; an index older than the last one accepted (a rollback) or
//! past its `expires` is refused. A pack's download must come from the site's
//! own origin and match the index's SHA-256 and size, hold only the folders the
//! index lists (`PolestarPack_<id>` and `PolestarPack_<id>_<locale>`) with the
//! files the guide compiler makes in them (each folder's TOC with the generated
//! directives and file lines only, the `.lua` files it lists, `.tga`/`.blp`
//! pictures, licence texts), and carry its id in each TOC. A pack only ever
//! writes, moves or removes its own folders: ones that do not exist yet or
//! already carry the same id. Polestar's own folders and every other addon are
//! never touched. The swap itself is the Addons page's (addons.rs): staged,
//! backed up, put back on failure.
//!
//! Each installed pack is pinned to the `uid`, publisher and folders it was
//! installed with ([`Pin`]): an update that changes any of them asks first, and
//! only an unchanged one, a day after it was published, may install by itself
//! ([`auto_update_ok`]). The index's `revoked` list turns packs off
//! ([`disable`]) or removes them.

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
/// What a pack folder may hold besides LICENSE* and README* texts: its TOC, the Lua files that
/// TOC lists, and pictures (guide-forge's images.rs: `.tga` and `.blp`). Nothing else the
/// compiler makes, so no `.xml`.
const FILE_KINDS: [&str; 4] = ["toc", "lua", "tga", "blp"];
/// The `## Key:` lines the compiler writes into a pack's TOCs (emit.rs `emit_toc`,
/// `emit_texts_toc`), and the localized `Title-`/`Notes-`. Anything else (`SavedVariables`,
/// `LoadWith`, `LoadManagers`, `AllowLoad`, ...) refuses the pack.
const TOC_KEYS: [&str; 16] = [
	"Interface",
	"Title",
	"Notes",
	"Author",
	"Version",
	"Category",
	"Group",
	"Dependencies",
	"LoadOnDemand",
	"X-Polestar-Pack",
	"X-Polestar-Format",
	"X-Polestar-Needs",
	"X-Polestar-Texts",
	"X-Polestar-Locale",
	"X-License",
	"X-Website",
];
/// The files a main folder's TOC loads (emit.rs `PACK_SCRIPTS`), and a locale folder's.
const MAIN_FILES: [&str; 3] = ["Pack.lua", "MapFrames.lua", "Guides.lua"];
const TEXTS_FILES: [&str; 1] = ["Texts.lua"];
/// An update installs by itself only once it has been out this long: time for the site to pull it.
pub const AUTO_HOLD_MS: i64 = 24 * 3600 * 1000;

/// A public key the index may be signed with.
pub struct PinnedKey {
	pub id: &'static str,
	pub key: [u8; 32],
}

/// The production signing keys: the live signer and the next one (held offline for rotation).
/// The signature's `keyId` picks which.
pub const RELEASE_KEYS: &[PinnedKey] = &[
	PinnedKey {
		id: "polestar-1",
		key: [
			0xaf, 0x69, 0xa8, 0xb7, 0x68, 0xef, 0xea, 0x39, 0xd9, 0xa9, 0x66, 0x03, 0xb6, 0xfd, 0x98, 0x73, 0x13, 0x77, 0xc1, 0x23, 0xf6, 0x75, 0x4a, 0x1e, 0xcd, 0x7d, 0xc9, 0xfd, 0xb3, 0x69, 0xab, 0xe8,
		],
	},
	PinnedKey {
		id: "polestar-2",
		key: [
			0xf3, 0xf4, 0xc0, 0xf9, 0xd9, 0x3a, 0xbd, 0x25, 0xed, 0xeb, 0xa1, 0x6e, 0x83, 0xfc, 0x05, 0xe3, 0xa7, 0x0c, 0x99, 0x56, 0x29, 0xfa, 0x7f, 0xa2, 0x8e, 0xf0, 0xb2, 0xb8, 0x40, 0x9f, 0xbb, 0x88,
		],
	},
];

/// The development site's key (polestar-site's `.env.local`), trusted only by debug builds.
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

/// The keys an index may be signed with in this build.
pub fn keys() -> Vec<&'static PinnedKey> {
	trusted_keys(cfg!(debug_assertions))
}

/// The release keys, and the dev key only for a debug build (`dev`): a release build never
/// trusts it, whichever site it is pointed at.
pub fn trusted_keys(dev: bool) -> Vec<&'static PinnedKey> {
	RELEASE_KEYS.iter().chain(DEV_KEYS.iter().filter(|_| dev)).collect()
}

/// One spelling per site: `https://Polestar.Guide:443/` -> `https://polestar.guide`. Scheme and
/// host in lower case, the default port dropped, no trailing slash, query or fragment. What the
/// settings keep and the saved index is keyed by.
pub fn normalize_base(url: &str) -> Option<String> {
	let u = tauri::Url::parse(url.trim()).ok()?;
	let host = u.host_str()?;
	let port = u.port().map(|p| format!(":{p}")).unwrap_or_default();
	Some(format!("{}://{}{port}{}", u.scheme(), host.to_ascii_lowercase(), u.path().trim_end_matches('/')))
}

/// A redirect of a pack or index request may stay on the origin it started from only (so never
/// to another host, nor from https to http).
pub fn redirect_ok(from: &reqwest::Url, to: &reqwest::Url) -> bool {
	from.origin() == to.origin()
}

/// The redirect policy of the client that talks to the community site.
pub fn redirect_policy() -> reqwest::redirect::Policy {
	reqwest::redirect::Policy::custom(|attempt| {
		let ok = attempt.previous().first().is_some_and(|first| redirect_ok(first, attempt.url()));
		if attempt.previous().len() > 5 {
			attempt.error("too many redirects")
		} else if ok {
			attempt.follow()
		} else {
			attempt.error("the community site redirected to another address; Polestar Client only downloads guides from the site itself")
		}
	})
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
	/// The pack's own id: opaque, never changes, never reused. Another `uid` under the same `id`
	/// is another pack.
	#[serde(default)]
	pub uid: Option<String>,
	#[serde(default)]
	pub publisher: Option<Publisher>,
	/// When this version became available (server time, ISO-8601 UTC).
	#[serde(default)]
	pub published: Option<String>,
	/// A moderator approved this version.
	#[serde(default)]
	pub reviewed: bool,
}

impl Entry {
	/// `published` in epoch milliseconds.
	pub fn published_at(&self) -> Option<i64> {
		self.published.as_deref().and_then(parse_time)
	}

	fn publisher_id(&self) -> Option<&str> {
		self.publisher.as_ref().map(|p| p.id.as_str())
	}
}

/// Who publishes a pack on the site: a stable user id and the handle shown.
#[derive(Deserialize, Serialize, Clone, Debug, PartialEq)]
pub struct Publisher {
	pub id: String,
	#[serde(default)]
	pub handle: Option<String>,
}

/// What a revocation does to an installed pack.
#[derive(Deserialize, Serialize, Clone, Copy, Debug, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub enum RevokeAction {
	/// Its folders leave AddOns for the client's data folder (restorable once no longer revoked).
	Disable,
	/// Its folders are deleted.
	Remove,
}

/// A `revoked` entry: versions of one pack (`id` and `uid`) the site pulled, `None` = every one.
#[derive(Clone, Debug, PartialEq)]
pub struct Revoked {
	pub id: String,
	pub uid: String,
	pub versions: Option<Vec<String>>,
	pub reason: String,
	pub action: RevokeAction,
}

impl Revoked {
	fn covers(&self, version: Option<&str>) -> bool {
		match &self.versions {
			None => true,
			Some(list) => version.is_some_and(|v| list.iter().any(|l| l == v)),
		}
	}
}

#[derive(Clone, Debug)]
pub struct Index {
	/// `generated`, epoch milliseconds: an index older than the last accepted one is refused.
	pub generated: i64,
	pub expires: i64,
	pub packs: Vec<Entry>,
	pub revoked: Vec<Revoked>,
}

impl Index {
	pub fn get(&self, id: &str) -> Option<&Entry> {
		self.packs.iter().find(|p| p.id == id)
	}

	/// The revocation that covers pack `id` at `version`, and what to do about it. `uid` is the
	/// one the install was pinned to; an install with none yet (made before pins, and its pack no
	/// longer listed) is matched by id and version alone, and then only ever turned off, never
	/// deleted. When several entries cover it, `remove` wins over `disable`.
	pub fn revocation(&self, id: &str, uid: Option<&str>, version: Option<&str>) -> Option<(&Revoked, RevokeAction)> {
		let hits = self.revoked.iter().filter(|r| r.id == id && r.covers(version)).filter_map(|r| match uid {
			Some(uid) => (r.uid == uid).then_some((r, r.action)),
			None => Some((r, RevokeAction::Disable)),
		});
		hits.reduce(|best, hit| if best.1 != RevokeAction::Remove && hit.1 == RevokeAction::Remove { hit } else { best })
	}
}

#[derive(Deserialize)]
struct RawIndex {
	schema: u32,
	generated: String,
	expires: String,
	packs: Vec<serde_json::Value>,
	#[serde(default)]
	revoked: Vec<serde_json::Value>,
}

/// What an installed pack was installed as: the client keeps this per pack id and compares every
/// update against it.
#[derive(Deserialize, Serialize, Clone, Debug, Default, PartialEq)]
#[serde(rename_all = "camelCase", default)]
pub struct Pin {
	pub uid: Option<String>,
	/// The publisher's stable id, and the handle it had (to say who it was).
	pub publisher: Option<String>,
	pub publisher_handle: Option<String>,
	/// The folders it installed (`addon`).
	pub folders: Vec<String>,
}

impl Pin {
	/// The pin of an install of `entry` that put `folders` into AddOns.
	pub fn of(entry: &Entry, folders: &[String]) -> Pin {
		Pin { uid: entry.uid.clone(), publisher: entry.publisher_id().map(str::to_owned), publisher_handle: entry.publisher.as_ref().and_then(|p| p.handle.clone()), folders: sorted(folders) }
	}

	/// The pin of a pack installed before pins existed (or by hand): the index's uid and publisher
	/// adopted the first time it lists the pack, the folders as they are in AddOns. A pin without
	/// a uid or publisher yet takes the index's once it has them; nothing a pin holds is ever
	/// replaced by this.
	pub fn adopt(pin: Option<&Pin>, entry: Option<&Entry>, installed: &Installed) -> Pin {
		let mut pin = pin.cloned().unwrap_or_else(|| Pin { folders: sorted(&installed.folders), ..Pin::default() });
		if let Some(e) = entry {
			if pin.uid.is_none() {
				pin.uid = e.uid.clone();
			}
			if pin.publisher.is_none() {
				pin.publisher = e.publisher_id().map(str::to_owned);
				pin.publisher_handle = e.publisher.as_ref().and_then(|p| p.handle.clone());
			}
		}
		pin
	}
}

fn sorted(folders: &[String]) -> Vec<String> {
	let mut out = folders.to_vec();
	out.sort();
	out.dedup();
	out
}

/// How an index entry differs from what was installed: the player confirms any of it first.
#[derive(Serialize, Clone, Debug, Default, PartialEq)]
#[serde(rename_all = "camelCase")]
pub struct Changes {
	/// Another pack (`uid`) under the same id: not an update of the one installed.
	pub replaced: bool,
	pub publisher: Option<PublisherChange>,
	/// Folders the new version adds, and ones it no longer has.
	pub added: Vec<String>,
	pub removed: Vec<String>,
}

#[derive(Serialize, Clone, Debug, PartialEq)]
pub struct PublisherChange {
	pub from: Option<String>,
	pub to: Option<String>,
}

impl Changes {
	pub fn any(&self) -> bool {
		self.replaced || self.publisher.is_some() || !self.added.is_empty() || !self.removed.is_empty()
	}

	/// The confirm's text, for an update asked for without one.
	pub fn describe(&self, title: &str) -> String {
		let mut what = Vec::new();
		if self.replaced {
			return format!("{title} was replaced by a different guide under the same name. Confirm to install the new one in its place.");
		}
		if let Some(p) = &self.publisher {
			what.push(format!("a new publisher ({} instead of {})", p.to.as_deref().unwrap_or("unknown"), p.from.as_deref().unwrap_or("unknown")));
		}
		if !self.added.is_empty() {
			what.push(format!("new folders ({})", self.added.join(", ")));
		}
		if !self.removed.is_empty() {
			what.push(format!("fewer folders (no {})", self.removed.join(", ")));
		}
		format!("This update of {title} has {}. Confirm to install it.", what.join(" and "))
	}
}

/// What `entry` changes against the pinned install.
pub fn changes(pin: &Pin, entry: &Entry) -> Changes {
	let publisher = pin.publisher.as_deref().filter(|&p| entry.publisher_id() != Some(p)).map(|_| PublisherChange { from: pin.publisher_handle.clone(), to: entry.publisher.as_ref().and_then(|p| p.handle.clone()) });
	Changes {
		replaced: pin.uid.is_some() && entry.uid != pin.uid,
		publisher,
		added: entry.addon.iter().filter(|f| !pin.folders.contains(f)).cloned().collect(),
		removed: pin.folders.iter().filter(|f| !entry.addon.contains(f)).cloned().collect(),
	}
}

/// May `entry` install by itself over the pinned install, at `now`? Only the same pack (uid), from
/// the same publisher, with the same folders, published at least [`AUTO_HOLD_MS`] ago. An entry
/// without a uid, publisher or publish date never may. The error says why not.
pub fn auto_update_ok(pin: Option<&Pin>, entry: &Entry, now: i64) -> Result<(), &'static str> {
	let pin = pin.ok_or("not pinned yet")?;
	if pin.uid.is_none() || entry.uid.is_none() || pin.publisher.is_none() || entry.publisher.is_none() {
		return Err("the index doesn't say which pack or publisher this is");
	}
	if changes(pin, entry).any() {
		return Err("the pack, its publisher or its folders changed");
	}
	let published = entry.published_at().ok_or("no publish date")?;
	if now < published.saturating_add(AUTO_HOLD_MS) {
		return Err("published less than a day ago");
	}
	Ok(())
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
	let mut revoked: Vec<Revoked> = Vec::with_capacity(raw.revoked.len());
	for value in raw.revoked {
		match check_revoked(&value) {
			Ok(r) => revoked.push(r),
			Err(e) => eprintln!("community index: a revoked entry left out: {e}"),
		}
	}
	Ok(Index { generated, expires, packs, revoked })
}

/// An opaque id (`uid`, a publisher's id): 1 to 64 visible ASCII characters.
fn token_ok(s: &str) -> bool {
	(1..=64).contains(&s.len()) && s.bytes().all(|c| c.is_ascii_graphic())
}

fn text_ok(s: &str, max: usize) -> bool {
	!s.trim().is_empty() && s.chars().count() <= max && !s.chars().any(char::is_control)
}

/// A `revoked` entry: `{id, uid, versions: [..] | "*", reason, action: "disable" | "remove"}`.
/// An action this client doesn't know turns the pack off (the safe one).
fn check_revoked(v: &serde_json::Value) -> Result<Revoked, String> {
	let text = |key: &str| v.get(key).and_then(|s| s.as_str()).ok_or_else(|| format!("no {key}"));
	let (id, uid) = (text("id")?, text("uid")?);
	if !valid_id(id) || !token_ok(uid) {
		return Err(format!("bad id or uid ({id:?}, {uid:?})"));
	}
	let versions = match v.get("versions") {
		Some(serde_json::Value::String(s)) if s == "*" => None,
		Some(serde_json::Value::Array(list)) => Some(list.iter().map(|v| v.as_str().map(str::to_owned).ok_or(format!("{id}: a version that is not text"))).collect::<Result<Vec<_>, _>>()?),
		_ => return Err(format!("{id}: versions is neither a list nor \"*\"")),
	};
	let reason: String = v.get("reason").and_then(|s| s.as_str()).unwrap_or("").chars().filter(|c| !c.is_control()).take(300).collect();
	let reason = if reason.trim().is_empty() { "The site gave no reason.".to_owned() } else { reason.trim().to_owned() };
	let action = if v.get("action").and_then(|s| s.as_str()) == Some("remove") { RevokeAction::Remove } else { RevokeAction::Disable };
	Ok(Revoked { id: id.to_owned(), uid: uid.to_owned(), versions, reason, action })
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
	if !text_ok(&e.title, 80) || !text_ok(&e.author, 64) || !text_ok(&e.version, 32) {
		return Err(format!("{}: title, author or version missing or too long", e.id));
	}
	// Downloaded only from the site itself: the signed index can't send players' addresses elsewhere.
	let url = tauri::Url::parse(&e.download.url).map_err(|_| format!("{}: download is not an address", e.id))?;
	let site = tauri::Url::parse(base).map_err(|_| format!("{}: the community site is not an address", e.id))?;
	if url.origin() != site.origin() || !(url.scheme() == "https" || (url.scheme() == "http" && is_local(base))) {
		return Err(format!("{}: download is not on {}", e.id, host(base)));
	}
	if e.uid.as_deref().is_some_and(|u| !token_ok(u)) {
		e.uid = None;
	}
	if e.publisher.as_ref().is_some_and(|p| !token_ok(&p.id)) {
		e.publisher = None;
	}
	if let Some(p) = e.publisher.as_mut().filter(|p| p.handle.as_deref().is_some_and(|h| !text_ok(h, 64))) {
		p.handle = None;
	}
	if e.published.as_deref().is_some_and(|p| parse_time(p).is_none()) {
		e.published = None;
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

/// A response's body, refused once it passes `max` bytes (also for the recording server's answers).
pub(crate) async fn read_capped(mut response: reqwest::Response, max: usize) -> Result<Vec<u8>, String> {
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
		let name = file.name().map_err(|e| bad(format!("has a file name that is not text ({e})")))?.into_owned();
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
		// The game reads `<folder>.toc` (and flavour TOCs beside it, which a pack never has) and
		// the Lua files it lists, all at the folder's top.
		let ext = file_name.rsplit_once('.').map(|(_, e)| e.to_ascii_lowercase()).unwrap_or_default();
		let top_level = inner.components().count() == 1;
		if (ext == "toc" && (!top_level || file_name != format!("{top}.toc"))) || (ext == "lua" && !top_level) {
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

/// Every listed folder came, each with its TOC naming this pack, holding only the directives and
/// file lines the compiler writes, and each Lua file in it listed there.
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
		let text = fs::read(&toc).map_err(|e| format!("Could not read {folder}.toc: {e}"))?;
		let listed = match check_toc(&String::from_utf8_lossy(&text), locale) {
			Ok(listed) => listed,
			Err(e) => return bad(format!("{e} in {folder}.toc")),
		};
		let entries = fs::read_dir(staging.join(folder)).map_err(|e| e.to_string())?;
		for name in entries.filter_map(|e| e.ok()).filter_map(|e| e.file_name().into_string().ok()) {
			if name.to_ascii_lowercase().ends_with(".lua") && !listed.iter().any(|l| l.eq_ignore_ascii_case(&name)) {
				return bad(format!("holds {folder}/{name}, which its TOC doesn't load"));
			}
		}
	}
	Ok(())
}

/// The file lines of a pack TOC, when every line is one the compiler writes: blank, a `#`
/// comment, a known `## Key: value` ([`TOC_KEYS`], or a `Title-`/`Notes-<locale>`), or one of the
/// folder's generated files ([`MAIN_FILES`], [`TEXTS_FILES`] for a locale folder).
fn check_toc(text: &str, locale: bool) -> Result<Vec<&'static str>, String> {
	let files: &[&'static str] = if locale { &TEXTS_FILES } else { &MAIN_FILES };
	let mut listed = Vec::new();
	for line in text.trim_start_matches('\u{feff}').lines() {
		let line = line.trim();
		if let Some(directive) = line.strip_prefix("##") {
			let key = directive.split_once(':').map(|(k, _)| k.trim()).ok_or_else(|| format!("has a line it may not have ({line})"))?;
			let localized = |prefix: &str| key.strip_prefix(prefix).is_some_and(valid_locale);
			if !TOC_KEYS.iter().any(|k| k.eq_ignore_ascii_case(key)) && !localized("Title-") && !localized("Notes-") {
				return Err(format!("has a directive guides may not have (## {key})"));
			}
		} else if line.is_empty() || line.starts_with('#') {
			continue;
		} else {
			let file = files.iter().find(|f| f.eq_ignore_ascii_case(line)).ok_or_else(|| format!("loads a file guides don't have ({line})"))?;
			listed.push(*file);
		}
	}
	Ok(listed)
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

/// Turns a pack off: moves its own folders (by their TOCs, as [`installed`] finds them) out of
/// AddOns into `kept` (emptied first), where [`restore`] finds them; returns them. Nothing else in
/// AddOns is touched.
pub fn disable(id: &str, addons: &Path, kept: &Path) -> Result<Vec<String>, String> {
	let folders: Vec<String> = installed(addons).into_iter().filter(|p| p.id == id).flat_map(|p| p.folders).collect();
	if folders.is_empty() {
		return Ok(folders);
	}
	if kept.exists() {
		fs::remove_dir_all(kept).map_err(|e| format!("Could not clear {}: {e}", kept.display()))?;
	}
	fs::create_dir_all(kept).map_err(|e| format!("Could not create {}: {e}", kept.display()))?;
	let mut moved: Vec<&String> = Vec::new();
	for folder in &folders {
		if let Err(e) = move_dir(&addons.join(folder), &kept.join(folder)) {
			for back in moved {
				let _ = move_dir(&kept.join(back), &addons.join(back));
			}
			return Err(format!("Could not move {folder} out of AddOns: {e}"));
		}
		moved.push(folder);
	}
	Ok(folders)
}

/// Puts a turned-off pack's folders back from `kept`; returns them. Each must still say it is
/// pack `id`, and none may be in AddOns already.
pub fn restore(id: &str, addons: &Path, kept: &Path) -> Result<Vec<String>, String> {
	let entries = fs::read_dir(kept).map_err(|_| "Polestar Client no longer has the copy it kept of this guide.".to_owned())?;
	let mut folders: Vec<String> = entries.filter_map(|e| e.ok()).filter(|e| e.file_type().is_ok_and(|t| t.is_dir())).filter_map(|e| e.file_name().into_string().ok()).collect();
	folders.sort();
	if !folders.contains(&main_folder(id)) {
		return Err("The copy Polestar Client kept of this guide is incomplete; not restoring it.".to_owned());
	}
	for folder in &folders {
		let ours = parse_folder(folder).is_some_and(|(owner, locale)| owner == id && folder_owner(&kept.join(folder), locale.is_some()).as_deref() == Some(id));
		if !ours {
			return Err(format!("The kept copy holds {folder}, which isn't this guide's; not restoring it."));
		}
		if fs::symlink_metadata(addons.join(folder)).is_ok() {
			return Err(format!("AddOns already has a {folder}; remove it first to restore the kept copy."));
		}
	}
	fs::create_dir_all(addons).map_err(|e| format!("Could not create {}: {e}", addons.display()))?;
	let mut moved: Vec<&String> = Vec::new();
	for folder in &folders {
		if let Err(e) = move_dir(&kept.join(folder), &addons.join(folder)) {
			for back in moved {
				let _ = move_dir(&addons.join(back), &kept.join(back));
			}
			return Err(format!("Could not move {folder} back into AddOns: {e}"));
		}
		moved.push(folder);
	}
	let _ = fs::remove_dir_all(kept);
	Ok(folders)
}

/// Moves a folder: a rename, or (onto another drive) a copy and then a delete.
fn move_dir(from: &Path, to: &Path) -> io::Result<()> {
	if fs::rename(from, to).is_ok() {
		return Ok(());
	}
	if let Err(e) = copy_dir(from, to) {
		let _ = fs::remove_dir_all(to);
		return Err(e);
	}
	fs::remove_dir_all(from)
}

/// Copies a folder's files and folders (links stay behind: a pack never has one).
fn copy_dir(from: &Path, to: &Path) -> io::Result<()> {
	fs::create_dir_all(to)?;
	for entry in fs::read_dir(from)? {
		let entry = entry?;
		let kind = entry.file_type()?;
		let target = to.join(entry.file_name());
		if kind.is_dir() {
			copy_dir(&entry.path(), &target)?;
		} else if kind.is_file() {
			fs::copy(entry.path(), target)?;
		}
	}
	Ok(())
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
			uid: Some(format!("pk_{id}")),
			publisher: Some(Publisher { id: "usr_1".to_owned(), handle: Some("Tester".to_owned()) }),
			published: Some("2026-10-27T16:41:44.877Z".to_owned()),
			reviewed: false,
		}
	}

	/// A main folder's TOC as the compiler writes it.
	fn toc(id: &str, version: &str) -> String {
		format!("## Interface: 16001\n## Title: Polestar Community: Pack {id}\n## Author: Tester\n## Version: {version}\n## X-Polestar-Pack: {id}\n# Generated by the compiler.\n\nPack.lua\nMapFrames.lua\nGuides.lua\n")
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
	fn the_pinned_dev_key_verifies_the_dev_site_in_debug_builds_only() {
		assert_eq!(base64::engine::general_purpose::URL_SAFE_NO_PAD.decode("eJMjWaXaFVfEtacWDrkmquvOZ5Q51gKr8uzJBS9rUhc").unwrap(), DEV_KEYS[0].key);
		let body = include_bytes!("fixtures/dev-index.json");
		let sig = include_bytes!("fixtures/dev-index.json.sig");
		let base = "http://localhost:3100";
		let index = verify_index(body, sig, &trusted_keys(true), base, NOW, None).unwrap();
		assert_eq!(index.packs.len(), 6);
		let ember = index.get("emberway").unwrap();
		assert_eq!(ember.uid.as_deref(), Some("pk_dev_emberway"));
		assert_eq!(ember.publisher.as_ref().map(|p| p.id.as_str()), Some("usr_dev_ashka"));
		assert_eq!(ember.published_at(), Some(NOW - 1000));
		assert!(ember.reviewed);
		assert_eq!(index.revoked.len(), 2);
		assert_eq!(index.revoked[1].versions, None);
		assert_eq!(index.revoked[1].action, RevokeAction::Remove);
		// A release build's keys never include the dev key, whichever site it is pointed at.
		let release = trusted_keys(false);
		assert!(release.iter().all(|k| k.id != "polestar-dev-1") && !release.is_empty());
		assert!(verify_index(body, sig, &release, base, NOW, None).unwrap_err().contains("doesn't know"));
		assert_eq!(keys().iter().any(|k| k.id == "polestar-dev-1"), cfg!(debug_assertions));
	}

	#[test]
	fn a_real_generated_pack_installs() {
		// The dev site's emberway 1.0.0, as the compiler made it: Pack.lua, MapFrames.lua,
		// Guides.lua, its TOC and licence texts.
		let zip = include_bytes!("fixtures/PolestarPack_emberway-1.0.0.zip");
		let index = verify_index(include_bytes!("fixtures/dev-index.json"), include_bytes!("fixtures/dev-index.json.sig"), &trusted_keys(true), "http://localhost:3100", NOW, None).unwrap();
		let e = index.get("emberway").unwrap();
		verify_zip(e, zip).unwrap();
		let addons = temp("real");
		assert_eq!(install_zip(zip, e, &addons).unwrap(), ["PolestarPack_emberway"]);
		assert_eq!(installed(&addons)[0].version.as_deref(), Some("1.0.0"));
		let _ = fs::remove_dir_all(&addons);
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

	#[test]
	fn only_what_the_compiler_makes_unpacks() {
		let dir = temp("allow");
		let main = toc("ember", "1.0.0");
		let try_zip = |files: &[(&str, &[u8])]| {
			let zip = zip_of(files);
			let staging = fresh_dir(&dir, STAGING).unwrap();
			let e = entry("ember", &zip);
			unpack(&zip, &staging, &e).and_then(|folders| check(&staging, &e, &folders))
		};
		let toc_file = "PolestarPack_ember/PolestarPack_ember.toc";
		let good: [(&str, &[u8]); 5] = [(toc_file, main.as_bytes()), ("PolestarPack_ember/Pack.lua", b"x"), ("PolestarPack_ember/MapFrames.lua", b"x"), ("PolestarPack_ember/Guides.lua", b"x"), ("PolestarPack_ember/media/map.tga", b"t")];
		try_zip(&good).unwrap();
		// XML (a <Script> runs code), and pictures the game doesn't draw from packs.
		for name in ["PolestarPack_ember/Frames.xml", "PolestarPack_ember/art.png"] {
			let err = try_zip(&[good[0], good[1], (name, b"<Ui/>")]).unwrap_err();
			assert!(err.contains("may not hold"), "{name}: {err}");
		}
		// A Lua file its TOC doesn't list, or one in a subfolder.
		let err = try_zip(&[good[0], good[1], ("PolestarPack_ember/Evil.lua", b"x")]).unwrap_err();
		assert!(err.contains("which its TOC doesn't load"), "{err}");
		assert!(try_zip(&[good[0], ("PolestarPack_ember/sub/Guides.lua", b"x")]).unwrap_err().contains("may not hold"));
		// A flavour TOC the game would read instead of the checked one.
		assert!(try_zip(&[good[0], ("PolestarPack_ember/PolestarPack_ember_Vanilla.toc", main.as_bytes())]).unwrap_err().contains("may not hold"));
		// TOC directives the compiler never writes, and file lines that aren't its files.
		for (line, says) in [("## SavedVariables: PolestarEvil", "SavedVariables"), ("## SavedVariablesPerCharacter: X", "SavedVariablesPerCharacter"), ("## LoadWith: Blizzard_AuctionUI", "LoadWith"), ("## LoadManagers: Foo", "LoadManagers"), ("## AllowLoad: Glue", "AllowLoad"), ("## RequiredDeps: Foo", "RequiredDeps"), ("Evil.lua", "Evil.lua"), ("Frames.xml", "Frames.xml"), ("..\\Polestar\\Core.lua", "Core.lua")] {
			let bad = format!("{main}{line}\n");
			let err = try_zip(&[(toc_file, bad.as_bytes()), good[1]]).unwrap_err();
			assert!(err.contains(says) && err.contains("PolestarPack_ember.toc"), "{line}: {err}");
		}
		// What the compiler does write: localized titles, comments, CRLF and a BOM.
		let windows = format!("\u{feff}{}## Title-deDE: Pack\r\n## X-Website: https://x\r\n", main.replace('\n', "\r\n"));
		try_zip(&[(toc_file, windows.as_bytes()), good[1]]).unwrap();
		// A locale folder loads Texts.lua only.
		let texts = "## Interface: 16001\n## Title: Pack (deDE)\n## LoadOnDemand: 1\n## Dependencies: Polestar\n## X-Polestar-Texts: ember\n## X-Polestar-Locale: deDE\n## X-License: CC-BY-SA-4.0\n\nTexts.lua\n";
		let unpack_locale = |locale_toc: &str| {
			let zip = zip_of(&[(toc_file, main.as_bytes()), ("PolestarPack_ember_deDE/PolestarPack_ember_deDE.toc", locale_toc.as_bytes()), ("PolestarPack_ember_deDE/Texts.lua", b"x")]);
			let mut e = entry("ember", &zip);
			e.addon.push("PolestarPack_ember_deDE".to_owned());
			let staging = fresh_dir(&dir, STAGING).unwrap();
			unpack(&zip, &staging, &e).and_then(|folders| check(&staging, &e, &folders))
		};
		unpack_locale(texts).unwrap();
		assert!(unpack_locale(&texts.replace("Texts.lua", "Guides.lua")).unwrap_err().contains("loads a file guides don't have"));
		let _ = fs::remove_dir_all(&dir);
	}

	#[test]
	fn downloads_come_from_the_site_only() {
		let ok = entry("ember", b"z");
		assert!(check_entry(ok.clone(), DEFAULT_BASE).is_ok());
		assert!(check_entry(ok.clone(), "https://Polestar.guide:443").is_ok());
		for url in ["https://cdn.example.com/ember.zip", "http://polestar.guide/api/v1/packs/ember/1.0.0/download", "https://polestar.guide:8443/x.zip", "https://evil.polestar.guide/x.zip"] {
			let mut e = ok.clone();
			e.download.url = url.to_owned();
			assert!(check_entry(e, DEFAULT_BASE).unwrap_err().contains("not on polestar.guide"), "{url}");
		}
		// A local dev site serves its own downloads over http.
		let mut local = ok.clone();
		local.download.url = "http://localhost:3100/api/v1/packs/ember/1.0.0/download".to_owned();
		assert!(check_entry(local.clone(), "http://localhost:3100").is_ok());
		assert!(check_entry(local, "http://localhost:3200").is_err());
		// Redirects stay on the origin they started from: no other host, no https -> http.
		let u = |s: &str| reqwest::Url::parse(s).unwrap();
		assert!(redirect_ok(&u("https://polestar.guide/a"), &u("https://polestar.guide/b")));
		assert!(!redirect_ok(&u("https://polestar.guide/a"), &u("https://cdn.example.com/b")));
		assert!(!redirect_ok(&u("https://polestar.guide/a"), &u("http://polestar.guide/b")));
		// Bad optional fields are dropped, not fatal: then the entry can't update by itself.
		let mut odd = ok.clone();
		odd.uid = Some("has space".to_owned());
		odd.published = Some("yesterday".to_owned());
		let odd = check_entry(odd, DEFAULT_BASE).unwrap();
		assert_eq!((odd.uid, odd.published), (None, None));
	}

	#[test]
	fn site_addresses_have_one_spelling() {
		assert_eq!(normalize_base("https://polestar.guide/").as_deref(), Some("https://polestar.guide"));
		assert_eq!(normalize_base(" HTTPS://Polestar.GUIDE:443 ").as_deref(), Some("https://polestar.guide"));
		assert_eq!(normalize_base("http://localhost:3100/").as_deref(), Some("http://localhost:3100"));
		assert_eq!(normalize_base("http://localhost:80").as_deref(), Some("http://localhost"));
		assert_eq!(normalize_base("not an address"), None);
	}

	#[test]
	fn updates_install_by_themselves_only_when_routine_and_a_day_old() {
		let e = entry("ember", b"z");
		let published = e.published_at().unwrap();
		let pin = Pin::of(&e, &e.addon);
		let day = AUTO_HOLD_MS;
		assert!(auto_update_ok(Some(&pin), &e, published + day).is_ok());
		// Held for a day after it came out.
		assert!(auto_update_ok(Some(&pin), &e, published + day - 1).unwrap_err().contains("less than a day"));
		// Another publisher.
		let mut other = e.clone();
		other.publisher = Some(Publisher { id: "usr_2".to_owned(), handle: Some("Mallory".to_owned()) });
		assert!(auto_update_ok(Some(&pin), &other, published + day).is_err());
		let c = changes(&pin, &other);
		assert_eq!(c.publisher, Some(PublisherChange { from: Some("Tester".to_owned()), to: Some("Mallory".to_owned()) }));
		assert!(c.describe("Ember").contains("new publisher (Mallory instead of Tester)"));
		// A new folder, or one gone.
		let mut more = e.clone();
		more.addon.push("PolestarPack_ember_deDE".to_owned());
		assert!(auto_update_ok(Some(&pin), &more, published + day).is_err());
		assert_eq!(changes(&pin, &more).added, ["PolestarPack_ember_deDE"]);
		let wide = Pin::of(&more, &more.addon);
		assert_eq!(changes(&wide, &e).removed, ["PolestarPack_ember_deDE"]);
		assert!(auto_update_ok(Some(&wide), &e, published + day).is_err());
		// Another pack under the same id: replaced, never an update.
		let mut replaced = e.clone();
		replaced.uid = Some("pk_someone_else".to_owned());
		assert!(changes(&pin, &replaced).replaced);
		assert!(auto_update_ok(Some(&pin), &replaced, published + day).is_err());
		// Without a uid, publisher or publish date (today's dev site), or a pin, never by itself.
		for strip in [|e: &mut Entry| e.uid = None, |e: &mut Entry| e.publisher = None, |e: &mut Entry| e.published = None] {
			let mut bare = e.clone();
			strip(&mut bare);
			assert!(auto_update_ok(Some(&Pin::of(&bare, &bare.addon)), &bare, published + day).is_err());
		}
		assert!(auto_update_ok(None, &e, published + day).is_err());
		// A pack installed before pins adopts the index's uid and publisher, its folders as on disk.
		let have = Installed { id: "ember".to_owned(), version: Some("1.0.0".to_owned()), title: None, author: None, folders: vec!["PolestarPack_ember".to_owned()] };
		let adopted = Pin::adopt(None, Some(&more), &have);
		assert_eq!((adopted.uid.as_deref(), adopted.publisher.as_deref()), (Some("pk_ember"), Some("usr_1")));
		assert_eq!(adopted.folders, ["PolestarPack_ember"]);
		// And a pin never takes another uid from the index.
		assert_eq!(Pin::adopt(Some(&pin), Some(&replaced), &have).uid.as_deref(), Some("pk_ember"));
	}

	#[test]
	fn revocations_match_exactly() {
		let r = |v: serde_json::Value| check_revoked(&v);
		let one = r(serde_json::json!({ "id": "ember", "uid": "pk_ember", "versions": ["1.2.0"], "reason": "Broken\u{7} steps", "action": "remove" })).unwrap();
		assert_eq!(one.reason, "Broken steps");
		let all = r(serde_json::json!({ "id": "ember", "uid": "pk_old", "versions": "*", "reason": "", "action": "something new" })).unwrap();
		assert_eq!((all.versions.clone(), all.action), (None, RevokeAction::Disable));
		assert!(r(serde_json::json!({ "id": "ember", "uid": "pk_ember", "versions": "1.2.0", "reason": "x", "action": "remove" })).is_err());
		let index = Index { generated: 0, expires: 1, packs: Vec::new(), revoked: vec![one, all] };
		assert_eq!(index.revocation("ember", Some("pk_ember"), Some("1.2.0")).map(|(_, a)| a), Some(RevokeAction::Remove));
		assert!(index.revocation("ember", Some("pk_ember"), Some("1.2.1")).is_none());
		assert!(index.revocation("ember", Some("pk_ember"), Some("1.2")).is_none());
		assert!(index.revocation("ember", Some("pk_new"), Some("1.2.0")).is_none());
		assert!(index.revocation("ember", Some("pk_old"), Some("0.1")).is_some());
		// An install without a pinned uid is only ever turned off.
		assert_eq!(index.revocation("ember", None, Some("1.2.0")).map(|(_, a)| a), Some(RevokeAction::Disable));
		// Two entries cover the same version (one version turned off, then the whole guide taken
		// down): remove wins, whichever comes first.
		let off = r(serde_json::json!({ "id": "ash", "uid": "pk_ash", "versions": ["1.0.0"], "reason": "a", "action": "disable" })).unwrap();
		let gone = r(serde_json::json!({ "id": "ash", "uid": "pk_ash", "versions": "*", "reason": "b", "action": "remove" })).unwrap();
		let index = Index { generated: 0, expires: 1, packs: Vec::new(), revoked: vec![off, gone] };
		assert_eq!(index.revocation("ash", Some("pk_ash"), Some("1.0.0")).map(|(r, a)| (r.reason.as_str(), a)), Some(("b", RevokeAction::Remove)));
	}

	#[test]
	fn revocation_moves_or_deletes_only_the_packs_own_folders() {
		let root = temp("revoke");
		let addons = root.join("AddOns");
		let kept = root.join("data").join("disabled").join("ember");
		for (dir, body) in [("Polestar", "## Author: Polestar\n".to_owned()), ("Questie", "## Author: Aero\n".to_owned()), ("PolestarPack_ember", toc("ember", "1.2.0")), ("PolestarPack_ember_deDE", "## X-Polestar-Texts: ember\n".to_owned()), ("PolestarPack_ember_frFR", "## X-Polestar-Texts: someone\n".to_owned()), ("PolestarPack_other", toc("other", "1.0.0"))] {
			fs::create_dir_all(addons.join(dir)).unwrap();
			fs::write(addons.join(dir).join(format!("{dir}.toc")), body).unwrap();
		}
		fs::write(addons.join("PolestarPack_ember/Guides.lua"), "x").unwrap();
		let names = |dir: &Path| {
			let mut v: Vec<String> = fs::read_dir(dir).map(|r| r.map(|e| e.unwrap().file_name().into_string().unwrap()).collect()).unwrap_or_default();
			v.sort();
			v
		};
		// Disable: its own folders leave AddOns for the data folder; a folder that names another
		// pack (frFR) and every other addon stay.
		assert_eq!(disable("ember", &addons, &kept).unwrap(), ["PolestarPack_ember", "PolestarPack_ember_deDE"]);
		assert_eq!(names(&addons), ["Polestar", "PolestarPack_ember_frFR", "PolestarPack_other", "Questie"]);
		assert_eq!(names(&kept), ["PolestarPack_ember", "PolestarPack_ember_deDE"]);
		assert_eq!(fs::read_to_string(kept.join("PolestarPack_ember/Guides.lua")).unwrap(), "x");
		// Restore puts them back, and refuses when AddOns has one of them again.
		assert_eq!(restore("ember", &addons, &kept).unwrap(), ["PolestarPack_ember", "PolestarPack_ember_deDE"]);
		assert!(!kept.exists());
		disable("ember", &addons, &kept).unwrap();
		fs::create_dir_all(addons.join("PolestarPack_ember")).unwrap();
		assert!(restore("ember", &addons, &kept).unwrap_err().contains("already has"));
		fs::remove_dir_all(addons.join("PolestarPack_ember")).unwrap();
		restore("ember", &addons, &kept).unwrap();
		// Remove: its own folders are deleted, nothing else.
		assert_eq!(uninstall("ember", &addons).unwrap(), ["PolestarPack_ember", "PolestarPack_ember_deDE"]);
		assert_eq!(names(&addons), ["Polestar", "PolestarPack_ember_frFR", "PolestarPack_other", "Questie"]);
		// Nothing of its own left: nothing moves.
		assert!(disable("ember", &addons, &kept).unwrap().is_empty());
		assert_eq!(names(&addons), ["Polestar", "PolestarPack_ember_frFR", "PolestarPack_other", "Questie"]);
		let _ = fs::remove_dir_all(&root);
	}
}
