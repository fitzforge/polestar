'use strict';
// What the bot writes to GitHub for a #bugs post: the issue's title, body
// and labels, the comments for the thread's follow-ups, and the hidden
// marker that ties an issue to its Discord thread. Pure functions: the
// Discord message goes in, Markdown comes out.
//
// The repository is public and the text is the player's, so it is made
// inert first: Discord's mention syntax becomes names, and nothing in it can
// mention a GitHub user, link another issue, write HTML or forge the marker.

// The bot's marker is always the body's last line; one anywhere else is
// player text (or a stranger's) and is never read.
const MARKER = /(?:^|\n)<!-- polestar-bot (\{[^\n]*\}) -->$/;
const FOLLOWUP_MARK = '<!-- polestar-bot:followup -->';

const COLORS = {
	discord: '5865F2',
	triage: 'FBCA04',
	bug: 'd73a4a',
	version: '0E8A16',
	guide: 'C5DEF5',
	locale: 'EDEDED',
	tag: 'BFD4F2',
	error: 'B60205',
	released: '1D76DB',
};

const LABEL_INFO = {
	discord: { color: COLORS.discord, description: 'Reported in the Discord #bugs forum' },
	triage: { color: COLORS.triage, description: 'Not looked at yet' },
	bug: { color: COLORS.bug, description: "Something isn't working" },
	'lua-error': { color: COLORS.error, description: 'The report lists Lua errors' },
	'from-chat': { color: COLORS.discord, description: 'Filed with !report or !suggest from a Discord message outside #bugs' },
	enhancement: { color: 'a2eeef', description: 'New feature or request' },
	idea: { color: 'a2eeef', description: 'A player\u2019s suggestion' },
};

// The info for a label the bot may create: known ones, then by prefix.
function labelInfo(name) {
	if (LABEL_INFO[name]) return LABEL_INFO[name];
	if (/^v\d/.test(name)) return { color: COLORS.version, description: 'Polestar version the report came from' };
	if (name.startsWith('guide:')) return { color: COLORS.guide, description: 'Guide the report came from' };
	if (name.startsWith('locale:')) return { color: COLORS.locale, description: 'Game locale of the report' };
	if (name.startsWith('released:')) return { color: COLORS.released, description: 'The fix shipped in this release' };
	return { color: COLORS.tag, description: 'Discord forum tag' };
}

