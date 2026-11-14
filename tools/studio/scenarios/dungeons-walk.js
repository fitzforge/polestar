'use strict';
// Turning dungeons on, walked as a player on the shipped Horde route (#2026): a Tauren Hunter on the Barrens
// guide, played to level 18 (the simulator's steps), then each moment of "Dungeons in my route" with the real
// engine, nothing stubbed: where the switch is (the guide window's menu, the settings), the window right after
// it is turned on mid-guide (at 18 here, at 26, 34 and 42 on the guides the route has there), the first
// pick-up, the start-looking line, the door, Skip this one and what it leaves in the log, turning it off
// with dungeon quests in the log, Ask me's question, and the dungeon heads-up card. Shots: <moment> (studio
// dungeons-walk/on-18 ...). The guides must be compiled with their dungeon steps (forge guide compile; render
// with --checkout pointing at an addon folder that holds them).

const skins = require('./skins');

const luaStr = (s) => JSON.stringify(String(s));

// The heads-up cards a level-up brings (a class quest's) put away; the guide window's banners stay
// (studio.clearHeadsUps would dismiss them too).
const CARDS_AWAY = `do local CT = Polestar.UI.ClassToast if CT and CT.current then CT.Hide() end end
stub.advance(0.5)`;

// Play the live guide until `cond` (a Lua expression) holds, or `limit` steps; a stuck step is passed with Next.
const UNTIL = (cond, limit = 300) => `local E = Polestar.Engine
for _ = 1, ${limit} do
	if ${cond} then break end
	local r = play.playStep()
	if r == "noguide" then break elseif r == "stuck" then E.Next(); stub.advance(0.6) end
end
stub.advance(0.5)
${CARDS_AWAY}`;

// The live step is a pick-up of a dungeon (`when dungeon` with an accept).
const PICKUP = `(function()
	local g, i = E.GetGuide(), E.GetLiveStep()
	local st = g and i and g.steps[i]
	if not st then return false end
	local dungeon = false
	for _, p in ipairs(st.when or {}) do if p.k == "dungeon" and not p.neg then dungeon = true end end
	if not dungeon then return false end
	for _, goal in ipairs(st.goals) do if goal.t == "accept" then return true end end
	return false
end)()`;

// Turn "Dungeons in my route" to `v` as the settings window does, and draw the window after it.
const SET = (v) => `Polestar.Set("behavior.dungeons", ${luaStr(v)})
stub.advance(1)
${CARDS_AWAY}
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// Another guide of the route at `level`, played `steps` steps (the e2e gate's switch points).
const AT = (id, level, steps) => `local w = stub.world
w.setLevel(${level})
Polestar.Engine.SetGuide(${luaStr(id)})
stub.advance(1)
for _ = 1, ${steps} do
	local r = play.playStep()
	if r == "noguide" then break elseif r == "stuck" then Polestar.Engine.Next(); stub.advance(0.6) end
end
w.level = ${level}
stub.advance(1)
${CARDS_AWAY}`;

const RUN_ON = `${SET('run')}`;

const shots = {
	// Where the switch is: the guide window's menu (what a player opens first), then the settings.
	menu: { title: 'The guide window\'s menu: where a player looks first', capture: ['PolestarGuideFrame', 'PolestarMenu'], lua: `local GF = Polestar.UI.GuideFrame
GF.OpenMenu(GF.menuButton)
stub.advance(0.5)` },
	settings: { title: 'Settings, Guide, Automation: "Dungeons in my route"', capture: ['PolestarOptions'], lua: `if PolestarNavArrow then PolestarNavArrow:Hide() end
if PolestarGuideFrame then PolestarGuideFrame:Hide() end
Polestar.UI.ShowOptions("guide")
stub.advance(0.5)
Polestar.UI.Options.Select("guide", "Automation")
stub.advance(1)` },
	// Mid-guide at 18 (the Barrens, before Wailing Caverns' pick-ups): turned on.
	'on-18': { title: 'At 18 in the Barrens: Run them, then the window', lua: RUN_ON },
	'pickup-18': { title: 'Run them: the first pick-up of Wailing Caverns', lua: `${RUN_ON}\n${UNTIL(PICKUP)}` },
	'soon-18': { title: 'Run them: a few steps before the run', lua: `${RUN_ON}\n${UNTIL('E.DungeonSoon()')}\nPolestar.UI.GuideFrame.Layout()` },
	'door-18': { title: 'Run them: at the door', lua: `${RUN_ON}\n${UNTIL('E.DungeonRun()')}\nPolestar.UI.GuideFrame.Layout()` },
	'kept-18': { title: 'At the door: Skip this one', lua: `${RUN_ON}\n${UNTIL('E.DungeonRun()')}
Polestar.UI.GuideFrame.Layout()
stub.advance(0.3)
Polestar.UI.GuideFrame.LaterBanner()
stub.advance(1)
Polestar.UI.GuideFrame.Layout()` },
	'off-18': { title: 'Turned off again with Wailing Caverns\' quests in the log', lua: `${RUN_ON}\n${UNTIL('E.DungeonSoon()')}\n${SET('skip')}` },
	// Dungeons on your way, from the guide window's menu, on the real route.
	'popover-18': { title: 'Dungeons on your way after Run them', capture: ['PolestarGuideFrame', 'PolestarDungeonRoute'], lua: `${RUN_ON}
local GF = Polestar.UI.GuideFrame
GF.DismissBanner()
Polestar.UI.DungeonRoute.Show(GF.menuButton)
stub.advance(0.5)` },
	'ask-18': { title: 'Ask me: the question at the first pick-up', lua: `${SET('ask')}\n${UNTIL('E.DungeonQuestion()')}\nPolestar.UI.GuideFrame.Layout()` },
	'card-18': { title: 'The dungeon heads-up card (Wailing Caverns is open to you)', capture: ['PolestarGuideFrame', 'PolestarClassToast'], lua: `stub.world.setLevel(20)
stub.advance(1)
${CARDS_AWAY}
local DT = Polestar.UI.DungeonToast
local c
for _, x in ipairs(DT.Candidates(stub.world.level, "any")) do if x.key == "wailing-caverns" then c = x end end
c = c or DT.Candidates(stub.world.level, "any")[1]
assert(c, "no dungeon card")
DT.Show(c)
stub.advance(1)
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)` },
	// The e2e gate's other switch points, on the guides the route has there.
	'on-26': { title: 'At 26 in the Barrens (04): Run them', lua: `${AT('forever/horde/04-the-barrens', 26, 18)}\n${RUN_ON}` },
	'on-34': { title: 'At 34 in Stranglethorn Vale: Run them', lua: `${AT('forever/horde/30-40/03-stranglethorn-vale', 34, 13)}\n${RUN_ON}` },
	'on-42': { title: 'At 42 in Stranglethorn Vale: Run them', lua: `${AT('forever/horde/40-50/01-stranglethorn-vale', 42, 29)}\n${RUN_ON}` },
};

module.exports = {
	title: 'Turning dungeons on, walked as a player on the shipped Horde route',
	character: skins.character,
	place: skins.place,
	guide: { id: 'forever/horde/02-the-barrens', play: 40 },
	settings: { 'behavior.dungeons': 'skip', 'behavior.offerClassQuests': false },
	// The game's Group Finder button, as the client has it (Find a group presses it).
	setup: 'LFGMicroButton = LFGMicroButton or CreateFrame("Button", "LFGMicroButton", UIParent)',
	window: skins.window,
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	shots,
};
