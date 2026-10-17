'use strict';
// Emitted Lua (tools/lib/dsl/emit.js) and the compile/lint commands: the pack
// loads under Lua 5.1 next to Core/Init.lua and round-trips to the compiled
// structure; output is byte-identical across runs; errors block writes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { compile, guideText, plain, GUIDES_DIR, DATA_DIR, ourManifest, writeTestPack } = require('./helpers/dsl');
const { tmpdir } = require('./helpers/tmp');
const { polestar } = require('./helpers/cli');
const { compileProject } = require('../tools/lib/dsl/project');
const { fillTokens } = require('../tools/lib/dsl/tokens');

const cli = (...args) => polestar(args);

function luaString(s) {
	return JSON.stringify(s);
}

// Load a pack folder the way the client does (its TOC's files in order) with
// Core/Init.lua and stand-ins for the registration functions; return what got
// registered.
function loadPack(pack) {
	const files = pack.scripts;
	const [out] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua'] }],
		script: `
			local packs, guides, frames = {}, {}, {}
			Polestar.RegisterPack = function(m) packs[#packs + 1] = m end
			Polestar.RegisterGuide = function(g) guides[#guides + 1] = g; return true end
			Polestar.RegisterMapFrames = function(f, p) frames[#frames + 1] = { frames = f, pack = p } end
			local ns = {}
			for _, f in ipairs({ ${files.map(luaString).join(', ')} }) do
				local chunk = assert(loadfile(f))
				chunk("Polestar_Guides", ns)
			end
			emit({ packs = packs, guides = guides, frames = frames, globals = { ADDON = rawget(_G, "ADDON") == nil, ns = rawget(_G, "ns") == nil } })`,
	}).emitted;
	return { ...out, files };
}

function readTree(dir) {
	const out = {};
	const walk = (d) => {
		for (const e of fs.readdirSync(d, { withFileTypes: true })) {
			const p = path.join(d, e.name);
			if (e.isDirectory()) walk(p);
			else out[path.relative(dir, p).split(path.sep).join('/')] = fs.readFileSync(p);
		}
	};
	walk(dir);
	return out;
}

test('the compiled pack loads under Lua 5.1 with Core/Init.lua and round-trips to the compiled structure', () => {
	const manifest = ourManifest();
	const { guides, diag, data } = compileProject({ packDir: GUIDES_DIR, manifest, dataDir: DATA_DIR });
	assert.equal(diag.hasErrors(), false);
	const pack = writeTestPack(guides, data, manifest);
	const loaded = loadPack(pack);
	assert.deepEqual(loaded.packs, [
		{
			addon: 'Polestar_Guides',
			id: 'guides',
			format: 3,
			title: 'Polestar Guides',
			author: 'Polestar',
			version: manifest.version,
			license: 'GPL-3.0-only',
			notes: 'Leveling, profession, reputation and collectible guides for Polestar.',
		},
	]);
	// Guides.lua holds the guides as compiled, their texts with name tokens (tokens.js).
	assert.deepEqual(loaded.guides, plain(guides.map((g) => g._localised)));
	assert.deepEqual(loaded.guides.map((g) => g.id), ['forever/alliance/human/01-northshire', 'forever/alliance/human/02-elwynn']);
	assert.deepEqual(loaded.guides.map((g) => g.pack), ['guides', 'guides']);
	// Era bounds only for maps the guides reference (all fixture goals are in Elwynn Forest).
	assert.deepEqual(loaded.frames, [{ frames: { era: { 1429: { c: 1415, left: 1535.4166, right: -1941.6666, top: 1300, bottom: -1060.4166 } } }, pack: 'guides' }]);
	// Files leak no globals beyond Polestar's registration calls.
	assert.deepEqual(loaded.globals, { ADDON: true, ns: true });
	// The TOC lists every Lua file in the folder, Pack.lua first.
	const lua = Object.keys(readTree(pack.dir)).filter((f) => f.endsWith('.lua')).sort();
	assert.deepEqual(loaded.files.map((f) => path.relative(pack.dir, f).split(path.sep).join('/')).sort(), lua);
	assert.equal(path.basename(loaded.files[0]), 'Pack.lua');
	assert.match(fs.readFileSync(path.join(pack.dir, 'LICENSE-DATA.txt'), 'utf8'), /pfQuest[\s\S]*MIT License[\s\S]*Copyright \(c\) 2017-2021 Eric Mauser \(Shagu\)/);
});

