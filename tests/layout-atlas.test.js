'use strict';
// The Atlas look: its skin (addon/Polestar_Skin_Atlas, tokens only) and its
// layout (addon/Polestar_Layout_Atlas, structure hooks only). The layout
// registers through Theme.RegisterLayout and is picked with SetLayout, any
// skin's tokens on top. Its hooks are also run here one by one on the live
// window's parts, to show they keep to the parts they are handed.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');

const LAYOUT = path.join(ADDONS, 'Polestar_Layout_Atlas', 'Atlas.lua');
const luaPath = (p) => JSON.stringify(p);

test('the Atlas skin registers as given and is legible', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas'],
		login: true,
		script: `
local T = Polestar.Theme
local notes = {}
for _, l in ipairs(Polestar.DebugLog(800)) do
	if tostring(l):find("Polestar_Skin_Atlas", 1, true) then notes[#notes + 1] = tostring(l) end
end
Polestar.Set("ui.skin", "atlas")
emit({ inUse = T.SkinId(), notes = #notes, legible = T.Legibility(T.Palette()) >= 1 })`,
	}).emitted;
	assert.deepEqual(out, { inUse: 'atlas', notes: 0, legible: true });
});

// Every hook the layout has, captured from a stand-in RegisterLayout and run
// on the window's own parts.
// A guide of two steps on screen (a test pack, as forge-addontest's).
const GUIDE = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({
	id = "test/atlas", pack = "test", title = "Atlas", minLevel = 1, maxLevel = 20,
	steps = {
		{ goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" },
			{ t = "note", text = "The kobolds are north of the abbey." },
		} },
		{ goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } },
		{ goals = { { t = "accept", quest = 33, title = "Wolves Across the Border" } } },
	},
})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)`;

const RUN_HOOKS = (compact) => `${GUIDE}
local T = Polestar.Theme
local spec
local register = T.RegisterLayout
T.RegisterLayout = function(id, s) spec = s; spec.id = id; return true end
local chunk = assert(loadfile(${luaPath(LAYOUT)}))
chunk("Polestar_Layout_Atlas", {})
T.RegisterLayout = register
Polestar.Set("ui.skin", "atlas")
Polestar.Set("ui.shown", true)
Polestar.Set("ui.compact", ${compact})
Polestar.UI.GuideFrame.Layout()
stub.advance(1)
local h, parts = spec.hooks, T.GuideParts()
local ran = {}
local function run(name, ...)
	if h[name] then
		local ok, err = pcall(h[name], ...)
		if not ok then error(name .. ": " .. tostring(err), 0) end
		ran[#ran + 1] = name
	end
end
local view = { index = 2, goals = {
	{ index = 1, t = "kill", text = "Kill 8 Kobold Vermin", status = "active", progress = { cur = 3, max = 8 }, quest = 7 },
	{ index = 2, t = "loot", text = "Gather 4 Candles", status = "active", optional = true, map = 1429, x = 0.4, y = 0.6 },
	{ index = 3, t = "note", text = "The candles drop from the kobolds." },
	{ index = 4, t = "turnin", text = "Turn in Kobold Camp Cleanup", status = "pending", quest = 7 },
} }
for _, g in ipairs(view.goals) do run("guideTakes", g) end
run("guideRender", view, parts)
for name, part in pairs({ here = parts.here, upnext = parts.upnext, tip = parts.tip, xp = parts.xp, banner = parts.banner }) do
	run("guidePlace", name, part, 300, 40)
end
run("guideShows", "upnextHead", true)
run("guideInset", "card")
if parts.person then run("guidePerson", parts.person, 300, 20) end
for _, r in ipairs(parts.rows or {}) do run("guideRow", r, view.goals[1], { current = true }) end
if parts.upnext then for i, r in ipairs({ parts.upnext:GetChildren() }) do if rawget(r, "psIndex") then run("guideUpRow", r, view, i) end end end
run("guideLayout", parts, 300, 200)
run("guideProgress", parts.foot, 0.4)
run("guideAnchor")
run("card", nil, "headsupGap")
run("guideTitle", parts.nav, parts)
spec.onLeave()
Polestar.UI.GuideFrame.Layout()
stub.advance(1)
emit({ id = spec.id, api = spec.api, ran = #ran, rows = #(parts.rows or {}), person = parts.person ~= nil })`;

test('the Atlas layout hooks run on the window parts without raising', () => {
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar', 'Polestar_Skin_Atlas'], script: RUN_HOOKS(false) }).emitted;
	assert.equal(out.id, 'atlas');
	assert.equal(out.api, 2);
	assert.ok(out.ran > 5, `hooks ran: ${out.ran}`);
	assert.ok(out.person && out.rows > 0, 'the window shows a step with its goals');
});

test('the Atlas layout hooks run in compact mode without raising', () => {
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar', 'Polestar_Skin_Atlas'], script: RUN_HOOKS(true) }).emitted;
	assert.ok(out.ran > 5, `hooks ran: ${out.ran}`);
});

// Full mode's air (the player's gaps, guideWindow.*: Atlas's defaults, and
// the step header): the tip further under the goals with more room round its
// text, the XP row a few px shorter, the title further down; the rail rows
// and under Up next as Polestar. Compact mode keeps Polestar's own gaps and
// the header's.
test('the Atlas layout opens up its gaps in full mode only', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
Polestar.Set("ui.upcoming", 2)
T.SetLayout("atlas")
local function draw()
	GF.Layout()
	stub.advance(1)
end
local function space()
	local t = {}
	for _, n in ipairs({ "upRow", "upnextFoot", "tipPad", "tipGap", "xpRow", "other" }) do t[#t + 1] = GF.Space(n, 10) end
	return t
end
local person = T.GuideParts().person
draw()
local out = { cap = T.HasCapability("surfaces.guideSpace"), full = space(), fullH = person:GetHeight() }
out.keys = {}
for _, k in ipairs({ "stepSpace", "titleSpace", "tipSpace", "tipPadding", "upRowHeight", "lastRowHeight", "xpRowHeight" }) do
	out.keys[#out.keys + 1] = Polestar.Get("guideWindow." .. k)
end
Polestar.Set("ui.compact", true)
draw()
out.compact, out.compactH = space(), person:GetHeight()
out.failed = T.LayoutInfo("atlas").failed or false
T.SetLayout()
draw()
out.own = space()
emit(out)`,
	}).emitted;
	assert.equal(out.cap, true);
	assert.deepEqual(out.keys, [9, 4, 9, 8, false, false, 24], "Atlas's defaults for the player's gaps; the rows keep Polestar's");
	assert.deepEqual(out.full, [10, 10, 8, 9, 24, 10], "full mode: rows and under Up next as Polestar, the tip's room and gap and the XP row Atlas's defaults (whole sizes, whatever Polestar's own)");
	assert.deepEqual(out.compact, [10, 10, 10, 10, 10, 10], "compact mode: Polestar's own");
	assert.deepEqual(out.own, [10, 10, 10, 10, 10, 10], "Polestar's own layout: its own");
	assert.equal(out.fullH - out.compactH, 2, 'the title: 9 over it (10 in compact mode); its line 4 under it, 7 over the goals (8 under it in compact mode)');
	assert.equal(out.failed, false);
});

// The step number under Atlas: three quarters of its size by Atlas's default
// (guideWindow.stepNumberSize 75%), the arrows round it and the title up to
// it; the player's size wins, a reset gives Atlas's back.
test("under Atlas the step number is three quarters of its size, the arrows round it and the title up to it", () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
T.SetLayout("atlas")
local nav = T.GuideParts().nav
local function read()
	GF.Render()
	GF.Layout()
	stub.advance(1)
	local _, size = nav.Steps.Count:GetFont()
	local title
	for i = 1, nav.Title:GetNumPoints() do
		local p, rel = nav.Title:GetPoint(i)
		if p == "RIGHT" then title = rel == nav.Steps end
	end
	local _, next = nav.Next:GetPoint(1)
	return { size = size, w = nav.Steps:GetWidth(), cw = nav.Steps.Count:GetWidth(), title = title or false, next = next == nav.Steps.Count }
end
local out = { key = Polestar.Get("guideWindow.stepNumberSize") }
out.atlas = read()
Polestar.Set("guideWindow.stepNumberSize", 1)
out.full = read()
Polestar.Set("guideWindow.stepNumberSize", Polestar.GetDefault("guideWindow.stepNumberSize"))
out.reset = read()
out.failed = T.LayoutInfo("atlas").failed or false
emit(out)`,
	}).emitted;
	assert.equal(out.key, 0.75, "Atlas's default: 75%");
	assert.ok(Math.abs(out.atlas.size - out.full.size * 0.75) <= 0.5, `three quarters of the size: ${out.atlas.size} of ${out.full.size}`);
	assert.ok(out.atlas.cw >= 20 && out.atlas.cw <= out.full.cw, `its box: ${out.atlas.cw} of ${out.full.cw}`);
	assert.equal(out.atlas.w, 24 + out.atlas.cw + 24, 'the arrows round the number');
	assert.equal(out.atlas.next, true, 'the next arrow right after it');
	assert.equal(out.atlas.title, true, 'the title runs up to the step number');
	assert.deepEqual(out.reset, out.atlas, "a reset: Atlas's 75% again");
	assert.equal(out.failed, false);
});

// The player's gaps under Atlas (Options > Guide window, Step card): a value
// set wins over Atlas's default in full mode, compact mode keeps its own,
// and a reset goes back to Atlas's default.
test("under Atlas the player's gaps win in full mode, compact keeps its own, a reset gives Atlas's back", () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
T.SetLayout("atlas")
local person = T.GuideParts().person
local function draw()
	GF.Layout()
	stub.advance(1)
end
local function read() draw(); return { GF.Space("tipPad", 10), GF.Space("tipGap", 10), GF.Space("xpRow", 10), GF.Space("upRow", 10), person:GetHeight() } end
local out = { atlas = read() }
Polestar.Set("guideWindow.tipPadding", 3)
Polestar.Set("guideWindow.tipSpace", 0)
Polestar.Set("guideWindow.xpRowHeight", 30)
Polestar.Set("guideWindow.upRowHeight", 20)
Polestar.Set("guideWindow.stepSpace", 20)
Polestar.Set("guideWindow.titleSpace", 30)
out.mine = read()
Polestar.Set("ui.compact", true)
out.compact = read()
Polestar.Set("ui.compact", false)
for _, k in ipairs({ "stepSpace", "titleSpace", "tipSpace", "tipPadding", "upRowHeight", "lastRowHeight", "xpRowHeight" }) do
	Polestar.Set("guideWindow." .. k, Polestar.GetDefault("guideWindow." .. k))
end
out.reset = read()
out.failed = T.LayoutInfo("atlas").failed or false
emit(out)`,
	}).emitted;
	assert.deepEqual(out.mine.slice(0, 4), [3, 0, 30, 20], "the player's values, whole sizes");
	assert.equal(out.mine[4] - out.atlas[4], (20 - 9) + (30 - 4), 'the title 11 lower, its line 26 further under it');
	assert.deepEqual(out.compact.slice(0, 4), [10, 10, 10, 10], "compact mode: Polestar's own, the player's gaps aside");
	assert.deepEqual(out.reset, out.atlas, "a reset: Atlas's defaults again");
	assert.equal(out.failed, false);
});

// The window's foot without a Journey: its border and the house look's shade
// keep their own alpha (a texture's alpha is its vertex colour's), never
// drawn solid; Atlas leaving does not draw them solid either.
test('without a Journey the window keeps its own bottom border, never a solid line', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
T.SetLayout("atlas")
local function draw()
	GF.Layout()
	stub.advance(1)
end
draw()
local F = GF.frame
local function foot()
	local t = F.psBorder and F.psBorder[2]
	local _, _, _, a = t:GetVertexColor()
	local _, _, _, top = F.psBorder[1]:GetVertexColor()
	return { a, top }
end
local out = { painted = foot() }
-- The joined Journey's seam, then none: Atlas's guideLayout with the card
-- under the window shown, then hidden.
local h = Polestar.ThemeInternal.LAYOUTS.atlas.hooks
local parts = T.GuideParts()
local J = CreateFrame("Frame", nil, F)
J:SetHeight(40)
h.guidePlace("journey", J, 300, 40)
h.guideLayout(parts, 300, 200)
out.joined = foot()
J:Hide()
draw()
out.drawn = foot()
T.SetLayout()
draw()
out.left = foot()
emit(out)`,
	}).emitted;
	assert.ok(out.painted[0] < 0.5, `the border as painted: ${out.painted}`);
	assert.equal(out.joined[0], 0, 'joined: no line where the window meets the Journey');
	assert.deepEqual(out.drawn, out.painted, 'the Journey gone: the border as painted, not solid');
	assert.ok(out.left[0] < 0.5 && out.left[0] === out.left[1], `after Atlas: the bottom as the top, ${out.left}`);
});

