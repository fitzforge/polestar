'use strict';
// The #known-issues board: one post (two or three messages when it is long)
// listing the problems players are likely to hit, each with what to do
// meanwhile, written again from GitHub on every run and edited in place.
//
// An entry is an issue labelled known-issue. Open, it is a known issue (one
// with fix-merged is fixed in the next update). Closed as completed, it is
// fixed in the next update until a release ships it, then "fixed in X" for
// FIXED_DAYS after that release, then gone. Closed any other way (not
// planned, duplicate), it is gone at once.
//
// Its words come from a maintainer's `Known issue: <one line>` and
// `Workaround: <one line>` lines on the issue (the newest of each), else
// from the title. Either way the text is made inert: no mentions, no links,
// no markup, one short line. The board's own links are the issue links.

const { shipCheck, isPrerelease, isAddonRelease } = require('./notify');

const LABEL = 'known-issue';
const MAX_MESSAGE = 1950; // Discord's 2000 for a bot, with room to spare
const MAX_MESSAGES = 3;
const MAX_KNOWN = 20;
const MAX_FIXED = 10;
const MAX_TEXT = 140;
const MAX_WORKAROUND = 160;
const FIXED_DAYS = 7;
const DAY = 24 * 60 * 60 * 1000;
const UPDATED = '-# Last updated ';

const TEAM = new Set(['OWNER', 'MEMBER', 'COLLABORATOR']);
const labelNames = (issue) => (issue.labels || []).map((l) => (typeof l === 'string' ? l : l.name));

