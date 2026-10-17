'use strict';
// Text stays inside its window. Every scene of `node tools/polestar.js
// preview` that shows one of Polestar's windows (the guide window, the hub on
// each section, Options on every page and tab, the welcome, the route
// choice, the rare alert, the report window and the copy window) is laid out
// through the preview's frame dump, in the game font and in Inter, and every
// visible string is checked against its window's edges and the frames that
// clip it.
//
// In game the client's font sets text about 13% wider than the preview's
// Inter metrics predict, so every glyph is measured 15% wider than the
// preview draws it, by the Lua (GetStringWidth: what the UI sizes and fits
// by at runtime) and by the check alike. A string bound in width (two
// anchors or SetWidth) is cut or wrapped by the client, so only its box has
// to fit; a wrapping one may grow in height, and outside a scroll area that
// growth has to fit too.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const P = require('../tools/commands/preview');
const { audit, describe, fontsFor, PASSES } = require('../tools/preview/fit');

const SLACK = 1.15;
const WINDOWS = new Set(['PolestarGuideFrame', 'PolestarOptions', 'PolestarPicker', 'PolestarWelcome', 'PolestarRouteChoice', 'PolestarMenu', 'PolestarRareToast', 'PolestarReport', 'PolestarCopy']);

// The preview's fonts, every advance SLACK times wider.
const fonts = fontsFor(SLACK);
const prelude = P.metricsLua(fonts);

function auditPanels(label, panels) {
	const found = [];
	try {
		panels.forEach((p, i) => {
			for (const [font, prefix] of PASSES) {
				const dump = P.dumpPanel({ ...p, script: prefix + p.script }, prelude);
				for (const f of audit(dump, p.roots, fonts, ['window'])) found.push(`${label} #${i + 1} (${font}): ${describe(f)}`);
			}
		});
	} finally {
		P.cleanupPacks();
	}
	return found;
}

const windowed = P.SCENES.filter((s) => s.panels.every((p) => p.roots.every((r) => WINDOWS.has(r))));

test('the audit covers the hub, Options, the guide window and the welcome', () => {
	const roots = new Set(windowed.flatMap((s) => s.panels.flatMap((p) => p.roots)));
	for (const r of ['PolestarGuideFrame', 'PolestarOptions', 'PolestarPicker', 'PolestarWelcome']) assert.ok(roots.has(r), r);
	const scripts = windowed.flatMap((s) => s.panels.map((p) => p.script)).join('\n');
	for (const section of ['Polestar.Lookup.Show', 'Polestar.Dungeons.Open', 'Polestar.Rares.Show', 'Polestar.UI.ShowPicker', '"guidepacks"']) {
		assert.ok(scripts.includes(section), section);
	}
});

for (const scene of windowed) {
	test(`text fits: ${scene.file}`, () => {
		const found = auditPanels(scene.file, scene.panels);
		assert.deepEqual(found, [], `text outside its window:\n${found.join('\n')}`);
	});
}

// Options on every page and tab, with every module's pages and the Recorder.
test('text fits: every Options page and tab', () => {
	const recorder = P.SCENES.find((s) => s.file === 'options-more.svg').panels[0].before;
	const pages = runAddon({
		stubs: ['stub_ui.lua'],
		before: recorder,
		addons: [{ name: 'Polestar', files: P.MODULE_FILES }],
		script: 'uistub.install()\nstub.login()\nemit(Polestar.UI.Options.Pages())',
	}).emitted[0];
	assert.ok(pages.length >= 8, `${pages.length} pages`);
	const panels = [];
	for (const p of pages) {
		const tabs = Array.isArray(p.tabs) && p.tabs.length ? p.tabs : [null];
		for (const t of tabs) {
			const select = t ? `; Polestar.UI.Options.Select(${JSON.stringify(p.key)}, ${JSON.stringify(t)})` : '';
			panels.push({ files: P.MODULE_FILES, before: recorder, roots: ['PolestarOptions'], name: `${p.key}${t ? ' > ' + t : ''}`, script: `Polestar.UI.ShowOptions(${JSON.stringify(p.key)})${select}` });
		}
	}
	const found = [];
	for (const panel of panels) found.push(...auditPanels(`Options ${panel.name}`, [panel]).map((l) => l.replace(/ #1 /, ' ')));
	assert.deepEqual(found, [], `text outside its window:\n${found.join('\n')}`);
});
