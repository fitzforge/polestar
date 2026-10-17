'use strict';
// End to end: a guide compiled by the real toolchain from DSL source, loaded by
// the real addon (Core, Theme, Nav, UI together, no fakes), driven through a
// quest flow in the stub world. Each module's own tests fake its neighbours;
// this is where the Engine view model, the UI rows, the Nav arrow and the
// compiler's output have to agree.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ROOT } = require('./helpers/lua');
const { compileSources } = require('../tools/lib/dsl/project');
const { loadData } = require('../tools/lib/dsl/data');
const { format } = require('../tools/lib/dsl/diag');
const { writeTestPack, groupData } = require('./helpers/dsl');

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

step Kobold camp
  goto 47.6,35.1 "Kobold camp"
  kill 6 x10 quest 7.1

step Back to the abbey
  turnin 7
`;

// Compile GUIDE into our pack on disk; return the Lua files in TOC order.
function compilePack() {
	const data = loadData(DATA);
	const { guides, diag } = compileSources([{ file: 'e2e.guide', text: GUIDE }], data);
	assert.deepEqual(diag.errors.map(format), []);
	const { dir, scripts } = writeTestPack(guides, data);
	return { dir, order: scripts };
}

test('a compiled guide drives the real engine, guide window and arrow through a quest flow', () => {
	const { dir, order } = compilePack();
	try {
		const loads = `do local ns = {}\n${order.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n')}\nend`;
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `
				local w = stub.world
				w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
				w.moveTo(1429, 48.5, 42.5)`,
			addons: ['Polestar'],
			script: `
				${loads}
				stub.login()
				stub.advance(0.5)
				local w = stub.world
				local GF = Polestar.UI.GuideFrame
				local function snap(label)
					local rows = {}
					for i, r in ipairs(GF.rows) do
						if r:IsShown() then
							local plain = r.Text:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
							rows[#rows + 1] = { text = plain, progress = plain:match("(%d+/%d+)$") or "" }
						end
					end
					local t = Polestar.Nav.GetTarget()
					emit({
						label = label,
						guide = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id,
						step = Polestar.Engine.GetStepIndex(),
						card = GF.parts.person.Name:GetText(),
						cardShown = GF.parts.card:IsShown(),
						emptyTitle = GF.parts.empty:IsShown() and GF.parts.empty.Title:GetText() or nil,
						rows = rows,
						target = t and { x = t.x, y = t.y, label = t.label } or false,
						arrow = PolestarNavArrow:IsShown(),
						distance = Polestar.Nav.GetDistance() and math.floor(Polestar.Nav.GetDistance() + 0.5) or false,
					})
				end
				snap("login")
				w.accept(783, {}, "A Threat Within")
				stub.advance(0.5)
				snap("accepted 783")
				w.turnIn(783)
				w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
				stub.advance(0.5)
				snap("on 7, heading to camp")
				w.moveTo(1429, 47.6, 35.1)
				stub.advance(1)
				w.progress(7, 1, 4)
				stub.advance(0.5)
				snap("at camp, 4 kills")
				w.progress(7, 1, 10)
				w.finish(7)
				stub.advance(0.5)
				snap("objectives done")
				w.turnIn(7)
				stub.advance(0.5)
				snap("guide done")`,
		});
		const [login, accepted, onSeven, atCamp, objectivesDone, done] = emitted;
		const texts = (s) => s.rows.map((r) => r.text);

		// Login: the guide is suggested for a level-1 Human and its first step shows.
		assert.equal(login.guide, 'forever/alliance/human/01-northshire');
		assert.equal(login.step, 1);
		assert.equal(login.card, 'Deputy Willem');
		assert.ok(texts(login).some((t) => /A Threat Within/.test(t)), JSON.stringify(login.rows));
		assert.deepEqual([login.target.x, login.target.y], [48.17, 42.94]);
		assert.equal(login.arrow, true);
		assert.ok(login.distance > 0, 'arrow measures a distance to Deputy Willem');

		// Accepting 783 moves the window and the arrow to Marshal McBride.
		assert.equal(accepted.step, 2);
		assert.equal(accepted.card, 'Marshal McBride');
		assert.deepEqual([accepted.target.x, accepted.target.y], [48.92, 41.61]);

		// After the hand-in, the arrow leads to the kobolds themselves (the
		// nearest place they spawn), not the camp's Go to, which is the step's
		// header.
		assert.equal(onSeven.step, 3);
		assert.equal(onSeven.card, 'Kobold camp');
		assert.deepEqual([onSeven.target.x, onSeven.target.y], [45.1, 33.9]);

		// Arriving completes the goto; the kill goal shows live progress.
		assert.equal(atCamp.step, 3);
		const killRow = atCamp.rows.find((r) => /Kobold Vermin/.test(r.text));
		assert.ok(killRow, JSON.stringify(atCamp.rows));
		assert.equal(killRow.progress, '4/10');

		assert.equal(objectivesDone.step, 4);
		assert.equal(objectivesDone.card, 'Marshal McBride', 'the window names the person to hand in to');

		// Turning in the last quest completes the guide; the window says so.
		assert.equal(done.emptyTitle, 'Guide complete');
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

