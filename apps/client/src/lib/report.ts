// Report a problem (#832): the report the player reads before they copy it for
// the Polestar Discord's #bugs or open it as a GitHub issue. Polestar Client
// sends nothing itself. The report holds the versions, the status, the problems
// on screen and the recent failures; account names, the computer's user name,
// folder paths, tokens and e-mail addresses are replaced before it is shown, in
// what the player wrote too. Plain functions over the snapshot, so the tests
// (tests/client-report.test.js) read them as the page does.

import type { ActivityEntry, Snapshot } from './types';

/** A Discord message holds 2000 characters (addon/Polestar/UI/Report.lua R.TEXT_MAX). */
export const TEXT_MAX = 2000;
/** What the player writes is kept whole up to this many characters. */
export const DESC_MAX = 1000;
/** Fewer characters than this say nothing a fix can go on: the report waits. */
export const DESC_MIN = 5;
/** GitHub refuses a longer new-issue link (addon/Polestar/UI/Report.lua R.LINK_MAX). */
export const LINK_MAX = 6000;
export const ISSUE_URL = 'https://github.com/fitzforge/polestar/issues/new';
/** Recent failures listed, newest first. */
export const FAILURES_MAX = 5;
/** A detail line is cut to this many characters, so one long line can't push the others out. */
export const LINE_MAX = 400;
/** Names shorter than this are replaced only inside paths or when they are the whole text. */
export const NAME_MIN = 3;
/** A home folder name in lower case and this short (`will`, `dev`) is often a word too: replaced inside paths only. */
export const PLAIN_MAX = 4;

export interface ReportInput {
	description: string;
	snapshot: Snapshot;
	activity: ActivityEntry[] | null;
	/** The `diagnostics` command's answer, when it came. */
	system: { os?: string; renderer?: string } | null;
}

/** What is replaced in a report: the names and paths this PC knows. */
export interface Private {
	names: string[];
	paths: string[];
}

const ACCOUNT = '<account>';
const USER = '<user>';
const PATH = '<path>';
const SECRET = '<redacted>';
const EMAIL = '<email>';

