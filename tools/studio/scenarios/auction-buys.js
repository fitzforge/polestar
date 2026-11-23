'use strict';
// Auction house buys (Quests/AuctionBuys.lua, UI/AuctionBuys.lua) in every
// look at the game's UI scales 0.64, 1.0 and 1.5: the guide's card when the
// guide opens ("Auction house buys for this guide"), the reminder at
// Orgrimmar's auction house ("N quest items to buy in Orgrimmar", Show me the
// auctioneer) and the list window (the guide window's menu, /polestar ah).
// An Orc Warrior at 37 on the shipped Whirlwind Weapon guide, whose cauldron
// takes eight of each exile's charm: a long farm no vendor serves.
// The looks are the built-in six and the skin addons in the download
// (skins.js's list, without its variants), each picked as skins.js picks it.
// Shots: <look>-<surface>-<scale> (studio auction-buys/hearth-town-0.64 ...),
// surface guide | town | list; `probe` lists what some shipped guides ask
// for at their start (its result, printed).
//
// The UI scale: UIParent at that scale, its size in UI units the screen's
// 1920 x 1080 over it, as the client has it.

const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('../../lib/paths');
const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const SCALES = ['0.64', '1.0', '1.5'];
const GUIDE = 'forever/class/warrior/whirlwind-weapon';

// The items the probe's guides collect (the client data the studio loads for
// them: a name, an icon, how it binds), read from their sources.
const PROBED = [
	GUIDE,
	'forever/horde/40-50/04-tanaris',
	'forever/horde/40-50/05-the-hinterlands',
	'forever/alliance/02-westfall',
	'forever/alliance/40-50/06-searing-gorge',
	'forever/class/warrior/brutal-armor',
	'forever/class/mage/spellfire-robes',
	'forever/collectibles/mounts/neutral/warlock-dreadsteed',
];
function collected(ids) {
	const out = new Set();
	for (const id of ids) {
		const file = path.join(ROOT, 'guides', `${id}.guide`);
		if (!fs.existsSync(file)) continue;
		for (const m of fs.readFileSync(file, 'utf8').matchAll(/^\s*(?:collect|buy)\s+(\d+)/gm)) out.add(Number(m[1]));
	}
	return [...out];
}

const SCALE = (scale) => `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end`;

// The guide's card: the guide opened afresh (told once per guide), past its catch-up.
const GUIDE_CARD = `Polestar.CharState().auctionGuides = {}
studio.clearHeadsUps()
Polestar.UI.AuctionBuys.CheckGuide(${JSON.stringify(GUIDE)})
stub.advance(1)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local m = Polestar.UI.ClassToast.current
return m and m.giver`;

// The reminder: at Orgrimmar's auction house, resting, a new visit.
const TOWN_CARD = `local w = stub.world
w.resting = true
w.moveTo(1454, 54.6, 65.2)
play.syncZone()
w.zone, w.subzone = "Orgrimmar", "The Drag"
Polestar.CharState().auctionVisit = nil
studio.clearHeadsUps()
Polestar.UI.AuctionBuys.CheckTown()
stub.advance(1)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)
local m = Polestar.UI.ClassToast.current
return m and m.title`;

// The list window, from the guide window's menu.
const LIST = `studio.clearHeadsUps()
if PolestarNavArrow then PolestarNavArrow:Hide() end
local item = Polestar.UI.AuctionBuys.MenuItem()
if item then item.onClick() end
stub.advance(1)
return item and item.text`;

const PROBE = `local out = {}
for _, id in ipairs(${JSON.stringify(PROBED).replace(/^\[/, '{').replace(/\]$/, '}')}) do
	Polestar.Engine.SetGuide(id)
	stub.advance(4)
	local list, pending = Polestar.AuctionBuys.List("guide")
	local names = {}
	for i, e in ipairs(list) do
		names[i] = e.need .. " " .. e.name .. " (" .. e.why .. (e.kills and (" " .. e.kills) or "") .. ") for " .. e.quests[1].title
	end
	out[#out + 1] = id .. ": " .. (#names > 0 and table.concat(names, "; ") or "nothing") .. (pending and " (pending)" or "")
end
return out`;

const shots = { probe: { title: 'What some shipped guides ask the auction house for at their start', lua: PROBE } };
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const scale of SCALES) {
		shots[`${name}-guide-${scale}`] = { title: `${name} at UI scale ${scale}: the guide's card`, capture: ['PolestarGuideFrame', 'PolestarClassToast'], lua: `${base}\n${SCALE(scale)}\n${GUIDE_CARD}` };
		shots[`${name}-town-${scale}`] = { title: `${name} at UI scale ${scale}: the reminder at Orgrimmar's auction house`, capture: ['PolestarGuideFrame', 'PolestarClassToast'], lua: `${base}\n${SCALE(scale)}\n${TOWN_CARD}` };
		shots[`${name}-list-${scale}`] = { title: `${name} at UI scale ${scale}: the list window`, capture: ['PolestarAuctionBuys'], lua: `${base}\n${SCALE(scale)}\n${LIST}` };
	}
}

module.exports = {
	title: 'Auction house buys: the guide\'s card, the reminder in town and the list, in every look at UI scales 0.64, 1.0 and 1.5',
	character: { race: 'Orc', cls: 'WARRIOR', faction: 'Horde', level: 37, money: 250000 },
	place: { map: 1454, x: 48.2, y: 78.4, zone: 'Orgrimmar', subzone: 'Valley of Strength' },
	guide: { id: GUIDE, play: 2 },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	data: { items: collected(PROBED) },
	// skins.js's: the client's map tree (a skin may read the continent) and Waymark's pictures.
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame', 'PolestarClassToast'],
	LOOKS,
	shots,
};
