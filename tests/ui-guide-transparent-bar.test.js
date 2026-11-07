'use strict';
// "Keep the bar shown" (ui.barShown): in the Transparent style the tabs and the
// step bar stay on screen over a dark strip instead of only under the cursor;
// the grip still waits for the cursor. Off (the default) and in the Standard
// style nothing changes. Against the real Core + Theme + UI manifests and the
// fake Engine (tests/lua/stub_ui.lua).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const PRE = `
uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local P = GF.parts
local function add(g) uistub.guides[g.id] = g; table.insert(uistub.order, g.id) end
add({ id = "test/durotar", pack = "guides", title = "Durotar", faction = "Horde", category = "Leveling", minLevel = 1, maxLevel = 12,
	zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = {
	{ title = "Valley of Trials", goals = { { t = "kill", verb = "Kill", subject = "Mottled Boar", subjectKind = "npc", npc = 3098, progress = { cur = 0, max = 8 }, status = "pending" } } } } })
uistub.setGuide("test/durotar", 1)
stub.advance(1)
local function state()
	return { title = P.nav.Title:GetAlpha(), strip = P.strip:GetAlpha(), grip = GF.grip:GetAlpha(), shade = P.band.Shade:IsShown() }
end
`;

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: PRE + script,
	}).emitted;
}

test('off by default: a transparent window away from the cursor hides its bar, with no strip, as before', () => {
	const [c] = run(`
		Polestar.Set("ui.style", "transparent")
		emit(state())`);
	assert.deepEqual(c, { title: 0, strip: 0, grip: 0, shade: false });
});

test('on: the tabs and the step bar stay shown on the dark strip; the grip still waits for the cursor', () => {
	const [c] = run(`
		Polestar.Set("ui.style", "transparent")
		Polestar.Set("ui.barShown", true)
		emit(state())`);
	assert.deepEqual(c, { title: 1, strip: 1, grip: 0, shade: true });
});

test('in the Standard style the option changes nothing', () => {
	const [off, on] = run(`
		emit(state())
		Polestar.Set("ui.barShown", true)
		emit(state())`);
	assert.deepEqual(off, { title: 1, strip: 1, grip: 1, shade: false });
	assert.deepEqual(on, off);
});

test('turning it off again hides the bar and the strip in Transparent', () => {
	const [c] = run(`
		Polestar.Set("ui.style", "transparent")
		Polestar.Set("ui.barShown", true)
		Polestar.Set("ui.barShown", false)
		emit(state())`);
	assert.deepEqual(c, { title: 0, strip: 0, grip: 0, shade: false });
});

test('the dark strip can be turned off: the bar stays shown with no background', () => {
	const [c] = run(`
		Polestar.Set("ui.style", "transparent")
		Polestar.Set("ui.barShown", true)
		Polestar.Set("ui.barShade", false)
		emit(state())`);
	assert.deepEqual(c, { title: 1, strip: 1, grip: 0, shade: false });
});

test('the bar text in the class colour: the guide name, the step count and Skip; back to the theme colour on default', () => {
	const [cls, def] = run(`
		UnitClass = function() return "Warlock", "WARLOCK", 9 end
		local r, g, b = Polestar.Theme.ClassColor()
		local function same(fs) local x, y, z = fs:GetTextColor(); return math.abs(x - r) < 1e-6 and math.abs(y - g) < 1e-6 and math.abs(z - b) < 1e-6 end
		local before = { P.nav.Title:GetTextColor() }
		Polestar.Set("ui.barText", "class")
		emit({ title = same(P.nav.Title), count = same(P.nav.Steps.Count), skip = same(P.nav.Skip.Label), hasClass = r ~= nil })
		Polestar.Set("ui.barText", "default")
		local after = { P.nav.Title:GetTextColor() }
		emit({ back = before[1] == after[1] and before[2] == after[2] and before[3] == after[3] })`);
	assert.equal(cls.hasClass, true, 'the stub player has a class colour');
	assert.deepEqual([cls.title, cls.count, cls.skip], [true, true, true]);
	assert.equal(def.back, true, 'default puts the theme colour back');
});