// The XP row under Atlas: its line starts at the card's text column, so the
// row takes its second line when the line wraps in Atlas's room (GF.Space
// "xpRoom"), not Polestar's. The level and its percent are parts of the
// core's own line, so Atlas puts nothing before it.
test('the Atlas XP row grows by a line when its whole text wraps', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
local Q = Polestar.QoL
Q.GetXPStats = function() return { rate = 1 } end
T.SetLayout("atlas")
GF.Layout()
stub.advance(1)
local xp = GF.xp
local width = 340
local own = width - 14 * 2 - 11 - 7
local room = GF.Space("xpRoom", own, width)
-- A line a little past Atlas's room.
local line = ""
xp.psRest = nil
while true do
	line = line .. "x"
	xp.Text:SetText(line)
	if xp.Text:GetUnboundedStringWidth() > room + 4 then break end
end
xp.psLine = line
local one = GF.Space("xpRow", GF.XPROW.h)
local out = { room = room, own = own, h = GF.XPHeight(width), one = one }
-- A short line keeps one line.
xp.psLine = "x"
xp.Text:SetText("x")
out.short = GF.XPHeight(width)
Polestar.Set("ui.compact", true)
out.compactRoom = GF.Space("xpRoom", own, width)
Polestar.Set("ui.compact", false)
T.SetLayout()
out.polestar = { GF.Space("xpRoom", own, width), GF.XPHeight(width), GF.XPROW.h }
emit(out)`,
	}).emitted;
	assert.ok(out.room > 0 && out.room !== out.own, `Atlas answers its own room: ${out.room} (Polestar's ${out.own})`);
	assert.ok(out.h > out.one, `a line past the room takes a second line: ${out.h} over ${out.one}`);
	assert.equal(out.short, out.one, 'a short line keeps one line');
	assert.equal(out.polestar[0], out.own, "Polestar's own layout: its own room");
});

// A quest's [level] in the goal rows: a size smaller than the line, as a
// string of its own after it where the line holds it on one line; in the
// line, wrapping with it, where it does not.
test('the Atlas goal rows draw the quest level a size smaller', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
Polestar.Levels = Polestar.Levels or {}
Polestar.Levels.QuestLevel = function() return 24 end
T.SetLayout("atlas")
if GF.Render then GF.Render() end
GF.Layout()
stub.advance(1)
local function look()
	for _, row in ipairs(T.GuideParts().rows or {}) do
		if row:IsShown() and (row.Text:GetText() or ""):find("Kobold", 1, true) then
			local level
			for _, r in ipairs({ row:GetRegions() }) do
				if r ~= row.Text and r.GetText and r:IsShown() and (r:GetText() or ""):find("[24]", 1, true) then level = r end
			end
			local _, size = row.Text:GetFont()
			local lsize
			if level then lsize = select(2, level:GetFont()) end
			return { inText = (row.Text:GetText() or ""):find("[24]", 1, true) ~= nil, own = level ~= nil, down = level and size - lsize or false }
		end
	end
	return false
end
local F = GF.frame
F:SetWidth(700)
GF.Layout()
stub.advance(1)
local out = { wide = look() }
F:SetWidth(170)
GF.Layout()
stub.advance(1)
out.narrow = look()
emit(out)`,
	}).emitted;
	assert.deepEqual(out.wide, { inText: false, own: true, down: 2 }, 'on one line: its own string, 2 smaller');
	assert.deepEqual(out.narrow, { inText: true, own: false, down: false }, 'a line that wraps: in the line');
});

// The real thing: the layout addon registers, SetLayout picks it, the window
// draws in normal and compact mode with nothing failed, another skin's tokens
// colour it, and SetLayout() gives Polestar's own layout back.
test('the Atlas layout registers, draws under another skin and leaves', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Skin_Beacon', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T = Polestar.Theme
local function hex(c) return string.format("%02x%02x%02x", math.floor(c[1] * 255 + 0.5), math.floor(c[2] * 255 + 0.5), math.floor(c[3] * 255 + 0.5)) end
local function draw()
	Polestar.UI.GuideFrame.Layout()
	if Polestar.UI.GuideFrame.Render then Polestar.UI.GuideFrame.Render() end
	stub.advance(1)
end
local refused = {}
for _, l in ipairs(Polestar.DebugLog(800)) do
	if tostring(l):find("Polestar_Layout_Atlas", 1, true) then refused[#refused + 1] = tostring(l) end
end
Polestar.Set("ui.shown", true)
Polestar.Set("ui.skin", "beacon")
draw()
local beacon = hex(T.Palette().accent)
local info = T.LayoutInfo("atlas")
local out = { registered = info ~= nil, refused = #refused, hooks = info and table.concat(info.hooks, ",") or "" }
out.set = T.SetLayout("atlas") and true or false
draw()
out.inUse = { T.LayoutId() or false, T.SkinId(), hex(T.Palette().accent) == beacon }
local nav = T.GuideParts().nav
local function rule() return nav.Rule:IsShown() and true or false end
out.rule = { rule() }
-- The player's switches hold under Atlas: the rule, Skip and Report.
local function skip() return nav.Skip:IsShown() and true or false end
local function report() return nav.Report:IsShown() and true or false end
out.switches = { skip(), report() }
-- Atlas's defaults (spec.defaults) start Report off; the player's choice wins.
Polestar.Set("guideWindow.reportButton", true)
draw()
out.switches[3] = report()
-- Atlas starts with tabs on, as the icon strip down the left; the player's style wins.
out.tabs = { Polestar.Get("guideWindow.tabs"), Polestar.Get("guideWindow.tabStyle") }
Polestar.Set("guideWindow.tabStyle", "edge")
out.tabs[3] = Polestar.Get("guideWindow.tabStyle")
Polestar.Set("guideWindow.tabStyle", "strip")
Polestar.Set("guideWindow.rules", false)
Polestar.Set("guideWindow.skipButton", false)
Polestar.Set("guideWindow.reportButton", false)
draw()
out.off = { rule(), skip(), report() }
Polestar.Set("guideWindow.rules", true)
Polestar.Set("guideWindow.skipButton", true)
Polestar.Set("guideWindow.reportButton", true)
draw()
out.skipLabel = nav.Skip.Label:IsShown() and true or false
Polestar.Set("ui.compact", true)
draw()
Polestar.Set("ui.compact", false)
Polestar.Set("ui.skin", "atlas")
draw()
out.atlasAccent = hex(T.Palette().accent)
out.failed = T.LayoutInfo("atlas").failed or false
T.SetLayout()
Polestar.Set("ui.skin", "beacon")
draw()
out.back = T.LayoutId() or false
out.rule[2] = rule()
emit(out)`,
	}).emitted;
	assert.equal(out.registered, true);
	assert.equal(out.refused, 0, 'registered as given');
	for (const h of ['guideLayout', 'guideRender', 'guidePlace', 'guideRow', 'guideTitle', 'guideProgress']) {
		assert.ok(out.hooks.split(',').includes(h), `hooks ${h}: ${out.hooks}`);
	}
	assert.equal(out.set, true);
	assert.deepEqual(out.inUse, ['atlas', 'beacon', true], "the layout in use, Beacon's tokens on top");
	assert.equal(out.atlasAccent, 'e6ba66', "the Atlas skin's own accent");
	assert.equal(out.failed, false, 'no hook failed in normal or compact mode');
	assert.equal(out.back, false, "Polestar's own layout again");
	assert.deepEqual(out.rule, [true, true], 'the header keeps its rule (guideWindow.rules) under Atlas and after');
	assert.deepEqual(out.switches, [true, false, true], "Skip shows, Report starts off by Atlas's default, the player's choice turns it on");
	assert.deepEqual(out.tabs, [true, 'strip', 'edge'], "tabs on as the left icon strip by Atlas's default, the player's style wins");
	assert.deepEqual(out.off, [false, false, false], 'switched off, they stay off under Atlas');
	assert.equal(out.skipLabel, false, 'Skip is its glyph alone under Atlas');
});

