'use strict';
// Run real Lua 5.1 modules through stdin: no generated test file or cleanup.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const { buildProgram, parseEmitted, ROOT } = require('./helpers/lua');
const { findLua } = require('../tools/lib/lua');

// UTF-8 byte escapes keep Lua string literals portable over stdin.
function luaText(value) {
	return '"' + Array.from(Buffer.from(value, 'utf8'), b => '\\' + b.toString().padStart(3, '0')).join('') + '"';
}

const FILES = { name: 'Polestar', files: [
	'Core/Init.lua', 'Core/Compat.lua', 'Core/LuaChunks.lua', 'Core/Names.lua',
	'Theme/Theme.xml', 'QoL/QoL.lua', 'QoL/Data.lua', 'QoL/Buttons.lua',
	'QoL/Riding.lua', 'Quests/QuestDB.lua',
] };

function run(script, locale = 'zhCN') {
	const program = 'assert(_VERSION == "Lua 5.1", "requires Lua 5.1")\n' + buildProgram({
		stubs: ['stub_qol.lua'], before: `function GetLocale() return ${JSON.stringify(locale)} end`,
		addons: [FILES], script: `
			Polestar.Data = { Pack = function() return false, "missing" end }
			stub.login()
			local q, B, N, Q = stub.qol, Polestar.QoL.Buttons, Polestar.Names, Polestar.QuestDB
			${script}
		`,
	});
	const result = spawnSync(findLua(), ['-'], { input: program, encoding: 'utf8', cwd: ROOT, timeout: 30000, maxBuffer: 8 * 1024 * 1024 });
	assert.ifError(result.error);
	assert.equal(result.status, 0, `${result.stderr}\n${result.stdout}`);
	return parseEmitted(result.stdout);
}

function targetSetup(source) {
	const goal = source === 'fromNpcs'
		? '{ t = "collect", item = 500100, fromNpcs = { { npc = 500101, npcName = "Old Target" } } }'
		: source === 'questDroppers'
			? '{ t = "collect", item = 500100, quest = 500200, oi = 1 }'
			: '{ t = "collect", item = 500100 }';
	return String.raw`
		Polestar.Set("qol.targetSimple", true) -- the single button's name; the list hides it
		Q.SetMeta({ schema = 2 })
		Q.AddChunk("npcs", 500101, 500101, "\n500101\t'Old Target;9000;1;1;50;50;0\n")
		${source === 'fromNpcs' ? '' : String.raw`Q.AddChunk("items", 500100, 500100, "\n500100\t'Test Item;1;500101;50;0\n")`}
		${source === 'questDroppers' ? String.raw`Q.AddChunk("quests", 500200, 500200, "\n500200\t" .. table.concat({ "'Test Quest", "", "", "", "", "", "", "", "", "", "", "{2,500100,1" }, ";") .. "\n")` : ''}
		q.step({ ${goal} })
		local button, step = PolestarTargetButton, PolestarStepButton
		assert(button.Label:GetText() == "Old Target", "fixture must start with the English fallback")
		local learned, updates, reads = 0, 0, 0
		Polestar.On("NAME_LEARNED", function() learned = learned + 1 end)
		Polestar.On("STEP_UPDATED", function() updates = updates + 1 end)
		local getView = Polestar.Engine.GetStepView
		Polestar.Engine.GetStepView = function(...) reads = reads + 1; return getView(...) end
		local name
		UnitGUID = function() return "Creature-0-0-0-0-500101-0" end
		UnitName = function() return name end
		local function learn(value) name = value; N.Learn("target") end
	`;
}

for (const source of ['fromNpcs', 'itemDroppers', 'questDroppers']) {
	test(`learned names refresh ${source} target and step macros once per burst`, () => {
		const [result] = run(targetSetup(source) + `
			learn(${luaText("\u76ee\u6807\u7532")}); learn(${luaText("\u76ee\u6807\u4e59")})
			stub.runTimers()
			emit({ resolved = N.Npc(500101), label = button.Label:GetText(), macro = button:GetAttribute("macrotext"),
				stepMacro = step:GetAttribute("macrotext"), learned = learned, updates = updates, reads = reads })
		`);
		assert.equal(result.resolved, '目标乙');
		assert.equal(result.label, '目标乙');
		assert.match(result.macro, /\/targetexact 目标乙/);
		assert.match(result.stepMacro, /\/targetexact 目标乙/);
		assert.equal(result.learned, 2);
		assert.equal(result.updates, 0, 'the refresh must not depend on a direct goal.npc redraw');
		assert.equal(result.reads, 1, 'a burst must reuse QoL.Coalesce');
	});

	test(`learned names queue ${source} secure attributes until combat ends`, () => {
		const [during, after] = run(targetSetup(source) + `
			local previous = button:GetAttribute("macrotext")
			local previousStep = step:GetAttribute("macrotext")
			local violations = 0
			local setAttribute = stub.Methods.SetAttribute
			stub.Methods.SetAttribute = function(self, ...)
				if self.secure and stub.inCombat then violations = violations + 1 end
				return setAttribute(self, ...)
			end
			q.combat(true)
			learn(${luaText("\u76ee\u6807\u7532")}); learn(${luaText("\u76ee\u6807\u4e59")})
			stub.runTimers()
			emit({ unchanged = button:GetAttribute("macrotext") == previous,
				stepUnchanged = step:GetAttribute("macrotext") == previousStep,
				label = button.Label:GetText(), violations = violations })
			q.combat(false); stub.runTimers()
			emit({ label = button.Label:GetText(), macro = button:GetAttribute("macrotext"),
				stepMacro = step:GetAttribute("macrotext"), violations = violations })
		`);
		assert.deepEqual(during, { unchanged: true, stepUnchanged: true, label: 'Old Target', violations: 0 });
		assert.equal(after.violations, 0);
		assert.equal(after.label, '目标乙');
		assert.match(after.macro, /\/targetexact 目标乙/);
		assert.match(after.stepMacro, /\/targetexact 目标乙/);
	});
}

