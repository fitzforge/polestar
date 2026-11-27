'use strict';
// The other-tab card (#2783, UI/OtherTab.lua): with two tabs open, the
// active tab's window shows a card once the other tab's next step is within
// 30 yd, keeps it until that step is past 300 yd, switches to that tab on a
// click, and shows nothing with guideWindow.otherTabNear off.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// Map 1429 is 3000 yd wide: 1 of x is 30 yd. The other tab's step is at
// 50, 50; the active one's far off.
const SCRIPT = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
local function at(yd) w.moveTo(1429, 50 + yd / 30, 50) end
at(400)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/main", pack = "test", title = "Main", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "goto", map = 1429, x = 10, y = 90, r = 5 } } } } })
Polestar.RegisterGuide({ id = "test/side", pack = "test", title = "Side Trip", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "goto", map = 1429, x = 50, y = 50, r = 5 } } } } })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local E, GF, OT = Polestar.Engine, Polestar.UI.GuideFrame, Polestar.UI.OtherTabCard
E.OpenTab("test/main", true)
E.OpenTab("test/side", false)
local function active() local _, a = E.GetTabs() return E.GetTabs()[a].guideId end
local function draw() GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1.1); GF.Layout() end
local function shown()
	local f = OT.Frame()
	return (OT.Shown() and f and f:IsVisible()) and true or false
end
draw()
`;

const run = (script, addons = ['Polestar']) => runAddon({ stubs: ['stub_world.lua'], addons, script: `${SCRIPT}\n${script}` }).emitted[0];

test('shown within 30 yd, kept to 300 yd, hidden past it', () => {
	const out = run(`
local r = { active = active() }
r.far = shown()
at(25) draw() r.near = shown()
r.title = OT.Frame().Title:GetText()
local _, _, _, _, py = GF.parts.person:GetPoint(1)
r.under = -(py or 0) >= OT.Frame():GetHeight()
at(100) draw() r.mid = shown()
at(350) draw() r.gone = shown()
at(100) draw() r.back = shown()
emit(r)`);
	assert.equal(out.active, 'test/main');
	assert.equal(out.far, false, 'not at 400 yd');
	assert.equal(out.near, true, 'shown at 25 yd');
	assert.match(out.title, /Side Trip/, 'names the other tab');
	assert.equal(out.under, true, 'the step\'s header sits under the card');
	assert.equal(out.mid, true, 'kept at 100 yd');
	assert.equal(out.gone, false, 'hidden at 350 yd');
	assert.equal(out.back, false, 'not again at 100 yd until within 30');
});

test('a click switches to the other tab', () => {
	const out = run(`
at(25) draw()
local before = shown()
stub.RunScript(OT.Frame(), "OnClick", "LeftButton")
draw()
emit({ before = before, active = active() })`);
	assert.equal(out.before, true);
	assert.equal(out.active, 'test/side');
});

test('the setting off hides it', () => {
	const out = run(`
at(25) draw()
local before = shown()
Polestar.Set("guideWindow.otherTabNear", false) draw()
local off = shown()
Polestar.Set("guideWindow.otherTabNear", true) draw()
emit({ before = before, off = off, on = shown() })`);
	assert.deepEqual(out, { before: true, off: false, on: true });
});

// The card wears its own sky blue in every look: a look's "sky" is its dark
// header ground (Classic's is brown, so the card read olive with a dark
// title), and a game look's link is its gold. Its title stays blue and
// readable on the window's ground.
test('in every bundled look the card is sky blue and its title reads on the window', () => {
	const out = run(`
at(10); draw()
local looks = { "polestar", "halo", "hearth", "forever", "blizzard", "classic" }
local res = {}
local function lum(r, g, b)
	local function ch(c) return c <= 0.03928 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4 end
	return 0.2126 * ch(r) + 0.7152 * ch(g) + 0.0722 * ch(b)
end
for _, id in ipairs(looks) do
	Polestar.Set("ui.skin", id); stub.advance(0.5); draw()
	local f = OT.Frame()
	local r, g, b = f.Head:GetTextColor()
	local br, bg, bb = Polestar.Theme.Color("bg")
	local a, z = lum(r, g, b), lum(br, bg, bb)
	res[id] = { blue = b > r and b > g, contrast = (math.max(a, z) + 0.05) / (math.min(a, z) + 0.05), skin = Polestar.Theme.SkinKey() }