test('strings with quotes, backslashes, control characters and UTF-8 survive the trip through Lua', () => {
	const tricky = 'Say "hi" \\ to Ünïcödé ✓\tTab';
	const src = guideText([
		'guide t/strings',
		`title ${tricky}`,
		'levels 1-2',
		'zone Elwynn Forest',
		'',
		`step ${tricky}`,
		'  tip First line.',
		'  tip ]] [[ --[[ not a comment',
		`  accept 424243 "${tricky.replace(/\\/g, '\\\\').replace(/"/g, '\\"')}" -- note with "quotes" and \\ backslash`,
		'  note "x\ty" r 7.25 @12.345,0.005',
	]);
	const r = compile(src);
	assert.deepEqual(r.errors, []);
	const loaded = loadPack(writeTestPack(r.guides));
	assert.deepEqual(loaded.guides, plain(r.guides.map((x) => x._localised)));
	const g = loaded.guides[0];
	// The title names the quest: a token, its English in `names`.
	assert.equal(fillTokens(g.title, g.names), tricky);
	assert.equal(fillTokens(g.steps[0].title, g.names), tricky);
	assert.equal(g.steps[0].note, 'First line.\n]] [[ --[[ not a comment');
	assert.equal(g.steps[0].goals[0].title, tricky);
	assert.equal(g.steps[0].goals[0].note, 'note with "quotes" and \\ backslash');
	// Coordinates are stored with two decimals.
	assert.deepEqual([g.steps[0].goals[1].x, g.steps[0].goals[1].y, g.steps[0].goals[1].r], [12.35, 0.01, 7.25]);
});

test('folder, keywords and collects compile into the guide table and load in the addon', () => {
	const src = guideText(['guide t/folder', 'title Horse', 'category Collectibles', 'folder Mounts · Level 40', 'keywords Pinto Bridle, Chestnut Mare', 'collects 2414, 5655', 'levels 40-40', 'zone Elwynn Forest', '', 'step S', '  level 40']);
	const r = compile(src);
	assert.deepEqual(r.errors, []);
	assert.equal(r.guides[0].folder, 'Mounts · Level 40');
	assert.deepEqual(r.guides[0].keywords, ['Pinto Bridle', 'Chestnut Mare']);
	assert.deepEqual(r.guides[0].collects, [2414, 5655]);
	assert.deepEqual(loadPack(writeTestPack(r.guides)).guides, plain(r.guides));
});

test('compile output is byte-identical across runs and skips drafts', () => {
	const a = tmpdir();
	const b = tmpdir();
	for (const out of [a, b]) {
		const r = cli('compile', '--guides', GUIDES_DIR, '--data', DATA_DIR, '--out', out);
		assert.equal(r.status, 0, r.stderr + r.stdout);
	}
	const ta = readTree(a);
	const tb = readTree(b);
	assert.deepEqual(Object.keys(ta).sort(), ['Guides.lua', 'LICENSE-DATA.txt', 'Polestar_Guides.toc', 'MapFrames.lua', 'Pack.lua'].sort());
	assert.match(ta['Guides.lua'].toString(), /-- Source: forever\/alliance\/human\/01-northshire\.guide\n[\s\S]*-- Source: forever\/alliance\/human\/02-elwynn\.guide\n/);
	for (const f of Object.keys(ta)) assert.ok(ta[f].equals(tb[f]), `${f} differs between runs`);
});

test('compile with errors exits non-zero and writes nothing; --include-drafts pulls drafts in', () => {
	const out = path.join(tmpdir(), 'pack');
	const r = cli('compile', '--guides', GUIDES_DIR, '--data', DATA_DIR, '--out', out, '--include-drafts');
	assert.equal(r.status, 1);
	assert.match(r.stderr, /drafts\/wip\.guide:7: error: quest 999999 is not in data/);
	assert.equal(fs.existsSync(out), false);
});

