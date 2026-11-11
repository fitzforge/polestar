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
"card": {"at": "BOTTOMLEFT>window.TOPLEFT@0,-1", "h": 138, "shown": true, "text": false, "w": 340},
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
"card": {"at": "BOTTOMLEFT>window.TOPLEFT@0,-1", "h": 144, "shown": true, "text": false, "w": 340},
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

// Below: under the window's bottom edge, sliding out from behind it; over it again where the screen has no room
// below. Above (the default) turns under the window where the screen has no room above.
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
	assert_eq!(out["below"]["at"], "TOPLEFT>window.BOTTOMLEFT@0,1", "under the window's bottom edge");
	assert_eq!(out["noRoomBelow"], "above", "no room below: over the window");
	assert_eq!(out["noRoomAbove"], "below", "no room above: under the window");
	assert_eq!(out["aboveAt"], "TOPLEFT>window.BOTTOMLEFT@0,1");
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
