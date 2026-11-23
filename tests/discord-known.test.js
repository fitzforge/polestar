'use strict';
// The #known-issues board (tools/discord-bot/lib/known.js): what it lists,
// in which words, and how it is written into the channel.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const K = require('../tools/discord-bot/lib/known');
const { fakeDiscord, fakeGitHub, quietLog, BOT } = require('./helpers/discord-fakes');

const REPO = 'fitzforge/polestar';
const CHANNEL = '950';
const DAY = 24 * 60 * 60 * 1000;
const NOW = Date.parse('2026-11-12T12:00:00Z');

function github() {
	const g = fakeGitHub(REPO);
	g.releasesList.push(
		{ id: 1, tag_name: 'v0.3.5', published_at: '2026-11-01T12:00:00Z', draft: false, prerelease: false },
		{ id: 2, tag_name: 'v0.3.6', published_at: '2026-11-10T12:00:00Z', draft: false, prerelease: false },
		{ id: 3, tag_name: 'v0.3.7-rc.1', published_at: '2026-11-11T12:00:00Z', draft: false, prerelease: true },
		{ id: 4, tag_name: 'forge-v1.2.0', published_at: '2026-11-11T13:00:00Z', draft: false, prerelease: false },
	);
	return g;
}

// An issue with `labels` (known-issue added), and its fields.
function issue(g, title, labels = [], fields = {}) {
	const i = { number: g.issues.length + 1, title, body: '', labels: ['known-issue', ...labels].map((name) => ({ name })), state: 'open', state_reason: null, closed_at: null, author_association: 'NONE', ...fields };
	g.issues.push(i);
	return i;
}

function comment(g, n, body, author_association = 'OWNER', type = 'User') {
	if (!g.commentsByIssue.has(n)) g.commentsByIssue.set(n, []);
	g.commentsByIssue.get(n).push({ body, author_association, user: { type } });
}

