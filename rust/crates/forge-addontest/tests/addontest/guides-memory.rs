//! What Polestar's own guide pack costs in memory (issues #60, #693): addon/Polestar_Guides loaded the way the
//! client loads it, with Polestar reading it (Core/Guides.lua) for one Alliance (Human) and one Horde (Orc)
//! character, under Lua 5.1 as the client counts it (collectgarbage("count")). The pack is format 8
//! (docs/PACK_FORMAT.md, "Format 8"): each faction's guides in a load-on-demand part
//! (Polestar_Guides_Alliance, _Horde) of which only the player's faction's loads, a goal's spawn spots as
//! one string, built into tables on the goal's first read of `spots`, and the side shelves (every guide that
//! is not a leveling guide) with their steps as one source string, read in when the guide is opened. Each
//! figure fails the test when it grows past its budget: the figure measured at the release's code freeze plus
//! 3 %, moved only then (docs/CI.md, "Memory budgets").
//!
//!   resident      after loading the pack (and the part it loads) and two full collects
//!   peak          the heap grown while loading them, with the collector stopped
//!   read          after reading every registered goal's spots once and two full collects: the most a
//!                 session can build (a session builds only the spots of the goals it shows; a shelf guide
//!                 is read in for the look and given back, Guides.Peek, as the guide menu and the indexes
//!                 do, so its steps count while read, not after)
//!
//! The pack is in the repository, so this needs no reference data and no game.

use forge_addontest::run::{addons_dir, lua_string};
use forge_addontest::{emitted, Addon, RunAddon};
use std::path::PathBuf;

fn part(name: &str) -> PathBuf {
	addons_dir().join(name)
}

/// The Lua list of a part's files for stub_packs.lua (stub.packs[name]); nothing for a part not built (the
/// budget test then says the part did not load).
fn pack_files(name: &str) -> String {
	if !part(name).exists() {
		return String::new();
	}
	let files = forge_addontest::run::dir_files(&part(name)).unwrap_or_else(|e| panic!("{e}"));
	let list: Vec<String> = files.iter().map(|f| lua_string(&f.to_string_lossy())).collect();
	format!("stub.packs[{}] = {{ {} }}", lua_string(name), list.join(", "))
}

/// KiB (Lua 5.1, 64-bit), measured here on the committed pack on 2026-10-24 (222 guides, 3,937 steps,
/// 12,280 goals, 25,233 spots; 155 registered for the Alliance character, 152 for the Horde one): Alliance
/// resident 10,499, peak 22,119, read 15,833; Horde resident 10,249, peak 21,665, read 16,146. The format-4
/// pack (every guide in Polestar_Guides, spots as tables) cost 24,378 resident and 47,362 at the peak for
/// either faction (the same harness, the same runtime).
/// The 1-60 routes and their baked legs grew the pack; 0.4.3's side shelves (#1863) took about 5,700 KiB a faction
/// back. Measured on next f5bd74406e (2026-11-26, #4143; three runs reading the same): Alliance
/// resident 13,938, peak 27,342, read 19,808; Horde resident 13,004, peak 24,904, read 19,070. Each budget is that
/// figure plus 3 % (docs/CI.md, "Memory budgets").
const BUDGET: [(&str, &str, [(&str, f64); 3]); 2] =
	[("Alliance", "Human", [("resident", 14360.0), ("peak", 28170.0), ("read", 20410.0)]), ("Horde", "Orc", [("resident", 13400.0), ("peak", 25660.0), ("read", 19650.0)])];

