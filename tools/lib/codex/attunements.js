'use strict';
// Attunements and keys (docs/ARCHITECTURE.md, "Codex" and "Dungeons"): per
// Codex instance, what lets a character in or opens its doors, as steps the
// Dungeons page shows with the character's progress and the "Guide me
// through it" guide walks (addon/Polestar/Dungeons/Attune.lua).
//
// The cited table data/codex/attunements.json names each attunement's
// goal only: the quests that end its chain (one of them with `any`), or the
// key item. The steps come from the Codex: every prerequisite of a goal
// (all of `pre`, the `preAny` of the attunement's side), oldest first; a
// quest started by an item gets the item's drops before it; an item goal
// adds the item's own sources (drops and chests for a dropped key, the
// standing and the NPC that hands it out for Aqual Quintessence). `links`
// in the table add a prerequisite our quest data lacks, each with its public
// source (Forever's City of Dalaran chain); `inside` places an NPC or object
// of a chain with no open-world spawn that the Codex puts in no instance
// (Marshal Windsor, the Core Fragment), each with its public source, so the
// guide sends the player to that instance's entrance; `removed` lists what
// Forever took out (the Seal of Ascension), shown in the local comparison only.
//
//   loadAttunementTable(file?)          -> { attunements: [Entry], inside: [Inside], removed: [Removed] }
//   attunementsOf(codex, { table })     -> { byKey: { instanceKey: [Attunement] }, warnings: [string] }
//   auditReport(journal, attune, codex, { verdicts }) -> markdown: our chains against Attune's
//                                          (local only; `attune` from tools/lib/consume/attune.js;
//                                          verdicts default to data/local/attunements-verdicts.md)
//
// Attunement: { id, name, kind: 'attunement'|'key'|'item', need: 'each'|'one', faction: 'A'|'H'|null,
//   item: { id, name, quality }|null, note, level, any: bool, goal: [questIds], steps: [Step],
//   inside: [{ kind: 'npc'|'object', id, instance }]|null }   (the table's `inside` its steps use)
// Step: { kind: 'quest', id, title, level, minLevel, faction, classes, start, finish, startItem,
//          after: [ids], afterAny: [ids], goal: bool, rep: { faction, name, standing }|null }
//     | { kind: 'drop', item: { id, name }, npc: Place, chance, instance }
//     | { kind: 'object', item: { id, name }, object: Place, chance }
//     | { kind: 'rep', faction, name, standing }
//     | { kind: 'gift', item: { id, name }, npc: Place }
// Place: { kind: 'npc'|'object', id, name, map, x, y, f }  (first spawn; map nil when none is known)
//
// Facts only (ids, names, levels, standings, coordinates); the notes are our
// own wording.

const fs = require('node:fs');
const path = require('node:path');
const { citationText } = require('./web');

const TABLE = path.join(__dirname, '..', '..', '..', 'data', 'codex', 'attunements.json');
// Our verdicts on the differences (which source is right, and why): local
// notes, kept apart so a rerun of the comparison keeps them.
const VERDICTS = path.join(__dirname, '..', '..', '..', 'data', 'local', 'attunements-verdicts.md');
const SIDE = { Alliance: 'A', Horde: 'H', A: 'A', H: 'H' };
const KINDS = new Set(['attunement', 'key', 'item']);
const MAX_STEPS = 60;
const MAX_SOURCES = 3;

function loadAttunementTable(file = TABLE) {
	const raw = JSON.parse(fs.readFileSync(file, 'utf8'));
	return { attunements: raw.attunements || [], inside: raw.inside || [], removed: raw.removed || [] };
}

function placeOf(kind, id, codex) {
	if (!id) return null;
	const rec = kind === 'object' ? codex.objects && codex.objects[id] : codex.npcs && codex.npcs[id];
	const s = rec && (rec.spawns || [])[0];
	return { kind, id, name: (rec && rec.name) || null, map: s ? s.map : null, x: s ? s.x : null, y: s ? s.y : null, f: s && s.f === 'e' ? 'e' : null };
}

