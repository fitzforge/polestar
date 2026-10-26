//! Guides Lookup builds on the spot (Lookup.Guide) are played to the end in the real engine with the shared
//! guide simulator (tools/lib/playtest.js): a vendor mount, a drop, a treasure, a dungeon drop, a quest reward
//! behind a prerequisite chain, a craft, a reputation reward, and the NPC, quest and dungeon kinds. Every one
//! must finish without a stuck step and without an accept or turn-in that has no location.
//!
//! The Codex is the synthetic tests/fixtures/codex/lookup.json. With data/forever/map-frames.json present its
//! three maps are moved onto real maps with their Era frames (Elwynn Forest, Westfall, Teldrassil); without it
//! the fixture's own synthetic frames are used.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::playtest::SIMULATE;
use forge_addontest::run::root;
use forge_addontest::{emitted, lua_value, truthy, RunAddon};
use serde_json::{json, Map, Value};

const REAL: [(i64, i64); 3] = [(9001, 1429), (9002, 1436), (9003, 1438)];

// #610: a mob spawning at three places far apart, near the giver and across the map.
const CREEPERS: [(i64, i64); 3] = [(50, 52), (20, 70), (24, 78)];

fn moved(id: i64) -> i64 {
	REAL.iter().find(|(k, _)| *k == id).map_or(id, |(_, v)| *v)
}

fn walk(v: &mut Value) {
	match v {
		Value::Array(a) => a.iter_mut().for_each(walk),
		Value::Object(o) => {
			if let Some(m) = o.get("map").and_then(Value::as_i64) {
				o.insert("map".into(), json!(moved(m)));
			}
			o.values_mut().for_each(walk);
		}
		_ => {}
	}
}

// The fixture, with its maps moved onto real ones when their frames exist.
fn load_codex() -> Value {
	let mut codex = fixture("lookup.json");
	let frames_file = root().join("data/forever/map-frames.json");
	let era = if frames_file.exists() {
		let v: Value = serde_json::from_str(&std::fs::read_to_string(&frames_file).unwrap()).unwrap();
		v["era"].clone()
	} else {
		Value::Null
	};
	if !truthy(&era) || !REAL.iter().all(|(_, id)| truthy(&era[id.to_string().as_str()])) {
		return codex;
	}
	walk(&mut codex["npcs"]);
	walk(&mut codex["objects"]);
	walk(&mut codex["instances"]);
	walk(&mut codex["quests"]);
	for q in codex["quests"].as_object_mut().unwrap().values_mut() {
		if let Some(z) = q["zone"].as_i64() {
			q["zone"] = json!(moved(z));
		}
	}
	let keys: Vec<i64> = codex["frames"].as_object().unwrap().keys().map(|k| k.parse().unwrap()).collect();
	let mut frames = Map::new();
	for id in keys {
		let m = moved(id);
		frames.insert(m.to_string(), era[m.to_string().as_str()].clone());
	}
	codex["frames"] = Value::Object(frames);
	let mut zones = Map::new();
	for z in codex["zones"].as_object().unwrap().values() {
		let m = moved(z["id"].as_i64().unwrap());
		zones.insert(m.to_string(), json!({ "id": m, "name": z["name"].clone() }));
	}
	codex["zones"] = Value::Object(zones);
	codex
}

/// A number as JS prints it.
fn num(v: &Value) -> String {
	if let Some(i) = v.as_i64() {
		return i.to_string();
	}
	match v.as_f64() {
		Some(f) if f.fract() == 0.0 && f.abs() < 1e15 => (f as i64).to_string(),
		Some(f) => f.to_string(),
		None => v.to_string(),
	}
}

/// `${v}` of a value.
fn js_str(v: &Value) -> String {
	match v {
		Value::String(s) => s.clone(),
		Value::Number(_) => num(v),
		_ => v.to_string(),
	}
}

struct Ctx {
	codex: Value,
	home: i64,
	maps: String,
	pack: CodexPack,
}

