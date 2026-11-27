//! The heads-up card over the guide window (addon/Polestar/UI/ClassToast.lua: the class quest's, a dungeon's and
//! the others it carries): a fresh install draws it in the house look's own way since 0.3.8 (the title first, the
//! facts under it in sentence case with the chip, no stripe); a skin built on the house look draws it exactly as
//! 0.3.7 did; where it goes (toasts.headsup.place: above the window, below it, or a spot of its own) and its compact
//! style (toasts.headsup.compact) are options that change the live card. The class quest scene of class-quests.rs:
//! an Orc Warlock at 10, the Durotar guide open, Gan'rul's Summons ready.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The card and each of its parts as drawn: shown, size, anchors (to the card, the guide window, the screen or a
// part), text; rounded to a tenth.
const DUMP: &str = r#"
local function r(v) return v and math.floor(v * 10 + 0.5) / 10 or false end
local function pts(o)
	local out = {}
	for i = 1, (o.GetNumPoints and o:GetNumPoints() or 0) do
		local p, rel, rp, x, y = o:GetPoint(i)
		-- A part of the card by its field name; the card, the window and the screen by theirs (the screen last:
		-- a frame's own parent field is UIParent too).
		local relName = false
		for k, v in pairs(CT.frame) do if v == rel then relName = k end end
		relName = rel == CT.frame and "card" or rel == GF.frame and "window" or rel == UIParent and "screen" or relName
		out[i] = p .. ">" .. tostring(relName) .. "." .. tostring(rp) .. "@" .. r(x) .. "," .. r(y)
	end
	return table.concat(out, " ")
end
local function part(o)
	if not o then return false end
	local t = o.GetText and o:GetText() or nil
	return { shown = o:IsShown() and true or false, w = r(o:GetWidth()), h = r(o:GetHeight()), at = pts(o), text = t or false }
end
function DUMP()
	local f = CT.frame
	local out = { card = part(f), side = CT.side, scale = r(f:GetScale()) }
	for _, k in ipairs({ "Stripe", "Ring", "Disc", "Icon", "Head", "Title", "Giver", "Route", "Badge", "Rule", "Close", "Open", "ShowMe", "Later", "Act", "More", "Off" }) do
		out[k] = part(f[k])
	end
	return out
end
who("WARLOCK", "Orc", "Horde", 10)
uistub.openTabs({ { "test/durotar", 1 } }, 1)
"#;

// The card as 0.3.7 drew it (next at 0df6f58ab, this scene, 2026-11-11): every look but the house look keeps it.
// Since 0.4.0 it stands clear of the window's drawing (here the shadow's 12 units over its top, and 4 more), not
// a unit into the window.
const AS_IN_0_3_7: &str = r#"{"Act": {"at": "", "h": 28, "shown": false, "text": false, "w": 72},
"Badge": {"at": "TOPRIGHT>card.TOPRIGHT@-34,-12", "h": 18, "shown": true, "text": false, "w": 53},
"Close": {"at": "TOPRIGHT>card.TOPRIGHT@-6,-6", "h": 24, "shown": true, "text": false, "w": 24},
"Disc": {"at": "CENTER>Ring.CENTER@0,0", "h": 36, "shown": true, "text": false, "w": 36},
"Giver": {"at": "TOPLEFT>card.TOPLEFT@70,-48", "h": 0, "shown": true, "text": "Get it from Ophek, Durotar.", "w": 256},
"Head": {"at": "TOPLEFT>card.TOPLEFT@70,-14", "h": 0, "shown": true, "text": "LEVEL 10 · WARLOCK", "w": 175},
"Icon": {"at": "CENTER>Ring.CENTER@0,0", "h": 32, "shown": true, "text": false, "w": 32},
"Later": {"at": "LEFT>Open.RIGHT@8,0", "h": 28, "shown": true, "text": false, "w": 72},
"More": {"at": "", "h": 28, "shown": false, "text": false, "w": 72},
"Off": {"at": "", "h": 28, "shown": false, "text": false, "w": 72},
"Open": {"at": "TOPLEFT>card.TOPLEFT@18,-96", "h": 28, "shown": true, "text": false, "w": 134},
"Ring": {"at": "TOPLEFT>card.TOPLEFT@18,-14", "h": 40, "shown": true, "text": false, "w": 40},
"Route": {"at": "TOPLEFT>card.TOPLEFT@70,-62", "h": 0, "shown": true, "text": "Your route takes you there at Orgrimmar.", "w": 256},
"Rule": {"at": "TOPLEFT>card.TOPLEFT@18,-86 TOPRIGHT>card.TOPRIGHT@-14,-86", "h": 1, "shown": true, "text": false, "w": 0},
"ShowMe": {"at": "", "h": 28, "shown": false, "text": false, "w": 74},
"Stripe": {"at": "TOPLEFT>card.TOPLEFT@1,-1 BOTTOMLEFT>card.BOTTOMLEFT@1,1", "h": 0, "shown": true, "text": false, "w": 4},
"Title": {"at": "TOPLEFT>card.TOPLEFT@70,-29", "h": 0, "shown": true, "text": "Voidwalker ready", "w": 240},
"card": {"at": "BOTTOMLEFT>window.TOPLEFT@0,16", "h": 138, "shown": true, "text": false, "w": 340},
"scale": 1, "side": "above"}"#;

