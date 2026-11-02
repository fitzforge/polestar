'use strict';
// node tools/polestar.js classrewards build
//
// The guide window's class-quest card (UI/ClassCard.lua) names what a class
// quest chain gives: the spell it teaches, else the item it hands over. This
// writes addon/Polestar/UI/ClassRewards.lua from:
//
//   data/forever/quests.json        which quests a class may take (classes),
//                                   their links (next, pre, preAll, preAny) and
//                                   item rewards (the web quest data's items and choices)
//   data/sources/forever-tdb        quest RewardSpell (else RewardDisplaySpell1)
//   the client tables               SpellEffect (a "teach" spell's learned
//                                   spell), SpellName, SpellMisc and Item (names,
//                                   icons, item classes)
//   guides/                         every guide with a `class` header: its
//                                   first `reward spell` / `reward item` line is
//                                   what its chain is for (Forever's own
//                                   chains, such as Cat Form, have no TDB row)
//
// Each class quest takes its chain's final reward: the reward of the
// furthest quest after it (following the links) that gives one. A class
// guide's quests that no link joins (Forever's custom chains) are one chain.

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('node:util');
const { header } = require('../lib/generated');
const { parseCsv } = require('../lib/data/csv');
const { parseGuide } = require('../lib/dsl/parse');
const { ROOT, DATA, SOURCES } = require('../lib/paths');

const usage = `usage: node tools/polestar.js classrewards build [--data <dir>] [--sources <dir>] [--guides <dir>] [--lua <file>]

  --data <dir>     data/forever (quests.json)
  --sources <dir>  data/sources (forever-tdb/extract.json, client-tables/, wago/)
  --guides <dir>   the guides (default: guides/)
  --lua <file>     output (default: addon/Polestar/UI/ClassRewards.lua)`;

const CLASS_BITS = { WARRIOR: 1, PALADIN: 2, HUNTER: 4, ROGUE: 8, PRIEST: 16, SHAMAN: 64, MAGE: 128, WARLOCK: 256, DRUID: 1024 };
const ALL_CLASSES = Object.values(CLASS_BITS).reduce((a, b) => a | b, 0);
const LEARN = 36; // SPELL_EFFECT_LEARN_SPELL
const SUMMON_PET = 56;
const AURA = 6;
const MOUNTED = 78;
const ITEM_WEAPON = 2;
const ITEM_ARMOR = 4;
const ITEM_REAGENT = 15; // Miscellaneous, subclass Reagent: the shaman's totems
const REAGENT_SUB = 1;
// Each race's home: its starting zone and its capital (uiMapIDs). Skyborne
// start on Zephras Isle and have no capital of their own.
const HOME = {
	Human: [1429, 1453], Dwarf: [1426, 1455], Gnome: [1426, 1455], NightElf: [1438, 1457],
	Orc: [1411, 1454], Troll: [1411, 1454], Scourge: [1420, 1458], Tauren: [1412, 1456], Skyborne: [2521],
};

// A class quest: a few classes (at most four of the nine). A quest for every
// class but one is a leveling quest with a class twin (Durotar's Vile
// Familiars, 792, for all but Warlocks, who take 1485), not a class quest.
function classMask(v) {
	const m = (Number(v) || 0) & ALL_CLASSES;
	let n = 0;
	for (const b of Object.values(CLASS_BITS)) if (m & b) n++;
	return n && n <= 4 ? m : 0;
}

// A quest's web quest-database row (rewards, quest-log sort): `web` in the
// data build (an older build without it: rebuild with `forge data build`).
const webOf = (v) => (v && v.web) || null;

// Each table from the newest build that has it: data/sources/client-tables
// and data/sources/wago, newest build first.
function tableFinder(sources) {
	const builds = [];
	for (const sub of ['client-tables', 'wago']) {
		const dir = path.join(sources, sub);
		if (!fs.existsSync(dir)) continue;
		for (const b of fs.readdirSync(dir)) if (/^\d+\.\d+\.\d+\.\d+$/.test(b)) builds.push({ b, dir: path.join(dir, b) });
	}
	const key = (b) => b.split('.').map(Number);
	builds.sort((x, y) => {
		const a = key(x.b), c = key(y.b);
		for (let i = 0; i < 4; i++) if (a[i] !== c[i]) return c[i] - a[i];
		return 0;
	});
	return (name) => {
		for (const { dir } of builds) {
			const file = path.join(dir, `${name}.csv`);
			if (fs.existsSync(file)) return parseCsv(fs.readFileSync(file, 'utf8'));
		}
		throw new Error(`classrewards: no ${name}.csv under ${sources}/client-tables or ${sources}/wago`);
	};
}

