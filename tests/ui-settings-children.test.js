'use strict';
// A control's children (c.children, addon/Polestar_Options/UI/Options.lua):
// the settings that matter only while their parent is on, rows of its section
// that open indented under the parent's line while it is on and are left out
// while it is off; the parent's hollow ring while a closed child is changed;
// search, Reset and a jump reaching a closed child; two parents on one line
// open a block each. Against the real addon's modules and the fakes of
// tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

// A test page: Parent (ui.locked) with three children, Partner beside it, After
// under them. `script` runs with O the window, page() the page's rows by key
// and label, spec(label) a control's spec, at(w) a row's { x, top, shown }.
function onPage(script, controls) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			assert(Polestar.RegisterOptions({ page = "Kids", key = "kids", tab = "Tab", section = "Section", controls = {
			${controls || `				{ kind = "toggle", key = "ui.locked", label = "Parent", children = {
					{ kind = "toggle", key = "ui.growUp", label = "Child one" },
					{ kind = "toggle", key = "ui.barsBottom", label = "Child two" },
					{ kind = "toggle", key = "ui.wholeStep", label = "Child three" },
				} },
				{ kind = "toggle", key = "ui.notesOpen", label = "Partner" },
				{ kind = "toggle", key = "ui.upcomingOpen", label = "After" },
`}
			} }))
			Polestar.UI.ShowOptions("kids")
			local O = Polestar.UI.Options
			local function page() return O.Controls("kids", "Tab") end
			local function spec(label)
				for _, c in ipairs(O.AllControls()) do if c.label == label and c.page and c.page.key == "kids" then return c end end
			end
			local function at(w)
				if not w then return { shown = false } end
				local _, _, _, x = w:GetPoint(1)
				return { x = x, top = w.psTop, shown = w:IsShown() }
			end
			${script}`,
	}).emitted;
}

test('children open indented under the parent\'s line while it is on, and close when it is off', () => {
	const [out] = onPage(`
		local function state()
			local r = page()
			return { parent = at(r["ui.locked"]), one = at(r["ui.growUp"]), two = at(r["ui.barsBottom"]),
				three = at(r["ui.wholeStep"]), partner = at(r["ui.notesOpen"]), after = at(r["ui.upcomingOpen"]) }
		end
		local off = state()
		Polestar.Set("ui.locked", true)
		local on = state()
		Polestar.Set("ui.locked", false)
		emit({ off = off, on = on, again = state() })`);
	const { off, on, again } = out;
	assert.equal(off.one.shown, false, 'off: the children are left out');
	assert.equal(off.three.shown, false);
	assert.equal(off.partner.top, off.parent.top, 'the partner stands beside the parent');
	assert.ok(off.after.top > off.parent.top, 'the next row on the line after');
	assert.equal(on.one.shown, true, 'on: the children show');
	assert.equal(on.three.shown, true);
	assert.equal(on.partner.top, on.parent.top, 'the partner keeps its half beside the parent');
	assert.ok(on.one.top > on.parent.top, 'the children stand under the parent\'s line');
	assert.equal(on.one.x, on.parent.x + 24, 'indented 24 from the rows');
	assert.equal(on.two.top, on.one.top, 'in halves of their own');
	assert.ok(on.two.x > on.one.x);
	assert.ok(on.three.top > on.one.top, 'the third on a line of its own');
	assert.equal(on.three.x, on.one.x);
	assert.ok(on.after.top > on.three.top, 'the rows after move down under them');
	assert.equal(again.one.shown, false, 'off again: closed');
	assert.equal(again.after.top, off.after.top, 'and the rows after back where they were');
});

test('a closed child off its default rings its parent; reset clears it; search and a jump still reach it', () => {
	const [out] = onPage(`
		local parent = page()["ui.locked"]
		local function ring() local r = rawget(parent, "KidsRing"); return r ~= nil and r:IsShown() end
		local out = { clean = ring() }
		Polestar.Set("ui.barsBottom", true)
		out.ringed = ring()
		local tip = O.TipOf(spec("Parent"))(parent)
		out.tip = false
		for _, l in ipairs(tip) do if type(l) == "table" and tostring(l[1]):find("under it", 1, true) then out.tip = true end end
		Polestar.Set("ui.locked", true)
		out.openRing = ring()
		Polestar.Set("ui.locked", false)
		-- Search finds the closed child, dimmed with why.
		local groups = O.Search("Child two")
		out.found = false
		for _, g in ipairs(groups) do
			for _, c in ipairs(g.controls) do if c.key == "ui.barsBottom" then out.found = true end end
		end
		out.why = false
		for _, l in ipairs(O.TipOf(spec("Child two"))(page()["ui.barsBottom"] or parent)) do
			if type(l) == "table" and l[1] == "Turn on Parent first." then out.why = l[1] end
		end
		-- A jump to it lands on its parent's row while it is closed.
		local w = O.Jump(spec("Child two"))
		out.jump = w == parent
		-- The section's Reset takes the closed children too.
		O.ResetSection({ spec("Parent"), spec("Child one"), spec("Child two"), spec("Child three") })
		out.reset = Polestar.Get("ui.barsBottom")
		out.after = ring()
		emit(out)`);
	assert.equal(out.clean, false, 'no ring while every child is at its default');
	assert.equal(out.ringed, true, 'a changed child under a closed parent rings it');
	assert.equal(out.tip, true, 'and its tooltip says so');
	assert.equal(out.openRing, false, 'open, the child shows its own mark');
	assert.equal(out.found, true, 'search finds the closed child');
	assert.equal(out.why, 'Turn on Parent first.', 'dimmed, it says what to turn on');
	assert.equal(out.jump, true, 'a jump to a closed child lands on its parent');
	assert.equal(out.reset, false, 'Reset puts the closed child back');
	assert.equal(out.after, false, 'and the ring goes');
});

test('two parents on one line open their children a block each, in their order', () => {
	const [out] = onPage(`
		Polestar.Set("ui.locked", true)
		Polestar.Set("ui.notesOpen", true)
		local r = page()
		emit({ a = at(r["ui.growUp"]), b = at(r["ui.barsBottom"]), c = at(r["ui.wholeStep"]), after = at(r["ui.upcomingOpen"]) })`, `
				{ kind = "toggle", key = "ui.locked", label = "Parent", children = {
					{ kind = "toggle", key = "ui.growUp", label = "Child one" },
				} },
				{ kind = "toggle", key = "ui.notesOpen", label = "Partner", children = {
					{ kind = "toggle", key = "ui.barsBottom", label = "Child two" },
					{ kind = "toggle", key = "ui.wholeStep", label = "Child three" },
				} },
				{ kind = "toggle", key = "ui.upcomingOpen", label = "After" },`);
	assert.ok(out.b.top > out.a.top, 'the second parent\'s block stands under the first\'s');
	assert.equal(out.a.x, out.b.x, 'each block indented alike');
	assert.ok(out.c.top >= out.b.top);
	assert.ok(out.after.top > out.c.top, 'the rows after come last');
});

test('Alert for rares, While you\'re here, Show arrow, Plan travel routes and Mirror to TomTom hold their dependent settings as children', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local out = {}
			for _, c in ipairs(O.AllControls()) do
				if c.children then
					local keys = {}
					for _, k in ipairs(c.children) do keys[#keys + 1] = k.key end
					out[c.key or c.label] = keys
				end
			end
			emit(out)`,
	}).emitted;
	assert.deepEqual(out['rares.alerts'], ['rares.treasureAlerts', 'rares.cooldown', 'rares.toastSeconds', 'rares.combatAlerts',
		'rares.sound', 'rares.soundKit']);
	assert.deepEqual(out['behavior.whileHereTurnins'], ['behavior.whileHereTurninSeconds']);
	assert.deepEqual(out['behavior.whileHereVendors'], ['behavior.whileHereSellSlots', 'behavior.whileHereRepairPercent']);
	assert.deepEqual(out['nav.arrow'], ['nav.hideArrowWithGuide']);
	assert.deepEqual(out['nav.travel'], ['nav.teleports', 'nav.detourCaption']);
	assert.deepEqual(out['nav.routeLines'], ['nav.lineStyle']);
	assert.deepEqual(out['nav.tomtom'], ['nav.useTomTomArrow']);
});

