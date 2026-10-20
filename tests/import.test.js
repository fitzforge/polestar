'use strict';
// Import strings in the addon (addon/Polestar/Core/Import.lua and the
// registry's `imported` pack in Core/Guides.lua): a guide compiled by the
// real compiler, written by the real writer (tools/lib/pack/importstring.js),
// read back under Lua 5.1 with the client's decoders faked in plain Lua
// (tests/lua/stub_encoding.lua). Round trip, refusals that leave
// SavedVariables untouched, update in place, delete, login, suggestions.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const zlib = require('node:zlib');
const { runAddon } = require('./helpers/lua');
const { compile, fixtureData } = require('./helpers/dsl');
const { importString, encodeImport, adler32, LIMITS } = require('../tools/lib/pack/importstring');
const { emitGuides, guideData, GUIDE_KEYS, STEP_KEYS, IMAGE_KEYS, WHEN_KEYS, GOAL_KEYS, ONLY_KEYS, LIST_KEYS } = require('../tools/lib/dsl/emit');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };
const ID = 'yendi/northshire';

const GUIDE = `guide ${ID}
title Northshire Valley
faction Alliance
levels 1-6
zone Elwynn Forest
version 1

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
  accept 7

step Kobold camp
  goto 47.6,35.1 "Kobold camp"
  kill 6 x10 quest 7.1

step Back to the abbey
  turnin 7
`;

let compiled;
function guide() {
	if (!compiled) {
		const c = compile({ 'northshire.guide': GUIDE }, fixtureData(), { pack: 'yendi', author: 'Yendi' });
		assert.deepEqual(c.errors, []);
		compiled = c.guides[0];
	}
	return compiled;
}

const MANIFEST = { id: 'yendi', license: 'CC-BY-4.0' };

function string() {
	const r = importString(guide(), { manifest: MANIFEST, data: fixtureData() });
	assert.equal(r.error, undefined);
	return r.text;
}

// The payload the writer puts in the string, for strings made by hand.
function payload() {
	const p = { format: 3, license: 'CC-BY-4.0', guide: guideData(guide()._localised || guide()) };
	return JSON.parse(JSON.stringify(p));
}

// Raw bytes in the string's envelope, checksum and all (what a careless or
// hostile tool could write).
function envelope(raw) {
	const bytes = Buffer.from(raw, 'utf8');
	return `!PS1!${adler32(bytes).toString(16).padStart(8, '0')}!${zlib.deflateSync(bytes).toString('base64')}`;
}

// JSON value -> Lua literal, for SavedVariables.
function lua(v) {
	if (Array.isArray(v)) return `{ ${v.map(lua).join(', ')} }`;
	if (v && typeof v === 'object') return `{ ${Object.entries(v).map(([k, x]) => `[${/^\d+$/.test(k) ? k : JSON.stringify(k)}] = ${lua(x)}`).join(', ')} }`;
	return JSON.stringify(v);
}

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
`;

// Paste and Import, as the page does.
const SAVE = `
function save(text)
	local info, why = I.Preview(text)
	assert(info, why)
	assert(I.Save(info.entry))
	return info