function walkGuides(dir, out = []) {
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) walkGuides(p, out);
		else if (e.name.endsWith('.guide')) out.push(p);
	}
	return out.sort();
}

// The guides with a `class` header: { file, mask, reward (first spell or item
// line, choices together), quests (accept/turnin/complete ids in order) }.
function classGuides(dir) {
	const diag = { error() {}, warn() {}, push() {} };
	const out = [];
	for (const file of walkGuides(dir)) {
		const g = parseGuide(fs.readFileSync(file, 'utf8'), file, diag);
		const classes = g && g.header && g.header.classes;
		if (!classes || !classes.length) continue;
		let mask = 0;
		for (const c of classes) mask |= CLASS_BITS[c] || 0;
		if (!mask) continue;
		const lines = g.header.reward || [];
		let reward = null;
		const first = lines.find((r) => r.spell || r.item);
		if (first && first.spell) reward = { spell: first.spell };
		else if (first) reward = { items: lines.filter((r) => r.item && r.line === first.line).map((r) => r.item), choice: !!first.choice };
		const quests = [];
		for (const step of g.steps || []) {
			for (const goal of step.goals || []) {
				const q = Number(goal.quest);
				if (q && ['accept', 'turnin', 'complete'].includes(goal.verb) && !quests.includes(q)) quests.push(q);
			}
		}
		out.push({ file: path.relative(ROOT, file), mask, reward, quests });
	}
	return out;
}

