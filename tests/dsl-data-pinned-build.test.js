'use strict';
// Reference data read from a Forever client build (meta.json's client tables
// source names it) loads only with that build's tables in the sources beside
// it: with another build's, or none, guides would compile with spell names as
// words and places without their area, and tests would fail for that reason.
// loadData stops with one error naming the build, the folder and the missing
// tables, as forge does (forge-guide tokens.rs check_pinned_tables; the
// guide_cli.rs and i18n_cli.rs tests).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA_DIR } = require('./helpers/dsl');
const { tmpdir } = require('./helpers/tmp');
const { loadData } = require('../tools/lib/dsl/data');

const AREA_TABLE = 'ID,ZoneName,AreaName_lang,ContinentID,ParentAreaID\n12,Elwynn,"Elwynn Forest",0,0\n';
const ALL = ['AreaTable', 'SpellName', 'SkillLineAbility'];

// The fixture data in <root>/forever, its meta naming client build `build`
// read with the tables `listed` (null: a source name without the list), and
// in <root>/sources/wago/<build> the tables `cached` gives each build.
function pinned(build, listed, cached) {
	const root = tmpdir('polestar-pinned-');
	const dir = path.join(root, 'forever');
	fs.cpSync(DATA_DIR, dir, { recursive: true });
	const meta = JSON.parse(fs.readFileSync(path.join(dir, 'meta.json'), 'utf8'));
	const name = listed ? `World of Warcraft: Forever client tables (${listed.join(', ')}) via wago.tools` : 'World of Warcraft: Forever client tables';
	meta.sources.push({ name, revision: `wow_classic_beta ${build}` });
	fs.writeFileSync(path.join(dir, 'meta.json'), JSON.stringify(meta));
	for (const [b, tables] of Object.entries(cached)) {
		const wago = path.join(root, 'sources', 'wago', b);
		fs.mkdirSync(wago, { recursive: true });
		for (const t of tables) fs.writeFileSync(path.join(wago, `${t}.csv`), t === 'AreaTable' ? AREA_TABLE : 'ID,Name_lang\n');
	}
	return { root, dir };
}

test("data read from a client build loads only with that build's tables beside it; the error names the build, the folder and what is missing", () => {
	const listed = ['UiMap', 'UiMapAssignment', 'AreaTable', 'SpellName'];
	// Another build's tables, or no sources at all.
	for (const cached of [{ '1.60.1.6': ALL }, {}]) {
		const { root, dir } = pinned('1.60.1.7', listed, cached);
		assert.throws(
			() => loadData(dir),
			(e) => {
				assert.equal(e.message.split(': the guide texts')[0], `the reference data was built from Forever client build 1.60.1.7, but ${path.join(root, 'sources', 'wago', '1.60.1.7')} lacks SpellName.csv, SkillLineAbility.csv, AreaTable.csv`);
				assert.match(e.message, /Put the sources the data was built with beside it, or rebuild the data with `forge data build`$/);
				return true;
			},
		);
	}
	// Part of them.
	assert.throws(() => loadData(pinned('1.60.1.7', listed, { '1.60.1.7': ['AreaTable', 'SpellName'] }).dir), /1\.60\.1\.7 lacks SkillLineAbility\.csv: /);
	// Its own build's, beside another's: it loads, with the places of that build's AreaTable.
	const data = loadData(pinned('1.60.1.7', listed, { '1.60.1.6': ALL, '1.60.1.7': ALL }).dir);
	assert.equal(data.areas.build, '1.60.1.7');
	assert.equal(data.areas.byId.get(12).name, 'Elwynn Forest');
});

test('the tables the source lists decide: SpellName needs the spell tables, AreaTable (or a source without the list) the areas; data naming no build needs no sources', () => {
	assert.doesNotThrow(() => loadData(pinned('1.60.1.7', ['SpellName', 'SkillLineAbility'], { '1.60.1.7': ['SpellName', 'SkillLineAbility'] }).dir));
	assert.doesNotThrow(() => loadData(pinned('1.60.1.7', ['UiMap', 'AreaTable', 'Map'], { '1.60.1.7': ['AreaTable'] }).dir));
	assert.throws(() => loadData(pinned('1.60.1.7', null, { '1.60.1.7': ['SpellName'] }).dir), /1\.60\.1\.7 lacks AreaTable\.csv: /);
	assert.equal(fs.existsSync(path.join(DATA_DIR, '..', 'sources')), false, 'the fixture data has no sources beside it');
	assert.doesNotThrow(() => loadData(DATA_DIR));
});
