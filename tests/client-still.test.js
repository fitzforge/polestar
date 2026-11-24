'use strict';
// Polestar Client draws nothing while nobody can see it (#1801: 0.1.6 kept 5-15% of a GPU busy
// while minimized beside the game). apps/client/src/lib/still.ts decides when the window is out of
// sight; app.css pauses every animation then; the only loops left anywhere are work indicators.
// Node strips the module's types.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { Stillness, STILL_AFTER_BLUR_MS } = require('../apps/client/src/lib/still.ts');

/** A clock and timers moved by hand. */
function clock() {
	let now = 0;
	let next = 1;
	const pending = new Map();
	return {
		timers: {
			now: () => now,
			set: (fn, ms) => (pending.set(next, { fn, at: now + ms }), next++),
			clear: (h) => pending.delete(h),
		},
		advance(ms) {
			now += ms;
			for (const [h, { fn, at }] of [...pending]) {
				if (at <= now && pending.delete(h)) fn();
			}
		},
		pending: () => pending.size,
	};
}

test('minimized, in the tray or a hidden page: still at once; back in sight: moving again', () => {
	const c = clock();
	const calls = [];
	const s = new Stillness((still) => calls.push(still), c.timers);
	s.update({ minimized: true, focused: false });
	s.update({ minimized: false, focused: true });
	s.update({ windowHidden: true, focused: false });
	s.update({ windowHidden: false, focused: true });
	s.update({ pageHidden: true });
	s.update({ pageHidden: false });
	assert.deepEqual(calls, [true, false, true, false, true, false]);
	assert.equal(c.pending(), 0, "nothing waits while it's out of sight or focused");
});

test('visible but unfocused (behind the game): still only after a while, and only once', () => {
	const c = clock();
	const calls = [];
	const s = new Stillness((still) => calls.push(still), c.timers);
	s.update({ focused: false });
	assert.deepEqual(calls, []);
	// Resizes and repeated blur reports while unfocused don't restart the wait.
	c.advance(STILL_AFTER_BLUR_MS - 1);
	s.update({ focused: false, minimized: false });
	assert.deepEqual(calls, []);
	c.advance(1);
	assert.deepEqual(calls, [true]);
	assert.equal(s.still, true);
	// Focused again: moving at once; the wait starts over on the next blur.
	s.update({ focused: true });
	assert.deepEqual(calls, [true, false]);
	s.update({ focused: false });
	c.advance(STILL_AFTER_BLUR_MS / 2);
	s.update({ focused: true });
	c.advance(STILL_AFTER_BLUR_MS);
	assert.deepEqual(calls, [true, false], 'a short look away changes nothing');
});

test('restored from the taskbar without the focus: moving, then still after the wait', () => {
	const c = clock();
	const calls = [];
	const s = new Stillness((still) => calls.push(still), c.timers);
	s.update({ minimized: true, focused: false });
	c.advance(STILL_AFTER_BLUR_MS * 3);
	s.update({ minimized: false });
	// It was unfocused all along: that time counts, so it stays still.
	assert.deepEqual(calls, [true]);
	s.update({ focused: true });
	assert.deepEqual(calls, [true, false]);
});

/** Every `animation:` shorthand in the Client's styles that repeats forever, as `file: selector`. */
function infiniteAnimations() {
	const root = path.join(__dirname, '../apps/client/src');
	const found = [];
	const walk = (dir) => {
		for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
			const p = path.join(dir, e.name);
			if (e.isDirectory()) walk(p);
			else if (/\.(svelte|css)$/.test(e.name)) {
				const text = fs.readFileSync(p, 'utf8');
				for (const m of text.matchAll(/([^{}]+)\{[^{}]*\banimation(?:-iteration-count)?\s*:[^;{}]*\binfinite\b/g)) {
					found.push(`${path.relative(root, p).replaceAll('\\', '/')}: ${m[1].trim().split('\n').pop().trim()}`);
				}
			}
		}
	};
	walk(root);
	return found.sort();
}

test('only work in progress loops: nothing repeats forever on a page left open', () => {
	assert.deepEqual(infiniteAnimations(), [
		// Waiting for the background service's first answer.
		'App.svelte: .starting-mark',
		// The status light while sending.
		'components/Beacon.svelte: .arc',
		// Progress of unknown length: a guide installing, checking, updating.
		'components/PackSheet.svelte: .indeterminate .fill',
		'screens/Addons.svelte: .indeterminate .fill',
		'screens/Addons.svelte: .turn.spinning',
		'screens/Community.svelte: .indeterminate .fill',
		'screens/Community.svelte: .turn.spinning',
		'styles/app.css: .spinner',
	]);
	const css = fs.readFileSync(path.join(__dirname, '../apps/client/src/styles/app.css'), 'utf8');
	assert.match(css, /html\.still \*,\s*html\.still \*::before,\s*html\.still \*::after \{\s*animation-play-state: paused !important;/, 'out of sight, even those hold still');
});
