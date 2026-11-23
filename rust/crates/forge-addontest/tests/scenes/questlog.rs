//! A full quest log: a level-10 Human partway through the Elwynn Forest guide Polestar loads for it, standing in
//! Goldshire with 25 quests: the guide's quests still being worked, the guide's quests ready to hand in, and
//! finished quests the guide never names. Talking to the NPCs who end both kinds, with the default settings,
//! auto turn-in hands in the guide's quests and never another one (#2918); nothing goes to chat; a burst of
//! quest log updates costs little.

use crate::common::{play, release_or_skip, Play};
use serde_json::Value;

/// A character Polestar knows (its saved variables exist, Install was had), with every setting at its default.
pub const KNOWN: &str = "PolestarDB = { schema = 1, settings = {}, welcomeSeen = 1 }\nPolestarCharDB = { schema = 1 }";

/// The quest stubs and the place: Goldshire, level 10, before login.
pub fn goldshire(script: &str) -> Play {
	Play {
		stubs: vec!["stub_scenes_quests.lua"],
		before: "ScenesQ.goldshire()\nScene.atLogin = Scene.snap()".into(),
		saved: vec![("Polestar".into(), KNOWN.into())],
		script: script.into(),
		..Default::default()
	}
}

/// Lua: the character placed at the guide step that hands in most quests to Marshal Dughan, its log filled to 25
/// with finished quests the guide does not name; `at`, `off` (those quests) and `named` (listed ones the guide
/// names, left out) set.
pub const FULL_LOG: &str = r#"
local w = stub.world
at = ScenesQ.place(240)
if not at then error("no guide loaded, or none that hands in a quest to Marshal Dughan (240)", 0) end
off, named = ScenesQ.fillLog(25)
isOff = {}
for _, q in ipairs(off) do isOff[q] = true end
logSize = 0
for _ in pairs(w.log) do logSize = logSize + 1 end
"#;

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or(f64::NAN)
}

/// An emitted Lua table with nothing in it (an empty table is emitted as `{}`), or nothing at all.
pub fn empty(v: &Value) -> bool {
	match v {
		Value::Null => true,
		Value::Array(a) => a.is_empty(),
		Value::Object(o) => o.is_empty(),
		_ => false,
	}
}

fn first(out: Vec<Value>) -> Value {
	out.into_iter().next().expect("the scene emitted nothing")
}

