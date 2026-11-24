'use strict';
// Translated text the windows outside Settings used to cut, laid out in
// German, Russian and Korean as `i18n fit` lays them out (tools/preview/fit.js:
// the client's font set about 15% wider than the preview's, CJK and Hangul
// 1em), and in English. Install's first page keeps its guide window and arrow
// miniatures whole ("Geh zu Goldshire" on two lines), and Your look its looks'
// goal lines with their counts ("Töte Kobold Vermin 10/10"); Characters its labels
// and guide lines ("Камень возвращения", "Darkshore (16-21) · Schritt 16 von
// 43"); the class quest card its class line ("Друид · УРОВЕНЬ 20" beside a
// long badge goes under it); the route choice its facts (the quests' number
// alone beside their glyph where the language writes it after the word,
// "заданий: 43", before anything is cut). Other text these windows
// cut by design (a step's tips folded to a line, a card's pros and cons, the
// next guide's title on a card) is not this test's, nor a box sized to its
// own text that the fit's font measures under a pixel wider than the
// client's ("≈10 min" by 0.6px in English too).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const P = require('../tools/commands/preview');
const { audit, describe, fontsFor, localeCodepoints, localeLua, interfaceFile } = require('../tools/preview/fit');
const { LOCALES } = require('../tools/lib/i18n/locales');

const fonts = fontsFor(1.15);
const shipped = Object.keys(LOCALES).map(interfaceFile);

// Scene file -> { the panels (1-based) to lay out, which of their findings are this test's (by finding and panel) }.
const SCENES = {
	// Install's first page whole; on Your look, the looks' guide windows keep each goal's line and count ("Kill Kobold
	// Vermin 10/10") whole.
	'welcome.svg': { panels: [1, 4], mine: (f, i) => i === 1 || /\d+\/\d+$/.test(f.text) },
	'characters.svg': { panels: [1, 2], mine: () => true },
	// The class line: "<CLASS> · LEVEL <n>" in the client's words.
	'guide-class-card.svg': { panels: [1, 2], mine: (f) => /\u00b7\s*\S+\s+\d+$/.test(f.text) },
	// The facts row: the levels, the trip, the quests, each a short string beside its glyph.
	'route-choice.svg': { panels: [1, 2], mine: (f) => f.box != null && f.box < 100 && /\d/.test(f.text) },
};

function findings(locale) {
	const prelude = `${P.metricsLua(fonts, localeCodepoints(shipped))}\n${localeLua(locale)}`;
	const out = [];
	try {
		for (const [file, { panels, mine }] of Object.entries(SCENES)) {
			const scene = P.SCENES.find((s) => s.file === file);
			assert.ok(scene, file);
			for (const i of panels) {
				const p = scene.panels[i - 1];
				const dump = P.dumpPanel({ ...p, script: `Polestar.Set("ui.font", "game")\n${p.script}` }, prelude);
				for (const f of audit(dump, p.roots, fonts, ['cut', 'lines', 'window'])) if (mine(f, i) && f.over >= 1) out.push(`${file} #${i}: ${describe(f)}`);
			}
			P.cleanupPacks();
		}
	} finally {
		P.cleanupPacks();
	}
	return out;
}

for (const locale of ['enUS', 'deDE', 'ruRU', 'koKR']) {
	test(`Install's first page, Characters, the class card's class line and the route choice's facts keep whole in ${locale}`, () => {
		assert.deepEqual(findings(locale), []);
	});
}
