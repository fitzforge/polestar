//! Completion by ID on a non-English client (docs/ARCHITECTURE.md, "Guide data"; #83). A fake frFR client
//! answers in French: the bind location, the zone and subzone texts, the flight map's node names and
//! C_Map.GetAreaInfo. The guide keeps its English names, so only the IDs can complete its steps: the
//! innkeeper's NPC ID, the area IDs (`area`) and the taxi node ID (`node`). The same guide on an English
//! client completes as before. Real Core and Nav, with the committed TravelData.lua's inns and flight masters
//! (Innkeeper Trelayne 6790 at Darkshire, area 42; node 12 "Darkshire, Duskwood"), on the stub world.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

fn addon() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml"])
}

// What each client calls the places: AreaTable areas (Duskwood 10, Elwynn Forest 12, Darkshire 42, Goldshire
// 87, Stormwind City 1519; Durotar 14, its Valley of Trials 363 and the Burning Blade Coven 365, a cave in it),
// the taxi nodes (12 Darkshire, 2 Stormwind) and two subzones without a goal.
struct Client {
	areas: &'static [(i32, &'static str)],
	nodes: &'static [(i32, &'static str)],
	grove: &'static str,
	trade: &'static str,
}

const FR_FR: Client = Client {
	areas: &[
		(10, "Bois de la Pénombre"),
		(12, "Forêt d'Elwynn"),
		(14, "Durotar"),
		(42, "Sombre-Comté"),
		(87, "Comté-de-l'Or"),
		(363, "Vallée des Épreuves"),
		(365, "Antre de la Lame ardente"),
		(1519, "Hurlevent"),
	],
	nodes: &[(2, "Hurlevent, Forêt d'Elwynn"), (12, "Sombre-Comté, Bois de la Pénombre")],
	grove: "Bosquet de Clairbois",
	trade: "Quartier commerçant",
};

const EN_US: Client = Client {
	areas: &[(10, "Duskwood"), (12, "Elwynn Forest"), (14, "Durotar"), (42, "Darkshire"), (87, "Goldshire"), (363, "Valley of Trials"), (365, "Burning Blade Coven"), (1519, "Stormwind City")],
	nodes: &[(2, "Stormwind, Elwynn"), (12, "Darkshire, Duskwood")],
	grove: "Brightwood Grove",
	trade: "Trade District",
};

fn js(s: &str) -> String {
	serde_json::to_string(s).unwrap()
}

fn lua_table(o: &[(i32, &str)]) -> String {
	format!("{{ {} }}", o.iter().map(|(k, v)| format!("[{k}] = {}", js(v))).collect::<Vec<_>>().join(", "))
}

// The client: its language, its names, a flight map that lists its nodes by ID (C_TaxiMap) as the Forever
// client does, and the player in Duskwood's Brightwood Grove, bound at Goldshire.
const CLIENT: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
function GetLocale() return "__LOCALE__" end
AREAS = __AREAS__
NODES = __NODES__
GROVE, TRADE = __GROVE__, __TRADE__
function C_Map.GetAreaInfo(id) return AREAS[id] end
local open -- node IDs of the open flight map, the current one first
function GetTaxiMapID() return open and 1415 or nil end
C_TaxiMap = {}
function C_TaxiMap.GetAllTaxiNodes()
	local out = {}
	for i, id in ipairs(open or {}) do out[i] = { nodeID = id, name = NODES[id], state = i == 1 and 0 or 1, slotIndex = i } end
	return out
end
-- The flight map at flight master npc, standing at node ids[1].
function openTaxi(npc, ids)
	open = ids
	local others = {}
	for i = 2, #ids do others[#others + 1] = NODES[ids[i]] end
	w.taxi(npc, NODES[ids[1]], others)
end
function closeTaxi() open = nil; w.close() end
w.zone, w.subzone = AREAS[10], GROVE
w.bindLocation = AREAS[87]
"#;

fn client(locale: &str) -> String {
	let c = match locale {
		"frFR" => &FR_FR,
		"enUS" => &EN_US,
		_ => panic!("no client {locale}"),
	};
	CLIENT.replace("__LOCALE__", locale).replace("__AREAS__", &lua_table(c.areas)).replace("__NODES__", &lua_table(c.nodes)).replace("__GROVE__", &js(c.grove)).replace("__TRADE__", &js(c.trade))
}

