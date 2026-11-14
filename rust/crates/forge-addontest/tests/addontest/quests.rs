//! Polestar.QuestDB at runtime (addon/Polestar/Quests) on a database built by
//! `forge data questdb` from tests/fixtures/questdb: load-on-demand, lookups,
//! available-quest filtering (prerequisites, level, race, class, faction,
//! exclusive groups, holidays), objective and turn-in markers through the
//! Pins contract, tooltip lines, nameplate icons, and that an unchanged quest
//! log costs no rebuild.

use forge_addontest::questdb::{build_db, data_with, fixture_dir, QuestDb, FILES};
use forge_addontest::run::root;
use forge_addontest::{emitted, lua_string, truthy, Addon, RunAddon};
use serde_json::{json, Value};

// The map marker layers are off by default; these tests exercise them, so the
// default saved profile turns them on.
const MARKERS_ON: &str = "PolestarDB = { schema = 1, settings = { qol = { mapObjectives = true, minimapObjectives = true, turnInMarkers = true, availableQuests = true } } }";

const BEFORE: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 40)
for q, t in pairs({ [7] = "Kobold Camp Cleanup", [18] = "Gathering Wood", [33] = "Wolves Across the Border", [60] = "Kobold Candles" }) do w.titles[q] = t end
"#;

const PRELUDE: &str = r#"
local w, sq, Q = stub.world, stub.quests, Polestar.QuestDB
sq.installPins()
stub.login()
stub.advance(0.3)
local function layer(name) local l = sq.pins.layers[name]; return l and l.pins or {} end
local function kinds(name)
	local out = {}
	for _, p in ipairs(layer(name)) do out[#out + 1] = p.header .. "@" .. p.x .. "," .. p.y .. ":" .. p.icon end
	table.sort(out)
	return out
end
"#;

fn fixture() -> QuestDb {
	build_db(&fixture_dir())
}

// Loads the full addon with the fake Pins installed on `db`, logs in, runs `script`.
fn run_saved(db: &QuestDb, script: &str, setup: &str, saved: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua"],
		before: format!("stub.quests.dbFiles = {}\n{BEFORE}{setup}", db.lua_files()),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), saved.into())],
		script: format!("{PRELUDE}{script}"),
		..Default::default()
	})
}

fn run(db: &QuestDb, script: &str, setup: &str) -> Vec<Value> {
	run_saved(db, script, setup, MARKERS_ON)
}

// An emitted Lua list (an empty table is emitted as `{}`).
fn arr(v: &Value) -> Vec<Value> {
	match v {
		Value::Array(a) => a.clone(),
		Value::Object(o) if o.is_empty() => Vec::new(),
		_ => panic!("not a list: {v}"),
	}
}

fn has(list: &Value, q: i64) -> bool {
	arr(list).iter().any(|v| v.as_i64() == Some(q))
}

#[test]
fn loads_the_database_at_login_and_answers_lookups() {
	let db = fixture();
	let out = run(
		&db,
		r#"
emit({ Q.IsLoaded(), sq.loadCalls })
emit(Q.GetQuest(7))
emit(Q.GetNpc(6))
emit(Q.GetObjectiveMobs(60, 1))
emit(Q.GetItemDroppers(772))
emit(Q.GetItem(772))
emit(Polestar.MapFrames.era[1429])
"#,
		"",
	);
	let (loaded, q7, npc, mobs, droppers, item, frame) = (&out[0], &out[1], &out[2], &out[3], &out[4], &out[5], &out[6]);
	assert_eq!(*loaded, json!([true, 1]));
	assert_eq!(q7["title"], "Kobold Camp Cleanup");
	assert_eq!(q7["faction"], "Alliance");
	assert_eq!(q7["pre"], json!([783]));
	assert_eq!(q7["start"]["npc"], json!([197]));
	assert_eq!(q7["objectives"], json!([{ "kind": "kill", "id": 6, "count": 10 }]));
	assert_eq!(npc["name"], "Kobold Vermin");
	assert_eq!(arr(&npc["spawns"]).len(), 3, "two camps east and one far camp, one cluster each");
	assert!(arr(&npc["spawns"]).iter().all(|s| s["map"] == 1429 && s["f"] == "e" && s["r"].as_f64().is_some_and(|r| r >= 0.0)));
	assert_eq!(*mobs, json!(["Kobold Vermin", "Kobold Miner"]), "droppers, best chance first");
	let pairs: Vec<Value> = arr(droppers).iter().map(|d| json!([d["id"], d["chance"]])).collect();
	assert_eq!(Value::Array(pairs), json!([[6, 40], [40, 20.5]]));
	assert_eq!(item["objects"], json!([{ "id": 77, "name": "Candle Crate", "chance": 100 }]));
	assert_eq!(item["vendors"], json!([{ "id": 253, "name": "William Pestle" }]));
	assert_eq!(*frame, json!({ "c": 0, "left": 1500, "right": -1500, "top": 500, "bottom": -1500 }));
}

#[test]
fn handsover_answers_from_the_quest_s_handed_over_items_a_record_without_them_an_older_database_or_an_unknown_quest_says_no_without_an_error() {
	let db = fixture();
	let out = run(&db, "emit({ Q.HandsOver(19, 772), Q.HandsOver(19, 900), Q.HandsOver(19, 1), Q.HandsOver(7, 772), Q.HandsOver(99999, 772) })", "");
	assert_eq!(out[0], json!([true, true, false, false, false]));
}

#[test]
fn does_not_load_the_database_when_qol_questdb_is_off() {
	let db = fixture();
	let out = run_saved(
		&db,
		r#"local c = {}; for _, call in ipairs(sq.pins.calls) do if call[2]:find("^quests%.") then c[#c + 1] = call end end; emit({ Q.IsLoaded(), sq.loadCalls, Q.IsRunning(), #c })"#,
		"",
		"PolestarDB = { schema = 1, settings = { qol = { questDB = false } } }",
	);
	assert_eq!(out[0], json!([false, 0, false, 0]));
}

#[test]
fn available_quests_honour_prerequisites_level_race_class_faction_exclusive_groups_and_holidays() {
	let db = fixture();
	let out = run(
		&db,
		r#"
emit(Q.GetAvailableQuests())
w.turnIn(783)                       -- unlocks 7 (pre 783)
stub.advance(0.3)
emit(Q.GetAvailableQuests())
w.setLevel(10)                      -- 10 opens up; level <= 4 quests turn grey
stub.advance(0.3)
emit(Q.GetAvailableQuests())
Polestar.Set("qol.lowLevelQuests", true)
stub.advance(0.3)
emit(Q.GetAvailableQuests())
emit({ Q.WhyUnavailable(5), Q.WhyUnavailable(9), Q.WhyUnavailable(13), Q.WhyUnavailable(12), Q.WhyUnavailable(14), Q.WhyUnavailable(19) })
emit(kinds("quests.available"))
"#,
		"w.complete({ 15 })",
	);
	// 14 is exclusive with completed 15; 19 needs 33 or 60; 17 starts from an item.
	assert_eq!(out[0], json!([16, 18, 33, 783]), "level 1: 7 needs 783, 60 needs level 2");
	assert_eq!(out[1], json!([7, 16, 18, 33]));
	assert_eq!(out[2], json!([10]), "everything else is grey at level 10");
	assert_eq!(out[3], json!([7, 10, 16, 18, 33, 60]));
	assert_eq!(out[4], json!(["eligibility", "eligibility", "eligibility", "eligibility", "exclusive", "prerequisite"]));
	assert_eq!(
		out[5],
		json!([
			"Eagan Peltskinner@48.9,40.2:map:quest-available",
			"Marshal McBride@48.9,41.6:map:quest-available",
			"Wanted Poster@50,50:map:quest-available",
			"William Pestle@43.3,65.7:map:quest-available",
		])
	);
}

#[test]
fn prerequisites_are_any_of() {
	let db = fixture();
	let out = run(
		&db,
		r#"
emit(Q.IsAvailable(19))
w.turnIn(33)
stub.advance(0.3)
emit(Q.IsAvailable(19))
"#,
		"w.setLevel(3)",
	);
	assert_eq!(out[0], false);
	assert_eq!(out[1], true);
}

#[test]
fn a_turn_in_or_accept_rechecks_only_the_quests_it_can_unlock_or_close_and_agrees_with_a_full_scan() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local function checks(fn)
	local before = Q.stats.availableChecks
	fn()
	stub.advance(0.3)
	return Q.stats.availableChecks - before
end
emit(checks(function() w.setLevel(3) end))       -- a level-up rechecks every candidate
emit(checks(function() w.turnIn(33) end))         -- 19 needs 33
emit(checks(function() w.accept(18, {}, "Gathering Wood") end))
local incremental = Q.GetAvailableQuests()
Q.Stop(); Q.Start(); Q.Flush()
emit(table.concat(incremental, ",") == table.concat(Q.GetAvailableQuests(), ","))
"#,
		"",
	);
	let (full, turn_in, accept) = (out[0].as_i64().unwrap(), out[1].as_i64().unwrap(), out[2].as_i64().unwrap());
	assert!(full > 3, "a full scan checks every candidate ({full})");
	assert!(turn_in < full && turn_in >= 1, "turn-in: {turn_in} of {full}");
	assert!(accept < full && accept >= 1, "accept: {accept} of {full}");
	assert_eq!(out[3], true, "the incremental set equals a fresh scan");
}

