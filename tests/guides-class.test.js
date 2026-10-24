'use strict';
// The Class guides (guides/forever/class/ and the four class mount guides):
// one guide per goal, each saying what it gives and why. Pinned so the
// structure the class rework settled on (data/local/class-rework/AUDIT.md,
// local) holds: no goal split over guides one character sees, the mount
// chains routed whole, and the chains the maintainer asked about kept apart
// where the quest data keeps them apart.
//
// The structure tests parse the guides alone; the chain tests read
// data/forever (forge data build) and skip without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { DATA, needs } = require('./helpers/data');

const MOUNTS = ['alliance/paladin-warhorse', 'alliance/paladin-charger', 'neutral/warlock-felsteed', 'neutral/warlock-dreadsteed'].map((m) => `forever/collectibles/mounts/${m}.guide`);
const DREADSTEED = 'forever/collectibles/mounts/neutral/warlock-dreadsteed.guide';
const CHARGER = 'forever/collectibles/mounts/alliance/paladin-charger.guide';

function walk(dir) {
	return fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(dir, e.name)) : e.name.endsWith('.guide') ? [path.join(dir, e.name)] : []));
}

// Every Class guide, parsed: { rel, ast, quests: the quest ids it accepts, turns in or completes }.
const GUIDES = [...walk(path.join(OFFICIAL_DIR, 'forever', 'class')), ...MOUNTS.map((m) => path.join(OFFICIAL_DIR, m))].map((file) => {
	const diag = new Diagnostics();
	const ast = parseGuide(fs.readFileSync(file, 'utf8'), file, diag);
	const quests = new Set();
	for (const s of ast.steps) for (const g of s.goals) if (['accept', 'turnin', 'complete'].includes(g.verb) && g.quest) quests.add(g.quest);
	return { rel: path.relative(OFFICIAL_DIR, file).split(path.sep).join('/'), ast, quests, errors: diag.sorted().filter((d) => d.severity === 'error') };
});

const byRel = (rel) => GUIDES.find((g) => g.rel === rel);

test('every Class guide parses, is category Class for a class, and says what it gives and why in one short line', () => {
	assert.ok(GUIDES.length >= 60, `${GUIDES.length} Class guides`);
	for (const g of GUIDES) {
		const h = g.ast.header;
		assert.deepEqual(g.errors, [], g.rel);
		assert.equal(h.category, 'Class', g.rel);
		assert.ok(h.classes && h.classes.length, `${g.rel}: a class header`);
		assert.ok(h.reward && h.reward.length, `${g.rel}: a reward`);
		assert.ok(h.why && h.why.length <= 120, `${g.rel}: a why of at most 120 characters (${(h.why || '').length})`);
	}
});

test('titles name the goal: the Warlock chains the maintainer asked about read as what they give', () => {
	const titles = new Map(GUIDES.map((g) => [g.rel, g.ast.header.title]));
	assert.equal(titles.get(DREADSTEED), 'Warlock Dreadsteed');
	assert.equal(titles.get('forever/class/warlock/shard-of-the-green-flame.guide'), 'Shard of the Green Flame');
	assert.equal(titles.get('forever/class/warlock/tome-of-sacrifice.guide'), 'Tome of Sacrifice');
	assert.deepEqual(byRel(DREADSTEED).ast.header.reward.map((r) => r.spell), [23161]);
	assert.deepEqual(byRel(CHARGER).ast.header.reward.map((r) => r.spell), [23214]);
});

// The data's chains: quests linked by pre, preAny, preAll, next,
// breadcrumbFor or excl, as connected components. -> Map(quest -> root)
function chains(quests) {
	const parent = new Map();
	const find = (x) => {
		if (!parent.has(x)) parent.set(x, x);
		while (parent.get(x) !== x) {
			parent.set(x, parent.get(parent.get(x)));
			x = parent.get(x);
		}
		return x;
	};
	for (const [id, q] of Object.entries(quests)) {
		if (!q.classes) continue;
		const me = Number(id);
		find(me);
		const links = [...(q.pre || []), ...(q.preAny || []), ...(q.preAll || []), ...(q.excl || []), q.next, q.breadcrumbFor].filter((x) => x && quests[x] && quests[x].classes);
		for (const x of links) parent.set(find(x), find(me));
	}
	return find;
}

const skip = needs('quests.json');
let quests, root;
function load() {
	if (!quests) {
		quests = JSON.parse(fs.readFileSync(path.join(DATA, 'quests.json'), 'utf8'));
		root = chains(quests);
	}
}

// Could one character see both guides on their own faction's list?
function sameAudience(a, b) {
	const fa = a.ast.header.faction, fb = b.ast.header.faction;
	if (fa && fb && fa !== fb) return false;
	const ra = a.ast.header.races, rb = b.ast.header.races;
	if (ra && rb && !ra.some((r) => rb.includes(r))) return false;
	return true;
}

