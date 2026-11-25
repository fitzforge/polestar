'use strict';
// Report a problem in Polestar Client (#832): the report and its GitHub link carry the
// versions, the status and the recent failures, with the account names, the computer's
// user name, folder paths and tokens it finds replaced. Each redaction rule has a test of
// its own. Node strips the types.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { reportText, issueUrl, redact, privateOf, ready, TEXT_MAX, LINK_MAX, DESC_MIN, LINE_MAX } = require('../apps/client/src/lib/report.ts');

const HOME_MAC = '/Users/jsmith/Library/Application Support/gg.polestar.client';
const ROOT_WIN = 'C:\\Users\\Kara Lynn\\Games\\World of Warcraft';
const TOKEN = 'ghp_A1b2C3d4E5f6G7h8I9j0K1l2M3n4O5p6Q7r8';
const NONE = { names: [], paths: [] };

function snapshot(extra = {}) {
	return {
		version: '0.1.9',
		setupDone: true,
		consent: true,
		shareNotice: false,
		paused: false,
		explore: true,
		serverUrl: 'https://rec.polestar.guide',
		defaultServerUrl: 'https://rec.polestar.guide',
		dataDir: HOME_MAC,
		game: {
			found: true,
			scanned: true,
			root: ROOT_WIN,
			dir: `${ROOT_WIN}\\_forever_`,
			gameVersion: '1.15.7.61582',
			chosen: null,
			problem: { path: `${ROOT_WIN}\\_classic_era_`, message: `The folder ${ROOT_WIN}\\_classic_era_ is the Classic Era client.` },
			candidates: [{ root: ROOT_WIN, dir: `${ROOT_WIN}\\_forever_`, client: '_forever_', version: '1.15.7.61582', accounts: 1, addonVersion: '0.4.2' }],
			addon: { installed: true, version: '0.4.2', latest: '0.4.3', updateAvailable: true },
			accounts: [{ name: 'GRIMTOTEM77', hasFile: true, recording: true, pending: 2, characters: 3, problem: 'GRIMTOTEM77 has no SavedVariables file yet.' }],
			running: false,
		},
		status: { kind: 'offline', title: "Can't reach the server", detail: `Token ${TOKEN} was refused for GRIMTOTEM77.`, action: 'retry', lastUpload: null, nextRetry: null },
		pending: 2,
		week: null,
		addons: {
			checkedAt: 1,
			checking: false,
			error: `Couldn't write ${HOME_MAC}/clientinfo.tmp: permission denied`,
			channel: 'stable',
			autoCheck: true,
			autoInstall: false,
			gameFound: true,
			gameRunning: false,
			products: [
				{ id: 'polestar', name: 'Polestar', blurb: '', installed: '0.4.2', latest: { version: '0.4.3' }, status: 'update', busy: null, progress: null },
				{ id: 'recorder', name: 'Polestar Recorder', blurb: '', installed: '0.3.0', latest: { version: '0.3.0' }, status: 'upToDate', busy: null, progress: null },
			],
		},
		community: { available: true, site: 'polestar.guide', base: '', defaultBase: '', telemetry: true, checkedAt: 1, checking: false, error: null, gameFound: true, gameRunning: false, autoUpdate: true, packs: [], link: null },
		update: null,
		custom: { community: null, server: null },
		...extra,
	};
}

const activity = [
	{ kind: 'failed', at: Date.UTC(2026, 10, 25, 14, 3), account: 'GRIMTOTEM77', chunks: 1, records: 1, bytes: 1, accepted: [], duplicate: [], rejected: [], message: `Upload for GRIMTOTEM77 failed: api_key=sk_live_9f8e7d6c5b4a3f2e1d0c reading /home/jsmith/.local/share/gg.polestar.client/queue` },
	{ kind: 'upload', at: Date.UTC(2026, 10, 25, 13, 0), account: 'GRIMTOTEM77', chunks: 1, records: 1, bytes: 1, accepted: [1], duplicate: [], rejected: [], message: null },
];

const input = (description, extra, act = activity) => ({ description, snapshot: snapshot(extra), activity: act, system: { os: 'macos aarch64', renderer: 'system default' } });