test('recompiling replaces the old Pack.xml layout and keeps files compile does not own', () => {
	const out = tmpdir();
	fs.mkdirSync(path.join(out, 'Guides', 'old'), { recursive: true });
	fs.writeFileSync(path.join(out, 'Guides', 'old', 'gone.lua'), '-- stale\n');
	fs.writeFileSync(path.join(out, 'Pack.xml'), '<Ui>\n\t<!-- Generated by `node tools/polestar.js compile`. Do not edit. -->\n</Ui>\n');
	fs.writeFileSync(path.join(out, 'Polestar_Guides.toc'), '## Title: old\n\nPack.xml\n');
	fs.writeFileSync(path.join(out, 'README.txt'), 'kept\n');
	const r = cli('compile', '--guides', GUIDES_DIR, '--data', DATA_DIR, '--out', out);
	assert.equal(r.status, 0, r.stderr);
	assert.equal(fs.existsSync(path.join(out, 'Guides')), false);
	assert.equal(fs.existsSync(path.join(out, 'Pack.xml')), false);
	assert.match(fs.readFileSync(path.join(out, 'Polestar_Guides.toc'), 'utf8'), /^## X-Polestar-Pack: guides$/m);
	assert.equal(fs.readFileSync(path.join(out, 'README.txt'), 'utf8'), 'kept\n');
	// Recompiling into the folder it generated works.
	assert.equal(cli('compile', '--guides', GUIDES_DIR, '--data', DATA_DIR, '--out', out).status, 0);
});

test('lint runs the same checks without writing, with matching exit codes', () => {
	const ok = cli('lint', '--guides', GUIDES_DIR, '--data', DATA_DIR);
	assert.equal(ok.status, 0, ok.stderr);
	// One warning: the fixture's goto before the kobolds (tests/dsl-validate.test.js).
	assert.match(ok.stdout, /lint ok: 2 files, 2 guides: 0 errors, 1 warning\n/);
	const bad = cli('lint', '--guides', GUIDES_DIR, '--data', DATA_DIR, '--include-drafts');
	assert.equal(bad.status, 1);
	assert.match(bad.stderr, /wip\.guide:7: error: `turnin` for quest 999999 that is never accepted/);
	const usage = cli('lint', '--bogus');
	assert.equal(usage.status, 2);
});

test('without reference data lint and compile stop with one error before reading any guide', () => {
	const missing = path.join(tmpdir(), 'nope');
	const empty = tmpdir();
	for (const dir of [missing, empty]) {
		const lint = cli('lint', '--guides', GUIDES_DIR, '--data', dir);
		assert.equal(lint.status, 1, lint.stderr);
		assert.equal(lint.stdout, '');
		const errors = lint.stderr.split('\n').filter((l) => /error:/.test(l));
		assert.equal(errors.length, 1, lint.stderr);
		assert.ok(errors[0].startsWith(`${dir}: error: no reference data: the folder ${dir === missing ? 'does not exist' : 'holds none of quests.json'}`), errors[0]);
		assert.match(lint.stderr, /hint: run `node tools\/polestar\.js data build`, or pass --data <dir>; --no-data/);
		assert.match(lint.stderr, /\nlint failed: no reference data\n$/);
		assert.doesNotMatch(lint.stderr, /\.guide/);
	}
	const out = tmpdir();
	const compile = cli('compile', '--guides', GUIDES_DIR, '--data', missing, '--out', out, '--format', 'json');
	assert.equal(compile.status, 1, compile.stderr);
	const doc = JSON.parse(compile.stdout);
	assert.deepEqual([doc.ok, doc.errors, doc.warnings, doc.diagnostics.length], [false, 1, 0, 1]);
	assert.equal(doc.diagnostics[0].file, missing);
	assert.deepEqual(fs.readdirSync(out), []);
});

test('partial reference data is a warning naming the missing files, and the guides are checked', () => {
	const data = tmpdir();
	for (const f of fs.readdirSync(DATA_DIR)) if (f !== 'map-frames.json') fs.copyFileSync(path.join(DATA_DIR, f), path.join(data, f));
	const r = cli('lint', '--guides', GUIDES_DIR, '--data', data);
	assert.match(r.stderr, /: warning: missing map-frames\.json\n/);
	assert.match(r.stdout + r.stderr, /lint (ok|failed): 2 files, 2 guides: /);
});

test('--no-data compiles guides that give every name themselves', () => {
	const guides = tmpdir();
	fs.writeFileSync(path.join(guides, 'a.guide'), guideText(['guide forever/a', 'title A', 'levels 1-2', 'zone map 1429', '', 'step S', '  accept 424243 "New Quest" @50,50', '  turnin 424243 "New Quest"']));
	const out = tmpdir();
	const r = cli('compile', '--guides', guides, '--no-data', '--out', out);
	assert.equal(r.status, 0, r.stderr);
	assert.doesNotMatch(r.stderr, /reference data/);
	assert.match(fs.readFileSync(path.join(out, 'Guides.lua'), 'utf8'), /id = "forever\/a"/);
	assert.match(fs.readFileSync(path.join(out, 'LICENSE-DATA.txt'), 'utf8'), /No reference data sources were recorded/);
	const both = cli('lint', '--guides', guides, '--no-data', '--data', DATA_DIR);
	assert.equal(both.status, 2);
	assert.match(both.stderr, /--no-data and --data cannot be used together/);
});

test('compile never writes into a folder that is not a generated pack (case-insensitive --out at the repo)', () => {
	const out = tmpdir();
	fs.mkdirSync(path.join(out, 'Guides', 'forever'), { recursive: true });
	fs.writeFileSync(path.join(out, 'Guides', 'forever', 'precious.guide'), 'guide t/x\n');
	const r = cli('compile', '--guides', GUIDES_DIR, '--data', DATA_DIR, '--out', out);
	assert.equal(r.status, 1);
	assert.match(r.stderr, /refusing to write into .*: it is not a generated community addon/);
	assert.equal(fs.readFileSync(path.join(out, 'Guides', 'forever', 'precious.guide'), 'utf8'), 'guide t/x\n');
	assert.deepEqual(fs.readdirSync(out), ['Guides']);
});