#[test]
fn the_guide_pack_stays_within_its_memory_budget_for_each_faction_693() {
	let mut over = vec![];
	for (faction, race, budget) in BUDGET {
		let main = forge_addontest::run::dir_files(&part("Polestar_Guides")).unwrap_or_else(|e| panic!("{e}"));
		let files: Vec<String> = main.iter().map(|f| lua_string(&f.to_string_lossy())).collect();
		let script = format!(
			r#"
local G = Polestar.Guides
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
local base = full()
collectgarbage("stop")
local ns = {{}}
for _, f in ipairs({{ {files} }}) do assert(loadfile(f))("Polestar_Guides", ns) end
stub.addonLoaded("Polestar_Guides")
local peak = collectgarbage("count") - base
collectgarbage("restart")
local resident = full() - base
stub.login()
local guides, other, spots = 0, 0, 0
local shelves, readIn, slowest, slowestId = 0, 0, 0, false
for _, h in ipairs(G.List()) do
	guides = guides + 1
	if h.faction and h.faction ~= {faction} then other = other + 1 end
	local t0 = os.clock()
	local steps, fresh = G.Peek(h.id)
	local dt = (os.clock() - t0) * 1000
	if fresh then
		shelves, readIn = shelves + 1, readIn + dt
		if dt > slowest then slowest, slowestId = dt, h.id end
	end
	for _, step in ipairs(steps) do
		for _, goal in ipairs(step.goals) do if goal.spots then spots = spots + #goal.spots end end
	end
	G.Unpeek(h.id, fresh)
end
local read = full() - base
emit({{ resident = resident, peak = peak, read = read, guides = guides, other = other, spots = spots,
	shelves = shelves, readIn = readIn, slowest = slowest, slowestId = slowestId,
	alliance = stub.packLoads.Polestar_Guides_Alliance or 0, horde = stub.packLoads.Polestar_Guides_Horde or 0 }})"#,
			files = files.join(", "),
			faction = lua_string(faction),
		);
		let out = emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_packs.lua"],
			before: format!(
				"{}\n{}\nlocal w = stub.world\nw.faction, w.race, w.raceName = {}, {}, {}",
				pack_files("Polestar_Guides_Alliance"),
				pack_files("Polestar_Guides_Horde"),
				lua_string(faction),
				lua_string(race),
				lua_string(race)
			),
			addons: vec![Addon::name("Polestar")],
			script,
			..Default::default()
		});
		let m = &out[0];
		for (k, b) in budget {
			let v = m[k].as_f64().unwrap();
			eprintln!("{faction} {k}: {v:.0} KiB (budget {b})");
			if v > b {
				over.push(format!("{faction} {k} {v:.0} KiB > {b}"));
			}
		}
		// What a side shelf costs when it is opened (Guides.Steps, read in once per opening): reported, not
		// budgeted (timings vary from run to run).
		eprintln!(
			"{faction}: {} side-shelf guides read in for the look in {:.1} ms, the slowest {:.2} ms ({})",
			m["shelves"],
			m["readIn"].as_f64().unwrap_or(0.0),
			m["slowest"].as_f64().unwrap_or(0.0),
			m["slowestId"]
		);
		let mine = if faction == "Alliance" { "alliance" } else { "horde" };
		let theirs = if faction == "Alliance" { "horde" } else { "alliance" };
		if (m[mine].as_i64(), m[theirs].as_i64()) != (Some(1), Some(0)) {
			over.push(format!("{faction}: its own faction's part loads with the pack, the other's does not ({mine} {}, {theirs} {})", m[mine], m[theirs]));
		}
		if m["other"] != 0 {
			over.push(format!("{faction}: {} guides of the other faction registered", m["other"]));
		}
		assert!(m["guides"].as_i64().unwrap() > 140, "{faction}: only {} guides registered", m["guides"]);
		assert!(m["spots"].as_i64().unwrap() > 10000, "{faction}: only {} spots read back", m["spots"]);
	}
	assert!(over.is_empty(), "over budget: {}", over.join(", "));
}

// The other faction's guides stay out: nothing asks for them (the guide menu lists the character's side only,
// #2462); only a saved tab of one (from before) brings them in at login, to show whose guide it is.
#[test]
fn the_other_faction_s_part_stays_out_unless_a_saved_tab_needs_it() {
	let run = |saved: &str, script: &str| {
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_packs.lua"],
			before: format!("{}\n{}\nlocal w = stub.world\nw.faction, w.race, w.raceName = \"Horde\", \"Orc\", \"Orc\"", pack_files("Polestar_Guides_Alliance"), pack_files("Polestar_Guides_Horde")),
			addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Guides")],
			saved: vec![("Polestar".into(), format!("PolestarCharDB = {saved}"))],
			login: true,
			script: script.into(),
		})
	};
	let fresh = run(
		"nil",
		r#"emit({ guide = Polestar.Guides.Get("forever/alliance/02-westfall") ~= nil, loads = stub.packLoads.Polestar_Guides_Alliance or 0,
	loadFaction = Polestar.Guides.LoadFaction ~= nil })"#,
	);
	assert_eq!(fresh[0], serde_json::json!({ "guide": false, "loads": 0, "loadFaction": false }));
	let saved = run(
		r#"{ schema = 1, tabs = { "forever/alliance/02-westfall" }, activeTab = 1 }"#,
		r#"emit({ loads = stub.packLoads.Polestar_Guides_Alliance or 0, guide = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false })"#,
	);
	assert_eq!(saved[0], serde_json::json!({ "loads": 1, "guide": "forever/alliance/02-westfall" }), "the saved tab of an Alliance guide comes back on a Horde character");
}

