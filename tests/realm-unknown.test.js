'use strict';
// Forever's client no longer gives addons the realm (1.60.1 hotfix, November 2026): GetRealmName and
// GetNormalizedRealmName read "". The keys filed by realm fall back to realm-less ones and take over the old
// entry once (docs/ARCHITECTURE.md, "Unknown realm"); and the instance tracker's copy check survives the
// obfuscated parts of creature GUIDs ("Creature and object GUIDs").

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const NO_REALM = `
function GetRealmName() return "" end
function GetNormalizedRealmName() return "" end
`;

// A level 18 Night Elf Mage resting in Darkshore (the Characters page's tests' world).
const WORLD = `
local w = stub.world
w.class, w.className, w.race, w.raceName = "MAGE", "Mage", "NightElf", "Night Elf"
w.level, w.xp, w.xpMax = 18, 1000, 4000
w.zone, w.subzone = "Darkshore", ""
w.money = 1240
GetXPExhaustion = function() return nil end
IsResting = function() return true end
`;

const ALTS = ['Core/Core.xml', 'Theme/Theme.xml', 'Alts/Alts.xml'];
const ALTS_UI = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml', 'Alts/Alts.xml'];

function run({ files = ALTS, ui = false, saved = '', script, realm = false, stubs = [] }) {
	const all = ['stub_world.lua', ...(ui ? ['stub_ui.lua'] : []), ...stubs];
	return runAddon({
		stubs: all,
		before: (realm ? '' : NO_REALM) + WORLD,
		addons: [{ name: 'Polestar', files }],
		saved: saved ? { Polestar: saved } : undefined,
		login: true,
		script,
	}).emitted;
}

test('with the realm unknown the character is filed under its name alone, never "Name-"', () => {
	const [out] = run({
		script: `
stub.advance(6)
local c = PolestarDB.alts.chars
local e = c["Testchar"]
emit({ key = Polestar.Alts.Key(), compat = Polestar.Compat.RealmName() or false, info = Polestar.Compat.GetPlayerInfo().realm or false,
	filed = e ~= nil, realm = e and e.realm or false, blank = c["Testchar-"] ~= nil, current = e ~= nil and Polestar.Alts.IsCurrent(e) })`,
	});
	assert.deepEqual(out, { key: 'Testchar', compat: false, info: false, filed: true, realm: false, blank: false, current: true });
});

test('the character\'s one "Name-Realm" entry moves to the name alone at login, with its saved realm and data', () => {
	const [out] = run({
		saved: `PolestarDB = { schema = 1, alts = { chars = {
			["Testchar-Test Realm"] = { key = "Testchar-Test Realm", name = "Testchar", realm = "Test Realm", faction = "Alliance", level = 17, seen = 5,
				profs = { [197] = 90 }, mats = { [2589] = 12 }, tabs = { { id = "g1", title = "Darkshore", step = 3, count = 40 } } },
			["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", faction = "Alliance", level = 30, seen = 4 },
		} } }`,
		script: `
local c = PolestarDB.alts.chars
local atLogin = c["Testchar"] ~= nil and c["Testchar-Test Realm"] == nil
local mats = atLogin and c["Testchar"].mats[2589] or false
stub.advance(6)
local e = c["Testchar"]
emit({ atLogin = atLogin, key = e.key, realm = e.realm, level = e.level, prof = e.profs[197], mats = mats, tab = e.tabs and e.tabs[1].id or false,
	old = c["Testchar-Test Realm"] ~= nil, alt = c["Alt-Test Realm"] ~= nil, current = Polestar.Alts.IsCurrent(e),
	unclaimed = #Polestar.Alts.Unclaimed() })`,
	});
	assert.deepEqual(out, {
		atLogin: true, key: 'Testchar', realm: 'Test Realm', level: 18, prof: 90, mats: 12, tab: 'g1',
		old: false, alt: true, current: true, unclaimed: 0,
	});
});

test('a "Name-" entry written while the client read "" is merged in, its newer values on top', () => {
	const [out] = run({
		saved: `PolestarDB = { schema = 1, alts = { chars = {
			["Testchar-Test Realm"] = { key = "Testchar-Test Realm", name = "Testchar", realm = "Test Realm", level = 17, seen = 5, profs = { [197] = 90 } },
			["Testchar-"] = { key = "Testchar-", name = "Testchar", realm = "", level = 18, seen = 9, zone = "Ashenvale" },
		} } }`,
		script: `
local c = PolestarDB.alts.chars
local e = c["Testchar"]
emit({ realm = e.realm, zone = e.zone, seen = e.seen, prof = e.profs[197], blank = c["Testchar-"] ~= nil, old = c["Testchar-Test Realm"] ~= nil })`,
	});
	assert.deepEqual(out, { realm: 'Test Realm', zone: 'Ashenvale', seen: 9, prof: 90, blank: false, old: false });
});

