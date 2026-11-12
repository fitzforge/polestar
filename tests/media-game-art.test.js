'use strict';
// `polestar media game-art` and wago.tools: CI reads the atlas tables from the
// cache with --offline (no request at all), a wago.tools outage falls back to
// the newest cached build holding them, and a 429/5xx is retried before it
// fails a run.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const gameArt = require('../tools/media/game-art');
const { fetchText, BUILDS_URL } = require('../tools/lib/data/wago');
const { tmpdir } = require('./helpers/tmp');

// One retail member per element the skin draws, in one 256x256 atlas.
function atlasCsv() {
	const els = ['ID,Name', ...gameArt.ELEMENTS.map((n, i) => `${i + 1},${n}`)];
	const members = ['ID,UiTextureAtlasElementID,UiTextureAtlasID,CommittedName,Width,Height,CommittedLeft,CommittedRight,CommittedTop,CommittedBottom', ...gameArt.ELEMENTS.map((n, i) => `${i + 1},${i + 1},7,${n},32,16,0,32,0,16`)];
	return {
		UiTextureAtlas: 'ID,FileDataID,AtlasWidth,AtlasHeight\n7,123456,256,256\n',
		UiTextureAtlasElement: `${els.join('\n')}\n`,
		UiTextureAtlasMember: `${members.join('\n')}\n`,
		UiTextureAtlasElementSliceData: 'ID,UiTextureAtlasElementID,Left,Top,Right,Bottom\n1,1,4,4,4,4\n',
	};
}

// 1.60.1.70500 holds the atlas tables; the newer 1.60.1.70600 only the map
// tables `forge data sources --only wago` fetches.
function cache() {
	const sourcesDir = tmpdir('polestar-game-art-');
	const put = (build, files) => {
		const dir = path.join(sourcesDir, 'wago', build);
		fs.mkdirSync(dir, { recursive: true });
		for (const [t, text] of Object.entries(files)) fs.writeFileSync(path.join(dir, `${t}.csv`), text);
	};
	put('1.60.1.70500', atlasCsv());
	put('1.60.1.70600', { UiMap: 'ID\n1\n', UiMapAssignment: 'ID\n1\n', AreaTable: 'ID\n1\n' });
	// The generator writes beside the addon folder it is given (addon/Polestar):
	// into the game looks' own part, addon/Polestar_Looks.
	const addons = tmpdir('polestar-game-art-addon-');
	const addon = path.join(addons, 'Polestar');
	fs.mkdirSync(addon);
	fs.mkdirSync(path.join(addons, 'Polestar_Looks'));
	return { sourcesDir, addon };
}

const header = (addon) => fs.readFileSync(path.join(addon, '..', 'Polestar_Looks', 'GameArt.lua'), 'utf8').split('\n')[1];

test('game-art --offline reads the newest cached build holding its tables and asks wago.tools nothing', async () => {
	const { sourcesDir, addon } = cache();
	const calls = [];
	const fetchImpl = async (url) => calls.push(url) && assert.fail(`fetched ${url}`);
	await gameArt.generate(addon, { offline: true, sourcesDir, fetchImpl });
	assert.deepEqual(calls, []);
	assert.match(header(addon), /build 1\.60\.1\.70500\./);
});

test('with wago.tools down, game-art falls back to the cached build holding its tables', async () => {
	const { sourcesDir, addon } = cache();
	const calls = [];
	const fetchImpl = async (url) => {
		calls.push(url);
		throw new Error('getaddrinfo ENOTFOUND wago.tools');
	};
	await gameArt.generate(addon, { sourcesDir, fetchImpl });
	assert.deepEqual(calls, [BUILDS_URL], 'only the build list was asked for; every table came from the cache');
	assert.match(header(addon), /build 1\.60\.1\.70500\./);
});

test('wago.tools 429/5xx are retried after each delay, then fail; a 404 fails at once', async () => {
	const waits = [];
	const wait = async (ms) => waits.push(ms);
	const respond = (statuses) => {
		const seen = [];
		const impl = async (url, init) => {
			seen.push(init.headers['user-agent']);
			const status = statuses.shift();
			return { ok: status === 200, status, text: async () => 'ID\n1\n' };
		};
		return { impl, seen };
	};
	const ok = respond([522, 500, 200]);
	assert.equal(await fetchText(ok.impl, 'https://wago.tools/x', { userAgent: 'polestar-media', delays: [5, 9], wait }), 'ID\n1\n');
	assert.deepEqual(waits, [5, 9]);
	assert.deepEqual(ok.seen, ['polestar-media', 'polestar-media', 'polestar-media'], 'every try names us');
	waits.length = 0;
	await assert.rejects(fetchText(respond([521, 429, 503]).impl, 'https://wago.tools/x', { delays: [5, 9], wait }), /HTTP 503/);
	assert.deepEqual(waits, [5, 9]);
	waits.length = 0;
	await assert.rejects(fetchText(respond([404]).impl, 'https://wago.tools/x', { delays: [5, 9], wait }), /HTTP 404/);
	assert.deepEqual(waits, []);
});