// #3924: a saved tab of a guide no part has (renamed or taken out of Polestar) loaded both faction parts at every
// login, so an Alliance character carried the Horde part and the other way round. The other faction's part comes
// in only for a guide it has (the pack's PartGuides index); a tab of a guide no part has loads nothing, and a
// retired one opens the guide it became, of the character's own faction.
#[test]
fn a_saved_tab_of_a_guide_no_part_has_never_loads_the_other_faction_s_part_3924() {
	let run = |faction: &str, race: &str, tabs: &str| {
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_packs.lua"],
			before: format!(
				"{}\n{}\nlocal w = stub.world\nw.faction, w.race, w.raceName = {}, {}, {}",
				pack_files("Polestar_Guides_Alliance"),
				pack_files("Polestar_Guides_Horde"),
				lua_string(faction),
				lua_string(race),
				lua_string(race)
			),
			addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Guides")],
			saved: vec![("Polestar".into(), format!("PolestarCharDB = {{ schema = 1, tabs = {{ {tabs} }}, activeTab = 1 }}"))],
			login: true,
			script: r#"local g = Polestar.Engine.GetGuide()
emit({ alliance = stub.packLoads.Polestar_Guides_Alliance or 0, horde = stub.packLoads.Polestar_Guides_Horde or 0, guide = g and g.id or false })"#
				.into(),
		})[0]
			.clone()
	};
	// A guide no release ever had: nothing loads, on either side.
	let none = run("Horde", "Tauren", r#""forever/class/druid/no-such-guide""#);
	assert_eq!((none["alliance"].as_i64(), none["horde"].as_i64()), (Some(0), Some(1)), "a Horde character with a tab of an unknown guide: {none}");
	let none = run("Alliance", "Human", r#""forever/horde/40-50/no-such-guide""#);
	assert_eq!((none["alliance"].as_i64(), none["horde"].as_i64()), (Some(1), Some(0)), "an Alliance character with a tab of an unknown guide: {none}");
	// Taken out in 0.4.3 (retired): no other part, the character's own leveling guide in its place.
	let drowned = run("Horde", "Tauren", r#""forever/miscellaneous/the-drowned-city-alliance""#);
	assert_eq!(drowned["alliance"], 0, "{drowned}");
	assert!(drowned["guide"].as_str().is_some_and(|g| g.starts_with("forever/horde/")), "the Horde leveling guide for the character: {drowned}");
	// Moved in 0.3.3 (retired with its new id): the guide it became.
	let stalk = run("Horde", "Tauren", r#""forever/class/shaman/stalk-with-the-earthmother""#);
	assert_eq!(stalk, serde_json::json!({ "alliance": 0, "horde": 1, "guide": "forever/miscellaneous/stalk-with-the-earthmother" }));
	// Another race's guide of the character's own faction (in its own part): the other part stays out.
	let other_race = run("Alliance", "Dwarf", r#""forever/alliance/human/01-elwynn-forest""#);
	assert_eq!(other_race["horde"], 0, "{other_race}");
}

// Baked legs in Polestar's own pack (formats 7 and 8, #3507): an Alliance zone guide ships in the faction part,
// and so do its legs, one Legs_<race>.lua per Alliance race, each returning at once for a player of another race.
// The faction part's guides load before its races' files, so Polestar.RegisterLegs finds the guide registered and
// keeps its legs; no race part loads, not even one left installed from before 0.4.3.
#[test]
fn the_faction_part_carries_its_races_legs_and_no_race_part_loads() {
	let r = forge_addontest::dsl::compile(&forge_addontest::dsl::guide_text(&[
		"guide forever/alliance/t-legs",
		"title Legs",
		"faction Alliance",
		"levels 1-10",
		"zone Elwynn Forest",
		"",
		"step S",
		"  level 2",
	]));
	assert_eq!(r.errors, Vec::<String>::new());
	r.guides[0].set_hidden("_legs", forge_guide::js::parse_json(r#"{ "1": "CgA" }"#).unwrap());
	r.guides[0].set_hidden("_legsGrid", "test");
	let pack = forge_addontest::dsl::write_our_test_pack(&r.guides);
	let toc = pack.text("../Polestar_Guides_Alliance/Polestar_Guides_Alliance.toc");
	assert_eq!(toc.rsplit("\n\n").next(), Some("Guides.lua\nLegs_Dwarf.lua\nLegs_Gnome.lua\nLegs_Human.lua\nLegs_NightElf.lua\nLegs_Skyborne.lua\n"));
	assert!(pack.text("../Polestar_Guides_Alliance/Legs_Dwarf.lua").contains("\nif not Polestar.IsPlayerRace(\"Dwarf\") then return end\n"));
	let parent = pack.dir.parent().unwrap().to_path_buf();
	assert!(!parent.join("Polestar_Guides_Human").exists(), "no race part of our pack");
	let lua_list = |files: Vec<PathBuf>| files.iter().map(|f| lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", ");
	let entries = |dir: PathBuf| lua_list(forge_addontest::run::toc_entries(&dir).unwrap_or_else(|e| panic!("{e}")).iter().map(|f| dir.join(f)).collect());
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!(
			"stub.packs.Polestar_Guides_Alliance = {{ {} }}\nstub.packs.Polestar_Guides_Human = {{}}\nlocal w = stub.world\nw.faction, w.race, w.raceName = \"Alliance\", \"Human\", \"Human\"",
			entries(parent.join("Polestar_Guides_Alliance")),
		),
		addons: vec![Addon::name("Polestar")],
		script: format!(
			r#"
local ns = {{}}
for _, f in ipairs({{ {} }}) do assert(loadfile(f))("Polestar_Guides", ns) end
stub.addonLoaded("Polestar_Guides")
stub.login()
local legs = Polestar.Guides.Legs("forever/alliance/t-legs")
emit({{ guide = Polestar.Guides.Get("forever/alliance/t-legs") ~= nil, leg = legs and legs[1] or false,
	alliance = stub.packLoads.Polestar_Guides_Alliance or 0, human = stub.packLoads.Polestar_Guides_Human or 0,
	dwarf = Polestar.IsPlayerRace("Dwarf"), mine = Polestar.IsPlayerRace("Human") }})"#,
			entries(pack.dir.clone())
		),
		..Default::default()
	});
	assert_eq!(out[0], serde_json::json!({ "guide": true, "leg": "CgA", "alliance": 1, "human": 0, "dwarf": false, "mine": true }));
}

// Side shelves (format 8): a guide of our pack that is not a leveling guide ships its steps as source and
// registers without them, listed with its step count. Opening it in a tab reads them in; a look at every
// guide's steps (Unlocks' index, Guides.Peek) reads a shelf in and gives it back; closing its tab gives its
// steps back too. One shelf in the pack (no faction), one in the Alliance part.
#[test]
fn a_side_shelf_guide_s_steps_load_when_it_is_opened_and_go_when_its_tab_closes() {
	let shelf = |id: &str, category: &str, faction: &str| {
		let mut lines = vec![format!("guide {id}"), format!("title {category} guide"), format!("category {category}"), "class Druid".into()];
		if !faction.is_empty() {
			lines.push(format!("faction {faction}"));
		}
		lines.extend(["levels 1-10", "zone Elwynn Forest", "", "step First", "  accept 7", "", "step Second", "  turnin 7"].map(String::from));
		lines
	};
	let class = shelf("forever/class/druid/t-shelf", "Class", "");
	let prof = shelf("forever/professions/t-shelf", "Professions", "Alliance");
	let sources: Vec<String> = [class, prof].iter().map(|l| forge_addontest::dsl::guide_text(&l.iter().map(String::as_str).collect::<Vec<_>>())).collect();
	let files: Vec<(String, &str)> = sources.iter().enumerate().map(|(i, s)| (format!("t{i}.guide"), s.as_str())).collect();
	let r = forge_addontest::dsl::compile_with(&files.iter().map(|(f, s)| (f.as_str(), *s)).collect::<Vec<_>>(), &forge_addontest::dsl::fixture_data(), None);
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = forge_addontest::dsl::write_our_test_pack(&r.guides);
	assert!(pack.text("Guides.lua").contains("stepsSrc = "), "the class guide ships its steps as source");
	assert!(pack.text("../Polestar_Guides_Alliance/Guides.lua").contains("stepsSrc = "), "so does the Alliance part's profession guide");
	let lua_list = |files: Vec<PathBuf>| files.iter().map(|f| lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", ");
	let entries = |dir: PathBuf| lua_list(forge_addontest::run::toc_entries(&dir).unwrap_or_else(|e| panic!("{e}")).iter().map(|f| dir.join(f)).collect());
	let parent = pack.dir.parent().unwrap().to_path_buf();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!(
			"stub.packs.Polestar_Guides_Alliance = {{ {} }}\nlocal w = stub.world\nw.faction, w.race, w.raceName = \"Alliance\", \"NightElf\", \"Night Elf\"\nw.class, w.className, w.classID = \"DRUID\", \"Druid\", 11",
			entries(parent.join("Polestar_Guides_Alliance"))
		),
		addons: vec![Addon::name("Polestar")],
		script: format!(
			r#"
local ns = {{}}
for _, f in ipairs({{ {} }}) do assert(loadfile(f))("Polestar_Guides", ns) end
stub.addonLoaded("Polestar_Guides")
stub.login()
local G, E = Polestar.Guides, Polestar.Engine
local function state(id)
	local def = G.Get(id)
	local h
	for _, x in ipairs(G.List()) do if x.id == id then h = x end end
	return {{ listed = h ~= nil and h.stepCount or false, inn = rawget(def, "steps") ~= nil }}
end
local ids = {{ "forever/class/druid/t-shelf", "forever/professions/t-shelf" }}
local out = {{}}
for _, id in ipairs(ids) do
	local s = {{ registered = state(id) }}
	Polestar.Unlocks.For(7)
	s.looked = state(id)
	E.SetGuide(id)
	local g = E.GetGuide()
	s.opened = state(id)
	s.first = g and g.id == id and g.steps[1].title or false
	E.SetGuide(nil)
	s.closed = state(id)
	out[id] = s
end
emit(out)"#,
			entries(pack.dir.clone())
		),
		..Default::default()
	});
	let one = |first: &str| {
		serde_json::json!({
			"registered": { "listed": 2, "inn": false },
			"looked": { "listed": 2, "inn": false },
			"opened": { "listed": 2, "inn": true },
			"first": first,
			"closed": { "listed": 2, "inn": false },
		})
	};
	assert_eq!(out[0]["forever/class/druid/t-shelf"], one("First"));
	assert_eq!(out[0]["forever/professions/t-shelf"], one("First"));
}

// A side-shelf guide reads in as the steps it would have had in its table, and its saved tab comes back after a
// reload. The same compiled guide is written twice, as a shelf (as our pack is compiled) and inline (its steps in
// the guide's table, as before the shelves); a character with that guide's tab saved logs in with each. Both
// land on the same step, the shelf's steps are read in for its tab and match the inline ones key for key, and
// closing the tab gives the shelf's steps back.
#[test]
fn a_side_shelf_guide_reads_in_as_its_inline_steps_and_its_saved_tab_comes_back_after_a_reload() {
	let id = "forever/class/druid/t-shelf";
	let header = format!("guide {id}");
	let r = forge_addontest::dsl::compile(&forge_addontest::dsl::guide_text(&[
		&header,
		"title Class guide",
		"category Class",
		"class Druid",
		"levels 1-10",
		"zone Elwynn Forest",
		"",
		"step First",
		"  accept 7",
		"",
		"step Kobolds",
		"  goto 52.3,26.8",
		"  kill 6 x10 quest 7.1",
		"  note Clear the camp for {npc:197}, one at a time.",
		"",
		"step Last",
		"  turnin 7",
	]));
	assert_eq!(r.errors, Vec::<String>::new());
	let shelf = forge_addontest::dsl::write_our_test_pack(&r.guides);
	assert!(shelf.text("Guides.lua").contains("stepsSrc = "), "the class guide ships its steps as source");
	let inline = forge_addontest::dsl::write_our_test_pack(&r.guides);
	let entries: Vec<forge_guide::js::V> = r
		.guides
		.iter()
		.map(|g| {
			let loc = g.hidden("_localised");
			forge_guide::obj! { "guide" => if loc.truthy() { loc } else { g.clone() }, "source" => forge_guide::js::V::Null }.into()
		})
		.collect();
	let text = forge_guide::emit::emit_guides_with(&entries, false, true);
	assert!(!text.contains("stepsSrc"), "the inline copy keeps its steps in its table");
	std::fs::write(inline.dir.join("Guides.lua"), text).unwrap();
	let run = |pack: &forge_addontest::dsl::TestPack| {
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_packs.lua"],
			before: "local w = stub.world\nw.faction, w.race, w.raceName = \"Alliance\", \"NightElf\", \"Night Elf\"\nw.class, w.className, w.classID = \"DRUID\", \"Druid\", 11".into(),
			addons: vec![Addon::name("Polestar"), Addon::dir("Polestar_Guides", pack.dir.clone())],
			saved: vec![("Polestar".into(), format!("PolestarCharDB = {{ schema = 1, tabs = {{ {0} }}, activeTab = 1, pins = {{ [{0}] = {{ step = 2, done = false }} }} }}", lua_string(id)))],
			login: true,
			script: format!(
				r#"local G, E = Polestar.Guides, Polestar.Engine
local def, g = G.Get({0}), E.GetGuide()
local out = {{ guide = g and g.id or false, inn = rawget(def, "steps") ~= nil, step = E.GetStepIndex() or false, steps = def.steps }}
E.SetGuide(nil)
out.closed = rawget(def, "steps") ~= nil
emit(out)"#,
				lua_string(id)
			),
		})
		.remove(0)
	};
	let (a, b) = (run(&shelf), run(&inline));
	assert_eq!(
		(&a["guide"], &a["inn"], &a["closed"]),
		(&serde_json::json!(id), &serde_json::json!(true), &serde_json::json!(false)),
		"the shelf's tab comes back with its steps read in; closing it gives them back"
	);
	assert_eq!(b["closed"], serde_json::json!(true), "inline steps stay");
	assert_eq!(a["step"], b["step"], "the shelf lands on the inline guide's step");
	assert_eq!(a["steps"], b["steps"], "the shelf's steps read in as the inline ones");
}

