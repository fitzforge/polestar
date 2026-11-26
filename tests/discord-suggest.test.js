'use strict';
// `!suggest` inside a post of the suggestions forum (tools/discord-bot): the
// whole post, its first message and every reply, filed as one issue; the
// post then followed like a #bugs post (replies copied, closes, progress and
// releases told in an idea's words).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { createChat, NAUGHTY } = require('../tools/discord-bot/lib/chat');
const { createSync } = require('../tools/discord-bot/lib/sync');
const { botConfig } = require('../tools/discord-bot/lib/config');
const { onIssue, onComment, onRelease, onProgress } = require('../tools/discord-bot/lib/notify');
const { fakeDiscord, fakeGitHub, fakeMedia, quietLog, FORUM, SUGGESTIONS, BOT } = require('./helpers/discord-fakes');

const HOUR = 60 * 60 * 1000;
const SHOT = (id) => [{ id, filename: `${id}.png`, content_type: 'image/png', size: 5, url: 'x' }];

// The bot and its chat over one Discord and GitHub, on a clock that never
// holds a user back (`limited`: one that stands still).
function setup({ suggestions = SUGGESTIONS, limited = false } = {}) {
	let t = 0;
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const media = fakeMedia();
	const config = { forumId: FORUM, suggestionsForumId: suggestions, botId: BOT, maintainerIds: ['fitz'] };
	const clock = limited ? () => 0 : () => (t += HOUR);
	const make = () => createSync({ discord, github, media, config, log: quietLog, sleep: async () => {}, now: clock });
	const sync = make();
	const chat = createChat({ discord, forumId: FORUM, suggestionsForumId: suggestions, maintainerIds: ['fitz'], file: sync.fileChat, fileIdea: sync.fileIdea, repo: github.repo, log: quietLog });
	// A command in a thread, as the gateway sends it (to the chat and the sync both, as bot.js does).
	async function command(thread, text, { author = 'fitz', reply = null } = {}) {
		const m = discord.say(thread, { author, content: text, type: reply ? 19 : 0 });
		if (reply) m.message_reference = { message_id: reply, channel_id: thread, type: 0 };
		await Promise.all([chat.dispatch('MESSAGE_CREATE', m), sync.dispatch('MESSAGE_CREATE', m)]);
		return m;
	}
	// A suggestions post with a conversation in it.
	function conversation(id = '2001') {
		discord.post(id, { forum: SUGGESTIONS, owner: 'op', name: 'Mini map toggle', content: 'Please add a toggle for the mini map. It covers the quest tracker.', tags: ['s-ui'], attachments: SHOT('a1'), author: { username: 'op', global_name: 'Opal' } });
		discord.say(id, { author: 'u2', name: 'Bea', content: 'Agreed, I hide it with a macro for now.', attachments: SHOT('b1') });
		discord.say(id, { author: 'op', name: 'op', content: 'A key bind would do.', attachments: SHOT('a2') });
		discord.say(id, { author: 'u3', name: 'Cal', content: 'Related: https://example.org/map' });
		discord.say(id, { author: 'bot2', bot: true, content: 'beep' });
		discord.say(id, { author: 'u4', content: '' });
		return id;
	}
	return { discord, github, media, sync, chat, command, conversation, config, make, clock };
}

const commentsOf = (github, n = 1) => github.commentsByIssue.get(n) || [];

test('SUGGESTIONS_FORUM_ID is an optional channel id', () => {
	const env = { DISCORD_TOKEN: 't', DISCORD_FORUM_ID: '1', GITHUB_TOKEN: 'g' };
	assert.equal(botConfig(env).suggestionsForumId, null);
	assert.equal(botConfig({ ...env, SUGGESTIONS_FORUM_ID: ' 1574054527907143792 ' }).suggestionsForumId, '1574054527907143792');
	assert.throws(() => botConfig({ ...env, SUGGESTIONS_FORUM_ID: 'suggestions' }), /SUGGESTIONS_FORUM_ID is not a channel id/);
});