// The layout's hooks, captured from a stand-in RegisterLayout, with the
// window on screen: `h` the hooks, `parts` the window's parts.
const HOOKS = `${GUIDE}
local T = Polestar.Theme
local spec
local register = T.RegisterLayout
T.RegisterLayout = function(id, s) spec = s; return true end
assert(loadfile(${luaPath(LAYOUT)}))("Polestar_Layout_Atlas", {})
T.RegisterLayout = register
Polestar.Set("ui.skin", "atlas")
Polestar.Set("ui.shown", true)
Polestar.UI.GuideFrame.Layout()
stub.advance(1)
local h, parts = spec.hooks, T.GuideParts()`;

const hooks = (script) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar', 'Polestar_Skin_Atlas'], script: `${HOOKS}\n${script}` }).emitted[0];

test('an area goal loses its spots line, and on the rail its next-spot button', () => {
	const out = hooks(`
local row = parts.rows[1]
local goal = { index = 1, t = "kill", text = "Kill Rockjaw Trogg", subject = "Rockjaw Trogg", spots = 12, spread = true, status = "active", quest = 7 }
local area = Polestar.UI.AreaLine(goal)
row.Sub:SetText("Ask the guard first\\n" .. area)
row.Sub:Show()
row.Alt:Show()
h.guideRow(row, goal, { current = true })
local railSub, railAlt = row.Sub:GetText(), row.Alt:IsShown()
Polestar.Set("ui.compact", true)
row.Sub:SetText(area)
row.Sub:Show()
row.Alt:Show()
h.guideRow(row, goal, { current = true })
emit({ area = area ~= nil, sub = railSub, rail = railAlt, compactAlt = row.Alt:IsShown(), compactSub = row.Sub:IsShown() and row.Sub:GetText() or false })`);
	assert.equal(out.area, true);
	assert.ok(!/spots/.test(out.sub) && /Ask the guard first/.test(out.sub), `sub: ${out.sub}`);
	assert.equal(out.rail, false, 'the next-spot button is off on the rail');
	assert.equal(out.compactAlt, false, 'compact mode keeps the rail, so no next-spot button either');
	assert.ok(!/spots/.test(String(out.compactSub)), `compact sub: ${out.compactSub}`);
});

test("While you're here keeps its line: no step line or × of its own, the count by the distance", () => {
	const out = hooks(`
local GF = Polestar.UI.GuideFrame
local r = GF.HereRow(1)
r.psView, r.psOff = { step = 7, index = 1 }, nil
Polestar.UI.SetCounted(r.Text, "Kill Small Crag Boar 2/12")
r.Sub:SetText("Step 7")
r.Sub:Show()
r.Dist:SetText("80 yd")
r:Show()
parts.here:Show()
local h0 = GF.LayoutHere(300)
h.guidePlace("here", parts.here, 300, h0)
local first = { r.Text:GetText(), r.Sub:IsShown() and r.Sub:GetAlpha() > 0, r.Close:IsShown() }
-- A second layout finds the count it took out at the first.
local h1 = GF.LayoutHere(300)
h.guidePlace("here", parts.here, 300, h1)
local own
for _, region in ipairs({ r:GetRegions() }) do
	if region.GetText and region ~= r.Text and region ~= r.Sub and region ~= r.Dist and region:IsShown() and (region:GetText() or ""):find("2/12", 1, true) then own = region:GetText() end
end
emit({ text = first[1], sub = first[2], close = first[3], count = own or false, shorter = parts.here:GetHeight() < h0, h0 = h0, h1 = parts.here:GetHeight(), rh = r:GetHeight(), ry = select(5, r:GetPoint(1)), th = r.Text:GetStringHeight(), lh = r.Text:GetLineHeight(), lab = parts.here.Label:IsShown(), labh = parts.here.Label:GetStringHeight() })`);
	assert.equal(out.text, 'Kill Small Crag Boar');
	assert.equal(out.sub, false, 'no step line');
	assert.equal(out.close, false, "no × of the row's own");
	assert.equal(out.count, '2/12  ·  ', 'the count left of the distance');
	assert.equal(out.h1, -out.ry + out.rh + 6, `the card holds its rows and its foot, no room for a step line: ${JSON.stringify(out)}`);
});

test('an Up next row not laid out yet takes Up next width, not the narrowest', () => {
	const out = hooks(`
Polestar.Set("ui.upcoming", 3)
Polestar.UI.GuideFrame.Layout()
stub.advance(1)
local rows = {}
for _, r in ipairs({ parts.upnext:GetChildren() }) do if rawget(r, "psIndex") then rows[#rows + 1] = r end end
local r = rows[1]
if not r then return emit({ rows = 0 }) end
r:Show()
parts.upnext:Show()
r.GetWidth = function() return 0 end
h.guideUpRow(r, { goals = { { t = "turnin", text = "Turn in A New Threat", status = "pending" } } }, 1)
h.guidePlace("upnext", parts.upnext, 320, 60)
emit({ rows = #rows, text = math.floor(r.Text:GetWidth() + 0.5) })`);
	assert.ok(out.rows > 0, 'Up next has rows');
	assert.ok(out.text > 200, `the text is ${out.text} wide`);
});

// Up next on the rail: folded (ui.upcomingOpen off), only its heading shows,
// the handle that opens it; open, its rows show and no heading.
test('on the rail a folded Up next shows its heading and no rows; a click on it opens it to rows without one', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
Polestar.Set("ui.upcoming", 2)
T.SetLayout("atlas")
Polestar.Set("ui.upcomingOpen", false)
local up = T.GuideParts().upnext
local function draw()
	GF.Layout()
	stub.advance(1)
end
local function look()
	local n = 0
	for _, r in ipairs({ up:GetChildren() }) do
		if rawget(r, "psIndex") and r:IsShown() then n = n + 1 end
	end
	return { shown = up:IsShown(), head = GF.Shows("upnextHead", true), toggle = up.Toggle:IsShown(), rows = n }
end
draw()
local out = { folded = look() }
up.Toggle:GetScript("OnClick")(up.Toggle)
draw()
out.open, out.setting = look(), Polestar.Get("ui.upcomingOpen")
out.failed = T.LayoutInfo("atlas").failed or false
emit(out)`,
	}).emitted;
	assert.equal(out.failed, false);
	assert.deepEqual(out.folded, { shown: true, head: true, toggle: true, rows: 0 }, 'folded: the heading only');
	assert.equal(out.setting, true, 'a click on the heading expands Up next');
	assert.equal(out.open.head, false, 'open: no heading');
	assert.equal(out.open.toggle, false, 'open: no heading');
	assert.equal(out.open.rows, 2, 'open: both rows asked for show');
});

// Atlas's defaults may name any setting but the layout and the skin: Up next
// starts open on the rail (ui.upcomingOpen, off in Polestar's own layout),
// the player's own choice still wins, and ui.skin is refused.
test('Atlas opens Up next by default, the player\'s choice wins, a layout cannot default the skin', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T = Polestar.Theme
local out = { before = Polestar.Get("ui.upcomingOpen") }
T.SetLayout("atlas")
out.atlas = Polestar.Get("ui.upcomingOpen")
Polestar.Set("ui.upcomingOpen", false)
out.player = Polestar.Get("ui.upcomingOpen")
out.failed = T.LayoutInfo("atlas").failed or false
local ok, why = T.RegisterLayout("probe", { addon = "Polestar_Layout_Atlas", name = "Probe", defaults = { ["ui.skin"] = "atlas" } })
out.skinOk, out.skinWhy = ok or false, why
emit(out)`,
	}).emitted;
	assert.equal(out.failed, false);
	assert.equal(out.before, false, "Polestar's own default: folded");
	assert.equal(out.atlas, true, "Atlas's default: open");
	assert.equal(out.player, false, "the player's choice wins");
	assert.equal(out.skinOk, false);
	assert.match(String(out.skinWhy), /not a setting a layout can default/);
});