function buildClassRewards({ quests, tdb, table, guides, npcs = {}, objects = {}, races = {} }) {
	// Spells: what a "teach" spell teaches, names, icons, kinds.
	const effects = new Map();
	for (const r of table('SpellEffect')) {
		const id = Number(r.SpellID);
		if (!effects.has(id)) effects.set(id, []);
		effects.get(id).push({ effect: Number(r.Effect), trigger: Number(r.EffectTriggerSpell), aura: Number(r.EffectAura) });
	}
	const spellNames = new Map(table('SpellName').map((r) => [Number(r.ID), r.Name_lang]));
	const spellIcons = new Map();
	for (const r of table('SpellMisc')) {
		const id = Number(r.SpellID), icon = Number(r.SpellIconFileDataID);
		if (icon && !spellIcons.has(id)) spellIcons.set(id, icon);
	}
	const items = new Map(table('Item').map((r) => [Number(r.ID), { cls: Number(r.ClassID), sub: Number(r.SubclassID), icon: Number(r.IconFileDataID) || 0 }]));
	const itemSparse = new Map();
	try {
		for (const r of table('ItemSparse')) itemSparse.set(Number(r.ID), r.Display_lang);
	} catch {
		// Names then come from quests' own data only.
	}
	const learned = (s) => (effects.get(s) || []).filter((e) => e.effect === LEARN && e.trigger).map((e) => e.trigger);
	// The spell the player ends up with: a teach spell's first learned spell.
	function resolve(s, depth = 0) {
		const l = learned(s);
		return l.length && depth < 4 ? resolve(l[0], depth + 1) : s;
	}
	function spellKind(s) {
		const all = [s, ...learned(s)];
		const fx = (id) => effects.get(id) || [];
		const resolvedAll = all.map((id) => resolve(id));
		if (resolvedAll.some((id) => fx(id).some((e) => e.effect === AURA && e.aura === MOUNTED))) return 'mount';
		if (resolvedAll.some((id) => fx(id).some((e) => e.effect === SUMMON_PET))) return 'pet';
		return 'ability';
	}
	function itemKind(list) {
		const it = items.get(list[0]);
		if (!it) return 'item';
		return it.cls === ITEM_WEAPON ? 'weapon' : it.cls === ITEM_ARMOR ? 'armor' : 'item';
	}
	// A class spell (a spell some class's skill lines list), not a buff the
	// turn-in casts (Call of Air's Swift Wind).
	const classSpells = new Set();
	for (const r of table('SkillLineAbility')) classSpells.add(Number(r.Spell));
	const teaches = (s) => learned(s).length > 0 || classSpells.has(s);
	// A shaman's totem (Earth, Fire, Water, Air Totem: a reagent).
	const isTotem = (i) => {
		const it = items.get(i);
		return !!it && it.cls === ITEM_REAGENT && it.sub === REAGENT_SUB;
	};
	const kept = (i) => {
		const it = items.get(i);
		return !!it && (it.cls === ITEM_WEAPON || it.cls === ITEM_ARMOR || isTotem(i));
	};

	// Class quests and their own rewards: { teach, spell, items, choice, show }.
	const mask = new Map();
	for (const [k, v] of Object.entries(quests)) {
		const m = classMask(v.classes);
		if (m) mask.set(Number(k), m);
	}
	for (const g of guides) for (const q of g.quests) {
		// A guide's class quest the data leaves open to every class: the guide's class.
		if (!mask.has(q) && quests[q] && quests[q].classes == null) mask.set(q, g.mask);
	}
	const tq = (tdb && tdb.quests) || {};
	const own = new Map();
	for (const q of mask.keys()) {
		const r = {};
		const t = tq[q];
		const s = t && Number(t.rewardSpell);
		if (s > 0 && teaches(s)) {
			r.teach = s;
			r.spell = resolve(s);
		}
		const w = webOf(quests[q]);
		const fixed = ((w && w.items) || []).map((e) => Number(Array.isArray(e) ? e[0] : e)).filter(kept);
		const choices = ((w && w.choices) || []).map((e) => Number(Array.isArray(e) ? e[0] : e)).filter(kept);
		if (fixed.length) r.items = [fixed.find(isTotem) || fixed[0]];
		else if (choices.length) {
			r.items = choices;
			r.choice = choices.length > 1;
		}
		if (!r.spell && !r.items) continue;
		r.show = r.items && (!r.spell || isTotem(r.items[0])) ? 'item' : 'spell';
		own.set(q, r);
	}
	// A class guide's reward (its first `reward` line): on the quest of the
	// guide that gives it, else the guide's last quest; the line says which
	// the card shows.
	const gives = (r, g) => r && ((g.spell && r.spell === g.spell) || (g.items && r.items && r.items.some((i) => g.items.includes(i))));
	const guideGiver = new Map(); // guide -> quest
	for (const g of guides) {
		if (!g.reward) continue;
		const mine = g.quests.filter((q) => mask.has(q) && mask.get(q) & g.mask);
		if (!mine.length) continue;
		const want = g.reward.spell ? { spell: resolve(g.reward.spell), teach: g.reward.spell } : { items: g.reward.items, choice: g.reward.choice && g.reward.items.length > 1 };
		const hit = mine.find((q) => gives(own.get(q), want));
		const q = hit || mine[mine.length - 1];
		const r = { ...(own.get(q) || {}), ...want };
		r.show = want.spell ? 'spell' : 'item';
		own.set(q, r);
		guideGiver.set(g, q);
	}

	// Links between class quests of the same class.
	const succ = new Map(), pred = new Map();
	const link = (a, b) => {
		if (!a || !b || a === b || !mask.has(a) || !mask.has(b) || !(mask.get(a) & mask.get(b))) return;
		if (!succ.has(a)) succ.set(a, new Set());
		if (!pred.has(b)) pred.set(b, new Set());
		succ.get(a).add(b);
		pred.get(b).add(a);
	};
	for (const q of mask.keys()) {
		const v = quests[q] || {};
		link(q, Number(v.next));
		for (const p of [...(v.pre || []), ...(v.preAll || []), ...(v.preAny || [])]) link(Number(p), q);
		const t = tq[q];
		if (t) {
			link(q, Number(t.next));
			link(Number(t.prev), q);
		}
	}
	// Chains: the links' connected parts.
	const parent = new Map([...mask.keys()].map((q) => [q, q]));
	const find = (q) => {
		while (parent.get(q) !== q) {
			parent.set(q, parent.get(parent.get(q)));
			q = parent.get(q);
		}
		return q;
	};
	const union = (a, b) => {
		const x = find(a), y = find(b);
		if (x !== y) parent.set(Math.max(x, y), Math.min(x, y));
	};
	for (const [a, set] of succ) for (const b of set) union(a, b);
	// The reward of q: the nearest quest from q on (q itself first, then
	// along the links) that teaches a spell, else the nearest that gives an
	// item; so Cat Form for every step of its chain, Berserker Stance for The
	// Affray before the Whirlwind weapon's quests.
	function nearest(q) {
		let frontier = [q], item = null;
		const seen = new Set([q]);
		while (frontier.length) {
			const next = [];
			for (const n of frontier) {
				const r = own.get(n);
				if (r && r.spell && r.show === 'spell') return n;
				if (r && !item) item = n;
				for (const s of succ.get(n) || []) if (!seen.has(s)) {
					seen.add(s);
					next.push(s);
				}
			}
			frontier = next;
		}
		return item;
	}
	const giverOf = new Map();
	for (const q of mask.keys()) {
		const n = nearest(q);
		if (n) giverOf.set(q, n);
	}
	// A class guide's quests no link leads to a reward (Forever's own chains,
	// such as Cat Form): the guide's reward, in its giver's chain.
	for (const [g, q] of guideGiver) {
		for (const o of g.quests) if (mask.has(o) && mask.get(o) & g.mask && !giverOf.has(o)) {
			giverOf.set(o, q);
			union(o, q);
		}
	}

	const rewards = [], rewardIndex = new Map();
	function rewardOf(q) {
		const r = own.get(q);
		const key = JSON.stringify([r.spell, r.items, r.show]);
		if (rewardIndex.has(key)) return rewardIndex.get(key);
		const e = { show: r.show };
		const totem = r.show === 'item' && isTotem(r.items[0]);
		if (r.spell && (r.show === 'spell' || totem)) {
			e.spell = r.spell;
			e.spellName = spellNames.get(r.spell) || null;
		}
		if (r.items && r.show === 'item') {
			e.items = r.items;
			e.itemNames = r.items.map((i) => itemSparse.get(i) || null);
			e.choice = !!r.choice;
		}
		e.kind = r.show === 'spell' ? spellKind(r.teach || r.spell) : totem ? 'ability' : itemKind(r.items);
		e.icon = r.show === 'spell' ? spellIcons.get(r.spell) || 0 : (items.get(r.items[0]) || {}).icon || 0;
		rewards.push(e);
		rewardIndex.set(key, rewards.length);
		return rewards.length;
	}
	const out = [];
	for (const q of [...mask.keys()].sort((a, b) => a - b)) {
		const giver = giverOf.get(q);
		out.push({ q, mask: mask.get(q), chain: find(q), reward: giver ? rewardOf(giver) : 0 });
	}
	// Where each rewarded chain starts, for the level-up heads-up
	// (UI/ClassToast.lua), and who starts it for each race: a quest no class
	// quest leads to and, in a class guide, the first quest of its chain the
	// guide takes for those races (Forever's own chains link only part way).
	const later = new Set();
	// Race masks pass 32 bits (Skyborne): compared as BigInt.
	const overlaps = (a, b) => a === 0n || b === 0n || (a & b) !== 0n;
	for (const g of guides) {
		const firsts = [];
		for (const q of g.quests) {
			if (!mask.has(q) || later.has(q)) continue;
			const races = BigInt((quests[q] && quests[q].races) || 0);
			const root = find(q);
			if (firsts.some((f) => f.q !== q && f.root === root && overlaps(f.races, races))) later.add(q);
			else firsts.push({ q, root, races });
		}
	}
	// Each race and side of races.json: its bit and its home maps (HOME). A
	// giver in a race's home is that race's; one in no race's home is for its
	// whole side; one in another race's home is a last resort (Skyborne,
	// without a capital of their own, take the Night Elves' and Tauren's).
	const SIDE = { Alliance: 'A', Horde: 'H' };
	const raceSides = [];
	for (const [race, sides] of Object.entries(races)) {
		for (const [side, r] of Object.entries(sides)) {
			if (SIDE[side]) raceSides.push({ key: `${race}:${SIDE[side]}`, side: SIDE[side], bit: BigInt(r.bit), home: new Set(HOME[race] || []) });
		}
	}
	const anyHome = new Set(Object.values(HOME).flat());
	// Gear-set turn-ins get no heads-up: the dungeon and raid set pieces (Tier
	// 0.5, Zul'Gurub, Ahn'Qiraj, Naxxramas, Silithus' Armaments of War) are
	// class quests filed in the quest log under a zone, not under the class,
	// at 58 and up, and pay gear, no spell. A chain a class guide takes keeps
	// its heads-up (Quel'Serrar, Arcane Refreshment): the guide is the opt-in.
	const guided = new Set();
	for (const g of guides) for (const q of g.quests) if (mask.has(q)) guided.add(find(q));
	const gearSet = (e, v) => {
		const w = webOf(v);
		const sort = Number(w && w.zone);
		const level = Number(v.minLevel) || Number(v.level) || 0;
		return sort > 0 && level >= 58 && !rewards[e.reward - 1].spell && !guided.has(e.chain);
	};
	const candidates = [];
	for (const e of out) {
		const q = e.q, v = quests[q];
		if (!e.reward || pred.has(q) || later.has(q) || !v || gearSet(e, v)) continue;
		const qraces = BigInt(v.races || 0);
		const start = v.start || {};
		const givers = [...(start.npc || []).map((id) => npcs[id]), ...(start.object || []).map((id) => objects[id])]
			.filter((w) => w && w.name)
			.map((w) => {
				const spawns = w.spawns || {};
				const maps = Object.keys(spawns).filter((k) => spawns[k].f === 'e' && (spawns[k].pts || []).length).map(Number);
				const at = maps.includes(Number(v.zone)) ? Number(v.zone) : maps[0];
				const g = { name: w.name, faction: w.faction, maps };
				if (at) {
					g.map = at;
					[g.x, g.y] = spawns[String(at)].pts[0];
				}
				return g;
			});
		for (const rs of raceSides) {
			if (qraces !== 0n && (qraces & rs.bit) === 0n) continue;
			let best = null;
			givers.forEach((g, i) => {
				if (g.faction && g.faction !== 'AH' && g.faction !== rs.side) return;
				// 0: in the race's home; 1: in no race's home; 2: in another race's home; 3: nowhere known.
				const rank = !g.maps.length ? 3 : g.maps.some((m) => rs.home.has(m)) ? 0 : g.maps.some((m) => anyHome.has(m)) ? 2 : 1;
				if (!best || rank < best.rank) best = { rank, i };
			});
			if (best) candidates.push({ q, reward: e.reward, minLevel: Number(v.minLevel) || Number(v.level) || 1, key: rs.key, rank: best.rank, giver: givers[best.i] });
		}
	}
	// One start per reward and race: the best-placed giver, then the lowest level, then the lowest id.
	const chosen = new Map();
	for (const c of candidates) {
		const k = `${c.reward}|${c.key}`;
		const b = chosen.get(k);
		if (!b || c.rank < b.rank || (c.rank === b.rank && (c.minLevel < b.minLevel || (c.minLevel === b.minLevel && c.q < b.q)))) chosen.set(k, c);
	}
	const byQuest = new Map();
	for (const c of chosen.values()) {
		if (!byQuest.has(c.q)) byQuest.set(c.q, { q: c.q, minLevel: c.minLevel, givers: [], races: {} });
		const s = byQuest.get(c.q);
		let i = s.givers.indexOf(c.giver);
		if (i < 0) i = s.givers.push(c.giver) - 1;
		s.races[c.key] = i + 1;
	}
	const starts = [...byQuest.values()].sort((a, b) => a.q - b.q);
	return { quests: out, rewards, starts };
}

