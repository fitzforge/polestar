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
			"   Dungeons and Rares show; Polestar_Options the settings window",
			"   (loaded when you open it); Polestar_SkinAPI the checks for skins",
			"   from other addons (loaded when you use one); Polestar_Looks the",
			"   WoW Forever, Blizzard, Classic and Hearth skins (loaded when you",
			"   pick one); Polestar_Nav",
			"   the arrow's walking routes",
			"   (Shortest Path Forever's pathing, by Cillian Berragan, GPL-3.0 or",
			"   later: see its LICENSE and CREDITS.md); the language folders",
			"   (Polestar_deDE, Polestar_frFR, ...) the guide texts and the game's",
			"   quest, NPC, object and item names in each language (the game loads",
			"   only its own). To update, delete the old Polestar folders there",
			"   first, the Polestar_Guides_deDE and Polestar_Names_deDE kind too",
			"   (one of each per language): Polestar no longer uses them.",
			"   The Polestar_Skin_ folders are skins: each shows up under Settings >",
			"   Theme and loads only when you pick it.",
		]
		.iter()
		.map(|s| s.to_string()),
	);
	if names.iter().any(|n| n == crate::addons::ARCADE) {
		lines.extend(
			[
				"   Polestar_Arcade is Freedoom Arcade by petllama: three levels of",
				"   Freedoom to play on a flight, loaded when you press Play (its own",
				"   licence, GPL-2.0 or later: see its LICENSE and CREDITS.md).",
			]
			.iter()
			.map(|s| s.to_string()),
		);
	}
	if names.iter().any(|n| forge_guide::project::own_extra(n).is_some()) {
		lines.extend(
			[
				"   Polestar_Experimental holds experimental guides for Forever's new",
				"   zones (alpha). They are on for everyone: the guide menu lists them",
				"   under Leveling with our own guides, and a route choice offers their",
				"   zones where they fit. Options > Guide > Show experimental guides",
				"   takes them out of the guide menu.",
			]
			.iter()
			.map(|s| s.to_string()),
		);
	}
	lines.extend(
		[
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
			"Polestar_Arcade/ is a program of its own: Freedoom Arcade, Copyright",
			"(C) 2026 petllama, from id Software's DOOM source, GPL-2.0 or later;",
			"Freedoom's levels and art (C) the Freedoom project, BSD licence",
			"(FREEDOOM-COPYING.txt).",
			"",
		]
		.iter()
		.map(|s| s.to_string()),
	);
	lines.join("\r\n")
}

