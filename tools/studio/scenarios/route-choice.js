'use strict';
// Choose your path (UI/RouteChoice.lua) in every look at the game's UI scales
// 0.64, 1.0 and 1.5. A level 46 Orc Hunter who finished Feralas picks Tanaris
// (recommended) or the detour through Desolace into Shen'dralas, one of
// Polestar's experimental guides in a zone whose quests are mostly Forever's
// own (the Forever mark after its name, its "New in Forever" chip), which
// comes back to Tanaris: the header says so. At 1.0 also the Badlands at
// level 40: Stranglethorn Vale or the experimental Riverglades, both meeting
// again in Feralas, which the header says. Each choice is given as
// Engine.GetRouteChoice builds it from the guides and the experimental
// guides' index (their pitches, pros and cons, levels and zones): the
// studio's session offers no choice there.
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
			pitch: "Gadgetzan's camps, Tooga's escort, then Thorium Point.",
			pros: ['Thorium Point on the way', 'Then on to the Hinterlands', 'Stays on the main route'], cons: ['Long runs across the desert'],
			thenId: 'forever/horde/40-50/05-the-hinterlands', thenGuideTitle: 'The Hinterlands & Blasted Lands', thenLevel: 48 },
		{ id: 'polestar-experimental/shendralas', title: "Shen'dralas", zoneName: "Shen'dralas", minLevel: 42, maxLevel: 44,
			seconds: 780, quests: 11, zone: 2652, focusX: 21.2, focusY: 22.4, experimental: true, newInForever: true, outleveled: true, detour: 'Desolace',
			pitch: 'A fallen Highborne temple south of Desolace.',
			pros: ['About 27,500 quest experience', 'Then back to the main route', 'Less grinding before level 50'],
			cons: ['Level 45 elites in the Valley of Bones'],
			thenId: 'forever/horde/40-50/04-tanaris', thenGuideTitle: TANARIS, thenLevel: 44 },
	],
};
const BADLANDS = {
	from: 'forever/horde/30-40/06-badlands', fromTitle: 'Badlands', recommended: 'forever/horde/40-50/01-stranglethorn-vale', joinsAt: 'Feralas & Tanaris',
	options: [
		{ id: 'forever/horde/40-50/01-stranglethorn-vale', title: 'Stranglethorn Vale & Swamp of Sorrows', zoneName: 'Stranglethorn Vale', minLevel: 39, maxLevel: 43,
			recommended: true, seconds: 600, quests: 41, zone: 1434, focusX: 32.5, focusY: 29.0,
			pitch: "Nesingwary's hunts and Booty Bay's pirates, then Stonard.",
			pros: ['Riding and level 40 training first', 'Stonard flight path for later', 'Stays on the main route'],
			cons: ['Spread over two zones, lots of travel'],
			thenId: 'forever/horde/40-50/02-feralas', thenGuideTitle: 'Feralas & Tanaris', thenLevel: 43 },
		{ id: 'polestar-experimental/riverglades-horde-1', title: 'Riverglades', zoneName: 'Riverglades',
			minLevel: 40, maxLevel: 43, seconds: 1500, quests: 70, zone: 2548, focusX: 77.1, focusY: 52.9, experimental: true, newInForever: true,
			pitch: 'A new Forever zone south of the Badlands.',
			pros: ['One zone instead of two', 'Ride straight in from Kargath', "Rog'mar: flight path and inn"],
			cons: ['New guide: steps may still change'],
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
