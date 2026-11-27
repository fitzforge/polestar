'use strict';
// The middle dot "·" that joins Polestar's text (#4015: "3/10 · 1/8" on a
// nameplate, "Level 14  ·  New spells" on the training note): a face without
// it draws a box, so a string in such a face shows "-" instead, whoever set
// its text (Theme.HasDot, Theme.Font's strings, Polestar's tooltips and chat
// lines). The Russian client font has none; on a Russian client EllesmereUI's
// font or a face the player picked keeps it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { Font } = require('../tools/preview/font');
const { runAddon, ROOT } = require('./helpers/lua');

const ADDON = path.join(ROOT, 'addon');
const DOT = '\u00b7';
const RU = 'function GetLocale() return "ruRU" end\nSTANDARD_TEXT_FONT = "Fonts\\\\FRIZQT___CYR.TTF"';

function bundledFonts() {
	const out = [];
	const walk = (dir) => {
		for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
			if (e.name === 'Libs') continue;
			const p = path.join(dir, e.name);
			if (e.isDirectory()) walk(p);
			else if (/\.(ttf|otf)$/i.test(e.name)) out.push(p);
		}
	};
	walk(ADDON);
	return out;
}

function lua(script, before = '') {
	return runAddon({ stubs: ['stub_world.lua'], before, addons: ['Polestar'], login: true, script }).emitted;
}

test('every bundled font has "·", and Theme.DOT_FACES lists it', () => {
	const fonts = bundledFonts();
	assert.ok(fonts.length >= 11, `bundled fonts found: ${fonts.length}`);
	const [listed] = lua('local t = {}; for k in pairs(Polestar.Theme.DOT_FACES) do t[#t + 1] = k end; table.sort(t); emit(t)');
	for (const f of fonts) {
		assert.ok(new Font(f).glyphId(0xb7) > 0, `${path.relative(ROOT, f)} has no "·"`);
		assert.ok(listed.includes(path.basename(f).toLowerCase()), `${path.basename(f)} is not in Theme.DOT_FACES`);
	}
});

test('Theme.Dot: "·" for a face with it, "-" for the ruRU client font and, on a Russian client, a face Polestar does not know', () => {
	const faces = `local T = Polestar.Theme
emit({
	game = T.Dot("Fonts\\\\FRIZQT__.TTF"),
	cyr = T.Dot("Fonts\\\\FRIZQT___CYR.TTF"),
	fira = T.Dot("Interface\\\\AddOns\\\\Polestar\\\\Media\\\\Fonts\\\\FiraSans-Medium.ttf"),
	other = T.Dot("Interface\\\\AddOns\\\\EllesmereUI\\\\media\\\\fonts\\\\Expressway.ttf"),
})`;
	assert.deepEqual(lua(faces)[0], { game: DOT, cyr: '-', fira: DOT, other: DOT });
	assert.deepEqual(lua(faces, RU)[0], { game: DOT, cyr: '-', fira: DOT, other: '-' });
});

// A Polestar string (Theme.Font, as the nameplate counts and the guide window's notes are) whose text has "·".
const STRING = `local fs = UIParent:CreateFontString(nil, "OVERLAY")
Polestar.Theme.Font(fs, "small")
fs:SetText("2/20 \\194\\183 2/3")
local a = fs:GetText()
fs:SetFormattedText("%s  \\194\\183  %s", "Level 14", "New spells")
emit({ face = (fs:GetFont()), count = a, note = fs:GetText() })`;

test('a Polestar string in a face with "·" keeps it (the skin\'s face; on a Russian client Fira Sans)', () => {
	const [en] = lua(STRING);
	assert.equal(en.count, `2/20 ${DOT} 2/3`);
	assert.equal(en.note, `Level 14  ${DOT}  New spells`);
	const [ru] = lua(STRING, RU);
	assert.match(ru.face, /FiraSans/i);
	assert.equal(ru.count, `2/20 ${DOT} 2/3`);
});

test('#4015: on a Russian client the game font picked, or EllesmereUI\'s font followed, draws "-" for "·"', () => {
	const [picked] = lua(`Polestar.Set("ui.font", "game")\n${STRING}`, RU);
	assert.deepEqual(picked, { face: 'Fonts\\FRIZQT___CYR.TTF', count: '2/20 - 2/3', note: 'Level 14  -  New spells' });
	const [eui] = lua(`Polestar.Set("ui.matchFont", true)\n${STRING}`, `${RU}\nstub.withEllesmere()`);
	assert.match(eui.face, /Expressway/);
	assert.equal(eui.count, '2/20 - 2/3');
	assert.equal(eui.note, 'Level 14  -  New spells');
	// The skin's face again: the next text keeps its "·".
	const [back] = lua(`Polestar.Set("ui.font", "game")\nPolestar.Set("ui.font", "skin")\n${STRING}`, RU);
	assert.equal(back.count, `2/20 ${DOT} 2/3`);
});

test('#4015: Polestar\'s tooltip lines and chat lines take "-" where the client\'s font has no "·"', () => {
	const script = `local fs = UIParent:CreateFontString("PsTipTextLeft1", "OVERLAY")
fs:SetFont(STANDARD_TEXT_FONT, 12, "")
fs:SetText("Dungeon \\194\\183 Levels 15-20")
local tip = { GetName = function() return "PsTip" end, NumLines = function() return 1 end }
Polestar.Theme.TipDots(tip)
GameTooltipText = { GetFont = function() return STANDARD_TEXT_FONT, 12, "" end }
local added = {}
Polestar.Hooks.AddLine({ AddDoubleLine = function(_, l, r) added[#added + 1] = l .. "|" .. r end }, "Polestar", "+3% \\194\\183 Head")
DEFAULT_CHAT_FRAME.GetFont = function() return STANDARD_TEXT_FONT, 14, "" end
Polestar.Print("a \\194\\183 b")
emit({ tip = fs:GetText(), line = added[1], chat = stub.messages[#stub.messages] })`;
	const [ru] = lua(script, RU);
	assert.equal(ru.tip, 'Dungeon - Levels 15-20');
	assert.equal(ru.line, 'Polestar|+3% - Head');
	assert.match(ru.chat, /a - b$/);
	const [en] = lua(script);
	assert.equal(en.tip, `Dungeon ${DOT} Levels 15-20`);
	assert.equal(en.line, `Polestar|+3% ${DOT} Head`);
	assert.match(en.chat, new RegExp(`a ${DOT} b$`));
});

test('every Polestar tooltip goes through Theme.TipDots before it shows', () => {
	const out = [];
	const walk = (dir) => {
		for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
			const p = path.join(dir, e.name);
			if (e.isDirectory()) walk(p);
			else if (e.name.endsWith('.lua')) out.push(p);
		}
	};
	for (const a of ['Polestar', 'Polestar_Options', 'Polestar_Skins']) walk(path.join(ADDON, a));
	const missing = [];
	for (const f of out) {
		const lines = fs.readFileSync(f, 'utf8').split('\n');
		lines.forEach((l, i) => {
			const m = l.match(/^\s*(GameTooltip|tip):Show\(\)/);
			if (m && !/TipDots\((GameTooltip|tip)\)/.test(lines[i - 1] || '') && !/LevelTip\.lua$/.test(f)) missing.push(`${path.relative(ROOT, f)}:${i + 1}`);
		});
	}
	assert.deepEqual(missing, []);
});
