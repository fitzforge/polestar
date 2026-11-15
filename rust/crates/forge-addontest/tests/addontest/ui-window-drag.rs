//! Dragging Polestar's windows and the HUD's frames (ns.DragWindow, Core/Init.lua): Install, the guide window,
//! the route choice, the guide end, the hub shell (the settings window's shell), the flight timer, the instance
//! tracker, the arrow and the floating button follow the pointer from the first pixel it travels, by exactly its
//! travel at UI scales 0.64, 1.0 and 1.5 (and a window scaled down to fit), stay where they are dropped, and a
//! press that does not move never moves the window or rewrites its anchor.
//!
//! The stub lays nothing out, so each window's left and top are read from its one anchor to UIParent here, as
//! the client resolves them: UIParent 1920 x 1080 physical pixels at the UI scale, the offsets in the window's
//! own (scaled) units.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const ENGINE: &str = r#"
local E = Polestar.Engine
E.GuideEnded = function() return true end
E.NextGuide = function() return "forever/alliance/02-westfall" end
E.GetRouteChoice = function(id)
	return { from = id, fromTitle = "Elwynn Forest", recommended = "a", options = {
		{ id = "a", title = "Westfall", zoneName = "Westfall", minLevel = 12, maxLevel = 17, recommended = true },
		{ id = "b", title = "Darkshore", zoneName = "Darkshore", minLevel = 12, maxLevel = 17 },
	} }
end
"#;

// The geometry and the drag, for any window (the windows themselves are the UI suite's: windows()).
const HELPERS: &str = r#"
-- A frame's left and top from its one anchor to UIParent, in its own units.
local function resolve(self)
	local p = self.points[1]
	if not p then return 0, 0 end
	local s, us = self:GetEffectiveScale(), UIParent:GetEffectiveScale()
	local uw, uh = UIParent:GetWidth() * us / s, UIParent:GetHeight() * us / s
	local w, h = self:GetWidth(), self:GetHeight()
	local function ax(pt, size) if pt:find("LEFT") then return 0 elseif pt:find("RIGHT") then return size end return size / 2 end
	local function ay(pt, size) if pt:find("BOTTOM") then return 0 elseif pt:find("TOP") then return size end return size / 2 end
	local rp = p.relPoint or p.point
	local left = ax(rp, uw) + p.x - ax(p.point, w)
	local bottom = ay(rp, uh) + p.y - ay(p.point, h)
	return left, bottom + h
end
local function laidOut(f)
	f.GetLeft = function(self) return (resolve(self)) end
	f.GetTop = function(self) return select(2, resolve(self)) end
	f.GetBottom = function(self) return select(2, resolve(self)) - self:GetHeight() end
	f.GetRight = function(self) return resolve(self) + self:GetWidth() end
	f.GetCenter = function(self)
		local l, t = resolve(self)
		return l + self:GetWidth() / 2, t - self:GetHeight() / 2
	end
end

function atScale(s)
	UIParent:SetScale(s)
	UIParent.GetWidth = function() return 1920 / s end
	UIParent.GetHeight = function() return 1080 / s end
end

local function anchor(f)
	local a = { f:GetPoint(1) }
	a[2] = a[2] and (a[2] == UIParent and "UIParent" or tostring(a[2])) or false
	return table.concat({ tostring(a[1]), tostring(a[2]), tostring(a[3]), string.format("%.4f", a[4] or 0), string.format("%.4f", a[5] or 0) }, " ")
end

local function near(a, b) return math.abs(a - b) < 1e-6 end

