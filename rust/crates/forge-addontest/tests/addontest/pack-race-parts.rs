//! A pack's race parts and retired guides (forge-guide's build_pack_files; addon/Polestar/Core/Guides.lua,
//! Engine.lua): leveling guides for one class and named races ship in <folder>_<race file>, a load-on-demand
//! addon Polestar loads for the player's race once the pack is in; the ids in the pack's retired.json become
//! Polestar.RetireGuides, and a saved tab of a retired guide opens its successor, the pack's leveling guide for
//! the player now.

use forge_addontest::dsl::{build_pack, write_pack_dir};
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, is_match, Addon, RunAddon};
use forge_guide::project::{Built, FileContent};
use serde_json::{json, Value};
use std::path::Path;

fn guide(id: &str, head: &str) -> String {
	format!("guide {id}\ntitle Elwynn Forest\nfaction Alliance\n{head}\nlevels 1-10\nzone Elwynn Forest\n\nstep Marshal McBride\n  accept 7\n  turnin 7\n")
}

// A pack with a plain guide, a Human Warrior chain, a Human and Dwarf Mage chain; retired: `retired` (JSON).
fn pack_dir(retired: Option<&str>, mage: bool) -> TempDir {
	let tmp = TempDir::new("polestar-parts-");
	let dir = tmp.path();
	let write = |rel: &str, text: &str| std::fs::write(dir.join(rel), text).unwrap();
	write("pack.json", r#"{"id":"parts","title":"Parts Pack","author":"Ann","version":"1.0.0","license":"CC0-1.0","folder":"PolestarPack_Parts"}"#);
	std::fs::create_dir(dir.join("guides")).unwrap();
	write("guides/plain.guide", &guide("parts/plain", ""));
	write("guides/human-warrior.guide", &guide("parts/human-warrior/01", "race Human\nclass Warrior"));
	write("guides/warrior-2.guide", &guide("parts/human-warrior/02", "race Human\nclass Warrior").replacen("levels 1-10", "levels 10-12", 1));
	if mage {
		write("guides/mage.guide", &guide("parts/human-dwarf-mage/01", "race Human,Dwarf\nclass Mage"));
	}
	if let Some(r) = retired {
		write("retired.json", r);
	}
	tmp
}

const OLD: Option<&str> = Some(r#"["parts/old-elwynn"]"#);

fn build(dir: &Path) -> Built {
	let r = build_pack(dir);
	assert_eq!(r.project.diag.errors().iter().map(|d| d.message.as_str()).collect::<Vec<_>>(), Vec::<&str>::new());
	r
}

fn text<'a>(r: &'a Built, name: &str) -> &'a str {
	match r.files.as_ref().unwrap().iter().find(|(n, _)| n == name) {
		Some((_, FileContent::Text(t))) => t,
		_ => panic!("no {name}"),
	}
}

