//! Experimental route options (Engine "Route choice"; Core/Guides.lua, Polestar.RegisterExperimental): a guide of
//! ours whose `next` also names one of Polestar's experimental guides offers it in the route choice. Its pack loads
//! on demand and is off, so the option comes from the experimental index Polestar_Guides carries (levels to the
//! route's top, travel, quests, pitch, the guide of ours it rejoins); choosing it switches the pack on, which loads
//! it, and the route goes on there and back to ours where its last guide hands over. It is never recommended and
//! never taken by itself: with behavior.routeChoice "recommended", with only it left, in the hand-in plan and in
//! the chain's needs the route is the same as without it. Each option says where it goes on ("Then"), a detour
//! names the zone it travels through, and a shared guide goes on by the character's faction. The real compiled
//! guides' default route is the same with the offers as without them, and the experimental pack's notes say no
//! install or setting is needed. Real Core manifest, stub world; the experimental pack is a fixture addon the
//! client loads on demand (stub_packs.lua).

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack_offering};
use forge_addontest::run::{addons_dir, lua_string, root};
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use forge_guide::project::find_guide_files;
use serde_json::{json, Value};

const EXP: &str = "Polestar_Experimental";

// Eastern Kingdoms (c = 0): the Badlands, Stranglethorn Vale south-west of them, the Riverglades south of them;
// Kalimdor (c = 1): Feralas, Desolace north of it, Shen'dralas east of Desolace, Tanaris east of Feralas.
// Frames are simplified squares.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1418, { name = "Badlands", c = 0, left = 0, right = -3000, top = -3000, bottom = -6000 })
w.addMap(1434, { name = "Stranglethorn Vale", c = 0, left = 3000, right = 0, top = -9000, bottom = -12000 })
w.addMap(2548, { name = "Riverglades", c = 0, left = 0, right = -3000, top = -6000, bottom = -9000 })
w.addMap(1444, { name = "Feralas", c = 1, left = 3000, right = 0, top = -3000, bottom = -6000 })
w.addMap(1443, { name = "Desolace", c = 1, left = 3000, right = 0, top = 0, bottom = -3000 })
w.addMap(2652, { name = "Shen'dralas", c = 1, left = 0, right = -3000, top = 0, bottom = -3000 })
w.addMap(1446, { name = "Tanaris", c = 1, left = 0, right = -3000, top = -3000, bottom = -6000 })
w.addMap(1425, { name = "The Hinterlands", c = 0, left = 0, right = -3000, top = 3000, bottom = 0 })
w.race, w.raceName, w.faction, w.class = "Orc", "Orc", "Horde", "WARRIOR"
"#;

