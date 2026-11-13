'use strict';
// Install (UI/Welcome.lua): every page in every look at the game's UI scales
// 0.64, 1.0 and 1.5, on a new Human Warrior at Northshire Abbey with no guide
// open yet. The pages are the welcome, Questing (quest automation, grey
// quests, the guide at login, the stat weights), Targeting (the target
// button's preview, the button, who it targets, its mark and ping), Groups
// and dungeons (group quests), Your route (the route demo, the
// route style, the route line), Your look (the looks beside the preview, the
// colour scheme) and the last page (You're all set, Start guide and Finish).
// The looks are the built-in six and the skin addons in the download
// (skins.js's list, without its variants), each picked as skins.js picks it.
// Shots: <look>-<page>-<scale> (studio install/hearth-look-1.5 ...), and at
// 1.0 <look>-groups-dungeons (with "Dungeons in my route", which shows once
// the route has dungeons and its setting) and <look>-look-gamepad (the
// gamepad's button names, shown while a gamepad is in use).
//
// The UI scale: UIParent at that scale, its size in UI units the screen's
// 1920 x 1080 over it, as the client has it.

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const PAGES = ['welcome', 'questing', 'targeting', 'groups', 'route', 'look', 'finish'];
const SCALES = ['0.64', '1.0', '1.5'];

const luaStr = (s) => JSON.stringify(String(s));

// The page opened at UI scale `scale`, after `before` (Lua) has run.
function page(scale, key, before = '') {
	return `local s = ${scale}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end
-- The window alone: the arrow and the guide window stay out of its frame.
Polestar.Set("nav.arrow", false)
if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
${before}
Polestar.UI.Welcome.Show(${luaStr(key)})
stub.advance(1)
local key, at, count, title = Polestar.UI.Welcome.Page()
return { key = key, step = at .. " of " .. count, title = title, height = PolestarWelcome:GetHeight(), scale = PolestarWelcome:GetScale() }`;
}

// The route with dungeons, and their setting, as the route lane brings them.
const DUNGEONS = `if Polestar.GetDefault("behavior.dungeons") == nil then Polestar.RegisterDefaults("behavior", { dungeons = "skip" }) end
local E = Polestar.Engine
local had = E.GuideDungeons and E.GuideDungeons() or {}
if next(had) == nil then E.GuideDungeons = function() return { [1581] = true } end end`;

// A gamepad in use (Forever's gamepad interface or a pad with the mouse interface).
const GAMEPAD = 'Polestar.Gamepad.IsActive = function() return true end';

// Every skin addon in the download loaded, as an installed client has them,
// so the look page lists them all (Theme.SkinChoices).
const ALL_SKINS = [...new Set(Object.values(LOOKS).map((l) => l[1]).filter(Boolean))].map((f) => skins.loadSkin(f)).join('\n');

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	for (const key of PAGES) {
		for (const scale of SCALES) {
			shots[`${name}-${key}-${scale}`] = { title: `${name}: Install's ${key} page at UI scale ${scale}`, lua: `${base}\n${page(scale, key, key === 'look' ? ALL_SKINS : '')}` };
		}
	}
	shots[`${name}-groups-dungeons`] = { title: `${name}: Groups and dungeons with "Dungeons in my route"`, lua: `${base}\n${page('1.0', 'groups', DUNGEONS)}` };
	shots[`${name}-look-gamepad`] = { title: `${name}: Your look with the gamepad's button names`, lua: `${base}\n${page('1.0', 'look', `${ALL_SKINS}\n${GAMEPAD}`)}` };
}

module.exports = {
	title: 'Install: every page in every look at UI scales 0.64, 1.0 and 1.5',
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 1, money: 0 },
	place: { map: 1429, x: 48.2, y: 42.3, zone: 'Elwynn Forest', subzone: 'Northshire Abbey' },
	settings: {},
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarWelcome'],
	pad: 40,
	LOOKS,
	PAGES,
	SCALES,
	shots,
};
