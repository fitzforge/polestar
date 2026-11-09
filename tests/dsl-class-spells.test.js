'use strict';
// A class's own spells in its guides (#1504, #1505): a guide whose header
// names the class tokenises them as that class's spells even where an item
// or object has the name ("Cold Snap", "Ice Block") or the name is one word
// ("Frostbite"); `learn` of a class spell the client's SkillLineAbility
// knows takes its name from SpellName, without the "not in data" warning.

const { test, after } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { compile, guideText, DATA_DIR } = require('./helpers/dsl');
const { loadData } = require('../tools/lib/dsl/data');

const BUILD = '1.60.1.1';
const root = tmpdir('polestar-class-spells-');
after(() => fs.rmSync(root, { recursive: true, force: true }));

// The fixture data with an item "Cold Snap" and an object "Ice Block", built
// from a Forever client build with the Mage's spells.
function classData() {
	const dir = path.join(root, 'data');
	fs.cpSync(DATA_DIR, dir, { recursive: true });
	const json = (f) => JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
	const items = json('items.json');
	items[19130] = { id: 19130, name: 'Cold Snap', drops: { npc: {}, object: {} }, vendors: [] };
	items[19103] = { id: 19103, name: 'Frostbite', drops: { npc: {}, object: {} }, vendors: [] };
	fs.writeFileSync(path.join(dir, 'items.json'), JSON.stringify(items));
	const objects = json('objects.json');
	objects[181247] = { id: 181247, name: 'Ice Block', spawns: {} };
	fs.writeFileSync(path.join(dir, 'objects.json'), JSON.stringify(objects));
	const meta = json('meta.json');
	meta.sources.push({ name: 'World of Warcraft: Forever client tables', revision: BUILD, url: 'https://wago.tools' });
	fs.writeFileSync(path.join(dir, 'meta.json'), JSON.stringify(meta));
	const wago = path.join(root, 'sources', 'wago', BUILD);
	fs.mkdirSync(wago, { recursive: true });
	fs.writeFileSync(path.join(wago, 'SpellName.csv'), 'ID,Name_lang\n116,Frostbolt\n205,Frostbolt\n11958,Ice Block\n12472,Cold Snap\n11071,Frostbite\n100,Charge\n2259,Alchemy\n');
	fs.writeFileSync(path.join(wago, 'SkillLineAbility.csv'), 'ID,SkillLine,Spell,ClassMask\n1,6,116,128\n2,6,205,128\n3,6,11958,128\n4,6,12472,128\n5,6,11071,128\n6,26,100,1\n7,171,2259,0\n');
	return loadData(dir);
}
const data = classData();

const header = (cls) => ['guide t/mage', 'title Mage', 'category Class', ...(cls ? [`class ${cls}`] : []), 'faction Alliance', 'levels 40-50', 'zone Elwynn Forest'];
const steps = ['step Level 44: Ice Block', '  tip Take Ice Block now, then Frostbite.', '  level 45', '', 'step Level 46: Cold Snap', '  tip Cold Snap resets your Frost cooldowns.', '  level 47'];

test('#1504: a Mage guide tokenises Ice Block, Cold Snap and Frostbite as the Mage\'s spells, not the item or object of that name', () => {
	const { guides, errors } = compile(guideText([...header('Mage'), '', ...steps]), data);
	assert.deepEqual(errors, []);
	const loc = guides[0]._localised;
	const [a, b] = loc.steps;
	assert.equal(a.title, 'Level 44: {spell:11958}');
	assert.equal(b.title, 'Level 46: {spell:12472}');
	const tips = JSON.stringify(loc.steps);
	assert.match(tips, /Take \{spell:11958\} now, then \{spell:11071\}\./);
	assert.match(tips, /\{spell:12472\} resets your Frost cooldowns\./);
	assert.equal(loc.names['spell:12472'], 'Cold Snap');
	assert.equal(loc.names['spell:11071'], 'Frostbite');
});

test('#1504: another class\'s guide, or one naming no class, keeps the world\'s names', () => {
	for (const cls of ['Warrior', null]) {
		const { guides } = compile(guideText([...header(cls), '', ...steps]), data);
		const loc = guides[0]._localised;
		assert.equal(loc.steps[1].title, 'Level 46: {item:19130}', String(cls));
		assert.doesNotMatch(JSON.stringify(loc.steps), /\{spell:(11958|12472|11071)\}/, String(cls));
	}
});

test('#1505: `learn` of a class spell takes the client\'s name, without the "not in data" warning; an unknown spell still warns', () => {
	const ok = compile(guideText([...header('Mage'), '', 'step Train', '  learn 116 optional', '  learn 205 "Frostbolt" optional']), data);
	assert.deepEqual(ok.errors, []);
	assert.deepEqual(ok.warnings.filter((w) => /not in data/.test(w)), []);
	const goals = ok.guides[0].steps[0].goals;
	assert.equal(goals[0].spellName, 'Frostbolt');
	const unknown = compile(guideText([...header('Mage'), '', 'step Train', '  learn 99999 "Made Up" optional']), data);
	assert.equal(unknown.warnings.filter((w) => /spell 99999 is not in data.*new Forever content\?/.test(w)).length, 1, unknown.text);
});
