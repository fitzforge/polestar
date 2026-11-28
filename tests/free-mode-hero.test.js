'use strict';
// The Free mode Main page's sky (Polestar_FreeMode/Hero.lua): each star's why line under its quest's title is one
// line in a label as wide as the star's slot. It keeps the strongest reasons that fit that width (Order.Why's order,
// "2 hand-ins at one stop · nearest" -> "2 hand-ins at one stop") instead of running past it into an ellipsis that
// nothing on the page opens. Measured as the client does, 15% wider than the preview's metrics, in every font.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const P = require('../tools/commands/preview');
const { fontsFor, PASSES } = require('../tools/preview/fit');
const { measure } = require('../tools/preview/render');

const fonts = fontsFor(1.15);
const prelude = P.metricsLua(fonts);
const plain = (s) => String(s).replace(/\|c[0-9a-fA-F]{8}|\|r/g, '').trim();

test("the Main page's star labels: every why line fits its label's width, in every font", () => {
	const panel = P.SCENES.find((s) => s.file === 'free-mode.svg').panels[1];
	const over = [];
	let seen = 0;
	try {
		for (const [font, prefix] of PASSES) {
			const dump = P.dumpPanel({ ...panel, script: prefix + panel.script }, prelude);
			const labels = dump.objects.filter((o) => o.kind === 'FontString' && o.shown && o.text && o.justifyH === 'CENTER' && o.w > 0 && !o.wrap
				&& /hand-ins? |nearest|started|pinned|ready to hand in|most XP|of your quests here|kept while you walk/.test(plain(o.text)));
			seen += labels.length;
			for (const o of labels) {
				const w = measure(fonts, o.font, plain(o.text));
				if (w > o.w + 0.5) over.push(`${font}: "${plain(o.text)}" ${w.toFixed(1)}px in ${o.w}px`);
			}
		}
	} finally {
		P.cleanupPacks();
	}
	assert.ok(seen >= PASSES.length, 'the sky shows its why lines');
	assert.deepEqual(over, [], 'a why line wider than its label');
});
