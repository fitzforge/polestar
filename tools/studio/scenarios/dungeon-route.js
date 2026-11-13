'use strict';
// Dungeons in the route, in every skin at the game's UI scales 0.64, 1.0 and 1.5: the guide window's question
// at a dungeon not answered yet (Ask me), the start-looking line a few steps before a chosen dungeon's run, "No
// group? Skip it" at the run, the quests kept in the log after it; the settings window on Guide > Automation (Dungeons
// in my route) and on Discovery > Dungeons (an answer per dungeon). A Tauren Hunter
// at 18 on the shipped Barrens guide, Wailing Caverns ahead. The game's UI scale is UIParent's: everything under
// it is drawn at that scale, as in the client.
//
// Shots: <skin>-<scale>-<surface> (studio dungeon-route/polestar-064-ask ...), scale 064, 100 or 150; surface
// ask, soon, nogroup, kept, automation, discovery. The skins and their loading are the skins scenario's.

const skins = require('./skins');

const { SKINS } = skins;
const luaStr = (s) => JSON.stringify(String(s));
const SCALES = { '064': 0.64, 100: 1, 150: 1.5 };

// The game's UI scale s on a 1920 x 1080 screen: UIParent drawn at s and 1920/s x 1080/s units big, as the client
// has it; the guide window at the same place on screen at every scale (its saved place is in UI units), room
// for it at 1.5.
const SCALE = (s) => `local s = ${s}
UIParent:SetScale(s)
function UIParent:GetWidth() return 1920 / s end
function UIParent:GetHeight() return 1080 / s end
Polestar.Set("ui.pos", { 1300 / s, 900 / s })`;

// The skin set up as the skins scenario sets it (its pick: the skin addon loaded, the skin and variant chosen,
// the settings window's addon loaded, the skin's layout preset applied). Halo, a built-in look the skins
// scenario has no shots of, is set up as its Forever shot with Halo's id.
function pick(name) {
	if (name === 'halo') return skins.shots['forever-guide'].lua.split('"forever"').join('"halo"');
	return skins.shots[`${name}-guide`].lua;
}
const LOOKS = ['polestar', 'halo', ...Object.keys(SKINS).filter((n) => n !== 'polestar')];

// What the engine says about the dungeon, for the guide window's banner (Engine.DungeonQuestion, DungeonSoon,
// DungeonRun; the notice SkipDungeon leaves). Wailing Caverns' real quests on this guide.
const BANNER = {
	ask: `local E = Polestar.Engine
E.DungeonQuestion = function() return { map = 43, name = "Wailing Caverns", quests = 3, runIn = 5 } end`,
	soon: `local E = Polestar.Engine
E.DungeonSoon = function() return { map = 43, name = "Wailing Caverns", steps = 3 } end`,
	nogroup: `local E = Polestar.Engine
E.DungeonRun = function() return { map = 43, name = "Wailing Caverns" } end`,
	kept: `Polestar.UI.GuideFrame.notices.dungeonKept = { map = 43, titles = { "Deviate Hides", "Smart Drinks", "Serpentbloom" } }`,
};

// The settings window alone, on a page and tab; a few dungeons answered one by one.
const SETTINGS = (page, tab) => `if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.Set("behavior.dungeons", "ask")
local s = Polestar.CharState()
s.dungeons[43] = true
s.dungeons[389] = false
Polestar.UI.ShowOptions(${luaStr(page)})
stub.advance(0.5)
${tab ? `Polestar.UI.Options.Select(${luaStr(page)}, ${luaStr(tab)})` : ''}
stub.advance(1)`;

const SURFACES = {
	ask: { capture: ['PolestarGuideFrame'], lua: `${BANNER.ask}\nPolestar.UI.GuideFrame.Layout()` },
	soon: { capture: ['PolestarGuideFrame'], lua: `${BANNER.soon}\nPolestar.UI.GuideFrame.Layout()` },
	nogroup: { capture: ['PolestarGuideFrame'], lua: `${BANNER.nogroup}\nPolestar.UI.GuideFrame.Layout()` },
	kept: { capture: ['PolestarGuideFrame'], lua: `${BANNER.kept}\nPolestar.UI.GuideFrame.Layout()` },
	automation: { capture: ['PolestarOptions'], lua: SETTINGS('guide', 'Automation') },
	discovery: { capture: ['PolestarOptions'], lua: SETTINGS('dungeons') },
};

const shots = {};
for (const name of LOOKS) {
	const base = pick(name);
	for (const [sk, scale] of Object.entries(SCALES)) {
		for (const [surface, s] of Object.entries(SURFACES)) {
			shots[`${name}-${sk}-${surface}`] = {
				title: `${name} at UI scale ${scale}: ${surface}`,
				capture: s.capture,
				pad: 16,
				lua: `${SCALE(scale)}\n${base}\n${s.lua}\nstub.advance(0.5)`,
			};
		}
	}
}

module.exports = {
	title: 'Dungeons in the route: the guide window\'s dungeon notices and the settings, in every skin at UI scales 0.64, 1.0 and 1.5',
	character: skins.character,
	place: skins.place,
	guide: { id: 'forever/horde/02-the-barrens', step: 40 },
	settings: {},
	window: skins.window,
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	shots,
};
