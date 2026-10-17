'use strict';
// `i18n names`: the client's own strings in each language, from the client's
// tables (DB2) as wago.tools exports them with `&locale=`
// (tools/lib/data/wago.js), cached per build and language in
// data/sources/wago/<build>/<locale>/<Table>.csv. The client's text is the
// most exact name there is, so these come before Wowhead, DingDB and pfQuest.
//
// From the Forever client's tables:
//   item       ItemSparse.Display_lang
//   map        Map.MapName_lang (instance maps: dungeon and raid names)
//   encounter  DungeonEncounter.Name_lang (bosses, events among them)
//   faction    Faction.Name_lang
//   taxi       TaxiNodes.Name_lang (flight points)
// Forever's ItemSparse holds only part of the Classic items (the rest load
// from the server): for those, the Classic Era client's ItemSparse, whose
// items Forever kept. Forever's newest items are in neither: Wowhead names
// those. Areas need nothing here: the client names them by id
// (C_Map.GetAreaInfo, Compat.GetAreaName) from the same AreaTable.

const fs = require('node:fs');
const path = require('node:path');
const { cachedTable, compareVersions, PRODUCTS } = require('../data/wago');

const TABLES = {
	item: { table: 'ItemSparse', field: 'Display_lang' },
	map: { table: 'Map', field: 'MapName_lang' },
	encounter: { table: 'DungeonEncounter', field: 'Name_lang' },
	faction: { table: 'Faction', field: 'Name_lang' },
	taxi: { table: 'TaxiNodes', field: 'Name_lang' },
};
const KINDS = Object.keys(TABLES);
// Each product's kinds: Forever's every one, the Era client's items behind them.
const PRODUCT_KINDS = { forever: KINDS, era: ['item'] };
const BUILDS_URL = 'https://wago.tools/api/builds';

async function fetchText(fetchImpl, url) {
	const res = await fetchImpl(url, { headers: { 'user-agent': 'polestar-names-build' } });
	if (!res.ok) throw new Error(`GET ${url}: HTTP ${res.status}`);
	return res.text();
}

const tableFile = (sourcesDir, build, locale, table) => path.join(sourcesDir, 'wago', build, ...(locale ? [locale] : []), `${table}.csv`);

// The cached builds of product holding every table of kinds in English and
// in every locale, newest first.
function completeBuilds(sourcesDir, product, kinds, locales) {
	const root = path.join(sourcesDir, 'wago');
	if (!fs.existsSync(root)) return [];
	const tables = kinds.map((k) => TABLES[k].table);
	return fs.readdirSync(root)
		.filter((b) => /^\d+(\.\d+)+$/.test(b) && PRODUCTS[product].family.test(b))
		.filter((b) => [null, ...locales].every((l) => tables.every((t) => fs.existsSync(tableFile(sourcesDir, b, l, t)))))
		.sort(compareVersions)
		.reverse();
}

// The newest build wago.tools lists for product, or null.
async function listedBuild(fetchImpl, product) {
	try {
		const builds = JSON.parse(await fetchText(fetchImpl, BUILDS_URL));
		const list = (builds[PRODUCTS[product].key] || []).map((b) => b.version).filter((v) => typeof v === 'string' && PRODUCTS[product].family.test(v));
		return list.sort(compareVersions).pop() || null;
	} catch {
		return null;
	}
}

// One build's tables of kinds in English and each language:
// { names: { [locale]: { kind: Map id -> name } }, english: { kind: Map }, urls }.
// Throws when a table can be neither read from the cache nor fetched.
async function loadTables({ sourcesDir, build, locales, kinds, offline, fetchImpl, log }) {
	const read = async (locale, kind) => {
		const { table, field } = TABLES[kind];
		const rows = await cachedTable({ sourcesDir, build, table, locale, offline, get: (url) => fetchText(fetchImpl, url), log });
		const m = new Map();
		for (const r of rows) {
			const id = Number(r.ID);
			const name = typeof r[field] === 'string' ? r[field].trim() : '';
			if (id > 0 && name) m.set(id, name);
		}
		return m;
	};
	const out = { names: {}, english: {}, urls: [] };
	for (const kind of kinds) {
		out.english[kind] = await read(null, kind);
		out.urls.push(`https://wago.tools/db2/${TABLES[kind].table}/csv?build=${build}&locale=<locale>`);
	}
	for (const locale of locales) {
		out.names[locale] = {};
		for (const kind of kinds) out.names[locale][kind] = await read(locale, kind);
	}
	return out;
}

// The client tables of each language: Forever's, then the Era client's items
// for the ids Forever's lack. Each product's build: `forever`/`era` when
// given; else the newest wago.tools lists (offline: none), falling back to
// the newest cached build holding every table this reads in English and in
// every language asked. A product with no such build throws: a pack without
// its instances, factions and flight points is never written silently.
// -> { names: { [locale]: { kind: Map id -> name } }, english: { kind: Map },
// builds: { forever, era }, urls }
async function loadClientNames({ sourcesDir, locales, forever, era, offline = false, fetchImpl = globalThis.fetch, log = () => {} }) {
	const out = {
		names: Object.fromEntries(locales.map((l) => [l, Object.fromEntries(KINDS.map((k) => [k, new Map()]))])),
		english: Object.fromEntries(KINDS.map((k) => [k, new Map()])),
		builds: {},
		urls: [],
	};
	for (const [product, given] of [['forever', forever], ['era', era]]) {
		const kinds = PRODUCT_KINDS[product];
		const tries = given ? [given] : [...new Set([offline ? null : await listedBuild(fetchImpl, product), ...completeBuilds(sourcesDir, product, kinds, locales)].filter(Boolean))];
		let got = null;
		let build = null;
		const errors = [];
		for (const b of tries) {
			try {
				got = await loadTables({ sourcesDir, build: b, locales, kinds, offline, fetchImpl, log });
				build = b;
				break;
			} catch (err) {
				errors.push(`${b}: ${err.message}`);
			}
		}
		if (!got) {
			throw new Error(`no ${product} client tables (${kinds.map((k) => TABLES[k].table).join(', ')}) for ${locales.join(', ')}${errors.length ? `: ${errors.join('; ')}` : ' cached'}; run once online, or pass the build`);
		}
		out.builds[product] = build;
		out.urls.push(...got.urls);
		for (const k of kinds) for (const [id, n] of got.english[k]) if (!out.english[k].has(id)) out.english[k].set(id, n);
		for (const l of locales) {
			for (const k of kinds) for (const [id, n] of got.names[l][k]) if (!out.names[l][k].has(id)) out.names[l][k].set(id, n);
		}
	}
	return out;
}

module.exports = { TABLES, KINDS, PRODUCT_KINDS, loadClientNames, completeBuilds };
