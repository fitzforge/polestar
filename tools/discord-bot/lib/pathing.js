'use strict';
// Pathing reports: a new issue whose player says the walk, path or arrow
// goes the wrong way. Polestar's walking maps are being rebuilt, so the bot
// labels these `navigation` and `on-hold` and tells the player, on GitHub
// and in the Discord thread, that the overhaul will most likely fix it.
// Run by .github/workflows/pathing-notice.yml when an issue is opened, or
// when a maintainer labels one `navigation`.

const { threadOf, postIn } = require('./notify');

const MARK = '<!-- polestar-bot:pathing -->';
const NOTE = "Just FYI: Polestar's pathing system is getting a big overhaul, so this will most likely be fixed in a future update. We'll keep this open and check it again once the new walking maps are in.";

// What the player wrote: the title, plus for a Discord post their words,
// which the issue quotes (`> ` lines) above the addon's report. Issues
// opened on GitHub are often long technical write-ups full of file paths,
// so only their title counts. Addon names ("Shortest Path Forever") and
// flight paths are not the complaint.
function playerText(issue, discord) {
	const quoted = discord ? String(issue.body || '').split('\n').filter((l) => l.startsWith('>')).join('\n') : '';
	return `${issue.title || ''}\n${quoted}`.replace(/shortest[\s_-]*path([\s_-]*forever)?|flight[\s_-]*paths?/gi, ' ');
}

const WORDS = [
	/\bpath(s|ing|ed|ways?)?\b/i,
	/\bpathfind\w*/i,
	/\bnavigat\w*/i,
	/\bnav\s*mesh\b/i,
	/\bwalk(s|ing|ed)?\s+(me|us|you|them|him|her)?\s*(off|into|through|over|up|around|across)\b/i,
	/\b(cliff|slope|ledge)s?\b/i,
];

const TEAM = new Set(['OWNER', 'MEMBER', 'COLLABORATOR']);

// A player's complaint: filed from Discord (the bot files as a team member),
// or opened on GitHub by someone outside the team. Maintainers' own issues
// are left alone.
function isPathingReport(issue) {
	const discord = labelNames(issue).includes('discord');
	if (!discord && TEAM.has(issue.author_association)) return false;
	const text = playerText(issue, discord);
	return WORDS.some((w) => w.test(text));
}

function labelNames(issue) {
	return (issue.labels || []).map((l) => (typeof l === 'string' ? l : l.name));
}

// Labels and tells once per issue: the comment's marker says it is done.
// True when it posted.
async function onPathingIssue({ discord, github, event, forumId, log = console }) {
	const issue = event.issue;
	if (issue.pull_request || issue.state !== 'open') return false;
	const labelled = event.action === 'labeled' && event.label && event.label.name === 'navigation';
	if (event.action !== 'opened' && !labelled) return false;
	if (!labelled && !isPathingReport(issue)) return false;
	const comments = await github.comments(issue.number);
	if (comments.some((c) => String(c.body || '').includes(MARK))) return false;
	const have = labelNames(issue);
	const add = ['navigation', 'on-hold'].filter((l) => !have.includes(l));
	if (add.length) await github.addLabels(issue.number, add);
	await github.comment(issue.number, `${NOTE}\n\n${MARK}`);
	// Only an issue filed from Discord has a thread; a marker in anything
	// else is a stranger's.
	const thread = discord && have.includes('discord') ? await threadOf(discord, issue, forumId, log) : null;
	if (thread) {
		const ping = thread.owner_id ? `<@${thread.owner_id}> ` : '';
		await postIn(discord, thread, `${ping}${NOTE} ([${github.repo}#${issue.number}](<https://github.com/${github.repo}/issues/${issue.number}>))`, thread.owner_id ? [thread.owner_id] : []);
	}
	log.info(`#${issue.number}: pathing report, labelled and told${thread ? ` (thread ${thread.id})` : ''}`);
	return true;
}

module.exports = { isPathingReport, onPathingIssue, NOTE, MARK };
