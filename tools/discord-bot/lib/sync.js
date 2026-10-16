'use strict';
// Discord #bugs to GitHub issues: a new post becomes an issue, every later
// message in its thread (the reporter's and other players') a comment, an
// edit of the first message its new body.
// The bot keeps no database: an issue's body carries its thread's id (the
// marker), the thread carries the bot's "Tracked as #N" reply, and both are
// read back on start, so a restart neither loses nor repeats a post.
//
// Work on one thread runs one job at a time, so a follow-up that arrives
// while its post is still being filed waits for the issue.

const { parseReport } = require('./report');
const I = require('./issue');
const { statusTags, withStatus } = require('./discord');

const DISCORD_EPOCH = 1420070400000n;

function createdAt(thread) {
	const ts = thread.thread_metadata && thread.thread_metadata.create_timestamp;
	return ts ? Date.parse(ts) : Number((BigInt(thread.id) >> 22n) + DISCORD_EPOCH);
}

function safeName(name) {
	return String(name || 'file').replace(/[^\w.-]+/g, '_').slice(-80);
}

function createSync({ discord, github, media, config, log = console, sleep = (ms) => new Promise((r) => setTimeout(r, ms)) }) {
	const { forumId, since = null } = config;
	const repo = github.repo;
	const issues = new Map(); // thread id -> issue number
	const threads = new Map(); // channel id -> channel (threads, and others as { id, parent_id: null })
	const seen = new Map(); // thread id -> starter content signature last written
	const queues = new Map();
	let forum = null;
	let botId = config.botId || null;

	function serial(id, fn) {
		const prev = queues.get(id) || Promise.resolve();
		const job = prev.then(fn);
		const tail = job.catch(() => {});
		queues.set(id, tail);
		tail.then(() => {
			if (queues.get(id) === tail) queues.delete(id);
		});
		return job;
	}

	async function getForum(refresh) {
		if (!forum || refresh) forum = await discord.getChannel(forumId);
		return forum;
	}

	async function getThread(id, fresh) {
		if (!fresh && threads.has(id)) return threads.get(id);
		let t;
		try {
			t = await discord.getChannel(id);
		} catch (err) {
			if (err.status !== 403 && err.status !== 404) throw err;
			t = { id, parent_id: null };
		}
		threads.set(id, t);
		return t;
	}

	const inForum = (t) => t && t.parent_id === forumId;

	// The issue filed for a thread: known, or found in the bot's reply there.
	async function issueFor(threadId) {
		if (issues.has(threadId)) return issues.get(threadId);
		const messages = await discord.getMessages(threadId, 100);
		for (const m of messages) {
			if (!m.author || !m.author.bot || (botId && m.author.id !== botId)) continue;
			const n = I.readTrackedReply(m.content, repo);
			if (n) {
				issues.set(threadId, n);
				return n;
			}
		}
		return null;
	}

	// A forum post's first message has the thread's id; it can land a moment
	// after the thread.
	async function starter(threadId) {
		for (let attempt = 0; attempt < 5; attempt++) {
			try {
				return await discord.getMessage(threadId, threadId);
			} catch (err) {
				if (err.status !== 404) throw err;
				await sleep(1000);
			}
		}
		return null;
	}

	// The name the server shows: the gateway's member nick, else the API's, else the account's.
	async function displayName(guild, author, member) {
		if (member && member.nick) return member.nick;
		try {
			const m = await discord.getMember(guild, author.id);
			if (m && m.nick) return m.nick;
		} catch {
			// left the server: their account name will do
		}
		return author.global_name || author.username;
	}

	// The message's attachments: images copied to the media branch, the rest linked.
	async function files(guild, threadId, message) {
		const out = [];
		for (const a of message.attachments || []) {
			const image = /^image\//.test(a.content_type || '');
			let url = null;
			if (image) {
				try {
					url = await media.copy(`discord/${threadId}/${a.id}-${safeName(a.filename)}`, a, `Media: screenshot from Discord thread ${threadId}`);
				} catch (err) {
					log.warn(`media: ${a.filename} in ${threadId} not copied: ${err.message}`);
				}
			}
			out.push({ name: a.filename, image, url, discordUrl: I.threadUrl(guild, threadId, message.id) });
		}
		return out;
	}

	const signature = (m) => JSON.stringify([m.content, (m.attachments || []).map((a) => a.id)]);

	async function postFor(thread, message) {
		const f = await getForum();
		const status = new Set(Object.values(statusTags(f)));
		const tagNames = (thread.applied_tags || [])
			.filter((id) => !status.has(id))
			.map((id) => (f.available_tags || []).find((t) => t.id === id))
			.filter(Boolean)
			.map((t) => t.name);
		const report = parseReport(I.discordToText(message.content, message.mentions));
		return {
			report,
			reporter: await displayName(thread.guild_id, message.author),
			guild: thread.guild_id,
			thread: thread.id,
			tags: tagNames,
			files: await files(thread.guild_id, thread.id, message),
		};
	}

	// Files a post. `backfill`: found on start, not seen being made, so
	// closed, old or already handled posts are left alone.
	function newPost(threadId, { backfill = false } = {}) {
		return serial(threadId, async () => {
			if (issues.has(threadId)) return null;
			const thread = await getThread(threadId, true);
			if (!inForum(thread)) return null;
			const meta = thread.thread_metadata || {};
			if (backfill && (meta.locked || meta.archived)) return null;
			if (since && createdAt(thread) < since) return null;
			const tags = statusTags(await getForum());
			const status = new Set(Object.values(tags));
			if ((thread.applied_tags || []).some((id) => status.has(id))) return null;
			if (await issueFor(threadId)) return null;
			const message = await starter(threadId);
			if (!message || message.author.bot) return null;

			const post = await postFor(thread, message);
			const labels = I.labelsFor(post.report, post.tags);
			await github.ensureLabels(labels, I.labelInfo);
			const issue = await github.createIssue({ title: I.issueTitle(thread.name), body: I.issueBody(post), labels });
			issues.set(threadId, issue.number);
			seen.set(threadId, signature(message));
			log.info(`filed #${issue.number} for "${thread.name}" (${threadId})`);

			await discord.send(threadId, I.trackedReply(repo, issue.number));
			if (tags.tracked) {
				await discord.editThread(threadId, { applied_tags: withStatus(thread.applied_tags, tags, 'tracked') });
			}
			return issue.number;
		});
	}

	// A message in a thread: the post itself, or a follow-up, the reporter's
	// or anyone else's (another player's confirmation or a Wowhead link is
	// context for whoever triages the issue).
	async function message(m) {
		if (m.channel_id === m.id) return newPost(m.id);
		if (!m.author || m.author.bot || m.webhook_id) return null;
		const thread = await getThread(m.channel_id);
		if (!inForum(thread)) return null;
		return serial(thread.id, async () => {
			const n = await issueFor(thread.id);
			if (!n) return null;
			const report = parseReport(I.discordToText(m.content, m.mentions));
			const f = await files(thread.guild_id, thread.id, m);
			if (!report.description && !report.details && !f.length) return null;
			const author = await displayName(thread.guild_id, m.author, m.member);
			const reporter = m.author.id === thread.owner_id;
			await github.comment(n, I.followUpComment({ report, author, reporter, guild: thread.guild_id, thread: thread.id, message: m.id, files: f }));
			log.info(`#${n}: added ${author}'s follow-up ${m.id}`);
			return n;
		});
	}

	// An edited message: when it is a tracked post's first one, the issue
	// body is written again. Edits that only add link previews change nothing.
	async function edit(m) {
		if (m.channel_id !== m.id) return null;
		const thread = await getThread(m.id);
		if (!inForum(thread)) return null;
		return serial(m.id, async () => {
			const n = await issueFor(m.id);
			if (!n) return null;
			const message = await discord.getMessage(m.id, m.id);
			if (seen.get(m.id) === signature(message)) return null;
			const fresh = await getThread(m.id, true);
			await github.updateIssue(n, { body: I.issueBody(await postFor(fresh, message)) });
			seen.set(m.id, signature(message));
			log.info(`#${n}: body updated from an edit`);
			return n;
		});
	}

	// Every filed issue written again from its post as it stands: title, body,
	// and the labels the report and tags give (added; none taken away, triage
	// not put back). For after a change to how posts are read.
	async function refresh() {
		let done = 0;
		for (const [threadId, n] of issues) {
			try {
				await serial(threadId, async () => {
					const thread = await getThread(threadId, true);
					if (!inForum(thread)) return;
					const message = await starter(threadId);
					if (!message) return;
					const post = await postFor(thread, message);
					const labels = I.labelsFor(post.report, post.tags).filter((l) => l !== 'triage');
					await github.ensureLabels(labels, I.labelInfo);
					await github.updateIssue(n, { title: I.issueTitle(thread.name), body: I.issueBody(post) });
					await github.addLabels(n, labels);
					seen.set(threadId, signature(message));
					done++;
				});
			} catch (err) {
				log.error(`refresh: #${n} failed:`, err.message);
			}
		}
		log.info(`refresh: ${done} of ${issues.size} issues rewritten`);
	}

	// Issues the bot filed before, read back from their markers.
	async function loadIndex() {
		for (const issue of await github.issuesLabelled('discord', { max: 1000 })) {
			const mk = I.readMarker(issue.body);
			if (mk && !issues.has(mk.thread)) issues.set(mk.thread, issue.number);
		}
		log.info(`index: ${issues.size} issues already filed from Discord`);
	}

	// Open posts made while the bot was away.
	async function backfill() {
		const f = await getForum(true);
		const { threads: active = [] } = await discord.activeThreads(f.guild_id);
		const mine = active.filter((t) => t.parent_id === forumId).sort((a, b) => (BigInt(a.id) < BigInt(b.id) ? -1 : 1));
		let filed = 0;
		for (const t of mine) {
			threads.set(t.id, t);
			try {
				if (await newPost(t.id, { backfill: true })) filed++;
			} catch (err) {
				log.error(`backfill: ${t.id} failed:`, err.message);
			}
		}
		log.info(`backfill: ${mine.length} open posts, ${filed} filed`);
	}

	function dispatch(type, d) {
		const run = (p) => Promise.resolve(p).catch((err) => log.error(`${type}:`, err.message));
		switch (type) {
			case 'READY':
				botId = d.user.id;
				log.info(`connected as ${d.user.username}`);
				return run(backfill());
			case 'GUILD_CREATE':
				for (const c of d.channels || []) threads.set(c.id, { id: c.id, parent_id: null });
				for (const t of d.threads || []) threads.set(t.id, { ...t, guild_id: d.id });
				return null;
			case 'THREAD_CREATE':
			case 'THREAD_UPDATE':
				threads.set(d.id, d);
				if (type === 'THREAD_CREATE' && d.parent_id === forumId && d.newly_created) return run(newPost(d.id));
				return null;
			case 'MESSAGE_CREATE':
				return run(message(d));
			case 'MESSAGE_UPDATE':
				return run(edit(d));
			default:
				return null;
		}
	}

	return { dispatch, loadIndex, backfill, refresh, newPost, message, edit, issues, issueFor };
}

module.exports = { createSync };
