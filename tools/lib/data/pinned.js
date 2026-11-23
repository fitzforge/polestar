'use strict';
// The Forever client build reference data was read from (meta.json's "World
// of Warcraft: Forever client tables" source) and the tables of that build the
// compile reads, cached beside the data folder (data/sources/wago/<build> for
// data/forever). The same rule as forge (forge-guide tokens.rs,
// check_pinned_tables): data read from a build compiles only with that
// build's tables, since without them spell names stay words and places lose
// their area.

const fs = require('node:fs');
const path = require('node:path');

const SOURCE = /^World of Warcraft: Forever client tables/;

// -> { build, tables: [the tables the source lists, in its name's brackets] },
// or null when the data names no build.
function pinnedBuild(meta) {
	const src = ((meta && meta.sources) || []).find((x) => x && SOURCE.test(String(x.name)));
	const m = src && /(\d+\.\d+\.\d+\.\d+)/.exec(String(src.revision || ''));
	if (!m) return null;
	const list = /\(([^)]*)\)/.exec(String(src.name));
	return { build: m[1], tables: list ? list[1].split(',').map((t) => t.trim()) : [] };
}

// That build's folder in the sources beside the data folder `dir`.
function buildDir(dir, build) {
	return path.join(dir, '..', 'sources', 'wago', build);
}

// The files of the build the compile reads: SpellName and SkillLineAbility
// (spell tokens) when the source lists SpellName, and AreaTable (places by ID)
// unless it lists the tables it read without it.
function neededTables(pin) {
	const need = [];
	if (pin.tables.includes('SpellName')) need.push('SpellName.csv', 'SkillLineAbility.csv');
	if (!pin.tables.length || pin.tables.includes('AreaTable')) need.push('AreaTable.csv');
	return need;
}

// Throws when the data in `dir` (its meta.json `meta`) was read from a Forever
// client build whose tables are not in the sources beside it, naming the
// build, the folder and the missing tables.
function checkPinnedTables(meta, dir) {
	const pin = pinnedBuild(meta);
	if (!pin || !dir) return;
	const wago = buildDir(dir, pin.build);
	const missing = neededTables(pin).filter((f) => !fs.existsSync(path.join(wago, f)));
	if (!missing.length) return;
	throw new Error(
		`the reference data was built from Forever client build ${pin.build}, but ${wago} lacks ${missing.join(', ')}: the guide texts would read differently (spell names as words, places without their area) and their translations as stale. Put the sources the data was built with beside it, or rebuild the data with \`forge data build\``,
	);
}

module.exports = { pinnedBuild, buildDir, checkPinnedTables };