function itemRef(id, codex) {
	const it = codex.items && codex.items[id];
	return { id, name: (it && it.name) || null };
}

// An item's sources as steps: drops and chests (best chance first, at most
// MAX_SOURCES) and, with `grants`, the standing and the NPC handing it out.
function sourceSteps(itemId, codex, { drops = true, grants = false } = {}) {
	const it = codex.items && codex.items[itemId];
	const out = [];
	if (!it) return out;
	const item = itemRef(itemId, codex);
	const src = it.sources || [];
	if (drops) {
		const found = src.filter((s) => (s.type === 'drop' && s.npc) || (s.type === 'object' && s.object));
		found.sort((a, b) => (b.chance ?? -1) - (a.chance ?? -1) || (a.npc || a.object) - (b.npc || b.object));
		for (const s of found.slice(0, MAX_SOURCES)) {
			if (s.type === 'drop') out.push({ kind: 'drop', item, npc: placeOf('npc', s.npc, codex), chance: s.chance ?? null, instance: s.instance || (codex.npcs && codex.npcs[s.npc] && codex.npcs[s.npc].instance) || null });
			else out.push({ kind: 'object', item, object: placeOf('object', s.object, codex), chance: s.chance ?? null });
		}
	}
	if (grants) {
		for (const s of src) {
			if (s.type === 'rep' && s.faction && s.standing) out.push(repStep(s.faction, s.standing, codex));
		}
		for (const s of src) {
			if (s.type === 'gift' && s.npc) out.push({ kind: 'gift', item, npc: placeOf('npc', s.npc, codex) });
		}
	}
	return out;
}

function repStep(faction, standing, codex) {
	const f = codex.factions && codex.factions[faction];
	return { kind: 'rep', faction, name: (f && f.name) || null, standing };
}

function questStep(q, codex, after, afterAny) {
	const s = q.start || {};
	const e = q.end || {};
	const startItem = (s.item || [])[0] && !(s.npc || []).length && !(s.object || []).length ? itemRef(s.item[0], codex) : null;
	const f = q.repFaction && codex.factions && codex.factions[q.repFaction];
	const rep = q.repFaction && q.repStanding ? { faction: q.repFaction, name: (f && f.name) || null, standing: q.repStanding } : null;
	return {
		kind: 'quest',
		id: q.id,
		title: q.title || null,
		level: q.level ?? null,
		minLevel: q.minLevel ?? null,
		faction: SIDE[q.faction] || null,
		classes: Array.isArray(q.classes) && q.classes.length ? q.classes : null,
		start: placeOf('npc', (s.npc || [])[0], codex) || placeOf('object', (s.object || [])[0], codex),
		finish: placeOf('npc', (e.npc || [])[0], codex) || placeOf('object', (e.object || [])[0], codex),
		startItem,
		after,
		afterAny,
		goal: false,
		rep,
	};
}

// The NPCs and objects a chain's steps meet ("npc:<id>", "object:<id>"):
// quest givers and turn-ins, kill and click targets, the drop and chest
// sources of objective items, and the item steps' own NPC or object.
function entitiesOf(steps, codex) {
	const quests = codex.quests || {};
	const items = codex.items || {};
	const out = new Set();
	const add = (kind, id) => id && out.add(`${kind}:${id}`);
	for (const s of steps) {
		if (s.kind === 'quest') {
			const q = quests[s.id] || {};
			for (const e of [q.start || {}, q.end || {}]) {
				for (const id of e.npc || []) add('npc', id);
				for (const id of e.object || []) add('object', id);
			}
			for (const o of q.objectives || []) {
				if (o.type === 'kill') add('npc', o.id);
				else if (o.type === 'object') add('object', o.id);
				else if (o.type === 'item') {
					for (const src of (items[o.id] && items[o.id].sources) || []) {
						if (src.type === 'drop') add('npc', src.npc);
						else if (src.type === 'object') add('object', src.object);
					}
				}
			}
		} else if (s.npc) add('npc', s.npc.id);
		else if (s.object) add('object', s.object.id);
	}
	return out;
}

