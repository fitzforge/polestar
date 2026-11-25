'use strict';

const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { createHash } = require('node:crypto');
const { test } = require('node:test');
const { runAddon } = require('./helpers/lua');
const { captureTargets, parseCapture, exportNames, targetsLua } = require('../tools/dev/npc-name-capture');

const codex = {
	6: { name: 'Kobold Vermin' },
	7: { name: 'Stone Golem' },
	8: { name: 'Tiger' },
	9: { name: '<TXT> ' },
	10: { name: 'Merchant' },
	11: { name: 'Guard' },
};
const pack = 'R("quest", 6, 8, [[\n6\tQuest text\n]])\nR("npc", 7, 7, [[\n7\tSteingolem\n]])';
const observed = { schema: 1, locale: 'deDE', names: [
	{ token: 'npc:10', name: 'Händler', source: 'client-learning', build: null, ref: 36 },
	{ token: 'quest:11', name: 'Wache suchen', source: 'client-learning', build: null, ref: 36 },
] };

test('NPC targets skip names the locale already has and unused English entries', () => {
	assert.deepEqual([...captureTargets(codex, pack, observed).keys()], [6, 8, 11]);
});

function saved(locale, name) {
	return `PolestarNpcNameCaptureDB = {
	["names"] = {
		[8] = "Tiger",
		[6] = ${JSON.stringify(name)},
	},
	["build"] = "1.60.1.71037",
	["locale"] = "${locale}",
}
`;
}

test('capture exports exact German and Traditional Chinese names and reports English or missing IDs', () => {
	for (const [locale, name] of [['deDE', 'Kobold "Ungeziefer"'], ['zhTW', '狗頭人‧害蟲']]) {
		const input = saved(locale, name);
		const existing = { ...observed, locale };
		const sha256 = createHash('sha256').update(input).digest('hex');
		const result = exportNames(parseCapture(input), captureTargets(codex, pack, existing), existing, sha256, 42);
		assert.deepEqual(result.document.names, [
			{ token: 'npc:6', name, source: 'client-learning', build: '1.60.1.71037', sha256, ref: 42 },
			...existing.names,
		]);
		assert.deepEqual(result.english, [8]);
		assert.deepEqual(result.unresolved, [11]);
	}
});

test('capture rejects unexpected Lua and duplicate IDs', () => {
	const input = saved('deDE', 'Koboldunhold');
	assert.throws(() => parseCapture(input + 'print("extra code")'), /SavedVariables/);
	assert.throws(() => parseCapture(input.replace('[8]', '[6]')), /duplicate NPC 6/);
});

test('the addon checks locale, retries missing tooltips and saves only localized results', () => {
	const base = path.resolve(__dirname, '../tools/dev/PolestarNpcNameCapture');
	assert.ok(fs.existsSync(path.join(base, 'Capture.lua')), 'missing collector addon');
	for (const [locale, name] of [['deDE', 'Wache'], ['zhTW', '衛兵']]) {
		const targets = targetsLua(locale, new Map([[6, 'Guard'], [8, 'Tiger']]));
		const { emitted } = runAddon({
			before: targets + `
local locale = "enUS"
GetLocale = function() return locale end
GetBuildInfo = function() return "1.60.1", "71037" end
local attempts = {}
local timers = {}
C_Timer.After = function(_, callback) timers[#timers + 1] = callback end
C_TooltipInfo = { GetHyperlink = function(link)
	local id = tonumber(link:match("-(%d+)-0000000000$"))
	attempts[id] = (attempts[id] or 0) + 1
	if id == 8 then return { lines = {{ leftText = "Tiger" }} } end
	if attempts[id] == 2 then return { lines = {{ leftText = "${name}" }} } end
end }
function runCapture()
	local command = SlashCmdList.POLESTARNPCNAMECAPTURE
	command("start")
	emit(PolestarNpcNameCaptureDB ~= nil)
	locale = "${locale}"
	command("start")
	while #timers > 0 do table.remove(timers, 1)() end
	emit(PolestarNpcNameCaptureDB)
	emit(attempts)
end`,
			addons: [{ name: 'PolestarNpcNameCapture', files: [path.join(base, 'Capture.lua')] }],
			script: 'runCapture()',
		});
		assert.deepEqual(emitted, [
			false,
			{ locale, build: '1.60.1.71037', names: { 6: name } },
			{ 6: 2, 8: 3 },
		]);
	}
});