#[test]
fn horde_characters_see_horde_quests_not_alliance_ones() {
	let db = fixture();
	let out = run(&db, "emit(Q.GetAvailableQuests())", r#"w.faction = "Horde"; w.race = "Orc"; w.raceName = "Orc""#);
	let list = &out[0];
	assert!(has(list, 9));
	assert!(!has(list, 783) && !has(list, 33));
	assert!(has(list, 16), "object-started quests have no faction");
}

// The fixture plus quests shaped like the QuestieDB merge: 9400 is Human-only
// (Forever mask 1), 9401 High Order Skyborne-only (2^32), 9402 an Era mask
// (pfQuest only, Human), 9403 a Horde quest for Windshaper Skyborne only
// (2^33); 9410 lists only breadcrumbs in `pre`; 9411 needs 783 and 33
// (preAll); 9412 either (preAny); 9420 is level 9 with no minimum level.
fn extra_db() -> QuestDb {
	let data = data_with(|raw| {
		let quests = raw.get_mut("quests.json").unwrap();
		let with = |base: &Value, id: i64, extra: Value| -> Value {
			let mut o = base.clone();
			o["id"] = json!(id);
			o["title"] = json!(format!("Quest {id}"));
			o["source"] = json!(["questie-forever"]);
			for (k, v) in extra.as_object().unwrap() {
				o[k] = v.clone();
			}
			o
		};
		let base = quests["783"].clone();
		let q9 = quests["9"].clone();
		let add = [
			(9400, with(&base, 9400, json!({ "races": 1 }))),
			(9401, with(&base, 9401, json!({ "races": 1i64 << 32 }))),
			(9402, with(&base, 9402, json!({ "races": 1, "source": ["pfquest"] }))),
			(9403, with(&q9, 9403, json!({ "races": 1i64 << 33 }))),
			(9410, with(&base, 9410, json!({ "pre": [9413], "breadcrumbs": [9413] }))),
			(9413, with(&base, 9413, json!({ "breadcrumbFor": 9410 }))),
			(9411, with(&base, 9411, json!({ "pre": [783, 33], "preAll": [783, 33] }))),
			(9412, with(&base, 9412, json!({ "pre": [783, 33], "preAny": [783, 33] }))),
			(9420, with(&base, 9420, json!({ "level": 9, "minLevel": 1 }))),
		];
		for (id, q) in add {
			quests[id.to_string()] = q;
		}
	});
	build_db(data.path())
}

#[test]
fn skyborne_the_race_mask_s_high_bits_decide_era_only_masks_never_exclude_it() {
	let db = extra_db();
	let check = r#"emit({ Q.WhyUnavailable(9400) or "ok", Q.WhyUnavailable(9401) or "ok", Q.WhyUnavailable(9402) or "ok", Q.WhyUnavailable(9403) or "ok" })"#;
	let sky = run(&db, check, r#"w.race = "Skyborne"; w.raceName = "High Order Skyborne""#).remove(0);
	assert_eq!(sky, json!(["eligibility", "ok", "ok", "eligibility"]), "Human-only is not for Skyborne; High Order-only is; an Era mask stays open; Horde never");
	let human = run(&db, check, "").remove(0);
	assert_eq!(human, json!(["ok", "eligibility", "ok", "eligibility"]));
	let wind = run(&db, check, r#"w.faction = "Horde"; w.race = "Skyborne"; w.raceName = "Windshaper Skyborne""#).remove(0);
	assert_eq!(wind, json!(["eligibility", "eligibility", "eligibility", "ok"]), "Windshaper (2^33) takes its own quest, not High Order's (2^32) or Alliance ones");
	let orc = run(&db, check, r#"w.faction = "Horde"; w.race = "Orc"; w.raceName = "Orc""#).remove(0);
	assert_eq!(orc[3], "eligibility", "a Skyborne-only mask excludes Era races");
	let list = run(&db, "emit(Q.GetAvailableQuests())", r#"w.race = "Skyborne"; w.raceName = "High Order Skyborne""#).remove(0);
	assert!(has(&list, 9401) && !has(&list, 9400) && !has(&list, 9403), "the giver markers follow the same filter");
}

#[test]
fn prerequisites_breadcrumbs_never_block_preall_needs_every_one_preany_one() {
	let db = extra_db();
	let out = run(
		&db,
		r#"
emit({ Q.WhyUnavailable(9410) or "ok", Q.WhyUnavailable(9411) or "ok", Q.WhyUnavailable(9412) or "ok" })
w.turnIn(783); stub.advance(0.3)
emit({ Q.WhyUnavailable(9411) or "ok", Q.WhyUnavailable(9412) or "ok" })
w.turnIn(33); stub.advance(0.3)
emit({ Q.WhyUnavailable(9411) or "ok" })
"#,
		"",
	);
	assert_eq!(out[0], json!(["ok", "prerequisite", "prerequisite"]));
	assert_eq!(out[1], json!(["prerequisite", "ok"]));
	assert_eq!(out[2], json!(["ok"]));
}

#[test]
fn objective_markers_follow_progress_and_become_a_turn_in_marker_when_ready() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
emit(kinds("quests.objectives"))
emit(sq.pinTooltip(layer("quests.objectives")[1]))
w.progress(7, 1, 4)
stub.advance(0.3)
emit(sq.pinTooltip(layer("quests.objectives")[1]))
w.progress(7, 1, 10)
stub.advance(0.3)
emit({ kinds("quests.objectives"), kinds("quests.turnin"), sq.pins.layers["quests.turnin"].opts })
w.turnIn(7)
stub.advance(0.3)
emit({ sq.pins.layers["quests.objectives"] == nil, sq.pins.layers["quests.turnin"] == nil })
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!(["Kobold Vermin@47.8,35.8:map:kill", "Kobold Vermin@50.3,35.8:map:kill", "Kobold Vermin@70.3,70.2:map:kill"]));
	assert_eq!(out[1], json!(["Kobold Vermin", "Kobold Camp Cleanup", "  Kobold Vermin: 0/10"]));
	assert_eq!(out[2], json!(["Kobold Vermin", "Kobold Camp Cleanup", "  Kobold Vermin: 4/10"]));
	let ready = &out[3];
	assert_eq!(ready[0], json!({}), "no objective markers once complete");
	assert_eq!(ready[1], json!(["Marshal McBride@48.9,41.6:map:quest-turnin"]));
	assert_eq!(ready[2], json!({ "world": true, "minimap": true, "edge": false, "scale": 1 }));
	assert_eq!(out[4], json!([true, true]));
}

// The fixture plus quests whose objective names overlap: 9500 needs Kobold
// Vermin (6) and Kobold Vermin Runt (9500), a name containing the other;
// 9501 needs 6 and 9501, a second NPC also named Kobold Vermin; 9502 the
// same two, 8 of one and 5 of the other.
fn overlap_db() -> QuestDb {
	let data = data_with(|raw| {
		let npcs = raw.get_mut("npcs.json").unwrap();
		let npc = |npcs: &Value, id: i64, name: &str, pts: Value| -> Value {
			let mut o = npcs["6"].clone();
			o["id"] = json!(id);
			o["name"] = json!(name);
			o["spawns"] = json!({ "1429": { "f": "e", "pts": pts } });
			o
		};
		let runt = npc(npcs, 9500, "Kobold Vermin Runt", json!([[20, 20], [20.4, 20.3]]));
		let other = npc(npcs, 9501, "Kobold Vermin", json!([[30, 80], [30.4, 80.3]]));
		npcs["9500"] = runt;
		npcs["9501"] = other;
		let quests = raw.get_mut("quests.json").unwrap();
		let kill = |id: i64, count: i64, text: &str| json!({ "type": "kill", "id": id, "count": count, "text": text });
		let q7 = quests["7"].clone();
		let q = |id: i64, objectives: Value| -> Value {
			let mut o = q7.clone();
			o["id"] = json!(id);
			o["title"] = json!(format!("Quest {id}"));
			o["pre"] = json!([]);
			o["objectives"] = objectives;
			o
		};
		quests["9500"] = q(9500, json!([kill(6, 8, "Kobold Vermin"), kill(9500, 5, "Kobold Vermin Runt")]));
		quests["9501"] = q(9501, json!([kill(6, 8, "Kobold Vermin"), kill(9501, 8, "Kobold Vermin")]));
		quests["9502"] = q(9502, json!([kill(6, 8, "Kobold Vermin"), kill(9501, 5, "Kobold Vermin")]));
	});
	build_db(data.path())
}

// Progress of quest q's objective on NPC `npc`: "cur/max" plus "done".
const PROGRESS: &str = r#"
local function prog(q, npc)
	for _, o in ipairs(Q._index.npc[npc] or {}) do
		if o.q == q then return o.cur .. "/" .. o.max .. (o.done and " done" or "") end
	end
	return "none"
end"#;

#[test]
fn one_client_line_per_objective_an_exact_name_beats_a_name_inside_another_the_longest_name_searches_first_leftovers_pair_last() {
	let db = overlap_db();
	let out = run(
		&db,
		&(PROGRESS.to_owned()
			+ r#"
w.accept(9500, { { text = "Kobold Vermin Runt slain: 5/5", required = 5, fulfilled = 5 }, { text = "Kobold Vermin slain: 0/8", required = 8 } })
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500), kinds("quests.objectives") })
w.progress(9500, 2, 3)
stub.advance(0.3)
w.progress(9500, 2, 4)
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
w.abandon(9500)
stub.advance(0.3)
w.accept(9500, { { text = "Slay Kobold Vermin Runts: 1/5", required = 5, fulfilled = 1 }, { text = "Slay Kobold Vermin: 2/8", required = 8, fulfilled = 2 } })
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
w.abandon(9500)
stub.advance(0.3)
w.accept(9500, { { text = "Kobold Vermin Runt slain: 5/5", required = 5, fulfilled = 5 }, { text = "Vermines tuées : 2/8", required = 8, fulfilled = 2 } })
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
"#),
		"",
	);
	let exact = &out[0];
	assert_eq!(exact[0], "0/8", "\"Kobold Vermin\" is not read from the Runt line");
	assert_eq!(exact[1], "5/5 done");
	assert_eq!(
		exact[2],
		json!(["Kobold Vermin@47.8,35.8:map:kill", "Kobold Vermin@50.3,35.8:map:kill", "Kobold Vermin@70.3,70.2:map:kill"]),
		"the unfinished objective keeps its markers; the finished Runts have none"
	);
	assert_eq!(out[1], json!(["4/8", "5/5 done"]), "repeated scans keep the assignment");
	assert_eq!(out[2], json!(["2/8", "1/5"]), "the longer name claims its line before the shorter one can");
	assert_eq!(out[3], json!(["2/8", "5/5 done"]), "an unmatched objective takes the line left over, never a claimed one");
}

#[test]
fn objectives_of_one_name_take_one_line_each_in_order_and_share_the_only_one_the_client_shows() {
	let db = overlap_db();
	let out = run(
		&db,
		&(PROGRESS.to_owned()
			+ r#"
w.accept(9501, { { text = "Kobold Vermin slain: 8/8", required = 8, fulfilled = 8 }, { text = "Kobold Vermin slain: 3/8", required = 8, fulfilled = 3 } })
stub.advance(0.3)
emit({ prog(9501, 6), prog(9501, 9501) })
w.abandon(9501)
stub.advance(0.3)
w.accept(9501, { { text = "Kobold Vermin slain: 3/8", required = 8, fulfilled = 3 } })
stub.advance(0.3)
emit({ prog(9501, 6), prog(9501, 9501) })
"#),
		"",
	);
	assert_eq!(out[0], json!(["8/8 done", "3/8"]));
	assert_eq!(out[1], json!(["3/8", "3/8"]));
}

#[test]
fn lines_of_counts_alone_are_matched_again_when_their_names_arrive_though_the_line_count_stays() {
	let db = overlap_db();
	let out = run(
		&db,
		&(PROGRESS.to_owned()
			+ r#"
w.accept(9500, { { text = " slain: 0/5", required = 5 }, { text = ": 0/8", required = 8 } })
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
local lines = w.log[9500].objectives
lines[1].text, lines[2].text = "Kobold Vermin Runt slain: 0/5", "Kobold Vermin slain: 0/8"
w.progress(9500, 1, 2)
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
w.progress(9500, 2, 3)
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
"#),
		"",
	);
	assert_eq!(out[0], json!(["0/5", "0/8"]), "nameless lines pair by position for now");
	assert_eq!(out[1], json!(["0/8", "2/5"]), "the names re-pair the lines: the Runts' count is not read as the Vermin's");
	assert_eq!(out[2], json!(["3/8", "2/5"]));
}

#[test]
fn objectives_of_one_name_take_the_line_requiring_their_own_count_before_database_order() {
	let db = overlap_db();
	let out = run(
		&db,
		&(PROGRESS.to_owned()
			+ r#"
w.accept(9502, { { text = "Kobold Vermin slain: 1/5", required = 5, fulfilled = 1 }, { text = "Kobold Vermin slain: 2/8", required = 8, fulfilled = 2 } })
stub.advance(0.3)
emit({ prog(9502, 6), prog(9502, 9501) })
"#),
		"",
	);
	assert_eq!(out[0], json!(["2/8", "1/5"]));
}

#[test]
fn a_turn_in_the_client_never_lists_counts_as_done_only_for_a_short_while_and_not_past_a_stop() {
	let db = fixture();
	let script = |restart: bool| {
		format!(
			r#"
w.turnIn(783)
w.completed[783] = nil              -- a repeatable: the client never lists it
stub.advance(0.3)
emit({{ Q.GetAvailableQuests(), kinds("quests.available") }})
{}
emit({{ Q.GetAvailableQuests(), kinds("quests.available") }})"#,
			if restart { "Q.Stop(); Q.Start(); Q.Flush()" } else { "stub.advance(10)" }
		)
	};
	for setup in ["", "C_QuestLog.GetAllCompletedQuestIDs = nil"] {
		let before = run(&db, r#"emit({ Q.GetAvailableQuests(), kinds("quests.available") })"#, setup).remove(0);
		for restart in [false, true] {
			let out = run(&db, &script(restart), setup);
			let (bridged, after) = (&out[0], &out[1]);
			let label = format!("{}{}", if setup.is_empty() { "bulk list" } else { setup }, if restart { ", restarted" } else { "" });
			assert!(has(&bridged[0], 7) && !has(&bridged[0], 783), "{label}: done during the window");
			assert_eq!(*after, before, "{label}: offered again afterwards, its follow-up closed");
		}
	}
}

#[test]
fn a_turn_in_counts_as_done_before_the_client_s_completed_flag_catches_up_and_only_for_that_quest() {
	let db = fixture();
	let turn_in = |lag: bool| {
		format!(
			r#"
w.turnIn(783)
{}
stub.advance(0.3)
emit({{ Q.GetAvailableQuests(), Q.WhyUnavailable(783) or "ok", kinds("quests.available") }})
w.completed[783] = true
stub.fire("QUEST_LOG_UPDATE")
stub.advance(0.3)
emit({{ Q.GetAvailableQuests(), kinds("quests.available") }})"#,
			if lag { "w.completed[783] = nil              -- the client has not listed it yet" } else { "" }
		)
	};
	for setup in ["", "C_QuestLog.GetAllCompletedQuestIDs = nil"] {
		let label = if setup.is_empty() { "bulk list" } else { setup };
		let out = run(&db, &turn_in(false), setup);
		let (now, later) = (&out[0], &out[1]);
		let lag = run(&db, &turn_in(true), setup);
		let (lag_now, lag_later) = (&lag[0], &lag[1]);
		assert!(has(&now[0], 7) && !has(&now[0], 783), "the fixture: 783 unlocks 7");
		assert_eq!(lag_now, now, "{label}: 783 done and 7 open at once, nothing else moves");
		assert_eq!(lag_later, later, "{label}: unchanged once the client catches up");
		let without: Vec<Value> = arr(lag_now).iter().enumerate().filter(|(i, _)| *i != 1).map(|(_, v)| v.clone()).collect();
		assert_eq!(*lag_later, Value::Array(without));
	}
}

#[test]
fn item_object_and_event_objectives_mark_their_sources_shared_clusters_carry_one_pin() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local pins = {}
for _, p in ipairs(layer("quests.objectives")) do pins[#pins + 1] = p.header .. ":" .. p.icon .. ":" .. #p.refs end
table.sort(pins)
emit(pins)
w.abandon(60); w.abandon(7)
w.accept(18, { { text = "Bundle of Wood: 0/1", type = "object", required = 1 }, { text = "Scout the farm", type = "event", required = 1 } })
stub.advance(0.3)
emit(kinds("quests.objectives"))
emit(#Q.GetMarkers(1429, "objectives"))
"#,
		"w.complete({ 783 }); w.setLevel(4)",
	);
	// Kobold Vermin is killed for 7 and drops candles for 60: one pin per
	// cluster with both objectives, under the kill glyph (the higher rank than loot).
	assert_eq!(
		out[0],
		json!(["Candle Crate:map:use:1", "Kobold Miner:map:loot:1", "Kobold Vermin:map:kill:2", "Kobold Vermin:map:kill:2", "Kobold Vermin:map:kill:2", "William Pestle:map:vendor:1",])
	);
	assert_eq!(out[1], json!(["Bundle of Wood@30.2,30.1:map:use", "Gathering Wood@40.5,70.3:map:explore"]));
	assert_eq!(out[2], 2);
}

#[test]
fn after_a_rebuild_a_cluster_two_quests_shared_shows_only_the_quest_still_needing_it() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local function vermin()
	local out = {}
	for _, p in ipairs(layer("quests.objectives")) do
		if p.header == "Kobold Vermin" then out[#out + 1] = p.icon .. ":" .. #p.refs end
	end
	table.sort(out)
	return out
end
emit(vermin())
w.progress(7, 1, 10)                -- 7's kill objective is done: only 60's candles still need the kobolds
stub.advance(0.3)
emit(vermin())
for _, p in ipairs(layer("quests.objectives")) do
	if p.header == "Kobold Vermin" then emit(sq.pinTooltip(p)) break end
end
"#,
		"w.complete({ 783 }); w.setLevel(4)",
	);
	assert_eq!(out[0], json!(["map:kill:2", "map:kill:2", "map:kill:2"]));
	assert_eq!(out[1], json!(["map:loot:1", "map:loot:1", "map:loot:1"]), "the loot glyph for NPC candle drops; the done kill quest is gone");
	let tip = arr(&out[2]);
	let any = |s: &str| tip.iter().any(|l| l.as_str().is_some_and(|l| l.contains(s)));
	assert!(any("Kobold Candles") && !any("Kobold Camp Cleanup"), "{}", out[2]);
}

// The suite's quest line: Hooks.AddLine
// with "<Quest>:" left in the quest colour and "<what> cur/max" right in
// textDim, success once done. The stub tooltip joins the halves with " | ".
#[test]
fn a_mob_two_quests_need_names_both_quests_and_your_progress_on_its_tooltip() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
w.progress(7, 1, 3)
stub.advance(0.3)
emit(sq.hoverUnit(6))
emit(sq.hoverItem(772))
emit(sq.hoverItem(1972))
w.progress(7, 1, 10)
stub.advance(0.3)
local seen = {}
local add = GameTooltip.AddDoubleLine
GameTooltip.AddDoubleLine = function(self, l, r, lr, lg, lb, rr, rg, rb)
	seen[#seen + 1] = { l, { lr, lg, lb }, { rr, rg, rb } }
	return add(self, l, r)
end
sq.hoverUnit(6)
GameTooltip.AddDoubleLine = add
local function same(c, name) local t = Q.Color(name); return c[1] == t.r and c[2] == t.g and c[3] == t.b end
emit({ same(seen[1][2], "quest"), same(seen[1][3], "success"), same(seen[2][2], "quest"), same(seen[2][3], "textDim") })
Polestar.Set("qol.questTooltips", false)
emit(sq.hoverUnit(6))
Polestar.Set("qol.questTooltips", true)
stub.advance(0.3)
emit(sq.hoverUnit(6, true))         -- GUID is a secret value (combat): no lines, no error
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!(["?", "Kobold Camp Cleanup: | Kill Kobold Vermin 3/10", "Kobold Candles: | Large Candle 0/8"]));
	assert_eq!(out[1], json!(["?", "Kobold Candles: | 0/8"]));
	assert_eq!(out[2], json!(["?", "Starts a quest: | A Strange Note"]));
	assert_eq!(out[3], json!([true, true, true, true]), "title in the quest colour; progress textDim, success once done");
	assert_eq!(out[4], json!(["?"]));
	assert_eq!(out[5], json!(["?"]));
}

// qol.questDropChance (off by default): on a mob that drops a quest item still needed, or an object it comes out
// of, the line says how often, from Polestar.QuestDB.GetDropChance and GetObjectDropChance, written as the
// Lookup window writes a chance. The fixture's Large Candle (772) drops from Kobold Vermin (6) at 40% and from
// Kobold Miner (40) at 20.456%, stored as 20.5, and comes out of the Candle Crate (object 77) every time.
#[test]
fn a_mob_s_tooltip_says_how_often_it_drops_the_quest_item_you_still_need_once_asked_to() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
w.progress(60, 1, 3)
stub.advance(0.3)
emit({ Q.GetDropChance(772, 6), Q.GetDropChance(772, 40), Q.GetDropChance(772, 99) == nil, Q.GetDropChance(99999, 6) == nil })
emit(Polestar.Get("qol.questDropChance"))
emit(sq.hoverUnit(6))
Polestar.Set("qol.questDropChance", true)
emit(sq.hoverUnit(6))
emit(sq.hoverUnit(40))
emit(sq.hoverItem(772))
emit({ Q.GetObjectDropChance(772, 77), Q.GetObjectDropChance(772, 6) == nil, Q.GetObjectDropChance(99999, 77) == nil })
emit(sq.hoverObject(77, "Candle Crate"))
emit(sq.hoverObject(nil, "Candle Crate"))
w.progress(60, 1, 8)
stub.advance(0.3)
emit(sq.hoverUnit(6))
"#,
		"",
	);
	assert_eq!(out[0], json!([40, 20.5, true, true]), "a dropper's chance in percent; none for another mob or an unknown item");
	assert_eq!(out[1], false);
	assert_eq!(out[2], json!(["?", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10", "Kobold Candles: | Large Candle 3/8"]), "off: the lines as they were");
	assert_eq!(out[3], json!(["?", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10", "Kobold Candles: | Large Candle 3/8  40%"]), "on the item's line only, never on a kill");
	assert_eq!(out[4], json!(["?", "Kobold Candles: | Large Candle 3/8  21%"]), "each dropper its own chance, whole percents from 10 up");
	assert_eq!(out[5], json!(["?", "Kobold Candles: | 3/8"]), "the item's own tooltip has no mob to speak for");
	assert_eq!(out[6], json!([100, true, true]), "an object the item comes out of has its own chance; a mob is no object");
	assert_eq!(out[7], json!(["?", "Kobold Candles: | Large Candle 3/8  100%"]), "on the object's tooltip too");
	assert_eq!(out[8], json!(["?", "Kobold Candles: | Large Candle 3/8"]), "an object hovered without an id cannot be looked up: no chance");
	assert_eq!(out[9], json!(["?", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10", "Kobold Candles: | Large Candle 8/8"]), "nothing left to drop for: no chance");
}

// qol.questTooltipsReplace (off by default): the client names a mob's quests itself (a title row, then its
// objectives), so with Polestar's lines each objective reads twice. On, the client's rows for a quest Polestar's
// lines name are left out, by the title row's quest id; the rows of a quest Polestar does not name stay, as do
// all of them in a group, on a tooltip whose data is secret, and while quest tooltips are off. A title hidden on
// one tooltip never hides rows on the next.
#[test]
fn the_client_s_own_quest_rows_step_aside_for_the_quests_polestar_s_lines_name_once_asked_to() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(18, { { text = "Bundle of Wood: 0/1", type = "object", required = 1 } })
stub.advance(0.3)
local function rows()
	return {
		{ type = "QuestTitle", id = 7, leftText = "Kobold Camp Cleanup" },
		{ type = "QuestObjective", leftText = "0/10 Kobold Vermin slain" },
		{ type = "QuestTitle", id = 999, leftText = "Someone Else's Quest" },
		{ type = "QuestObjective", leftText = "0/1 Something" },
	}
end
emit(Polestar.Get("qol.questTooltipsReplace"))
emit(sq.hoverUnit(6, nil, rows()))
Polestar.Set("qol.questTooltipsReplace", true)
emit(sq.hoverUnit(6, nil, rows()))
-- A party member's row under a hidden title goes with it.
emit(sq.hoverUnit(6, nil, { { type = "QuestTitle", id = 7, leftText = "Kobold Camp Cleanup" }, { type = "QuestPlayer", leftText = "Friend" }, { type = "QuestObjective", leftText = "0/10 Kobold Vermin slain" } }))
-- A title row without a quest id is not matched by its name: another quest may share it.
emit(sq.hoverUnit(6, nil, { { type = "QuestTitle", leftText = "Kobold Camp Cleanup" }, { type = "QuestObjective", leftText = "0/10 Kobold Vermin slain" } }))
-- The title hidden above does not reach the next tooltip, whose rows come without a title.
local function hidden() return sq.hoverUnit(6, nil, { { type = "QuestTitle", id = 7, leftText = "Kobold Camp Cleanup" }, { type = "QuestObjective", leftText = "0/10 Kobold Vermin slain" } }) end
hidden()
emit(sq.hoverUnit(99, nil, { { type = "QuestObjective", leftText = "0/1 Untitled" }, { type = "QuestPlayer", leftText = "Friend" } }))
hidden()
emit(sq.hoverUnit(6, nil, { { type = "QuestObjective", leftText = "0/1 Untitled" } }))
emit(sq.hoverObject(55, "Bundle of Wood", { { type = "QuestTitle", id = 18, leftText = "Gathering Wood" }, { type = "QuestObjective", leftText = "0/1 Bundle of Wood" } }))
emit(sq.hoverUnit(99, nil, rows()))                                  -- a mob Polestar names no quest on
local grouped = true
IsInGroup = function() return grouped end
emit(#sq.hoverUnit(6, nil, rows()))
grouped = false
Polestar.Set("qol.questTooltips", false)
emit(#sq.hoverUnit(6, nil, rows()))
Polestar.Set("qol.questTooltips", true)
stub.advance(0.3)
emit(sq.hoverUnit(6, true, rows()))                                  -- secret GUID (combat): the client's rows stay
"#,
		"",
	);
	let both = json!(["?", "Kobold Camp Cleanup", "0/10 Kobold Vermin slain", "Someone Else's Quest", "0/1 Something", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10"]);
	assert_eq!(out[0], false);
	assert_eq!(out[1], both, "off: the client's rows and Polestar's line");
	assert_eq!(
		out[2],
		json!(["?", "Someone Else's Quest", "0/1 Something", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10"]),
		"the quest Polestar names shows once; the other keeps the client's rows"
	);
	assert_eq!(out[3], json!(["?", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10"]), "the rows under a hidden title go with it");
	assert_eq!(out[4], json!(["?", "Kobold Camp Cleanup", "0/10 Kobold Vermin slain", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10"]), "no quest id on the title: its rows stay");
	assert_eq!(out[5], json!(["?", "0/1 Untitled", "Friend"]), "untitled rows on the next tooltip stay, on a mob Polestar names nothing on");
	assert_eq!(out[6], json!(["?", "0/1 Untitled", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10"]), "and on one it does name a quest on");
	assert_eq!(out[7], json!(["?", "Gathering Wood: | Not done"]), "objects too");
	assert_eq!(out[8], json!(["?", "Kobold Camp Cleanup", "0/10 Kobold Vermin slain", "Someone Else's Quest", "0/1 Something"]), "nothing of Polestar's to show: nothing left out");
	assert_eq!(out[9], 6, "in a group the client's rows carry the party's progress: all stay");
	assert_eq!(out[10], 5, "quest tooltips off: the client's rows alone");
	assert_eq!(out[11], json!(["?", "Kobold Camp Cleanup", "0/10 Kobold Vermin slain", "Someone Else's Quest", "0/1 Something"]), "unreadable data: the client's rows stay and Polestar adds none");
}

// The "New in Forever" mark (Quests/NewQuests.lua): a quest Forever added carries its ∞ after its name on the quest
// lines of a mob's and an item's tooltip ("Starts a quest" too); ui.newInForever off takes it away. Kobold Camp
// Cleanup (7) and A Strange Note (1972's) stand in for Forever's quests here.
#[test]
fn a_forever_quest_s_tooltip_lines_carry_the_new_in_forever_mark() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local note = Q.StartedBy(1972)[1]
Polestar.NewQuests.Register(6, string.format("%06d%06d", math.min(7, note), math.max(7, note)))
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
stub.advance(0.3)
emit(sq.hoverUnit(6))
emit(sq.hoverItem(1972))
Polestar.Set("ui.newInForever", false)
emit(sq.hoverUnit(6))
"#,
		"w.complete({ 783 })",
	);
	let mark = " |TInterface\\AddOns\\Polestar\\Media\\UI\\icon-forever:8:16:0:0|t";
	assert_eq!(out[0], json!(["?", format!("Kobold Camp Cleanup{mark}: | Kill Kobold Vermin 0/10"), "Kobold Candles: | Large Candle 0/8"]));
	assert_eq!(out[1], json!(["?", format!("Starts a quest: | A Strange Note{mark}")]));
	assert_eq!(out[2], json!(["?", "Kobold Camp Cleanup: | Kill Kobold Vermin 0/10", "Kobold Candles: | Large Candle 0/8"]));
}

// An item a quest still needs is marked in the bags and named on its tooltip
// until the quest is handed in: through the log, and (not accepted yet) through
// the running guide's steps from the live one on.
#[test]
fn an_item_a_quest_needs_is_flagged_while_the_quest_is_in_the_log_or_ahead_in_the_guide() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local E = Polestar.Engine
local function guideAhead() E.GetGuide = function() return { id = "test", steps = { { goals = { { t = "accept", quest = 60 } } } } } end end
guideAhead()
E.GetLiveStep = function() return 1 end
E.Applies = function() return true end
Polestar.Fire("GUIDE_CHANGED", nil); stub.advance(0.3)
emit({ Q.IsItemNeeded(772), sq.hoverItem(772) })
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
stub.advance(0.3)
emit({ Q.IsItemNeeded(772), sq.hoverItem(772) })
w.turnIn(60); stub.advance(0.3)
emit({ Q.IsItemNeeded(772), sq.hoverItem(772) })
E.GetGuide = function() return nil end
Polestar.Fire("GUIDE_CHANGED", nil); stub.advance(0.3)
emit({ Q.IsItemNeeded(772) })
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!([true, ["?", "Kobold Candles: | 0/8 (not accepted)"]]));
	assert_eq!(out[1], json!([true, ["?", "Kobold Candles: | 0/8"]]));
	assert_eq!(out[2], json!([false, ["?"]]));
	assert_eq!(out[3], json!([false]));
}

// The guide-ahead list reads from the live step (not the one on screen),
// leaves out steps that are not for this character, shows how many the bags
// hold, and hiding the bag marks does not turn off the guards that ask it.
#[test]
fn quest_items_ahead_from_the_live_step_only_steps_for_you_with_the_count_you_carry_marks_off_keeps_the_guards() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local E = Polestar.Engine
local steps = { { goals = { { t = "goto" } } }, { goals = { { t = "accept", quest = 60 } } }, { goals = { { t = "goto" } } } }
local applies = { true, true, true }
E.GetGuide = function() return { id = "test", steps = steps } end
E.Applies = function(i) return applies[i] == true end
local function again() Polestar.Fire("GUIDE_CHANGED", nil); stub.advance(0.3) end
E.GetStepIndex = function() return 2 end   -- looking back at the accept
E.GetLiveStep = function() return 3 end    -- the guide has moved past it
again()
emit({ Q.IsItemNeeded(772) })
E.GetStepIndex = function() return 1 end
E.GetLiveStep = function() return 1 end
applies[2] = false                         -- another class's step
again()
emit({ Q.IsItemNeeded(772) })
applies[2] = true
w.items[772] = 3
again()
emit(sq.hoverItem(772))
Polestar.Set("qol.questBagMarks", false)
again()
emit({ Q.IsItemNeeded(772) })
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!([false]), "a quest behind the live step is not ahead, whichever step is on screen");
	assert_eq!(out[1], json!([false]), "a step that is not for this character is left out");
	assert_eq!(out[2], json!(["?", "Kobold Candles: | 3/8 (not accepted)"]));
	assert_eq!(out[3], json!([true]), "qol.questBagMarks off hides only the marks");
}

// The Applejack Still (91736, #820) takes four Shiny Red Apples (4536) when it
// is clicked and never enters the quest log, so only the guide-ahead path
// knows the apples are needed. On the database built from data/forever and
// Elwynn Forest's steps (Stonefield Farm buys the apples, the still takes
// them, Westbrook Garrison follows), the apples are protected and named on
// their tooltip and the delete dialog until the guide has gone past the still.
#[test]
fn the_applejack_still_s_apples_are_protected_from_the_guide_until_it_is_past_the_still_820() {
	forge_addontest::needs!("quests.json");
	let db = build_db(&root().join("data/forever"));
	let out = run(
		&db,
		r#"
local E = Polestar.Engine
local steps = {
	{ title = "The Stonefield Farm", goals = { { t = "turnin", quest = 88 }, { t = "turnin", quest = 87 }, { t = "buy", item = 4536, count = 4 } } },
	{ title = "The Applejack Still", goals = { { t = "accept", quest = 91736 }, { t = "turnin", quest = 91736 }, { t = "collect", item = 247824, count = 1 } } },
	{ title = "Westbrook Garrison", goals = { { t = "accept", quest = 91738 }, { t = "turnin", quest = 91738 } } },
}
local live = 1
E.GetGuide = function() return { id = "forever/alliance/human/01-elwynn-forest", steps = steps } end
E.GetLiveStep = function() return live end
E.Applies = function() return true end
local function at(i) live = i; Polestar.Fire("STEP_CHANGED"); stub.advance(0.3) end
GetCursorInfo = function() return "item", 4536 end
local function deleteText()
	local text = { s = "Do you want to destroy Shiny Red Apple?" }
	function text:GetText() return self.s end
	function text:SetText(v) self.s = v end
	function text:GetStringHeight() return 12 end
	local dialog = { text = text, h = 100 }
	function dialog:GetHeight() return self.h end
	function dialog:SetHeight(h) self.h = h end
	StaticPopup_FindVisible = function() return dialog end
	Q.AddDeleteWarning("DELETE_ITEM")
	return (text.s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\n", "/"))
end
w.items[4536] = 4
at(1)
emit({ Q.IsItemNeeded(4536), sq.hoverItem(4536), deleteText() })
at(2)
emit({ Q.IsItemNeeded(4536) })
at(3)
emit({ Q.IsItemNeeded(4536), sq.hoverItem(4536), deleteText() })
"#,
		"",
	);
	// Applejack Still (91736) is a quest Forever added: its tooltip line carries the "New in Forever" mark.
	let mark = " |TInterface\\AddOns\\Polestar\\Media\\UI\\icon-forever:8:16:0:0|t";
	// The apples' count is the data's: 4 in a build that has it (Forever's quest data), else the objective reads 1/1.
	let quests: Value = serde_json::from_str(&std::fs::read_to_string(root().join("data/forever/quests.json")).unwrap()).unwrap();
	let n = quests["91736"]["objectives"][0]["count"].as_u64().unwrap_or(1).min(4);
	assert_eq!(
		out[0],
		json!([true, ["?", format!("Applejack Still{mark}: | {n}/{n} (not accepted)")], "Do you want to destroy Shiny Red Apple?//Needed for: “Applejack Still”"]),
		"bought at the Stonefield Farm: the still ahead needs them"
	);
	assert_eq!(out[1], json!([true]), "at the still");
	assert_eq!(out[2], json!([false, ["?"], "Do you want to destroy Shiny Red Apple?"]), "past the still: free to sell or delete");
}

// The delete confirmation gets "Needed for: <Quest>" while the item on the
// cursor is one a quest in the log still needs, and the dialog grows by the
// lines added.
#[test]
fn the_delete_confirmation_names_the_quest_that_still_needs_the_item() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local cursor = 772
GetCursorInfo = function() return "item", cursor end
local function popup()
	local text = { s = "Do you want to destroy X?", lines = 1 }
	function text:GetText() return self.s end
	function text:SetText(v) self.s = v; self.lines = 3 end
	function text:GetStringHeight() return self.lines * 12 end
	local dialog = { text = text, h = 100 }
	function dialog:GetHeight() return self.h end
	function dialog:SetHeight(h) self.h = h end
	StaticPopup_FindVisible = function() return dialog end
	return dialog
end
local function show(which)
	local d = popup()
	Q.AddDeleteWarning(which)
	return { (d.text.s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\n", "/")), d.h }
end
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
stub.advance(0.3)
emit(show("DELETE_ITEM"))
cursor = 1972
emit(show("DELETE_ITEM"))
cursor = 772
w.turnIn(60); stub.advance(0.3)
emit(show("DELETE_GOOD_ITEM"))
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!(["Do you want to destroy X?//Needed for: “Kobold Candles”", 124]));
	assert_eq!(out[1], json!(["Do you want to destroy X?", 100]), "an item no quest needs: dialog untouched");
	assert_eq!(out[2], json!(["Do you want to destroy X?", 100]), "quest handed in: dialog untouched");
}

// At a vendor, a sale that takes a quest item out of the bags raises a
// buy-back question; nothing is bought until the dialog is accepted.
#[test]
fn selling_an_item_a_quest_needs_offers_the_buyback_and_buys_it_back_only_when_accepted() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local bag = { { itemID = 772, stackCount = 8 }, { itemID = 5, stackCount = 3 } }
Polestar.QoL = { Client = {
	NumBags = function() return 0 end,
	NumSlots = function() return #bag end,
	SlotInfo = function(_, slot) return bag[slot] end,
} }
local shown, bought, money = {}, {}, 1000
StaticPopupDialogs = {}
StaticPopup_Show = function(which, text, _, data) shown[#shown + 1] = { which, (text:gsub("|c%x+|Hitem[^|]*|h", ""):gsub("|h|r", "")), data } end
local buyback = {}
GetNumBuybackItems = function() return #buyback end
GetBuybackItemLink = function(i) return buyback[i].link end
GetBuybackItemInfo = function(i) return "x", "icon", buyback[i].price end
BuybackItem = function(i) bought[#bought + 1] = i end
GetMoney = function() return money end
GetCoinTextureString = function(c) return c .. "c" end
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
stub.advance(0.3)
Q.SellWarningOpen(true)
emit(#shown)
bag[1] = nil                         -- the candles are sold
buyback[1] = { link = "|cffffffff|Hitem:772::::::::|h[Large Candle]|h|r", price = 24 }
Q.CheckSold()
emit(shown)
local data = shown[1] and shown[1][3]
emit(#bought)                        -- asked, not bought
StaticPopupDialogs.POLESTAR_QUEST_BUYBACK.OnAccept(nil, data)
emit(bought)
money = 5
shown[1] = nil
StaticPopupDialogs.POLESTAR_QUEST_BUYBACK.OnAccept(nil, data)
emit(bought)
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], 0, "nothing asked while the bags are unchanged");
	let shown = arr(&out[1]);
	assert_eq!(shown.len(), 1);
	assert_eq!(shown[0][0], "POLESTAR_QUEST_BUYBACK");
	assert_eq!(shown[0][2], 772);
	let text = shown[0][1].as_str().unwrap();
	for want in ["Large Candle", "Kobold Candles", "24c"] {
		assert!(text.contains(want), "{want} in {text}");
	}
	assert_eq!(out[2], 0, "asking buys nothing");
	assert_eq!(out[3], json!([1]), "accept buys the buyback entry back");
	assert_eq!(out[4], json!([1]), "too little money: no second buyback");
}

#[test]
fn object_tooltips_by_id_or_without_one_by_name() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(18, { { text = "Bundle of Wood: 0/1", type = "object", required = 1 } })
stub.advance(0.3)
emit(sq.hoverObject(55, "Bundle of Wood"))
emit(sq.hoverObject(nil, "Bundle of Wood"))
"#,
		"",
	);
	assert_eq!(out[0], json!(["?", "Gathering Wood: | Not done"]));
	assert_eq!(out[1], json!(["?", "Gathering Wood: | Not done"]));
}

// Sapphires of Aku'Mai (6563): the sapphire drops from three objects that
// share its name, so the name index met the one objective three times and
// the tooltip of an object hovered without an id listed it three times.
#[test]
fn an_item_several_objects_of_one_name_drop_names_its_objective_once_on_their_tooltip() {
	let data = data_with(|raw| {
		let objects = raw.get_mut("objects.json").unwrap();
		for id in [78, 79] {
			let mut o = objects["77"].clone();
			o["id"] = json!(id);
			objects[id.to_string()] = o;
		}
		let drops = &mut raw.get_mut("items.json").unwrap()["772"]["drops"]["object"];
		drops["78"] = json!(100);
		drops["79"] = json!(100);
	});
	let db = build_db(data.path());
	let out = run(
		&db,
		r#"
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
stub.advance(0.3)
emit(sq.hoverObject(nil, "Candle Crate"))
emit(sq.hoverObject(78, "Candle Crate"))
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!(["?", "Kobold Candles: | Large Candle 0/8"]));
	assert_eq!(out[1], json!(["?", "Kobold Candles: | Large Candle 0/8"]));
}

#[test]
fn an_unchanged_quest_log_costs_no_rebuild_and_no_pins_call() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local function snap() return { rebuilds = Q.stats.rebuilds, changes = Q.stats.changes, publishes = Q.stats.publishes, available = Q.stats.availableScans, calls = #sq.pins.calls } end
emit(snap())
for _ = 1, 5 do
	stub.fire("QUEST_LOG_UPDATE")
	stub.fire("UNIT_QUEST_LOG_CHANGED", "player")
	stub.advance(0.1)
end
stub.advance(1)
emit(snap())
"#,
		"w.complete({ 783 })",
	);
	assert!(out[0]["calls"].as_i64().unwrap() > 0);
	assert_eq!(out[1], out[0]);
}

#[test]
fn a_progress_count_alone_rebuilds_no_marker_and_calls_no_pins_tooltips_read_it_live_a_finished_objective_rebuilds() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local updates = 0
Polestar.On("QUESTDB_UPDATED", function() updates = updates + 1 end)
local function snap() return { rebuilds = Q.stats.rebuilds, calls = #sq.pins.calls, pins = #layer("quests.objectives"), updates = updates } end
emit(snap())
w.progress(7, 1, 4)
stub.advance(0.3)
emit(snap())
emit(sq.pinTooltip(layer("quests.objectives")[1]))
w.progress(7, 1, 10)
stub.advance(0.3)
emit(snap())
"#,
		"w.complete({ 783 })",
	);
	let (base, tick, tip, done) = (&out[0], &out[1], &out[2], &out[3]);
	assert!(base["pins"].as_i64().unwrap() > 0);
	let mut want = base.clone();
	want["updates"] = json!(base["updates"].as_i64().unwrap() + 1);
	assert_eq!(*tick, want, "kill count 4/10: same markers, no Pins call, one update for tooltips and nameplates");
	assert!(arr(tip).iter().any(|l| l.as_str().is_some_and(|l| l.contains("4/10"))), "the marker tooltip reads the live count: {tip}");
	assert_eq!(done["rebuilds"].as_i64().unwrap(), base["rebuilds"].as_i64().unwrap() + 1, "objective done: markers rebuilt");
	assert_eq!(done["pins"], 0, "its kill markers are gone");
}

#[test]
fn quest_log_events_are_coalesced_into_one_update_per_throttle_window() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local before = Q.stats.scans
for _ = 1, 20 do stub.fire("QUEST_LOG_UPDATE") end
stub.advance(0.3)
emit(Q.stats.scans - before)
"#,
		"",
	);
	assert_eq!(out[0], 1);
}

#[test]
fn marker_settings_reach_the_pins_layers() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
Polestar.Set("qol.minimapObjectives", false)
stub.advance(0.3)
emit({ sq.pins.layers["quests.objectives"].opts, sq.pins.layers["quests.available"].opts })
Polestar.Set("qol.mapObjectives", false)
stub.advance(0.3)
emit(sq.pins.layers["quests.objectives"] == nil)
Polestar.Set("qol.availableQuests", false)
stub.advance(0.3)
emit({ sq.pins.layers["quests.available"] == nil, #Q.GetAvailableQuests() })
"#,
		"w.complete({ 783 })",
	);
	let opts = json!({ "world": true, "minimap": false, "edge": false, "scale": 1 });
	let objectives = json!({ "world": true, "minimap": false, "edge": false, "scale": 1, "minimapAreas": true });
	assert_eq!(out[0], json!([objectives, opts]), "objective areas would follow the layer onto the minimap");
	assert_eq!(out[1], true);
	assert_eq!(out[2], json!([true, 0]));
}

#[test]
fn nameplate_icons_mark_objective_mobs_until_the_objective_is_done() {
	let db = fixture();
	let out = run(
		&db,
		r#"
Polestar.Set("qol.nameplateIcons", true)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
sq.addPlate("nameplate1", 6)
sq.addPlate("nameplate2", 197)
emit(Q.NameplateIcons())
sq.addPlate("nameplate3", 6, true)  -- GUID secret: no icon, no error
emit(Q.NameplateIcons())
w.progress(7, 1, 10)
stub.advance(0.3)
emit(Q.NameplateIcons())
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!(["nameplate1"]));
	assert_eq!(out[1], json!(["nameplate1"]));
	assert_eq!(out[2], json!({}), "empty");
}

#[test]
fn nameplate_icons_do_not_show_a_progress_count_the_client_shows_it_in_the_nameplate_name() {
	let db = fixture();
	let out = run(
		&db,
		r#"
Polestar.Set("qol.nameplateIcons", true)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.progress(7, 1, 3)
stub.advance(0.3)
sq.addPlate("nameplate1", 6)
emit(Q.NameplateIcon("nameplate1") ~= nil)
emit(Q.NameplateCount("nameplate1") == nil)
w.progress(7, 1, 7)
stub.advance(0.3)
emit(Q.NameplateCount("nameplate1") == nil)
w.accept(7, { { text = "Kobold Vermin slain: 0/1", type = "monster", required = 1 } })
stub.advance(0.3)
emit({ Q.NameplateIcons(), Q.NameplateCount("nameplate1") == nil })
"#,
		"w.complete({ 783 }); w.setLevel(4)",
	);
	assert_eq!(out[0], true, "icon shows for objective mob");
	assert_eq!(out[1], true, "count is suppressed; the client shows it in the nameplate name");
	assert_eq!(out[2], true, "count stays suppressed after progress update");
	assert_eq!(out[3], json!([["nameplate1"], true]), "one-off objective: icon only, count nil");
}

#[test]
fn nameplate_icons_sit_beside_the_health_bar_the_player_sees_above_the_frame_that_draws_it() {
	let db = fixture();
	let out = run(
		&db,
		r#"
Polestar.Set("qol.nameplateIcons", true)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local function frame(kind, parent, label, level, wd, ht)
	local f = CreateFrame(kind, nil, parent)
	f.label, f.level = label, level
	if wd then f:SetSize(wd, ht) end
	return f
end
-- Blizzard's own plate: the UnitFrame with its health bar.
local function blizzard(plate)
	plate.label, plate.level = "base", 3
	plate.UnitFrame = frame("Frame", plate, "unitframe", 4)
	plate.UnitFrame.healthBar = frame("StatusBar", plate.UnitFrame, "blizzard bar", 5, 120, 8)
end
local function where(unit)
	local f = Q.NameplateIcon(unit)
	local point, rel, relPoint, x, y = f:GetPoint(1)
	return { at = point .. " " .. (rel.label or "?") .. " " .. relPoint .. " " .. x .. "," .. y,
		parent = f:GetParent().label or "?", level = f:GetFrameLevel(), size = f:GetWidth() }
end
sq.addPlate("nameplate1", 6, false, function(plate) plate.label = "base" end)
sq.addPlate("nameplate2", 6, false, blizzard)
sq.addPlate("nameplate3", 6, false, function(plate) -- Plater-like
	blizzard(plate)
	plate.UnitFrame:SetAlpha(0)
	plate.unitFrame = frame("Frame", plate, "plater", 6)
	plate.unitFrame.healthBar = frame("StatusBar", plate.unitFrame, "plater bar", 7, 110, 12)
end)
sq.addPlate("nameplate4", 6, false, function(plate) -- an addon this code does not know
	blizzard(plate)
	plate.UnitFrame:Hide()
	frame("Frame", plate, "decor", 8, 20, 20)
	frame("StatusBar", frame("Frame", plate, "small", 8), "small bar", 9, 40, 4)
	local holder = frame("Frame", plate, "generic", 8)
	frame("StatusBar", frame("Frame", holder, "inner", 9), "generic bar", 10, 100, 18)
end)
-- EllesmereUI Nameplates builds its plate in its own NAME_PLATE_UNIT_ADDED
-- handler (it may run after this one) and fades Blizzard's UnitFrame to alpha 0.
sq.addPlate("nameplate5", 6, false, blizzard)
local before = where("nameplate5")
local base = C_NamePlate.GetNamePlateForUnit("nameplate5")
local p = frame("Frame", base, "eui", 4)
p.nameplate = base
p.health = frame("StatusBar", p, "eui bar", 10, 140, 24)
base.UnitFrame:SetAlpha(0)
EllesmereNameplates_NS = { plates = { nameplate5 = p }, friendlyPlates = {} }
stub.runTimers()
emit({ before = before, after = where("nameplate5") })
local out = {}
for i = 1, 4 do out[i] = where("nameplate" .. i) end
emit(out)
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(
		out[0],
		json!({
			"before": { "at": "RIGHT blizzard bar LEFT -3,0", "parent": "base", "level": 10, "size": 14 },
			"after": { "at": "RIGHT eui bar LEFT -3,0", "parent": "eui", "level": 15, "size": 20 },
		})
	);
	assert_eq!(
		out[1],
		json!([
			{ "at": "BOTTOM base TOP 0,-2", "parent": "base", "level": 6, "size": 16 },
			{ "at": "RIGHT blizzard bar LEFT -3,0", "parent": "base", "level": 10, "size": 14 },
			{ "at": "RIGHT plater bar LEFT -3,0", "parent": "plater", "level": 12, "size": 14 },
			{ "at": "RIGHT generic bar LEFT -3,0", "parent": "generic", "level": 15, "size": 18 },
		])
	);
}

// #995: another addon's quest icon sits at the left end of the bar, on top of
// ours; qol.nameplateIconSide moves the skull and its count right of the bar
// (past Blizzard's level badge) or above the name, and a change moves the
// icons already shown.
#[test]
fn nameplate_icon_position_moves_the_icon_and_its_count_right_or_above() {
	let db = fixture();
	let out = run(
		&db,
		r#"
Polestar.Set("qol.nameplateIcons", true)
w.accept(7, { { text = "Kobold Vermin slain: 3/10", type = "monster", required = 10 } })
w.progress(7, 1, 3)
stub.advance(0.3)
local function frame(kind, parent, label, level, wd, ht)
	local f = CreateFrame(kind, nil, parent)
	f.label, f.level = label, level
	if wd then f:SetSize(wd, ht) end
	return f
end
local function blizzard(plate)
	plate.label, plate.level = "base", 3
	local uf = frame("Frame", plate, "unitframe", 4)
	plate.UnitFrame = uf
	uf.healthBar = frame("StatusBar", uf, "blizzard bar", 5, 120, 8)
	uf.name = uf:CreateFontString(nil, "OVERLAY")
	uf.name.label = "name"
	uf.name:SetText("Kobold Vermin")
	uf.PlayerLevelDiffFrame = frame("Frame", uf, "level", 5, 15, 15)
end
local function rel(r) return r and (r.label or "?") or "nil" end
local function where(unit)
	local f = Q.NameplateIcon(unit)
	local point, r, relPoint, x, y = f:GetPoint(1)
	local cp, cr, crp, cx = f.count:GetPoint(1)
	return { icon = point .. " " .. rel(r) .. " " .. relPoint .. " " .. x .. "," .. y,
		count = cp .. " " .. (cr == f and "icon" or rel(cr)) .. " " .. crp .. " " .. cx }
end
emit(Polestar.GetDefault("qol.nameplateIconSide"))
sq.addPlate("nameplate1", 6, false, blizzard)
local seen = { left = where("nameplate1") }
Polestar.Set("qol.nameplateIconSide", "right")
seen.right = where("nameplate1")
Polestar.Set("qol.nameplateIconSide", "above")
seen.above = where("nameplate1")
-- a new plate takes the side too; with no level badge, the bar's end
sq.addPlate("nameplate2", 6, false, function(plate) blizzard(plate); plate.UnitFrame.PlayerLevelDiffFrame:Hide() end)
seen.newAbove = where("nameplate2")
Polestar.Set("qol.nameplateIconSide", "right")
seen.noBadge = where("nameplate2")
Polestar.Set("qol.nameplateIconSide", "nonsense")
seen.unknown = where("nameplate2")
emit(seen)
emit(Q.NameplateCount("nameplate1"))
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!("left"), "default keeps the icon where it was");
	assert_eq!(
		out[1],
		json!({
			"left": { "icon": "RIGHT blizzard bar LEFT -3,0", "count": "RIGHT icon LEFT -2" },
			"right": { "icon": "LEFT level RIGHT 3,0", "count": "LEFT icon RIGHT 2" },
			"above": { "icon": "BOTTOM name TOP 0,3", "count": "LEFT icon RIGHT 2" },
			"newAbove": { "icon": "BOTTOM name TOP 0,3", "count": "LEFT icon RIGHT 2" },
			"noBadge": { "icon": "LEFT blizzard bar RIGHT 3,0", "count": "LEFT icon RIGHT 2" },
			"unknown": { "icon": "RIGHT blizzard bar LEFT -3,0", "count": "RIGHT icon LEFT -2" },
		})
	);
	assert_eq!(out[2], json!("3/10"), "the count still shows");
}

#[test]
fn turning_the_database_off_clears_every_layer() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
Polestar.Set("qol.questDB", false)
local n = 0
for name in pairs(sq.pins.layers) do if name:find("^quests%.") then n = n + 1 end end
emit({ n, Q.IsRunning(), Q.ObjectivesForNpc(6) == nil })
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], json!([0, false, true]));
}

// Quest settings live on the Questing page (its Quests tab) and their map
// markers on the Map page, with every other map icon; their keys sit under
// the `qol.` section the module registered from its start.
#[test]
fn registers_its_settings_on_the_questing_page_and_its_markers_on_the_map_page() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local keys = { "questDB", "mapObjectives", "minimapObjectives", "objectiveSpots", "objectiveAreaAlpha", "questMarkerSize", "turnInMarkers", "availableQuests",
	"lowLevelQuests", "questLevelWindow", "questTooltips", "nameplateIcons", "nameplateIconSide", "questLevels", "guideHighlight", "guideDim" }
local d, mine = {}, {}
for _, k in ipairs(keys) do d[k] = Polestar.GetDefault("qol." .. k); mine["qol." .. k] = true end
emit(d)
local out, other = { Questing = {}, Map = {} }, {}
local reg = Polestar.Widgets and Polestar.Widgets.OptionsRegistry or {}
if #reg == 0 then reg = Q.OPTIONS end
for _, spec in ipairs(reg) do
	for _, c in ipairs(spec.controls) do
		if c.key and mine[c.key] then
			local list = out[spec.page]
			if list and (spec.page == "Map" or spec.tab == "Quests") then
				list[#list + 1] = c.key .. (c.help and "+help" or "")
			else
				other[#other + 1] = c.key
			end
		end
	end
end
emit(out)
emit(other)
"#,
		"",
	);
	assert_eq!(
		out[0],
		json!({
			"questDB": true, "mapObjectives": false, "minimapObjectives": false, "objectiveSpots": "groups", "objectiveAreaAlpha": 0.6, "questMarkerSize": 1, "turnInMarkers": false,
			"availableQuests": false, "lowLevelQuests": false, "questLevelWindow": 5, "questTooltips": true, "nameplateIcons": false,
			"nameplateIconSide": "left", "questLevels": true, "guideHighlight": true, "guideDim": false,
		})
	);
	assert_eq!(out[1]["Questing"], json!(["qol.questDB+help", "qol.questTooltips+help", "qol.nameplateIcons+help", "qol.nameplateIconSide+help", "qol.questLevels+help"]));
	assert_eq!(
		out[1]["Map"],
		json!([
			"qol.availableQuests+help",
			"qol.questLevelWindow+help",
			"qol.lowLevelQuests+help",
			"qol.mapObjectives+help",
			"qol.objectiveSpots+help",
			"qol.objectiveAreaAlpha+help",
			"qol.turnInMarkers+help",
			"qol.minimapObjectives+help",
			"qol.questMarkerSize+help",
			"qol.guideHighlight+help",
			"qol.guideDim+help",
		])
	);
	assert_eq!(out[2], json!({}), "no quest setting on another page");
}

#[test]
fn with_the_shipped_database_and_the_real_pins_service_quest_7_gets_objective_markers() {
	let shipped = root().join("addon/Polestar_QuestDB");
	if !shipped.join("Quests.lua").exists() {
		eprintln!("skipped: not generated");
		return;
	}
	let files: Vec<String> = FILES.iter().map(|f| lua_string(&shipped.join(f).to_string_lossy())).collect();
	let result = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua"],
		before: format!(
			r#"stub.quests.dbFiles = {{ {} }}
local w = stub.world
w.addMap(1429, {{ name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }})
w.moveTo(1429, 48, 40)
w.complete({{ 783 }})"#,
			files.join(", ")
		),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), MARKERS_ON.into())],
		login: true,
		script: r#"
local w, Q = stub.world, Polestar.QuestDB
stub.advance(0.3)
local avail = #Q.GetAvailableQuests()
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(0.3)
local pins = Polestar.Pins.GetLayer("quests.objectives") or {}
emit({ avail = avail, pins = #pins, header = pins[1] and pins[1].header, era = Polestar.MapFrames.era[1429] ~= nil, avail7 = Q.IsAvailable(7) })"#
			.into(),
	})
	.remove(0);
	assert!(result["avail"].as_i64().unwrap() > 0, "a fresh level-1 Human has quests to take");
	assert!(result["pins"].as_i64().unwrap() > 0);
	assert_eq!(result["header"], "Kobold Vermin");
	assert_eq!(result["era"], true);
	assert_eq!(result["avail7"], false, "a quest in the log is not available");
}

#[test]
fn quests_under_a_collapsed_quest_log_header_still_get_markers() {
	let db = fixture();
	let out = run(
		&db,
		r#"
emit(#layer("quests.objectives"))
sq.collapsed[33] = true
w.accept(33, { { text = "Tough Wolf Meat: 0/8", type = "item", required = 8 } })
stub.advance(0.3)
local wolves = 0
for _, p in ipairs(layer("quests.objectives")) do if p.header == "Young Wolf" then wolves = wolves + 1 end end
emit(wolves)
w.abandon(7)
stub.advance(0.3)
local kobolds = 0
for _, p in ipairs(layer("quests.objectives")) do if p.header == "Kobold Vermin" then kobolds = kobolds + 1 end end
emit(kobolds)
"#,
		r#"w.complete({ 783 }); w.onQuest(7, { { text = "Kobold Vermin slain: 2/10", type = "monster", required = 10, fulfilled = 2 } }); stub.quests.collapsed[7] = true"#,
	);
	assert_eq!(out[0], 3, "found by the login sweep");
	assert_eq!(out[1], 1, "found through QUEST_ACCEPTED");
	assert_eq!(out[2], 0, "dropped once the client says it is gone");
}

#[test]
fn level_window_quests_more_than_n_levels_above_yours_are_hidden_high_10_shows_any() {
	let db = extra_db();
	let why = r#"emit({ Q.WhyUnavailable(9420) or "ok", Q.WhyUnavailable(60) or "ok", Q.WhyUnavailable(16) or "ok", Q.WhyUnavailable(33) or "ok" })"#;
	let out = run(
		&db,
		&format!(
			r#"
{why}
Polestar.Set("qol.questLevelWindow", 1); stub.advance(0.3)
{why}
Polestar.Set("qol.questLevelWindow", 0); stub.advance(0.3)
{why}
Polestar.Set("qol.questLevelWindow", 10); stub.advance(0.3)
{why}
local n = 0
for _, p in ipairs(layer("quests.available")) do for _, q in ipairs(p.refs) do if q == 9420 then n = n + 1 end end end
emit(n)
"#
		),
		"w.setLevel(2)",
	);
	// Level 2: 9420 is level 9, 60 level 4, 16 level 3, 33 level 2.
	assert_eq!(out[0], json!(["high", "ok", "ok", "ok"]), "default +5: level 9 is too high at 2");
	assert_eq!(out[1], json!(["high", "high", "ok", "ok"]));
	assert_eq!(out[2], json!(["high", "high", "high", "ok"]));
	assert_eq!(out[3], json!(["ok", "ok", "ok", "ok"]));
	assert!(out[4].as_i64().unwrap() > 0, "its giver is marked once the window allows it");
}

#[test]
fn done_quests_completed_ones_never_show_from_the_bulk_list_or_per_quest_when_the_client_has_none() {
	let db = fixture();
	let check = r#"
emit({ Q.WhyUnavailable(33) or "ok", Q.IsAvailable(33), Q.IsAvailable(18) })
w.turnIn(18); stub.advance(0.3)
emit({ Q.WhyUnavailable(18) or "ok", Q.IsAvailable(18) })"#;
	let bulk = run(&db, check, "w.complete({ 33 })");
	assert_eq!(bulk[0], json!(["done", false, true]));
	assert_eq!(bulk[1], json!(["done", false]));
	let single = run(&db, check, "w.complete({ 33 }); C_QuestLog.GetAllCompletedQuestIDs = nil");
	assert_eq!(single[0], json!(["done", false, true]), "C_QuestLog.IsQuestFlaggedCompleted answers per quest");
	assert_eq!(single[1], json!(["done", false]));
}

// Pin selection: what ends up in each layer and how it looks.
#[test]
fn pin_selection_turn_in_toggle_and_the_guide_step_highlighted_with_the_rest_dimmed() {
	let db = fixture();
	let out = run(
		&db,
		r#"
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(33, { { text = "Tough Wolf Meat: 0/8", type = "item", required = 8 } })
w.progress(33, 1, 8)
stub.advance(0.3)
local function look(name)
	local out = {}
	for _, p in ipairs(layer(name)) do
		local accent = Q.Color("accent")
		out[#out + 1] = { h = p.header, area = p.area and true or false, radius = p.radius, ring = p.ring == accent, mark = p.icon:sub(1, 4) == "map:",
			size = p.size, mini = p.minimapSize, a = p.color[4], focus = p.focus or "none" }
	end
	table.sort(out, function(a, b) if a.h ~= b.h then return a.h < b.h end return (a.radius or 0) < (b.radius or 0) end)
	return out
end
emit(look("quests.objectives"))
-- a guide whose current step kills for quest 7
local E = Polestar.Engine
E.GetGuide = function() return { id = "test", steps = { { goals = { { t = "kill", quest = 7, target = "Kobold Vermin" } } } } } end
E.GetStepIndex = function() return 1 end
Polestar.Fire("STEP_CHANGED", 1); stub.advance(0.3)
emit({ look("quests.objectives"), look("quests.turnin"), look("quests.available") })
Polestar.Set("qol.guideDim", true); stub.advance(0.3)
emit({ look("quests.objectives"), look("quests.turnin"), look("quests.available") })
E.GetGuide = function() return nil end
Polestar.Fire("GUIDE_CHANGED", nil); stub.advance(0.3)
emit({ look("quests.objectives"), look("quests.available") })
Polestar.Set("qol.turnInMarkers", false); stub.advance(0.3)
emit(sq.pins.layers["quests.turnin"] == nil)
"#,
		"w.complete({ 783 })",
	);
	let (kill, kill_mini, turnin) = (16.0, 14.0, 18.0);
	let num = |p: &Value, k: &str| p[k].as_f64();
	let ring = |p: &Value| truthy(&p["ring"]);
	let list = |v: &Value| arr(v).clone();
	let (spots, focus, dim, off) = (list(&out[0]), &out[1], &out[2], &out[3]);
	// Kobold Vermin: two camps and a far one, too few to group: three markers.
	assert_eq!(spots.len(), 3);
	assert!(
		spots.iter().all(|p| p["h"] == "Kobold Vermin" && p["focus"] == "none" && !ring(p) && truthy(&p["mark"]) && num(p, "size") == Some(kill) && num(p, "mini") == Some(kill_mini)),
		"a map mark (glyph in its medallion), 16 px on the world map, 14 on the minimap"
	);
	assert!(spots.iter().all(|p| !truthy(&p["area"])), "a lone spot is a marker, no disc under it");
	let (f_obj, f_turn, f_avail) = (list(&focus[0]), list(&focus[1]), list(&focus[2]));
	assert!(
		f_obj.iter().all(|p| p["focus"] == "focus" && ring(p) && num(p, "size") == Some(kill * 1.3) && num(p, "mini") == Some(kill_mini * 1.3)),
		"the step quest: same glyph, x1.3, circled in the accent"
	);
	assert!(f_turn.iter().all(|p| p["focus"] == "none" && !ring(p) && num(p, "size") == Some(turnin) && num(p, "a") == Some(1.0)), "not in the step, not dimmed by default");
	assert!(!f_avail.is_empty() && f_avail.iter().all(|p| p["focus"] == "none"));
	assert_eq!([f_obj.len(), f_turn.len()], [3, 1], "three Vermin clusters; one turn-in (Eagan Peltskinner)");
	let (d_obj, d_turn, d_avail) = (list(&dim[0]), list(&dim[1]), list(&dim[2]));
	let (off0, off1) = (list(&off[0]), list(&off[1]));
	assert!(!d_avail.is_empty() && off0.len() == 3 && !off1.is_empty());
	assert!(d_obj.iter().all(|p| p["focus"] == "focus" && num(p, "a") == Some(1.0)));
	assert!(d_turn.iter().all(|p| p["focus"] == "dim" && truthy(&p["mark"]) && num(p, "a").is_some_and(|a| (a - 0.6).abs() < 1e-9)), "qol.guideDim: everything else recedes to 0.6");
	assert!(d_avail.iter().all(|p| p["focus"] == "dim"));
	assert!(off0.iter().all(|p| p["focus"] == "none" && !ring(p)) && off1.iter().all(|p| p["focus"] == "none" && num(p, "a") == Some(1.0)), "no guide: plain look");
	assert_eq!(out[4], true, "qol.turnInMarkers off clears the turn-in layer");
}

#[test]
fn the_database_loads_on_demand_not_while_every_quest_feature_is_off_at_once_when_one_turns_on() {
	let db = fixture();
	let all_off = "{ questDB = true, mapObjectives = false, minimapObjectives = false, availableQuests = false, turnInMarkers = false, questTooltips = false, questBagMarks = false, questSellWarning = false, nameplateIcons = false, questLoot = false }";
	let out = run_saved(
		&db,
		r#"
emit({ Q.IsLoaded(), sq.loadCalls, Q.IsRunning() })
Polestar.Set("qol.questTooltips", true)
stub.advance(0.3)
emit({ Q.IsLoaded(), sq.loadCalls, Q.IsRunning() })
"#,
		"",
		&format!("PolestarDB = {{ schema = 1, settings = {{ qol = {all_off} }} }}"),
	);
	assert_eq!(out[0], json!([false, 0, false]));
	assert_eq!(out[1], json!([true, 1, true]));
}

// Objective spots (#1085): the fixture plus quest 9600, "Forager Cull", whose
// Murloc Forager (9600) spawns in seven clusters on Elwynn's map (3000 yd
// wide, 30 yd per percent): a chain of four 120 yd apart (their discs 70 yd
// apart, within the 90 yd link), a pair the same way, and one alone.
fn spots_db() -> QuestDb {
	let data = data_with(|raw| {
		let npcs = raw.get_mut("npcs.json").unwrap();
		let mut npc = npcs["40"].clone();
		npc["id"] = json!(9600);
		npc["name"] = json!("Murloc Forager");
		npc["spawns"] = json!({ "1429": { "f": "e", "pts": [[20, 80], [24, 80], [28, 80], [32, 80], [60, 90], [64, 90], [85, 20]] } });
		npcs["9600"] = npc;
		let quests = raw.get_mut("quests.json").unwrap();
		let mut q = quests["7"].clone();
		q["id"] = json!(9600);
		q["title"] = json!("Forager Cull");
		q["pre"] = json!([]);
		q["objectives"] = json!([{ "type": "kill", "id": 9600, "count": 5, "text": "Murloc Forager" }]);
		quests["9600"] = q;
	});
	build_db(data.path())
}

// The objective layer split into markers (spots: how many a region's marker
// stands for) and areas (alpha relative to the accent's), with its opts.
const SPOTS_LOOK: &str = r#"
local function look()
	local icons, areas = {}, {}
	local accent = Q.Color("accent")
	for _, p in ipairs(layer("quests.objectives")) do
		if p.hull then
			areas[#areas + 1] = { only = p.areaOnly == true, corners = #p.hull / 2, accent = p.color[1] == accent.r and p.color[2] == accent.g and p.color[3] == accent.b,
				a = math.floor(p.color[4] / accent.a * 1000 + 0.5) / 1000 }
		else
			icons[#icons + 1] = { h = p.header, spots = p.spots or 1, size = p.size, mini = p.minimapSize }
		end
	end
	table.sort(icons, function(a, b) return a.spots > b.spots end)
	local l = sq.pins.layers["quests.objectives"]
	return { icons = icons, areas = areas, opts = l and l.opts }
end
local function centre()
	for _, p in ipairs(layer("quests.objectives")) do if p.spots then return p end end
end
"#;

#[test]
fn objective_spots_three_or_more_close_together_draw_one_accent_area_with_one_marker_lone_spots_and_pairs_stay_markers_each_option_changes_the_look() {
	let db = spots_db();
	let out = run(
		&db,
		&format!(
			r#"{SPOTS_LOOK}
w.accept(9600, {{ {{ text = "Murloc Forager slain: 0/5", type = "monster", required = 5 }} }})
stub.advance(0.3)
emit(look())
emit(sq.pinTooltip(centre()))
Polestar.Set("qol.objectiveAreaAlpha", 0.3); stub.advance(0.3)
emit(look())
Polestar.Set("qol.questMarkerSize", 1.5); stub.advance(0.3)
emit(look())
Polestar.Set("qol.objectiveSpots", "icons"); stub.advance(0.3)
emit(look())
Polestar.Set("qol.objectiveSpots", "areas"); stub.advance(0.3)
emit(look())
Polestar.Set("qol.minimapObjectives", false); stub.advance(0.3)
emit(look().opts)
"#
		),
		r#"w.titles[9600] = "Forager Cull""#,
	);
	let icons = |v: &Value| arr(&v["icons"]);
	let areas = |v: &Value| arr(&v["areas"]);
	let spots = |v: &Value| icons(v).iter().map(|p| p["spots"].as_i64().unwrap()).collect::<Vec<_>>();
	let alpha = |v: &Value| areas(v).iter().map(|a| a["a"].as_f64().unwrap()).collect::<Vec<_>>();
	let (groups, tip, faint, big, only_icons, only_areas) = (&out[0], arr(&out[1]), &out[2], &out[3], &out[4], &out[5]);
	// Default "groups": the chain of four is one area and one marker; the pair and the lone spot stay markers.
	assert_eq!(spots(groups), vec![4, 1, 1, 1], "{groups}");
	assert_eq!(areas(groups).len(), 1);
	let group_areas = areas(groups);
	let area = &group_areas[0];
	assert!(truthy(&area["only"]) && truthy(&area["accent"]) && area["corners"].as_i64().unwrap() >= 8, "a soft polygon in the accent, no pin of its own: {area}");
	assert_eq!(alpha(groups), vec![0.6], "qol.objectiveAreaAlpha's default");
	assert!(icons(groups).iter().all(|p| p["h"] == "Murloc Forager" && p["size"] == 16.0 && p["mini"] == 14.0), "the region's marker looks like any other: {groups}");
	assert_eq!(groups["opts"]["minimapAreas"], true, "areas on the minimap too");
	assert_eq!(groups["opts"]["minimap"], true);
	assert!(tip.iter().any(|l| *l == "Murloc Forager") && tip.iter().any(|l| *l == "Forager Cull") && tip.iter().any(|l| *l == "  Murloc Forager: 0/5"), "its tooltip as a spot's: {tip:?}");
	// Area opacity.
	assert_eq!(alpha(faint), vec![0.3]);
	assert_eq!(spots(faint), vec![4, 1, 1, 1]);
	// Quest marker size: every marker, both surfaces.
	assert!(icons(big).iter().all(|p| p["size"] == 24.0 && p["mini"] == 21.0), "{big}");
	// Icons only: every spot its own marker, no areas, none on the minimap.
	assert_eq!(spots(only_icons), vec![1; 7]);
	assert!(areas(only_icons).is_empty());
	assert!(only_icons["opts"]["minimapAreas"].is_null());
	// Areas only: every region an area (chain, pair, lone), no markers.
	assert!(icons(only_areas).is_empty(), "{only_areas}");
	assert_eq!(areas(only_areas).len(), 3);
	assert!(areas(only_areas).iter().all(|a| truthy(&a["only"]) && truthy(&a["accent"])));
	// Minimap markers off: the layer and its areas leave the minimap.
	assert_eq!(out[6]["minimap"], false);
}

#[test]
fn objective_spot_regions_group_only_the_objectives_a_quest_log_change_brought_never_on_a_setting_a_step_change_or_a_kill_count() {
	let db = spots_db();
	let out = run(
		&db,
		r#"
w.accept(9600, { { text = "Murloc Forager slain: 0/5", type = "monster", required = 5 } })
stub.advance(0.3)
local function area() for _, p in ipairs(layer("quests.objectives")) do if p.hull then return p end end end
local first = area()
local calls, of = 0, Polestar.Regions.Of
Polestar.Regions.Of = function(...) calls = calls + 1; return of(...) end
for _, mode in ipairs({ "icons", "areas", "groups" }) do Polestar.Set("qol.objectiveSpots", mode); stub.advance(0.3) end
Polestar.Set("qol.objectiveAreaAlpha", 0.4); stub.advance(0.3)
Polestar.Set("qol.questMarkerSize", 0.8); stub.advance(0.3)
Polestar.Fire("STEP_CHANGED", 1); stub.advance(0.3)
emit(calls)
w.progress(9600, 1, 2); stub.advance(0.3)
emit(calls)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
emit(calls)
w.abandon(7); stub.advance(0.3)
emit({ calls, area() == first })
"#,
		"w.complete({ 783 })",
	);
	assert_eq!(out[0], 0, "settings and a step change only restyle");
	assert_eq!(out[1], 0, "a kill count alone");
	assert_eq!(out[2], 1, "a quest came: only its objective is grouped (7's kobolds); 9600's foragers keep theirs");
	assert_eq!(out[3], json!([1, true]), "a quest left: nothing grouped, the foragers' area is the same pin");
}

#[test]
fn with_the_objective_and_turn_in_markers_off_a_quest_log_change_builds_no_marker_and_groups_no_spot() {
	let db = spots_db();
	let out = run_saved(
		&db,
		r#"
local calls, of = 0, Polestar.Regions.Of
Polestar.Regions.Of = function(...) calls = calls + 1; return of(...) end
local rebuilds = Q.stats.rebuilds
w.accept(9600, { { text = "Murloc Forager slain: 0/5", type = "monster", required = 5 } })
stub.advance(0.3)
Polestar.Fire("STEP_CHANGED", 1); stub.advance(0.3)
emit({ Q.stats.rebuilds - rebuilds, calls, sq.pins.layers["quests.objectives"] == nil, Q.ObjectivesForNpc(9600) ~= nil })
Polestar.Set("qol.mapObjectives", true); stub.advance(0.3)
emit({ Q.stats.rebuilds - rebuilds, calls, #layer("quests.objectives") > 0 })
"#,
		"",
		"PolestarDB = { schema = 1, settings = { qol = { mapObjectives = false, minimapObjectives = false, turnInMarkers = false, questTooltips = true } } }",
	);
	assert_eq!(out[0], json!([0, 0, true, true]), "no markers or regions; the tooltip index still knows the forager");
	assert_eq!(out[1], json!([1, 1, true]), "turned on: built and grouped once");
}

#[test]
fn objective_areas_fade_with_their_marker_under_guide_dim_and_a_step_quest_s_stay_full() {
	let db = spots_db();
	let out = run(
		&db,
		&format!(
			r#"{SPOTS_LOOK}
w.accept(9600, {{ {{ text = "Murloc Forager slain: 0/5", type = "monster", required = 5 }} }})
Polestar.Set("qol.guideDim", true)
local E = Polestar.Engine
E.GetGuide = function() return {{ id = "test", steps = {{ {{ goals = {{ {{ t = "kill", quest = 7, target = "Kobold Vermin" }} }} }} }} }} end
E.GetStepIndex = function() return 1 end
Polestar.Fire("STEP_CHANGED", 1); stub.advance(0.3)
emit({{ look(), centre().focus }})
E.GetGuide = function() return {{ id = "test", steps = {{ {{ goals = {{ {{ t = "kill", quest = 9600, target = "Murloc Forager" }} }} }} }} }} end
Polestar.Fire("STEP_CHANGED", 1); stub.advance(0.3)
emit({{ look(), centre().focus }})
"#
		),
		"",
	);
	let alpha = |v: &Value| arr(&v["areas"]).iter().map(|a| a["a"].as_f64().unwrap()).collect::<Vec<_>>();
	assert_eq!(out[0][1], "dim");
	assert_eq!(alpha(&out[0][0]), vec![0.36], "another quest's: 0.6 x the dim 0.6");
	assert_eq!(out[1][1], "focus");
	assert_eq!(alpha(&out[1][0]), vec![0.6], "the step's quest: full");
}

// The full-scan indexes (the item tooltip's "Starts a quest", the loot line, closes, follow-ups) read the one
// field they need from the data's text: no quest record is decoded to build them (that cost ~55 ms and ~6 MB of
// garbage each on the full database, in the frame that first asked).
#[test]
fn the_quest_indexes_are_built_without_decoding_a_record_and_answer_as_before() {
	let db = fixture();
	let out = run(
		&db,
		r#"
local mt = getmetatable(Q._data.quests)
local get, reads = mt.__index, 0
mt.__index = function(t, id) reads = reads + 1; return get(t, id) end
local answers = { started = Q.StartedBy(1972), closed14 = Q.ClosedBy(14), closed15 = Q.ClosedBy(15),
	after783 = Q.FollowUps(783), after33 = Q.FollowUps(33), after60 = Q.FollowUps(60), none = Q.StartedBy(4) or false }
mt.__index = get
emit(reads)
emit(answers)
"#,
		"",
	);
	assert_eq!(out[0], 0, "no record decoded");
	assert_eq!(out[1], json!({ "started": [17], "closed14": [15], "closed15": [14], "after783": [7], "after33": [19], "after60": [19], "none": false }));
}
