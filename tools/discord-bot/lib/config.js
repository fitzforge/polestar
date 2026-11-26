'use strict';
// The bot's settings, from the environment (.env on the server, secrets and
// variables in the Actions). Every one is described in .env.example.

function required(env, name) {
	const v = (env[name] || '').trim();
	if (!v) throw new Error(`${name} is not set (see tools/discord-bot/.env.example)`);
	return v;
}

// An optional channel id: null when unset, an error when it is no id.
function optionalId(env, name) {
	const v = (env[name] || '').trim();
	if (v && !/^\d+$/.test(v)) throw new Error(`${name} is not a channel id: ${v}`);
	return v || null;
}

// Fitz's Discord user id: the one maintainer allowed `!report` and `!suggest`
// when MAINTAINER_IDS is not set.
const FITZ = '162893436729556992';

const ids = (v) => String(v).split(/[\s,]+/).filter(Boolean);

function botConfig(env = process.env) {
	const repo = (env.GITHUB_REPO || 'fitzforge/polestar').trim();
	const since = (env.SYNC_SINCE || '').trim();
	const sinceMs = since ? Date.parse(since) : null;
	if (since && Number.isNaN(sinceMs)) throw new Error(`SYNC_SINCE is not a date: ${since}`);
	return {
		discordToken: required(env, 'DISCORD_TOKEN'),
		forumId: required(env, 'DISCORD_FORUM_ID'),
		githubToken: required(env, 'GITHUB_TOKEN'),
		repo,
		mediaRepo: (env.MEDIA_REPO || repo).trim(),
		mediaBranch: (env.MEDIA_BRANCH || 'bug-media').trim(),
		mediaToken: (env.MEDIA_TOKEN || env.GITHUB_TOKEN).trim(),
		since: sinceMs,
		exemptIds: ids(env.RATE_EXEMPT_IDS || ''),
		maintainerIds: ids((env.MAINTAINER_IDS || '').trim() || FITZ),
		suggestionsForumId: optionalId(env, 'SUGGESTIONS_FORUM_ID'),
	};
}

module.exports = { botConfig, required };
