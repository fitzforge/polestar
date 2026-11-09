'use strict';
// `learn <spell>` of a spell no recipe has but a skill line teaches in the
// data's own client build (SkillLineAbility: class spells, talents, Forever's
// new ones): known, with the client's name (SpellName) when the guide gives
// none. A spell the client's skill lines do not teach keeps the warning or
// the error; so does `craft`, which needs the recipe for its item and
// reagents. The JS compiler side of forge-guide's dsl_verbs.rs test.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA_DIR, guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { tmpdir } = require('./helpers/tmp');
const { loadData } = require('../tools/lib/dsl/data');

// Rows of the 1.60.1.70862 client tables: Frostbolt, Fireball (133, and 143 a
// later rank), Comprehend Scroll (Forever's) and Chains of Ice, which no skill
// line teaches.
const SKILL_LINE_ABILITY = [
	'AbilityVerb_lang,AbilityAllVerb_lang,ID,SkillLine,Spell,MinSkillLineRank,ClassMask,SupercedesSpell,AcquireMethod,TrivialSkillLineRankHigh,TrivialSkillLineRankLow,Flags,NumSkillUps,UniqueBit,TradeSkillCategoryID,SkillupSkillLineID,Field_5_5_4_67090_014_0,Field_5_5_4_67090_014_1,RaceMasks_0,RaceMasks_1',
	',,69,6,116,1,128,0,0,0,0,0,1,0,0,0,0,0,0,0',
	',,455,8,133,1,128,0,2,0,0,0,1,0,0,0,0,0,0,0',
	',,460,8,143,1,128,0,0,0,0,0,1,0,0,0,0,0,0,0',
	',,58472,3012,1296017,1,128,0,0,0,0,0,0,0,0,0,0,0,-1,-1',
].join('\n');
const SPELL_NAME = ['ID,Name_lang', '113,"Chains of Ice"', '116,Frostbolt', '133,Fireball', '143,Fireball', '1296017,"Comprehend Scroll"'].join('\n');

// The fixture data in <root>/forever, its meta naming client build 1.60.1.1,
// whose tables are cached in <root>/sources/wago/1.60.1.1.
function pinnedData() {
	const root = tmpdir('polestar-learn-');
	const dir = path.join(root, 'forever');
	fs.cpSync(DATA_DIR, dir, { recursive: true });
	const meta = JSON.parse(fs.readFileSync(path.join(dir, 'meta.json'), 'utf8'));
	meta.sources.push({ name: 'World of Warcraft: Forever client tables (SpellName, SkillLineAbility) via wago.tools', revision: 'wow_classic_beta 1.60.1.1' });
	fs.writeFileSync(path.join(dir, 'meta.json'), JSON.stringify(meta));
	const wago = path.join(root, 'sources', 'wago', '1.60.1.1');
	fs.mkdirSync(wago, { recursive: true });
	fs.writeFileSync(path.join(wago, 'SkillLineAbility.csv'), `${SKILL_LINE_ABILITY}\n`);
	fs.writeFileSync(path.join(wago, 'SpellName.csv'), `${SPELL_NAME}\n`);
	return loadData(dir);
}

const SRC = guideText(['step Trainer', '  learn 116 "Frostbolt"', '  learn 143', '  learn 1296017', '  craft 116 "Frostbolt"', '  learn 113 "Chains of Ice"', '  learn 113']);

const at = (line, message) => `test.guide:${lineOf(SRC, line)}: ${message}`;
const unknown = (line, spell) => at(line, `spell ${spell} is not in data; using the explicit name (new Forever content?)`);
const nameless = (line, spell) => at(line, `spell ${spell} is not in data; give its name: \`learn ${spell} "Name"\``);

test('learn of a spell a skill line teaches in the client build: its client name, no warning; craft and other spells as before', () => {
	const r = compile(SRC, pinnedData());
	assert.deepEqual(r.errors, [nameless('  learn 113', 113)], r.text);
	assert.deepEqual(r.warnings, [unknown('  craft 116 "Frostbolt"', 116), unknown('  learn 113 "Chains of Ice"', 113)], r.text);
	assert.deepEqual(plain(r.guides[0].steps[0].goals).slice(0, 5), [
		{ t: 'learn', spell: 116, spellName: 'Frostbolt' },
		{ t: 'learn', spell: 143, spellName: 'Fireball' },
		{ t: 'learn', spell: 1296017, spellName: 'Comprehend Scroll' },
		{ t: 'craft', spell: 116, spellName: 'Frostbolt' },
		{ t: 'learn', spell: 113, spellName: 'Chains of Ice' },
	]);
});

test('without the client build a learn of a class spell still needs its name and warns', () => {
	const r = compile(SRC);
	assert.deepEqual(r.errors, [nameless('  learn 143', 143), nameless('  learn 1296017', 1296017), nameless('  learn 113', 113)], r.text);
	assert.deepEqual(r.warnings, [unknown('  learn 116 "Frostbolt"', 116), unknown('  craft 116 "Frostbolt"', 116), unknown('  learn 113 "Chains of Ice"', 113)], r.text);
});