// The steps before (guideWindow.lastSteps, Polestar's part `last`): 1 by
// Atlas's default, each row on the rail with a node of its own, done or
// skipped, the oldest on top; never more than come before; the player's count
// wins, a reset goes back to Atlas's; none in compact mode or under
// Polestar's own layout (0 by default).
test('the steps before show on the rail: as many as asked and come before, done or skipped, oldest on top', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({
	id = "test/before", pack = "test", title = "Before", minLevel = 1, maxLevel = 20,
	steps = {
		{ goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } },
		{ goals = { { t = "accept", quest = 33, title = "Wolves Across the Border", npc = 196, npcName = "Eagan Peltskinner" } } },
		{ goals = { { t = "accept", quest = 18, title = "Brotherhood of Thieves", npc = 823, npcName = "Deputy Willem" } } },
		{ goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem" } } },
		{ goals = { { t = "accept", quest = 5261, title = "Eagan Peltskinner", npc = 823, npcName = "Deputy Willem" } } },
	},
})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local T, E = Polestar.Theme, Polestar.Engine
local function draw()
	Polestar.UI.GuideFrame.Layout()
	if Polestar.UI.GuideFrame.Render then Polestar.UI.GuideFrame.Render() end
	stub.advance(1)
end
local function accept(q, title)
	stub.world.accept(q, {}, title)
	stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
end
Polestar.Set("ui.shown", true)
Polestar.Set("ui.skin", "atlas")
T.SetLayout("atlas")
draw()
local parts = T.GuideParts()
local last = parts.last
-- The rows shown, top to bottom: step, status, number, "skipped" said, a
-- rail node beside it; and whether they stack oldest on top.
local function state()
	local rows, nodes = {}, {}
	for _, region in ipairs({ parts.window:GetChildren() }) do
		for _, t in ipairs({ region:GetRegions() }) do
			local p = t.GetPoint and { t:GetPoint(1) }
			if p and p[2] and t:IsShown() then nodes[p[2]] = true end
		end
	end
	local n = last:IsShown() and (last.psCount or 0) or 0
	local tops = {}
	for i = 1, n do
		local r = last.Rows[i]
		local text = r.Text:GetText() or ""
		rows[#rows + 1] = { index = r.psIndex, status = r.psStatus, num = r.Num:GetText(),
			skipped = text:find("skipped", 1, true) ~= nil, node = nodes[r] or false }
		local _, _, _, _, y = r:GetPoint(1)
		tops[#tops + 1] = y
	end
	local stacked = true
	for i = 2, #tops do if not (tops[i] < tops[i - 1]) then stacked = false end end
	local _, rel, _, _, drop = last:GetPoint(1)
	return { n = n, rows = rows, stacked = stacked, drop = n > 0 and rel == parts.person and drop or false }
end
local out = { first = state() }
accept(7, "Kobold Camp Cleanup")
draw()
out.atlas = state()
Polestar.Set("guideWindow.lastSteps", 3)
draw()
out.two = state()
accept(33, "Wolves Across the Border")
E.Skip(); stub.advance(0.6)
accept(783, "A Threat Within")
draw()
out.step = E.GetStepIndex()
out.three = state()
Polestar.Set("guideWindow.lastSteps", 0)
draw()
out.zero = state()
Polestar.Set("guideWindow.lastSteps", nil)
draw()
out.back = state()
Polestar.Set("ui.compact", true)
draw()
out.compact = state()
Polestar.Set("ui.compact", false)
T.SetLayout()
draw()
out.house = state()
out.failed = T.LayoutInfo("atlas").failed or false
emit(out)`,
	}).emitted;
	assert.equal(out.failed, false, 'no hook failed');
	assert.equal(out.first.n, 0, 'nothing before step 1');
	assert.deepEqual(out.atlas.rows, [{ index: 1, status: 'done', num: '1', skipped: false, node: true }], "Atlas's 1: step 1 done, on a node");
	assert.equal(out.atlas.drop, -3, "the rows stand 3 into the title's room, their text as clear of the bars as of the title");
	assert.equal(out.two.n, 1, 'three asked at step 2: the one there is');
	assert.equal(out.step, 5);
	assert.deepEqual(out.three.rows.map((r) => [r.index, r.status, r.skipped, r.node]),
		[[2, 'done', false, true], [3, 'skipped', true, true], [4, 'done', false, true]], 'three, the oldest on top, the skipped one in the middle');
	assert.equal(out.three.stacked, true, 'each row under the one before');
	assert.equal(out.zero.n, 0, '0 turns them off');
	assert.deepEqual(out.back.rows.map((r) => r.index), [4], "reset: Atlas's 1, the newest");
	assert.equal(out.compact.n, 0, 'compact mode leaves them out');
	assert.equal(out.house.n, 0, "Polestar's own layout: 0 by default");
});

// Under Atlas nothing extra sits in the window: Along the way, a banner
// notice (Looking ahead) and the party line each go on a card above it, and
// leave no heading or gap behind; under Polestar's own layout each stays in
// the window as before.
const OUTSIDE = (layout) => `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
local E = Polestar.Engine
E.GetAlong = function()
	return { { index = 1, title = "Boars", goals = {
		{ index = 1, step = 1, t = "loot", text = "Collect Chunk of Boar Meat", status = "active", optional = true, progress = { cur = 6, max = 10 }, map = 1429, x = 0.48, y = 0.44 },
		{ index = 2, step = 1, t = "loot", text = "Collect Stolen Blasting Powder", status = "active", progress = { cur = 3, max = 16 }, map = 1429, x = 0.5, y = 0.5 },
	} } }
end
Polestar.Party = Polestar.Party or {}
Polestar.Party.StepLine = function() return "2 of 3 on this step" end
Polestar.Set("ui.shown", true)
${layout ? `T.SetLayout("${layout}")` : 'T.SetLayout()'}
E.Goto(3)
local function draw()
	GF.Layout()
	if GF.Render then GF.Render() end
	GF.UpdateParty()
	GF.Layout()
	stub.advance(1)
	GF.Layout()
end
draw()
local parts = T.GuideParts()
local placed = {}
for _, p in ipairs(GF.Placed()) do placed[p[1]] = true end
local rows = {}
for _, r in ipairs(GF.alongRows) do
	if r:IsShown() then
		local meta
		for _, c in ipairs({ r:GetChildren() }) do
			if rawget(c, "Text") and c:IsShown() then meta = c.Text:GetText() end
		end
		rows[#rows + 1] = { r.Text:GetText(), meta or false }
	end
end
local stack = {}
local own = parts.window
for _, c in ipairs({ own:GetChildren() }) do
	if rawget(c, "cards") then for _, b in ipairs(c.cards) do if b:IsShown() then stack[#stack + 1] = b end end end
end
emit({
	along = { placed.along or false, parts.along:IsShown(), parts.along.Label:GetText() },
	banner = { placed.banner or false, parts.banner:IsShown(), parts.banner.psKind or false, parts.banner.Text:GetText() or "" },
	bannerClose = parts.banner.Close:IsShown(),
	party = { placed.party or false, GF.party:IsShown() },
	rows = rows, cards = #stack,
})`;

const outside = (layout) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
	script: OUTSIDE(layout),
}).emitted[0];

test('under Atlas Along the way is a card above the window: no heading in it, the count by the distance, optional kept', () => {
	const out = outside('atlas');
	assert.equal(out.along[0], false, 'not in the window');
	assert.equal(out.along[1], true, 'shown on its card');
	assert.equal(out.along[2], 'ALONG THE WAY');
	assert.equal(out.rows.length, 2);
	assert.match(out.rows[0][0], /Chunk of Boar Meat/);
	assert.doesNotMatch(out.rows[0][0], /6\/10/, 'the count leaves the line');
	assert.match(out.rows[0][0], /optional/, 'the optional tag stays');
	assert.match(String(out.rows[0][1]), /^6\/10  ·  \d+ yd$/, `meta: ${out.rows[0][1]}`);
	assert.ok(out.cards >= 2, `cards above: ${out.cards}`);
});

test('under Atlas the Looking ahead banner stays in the window as a strip, with no ×', () => {
	const out = outside('atlas');
	assert.deepEqual(out.banner.slice(0, 3), [true, true, 'away']);
	assert.match(out.banner[3], /Looking ahead/);
	assert.equal(out.bannerClose, false, 'no ×: paging back or its link ends it');
});

test('under Atlas the party line is a card above the window', () => {
	assert.deepEqual(outside('atlas').party, [false, true]);
});

test("Polestar's own layout keeps Along the way, the banner and the party line in the window", () => {
	const out = outside(null);
	assert.deepEqual(out.along, [true, true, 'Along the way']);
	assert.match(out.rows[0][0], /6\/10/, 'the count stays in the line');
	assert.deepEqual(out.banner.slice(0, 3), [true, true, 'away']);
	assert.deepEqual(out.party, [true, true]);
	assert.equal(out.cards, 0);
});

// The arrow on the step's title: on the rail a ring of the arrow's colour
// round a gap round the current node, in place of the target bar; without it
// the node keeps its plain halo; in compact mode (no rail) the same.
const AIM = `
local person = parts.person
local function halo()
	for _, child in ipairs({ parts.window:GetChildren() }) do
		for _, t in ipairs({ child:GetRegions() }) do
			if t:GetDrawLayer() == "OVERLAY" and select(2, t:GetDrawLayer()) == 0 and t:IsShown() and math.floor(t:GetWidth()) == 18 then return t end
		end
	end
end
local function plainRing()
	for _, child in ipairs({ parts.window:GetChildren() }) do
		for _, t in ipairs({ child:GetRegions() }) do
			if t:GetDrawLayer() == "OVERLAY" and select(2, t:GetDrawLayer()) == 1 and t:IsShown() and math.floor(t:GetWidth()) == 16 then return t end
		end
	end
end
local function lines(row)
	local n, last = 0, nil
	for _, t in ipairs({ row:GetRegions() }) do
		if t:GetObjectType() == "Texture" and t:GetDrawLayer() == "OVERLAY" and t:IsShown() and t:GetHeight() <= 2 and t:GetWidth() >= 8 then n = n + 1; last = t end
	end
	return n, last
end
local function state(row)
	local n, t = lines(row)
	if not t then return { n = n } end
	local _, _, _, _, y = t:GetPoint(1)
	return { n = n, w = t:GetWidth(), y = y }
end`;

const TARGET_BAR = (v) => `Polestar.Set("guideWindow.targetBar", ${v})`;

test("on the rail the arrow on the step's title is a ring round its node, not the bar", () => {
	const out = hooks(`${AIM}
${TARGET_BAR(false)}
person.Mark:Show()
h.guideLayout(parts)
local h18 = halo()
local aimed = { tex = person.Mark:GetTexture() ~= nil, w = h18 and h18:GetWidth(), c = h18 and { h18:GetVertexColor() } }
local accent = { Polestar.Theme.Accent() }
person.Mark:Hide()
local plain = { halo = halo() ~= nil, ring = plainRing() ~= nil }
Polestar.Set("ui.compact", true)
person.Mark:Show()
h.guideLayout(parts)
emit({ aimed = aimed, accent = accent, plain = plain, compactTex = person.Mark:GetTexture() ~= nil, compactHalo = halo() ~= nil })`);
	assert.ok(out.aimed.w, 'the current node is ringed');
	assert.equal(out.aimed.tex, false, 'the bar is not drawn on the rail');
	assert.equal(out.aimed.w, 18, 'a 2px ring round a gap round the 10px node');
	assert.ok(out.aimed.c[3] === 1 && out.aimed.c.length === 4, 'solid');
	assert.ok(Math.hypot(out.aimed.c[0] - out.accent[0], out.aimed.c[1] - out.accent[1], out.aimed.c[2] - out.accent[2]) >= 0.25, `reads against the accent: ${out.aimed.c} / ${out.accent}`);
	assert.deepEqual(out.plain, { halo: false, ring: true }, 'not aimed: the plain halo');
	assert.equal(out.compactTex, false, 'compact mode keeps the rail: the ring round its node, not the bar');
	assert.equal(out.compactHalo, true);
});

// A goto-only step has no person: the core marks the goto row, and the title's
// ring follows it. The row draws no hairline under its text.
const withSteps = (src, steps) => src.replace(/steps = \{[\s\S]*?\n\t\},\n\}\)/, `steps = {\n${steps}\n\t},\n})`);
const GOTO_STEPS = '\t\t{ goals = { { t = "goto", map = 1429, x = 0.40, y = 0.30, text = "Go to the hill" } } },';
const TWO_STEPS = '\t\t{ goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" }, { t = "accept", quest = 33, title = "Wolves Across the Border", npc = 197, npcName = "Marshal McBride" } } },';
const guideHooks = (steps) => (script) => runAddon({
	stubs: ['stub_world.lua'], addons: ['Polestar', 'Polestar_Skin_Atlas'],
	script: `${withSteps(HOOKS, steps)}\n${script}`,
}).emitted[0];
const gotoHooks = guideHooks(GOTO_STEPS);
const twoHooks = guideHooks(TWO_STEPS);

test('a Go to step aimed at shows the ring on the title and no underline on its row', () => {
	const out = gotoHooks(`${AIM}
${TARGET_BAR(false)}
local row = parts.rows[1]
h.guideLayout(parts); local initial = halo() ~= nil
local pre = row.Mark:IsShown(); row.Mark:Hide()
h.guideLayout(parts)
local before = { halo = halo() ~= nil, line = state(row) }
row.Mark:Show()
local g = person.psGroup
local after = { initial = initial, pre = pre, halo = halo() ~= nil, line = state(row), mark = person.Mark:IsShown(), pp = person.psPerson, hg = person.psHeaderGoal ~= nil, kind = g and g.kind, header = row.psGoal and row.psGoal.header, gk = row.psGoal and row.psGoal.kind }
row.Mark:Hide()
emit({ before = before, after = after, back = { halo = halo() ~= nil, line = state(row) } })`);
	assert.equal(out.after.initial, true, "ring when marked at layout"); assert.equal(out.after.mark, false, 'the core marks the row, not the person');
	assert.equal(out.after.halo, true, `the ring shows though the title has no mark: ${JSON.stringify(out.after)}`);
	assert.equal(out.after.line.n, out.before.line.n, 'no underline');
	assert.equal(out.before.halo, false);
	assert.deepEqual(out.back, out.before, 'the arrow moves off: both go');
});

test('the ring shows whether or not the target bar is on', () => {
	for (const v of [true, false]) {
		const out = gotoHooks(`${AIM}
${TARGET_BAR(v)}
h.guideLayout(parts)
parts.rows[1].Mark:Show()
emit(halo() ~= nil)`);
		assert.equal(out, true, `targetBar ${v}`);
	}
});

test("the ring reads against a warm class accent and keeps the quest colour on a cool one", () => {
	const run = (setup) => hooks(`${AIM}
${setup}
${TARGET_BAR(false)}
Polestar.Theme.Refresh()
person.Mark:Show()
h.guideLayout(parts)
local ar, ag, ab = Polestar.Theme.Accent()
local qr, qg, qb = Polestar.Theme.Color("quest")
emit({ ring = { halo():GetVertexColor() }, accent = { ar, ag, ab }, quest = { qr, qg, qb } })`);
	const dist = (a, b) => Math.hypot(a[0] - b[0], a[1] - b[1], a[2] - b[2]);
	const rogue = run(`Polestar.Set("ui.classAccent", true); UnitClass = function() return "Rogue", "ROGUE", 4 end; RAID_CLASS_COLORS = { ROGUE = { r = 1, g = 0.96, b = 0.41 } }`);
	assert.ok(dist(rogue.ring, rogue.accent) >= 0.25, `ring ${rogue.ring} against accent ${rogue.accent}`);
	const paladin = run(`Polestar.Set("ui.classAccent", true); UnitClass = function() return "Paladin", "PALADIN", 2 end; RAID_CLASS_COLORS = { PALADIN = { r = 0.96, g = 0.55, b = 0.73 } }`);
	assert.ok(dist(paladin.ring, paladin.quest) < 0.01, `paladin keeps quest: ${paladin.ring}`);
	const gold = run('');
	assert.ok(dist(gold.ring, gold.accent) >= 0.25, `house gold: ring ${gold.ring} against accent ${gold.accent}`);
	assert.ok(dist(gold.ring, [0.58, 0.79, 1]) < 0.01, `house gold falls back to the npc blue: ${gold.ring}`);
	const halo = run('Polestar.Set("ui.skin", "halo")');
	assert.ok(dist(halo.ring, halo.accent) >= 0.25, `FFD100 skin: ring ${halo.ring} against accent ${halo.accent}`);
});

// Under Atlas the arrow's target row, a main goal, the "Go to" line or a card
// row, is lit by the core's wash (guideShows "markWash") in the target bar
// colour, fading across it, with no bar and no underline; the transparent
// style draws no fills and shows the bar instead; the target bar off, nothing.
// The person's light stays dark: the rail's ring marks the title.
const AIM_LOOK = `
local GF = Polestar.UI.GuideFrame
local function look(r)
	local m = rawget(r, "Mark")
	local l = m and rawget(m, "psLit")
	local lines = 0
	for _, t in ipairs({ r:GetRegions() }) do
		if t:GetObjectType() == "Texture" and t:GetDrawLayer() == "OVERLAY" and t:IsShown() and t:GetHeight() <= 2 and t:GetWidth() >= 8 then lines = lines + 1 end
	end
	local wash = 0
	if l and l:IsShown() then
		rawset(l, "SetGradient", function(_, _, a, b) wash = { a.r, a.g, a.b, a.a, b.a } end)
		GF.PaintMark(m)
	end
	return { mark = m and m:IsShown() or false, bar = m and m:IsShown() and m:GetAlpha() or 0, wash = wash, lines = lines }
end
local function looks(r)
	local out = { opaque = look(r) }
	Polestar.Set("ui.style", "transparent"); out.clear = look(r)
	Polestar.Set("ui.style", "standard")
	Polestar.Set("guideWindow.targetBarColor", { 1, 0, 0 }); out.colour = look(r)
	Polestar.Set("guideWindow.targetBarColor", false)
	Polestar.Set("guideWindow.targetBar", false); out.off = look(r)
	Polestar.Set("guideWindow.targetBar", true)
	return out
end`;
const live = (steps, script) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
	script: `${steps ? withSteps(GUIDE, steps) : GUIDE}
local T = Polestar.Theme
Polestar.Set("ui.shown", true)
T.SetLayout("atlas")
Polestar.UI.GuideFrame.Layout(); if Polestar.UI.GuideFrame.Render then Polestar.UI.GuideFrame.Render() end; stub.advance(1)
${AIM_LOOK}
${script}`,
}).emitted[0];
const washed = (out, what) => {
	assert.equal(out.opaque.mark, true, `${what}: marked`);
	assert.equal(out.opaque.bar, 0, `${what}: no bar beside the wash`);
	assert.equal(out.opaque.lines, 0, `${what}: no underline`);
	assert.ok(out.opaque.wash[3] > 0.1, `${what}: lit: ${JSON.stringify(out.opaque.wash)}`);
	assert.equal(out.opaque.wash[4], 0, `${what}: fading out across the row`);
	assert.deepEqual(out.colour.wash.slice(0, 3), [1, 0, 0], `${what}: in the target bar colour`);
	assert.ok(out.clear.bar === 1 && (out.clear.wash === 0 || out.clear.wash[3] === 0), `${what}: transparent: the bar, no fill: ${JSON.stringify(out.clear)}`);
	assert.ok(out.off.bar === 0 && (out.off.wash === 0 || out.off.wash[3] === 0), `${what}: target bar off: nothing: ${JSON.stringify(out.off)}`);
};

test('under Atlas the aimed Go to line is lit, not underlined; transparent shows the bar; off shows nothing', () => {
	const out = live(GOTO_STEPS, `
local r = GF.rows[1]
emit({ looks = looks(r), bar = Polestar.Get("guideWindow.targetBar"), failed = T.LayoutInfo("atlas").failed or false })`);
	assert.equal(out.failed, false);
	assert.equal(out.bar, true, 'Atlas leaves the target bar on');
	washed(out.looks, 'Go to');
});

test('under Atlas only the aimed main goal row is lit, and the person under the ring is not', () => {
	const out = live(TWO_STEPS, `
local a, b = GF.rows[1], GF.rows[2]
GF.ShowMark(a, false); GF.ShowMark(b, false)
GF.ShowMark(a, true)
local out = { a = looks(a), b = look(b) }
local person = T.GuideParts().person
GF.ShowMark(person, true)
local pl = rawget(person.Mark, "psLit")
out.personLit = pl and pl:IsShown() or false
GF.ShowMark(person, false)
emit(out)`);
	washed(out.a, 'goal row');
	assert.equal(out.b.mark, false, 'the other row: no mark');
	assert.equal(out.b.wash, 0, 'the other row: no wash');
	assert.equal(out.personLit, false, 'the ring marks the title, not a wash');
});

test("under Atlas the aimed card row (Along the way, While you're here) is lit the same", () => {
	const out = live(null, `
local E = Polestar.Engine
E.GetAlong = function()
	return { { index = 1, title = "Boars", goals = {
		{ index = 1, step = 1, t = "loot", text = "Collect Chunk of Boar Meat", status = "active", progress = { cur = 6, max = 10 }, map = 1429, x = 0.48, y = 0.44 },
		{ index = 2, step = 1, t = "loot", text = "Collect Stolen Blasting Powder", status = "active", progress = { cur = 3, max = 16 }, map = 1429, x = 0.5, y = 0.5 },
	} } }
end
E.GetWhileHereList = function()
	return { { step = 1, index = 2, t = "loot", here = "work", text = "Collect Stolen Blasting Powder", status = "active", progress = { cur = 3, max = 16 }, map = 1429, x = 0.5, y = 0.5 } }
end
E.Goto(3)
local target = { stepIndex = 1, goalIndex = 2, map = 1429, x = 0.5, y = 0.5 }
Polestar.Nav.GetTarget = function() return target end
GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1); GF.Layout(); stub.advance(1)
local aimed, other
for _, r in ipairs(GF.alongRows) do
	if r:IsShown() then if rawget(r, "Mark") and r.Mark:IsShown() then aimed = r else other = r end end
end
local out = { found = aimed ~= nil }
if aimed then out.along = looks(aimed) end
out.other = other and look(other) or false
-- While you're here: its row for the same goal.
local h = GF.HereRow(1)
out.here = look(h)
-- The arrow moves off: the mark goes.
target = { stepIndex = 9, goalIndex = 9, map = 1, x = 0.1, y = 0.1 }
stub.advance(1)
out.moved = aimed and look(aimed) or false
-- Atlas leaves: no card row keeps a mark.
target = { stepIndex = 1, goalIndex = 2, map = 1429, x = 0.5, y = 0.5 }
stub.advance(1)
T.SetLayout()
out.left = aimed and look(aimed) or false
emit(out)`);
	assert.equal(out.found, true, 'an Along the way row is marked');
	washed(out.along, 'Along the way');
	assert.equal(out.other.mark, false, 'the other row: no mark');
	assert.equal(out.here.mark, true, "While you're here: marked");
	assert.equal(out.here.bar, 0);
	assert.equal(out.here.lines, 0);
	assert.ok(out.here.wash[3] > 0.1, `While you're here: lit: ${JSON.stringify(out.here)}`);
	assert.equal(out.moved.mark, false, 'the arrow moves off: the mark goes');
	assert.equal(out.left.mark, false, 'Atlas leaves: the mark goes');
});

