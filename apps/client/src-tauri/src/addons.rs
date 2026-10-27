//! Polestar's addons: what GitHub releases of fitzforge/polestar offer, what
//! is installed in the game's `Interface/AddOns`, and installing, repairing
//! and removing them safely.
//!
//! Every download is checked against the SHA-256 GitHub publishes for the
//! asset and against the release's SHA256SUMS when it has one; it is unpacked
//! into a staging folder, checked for the folders it must hold (each with its
//! .toc), and only then swapped in: the old folders move to a backup first
//! and come back if anything fails. A product only ever touches its own
//! folders.

use std::collections::BTreeMap;
use std::fs;
use std::io::{self, Read};
use std::path::{Component, Path, PathBuf};

use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};

pub const REPO: &str = "fitzforge/polestar";
/// The largest zip this client will take (Polestar with its walking maps is tens of MB).
const MAX_ZIP: u64 = 512 * 1024 * 1024;
pub(crate) const STAGING: &str = ".polestar-client-staging";
pub(crate) const BACKUP: &str = ".polestar-client-backup";
/// What a GitHub addon zip may unpack to, and how many entries it may hold.
const MAX_UNPACKED: u64 = 1024 * 1024 * 1024;
const MAX_ENTRIES: usize = 50_000;

/// A zip path component Windows treats as an ordinary file or folder name: no
/// `:` (alternate data streams), no control characters, no trailing `.` or space,
/// and no device name (`CON`, `NUL`, `COM1`, `LPT¹`, `CONIN$`, ...) with any extension.
pub(crate) fn safe_component(name: &str) -> bool {
	if name.is_empty() || name.ends_with(['.', ' ']) || name.chars().any(|c| c == ':' || c.is_control()) {
		return false;
	}
	let stem = name.split('.').next().unwrap_or(name).trim_end_matches(' ').to_uppercase();
	let device = match stem.as_str() {
		"CON" | "PRN" | "AUX" | "NUL" | "CONIN$" | "CONOUT$" => true,
		s => {
			let mut chars = s.chars();
			let prefix: String = chars.by_ref().take(3).collect();
			let rest: Vec<char> = chars.collect();
			(prefix == "COM" || prefix == "LPT") && rest.len() == 1 && matches!(rest[0], '0'..='9' | '¹' | '²' | '³')
		}
	};
	!device
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Folders {
	/// One folder of this name.
	One(&'static str),
	/// `Polestar` and the `Polestar_*` folders whose .toc says `## Author: Polestar`,
	/// except the Recorder (its own product): the main addon, guides, maps and languages.
	Polestar,
}

pub struct Product {
	pub id: &'static str,
	pub name: &'static str,
	pub blurb: &'static str,
	/// The folder whose .toc carries the installed version.
	pub main: &'static str,
	pub folders: Folders,
	asset_prefix: &'static str,
	tag: fn(&str) -> bool,
}

fn polestar_tag(tag: &str) -> bool {
	tag.strip_prefix('v').is_some_and(|rest| rest.starts_with(|c: char| c.is_ascii_digit()))
}

fn lib_tag(tag: &str) -> bool {
	tag.starts_with("lib-v")
}

pub const PRODUCTS: [Product; 3] = [
	Product {
		id: "polestar",
		name: "Polestar",
		blurb: "Leveling guides, the arrow, Lookup, Dungeons and Rares",
		main: "Polestar",
		folders: Folders::Polestar,
		asset_prefix: "Polestar-",
		tag: polestar_tag,
	},
	Product {
		id: "recorder",
		name: "Polestar Recorder",
		blurb: "Records your play for the recording program (off until you turn it on)",
		main: "Polestar_Recorder",
		folders: Folders::One("Polestar_Recorder"),
		asset_prefix: "Polestar_Recorder-",
		tag: polestar_tag,
	},
	Product {
		id: "libforeverdata",
		name: "LibForeverData",
		blurb: "WoW: Forever's quests, NPCs and items as a library for other addons",
		main: "LibForeverData",
		folders: Folders::One("LibForeverData"),
		asset_prefix: "LibForeverData-",
		tag: lib_tag,
	},
];

pub fn product(id: &str) -> Option<&'static Product> {
	PRODUCTS.iter().find(|p| p.id == id)
}

#[derive(Clone, Debug)]
pub struct Asset {
	pub name: String,
	pub url: String,
	pub size: u64,
	/// `sha256:<hex>` when GitHub gives one.
	pub digest: Option<String>,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Release {
	pub version: String,
	pub tag: String,
	pub title: String,
	pub page_url: String,
	pub published_at: Option<String>,
	pub prerelease: bool,
	#[serde(skip)]
	pub body: String,
	#[serde(skip)]
	pub asset: Asset,
	#[serde(skip)]
	pub sums: Option<Asset>,
}

#[derive(Deserialize)]
struct GhRelease {
	tag_name: String,
	#[serde(default)]
	name: Option<String>,
	#[serde(default)]
	body: Option<String>,
	html_url: String,
	draft: bool,
	prerelease: bool,
	#[serde(default)]
	published_at: Option<String>,
	#[serde(default)]
	assets: Vec<GhAsset>,
}

#[derive(Deserialize)]
struct GhAsset {
	name: String,
	browser_download_url: String,
	size: u64,
	#[serde(default)]
	digest: Option<String>,
}

/// Every release per product, newest first (pre-releases only on the Beta
/// channel), from the repository's last 100 releases. Tags of other kinds
/// (`forge-v*`, `data-pack`, `client-v*`) never match a product.
pub async fn releases(http: &reqwest::Client, beta: bool) -> Result<BTreeMap<&'static str, Vec<Release>>, String> {
	let response = http
		.get(format!("https://api.github.com/repos/{REPO}/releases?per_page=100"))
		.header("Accept", "application/vnd.github+json")
		.header("X-GitHub-Api-Version", "2022-11-28")
		.send()
		.await
		.map_err(|e| format!("Could not reach GitHub: {e}"))?;
	let status = response.status();
	if status == reqwest::StatusCode::FORBIDDEN || status == reqwest::StatusCode::TOO_MANY_REQUESTS {
		return Err("GitHub is limiting requests from this network for now; try again in an hour.".to_owned());
	}
	if !status.is_success() {
		return Err(format!("GitHub answered {status}."));
	}
	let releases: Vec<GhRelease> = response.json().await.map_err(|e| format!("Could not read GitHub's answer: {e}"))?;
	let mut out: BTreeMap<&'static str, Vec<Release>> = BTreeMap::new();
	for release in releases {
		if release.draft || (release.prerelease && !beta) {
			continue;
		}
		let sums = release.assets.iter().find(|a| a.name == "SHA256SUMS").map(|a| Asset { name: a.name.clone(), url: a.browser_download_url.clone(), size: a.size, digest: a.digest.clone() });
		for product in &PRODUCTS {
			if !(product.tag)(&release.tag_name) {
				continue;
			}
			let Some(asset) = release.assets.iter().find(|a| a.name.starts_with(product.asset_prefix) && a.name.ends_with(".zip")) else { continue };
			let version = asset.name[product.asset_prefix.len()..asset.name.len() - 4].trim_start_matches('v').to_owned();
			out.entry(product.id).or_default().push(
				Release {
					version,
					tag: release.tag_name.clone(),
					title: release.name.clone().filter(|n| !n.trim().is_empty()).unwrap_or_else(|| release.tag_name.clone()),
					page_url: release.html_url.clone(),
					published_at: release.published_at.clone(),
					prerelease: release.prerelease,
					body: release.body.clone().unwrap_or_default(),
					asset: Asset { name: asset.name.clone(), url: asset.browser_download_url.clone(), size: asset.size, digest: asset.digest.clone() },
					sums: sums.clone(),
				},
			);
		}
	}
	Ok(out)
}

/// `## Version:` from a folder's own .toc (or its first .toc).
pub fn toc_version(folder: &Path) -> Option<String> {
	toc_field(folder, "Version")
}

pub(crate) fn toc_field(folder: &Path, field: &str) -> Option<String> {
	let toc = toc_file(folder)?;
	let text = fs::read_to_string(toc).ok()?;
	let prefix = format!("## {field}:");
	text.lines().find_map(|l| l.trim_start_matches('\u{feff}').strip_prefix(&prefix).map(|v| v.trim().to_owned())).filter(|v| !v.is_empty())
}

pub(crate) fn toc_file(folder: &Path) -> Option<PathBuf> {
	let name = folder.file_name()?.to_str()?;
	let own = folder.join(format!("{name}.toc"));
	if own.is_file() {
		return Some(own);
	}
	let mut tocs: Vec<PathBuf> = fs::read_dir(folder).ok()?.filter_map(|e| e.ok().map(|e| e.path())).filter(|p| p.extension().is_some_and(|x| x.eq_ignore_ascii_case("toc"))).collect();
	tocs.sort();
	tocs.into_iter().next()
}

/// Is `name` one of Polestar's own addon folders (by name and its .toc's author)?
fn polestar_folder(addons: &Path, name: &str) -> bool {
	(name == "Polestar" || (name.starts_with("Polestar_") && name != "Polestar_Recorder"))
		&& toc_field(&addons.join(name), "Author").is_some_and(|a| a == "Polestar" || a.starts_with("Polestar;"))
}

/// The product's folders now in `addons`.
pub fn installed_folders(addons: &Path, product: &Product) -> Vec<String> {
	match product.folders {
		Folders::One(name) => {
			if addons.join(name).is_dir() {
				vec![name.to_owned()]
			} else {
				Vec::new()
			}
		}
		Folders::Polestar => {
			let Ok(entries) = fs::read_dir(addons) else { return Vec::new() };
			let mut names: Vec<String> = entries.filter_map(|e| e.ok()).filter(|e| e.path().is_dir()).filter_map(|e| e.file_name().into_string().ok()).filter(|n| polestar_folder(addons, n)).collect();
			names.sort();
			names
		}
	}
}

pub fn installed_version(addons: &Path, product: &Product) -> Option<String> {
	toc_version(&addons.join(product.main))
}

pub(crate) fn hex(bytes: &[u8]) -> String {
	bytes.iter().map(|b| format!("{b:02x}")).collect()
}

/// How far an install has got, for the Addons page: `download` counts bytes (`total` when GitHub
/// gave the size), then `verify` and `install`, which have no count; a removal is `remove`.
#[derive(Serialize, Clone, Copy, PartialEq, Eq, Debug)]
#[serde(rename_all = "camelCase")]
pub struct Progress {
	pub phase: &'static str,
	pub done: u64,
	pub total: Option<u64>,
}

impl Progress {
	pub const fn step(phase: &'static str) -> Progress {
		Progress { phase, done: 0, total: None }
	}
}

/// Downloads an asset, telling `progress` the bytes so far and the total when known.
async fn download(http: &reqwest::Client, asset: &Asset, progress: &(dyn Fn(u64, Option<u64>) + Sync)) -> Result<Vec<u8>, String> {
	if asset.size > MAX_ZIP {
		return Err(format!("{} is {} MB, far bigger than any Polestar addon; not installing it.", asset.name, asset.size / 1_000_000));
	}
	let failed = |e: reqwest::Error| format!("Downloading {} failed: {e}", asset.name);
	let mut response = http.get(&asset.url).send().await.map_err(failed)?;
	if !response.status().is_success() {
		return Err(format!("Downloading {} failed: GitHub answered {}.", asset.name, response.status()));
	}
	let total = response.content_length().filter(|&n| n > 0).or((asset.size > 0).then_some(asset.size));
	let mut bytes = Vec::with_capacity(total.unwrap_or(0).min(MAX_ZIP) as usize);
	while let Some(chunk) = response.chunk().await.map_err(failed)? {
		bytes.extend_from_slice(&chunk);
		if bytes.len() as u64 > MAX_ZIP {
			return Err(format!("{} is far bigger than any Polestar addon; not installing it.", asset.name));
		}
		progress(bytes.len() as u64, total);
	}
	Ok(bytes)
}

/// Checks the zip against GitHub's digest and the release's SHA256SUMS; at
/// least one of them must be there.
async fn verify(http: &reqwest::Client, release: &Release, bytes: &[u8]) -> Result<(), String> {
	let have = hex(&Sha256::digest(bytes));
	let mismatch = || format!("{} does not match the checksum published for it, so it was not installed. Try again later.", release.asset.name);
	let mut checked = false;
	if let Some(digest) = &release.asset.digest {
		let want = digest.strip_prefix("sha256:").ok_or_else(|| format!("GitHub gave a checksum this client cannot read ({digest})."))?;
		if !have.eq_ignore_ascii_case(want) {
			return Err(mismatch());
		}
		checked = true;
	}
	if let Some(sums) = &release.sums {
		let text = String::from_utf8(download(http, sums, &|_, _| {}).await?).map_err(|_| "SHA256SUMS is not text.".to_owned())?;
		let want = text.lines().find_map(|l| {
			let (sum, file) = l.split_once(char::is_whitespace)?;
			(file.trim().trim_start_matches('*') == release.asset.name).then(|| sum.trim().to_owned())
		});
		match want {
			Some(want) if want.eq_ignore_ascii_case(&have) => checked = true,
			Some(_) => return Err(mismatch()),
			None => return Err(format!("The release's SHA256SUMS does not list {}; not installing it.", release.asset.name)),
		}
	}
	if checked {
		Ok(())
	} else {
		Err(format!("GitHub publishes no checksum for {}, so it can't be checked; not installing it.", release.asset.name))
	}
}

/// Downloads, checks and installs a product's release, telling `report` how far it has got;
/// returns the folders installed.
pub async fn install(http: &reqwest::Client, product: &'static Product, release: &Release, addons: &Path, report: &(dyn Fn(Progress) + Sync)) -> Result<Vec<String>, String> {
	let bytes = download(http, &release.asset, &|done, total| report(Progress { phase: "download", done, total })).await?;
	report(Progress::step("verify"));
	verify(http, release, &bytes).await?;
	report(Progress::step("install"));
	let addons = addons.to_owned();
	tauri::async_runtime::spawn_blocking(move || {
		fs::create_dir_all(&addons).map_err(|e| format!("Could not create {}: {e}", addons.display()))?;
		let staging = fresh_dir(&addons, STAGING).map_err(|e| format!("Could not prepare the install: {e}"))?;
		let result = unpack(&bytes, &staging).and_then(|folders| {
			check(&staging, product, &folders)?;
			// Polestar's update also clears its folders the new release no longer has.
			let obsolete: Vec<String> = installed_folders(&addons, product).into_iter().filter(|f| !folders.contains(f)).collect();
			swap(&addons, &staging, &folders, &obsolete)?;
			Ok(folders)
		});
		let _ = fs::remove_dir_all(&staging);
		result
	})
	.await
	.map_err(|e| e.to_string())?
}

/// Removes a product's folders (and nothing else).
pub fn uninstall(product: &Product, addons: &Path) -> Result<Vec<String>, String> {
	let folders = installed_folders(addons, product);
	if folders.is_empty() {
		return Ok(folders);
	}
	let staging = fresh_dir(addons, STAGING).map_err(|e| format!("Could not prepare the removal: {e}"))?;
	let result = swap(addons, &staging, &[], &folders).map(|()| folders);
	let _ = fs::remove_dir_all(&staging);
	result
}

pub(crate) fn fresh_dir(addons: &Path, name: &str) -> io::Result<PathBuf> {
	let dir = addons.join(name);
	if dir.exists() {
		fs::remove_dir_all(&dir)?;
	}
	fs::create_dir_all(&dir)?;
	Ok(dir)
}

/// Unpacks the zip's top-level folders into `staging`; returns their names.
/// Paths that would leave the folder (zip slip), names Windows would not treat as
/// plain files, too many entries or more than 1 GB unpacked make the whole zip fail.
fn unpack(bytes: &[u8], staging: &Path) -> Result<Vec<String>, String> {
	let bad = |e: String| format!("The download is not a usable zip: {e}");
	let mut archive = zip::ZipArchive::new(io::Cursor::new(bytes)).map_err(|e| bad(e.to_string()))?;
	if archive.len() > MAX_ENTRIES {
		return Err(bad("it holds too many files".to_owned()));
	}
	let mut folders: Vec<String> = Vec::new();
	let mut total: u64 = 0;
	for i in 0..archive.len() {
		let mut entry = archive.by_index(i).map_err(|e| bad(e.to_string()))?;
		let Some(path) = entry.enclosed_name() else { return Err(bad(format!("unsafe path {}", entry.name()))) };
		if path.components().any(|c| !matches!(c, Component::Normal(n) if n.to_str().is_some_and(safe_component))) {
			return Err(bad(format!("unsafe path {}", entry.name())));
		}
		let mut parts = path.components();
		let Some(Component::Normal(top)) = parts.next() else { continue };
		// Files at the top level (a README beside the folders) are not addons.
		if parts.as_path().as_os_str().is_empty() && !entry.is_dir() {
			continue;
		}
		let top = top.to_str().ok_or_else(|| bad("a folder name that is not text".to_owned()))?.to_owned();
		if top.starts_with('.') {
			return Err(bad(format!("unexpected folder {top}")));
		}
		if !folders.contains(&top) {
			folders.push(top);
		}
		let target = staging.join(&path);
		if entry.is_dir() {
			fs::create_dir_all(&target).map_err(|e| e.to_string())?;
			continue;
		}
		let room = MAX_UNPACKED - total;
		if entry.size() > room {
			return Err(bad("it unpacks to more than 1 GB".to_owned()));
		}
		if let Some(parent) = target.parent() {
			fs::create_dir_all(parent).map_err(|e| e.to_string())?;
		}
		let mut data = Vec::with_capacity(entry.size().min(64 * 1024 * 1024) as usize);
		// Never more than the cap, whatever the zip's header claims.
		(&mut entry).take(room + 1).read_to_end(&mut data).map_err(|e| bad(e.to_string()))?;
		total += data.len() as u64;
		if total > MAX_UNPACKED {
			return Err(bad("it unpacks to more than 1 GB".to_owned()));
		}
		fs::write(&target, data).map_err(|e| e.to_string())?;
	}
	folders.sort();
	Ok(folders)
}

/// The zip must hold exactly the product's folders, each with a .toc.
fn check(staging: &Path, product: &Product, folders: &[String]) -> Result<(), String> {
	let fail = |what: String| Err(format!("The {} download {what}; not installing it.", product.name));
	if !folders.iter().any(|f| f == product.main) {
		return fail(format!("has no {} folder", product.main));
	}
	for folder in folders {
		let ours = match product.folders {
			Folders::One(name) => folder == name,
			Folders::Polestar => folder == "Polestar" || (folder.starts_with("Polestar_") && folder != "Polestar_Recorder"),
		};
		if !ours {
			return fail(format!("holds a folder that is not part of it ({folder})"));
		}
		if toc_file(&staging.join(folder)).is_none() {
			return fail(format!("has no .toc in {folder}"));
		}
	}
	Ok(())
}

/// Moves a backup out of the way under a unique `.polestar-client-backup-<unix time>`
/// name in AddOns (never deleted: it holds folders a failed restore left); returns it.
fn keep_backup(addons: &Path, backup: &Path) -> io::Result<PathBuf> {
	let secs = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map(|d| d.as_secs()).unwrap_or(0);
	let mut n = 0;
	loop {
		let name = if n == 0 { format!("{BACKUP}-{secs}") } else { format!("{BACKUP}-{secs}-{n}") };
		let kept = addons.join(name);
		if !kept.exists() {
			fs::rename(backup, &kept)?;
			return Ok(kept);
		}
		n += 1;
	}
}

/// The working backup folder, empty. One left with folders in it (a restore that
/// failed, or a crash mid-swap) is kept under its own name, never wiped.
fn fresh_backup(addons: &Path) -> io::Result<PathBuf> {
	let dir = addons.join(BACKUP);
	if dir.exists() && fs::read_dir(&dir)?.next().is_some() {
		keep_backup(addons, &dir)?;
	}
	fresh_dir(addons, BACKUP)
}

/// Moves `remove` and the folders being replaced into a backup, moves the
/// new folders from `staging` in, and deletes the backup. On any failure,
/// takes the new folders out again and puts the backup back; whatever can't
/// go back stays in a uniquely named backup the message names.
pub(crate) fn swap(addons: &Path, staging: &Path, install: &[String], remove: &[String]) -> Result<(), String> {
	let backup = fresh_backup(addons).map_err(|e| format!("Could not prepare a backup: {e}"))?;
	let mut backed: Vec<&String> = Vec::new();
	let mut moved: Vec<&String> = Vec::new();
	let result = (|| -> io::Result<()> {
		for name in install.iter().chain(remove) {
			if addons.join(name).exists() && !backed.contains(&name) {
				fs::rename(addons.join(name), backup.join(name))?;
				backed.push(name);
			}
		}
		for name in install {
			fs::rename(staging.join(name), addons.join(name))?;
			moved.push(name);
		}
		Ok(())
	})();
	match result {
		Ok(()) => {
			let _ = fs::remove_dir_all(&backup);
			Ok(())
		}
		Err(e) => {
			for name in moved {
				let _ = fs::remove_dir_all(addons.join(name));
			}
			let mut lost = Vec::new();
			for name in backed {
				if fs::rename(backup.join(name), addons.join(name)).is_err() {
					lost.push(name.as_str());
				}
			}
			if lost.is_empty() {
				let _ = fs::remove_dir_all(&backup);
				Err(format!("Could not replace the addon folders ({e}); everything was put back as it was. Is the game still running?"))
			} else {
				let kept = keep_backup(addons, &backup).unwrap_or(backup);
				Err(format!("Could not replace the addon folders ({e}), and {} could not be put back: copy them from {} into AddOns.", lost.join(", "), kept.display()))
			}
		}
	}
}

/// `1.2.10` > `1.2.9`; non-numeric parts compare as text; `1.0.0-beta` < `1.0.0`.
pub fn newer(candidate: &str, installed: &str) -> bool {
	let parse = |v: &str| v.trim_start_matches('v').split(['.', '-']).map(|p| p.parse::<u64>().map_err(|_| p.to_owned())).collect::<Vec<_>>();
	let (a, b) = (parse(candidate), parse(installed));
	for i in 0..a.len().max(b.len()) {
		match (a.get(i), b.get(i)) {
			(Some(Ok(x)), Some(Ok(y))) if x != y => return x > y,
			(Some(Err(x)), Some(Err(y))) if x != y => return x > y,
			(Some(Ok(_)), Some(Err(_))) => return true,
			(Some(Err(_)), Some(Ok(_))) => return false,
			(Some(Err(_)), None) => return false,
			(None, Some(Err(_))) => return true,
			(Some(_), None) => return true,
			(None, Some(_)) => return false,
			_ => {}
		}
	}
	false
}

#[cfg(test)]
mod tests {
	use super::*;
	use std::io::Write;

	fn zip_of(files: &[(&str, &str)]) -> Vec<u8> {
		let mut out = io::Cursor::new(Vec::new());
		let mut w = zip::ZipWriter::new(&mut out);
		for (name, body) in files {
			w.start_file(*name, zip::write::SimpleFileOptions::default()).unwrap();
			w.write_all(body.as_bytes()).unwrap();
		}
		w.finish().unwrap();
		out.into_inner()
	}

	fn temp(name: &str) -> PathBuf {
		let dir = std::env::temp_dir().join(format!("polestar-client-test-{name}-{}", std::process::id()));
		let _ = fs::remove_dir_all(&dir);
		fs::create_dir_all(&dir).unwrap();
		dir
	}

	#[test]
	fn polestar_update_replaces_its_folders_and_leaves_others() {
		let addons = temp("swap");
		for (dir, author) in [("Polestar", "Polestar"), ("Polestar_Guides_deDE", "Polestar"), ("Polestar_MyPack", "Someone"), ("Polestar_Recorder", "Polestar"), ("Questie", "Aero")] {
			fs::create_dir_all(addons.join(dir)).unwrap();
			fs::write(addons.join(dir).join(format!("{dir}.toc")), format!("## Version: 0.1.0\n## Author: {author}\n")).unwrap();
		}
		let staging = fresh_dir(&addons, STAGING).unwrap();
		let zip = zip_of(&[("Polestar/Polestar.toc", "## Version: 0.2.0\n## Author: Polestar\n"), ("Polestar_Nav/Polestar_Nav.toc", "## Author: Polestar\n"), ("README.txt", "hi")]);
		let folders = unpack(&zip, &staging).unwrap();
		assert_eq!(folders, ["Polestar", "Polestar_Nav"]);
		let product = product("polestar").unwrap();
		check(&staging, product, &folders).unwrap();
		let obsolete: Vec<String> = installed_folders(&addons, product).into_iter().filter(|f| !folders.contains(f)).collect();
		assert_eq!(obsolete, ["Polestar_Guides_deDE"]);
		swap(&addons, &staging, &folders, &obsolete).unwrap();
		assert_eq!(installed_version(&addons, product).as_deref(), Some("0.2.0"));
		assert!(addons.join("Polestar_Nav").is_dir());
		assert!(!addons.join("Polestar_Guides_deDE").exists());
		for keep in ["Polestar_MyPack", "Polestar_Recorder", "Questie"] {
			assert!(addons.join(keep).is_dir(), "{keep} must stay");
		}
		assert!(!addons.join(BACKUP).exists());
		let _ = fs::remove_dir_all(&addons);
	}

	#[test]
	fn zip_slip_and_foreign_folders_are_refused() {
		let dir = temp("slip");
		let staging = fresh_dir(&dir, STAGING).unwrap();
		assert!(unpack(&zip_of(&[("../evil/x.lua", "x")]), &staging).is_err());
		let staging = fresh_dir(&dir, STAGING).unwrap();
		let folders = unpack(&zip_of(&[("Polestar_Recorder/Polestar_Recorder.toc", "x"), ("Questie/Questie.toc", "x")]), &staging).unwrap();
		assert!(check(&staging, product("recorder").unwrap(), &folders).is_err());
		let _ = fs::remove_dir_all(&dir);
	}

	#[test]
	fn windows_unsafe_names_are_refused() {
		for name in ["COM1.lua", "nul.lua", "Lpt¹.txt", "CON", "conin$.lua", "a.lua:hidden.lua", "x.lua.", "x.lua ", "a\nb.lua", "AUX.tar.gz"] {
			assert!(!safe_component(name), "{name:?} must be refused");
		}
		for name in ["Polestar.lua", "COM10.lua", "CONSOLE.lua", "comet.lua", "LPT.lua", "Nullable.lua"] {
			assert!(safe_component(name), "{name:?} is fine");
		}
		let dir = temp("winnames");
		let staging = fresh_dir(&dir, STAGING).unwrap();
		assert!(unpack(&zip_of(&[("Polestar/Polestar.toc", "x"), ("Polestar/COM1.lua", "x")]), &staging).is_err());
		let _ = fs::remove_dir_all(&dir);
	}

	#[test]
	fn a_backup_left_by_a_failed_restore_is_kept() {
		let addons = temp("keep");
		fs::create_dir_all(addons.join(BACKUP).join("Polestar")).unwrap();
		fs::write(addons.join(BACKUP).join("Polestar").join("Polestar.toc"), "x").unwrap();
		let staging = fresh_dir(&addons, STAGING).unwrap();
		swap(&addons, &staging, &[], &[]).unwrap();
		let kept: Vec<_> = fs::read_dir(&addons).unwrap().filter_map(|e| e.ok()).map(|e| e.file_name().into_string().unwrap()).filter(|n| n.starts_with(&format!("{BACKUP}-"))).collect();
		assert_eq!(kept.len(), 1, "the old backup moved aside: {kept:?}");
		assert!(addons.join(&kept[0]).join("Polestar").join("Polestar.toc").is_file());
		let _ = fs::remove_dir_all(&addons);
	}

	#[test]
	fn versions_compare() {
		assert!(newer("0.3.10", "0.3.9"));
		assert!(newer("1.0.0", "1.0.0-beta"));
		assert!(!newer("0.3.0", "0.3.0"));
		assert!(polestar_tag("v0.2.6") && !polestar_tag("vendor") && !polestar_tag("forge-v1"));
	}

	/// The real thing against GitHub: every product's newest release is
	/// downloaded, checked and installed into an empty AddOns folder, then
	/// removed. `cargo test -- --ignored live_github` (needs the network).
	#[test]
	#[ignore]
	fn live_github_install_and_uninstall() {
		let _ = rustls::crypto::ring::default_provider().install_default();
		let addons = temp("live").join("AddOns");
		let http = reqwest::Client::builder().user_agent("PolestarClient-test").build().unwrap();
		tauri::async_runtime::block_on(async {
			let releases = releases(&http, false).await.unwrap();
			for product in &PRODUCTS {
				let Some(release) = releases.get(product.id).and_then(|r| r.first()) else { continue };
				let phases = std::sync::Mutex::new(Vec::new());
				let folders = install(&http, product, release, &addons, &|p| phases.lock().unwrap().push(p)).await.unwrap();
				let phases = phases.into_inner().unwrap();
				let last_download = phases.iter().rfind(|p| p.phase == "download").expect("download progress");
				assert_eq!(Some(last_download.done), last_download.total, "the download reports its whole size");
				assert_eq!(phases.iter().map(|p| p.phase).filter(|&p| p != "download").collect::<Vec<_>>(), ["verify", "install"]);
				println!("{} {} -> {:?} (toc {:?})", product.name, release.version, folders, installed_version(&addons, product));
				assert_eq!(installed_folders(&addons, product), folders);
			}
		});
		for product in &PRODUCTS {
			uninstall(product, &addons).unwrap();
			assert!(installed_folders(&addons, product).is_empty());
		}
		assert_eq!(fs::read_dir(&addons).unwrap().count(), 0, "nothing left behind");
	}
}