#[test]
fn a_full_log_hands_in_only_the_guides_quests_2918() {
	let Some(_) = release_or_skip() else { return };
	let out = first(play(&goldshire(&format!(
		r#"{FULL_LOG}
local s = Scene.snap()
local talks = {{}}
for _, npc in ipairs({{ 240, 241, 253, 514, 295 }}) do talks[#talks + 1] = ScenesQ.talk(npc, "gossip") end
-- The same NPCs' greeting windows, and an off-guide quest's own progress and reward windows.
talks[#talks + 1] = ScenesQ.talk(240, "greeting")
talks[#talks + 1] = ScenesQ.talk(514, "greeting")
local direct = nil
for _, e in ipairs(ScenesQ.OFF_NEAR) do if w.log[e[1]] and not direct then direct = e end end
if direct then
	w.questProgress(direct[2], direct[1]); stub.advance(2); if w.frame then w.close() end
	if w.log[direct[1]] then w.questComplete(direct[2], direct[1]); stub.advance(2); if w.frame then w.close() end end
end
local d = Scene.since(s)
local offActs, guideIn = {{}}, {{}}
for _, c in ipairs(w.calls) do
	if isOff[c[2]] then offActs[#offActs + 1] = c[1] .. " " .. c[2] end
	if c[1] == "GetQuestReward" and c[2] and not isOff[c[2]] then guideIn[#guideIn + 1] = c[2] end
end
emit({{ at = at, off = off, named = named, logSize = logSize, offActs = offActs, guideIn = guideIn, lines = d.lines,
	sounds = d.soundIds, alerts = d.alerts, worstTalkMs = math.max(unpack(talks)) }})
"#
	))));
	println!("{}", serde_json::to_string_pretty(&out).unwrap());
	assert_eq!(out["logSize"], 25, "the quest log holds 25 quests: {out}");
	assert!(out["off"].as_array().is_some_and(|a| a.len() >= 10), "at least 10 finished quests the guide does not name: {}", out["off"]);
	let off_acts = out["offActs"].as_array().cloned().unwrap_or_default();
	let handed: Vec<&str> = off_acts.iter().filter_map(|a| a.as_str()?.strip_prefix("GetQuestReward ")).collect();
	assert!(
		off_acts.is_empty(),
		"auto turn-in handed in {} quests the guide does not name, with default settings (#2918; the player keeps them for later): {}; every action on such quests: {}",
		handed.len(),
		handed.join(", "),
		Value::Array(off_acts.clone())
	);
	assert!(out["guideIn"].as_array().is_some_and(|a| !a.is_empty()), "auto turn-in handed in none of the guide's ready quests ({}): the counters are not live", out["at"]["ready"]);
	assert_eq!(out["lines"].as_array().map_or(0, Vec::len), 0, "chat lines while handing in: {}", out["lines"]);
	assert!(empty(&out["alerts"]), "alerts while handing in: {}", out["alerts"]);
}

#[test]
fn a_full_log_stays_quiet_and_a_quest_log_burst_costs_little() {
	let Some(_) = release_or_skip() else { return };
	let out = first(play(&goldshire(&format!(
		r#"{FULL_LOG}
local s = Scene.snap()
local N = 40
local burst = Scene.work(function()
	for _ = 1, N do stub.fire("QUEST_LOG_UPDATE"); stub.fire("UNIT_QUEST_LOG_CHANGED", "player") end
end)
local settle = Scene.work(function() stub.advance(3) end)
-- Objective progress on the guide's quests being worked: the client's QUEST_LOG_UPDATE and QUEST_WATCH_UPDATE.
local progress = {{ ms = 0, n = 0 }}
for _, q in ipairs(at.working) do
	local c = Scene.work(function() w.progress(q, 1, 1); stub.advance(0.5) end)
	progress.ms, progress.n = progress.ms + c.ms, progress.n + 1
end
stub.advance(5)
local d = Scene.since(s)
local login = Scene.since(Scene.atLogin)
emit({{ n = N, burstMs = burst.ms, burstKb = burst.kb, settleMs = settle.ms, progressMs = progress.n > 0 and progress.ms / progress.n or 0,
	progressN = progress.n, lines = login.lines, sounds = d.soundIds, alerts = d.alerts, actions = d.actions, logSize = logSize }})
"#
	))));
	println!("{}", serde_json::to_string_pretty(&out).unwrap());
	assert_eq!(out["logSize"], 25, "{out}");
	assert_eq!(out["lines"].as_array().map_or(0, Vec::len), 0, "chat lines from login through a full log's updates: {}", out["lines"]);
	assert_eq!(out["actions"].as_array().map_or(0, Vec::len), 0, "automatic actions while nobody was talked to: {}", out["actions"]);
	assert!(empty(&out["alerts"]), "alerts from quest log updates: {}", out["alerts"]);
	let per = num(&out["burstMs"]) / num(&out["n"]);
	// A turn-in or a loot fires several QUEST_LOG_UPDATEs in one frame; the handlers mark work and leave it for later.
	forge_addontest::assert_timing!(per < BURST_MS, "a QUEST_LOG_UPDATE with 25 quests in the log took {per:.3} ms (budget {BURST_MS} ms): {out}");
	// The debounced work the burst leaves: one evaluation of the guide and the log, whatever the burst's size.
	let settle = num(&out["settleMs"]);
	forge_addontest::assert_timing!(settle < SETTLE_MS, "the work left after 40 quest log updates took {settle:.1} ms (budget {SETTLE_MS} ms): {out}");
	let progress = num(&out["progressMs"]);
	forge_addontest::assert_timing!(progress < PROGRESS_MS, "an objective's progress with 25 quests in the log took {progress:.1} ms (budget {PROGRESS_MS} ms): {out}");
}

/// Budgets (CPU ms, quiet machine), about 5x what 0.4.1.1 takes (0.05 ms per QUEST_LOG_UPDATE with its
/// UNIT_QUEST_LOG_CHANGED, 10 ms of work left after the burst, 5 ms per objective's progress).
const BURST_MS: f64 = 0.25;
const SETTLE_MS: f64 = 50.0;
const PROGRESS_MS: f64 = 25.0;