// A side-shelf guide opened again after its tab closed reads its steps in afresh, and the Engine's per-guide
// lookups (the goal layout, the step numbers, the chain's needs) follow the new tables: the hand-in of an
// optional quest the character did not take stays out the second time as it did the first (before, the layout
// kept the first reading's goals, missed the new hand-in and let it count again).
#[test]
fn a_side_shelf_guide_opened_again_answers_from_its_new_steps() {
	let id = "forever/class/druid/t-again";
	let header = format!("guide {id}");
	let r = forge_addontest::dsl::compile(&forge_addontest::dsl::guide_text(&[
		&header,
		"title Class guide",
		"category Class",
		"class Druid",
		"levels 1-10",
		"zone Elwynn Forest",
		"",
		"step Camp",
		"  accept 7 optional",
		"",
		"step Hand in",
		"  turnin 7",
	]));
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = forge_addontest::dsl::write_our_test_pack(&r.guides);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: "local w = stub.world\nw.faction, w.race, w.raceName = \"Alliance\", \"NightElf\", \"Night Elf\"\nw.class, w.className, w.classID = \"DRUID\", \"Druid\", 11".into(),
		addons: vec![Addon::name("Polestar"), Addon::dir("Polestar_Guides", pack.dir.clone())],
		login: true,
		script: format!(
			r#"local G, E = Polestar.Guides, Polestar.Engine
E.SetGuide({0})
local first = E.Applies(2, 1)
E.SetGuide(nil)
local dropped = rawget(G.Get({0}), "steps") == nil
E.SetGuide({0})
emit({{ first = first, dropped = dropped, again = E.Applies(2, 1) }})"#,
			lua_string(id)
		),
		..Default::default()
	});
	assert_eq!(out[0], serde_json::json!({ "first": false, "dropped": true, "again": false }));
}

