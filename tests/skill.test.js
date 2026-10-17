'use strict';
// The skills for coding agents in skills/ (agentskills.io format) keep up
// with the tools: each one's front matter follows the format's rules, every
// file it links exists, and every `polestar <command> --option` it names
// exists. polestar-guide-pack, the pack authors' skill, also has its
// guide-format reference name every header key, step line, verb, modifier
// and condition the parser accepts (and nothing else), and its example guide
// lint clean and play to the end against data/forever (skipped without it).
// The Claude Code and Codex plugins carry every skill.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { VERBS, MODS, MOD_WORDS, HEADER_KEYS, STEP_KEYS } = require('../tools/lib/dsl/parse');
const { FACTIONS } = require('../tools/lib/dsl/conditions');
const { CLASSES, RACES } = require('../tools/lib/game/races');
const { load } = require('../tools/polestar');
const { tmpdir } = require('./helpers/tmp');
const { needs } = require('./helpers/data');
const cli = require('./helpers/cli');

const SKILLS = path.join(__dirname, '..', 'skills');
const SKILL = path.join(SKILLS, 'polestar-guide-pack');
const read = (rel) => fs.readFileSync(path.join(SKILL, rel), 'utf8');
const MAIN = read('SKILL.md');
const REF = read('references/guide-format.md');
const COMMANDS = load();
const ALL = fs.readdirSync(SKILLS, { withFileTypes: true }).filter((d) => d.isDirectory() && !d.name.startsWith('.')).map((d) => d.name).sort();
const skillText = (name) => fs.readFileSync(path.join(SKILLS, name, 'SKILL.md'), 'utf8');

const spans = (text) => [...text.matchAll(/`([^`\n]+)`/g)].map((m) => m[1]);

// Fenced code blocks, indented ones (inside a list) too: [{ info, text }].
function blocks(text) {
	const out = [];
	let open = null;
	for (const line of text.split('\n')) {
		const fence = /^(\s*)```(\S*)\s*$/.exec(line);
		if (fence && !open) open = { indent: fence[1].length, info: fence[2], lines: [] };
		else if (fence && open) {
			out.push({ info: open.info, text: open.lines.join('\n') });
			open = null;
		} else if (open) open.lines.push(line.slice(open.indent));
	}
	assert.equal(open, null, 'every code fence is closed');
	return out;
}

// The markdown tables under a `## heading`: rows of trimmed cells, header row
// and separator dropped.
function table(text, heading) {
	const start = text.indexOf(`\n## ${heading}\n`);
	assert.ok(start >= 0, `## ${heading}`);
	const end = text.indexOf('\n## ', start + 1);
	const rows = [];
	let first = true;
	for (const line of text.slice(start, end < 0 ? undefined : end).split('\n')) {
		if (!line.startsWith('|')) {
			first = true;
			continue;
		}
		const cells = line.split('|').slice(1, -1).map((c) => c.trim());
		if (!first && !/^-+$/.test(cells[0])) rows.push(cells);
		first = false;
	}
	return rows;
}

// The first word of each code span in a row's first cell: `zone <Name>` -> zone.
const firstWords = (rows) => rows.flatMap((r) => spans(r[0])).map((s) => s.split(/[\s<]/)[0].toLowerCase());

