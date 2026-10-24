//! "Pick up the quests" for a dungeon (addon/Polestar/Dungeons/Pickup.lua over Lookup's guide machinery):
//! which of a page's quests this character can take before the run, their open prerequisites first, the
//! givers on a travel route from where the player stands, the entrance last; the guide opens in a new tab,
//! comes back after /reload, and plays to the end in the real engine. Each quest's giver link points at the
//! first prerequisite still to do.
//!
//! The Codex and the page are the synthetic tests/fixtures/codex/dungeon-pickup.json: Shadowfang Keep
//! (levels 22-30) for a Horde character with
//!   1098 Deathstalkers in Shadowfang   Hadrec, Silverpine (done in most runs)
//!   1740 The Orb of Soran'ruk          Doan Karhan, The Barrens, Warlock only
//!   1013 The Book of Ur                Keeper Bel'dugur, Undercity (in the log)
//!   1014 Arugal Must Die               Dalar, Silverpine, after 1011, which needs one
//!                                      of 1009 (Alliance) or 1010 (Bethor Iceshard,
//!                                      Undercity, turned in to Renferrel, Silverpine)
//!   1016 Return to Dalar               a follow-up of 1014: taken after the run
//!   1999 Wolves at the Wall            Tauren only
//!   1806 The Test of Righteousness     Alliance Paladin

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::dsl::plain;
use forge_addontest::playtest::SIMULATE;
use forge_addontest::{emitted, lua_value, text, truthy, Addon, RunAddon};
use forge_data::codex::client::{Corpse, InstanceMap};
use forge_data::codex::journal::{build_journal, emit_journal, Codex, JournalInputs};
use forge_guide::js::V;
use serde_json::{json, Value};

const KEY: &str = "shadowfang-keep";
const GID: &str = "lookup/pickup/shadowfang-keep";
const UNDERCITY: [i32; 3] = [1458, 66, 44];
const BARRENS: [i32; 3] = [1413, 50, 57];

/// The fixture's codex and journal inputs.
fn fixture_parts() -> (Value, Value) {
	let f = fixture("dungeon-pickup.json");
	(f["codex"].clone(), f["inputs"].clone())
}

fn to_v(v: &Value) -> V {
	forge_guide::js::parse_json(&v.to_string()).unwrap()
}

/// `v[k]` as V, an empty object when absent.
fn part(v: &Value, k: &str) -> V {
	if v[k].is_null() {
		V::obj()
	} else {
		to_v(&v[k])
	}
}

/// The first of `paths` present in `v` (null when none is).
fn pick(v: &Value, paths: &[&[&str]]) -> Value {
	for p in paths {
		let mut x = v;
		for k in *p {
			x = &x[*k];
		}
		if !x.is_null() {
			return x.clone();
		}
	}
	Value::Null
}

fn instance_map(m: &Value) -> InstanceMap {
	let nums = |k: &str| m[k].as_array().map(|a| a.iter().filter_map(Value::as_f64).collect()).unwrap_or_default();
	InstanceMap {
		id: m["id"].as_f64().unwrap_or(0.0),
		name: text(&m["name"]).to_string(),
		raid: m["raid"].as_bool().unwrap_or(false),
		players: m["players"].as_f64(),
		area: m["area"].as_f64(),
		areas: nums("areas"),
		inner: nums("inner"),
		zones: nums("zones"),
		corpse: m["corpse"].is_object().then(|| Corpse { c: m["corpse"]["c"].as_f64().unwrap_or(0.0), x: m["corpse"]["x"].as_f64().unwrap_or(0.0), y: m["corpse"]["y"].as_f64().unwrap_or(0.0) }),
	}
}

/// `buildJournal(inputs, codex)`: the JS inputs object (maps, frames, forever.{quests, objects, zones},
/// journalQuests, attunementTable) mapped onto forge_data's JournalInputs.
fn journal_of(codex: &Value, inputs: &Value) -> V {
	let maps: Vec<InstanceMap> = pick(inputs, &[&["maps"], &["instanceMaps"], &["client", "instanceMaps"]]).as_array().map(|a| a.iter().map(instance_map).collect()).unwrap_or_default();
	let or_obj = |v: Value| if v.is_null() { V::obj() } else { to_v(&v) };
	let frames = or_obj(pick(inputs, &[&["frames"], &["mapFrames", "forever"], &["forever", "mapFrames", "forever"]]));
	let fv_quests = or_obj(pick(inputs, &[&["forever", "quests"]]));
	let fv_objects = or_obj(pick(inputs, &[&["forever", "objects"]]));
	let fv_zones = or_obj(pick(inputs, &[&["forever", "zones"]]));
	let fv_dungeons = or_obj(pick(inputs, &[&["forever", "dungeons"]]));
	let journal_quests: Vec<V> = pick(inputs, &[&["journalQuests"]]).as_array().map(|a| a.iter().map(to_v).collect()).unwrap_or_default();
	let attunement_table = or_obj(pick(inputs, &[&["attunementTable"]]));
	let codex_v = Codex {
		instances: part(codex, "instances"),
		quests: part(codex, "quests"),
		npcs: part(codex, "npcs"),
		items: part(codex, "items"),
		objects: part(codex, "objects"),
		factions: part(codex, "factions"),
		zones: part(codex, "zones"),
	};
	build_journal(
		&JournalInputs {
			maps: &maps,
			frames: &frames,
			fv_quests: &fv_quests,
			fv_objects: &fv_objects,
			fv_zones: &fv_zones,
			fv_dungeons: &fv_dungeons,
			journal_quests: &journal_quests,
			attunement_table: &attunement_table,
		},
		&codex_v,
	)
	.0
}