fn ctx() -> Ctx {
	let mut codex = load_codex();
	let home = codex["frames"].as_object().unwrap().keys().map(|k| k.parse::<i64>().unwrap()).min().unwrap();
	let spawns: Vec<Value> = CREEPERS.iter().map(|(x, y)| json!({ "map": home, "x": x, "y": y, "f": "e" })).collect();
	codex["npcs"]["5014"] = json!({ "id": 5014, "name": "Marsh Creeper", "level": 19, "levelMax": 20, "faction": null, "rare": false, "elite": false, "boss": false, "instance": null, "roles": [],
		"spawns": spawns });
	codex["quests"]["7010"] = json!({ "id": 7010, "title": "Creepers in the Marsh", "level": 18, "minLevel": 15, "faction": "A", "races": null, "classes": null,
		"start": { "npc": [5008], "object": [], "item": [] }, "end": { "npc": [5008], "object": [] },
		"objectives": [{ "type": "kill", "id": 5014, "count": 6, "text": "Marsh Creeper" }], "pre": [], "preAny": [], "zone": home, "rewards": [], "choices": [] });
	let mut frames: Vec<(i64, Value)> = codex["frames"].as_object().unwrap().iter().map(|(k, f)| (k.parse::<i64>().unwrap(), f.clone())).collect();
	frames.sort_by_key(|(id, _)| *id);
	let maps = frames
		.iter()
		.map(|(id, f)| {
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&codex["zones"][id.to_string().as_str()]["name"]).unwrap(),
				num(&f["c"]),
				num(&f["left"]),
				num(&f["right"]),
				num(&f["top"]),
				num(&f["bottom"])
			)
		})
		.collect::<Vec<_>>()
		.join("\n");
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	Ctx { codex, home, maps, pack }
}

/// The `before` of a run: the codex pack, the maps, then `tail`.
fn world(c: &Ctx, tail: &str) -> String {
	format!("{}\nlocal w = stub.world\n{}\n", c.pack.stub_lua, c.maps) + tail
}

const PLAY: &str = r#"
stub.login()
Polestar.Set("behavior.autoNextGuide", false)
local id, why = Polestar.Lookup.Guide(@KIND@, @ID@)
local g = id and Polestar.Guides.Get(id)
local steps = {}
if g then
	for i, s in ipairs(g.steps) do
		local verbs = {}
		for j, goal in ipairs(s.goals) do verbs[j] = goal.t end
		steps[i] = { title = s.title, goals = table.concat(verbs, " ") }
	end
end
emit({ id = id or false, why = why or false, active = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false, steps = steps })
stub.advance(0.6)
"#;

// Builds and opens the guide, describes it, then plays it to the end.
fn play(c: &Ctx, kind: &str, id: &Value, level: i64, setup: &str) -> (Value, Value) {
	let mut out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: world(c, &format!("w.level = {level}\nw.moveTo({}, 50, 50)\n{setup}", c.home)),
		addons: vec!["Polestar".into()],
		script: PLAY.replace("@KIND@", &lua_value(&json!(kind))).replace("@ID@", &lua_value(id)) + SIMULATE,
		..Default::default()
	});
	let built = out.remove(0);
	let run = out.remove(0);
	(built, run)
}

fn assert_plays(c: &Ctx, kind: &str, id: impl Into<Value>, steps: Value, setup: &str) {
	let id: Value = id.into();
	let (built, out) = play(c, kind, &id, 20, setup);
	let gid = format!("lookup/{kind}/{}", js_str(&id));
	assert_eq!(json!({ "id": built["id"], "active": built["active"] }), json!({ "id": gid, "active": gid }), "guide built ({})", js_str(&built["why"]));
	assert_eq!(built["steps"], steps);
	assert!(!truthy(&out["stuck"]), "stuck: {}", out["stuck"]);
	assert_eq!(out["done"], true);
	assert_eq!(out["missing"], json!({}), "every accept and turn-in has a location");
	assert_eq!(out["visited"], steps.as_array().unwrap().len() as i64);
}

#[test]
fn a_vendor_mount_go_to_the_vendor_and_buy_it() {
	let c = ctx();
	assert_plays(&c, "mount", 8000, json!([{ "title": "Mira Saddler", "goals": "goto buy" }]), "");
}

