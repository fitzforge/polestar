'use strict';
// Tab styles (addon/Polestar/UI/TabStyles): with edge tabs the window's lines
// along the tabs' edge are cut under the active tab (drawn again as two
// pieces), and come back whole, at their own alpha, with another style.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const SCRIPT = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/tabs", pack = "test", title = "Tabs", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } } })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
Polestar.Set("ui.border", true)
Polestar.Set("guideWindow.border", true)
Polestar.Set("guideWindow.tabs", true)
local GF = Polestar.UI.GuideFrame
local function draw() GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1) end
local F = _G.PolestarGuideFrame
local function state()
	local top = F.psBorder and F.psBorder[1]
	local pieces, pieceAlpha = 0, nil
	for _, r in ipairs({ F:GetRegions() }) do
		if r ~= top and r:IsShown() and r.GetVertexColor and top and r:GetHeight() == top:GetHeight() and r:GetAlpha() ~= 0 then
			local a, b = { r:GetVertexColor() }, { top:GetVertexColor() }
			if a[1] == b[1] and a[2] == b[2] and a[3] == b[3] and r:GetDrawLayer() == top:GetDrawLayer() and select(2, r:GetDrawLayer()) == select(2, top:GetDrawLayer()) then pieces = pieces + 1; pieceAlpha = select(4, r:GetVertexColor()) end
		end
	end
	-- A texture's alpha is its colour's (as in the client).
	return { border = top ~= nil and top:IsShown(), alpha = top and select(4, top:GetVertexColor()), pieces = pieces, pieceAlpha = pieceAlpha }
end
local first = state()
Polestar.Set("guideWindow.tabStyle", "edge"); draw()
local edge = state()
Polestar.Set("guideWindow.tabStyle", "underline"); draw()
local underline = state()
-- The strip in compact mode stands as edge tabs; back out of it, the line
-- has its own alpha again.
Polestar.Set("guideWindow.tabStyle", "strip"); draw()
Polestar.Set("ui.compact", true); draw()
local compact = state()
Polestar.Set("ui.compact", false); draw()
local stripped = state()
Polestar.Set("guideWindow.tabStyle", "underline")
emit({ first = first, edge = edge, underline = underline, compact = compact, strip = stripped })`;

test('edge tabs cut the window border under the active tab; another style gives it back whole', () => {
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: SCRIPT }).emitted;
	assert.equal(out.edge.border, true, JSON.stringify(out));
	assert.equal(out.edge.alpha, 0, 'the whole line is hidden under edge tabs');
	assert.ok(out.edge.pieces >= 2, `two pieces stand for it: ${JSON.stringify(out)}`);
	assert.ok(out.first.alpha > 0, `the line's own alpha: ${out.first.alpha}`);
	assert.equal(out.underline.alpha, out.first.alpha, 'whole again with another style, at its own alpha (not 1)');
	assert.equal(out.edge.pieceAlpha, out.first.alpha, 'the pieces at the line\'s own alpha');
	assert.equal(out.compact.alpha, 0, 'compact mode: the strip as edge tabs cuts it');
	assert.equal(out.compact.pieceAlpha, out.first.alpha, 'and its pieces at its alpha');
	assert.ok(out.compact.pieces >= 2, 'two pieces stand for it');
	assert.equal(out.strip.alpha, out.first.alpha, 'out of compact mode: its own alpha again');
});

// The side strip and the edge tabs wear the window's own paint, in every
// look: the strip's line on the window's side is open, and the window's left
// line is cut beside the lit tab, so the two read as one shape.
test('the side strip and edge tabs take the window paint in every look, the lit tab joined to the window, no shadow of their own', () => {
	const script = SCRIPT.replace(/Polestar\.Set\("guideWindow\.tabStyle", "edge"\); draw\(\)[\s\S]*$/, `
		local Theme = Polestar.Theme
		local out = {}
		for _, c in ipairs(Theme.SkinChoices()) do
			Polestar.Set("ui.skin", c.value)
			Polestar.Set("guideWindow.tabStyle", "strip"); draw()
			local own = GF.TabStyleFrames()
			local s = own.side
			local sb = rawget(s, "psBorder")
			local left = F.psBorder and F.psBorder[3]
			local below = not (rawget(s, "psShadow") and s.psShadow:IsShown())
			local leftCut = left == nil or left:GetAlpha() == 0
			Polestar.Set("guideWindow.tabStyle", "edge"); draw()
			local tab = own.edge.tabs[1]
			local tb = rawget(tab, "psBorder")
			out[#out + 1] = { skin = c.value, painted = s.psSkin ~= nil and s.psSkin.skin ~= nil, below = below,
				open = sb == nil or sb[4]:GetAlpha() == 0, leftCut = leftCut,
				tabPainted = tab.psSkin ~= nil, tabFoot = tb == nil or tb[2]:GetAlpha() == 0,
				tabBelow = not (rawget(tab, "psShadow") and tab.psShadow:IsShown()) }
		end
		Polestar.Set("guideWindow.tabStyle", "underline"); draw()
		emit({ looks = out, whole = F.psBorder and F.psBorder[3]:GetAlpha() })`);
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script }).emitted;
	assert.ok(out.looks.length >= 3, `looks tried: ${out.looks.length}`);
	for (const l of out.looks) {
		assert.deepEqual(l, { skin: l.skin, painted: true, below: true, open: true, leftCut: true, tabPainted: true, tabFoot: true, tabBelow: true }, l.skin);
	}
	assert.equal(out.whole, 1, 'with the underline style the left line is whole again');
});

