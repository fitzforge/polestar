'use strict';
// Choose your path (UI/RouteChoice.lua) in every look at the game's UI scales
// 0.64, 1.0 and 1.5. A level 46 Orc Hunter who finished Feralas picks Tanaris
// (recommended) or the detour through Desolace into Shen'dralas, one of
// Polestar's experimental guides in a zone whose quests are mostly Forever's
// own (its ∞ pennant): the routes go on to different guides, so each card
// says which ("Then:"). At 1.0 also the Badlands at level 40: Stranglethorn
// Vale or the experimental Riverglades, both meeting again in Feralas, which
// the header says. Each choice is given as Engine.GetRouteChoice builds it
// from the guides and the experimental guides' index (their pitches, pros
// and cons, levels and zones): the studio's session offers no choice there.
// The looks are the built-in six and the skin addons in the download with
// the variants skins.js shows (Umbra on WoW Forever and Classic, Lanterns'
// Tidepool and Plain), each picked as skins.js picks it. Shots:
// <look>-<scale> and <look>-badlands-1.0 (studio route-choice/hearth-0.64 ...).
//
// The UI scale: UIParent at that scale, its size in UI units the screen's
// 1920 x 1080 over it, as the client has it.

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null], ...skins.SKINS };

const SCALES = ['0.64', '1.0', '1.5'];

const SCALE = (scale) => `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end`;

function lua(v) {
	if (v === null || v === undefined) return 'nil';
	if (typeof v === 'number' || typeof v === 'boolean') return String(v);
	if (typeof v === 'string') return JSON.stringify(v);
	if (Array.isArray(v)) return `{ ${v.map(lua).join(', ')} }`;
	return `{ ${Object.entries(v).map(([k, x]) => `${k} = ${lua(x)}`).join(', ')} }`;
}

const TANARIS = 'Tanaris & Searing Gorge';
const FERALAS = {
	from: 'forever/horde/40-50/03-feralas', fromTitle: 'Feralas', recommended: 'forever/horde/40-50/04-tanaris',
	options: [
		{ id: 'forever/horde/40-50/04-tanaris', title: TANARIS, zoneName: 'Tanaris', minLevel: 46, maxLevel: 48, recommended: true,
			seconds: 300, quests: 28, zone: 1446, focusX: 52.0, focusY: 28.4,
			pitch: "Gadgetzan and the Searing Gorge at 46-48: the Wastewander camps, Tooga's escort and Thorium Point.",
			thenId: 'forever/horde/40-50/05-the-hinterlands', thenGuideTitle: 'The Hinterlands & Blasted Lands', thenLevel: 48 },
		{ id: 'polestar-experimental/shendralas', title: "Shen'dralas (experimental)", zoneName: "Shen'dralas", minLevel: 42, maxLevel: 44,
			seconds: 780, quests: 11, zone: 2652, focusX: 21.2, focusY: 22.4, experimental: true, newInForever: true, outleveled: true, detour: 'Desolace',
			pitch: "A detour south of Desolace into Shen'dralas: 11 quests around a fallen Highborne temple, for levels 41-45.",
			pros: ['About 27,500 quest experience plus the kills', 'Brings you back to the main route where you left it',
				'Its experience comes off the grinding the route asks for before level 50: about an hour sooner to 60'],
			cons: ['Its quests are about on level at 43 and a few levels under you at 46', 'Elites walk the Valley of Bones: Corpsefeeders and Magram Necrokhans, level 45',
				"Experimental: written from a handful of players' recordings"],
			thenId: 'forever/horde/40-50/04-tanaris', thenGuideTitle: TANARIS, thenLevel: 44 },
	],
};
const BADLANDS = {
	from: 'forever/horde/30-40/06-badlands', fromTitle: 'Badlands', recommended: 'forever/horde/40-50/01-stranglethorn-vale', joinsAt: 'Feralas & Tanaris',
	options: [
		{ id: 'forever/horde/40-50/01-stranglethorn-vale', title: 'Stranglethorn Vale & Swamp of Sorrows', zoneName: 'Stranglethorn Vale', minLevel: 39, maxLevel: 43,
			recommended: true, seconds: 600, quests: 41, zone: 1434, focusX: 32.5, focusY: 29.0,
			pitch: "Stranglethorn Vale and the Swamp of Sorrows at 40-43: Grom'gol, Booty Bay's pirates, Nesingwary's hunts and Stonard.",
			thenId: 'forever/horde/40-50/02-feralas', thenGuideTitle: 'Feralas & Tanaris', thenLevel: 43 },
		{ id: 'polestar-experimental/riverglades-horde-1', title: "Riverglades 1: Powderfuse Port, Rog'mar and the western farms (experimental)", zoneName: 'Riverglades',
			minLevel: 37, maxLevel: 43, seconds: 1500, quests: 70, zone: 2548, focusX: 77.1, focusY: 52.9, experimental: true, newInForever: true,
			pitch: "Forever's new zone south of the Badlands: the Horde fort of Rog'mar and about 70 quests from level 40, then back to Kargath for Feralas.",
			pros: ['Reaches level 60 about 40 minutes sooner than the Stranglethorn Vale route',
				'Replaces Stranglethorn Vale and the Swamp of Sorrows with one zone and one hub',
				"You ride in from Kargath through the Badlands' southern edge, and come back out at Kargath for Feralas & Tanaris"],
			cons: ["Experimental: written from players' recordings and not yet checked end to end in the game",
				"Skips Stranglethorn Vale and the Swamp of Sorrows: their quests left in your log can be abandoned, and Stonard's flight path waits until later",
				'Its later quests are for levels 43-45, a few levels above you when you reach them: pull carefully',
				'Elite camps, and a few quests that need a group (each behind a group choice)'],
			thenId: 'forever/horde/40-50/02-feralas', thenGuideTitle: 'Feralas & Tanaris', thenLevel: 43 },
	],
};

// Choice `c` shown alone (the arrow and the guide window stay out of its frame).
const SHOW = (c) => `local E = Polestar.Engine
E.GetRouteChoice = function() return ${lua(c)} end
E.PendingRouteChoice = function() return ${JSON.stringify(c.from)} end
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.UI.ShowRouteChoice(${JSON.stringify(c.from)})
stub.advance(0.5)
return PolestarRouteChoice and PolestarRouteChoice:IsShown() and PolestarRouteChoice.Subtitle:GetText()`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-${scale}`] = { title: `${name} at UI scale ${scale}: Tanaris or Shen'dralas after Feralas`, lua: `${base}\n${SCALE(scale)}\n${SHOW(FERALAS)}` };
	}
	shots[`${name}-badlands-1.0`] = { title: `${name} at UI scale 1.0: Stranglethorn Vale or Riverglades after the Badlands`, lua: `${base}\n${SCALE('1.0')}\n${SHOW(BADLANDS)}` };
}

module.exports = {
	title: 'Choose your path: Tanaris or the Shen\'dralas detour after Feralas, and Stranglethorn Vale or Riverglades after the Badlands, in every look at UI scales 0.64, 1.0 and 1.5',
	character: { race: 'Orc', cls: 'HUNTER', faction: 'Horde', level: 46, money: 412000 },
	place: { map: 1444, x: 74.8, y: 45.0, zone: 'Feralas', subzone: 'Camp Mojache' },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false, 'nav.arrow': false },
	window: [1440, 690],
	// skins.js's: the client's map tree (a skin may read the continent) and Waymark's pictures.
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarRouteChoice'],
	LOOKS,
	shots,
};