// As compile writes it for "Darkshire" (docs/GUIDE_FORMAT.md, "Places by ID").
const DARKSHIRE: &str = r#"
Polestar.RegisterGuide({ id = "test/darkshire", pack = "test", title = "Darkshire", faction = "Alliance", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "sethome", npc = 6790, npcName = "Innkeeper Trelayne", location = "Darkshire", area = 42 } } },
	{ goals = { { t = "getfp", npc = 2409, npcName = "Felicia Maline", location = "Darkshire", node = 12, area = 42 } } },
	{ goals = { { t = "fly", location = "Stormwind City", area = 1519 } } },
	{ goals = { { t = "hearth", location = "Darkshire", area = 42 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

const PRE: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#;

struct Run<'a> {
	guide: &'a str,
	id: &'a str,
	before: &'a str,
	flags: &'a str,
}

impl Default for Run<'_> {
	fn default() -> Self {
		Run { guide: DARKSHIRE, id: "test/darkshire", before: "", flags: "" }
	}
}

fn run(locale: &str, opts: Run, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: client(locale) + opts.before,
		addons: vec![addon()],
		saved: vec![("Polestar".into(), format!("PolestarCharDB = {{ schema = 1, guide = \"{}\", flags = {{ {} }} }}", opts.id, opts.flags))],
		script: [TEST_PACK, TEST_SOURCE, &(opts.guide.to_string() + PRE), script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

// Bind at Innkeeper Trelayne, learn Darkshire's flight path, fly to Stormwind, hearth back: the step after
// each.
const WALK: &str = r#"
	local w = stub.world
	local texts = {}
	for i = 1, 4 do texts[i] = E.GetStepView(i).goals[1].text end
	local trail = { E.GetStepIndex() }
	w.gossip(6790); w.bind(AREAS[42]); w.close(); flush(); trail[#trail + 1] = E.GetStepIndex()
	openTaxi(2409, { 12, 2 }); closeTaxi(); flush(); trail[#trail + 1] = E.GetStepIndex()
	w.setZone(AREAS[1519], TRADE); flush(); trail[#trail + 1] = E.GetStepIndex()
	w.setZone(AREAS[10], AREAS[42]); flush(); trail[#trail + 1] = E.GetStepIndex()
	local f = PolestarCharDB.flags
	emit({ texts = texts, trail = trail, inn = f.inn, node12 = f.taxi and f.taxi[12] or false })
"#;

#[test]
fn t_83_on_a_french_client_sethome_getfp_fly_and_hearth_complete_by_id_and_the_goals_read_in_french() {
	let out = run("frFR", Run::default(), WALK);
	assert_eq!(out["trail"], json!([1, 2, 3, 4, 5]));
	// The places as the French client names them; the verbs are the shipped French interface's, not this
	// test's business.
	let places = ["Sombre-Comté", "Sombre-Comté", "Hurlevent", "Sombre-Comté"];
	for (i, t) in out["texts"].as_array().unwrap().iter().enumerate() {
		let t = text(t);
		assert!(t.ends_with(places[i]), "{t} names {}", places[i]);
	}
	assert_eq!(out["inn"], json!({ "sombre-comté": 6790 }), "Travel learns the innkeeper of the French bind location");
	assert_eq!(out["node12"], true, "the flight map listed Darkshire by its node ID");
}

#[test]
fn the_same_guide_on_an_english_client_completes_as_before_with_or_without_c_map_getareainfo() {
	for before in ["", "C_Map.GetAreaInfo = nil"] {
		let out = run("enUS", Run { before, ..Default::default() }, WALK);
		assert_eq!(out["trail"], json!([1, 2, 3, 4, 5]), "{}", if before.is_empty() { "with GetAreaInfo" } else { before });
		assert_eq!(out["texts"], json!(["Set your home to Darkshire", "Get the flight path at Darkshire", "Fly to Stormwind City", "Hearth to Darkshire"]));
		assert_eq!(out["inn"], json!({ "darkshire": 6790 }));
	}
}

#[test]
fn t_83_bound_at_darkshire_before_the_step_a_french_client_passes_the_sethome_whether_or_not_polestar_saw_the_bind() {
	let script = r#"
		local inn = Polestar.Nav.BoundInn()
		emit({ step = E.GetStepIndex(), bound = inn and inn.npc or false })"#;
	// Polestar saw the bind: Travel learned the innkeeper then (flags.inn).
	let learned = run("frFR", Run { before: "w.bindLocation = AREAS[42]", flags: r#"inn = { ["sombre-comté"] = 6790 }"#, ..Default::default() }, script);
	assert_eq!(learned, json!({ "step": 2, "bound": 6790 }));
	// Bound before Polestar was installed: the inn whose area the client names so.
	let unseen = run("frFR", Run { before: "w.bindLocation = AREAS[42]", ..Default::default() }, script);
	assert_eq!(unseen, json!({ "step": 2, "bound": 6790 }));
	// A bind Travel paired with the wrong innkeeper (bound away from it, as a simulated bind is): the bind
	// location still reads as Darkshire's area.
	let mislearned = run("frFR", Run { before: "w.bindLocation = AREAS[42]", flags: r#"inn = { ["sombre-comté"] = 295 }"#, ..Default::default() }, script);
	assert_eq!(mislearned, json!({ "step": 2, "bound": 295 }));
}

#[test]
fn bound_at_another_inn_or_at_a_flight_master_where_darkshire_is_not_yet_known_the_french_client_keeps_the_step() {
	let out = run(
		"frFR",
		Run { flags: r#"inn = { ["comté-de-l'or"] = 295 }"#, ..Default::default() },
		r#"
			local w = stub.world
			local r = { start = E.GetStepIndex() }
			-- Binding at Innkeeper Farley (Goldshire) is not Darkshire's inn.
			w.gossip(295); w.bind(AREAS[87]); w.close(); flush()
			r.otherInn = E.GetStepIndex()
			w.gossip(6790); w.bind(AREAS[42]); w.close(); flush()
			r.bound = E.GetStepIndex()
			-- Stormwind's flight map, Darkshire not on it: its path is not known.
			openTaxi(352, { 2 }); closeTaxi(); flush()
			r.otherFp = E.GetStepIndex()
			emit(r)"#,
	);
	assert_eq!(out, json!({ "start": 1, "otherInn": 1, "bound": 2, "otherFp": 2 }));
}

#[test]
fn a_goal_the_compiler_left_without_an_id_keeps_matching_by_its_english_name_sethome_by_its_inn_hearth_and_getfp_by_name() {
	const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/names", pack = "test", title = "Names", faction = "Alliance", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "sethome", location = "Darkshire" } } },
	{ goals = { { t = "hearth", location = "Darkshire" } } },
	{ goals = { { t = "getfp", location = "Darkshire" } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;
	let script = r#"
		local w = stub.world
		local trail = { E.GetStepIndex() }
		w.bind(AREAS[42]); flush(); trail[#trail + 1] = E.GetStepIndex()
		w.setZone(AREAS[10], AREAS[42]); flush(); trail[#trail + 1] = E.GetStepIndex()
		openTaxi(2409, { 12 }); closeTaxi(); flush(); trail[#trail + 1] = E.GetStepIndex()
		emit({ trail = trail, text = E.GetStepView(2).goals[1].text })"#;
	// The inn the location names is Darkshire's, whose area the French client names "Sombre-Comté"; a hearth
	// or flight path without an ID has only its English name, which the French client never says.
	let fr = run("frFR", Run { guide: GUIDE, id: "test/names", ..Default::default() }, script);
	assert_eq!(fr["trail"], json!([1, 2, 2, 2]));
	assert!(is_match(text(&fr["text"]), r"Darkshire$"), "a goal without an area keeps its English place name");
	let en = run("enUS", Run { guide: GUIDE, id: "test/names", ..Default::default() }, script);
	assert_eq!(en, json!({ "trail": [1, 2, 3, 4], "text": "Hearth to Darkshire" }));
}

#[test]
fn the_innkeeper_a_sethome_binds_at_its_npc_else_its_location_s_inn_s_innkeeper_else_a_nearest_candidate_qol_s_bind_helper_asks_the_same() {
	let out = run(
		"enUS",
		Run::default(),
		r#"
			local I = E.IsSethomeInnkeeper
			local named = { t = "sethome", npc = 6790, location = "Darkshire" }
			local byPlace = { t = "sethome", location = "Darkshire" }
			local unknown = { t = "sethome", location = "Nowhere" }
			local nearest = { t = "sethome", candidates = { { npc = 3934 }, { npc = 6790 } } }
			emit({
				named = { I(named, 6790), I(named, 295) },
				byPlace = { I(byPlace, 6790), I(byPlace, 295) },
				unknown = I(unknown, 6790),
				nearest = { I(nearest, 6790), I(nearest, 295) },
				noNpc = I(named, nil),
				notSethome = I({ t = "talk", npc = 6790 }, 6790),
			})"#,
	);
	assert_eq!(
		out,
		json!({
			"named": [true, false], "byPlace": [true, false], "unknown": false, "nearest": [true, false], "noNpc": false, "notSethome": false,
		})
	);
}

// A goto labelled with a cave's subzone (compile gives it the area, #105) at the cave's mouth, then one
// labelled with its zone; Durotar's frame as the client places it (data/forever/map-frames.json).
const COVEN: &str = r#"
Polestar.RegisterGuide({ id = "test/coven", pack = "test", title = "Coven", faction = "Alliance", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "goto", text = "{area:365}", area = 365, map = 1411, x = 45, y = 56 } } },
	{ goals = { { t = "goto", text = "{zone:1411}", area = 14, map = 1411, x = 52, y = 44 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;
const DUROTAR: &str = r#"
w.addMap(1411, { name = "Durotar", c = 1, left = -1962.5, right = -7250, top = 1808.333, bottom = -1716.667 })
w.moveTo(1411, 44, 62)
w.zone, w.subzone = AREAS[14], AREAS[363]
-- The player at x, y in Durotar's subzone sub, indoors or not; the step after
-- the next arrival poll.
function at(x, y, sub, indoors)
	w.moveTo(1411, x, y)
	w.indoors = indoors
	stub.world.setZone(AREAS[14], sub)
	stub.advance(0.6)
	return E.GetStepIndex()
end
"#;

#[test]
fn t_177_walking_into_the_cave_a_goto_names_arrives_there_by_area_id_on_a_french_client_too_a_goto_naming_the_zone_does_not() {
	for locale in ["frFR", "enUS"] {
		let out = run(
			locale,
			Run { guide: COVEN, id: "test/coven", before: DUROTAR, ..Default::default() },
			r#"emit({
				E.GetStepIndex(),
				at(45.13, 55.75, AREAS[363], false), -- 11 yd from the mouth's point, outside
				at(45.13, 55.75, AREAS[365], true),  -- the same 11 yd, inside the Burning Blade Coven
				at(30, 30, AREAS[363], false),
				at(30, 30, AREAS[14], true),         -- a subzone text naming the zone itself
			})"#,
		);
		assert_eq!(out, json!([1, 1, 2, 2, 2]), "{locale}");
	}
}

#[test]
fn t_177_the_cave_arrives_only_on_going_in_not_in_its_subzone_outdoors_not_when_inside_as_the_goto_comes_up_not_for_a_second_goto_into_it() {
	// Its subzone outdoors, around or above the cave (Fargodeep Mine's hill).
	let outdoors = run("frFR", Run { guide: COVEN, id: "test/coven", before: DUROTAR, ..Default::default() }, "emit({ at(45.5, 57, AREAS[365], false), at(45.5, 57, AREAS[365], true) })");
	assert_eq!(outdoors, json!([1, 2]));
	// Inside the cave when the step comes up: the goto's point still leads.
	let before = format!("{DUROTAR}\nw.moveTo(1411, 44.5, 55); w.subzone, w.indoors = AREAS[365], true");
	let inside = run(
		"frFR",
		Run { guide: COVEN, id: "test/coven", before: &before, ..Default::default() },
		"emit({ at(44.5, 55, AREAS[365], true), at(44, 62, AREAS[363], false), at(44.5, 55, AREAS[365], true) })",
	);
	assert_eq!(inside, json!([1, 1, 2]));
	// A second goto of the step into the same cave is a waypoint further in.
	let two_guide = COVEN.replacen("x = 45, y = 56 } } }", r#"x = 45, y = 56 }, { t = "goto", text = "{area:365}", area = 365, map = 1411, x = 43, y = 53 } } }"#, 1);
	let two = run("frFR", Run { guide: &two_guide, id: "test/coven", before: DUROTAR, ..Default::default() }, "emit({ at(45.13, 55.75, AREAS[365], true), at(43.05, 53.05, AREAS[365], true) })");
	assert_eq!(two, json!([1, 2]));
}

#[test]
fn t_177_back_at_the_goto_after_stepping_past_it_the_player_inside_the_cave_still_walks_to_its_point_being_outside_earlier_does_not_count() {
	let out = run(
		"frFR",
		Run { guide: COVEN, id: "test/coven", before: DUROTAR, ..Default::default() },
		r#"
			local r = { at(44, 62, AREAS[363], false) } -- outside, the goto open
			E.Next(); flush(); r[#r + 1] = E.GetStepIndex()
			r[#r + 1] = at(45.13, 55.75, AREAS[365], true) -- into the cave on the next step
			E.Prev(); flush(); r[#r + 1] = E.GetStepIndex()
			r[#r + 1] = at(45.13, 55.75, AREAS[365], true) -- still inside: the goto stays
			r[#r + 1] = at(44, 62, AREAS[363], false)
			r[#r + 1] = at(45.13, 55.75, AREAS[365], true) -- out and back in
			emit(r)"#,
	);
	assert_eq!(out, json!([1, 2, 2, 1, 1, 1, 2]));
}