// A goal's packed spots (format 8) are checked at registration without being built, read back on the goal's
// first read of `spots` as the tables the compiler had, and kept on the goal (the Engine keys its pick and
// visits by spot). A string that is not packed spots, or one beside `spots`, refuses the guide.
#[test]
fn packed_spots_read_back_as_the_compiler_s_tables_and_a_bad_string_refuses_the_guide() {
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"
local G = Polestar.Guides
assert(Polestar.RegisterPack({ addon = "JoeAddon", id = "joe", format = 8, title = "Joe", author = "Joe", version = "1", license = "MIT" }))
local function guide(id, goal)
	goal.t, goal.target, goal.npc, goal.map, goal.x, goal.y = "kill", "Young Wolf", 299, 1429, 43.5, 9.2
	local ok, err = Polestar.RegisterGuide({ id = id, pack = "joe", title = id, steps = { { goals = { goal } } } })
	return ok and true or err
end
local res = {
	ok = guide("joe/ok", { spotsPacked = "43.5,9.2,,110,19;47.4,9.7,-12.5,4,,1;50,50.25,,15,2" }),
	spread = guide("joe/spread", { spotsPacked = "1,2,,3", spread = true }),
	trailing = guide("joe/trailing", { spotsPacked = "1,2,,3;" }),
	noR = guide("joe/nor", { spotsPacked = "1,2" }),
	word = guide("joe/word", { spotsPacked = "1,2,,x" }),
	both = guide("joe/both", { spotsPacked = "1,2,,3", spots = { { x = 1, y = 2, r = 3 } } }),
	empty = guide("joe/empty", { spotsPacked = "" }),
}
local goal = G.Get("joe/ok").steps[1].goals[1]
local before = rawget(goal, "spots") == nil
local spots = goal.spots
emit({ res = res, before = before, spots = spots, same = goal.spots == spots, kept = rawget(goal, "spots") == spots,
	valid = G.Validate(G.Get("joe/ok")) or true })
"#
		.into(),
		..Default::default()
	});
	let m = &out[0];
	assert_eq!(
		m["res"],
		serde_json::json!({ "ok": true, "spread": true, "trailing": "step 1 goal 1: bad spots", "noR": "step 1 goal 1: bad spots", "word": "step 1 goal 1: bad spots", "both": "step 1 goal 1: bad spots", "empty": "step 1 goal 1: bad spots" })
	);
	assert_eq!(m["before"], true, "registering does not build the spots");
	assert_eq!(m["spots"], serde_json::json!([{ "x": 43.5, "y": 9.2, "r": 110, "n": 19 }, { "x": 47.4, "y": 9.7, "z": -12.5, "r": 4, "alt": true }, { "x": 50, "y": 50.25, "r": 15, "n": 2 }]));
	assert_eq!((m["same"].clone(), m["kept"].clone(), m["valid"].clone()), (serde_json::json!(true), serde_json::json!(true), serde_json::json!(true)));
}

