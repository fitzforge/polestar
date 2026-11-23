'use strict';
// The new settings page's Preview panel (addon/Polestar_Options/UI/Grouped.lua):
// it stands beside the rows only on a page that registers a live preview, and
// holds the preview alone (no description, no counts). A Preview button at
// the folder-tab bar's right end, after the filter, hides and shows it for
// the account (PolestarDB.optionsPreviewHidden), lit while it is open; the old
// PolestarDB.optionsSideHidden moves into it once. Against the real addon's
// modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

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
			local function panelShown()
				local f = G._side()
				return (f and f:IsShown()) and true or false
			end
			local function buttonShown()
				local b = G.PreviewButton()
				return (b and b:IsShown()) and true or false
			end
			${script}`,
	}).emitted;
}

test('the Preview panel and button appear only on pages that register a preview', () => {
	const [out] = run(`
		Polestar.Set("ui.optionsSize", { 1500, 900 })
		Polestar.UI.ShowOptions()
		local pages, has = {}, {}
		for _, key in ipairs({ "guidewindow", "questing", "profiles" }) do
			O.Select(key)
			pages[key] = buttonShown()
			has[key] = G.HasPreview(G.Current())
		end
		O.Select("guidewindow")
		local guidewindowBodyW = O.frame.BodyWidth
		local panel = panelShown()
		-- The panel holds the preview alone: no line of text of its own.
		local sideText = false
		local f = G._side()
		for _, r in ipairs({ f:GetRegions() }) do
			if r.GetText and r:IsShown() and (r:GetText() or "") ~= "" then sideText = true end
		end
		O.Select("questing")
		emit({ pages = pages, has = has, panelOnGuidewindow = panel, panelOnQuesting = panelShown(),
			guidewindowBodyW = guidewindowBodyW, questingBodyW = O.frame.BodyWidth, sideText = sideText })`);
	assert.deepEqual(out.pages, { guidewindow: true, questing: false, profiles: false });
	assert.deepEqual(out.has, { guidewindow: true, questing: false, profiles: false });
	assert.equal(out.panelOnGuidewindow, true);
	assert.equal(out.panelOnQuesting, false);
	assert.ok(out.questingBodyW > out.guidewindowBodyW, 'rows take the width');
	assert.equal(out.sideText, false, 'no description, no counts in the panel');
});

test('the Preview button hides and shows the panel for the account and is lit while open', () => {
	const [out] = run(`
		Polestar.Set("ui.optionsSize", { 1500, 900 })
		Polestar.UI.ShowOptions()
		O.Select("guidewindow")
		local states = {}
		local b = G.PreviewButton()
		states[1] = { on = b.psOn, shown = panelShown() }
		stub.RunScript(b, "OnClick")
		b = G.PreviewButton()
		states[2] = { on = b.psOn, shown = panelShown() }
		local bodyHidden = O.frame.BodyWidth
		-- The Changed view: no Preview button there, and no error.
		G.Filter("changed")
		local inChanged = buttonShown()
		G.Back()
		emit({ states = states, saved = PolestarDB.optionsPreviewHidden, inChanged = inChanged,
			back = buttonShown(), bodyHidden = bodyHidden })`);
	assert.deepEqual(out.states, [{ on: true, shown: true }, { on: false, shown: false }]);
	assert.equal(out.saved, true);
	assert.equal(out.inChanged, false, 'hidden in the Changed view');
	assert.equal(out.back, true);
});

test('the Preview button counts in the band\'s right end, after the filter', () => {
	const [out] = run(`
		Polestar.Set("ui.optionsSize", { 1500, 900 })
		Polestar.UI.ShowOptions()
		O.Select("questing")
		local without = O.frame.FolderTabs.psOpts.rightWidth
		O.Select("guidewindow")
		local with = O.frame.FolderTabs.psOpts.rightWidth
		local b = G.PreviewButton()
		local filters = G._filters()
		local _, _, _, bx = b:GetPoint(1)
		local _, _, _, fx = filters[#filters]:GetPoint(1)
		emit({ without = without, with = with, w = b:GetWidth(), left = bx < fx, icon = b.Dot:IsShown() and b.Dot:GetTexture() or false })`);
	assert.ok(out.with >= out.without + out.w, 'rightWidth counts the button');
	assert.equal(out.left, true, 'it stands left of the filter');
	assert.match(String(out.icon), /eye/, 'the eye glyph before its label');
});

test('optionsSideHidden migrates to optionsPreviewHidden once', () => {
	const [first] = run(`
		Polestar.Set("ui.optionsSize", { 1500, 900 })
		Polestar.UI.ShowOptions()
		O.Select("guidewindow")
		local shownAtFirst = panelShown()
		emit({ preview = PolestarDB.optionsPreviewHidden, side = PolestarDB.optionsSideHidden == nil and null or PolestarDB.optionsSideHidden,
			shownAtFirst = shownAtFirst })`, 'PolestarDB = { settings = {}, optionsLayout = "grouped", optionsSideHidden = true }');
	assert.deepEqual({ preview: first.preview, side: first.side ?? null }, { preview: true, side: null });
	assert.equal(first.shownAtFirst, false, 'the migrated choice holds from the first render');
	// The player has chosen since (shown): a leftover optionsSideHidden does not
	// overwrite that choice, and is dropped.
	const [second] = run(`
		Polestar.Set("ui.optionsSize", { 1500, 900 })
		Polestar.UI.ShowOptions()
		O.Select("guidewindow")
		emit({ preview = PolestarDB.optionsPreviewHidden, side = PolestarDB.optionsSideHidden == nil, shown = panelShown() })`,
		'PolestarDB = { settings = {}, optionsLayout = "grouped", optionsSideHidden = true, optionsPreviewHidden = false }');
	assert.deepEqual(second, { preview: false, side: true, shown: true }, 'the choice stays, optionsSideHidden goes');
});

test('a preview that lays nothing out leaves no empty panel: the rows take the width', () => {
	const [out] = run(`
		Polestar.Set("ui.optionsSize", { 1500, 900 })
		-- Guide window's previews lay out nothing (a frame 0 tall, no line).
		local function nothing(host)
			host.psHotspots = 0
			local f = CreateFrame("Frame", nil, host)
			f.Layout = function() return 0 end
			f.caption = ""
			return f
		end
		for _, p in ipairs(O.Kit.pages) do
			if p.key == "guidewindow" then
				for _, t in ipairs(p.tabs) do if t.preview then t.preview = nothing end end
			end
		end
		Polestar.UI.ShowOptions()
		O.Select("questing")
		local full = O.frame.BodyWidth
		O.Select("guidewindow")
		emit({ panel = panelShown(), bodyW = O.frame.BodyWidth, full = full })`);
	assert.equal(out.panel, false, 'no empty panel');
	assert.equal(out.bodyW, out.full, 'the rows take the full width');
});
