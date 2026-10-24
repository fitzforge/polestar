//! `forge data fetch`: the public data pack from a release (or any URL or local path): reads the
//! index (polestar-data-pack.json), downloads the archive beside it, checks its size and BLAKE3,
//! unpacks it into a fresh directory, checks every file against the manifest (size and BLAKE3, no
//! file more or less), then puts it in place of the previous pack.

use crate::pack::{ARCHIVE, INDEX, MANIFEST};
use serde_json::Value;
use std::io::{Read, Write};
use std::path::{Path, PathBuf};

/// The release asset `forge data fetch` reads by default ($POLESTAR_DATA_PACK_URL overrides): the
/// fixed `data-pack` release, so Forge's own releases never move it.
pub const DEFAULT_URL: &str = "https://github.com/fitzforge/polestar/releases/download/data-pack/polestar-data-pack.json";

pub fn default_url() -> String {
	std::env::var("POLESTAR_DATA_PACK_URL").unwrap_or_else(|_| DEFAULT_URL.to_string())
}

/// Where the pack lives: $POLESTAR_DATA_PACK, else the user's data folder
/// (`$XDG_DATA_HOME` or `~/.local/share` on Linux, `~/Library/Application Support` on macOS,
/// `%LOCALAPPDATA%` on Windows) + `polestar/data-pack`.
pub fn default_pack_dir() -> Option<PathBuf> {
	if let Some(p) = std::env::var_os("POLESTAR_DATA_PACK") {
		return Some(PathBuf::from(p));
	}
	let base = if cfg!(windows) {
		std::env::var_os("LOCALAPPDATA").map(PathBuf::from)
	} else if cfg!(target_os = "macos") {
		std::env::var_os("HOME").map(|h| PathBuf::from(h).join("Library/Application Support"))
	} else {
		std::env::var_os("XDG_DATA_HOME").map(PathBuf::from).or_else(|| std::env::var_os("HOME").map(|h| PathBuf::from(h).join(".local/share")))
	};
	base.map(|b| b.join("polestar").join("data-pack"))
}

fn open(url: &str) -> Result<Box<dyn Read>, String> {
	if url.starts_with("http://") || url.starts_with("https://") {
		let resp = ureq::get(url).call().map_err(|e| match e {
			ureq::Error::StatusCode(404) if url == DEFAULT_URL => {
				"no public data pack has been published yet. Build from your own game client instead: forge build --wow <game folder> --guides <dir> --out <dir>".to_string()
			}
			ureq::Error::StatusCode(404) => format!("{url}: not found (404)"),
			e => format!("{url}: {e}"),
		})?;
		return Ok(Box::new(resp.into_body().into_reader()));
	}
	let path = url.strip_prefix("file://").unwrap_or(url);
	Ok(Box::new(std::fs::File::open(path).map_err(|e| format!("{path}: {e}"))?))
}

/// The archive's location: the index's `archiveUrl`, else its `archive` name beside the index.
fn sibling(url: &str, name: &str) -> String {
	match url.rfind('/') {
		Some(k) => format!("{}/{name}", &url[..k]),
		None => name.to_string(),
	}
}

pub struct Fetched {
	pub dir: PathBuf,
	pub files: usize,
	pub bytes: u64,
	pub archive_bytes: u64,
}

/// Download, verify and unpack the pack at `url` into `dest`.
pub fn fetch(url: &str, dest: &Path, log: &mut dyn FnMut(&str)) -> Result<Fetched, String> {
	let mut text = String::new();
	open(url)?.read_to_string(&mut text).map_err(|e| format!("{url}: {e}"))?;
	let index: Value = serde_json::from_str(&text).map_err(|e| format!("{url}: not a pack index: {e}"))?;
	let want_hash = index["blake3"].as_str().ok_or_else(|| format!("{url}: no blake3"))?.to_string();
	let want_size = index["size"].as_u64().ok_or_else(|| format!("{url}: no size"))?;
	let aurl = index["archiveUrl"].as_str().map(String::from).unwrap_or_else(|| sibling(url, index["archive"].as_str().unwrap_or(ARCHIVE)));
	let parent = dest.parent().ok_or("the pack folder has no parent")?;
	std::fs::create_dir_all(parent).map_err(|e| format!("{}: {e}", parent.display()))?;
	let stem = dest.file_name().ok_or("the pack folder needs a name (--dest)")?.to_string_lossy().into_owned();
	let incoming = parent.join(format!(".{stem}.incoming"));
	let _ = std::fs::remove_dir_all(&incoming);
	std::fs::create_dir_all(&incoming).map_err(|e| e.to_string())?;
	let tmp = parent.join(format!(".{stem}.download"));
	get_archive(&aurl, want_size, &want_hash, &tmp, &incoming, log)?;
	for a in index["assets"].as_array().into_iter().flatten() {
		let name = a["archive"].as_str().ok_or("an asset without a name")?;
		let url = a["url"].as_str().map(String::from).unwrap_or_else(|| sibling(url, name));
		get_archive(&url, a["size"].as_u64().unwrap_or(0), a["blake3"].as_str().unwrap_or(""), &tmp, &incoming, log)?;
	}
	let (files, bytes) = verify(&incoming)?;
	let manifest: Value = serde_json::from_slice(&std::fs::read(incoming.join(MANIFEST)).map_err(|e| e.to_string())?).map_err(|e| e.to_string())?;
	if manifest != index["manifest"] {
		return Err(format!("{}: the archive's manifest is not the index's", INDEX));
	}
	let _ = std::fs::remove_dir_all(dest);
	std::fs::rename(&incoming, dest).map_err(|e| format!("{}: {e}", dest.display()))?;
	for x in manifest["external"].as_array().into_iter().flatten() {
		log(&format!("{} ({}): {}", x["title"].as_str().unwrap_or(""), x["credit"].as_str().unwrap_or(""), x["note"].as_str().unwrap_or("")));
	}
	for x in manifest["requires"].as_array().into_iter().flatten() {
		log(&format!("needs, not in the pack: {}: {}", x["title"].as_str().unwrap_or(""), x["note"].as_str().unwrap_or("")));
	}
	Ok(Fetched { dir: dest.to_path_buf(), files, bytes, archive_bytes: want_size })
}

