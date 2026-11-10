//! Timed quests (addon/Polestar/Quests/Timed.lua, 0.3.6, a Discord request): before the accept, how long the quest
//! allows (its `limit`); once taken, "M:SS left" on its goals in the guide window, full and compact, in the warning
//! colour under 2 minutes and the danger colour under 1; a chat line and a sound at 5 minutes, at 1 and when it fails
//! (qol.questTimerAlerts); and a hint on the step when the way to its hand-in (Nav.EstimateTravel) takes longer than
//! the time left. The clock is the client's (C_QuestLog.GetTimeAllowed), else the accept's time plus the guide's
//! `limit` (a delivery, ready at once, which the client may not report: recordings show 3364, 3522, 647, 853 and 97891
//! failing at exactly their limits with no timer the Recorder saw). The arrow shows the same countdown between its
//! distance and its label (Nav/Arrow.lua, syncTimer). A failed quest loses its countdown and reads as the Engine's
//! failed-quest line says. The whole addon, the stub world.

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
		script: [TEST_PACK, TEST_SOURCE, &GUIDE.replace("LIMIT", &limit.to_string()), HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
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

#[test]
fn the_arrow_counts_down_under_its_distance_while_a_timer_runs_and_the_label_moves_back_after() {
	let out = run(
		300,
		r#"
		local t0
		C_QuestLog.GetTimeAllowed = function(q) if q == 3364 and w.log[3364] then return 300, GetTime() - t0 end return 0 end
		local A = Polestar.Nav.arrow
		local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", "")) end
		local function role()
			local c = (A.timerText:GetText() or ""):match("|c(%x%x%x%x%x%x%x%x)")
			for _, k in ipairs({ "text", "warning", "danger" }) do if c and Polestar.Theme.Hex(k) == c then return k end end
			return c or false
		end
		local function labelUnder() local _, rel = A.labelText:GetPoint(1); return rel == A.timerText and "timer" or rel == A.distText and "distance" or "?" end
		local r = { before = { A.timerText:IsShown(), labelUnder() } }
		t0 = GetTime(); w.accept(3364, {}, "Scalding Mornbrew Delivery"); stub.advance(1.1)
		local wp = E.GetWaypoint()
		r.target = wp and wp.quest or false
		r.taken = { A.timerText:IsShown(), plain(A.timerText:GetText()), role(), labelUnder(), (A.timerText:GetText() or ""):find("|T", 1, true) ~= nil }
		jump(200); r.warn = role()
		jump(45); r.danger = { plain(A.timerText:GetText()), role() }
		-- A point of the player's own (no quest): the timer that runs still shows.
		Polestar.Nav.SetTarget(1429, 30, 30, "Somewhere")
		stub.advance(1.1)
		r.manual = { A.timerText:IsShown(), plain(A.timerText:GetText()) ~= "" }
		Polestar.Nav.ReleaseTarget()
		w.turnIn(3364); stub.advance(1.1)
		r.done = { A.timerText:IsShown(), labelUnder() }
		emit(r)"#,
	);
	assert_eq!(out["before"], serde_json::json!([false, "distance"]), "no timer: no line, the label under the distance");
	assert_eq!(out["target"], 3364, "the arrow leads to the timed quest's hand-in");
	let taken = &out["taken"];
	assert_eq!(taken[0], true);
	assert!(s(&taken[1]).contains("4:59 left") || s(&taken[1]).contains("4:58 left"), "{taken}");
	assert_eq!(taken[2], "text");
	assert_eq!(taken[3], "timer", "the label moves under the countdown");
	assert_eq!(taken[4], true, "with the hourglass");
	assert_eq!(out["warn"], "warning", "under 2 minutes");
	assert_eq!(out["danger"][1], "danger", "under 1 minute: {}", out["danger"]);
	assert_eq!(out["manual"], serde_json::json!([true, true]));
	assert_eq!(out["done"], serde_json::json!([false, "distance"]), "handed in: the line goes, the label comes back up");
}

#[test]
fn a_delivery_ready_at_the_accept_counts_down_from_the_guides_limit_and_its_failure_reads_one_way() {
	let out = run(
		600,
		r#"
		-- The client has the API but reports no time for a quest ready at once (what the recordings point to).
		C_QuestLog.GetTimeAllowed = function() return 0, 0 end
		C_QuestLog.IsFailed = function(q) return w.log[q] and w.log[q].failed or false end
		local A = Polestar.Nav.arrow
		local r = {}
		w.accept(3364, {}, "Scalding Mornbrew Delivery"); stub.advance(1.1)
		r.ready = C_QuestLog.ReadyForTurnIn(3364)
		r.step, r.taken, r.arrow = E.GetStepIndex(), rows(), A.timerText:IsShown()
		r.record = Polestar.CharState().timedAccepts[3364] ~= nil
		jump(420); r.later = rows()
		w.log[3364].failed = true; stub.fire("QUEST_LOG_UPDATE"); stub.advance(1.1)
		r.failed, r.failedArrow = rows(), A.timerText:IsShown()
		r.said = { said("failed: its time ran out"), said("failed") }
		w.abandon(3364); stub.advance(1.1)
		r.abandoned = rows()
		w.accept(3364, {}, "Scalding Mornbrew Delivery"); stub.advance(1.1)
		r.again = rows()
		emit(r)"#,
	);
	assert_eq!(out["ready"], true, "a delivery: ready at the accept");
	assert_eq!(out["step"], 2);
	let taken = s(&out["taken"]);
	assert!(taken.contains("9:59 left") || taken.contains("9:58 left"), "the guide's 600 s from the accept: {taken}");
	assert_eq!(out["arrow"], true, "the arrow counts down too");
	assert_eq!(out["record"], true, "kept in CharState over a reload");
	assert!(s(&out["later"]).contains("2:5") || s(&out["later"]).contains("3:0"), "{}", out["later"]);
	let failed = s(&out["failed"]);
	assert!(!failed.contains(" left"), "failed: no countdown ({failed})");
	assert!(failed.contains("failed: abandon it and take it again"), "the Engine's failed line: {failed}");
	assert_eq!(out["failedArrow"], false);
	assert_eq!(out["said"], serde_json::json!([1, 1]), "one chat line, telling the same thing");
	assert!(s(&out["abandoned"]).contains("Timed: 10 min once accepted"), "back at the giver, the accept says how long: {}", out["abandoned"]);
	let again = s(&out["again"]);
	assert!(again.contains("9:59 left") || again.contains("9:58 left"), "taken again, the clock starts afresh: {again}");
}

// 0.3.7 (Apothecary Zamah, taken with 42:00 left on the Barrens route, which never goes to Thunder Bluff): a
// timed quest no guide step takes counts down from the quest database's limit (QuestDB.TimeLimit, Polestar_QuestDB's
// 20th quest field) when the client reports no timer, and the guide window's While-here panel opens with a row for it:
// "Apothecary Zamah  44:59 left / Thunder Bluff ~6 min · this guide doesn't go there". A click points the arrow at
// the ender with its height (Nav.SetTarget), a right-click hides the row until the timer ends; in combat the row
// never comes or goes (it catches up when the fight ends). The guide's own timed quest gets no such row.
const OFF_ROUTE: &str = r#"
	w.addMap(1456, { name = "Thunder Bluff", c = 1, left = 500, right = -1500, top = 0, bottom = -1300 })
	C_QuestLog.GetTimeAllowed = function() return 0, 0 end
	C_QuestLog.IsFailed = function(q) return w.log[q] and w.log[q].failed or false end
	Polestar.QuestDB.TimeLimit = function(q) return q == 853 and 2700 or nil end
	Polestar.Codex.Quest = function(q) if q == 853 then return { id = 853, ["end"] = { npc = { 3419 } } } end end
	Polestar.Lookup.QuestEnd = function(ends)
		if ends and ends.npc and ends.npc[1] == 3419 then
			return { npc = 3419, name = "Apothecary Zamah", spawn = { map = 1456, x = 22.81, y = 20.89, f = "e", z = 21.5 } }
		end
	end
	Polestar.Nav.EstimateTravel = function() return 360 end
	local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", "")) end
	-- The While-here panel's rows on screen (a row the panel is fading out with holds no view): "text / subline".
	function here()
		local out, h = {}, GF.here
		if not h:IsShown() then return "" end
		for _, r in ipairs(h.Rows) do
			if r:IsShown() and (r.psOff or r.psView) then out[#out + 1] = plain(r.Text:GetText()) .. (r.Sub:IsShown() and (" / " .. plain(r.Sub:GetText())) or "") end
		end
		return table.concat(out, " | ")
	end
	function click(button) local r = GF.here.Rows[1]; r:GetScript("OnClick")(r, button) end
"#;

#[test]
fn a_timed_quest_the_route_never_hands_in_counts_down_from_the_quest_database_and_gets_its_own_while_here_row() {
	let out = run(
		600,
		&format!(
			"{OFF_ROUTE}{}",
			r#"
		local A = Polestar.Nav.arrow
		local r = {}
		w.accept(853, {}, "Apothecary Zamah"); stub.advance(1.1)
		local rec = Polestar.CharState().timedAccepts[853]
		r.record = rec and rec.limit or false
		r.left = math.floor((Polestar.Timed.Left(853) or 0) + 0.5)
		r.arrow = A.timerText:IsShown()
		r.row = here()
		r.label = plain(GF.here.Label:GetText())
		click("LeftButton")
		local t = Polestar.Nav.GetTarget()
		r.target = t and { t.map, t.x, t.y, t.z, t.label } or false
		jump(30); r.later = here()
		-- In combat the row stays, even once the quest has left the log; after the fight it goes.
		stub.fire("PLAYER_REGEN_DISABLED")
		w.abandon(853); stub.advance(1.1)
		r.combat = here()
		stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(1.1)
		r.after = here()
		-- Taken again, then hidden with a right-click until its timer ends.
		w.accept(853, {}, "Apothecary Zamah"); stub.advance(1.1)
		r.again = here()
		click("RightButton"); stub.advance(1.1)
		r.muted = { here(), Polestar.Timed.Left(853) ~= nil }
		emit(r)"#
		),
	);
	assert_eq!(out["record"], 2700, "the quest database's limit starts the clock at the accept");
	let left = out["left"].as_i64().unwrap();
	assert!((2697..=2700).contains(&left), "{left}");
	assert_eq!(out["arrow"], true, "the arrow counts it down too");
	let row = s(&out["row"]);
	assert!(row.starts_with("Apothecary Zamah  44:5"), "{row}");
	assert!(row.contains(" left / Thunder Bluff ~6 min · this guide doesn't go there"), "{row}");
	assert_eq!(out["label"], "Timed quest", "only the off-route row: the panel says what it is");
	assert_eq!(out["target"], serde_json::json!([1456, 22.81, 20.89, 21.5, "Apothecary Zamah"]), "the arrow to Zamah, with his height");
	assert!(s(&out["later"]).contains("44:2"), "the row counts down: {}", out["later"]);
	assert!(s(&out["combat"]).starts_with("Apothecary Zamah"), "no row goes in combat: {}", out["combat"]);
	assert_eq!(out["after"], "", "after the fight the abandoned quest's row goes");
	assert!(s(&out["again"]).contains("44:5"), "taken again: {}", out["again"]);
	assert_eq!(out["muted"], serde_json::json!(["", true]), "right-click hides the row; the timer itself runs on");
}

#[test]
fn a_timed_quest_the_route_hands_in_gets_no_off_route_row() {
	let out = run(
		600,
		&format!(
			"{OFF_ROUTE}{}",
			r#"
		w.accept(3364, {}, "Scalding Mornbrew Delivery"); stub.advance(1.1)
		emit({ left = Polestar.Timed.Left(3364) ~= nil, row = here(), off = #Polestar.Timed.OffRoute({}) })"#
		),
	);
	assert_eq!(out["left"], true, "the guide's own timed quest counts down");
	assert_eq!(out["off"], 0);
	assert!(!s(&out["row"]).contains("doesn't go there"), "{}", out["row"]);
}
