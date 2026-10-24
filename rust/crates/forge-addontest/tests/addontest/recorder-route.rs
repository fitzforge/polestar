//! Route telemetry in the recorder (addon/Polestar_Recorder/Route.lua): `step` snapshots from Polestar's message
//! bus, combat/AFK/revive events, and running with Polestar absent, late or broken.

use forge_addontest::{emitted, RunAddon};
use serde_json::{json, Value};

const REC: &str = "Polestar_Recorder";

// A stand-in for Polestar's bus and Engine (docs/ARCHITECTURE.md "Message bus", "Tabs"): __fire(msg, ...)
// delivers a message; __polestar.guide/step is the active tab.
const FAKE_POLESTAR: &str = r#"
__polestar = {
	handlers = {},
	guides = {
		g1 = { id = "forever/alliance/human/01-elwynn", title = "Elwynn Forest", steps = { { title = "Deputy Willem" }, { title = "Kobold Camp" }, { title = "Wolves" } } },
		g2 = { id = "professions/mining", title = "Mining 1-75", steps = { { title = "Learn Mining" } } },
	},
}
__polestar.guide, __polestar.step = __polestar.guides.g1, 2
function __installPolestar()
	Polestar = {
		On = function(msg, fn)
			__polestar.handlers[msg] = __polestar.handlers[msg] or {}
			table.insert(__polestar.handlers[msg], fn)
			return {}
		end,
		Engine = {
			GetGuide = function() return __polestar.guide end,
			GetStepIndex = function() return __polestar.step end,
		},
	}
end
function __fire(msg, ...)
	for _, fn in ipairs(__polestar.handlers[msg] or {}) do fn(...) end
end
"#;

const PRELUDE: &str = r#"
local function S() return PolestarRecorderDB.sessions[PolestarRecorderDB.current] end
local function events(kind)
	local out = {}
	for _, e in ipairs(S().events) do
		if e.e == kind then
			local c = {}
			for k, v in pairs(e) do if k ~= "t" then c[k] = v end end
			out[#out + 1] = c
		end
	end
	return out
end
"#;

fn run_with(script: &str, before: &str, login: bool, saved: Option<String>) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_recorder.lua"],
		addons: vec![REC.into()],
		login,
		saved: saved.map(|s| (REC.to_string(), s)).into_iter().collect(),
		before: format!("{FAKE_POLESTAR}{before}"),
		script: format!("{PRELUDE}{script}"),
	})
}

fn run(script: &str, before: &str) -> Value {
	run_with(script, before, true, None).remove(0)
}

#[test]
fn step_snapshots_at_login_on_every_step_change_on_a_tab_switch_once_and_at_guide_completion() {
	let out = run(
		r#"
		stub.world.xp, stub.world.money, stub.world.rested = 120, 4200, 800
		stub.advance(5)
		__polestar.step = 3
		__fire("STEP_CHANGED", 3)
		stub.advance(5)
		-- switching tabs fires GUIDE_CHANGED then STEP_CHANGED for the same state
		__polestar.guide, __polestar.step = __polestar.guides.g2, 1
		__fire("GUIDE_CHANGED", "professions/mining")
		__fire("STEP_CHANGED", 1)
		stub.advance(5)
		stub.world.combat = true
		__polestar.guide, __polestar.step = __polestar.guides.g1, 3
		__fire("GUIDE_CHANGED", "forever/alliance/human/01-elwynn")
		stub.world.combat = false
		stub.advance(5)
		__polestar.step = nil
		__fire("STEP_CHANGED", nil)
		__fire("GUIDE_COMPLETED", "forever/alliance/human/01-elwynn")
		emit(events("step"))"#,
		"__installPolestar(); stub.world.level, stub.world.xp = 3, 100; stub.moveTo(48.2, 41.9)",
	);
	let out = out.as_array().unwrap();
	assert_eq!(out.len(), 6);
	for e in out {
		assert!(e["time"].is_number());
	}
	let stripped: Vec<Value> = out
		.iter()
		.map(|e| {
			let mut c = e.clone();
			c.as_object_mut().unwrap().remove("time");
			c
		})
		.collect();
	let with_base = |mut v: Value| {
		for (k, x) in json!({ "v": 1, "lvl": 3, "xpMax": 400, "map": 1429, "x": 48.2, "y": 41.9 }).as_object().unwrap() {
			v[k] = x.clone();
		}
		v
	};
	let want: Vec<Value> = [
		json!({ "e": "step", "reason": "login", "guide": "forever/alliance/human/01-elwynn", "step": 2, "title": "Kobold Camp", "guideTitle": "Elwynn Forest", "xp": 100, "money": 0 }),
		json!({ "e": "step", "reason": "step", "guide": "forever/alliance/human/01-elwynn", "step": 3, "title": "Wolves", "xp": 120, "money": 4200, "rested": 800 }),
		json!({ "e": "step", "reason": "guide", "guide": "professions/mining", "step": 1, "title": "Learn Mining", "guideTitle": "Mining 1-75", "xp": 120, "money": 4200, "rested": 800 }),
		json!({ "e": "step", "reason": "guide", "guide": "forever/alliance/human/01-elwynn", "step": 3, "title": "Wolves", "guideTitle": "Elwynn Forest", "xp": 120, "money": 4200, "rested": 800, "combat": true }),
		json!({ "e": "step", "reason": "step", "guide": "forever/alliance/human/01-elwynn", "xp": 120, "money": 4200, "rested": 800 }),
		json!({ "e": "step", "reason": "complete", "guide": "forever/alliance/human/01-elwynn", "xp": 120, "money": 4200, "rested": 800 }),
	]
	.into_iter()
	.map(with_base)
	.collect();
	assert_eq!(stripped, want);
}

