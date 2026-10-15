'use strict';
// The guide window's "Along the way" section (docs/parity plan, Phase 2,
// Task 2.3), end to end: a guide compiled from DSL with an `along` step,
// loaded by the real addon (Core, Theme, Nav, UI), driven in the stub world.
// Along steps are listed under the card while the route is past them, and
// never named by "Then:" or the Up next list.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ROOT } = require('./helpers/lua');
const { compileSources } = require('../tools/lib/dsl/project');
const { loadData } = require('../tools/lib/dsl/data');
const { format } = require('../tools/lib/dsl/diag');
const { writeTestPack } = require('./helpers/dsl');

const DATA = path.join(ROOT, 'tests', 'fixtures', 'dsl', 'data');

const GUIDE = `guide forever/alliance/human/01-northshire
title Northshire Valley
faction Alliance
race Human
levels 1-6
zone Elwynn Forest

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
  accept 7

step Kobolds on the way
  along until back
  kill 6 x10 quest 7.1

step Kobold camp
  goto 47.6,35.1 "Kobold camp"

step Back to the abbey
  label back
  turnin 7
`;

function compilePack() {
	const data = loadData(DATA);
	const { guides, diag } = compileSources([{ file: 'along.guide', text: GUIDE }], data);
	assert.deepEqual(diag.errors.map(format), []);
	return writeTestPack(guides, data);
}

test('along goals show under the card while the route is past them; Then and Up next skip along steps', () => {
	const { dir, scripts } = compilePack();
	try {
		const loads = `do local ns = {}\n${scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n')}\nend`;
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `
				local w = stub.world
				w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
				w.moveTo(1429, 48.5, 42.5)`,
			addons: ['Polestar'],
			script: `
				${loads}
				Polestar.Set("ui.upcoming", 3)
				Polestar.Set("ui.upcomingOpen", true)
				stub.login()
				stub.advance(0.5)
				local w = stub.world
				local GF = Polestar.UI.GuideFrame
				local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
				local function snap(label)
					local A = GF.parts.along
					local rows, ups = {}, {}
					for _, r in ipairs(GF.alongRows) do
						if r:IsShown() then rows[#rows + 1] = { text = plain(r.Text:GetText()), step = r.psStep, goal = r.psGoal } end
					end
					for _, r in ipairs(GF.upRows) do if r:IsShown() then ups[#ups + 1] = r.psIndex end end
					emit({
						label = label,
						step = Polestar.Engine.GetStepIndex(),
						shown = A:IsShown(),
						header = A:IsShown() and plain(A.Label:GetText()) or false,
						rows = rows,
						after = plain(GF.parts.after.Text:GetText()),
						upnext = ups,
					})
				end
				snap("login")
				w.accept(783, {}, "A Threat Within")
				stub.advance(0.5)
				w.turnIn(783)
				w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
				stub.advance(0.5)
				snap("on 7")
				w.progress(7, 1, 4)
				stub.advance(0.5)
				snap("4 kills")
				Polestar.Set("ui.compact", true)
				stub.advance(0.1)
				snap("compact")
				Polestar.Set("ui.compact", false)
				w.moveTo(1429, 47.6, 35.1)
				stub.advance(1)
				snap("at back")`,
		});
		const [login, onSeven, kills, compact, atBack] = emitted;

		// Step 1: nothing is along yet; Up next skips the along step 3.
		assert.equal(login.step, 1);
		assert.equal(login.shown, false);
		assert.equal(login.after, 'Then: Marshal McBride');
		assert.deepEqual(login.upnext, [2, 4, 5]);

		// Accepting 7 passes over the along step: step 4, with the kobolds along the way.
		assert.equal(onSeven.step, 4);
		assert.equal(onSeven.shown, true);
		assert.equal(onSeven.header, 'Along the way');
		assert.equal(onSeven.rows.length, 1);
		assert.match(onSeven.rows[0].text, /Kobold Vermin/);
		assert.match(onSeven.rows[0].text, /0\/10$/);
		assert.deepEqual([onSeven.rows[0].step, onSeven.rows[0].goal], [3, 1]);

		// Progress updates in place (an along goal's progress must refresh the window).
		assert.equal(kills.step, 4);
		assert.match(kills.rows[0].text, /4\/10$/);

		// Compact mode hides the section.
		assert.equal(compact.shown, false);

		// Arriving at the camp reaches the labelled step, which ends it.
		assert.equal(atBack.step, 5);
		assert.equal(atBack.shown, false);
		assert.equal(Object.keys(atBack.rows).length, 0); // the Lua stub encodes an empty list as {}
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});
