//! The client info file (docs/RECORDING.md "Client info"): `Interface/AddOns/Polestar/ClientInfo.lua`,
//! written by Polestar Client from the release list it checks for addon updates, so the addon's update
//! card (addon/Polestar/Core/Update.lua) knows the newest release:
//! `PolestarClientInfo = { latest, released, checked, releases = { newest first } }`.
//! Only releases count (no pre-releases, whatever the client's channel), and only versions that are
//! digits and dots, so nothing but a version string reaches the Lua file. The game reads addon files
//! only when it loads them (login, /reload) and never writes them, so the file can be written at any
//! time; it is written atomically (a temporary file, then a rename), and only when it changes.

use std::io::{self, Write};
use std::path::Path;

use crate::addons::Release;

pub const FILE_NAME: &str = "ClientInfo.lua";
/// The releases listed, newest first: enough to count how far behind any recent build is.
const MAX_RELEASES: usize = 20;

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Info {
	/// The newest release's version.
	pub latest: String,
	/// When it was published (Unix seconds), when GitHub says.
	pub released: Option<i64>,
	/// When the client checked (Unix seconds).
	pub checked: i64,
	/// Release versions, newest first, at most MAX_RELEASES.
	pub releases: Vec<String>,
}

/// A version as the file may carry it: x.y.z (more parts allowed), digits and dots only.
fn plain_version(v: &str) -> bool {
	let parts: Vec<&str> = v.split('.').collect();
	v.len() <= 32 && parts.len() >= 3 && parts.iter().all(|p| !p.is_empty() && p.bytes().all(|b| b.is_ascii_digit()))
}

/// "2026-11-10T12:00:00Z" (GitHub's `published_at`) -> Unix seconds.
fn unix_seconds(stamp: &str) -> Option<i64> {
	let b = stamp.as_bytes();
	if b.len() < 20 || b[4] != b'-' || b[7] != b'-' || b[10] != b'T' || b[13] != b':' || b[16] != b':' || !stamp.ends_with('Z') {
		return None;
	}
	let num = |from: usize, to: usize| stamp.get(from..to)?.parse::<i64>().ok();
	let (y, m, d) = (num(0, 4)?, num(5, 7)?, num(8, 10)?);
	let (hh, mm, ss) = (num(11, 13)?, num(14, 16)?, num(17, 19)?);
	if !(1..=12).contains(&m) || !(1..=31).contains(&d) || hh > 23 || mm > 59 || ss > 60 {
		return None;
	}
	// Days from the civil date (Howard Hinnant's algorithm).
	let y = if m <= 2 { y - 1 } else { y };
	let era = y.div_euclid(400);
	let yoe = y - era * 400;
	let mp = (m + 9) % 12;
	let doy = (153 * mp + 2) / 5 + d - 1;
	let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
	let days = era * 146_097 + doe - 719_468;
	Some(days * 86_400 + hh * 3600 + mm * 60 + ss)
}

/// What the file says, from Polestar's releases (newest first, as the catalog keeps them) and the
/// check's time (Unix seconds); None without a release.
pub fn info<'a>(releases: impl IntoIterator<Item = &'a Release>, checked: i64) -> Option<Info> {
	let stable: Vec<&Release> = releases.into_iter().filter(|r| !r.prerelease && plain_version(&r.version)).collect();
	let newest = stable.first()?;
	Some(Info {
		latest: newest.version.clone(),
		released: newest.published_at.as_deref().and_then(unix_seconds),
		checked,
		releases: stable.iter().take(MAX_RELEASES).map(|r| r.version.clone()).collect(),
	})
}

/// The file's text.
pub fn render(info: &Info) -> String {
	let mut text = String::from("-- Written by Polestar Client (docs/RECORDING.md, \"Client info\"); rewritten after each check.\n");
	text.push_str("PolestarClientInfo = {\n");
	text.push_str(&format!("\tlatest = \"{}\",\n", info.latest));
	if let Some(released) = info.released {
		text.push_str(&format!("\treleased = {released},\n"));
	}
	text.push_str(&format!("\tchecked = {},\n", info.checked));
	let list: Vec<String> = info.releases.iter().map(|v| format!("\"{v}\"")).collect();
	text.push_str(&format!("\treleases = {{ {} }},\n", list.join(", ")));
	text.push_str("}\n");
	text
}