// IDs are matched to local name records and installed spawn/faction data;
// repeated names (Jartsam, Genn) are constrained to these existing route points.
const TRAINERS = [
	['Orc', 'Horde', 'WARRIOR', 4752, 'Kildar', 1454, 69.4, 13.1],
	['Troll', 'Horde', 'WARRIOR', 7953, "Xar'Ti", 1411, 55.3, 75.5],
	['Tauren', 'Horde', 'WARRIOR', 3690, 'Kar Stormsinger', 1412, 46.8, 62.0],
	['Scourge', 'Horde', 'WARRIOR', 4773, 'Velma Warnam', 1420, 60.1, 52.6],
	['Human', 'Alliance', 'WARRIOR', 4732, 'Randal Hunter', 1429, 84.3, 64.9],
	['NightElf', 'Alliance', 'WARRIOR', 4753, 'Jartsam', 1438, 25.3, 50.2],
	['Dwarf', 'Alliance', 'WARRIOR', 4772, 'Ultham Ironhorn', 1426, 63.7, 50.1],
	['Gnome', 'Alliance', 'WARRIOR', 7954, 'Binjy Featherwhistle', 1426, 49.2, 48.1],
	['Skyborne', 'Alliance', 'WARRIOR', 265756, 'Genn Fairweather', 2521, 53.5, 80.5],
	['Skyborne', 'Horde', 'WARRIOR', 265756, 'Genn Fairweather', 2521, 53.5, 80.5],
	['Human', 'Alliance', 'WARLOCK', 6251, 'Strahad Farsan', 1413, 62.6, 35.5],
	['Human', 'Alliance', 'PALADIN', 928, 'Lord Grayson Shadowbreaker', 1453, 48.43, 50.22],
];

function ridingScript(localized, missingNames = false) {
	return `
		local cases = { ${TRAINERS.map(([race, faction, cls, id]) => `{ ${JSON.stringify(race)}, ${JSON.stringify(faction)}, ${JSON.stringify(cls)}, ${id} }`).join(', ')} }
		${localized ? String.raw`for _, row in ipairs(cases) do N.AddChunk("zhCN", "npc", row[4], row[4], "\n" .. row[4] .. "\t" .. ${luaText('\u672c\u5730\u8bad\u7ec3\u5e08')} .. row[4] .. "\n") end` : ''}
		${missingNames ? 'Polestar.Names = nil' : ''}
		local info, notice
		local C = Polestar.Compat
		C.GetPlayerInfo = function() return info end
		C.IsSpellKnown = function() return false end
		C.GetSkillRank = function() return 0, 0 end
		C.IsQuestCompleted = function() return false end
		C.GetFactionStanding = function() return nil end
		Polestar.On("RIDING_DUE", function(n) notice = n end)
		for _, row in ipairs(cases) do
			info = { race = row[1], faction = row[2], class = row[3], level = 40 }
			Polestar.CharState().flags = {}; notice = nil
			Polestar.QoL.Riding.Check(40)
			assert(notice and notice.trainer, "route must produce a trainer notice")
			emit({ npc = notice.trainer.npc, name = notice.trainer.npcName, map = notice.trainer.map,
				x = notice.trainer.x, y = notice.trainer.y, cost = notice.cost, classKind = notice.classKind })
		end
	`;
}

function assertRoutes(rows, localized) {
	assert.equal(rows.length, TRAINERS.length);
	for (const [i, row] of rows.entries()) {
		const [, , cls, id, english, map, x, y] = TRAINERS[i];
		assert.equal(row.name, localized ? `本地训练师${id}` : english, english);
		assert.equal(row.npc, id, english);
		assert.deepEqual([row.map, row.x, row.y], [map, x, y], 'retain the existing destination');
		assert.equal(row.cost, cls === 'WARRIOR' ? 1000000 : 0, 'retain costs and class routes');
		assert.equal(row.classKind, cls === 'WARRIOR' ? undefined : cls);
	}
}

test('riding notices use localized NPC identities for every race, faction and class route', () => {
	assertRoutes(run(ridingScript(true)), true);
});

test('riding notices retain English and destination when an NPC name or Names module is unavailable', () => {
	assertRoutes(run(ridingScript(false)), false);
	assertRoutes(run(ridingScript(false, true)), false);
});

test('riding notices retain English on an English client even with a Chinese names chunk', () => {
	assertRoutes(run(ridingScript(true), 'enUS'), false);
});