#[test]
fn a_reload_snapshots_the_current_step_again_into_the_same_session() {
	let first = run("emit(stub.serialize(PolestarRecorderDB))", "__installPolestar()");
	let out = run_with(
		r#"
		stub.fire("PLAYER_LOGIN")
		stub.fire("PLAYER_ENTERING_WORLD", false, true)
		local reasons = {}
		for _, e in ipairs(events("step")) do reasons[#reasons + 1] = e.reason .. ":" .. e.step end
		local n = 0
		for _ in pairs(PolestarRecorderDB.sessions) do n = n + 1 end
		emit({ reasons = reasons, sessions = n })"#,
		"__installPolestar(); stub.epoch = stub.epoch + 60",
		false,
		Some(format!("PolestarRecorderDB = {}", first.as_str().unwrap())),
	);
	assert_eq!(out[0], json!({ "reasons": ["login:2", "login:2"], "sessions": 1 }));
}

#[test]
fn combat_afk_and_revive_events() {
	let out = run(
		r#"
		stub.moveTo(40, 40)
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(10)
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.fire("PLAYER_REGEN_ENABLED") -- no second "off"
		stub.world.afk = true
		stub.fire("PLAYER_FLAGS_CHANGED", "player")
		stub.fire("PLAYER_FLAGS_CHANGED", "player") -- unchanged: nothing
		stub.world.afk = false
		stub.fire("PLAYER_FLAGS_CHANGED", "player")
		stub.fire("PLAYER_FLAGS_CHANGED", "party1")
		-- die, release (PLAYER_ALIVE while a ghost: not a revive), run back
		stub.world.dead = true
		stub.fire("PLAYER_DEAD")
		stub.fire("PLAYER_ALIVE")
		stub.moveTo(41, 41)
		stub.world.dead = false
		stub.fire("PLAYER_UNGHOST")
		stub.fire("PLAYER_ALIVE") -- already alive: no second revive
		emit({ combat = events("combat"), afk = events("afk"), death = #events("death"), revive = events("revive") })"#,
		"",
	);
	assert_eq!(out["combat"], json!([{ "e": "combat", "on": true, "map": 1429, "x": 40, "y": 40 }, { "e": "combat", "on": false }]));
	assert_eq!(out["afk"], json!([{ "e": "afk", "on": true }, { "e": "afk", "on": false }]));
	assert_eq!(out["death"], 1);
	assert_eq!(out["revive"], json!([{ "e": "revive", "map": 1429, "x": 41, "y": 41 }]));
}

#[test]
fn without_polestar_nothing_is_snapshotted_and_nothing_errors_a_late_or_broken_polestar_is_handled() {
	let absent = run(
		r#"
		stub.fire("PLAYER_REGEN_DISABLED")
		emit({ steps = #events("step"), combat = #events("combat") })"#,
		"",
	);
	assert_eq!(absent, json!({ "steps": 0, "combat": 1 }));

	// Polestar loads after the recorder: attached on its ADDON_LOADED.
	let late = run(
		r#"
		__installPolestar()
		stub.addonLoaded("Polestar")
		__polestar.step = 3
		__fire("STEP_CHANGED", 3)
		local s = {}
		for _, e in ipairs(events("step")) do s[#s + 1] = e.reason .. ":" .. e.step end
		emit(s)"#,
		"",
	);
	assert_eq!(late, json!(["step:3"]));

	// An Engine that errors or returns junk: snapshots carry what is known.
	let broken = run(
		r#"
		Polestar.Engine.GetGuide = function() error("boom") end
		__fire("STEP_CHANGED", 2)
		__fire("GUIDE_CHANGED", { id = "x/y" })
		__fire("GUIDE_COMPLETED", nil)
		local s = {}
		for _, e in ipairs(events("step")) do s[#s + 1] = { e.reason, e.guide or false, e.step or false } end
		emit(s)"#,
		"__installPolestar()",
	);
	assert_eq!(broken, json!([["login", "forever/alliance/human/01-elwynn", 2], ["step", false, 2], ["guide", "x/y", false]]));
}