// Discord's markup as a reader sees it: <@id> as @name, <#id> as #channel,
// <:emoji:id> as :emoji:. `mentions` is the message's mentions array.
function discordToText(content, mentions = []) {
	const names = new Map(mentions.map((u) => [u.id, u.global_name || u.username]));
	return String(content || '')
		.replace(/<@!?(\d+)>/g, (_, id) => '@' + (names.get(id) || 'user'))
		.replace(/<@&\d+>/g, '@role')
		.replace(/<#\d+>/g, '#channel')
		.replace(/<a?:(\w+):\d+>/g, ':$1:')
		.replace(/<t:(\d+)(?::\w)?>/g, (_, t) => new Date(Number(t) * 1000).toISOString());
}

// Player text made inert for GitHub Markdown.
function inert(text) {
	return String(text)
		.replace(/&/g, '&amp;')
		.replace(/</g, '&lt;')
		.replace(/>/g, '&gt;')
		.replace(/@(?=[\w-])/g, '@\u200d')
		.replace(/#(?=\d)/g, '#\u200d');
}

// A table cell: inert, one line, pipes escaped.
function cell(text) {
	return inert(text).replace(/\|/g, '\\|').replace(/\s*\n\s*/g, ' ');
}

function quote(text) {
	return inert(text).split('\n').map((l) => (l ? '> ' + l : '>')).join('\n');
}

// A code block that the text cannot close early, and in which no HTML
// comment opens (so it cannot hide a marker from the reader).
function fence(text, lang = 'text') {
	const body = String(text).replace(/<!--/g, '<\u200b!--');
	const longest = Math.max(2, ...(body.match(/`+/g) || []).map((s) => s.length));
	const ticks = '`'.repeat(longest + 1);
	return `${ticks}${lang}\n${body}\n${ticks}`;
}

function marker(data) {
	return `<!-- polestar-bot ${JSON.stringify(data)} -->`;
}

// The marker's data from an issue body's last line, or null.
function readMarker(body) {
	const m = String(body || '').trimEnd().match(MARKER);
	if (!m) return null;
	try {
		const data = JSON.parse(m[1]);
		return typeof data.thread === 'string' && /^\d+$/.test(data.thread) ? data : null;
	} catch {
		return null;
	}
}

const labelNames = (issue) => (issue.labels || []).map((l) => (typeof l === 'string' ? l : l.name));

// The marker of an issue the bot filed, or null. Only maintainers and the
// bot can label an issue `discord`, so an issue opened on GitHub with a
// marker of its own is not trusted. `login`: the bot's GitHub account
// (BOT_GITHUB_LOGIN), checked against the issue's author when set.
function issueMarker(issue, login = (process.env.BOT_GITHUB_LOGIN || '').trim() || null) {
	if (!issue || issue.pull_request || !labelNames(issue).includes('discord')) return null;
	if (login && !(issue.user && issue.user.login === login)) return null;
	return readMarker(issue.body);
}

function threadUrl(guild, thread, message) {
	return `https://discord.com/channels/${guild}/${thread}` + (message ? `/${message}` : '');
}

// A post's title as an issue title: the whole title, a link in it kept as
// text (a Markdown link as "its text (its address)", Discord's <address>
// without the brackets). A player who pasted the report into the title box
// gets their words alone: no bold lead-in, nothing from the code block on,
// their first line only. Discord's titles stop at 100 characters; GitHub's at
// 256, the only cut (never inside a character).
const MAX_TITLE = 256;
function issueTitle(name, fallback = 'Bug report from Discord') {
	const words = String(name || '')
		.replace(/```[\s\S]*$/, '')
		.replace(/^\s*\*\*[^*\n]{1,60}[:：]\*\*\s*/, '')
		.trim()
		.split('\n')[0]
		.replace(/\[([^\]\n]+)\]\(<?(https?:\/\/[^\s)>]+)>?\)/g, '$1 ($2)')
		.replace(/<(https?:\/\/[^\s>]+)>/g, '$1')
		.replace(/\s+/g, ' ')
		.trim();
	const t = Array.from(words || fallback);
	return t.length > MAX_TITLE ? t.slice(0, MAX_TITLE - 3).join('').trimEnd() + '...' : t.join('');
}

// The report's text is the player's, so a label is made from it only when it
// has the shape of a real one: a release version, a guide id, a game locale.
const LABEL_VERSION = /^\d{1,2}\.\d{1,3}\.\d{1,3}(?:-(?:alpha|beta|rc|test)\.\d{1,3})?$/;
const LABEL_GUIDE = /^[a-z0-9]+(?:[-_][a-z0-9]+){0,8}$/;
const LOCALES = new Set(['enUS', 'enGB', 'enCN', 'enTW', 'deDE', 'esES', 'esMX', 'frFR', 'itIT', 'koKR', 'ptBR', 'ptPT', 'ruRU', 'zhCN', 'zhTW']);

// Labels for a post: always discord, triage and bug, then what the report
// and the post's forum tags (set by the server's admins) say.
function labelsFor(report, forumTags = []) {
	const labels = ['discord', 'triage', 'bug'];
	const d = report && report.details;
	if (d) {
		if (d.version && LABEL_VERSION.test(d.version)) labels.push('v' + d.version);
		const guide = d.guideId && d.guideId.split('/').pop();
		if (guide && guide.length <= 44 && LABEL_GUIDE.test(guide)) labels.push('guide:' + guide);
		if (d.locale && LOCALES.has(d.locale)) labels.push('locale:' + d.locale);
		if (d.errors && d.errors.length) labels.push('lua-error');
	}
	labels.push(...tagLabels(forumTags));
	return [...new Set(labels.map((l) => l.slice(0, 50)))];
}

// The labels a post's forum tags (set by the server's admins) give: each
// tag's name as a label, in a label's own words.
function tagLabels(forumTags) {
	const out = [];
	for (const t of forumTags) {
		const name = t.toLowerCase().replace(/[^\p{L}\p{N} _-]/gu, '').trim().replace(/\s+/g, '-');
		if (name) out.push(name);
	}
	return out;
}

// Labels for a whole suggestions-forum post filed with `!suggest`: always
// discord, triage, enhancement and idea, then the post's forum tags as a
// #bugs post's are.
function ideaLabels(forumTags = []) {
	return [...new Set(['discord', 'triage', 'enhancement', 'idea', ...tagLabels(forumTags)].map((l) => l.slice(0, 50)))];
}

function summaryTable(d) {
	const rows = [];
	rows.push(['Polestar', [d.version, d.stage].filter(Boolean).join(' ')]);
	if (d.client) rows.push(['Client', `${d.client} (${d.build}) · ${d.locale}`]);
	if (d.character) rows.push(['Character', d.character]);
	if (d.guideId) {
		let g = (d.guideTitle ? d.guideTitle + ' · ' : '') + d.guideId;
		if (d.pack) g += ' · ' + d.pack;
		rows.push(['Guide', g]);
	}
	if (d.step) {
		let s = `${d.step} of ${d.stepCount}` + (d.stepTitle ? `: ${d.stepTitle}` : '');
		if (d.liveStep && d.liveStep !== d.step) s += ` (the guide is at step ${d.liveStep})`;
		rows.push(['Step', s]);
	}
	if (d.zone) rows.push(['Where', d.zone + (d.map ? ` · map ${d.map}` : '')]);
	if (d.routes) rows.push(['Routes', d.routes]);
	if (d.settings) rows.push(['Settings', settingsSummary(d.settings)]);
	rows.push(['Errors', d.errors.length ? d.errors.map((e) => `${e.count}x ${e.message}`).join(' / ') : 'none']);
	return ['| | |', '|---|---|', ...rows.map(([k, v]) => `| ${k} | ${cell(v)} |`)].join('\n');
}

// "23 changed · profile Raid (character)", or "all defaults · ...".
function settingsSummary(s) {
	const what = s.count ? `${s.count} changed` : 'all defaults';
	return s.profile ? `${what} · profile ${s.profile} (${s.source})` : what;
}

// The settings the player changed, unfolded under the summary: one a line,
// "key = value (default d)", in the report's order (what most often changes
// what Polestar does first, the looks last), then what the report could not
// carry. Null when every setting is at its default.
function settingsSection(s) {
	if (!s || (!s.entries.length && !s.looks)) return null;
	const lines = s.entries.map((e) => `${e.key} = ${e.value}` + (e.default != null ? ` (default ${e.default})` : ''));
	if (!s.unfolded) {
		if (s.looks) lines.push(`looks: ${s.looks}`);
		if (s.more) lines.push(`+${s.more} more the report had no room for (#${s.hash})`);
		if (s.damaged) lines.push('(the packed settings line did not unfold: damaged or cut short)');
	}
	return [`<details><summary>Settings: ${inert(settingsSummary(s)).replace(/\s+/g, ' ')}</summary>`, '', fence(lines.join('\n')), '', '</details>'].join('\n');
}

// A message's files: images embedded, the rest as links: the copy on the
// media branch, else the Discord message, with why it was not copied.
function mediaSection(files) {
	const out = [];
	for (const f of files) {
		if (f.url && f.image) out.push(`![${cell(f.name)}](${f.url})`);
		else if (f.url) out.push(`- [${cell(f.name)}](${f.url})` + (f.video ? ' (video)' : ''));
		else out.push(`- [${cell(f.name)}](${f.discordUrl}) (on Discord${f.note ? `: ${f.note}` : ''})`);
	}
	return out.join('\n\n');
}

// The issue body. `post`: { report, reporter, guild, thread, tags, files }.
// `kind` 'suggestion': a suggestions-forum post's ("Suggested by").
function issueBody(post) {
	const { report, reporter, guild, thread, tags = [], files = [], kind = 'report' } = post;
	const out = [];
	let head = `**${kind === 'suggestion' ? 'Suggested' : 'Reported'} by ${cell(reporter)} on [Discord](${threadUrl(guild, thread)})**`;
	if (tags.length) head += ' · ' + tags.map(cell).join(', ');
	out.push(head, '');
	out.push(report.description ? quote(report.description) : '_No description._', '');
	if (report.details) {
		out.push(summaryTable(report.details), '');
		const settings = settingsSection(report.details.settings);
		if (settings) out.push(settings, '');
		out.push('<details><summary>Full report</summary>', '', fence(report.block), '', '</details>', '');
	}
	if (files.length) out.push('### Screenshots', '', mediaSection(files), '');
	out.push(marker({ thread, guild }));
	return out.join('\n');
}

// A follow-up in the thread, as an issue comment: the reporter's, or
// another player's.
function followUpComment(msg) {
	const { report, author, reporter = false, guild, thread, message, files = [] } = msg;
	const head = reporter ? `**${cell(author)}** (the reporter) added on` : `**${cell(author)}** commented on`;
	const out = [`${head} [Discord](${threadUrl(guild, thread, message)}):`, ''];
	if (report.description) out.push(quote(report.description), '');
	if (report.details) out.push(fence(report.block), '');
	if (files.length) out.push(mediaSection(files), '');
	out.push(FOLLOWUP_MARK);
	return out.join('\n');
}

// The Discord message a follow-up comment was copied from, or null: read
// from the comment's first line (the bot's own, before any player text) and
// only when the comment ends in the follow-up mark and links `thread`.
// `login`: the bot's GitHub account (BOT_GITHUB_LOGIN), checked against the
// comment's author when set, as for the issue marker.
const FOLLOWUP_HEAD = /^\*\*.*\*\* (?:\(the reporter\) added|commented) on \[Discord\]\(https:\/\/discord\.com\/channels\/\d+\/(\d+)\/(\d+)\):$/;
function followUpMessage(comment, thread, login = (process.env.BOT_GITHUB_LOGIN || '').trim() || null) {
	if (!comment || (login && !(comment.user && comment.user.login === login))) return null;
	const text = String(comment.body || '').trimEnd();
	if (!text.endsWith(FOLLOWUP_MARK)) return null;
	const m = FOLLOWUP_HEAD.exec(text.split('\n', 1)[0]);
	return m && m[1] === thread ? m[2] : null;
}

// The bot's reply in the thread once the issue exists, and that reply read
// back. A suggestions post's says it will hear when the idea moves.
function trackedReply(repo, number, idea = false) {
	const link = `[${repo}#${number}](<https://github.com/${repo}/issues/${number}>)`;
	return `Tracked as ${link}. Replies in this thread, from anyone, are copied to the issue. ` + (idea ? "We'll reply here as this idea moves." : "We'll reply here when it's fixed.");
}

function readTrackedReply(content, repo) {
	const esc = repo.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
	const m = String(content || '').match(new RegExp(`github\\.com/${esc}/issues/(\\d+)`));
	return m ? Number(m[1]) : null;
}

// The bot's reply to a post held by the hourly limit (edited into the
// tracked reply once it is filed), and that reply recognised again.
const HELD_LEAD = "Thanks! You've sent a few reports this hour";
function heldReply(minutes) {
	const m = Math.max(1, Math.ceil(minutes));
	return `${HELD_LEAD}; this one will be filed automatically in about ${m} minute${m === 1 ? '' : 's'}.`;
}

const isHeldReply = (content) => String(content || '').startsWith(HELD_LEAD);

// Filed from chat by the maintainer (`!report`, `!suggest`): labels, the
// issue body, and the #bugs post the bot starts for the follow-ups.

const MAX_BODY = 60000; // GitHub takes 65536 characters

function chatLabels(kind, report) {
	const base = kind === 'suggestion' ? ['discord', 'triage', 'enhancement', 'idea'] : labelsFor(report);
	return [...new Set([...base, 'from-chat'])];
}

const utc = (ms) => new Date(ms).toISOString().replace('T', ' ').slice(0, 16) + ' UTC';

// A link a player pasted (an embed's), when it is a plain web address.
function linkLine(link) {
	if (!/^https?:\/\/[^\s]+$/.test(link.url || '')) return null;
	const url = link.url.replace(/[()<>]/g, encodeURIComponent);
	return `- [${cell(link.title || link.url)}](${url})`;
}

// The issue body. `post`: { kind, reporter, guild, channel, channelName,
// message (the one replied to), thread (the #bugs post), messages: [{ id,
// at, report, files, links }] }, the messages oldest first.
function chatIssueBody(post) {
	const { kind, reporter, guild, channel, channelName, message, thread, messages } = post;
	const verb = kind === 'suggestion' ? 'Suggested' : 'Reported';
	const where = channelName ? `#${cell(channelName)}` : 'chat';
	const head = [
		`**${verb} by ${cell(reporter)} on [Discord](${threadUrl(guild, channel, message)})**`,
		`_Filed from ${where} on Discord; follow-ups go to [its #bugs post](${threadUrl(guild, thread)})._`,
		'',
	].join('\n');
	const first = messages.find((m) => m.report.details);
	const tail = [];
	if (first) {
		tail.push(summaryTable(first.report.details), '');
		tail.push('<details><summary>Full report</summary>', '', fence(first.report.block), '', '</details>', '');
	}
	const blocks = [];
	let size = head.length + tail.join('\n').length + 300;
	const included = [];
	for (const m of messages) {
		const out = [`[${utc(m.at)}](${threadUrl(guild, channel, m.id)})`];
		if (m.report.description) out.push(quote(m.report.description));
		if (m.report.details && m !== first) out.push('', fence(m.report.block));
		if (m.files.length) out.push('', mediaSection(m.files));
		const links = (m.links || []).map(linkLine).filter(Boolean);
		if (links.length) out.push('', links.join('\n'));
		const block = out.join('\n') + '\n';
		if (size + block.length > MAX_BODY) break;
		size += block.length + 1;
		blocks.push(block);
		included.push(m.id);
	}
	const left = messages.length - included.length;
	if (left) blocks.push(`_${left} more message${left === 1 ? '' : 's'} not included: too long for an issue._\n`);
	return [head, blocks.join('\n'), ...tail, marker({ thread, guild, messages: included })].join('\n');
}

// The first message of the #bugs post the bot starts: who it is from (the
// player is pinged, and read back from here to be pinged again), where it
// was said, their words, and `links`: copied media not attached to the
// post, one per line so Discord previews them. Under Discord's 2000
// characters: the links first, the words cut to what is left.
function chatPostStarter({ kind, reporterId, jump, text, links = [] }) {
	const verb = kind === 'suggestion' ? 'Suggested' : 'Reported';
	const head = `**${verb} by <@${reporterId}>** in ${jump}`;
	const foot = '-# Filed from chat by a maintainer. Replies here are copied to the issue.';
	const shown = [];
	let room = 1990 - head.length - foot.length - 400;
	for (const url of links) {
		if (url.length + 1 > room - 40) break;
		shown.push(url);
		room -= url.length + 1;
	}
	if (shown.length < links.length) shown.push(`-# ${links.length - shown.length} more on the issue`);
	const media = shown.join('\n');
	const most = Math.min(1200, 1990 - head.length - foot.length - media.length - 10);
	const words = String(text || '').trim();
	let quoted = words ? words.split('\n').map((l) => `> ${l}`).join('\n') : '';
	if (quoted.length > most) quoted = quoted.slice(0, most).trimEnd() + '\u2026';
	const out = [head];
	if (quoted) out.push(quoted);
	if (media) out.push(media);
	out.push(foot);
	return out.join('\n');
}

// The player a #bugs post the bot started is for, from its first message, or null.
function reportedBy(message) {
	if (!message || !message.author || !message.author.bot) return null;
	const m = /^\*\*(?:Reported|Suggested) by <@!?([^>\s]+)>\*\*/.exec(message.content || '');
	return m ? m[1] : null;
}

module.exports = {
	FOLLOWUP_MARK,
	discordToText,
	inert,
	fence,
	marker,
	readMarker,
	threadUrl,
	issueTitle,
	labelsFor,
	ideaLabels,
	labelInfo,
	issueBody,
	followUpComment,
	followUpMessage,
	trackedReply,
	readTrackedReply,
	heldReply,
	isHeldReply,
	issueMarker,
	chatLabels,
	chatIssueBody,
	chatPostStarter,
	reportedBy,
	labelNames,
};
