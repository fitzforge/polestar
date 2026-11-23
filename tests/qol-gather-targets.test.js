'use strict';
// A gathered material (`collect … gather Skinning`) comes from skinning the
// beasts at the step's place, not from loot: the target button names the
// goal's own sources and never falls back to the item's droppers over the
// whole world (#3135: a Darkshore Medium Leather step named Feralas ogres).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const { buildProgram, parseEmitted, ROOT } = require('./helpers/lua');
const { findLua } = require('../tools/lib/lua');

const FILES = { name: 'Polestar', files: [
	'Core/Init.lua', 'Core/Compat.lua', 'Core/LuaChunks.lua', 'Core/Names.lua',
	'Theme/Theme.xml', 'QoL/QoL.lua', 'QoL/Data.lua', 'QoL/Buttons.lua',
	'QoL/Riding.lua', 'Quests/QuestDB.lua',
] };

function run(goal) {
	const program = 'assert(_VERSION == "Lua 5.1", "requires Lua 5.1")\n' + buildProgram({
		stubs: ['stub_qol.lua'], before: 'function GetLocale() return "enUS" end',
		addons: [FILES], script: String.raw`
			Polestar.Data = { Pack = function() return false, "missing" end }
			stub.login()
			local q, Q = stub.qol, Polestar.QuestDB
			Polestar.Set("qol.targetSimple", true) -- the single button's name; the list hides it
			Q.SetMeta({ schema = 2 })
			Q.AddChunk("npcs", 500101, 500102, "\n500101\t'Far Ogre;9000;1;1;50;50;0\n500102\t'Near Beast;9000;1;1;50;50;0\n")
			Q.AddChunk("items", 500100, 500100, "\n500100\t'Test Leather;1;500101;50;0\n")
			q.step({ { ${goal} } })
			local button = PolestarTargetButton
			emit({ label = button.Label:GetText() or "", macro = button:GetAttribute("macrotext") or "" })
		`,
	});
	const result = spawnSync(findLua(), ['-'], { input: program, encoding: 'utf8', cwd: ROOT, timeout: 30000, maxBuffer: 8 * 1024 * 1024 });
	assert.ifError(result.error);
	assert.equal(result.status, 0, `${result.stderr}\n${result.stdout}`);
	return parseEmitted(result.stdout)[0];
}

test('a gathered material never names the item droppers of other zones (#3135)', () => {
	const r = run('t = "collect", item = 500100, gather = { skill = "Skinning", skillLine = 393, rank = 80 }');
	assert.doesNotMatch(r.macro, /Far Ogre/);
	assert.notEqual(r.label, 'Far Ogre');
});

test('a gathered material still names the sources written on its goal', () => {
	const r = run('t = "collect", item = 500100, gather = { skill = "Skinning", skillLine = 393, rank = 80 }, fromNpcs = { { npc = 500102, npcName = "Near Beast" } }');
	assert.match(r.macro, /\/targetexact Near Beast/);
	assert.doesNotMatch(r.macro, /Far Ogre/);
});

test('a looted item keeps its droppers as the fallback', () => {
	const r = run('t = "collect", item = 500100');
	assert.match(r.macro, /\/targetexact Far Ogre/);
});

test('cloth and meat (`gather` with no profession) drop as loot and keep their droppers', () => {
	for (const way of ['true', '{ min = 18, max = 30 }']) {
		const r = run(`t = "collect", item = 500100, gather = ${way}`);
		assert.match(r.macro, /\/targetexact Far Ogre/, way);
	}
});
