'use strict';
// Quest-starting loot on the quest item button (QoL/QuestLoot.lua,
// QoL/Buttons.lua; #1627): a Tauren Hunter on the shipped Barrens guide
// loots the Hoof of Lakota'mani (begins "Lakota'mani", 883) on a step with no
// item of its own: it goes on the quest item button, glowing.
//
// The quest database answers who may take a quest (QuestDB.CheckAvailable).
// When the checkout's Polestar_QuestDB is not loaded (none built, or an
// older build), a stand-in answers for quest 883 alone from
// data/forever/quests.json's facts (level 22, from level 10, either faction):
// the button's choice and look are the real code's.

const HOOF = 5099;
const QUEST = 883;

const QUESTDB = `local Q = Polestar.QuestDB
if not Q.IsLoaded() then
	Q.IsLoaded = function() return true end
	local ctxOf = Q.PlayerContext
	Q.PlayerContext = function(p, ctx)
		ctx = ctx or {}
		ctx.level = UnitLevel("player")
		return ctx
	end
	Q.StartedBy = function(id) if id == ${HOOF} then return { ${QUEST} } end end
	Q.CheckAvailable = function(id, ctx, isDone, isOn)
		if id ~= ${QUEST} or (ctx.level or 1) < 10 then return false, "eligibility" end
		if isDone(id) then return false, "done" end
		if isOn(id) then return false, "active" end
		return true
	end
end`;

module.exports = {
	title: 'Quest-starting loot on the quest item button, glowing (#1627)',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 17, money: 4200 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 55, hours: 1.5 },
	data: { items: [HOOF] },
	settings: { 'behavior.offerClassQuests': false },
	setup: QUESTDB,
	window: [1440, 690],
	capture: ['PolestarQuestItemButton', 'PolestarTargetButton', 'GameTooltip'],
	pad: 48,
	shots: {
		glow: {
			title: 'The Hoof of Lakota\'mani looted: on the quest item button, glowing',
			lua: `studio.bag(${HOOF}, 1, { quest = ${QUEST} })
stub.advance(1)`,
		},
		hover: {
			title: 'The same, hovered: the item\'s tooltip and "You can take the quest this item starts. Click to read it."',
			lua: `studio.bag(${HOOF}, 1, { quest = ${QUEST} })
stub.advance(1)
studio.installTips(GameTooltip)
studio.hover(PolestarQuestItemButton)`,
		},
	},
};