// The house look's card since 0.3.8 (glowup-038, this scene, 2026-11-12): the title at the top, "Level 10 · Warlock"
// under it on the chip's middle with the chip after it, no stripe, everything 4px further left.
const HOUSE_0_3_8: &str = r#"{"Act": {"at": "", "h": 28, "shown": false, "text": false, "w": 72},
"Badge": {"at": "TOPLEFT>card.TOPLEFT@173,-32", "h": 18, "shown": true, "text": false, "w": 53},
"Close": {"at": "TOPRIGHT>card.TOPRIGHT@-6,-6", "h": 24, "shown": true, "text": false, "w": 24},
"Disc": {"at": "CENTER>Ring.CENTER@0,0", "h": 36, "shown": true, "text": false, "w": 36},
"Giver": {"at": "TOPLEFT>card.TOPLEFT@66,-54", "h": 0, "shown": true, "text": "Get it from Ophek, Durotar.", "w": 260},
"Head": {"at": "LEFT>card.TOPLEFT@66,-41", "h": 0, "shown": true, "text": "Level 10 · Warlock", "w": 260},
"Icon": {"at": "CENTER>Ring.CENTER@0,0", "h": 32, "shown": true, "text": false, "w": 32},
"Later": {"at": "LEFT>Open.RIGHT@8,0", "h": 28, "shown": true, "text": false, "w": 72},
"More": {"at": "", "h": 28, "shown": false, "text": false, "w": 72},
"Off": {"at": "", "h": 28, "shown": false, "text": false, "w": 72},
"Open": {"at": "TOPLEFT>card.TOPLEFT@14,-102", "h": 28, "shown": true, "text": false, "w": 134},
"Ring": {"at": "TOPLEFT>card.TOPLEFT@14,-14", "h": 40, "shown": true, "text": false, "w": 40},
"Route": {"at": "TOPLEFT>card.TOPLEFT@66,-68", "h": 0, "shown": true, "text": "Your route takes you there at Orgrimmar.", "w": 260},
"Rule": {"at": "TOPLEFT>card.TOPLEFT@14,-92 TOPRIGHT>card.TOPRIGHT@-14,-92", "h": 1, "shown": true, "text": false, "w": 0},
"ShowMe": {"at": "", "h": 28, "shown": false, "text": false, "w": 74},
"Stripe": {"at": "TOPLEFT>card.TOPLEFT@1,-1 BOTTOMLEFT>card.BOTTOMLEFT@1,1", "h": 0, "shown": false, "text": false, "w": 4},
"Title": {"at": "TOPLEFT>card.TOPLEFT@66,-14", "h": 0, "shown": true, "text": "Voidwalker ready", "w": 244},
"card": {"at": "BOTTOMLEFT>window.TOPLEFT@0,16", "h": 144, "shown": true, "text": false, "w": 340},
"scale": 1, "side": "above"}"#;

