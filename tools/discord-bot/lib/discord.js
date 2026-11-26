'use strict';
// Discord's REST API, the few calls the bot and the GitHub Actions make.
// Waits out rate limits (429, retry_after) and retries server errors; any
// other failure throws with Discord's message.

const API = process.env.DISCORD_API || 'https://discord.com/api/v10';

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

class DiscordError extends Error {
	constructor(status, body, what) {
		super(`Discord ${what}: ${status} ${body && body.message ? body.message : ''}`.trim());
		this.status = status;
		this.code = body && body.code;
	}
}

function createDiscord({ token, api = API, fetch: fetchImpl = fetch }) {
	if (!token) throw new Error('DISCORD_TOKEN is not set');

	// `files` ({ name, type, data }): sent as attachments, the body as payload_json.
	async function request(method, path, body, attempt = 0, files = null) {
		const headers = {
			Authorization: `Bot ${token}`,
			'User-Agent': 'DiscordBot (https://github.com/fitzforge/polestar, 1)',
		};
		let payload;
		if (files && files.length) {
			payload = new FormData();
			payload.append('payload_json', JSON.stringify(body));
			files.forEach((f, i) => payload.append(`files[${i}]`, new Blob([f.data], { type: f.type || 'application/octet-stream' }), f.name));
		} else {
			headers['Content-Type'] = 'application/json';
			payload = body === undefined ? undefined : JSON.stringify(body);
		}
		const res = await fetchImpl(api + path, { method, headers, body: payload });
		if (res.status === 204) return null;
		const data = await res.json().catch(() => null);
		if (res.status === 429 && attempt < 5) {
			await sleep(Math.ceil(((data && data.retry_after) || 1) * 1000));
			return request(method, path, body, attempt + 1, files);
		}
		if (res.status >= 500 && attempt < 3) {
			await sleep(1000 * 2 ** attempt);
			return request(method, path, body, attempt + 1, files);
		}
		if (!res.ok) throw new DiscordError(res.status, data, `${method} ${path}`);
		return data;
	}

	// No @everyone ever; users and roles only when listed.
	const mentions = (users = [], roles = []) => ({ parse: [], users, roles });

	return {
		request,
		gatewayUrl: async () => (await request('GET', '/gateway/bot')).url,
		me: () => request('GET', '/users/@me'),
		getChannel: (id) => request('GET', `/channels/${id}`),
		getMessage: (channel, id) => request('GET', `/channels/${channel}/messages/${id}`),
		// Newest first; `before`: only messages older than that id.
		getMessages: (channel, limit = 50, before = null) => request('GET', `/channels/${channel}/messages?limit=${limit}${before ? `&before=${before}` : ''}`),
		// Newer than `after`, at most `limit` (Discord gives them newest first).
		getMessagesAfter: (channel, after, limit = 50) => request('GET', `/channels/${channel}/messages?limit=${limit}&after=${after}`),
		getMember: (guild, user) => request('GET', `/guilds/${guild}/members/${user}`),
		getGuild: (id) => request('GET', `/guilds/${id}`),
		activeThreads: (guild) => request('GET', `/guilds/${guild}/threads/active`),
		send: (channel, content, users = [], roles = []) =>
			request('POST', `/channels/${channel}/messages`, { content, allowed_mentions: mentions(users, roles), flags: 4 }),
		// A reply to message `id`, its author not pinged by the reply itself.
		reply: (channel, id, content, users = []) =>
			request('POST', `/channels/${channel}/messages`, { content, allowed_mentions: { ...mentions(users), replied_user: false }, flags: 4, message_reference: { message_id: id, fail_if_not_exists: false } }),
		// A new forum post started by the bot: the thread, its first message as
		// given, with `files` attached ({ name, type, data }) and link previews
		// on when `embeds`.
		startPost: (forum, { name, content, users = [], applied_tags = [], files = [], embeds = false }) =>
			request('POST', `/channels/${forum}/threads`, {
				name,
				applied_tags,
				message: { content, allowed_mentions: mentions(users), flags: embeds ? 0 : 4, attachments: files.map((f, id) => ({ id, filename: f.name })) },
			}, 0, files),
		editMessage: (channel, id, content) =>
			request('PATCH', `/channels/${channel}/messages/${id}`, { content, allowed_mentions: mentions(), flags: 4 }),
		deleteMessage: (channel, id) => request('DELETE', `/channels/${channel}/messages/${id}`),
		deleteThread: (id) => request('DELETE', `/channels/${id}`),
		editThread: (id, fields) => request('PATCH', `/channels/${id}`, fields),
	};
}

// A forum's status tags (Tracked, In progress, Fixed, Won't fix, Duplicate)
// by role, from its available_tags; names match without case or apostrophe
// style.
const STATUS_TAGS = { tracked: 'tracked', progress: 'in progress', fixed: 'fixed', wontfix: "won't fix", duplicate: 'duplicate' };

function tagKey(name) {
	return String(name).toLowerCase().replace(/[\u2018\u2019`]/g, "'").trim();
}

function statusTags(forum) {
	const out = {};
	for (const [role, name] of Object.entries(STATUS_TAGS)) {
		const tag = (forum.available_tags || []).find((t) => tagKey(t.name) === name);
		if (tag) out[role] = tag.id;
	}
	return out;
}

// A thread's applied tags with the status tags swapped for `role`'s (none
// when role is null or the forum lacks it). Discord allows five per post.
function withStatus(applied, tags, role) {
	const status = new Set(Object.values(tags));
	const next = (applied || []).filter((id) => !status.has(id));
	if (role && tags[role]) next.push(tags[role]);
	return next.slice(-5);
}

module.exports = { createDiscord, DiscordError, statusTags, withStatus, tagKey };
