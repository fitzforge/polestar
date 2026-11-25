//! Spawn markers for your quests (addon/Polestar/Maps/MobMarkers.lua, rohkin's Mob Markers folded into Polestar):
//! which quests' mobs and objects it marks (the log's open quests, only the current guide step's with "Only the
//! current step's quests" on, the whole log with no guide), that a finished objective's mobs drop off, that hiding the
//! guide hides the markers and legend, the minimap inside its rim, objects with the pickup bag, the setting on for a
//! new install and off for a profile from before, and that off nothing is built or runs. Runs Core, Theme, Nav, the
//! Codex reader and Maps over stub_world.lua with tests/fixtures/codex/spawn-markers.json.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 5] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Lookup/Codex.lua", "Maps/Maps.xml"];

// tests/fixtures/codex/spawn-markers.json: quest 100 needs Wolves (2 spawns) and Bear Pelts (Bears, 3 spawns) on map
// 1429; 200 a Spider (1 spawn) on 1430; 400 is a letter (no mobs); 500 Dry Branches from their objects (2 spawns).
fn pack() -> CodexPack {
	write_codex_pack(&fixture("spawn-markers.json"), &CodexOpts::default())
}

// The world: Elwynn-sized map 1429 and map 1430 north of it, both on continent 0, the player on 1429.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.addMap(1430, { name = "Westfall", c = 0, left = 1500, right = -1500, top = 2500, bottom = 500 })
w.moveTo(1429, 47.6, 35.1)
"#;

const LOG: &str = r#"
local w = stub.world
-- The log lists the pelts first, the Codex the wolves.
w.accept(100, { { text = "Bear Pelt", type = "item", required = 5 }, { text = "Wolf slain", required = 8 } })
w.accept(200, { { text = "Spider slain", required = 1 } })
w.accept(400, {})
local M = Polestar.MobMarkers
-- The world map open on 1429, its canvas big enough that no two spawns share a marker.
local function open(mapID)
	stub.worldMapID = mapID or 1429
	WorldMapFrame:GetCanvas():SetSize(1000, 700)
	WorldMapFrame:Show()
	stub.advance(0.5)
end
local function state()
	stub.advance(0.5)
	local s = M.State()
	return { s.quests, s.spawns, s.drawn }
end
"#;

fn run_with(saved: Option<&str>, before: &str, script: &str) -> Vec<Value> {
	let p = pack();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{}\n{WORLD}\n{before}", p.stub_lua),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: saved.map(|s| vec![("Polestar".into(), s.into())]).unwrap_or_default(),
		login: true,
		script: format!("{LOG}\n{script}"),
	})
}

// The Codex loaded, as the guide's engine or Lookup loads it in play.
fn run(script: &str) -> Vec<Value> {
	run_with(None, "", &format!("Polestar.Codex.Load()\n{script}"))
}

#[test]
fn with_no_guide_running_every_open_quest_in_the_log_with_mobs_is_marked() {
	let out = run("open(); emit(state())");
	assert_eq!(out, vec![json!([2, 6, 5])], "quests 100 and 200 (6 spawns, 5 on 1429); not the mobless 400");
}