test('every SKILL.md front matter follows the agentskills.io format', () => {
	assert.ok(ALL.includes('polestar-guide-pack'));
	for (const name of ALL) {
		const main = skillText(name);
		const m = /^---\n([\s\S]*?)\n---\n/.exec(main);
		assert.ok(m, `${name}: SKILL.md starts with --- front matter ---`);
		const fields = {};
		for (const line of m[1].split('\n')) {
			const kv = /^([a-z-]+): (.+)$/.exec(line);
			assert.ok(kv, `${name}: one "key: value" per line: ${line}`);
			// A plain YAML scalar: no ": " or " #" inside, no quote or indicator first.
			assert.doesNotMatch(kv[2], /: | #|^["'&*!|>%@`[{]/, `${name}: ${kv[1]} reads as plain YAML`);
			fields[kv[1]] = kv[2];
		}
		assert.deepEqual(Object.keys(fields).filter((k) => !['name', 'description', 'license', 'compatibility', 'metadata', 'allowed-tools'].includes(k)), []);
		assert.equal(fields.name, name);
		assert.match(fields.name, /^[a-z0-9]+(-[a-z0-9]+)*$/);
		assert.ok(fields.name.length <= 64);
		assert.ok(fields.description && fields.description.length <= 1024, `${name}: description of 1 to 1024 characters`);
		assert.ok(!fields.compatibility || fields.compatibility.length <= 500);
		assert.ok(main.split('\n').length < 500, `${name}: SKILL.md under 500 lines`);
	}
});

test('every file a SKILL.md links and every repository file it names exists', () => {
	const root = path.join(__dirname, '..');
	for (const name of ALL) {
		const main = skillText(name);
		const links = [...main.matchAll(/\]\(([^)#]+)\)/g)].map((m) => m[1]).filter((l) => !/^[a-z]+:/.test(l));
		for (const l of links) assert.ok(fs.existsSync(path.join(SKILLS, name, l)), `${name}: ${l}`);
		const named = spans(main).filter((s) => /^(docs|skills|tests|tools)\/[^\s*<]+\.(md|js|json)$/.test(s) || /^[A-Z]+\.md$/.test(s));
		for (const f of named) assert.ok(fs.existsSync(path.join(root, f)), `${name}: ${f}`);
	}
	assert.ok([...MAIN.matchAll(/\]\(([^)#]+)\)/g)].some((m) => m[1] === 'references/guide-format.md'));
	const docs = spans(MAIN + REF).filter((s) => /^docs\/[A-Z_]+\.md$/.test(s));
	assert.ok(docs.length >= 4);
	for (const d of docs) assert.ok(fs.existsSync(path.join(__dirname, '..', d)), d);
});

// Claude Code finds every skill under the plugin's skills path on its own;
// Codex only takes a list, so a new skill must be added to it.
test('the Claude Code and Codex plugins carry every skill', () => {
	const root = path.join(__dirname, '..');
	const json = (rel) => JSON.parse(fs.readFileSync(path.join(root, rel), 'utf8'));
	const claude = json('.claude-plugin/marketplace.json').plugins.find((p) => p.name === 'polestar');
	assert.equal(path.join(root, claude.source, ...claude.skills), SKILLS + path.sep);
	const codex = json('.agents/plugins/marketplace.json').plugins.find((p) => p.name === 'polestar');
	assert.equal(path.join(root, codex.source.path), SKILLS);
	const manifest = json('skills/.codex-plugin/plugin.json');
	assert.deepEqual(manifest.skills.map((s) => path.basename(s)).sort(), ALL);
});

// Every `polestar <command> ...` the skill writes, from code spans and code
// blocks (a `# comment` dropped): [{ cmd, args }].
function invocations(texts) {
	const lines = [];
	for (const text of texts) {
		lines.push(...spans(text));
		for (const b of blocks(text)) lines.push(...b.text.split('\n').map((l) => l.replace(/\s#\s.*$/, '')));
	}
	const out = [];
	for (const line of lines) {
		for (const m of line.matchAll(/(?<![<\/.\w-])polestar ([a-z][a-z0-9]*)((?: [^\s|]+| "[^"]*")*)/g)) out.push({ cmd: m[1], args: m[2].trim(), line });
	}
	return out;
}

test('every polestar command and option a skill names exists', () => {
	const used = new Set(invocations([MAIN, REF]).map((c) => c.cmd));
	for (const cmd of ['new', 'find', 'lint', 'playtest', 'play', 'dev', 'pack', 'doctor']) assert.ok(used.has(cmd), `the skill names polestar ${cmd}`);
	const kinds = /--kind <k>\s+only ([a-z, ]+)/.exec(COMMANDS.get('find').usage)[1].split(/,\s*/);
	for (const name of ALL) {
		const texts = name === 'polestar-guide-pack' ? [MAIN, REF] : [skillText(name)];
		for (const { cmd, args, line } of invocations(texts)) {
			if (cmd === 'help') continue;
			assert.ok(COMMANDS.has(cmd), `${name}: unknown command in: ${line}`);
			const usage = COMMANDS.get(cmd).usage;
			for (const opt of args.match(/--[a-z][a-z-]*/g) || []) assert.match(usage, new RegExp(`${opt}(?![a-z-])`), `${name}: polestar ${cmd} --help has no ${opt}: ${line}`);
			const kind = /--kind (\S+)/.exec(args);
			if (kind && !kind[1].startsWith('<')) assert.ok(kinds.includes(kind[1]), `${name}: find --kind ${kind[1]}: ${line}`);
		}
	}
});

test('the reference names every header key, step line, verb, modifier and condition, and no other', () => {
	const header = firstWords(table(REF, 'Header'));
	assert.deepEqual(HEADER_KEYS.filter((k) => !header.includes(k)), []);
	assert.deepEqual(header.filter((k) => !HEADER_KEYS.includes(k)), []);

	const steps = firstWords(table(REF, 'Steps'));
	assert.deepEqual(['step', ...STEP_KEYS].filter((k) => !steps.includes(k)), []);
	assert.deepEqual(steps.filter((k) => k !== 'step' && !STEP_KEYS.includes(k)), []);

	const verbs = firstWords(table(REF, 'Goals'));
	assert.deepEqual(VERBS.filter((v) => !verbs.includes(v)), []);
	assert.deepEqual(verbs.filter((v) => !VERBS.includes(v)), []);

	// Modifier forms that are no word of MOD_WORDS.
	const FORMS = ['@x,y', 'x<n>', '"text"'];
	const mods = table(REF, 'Modifiers').flatMap((r) => spans(r[0])).map((s) => s.toLowerCase());
	const modWords = mods.map((s) => (FORMS.includes(s) ? s : s.split(' ')[0]));
	assert.deepEqual([...MOD_WORDS, ...FORMS].filter((w) => !modWords.includes(w)), []);
	assert.deepEqual(modWords.filter((w) => !MOD_WORDS.includes(w) && !FORMS.includes(w)), []);

	const names = new Set(spans(REF.slice(REF.indexOf('\n## Conditions\n'))).map((s) => s.toLowerCase()));
	assert.deepEqual([...Object.keys(CLASSES), ...Object.keys(RACES), ...Object.keys(FACTIONS)].filter((n) => !names.has(n)), []);
});

// The parser's modifier names as the reference writes them.
const LABEL = { at: '@x,y', count: 'xN', text: '"text"', frame: 'era', until: 'until', criteria: 'criteria' };
const COMMON = ['optional', 'only', 'text', 'group'];
const PLACE = ['at', 'map', 'r', 'frame'];

test("the Goals table's last column lists exactly the modifiers each verb takes", () => {
	for (const row of table(REF, 'Goals')) {
		const verb = spans(row[0])[0].split(' ')[0];
		const allowed = MODS[verb];
		const col = row[row.length - 1];
		const named = spans(col).map((s) => s.split(' ')[0]);
		const label = (m) => LABEL[m] || m;
		// Beyond the common ones: the verb's own modifiers, as written.
		const own = allowed.filter((m) => !COMMON.includes(m) && !PLACE.includes(m)).map(label);
		const placeNamed = named.filter((n) => ['@x,y', 'map', 'r', 'era', 'live'].includes(n));
		const ownNamed = named.filter((n) => !placeNamed.includes(n) && n !== '"text"' && n !== 'group');
		assert.deepEqual(ownNamed.sort(), own.sort(), `${verb}: ${col}`);
		const place = allowed.filter((m) => PLACE.includes(m));
		if (/no place modifiers/.test(col)) assert.deepEqual(place, [], verb);
		else if (/ only$/.test(col)) assert.deepEqual(placeNamed.filter((n) => n !== 'live').map((n) => ({ era: 'frame' })[n] || n).sort(), place.sort(), verb);
		else assert.deepEqual(place, PLACE, `${verb} takes every place modifier`);
		// The common ones, but those the column says the verb takes not ("no `group`").
		const without = COMMON.filter((m) => col.includes(`no \`${label(m)}\``));
		const common = COMMON.filter((m) => allowed.includes(m));
		assert.deepEqual(common, COMMON.filter((m) => !without.includes(m)), `${verb} takes ${COMMON.filter((m) => !without.includes(m)).join(', ')}`);
	}
});

const hasLua = () =>
	['lua5.1', 'luajit', 'lua'].some((b) => {
		const r = spawnSync(b, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' });
		return r.status === 0 && /5\.1/.test(r.stdout);
	});

// The example guide in a pack of its own (the pack id it uses).
function examplePack() {
	const guide = blocks(MAIN).find((b) => b.text.startsWith('guide '));
	assert.ok(guide, 'SKILL.md has an example guide');
	const id = /^guide ([a-z0-9-]+)\//.exec(guide.text)[1];
	const dir = tmpdir('polestar-skill-');
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify({ id, title: 'Skill Example', author: 'Joe', version: '1.0.0', license: 'CC0-1.0' }));
	fs.mkdirSync(path.join(dir, 'guides'));
	fs.writeFileSync(path.join(dir, 'guides', 'example.guide'), guide.text);
	return dir;
}

test('the example guide lints clean against the reference data', { skip: needs('quests.json', 'npcs.json', 'zones.json') }, () => {
	const r = cli.polestar(['lint', examplePack(), '--format', 'json']);
	const doc = JSON.parse(r.stdout);
	assert.equal(r.status, 0, r.stdout + r.stderr);
	assert.deepEqual({ errors: doc.errors, warnings: doc.warnings }, { errors: 0, warnings: 0 }, r.stdout);
});

test('the example guide plays to the end', { skip: needs('quests.json', 'npcs.json', 'zones.json', 'races.json') || (!process.env.LUA && !hasLua() && 'no Lua 5.1') }, () => {
	const r = cli.polestar(['playtest', examplePack()]);
	assert.equal(r.status, 0, r.stdout + r.stderr);
	assert.match(r.stdout, /^ok {2}/m);
	assert.doesNotMatch(r.stdout, /^(stuck|fail)/m);
});
