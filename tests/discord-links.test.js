'use strict';
// Pull requests shown on the issues they address (tools/discord-bot/links.js):
// which references count as a claim, one comment per issue kept up to date,
// the overlap warning on competing pull requests, merges remembered after the
// pull request is gone, and the Discord reporter told once.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { addressed, update, touchedBy, ISSUE_MARK, OVERLAP_MARK } = require('../tools/discord-bot/lib/links');
const { onProgress } = require('../tools/discord-bot/lib/notify');
const { createSync } = require('../tools/discord-bot/lib/sync');
const { fakeDiscord, fakeGitHub, fakeMedia, quietLog, FORUM, BOT } = require('./helpers/discord-fakes');

const REPO = 'fitzforge/polestar';
const refs = (title, body = '', number = 999) => addressed({ number, title, body }, REPO);

test('a title reference or a closing keyword is a claim; a mention, a comment or code is not', () => {
	assert.deepEqual(refs('Buttons: the target button passes over corpses (#355)'), [355]);
	assert.deepEqual(refs('Codex', 'Closes #350, #382 and #368.\n\nfixed: #12; Resolves fitzforge/polestar#40'), [12, 40, 350, 368, 382]);
	assert.deepEqual(refs('x', 'Fixes https://github.com/fitzforge/polestar/issues/302 (XooVe).'), [302]);
	assert.deepEqual(refs('x', 'Same root cause as #279; refs #51, see #292 and other/repo#7. Fixes other/repo#8.'), []);
	assert.deepEqual(refs('x', '<!-- "closes #12" on next -->\n```\nfixes #13\n```\n`closes #14`'), []);
	assert.deepEqual(refs('Follow-up to #380', 'closes #380', 380), []);
});

test('an edit that drops a reference still touches the issue it dropped', () => {
	const event = { action: 'edited', pull_request: { number: 9, title: 'x', body: 'fixes #2' }, changes: { body: { from: 'fixes #1' } } };
	assert.deepEqual(touchedBy(event, REPO).sort(), [1, 2]);
});

function fakeRepo(issues) {
	const comments = new Map();
	let id = 1;
	const labels = new Map(issues.map((i) => [i.number, new Set(i.labels || [])]));
	const writes = [];
	return {
		repo: REPO,
		writes,
		labels,
		store: comments,
		async ensureLabels() {},
		async getIssue(n) {
			const i = issues.find((x) => x.number === n);
			if (!i) throw Object.assign(new Error('404'), { status: 404 });
			return { ...i, labels: [...labels.get(n)].map((name) => ({ name })) };
		},
		async comments(n) {
			return comments.get(n) || [];
		},
		async comment(n, body) {
			writes.push(['comment', n]);
			if (!comments.has(n)) comments.set(n, []);
			comments.get(n).push({ id: id++, body, user: { login: 'github-actions[bot]' } });
		},
		async editComment(cid, body) {
			writes.push(['edit', cid]);
			for (const list of comments.values()) for (const c of list) if (c.id === cid) c.body = body;
		},
		async addLabels(n, ls) {
			writes.push(['label', n, ...ls]);
			if (!labels.has(n)) labels.set(n, new Set());
			for (const l of ls) labels.get(n).add(l);
		},
		async removeLabel(n, name) {
			writes.push(['unlabel', n, name]);
			labels.get(n).delete(name);
		},
	};
}

const pr = (number, user, base, body, labels = []) => ({ number, title: `PR ${number}`, body, draft: false, user: { login: user }, base: { ref: base }, labels: labels.map((name) => ({ name })) });
const issueBody = (gh, n, mark) => (gh.store.get(n) || []).filter((c) => c.body.includes(mark)).map((c) => c.body);