#[test]
fn a_drop_go_to_the_mob_kill_it_loot_the_item() {
	let c = ctx();
	assert_plays(&c, "item", 8004, json!([{ "title": "Bristle Boar", "goals": "goto kill collect" }]), "");
}

#[test]
fn a_treasure_go_to_the_chest_and_loot_it() {
	let c = ctx();
	assert_plays(&c, "item", 8009, json!([{ "title": "Weathered Chest", "goals": "goto interact collect" }]), "");
}

#[test]
fn a_dungeon_drop_the_entrance_first_then_the_boss() {
	let c = ctx();
	assert_plays(
		&c,
		"item",
		8008,
		json!([
			{ "title": "Ashen Crypt", "goals": "goto" },
			{ "title": "Lord Ashcroft", "goals": "kill collect" },
		]),
		"",
	);
}

#[test]
fn a_quest_reward_every_prerequisite_one_of_the_any_of_ones_this_character_can_take_then_the_quest() {
	let c = ctx();
	assert_plays(
		&c,
		"item",
		8001,
		json!([
			{ "title": "Trouble in the Vale", "goals": "accept kill collect turnin" },
			{ "title": "Alliance Errand", "goals": "accept turnin" },
			{ "title": "The Saddler's Request", "goals": "accept interact complete turnin collect" },
		]),
		"",
	);
	// Finished prerequisites are left out.
	assert_plays(
		&c,
		"item",
		8001,
		json!([
			{ "title": "Alliance Errand", "goals": "accept turnin" },
			{ "title": "The Saddler's Request", "goals": "accept interact complete turnin collect" },
		]),
		"w.complete({ 7001 })",
	);
}

#[test]
fn an_event_objective_explore_report_is_placed_where_the_data_puts_it_not_at_the_giver_515() {
	let c = ctx();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: world(&c, &format!("w.level = 20\nw.moveTo({}, 50, 50)", c.home)),
		addons: vec!["Polestar".into()],
		script: r#"
stub.login()
local id = Polestar.Lookup.Guide("item", 8001)
for _, s in ipairs(Polestar.Guides.Get(id).steps) do
	for _, g in ipairs(s.goals) do
		if g.t == "complete" and g.quest == 7002 then emit({ map = g.map or false, x = g.x or false, y = g.y or false, f = g.f or false }) end
	end
end"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "map": c.codex["quests"]["7002"]["objectives"][1]["map"].clone(), "x": 66, "y": 40, "f": "e" }));
}

#[test]
fn a_beast_to_tame_taming_the_beast_reads_tame_not_kill_and_still_plays_565() {
	let c = ctx();
	assert_plays(&c, "quest", 7009, json!([{ "title": "Taming the Beast", "goals": "accept kill turnin" }]), "");
	let texts = |quest: i64| {
		json!(emitted(&RunAddon {
			stubs: vec!["stub_world.lua"],
			before: world(&c, &format!("w.level = 20\nw.moveTo({}, 50, 50)", c.home)),
			addons: vec!["Polestar".into()],
			script: r#"
stub.login()
Polestar.Set("behavior.autoNextGuide", false)
Polestar.Lookup.Guide("quest", @QUEST@)
local view = Polestar.Engine.GetStepView(1)
for _, g in ipairs(view.goals) do
	if g.t == "kill" then emit(g.text) end
end"#
				.replace("@QUEST@", &quest.to_string()),
			..Default::default()
		}))
	};
	assert_eq!(texts(7009), json!(["Tame Bristle Boar"]));
	assert_eq!(texts(7001), json!(["Kill Kobold Digger"]), "a plain kill objective still reads \"Kill\"");
}