test('several "Name-Realm" entries: none is taken, all stay listed and the page says so under the list', () => {
	const [out] = run({
		files: ALTS_UI,
		ui: true,
		saved: `PolestarDB = { schema = 1, alts = { chars = {
			["Testchar-Realm A"] = { key = "Testchar-Realm A", name = "Testchar", realm = "Realm A", level = 10, seen = 5 },
			["Testchar-Realm B"] = { key = "Testchar-Realm B", name = "Testchar", realm = "Realm B", level = 20, seen = 6 },
		} } }`,
		script: `
stub.advance(6)
local c = PolestarDB.alts.chars
Polestar.Fire("SHOW_ALTS")
local s = Polestar.UI.AltsSection.Shown()
emit({ a = c["Testchar-Realm A"] ~= nil and c["Testchar-Realm A"].level, b = c["Testchar-Realm B"] ~= nil and c["Testchar-Realm B"].level,
	mine = c["Testchar"] ~= nil and c["Testchar"].realm or false, unclaimed = #Polestar.Alts.Unclaimed(), rows = s.rows,
	subtitle = s.subtitle, apart = s.apart or false })`,
	});
	assert.equal(out.a, 10);
	assert.equal(out.b, 20);
	assert.equal(out.mine, false, 'a new entry, no realm guessed');
	assert.equal(out.unclaimed, 2);
	assert.equal(out.rows, 3);
	assert.match(out.subtitle, /^3 characters on 2 realms/);
	assert.match(out.apart, /^2 characters named Testchar were saved on different realms/);
});

test('the Characters page names no realm when the client gives none', () => {
	const [alone, two] = run({
		files: ALTS_UI,
		ui: true,
		script: `
Polestar.Fire("SHOW_ALTS")
local s = Polestar.UI.AltsSection.Shown()
emit({ subtitle = s.subtitle, rows = s.rows, key = s.keys[1], apart = s.apart or false })
PolestarDB.alts.chars["Alt"] = { key = "Alt", name = "Alt", class = "WARRIOR", race = "Orc", level = 30, xp = 1, xpMax = 5000, seen = 5 }
Polestar.UI.AltsSection.Render()
emit({ subtitle = Polestar.UI.AltsSection.Shown().subtitle })`,
	});
	assert.equal(alone.rows, 1);
	assert.equal(alone.key, 'Testchar');
	assert.match(alone.subtitle, /^1 character(\n|$)/);
	assert.equal(alone.apart, false);
	assert.match(two.subtitle, /^2 characters \u00b7 each as of their last logout/);
	assert.doesNotMatch(two.subtitle, / on /);
});

test('with the realm known the page and the key are as before', () => {
	const [out] = run({
		files: ALTS_UI,
		ui: true,
		realm: true,
		script: `
Polestar.Fire("SHOW_ALTS")
local s = Polestar.UI.AltsSection.Shown()
emit({ key = Polestar.Alts.Key(), subtitle = s.subtitle })`,
	});
	assert.equal(out.key, 'Testchar-Test Realm');
	assert.match(out.subtitle, /^1 character on Test Realm/);
});

test('materials: an alt of the realm saved on the character\'s entry counts, another realm\'s does not; prices move to the faction', () => {
	const [out] = run({
		saved: `local now = GetServerTime()
		PolestarDB = { schema = 1, alts = { chars = {
			["Testchar-Test Realm"] = { key = "Testchar-Test Realm", name = "Testchar", realm = "Test Realm", faction = "Alliance", level = 17, seen = 5 },
			["Kaelia-Test Realm"] = { key = "Kaelia-Test Realm", name = "Kaelia", realm = "Test Realm", faction = "Alliance", level = 30, seen = 1, mats = { [2589] = 120 } },
			["Far-Elsewhere"] = { key = "Far-Elsewhere", name = "Far", realm = "Elsewhere", faction = "Alliance", level = 30, seen = 1, mats = { [2589] = 7 } },
			["Fresh-"] = { key = "Fresh-", name = "Fresh", realm = "", faction = "Alliance", level = 3, seen = 1, mats = { [2589] = 2 } },
		} }, materials = { prices = {
			["Test Realm-Alliance"] = { [2589] = { t = now - 60, rows = { { p = 10, q = 5 } } }, [2592] = { t = now - 60, rows = { { p = 40, q = 5 } } } },
			["-Alliance"] = { [2589] = { t = now - 10, rows = { { p = 12, q = 5 } } } },
			["Test Realm-Horde"] = { [2589] = { t = now - 60, rows = { { p = 99, q = 5 } } } },
		} } }`,
		script: `
stub.world.faction = "Alliance"
local M = Polestar.Materials
local _, parts = M.Have(2589)
local names = {}
for i, a in ipairs(parts.alts) do names[i] = a.name .. ":" .. a.count end
local p = PolestarDB.materials.prices
emit({ alts = names, linen = M.Price(2589, 1), wool = M.Price(2592, 1), moved = p["Test Realm-Alliance"] == nil and p["-Alliance"] == nil,
	horde = p["Test Realm-Horde"] ~= nil })`,
	});
	assert.deepEqual(out.alts, ['Kaelia:120', 'Fresh:2']);
	assert.equal(out.linen, 12, 'the newer of the two prices for one item');
	assert.equal(out.wool, 40);
	assert.equal(out.moved, true);
	assert.equal(out.horde, true, 'the other faction\'s house is left alone');
});