// Exact points (#1944): a packed spot of radius 0 is built as the array { x, y, z? } that Own.POINT reads by
// name (its `r` reads 0; `alt` and `lvl` as written), in about half a spot table's memory, so a goal holding
// 40 points costs what one holding 20 spots did. A goal of them is exact (Engine.SpotsExact).
#[test]
fn packed_exact_points_read_back_by_name_in_about_half_a_spot_s_memory_1944() {
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"
local G = Polestar.Guides
assert(Polestar.RegisterPack({ addon = "JoeAddon", id = "joe", format = 8, title = "Joe", author = "Joe", version = "1", license = "MIT" }))
local function guide(id, packed)
	local goal = { t = "collect", item = 5, itemName = "Trapped Game", map = 1429, x = 43.41, y = 14.62, spotsPacked = packed }
	assert(Polestar.RegisterGuide({ id = id, pack = "joe", title = id, steps = { { goals = { goal } } } }))
	return G.Get(id).steps[1].goals[1]
end
local goal = guide("joe/points", "43.41,14.62,,0;45.1,16.1,12.5,0;42.7,21.2,,0,,1,14")
local read = {}
for i, p in ipairs(goal.spots) do read[i] = { p.x, p.y, p.z or false, p.r, p.n or false, p.alt or false, p.lvl or false, rawget(p, "x") == nil } end
-- Bytes per entry of 400 built, the list's slot included. A first build of the same records in another order (its own
-- list: lists are shared by their packed text) makes the field strings the parse creates once, so the client's string
-- table, which may double then, has grown before the measured build: its growth is no entry's cost.
local function cost(id, rec)
	local t, back = {}, {}
	for i = 1, 400 do t[i] = rec:format(i % 90 + 5, i % 70 + 5) end
	for i = 400, 1, -1 do back[#back + 1] = t[i] end
	local _ = #guide(id .. "-first", table.concat(back, ";")).spots
	local g = guide(id, table.concat(t, ";"))
	collectgarbage("collect"); collectgarbage("collect")
	local before = collectgarbage("count")
	local n = #g.spots
	collectgarbage("collect"); collectgarbage("collect")
	return (collectgarbage("count") - before) * 1024 / n
end
local camp = guide("joe/camp", "43.5,9.2,,110,19;47.4,9.7,,40,3")
emit({ read = read, exact = { Polestar.Engine.SpotsExact(goal), Polestar.Engine.SpotsExact(camp) },
	point = cost("joe/many-points", "%d.25,%d.5,,0"), spot = cost("joe/many-spots", "%d.25,%d.5,,40,3"),
	valid = G.Validate(G.Get("joe/points")) or true })
"#
		.into(),
		..Default::default()
	});
	let m = &out[0];
	assert_eq!(
		m["read"],
		serde_json::json!([[43.41, 14.62, false, 0, false, false, false, true], [45.1, 16.1, 12.5, 0, false, false, false, true], [42.7, 21.2, false, 0, false, true, 14, true]]),
		"x, y and z by name from the array, r 0, alt and lvl as written"
	);
	assert_eq!(m["exact"], serde_json::json!([true, false]));
	assert_eq!(m["valid"], true, "the goal still validates once its points are built");
	let (point, spot) = (m["point"].as_f64().unwrap(), m["spot"].as_f64().unwrap());
	eprintln!("a packed point: {point:.0} bytes, a packed spot: {spot:.0} bytes (Lua 5.1, list slot included)");
	assert!(point < spot * 0.6, "a point costs {point:.0} bytes against a spot's {spot:.0}");
	assert!(point < 130.0 && spot < 260.0, "absent optional fields must not reserve space: {point:.0} bytes per point, {spot:.0} per camp");
}

