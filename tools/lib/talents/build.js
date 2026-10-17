'use strict';
// Talent plans for the addon's Talents module: talents/forever/<class>.json
// (picks by talent name, one per level) resolved against the Forever client's
// trait tables and replayed point by point under the client's rules, then
// written as addon/Polestar/Talents/Builds.lua with a snapshot of the tree,
// so the addon can check its plan against the live tree at run time.
//
// Forever's three-column trees are one C_Traits tree per class:
//   SkillLineXTraitTree  SkillLineID (class skill line) -> TraitTreeID
//   TraitNode            ID, TraitTreeID, PosX, PosY (columns by PosX, rows by PosY)
//   TraitNodeXTraitNodeEntry -> TraitNodeEntry (MaxRanks, TraitDefinitionID)
//   TraitDefinition      SpellID (name from SpellName)
//   TraitNodeGroupXTraitNode, TraitNodeGroupXTraitCond -> TraitCond: a node
//                        group gated on points spent (CondType 0,
//                        SpentAmountRequired) in the group TraitNodeGroupID
//   TraitEdge            LeftTraitNodeID -> RightTraitNodeID (an arrow);
//                        Type 0 is drawn only (VisualOnly) and gates nothing;
//                        of several arrows into one talent, any one will do

// Whether an arrow needs the talent before it at full rank ("full") or one
// rank ("started"). Unconfirmed in game: the one switch for the tool's replay
// and the addon (Builds.lua carries it). Flip it, then `talents build`.
const PREREQ_RULE = 'full';

const TABLES = [
	'SkillLineXTraitTree',
	'TraitNode',
	'TraitNodeEntry',
	'TraitDefinition',
	'TraitNodeXTraitNodeEntry',
	'TraitNodeGroupXTraitNode',
	'TraitNodeGroupXTraitCond',
	'TraitCond',
	'TraitEdge',
	'SpellName',
];

// Each class's tree, by its class skill line (SkillLineXTraitTree).
const CLASSES = {
	DRUID: { skillLine: 574, name: 'Druid' },
	HUNTER: { skillLine: 50, name: 'Hunter' },
	MAGE: { skillLine: 237, name: 'Mage' },
	PALADIN: { skillLine: 184, name: 'Paladin' },
	PRIEST: { skillLine: 613, name: 'Priest' },
	ROGUE: { skillLine: 38, name: 'Rogue' },
	SHAMAN: { skillLine: 373, name: 'Shaman' },
	WARLOCK: { skillLine: 354, name: 'Warlock' },
	WARRIOR: { skillLine: 26, name: 'Warrior' },
};
const FIRST_LEVEL = 10; // the first talent point
const COLUMN_GAP = 1200; // PosX distance that separates two spec columns
const SAME_X = 100; // PosX (or PosY) within this is one column (or row) of a spec

const num = (v) => Number(v) || 0;
const VISUAL_ONLY = 0; // TraitEdge.Type of a line that is not a prerequisite
const REQUIRED = 3; // TraitEdge.Type of an arrow that must be met

// A stray copy of a talent: a node with the same spell as another node of its
// tree, placed far off the tree's grid (more than STRAY_FAR times the other
// nodes' furthest PosX or PosY). In 1.60.1.70374 the Hunter tree has Lightning
// Reflexes twice (node 104982 at PosX 102800, ten times the real one's 10280)
// and the Priest tree Holy Specialization twice (node 105865 at PosY 21300,
// below the Shadow column). Kept, they would make a fourth spec column or an
// extra row; they are left out of the snapshot.
const STRAY_FAR = 2;
function strays(nodes) {
	const ids = Object.keys(nodes).map(Number);
	const bySpell = new Map();
	for (const id of ids) {
		const spell = nodes[id].spell;
		if (!bySpell.has(spell)) bySpell.set(spell, []);
		bySpell.get(spell).push(id);
	}
	const out = [];
	for (const id of ids) {
		const n = nodes[id];
		if (!n.spell || bySpell.get(n.spell).length < 2) continue;
		const others = ids.filter((o) => o !== id).map((o) => nodes[o]);
		const maxX = Math.max(...others.map((o) => o.x));
		const maxY = Math.max(...others.map((o) => o.y));
		if (n.x > STRAY_FAR * maxX || n.y > STRAY_FAR * maxY) out.push(id);
	}
	return out.sort((a, b) => a - b);
}