/// `writeCodexPack(codex, { extraFiles: emitJournal(buildJournal(inputs, codex)) })`.
fn pack_of(codex: &Value, inputs: &Value) -> CodexPack {
	write_codex_pack(codex, &CodexOpts { extra_files: vec![("Dungeons1.lua".to_string(), emit_journal(&journal_of(codex, inputs)))], ..Default::default() })
}

fn default_pack() -> CodexPack {
	let (c, i) = fixture_parts();
	pack_of(&c, &i)
}

/// A number as JS prints it.
fn js_num(v: &Value) -> String {
	match v.as_f64() {
		Some(f) if f.fract() == 0.0 && f.abs() < 1e15 => format!("{}", f as i64),
		Some(f) => format!("{f}"),
		None => v.to_string(),
	}
}

/// A value as a JS template literal prints it.
fn js(v: &Value) -> String {
	v.as_str().map_or_else(|| v.to_string(), str::to_string)
}

// The stub world draws the fixture's maps with the bounds of their Era frames.
fn maps_lua(codex: &Value) -> String {
	codex["frames"]
		.as_object()
		.unwrap()
		.iter()
		.map(|(id, f)| {
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&codex["zones"][id.as_str()]["name"]).unwrap(),
				js_num(&f["c"]),
				js_num(&f["left"]),
				js_num(&f["right"]),
				js_num(&f["top"]),
				js_num(&f["bottom"])
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

// The guide's steps as { title, goals: "verb:quest ..." }.
const DESCRIBE: &str = r#"
local function describe(g)
	local out = {}
	for i, s in ipairs(g and g.steps or {}) do
		local verbs = {}
		for j, goal in ipairs(s.goals) do verbs[j] = goal.t .. (goal.quest and (":" .. goal.quest) or "") end
		out[i] = { title = s.title, goals = table.concat(verbs, " ") }
	end
	return out
end
local function tabIds()
	local ids = {}
	for i, t in ipairs(Polestar.Engine.GetTabs()) do ids[i] = t.guideId end
	return ids
end
"#;

struct Opts {
	level: i32,
	race: &'static str,
	faction: &'static str,
	cls: &'static str,
	at: Option<[i32; 3]>,
	done: Vec<i32>,
	log: Vec<i32>,
	ready: Vec<i32>,
	saved: Option<String>,
}

impl Default for Opts {
	fn default() -> Self {
		Opts { level: 21, race: "Scourge", faction: "Horde", cls: "WARLOCK", at: Some(UNDERCITY), done: vec![1098], log: vec![1013], ready: vec![], saved: None }
	}
}

fn run(pack: &CodexPack, script: &str, o: Opts) -> Vec<Value> {
	let (codex, _) = fixture_parts();
	let race = serde_json::to_string(o.race).unwrap();
	let faction = serde_json::to_string(o.faction).unwrap();
	let cls = serde_json::to_string(o.cls).unwrap();
	let at = o.at.map(|a| format!("w.moveTo({}, {}, {})", a[0], a[1], a[2])).unwrap_or_default();
	let before = format!(
		"{stub}\nlocal w = stub.world\n{maps}\nw.level, w.race, w.raceName, w.faction = {level}, {race}, {race}, {faction}\nw.class, w.className = {cls}, {cls}\n{at}\nw.complete({done})\nfor _, q in ipairs({log}) do w.onQuest(q, {{ 1 }}) end\nfor _, q in ipairs({ready}) do w.onQuest(q, {{}}) end",
		stub = pack.stub_lua,
		maps = maps_lua(&codex),
		level = o.level,
		done = lua_value(&json!(o.done)),
		log = lua_value(&json!(o.log)),
		ready = lua_value(&json!(o.ready)),
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before,
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml"])],
		saved: o.saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		login: true,
		script: format!("{DESCRIBE}\nlocal D = Polestar.Dungeons\n{script}"),
	})
}

/// The Lua with {KEY} and {GID} filled in.
fn k(s: &str) -> String {
	s.replace("{KEY}", KEY).replace("{GID}", GID)
}

// From the Undercity: Bethor's errand there, on to Renferrel and Dalar in Silverpine (the chain in its order,
// Dalar's quest once it is behind), then the Barrens for the Warlock's quest, the entrance last with the quest
// already in the log listed, and the way to the hand-in guide after the run.
fn from_undercity() -> Vec<Value> {
	vec![
		json!({ "title": "Orders from the Undercity", "goals": "accept:1010 turnin:1010" }),
		json!({ "title": "The Dalaran Inquiry", "goals": "accept:1011 turnin:1011" }),
		json!({ "title": "Dalar Dawnweaver", "goals": "accept:1014" }),
		json!({ "title": "Doan Karhan", "goals": "accept:1740" }),
		json!({ "title": "Shadowfang Keep", "goals": "note goto note" }),
	]
}

fn barrens_first() -> Value {
	let f = from_undercity();
	json!([f[3], f[0], f[1], f[2], f[4]])
}

#[test]
fn a_horde_warlock_the_quests_that_apply_open_prerequisites_first_in_chain_order_the_givers_on_a_route_from_the_undercity_the_entrance_last() {
	let pack = default_pack();
	let out = &run(
		&pack,
		&k(r#"
local plan = D.PickupPlan("{KEY}")
local take, carried = {}, {}
for i, t in ipairs(plan.take) do take[i] = t.quest.id end
for i, q in ipairs(plan.carried) do carried[i] = q.id end
local def = D.PickupGuide("{KEY}")
local last = def.steps[#def.steps]
emit({ take = take, carried = carried, title = def.title, steps = describe(def), note = last.goals[1].text,
	entrance = { last.goals[2].map, last.goals[2].x, last.goals[2].y, last.goals[2].text }, after = last.goals[3].text })"#),
		Opts::default(),
	)[0];
	assert_eq!(out["take"], json!([1740, 1014]), "not done 1098, Tauren-only 1999, Alliance 1806, follow-up 1016, carried 1013");
	assert_eq!(out["carried"], json!([1013]));
	assert_eq!(out["title"], "Shadowfang Keep: pick up the quests");
	assert_eq!(out["steps"], json!(from_undercity()));
	assert_eq!(out["note"], "In your log already: The Book of Ur");
	assert_eq!(out["entrance"], json!([1421, 44.8, 67.8, "Enter Shadowfang Keep"]));
	assert_eq!(out["after"], "After the run: open this dungeon's page (/polestar dungeons Shadowfang Keep) and choose Hand in the quests.");
}

#[test]
fn the_route_starts_where_the_player_stands_another_class_gets_no_class_quest() {
	let pack = default_pack();
	let script = k(r#"emit(describe(D.PickupGuide("{KEY}")))"#);
	let barrens = run(&pack, &script, Opts { at: Some(BARRENS), ..Default::default() }).remove(0);
	assert_eq!(barrens, barrens_first(), "Doan Karhan first from the Barrens");
	let mage = run(&pack, &script, Opts { cls: "MAGE", ..Default::default() }).remove(0);
	let f = from_undercity();
	assert_eq!(mage, json!([f[0], f[1], f[2], f[4]]));
}

#[test]
fn a_quest_several_npcs_of_both_sides_give_tabetha_s_task_the_character_s_side_s_giver_nearest_the_player_never_the_other_side_s_though_the_page_names_the_first() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	let npc = |id: i32, name: &str, faction: &str, map: i32, x: i32, y: i32| json!({ "id": id, "name": name, "level": 50, "levelMax": null, "faction": faction, "rare": false, "elite": false, "boss": false, "instance": null, "roles": [], "spawns": [{ "map": map, "x": x, "y": y, "f": "e" }] });
	c["npcs"]["9001"] = npc(9001, "Anastasia Hartwell", "H", 1458, 70, 40);
	c["npcs"]["9002"] = npc(9002, "Barrens Trainer", "A", 1413, 60, 30);
	c["npcs"]["9003"] = npc(9003, "Silverpine Trainer", "A", 1421, 60, 60);
	let quest = |id: i32, title: &str, givers: &[i32]| {
		json!({
			"id": id, "title": title, "level": 25, "minLevel": 18, "faction": null, "races": null, "classes": null,
			"start": { "npc": givers, "object": [], "item": [] }, "end": { "npc": givers, "object": [] },
			"objectives": [], "pre": [], "zone": 1421, "rewards": [], "choices": [], "preAny": [],
		})
	};
	c["quests"]["90200"] = quest(90200, "Tabetha's Task", &[9001, 9002, 9003]);
	c["quests"]["90201"] = quest(90201, "Alliance Errand", &[9002]);
	i["forever"]["quests"]["90200"] = json!({ "area": 209 });
	i["forever"]["quests"]["90201"] = json!({ "area": 209 });
	let journal = plain(&journal_of(&c, &i));
	let page = journal["dungeons"][KEY]["quests"].as_array().unwrap().iter().find(|q| q["id"] == 90200).unwrap().clone();
	assert_eq!(page["start"]["name"], "Anastasia Hartwell", "the page keeps the first giver");
	let own = pack_of(&c, &i);
	let script = k(r#"
local plan = D.PickupPlan("{KEY}")
local g = {}
for _, t in ipairs(plan.take) do if t.quest.id >= 90200 then g[#g + 1] = t.quest.id .. ":" .. t.giver.name end end
local p = D.GiverTarget("{KEY}", 90200)
emit({ take = g, target = p and p.name or false })"#);
	let human = || Opts { race: "Human", faction: "Alliance", cls: "MAGE", ..Default::default() };
	let barrens = run(&own, &script, Opts { at: Some(BARRENS), ..human() }).remove(0);
	assert_eq!(barrens, json!({ "take": ["90200:Barrens Trainer", "90201:Barrens Trainer"], "target": "Barrens Trainer" }));
	let silverpine = run(&own, &script, Opts { at: Some([1421, 50, 50]), ..human() }).remove(0);
	assert_eq!(silverpine["take"], json!(["90200:Silverpine Trainer", "90201:Barrens Trainer"]), "the nearest of its side");
	let horde = run(&own, &script, Opts { cls: "MAGE", at: Some(BARRENS), ..Default::default() }).remove(0);
	assert_eq!(horde, json!({ "take": ["90200:Anastasia Hartwell"], "target": "Anastasia Hartwell" }), "the Alliance trainer next door is not for the Horde, nor a quest only an Alliance NPC gives");
}

#[test]
fn pickup_opens_the_guide_in_a_new_tab_and_it_plays_to_the_end_the_giver_link_points_at_the_first_prerequisite_still_to_do() {
	let pack = default_pack();
	let script = k(r#"
Polestar.Set("behavior.autoNextGuide", false)
local before = #Polestar.Engine.GetTabs()
local function target(id)
	local p, label, first, turnIn = D.GiverTarget("{KEY}", id)
	return { p and p.map or false, label or false, first or false, turnIn or false }
end
local links = { arugal = target(1014), orb = target(1740) }
local id, why = D.PickUp("{KEY}")
emit({ id = id or false, why = why or false, tabs = tabIds(), before = before, active = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false })
stub.world.accept(1010, { 1 })
links.arugalAfter = target(1014)
stub.world.abandon(1010)
emit(links)
stub.advance(0.6)
{SIMULATE}"#)
	.replace("{SIMULATE}", SIMULATE);
	let r = run(&pack, &script, Opts::default());
	let (opened, links, out) = (&r[0], &r[1], &r[2]);
	assert_eq!(opened["id"], GID, "built ({})", js(&opened["why"]));
	assert_eq!(opened["active"], GID);
	assert_eq!(links["arugal"], json!([1458, "Bethor Iceshard", "Orders from the Undercity", false]), "Arugal Must Die: Bethor's errand comes first");
	assert_eq!(links["arugalAfter"], json!([1421, "Apothecary Renferrel", "Orders from the Undercity", true]), "in the log: where it is turned in");
	assert_eq!(links["orb"], json!([1413, "Doan Karhan", false, false]), "no prerequisite: the giver");
	assert!(!truthy(&out["stuck"]), "stuck: {}", out["stuck"]);
	assert_eq!(out["done"], true);
	assert_eq!(out["missing"], json!({}), "every accept and turn-in has a location");
	assert_eq!(out["visited"], from_undercity().len() as i32);
	let tabs = opened["tabs"].as_array().unwrap();
	assert_eq!(json!([tabs.len(), tabs[tabs.len() - 1]]), json!([opened["before"].as_i64().unwrap() + 1, GID]), "in a new tab of its own");
}

#[test]
fn the_tab_survives_reload_rebuilt_before_the_engine_reopens_it_in_the_same_route_without_a_position() {
	let pack = default_pack();
	let first = run(
		&pack,
		&k(r#"
D.PickUp("{KEY}")
local s = Polestar.CharState()
emit({ tabs = s.tabs, order = s.dungeonPickup and s.dungeonPickup["{KEY}"] or false, steps = describe(Polestar.Guides.Get("{GID}")) })"#),
		Opts::default(),
	)
	.remove(0);
	assert!(first["order"].as_array().is_some_and(|a| !a.is_empty()), "the route is kept");
	let saved = format!(
		"PolestarCharDB = {{ schema = 1, tabs = {}, activeTab = {}, dungeonPickup = {{ [{}] = {} }} }}",
		lua_value(&first["tabs"]),
		first["tabs"].as_array().unwrap().len(),
		serde_json::to_string(KEY).unwrap(),
		lua_value(&first["order"])
	);
	let after = run(
		&pack,
		&k(r#"emit({ tabs = tabIds(), active = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false, steps = describe(Polestar.Guides.Get("{GID}")) })"#),
		Opts { at: None, saved: Some(saved), ..Default::default() },
	)
	.remove(0);
	assert_eq!(after["tabs"], first["tabs"]);
	assert_eq!(after["active"], GID);
	assert_eq!(after["steps"], first["steps"]);
	assert_eq!(after["steps"], json!(from_undercity()));
}

#[test]
fn nothing_left_to_pick_up_pickup_says_so_and_builds_no_guide() {
	let pack = default_pack();
	let out = run(
		&pack,
		&k(r#"
local before = tabIds()
local id, why = D.PickUp("{KEY}")
emit({ id = id or false, why = why or false, guide = Polestar.Guides.Get("{GID}") ~= nil, same = #tabIds() == #before, carried = #D.PickupPlan("{KEY}").carried })"#),
		Opts { done: vec![1098, 1740, 1014, 1016], log: vec![1013], ..Default::default() },
	)
	.remove(0);
	assert_eq!(out, json!({ "id": false, "why": "nothing", "guide": false, "same": true, "carried": 1 }));
}

#[test]
fn a_follow_up_of_a_dungeon_quest_is_picked_up_once_that_quest_is_done() {
	let pack = default_pack();
	let out = run(&pack, &k(r#"emit(describe(D.PickupGuide("{KEY}")))"#), Opts { done: vec![1098, 1740, 1014], log: vec![1013], ..Default::default() }).remove(0);
	assert_eq!(out, json!([{ "title": "Dalar Dawnweaver", "goals": "accept:1016" }, from_undercity()[4]]));
}

#[test]
fn a_breadcrumb_is_not_picked_up_once_the_quest_it_leads_to_is_turned_in_or_in_the_log_368_rawbowke_klockmort_s_essentials_after_essential_artificials() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	let quest = |id: i32, title: &str, giver: i32| {
		json!({
			"id": id, "title": title, "level": 25, "minLevel": 18, "faction": "H", "races": null, "classes": null,
			"start": { "npc": [giver], "object": [], "item": [] }, "end": { "npc": [6247], "object": [] },
			"objectives": [], "pre": [], "zone": 1458, "rewards": [], "choices": [], "preAny": [],
		})
	};
	// Two breadcrumbs to Doan Karhan's The Orb of Soran'ruk (1740): one naming it as its breadcrumbFor, one only
	// named by 1740's own `breadcrumbs`.
	c["quests"]["90300"] = quest(90300, "Doan's Summons", 2934);
	c["quests"]["90301"] = quest(90301, "Word for Doan", 1498);
	i["forever"]["quests"]["90300"] = json!({ "area": 209, "breadcrumbFor": 1740 });
	i["forever"]["quests"]["90301"] = json!({ "area": 209 });
	i["forever"]["quests"]["1740"]["breadcrumbs"] = json!([90301]);
	let own = pack_of(&c, &i);
	let script = k(r#"
local plan = D.PickupPlan("{KEY}")
local take = {}
for k, t in ipairs(plan.take) do take[k] = t.quest.id end
table.sort(take)
local closedBy = {}
for _, s in ipairs((D.PickupGuide("{KEY}") or { steps = {} }).steps) do
	for _, g in ipairs(s.goals) do
		if g.t == "accept" and g.quest >= 90300 then closedBy[tostring(g.quest)] = table.concat(g.closedBy or {}, ",") end
	end
end
emit({ take = take, closedBy = closedBy })"#);
	let open = run(&own, &script, Opts::default()).remove(0);
	assert_eq!(open["take"], json!([1014, 1740, 90300, 90301]), "Doan's quest not taken yet: its breadcrumbs are offered");
	assert_eq!(open["closedBy"], json!({ "90300": "1740", "90301": "1740" }), "each accept knows the quest that closes it, so the Engine passes it once that is taken");
	let turned_in = run(&own, &script, Opts { done: vec![1098, 1740], ..Default::default() }).remove(0);
	assert_eq!(turned_in["take"], json!([1014]), "Doan's quest turned in: no giver offers its breadcrumbs any more");
	let carried = run(&own, &script, Opts { log: vec![1013, 1740], ..Default::default() }).remove(0);
	assert_eq!(carried["take"], json!([1014]), "Doan's quest in the log: neither");
}

fn takes(v: &Value, id: i32) -> bool {
	v["take"].as_array().into_iter().flatten().any(|x| *x == id)
}

#[test]
fn errands_on_the_page_before_a_dungeon_quest_are_done_on_the_way_519_hamuul_runetotem_and_nara_wildmane_before_leaders_of_the_fang() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	let npc = |id: i32, name: &str, map: i32, x: i32, y: i32| {
		json!({
			"id": id, "name": name, "level": 30, "levelMax": null, "faction": "H", "rare": false, "elite": false, "boss": false,
			"instance": null, "roles": [], "spawns": [{ "map": map, "x": x, "y": y, "f": "e" }],
		})
	};
	c["npcs"]["90410"] = npc(90410, "Giver One", 1421, 40, 40);
	c["npcs"]["90411"] = npc(90411, "Giver Two", 1421, 45, 45);
	c["npcs"]["90412"] = npc(90412, "Giver Three", 1421, 50, 50);
	let quest = |id: i32, title: &str, giver: i32, ender: i32, pre: &[i32], objectives: Value| {
		json!({
			"id": id, "title": title, "level": 25, "minLevel": 18, "faction": "H", "races": null, "classes": null,
			"start": { "npc": [giver], "object": [], "item": [] }, "end": { "npc": [ender], "object": [] },
			"objectives": objectives, "pre": pre, "zone": 1421, "rewards": [], "choices": [], "preAny": [],
		})
	};
	// A: off the page, with objectives, already done. B and C: errands on the page (no objectives), each turned
	// in at the next giver. D: the dungeon quest itself, with objectives, after C.
	c["quests"]["90400"] = quest(90400, "An Earlier Errand", 90410, 90410, &[], json!([{ "type": "kill", "id": 90420, "count": 1, "text": "Test Mob" }]));
	c["quests"]["90401"] = quest(90401, "Hamuul Runetotem", 90410, 90411, &[90400], json!([]));
	c["quests"]["90402"] = quest(90402, "Nara Wildmane", 90411, 90412, &[90401], json!([]));
	c["quests"]["90403"] = quest(90403, "Leaders of the Fang", 90412, 90412, &[90402], json!([{ "type": "item", "id": 90421, "count": 1, "text": "Gem of Test" }]));
	i["forever"]["quests"]["90401"] = json!({ "area": 209 });
	i["forever"]["quests"]["90402"] = json!({ "area": 209 });
	i["forever"]["quests"]["90403"] = json!({ "area": 209 });
	let own = pack_of(&c, &i);
	let script = k(r#"
local plan = D.PickupPlan("{KEY}")
local take, carried = {}, {}
for _, t in ipairs(plan.take) do if t.quest.id >= 90400 then take[#take + 1] = t.quest.id end end
for _, q in ipairs(plan.carried) do if q.id >= 90400 then carried[#carried + 1] = q.id end end
local pre = {}
for _, t in ipairs(plan.take) do
	if t.quest.id == 90403 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
local def = D.PickupGuide("{KEY}")
local steps, notes = {}, {}
for _, s in ipairs(def.steps) do
	local verbs = {}
	for _, g in ipairs(s.goals) do
		if g.quest and g.quest >= 90400 then verbs[#verbs + 1] = g.t .. ":" .. g.quest end
		if g.t == "note" then notes[#notes + 1] = g.text end
	end
	if #verbs > 0 then steps[#steps + 1] = table.concat(verbs, " ") end
end
emit({ take = take, carried = carried, pre = pre, steps = steps, notes = notes })"#);
	let open = run(&own, &script, Opts { done: vec![1098, 90400], ..Default::default() }).remove(0);
	assert_eq!(open["take"], json!([90403]), "the errands ahead of it are not takes of their own");
	assert_eq!(open["pre"], json!([90401, 90402]), "Leaders of the Fang's open prerequisites: Hamuul Runetotem, Nara Wildmane");
	assert_eq!(
		open["steps"],
		json!(["accept:90401 turnin:90401", "accept:90402 turnin:90402", "accept:90403"]),
		"both errands done on the way, then the giver of Leaders of the Fang, before the entrance"
	);

	let with_log = run(&own, &script, Opts { done: vec![1098, 90400], log: vec![1013, 90401], ..Default::default() }).remove(0);
	assert_eq!(with_log["take"], json!([90403]));
	assert_eq!(with_log["carried"], json!({}), "Hamuul Runetotem is done on the way, not carried");
	assert!(!with_log["notes"].as_array().into_iter().flatten().any(|n| text(n).contains("Hamuul Runetotem")), "no \"In your log already\" note for it at the entrance");

	// A variant where Nara Wildmane's turn-in has no spawn (inside): it no longer qualifies as an errand, so it
	// blocks Leaders of the Fang again.
	let mut c2 = c.clone();
	c2["npcs"]["90413"] = npc(90413, "Inside NPC", 1421, 50, 50);
	c2["npcs"]["90413"]["spawns"] = json!([]);
	c2["quests"]["90402"] = quest(90402, "Nara Wildmane", 90411, 90413, &[90401], json!([]));
	let inside = pack_of(&c2, &i);
	let blocked = run(&inside, &script, Opts { done: vec![1098, 90400], ..Default::default() }).remove(0);
	assert_eq!(blocked["take"], json!([90402]), "Nara Wildmane turns in nowhere reachable: it no longer clears the way for Leaders of the Fang, though it is still takeable on its own");
	drop(inside);

	// A variant where an item starts Nara Wildmane (as Nefarian's head starts The Lord of Blackrock), a giver
	// listed beside it: no errand either, though it asks for nothing, so it still blocks Leaders of the Fang.
	let mut c3 = c.clone();
	c3["quests"]["90402"]["start"] = json!({ "npc": [90411], "object": [], "item": [90422] });
	let by_item = pack_of(&c3, &i);
	let blocked = run(&by_item, &script, Opts { done: vec![1098, 90400], ..Default::default() }).remove(0);
	assert!(!takes(&blocked, 90403), "an item starts Nara Wildmane: Leaders of the Fang is left for after the run");
	drop(by_item);

	// A variant where Nara Wildmane needs Honored (as Strength of Mount Mugamba needs Zandalar standing): no
	// errand for a character below it, one for a character who has it.
	let mut c4 = c.clone();
	c4["quests"]["90402"]["repFaction"] = json!(270);
	c4["quests"]["90402"]["repStanding"] = json!(6);
	let by_rep = pack_of(&c4, &i);
	let friendly = run(&by_rep, &format!("stub.world.setRep(270, \"Zandalar Tribe\", 5, 3000, 3000, 9000)\n{script}"), Opts { done: vec![1098, 90400], ..Default::default() }).remove(0);
	assert!(!takes(&friendly, 90403), "Friendly, not Honored: Leaders of the Fang is left for after the run");
	let honored = run(&by_rep, &format!("stub.world.setRep(270, \"Zandalar Tribe\", 6, 9000, 9000, 21000)\n{script}"), Opts { done: vec![1098, 90400], ..Default::default() }).remove(0);
	assert_eq!(honored["take"], json!([90403]), "Honored: Nara Wildmane is an errand again");
}

// Travel between the fixture's zones by the way a player goes (seconds): Undercity and Silverpine are next
// door, the Barrens a zeppelin away.
const ZONE_TRAVEL: &str = r#"
local ZONES = { [1458] = "uc", [1421] = "sp", [1413] = "b" }
local COST = { ["uc-sp"] = 120, ["uc-b"] = 250, ["sp-b"] = 370 }
Polestar.TravelCost = function(a, b)
	local za, zb = ZONES[a.map], ZONES[b.map]
	if not (za and zb) then return nil end
	if za == zb then return 20 + math.abs(a.x - b.x) + math.abs(a.y - b.y) end
	return COST[za .. "-" .. zb] or COST[zb .. "-" .. za]
end"#;

#[test]
fn the_route_plans_toward_the_entrance_from_the_undercity_the_barrens_come_first_so_the_silverpine_chain_ends_next_to_the_keep() {
	let pack = default_pack();
	let out = run(&pack, &format!("{ZONE_TRAVEL}\n{}", k(r#"emit(describe(D.PickupGuide("{KEY}")))"#)), Opts::default()).remove(0);
	// A nearest-next walk took Bethor first (next door), went on through Silverpine, then to the Barrens and
	// all the way back to the keep.
	assert_eq!(out, barrens_first());
}

// Dungeons.PlanStops on its own: cities as points, travel by city pair.
const PLAN: &str = r#"
local CITY = { tb = { tb = 30, og = 300, uc = 450 }, og = { tb = 300, og = 30, uc = 200 }, uc = { tb = 450, og = 200, uc = 30 } }
local function at(city, name) return { city = city, name = name } end
local function travel(a, b) return CITY[a.city][b.city] end
local function names(stops, order)
	local out = {}
	for i, s in ipairs(order) do out[i] = stops[s].inP.name end
	return out
end
"#;

#[test]
fn ragefire_chasm_from_thunder_bluff_the_givers_in_thunder_bluff_the_undercity_then_orgrimmar_next_to_the_entrance() {
	let pack = default_pack();
	let script = PLAN.to_string()
		+ r#"
local stops = {
	{ inP = at("tb", "Thunder Bluff giver"), outP = at("tb"), deps = {} },
	{ inP = at("og", "Orgrimmar giver"), outP = at("og"), deps = {} },
	{ inP = at("uc", "Undercity giver"), outP = at("uc"), deps = {} },
}
local order, cost = D.PlanStops(stops, at("tb"), at("og", "entrance"), travel)
emit({ route = names(stops, order), cost = cost })"#;
	let out = run(&pack, &script, Opts::default()).remove(0);
	assert_eq!(out["route"], json!(["Thunder Bluff giver", "Undercity giver", "Orgrimmar giver"]));
	assert_eq!(out["cost"], 30 + 450 + 200 + 30, "not 30 + 300 + 200 + 200 (Orgrimmar, the Undercity and back)");
}

#[test]
fn planstops_keeps_every_stop_after_the_ones_it_waits_on_and_a_giver_s_visits_fall_together_where_they_can() {
	let pack = default_pack();
	let script = PLAN.to_string()
		+ r#"
-- A chain: a prerequisite from the Undercity turned in at Orgrimmar, then a
-- second one from Orgrimmar; the Orgrimmar giver has one quest open now and
-- one that waits on the chain.
local stops = {
	{ inP = at("uc", "first link"), outP = at("og"), deps = {} },
	{ inP = at("og", "second link"), outP = at("og"), deps = { 1 } },
	{ inP = at("og", "giver, open now"), outP = at("og"), deps = {} },
	{ inP = at("og", "giver, after the chain"), outP = at("og"), deps = { 2 } },
}
local order = D.PlanStops(stops, at("og"), at("og", "entrance"), travel)
-- Above the exact size: the improved nearest-next order still honours every dependency.
local many, from = {}, at("tb")
for i = 1, 14 do
	local city = ({ "tb", "og", "uc" })[i % 3 + 1]
	many[i] = { inP = at(city, "s" .. i), outP = at(city), deps = i > 1 and i % 4 == 0 and { i - 1 } or {} }
end
local big = D.PlanStops(many, from, at("og", "entrance"), travel)
local pos, ok = {}, #big == 14
for p, i in ipairs(big) do pos[i] = p end
for i, s in ipairs(many) do for _, d in ipairs(s.deps) do ok = ok and pos[d] < pos[i] end end
emit({ route = names(stops, order), big = ok })"#;
	let out = run(&pack, &script, Opts::default()).remove(0);
	// The chain in its order; the giver's two visits fall together after it, one stop instead of two trips.
	assert_eq!(out["route"], json!(["first link", "second link", "giver, open now", "giver, after the chain"]));
	assert_eq!(out["big"], true);
}

// After the run (Dungeons/Handin.lua): Arugal Must Die is finished, The Book of Ur is not; Return to Dalar
// opens when Arugal Must Die is turned in to Dalar, who gives it.
fn after_run() -> Opts {
	Opts { done: vec![1098, 1740, 1011], log: vec![1013], ready: vec![1014], ..Default::default() }
}

#[test]
fn after_the_run_a_finished_quest_routes_to_its_turn_in_the_follow_up_it_opens_is_taken_there_an_unfinished_one_is_a_note() {
	let pack = default_pack();
	let out = run(
		&pack,
		&k(r#"
local plan = D.HandinPlan("{KEY}")
local def = D.HandinGuide("{KEY}")
local ids = function(list, f) local o = {} for i, x in ipairs(list) do o[i] = f(x) end return o end
local last = def.steps[#def.steps]
emit({ hand = ids(plan.hand, function(h) return h.quest.id end), ender = { plan.hand[1].ender.name, plan.hand[1].ender.map },
	unfinished = ids(plan.unfinished, function(q) return q.id end),
	follow = ids(D.HandinFollowUps(plan), function(f) return f.rec.id end),
	title = def.title, steps = describe(def), note = last.goals[#last.goals].text, turnin = { last.goals[1].npcName, last.goals[1].map, last.goals[1].x } })"#),
		after_run(),
	)
	.remove(0);
	assert_eq!(out["hand"], json!([1014]));
	assert_eq!(out["ender"], json!(["Dalar Dawnweaver", 1421]));
	assert_eq!(out["unfinished"], json!([1013]));
	assert_eq!(out["follow"], json!([1016]), "Return to Dalar, given by the NPC Arugal Must Die is turned in to");
	assert_eq!(out["title"], "Shadowfang Keep: hand in the quests");
	assert_eq!(out["steps"], json!([{ "title": "Dalar Dawnweaver", "goals": "turnin:1014 accept:1016 note" }]));
	assert_eq!(out["note"], "Not finished yet: The Book of Ur");
	assert_eq!(out["turnin"], json!(["Dalar Dawnweaver", 1421, 44.2]));
}

#[test]
fn after_the_run_a_follow_up_from_a_giver_next_door_is_a_stop_of_its_own_one_far_away_or_one_this_character_cannot_take_is_left_out_a_finished_delivery_is_handed_in() {
	let pack = default_pack();
	let r = run(
		&pack,
		&k(r#"
local function follow() local o = {} for i, f in ipairs(D.HandinFollowUps(D.HandinPlan("{KEY}"))) do o[i] = f.rec.id end return o end
emit(follow())
-- Held, so the Codex keeps this record while its giver is moved.
local dalar = Polestar.Codex.Quest(1016)
dalar.start.npc = { 1952 } -- High Executor Hadrec, next to Dalar
emit(describe(D.HandinGuide("{KEY}")))
dalar.start.npc = { 6247 } -- Doan Karhan, in the Barrens
emit(#follow())
dalar.start.npc = { 1938 }
stub.world.level = 17
emit(#follow())
stub.world.level = 21
stub.world.finish(1013)
emit(describe(D.HandinGuide("{KEY}")))"#),
		Opts { at: Some(BARRENS), ..after_run() },
	);
	let (barrens, near, far, low, both) = (&r[0], &r[1], &r[2], &r[3], &r[4]);
	assert_eq!(*barrens, json!([1016]), "nearness is measured from the turn-in, not from where the player stands");
	assert_eq!(*near, json!([{ "title": "Dalar Dawnweaver", "goals": "turnin:1014" }, { "title": "High Executor Hadrec", "goals": "accept:1016 note" }]));
	assert_eq!(*far, 0);
	assert_eq!(*low, 0, "Return to Dalar needs level 18");
	let mut goals: Vec<&str> = both.as_array().unwrap().iter().map(|s| text(&s["goals"])).collect();
	goals.sort();
	assert_eq!(goals, vec!["turnin:1013", "turnin:1014 accept:1016"]);
}

#[test]
fn nothing_to_hand_in_handin_says_so_and_builds_no_guide_the_text_names_what_is_not_finished() {
	let pack = default_pack();
	let out = run(
		&pack,
		&k(r#"
local before = tabIds()
local id, why = D.HandIn("{KEY}")
emit({ id = id or false, why = why or false, guide = Polestar.Guides.Get("lookup/handin/{KEY}") ~= nil, same = #tabIds() == #before,
	text = D.HandinText(D.HandinPlan("{KEY}")) })
stub.world.abandon(1013)
emit(D.HandinText(D.HandinPlan("{KEY}")))"#),
		Opts::default(),
	)
	.remove(0);
	assert_eq!(out, json!({ "id": false, "why": "nothing", "guide": false, "same": true, "text": "Not finished yet: The Book of Ur." }));
}

#[test]
fn handin_takes_the_place_of_the_pick_up_guide_once_that_one_is_at_the_entrance_comes_back_after_reload_and_plays_to_the_end() {
	let pack = default_pack();
	let opts = || Opts { done: vec![1098, 1740, 1011, 1014], log: vec![], ready: vec![1013], ..Default::default() };
	let script = k(r#"
Polestar.Set("behavior.autoNextGuide", false)
-- Return to Dalar is all that is left to pick up: its step, then the entrance.
D.PickUp("{KEY}")
Polestar.Engine.OpenTab("lookup/pickup/{KEY}")
local early = { D.HandIn("{KEY}") }
local kept = tabIds()
stub.world.accept(1016, { 1 })
stub.advance(0.6)
local id = D.HandIn("{KEY}")
local s = Polestar.CharState()
emit({ early = early[1] or false, kept = kept, id = id or false, tabs = tabIds(), active = Polestar.Engine.GetGuide().id,
	order = s.dungeonHandin and s.dungeonHandin["{KEY}"] or false, saved = s.tabs })
stub.advance(0.6)
{SIMULATE}"#)
	.replace("{SIMULATE}", SIMULATE);
	let r = run(&pack, &script, opts());
	let (first, out) = (&r[0], &r[1]);
	assert_eq!(first["early"], "lookup/handin/shadowfang-keep", "built while the pick-up guide still has a quest to take");
	assert_eq!(first["kept"], json!(["lookup/pickup/shadowfang-keep", "lookup/handin/shadowfang-keep"]), "then both stay open");
	assert_eq!(first["id"], "lookup/handin/shadowfang-keep");
	assert_eq!(first["tabs"], json!(["lookup/handin/shadowfang-keep"]), "at its last step the pick-up guide gives up its tab");
	assert_eq!(first["active"], "lookup/handin/shadowfang-keep");
	assert_eq!(first["order"], json!(["enpc2934"]));
	assert!(!truthy(&out["stuck"]), "stuck: {}", out["stuck"]);
	assert_eq!(out["done"], true);
	assert_eq!(out["missing"], json!({}));
	let saved = format!(
		"PolestarCharDB = {{ schema = 1, tabs = {}, activeTab = 1, dungeonHandin = {{ [{}] = {} }} }}",
		lua_value(&first["saved"]),
		serde_json::to_string(KEY).unwrap(),
		lua_value(&first["order"])
	);
	let after = run(&pack, &k(r#"emit({ tabs = tabIds(), steps = describe(Polestar.Guides.Get("lookup/handin/{KEY}")) })"#), Opts { at: None, saved: Some(saved), ..opts() }).remove(0);
	assert_eq!(after, json!({ "tabs": ["lookup/handin/shadowfang-keep"], "steps": [{ "title": "Keeper Bel'dugur", "goals": "turnin:1013" }] }));
}
