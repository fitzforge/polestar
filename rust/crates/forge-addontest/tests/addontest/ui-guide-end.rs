//! The end of a leveling guide (addon/Polestar/UI/GuideEnd.lua, and the guide window's banners in
//! UI/GuideFrame.lua) against the real Core + Theme + UI manifests and the fake Engine of tests/lua/stub_ui.lua,
//! given GUIDE_END's info.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const HELPERS: &str = r#"
local E = Polestar.Engine
GE, GF = Polestar.UI.GuideEnd, Polestar.UI.GuideFrame
ENDED, NEXT, CHOICE = {}, "forever/alliance/02-westfall", false
E.GuideEnded = function(id) return ENDED[id] == true end
E.NextGuide = function() return NEXT end
E.StartNext = function(id) uistub.calls[#uistub.calls + 1] = { "StartNext", id }; return true end
E.GetRouteChoice = function(id)
	if not CHOICE then return nil end
	return { from = id, fromTitle = "Elwynn Forest", recommended = "a", options = {
		{ id = "a", title = "Westfall", zoneName = "Westfall", minLevel = 12, maxLevel = 17, recommended = true },
		{ id = "b", title = "Darkshore", zoneName = "Darkshore", minLevel = 12, maxLevel = 17 },
	} }
end
function lastCall(name)
	for i = #uistub.calls, 1, -1 do if uistub.calls[i][1] == name then return uistub.calls[i] end end
	return false
end
function info(t) t.guideId = uistub.elwynn; return t end
function view()
	local F = PolestarGuideEnd
	stub.advance(1)
	local point, rel, relPoint = F:GetPoint(1)
	return {
		shown = F:IsShown(), title = F.Title:GetText(), undone = F.Undone:IsShown() and F.Undone:GetText() or false,
		next = F.Art:IsShown() and F.Next:GetText() or false, text = F.Text:IsShown() and F.Text:GetText() or false,
		go = rawget(F, "Go") ~= nil, later = F.Later.Label:GetText(),
		strata = F:GetFrameStrata(), point = point, alpha = F:GetAlpha(),
	}
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &FILES)], script: ["uistub.install()", "stub.login()", HELPERS, script].join("\n"), ..Default::default() })
		.remove(0)
}

/// Text with the colour escapes taken out.
fn plain(v: &Value) -> String {
	let s = v.as_str().unwrap_or("");
	let mut out = String::new();
	let mut rest = s;
	while let Some(i) = rest.find('|') {
		out.push_str(&rest[..i]);
		let tail = &rest[i..];
		if tail.starts_with("|c") && tail.len() >= 10 {
			rest = &tail[10..];
		} else if let Some(after) = tail.strip_prefix("|r") {
			rest = after;
		} else {
			out.push('|');
			rest = &tail[1..];
		}
	}
	out.push_str(rest);
	out
}

#[test]
fn the_end_with_steps_left_open_names_the_guide_the_steps_and_the_next_guide_back_returns_to_the_live_step() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 5)
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 3, live = 3, next = NEXT }))
		local r = view()
		r.esc = false
		for _, n in ipairs(UISpecialFrames or {}) do if n == "PolestarGuideEnd" then r.esc = true end end
		PolestarGuideEnd.Later:Click()
		r.goto, r.after = lastCall("Goto"), PolestarGuideEnd:IsShown()
		emit(r)"#);
	// Too long for one line: the break goes before the guide, never inside its name.
	assert_eq!(plain(&out["title"]), "You've reached the end of\nElwynn Forest (1–13)");
	assert!(out["title"].as_str().unwrap().contains("|c"), "the guide's name in the accent");
	assert_eq!(out["undone"], "3 steps were left undone.");
	assert_eq!(out["next"], "Next: Westfall (12–17)");
	assert_eq!(out["go"], false, "no Start button: the guide window owns the next guide's button");
	assert_eq!(out["later"], "Back to step 3");
	assert_eq!(out["strata"], "DIALOG");
	assert_eq!(out["point"], "CENTER");
	assert_eq!(out["alpha"], 1.0, "faded in");
	assert_eq!(out["esc"], true);
	assert_eq!(out["goto"], json!(["Goto", 3]));
	assert_eq!(out["after"], false);
}