// Compact mode keeps the player's tab style: the strip down the left stands
// as the edge tabs above the window, edge and the switcher stay; underline
// gives way to the slim strip, and only with two guides open.
test('compact mode keeps the tab style; strip goes on the top edge; underline is the slim strip from two tabs', () => {
	const script = SCRIPT.replace(/Polestar\.Set\("guideWindow\.tabStyle", "edge"\)[\s\S]*$/, `
Polestar.RegisterGuide({ id = "test/tabs2", pack = "test", title = "Tabs two", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 33, title = "Wolves Across the Border" } } } } })
local function at(style, compact)
	Polestar.Set("guideWindow.tabStyle", style)
	Polestar.Set("ui.compact", compact)
	draw()
	return { style = GF.TabStyle() or false, strip = GF.StripShown() }
end
local out = {}
for _, s in ipairs({ "underline", "switcher", "edge", "strip" }) do out[s .. "1"] = at(s, true) end
Polestar.Engine.OpenTab("test/tabs2", false)
stub.advance(0.6)
for _, s in ipairs({ "underline", "switcher", "edge", "strip" }) do
	out[s .. "2"] = at(s, true)
	out[s .. "Full"] = at(s, false)
end
emit(out)`);
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script }).emitted;
	assert.deepEqual(out.underline1, { style: false, strip: false }, 'one guide: the navigator names it');
	assert.deepEqual(out.underline2, { style: false, strip: true }, 'two guides: the slim strip');
	assert.deepEqual(out.underlineFull, { style: 'underline', strip: true });
	for (const s of ['switcher', 'edge']) {
		assert.deepEqual(out[`${s}2`], { style: s, strip: false }, `${s} in compact mode`);
		assert.deepEqual(out[`${s}Full`], { style: s, strip: false }, `${s} out of it`);
	}
	assert.deepEqual(out.strip1, { style: 'edge', strip: false }, 'strip in compact mode: the edge tabs');
	assert.deepEqual(out.strip2, { style: 'edge', strip: false });
	assert.deepEqual(out.stripFull, { style: 'strip', strip: false }, 'strip out of compact mode');
});

