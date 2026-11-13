//! Another addon keeping the guide window or the arrow out of sight. Some UI addons follow the guide's steps in
//! their own quest tracker and route and, to keep one arrow on screen, turn Polestar's window and arrow down to
//! nothing (alpha 0, a scale far below a pixel) instead of hiding them, laying that again whenever Polestar sets
//! their scale or alpha. Both still read as shown: a player saw only the target button, and /polestar took that
//! too, as it turned the unseen window off. Now the account is told once (a notice and a chat line), and the
//! window's toggle, /polestar show and the arrow's commands keep what is out of sight on and say why it is not
//! seen. Out of sight is told by the scale alone (under 0.2): the player's own fades take the window and the arrow
//! to alpha 0 in a fight. VEIL stands in for such an addon (our own code). The report runs the whole addon with the
//! shipped guides over tests/lua/stub_world.lua, the window the UI over stub_ui.lua, the arrow and the notice the
//! real Nav over stub_nav.lua, unlock mode the whole addon.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const VEIL: &str = r#"-- A stand-in for a UI addon that follows Polestar's guide in its own quest tracker and route (our own code,
-- written from what such an addon does to Polestar's frames): a frame is not hidden but veiled, alpha 0 and a
-- scale far below a pixel, laid again whenever Polestar sets its scale or alpha; unveil gives back what Polestar
-- last asked for. said(n): the chat lines after the first n, without the prefix, one string.
local veiled, laying = {}, false
local function lay(f)
	laying = true
	f:SetAlpha(0)
	f:SetScale(0.001)
	laying = false
end
local function veil(f)
	if veiled[f] == nil then
		hooksecurefunc(f, "SetScale", function(self, s) local v = veiled[self]; if v and not laying then v.scale = s; lay(self) end end)
		hooksecurefunc(f, "SetAlpha", function(self, a) local v = veiled[self]; if v and not laying then v.alpha = a; lay(self) end end)
	end
	veiled[f] = { scale = f:GetScale(), alpha = f:GetAlpha() }
	lay(f)
end
local function unveil(f)
	local v = veiled[f]
	veiled[f] = false
	laying = true
	f:SetScale(v.scale)
	f:SetAlpha(v.alpha)
	laying = false
end
local function said(n)
	local out = {}
	for i = n + 1, #stub.messages do out[#out + 1] = (stub.messages[i]:gsub("^|c%x+Polestar|r: ", "")) end
	return table.concat(out, "\n")
end
local function seen(f) return f:IsShown() and f:GetScale() >= 0.2 and f:GetAlpha() >= 0.05 end
"#;

const BOTH: &str = "Another addon is keeping the guide window and the arrow out of sight. Some UI addons show the guide's steps in their own quest tracker and route instead: turn that off in that addon to get Polestar's back.";
const WINDOW: &str = "Another addon is keeping the guide window out of sight. Some UI addons show the guide's steps in their own quest tracker instead: turn that off in that addon to get it back.";
const ARROW: &str = "Another addon is keeping the arrow out of sight. Some UI addons lead the way with their own arrow or route instead: turn that off in that addon to get it back.";

/// `script` on the guide window (the UI over stub_ui.lua, logged in, `F` the window): its one emitted value.
fn window(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"])],
		script: format!("uistub.install()\nstub.login()\nlocal F = PolestarGuideFrame\n{VEIL}{script}"),
		..Default::default()
	})
	.remove(0)
}

/// `script` on the arrow (the real Nav over stub_nav.lua, logged in): its one emitted value.
fn arrow(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml"])],
		login: true,
		script: format!("{VEIL}{script}"),
		..Default::default()
	})
	.remove(0)
}

// A level-1 Human in Northshire, as the report's player: the shipped Elwynn Forest guide, its first person taken
// (783), the next one's target button on screen with the window and the arrow.
const NORTHSHIRE: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
w.moveTo(1429, 48.5, 42.5)"#;

const REPORT: &str = r#"
stub.login()
stub.advance(0.5)
stub.world.accept(783, {}, "A Threat Within")
stub.advance(0.5)
local function look()
	return { window = PolestarGuideFrame:IsShown(), windowSeen = seen(PolestarGuideFrame), arrowSeen = seen(PolestarNavArrow),
		-- The target button, or beside its list the Polestar mark in its slot.
		targetButton = seen(PolestarTargetButton) or seen(PolestarTargetAnchor), on = Polestar.Get("ui.shown") }
end
local before = look()
for _, f in ipairs({ PolestarGuideFrame, PolestarNavArrow, PolestarQuestItemButton, PolestarHearthButton }) do veil(f) end
Polestar.Set("nav.minimapPins", false)
stub.advance(0.5)
local hidden = look()
local n = #stub.messages
SlashCmdList.POLESTAR("")
stub.advance(0.5)
local after = look()
after.said = said(n)
emit({ before = before, veiled = hidden, after = after })
"#;

