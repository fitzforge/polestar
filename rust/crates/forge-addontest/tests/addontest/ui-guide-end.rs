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
		go = F.Go.Label:GetText(), later = F.Later.Label:GetText(), primary = F.Go.psPrimary == true,
		strata = F:GetFrameStrata(), point = point, alpha = F:GetAlpha(),
	}
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: ["uistub.install()", "stub.login()", HELPERS, script].join("\n"),
		..Default::default()
	})
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
		} else if tail.starts_with("|r") {
			rest = &tail[2..];
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
	assert_eq!(plain(&out["title"]), "You've reached the end of Elwynn Forest (1–13)");
	assert!(out["title"].as_str().unwrap().contains("|c"), "the guide's name in the accent");
	assert_eq!(out["undone"], "3 steps were left undone.");
	assert_eq!(out["next"], "Next: Westfall (12–17)");
	assert_eq!(out["go"], "Start Westfall");
	assert_eq!(out["primary"], true);
	assert_eq!(out["later"], "Back to step 3");
	assert_eq!(out["strata"], "DIALOG");
	assert_eq!(out["point"], "CENTER");
	assert_eq!(out["alpha"], 1.0, "faded in");
	assert_eq!(out["esc"], true);
	assert_eq!(out["goto"], json!(["Goto", 3]));
	assert_eq!(out["after"], false);
}

#[test]
fn a_guide_done_whole_says_completed_start_loads_the_next_guide_not_now_only_closes() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 1); uistub.complete()
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, next = NEXT }))
		local r = view()
		PolestarGuideEnd.Go:Click()
		r.start, r.after = lastCall("StartNext"), PolestarGuideEnd:IsShown()
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, next = NEXT }))
		PolestarGuideEnd.Later:Click()
		r.again = { shown = PolestarGuideEnd:IsShown(), goto = lastCall("Goto") }
		emit(r)"#);
	assert_eq!(plain(&out["title"]), "You've completed Elwynn Forest (1–13)");
	assert_eq!(out["undone"], false);
	assert_eq!(out["later"], "Not now");
	assert_eq!(out["start"], json!(["StartNext", "forever/alliance/human/01-elwynn-forest"]));
	assert_eq!(out["after"], false);
	assert_eq!(out["again"], json!({ "shown": false, "goto": false }));
}

#[test]
fn a_route_choice_opens_the_route_choice_window_and_no_next_guide_offers_the_guide_menu() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 1); uistub.complete()
		CHOICE = true
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0, choose = true }))
		local r = { choice = view() }
		PolestarGuideEnd.Go:Click()
		r.routeChoice = PolestarRouteChoice and PolestarRouteChoice:IsShown() or false
		Polestar.UI.RouteChoice.Hide()
		CHOICE = false
		local picked = false
		Polestar.UI.ShowPicker = function() picked = true end
		Polestar.Fire("GUIDE_END", uistub.elwynn, info({ undone = 0 }))
		r.none = view()
		PolestarGuideEnd.Go:Click()
		r.picked = picked
		emit(r)"#);
	assert_eq!(out["choice"]["go"], "Choose where to go next");
	assert_eq!(out["choice"]["text"], "Pick where you want to level next.");
	assert_eq!(out["choice"]["next"], false);
	assert_eq!(out["routeChoice"], true);
	assert_eq!(out["none"]["go"], "Pick a guide");
	assert_eq!(out["none"]["later"], "Close");
	assert_eq!(out["none"]["text"], "Nice work. Pick your next guide to keep going.");
	assert_eq!(out["picked"], true);
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
