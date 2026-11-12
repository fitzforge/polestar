'use strict';
// "About" before a time or count (#1906): "≈" where the face draws it, "~"
// where it has none (Theme.Approx). The game font draws "~" level with the
// digits' tops ("Stormwind ~0:38"); its "≈" sits mid-height. The sign is
// never inside a translated string: each site passes it in.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { Font } = require('../tools/preview/font');
const { runAddon, ROOT } = require('./helpers/lua');

const ADDON = path.join(ROOT, 'addon');
const APPROX = '\u2248';

// Every font file the addon folders bundle (Polestar's faces, the skins').
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

test('every bundled font has "≈", and Theme.Approx counts it as one that does', () => {
	const fonts = bundledFonts();
	assert.ok(fonts.length >= 11, `bundled fonts found: ${fonts.length}`);
	const [listed] = lua('local t = {}; for k in pairs(Polestar.Theme.APPROX_FACES) do t[#t + 1] = k end; table.sort(t); emit(t)');
	for (const f of fonts) {
		assert.ok(new Font(f).glyphId(0x2248) > 0, `${path.relative(ROOT, f)} has no "≈"`);
		assert.ok(listed.includes(path.basename(f).toLowerCase()), `${path.basename(f)} is not in Theme.APPROX_FACES`);
	}
});

test('Theme.Approx: "≈" for a face with it, "~" for the ruRU client font and a face Polestar does not know', () => {
	const [out] = lua(`local T = Polestar.Theme
emit({
	body = T.Approx(),
	game = T.Approx("Fonts\\\\FRIZQT__.TTF"),
	cyr = T.Approx("Fonts\\\\FRIZQT___CYR.TTF"),
	ko = T.Approx("Fonts\\\\2002.TTF"),
	other = T.Approx("Interface\\\\AddOns\\\\SomeSkin\\\\Fonts\\\\Fancy.ttf"),
})`);
	assert.deepEqual(out, { body: APPROX, game: APPROX, cyr: '~', ko: '~', other: '~' });
});

test('the flight timer\'s estimate takes the sign of the face it is drawn in', () => {
	const [inter] = lua('emit(Polestar.Maps.FlightTimeText("estimate", 38))');
	assert.equal(inter, `${APPROX}0:38`);
	const [game] = lua('Polestar.Set("ui.font", "game"); emit(Polestar.Maps.FlightTimeText("estimate", 38))');
	assert.equal(game, `${APPROX}0:38`, 'the enUS game font has "≈"');
	// ruRU with the game font picked (Theme.FontSpec keeps a font the player chose): FRIZQT___CYR, no "≈".
	const [ru] = lua('Polestar.Set("ui.font", "game"); emit({ face = Polestar.Theme.FontSpec("body"), text = Polestar.Maps.FlightTimeText("estimate", 38) })',
		'function GetLocale() return "ruRU" end\nSTANDARD_TEXT_FONT = "Fonts\\\\FRIZQT___CYR.TTF"');
	assert.deepEqual(ru, { face: 'Fonts\\FRIZQT___CYR.TTF', text: '~0:38' });
});

test('no player-visible "~" is written into the text at the sites: each takes Theme.Approx', () => {
	const sites = [
		'Polestar/Maps/FlightTimer.lua', 'Polestar/Maps/TravelPins.lua', 'Polestar/QoL/Death.lua',
		'Polestar/UI/GuideFrameStatus.lua', 'Polestar/UI/RouteChoice.lua', 'Polestar_Options/UI/Looks/Trackers.lua',
	];
	for (const rel of sites) {
		const code = fs.readFileSync(path.join(ADDON, rel), 'utf8').split('\n').filter((l) => !/^\s*--/.test(l)).join('\n');
		// A "~" inside a string literal that is not Lua's "~=".
		const hits = code.match(/"[^"\n]*~(?!=)[^"\n]*"/g) || [];
		assert.deepEqual(hits, [], `${rel} still writes "~" into its text`);
		assert.match(code, /Approx\(/, `${rel} takes the sign from Theme.Approx`);
	}
});
