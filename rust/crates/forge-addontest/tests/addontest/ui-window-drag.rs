//! Dragging Polestar's windows (W.DragWindow, Theme/Widgets.lua): Install, the guide window, the route choice,
//! the guide end and the hub shell (the settings window's shell) follow the pointer from the first pixel it
//! travels, by exactly its travel at UI scales 0.64, 1.0 and 1.5 (and a window scaled down to fit), and a press
//! that does not move never moves the window or rewrites its anchor.
//!
//! The stub lays nothing out, so each window's left and top are read from its one anchor to UIParent here, as
//! the client resolves them: UIParent 1920 x 1080 physical pixels at the UI scale, the offsets in the window's
//! own (scaled) units.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const HELPERS: &str = r#"
local E = Polestar.Engine
E.GuideEnded = function() return true end
E.NextGuide = function() return "forever/alliance/02-westfall" end
E.GetRouteChoice = function(id)
	return { from = id, fromTitle = "Elwynn Forest", recommended = "a", options = {
		{ id = "a", title = "Westfall", zoneName = "Westfall", minLevel = 12, maxLevel = 17, recommended = true },
		{ id = "b", title = "Darkshore", zoneName = "Darkshore", minLevel = 12, maxLevel = 17 },
	} }
end

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
	local function tick() local f = handle:GetScript("OnUpdate"); if f then f(handle, 0.016) end end
	stub.cursor = { 901, 500 }
	tick()
	local first = { (win:GetLeft() - l0) * e, (win:GetTop() - t0) * e }
	stub.cursor = { 901 + 40, 500 - 30 }
	tick()
	local pulled = { (win:GetLeft() - l0) * e, (win:GetTop() - t0) * e }
	stub.RunScript(handle, "OnMouseUp", "LeftButton")
	local a1 = anchor(win)
	stub.RunScript(handle, "OnMouseDown", "LeftButton")
	tick()
	stub.RunScript(handle, "OnMouseUp", "LeftButton")
	return {
		pressStill = pressed,
		firstPixel = near(first[1], 1) and near(first[2], 0),
		follows = near(pulled[1], 41) and near(pulled[2], -30),
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
		script: ["uistub.install()", "stub.login()", HELPERS, script].join("\n"),
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
	let ok = json!({ "pressStill": true, "firstPixel": true, "follows": true, "clickStill": true });
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
		PolestarWelcome:GetScript("OnUpdate")(PolestarWelcome, 0.016)
		stub.RunScript(PolestarWelcome, "OnMouseUp", "LeftButton")
		emit({ moved = moved, left = PolestarWelcome:GetLeft() })"#);
	assert_eq!(out["moved"], json!({ "pressStill": true, "firstPixel": true, "follows": true, "clickStill": true }));
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
		local f = h:GetScript("OnUpdate"); if f then f(h, 0.016) end
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
