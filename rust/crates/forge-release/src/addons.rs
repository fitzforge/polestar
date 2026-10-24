//! Which addon folders a release ships, and whether the Codex may ship.

use std::path::Path;

/// Always in the release: the addon, our guides and the walking router and maps (committed).
pub const RELEASE_ADDONS: [&str; 3] = ["Polestar", "Polestar_Guides", "Polestar_Nav"];
/// The Codex folder (Lookup, Dungeons and Rares read it): a release refuses to go without it.
pub const CODEX: &str = "Polestar_Codex";
/// The optional recorder, in a zip of its own.
pub const RECORDER: &str = "Polestar_Recorder";

/// The generated data addons, shipped when built: the quest and item databases, the Codex, then the
/// language folders `Polestar_<locale>` (our guides' texts and the game's names in each language).
pub fn data_addons() -> Vec<String> {
	let mut out: Vec<String> = ["Polestar_QuestDB", "Polestar_ItemDB", CODEX].iter().map(|s| s.to_string()).collect();
	out.extend(forge_guide::locales::LOCALE_CODES.iter().map(|l| forge_guide::toc::language_addon(l)));
	out
}

/// The release's addon folders present under `addons` in load order, and the data addons left out
/// because they are not built (no `<name>/<name>.toc`).
pub struct Release {
	pub names: Vec<String>,
	pub skipped: Vec<String>,
}

fn has_toc(addons: &Path, name: &str) -> bool {
	addons.join(name).join(format!("{name}.toc")).exists()
}

/// The release's folders: the three always shipped, our guides' faction parts and race parts once
/// built, then the data addons that are built (our guides' texts are in the language folders).
pub fn release_addons(addons: &Path) -> Release {
	let guides = forge_guide::project::OWN_FOLDER;
	let factions = forge_guide::project::FACTION_PARTS.iter().map(|f| forge_guide::project::part_addon(guides, f));
	let parts = forge_guide::races::RACE_FILES.iter().map(|r| forge_guide::project::part_addon(guides, r));
	let (data, skipped): (Vec<String>, Vec<String>) = data_addons().into_iter().partition(|n| has_toc(addons, n));
	let mut names: Vec<String> = RELEASE_ADDONS.iter().map(|s| s.to_string()).collect();
	names.extend(factions.chain(parts).filter(|n| has_toc(addons, n)));
	names.extend(data);
	Release { names, skipped }
}

/// The folders under `addons` the language folders replaced (Polestar_Guides_<locale> and
/// Polestar_Names_<locale>, before 0.3.0): never shipped; a release names them so they get deleted.
pub fn retired_addons(addons: &Path) -> Vec<String> {
	forge_guide::locales::LOCALE_CODES.iter().flat_map(|l| forge_guide::toc::retired_language_addons(l)).filter(|n| addons.join(n).is_dir()).collect()
}

/// The `## Version:` value of `<dir>/<name>.toc`; None without the file or the line.
pub fn toc_version(dir: &Path, name: &str) -> Option<String> {
	let text = std::fs::read_to_string(dir.join(format!("{name}.toc"))).ok()?;
	text.lines().find_map(|l| l.strip_prefix("## Version:")).and_then(|v| v.split_whitespace().next()).map(str::to_string)
}

/// The first built data addon among `names` (Polestar_QuestDB, Polestar_ItemDB, the language folders) that
/// lacks its third-party notice, LICENSE-DATA.txt, with the command that writes it; None when each has one.
/// A data addon holds facts from the sources its notice credits, so it never ships without it.
pub fn notice_refusal(addons: &Path, names: &[String]) -> Option<String> {
	for n in names.iter().filter(|n| data_addons().contains(n) && n.as_str() != CODEX) {
		if !addons.join(n).join("LICENSE-DATA.txt").exists() {
			let cmd = match n.as_str() {
				"Polestar_QuestDB" => "forge data questdb".to_string(),
				"Polestar_ItemDB" => "forge data itemdb".to_string(),
				_ => format!("forge data names {}", n.trim_start_matches(forge_guide::toc::LANGUAGE_PREFIX)),
			};
			return Some(format!("{n} has no LICENSE-DATA.txt (rebuild it with `{cmd}`)"));
		}
	}
	None
}

