'use strict';
// The public-text check (tools/public-text.js): commit messages through the
// commit-msg hook (tools/hooks/commit-msg) and a pull request's title,
// description, branch name and commits as the "Public text" job in
// .github/workflows/pr-base.yml runs it. The words come from the rules' own
// examples (tools/lib/public-text.json), so this file spells none, and every
// case checks the output names the rule and the place but never the words.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { loadRules, sha256 } = require('../tools/lib/public-text');

const ROOT = path.join(__dirname, '..');
const SCRIPT = path.join(ROOT, 'tools', 'public-text.js');
const HOOK = path.join(ROOT, 'tools', 'hooks', 'commit-msg');
const RULES = loadRules();
const rule = (scope) => RULES.rules.find((r) => r.scope === scope);
// A word only the message checks ban (a prose or message rule: messages are
// held to every rule, files to the tree rules), and a phrase a tree rule bans.
const MSG = RULES.rules.find((r) => r.scope !== 'tree');
const TREE = rule('tree');

let tmp;
function file(name, text) {
	tmp = tmp || fs.mkdtempSync(path.join(os.tmpdir(), 'public-text-'));
	const f = path.join(tmp, name);
	fs.writeFileSync(f, text);
	return f;
}
function run(args, env = {}, cmd = process.execPath, pre = [SCRIPT]) {
	const r = spawnSync(cmd, [...pre, ...args], { cwd: ROOT, encoding: 'utf8', env: { ...process.env, GITHUB_ACTIONS: '', GITHUB_STEP_SUMMARY: '', PR_TITLE: '', PR_BODY: '', PR_BRANCH: '', ...env } });
	return { status: r.status, out: r.stdout + r.stderr };
}
const silent = (out, ...words) => {
	for (const w of words) assert.ok(!out.toLowerCase().includes(w.toLowerCase()), 'the output never repeats the words');
};

test('a commit message breaking a rule is refused, naming the rule and line only', () => {
	const bad = file('bad-msg', `Westfall: turn in at Sentinel Hill\n\nThe farms come after.\n${MSG.match[0]}\n`);
	const r = run(['--commit-msg', bad]);
	assert.equal(r.status, 1);
	assert.match(r.out, new RegExp(`Commit message, line 4 column 1: public-text rule ${MSG.id}`));
	silent(r.out, MSG.match[0]);
	const tree = run(['--commit-msg', file('tree-msg', `Desolace: ${TREE.match[0]}\n`)]);
	assert.equal(tree.status, 1);
	assert.match(tree.out, new RegExp(`public-text rule ${TREE.id}`));
	silent(tree.out, TREE.match[0]);
	assert.equal(run(['--commit-msg', file('good-msg', 'Westfall: turn in at Sentinel Hill before the farms\n')]).status, 0);
});

test('git\'s comment lines and a `commit -v` diff are not the message', () => {
	const text = `Westfall: turn in at Sentinel Hill\n# ${MSG.match[0]}\n# ------------------------ >8 ------------------------\n+${MSG.match[0]}\n`;
	assert.equal(run(['--commit-msg', file('comments', text)]).status, 0);
});

test('a product name is caught as a whole token, by its hash', () => {
	const rules = file('rules.json', JSON.stringify({ hashed: [{ id: 'product-name', scope: 'tree', phrases: [[sha256('acmeguides')]] }], rules: [] }));
	const r = run(['--rules', rules, file('name-msg', 'Works like AcmeGuides does\n')]);
	assert.equal(r.status, 1);
	assert.match(r.out, /name-msg, line 1 column 12: public-text rule product-name/);
	silent(r.out, 'acmeguides');
	assert.equal(run(['--rules', rules, file('two-tokens', 'Works like Acme Guides does\n')]).status, 0);
	assert.deepEqual(JSON.parse(run(['--hash', 'Acme Guides']).out), [sha256('acme'), sha256('guides')]);
});

