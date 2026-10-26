//! What Polestar's own guide pack costs in memory (issues #60, #693): addon/Polestar_Guides loaded the way the
//! client loads it, with Polestar reading it (Core/Guides.lua) for one Alliance (Human) and one Horde (Orc)
//! character, under Lua 5.1 as the client counts it (collectgarbage("count")). The pack is format 8
//! (docs/PACK_FORMAT.md, "Format 8"): each faction's guides in a load-on-demand part
//! (Polestar_Guides_Alliance, _Horde) of which only the player's faction's loads, and a goal's spawn spots as
//! one string, built into tables on the goal's first read of `spots`. Each figure fails the test when it grows
//! past its budget: lower a budget when a change lowers the figure, never raise one to make a change pass.
//!
//!   resident      after loading the pack (and the part it loads) and two full collects
//!   peak          the heap grown while loading them, with the collector stopped
//!   read          after reading every registered goal's spots once and two full collects: the most a
//!                 session can build (a session builds only the spots of the goals it shows)
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
const BUDGET: [(&str, &str, [(&str, f64); 3]); 2] =
	[("Alliance", "Human", [("resident", 10950.0), ("peak", 23000.0), ("read", 16500.0)]), ("Horde", "Orc", [("resident", 10700.0), ("peak", 22550.0), ("read", 16800.0)])];

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
for _, h in ipairs(G.List()) do
	guides = guides + 1
	if h.faction and h.faction ~= {faction} then other = other + 1 end
	for _, step in ipairs(G.Get(h.id).steps) do
		for _, goal in ipairs(step.goals) do if goal.spots then spots = spots + #goal.spots end end
	end
end
local read = full() - base
emit({{ resident = resident, peak = peak, read = read, guides = guides, other = other, spots = spots,
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

// The other faction's guides come in when the player asks for them (the guide menu's faction filter,
// Guides.LoadFaction), and a saved tab of one brings them in at login.
#[test]
fn the_other_faction_s_part_loads_when_asked_for_or_when_a_saved_tab_needs_it() {
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
	let asked = run(
		"nil",
		r#"local G = Polestar.Guides
local before = G.Get("forever/alliance/02-westfall") ~= nil
local fired = 0
Polestar.On("GUIDES_REGISTERED", function() fired = fired + 1 end)
local came = G.LoadFaction("Alliance")
emit({ before = before, came = came, after = G.Get("forever/alliance/02-westfall") ~= nil, fired = fired,
	again = G.LoadFaction("Alliance"), loads = stub.packLoads.Polestar_Guides_Alliance })"#,
	);
	assert_eq!(asked[0], serde_json::json!({ "before": false, "came": true, "after": true, "fired": 1, "again": false, "loads": 1 }));
	let saved = run(
		r#"{ schema = 1, tabs = { "forever/alliance/02-westfall" }, activeTab = 1 }"#,
		r#"emit({ loads = stub.packLoads.Polestar_Guides_Alliance or 0, guide = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false })"#,
	);
	assert_eq!(saved[0], serde_json::json!({ "loads": 1, "guide": "forever/alliance/02-westfall" }), "the saved tab of an Alliance guide comes back on a Horde character");
}

// Baked legs in Polestar's own pack (formats 7 and 8): an Alliance zone guide ships in the faction part and
// its legs in each Alliance race's part, here one with Legs.lua alone. The faction part loads before the
// race part, so Polestar.RegisterLegs finds the guide registered and keeps its legs.
#[test]
fn the_faction_part_loads_before_a_race_part_holding_only_legs_whose_legs_are_kept() {
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
	assert_eq!(pack.text("../Polestar_Guides_Human/Polestar_Guides_Human.toc").rsplit("\n\n").next(), Some("Legs.lua\n"));
	let lua_list = |files: Vec<PathBuf>| files.iter().map(|f| lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", ");
	let entries = |dir: PathBuf| lua_list(forge_addontest::run::toc_entries(&dir).unwrap_or_else(|e| panic!("{e}")).iter().map(|f| dir.join(f)).collect());
	let parent = pack.dir.parent().unwrap().to_path_buf();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!(
			"stub.packs.Polestar_Guides_Alliance = {{ {} }}\nstub.packs.Polestar_Guides_Human = {{ {} }}\nlocal w = stub.world\nw.faction, w.race, w.raceName = \"Alliance\", \"Human\", \"Human\"",
			entries(parent.join("Polestar_Guides_Alliance")),
			entries(parent.join("Polestar_Guides_Human"))
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
	alliance = stub.packLoads.Polestar_Guides_Alliance or 0, human = stub.packLoads.Polestar_Guides_Human or 0 }})"#,
			entries(pack.dir.clone())
		),
		..Default::default()
	});
	assert_eq!(out[0], serde_json::json!({ "guide": true, "leg": "CgA", "alliance": 1, "human": 1 }));
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