const MAPS = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.xml'];

function maps(saved, script) {
	return run({
		files: MAPS,
		stubs: ['stub_maps.lua'],
		saved,
		script: `local M, m, w = Polestar.Maps, stub.maps, stub.world
Polestar.Nav.RegisterTravelData(m.travel, true)
local function target(guid) w.units.target = guid; stub.fire("PLAYER_TARGET_CHANGED") end
${script}`,
	});
}

test('instance entries filed as "Name-Realm" take the name alone; another character\'s are left', () => {
	const [out] = maps(
		`local now = GetServerTime()
		PolestarDB = { schema = 1, instances = { entries = {
			{ t = now - 600, name = "The Deadmines", char = "Testchar-Test Realm" },
			{ t = now - 300, name = "The Stockade", char = "Testchar-" },
			{ t = now - 200, name = "Wailing Caverns", char = "Alt-Test Realm" },
		} } }`,
		`local chars = {}
for i, e in ipairs(PolestarDB.instances.entries) do chars[i] = e.char end
m.enter("The Stockade", 34)
local list = PolestarDB.instances.entries
emit({ chars = chars, new = list[#list].char })`,
	);
	assert.deepEqual(out, { chars: ['Testchar', 'Testchar', 'Alt-Test Realm'], new: 'Testchar' });
});

test('instance copy: two creatures of a visit must agree; a copy part that differs per creature never splits a run', () => {
	const [agree, perCreature] = maps('', `
m.enter("The Stockade", 34)
target("Creature-0-11-34-100-1706-0000AAAA")
target("Creature-0-12-34-100-1707-0000AAAB")   -- the realm part obfuscated per creature: no matter
m.jump(600)
m.leave()
m.jump(60)
m.enter("The Stockade", 34)
target("Creature-0-13-34-200-1706-0000BBBB")
target("Creature-0-14-34-200-1708-0000BBBC")   -- another copy, two creatures agree
local runs = Polestar.CharState().instanceRuns
emit({ runs = #runs, inHour = M.GetInstanceStatus().inHour, zones = { runs[1].zone, runs[2] and runs[2].zone or false } })
m.leave()
m.jump(60)
m.enter("The Stockade", 34)
target("Creature-0-15-34-300-1706-0000CCCC")
target("Creature-0-16-34-301-1709-0000CCCD")   -- two creatures of one visit disagree: the part names no copy
target("Creature-0-17-34-302-1709-0000CCCE")
runs = Polestar.CharState().instanceRuns
emit({ runs = #runs, inHour = M.GetInstanceStatus().inHour })`);
	assert.deepEqual(agree, { runs: 2, inHour: 2, zones: ['100', '200'] });
	assert.deepEqual(perCreature, { runs: 2, inHour: 2 });
});

test('instance copy: a value saved in an earlier session is not compared (a relog may change it)', () => {
	const [out] = maps(
		`local now = GetServerTime()
		PolestarCharDB = { instanceRuns = { { id = 34, name = "The Stockade", kind = "party", entered = now - 900, since = nil, left = now - 120,
			time = 780, xp = 0, level = 18, zone = "100" } } }
		PolestarDB = { schema = 1, instances = { entries = { { t = now - 900, name = "The Stockade", char = "Testchar" } } } }`,
		`m.enter("The Stockade", 34)
target("Creature-0-21-34-555-1706-0000AAAA")
target("Creature-0-22-34-555-1707-0000AAAB")
local runs = Polestar.CharState().instanceRuns
emit({ runs = #runs, inHour = M.GetInstanceStatus().inHour, zone = runs[1].zone })`,
	);
	assert.deepEqual(out, { runs: 1, inHour: 1, zone: '555' });
});

const TRANSIT = ['Core/Init.lua', 'Core/Compat.lua', 'Nav/Transit.lua'];

