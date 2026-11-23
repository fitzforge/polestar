'use strict';
// The Discord bug bot (tools/discord-bot): reading the addon's report back
// out of a #bugs post, filing posts as issues exactly once, carrying the
// thread's follow-ups (the reporter's and other players') and edits over,
// and telling the thread when the issue closes, reopens or ships.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const { parseReport } = require('../tools/discord-bot/lib/report');
const I = require('../tools/discord-bot/lib/issue');
const { createSync } = require('../tools/discord-bot/lib/sync');
const { onIssue, onComment, onRelease, replyMessage } = require('../tools/discord-bot/lib/notify');
const { fakeDiscord, fakeGitHub, fakeMedia, quietLog, FORUM, BOT } = require('./helpers/discord-fakes');

const POST = fs.readFileSync(path.join(__dirname, 'fixtures', 'discord', 'elwynn-trainer.md'), 'utf8');

function setup({ since } = {}) {
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const media = fakeMedia();
	// Every call an hour on, so the per-user limits never hold a test back.
	let t = 0;
	const sync = createSync({ discord, github, media, config: { forumId: FORUM, since, botId: BOT }, log: quietLog, sleep: async () => {}, now: () => (t += 60 * 60 * 1000) });
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
		'Routen: roads · travel planner off',
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
	assert.equal(r.details.routes, 'roads · travel planner off', 'the route settings, found by their words under a translated label');
	assert.match(I.issueBody({ report: r, reporter: 'x', guild: '1', thread: '2' }), /^\| Routes \| roads · travel planner off \|$/m);
	assert.ok(I.labelsFor(r).includes('lua-error'));
});

test('a Chinese report, its labels in full-width colons and brackets, reads like any other', () => {
	const zh = [
		'**出了什么问题：** 箭头指向水里',
		'```',
		'Polestar 0.2.4 Beta · 客户端 1.60.1（70338） · zhCN',
		'Human Warrior · 4级 · Alliance',
		'指南：Elwynn Forest（forever/alliance/human/01-elwynn-forest）',
		'步骤 3/8：Kobold Camp',
		'[x] Accept Wolves Across the Border · quest 33 · npc 196 · map 1429 @48.20,40.00 live',
		'[>] Kill Kobold Vermin 7/10 · quest 7 · npc 6 · map 1429 @47.60,35.10 live',
		'箭头：Kill Kobold Vermin · 42 yd',
		'位置：Elwynn Forest · map 1429 @47.00,35.00 live',
		'路线：balanced',
		'错误：',
		'  1x Polestar/Nav/Arrow.lua:40: bad argument',
		'```',
	].join('\n');
	const r = parseReport(zh);
	assert.equal(r.description, '箭头指向水里', 'the lead-in goes, as in English');
	const d = r.details;
	assert.deepEqual([d.client, d.build, d.locale], ['1.60.1', '70338', 'zhCN']);
	assert.equal(d.character, 'Human Warrior · 4级 · Alliance');
	assert.deepEqual([d.guideTitle, d.guideId], ['Elwynn Forest', 'forever/alliance/human/01-elwynn-forest']);
	assert.deepEqual([d.step, d.stepCount, d.stepTitle], [3, 8, 'Kobold Camp']);
	assert.equal(d.arrow, '箭头：Kill Kobold Vermin · 42 yd', 'the goals are passed over, not read as the arrow or the place');
	assert.deepEqual([d.zone, d.map, d.routes], ['Elwynn Forest', 1429, 'balanced']);
	assert.ok(I.labelsFor(r).includes('guide:01-elwynn-forest'));
	assert.equal(I.issueTitle('**出了什么问题：** 箭头指向水里 ``` Polestar'), '箭头指向水里');
});

test('a report with no guide open still finds the arrow and position lines', () => {
	const r = parseReport('```\nPolestar dev · client 1.60.1 (70425) · enUS\nGuide: none open\nArrow: none\nWhere: Stormwind City · no position\nErrors: none\n```');
	assert.equal(r.details.version, 'dev');
	assert.equal(r.details.character, undefined);
	assert.equal(r.details.arrow, 'Arrow: none');
	assert.equal(r.details.zone, 'Stormwind City');
	assert.deepEqual(I.labelsFor(r), ['discord', 'triage', 'bug', 'locale:enUS']);
	assert.equal(r.details.routes, undefined, 'a report from before the Routes line has none');
});

