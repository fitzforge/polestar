'use strict';
// Chat messages (ui.chatMessages, #2527): the lines telling what Polestar did
// for you (ns.Notice) show by default and stay out of chat with the setting
// off. Two of them: the turn-in waiting on a reward and the action button
// upgrade.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const PREFIX = '|cff4fd1c5Polestar|r: ';

const GUIDE = `
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({
	id = "test/auto", pack = "test", title = "Automation", minLevel = 1, maxLevel = 10,
	steps = {
		{ goals = { { t = "accept", quest = 783, title = "A Threat Within" } } },
		{ goals = { { t = "turnin", quest = 783, title = "A Threat Within" } } },
	},
})
`;

function turnIn(off) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: 'w = stub.world; w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); w.moveTo(1429, 48, 42); w.onQuest(783, {}); w.choices[783] = 3',
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `${GUIDE}
stub.login()
${off ? 'Polestar.Set("ui.chatMessages", false)' : ''}
stub.messages = {}
w.questProgress(197, 783)
emit({ frame = w.frame and w.frame.kind, said = stub.messages })`,
	}).emitted[0];
}

test('the turn-in waiting on a reward says so by default, and not with Chat messages off', () => {
	const on = turnIn(false);
	assert.equal(on.frame, 'complete');
	assert.deepEqual(on.said, [`${PREFIX}Choose a reward to finish the turn-in.`]);
	const off = turnIn(true);
	assert.equal(off.frame, 'complete', 'the turn-in still waits on the reward');
	assert.deepEqual(off.said, {}, 'no chat line');
});

const SPELLS = `
local S = Polestar.QoL.Spells
local C = Polestar.Compat
KNOWN = { [136] = true, [139] = true, [6074] = true }
C.IsSpellKnown = function(id) return KNOWN[id] == true end
IsPlayerSpell = function(id) return KNOWN[id] == true end
C.GetPlayerInfo = function() return { name = "T", level = 20, race = "Human", class = "PRIEST", faction = "Alliance" } end
NAMES = { [136] = "Renew", [139] = "Renew", [6074] = "Renew" }
RANKS = { [136] = 1, [139] = 2, [6074] = 3 }
C_Spell.GetSpellName = function(id) return NAMES[id] end
C_Spell.GetSpellSubtext = function(id) return RANKS[id] and ("Rank " .. RANKS[id]) or "" end
BOOK = { 136, 139, 6074 }
C_SpellBook = {
	GetNumSpellBookSkillLines = function() return 1 end,
	GetSpellBookSkillLineInfo = function() return { itemIndexOffset = 0, numSpellBookItems = #BOOK } end,
	GetSpellBookItemInfo = function(i) return BOOK[i] and { spellID = BOOK[i], itemType = 1, name = NAMES[BOOK[i]] } or nil end,
}
ACTIONS, CURSOR = { [5] = { "spell", 139 } }, nil
HasAction = function(s) return ACTIONS[s] ~= nil end
GetActionInfo = function(s) local a = ACTIONS[s]; if a then return a[1], a[2] end end
GetCursorInfo = function() if CURSOR then return CURSOR[1], CURSOR[2] end end
C_Spell.PickupSpell = function(id) CURSOR = { "spell", id } end
PlaceAction = function(s)
	local old = ACTIONS[s]
	ACTIONS[s] = CURSOR
	CURSOR = old
	stub.fire("ACTIONBAR_SLOT_CHANGED", s)
end
ClearCursor = function() CURSOR = nil end
stub.advance(7)
`;

function upgrade(off) {
	return runAddon({
		stubs: ['stub_qol.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] }],
		login: true,
		script: `${SPELLS}
${off ? 'Polestar.Set("ui.chatMessages", false)' : ''}
stub.messages = {}
emit({ done = S.Upgrade(), slot = ACTIONS[5][2], said = stub.messages })`,
	}).emitted[0];
}

test('the action button upgrade says so by default, and not with Chat messages off', () => {
	const on = upgrade(false);
	assert.deepEqual([on.done, on.slot], [1, 6074]);
	assert.deepEqual(on.said, [`${PREFIX}Upgraded 1 action button to the highest rank.`]);
	const off = upgrade(true);
	assert.deepEqual([off.done, off.slot], [1, 6074], 'the button is still upgraded');
	assert.deepEqual(off.said, {}, 'no chat line');
});