-- Press, one pixel, a long pull, release; then a plain click. -> what moved, in physical pixels.
function drag(win, handle)
	laidOut(win)
	local e = win:GetEffectiveScale()
	stub.cursor = { 900, 500 }
	local a0, l0, t0 = anchor(win), win:GetLeft(), win:GetTop()
	stub.RunScript(handle, "OnMouseDown", "LeftButton")
	local pressed = anchor(win) == a0
	-- The move runs on W.DragWindow's own driver frame: one frame of the client.
	local function tick() stub.advance(0.016) end
	stub.cursor = { 901, 500 }
	tick()
	local first = { (win:GetLeft() - l0) * e, (win:GetTop() - t0) * e }
	stub.cursor = { 901 + 40, 500 - 30 }
	tick()
	local pulled = { (win:GetLeft() - l0) * e, (win:GetTop() - t0) * e }
	stub.RunScript(handle, "OnMouseUp", "LeftButton")
	-- Where the drop leaves it once its spot is saved (and the window put there again).
	local dropped = { (win:GetLeft() - l0) * e, (win:GetTop() - t0) * e }
	local a1 = anchor(win)
	stub.RunScript(handle, "OnMouseDown", "LeftButton")
	tick()
	stub.RunScript(handle, "OnMouseUp", "LeftButton")
	return {
		pressStill = pressed,
		firstPixel = near(first[1], 1) and near(first[2], 0),
		follows = near(pulled[1], 41) and near(pulled[2], -30),
		dropStays = math.abs(dropped[1] - 41) <= e and math.abs(dropped[2] + 30) <= e,
		clickStill = anchor(win) == a1,
	}
end

-- The first descendant of f that drags it: an OnMouseDown and no click of its own.
function handleOf(f)
	local function walk(x)
		for _, c in ipairs({ x:GetChildren() }) do
			if c:GetScript("OnMouseDown") and not c:GetScript("OnClick") then return c end
			local h = walk(c)
			if h then return h end
		end
	end
	return walk(f)
end

