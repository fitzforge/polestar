'use strict';
// The Discord bug bot (tools/discord-bot): reading the addon's report back
// out of a #bugs post, filing posts as issues exactly once, carrying the
// thread's follow-ups (the reporter's and other players') and edits over,
// and telling the thread when the issue closes, reopens or ships.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { parseReport } = require('../tools/discord-bot/lib/report');
const I = require('../tools/discord-bot/lib/issue');
const { createSync } = require('../tools/discord-bot/lib/sync');
const { onIssue, onRelease } = require('../tools/discord-bot/lib/notify');
const { fakeDiscord, fakeGitHub, fakeMedia, quietLog, FORUM, BOT } = require('./helpers/discord-fakes');

const POST = fs.readFileSync(path.join(__dirname, 'fixtures', 'discord', 'elwynn-trainer.md'), 'utf8');

function setup({ since } = {}) {
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const media = fakeMedia();
	const sync = createSync({ discord, github, media, config: { forumId: FORUM, since, botId: BOT }, log: quietLog, sleep: async () => {} });
	return { discord, github, media, sync };
}

test('a posted report gives its version, locale, guide, step and position', () => {
	const r = parseReport(POST);
	assert.match(r.description, /^Told me to go to pally trainer/);
	const d = r.details;
	assert.equal(d.version, '0.2.3');
	assert.equal(d.stage, 'Beta');
	assert.equal(d.locale, 'enUS');
	assert.equal(d.guideId, 'forever/alliance/human/01-elwynn-forest');
	assert.deepEqual([d.step, d.stepCount, d.liveStep], [15, 68, 16]);
	assert.equal(d.stepTitle, 'Northshire Abbey');
	assert.equal(d.zone, 'Elwynn Forest, Goldshire');
	assert.equal(d.map, 1429);
	assert.deepEqual(d.errors, []);
	assert.deepEqual(I.labelsFor(r, ['Questing']), ['discord', 'triage', 'bug', 'v0.2.3', 'guide:01-elwynn-forest', 'locale:enUS', 'questing']);
});

test('a translated report parses by shape, not by its words', () => {
	const de = [
		'**Was ist schiefgelaufen:** Der Pfeil zeigt ins Wasser.',
		'```',
		'Polestar 0.2.4 Beta · Client 1.60.1 (70425) · deDE',
		'Zwerg Jäger · Stufe 9 (12%) · Allianz',
		'Leitfaden: Dun Morogh (forever/alliance/dwarf/01-dun-morogh) · Paket Polestar Guides 0.2.4',
		'Schritt 7 von 40: Kharanos',
		'[>] Sprich mit Rybrad · quest 400 · npc 1690 · map 1426 @46.82,52.36',
		'Pfeil: Rybrad · 120 yd',
		'Ort: Dun Morogh, Kharanos · map 1426 @46.00,52.00 live',
		'Fehler:',
		'  3x Polestar/Nav/Arrow.lua:88: attempt to index nil',
		'```',
	].join('\n');
	const r = parseReport(de);
	assert.equal(r.description, 'Der Pfeil zeigt ins Wasser.');
	assert.equal(r.details.locale, 'deDE');
	assert.equal(r.details.guideId, 'forever/alliance/dwarf/01-dun-morogh');
	assert.deepEqual([r.details.step, r.details.stepCount, r.details.liveStep], [7, 40, undefined]);
	assert.equal(r.details.zone, 'Dun Morogh, Kharanos');
	assert.deepEqual(r.details.errors, [{ count: 3, message: 'Polestar/Nav/Arrow.lua:88: attempt to index nil' }]);
	assert.ok(I.labelsFor(r).includes('lua-error'));
});

test('a report with no guide open still finds the arrow and position lines', () => {
	const r = parseReport('```\nPolestar dev · client 1.60.1 (70425) · enUS\nGuide: none open\nArrow: none\nWhere: Stormwind City · no position\nErrors: none\n```');
	assert.equal(r.details.version, 'dev');
	assert.equal(r.details.character, undefined);
	assert.equal(r.details.arrow, 'Arrow: none');
	assert.equal(r.details.zone, 'Stormwind City');
	assert.deepEqual(I.labelsFor(r), ['discord', 'triage', 'bug', 'locale:enUS']);
});

