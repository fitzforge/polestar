'use strict';
// The settings window's new marks (addon/Polestar_Options/UI/Options.lua,
// the seen record seeded by addon/Polestar/UI/OptionsLoader.lua): a setting
// tagged with the release it came in carries a ring on its row, and its page
// one on its sidebar row until the page is opened. A fresh install has every setting there is from the start, so
// nothing is new to it; an account from an older version still sees the
// settings that came after it. Against the real addon's modules and the fakes
// of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml'];

// Opens the settings window and emits the New count over every page, the
// tagged settings there are, and the seen record as saved.
function newCounts(saved) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		saved: saved ? { Polestar: saved } : undefined,
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			Polestar.UI.ShowOptions()
			local keys, n, tagged = {}, 0, 0
			for _, c in ipairs(O.AllControls()) do
				if c.new then tagged = tagged + 1 end
				if not keys[c.page.key] then keys[c.page.key] = true; n = n + O.PageNew(c.page.key) end
			end
			local seen = {}
			for k, v in pairs(PolestarDB.optionsSeen or {}) do seen[#seen + 1] = tostring(k) .. "=" .. tostring(v) end
			emit({ new = n, tagged = tagged, seen = seen })`,
	}).emitted[0];
}

test('a fresh install sees no setting as new, also when it first opens the settings after a reload', () => {
	const fresh = newCounts();
	assert.ok(fresh.tagged > 0, 'some settings are tagged with the release they came in');
	assert.equal(fresh.new, 0, 'nothing is new to a player who has just installed Polestar');
	// The next session: the saved table is back, so the account no longer reads as new.
	const later = newCounts('PolestarDB = { settings = {}, optionsSeen = { ["*"] = true } }');
	assert.equal(later.new, 0, 'the window first opened in a later session still shows nothing new');
});

test('an account from an older version still sees the settings that came after it as new', () => {
	const upgrade = newCounts('PolestarDB = { settings = {} }');
	assert.ok(upgrade.new > 0, `the settings added since the version it had count as new (${upgrade.new})`);
	const seenOld = newCounts('PolestarDB = { settings = {}, optionsSeen = { arrow = "0.3.8" } }');
	assert.ok(seenOld.new > 0, 'a seen record from an older release keeps the newer settings new');
});

test('a new setting is a quiet ring on its row, its page one ring in the sidebar: no count, no pill', () => {
	const out = runAddon({
		stubs: ['stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			Polestar.UI.ShowOptions("guide")
			local function navRow(key)
				for _, b in ipairs(PolestarOptions.navButtons) do if b:IsShown() and b.psKey == key then return b end end
			end
			local b = navRow("guidewindow")
			local side = { count = b.Count:IsShown(), mark = b.Changed:IsShown() and tostring(b.Changed:GetTexture()):match("[^\\\\/]+$") or false }
			O.Select("guidewindow", Polestar.L["Window"])
			local rows = O.Controls("guidewindow", Polestar.L["Window"])
			local function ring(key) local r = rawget(rows[key], "NewRing") return r ~= nil and r:IsShown() end
			local pill = false
			for _, card in ipairs(O.view.cards) do if rawget(card, "New") and card.New:IsShown() then pill = true end end
			emit({ side = side, padding = ring("guideWindow.padding"), scale = ring("ui.scale"), pill = pill,
				opened = navRow("guidewindow").Changed:IsShown() and tostring(navRow("guidewindow").Changed:GetTexture()):match("[^\\\\/]+$") or false })`,
	}).emitted[0];
	assert.deepEqual(out.side, { count: false, mark: 'ring' }, 'the page\'s sidebar row: one ring, no count chip at all');
	assert.equal(out.padding, true, 'a setting new since the account\'s version: a ring on its row');
	assert.equal(out.scale, false, 'an older one: none');
	assert.equal(out.pill, false, 'no New pill on the sections');
	assert.equal(out.opened, false, 'opened, the page\'s ring goes');
});

test('the sidebar ring and the gold dot explain themselves; a new row\'s tooltip says which release it came in', () => {
	const out = runAddon({
		stubs: ['stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local W = Polestar.Widgets
			Polestar.UI.ShowOptions("guide")
			local function navRow(key)
				for _, b in ipairs(PolestarOptions.navButtons) do if b:IsShown() and b.psKey == key then return b end end
			end
			local function tipLines(key)
				for _, c in ipairs(O.AllControls()) do
					if c.key == key then return O.TipOf(c)({}) end
				end
			end
			local function texts(lines)
				local t = {}
				for _, l in ipairs(lines or {}) do t[#t + 1] = type(l) == "table" and l[1] or l end
				return t
			end
			local ringTip = navRow("guidewindow").psTip
			local padding, older = texts(tipLines("guideWindow.padding")), texts(tipLines("ui.scale"))
			O.Select("guidewindow", Polestar.L["Window"])
			Polestar.Set("guideWindow.padding", 3)
			O.RefreshNav()
			local dotTip = navRow("guidewindow").psTip
			local plain = false
			for _, b in ipairs(PolestarOptions.navButtons) do
				if b:IsShown() and b.psItem and not b.psItem.group and not b.psItem.new and not b.psItem.changed and b.psTip then plain = b.psKey end
			end
			emit({ ringTip = ringTip, padding = padding, older = older, dotTip = dotTip or false, plain = plain })`,
	}).emitted[0];
	assert.equal(out.ringTip, 'New settings on this page', 'the ring says what it is');
	assert.ok(out.padding.some((l) => /^New in \d/.test(l)), `a new row names its release: ${out.padding}`);
	assert.ok(!out.older.some((l) => /^New in /.test(l)), 'an older setting says nothing of the kind');
	assert.equal(out.dotTip, 'Settings on this page changed from their default', 'the gold dot says what it is');
	assert.equal(out.plain, false, 'only a marked page has a tooltip');
});
