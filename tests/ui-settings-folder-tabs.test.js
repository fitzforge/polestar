'use strict';
// The new settings page's folder tabs (W.FolderTabs in addon/Polestar/Theme/
// Widgets.lua, drawn by addon/Polestar_Options/UI/Grouped.lua): a boxed tab
// with an icon before its label, every icon in a bar unique and one of the
// addon's own glyphs (Media/UI); the active tab raised and joined to the body
// with no line under it; a filled dot for a changed row on the tab, a hollow
// one for a change only under a closed parent; icons alone, the label in the
// tooltip, where the tabs don't fit. The current page builds none. Against
// the real addon's modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

// The addon's fixed icon set: the glyphs under Media/UI, by name.
const GLYPHS = new Set(fs.readdirSync(path.join(__dirname, '..', 'addon', 'Polestar', 'Media', 'UI'))
	.map((f) => f.replace(/\.[^.]+$/, '')));

function run(script, saved) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: saved || 'PolestarDB = { settings = {}, optionsLayout = "grouped" }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local G = O.Grouped
			-- The folder tabs on screen: { icons, labels, active button }.
			local function bar()
				local f = rawget(O.frame, "FolderTabs")
				if not (f and f:IsShown()) then return nil end
				local out = { icons = {}, labels = {} }
				for _, b in ipairs(f.buttons) do
					if b:IsShown() then
						out.icons[#out.icons + 1] = b.psIcon
						out.labels[#out.labels + 1] = b.psTip
						if b.psOn then out.active = b end
					end
				end
				return out
			end
			${script}`,
	}).emitted;
}

test('folder tabs: an icon before each label, unique in the bar, the active one raised', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		local bars, activeOn, activeLine, raised, iconLeft, skinBar = {}, nil, nil, nil, true, nil
		for _, g in ipairs(G.Tree()) do
			for _, p in ipairs(g.pages) do
				O.Select(p.key)
				local b = bar()
				if b and #b.icons > 0 then
					bars[#bars + 1] = { page = p.key, icons = b.icons }
					if #b.icons > 1 and b.active and activeOn == nil then
						activeOn = b.active.psOn
						activeLine = b.active.Under:IsShown()
						-- No skin's selected bar under it (the default look's accent bar).
						local d = rawget(b.active, "psSkin")
						skinBar = (d and d.bar and d.bar:IsShown()) and true or false
						-- Raised: taller than a resting tab, whose bottom edge shows.
						for _, o in ipairs(O.frame.FolderTabs.buttons) do
							if o:IsShown() and not o.psOn then
								raised = b.active:GetHeight() > o:GetHeight() and o.Under:IsShown()
							end
						end
					end
					for _, x in ipairs(O.frame.FolderTabs.buttons) do
						if x:IsShown() then
							local _, rel = x.Label:GetPoint(1)
							if rel ~= x.Icon then iconLeft = false end
						end
					end
				end
			end
		end
		emit({ bars = bars, activeOn = activeOn, activeLine = activeLine, raised = raised, iconLeft = iconLeft, skinBar = skinBar,
			fallback = G.TAB_ICONS })`);
	assert.ok(out.bars.some((b) => b.icons.length > 1), 'some page has folder tabs');
	for (const bar of out.bars) {
		assert.equal(new Set(bar.icons).size, bar.icons.length, bar.page);
		for (const icon of bar.icons) assert.ok(GLYPHS.has(icon), `${bar.page}: ${icon} is one of the addon's glyphs`);
	}
	for (const icon of out.fallback) assert.ok(GLYPHS.has(icon), `fallback ${icon} is one of the addon's glyphs`);
	assert.equal(out.activeOn, true);
	assert.equal(out.activeLine, false);
	assert.equal(out.skinBar, false, 'no skin bar under the active tab');
	assert.equal(out.raised, true, 'the active tab stands taller than the resting ones');
	assert.equal(out.iconLeft, true, 'each label sits right of its icon');
});

test('the dot follows the changed state of the tab', () => {
	const [out] = run(`
		assert(Polestar.RegisterOptions({ page = "Kids", key = "kids", tab = "Tab", section = "Section", controls = {
			{ kind = "toggle", key = "ui.locked", label = "Parent" },
			{ kind = "toggle", key = "ui.notesOpen", label = "Partner" },
		} }))
		assert(Polestar.RegisterOptions({ page = "Kids", key = "kids", tab = "Other", section = "Section", controls = {
			{ kind = "toggle", key = "ui.wholeStep", label = "Elsewhere" },
		} }))
		Polestar.UI.ShowOptions()
		O.Select("kids", "Tab")
		local _, t = G.Current()
		local dots, shown = {}, {}
		local function look()
			O.Select("kids", "Tab")
			dots[#dots + 1] = G.TabDot(t) or "none"
			local b = O.frame.FolderTabs.buttons[1]
			shown[#shown + 1] = { b.Dot:IsShown(), b.psDot or "none" }
		end
		look()
		Polestar.Set("ui.notesOpen", true)
		look()
		Polestar.Set("ui.notesOpen", false)
		look()
		emit({ dots = dots, shown = shown })`);
	assert.deepEqual(out.dots.map((d) => (d === 'none' ? null : d)), [null, 'filled', null]);
	assert.deepEqual(out.shown, [[false, 'none'], [true, 'filled'], [false, 'none']]);
});

