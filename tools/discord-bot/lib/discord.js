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

	async function request(method, path, body, attempt = 0) {
		const res = await fetchImpl(api + path, {
			method,
			headers: {
				Authorization: `Bot ${token}`,
				'Content-Type': 'application/json',
				'User-Agent': 'DiscordBot (https://github.com/fitzforge/polestar, 1)',
			},
			body: body === undefined ? undefined : JSON.stringify(body),
		});
		if (res.status === 204) return null;
		const data = await res.json().catch(() => null);
		if (res.status === 429 && attempt < 5) {
			await sleep(Math.ceil(((data && data.retry_after) || 1) * 1000));
			return request(method, path, body, attempt + 1);
		}
		if (res.status >= 500 && attempt < 3) {
			await sleep(1000 * 2 ** attempt);
			return request(method, path, body, attempt + 1);
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
		getMessages: (channel, limit = 50) => request('GET', `/channels/${channel}/messages?limit=${limit}`),
		getMember: (guild, user) => request('GET', `/guilds/${guild}/members/${user}`),
		getGuild: (id) => request('GET', `/guilds/${id}`),
		activeThreads: (guild) => request('GET', `/guilds/${guild}/threads/active`),
		send: (channel, content, users = [], roles = []) =>
			request('POST', `/channels/${channel}/messages`, { content, allowed_mentions: mentions(users, roles), flags: 4 }),
		editMessage: (channel, id, content) =>
			request('PATCH', `/channels/${channel}/messages/${id}`, { content, allowed_mentions: mentions(), flags: 4 }),
		deleteMessage: (channel, id) => request('DELETE', `/channels/${channel}/messages/${id}`),
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