test('a pull request: its title, description, branch name and every commit message', () => {
	const commits = file('commits.jsonl', [
		JSON.stringify({ sha: 'a'.repeat(40), message: 'Westfall: turn in at Sentinel Hill' }),
		JSON.stringify({ sha: 'b'.repeat(40), message: `Desolace loop\n\n${MSG.match[0]}` }),
	].join('\n') + '\n');
	const summary = file('summary.md', '');
	const env = { PR_TITLE: 'Desolace: one loop', PR_BODY: `Closes #1\n\nWhy:\n${TREE.match[0]}`, PR_BRANCH: 'fix/desolace-loop', GITHUB_ACTIONS: 'true', GITHUB_STEP_SUMMARY: summary };
	const r = run(['--pr', '--commits', commits], env);
	assert.equal(r.status, 1);
	assert.match(r.out, new RegExp(`::error::Pull request description, line 4 column 1: public-text rule ${TREE.id}`));
	assert.match(r.out, new RegExp(`::error::Commit bbbbbbbbbbbb message, line 3 column 1: public-text rule ${MSG.id}`));
	assert.doesNotMatch(r.out, /aaaaaaaaaaaa|Pull request title,|Branch name,/);
	const written = fs.readFileSync(summary, 'utf8');
	assert.match(written, /^## Public text/);
	silent(r.out + written, MSG.match[0], TREE.match[0]);
	assert.match(run(['--pr'], { ...env, PR_BODY: '', PR_BRANCH: `x-${MSG.match[0].split(' ')[0]}` }).out, /Branch name, line 1 column 3/);
	assert.equal(run(['--pr', '--commits', file('ok.jsonl', `${JSON.stringify({ sha: 'c'.repeat(40), message: 'Fine' })}\n`)], { PR_TITLE: 'Desolace: one loop', PR_BODY: 'Closes #1' }).status, 0);
	assert.equal(run(['--pr', 'extra-file']).status, 2, 'files go without --pr');
});

test('the commit-msg hook runs the check from the clone, and the hooks are executable', () => {
	for (const h of ['commit-msg', 'pre-push']) assert.ok(fs.statSync(path.join(ROOT, 'tools', 'hooks', h)).mode & 0o111, `tools/hooks/${h} is executable`);
	const bad = run([file('hook-bad', `${MSG.match[0]}\n`)], {}, 'sh', [HOOK]);
	assert.equal(bad.status, 1);
	assert.match(bad.out, new RegExp(`public-text rule ${MSG.id}`));
	assert.equal(run([file('hook-good', 'Westfall: turn in at Sentinel Hill\n')], {}, 'sh', [HOOK]).status, 0);
});

// A push publishes its branch name and every commit the remote lacks: the pre-push hook checks them
// all, for commits made without the commit-msg hook. A temporary repository with a fake remote-tracking
// ref holds one published commit and two new ones.
test('the pre-push hook checks the branch name and each commit the remote does not have', () => {
	const repo = fs.mkdtempSync(path.join(os.tmpdir(), 'public-text-push-'));
	const git = (...args) => {
		const r = spawnSync('git', ['-c', 'user.name=Test', '-c', 'user.email=test@example.invalid', '-c', 'commit.gpgsign=false', '-c', 'core.hooksPath=/dev/null', ...args], { cwd: repo, encoding: 'utf8' });
		assert.equal(r.status, 0, r.stderr);
		return r.stdout.trim();
	};
	git('init', '-q');
	git('commit', '-q', '--allow-empty', '-m', `Published: ${MSG.match[0]}`);
	const published = git('rev-parse', 'HEAD');
	git('update-ref', 'refs/remotes/origin/work', published);
	git('commit', '-q', '--allow-empty', '-m', 'Westfall: turn in at Sentinel Hill');
	git('commit', '-q', '--allow-empty', '-m', `Desolace loop\n\n${TREE.match[0]}`);
	const head = git('rev-parse', 'HEAD');
	const push = (input) => {
		const r = spawnSync('sh', [path.join(ROOT, 'tools', 'hooks', 'pre-push'), 'origin', 'url'], { cwd: repo, input, encoding: 'utf8', env: { ...process.env, PATH: process.env.PATH } });
		return { status: r.status, out: r.stdout + r.stderr };
	};
	// The hook finds the script through the clone's top level: point it at this checkout's.
	fs.mkdirSync(path.join(repo, 'tools', 'lib'), { recursive: true });
	for (const f of ['tools/public-text.js', 'tools/lib/public-text.js', 'tools/lib/public-text.json']) fs.copyFileSync(path.join(ROOT, f), path.join(repo, f));
	const r = push(`refs/heads/work ${head} refs/heads/work ${published}\n`);
	assert.equal(r.status, 1);
	assert.match(r.out, new RegExp(`Commit ${head.slice(0, 12)} message, line 3 column 1: public-text rule ${TREE.id}`));
	assert.doesNotMatch(r.out, new RegExp(published.slice(0, 12)), 'a commit the remote has is not checked again');
	silent(r.out, MSG.match[0], TREE.match[0]);
	const fresh = push(`refs/heads/work ${head} refs/heads/fresh-branch ${'0'.repeat(40)}\n`);
	assert.doesNotMatch(fresh.out, new RegExp(published.slice(0, 12)), 'a new branch: only commits no remote-tracking ref has');
	assert.match(fresh.out, new RegExp(head.slice(0, 12)));
	const name = push(`refs/heads/work ${published} refs/heads/x-${MSG.match[0].split(' ')[0]} ${published}\n`);
	assert.match(name.out, /Branch name, line 1 column 3/);
	assert.equal(push(`(delete) ${'0'.repeat(40)} refs/heads/old ${published}\n`).status, 0, 'a deletion publishes nothing');
	assert.equal(push(`refs/heads/work ${head} refs/heads/work ${head}\n`).status, 0, 'nothing new');
	fs.rmSync(repo, { recursive: true, force: true });
});

// After a rebase onto the base branch or a merge of it, the range from the remote ref's old tip holds
// commits already public on origin (a contributor's message the rules flag): the hook doesn't check
// those again, and still refuses a new commit that breaks a rule.
test('the pre-push hook skips commits already on origin after a merge, and still checks new ones', () => {
	const repo = fs.mkdtempSync(path.join(os.tmpdir(), 'public-text-known-'));
	const git = (...args) => {
		const r = spawnSync('git', ['-c', 'user.name=Test', '-c', 'user.email=test@example.invalid', '-c', 'commit.gpgsign=false', '-c', 'core.hooksPath=/dev/null', ...args], { cwd: repo, encoding: 'utf8' });
		assert.equal(r.status, 0, r.stderr);
		return r.stdout.trim();
	};
	git('init', '-q', '-b', 'base');
	git('commit', '-q', '--allow-empty', '-m', 'Base');
	const base = git('rev-parse', 'HEAD');
	// The base branch on origin moved on with a contributor's commit whose message a rule flags.
	git('commit', '-q', '--allow-empty', '-m', `Contributor's work\n\n${TREE.match[0]}`);
	const theirs = git('rev-parse', 'HEAD');
	git('update-ref', 'refs/remotes/origin/base', theirs);
	// Our branch was pushed at its first commit, then merged the base branch and added a clean commit.
	git('checkout', '-q', '-b', 'work', base);
	git('commit', '-q', '--allow-empty', '-m', 'Westfall: turn in at Sentinel Hill');
	const pushed = git('rev-parse', 'HEAD');
	git('update-ref', 'refs/remotes/origin/work', pushed);
	git('merge', '-q', '--no-ff', '-m', 'Merge base', 'base');
	git('commit', '-q', '--allow-empty', '-m', 'Desolace: the loop ends at the camp');
	fs.mkdirSync(path.join(repo, 'tools', 'lib'), { recursive: true });
	for (const f of ['tools/public-text.js', 'tools/lib/public-text.js', 'tools/lib/public-text.json']) fs.copyFileSync(path.join(ROOT, f), path.join(repo, f));
	const push = (local) => {
		const r = spawnSync('sh', [path.join(ROOT, 'tools', 'hooks', 'pre-push'), 'origin', 'url'], { cwd: repo, input: `refs/heads/work ${local} refs/heads/work ${pushed}\n`, encoding: 'utf8' });
		return { status: r.status, out: r.stdout + r.stderr };
	};
	const clean = push(git('rev-parse', 'HEAD'));
	assert.equal(clean.status, 0, clean.out);
	assert.doesNotMatch(clean.out, new RegExp(theirs.slice(0, 12)), 'the commit already on origin is not checked again');
	// A new commit of ours that breaks a rule is still refused, and only it is named.
	git('commit', '-q', '--allow-empty', '-m', `Ours\n\n${MSG.match[0]}`);
	const ours = git('rev-parse', 'HEAD');
	const bad = push(ours);
	assert.equal(bad.status, 1);
	assert.match(bad.out, new RegExp(`Commit ${ours.slice(0, 12)} message, line 3`));
	assert.doesNotMatch(bad.out, new RegExp(theirs.slice(0, 12)));
	silent(bad.out, MSG.match[0], TREE.match[0]);
	fs.rmSync(repo, { recursive: true, force: true });
});

// The job checks out only these files from the base branch: each local file the
// script loads must be among them, and the text comes in through env, never
// expanded into the shell.
test('the Public text job checks out everything the check loads and keeps the text out of the shell', () => {
	const yml = fs.readFileSync(path.join(ROOT, '.github', 'workflows', 'pr-base.yml'), 'utf8');
	const job = yml.slice(yml.indexOf('\n  public-text:'));
	assert.ok(job.length > 20, 'pr-base.yml has the public-text job');
	const sparse = job.match(/sparse-checkout: \|\n((?: {12}\S.*\n)+)/)[1].trim().split(/\s+/);
	const needed = new Set();
	const visit = (rel) => {
		if (needed.has(rel)) return;
		needed.add(rel);
		if (!rel.endsWith('.js')) return;
		for (const m of fs.readFileSync(path.join(ROOT, rel), 'utf8').matchAll(/require\('(\.[^']+)'\)/g)) {
			visit(path.relative(ROOT, require.resolve(path.join(ROOT, path.dirname(rel), m[1]))).split(path.sep).join('/'));
		}
	};
	visit('tools/public-text.js');
	needed.add('tools/lib/public-text.json');
	assert.deepEqual(sparse.sort(), [...needed].sort());
	assert.match(job, /node tools\/public-text\.js --pr --commits/);
	for (const v of ['title', 'body', 'head.ref']) assert.match(job, new RegExp(`^ {6}PR_\\w+: \\$\\{\\{ github\\.event\\.pull_request\\.${v.replace('.', '\\.')} \\}\\}$`, 'm'));
	const runs = job.slice(job.indexOf('run: |'));
	assert.doesNotMatch(runs, /\$\{\{/, 'no expression inside run:');
});