// One table entry -> Attunement | null (warnings pushed). inside: the table's `inside`.
function buildOne(entry, codex, warn, inside = []) {
	const quests = codex.quests || {};
	const links = entry.links || {};
	const side = SIDE[entry.faction] || null;
	const steps = [];
	const seen = new Set();
	const fits = (id) => {
		const q = quests[id];
		return q && (!side || !SIDE[q.faction] || SIDE[q.faction] === side);
	};
	const visit = (id) => {
		if (seen.has(id) || steps.length >= MAX_STEPS) return;
		seen.add(id);
		const q = quests[id];
		if (!q) {
			warn(`${entry.id}: quest ${id} is not in the Codex`);
			return;
		}
		const link = links[id] || links[String(id)];
		const pre = [...new Set([...(q.pre || []), ...((link && link.pre) || [])])].filter((p) => p !== id && quests[p]);
		let any = (q.preAny || []).filter((p) => p !== id && quests[p]);
		if (any.length > 1) {
			const mine = any.filter(fits);
			if (mine.length) any = mine;
		}
		for (const p of pre) visit(p);
		for (const p of any) visit(p);
		const step = questStep(q, codex, pre, any);
		// A quest only an item starts: where the item comes from, first.
		if (step.startItem) steps.push(...sourceSteps(step.startItem.id, codex));
		steps.push(step);
	};
	const goal = (entry.goal || []).filter((id) => {
		if (quests[id]) return true;
		warn(`${entry.id}: goal quest ${id} is not in the Codex`);
		return false;
	});
	if ((entry.goal || []).length && !goal.length) return null;
	for (const id of goal) visit(id);
	for (const s of steps) if (s.kind === 'quest' && goal.includes(s.id)) s.goal = true;
	if (entry.item) {
		if (!(codex.items && codex.items[entry.item])) warn(`${entry.id}: item ${entry.item} is not in the Codex`);
		steps.push(...sourceSteps(entry.item, codex, { drops: !goal.length, grants: true }));
	}
	if (!steps.length) {
		warn(`${entry.id}: no steps`);
		return null;
	}
	const it = entry.item && codex.items && codex.items[entry.item];
	// The level the chain asks for: its highest minLevel (of `any` goals, the lowest goal's).
	let level = it && it.reqLevel ? it.reqLevel : null;
	const goalLevels = [];
	for (const s of steps) {
		if (s.kind !== 'quest' || !s.minLevel) continue;
		if (s.goal) goalLevels.push(s.minLevel);
		else level = Math.max(level || 0, s.minLevel);
	}
	if (goalLevels.length) level = Math.max(level || 0, entry.any ? Math.min(...goalLevels) : Math.max(...goalLevels));
	return {
		id: entry.id,
		name: entry.name,
		kind: KINDS.has(entry.kind) ? entry.kind : 'attunement',
		need: entry.need === 'one' ? 'one' : 'each',
		faction: side,
		item: entry.item ? { id: entry.item, name: (it && it.name) || entry.name || null, quality: (it && it.quality) ?? null } : null,
		note: entry.note || null,
		level,
		any: !!entry.any,
		goal,
		steps,
		inside: placedInside(steps, codex, inside),
	};
}

// The table's `inside` entries this chain meets, in an instance of the Codex.
function placedInside(steps, codex, inside) {
	const met = entitiesOf(steps, codex);
	const instances = codex.instances || {};
	const out = inside.filter((e) => met.has(`${e.kind}:${e.id}`) && instances[e.instance]).map((e) => ({ kind: e.kind, id: e.id, instance: e.instance }));
	return out.length ? out : null;
}

