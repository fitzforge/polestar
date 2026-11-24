//! What sits over what on the screen (#2753): the guide window (UI/GuideFrame.lua) whole over the game's action
//! bars, the target list's rows and mark (QoL/Buttons.lua) whole over the window, and the tooltip over all. The
//! window and the rows share the MEDIUM strata with the bars, so the order is the frame levels: in 0.4.0.1 a row
//! at UIParent's level drew its backing under the window and its model and count over it.
//!
//! The stub keeps a frame's level as set; the client's rules are modelled here (warcraft.wiki.gg, Frame:Raise and
//! Frame:SetFrameLevel): a frame made on a parent sits one level over it and follows it when the parent's level
//! changes, Raise puts a frame one level over the highest in its strata, and Raise on a secure frame in combat is
//! refused. The game's bars are made before the addon loads, as the client's are. The QoL harness's secure frames
//! (tests/lua/stub_qol.lua) refuse protected calls in combat.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const MODS: [&str; 4] = ["Core/Core.xml", "Theme/Theme.xml", "QoL/QoL.xml", "UI/UI.xml"];

const CLIENT: &str = r#"
local M = stub.Methods
local function strataOf(o)
	while o do
		local s = rawget(o, "strata")
		if s then return s end
		o = o:GetParent()
	end
	return "MEDIUM"
end
local function levelOf(o)
	local l = rawget(o, "level")
	if l then return l end
	local p = o:GetParent()
	return p and levelOf(p) + 1 or 0
end
local function within(o, anc)
	while o do
		if o == anc then return true end
		o = o:GetParent()
	end
	return false
end
layers = { strataOf = strataOf, levelOf = levelOf, within = within, refused = {} }
M.GetFrameLevel = levelOf
function M.SetFrameLevel(self, l)
	local d = l - levelOf(self)
	for _, o in ipairs(stub.frames) do
		if o ~= self and rawget(o, "level") and within(o, self) then o.level = o.level + d end
	end
	self.level = l
end
function M.Raise(self)
	if self.secure and stub.inCombat then
		table.insert(layers.refused, tostring(self:GetName()))
		return
	end
	local s, top = strataOf(self), 0
	for _, o in ipairs(stub.frames) do
		if not within(o, self) and strataOf(o) == s then top = math.max(top, levelOf(o)) end
	end
	M.SetFrameLevel(self, top + 1)
end
GameTooltip:SetFrameStrata("TOOLTIP")

-- The game's bars: the main bar's art frame and its buttons, and the bar over it at its own level.
local main = CreateFrame("Frame", "MainMenuBar", UIParent)
local art = CreateFrame("Frame", "MainMenuBarArtFrame", main)
local left = CreateFrame("Frame", "MultiBarBottomLeft", UIParent)
left:SetFrameLevel(3)
for i = 1, 12 do
	CreateFrame("CheckButton", "ActionButton" .. i, art, "SecureActionButtonTemplate")
	CreateFrame("CheckButton", "MultiBarBottomLeftButton" .. i, left, "SecureActionButtonTemplate")
end
"#;

const HELPERS: &str = r#"
local B = Polestar.QoL.Buttons
local L = layers
-- The lowest and highest level, and the strata, of the frames under each root.
local function span(roots)
	local lo, hi, strata = math.huge, -math.huge, {}
	for _, o in ipairs(stub.frames) do
		for _, r in ipairs(roots) do
			if L.within(o, r) then
				local l = L.levelOf(o)
				lo, hi = math.min(lo, l), math.max(hi, l)
				strata[L.strataOf(o)] = true
			end
		end
	end
	local list = {}
	for s in pairs(strata) do list[#list + 1] = s end
	table.sort(list)
	return { lo = lo, hi = hi, strata = table.concat(list, ",") }
end
local function bars() return { MainMenuBar, MultiBarBottomLeft } end
local function list()
	local roots = { B.anchor }
	for _, r in ipairs(B.rows) do roots[#roots + 1] = r end
	return roots
end
-- Each layer, bottom to top, and whether each sits whole over the one under it.
function order()
	local b, w, t = span(bars()), span({ PolestarGuideFrame }), span(list())
	return { bars = b.strata, window = w.strata, list = t.strata, windowOverBars = w.lo > b.hi, listOverWindow = t.lo > w.hi,
		rows = #B.rows, listShown = B.anchor:IsShown() }
end
"#;

fn run(stubs: Vec<&'static str>, script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs, before: CLIENT.into(), addons: vec![Addon::files("Polestar", &MODS)], script: format!("uistub.install()\nstub.login()\n{HELPERS}\n{script}"), ..Default::default() })
}

#[test]
fn the_window_sits_whole_over_the_action_bars_and_the_target_list_whole_over_the_window() {
	let out = run(
		vec!["stub_ui.lua"],
		r#"
		uistub.setGuide(uistub.elwynn, 3)
		stub.runTimers()
		emit(order())
		-- The window grows parts after the list was made (another step, the step list opened): still under it.
		uistub.setGuide(uistub.elwynn, 4)
		stub.runTimers()
		uistub.setGuide(uistub.elwynn, 3)
		stub.runTimers()
		emit(order())
		-- A row's tooltip: the game's, over everything.
		local r = B.rows[1]
		r:GetScript("OnEnter")(r)
		emit({ GameTooltip:IsShown(), GameTooltip:GetOwner() == r, GameTooltip:GetFrameStrata() })
	"#,
	);
	let whole = json!({ "bars": "MEDIUM", "window": "MEDIUM", "list": "MEDIUM", "windowOverBars": true, "listOverWindow": true, "rows": 1, "listShown": true });
	assert_eq!(out[0], whole, "the bars, then the window, then the list: none drawn between another's parts");
	assert_eq!(out[1]["windowOverBars"], true, "{:?}", out[1]);
	assert_eq!(out[1]["listOverWindow"], true, "parts the window makes later stay under the list: {:?}", out[1]);
	assert_eq!(out[2], json!([true, true, "TOOLTIP"]));
}

#[test]
fn a_target_list_that_changes_in_a_fight_raises_no_secure_row_until_it_ends() {
	let out = run(
		vec!["stub_ui.lua", "stub_qol.lua"],
		r#"
		uistub.setGuide(uistub.elwynn, 3)
		stub.runTimers()
		local before = #B.rows
		stub.qol.combat(true)
		-- Two more names while the fight goes on: rows for them are made after it.
		local g = uistub.goal(3, 4)
		g.source = nil
		uistub.goal(3, 3).subject = "Kobold Worker"
		g.subject, g.subjectKind, g.verb, g.t, g.npc = "Kobold Laborer", "npc", "Kill", "kill", 80
		uistub.update()
		stub.runTimers()
		emit({ before = before, inFight = #B.rows, refused = table.concat(layers.refused, ",") })
		stub.qol.combat(false)
		stub.runTimers()
		emit({ after = #B.rows, refused = table.concat(layers.refused, ","), order = order() })
	"#,
	);
	assert_eq!(out[0]["refused"], "", "no Raise on a secure row in the fight");
	assert_eq!(out[0]["inFight"], out[0]["before"], "no row made in the fight");
	assert_eq!(out[1]["refused"], "");
	assert!(out[1]["after"].as_u64().unwrap() > out[0]["before"].as_u64().unwrap(), "the new rows come after the fight: {out:?}");
	assert_eq!(out[1]["order"]["listOverWindow"], true, "{out:?}");
	assert_eq!(out[1]["order"]["windowOverBars"], true, "{out:?}");
}
