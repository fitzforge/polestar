//! The guide window's tweaks round (A to D): a lone tab has no ×, the bug report lives in the ⋯ menu, Nearby
//! services carries its word when the navigator has room, section labels are quiet small caps, the notices are
//! one-line strips with the action inline and the whole text in a tooltip, the compact window's progress is a thin
//! line under the navigator, a title that says its first goal takes that goal over, and the Journey's "then" line
//! and the step list do not repeat what the window already says. Against the real Core + Theme + UI manifests and
//! the fake Engine (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const HELPERS: &str = r#"
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
local function size(fs) local _, s = fs:GetFont() return s end
local function subjects()
	local out = {}
	for _, r in ipairs(GF.rows) do if r:IsShown() and r.psGoal then out[#out + 1] = r.psGoal.subject end end
	return out
end
-- A step whose title says its first goal, and one whose title does not.
local function steps()
	local function G(t, f) f.t = t; return f end
	local s = uistub.guides[uistub.elwynn].steps
	s[#s + 1] = { title = "Go to Frostmane Hold", goals = {
		G("goto", { verb = "Go to", subject = "Frostmane Hold", subjectKind = "place", map = 1429, x = 25.1, y = 50.9, status = "active", tickable = true }),
		G("kill", { verb = "Kill", subject = "Frostmane Troll", subjectKind = "npc", npc = 1, progress = { cur = 1, max = 5 }, status = "active" }),
	} }
	s[#s + 1] = { title = "The troll camp", goals = {
		G("goto", { verb = "Go to", subject = "Frostmane Hold", subjectKind = "place", map = 1429, x = 25.1, y = 50.9, status = "active", tickable = true }),
		G("kill", { verb = "Kill", subject = "Frostmane Troll", subjectKind = "npc", npc = 1, progress = { cur = 1, max = 5 }, status = "active" }),
	} }
	return #s - 1, #s
end
"#;

fn run_in(skin: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!(
			"uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\nlocal SL = GF.stepList\nlocal F = PolestarGuideFrame\n{HELPERS}\nPolestar.Set(\"ui.skin\", \"{skin}\")\n{script}"
		),
		..Default::default()
	})
}

const SKINS: [&str; 3] = ["polestar", "halo", "hearth"];

/// One tab has no × (middle-click and its menu still close it); two tabs each have one.
#[test]
fn a_lone_tab_has_no_close_button_and_two_tabs_each_have_one() {
	for skin in SKINS {
		let out = run_in(
			skin,
			r#"
			uistub.openTabs({ { uistub.elwynn, 2 } }, 1)
			local one = GF.tabs[1].Close:IsShown()
			uistub.openTabs({ { uistub.elwynn, 2 }, { "forever/alliance/02-westfall", 1 } }, 1)
			emit({ one = one, two = { GF.tabs[1].Close:IsShown(), GF.tabs[2].Close:IsShown() } })"#,
		)
		.remove(0);
		assert_eq!(out, json!({ "one": false, "two": [true, true] }), "{skin}");
	}
}

/// The bug report is a row of the ⋯ menu, not a navigator button; Nearby services carries its word when the
/// navigator has the room and is the glyph alone (its tooltip names it) when it has not.
#[test]
fn the_bug_report_is_in_the_menu_and_nearby_services_carries_its_word_when_there_is_room() {
	for skin in SKINS {
		let out = run_in(
			skin,
			r#"
			local nav = GF.parts.nav
			uistub.setGuide(uistub.elwynn, 3)
			local report = nav.Report:IsShown()
			nav.Menu:Click()
			local inMenu = false
			for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Report a problem" then inMenu = true end end
			PolestarMenu:Hide()
			Polestar.Set("ui.width", 480)
			stub.advance(0.1)
			local wide = { label = nav.Nearby.Label:IsShown(), text = nav.Nearby.Label:GetText(), w = nav.Nearby:GetWidth() }
			GF.LabelNearby(10)
			local narrow = { label = nav.Nearby.Label:IsShown(), w = nav.Nearby:GetWidth() }
			emit({ report = report, inMenu = inMenu, wide = wide, narrow = narrow })"#,
		)
		.remove(0);
		assert_eq!(out["report"], false, "{skin}: no bug on the navigator");
		assert_eq!(out["inMenu"], true, "{skin}: the menu reports a problem");
		assert_eq!(out["wide"]["label"], true, "{skin}: {out}");
		assert_eq!(out["wide"]["text"], "Nearby", "{skin}");
		assert!(out["wide"]["w"].as_f64().unwrap() > 24.0, "{skin}: {out}");
		assert_eq!(out["narrow"], json!({ "label": false, "w": 24 }), "{skin}");
	}
}