test('Grow upward, Step slide, Tabs, Target bar, Step tips and Progress bar open their settings under them (Look > Guide window)', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local out = {}
			for _, c in ipairs(O.AllControls()) do
				if c.children and c.page and c.page.key == "guidewindow" then
					local keys = {}
					for _, k in ipairs(c.children) do keys[#keys + 1] = k.key end
					out[c.key] = keys
				end
			end
			emit(out)`,
	}).emitted;
	assert.deepEqual(out['ui.growUp'], ['ui.barsBottom']);
	assert.deepEqual(out['guideWindow.stepAnim'], ['guideWindow.animSpeed']);
	assert.deepEqual(out['guideWindow.tabs'], ['guideWindow.tabHeight']);
	assert.deepEqual(out['guideWindow.targetBar'], ['guideWindow.targetBarWidth', 'guideWindow.targetBarColor']);
	assert.deepEqual(out['ui.showNotes'], ['guideWindow.noteSize', 'ui.notesOpen']);
	assert.deepEqual(out['guideWindow.progress'], ['guideWindow.progressHeight', 'guideWindow.progressColor', 'guideWindow.progressPct']);
});

test('Look > Guide window keeps offKey(key), the disabled-while-off helper other rows call', () => {
	const fs = require('node:fs');
	const path = require('node:path');
	const src = fs.readFileSync(path.join(__dirname, '..', 'addon/Polestar_Options/UI/Looks/GuideWindow.lua'), 'utf8');
	assert.match(src, /^local function offKey\(key\) return function\(\) return look\(key\) == false end end$/m,
		'offKey stays before SPECS: a row such as Tab style calls disabled = offKey("tabs")');
	assert.ok(src.indexOf('local function offKey') < src.indexOf('local SPECS'), 'declared before the specs that call it');
});