// Clusters sorted values: a new cluster wherever the gap exceeds `gap`.
function clusters(values, gap) {
	const out = [];
	for (const v of [...new Set(values)].sort((a, b) => a - b)) {
		const last = out[out.length - 1];
		if (last && v - last[last.length - 1] <= gap) last.push(v);
		else out.push([v]);
	}
	return out;
}

// -> { treeID, strays: [ids left out], nodes: { id: { entry, max, spell, name, spec, row, col } }, specs: [[ids]], groups, gates, edges }
function treeFacts(tables, cls) {
	const info = CLASSES[cls];
	if (!info) throw new Error(`talents: no tree known for class ${cls}`);
	const link = tables.SkillLineXTraitTree.find((r) => num(r.SkillLineID) === info.skillLine);
	if (!link) throw new Error(`talents: no TraitTree for skill line ${info.skillLine}`);
	const treeID = num(link.TraitTreeID);
	const spells = new Map(tables.SpellName.map((r) => [num(r.ID), r.Name_lang]));
	const defs = new Map(tables.TraitDefinition.map((r) => [num(r.ID), r]));
	const entries = new Map(tables.TraitNodeEntry.map((r) => [num(r.ID), r]));
	const entryOf = new Map();
	for (const r of tables.TraitNodeXTraitNodeEntry) if (!entryOf.has(num(r.TraitNodeID)) || num(r._Index) === 0) entryOf.set(num(r.TraitNodeID), num(r.TraitNodeEntryID));
	const raw = tables.TraitNode.filter((r) => num(r.TraitTreeID) === treeID);
	const nodes = {};
	for (const r of raw) {
		const id = num(r.ID);
		const entry = entries.get(entryOf.get(id));
		if (!entry) continue;
		const def = defs.get(num(entry.TraitDefinitionID));
		const spell = def ? num(def.SpellID) : 0;
		const name = (def && def.OverrideName_lang) || spells.get(spell) || '';
		nodes[id] = { entry: num(entry.ID), max: num(entry.MaxRanks), spell, name, x: num(r.PosX), y: num(r.PosY) };
	}
	const dropped = strays(nodes);
	for (const id of dropped) delete nodes[id];
	const all = Object.values(nodes);
	const specCols = clusters(all.map((n) => n.x), COLUMN_GAP);
	const rows = clusters(all.map((n) => n.y), SAME_X); // PosY a few units apart (Warlock's 2120 and 2130) is one row
	const specs = specCols.map(() => []);
	for (const [id, n] of Object.entries(nodes)) {
		const s = specCols.findIndex((c) => c.includes(n.x));
		const cols = clusters(specCols[s], SAME_X);
		n.spec = s + 1;
		n.row = rows.findIndex((r) => r.includes(n.y)) + 1;
		n.col = cols.findIndex((c) => c.includes(n.x)) + 1;
		specs[s].push(num(id));
	}
	// Gates: a node in a gated group needs points spent in the counted group.
	const conds = new Map(tables.TraitCond.filter((r) => num(r.CondType) === 0 && num(r.SpentAmountRequired) > 0).map((r) => [num(r.ID), r]));
	const condsOfGroup = new Map();
	for (const r of tables.TraitNodeGroupXTraitCond) {
		const c = conds.get(num(r.TraitCondID));
		if (!c) continue;
		const g = num(r.TraitNodeGroupID);
		if (!condsOfGroup.has(g)) condsOfGroup.set(g, []);
		condsOfGroup.get(g).push({ group: num(c.TraitNodeGroupID), need: num(c.SpentAmountRequired) });
	}
	const members = new Map();
	const gates = {};
	for (const r of tables.TraitNodeGroupXTraitNode) {
		const id = num(r.TraitNodeID);
		const g = num(r.TraitNodeGroupID);
		if (!nodes[id]) continue;
		if (!members.has(g)) members.set(g, []);
		members.get(g).push(id);
		for (const gate of condsOfGroup.get(g) || []) (gates[id] = gates[id] || []).push(gate);
	}
	const groups = {};
	for (const list of Object.values(gates)) for (const { group } of list) groups[group] = (members.get(group) || []).slice().sort((a, b) => a - b);
	for (const list of Object.values(gates)) list.sort((a, b) => a.need - b.need || a.group - b.group);
	// Type 0 (VisualOnly) draws a line without gating: the Druid tree's
	// Nature's Splendor -> Nature's Majesty, beside the real arrow back.
	const edges = tables.TraitEdge.filter((r) => num(r.Type) !== VISUAL_ONLY && nodes[num(r.LeftTraitNodeID)] && nodes[num(r.RightTraitNodeID)])
		.map((r) => ({ from: num(r.LeftTraitNodeID), to: num(r.RightTraitNodeID), type: num(r.Type) }))
		.sort((a, b) => a.to - b.to || a.from - b.from);
	// A Required arrow (Type 3) must be met whatever else leads in; the replay
	// knows only "any one arrow", so a tree that mixes them is refused.
	for (const e of edges) {
		if (e.type === REQUIRED && edges.some((o) => o.to === e.to && o !== e)) throw new Error(`talents: node ${e.to} has a Required arrow beside others, which the replay does not model`);
	}
	for (const e of edges) delete e.type;
	return { cls, treeID, strays: dropped, nodes, specs, groups, gates, edges };
}