// The edge tabs join the window without a seam: they take its ground colour
// and border setting, the house look's shade under a tab's foot is gone, and
// the tabs not lit stand just past the window's own lines (a thick border, the
// shade), so its edge runs whole under them; the lit one stands on the edge.
test('edge tabs join the window: its ground and border, no shade at the foot, the unlit ones past its edge', () => {
	const script = SCRIPT.replace(/Polestar\.Set\("guideWindow\.tabStyle", "edge"\)[\s\S]*$/, `
Polestar.RegisterGuide({ id = "test/tabs2", pack = "test", title = "Tabs two", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 33, title = "Wolves Across the Border" } } } } })
Polestar.Engine.OpenTab("test/tabs2", false)
stub.advance(0.6)
Polestar.Set("ui.skin", "polestar")
Polestar.Set("ui.borderSize", 3)
Polestar.Set("guideWindow.bgColor", { 0.2, 0.3, 0.4 })
local px = Polestar.Theme.Pixel(F)
local function at(style, compact)
	Polestar.Set("ui.style", style)
	Polestar.Set("ui.compact", compact)
	Polestar.Set("guideWindow.tabStyle", "edge"); draw(); draw()
	local e = GF.TabStyleFrames().edge
	local on, off
	for _, b in ipairs(e.tabs) do
		if b:IsShown() then if b.psActive then on = b else off = b end end
	end
	local function lift(b) return select(5, b:GetPoint(1)) end
	local sk = rawget(on, "psSkin")
	local shade = sk and sk.edge and sk.edge[3]
	local fe = rawget(F, "psSkin") and F.psSkin.edge
	return { bare = on.psBare == F.psBare, color = on.psBgColor == F.psBgColor and on.psBgColor ~= nil,
		noBorder = on.psNoBorder == F.psNoBorder, footShade = shade == nil or shade:GetAlpha() == 0,
		onLift = lift(on), offLift = lift(off), addLift = lift(e.Add),
		windowShade = fe and fe[2] and fe[2]:IsShown() or false }
end
local out = { opaque = at("standard", true), full = at("standard", false), clear = at("transparent", true) }
Polestar.Set("guideWindow.border", false)
out.noBorder = at("standard", true)
out.noBorder.tabBorder = GF.TabStyleFrames().edge.tabs[1].psNoBorder
out.px = px
emit(out)`);
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script }).emitted;
	for (const k of ['opaque', 'full', 'noBorder']) {
		const o = out[k];
		assert.equal(o.bare, true, `${k}: ${JSON.stringify(o)}`);
		assert.equal(o.color, true, `${k}: the window's ground colour on the tab`);
		assert.equal(o.noBorder, true, `${k}: the window's border setting on the tab`);
		assert.equal(o.footShade, true, `${k}: no shade under the tab's foot`);
		assert.equal(o.onLift, 0, `${k}: the lit tab stands on the window's edge`);
	}
	// A 3px border reaches two pixels past the edge, the shade one more.
	const past = 2 * out.px + (out.opaque.windowShade ? out.px : 0);
	assert.ok(Math.abs(out.opaque.offLift - past) < 1e-6, `unlit tab past the window's lines: ${JSON.stringify(out.opaque)}`);
	assert.ok(Math.abs(out.opaque.addLift - past) < 1e-6, 'the + tab too');
	assert.ok(Math.abs(out.full.offLift - past) < 1e-6, 'the same out of compact mode');
	assert.equal(out.clear.bare, true, 'transparent: the tab is bare with the window');
	assert.equal(out.clear.offLift, 0, 'transparent: no lines to stand past');
	assert.equal(out.noBorder.tabBorder, true, 'no window border: none on the tab');
	assert.ok(out.noBorder.offLift <= out.px + 1e-6, 'no border: past the shade alone');
});

test('Default tab style: nothing saved, so the layout\'s style shows and follows the layout', () => {
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: `
stub.login()
local P = Polestar
P.Set("guideWindow.tabStyle", "edge")
local saved = P.Get("guideWindow.tabStyle")
P.SetLayoutDefaults({ ["guideWindow.tabStyle"] = "strip" })
local kept = P.Get("guideWindow.tabStyle")
-- The Default choice: nothing stored.
P.Set("guideWindow.tabStyle", nil)
local layout = P.Get("guideWindow.tabStyle")
local stored = P.GetStored("guideWindow.tabStyle")
P.SetLayoutDefaults(nil)
emit({ saved = saved, kept = kept, layout = layout, stored = stored == nil, base = P.Get("guideWindow.tabStyle") })` }).emitted;
	assert.equal(out.saved, 'edge');
	assert.equal(out.kept, 'edge', 'a saved style beats the layout\'s default');
	assert.equal(out.layout, 'strip', 'Default shows the layout\'s style');
	assert.equal(out.stored, true, 'Default stores nothing');
	assert.equal(out.base, 'underline', 'and follows the layout back to Polestar\'s own');
});

// Three tabs in a narrow window: the tabs not in view keep a few letters of
// their title, the level range gives way first (a range with no name tells
// nothing).
test('a narrow tab keeps its title before its level range', () => {
	const script = SCRIPT.replace(/Polestar\.Set\("guideWindow\.tabStyle", "edge"\)[\s\S]*$/, `
for i = 2, 3 do
	Polestar.RegisterGuide({ id = "test/tabs" .. i, pack = "test", title = "Westfall and the Dead Mines " .. i, minLevel = 10, maxLevel = 20,
		steps = { { goals = { { t = "accept", quest = 30 + i, title = "Quest " .. i } } } } })
end
Polestar.Set("guideWindow.tabStyle", "underline")
Polestar.Engine.OpenTab("test/tabs2", false)
Polestar.Engine.OpenTab("test/tabs3", false)
stub.advance(0.6)
F:SetWidth(300)
draw()
local strip
for _, c in ipairs({ F:GetChildren() }) do if type(c) == "table" and c.psCount then strip = c end end
local tabs = {}
for _, b in ipairs({ strip:GetChildren() }) do
	if type(b) == "table" and type(rawget(b, "Label")) == "table" and type(rawget(b, "Range")) == "table" and b:IsShown() then
		tabs[#tabs + 1] = { title = b.Label:IsShown() and b.Label:GetWidth() or 0, full = b.psTitleW, range = b.Range:IsShown(), w = b:GetWidth() }
	end
end
emit({ n = strip.psCount, tabs = tabs })`);
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script }).emitted;
	assert.equal(out.n, 3, JSON.stringify(out));
	assert.equal(out.tabs.length, 3, JSON.stringify(out));
	for (const t of out.tabs) {
		assert.ok(t.title >= 1, `every tab shows some of its title: ${JSON.stringify(out.tabs)}`);
		if (t.range) assert.ok(t.title >= Math.min(t.full, 30), `a range shows only beside a few letters of the title: ${JSON.stringify(t)}`);
	}
});

