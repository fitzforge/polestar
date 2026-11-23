'use strict';
// In-memory Discord and GitHub for the bug bot's tests: the calls
// tools/discord-bot/lib makes, over plain maps, recording what was written.

const FORUM = '900';
const GUILD = '800';
const BOT = '700';
const TAGS = [
	{ id: 't-questing', name: 'Questing' },
	{ id: 't-tracked', name: 'Tracked', moderated: true },
	{ id: 't-fixed', name: 'Fixed', moderated: true },
	{ id: 't-wontfix', name: 'Won\u2019t fix', moderated: true },
	{ id: 't-dup', name: 'Duplicate', moderated: true },
];

function httpError(status) {
	const err = new Error(`HTTP ${status}`);
	err.status = status;
	return err;
}

function fakeDiscord() {
	const channels = new Map([[FORUM, { id: FORUM, type: 15, name: 'bugs', guild_id: GUILD, available_tags: TAGS }]]);
	const messages = new Map(); // channel -> [message]
	const sent = [];
	const edits = [];
	const requests = []; // raw REST calls: slash command registration and interaction replies
	let nextId = 5000;
	// The server: @everyone (the guild's id) with no staff bits, a Moderator
	// role (Manage Messages) and an Admin role (Administrator). `members`: user id -> role ids.
	const guild = { id: GUILD, owner_id: 'owner', roles: [{ id: GUILD, permissions: '1024' }, { id: 'r-mod', permissions: String(1 << 13) }, { id: 'r-admin', permissions: '8' }] };
	const members = new Map();
	return {
		channels,
		messages,
		sent,
		edits,
		requests,
		guild,
		members,
		async getGuild(id) {
			if (id !== GUILD) throw httpError(404);
			return structuredClone(guild);
		},
		async request(method, path, body) {
			requests.push({ method, path, body });
			return null;
		},
		// A forum post: its thread and its first message (same id).
		post(id, { owner = 'u1', name = 'A bug', content = '', tags = [], attachments = [], meta = {}, author = {} } = {}) {
			channels.set(id, { id, parent_id: FORUM, guild_id: GUILD, owner_id: owner, name, applied_tags: tags, thread_metadata: meta });
			const msg = { id, channel_id: id, content, attachments, mentions: [], author: { id: owner, username: 'savagehands', global_name: 'SavageHands', ...author } };
			messages.set(id, [msg]);
			return msg;
		},
		// A message as the gateway gives it: with the author's member roles
		// when they are in `members`. `type`: 0 a message, 19 a reply, 4 a rename.
		say(thread, { author = 'u1', content = '', attachments = [], bot = false, type = 0 } = {}) {
			const msg = { id: String(nextId++), type, channel_id: thread, content, attachments, mentions: [], author: { id: author, username: 'someone', bot } };
			if (members.has(author)) msg.member = { roles: [...members.get(author)] };
			messages.get(thread).push(msg);
			return msg;
		},
		async getChannel(id) {
			if (!channels.has(id)) throw httpError(404);
			return structuredClone(channels.get(id));
		},
		async getMessage(channel, id) {
			const m = (messages.get(channel) || []).find((x) => x.id === id);
			if (!m) throw httpError(404);
			return structuredClone(m);
		},
		// Newest first, `limit` at a time, older than `before` when given.
		async getMessages(channel, limit = 50, before = null) {
			const all = [...(messages.get(channel) || [])].reverse().filter((m) => !before || BigInt(m.id) < BigInt(before));
			return structuredClone(all.slice(0, limit));
		},
		async getMember(guildId, user) {
			if (guildId !== GUILD || !members.has(user)) throw httpError(404);
			return { roles: [...members.get(user)] };
		},
		async activeThreads() {
			return { threads: [...channels.values()].filter((c) => c.parent_id) };
		},
		async send(channel, content, users = [], roles = []) {
			sent.push({ channel, content, users, roles });
			const msg = { id: String(nextId++), channel_id: channel, content, attachments: [], mentions: [], author: { id: BOT, username: 'Polestar Bot', bot: true } };
			if (messages.has(channel)) messages.get(channel).push(msg);
			return msg;
		},
		// The bot's own message rewritten; recorded in `edits` as { channel, message, content }.
		async editMessage(channel, id, content) {
			const m = (messages.get(channel) || []).find((x) => x.id === id);
			if (!m) throw httpError(404);
			m.content = content;
			edits.push({ channel, message: id, content });
			return structuredClone(m);
		},
		async me() {
			return { id: BOT, username: 'Polestar Bot', bot: true };
		},
		async deleteMessage(channel, id) {
			const list = messages.get(channel) || [];
			const i = list.findIndex((x) => x.id === id);
			if (i < 0) throw httpError(404);
			list.splice(i, 1);
			edits.push({ channel, message: id, deleted: true });
		},
		async editThread(id, fields) {
			edits.push({ id, ...fields });
			const c = channels.get(id);
			if (fields.applied_tags) c.applied_tags = fields.applied_tags;
			if ('locked' in fields || 'archived' in fields) c.thread_metadata = { ...c.thread_metadata, ...('locked' in fields ? { locked: fields.locked } : {}), ...('archived' in fields ? { archived: fields.archived } : {}) };
			return c;
		},
	};
}

