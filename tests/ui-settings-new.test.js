'use strict';
// The settings window's New badges (addon/Polestar_Options/UI/Options.lua,
// the seen record seeded by addon/Polestar/UI/OptionsLoader.lua): a setting
// tagged with the release it came in counts on its page's row until the page
// is opened. A fresh install has every setting there is from the start, so
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
