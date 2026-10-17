'use strict';
// The browser playground (tools/play): the hit-testing the page uses, and a
// scripted session over HTTP against the real addons in a live Lua process.
// Needs data/forever (node tools/polestar.js data build); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { hitTest, toScreen } = require('../tools/play/public/hit');
const { tmpdir } = require('./helpers/tmp');

const skip = needs('races.json');

test('hit-testing picks the front-most mouse frame inside its clip', () => {
	const hits = [
		{ id: 1, r: [0, 0, 500, 500], m: 1 },
		{ id: 2, r: [100, 100, 100, 100], m: 1, w: 1 },
		{ id: 3, r: [100, 150, 100, 400], c: [0, 0, 500, 200], m: 1 }, // clipped below 200
		{ id: 4, r: [120, 120, 20, 20], w: 1 }, // wheel only
	];
	assert.equal(hitTest(hits, 130, 130).id, 2, 'the wheel-only frame on top takes no clicks');
	assert.equal(hitTest(hits, 130, 130, 'w').id, 4);
	assert.equal(hitTest(hits, 150, 180).id, 3, 'later frames are in front');
	assert.equal(hitTest(hits, 150, 300).id, 1, 'clipped-out part falls through');
	assert.equal(hitTest(hits, 600, 600), null);
	assert.equal(hitTest(hits, 50, 50, 'w'), null);
	// A 960x600 element showing 1920x1080 letterboxed: 0.5 scale, 30px bars.
	const p = toScreen({ left: 0, top: 0, width: 960, height: 600 }, { w: 1920, h: 1080 }, 480, 300);
	assert.deepEqual([p.x, p.y, p.scale], [960, 540, 0.5]);
});

async function act(base, action, known = 0) {
	const r = await fetch(`${base}api/act`, { method: 'POST', headers: { 'content-type': 'application/json' }, body: JSON.stringify({ action, known }) });
	assert.equal(r.status, 200);
	return r.json();
}

test('a scripted session: hub, a guide, a goal, a scheme change, the world map, then a clean stop', { skip, timeout: 120000 }, async () => {
	const { startServer } = require('../tools/play/server');
	const dataDir = tmpdir('polestar-play-test-');
	const play = await startServer({ port: 0, dataDir, artDir: null });
	try {
		let f = await act(play.url, { type: 'render' });
		assert.ok(f.svg.startsWith('<svg'), 'a frame is drawn');
		assert.ok(f.hits.some((h) => h.n === 'PolestarGuideFrame'), 'the guide window takes the mouse');
		assert.equal(f.state.player.level, 1);
		assert.ok(f.timing.total > 0);

		// The hub opens beside the guide window.
		f = await act(play.url, { type: 'open', what: 'hub' });
		assert.equal(f.state.hub, true);
		assert.ok(f.hits.some((h) => h.n === 'PolestarPicker'));

		// Pick and load a guide this character can play.
		const guides = await (await fetch(`${play.url}api/guides`)).json();
		const g = guides.find((x) => x.faction === f.state.player.faction && x.cat === 'Leveling' && (x.lo || 1) <= 2);
		assert.ok(g, 'a starter guide exists');
		f = await act(play.url, { type: 'loadGuide', guide: g.id });
		assert.equal(f.state.guide.id, g.id);
		const before = f.state.guide.goals.filter((x) => x.status === 'done').length + f.state.guide.step * 100;

		// Do a goal: the Engine sees the world change.
		f = await act(play.url, { type: 'goal' });
		assert.ok(['done', 'advanced'].includes(f.result), `goal result ${f.result}`);
		const after = f.state.guide.goals.filter((x) => x.status === 'done').length + f.state.guide.step * 100;
		assert.ok(after > before, 'the goal was completed');

		// The scheme, through the addon's own settings; the frame re-renders.
		const svgBefore = f.svg;
		f = await act(play.url, { type: 'set', path: 'ui.scheme', value: 'graphite' });
		assert.equal(f.state.look['ui.scheme'], 'graphite');
		assert.deepEqual(f.state.changed.find((c) => c[0] === 'ui.scheme'), ['ui.scheme', 'graphite']);
		assert.notEqual(f.svg, svgBefore);

		// Hovering a frame from the hit map runs its scripts without errors.
		const frame = f.hits.find((h) => h.n === 'PolestarGuideFrame');
		const hover = await act(play.url, { type: 'hover', id: frame.id, x: frame.r[0] + 5, y: frame.r[1] + 5 });
		assert.equal(hover.errors.length, 0);

		// The world map opens with the guide's pins on it and closes, without errors.
		f = await act(play.url, { type: 'open', what: 'map' });
		assert.equal(f.errors.length, 0);
		assert.ok(f.hits.some((h) => h.n === 'WorldMapFrameCloseButton'), 'the map is open');
		f = await act(play.url, { type: 'open', what: 'map' });
		assert.equal(f.errors.length, 0);
		assert.ok(!f.hits.some((h) => h.n === 'WorldMapFrameCloseButton'), 'and closed');

		// A Lua error is reported, never fatal.
		f = await act(play.url, { type: 'slash', text: '/run error("boom")' });
		assert.ok(f.errors.some((e) => /boom/.test(e.msg)));
		f = await act(play.url, { type: 'render' });
		assert.ok(f.svg.startsWith('<svg'));
	} finally {
		await play.close({ save: true });
	}
	// SavedVariables written on stop.
	const sv = fs.readFileSync(path.join(dataDir, 'SavedVariables', 'Polestar.lua'), 'utf8');
	assert.match(sv, /scheme = "graphite"/);
});
