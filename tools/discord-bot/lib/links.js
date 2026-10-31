'use strict';
// Which issues a pull request addresses, and the comments and labels that
// show it: every issue a pull request addresses gets one comment listing the
// pull requests for it (kept up to date, never a second one) and the label
// `has-pr`; a pull request whose issue already has another open pull request
// gets one comment naming them and the label `overlap`. Run by
// .github/workflows/pr-links.yml through tools/discord-bot/links.js;
// CONTRIBUTING.md, "Before you start", is the process it supports.
//
// A pull request addresses an issue when its title names it (#N) or its
// description closes it the way GitHub reads it ("closes #N", "fixes #N",
// "resolves #N", and the -ed and bare forms). A plain mention ("see #N",
// "refs #N") does not count: it is a link, not a claim. An issue filed from
// the Discord #bugs forum also tells the player in their thread, once, that
// a fix is open (`tell`: onProgress in lib/notify.js).
const ISSUE_MARK = '<!-- polestar:pr-links -->';
const OVERLAP_MARK = '<!-- polestar:pr-overlap -->';
const TOLD_MARK = '<!-- told -->';
const MERGED_RE = /<!-- merged:(\d+):([\w./-]+):([\w.-]+) -->/g;

const LABELS = {
	'has-pr': { color: '1d76db', description: 'An open pull request addresses this issue; see the pull requests comment' },
	'fix-merged': { color: '0e8a16', description: 'The fix is merged and waits for its release; the issue closes when it ships' },
	overlap: { color: 'd93f0b', description: 'Another open pull request addresses the same issue' },
};

const KEYWORD = String.raw`(?:close[sd]?|fix(?:e[sd])?|resolve[sd]?)`;