// Our guides (the test pack): the Badlands offer the Riverglades beside Stranglethorn Vale (an alternative: both
// meet again in Feralas; Stranglethorn Vale has a dungeon run); Feralas offers Shen'dralas beside Tanaris (a detour back to Tanaris). Tanaris's
// own `next` names the Alliance's guide first, as a shared guide's lines may.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/badlands", pack = "test", title = "Badlands", faction = "Horde", minLevel = 39, maxLevel = 40, zone = 1418,
	next = "test/stv", nextChoices = { "test/stv", "polestar-experimental/glades-1" }, nextWhen = STV_WHEN, steps = {
	{ goals = { { t = "accept", quest = 1, title = "Into the Badlands", map = 1418, x = 40, y = 40 }, { t = "accept", quest = 60, title = "Jungle Errand", map = 1418, x = 40, y = 40 } } },
	{ goals = { { t = "turnin", quest = 1, title = "Into the Badlands", map = 1418, x = 4, y = 45 } } },
} })
Polestar.RegisterGuide({ id = "test/stv", pack = "test", title = "Stranglethorn Vale", faction = "Horde", minLevel = 39, maxLevel = 43, zone = 1434,
	zoneName = "Stranglethorn Vale", next = "test/feralas", pitch = "Jungle camps from Grom'gol.", steps = {
	{ goals = { { t = "turnin", quest = 60, title = "Jungle Errand", map = 1434, x = 30, y = 30 } } },
	{ goals = { { t = "accept", quest = 71, title = "Jungle Hunt", map = 1434, x = 32, y = 32 } } },
	{ when = { { k = "dungeon", name = "Zul'Gurub", map = 309 } }, goals = { { t = "accept", quest = 72, title = "Into the Temple", map = 1434, x = 33, y = 33 } } },
	{ goals = { { t = "level", level = 43 } } },
} })
Polestar.RegisterGuide({ id = "test/feralas", pack = "test", title = "Feralas", faction = "Horde", minLevel = 43, maxLevel = 45, zone = 1444, steps = {
	{ goals = { { t = "level", level = 45 } } },
} })
Polestar.RegisterGuide({ id = "test/feralas3", pack = "test", title = "Feralas Again", faction = "Horde", minLevel = 45, maxLevel = 47, zone = 1444,
	next = "test/tanaris", nextChoices = { "test/tanaris", "polestar-experimental/shen" }, steps = {
	{ goals = { { t = "accept", quest = 3, title = "Camp Mojache", map = 1444, x = 75, y = 44 } } },
	{ goals = { { t = "turnin", quest = 3, title = "Camp Mojache", map = 1444, x = 75, y = 45 } } },
} })
Polestar.RegisterGuide({ id = "test/tanaris", pack = "test", title = "Tanaris", faction = "Horde", minLevel = 46, maxLevel = 48, zone = 1446,
	zoneName = "Tanaris", next = "test/alliance-feathermoon", nextChoices = { "test/alliance-feathermoon", "test/hinterlands" }, pitch = "Gadgetzan.", steps = {
	{ goals = { { t = "level", level = 48 } } },
} })
Polestar.RegisterGuide({ id = "test/hinterlands", pack = "test", title = "The Hinterlands", faction = "Horde", minLevel = 48, maxLevel = 50, zone = 1425, steps = {
	{ goals = { { t = "level", level = 50 } } },
} })
Polestar.RegisterGuide({ id = "test/alliance-feathermoon", pack = "test", title = "Feathermoon", faction = "Alliance", minLevel = 46, maxLevel = 48, zone = 1444, steps = {
	{ goals = { { t = "level", level = 48 } } },
} })
"#;

// The experimental index Polestar_Guides' Guides.lua carries (forge's experimental_index writes it): the
// Riverglades' first guide, its route to 43 rejoining at Feralas; Shen'dralas, shared by both factions,
// rejoining at the Alliance's Feathermoon or the Horde's Tanaris, in through Desolace.
const INDEX: &str = r#"
Polestar.RegisterExperimental({
	{ id = "polestar-experimental/glades-1", pack = "polestar-experimental", title = "Riverglades 1 (experimental)", faction = "Horde",
		minLevel = 37, maxLevel = 40, topLevel = 43, zone = 2548, zoneName = "Riverglades",
		pitch = "Forever's new zone south of the Badlands.", pros = { "About 70 quests" }, cons = { "Experimental: written from players' recordings" },
		questIds = { 9501, 9502, 9503 }, joins = { "test/feralas" }, start = { map = 2548, x = 50, y = 20 }, focus = { map = 2548, x = 50, y = 20 } },
	{ id = "polestar-experimental/shen", pack = "polestar-experimental", title = "Shen'dralas (experimental)",
		minLevel = 41, maxLevel = 45, topLevel = 45, zone = 2652, zoneName = "Shen'dralas", pitch = "A detour south of Desolace.",
		questIds = { 9601, 9602 }, joins = { "test/alliance-feathermoon", "test/tanaris" }, start = { map = 2652, x = 20, y = 20 },
		focus = { map = 2652, x = 20, y = 20 }, viaMap = 1443, via = "Desolace" },
})
"#;

