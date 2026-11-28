'use strict';
// The Discord bot's chat commands (tools/discord-bot/lib/chat.js): `!bug`,
// how to report a bug, capped against spam and never inside the #bugs forum;
// and the maintainer's `!report` and `!suggest`, which file a player's
// messages as an issue (lib/sync.js fileChat).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { loadFaq, parseFaq, FAQ_DIR } = require('../tools/discord-bot/lib/faq');
const { createChat, filedReply, LIMITS, NAUGHTY } = require('../tools/discord-bot/lib/chat');
const { createSync, gatherRun } = require('../tools/discord-bot/lib/sync');
const { fakeDiscord, fakeGitHub, fakeMedia, quietLog, FORUM, SUGGESTIONS, GUILD, BOT } = require('./helpers/discord-fakes');

const GENERAL = '1001';
const HOUR = 60 * 60 * 1000;

function setup(faq = loadFaq(FAQ_DIR)) {
	const discord = fakeDiscord();
	for (let i = 0; i < 10; i++) discord.channels.set(String(1001 + i), { id: String(1001 + i), type: 0, name: `chat-${i}`, guild_id: GUILD });
	let t = 1_000_000;
	const clock = { now: () => t, advance: (ms) => (t += ms) };
	const chat = createChat({ discord, forumId: FORUM, faq, log: quietLog, now: clock.now });
	const say = (channel, content, extra = {}) => chat.dispatch('MESSAGE_CREATE', { channel_id: channel, content, author: { id: 'u1' }, ...extra });
	return { discord, chat, clock, say };
}

test('!bug and !bugs answer with how to report, linking the #bugs forum', async () => {
	const { discord, say } = setup();
	assert.equal(await say(GENERAL, '!bug'), true);
	assert.equal(discord.sent.length, 1);
	assert.equal(discord.sent[0].channel, GENERAL);
	assert.match(discord.sent[0].content, /\/polestar report/);
	assert.match(discord.sent[0].content, /Copy report/);
	assert.ok(discord.sent[0].content.includes(`<#${FORUM}>`));
	assert.ok(discord.sent[0].content.length <= 2000);
	assert.deepEqual(discord.sent[0].users, [], 'pings no one');
});

test('the command is matched whole and in any case', async () => {
	const { discord, say } = setup();
	for (const text of ['!bugsplat', 'my !bug', 'bug']) assert.equal(await say(GENERAL, text), false, text);
	assert.equal(await say(GENERAL, '  !BUGS '), true);
	assert.equal(discord.sent.length, 1);
});

test('a channel gets it at most once every 10 minutes', async () => {
	const { discord, say, clock } = setup();
	await say(GENERAL, '!bug', { author: { id: 'a' } });
	assert.equal(await say(GENERAL, '!bug', { author: { id: 'b' } }), false, 'someone else, same channel');
	clock.advance(LIMITS.channelMs - 1);
	assert.equal(await say(GENERAL, '!bug', { author: { id: 'c' } }), false);
	clock.advance(1);
	assert.equal(await say(GENERAL, '!bug', { author: { id: 'd' } }), true);
	assert.equal(discord.sent.length, 2);
});

test('a person can call it once an hour, in any channel', async () => {
	const { discord, say, clock } = setup();
	await say('1001', '!bug');
	assert.equal(await say('1002', '!bug'), false, 'another channel');
	clock.advance(HOUR - 1);
	assert.equal(await say('1003', '!bug'), false);
	clock.advance(1);
	assert.equal(await say('1003', '!bug'), true);
	assert.equal(discord.sent.length, 2);
});

test('the whole server gets at most 6 answers an hour', async () => {
	const { discord, say, clock } = setup();
	for (let i = 0; i < 6; i++) assert.equal(await say(String(1001 + i), '!bug', { author: { id: `p${i}` } }), true);
	assert.equal(await say('1008', '!bug', { author: { id: 'p8' } }), false, 'the 7th in an hour');
	clock.advance(HOUR);
	assert.equal(await say('1009', '!bug', { author: { id: 'p9' } }), true, 'the next hour');
	assert.equal(discord.sent.length, 7);
});

