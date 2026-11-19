'use strict';
// The settings window's reorganization (docs/superpowers/specs/2026-11-17-settings-ia-review.md):
// each setting has one home row, and every other place it shows is a
// reference to that home (O.Ref). The saved keys stay as they were.
// Against the real addon's modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

// Every key the settings window holds, sorted, as it was before the reorganization.
const KEYS_FIXTURE = path.join(__dirname, 'fixtures', 'settings', 'registered-keys.json');

let cached;
function survey() {
	if (cached) return cached;
	cached = runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local K = O.Kit
			local rows, home, keys, seen = {}, {}, {}, {}
			for _, p in ipairs(K.pages) do
				for _, t in ipairs(p.tabs) do
					for _, s in ipairs(t.sections) do
						for _, c in ipairs(K.homeSettings(s)) do
							local key = c.key
							if key ~= nil then
								local at = { page = p.key, tab = t.name or "", section = s.name or "" }
								rows[key] = rows[key] or {}
								table.insert(rows[key], at)
								if not home[key] then home[key] = at end
								if not seen[key] then
									seen[key] = true
									keys[#keys + 1] = key
								end
							end
						end
					end
				end
			end
			table.sort(keys)
			local multiHome = {}
			for _, key in ipairs(keys) do
				if #rows[key] > 1 then
					local where = {}
					for _, at in ipairs(rows[key]) do where[#where + 1] = at.page .. " > " .. at.tab .. " > " .. at.section end
					multiHome[#multiHome + 1] = key .. ": " .. table.concat(where, " | ")
				end
			end
			emit({ multiHome = multiHome, home = home, keys = keys })`,
	}).emitted[0];
	return cached;
}

// Two homes on purpose (the review's "Intentional"): the walk colour and the
// route colour head both the Line and the Dots cards, and each card shows for
// one line style only.
const INTENTIONAL = ['nav.walkColor', 'nav.dotColor'];

test('every saved key has exactly one home row; every other appearance is a reference', () => {
	const multiHome = survey().multiHome.filter((line) => !INTENTIONAL.includes(line.split(':')[0]));
	assert.deepEqual(multiHome, []);
});

// page key, and the tab or section where the review names one.
const HOMES = {
	'qol.instantQuestText': ['qualityoflife', 'Game'],
	'qol.hideErrors': ['qualityoflife', 'Game'],
	'qol.hideQuestTracker': ['qualityoflife', 'Game'],
	'nav.alerts': ['alerts', 'Transport alert'],
	'nav.alertBanner': ['alerts', 'Transport alert'],
	'rares.alerts': ['discovery', 'Rares'],
	'rares.combatAlerts': ['discovery'],
	'nav.arrow': ['guide'],
	'nav.distanceUnit': ['guide'],
	'qol.itemButton': ['questing', 'Buttons'],
	'nav.castPrompt': ['questing'],
	'qol.targetPlate': ['questing'],
	'maps.minimapButton': ['guide', 'Show and hide'],
	'ui.launcher': ['guide', 'Show and hide'],
	'nav.worldPins': ['map'],
	'nav.minimapRoute': ['map'],
	'nav.routeLines': ['guide'],
	'nav.journeySteps': ['guide'],
	'maps.coords': ['map'],
	'nav.nearbyMenu': ['guide'],
	'dungeons.headsUp': ['discovery'],
};

test('the homes match the review', () => {
	const { home } = survey();
	for (const [key, [page, section]] of Object.entries(HOMES)) {
		assert.ok(home[key], `${key} has a home`);
		assert.equal(home[key].page, page, `${key}'s home page: ${JSON.stringify(home[key])}`);
		if (section) assert.ok([home[key].tab, home[key].section].includes(section), `${key}'s home tab or section: ${JSON.stringify(home[key])}`);
	}
});

// The places that keep a reference (page > tab > section: key), the places a
// copy left without one, and words players searched the copies by.
const REFS = [
	'qualityoflife > Quests > Faster questing: behavior.autoAccept',
	'qualityoflife > Quests > Rewards, buttons and tracker: qol.itemButton',
	'questing > Quests > Faster questing: qol.instantQuestText',
	'questing > Quests > Quest log and tooltips: qol.hideQuestTracker',
	'guide > Arrow & routes > Along the route: nav.alerts',
	'alerts > Rare alert > Rare alert: rares.alerts',
	'alerts > Rare alert > Rare alert: rares.soundKit',
	'arrow > Look > Arrow: nav.arrow',
	'arrow > Text > Text: nav.arrowEta',
	'buttons > Action buttons > Buttons: qol.itemButton',
	'buttons > Action buttons > Buttons: nav.castPrompt',
	'buttons > Action buttons > Text: qol.targetPlate',
	'buttons > Launcher & minimap > Floating & minimap: maps.minimapButton',
	'mappins > Pins > Target pin: nav.worldPins',
	'routelines > Route > Route lines: nav.routeLines',
	'routelines > Route > Route lines: nav.lineStyle',
	'trackers > Travel > Flight timer: maps.flightTimer',
	'trackers > Travel > Journey: nav.journeySteps',
	'trackers > Party panel > Party panel: party.panel',
	'qualityoflife > Trackers & map > Minimap and coordinates: maps.coords',
	'qualityoflife > Travel > Hearth and travel: nav.nearbyMenu',
	'guide > Automation > Guides: behavior.trainReminder',
	'alerts > Heads-up card > Card: dungeons.headsUp',
];
const DROPPED = [
	'qualityoflife > Quests > Faster questing: qol.instantQuestText',
	'qualityoflife > Quests > Faster questing: qol.hideErrors',
	'qualityoflife > Quests > Rewards, buttons and tracker: qol.hideQuestTracker',
	'qualityoflife > Travel > Hearth and travel: nav.alerts',
	'map > Guide & quests > Guide: maps.minimapButton',
	'qualityoflife > Trackers & map > Minimap and coordinates: maps.minimapButton',
];
const SEARCHED = {
	'who it targets': 'qol.targetPlate',
	'flash taskbar': 'nav.alertFlash',
	'hide with guide': 'nav.hideArrowWithGuide',
	'alert in combat': 'rares.combatAlerts',
	'transport banner countdown': 'nav.alertBanner',
};

let placesCached;
function places() {
	if (placesCached) return placesCached;
	placesCached = runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local UI, O, K = Polestar.UI, Polestar.UI.Options, Polestar.UI.Options.Kit
			UI.ShowOptions()
			local refs, any = {}, {}
			local function note(c, where)
				if not c.key then return end
				any[where .. ": " .. c.key] = true
				if rawget(c, "ref") then refs[where .. ": " .. c.key] = O.HomeOf(c) ~= nil end
			end
			for _, p in ipairs(K.pages) do
				for _, t in ipairs(p.tabs) do
					for _, s in ipairs(t.sections) do
						local where = p.key .. " > " .. (t.name or "") .. " > " .. (s.name or "")
						if s.toggle then note(s.toggle, where) end
						for _, c in ipairs(s.controls) do
							note(c, where)
							for _, e in ipairs(rawget(c, "extras") or {}) do note(e, where) end
						end
					end
				end
			end
			local found = {}
			for q, key in pairs(${luaTable(SEARCHED)}) do
				found[q] = false
				for _, g in ipairs(O.Search(q)) do
					for _, c in ipairs(g.controls) do if c.key == key then found[q] = true end end
				end
			end
			emit({ refs = refs, any = any, found = found })`,
	}).emitted[0];
	return placesCached;
}

function luaTable(obj) {
	return `{ ${Object.entries(obj).map(([k, v]) => `[${JSON.stringify(k)}] = ${JSON.stringify(v)}`).join(', ')} }`;
}

test('the other places show a reference that finds its home; the review\'s drops are gone', () => {
	const { refs, any } = places();
	for (const r of REFS) assert.equal(refs[r], true, `a reference with a home at ${r}`);
	for (const d of DROPPED) assert.ok(!any[d], `no copy left at ${d}`);
});

test('search still finds a setting by the words of the copy that became a reference', () => {
	const { found } = places();
	for (const q of Object.keys(SEARCHED)) assert.equal(found[q], true, `"${q}" finds ${SEARCHED[q]}`);
});

test('the reorganization changes no saved key', () => {
	const keysBefore = JSON.parse(fs.readFileSync(KEYS_FIXTURE, 'utf8'));
	assert.deepEqual(survey().keys, keysBefore);
});

// The new page's dependency line walks a reference's home up its parents to
// the first that is off. Rare alert's Sound (rares.soundKit) opens under Alert
// for rares, which waits on the module's switch (rares.enabled).
function soundKitLine(settings) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {}, optionsLayout = "grouped" }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local K, G = O.Kit, O.Grouped
			for k, v in pairs(${luaTable(settings)}) do Polestar.Set(k, v) end
			local ref
			for _, s in ipairs(K.pageByKey("alerts").tabs) do
				for _, sec in ipairs(s.sections) do
					for _, c in ipairs(sec.controls) do
						if rawget(c, "ref") and c.key == "rares.soundKit" and not rawget(c, "extras") then ref = c end
					end
				end
			end
			-- The plain reference (Essentials' Sound, without Play a sound as an
			-- extra) on its own: a section without Alert for rares.
			local d = G._dependency({ name = "Test", controls = { ref } })
			emit({ toggle = d and d.toggle.key or false })`,
	}).emitted[0].toggle;
}

test('a dependency line: the nearest switch that is off wins, the module switch last', () => {
	assert.equal(soundKitLine({ 'rares.enabled': false, 'rares.alerts': true, 'rares.sound': false }), 'rares.enabled');
	assert.equal(soundKitLine({ 'rares.enabled': false, 'rares.alerts': false, 'rares.sound': true }), 'rares.alerts');
	assert.equal(soundKitLine({ 'rares.enabled': true, 'rares.alerts': false, 'rares.sound': false }), 'rares.alerts');
	assert.equal(soundKitLine({ 'rares.enabled': true, 'rares.alerts': true, 'rares.sound': false }), false);
});