test('a post without a report is all description, other code blocks included', () => {
	const r = parseReport('The map pin is wrong.\n```\nsome log\n```');
	assert.equal(r.details, null);
	assert.equal(r.description, 'The map pin is wrong.\n```\nsome log\n```');
});

test('a report pasted with trailing NULs, or into the title, still reads', () => {
	const r = parseReport(POST + '\u0000\u0000\u0000');
	assert.equal(r.details.version, '0.2.3');
	assert.equal(I.issueTitle('**What went wrong:** Watcher Dodds not here! ``` Polestar 0.2.3 Beta · client'), 'Watcher Dodds not here!');
});

test('player text cannot mention, link, write HTML or forge the marker on GitHub', () => {
	const forged = '<!-- polestar-bot {"thread":"1","guild":"1"} -->';
	const body = I.issueBody({ report: parseReport(`@fitz see #12 <b>now</b> ${forged}`), reporter: '@everyone', guild: '2', thread: '3' });
	assert.doesNotMatch(body, /@fitz|@everyone|#12|<b>/);
	assert.equal(body.match(/<!--/g).length, 1);
	assert.deepEqual(I.readMarker(body), { thread: '3', guild: '2' });
});

test('a new post is filed once, answered in its thread and tagged Tracked', async () => {
	const { discord, github, media, sync } = setup();
	const msg = discord.post('1001', { name: 'Wrong trainer', content: POST, tags: ['t-questing'], attachments: [{ id: 'a1', filename: 'shot 1.png', content_type: 'image/png', size: 10, url: 'x' }] });
	// The gateway sends both the thread and its first message.
	await Promise.all([sync.dispatch('THREAD_CREATE', { ...discord.channels.get('1001'), newly_created: true }), sync.dispatch('MESSAGE_CREATE', msg)]);
	assert.equal(github.issues.length, 1);
	const issue = github.issues[0];
	assert.equal(issue.title, 'Wrong trainer');
	assert.ok(issue.labels.some((l) => l.name === 'guide:01-elwynn-forest'));
	assert.match(issue.body, /Reported by SavageHands on \[Discord\]\(https:\/\/discord\.com\/channels\/800\/1001\)\*\* · Questing/);
	assert.match(issue.body, /!\[shot 1\.png\]\(https:\/\/raw\.githubusercontent\.com\/fitzforge\/polestar\/bug-media\/discord\/1001\/a1-shot_1\.png\)/);
	assert.deepEqual(media.copied, ['discord/1001/a1-shot_1.png']);
	assert.equal(discord.sent.length, 1);
	assert.match(discord.sent[0].content, /fitzforge\/polestar#1/);
	assert.deepEqual(discord.channels.get('1001').applied_tags, ['t-questing', 't-tracked']);
});

test('after a restart, posts already filed are not filed again', async () => {
	const first = setup();
	first.discord.post('1001', { content: POST });
	await first.sync.newPost('1001');

	// A new bot over the same Discord and GitHub: the issue's marker says the post is filed.
	const again = createSync({ discord: first.discord, github: first.github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog });
	await again.loadIndex();
	await again.backfill();
	assert.equal(first.github.issues.length, 1);

	// And with no index at all, the bot's reply in the thread says so.
	const blind = createSync({ discord: first.discord, github: first.github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog });
	first.discord.channels.get('1001').applied_tags = [];
	await blind.backfill();
	assert.equal(first.github.issues.length, 1);
});

test('backfill leaves locked, tagged and older posts alone', async () => {
	const { discord, github, sync } = setup({ since: Date.parse('2026-10-01T00:00:00Z') });
	discord.post('2001', { meta: { locked: true, create_timestamp: '2026-10-10T00:00:00Z' } });
	discord.post('2002', { tags: ['t-fixed'], meta: { create_timestamp: '2026-10-10T00:00:00Z' } });
	discord.post('2003', { meta: { create_timestamp: '2026-09-01T00:00:00Z' } });
	discord.post('2004', { name: 'New one', meta: { create_timestamp: '2026-10-10T00:00:00Z' } });
	await sync.backfill();
	assert.deepEqual(github.issues.map((i) => i.title), ['New one']);
});

test("every player's follow-up becomes a comment, the reporter's marked as theirs; the bot's own messages and empty ones do not", async () => {
	const { discord, github, sync } = setup();
	discord.post('1001', { content: POST });
	await sync.newPost('1001');
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u2', content: 'Shows green until 85, not 100: https://www.wowhead.com/forever/spell=2392' }));
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u1', content: 'It happens at step 20 too', attachments: [{ id: 'a9', filename: 'b.jpg', content_type: 'image/jpeg', size: 5, url: 'y' }] }));
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u3', content: '' }));
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u4', content: 'I am a bot', bot: true }));
	const comments = github.commentsByIssue.get(1);
	assert.equal(comments.length, 2);
	assert.match(comments[0].body, /^\*\*someone\*\* commented on \[Discord\]/);
	assert.match(comments[0].body, /green until 85, not 100/);
	assert.match(comments[1].body, /^\*\*someone\*\* \(the reporter\) added on \[Discord\]/);
	assert.match(comments[1].body, /It happens at step 20 too/);
	assert.match(comments[1].body, /bug-media\/discord\/1001\/a9-b\.jpg/);
});

test('editing the first message rewrites the issue body, once per change', async () => {
	const { discord, github, sync } = setup();
	const msg = discord.post('1001', { content: 'Arrow points into a wall' });
	await sync.newPost('1001');
	await sync.dispatch('MESSAGE_UPDATE', msg);
	msg.content = 'Arrow points into a wall in Goldshire';
	await sync.edit(msg);
	assert.match(github.issues[0].body, /in Goldshire/);
	let writes = 0;
	const update = github.updateIssue;
	github.updateIssue = (...a) => (writes++, update(...a));
	await sync.edit(msg);
	assert.equal(writes, 0);
});

async function filed() {
	const s = setup();
	s.discord.post('1001', { content: POST, tags: ['t-questing'] });
	await s.sync.newPost('1001');
	return s;
}

test('closing as completed tells the reporter, tags Fixed and locks the thread', async () => {
	const { discord, github } = await filed();
	const issue = { ...github.issues[0], state_reason: 'completed' };
	await onIssue({ discord, github, event: { action: 'closed', issue }, forumId: FORUM, log: quietLog });
	const last = discord.sent.at(-1);
	assert.match(last.content, /^<@u1> This is fixed and will ship in the next Polestar update/);
	assert.deepEqual(last.users, ['u1']);
	const t = discord.channels.get('1001');
	assert.deepEqual(t.applied_tags, ['t-questing', 't-fixed']);
	assert.equal(t.thread_metadata.locked, true);
});

test("closing as not planned quotes the maintainer's last note, not a copied follow-up", async () => {
	const { discord, github, sync } = await filed();
	await github.comment(1, 'Trainers in Goldshire are only for level 10+, this is expected.');
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u1', content: 'any news?' }));
	await onIssue({ discord, github, event: { action: 'closed', issue: { ...github.issues[0], state_reason: 'not_planned' } }, log: quietLog });
	const last = discord.sent.at(-1).content;
	assert.match(last, /not to change this one\.\n> Trainers in Goldshire are only for level 10\+/);
	assert.doesNotMatch(last, /any news/);
	assert.deepEqual(discord.channels.get('1001').applied_tags, ['t-questing', 't-wontfix']);
});

test('a duplicate points at the issue it duplicates; reopening unlocks and tracks again', async () => {
	const { discord, github } = await filed();
	await github.comment(1, 'Duplicate of #7');
	await onIssue({ discord, github, event: { action: 'closed', issue: { ...github.issues[0], state_reason: 'duplicate' } }, log: quietLog });
	assert.match(discord.sent.at(-1).content, /tracking it in \[fitzforge\/polestar#7\]/);
	await onIssue({ discord, github, event: { action: 'reopened', issue: github.issues[0] }, log: quietLog });
	assert.match(discord.sent.at(-1).content, /^We've reopened this/);
	const t = discord.channels.get('1001');
	assert.deepEqual(t.applied_tags, ['t-questing', 't-tracked']);
	assert.equal(t.thread_metadata.locked, false);
});

test('a release tells the threads of fixes closed since the last release, once', async () => {
	const { discord, github, sync } = setup();
	for (const id of ['1', '2', '3', '4']) {
		discord.post(id, { content: 'bug ' + id });
		await sync.newPost(id);
	}
	const close = (n, reason, at) => Object.assign(github.issues[n - 1], { state: 'closed', state_reason: reason, closed_at: at });
	close(1, 'completed', '2026-10-10T00:00:00Z'); // before 0.2.3: already shipped
	close(2, 'completed', '2026-10-15T00:00:00Z');
	close(3, 'not_planned', '2026-10-15T00:00:00Z');
	close(4, 'completed', '2026-10-15T01:00:00Z');
	github.releasesList.push({ id: 1, tag_name: 'v0.2.3', published_at: '2026-10-14T16:50:15Z' });
	const release = { id: 2, tag_name: 'v0.2.5', name: 'Polestar 0.2.5', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.2.5', published_at: '2026-10-16T00:00:00Z' };
	github.releasesList.push(release);
	discord.channels.get('4').thread_metadata = { archived: true, locked: true };

	const before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release }, log: quietLog }), { told: 2, failed: 0 });
	const told = discord.sent.slice(before);
	assert.deepEqual(told.map((s) => s.channel), ['4', '2']);
	assert.match(told[0].content, /^<@u1> The fix is out in \*\*Polestar 0\.2\.5\*\*/);
	assert.ok(discord.edits.some((e) => e.id === '4' && e.archived === false));
	assert.ok(github.issues[1].labels.some((l) => l.name === 'released:v0.2.5'));

	assert.deepEqual(await onRelease({ discord, github, event: { release }, log: quietLog }), { told: 0, failed: 0 });
});

test('a pre-release (a test build) tells no thread, and the next full release still tells every fix since the last full one', async () => {
	const { discord, github, sync } = setup();
	for (const id of ['1', '2']) {
		discord.post(id, { content: 'bug ' + id });
		await sync.newPost(id);
	}
	const close = (n, at) => Object.assign(github.issues[n - 1], { state: 'closed', state_reason: 'completed', closed_at: at });
	close(1, '2026-10-15T00:00:00Z'); // before the test build
	close(2, '2026-10-16T12:00:00Z'); // after it
	github.releasesList.push({ id: 1, tag_name: 'v0.2.4', published_at: '2026-10-14T00:00:00Z' });
	const test = { id: 2, tag_name: 'v0.2.5-test.1', name: 'Polestar 0.2.5 test build', prerelease: true, published_at: '2026-10-16T00:00:00Z' };
	github.releasesList.push(test);

	const before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release: test }, log: quietLog }), { told: 0, failed: 0 });
	assert.equal(discord.sent.length, before);
	assert.ok(github.issues.every((i) => !i.labels.some((l) => String(l.name || l).startsWith('released:'))));

	const release = { id: 3, tag_name: 'v0.2.5', name: 'Polestar 0.2.5', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.2.5', published_at: '2026-10-20T00:00:00Z' };
	github.releasesList.push(release);
	assert.deepEqual(await onRelease({ discord, github, event: { release }, log: quietLog }), { told: 2, failed: 0 });
});

