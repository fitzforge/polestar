'use strict';
// `itemdb build`: Blizzard Classic Era item tables (wago.tools) -> the
// load-on-demand data addon addon/Polestar_ItemDB (Items.lua + TOC) that
// Polestar.Gear scores items from. Same inputs give byte-identical output.

const fs = require('node:fs');
const path = require('node:path');
const { loadTables } = require('../professions/tables');
const { header } = require('../generated');
const { extractItems, encode } = require('./stats');

const { ROOT, SOURCES } = require('../paths');
const TABLES = ['ItemSparse', 'Item', 'ItemEffect', 'SpellEffect'];
const ADDON = 'Polestar_ItemDB';
const SCHEMA = 1;

function luaStr(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n')}"`;
}

// -> Items.lua text. One Register call; every entry is a number key and one
// string constant, far below Lua 5.1's per-function constant limit.
function emitLua(items, build) {
	const lines = [
		header('lua', 'itemdb build', 'the Blizzard Classic Era client tables'),
		`-- Blizzard Classic Era client tables (wago.tools build ${build}): ItemSparse, Item,`,
		'-- ItemEffect, SpellEffect. Game data (c) Blizzard Entertainment, used as facts.',
		'-- Entry: "<inventoryType> <itemLevel> <requiredLevel> <quality> <classID> <subclassID>',
		'-- [<stat><n> ...] [dmin<n> dmax<n> speed<ms>] [cls<classMask>] [uniq1]"; mpr = mp5, hpr = hp5.',
		'',
		'local DB = Polestar and Polestar.ItemDB',
		'if not (DB and DB.Register) then return end',
		'',
		`DB.Register({ schema = ${SCHEMA}, build = ${luaStr(build)}, count = ${items.length} }, {`,
	];
	for (const rec of items) lines.push(`[${rec.id}]=${luaStr(encode(rec))},`);
	lines.push('})', '');
	return lines.join('\n');
}

// `files`: the data files in load order. Forever.lua (written by `gear build`
// from ForeverLevelingBiS) loads after Items.lua and overlays it.
function emitToc(version, files = ['Items.lua']) {
	return [
		'## Interface: 16001',
		'## Title: Polestar Item Data',
		'## Notes: Item stats for Polestar\'s gear advice. Loaded on demand.',
		...require('../i18n/toc').tocLines('Polestar_ItemDB'),
		'## Author: Polestar',
		'## X-License: GPL-3.0-only',
		`## Version: ${version}`,
		'## Category: Quests',
		'## LoadOnDemand: 1',
		'## Dependencies: Polestar',
		'',
		...files,
		'',
	].join('\n');
}

// The data files present in the pack folder, in load order.
function packFiles(outDir) {
	return ['Items.lua', 'Forever.lua'].filter((f) => f === 'Items.lua' || fs.existsSync(path.join(outDir, f)));
}

function packageVersion() {
	try {
		return JSON.parse(fs.readFileSync(path.join(ROOT, 'package.json'), 'utf8')).version || '0.0.0';
	} catch {
		return '0.0.0';
	}
}

// -> { build, outDir, count, bytes, skipped, warnings }
async function buildItemDb({ sourcesDir, build, offline, outDir, fetchImpl, log = () => {} } = {}) {
	sourcesDir = sourcesDir || SOURCES;
	outDir = outDir || path.join(ROOT, 'addon', ADDON);
	const loaded = await loadTables({ sourcesDir, build, offline, fetchImpl, log, tables: TABLES });
	const { items, skipped } = extractItems(loaded.tables);
	if (!items.length) throw new Error(`build ${loaded.build}: no equippable items found (wrong tables?)`);
	const lua = emitLua(items, loaded.build);
	fs.mkdirSync(outDir, { recursive: true });
	const luaFile = path.join(outDir, 'Items.lua');
	fs.writeFileSync(`${luaFile}.tmp`, lua);
	fs.renameSync(`${luaFile}.tmp`, luaFile);
	fs.writeFileSync(path.join(outDir, `${ADDON}.toc`), emitToc(packageVersion(), packFiles(outDir)));
	return { build: loaded.build, outDir, count: items.length, bytes: Buffer.byteLength(lua), skipped, warnings: loaded.warnings };
}

module.exports = { buildItemDb, emitLua, emitToc, packFiles, packageVersion, TABLES, ADDON, SCHEMA };
