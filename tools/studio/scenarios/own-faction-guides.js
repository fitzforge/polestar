'use strict';
// The character's own side's guides only (#2462): a level 22 Human Warrior in
// Lakeshire. The guide menu on Class, the Warrior folder open: the Alliance
// armor chain (Fire Hardened Armor) and the Warrior's other chains, never the
// Horde's Brutal Armor, with no faction filter on the tab row; in the
// default look and the game's (Blizzard) at UI scale 1.0. Then the Horde
// chain opened anyway (a tab saved before the change brings the Horde part
// in): the guide window's banner says whose guide it is and the arrow is off.
// Each shot returns what it showed.

const skins = require('./skins');

const MENU = `local P = Polestar.UI.Picker
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.UI.ShowPicker()
stub.advance(0.5)
P.SetView("browse")
P.SetCategory("Class")
for _, e in ipairs(P.Entries("", "Class")) do
	if e.kind == "folder" then P.SetCollapsed(e.id, e.text ~= "Warrior") end
end
P.Select("forever/class/warrior/fire-hardened-armor")
P.Render()
stub.advance(0.5)
local out = {}
for _, e in ipairs(P.Entries("", "Class")) do
	if e.kind == "guide" and e.folder.text == "Warrior" then out[#out + 1] = e.title end
end
return "Warrior: " .. table.concat(out, ", ") .. " || filter: " .. tostring(PolestarPicker.factionButtons ~= nil)`;

// The Horde part in, as an old saved tab of the Horde chain brings it; the chain loaded.
const WARNING = `for _, f in ipairs({ "Alliance", "Horde" }) do Polestar.Data.Pack("Polestar_Guides_" .. f) end
Polestar.Fire("GUIDES_REGISTERED")
stub.advance(0.5)
local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
E.SetGuide("forever/class/warrior/brutal-armor")
stub.advance(1)
GF.Layout()
stub.advance(0.5)
local B = GF.parts.banner
return { side = tostring(E.OtherFaction("forever/class/warrior/brutal-armor")), arrow = tostring(E.GetWaypoint() ~= nil),
	banner = B:IsShown() and B.Text:GetText() or "NO banner" }`;

const shots = {};
for (const look of ['polestar', 'blizzard']) {
	const base = skins.pick(look, null);
	shots[`menu-class-${look}`] = { title: `${look} at UI scale 1.0: the guide menu's Class list, the Warrior folder: the Alliance chains only`, lua: `${base}\n${MENU}`, capture: ['PolestarPicker'] };
	shots[`warning-${look}`] = { title: `${look} at UI scale 1.0: the Horde chain opened anyway: the banner says whose it is, no arrow`, lua: `${base}\n${WARNING}`, capture: ['PolestarGuideFrame'] };
}

module.exports = {
	title: "The guide menu lists the character's own side only; another side's guide says so (#2462)",
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 22, money: 9000 },
	place: { map: 1433, x: 26.7, y: 44.5, zone: 'Redridge Mountains', subzone: 'Lakeshire' },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: [1440, 690],
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarPicker', 'PolestarGuideFrame'],
	shots,
};
