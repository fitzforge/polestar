'use strict';
// The update reply: a report from an older Polestar than the latest full
// release is told at once to update and say whether it still happens. The
// bot tells a #bugs post as it files it (in the thread and on the issue);
// the issue workflow tells an issue opened on GitHub with the bug forms'
// "Polestar version" field (on the issue). Once per issue: the bot files a
// post once, and the issue comment carries UPDATE_MARK, so a re-run finds it.

const I = require('./issue');

const UPDATE_MARK = '<!-- polestar-bot:update -->';
const DOWNLOAD_URL = 'https://www.curseforge.com/wow/addons/polestar';
// How long the latest release is kept before GitHub is asked again.
const LATEST_TTL = 10 * 60 * 1000;

const VERSION = /^v?(\d{1,3})\.(\d{1,3})\.(\d{1,3})(?:-([0-9A-Za-z]{1,20}(?:\.[0-9A-Za-z]{1,20}){0,3}))?$/;
// A full addon release's tag: v0.3.7 (not a prerelease's v0.3.8-rc.1, nor
// Polestar Client's client-v0.1.7, Forge's forge-v*, the data's data-v*).
const FULL_TAG = /^v\d{1,3}\.\d{1,3}\.\d{1,3}$/;

// A version as { core: [major, minor, patch], pre: [...identifiers], text },
// or null for anything else ("dev", a build from source, words). `text` is
// rebuilt from the parts, so it is safe to write anywhere.
function parseVersion(value) {
	const m = VERSION.exec(String(value || '').trim());
	if (!m) return null;
	const core = [m[1], m[2], m[3]].map(Number);
	const pre = m[4] ? m[4].split('.') : [];
	return { core, pre, text: core.join('.') + (pre.length ? '-' + pre.join('.') : '') };
}

// Semantic version order: core numbers, then a prerelease before its release
// (0.3.7-rc.1 < 0.3.7), its identifiers numbers before words.
function compareVersions(a, b) {
	for (let i = 0; i < 3; i++) if (a.core[i] !== b.core[i]) return a.core[i] < b.core[i] ? -1 : 1;
	if (!a.pre.length || !b.pre.length) return Math.sign(b.pre.length - a.pre.length);
	for (let i = 0; i < Math.max(a.pre.length, b.pre.length); i++) {
		const x = a.pre[i];
		const y = b.pre[i];
		if (x === undefined) return -1;
		if (y === undefined) return 1;
		if (x === y) continue;
		const nx = /^\d+$/.test(x);
		const ny = /^\d+$/.test(y);
		if (nx && ny) return Number(x) < Number(y) ? -1 : 1;
		if (nx !== ny) return nx ? -1 : 1;
		return x < y ? -1 : 1;
	}
	return 0;
}

// The latest published full release of the addon: { version, tag, url }, or
// null. GitHub's releases/latest (never a draft or a prerelease); when that is
// another of the repository's releases (Polestar Client's), the newest addon
// one among the recent releases.
async function latestFullRelease(github) {
	const full = (r) => (r && !r.draft && !r.prerelease && FULL_TAG.test(r.tag_name || '') ? { version: parseVersion(r.tag_name), tag: r.tag_name, url: r.html_url } : null);
	const latest = full(await github.latestRelease());
	if (latest) return latest;
	const all = (await github.releases()).map(full).filter(Boolean);
	return all.sort((a, b) => compareVersions(b.version, a.version))[0] || null;
}

// latestFullRelease kept for `ttl`: the bot asks once per ten minutes at
// most. A failed read is logged and answers with what it had (or null).
function cachedLatest(github, { now = Date.now, ttl = LATEST_TTL, log = console } = {}) {
	let hit = null;
	return async () => {
		if (hit && now() - hit.at < ttl) return hit.release;
		try {
			const release = await latestFullRelease(github);
			hit = { at: now(), release };
			return release;
		} catch (err) {
			log.warn(`update reply: the latest release not read: ${err.message}`);
			return hit ? hit.release : null;
		}
	};
}

// The reply's words when `version` (the report's) is older than `latest`
// (latestFullRelease's), else null.
function updateText(version, latest) {
	const current = parseVersion(version);
	if (!current || !latest || !latest.version || compareVersions(current, latest.version) >= 0) return null;
	return `You're on ${current.text}, ${latest.version.text} is out. Please update and tell us if it still happens.`;
}

// The reply in the thread (the link without a preview) and on the issue.
const discordUpdate = (text) => `${text} Download it from CurseForge: <${DOWNLOAD_URL}>`;
const githubUpdate = (text) => `${text}\n\nDownload it from CurseForge: ${DOWNLOAD_URL}\n\n${UPDATE_MARK}`;

// The "Polestar version" field of an issue opened with a bug form (GitHub
// writes it as a `### Polestar version` heading, the answer below), as a
// version or null ("0.3.6 Beta" gives 0.3.6; "dev" or no answer, null).
function formVersion(body) {
	const field = /^###[ \t]+Polestar version[ \t]*\r?\n(?:[ \t]*\r?\n)*[ \t]*(\S[^\r\n]*)/m.exec(String(body || ''));
	if (!field) return null;
	const v = /(?:^|[^\w.])(v?\d{1,3}\.\d{1,3}\.\d{1,3}(?:-[0-9A-Za-z]+(?:\.[0-9A-Za-z]+)*)?)(?![\w.])/.exec(field[1]);
	return v && parseVersion(v[1]) ? v[1] : null;
}

// An issue opened on GitHub (not filed from Discord: the bot tells those):
// the update reply on the issue when its form's version is older than the
// latest full release, unless the issue has it already.
async function onOpened({ github, event, latest = () => latestFullRelease(github), log = console }) {
	const { action, issue } = event;
	if (action !== 'opened' || !issue || issue.pull_request || I.labelNames(issue).includes('discord')) return false;
	const version = formVersion(issue.body);
	if (!version) return false;
	const release = await latest();
	const text = updateText(version, release);
	if (!text) return false;
	if ((await github.comments(issue.number)).some((c) => String(c.body || '').includes(UPDATE_MARK))) return false;
	await github.comment(issue.number, githubUpdate(text));
	log.info(`#${issue.number}: on ${version}, told ${release.version.text} is out`);
	return true;
}

module.exports = { UPDATE_MARK, DOWNLOAD_URL, LATEST_TTL, parseVersion, compareVersions, latestFullRelease, cachedLatest, updateText, discordUpdate, githubUpdate, formVersion, onOpened };
