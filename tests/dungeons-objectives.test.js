'use strict';

const assert = require('node:assert/strict');
const path = require('node:path');
const { test } = require('node:test');
const { ADDONS, runAddon } = require('./helpers/lua');

const source = JSON.stringify(path.join(ADDONS, 'Polestar', 'Dungeons', 'Dungeons.lua').replaceAll('\\', '/'));
const script = [
	'assert(loadfile(' + source + '))("Polestar", Polestar)',
	'local D = Polestar.Dungeons',
	'local function objective(quest, npc, name, count)',
	'  return D.ObjectiveText({ id = quest, objectives = { { k = "kill", id = npc, name = name, n = count } } })',
	'end',
	'emit({',
	'  objective(92753, 253370, "[DNT] Kill Credit: Place Explosives"),',
	'  objective(94748, 272737, "[DNT] Kill Credit", 5),',
	'  objective(94888, 272737, "[DNT] Kill Credit", 5),',
	'  objective(94907, 271293, "[DNT] Kill Credit: Twilight Thrall"),',
	'  objective(95602, 272603, "[DNT] Kill Credit", 5),',
	'  objective(94748, 272737, "[DNT] Kill Credit", 2),',
	'  objective(94748, 272737, "Kobold", 5),',
	'  objective(94748, 404, "Kobold"),',
	'  D.ObjectiveText({ id = 92753, objective = "Legacy objective" })',
	'})',
].join('\n');

const expected = {
	enUS: [
		'Place the explosives',
		"Rescue 5 Rog'mar Scouts",
		'Rescue 5 Farholde Scouts',
		'Capture a Twilight Thrall',
		'Destroy 5 Twilight Ritual Circles',
		"Rescue 2 Rog'mar Scouts",
		'Kill 5 Kobold',
		'Kill Kobold',
		'Legacy objective',
	],
	zhCN: [
		'放置炸弹',
		'解救 5 名洛格玛斥候',
		'营救 5 名法霍德斥候',
		'俘获暮光奴隶',
		'摧毁 5 个暮光仪式法阵',
		'解救 2 名洛格玛斥候',
		'击杀 5 个Kobold',
		'击杀Kobold',
		'Legacy objective',
	],
};

for (const [locale, lines] of Object.entries(expected)) {
	test('dungeon credit objectives describe the action for each quest in ' + locale, () => {
		const [actual] = runAddon({
			before: 'GetLocale = function() return ' + JSON.stringify(locale) + ' end',
			addons: [
				{ name: 'Polestar', files: ['Core/Core.xml'] },
				{ name: 'Polestar_zhCN', files: ['Interface.lua'] },
			],
			script,
		}).emitted;
		assert.deepEqual(actual, lines);
	});
}
