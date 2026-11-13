'use strict';
// The settings search's dropdown (Polestar_Options/UI/SearchDropdown.lua) in
// every look at the game's UI scales 0.64, 1.0 and 1.5: the settings window
// on its Guide page with "arrow" typed in the header's box (the Arrow page,
// its sections and the best settings, the second row lit by the Down key),
// and with a query nothing matches ("hearthston xyzzy": the nearest settings
// offered) at 1.0. The looks are the built-in six and the skin addons in the
// download (skins.js's list, without its variants), each picked as skins.js
// picks it. Shots: <look>-<scale> and <look>-nomatch (studio
// settings-search/hearth-0.64 ...); the close-up is the dropdown and its box.
//
// The UI scale: UIParent at that scale, its size in UI units the screen's
// 1920 x 1080 over it, as the client has it (the settings window keeps its
// size in screen pixels; its text grows and shrinks with the scale).

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const SCALES = ['0.64', '1.0', '1.5'];

const luaStr = (s) => JSON.stringify(String(s));

function search(scale, query, downs) {
	return `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end
-- The window alone: the arrow and the guide window stay out of its frame.
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.UI.ShowOptions("guide")
stub.advance(1)
local box = PolestarOptions.Search
box:SetFocus()
box:SetText(${luaStr(query)})
stub.RunScript(box, "OnTextChanged", true)
for _ = 1, ${downs} do stub.RunScript(box, "OnArrowPressed", "DOWN") end
stub.advance(0.5)
local rows = {}
for i, r in ipairs(Polestar.UI.Options.Dropdown.Rows()) do rows[i] = r.kind .. ": " .. (r.label or "") end
return rows`;
}

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-${scale}`] = { title: `${name} at UI scale ${scale}: "arrow" typed, the second row lit`, lua: `${base}\n${search(scale, 'arrow', 2)}` };
	}
	shots[`${name}-nomatch`] = { title: `${name}: a query nothing matches, the nearest settings offered`, lua: `${base}\n${search('1.0', 'hearthston xyzzy', 0)}` };
}

module.exports = {
	title: 'The settings search\'s dropdown in every look at UI scales 0.64, 1.0 and 1.5',
	character: skins.character,
	place: skins.place,
	settings: {},
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarOptionsMatches'],
	pad: 72,
	LOOKS,
	shots,
};