// A game look leaves its frame open on the window's side of the side strip
// (Theme.KitOpen), and in Classic stretches its tile there. In the
// transparent style the tabs are bare like the window, in every skin: no
// ground, no frame, on the strip, its unlit tabs and the edge tabs; the lit
// tab keeps only its mark.
test('transparent: the side strip and edge tabs draw no ground or frame in any skin', () => {
	const fs = require('node:fs');
	const path = require('node:path');
	// Our skins are folders of Polestar_Skins since 0.4.3 (#3507): one add-on, every skin inside.
	const ownSkins = fs.readdirSync(path.join(__dirname, '..', 'addon', 'Polestar_Skins', 'Skins')).sort();
	const script = SCRIPT.replace(/Polestar\.Set\("guideWindow\.tabStyle", "edge"\)[\s\S]*$/, `
Polestar.RegisterGuide({ id = "test/tabs2", pack = "test", title = "Tabs two", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 33, title = "Wolves Across the Border" } } } } })
Polestar.Engine.OpenTab("test/tabs2", false)
stub.advance(0.6)
Polestar.Theme._testShowHidden = true
-- Every texture under f that would draw: shown up the chain, not clear.
local function painted(f, out, name)
	if not f:IsShown() then return end
	for _, r in ipairs({ f:GetRegions() }) do
		if r:GetObjectType() == "Texture" and r:IsShown() and (r:GetDrawLayer() == "BACKGROUND" or r:GetDrawLayer() == "BORDER") then
			local a = r:GetAlpha() * (select(4, r:GetVertexColor()) or 1)
			if a > 0.01 then out[#out + 1] = name .. ":" .. tostring(r:GetTexture()) end
		end
	end
	-- The lit tab keeps its mark (the accent bar, or a skin's own: Lanterns' pill).
	for i, c in ipairs({ f:GetChildren() }) do if not c.psActive then painted(c, out, name .. "." .. i) end end
end
local res = {}
for _, c in ipairs(Polestar.Theme.SkinChoices()) do
	Polestar.Set("ui.skin", c.value)
	for _, style in ipairs({ "standard", "transparent" }) do
		Polestar.Set("ui.style", style)
		for _, tabs in ipairs({ "strip", "edge" }) do
			Polestar.Set("guideWindow.tabStyle", tabs); draw(); draw()
			local fr = GF.TabStyleFrames()
			local f = tabs == "strip" and fr.side or fr.edge
			local out, own = {}, {}
			painted(f, out, tabs)
			-- What the window itself still draws (a skin's marks of its
			-- extent while transparent: Lumen's corner ticks): the tabs may
			-- draw that too, nothing else.
			local win = {}
			for _, r in ipairs({ F:GetRegions() }) do
				if r:GetObjectType() == "Texture" and r:IsShown() and (r:GetDrawLayer() == "BACKGROUND" or r:GetDrawLayer() == "BORDER") then
					local a = r:GetAlpha() * (select(4, r:GetVertexColor()) or 1)
					if a > 0.01 then win[tostring(r:GetTexture())] = true end
				end
			end
			for _, k in ipairs(out) do
				if not win[k:match(":(.*)$")] then own[#own + 1] = k end
			end
			res[#res + 1] = { skin = c.value, style = style, tabs = tabs, shown = f:IsShown(), bare = F.psBare and true or false, painted = out, own = own }
		end
	end
end
emit(res)`);
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar', 'Polestar_Skins'], script }).emitted;
	const skins = new Set(out.map((r) => r.skin));
	for (const k of ['polestar', 'classic', 'forever']) assert.ok(skins.has(k), `${k} among the skins: ${[...skins]}`);
	assert.ok(skins.size >= 4 + ownSkins.length, `every skin of Polestar_Skins: ${[...skins]}`);
	for (const r of out) {
		const at = `${r.skin} ${r.style} ${r.tabs}`;
		assert.equal(r.shown, true, `${at}: shown`);
		if (r.style === 'transparent') {
			assert.equal(r.bare, true, at);
			assert.deepEqual(Object.values(r.own), [], `${at}: nothing painted under the tabs the window does not paint`);
		}
	}
	// The opaque look has its ground (the check sees a painted ground).
	assert.ok(out.some((r) => r.style === 'standard' && Object.values(r.painted).length > 0), 'an opaque strip draws its ground');
});