#[test]
fn the_report_another_addon_veiling_the_window_and_arrow_leaves_the_target_button_and_polestar_no_longer_turns_the_window_off() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: NORTHSHIRE.into(),
		addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Guides"), Addon::name("Polestar_Guides_Alliance")],
		script: format!("{VEIL}{REPORT}"),
		..Default::default()
	})
	.remove(0);
	let look = |seen: bool| json!({ "window": true, "windowSeen": seen, "arrowSeen": seen, "targetButton": true, "on": true });
	assert_eq!(out["before"], look(true));
	assert_eq!(out["veiled"], look(false), "the window and the arrow out of sight, the target button all that shows");
	let mut after = look(false);
	after["said"] = json!(BOTH);
	assert_eq!(out["after"], after, "/polestar keeps the window on, the target button with it, and says why it is not seen");
}

#[test]
fn a_window_another_addon_keeps_out_of_sight_stays_on_through_polestar_and_polestar_show_which_say_why_and_toggles_as_before_once_seen() {
	let out = window(
		r#"
uistub.setGuide(uistub.elwynn, 3)
stub.advance(1)
local n = #stub.messages
veil(F)
stub.advance(0.1)
local told = said(n)
n = #stub.messages
SlashCmdList.POLESTAR("")
local toggled = { on = Polestar.Get("ui.shown"), window = F:IsShown(), said = said(n) }
n = #stub.messages
SlashCmdList.POLESTAR("show")
local shown = said(n)
unveil(F)
n = #stub.messages
SlashCmdList.POLESTAR("")
local off = { on = Polestar.Get("ui.shown"), window = F:IsShown(), said = said(n) }
SlashCmdList.POLESTAR("")
emit({ told = told, toggled = toggled, shown = shown, off = off, back = { on = Polestar.Get("ui.shown"), seen = seen(F) } })
"#,
	);
	assert_eq!(out["told"], WINDOW, "the account is told the moment the window goes out of sight");
	assert_eq!(out["toggled"], json!({ "on": true, "window": true, "said": WINDOW }));
	assert_eq!(out["shown"], WINDOW);
	assert_eq!(out["off"], json!({ "on": false, "window": false, "said": "" }), "seen again: the toggle turns it off as before");
	assert_eq!(out["back"], json!({ "on": true, "seen": true }));
}

// The window scale changed while the window is out of sight (a player who cannot see it may well try): it scales
// about its pinned corner from the scale Polestar set, as it always does, not from the other addon's, which put
// it in the corner of the screen once it was seen again. The place is kept exact, not rounded to a whole unit
// (#1785: a rounded re-pin moved the window by part of a pixel and its text shifted on the grid).
#[test]
fn a_window_scale_changed_while_another_addon_keeps_the_window_out_of_sight_keeps_its_place() {
	let out = window(
		r#"
local GF = Polestar.UI.GuideFrame
uistub.setGuide(uistub.elwynn, 3)
F.x, F.y = 1500, 300
stub.RunScript(GF.parts.nav, "OnDragStart")
stub.RunScript(GF.parts.nav, "OnDragStop")
local top = F:GetTop()
veil(F)
Polestar.Set("ui.scale", 1.2)
unveil(F)
local pos = Polestar.Get("ui.pos")
emit({ pos = { pos[1], pos[2] }, top = top, scale = F:GetScale() })
"#,
	);
	let (x, y) = (out["pos"][0].as_f64().unwrap(), out["pos"][1].as_f64().unwrap());
	let top = out["top"].as_f64().unwrap() / 1.2;
	assert!((x - 1250.0).abs() < 1e-6 && (y - top).abs() < 1e-6, "the place scaled from 1 to 1.2 about the top-left corner: {} for [1250, {top}]", out["pos"]);
	assert_eq!(out["scale"], 1.2);
}

#[test]
fn an_arrow_another_addon_keeps_out_of_sight_stays_on_through_polestar_arrow_arrow_show_says_why_arrow_hide_hides_and_the_account_is_told_once() {
	let out = arrow(
		r#"
local Nav = Polestar.Nav
local A = Nav.arrow.frame
stub.nav.setWaypoint({ map = 9000, x = 50, y = 20, label = "Somewhere", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 })
Nav.Refresh()
stub.runTimers()
local function notice()
	local B = Nav.alerts.banner
	return B ~= nil and B:IsShown() and B.Title:GetText() or false
end
local n = #stub.messages
veil(A)
stub.advance(0.1)
local told = { said = said(n), notice = notice() }
n = #stub.messages
SlashCmdList.POLESTAR("arrow")
local toggled = { on = Polestar.Get("nav.arrow"), arrow = A:IsShown(), said = said(n) }
n = #stub.messages
SlashCmdList.POLESTAR("arrow show")
local shown = said(n)
SlashCmdList.POLESTAR("arrow hide")
local hidden = { on = Polestar.Get("nav.arrow"), arrow = A:IsShown() }
SlashCmdList.POLESTAR("arrow show")
unveil(A)
stub.advance(13)
n = #stub.messages
veil(A)
stub.advance(0.1)
emit({ told = told, toggled = toggled, shown = shown, hidden = hidden, again = { said = said(n), notice = notice() } })
"#,
	);
	assert_eq!(out["told"], json!({ "said": ARROW, "notice": "Polestar is out of sight" }));
	assert_eq!(out["toggled"], json!({ "on": true, "arrow": true, "said": ARROW }));
	assert_eq!(out["shown"], ARROW);
	assert_eq!(out["hidden"], json!({ "on": false, "arrow": false }), "arrow hide still hides it");
	assert_eq!(out["again"], json!({ "said": "", "notice": false }), "told once on the account");
}