#[test]
fn a_craft_learn_the_profession_at_its_trainer_skill_up_learn_the_recipe_craft() {
	let c = ctx();
	assert_plays(&c, "item", 8005, json!([{ "title": "Tailoring", "goals": "train skill learn craft" }]), "");
	assert_plays(&c, "item", 8005, json!([{ "title": "Tailoring", "goals": "learn craft" }]), r#"w.learnSkill(197, "Tailoring", 120, 150)"#);
}

#[test]
fn a_reputation_reward_reach_the_standing_then_buy_it_from_the_quartermaster() {
	let c = ctx();
	assert_plays(
		&c,
		"tabard",
		8006,
		json!([
			{ "title": "Vale Wardens", "goals": "rep" },
			{ "title": "Quartermaster Ilsa", "goals": "goto buy" },
		]),
		"",
	);
}

#[test]
fn a_vendor_item_behind_a_standing_or_a_skill_rank_reach_it_first_then_buy() {
	let c = ctx();
	assert_plays(
		&c,
		"mount",
		8016,
		json!([
			{ "title": "Vale Wardens", "goals": "rep" },
			{ "title": "Quartermaster Ilsa", "goals": "goto buy" },
		]),
		"",
	);
	assert_plays(
		&c,
		"recipe",
		8017,
		json!([
			{ "title": "Tailoring", "goals": "skill" },
			{ "title": "Mira Saddler", "goals": "goto buy" },
		]),
		r#"w.learnSkill(197, "Tailoring", 60, 150)"#,
	);
}

#[test]
fn npc_quest_and_dungeon_lookups_lead_there() {
	let c = ctx();
	assert_plays(&c, "rare", 5011, json!([{ "title": "Gnash the Unseen", "goals": "goto kill" }]), "");
	assert_plays(&c, "quest", 7001, json!([{ "title": "Trouble in the Vale", "goals": "accept kill collect turnin" }]), "");
	assert_plays(&c, "instance", "ashen_crypt", json!([{ "title": "Ashen Crypt", "goals": "goto" }]), "");
}

// Tazul (#610): a Lookup quest step sent the arrow for a kill objective to the one spawn nearest the giver,
// with no other places to move on to, while most of the mobs were elsewhere. Its kill, collect and interact
// goals now carry every Codex spawn of the target as spawn areas (`spots`), as compiled guide goals do, so the
// arrow takes the place where the player is.
#[test]
fn tazul_s_report_610_a_lookup_quest_objective_lists_every_place_its_mob_spawns_and_the_arrow_takes_the_one_the_player_is_at() {
	let c = ctx();
	let tail = String::from("w.level = 20\n") + r#"w.onQuest(7010, { { text = "Marsh Creeper slain: 0/6", required = 6 } }, "Creepers in the Marsh")"# + &format!("\nw.moveTo({}, 21, 71)", c.home);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: world(&c, &tail),
		addons: vec!["Polestar".into()],
		script: r#"
stub.login()
Polestar.Set("behavior.autoNextGuide", false)
local id = Polestar.Lookup.Guide("quest", 7010)
local kill
for _, s in ipairs(Polestar.Guides.Get(id).steps) do
	for _, g in ipairs(s.goals) do
		if g.t == "kill" and g.npc == 5014 then kill = g end
	end
end
stub.advance(0.6)
local p = Polestar.Engine.GetWaypoint()
local spots = {}
for i, s in ipairs(kill.spots or {}) do spots[i] = { x = s.x, y = s.y } end
emit({ x = kill.x, y = kill.y, spread = kill.spread or false, spots = spots, arrow = p and { kind = p.kind, x = p.x, y = p.y } or false })"#
			.into(),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(json!({ "x": out["x"], "y": out["y"] }), json!({ "x": 50, "y": 52 }), "the goal keeps the spawn nearest the giver as its point");
	let key = |v: &Value| format!("{},{}", js_str(&v["x"]), js_str(&v["y"]));
	// an empty Lua table comes back as {}
	let spots: Vec<Value> = out["spots"].as_array().cloned().unwrap_or_default();
	let mut got: Vec<String> = spots.iter().map(key).collect();
	got.sort();
	let mut want: Vec<String> = CREEPERS.iter().map(|(x, y)| format!("{x},{y}")).collect();
	want.sort();
	assert_eq!(got, want, "every place the mob spawns is a spot");
	assert_eq!(spots.first().map(key).unwrap_or_default(), "50,52", "the search starts at the goal point");
	assert_eq!(out["spread"], true, "places this far apart are searched one after another");
	assert_eq!(out["arrow"], json!({ "kind": "kill", "x": 20, "y": 70 }), "the arrow takes the place the player stands at");
}
