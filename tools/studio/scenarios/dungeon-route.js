'use strict';
// Dungeons in the route, in every skin at the game's UI scales 0.64, 1.0 and 1.5: the guide window's question
// at a dungeon not answered yet (Ask me), the start-looking line a few steps before a chosen dungeon's run with Find
// a group (the game's Group Finder), the door (solo: I'm in a group / Skip this one; in a party: the run, Skip this
// one), the quests kept in the log after it, the party's offer when a party member runs a dungeon this character
// skips (Party.DungeonOffer: Run it this time / Not now), what turning dungeons on or off says at once (the next
// dungeon near or far off; the dungeon quests still in the log), Dungeons on your way (the guide window's menu
// entry and its popover), the dungeon card's Add to my route; the settings window on Guide > Automation (Dungeons
// in my route) and on Discovery > Dungeons (an answer per dungeon). A Tauren Hunter at 18 on the shipped Barrens
// guide, Wailing Caverns ahead. The game's UI scale is UIParent's: everything under it is drawn at that scale, as in
// the client.
//
// Shots: <skin>-<scale>-<surface> (studio dungeon-route/polestar-064-ask ...), scale 064, 100 or 150; surface
// ask, soon, nogroup, doorparty, kept, party, changed, far, off, menu, popover, card, automation, discovery. The
// skins and their loading are the skins scenario's.

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
// DungeonRun, DungeonsAhead, DungeonQuestsInLog; the notice Skip this one leaves). Wailing Caverns' real quests on
// this guide; the levels and places about where the Horde route has them.
const AHEAD = `local E = Polestar.Engine
E.GuideDungeons = function() return { [43] = true, [2999] = true, [33] = true } end
E.DungeonsAhead = function()
	local function a(map) return E.DungeonAnswer(map) end
	return {
		{ map = 43, name = "Wailing Caverns", level = 19.4, runMap = 1413, pickMap = 1413, pickMaps = { 1413, 1456 }, picks = 7, inLog = 0, here = true, answer = a(43),
			wayOnly = E.DungeonWayOnly(43), allQuests = { minutes = 14, xp = 23100 } },
		{ map = 2999, name = "Ruins of Lordaeron", level = 23.6, runMap = 1420, pickMap = 1421, pickMaps = { 1421, 1420 }, picks = 4, inLog = 0, here = false, answer = a(2999),
			wayOnly = E.DungeonWayOnly(2999) },
		{ map = 33, name = "Shadowfang Keep", level = 24.8, runMap = 1421, pickMap = 1424, pickMaps = { 1424 }, picks = 3, inLog = 0, here = false, answer = a(33),
			wayOnly = E.DungeonWayOnly(33), allQuests = { minutes = 9, xp = 11800 } },
	}
end`;
const BANNER = {
	ask: `local E = Polestar.Engine
E.DungeonQuestion = function() return { map = 43, name = "Wailing Caverns", quests = 3, runIn = 5 } end`,
	soon: `LFGMicroButton = LFGMicroButton or CreateFrame("Button", "LFGMicroButton", UIParent)
local E = Polestar.Engine
E.DungeonSoon = function() return { map = 43, name = "Wailing Caverns", steps = 3 } end`,
	nogroup: `local E = Polestar.Engine
E.DungeonRun = function() return { map = 43, name = "Wailing Caverns" } end`,
	doorparty: `IsInGroup = function() return true end
GetNumSubgroupMembers = function() return 2 end
local E = Polestar.Engine
E.DungeonRun = function() return { map = 43, name = "Wailing Caverns" } end`,
	kept: `Polestar.UI.GuideFrame.notices.dungeonKept = { map = 43, kept = {
	{ quest = 1486, title = "Deviate Hides", ready = true }, { quest = 1491, title = "Smart Drinks", ready = false }, { quest = 959, title = "Trouble at the Docks", ready = false } } }`,
	party: `Polestar.Party.DungeonOffer = function() return { map = 43, name = "Wailing Caverns", names = { "Ana" } } end`,
	changed: `${AHEAD}
Polestar.Set("behavior.dungeons", "run")`,
	far: `local E = Polestar.Engine
E.DungeonsAhead = function() return { { map = 209, name = "Zul'Farrak", level = 46.2, runMap = 1446, pickMap = 1444, pickMaps = { 1444, 1446 }, picks = 5, inLog = 0, here = false, answer = true } } end
Polestar.Set("behavior.dungeons", "run")`,
	off: `${AHEAD}
local E = Polestar.Engine
Polestar.Set("behavior.dungeons", "run")
E.DungeonQuestsInLog = function() return { { quest = 959, title = "Trouble at the Docks", ready = true }, { quest = 1491, title = "Smart Drinks", ready = false } } end
Polestar.Set("behavior.dungeons", "skip")`,
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

const LAYOUT = 'Polestar.UI.GuideFrame.Layout()';
const SURFACES = {
	ask: { capture: ['PolestarGuideFrame'], lua: `${BANNER.ask}\n${LAYOUT}` },
	soon: { capture: ['PolestarGuideFrame'], lua: `${BANNER.soon}\n${LAYOUT}` },
	nogroup: { capture: ['PolestarGuideFrame'], lua: `${BANNER.nogroup}\n${LAYOUT}` },
	doorparty: { capture: ['PolestarGuideFrame'], lua: `${BANNER.doorparty}\n${LAYOUT}` },
	kept: { capture: ['PolestarGuideFrame'], lua: `${BANNER.kept}\n${LAYOUT}` },
	party: { capture: ['PolestarGuideFrame'], lua: `${BANNER.party}\n${LAYOUT}` },
	changed: { capture: ['PolestarGuideFrame'], lua: `${BANNER.changed}\n${LAYOUT}` },
	far: { capture: ['PolestarGuideFrame'], lua: `${BANNER.far}\n${LAYOUT}` },
	off: { capture: ['PolestarGuideFrame'], lua: `${BANNER.off}\n${LAYOUT}` },
	// The guide window's menu, Dungeons on your way just before Quick settings.
	menu: { capture: ['PolestarGuideFrame', 'PolestarMenu'], lua: `${AHEAD}
local GF = Polestar.UI.GuideFrame
GF.OpenMenu(GF.menuButton)` },
	// Dungeons on your way: Run them for every dungeon, Shadowfang Keep switched off.
	popover: { capture: ['PolestarGuideFrame', 'PolestarDungeonRoute'], lua: `${AHEAD}
Polestar.Set("behavior.dungeons", "run")
Polestar.CharState().dungeons[33] = false
local GF = Polestar.UI.GuideFrame
GF.DismissBanner()
Polestar.UI.DungeonRoute.Show(GF.menuButton)` },
	// The dungeon card at 20 for a dungeon the route can still take: Add to my route.
	card: { capture: ['PolestarGuideFrame', 'PolestarClassToast'], lua: `${AHEAD}
stub.world.setLevel(20)
stub.advance(1)
do local CT = Polestar.UI.ClassToast if CT and CT.current then CT.Hide() end end
local DT = Polestar.UI.DungeonToast
local c
for _, x in ipairs(DT.Candidates(20, "any")) do if x.key == "wailing-caverns" then c = x end end
assert(c, "no Wailing Caverns card")
DT.Show(c)
stub.advance(1)
${LAYOUT}` },
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
	title: 'Dungeons in the route: the guide window\'s dungeon notices, Dungeons on your way, the card and the settings, in every skin at UI scales 0.64, 1.0 and 1.5',
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