// Comments and code are not claims: the pull request template's own
// comments say "closes #N".
function prose(text) {
	return String(text || '')
		.replace(/<!--[\s\S]*?-->/g, ' ')
		.replace(/```[\s\S]*?```/g, ' ')
		.replace(/`[^`\n]*`/g, ' ');
}

// One issue reference in this repository: #N, owner/repo#N or the issue's URL.
function refPattern(repo) {
	const r = repo.replace(/[.]/g, '\\.');
	return String.raw`(?:${r}#|#|https://github\.com/${r}/issues/)(\d+)`;
}

// The issue numbers a pull request addresses, ascending, without its own.
function addressed(pr, repo) {
	const one = refPattern(repo);
	const found = new Set();
	for (const m of prose(pr.title).matchAll(new RegExp(one, 'g'))) found.add(Number(m[1]));
	// A keyword then a run of references: "closes #350, #382 and #368".
	const run = new RegExp(String.raw`\b${KEYWORD}:?\s+(${one}(?:\s*(?:,|and|&)?\s*${one})*)`, 'gi');
	for (const m of prose(pr.body).matchAll(run)) {
		for (const n of m[1].matchAll(new RegExp(one, 'g'))) found.add(Number(n[1]));
	}
	found.delete(pr.number);
	return [...found].sort((a, b) => a - b);
}

// The merged pull requests a previous issue comment recorded.
function mergedIn(body) {
	const out = [];
	for (const m of String(body || '').matchAll(MERGED_RE)) out.push({ number: Number(m[1]), base: m[2], user: m[3] });
	return out;
}

const who = (pr) => `#${pr.number} by @${pr.user}`;

function mergedLine(m, defaultBranch) {
	const where = m.base === defaultBranch
		? `merged into \`${m.base}\`; it ships in the next release`
		: `merged into \`${m.base}\``;
	return `- ${who(m)}, ${where} <!-- merged:${m.number}:${m.base}:${m.user} -->`;
}

// The issue's comment, or null when there is nothing to say and no comment
// to update. open: the open pull requests addressing it ({ number, user,
// base, draft }); merged: those merged, from the old comment and this event;
// told: the player was told in Discord (kept so they are told only once).
function issueComment({ open, merged, hadComment, defaultBranch, told = false }) {
	const tail = told ? `\n${TOLD_MARK}\n` : '';
	if (!open.length && !merged.length) {
		return hadComment ? `${ISSUE_MARK}\n**Pull requests for this issue**\n\nNo pull request is open for this issue now.\n${tail}` : null;
	}
	const lines = [
		...open.map((p) => `- ${who(p)}, into \`${p.base}\`${p.draft ? ' (draft)' : ''}`),
		...merged.map((m) => mergedLine(m, defaultBranch)),
	];
	let after;
	if (open.length > 1) after = `${open.length} pull requests are open for this issue. Please don't open another: review one of these, or offer what you have on it. One of them is merged, crediting whoever helped.`;
	else if (open.length === 1) after = 'Someone is working on this. Before you start on it yourself, look at that pull request: review it, or offer what you have on it.';
	else after = 'Nothing more is needed here unless the fix turns out not to work.';
	return `${ISSUE_MARK}\n**Pull requests for this issue**\n\n${lines.join('\n')}\n\n${after} (CONTRIBUTING.md, "Before you start")\n${tail}`;
}

// The pull request's overlap comment, or null when there is none to write.
// others: [{ issue, prs: [{ number, user }] }] for each issue it addresses
// that other open pull requests address too.
function overlapComment({ others, hadComment }) {
	if (!others.length) {
		return hadComment ? `${OVERLAP_MARK}\n**Other pull requests for the same issue**\n\nNo other open pull request addresses the same issue now.\n` : null;
	}
	const lines = others.map((o) => `- #${o.issue}: also ${o.prs.map(who).join(', ')}`);
	return `${OVERLAP_MARK}\n**Other pull requests for the same issue**\n\n${lines.join('\n')}\n\nPlease compare with them before going further. If one already covers the issue, close this one or offer the part it is missing there. One of them is merged, crediting whoever helped (CONTRIBUTING.md, "Before you start").\n`;
}

const brief = (p) => ({ number: p.number, user: p.user.login, base: p.base.ref, draft: Boolean(p.draft), title: p.title, body: p.body });

// The workflow's own comment carrying a mark. Anyone can write the mark in a
// comment, so only one the Actions bot wrote counts.
const ACTIONS_BOT = 'github-actions[bot]';
const ownComment = (comments, mark) => comments.filter((c) => c.body && c.body.includes(mark) && c.user && c.user.login === ACTIONS_BOT).pop();

// Brings the comments and labels up to date for the issues `touched` and
// every open pull request addressing them. pulls: the open pull requests
// (GitHub's objects); closed: the pull request this event closed, if any;
// tell(issue, prs): tells a Discord reporter a fix is open, true when told.
async function update({ github, pulls, touched, closed = null, defaultBranch, tell = null, log = () => {} }) {
	const repo = github.repo;
	const open = pulls.map(brief).map((p) => ({ ...p, issues: addressed(p, repo) }));
	const byIssue = new Map();
	for (const p of open) for (const n of p.issues) {
		if (!byIssue.has(n)) byIssue.set(n, []);
		byIssue.get(n).push(p);
	}
	await github.ensureLabels(Object.keys(LABELS), (name) => LABELS[name]);

	const prsToCheck = new Set();
	for (const n of [...new Set(touched)].sort((a, b) => a - b)) {
		let issue;
		try {
			issue = await github.getIssue(n);
		} catch (err) {
			if (err.status === 404 || err.status === 410) continue;
			throw err;
		}
		if (issue.pull_request) continue;
		const prs = (byIssue.get(n) || []).sort((a, b) => a.number - b.number);
		for (const p of prs) prsToCheck.add(p.number);
		if (issue.state !== 'open') continue;
		const old = ownComment(await github.comments(n), ISSUE_MARK);
		const merged = mergedIn(old && old.body).filter((m) => !prs.some((p) => p.number === m.number));
		if (closed && closed.merged && !merged.some((m) => m.number === closed.number)) merged.push({ number: closed.number, base: closed.base, user: closed.user });
		const labels = new Set((issue.labels || []).map((l) => (typeof l === 'string' ? l : l.name)));
		let told = Boolean(old && old.body.includes(TOLD_MARK));
		if (!told && prs.length && tell && labels.has('discord')) told = await tell(issue, prs);
		const body = issueComment({ open: prs, merged, hadComment: Boolean(old), defaultBranch, told });
		if (body && (!old || old.body !== body)) {
			if (old) await github.editComment(old.id, body);
			else await github.comment(n, body);
			log(`#${n}: ${prs.length} open, ${merged.length} merged`);
		}
		await setLabel(github, n, labels, 'has-pr', prs.length > 0);
		await setLabel(github, n, labels, 'fix-merged', merged.length > 0 && prs.length === 0);
	}

	for (const p of open.filter((x) => prsToCheck.has(x.number))) {
		const others = p.issues
			.map((n) => ({ issue: n, prs: (byIssue.get(n) || []).filter((q) => q.number !== p.number) }))
			.filter((o) => o.prs.length);
		const old = ownComment(await github.comments(p.number), OVERLAP_MARK);
		const body = overlapComment({ others, hadComment: Boolean(old) });
		if (body && (!old || old.body !== body)) {
			if (old) await github.editComment(old.id, body);
			else await github.comment(p.number, body);
			log(`PR #${p.number}: overlaps on ${others.map((o) => `#${o.issue}`).join(', ') || 'nothing now'}`);
		}
		const pr = pulls.find((x) => x.number === p.number);
		const has = new Set((pr.labels || []).map((l) => l.name));
		await setLabel(github, p.number, has, 'overlap', others.length > 0);
	}
}

async function setLabel(github, n, has, name, want) {
	if (want && !has.has(name)) await github.addLabels(n, [name]);
	else if (!want && has.has(name)) await github.removeLabel(n, name);
}

// The issues a pull_request_target event touches: those the pull request
// addresses now, and those it addressed before an edit.
function touchedBy(event, repo) {
	const pr = event.pull_request;
	const now = addressed({ number: pr.number, title: pr.title, body: pr.body }, repo);
	const ch = event.changes || {};
	const before = ch.title || ch.body
		? addressed({ number: pr.number, title: ch.title ? ch.title.from : pr.title, body: ch.body ? ch.body.from : pr.body }, repo)
		: [];
	return [...new Set([...now, ...before])];
}

module.exports = { addressed, mergedIn, issueComment, overlapComment, update, touchedBy, ISSUE_MARK, OVERLAP_MARK, LABELS };
