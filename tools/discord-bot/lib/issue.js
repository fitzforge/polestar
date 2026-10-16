'use strict';
// What the bot writes to GitHub for a #bugs post: the issue's title, body
// and labels, the comments for the thread's follow-ups, and the hidden
// marker that ties an issue to its Discord thread. Pure functions: the
// Discord message goes in, Markdown comes out.
//
// The repository is public and the text is the player's, so it is made
// inert first: Discord's mention syntax becomes names, and nothing in it can
// mention a GitHub user, link another issue, write HTML or forge the marker.

const MARKER = /<!-- polestar-bot (\{[^\n]*?\}) -->/;
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

// A code block that the text cannot close early.
function fence(text, lang = 'text') {
	const longest = Math.max(2, ...(String(text).match(/`+/g) || []).map((s) => s.length));
	const ticks = '`'.repeat(longest + 1);
	return `${ticks}${lang}\n${text}\n${ticks}`;
}

function marker(data) {
	return `<!-- polestar-bot ${JSON.stringify(data)} -->`;
}

// The marker's data from an issue body, or null.
function readMarker(body) {
	const m = String(body || '').match(MARKER);
	if (!m) return null;
	try {
		const data = JSON.parse(m[1]);
		return typeof data.thread === 'string' && /^\d+$/.test(data.thread) ? data : null;
	} catch {
		return null;
	}
}

function threadUrl(guild, thread, message) {
	return `https://discord.com/channels/${guild}/${thread}` + (message ? `/${message}` : '');
}

// A post's title as an issue title. A player who pasted the report into the
// title box gets their words alone: no bold lead-in, nothing from the code block on.
function issueTitle(name) {
	const t = String(name || '')
		.replace(/```[\s\S]*$/, '')
		.replace(/^\s*\*\*[^*\n]{1,60}:\*\*\s*/, '')
		.replace(/\s+/g, ' ')
		.trim() || 'Bug report from Discord';
	return t.length > 200 ? t.slice(0, 197) + '...' : t;
}

// Labels for a post: always discord, triage and bug, then what the report
// and the post's forum tags say.
function labelsFor(report, forumTags = []) {
	const labels = ['discord', 'triage', 'bug'];
	const d = report && report.details;
	if (d) {
		if (d.version && d.version !== 'dev') labels.push('v' + d.version);
		if (d.guideId) labels.push('guide:' + d.guideId.split('/').pop());
		if (d.locale && d.locale !== '?') labels.push('locale:' + d.locale);
		if (d.errors && d.errors.length) labels.push('lua-error');
	}
	for (const t of forumTags) {
		const name = t.toLowerCase().replace(/[^\p{L}\p{N} _-]/gu, '').trim().replace(/\s+/g, '-');
		if (name) labels.push(name);
	}
	return [...new Set(labels.map((l) => l.slice(0, 50)))];
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
	rows.push(['Errors', d.errors.length ? d.errors.map((e) => `${e.count}x ${e.message}`).join(' / ') : 'none']);
	return ['| | |', '|---|---|', ...rows.map(([k, v]) => `| ${k} | ${cell(v)} |`)].join('\n');
}

function mediaSection(files) {
	const out = [];
	for (const f of files) {
		if (f.url && f.image) out.push(`![${cell(f.name)}](${f.url})`);
		else out.push(`- [${cell(f.name)}](${f.url || f.discordUrl})` + (f.url ? '' : ' (on Discord)'));
	}
	return out.join('\n\n');
}

// The issue body. `post`: { report, reporter, guild, thread, tags, files }.
function issueBody(post) {
	const { report, reporter, guild, thread, tags = [], files = [] } = post;
	const out = [];
	let head = `**Reported by ${cell(reporter)} on [Discord](${threadUrl(guild, thread)})**`;
	if (tags.length) head += ' · ' + tags.map(cell).join(', ');
	out.push(head, '');
	out.push(report.description ? quote(report.description) : '_No description._', '');
	if (report.details) {
		out.push(summaryTable(report.details), '');
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

// The bot's reply in the thread once the issue exists, and that reply read back.
function trackedReply(repo, number) {
	return `Tracked as [${repo}#${number}](<https://github.com/${repo}/issues/${number}>). We'll reply here when it's fixed.`;
}

function readTrackedReply(content, repo) {
	const esc = repo.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
	const m = String(content || '').match(new RegExp(`github\\.com/${esc}/issues/(\\d+)`));
	return m ? Number(m[1]) : null;
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
	labelInfo,
	issueBody,
	followUpComment,
	trackedReply,
	readTrackedReply,
};