test('!suggest in a suggestions post files the whole post: its title, the first message as the body, every reply as a comment in order, no #bugs post', async () => {
	const { discord, github, media, command, conversation } = setup();
	const id = conversation();
	const cmd = await command(id, '!suggest');

	assert.equal(github.issues.length, 1);
	const issue = github.issues[0];
	assert.equal(issue.title, 'Mini map toggle');
	assert.match(issue.body, /^\*\*Suggested by Opal on \[Discord\]\(https:\/\/discord\.com\/channels\/800\/2001\)\*\* · UI\n\n> Please add a toggle for the mini map\. It covers the quest tracker\./);
	assert.match(issue.body, /!\[a1\.png\]\(https:\/\/raw\.githubusercontent\.com\/[^)]*\/discord\/2001\/a1-a1\.png\)/, 'the poster\'s files are copied');
	assert.match(issue.body, /"thread":"2001"/);

	const comments = commentsOf(github);
	assert.equal(comments.length, 3, 'the bot\'s message, the empty one and the command are not comments');
	assert.match(comments[0].body, /^\*\*Bea\*\* commented on \[Discord\]\(https:\/\/discord\.com\/channels\/800\/2001\/\d+\):/);
	assert.match(comments[0].body, /I hide it with a macro/);
	assert.match(comments[0].body, /!\[b1\.png\]\(https:\/\/raw\.githubusercontent\.com\/[^)]*\/discord\/2001\/b1-b1\.png\)/, 'other players\' images are copied too');
	assert.ok(!comments[0].body.includes('(on Discord)'));
	assert.match(comments[1].body, /^\*\*op\*\* \(the reporter\) added on/);
	assert.match(comments[1].body, /A key bind would do/);
	assert.match(comments[1].body, /bug-media\/discord\/2001\/a2-a2\.png/);
	assert.match(comments[2].body, /^\*\*Cal\*\* commented on/);
	assert.deepEqual(media.copied, ['discord/2001/a1-a1.png', 'discord/2001/b1-b1.png', 'discord/2001/a2-a2.png']);

	assert.equal(discord.posts.length, 0, 'no extra #bugs post');
	const tracked = discord.sent.filter((s) => s.channel === id);
	assert.equal(tracked.length, 1);
	assert.match(tracked[0].content, /^Tracked as \[fitzforge\/polestar#1\]\(<https:\/\/github\.com\/fitzforge\/polestar\/issues\/1>\)\. Replies in this thread, from anyone, are copied to the issue\./);
	assert.deepEqual(discord.channels.get(id).applied_tags, ['s-ui', 's-tracked'], 'the forum\'s Tracked tag, its own tags kept');
	assert.ok(discord.edits.some((e) => e.deleted && e.message === cmd.id), 'the command is deleted');
});

test('the issue\'s labels are discord, triage, enhancement and idea, then the post\'s forum tags as a #bugs post\'s', async () => {
	const { github, command, conversation } = setup();
	await command(conversation(), '!suggest');
	assert.deepEqual(github.issues[0].labels.map((l) => l.name), ['discord', 'triage', 'enhancement', 'idea', 'ui']);
	assert.ok(github.labels.has('ui'));
});

test('the text after !suggest is the issue\'s title; the post\'s title is the default', async () => {
	const { github, command, conversation } = setup();
	const id = conversation();
	await command(id, '!suggest A key bind for the mini map\nand more');
	assert.equal(github.issues[0].title, 'A key bind for the mini map');
});

test('a post by someone who is the maintainer is filed all the same, a reply to any message in it too', async () => {
	const { github, command, conversation, discord } = setup();
	const id = conversation();
	const reply = discord.messages.get(id)[1];
	await command(id, '!suggest', { reply: reply.id });
	assert.equal(github.issues.length, 1);
	assert.equal(commentsOf(github).length, 3);
	assert.equal(discord.posts.length, 0);
});