test('text from GitHub cannot ping, link or format on Discord, and stays one short line', () => {
	const t = K.sanitise('@everyone look @here <@123> <@&456> <#789> <t:1700000000:R> <:pog:42>\nsecond line', 200);
	assert.ok(!/@everyone|@here|<@|<#|<t:/.test(t), t);
	assert.ok(!t.includes('\n'));
	assert.match(t, /everyone look here/);
	assert.match(t, /:pog:/);
	const links = K.sanitise('see [this](https://evil.example/x) and https://evil.example/y www.evil.example discord.gg/abc and https://github.com/fitzforge/polestar/issues/12#issuecomment-1 and https://github.com/someone/else/issues/3', 300);
	assert.ok(!/https?:|www\.|discord\.gg|evil|someone/.test(links), links);
	assert.match(links, /see this and/);
	assert.match(links, /#12\b/);
	assert.equal(K.sanitise('**bold** _x_ `code` ||spoiler|| ~~s~~', 100), '\\*\\*bold\\*\\* \\_x\\_ \\`code\\` \\|\\|spoiler\\|\\| \\~\\~s\\~\\~');
	assert.equal(K.sanitise('# Big heading', 100), 'Big heading');
	const long = K.sanitise('word '.repeat(100), 50);
	assert.ok(long.length <= 50 && long.endsWith('\u2026'), long);
	assert.match(K.sanitise('@someone', 50), /^@\u200bsomeone$/);
});

test("an entry's words are a maintainer's newest Known issue and Workaround lines, else the title", async () => {
	const g = github();
	const a = issue(g, '[Bug] Arrow points into the lake at Goldshire  @everyone');
	const b = issue(g, 'Quest log error after hearth');
	comment(g, b.number, 'Known issue: old words\nWorkaround: old fix');
	comment(g, b.number, 'Thanks for the report!\n\n**Known issue:** The guide skips "Bounty on Murlocs" after a hearth.\n- **Workaround:** Click the step back once (right-click, Previous step).');
	comment(g, b.number, 'Known issue: a player trying to change it', 'NONE');
	comment(g, b.number, 'Workaround: the bot', 'NONE', 'Bot');
	const c = issue(g, 'Body markers', [], { author_association: 'MEMBER', body: 'Known issue: From the body.\nWorkaround: Body fix.' });
	const { known } = await K.collect({ github: g, now: NOW });
	const by = Object.fromEntries(known.map((e) => [e.number, e]));
	assert.equal(by[a.number].text, 'Arrow points into the lake at Goldshire everyone');
	assert.equal(by[a.number].workaround, '');
	assert.equal(by[b.number].text, 'The guide skips "Bounty on Murlocs" after a hearth.');
	assert.equal(by[b.number].workaround, 'Click the step back once (right-click, Previous step).');
	assert.equal(by[c.number].text, 'From the body.');
	// A player's body is not read.
	const d = issue(g, 'Player title', [], { author_association: 'NONE', body: 'Known issue: player words' });
	const again = await K.collect({ github: g, now: NOW });
	assert.equal(again.known.find((e) => e.number === d.number).text, 'Player title');
});

test('known issues are grouped by guide, then engine, navigation and addon; newest first', async () => {
	const g = github();
	issue(g, 'Westfall old', ['guide:02-westfall']);
	issue(g, 'Engine thing', ['engine']);
	issue(g, 'Westfall new', ['guide:02-westfall', 'engine']);
	issue(g, 'Arrow thing', ['navigation']);
	issue(g, 'Plain', ['bug']);
	const entries = await K.collect({ github: g, now: NOW });
	assert.deepEqual(entries.known.map((e) => [e.number, e.area]), [[5, 'Addon'], [4, 'Arrow and travel'], [3, 'Westfall'], [2, 'Guide engine'], [1, 'Westfall']]);
	const [msg] = K.renderBoard({ repo: REPO, entries, forumId: '900', now: NOW });
	const order = ['**Addon**', '**Arrow and travel**', '**Westfall**', '**Guide engine**'].map((h) => msg.indexOf(h));
	assert.ok(order.every((x, i) => x > 0 && (i === 0 || x > order[i - 1])), msg);
	assert.ok(msg.indexOf('Westfall new') < msg.indexOf('Westfall old'));
	assert.match(msg, /^\*\*Known issues in Polestar 0\.3\.6\*\*\n-# Last updated <t:\d+:f>\n/);
	assert.match(msg, /Report it in <#900>\./);
	assert.match(msg, /^- \[#3\]\(<https:\/\/github\.com\/fitzforge\/polestar\/issues\/3>\) Westfall new$/m);
});

test('a workaround follows its entry after an arrow', () => {
	const entries = { known: [{ number: 7, area: 'Addon', text: 'Window resets', workaround: 'Type /ps reset' }], next: [], released: [], latest: null };
	const [msg] = K.renderBoard({ repo: REPO, entries, now: NOW });
	assert.match(msg, /^- \[#7\]\(<https:\/\/github\.com\/fitzforge\/polestar\/issues\/7>\) Window resets \u2192 Type \/ps reset$/m);
	assert.match(msg, /Report it in #bugs\./);
	assert.match(msg, /^\*\*Known issues in Polestar\*\*/);
});

test('fixed issues move to "next update", then "fixed in X" for a week after X ships, then drop off; other closes drop off at once', async () => {
	const g = github();
	issue(g, 'Still open');
	issue(g, 'Merged, not closed', ['fix-merged']);
	issue(g, 'Closed after 0.3.6', [], { state: 'closed', state_reason: 'completed', closed_at: '2026-11-11T08:00:00Z' });
	issue(g, 'Shipped in 0.3.6', [], { state: 'closed', state_reason: 'completed', closed_at: '2026-11-05T08:00:00Z' });
	issue(g, 'Told by the release run', ['released:v0.3.6'], { state: 'closed', state_reason: 'completed', closed_at: '2026-10-20T08:00:00Z' });
	issue(g, 'Shipped in 0.3.5', [], { state: 'closed', state_reason: 'completed', closed_at: '2026-10-28T08:00:00Z' });
	issue(g, 'Not planned', [], { state: 'closed', state_reason: 'not_planned', closed_at: '2026-11-11T08:00:00Z' });
	issue(g, 'Duplicate', [], { state: 'closed', state_reason: 'duplicate', closed_at: '2026-11-11T08:00:00Z' });
	const e = await K.collect({ github: g, now: NOW });
	assert.deepEqual(e.known.map((x) => x.number), [1]);
	assert.deepEqual(e.next.map((x) => x.number), [3, 2]);
	assert.deepEqual(e.released.map((x) => x.number), [5, 4]);
	assert.equal(e.latest.tag_name, 'v0.3.6');
	const msg = K.renderBoard({ repo: REPO, entries: e, now: NOW }).join('\n');
	assert.match(msg, /\*\*Fixed in the next update\*\*\n- \[#3\]/);
	assert.match(msg, /\*\*Fixed in 0\.3\.6 \(update to get the fix\)\*\*\n- \[#5\]/);
	assert.ok(!/Not planned|Duplicate|Shipped in 0\.3\.5/.test(msg));

	const later = await K.collect({ github: g, now: Date.parse('2026-11-10T12:00:00Z') + (K.FIXED_DAYS + 1) * DAY });
	assert.deepEqual(later.released, []);
	assert.deepEqual(later.next.map((x) => x.number), [3, 2]);
});

test('a long board splits into at most three messages under 2000 characters, never leaving a heading alone, and caps the list', async () => {
	const g = github();
	for (let i = 0; i < 26; i++) {
		const it = issue(g, `Issue ${i}`, [`guide:0${i % 4}-zone-${i % 4}`]);
		comment(g, it.number, `Known issue: ${'Something long goes wrong here '.repeat(6)}\nWorkaround: ${'Do this other long thing instead '.repeat(6)}`);
	}
	for (let i = 0; i < 12; i++) issue(g, `Fixed ${i}`, ['fix-merged']);
	const entries = await K.collect({ github: g, now: NOW });
	const messages = K.renderBoard({ repo: REPO, entries, now: NOW });
	assert.ok(messages.length >= 2 && messages.length <= 3, String(messages.length));
	for (const m of messages) {
		assert.ok(m.length <= 2000, String(m.length));
		const last = m.split('\n').at(-1);
		assert.ok(!/^\*\*/.test(last), `ends on a heading: ${last}`);
		assert.ok(!/^\n/.test(m));
	}
	const all = messages.join('\n');
	const shown = (all.match(/^- \[#\d+\]/gm) || []).length;
	const more = /-# And (\d+) more on GitHub/.exec(all);
	assert.ok(more, 'says how many more');
	const fixedShown = (all.split('**Fixed in the next update**')[1] || '').match(/^- \[#/gm) || [];
	assert.ok(fixedShown.length <= 10);
	assert.equal(shown - fixedShown.length + Number(more[1]), 26);
});

test('the board is written into the bot\'s own messages in place: posted once, edited on change, untouched when only the date moves, shrunk by deleting', async () => {
	const discord = fakeDiscord();
	discord.messages.set(CHANNEL, [{ id: '100', channel_id: CHANNEL, content: 'Welcome to known issues', author: { id: 'mod', bot: false } }]);
	const g = github();
	const first = issue(g, 'First problem');
	await K.updateBoard({ discord, github: g, channel: CHANNEL, now: NOW, log: quietLog });
	assert.equal(discord.sent.length, 1);
	const id = discord.messages.get(CHANNEL).find((m) => m.author.id === BOT).id;

	await K.updateBoard({ discord, github: g, channel: CHANNEL, now: NOW + DAY, log: quietLog });
	assert.equal(discord.sent.length, 1);
	assert.equal(discord.edits.length, 0, 'the date alone changes nothing');

	comment(g, first.number, 'Workaround: Reload the UI.');
	await K.updateBoard({ discord, github: g, channel: CHANNEL, now: NOW + 2 * DAY, log: quietLog });
	assert.equal(discord.sent.length, 1);
	assert.deepEqual(discord.edits.map((e) => e.message), [id]);
	assert.match(discord.messages.get(CHANNEL).find((m) => m.id === id).content, /\u2192 Reload the UI\./);
	assert.equal(discord.messages.get(CHANNEL)[0].content, 'Welcome to known issues');

	// Grows to two messages, then back to one.
	for (let i = 0; i < 20; i++) {
		const it = issue(g, `More ${i}`);
		comment(g, it.number, `Known issue: ${'x'.repeat(130)}\nWorkaround: ${'y'.repeat(150)}`);
	}
	await K.updateBoard({ discord, github: g, channel: CHANNEL, now: NOW, log: quietLog });
	const botMessages = () => discord.messages.get(CHANNEL).filter((m) => m.author.id === BOT);
	assert.ok(botMessages().length >= 2);
	assert.equal(botMessages()[0].id, id, 'the first message stays the header');
	for (const it of g.issues) it.labels = it.labels.filter((l) => l.name !== 'known-issue' || it.number === first.number);
	await K.updateBoard({ discord, github: g, channel: CHANNEL, now: NOW, log: quietLog });
	assert.deepEqual(botMessages().map((m) => m.id), [id]);
	assert.ok(discord.edits.some((e) => e.deleted));
});