end
`;

function run(script, opts = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua', ...(opts.stubs || [])],
		addons: [CORE],
		before: WORLD + (opts.before || ''),
		saved: opts.saved,
		login: true,
		script: `I = Polestar.Import\nG = Polestar.Guides\n${SAVE}\n${script}`,
	}).emitted;
}

const str = (s) => JSON.stringify(s);

test('the caps, the checksum and the key lists are the writer\'s', () => {
	const [out] = run(`emit({ limits = I.LIMITS, sum = I.Adler32("Wikipedia"), keys = I.KEYS })`);
	assert.deepEqual(out.limits, LIMITS);
	assert.equal(out.sum, adler32(Buffer.from('Wikipedia')).toString(16).padStart(8, '0'));
	const sorted = (a) => [...a].sort();
	assert.deepEqual(out.keys.guide, sorted(GUIDE_KEYS.filter((k) => k !== 'pack')));
	assert.deepEqual(out.keys.step, sorted(STEP_KEYS));
	assert.deepEqual(out.keys.when, sorted(WHEN_KEYS));
	assert.deepEqual(out.keys.goal, sorted(GOAL_KEYS));
	assert.deepEqual(out.keys.only, sorted(ONLY_KEYS));
	assert.deepEqual(out.keys.image, sorted(IMAGE_KEYS));
	for (const k of ['reagents', 'candidates', 'fromNpcs', 'spots', 'items', 'reward']) assert.deepEqual(out.keys[k], sorted(LIST_KEYS[k]), k);
});

test('a step picture rides along in a string, but an imported guide has no addon folder holding the file, so it shows none', () => {
	const p = payload();
	p.guide.steps[0].image = { file: 'media\\cave', w: 512, h: 256 };
	const [out] = run(`
		save(${str(encodeImport(p))})
		local s = G.Get(${str(ID)}).steps
		emit({ image = s[1].image, second = s[2].image == nil })
	`);
	assert.deepEqual(out, { image: { file: 'media\\cave', w: 512, h: 256 }, second: true });
});

test('round trip: .guide -> string -> preview -> Import registers the guide a community addon registers', () => {
	const [mine, theirs] = [
		run(`
			local info, why = I.Preview(${str(string())})
			assert(info, why)
			emit({ preview = { title = info.title, author = info.author, steps = info.steps, state = info.state, license = info.license, version = info.version,
				minLevel = info.minLevel, maxLevel = info.maxLevel, faction = info.faction } })
			assert(I.Save(info.entry))
			local g = G.Get(${str(ID)})
			emit({ pack = g.pack, license = g.license, guide = g, record = G.Pack("imported").guides, listed = #G.Packs() })
		`),
		run(`
			assert(Polestar.RegisterPack({ addon = "PolestarPack_Yendi", id = "yendi", format = 3, title = "Yendi", author = "Yendi", version = "1", license = "CC-BY-4.0" }))
			stub.addonLoaded("PolestarPack_Yendi")
			assert(loadstring(${str(emitGuides([{ guide: guide()._localised || guide() }]))}))()
			emit({ guide = G.Get(${str(ID)}) })
		`),
	];
	const [preview, reg] = mine;
	assert.deepEqual(preview.preview, { title: 'Northshire Valley', author: 'Yendi', steps: 4, state: 'new', license: 'CC-BY-4.0', version: 1, minLevel: 1, maxLevel: 6, faction: 'Alliance' });
	assert.equal(reg.pack, 'imported');
	assert.equal(reg.license, 'CC-BY-4.0');
	assert.deepEqual(reg.record, [ID]);
	assert.equal(reg.listed, 0, 'the imported guides are not a row of the Community guides page');
	const strip = ({ pack, license, ...rest }) => rest;
	assert.deepEqual(strip(reg.guide), strip(theirs[0].guide));
});

test('a guide with `when` steps goes into a format 4 string and imports with its conditions', () => {
	const src = GUIDE.replace('step Back to the abbey\n', 'step Back to the abbey\n  when onquest 7\n  when level<6\n');
	const c = compile({ 'northshire.guide': src }, fixtureData(), { pack: 'yendi', author: 'Yendi' });
	assert.deepEqual(c.errors, []);
	const r = importString(c.guides[0], { manifest: MANIFEST, data: fixtureData() });
	assert.equal(r.error, undefined);
	const [out] = run(`
		local info, why = I.Preview(${str(r.text)})
		assert(info, why)
		assert(I.Save(info.entry))
		emit({ format = info.entry.format, when = G.Get(${str(ID)}).steps[4].when })
	`);
	assert.equal(out.format, 4);
	assert.deepEqual(out.when, [{ k: 'onquest', q: [7] }, { k: 'level', op: '<', n: 6 }]);
});

test('a damaged, truncated, oversized, foreign or code-carrying string is refused with a reason, and SavedVariables stay untouched', () => {
	const good = string();
	const body = good.slice(14);
	const flipped = good.slice(0, 40) + (good[40] === 'A' ? 'B' : 'A') + good.slice(41);
	const p = payload();
	p.guide.onLoad = 'print("hi")';
	const cases = {
		tampered: flipped,
		truncated: good.slice(0, good.length - 24),
		checksum: `!PS1!00000000!${body}`,
		oversized: `!PS1!00000000!${'A'.repeat(LIMITS.length)}`,
		notOurs: 'hello there',
		newer: `!PS2!${good.slice(5)}`,
		luaChunk: envelope('return { format = 3, license = "MIT", guide = { id = "yendi/x" } }'),
		unknownField: encodeImport(p),
		newerFormat: encodeImport({ ...payload(), format: 99 }),
		noGuide: encodeImport({ format: 3, license: 'MIT' }),
		nullValue: envelope('{"format":3,"license":"MIT","guide":null}'),
		deep: envelope(`{"format":3,"license":"MIT","guide":${'['.repeat(40)}${']'.repeat(40)}}`),
		badType: encodeImport({ ...payload(), guide: { ...payload().guide, steps: 'all of them' } }),
	};
	const [out] = run(`
		-- Nothing may run text from a string.
		loadstring = function() error("loadstring called") end
		load, RunScript, setfenv = loadstring, loadstring, loadstring
		local out = {}
		for name, text in pairs(${lua(cases)}) do
			local info, why = I.Preview(text)
			out[name] = info and "accepted" or why
		end
		emit({ reasons = out, imports = PolestarDB.imports == nil, registered = G.Get("yendi/northshire") == nil and G.Get("yendi/x") == nil })
	`);
	const r = out.reasons;
	for (const name of ['tampered', 'truncated', 'checksum']) assert.match(r[name], /damaged or incomplete/, name);
	assert.match(r.oversized, new RegExp(`too long: Polestar reads up to ${LIMITS.length} characters`));
	assert.match(r.notOurs, /not a Polestar import string/);
	assert.match(r.newer, /needs a newer Polestar/);
	assert.match(r.newerFormat, /needs a newer Polestar/);
	assert.match(r.luaChunk, /damaged or incomplete/);
	assert.match(r.unknownField, /field Polestar does not read \(guide\.onLoad\)/);
	assert.match(r.noGuide, /holds no guide/);
	assert.match(r.nullValue, /damaged or incomplete/);
	assert.match(r.deep, /damaged or incomplete/);
	assert.match(r.badType, /does not read \(guide\.steps\)/);
	assert.equal(out.imports, true, 'PolestarDB.imports never made');
	assert.equal(out.registered, true);
});

test('a whole leveling route goes in as one string: 1,200 steps, 600 KB of guide data', () => {
	const route = payload();
	const step = route.guide.steps[0];
	route.guide.steps = Array.from({ length: 1200 }, (_, i) => ({ ...step, note: `Step ${i + 1}: ${'n'.repeat(480)}` }));
	assert.ok(Buffer.byteLength(JSON.stringify(route)) > 600000);
	const [out] = run(`
		local info, why = I.Preview(${str(encodeImport(route))})
		assert(info, why)
		assert(I.Save(info.entry))
		emit({ steps = info.steps, registered = #G.Get(${str(ID)}).steps })
	`);
	assert.deepEqual(out, { steps: 1200, registered: 1200 });
});

test('the guide must fit the caps and the id rules, and lead only to Polestar\'s guides or imported ones', () => {
	const long = payload();
	while (long.guide.steps.length <= LIMITS.steps) long.guide.steps.push(long.guide.steps[0]);
	const ours = payload();
	ours.guide.id = 'forever/alliance/sneaky';
	const bare = payload();
	bare.guide.id = 'northshire';
	const leads = payload();
	leads.guide.next = 'bob/goldshire';
	const toOurs = payload();
	toOurs.guide.next = 'forever/alliance/02-westfall';
	toOurs.guide.nextChoices = ['forever/alliance/02-westfall', 'bob/goldshire'];
	const bob = payload();
	bob.guide.id = 'bob/goldshire';
	const invalid = payload();
	invalid.guide.steps[0].goals[0].t = 'teleport';
	const [out] = run(`
		local function why(text) local info, reason = I.Preview(text) return info and "accepted" or reason end
		local out = {
			long = why(${str(encodeImport(long))}), ours = why(${str(encodeImport(ours))}), bare = why(${str(encodeImport(bare))}),
			leads = why(${str(encodeImport(leads))}), toOurs = why(${str(encodeImport(toOurs))}), invalid = why(${str(encodeImport(invalid))}),
		}
		save(${str(encodeImport(bob))})
		out.leadsAfter = why(${str(encodeImport(leads))})
		out.toOursAfter = why(${str(encodeImport(toOurs))})
		emit(out)
	`);
	assert.match(out.long, new RegExp(`has ${LIMITS.steps + 1} steps; an import string holds ${LIMITS.steps} at most`));
	assert.match(out.ours, /must start with its author's own id/);
	assert.match(out.bare, /must start with its author's own id/);
	assert.match(out.leads, /leads on to bob\/goldshire.*import that guide first/);
	assert.match(out.toOurs, /leads on to bob\/goldshire/);
	assert.match(out.invalid, /^Guide yendi\/northshire was refused: step 1 goal 1: unknown verb teleport\.$/);
	assert.equal(out.leadsAfter, 'accepted');
	assert.equal(out.toOursAfter, 'accepted');
});

test('a guide id under an installed community addon\'s id stays the addon\'s', () => {
	const [out] = run(`
		assert(Polestar.RegisterPack({ addon = "PolestarPack_Yendi", id = "yendi", format = 3, title = "Yendi's Guides", author = "Yendi", version = "1", license = "MIT" }))
		local info, why = I.Preview(${str(string())})
		emit({ info = info ~= nil, why = why })
	`);
	assert.equal(out.info, false);
	assert.match(out.why, /Guides under yendi\/ come from the community addon Yendi's Guides, which is installed/);
});

test('a newer version updates the guide in place: the open tab keeps its progress where the steps are unchanged', () => {
	const v1 = string();
	const p2 = payload();
	p2.guide.version = 2;
	p2.guide.title = 'Northshire Valley, revised';
	const v2 = encodeImport(p2);
	const p0 = payload();
	p0.guide.version = 0;
	const [out] = run(`
		save(${str(v1)})
		local E = Polestar.Engine
		E.SetGuide(${str(ID)})
		assert(E.ToggleGoal(1, 1))
		E.Goto(2)
		local before = E.GetGuide()
		local same, older, newer = I.Preview(${str(v1)}), I.Preview(${str(encodeImport(p0))}), I.Preview(${str(v2)})
		assert(I.Save(newer.entry))
		local s = Polestar.CharState()
		emit({ states = { same.state, older.state, newer.state }, have = newer.have, title = E.GetGuide().title, replaced = E.GetGuide() ~= before,
			step = E.GetStepIndex(), tick = s.manual[${str(ID)}]["1:1"], version = PolestarDB.imports[${str(ID)}].guide.version, tabs = #E.GetTabs() })
	`);
	assert.deepEqual(out.states, ['same', 'older', 'update']);
	assert.equal(out.have, 1);
	assert.equal(out.title, 'Northshire Valley, revised');
	assert.equal(out.replaced, true);
	assert.equal(out.step, 2, 'still looking at the step the player looked at');
	assert.equal(out.tick, 'tick', 'the tick stays');
	assert.equal(out.version, 2);
	assert.equal(out.tabs, 1);
});

test('Delete takes the guide out of the store, the registry and the open tabs', () => {
	const [out] = run(`
		save(${str(string())})
		Polestar.Engine.SetGuide(${str(ID)})
		local deleted = I.Delete(${str(ID)})
		emit({ deleted = deleted, stored = PolestarDB.imports[${str(ID)}] == nil, got = G.Get(${str(ID)}) == nil, list = #I.List(),
			record = #G.Pack("imported").guides, open = Polestar.Engine.GetGuide() == nil, again = I.Delete(${str(ID)}) })
	`);
	assert.deepEqual(out, { deleted: true, stored: true, got: true, list: 0, record: 0, open: true, again: false });
});

test('at login the stored guides register through the same checks; one that fails stays stored and listed with why', () => {
	const good = payload();
	const bad = payload();
	bad.guide.id = 'yendi/broken';
	bad.guide.steps[0].goals[0].sneaky = true;
	const saved = `PolestarDB = { schema = 1, settings = {}, imports = { [${str(ID)}] = ${lua(good)}, ["yendi/broken"] = ${lua(bad)} } }`;
	const [out] = run(`
		emit({ got = G.Get(${str(ID)}) and G.Get(${str(ID)}).pack, broken = G.Get("yendi/broken") == nil, list = I.List(), stored = PolestarDB.imports["yendi/broken"] ~= nil })
	`, { saved: { Polestar: saved } });
	assert.equal(out.got, 'imported');
	assert.equal(out.broken, true);
	assert.equal(out.stored, true);
	assert.deepEqual(out.list.map((e) => [e.id, e.title, e.author, e.version, e.license, e.steps]), [
		['yendi/northshire', 'Northshire Valley', 'Yendi', 1, 'CC-BY-4.0', 4],
		['yendi/broken', 'Northshire Valley', 'Yendi', 1, 'CC-BY-4.0', 4],
	].sort((a, b) => (a[1] + a[0] < b[1] + b[0] ? -1 : 1)));
	const broken = out.list.find((e) => e.id === 'yendi/broken');
	assert.match(broken.problem, /field Polestar does not read \(guide\.steps\[1\]\.goals\[1\]\.sneaky\)/);
});

test('suggestions never pick an imported guide, and the imported pack is never a suggestion source', () => {
	const [out] = run(`
		save(${str(string())})
		Polestar.Set("behavior.suggestFrom", "imported")
		local has = false
		for _, id in ipairs(G.Suggestions()) do if id == ${str(ID)} then has = true end end
		emit({ has = has, sources = G.SuggestSources(), from = G.SuggestSource(), fits = G.GuideMatches(G.Get(${str(ID)}), Polestar.Compat.GetPlayerInfo()) })
	`);
	assert.equal(out.fits, true, 'the guide is one the character could follow');
	assert.equal(out.has, false);
	assert.deepEqual(out.sources, ['guides']);
	assert.equal(out.from, 'guides');
});

test('no community addon can take the imported pack\'s id', () => {
	const [out] = run(`
		local ok, err = Polestar.RegisterPack({ addon = "Sneaky", id = "imported", imported = true, format = 3, title = "x", author = "x", version = "1", license = "MIT" })
		emit({ ok = ok, err = err, holder = G.Pack("imported").imported })
	`);
	assert.equal(out.ok, false);
	assert.match(out.err, /reserved for Polestar/);
	assert.equal(out.holder, true);
});

test('a text over the cap is refused at once, naming it, before any of it is filled in', () => {
	const long = payload();
	long.guide.title = '{a:1}'.repeat(50000);
	const key = payload();
	key.guide.written = { ['x'.repeat(5000)]: 'y' };
	const ns = payload();
	ns.guide.steps[0].goals[0].qlvl = 'q'.repeat(5000);
	const [out] = run(`
		local function why(text)
			local t0 = os.clock()
			local info, reason = I.Preview(text)
			return { reason = info and "accepted" or reason, seconds = os.clock() - t0 }
		end
		emit({ long = why(${str(encodeImport(long))}), key = why(${str(encodeImport(key))}), ns = why(${str(encodeImport(ns))}), imports = PolestarDB.imports == nil })
	`);
	assert.match(out.long.reason, /holds a text longer than Polestar reads \(guide\.title\): 4096 characters at most/);
	assert.ok(out.long.seconds < 0.2, `refused in ${out.long.seconds} s`);
	assert.match(out.key.reason, /text longer than Polestar reads \(guide\.written\)/);
	assert.match(out.ns.reason, /text longer than Polestar reads \(guide\.steps\[1\]\.goals\[1\]\.qlvl\)/);
	assert.equal(out.imports, true);
});

test('a payload over the cap is refused with its own message', () => {
	const big = envelope(`{"format":3,"license":"MIT","guide":{"id":"yendi/x","title":"${' '.repeat(LIMITS.payload)}"}}`);
	assert.ok(big.length < LIMITS.length, 'the string itself is short');
	const [out] = run(`local info, why = I.Preview(${str(big)}) emit({ why = why })`);
	assert.equal(out.why, `This import string holds too much: Polestar reads up to ${LIMITS.payload / 1024} KB of guide data.`);
});

test('a string adds Era frames only for the maps its guide uses, and never over a frame someone registered', () => {
	// A goal on a map Polestar has no frame for (9998), and a frame for a map no goal uses (9999).
	const p = payload();
	const goal = p.guide.steps.flatMap((st) => st.goals).find((g) => g.map !== undefined);
	goal.map = 9998;
	const mine = { c: 0, left: 1, right: 2, top: 3, bottom: 4 };
	p.frames = { 9998: mine, 9999: mine };
	const text = encodeImport(p);
	const [free, taken] = [
		run(`
			local before = Polestar.MapFrames.era[9998]
			save(${str(text)})
			emit({ before = before == nil, got = Polestar.MapFrames.era[9998], stray = Polestar.MapFrames.era[9999] == nil })
		`),
		run(`
			assert(Polestar.RegisterPack({ addon = "PolestarPack_Joe", id = "joe", format = 3, title = "Joe", author = "Joe", version = "1", license = "MIT" }))
			Polestar.RegisterMapFrames({ era = { [9998] = { c = 0, left = 10, right = 20, top = 30, bottom = 40 } } }, "joe")
			save(${str(text)})
			emit({ left = Polestar.MapFrames.era[9998].left, stray = Polestar.MapFrames.era[9999] == nil })
		`),
	];
	assert.equal(free[0].before, true);
	assert.deepEqual(free[0].got, mine, 'a map no one registered takes the string\'s frame');
	assert.equal(free[0].stray, true, 'a map the guide never uses is left out');
	assert.equal(taken[0].left, 10, 'the community addon\'s frame stays');
	assert.equal(taken[0].stray, true);
});
