'use strict';
// In-memory Discord and GitHub for the bug bot's tests: the calls
// tools/discord-bot/lib makes, over plain maps, recording what was written.

const FORUM = '900';
const GUILD = '800';
const BOT = '700';
const TAGS = [
	{ id: 't-questing', name: 'Questing' },
	{ id: 't-tracked', name: 'Tracked' },
	{ id: 't-fixed', name: 'Fixed' },
	{ id: 't-wontfix', name: 'Won\u2019t fix' },
	{ id: 't-dup', name: 'Duplicate' },
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
	return {
		channels,
		messages,
		sent,
		edits,
		requests,
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
		say(thread, { author = 'u1', content = '', attachments = [], bot = false } = {}) {
			const msg = { id: String(nextId++), channel_id: thread, content, attachments, mentions: [], author: { id: author, username: 'someone', bot } };
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
		async getMessages(channel) {
			return structuredClone([...(messages.get(channel) || [])].reverse());
		},
		async getMember() {
			throw httpError(404);
		},
		async activeThreads() {
			return { threads: [...channels.values()].filter((c) => c.parent_id) };
		},
		async send(channel, content, users = []) {
			sent.push({ channel, content, users });
			const msg = { id: String(nextId++), channel_id: channel, content, attachments: [], mentions: [], author: { id: BOT, username: 'Polestar Bot', bot: true } };
			if (messages.has(channel)) messages.get(channel).push(msg);
			return msg;
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
	return {
		repo,
		commentsByIssue: comments,
		issues,
		labels,
		releasesList: releases,
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
			comments.get(n).push({ body, author_association: 'OWNER', user: { type: 'User' } });
		},
		async comments(n) {
			return comments.get(n) || [];
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
		async releases() {
			return releases;
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
