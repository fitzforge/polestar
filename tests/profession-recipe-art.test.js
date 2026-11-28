'use strict';
// The profession window shows the game's own icon and tooltip for every recipe a profession guide uses (UI/GuideFrame.lua,
// GF.GoalIcon and GF.RecipeSpell; tests/guide-kind-craft.test.js draws the rows): the created item's where there is one,
// otherwise the recipe's spell (an enchant, a smelt, a transmute makes no item). This sweep goes over every `craft` and
// `learn` goal of every forever/professions guide, single and paired, and every `craft` goal of any other guide (a
// reputation guide's dumplings), as the committed Guides.lua files ship them, and checks that each resolves an icon from
// the client's own tables: the item's icon (Item.csv), the spell's (SpellMisc.csv). The generic anvil is for a client
// that gives nothing, never for a recipe our data knows.
//
// The parse reads the Guides.lua files only (like tests/profession-trainers.test.js); the icon tables are the cached
// client tables in data/sources/wago, so that part skips without them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { SOURCES, ROOT, DATA } = require('../tools/lib/paths');

const GUIDES = ['Polestar_Guides', 'Polestar_Guides_Alliance', 'Polestar_Guides_Horde'].map((a) => path.join(ROOT, 'addon', a, 'Guides.lua'))
	.concat(path.join(ROOT, 'addon', 'Polestar', 'Experimental', 'Guides.lua'));
const PROFESSIONS = path.join(ROOT, 'guides', 'forever', 'professions');

// A side shelf (format 8) carries its steps as one Lua string (`stepsSrc`): its source, unescaped.
function shelfSource(block) {
	const m = block.match(/^\t\t\tstepsSrc = "((?:[^"\\]|\\.)*)",$/m);
	if (!m) return block;
	return m[1].replace(/\\(\d{3}|.)/g, (_, c) => ({ n: '\n', r: '\r', t: '\t' })[c] ?? (/^\d{3}$/.test(c) ? String.fromCharCode(Number(c)) : c));
}

// { guide: 'forever/professions/x.guide', source } for every guide in the Guides.lua files.
function blocks() {
	const out = [];
	for (const file of GUIDES) {
		const parts = fs.readFileSync(file, 'utf8').split(/^(-- Source: .*)$/m);
		for (let i = 1; i < parts.length; i += 2) out.push({ guide: parts[i].replace('-- Source: ', '').trim(), source: shelfSource(parts[i + 1]) });
	}
	return out;
}

// Every recipe goal: { guide, t, spell, name, item } (craft with an item: item), and every item the profession guides
// name. A learn step wears the spell's icon in a profession guide only (a class guide's learn keeps its glyph).
function recipes() {
	const goals = [];
	const items = new Set();
	for (const { guide, source } of blocks()) {
		const profession = guide.includes('forever/professions/');
		const crafts = [...source.matchAll(/t = "craft", spell = (\d+), spellName = "([^"]*)"(?:, item = (\d+))?/g)];
		assert.equal(crafts.length, (source.match(/t = "craft"/g) || []).length, `${guide}: every craft goal carries its spell and name`);
		for (const m of crafts) goals.push({ guide, t: 'craft', spell: Number(m[1]), name: m[2], item: m[3] ? Number(m[3]) : null });
		if (!profession) continue;
		const learns = [...source.matchAll(/t = "learn", spell = (\d+), spellName = "([^"]*)"(?:, npc = \d+, npcName = "[^"]*")?(?:, item = \d+, itemName = "[^"]*")?(?:, makes = (\d+))?/g)];
		assert.equal(learns.length, (source.match(/t = "learn"/g) || []).length, `${guide}: every learn goal carries its spell and name`);
		for (const m of learns) goals.push({ guide, t: 'learn', spell: Number(m[1]), name: m[2], item: null, makes: m[3] ? Number(m[3]) : null });
		for (const m of source.matchAll(/\bitem = (\d+)/g)) items.add(Number(m[1]));
	}
	return { goals, items };
}

test('every profession guide, single and paired, is in the committed Guides.lua with its recipe goals', () => {
	const shipped = blocks().filter((b) => b.guide.includes('forever/professions/')).map((b) => path.basename(b.guide));
	for (const file of fs.readdirSync(PROFESSIONS).filter((f) => f.endsWith('.guide'))) {
		assert.ok(shipped.includes(file), `${file} is in Guides.lua`);
	}
	const { goals } = recipes();
	assert.ok(goals.filter((g) => g.t === 'craft').length > 100 && goals.filter((g) => g.t === 'learn').length > 100, 'the sweep sees the guides\' crafts and learns');
	assert.ok(goals.some((g) => g.t === 'craft' && !g.item), 'there are recipes with no item (the enchants): the spell\'s icon is what they wear');
});