// The last step done before the rest (GUIDE_STEPS_LEFT, #3517) is no end yet: the window says how many steps are
// left and that the next guide follows, with one button, back to the live step; no next guide offered. The end
// itself comes later as usual.
#[test]
fn the_last_step_done_early_says_how_many_steps_are_left_with_back_to_the_live_step_as_its_one_button() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 5); uistub.live = 3
		Polestar.Fire("GUIDE_STEPS_LEFT", uistub.elwynn, info({ left = 2, live = 3, next = NEXT }))
		local r = view()
		PolestarGuideEnd.Later:Click()
		r.goto, r.after, r.start = lastCall("Goto"), PolestarGuideEnd:IsShown(), lastCall("StartNext")
		-- The live step moved on while a fight held the window back: its count is stale, nothing shows.
		uistub.live = 4
		stub.inCombat = true
		Polestar.Fire("GUIDE_STEPS_LEFT", uistub.elwynn, info({ left = 2, live = 3 }))
		stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(1)
		r.staleAfterFight = PolestarGuideEnd:IsShown()
		Polestar.Fire("GUIDE_STEPS_LEFT", uistub.elwynn, info({ left = 1, live = 4 }))
		r.one = view()
		-- A route choice after the guide.
		CHOICE = true
		Polestar.Fire("GUIDE_STEPS_LEFT", uistub.elwynn, info({ left = 1, live = 4, choose = true }))
		r.choice = view()
		CHOICE = false
		-- A translation that numbers its arguments.
		Polestar.L["%d steps left in %s"] = "%2$s: noch %1$d Schritte"
		Polestar.Fire("GUIDE_STEPS_LEFT", uistub.elwynn, info({ left = 3, live = 4 }))
		r.numbered = view()
		-- Its tab closed meanwhile: nothing to say.
		Polestar.UI.GuideEnd.Hide()
		local tabs = E.GetTabs
		E.GetTabs = function() return {} end
		r.closed = Polestar.UI.GuideEnd.Show(info({ left = 2, live = 4 }))
		E.GetTabs = tabs
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, next = NEXT }))
		r.theEnd = view()
		emit(r)"#);
	assert_eq!(plain(&out["title"]), "2 steps left in\nElwynn Forest (1–13)");
	assert_eq!(out["undone"], false);
	assert_eq!(out["next"], false, "no next guide yet");
	assert_eq!(out["text"], "Do or skip what's left, and the next guide follows.");
	assert_eq!(out["later"], "Back to step 3");
	assert_eq!(out["go"], false, "its one button");
	assert_eq!(out["goto"], json!(["Goto", 3]));
	assert_eq!(out["after"], false);
	assert_eq!(out["start"], false, "no guide started");
	assert_eq!(plain(&out["one"]["title"]), "1 step left in\nElwynn Forest (1–13)");
	assert_eq!(out["one"]["text"], "Do or skip what's left, and the guide ends.", "no next guide");
	assert_eq!(out["choice"]["text"], "Do or skip what's left, and you choose where to go next.");
	assert_eq!(out["staleAfterFight"], false);
	assert_eq!(out["one"]["later"], "Back to step 4");
	assert_eq!(plain(&out["numbered"]["title"]), "Elwynn Forest (1–13): noch 3 Schritte");
	assert_eq!(out["closed"], false);
	assert_eq!(plain(&out["theEnd"]["title"]), "You've completed\nElwynn Forest (1–13)");
	assert_eq!(out["theEnd"]["later"], "Close", "the end itself, as usual");
}

#[test]
fn a_guide_done_whole_says_completed_and_its_one_button_closes_it_without_starting_the_next_guide() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 1); uistub.complete()
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, next = NEXT }))
		local r = view()
		PolestarGuideEnd.Later:Click()
		r.start, r.after = lastCall("StartNext"), PolestarGuideEnd:IsShown()
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, next = NEXT }))
		PolestarGuideEnd.Later:Click()
		r.again = { shown = PolestarGuideEnd:IsShown(), goto = lastCall("Goto") }
		emit(r)"#);
	assert_eq!(plain(&out["title"]), "You've completed\nElwynn Forest (1–13)");
	assert_eq!(out["undone"], false);
	assert_eq!(out["later"], "Close");
	assert_eq!(out["start"], false, "the button closes, the guide window offers the next guide");
	assert_eq!(out["after"], false);
	assert_eq!(out["again"], json!({ "shown": false, "goto": false }));
}

#[test]
fn a_route_choice_or_no_next_guide_says_so_in_the_text_and_closes_with_its_one_button() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 1); uistub.complete()
		CHOICE = true
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, choose = true }))
		local r = { choice = view() }
		PolestarGuideEnd.Later:Click()
		r.routeChoice = PolestarRouteChoice and PolestarRouteChoice:IsShown() or false
		CHOICE = false
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0 }))
		r.none = view()
		emit(r)"#);
	assert_eq!(out["choice"]["go"], false);
	assert_eq!(out["choice"]["later"], "Close");
	assert_eq!(out["choice"]["text"], "Pick where you want to level next.");
	assert_eq!(out["choice"]["next"], false);
	assert_eq!(out["routeChoice"], false, "the guide window offers the choice, not this window");
	assert_eq!(out["none"]["go"], false);
	assert_eq!(out["none"]["later"], "Close");
	assert_eq!(out["none"]["text"], "Nice work. Pick your next guide to keep going.");
}

