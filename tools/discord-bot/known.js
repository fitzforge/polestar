#!/usr/bin/env node
'use strict';
// Writes the #known-issues board again from GitHub (issues labelled
// known-issue) and edits it in place; run by
// .github/workflows/discord-known-issues.yml.
//
//   node tools/discord-bot/known.js             write the board
//   node tools/discord-bot/known.js --dry-run   print it, write nothing
//
// Needs GITHUB_TOKEN and GITHUB_REPOSITORY; to write, DISCORD_TOKEN and
// KNOWN_ISSUES_CHANNEL_ID (unset: logs that there is no board and exits).
// DISCORD_FORUM_ID, when set, is the #bugs channel the header points to.

const { required } = require('./lib/config');
const { createDiscord } = require('./lib/discord');
const { createGitHub } = require('./lib/github');
const { updateBoard } = require('./lib/known');

async function main(argv) {
	const env = process.env;
	const dry = argv.includes('--dry-run');
	const github = createGitHub({ token: required(env, 'GITHUB_TOKEN'), repo: required(env, 'GITHUB_REPOSITORY') });
	const forumId = (env.DISCORD_FORUM_ID || '').trim() || null;
	const channel = (env.KNOWN_ISSUES_CHANNEL_ID || '').trim();
	if (!dry && !channel) {
		console.log('KNOWN_ISSUES_CHANNEL_ID is not set: no board to write');
		return 0;
	}
	const discord = dry ? null : createDiscord({ token: required(env, 'DISCORD_TOKEN') });
	const { messages } = await updateBoard({ discord, github, channel, forumId });
	if (dry) for (const [i, m] of messages.entries()) console.log(`--- message ${i + 1} (${m.length} characters)\n${m}`);
	return 0;
}

main(process.argv.slice(2)).then(
	(code) => process.exit(code),
	(err) => {
		console.error(err.message);
		process.exit(1);
	},
);
