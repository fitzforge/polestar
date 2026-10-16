'use strict';
// GitHub back to Discord, run by the Actions: an issue filed from a #bugs
// post closed or reopened, and a release that ships the fixes. The player
// hears it in their own thread, which gets the matching status tag (Fixed,
// Won't fix, Duplicate, Tracked again) and is locked while the issue is
// closed. Every message pings only the reporter.

const I = require('./issue');
const { statusTags, withStatus } = require('./discord');

const MAX_REASON = 1200;

function issueLink(repo, n) {
	return `[${repo}#${n}](<https://github.com/${repo}/issues/${n}>)`;
}

function clip(text, n) {
	const t = String(text).trim();
	return t.length > n ? t.slice(0, n - 3).trimEnd() + '...' : t;
}

const quote = (text) => text.split('\n').map((l) => '> ' + l).join('\n');

// The last thing a maintainer said on the issue (not the bot's copies of
// Discord follow-ups), as the reason for closing it.
function maintainerNote(comments) {
	const team = new Set(['OWNER', 'MEMBER', 'COLLABORATOR']);
	for (let i = comments.length - 1; i >= 0; i--) {
		const c = comments[i];
		if (!team.has(c.author_association) || !c.body || c.body.includes(I.FOLLOWUP_MARK)) continue;
		if (c.user && c.user.type === 'Bot') continue;
		return c.body.trim();
	}
	return null;
}

function duplicateOf(comments) {
	for (let i = comments.length - 1; i >= 0; i--) {
		const m = String(comments[i].body || '').match(/duplicate of #(\d+)/i);
		if (m) return Number(m[1]);
	}
	return null;
}

// The first line of a "not planned" close, by the resolution label /close
// sets (lib/commands.js); closed on GitHub without one, "won't change".
const NOT_PLANNED = {
	'resolution:no-action': 'No change is needed here.',
	'resolution:cannot-reproduce': 'We couldn\'t reproduce this one.',
	'resolution:not-resolved': 'We\'re closing this one without a fix for now.',
};

// The message and status for an issue's close or reopen.
function issueMessage({ repo, issue, action, owner, comments }) {
	const ping = owner ? `<@${owner}> ` : '';
	const link = issueLink(repo, issue.number);
	if (action === 'reopened') {
		return { role: 'tracked', locked: false, content: `We've reopened this and are looking at it again. (${link})` };
	}
	if (issue.state_reason === 'duplicate') {
		const of = duplicateOf(comments);
		const where = of ? `we're tracking it in ${issueLink(repo, of)}` : "we're tracking it in another issue";
		return { role: 'duplicate', locked: true, content: `${ping}This was already reported, so ${where}. Thanks for the report! (${link})` };
	}
	if (issue.state_reason === 'not_planned') {
		const note = maintainerNote(comments);
		const labels = (issue.labels || []).map((l) => (typeof l === 'string' ? l : l.name));
		const lead = labels.map((l) => NOT_PLANNED[l]).find(Boolean) || 'We\'ve decided not to change this one.';
		let content = `${ping}${lead}`;
		if (note) content += '\n' + quote(clip(note, MAX_REASON));
		content += `\nThanks for the report! (${link})`;
		return { role: 'wontfix', locked: true, content };
	}
	return { role: 'fixed', locked: true, content: `${ping}This is fixed and will ship in the next Polestar update. Thanks for the report! (${link})` };
}

function releaseMessage({ repo, issue, release, owner }) {
	const name = release.name || release.tag_name;
	const ping = owner ? `<@${owner}> ` : '';
	return `${ping}The fix is out in **${name}**: update Polestar to get it. ([release notes](<${release.html_url}>), ${issueLink(repo, issue.number)})`;
}

// The thread an issue was filed from, or null (no marker, deleted, or not
// in the forum named by forumId when one is given).
async function threadOf(discord, issue, forumId, log) {
	const mk = I.readMarker(issue.body);
	if (!mk) return null;
	try {
		const thread = await discord.getChannel(mk.thread);
		if (forumId && thread.parent_id !== forumId) {
			log.warn(`#${issue.number}: thread ${mk.thread} is not in the #bugs forum, skipped`);
			return null;
		}
		return thread;
	} catch (err) {
		if (err.status === 404 || err.status === 403) {
			log.warn(`#${issue.number}: thread ${mk.thread} is gone`);
			return null;
		}
		throw err;
	}
}

// Posts in a thread, opening it first when Discord archived it.
async function postIn(discord, thread, content, users) {
	if (thread.thread_metadata && thread.thread_metadata.archived) await discord.editThread(thread.id, { archived: false });
	await discord.send(thread.id, content, users);
}

async function onIssue({ discord, github, event, forumId, log = console }) {
	const issue = event.issue;
	const action = event.action;
	if (action !== 'closed' && action !== 'reopened') return false;
	const thread = await threadOf(discord, issue, forumId, log);
	if (!thread) return false;
	const comments = action === 'closed' ? await github.comments(issue.number) : [];
	const msg = issueMessage({ repo: github.repo, issue, action, owner: thread.owner_id, comments });
	await postIn(discord, thread, msg.content, thread.owner_id ? [thread.owner_id] : []);
	const forum = await discord.getChannel(thread.parent_id);
	await discord.editThread(thread.id, { applied_tags: withStatus(thread.applied_tags, statusTags(forum), msg.role), locked: msg.locked });
	log.info(`#${issue.number} ${action} (${issue.state_reason || 'reopened'}): told thread ${thread.id}`);
	return true;
}

// The issues a release ships: filed from Discord, closed as completed after
// the release before it was published and before this one was, and not told
// about a release yet (the released:<tag> label marks those told).
async function shippedBy(github, release) {
	const published = Date.parse(release.published_at || release.created_at);
	const earlier = (await github.releases())
		.filter((r) => !r.draft && r.id !== release.id && Date.parse(r.published_at) < published)
		.sort((a, b) => Date.parse(b.published_at) - Date.parse(a.published_at))[0];
	const from = earlier ? Date.parse(earlier.published_at) : 0;
	const closed = await github.issuesLabelled('discord', { state: 'closed', since: earlier ? earlier.published_at : undefined, max: 1000 });
	return closed.filter((i) => {
		const at = Date.parse(i.closed_at);
		return i.state_reason === 'completed' && at > from && at <= published &&
			!i.labels.some((l) => String(l.name || l).startsWith('released:'));
	});
}

async function onRelease({ discord, github, event, forumId, log = console }) {
	const release = event.release;
	if (!release || release.draft) return { told: 0, failed: 0 };
	const label = `released:${release.tag_name}`;
	const issues = await shippedBy(github, release);
	let told = 0;
	let failed = 0;
	for (const issue of issues) {
		try {
			const thread = await threadOf(discord, issue, forumId, log);
			if (thread) {
				await postIn(discord, thread, releaseMessage({ repo: github.repo, issue, release, owner: thread.owner_id }), thread.owner_id ? [thread.owner_id] : []);
				told++;
			}
			await github.ensureLabels([label], I.labelInfo);
			await github.addLabels(issue.number, [label]);
		} catch (err) {
			failed++;
			log.error(`#${issue.number}: ${err.message}`);
		}
	}
	log.info(`${release.tag_name}: ${issues.length} fixed issues from Discord, ${told} threads told, ${failed} failed`);
	return { told, failed };
}

module.exports = { onIssue, onRelease, issueMessage, releaseMessage, shippedBy, maintainerNote };