// Text from GitHub made safe for a Discord message: one line, no mentions,
// no Discord markup, no links (a link to one of this repository's issues
// becomes #N), markdown escaped, at most `max` characters.
function sanitise(text, max, repo = 'fitzforge/polestar') {
	const issueUrl = new RegExp(`https?://(?:www\\.)?github\\.com/${repo.replace(/[.]/g, '\\.')}/(?:issues|pull)/(\\d+)\\S*`, 'gi');
	let t = String(text || '')
		.replace(/<!--[\s\S]*?-->/g, ' ')
		.replace(/\[([^\]]*)\]\([^)]*\)/g, '$1') // masked links: their words
		.replace(issueUrl, '#$1')
		.replace(/\b(?:https?:\/\/|www\.)\S+/gi, '')
		.replace(/\b(?:discord(?:app)?\.(?:gg|com|io|me)|dsc\.gg)\/\S*/gi, '')
		.replace(/<a?:(\w+):\d+>/g, ':$1:')
		.replace(/<[@#][!&]?\d*>|<t:\d+(?::\w)?>|<\/[\w ]+:\d+>/g, '')
		.replace(/[<>]/g, '')
		.replace(/@+\s*(everyone|here)\b/gi, '$1')
		.replace(/@(?=\S)/g, '@\u200b')
		.replace(/\s+/g, ' ')
		.trim()
		.replace(/^(?:#+|>+|-#)\s*/, '')
		.replace(/[\\*_~`|]/g, '\\$&');
	if (t.length > max) {
		t = t.slice(0, max - 1);
		const space = t.lastIndexOf(' ');
		if (space > max * 0.6) t = t.slice(0, space);
		t = t.replace(/\\$/, '').trimEnd() + '\u2026';
	}
	return t;
}

// A title as an entry's text: without its [Bug]-style prefixes.
function titleText(title) {
	return String(title || '').replace(/^\s*(?:\[[^\]]*\]\s*|(?:bug|issue)\s*:\s*)+/i, '');
}

// The newest maintainer `Known issue:` and `Workaround:` lines on an issue
// (comments newest first, then the body when a maintainer wrote it), each
// null when there is none.
function markers(issue, comments) {
	const sources = comments
		.filter((c) => TEAM.has(c.author_association) && c.body && !(c.user && c.user.type === 'Bot'))
		.map((c) => c.body)
		.reverse();
	if (TEAM.has(issue.author_association) && issue.body) sources.push(issue.body);
	const find = (name) => {
		const re = new RegExp(`^[\\s>*_-]*${name}\\s*:[*_]*\\s*(.+)$`, 'im');
		for (const body of sources) {
			const m = re.exec(body);
			if (m && m[1].replace(/[*_\s]/g, '')) return m[1].replace(/^[*_\s]+|[*_\s]+$/g, '');
		}
		return null;
	};
	return { text: find('known issue'), workaround: find('workaround') };
}

// "guide:02-westfall" as "Westfall".
function guideName(id) {
	return id
		.replace(/^\d+-/, '')
		.split('-')
		.map((w) => (w ? w[0].toUpperCase() + w.slice(1) : w))
		.join(' ');
}

const AREAS = [
	['navigation', 'Arrow and travel'],
	['engine', 'Guide engine'],
	['lua-error', 'Errors'],
	['client', 'Polestar Client'],
];

// An issue's area: its guide (the first guide: label), else navigation,
// engine, errors or the client by label, else the addon.
function areaOf(issue) {
	const names = labelNames(issue);
	const guide = names.find((n) => n.startsWith('guide:') && n.length > 6);
	if (guide) return guideName(guide.slice(6));
	const area = AREAS.find(([label]) => names.includes(label));
	return area ? area[1] : 'Addon';
}

// The latest full addon release, or null.
function latestRelease(releases) {
	return releases
		.filter((r) => !r.draft && isAddonRelease(r) && !isPrerelease(r) && r.published_at)
		.sort((a, b) => Date.parse(b.published_at) - Date.parse(a.published_at))[0] || null;
}

const version = (release) => String(release.tag_name).replace(/^v/, '');

// Where a known-issue issue stands: 'known', 'next' (fixed in the next
// update), 'released' (fixed in the latest release, still shown) or null
// (not on the board). `ships` is shipCheck's for the latest release.
async function standing(issue, { latest, ships, now }) {
	if (issue.state === 'open') return labelNames(issue).includes('fix-merged') ? 'next' : 'known';
	if (issue.state_reason !== 'completed') return null;
	if (!latest || Date.parse(issue.closed_at) > Date.parse(latest.published_at)) return 'next';
	if (now - Date.parse(latest.published_at) > FIXED_DAYS * DAY) return null;
	const told = labelNames(issue).includes(`released:${latest.tag_name}`);
	return told || (ships && await ships(issue)) ? 'released' : null;
}

// The board's entries from GitHub: { known, next, released, latest }, each
// list of { number, area, text, workaround }, newest first.
async function collect({ github, now = Date.now() }) {
	const latest = latestRelease(await github.releases());
	const ships = latest ? await shipCheck(github, latest) : null;
	const open = await github.issuesLabelled(LABEL, { state: 'open', max: 200 });
	const since = latest ? new Date(Date.parse(latest.published_at) - 90 * DAY).toISOString() : undefined;
	const closed = await github.issuesLabelled(LABEL, { state: 'closed', since, max: 200 });
	const out = { known: [], next: [], released: [], latest };
	for (const issue of [...open, ...closed]) {
		if (issue.pull_request) continue;
		const where = await standing(issue, { latest, ships, now });
		if (!where) continue;
		const m = markers(issue, await github.comments(issue.number));
		out[where].push({
			number: issue.number,
			area: areaOf(issue),
			text: sanitise(m.text || titleText(issue.title), MAX_TEXT, github.repo),
			workaround: m.workaround ? sanitise(m.workaround, MAX_WORKAROUND, github.repo) : '',
		});
	}
	for (const list of [out.known, out.next, out.released]) list.sort((a, b) => b.number - a.number);
	return out;
}

const link = (repo, n) => `[#${n}](<https://github.com/${repo}/issues/${n}>)`;

function entryLine(repo, e, { workaround = true } = {}) {
	const text = e.text || 'Untitled';
	return `- ${link(repo, e.number)} ${text}${workaround && e.workaround ? ` \u2192 ${e.workaround}` : ''}`;
}

// Known entries grouped by area: groups ordered by their newest entry,
// entries newest first.
function grouped(entries) {
	const groups = new Map();
	for (const e of entries) {
		if (!groups.has(e.area)) groups.set(e.area, []);
		groups.get(e.area).push(e);
	}
	return [...groups.entries()].sort((a, b) => b[1][0].number - a[1][0].number);
}

// The board's lines, `cap` known entries at most (MAX_FIXED fixed ones per
// section). Each item is a line, or a group of lines kept in one message.
function boardBlocks({ repo, entries, forumId, now, cap = MAX_KNOWN }) {
	const { known, next, released, latest } = entries;
	const blocks = [
		`**Known issues in Polestar${latest ? ' ' + version(latest) : ''}**`,
		`${UPDATED}<t:${Math.floor(now / 1000)}:f>`,
		`Problems we know about and are fixing, with what to do meanwhile. Something else wrong? Report it in ${forumId ? `<#${forumId}>` : '#bugs'}.`,
	];
	const shown = known.slice(0, cap);
	if (!known.length) blocks.push('', 'No known issues right now.');
	for (const [area, list] of grouped(shown)) {
		const lines = list.map((e) => entryLine(repo, e));
		blocks.push('', [`**${area}**`, lines[0]], ...lines.slice(1));
	}
	if (known.length > shown.length) {
		blocks.push(`-# And ${known.length - shown.length} more on GitHub: <https://github.com/${repo}/issues?q=is%3Aissue+is%3Aopen+label%3A${LABEL}>`);
	}
	const fixed = (title, list, opts) => {
		if (!list.length) return;
		const lines = list.slice(0, MAX_FIXED).map((e) => entryLine(repo, e, opts));
		blocks.push('', [`**${title}**`, lines[0]], ...lines.slice(1));
	};
	fixed('Fixed in the next update', next);
	if (latest) fixed(`Fixed in ${version(latest)} (update to get the fix)`, released, { workaround: false });
	return blocks;
}

// Lines into messages of at most MAX_MESSAGE characters, never splitting a
// group of lines; a message never starts with a blank line.
function pack(blocks) {
	const messages = [];
	let cur = '';
	for (const block of blocks) {
		const text = Array.isArray(block) ? block.join('\n') : block;
		if (cur && cur.length + 1 + text.length > MAX_MESSAGE) {
			messages.push(cur.replace(/\n+$/, ''));
			cur = '';
		}
		if (!cur && text === '') continue;
		cur = cur ? `${cur}\n${text}` : text;
	}
	if (cur) messages.push(cur);
	return messages;
}

// The board as messages: as many known entries as fit in MAX_MESSAGES.
function renderBoard({ repo, entries, forumId = null, now = Date.now() }) {
	for (let cap = MAX_KNOWN; ; cap--) {
		const messages = pack(boardBlocks({ repo, entries, forumId, now, cap }));
		if (messages.length <= MAX_MESSAGES || cap === 0) return messages.slice(0, MAX_MESSAGES);
	}
}

// A message's words without its "Last updated" line: two boards that differ
// only there are the same board.
const withoutStamp = (content) => String(content || '').split('\n').filter((l) => !l.startsWith(UPDATED)).join('\n');

// Writes the board into the channel: the bot's own messages there, oldest
// first, are its slots. Each is edited when its text changes, new ones are
// posted when the board grows, surplus ones deleted when it shrinks. Nothing
// is re-posted, so no state is kept anywhere but the channel.
async function writeBoard({ discord, channel, messages, log = console }) {
	const me = await discord.me();
	const slots = (await discord.getMessages(channel, 50))
		.filter((m) => m.author && m.author.id === me.id)
		.sort((a, b) => (BigInt(a.id) < BigInt(b.id) ? -1 : 1));
	let changed = 0;
	for (let i = 0; i < messages.length; i++) {
		const slot = slots[i];
		if (!slot) {
			await discord.send(channel, messages[i]);
			changed++;
		} else if (withoutStamp(slot.content) !== withoutStamp(messages[i])) {
			await discord.editMessage(channel, slot.id, messages[i]);
			changed++;
		}
	}
	for (const slot of slots.slice(messages.length)) {
		await discord.deleteMessage(channel, slot.id);
		changed++;
	}
	log.info(changed ? `known issues: ${changed} of ${messages.length} messages written` : 'known issues: unchanged');
	return changed;
}

async function updateBoard({ discord, github, channel, forumId = null, now = Date.now(), log = console }) {
	const entries = await collect({ github, now });
	const messages = renderBoard({ repo: github.repo, entries, forumId, now });
	log.info(`known issues: ${entries.known.length} known, ${entries.next.length} fixed for the next update, ${entries.released.length} fixed in the latest release`);
	return { entries, messages, changed: discord ? await writeBoard({ discord, channel, messages, log }) : 0 };
}

module.exports = { LABEL, sanitise, markers, areaOf, collect, renderBoard, writeBoard, updateBoard, MAX_MESSAGE, FIXED_DAYS };