test('a report from an old Polestar keeps its version, and the issue says it is outdated', () => {
	const r = parseReport('```\nPolestar 0.3.5 Beta (outdated: latest 0.3.7) · client 1.60.1 (70425) · enUS\nGuide: none open\nArrow: none\nWhere: Stormwind City · no position\nErrors: none\n```');
	assert.equal(r.details.version, '0.3.5');
	assert.equal(r.details.locale, 'enUS');
	assert.match(I.issueBody({ report: r, reporter: 'x', guild: '1', thread: '2' }), /^\| Polestar \| 0\.3\.5 Beta \(outdated: latest 0\.3\.7\) \|$/m);
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

test('a 1,000-character description of several lines reads whole, inside the bold line and after it; the issue title is its whole first line', () => {
	const first = 'The arrow points into the lake at Goldshire and never moves on to the next goal at all.';
	const rest = ('I walked round the lake twice, reloaded, and the step stayed where it was. '.repeat(13)).trim();
	const desc = `${first}\n\n${rest}`.slice(0, 1000);
	assert.equal(desc.length, 1000);
	const post = [
		`**What went wrong:** ${desc}`,
		'**Addons:** Questie',
		'```',
		'Polestar 0.3.7 · client 1.60.1 (70532) · enUS',
		'Human Warrior · level 4 · Alliance',
		'Guide: Elwynn Forest (forever/alliance/human/01-elwynn-forest)',
		'Step 3 of 8 (guide step 3): Kobold Camp',
		'[>] Kill Kobold Vermin 7/10 · quest 7 · npc 6 · map 1429 @47.60,35.10 live',
		'... 4 more goals',
		'Arrow: Kill Kobold Vermin · 42 yd',
		'Where: Elwynn Forest · map 1429 @47.00,35.00 live',
		'Errors:',
		'  2x Polestar/Nav/Arrow.lua:40: bad argument',
		'(trimmed to fit Discord)',
		'```',
	].join('\n');
	const r = parseReport(post);
	assert.equal(r.description, `${desc}\n**Addons:** Questie`);
	assert.deepEqual([r.details.guideId, r.details.step, r.details.map], ['forever/alliance/human/01-elwynn-forest', 3, 1429]);
	assert.equal(r.details.arrow, 'Arrow: Kill Kobold Vermin · 42 yd', 'the trimmed goals\' count line is passed over');
	assert.deepEqual(r.details.errors, [{ count: 2, message: 'Polestar/Nav/Arrow.lua:40: bad argument' }]);
	assert.ok(I.issueBody({ report: r, reporter: 'x', guild: '1', thread: '2' }).includes(`> ${rest.slice(0, 200)}`), 'the issue quotes it');
	// Pasted into the title box, the first line is the title, whole.
	assert.equal(I.issueTitle(`**What went wrong:** ${desc} \`\`\` Polestar 0.3.7`), first);
	assert.equal(I.issueTitle('Arrow broken\nsecond line'), 'Arrow broken', 'the first line only');
	assert.equal(I.issueTitle('箭'.repeat(100)), '箭'.repeat(100), "Discord's longest title whole");
	assert.equal(I.issueTitle('箭'.repeat(300)), '箭'.repeat(253) + '...', "GitHub's limit, cut between characters");
	// The description continued after the block (pasted below it) is kept too.
	const after = parseReport(`**What went wrong:** ${first}\n\`\`\`\nPolestar 0.3.7 · client 1.60.1 (70532) · enUS\nGuide: none open\nArrow: none\nWhere: Stormwind City · no position\nErrors: none\n\`\`\`\n${rest}`);
	assert.equal(after.description, `${first}\n\n${rest}`);
});

// A report's details block with `settings` (the Settings section's lines) at its end.
function withSettings(settings, head = 'Settings') {
	return [
		'**What went wrong:** The arrow points into the lake.',
		'```',
		'Polestar 0.4.0 Beta · client 1.60.1 (70532) · enUS',
		'Human Warrior · level 4 · Alliance',
		'Guide: Elwynn Forest (forever/alliance/human/01-elwynn-forest)',
		'Step 3 of 8 (guide step 3): Kobold Camp',
		'[>] Kill Kobold Vermin 7/10 · quest 7 · npc 6 · map 1429 @47.60,35.10 live',
		'Arrow: Kill Kobold Vermin · 42 yd',
		'Where: Elwynn Forest · map 1429 @47.00,35.00 live',
		'Routes: balanced',
		'Errors: none',
		'Quest log 2/40: 783 1/2, 7 done',
		...settings.map((l, i) => (i === 0 ? `${head}: ${l}` : l)),
		'Log:',
		'> 12:00:01 picked the inn at Goldshire',
		'```',
	].join('\n');
}

// The packed line the addon writes (Core/Import.lua, Import.Envelope): every setting a line, zlib, base64.
function packed(lines, sum) {
	const raw = Buffer.from(lines.join('\n'), 'utf8');
	const { adler32 } = require('../tools/discord-bot/lib/report');
	return `!PSR1!${sum || adler32(raw)}!${zlib.deflateSync(raw).toString('base64')}`;
}

test('the report\'s Settings section reads into its profile and settings, each with its default, and the issue folds them under the summary', () => {
	const r = parseReport(withSettings([
		'profile Raid (character) · 5 changed',
		'behavior.autoAccept=off behavior.whileHereRadius=180->400 nav.routeStyle=balanced->fastest',
		'gear.minUpgrade=1->5',
		'looks: skin=hearth · 1 position moved',
	]));
	const s = r.details.settings;
	assert.deepEqual(s, {
		count: 5, profile: 'Raid', source: 'character', looks: 'skin=hearth · 1 position moved',
		entries: [
			{ key: 'behavior.autoAccept', value: 'off', default: 'on' },
			{ key: 'behavior.whileHereRadius', value: '400', default: '180' },
			{ key: 'nav.routeStyle', value: 'fastest', default: 'balanced' },
			{ key: 'gear.minUpgrade', value: '5', default: '1' },
		],
	});
	assert.deepEqual(r.details.errors, [], 'the section reads as no error');
	const body = I.issueBody({ report: r, reporter: 'x', guild: '1', thread: '2' });
	assert.match(body, /^\| Settings \| 5 changed · profile Raid \(character\) \|$/m);
	const folded = body.slice(body.indexOf('<details><summary>Settings: '), body.indexOf('<details><summary>Full report'));
	assert.equal(folded, [
		'<details><summary>Settings: 5 changed · profile Raid (character)</summary>',
		'',
		'```text',
		'behavior.autoAccept = off (default on)',
		'behavior.whileHereRadius = 400 (default 180)',
		'nav.routeStyle = fastest (default balanced)',
		'gear.minUpgrade = 5 (default 1)',
		'looks: skin=hearth · 1 position moved',
		'```',
		'',
		'</details>',
		'',
		'',
	].join('\n'));
	assert.ok(body.indexOf('| Settings |') < body.indexOf('<details><summary>Settings: ') && body.indexOf('<details><summary>Settings: ') < body.indexOf('<details><summary>Full report'));
});

test('a report on the defaults says so in its row and folds nothing; a translated label and a report from before the section read too', () => {
	const defaults = parseReport(withSettings(['all defaults']));
	assert.deepEqual(defaults.details.settings, { count: 0, entries: [] });
	const body = I.issueBody({ report: defaults, reporter: 'x', guild: '1', thread: '2' });
	assert.match(body, /^\| Settings \| all defaults \|$/m);
	assert.doesNotMatch(body, /<summary>Settings/);
	const zh = parseReport(withSettings(['profile Default (class) · 1 changed', 'qol.sellJunk=off'], '设置').replace('Settings: ', '设置：'));
	assert.deepEqual(zh.details.settings, { count: 1, profile: 'Default', source: 'class', entries: [{ key: 'qol.sellJunk', value: 'off', default: 'on' }] });
	assert.equal(parseReport(POST).details.settings, undefined, 'a report from before the section has none');
});

test('past its cap the list and the packed line, which carries the rest, unfold into every setting; a damaged, altered or oversized one leaves the list as shown and says so', () => {
	const { adler32 } = require('../tools/discord-bot/lib/report');
	const listed = ['behavior.autoAccept=off', 'nav.routeStyle=balanced->fastest'];
	const rest = ['qol.sellJunk=off', 'ui.pos=none->2940,13', 'guideWindow.titleSize=1->1.2'];
	const hash = adler32(Buffer.from([...listed, ...rest].join('\n')));
	const lines = (code, list = listed) => ['profile Default (account) · 5 changed', list.join(' '), 'looks: 1 position moved · 1 other look', `+1 more #${hash}`, code];
	const r = parseReport(withSettings(lines(packed(rest))));
	const s = r.details.settings;
	assert.equal(s.unfolded, true);
	assert.deepEqual(s.entries.map((e) => `${e.key}=${e.value}/${e.default}`), ['behavior.autoAccept=off/on', 'nav.routeStyle=fastest/balanced', 'qol.sellJunk=off/on', 'ui.pos=2940,13/none', 'guideWindow.titleSize=1.2/1']);
	assert.deepEqual([s.more, s.hash], [1, hash]);
	const body = I.issueBody({ report: r, reporter: 'x', guild: '1', thread: '2' });
	assert.match(body, /^qol\.sellJunk = off \(default on\)$/m, 'the setting the list had no room for');
	assert.match(body, /^ui\.pos = 2940,13 \(default none\)$/m, 'the looks, with their values');
	const folded = body.slice(body.indexOf('<details><summary>Settings: '), body.indexOf('<details><summary>Full report'));
	assert.doesNotMatch(folded, /^looks: /m, 'the looks line is not needed once every look is listed');
	// A packed line whose own checksum does not match: the list as shown, and the note.
	const bad = parseReport(withSettings(lines(packed(rest, '00000000')))).details.settings;
	assert.deepEqual([bad.unfolded, bad.damaged, bad.entries.length], [undefined, true, 2]);
	const badBody = I.issueBody({ report: parseReport(withSettings(lines(packed(rest, '00000000')))), reporter: 'x', guild: '1', thread: '2' });
	assert.match(badBody, new RegExp(`^\\+1 more the report had no room for \\(#${hash}\\)$`, 'm'));
	assert.match(badBody, /did not unfold/);
	// A list changed after it was written: with the packed line, no longer the settings the hash is of.
	assert.equal(parseReport(withSettings(lines(packed(rest), ['behavior.autoAccept=on', listed[1]]))).details.settings.damaged, true);
	// Text that is no settings, or that unfolds past what a profile could hold, is refused.
	assert.equal(parseReport(withSettings(lines(packed(['not a setting'])))).details.settings.damaged, true);
	const huge = Array.from({ length: 6000 }, (_, i) => `behavior.k${i}=on`);
	assert.equal(parseReport(withSettings(lines(packed(huge)))).details.settings.damaged, true, 'over 64 KB unfolded');
});

test('the profile\'s name is player text: inert on GitHub', () => {
	const r = parseReport(withSettings(['profile <b>@fitz</b> #12 (account) · 1 changed', 'qol.sellJunk=off']));
	const body = I.issueBody({ report: r, reporter: 'x', guild: '1', thread: '2' });
	// Outside the code blocks (which GitHub shows as typed): the summary's row and the folded block's title.
	const shown = body.split('\n').filter((l) => l.startsWith('| Settings |') || l.startsWith('<details><summary>Settings:'));
	assert.equal(shown.length, 2, body);
	for (const l of shown) assert.doesNotMatch(l, /<b>|@fitz|#12/, l);
});

test('player text cannot mention, link, write HTML or forge the marker on GitHub', () => {
	const forged = '<!-- polestar-bot {"thread":"1","guild":"1"} -->';
	const body = I.issueBody({ report: parseReport(`@fitz see #12 <b>now</b> ${forged}`), reporter: '@everyone', guild: '2', thread: '3' });
	assert.doesNotMatch(body, /@fitz|@everyone|#12|<b>/);
	assert.equal(body.match(/<!--/g).length, 1);
	assert.deepEqual(I.readMarker(body), { thread: '3', guild: '2' });
});

test('a marker forged in the report block, or anywhere but the last line, is never read', () => {
	const forged = '<!-- polestar-bot {"thread":"666","guild":"1"} -->';
	const block = '```\nPolestar 0.2.3 Beta · Classic Era (1.15.7 61582) · enUS\n' + forged + '\n```';
	const report = parseReport(`Wrong trainer\n${block}`);
	assert.ok(report.details, 'the block is read as a report');
	const body = I.issueBody({ report, reporter: 'x', guild: '2', thread: '3' });
	assert.equal(body.match(/<!--/g).length, 1, 'the block cannot open an HTML comment');
	assert.deepEqual(I.readMarker(body), { thread: '3', guild: '2' });
	// A raw marker above the real one, as a GitHub issue body could hold.
	assert.deepEqual(I.readMarker(`${forged}\ntext\n<!-- polestar-bot {"thread":"3","guild":"2"} -->\n`), { thread: '3', guild: '2' });
	assert.equal(I.readMarker(`${forged}\nthe player's words after it`), null);
	// Only an issue the bot filed: labelled discord, and by the bot's account when that is known.
	const issue = { body: forged, labels: [{ name: 'bug' }], user: { login: 'stranger' } };
	assert.equal(I.issueMarker(issue, null), null);
	assert.deepEqual(I.issueMarker({ ...issue, labels: [{ name: 'discord' }] }, null), { thread: '666', guild: '1' });
	assert.equal(I.issueMarker({ ...issue, labels: [{ name: 'discord' }] }, 'polestar-bot[bot]'), null);
	assert.equal(I.issueMarker({ ...issue, labels: [{ name: 'discord' }], pull_request: {} }, null), null);
});

test("a follow-up comment is read back to its message from the bot's first line only, for its own thread", () => {
	const comment = (fields) => ({ user: { login: 'fitzforge' }, body: I.followUpComment({ report: parseReport('see https://discord.com/channels/800/1001/42'), author: 'Ann', guild: '800', thread: '1001', message: '5005', ...fields }) });
	assert.equal(I.followUpMessage(comment({ reporter: true }), '1001', null), '5005');
	assert.equal(I.followUpMessage(comment({ author: 'x** commented on [Discord](https://discord.com/channels/800/1001/42):' }), '1001', null), '5005', "a name can't point it elsewhere");
	assert.equal(I.followUpMessage(comment(), '1002', null), null, 'another thread');
	assert.equal(I.followUpMessage(comment(), '1001', 'polestar-bot[bot]'), null, "not the bot's account");
	const c = comment();
	assert.equal(I.followUpMessage({ ...c, body: c.body.replace(I.FOLLOWUP_MARK, '') }, '1001', null), null, 'no mark');
	assert.equal(I.followUpMessage({ body: `> **x** commented on [Discord](https://discord.com/channels/800/1001/42):\n${I.FOLLOWUP_MARK}` }, '1001', null), null);
});

test('labels come from a report only in the shape of a real version, guide id or locale', () => {
	const labels = (details) => I.labelsFor({ details: { errors: [], ...details } });
	assert.deepEqual(labels({ version: '0.2.5-test.2', guideId: 'forever/alliance/01-elwynn-forest', locale: 'deDE' }), ['discord', 'triage', 'bug', 'v0.2.5-test.2', 'guide:01-elwynn-forest', 'locale:deDE']);
	assert.deepEqual(labels({ version: '0.2.3-buy-cheap-gold', guideId: 'x/Free_Stuff.Here', locale: 'xxYY' }), ['discord', 'triage', 'bug']);
	assert.deepEqual(labels({ version: '123.4.5', guideId: 'x/' + 'a'.repeat(45) }), ['discord', 'triage', 'bug']);
});

const { createMedia, imageType } = require('../tools/discord-bot/lib/github');

test('only real images up to 5 MiB are copied to the media branch, whatever Discord calls them', async () => {
	const PNG = [0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, 0, 0];
	assert.equal(imageType(Uint8Array.from(PNG)), 'png');
	assert.equal(imageType(Uint8Array.from([0xff, 0xd8, 0xff, 0xe0])), 'jpeg');
	assert.equal(imageType(Buffer.from('RIFF\0\0\0\0WEBPVP8 ')), 'webp');
	assert.equal(imageType(Buffer.from('GIF89a..')), 'gif');
	assert.equal(imageType(Buffer.from('<html><script>')), null);
	const puts = [];
	const github = {
		repo: 'fitzforge/polestar-bug-media',
		async request(method, p, body) {
			if (method === 'GET' && p.includes('/contents/')) throw Object.assign(new Error('404'), { status: 404 });
			if (method === 'PUT') puts.push(p);
			return {};
		},
	};
	const WEBP = Buffer.from('RIFF\0\0\0\0WEBPVP8 ');
	const bodies = { png: Uint8Array.from(PNG), html: Buffer.from('<html>not a picture</html>'), 'px/d.png?format=webp': WEBP, 'px/e.png?ex=1&format=webp': WEBP, 'px/f.png?format=webp': Buffer.alloc(5 * 1024 * 1024 + 1) };
	const fetched = [];
	const fetch = async (url) => (fetched.push(url), bodies[url] ? { ok: true, arrayBuffer: async () => bodies[url] } : { ok: false });
	const media = createMedia({ github, branch: 'bug-media', fetch });
	assert.match(await media.copy('a.png', { url: 'png', size: 10 }, 'm'), /bug-media\/a\.png$/);
	assert.equal(await media.copy('b.png', { url: 'html', size: 10 }, 'm'), null);
	const big = 5 * 1024 * 1024 + 1;
	assert.equal(await media.copy('c.png', { url: 'png', size: big }, 'm'), null, 'too big, and no media proxy to shrink it');
	// Too big as sent (a full-size PNG screenshot): Discord's media proxy gives it as WebP, kept under .webp.
	assert.match(await media.copy('d.png', { url: 'png', proxy_url: 'px/d.png', content_type: 'image/png', size: big }, 'm'), /bug-media\/d\.webp$/);
	assert.match(await media.copy('e.png', { url: 'png', proxy_url: 'px/e.png?ex=1', content_type: 'image/png', size: big }, 'm'), /bug-media\/e\.webp$/);
	assert.equal(await media.copy('f.png', { url: 'png', proxy_url: 'px/f.png', content_type: 'image/png', size: big }, 'm'), null, 'still too big as WebP');
	assert.equal(await media.copy('g.zip', { url: 'png', proxy_url: 'px/g.zip', content_type: 'application/zip', size: big }, 'm'), null, 'not an image');
	assert.deepEqual(puts.map((p) => p.split('/').pop()), ['a.png', 'd.webp', 'e.webp']);
	assert.deepEqual(fetched, ['png', 'html', 'px/d.png?format=webp', 'px/e.png?ex=1&format=webp', 'px/f.png?format=webp'], 'nothing fetched for what cannot be copied');
});

test("the reporter's full-size screenshot in a follow-up is mirrored and embedded in its comment", async () => {
	const puts = [];
	const mediaGitHub = {
		repo: 'fitzforge/polestar',
		async request(method, p) {
			if (method === 'GET' && p.includes('/contents/')) throw Object.assign(new Error('404'), { status: 404 });
			if (method === 'PUT') puts.push(p);
			return {};
		},
	};
	const fetch = async (url) => ({ ok: url.endsWith('format=webp'), arrayBuffer: async () => Buffer.from('RIFF\0\0\0\0WEBPVP8 ') });
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const sync = createSync({ discord, github, media: createMedia({ github: mediaGitHub, branch: 'bug-media', fetch }), config: { forumId: FORUM, botId: BOT }, log: quietLog, sleep: async () => {}, now: () => 0 });
	discord.post('1001', { content: POST });
	await sync.newPost('1001');
	const shot = { id: 'a9', filename: 'image.png', content_type: 'image/png', size: 7838236, url: 'https://cdn.discordapp.com/x/image.png', proxy_url: 'https://media.discordapp.net/x/image.png' };
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u1', content: '', attachments: [shot] }));
	const body = github.commentsByIssue.get(1)[0].body;
	assert.match(body, /!\[image\.png\]\(https:\/\/raw\.githubusercontent\.com\/fitzforge\/polestar\/bug-media\/discord\/1001\/a9-image\.webp\)/);
	assert.doesNotMatch(body, /\(on Discord\)/);
	assert.equal(puts.length, 1);
});

test("only the thread owner's screenshots are copied; reports and follow-ups are capped per user an hour", async () => {
	let t = 0;
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const media = fakeMedia();
	const sync = createSync({ discord, github, media, config: { forumId: FORUM, botId: BOT }, log: quietLog, sleep: async () => {}, now: () => t });
	discord.post('1001', { content: POST });
	await sync.newPost('1001');
	const shot = (id) => [{ id, filename: 'x.png', content_type: 'image/png', size: 5, url: 'y' }];
	await sync.message(discord.say('1001', { author: 'u2', content: 'me too', attachments: shot('a2') }));
	await sync.message(discord.say('1001', { author: 'u1', content: 'here', attachments: shot('a1') }));
	assert.deepEqual(media.copied, ['discord/1001/a1-x.png']);
	assert.match(github.commentsByIssue.get(1)[0].body, /\[x\.png\]\(https:\/\/discord\.com\/channels\/800\/1001\/\d+\) \(on Discord\)/);

	for (let i = 0; i < 25; i++) await sync.message(discord.say('1001', { author: 'u2', content: `spam ${i}` }));
	assert.equal(github.commentsByIssue.get(1).length, 2 + 19, 'u2 gets 20 an hour');
	t += 60 * 60 * 1000;
	await sync.message(discord.say('1001', { author: 'u2', content: 'an hour later' }));
	assert.equal(github.commentsByIssue.get(1).length, 22);

	for (const id of ['1002', '1003', '1004', '1005', '1006', '1007']) {
		discord.post(id, { owner: 'u9', content: 'bug' });
		await sync.newPost(id);
	}
	discord.post('1008', { owner: 'u8', content: 'bug' });
	await sync.newPost('1008');
	assert.deepEqual(github.issues.map((i) => i.body.match(/channels\/800\/(\d+)/)[1]), ['1001', '1002', '1003', '1004', '1005', '1006', '1008'], "u9's sixth report in an hour is not filed yet");
});

// A bot on a clock the test moves, its timers run by hand: fire() moves the
// clock to each due timer in turn and awaits what it starts.
function clocked(config = {}) {
	let t = 0;
	const timers = [];
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const sync = createSync({ discord, github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT, ...config }, log: quietLog, sleep: async () => {}, now: () => t, setTimer: (fn, ms) => timers.push({ at: t + ms, fn }) });
	async function fire() {
		while (timers.length) {
			timers.sort((a, b) => a.at - b.at);
			const { at, fn } = timers.shift();
			t = Math.max(t, at);
			fn();
			for (let i = 0; i < 20; i++) await new Promise((r) => setImmediate(r));
		}
	}
	return { discord, github, sync, timers, fire, tick: (ms) => (t += ms) };
}

const filedThreads = (github) => github.issues.map((i) => i.body.match(/channels\/800\/(\d+)/)[1]);

test("server staff have no hourly limits: an admin's or moderator's sixth report and 21st follow-up go through", async () => {
	const { discord, github, sync, timers } = clocked();
	discord.members.set('fitz', ['r-admin']);
	discord.members.set('mod', ['r-mod']);
	discord.members.set('player', []);
	const fitz = ['1001', '1002', '1003', '1004', '1005', '1006'];
	for (const id of fitz) {
		discord.post(id, { owner: 'fitz', content: 'bug' });
		await sync.newPost(id);
	}
	assert.deepEqual(filedThreads(github), fitz, "the admin's sixth report is filed");
	for (const id of ['1011', '1012', '1013', '1014', '1015', '1016']) {
		discord.post(id, { owner: 'mod', content: 'bug' });
		await sync.newPost(id);
	}
	assert.equal(github.issues.length, 12, "a moderator's too");
	assert.ok(discord.sent.every((s) => !I.isHeldReply(s.content)), 'staff are never told to wait');
	for (let i = 0; i < 25; i++) await sync.message(discord.say('1001', { author: 'fitz', content: `note ${i}` }));
	for (let i = 0; i < 25; i++) await sync.message(discord.say('1001', { author: 'player', content: `me too ${i}` }));
	assert.equal(github.commentsByIssue.get(1).length, 25 + 20, "the admin's follow-ups all go through, the player's stop at 20");
	assert.equal(timers.length, 5, "the player's five skipped follow-ups wait for a retry");
});

test('the server owner and RATE_EXEMPT_IDS have no hourly limits either', async () => {
	const { discord, github, sync } = clocked({ exemptIds: ['listed'] });
	for (const [i, owner] of ['owner', 'listed'].flatMap((o) => Array(6).fill(o)).entries()) {
		discord.post(String(2001 + i), { owner, content: 'bug' });
		await sync.newPost(String(2001 + i));
	}
	assert.equal(github.issues.length, 12);
});

test("a player's sixth report in an hour is told when it will be filed, filed by the retry, and the reply becomes the issue link", async () => {
	const { discord, github, sync, timers, fire, tick } = clocked();
	const ids = ['1001', '1002', '1003', '1004', '1005', '1006'];
	for (const id of ids) {
		discord.post(id, { owner: 'u9', content: 'bug' });
		await sync.newPost(id);
		tick(60 * 1000);
	}
	assert.deepEqual(filedThreads(github), ids.slice(0, 5));
	assert.equal(timers.length, 1);
	assert.equal(timers[0].at, 60 * 60 * 1000 + 1000, 'retried a second after the first report of the hour ages out');
	const told = discord.sent.filter((s) => s.channel === '1006');
	assert.deepEqual(told.map((s) => s.content), ["Thanks! You've sent a few reports this hour; this one will be filed automatically in about 55 minutes."]);
	await sync.newPost('1006'); // seen again (a THREAD_UPDATE): one retry waiting, told once
	assert.equal(timers.length, 1);
	assert.equal(discord.sent.filter((s) => s.channel === '1006').length, 1);
	await fire();
	assert.deepEqual(filedThreads(github), ids, 'filed by the retry, no restart needed');
	assert.equal(discord.sent.filter((s) => s.channel === '1006').length, 1, 'no second reply');
	const thread = discord.messages.get('1006').filter((m) => m.author.bot);
	assert.equal(thread.length, 1);
	assert.match(thread[0].content, /^Tracked as \[fitzforge\/polestar#6\]/, 'the held reply now links the issue');
	assert.deepEqual(discord.channels.get('1006').applied_tags, ['t-tracked']);

	for (let i = 0; i < 22; i++) await sync.message(discord.say('1001', { author: 'u2', content: `spam ${i}` }));
	assert.equal(github.commentsByIssue.get(1).length, 20);
	await fire();
	const bodies = github.commentsByIssue.get(1).map((c) => c.body);
	assert.equal(bodies.length, 22, 'the two skipped follow-ups are copied later');
	assert.match(bodies[21], /spam 21/);
});

test('after a restart, a held post is filed by the backfill into the same reply', async () => {
	const { discord, github, sync } = clocked();
	for (const id of ['1001', '1002', '1003', '1004', '1005', '1006']) {
		discord.post(id, { owner: 'u9', content: 'bug' });
		await sync.newPost(id);
	}
	assert.ok(I.isHeldReply(discord.messages.get('1006').at(-1).content));
	const again = createSync({ discord, github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog });
	await again.loadIndex();
	await again.backfill();
	assert.equal(github.issues.length, 6);
	const bot = discord.messages.get('1006').filter((m) => m.author.bot);
	assert.equal(bot.length, 1);
	assert.match(bot[0].content, /polestar#6/);
});

test('skipped work waiting for a retry is capped', async () => {
	const { discord, sync, timers } = clocked();
	discord.post('1001', { content: POST });
	await sync.newPost('1001');
	for (let i = 0; i < 130; i++) await sync.message(discord.say('1001', { author: 'u2', content: `spam ${i}` }));
	assert.equal(timers.length, 100);
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
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u2', content: 'Shows green until 85, not 100: https://example.org/spell=2392' }));
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

test('what the thread says while its post waits for the hourly limit is copied once the post is filed, in order', async () => {
	const { discord, github, sync, fire } = clocked();
	for (const id of ['1001', '1002', '1003', '1004', '1005', '1006']) {
		discord.post(id, { owner: 'u9', content: 'bug' });
		await sync.newPost(id);
	}
	assert.equal(github.issues.length, 5, 'the sixth waits');
	await sync.dispatch('MESSAGE_CREATE', discord.say('1006', { author: 'u9', content: 'did the bot miss this' }));
	await sync.dispatch('MESSAGE_CREATE', discord.say('1006', { author: 'u2', content: 'same here' }));
	assert.equal(github.commentsByIssue.get(6), undefined, 'no issue to copy to yet');
	await fire();
	const bodies = github.commentsByIssue.get(6).map((c) => c.body);
	assert.equal(bodies.length, 2);
	assert.match(bodies[0], /^\*\*someone\*\* \(the reporter\) added[\s\S]*did the bot miss this/);
	assert.match(bodies[1], /^\*\*someone\*\* commented[\s\S]*same here/);
});

test('after a restart or a new gateway session, follow-ups sent while the bot was away are copied once, oldest first', async () => {
	const { discord, github, sync } = setup();
	discord.post('1001', { content: POST });
	await sync.newPost('1001');
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u2', content: 'seen live' }));
	// Said while the bot was down: no gateway event reaches it.
	discord.say('1001', { author: 'u1', content: 'still broken after a reload' });
	discord.say('1001', { author: 'u3', attachments: [{ id: 'a7', filename: 'c.png', content_type: 'image/png', size: 5, url: 'z' }] });
	discord.say('1001', { author: 'u3' }); // a sticker alone: nothing to copy
	discord.say('1001', { author: 'u1', content: 'A better title', type: 4 }); // the post renamed
	const bodies = () => github.commentsByIssue.get(1).map((c) => c.body);

	// The fakes' message ids date from 2015 (Discord's epoch): a clock at 0 keeps them inside the catch-up's week.
	const again = createSync({ discord, github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog, now: () => 0 });
	await again.loadIndex();
	await again.dispatch('READY', { user: { id: BOT, username: 'Polestar Bot' } });
	assert.equal(bodies().length, 3);
	assert.match(bodies()[0], /seen live/);
	assert.match(bodies()[1], /\(the reporter\) added[\s\S]*still broken after a reload/);
	assert.match(bodies()[2], /\[c\.png\]\(https:\/\/discord\.com\/channels\/800\/1001\/\d+\) \(on Discord\)/);

	// The session lost again (READY, not RESUMED), and another restart: nothing twice.
	await again.dispatch('READY', { user: { id: BOT, username: 'Polestar Bot' } });
	const third = createSync({ discord, github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog, now: () => 0 });
	await third.loadIndex();
	await third.backfill();
	assert.equal(bodies().length, 3);
});

test("the catch-up copies the last week's missed follow-ups, not older ones (those are a one-off backfill's)", async () => {
	const discord = fakeDiscord();
	const github = fakeGitHub();
	const sync = createSync({ discord, github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog, sleep: async () => {}, now: () => Date.parse('2026-11-10T12:00:00Z') });
	const snowflake = (iso) => String((BigInt(Date.parse(iso)) - 1420070400000n) << 22n);
	const post = snowflake('2026-10-15T18:00:00Z');
	discord.post(post, { content: POST });
	await sync.newPost(post);
	for (const [iso, content] of [['2026-10-16T09:00:00Z', 'a month ago'], ['2026-11-09T09:00:00Z', 'yesterday']]) {
		discord.messages.get(post).push({ id: snowflake(iso), type: 0, channel_id: post, content, attachments: [], mentions: [], author: { id: 'u2', username: 'someone' } });
	}
	await sync.backfill();
	assert.deepEqual(github.commentsByIssue.get(1).map((c) => c.body.match(/> (.*)/)[1]), ['yesterday']);
});

test('a follow-up GitHub failed to take is copied by a catch-up a few minutes later, once', async () => {
	const { discord, github, sync, timers, fire } = clocked();
	discord.post('1001', { content: POST });
	await sync.newPost('1001');
	const comment = github.comment;
	let failures = 2;
	github.comment = async (...a) => {
		if (failures-- > 0) throw Object.assign(new Error('GitHub POST: 502'), { status: 502 });
		return comment(...a);
	};
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u2', content: 'me too' }));
	assert.equal(github.commentsByIssue.get(1), undefined);
	assert.equal(timers.length, 1);
	assert.equal(timers[0].at, 5 * 60 * 1000);
	await fire(); // fails again, then backs off to 10 minutes and copies it
	assert.equal(github.commentsByIssue.get(1).length, 1);
	await sync.dispatch('MESSAGE_CREATE', discord.say('1001', { author: 'u2', content: 'and again' }));
	assert.deepEqual(github.commentsByIssue.get(1).map((c) => /me too/.test(c.body) || /and again/.test(c.body)), [true, true]);
	assert.equal(github.commentsByIssue.get(1).length, 2);
});

test('a post its player tagged In progress is filed; a status tag only moderators can set still means handled', async () => {
	const { discord, github, sync } = setup();
	discord.channels.get(FORUM).available_tags = [...discord.channels.get(FORUM).available_tags, { id: 't-progress', name: 'In Progress', moderated: false }];
	discord.post('1001', { name: 'Picked In progress', tags: ['t-progress'] });
	discord.post('1002', { name: 'Fixed already', tags: ['t-fixed'] });
	await sync.backfill();
	assert.deepEqual(github.issues.map((i) => i.title), ['Picked In progress']);
	assert.deepEqual(discord.channels.get('1001').applied_tags, ['t-tracked'], 'In progress gives way to Tracked');
});

test("an edited follow-up rewrites its comment; one never copied is copied; link previews change nothing", async () => {
	const { discord, github, sync } = setup();
	discord.post('1001', { content: POST });
	await sync.newPost('1001');
	const msg = discord.say('1001', { author: 'u2', content: 'Happens at stpe 20' });
	await sync.dispatch('MESSAGE_CREATE', msg);
	let writes = 0;
	const editComment = github.editComment;
	github.editComment = (...a) => (writes++, editComment(...a));
	await sync.dispatch('MESSAGE_UPDATE', { ...msg, embeds: [{}] });
	assert.equal(writes, 0, 'a link preview is not an edit');
	msg.content = 'Happens at step 20';
	msg.edited_timestamp = '2026-11-10T20:07:53Z';
	await sync.dispatch('MESSAGE_UPDATE', msg);
	await sync.dispatch('MESSAGE_UPDATE', msg);
	assert.equal(writes, 1, 'written once per change');
	const away = discord.say('1001', { author: 'u3', content: 'sent while the bot was away' });
	away.content = 'sent while the bot was away, then edited';
	away.edited_timestamp = '2026-11-10T20:09:00Z';
	await sync.dispatch('MESSAGE_UPDATE', away);
	const bodies = github.commentsByIssue.get(1).map((c) => c.body);
	assert.equal(bodies.length, 2);
	assert.match(bodies[0], /Happens at step 20/);
	assert.doesNotMatch(bodies[0], /stpe/);
	assert.match(bodies[1], /then edited/);
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

// A maintainer's comment on issue n as GitHub's issue_comment event carries it.
async function remark(github, n, body, { association = 'OWNER', type = 'User' } = {}) {
	await github.comment(n, body);
	const c = github.commentsByIssue.get(n).at(-1);
	Object.assign(c, { author_association: association, user: { login: 'fitzforge', type } });
	return structuredClone(c);
}

test("a maintainer's reply on GitHub is posted in the thread once, edited there when edited; nobody else's is", async () => {
	const { discord, github, sync } = await filed();
	const issue = () => structuredClone(github.issues[0]);
	const reply = async (comment, action = 'created') => onComment({ discord, github, event: { action, issue: issue(), comment }, forumId: FORUM, log: quietLog });
	const bot = () => discord.messages.get('1001').filter((m) => m.author.bot);
	const before = bot().length;

	const c = await remark(github, 1, [
		'<!-- triage note -->',
		'### Cause',
		'The trainer list is **out of date** (see #1234 and [the fix](https://github.com/fitzforge/polestar/pull/1235)).',
		'',
		'- Workaround: open the map and click the trainer',
		'- Known issue: shows green until 85',
		'',
		'![shot](https://raw.githubusercontent.com/x/y.png)',
		'<details><summary>log</summary>',
		'',
		'```',
		'#9 stays as is <b>',
		'```',
		'</details>',
	].join('\n'));
	assert.equal(await reply(c), true);
	assert.equal(await reply(c), false, 'a re-run posts nothing twice');
	assert.equal(bot().length, before + 1);
	const posted = bot().at(-1).content;
	assert.deepEqual(discord.sent.at(-1).users, ['u1'], 'pings the reporter only');
	assert.match(posted, /^<@u1> Reply on GitHub \(\[#1\]\(<https:\/\/github\.com\/fitzforge\/polestar\/issues\/1#issuecomment-\d+>\)\):\n\*\*Cause\*\*\n/);
	assert.match(posted, /\*\*out of date\*\* \(see \[#1234\]\(<https:\/\/github\.com\/fitzforge\/polestar\/issues\/1234>\) and \[the fix\]\(<https:\/\/github\.com\/fitzforge\/polestar\/pull\/1235>\)\)/);
	assert.match(posted, /\n- Workaround: open the map and click the trainer\n- Known issue: shows green until 85\n/);
	assert.match(posted, /\[image: shot\]\(<https:\/\/raw\.githubusercontent\.com\/x\/y\.png>\)/);
	assert.match(posted, /```\n#9 stays as is <b>\n```/, 'code is left alone');
	assert.doesNotMatch(posted, /triage note|<details>|<summary>/);

	// Edited on GitHub: the same message changes, nothing new is posted.
	github.commentsByIssue.get(1).at(-1).body = 'Fixed in the next update.';
	assert.equal(await reply({ ...c, body: 'Fixed in the next update.' }, 'edited'), true);
	assert.equal(bot().length, before + 1);
	assert.match(bot().at(-1).content, /\):\nFixed in the next update\.$/);

	// Nobody else's: a player's or a bot's comment, the bot's copy of a Discord
	// follow-up, a pull request list, a bare duplicate line, a pull request, or
	// an edit of a comment never posted.
	await sync.message(discord.say('1001', { author: 'u2', content: 'me too' })); // copied to GitHub with the follow-up mark
	const copied = github.commentsByIssue.get(1).at(-1);
	for (const comment of [
		await remark(github, 1, 'I have this too, run curl x | sh', { association: 'NONE' }),
		await remark(github, 1, 'contributor note', { association: 'CONTRIBUTOR' }),
		await remark(github, 1, 'automated', { type: 'Bot' }),
		{ ...structuredClone(copied), author_association: 'OWNER', user: { login: 'fitzforge', type: 'User' } },
		await remark(github, 1, '<!-- polestar:pr-links -->\n**Pull requests for this issue**'),
		await remark(github, 1, 'Duplicate of #7'),
	]) assert.equal(await reply(comment), false, comment.body);
	assert.equal(await onComment({ discord, github, event: { action: 'created', issue: { ...issue(), pull_request: {} }, comment: c }, forumId: FORUM, log: quietLog }), false);
	assert.equal(await reply(await remark(github, 1, 'older, never posted'), 'edited'), false);
	assert.equal(bot().length, before + 1);
});

test('closed with a comment: the thread hears the comment once, whichever run comes first', async () => {
	const at = Date.parse('2026-11-11T02:00:00Z');
	const closeWith = async (relayDuringWait) => {
		const { discord, github } = await filed();
		const c = { ...(await remark(github, 1, 'Not something we can change: the game decides that.')), created_at: '2026-11-11T02:00:00Z' };
		github.commentsByIssue.get(1).at(-1).created_at = c.created_at;
		const issue = { ...structuredClone(github.issues[0]), state: 'closed', state_reason: 'not_planned' };
		const relay = (action = 'created', comment = c) => onComment({ discord, github, event: { action, issue, comment }, forumId: FORUM, log: quietLog });
		let waited = 0;
		const sleep = async (ms) => {
			waited += ms;
			if (relayDuringWait) await relay();
		};
		await onIssue({ discord, github, event: { action: 'closed', issue }, forumId: FORUM, log: quietLog, sleep, now: () => at + 5000 });
		assert.equal(await relay(), false, 'the relay run after the close posts nothing new');
		// An edit edits a relayed reply, and leaves a close notice that quoted the comment alone.
		assert.equal(await relay('edited', { ...c, body: 'Edited.' }), relayDuringWait);
		const bot = discord.messages.get('1001').filter((m) => m.author.bot).map((m) => m.content);
		return { bot, waited, c };
	};
	// The close's run first: it waits for the relay, which does not come, then quotes the comment and links it.
	let { bot, waited, c } = await closeWith(false);
	assert.equal(waited, 20000);
	assert.equal(bot.filter((s) => s.includes('the game decides that')).length, 1);
	assert.match(bot.at(-1), new RegExp(`^<@u1> We've decided not to change this one\\.\\n> Not something[\\s\\S]*, \\[comment\\]\\(<[^>]+#issuecomment-${c.id}>\\)\\)$`));
	assert.doesNotMatch(bot.at(-1), /Edited/, 'an edit leaves the close notice alone');
	// The relay lands while the close's run waits: the close no longer quotes it.
	({ bot, c } = await closeWith(true));
	assert.equal(bot.filter((s) => s.includes('the game decides that') || s.endsWith('Edited.')).length, 1, 'one copy, edited in place');
	assert.match(bot.at(-2), /^<@u1> Reply on GitHub/);
	assert.match(bot.at(-1), /^<@u1> We've decided not to change this one\.\nThanks for the report!/);
});

test('a long reply is cut under 2000 characters with a link to the full reply, its code block closed', () => {
	const body = 'Intro line.\n```\n' + 'x '.repeat(1500) + '\n```\nAfter.';
	const msg = replyMessage({ repo: 'fitzforge/polestar', issue: { number: 5 }, comment: { id: 77, body }, owner: 'u1' });
	assert.ok(msg.length <= 2000, String(msg.length));
	assert.match(msg, /\n```\n… full reply: <https:\/\/github\.com\/fitzforge\/polestar\/issues\/5#issuecomment-77>$/);
});

test('the needs-info question and a not-planned close do not quote a reply the thread already has', async () => {
	const { discord, github } = await filed();
	const c = await remark(github, 1, 'Which class were you playing?');
	await onComment({ discord, github, event: { action: 'created', issue: structuredClone(github.issues[0]), comment: c }, forumId: FORUM, log: quietLog });
	await onIssue({ discord, github, event: { action: 'labeled', label: { name: 'needs-info' }, issue: github.issues[0] }, forumId: FORUM, log: quietLog });
	assert.match(discord.sent.at(-1).content, /^<@u1> We need a little more to go on with this one: please answer the question above here in the thread\./);
	const why = await remark(github, 1, 'Trainers there are for level 10+, this is expected.');
	await onComment({ discord, github, event: { action: 'created', issue: structuredClone(github.issues[0]), comment: why }, forumId: FORUM, log: quietLog });
	await onIssue({ discord, github, event: { action: 'closed', issue: { ...structuredClone(github.issues[0]), state: 'closed', state_reason: 'not_planned' } }, forumId: FORUM, log: quietLog });
	assert.match(discord.sent.at(-1).content, /^<@u1> We've decided not to change this one\.\nThanks for the report!/);
});

test('a fix closed when its release is already out says so, and is labelled so the next release run skips it', async () => {
	const { discord, github, sync } = await filed();
	for (const id of ['1002', '1003', '1004']) {
		discord.post(id, { content: 'bug ' + id });
		await sync.newPost(id);
	}
	const v036 = { id: 1, tag_name: 'v0.3.6', name: 'Polestar 0.3.6', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.3.6', published_at: '2026-11-10T12:47:02Z' };
	github.releasesList.push(v036);
	const close = async (n, fields) => {
		Object.assign(github.issues[n - 1], { state: 'closed', state_reason: 'completed', ...fields });
		await onIssue({ discord, github, event: { action: 'closed', issue: structuredClone(github.issues[n - 1]) }, forumId: FORUM, log: quietLog });
		return discord.sent.at(-1).content;
	};
	const labelled = (n) => github.issues[n - 1].labels.map((l) => l.name).filter((l) => l.startsWith('released:'));
	// A sweep labelled it released:v0.3.6 before closing it.
	github.issues[0].labels.push({ name: 'released:v0.3.6' });
	assert.match(await close(1, { closed_at: '2026-11-10T12:51:29Z' }), /^<@u1> This is fixed, and the fix is out in \*\*Polestar 0\.3\.6\*\*: update Polestar to get it\. Thanks for the report! \(\[release notes\]\(<https:\/\/github\.com\/fitzforge\/polestar\/releases\/tag\/v0\.3\.6>\)/);
	assert.deepEqual(labelled(1), ['released:v0.3.6']);
	// Milestone 0.3.6, closed by hand a few minutes after 0.3.6 was published.
	assert.match(await close(2, { closed_at: '2026-11-10T12:52:33Z', milestone: { title: '0.3.6' } }), /the fix is out in \*\*Polestar 0\.3\.6\*\*/);
	assert.deepEqual(labelled(2), ['released:v0.3.6']);
	// Closed before the release (the release run tells it), or for an update not out yet.
	assert.match(await close(3, { closed_at: '2026-11-10T12:00:00Z', milestone: { title: '0.3.6' } }), /will ship in the next Polestar update/);
	assert.match(await close(4, { closed_at: '2026-11-10T13:00:00Z', milestone: { title: '0.3.7' } }), /will ship in the next Polestar update/);
	assert.deepEqual([labelled(3), labelled(4)], [[], []]);

	const v037 = { id: 2, tag_name: 'v0.3.7', name: 'Polestar 0.3.7', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.3.7', published_at: '2026-11-14T00:00:00Z' };
	github.releasesList.push(v037);
	const before = discord.sent.length;
	await onRelease({ discord, github, event: { release: v037 }, log: quietLog });
	assert.deepEqual(discord.sent.slice(before).map((s) => s.channel), ['1004'], '0.3.7 tells only the fix it ships, not the two already told they are out');
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

// The issue #1 (thread 1001) duplicates: #2, filed on GitHub, in the state given.
async function duplicated(fields = {}, labels = [], note = null) {
	const s = await filed();
	const m = await s.github.createIssue({ title: 'arrow', body: '', labels });
	Object.assign(m, fields);
	if (note) await s.github.comment(m.number, note);
	return s;
}

test("closed as duplicate by GitHub's marker alone points at the issue, tags Duplicate and locks", async () => {
	const { discord, github } = await duplicated({}, ['has-pr']);
	Object.assign(github.issues[0], { duplicate_of: 2 });
	await onIssue({ discord, github, event: { action: 'closed', issue: { ...github.issues[0], state_reason: 'duplicate' } }, log: quietLog });
	assert.match(discord.sent.at(-1).content, /^<@u1> This was already reported, so we're tracking it in \[fitzforge\/polestar#2\]\(<[^>]+>\)\. A fix is in progress\.\nThanks for the report!/);
	const t = discord.channels.get('1001');
	assert.deepEqual(t.applied_tags, ['t-questing', 't-dup']);
	assert.equal(t.thread_metadata.locked, true);
});

test('closed as not planned with a "Duplicate of #M" comment is a duplicate, quoting the explanation and not the bare line', async () => {
	const { discord, github } = await duplicated({}, ['fix-merged']);
	await github.comment(1, 'Thanks! This is the same bug as #2: the arrow points at the wrong spot.');
	await github.comment(1, 'Duplicate of #2.');
	await onIssue({ discord, github, event: { action: 'closed', issue: { ...github.issues[0], state_reason: 'not_planned' } }, log: quietLog });
	const last = discord.sent.at(-1).content;
	assert.match(last, /^<@u1> It's the same bug as \[fitzforge\/polestar#2\]\(<[^>]+>\), and that's already fixed: it ships in the next Polestar update\.\n> Thanks! This is the same bug as #2: the arrow points at the wrong spot\.\nThanks for the report!/);
	assert.doesNotMatch(last, /not to change|> Duplicate of/);
	const t = discord.channels.get('1001');
	assert.deepEqual(t.applied_tags, ['t-questing', 't-dup']);
	assert.equal(t.thread_metadata.locked, true);
});

test("a duplicate's message says where the issue it duplicates stands", async () => {
	const long = 'x'.repeat(400);
	const cases = [
		[{ state: 'closed', state_reason: 'completed' }, [], null, /It's the same bug as \[fitzforge\/polestar#2\]\S+, and that's already fixed: it ships in the next Polestar update\./],
		[{ state: 'closed', state_reason: 'completed' }, ['released:v0.2.6'], null, /It's the same bug as \[fitzforge\/polestar#2\]\S+, and the fix is out in Polestar 0\.2\.6: update Polestar to get it\./],
		[{ state: 'closed', state_reason: 'not_planned' }, [], 'Works as designed: the arrow points at the giver.', /It's the same as \[fitzforge\/polestar#2\]\S+, and we've decided not to change it:\n> Works as designed: the arrow points at the giver\.\n\n> Same arrow\./],
		[{ state: 'closed', state_reason: 'not_planned' }, ['resolution:cannot-reproduce'], long, /It's the same as \[fitzforge\/polestar#2\]\S+, and we couldn't reproduce that one\.\n> Same arrow\./],
		[{ state: 'open' }, [], null, /This was already reported, so we're tracking it in \[fitzforge\/polestar#2\]\S+\.\n> Same arrow\./],
	];
	for (const [fields, labels, note, want] of cases) {
		const { discord, github } = await duplicated(fields, labels, note);
		await github.comment(1, 'Duplicate of #2\n\nSame arrow.');
		await onIssue({ discord, github, event: { action: 'closed', issue: { ...github.issues[0], state_reason: 'duplicate' } }, log: quietLog });
		const last = discord.sent.at(-1).content;
		assert.match(last, want);
		assert.doesNotMatch(last, /x{400}|A fix is in progress/);
	}
});

test('a release tells the threads of duplicates of what it ships, once, wherever the shipped issue was filed', async () => {
	const { discord, github, sync } = setup();
	for (const id of ['1', '2', '3', '4']) {
		discord.post(id, { content: 'bug ' + id });
		await sync.newPost(id);
	}
	const fix = await github.createIssue({ title: 'filed on GitHub', body: '', labels: [] }); // #5
	const close = (n, fields) => Object.assign(github.issues[n - 1], { state: 'closed', closed_at: '2026-10-15T00:00:00Z', ...fields });
	close(1, { state_reason: 'completed' });
	close(2, { state_reason: 'not_planned' });
	await github.comment(2, 'Duplicate of #1');
	close(3, { state_reason: 'duplicate', duplicate_of: fix.number });
	close(fix.number, { state_reason: 'completed' });
	close(4, { state_reason: 'not_planned' });
	await github.comment(4, 'Duplicate of #9'); // not in this release
	github.releasesList.push({ id: 1, tag_name: 'v0.2.5', published_at: '2026-10-14T00:00:00Z' });
	const release = { id: 2, tag_name: 'v0.2.6', name: 'Polestar 0.2.6', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.2.6', published_at: '2026-10-16T00:00:00Z' };
	github.releasesList.push(release);

	const before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release }, log: quietLog }), { told: 3, failed: 0 });
	const told = discord.sent.slice(before);
	assert.deepEqual(told.map((s) => s.channel), ['1', '2', '3']);
	assert.match(told[1].content, /^<@u1> The fix for \[fitzforge\/polestar#1\]\S+, the same bug as yours, is out in \*\*Polestar 0\.2\.6\*\*/);
	assert.match(told[2].content, /The fix for \[fitzforge\/polestar#5\]/);
	for (const n of [2, 3]) assert.ok(github.issues[n - 1].labels.some((l) => l.name === 'released:v0.2.6'));

	assert.deepEqual(await onRelease({ discord, github, event: { release }, log: quietLog }), { told: 0, failed: 0 });
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

test('a manual release run told which issues it ships tells exactly those and their duplicates, once, whatever their close time', async () => {
	const { discord, github, sync } = setup();
	for (const id of ['1', '2', '3', '4', '5']) {
		discord.post(id, { content: 'bug ' + id });
		await sync.newPost(id);
	}
	const close = (n, fields) => Object.assign(github.issues[n - 1], { state: 'closed', state_reason: 'completed', ...fields });
	github.releasesList.push({ id: 1, tag_name: 'v0.3.5', published_at: '2026-11-08T00:00:00Z' });
	const release = { id: 2, tag_name: 'v0.3.6', name: 'Polestar 0.3.6', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.3.6', published_at: '2026-11-10T12:47:02Z' };
	github.releasesList.push(release);
	close(1, { closed_at: '2026-11-10T12:51:29Z' }); // closed by hand during the run
	close(2, { closed_at: '2026-11-10T12:52:33Z' }); // the same, not listed
	close(3, { closed_at: '2026-11-10T12:53:00Z', state_reason: 'not_planned' });
	await github.comment(3, 'Duplicate of #1');
	// #4 still open, listed by mistake; #5 closed as not planned, listed by mistake.
	close(5, { closed_at: '2026-11-10T12:00:00Z', state_reason: 'not_planned' });
	Object.assign(github.issues[3], { state: 'open' });

	let before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release }, log: quietLog }), { told: 0, failed: 0 }, 'the release run itself: all closed after it');
	assert.deepEqual(await onRelease({ discord, github, event: { release }, issues: [1, 4, 5, 99], log: quietLog }), { told: 2, failed: 0 });
	const told = discord.sent.slice(before);
	assert.deepEqual(told.map((s) => s.channel), ['1', '3']);
	assert.match(told[0].content, /^<@u1> The fix is out in \*\*Polestar 0\.3\.6\*\*/);
	assert.match(told[1].content, /The fix for \[fitzforge\/polestar#1\]\S+, the same bug as yours, is out in \*\*Polestar 0\.3\.6\*\*/);
	for (const n of [1, 3]) assert.ok(github.issues[n - 1].labels.some((l) => l.name === 'released:v0.3.6'));
	for (const n of [2, 4, 5]) assert.ok(!github.issues[n - 1].labels.some((l) => l.name.startsWith('released:')));
	before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release }, issues: [1], log: quietLog }), { told: 0, failed: 0 }, 'once');
	assert.equal(discord.sent.length, before);
});

test('a Forge, data, library or data pack release tells no thread and is never the release before', async () => {
	const { discord, github, sync } = setup();
	for (const id of ['1', '2']) {
		discord.post(id, { content: 'bug ' + id });
		await sync.newPost(id);
	}
	const close = (n, at) => Object.assign(github.issues[n - 1], { state: 'closed', state_reason: 'completed', closed_at: at });
	close(1, '2026-10-15T00:00:00Z');
	close(2, '2026-10-17T00:00:00Z');
	github.releasesList.push({ id: 1, tag_name: 'v0.2.3', published_at: '2026-10-14T16:50:15Z' });
	const before = discord.sent.length;
	for (const [id, tag, at] of [[2, 'forge-v0.1.0', '2026-10-16T00:00:00Z'], [3, 'data-v2026.10.1', '2026-10-16T01:00:00Z'], [4, 'lib-v1.2026.10.1', '2026-10-16T02:00:00Z'], [5, 'data-pack', '2026-10-16T03:00:00Z']]) {
		const r = { id, tag_name: tag, name: tag, published_at: at };
		github.releasesList.push(r);
		assert.deepEqual(await onRelease({ discord, github, event: { release: r }, log: quietLog }), { told: 0, failed: 0 }, tag);
	}
	assert.equal(discord.sent.length, before);
	assert.ok(github.issues.every((i) => !(i.labels || []).some((l) => /^released:/.test(l.name))));
	// The addon release after them counts from v0.2.3: both fixes ship in it.
	const release = { id: 6, tag_name: 'v0.2.5', name: 'Polestar 0.2.5', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.2.5', published_at: '2026-10-18T00:00:00Z' };
	github.releasesList.push(release);
	assert.deepEqual(await onRelease({ discord, github, event: { release }, log: quietLog }), { told: 2, failed: 0 });
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

// Prereleases: no thread hears of them, the testers do, once.
const { spawnSync } = require('node:child_process');
const { tmpdir } = require('./helpers/tmp');

const TESTERS = { channel: '950', role: 'r-testers' };

async function closedFixes(dates) {
	const s = setup();
	for (const [i, at] of dates.entries()) {
		const id = String(i + 1);
		s.discord.post(id, { content: 'bug ' + id });
		await s.sync.newPost(id);
		Object.assign(s.github.issues[i], { state: 'closed', state_reason: 'completed', closed_at: at });
	}
	return s;
}

test('a prerelease tells no thread and pings the testers once, with the player entries from its changes/', async () => {
	const { discord, github } = await closedFixes(['2026-10-15T00:00:00Z']);
	github.releasesList.push({ id: 1, tag_name: 'v0.2.4', published_at: '2026-10-10T00:00:00Z' });
	const release = { id: 2, tag_name: 'v0.3.0-rc.1', prerelease: true, html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.3.0-rc.1', published_at: '2026-10-16T00:00:00Z' };
	github.releasesList.push(release);
	const tag = release.tag_name;
	github.files.set(`${tag}:changes/README.md`, '# Changelog fragments\n');
	github.files.set(`${tag}:changes/b-arrow.md`, '---\nsection: players\n---\n- The arrow walks\n  real paths.\n');
	github.files.set(`${tag}:changes/a-tooling.md`, '---\nsection: contributors\n---\n- A new command.\n');
	github.files.set(`${tag}:changes/c-french.md`, '---\nsection: players\n---\n- Polestar is in French.\n');
	// A tester asking about it first is not the bot's ping.
	discord.messages.set(TESTERS.channel, []);
	discord.say(TESTERS.channel, { author: 'u9', content: `is **${tag}** out yet?` });

	const before = discord.sent.length;
	const edits = discord.edits.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release }, forumId: FORUM, testers: TESTERS, log: quietLog }), { told: 0, failed: 0 });
	const sent = discord.sent.slice(before);
	assert.equal(sent.length, 1);
	assert.equal(sent[0].channel, TESTERS.channel);
	assert.deepEqual(sent[0].roles, [TESTERS.role]);
	assert.deepEqual(sent[0].users, []);
	assert.match(sent[0].content, /^<@&r-testers> \*\*v0\.3\.0-rc\.1\*\*/);
	assert.ok(sent[0].content.includes(`<#${FORUM}>`));
	assert.ok(sent[0].content.includes(release.html_url));
	const arrow = sent[0].content.indexOf('- The arrow walks real paths.');
	assert.ok(arrow > 0 && arrow < sent[0].content.indexOf('- Polestar is in French.'));
	assert.doesNotMatch(sent[0].content, /A new command/);
	assert.equal(discord.edits.length, edits);
	assert.ok(github.issues.every((i) => !i.labels.some((l) => l.name.startsWith('released:'))));

	await onRelease({ discord, github, event: { release }, forumId: FORUM, testers: TESTERS, log: quietLog });
	assert.equal(discord.sent.length, before + 1);
});

test('a full release counts its fixes from the full release before it, never from a prerelease', async () => {
	const { discord, github } = await closedFixes(['2026-10-09T00:00:00Z', '2026-10-12T00:00:00Z', '2026-10-14T12:00:00Z']);
	github.releasesList.push(
		{ id: 1, tag_name: 'v0.2.4', published_at: '2026-10-10T00:00:00Z' },
		{ id: 2, tag_name: 'v0.2.5-test.1', prerelease: true, published_at: '2026-10-11T00:00:00Z' },
		{ id: 3, tag_name: 'v0.3.0-rc.1', published_at: '2026-10-13T00:00:00Z' },
	);
	const rc = github.releasesList[2];
	await onRelease({ discord, github, event: { release: rc }, forumId: FORUM, testers: null, log: quietLog });
	const release = { id: 4, tag_name: 'v0.3.0', name: 'Polestar 0.3.0', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.3.0', published_at: '2026-10-16T00:00:00Z' };
	github.releasesList.push(release);

	const before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release }, forumId: FORUM, log: quietLog }), { told: 2, failed: 0 });
	assert.deepEqual(discord.sent.slice(before).map((s) => s.channel).sort(), ['2', '3']);
});

test('a patch tells the fixes closed by hand, not those closed by a commit only `next` has; the feature release after it tells those', async () => {
	const { discord, github } = await closedFixes(['2026-10-11T00:00:00Z', '2026-10-12T00:00:00Z', '2026-10-13T00:00:00Z']);
	// #1 by a push to next, #2 by hand (the patch's fix), #3 by a pull request merged into next.
	github.timelines.set(1, [{ event: 'closed', commit_id: 'c-next', created_at: '2026-10-11T00:00:00Z' }]);
	github.timelines.set(2, [{ event: 'closed', commit_id: null, created_at: '2026-10-12T00:00:00Z' }]);
	github.timelines.set(3, [
		{ event: 'cross-referenced', source: { issue: { number: 40, repository_url: 'https://api.github.com/repos/fitzforge/polestar', pull_request: { merged_at: '2026-10-13T00:00:02Z' } } } },
		{ event: 'closed', commit_id: null, created_at: '2026-10-13T00:00:03Z' },
	]);
	github.pulls.set(40, { merge_commit_sha: 'c-pr' });
	github.tagCommits.set('v0.2.4', new Set(['c-old']));
	github.tagCommits.set('v0.2.5', new Set(['c-old', 'c-patch']));
	github.tagCommits.set('v0.3.0', new Set(['c-old', 'c-patch', 'c-next', 'c-pr']));
	github.releasesList.push({ id: 1, tag_name: 'v0.2.4', published_at: '2026-10-10T00:00:00Z' });
	const patch = { id: 2, tag_name: 'v0.2.5', name: 'Polestar 0.2.5', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.2.5', published_at: '2026-10-14T00:00:00Z' };
	github.releasesList.push(patch);

	let before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release: patch }, forumId: FORUM, log: quietLog }), { told: 1, failed: 0 });
	assert.deepEqual(discord.sent.slice(before).map((s) => s.channel), ['2']);
	assert.ok(github.issues[0].labels.every((l) => l.name !== 'released:v0.2.5'));

	const feature = { id: 3, tag_name: 'v0.3.0', name: 'Polestar 0.3.0', html_url: 'https://github.com/fitzforge/polestar/releases/tag/v0.3.0', published_at: '2026-10-16T00:00:00Z' };
	github.releasesList.push(feature);
	before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release: feature }, forumId: FORUM, log: quietLog }), { told: 2, failed: 0 });
	assert.deepEqual(discord.sent.slice(before).map((s) => s.channel).sort(), ['1', '3']);
});

test('a prerelease with the testers channel or role unset tells no one and exits 0', async () => {
	const { discord, github } = await closedFixes(['2026-10-15T00:00:00Z']);
	const release = { id: 2, tag_name: 'v0.3.0-rc.2', prerelease: true, published_at: '2026-10-16T00:00:00Z' };
	const before = discord.sent.length;
	assert.deepEqual(await onRelease({ discord, github, event: { release }, forumId: FORUM, testers: null, log: quietLog }), { told: 0, failed: 0 });
	assert.equal(discord.sent.length, before);

	const dir = tmpdir();
	const eventPath = path.join(dir, 'release.json');
	fs.writeFileSync(eventPath, JSON.stringify({ release }));
	const run = spawnSync(process.execPath, [path.join(__dirname, '..', 'tools', 'discord-bot', 'notify.js'), 'release'], {
		encoding: 'utf8',
		env: {
			PATH: process.env.PATH,
			NOTIFY_EVENT_PATH: eventPath,
			DISCORD_TOKEN: 'token',
			GITHUB_TOKEN: 'token',
			GITHUB_REPOSITORY: 'fitzforge/polestar',
			DISCORD_TESTERS_CHANNEL_ID: TESTERS.channel,
			// Nothing listens here: a run that called out would fail.
			DISCORD_API: 'http://127.0.0.1:9',
			GITHUB_API_URL: 'http://127.0.0.1:9',
		},
	});
	assert.equal(run.status, 0, run.stderr);
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

test('/close and /reopen with an issue number act only on issues filed from Discord, never a pull request or another issue', async () => {
	const { github, commands, told } = await commanded();
	github.issues.push({ number: 2, title: 'Roadmap', body: 'plans', labels: [{ name: 'enhancement' }], state: 'open' });
	github.issues.push({ number: 3, title: 'A PR', body: github.issues[0].body, labels: [{ name: 'discord' }], state: 'open', pull_request: {} });
	for (const n of [2, 3]) {
		await commands.handle(command('close', { reason: 'fixed', issue: n }));
		assert.match(told(), /isn\u2019t a bug report filed from Discord/);
		assert.equal(github.issues[n - 1].state, 'open');
	}
	github.issues[1].state = 'closed';
	await commands.handle(command('reopen', { issue: 2 }));
	assert.equal(github.issues[1].state, 'closed');
	await commands.handle(command('close', { reason: 'fixed', issue: 1 }, { channel: '42' }));
	assert.equal(github.issues[0].state, 'closed');
});


// The update reply (lib/update.js): a report from an older Polestar than the
// latest full release is asked, once, to update first.
const U = require('../tools/discord-bot/lib/update');
const { maintainerNote } = require('../tools/discord-bot/lib/notify');

const full = (tag, published_at, extra = {}) => ({ tag_name: tag, html_url: `https://github.com/fitzforge/polestar/releases/tag/${tag}`, published_at, ...extra });
const reportOn = (version) => `It broke.\n\`\`\`\nPolestar ${version} Beta · client 1.60.1 (70888) · enUS\nGuide: none open\nArrow: none\nWhere: Stormwind City · no position\nErrors: none\n\`\`\``;
const UPDATE_037 = "You're on 0.3.6, 0.3.7 is out. Please update and tell us if it still happens.";

test('a title with a link is filed whole, the link kept as text (#1817)', () => {
	const title = 'Miss one quest on excavation to complete : https://example.com/forever/fr/quest=98824/prisme-pr%C3%A9historique';
	assert.equal(I.issueTitle(title), title, 'not cut before or inside the link');
	assert.equal(I.issueTitle('Wrong ender for [Prisme](<https://example.com/quest=98824>) here'), 'Wrong ender for Prisme (https://example.com/quest=98824) here');
	assert.equal(I.issueTitle('See <https://example.com/quest=98824> please'), 'See https://example.com/quest=98824 please');
});

test('versions order as releases do; a build from source or words is no version', () => {
	const v = (s) => U.parseVersion(s);
	assert.equal(v('dev'), null);
	assert.equal(v('0.3.7 Beta'), null);
	assert.equal(v('v0.3.7').text, '0.3.7');
	const order = ['0.3.6', '0.3.7-rc.1', '0.3.7-rc.2', '0.3.7', '0.3.8-test.1', '0.3.10'].map(v);
	for (let i = 1; i < order.length; i++) assert.equal(U.compareVersions(order[i - 1], order[i]), -1, `${order[i - 1].text} < ${order[i].text}`);
	const latest = { version: v('v0.3.7') };
	assert.equal(U.updateText('0.3.6', latest), UPDATE_037);
	assert.equal(U.updateText('0.3.7-rc.2', latest), "You're on 0.3.7-rc.2, 0.3.7 is out. Please update and tell us if it still happens.");
	for (const current of ['0.3.7', '0.3.8-rc.1', 'dev', '', undefined]) assert.equal(U.updateText(current, latest), null, `${current}: nothing to say`);
	assert.equal(U.updateText('0.3.6', null), null, 'no release known: nothing to say');
});

test("the latest full release is GitHub's latest, or the newest addon release when that is another release (drafts, prereleases and the Client's ignored)", async () => {
	const github = fakeGitHub();
	github.releasesList.push(full('v0.3.6', '2026-11-10T00:00:00Z'), full('v0.3.7', '2026-11-11T17:00:00Z'), full('client-v0.1.7', '2026-11-11T18:00:00Z'), full('v0.3.8-rc.1', '2026-11-12T00:00:00Z', { prerelease: true }), full('v0.3.9', '2026-11-13T00:00:00Z', { draft: true }));
	github.latest = full('client-v0.1.7', '2026-11-11T18:00:00Z');
	assert.equal((await U.latestFullRelease(github)).tag, 'v0.3.7');
	github.latest = full('v0.3.7', '2026-11-11T17:00:00Z');
	assert.equal((await U.latestFullRelease(github)).version.text, '0.3.7');
	github.latest = null;
	github.releasesList.length = 0;
	assert.equal(await U.latestFullRelease(github), null);
});

test('the bot asks GitHub for the latest release at most once in ten minutes, and keeps the last answer when GitHub fails', async () => {
	const github = fakeGitHub();
	let calls = 0;
	let fail = false;
	github.latestRelease = async () => {
		calls++;
		if (fail) throw new Error('GitHub down');
		return full('v0.3.7', '2026-11-11T17:00:00Z');
	};
	let t = 0;
	const latest = U.cachedLatest(github, { now: () => t, log: quietLog });
	assert.equal((await latest()).tag, 'v0.3.7');
	t = 9 * 60 * 1000;
	await latest();
	assert.equal(calls, 1);
	t = 11 * 60 * 1000;
	fail = true;
	assert.equal((await latest()).tag, 'v0.3.7');
	assert.equal(calls, 2);
});

test('a post from an older Polestar is told at once, in its thread and on the issue, once; a current or dev one is not', async () => {
	const { discord, github, sync } = setup();
	github.releasesList.push(full('v0.3.7', '2026-11-11T17:00:00Z'));
	discord.post('1001', { content: reportOn('0.3.6') });
	await sync.newPost('1001');
	assert.deepEqual(discord.sent.map((m) => m.content), [I.trackedReply(github.repo, 1), `${UPDATE_037} Download it from CurseForge: <https://www.curseforge.com/wow/addons/polestar>`]);
	assert.deepEqual(discord.sent[1].users, [], 'no ping');
	const [comment] = github.commentsByIssue.get(1);
	assert.equal(comment.body, `${UPDATE_037}\n\nDownload it from CurseForge: https://www.curseforge.com/wow/addons/polestar\n\n${U.UPDATE_MARK}`);
	// Not a maintainer's word: a needs-info question or a close never quotes it.
	assert.equal(maintainerNote([comment]), null);

	// After a restart, the filed post is told nothing again.
	const again = createSync({ discord, github, media: fakeMedia(), config: { forumId: FORUM, botId: BOT }, log: quietLog });
	await again.loadIndex();
	await again.backfill();
	await again.newPost('1001');
	assert.equal(discord.sent.length, 2);
	assert.equal(github.commentsByIssue.get(1).length, 1);

	for (const [id, version] of [['1002', '0.3.7'], ['1003', 'dev'], ['1004', '0.3.8-rc.1']]) {
		discord.post(id, { content: reportOn(version) });
		await sync.newPost(id);
	}
	assert.equal(discord.sent.length, 5, 'only the three tracked replies');
	assert.equal(github.commentsByIssue.size, 1);
});

test('a GitHub failure reading the release or writing the reply never stops the filing', async () => {
	const { discord, github, sync } = setup();
	github.latestRelease = async () => {
		throw new Error('GitHub down');
	};
	discord.post('1001', { content: reportOn('0.3.6') });
	assert.equal(await sync.newPost('1001'), 1);
	assert.equal(discord.sent.length, 1);

	const other = setup();
	other.github.releasesList.push(full('v0.3.7', '2026-11-11T17:00:00Z'));
	other.github.comment = async () => {
		throw new Error('GitHub down');
	};
	other.discord.post('1001', { content: reportOn('0.3.6') });
	assert.equal(await other.sync.newPost('1001'), 1);
	assert.equal(other.discord.sent.length, 2, 'the thread is told all the same');
});

test("an issue opened with a bug form on an old version is told on GitHub once; a Discord one, a current one or a dev build is not", async () => {
	const github = fakeGitHub();
	github.releasesList.push(full('v0.3.7', '2026-11-11T17:00:00Z'));
	const form = (version) => `### What went wrong\n\nThe arrow spins.\n\n### Polestar version\n\n${version}\n\n### Other addons\n\n_No response_`;
	github.issues.push({ number: 1, title: 'Arrow spins', body: form('0.3.6 Beta'), labels: [{ name: 'bug' }], state: 'open' });
	const event = { action: 'opened', issue: github.issues[0] };
	assert.equal(await U.onOpened({ github, event, log: quietLog }), true);
	assert.equal(github.commentsByIssue.get(1)[0].body, `${UPDATE_037}\n\nDownload it from CurseForge: https://www.curseforge.com/wow/addons/polestar\n\n${U.UPDATE_MARK}`);
	assert.equal(await U.onOpened({ github, event, log: quietLog }), false, 'a re-run finds the reply');
	assert.equal(github.commentsByIssue.get(1).length, 1);

	assert.equal(U.formVersion(form('v0.3.6')), 'v0.3.6');
	assert.equal(U.formVersion(form('Polestar 0.3.5 (from CurseForge)')), '0.3.5');
	for (const v of ['dev', '_No response_', 'latest']) assert.equal(U.formVersion(form(v)), null, v);
	for (const [n, issue] of [
		[2, { body: form('0.3.7'), labels: [] }],
		[3, { body: form('dev'), labels: [] }],
		[4, { body: form('0.3.6'), labels: [{ name: 'discord' }] }],
		[5, { body: form('0.3.6'), labels: [], pull_request: {} }],
	]) {
		github.issues.push({ number: n, title: 'x', state: 'open', ...issue });
		assert.equal(await U.onOpened({ github, event: { action: 'opened', issue: github.issues[n - 1] }, log: quietLog }), false, `#${n}`);
	}
	assert.equal(github.commentsByIssue.size, 1);
});
