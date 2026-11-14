'use strict';
// The Profiles page's Share tab (Polestar_Options/UI/Profiles.lua) in every
// look at the game's UI scales 0.64, 1.0 and 1.5. Make a string: the
// checklist of categories (every one ticked but Window positions, and the
// line saying why), the Guide window's list open under its row, the string
// made. Import: a pasted string's checklist, Window positions unticked as it
// was made on another screen, the Guide window's list open (yours, then
// theirs). The profile in use has settings off their defaults in most
// categories; the string is a friend's, written here. The looks are the
// built-in six and the skin addons in the download (skins.js's list,
// without its variants), each picked as skins.js picks it. Shots:
// <look>-export-<scale> and <look>-import-<scale> (studio
// profile-share/hearth-import-0.64 ...); the close-up is the settings window.
//
// The UI scale: UIParent at that scale, its size in UI units the screen's
// 1920 x 1080 over it, as the client has it (the settings window keeps its
// size in screen pixels; its text grows and shrinks with the scale).

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const SCALES = ['0.64', '1.0', '1.5'];

// Settings of the profile in use, off their defaults in most categories
// (never the skin: the look is the shot's). The skin audit's Share surfaces
// (tools/preview/audit.js) use these and FRIEND too.
const MINE = `local set = Polestar.Set
set("ui.textSize", 1.1)
set("ui.compact", true)
set("ui.width", 380)
set("guideWindow.titleSize", 1.15)
set("nav.arrowScale", 1.2)
set("nav.lineWidth", 5)
set("behavior.autoAccept", false)
set("gear.minUpgrade", 4)
set("ui.pos", { 1400, 860 })`;

// A friend's string: the skin, the fonts, the guide window, the routes and
// the positions, made on a 2560 x 1440 screen.
const FRIEND = JSON.stringify({
	format: 1, name: 'Mira', categories: ['skin', 'fonts', 'window', 'routes', 'positions'],
	screen: { w: 2560, h: 1440, scale: 0.9 }, migrations: [],
	settings: {
		'ui.accent': [0.55, 0.75, 1], 'ui.textSize': 1.2, 'ui.compact': false, 'ui.width': 420, 'ui.upcoming': 4,
		'guideWindow.titleSize': 1.3, 'nav.lineWidth': 6, 'nav.travel': false, 'ui.pos': [300, 500],
	},
});

const luaStr = (s) => JSON.stringify(String(s));

function share(scale, part) {
	return `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end
-- The window alone: the arrow and the guide window stay out of its frame.
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
${MINE}
Polestar.UI.ShowOptions("profiles")
stub.advance(1)
local O, PV = Polestar.UI.Options, Polestar.UI.Profiles
O.Select("profiles", Polestar.L["Share"])
stub.advance(0.5)
${part === 'export' ? `PV.Open("export", "window")
PV.Export()` : `PV.Check(Polestar.Profiles.Pack(${luaStr(FRIEND)}))
PV.Open("import", "window")
stub.advance(0.3)
local v = PV.views[Polestar.L["Share"]]
Polestar.Widgets.ScrollTo(PolestarOptions.Scroll, math.max(0, (v.ImportCard.psTop or 0) - 16))`}
stub.advance(0.5)
return PV.Shown()`;
}

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-export-${scale}`] = { title: `${name} at UI scale ${scale}: Make a string, the Guide window's list open`, lua: `${base}\n${share(scale, 'export')}` };
		shots[`${name}-import-${scale}`] = { title: `${name} at UI scale ${scale}: a friend's string pasted, the Guide window's changes open`, lua: `${base}\n${share(scale, 'import')}` };
	}
}

module.exports = {
	title: 'The Share tab of the Profiles page (make a string, import one) in every look at UI scales 0.64, 1.0 and 1.5',
	character: skins.character,
	place: skins.place,
	settings: {},
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarOptions'],
	pad: 24,
	LOOKS,
	MINE,
	FRIEND,
	shots,
};
