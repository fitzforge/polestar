'use strict';
// GitHub back to Discord, run by the Actions: an issue filed from a #bugs
// post gets its first pull request, is closed or reopened, and a release
// ships the fixes. The player hears it in their own thread, which gets the
// matching status tag (In progress, Fixed, Won't fix, Duplicate, Tracked
// again) and is locked while the issue is closed. A duplicate hears where the
// issue it duplicates stands, and again when a release ships that one's fix.
// Every such message pings only the reporter. A prerelease (a release
// candidate) tells no thread: it pings the tester role once in the testers
// channel instead.

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

const TEAM = new Set(['OWNER', 'MEMBER', 'COLLABORATOR']);
const labelNames = (issue) => (issue.labels || []).map((l) => (typeof l === 'string' ? l : l.name));
const isReleased = (label) => label.startsWith('released:');

// What maintainers said on the issue, newest first: not the bot's copies of
// Discord follow-ups or its pull request lists.
function maintainerComments(comments) {
	return comments
		.filter((c) => TEAM.has(c.author_association) && c.body && !c.body.includes(I.FOLLOWUP_MARK) && !c.body.includes('<!-- polestar:pr-') && !(c.user && c.user.type === 'Bot'))
		.reverse();
}

// The last thing a maintainer said on the issue, as the reason for closing
// it or the question to ask.
function maintainerNote(comments) {
	const c = maintainerComments(comments)[0];
	return c ? c.body.trim() : null;
}

// A maintainer's `Duplicate of #M` line (what GitHub's UI, older gh and
// /close post), the newest one's M; null when there is none.
function duplicateComment(comments) {
	for (const c of maintainerComments(comments)) {
		const m = /^[ \t]*duplicate of #(\d+)\b/im.exec(c.body);
		if (m) return Number(m[1]);
	}
	return null;
}

