'use strict';
// Community addons switched off and on, where suggestions come from, and the
// installed packs the core finds in the AddOns list
// (addon/Polestar/Core/Guides.lua, Search.lua, Lookup/Guide.lua).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };
const WITH_LOOKUP = { name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Lookup.xml'] };

// A Horde character at level 12 in the Barrens.
const WORLD = `
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.moveTo(1413, 52, 31)
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Orc", "Orc", "Horde", "WARRIOR", "Warrior", 12
`;

// Ours (`guides`, from Polestar_Guides) and Joe's pack, each with a Horde and
// an Alliance leveling guide for 10-20 and a guide collecting item 8000.
const PACKS = `
G = Polestar.Guides
local function meta(addon, id, title)
	return { addon = addon, id = id, format = 1, title = title, author = "A", version = "1", license = "MIT" }
end
local function guide(id, pack, extra)
	local g = { id = id, pack = pack, title = "T " .. id, minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } }
	for k, v in pairs(extra or {}) do g[k] = v end
	assert(Polestar.RegisterGuide(g))
end
assert(Polestar.RegisterPack(meta("Polestar_Guides", "guides", "Polestar Guides")))
guide("forever/horde", "guides", { faction = "Horde" })
guide("forever/alliance", "guides", { faction = "Alliance" })
guide("forever/mount", "guides", { category = "Collectibles", collects = { 8000 } })
assert(Polestar.RegisterPack(meta("JoeAddon", "joe", "Joe's Routes")))
guide("joe/a", "joe", { faction = "Horde", nextChoices = { "joe/b" } })
guide("joe/b", "joe", { faction = "Horde" })
guide("joe/mount", "joe", { category = "Collectibles", collects = { 8000 } })
function ids(list) local out = {} for i, h in ipairs(list) do out[i] = type(h) == "table" and h.id or h end return out end
`;

function run(script, { before = '', saved, addon = CORE, stubs = [] } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', ...stubs],
		before: WORLD + before,
		addons: [addon],
		saved: saved ? { Polestar: saved } : undefined,
		script: `${PACKS}\nstub.login()\n${script}`,
	}).emitted;
}

test('a hidden pack\'s guides leave Get, List, Suggest and OfferedBy, and come back when it is shown', () => {
	const [out] = run(`
		Polestar.Set("behavior.suggestFrom", "joe")
		local fired = {}
		Polestar.On("PACKS_CHANGED", function(id) fired[#fired + 1] = id end)
		local r = { before = { suggest = G.Suggest(), offered = #G.OfferedBy("joe/b") } }
		G.SetPackShown("joe", false)
		r.hidden = { get = G.Get("joe/a") ~= nil, list = ids(G.List()), suggest = G.Suggestions(), offered = #G.OfferedBy("joe/b"),
			shown = G.PackShown("joe"), off = PolestarDB.packs.joe.off, status = G.Pack("joe").status, fired = #fired, firedWith = fired[1] }
		G.SetPackShown("joe", false)
		r.again = #fired
		G.SetPackShown("joe", true)
		r.back = { get = G.Get("joe/a") ~= nil, list = ids(G.List()), suggest = G.Suggest(), shown = G.PackShown("joe"),
			status = G.Pack("joe").status, fired = fired, stored = PolestarDB.packs and PolestarDB.packs.joe and PolestarDB.packs.joe.off or false }
		emit(r)
	`);
	assert.deepEqual(out.before, { suggest: 'joe/a', offered: 1 });
	assert.deepEqual(out.hidden, {
		get: false, list: ['forever/horde', 'forever/alliance', 'forever/mount'], suggest: ['forever/horde'], offered: 0,
		shown: false, off: true, status: 'off', fired: 1, firedWith: 'joe',
	});
	assert.equal(out.again, 1, 'hiding a hidden pack changes nothing');
	assert.deepEqual(out.back, {
		get: true, list: ['forever/horde', 'forever/alliance', 'forever/mount', 'joe/a', 'joe/b', 'joe/mount'], suggest: 'joe/a',
		shown: true, status: 'on', fired: ['joe', 'joe'], stored: false,
	});
});

