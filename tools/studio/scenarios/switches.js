'use strict';
// The settings window's switches (Theme/Widgets.lua W.Toggle, W.Switch) in
// every look at the game's UI scales 0.64, 1.0 and 1.5: a page of its own
// ("Switches") whose first card holds one row per state, on and off: at
// rest, under the cursor, held down, with the gamepad's focus, and turned
// off by the setting they hang on (disabled); the second card a section's
// on/off in its header and a switch beside a slider (W.Switch). The house
// look is also shot in each colour scheme at 1.0. The looks are the
// built-in six and the skin addons in the download (skins.js's list,
// without its variants), each picked as skins.js picks it. Shots:
// <look>-<scale> and polestar-<scheme> (studio switches/hearth-0.64 ...).
// What a shot returns is the first card's box in screen pixels (x, y, w, h,
// the second card included), for close-ups cut from the 1x render.

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const SCALES = ['0.64', '1.0', '1.5'];
const SCHEMES = ['dusk', 'night', 'graphite'];

const PAGE = `Polestar.RegisterDefaults("studio", { on = true, off = false, hoverOn = true, hoverOff = false, pressOn = true, focusOff = false,
	disabledOn = true, disabledOff = false, section = true, size = 1, extra = true, child = false })
local off = function() return true end
Polestar.RegisterOptions({ page = "Switches", key = "switches", icon = "qol-toggles", order = 5, tab = "States", section = "Every state", controls = {
	{ kind = "toggle", key = "studio.on", label = "On" },
	{ kind = "toggle", key = "studio.off", label = "Off" },
	{ kind = "toggle", key = "studio.hoverOn", label = "Hover, on" },
	{ kind = "toggle", key = "studio.hoverOff", label = "Hover, off" },
	{ kind = "toggle", key = "studio.pressOn", label = "Pressed, on" },
	{ kind = "toggle", key = "studio.focusOff", label = "Gamepad focus, off" },
	{ kind = "toggle", key = "studio.disabledOn", label = "Disabled, on", disabled = off },
	{ kind = "toggle", key = "studio.disabledOff", label = "Disabled, off", disabled = off },
} })
Polestar.RegisterOptions({ page = "Switches", tab = "States", section = "Header switch",
	toggle = { kind = "toggle", key = "studio.section", label = "Header switch" },
	controls = {
		{ kind = "slider", key = "studio.size", label = "Size", min = 0.5, max = 2, step = 0.05, format = "%.2f",
			extras = { { kind = "toggle", key = "studio.extra", label = "Glow" } } },
		{ kind = "toggle", key = "studio.child", label = "Child, off" },
	} })`;

function shot(scale) {
	return `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
${PAGE}
local UI = Polestar.UI
UI.ShowOptions("switches")
stub.advance(1)
local O = UI.Options
local rows = O.Controls("switches")
local function run(key, script, ...)
	local r = rows[key]
	local fn = r and r:GetScript(script)
	if fn then fn(r, ...) end
end
run("studio.hoverOn", "OnEnter")
run("studio.hoverOff", "OnEnter")
run("studio.pressOn", "OnMouseDown", "LeftButton")
local focused = rows["studio.focusOff"]
if focused and focused.psOnPadFocus then focused:psOnPadFocus(true) end
stub.advance(0.5)
-- The rows' tooltips out of the picture (the cursor stays on them).
for _, key in ipairs({ "studio.hoverOn", "studio.hoverOff" }) do
	if rows[key] then Polestar.Widgets.HideTooltip(rows[key]); Polestar.Widgets.TipHide(rows[key]) end
end
if GameTooltip then GameTooltip:Hide() end
-- The rows' box on the screen (y down), the cards' headers above them inside the margin the cut adds.
local x0, y0, x1, y1 = math.huge, math.huge, -math.huge, -math.huge
for _, r in pairs(rows) do
	if r.IsShown and r:IsShown() and r:GetLeft() then
		local e = r:GetEffectiveScale()
		x0, x1 = math.min(x0, r:GetLeft() * e), math.max(x1, r:GetRight() * e)
		y0, y1 = math.min(y0, 1080 - r:GetTop() * e), math.max(y1, 1080 - r:GetBottom() * e)
	end
end
return { x = x0, y = y0, w = x1 - x0, h = y1 - y0 }`;
}

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-${scale}`] = { title: `${name} at UI scale ${scale}: every switch state`, lua: `${base}\n${shot(scale)}` };
	}
}
for (const scheme of SCHEMES) {
	shots[`polestar-${scheme}`] = {
		title: `The house look in ${scheme} at UI scale 1.0: every switch state`,
		lua: `${skins.pick('polestar', null)}\nPolestar.Set("ui.scheme", "${scheme}")\nstub.advance(0.5)\n${shot('1.0')}`,
	};
}

module.exports = {
	title: 'The settings window\'s switches in every state and look at UI scales 0.64, 1.0 and 1.5',
	character: skins.character,
	place: skins.place,
	settings: {},
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarOptions'],
	pad: 0,
	LOOKS,
	shots,
};