fn run(script: &str) -> Value {
	let pre = crate::class_quests::TOAST_PRE;
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &UI_FILES)], script: format!("{pre}{DUMP}{script}"), ..Default::default() }).remove(0)
}

// A player who never touches the card's options sees it above the window, as wide as it, in the house look's own
// way.
#[test]
fn a_fresh_install_draws_the_heads_up_card_in_the_house_looks_own_way() {
	let out = run(r#"
		CT.Show(1506)
		stub.advance(1)
		emit({ dump = DUMP(), place = Polestar.Get("toasts.headsup.place"), compact = Polestar.Get("toasts.headsup.compact") })"#);
	let want: Value = serde_json::from_str(HOUSE_0_3_8).unwrap();
	assert_eq!(out["dump"], want, "the card at a fresh install");
	assert_eq!(out["place"], "above");
	assert_eq!(out["compact"], false);
}

// A skin built on the house look (here one registered with nothing of its own) gets none of the house look's own
// touches: every part where 0.3.7 put it, the header over the title, the stripe.
#[test]
fn a_skin_on_the_house_look_draws_the_heads_up_card_exactly_as_0_3_7_did() {
	let out = run(r#"
		Polestar.Theme.RegisterSkin("plain", { name = "Plain", addon = "Test_Plain" })
		Polestar.Set("ui.skin", "plain")
		CT.Show(1506)
		stub.advance(1)
		emit({ dump = DUMP(), skin = Polestar.Theme.SkinId(), base = Polestar.Theme.SkinKey() })"#);
	assert_eq!((out["skin"].as_str(), out["base"].as_str()), (Some("plain"), Some("polestar")), "a skin on the house look");
	let want: Value = serde_json::from_str(AS_IN_0_3_7).unwrap();
	assert_eq!(out["dump"], want, "the card as 0.3.7 drew it");
}

// Below: under the window's bottom edge, sliding out from behind it, clear of the shadow drawn under it (20 units,
// and 4 more); over it again where the screen has no room below. Above (the default) turns under the window where
// the screen has no room above.
#[test]
fn below_puts_the_card_under_the_window_and_each_side_turns_where_the_screen_has_no_room() {
	let out = run(r#"
		CT.Show(1506)
		stub.advance(1)
		-- The window in the middle of the screen (the stub's frames stand at x, y): room on both sides.
		local w = GF.frame
		w.y = 300
		Polestar.Set("toasts.headsup.place", "below")
		CT.Place()
		local below = { side = CT.side, at = DUMP().card.at }
		-- The window at the screen's bottom: no room under it.
		w.y = 4
		CT.Place()
		local noRoomBelow = CT.side
		-- Above, the window at the screen's top: no room over it.
		Polestar.Set("toasts.headsup.place", nil)
		w.y = UIParent.height - w:GetHeight() + 10
		CT.Place()
		emit({ below = below, noRoomBelow = noRoomBelow, noRoomAbove = CT.side, aboveAt = DUMP().card.at })"#);
	assert_eq!(out["below"]["side"], "below");
	assert_eq!(out["below"]["at"], "TOPLEFT>window.BOTTOMLEFT@0,-24", "under the window's bottom edge, clear of its shadow");
	assert_eq!(out["noRoomBelow"], "above", "no room below: over the window");
	assert_eq!(out["noRoomAbove"], "below", "no room above: under the window");
	assert_eq!(out["aboveAt"], "TOPLEFT>window.BOTTOMLEFT@0,-24");
}

// A window as tall as the screen leaves no room over or under it: the card stands beside it, top edges level, on the
// side facing the middle of the screen, else the side with room; clear of the shadow at its side (16 units, and 4).
// The house look's shadow is what the window draws past its edges (CT.Reach).
#[test]
fn with_no_room_over_or_under_the_window_the_card_stands_beside_it() {
	let out = run(r#"
		CT.Show(1506)
		stub.advance(1)
		local w = GF.frame
		local reach = CT.Reach(w)
		w.y = 100
		w:SetHeight(900)
		w.x = 1300
		CT.Place()
		local right = { side = CT.side, at = DUMP().card.at }
		w.x = 100
		CT.Place()
		emit({ reach = reach, nearRight = right, nearLeft = { side = CT.side, at = DUMP().card.at } })"#);
	assert_eq!(out["reach"], serde_json::json!({ "top": 12, "bottom": 20, "left": 16, "right": 16 }), "the house look's shadow");
	assert_eq!(out["nearRight"], serde_json::json!({ "side": "left", "at": "TOPRIGHT>window.TOPLEFT@-20,0" }), "near the right edge: on its left");
	assert_eq!(out["nearLeft"], serde_json::json!({ "side": "right", "at": "TOPLEFT>window.TOPRIGHT@20,0" }), "near the left edge: on its right");
}

// A skin that draws its own cards above the window (Skin API 2's guideAnchor: the Atlas layout's stack) gives the
// card their frame to sit on. With no room over them (the window near the screen's top), the card goes under the
// window, never under that frame: there it lay on the window, behind it, its buttons out of reach (#4212, the level-up
// and old-rank spell cards). With room it still sits on the skin's cards; the house look keeps its place under the
// window (the test above).
#[test]
fn under_a_skin_s_cards_above_the_window_the_card_never_lands_on_the_window_4212() {
	let out = run(r#"
		CT.Show(1506)
		stub.advance(1)
		local w = GF.frame
		local stack = CreateFrame("Frame", nil, UIParent)
		local ok, why = Polestar.Theme.RegisterSkin("stacked", { name = "Stacked", addon = "Test_Stacked", base = "polestar",
			hooks = { guideAnchor = function() return stack end } })
		Polestar.Set("ui.skin", "stacked")
		-- The card's box from its first anchor (to the window or the skin's frame), against the window's.
		local function at()
			local f = CT.frame
			local p, rel, rp, x, y = f:GetPoint(1)
			local ref = rp:find("^BOTTOM") and rel:GetBottom() or rel:GetTop()
			local bottom = p:find("^BOTTOM") and ref + y or ref + y - f:GetHeight() * f:GetScale()
			local top = bottom + f:GetHeight() * f:GetScale()
			return { side = CT.side, on = rel == w and "window" or rel == stack and "stack" or tostring(rel),
				overWindow = bottom < w:GetTop() and top > w:GetBottom() }
		end
		local function place(y)
			w.y = y
			stack.x, stack.y = w.x, w:GetTop()
			stack:SetSize(w:GetWidth(), 70)
			CT.Place()
			return at()
		end
		-- Room over the skin's cards: on them.
		local room = place(200)
		-- The window near the screen's top, the cards over it up to the edge: under the window.
		local top = place(UIParent.height - w:GetHeight() - 75)
		emit({ ok = ok, why = why or false, room = room, top = top })"#);
	assert_eq!(out["ok"], true, "registered: {}", out["why"]);
	assert_eq!(out["room"], serde_json::json!({ "side": "above", "on": "stack", "overWindow": false }), "room over the cards: on them");
	assert_eq!(out["top"], serde_json::json!({ "side": "below", "on": "window", "overWindow": false }), "no room over the cards: under the window, clear of it");
}

// A spot of its own: the card leaves the window for its saved place (the screen's top middle until it is moved),
// stays on screen, and Move frames offers its box only while it has a spot of its own.
#[test]
fn a_spot_of_its_own_takes_the_card_off_the_window_to_its_saved_place_moved_with_move_frames() {
	let out = run(r#"
		CT.Show(1506)
		stub.advance(1)
		local M = Polestar.Movers
		local boxBefore = (function()
			M.Unlock()
			local b = M.Box("headsUp")
			local shown = b ~= nil and b:IsShown() or false
			M.Lock()
			return shown
		end)()
		Polestar.Set("toasts.headsup.place", "free")
		CT.Place()
		local first = { side = CT.side, at = DUMP().card.at }
		Polestar.Set("toasts.headsup.pos", { "TOPLEFT", 120, -80 })
		CT.Place()
		local moved = DUMP().card.at
		M.Unlock()
		local b = M.Box("headsUp")
		emit({ boxBefore = boxBefore, first = first, moved = moved, box = b ~= nil and b:IsShown() or false })"#);
	assert_eq!(out["boxBefore"], false, "no box for the card while it sits on the window");
	assert_eq!(out["first"]["side"], "free");
	assert_eq!(out["first"]["at"], "TOP>screen.TOP@0,-200", "the screen's top middle until it is moved");
	assert_eq!(out["moved"], "TOPLEFT>screen.TOPLEFT@120,-80", "its saved place");
	assert_eq!(out["box"], true, "Move frames has its box");
}

// Compact: one line (the icon, the title and the action, the close button), the header, giver, route and Later
// in its tooltip and menu; off again, the full card is back.
#[test]
fn compact_draws_the_card_on_one_line_and_off_again_the_full_card_is_back() {
	let out = run(r#"
		CT.Show(1506)
		stub.advance(1)
		local full = CT.frame:GetHeight()
		Polestar.Set("toasts.headsup.compact", true)
		CT.Place()
		local f = CT.frame
		local compact = { h = f:GetHeight(), title = f.Title:IsShown(), open = f.Open:IsShown(), close = f.Close:IsShown(),
			head = f.Head:IsShown(), giver = f.Giver:IsShown(), route = f.Route:IsShown(), later = f.Later:IsShown() }
		CT.CompactTip(f)
		local tip = GameTooltip:IsShown()
		Polestar.Set("toasts.headsup.compact", nil)
		CT.Place()
		emit({ full = full, compact = compact, tip = tip, back = f:GetHeight(), giver = f.Giver:IsShown() })"#);
	let c = &out["compact"];
	assert!(c["h"].as_f64().unwrap() <= 48.0, "one line: {}", c["h"]);
	assert_eq!((c["title"].as_bool(), c["open"].as_bool(), c["close"].as_bool()), (Some(true), Some(true), Some(true)));
	assert_eq!((c["head"].as_bool(), c["giver"].as_bool(), c["route"].as_bool(), c["later"].as_bool()), (Some(false), Some(false), Some(false), Some(false)));
	assert_eq!(out["tip"], true, "what the line leaves out is in its tooltip");
	assert_eq!(out["back"], out["full"], "off again: the full card");
	assert_eq!(out["giver"], true);
}

// A frame's edges as the client gives them: its box in its own units from its first anchor.
const LIVE: &str = r#"
local function at(pt, wd, ht)
	return (pt:find("LEFT") and 0 or pt:find("RIGHT") and 1 or 0.5) * wd, (pt:find("BOTTOM") and 0 or pt:find("TOP") and 1 or 0.5) * ht
end
-- A frame's box in screen pixels, { left, bottom, right, top }, from its first anchor.
local function box(o)
	local e = o:GetEffectiveScale()
	local wd, ht = o:GetWidth() * e, o:GetHeight() * e
	local p, rel, rp, x, y = o:GetPoint(1)
	if o == UIParent or not p then return { 0, 0, wd, ht } end
	local r = box(rel or UIParent)
	local ax, ay = at(rp, r[3] - r[1], r[4] - r[2])
	local px, py = at(p, wd, ht)
	local l, b = r[1] + ax + x * e - px, r[2] + ay + y * e - py
	return { l, b, l + wd, b + ht }
end
-- The frame's edges as the client gives them: its box in its own units.
local function live(o)
	local function edge(i) return function(self) return box(self)[i] / self:GetEffectiveScale() end end
	o.GetLeft, o.GetBottom, o.GetRight, o.GetTop = edge(1), edge(2), edge(3), edge(4)
	o.GetCenter = function(self)
		local b, e = box(self), self:GetEffectiveScale()
		return (b[1] + b[3]) / 2 / e, (b[2] + b[4]) / 2 / e
	end
end
"#;

// Dragging the heads-up card directly with the mouse frees it from the window, sets toasts.headsup.place to "free",
// and records its new drop position. With ui.lockHud, a plain drag does not move it and Shift-drag does.
#[test]
fn dragging_the_heads_up_card_switches_its_place_to_free_and_saves_its_spot_2629() {
	let out = run(&[
		LIVE,
		r#"
		CT.Show(1506)
		stub.advance(1)
		local f = CT.frame
		live(f)
		local movable = f:IsMovable() and true or false
		local placeBefore = Polestar.Get("toasts.headsup.place")
		-- A drag on the card (pressed, moved, released)
		stub.cursor = { 500, 500 }
		stub.RunScript(f, "OnMouseDown", "LeftButton")
		stub.advance(0.016)
		stub.cursor = { 550, 450 }
		stub.advance(0.016)
		stub.RunScript(f, "OnMouseUp", "LeftButton")
		local pos = Polestar.Get("toasts.headsup.pos")
		local placeAfter = Polestar.Get("toasts.headsup.place")

		-- With ui.lockHud, a plain drag does nothing
		Polestar.Set("ui.lockHud", true)
		local savedPos = { pos[1], pos[2], pos[3] }
		stub.cursor = { 550, 450 }
		stub.RunScript(f, "OnMouseDown", "LeftButton")
		stub.advance(0.016)
		stub.cursor = { 600, 400 }
		stub.advance(0.016)
		stub.RunScript(f, "OnMouseUp", "LeftButton")
		local posLocked = Polestar.Get("toasts.headsup.pos")
		local lockedStayed = posLocked[1] == savedPos[1] and posLocked[2] == savedPos[2] and posLocked[3] == savedPos[3]

		-- With ui.lockHud, Shift-drag moves it
		stub.keys.shift = true
		stub.cursor = { 550, 450 }
		stub.RunScript(f, "OnMouseDown", "LeftButton")
		stub.advance(0.016)
		stub.cursor = { 600, 400 }
		stub.advance(0.016)
		stub.RunScript(f, "OnMouseUp", "LeftButton")
		stub.keys.shift = false
		local posShift = Polestar.Get("toasts.headsup.pos")
		local shiftMoved = posShift[2] ~= savedPos[2] or posShift[3] ~= savedPos[3]

		emit({ movable = movable, placeBefore = placeBefore, placeAfter = placeAfter,
			side = CT.side, pos = type(pos) == "table" and pos[1] or false,
			lockedStayed = lockedStayed, shiftMoved = shiftMoved })"#,
	]
	.join("\n"));
	assert_eq!(out["movable"], true, "card is movable");
	assert_eq!(out["placeBefore"], "above");
	assert_eq!(out["placeAfter"], "free", "dragging frees the card from the window");
	assert_eq!(out["side"], "free");
	assert_eq!(out["pos"], "TOP", "saved on its drop point");
	assert_eq!(out["lockedStayed"], true, "locked (ui.lockHud): a plain drag leaves the card");
	assert_eq!(out["shiftMoved"], true, "locked (ui.lockHud): Shift-drag moves it");
}

// The card with the quest buttons and their target list (QoL/Buttons.lua) on one screen (#2629: Drasi's list drawn
// over the card and its buttons). The stub keeps a frame's anchors but never lays them out, so here the window, the
// buttons, the list's rows and mark and the card read their edges off their anchors as the client does (the frame
// each hangs from, every scale counted). The screen is 1366 x 768 pixels; UIParent's units follow the UI scale.
// The step has five mobs, so the list shows five rows.
const ON_SCREEN: &str = r#"
local B, QoL = Polestar.QoL.Buttons, Polestar.QoL
local w = GF.frame
local function screen(scale) UIParent.scale, UIParent.width, UIParent.height = scale, 1366 / scale, 768 / scale end
local function kill(name, id) return G("kill", { verb = "Kill", subject = name, subjectKind = "npc", npc = id, status = "active" }) end
add({ id = "test/boars", pack = "guides", title = "Boars", faction = "Horde", category = "Leveling", minLevel = 1, maxLevel = 12,
	zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = {
	{ title = "Boars", goals = { kill("Test Boar A", 9001), kill("Test Boar B", 9002), kill("Test Boar C", 9003), kill("Test Boar D", 9004), kill("Test Boar E", 9005) } },
} })
uistub.openTabs({ { "test/boars", 1 } }, 1)
stub.advance(1)
CT.Show(1506)
stub.advance(1)
for _, o in ipairs({ w, B.Holder(), B.item, B.hearth, B.target, B.rare, B.bag, B.anchor, CT.frame }) do live(o) end
for _, r in ipairs(B.rows) do live(r) end
local function rowsShown()
	local n = 0
	for _, r in ipairs(B.rows) do if r:IsVisible() then n = n + 1 end end
	return n
end
-- How many of the shown buttons, the list's rows and its mark the card covers.
local function covered()
	local c = box(CT.frame)
	local n = 0
	local list = { B.anchor, B.item, B.hearth, B.target, B.rare, B.bag }
	for _, r in ipairs(B.rows) do list[#list + 1] = r end
	for _, o in ipairs(list) do
		if o:IsVisible() then
			local b = box(o)
			if c[1] < b[3] and b[1] < c[3] and c[2] < b[4] and b[2] < c[4] then n = n + 1 end
		end
	end
	return n
end
"#;

fn run_on_screen(script: &str) -> Value {
	let pre = crate::class_quests::TOAST_PRE;
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "QoL/QoL.xml", "UI/UI.xml"])],
		script: format!("{pre}{DUMP}{LIVE}{ON_SCREEN}{script}"),
		..Default::default()
	})
	.remove(0)
}

// Where they open for a player who never moved them (the window at the screen's top right, the buttons right of
// its middle, the list beside the target button): at UI scale 0.64, 1 and 1.5, above, below or on its own spot,
// full or compact (the card and the window), with the window as tall as the step makes it or a long step's 300
// units, the card covers none of the buttons and none of the list.
#[test]
fn at_their_default_places_the_heads_up_card_never_covers_the_target_list_2629() {
	let out = run_on_screen(
		r#"
		local scenes, bad = {}, {}
		for _, scale in ipairs({ 0.64, 1, 1.5 }) do
			for _, place in ipairs({ "above", "below", "free" }) do
				for _, compact in ipairs({ false, true }) do
					for _, tall in ipairs({ false, 300 }) do
						screen(scale)
						Polestar.Set("toasts.headsup.place", place)
						Polestar.Set("toasts.headsup.compact", compact)
						Polestar.Set("ui.compact", compact)
						GF.ApplyPosition()
						GF.Layout()
						if tall then w:SetHeight(tall) end
						CT.Place(false)
						stub.advance(1)
						local name = table.concat({ scale, place, compact and "compact" or "full", tall or "laid out" }, " ")
						scenes[#scenes + 1] = name
						if not CT.frame:IsShown() then bad[#bad + 1] = name .. ": no card" end
						local n = covered()
						if n > 0 then bad[#bad + 1] = name .. ": the card " .. CT.side .. " covers " .. n end
					end
				end
			end
		end
		emit({ rows = rowsShown(), scenes = #scenes, bad = bad, moved = QoL.State().buttonPos or false, pos = Polestar.Get("ui.pos") or false })"#,
	);
	assert_eq!(out["rows"], 5, "the list shows the step's five mobs");
	assert_eq!(out["scenes"], 36);
	let bad = &out["bad"];
	assert!(bad.as_array().is_some_and(|a| a.is_empty()) || bad.as_object().is_some_and(|o| o.is_empty()), "the card covers the list or a button: {bad}");
	assert_eq!((&out["moved"], &out["pos"]), (&Value::Bool(false), &Value::Bool(false)), "nothing moved: the default places");
}

// A player who moved them keeps their places: with the list standing over where the card would go (Drasi's
// screenshot: the rows over the card above the window and over the window's header), the card takes a side clear
// of it; and moving the buttons onto a card already shown moves the card aside.
#[test]
fn the_heads_up_card_takes_a_side_clear_of_a_moved_target_list_2629() {
	let out = run_on_screen(
		r#"
		screen(1)
		local spot = { "CENTER", "CENTER", 260, 140 }
		B.SetPosition(spot)
		local row = box(B.rows[1])
		Polestar.Set("ui.pos", { row[1] - 40, row[4] - 60 })
		w:SetHeight(300)
		CT.Place(false)
		stub.advance(1)
		local moved = { side = CT.side, covered = covered(), buttons = QoL.State().buttonPos, pos = Polestar.Get("ui.pos") }
		-- Back to the default places, the card above the window; then the buttons dragged so the first row lands on it.
		B.SetPosition(nil)
		Polestar.Set("ui.pos", nil)
		w:SetHeight(300)
		CT.Place(false)
		stub.advance(1)
		local before = { side = CT.side, covered = covered() }
		local c = box(CT.frame)
		B.SetPosition({ "CENTER", "BOTTOMLEFT", c[1] - 6, c[4] + 16 })
		stub.advance(1)
		emit({ rows = rowsShown(), moved = moved, row = row, before = before, dragged = { side = CT.side, covered = covered() } })"#,
	);
	assert_eq!(out["rows"], 5);
	let moved = &out["moved"];
	assert_eq!(moved["covered"], 0, "the card clear of the moved list: {moved}");
	assert_ne!(moved["side"], "above", "above is under the list: {moved}");
	assert_eq!(moved["buttons"], serde_json::json!(["CENTER", "CENTER", 260, 140]), "the buttons stay where the player put them");
	let (l, t) = (out["row"][0].as_f64().unwrap(), out["row"][3].as_f64().unwrap());
	let pos = (moved["pos"][0].as_f64().unwrap(), moved["pos"][1].as_f64().unwrap());
	assert_eq!(pos, (l - 40.0, t - 60.0), "the window stays where the player put it");
	assert_eq!(out["before"], serde_json::json!({ "side": "above", "covered": 0 }), "at the default places: above the window");
	assert_eq!(out["dragged"]["covered"], 0, "the buttons dragged onto the card: it moves aside: {}", out["dragged"]);
}

// A fight's end shows, hides and places the quest buttons in one frame (QoL.Secure's queue at
// PLAYER_REGEN_ENABLED), and each of those had the card measure the window, its look and the screen again
// (#2772: 0.4.1's hitch on kills). They say so once a frame at most, and the card takes its side again only when
// what the buttons cover changed. Before: a burst of 8 shows and hides and a placing fired 9 times and placed the
// card 9 times.
#[test]
fn buttons_coming_and_going_in_one_frame_place_the_heads_up_card_once_and_only_when_they_moved_2772() {
	let out = run_on_screen(
		r#"
		screen(1)
		w:SetHeight(300)
		CT.Place(false)
		stub.advance(1)
		local fired, placed, real = 0, 0, CT.Place
		Polestar.On("QUEST_BUTTONS_PLACED", function() fired = fired + 1 end)
		CT.Place = function(...) placed = placed + 1 return real(...) end
		local function burst(spot)
			fired, placed = 0, 0
			for _, b in ipairs({ B.item, B.hearth, B.rare, B.bag }) do
				if b:IsShown() then b:Hide(); b:Show() else b:Show(); b:Hide() end
			end
			B.SetPosition(spot)
			stub.advance(1)
			return { fired = fired, placed = placed, side = CT.side, covered = covered() }
		end
		local same = burst(nil)
		local moved = burst({ "CENTER", "CENTER", 260, 140 })
		emit({ same = same, moved = moved })"#,
	);
	assert_eq!((&out["same"]["fired"], &out["same"]["placed"]), (&Value::from(1), &Value::from(0)), "nothing moved: {}", out["same"]);
	assert_eq!((&out["moved"]["fired"], &out["moved"]["placed"]), (&Value::from(1), &Value::from(1)), "the buttons moved: {}", out["moved"]);
	assert_eq!(out["moved"]["covered"], 0, "the card clear of the moved buttons: {}", out["moved"]);
}