// Polestar's own lowest settings: the window at scale 0.6, opacity 0.3, faded in a fight to nothing
// (guideWindow.combatAlpha 0) and at rest to 0.03 (idleAlpha 0.1 x opacity 0.3); the arrow at scale 0.5 and
// opacity 0.1, nothing in a fight (nav.arrowCombatAlpha 0). None of it reads as out of sight: the toggles turn
// them off as always and nothing is said.
#[test]
fn polestar_s_own_lowest_scale_and_opacity_never_read_as_out_of_sight() {
	let out = window(
		r#"
uistub.setGuide(uistub.elwynn, 3)
Polestar.Set("ui.scale", 0.6)
Polestar.Set("ui.opacity", 0.3)
Polestar.Set("ui.combat", "fade")
Polestar.Set("guideWindow.combatAlpha", 0)
Polestar.Set("guideWindow.idleAlpha", 0.1)
stub.fire("PLAYER_REGEN_DISABLED")
stub.advance(2)
local n = #stub.messages
local fight = { shown = F:IsShown(), alpha = F:GetAlpha(), out = Polestar.OutOfSight(F) }
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(2)
local rest = { alpha = math.floor(F:GetAlpha() * 100 + 0.5) / 100, out = Polestar.OutOfSight(F) }
SlashCmdList.POLESTAR("")
emit({ fight = fight, rest = rest, on = Polestar.Get("ui.shown"), said = said(n) })
"#,
	);
	assert_eq!(out, json!({ "fight": { "shown": true, "alpha": 0, "out": false }, "rest": { "alpha": 0.03, "out": false }, "on": false, "said": "" }));
	let out = arrow(
		r#"
local Nav = Polestar.Nav
local A = Nav.arrow.frame
Polestar.Set("nav.arrowScale", 0.5)
Polestar.Set("nav.arrowAlpha", 0.1)
Polestar.Set("nav.arrowCombatAlpha", 0)
stub.nav.setWaypoint({ map = 9000, x = 50, y = 20, label = "Somewhere", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 })
Nav.Refresh()
stub.runTimers()
stub.fire("PLAYER_REGEN_DISABLED")
stub.advance(0.1)
local n = #stub.messages
local B = Nav.alerts.banner
local low = { shown = A:IsShown(), alpha = A:GetAlpha(), out = Polestar.OutOfSight(A), notice = B ~= nil and B:IsShown() }
SlashCmdList.POLESTAR("arrow")
emit({ low = low, on = Polestar.Get("nav.arrow"), said = said(n) })
"#,
	);
	assert_eq!(out, json!({ "low": { "shown": true, "alpha": 0, "out": false, "notice": false }, "on": false, "said": "" }));
}

// Unlock mode over a window another addon keeps out of sight: the window's box stands where the window would at
// the scale Polestar set, not shrunk to a speck in the corner, and a drag saves a place on the screen (one worked
// out at the other addon's scale lands thousands of times too far away).
#[test]
fn unlock_mode_over_a_window_another_addon_keeps_out_of_sight_boxes_and_drags_it_at_polestar_s_scale() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		script: format!(
			"{VEIL}{}",
			r#"
stub.login()
local M = Polestar.Movers
local function r(v) return math.floor(v + 0.5) end
local function rect() local l, b, w, h = M.Rect("guide"); return { r(l), r(b), r(w), r(h) } end
Polestar.Set("movers.grid", false)
Polestar.Set("movers.snap", false)
local F = PolestarGuideFrame
M.Unlock()
local seen = rect()
M.Lock()
veil(F)
M.Unlock()
local veiled = rect()
local b = M.Box("guide")
local l, bt, w, h = M.Rect("guide")
stub.cursor = { l + w / 2, bt + h / 2 }
stub.RunScript(b, "OnMouseDown", "LeftButton")
stub.cursor = { l + w / 2 - 100, bt + h / 2 - 50 }
PolestarMovers:GetScript("OnUpdate")(PolestarMovers, 0.02)
stub.RunScript(b, "OnMouseUp", "LeftButton")
M.Lock()
unveil(F)
M.Unlock()
emit({ out = Polestar.OutOfSight(F), seen = seen, veiled = veiled, moved = rect() })
"#
		),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["out"], false);
	assert_eq!(out["veiled"], out["seen"], "the box where the window stands at its own scale: {out}");
	let (seen, moved) = (out["seen"].as_array().unwrap(), out["moved"].as_array().unwrap());
	let at = |v: &Vec<Value>, i: usize| v[i].as_i64().unwrap();
	assert_eq!([at(moved, 0), at(moved, 1), at(moved, 2), at(moved, 3)], [at(seen, 0) - 100, at(seen, 1) - 50, at(seen, 2), at(seen, 3)], "the drag moved the window 100 left and 50 down: {out}");
}
