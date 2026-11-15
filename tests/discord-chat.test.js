'use strict';
// The Discord bot's `!bug` command (tools/discord-bot/lib/chat.js): how to
// report a bug, capped against spam, never inside the #bugs forum.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { createChat, LIMITS } = require('../tools/discord-bot/lib/chat');
const { fakeDiscord, quietLog, FORUM, GUILD } = require('./helpers/discord-fakes');

const GENERAL = '1001';
const HOUR = 60 * 60 * 1000;

function setup() {
	const discord = fakeDiscord();
	for (let i = 0; i < 10; i++) discord.channels.set(String(1001 + i), { id: String(1001 + i), type: 0, name: `chat-${i}`, guild_id: GUILD });
	let t = 1_000_000;
	const clock = { now: () => t, advance: (ms) => (t += ms) };
	const chat = createChat({ discord, forumId: FORUM, log: quietLog, now: clock.now });
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
	for (const text of ['!bugsplat', 'my !bug', '!bug please', 'bug']) assert.equal(await say(GENERAL, text), false, text);
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
