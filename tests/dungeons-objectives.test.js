'use strict';

const assert = require('node:assert/strict');
const path = require('node:path');
const { test } = require('node:test');
const { ADDONS, runAddon } = require('./helpers/lua');

const source = JSON.stringify(path.join(ADDONS, 'Polestar', 'Dungeons', 'Dungeons.lua').replaceAll('\\', '/'));
const script = [
	'assert(loadfile(' + source + '))("Polestar", Polestar)',
	'local D = Polestar.Dungeons',
	'local function text(id, ...)',
	'  return D.ObjectiveText({ id = id, objectives = { ... } })',
	'end',
	'local function event(name, count)',
	'  return { k = "event", name = name, n = count }',
	'end',
	'emit({',
	'  text(92753, event("Explosives placed")),',
	'  text(94748, event("Rog\'mar Scout rescued", 5)),',
	'  text(94888, event("Farholde Scouts rescued", 5)),',
	'  text(94907, { k = "kill", id = 258652, name = "Twilight Thrall" }),',
	'  text(95602, event("Twilight Ritual Circle destroyed", 5)),',
	'  text(-1, event("A rescue", 2), event("A ritual", 3)),',
	'  text(-2, event("A single event", 1)),',
	'  text(-3, { k = "kill", id = -1, name = "Kobold", n = 2 }),',
	'  D.ObjectiveText({ id = 92753, objective = "Legacy objective" }),',
	'})',
].join('\n');

const expected = {
	enUS: [
		'Explosives placed',
		"Rog'mar Scout rescued ×5",
		'Farholde Scouts rescued ×5',
		'Kill Twilight Thrall',
		'Twilight Ritual Circle destroyed ×5',
		'A rescue ×2\nA ritual ×3',
		'A single event',
		'Kill 2 Kobold',
		'Legacy objective',
	],
	zhCN: [
		'找到深藏于死亡矿井中的熔炉，在旁安放强效炸药。随后，在死亡矿井出口与阿尔巴·晴月会合。',
		'为达格罗什解救暮光之帷内的5名洛格玛斥候。',
		'为里夫坦中士解救暮光之帷内的5名法霍德斥候。',
		'击杀暮光奴隶',
		'摧毁在阳光林地下方洞穴中发现的5个暮光仪式法阵。',
		'A rescue ×2\nA ritual ×3',
		'A single event',
		'击杀 2 个Kobold',
		'Legacy objective',
	],
};

for (const [locale, lines] of Object.entries(expected)) {
	test('dungeon journal localizes names and preserves event counts in ' + locale, () => {
		const [actual] = runAddon({
			before: 'GetLocale = function() return ' + JSON.stringify(locale) + ' end',
			addons: [
				{ name: 'Polestar', files: ['Core/Core.xml', 'Core/LuaChunks.lua', 'Core/Names.lua'] },
				{ name: 'Polestar_zhCN', files: ['Interface.lua', 'Names.lua'] },
			],
			script,
		}).emitted;
		assert.deepEqual(actual, lines);
	});
}