/// The entries of the addon folders `names` under `addons`, each folder's `extras` (file name, data)
/// placed right after the folder's own entry, in place of a file of that name in the folder. What
/// `addons::NOT_SHIPPED` names stays out.
pub fn archive_entries(addons: &Path, names: &[String], extras: &[(&str, Vec<Entry>)]) -> Result<Vec<Entry>, String> {
	let shipped = |e: &Entry| !crate::addons::NOT_SHIPPED.iter().any(|x| if x.ends_with('/') { e.name.starts_with(x) } else { e.name == *x });
	let mut out = Vec::new();
	for n in names {
		let mut tree = directory_entries(&[&addons.join(n)])?.into_iter();
		out.extend(tree.next());
		let added: Vec<Entry> = extras.iter().filter(|(f, _)| f == n).flat_map(|(_, list)| list.iter().map(|e| Entry { name: format!("{n}/{}", e.name), data: e.data.clone() })).collect();
		let taken: Vec<String> = added.iter().map(|e| e.name.clone()).collect();
		out.extend(added);
		out.extend(tree.filter(|e| !taken.contains(&e.name) && shipped(e)));
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
		let names: Vec<String> = ["Polestar", "Polestar_Guides", "Polestar_Nav", "Polestar_Options", "Polestar_SkinAPI", "Polestar_Looks", "Polestar_Codex"].iter().map(|s| s.to_string()).collect();
		let text = readme("0.2.0", &names);
		assert!(text.starts_with("Polestar 0.2.0\r\n"));
		assert!(text.contains("_forever_/Interface/AddOns/"));
		assert!(text.contains("/reload does not"));
		for n in &names {
			assert!(text.contains(&format!("\r\n     {n}\r\n")), "{n}");
		}
		assert!(!text.contains("     Polestar_Recorder\r\n"));
		assert!(text.contains("Polestar_Nav\r\n   the arrow's walking routes\r\n   (Shortest Path Forever's pathing, by Cillian Berragan"));
		assert!(text.contains("Polestar_Options the settings window\r\n   (loaded when you open it)"));
		assert!(text.contains("Polestar_SkinAPI the checks for skins\r\n   from other addons (loaded when you use one)"));
		assert!(text.contains("Polestar_Looks the\r\n   WoW Forever, Blizzard, Classic and Hearth skins (loaded when you\r\n   pick one)"));
		assert!(text.contains("\r\nPortions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever),\r\n"));
		assert!(!text.replace("\r\n", "").contains('\n'), "CRLF line endings throughout");
	}

	// What the players read about the experimental guides: on for everyone, listed under Leveling, offered by a
	// route choice where they fit, and the setting that hides them; only when the folder ships.
	#[test]
	fn the_readme_says_the_experimental_guides_are_on_and_where_to_hide_them_only_when_they_ship() {
		let with: Vec<String> = ["Polestar", "Polestar_Guides", "Polestar_Experimental", "Polestar_Codex"].iter().map(|s| s.to_string()).collect();
		let text = readme("0.3.8", &with);
		assert!(text.contains("\r\n     Polestar_Experimental\r\n"));
		assert!(text.contains(
			"\r\n   Polestar_Experimental holds experimental guides for Forever's new\r\n   zones (alpha). They are on for everyone: the guide menu lists them\r\n   under Leveling with our own guides, and a route choice offers their\r\n   zones where they fit. Options > Guide > Show experimental guides\r\n   takes them out of the guide menu.\r\n2. Quit"
		));
		let without = readme("0.3.8", &with[..2]);
		assert!(!without.contains("Polestar_Experimental"));
		assert!(without.contains("Theme and loads only when you pick it.\r\n2. Quit"));
	}

	// Freedoom Arcade's folder: what it is and its own licence, only when it ships.
	#[test]
	fn the_readme_names_freedoom_arcade_and_its_licence_only_when_it_ships() {
		let with: Vec<String> = ["Polestar", "Polestar_Guides", "Polestar_Looks", "Polestar_Arcade", "Polestar_Codex"].iter().map(|s| s.to_string()).collect();
		let text = readme("0.4.0", &with);
		assert!(text.contains("\r\n     Polestar_Arcade\r\n"));
		assert!(text.contains("\r\n   Polestar_Arcade is Freedoom Arcade by petllama: three levels of\r\n"));
		assert!(text.contains("\r\nPolestar_Arcade/ is a program of its own: Freedoom Arcade, Copyright\r\n(C) 2026 petllama, from id Software's DOOM source, GPL-2.0 or later;\r\n"));
		let without = readme("0.4.0", &[with[0].clone(), with[1].clone()]);
		assert!(!without.contains("Polestar_Arcade is Freedoom Arcade"));
	}

	#[test]
	fn a_packs_files_and_its_sibling_addons_become_top_folders() {
		let files: Vec<(String, Vec<u8>)> = ["Pack.lua", "Guides.lua", "../P_deDE/P_deDE.toc", "P.toc", "img/a.tga"].iter().map(|n| (n.to_string(), n.as_bytes().to_vec())).collect();
		let names: Vec<String> = pack_entries("P", &files).into_iter().map(|e| e.name).collect();
		assert_eq!(names, ["P/", "P/Guides.lua", "P/P.toc", "P/Pack.lua", "P/img/a.tga", "P_deDE/", "P_deDE/P_deDE.toc"]);
	}

	// Freedoom Arcade's scripts, CurseForge images and nested standalone TOC stay out of the zip; its game files,
	// licences, credits and README ship.
	#[test]
	fn the_arcade_ships_without_its_scripts_page_images_or_nested_toc() {
		let root = std::env::temp_dir().join(format!("forge-release-pack-arcade-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&root);
		let a = root.join("Polestar_Arcade");
		for f in [
			"Polestar_Arcade.toc",
			"LICENSE",
			"CREDITS.md",
			"FREEDOOM-COPYING.txt",
			"README.md",
			"src/core.lua",
			"src/FreedoomArcade.toc",
			"tools/deploy.sh",
			"tools/publish_curseforge.py",
			"curseforge/logo.png",
			"maps/E1M1.lua",
		] {
			std::fs::create_dir_all(a.join(f).parent().unwrap()).unwrap();
			std::fs::write(a.join(f), f).unwrap();
		}
		let names: Vec<String> = archive_entries(&root, &["Polestar_Arcade".to_string()], &[]).unwrap().into_iter().map(|e| e.name).collect();
		std::fs::remove_dir_all(&root).unwrap();
		assert_eq!(
			names,
			[
				"Polestar_Arcade/",
				"Polestar_Arcade/CREDITS.md",
				"Polestar_Arcade/FREEDOOM-COPYING.txt",
				"Polestar_Arcade/LICENSE",
				"Polestar_Arcade/Polestar_Arcade.toc",
				"Polestar_Arcade/README.md",
				"Polestar_Arcade/maps/",
				"Polestar_Arcade/maps/E1M1.lua",
				"Polestar_Arcade/src/",
				"Polestar_Arcade/src/core.lua",
			]
		);
	}

	#[test]
	fn sha256_of_nothing() {
		assert_eq!(sha256_hex(b""), "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
	}
}
