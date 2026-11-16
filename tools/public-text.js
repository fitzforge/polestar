#!/usr/bin/env node
'use strict';
// The public-text check (CONTRIBUTING.md, "Commits and pull requests"): a
// commit message, branch name or pull request title and description names no
// other guide product and never says a route was compared with, follows or
// matches another guide. The rules are tools/lib/public-text.json; a hit is
// printed as the rule's id and where it is, never the words, so a CI log
// never repeats them.
//
//   node tools/public-text.js FILE...            each file's text
//   node tools/public-text.js --commit-msg FILE  a message being committed (tools/hooks/commit-msg): its
//                                                comment lines and a `git commit -v` diff left out
//   node tools/public-text.js --pre-push         what a push publishes (tools/hooks/pre-push; the refs on stdin
//                                                as git gives them): each branch or tag name and the message
//                                                of every commit not on origin yet
//   node tools/public-text.js --pr [--commits FILE]
//                                                a pull request: PR_TITLE, PR_BODY and PR_BRANCH from the
//                                                environment, and each commit message in FILE (JSON lines
//                                                { sha, message }: the PR's commits from the GitHub API)
//   node tools/public-text.js --hash PHRASE      a name's entry for the rules' `hashed` phrases
//     --rules FILE                               the rules (default tools/lib/public-text.json)
// Exit 0: nothing found; 1: something found; 2: usage.

const fs = require('node:fs');
const { spawnSync } = require('node:child_process');
const { RULES_FILE, loadRules, hits, lineCol, commitMessage, phraseHashes } = require('./lib/public-text');

const USAGE = 'usage: node tools/public-text.js [--rules FILE] (FILE... | --commit-msg FILE | --pre-push | --pr [--commits FILE] | --hash PHRASE)';
const ZERO = /^0+$/;

function git(args) {
	const r = spawnSync('git', args, { encoding: 'utf8', maxBuffer: 1 << 28 });
	if (r.status !== 0) throw new Error(`git ${args.join(' ')}: ${r.stderr.trim()}`);
	return r.stdout;
}

// What a push publishes, from the pre-push hook's stdin (a line per ref:
// "<local ref> <local sha> <remote ref> <remote sha>"): each branch or tag
// name, and the message of each commit that is not public yet: none of
// origin's remote-tracking refs (refs/remotes/origin/*) has it, nor the
// remote ref's current tip. A rebase or merge that brings in commits already
// on origin (a contributor's, another branch's) doesn't check them again: a
// pushed message can't be reworded anyway. A deletion publishes nothing.
function pushTexts(input) {
	const texts = [];
	for (const line of input.split('\n')) {
		const [, localSha, remoteRef, remoteSha] = line.trim().split(/\s+/);
		if (!localSha || !remoteRef || ZERO.test(localSha)) continue;
		const name = remoteRef.replace(/^refs\/(heads|tags)\//, '');
		texts.push({ what: remoteRef.startsWith('refs/tags/') ? 'Tag name' : 'Branch name', text: name });
		const known = remoteSha && !ZERO.test(remoteSha) && spawnSync('git', ['cat-file', '-e', `${remoteSha}^{commit}`]).status === 0;
		const range = [localSha, '--not', '--remotes=origin', ...(known ? [remoteSha] : [])];
		for (const rec of git(['log', '--format=%H%x00%B%x01', ...range]).split('\x01')) {
			const [sha, message] = rec.replace(/^\n/, '').split('\0');
			if (sha) texts.push({ what: `Commit ${sha.slice(0, 12)} message`, text: message });
		}
	}
	return texts;
}

// [{ what, text }] -> lines naming each hit's place and rule.
function findings(texts, set) {
	const out = [];
	for (const { what, text } of texts) {
		for (const h of hits(text || '', set)) {
			const { line, col } = lineCol(text, h.index);
			out.push(`${what}, line ${line} column ${col}: public-text rule ${h.rule}`);
		}
	}
	return out;
}

function main(argv) {
	let rules = RULES_FILE;
	let mode = 'files';
	let commits = null;
	let hash = null;
	const files = [];
	for (let i = 0; i < argv.length; i++) {
		const a = argv[i];
		if (a === '--rules') rules = argv[++i];
		else if (a === '--commit-msg') mode = 'commit-msg';
		else if (a === '--pr') mode = 'pr';
		else if (a === '--pre-push') mode = 'pre-push';
		else if (a === '--commits') commits = argv[++i];
		else if (a === '--hash') hash = argv[++i];
		else if (a === '-h' || a === '--help') {
			console.log(USAGE);
			return 0;
		} else if (a.startsWith('--')) {
			console.error(`unknown option ${a}\n${USAGE}`);
			return 2;
		} else files.push(a);
	}
	if (hash != null) {
		console.log(JSON.stringify(phraseHashes(hash)));
		return 0;
	}
	const noFiles = mode === 'pr' || mode === 'pre-push';
	if (noFiles === files.length > 0 || (mode === 'commit-msg' && files.length !== 1) || (commits && mode !== 'pr') || rules == null) {
		console.error(USAGE);
		return 2;
	}
	const set = loadRules(rules);
	let texts;
	if (mode === 'pr') {
		texts = [
			{ what: 'Pull request title', text: process.env.PR_TITLE },
			{ what: 'Pull request description', text: process.env.PR_BODY },
			{ what: 'Branch name', text: process.env.PR_BRANCH },
		];
		if (commits) {
			for (const line of fs.readFileSync(commits, 'utf8').split('\n')) {
				if (!line.trim()) continue;
				const c = JSON.parse(line);
				texts.push({ what: `Commit ${String(c.sha || '').slice(0, 12)} message`, text: c.message });
			}
		}
	} else if (mode === 'pre-push') {
		texts = pushTexts(fs.readFileSync(0, 'utf8'));
	} else {
		texts = files.map((f) => {
			const text = fs.readFileSync(f, 'utf8');
			return { what: mode === 'commit-msg' ? 'Commit message' : f, text: mode === 'commit-msg' ? commitMessage(text) : text };
		});
	}
	const found = findings(texts, set);
	if (!found.length) return 0;
	const ci = process.env.GITHUB_ACTIONS === 'true';
	for (const f of found) console.error(ci ? `::error::${f}` : f);
	const how = mode === 'pr'
		? 'Reword the title, description or branch name; a commit message is reworded before the merge, or the pull request is squash-merged with a neutral one.'
		: mode === 'commit-msg'
			? 'Reword the message: drop the clause rather than swap in another word. The commit was not made; git keeps the message in COMMIT_EDITMSG (git rev-parse --git-path COMMIT_EDITMSG).'
			: mode === 'pre-push'
				? 'Nothing was pushed. Reword the commit messages named (git rebase -i, reword) or rename the branch; a pushed message stays readable for good.'
				: 'Reword the lines named.';
	console.error(`Public text: ${found.length} line(s) break the public-text rule (CONTRIBUTING.md, "Commits and pull requests"; the rules are ${rules === RULES_FILE ? 'tools/lib/public-text.json' : rules}). ${how}`);
	if (ci && process.env.GITHUB_STEP_SUMMARY) {
		fs.appendFileSync(process.env.GITHUB_STEP_SUMMARY, ['## Public text', '', ...found.map((f) => `- ${f}`), '', how, ''].join('\n'));
	}
	return 1;
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = { main };