/// The first of our guide parts among `names` (Polestar_Guides and its faction parts) that lacks its
/// LICENSE-DATA.txt; None when each has one. Their guides carry the reference data's facts, so like a data
/// addon none ships without the notice `forge guide compile` writes beside it.
pub fn guide_notice_refusal(addons: &Path, names: &[String]) -> Option<String> {
	let guides = forge_guide::project::OWN_FOLDER;
	let parts: Vec<String> = std::iter::once(guides.to_string()).chain(forge_guide::project::FACTION_PARTS.iter().map(|f| forge_guide::project::part_addon(guides, f))).collect();
	let n = names.iter().find(|n| parts.contains(n) && !addons.join(n).join("LICENSE-DATA.txt").exists())?;
	Some(format!("{n} has no LICENSE-DATA.txt (rebuild it with `forge guide compile`)"))
}

/// Why the built Codex folder `dir` may not ship, or None when it may: it must be built, carry its
/// Meta.lua and LICENSE-DATA.txt, and come from release-safe inputs only (never a `--local-extras` build,
/// nor one naming AtlasLoot, RareScanner, DungeonJournal or dungeons.json among its sources).
pub fn codex_refusal(dir: &Path) -> Option<String> {
	const REBUILD: &str = "`forge data codex`";
	if !dir.join(format!("{CODEX}.toc")).exists() {
		return Some(format!("not built (run {REBUILD})"));
	}
	if !dir.join("Meta.lua").exists() {
		return Some(format!("Meta.lua is missing (run {REBUILD})"));
	}
	if !dir.join("LICENSE-DATA.txt").exists() {
		return Some(format!("LICENSE-DATA.txt is missing (rebuild it with {REBUILD})"));
	}
	let meta = std::fs::read_to_string(dir.join("Meta.lua")).unwrap_or_default();
	static LOCAL: std::sync::LazyLock<regex::Regex> = std::sync::LazyLock::new(|| regex::Regex::new(r"\blocalExtras = true\b").unwrap());
	static NAME: std::sync::LazyLock<regex::Regex> = std::sync::LazyLock::new(|| regex::Regex::new(r#"\bname = "([^"]*)""#).unwrap());
	static LOCAL_ONLY: std::sync::LazyLock<regex::Regex> = std::sync::LazyLock::new(|| regex::Regex::new(r"(?i)AtlasLoot|RareScanner|DungeonJournal|dungeons\.json").unwrap());
	if LOCAL.is_match(&meta) {
		return Some(format!("it is a --local-extras build (AtlasLoot, RareScanner, DungeonJournal); rebuild it with {REBUILD}"));
	}
	let named = NAME.captures_iter(&meta).map(|c| c[1].to_string()).find(|n| LOCAL_ONLY.is_match(n));
	named.map(|n| format!("its sources include a local-only input ({n}); rebuild it with {REBUILD}"))
}

#[cfg(test)]
mod tests {
	use super::*;

	fn tmp(name: &str) -> std::path::PathBuf {
		let d = std::env::temp_dir().join(format!("forge-release-addons-{name}-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&d);
		std::fs::create_dir_all(&d).unwrap();
		d
	}

	fn addon(root: &Path, name: &str) {
		std::fs::create_dir_all(root.join(name)).unwrap();
		std::fs::write(root.join(name).join(format!("{name}.toc")), "## Interface: 16001\n## Version: 0.1.0\n").unwrap();
	}

	#[test]
	fn the_release_holds_the_built_data_addons_in_load_order_and_names_the_others() {
		let root = tmp("order");
		for n in [
			"Polestar",
			"Polestar_Codex",
			"Polestar_QuestDB",
			"Polestar_deDE",
			"Polestar_Guides_Orc",
			"Polestar_Guides_Horde",
			"Polestar_Guides_Alliance",
			"Polestar_frFR",
			"Polestar_Guides_deDE",
			"Polestar_Names_frFR",
		] {
			addon(&root, n);
		}
		let r = release_addons(&root);
		assert_eq!(
			r.names,
			[
				"Polestar",
				"Polestar_Guides",
				"Polestar_Nav",
				"Polestar_Guides_Alliance",
				"Polestar_Guides_Horde",
				"Polestar_Guides_Orc",
				"Polestar_QuestDB",
				"Polestar_Codex",
				"Polestar_deDE",
				"Polestar_frFR"
			]
		);
		assert!(r.skipped.contains(&"Polestar_ItemDB".to_string()));
		assert!(!r.skipped.contains(&"Polestar_Codex".to_string()));
		// The folders the language folders replaced never ship; the release names them.
		assert_eq!(retired_addons(&root), ["Polestar_Guides_deDE", "Polestar_Names_frFR"]);
	}

	#[test]
	fn the_codex_ships_only_built_from_release_safe_inputs() {
		let root = tmp("codex");
		let dir = root.join(CODEX);
		assert_eq!(codex_refusal(&dir).unwrap(), "not built (run `forge data codex`)");
		addon(&root, CODEX);
		assert!(codex_refusal(&dir).unwrap().starts_with("Meta.lua is missing"));
		std::fs::write(dir.join("Meta.lua"), "C.Register(\"meta\", {\n\tlocalExtras = false,\n\tsources = {\n\t\t{\n\t\t\tname = \"pfQuest\",\n\t\t},\n\t},\n})\n").unwrap();
		assert!(codex_refusal(&dir).unwrap().starts_with("LICENSE-DATA.txt is missing"));
		std::fs::write(dir.join("LICENSE-DATA.txt"), "Polestar Codex: third-party notices\n").unwrap();
		assert_eq!(codex_refusal(&dir), None);
		std::fs::write(dir.join("Meta.lua"), "C.Register(\"meta\", {\n\tlocalExtras = true,\n})\n").unwrap();
		assert!(codex_refusal(&dir).unwrap().starts_with("it is a --local-extras build"));
		// An older local build that predates the flag still names its inputs.
		std::fs::write(dir.join("Meta.lua"), "C.Register(\"meta\", {\n\tsources = {\n\t\t{\n\t\t\tlicence = \"GPL-2.0\",\n\t\t\tname = \"AtlasLootClassic\",\n\t\t},\n\t},\n})\n").unwrap();
		assert_eq!(codex_refusal(&dir).unwrap(), "its sources include a local-only input (AtlasLootClassic); rebuild it with `forge data codex`");
	}

	#[test]
	fn a_data_addon_ships_only_with_its_notice() {
		let root = tmp("notice");
		addon(&root, "Polestar_QuestDB");
		let names = vec!["Polestar".to_string(), "Polestar_QuestDB".to_string()];
		assert_eq!(notice_refusal(&root, &names).unwrap(), "Polestar_QuestDB has no LICENSE-DATA.txt (rebuild it with `forge data questdb`)");
		std::fs::write(root.join("Polestar_QuestDB").join("LICENSE-DATA.txt"), "Polestar quest database: third-party notices\n").unwrap();
		assert_eq!(notice_refusal(&root, &names), None);
	}

	#[test]
	fn a_guide_part_ships_only_with_its_notice() {
		let root = tmp("guide-notice");
		for n in ["Polestar_Guides", "Polestar_Guides_Horde"] {
			addon(&root, n);
		}
		std::fs::write(root.join("Polestar_Guides").join("LICENSE-DATA.txt"), "notices\n").unwrap();
		let names = vec!["Polestar_Guides".to_string(), "Polestar_Guides_Horde".to_string()];
		assert_eq!(guide_notice_refusal(&root, &names).unwrap(), "Polestar_Guides_Horde has no LICENSE-DATA.txt (rebuild it with `forge guide compile`)");
		std::fs::write(root.join("Polestar_Guides_Horde").join("LICENSE-DATA.txt"), "notices\n").unwrap();
		assert_eq!(guide_notice_refusal(&root, &names), None);
	}
}
