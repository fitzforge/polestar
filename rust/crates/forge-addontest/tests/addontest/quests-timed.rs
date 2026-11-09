//! Timed quests (addon/Polestar/Quests/Timed.lua, 0.3.7, a Discord request): before the accept, how long the quest
//! allows (its `limit`); once taken, "M:SS left" on its goals in the guide window, full and compact, in the warning
//! colour under 2 minutes and the danger colour under 1; a chat line and a sound at 5 minutes, at 1 and when it fails
//! (qol.questTimerAlerts); and a hint on the step when the way to its hand-in (Nav.EstimateTravel) takes longer than
//! the time left. The clock is the client's (C_QuestLog.GetTimeAllowed), else the accept's time plus the guide's
//! `limit` (a delivery, ready at once, which the client may not report: recordings show 3364, 3522, 647, 853 and 97891
//! failing at exactly their limits with no timer the Recorder saw). The whole addon, the stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.level = 5
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 47.6, 45.1)
"#;

// Scalding Mornbrew Delivery as the Dwarf guide has it: Nori's accept (limit LIMIT), Durnan's hand-in far off.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/timed", pack = "test", title = "Timed", minLevel = 1, maxLevel = 10, steps = {
	{ title = "Nori", goals = {
		{ t = "accept", quest = 3364, title = "Scalding Mornbrew Delivery", npc = 12738, npcName = "Nori Pridedrift", minLevel = 4, qlvl = 5, limit = LIMIT,
			map = 1429, x = 47.6, y = 45.1 },
	} },
	{ title = "Durnan", goals = {
		{ t = "turnin", quest = 3364, title = "Scalding Mornbrew Delivery", npc = 836, npcName = "Durnan Furcutter", map = 1429, x = 20.0, y = 60.0 },
	} },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
GF = Polestar.UI.GuideFrame
PolestarGuideFrame:Show()
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", "")) end
-- The window's goal rows: "text / subline".
function rows()
	local out = {}
	for _, r in ipairs(GF.rows) do
		if r:IsShown() then out[#out + 1] = plain(r.Text:GetText()) .. (r.Sub:IsShown() and (" / " .. plain(r.Sub:GetText())) or "") end
	end
	return table.concat(out, " | ")
end
-- The countdown's colour: "text", "warning", "danger" or false.
function colour()
	for _, r in ipairs(GF.rows) do
		local c = r:IsShown() and (r.Text:GetText() or ""):match("|c(%x%x%x%x%x%x%x%x)%d+:%d%d left|r")
		if c then
			for _, role in ipairs({ "text", "warning", "danger" }) do if Polestar.Theme.Hex(role) == c then return role end end
			return c
		end
	end
	return false
end
-- Jump the clock by s seconds (the last second played, so the ticker runs).
function jump(s) stub.now = stub.now + s - 1.1; stub.advance(1.1) end
-- Sounds on the Master channel (the alerts'; the stub's SOUNDKIT ids are all 1).
warnings = 0
local play = PlaySound
PlaySound = function(id, channel) if channel == "Master" then warnings = warnings + 1 end return play(id, channel) end
function said(pattern)
	local n = 0
	for _, m in ipairs(stub.messages) do if m:find(pattern) then n = n + 1 end end
	return n
end
"#;

fn run(limit: u32, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/timed" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &GUIDE.replace("LIMIT", &limit.to_string()), HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script]
			.join("\n"),
		..Default::default()
	})
	.remove(0)
}

fn s(v: &Value) -> &str {
	v.as_str().unwrap_or_else(|| panic!("not a string: {v}"))
}