// Admin slash commands (lib/commands.js): /close with a reason and /reopen,
// run in a #bugs thread; the issue changes on GitHub and the Action then
// tells the thread as when it closes there.
const { createCommands } = require('../tools/discord-bot/lib/commands');

function command(name, opts = {}, { admin = true, channel = '1001' } = {}) {
	return {
		id: 'i1', token: 'tok', application_id: 'app', type: 2, channel_id: channel,
		member: { permissions: admin ? String(1n << 3n | 1n << 10n) : String(1n << 10n) },
		data: { name, options: Object.entries(opts).map(([k, value]) => ({ name: k, value })) },
	};
}

async function commanded() {
	const s = await filed();
	s.commands = createCommands({ discord: s.discord, github: s.github, issueFor: s.sync.issueFor, log: quietLog });
	// What the admin was told: the edited reply to the deferred interaction.
	s.told = () => s.discord.requests.filter((r) => r.method === 'PATCH').at(-1).body.content;
	return s;
}

test('only administrators can use /close and /reopen: they are registered for Administrators and checked on every use', async () => {
	const { discord, github, commands } = await commanded();
	await commands.register('app', '800');
	const reg = discord.requests[0];
	assert.equal(reg.path, '/applications/app/guilds/800/commands');
	assert.deepEqual(reg.body.map((c) => [c.name, c.default_member_permissions]), [['close', '8'], ['reopen', '8']]);

	await commands.handle(command('close', { reason: 'fixed' }, { admin: false }));
	const reply = discord.requests.at(-1);
	assert.equal(reply.body.type, 4);
	assert.equal(reply.body.data.flags, 64, 'seen only by the one who asked');
	assert.match(reply.body.data.content, /Only server administrators/);
	assert.equal(github.issues[0].state, 'open');
});