test('two pull requests on one issue: one comment listing both, and each is warned about the other', async () => {
	const gh = fakeRepo([{ number: 302, state: 'open' }, { number: 316, state: 'open', pull_request: {} }, { number: 321, state: 'open', pull_request: {} }]);
	const pulls = [pr(316, 'b7216309-jpg', 'next', 'Fixes #302'), pr(321, 'CDVolvik', 'next', 'Fixes #302 (XooVe).')];
	await update({ github: gh, pulls, touched: [302], defaultBranch: 'next' });
	const [body] = issueBody(gh, 302, ISSUE_MARK);
	assert.match(body, /- #316 by @b7216309-jpg, into `next`\n- #321 by @CDVolvik/);
	assert.match(body, /2 pull requests are open/);
	assert.deepEqual([...gh.labels.get(302)], ['has-pr']);
	assert.match(issueBody(gh, 316, OVERLAP_MARK)[0], /#302: also #321 by @CDVolvik/);
	assert.match(issueBody(gh, 321, OVERLAP_MARK)[0], /#302: also #316 by @b7216309-jpg/);
	assert.ok(gh.labels.get(316).has('overlap') && gh.labels.get(321).has('overlap'));

	// The same state again writes nothing.
	gh.writes.length = 0;
	pulls[0].labels = [{ name: 'overlap' }];
	pulls[1].labels = [{ name: 'overlap' }];
	await update({ github: gh, pulls, touched: [302], defaultBranch: 'next' });
	assert.deepEqual(gh.writes, []);
});

test('a merge into next stays on the issue after the pull request is gone, and the overlap clears', async () => {
	const gh = fakeRepo([{ number: 302, state: 'open' }, { number: 316, state: 'open', pull_request: {} }, { number: 321, state: 'open', pull_request: {} }]);
	const both = [pr(316, 'b7216309-jpg', 'next', 'Fixes #302'), pr(321, 'CDVolvik', 'next', 'Fixes #302')];
	await update({ github: gh, pulls: both, touched: [302], defaultBranch: 'next' });

	const left = [pr(316, 'b7216309-jpg', 'next', 'Fixes #302', ['overlap'])];
	await update({ github: gh, pulls: left, touched: [302], closed: { number: 321, merged: true, base: 'next', user: 'CDVolvik' }, defaultBranch: 'next' });
	const bodies = issueBody(gh, 302, ISSUE_MARK);
	assert.equal(bodies.length, 1, 'the comment is edited, not repeated');
	assert.match(bodies[0], /- #316 by @b7216309-jpg, into `next`\n- #321 by @CDVolvik, merged into `next`; it ships in the next release/);
	assert.match(issueBody(gh, 316, OVERLAP_MARK)[0], /No other open pull request addresses the same issue now/);
	assert.ok(!gh.labels.get(316).has('overlap'));

	// The other is closed unmerged: the merge is still listed, and the label says so.
	await update({ github: gh, pulls: [], touched: [302], closed: { number: 316, merged: false, base: 'next', user: 'b7216309-jpg' }, defaultBranch: 'next' });
	const last = issueBody(gh, 302, ISSUE_MARK)[0];
	assert.doesNotMatch(last, /#316/);
	assert.match(last, /#321 by @CDVolvik, merged/);
	assert.deepEqual([...gh.labels.get(302)], ['fix-merged']);
});

test('a pull request that stops addressing an issue leaves it saying no pull request is open', async () => {
	const gh = fakeRepo([{ number: 1, state: 'open' }, { number: 9, state: 'open', pull_request: {} }]);
	await update({ github: gh, pulls: [pr(9, 'a', 'next', 'closes #1')], touched: [1], defaultBranch: 'next' });
	await update({ github: gh, pulls: [pr(9, 'a', 'next', 'closes #2')], touched: [1], defaultBranch: 'next' });
	assert.match(issueBody(gh, 1, ISSUE_MARK)[0], /No pull request is open for this issue now/);
	assert.deepEqual([...gh.labels.get(1)], []);
});

test("a stranger's comment carrying the marks is not the workflow's: no forged merges, mentions or told flag", async () => {
	const gh = fakeRepo([{ number: 5, state: 'open', labels: ['discord'] }, { number: 9, state: 'open', pull_request: {} }]);
	const forged = `${ISSUE_MARK}\n<!-- told -->\n<!-- merged:77:next:victim -->`;
	gh.store.set(5, [{ id: 900, body: forged, user: { login: 'stranger' } }]);
	gh.store.set(9, [{ id: 901, body: `${OVERLAP_MARK} x`, user: { login: 'stranger' } }]);
	const told = [];
	await update({ github: gh, pulls: [pr(9, 'a', 'next', 'fixes #5')], touched: [5], defaultBranch: 'next', tell: async (i) => (told.push(i.number), true) });
	assert.deepEqual(told, [5], 'the reporter is still told');
	assert.equal(gh.store.get(5)[0].body, forged, "the stranger's comment is not edited");
	const [ours] = gh.store.get(5).filter((c) => c.user.login === 'github-actions[bot]').map((c) => c.body);
	assert.doesNotMatch(ours, /victim|#77/);
	assert.ok(!gh.writes.some((w) => w[0] === 'edit'));
	assert.ok(!gh.labels.get(5).has('fix-merged'));
});

test('a Discord report is told once, and again only if telling failed', async () => {
	const gh = fakeRepo([{ number: 5, state: 'open', labels: ['discord'] }, { number: 6, state: 'open' }]);
	const told = [];
	let ok = false;
	const tell = async (issue, prs) => (told.push([issue.number, prs.map((p) => p.number)]), ok);
	const pulls = [pr(10, 'a', 'next', 'closes #5, #6')];
	await update({ github: gh, pulls, touched: [5, 6], defaultBranch: 'next', tell });
	ok = true;
	await update({ github: gh, pulls, touched: [5, 6], defaultBranch: 'next', tell });
	await update({ github: gh, pulls: [...pulls, pr(11, 'b', 'next', 'fixes #5')], touched: [5], defaultBranch: 'next', tell });
	assert.deepEqual(told, [[5, [10]], [5, [10]]], 'not for the issue from GitHub, and not a third time');
});

test('the reporter hears a fix is open in their thread, which is tagged In progress', async () => {
	const discord = fakeDiscord();
	discord.channels.get(FORUM).available_tags.push({ id: 't-progress', name: 'In progress' });
	const github = fakeGitHub();
	const sync = createSync({ discord, github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog, sleep: async () => {} });
	discord.post('1001', { content: fs.readFileSync(path.join(__dirname, 'fixtures', 'discord', 'elwynn-trainer.md'), 'utf8'), tags: ['t-questing'] });
	await sync.newPost('1001');
	const told = await onProgress({ discord, github, issue: github.issues[0], prs: [{ number: 321 }], forumId: FORUM, log: quietLog });
	assert.equal(told, true);
	const last = discord.sent.at(-1);
	assert.match(last.content, /^<@u1> A fix for this is open \(\[#321\]\(<https:\/\/github\.com\/fitzforge\/polestar\/pull\/321>\)\)\. It still has to be reviewed/);
	assert.deepEqual(last.users, ['u1']);
	assert.deepEqual(discord.channels.get('1001').applied_tags, ['t-questing', 't-progress']);
});

test('needs-info asks the reporter the maintainer\'s question in their thread, without the bot\'s own comments', async () => {
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const sync = createSync({ discord, github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog, sleep: async () => {} });
	discord.post('1001', { content: fs.readFileSync(path.join(__dirname, 'fixtures', 'discord', 'elwynn-trainer.md'), 'utf8'), tags: ['t-questing'] });
	await sync.newPost('1001');
	await github.comment(1, 'Which class were you playing, and could you type `/polestar where` at the trainer?');
	await github.comment(1, `${ISSUE_MARK}\n**Pull requests for this issue**\n\n- #9 by @a, into \`next\``);
	const sent = discord.sent.length;
	const { onIssue } = require('../tools/discord-bot/lib/notify');
	assert.equal(await onIssue({ discord, github, event: { action: 'labeled', label: { name: 'triage' }, issue: github.issues[0] }, forumId: FORUM, log: quietLog }), false);
	assert.equal(await onIssue({ discord, github, event: { action: 'labeled', label: { name: 'needs-info' }, issue: github.issues[0] }, forumId: FORUM, log: quietLog }), true);
	assert.equal(discord.sent.length, sent + 1);
	assert.match(discord.sent.at(-1).content, /^<@u1> We need a little more to go on with this one:\n> Which class were you playing/);
	assert.deepEqual(discord.channels.get('1001').applied_tags, ['t-questing', 't-tracked'], 'the status tag stays');
});
