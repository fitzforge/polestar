//! Docked action buttons (qol.buttonDock, addon/Polestar/QoL/Buttons.lua, #2242): the guide window keeps a strip at
//! its bottom and the shown buttons lie in a row in it, placed out of combat only; the goal the single target
//! button takes next wears its crosshair in the window. Against the real Core, Theme, QoL and UI and the fakes of
//! tests/lua/stub_ui.lua (a frame's place there is its x, y).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const MODS: [&str; 4] = ["Core/Core.xml", "Theme/Theme.xml", "QoL/QoL.xml", "UI/UI.xml"];

// The guide window at (100, 300), 340 wide, on Elwynn's Kobold Camp: a kill goal (Kobold Vermin) and a collect
// goal (Young Wolf drops the meat). x(b): a button's x in the row, from the holder's corner.
const PRELUDE: &str = r#"
local GF, QoL = Polestar.UI.GuideFrame, Polestar.QoL
local F, B = GF.frame, QoL.Buttons
local function x(b) return (select(4, b:GetPoint(1))) end
local function holderAt() local _, _, _, hx, hy = B.Holder():GetPoint(1); return { hx, hy } end
local function kobolds(simple)
	Polestar.Set("qol.targetSimple", simple ~= false)
	uistub.setGuide(uistub.elwynn, 3)
	F.x, F.y = 100, 300
	F:SetWidth(340)
	stub.runTimers()
end
-- The goal rows wearing the crosshair: their text and whether the glyph is the crosshair.
local function aims()
	local out = {}
	for _, r in ipairs(GF.parts.goals.Child and { GF.parts.goals.Child:GetChildren() } or {}) do
		if r.psGoal and r:IsShown() and r.psAimed then
			out[#out + 1] = { r.Text:GetText(), tostring(r.Icon:GetTexture()):match("qol%-target") ~= nil }
		end
	end
	return out
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &MODS)], script: format!("uistub.install()\nstub.login()\n{PRELUDE}{script}"), ..Default::default() })
		.remove(0)
}