const lua = (v) => (v === null || v === undefined ? 'nil' : typeof v === 'string' ? JSON.stringify(v) : String(v));

function toLua({ quests, rewards, starts = [] }) {
	const rrows = rewards.map((r) => {
		const f = [`kind = ${lua(r.kind)}`, `show = ${lua(r.show)}`];
		if (r.spell) f.push(`spell = ${r.spell}`, `spellName = ${lua(r.spellName)}`);
		if (r.items) {
			f.push(`items = { ${r.items.join(', ')} }`);
			if (r.itemNames.some((n) => n)) f.push(`itemNames = { ${r.itemNames.map(lua).join(', ')} }`);
			if (r.choice) f.push('choice = true');
		}
		if (r.icon) f.push(`icon = ${r.icon}`);
		return `\t\t{ ${f.join(', ')} },`;
	});
	const qrows = [];
	for (let i = 0; i < quests.length; i += 6) {
		qrows.push('\t\t' + quests.slice(i, i + 6).map((e) => `[${e.q}] = { ${e.mask}, ${e.chain}, ${e.reward} },`).join(' '));
	}
	return [
		header('lua', 'classrewards build', 'data/forever/quests.json, TrinityCore quest_template (data/sources/forever-tdb), the client tables and the guides\' `reward` lines'),
		'-- What each class quest chain gives, for the class-quest card (UI/ClassCard.lua).',
		'',
		'local ADDON, ns = ...',
		'',
		'ns.ClassRewards = {',
		'\t-- kind: "ability" | "pet" | "mount" (a spell); "weapon" | "armor" | "item" (items, a choice when `choice`)',
		'\trewards = {',
		...rrows,
		'\t},',
		'\t-- quest = { class mask (1 Warrior, 2 Paladin, 4 Hunter, 8 Rogue, 16 Priest, 64 Shaman, 128 Mage, 256 Warlock, 1024 Druid), chain, reward (0: none) }',
		'\tquests = {',
		...qrows,
		'\t},',
		'\t-- chain starts with a reward: quest = { min level, g = { giver, ... }, r = { ["<race>:<A|H>"] = giver index } };',
		'\t-- a giver = { name, uiMapID, x, y } (Era map percent); a race takes this quest for the reward only where r names it',
		'\tstarts = {',
		...starts.map((s) => {
			const g = s.givers.map((v) => `{ ${lua(v.name)}${v.map ? `, ${v.map}, ${v.x}, ${v.y}` : ''} }`).join(', ');
			const r = Object.keys(s.races).sort().map((k) => `["${k}"] = ${s.races[k]}`).join(', ');
			return `\t\t[${s.q}] = { ${s.minLevel}, g = { ${g} }, r = { ${r} } },`;
		}),
		'\t},',
		'}',
		'',
	].join('\n');
}