#[test]
fn class_chains_go_into_a_load_on_demand_part_per_race_the_retired_ids_into_the_pack() {
	let dir = pack_dir(OLD, true);
	let r = build(dir.path());
	let files: Vec<&str> = r.files.as_ref().unwrap().iter().map(|(n, _)| n.as_str()).collect();
	assert!(files.contains(&"../PolestarPack_Parts_Human/PolestarPack_Parts_Human.toc"));
	assert!(files.contains(&"../PolestarPack_Parts_Dwarf/Guides.lua"));
	let main = text(&r, "Guides.lua");
	assert!(is_match(main, r"parts/plain"));
	assert!(!is_match(main, r"parts/human-warrior/01"));
	assert!(is_match(main, r#"Polestar\.RetireGuides\("parts", \{\n\t"parts/old-elwynn",\n\}\)"#));
	let human = text(&r, "../PolestarPack_Parts_Human/Guides.lua");
	assert!(is_match(human, r"parts/human-warrior/01"));
	assert!(is_match(human, r"parts/human-dwarf-mage/01"));
	assert!(!is_match(text(&r, "../PolestarPack_Parts_Dwarf/Guides.lua"), r"human-warrior"));
	let toc = text(&r, "../PolestarPack_Parts_Human/PolestarPack_Parts_Human.toc");
	assert!(is_match(toc, r"## LoadOnDemand: 1\n## Dependencies: Polestar, PolestarPack_Parts\n## X-Polestar-Part: parts\n## X-Polestar-Race: Human"));
}

#[test]
fn a_retired_json_that_is_no_list_of_ids_is_an_error_a_retired_id_still_in_the_pack_warns() {
	let bad_dir = pack_dir(Some(r#"{"a":1}"#), true);
	let bad = build_pack(bad_dir.path());
	assert!(bad.project.diag.errors().iter().any(|d| is_match(&d.message, "must be a list of guide ids")));
	let live_dir = pack_dir(Some(r#"["parts/plain"]"#), true);
	let live = build_pack(live_dir.path());
	assert!(live.project.diag.list.iter().any(|d| d.severity == "warning" && is_match(&d.message, r#"retired guide id "parts/plain" is still a guide"#)));
}

// The built pack in an AddOns folder, loaded as the client would for a Human Warrior with `saved` as the
// character's saved state.
fn play(saved: &str) -> Vec<Value> {
	let addons = TempDir::new("polestar-parts-play-");
	let out = addons.path().join("PolestarPack_Parts");
	let dir = pack_dir(OLD, true);
	write_pack_dir(&out, build(dir.path()).files.as_ref().unwrap());
	let part = |name: &str| format!("stub.packs[{}] = {{ {} }}", serde_json::to_string(name).unwrap(), serde_json::to_string(&addons.path().join(name).join("Guides.lua")).unwrap());
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!(
			"{}\n{}\n{}",
			part("PolestarPack_Parts_Human"),
			part("PolestarPack_Parts_Dwarf"),
			r#"local w = stub.world
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Human", "Human", "WARRIOR", "Warrior", "Alliance", 1
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)"#
		),
		addons: vec![Addon::name("Polestar"), Addon::dir("PolestarPack_Parts", &out)],
		saved: vec![("Polestar".into(), format!("PolestarCharDB = {saved}"))],
		script: r#"stub.login()
local G = Polestar.Guides
emit({ human = stub.packLoads.PolestarPack_Parts_Human or 0, dwarf = stub.packLoads.PolestarPack_Parts_Dwarf or 0,
	warrior = G.Get("parts/human-warrior/01") ~= nil, retired = G.IsRetired("parts/old-elwynn"),
	guide = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false,
	mage = G.Get("parts/human-dwarf-mage/01") ~= nil,
	open = rawget(G.Get("parts/human-warrior/01"), "steps") ~= nil,
	other = rawget(G.Get("parts/human-warrior/02"), "steps") ~= nil })
Polestar.Engine.SetGuide("parts/human-warrior/02")
emit({ first = rawget(G.Get("parts/human-warrior/01"), "steps") ~= nil, second = rawget(G.Get("parts/human-warrior/02"), "steps") ~= nil,
	title = Polestar.Engine.GetStepView(1).title })"#
			.into(),
		..Default::default()
	})
}

#[test]
fn the_player_s_race_part_loads_with_the_pack_the_other_race_s_does_not_a_saved_retired_guide_opens_its_successor() {
	let out = play(r#"{ schema = 1, tabs = { "parts/old-elwynn" }, activeTab = 1 }"#);
	let (r, after) = (&out[0], &out[1]);
	assert_eq!(r["human"], 1);
	assert_eq!(r["dwarf"], 0);
	assert_eq!(r["warrior"], true);
	assert_eq!(r["retired"], true);
	assert_eq!(r["guide"], "parts/human-warrior/01", "the Human Warrior chain, the class-specific guide at level 1");
	// Only the player's class route registers; only the open guide's steps are read in.
	assert_eq!(r["mage"], false, "the Mage route of the same race part is never registered for a Warrior");
	assert_eq!(r["open"], true);
	assert_eq!(r["other"], false, "a guide not opened keeps its steps as source");
	assert_eq!(*after, json!({ "first": false, "second": true, "title": "Marshal McBride" }), "switched away, the first guide gives its steps back");
}

#[test]
fn a_race_part_keeps_each_guide_s_steps_as_one_source_string_with_its_count_the_class_decides_what_registers() {
	let dir = pack_dir(OLD, true);
	let r = build(dir.path());
	let part = text(&r, "../PolestarPack_Parts_Human/Guides.lua");
	assert!(is_match(part, r"stepCount = 1,\n\t\t\tstepsSrc = \x22return \{"));
	assert!(!is_match(part, r"\tsteps = \{"));
	assert!(is_match(part, r#"if Polestar\.PartWants\(\{ "WARRIOR" \}\) then register\(\) end"#));
	assert!(is_match(text(&r, "Guides.lua"), r"\t\t\tsteps = \{"), "the pack's own guides are as before");
}