// A plan's picks by name -> node IDs. tree names the column (source.order).
function resolveBuild(facts, source, build) {
	const errors = [];
	const picks = [];
	const notes = {};
	build.picks.forEach((p, i) => {
		const where = `${build.key} pick ${i + 1} (level ${p.level}, ${p.talent})`;
		const spec = source.order.indexOf(p.tree) + 1;
		if (!spec) return errors.push(`${where}: unknown tree "${p.tree}"`);
		const hits = facts.specs[spec - 1].filter((id) => facts.nodes[id].name === p.talent);
		if (hits.length !== 1) return errors.push(`${where}: ${hits.length ? 'more than one' : 'no'} ${p.tree} talent named "${p.talent}"`);
		picks.push({ level: p.level, node: hits[0], rank: p.rank });
		if (p.note) notes[p.level] = p.note;
	});
	return { picks, notes, errors };
}

// Every pick under the client's rules: one point per level from 10, the next
// rank of its talent, the tier gate met and every arrow into it satisfied.
function replay(facts, picks, { prereq = PREREQ_RULE } = {}) {
	const errors = [];
	const ranks = {};
	const spent = (g) => (facts.groups[g] || []).reduce((s, id) => s + (ranks[id] || 0), 0);
	picks.forEach((p, i) => {
		const n = facts.nodes[p.node];
		const where = `pick ${i + 1} (level ${p.level}, ${n ? n.name : p.node})`;
		if (!n) return errors.push(`${where}: node ${p.node} is not in tree ${facts.treeID}`);
		if (p.level !== FIRST_LEVEL + i) errors.push(`${where}: expected level ${FIRST_LEVEL + i}`);
		const have = ranks[p.node] || 0;
		if (p.rank !== have + 1) errors.push(`${where}: rank ${p.rank} after ${have}`);
		if (p.rank > n.max) errors.push(`${where}: rank ${p.rank} of ${n.max}`);
		for (const g of facts.gates[p.node] || []) if (spent(g.group) < g.need) errors.push(`${where}: needs ${g.need} points in its tree, has ${spent(g.group)}`);
		// Several arrows into one talent: any one of them opens it (the
		// client's SufficientForAvailability edges, as the Hunter's
		// Intimidation, from Bestial Swiftness or Bestial Wrath).
		const into = facts.edges.filter((e) => e.to === p.node);
		const need = (e) => (prereq === 'full' ? facts.nodes[e.from].max : 1);
		if (into.length && !into.some((e) => (ranks[e.from] || 0) >= need(e))) {
			errors.push(`${where}: needs ${into.map((e) => `${facts.nodes[e.from].name} ${need(e)}/${facts.nodes[e.from].max}`).join(' or ')}`);
		}
		ranks[p.node] = p.rank;
	});
	return errors;
}

function luaStr(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n')}"`;
}

