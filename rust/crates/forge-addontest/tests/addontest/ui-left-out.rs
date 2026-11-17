//! What the guide leaves out, in the guide window (#2634): a dim "N left out here" line on the live step's card
//! that opens to each quest with why (Engine.LeftOutHere), "Guide me" on a quest that needs another first (Lookup's
//! guide to it) and "Turn off Skip grey quests"; the grind step's why and what else is near; the cleanup nudge
//! with 3 or more quests off the route (RoutePlan.OffRoute); the step browser's line on each card. In every look,
//! and off with guideWindow.leftOut. Against the real Core + Theme + UI manifests and the fake Engine
//! (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The fake Engine's left-out list for step 3 of Elwynn, a grind hint for step 4, quests off the route.
const SETUP: &str = r#"
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", "")):gsub("|r", "") end
local function lineFor(needle)
	for _, l in ipairs(GF.lines) do
		if l:IsShown() and plain(l.Text:GetText()):find(needle, 1, true) then return l end
	end
end
-- The card's summary lines top to bottom, plain, "+" on an opened one, ">" with a chevron to the right.
local function lines()
	local out = {}
	for _, f in ipairs(GF.CardItems()) do
		if f.psLine then
			local tex = f.Chevron:IsShown() and f.Chevron:GetTexture() or ""
			out[#out + 1] = plain(f.Text:GetText()) .. (tex:match("chevron%-up") and "+" or tex:match("chevron%-right") and ">" or "")
		end
	end
	return out
end
local E = Polestar.Engine
E.LeftOutHere = function(i, alone)
	if i ~= 3 then return {} end
	return {
		{ quest = 1150, title = "Test of Endurance", kind = "pre", text = "Requires “Test of Faith” first", fix = { kind = "chain", quest = 1150 }, step = 3 },
		{ quest = 6462, title = "Troll Charm", kind = "catchup", text = "Pays 60% XP at your level and is out of the way (Skip grey quests)", fix = { kind = "skipGrey" }, step = 3 },
	}
end
OFF = {}
Polestar.RoutePlan = Polestar.RoutePlan or {}
Polestar.RoutePlan.OffRoute = function() return OFF end
GUIDED, ROOM = {}, {}
Polestar.Lookup = Polestar.Lookup or {}
Polestar.Lookup.Guide = function(kind, id) GUIDED[#GUIDED + 1] = kind .. ":" .. id; return "lookup/quest/" .. id end
local showRoom = UI.ShowQuestRoom
UI.ShowQuestRoom = function(mode) ROOM[#ROOM + 1] = mode or "room" end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\nlocal GF, UI = Polestar.UI.GuideFrame, Polestar.UI\n{SETUP}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn strings(v: &Value) -> Vec<String> {
	v.as_array().unwrap().iter().map(|x| text(x).to_string()).collect()
}

#[test]
fn the_card_says_how_many_are_left_out_here_and_opens_to_each_with_why_and_a_fix() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local closed = lines()
		stub.RunScript(lineFor("left out here"), "OnClick", "LeftButton")
		local opened = lines()
		stub.RunScript(lineFor("Test of Endurance"), "OnClick", "LeftButton")
		stub.RunScript(lineFor("Turn off Skip grey quests"), "OnClick", "LeftButton")
		local dim = { lineFor("left out here").Text:GetTextColor() }
		local want = { Polestar.Theme.Color("textDim") }
		emit({ closed = closed, opened = opened, guided = GUIDED, grey = Polestar.Get("behavior.skipGrey"),
			dim = math.abs(dim[1] - want[1]) < 0.002 and math.abs(dim[2] - want[2]) < 0.002 })"#);
	assert_eq!(strings(&out["closed"]).last().unwrap(), "2 left out here", "{out}");
	let opened = strings(&out["opened"]);
	let at = opened.iter().position(|s| s == "2 left out here+").unwrap_or_else(|| panic!("{out}"));
	assert_eq!(
		opened[at + 1..],
		[
			"Test of Endurance  \u{b7}  Requires \u{201c}Test of Faith\u{201d} first  \u{b7}  Guide me>",
			"Troll Charm  \u{b7}  Pays 60% XP at your level and is out of the way (Skip grey quests)",
			"Turn off Skip grey quests>",
		]
	);
	assert_eq!(out["guided"], json!(["quest:1150"]), "Guide me: Lookup's guide to the quest through what it needs");
	assert_eq!(out["grey"], false, "Turn off: the setting goes off");
	assert_eq!(out["dim"], true, "the line is dim");
}

#[test]
fn guide_window_left_out_off_hides_the_lines() {
	let out = run(r#"
		Polestar.Set("guideWindow.leftOut", false)
		OFF = { { quest = 1, title = "A" }, { quest = 2, title = "B" }, { quest = 3, title = "C" } }
		uistub.setGuide(uistub.elwynn, 3)
		emit({ lines = lines() })"#);
	assert!(!strings(&out["lines"]).iter().any(|s| s.contains("left out") || s.contains("route")), "{out}");
}

#[test]
fn three_quests_off_the_route_bring_the_cleanup_nudge_two_do_not() {
	let out = run(r#"
		OFF = { { quest = 1, title = "A" }, { quest = 2, title = "B" } }
		uistub.setGuide(uistub.elwynn, 2)
		local two = lines()
		OFF = { { quest = 1, title = "A" }, { quest = 2, title = "B" }, { quest = 3, title = "C" } }
		uistub.setStep(1)
		local three = lines()
		stub.RunScript(lineFor("part of your route"), "OnClick", "LeftButton")
		emit({ two = two, three = three, room = ROOM })"#);
	assert!(!strings(&out["two"]).iter().any(|s| s.contains("route")), "{out}");
	assert_eq!(strings(&out["three"]).last().unwrap(), "3 quests aren't part of your route>", "{out}");
	assert_eq!(out["room"], json!(["offroute"]));
}

#[test]
fn a_grind_step_says_why_and_what_is_still_worth_doing_near_here() {
	let out = run(r#"
		local steps = uistub.guides[uistub.elwynn].steps
		steps[#steps + 1] = { title = "Level 32", goals = { { t = "level", verb = "Reach", subject = "level 32", subjectKind = "text", status = "active", level = 32 } } }
		local n = #steps
		E.GrindHint = function(i) if i == n then return { lo = 32, hi = 35, nearby = { { quest = 5147, title = "WANTED: Arnak Grimtotem", share = 1, step = 2 } } } end end
		uistub.player.level = 31
		uistub.setGuide(uistub.elwynn, n)
		local got = lines()
		stub.RunScript(lineFor("Worth doing"), "OnClick", "LeftButton")
		emit({ lines = got, at = E.GetStepIndex() })"#);
	let lines = strings(&out["lines"]);
	assert!(lines.contains(&"You're 31: the quests after this are level 32\u{2013}35".to_string()), "{out}");
	assert!(lines.contains(&"Worth doing near here: WANTED: Arnak Grimtotem>".to_string()), "{out}");
	assert_eq!(out["at"], 2, "a click shows the quest's step: {out}");
}

// Every look: the line and its opened list read in each, with no error.
#[test]
fn the_left_out_lines_read_in_every_look() {
	let out = run(r#"
		local got = {}
		for _, skin in ipairs({ "polestar", "hearth", "forever", "blizzard", "classic", "halo" }) do
			Polestar.Set("ui.skin", skin)
			uistub.setGuide(uistub.elwynn, 3)
			-- Opened once, the line stays open for the step as the look changes.
			if not lineFor("Test of Endurance") then stub.RunScript(lineFor("left out here"), "OnClick", "LeftButton") end
			local l = lineFor("Test of Endurance")
			got[skin] = l and l:IsShown() and l:GetHeight() > 0 and #lines() or false
		end
		emit(got)"#);
	for skin in ["polestar", "hearth", "forever", "blizzard", "classic", "halo"] {
		assert!(out[skin].as_u64().unwrap_or(0) >= 4, "{skin}: {out}");
	}
}

// The step browser: a muted line on the card of a step with quests left out, the reasons in its tooltip.
#[test]
fn the_step_browser_marks_a_step_with_quests_left_out() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 1)
		UI.StepList.Toggle(true)
		local card
		for _, r in ipairs(UI.StepList.rows) do if r:IsShown() and r.psIndex == 3 then card = r end end
		local said = {}
		for j = 1, card.psN do said[#said + 1] = plain(card.G[j].Text:GetText()) end
		emit({ said = said, out = #card.psOut })"#);
	assert_eq!(strings(&out["said"]).last().unwrap(), "2 left out here", "{out}");
	assert_eq!(out["out"], 2);
}
