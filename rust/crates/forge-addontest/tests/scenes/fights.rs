//! Ten fights on the guide: a level 14 Orc Warrior at the Crossroads, on the guide the addon opens for them at
//! login, its quests up to the guide's first kill step in the log (the earlier ones handed in), stands at that
//! step's mobs and kills ten of them: target, combat (PLAYER_REGEN_DISABLED), the kill and its quest credit, out
//! of combat (PLAYER_REGEN_ENABLED), auto loot. What the player meets in those ten fights:
//!
//! - with the default settings: nothing in chat, no sound, no alert; the one thing done for them is the loot
//!   (qol.fastLoot takes each slot of an auto-loot window);
//! - with every feature on (every setting of qol, rares, nav, maps and behavior that is off by default turned on)
//!   and the Arcade played and put away by a fight once before: the Arcade's own lines belong to that fight only
//!   (#2899: 0.4.1 ended every later fight with "combat over. Type /doom to get back to Doom."); Polestar says only
//!   what a setting asks for, at most once (qol.targetAnnounce: "Targeting: <names>" when the step's mobs change);
//! - with the class-training banner up (trained two levels ago: TRAIN_DUE): the same silence, and a kill costs no
//!   more at the end than at the start.
//!
//! Each kill's work is timed with its 3 seconds of client frames (the addon's timers and OnUpdate run in them).

use crate::common::{play, release_or_skip, Play};
use forge_addontest::assert_timing;
use serde_json::Value;

const WORLD: &str = r#"
local w = stub.world
w.faction, w.race, w.raceName, w.raceID, w.class, w.className, w.classID = "Horde", "Orc", "Orc", 2, "WARRIOR", "Warrior", 1
w.addMap(1413, { name = "The Barrens", c = 1, left = 2622.917, right = -7510.417, top = 1612.5, bottom = -5139.583 })
w.moveTo(1413, 51.9, 30.4)
w.zone, w.subzone = "The Barrens", "The Crossroads"
"#;