/// Writes the file into `addon_dir` (the Polestar addon folder) when its text changes. Ok(true) when
/// written; Ok(false) when it already said that or there is no such folder.
pub fn write(addon_dir: &Path, info: &Info) -> io::Result<bool> {
	if !addon_dir.is_dir() {
		return Ok(false);
	}
	let text = render(info);
	let file = addon_dir.join(FILE_NAME);
	if std::fs::read_to_string(&file).is_ok_and(|old| old == text) {
		return Ok(false);
	}
	let tmp = addon_dir.join(format!("{FILE_NAME}.tmp"));
	{
		let mut f = std::fs::File::create(&tmp)?;
		f.write_all(text.as_bytes())?;
		f.sync_all()?;
	}
	std::fs::rename(&tmp, &file).inspect_err(|_| {
		let _ = std::fs::remove_file(&tmp);
	})?;
	Ok(true)
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::addons::Asset;

	fn release(version: &str, prerelease: bool, published: Option<&str>) -> Release {
		Release {
			version: version.to_owned(),
			tag: format!("v{version}"),
			title: format!("Polestar {version}"),
			page_url: format!("https://github.com/fitzforge/polestar/releases/tag/v{version}"),
			published_at: published.map(str::to_owned),
			prerelease,
			body: String::new(),
			asset: Asset { name: format!("Polestar-{version}.zip"), url: String::new(), size: 0, digest: None },
			sums: None,
		}
	}

	#[test]
	fn published_at_reads_as_unix_seconds() {
		assert_eq!(unix_seconds("1970-01-01T00:00:00Z"), Some(0));
		assert_eq!(unix_seconds("2026-11-10T12:00:00Z"), Some(1_794_312_000));
		assert_eq!(unix_seconds("2024-02-29T23:59:59Z"), Some(1_709_251_199));
		assert_eq!(unix_seconds("2026-13-10T12:00:00Z"), None);
		assert_eq!(unix_seconds("yesterday"), None);
	}

	#[test]
	fn the_info_lists_releases_only_newest_first_and_never_a_strange_version() {
		let list = vec![
			release("0.3.8-rc1", true, Some("2026-11-12T10:00:00Z")),
			release("0.3.7", false, Some("2026-11-10T12:00:00Z")),
			release("0.3.6\"; os.exit() --", false, None),
			release("0.3.6", false, Some("2026-11-03T12:00:00Z")),
			release("0.3.5", false, None),
		];
		let info = info(&list, 1_794_400_000).unwrap();
		assert_eq!(
			info,
			Info { latest: "0.3.7".into(), released: Some(1_794_312_000), checked: 1_794_400_000, releases: vec!["0.3.7".into(), "0.3.6".into(), "0.3.5".into()] }
		);
		assert_eq!(
			render(&info),
			"-- Written by Polestar Client (docs/RECORDING.md, \"Client info\"); rewritten after each check.\nPolestarClientInfo = {\n\tlatest = \"0.3.7\",\n\treleased = 1794312000,\n\tchecked = 1794400000,\n\treleases = { \"0.3.7\", \"0.3.6\", \"0.3.5\" },\n}\n"
		);
		assert_eq!(super::info(&[release("0.4.0-rc1", true, None)], 1), None, "no release yet: no file");
		let many: Vec<Release> = (0..30).rev().map(|n| release(&format!("0.3.{n}"), false, None)).collect();
		let info = super::info(&many, 1).unwrap();
		assert_eq!((info.releases.len(), info.releases[0].as_str(), info.released), (MAX_RELEASES, "0.3.29", None));
	}

	#[test]
	fn the_file_is_written_into_the_polestar_folder_only_when_it_changes() {
		let root = std::env::temp_dir().join(format!("polestar-clientinfo-{}", std::process::id()));
		let dir = root.join("Polestar");
		let info = Info { latest: "0.3.7".into(), released: None, checked: 100, releases: vec!["0.3.7".into(), "0.3.6".into()] };
		assert!(!write(&dir, &info).unwrap(), "no Polestar folder: nothing written");
		std::fs::create_dir_all(&dir).unwrap();
		// The release's empty file is replaced.
		std::fs::write(dir.join(FILE_NAME), "PolestarClientInfo = nil\n").unwrap();
		assert!(write(&dir, &info).unwrap());
		assert_eq!(std::fs::read_to_string(dir.join(FILE_NAME)).unwrap(), render(&info));
		assert!(!dir.join("ClientInfo.lua.tmp").exists());
		assert!(!write(&dir, &info).unwrap(), "the same text is not written again");
		assert!(write(&dir, &Info { checked: 200, ..info }).unwrap(), "a new check is");
		std::fs::remove_dir_all(&root).unwrap();
	}
}