function windows()
	Polestar.UI.Welcome.Show("route")
	Polestar.Fire("ROUTE_CHOICE", "elwynn")
	Polestar.Fire("GUIDE_END", uistub.elwynn, { guideId = uistub.elwynn, undone = 0, next = "forever/alliance/02-westfall" })
	Polestar.UI.ShowPicker()
	stub.advance(1)
	return {
		install = { PolestarWelcome, PolestarWelcome },
		guide = { PolestarGuideFrame, handleOf(PolestarGuideFrame) },
		routeChoice = { PolestarRouteChoice, PolestarRouteChoice.Header },
		guideEnd = { PolestarGuideEnd, PolestarGuideEnd.Header },
		hub = { PolestarPicker, PolestarPicker.Header },
	}
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: ["uistub.install()", "stub.login()", ENGINE, HELPERS, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn every_window_follows_the_pointer_from_the_first_pixel_by_its_exact_travel_and_a_plain_click_never_moves_it() {
	let out = run(r#"
		local out = {}
		for _, s in ipairs({ 0.64, 1.0, 1.5 }) do
			atScale(s)
			for name, w in pairs(windows()) do
				out[name .. "@" .. s] = w[1] and w[2] and drag(w[1], w[2]) or "missing"
			end
		end
		emit(out)"#);
	let ok = json!({ "pressStill": true, "firstPixel": true, "follows": true, "dropStays": true, "clickStill": true });
	let obj = out.as_object().expect("an object");
	assert_eq!(obj.len(), 15, "five windows at three scales: {out}");
	for (k, v) in obj {
		assert_eq!(v, &ok, "{k}");
	}
}

#[test]
fn a_window_scaled_down_to_fit_still_moves_by_the_pointers_exact_travel_and_stays_on_screen() {
	let out = run(r#"
		atScale(1.5)
		local w = windows()
		PolestarWelcome:SetScale(0.8)
		local moved = drag(PolestarWelcome, PolestarWelcome)
		-- Pulled far past the left edge: clamped to it.
		PolestarWelcome:SetClampedToScreen(true)
		PolestarWelcome.IsClampedToScreen = function() return true end
		stub.cursor = { 900, 500 }
		stub.RunScript(PolestarWelcome, "OnMouseDown", "LeftButton")
		stub.cursor = { -4000, 500 }
		stub.advance(0.016)
		stub.RunScript(PolestarWelcome, "OnMouseUp", "LeftButton")
		emit({ moved = moved, left = PolestarWelcome:GetLeft() })"#);
	assert_eq!(out["moved"], json!({ "pressStill": true, "firstPixel": true, "follows": true, "dropStays": true, "clickStill": true }));
	assert_eq!(out["left"], json!(0));
}

#[test]
fn a_locked_guide_window_does_not_move_and_a_move_saves_its_spot() {
	let out = run(r#"
		atScale(1.0)
		local w = windows()
		local F, h = w.guide[1], w.guide[2]
		Polestar.Set("ui.locked", true)
		local before = { F:GetPoint(1) }
		stub.cursor = { 900, 500 }
		stub.RunScript(h, "OnMouseDown", "LeftButton")
		stub.cursor = { 950, 520 }
		stub.advance(0.016)
		stub.RunScript(h, "OnMouseUp", "LeftButton")
		local after = { F:GetPoint(1) }
		local still = before[1] == after[1] and before[4] == after[4] and before[5] == after[5]
		Polestar.Set("ui.locked", false)
		local moved = drag(F, h)
		emit({ still = still, moved = moved, saved = type(Polestar.Get("ui.pos")) == "table" })"#);
	assert_eq!(out["still"], true);
	assert_eq!(out["moved"]["follows"], true);
	assert_eq!(out["saved"], true);
}

// The HUD's own frames, dragged the same way (W.DragWindow): the flight timer and the instance tracker
// (Maps.CompactFrame, their builder; each put back where its saved spot says, as the timer's setting
// handler does), the arrow and the floating button. Each keeps its own lock (ns.DragLocked: ui.lockHud,
// Shift to move), its saved spot's form, and a plain click on the arrow or the button still acts.
const HUD_OK: &str = r#"{ "pressStill": true, "firstPixel": true, "follows": true, "dropStays": true, "clickStill": true }"#;

#[test]
fn the_flight_timer_and_the_instance_tracker_follow_the_pointer_and_stay_where_they_are_dropped_at_every_scale() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: "stub.maps.useWorld(); stub.maps.place(0, 800); stub.world.faction = \"Alliance\"".into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml"])],
		login: true,
		script: [HELPERS, r#"
		local M = Polestar.Maps
		local frames = {
			timer = M.CompactFrame("PolestarDragTimer", "maps.timerPos", "TOP", 0, -140),
			tracker = M.CompactFrame("PolestarDragTracker", "maps.trackerPos", "TOPRIGHT", -220, -220),
		}
		Polestar.On("SETTING_CHANGED", function(p)
			if p == "maps.timerPos" then frames.timer.Place() elseif p == "maps.trackerPos" then frames.tracker.Place() end
		end)
		local out = {}
		for _, k in ipairs({ "0.64", "1", "1.5" }) do
			atScale(tonumber(k))
			for name, f in pairs(frames) do
				f:SetSize(220, 34)
				f.Place()
				f:Show()
				out[name .. "@" .. k] = drag(f, f)
			end
		end
		-- The lock: a plain press and pull leaves it and its spot; Shift moves it.
		local f = frames.timer
		Polestar.Set("ui.lockHud", true)
		local function spot() local p = Polestar.Get("maps.timerPos"); return p and (p[1] .. " " .. p[2] .. " " .. p[3]) or "none" end
		local saved, a0 = spot(), { f:GetPoint(1) }
		stub.cursor = { 900, 500 }
		stub.RunScript(f, "OnMouseDown", "LeftButton")
		stub.cursor = { 960, 520 }
		stub.advance(0.016)
		stub.RunScript(f, "OnMouseUp", "LeftButton")
		local a1 = { f:GetPoint(1) }
		out.locked = a0[1] == a1[1] and a0[4] == a1[4] and a0[5] == a1[5] and spot() == saved
		stub.keys.shift = true
		out.shift = drag(f, f).follows
		local p = Polestar.Get("maps.timerPos")
		out.form = type(p) == "table" and p[1] == "CENTER" and math.floor(p[2]) == p[2] and math.floor(p[3]) == p[3]
		emit(out)"#].join("\n"),
		..Default::default()
	})
	.remove(0);
	let ok: Value = serde_json::from_str(HUD_OK).unwrap();
	for name in ["timer", "tracker"] {
		for s in ["0.64", "1", "1.5"] {
			assert_eq!(out[format!("{name}@{s}")], ok, "{name} at {s}: {out}");
		}
	}
	assert_eq!(out["locked"], true, "locked (ui.lockHud): a plain drag neither moves it nor saves");
	assert_eq!(out["shift"], true, "Shift-drag moves it");
	assert_eq!(out["form"], true, "saved as {{ \"CENTER\", x, y }} in whole units, as before");
}

#[test]
fn the_arrow_follows_the_pointer_saves_its_spot_and_a_plain_click_still_takes_the_next_spot() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml"])],
		login: true,
		script: [HELPERS, r#"
		local nav = stub.nav
		local m, x, y = nav.mapPoint(100, 0)
		Polestar.Nav.SetTarget(m, x, y, "T")
		stub.advance(0.1)
		local f = PolestarNavArrow
		local spots = 0
		Polestar.Nav.NextSpot = function() spots = spots + 1 end
		Polestar.Set("nav.arrowScale", 1.3)
		local out = {}
		for _, k in ipairs({ "0.64", "1", "1.5" }) do
			atScale(tonumber(k))
			out["arrow@" .. k] = drag(f, f)
		end
		out.shown = f:IsShown()
		-- drag(): three drags, each with a plain click after it.
		out.clicks = spots
		local p = Polestar.Get("nav.arrowPos")
		out.form = type(p) == "table" and type(p.point) == "string" and type(p.relPoint) == "string" and type(p.x) == "number"
		Polestar.Set("ui.lockHud", true)
		local a0 = { f:GetPoint(1) }
		stub.cursor = { 900, 500 }
		stub.RunScript(f, "OnMouseDown", "LeftButton")
		stub.cursor = { 960, 520 }
		stub.advance(0.016)
		stub.RunScript(f, "OnMouseUp", "LeftButton")
		local a1 = { f:GetPoint(1) }
		out.locked = a0[4] == a1[4] and a0[5] == a1[5]
		emit(out)"#].join("\n"),
		..Default::default()
	})
	.remove(0);
	let ok: Value = serde_json::from_str(HUD_OK).unwrap();
	for s in ["0.64", "1", "1.5"] {
		assert_eq!(out[format!("arrow@{s}")], ok, "arrow at {s} (scaled 1.3): {out}");
	}
	assert_eq!(out["clicks"], 3, "a move is no click; a plain click takes the next spot");
	assert_eq!(out["form"], true, "saved as {{ point, relPoint, x, y }}, as before");
	assert_eq!(out["locked"], true);
}