// Group content: the compiler derives `group` from the data (dungeon and raid
// quests, elites) or takes the author's `group 3`; the guide window says it
// under the goal, once per run, and the guide menu tags the guide "Group".
const GROUP_GUIDE = `guide forever/class/hollow
title The Hollow Deeps
category Class
faction Alliance
levels 1-60
zone Elwynn Forest

step Marshal McBride
  accept 9600
  accept 9603
  accept 9601
  accept 9602

step Kobolds
  kill 95003 group 3
  kill 95003 "Kill the Elite Kobold again"
`;

test('a compiled guide with group content shows the group line once per run and the menu\'s Group chip', () => {
	const data = groupData();
	const { guides, diag } = compileSources([{ file: 'e2e.guide', text: GUIDE }, { file: 'hollow.guide', text: GROUP_GUIDE }], data);
	assert.deepEqual(diag.errors.map(format), []);
	const { dir, scripts } = writeTestPack(guides, data);
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
				stub.login()
				stub.advance(0.5)
				local w, GF = stub.world, Polestar.UI.GuideFrame
				local DUNGEON = "|c" .. Polestar.Theme.Hex("dungeon")
				local function subs()
					local out = {}
					for _, r in ipairs(GF.rows) do
						if r:IsShown() then
							local sub = r.Sub:IsShown() and r.Sub:GetText() or ""
							out[#out + 1] = { sub = sub:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), coloured = sub:find(DUNGEON, 1, true) == 1 }
						end
					end
					return out
				end
				Polestar.Engine.SetGuide("forever/class/hollow")
				stub.advance(0.5)
				local accepts = subs()
				for _, q in ipairs({ 9600, 9603, 9601, 9602 }) do w.accept(q, {}) end
				stub.advance(0.5)
				local kills = subs()
				Polestar.UI.ShowPicker()
				Polestar.UI.Picker.SetCategory("All")
				local chips = {}
				for _, f in ipairs(stub.frames) do
					if f.psGuide and rawget(f, "Range") and f:IsShown() then
						chips[f.psGuide.id] = f.Group:IsShown() and f.Group.Text:GetText() or false
					end
				end
				Polestar.UI.Picker.Select("forever/class/hollow")
				local details = {}
				for _, c in ipairs(Polestar.UI.Picker.details.Chips) do if c:IsShown() then details[#details + 1] = c.Text:GetText() end end
				emit({ accepts = accepts, kills = kills, chips = chips, details = details })`,
		});
		const [out] = emitted;
		const dungeon = { sub: 'Dungeon: Hollow Deeps', coloured: true };
		const none = { sub: '', coloured: false };
		// Two quests in the Hollow Deeps say it once; the raid quest names its
		// raid; the breadcrumb with the dungeon's area is done outside.
		assert.deepEqual(out.accepts, [dungeon, none, { sub: 'Raid: Molten Core', coloured: true }, none]);
		// The author's group size wins over the elite the data names.
		assert.deepEqual(out.kills, [{ sub: 'Group of 3 advised', coloured: true }, { sub: 'Elite: group advised', coloured: true }]);
		assert.deepEqual(out.chips, { 'forever/class/hollow': 'Group', 'forever/alliance/human/01-northshire': false });
		assert.deepEqual(out.details.slice(0, 2), ['Levels 1\u201360', 'Group']);
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

// The Map page is assembled from several modules: the options window
// declares its tabs and sections, and Nav, Quests, Rares and Maps fill them
// by name. A name that drifts would open a stray section or tab.
test('the Map page gathers every map setting from its modules into the declared tabs and sections', () => {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `
			stub.login()
			local O = Polestar.UI.Options
			Polestar.UI.ShowOptions("map")
			local tabs = {}
			for _, p in ipairs(O.Pages()) do if p.key == "map" then tabs = p.tabs end end
			local out = { tabs = tabs, sections = {}, keys = {} }
			for _, t in ipairs(tabs) do
				O.Select("map", t)
				local heads = {}
				for _, h in ipairs(O.view.headers) do if h:IsShown() then heads[#heads + 1] = h.Text:GetText() end end
				local keys = {}
				for k in pairs(O.Controls("map", t)) do keys[#keys + 1] = k end
				table.sort(keys)
				out.sections[t], out.keys[t] = heads, keys
			end
			emit(out)`,
	});
	const [out] = emitted;
	assert.deepEqual(out.tabs, ['Guide & quests', 'Rares & travel', 'Zones']);
	assert.deepEqual(out.sections, {
		'Guide & quests': ['Guide', 'Quest markers'],
		'Rares & travel': ['Rares and treasures', 'Dungeons and travel'],
		Zones: ['Zones', 'Coordinates'],
	});
	assert.deepEqual(out.keys['Guide & quests'], [
		'maps.minimapButton', 'nav.minimapPins', 'nav.trailDots', 'nav.worldPins', 'qol.availableQuests', 'qol.guideDim', 'qol.guideHighlight', 'qol.lowLevelQuests',
		'qol.mapObjectives', 'qol.minimapObjectives', 'qol.objectiveAreas', 'qol.questLevelWindow', 'qol.turnInMarkers',
	]);
	assert.deepEqual(out.keys['Rares & travel'], [
		'maps.dockPins', 'maps.dungeonPins', 'maps.innPins', 'maps.taxiPins', 'maps.travelMinimap',
		'rares.hideGrey', 'rares.minimapRares', 'rares.minimapTreasures', 'rares.worldRares', 'rares.worldTreasures',
	]);
	assert.deepEqual(out.keys.Zones, ['maps.coords', 'maps.minimapCoords', 'maps.reveal', 'maps.zoneLevels']);
});
