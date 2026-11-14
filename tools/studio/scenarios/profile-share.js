'use strict';
// The Profiles page's Share tab (Polestar_Options/UI/Profiles.lua) in every
// look at the game's UI scales 0.64, 1.0 and 1.5. Make a string: the
// checklist of categories (every one ticked but Window positions, and the
// line saying why), the Guide window's list open under its row, and the
// string made: a long one, scrolling in its well three lines tall. Import: a
// pasted string's checklist, Window positions unticked as it was made on
// another screen, the Guide window's list open (yours, then theirs). The
// profile in use has settings off their defaults in every category but the
// skin; the string is a friend's, written here. The looks are the built-in
// six and the skin addons in the download (skins.js's list, without its
// variants), each picked as skins.js picks it. Shots: <look>-export-<scale>
// and <look>-import-<scale> (studio profile-share/hearth-import-0.64 ...);
// the close-up is the settings window.
//
// The UI scale: UIParent at that scale, its size in UI units the screen's
// 1920 x 1080 over it, as the client has it (the settings window keeps its
// size in screen pixels; its text grows and shrinks with the scale).

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const SCALES = ['0.64', '1.0', '1.5'];

// Settings of the profile in use, off their defaults in every category but
// the skin (the look is the shot's), enough for a string longer than its
// well at every scale.
const MINE = `local set = Polestar.Set
set("ui.textSize", 1.1)
set("ui.compact", true)
set("ui.width", 380)
set("guideWindow.titleSize", 1.15)
set("nav.arrowScale", 1.2)
set("nav.worldPins", false)
set("maps.coords", false)
set("nav.lineWidth", 5)
set("nav.travel", false)
set("trackers.flight.scale", 1.1)
set("behavior.autoAccept", false)
set("behavior.autoTurnin", false)
set("behavior.skipGrey", true)
set("party.chat", false)
set("rares.alerts", false)
set("qol.xpTracker", false)
set("toasts.rare.scale", 1.2)
set("gear.minUpgrade", 4)
set("qol.sellJunk", false)
set("lookup.tooltip", false)
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

// The Share tab's two states, once it shows. export: the Guide window's list
// open and the string made, the page scrolled so the string's well and its
// line stand at the foot of the view. import: a friend's string pasted, the
// Guide window's changes open, the page scrolled to the Import card. The
// skin audit's Share surfaces (tools/preview/audit.js) run them too.
const STATES = {
	export: `local PV = Polestar.UI.Profiles
PV.Open("export", "window")
PV.Export()
stub.advance(0.3)
local v, sf = PV.views[Polestar.L["Share"]], PolestarOptions.Scroll
Polestar.Widgets.ScrollTo(sf, math.max(0, (v.psCopyTop or 0) + v.CopyWell:GetHeight() + 60 - sf:GetHeight()))`,
	import: `local PV = Polestar.UI.Profiles
local text = Polestar.Profiles.Pack(${luaStr(FRIEND)})
PV.Check(text)
PV.Open("import", "window")
stub.advance(0.3)
local v = PV.views[Polestar.L["Share"]]
-- The box as a paste leaves it: the string's start and its size.
v.PasteBox:SetText(text:sub(1, 40) .. "\\226\\128\\166 (" .. math.ceil(#text / 1024) .. " KB)")
Polestar.Widgets.ScrollTo(PolestarOptions.Scroll, math.max(0, (v.ImportCard.psTop or 0) - 16))`,
};

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
Polestar.UI.Options.Select("profiles", Polestar.L["Share"])
stub.advance(0.5)
${STATES[part]}
stub.advance(0.5)
return Polestar.UI.Profiles.Shown()`;
}

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-export-${scale}`] = { title: `${name} at UI scale ${scale}: Make a string, the Guide window's list open, a long string made`, lua: `${base}\n${share(scale, 'export')}` };
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
	STATES,
	shots,
};