test('a second !suggest in the same post says it is filed already, files nothing, also after a restart', async () => {
	const { discord, github, command, conversation, make } = setup();
	const id = conversation();
	await command(id, '!suggest');
	const before = discord.sent.length;
	await command(id, '!suggest Another title');
	assert.equal(discord.sent[before].content, 'Already filed as [fitzforge/polestar#1](<https://github.com/fitzforge/polestar/issues/1>).');
	assert.deepEqual(discord.sent[before].users, []);
	assert.equal(github.issues.length, 1);
	assert.equal(commentsOf(github).length, 3, 'nothing is copied twice');

	// A new bot over the same Discord and GitHub: the issue's marker says so.
	const again = make();
	await again.loadIndex();
	assert.deepEqual(await again.fileIdea(id), { number: 1, thread: id, existing: true });
	assert.equal(github.issues.length, 1);
});

test('only the maintainer files a post: anyone else is told off and nothing is filed', async () => {
	const { discord, github, command, conversation } = setup();
	const id = conversation();
	await command(id, '!suggest', { author: 'u2' });
	assert.equal(discord.sent.at(-1).content, NAUGHTY);
	assert.equal(github.issues.length, 0);
	assert.equal(github.commentsByIssue.size, 0);
});

test('!suggest is for a suggestions post only: in a #bugs post it needs a reply, without a suggestions forum set up it does too', async () => {
	const bugs = setup();
	bugs.discord.post('3001', { owner: 'u5', content: 'a bug' });
	await bugs.command('3001', '!suggest');
	assert.match(bugs.discord.sent.at(-1).content, /^Reply to the message you want filed with `!suggest`/);
	assert.equal(bugs.github.issues.length, 0);

	const none = setup({ suggestions: null });
	const id = none.conversation();
	await none.command(id, '!suggest');
	assert.match(none.discord.sent.at(-1).content, /^Reply to the message you want filed with `!suggest`/);
	assert.equal(none.github.issues.length, 0);
});

test('a bot\'s post cannot be filed', async () => {
	const { discord, github, command } = setup();
	discord.post('2002', { forum: SUGGESTIONS, owner: BOT, name: 'Bot post', content: 'hi', author: { id: BOT, bot: true } });
	await command('2002', '!suggest');
	assert.match(discord.sent.at(-1).content, /bot.s post/);
	assert.equal(github.issues.length, 0);
});

test('replies after the filing are copied to the issue, the poster\'s marked as the reporter; a post nobody filed is left alone', async () => {
	const { discord, github, sync, command, conversation } = setup();
	const id = conversation();
	await command(id, '!suggest');
	await sync.dispatch('MESSAGE_CREATE', discord.say(id, { author: 'u2', name: 'Bea', content: 'One more thing' }));
	await sync.dispatch('MESSAGE_CREATE', discord.say(id, { author: 'op', name: 'op', content: 'Thanks all' }));
	await sync.dispatch('MESSAGE_CREATE', discord.say(id, { author: 'fitz', content: '!suggest again' }));
	const comments = commentsOf(github);
	assert.equal(comments.length, 5);
	assert.match(comments[3].body, /^\*\*Bea\*\* commented on/);
	assert.match(comments[4].body, /^\*\*op\*\* \(the reporter\) added on/);

	discord.post('2003', { forum: SUGGESTIONS, owner: 'op', content: 'Not filed' });
	await sync.dispatch('THREAD_CREATE', { ...discord.channels.get('2003'), newly_created: true });
	await sync.dispatch('MESSAGE_CREATE', discord.say('2003', { author: 'u2', content: 'a reply' }));
	assert.equal(github.issues.length, 1, 'a suggestions post is never filed by itself');
	assert.equal(commentsOf(github, 2).length, 0);
});