test('no goal is split: two Class guides one character sees never share a quest chain', { skip }, () => {
	load();
	const chainsOf = (g) => new Set([...g.quests].filter((q) => quests[q] && quests[q].classes).map(root));
	const sets = new Map(GUIDES.map((g) => [g.rel, chainsOf(g)]));
	for (let i = 0; i < GUIDES.length; i++) {
		for (let j = i + 1; j < GUIDES.length; j++) {
			const a = GUIDES[i], b = GUIDES[j];
			if (!sameAudience(a, b)) continue;
			const shared = [...sets.get(a.rel)].filter((c) => sets.get(b.rel).has(c));
			assert.deepEqual(shared, [], `${a.rel} and ${b.rel} share a chain`);
		}
	}
});

test('the mount chains are routed whole: the Dreadsteed\'s twelve quests and the Charger\'s chain', { skip }, () => {
	load();
	const chainOf = (q) => Object.keys(quests).map(Number).filter((id) => quests[id].classes && root(id) === root(q));
	const dread = chainOf(7631).sort((a, b) => a - b);
	assert.deepEqual(dread, [7562, 7563, 7564, 7623, 7624, 7625, 7626, 7627, 7628, 7629, 7630, 7631]);
	assert.deepEqual(dread.filter((q) => !byRel(DREADSTEED).quests.has(q)), []);
	// Again Into the Great Ossuary (7666) only repeats the last fight: a tip, not a step.
	const charger = chainOf(7647).filter((q) => q !== 7666);
	assert.deepEqual(charger.filter((q) => !byRel(CHARGER).quests.has(q)), []);
});

test('An Imp\'s Request, Niby\'s and Daio\'s chains are not on the Dreadsteed road: the data links none of them to it', { skip }, () => {
	load();
	const dread = root(7631);
	for (const q of [8419, 8420, 8421, 8422, 7601, 7602, 7603, 7581, 7582, 7583]) assert.notEqual(root(q), dread, `quest ${q}`);
	for (const q of [8419, 7601, 7581]) assert.ok(!byRel(DREADSTEED).quests.has(q), `quest ${q} stays out of the Dreadsteed guide`);
});

// The client's spell tables (data/sources/wago/<newest 1.60 build>, cached by
// data build): a `reward spell` id the client does not have shows no icon or
// tooltip, and a spell written as `reward text` shows the fallback glyph.
const { parseCsv } = require('../tools/lib/data/csv');
const { PRODUCTS, compareVersions } = require('../tools/lib/data/wago');
const WAGO = path.join(__dirname, '..', 'data', 'sources', 'wago');
const SPELL_TABLES = ['SpellName', 'SpellMisc', 'SkillLineAbility'];
const spellBuild = fs.existsSync(WAGO)
	? fs.readdirSync(WAGO).filter((b) => PRODUCTS.forever.family.test(b) && SPELL_TABLES.every((t) => fs.existsSync(path.join(WAGO, b, `${t}.csv`)))).sort(compareVersions).pop()
	: null;
const CLASS_BIT = { Warrior: 1, Paladin: 2, Hunter: 4, Rogue: 8, Priest: 16, Shaman: 64, Mage: 128, Warlock: 256, Druid: 1024 };

test('reward spells are the client\'s: each id is in the Forever spell tables under its name, with an icon; no class spell is left as words', { skip: spellBuild ? false : 'no cached Forever wago build with SpellName, SpellMisc and SkillLineAbility (forge data build)' }, () => {
	const table = (t) => parseCsv(fs.readFileSync(path.join(WAGO, spellBuild, `${t}.csv`), 'utf8'));
	const names = new Map(table('SpellName').map((r) => [Number(r.ID), r.Name_lang]));
	const icons = new Map(table('SpellMisc').map((r) => [Number(r.SpellID), Number(r.SpellIconFileDataID)]));
	const classSpells = new Map(); // name -> class mask
	for (const r of table('SkillLineAbility')) {
		const name = names.get(Number(r.Spell));
		if (name) classSpells.set(name, (classSpells.get(name) || 0) | Number(r.ClassMask));
	}
	let spells = 0;
	for (const g of GUIDES) {
		const mask = (g.ast.header.classes || []).reduce((m, c) => m | (CLASS_BIT[c] || 0), 0);
		for (const r of g.ast.header.reward || []) {
			if (r.spell !== undefined) {
				spells++;
				const name = names.get(r.spell);
				assert.ok(name, `${g.rel}: reward spell ${r.spell} is not in ${spellBuild} SpellName`);
				assert.ok(r.spellName.startsWith(name), `${g.rel}: reward spell ${r.spell} is "${name}" in the client, not "${r.spellName}"`);
				assert.ok(icons.get(r.spell) > 0, `${g.rel}: reward spell ${r.spell} has no icon in ${spellBuild} SpellMisc`);
			} else if (r.text !== undefined) {
				assert.ok(!(classSpells.get(r.text) & mask), `${g.rel}: "reward text ${r.text}" is a class spell: write it as \`reward spell <id> "${r.text}"\``);
			}
		}
	}
	assert.ok(spells >= 30, `${spells} reward spells checked`);
});
