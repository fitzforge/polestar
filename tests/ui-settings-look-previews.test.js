'use strict';
// Every Look page's live preview on the new settings page (Grouped.lua's
// Preview panel, UI/Preview.lua's bands): on every tab, through each thing
// that lays a band out again (a tab switch, its picker's pick, a watched
// setting, a theme refresh, a resize, the panel hidden and shown), the
// preview stays in the side panel at its width and the band's height, and
// the slot over the rows holds no preview. The classic page still pins it in
// that slot. Against the real addon's modules and the fakes of
// tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

// -> { { page, tab, <step> = "ok" | what is wrong } } for every Look tab.
function walk(script) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {}, optionsLayout = "grouped" }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local G = O.Grouped
			local W = Polestar.Widgets
			local P = Polestar.UI.Preview
			Polestar.Set("ui.optionsSize", { 1500, 900 })
			Polestar.UI.ShowOptions()
			-- The previews shown in the side panel (the stub lists a child
			-- set under the same parent twice: counted once).
			local function sideHosts()
				local f, n, h, seen = G._side(), 0, nil, {}
				if not f then return 0 end
				for _, c in ipairs({ f:GetChildren() }) do
					if rawget(c, "psIsHost") and c:IsShown() and not seen[c] then
						seen[c] = true
						n, h = n + 1, c
					end
				end
				return n, h
			end
			local function state()
				local w, side = O.frame, G._side()
				local held = rawget(W.ShellPreviewSlot(w), "psHost")
				local n, h = sideHosts()
				local bad = {}
				if not (side and side:IsShown()) then bad[#bad + 1] = "no side panel" end
				if n ~= 1 then bad[#bad + 1] = n .. " previews in the side panel" end
				if held and rawget(held, "psIsHost") then bad[#bad + 1] = "preview in the top slot" end
				local ph = w.psPreviewH or 0
				if ph ~= 0 and not (held and not rawget(held, "psIsHost")) then bad[#bad + 1] = "top slot " .. ph .. " tall" end
				if h then
					local _, rel = h:GetPoint(1)
					if rel ~= side or h:GetNumPoints() ~= 1 then bad[#bad + 1] = "preview anchored off the side panel" end
					if math.abs(h:GetWidth() - (side:GetWidth() - 24)) > 1 then bad[#bad + 1] = "preview " .. h:GetWidth() .. " wide in a " .. side:GetWidth() .. " panel" end
					local f = h.Frame
					if f and P.IsBand(f) then
						if f.psWidth and math.abs(f.psWidth - h:GetWidth()) > 1 then bad[#bad + 1] = "band laid out " .. f.psWidth .. " wide" end
						local want = math.max(1, P.Snap(h, f.psHeight or 0))
						if math.abs(h:GetHeight() - want) > 1 then bad[#bad + 1] = "preview " .. h:GetHeight() .. " tall, band " .. want end
					end
				end
				return #bad == 0 and "ok" or table.concat(bad, "; ")
			end
			local function band()
				local _, h = sideHosts()
				local f = h and h.Frame
				if f and P.IsBand(f) then return f, h end
			end
			local rows = {}
			for _, g in ipairs(G.Tree()) do if g.key == "look" then
				for _, p in ipairs(g.pages) do
					local tabs = G.Tabs(p)
					for i, t in ipairs(tabs) do
						local r = { page = p.key, tab = t.name }
						rows[#rows + 1] = r
						local function go() G.Select(p.key, t.name) end
						go()
						${script}
					end
				end
			end end
			emit(rows)`,
	}).emitted[0];
}

function failures(rows, steps) {
	const out = [];
	for (const r of rows) {
		for (const s of steps) {
			if (r[s] !== undefined && r[s] !== 'ok' && r[s] !== '-') out.push(`${r.page} / ${r.tab} / ${s}: ${r[s]}`);
		}
	}
	return out;
}

const STEPS = ['first', 'switch', 'again', 'watch', 'theme', 'resize', 'toggle'];

test('every Look tab keeps its preview in the side panel, at its width and height, through each re-layout', () => {
	const rows = walk(`
		r.first = state()
		local other = tabs[i % #tabs + 1]
		if other ~= t then G.Select(p.key, other.name); go() end
		r.switch = state()
		-- Its picker's pick changed (a hovered row, the dropdown): P.Again.
		local f = band()
		if f then P.Again(f); r.again = state() else r.again = "-" end
		-- A watched setting and a theme refresh lay the band out again: the
		-- preview takes the band's height (squeezed first, so it must).
		f = band()
		local h = select(2, band())
		if f and f.psWatch and f.psWatch[1] then
			h:SetHeight(1)
			Polestar.Fire("SETTING_CHANGED", f.psWatch[1] .. "lookPreviewsTest")
			r.watch = state()
		else r.watch = "-" end
		f, h = band()
		if f then
			h:SetHeight(1)
			Polestar.Theme.Refresh()
			r.theme = state()
		else r.theme = "-" end
		Polestar.Set("ui.optionsSize", { 1300, 820 }); G.Relayout(); r.resize = state()
		Polestar.Set("ui.optionsSize", { 1500, 900 }); G.Relayout()
		G.SetPreviewHidden(true); G.SetPreviewHidden(false); r.toggle = state()`);
	const pages = new Set(rows.map((r) => r.page));
	assert.deepEqual([...pages], ['guidewindow', 'theme', 'arrow', 'mappins', 'routelines', 'buttons', 'alerts', 'trackers']);
	assert.ok(rows.length >= pages.size * 2, 'every Look page has its tabs');
	assert.ok(rows.filter((r) => r.again !== '-').length === rows.length, 'every Look tab shows a band');
	assert.deepEqual(failures(rows, STEPS), []);
});

test('the classic page still pins every Look tab\'s preview in the slot over the rows', () => {
	const rows = walk(`
		G.SetOn(false)
		O.Select(p.key, t.name)
		local w = O.frame
		local slot = W.ShellPreviewSlot(w)
		local held = rawget(slot, "psHost")
		local bad = {}
		if not (held and rawget(held, "psIsHost")) then bad[#bad + 1] = "no preview in the slot" end
		if held and held:GetParent() ~= slot then bad[#bad + 1] = "preview not under the slot" end
		if (w.psPreviewH or 0) <= 0 then bad[#bad + 1] = "slot 0 tall" end
		if G._side() and G._side():IsShown() then bad[#bad + 1] = "side panel shown" end
		r.classic = #bad == 0 and "ok" or table.concat(bad, "; ")
		G.SetOn(true)
		go()
		r.back = state()`);
	assert.deepEqual(failures(rows, ['classic', 'back']), []);
});