// The experimental pack's own files: its registration and its guides, as `forge guide compile experimental`
// writes them in shape.
const EXP_PACK: &str = r#"local ADDON = ...
Polestar.RegisterPack({ addon = ADDON, id = "polestar-experimental", format = 5, title = "Polestar Experimental", author = "Polestar", version = "1.0.0", license = "GPL-3.0-only" })
"#;
const EXP_GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "polestar-experimental/glades-1", pack = "polestar-experimental", title = "Riverglades 1 (experimental)", faction = "Horde",
	minLevel = 37, maxLevel = 40, zone = 2548, zoneName = "Riverglades", next = "polestar-experimental/glades-2", pitch = "Forever's new zone south of the Badlands.", steps = {
	{ goals = { { t = "accept", quest = 9501, title = "Rog'mar", map = 2548, x = 50, y = 20 } } },
	{ goals = { { t = "turnin", quest = 9501, title = "Rog'mar", map = 2548, x = 51, y = 20 } } },
} })
Polestar.RegisterGuide({ id = "polestar-experimental/glades-2", pack = "polestar-experimental", title = "Riverglades 2 (experimental)", faction = "Horde",
	minLevel = 40, maxLevel = 43, zone = 2548, zoneName = "Riverglades", next = "test/feralas", steps = {
	{ goals = { { t = "accept", quest = 9502, title = "Sunnyglade", map = 2548, x = 40, y = 60 } } },
	{ goals = { { t = "turnin", quest = 9502, title = "Sunnyglade", map = 2548, x = 41, y = 60 } } },
} })
Polestar.RegisterGuide({ id = "polestar-experimental/shen", pack = "polestar-experimental", title = "Shen'dralas (experimental)", minLevel = 41, maxLevel = 45,
	zone = 2652, zoneName = "Shen'dralas", next = "test/alliance-feathermoon", nextChoices = { "test/alliance-feathermoon", "test/tanaris" }, steps = {
	{ goals = { { t = "accept", quest = 9601, title = "Strange Pylons", map = 2652, x = 20, y = 20 } } },
	{ goals = { { t = "turnin", quest = 9601, title = "Strange Pylons", map = 2652, x = 21, y = 20 } } },
} })
"#;