/// Optional, While you're here, Journey and a class quest's head are quiet small caps: capitals at the cardLabel
/// role's size in the house look, a step under the muted text in every look.
#[test]
fn section_labels_are_quiet_small_caps() {
	let out = run_in(
		"polestar",
		r#"
		uistub.setGuide(uistub.elwynn, 3)
		local o = SL.out
		local JP = Polestar.UI.JourneyPanel
		emit({ opt = o.opt.Label:GetText(), wh = o.wh.Label:GetText(), journey = JP.head.Label:GetText(),
			sizes = { size(o.opt.Label), size(o.wh.Label), size(JP.head.Label) }, ink = GF.LabelInk() })"#,
	)
	.remove(0);
	assert_eq!(out["opt"], "OPTIONAL");
	assert_eq!(out["wh"], "WHILE YOU'RE HERE");
	assert_eq!(out["journey"], "JOURNEY");
	assert_eq!(out["sizes"], json!([9, 9, 9]), "the cardLabel role");
	assert_eq!(out["ink"], "textOff");
}

/// A notice is one strip: the house look's 18px row, the text cut to one line, the action inline by the close.
/// Cut, the text's whole wording is its tooltip; whole, it has none.
#[test]
fn a_notice_is_one_line_with_its_action_inline_and_its_whole_text_in_a_tooltip() {
	for skin in SKINS {
		let out = run_in(
			skin,
			r#"
			local N, B = GF.parts.nav, GF.parts.banner
			uistub.setGuide(uistub.elwynn, 3)
			uistub.live = 4
			uistub.skipped[3] = true
			uistub.setStep(3)
			local skip = { text = B.Text:GetText(), action = B.Jump.Label:GetText(), lines = B.Text:GetMaxLines(), h = B:GetHeight(),
				inline = select(2, B.Jump:GetPoint(1)) == B.Close, tip = B.TextHit.psText or false }
			local long = "Looking ahead at a step whose wording runs on far past the room this narrow strip has for it"
			SL.SlimBanner(240, long, "Back to step 3")
			local cut = { w = B.Text:GetWidth(), full = B.Text:GetUnboundedStringWidth(), tip = B.TextHit.psText, mouse = B.TextHit:IsMouseEnabled() }
			B.TextHit:GetScript("OnEnter")(B.TextHit)
			cut.lines = GameTooltip.lines
			emit({ skip = skip, cut = cut, slim = SL.SLIM_H })"#,
		)
		.remove(0);
		let s = &out["skip"];
		assert_eq!(s["text"], "You skipped this step.", "{skin}");
		assert_eq!(s["action"], "Unskip it", "{skin}");
		assert_eq!(s["lines"], 1, "{skin}");
		assert_eq!(s["h"], out["slim"], "{skin}: the strip's height");
		assert_eq!(s["inline"], true, "{skin}");
		assert_eq!(s["tip"], false, "{skin}: a whole text needs no tooltip");
		let c = &out["cut"];
		assert!(c["w"].as_f64().unwrap() < c["full"].as_f64().unwrap(), "{skin}: cut to the room: {c}");
		assert_eq!(c["mouse"], true, "{skin}");
		assert!(c["lines"].to_string().contains("far past the room"), "{skin}: the whole text in the tooltip: {c}");
	}
	assert_eq!(run_in("polestar", "emit({ h = SL.SLIM_H })").remove(0)["h"], 18, "the house look's strip");
}

/// Compact: the progress is a thin line under the navigator, no footer bar and no percentage. Full keeps the bar and
/// the percentage where the look shows it.
#[test]
fn the_compact_window_s_progress_is_a_thin_line_under_the_navigator() {
	for skin in SKINS {
		let out = run_in(
			skin,
			r#"
			uistub.setGuide(uistub.elwynn, 3)
			local foot, nl = GF.parts.foot, GF.navLine
			local full = { line = nl:IsShown(), foot = foot:IsShown(), pct = foot.Pct:IsShown() == (not Polestar.Theme.GameSkin() and GF.On("progressPct")) }
			Polestar.Set("ui.compact", true)
			stub.advance(0.1)
			local compact = { line = nl:IsShown(), foot = foot:IsShown(), h = nl:GetHeight(), fill = nl.Fill:IsShown(),
				frac = nl.Fill:GetWidth() / PolestarGuideFrame:GetWidth(), below = select(2, nl:GetPoint(1)) == GF.parts.nav }
			emit({ full = full, compact = compact })"#,
		)
		.remove(0);
		assert_eq!(out["full"], json!({ "line": false, "foot": true, "pct": true }), "{skin}");
		let c = &out["compact"];
		assert_eq!(c["line"], true, "{skin}: {c}");
		assert_eq!(c["foot"], false, "{skin}: no footer bar, no percentage");
		assert_eq!(c["h"], 2, "{skin}");
		assert_eq!(c["fill"], true, "{skin}");
		assert_eq!(c["below"], true, "{skin}: under the navigator");
		let frac = c["frac"].as_f64().unwrap();
		assert!(frac > 0.0 && frac < 1.0, "{skin}: the fill follows the guide's progress: {frac}");
	}
}

