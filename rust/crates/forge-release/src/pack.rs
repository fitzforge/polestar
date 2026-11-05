//! The release archives' contents: our release's Polestar-<version>.zip and Polestar_Recorder-<version>.zip
//! (addon folders at the top level, the GPL and the players' README.txt in Polestar/), and another
//! pack's <folder>-<version>.zip.

use crate::zip::{directory_entries, Entry};
use sha2::{Digest, Sha256};
use std::path::Path;

/// The players' install steps, Polestar/README.txt in the zip; CRLF so Notepad shows it as written.
pub fn readme(version: &str, names: &[String]) -> String {
	let mut lines: Vec<String> = vec![
		format!("Polestar {version}"),
		"Leveling guides for World of Warcraft: Forever.".into(),
		String::new(),
		"Install".into(),
		"1. Copy these folders from the zip into".into(),
		"   World of Warcraft/_forever_/Interface/AddOns/".into(),
		"   (_classic_beta_ instead of _forever_ on the beta client):".into(),
	];
	lines.extend(names.iter().map(|n| format!("     {n}")));
	lines.extend(
		[
			"   They are all part of Polestar: Polestar_Codex holds what Lookup,",
			"   Dungeons and Rares show; Polestar_Nav the arrow's walking routes",
			"   (Shortest Path Forever's pathing, by Cillian Berragan, GPL-3.0 or",
			"   later: see its LICENSE and CREDITS.md); the language folders",
			"   (Polestar_deDE, Polestar_frFR, ...) the guide texts and the game's",
			"   quest, NPC, object and item names in each language (the game loads",
			"   only its own). To update, delete the old Polestar folders there",
			"   first, the Polestar_Guides_deDE and Polestar_Names_deDE kind too",
			"   (one of each per language): Polestar no longer uses them.",
			"2. Quit the game completely and start it again. A /reload does not",
			"   load new addon folders.",
			"",
			"Polestar_Recorder (a separate zip) is optional: it records your sessions",
			"to improve the routes and stays off until you turn it on.",
			"",
			"Source, issues and documentation: https://github.com/fitzforge/polestar",
			"Polestar is free software under the GNU General Public License, version 3",
			"only (LICENSE). The data folders carry their own notices (LICENSE-DATA.txt).",
			"Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever),",
			"GPL-3.0 or later, adapted with his permission: the route lines, journey",
			"panel, transit times, travel prompts and alerts in Polestar/ (LICENSE",
			"names the files) and the walking routes in Polestar_Nav/.",
			"",
		]
		.iter()
		.map(|s| s.to_string()),
	);
	lines.join("\r\n")
}

/// The entries of the addon folders `names` under `addons`, each folder's `extras` (file name, data)
/// placed right after the folder's own entry, in place of a file of that name in the folder.
pub fn archive_entries(addons: &Path, names: &[String], extras: &[(&str, Vec<Entry>)]) -> Result<Vec<Entry>, String> {
	let mut out = Vec::new();
	for n in names {
		let mut tree = directory_entries(&[&addons.join(n)])?.into_iter();
		out.extend(tree.next());
		let added: Vec<Entry> = extras.iter().filter(|(f, _)| f == n).flat_map(|(_, list)| list.iter().map(|e| Entry { name: format!("{n}/{}", e.name), data: e.data.clone() })).collect();
		let taken: Vec<String> = added.iter().map(|e| e.name.clone()).collect();
		out.extend(added);
		out.extend(tree.filter(|e| !taken.contains(&e.name)));
	}
	Ok(out)
}

/// POSIX `path.normalize` of a relative name: `.` dropped, `x/..` folded.
fn normalize(name: &str) -> String {
	let mut parts: Vec<&str> = Vec::new();
	for p in name.split('/') {
		match p {
			"" | "." => {}
			".." if parts.last().is_some_and(|l| *l != "..") => {
				parts.pop();
			}
			p => parts.push(p),
		}
	}
	let mut out = parts.join("/");
	if name.ends_with('/') {
		out.push('/');
	}
	out
}

/// A built pack's files (names relative to its folder `folder`; `../<folder>_<x>/...` are its texts
/// addons and race parts) as archive entries: each top folder, sorted, then its files sorted by name.
pub fn pack_entries(folder: &str, files: &[(String, Vec<u8>)]) -> Vec<Entry> {
	let at = |name: &str| normalize(&format!("{folder}/{name}"));
	let mut dirs: Vec<String> = files.iter().map(|(n, _)| at(n).split('/').next().unwrap_or_default().to_string()).collect();
	dirs.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
	dirs.dedup();
	let mut sorted: Vec<&(String, Vec<u8>)> = files.iter().collect();
	sorted.sort_by(|a, b| forge_guide::js::cmp_utf16(&a.0, &b.0));
	let mut out = Vec::new();
	for d in dirs {
		out.push(Entry::dir(format!("{d}/")));
		out.extend(sorted.iter().filter(|(n, _)| at(n).starts_with(&format!("{d}/"))).map(|(n, data)| Entry::file(at(n), data.clone())));
	}
	out
}

/// The SHA-256 of `data` in hex: a SHA256SUMS line is `<hex>  <file>\n`, what `sha256sum -c` reads.
pub fn sha256_hex(data: &[u8]) -> String {
	Sha256::digest(data).iter().map(|b| format!("{b:02x}")).collect()
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn the_readme_names_every_folder_shipped_in_crlf_lines() {
		let names: Vec<String> = ["Polestar", "Polestar_Guides", "Polestar_Nav", "Polestar_Codex"].iter().map(|s| s.to_string()).collect();
		let text = readme("0.2.0", &names);
		assert!(text.starts_with("Polestar 0.2.0\r\n"));
		assert!(text.contains("_forever_/Interface/AddOns/"));
		assert!(text.contains("/reload does not"));
		for n in &names {
			assert!(text.contains(&format!("\r\n     {n}\r\n")), "{n}");
		}
		assert!(!text.contains("     Polestar_Recorder\r\n"));
		assert!(text.contains("Polestar_Nav the arrow's walking routes\r\n   (Shortest Path Forever's pathing, by Cillian Berragan"));
		assert!(text.contains("\r\nPortions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever),\r\n"));
		assert!(!text.replace("\r\n", "").contains('\n'), "CRLF line endings throughout");
	}

	#[test]
	fn a_packs_files_and_its_sibling_addons_become_top_folders() {
		let files: Vec<(String, Vec<u8>)> = ["Pack.lua", "Guides.lua", "../P_deDE/P_deDE.toc", "P.toc", "img/a.tga"].iter().map(|n| (n.to_string(), n.as_bytes().to_vec())).collect();
		let names: Vec<String> = pack_entries("P", &files).into_iter().map(|e| e.name).collect();
		assert_eq!(names, ["P/", "P/Guides.lua", "P/P.toc", "P/Pack.lua", "P/img/a.tga", "P_deDE/", "P_deDE/P_deDE.toc"]);
	}

	#[test]
	fn sha256_of_nothing() {
		assert_eq!(sha256_hex(b""), "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
	}
}
