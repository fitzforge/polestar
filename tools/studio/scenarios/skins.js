'use strict';
// Every skin on the surfaces a skin has to carry: the guide window on a
// step, a heads-up card over it (a class quest's, else a dungeon's), the
// waypoint arrow, and the world map's route and step pins. A Tauren Hunter
// at 18 on the shipped Barrens guide, played 40 steps (to the coast south of
// Ratchet).
//
// Built-in skins are set by id; a skin addon (addon/Polestar_Skin_<Name>) is
// loaded after Polestar from the checkout being rendered (--checkout), the
// way the client loads an addon that depends on Polestar, then picked. The
// skin's own layout preset is applied, as a player who accepted "Apply
// <skin>'s layout" has it. Shots: <skin>-guide, <skin>-cards, <skin>-arrow,
// <skin>-map (studio skins/<skin>-guide ...).

const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('../../lib/paths');

const ADDONS = process.env.POLESTAR_ADDON_DIR || path.join(ROOT, 'addon');

// shot name -> [skin id, addon folder (null: built in), variant (nil: the
// skin's default)]: the built-in skins and the skin addons in the download.
const SKINS = {
	polestar: ['polestar', null],
	forever: ['forever', null],
	blizzard: ['blizzard', null],
	classic: ['classic', null],
	hearth: ['hearth', null],
	vellum: ['vellum', 'Polestar_Skin_Vellum'],
	lumen: ['lumen', 'Polestar_Skin_Lumen'],
	beacon: ['beacon', 'Polestar_Skin_Beacon'],
	aurora: ['aurora', 'Polestar_Skin_Aurora'],
};

const luaStr = (s) => JSON.stringify(String(s));

// The Lua that loads a skin addon's TOC files in order, as the client does.
function loadAddon(folder) {
	const dir = path.join(ADDONS, folder);
	const toc = path.join(dir, `${folder}.toc`);
	if (!fs.existsSync(toc)) return `error(${luaStr(`no ${folder} in ${ADDONS}`)})`;
	const files = fs.readFileSync(toc, 'utf8').split(/\r?\n/).map((l) => l.trim()).filter((l) => l && !l.startsWith('#'));
	return files.map((f) => `assert(loadfile(${luaStr(path.join(dir, f.replace(/\\/g, '/')))}))(${luaStr(folder)}, {})`).join('\n');
}

function pick(id, folder, variant) {
	return `${folder ? loadAddon(folder) : ''}
local Theme = Polestar.Theme
${variant ? `Polestar.Set(${luaStr(`ui.skinVariants.${id}`)}, ${luaStr(variant)})` : ''}
Polestar.Set("ui.skin", ${luaStr(id)})
stub.advance(0.5)
assert(Theme.SkinId() == ${luaStr(id)}, "skin not in use: " .. tostring(Theme.SkinId()))
if Theme.ApplySkinPreset then Theme.ApplySkinPreset(${luaStr(id)}) end
stub.advance(0.5)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;
}
// The cards: a class quest's heads-up (UI/ClassToast.lua) over the guide
// window, else the dungeon heads-up (UI/DungeonToast.lua).
const CARDS = `local CT, DT = Polestar.UI.ClassToast, Polestar.UI.DungeonToast
local shown = false
local q = CT and CT.Candidates and CT.Candidates(stub.world.level, "any")
if q and q[1] then shown = CT.Show(q[1]) end
if not shown and DT and DT.Candidates then
	local c = DT.Candidates(stub.world.level, "any")
	if c[1] then shown = DT.Show(c[1]) end
end
assert(shown, "no card to show")
stub.advance(1)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// The world map, and a 520 x 340 zone of it round the character (where
// the step's pins are) named for the close-up.
const MAP = `play.openMap()
stub.advance(1)
local canvas = WorldMapFrame:GetCanvas()
local zone = CreateFrame("Frame", "StudioPinZone", canvas)
zone:SetSize(520, 340)
local w = stub.world
zone:SetPoint("CENTER", canvas, "TOPLEFT", w.x / 100 * canvas:GetWidth(), -w.y / 100 * canvas:GetHeight())
zone:Show()
stub.advance(0.2)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(SKINS)) {
	const base = pick(id, folder, variant);
	shots[`${name}-guide`] = { title: `${name}: the guide window on a field step`, lua: base };
	shots[`${name}-cards`] = { title: `${name}: a heads-up card over the guide window`, capture: ['PolestarGuideFrame', 'PolestarClassToast'], lua: `${base}\n${CARDS}` };
	shots[`${name}-arrow`] = { title: `${name}: the waypoint arrow`, capture: ['PolestarNavArrow'], pad: 40, lua: base };
	shots[`${name}-map`] = { title: `${name}: the route and the step pins on the world map`, capture: ['StudioPinZone'], pad: 0, lua: `${base}\n${MAP}` };
}

module.exports = {
	title: 'Skins: the guide window, the cards, the arrow and the map pins in every skin',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 18, money: 4200 },
	place: { map: 1413, x: 50.2, y: 27.0, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 39, hours: 1 },
	settings: {},
	window: [1440, 690],
	capture: ['PolestarGuideFrame'],
	SKINS,
	shots,
};