function attunementsOf(codex = {}, { table } = {}) {
	const t = table || loadAttunementTable();
	const warnings = [];
	const byKey = {};
	const instances = codex.instances || {};
	for (const entry of t.attunements) {
		const warn = (m) => warnings.push(m);
		// An instance this build lacks (a fixture, a build without the client) has no page.
		if (!instances[entry.key]) continue;
		const a = buildOne(entry, codex, warn, t.inside || []);
		if (a) (byKey[entry.key] = byKey[entry.key] || []).push(a);
	}
	return { byKey, warnings };
}

// ---------------------------------------------------------------------------
// The local comparison with Attune (never in a release build)
// ---------------------------------------------------------------------------

const QUEST_TYPES = new Set(['Pick Up', 'Quest', 'Turn In']);
const ATTUNE_SIDE = { Alliance: 'A', Horde: 'H' };

function ourQuests(a) {
	return new Set(a.steps.filter((s) => s.kind === 'quest').map((s) => s.id));
}

function attuneQuests(at) {
	return new Set(at.steps.filter((s) => QUEST_TYPES.has(s.type) && s.ref).map((s) => s.ref));
}

const qname = (id, quests) => (quests[id] && quests[id].title ? `${quests[id].title} (${id})` : String(id));

// The goal of ours that quest `id` comes after (through pre and preAny), or null.
function followsGoal(id, goals, quests) {
	const want = new Set(goals || []);
	const seen = new Set();
	const stack = [id];
	while (stack.length && seen.size < 200) {
		const q = quests[stack.pop()];
		if (!q) continue;
		for (const p of [...(q.pre || []), ...(q.preAny || [])]) {
			if (want.has(p)) return p;
			if (!seen.has(p)) {
				seen.add(p);
				stack.push(p);
			}
		}
	}
	return null;
}