const HELPERS: &str = r#"
E, G, w = Polestar.Engine, Polestar.Guides, stub.world
GLADES, SHEN = "polestar-experimental/glades-1", "polestar-experimental/shen"
function flush() stub.advance(0.25) end
LOG = {}
for _, m in ipairs({ "ROUTE_CHOICE", "ROUTE_CHOSEN", "GUIDE_CHANGED" }) do
	Polestar.On(m, function(a, b) LOG[#LOG + 1] = m .. " " .. tostring(a) .. (b and (" " .. tostring(b)) or "") end)
end
function takeLog() local l = LOG; LOG = {}; return l end
function finish(q)
	w.accept(q, {}); flush()
	w.finish(q); w.turnIn(q); flush()
end
-- The Badlands done: Jungle Errand accepted (carried to Stranglethorn Vale), Into the Badlands handed in.
function endBadlands() w.accept(60, {}); flush(); finish(1) end
function optionIds(c)
	local out = {}
	for i, o in ipairs(c.options) do out[i] = o.id .. (o.recommended and "*" or "") .. (o.experimental and " (experimental)" or "") end
	return out
end
function option(c, id)
	for _, o in ipairs(c.options) do if o.id == id then return o end end
end
function loads() return stub.packLoads.Polestar_Experimental or 0 end
-- Forever's own quests, as Quests/NewQuestIds.lua lists them: the fixture's 9500s and 9600s.
Polestar.NewQuests = Polestar.NewQuests or {}
Polestar.NewQuests.IsNew = function(q) return q >= 9500 and q < 9700 end
"#;

/// A list's lines (an empty Lua table comes out as an object: no lines).
fn lines(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|l| l.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default()
}

/// The experimental pack written into a temp folder: its TOC, Pack.lua and Guides.lua.
fn exp_pack() -> TempDir {
	let tmp = TempDir::new("polestar-exp-");
	let dir = tmp.path().join(EXP);
	std::fs::create_dir_all(&dir).unwrap();
	std::fs::write(
		dir.join(format!("{EXP}.toc")),
		"## Interface: 16001\n## Title: Polestar Experimental\n## Author: Polestar\n## Version: 1.0.0\n## LoadOnDemand: 1\n## Dependencies: Polestar\n## X-Polestar-Pack: polestar-experimental\n## X-Polestar-Format: 5\n\nPack.lua\nGuides.lua\n",
	)
	.unwrap();
	std::fs::write(dir.join("Pack.lua"), EXP_PACK).unwrap();
	std::fs::write(dir.join("Guides.lua"), EXP_GUIDES).unwrap();
	tmp
}

/// The AddOns list: Polestar, and (when `installed`) the experimental pack, loaded only on demand: its TOC's
/// fields, and its files for stub_packs.lua, which runs them when the client is asked to load it.
fn addons(pack: &TempDir, installed: bool) -> String {
	let mut s = "stub.addonMeta.Polestar = { Version = \"1.0.0\" }\nstub.addons = { { name = \"Polestar\", loaded = true }".to_string();
	if !installed {
		return s + " }\n";
	}
	let dir = pack.path().join(EXP);
	s.push_str(&format!(", {{ name = {} , reason = \"DEMAND_LOADED\" }} }}\n", lua_string(EXP)));
	s.push_str(&format!(
		"stub.addonMeta[{n}] = {{ Title = \"Polestar Experimental\", Author = \"Polestar\", Version = \"1.0.0\", LoadOnDemand = \"1\", [\"X-Polestar-Pack\"] = \"polestar-experimental\", [\"X-Polestar-Format\"] = \"5\" }}\nstub.packs[{n}] = {{ {}, {} }}\n",
		lua_string(&dir.join("Pack.lua").to_string_lossy()),
		lua_string(&dir.join("Guides.lua").to_string_lossy()),
		n = lua_string(EXP)
	));
	s
}

/// One run: the world, the AddOns list, our guides (Stranglethorn Vale offered only `stv_when`), the index, the
/// hand-off by itself (behavior.guideEnd "continue", where these choices are made at a guide's end).
fn run(installed: bool, stv_when: &str, before: &str, script: &str) -> Value {
	let pack = exp_pack();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!("{WORLD}{}{before}", addons(&pack, installed)),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [TEST_PACK, TEST_SOURCE, &format!("STV_WHEN = {stv_when}"), GUIDES, INDEX, HELPERS, "stub.login()", r#"Polestar.Set("behavior.guideEnd", "continue")"#, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn offered_from_the_index_while_its_pack_is_off_beside_the_one_other_option() {
	let script = r#"
		w.setLevel(40); w.moveTo(1418, 4, 45)
		E.SetGuide("test/badlands"); flush(); takeLog()
		endBadlands()
		local r = { asked = takeLog(), guide = E.GetGuide().id, pending = E.PendingRouteChoice() or false, loads = loads() }
		local c = E.GetRouteChoice("test/badlands")
		if c then
			r.options, r.recommended, r.joinsAt = optionIds(c), c.recommended, c.joinsAt
			local g = option(c, GLADES) or {}
			r.glades = { title = g.title, zoneName = g.zoneName, zone = g.zone, levels = { g.minLevel, g.maxLevel }, quests = g.quests,
				pitch = g.pitch, pros = g.pros, cons = g.cons, travel = type(g.seconds) == "number", focus = { g.focusX, g.focusY },
				newInForever = g.newInForever or false, thenId = g.thenId, thenGuideTitle = g.thenGuideTitle, thenLevel = g.thenLevel,
				detour = g.detour or false }
			local s = option(c, "test/stv") or {}
			r.stv = { experimental = s.experimental or false, newInForever = s.newInForever or false, thenId = s.thenId, quests = s.quests }
		end
		r.offeredBy = E.RouteChoiceFor("test/stv") or false
		emit(r)"#;
	let out = run(true, "nil", "", script);
	// The choice is asked though only one option is ours: the window must not skip it.
	assert_eq!(out["asked"], json!(["ROUTE_CHOICE test/badlands"]), "{out}");
	assert_eq!(out["guide"], "test/badlands");
	assert_eq!(out["pending"], "test/badlands");
	assert_eq!(out["loads"], 0, "nothing of the pack loads to offer it");
	assert_eq!(out["options"], json!(["test/stv*", "polestar-experimental/glades-1 (experimental)"]));
	assert_eq!(out["recommended"], "test/stv");
	assert_eq!(out["joinsAt"], "Feralas", "both meet again in Feralas: the Riverglades' route rejoins where Stranglethorn Vale goes on");
	// The card's facts from the index: the route's levels to its top, its quests, its travel, pitch, pros and cons.
	assert_eq!(
		out["glades"],
		json!({ "title": "Riverglades 1 (experimental)", "zoneName": "Riverglades", "zone": 2548, "levels": [37, 43], "quests": 3,
			"pitch": "Forever's new zone south of the Badlands.", "pros": ["About 70 quests"], "cons": ["Experimental: written from players' recordings"],
			"travel": true, "focus": [50, 20], "newInForever": true, "thenId": "test/feralas", "thenGuideTitle": "Feralas", "thenLevel": 43,
			"detour": false })
	);
	// Its quests: Jungle Hunt, not the dungeon run's Into the Temple (the count reads the same with dungeons off).
	assert_eq!(out["stv"], json!({ "experimental": false, "newInForever": false, "thenId": "test/feralas", "quests": 1 }));
	assert_eq!(out["offeredBy"], "test/badlands", "/polestar path can offer it again from Stranglethorn Vale");

	// Not installed (or turned off in the AddOns list): nothing to offer, the route goes on as before.
	let none = run(false, "nil", "", script);
	assert_eq!(none["asked"], json!(["GUIDE_CHANGED test/stv"]), "{none}");
	assert_eq!(none["guide"], "test/stv");
	assert_eq!(none["options"], json!(["test/stv*"]), "{none}");
}

#[test]
fn choosing_it_switches_the_pack_on_loads_it_and_continues_there_in_a_fight_once_it_ends() {
	let out = run(
		true,
		"nil",
		"",
		r#"
		w.setLevel(40); w.moveTo(1418, 4, 45)
		E.SetGuide("test/badlands"); flush(); finish(1); takeLog()
		local r = { chose = E.ChooseRoute("test/badlands", GLADES) }; flush()
		r.after = { guide = E.GetGuide().id, loads = loads(), on = PolestarDB.packs["polestar-experimental"].on, saved = PolestarCharDB.routes["test/badlands"],
			log = takeLog(), pending = E.PendingRouteChoice() or false }
		emit(r)"#,
	);
	assert_eq!(out["chose"], true);
	assert_eq!(
		out["after"],
		json!({ "guide": "polestar-experimental/glades-1", "loads": 1, "on": true, "saved": "polestar-experimental/glades-1",
			"log": ["GUIDE_CHANGED polestar-experimental/glades-1", "ROUTE_CHOSEN test/badlands polestar-experimental/glades-1"], "pending": false }),
		"no install, no setting: the choice switches the pack on, loads it and opens its guide"
	);

	let fight = run(
		true,
		"nil",
		"",
		r#"
		w.setLevel(40); w.moveTo(1418, 4, 45)
		E.SetGuide("test/badlands"); flush(); finish(1); takeLog()
		stub.inCombat = true
		local r = { chose = E.ChooseRoute("test/badlands", GLADES) }; flush()
		r.during = { guide = E.GetGuide().id, loads = loads() }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED"); flush()
		r.after = { guide = E.GetGuide().id, loads = loads(), chosen = (function() for _, l in ipairs(takeLog()) do if l:find("ROUTE_CHOSEN", 1, true) then return l end end return false end)() }
		emit(r)"#,
	);
	assert_eq!(fight["chose"], true);
	assert_eq!(fight["during"], json!({ "guide": "test/badlands", "loads": 0 }), "never loaded in a fight");
	assert_eq!(fight["after"], json!({ "guide": "polestar-experimental/glades-1", "loads": 1, "chosen": "ROUTE_CHOSEN test/badlands polestar-experimental/glades-1" }));
}

#[test]
fn its_route_rejoins_ours_where_its_last_guide_hands_over() {
	let out = run(
		true,
		"nil",
		"",
		r#"
		w.setLevel(40); w.moveTo(1418, 4, 45)
		E.SetGuide("test/badlands"); flush(); finish(1)
		E.ChooseRoute("test/badlands", GLADES); flush(); takeLog()
		finish(9501)
		local second = E.GetGuide().id
		finish(9502)
		emit({ second = second, rejoined = E.GetGuide().id, log = takeLog() })"#,
	);
	assert_eq!(out["second"], "polestar-experimental/glades-2");
	assert_eq!(out["rejoined"], "test/feralas", "{out}");
}

#[test]
fn never_recommended_never_taken_by_itself_and_never_in_the_plan_until_chosen() {
	// behavior.routeChoice "recommended", the player standing at the Riverglades' start and past Stranglethorn
	// Vale's levels: the route still goes on to Stranglethorn Vale, without asking.
	let rec = run(
		true,
		"nil",
		"",
		r#"
		Polestar.Set("behavior.routeChoice", "recommended")
		w.setLevel(43); w.moveTo(2548, 50, 20)
		E.SetGuide("test/badlands"); flush()
		local c = E.GetRouteChoice("test/badlands")
		local r = { recommended = c.recommended, outleveled = option(c, "test/stv").outleveled, nearer = option(c, GLADES).seconds < option(c, "test/stv").seconds }
		takeLog(); endBadlands()
		r.log, r.guide, r.loads = takeLog(), E.GetGuide().id, loads()
		emit(r)"#,
	);
	assert_eq!(rec["recommended"], "test/stv");
	assert_eq!((rec["outleveled"].clone(), rec["nearer"].clone()), (json!(true), json!(true)));
	assert_eq!(rec["log"], json!(["GUIDE_CHANGED test/stv"]));
	assert_eq!((rec["guide"].clone(), rec["loads"].clone()), (json!("test/stv"), json!(0)));

	// Only the experimental option fits (Stranglethorn Vale only below 41): no choice, the guide ends there as it
	// did without the offer.
	let alone = run(
		true,
		r#"{ ["test/stv"] = { { k = "level", op = "<", n = 41 } } }"#,
		"",
		r#"
		w.setLevel(42); w.moveTo(1418, 4, 45)
		E.SetGuide("test/badlands"); flush(); takeLog()
		endBadlands()
		local c = E.GetRouteChoice("test/badlands")
		emit({ log = takeLog(), done = E.GetLiveStep() == nil, guide = E.GetGuide().id, pending = E.PendingRouteChoice() or false, nextGuide = E.NextGuide("test/badlands") or false,
			options = #c.options, recommended = c.recommended or false })"#,
	);
	assert_eq!(lines(&alone["log"]), Vec::<String>::new(), "{alone}");
	for (k, v) in [("done", json!(true)), ("guide", json!("test/badlands")), ("pending", json!(false)), ("nextGuide", json!(false)), ("options", json!(1)), ("recommended", json!(false))] {
		assert_eq!(alone[k], v, "{k}: {alone}");
	}

	// The hand-in plan follows the route without the offer: Jungle Errand is handed in later, in Stranglethorn
	// Vale; once the Riverglades are chosen and in, the plan follows them.
	let plan = run(
		true,
		"nil",
		"",
		r#"
		w.setLevel(40); w.moveTo(1418, 40, 40)
		E.SetGuide("test/badlands"); flush()
		w.accept(60, {}); flush()
		local t = Polestar.RoutePlan.GetTurnIn(60)
		local r = { before = { status = t.status, guide = t.guide or false } }
		finish(1); E.ChooseRoute("test/badlands", GLADES); flush()
		t = Polestar.RoutePlan.GetTurnIn(60)
		r.chosen = { status = t.status, guide = t.guide or false }
		emit(r)"#,
	);
	assert_eq!(plan["before"], json!({ "status": "later", "guide": "test/stv" }), "{plan}");
	assert_eq!(plan["chosen"]["status"], "unplanned", "{plan}");
}

#[test]
fn a_detour_names_the_zone_it_goes_through_each_card_says_where_it_goes_on_and_a_shared_guide_goes_on_by_faction() {
	let script = r#"
		w.setLevel(46); w.moveTo(HERE, 75, 44)
		E.SetGuide("test/feralas3"); flush(); takeLog()
		finish(3)
		local c = E.GetRouteChoice("test/feralas3")
		local r = { asked = takeLog(), options = optionIds(c), joinsAt = c.joinsAt or false }
		for _, o in ipairs(c.options) do
			r[o.id] = { thenId = o.thenId or false, thenGuideTitle = o.thenGuideTitle or false, thenLevel = o.thenLevel or false, detour = o.detour or false }
		end
		emit(r)"#;
	let feralas = run(true, "nil", "HERE = 1444", script);
	assert_eq!(feralas["asked"], json!(["ROUTE_CHOICE test/feralas3"]));
	assert_eq!(feralas["options"], json!(["test/tanaris*", "polestar-experimental/shen (experimental)"]));
	assert_eq!(feralas["joinsAt"], false, "a detour comes back to the other option: no one guide to meet again in");
	// Tanaris goes on to the Hinterlands, not the Alliance's guide its first `next` line names.
	assert_eq!(feralas["test/tanaris"], json!({ "thenId": "test/hinterlands", "thenGuideTitle": "The Hinterlands", "thenLevel": 48, "detour": false }));
	// Shen'dralas comes back to Tanaris (the Horde's rejoin, not the Alliance's), through Desolace.
	assert_eq!(feralas["polestar-experimental/shen"], json!({ "thenId": "test/tanaris", "thenGuideTitle": "Tanaris", "thenLevel": 45, "detour": "Desolace" }));
	// Standing in Desolace already, the way in is no detour through it.
	let desolace = run(true, "nil", "HERE = 1443", script);
	assert_eq!(desolace["polestar-experimental/shen"]["detour"], false);
}

/// Our guides (guides/) compiled with the reference data, with their experimental `next` lines (and the index of
/// the experimental guides they offer, from experimental/) or with those lines taken out, built into a pack
/// folder as `forge guide compile` builds Polestar_Guides.
fn our_route(data: &forge_guide::data::Data, offers: bool) -> forge_addontest::dsl::TestPack {
	let dir = root().join("guides");
	let texts: Vec<(String, String)> = find_guide_files(&dir, false)
		.iter()
		.map(|f| {
			let text = std::fs::read_to_string(dir.join(f)).unwrap();
			let text = if offers { text } else { text.split_inclusive('\n').filter(|l| !l.starts_with("next polestar-experimental/")).collect() };
			(format!("guides/{f}"), text)
		})
		.collect();
	let sources: Vec<(&str, &str)> = texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let compiled = compile_with(&sources, data, None);
	assert_eq!(compiled.errors, Vec::<String>::new());
	let index = if offers {
		let mut diag = forge_guide::diag::Diagnostics::new();
		let index = forge_guide::project::experimental_index(&compiled.guides, &forge_guide::project::read_extras(root(), data), data, &mut diag);
		assert!(!diag.has_errors(), "{:?}", diag.sorted());
		index
	} else {
		Vec::new()
	};
	write_test_pack_offering(&compiled.guides, data, &our_manifest(), &index)
}

/// The AddOns-list lines of the checkout's experimental pack (addon/Polestar_Experimental), loaded on demand: the
/// route choices may offer its guides from the index.
fn exp_installed() -> String {
	let toc = std::fs::read_to_string(addons_dir().join(EXP).join(format!("{EXP}.toc"))).unwrap();
	let meta: Vec<String> = toc.lines().filter_map(|l| l.strip_prefix("## ")?.split_once(':')).map(|(k, v)| format!("[{}] = {}", lua_string(k.trim()), lua_string(v.trim()))).collect();
	format!(
		"stub.addonMeta.Polestar = {{ Version = \"1.0.0\" }}\nstub.addons = {{ {{ name = \"Polestar\", loaded = true }}, {{ name = {n}, reason = \"DEMAND_LOADED\" }} }}\nstub.addonMeta[{n}] = {{ {} }}\n",
		meta.join(", "),
		n = lua_string(EXP)
	)
}

/// For a character of `race` (faction `faction`) and the pack built in `pack`: for every leveling guide they fit,
/// where the route goes on (Engine.NextGuide) with behavior.routeChoice "recommended", and whether Skip grey
/// quests may leave quest 1 out at 60 (Engine.GreyLeftOut: false while a guide down the chain is not known); the
/// guides whose route choice asks with "ask"; and the experimental offers of their `next` lines.
fn route_of(pack: &forge_addontest::dsl::TestPack, race: &str, faction: &str) -> Value {
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", lua_string(&f.to_string_lossy()))).collect();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{}stub.world.race, stub.world.raceName, stub.world.faction = {r}, {r}, {}", exp_installed(), lua_string(faction), r = lua_string(race)),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			r#"
			do local ns = {{}}
			{}
			end
			stub.login()
			local E, G = Polestar.Engine, Polestar.Guides
			Polestar.Set("behavior.skipGrey", true)
			local player = Polestar.Compat.GetPlayerInfo()
			local out = {{ route = {{}}, asks = {{}}, offers = {{}} }}
			local list = {{}}
			for _, h in ipairs(G.List()) do
				local g = G.Get(h.id)
				if g and (g.category == nil or g.category == "Leveling") and G.GuideMatches(g, player) then list[#list + 1] = g end
			end
			Polestar.Set("behavior.routeChoice", "ask")
			for _, g in ipairs(list) do
				local c = E.GetRouteChoice(g.id)
				if c and #c.options >= 2 and not E.NextGuide(g.id) then out.asks[#out.asks + 1] = g.id end
				for _, id in ipairs(g.nextChoices or {{}}) do
					if G.ExperimentalOffer(g, id) then out.offers[#out.offers + 1] = g.id .. " -> " .. id end
				end
			end
			table.sort(out.asks); table.sort(out.offers)
			Polestar.Set("behavior.routeChoice", "recommended")
			for _, g in ipairs(list) do out.route[g.id] = (E.NextGuide(g.id) or "-") .. " / " .. tostring(E.GreyLeftOut(g.id, 1, 60)) end
			emit(out)"#,
			loads.join("\n\t\t\t")
		),
		..Default::default()
	})
	.remove(0)
}

// The whole route compiled both ways, with the experimental `next` lines and without them: the files are the same
// but for the offering guides' `nextChoices` lines and the index after Polestar_Guides' guides; loaded by the
// addon, the default route (behavior.routeChoice "recommended": every guide's next guide, and the chain Skip grey
// quests reads) is the same for both factions, and with "ask" the offering guides ask at their end.
#[test]
fn the_real_route_compiled_with_the_offers_and_without_them_has_the_same_default_route() {
	forge_addontest::needs!("quests.json", "npcs.json", "objects.json", "items.json", "map-frames.json");
	let data = forge_guide::data::load_data(&root().join("data/forever")).expect("data/forever");
	let with = our_route(&data, true);
	let without = our_route(&data, false);
	// The files: the same but for the offers.
	let text = |p: &forge_addontest::dsl::TestPack, name: &str| match p.files.iter().find(|(n, _)| n == name) {
		Some((_, forge_guide::project::FileContent::Text(t))) => t.clone(),
		_ => String::new(),
	};
	let names: Vec<String> = with.files.iter().map(|(n, _)| n.clone()).collect();
	assert_eq!(names, without.files.iter().map(|(n, _)| n.clone()).collect::<Vec<_>>());
	let mut offered: Vec<String> = Vec::new();
	for name in &names {
		let (a, b) = (text(&with, name), text(&without, name));
		if a == b {
			continue;
		}
		let b_lines: Vec<&str> = b.lines().collect();
		let a_lines: Vec<&str> = a.lines().collect();
		assert!(b_lines.iter().all(|l| a_lines.contains(l)), "{name}: nothing of the route without the offers goes");
		if name == "Guides.lua" {
			assert!(a.starts_with(b.as_str()) && a[b.len()..].starts_with("\nPolestar.RegisterExperimental({\n"), "{name}: only the index, after the guides");
		} else if name == "MapFrames.lua" {
			assert!(a_lines.iter().filter(|l| !b_lines.contains(l)).all(|l| l.starts_with("\t\t[")), "{name}: only the frames of the index's points");
		} else {
			for l in a_lines.iter().filter(|l| !b_lines.contains(l)) {
				assert!(l.starts_with("\t\t\tnextChoices = { ") && l.contains("\"polestar-experimental/"), "{name}: only the offering guides' route choices, not {l}");
				offered.push(l.to_string());
			}
		}
	}
	assert_eq!(offered.len(), 3, "the three offers: {offered:?}");
	for (race, faction, offers) in [
		("Orc", "Horde", json!(["forever/horde/30-40/06-badlands -> polestar-experimental/riverglades-horde-1", "forever/horde/40-50/03-feralas -> polestar-experimental/shendralas"])),
		("Human", "Alliance", json!(["forever/alliance/50-60/04-western-plaguelands -> polestar-experimental/hyjal-1"])),
	] {
		let (a, b) = (route_of(&with, race, faction), route_of(&without, race, faction));
		assert!(a["route"].as_object().unwrap().len() > 20, "{race}: the guides are in");
		assert_eq!(a["offers"], offers, "{race}: the route choices that offer an experimental guide");
		assert_eq!(lines(&b["offers"]), Vec::<String>::new());
		assert_eq!(a["route"], b["route"], "{race}: the default route is the same without the offers");
		// With "ask" (the default) the offering guides ask at their end, and no other guide asks anew.
		let mut asks = lines(&b["asks"]);
		asks.extend(lines(&offers).iter().map(|o| o.split(" -> ").next().unwrap().to_string()));
		asks.sort();
		assert_eq!(lines(&a["asks"]), asks, "{race}: the choices asked with \"ask\"");
	}
}

// What players read about the experimental pack outside the game's route choice: its AddOns-list notes (the TOC,
// in English, from experimental/pack.json) say it loads when they pick one of its zones where a guide offers it,
// so there is nothing to install or switch on first.
#[test]
fn the_experimental_pack_says_no_install_or_setting_is_needed() {
	let pack: Value = serde_json::from_str(&std::fs::read_to_string(root().join("experimental/pack.json")).unwrap()).unwrap();
	let notes = pack["notes"].as_str().unwrap();
	assert!(notes.contains("Loads when you pick one of its zones where a guide offers it"), "{notes}");
	let toc = std::fs::read_to_string(addons_dir().join(EXP).join(format!("{EXP}.toc"))).unwrap();
	assert!(toc.lines().any(|l| l == format!("## Notes: {notes}")), "addon/{EXP} carries experimental/pack.json's notes: rebuild it with `forge guide compile experimental`");
}