fn n(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

/// An empty Lua list (it emits as `{}`).
fn empty(v: &Value) -> bool {
	v.as_array().is_some_and(|a| a.is_empty()) || v.as_object().is_some_and(|o| o.is_empty())
}

// On: a 52px strip (a 36px button, 8 padding above and below) under the window's parts, the row at its
// bottom-left inside the padding, the target button at the left and its name after it; off again, the window
// gives the strip back and the set floats at its saved spot with its name beside it as before.
#[test]
fn docked_the_window_keeps_a_strip_and_the_row_lies_in_it_off_again_the_set_floats() {
	let out = run(r#"
		kobolds()
		local h0 = F:GetHeight()
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		local docked = { strip = F:GetHeight() - h0, at = holderAt(), point = (B.target:GetPoint(1)), docked = B.Docked(),
			name = B.target.Label:GetText(), nameShown = B.target.Label:IsShown(), nameW = B.target.Label:GetWidth(),
			namePoint = { select(4, B.target.Label:GetPoint(1)) }, foot = select(5, GF.parts.foot:GetPoint(1)) }
		Polestar.Set("qol.buttonDock", false)
		stub.runTimers()
		emit({ docked = docked, after = F:GetHeight() - h0, point = (B.target:GetPoint(1)), docked2 = B.Docked(),
			nameW = B.target.Label:GetWidth(), foot = select(5, GF.parts.foot:GetPoint(1)) })
	"#);
	let d = &out["docked"];
	assert_eq!(n(&d["strip"]), 52.0, "{out}");
	assert_eq!(d["at"], json!([108, 308]), "the row starts at the window's bottom-left, inside its padding");
	assert_eq!(d["point"], "BOTTOMLEFT");
	assert_eq!(d["docked"], true);
	assert_eq!(d["name"], "Kobold Vermin");
	assert_eq!(d["nameShown"], true);
	assert_eq!(n(&d["nameW"]), 340.0 - 16.0 - 42.0, "the name has the room between the target button and the right end");
	assert_eq!(d["namePoint"], json!([42, 18]), "right after the target button and its gap, on the row's middle");
	assert_eq!(n(&d["foot"]), 52.0, "the progress sits on the strip, not under the buttons");
	assert_eq!(n(&out["after"]), 0.0, "undocked, the window gives the strip back");
	assert_eq!(out["point"], "CENTER");
	assert_eq!(out["docked2"], false);
	assert_eq!(n(&out["nameW"]), 0.0, "the name is the button's own again, its own width");
	assert_eq!(n(&out["foot"]), 0.0);
}

// Every button up: target and rare packed in from the left, then the rare's name in the room left between; the
// bag at the window's width less the padding and itself, the Hearthstone and quest item leftward from it.
#[test]
fn docked_a_full_row_target_and_rare_at_the_left_item_hearthstone_and_bag_at_the_right_end() {
	let out = run(r#"
		kobolds()
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		B.rare.applied = "Mor'Ladim"
		B.rare.Label:SetText("Mor'Ladim")
		for _, b in ipairs({ B.item, B.hearth, B.rare, B.bag }) do b:Show() end
		stub.runTimers()
		local l = B.rare.Label
		emit({ xs = { x(B.target), x(B.rare), x(B.item), x(B.hearth), x(B.bag) }, rare = { l:IsShown(), select(4, l:GetPoint(1)), l:GetWidth() },
			target = B.target.Label:IsShown(), level = B.bag:GetFrameLevel() > F:GetFrameLevel() })
	"#);
	assert_eq!(out["xs"], json!([0, 42, 204, 246, 288]), "{out}");
	assert_eq!(out["rare"], json!([true, 84, 204 - 6 - 84]), "the rare's name takes the slot, up to the quest item's gap");
	assert_eq!(out["target"], false, "the target's name gives way while a rare is up");
	assert_eq!(out["level"], true, "the row draws over the window, which takes neither its clicks nor its hover");
}

// The bag's "press again" right-aligned against the right end; the names give way while it shows, then come back.
#[test]
fn docked_an_armed_bag_s_press_again_takes_the_names_place_and_gives_it_back() {
	let out = run(r#"
		kobolds()
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		B.bag:Show()
		B.bag.Label:SetText("Press again to delete")
		stub.runTimers()
		local bl = B.bag.Label
		local armed = { bag = bl:IsShown(), side = (bl:GetPoint(1)), justify = bl:GetJustifyH(), target = B.target.Label:IsShown() }
		B.bag.Label:SetText("")
		B.bag:Hide()
		stub.runTimers()
		emit({ armed = armed, back = B.target.Label:IsShown(), bag = bl:IsShown() })
	"#);
	assert_eq!(out["armed"], json!({ "bag": true, "side": "RIGHT", "justify": "RIGHT", "target": false }), "{out}");
	assert_eq!(out["back"], true);
	assert_eq!(out["bag"], false);
}

// A fight holds the row where it is (its frames are protected); it follows the window once the fight ends.
#[test]
fn docked_in_a_fight_the_row_does_not_move_it_follows_the_window_once_the_fight_ends() {
	let out = run(r#"
		kobolds()
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		F.x = 500
		Polestar.Fire("GUIDE_WINDOW_PLACED", true)
		stub.runTimers()
		local during = holderAt()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.runTimers()
		emit({ during = during, after = holderAt() })
	"#);
	assert_eq!(out["during"], json!([108, 308]), "{out}");
	assert_eq!(out["after"], json!([508, 308]));
}

// A drag on a docked button moves nothing (the window carries the row), and the tooltips stop saying "drag".
#[test]
fn docked_a_drag_moves_nothing_and_the_tooltip_says_no_drag() {
	let out = run(r#"
		kobolds()
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		local before = holderAt()
		stub.RunScript(B.target, "OnMouseDown", "LeftButton")
		stub.RunScript(B.target, "OnDragStart")
		stub.RunScript(B.target, "OnDragStop")
		stub.runTimers()
		stub.RunScript(B.target, "OnEnter")
		local lines = GameTooltip.lines
		stub.RunScript(B.target, "OnLeave")
		emit({ before = before, after = holderAt(), lines = lines })
	"#);
	assert_eq!(out["before"], out["after"], "{out}");
	let lines: Vec<&str> = out["lines"].as_array().unwrap().iter().filter_map(|l| l.as_str()).collect();
	assert!(lines.contains(&"Click again for the next name."), "{out}");
	assert!(!lines.iter().any(|l| l.contains("drag")), "{out}");
}

// With the single button: the goal it takes next wears its crosshair in place of the verb's glyph; a click on to
// the next name moves the crosshair to that name's goal. Floating, no row wears it.
#[test]
fn docked_the_goal_the_target_button_takes_next_wears_its_crosshair_and_it_follows_the_next_name() {
	let out = run(r#"
		-- The plain macros: a press's mark would re-apply them itself. Young Wolf
		-- drops the collect goal's meat.
		Polestar.Set("qol.markTarget", false)
		uistub.guides[uistub.elwynn].steps[3].goals[4].fromNpcs = { { npc = 299, npcName = "Young Wolf" } }
		kobolds()
		local floating = aims()
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		local first = { aims(), B.target.applied }
		stub.RunScript(B.target, "PostClick", "LeftButton", false)
		stub.runTimers()
		local second = { aims(), B.target.applied }
		Polestar.Set("qol.buttonDock", false)
		stub.runTimers()
		emit({ floating = floating, first = first, second = second, off = aims() })
	"#);
	assert!(empty(&out["floating"]), "{out}");
	assert_eq!(out["first"][1], "Kobold Vermin");
	assert_eq!(out["first"][0].as_array().unwrap().len(), 1, "{out}");
	assert!(out["first"][0][0][0].as_str().unwrap().contains("Kobold Vermin"), "{out}");
	assert_eq!(out["first"][0][0][1], true, "the crosshair stands in for the verb's glyph");
	assert_eq!(out["second"][1], "Young Wolf");
	assert!(out["second"][0][0][0].as_str().unwrap().contains("Tough Wolf Meat"), "{out}");
	assert!(empty(&out["off"]), "floating again, the glyphs come back: {out}");
}

// Beside the target list (the default), the Polestar mark takes the target button's slot, the rows hang under the
// row outside the window, and no goal wears the crosshair: the rows show who.
#[test]
fn docked_beside_the_list_the_mark_takes_the_slot_and_the_rows_hang_under_the_window() {
	let out = run(r#"
		kobolds(false)
		Polestar.Set("buttons.listUp", true)
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		local r1 = B.rows[1]
		local p, rel, rp, rx, ry = r1:GetPoint(1)
		emit({ target = B.target:IsShown(), mark = B.anchor:IsShown(), markLevel = B.anchor:GetFrameLevel() > F:GetFrameLevel(),
			row = { r1:IsShown(), p, rel == B.target, rp, rx, ry }, aims = aims(), strip = F.psDock })
	"#);
	assert_eq!(out["target"], false, "{out}");
	assert_eq!(out["mark"], true);
	assert_eq!(out["markLevel"], true);
	assert_eq!(out["row"], json!([true, "TOPLEFT", true, "BOTTOMLEFT", 0, -8]), "under the target slot, downward even with the list set to go up");
	assert!(empty(&out["aims"]), "{out}");
	assert_eq!(n(&out["strip"]), 52.0);
}

// A window that measured its strip before the row settled (a button shown later, a fight in between) lays out
// again when the row is placed.
#[test]
fn docked_a_window_that_measured_its_strip_too_short_lays_out_again_when_the_row_is_placed() {
	let out = run(r#"
		kobolds()
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		local good = F:GetHeight()
		F.psDock = 0
		F:SetHeight(good - 52)
		Polestar.Fire("GUIDE_WINDOW_PLACED")
		stub.runTimers()
		emit({ good = good, after = F:GetHeight(), dock = F.psDock })
	"#);
	assert_eq!(out["after"], out["good"], "{out}");
	assert_eq!(n(&out["dock"]), 52.0);
}

// The window hidden: the set floats at its saved spot; shown again, it docks.
#[test]
fn docked_with_the_window_hidden_the_set_floats_and_docks_again_when_it_shows() {
	let out = run(r#"
		kobolds()
		Polestar.Set("qol.buttonDock", true)
		stub.runTimers()
		F:Hide()
		Polestar.Fire("GUIDE_WINDOW_PLACED")
		stub.runTimers()
		local hidden = { B.Docked(), (B.target:GetPoint(1)) }
		F:Show()
		Polestar.Fire("GUIDE_WINDOW_PLACED")
		stub.runTimers()
		emit({ hidden = hidden, shown = { B.Docked(), (B.target:GetPoint(1)) } })
	"#);
	assert_eq!(out["hidden"], json!([false, "CENTER"]), "{out}");
	assert_eq!(out["shown"], json!([true, "BOTTOMLEFT"]));
}