// journal: the Codex's journal.json; attune: readAttune(); codex: { quests } (the Codex's);
// verdicts: markdown appended as "## Verdicts" (default: data/local/attunements-verdicts.md when present).
function auditReport(journal, attune, codex = {}, { verdicts } = {}) {
	if (verdicts === undefined) verdicts = fs.existsSync(VERDICTS) ? fs.readFileSync(VERDICTS, 'utf8') : '';
	const quests = codex.quests || {};
	const ours = [];
	for (const [key, page] of Object.entries((journal && journal.dungeons) || {})) for (const a of page.attunement || []) ours.push({ key, page, a });
	const table = loadAttunementTable();
	const theirs = ((attune && attune.attunes) || []).filter((x) => !/^DUNGEONS$|^CLASS/.test(x.group || ''));
	const lines = [];
	lines.push('# Attunements: Polestar against Attune', '');
	lines.push(`Local comparison (Attune ${(attune && attune.meta && attune.meta.version) || '?'}: no licence, read here only). Ours: the Codex journal's attunements, built from the Codex's quests and items and the cited goals in data/codex/attunements.json.`, '');
	const matched = new Set();
	const rows = [];
	for (const at of theirs) {
		const tq = attuneQuests(at);
		const side = ATTUNE_SIDE[at.faction] || null;
		let best = null;
		let score = 0;
		for (const o of ours) {
			if (side && o.a.faction && o.a.faction !== side) continue;
			const oq = ourQuests(o.a);
			let n = 0;
			for (const id of tq) if (oq.has(id)) n++;
			const itemHit = o.a.item && at.steps.some((s) => s.type === 'Item' && s.ref === o.a.item.id) ? 1 : 0;
			if (n + itemHit > score) {
				score = n + itemHit;
				best = o;
			}
		}
		rows.push({ at, tq, best });
		if (best) matched.add(best);
	}
	lines.push('## Summary', '', '| Attune | Side | Ours | Quests both | Only Attune | Only ours |', '|---|---|---|---|---|---|');
	for (const { at, tq, best } of rows) {
		if (!best) {
			lines.push(`| ${at.name} (${at.group}) | ${at.faction || ''} | none | 0 | ${tq.size} | 0 |`);
			continue;
		}
		const oq = ourQuests(best.a);
		const both = [...tq].filter((id) => oq.has(id)).length;
		lines.push(`| ${at.name} (${at.group}) | ${at.faction || ''} | ${best.page.name}: ${best.a.name} | ${both} | ${tq.size - both} | ${oq.size - both} |`);
	}
	for (const o of ours) if (!matched.has(o)) lines.push(`| none | ${o.a.faction || ''} | ${o.page.name}: ${o.a.name} | 0 | 0 | ${ourQuests(o.a).size} |`);
	lines.push('');
	lines.push('## Differences', '');
	for (const { at, tq, best } of rows) {
		lines.push(`### ${at.name} (${at.group}, ${at.faction || 'both'})`, '');
		if (!best) {
			const inCodex = [...tq].filter((id) => quests[id]);
			lines.push(`No attunement of ours matches. Its quests in our Codex: ${inCodex.length ? inCodex.map((id) => qname(id, quests)).join(', ') : 'none'}.`, '');
			continue;
		}
		const oq = ourQuests(best.a);
		const onlyThem = [...tq].filter((id) => !oq.has(id));
		const onlyUs = [...oq].filter((id) => !tq.has(id));
		lines.push(`Ours: ${best.page.name}, ${best.a.name} (${best.a.steps.length} steps).`);
		if (!onlyThem.length && !onlyUs.length) lines.push('Same quests.');
		for (const id of onlyThem) {
			const q = quests[id];
			let why = 'not in our Codex (not a Forever quest our sources know)';
			if (q) {
				const needed = best.a.steps.some((s) => s.kind === 'quest' && ((s.after || []).includes(id) || (s.afterAny || []).includes(id)));
				const after = followsGoal(id, best.a.goal, quests);
				if (needed) why = 'in our chain';
				else if (after) why = `a follow-up of our goal ${qname(after, quests)}: it comes after the attunement is had, so ours stops before it`;
				else why = 'in our Codex, but no step of ours waits on it (our data: not a prerequisite)';
			}
			lines.push(`- Only Attune: ${qname(id, quests)}: ${why}.`);
		}
		for (const id of onlyUs) {
			const s = best.a.steps.find((x) => x.kind === 'quest' && x.id === id);
			const by = best.a.steps.filter((x) => x.kind === 'quest' && ((x.after || []).includes(id) || (x.afterAny || []).includes(id))).map((x) => qname(x.id, quests));
			lines.push(`- Only ours: ${qname(id, quests)}${s && s.goal ? ' (a goal)' : ''}${by.length ? `: a prerequisite of ${by.join(', ')}` : ''}.`);
		}
		const tItems = at.steps.filter((s) => s.type === 'Item').map((s) => s.ref);
		if (best.a.item && !tItems.includes(best.a.item.id)) lines.push(`- Ours names the item ${best.a.item.name} (${best.a.item.id}); Attune does not.`);
		lines.push('');
	}
	const unmatchedOurs = ours.filter((o) => !matched.has(o));
	if (unmatchedOurs.length) {
		lines.push('## Ours only', '');
		for (const o of unmatchedOurs) lines.push(`- ${o.page.name}: ${o.a.name} (${o.a.kind}, ${o.a.steps.length} steps): Attune has no entry for it.`);
		lines.push('');
	}
	if (table.removed.length) {
		lines.push('## Removed in Forever', '');
		for (const r of table.removed) lines.push(`- ${r.name} (${r.key}, item ${r.item}): ${r.why} Sources: ${r.sources.map(citationText).join('; ')}.`);
		lines.push('');
	}
	if (verdicts && verdicts.trim()) lines.push('## Verdicts', '', verdicts.trim());
	return `${lines.join('\n')}\n`;
}

module.exports = { loadAttunementTable, attunementsOf, auditReport, TABLE };
