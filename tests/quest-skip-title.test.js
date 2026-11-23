'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK } = require('./helpers/packs');
const { namesPack } = require('./helpers/names');

test('skipping a quest uses its localised title and keeps the guide title as a fallback', () => {
	const names = namesPack('zhTW', { quest: { 543: '匹瑞諾德王冠' } });
	const { emitted } = runAddon({
		stubs: ['stub_world.lua', 'stub_packs.lua'],
		before: `function GetLocale() return "zhTW" end\n${names.stubLua}`,
		addons: ['Polestar'],
		script: `
${TEST_PACK}
Polestar.RegisterGuide({ id = "test/quest-skip", pack = "test", title = "Test guide", minLevel = 1, maxLevel = 60,
	steps = {
		{ goals = { { t = "accept", quest = 543, title = "The Perenolde Tiara" } } },
		{ goals = { { t = "accept", quest = 7, title = "Guide fallback" } } },
	},
})
stub.login()
local E = Polestar.Engine
E.SetGuide("test/quest-skip")
assert(E.GetGuide().id == "test/quest-skip")
Polestar.On("PLAYER_SKIPPED_QUEST", function(id, title) emit({ id, title }) end)
E.SkipQuest(543, true)
E.SkipQuest(7, true)
`,
	});
	assert.deepEqual(emitted, [[543, '匹瑞諾德王冠'], [7, 'Guide fallback']]);
});