// The cached client tables, newest build first; the sweep reads the union (a later build is the data's superset).
function table(file, idColumn, iconColumn) {
	const dir = path.join(SOURCES, 'wago');
	if (!fs.existsSync(dir)) return null;
	const icons = new Map();
	for (const build of fs.readdirSync(dir).filter((d) => d.startsWith('1.60.')).sort().reverse()) {
		const csv = path.join(dir, build, file);
		if (!fs.existsSync(csv)) continue;
		const rows = fs.readFileSync(csv, 'utf8').split('\n');
		const head = rows[0].split(',');
		const [id, icon] = [head.indexOf(idColumn), head.indexOf(iconColumn)];
		for (const row of rows.slice(1)) {
			const c = row.split(',');
			if (c.length > Math.max(id, icon) && !icons.has(Number(c[id]))) icons.set(Number(c[id]), Number(c[icon]));
		}
	}
	return icons.size ? icons : null;
}
const spellIcons = table('SpellMisc.csv', 'SpellID', 'SpellIconFileDataID');
const itemIcons = table('Item.csv', 'ID', 'IconFileDataID');
const skip = spellIcons && itemIcons ? false : 'client tables not cached: data/sources/wago has no 1.60.x SpellMisc.csv / Item.csv (forge data build)';

test('every craft and learn goal resolves an item or spell icon from the client tables: no recipe falls back to the anvil', { skip }, () => {
	const { goals } = recipes();
	const unresolved = [];
	for (const g of goals) {
		// A craft with an item wears the item's icon, or the spell's where the client has no icon for the item
		// (GF.GoalIcon's fallback: Forever's Runecloth Cuffs, item 254123, has none in Item.csv); every other
		// recipe, and every learn step, the spell's.
		const icon = (g.t === 'craft' && g.item && itemIcons.get(g.item)) || spellIcons.get(g.spell);
		if (!icon) unresolved.push(`${g.guide}: ${g.t} ${g.spell} ${g.name}${g.item ? ` (item ${g.item})` : ''}: no item or spell icon in the client tables`);
	}
	assert.deepEqual(unresolved, []);
});

test('every material the profession guides name has an icon in the client tables', { skip }, () => {
	const { items, goals } = recipes();
	// An item that is only a craft's product wears the craft's icon (the test above), the spell's where it has none.
	const madeWithIcon = new Set(goals.filter((g) => g.t === 'craft' && g.item && spellIcons.get(g.spell)).map((g) => g.item));
	const missing = [...items].filter((i) => !itemIcons.get(i) && !madeWithIcon.has(i));
	assert.deepEqual(missing, [], 'items with no icon');
});

test('the recipes with no item of their own (enchants and the like) all have a spell icon', { skip }, () => {
	const { goals } = recipes();
	const spellOnly = goals.filter((g) => g.t === 'craft' && !g.item);
	assert.ok(spellOnly.length > 0);
	for (const g of spellOnly) assert.ok(spellIcons.get(g.spell), `${g.guide}: ${g.name} (${g.spell}) has no spell icon`);
});

// A learn step shows what the client's profession window draws for the recipe, which is what its craft row shows: the
// item the recipe makes. The recipe spell's own icon is often a generic crest (every smelt, the bolts), so a learn
// goal that lacks `makes` would wear a wrong icon. The compiler writes `makes` from the recipe in professions.json.
const professions = (() => {
	try {
		return JSON.parse(fs.readFileSync(path.join(DATA, 'professions.json'), 'utf8'));
	} catch {
		return null;
	}
})();
test('every learn step of a recipe that makes an item carries it (`makes`), the same item its craft goals name; the others carry none', { skip: professions ? false : 'reference data not built: data/forever has no professions.json (forge data build)' }, () => {
	const made = new Map();
	for (const line of Object.keys(professions)) {
		for (const r of professions[line].recipes || []) if (!made.has(r.spell)) made.set(r.spell, r.item > 0 ? r.item : null);
	}
	const { goals } = recipes();
	const wrong = [];
	for (const g of goals) {
		if (!made.has(g.spell)) {
			wrong.push(`${g.guide}: ${g.t} ${g.spell} ${g.name}: not a recipe in professions.json`);
			continue;
		}
		const want = made.get(g.spell);
		if (g.t === 'learn' && (g.makes || null) !== want) wrong.push(`${g.guide}: learn ${g.spell} ${g.name}: makes ${g.makes} but the recipe makes ${want}`);
		if (g.t === 'craft' && (g.item || null) !== want) wrong.push(`${g.guide}: craft ${g.spell} ${g.name}: item ${g.item} but the recipe makes ${want}`);
	}
	assert.deepEqual(wrong, []);
});