/// A title that says its first goal takes it over: the goal's row is not drawn, the title row carries its tick box.
/// A title that says something else leaves the goal its row.
#[test]
fn a_title_that_says_its_first_goal_takes_it_over() {
	for skin in SKINS {
		let out = run_in(
			skin,
			r#"
			local same, other = steps()
			local P = GF.parts.person
			uistub.setGuide(uistub.elwynn, same)
			stub.advance(0.1)
			local took = { name = plain(P.Name:GetText()), rows = subjects(), check = P.Check:IsShown(), goal = P.psTakeover and P.psTakeover.subject or false }
			uistub.setStep(other)
			stub.advance(0.1)
			local kept = { name = plain(P.Name:GetText()), rows = subjects(), check = P.Check:IsShown() }
			emit({ took = took, kept = kept })"#,
		)
		.remove(0);
		assert_eq!(out["took"]["name"], "Go to Frostmane Hold", "{skin}");
		assert_eq!(out["took"]["rows"], json!(["Frostmane Troll"]), "{skin}: no duplicate row");
		assert_eq!(out["took"]["check"], true, "{skin}: the title row's tick box");
		assert_eq!(out["took"]["goal"], "Frostmane Hold", "{skin}");
		assert_eq!(out["kept"]["rows"], json!(["Frostmane Hold", "Frostmane Troll"]), "{skin}");
		assert_eq!(out["kept"]["check"], false, "{skin}");
	}
}

/// The step list leaves out a first goal its card's title already says.
#[test]
fn the_step_list_does_not_repeat_a_title_s_first_goal() {
	let out = run_in(
		"polestar",
		r#"
		local same, other = steps()
		uistub.setGuide(uistub.elwynn, same)
		Polestar.Set("ui.stepList", true)
		stub.advance(0.3)
		local cards = {}
		for i = 1, SL.n do
			local r = SL.rows[i]
			if r.psIndex == same or r.psIndex == other then
				local lines = {}
				for j = 1, r.psN do lines[j] = plain(r.G[j].Text:GetText()) end
				cards[#cards + 1] = { title = plain(r.Tab:GetText()), lines = lines }
			end
		end
		emit(cards)"#,
	)
	.remove(0);
	let cards = out.as_array().unwrap();
	assert_eq!(cards.len(), 2, "{out}");
	assert!(!cards[0]["lines"].to_string().contains("Go to Frostmane Hold"), "the title says it: {out}");
	assert!(cards[1]["lines"].to_string().contains("Frostmane Hold"), "a title that does not keeps the line: {out}");
}

// The Journey's route, as tests/addontest/ui-journey.rs sets it: a walk, a lift, a walk.
const ROUTE: &str = r#"
local Nav = Polestar.Nav
Polestar.RegisterDefaults("nav", { distanceUnit = "yards", journeySteps = true, journeyOpen = true })
R = { ci = 1, ps = 670, py = 3000, timed = false, wait = 15, ride = 10, active = true }
R.legs = {
	{ kind = "walk", step = "lift", label = "Walk to The Great Lift, Top", seconds = 670, yards = 3000, to = { name = "The Great Lift, Top" } },
	{ kind = "lift", lift = 7, side = "top", label = "Ride the elevator down", seconds = 25, yards = 60, to = { name = "The Great Lift, Bottom" } },
	{ kind = "walk", label = "Walk to Silithus", seconds = 1513, yards = 4940, to = { name = "Silithus", map = 1451 } },
}
Nav.travel = {
	Active = function() return R.active and R.legs ~= nil and #R.legs > 1 end,
	Progress = function() return R.ps, R.py end,
}
function Nav.GetRoute() return R.legs, R.legs and R.ci end
Polestar.Transit = {
	Now = function() return 1000 + GetTime() end,
	NextDeparture = function() return R.wait, R.ride, R.timed end,
}
uistub.target = { label = "Silithus" }
uistub.setGuide(uistub.elwynn, 3)
Polestar.Fire("ROUTE_CHANGED", R.legs)
JP = Polestar.UI.JourneyPanel
"#;

/// The Journey's "then" line leaves out a step the window already says (the step card's title); left with nothing,
/// it goes. Its time is at the distance's size, not the number role's.
#[test]
fn the_journey_s_then_line_does_not_repeat_the_card_and_its_time_is_at_text_size() {
	let out = run_in(
		"polestar",
		&format!(
			r#"{ROUTE}
		local P = GF.parts.person
		local function more() return JP.more:IsShown() and plain(JP.more:GetText()) or false end
		local before = more()
		R.legs[3].label = plain(P.Name:GetText())
		Polestar.Fire("ROUTE_CHANGED", R.legs)
		local one = more()
		R.legs[2].label = R.legs[3].label
		Polestar.Fire("ROUTE_CHANGED", R.legs)
		local none = more()
		emit({{ before = before, one = one, none = none, time = size(JP.head.Time), dist = size(JP.head.Dist) }})"#
		),
	)
	.remove(0);
	assert_eq!(out["before"], "then Ride the elevator down, Walk to Silithus", "{out}");
	assert_eq!(out["one"], "then Ride the elevator down", "the card's title left out: {out}");
	assert_eq!(out["none"], false, "nothing left to say: {out}");
	assert_eq!(out["time"], out["dist"], "the time at the distance's size");
}