test('never in the #bugs forum or its threads, never to a bot or a webhook', async () => {
	const { discord, say } = setup();
	discord.post('2001', { content: 'a report' });
	assert.equal(await say('2001', '!bug'), false, 'a #bugs thread');
	assert.equal(await say(FORUM, '!bug'), false, 'the forum itself');
	assert.equal(await say(GENERAL, '!bug', { author: { id: 'b', bot: true } }), false, 'a bot');
	assert.equal(await say(GENERAL, '!bug', { webhook_id: 'w' }), false, 'a webhook');
	assert.equal(discord.sent.length, 0);
});

test('a failing channel lookup is logged, not thrown', async () => {
	const { discord, chat } = setup();
	const errors = [];
	const c = createChat({ discord, forumId: FORUM, log: { ...quietLog, error: (...a) => errors.push(a.join(' ')) } });
	assert.equal(await c.dispatch('MESSAGE_CREATE', { channel_id: 'missing', content: '!bug', author: { id: 'u1' } }), false);
	assert.equal(errors.length, 1);
	assert.equal(chat.dispatch('READY', {}), null);
});

// --- `!report` and `!suggest` ---

const at = (min) => new Date(Date.UTC(2026, 10, 15, 12, min)).toISOString();
const msg = (id, author, min, content = 'x') => ({ id: String(id), author: { id: author }, timestamp: at(min), content });

test('the run gathered around a message: its author\'s, 10 minutes apart at most, commands passed over, at most 10', () => {
	const list = [msg(9, 'a', -1), msg(10, 'a', 0), msg(11, 'a', 2), msg(12, 'b', 3), msg(13, 'a', 4), msg(14, 'a', 5, '!report'), msg(15, 'a', 6), msg(16, 'a', 30)];
	const ids = (run) => run.map((m) => m.id);
	assert.deepEqual(ids(gatherRun([...list].reverse(), '13')), ['13', '15'], 'someone else writes before it, a gap and a command after');
	assert.deepEqual(ids(gatherRun(list, '10')), ['9', '10', '11'], 'before and after it, until someone else writes');
	assert.deepEqual(gatherRun(list, '99'), []);
	const many = Array.from({ length: 14 }, (_, i) => msg(100 + i, 'a', i));
	assert.deepEqual(ids(gatherRun(many, '104')), ['104', '105', '106', '107', '108', '109', '110', '111', '112', '113'], 'it and those after it first');
	assert.deepEqual(ids(gatherRun(many, '110')), ['104', '105', '106', '107', '108', '109', '110', '111', '112', '113'], 'then what room is left, backwards');
});