test('suggestions come from the chosen pack, with ours filling in where it has nothing', () => {
	const [out] = run(`
		local r = { default = G.SuggestSource(), ours = G.Suggest() }
		Polestar.Set("behavior.suggestFrom", "joe")
		r.source = G.SuggestSource()
		r.joe = G.Suggest()
		stub.world.faction, stub.world.race = "Alliance", "Human"
		r.allianceFromJoe = G.Suggest()
		stub.world.faction, stub.world.race = "Horde", "Orc"
		G.SetPackShown("joe", false)
		r.hiddenSource = G.SuggestSource()
		r.hidden = G.Suggest()
		G.SetPackShown("joe", true)
		Polestar.Set("behavior.suggestFrom", "nope")
		r.nope = G.SuggestSource()
		emit(r)
	`);
	assert.deepEqual(out, {
		default: 'guides', ours: 'forever/horde', source: 'joe', joe: 'joe/a', allianceFromJoe: 'forever/alliance',
		hiddenSource: 'guides', hidden: 'forever/horde', nope: 'guides',
	});
});

test('Lookup\'s curated guide comes from the suggestion source, then ours', () => {
	const [out] = run(`
		local r = { default = Polestar.Lookup.CuratedGuide("mount", 8000) }
		Polestar.Set("behavior.suggestFrom", "joe")
		r.joe = Polestar.Lookup.CuratedGuide("mount", 8000)
		G.SetPackShown("guides", false)
		Polestar.Set("behavior.suggestFrom", "guides")
		r.oursHidden = Polestar.Lookup.CuratedGuide("mount", 8000) or false
		emit(r)
	`, { addon: WITH_LOOKUP, stubs: ['stub_lookup_runtime.lua'] });
	assert.deepEqual(out, { default: 'forever/mount', joe: 'joe/mount', oursHidden: false });
});

test('installed packs: on, broken, turned off, not loaded, too new, never registered', () => {
	const [out] = run(`
		Polestar.RegisterPack({ addon = "EmptyAddon", id = "empty", format = 1, title = "Empty", author = "E", version = "1", license = "MIT" })
		G.ScanInstalled()
		G.ScanInstalled()
		local rows = {}
		for _, r in ipairs(G.Packs()) do
			local kinds = {}
			for i, p in ipairs(r.problems) do kinds[i] = p.kind end
			rows[#rows + 1] = { id = r.id, addon = r.addon, status = r.status, reason = r.reason or false, needs = r.needs or false,
				title = r.title or false, author = r.author or false, version = r.version or false, license = r.license or false,
				website = r.website or false, problems = kinds }
		end
		emit({ rows = rows, problems = G.ProblemCount() })
	`, {
		before: `
			ADDON_INTERFACE_VERSION = "Out of date"
			stub.addons = {
				{ name = "Polestar", loaded = true },
				{ name = "Polestar_Guides", loaded = true },
				{ name = "JoeAddon", loaded = true },
				{ name = "EmptyAddon", loaded = true },
				{ name = "Off", reason = "DISABLED", enabled = false },
				{ name = "Old", reason = "INTERFACE_VERSION" },
				{ name = "Future", reason = "INTERFACE_VERSION" },
				{ name = "Crash", loaded = true },
				{ name = "SomethingElse", loaded = true },
			}
			local function toc(id, title, extra)
				local m = { ["X-Polestar-Pack"] = id, ["X-Polestar-Format"] = "1", Title = title, Author = title .. " Author", Version = "2.0", ["X-License"] = "CC0-1.0", ["X-Website"] = "https://example.org/" .. id }
				for k, v in pairs(extra or {}) do m[k] = v end
				return m
			end
			stub.addonMeta.Polestar_Guides = toc("guides", "Polestar Guides")
			stub.addonMeta.JoeAddon = toc("joe", "Joe's Routes")
			stub.addonMeta.EmptyAddon = toc("empty", "Empty")
			stub.addonMeta.Off = toc("off", "Switched Off", { Title = "Polestar Community: Switched Off" })
			stub.addonMeta.Old = toc("old", "Old Pack", { Title = "Polestar Pack: Old Pack" })
			stub.addonMeta.Future = toc("future", "Future Pack", { ["X-Polestar-Format"] = "4", ["X-Polestar-Needs"] = "0.4.0" })
			stub.addonMeta.Crash = toc("crash", "Crashing Pack")`,
	});
	const by = Object.fromEntries(out.rows.map((r) => [r.addon, r]));
	assert.deepEqual(out.rows.map((r) => r.addon), ['Polestar_Guides', 'Crash', 'EmptyAddon', 'Future', 'JoeAddon', 'Old', 'Off'],
		'ours first, then by title; each addon once after two scans');
	assert.equal(by.Polestar_Guides.status, 'on');
	assert.equal(by.JoeAddon.status, 'on');
	assert.equal(by.EmptyAddon.status, 'broken');
	assert.deepEqual(by.EmptyAddon.problems, ['no-guides']);
	assert.equal(by.Off.status, 'disabled');
	assert.equal(by.Old.status, 'not-loaded');
	assert.equal(by.Old.reason, 'Out of date');
	assert.equal(by.Future.status, 'too-new');
	assert.equal(by.Future.needs, '0.4.0');
	assert.equal(by.Crash.status, 'broken');
	assert.deepEqual(by.Crash.problems, ['no-guides']);
	assert.deepEqual(
		{ id: by.Off.id, title: by.Off.title, author: by.Off.author, version: by.Off.version, license: by.Off.license, website: by.Off.website },
		{ id: 'off', title: 'Switched Off', author: 'Switched Off Author', version: '2.0', license: 'CC0-1.0', website: 'https://example.org/off' },
		'an unregistered pack reads its TOC, without the "Polestar Community: " the compiler puts before its title',
	);
	assert.equal(by.Old.title, 'Old Pack', 'the legacy "Polestar Pack: " title prefix is stripped too');
	assert.equal(by.JoeAddon.title, "Joe's Routes", 'a registered pack keeps what it registered');
	assert.equal(out.problems, 2);
});

