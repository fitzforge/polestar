#!/usr/bin/env node
'use strict';
// Keeps each issue's "Pull requests for this issue" comment and the has-pr,
// fix-merged and overlap labels up to date, and tells a Discord reporter once
// when a fix opens for their report; run by .github/workflows/pr-links.yml.
//
//   node tools/discord-bot/links.js event              a pull request opened, edited, closed...
//   node tools/discord-bot/links.js sweep [--dry-run]  every open pull request, and every issue
//                                                      labelled has-pr or fix-merged
//
// Reads the event from GITHUB_EVENT_PATH; needs GITHUB_TOKEN and
// GITHUB_REPOSITORY. With DISCORD_TOKEN set, a `discord` issue's thread is
// told (checked against DISCORD_FORUM_ID when set). --dry-run writes nothing
// and prints what it would do.

const fs = require('node:fs');
const { required } = require('./lib/config');
const { createGitHub } = require('./lib/github');
const { createDiscord } = require('./lib/discord');
const { onProgress } = require('./lib/notify');
const { update, touchedBy, addressed } = require('./lib/links');

// A GitHub client whose writes only print.
function dryRun(github) {
	const say = (...a) => console.log('[dry-run]', ...a);
	return {
		...github,
		comment: async (n, body) => say(`comment on #${n}:\n${body}`),
		editComment: async (id, body) => say(`edit comment ${id}:\n${body}`),
		addLabels: async (n, labels) => say(`#${n} +${labels.join(',')}`),
		removeLabel: async (n, name) => say(`#${n} -${name}`),
		ensureLabels: async () => {},
	};
}

async function main(argv) {
	const [mode, ...flags] = argv;
	if (mode !== 'event' && mode !== 'sweep') throw new Error('usage: links.js event | sweep [--dry-run]');
	const env = process.env;
	const dry = flags.includes('--dry-run');
	const live = createGitHub({ token: required(env, 'GITHUB_TOKEN'), repo: required(env, 'GITHUB_REPOSITORY') });
	const github = dry ? dryRun(live) : live;
	const defaultBranch = (await github.request('GET', `/repos/${github.repo}`)).default_branch;
	const forumId = (env.DISCORD_FORUM_ID || '').trim() || null;
	const suggestionsForumId = (env.SUGGESTIONS_FORUM_ID || '').trim() || null;
	const discord = env.DISCORD_TOKEN && !dry ? createDiscord({ token: env.DISCORD_TOKEN }) : null;
	const tell = discord
		? (issue, prs) => onProgress({ discord, github, issue, prs, forumId, suggestionsForumId })
		: dry ? async (issue) => (console.log(`[dry-run] tell #${issue.number}'s Discord thread`), false) : null;
	const pulls = await github.openPulls();

	let touched;
	let closed = null;
	if (mode === 'event') {
		const event = JSON.parse(fs.readFileSync(required(env, 'GITHUB_EVENT_PATH'), 'utf8'));
		const pr = event.pull_request;
		touched = touchedBy(event, github.repo);
		if (event.action === 'closed') closed = { number: pr.number, merged: Boolean(pr.merged), base: pr.base.ref, user: pr.user.login };
	} else {
		const tracked = [];
		for (const label of ['has-pr', 'fix-merged']) tracked.push(...(await github.issuesLabelled(label, { state: 'open' })).map((i) => i.number));
		touched = [...pulls.flatMap((p) => addressed(p, github.repo)), ...tracked];
	}
	await update({ github, pulls, touched, closed, defaultBranch, tell, log: (m) => console.log(m) });
	return 0;
}

main(process.argv.slice(2)).then(
	(code) => process.exit(code),
	(err) => {
		console.error(err.message);
		process.exit(1);
	},
);