test('the answer under the player\'s message: thanks and a ping when new, where it is when filed before', () => {
	const [thanks, ping] = filedReply('report', 'fitzforge/polestar', { number: 7, thread: '5001', existing: false, reporter: 'u5' });
	assert.match(thanks, /^Thanks <@u5>! This has now been reported as a bug: \[#7\]\(<https:\/\/github\.com\/fitzforge\/polestar\/issues\/7>\)\. You can follow it and add details in <#5001>, and we'll let you know there when it's fixed\.$/);
	assert.deepEqual(ping, ['u5']);
	assert.match(filedReply('suggestion', 'fitzforge/polestar', { number: 8, thread: '5002', existing: false, reporter: 'u5' })[0], /^Thanks <@u5>! Your idea has been added as a suggestion: \[#8\]\(<[^>]+>\)\. You can follow it and add details in <#5002>\.$/);
	const [again, none] = filedReply('report', 'fitzforge/polestar', { number: 7, thread: '5001', existing: true });
	assert.equal(again, 'Already filed as [fitzforge/polestar#7](<https://github.com/fitzforge/polestar/issues/7>). Follow-ups: <#5001>');
	assert.deepEqual(none, []);
});

// The chat over a sync, on a clock that never holds a user back.
function filing(extra = {}) {
	let t = 0;
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const media = fakeMedia();
	discord.channel('c1', 'general');
	const config = { forumId: FORUM, botId: BOT, maintainerIds: ['fitz'], ...extra };
	const sync = createSync({ discord, github, media, config, log: quietLog, sleep: async () => {}, now: () => (t += HOUR) });
	const chat = createChat({ discord, forumId: FORUM, suggestionsForumId: config.suggestionsForumId, maintainerIds: ['fitz'], file: sync.fileChat, repo: github.repo, log: quietLog, now: () => t });
	// The maintainer's command, a reply to `target`, as the gateway sends it.
	async function command(text, target, { author = 'fitz', channel = 'c1' } = {}) {
		const m = discord.say(channel, { author, content: text, type: 19 });
		if (target) m.message_reference = { message_id: target, channel_id: channel, type: 0 };
		await chat.dispatch('MESSAGE_CREATE', m);
		return m;
	}
	return { discord, github, media, sync, chat, command, config, clock: () => t };
}

const SHOT = [{ id: 'a1', filename: 's.png', content_type: 'image/png', size: 5, url: 'x' }];

test('!report files the player\'s run of messages as a bug, starts a #bugs post, thanks them under their message and deletes the command', async () => {
	const { discord, github, media, command } = filing();
	discord.say('c1', { author: 'u9', content: 'unrelated' });
	const first = discord.say('c1', { author: 'u5', name: 'Alice', content: 'The Paladin trainer in Elwynn is missing', timestamp: at(0) });
	discord.say('c1', { author: 'u5', name: 'Alice', content: 'standing right here', attachments: SHOT, timestamp: at(1) });
	discord.say('c1', { author: 'u6', content: 'same for me' });
	discord.say('c1', { author: 'u5', name: 'Alice', content: 'a later message after someone else', timestamp: at(2) });
	const cmd = await command('!report', first.id);

	assert.equal(github.issues.length, 1);
	const issue = github.issues[0];
	assert.equal(issue.title, 'The Paladin trainer in Elwynn is missing');
	assert.deepEqual(issue.labels.map((l) => l.name), ['discord', 'triage', 'bug', 'from-chat']);
	assert.match(issue.body, /^\*\*Reported by Alice on \[Discord\]\(https:\/\/discord\.com\/channels\/800\/c1\/\d+\)\*\*/);
	assert.match(issue.body, /Filed from #general on Discord; follow-ups go to \[its #bugs post\]/);
	assert.ok(issue.body.indexOf('> The Paladin trainer') < issue.body.indexOf('> standing right here'), 'in order');
	assert.ok(!issue.body.includes('same for me'), 'only the player\'s own run');
	assert.ok(!issue.body.includes('a later message'));
	assert.match(issue.body, /!\[s\.png\]\(https:\/\/raw\.githubusercontent\.com\/[^)]*\/discord\/c1\/a1-s\.png\)/);
	assert.deepEqual(media.copied, ['discord/c1/a1-s.png']);

	const [post] = discord.posts;
	assert.equal(post.forum, FORUM);
	assert.equal(post.name, 'The Paladin trainer in Elwynn is missing');
	assert.deepEqual(post.applied_tags, ['t-tracked']);
	assert.deepEqual(post.users, ['u5']);
	assert.match(post.content, /^\*\*Reported by <@u5>\*\* in https:\/\/discord\.com\/channels\/800\/c1\/\d+\n> The Paladin trainer/);
	assert.deepEqual(post.files.map((f) => [f.name, f.type]), [['s.png', 'image/png']]);
	assert.match(issue.body, new RegExp(`"thread":"${post.id}"`));
	assert.match(discord.sent.find((s) => s.channel === post.id).content, /^Tracked as \[fitzforge\/polestar#1\]/);

	const thanks = discord.sent.find((s) => s.replyTo === first.id);
	assert.match(thanks.content, /^Thanks <@u5>! This has now been reported as a bug: \[#1\]/);
	assert.deepEqual(thanks.users, ['u5']);
	assert.ok(discord.edits.some((e) => e.deleted && e.message === cmd.id), 'the command is deleted');
});

test('!suggest labels the issue an idea, and the text after the command is the title', async () => {
	const { discord, github, command } = filing();
	const m = discord.say('c1', { author: 'u5', name: 'Alice', content: 'It would be nice to see a mini map toggle' });
	await command('!suggest Map toggle\nsecond line', m.id);
	const issue = github.issues[0];
	assert.equal(issue.title, 'Map toggle');
	assert.deepEqual(issue.labels.map((l) => l.name), ['discord', 'triage', 'enhancement', 'idea', 'from-chat']);
	assert.match(issue.body, /^\*\*Suggested by Alice on/);
	assert.equal(discord.posts[0].name, 'Map toggle');
	assert.match(discord.posts[0].content, /^\*\*Suggested by <@u5>\*\*/);
	assert.match(discord.sent.find((s) => s.replyTo === m.id).content, /Your idea has been added as a suggestion/);
});

test('a message filed already, or one of its run, gets "Already filed", also after a restart; nothing new is made', async () => {
	const { discord, github, sync, command, config } = filing();
	const a = discord.say('c1', { author: 'u5', content: 'first', timestamp: at(0) });
	const b = discord.say('c1', { author: 'u5', content: 'second', timestamp: at(1) });
	await command('!report', a.id);
	await command('!report', b.id);
	await command('!suggest', a.id);
	assert.equal(github.issues.length, 1);
	assert.equal(discord.posts.length, 1);
	const again = discord.sent.filter((s) => /^Already filed as/.test(s.content));
	assert.equal(again.length, 2);
	assert.deepEqual(again.map((s) => s.replyTo), [b.id, a.id]);
	assert.deepEqual(again[0].users, []);
	assert.ok(again[0].content.endsWith(`Follow-ups: <#${discord.posts[0].id}>`));

	// A new bot over the same Discord and GitHub reads the issue's marker back.
	const blind = createSync({ discord, github, media: fakeMedia(), config, log: quietLog });
	await blind.loadIndex();
	assert.deepEqual(await blind.fileChat('report', { channel: 'c1', message: b.id }), { number: 1, thread: discord.posts[0].id, existing: true });
	assert.equal(github.issues.length, 1);
});

test('only the maintainer files: anyone else is told off (capped), nothing is filed; without a reply the maintainer is told how', async () => {
	const { discord, github, command } = filing();
	const m = discord.say('c1', { author: 'u5', content: 'a bug' });
	await command('!report', m.id, { author: 'u7' });
	assert.equal(discord.sent.at(-1).content, NAUGHTY);
	assert.equal(discord.sent.at(-1).replyTo !== undefined, true);
	const before = discord.sent.length;
	await command('!suggest', m.id, { author: 'u7' });
	assert.equal(discord.sent.length, before, 'the same person again in the hour: ignored');
	await command('!report', null);
	assert.match(discord.sent.at(-1).content, /^Reply to the message you want filed with `!report`/);
	assert.equal(github.issues.length, 0);
	assert.equal(discord.posts.length, 0);
});

test('a bot\'s or a deleted message cannot be filed; GitHub failing removes the post it started and tells the maintainer', async () => {
	const { discord, github, command } = filing();
	const robot = discord.say('c1', { author: 'b1', bot: true, content: 'beep' });
	await command('!report', robot.id);
	assert.match(discord.sent.at(-1).content, /bot.s message/);
	await command('!report', '999999');
	assert.match(discord.sent.at(-1).content, /can.t be read/);

	const m = discord.say('c1', { author: 'u5', content: 'real bug' });
	github.createIssue = async () => {
		throw new Error('GitHub is down');
	};
	await command('!report', m.id);
	assert.match(discord.sent.at(-1).content, /That didn.t work: GitHub is down/);
	assert.equal(discord.posts.length, 1);
	assert.deepEqual(discord.deletedThreads, [discord.posts[0].id], 'the #bugs post of an unfiled report is removed');
});

test('when Discord refuses the files the post goes without them, the copied media listed as links', async () => {
	const { discord, github, command } = filing();
	discord.refuseFiles = true;
	const m = discord.say('c1', { author: 'u5', content: 'look', attachments: SHOT });
	await command('!report', m.id);
	assert.equal(github.issues.length, 1);
	assert.deepEqual(discord.posts[0].files, []);
	assert.ok(discord.posts[0].content.includes('https://raw.githubusercontent.com/fitzforge/polestar/bug-media/discord/c1/a1-s.png'));
	assert.equal(discord.posts[0].embeds, true, 'link previews on');
});

test('the post the bot started follows like a #bugs post: the player is the reporter, the maintainer\'s commands and the bot\'s first message are not copied', async () => {
	const { discord, github, sync, command } = filing();
	const m = discord.say('c1', { author: 'u5', name: 'Alice', content: 'a bug' });
	await command('!report', m.id);
	const thread = discord.posts[0].id;
	await sync.dispatch('MESSAGE_CREATE', discord.say(thread, { author: 'u5', name: 'Alice', content: 'more detail' }));
	await sync.dispatch('MESSAGE_CREATE', discord.say(thread, { author: 'u6', name: 'Bob', content: 'me too' }));
	await sync.dispatch('MESSAGE_CREATE', discord.say(thread, { author: 'fitz', content: '!suggest' }));
	const comments = github.commentsByIssue.get(1);
	assert.equal(comments.length, 2);
	assert.match(comments[0].body, /^\*\*Alice\*\* \(the reporter\) added on/);
	assert.match(comments[1].body, /^\*\*Bob\*\* commented on/);

	// The bot's own first message is never the issue body.
	const body = github.issues[0].body;
	await sync.dispatch('MESSAGE_UPDATE', { ...discord.messages.get(thread)[0], channel_id: thread, edited_timestamp: at(5) });
	assert.equal(github.issues[0].body, body);
});

test('a #bugs post\'s own first message under !report gives that post\'s issue', async () => {
	const { discord, github, sync, command } = filing();
	const first = discord.post('3001', { owner: 'u5', content: 'a bug', name: 'A bug' });
	await sync.newPost('3001');
	await command('!report', first.id, { channel: '3001' });
	assert.equal(github.issues.length, 1);
	assert.equal(discord.posts.length, 0);
	assert.match(discord.sent.find((s) => s.replyTo === '3001').content, /^Already filed as/);
});

test('the maintainer\'s `!bug <text>` is `!report <text>`: filed as a bug, the text its title; for anyone else it is the plain help, filing and telling off nothing', async () => {
	const { discord, github, command } = filing();
	const m = discord.say('c1', { author: 'u5', name: 'Alice', content: 'Library books do not complete when picked up' });
	await command('!bug Library books guide doesn\'t mark as complete', m.id);
	assert.equal(github.issues.length, 1);
	assert.equal(github.issues[0].title, 'Library books guide doesn\'t mark as complete');
	assert.deepEqual(github.issues[0].labels.map((l) => l.name), ['discord', 'triage', 'bug', 'from-chat']);
	assert.match(github.issues[0].body, /^\*\*Reported by Alice on/);
	assert.match(discord.sent.find((s) => s.replyTo === m.id).content, /^Thanks <@u5>! This has now been reported as a bug: \[#1\]/);
	assert.ok(!github.commentsByIssue.has(1), 'the command is not a comment');

	// Anyone else: the help, no filing, no "Naughty naughty".
	const other = discord.say('c1', { author: 'u6', content: 'something else' });
	const before = discord.sent.length;
	await command('!bug something is broken', other.id, { author: 'u7' });
	assert.equal(discord.sent.length, before + 1);
	assert.match(discord.sent.at(-1).content, /Found a bug or a wrong step/);
	assert.ok(!discord.sent.some((s) => s.content === NAUGHTY));
	assert.equal(github.issues.length, 1);
	assert.equal(discord.posts.length, 1);
});

test('the maintainer\'s `!bug <text>` without a reply is told how, in its own words; bare `!bug` is the help for everyone', async () => {
	const { discord, github, command } = filing();
	await command('!bug it broke', null);
	assert.match(discord.sent.at(-1).content, /^Reply to the message you want filed with `!bug`/);
	assert.equal(github.issues.length, 0);
	await command('!bug', null);
	assert.match(discord.sent.at(-1).content, /Found a bug or a wrong step/);
});

test('a 170-character message files: the GitHub title whole, the Discord post name at most 100 characters', async () => {
	const { discord, github, command } = filing();
	const long = 'The Paladin trainer in Elwynn Forest is missing from the Northshire Abbey and I looked everywhere for him, the guide says he is inside but nobody is there at all today';
	assert.ok(long.length >= 165 && long.length < 256);
	const m = discord.say('c1', { author: 'u5', name: 'Alice', content: long });
	await command('!suggest', m.id);
	assert.equal(github.issues[0].title, long);
	const name = discord.posts[0].name;
	assert.ok(Array.from(name).length <= 100, name.length);
	assert.ok(name.endsWith('\u2026') && long.startsWith(name.slice(0, -1)));
});

test('a suggestion filed from chat gets its post in the suggestions forum, tagged there; a report stays in #bugs', async () => {
	const { discord, github, command } = filing({ suggestionsForumId: SUGGESTIONS });
	const a = discord.say('c1', { author: 'u5', name: 'Alice', content: 'a mini map toggle please' });
	await command('!suggest', a.id);
	const b = discord.say('c1', { author: 'u6', name: 'Bob', content: 'the trainer is missing' });
	await command('!report', b.id);
	assert.equal(discord.posts[0].forum, SUGGESTIONS);
	assert.match(github.issues[0].body, /follow-ups go to \[its suggestions post\]/);
	assert.equal(discord.posts[1].forum, FORUM);
	assert.deepEqual(discord.posts[1].applied_tags, ['t-tracked']);
});

test('a Discord 400 names the refused fields in the error', async () => {
	const { createDiscord } = require('../tools/discord-bot/lib/discord');
	const d = createDiscord({ token: 't', api: 'http://x', fetch: async () => ({ ok: false, status: 400, json: async () => ({ message: 'Invalid Form Body', code: 50035, errors: { name: { _errors: [{ code: 'BASE_TYPE_MAX_LENGTH' }] } } }), text: async () => '' }) });
	await assert.rejects(d.getChannel('1'), /400 Invalid Form Body .*"name".*BASE_TYPE_MAX_LENGTH/);
});

test('!dungeons and !dung answer with the text from faq/dungeons.md, any case, whole message only, pinging no one', async () => {
	const { discord, say } = setup();
	assert.equal(await say(GENERAL, '!dungeons'), true);
	assert.equal(await say('1002', '  !DUNG ', { author: { id: 'u2' } }), true);
	assert.equal(discord.sent.length, 2);
	assert.ok(discord.sent[0].content.startsWith('**🏰 Are dungeons in the leveling guide?**\nNot yet, on purpose.'));
	assert.ok(discord.sent[0].content.endsWith('Your leveling guide keeps your place in its own tab the whole time.'));
	assert.ok(discord.sent[0].content.length < 2000);
	assert.equal(discord.sent[0].content, discord.sent[1].content);
	assert.deepEqual(discord.sent[0].users, []);
	for (const text of ['!dungeons please', 'my !dung', '!dungeon']) assert.equal(await say('1003', text, { author: { id: 'u3' } }), false, text);
});

test('!pray and !faith reply with the picture from faq/pray.md, named pray.png, and no text; FAQ files without an image reply with text only', async () => {
	const { discord, say } = setup();
	assert.equal(await say(GENERAL, '!pray'), true);
	assert.equal(await say('1002', '!FAITH', { author: { id: 'u2' } }), true);
	assert.equal(await say('1003', '!dungeons', { author: { id: 'u3' } }), true);
	for (const m of discord.sent.slice(0, 2)) {
		assert.equal(m.content, '');
		assert.equal(m.files.length, 1);
		assert.equal(m.files[0].name, 'pray.png');
		assert.equal(m.files[0].type, 'image/png');
		assert.deepEqual([...m.files[0].data.subarray(0, 4)], [0x89, 0x50, 0x4e, 0x47], 'a real PNG');
	}
	assert.equal(discord.sent[2].files, undefined);
	assert.ok(discord.sent[2].content.length > 0);
});

test('a FAQ file may name an image, which must exist under faq/', () => {
	assert.deepEqual(parseFaq('x.md', 'Commands: !a\nImage: media/a.png\n\nOne line'), { commands: ['!a'], text: 'One line', image: 'media/a.png' });
	assert.throws(() => parseFaq('x.md', 'Commands: !a\nImage:\n\ntext'), /"Image:" needs a file/);
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'faq-'));
	try {
		fs.writeFileSync(path.join(dir, 'a.md'), 'Commands: !a\nImage: media/a.png\n');
		assert.throws(() => loadFaq(dir), /faq\/a\.md: the image media\/a\.png was not found/);
		fs.writeFileSync(path.join(dir, 'a.md'), 'Commands: !a\nImage: ../a.png\n');
		assert.throws(() => loadFaq(dir), /outside faq\//);
		fs.writeFileSync(path.join(dir, 'a.md'), 'Commands: !a\nImage: a.txt\n');
		assert.throws(() => loadFaq(dir), /must be a png/);
	} finally {
		fs.rmSync(dir, { recursive: true });
	}
});

test('the FAQ answers hold the !bug caps, shared with it', async () => {
	const { discord, say, clock } = setup();
	await say(GENERAL, '!dungeons', { author: { id: 'a' } });
	assert.equal(await say(GENERAL, '!dung', { author: { id: 'b' } }), false, 'channel, 10 minutes');
	assert.equal(await say('1002', '!dung', { author: { id: 'a' } }), false, 'person, an hour');
	assert.equal(await say(GENERAL, '!bug', { author: { id: 'c' } }), false, 'the channel cap is shared with !bug');
	clock.advance(LIMITS.channelMs);
	assert.equal(await say(GENERAL, '!dung', { author: { id: 'b' } }), true);
	for (let i = 0; i < 4; i++) assert.equal(await say(String(1003 + i), '!dung', { author: { id: `p${i}` } }), true);
	assert.equal(await say('1008', '!dung', { author: { id: 'z' } }), false, 'the 7th in an hour');
	assert.equal(discord.sent.length, 6);
});

test('nothing from the FAQ in the #bugs forum or its threads, or to a bot', async () => {
	const { discord, say } = setup();
	discord.channels.set('2001', { id: '2001', type: 11, name: 'thread', parent_id: FORUM, guild_id: GUILD });
	assert.equal(await say('2001', '!dungeons'), false);
	assert.equal(await say(FORUM, '!dung'), false);
	assert.equal(await say(GENERAL, '!dung', { author: { id: 'b', bot: true } }), false);
	assert.equal(discord.sent.length, 0);
});

test('a FAQ file with a bad shape is refused with a line naming the file and the problem', () => {
	const bad = (source, re) => assert.throws(() => parseFaq('x.md', source), re, source);
	bad('!dungeons\n\ntext', /^Error: faq\/x\.md: the first line must be "Commands:/);
	bad('Commands:\n\ntext', /faq\/x\.md: the first line|no commands/);
	bad('Commands: dungeons\n\ntext', /"dungeons" is not a command/);
	bad('Commands: !bug\n\ntext', /!bug is already used by the bot/);
	bad('Commands: !a\n\n  \n', /no text/);
	bad('Commands: !a\n\n' + 'x'.repeat(2001), /2001 characters; Discord allows 2000/);
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'faq-'));
	try {
		fs.writeFileSync(path.join(dir, 'a.md'), 'Commands: !one, !Two\n\nAnswer one\n');
		assert.deepEqual(loadFaq(dir), [{ file: 'a.md', commands: ['!one', '!two'], text: 'Answer one' }]);
		fs.writeFileSync(path.join(dir, 'b.md'), 'Commands: !two\n\nAnswer two\n');
		assert.throws(() => loadFaq(dir), /faq\/b\.md: !two is also in faq\/a\.md/);
		fs.writeFileSync(path.join(dir, 'b.md'), 'no header');
		assert.throws(() => loadFaq(dir), /faq\/b\.md: the first line/);
	} finally {
		fs.rmSync(dir, { recursive: true });
	}
});

test('the shipped FAQ loads', () => {
	const faq = loadFaq(FAQ_DIR);
	assert.deepEqual(faq.find((e) => e.file === 'dungeons.md').commands, ['!dungeons', '!dung']);
	assert.deepEqual(faq.find((e) => e.file === 'pray.md').commands, ['!pray', '!faith']);
});