test('at 860 wide the tabs that do not fit show icons only, the label in the tooltip', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("alerts")
		local f = O.frame.FolderTabs
		local wideCompact = f.compact
		-- Wide: the last tab ends short of what stands at the band's right end.
		local last
		for _, b in ipairs(f.buttons) do if b:IsShown() then last = b end end
		local _, _, _, lx = last:GetPoint(1)
		local fits = lx + last:GetWidth() + f.psOpts.rightWidth <= O.frame.psMainW
		O.frame:SetWidth(860)
		O.Select("alerts")
		local b = f.buttons[1]
		local tip
		local real = Polestar.Widgets.Tooltip
		Polestar.Widgets.Tooltip = function(_, _, title) tip = title end
		b:GetScript("OnEnter")(b)
		b:GetScript("OnLeave")(b)
		Polestar.Widgets.Tooltip = real
		emit({ wide = wideCompact, fits = fits, rightW = f.psOpts.rightWidth, compact = f.compact, labelShown = b.Label:IsShown(),
			iconShown = b.Icon:IsShown(), tip = tip, psTip = b.psTip, label = b.Label:GetText() })`);
	assert.equal(out.wide, false, 'the default window has room for the labels');
	assert.equal(out.fits, true, 'the last tab ends short of the right end');
	assert.ok(out.rightW > 0, 'the filter stands at the right end');
	assert.equal(out.compact, true);
	assert.equal(out.labelShown, false);
	assert.equal(out.iconShown, true);
	assert.equal(out.psTip, out.label);
	assert.equal(out.tip, out.label, 'the tooltip names the tab while compact');
});

test('the filter at the right end takes its room: the tabs give way to icons for it', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.frame:SetWidth(1000)
		O.Select("alerts")
		local f = O.frame.FolderTabs
		local rightW = f.psOpts.rightWidth
		-- The labelled tabs' width, from a band wide enough for them.
		f:Set(f.psList, nil, { active = f.psOpts.active, width = 4000, rightWidth = 0, onSelect = f.psOpts.onSelect })
		local total = 0
		for _, b in ipairs(f.buttons) do if b:IsShown() then total = total + b:GetWidth() + 6 end end
		-- A window where the tabs fit the band, but not beside the filter.
		O.frame:SetWidth(1000 + (total + 32 + 8 + rightW / 2) - O.frame.psMainW)
		O.Select("alerts")
		local withFilter = f.compact
		local opts = f.psOpts
		local nowRight = opts.rightWidth
		local without = f:Set(f.psList, nil, { active = opts.active, width = opts.width, rightWidth = 0, onSelect = opts.onSelect }).compact
		emit({ rightW = nowRight, withFilter = withFilter, without = without, filterW = rightW })`);
	assert.ok(out.rightW > 0, 'the filter stands at the right end');
	assert.equal(out.without, false, 'the tabs fit the band alone');
	assert.equal(out.withFilter, true, 'beside the filter they give way to icons');
});

test('under a game look a folder tab takes no kit tab art: the box is the layout\'s', () => {
	const [out] = run(`
		Polestar.Set("ui.skin", "forever")
		Polestar.UI.ShowOptions()
		O.Select("alerts")
		local f = O.frame.FolderTabs
		local art, n = false, 0
		for _, b in ipairs(f.buttons) do
			if b:IsShown() then
				n = n + 1
				if rawget(b, "psSkin") or select("#", b:GetChildren()) > 0 then art = true end
			end
		end
		local b = f.buttons[1]
		emit({ kit = Polestar.Theme.Kit() ~= nil, art = art, n = n, edges = b.Left:IsShown() and b.Right:IsShown() and b.Top:IsShown() })`);
	assert.equal(out.kit, true, 'a game look is in use');
	assert.ok(out.n > 1);
	assert.equal(out.art, false, 'no kit tab host or art on a folder tab');
	assert.equal(out.edges, true, 'the layout\'s box is drawn');
});

test('the current page builds no folder tabs', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guidewindow")
		local classic = rawget(O.frame, "FolderTabs") == nil
		-- Built on the new page, then switched off: hidden with the rest of it.
		G.SetOn(true)
		O.Select("guidewindow")
		local built = rawget(O.frame, "FolderTabs") ~= nil and O.frame.FolderTabs:IsShown()
		G.SetOn(false)
		emit({ folder = not classic, built = built, after = O.frame.FolderTabs:IsShown() })`, 'PolestarDB = { settings = {} }');
	assert.equal(out.folder, false);
	assert.equal(out.built, true);
	assert.equal(out.after, false);
});