#[test]
fn the_window_counts_down_on_the_timed_quests_step_in_the_colours_and_hints_when_the_way_is_too_long() {
	let out = run(
		300,
		r#"
		local t0
		C_QuestLog.GetTimeAllowed = function(q) if q == 3364 and w.log[3364] then return 300, GetTime() - t0 end return 0 end
		Polestar.Nav.EstimateTravel = function() return 150 end
		local r = { before = rows() }
		t0 = GetTime(); w.accept(3364, {}, "Scalding Mornbrew Delivery"); stub.advance(1.1)
		r.step, r.taken, r.colourTaken = E.GetStepIndex(), rows(), colour()
		jump(200)
		r.warn, r.colourWarn = rows(), colour()
		jump(45)
		r.danger, r.colourDanger = rows(), colour()
		Polestar.Set("ui.compact", true); stub.advance(1.1)
		r.compact = rows()
		Polestar.Set("ui.compact", false)
		w.turnIn(3364); stub.advance(1.1)
		r.done = rows()
		emit(r)"#,
	);
	assert!(s(&out["before"]).contains("Timed: 5 min once accepted"), "{}", out["before"]);
	assert_eq!(out["step"], 2);
	let taken = s(&out["taken"]);
	assert!(taken.contains("4:59 left") || taken.contains("4:58 left"), "{taken}");
	assert!(!taken.contains("The way to"), "150 s of way, 5 minutes left: no hint ({taken})");
	assert_eq!(out["colourTaken"], "text");
	assert!(s(&out["warn"]).contains("1:3") || s(&out["warn"]).contains("1:4"), "{}", out["warn"]);
	assert_eq!(out["colourWarn"], "warning", "under 2 minutes");
	assert!(s(&out["warn"]).contains("The way to Durnan Furcutter takes about 3 min, longer than the time left"), "{}", out["warn"]);
	assert_eq!(out["colourDanger"], "danger", "under 1 minute");
	assert!(s(&out["compact"]).contains(" left"), "compact mode keeps the countdown: {}", out["compact"]);
	assert!(!s(&out["done"]).contains(" left"), "handed in: no countdown ({})", out["done"]);
}

#[test]
fn alerts_at_five_minutes_one_minute_and_on_failure_once_each_and_only_with_the_option_on() {
	let out = run(
		600,
		r#"
		C_QuestLog.GetTimeAllowed = nil           -- the client reports no timer: the guide's limit and the accept's time
		C_QuestLog.IsFailed = function(q) return w.log[q] and w.log[q].failed or false end
		local r = {}
		w.accept(3364, {}, "Scalding Mornbrew Delivery"); stub.advance(1.1)
		r.start = { said("left"), warnings }
		jump(299); r.five = { said("5 minutes left"), warnings }
		jump(10); r.fiveOnce = said("5 minutes left")
		jump(235); r.one = { said("1 minute left"), warnings }
		r.clock = rows()
		w.log[3364].failed = true; stub.fire("QUEST_LOG_UPDATE"); stub.advance(1.1)
		r.failed = { said("failed: its time ran out"), warnings }
		jump(5); r.failedOnce = said("failed")
		-- Off: the countdown stays, nothing is said.
		Polestar.Set("qol.questTimerAlerts", false)
		w.abandon(3364); stub.advance(1.1)
		local before = said("left") + said("failed")
		w.accept(3364, {}, "Scalding Mornbrew Delivery"); stub.advance(1.1)
		jump(300); jump(240)
		r.off = { said("left") + said("failed") - before, rows():find(" left") ~= nil }
		emit(r)"#,
	);
	assert_eq!(out["start"], serde_json::json!([0, 0]), "nothing at the accept");
	assert_eq!(out["five"], serde_json::json!([1, 1]), "“Scalding Mornbrew Delivery”: 5 minutes left, with a sound");
	assert_eq!(out["fiveOnce"], 1);
	assert_eq!(out["one"], serde_json::json!([1, 2]));
	assert!(s(&out["clock"]).contains("0:5") || s(&out["clock"]).contains("1:0"), "the data's clock counts down: {}", out["clock"]);
	assert_eq!(out["failed"], serde_json::json!([1, 3]));
	assert_eq!(out["failedOnce"], 1);
	assert_eq!(out["off"], serde_json::json!([0, true]));
}