const LEAKS = ['GRIMTOTEM77', 'grimtotem77', 'jsmith', 'Kara Lynn', 'Kara', 'Lynn', TOKEN, 'sk_live_9f8e7d6c5b4a3f2e1d0c', 'Application Support', 'World of Warcraft', 'Doomhammer', 'Thrallina', '/Users/', 'C:\\', '/home/', 'kara@example.com'];

function assertClean(text) {
	for (const leak of LEAKS) assert.ok(!text.includes(leak), `the report shows ${JSON.stringify(leak)}:\n${text}`);
}

// The whole report and link.

test('a report built from a state that holds an account name, a token and paths shows none of them', () => {
	const text = reportText(input('The upload keeps failing since this morning.'));
	assertClean(text);
	assert.match(text, /<account>/);
	assert.match(text, /<path>/);
	assert.match(text, /<redacted>/);
});

test('what the player writes is redacted too: a pasted path, a token, an e-mail, the account and the user name', () => {
	const text = reportText(input(`Kara Lynn here. It fails on GRIMTOTEM77. My folder is C:\\Users\\Kara Lynn\\Games\\World of Warcraft\\_forever_\\WTF\\Account\\GRIMTOTEM77\\Doomhammer\\Thrallina\\SavedVariables\\Polestar.lua and ~/Desktop/log.txt, Bearer ${TOKEN}, mail kara@example.com. Lynn`));
	assertClean(text);
	assert.ok(!text.includes('~/Desktop'), text);
});

test('the GitHub link carries none of them either, encoded or not', () => {
	const url = issueUrl(input(`Broken for GRIMTOTEM77 at /Users/jsmith/Games token=${TOKEN}`));
	assertClean(url);
	assertClean(decodeURIComponent(url));
});

test('a Windows-only state shows none of its names or paths', () => {
	const root = 'D:\\Spiele\\World of Warcraft';
	const s = {
		dataDir: 'C:\\Users\\Kara Lynn\\AppData\\Roaming\\gg.polestar.client',
		game: { ...snapshot().game, root, dir: `${root}\\_forever_`, problem: null, candidates: [{ root, dir: `${root}\\_forever_`, client: '_forever_', version: '1.15.7.61582', accounts: 1, addonVersion: '0.4.2' }] },
		addons: { ...snapshot().addons, error: 'Could not write C:\\Users\\Kara Lynn\\AppData\\Roaming\\gg.polestar.client\\clientinfo.tmp' },
		status: { ...snapshot().status, detail: `D:\\Spiele\\World of Warcraft\\_forever_\\WTF\\Account\\GRIMTOTEM77\\Doomhammer\\Thrallina\\SavedVariables\\Polestar_Recorder.lua is locked` },
	};
	const text = reportText(input('Kara Lynn: nothing uploads', s));
	assertClean(text);
	assert.ok(!text.includes('Spiele') && !text.includes('AppData'), text);
	assertClean(decodeURIComponent(issueUrl(input('Kara Lynn: nothing uploads', s))));
});

test('the report keeps what a fix needs: versions, OS, status, problems and the recent failure', () => {
	const text = reportText(input('The upload keeps failing since this morning.'));
	for (const want of ['The upload keeps failing since this morning.', 'Polestar Client 0.1.9', 'macos aarch64', 'client 1.15.7.61582', 'Polestar 0.4.2 (0.4.3 available)', 'Polestar Recorder 0.3.0', "Status: Can't reach the server", 'Problem: Addons:', 'Failed 2026-11-25 14:03 UTC: upload']) {
		assert.ok(text.includes(want), `missing ${JSON.stringify(want)}:\n${text}`);
	}
});

test('the title is the first line of the description redacted with everything the report knows', () => {
	const s = { addons: { ...snapshot().addons, error: 'Could not read /home/zedquill/.config/x' } };
	const url = new URL(issueUrl(input('zedquill cannot upload\nmore', s, [])));
	assert.equal(url.searchParams.get('title'), 'Bug: Client: <user> cannot upload');
	assert.match(url.searchParams.get('steps'), /^<user> cannot upload/);
});

