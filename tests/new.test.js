'use strict';
// polestar new: a pack folder from tools/templates/pack/. The end-to-end test
// needs data/forever and Lua 5.1; it skips without them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { ROOT } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');
const cli = require('./helpers/cli');
const { needs } = require('./helpers/data');

const ARGS = ['--yes', '--id', 'ann-routes', '--title', "Ann's Routes", '--author', 'Ann'];
const REPO = 'https://example.test/polestar.git';

function hasLua() {
	return ['lua5.1', 'luajit', 'lua'].some((b) => {
		const r = spawnSync(b, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' });
		return r.status === 0 && /5\.1/.test(r.stdout);
	});
}

// The origin URL `new` reads stands in for this clone's git remote; without
// one, the test's own environment must not leak a value.
function polestar(args, { cwd, origin, env = {}, input = '' } = {}) {
	return cli.polestar(args, { cwd, input, env: { ...env, POLESTAR_ORIGIN_URL: origin } });
}

const tmp = () => tmpdir('polestar-new-');

const read = (dir, f) => fs.readFileSync(path.join(dir, f), 'utf8');

test('new --yes writes the template with the values filled in', () => {
	const dir = path.join(tmp(), 'ann');
	const r = polestar(['new', dir, ...ARGS, '--license', 'CC0-1.0'], { origin: '' });
	assert.equal(r.status, 0, r.stderr);
	assert.deepEqual(JSON.parse(read(dir, 'pack.json')), { id: 'ann-routes', title: "Ann's Routes", author: 'Ann', version: '0.1.0', license: 'CC0-1.0' });
	const guide = read(dir, 'guides/example.guide');
	assert.match(guide, /^guide ann-routes\/example$/m);
	assert.match(guide, /^next forever\/alliance\/02-westfall$/m);
	assert.ok(fs.existsSync(path.join(ROOT, 'guides', 'forever', 'alliance', '02-westfall.guide')));
	assert.match(read(dir, 'README.md'), /^# Ann's Routes$/m);
	assert.match(read(dir, 'README.md'), /PolestarPack_AnnsRoutes-<version>\.zip/);
	assert.match(read(dir, 'LICENSE'), /CC0-1\.0/);
	assert.match(read(dir, 'LICENSE'), /https:\/\/creativecommons\.org\/publicdomain\/zero\/1\.0\//);
	assert.deepEqual(read(dir, '.gitignore').split('\n').filter(Boolean), ['dist/', 'drafts/']);
	const tasks = JSON.parse(read(dir, '.vscode/tasks.json'));
	const lint = tasks.tasks.find((t) => t.group && t.group.isDefault);
	assert.match(lint.command, /lint/);
	assert.equal(lint.problemMatcher.pattern.regexp, '^(.*):(\\d+): (error|warning): (.*)$');
	const agents = read(dir, 'AGENTS.md');
	assert.match(agents, /`ann-routes\/`/);
	for (const s of ['polestar find', '--json', 'polestar lint --format json', 'polestar playtest']) assert.ok(agents.includes(s), s);
	assert.match(read(dir, 'CLAUDE.md'), /AGENTS\.md/);
	for (const f of ['pack.json', 'guides/example.guide', 'README.md', 'AGENTS.md']) assert.doesNotMatch(read(dir, f), /\{\{\w+\}\}/, f);
});

// Every file under dir, relative paths, sorted.
function filesUnder(dir, rel = '') {
	return fs
		.readdirSync(path.join(dir, rel), { withFileTypes: true })
		.flatMap((e) => (e.isDirectory() ? filesUnder(dir, path.join(rel, e.name)) : [path.join(rel, e.name)]))
		.sort();
}

test('new copies the polestar-guide-pack skill into .agents/skills and .claude/skills, and AGENTS.md points to it', () => {
	const dir = path.join(tmp(), 'ann');
	assert.equal(polestar(['new', dir, ...ARGS], { origin: '' }).status, 0);
	const skill = path.join(ROOT, 'skills', 'polestar-guide-pack');
	const files = filesUnder(skill);
	assert.ok(files.includes('SKILL.md') && files.includes(path.join('references', 'guide-format.md')), files.join(', '));
	for (const into of ['.agents/skills', '.claude/skills']) {
		const copy = path.join(dir, into, 'polestar-guide-pack');
		assert.deepEqual(filesUnder(copy), files, into);
		for (const f of files) assert.equal(read(copy, f), read(skill, f), `${into}/${f}`);
	}
	const agents = read(dir, 'AGENTS.md');
	for (const p of ['.agents/skills/polestar-guide-pack/SKILL.md', '.claude/skills/']) assert.ok(agents.includes(`\`${p}\``), p);
});

test("LICENSE: GPL-3.0-only names the pack and its author before the GPL's text, MIT has the author and year, others a reminder", () => {
	const gpl = path.join(tmp(), 'p');
	assert.equal(polestar(['new', gpl, ...ARGS, '--license', 'GPL-3.0-only'], { origin: '' }).status, 0);
	const text = read(gpl, 'LICENSE');
	const lines = text.split('\n');
	assert.equal(lines[0], "Ann's Routes");
	assert.equal(lines[1], `Copyright (c) ${new Date().getFullYear()} Ann`);
	assert.match(text, /under\nthe terms of the GNU General Public License as published by the Free Software\nFoundation, version 3\./);
	assert.doesNotMatch(text, /Polestar|THIRD_PARTY/);
	const ours = read(ROOT, 'LICENSE');
	const gplStart = ours.indexOf('                    GNU GENERAL PUBLIC LICENSE');
	assert.ok(gplStart > 0);
	assert.ok(text.endsWith(ours.slice(gplStart)), 'the licence text follows, as our LICENSE carries it');
	const mit = path.join(tmp(), 'p');
	assert.equal(polestar(['new', mit, ...ARGS, '--license', 'MIT'], { origin: '' }).status, 0);
	assert.match(read(mit, 'LICENSE'), new RegExp(`^Copyright \\(c\\) ${new Date().getFullYear()} Ann$`, 'm'));
	assert.match(read(mit, 'LICENSE'), /Permission is hereby granted/);
	const other = path.join(tmp(), 'p');
	assert.equal(polestar(['new', other, ...ARGS, '--license', 'Apache-2.0'], { origin: '' }).status, 0);
	assert.equal(read(other, 'LICENSE').trim().split('\n').length, 1);
	assert.match(read(other, 'LICENSE'), /Apache-2\.0.*full text/);
});

test('a non-empty folder is refused and left alone; a bad id is refused', () => {
	const dir = tmp();
	fs.writeFileSync(path.join(dir, 'notes.txt'), 'mine');
	const r = polestar(['new', dir, ...ARGS], { origin: '' });
	assert.equal(r.status, 1);
	assert.match(r.stderr, /not an empty folder/);
	assert.deepEqual(fs.readdirSync(dir), ['notes.txt']);
	const bad = path.join(tmp(), 'p');
	const b = polestar(['new', bad, '--yes', '--id', 'polestar'], { origin: '' });
	assert.equal(b.status, 1);
	assert.equal(fs.existsSync(bad), false);
});

test('with an origin URL the workflow and dev container install Polestar from it; without one they are skipped and why is printed', () => {
	const withRepo = path.join(tmp(), 'p');
	const a = polestar(['new', withRepo, ...ARGS], { origin: REPO });
	assert.equal(a.status, 0, a.stderr);
	const wf = read(withRepo, '.github/workflows/pack.yml');
	assert.ok(wf.includes(`git clone --depth 1 "${REPO}"`));
	for (const s of ['lua5.1', 'npm link', 'polestar lint --format github', 'polestar playtest', 'polestar pack', "tags: ['v*']", '${{ github.token }}']) assert.ok(wf.includes(s), s);
	// The check job runs Polestar's data build: it gets read access only; the
	// release job, on version tags after the check passed, writes.
	const [top, jobs] = wf.split(/^jobs:$/m);
	assert.match(top, /^permissions:\n {2}contents: read$/m);
	assert.doesNotMatch(top, /contents: write/);
	const [check, release] = jobs.split(/^ {2}release:$/m);
	assert.doesNotMatch(check, /contents: write|gh release/);
	assert.match(release, /^ {4}if: startsWith\(github\.ref, 'refs\/tags\/v'\)$/m);
	assert.match(release, /^ {4}needs: check$/m);
	assert.match(release, /^ {4}permissions:\n {6}contents: write$/m);
	assert.doesNotMatch(release, /polestar|npm|git clone/, 'the release job runs no third-party code');
	assert.match(release, /gh release create/);
	const dc = JSON.parse(read(withRepo, '.devcontainer/devcontainer.json'));
	assert.match(dc.image, /node:24/);
	assert.ok(dc.postCreateCommand.includes(REPO) && /lua5\.1/.test(dc.postCreateCommand) && /npm link/.test(dc.postCreateCommand));
	// Never fetch from community web sites (quest XP) or read a Wowhead cache from a runner or Codespace.
	for (const text of [wf, dc.postCreateCommand]) assert.deepEqual(text.match(/polestar data build[^\n"&]*/g).map((s) => s.trim()), ['polestar data build --no-web-xp --no-wowhead']);
	assert.doesNotMatch(a.stdout, /skipped/);

	const without = path.join(tmp(), 'p');
	const b = polestar(['new', without, ...ARGS], { origin: '' });
	assert.equal(b.status, 0, b.stderr);
	assert.equal(fs.existsSync(path.join(without, '.github')), false);
	assert.equal(fs.existsSync(path.join(without, '.devcontainer')), false);
	assert.match(b.stdout, /skipped .*pack\.yml.*\.devcontainer.*no origin remote/);
});

const skip = needs('quests.json') || (!hasLua() && 'no Lua 5.1');

test('end to end: the new pack lints clean, playtests and packs from its own folder', { skip }, () => {
	const dir = path.join(tmp(), 'ann');
	assert.equal(polestar(['new', dir, ...ARGS, '--license', 'CC-BY-4.0'], { origin: '' }).status, 0);
	const lint = polestar(['lint', '--format', 'json'], { cwd: dir });
	assert.equal(lint.status, 0, lint.stdout + lint.stderr);
	const doc = JSON.parse(lint.stdout);
	const diags = Array.isArray(doc) ? doc : doc.diagnostics;
	assert.deepEqual(diags, []);
	const play = polestar(['playtest'], { cwd: dir });
	assert.equal(play.status, 0, play.stdout + play.stderr);
	assert.match(play.stdout, /ok {2}ann-routes\/example/);
	const pack = polestar(['pack'], { cwd: dir });
	assert.equal(pack.status, 0, pack.stdout + pack.stderr);
	assert.ok(fs.existsSync(path.join(dir, 'dist', 'PolestarPack_AnnsRoutes-0.1.0.zip')));
});

test('the default author is git config user.name, read from where new runs', () => {
	// The stub is the global config of a fresh home, and new runs there (not
	// in this clone, whose own config could name someone else). GIT_CONFIG_GLOBAL
	// names the same file, for a git that honours it (2.32+); older ones read
	// $HOME/.gitconfig.
	const home = tmp();
	const cfg = path.join(home, '.gitconfig');
	fs.writeFileSync(cfg, '[user]\n\tname = Stub Author\n');
	const dir = path.join(tmp(), 'p');
	const r = polestar(['new', dir, '--yes', '--id', 'stub-pack', '--license', 'MIT'], {
		cwd: home,
		origin: '',
		env: { GIT_CONFIG_GLOBAL: cfg, GIT_CONFIG_NOSYSTEM: '1', HOME: home, XDG_CONFIG_HOME: path.join(home, '.config') },
	});
	assert.equal(r.status, 0, r.stderr);
	assert.equal(JSON.parse(read(dir, 'pack.json')).author, 'Stub Author');
	assert.match(read(dir, 'LICENSE'), /Stub Author/);
});

test('origin URLs: SSH and http become https; credentials, query and fragment are dropped; anything else is skipped with the reason', () => {
	for (const [origin, want] of [
		['git@github.com:example/polestar.git', 'https://github.com/example/polestar.git'],
		['ssh://git@github.com/example/polestar.git', 'https://github.com/example/polestar.git'],
		['https://someone:s3cret@github.com/example/polestar.git', 'https://github.com/example/polestar.git'],
		['http://github.com/example/polestar.git', 'https://github.com/example/polestar.git'],
		['http://git.example.com:3000/o/r.git', 'https://git.example.com:3000/o/r.git'],
		['ssh://git@git.example.com:2222/o/r.git', 'https://git.example.com/o/r.git'],
		['https://github.com/example/polestar.git?ref=x;rm%20-rf#frag', 'https://github.com/example/polestar.git'],
	]) {
		const dir = path.join(tmp(), 'p');
		assert.equal(polestar(['new', dir, ...ARGS], { origin }).status, 0);
		const wf = read(dir, '.github/workflows/pack.yml');
		assert.ok(wf.includes(`git clone --depth 1 "${want}" `), origin);
		const dc = JSON.parse(read(dir, '.devcontainer/devcontainer.json'));
		assert.ok(dc.postCreateCommand.includes(`git clone --depth 1 "${want}" `), origin);
		assert.doesNotMatch(wf + dc.postCreateCommand, /s3cret|git@|http:|\?|#frag/);
	}
	for (const origin of ['/srv/git/polestar.git', 'ftp://example.test/polestar.git', 'https://example.test/$(id)/polestar.git']) {
		const dir = path.join(tmp(), 'p');
		const r = polestar(['new', dir, ...ARGS], { origin });
		assert.equal(r.status, 0, r.stderr);
		assert.equal(fs.existsSync(path.join(dir, '.github')), false, origin);
		assert.equal(fs.existsSync(path.join(dir, '.devcontainer')), false, origin);
		assert.match(r.stdout, /skipped .*not an http\(s\) or SSH URL/);
	}
});

test('the example guide carries no author line: it takes the pack author, whatever characters the name has', () => {
	const dir = path.join(tmp(), 'p');
	assert.equal(polestar(['new', dir, '--yes', '--id', 'ann-routes', '--title', "Ann's Routes", '--author', 'Ann #1 -- the best', '--license', 'CC0-1.0'], { origin: '' }).status, 0);
	assert.doesNotMatch(read(dir, 'guides/example.guide'), /^author /m);
	assert.equal(JSON.parse(read(dir, 'pack.json')).author, 'Ann #1 -- the best');
});

test('without --yes and without a terminal, new exits 1 and says how to pass the values', () => {
	const dir = path.join(tmp(), 'p');
	const r = polestar(['new', dir, '--id', 'ann-routes'], { origin: '', input: '' });
	assert.equal(r.status, 1);
	assert.match(r.stderr, /--yes/);
	assert.equal(fs.existsSync(dir), false);
});

test('known licence ids are written in their canonical case', () => {
	for (const [given, want] of [['mit', 'MIT'], ['cc-by-4.0', 'CC-BY-4.0'], ['cc0-1.0', 'CC0-1.0'], ['gpl-3.0-only', 'GPL-3.0-only']]) {
		const dir = path.join(tmp(), 'p');
		assert.equal(polestar(['new', dir, ...ARGS, '--license', given], { origin: '' }).status, 0);
		assert.equal(JSON.parse(read(dir, 'pack.json')).license, want);
		if (want === 'MIT') assert.match(read(dir, 'LICENSE'), /^MIT License/);
	}
});