#[test]
fn only_the_current_steps_quests_are_marked_until_the_option_is_turned_off() {
	let out = run(r#"
		Polestar.Engine.GetStepIndex = function() return 1 end
		Polestar.Engine.GetStepView = function() return { goals = {
			{ quest = 200, t = "kill" },
			{ quest = 100, t = "turnin" },
			{ quest = 100, t = "kill", status = "done" },
		} } end
		Polestar.Fire("STEP_CHANGED")
		open()
		emit(state())
		Polestar.Set("mobMarkers.stepOnly", false)
		emit(state())"#);
	assert_eq!(out, vec![json!([1, 1, 0]), json!([2, 6, 5])], "the step works on 200 only; a hand-in or a done goal does not count");
}

#[test]
fn step_only_refresh_does_not_read_unrelated_quests() {
	let out = run(r#"
		local C = Polestar.Compat
		local Q = C_QuestLog
		local goals = {}
		Polestar.Engine.GetStepIndex = function() return 1 end
		Polestar.Engine.GetStepView = function() return { goals = goals } end
		local wholeLog, entries, ready = 0, 0, {}
		local originalCount, originalInfo, originalReady = Q.GetNumQuestLogEntries, Q.GetInfo, C.IsQuestReadyForTurnIn
		local hidden = false
		Q.GetNumQuestLogEntries = function() wholeLog = wholeLog + 1; return originalCount() end
		Q.GetInfo = function(index)
			entries = entries + 1
			local info = originalInfo(index)
			if info and info.questID == 100 then info.isHidden = hidden end
			return info
		end
		C.IsQuestReadyForTurnIn = function(id) ready[#ready + 1] = id; return originalReady(id) end
		-- Our ordered log is 100, 200, 400. The Forever client can give us the index of just 100.
		Q.GetLogIndexForQuestID = function(id) if id == 100 and Q.IsOnQuest(id) then return 1 end end
		local function refresh(palette)
			wholeLog, entries, ready = 0, 0, {}
			Polestar.Set("mobMarkers.questPalette", palette)
			emit({ wholeLog, entries, ready, M.State().spawns })
		end
		refresh("vivid") -- no goal needs a log entry
		goals = { { quest = 100, t = "kill" }, { quest = 200, t = "turnin" }, { quest = 100, t = "collect" } }
		refresh("safe") -- the same quest is mentioned twice, but is checked once
		hidden = true
		refresh("muted") -- a hidden log entry remains excluded even when the index exists
		hidden = false
		Q.GetLogIndexForQuestID = nil
		refresh("mono") -- clients without the index API still only check readiness for 100
		goals[2].t = "kill"
		goals[1], goals[2] = goals[2], goals[1]
		refresh("polestar") -- two quests follow the log order
		emit(M.State().ids)
		-- Progress must still refresh the markers when the same quest remains on the step.
		w.progress(100, 2, 8)
		stub.advance(0.5)
		emit(M.State().spawns)
		w.finish(100)
		stub.advance(0.5)
		emit(M.State().ids)"#);
	assert_eq!(out, vec![json!([0, 0, {}, 0]), json!([0, 1, [100], 5]), json!([0, 1, {}, 0]), json!([1, 3, [100], 5]), json!([1, 3, [100, 200], 6]), json!([100, 200]), json!(4), json!([200])]);
}

#[test]
fn a_finished_objectives_mobs_drop_off_matched_by_name_not_by_the_logs_order() {
	let out = run(r#"
		open()
		stub.world.progress(100, 2, 8)
		emit(state())
		stub.world.progress(100, 1, 5)
		emit(state())"#);
	assert_eq!(out, vec![json!([2, 4, 3]), json!([1, 1, 0])], "the wolves go first, then the bears (quest 100 is then ready: off the list)");
}

#[test]
fn hiding_the_guide_hides_the_markers_and_legend_and_showing_it_brings_them_back() {
	let out = run(r#"
		open()
		local function shown() local s = state(); emit({ s[3], PolestarMobMarkersLegend:IsShown() }) end
		shown()
		Polestar.Set("ui.shown", false)
		shown()
		Polestar.Set("ui.shown", true)
		shown()
		emit(#stub.underGameFrames)"#);
	assert_eq!(out, vec![json!([5, true]), json!([0, false]), json!([5, true]), json!(0)], "and no frame is made under the game's own");
}

// The player on the wolves' first spawn (1429 at 10,10): the minimap shows the markers inside its rim.
#[test]
fn the_minimap_shows_the_spawns_inside_its_rim_and_none_while_the_guide_is_hidden() {
	let out = run(r#"
		stub.world.moveTo(1429, 10, 10)
		local function drawn() stub.advance(0.5); emit(Polestar.MobMarkers.State().minimap) end
		drawn()
		Polestar.Set("ui.shown", false)
		drawn()
		Polestar.Set("ui.shown", true)
		drawn()
		Polestar.Set("mobMarkers.showMinimap", false)
		drawn()"#);
	assert_eq!(out[0], out[2]);
	assert!(out[0].as_i64().unwrap() >= 1, "the wolf under the player is drawn: {out:?}");
	assert_eq!(out[1], json!(0));
	assert_eq!(out[3], json!(0));
}

#[test]
fn an_item_picked_from_objects_marks_the_objects_with_the_pickup_bag() {
	let out = run(r#"
		stub.world.accept(500, { { text = "Dry Branch", type = "item", required = 2 } })
		Polestar.Engine.GetStepIndex = function() return 1 end
		Polestar.Engine.GetStepView = function() return { goals = { { quest = 500, t = "collect" } } } end
		Polestar.Fire("STEP_CHANGED")
		open()
		emit(state())
		local icons = {}
		for _, f in ipairs({ Polestar.MapCanvas.Get(WorldMapFrame).frame:GetChildren() }) do
			if f.skull and f:IsShown() then icons[#icons + 1] = f.skull:GetTexture() end
		end
		emit(icons)"#);
	assert_eq!(out[0], json!([1, 2, 2]), "both Dry Branch spawns on 1429");
	let loot = r"Interface\AddOns\Polestar\Media\UI\icon-collect";
	assert_eq!(out[1], json!([loot, loot]), "not the skull");
}

// The legend's click turns a quest's markers off for this character; they come back with a second click, and a quest
// turned in leaves the hidden list.
#[test]
fn a_quest_turned_off_from_the_legend_stays_off_for_the_character_until_turned_in() {
	let out = run(r#"
		open()
		local hidden = Polestar.CharState()
		hidden.mobMarkersHidden = { [100] = true }
		Polestar.Set("mobMarkers.questPalette", "vivid")
		emit(state())
		stub.world.turnIn(100)
		stub.advance(0.5)
		emit(hidden.mobMarkersHidden[100] == nil)"#);
	assert_eq!(out[0], json!([2, 6, 0]), "100's spawns count, none is drawn; 200's are on 1430");
	assert_eq!(out[1], json!(true));
}

// On for a new install; a profile from before the markers keeps them off; off, nothing is built, no frame is made
// on the maps and nothing runs per frame.
#[test]
fn on_for_a_new_install_off_for_a_profile_from_before_and_off_builds_nothing() {
	let fresh = run("emit({ Polestar.Get('mobMarkers.enabled'), state()[1] })");
	assert_eq!(fresh, vec![json!([true, 2])]);
	let before = run_with(
		Some("PolestarDB = { schema = 1, settings = { ui = { scale = 1 } } }"),
		"",
		r#"
		open()
		local s = state()
		emit({ Polestar.Get("mobMarkers.enabled"), s[1], s[2], s[3], PolestarMobMarkersLegend ~= nil, Polestar.MobMarkers.State().minimap })"#,
	);
	assert_eq!(before, vec![json!([false, 0, 0, 0, false, 0])]);
}

// The markers never load the Codex by themselves, not even with the world map open: on at login with nothing else
// asking for it, they wait; once something loads it (the guide's engine, Lookup) they build at once.
#[test]
fn the_markers_wait_for_the_codex_and_build_when_something_loads_it() {
	let out = run_with(
		None,
		"",
		r#"
		open()
		local s = state()
		emit({ Polestar.Codex.IsLoaded(), s[1] })
		Polestar.Codex.Load()
		s = state()
		emit({ Polestar.Codex.IsLoaded(), s[1], s[3] })"#,
	);
	assert_eq!(out, vec![json!([false, 0]), json!([true, 2, 5])]);
}