function escape(s: string): string {
	return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

/** The account names and folder paths in the snapshot and the activity list. */
export function privateOf(snapshot: Snapshot, activity: ActivityEntry[] | null = null): Private {
	const g = snapshot.game;
	const paths = [snapshot.dataDir, g.root, g.dir, g.chosen, g.problem?.path, ...g.candidates.flatMap((c) => [c.root, c.dir])].filter((p): p is string => !!p && p.length > 1);
	const accounts = [...g.accounts.map((a) => a.name), ...(activity ?? []).map((e) => e.account)].filter((n): n is string => !!n && !!n.trim());
	return { names: [...new Set(accounts.map((n) => n.trim()))], paths: [...new Set(paths)] };
}

// Paths by their shape. A folder's name may hold single spaces when a separator follows it
// (`Program Files (x86)\`); the last part of a path ends at the first space, so the words
// between two paths stay, and a full stop after it is the sentence's. A path in quotes is
// read to its closing quote.
const W = String.raw`[^\\/\s"'<>|,;:*?]+`;
const REST = String.raw`(?:${W}(?: ${W})*[\\/])*(?:${W}(?<![.]))?`;
const ROOTS = 'Users|home|var|tmp|private|Volumes|mnt|media|run|opt|srv|root|data|Applications|Library|snap|usr|etc|proc|dev';
const START = String.raw`(?:\\\\\?\\)?[A-Za-z]:[\\/]|\\\\|file:\/\/|(?:smb|afp|nfs|cifs|sftp):\/\/|~[\w.-]*\/|\/(?:${ROOTS})\/`;
const QUOTED = new RegExp(String.raw`(["'])(?:${START})(?:(?!\1)[^\n])*\1`, 'gi');
const URL_PATH = /\b(?:file|smb|afp|nfs|cifs|sftp):\/\/[^\s"'<>]*/gi;
const WTF = new RegExp(String.raw`(?<![\w-])WTF[\\/]Account[\\/]${REST}`, 'gi');
const WIN_PATH = new RegExp(String.raw`(?:(?<![A-Za-z0-9])(?:\\\\\?\\)?[A-Za-z]:|(?<![\\\w])\\\\[^\\/\s?]+)[\\/]${REST}`, 'g');
const POSIX_PATH = new RegExp(String.raw`(?<![\w.:/~<>-])(?:~[\w.-]*|\/(?:${ROOTS}))\/${REST}`, 'g');
const GITHUB_TOKEN = /\b(?:gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,})\b/g;
const AWS_KEY = /\b(?:AKIA|ASIA)[0-9A-Z]{16}\b/g;
const JWT = /\beyJ[\w-]{5,}\.[\w-]{5,}(?:\.[\w-]*)?/g;
const BEARER = /\b(bearer)\s+[A-Za-z0-9._~+/=-]{8,}/gi;
// A secret's name: one of these words alone, or a word ending in `_`/`-` and one of these
// or key, auth, session, sig (client_secret, refresh_token, x-api-key; not hotkey or monkey).
const SECRET_NAMES = String.raw`token|secret|password|passwd|pwd|api[_-]?key|apikey|signature|session[_-]?id|sid`;
const KEYED = new RegExp(String.raw`(?<![\w-])((?:[\w-]*[_-](?:${SECRET_NAMES}|key|auth|session|sig))|(?:${SECRET_NAMES}))(["']?\s*[:=]\s*)("[^"]*"|'[^']*'|[^\s,;&"']+)`, 'gi');
// Headers whose whole value is secret, to the end of the line: every cookie, every credential.
const HEADER = /(?<![\w-])((?:set-)?cookie|(?:proxy-)?authorization)(["']?\s*[:=]\s*)(?:(bearer|basic|digest|negotiate)\s+)?[^\n]+/gi;
const EMAIL_RE = /[\w.+-]+@[\w-]+(?:\.[\w-]+)+/g;
// A long run of letters and digits mixed, as keys and tokens are; words, versions, commit
// hashes (hex only) and UUIDs are not.
const OPAQUE = /[A-Za-z0-9_+=-]{20,}/g;

function opaque(s: string): boolean {
	if (/^[0-9a-f]{7,40}$/i.test(s) || /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(s)) return false;
	const digits = (s.match(/\d/g) ?? []).length;
	const letters = (s.match(/[A-Za-z]/g) ?? []).length;
	return digits >= 4 && letters >= 4;
}

/** A known path as a pattern: either separator, any case, and the folders that follow it. */
function knownPattern(p: string): RegExp | null {
	const trimmed = p.replace(/[\\/]+$/, '');
	if (!trimmed) return null;
	const body = [...trimmed].map((c) => (c === '/' || c === '\\' ? '[\\\\/]' : escape(c))).join('');
	// A drive alone (`D:\`) is a path only with its separator, never the `d:` in a word.
	const tail = /^[A-Za-z]:$/.test(trimmed) ? `[\\\\/]${REST}` : `(?:[\\\\/]${REST})?`;
	return new RegExp(`(?<![A-Za-z0-9])${body}${tail}`, 'gi');
}

const HOME_SEGMENT = /(?:^|[\\/])(?:Users|home)[\\/]([^\\/"']+)/gi;
const TILDE_USER = /~([\w.-]+)\//g;

function cleanName(n: string): string {
	return n.trim().replace(/[.,;:!?)\]}]+$/, '');
}

/** The user names in the known paths (a whole folder name, spaces and all) and in path shapes in the text. */
export function userNames(text: string, priv: Private): string[] {
	const found: string[] = [];
	const take = (s: string) => {
		for (const m of s.matchAll(HOME_SEGMENT)) found.push(m[1]);
		for (const m of s.matchAll(TILDE_USER)) found.push(m[1]);
	};
	for (const p of priv.paths) take(p);
	for (const re of [QUOTED, URL_PATH, WIN_PATH, POSIX_PATH]) for (const m of text.matchAll(re)) take(m[0].replace(/^["']|["']$/g, ''));
	const out = new Set<string>();
	for (const raw of found) {
		const n = cleanName(raw);
		if (!n || /^(public|shared|default|all users|guest)$/i.test(n)) continue;
		out.add(n);
		for (const w of n.split(/\s+/)) if (w.length >= NAME_MIN) out.add(cleanName(w));
	}
	return [...out].filter((n) => n.length >= NAME_MIN);
}

function wordRe(n: string, flags: string): RegExp {
	return new RegExp(`(?<![\\p{L}\\p{N}_<])${escape(n)}(?![\\p{L}\\p{N}_>])`, flags);
}

interface Ctx {
	priv: Private;
	users: string[];
}

/** The redaction rules, in the order they run. Each is named so a test can say which one failed. */
export const RULES: { name: string; run: (s: string, c: Ctx) => string }[] = [
	{ name: 'quoted path', run: (s) => s.replace(QUOTED, (_m, q: string) => `${q}${PATH}${q}`) },
	{
		name: 'known path',
		run: (s, c) => {
			for (const p of [...c.priv.paths].sort((a, b) => b.length - a.length)) {
				const re = knownPattern(p);
				if (re) s = s.replace(re, PATH);
			}
			return s;
		},
	},
	{ name: 'path link', run: (s) => s.replace(URL_PATH, PATH) },
	{ name: 'WTF account folder', run: (s) => s.replace(WTF, PATH) },
	{ name: 'GitHub token', run: (s) => s.replace(GITHUB_TOKEN, SECRET) },
	{ name: 'AWS key', run: (s) => s.replace(AWS_KEY, SECRET) },
	{ name: 'JWT', run: (s) => s.replace(JWT, SECRET) },
	{ name: 'bearer', run: (s) => s.replace(BEARER, (_m, kind: string) => `${kind} ${SECRET}`) },
	{
		name: 'keyed secret',
		run: (s) =>
			s
				.replace(HEADER, (_m, key: string, sep: string, scheme: string | undefined) => `${key}${sep}${scheme ? `${scheme} ` : ''}${SECRET}`)
				.replace(KEYED, (m, key: string, sep: string, value: string) => (/^<\w+>$/.test(value) ? m : `${key}${sep}${SECRET}`)),
	},
	{ name: 'e-mail', run: (s) => s.replace(EMAIL_RE, EMAIL) },
	{ name: 'Windows path', run: (s) => s.replace(WIN_PATH, PATH) },
	{ name: 'POSIX path', run: (s) => s.replace(POSIX_PATH, PATH) },
	{ name: 'opaque token', run: (s) => s.replace(OPAQUE, (m) => (opaque(m) ? SECRET : m)) },
	{
		name: 'account name',
		run: (s, c) => {
			const names = [...c.priv.names].sort((a, b) => b.length - a.length);
			for (const n of names) if (n.length >= NAME_MIN) s = s.replace(wordRe(n, 'giu'), ACCOUNT);
			for (const n of names) if (s.trim().toLowerCase() === n.toLowerCase()) return ACCOUNT;
			return s;
		},
	},
	{
		name: 'user name',
		run: (s, c) => {
			for (const u of [...c.users].sort((a, b) => b.length - a.length)) {
				if (/^[a-z]+$/.test(u) && u.length <= PLAIN_MAX) continue;
				s = s.replace(wordRe(u, 'gu'), USER);
			}
			return s;
		},
	},
];

/**
 * The text with this PC's private details replaced: known folder paths and the folders
 * after them, paths by their shape (`<path>`), the user name in a home folder (`<user>`),
 * account names (`<account>`), e-mail addresses, and tokens and keys (`<redacted>`).
 */
export function redact(text: string, priv: Private, users = userNames(text, priv)): string {
	const ctx: Ctx = { priv, users };
	return RULES.reduce((s, r) => r.run(s, ctx), text);
}

/** The description (redacted whole, then cut to DESC_MAX) and the detail lines, redacted with the user names found in any of them. */
function redacted(input: ReportInput): { desc: string; lines: string[] } {
	const priv = privateOf(input.snapshot, input.activity);
	const raw = details(input);
	const users = userNames([input.description, ...raw].join('\n'), priv);
	return { desc: cut(redact(input.description.trim(), priv, users), DESC_MAX), lines: raw.map((l) => cut(redact(l, priv, users), LINE_MAX)) };
}

function oneLine(s: string): string {
	return s.replace(/\s+/g, ' ').trim();
}

/** The first n characters (code points, never half a character), with "..." when cut. */
function cut(s: string, n: number): string {
	const cps = Array.from(s);
	if (cps.length <= n) return s;
	return cps.slice(0, Math.max(0, n - 3)).join('').trimEnd() + '...';
}

function stamp(ms: number): string {
	const d = new Date(ms);
	const p = (n: number) => String(n).padStart(2, '0');
	return `${d.getUTCFullYear()}-${p(d.getUTCMonth() + 1)}-${p(d.getUTCDate())} ${p(d.getUTCHours())}:${p(d.getUTCMinutes())} UTC`;
}

const ADDON_STATUS: Record<string, string> = {
	noGame: 'game not found',
	unknown: 'not checked',
	unavailable: 'unavailable',
	install: 'not installed',
	update: 'update available',
	upToDate: 'up to date',
};

/** The report's detail lines, most useful first. */
export function details(input: Omit<ReportInput, 'description'>): string[] {
	const { snapshot: s, activity, system } = input;
	const g = s.game;
	const lines: string[] = [];
	lines.push(['Polestar Client ' + s.version, system?.os, system?.renderer && `renderer ${system.renderer}`, s.update && `client update ${s.update} waiting`].filter(Boolean).join(' · '));
	lines.push(
		'Game: ' +
			(g.found ? ['found', g.gameVersion ? `client ${g.gameVersion}` : 'version unknown', g.running ? 'running' : 'closed'].join(' · ') : g.scanned ? 'not found' : 'still looking') +
			(g.candidates.length > 1 ? ` · ${g.candidates.length} game folders found` : ''),
	);
	if (s.addons.products.length) {
		lines.push(
			'Addons: ' +
				s.addons.products
					.map((p) => `${p.name} ${p.installed ?? '-'}${p.latest && p.status === 'update' ? ` (${p.latest.version} available)` : p.status !== 'upToDate' && p.status !== 'update' ? ` (${ADDON_STATUS[p.status] ?? p.status})` : ''}${p.busy ? ` [${p.busy} running]` : ''}`)
					.join(', ') +
				` · ${s.addons.channel} channel`,
		);
	}
	const packs = s.community.packs.filter((p) => p.installed);
	lines.push('Community Guides: ' + (packs.length ? packs.map((p) => `${p.title} ${p.installed}${p.status === 'upToDate' ? '' : ` (${p.status})`}`).join(', ') : 'none installed'));
	lines.push(`Status: ${oneLine(s.status.title)}${s.status.detail ? ` · ${oneLine(s.status.detail)}` : ''}`);
	lines.push(`Sharing: ${s.consent ? 'on' : 'off'}${s.paused ? ' · uploads paused' : ''} · ${s.pending} waiting to send · ${g.accounts.length} account${g.accounts.length === 1 ? '' : 's'}`);
	const problems = [
		g.problem?.message,
		s.addons.error && `Addons: ${s.addons.error}`,
		s.community.error && `Community Guides: ${s.community.error}`,
		...g.accounts.filter((a) => a.problem).map((a) => `Account: ${a.problem}`),
	].filter((p): p is string => !!p);
	for (const p of problems) lines.push(`Problem: ${oneLine(p)}`);
	const failures = (activity ?? []).filter((e) => e.kind === 'failed' || ((e.kind === 'install' || e.kind === 'update' || e.kind === 'repair' || e.kind === 'uninstall') && e.message)).slice(0, FAILURES_MAX);
	for (const f of failures) lines.push(`Failed ${stamp(f.at)}: ${f.kind === 'failed' ? 'upload' : `${f.kind}${f.product ? ` ${f.product}` : ''}${f.version ? ` ${f.version}` : ''}`}: ${oneLine(f.message ?? 'no message')}`);
	if (!failures.length) lines.push('Failed: nothing recently');
	return lines;
}

const TRIMMED = '(some details left out to fit)';

/** A fence longer than any run of backticks in the block, so a line can't close it. */
function fenceFor(lines: string[]): string {
	const longest = Math.max(0, ...lines.flatMap((l) => (l.match(/`+/g) ?? []).map((r) => r.length)));
	return '`'.repeat(Math.max(3, longest + 1));
}

/**
 * The description and the detail lines in at most `max` by `measure`: detail lines go from
 * the end first, then the description and the first line are cut, never half a character;
 * the code block is always closed.
 */
function fit(desc: string, lines: string[], max: number, measure: (s: string) => number): string {
	const build = (d: string, ls: string[], trimmed: boolean) => {
		const body = trimmed ? [...ls, TRIMMED] : ls;
		const fence = fenceFor(body);
		return `${d}\n\n${fence}text\n${body.join('\n')}\n${fence}`;
	};
	let text = build(desc, lines, false);
	if (measure(text) <= max) return text;
	for (let keep = lines.length - 1; keep >= 1; keep--) {
		text = build(desc, lines.slice(0, keep), true);
		if (measure(text) <= max) return text;
	}
	// The longest start of the description (in characters) that fits with the first line.
	const longest = (make: (n: number) => string, total: number) => {
		let lo = 0;
		let hi = total;
		while (lo < hi) {
			const mid = (lo + hi + 1) >> 1;
			if (measure(make(mid)) <= max) lo = mid;
			else hi = mid - 1;
		}
		return make(lo);
	};
	const first = lines.slice(0, 1);
	text = longest((n) => build(cut(desc, n), first, true), Array.from(desc).length);
	if (measure(text) <= max) return text;
	return longest((n) => build('', [cut(first[0] ?? '', n)], true), Array.from(first[0] ?? '').length);
}

/**
 * The report: what the player wrote, then the details in a block, everything redacted.
 * At most `max` characters (a Discord message, characters counted as JavaScript and Discord
 * count them).
 */
export function reportText(input: ReportInput, max = TEXT_MAX): string {
	const { desc, lines } = redacted(input);
	return fit(desc, lines, max, (s) => s.length);
}

/** A link that opens a new "Bug report" issue with the title, versions and the report filled in, at most LINK_MAX long. */
export function issueUrl(input: ReportInput): string {
	const { desc, lines } = redacted(input);
	const first = oneLine(desc.split('\n')[0] ?? '');
	const addon = input.snapshot.addons.products.find((p) => p.id === 'polestar')?.installed ?? input.snapshot.game.addon?.version ?? null;
	const fields: [string, string][] = [
		['template', 'bug-report.yml'],
		['title', `Bug: Client: ${cut(first, 80)}`],
		['version', `Polestar ${addon ?? 'not installed'} · Polestar Client ${input.snapshot.version}`],
	];
	const base = `${ISSUE_URL}?${fields.map(([k, v]) => `${k}=${encodeURIComponent(v)}`).join('&')}&steps=`;
	const room = LINK_MAX - base.length;
	const body = fit(desc, lines, room, (s) => encodeURIComponent(s).length);
	return base + encodeURIComponent(body);
}

/** Whether the description says enough to send. */
export function ready(description: string): boolean {
	return description.trim().length >= DESC_MIN;
}