/// Puts the character at the open guide's first kill step: the quests handed in before it complete, the ones taken
/// before it in the log (the kill quest's objectives open, every other objective done), the player at its mobs.
/// `killStep()` -> the step, its kill goals.
const TO_KILL_STEP: &str = r#"
local E = assert(Polestar.Engine, "no Polestar.Engine")
local w, S = stub.world, stub.scenes
function killStep()
	local g = assert(E.GetGuide(), "no guide open at login")
	local k
	for i = E.GetStepIndex(), E.GetStepCount() do
		for _, gl in ipairs(g.steps[i].goals) do
			if not k and gl.t == "kill" and gl.quest and gl.oi then k = i end
		end
	end
	assert(k, "the guide " .. g.id .. " has no kill step ahead")
	local handed, done, taken, want, kills = {}, {}, {}, {}, {}
	for i = 1, k - 1 do
		for _, gl in ipairs(g.steps[i].goals) do
			if gl.t == "turnin" and gl.quest then handed[gl.quest] = true; done[#done + 1] = gl.quest end
		end
	end
	for i = 1, k - 1 do
		for _, gl in ipairs(g.steps[i].goals) do
			if gl.t == "accept" and gl.quest and not handed[gl.quest] then taken[gl.quest] = true end
		end
	end
	for _, gl in ipairs(g.steps[k].goals) do
		if gl.t == "kill" and gl.quest and gl.oi then
			want[gl.quest] = want[gl.quest] or {}
			want[gl.quest][gl.oi] = gl.count or 1
			kills[#kills + 1] = gl
		end
	end
	w.complete(done)
	for q in pairs(taken) do
		local objs = {}
		for i, n in pairs(want[q] or {}) do objs[i] = { required = n } end
		for i = 1, #objs do objs[i] = objs[i] or { required = 1, fulfilled = 1 } end
		w.onQuest(q, #objs > 0 and objs or { { required = 1, fulfilled = 1 } })
	end
	w.moveTo(kills[1].map or w.map, kills[1].x or w.x, kills[1].y or w.y)
	stub.fire("QUEST_LOG_UPDATE")
	stub.advance(3)
	assert(E.GetStepIndex() == k, "the guide is at step " .. tostring(E.GetStepIndex()) .. ", not its kill step " .. k)
	return k, kills
end

-- Ten kills of the step's mobs, in goal order, each crediting its objective. -> what reached the player, the ms of each.
function tenKills(kills)
	local s, ms, goal, n = Scene.snap(), {}, 1, 0
	for i = 1, 10 do
		local gl = kills[goal]
		local o = w.log[gl.quest].objectives[gl.oi]
		ms[i] = Scene.work(function()
			S.fight(gl.npc, gl.target or "Mob", gl.lvl or w.level, function() w.progress(gl.quest, gl.oi, o.numFulfilled + 1) end)
		end).ms
		if o.numFulfilled >= o.numRequired and kills[goal + 1] then goal = goal + 1 end
	end
	local d = Scene.since(s)
	d.ms = ms
	d.looted = S.looted
	return d
end
"#;

/// Every setting of these sections that is off by default, turned on.
const ALL_ON: &str = r#"
local on = {}
for _, sec in ipairs({ "qol", "rares", "nav", "maps", "behavior" }) do
	for key, v in pairs(Polestar.GetDefault(sec) or {}) do
		if v == false then Polestar.Set(sec .. "." .. key, true); on[#on + 1] = sec .. "." .. key end
	end
end
table.sort(on)
stub.advance(1)
"#;

/// The Arcade opened (/polestar arcade), in a level, and put away by a fight: what that showed.
const ARCADE_PAUSED_ONCE: &str = r#"
local s = Scene.snap()
Polestar.RunCommand("arcade")
stub.advance(1)
local A = FreedoomArcade
if A and A.G and A.G.InitNew then A.G.InitNew(2, 1, 1) end
stub.advance(1)
local open = FreedoomArcadeAPI and FreedoomArcadeAPI.IsOpen and FreedoomArcadeAPI.IsOpen() or false
stub.inCombat = true
stub.fire("PLAYER_REGEN_DISABLED")
stub.advance(1)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(1)
arcade = Scene.since(s)
arcade.opened = open
arcade.level = A and A.G and A.G.state or false
"#;

fn run(level: u32, saved: Option<&str>, setup: &str, script: &str) -> Value {
	play(&Play {
		stubs: vec!["stub_rares.lua", "stub_scenes_world.lua"],
		before: format!("{WORLD}\nstub.world.level = {level}"),
		saved: saved.map(|s| vec![("Polestar".to_string(), s.to_string())]).unwrap_or_default(),
		script: format!("{TO_KILL_STEP}\nstub.advance(3)\n{setup}\nlocal k, kills = killStep()\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn lines(d: &Value) -> Vec<String> {
	d["lines"].as_array().map(|a| a.iter().map(|l| plain(l.as_str().unwrap_or(""))).collect()).unwrap_or_default()
}

/// A chat line without its colour codes.
fn plain(s: &str) -> String {
	let mut out = String::new();
	let mut rest = s;
	while let Some(i) = rest.find('|') {
		out.push_str(&rest[..i]);
		let after = &rest[i + 1..];
		if after.starts_with('c') && after.len() >= 9 {
			rest = &after[9..];
		} else if let Some(stripped) = after.strip_prefix('r') {
			rest = stripped;
		} else {
			out.push('|');
			rest = after;
		}
	}
	out.push_str(rest);
	out
}

fn ms(d: &Value) -> Vec<f64> {
	d["ms"].as_array().unwrap().iter().map(|v| v.as_f64().unwrap()).collect()
}

/// What every one of the ten fights may do: no sound, no alert, no rare, the loot taken (one slot a kill), nothing else.
fn quiet_but_the_loot(case: &str, d: &Value) {
	assert_eq!(d["sounds"], 0, "{case}: {} sounds in 10 fights: {}", d["sounds"], d["soundIds"]);
	assert_eq!(d["alertTotal"], 0, "{case}: raid-warning, error-frame lines or flashes in 10 fights: {}", d["alerts"]);
	assert_eq!(d["rares"], 0, "{case}: {} rare alerts in 10 fights", d["rares"]);
	assert_eq!(d["cards"], 0, "{case}: {} rare cards in 10 fights", d["cards"]);
	assert_eq!(d["auto"], serde_json::json!({ "LootSlot": 10 }), "{case}: automatic actions in 10 fights (one loot slot a kill expected): {}", d["actions"]);
	assert_eq!(d["looted"], 10, "{case}: the loot of {} kills of 10 taken", d["looted"]);
}

fn per_kill(case: &str, d: &Value, budget: f64) {
	let t = ms(d);
	let worst = t.iter().cloned().fold(0.0, f64::max);
	let mean = t.iter().sum::<f64>() / t.len() as f64;
	assert_timing!(worst <= budget, "{case}: the slowest of 10 kills took {worst:.1} ms with its 3 s of frames (budget {budget} ms; all: {t:.1?})");
	// No growth: the last three kills against the first three.
	let first = t[..3].iter().sum::<f64>() / 3.0;
	let last = t[7..].iter().sum::<f64>() / 3.0;
	assert_timing!(last <= first * 2.0, "{case}: kills 8-10 took {last:.1} ms each, kills 1-3 {first:.1} ms: the work grows kill by kill (all: {t:.1?}, mean {mean:.1})");
}

#[test]
fn ten_fights_on_the_guide_with_the_default_settings_say_nothing_and_only_loot() {
	let Some(_) = release_or_skip() else { return };
	let d = run(14, None, "", "emit(tenKills(kills))");
	let said = lines(&d);
	assert!(said.is_empty(), "default settings: {} chat lines after 10 fights: {said:?}", said.len());
	quiet_but_the_loot("default settings", &d);
	// 0.4.1.1: 55-61 ms a kill, 3 s of client frames included.
	per_kill("default settings", &d, 180.0);
}

#[test]
fn ten_fights_with_every_feature_on_and_the_arcade_paused_once_bring_no_combat_over_line_2899() {
	let Some(_) = release_or_skip() else { return };
	let d = run(14, None, &format!("{ALL_ON}\n{ARCADE_PAUSED_ONCE}"), "local d = tenKills(kills); d.arcade = arcade; d.on = on; emit(d)");
	let arcade = &d["arcade"];
	assert_eq!(arcade["opened"], true, "/polestar arcade did not open the Arcade (chat: {:?})", lines(arcade));
	assert_eq!(arcade["level"], "level", "the Arcade is not in a level, so a fight would not pause it");
	let paused = lines(arcade);
	assert!(paused.iter().any(|l| l.contains("Freedoom Arcade") && l.contains("in combat")), "the fight with the Arcade open did not say it paused the game: {paused:?}");
	let said = lines(&d);
	let arcade_lines: Vec<&String> = said.iter().filter(|l| l.contains("Freedoom Arcade")).collect();
	assert!(arcade_lines.is_empty(), "every feature on, the Arcade put away by an earlier fight: {} Arcade lines after 10 more fights: {arcade_lines:?}", arcade_lines.len());
	// The settings that may print in a fight, once each: qol.targetAnnounce names the step's mobs when they change.
	let targeting = said.iter().filter(|l| l.starts_with("Polestar: Targeting: ")).count();
	assert!(targeting <= 1, "every feature on: {targeting} \"Targeting:\" lines after 10 fights: {said:?}");
	let other: Vec<&String> = said.iter().filter(|l| !l.starts_with("Polestar: Targeting: ")).collect();
	assert!(other.is_empty(), "every feature on ({}): chat lines no setting asks for after 10 fights: {other:?}", d["on"]);
	quiet_but_the_loot("every feature on", &d);
	// 0.4.1.1: 67-74 ms a kill, 3 s of client frames included.
	per_kill("every feature on", &d, 220.0);
}

#[test]
fn ten_fights_under_the_class_training_banner_cost_the_same_at_the_end_as_at_the_start() {
	let Some(_) = release_or_skip() else { return };
	// Trained at 12, logged in at 13 (odd: no reminder), then 14: the banner comes up.
	let d = run(
		13,
		Some("PolestarCharDB = { schema = 1, classTrainLevel = 12 }"),
		r#"due = {}
Polestar.On("TRAIN_DUE", function(level, t) due[#due + 1] = { level = level, npc = t and t.npc } end)
stub.world.setLevel(14)
stub.advance(3)
"#,
		r#"local d = tenKills(kills)
d.due = due
local banner = {}
for _, fs in ipairs(stub.strings) do
	local t = fs.GetText and fs:GetText()
	if type(t) == "string" and fs:IsVisible() and t:lower():find("train") then banner[#banner + 1] = t end
end
d.banner = banner
emit(d)"#,
	);
	assert_eq!(d["due"].as_array().map(Vec::len), Some(1), "the training reminder (TRAIN_DUE) fired {} times at level 14, trained at 12", d["due"]);
	assert!(!d["banner"].as_array().unwrap().is_empty(), "no training line shown in the guide window after TRAIN_DUE");
	let said = lines(&d);
	assert!(said.is_empty(), "training banner up: {} chat lines after 10 fights: {said:?}", said.len());
	quiet_but_the_loot("training banner up", &d);
	// 0.4.1.1: 11-13 ms a kill, 3 s of client frames included (a character Polestar has seen before: the first two
	// cases are a character's first session, which costs more a frame).
	per_kill("training banner up", &d, 40.0);
}
