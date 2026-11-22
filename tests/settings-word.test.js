'use strict';
// The window is called "Settings" in every language: no English string the
// addon shows names it "Options". The game's own Options menu keeps its name
// (the gamepad switch, the key bindings, the gamepad's Options button; #2762).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ADDON = path.join(__dirname, '..', 'addon');
const GAME_OWN = [
	'Bind a key to the target button (Options > Keybindings',
	"Browsing the guide needs the game's gamepad interface (Options, Gamepad",
	"Off, Polestar uses the gamepad only with the game's gamepad interface (Options, Gamepad",
	'Options button',
];

function luaFiles(dir) {
	return fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) return luaFiles(p);
		return e.name.endsWith('.lua') && !/^(Interface|Texts|Guides)\.lua$/.test(e.name) ? [p] : [];
	});
}

test('no player-facing string names the window "Options"', () => {
	const found = [];
	for (const file of luaFiles(ADDON)) {
		const lines = fs.readFileSync(file, 'utf8').split('\n');
		lines.forEach((line, i) => {
			if (/^\s*--/.test(line)) return;
			for (const m of line.matchAll(/L\["((?:[^"\\]|\\.)*)"\]/g)) {
				const key = m[1];
				if (!/\bOptions\b|\bPolestar options\b|\boptions page\b/.test(key)) continue;
				if (GAME_OWN.some((g) => key.startsWith(g))) continue;
				found.push(`${path.relative(ADDON, file)}:${i + 1}: ${key.slice(0, 60)}`);
			}
		});
	}
	assert.deepEqual(found, []);
});

test('every locale names the window with one word in its toc and its Settings key', () => {
	const WORD = { deDE: 'Einstellungen', esES: 'Ajustes', esMX: 'Configuración', frFR: 'Réglages', koKR: '설정', ptBR: 'Configurações', ruRU: 'Настройки', zhCN: '设置', zhTW: '設定' };
	for (const [loc, word] of Object.entries(WORD)) {
		const text = fs.readFileSync(path.join(ADDON, `Polestar_${loc}`, 'Interface.lua'), 'utf8');
		assert.ok(text.includes(`L["Settings"] = "${word}"`), `${loc}: Settings is ${word}`);
	}
});