function fakeGitHub(repo = 'fitzforge/polestar') {
	const issues = [];
	const comments = new Map();
	const labels = new Set();
	const releases = [];
	const files = new Map(); // `${ref}:${path}` -> text: the repository at a tag
	const timelines = new Map(); // issue number -> timeline events
	const pulls = new Map(); // pull request number -> { merge_commit_sha }
	const tagCommits = new Map(); // tag -> Set of the commits it holds
	let commentIds = 0;
	return {
		repo,
		commentsByIssue: comments,
		issues,
		labels,
		releasesList: releases,
		files,
		timelines,
		pulls,
		tagCommits,
		async ensureLabels(names) {
			for (const n of names) labels.add(n);
		},
		async createIssue({ title, body, labels: ls }) {
			const issue = { number: issues.length + 1, title, body, labels: ls.map((name) => ({ name })), state: 'open', state_reason: null, closed_at: null };
			issues.push(issue);
			return issue;
		},
		async getIssue(n) {
			if (!issues[n - 1]) throw httpError(404);
			return structuredClone(issues[n - 1]);
		},
		async updateIssue(n, fields) {
			Object.assign(issues[n - 1], fields);
			return issues[n - 1];
		},
		async removeLabel(n, name) {
			issues[n - 1].labels = issues[n - 1].labels.filter((l) => l.name !== name);
		},
		async comment(n, body) {
			if (!comments.has(n)) comments.set(n, []);
			comments.get(n).push({ id: ++commentIds, body, author_association: 'OWNER', user: { type: 'User' } });
		},
		async comments(n) {
			return structuredClone(comments.get(n) || []);
		},
		async editComment(id, body) {
			const c = [...comments.values()].flat().find((x) => x.id === id);
			if (!c) throw httpError(404);
			c.body = body;
			return c;
		},
		async addLabels(n, ls) {
			issues[n - 1].labels.push(...ls.map((name) => ({ name })));
		},
		async issuesLabelled(label, { state = 'all' } = {}) {
			return issues
				.filter((i) => i.labels.some((l) => l.name === label) && (state === 'all' || i.state === state))
				.map((i) => structuredClone(i))
				.reverse();
		},
		// GitHub's duplicate marker: the issue's duplicate_of field here.
		async duplicateOf(n) {
			return (issues[n - 1] && issues[n - 1].duplicate_of) || null;
		},
		// The search qualifiers the bot uses: is:closed, label:, reason:duplicate
		// and a quoted phrase in a comment.
		async searchIssues(q) {
			const label = /label:(\S+)/.exec(q);
			const phrase = /"([^"]+)"/.exec(q);
			return issues
				.filter((i) => (!q.includes('is:closed') || i.state === 'closed') &&
					(!label || i.labels.some((l) => l.name === label[1])) &&
					(!q.includes('reason:duplicate') || i.state_reason === 'duplicate') &&
					(!phrase || (comments.get(i.number) || []).some((c) => c.body.toLowerCase().includes(phrase[1].toLowerCase()))))
				.map((i) => structuredClone(i))
				.reverse();
		},
		async releases() {
			return releases;
		},
		// GitHub's releases/latest: `latest` when a test sets it (null: none),
		// else the last published release that is no draft or prerelease.
		latest: undefined,
		async latestRelease() {
			if (this.latest !== undefined) return this.latest;
			const full = releases.filter((r) => !r.draft && !r.prerelease);
			return full.sort((a, b) => String(a.published_at || '').localeCompare(String(b.published_at || ''))).pop() || null;
		},
		async timeline(n) {
			return structuredClone(timelines.get(n) || []);
		},
		async pull(n) {
			if (!pulls.has(n)) throw httpError(404);
			return { number: n, ...pulls.get(n) };
		},
		async contains(ref, sha) {
			return (tagCommits.get(ref) || new Set()).has(sha);
		},
		async listDir(dir, ref) {
			const prefix = `${ref}:${dir}/`;
			return [...files.keys()]
				.filter((k) => k.startsWith(prefix) && !k.slice(prefix.length).includes('/'))
				.map((k) => ({ name: k.slice(prefix.length), path: k.slice(ref.length + 1), type: 'file' }));
		},
		async readFile(p, ref) {
			return files.has(`${ref}:${p}`) ? files.get(`${ref}:${p}`) : null;
		},
	};
}

// Screenshots "copied": the path they would get on the media branch.
function fakeMedia() {
	const copied = [];
	return {
		copied,
		async copy(path) {
			copied.push(path);
			return `https://raw.githubusercontent.com/fitzforge/polestar/bug-media/${path}`;
		},
	};
}

const quietLog = { info() {}, warn() {}, error() {} };

module.exports = { fakeDiscord, fakeGitHub, fakeMedia, quietLog, FORUM, GUILD, BOT };