// A notice's action by the × (guideWindow.bannerLinks "right", Atlas's
// default), its text cut short: the link is as wide as the label it draws,
// so it stays inside its card. Some clients (and the playground) report the
// whole text's width from GetStringWidth once it is cut; the label does so here.
test("under Atlas a notice's long jump link stays inside its card", () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
T.SetLayout("atlas")
local banner = T.GuideParts().banner
local label = banner.Jump.Label
label.GetStringWidth = label.GetUnboundedStringWidth
local width = 260
GF.LayoutBanner(width, true, "outlevel", { guideId = "test/atlas", title = "Western Elwynn, Westfall and the Road to Darkshire" })
emit({
	links = Polestar.Get("guideWindow.bannerLinks"),
	link = banner.Jump:GetWidth(), label = label:GetWidth(), full = label:GetUnboundedStringWidth(),
	shown = banner.Jump:IsShown(), width = width,
})`,
	}).emitted;
	assert.equal(out.links, 'right');
	assert.equal(out.shown, true);
	assert.ok(out.full > out.label, `the label is cut: ${out.label} of ${out.full}`);
	assert.equal(out.link, Math.floor(out.label + 16 + 0.5), 'the link is as wide as its label');
	assert.ok(out.link + 33 <= out.width, `inside the card: link ${out.link} in ${out.width}`);
});

// The class-quest card is a part a layout may place itself (guidePlace
// "classCard"): Atlas lifts it above the window. A card of 60 px stands in
// for UI/ClassCard.lua's (its Layout and Frame), so the claim is checked
// without a class chain on screen.
test('under Atlas the class card is handed to the layout, not stacked in the window', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF, UI = Polestar.Theme, Polestar.UI.GuideFrame, Polestar.UI
Polestar.Set("ui.shown", true)
T.SetLayout("atlas")
local CC = UI.ClassCard
local f = CreateFrame("Frame", nil, PolestarGuideFrame)
f:Show()
CC.Layout = function() return 60 end
CC.Frame = function() return f end
local seen
local before = GF.HookValue
GF.HookValue = function(hook, name, ...)
	if hook == "guidePlace" and name == "classCard" then seen = true end
	return before(hook, name, ...)
end
GF.Layout()
emit({ seen = seen == true })`,
	}).emitted;
	assert.equal(out.seen, true, 'guidePlace "classCard" runs');
});

