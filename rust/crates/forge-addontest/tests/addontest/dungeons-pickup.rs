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
			store_xp: &Default::default(),
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
	/// Load the quest database module (Quests/QuestDB.lua) too; the script adds its records.
	questdb: bool,
}

impl Default for Opts {
	fn default() -> Self {
		Opts { level: 21, race: "Scourge", faction: "Horde", cls: "WARLOCK", at: Some(UNDERCITY), done: vec![1098], log: vec![1013], ready: vec![], saved: None, questdb: false }
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
		addons: vec![if o.questdb {
			Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml", "Quests/QuestDB.lua", "Dungeons/Dungeons.xml"])
		} else {
			Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml"])
		}],
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
	assert_eq!(out["note"], "In your log already: “The Book of Ur”");
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

// #1024 (Pilk, Tauren Druid, Wailing Caverns): the arrow to Apothecary Zamah led up out of the Pools of Vision,
// because the pick-up guide's goals had no height and a walk without one ends on the top surface. Every goal at
// an NPC now carries the height of that NPC's Codex spawn there: a page giver's accept (Doan Karhan), a
// prerequisite's accept (Bethor Iceshard, under the Undercity's ruins); an NPC without one stays without.
#[test]
fn the_pick_up_guide_s_goals_at_an_npc_carry_the_height_of_its_spawn_so_the_arrow_walks_to_its_floor_1024() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	c["npcs"]["1498"]["spawns"][0]["z"] = json!(-43.2);
	c["npcs"]["6247"]["spawns"][0]["z"] = json!(91.3);
	let pack = pack_of(&c, &inputs);
	let out = run(
		&pack,
		&k(r#"
local z = {}
for _, s in ipairs(D.PickupGuide("{KEY}").steps) do
	for _, g in ipairs(s.goals) do
		if g.quest then z[g.t .. ":" .. g.quest] = g.z or false end
	end
end
emit(z)"#),
		Opts::default(),
	)
	.remove(0);
	assert_eq!(out["accept:1740"], json!(91.3), "Doan Karhan, the page's giver: his height");
	assert_eq!(out["accept:1010"], json!(-43.2), "Bethor Iceshard, a prerequisite's giver: his height");
	assert_eq!(out["turnin:1010"], json!(false), "Apothecary Renferrel has no height in the Codex: none");
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

// Storm, Earth, and Fire (79358 in the 0.3.5 data) is turned in to Rau Cliffrunner (Horde) or Veyric Thunderhame
// (no side in the Codex); the page keeps the first, Rau, so 0.3.5's hand-in guide sent Alliance Shamans to the
// Horde's NPC. The character's own side picks the ender, as Dungeons.Giver picks the giver: the page's when it is
// theirs, else the Codex ender of their side; the Dungeons page's Ends line reads the same.
#[test]
fn a_quest_turned_in_to_npcs_of_both_sides_storm_earth_and_fire_the_alliance_hands_it_in_to_its_own_ender_never_the_page_s_horde_one() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	let npc = |id: i32, name: &str, faction: Value, map: i32, x: i32, y: i32| json!({ "id": id, "name": name, "level": 37, "levelMax": null, "faction": faction, "rare": false, "elite": false, "boss": false, "instance": null, "roles": [], "spawns": [{ "map": map, "x": x, "y": y, "f": "e" }] });
	c["npcs"]["9011"] = npc(9011, "Rau Cliffrunner", json!("H"), 1413, 46, 52);
	c["npcs"]["9012"] = npc(9012, "Veyric Thunderhame", Value::Null, 1421, 60, 28);
	c["quests"]["90300"] = json!({
		"id": 90300, "title": "Storm, Earth, and Fire", "level": 25, "minLevel": 18, "faction": null, "races": null, "classes": null,
		"start": { "npc": [9012], "object": [], "item": [] }, "end": { "npc": [9011, 9012], "object": [] },
		"objectives": [], "pre": [], "zone": 1421, "rewards": [], "choices": [], "preAny": [],
	});
	i["forever"]["quests"]["90300"] = json!({ "area": 209 });
	let journal = plain(&journal_of(&c, &i));
	let page = journal["dungeons"][KEY]["quests"].as_array().unwrap().iter().find(|q| q["id"] == 90300).unwrap().clone();
	assert_eq!(page["finish"]["name"], "Rau Cliffrunner", "the page keeps the first ender");
	let own = pack_of(&c, &i);
	let script = k(r#"
local plan = D.HandinPlan("{KEY}")
local ender
for _, h in ipairs(plan.hand) do if h.quest.id == 90300 then ender = h.ender.name end end
local turnin
for _, s in ipairs(D.HandinGuide("{KEY}").steps) do
	for _, g in ipairs(s.goals) do if g.t == "turnin" and g.quest == 90300 then turnin = g.npcName end end
end
local e = D.Ender and D.Ender(D.Quest("{KEY}", 90300), Polestar.PlayerPoint())
emit({ plan = ender or false, guide = turnin or false, ender = e and e.name or false })"#);
	let shaman = run(&own, &script, Opts { race: "Dwarf", faction: "Alliance", cls: "SHAMAN", level: 40, ready: vec![90300], ..Default::default() }).remove(0);
	assert_eq!(shaman, json!({ "plan": "Veyric Thunderhame", "guide": "Veyric Thunderhame", "ender": "Veyric Thunderhame" }), "an Alliance Shaman hands it in to Veyric");
	let horde = run(&own, &script, Opts { race: "Troll", cls: "SHAMAN", level: 40, ready: vec![90300], ..Default::default() }).remove(0);
	assert_eq!(horde, json!({ "plan": "Rau Cliffrunner", "guide": "Rau Cliffrunner", "ender": "Rau Cliffrunner" }), "the Horde keeps the page's Rau");
}

// #1326 (TrustmeXD): The Glowing Shard (6981) drops inside Wailing Caverns, and its one quest-log line is to speak
// to Sputtervalve in Ratchet, after the run, before Falla Sagewind takes it. The Codex had no line for it, so the
// hand-in guide found it unfinished and left it out ("Not finished yet"). A quest whose open lines are all talks to
// an NPC outside is now handed in: a stop at that NPC (the talk goal on its line) before the turn-in, the
// follow-up taken there after. Here 90600 is that quest on the fixture's page, 90601 one whose open line is a kill
// outside (still unfinished: a kill is real work, not a hand-in errand).
#[test]
fn a_dungeon_quest_whose_open_line_is_to_speak_to_an_npc_outside_is_handed_in_after_that_talk_1326_the_glowing_shard_and_sputtervalve() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	c["npcs"]["9030"] = sideless_npc(9030, "Sputtervalve", 1413, 62, 37);
	c["npcs"]["9031"] = sideless_npc(9031, "Falla Sagewind", 1413, 48, 32);
	let quest = |id: i32, title: &str, start: Value, pre: &[i32], objectives: Value| {
		json!({
			"id": id, "title": title, "level": 26, "minLevel": 15, "faction": null, "races": null, "classes": null,
			"start": start, "end": { "npc": [9031], "object": [] },
			"objectives": objectives, "pre": pre, "zone": 1413, "rewards": [], "choices": [], "preAny": [],
		})
	};
	let by_item = json!({ "npc": [], "object": [], "item": [90620] });
	c["quests"]["90600"] =
		quest(90600, "The Glowing Shard", by_item.clone(), &[], json!([{ "type": "talk", "id": 9030, "count": 1, "text": "Speak with someone in Ratchet about the Glowing Shard" }]));
	c["quests"]["90601"] = quest(90601, "A Kill Left", by_item, &[], json!([{ "type": "kill", "id": 90621, "count": 1, "text": "Test Mob" }]));
	c["quests"]["90602"] = quest(90602, "In Nightmares", json!({ "npc": [9031], "object": [], "item": [] }), &[90600], json!([]));
	i["forever"]["quests"]["90600"] = json!({ "area": 209 });
	i["forever"]["quests"]["90601"] = json!({ "area": 209 });
	let own = pack_of(&c, &i);
	let script = k(r#"
local plan = D.HandinPlan("{KEY}")
local hand, unfinished, talk = {}, {}, false
for _, h in ipairs(plan.hand) do
	if h.quest.id >= 90600 then hand[#hand + 1] = h.quest.id end
end
for _, q in ipairs(plan.unfinished) do if q.id >= 90600 then unfinished[#unfinished + 1] = q.id end end
local steps = {}
for _, s in ipairs((D.HandinGuide("{KEY}") or { steps = {} }).steps) do
	local verbs = {}
	for _, g in ipairs(s.goals) do
		if g.quest and g.quest >= 90600 then verbs[#verbs + 1] = g.t .. ":" .. g.quest end
		if g.t == "talk" then talk = { npc = g.npc, name = g.npcName, oi = g.oi, map = g.map, x = g.x, y = g.y } end
	end
	if #verbs > 0 then steps[#steps + 1] = s.title .. " " .. table.concat(verbs, " ") end
end
emit({ hand = hand, unfinished = unfinished, steps = steps, talk = talk })"#);

	let open = run(&own, &script, Opts { at: Some(BARRENS), log: vec![1013, 90600, 90601], ..Default::default() }).remove(0);
	assert_eq!(open["hand"], json!([90600]), "the shard is handed in though its talk line is open");
	assert_eq!(open["unfinished"], json!([90601]), "a kill left outside is still unfinished");
	assert_eq!(open["steps"], json!(["Sputtervalve talk:90600", "Falla Sagewind turnin:90600 accept:90602"]), "Sputtervalve first, then Falla Sagewind for the hand-in and the follow-up");
	assert_eq!(open["talk"], json!({ "npc": 9030, "name": "Sputtervalve", "oi": 1, "map": 1413, "x": 62, "y": 37 }), "the talk goal is counted by the quest's first line, the arrow on Sputtervalve");

	// Spoken to already: the line is done and the quest ready, so the guide goes straight to Falla Sagewind.
	let ready = run(&own, &script, Opts { at: Some(BARRENS), ready: vec![90600], ..Default::default() }).remove(0);
	assert_eq!(ready["hand"], json!([90600]));
	assert_eq!(ready["steps"], json!(["Falla Sagewind turnin:90600 accept:90602"]), "no talk left");
}

#[test]
fn pickup_opens_the_guide_in_a_new_tab_and_it_plays_to_the_end_the_giver_link_points_at_the_first_prerequisite_still_to_do() {
	let pack = default_pack();
	let script = k(r#"
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

// #1406 (In0k: Gryan Stoutmantle did not offer The Defias Brotherhood): the accepts carry their quests'
// prerequisites, so when the step that does one is skipped, the accept after it says why and the guide moves
// on, instead of sending the player to a giver who does not offer it. Skipping Bethor's errand leaves The
// Dalaran Inquiry without its Horde prerequisite (the Alliance's Word from Dalaran is not named) and Arugal Must
// Die without The Dalaran Inquiry.
#[test]
fn an_accept_whose_prerequisite_step_was_skipped_says_what_it_requires_and_the_guide_moves_on_1406() {
	let pack = default_pack();
	let out = run(
		&pack,
		&k(r#"
D.PickUp("{KEY}")
local E = Polestar.Engine
Polestar.Set("behavior.autoAccept", false)
stub.advance(0.25)
local function marks(i)
	local out = {}
	for g, v in ipairs(E.GetStepView(i).goals) do out[g] = v.status .. ":" .. tostring(v.unavailableText) end
	return out
end
local g = E.GetGuide()
local inquiry, arugal = g.steps[2].goals[1], g.steps[3].goals[1]
local r = {
	inquiry = { inquiry.quest, inquiry.pre or false, inquiry.preAll or false },
	arugal = { arugal.quest, arugal.pre or false, arugal.preAll or false, arugal.preTitles and arugal.preTitles[1011] or false },
	before = { E.GetStepIndex(), marks(3) },
}
E.Skip()
stub.advance(0.25)
r.after = { E.GetStepIndex(), marks(2)[1], marks(3)[1] }
emit(r)"#),
		Opts::default(),
	)
	.remove(0);
	assert_eq!(out["inquiry"], json!([1011, [1010], false]), "one of 1009 and 1010: the Horde's, the Alliance's left out");
	assert_eq!(out["arugal"], json!([1014, false, [1011], "The Dalaran Inquiry"]));
	assert_eq!(out["before"], json!([1, ["pending:nil"]]), "while the route still brings it, the accept waits its turn");
	assert_eq!(
		out["after"],
		json!([4, "skipped:Requires Orders from the Undercity first", "skipped:Requires The Dalaran Inquiry first"]),
		"Bethor's step skipped: the accepts after it say why, and the guide goes on to Doan Karhan"
	);
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

/// A quest of the fixture's page (area 209: Shadowfang Keep) in the Codex shape.
fn page_quest(id: i32, title: &str, faction: Value, giver: i32, ender: i32) -> Value {
	json!({
		"id": id, "title": title, "level": 24, "minLevel": 18, "faction": faction, "races": null, "classes": null,
		"start": { "npc": [giver], "object": [], "item": [] }, "end": { "npc": [ender], "object": [] },
		"objectives": [], "pre": [], "zone": 1421, "rewards": [], "choices": [], "preAny": [],
	})
}

/// An NPC of no faction (the Argent Dawn's, friendly to both sides) at a point of the fixture's maps.
fn sideless_npc(id: i32, name: &str, map: i32, x: i32, y: i32) -> Value {
	json!({ "id": id, "name": name, "level": 30, "levelMax": null, "faction": null, "rare": false, "elite": false, "boss": false, "instance": null, "roles": [], "spawns": [{ "map": map, "x": x, "y": y, "f": "e" }] })
}

const TAKE: &str = r#"
local plan = D.PickupPlan("{KEY}")
local take = {}
for i, t in ipairs(plan.take) do take[i] = t.quest.id end
table.sort(take)
local accepts = {}
for _, s in ipairs((D.PickupGuide("{KEY}") or { steps = {} }).steps) do
	for _, g in ipairs(s.goals) do if g.t == "accept" then accepts[#accepts + 1] = g.quest end end
end
table.sort(accepts)
emit({ take = take, accepts = accepts })"#;

#[test]
fn a_quest_the_codex_gives_no_side_whose_follow_up_is_the_alliance_s_is_never_in_a_horde_pick_up_1026_in_search_of_thaelrid() {
	// The 0.3.2 Codex's Blackfathom Deeps: In Search of Thaelrid has no side and its giver, Dawnwatcher
	// Shaedlass, is the Argent Dawn's (no faction either); only its follow-up, Blackfathom Villainy, is the
	// Alliance's, and the Codex does not even list the first as the second's prerequisite (the page does).
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	c["npcs"]["9101"] = sideless_npc(9101, "Dawnwatcher Shaedlass", 1421, 60, 40);
	c["npcs"]["9102"] = sideless_npc(9102, "Argent Guard Thaelrid", 1421, 44, 68);
	c["quests"]["90400"] = page_quest(90400, "In Search of Thaelrid", Value::Null, 9101, 9102);
	c["quests"]["90401"] = page_quest(90401, "Blackfathom Villainy", json!("A"), 9102, 9101);
	i["forever"]["quests"]["90400"] = json!({ "area": 209 });
	i["forever"]["quests"]["90401"] = json!({ "area": 209, "pre": [90400] });
	let own = pack_of(&c, &i);
	let horde = run(&own, &k(TAKE), Opts::default()).remove(0);
	assert_eq!(horde, json!({ "take": [1014, 1740], "accepts": [1010, 1011, 1014, 1740] }), "the Horde warlock is never sent to Shaedlass");
	let human = run(&own, &k(TAKE), Opts { race: "Human", faction: "Alliance", cls: "MAGE", log: vec![], ..Default::default() }).remove(0);
	assert!(takes(&human, 90400), "an Alliance character still takes it: {}", human["take"]);
}

#[test]
fn a_quest_the_codex_gives_no_side_takes_the_quest_database_s_the_horde_never_picks_up_an_alliance_quest_from_a_giver_of_no_faction_1026() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	c["npcs"]["9101"] = sideless_npc(9101, "Argent Quartermaster", 1421, 60, 40);
	c["quests"]["90410"] = page_quest(90410, "Argent Errand", Value::Null, 9101, 9101);
	c["quests"]["90411"] = page_quest(90411, "Argent Call", Value::Null, 9101, 9101);
	i["forever"]["quests"]["90410"] = json!({ "area": 209 });
	i["forever"]["quests"]["90411"] = json!({ "area": 209 });
	let own = pack_of(&c, &i);
	// Layout: title, level, minLevel, races, classes, faction: 90410 the Alliance's, 90411 both sides'.
	let script = format!(
		"{}\nAddRecords(\"quests\", {{ [90410] = {{ \"Argent Errand\", 24, 18, 77, nil, 1 }}, [90411] = {{ \"Argent Call\", 24, 18 }} }})\nPolestar.QuestDB.SetMeta({{}})\n{}",
		forge_addontest::questdb::ADD_RECORDS_LUA,
		k(TAKE)
	);
	let horde = run(&own, &script, Opts { questdb: true, ..Default::default() }).remove(0);
	assert_eq!(horde["take"], json!([1014, 1740, 90411]), "the quest database's Alliance quest is not the Horde's; the one of both sides is");
	let human = run(&own, &script, Opts { race: "Human", faction: "Alliance", cls: "MAGE", log: vec![], questdb: true, ..Default::default() }).remove(0);
	assert_eq!(human["take"], json!([90410, 90411]));
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

#[test]
fn a_quest_an_item_starts_that_drops_outside_is_collected_on_the_way_and_opens_the_quest_after_it_1380_the_damp_note() {
	// #1380: Blackfathom Deeps' Allegiance to the Old Gods (6564) starts from the Damp Note, which the
	// Blackfathom Tide Priestesses drop one time in three in the tunnels before the portal, outside the instance.
	// It is handed to Je'neu Sancrea, who then gives the second Allegiance to the Old Gods (6565), Lorgus Jett
	// inside. The pick-up guide left both out: no giver for the first, and the second followed a quest of the
	// page that was no errand. Here A (90501) starts from item 90520, which the Tide Priestess (90511, spawns
	// outside) drops at 33%, asks nothing and is turned in to Giver J (90510); B (90502) is J's, after A.
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	let npc = |id: i32, name: &str, faction: Value, x: i32, y: i32| {
		json!({
			"id": id, "name": name, "level": 21, "levelMax": null, "faction": faction, "rare": false, "elite": false, "boss": false,
			"instance": null, "roles": [], "spawns": [{ "map": 1421, "x": x, "y": y, "f": "e" }],
		})
	};
	c["npcs"]["90510"] = npc(90510, "Giver J", json!("H"), 40, 40);
	c["npcs"]["90511"] = npc(90511, "Tide Priestess", Value::Null, 46, 46);
	let note =
		|chance: f64| json!({ "id": 90520, "name": "Damp Note", "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": [{ "type": "drop", "npc": 90511, "chance": chance }] });
	c["items"]["90520"] = note(33.0);
	let quest = |id: i32, title: &str, start: Value, pre: &[i32], min_level: i32, objectives: Value| {
		json!({
			"id": id, "title": title, "level": 25, "minLevel": min_level, "faction": "H", "races": null, "classes": null,
			"start": start, "end": { "npc": [90510], "object": [] },
			"objectives": objectives, "pre": pre, "zone": 1421, "rewards": [], "choices": [], "preAny": [],
		})
	};
	let from_note = json!({ "npc": [], "object": [], "item": [90520] });
	let from_j = json!({ "npc": [90510], "object": [], "item": [] });
	c["quests"]["90501"] = quest(90501, "Allegiance A", from_note.clone(), &[], 18, json!([]));
	c["quests"]["90502"] = quest(90502, "Allegiance B", from_j.clone(), &[90501], 18, json!([{ "type": "kill", "id": 90521, "count": 1, "text": "Lorgus" }]));
	i["forever"]["quests"]["90501"] = json!({ "area": 209 });
	i["forever"]["quests"]["90502"] = json!({ "area": 209 });
	let script = k(r#"
local plan = D.PickupPlan("{KEY}")
local take, pre = {}, {}
for _, t in ipairs(plan.take) do
	if t.quest.id >= 90500 then take[#take + 1] = t.quest.id end
	if t.quest.id == 90502 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
local def = D.PickupGuide("{KEY}")
local steps = {}
for _, s in ipairs(def and def.steps or {}) do
	local verbs = {}
	for _, g in ipairs(s.goals) do
		if (g.quest and g.quest >= 90500) or g.item == 90520 then
			verbs[#verbs + 1] = g.t .. ":" .. (g.quest or g.item) .. (g.npcName and ("@" .. g.npcName) or "")
		end
	end
	if #verbs > 0 then steps[#steps + 1] = table.concat(verbs, " ") end
end
local pt, label, first = D.GiverTarget("{KEY}", 90502)
local own, ownLabel = D.GiverTarget("{KEY}", 90501)
emit({ take = take, pre = pre, steps = steps, target = pt and { pt.map, pt.x, pt.y, label, first } or false,
	own = own and { own.map, own.x, own.y, ownLabel } or false })"#);
	let opts = || Opts { done: vec![1098], ..Default::default() };

	let own = pack_of(&c, &i);
	let out = run(&own, &script, opts()).remove(0);
	assert_eq!(out["take"], json!([90502]), "A is done on the way to B, not a take of its own");
	assert_eq!(out["pre"], json!([90501]));
	assert_eq!(
		out["steps"],
		json!(["collect:90520@Tide Priestess accept:90501 turnin:90501@Giver J", "accept:90502@Giver J"]),
		"the note from the mob outside, taken and handed in, then B from the same giver, before the entrance"
	);
	assert_eq!(out["target"], json!([1421, 46, 46, "Tide Priestess", "Allegiance A"]), "B's pin: the mob that drops the note A starts from");
	assert_eq!(out["own"], json!([1421, 46, 46, "Tide Priestess"]), "A's pin: the same mob");
	drop(own);

	// B not open before level 40: A is a take of its own, collected and taken at the mob.
	let mut later = c.clone();
	later["quests"]["90502"] = quest(90502, "Allegiance B", from_j.clone(), &[90501], 40, json!([{ "type": "kill", "id": 90521, "count": 1, "text": "Lorgus" }]));
	let later = pack_of(&later, &i);
	let alone = run(&later, &script, opts()).remove(0);
	assert_eq!(alone["take"], json!([90501]));
	assert_eq!(alone["steps"], json!(["collect:90520@Tide Priestess accept:90501"]));
	drop(later);

	// A note that drops one time in ten is no errand before the run: both are left for after it, as before.
	let mut rare = c.clone();
	rare["items"]["90520"] = note(10.0);
	let rare = pack_of(&rare, &i);
	let none = run(&rare, &script, opts()).remove(0);
	assert_eq!(none["take"], json!({}), "{none}");
	drop(rare);

	// A's own prerequisite still open (as Trouble in the Deeps from Stonetalon before the Damp Note): no trip
	// is added for it, and both wait.
	let mut gated = c.clone();
	gated["quests"]["90500"] = quest(90500, "A Breadcrumb", from_j.clone(), &[], 18, json!([]));
	gated["quests"]["90501"]["preAny"] = json!([90500]);
	let gated = pack_of(&gated, &i);
	let wait = run(&gated, &script, opts()).remove(0);
	assert_eq!(wait["take"], json!({}), "{wait}");
}

#[test]
fn a_prerequisite_whose_objective_is_to_speak_to_an_npc_sends_the_player_to_that_npc_before_its_turn_in_1236_hidden_enemies_and_neeru_fireblade() {
	// #1236, #1240: Hidden Enemies (5727) asks the player to speak to Neeru Fireblade in the Cleft of Shadow
	// and is handed in to Thrall; it is the prerequisite of the Ragefire Chasm quest. The Codex used to drop
	// talk objectives, so the guide's step for it was accept and hand in at Thrall, Neeru never visited. Here B
	// is that quest, off the page: given and turned in by Giver One, its one objective to speak to Giver Two
	// elsewhere; D is the dungeon quest after it.
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	let npc = |id: i32, name: &str, x: i32, y: i32| {
		json!({
			"id": id, "name": name, "level": 30, "levelMax": null, "faction": "H", "rare": false, "elite": false, "boss": false,
			"instance": null, "roles": [], "spawns": [{ "map": 1421, "x": x, "y": y, "f": "e" }],
		})
	};
	c["npcs"]["90510"] = npc(90510, "Giver One", 40, 40);
	c["npcs"]["90511"] = npc(90511, "Giver Two", 60, 60);
	let quest = |id: i32, title: &str, pre: &[i32], objectives: Value| {
		json!({
			"id": id, "title": title, "level": 25, "minLevel": 18, "faction": "H", "races": null, "classes": null,
			"start": { "npc": [90510], "object": [], "item": [] }, "end": { "npc": [90510], "object": [] },
			"objectives": objectives, "pre": pre, "zone": 1421, "rewards": [], "choices": [], "preAny": [],
		})
	};
	c["quests"]["90501"] = quest(90501, "Speak to Giver Two", &[], json!([{ "type": "talk", "id": 90511, "count": 1, "text": "Giver Two" }]));
	c["quests"]["90503"] = quest(90503, "The Dungeon Quest", &[90501], json!([{ "type": "item", "id": 90521, "count": 1, "text": "Gem of Test" }]));
	i["forever"]["quests"]["90503"] = json!({ "area": 209 });
	let own = pack_of(&c, &i);
	let script = k(r#"
local q = Polestar.Codex.Quest(90501)
local plan = D.PickupPlan("{KEY}")
local take, pre = {}, {}
for _, t in ipairs(plan.take) do
	if t.quest.id >= 90500 then take[#take + 1] = t.quest.id end
	if t.quest.id == 90503 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
local steps, talk = {}, nil
for _, s in ipairs(D.PickupGuide("{KEY}").steps) do
	local verbs = {}
	for _, g in ipairs(s.goals) do
		if g.quest and g.quest >= 90500 then verbs[#verbs + 1] = g.t .. ":" .. g.quest end
		if g.t == "talk" and g.quest == 90501 then talk = { npc = g.npc, name = g.npcName, oi = g.oi, map = g.map, x = g.x, y = g.y } end
	end
	if #verbs > 0 then steps[#steps + 1] = table.concat(verbs, " ") end
end
emit({ objective = q.objectives[1], take = take, pre = pre, steps = steps, talk = talk })"#);
	let out = run(&own, &script, Opts { done: vec![1098], ..Default::default() }).remove(0);
	assert_eq!(out["objective"]["type"], json!("talk"), "the Codex keeps the talk objective");
	assert_eq!(out["objective"]["id"], json!(90511));
	assert_eq!(out["take"], json!([90503]));
	assert_eq!(out["pre"], json!([90501]), "the dungeon quest's open prerequisite");
	assert_eq!(out["steps"], json!(["accept:90501 talk:90501 turnin:90501", "accept:90503"]), "accept, speak to Giver Two, hand in, then the dungeon quest");
	assert_eq!(out["talk"]["npc"], json!(90511));
	assert_eq!(out["talk"]["name"], json!("Giver Two"));
	assert_eq!(out["talk"]["oi"], json!(1), "counted by the quest's first objective line");
	assert_eq!((out["talk"]["map"].clone(), out["talk"]["x"].clone(), out["talk"]["y"].clone()), (json!(1421), json!(60), json!(60)), "the arrow points at Giver Two");

	// #1256: B already in the log, Giver Two not yet spoken to. The guide still sends the player there and
	// back before the dungeon quest, instead of to its giver for a quest it cannot offer yet.
	let logged = run(&own, &script, Opts { done: vec![1098], log: vec![1013, 90501], ..Default::default() }).remove(0);
	assert_eq!(logged["take"], json!([90503]));
	assert_eq!(logged["steps"], json!(["accept:90501 talk:90501 turnin:90501", "accept:90503"]), "B's step comes first: its accept is already done, the talk and the hand-in are left");
}

// #1226 (rockzors, Gnome Warlock 27, Excavation Site: Wetlands): Horrors in the Highland's chain starts with
// Tramping Paws at Rethiel the Greenwarden, and the page lists The Greenwarden, First Mate Fitzsimmons's
// breadcrumb from Menethil Harbor to Rethiel, before it. The Codex names no prerequisite for Tramping Paws (the
// game does not require the breadcrumb), so the guide picked up Menethil's quests and walked to Rethiel without
// it. An open breadcrumb of the chain, an errand turned in at the giver of a prerequisite still to take, now goes
// right before that prerequisite, and its accept is closed by it.
#[test]
fn an_open_breadcrumb_of_the_chain_is_done_on_the_way_before_the_quest_it_leads_to_1226_the_greenwarden_before_tramping_paws() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	let npc = |id: i32, name: &str, x: i32| {
		json!({
			"id": id, "name": name, "level": 30, "levelMax": null, "faction": "H", "rare": false, "elite": false, "boss": false,
			"instance": null, "roles": [], "spawns": [{ "map": 1421, "x": x, "y": x, "f": "e" }],
		})
	};
	c["npcs"]["90710"] = npc(90710, "Rethiel", 40);
	c["npcs"]["90711"] = npc(90711, "Fitzsimmons", 30);
	let quest = |id: i32, title: &str, giver: i32, objectives: Value, pre: &[i32], pre_any: &[i32]| {
		json!({
			"id": id, "title": title, "level": 25, "minLevel": 18, "faction": "H", "races": null, "classes": null,
			"start": { "npc": [giver], "object": [], "item": [] }, "end": { "npc": [90710], "object": [] },
			"objectives": objectives, "pre": pre, "zone": 1421, "rewards": [], "choices": [], "preAny": pre_any,
		})
	};
	let kill = json!([{ "type": "kill", "id": 90720, "count": 1, "text": "Mosshide Gnoll" }]);
	// 90700 Tramping Paws (Rethiel's, with objectives), 90701 The Greenwarden (Fitzsimmons's errand to Rethiel,
	// named only by 90700's breadcrumbs), 90702 the dungeon quest after 90700.
	c["quests"]["90700"] = quest(90700, "Tramping Paws", 90710, kill.clone(), &[], &[]);
	c["quests"]["90701"] = quest(90701, "The Greenwarden", 90711, json!([]), &[], &[]);
	c["quests"]["90702"] = quest(90702, "Horrors in the Highland", 90710, kill.clone(), &[90700], &[]);
	i["forever"]["quests"]["90700"] = json!({ "breadcrumbs": [90701] });
	i["forever"]["quests"]["90702"] = json!({ "area": 209 });
	let own = pack_of(&c, &i);
	let script = k(r#"
local plan = D.PickupPlan("{KEY}")
local pre = {}
for _, t in ipairs(plan.take) do
	if t.quest.id == 90702 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
local steps, closedBy = {}, {}
for _, s in ipairs((D.PickupGuide("{KEY}") or { steps = {} }).steps) do
	local verbs = {}
	for _, g in ipairs(s.goals) do
		if g.quest and g.quest >= 90700 then
			verbs[#verbs + 1] = g.t .. ":" .. g.quest
			if g.t == "accept" and g.closedBy then closedBy[tostring(g.quest)] = table.concat(g.closedBy, ",") end
		end
	end
	if #verbs > 0 then steps[#steps + 1] = table.concat(verbs, " ") end
end
local chain = {}
for n, id in ipairs(D.Quest("{KEY}", 90702).chain or {}) do chain[n] = id end
emit({ pre = pre, steps = steps, closedBy = closedBy, chain = chain })"#);
	let open = run(&own, &script, Opts { done: vec![1098], ..Default::default() }).remove(0);
	assert_eq!(open["chain"], json!([90701, 90700]), "the page lists the breadcrumb before Tramping Paws");
	assert_eq!(open["pre"], json!([90701, 90700]), "The Greenwarden right before Tramping Paws");
	assert_eq!(open["steps"], json!(["accept:90701 turnin:90701", "accept:90700 kill:90700 turnin:90700", "accept:90702"]), "the breadcrumb on the way to Rethiel, then his chain");
	assert_eq!(open["closedBy"], json!({ "90701": "90700" }), "taking Tramping Paws first closes the breadcrumb");

	let taken = run(&own, &script, Opts { done: vec![1098], log: vec![1013, 90700], ..Default::default() }).remove(0);
	assert_eq!(taken["pre"], json!([90700]), "Tramping Paws in the log: the breadcrumb is closed");
	let crumb_done = run(&own, &script, Opts { done: vec![1098, 90701], ..Default::default() }).remove(0);
	assert_eq!(crumb_done["pre"], json!([90700]), "the breadcrumb done: nothing to add");
	drop(own);

	// An alternative of a `preAny` the chain did not choose is no breadcrumb, though the page lists it and it
	// is an errand to the same giver: only one of them is needed.
	c["quests"]["90702"]["pre"] = json!([]);
	c["quests"]["90702"]["preAny"] = json!([90700, 90703]);
	c["quests"]["90703"] = quest(90703, "Another Way In", 90711, json!([]), &[], &[]);
	i["forever"]["quests"]["90700"] = json!({});
	let any = pack_of(&c, &i);
	let either = run(&any, &script, Opts { done: vec![1098], ..Default::default() }).remove(0);
	assert_eq!(either["chain"], json!([90700, 90703]), "the page lists both alternatives");
	assert_eq!(either["pre"], json!([90700]), "the first alternative alone");
}

// A quest whose chain is ten quests long (#918: Alba Fairmoon's chain to The State of the Mines, Testing the
// Wells ten quests before the Deadmines quest): the plan lists every open prerequisite, the first first, and no
// "Earlier quests of this chain are not listed." note. A second branch makes it fifteen: still all of them,
// each before the quest that needs it.
#[test]
fn a_ten_quest_chain_starts_at_its_first_quest_918_testing_the_wells_before_the_state_of_the_mines() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	c["npcs"]["90510"] = json!({
		"id": 90510, "name": "Chain Giver", "level": 30, "levelMax": null, "faction": "H", "rare": false, "elite": false, "boss": false,
		"instance": null, "roles": [], "spawns": [{ "map": 1421, "x": 40, "y": 40, "f": "e" }],
	});
	let quest = |id: i32, pre: &[i32], pre_any: &[i32]| {
		json!({
			"id": id, "title": format!("Link {id}"), "level": 20, "minLevel": 10, "faction": "H", "races": null, "classes": null,
			"start": { "npc": [90510], "object": [], "item": [] }, "end": { "npc": [90510], "object": [] },
			"objectives": [{ "type": "kill", "id": 90511, "count": 1, "text": "Test Mob" }],
			"pre": pre, "zone": 1421, "rewards": [], "choices": [], "preAny": pre_any,
		})
	};
	// 90500 (Testing the Wells) .. 90509 (the dungeon quest); 90501 needs one of 90500, as The State of the
	// Mines does.
	c["quests"]["90500"] = quest(90500, &[], &[]);
	c["quests"]["90501"] = quest(90501, &[], &[90500]);
	for id in 90502..=90509 {
		c["quests"][id.to_string()] = quest(id, &[id - 1], &[]);
	}
	i["forever"]["quests"]["90509"] = json!({ "area": 209 });
	let script = k(r#"
local pre = {}
for _, t in ipairs(D.PickupPlan("{KEY}").take) do
	if t.quest.id == 90509 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
local first, cut = {}, 0
for _, s in ipairs(D.PickupGuide("{KEY}").steps) do
	for _, g in ipairs(s.goals) do
		if g.quest and g.quest >= 90500 then first[#first + 1] = g.quest; break end
	end
	if s.note and s.note:find("not listed") then cut = cut + 1 end
end
emit({ pre = pre, first = first, cut = cut })"#);
	let ten = pack_of(&c, &i);
	let open = run(&ten, &script, Opts::default()).remove(0);
	assert_eq!(open["pre"], json!((90500..=90508).collect::<Vec<_>>()), "all nine prerequisites, Testing the Wells first");
	assert_eq!(open["first"], json!((90500..=90509).collect::<Vec<_>>()), "the guide starts at the first quest of the chain");
	assert_eq!(open["cut"], 0, "nothing left out");
	let wells_done = run(&ten, &script, Opts { done: vec![1098, 90500], ..Default::default() }).remove(0);
	assert_eq!(wells_done["pre"], json!((90501..=90508).collect::<Vec<_>>()), "Testing the Wells done: the chain starts at the next quest");
	drop(ten);

	// The dungeon quest also needs 90524, the end of a second chain of five: fourteen open prerequisites.
	c["quests"]["90509"]["pre"] = json!([90508, 90524]);
	c["quests"]["90520"] = quest(90520, &[], &[]);
	for id in 90521..=90524 {
		c["quests"][id.to_string()] = quest(id, &[id - 1], &[]);
	}
	let fifteen = pack_of(&c, &i);
	let both = run(&fifteen, &script, Opts::default()).remove(0);
	let mut want: Vec<i32> = (90500..=90508).collect();
	want.extend(90520..=90524);
	assert_eq!(both["pre"], json!(want), "both chains whole, each in its order");
	assert_eq!(both["cut"], 0);
}

// #1076 (Jamemba, Dwarf Shaman 23, The Stockade): Fury in the Depths (378, level 22) needs one of The Dark
// Iron War (303, level 25). Lookup.QuestChain left a `preAny` the character is too low for out of the chain, so
// the plan took 378 with no prerequisite and sent the player to Motley Garmason, who refused it. The chain now
// keeps that prerequisite, and a quest with a prerequisite above the reach (the character's level, or the
// dungeon's lowest, 22 here) is put off as `later`, the way its own level would; with the level, it is taken
// after its prerequisite. A required (`pre`) prerequisite above the reach puts it off too.
#[test]
fn a_quest_whose_prerequisite_needs_a_higher_level_waits_till_then_1076_fury_in_the_depths_after_the_dark_iron_war() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	c["npcs"]["90610"] = json!({
		"id": 90610, "name": "Motley Garmason", "level": 30, "levelMax": null, "faction": "H", "rare": false, "elite": false, "boss": false,
		"instance": null, "roles": [], "spawns": [{ "map": 1421, "x": 40, "y": 40, "f": "e" }],
	});
	let quest = |id: i32, min: i32, pre: &[i32], pre_any: &[i32]| {
		json!({
			"id": id, "title": format!("Quest {id}"), "level": min + 3, "minLevel": min, "faction": "H", "races": null, "classes": null,
			"start": { "npc": [90610], "object": [], "item": [] }, "end": { "npc": [90610], "object": [] },
			"objectives": [{ "type": "kill", "id": 90611, "count": 1, "text": "Dark Iron Dwarf" }],
			"pre": pre, "zone": 1421, "rewards": [], "choices": [], "preAny": pre_any,
		})
	};
	c["quests"]["90603"] = quest(90603, 25, &[], &[]);
	c["quests"]["90678"] = quest(90678, 18, &[], &[90603]);
	i["forever"]["quests"]["90678"] = json!({ "area": 209 });
	let script = k(r#"
local plan = D.PickupPlan("{KEY}")
local take, pre = {}, {}
for _, t in ipairs(plan.take) do
	take[#take + 1] = t.quest.id
	if t.quest.id == 90678 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
table.sort(take)
local chain = {}
for n, q in ipairs(Polestar.Lookup.QuestChain(90678, Polestar.Lookup.PlayerInfo())) do chain[n] = q.id end
emit({ take = take, pre = pre, later = plan.later, chain = chain })"#);
	let any = pack_of(&c, &i);
	let low = run(&any, &script, Opts::default()).remove(0);
	assert_eq!(low["chain"], json!([90603, 90678]), "the prerequisite it is too low for stays in the chain");
	assert!(!takes(&low, 90678), "not taken at 21 (dungeon's lowest 22) while its prerequisite needs 25: {}", low["take"]);
	assert_eq!(low["later"], json!(1), "counted for later");
	let high = run(&any, &script, Opts { level: 25, ..Default::default() }).remove(0);
	assert!(takes(&high, 90678), "taken at 25: {}", high["take"]);
	assert_eq!(high["pre"], json!([90603]), "after The Dark Iron War");
	drop(any);

	c["quests"]["90678"]["preAny"] = json!([]);
	c["quests"]["90678"]["pre"] = json!([90603]);
	let all = pack_of(&c, &i);
	let required = run(&all, &script, Opts::default()).remove(0);
	assert!(!takes(&required, 90678), "a required prerequisite above the reach puts it off too: {}", required["take"]);
	assert_eq!(required["later"], json!(1));
}

// The dungeon sweep (2026-11-08): the Stockade pick-up guide of an Alliance character who had not run the
// Deadmines sent them to "accept" The Unsent Letter (373), which only Edwin VanCleef's drop starts, before Bazil
// Thredd (389); Scholomance's and Stratholme's left bare "First do the quest Finkle Einhorn, At Your Service!"
// notes (a giver inside Blackrock Spire) before quests nobody offers without it. A quest with a prerequisite
// the guide cannot start out here (an item not in the bags, a giver or turn-in with no place) is not taken
// before the run, nor counted as opening at a later level; with the item in the bags it is taken after it.
#[test]
fn a_quest_whose_prerequisite_starts_from_an_item_the_character_lacks_or_has_no_placed_giver_waits_the_unsent_letter_before_bazil_thredd() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	let npc = |id: i32, name: &str, spawns: Value| {
		json!({ "id": id, "name": name, "level": 30, "levelMax": null, "faction": "H", "rare": false, "elite": false, "boss": false,
			"instance": null, "roles": [], "spawns": spawns })
	};
	c["npcs"]["90710"] = npc(90710, "Baros Alexston", json!([{ "map": 1421, "x": 40, "y": 40, "f": "e" }]));
	c["npcs"]["90712"] = npc(90712, "Pip Quickwit", json!([]));
	let quest = |id: i32, giver: Value, item: Value, pre_any: &[i32]| {
		json!({
			"id": id, "title": format!("Quest {id}"), "level": 22, "minLevel": 18, "faction": "H", "races": null, "classes": null,
			"start": { "npc": giver, "object": [], "item": item }, "end": { "npc": [90710], "object": [] },
			"objectives": [], "pre": [], "zone": 1421, "rewards": [], "choices": [], "preAny": pre_any,
		})
	};
	c["quests"]["90713"] = quest(90713, json!([]), json!([90711]), &[]);
	c["quests"]["90714"] = quest(90714, json!([90710]), json!([]), &[90713]);
	c["quests"]["90715"] = quest(90715, json!([90712]), json!([]), &[]);
	c["quests"]["90716"] = quest(90716, json!([90710]), json!([]), &[90715]);
	i["forever"]["quests"]["90714"] = json!({ "area": 209 });
	i["forever"]["quests"]["90716"] = json!({ "area": 209 });
	let pack = pack_of(&c, &i);
	let script = |before: &str| {
		k(&format!(
			r#"{before}
local plan = D.PickupPlan("{{KEY}}")
local take, pre, accepts = {{}}, {{}}, {{}}
for _, t in ipairs(plan.take) do
	take[#take + 1] = t.quest.id
	if t.quest.id == 90714 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
table.sort(take)
for _, s in ipairs(D.PickupGuide("{{KEY}}").steps) do
	for _, g in ipairs(s.goals) do if g.t == "accept" or g.t == "note" then accepts[#accepts + 1] = g.t .. ":" .. tostring(g.quest or g.text) end end
end
emit({{ take = take, pre = pre, later = plan.later, accepts = table.concat(accepts, " ") }})"#
		))
	};
	let lacks = run(&pack, &script(""), Opts::default()).remove(0);
	assert!(!takes(&lacks, 90714), "not taken without the letter: {}", lacks["take"]);
	assert!(!takes(&lacks, 90716), "not taken while its prerequisite's giver has no place: {}", lacks["take"]);
	let carries = run(&pack, &script("stub.world.addItem(90711, 1)"), Opts::default()).remove(0);
	assert_eq!(lacks["later"], carries["later"], "neither counted as opening at a later level");
	let steps = js(&lacks["accepts"]);
	assert!(!steps.contains("accept:90713") && !steps.contains("First do the quest"), "no accept from an item the character lacks, no bare note: {steps}");
	assert!(takes(&carries, 90714), "taken with the letter in the bags: {}", carries["take"]);
	assert_eq!(carries["pre"], json!([90713]), "after the quest the letter starts");
}

// The dungeon sweep (2026-11-08): Gnomeregan's Alliance pick-up guide sent a Stormwind player to Stonetalon for
// Castpipe's Task and to Darnassus for Klockmort's Essentials, breadcrumbs to Ironforge quests it took anyway;
// the Excavation Site's to Ashenvale for Seeking Caitlin. A breadcrumb (no objectives, required by no quest of
// the plan, turned in where a quest the plan takes is given) is left out when its giver is on a continent no
// other stop is on, or its detour (the cheapest insertion on the way to its target, from the player, the
// entrance or another stop) is over 300 seconds; one on the way stays, and so does one a quest requires.
// Fixture: a Mage (no Barrens class quest) in the Undercity; the target Down in the Keep (90810) and Lost Letters
// (90815) are given by Hadrec in Silverpine. Breadcrumbs to him: Word from the Barrens (90811, Barrens: another
// continent), Word from the Undercity (90812, next to the player), Word from Hillsbrad (90813, a zone further:
// 400 s from Silverpine); Hillsbrad Orders (90814, Hillsbrad) is one Lost Letters requires.
const CRUMB_TRAVEL: &str = r#"
local ZONES = { [1458] = "uc", [1421] = "sp", [1413] = "b", [1424] = "hb" }
local COST = { ["uc-sp"] = 120, ["uc-b"] = 250, ["sp-b"] = 370, ["sp-hb"] = 400, ["uc-hb"] = 450, ["b-hb"] = 700 }
Polestar.TravelCost = function(a, b)
	local za, zb = ZONES[a.map], ZONES[b.map]
	if not (za and zb) then return nil end
	if za == zb then return 20 + math.abs(a.x - b.x) + math.abs(a.y - b.y) end
	return COST[za .. "-" .. zb] or COST[zb .. "-" .. za]
end"#;

#[test]
fn a_breadcrumb_on_another_continent_or_a_long_detour_is_left_out_one_on_the_way_or_required_stays_gnomeregan_s_castpipe_s_task() {
	let (codex, inputs) = fixture_parts();
	let mut c = codex.clone();
	let mut i = inputs.clone();
	c["frames"]["1424"] = json!({ "c": 0, "left": 1066.667, "right": -2133.333, "top": 400, "bottom": -1733.333 });
	c["zones"]["1424"] = json!({ "id": 1424, "name": "Hillsbrad Foothills" });
	let npc = |id: i32, name: &str, map: i32, x: i32, y: i32| {
		json!({ "id": id, "name": name, "level": 30, "levelMax": null, "faction": "H", "rare": false, "elite": false, "boss": false,
			"instance": null, "roles": [], "spawns": [{ "map": map, "x": x, "y": y, "f": "e" }] })
	};
	c["npcs"]["90802"] = npc(90802, "Barrens Runner", 1413, 90, 90);
	c["npcs"]["90803"] = npc(90803, "Undercity Runner", 1458, 66, 44);
	c["npcs"]["90804"] = npc(90804, "Hillsbrad Runner", 1424, 60, 20);
	let quest = |id: i32, title: &str, giver: i32, kill: bool, pre: &[i32]| {
		json!({
			"id": id, "title": title, "level": 22, "minLevel": 18, "faction": "H", "races": null, "classes": null,
			"start": { "npc": [giver], "object": [], "item": [] }, "end": { "npc": [1952], "object": [] },
			"objectives": if kill { json!([{ "type": "kill", "id": 90899, "count": 1, "text": "Worgen" }]) } else { json!([]) },
			"pre": pre, "zone": 1421, "rewards": [], "choices": [], "preAny": [],
		})
	};
	c["quests"]["90810"] = quest(90810, "Down in the Keep", 1952, true, &[]);
	c["quests"]["90811"] = quest(90811, "Word from the Barrens", 90802, false, &[]);
	c["quests"]["90812"] = quest(90812, "Word from the Undercity", 90803, false, &[]);
	c["quests"]["90813"] = quest(90813, "Word from Hillsbrad", 90804, false, &[]);
	for id in ["90810", "90811", "90812", "90813"] {
		i["forever"]["quests"][id] = json!({ "area": 209 });
	}
	let pack = pack_of(&c, &i);
	let script = k(&format!(
		r#"{CRUMB_TRAVEL}
local plan = D.PickupPlan("{{KEY}}")
local take, pre, crumbs = {{}}, {{}}, {{}}
for _, t in ipairs(plan.take) do
	take[#take + 1] = t.quest.id
	if t.quest.id == 90815 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
table.sort(take)
for _, b in ipairs(plan.breadcrumbs or {{}}) do crumbs[tostring(b.id)] = {{ far = b.far, taken = b.taken, detour = b.detour and math.floor(b.detour) or false }} end
local accepts = {{}}
for _, s in ipairs(D.PickupGuide("{{KEY}}").steps) do
	for _, g in ipairs(s.goals) do if g.t == "accept" then accepts[#accepts + 1] = g.quest end end
end
table.sort(accepts)
emit({{ take = take, pre = pre, crumbs = crumbs, accepts = accepts }})"#
	));
	let uc = run(&pack, &script, Opts { cls: "MAGE", ..Default::default() }).remove(0);
	let show = serde_json::to_string(&uc).unwrap();
	assert!(takes(&uc, 90810), "the target is taken straight from Hadrec: {show}");
	assert_eq!(uc["crumbs"]["90811"]["far"], true, "the Barrens breadcrumb is on another continent: {show}");
	assert!(!takes(&uc, 90811), "left out: {show}");
	assert!(uc["crumbs"]["90813"]["detour"].as_i64().unwrap_or(0) > 300, "Hillsbrad is a detour over 300 s: {show}");
	assert!(!takes(&uc, 90813), "left out: {show}");
	assert!(uc["crumbs"]["90812"]["detour"].as_i64().unwrap_or(9999) <= 300, "the Undercity one is on the way: {show}");
	assert!(takes(&uc, 90812), "the breadcrumb next to the player stays: {show}");
	let accepts: Vec<i64> = uc["accepts"].as_array().unwrap().iter().filter_map(Value::as_i64).collect();
	assert!(!accepts.contains(&90811) && !accepts.contains(&90813), "no accept of a left-out breadcrumb: {show}");
	// From Hillsbrad, Word from Hillsbrad is on the way out: it stays.
	let hb = run(&pack, &script, Opts { cls: "MAGE", at: Some([1424, 60, 21]), ..Default::default() }).remove(0);
	assert!(takes(&hb, 90813), "taken by a player standing beside its giver: {}", serde_json::to_string(&hb).unwrap());
	// #1402 (Geekmandem at Stonetalon Peak, Castpipe's Task 200 s out of his way): a breadcrumb that crosses the
	// sea to its target is taken only from the town of its giver (150 s). From beside the Barrens Runner, Word
	// from the Barrens stays; from the zone's far corner it is 190 s out of the way, under 300 s, and left out.
	let beside = run(&pack, &script, Opts { cls: "MAGE", at: Some([1413, 90, 95]), ..Default::default() }).remove(0);
	let show = serde_json::to_string(&beside).unwrap();
	assert_eq!(beside["crumbs"]["90811"]["far"], false, "the player is on its continent: {show}");
	assert!(beside["crumbs"]["90811"]["detour"].as_i64().unwrap_or(9999) <= 150, "beside the player: {show}");
	assert!(takes(&beside, 90811), "taken from beside its giver: {show}");
	let corner = run(&pack, &script, Opts { cls: "MAGE", at: Some([1413, 5, 5]), ..Default::default() }).remove(0);
	let show = serde_json::to_string(&corner).unwrap();
	let detour = corner["crumbs"]["90811"]["detour"].as_i64().unwrap_or(0);
	assert!(detour > 150 && detour <= 300, "a detour the 300 s rule would keep: {show}");
	assert!(!takes(&corner, 90811), "left out: it crosses the sea for a quest Hadrec gives anyway: {show}");
	assert!(takes(&corner, 90810), "the target still taken: {show}");
	drop(pack);
	// Lost Letters (90815, Hadrec) requires Hillsbrad Orders (90814, Hillsbrad): a required errand stays however
	// far, and Word from Hillsbrad, beside it, is then on the way too.
	c["quests"]["90814"] = quest(90814, "Hillsbrad Orders", 90804, false, &[]);
	c["quests"]["90815"] = quest(90815, "Lost Letters", 1952, true, &[90814]);
	i["forever"]["quests"]["90815"] = json!({ "area": 209 });
	let both = pack_of(&c, &i);
	let req = run(&both, &script, Opts { cls: "MAGE", ..Default::default() }).remove(0);
	let show = serde_json::to_string(&req).unwrap();
	assert!(takes(&req, 90815), "Lost Letters taken: {show}");
	assert_eq!(req["pre"], json!([90814]), "after the required Hillsbrad Orders: {show}");
	assert!(takes(&req, 90813), "Word from Hillsbrad rides along with it: {show}");
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
	assert_eq!(out["note"], "Not finished yet: “The Book of Ur”");
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
	assert_eq!(out, json!({ "id": false, "why": "nothing", "guide": false, "same": true, "text": "Not finished yet: “The Book of Ur”." }));
}

#[test]
fn handin_takes_the_place_of_the_pick_up_guide_once_that_one_is_at_the_entrance_comes_back_after_reload_and_plays_to_the_end() {
	let pack = default_pack();
	let opts = || Opts { done: vec![1098, 1740, 1011, 1014], log: vec![], ready: vec![1013], ..Default::default() };
	let script = k(r#"
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

// A dungeon with a way in for each faction (the City of Dalaran, #706): the page, the arrow and the pick-up
// guide's last step (all from Dungeons.Get, over the Codex pack's decoder) use the character's own.
#[test]
fn a_dungeon_with_a_way_in_for_each_faction_the_page_and_the_arrow_lead_to_the_character_s_own_the_guide_ends_there() {
	let (mut codex, inputs) = fixture_parts();
	codex["instances"][KEY]["entrance"]["A"] = json!({ "map": 1421, "x": 50, "y": 60 });
	let sides = pack_of(&codex, &inputs);
	let enter = k(r#"local d, def = D.Get("{KEY}"), D.PickupGuide("{KEY}")
local at
for _, g in ipairs(def and def.steps[#def.steps].goals or {}) do if g.t == "goto" then at = { g.map, g.x, g.y } end end
emit({ page = { d.entrance.map, d.entrance.x, d.entrance.y }, arrow = { D.Entrance("{KEY}") }, guide = at })"#);
	let horde = run(&sides, &enter, Opts::default()).remove(0);
	assert_eq!(horde, json!({ "page": [1421, 44.8, 67.8], "arrow": [1421, 44.8, 67.8, "e"], "guide": [1421, 44.8, 67.8] }), "the Horde: the one way in");
	let alliance = run(&sides, &enter, Opts { race: "Human", faction: "Alliance", cls: "PALADIN", done: vec![], log: vec![], ..Default::default() }).remove(0);
	assert_eq!(json!([alliance["page"], alliance["arrow"]]), json!([[1421, 50, 60], [1421, 50, 60]]), "the Alliance: its own");
}

// #1328: with six tabs open, a Dungeons guide (Lookup.Guide) used to take the active tab's place, often the
// leveling guide, though its buttons say it opens in a new tab and every caller has a "Six tabs is the limit"
// line for this. It is refused now and no tab changes; a hand-in still takes the tab of a pick-up guide at its
// last step, whichever tab is active.
const SIX_TABS: &str = r#"
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
for i = 1, 6 do
	Polestar.RegisterGuide({ id = "test/f" .. i, pack = "test", title = "Filler " .. i, minLevel = 1, maxLevel = 60, steps = { { goals = { { t = "level", level = 60 } } } } })
end
local E = Polestar.Engine
while #E.GetTabs() > 0 do E.CloseTab(1) end
"#;

#[test]
fn with_six_tabs_open_a_dungeon_guide_never_takes_the_active_tab_a_hand_in_still_takes_the_finished_pick_up_s_tab() {
	let pack = default_pack();
	let refused = run(
		&pack,
		&(SIX_TABS.to_string()
			+ &k(r#"
for i = 1, 6 do E.OpenTab("test/f" .. i, false) end
E.SelectTab(1)
local id, why = D.PickUp("{KEY}")
emit({ id = id or false, why = why or false, tabs = tabIds(), active = E.GetGuide().id })"#)),
		Opts::default(),
	)
	.remove(0);
	assert_eq!(refused, json!({ "id": false, "why": "tabs", "tabs": ["test/f1", "test/f2", "test/f3", "test/f4", "test/f5", "test/f6"], "active": "test/f1" }));

	let opts = Opts { done: vec![1098, 1740, 1011, 1014], log: vec![], ready: vec![1013], ..Default::default() };
	let handed = run(
		&pack,
		&(SIX_TABS.to_string()
			+ &k(r#"
D.PickUp("{KEY}")
for i = 1, 5 do E.OpenTab("test/f" .. i, false) end
E.SelectTab(3)
stub.world.accept(1016, { 1 })
stub.advance(0.6)
local id, why = D.HandIn("{KEY}")
emit({ id = id or false, why = why or false, tabs = tabIds(), active = E.GetGuide().id })"#)),
		opts,
	)
	.remove(0);
	assert_eq!(
		handed,
		json!({
			"id": "lookup/handin/shadowfang-keep",
			"why": false,
			"tabs": ["lookup/handin/shadowfang-keep", "test/f1", "test/f2", "test/f3", "test/f4", "test/f5"],
			"active": "lookup/handin/shadowfang-keep",
		})
	);
}