test('every author\'s images and videos in a suggestions post are copied, in the filing and in later replies; other files stay links, as in #bugs', async () => {
	const { discord, github, media, sync, command, conversation } = setup();
	const id = conversation();
	await command(id, '!suggest');
	const before = media.copied.length;
	const clip = [{ id: 'v1', filename: 'demo.mp4', content_type: 'video/mp4', size: 5, url: 'x' }];
	const doc = [{ id: 'd1', filename: 'notes.txt', content_type: 'text/plain', size: 5, url: 'x' }];
	await sync.dispatch('MESSAGE_CREATE', discord.say(id, { author: 'u2', name: 'Bea', content: 'a clip', attachments: [...SHOT('c1'), ...clip, ...doc] }));
	const body = commentsOf(github).at(-1).body;
	assert.match(body, /!\[c1\.png\]\([^)]*discord\/2001\/c1-c1\.png\)/);
	assert.match(body, /- \[demo\.mp4\]\([^)]*discord\/2001\/v1-demo\.mp4\) \(video\)/);
	assert.match(body, /- \[notes\.txt\]\([^)]*\) \(on Discord: not an image or video, not copied\)/);
	assert.deepEqual(media.copied.slice(before), ['discord/2001/c1-c1.png', 'discord/2001/v1-demo.mp4']);

	// A #bugs post: the same rule.
	discord.post('3001', { owner: 'u5', content: 'a bug' });
	await sync.newPost('3001');
	await sync.dispatch('MESSAGE_CREATE', discord.say('3001', { author: 'u2', content: 'me too', attachments: SHOT('e1') }));
	assert.deepEqual(media.copied.slice(before + 2), ['discord/3001/e1-e1.png']);
	assert.match(commentsOf(github, 2)[0].body, /!\[e1\.png\]\([^)]*discord\/3001\/e1-e1\.png\)/);
});

test('an edited reply and an edited first message are written again on the issue', async () => {
	const { discord, github, sync, command, conversation } = setup();
	const id = conversation();
	await command(id, '!suggest');
	const reply = discord.messages.get(id)[1];
	reply.content = 'Agreed, but a key bind is better.';
	await sync.dispatch('MESSAGE_UPDATE', { ...reply, edited_timestamp: '2026-11-20T00:00:00Z' });
	assert.match(commentsOf(github)[0].body, /a key bind is better/);

	discord.messages.get(id)[0].content = 'A toggle for the mini map, please.';
	await sync.dispatch('MESSAGE_UPDATE', { ...discord.messages.get(id)[0], channel_id: id, edited_timestamp: '2026-11-20T00:01:00Z' });
	assert.match(github.issues[0].body, /^\*\*Suggested by Opal/);
	assert.match(github.issues[0].body, /> A toggle for the mini map, please\./);
	assert.equal(github.issues[0].title, 'Mini map toggle');
});

test('follow-ups have the same hourly limits as a #bugs post\'s, and what the post said while the bot was away is caught up on the next connection', async () => {
	const { discord, github, sync, command, conversation, make } = setup({ limited: true });
	const id = conversation();
	await command(id, '!suggest');
	const base = commentsOf(github).length;
	for (let i = 0; i < 25; i++) await sync.dispatch('MESSAGE_CREATE', discord.say(id, { author: 'u2', name: 'Bea', content: `reply ${i}` }));
	assert.equal(commentsOf(github).length - base, 20, 'u2 gets 20 an hour; filing the post did not count against it');

	// Away: a new bot over the same Discord and GitHub reads the issue back and catches up.
	const away = make();
	await away.loadIndex();
	discord.say(id, { author: 'u3', name: 'Cal', content: 'said while away' });
	await away.backfill();
	assert.ok(commentsOf(github).some((c) => c.body.includes('said while away')));
	const count = commentsOf(github).length;
	await away.backfill();
	assert.equal(commentsOf(github).length, count, 'once');
});

