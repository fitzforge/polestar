'use strict';
// Every skin on the surfaces a skin has to carry: the guide window on a
// step, a heads-up card over it (a class quest's, else a dungeon's), a toast
// (the rare alert), the waypoint arrow, the world map's route and step pins,
// and the settings window on its Theme page. A Tauren Hunter
// at 18 on the shipped Barrens guide, played 40 steps (to the coast south of
// Ratchet).
//
// Built-in skins are set by id; a skin addon (addon/Polestar_Skin_<Name>) is
// loaded after Polestar from the checkout being rendered (--checkout), the
// way the client loads an addon that depends on Polestar, then picked. The
// skin's own layout preset is applied, as a player who accepted "Apply
// <skin>'s layout" has it. Shots: <skin>-guide, <skin>-cards, <skin>-toast,
// <skin>-arrow, <skin>-map, <skin>-settings (studio skins/<skin>-guide ...).

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
	hairline: ['hairline', 'Polestar_Skin_Hairline'],
	umbra: ['umbra', 'Polestar_Skin_Umbra'],
	'umbra-forever': ['umbra', 'Polestar_Skin_Umbra', 'forever'],
	'umbra-classic': ['umbra', 'Polestar_Skin_Umbra', 'classic'],
	waymark: ['waymark', 'Polestar_Skin_Waymark'],
	lanterns: ['lanterns', 'Polestar_Skin_Lanterns'],
	'lanterns-tidepool': ['lanterns', 'Polestar_Skin_Lanterns', 'tidepool'],
	'lanterns-plain': ['lanterns', 'Polestar_Skin_Lanterns', 'plain'],
	sheen: ['sheen', 'Polestar_Skin_Sheen'],
};

const luaStr = (s) => JSON.stringify(String(s));

// The Lua that loads an addon's TOC files in order, as the client does,
// once, its files sharing the addon's namespace: the addon is marked loaded
// (C_AddOns.IsAddOnLoaded), so Polestar's own load-on-demand request for it
// (C_AddOns.LoadAddOn) finds it there.
function loadAddon(folder) {
	const dir = path.join(ADDONS, folder);
	const toc = path.join(dir, `${folder}.toc`);
	if (!fs.existsSync(toc)) return `error(${luaStr(`no ${folder} in ${ADDONS}`)})`;
	const files = fs.readFileSync(toc, 'utf8').split(/\r?\n/).map((l) => l.trim()).filter((l) => l && !l.startsWith('#'));
	return `stub.addonsLoaded = stub.addonsLoaded or {}
if not stub.addonsLoaded[${luaStr(folder)}] then
stub.addonsLoaded[${luaStr(folder)}] = true
local ns = {}
${files.map((f) => `assert(loadfile(${luaStr(path.join(dir, f.replace(/\\/g, '/')))}))(${luaStr(folder)}, ns)`).join('\n')}
end`;
}

// A skin addon, after the Skin API's checks (Polestar_SkinAPI, the part
// Polestar loads on demand for a registering skin) where the checkout has
// them.
function loadSkin(folder) {
	const api = fs.existsSync(path.join(ADDONS, 'Polestar_SkinAPI', 'Polestar_SkinAPI.toc')) ? `${loadAddon('Polestar_SkinAPI')}\n` : '';
	return `${api}${loadAddon(folder)}`;
}

// The settings window's addon (Polestar_Options, loaded on demand; the
// studio's session loads Polestar and the guides only), loaded once as the
// client would on Polestar's request. It also holds the skin presets.
const OPTIONS = `if not (Polestar.UI and Polestar.UI.Options) then
${loadAddon('Polestar_Options')}
end`;

function pick(id, folder, variant) {
	return `${folder ? loadSkin(folder) : ''}
local Theme = Polestar.Theme
${variant ? `Polestar.Set(${luaStr(`ui.skinVariants.${id}`)}, ${luaStr(variant)})` : ''}
Polestar.Set("ui.skin", ${luaStr(id)})
stub.advance(0.5)
assert(Theme.SkinId() == ${luaStr(id)}, "skin not in use: " .. tostring(Theme.SkinId()))
${OPTIONS}
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

// A toast over the world: the rare alert, a rare on the minimap at its
// distance (Rares/Toast.lua, PolestarRareToast).
const TOAST = `local a = Polestar.Rares.AlertOf({ source = "vignette", kind = "rare", id = 5865, name = "Dishu", level = 13 }, { map = 1413, x = 49.6, y = 29.6 }, true)
a.yards = 87
if PolestarNavArrow then PolestarNavArrow:Hide() end
Polestar.Fire("RARE_SPOTTED", a)
stub.advance(4)`;

// The settings window on its Theme page, where the skin and its variants
// are picked.
const SETTINGS = `${OPTIONS}
-- The window alone: the arrow and the guide window stay out of its frame.
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.UI.ShowOptions("theme")
stub.advance(1)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(SKINS)) {
	const base = pick(id, folder, variant);
	shots[`${name}-guide`] = { title: `${name}: the guide window on a field step`, lua: base };
	shots[`${name}-cards`] = { title: `${name}: a heads-up card over the guide window`, capture: ['PolestarGuideFrame', 'PolestarClassToast'], lua: `${base}\n${CARDS}` };
	shots[`${name}-arrow`] = { title: `${name}: the waypoint arrow`, capture: ['PolestarNavArrow'], pad: 40, lua: base };
	shots[`${name}-toast`] = { title: `${name}: the rare alert toast`, capture: ['PolestarRareToast'], pad: 40, lua: `${base}\n${TOAST}` };
	shots[`${name}-settings`] = { title: `${name}: the settings window on its Theme page`, capture: ['PolestarOptions'], lua: `${base}\n${SETTINGS}` };
	shots[`${name}-map`] = { title: `${name}: the route and the step pins on the world map`, capture: ['StudioPinZone'], pad: 0, lua: `${base}\n${MAP}` };
}

module.exports = {
	title: 'Skins: the guide window, the cards, the arrow and the map pins in every skin',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 18, money: 4200 },
	place: { map: 1413, x: 50.2, y: 27.0, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 39, hours: 1 },
	settings: {},
	window: [1440, 690],
	// The client's map tree (the studio's maps carry no parent): a skin that
	// reads the continent (Waymark, the Skin API's resolve context) sees
	// Kalimdor here.
	stubs: [path.join(__dirname, '..', 'continents.lua')],
	// Waymark's pictures: the continents' loading screens, Forever's and the
	// older ones (the local art cache only; never in the repository).
	art: [7963776, 7963779, 131839, 131848],
	capture: ['PolestarGuideFrame'],
	SKINS,
	pick,
	shots,
};