/// Download `url` to `tmp`, check its size and BLAKE3, unpack it into `into`.
fn get_archive(url: &str, want_size: u64, want_hash: &str, tmp: &Path, into: &Path, log: &mut dyn FnMut(&str)) -> Result<(), String> {
	log(&format!("downloading {url} ({:.1} MB)", want_size as f64 / 1e6));
	{
		let mut r = open(url)?;
		let mut f = std::io::BufWriter::new(std::fs::File::create(tmp).map_err(|e| format!("{}: {e}", tmp.display()))?);
		let mut h = blake3::Hasher::new();
		let mut buf = vec![0u8; 1 << 20];
		let mut n = 0u64;
		loop {
			let k = r.read(&mut buf).map_err(|e| format!("{url}: {e}"))?;
			if k == 0 {
				break;
			}
			h.update(&buf[..k]);
			f.write_all(&buf[..k]).map_err(|e| e.to_string())?;
			n += k as u64;
		}
		f.flush().map_err(|e| e.to_string())?;
		let got = h.finalize().to_hex().to_string();
		if n != want_size || got != want_hash {
			let _ = std::fs::remove_file(tmp);
			return Err(format!("{url}: {n} bytes, BLAKE3 {got}; the index says {want_size} bytes, {want_hash}: not the published pack"));
		}
	}
	log("verified (BLAKE3); unpacking");
	let f = std::fs::File::open(tmp).map_err(|e| e.to_string())?;
	let mut ar = tar::Archive::new(flate2::read::GzDecoder::new(std::io::BufReader::new(f)));
	for entry in ar.entries().map_err(|e| e.to_string())? {
		let mut entry = entry.map_err(|e| e.to_string())?;
		if !entry.unpack_in(into).map_err(|e| e.to_string())? {
			return Err(format!("{}: a path outside the pack", entry.path().map(|p| p.display().to_string()).unwrap_or_default()));
		}
	}
	let _ = std::fs::remove_file(tmp);
	Ok(())
}

/// Every manifest file present with its size and BLAKE3, and no other file. (files, bytes)
pub fn verify(dir: &Path) -> Result<(usize, u64), String> {
	let manifest: Value = serde_json::from_slice(&std::fs::read(dir.join(MANIFEST)).map_err(|e| format!("{}: {e}", dir.join(MANIFEST).display()))?).map_err(|e| e.to_string())?;
	let mut want = std::collections::BTreeSet::new();
	let mut bytes = 0u64;
	for f in manifest["files"].as_array().into_iter().flatten() {
		let rel = f["path"].as_str().ok_or("manifest: a file without a path")?;
		let p = dir.join(rel);
		let h = crate::pack::blake3_file(&p)?;
		let size = std::fs::metadata(&p).map_err(|e| e.to_string())?.len();
		if Some(h.as_str()) != f["blake3"].as_str() || Some(size) != f["size"].as_u64() {
			return Err(format!("{rel}: {size} bytes, BLAKE3 {h}; the manifest says {} bytes, {}", f["size"], f["blake3"]));
		}
		bytes += size;
		want.insert(rel.to_string());
	}
	want.insert(MANIFEST.to_string());
	let mut stack = vec![dir.to_path_buf()];
	while let Some(d) = stack.pop() {
		for e in std::fs::read_dir(&d).map_err(|e| e.to_string())?.flatten() {
			let p = e.path();
			if p.is_dir() {
				stack.push(p);
			} else {
				let rel = p.strip_prefix(dir).unwrap().to_string_lossy().replace('\\', "/");
				if !want.contains(&rel) {
					return Err(format!("{rel}: in the pack but not in its manifest"));
				}
			}
		}
	}
	Ok((want.len() - 1, bytes))
}
