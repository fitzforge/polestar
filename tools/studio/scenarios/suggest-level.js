'use strict';
// Suggestions one level below a quest's level (feat/suggest-quest-level-037),
// Horde side (the class card is suggest-class.js): the dungeon
// heads-up (UI/DungeonToast.lua: a dungeon's quests offered from one level
// below theirs, Razorfen Kraul at 32 and 33, Wailing Caverns at 19 and 21, for a Tauren), and the guide list's
// "Suggested for you" (UI/Picker.lua: a 1-12 guide's follow-up from level 11).
// Each shot sets its character up itself; the result of each check comes back
// in the shot's result, which polestar studio prints.

const DUNGEON = (race, cls, level, map, x, y) => `local w = stub.world
w.level = ${level}
w.moveTo(${map}, ${x}, ${y}); play.syncZone()
local DT = Polestar.UI.DungeonToast
local CT = Polestar.UI.ClassToast
if CT.current then CT.Hide() end
stub.advance(1)
local list = DT.Candidates(${level}, "any")
local names = {}
for _, c in ipairs(list) do names[#names + 1] = c.key .. "@" .. tostring(c.due) .. ":" .. tostring(c.pickLabel) end
local want
for _, c in ipairs(list) do if c.key == STUDIO_DUNGEON then want = c end end
if want then DT.Show(want) end
stub.advance(1)
return { level = ${level}, candidates = table.concat(names, " | ") }`;

const SUGGESTED = (level) => `local w = stub.world
w.level = ${level}
Polestar.Engine.SetGuide("forever/horde/tauren/01-mulgore")
stub.advance(1)
studio.clearHeadsUps()
Polestar.UI.ShowPicker()
stub.advance(0.5)
local P = Polestar.UI.Picker
if P.ShowSection then P.ShowSection("Home") end
stub.advance(0.5)
return { level = ${level} }`;

module.exports = {
	title: 'Suggestions one level below a quest\'s level: the dungeon heads-up, Suggested for you',
	character: { race: 'Tauren', cls: 'WARRIOR', faction: 'Horde', level: 20, money: 9000 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens' },
	window: [1440, 690],
	capture: ['PolestarGuideFrame', 'PolestarClassToast'],
	shots: {
		'dungeon-rfk-32': {
			title: 'Tauren 32 in the southern Barrens: Razorfen Kraul\'s heads-up, one quest waiting (Going, Going, Guano!, level 33, from 33)',
			lua: `STUDIO_DUNGEON = "razorfen-kraul"\n${DUNGEON('Tauren', 'WARRIOR', 32, 1413, 41.0, 86.0)}`,
		},
		'dungeon-rfk-33': {
			title: 'At 33: every Razorfen Kraul quest offered',
			lua: `STUDIO_DUNGEON = "razorfen-kraul"\n${DUNGEON('Tauren', 'WARRIOR', 33, 1413, 41.0, 86.0)}`,
		},
		'dungeon-wc-19': {
			title: 'Tauren 19 in the Barrens: the Wailing Caverns heads-up, two quests from level 20',
			lua: `STUDIO_DUNGEON = "wailing-caverns"\n${DUNGEON('Tauren', 'WARRIOR', 19, 1413, 46.0, 36.0)}`,
		},
		'dungeon-wc-21': {
			title: 'Tauren 21: every Wailing Caverns quest offered (Leaders of the Fang, level 22, from 21)',
			lua: `STUDIO_DUNGEON = "wailing-caverns"\n${DUNGEON('Tauren', 'WARRIOR', 21, 1413, 46.0, 36.0)}`,
		},
		'suggested-10': { title: 'Mulgore 1-12 open at level 10: Home\'s "Suggested for you" without the 12-19 follow-up', capture: ['PolestarPicker'], lua: SUGGESTED(10) },
		'suggested-11': { title: 'At level 11: the follow-up listed', capture: ['PolestarPicker'], lua: SUGGESTED(11) },
	},
};