function transit(saved, script) {
	return runAddon({
		before: NO_REALM,
		addons: [{ name: 'Polestar', files: TRANSIT }],
		saved: saved ? { Polestar: saved } : undefined,
		// The travel data registers at load, before login (its login check drops sightings of unknown routes).
		script: `local T = Polestar.Transit
T.Register({ routes = { r = { kind = "boat", period = 100000, fit = { samples = 10, span = 15000, speed = 12 },
	stops = { { 0, 20000, 0, 0, 0 }, { 50000, 70000, 0, 3000, 0 } },
	frames = { { 0, 20000, 0, 0, 0, 0 }, { 50000, 70000, 0, 3000, 0, 0 }, { 100000, 100000, 0, 0, 0, 1 } } } },
	services = { ["boat-x"] = { kind = "boat", name = "A - B", ends = { "A", "B" }, board = 10, pre = 0, post = 0,
		wait = { a = 60, b = 60 }, ride = { a = 30, b = 30 }, routes = { { route = "r", a = { 1 }, b = { 2 } } } } } })
stub.login()
${script}`,
	}).emitted;
}

test('boat timings: the one realm\'s sightings move to "?"; with several realms none moves', () => {
	const sighting = (realm, seenAgo) => `["${realm}"] = { r = { epoch = (now - ${seenAgo}) * 1000, seen = now - ${seenAgo}, source = "you" } }`;
	// The next departure reads the held sighting: the first read of the store runs the move.
	const probe = `T.NextDeparture("boat", "boat-x")
local s = Polestar.DB().transit
local keys = {}
for k in pairs(s) do keys[#keys + 1] = k end
table.sort(keys)
emit({ keys = keys, q = s["?"] and s["?"].r and (GetServerTime() - s["?"].r.seen) or false })`;
	const [one] = transit(`local now = GetServerTime()
		PolestarDB = { schema = 1, transit = { ${sighting('Test Realm', 300)} } }`, probe);
	const [several] = transit(`local now = GetServerTime()
		PolestarDB = { schema = 1, transit = { ${sighting('Realm A', 300)}, ${sighting('Realm B', 200)} } }`, probe);
	assert.deepEqual(one, { keys: ['?'], q: 300 });
	assert.deepEqual(several, { keys: ['?', 'Realm A', 'Realm B'], q: false });
});

test('a transit sender named with a realm never counts while this realm is unknown; one without does', () => {
	const [out] = transit('', `
function Ambiguate(name) return name end
local f = T.fromThisRealm
emit({ f("Ana Smith"), f("Ana Smith-TestRealm"), f("Ana Smith-") })`);
	assert.deepEqual(out, [true, false, true]);
});

const RARES = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Lookup/Lookup.xml', 'UI/UI.xml', 'Rares/Rares.xml'];

function rares(saved, script) {
	return run({ files: RARES, stubs: ['stub_rares.lua'], saved, script: `local R = Polestar.Rares\n${script}` });
}

test('rares met: the one realm\'s history moves to "?" (a rare in both keeps the newer, both counts)', () => {
	const [out] = rares(
		`PolestarDB = { schema = 1, rares = { history = {
			["Test Realm"] = { ["rare:61"] = { kind = "rare", id = 61, name = "Thuros", first = 100, t = 500, n = 3, alerted = 500 },
				["rare:79"] = { kind = "rare", id = 79, name = "Narg", first = 50, t = 60, n = 1 } },
			["?"] = { ["rare:61"] = { kind = "rare", id = 61, name = "Thuros", first = 900, t = 1000, n = 1 } },
		} } }`,
		`local h = R.History()
local e = h["rare:61"]
emit({ n = e.n, first = e.first, t = e.t, alerted = e.alerted, narg = h["rare:79"] ~= nil, old = PolestarDB.rares.history["Test Realm"] ~= nil,
	unclaimed = R.UnclaimedRealms() })`,
	);
	assert.deepEqual(out, { n: 4, first: 100, t: 1000, alerted: 500, narg: true, old: false, unclaimed: 0 });
});

test('rares met on several realms stay apart, and the Characters page says so', () => {
	const [out] = run({
		files: [...RARES, 'Alts/Alts.xml'],
		ui: true,
		stubs: ['stub_rares.lua'],
		saved: `PolestarDB = { schema = 1, rares = { history = {
			["Realm A"] = { ["rare:61"] = { kind = "rare", id = 61, t = 500, n = 3 } },
			["Realm B"] = { ["rare:79"] = { kind = "rare", id = 79, t = 60, n = 1 } },
		} } }`,
		script: `local R = Polestar.Rares
local n = 0
for _ in pairs(R.History()) do n = n + 1 end
Polestar.Fire("SHOW_ALTS")
emit({ n = n, unclaimed = R.UnclaimedRealms(), a = PolestarDB.rares.history["Realm A"] ~= nil, apart = Polestar.UI.AltsSection.Shown().apart or false })`,
	});
	assert.equal(out.n, 0);
	assert.equal(out.unclaimed, 2);
	assert.equal(out.a, true);
	assert.match(out.apart, /^Rares met on 2 realms are kept apart/);
});
