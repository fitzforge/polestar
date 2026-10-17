'use strict';
// Blizzard client tables (DB2) as CSV from wago.tools, cached per build under
// <sources>/wago/<build>/<Table>.csv. Cached builds are immutable, so a
// present cache file is never re-downloaded.
//
// Two products: Classic Era (`wow_classic_era`, 1.13-1.15, the frame pfQuest
// coordinates are in) and Forever (`wow_classic_beta` during the beta, which
// also lists 5.5 Mists builds, so only its 1.60+ builds count).

const fs = require('node:fs');
const path = require('node:path');
const { parseCsv } = require('./csv');

const BUILDS_URL = 'https://wago.tools/api/builds';
// `optional` tables are fetched like the rest, but a build without them still
// loads (tables[t] stays undefined, with a warning).
const PRODUCTS = {
	era: { key: 'wow_classic_era', family: /^1\.1[0-5]\./, tables: ['UiMap', 'UiMapAssignment', 'AreaTable', 'Faction'], optional: [] },
	forever: { key: 'wow_classic_beta', family: /^1\.6\d\./, tables: ['UiMap', 'UiMapAssignment', 'AreaTable'], optional: ['ChrRaces', 'ChrClasses', 'CharBaseInfo', 'Faction', 'Map', 'ItemSparse'] },
};
const PRODUCT = PRODUCTS.era.key;
const TABLES = PRODUCTS.era.tables;
// A build version names a cache folder: digits and dots only (security L10).
const BUILD_RE = /^\d+(\.\d+)+$/;

// locale: a client language (deDE...): the table's strings in it; none for English.
function tableUrl(table, build, locale = null) {
	return `https://wago.tools/db2/${table}/csv?build=${encodeURIComponent(build)}${locale ? `&locale=${encodeURIComponent(locale)}` : ''}`;
}

function compareVersions(a, b) {
	const pa = String(a).split('.').map(Number);
	const pb = String(b).split('.').map(Number);
	for (let i = 0; i < Math.max(pa.length, pb.length); i++) {
		const d = (pa[i] || 0) - (pb[i] || 0);
		if (d) return d;
	}
	return 0;
}

// The newest cached build of product holding every one of tables.
function newestCachedBuild(cacheRoot, product, tables = product.tables) {
	if (!fs.existsSync(cacheRoot)) return null;
	const builds = fs
		.readdirSync(cacheRoot)
		.filter((b) => BUILD_RE.test(b) && product.family.test(b) && tables.every((t) => fs.existsSync(path.join(cacheRoot, b, `${t}.csv`))))
		.sort(compareVersions);
	return builds.length ? builds[builds.length - 1] : null;
}

async function fetchText(fetchImpl, url) {
	const res = await fetchImpl(url, { headers: { 'user-agent': 'polestar-data-build' } });
	if (!res.ok) throw new Error(`GET ${url}: HTTP ${res.status}`);
	return res.text();
}

async function latestBuild(fetchImpl, product) {
	const builds = JSON.parse(await fetchText(fetchImpl, BUILDS_URL));
	const listed = Array.isArray(builds[product.key]) ? builds[product.key].map((b) => b.version).filter(Boolean) : [];
	const list = listed.filter((v) => typeof v === 'string' && BUILD_RE.test(v) && product.family.test(v));
	if (!list.length) throw new Error(`${BUILDS_URL}: no ${product.key} ${product.family.source} builds listed`);
	return list.sort(compareVersions)[list.length - 1];
}

// The rows of client table `table` of `build`: the cached
// <sourcesDir>/wago/<build>/<table>.csv (<build>/<locale>/<table>.csv for a
// language's strings), else fetched (`get(url)` -> text, checked to be a DB2
// CSV export) and cached, written atomically. Offline, a missing file throws
// `missing(file)` (default an Error naming it).
async function cachedTable({ sourcesDir, build, table, locale = null, offline = false, get, missing, log = () => {} }) {
	if (locale && !/^[a-z]{2}[A-Z]{2}$/.test(locale)) throw new Error(`wago: bad locale "${locale}"`);
	const file = path.join(sourcesDir, 'wago', build, ...(locale ? [locale] : []), `${table}.csv`);
	if (fs.existsSync(file)) return parseCsv(fs.readFileSync(file, 'utf8'));
	if (offline) throw missing ? missing(file) : new Error(`--offline: missing cached ${path.relative(process.cwd(), file)}`);
	const url = tableUrl(table, build, locale);
	log(`fetching ${url}`);
	const text = await get(url);
	const rows = parseCsv(text);
	if (!rows.length || !('ID' in rows[0])) throw new Error(`${url}: not a DB2 CSV export`);
	fs.mkdirSync(path.dirname(file), { recursive: true });
	const tmp = `${file}.${process.pid}.tmp`;
	fs.writeFileSync(tmp, text);
	fs.renameSync(tmp, file);
	return rows;
}

// The build to read: `build` when given, else the newest wago.tools lists for
// the product, else (offline, or wago.tools unreachable) the newest cached
// one holding `tables` (default the product's). -> { build, warnings }
async function pickBuild({ sourcesDir, build, offline = false, fetchImpl = globalThis.fetch, product: name = 'era', tables }) {
	const product = PRODUCTS[name];
	if (!product) throw new Error(`wago: unknown product "${name}"`);
	if (build) return { build, warnings: [] };
	const cacheRoot = path.join(sourcesDir, 'wago');
	if (offline) {
		const cached = newestCachedBuild(cacheRoot, product, tables);
		if (!cached) throw new Error(`--offline: no cached wago.tools build under ${cacheRoot} (${product.key})`);
		return { build: cached, warnings: [] };
	}
	try {
		return { build: await latestBuild(fetchImpl, product), warnings: [] };
	} catch (err) {
		const cached = newestCachedBuild(cacheRoot, product, tables);
		if (!cached) throw err;
		return { build: cached, warnings: [`wago.tools: ${err.message}; using cached ${product.key} build ${cached}`] };
	}
}

// -> { build, product, tables: { UiMap: rows, ... }, urls, warnings }
// product: "era" (default) or "forever".
async function loadWago({ sourcesDir, build, offline = false, fetchImpl = globalThis.fetch, log = () => {}, product: name = 'era' }) {
	const product = PRODUCTS[name];
	if (!product) throw new Error(`wago: unknown product "${name}"`);
	const picked = await pickBuild({ sourcesDir, build, offline, fetchImpl, product: name });
	const warnings = picked.warnings;
	const chosen = picked.build;
	const tables = {};
	const urls = {};
	const load = async (t) => {
		urls[t] = tableUrl(t, chosen);
		tables[t] = await cachedTable({ sourcesDir, build: chosen, table: t, offline, get: (url) => fetchText(fetchImpl, url), log });
	};
	for (const t of product.tables) await load(t);
	for (const t of product.optional) {
		try {
			await load(t);
		} catch (err) {
			delete urls[t];
			warnings.push(`wago.tools ${product.key} ${chosen}: no ${t} (${err.message})`);
		}
	}
	return { build: chosen, product: product.key, tables, urls, warnings };
}

module.exports = { loadWago, pickBuild, cachedTable, compareVersions, tableUrl, TABLES, PRODUCT, PRODUCTS, BUILDS_URL };
