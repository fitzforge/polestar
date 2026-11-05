#!/usr/bin/env node
'use strict';
// Tells #bugs threads what happened on GitHub; run by the workflows
// .github/workflows/discord-issue-sync.yml and discord-release-notify.yml.
//
//   node tools/discord-bot/notify.js issue     an issue closed, reopened or labelled needs-info
//   node tools/discord-bot/notify.js release   a release published
//
// Reads the event from GITHUB_EVENT_PATH (NOTIFY_EVENT_PATH first when set:
// a manual run's stand-in); needs DISCORD_TOKEN, GITHUB_TOKEN and
// GITHUB_REPOSITORY, and checks threads against DISCORD_FORUM_ID when set.
// A prerelease pings DISCORD_TESTER_ROLE_ID in DISCORD_TESTERS_CHANNEL_ID,
// and tells no one when either is unset.

const fs = require('node:fs');
const { required } = require('./lib/config');
const { createDiscord } = require('./lib/discord');
const { createGitHub } = require('./lib/github');
const { onIssue, onRelease } = require('./lib/notify');

async function main(mode) {
	if (mode !== 'issue' && mode !== 'release') throw new Error('usage: notify.js issue|release');
	const env = process.env;
	const event = JSON.parse(fs.readFileSync(env.NOTIFY_EVENT_PATH || required(env, 'GITHUB_EVENT_PATH'), 'utf8'));
	const discord = createDiscord({ token: required(env, 'DISCORD_TOKEN') });
	const github = createGitHub({ token: required(env, 'GITHUB_TOKEN'), repo: required(env, 'GITHUB_REPOSITORY') });
	const forumId = (env.DISCORD_FORUM_ID || '').trim() || null;
	if (mode === 'issue') {
		await onIssue({ discord, github, event, forumId });
		return 0;
	}
	const testersChannel = (env.DISCORD_TESTERS_CHANNEL_ID || '').trim();
	const testerRole = (env.DISCORD_TESTER_ROLE_ID || '').trim();
	const testers = testersChannel && testerRole ? { channel: testersChannel, role: testerRole } : null;
	const { failed } = await onRelease({ discord, github, event, forumId, testers });
	return failed ? 1 : 0;
}

main(process.argv[2]).then(
	(code) => process.exit(code),
	(err) => {
		console.error(err.message);
		process.exit(1);
	},
);