test('Atlas writes its caps labels through Polestar.Upper, so accents and Cyrillic rise too', () => {
	const src = require('node:fs').readFileSync(LAYOUT, 'utf8');
	const raw = src.split('\n').filter((l) => /string\.upper\(|:upper\(\)/.test(l) && !/^function Core\.upper/.test(l));
	assert.deepEqual(raw, [], 'caps go through Core.upper');
	assert.match(src, /^function Core\.upper\(s\) return \(P\.Upper and P\.Upper\(s\)\)/m);
});

// Compact mode under Atlas is the full window with the current step alone:
// the cards above (Still to do), the XP row and the Journey keep their places
// (GF.Shows "along", "xp", "journey"); Polestar's own layout leaves them out.
test('Atlas compact mode keeps Still to do, the XP row and the Journey; Polestar compact leaves them out', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T, GF = Polestar.Theme, Polestar.UI.GuideFrame
local function draw() GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1) end
local function state()
	-- A line for the XP row (the stub has no XP pace), laid out again.
	GF.xp.psHas = true
	GF.Layout()
	return { along = GF.Shows("along", not Polestar.Get("ui.compact")), xpShows = GF.Shows("xp", not Polestar.Get("ui.compact")), journey = GF.Shows("journey", not Polestar.Get("ui.compact")),
		xp = GF.xp:IsShown() }
end
Polestar.Set("ui.shown", true)
Polestar.Set("ui.skin", "atlas")
T.SetLayout("atlas")
draw()
local out = { full = state() }
Polestar.Set("ui.compact", true)
draw()
out.compact = state()
T.SetLayout()
draw()
out.house = state()
out.failed = T.LayoutInfo("atlas").failed or false
emit(out)`,
	}).emitted;
	assert.equal(out.failed, false, 'no hook failed');
	assert.deepEqual([out.full.xpShows, out.full.journey, out.full.xp], [true, true, true], 'full mode: both');
	assert.deepEqual([out.compact.along, out.compact.xpShows, out.compact.journey], [true, true, true], 'Atlas compact: the cards above (Still to do), the XP row and the Journey kept');
	assert.equal(out.compact.xp, true, 'the XP row shows in compact mode');
	assert.deepEqual([out.house.along, out.house.xpShows, out.house.journey, out.house.xp], [false, false, false, false], "Polestar's own compact: none");
});

// The Atlas card in Presets carries a Beta tag, from its TOC
// (## X-Polestar-Layout-Stage: beta), loaded or not.
test('the Atlas layout preset is tagged beta', () => {
	const toc = require('node:fs').readFileSync(path.join(ADDONS, 'Polestar_Layout_Atlas', 'Polestar_Layout_Atlas.toc'), 'utf8');
	const fields = [...toc.matchAll(/^## (X-[\w-]+):\s*(.*?)\s*$/gm)].map((m) => `[${JSON.stringify(m[1])}] = ${JSON.stringify(m[2])}`);
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Layout_Atlas'],
		login: true,
		script: `
stub.addons = { { name = "Polestar", loaded = true }, { name = "Polestar_Layout_Atlas", loaded = true } }
stub.addonMeta["Polestar_Layout_Atlas"] = { ${fields.join(', ')} }
local stage
for _, lp in ipairs(Polestar.Theme.LayoutPresets()) do if lp.id == "atlas" then stage = lp.stage end end
emit({ stage = stage or false })`,
	}).emitted;
	assert.deepEqual(out, { stage: 'beta' });
});

// The install's look page offers the guide window's layout when a layout
// addon is installed: Polestar's own, then Atlas tagged Beta; picking it
// puts it on.
test('the install offers Atlas as the guide window layout, tagged Beta', () => {
	const toc = require('node:fs').readFileSync(path.join(ADDONS, 'Polestar_Layout_Atlas', 'Polestar_Layout_Atlas.toc'), 'utf8');
	const fields = [...toc.matchAll(/^## (X-[\w-]+):\s*(.*?)\s*$/gm)].map((m) => `[${JSON.stringify(m[1])}] = ${JSON.stringify(m[2])}`);
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Layout_Atlas'],
		login: true,
		script: `
stub.addons = { { name = "Polestar", loaded = true }, { name = "Polestar_Layout_Atlas", loaded = true } }
stub.addonMeta["Polestar_Layout_Atlas"] = { ${fields.join(', ')} }
local UI = Polestar.UI
UI.Welcome.Show("look")
stub.advance(0.5)
local F = UI.Welcome.frame
local names, atlas = {}, nil
for _, c in ipairs(F.LayoutPick and F.LayoutPick.cards or {}) do
	if c:IsShown() then
		names[#names + 1] = c.Name:GetText()
		if c.psValue == "atlas" then atlas = c end
	end
end
if atlas then atlas:GetScript("OnClick")(atlas, "LeftButton") end
emit({ names = names, layout = Polestar.Theme.LayoutId() or false })`,
	}).emitted;
	assert.deepEqual(out.names, ['Polestar', 'Atlas (Beta)'], JSON.stringify(out));
	assert.equal(out.layout, 'atlas');
});

// Install's look preview under Atlas: one picture drawn again in look after
// look (the pointer over the looks) shows the last look alone, as a fresh
// picture of it does: no paper, corners or glare of a look drawn before.
test("under Atlas a look's card drawn again shows that look alone", () => {
	const toc = require('node:fs').readFileSync(path.join(ADDONS, 'Polestar_Layout_Atlas', 'Polestar_Layout_Atlas.toc'), 'utf8');
	const fields = [...toc.matchAll(/^## (X-[\w-]+):\s*(.*?)\s*$/gm)].map((m) => `[${JSON.stringify(m[1])}] = ${JSON.stringify(m[2])}`);
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Options', 'Polestar_Layout_Atlas', 'Polestar_Skin_Vellum', 'Polestar_Skin_Lumen', 'Polestar_Skin_Sheen', 'Polestar_Skin_Aurora'],
		login: true,
		script: `
stub.addons = { { name = "Polestar", loaded = true }, { name = "Polestar_Layout_Atlas", loaded = true } }
stub.addonMeta["Polestar_Layout_Atlas"] = { ${fields.join(', ')} }
local T, UI = Polestar.Theme, Polestar.UI
UI.Welcome.Show("look")
stub.advance(0.5)
local F = UI.Welcome.frame
for _, c in ipairs(F.LayoutPick and F.LayoutPick.cards or {}) do
	if c.psValue == "atlas" then c:GetScript("OnClick")(c, "LeftButton") end
end
local art = F.LookPage.Preview.Art
-- The textures shown in the picture, by texture and colour.
local function shown()
	local out = {}
	local function walk(f)
		for _, r in ipairs({ f:GetRegions() }) do
			if r:IsShown() and r.GetTexture then
				local c = { r:GetVertexColor() }
				out[#out + 1] = string.format("%s %.2f,%.2f,%.2f,%.2f", tostring(r:GetTexture()), c[1] or -1, c[2] or -1, c[3] or -1, c[4] or -1)
			end
		end
		for _, c in ipairs({ f:GetChildren() }) do if c:IsShown() then walk(c) end end
	end
	walk(art)
	table.sort(out)
	return out
end
T.DrawSkinCard(art, "polestar")
local fresh = shown()
for _, id in ipairs({ "vellum", "lumen", "sheen", "aurora", "polestar" }) do T.DrawSkinCard(art, id) end
emit({ layout = T.LayoutId() or false, fresh = fresh, again = shown() })`,
	}).emitted;
	assert.equal(out.layout, 'atlas');
	assert.ok(out.fresh.length > 0);
	const lingering = out.again.filter((t) => !out.fresh.includes(t));
	assert.deepEqual(lingering, [], 'pieces of a look drawn before still show');
	assert.deepEqual(out.again, out.fresh);
});

// Large text, then Atlas, then the text sizes back (the Atlas card in
// Presets puts the Large text preset's sizes back): the goal row takes the
// new size at once, not the one it had when Atlas first dressed it.
test('under Atlas a goal row follows a text size changed after Atlas dressed it', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
Polestar.Set("ui.shown", true)
local GF = Polestar.UI.GuideFrame
local F = _G.PolestarGuideFrame
local function goalSize()
	GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1)
	local found
	local function walk(f)
		for _, r in ipairs({ f:GetRegions() }) do
			if not found and r:IsShown() and r.GetFont and (r.GetText and r:GetText() or ""):find("Kobold Camp Cleanup", 1, true) then
				local _, s = r:GetFont(); found = s
			end
		end
		for _, c in ipairs({ f:GetChildren() }) do if c:IsShown() then walk(c) end end
	end
	walk(F)
	return found
end
local plain = goalSize()
Polestar.Set("guideWindow.goalSize", 1.25)
local large = goalSize()
Polestar.Theme.SetLayout("atlas")
local atlasLarge = goalSize()
Polestar.Set("guideWindow.goalSize", nil)
emit({ plain = plain, large = large, atlasLarge = atlasLarge, after = goalSize() })`,
	}).emitted;
	assert.ok(out.large > out.plain, JSON.stringify(out));
	assert.equal(out.after, out.plain, `back to its own size: ${JSON.stringify(out)}`);
});