// Issue #60, the load-time spike: registering a guide runs Guides.Validate over every step and goal. The key
// lists those checks walk used to be table literals inside their loops, so each of the pack's ~12,000 goals
// left a few throwaway tables behind (about 3 MiB over a full registration). They are one shared table now
// (`KEYS` in Core/Guides.lua), and validating allocates almost nothing; a goal's packed spots are checked
// without building them (Own.spotsPackedOk).
//
// Measured here on the validation alone, with the pack and both faction parts already loaded, so the figure
// is not buried under what the Lua parser allocates. Before the change: 0.267 KiB per goal under Lua 5.1 and
// 0.243 under LuaJIT. After: 0.000 and 0.011.
const MAX_VALIDATE_KIB_PER_GOAL: f64 = 0.05;

#[test]
fn validating_the_registered_guides_allocates_almost_nothing_per_goal() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		// The pack and its parts by their TOCs, the way the client loads them, so a file added to one is
		// measured.
		addons: vec![
			Addon::files("Polestar", &["Core/Core.xml"]),
			Addon::dir("Polestar_Guides", part("Polestar_Guides")),
			Addon::dir("Polestar_Guides_Alliance", part("Polestar_Guides_Alliance")),
			Addon::dir("Polestar_Guides_Horde", part("Polestar_Guides_Horde")),
		],
		script: r#"
			local defs, goals = {}, 0
			for _, header in ipairs(Polestar.Guides.List()) do
				local g = Polestar.Guides.Get(header.id)
				if g then
					defs[#defs + 1] = g
					for _, step in ipairs(g.steps) do goals = goals + #step.goals end
				end
			end
			-- Nothing is freed while the collector is stopped, so what the
			-- validation allocates is what it would have left as garbage.
			collectgarbage("collect"); collectgarbage("collect")
			collectgarbage("stop")
			local base = collectgarbage("count")
			for i = 1, #defs do assert(Polestar.Guides.Validate(defs[i]) == nil) end
			local allocated = collectgarbage("count") - base
			collectgarbage("restart")
			emit({ kib = allocated, guides = #defs, goals = goals })
		"#
		.into(),
		..Default::default()
	});
	let m = &out[0];
	let guides = m["guides"].as_f64().unwrap_or(0.0);
	let goals = m["goals"].as_f64().unwrap_or(0.0);
	let kib = m["kib"].as_f64().unwrap_or(0.0);
	assert!(guides > 200.0, "only {} guides registered", m["guides"]);
	assert!(goals > 10000.0, "only {} goals", m["goals"]);
	let per_goal = kib / goals;
	assert!(per_goal <= MAX_VALIDATE_KIB_PER_GOAL, "{per_goal:.3} KiB per goal over the {MAX_VALIDATE_KIB_PER_GOAL} KiB budget");
	println!("guides pack: validating {} goals allocates {:.2} MiB, {per_goal:.3} KiB per goal under Lua 5.1 (in-process)", m["goals"], kib / 1024.0);
}
