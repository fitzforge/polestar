'use strict';
// Community guides, end to end. The packs are built by the CLI into a temp AddOns
// folder:
//
//   acceptance-good                         made by `polestar new --yes` in
//                                           before(), then a second guide
//                                           (tests/fixtures/packs/acceptance-farms.guide)
//   tests/fixtures/packs/acceptance-bad/    imposter/: a pack source reusing the
//                                           id acceptance-good (it builds; the
//                                           game refuses it); two hand-written
//                                           addons the CLI would never write: a
//                                           guide under forever/, and format 2
//
// Then the real Polestar (every module), our committed pack and those addons
// load through their TOCs on the Lua harness, the AddOns list (stub.addons)
// and TOC fields (stub.addonMeta) as the client reports them. Needs
// data/forever (the build) and Lua 5.1; skips without them.

const { test, before } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { runAddon, ROOT, ADDONS } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');
const { needs } = require('./helpers/data');
const cli = require('./helpers/cli');

const FIXTURES = path.join(__dirname, 'fixtures', 'packs');

function hasLua() {
	return ['lua5.1', 'luajit', 'lua'].some((b) => {
		const r = spawnSync(b, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' });
		return r.status === 0 && /5\.1/.test(r.stdout);
	});
}

const skip = needs('races.json') || (!process.env.LUA && !hasLua() && 'no Lua 5.1');

const GOOD = 'PolestarPack_AcceptanceGood';
const IMPOSTER = 'PolestarPack_AcceptanceImposter';
const STRAY = 'PolestarPack_AcceptanceStray';
const FUTURE = 'PolestarPack_AcceptanceFuture';
const WESTFALL = 'forever/alliance/02-westfall';

function polestar(args, cwd, env = {}) {
	const r = cli.polestar(args, { cwd, env });
	assert.equal(r.status, 0, `polestar ${args.join(' ')}:\n${r.stdout}${r.stderr}`);
	return r;
}

// The TOC's ## fields.
function tocMeta(dir) {
	const toc = fs.readdirSync(dir).find((f) => f.endsWith('.toc'));
	const meta = {};
	for (const line of fs.readFileSync(path.join(dir, toc), 'utf8').split(/\r?\n/)) {
		const m = /^##\s*([^:]+):\s*(.*)$/.exec(line);
		if (m) meta[m[1].trim()] = m[2].trim();
	}
	return meta;
}

const luaStr = (s) => JSON.stringify(s);

let addons; // [{ name, dir }] in the order the client loads them
let good; // the built good pack's folder
let goodSrc; // its source, as `new` wrote it
let zip;
let tmp;

before(() => {
	if (skip) return;
	tmp = tmpdir('polestar-acceptance-');
	const dest = path.join(tmp, 'AddOns');
	fs.mkdirSync(dest);
	// The pack `new` makes (no origin: no workflow), plus a second guide; it
	// lints clean, playtests, packs and installs with --dest.
	goodSrc = path.join(tmp, 'acceptance-good');
	polestar(['new', goodSrc, '--yes', '--id', 'acceptance-good', '--title', 'Acceptance Good', '--author', 'Ann Example', '--license', 'CC-BY-4.0'], tmp, { POLESTAR_ORIGIN_URL: '' });
	fs.copyFileSync(path.join(FIXTURES, 'acceptance-farms.guide'), path.join(goodSrc, 'guides', 'farms.guide'));
	const lint = polestar(['lint'], goodSrc);
	assert.match(lint.stdout, /lint ok: 2 files, 2 guides: 0 errors, 0 warnings/);
	const play = polestar(['playtest'], goodSrc);
	assert.match(play.stdout, /ok {2}acceptance-good\/example/);
	polestar(['pack'], goodSrc);
	zip = path.join(goodSrc, 'dist', `${GOOD}-0.1.0.zip`);
	polestar(['install', '--dest', dest], goodSrc);
	const imposterSrc = path.join(tmp, 'imposter');
	fs.cpSync(path.join(FIXTURES, 'acceptance-bad', 'imposter'), imposterSrc, { recursive: true });
	polestar(['install', imposterSrc, '--dest', dest], ROOT);
	for (const name of [STRAY, FUTURE]) fs.cpSync(path.join(FIXTURES, 'acceptance-bad', name), path.join(dest, name), { recursive: true });
	good = path.join(dest, GOOD);
	addons = [
		{ name: 'Polestar', dir: path.join(ADDONS, 'Polestar') },
		{ name: 'Polestar_Guides', dir: path.join(ADDONS, 'Polestar_Guides') },
		...fs.readdirSync(dest).sort().map((name) => ({ name, dir: path.join(dest, name) })),
	];
});

// A level-5 Human in Goldshire, every addon loaded (the too-new one too: the
// client loads it, Polestar refuses it) plus `extra` ([{ name, dir }]), logged in.
function run(script, { saved, world = '', extra = [] } = {}) {
	const all = [...addons, ...extra];
	const list = all.map((a) => `{ name = ${luaStr(a.name)}, loaded = true }`).join(', ');
	const meta = all.map((a) => {
		const fields = Object.entries(tocMeta(a.dir)).map(([k, v]) => `[${luaStr(k)}] = ${luaStr(v)}`).join(', ');
		return `stub.addonMeta[${luaStr(a.name)}] = { ${fields} }`;
	});
	return runAddon({
		stubs: ['stub_world.lua'],
		before: `stub.addons = { ${list} }
${meta.join('\n')}
local w = stub.world
-- The maps with the Era frames of our MapFrames.lua, so goto coordinates match.
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1535.417, right = -1935.417, top = -7939.583, bottom = -10254.166 })
w.addMap(1436, { name = "Westfall", c = 0, left = 3016.667, right = -483.333, top = -9400, bottom = -11733.333 })
w.moveTo(1429, 42.9, 65.6)
w.level = 5
${world}`,
		addons: all.map(({ name, dir }) => ({ name, dir })),
		saved: saved ? { Polestar: saved } : undefined,
		login: true,
		script: `stub.advance(0.5)
G, E, UI = Polestar.Guides, Polestar.Engine, Polestar.UI
function flush() stub.advance(0.25) end
function rowOf(addon)
	for _, r in ipairs(UI.Packs.view.rows) do if r:IsShown() and r.psRecord.addon == addon then return r end end
end
function shownText(fs) return fs:IsShown() and fs:GetText() or false end
function titles(entries)
	local out = {}
	for _, e in ipairs(entries) do out[#out + 1] = e.kind == "guide" and e.guide.id or ("[" .. e.text .. "]") end
	return out
end
function nav()
	local out = {}
	for _, b in ipairs(PolestarPicker.navButtons) do
		if b:IsShown() then out[#out + 1] = (b.psHeading and "# " or "") .. b.Label:GetText() end
	end
	return out
end
function tabs()
	local out = {}
	for i, t in ipairs((E.GetTabs())) do out[i] = t.guideId end
	return out
end
${script}`,
	}).emitted;
}

test('the pack made by `new` lints, playtests, packs and installs with --dest', { skip }, () => {
	assert.ok(fs.existsSync(zip), zip);
	assert.deepEqual(fs.readdirSync(good).sort(), ['Guides.lua', 'LICENSE-DATA.txt', 'LICENSE.txt', `${GOOD}.toc`, 'MapFrames.lua', 'Pack.lua'].sort());
	assert.equal(fs.readFileSync(path.join(good, 'LICENSE.txt'), 'utf8'), fs.readFileSync(path.join(goodSrc, 'LICENSE'), 'utf8'));
	assert.equal(tocMeta(good)['X-Polestar-Pack'], 'acceptance-good');
});

test('beside ours: a row with its credits, its own picker entry, credits in the details, and a hand-over to our guide', { skip }, () => {
	const [out] = run(`
		UI.ShowOptions("guidepacks")
		local row = rowOf(${luaStr(GOOD)})
		local page = { title = row.Title:GetText(), credits = row.Credits:GetText(), count = shownText(row.Count), on = row.Switch.checked,
			status = shownText(row.Status), problems = row.Problems:IsShown() }
		UI.ShowPicker()
		local P = UI.Picker
		P.SetCategory("pack:acceptance-good")
		local picker = { nav = nav(), title = PolestarPicker.Title:GetText(), entries = titles(P.Entries("All", "", "pack:acceptance-good")),
			leveling = titles(P.Entries("All", "", "Leveling")) }
		P.Select("acceptance-good/example")
		local credits = shownText(P.details.Credits)
		P.Select(${luaStr(WESTFALL)})
		local ours = shownText(P.details.Credits)
		emit({ page = page, picker = picker, credits = credits, ours = ours, next = G.Get("acceptance-good/example").next })`);
	assert.deepEqual(out.page, { title: 'Acceptance Good', credits: 'Ann Example  ·  0.1.0  ·  CC-BY-4.0', count: '2 guides', on: true, status: false, problems: false });
	const heading = out.picker.nav.indexOf('# Community guides');
	assert.ok(heading >= 0, out.picker.nav.join(', '));
	assert.ok(out.picker.nav.slice(heading).includes('Acceptance Good  ·  Ann Example'), out.picker.nav.join(', '));
	assert.equal(out.picker.title, 'Acceptance Good');
	assert.deepEqual(out.picker.entries.filter((e) => !e.startsWith('[')), ['acceptance-good/example', 'acceptance-good/farms']);
	assert.ok(!out.picker.leveling.some((e) => e.startsWith('acceptance-good/')), 'our categories list only our guides');
	assert.ok(out.picker.leveling.includes(WESTFALL));
	assert.equal(out.credits, 'By Ann Example  ·  Acceptance Good 0.1.0  ·  CC-BY-4.0');
	assert.equal(out.ours, 'By Polestar');
	assert.equal(out.next, WESTFALL);
});

test('the example guide played to its end hands over to our Westfall guide', { skip }, () => {
	const [out] = run(`
		E.OpenTab("acceptance-good/example"); flush()
		local start = { guide = E.GetGuide().id, step = E.GetStepIndex() }
		local w = stub.world
		local trace = {}
		for _, p in ipairs({ { 42.9, 65.6 }, { 24.2, 74.5 }, { 20.6, 80.5 } }) do
			w.moveTo(1429, p[1], p[2]); stub.advance(1); flush()
			trace[#trace + 1] = { E.GetGuide().id, E.GetStepIndex() }
		end
		emit({ start = start, guide = E.GetGuide() and E.GetGuide().id, tabs = tabs(), trace = trace })`);
	assert.deepEqual(out.start, { guide: 'acceptance-good/example', step: 1 });
	assert.equal(out.guide, WESTFALL, JSON.stringify(out));
});

test('the bad addons\' refusals show on the page and our guides are untouched', { skip }, () => {
	const [out] = run(`
		UI.ShowOptions("guidepacks")
		local function row(addon)
			local r = rowOf(addon)
			if not r then return false end
			local list = false
			if r.ShowList:IsShown() then r.ShowList:Click(); r = rowOf(addon); list = shownText(r.List) end
			return { status = shownText(r.Status), switch = r.Switch:IsShown(), problems = r.Problems:IsShown() and r.Problems.Text:GetText() or false, list = list }
		end
		local westfall, example = G.Get(${luaStr(WESTFALL)}), G.Get("acceptance-good/example")
		emit({ imposter = row(${luaStr(IMPOSTER)}), stray = row(${luaStr(STRAY)}), future = row(${luaStr(FUTURE)}),
			westfall = { title = westfall.title, pack = westfall.pack }, example = { title = example.title, pack = example.pack },
			stray_walk = G.Get("acceptance-stray/walk") ~= nil, future_guide = G.Get("acceptance-future/a") ~= nil,
			count = G.Pack("acceptance-good").guideCount, ours = G.Pack("guides").guideCount, oursProblems = #G.Pack("guides").problems })`);
	assert.match(out.imposter.status, /^refused: Pack id acceptance-good is already taken by PolestarPack_AcceptanceGood; PolestarPack_AcceptanceImposter was refused\. 1 guide dropped\.$/);
	assert.equal(out.imposter.switch, false);
	assert.equal(out.stray.problems, '1 problem');
	assert.match(out.stray.list, /Guide forever\/alliance\/02-westfall was refused: its id must start with acceptance-stray\//);
	assert.equal(out.stray.switch, true, 'the rest of the pack is on');
	assert.equal(out.stray_walk, true);
	assert.equal(out.future.status, 'needs Polestar 0.9.0 or newer');
	assert.equal(out.future.switch, false);
	assert.equal(out.future_guide, false);
	assert.deepEqual(out.westfall, { title: 'Westfall', pack: 'guides' });
	assert.deepEqual(out.example, { title: 'Goldshire to Westfall', pack: 'acceptance-good' });
	assert.equal(out.count, 2);
	assert.equal(out.oursProblems, 0);
	assert.ok(out.ours > 100, `our pack keeps its guides (${out.ours})`);
});

test('switching the pack off and on hides and restores its guides and its open tab, without a reload', { skip }, () => {
	const [out] = run(`
		E.OpenTab(${luaStr(WESTFALL)}); E.OpenTab("acceptance-good/farms"); flush()
		local function state()
			UI.ShowPicker()
			return { get = G.Get("acceptance-good/farms") ~= nil, tabs = tabs(), guide = E.GetGuide() and E.GetGuide().id,
				entry = table.concat(nav(), "|"):find("Acceptance Good", 1, true) ~= nil }
		end
		local r = { before = state() }
		local reloads = stub.reloaded or false
		UI.ShowOptions("guidepacks")
		rowOf(${luaStr(GOOD)}).Switch:Click(); flush()
		r.off = state()
		UI.ShowOptions("guidepacks")
		rowOf(${luaStr(GOOD)}).Switch:Click(); flush()
		r.on = state()
		r.reloaded = (stub.reloaded or false) ~= reloads
		emit(r)`);
	const has = (s) => s.tabs.includes('acceptance-good/farms');
	assert.equal(out.before.get, true);
	assert.ok(has(out.before), out.before.tabs.join(', '));
	assert.equal(out.before.entry, true);
	assert.equal(out.off.get, false);
	assert.ok(!has(out.off), out.off.tabs.join(', '));
	assert.equal(out.off.entry, false);
	assert.notEqual(out.off.guide, 'acceptance-good/farms');
	assert.equal(out.on.get, true);
	assert.deepEqual(out.on.tabs, out.before.tabs, 'the tab comes back in its place');
	assert.equal(out.on.entry, true);
	assert.equal(out.reloaded, false);
});

test('suggestions come from the chosen pack and fall back to ours for a character it does not cover', { skip }, () => {
	const script = `
		local r = { default = G.Suggest() }
		Polestar.Set("behavior.suggestFrom", "acceptance-good")
		r.source = G.SuggestSource()
		r.chosen = G.Suggest()
		emit(r)`;
	const [human] = run(script);
	assert.equal(human.source, 'acceptance-good');
	assert.equal(human.chosen, 'acceptance-good/example');
	assert.ok(human.default && !human.default.startsWith('acceptance-good/'), human.default);
	const [orc] = run(script, {
		world: `w.addMap(1411, { name = "Durotar", c = 1, left = -1962.5, right = -7250, top = 1808.333, bottom = -1716.667 })
w.moveTo(1411, 52, 43)
w.race, w.raceName, w.faction, w.class, w.className = "Orc", "Orc", "Horde", "WARRIOR", "Warrior"`,
	});
	assert.equal(orc.source, 'acceptance-good');
	assert.ok(orc.chosen && orc.chosen.startsWith('forever/horde/'), String(orc.chosen));
	assert.equal(orc.chosen, orc.default, 'ours fill in where the pack has nothing');
});

test('the welcome greets a new character on a profile that saw the beta notice, walks its three pages and reopens from About', { skip }, () => {
	const saved = 'PolestarDB = { schema = 1, settings = {}, betaNoticeSeen = true }';
	const [out] = run(`
		stub.advance(3)
		local Wel = UI.Welcome
		local first = PolestarWelcome ~= nil and PolestarWelcome:IsShown()
		local pages = {}
		for i = 1, 4 do
			pages[i] = select(4, Wel.Page())
			if i < 4 then PolestarWelcome.Next:Click() end
		end
		local next = PolestarWelcome.Next:IsShown()
		PolestarWelcome.Browse:Click()
		local closed = not PolestarWelcome:IsShown()
		UI.ShowOptions("about")
		UI.Options.view.Welcome:Click()
		emit({ first = first, guide = G.Get(G.Suggest()).title, pages = pages, next = next, closed = closed,
			seen = PolestarDB.welcomeSeen, char = PolestarCharDB.welcomeSeen, old = PolestarDB.betaNoticeSeen or false,
			reopened = PolestarWelcome:IsShown(), title = select(4, Wel.Page()) })`, { saved });
	assert.equal(out.first, true);
	assert.deepEqual(out.pages, ['Hello, Testchar', 'Make it yours', 'Route style', out.guide], 'the last page names the suggested guide');
	assert.equal(out.next, false, 'the last page has the guide buttons, not Next');
	assert.equal(out.closed, true);
	assert.equal(out.seen, 1);
	assert.equal(out.char, 1);
	assert.equal(out.old, false);
	assert.equal(out.reopened, true);
	assert.equal(out.title, 'Hello, Testchar');

	const [again] = run('stub.advance(10)\nemit({ shown = PolestarWelcome ~= nil and PolestarWelcome:IsShown() })', {
		saved: 'PolestarDB = { schema = 1, settings = {}, welcomeSeen = 1 }\nPolestarCharDB = { schema = 1, welcomeSeen = 1 }',
	});
	assert.equal(again.shown, false, 'the next login of that character does not show it');
});

test('a "|" in a pack and its guide prints literally in the guide window and the picker, escaped exactly once', { skip }, () => {
	const src = path.join(tmp, 'pipe');
	fs.mkdirSync(path.join(src, 'guides'), { recursive: true });
	fs.writeFileSync(path.join(src, 'pack.json'), JSON.stringify({ id: 'pipe', title: 'Pipe |cffff0000Red|r', author: 'Pi|pe', version: '1.0.0', license: 'CC0-1.0', source: 'My |Hitem:1|h notes', folder: 'PolestarPack_Pipe' }));
	fs.writeFileSync(path.join(src, 'guides', 'walk.guide'), [
		'guide pipe/walk', 'title Walk |cffff0000Red|r', 'faction Alliance', 'levels 5-10', 'zone Elwynn Forest', '',
		'step Step |Hone', '  tip Mind the |cffff0000red|r sign.', '  goto 24.2,74.5 "Mill |cffgold" r 30', '',
	].join('\n'));
	const out = path.join(tmp, 'pipe-out', 'PolestarPack_Pipe');
	polestar(['compile', src, '--out', out], tmp);
	const [r] = run(`
		E.OpenTab("pipe/walk"); flush()
		local texts = {}
		local function walk(f)
			for _, x in ipairs(f.regions or {}) do
				if x.kind == "FontString" and x.text and stub.Methods.IsVisible(x) then texts[#texts + 1] = x.text end
			end
			for _, c in ipairs(f.children or {}) do walk(c) end
		end
		walk(PolestarGuideFrame)
		UI.ShowPicker()
		UI.Picker.SetCategory("pack:pipe")
		UI.Picker.Select("pipe/walk")
		emit({ guide = E.GetGuide() and E.GetGuide().id, texts = texts, header = PolestarPicker.Title:GetText(),
			credits = UI.Picker.details.Credits:GetText(), source = UI.Picker.details.Source:GetText() })`, { extra: [{ name: 'PolestarPack_Pipe', dir: out }] });
	assert.equal(r.guide, 'pipe/walk');
	const all = r.texts.join('\n');
	for (const want of ['Walk ||cffff0000Red||r', 'Mind the ||cffff0000red||r sign.']) assert.ok(all.includes(want), `${want} in:\n${all}`);
	assert.ok(/Mill \|\|cffgold/.test(all), `the goto label in:\n${all}`);
	assert.doesNotMatch(all, /\|\|\|\|/, 'escaped once');
	// Apart from the window's own colour codes, no "|" stands alone.
	assert.doesNotMatch(all.replace(/\|\|/g, '').replace(/\|c[0-9a-f]{8}|\|r/g, ''), /\|/, 'no "|" left alone');
	assert.equal(r.header, 'Pipe ||cffff0000Red||r');
	assert.equal(r.credits, 'By Pi||pe  ·  Pipe ||cffff0000Red||r 1.0.0  ·  CC0-1.0');
	assert.equal(r.source, '“My ||Hitem:1||h notes”');
});
