'use strict';
// Capitals as each client language writes them (ns.Upper). Lua's upper()
// knows ASCII alone; the caps labels and the typed confirm word go through
// ns.Upper so "Jäger" reads "JÄGER" and "Охотник" reads "ОХОТНИК".

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function lua(script) {
	return runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], login: true, script }).emitted;
}

const CASES = {
	enUS: ['Training due', 'TRAINING DUE'],
	deDE: ['Ausbildung fällig · Jäger', 'AUSBILDUNG FÄLLIG · JÄGER'],
	esES: ['Misión de clase: cazador niño', 'MISIÓN DE CLASE: CAZADOR NIÑO'],
	frFR: ['Quête de classe · prêtre élu', 'QUÊTE DE CLASSE · PRÊTRE ÉLU'],
	ptBR: ['Missão de classe · ação', 'MISSÃO DE CLASSE · AÇÃO'],
	ruRU: ['Классовое задание · охотник, ёж', 'КЛАССОВОЕ ЗАДАНИЕ · ОХОТНИК, ЁЖ'],
	plPL: ['źdźbło łąka', 'ŹDŹBŁO ŁĄKA'],
	koKR: ['직업 퀘스트', '직업 퀘스트'],
	zhCN: ['职业任务', '职业任务'],
	zhTW: ['職業任務', '職業任務'],
};

test('ns.Upper raises Latin-1, Latin Extended-A and Cyrillic; scripts with no capitals pass through', () => {
	const keys = Object.keys(CASES);
	const list = keys.map((k) => `[${JSON.stringify(k)}] = Polestar.Upper(${JSON.stringify(CASES[k][0])})`).join(',\n');
	const [out] = lua(`emit({ ${list} })`);
	for (const k of keys) assert.equal(out[k], CASES[k][1], k);
});

test('ns.Upper keeps ß, the multiplication sign and nil safe', () => {
	const [out] = lua('emit({ a = Polestar.Upper("straße"), b = Polestar.Upper("2×3"), c = Polestar.Upper(nil) })');
	assert.deepEqual(out, { a: 'STRAßE', b: '2×3', c: '' });
});

test('the typed confirm word unlocks in any case, accented letters too', () => {
	const [out] = lua(`local W = Polestar.Widgets
local m = W.Modal({ title = "t", text = "x", action = "Go", danger = true, typeToConfirm = "ZURÜCKSETZEN", onAccept = function() end })
local function try(s)
	m.Box.Word:SetText(s)
	local f = m.Box.Word:GetScript("OnTextChanged")
	if f then f(m.Box.Word, true) end
	return m.Box.Action:IsEnabled() and true or false
end
emit({ lower = try("  zurücksetzen "), wrong = try("zuruck"), exact = try("ZURÜCKSETZEN") })`);
	assert.deepEqual(out, { lower: true, wrong: false, exact: true });
});
