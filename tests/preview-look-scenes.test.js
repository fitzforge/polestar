'use strict';
// The Look pages' preview scenes (`node tools/polestar.js preview`, docs/preview/settings-*.svg) draw what the
// live settings window draws. The UI stub stands a fake Nav in for the real one; the scenes keep Nav's own arrow and
// travel prompts on it (REAL_NAV_PARTS), and without them the Buttons page would silently lose the travel button's
// row beside the Hearthstone and the travel button under the arrow in its preview.

const test = require('node:test');
const assert = require('node:assert/strict');
const P = require('../tools/commands/preview');

const prelude = P.metricsLua(P.loadFonts());

// The strings a panel shows.
function texts(scene, i) {
	const panel = P.SCENES.find((s) => s.file === scene).panels[i];
	try {
		const dump = P.dumpPanel(panel, prelude);
		return dump.objects.filter((o) => o.kind === 'FontString' && o.text && o.shown).map((o) => o.text.replace(/\|c[0-9a-fA-F]{8}|\|r/g, '').trim());
	} finally {
		P.cleanupPacks();
	}
}

test('the Buttons page scene shows the Hearthstone beside the travel button under the arrow, and draws both', () => {
	const t = texts('settings-buttons.svg', 1);
	for (const s of ['Hearthstone', 'Travel button under the arrow', 'Travel button', 'Goldshire']) {
		assert.ok(t.includes(s), `"${s}" in the Action buttons scene: ${t.join(' | ')}`);
	}
});