test('the link encodes spaces as %20, as the addon does', () => {
	const url = issueUrl(input('It stops'));
	assert.ok(url.includes('title=Bug%3A%20Client%3A%20It%20stops'), url.slice(0, 200));
	assert.ok(!url.includes('+'), url.slice(0, 200));
});

// Lengths.

test('the report fits a Discord message, and the link fits what GitHub accepts', () => {
	const long = 'The upload stops halfway. '.repeat(200);
	const text = reportText(input(long));
	assert.ok(text.length <= TEXT_MAX, `${text.length}`);
	assert.match(text, /Polestar Client 0\.1\.9/);
	const url = issueUrl(input(long));
	assert.ok(url.length <= LINK_MAX, `${url.length}`);
	assert.match(url, /^https:\/\/github\.com\/fitzforge\/polestar\/issues\/new\?template=bug-report\.yml&title=Bug%3A%20Client%3A%20/);
	const query = new URL(url).searchParams;
	assert.equal(query.get('version'), 'Polestar 0.4.2 · Polestar Client 0.1.9');
	assert.match(query.get('steps'), /^The upload stops halfway\./);
});

for (const [name, desc] of [
	['Chinese', '漢'.repeat(1000)],
	['emoji', '😀'.repeat(500)],
]) {
	test(`a ${name} description keeps the link within LINK_MAX, its block closed and no character cut in half`, () => {
		const url = issueUrl(input(desc));
		assert.ok(url.length <= LINK_MAX, `${url.length}`);
		const steps = new URL(url).searchParams.get('steps');
		assert.match(steps, /\n```$/);
		assert.equal((steps.match(/```/g) ?? []).length % 2, 0);
		assert.ok(!/[\uD800-\uDBFF](?![\uDC00-\uDFFF])/.test(steps), 'a lone high surrogate');
		const text = reportText(input(desc));
		assert.ok(text.length <= TEXT_MAX, `${text.length}`);
		assert.match(text, /\n```$/);
	});
}

test('a ``` in a detail line does not close the block early', () => {
	const s = { status: { ...snapshot().status, detail: 'the server said ```oops```' } };
	const text = reportText(input('It fails', s));
	const fence = text.match(/\n(`{3,})text\n/)[1];
	assert.ok(fence.length >= 4, text);
	assert.ok(text.endsWith(`\n${fence}`), text);
});

test('the report waits for a few words from the player', () => {
	assert.equal(ready(''), false);
	assert.equal(ready('x'.repeat(DESC_MIN - 1)), false);
	assert.equal(ready('It crashed'), true);
});

test('the account names come from the game and from the activity list', () => {
	const s = snapshot();
	s.game.accounts = [];
	const priv = privateOf(s, activity);
	assert.deepEqual(priv.names, ['GRIMTOTEM77']);
	assert.ok(priv.paths.includes(HOME_MAC));
});

// One test per rule.

test('rule "quoted path": a quoted path is read to its closing quote, spaces and all', () => {
	assert.equal(redact('Open "C:\\Games\\z w.lua" now', NONE), 'Open "<path>" now');
	assert.equal(redact("Open '/Users/zed/My Games/a b.txt' now", NONE), "Open '<path>' now");
});

test('rule "known path": a folder the client knows, outside the path shapes, and the folders after it', () => {
	const priv = { names: [], paths: ['/games/World of Warcraft'] };
	assert.equal(redact('Failed in /games/World of Warcraft/_forever_/Logs ok', priv), 'Failed in <path> ok');
	assert.equal(redact('Failed in \\games\\World of Warcraft ok', priv), 'Failed in <path> ok');
});

test('rule "known path": the realm and character after a known game folder go too', () => {
	const priv = { names: ['GRIMTOTEM77'], paths: [ROOT_WIN] };
	assert.equal(redact(`${ROOT_WIN}\\WTF\\Account\\GRIMTOTEM77\\Doomhammer\\Thrallina\\SavedVariables\\X.lua`, priv), '<path>');
});

test('rule "path link": file:// and network share links', () => {
	assert.equal(redact('see file:///Users/jsmith/notes.txt', NONE), 'see <path>');
	assert.equal(redact('see smb://nas/share/wow/x', NONE), 'see <path>');
});

test('rule "WTF account folder": an account folder path with no drive in front', () => {
	assert.equal(redact('WTF\\Account\\AB\\Doomhammer\\Thrallina\\SavedVariables\\X.lua is locked', NONE), '<path> is locked');
	assert.equal(redact('in WTF/Account/AB/Doomhammer/Thrallina', NONE), 'in <path>');
});

test('rule "GitHub token"', () => {
	assert.equal(redact('got ghp_abcdefghijklmnopqrstuvwxyzABCD12 back', NONE), 'got <redacted> back');
	assert.equal(redact('got github_pat_abcdefghijklmnopqrstuvwxyz back', NONE), 'got <redacted> back');
});

test('rule "AWS key"', () => {
	assert.equal(redact('key AKIAABCDEFGHIJKLMNOP here', NONE), 'key <redacted> here');
});

test('rule "JWT": the header, payload and signature', () => {
	assert.equal(redact('jwt eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ4In0.c2lnbmF0dXJl end', NONE), 'jwt <redacted> end');
});

test('rule "bearer"', () => {
	assert.equal(redact('sent Bearer abcdefghijkl', NONE), 'sent Bearer <redacted>');
});

test('rule "keyed secret": a key name with or without a prefix, and an Authorization scheme', () => {
	assert.equal(redact('refresh_token=abcdefgh&x=1', NONE), 'refresh_token=<redacted>&x=1');
	assert.equal(redact('client_secret: hunter2', NONE), 'client_secret: <redacted>');
	assert.equal(redact('Authorization: Basic dXNlcjpwYXNz', NONE), 'Authorization: Basic <redacted>');
	assert.equal(redact('password="a b c"', NONE), 'password=<redacted>');
	assert.equal(redact('{"token":"a1b2c3d4","password":"hunter2","id":7}', NONE), '{"token":<redacted>,"password":<redacted>,"id":7}');
	assert.equal(redact('{"Authorization":"Bearer abc"}', NONE), '{"Authorization":<redacted>');
});

test('rule "e-mail"', () => {
	assert.equal(redact('mail kara.lynn+wow@example.co.uk now', NONE), 'mail <email> now');
});

test('rule "Windows path": a drive, a long-path prefix and a network share; spaced folders inside the path', () => {
	assert.equal(redact('C:\\Games\\WoW\\x.log failed', NONE), '<path> failed');
	assert.equal(redact('at \\\\?\\C:\\Games\\x.log', NONE), 'at <path>');
	assert.equal(redact('at \\\\nas\\share\\x.log', NONE), 'at <path>');
	assert.equal(redact('at D:\\Program Files (x86)\\WoW\\x.log done', NONE), 'at <path> done');
});

test('rule "POSIX path": the words between two paths stay; ~ and ~user', () => {
	assert.equal(redact('/etc/hosts and /usr/bin/node', NONE), '<path> and <path>');
	assert.equal(redact('In ~/Desktop/log.txt, see https://github.com/fitzforge/polestar/issues/832 then /reload', NONE), 'In <path>, see https://github.com/fitzforge/polestar/issues/832 then /reload');
	assert.equal(redact('~karalyn/notes.txt; karalyn said', NONE), '<path>; <user> said');
});

test('rule "opaque token": a long mixed run goes; commit hashes and UUIDs stay', () => {
	assert.equal(redact('id k9Xq2Lm8Rt4Vb7Np3Zw6 end', NONE), 'id <redacted> end');
	assert.equal(redact('commit 3f9a2b1c4d5e6f708192a3b4c5d6e7f809a1b2c3', NONE), 'commit 3f9a2b1c4d5e6f708192a3b4c5d6e7f809a1b2c3');
	assert.equal(redact('id 123e4567-e89b-12d3-a456-426614174000', NONE), 'id 123e4567-e89b-12d3-a456-426614174000');
	assert.equal(redact('Polestar 0.4.3, client 1.15.7.61582, session ended', NONE), 'Polestar 0.4.3, client 1.15.7.61582, session ended');
});

test('rule "account name": any case as a word; a short name only as the whole text', () => {
	assert.equal(redact('grimtotem77 failed', { names: ['GRIMTOTEM77'], paths: [] }), '<account> failed');
	assert.equal(redact('a cat sat', { names: ['A'], paths: [] }), 'a cat sat');
	assert.equal(redact('A', { names: ['A'], paths: [] }), '<account>');
});

test('rule "user name": the home folder name, in its own case, with a space, or with punctuation after it', () => {
	assert.equal(redact('jsmith said hi', { names: [], paths: ['/Users/jsmith/x'] }), '<user> said hi');
	assert.equal(redact('Will said it will not update', { names: [], paths: ['/Users/Will/x'] }), '<user> said it will not update');
	assert.equal(redact('Kara Lynn cannot log in; Lynn again', { names: [], paths: [ROOT_WIN] }), '<user> cannot log in; <user> again');
	assert.equal(redact('see /Users/jsmith. jsmith said', NONE), 'see <path>. <user> said');
	// A short lower-case home name is a word too: it goes inside paths, the prose keeps it.
	assert.equal(redact('Update all will not finish in /Users/will/x', NONE), 'Update all will not finish in <path>');
});

test('a path whose last folder has a space: the known user name still goes; an unknown one is cut at the space', () => {
	// Known (the game folder is under C:\Users\Kara Lynn): every word of the name goes.
	assert.equal(redact('C:\\Users\\Kara Lynn', { names: [], paths: [ROOT_WIN] }), '<path> <user>');
	// Unknown and unquoted, a path ends at its first space, so the words after it stay as text:
	// "Zed" is read as the user name, "Quill" is not.
	assert.equal(redact('C:\\Users\\Zed Quill', NONE), '<path> Quill');
	assert.equal(redact('"C:\\Users\\Zed Quill"', NONE), '"<path>"');
});

test('rule "known path": a drive root the client knows is a path only with its separator', () => {
	const priv = { names: [], paths: ['D:\\'] };
	assert.equal(redact('Failed: nothing recently', priv), 'Failed: nothing recently');
	assert.equal(redact('at D:\\Games\\x.log and d:/y', priv), 'at <path> and <path>');
});

test('rule "quoted path": an apostrophe inside a double-quoted path', () => {
	assert.equal(redact('"C:\\Users\\O\'Brien\\Games\\x.lua" ok', NONE), '"<path>" ok');
});

test('rule "keyed secret": words that only end like a key name stay', () => {
	for (const text of ['hotkey=F5', 'monkey: yes', 'Session: 2 hours', 'author: Fitz', 'Key: value']) assert.equal(redact(text, NONE), text);
	assert.equal(redact('x-api-key: abc123', NONE), 'x-api-key: <redacted>');
	assert.equal(redact('session_id=abc123 next', NONE), 'session_id=<redacted> next');
	assert.equal(redact('user_session=abc123 next', NONE), 'user_session=<redacted> next');
});

test('rule "keyed secret": a cookie or credential header is redacted to the end of its line', () => {
	assert.equal(redact('Cookie: a=b; c=d; sid=xyz\nnext line', NONE), 'Cookie: <redacted>\nnext line');
	assert.equal(redact('Set-Cookie: sid=xyz; Path=/; HttpOnly', NONE), 'Set-Cookie: <redacted>');
	assert.equal(redact('Authorization: Bearer abc.def ghi', NONE), 'Authorization: Bearer <redacted>');
});

test('one over-long detail line is cut and the lines after it stay', () => {
	const s = { status: { ...snapshot().status, detail: 'x '.repeat(2100) } };
	const text = reportText(input('It fails', s));
	assert.ok(text.length <= TEXT_MAX, `${text.length}`);
	for (const want of ['Sharing: on', 'Problem: Addons:', 'Failed 2026-11-25 14:03 UTC']) assert.ok(text.includes(want), `missing ${want}:\n${text}`);
	const status = text.split('\n').find((l) => l.startsWith('Status:'));
	assert.ok(status.length <= LINE_MAX && status.endsWith('...'), status);
});