// A game look (Forever) under Atlas: the quest tracker band the kit draws
// behind the step's title stays out (guideShows "kitHeader"; Atlas underlines
// the title itself), and back in Polestar's own layout. The goal the kit
// lights with its own selected card (Theme.KitRowLit) wears that card alone:
// the mark's wash over it ran out past the card's inset.
test('under Atlas a game look draws no title band and no wash over its lit goal', () => {
	const run = (layout) => runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Looks', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T = Polestar.Theme
local GF = Polestar.UI.GuideFrame
local header
local kitHeader = T.KitHeader
T.KitHeader = function(f, shown) if f == T.GuideParts().person then header = shown end return kitHeader(f, shown) end
Polestar.Set("ui.shown", true)
Polestar.Set("ui.skin", "forever")
${layout ? `T.SetLayout("${layout}")` : ''}
GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1)
GF.ApplyStyle()
local r = GF.rows[1]
GF.ShowMark(r, true)
local l = rawget(r.Mark, "psLit")
r.Text:SetText("Kill 8 Kobold Vermin 3/8")
GF.Hook("guideRow", r, { index = 1, t = "kill", status = "active", progress = { cur = 3, max = 8 } }, { current = true })
local count = { top = false, right = false }
for _, fs in ipairs({ r:GetRegions() }) do
	if fs:GetObjectType() == "FontString" and fs:IsShown() and fs:GetText() == "3/8" then
		for i = 1, fs:GetNumPoints() do
			local p, rel, _, x = fs:GetPoint(i)
			if p == "TOP" then count.top = rel == r.Text end
			if p == "RIGHT" then count.right = -x end
		end
	end
end
emit({ kit = T.Kit() ~= nil, header = header, kitLit = rawget(r, "psKitLit") or false, wash = l and l:IsShown() or false, mark = r.Mark:IsShown(),
	count = count, inset = T.Metric("guideLitInset", 4), litInset = GF.LookSpace("litInset", T.Metric("guideLitInset", 4)) })`,
	}).emitted[0];
	const atlas = run('atlas');
	assert.equal(atlas.kit, true, 'the Forever kit is in use');
	assert.equal(atlas.header, false, 'Atlas: no quest tracker band behind the title');
	assert.equal(atlas.kitLit, true, 'the kit lights the goal to do now');
	assert.equal(atlas.mark, true, 'the goal is marked');
	assert.equal(atlas.wash, false, 'no wash over the kit-lit goal');
	assert.equal(atlas.count.top, true, "the count sits on the text's first line");
	assert.equal(atlas.litInset, 0, "the layout sets where the kit's card stands: the row's edges");
	const own = run(null);
	assert.equal(own.header, true, "Polestar's own layout keeps the band");
	assert.equal(own.litInset, own.inset, "Polestar's own layout keeps the look's inset");
});

// Still to do's carried row reads as Optional's rows do: one line, the XP on
// the right, and its View (a click lists the quests) shown on the right only
// while the pointer is on the card, brighter on the row itself, the XP
// stepping left of it.
test("under Atlas Still to do's carried row is one line, its View shown on hover", () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T = Polestar.Theme
local GF = Polestar.UI.GuideFrame
Polestar.RoutePlan.Carried = function() return { { quest = 0, title = "The Absent Minded Prospector", status = "missed", xp = 6150 } } end
Polestar.Set("ui.shown", true)
T.SetLayout("atlas")
GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1)
local row
for _, r in ipairs({ T.GuideParts().along:GetChildren() }) do
	if rawget(r, "psFacts") and r.psFacts.count and r:IsShown() then row = r end
end
assert(row, "no carried row")
local m, card = row:GetChildren(), T.GuideParts().along
local meta = {}
for _, c in ipairs({ row:GetChildren() }) do if rawget(c, "Text") and c.Text:GetJustifyH() == "RIGHT" then m = c end end
local function state()
	stub.advance(0.3)
	local _, _, _, x = m.Text:GetPoint(1)
	return { view = rawget(m, "ViewLabel") and m.ViewLabel:IsShown() or false, right = -x, xp = m.Text:GetText() }
end
local text = row.Text:GetText()
local _, _, _, lx, ly = card.Label:GetPoint(1)
local _, _, _, _, ry = row:GetPoint(1)
local out = { oneLine = not text:find("\\n"), rest = state(), label = { lx, ly }, under = -ry - (-ly + math.ceil(card.Label:GetStringHeight())), rowH = row:GetHeight() }
card.IsMouseOver = function() return true end
out.card = state()
row.IsMouseOver = function() return true end
out.row = state()
local r, g, b = m.ViewLabel:GetTextColor()
out.lit = { r, g, b }
out.text = { T.Color("text") }
emit(out)`,
	}).emitted;
	assert.equal(out.oneLine, true, 'one line, no "Click to view" under it');
	assert.deepEqual(out.label, [14, -9], "the heading where Optional's stands");
	assert.equal(out.under, 3, "the first row 3 under the heading, as Optional's");
	assert.equal(out.rowH, 23, "a row as tall as Optional's");
	assert.equal(out.rest.view, false, 'View hidden off the card');
	assert.match(out.rest.xp, /6,150 XP/);
	assert.equal(out.card.view, true, 'View on the right with the pointer on the card');
	assert.ok(out.card.right > out.rest.right, `the XP steps left of View: ${out.rest.right} -> ${out.card.right}`);
	assert.deepEqual(out.lit.map((v) => v.toFixed(3)), out.text.slice(0, 3).map((v) => v.toFixed(3)), 'brighter on the row');
});