// One class's T.Register({ ... }) call, as lines. The summary and the
// per-level notes are our prose: literal L["..."] keys, so `i18n keys` lists
// them and each client reads its language's.
function emitRegister(facts, source, builds, prereq = PREREQ_RULE) {
	const L = ['T.Register({'];
	L.push(`\tclass = ${luaStr(source.class)}, tree = ${facts.treeID}, prereq = ${luaStr(prereq)},`);
	L.push(`\tsource = ${luaStr(source.source)}, url = ${luaStr(source.sourceUrl)},`);
	L.push(`\tsummary = L[${luaStr(source.summary)}],`);
	L.push(`\tspecs = { ${source.order.map(luaStr).join(', ')} },`);
	L.push('\t-- node = { entry, max ranks, spell, spec column, row, column, name }');
	L.push('\tnodes = {');
	for (const id of Object.keys(facts.nodes).map(Number).sort((a, b) => a - b)) {
		const n = facts.nodes[id];
		L.push(`\t\t[${id}] = { ${n.entry}, ${n.max}, ${n.spell}, ${n.spec}, ${n.row}, ${n.col}, ${luaStr(n.name)} },`);
	}
	L.push('\t},');
	L.push('\t-- node = { { counted group, points }, ... }');
	L.push('\tgates = {');
	for (const id of Object.keys(facts.gates).map(Number).sort((a, b) => a - b)) {
		L.push(`\t\t[${id}] = { ${facts.gates[id].map((g) => `{ ${g.group}, ${g.need} }`).join(', ')} },`);
	}
	L.push('\t},');
	L.push('\tgroups = {');
	for (const g of Object.keys(facts.groups).map(Number).sort((a, b) => a - b)) L.push(`\t\t[${g}] = { ${facts.groups[g].join(', ')} },`);
	L.push('\t},');
	L.push('\t-- { from, to }: the arrow\'s target needs its source first');
	L.push(`\tedges = { ${facts.edges.map((e) => `{ ${e.from}, ${e.to} }`).join(', ')} },`);
	L.push('\tbuilds = {');
	for (const b of builds) {
		L.push('\t\t{');
		L.push(`\t\t\tkey = ${luaStr(b.key)}, spec = ${source.order.indexOf(b.spec) + 1}, split = ${luaStr(b.split)}, link = ${luaStr(b.link)},`);
		L.push('\t\t\t-- in order, one point each: { node, rank }');
		const rows = [];
		for (let i = 0; i < b.picks.length; i += 6) rows.push(`\t\t\t\t${b.picks.slice(i, i + 6).map((p) => `{ ${p.node}, ${p.rank} },`).join(' ')}`);
		L.push('\t\t\tpicks = {', ...rows, '\t\t\t},');
		L.push('\t\t\tnotes = {');
		for (const lv of Object.keys(b.notes).map(Number).sort((x, y) => x - y)) L.push(`\t\t\t\t[${lv}] = L[${luaStr(b.notes[lv])}],`);
		L.push('\t\t\t},', '\t\t},');
	}
	L.push('\t},', '})');
	return L;
}

// parts: [{ facts, source, builds }], one T.Register per class, in order.
function emitLuaAll(header, parts, prereq = PREREQ_RULE) {
	const L = [header, '', 'local ADDON, ns = ...', 'local T = ns.Talents', 'local L = ns.L'];
	for (const p of parts) L.push('', ...emitRegister(p.facts, p.source, p.builds, prereq));
	L.push('');
	return L.join('\n');
}

function emitLua(header, facts, source, builds, prereq = PREREQ_RULE) {
	return emitLuaAll(header, [{ facts, source, builds }], prereq);
}

// source (talents/forever/<class>.json) + tables -> { lua, errors, facts, builds }
function buildTalents(source, tables, { header, prereq = PREREQ_RULE } = {}) {
	const facts = treeFacts(tables, source.class);
	const errors = [];
	const builds = [];
	for (const b of source.builds) {
		const r = resolveBuild(facts, source, b);
		errors.push(...r.errors);
		if (!r.errors.length) errors.push(...replay(facts, r.picks, { prereq }).map((e) => `${b.key} ${e}`));
		builds.push({ ...b, picks: r.picks, notes: r.notes });
	}
	return { facts, builds, errors, lua: emitLua(header || '-- Talents', facts, source, builds, prereq) };
}

// Several classes' sources -> one Builds.lua: { lua, errors, results }.
// Sources are sorted by class so the file does not depend on read order; a
// class may have one source.
function buildAllTalents(sources, tables, { header, prereq = PREREQ_RULE } = {}) {
	const errors = [];
	const seen = new Set();
	const sorted = [...sources].sort((a, b) => (a.class < b.class ? -1 : a.class > b.class ? 1 : 0));
	const results = [];
	for (const source of sorted) {
		if (seen.has(source.class)) {
			errors.push(`${source.class}: more than one plan file`);
			continue;
		}
		seen.add(source.class);
		const r = buildTalents(source, tables, { header, prereq });
		errors.push(...r.errors.map((e) => `${source.class} ${e}`));
		results.push({ source, ...r });
	}
	const lua = emitLuaAll(header || '-- Talents', results.map((r) => ({ facts: r.facts, source: r.source, builds: r.builds })), prereq);
	return { lua, errors, results };
}

module.exports = { PREREQ_RULE, TABLES, CLASSES, FIRST_LEVEL, STRAY_FAR, strays, treeFacts, resolveBuild, replay, buildTalents, buildAllTalents, emitLua, emitLuaAll };