#[test]
fn back_on_the_guide_its_banner_offers_the_next_guide_until_dismissed_and_continue_automatically_says_it_moved_on() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local B = GF.parts.banner
		local r = { before = B:IsShown() }
		ENDED[uistub.elwynn] = true
		GF.Layout()
		r.ended = { shown = B:IsShown(), text = B.Text:GetText(), link = B.Jump.Label:GetText() }
		B.Jump:Click()
		r.start = lastCall("StartNext")
		B.Close:Click()
		r.dismissed = B:IsShown()
		uistub.setGuide("forever/alliance/02-westfall", 1)
		Polestar.Fire("GUIDE_CONTINUED", uistub.elwynn, "forever/alliance/02-westfall")
		r.continued = B:IsShown() and B.Text:GetText() or false
		stub.advance(21)
		r.gone = B:IsShown()
		emit(r)"#);
	assert_eq!(out["before"], false);
	assert_eq!(out["ended"], json!({ "shown": true, "text": "You've reached the end of this guide.", "link": "Start Westfall (12–17)" }));
	assert_eq!(out["start"], json!(["StartNext", "forever/alliance/human/01-elwynn-forest"]));
	assert_eq!(out["dismissed"], false);
	assert_eq!(out["continued"], "Elwynn Forest complete — continuing with Westfall");
	assert_eq!(out["gone"], false);
}

// The quests still in the log that a later guide hands in (Engine.CarriedQuests): listed under "Carried to later
// guides" with the guide that hands each in and its levels, six at most and "+N more"; none, and the list is gone.
#[test]
fn the_end_lists_the_quests_a_later_guide_hands_in_with_that_guide() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 1); uistub.complete()
		local list = { { quest = 1, title = "Sceptre of Light", guideId = NEXT }, { quest = 2, title = "Lost Letter", guideId = "gone/guide" } }
		for i = 3, 8 do list[i] = { quest = i, title = "Quest " .. i, guideId = NEXT } end
		E.CarriedQuests = function(id) return id == uistub.elwynn and list or {} end
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, next = NEXT }))
		stub.advance(1)
		local F = PolestarGuideEnd
		local r = { head = F.CarriedHead:IsShown() and F.CarriedHead:GetText() or false, list = F.Carried:IsShown() and F.Carried:GetText() or false, tall = F:GetHeight() }
		Polestar.UI.GuideEnd.Hide()
		list = {}
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, next = NEXT }))
		stub.advance(1)
		r.none = { head = F.CarriedHead:IsShown(), list = F.Carried:IsShown(), tall = F:GetHeight() }
		emit(r)"#);
	assert_eq!(out["head"], "Carried to later guides");
	assert_eq!(
		out["list"],
		"Sceptre of Light · Westfall (12–17)\nLost Letter\nQuest 3 · Westfall (12–17)\nQuest 4 · Westfall (12–17)\nQuest 5 · Westfall (12–17)\nQuest 6 · Westfall (12–17)\n+2 more"
	);
	assert_eq!(out["none"]["head"], false);
	assert_eq!(out["none"]["list"], false);
	assert!(out["tall"].as_f64().unwrap() > out["none"]["tall"].as_f64().unwrap(), "the list makes the window taller");
}

// Held back by a fight, a steps-left window whose tab is closed meanwhile is dropped, not kept for the next fight;
// an end that follows an open steps-left window plays its chime.
#[test]
fn a_steps_left_window_held_back_by_a_fight_is_dropped_with_its_tab_and_the_end_after_one_chimes() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 5); uistub.live = 3
		stub.inCombat = true
		Polestar.Fire("GUIDE_STEPS_LEFT", uistub.elwynn, info({ left = 2, live = 3 }))
		local tabs = E.GetTabs
		E.GetTabs = function() return {} end
		stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(1)
		local r = { afterFight = PolestarGuideEnd and PolestarGuideEnd:IsShown() or false }
		E.GetTabs = tabs
		stub.inCombat = true; stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(1)
		r.nextFight = PolestarGuideEnd and PolestarGuideEnd:IsShown() or false
		local played = 0
		Polestar.UI.ClassCard.GameSoundOn = function() return true end
		local play = Polestar.PlaySound
		Polestar.PlaySound = function(...) played = played + 1 end
		Polestar.Fire("GUIDE_STEPS_LEFT", uistub.elwynn, info({ left = 1, live = 3 }))
		r.leftChimes = played
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, next = NEXT }))
		r.endChimes = played
		Polestar.PlaySound = play
		emit(r)"#);
	assert_eq!(out["afterFight"], false);
	assert_eq!(out["nextFight"], false, "not kept for the next fight");
	assert_eq!(out["leftChimes"], 0);
	assert_eq!(out["endChimes"], 1);
}

// The steps-left window closes once the live step moves on (one of them done or skipped): its count is stale.
// Looking at another step leaves it up.
#[test]
fn the_steps_left_window_closes_once_the_live_step_moves_on() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3); uistub.live = 3
		Polestar.Fire("GUIDE_STEPS_LEFT", uistub.elwynn, info({ left = 2, live = 3, next = NEXT }))
		stub.advance(1)
		Polestar.Fire("STEP_CHANGED", 5)
		local r = { browsing = PolestarGuideEnd:IsShown() }
		uistub.live = 4
		Polestar.Fire("STEP_UPDATED", 4)
		r.moved = PolestarGuideEnd:IsShown()
		emit(r)"#);
	assert_eq!(out, json!({ "browsing": true, "moved": false }));
}