// Every card above the window wears one card's measures (Optional's): its
// heading 14 in and 9 down, its first row 3 under the heading, a one-line row
// 23 tall with its icon and right column on the line's middle, its foot 6
// under the last row. While you're here's second line stays unseen (Polestar
// shows it again at each distance refresh).
test('under Atlas every card above the window has the same heading, row and foot', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', 'Polestar_Skin_Atlas', 'Polestar_Layout_Atlas'],
		script: `${GUIDE}
local T = Polestar.Theme
local GF = Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
T.SetLayout("atlas")
GF.Layout(); stub.advance(1)
Polestar.RunCommand("atlas test")
stub.advance(1); GF.Layout(); stub.advance(1)
local parts = T.GuideParts()
local stack = PolestarGuideFrameCards
local function y(f) local _, _, _, _, v = f:GetPoint(1) return v end
local function head(label)
	local _, _, _, x, v = label:GetPoint(1)
	return { x, v, v - math.ceil(label:GetStringHeight()) - 3 }
end
local out = {}
local function firstRow(rows)
	for _, r in ipairs(rows) do if r:IsShown() then return r end end
end
local here = firstRow(rawget(parts.here, "Rows") or {})
out.here = { head = head(parts.here.Label), row = y(here), h = here:GetHeight(), sub = here.Sub:IsShown() and here.Sub:GetAlpha() or 0 }
here.Sub:Show()
out.here.subAfter = here.Sub:GetAlpha()
local along = {}
for _, r in ipairs({ parts.along:GetChildren() }) do if rawget(r, "psFacts") ~= nil or rawget(r, "psStep") then along[#along + 1] = r end end
table.sort(along, function(a, b) return y(a) > y(b) end)
local a = firstRow(along)
out.along = { head = head(parts.along.Label), row = y(a), h = a:GetHeight() }
local opt = stack.opt
local o = firstRow(opt.Rows)
out.opt = { head = head(opt.Label), row = y(o), h = o:GetHeight() }
local tr = stack.train
local _, _, _, _, iy = tr.Icon:GetPoint(1)
out.train = { head = head(tr.Label), icon = iy, foot = tr:GetHeight() }
emit(out)`,
	}).emitted;
	for (const name of ['here', 'along', 'opt']) {
		const c = out[name];
		// Optional's notes (a tip line) stand over its heading.
		if (name !== 'opt') assert.deepEqual(c.head.slice(0, 2), [14, -9], `${name}: the heading 14 in, 9 down`);
		else assert.equal(c.head[0], 14, 'opt: the heading 14 in');
		assert.equal(c.row, c.head[2], `${name}: the first row 3 under the heading`);
		assert.ok(c.h >= 23 && (c.h - 23) % 1 === 0, `${name}: a row at least 23 tall (${c.h})`);
	}
	assert.equal(out.opt.h, 23);
	assert.deepEqual(out.train.head.slice(0, 2), [14, -9], 'training: the heading 14 in, 9 down');
	assert.equal(out.train.icon, out.train.head[2] - 12, "training: its icon on the row's middle");
	assert.equal(out.train.foot, -(out.train.head[2] - 23) + 6, 'training: its foot 6 under the row');
	assert.equal(out.here.sub, 0, "While you're here: its second line unseen");
	assert.equal(out.here.subAfter, 0, 'and still unseen when Polestar shows it again');
});

// Every button of the header bar takes the skin's plate alike: Hearth's plank
// on all of them (Skip and All steps with Menu, Lookup, Report, Nearby), none
// of them in another skin.
test('the header bar buttons are plated alike in Hearth and bare in Polestar', () => {
	const script = (skin) => `${GUIDE}
Polestar.Set("ui.skin", ${JSON.stringify(skin)})
Polestar.Set("ui.shown", true)
Polestar.UI.GuideFrame.Layout()
stub.advance(1)
local nav = Polestar.Theme.GuideParts().nav
local out = {}
for _, key in ipairs({ "Menu", "Lookup", "Report", "Nearby", "AllSteps", "Skip" }) do
	local f = rawget(nav[key], "psFrame")
	out[key] = f ~= nil and f:IsShown() and true or false
end
emit(out)`;
	const keys = ['Menu', 'Lookup', 'Report', 'Nearby', 'AllSteps', 'Skip'];
	for (const [skin, want] of [['hearth', true], ['polestar', false]]) {
		const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(skin) }).emitted;
		for (const k of keys) assert.equal(out[k], want, `${skin}: ${k}`);
	}
});