test('a pack not loaded for a reason the client has no text for shows the reason as given', () => {
	const [out] = run(`
		G.ScanInstalled()
		local r
		for _, p in ipairs(G.Packs()) do if p.addon == "Lonely" then r = p end end
		emit({ addon = r.addon, status = r.status, reason = r.reason or false, global = ADDON_DEP_MISSING ~= nil })
	`, {
		before: `
			stub.addons = {
				{ name = "Polestar", loaded = true },
				{ name = "Polestar_Guides", loaded = true },
				{ name = "Lonely", reason = "DEP_MISSING" },
			}
			stub.addonMeta.Polestar_Guides = { ["X-Polestar-Pack"] = "guides", ["X-Polestar-Format"] = "1", Title = "Polestar Guides" }
			stub.addonMeta.Lonely = { ["X-Polestar-Pack"] = "lonely", ["X-Polestar-Format"] = "1", Title = "Lonely Pack" }`,
	});
	assert.deepEqual(out, { addon: 'Lonely', status: 'not-loaded', reason: 'DEP_MISSING', global: false });
});

test('a pack whose file errors after two guides keeps them and stays on', () => {
	const [out] = run(`
		local ok = pcall(function()
			Polestar.RegisterPack({ addon = "PartAddon", id = "part", format = 1, title = "Part", author = "P", version = "1", license = "MIT" })
			Polestar.RegisterGuide({ id = "part/a", pack = "part", title = "A", steps = { { goals = { { t = "level", level = 30 } } } } })
			Polestar.RegisterGuide({ id = "part/b", pack = "part", title = "B", steps = { { goals = { { t = "level", level = 30 } } } } })
			error("boom")
		end)
		G.ScanInstalled()
		local E = Polestar.Engine
		local a, b = E.OpenTab("part/a"), E.OpenTab("part/b")
		local tabs = {}
		for i, t in ipairs(E.GetTabs()) do tabs[i] = t.guideId end
		emit({ ok = ok, status = G.Pack("part").status, count = G.Pack("part").guideCount, problems = #G.Pack("part").problems,
			opened = { a ~= nil, b ~= nil }, tabs = tabs })
	`, { before: 'stub.addons = { { name = "PartAddon", loaded = true } }; stub.addonMeta.PartAddon = { ["X-Polestar-Pack"] = "part", ["X-Polestar-Format"] = "1" }' });
	assert.equal(out.ok, false);
	assert.equal(out.status, 'on');
	assert.equal(out.count, 2);
	assert.equal(out.problems, 0);
	assert.deepEqual(out.opened, [true, true]);
	assert.ok(out.tabs.includes('part/a') && out.tabs.includes('part/b'), out.tabs.join(','));
});

test('search finds a shown pack\'s guide by title, and not once the pack is hidden', () => {
	const [out] = run(`
		local function found()
			for _, r in ipairs(Polestar.Search.Query("T joe/a")) do
				if r.kind == "guide" and r.id == "joe/a" then return true end
			end
			return false
		end
		local r = { shown = found() }
		G.SetPackShown("joe", false)
		r.hidden = found()
		G.SetPackShown("joe", true)
		r.back = found()
		emit(r)
	`);
	assert.deepEqual(out, { shown: true, hidden: false, back: true });
});
