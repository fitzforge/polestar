'use strict';
// The Look pages' preview scenes (`node tools/polestar.js preview`, docs/preview/settings-*.svg) draw what the
// live settings window draws. The UI stub stands a fake Nav in for the real one; the scenes keep Nav's own arrow and
// travel prompts on it (REAL_NAV_PARTS), and without them the Buttons page would silently lose the travel button's
// row beside the Hearthstone and the travel button under the arrow in its preview.

const test = require('node:test');
const assert = require('node:assert/strict');
const P = require('../tools/commands/preview');

const prelude = P.metricsLua(P.loadFonts());

// The strings a panel shows, after its own script and `then` (more Lua run on the panel as it stands).
function texts(scene, i, then = '') {
	const base = P.SCENES.find((s) => s.file === scene).panels[i];
	const panel = then ? { ...base, script: `${base.script}\n${then}` } : base;
	try {
		const dump = P.dumpPanel(panel, prelude);
		return dump.objects.filter((o) => o.kind === 'FontString' && o.text && o.shown).map((o) => o.text.replace(/\|c[0-9a-fA-F]{8}|\|r/g, '').trim());
	} finally {
		P.cleanupPacks();
	}
}

// The Action buttons tab's preview is a band of the button sets (#2084), whose dropdown picks the travel button
// instead, alone: the pick is there only with Nav's own travel prompts in the scene.
const PICK_TRAVEL = `local O = Polestar.UI.Options
local host = O.view and rawget(O.view, "PreviewHost")
local f = host and host.Frame
if f and f.Pick then f.Pick("travel"); Polestar.UI.Preview.Again(f) end
stub.advance(0.1)`;

test('the Buttons page shows the Hearthstone beside the travel button under the arrow, and its band picks the travel button', () => {
	const t = texts('settings-buttons.svg', 1, PICK_TRAVEL);
	for (const s of ['Hearthstone', 'Travel button under the arrow', 'Travel button']) {
		assert.ok(t.includes(s), `"${s}" on the Action buttons tab: ${t.join(' | ')}`);
	}
});