module.exports = {
	name: 'classrewards',
	summary: 'Build the class-quest card\'s data (what each class quest chain teaches or gives)',
	usage,
	buildClassRewards,
	classGuides,
	tableFinder,
	toLua,
	async run(argv) {
		const [sub, ...rest] = argv;
		if (sub !== 'build') {
			console.error(usage);
			return 2;
		}
		const { values } = parseArgs({ args: rest, options: { data: { type: 'string' }, sources: { type: 'string' }, guides: { type: 'string' }, lua: { type: 'string' } } });
		const dataDir = path.resolve(values.data || DATA);
		const sources = path.resolve(values.sources || SOURCES);
		const quests = JSON.parse(fs.readFileSync(path.join(dataDir, 'quests.json'), 'utf8'));
		const npcs = JSON.parse(fs.readFileSync(path.join(dataDir, 'npcs.json'), 'utf8'));
		const objects = JSON.parse(fs.readFileSync(path.join(dataDir, 'objects.json'), 'utf8'));
		const races = JSON.parse(fs.readFileSync(path.join(dataDir, 'races.json'), 'utf8'));
		const tdbFile = path.join(sources, 'forever-tdb', 'extract.json');
		const tdb = fs.existsSync(tdbFile) ? JSON.parse(fs.readFileSync(tdbFile, 'utf8')) : null;
		const guides = classGuides(path.resolve(values.guides || path.join(ROOT, 'guides')));
		const data = { ...buildClassRewards({ quests, tdb, table: tableFinder(sources), guides, npcs, objects, races }) };
		const out = path.resolve(values.lua || path.join(ROOT, 'addon', 'Polestar', 'UI', 'ClassRewards.lua'));
		fs.mkdirSync(path.dirname(out), { recursive: true });
		fs.writeFileSync(out, toLua(data));
		const withReward = data.quests.filter((e) => e.reward).length;
		console.log(`classrewards: ${data.quests.length} class quest(s), ${withReward} with a reward, ${data.rewards.length} reward(s) -> ${path.relative(ROOT, out)}`);
		if (!tdb) console.log('classrewards: no forever-tdb extract; reward spells come from the guides only');
		return 0;
	},
};