end
emit(res)`, ['Polestar']);
	for (const [id, r] of Object.entries(out)) {
		assert.equal(r.blue, true, `${id}: the title is blue ${JSON.stringify(r)}`);
		assert.ok(r.contrast >= 3, `${id}: the title reads on the window ${JSON.stringify(r)}`);
	}
});

// In the client a texture's SetAlpha sets its vertex colour's alpha, so the
// hover must change the wash's vertex colour only: SetAlpha(1.6) drew the
// wash solid sky, hiding the sky stripe, icon and chevron (#1684 alike).
test('hovering deepens the wash through its colour and leaving gives it back, never SetAlpha', () => {
	const out = run(`
at(25) draw()
local f = OT.Frame()
local function wash() local _, _, _, a = f.Wash:GetVertexColor() return { a = math.floor(a * 100 + 0.5), alpha = f.Wash:GetAlpha() } end
local r = { before = wash() }
stub.RunScript(f, "OnEnter")
r.hover = wash()
stub.RunScript(f, "OnLeave")
r.after = wash()
stub.RunScript(f, "OnEnter") stub.RunScript(f, "OnLeave")
draw()
r.again = wash()
emit(r)`);
	assert.deepEqual(out.before, { a: 12, alpha: 1 });
	assert.deepEqual(out.hover, { a: 20, alpha: 1 }, 'a little deeper, still a wash: ' + JSON.stringify(out));
	assert.deepEqual(out.after, { a: 12, alpha: 1 });
	assert.deepEqual(out.again, { a: 12, alpha: 1 });
});

// Under Atlas the card stands above the window with its other cards
// (guidePlace "otherTab"): on the window's ground, without its own wash,
// stripe or border, its × putting it away; back in the window under
// Polestar's own layout, in its own look again.
test('Atlas stacks it above the window with its cards; the default layout keeps it in the window', () => {
	const out = run(`
at(25)
local T = Polestar.Theme
T.SetLayout("atlas")
draw()
local f = OT.Frame()
local card = GF.parts.card
local function under(x, top) local p = x for _ = 1, 12 do if not p then return false end if p == top then return true end p = p:GetParent() end return false end
local stack
for _, c in ipairs({ GF.frame:GetChildren() }) do if rawget(c, "cards") then stack = c end end
local r = { shown = f:IsVisible(), inCard = under(f, card), inStack = stack ~= nil and under(f, stack),
	wash = f.Wash:IsShown(), stripe = f.Stripe:IsShown(), border = f.psBorder and f.psBorder[1]:IsShown() or false, h = f:GetHeight() }
local _, _, _, _, py = GF.parts.person:GetPoint(1)
r.personY = py
stub.RunScript(f, "OnEnter") stub.RunScript(f, "OnLeave")
r.washHover = f.Wash:IsShown()
T.SetLayout(nil)
draw()
r.back = { shown = f:IsVisible(), inCard = under(f, card), wash = f.Wash:IsShown(), stripe = f.Stripe:IsShown() }
T.SetLayout("atlas")
draw()
local b = f:GetParent()
if b and b.Close then b.Close:GetScript("OnClick")(b.Close) end
draw()
r.closed = f:IsVisible()
emit(r)`, ['Polestar', { name: 'Polestar_Skins', files: ['Skins/Atlas/Atlas.lua', 'Layouts/Atlas/Atlas.lua'] }]);
	assert.equal(out.shown, true, JSON.stringify(out));
	assert.equal(out.inStack, true, 'above the window, in the cards\' stack: ' + JSON.stringify(out));
	assert.equal(out.inCard, false);
	assert.deepEqual([out.wash, out.stripe, out.border, out.washHover], [false, false, false, false], 'the window\'s ground, none of its own');
	assert.ok(out.h > 30, 'heading and a wrapped row: ' + out.h);
	assert.deepEqual(out.back, { shown: true, inCard: true, wash: true, stripe: true }, 'Polestar\'s own layout: in the window, its own look');
	assert.equal(out.closed, false, 'its × puts it away');
});