test('the whole post is filed whatever its age and however much its author said: no hourly limit holds it back', async () => {
	const { discord, github, command } = setup({ limited: true });
	discord.post('2010', { forum: SUGGESTIONS, owner: 'op', name: 'Long talk', content: 'An idea' });
	for (let i = 0; i < 30; i++) discord.say('2010', { author: 'op', name: 'op', content: `thought ${i}` });
	await command('2010', '!suggest');
	assert.equal(commentsOf(github).length, 30);
	assert.match(commentsOf(github)[0].body, /thought 0/);
	assert.match(commentsOf(github)[29].body, /thought 29/);
});

// A filed suggestions post and its issue, for the notices.
async function filed() {
	const s = setup();
	const id = s.conversation();
	await s.command(id, '!suggest');
	return { ...s, id };
}
const told = (discord, id) => discord.sent.filter((m) => m.channel === id).at(-1);
const notify = (s) => ({ discord: s.discord, github: s.github, forumId: FORUM, suggestionsForumId: SUGGESTIONS, log: quietLog });

test('closed as completed: "This idea is planned", pinging the poster, tagged Fixed, locked', async () => {
	const s = await filed();
	const issue = { ...s.github.issues[0], state: 'closed', state_reason: 'completed' };
	await onIssue({ ...notify(s), event: { action: 'closed', issue } });
	const last = told(s.discord, s.id);
	assert.match(last.content, /^<@op> This idea is planned and will ship in the next Polestar update\. Thanks for the idea! \(\[fitzforge\/polestar#1\]/);
	assert.deepEqual(last.users, ['op']);
	assert.deepEqual(s.discord.channels.get(s.id).applied_tags, ['s-ui', 's-fixed']);
	assert.equal(s.discord.channels.get(s.id).thread_metadata.locked, true);
});

test('closed as not planned: "Not planned for now" with the maintainer\'s note', async () => {
	const s = await filed();
	await s.github.comment(1, 'It clashes with the tracker layout; we may revisit it later.');
	const issue = { ...s.github.issues[0], state: 'closed', state_reason: 'not_planned' };
	await onIssue({ ...notify(s), event: { action: 'closed', issue } });
	const last = told(s.discord, s.id);
	assert.match(last.content, /^<@op> Not planned for now\.\n> It clashes with the tracker layout; we may revisit it later\.\nThanks for the idea! \(/);
	assert.ok(!/report|bug/i.test(last.content));
	assert.deepEqual(s.discord.channels.get(s.id).applied_tags, ['s-ui', 's-wontfix']);
});

test('a first pull request, a question and a reopening are told as an idea\'s', async () => {
	const s = await filed();
	assert.equal(await onProgress({ ...notify(s), issue: s.github.issues[0], prs: [{ number: 12 }] }), true);
	assert.match(told(s.discord, s.id).content, /^<@op> This idea is in progress: a change for it is open \(\[#12\]\(<https:\/\/github\.com\/fitzforge\/polestar\/pull\/12>\)\)\. It still has to be reviewed; we'll tell you here when it ships\./);
	assert.deepEqual(s.discord.channels.get(s.id).applied_tags, ['s-ui', 's-progress']);

	await s.github.comment(1, 'Which key would you bind it to?');
	await onIssue({ ...notify(s), event: { action: 'labeled', label: { name: 'needs-info' }, issue: s.github.issues[0] } });
	assert.match(told(s.discord, s.id).content, /^<@op> We'd like to know a little more about this idea:\n> Which key would you bind it to\?\nPlease answer here in the thread\./);

	await onIssue({ ...notify(s), event: { action: 'reopened', issue: s.github.issues[0] } });
	assert.match(told(s.discord, s.id).content, /^We've reopened this idea and are looking at it again\./);
});

test('a release tells the poster "This idea has shipped in Polestar X", once', async () => {
	const s = await filed();
	Object.assign(s.github.issues[0], { state: 'closed', state_reason: 'completed', closed_at: '2026-11-20T00:00:00Z' });
	s.github.releasesList.push({ id: 1, tag_name: 'v0.4.3', published_at: '2026-11-10T00:00:00Z' });
	const release = { id: 2, tag_name: 'v0.4.4', name: 'Polestar 0.4.4', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.4.4', published_at: '2026-11-21T00:00:00Z' };
	s.github.releasesList.push(release);
	assert.deepEqual(await onRelease({ ...notify(s), event: { release } }), { told: 1, failed: 0 });
	assert.match(told(s.discord, s.id).content, /^<@op> This idea has shipped in \*\*Polestar 0\.4\.4\*\*: update Polestar to get it\. \(\[release notes\]/);
	assert.deepEqual(await onRelease({ ...notify(s), event: { release } }), { told: 0, failed: 0 });
});

test('a maintainer\'s reply on GitHub reaches the suggestions post', async () => {
	const s = await filed();
	await s.github.comment(1, 'Good idea, thanks.');
	const comment = { ...s.github.commentsByIssue.get(1).at(-1), user: { login: 'fitzforge', type: 'User' } };
	assert.equal(await onComment({ ...notify(s), event: { action: 'created', issue: s.github.issues[0], comment } }), true);
	assert.match(told(s.discord, s.id).content, /^<@op> Reply on GitHub \(/);
});

test('a duplicate of an idea is told in an idea\'s words', async () => {
	const s = await filed();
	s.github.issues.push({ number: 2, title: 'The first idea', body: 'x', labels: [{ name: 'idea' }], state: 'open', state_reason: null });
	const issue = Object.assign(s.github.issues[0], { state: 'closed', state_reason: 'duplicate', duplicate_of: 2 });
	await onIssue({ ...notify(s), event: { action: 'closed', issue } });
	const last = told(s.discord, s.id);
	assert.match(last.content, /^<@op> This was already suggested, so we're tracking it in \[fitzforge\/polestar#2\]/);
	assert.match(last.content, /Thanks for the idea!/);
});

test('without SUGGESTIONS_FORUM_ID the Actions leave a suggestions post alone; a #bugs post is told as a bug as ever', async () => {
	const s = await filed();
	const issue = { ...s.github.issues[0], state: 'closed', state_reason: 'completed' };
	const before = s.discord.sent.length;
	assert.equal(await onIssue({ discord: s.discord, github: s.github, forumId: FORUM, log: quietLog, event: { action: 'closed', issue } }), false);
	assert.equal(s.discord.sent.length, before);

	s.discord.post('1001', { content: 'a bug' });
	await s.sync.newPost('1001');
	const bug = { ...s.github.issues[1], state: 'closed', state_reason: 'completed' };
	await onIssue({ ...notify(s), event: { action: 'closed', issue: bug } });
	assert.match(told(s.discord, '1001').content, /^<@u1> This is fixed and will ship in the next Polestar update\. Thanks for the report!/);
});

test('!report in a suggestions post files the whole post as a bug: Reported by, bug labels, every author\'s media, thanked, tracked there, no extra post', async () => {
	const { discord, github, media, command, conversation } = setup();
	const id = conversation();
	const cmd = await command(id, '!report');
	assert.equal(github.issues.length, 1);
	const issue = github.issues[0];
	assert.equal(issue.title, 'Mini map toggle');
	assert.deepEqual(issue.labels.map((l) => l.name), ['discord', 'triage', 'bug', 'ui']);
	assert.match(issue.body, /^\*\*Reported by Opal on \[Discord\]\(https:\/\/discord\.com\/channels\/800\/2001\)\*\* · UI/);
	assert.equal(commentsOf(github).length, 3);
	assert.match(commentsOf(github)[0].body, /!\[b1\.png\]/);
	assert.deepEqual(media.copied, ['discord/2001/a1-a1.png', 'discord/2001/b1-b1.png', 'discord/2001/a2-a2.png']);
	assert.equal(discord.posts.length, 0);
	const said = discord.sent.filter((s) => s.channel === id);
	assert.match(said[0].content, /^Tracked as \[fitzforge\/polestar#1\].*We'll reply here when it's fixed\.$/);
	assert.match(said[1].content, /^Thanks <@op>! This has now been reported as a bug: \[#1\]\(<https:\/\/github\.com\/fitzforge\/polestar\/issues\/1>\)\.$/);
	assert.deepEqual(said[1].users, ['op']);
	assert.equal(said[1].replyTo, id);
	assert.deepEqual(discord.channels.get(id).applied_tags, ['s-ui', 's-tracked']);
	assert.ok(discord.edits.some((e) => e.deleted && e.message === cmd.id));
});

test('`!bug <text>` by the maintainer in a suggestions post is `!report <text>`: the whole post, the text its title', async () => {
	const { github, command, conversation } = setup();
	const id = conversation();
	await command(id, '!bug Library books guide doesn\'t mark as complete automatically');
	assert.equal(github.issues.length, 1);
	assert.equal(github.issues[0].title, 'Library books guide doesn\'t mark as complete automatically');
	assert.match(github.issues[0].body, /^\*\*Reported by Opal/);
	assert.equal(commentsOf(github).length, 3);
	assert.ok(commentsOf(github).every((c) => !c.body.includes('!bug')), 'the command is not copied');
});

test('a post filed one way answers "Already filed as #N" to the other command; non-maintainers filing with `!bug <text>` get the help only', async () => {
	const { discord, github, command, conversation } = setup();
	const id = conversation();
	await command(id, '!suggest');
	for (const text of ['!report', '!bug again please', '!suggest']) {
		const before = discord.sent.length;
		await command(id, text);
		assert.equal(discord.sent[before].content, 'Already filed as [fitzforge/polestar#1](<https://github.com/fitzforge/polestar/issues/1>).', text);
	}
	assert.equal(github.issues.length, 1);

	const other = setup();
	const id2 = other.conversation();
	const before = other.discord.sent.length;
	await other.command(id2, '!bug the map is broken', { author: 'u2' });
	assert.match(other.discord.sent[before].content, /Found a bug or a wrong step/);
	assert.equal(other.github.issues.length, 0);
});

test('a suggestions post filed as a bug is followed and told as a bug, its first-message edit keeps "Reported by"; one filed as an idea is told as an idea', async () => {
	const { discord, github, sync, command, conversation, make } = setup();
	const id = conversation();
	await command(id, '!report');
	await sync.dispatch('MESSAGE_CREATE', discord.say(id, { author: 'u2', name: 'Bea', content: 'still here' }));
	assert.equal(commentsOf(github).length, 4);
	discord.messages.get(id)[0].content = 'The mini map covers the tracker.';
	await sync.dispatch('MESSAGE_UPDATE', { ...discord.messages.get(id)[0], channel_id: id, edited_timestamp: '2026-11-20T00:01:00Z' });
	assert.match(github.issues[0].body, /^\*\*Reported by Opal/);

	// After a restart the index remembers it is a bug.
	const again = make();
	await again.loadIndex();
	discord.messages.get(id)[0].content = 'The mini map covers the tracker, again.';
	await again.dispatch('MESSAGE_UPDATE', { ...discord.messages.get(id)[0], channel_id: id, edited_timestamp: '2026-11-20T00:02:00Z' });
	assert.match(github.issues[0].body, /^\*\*Reported by Opal/);

	const issue = { ...github.issues[0], state: 'closed', state_reason: 'completed' };
	await onIssue({ discord, github, forumId: FORUM, suggestionsForumId: SUGGESTIONS, log: quietLog, event: { action: 'closed', issue } });
	assert.match(told(discord, id).content, /^<@op> This is fixed and will ship in the next Polestar update\. Thanks for the report!/);
});