#[test]
fn the_floating_button_follows_the_pointer_saves_its_centre_and_a_click_after_a_move_is_no_click() {
	let out = run(r#"
		Polestar.Maps = { ShowMenu = function() end, PaintHidden = function() end, ButtonTip = function() end }
		local toggles = 0
		Polestar.ToggleHidden = function() toggles = toggles + 1 end
		Polestar.Set("ui.launcher", true)
		local b = PolestarLauncher
		local out = {}
		for _, k in ipairs({ "0.64", "1", "1.5" }) do
			atScale(tonumber(k))
			out["button@" .. k] = drag(b, b)
		end
		-- A move, then the release's click the client sends: it does nothing.
		stub.cursor = { 900, 500 }
		stub.RunScript(b, "OnMouseDown", "LeftButton")
		stub.cursor = { 930, 480 }
		stub.advance(0.016)
		stub.RunScript(b, "OnMouseUp", "LeftButton")
		b:Click("LeftButton")
		out.afterMove = toggles
		-- A plain press and release, then its click: shows or hides the window.
		stub.RunScript(b, "OnMouseDown", "LeftButton")
		stub.RunScript(b, "OnMouseUp", "LeftButton")
		b:Click("LeftButton")
		out.plain = toggles
		local p = Polestar.Get("ui.launcherPos")
		out.form = type(p) == "table" and type(p[1]) == "number" and math.floor(p[1]) == p[1]
		emit(out)"#);
	let ok: Value = serde_json::from_str(HUD_OK).unwrap();
	for s in ["0.64", "1", "1.5"] {
		assert_eq!(out[format!("button@{s}")], ok, "floating button at {s}: {out}");
	}
	assert_eq!(out["afterMove"], 0, "a click after a move is no click");
	assert_eq!(out["plain"], 1, "a plain click still shows or hides the window");
	assert_eq!(out["form"], true, "saved as its centre {{ x, y }} in whole units, as before");
}