test("/close Can't reproduce closes the thread's issue with the admin's note; the thread hears it in those words, tagged and locked", async () => {
	const { discord, github, commands, told } = await commanded();
	await commands.handle(command('close', { reason: 'noreproduce', note: 'Tried on a fresh Human, the trainer was there.' }));
	const issue = github.issues[0];
	assert.deepEqual([issue.state, issue.state_reason], ['closed', 'not_planned']);
	assert.ok(issue.labels.some((l) => l.name === 'resolution:cannot-reproduce'));
	assert.match(told(), /^Closed \[fitzforge\/polestar#1\].* as \*\*Can\u2019t reproduce\*\*/);

	await onIssue({ discord, github, event: { action: 'closed', issue }, log: quietLog });
	assert.match(discord.sent.at(-1).content, /^<@u1> We couldn't reproduce this one\.\n> Tried on a fresh Human, the trainer was there\./);
	const t = discord.channels.get('1001');
	assert.deepEqual(t.applied_tags, ['t-questing', 't-wontfix']);
	assert.equal(t.thread_metadata.locked, true);
});

test('/close Duplicate needs the issue it duplicates and points the thread at it; /reopen clears the resolution, a new reason replaces it', async () => {
	const { discord, github, commands, told } = await commanded();
	await commands.handle(command('close', { reason: 'duplicate' }));
	assert.match(told(), /Give the issue it duplicates/);
	assert.equal(github.issues[0].state, 'open');

	await commands.handle(command('close', { reason: 'duplicate', duplicate_of: 7 }));
	assert.equal(github.issues[0].state_reason, 'duplicate');
	await onIssue({ discord, github, event: { action: 'closed', issue: github.issues[0] }, log: quietLog });
	assert.match(discord.sent.at(-1).content, /tracking it in \[fitzforge\/polestar#7\]/);

	await commands.handle(command('reopen'));
	assert.equal(github.issues[0].state, 'open');
	assert.ok(!github.issues[0].labels.some((l) => l.name.startsWith('resolution:')));
	await commands.handle(command('close', { reason: 'noaction' }));
	assert.deepEqual(github.issues[0].labels.filter((l) => l.name.startsWith('resolution:')).map((l) => l.name), ['resolution:no-action']);
	await onIssue({ discord, github, event: { action: 'closed', issue: github.issues[0] }, log: quietLog });
	assert.match(discord.sent.at(-1).content, /^<@u1> No change is needed here\./);
});

test('outside a filed #bugs thread /close asks for the issue number and changes nothing', async () => {
	const { github, commands, told, discord } = await commanded();
	discord.channels.set('42', { id: '42', parent_id: null });
	discord.messages.set('42', []);
	await commands.handle(command('close', { reason: 'fixed' }, { channel: '42' }));
	assert.match(told(), /isn\u2019t a filed bug report/);
	assert.equal(github.issues[0].state, 'open');
});