// A maintainer's explanation on a duplicate: their newest comment that is
// more than the bare `Duplicate of #M` line, without that line.
function duplicateNote(comments) {
	for (const c of maintainerComments(comments)) {
		const text = c.body.replace(/^[ \t]*duplicate of #\d+[ \t]*\.?[ \t]*$/gim, '').trim();
		if (text) return text;
	}
	return null;
}

// The issue a closed one duplicates: { of: M }, of null when closed as
// duplicate naming none; null when it is no duplicate. Closed as duplicate,
// GitHub's marker (`gh issue close --duplicate-of`) or a `Duplicate of #M`
// comment names M; closed as not planned, the comment does (GitHub's UI and
// older gh close a duplicate that way), unless a resolution: label other
// than resolution:duplicate says why it closed (a /close after a reopen).
async function duplicateTarget(github, issue, comments) {
	if (issue.state_reason === 'duplicate') return { of: (await github.duplicateOf(issue.number)) || duplicateComment(comments) };
	if (issue.state_reason !== 'not_planned') return null;
	if (labelNames(issue).some((l) => l.startsWith('resolution:') && l !== 'resolution:duplicate')) return null;
	const of = duplicateComment(comments);
	return of ? { of } : null;
}

// Where the duplicated issue stands: { issue, note } (note: its maintainer's
// last word, read when it was closed as not planned), null when it is gone.
async function duplicateStatus(github, n) {
	try {
		const issue = await github.getIssue(n);
		const closedNotPlanned = issue.state === 'closed' && issue.state_reason === 'not_planned';
		return { issue, note: closedNotPlanned ? maintainerNote(await github.comments(n)) : null };
	} catch (err) {
		if (err.status === 404 || err.status === 410) return null;
		throw err;
	}
}

// The first line of a "not planned" close, by the resolution label /close
// sets (lib/commands.js); closed on GitHub without one, "won't change".
const NOT_PLANNED = {
	'resolution:no-action': 'No change is needed here.',
	'resolution:cannot-reproduce': 'We couldn\'t reproduce this one.',
	'resolution:not-resolved': 'We\'re closing this one without a fix for now.',
};

// The same, said of the issue a duplicate points at.
const NOT_PLANNED_THERE = {
	'resolution:no-action': 'no change is needed there',
	'resolution:cannot-reproduce': 'we couldn\'t reproduce that one',
	'resolution:not-resolved': 'we\'ve closed that one without a fix for now',
};

const MAX_THEIR_REASON = 300;

// A duplicate's first lines: the issue it duplicates and where that stands.
function duplicateLead(repo, of, target) {
	if (!of) return 'This was already reported, so we\'re tracking it in another issue.';
	const link = issueLink(repo, of);
	if (!target) return `This was already reported, so we're tracking it in ${link}.`;
	const { issue, note } = target;
	const labels = labelNames(issue);
	const released = labels.find(isReleased);
	if (released) return `It's the same bug as ${link}, and the fix is out in Polestar ${released.slice('released:'.length).replace(/^v/, '')}: update Polestar to get it.`;
	if (labels.includes('fix-merged') || (issue.state === 'closed' && issue.state_reason === 'completed')) {
		return `It's the same bug as ${link}, and that's already fixed: it ships in the next Polestar update.`;
	}
	if (issue.state === 'closed' && issue.state_reason === 'not_planned') {
		const why = labels.map((l) => NOT_PLANNED_THERE[l]).find(Boolean) || 'we\'ve decided not to change it';
		return note && note.length <= MAX_THEIR_REASON ? `It's the same as ${link}, and ${why}:\n${quote(note)}` : `It's the same as ${link}, and ${why}.`;
	}
	if (issue.state === 'open') return `This was already reported, so we're tracking it in ${link}.${labels.includes('has-pr') ? ' A fix is in progress.' : ''}`;
	return `This was already reported in ${link}.`;
}

// The message and status for an issue's close or reopen. duplicate, for a
// close as a duplicate: { of, target, note } (duplicateTarget's M, its
// duplicateStatus, the maintainer's explanation).
function issueMessage({ repo, issue, action, owner, comments, duplicate = null }) {
	const ping = owner ? `<@${owner}> ` : '';
	const link = issueLink(repo, issue.number);
	if (action === 'reopened') {
		return { role: 'tracked', locked: false, content: `We've reopened this and are looking at it again. (${link})` };
	}
	if (duplicate) {
		let content = ping + duplicateLead(repo, duplicate.of, duplicate.target);
		// After the other issue's quoted reason, a blank line keeps the two quotes apart.
		if (duplicate.note) content += (content.includes('\n> ') ? '\n\n' : '\n') + quote(clip(duplicate.note, MAX_REASON));
		return { role: 'duplicate', locked: true, content: `${content}\nThanks for the report! (${link})` };
	}
	if (issue.state_reason === 'not_planned') {
		const note = maintainerNote(comments);
		const lead = labelNames(issue).map((l) => NOT_PLANNED[l]).find(Boolean) || 'We\'ve decided not to change this one.';
		let content = `${ping}${lead}`;
		if (note) content += '\n' + quote(clip(note, MAX_REASON));
		content += `\nThanks for the report! (${link})`;
		return { role: 'wontfix', locked: true, content };
	}
	return { role: 'fixed', locked: true, content: `${ping}This is fixed and will ship in the next Polestar update. Thanks for the report! (${link})` };
}

// "The fix is out"; of, for a duplicate, the issue whose fix it is.
function releaseMessage({ repo, issue, release, owner, of = null }) {
	const name = release.name || release.tag_name;
	const ping = owner ? `<@${owner}> ` : '';
	const what = of ? `The fix for ${issueLink(repo, of)}, the same bug as yours, is out` : 'The fix is out';
	return `${ping}${what} in **${name}**: update Polestar to get it. ([release notes](<${release.html_url}>), ${issueLink(repo, issue.number)})`;
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

// A maintainer's question, relayed when the issue gets needs-info: the
// reporter answers in the thread, and the bot carries the answer back.
function questionMessage({ repo, issue, owner, note }) {
	const ping = owner ? `<@${owner}> ` : '';
	return `${ping}We need a little more to go on with this one:\n${quote(clip(note, MAX_REASON))}\nPlease answer here in the thread. (${issueLink(repo, issue.number)})`;
}

async function onIssue({ discord, github, event, forumId, log = console }) {
	const issue = event.issue;
	const action = event.action;
	const asking = action === 'labeled' && event.label && event.label.name === 'needs-info';
	if (action !== 'closed' && action !== 'reopened' && !asking) return false;
	const thread = await threadOf(discord, issue, forumId, log);
	if (!thread) return false;
	const comments = action === 'reopened' ? [] : await github.comments(issue.number);
	const users = thread.owner_id ? [thread.owner_id] : [];
	if (asking) {
		const note = maintainerNote(comments);
		if (!note) {
			log.info(`#${issue.number}: needs-info with no maintainer comment to relay`);
			return false;
		}
		await postIn(discord, thread, questionMessage({ repo: github.repo, issue, owner: thread.owner_id, note }), users);
		log.info(`#${issue.number} needs-info: asked in thread ${thread.id}`);
		return true;
	}
	const dup = action === 'closed' ? await duplicateTarget(github, issue, comments) : null;
	const duplicate = dup && { of: dup.of, target: dup.of ? await duplicateStatus(github, dup.of) : null, note: duplicateNote(comments) };
	const msg = issueMessage({ repo: github.repo, issue, action, owner: thread.owner_id, comments, duplicate });
	await postIn(discord, thread, msg.content, users);
	const forum = await discord.getChannel(thread.parent_id);
	await discord.editThread(thread.id, { applied_tags: withStatus(thread.applied_tags, statusTags(forum), msg.role), locked: msg.locked });
	log.info(`#${issue.number} ${action} (${issue.state_reason || 'reopened'}): told thread ${thread.id}`);
	return true;
}

// The message for an issue's first open pull request: someone is on it, it
// is not reviewed yet.
function progressMessage({ repo, issue, prs, owner }) {
	const ping = owner ? `<@${owner}> ` : '';
	const links = prs.map((p) => `[#${p.number}](<https://github.com/${repo}/pull/${p.number}>)`).join(', ');
	const what = prs.length > 1 ? `Fixes for this are open (${links})` : `A fix for this is open (${links})`;
	return `${ping}${what}. It still has to be reviewed; we'll tell you here when it's fixed. (${issueLink(repo, issue.number)})`;
}

// Tells the reporter a fix is open and tags the thread In progress. True
// when told; false when the issue has no thread, so the next run tries again
// only if a thread appears.
async function onProgress({ discord, github, issue, prs, forumId, log = console }) {
	const thread = await threadOf(discord, issue, forumId, log);
	if (!thread) return false;
	await postIn(discord, thread, progressMessage({ repo: github.repo, issue, prs, owner: thread.owner_id }), thread.owner_id ? [thread.owner_id] : []);
	const forum = await discord.getChannel(thread.parent_id);
	const tags = statusTags(forum);
	if (tags.progress) await discord.editThread(thread.id, { applied_tags: withStatus(thread.applied_tags, tags, 'progress') });
	log.info(`#${issue.number}: fix open in ${prs.map((p) => `#${p.number}`).join(', ')}; told thread ${thread.id}`);
	return true;
}

// A prerelease: GitHub's prerelease flag, or a tag with a prerelease part
// (v0.3.0-rc.1, v0.2.5-test.1).
function isPrerelease(release) {
	return Boolean(release.prerelease) || /^v?\d+\.\d+\.\d+-/.test(release.tag_name || '');
}

// An addon release (v0.2.5, v0.3.0-rc.1). The repository also publishes Forge
// (forge-v*), the open database (data-v*), LibForeverData (lib-v*) and the
// data pack (data-pack): they ship no fix to players, tell no thread and never
// count as the release before.
function isAddonRelease(release) {
	return /^v\d/.test(release.tag_name || '');
}

// The commit that closed an issue, or null when it was closed by hand: the
// last close's commit (a push saying "Fixes #N"), else the merge commit of
// this repository's pull request merged as it closed (a minute apart at
// most).
async function closingCommit(github, n) {
	const events = await github.timeline(n);
	const close = events.filter((e) => e.event === 'closed').at(-1);
	if (!close) return null;
	if (close.commit_id) return close.commit_id;
	const at = Date.parse(close.created_at);
	const pr = events
		.map((e) => e.event === 'cross-referenced' && e.source && e.source.issue)
		.find((src) => src && src.pull_request && src.pull_request.merged_at &&
			String(src.repository_url || '').endsWith(`/repos/${github.repo}`) &&
			Math.abs(Date.parse(src.pull_request.merged_at) - at) <= 60000);
	if (!pr) return null;
	return (await github.pull(pr.number)).merge_commit_sha || null;
}

const isFeature = (r) => /^v?\d+\.\d+\.0$/.test(r.tag_name || '');

// Whether an issue ships in a release (a function of the issue): closed as
// completed before the release was published. One closed by a commit ships
// when the release holds that commit and the full release before it
// (prereleases do not count) does not: a fix merged into `next` waits for
// the feature release, however many patches go out first. One closed by hand
// ships when it closed after the full release before was published. Either
// closed after the last feature release (x.y.0), `since` as the function's
// property.
async function shipCheck(github, release) {
	const published = Date.parse(release.published_at || release.created_at);
	const full = (await github.releases())
		.filter((r) => !r.draft && isAddonRelease(r) && !isPrerelease(r) && r.id !== release.id && Date.parse(r.published_at) < published)
		.sort((a, b) => Date.parse(b.published_at) - Date.parse(a.published_at));
	const earlier = full[0];
	const feature = full.find(isFeature);
	const from = earlier ? Date.parse(earlier.published_at) : 0;
	const reach = feature ? Date.parse(feature.published_at) : 0;
	const ships = async (i) => {
		const at = Date.parse(i.closed_at);
		if (i.state !== 'closed' || i.state_reason !== 'completed' || at <= reach || at > published) return false;
		const sha = await closingCommit(github, i.number);
		if (!sha) return at > from;
		return await github.contains(release.tag_name, sha) && !(earlier && await github.contains(earlier.tag_name, sha));
	};
	ships.since = reach ? feature.published_at : undefined;
	return ships;
}

// The issues a release ships: filed from Discord, shipping by shipCheck, and
// not told about a release yet (the released:<tag> label marks those told).
async function shippedBy(github, release, ships = null) {
	ships = ships || await shipCheck(github, release);
	const closed = await github.issuesLabelled('discord', { state: 'closed', since: ships.since, max: 1000 });
	const out = [];
	for (const i of closed) {
		if (labelNames(i).some(isReleased)) continue;
		if (await ships(i)) out.push(i);
	}
	return out;
}

// Issues filed from Discord, closed as duplicates and not told about a
// release yet, each with the issue it duplicates: { issue, of }. GitHub's
// search finds those closed as duplicate and those with a `Duplicate of`
// comment (closed as not planned that way); duplicateTarget checks each.
async function waitingDuplicates(github) {
	const base = `repo:${github.repo} is:issue is:closed label:discord`;
	const found = new Map();
	for (const q of [`${base} reason:duplicate`, `${base} "Duplicate of"`]) {
		for (const i of await github.searchIssues(q)) found.set(i.number, i);
	}
	const out = [];
	for (const issue of found.values()) {
		if (labelNames(issue).some(isReleased)) continue;
		const dup = await duplicateTarget(github, issue, await github.comments(issue.number));
		if (dup && dup.of) out.push({ issue, of: dup.of });
	}
	return out.sort((a, b) => a.issue.number - b.issue.number);
}

const MAX_MESSAGE = 2000;
const MAX_ENTRY = 300;

// A markdown list's items, each joined onto one line.
function listItems(markdown) {
	const items = [];
	for (const line of markdown.split('\n')) {
		if (line.startsWith('- ')) items.push(line.slice(2).trim());
		else if (line.trim() && items.length) items[items.length - 1] += ' ' + line.trim();
	}
	return items;
}

// A changelog fragment (changes/<slug>.md: front matter naming its section,
// then the entry) as { section, body }, or null when it is not one.
function parseFragment(text) {
	const m = /^---\n([\s\S]*?)\n---\n([\s\S]*)$/.exec(String(text).replace(/\r\n?/g, '\n'));
	if (!m) return null;
	const section = /^section:\s*(\S+)\s*$/m.exec(m[1]);
	return section ? { section: section[1], body: m[2] } : null;
}

// The player entries a tag carries as changelog fragments (changes/*.md
// with section players), in file name order, each on one line.
async function playerEntries(github, ref) {
	const paths = (await github.listDir('changes', ref))
		.filter((f) => f.type === 'file' && f.name.endsWith('.md') && f.name !== 'README.md' && !f.name.startsWith('.'))
		.map((f) => f.path)
		.sort();
	const entries = [];
	for (const p of paths) {
		const frag = parseFragment((await github.readFile(p, ref)) || '');
		if (frag && frag.section === 'players') entries.push(...listItems(frag.body));
	}
	return entries;
}

// The testers' ping for a prerelease: its tag in bold (what marks it told),
// where to report, and as many player entries as fit in one message.
function candidateMessage({ repo, release, role, forumId, entries }) {
	const tag = release.tag_name;
	const bugs = forumId ? `<#${forumId}>` : '#bugs';
	let content = `<@&${role}> **${tag}** is ready to test: please try it and report anything wrong in ${bugs}. ([release](<${release.html_url}>))`;
	if (!entries.length) return content;
	const more = (n) => `\n...and ${n} more in [the changes](<https://github.com/${repo}/tree/${tag}/changes>).`;
	content += '\n\nNew for players:';
	let shown = 0;
	for (const entry of entries) {
		const line = '\n- ' + clip(entry, MAX_ENTRY);
		if (content.length + line.length + more(entries.length).length > MAX_MESSAGE) break;
		content += line;
		shown++;
	}
	return shown < entries.length ? content + more(entries.length - shown) : content;
}

// Pings the tester role about a prerelease, once: a bot message in the
// channel's last 50 carrying the tag in bold means a run already did.
async function announceCandidate({ discord, github, release, forumId, testers, log }) {
	const tag = release.tag_name;
	if (!testers) {
		log.info(`${tag}: a prerelease; DISCORD_TESTERS_CHANNEL_ID or DISCORD_TESTER_ROLE_ID is not set, so no one is told`);
		return false;
	}
	const recent = await discord.getMessages(testers.channel, 50);
	if (recent.some((m) => m.author && m.author.bot && String(m.content || '').includes(`**${tag}**`))) {
		log.info(`${tag}: testers were told already`);
		return false;
	}
	let entries = [];
	try {
		entries = await playerEntries(github, tag);
	} catch (err) {
		log.warn(`${tag}: changes/ not read (${err.message}), the ping goes without them`);
	}
	await discord.send(testers.channel, candidateMessage({ repo: github.repo, release, role: testers.role, forumId, entries }), [], [testers.role]);
	log.info(`${tag}: a prerelease; testers told in ${testers.channel}`);
	return true;
}

async function onRelease({ discord, github, event, forumId, testers = null, log = console }) {
	const release = event.release;
	if (!release || release.draft || !isAddonRelease(release)) return { told: 0, failed: 0 };
	if (isPrerelease(release)) {
		await announceCandidate({ discord, github, release, forumId, testers, log });
		return { told: 0, failed: 0 };
	}
	const label = `released:${release.tag_name}`;
	const ships = await shipCheck(github, release);
	const issues = await shippedBy(github, release, ships);
	let told = 0;
	let failed = 0;
	// Tells an issue's thread and labels the issue, so no run tells it again.
	const tell = async (issue, of = null) => {
		try {
			const thread = await threadOf(discord, issue, forumId, log);
			if (thread) {
				await postIn(discord, thread, releaseMessage({ repo: github.repo, issue, release, owner: thread.owner_id, of }), thread.owner_id ? [thread.owner_id] : []);
				told++;
			}
			await github.ensureLabels([label], I.labelInfo);
			await github.addLabels(issue.number, [label]);
		} catch (err) {
			failed++;
			log.error(`#${issue.number}: ${err.message}`);
		}
	};
	for (const issue of issues) await tell(issue);

	// The duplicates of what it ships, wherever that was filed.
	const shipping = new Map(issues.map((i) => [i.number, true]));
	let dups = 0;
	try {
		for (const { issue, of } of await waitingDuplicates(github)) {
			if (!shipping.has(of)) {
				const target = await duplicateStatus(github, of);
				shipping.set(of, Boolean(target) && await ships(target.issue));
			}
			if (!shipping.get(of)) continue;
			dups++;
			await tell(issue, of);
		}
	} catch (err) {
		failed++;
		log.error(`duplicates: ${err.message}`);
	}
	log.info(`${release.tag_name}: ${issues.length} fixed issues and ${dups} duplicates of them from Discord, ${told} threads told, ${failed} failed`);
	return { told, failed };
}

module.exports = { onIssue, onRelease, onProgress, issueMessage, releaseMessage, progressMessage, candidateMessage, shippedBy, isPrerelease, maintainerNote, threadOf, postIn };
