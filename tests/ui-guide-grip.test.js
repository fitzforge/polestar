'use strict';
// The guide window's width grip as the player finds it: in the playground
// (tools/play, the real addons with the client's layout and mouse focus), the
// window's bottom-right corner is the grip's, it shows under the cursor, and a
// drag from there widens the window, in Polestar's own layout and in Atlas,
// opaque and transparent, with Grow upward too (0.4.3-rc put the grip over the
// top edge then, and the corner moved the window). Needs data/forever.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { tmpdir } = require('./helpers/tmp');
const { Session } = require('../tools/play/session');
const { hitTest } = require('../tools/play/public/hit');

const skip = needs('races.json');

async function corner(sets) {
	const dataDir = tmpdir('polestar-grip-');
	const s = new Session({ dataDir });
	await s.start();
	try {
		for (const [k, v] of sets) await s.act({ type: 'set', path: k, value: v });
		const f = await s.act({ type: 'open', what: 'guide' });
		assert.equal(f.errors.length, 0, JSON.stringify(f.errors));
		const win = f.hits.find((h) => h.n === 'PolestarGuideFrame');
		assert.ok(win, 'the guide window is on screen');
		// 4 px in from the window's bottom-right corner, where the player grabs it.
		const x = win.r[0] + win.r[2] - 4, y = win.r[1] + win.r[3] - 4;
		const top = hitTest(f.hits, x, y);
		const ids = f.hits.map((h) => h.id).join(',');
		const grip = (await s.call(`for _, id in ipairs({ ${ids} }) do if preview.object(id) == Polestar.UI.GuideFrame.grip then return id end end`)).value;
		await s.act({ type: 'hover', id: top.id, x, y });
		const shown = (await s.call('local g = Polestar.UI.GuideFrame.grip return { shown = g:IsVisible(), alpha = g:GetAlpha() }')).value;
		await s.act({ type: 'dragStart', id: top.id, x, y, x0: x, y0: y });
		await s.act({ type: 'dragMove', x: x + 60, y });
		await s.act({ type: 'dragStop', x: x + 60, y });
		const after = (await s.call('return { w = PolestarGuideFrame:GetWidth(), saved = Polestar.Get("ui.width") }')).value;
		return { focusIsGrip: top.id === grip, shown, w0: Math.round(win.r[2]), ...after };
	} finally {
		await s.stop({ save: false });
		fs.rmSync(dataDir, { recursive: true, force: true });
	}
}

const LOOKS = { Standard: [], Atlas: [['ui.layout', 'atlas']] };
const STYLES = { opaque: [], transparent: [['ui.style', 'transparent']] };
const GROW = { 'grows down': [], 'Grow upward': [['ui.growUp', true], ['ui.pos', [1500, 26]]] };

for (const [look, l] of Object.entries(LOOKS)) {
	for (const [style, st] of Object.entries(STYLES)) {
		for (const [grow, g] of Object.entries(GROW)) {
			test(`${look}, ${style}, ${grow}: the window's bottom-right corner is the grip's, it shows under the cursor, and a drag from it widens the window`, { skip, timeout: 60000 }, async () => {
				const c = await corner([...l, ...st, ...g]);
				assert.equal(c.focusIsGrip, true, `the corner takes the grip: ${JSON.stringify(c)}`);
				assert.deepEqual(c.shown, { shown: true, alpha: 1 });
				assert.equal(c.w0, 340);
				assert.deepEqual({ w: c.w, saved: c.saved }, { w: 400, saved: 400 }, 'the drag widens the window by as much');
			});
		}
	}
}
