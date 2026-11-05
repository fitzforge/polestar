'use strict';
// The Dungeons journal's quests and rewards against Attune's dungeon quest
// lists (a local comparison: `codex attune`, docs/ARCHITECTURE.md "Codex").
// Attune (tools/lib/consume/attune.js, no licence) is only a yardstick: this
// report names what it lists that the journal does not and why, so a gap is
// fixed from release-safe data; nothing of Attune's reaches a build.
//
//   auditDungeonQuests({ journal, attune, quests, forever, build }) -> { rows, rewards, markdown }
//
// journal: data/forever/codex/journal.json; attune: readAttune(); quests: the
// Codex quests (data/forever/codex/quests.json); forever: data/forever
// quests.json (QuestieDB facts and Forever's `web` rows); build: the
// client build the Codex was built from.
//
// rows: one per Attune dungeon group and side: { name, faction, key, attune,
//   ours, both, chain, attuneOnly: [{ id, title, why }], oursOnly: [{ id, title, why }] }
// rewards: { checked, match, differ: [{ key, id, title, ours, web, attune }] }

const norm = (s) =>
	String(s || '')
		.toLowerCase()
		.replace(/^the\s+/, '')
		.replace(/[^a-z0-9]/g, '');

// Attune's names for instances the journal names otherwise.
const ALIAS = {
	excavationsite: 'excavation-site-wetlands',
	stockade: 'stormwind-stockade',
	templeofatalhakkar: 'sunken-temple',
	lowerblackrockspire: 'blackrock-spire',
	upperblackrockspire: 'blackrock-spire',
};
const SIDE = { Alliance: 'A', Horde: 'H' };
// What the audit found for the quests Attune lists that the journal leaves
// out on purpose (each checked on its public source, 2026-10-15).
const VERDICTS = {
	96403: "Forever's quest data (quest 96403) says Side: Alliance (its list row side 1; one player's report, 2026-09-24, says the beta let both sides take it); QuestieDB has an Alliance race mask",
	469: 'Attune puts it before Highland Hides; a player\'s report on quest 98815 (2026-10-02) says Daily Delivery is not needed (Young Crocolisk Skins is)',
	5342: "the Barov story's follow-up outside: kill the other side's Barov heir; nothing of it is in Scholomance",
	5344: "the Barov story's follow-up outside: kill the other side's Barov heir; nothing of it is in Scholomance",
	5961: 'Sylvanas sends you to Nathanos Blightcaller; no source names it a prerequisite of his errands (QuestieDB, Forever\'s quest data for quests 5961 and 6022)',
	6144: 'Attune puts it before Ramstein; QuestieDB opens both with Duskwing and The Corpulent One (preAll 6135, 6136), and its chain goes on outdoors (The Crimson Courier, an Eastern Plaguelands NPC per Forever\'s NPC data, npc 12337)',
};
const QUEST_STEPS = new Set(['Pick Up', 'Quest', 'Turn In']);
// Forever's quest types.
const DUNGEON = 81;
const RAID = 62;

function pageKeyOf(journal) {
	const byName = {};
	for (const [k, p] of Object.entries(journal.dungeons || {})) byName[norm(p.name)] = k;
	return (name) => ALIAS[norm(name)] || byName[norm(name)] || null;
}

const sideOk = (side, f) => !side || !f || f === side;

function itemSets(list) {
	const choice = new Set();
	const fixed = new Set();
	for (const it of list || []) (it.choice ? choice : fixed).add(it.id);
	return { choice, fixed };
}
const pairSets = (choices, items) => ({ choice: new Set((choices || []).map((p) => p[0])), fixed: new Set((items || []).map((p) => p[0])) });
const same = (a, b) => a.size === b.size && [...a].every((x) => b.has(x));
const fmt = (s) => ({ choice: [...s.choice].sort((a, b) => a - b), fixed: [...s.fixed].sort((a, b) => a - b) });

function auditDungeonQuests({ journal = {}, attune = {}, quests = {}, forever = {}, build = null } = {}) {
	const keyOf = pageKeyOf(journal);
	const pages = journal.dungeons || {};
	const title = (id) => (quests[id] && quests[id].title) || (forever[id] && forever[id].title) || null;
	const onPages = (id) => Object.entries(pages).filter(([, p]) => p.quests.some((q) => q.id === id)).map(([k]) => k);
	const rows = [];
	for (const a of attune.attunes || []) {
		if (a.group !== 'DUNGEONS') continue;
		const side = SIDE[a.faction] || null;
		const key = keyOf(a.name);
		const p = key ? pages[key] : null;
		const ids = [...new Set(a.steps.filter((s) => QUEST_STEPS.has(s.type) && s.ref).map((s) => s.ref))];
		const ours = new Map();
		const chain = new Set();
		if (p) {
			for (const q of p.quests) if (sideOk(side, q.faction)) ours.set(q.id, q);
			for (const q of p.quests) if (sideOk(side, q.faction)) for (const c of q.chain || []) chain.add(c);
		}
		const row = { name: a.name, faction: a.faction, key, attune: ids.length, ours: ours.size, both: 0, chain: 0, attuneOnly: [], oursOnly: [] };
		for (const id of ids) {
			if (ours.has(id)) {
				row.both++;
				continue;
			}
			if (chain.has(id)) {
				row.chain++;
				continue;
			}
			const f = forever[id];
			const anySide = p && p.quests.find((q) => q.id === id);
			const live = f && (f.source || []).some((s) => /^questie|^recorder/.test(s));
			let why;
			if (VERDICTS[id]) why = VERDICTS[id];
			else if (!live) why = `not in QuestieDB's Forever store${f ? ' (pfQuest alone, no giver)' : ''}: retired or Season of Discovery (the web quest database lists those too)`;
			else if (anySide) why = `on the page for the ${anySide.faction === 'A' ? 'Alliance' : 'Horde'} only (our side data)`;
			else {
				const elsewhere = onPages(id).filter((k) => k !== key);
				if (elsewhere.length) why = `on the ${elsewhere.join(', ')} page`;
				else if (f && f.web && (f.web.type === DUNGEON || f.web.type === RAID)) why = `the web quest database files it as a ${f.web.type === RAID ? 'raid' : 'dungeon'} quest of area ${f.web.zone}`;
				else why = 'no link to the instance or to a page quest in our data';
			}
			row.attuneOnly.push({ id, title: title(id), why });
		}
		for (const [id, q] of ours) {
			if (ids.includes(id)) continue;
			const f = forever[id] || {};
			const w = f.web;
			const why = w && (w.type === DUNGEON || w.type === RAID) ? 'web: dungeon quest' : w && w.zone && p && f.area !== w.zone && (p.quests || []).length ? `web area ${w.zone}` : q.inside ? 'inside' : q.chain && q.chain.some((c) => ids.includes(c)) ? 'follows an Attune quest' : 'objectives or area in the instance';
			row.oursOnly.push({ id, title: q.title, why });
		}
		rows.push(row);
	}

	// Rewards: every journal quest's items against Forever's list row and Attune's table.
	const rewards = { checked: 0, match: 0, differ: [] };
	for (const [key, p] of Object.entries(pages)) {
		for (const q of p.quests) {
			const w = forever[q.id] && forever[q.id].web;
			const at = (attune.rewards || {})[q.id];
			if (!w && !at) continue;
			rewards.checked++;
			const o = itemSets(q.rewards && q.rewards.items);
			const wh = w ? pairSets(w.choices, w.items) : null;
			const as = at ? pairSets(at.choice, at.fixed) : null;
			const okW = !wh || (same(o.choice, wh.choice) && same(o.fixed, wh.fixed));
			const okA = !as || (same(o.choice, as.choice) && same(o.fixed, as.fixed));
			if (okW && okA) rewards.match++;
			else rewards.differ.push({ key, id: q.id, title: q.title, ours: fmt(o), web: wh && fmt(wh), attune: as && fmt(as) });
		}
	}
	return { rows, rewards, markdown: markdown(rows, rewards, attune, build) };
}

function markdown(rows, rewards, attune, build) {
	const out = [];
	const m = attune.meta || {};
	out.push('# Dungeon quests: the journal against Attune');
	out.push('');
	out.push(`Local comparison (\`codex attune\`), never shipped. Attune ${m.version || '?'} (${m.licence || 'no licence'}) is a yardstick only; the journal is the release Codex${build ? ` (client build ${build})` : ''}.`);
	out.push('Per Attune dungeon group and side: Attune\'s quests (Pick Up, Quest and Turn In steps), ours (the page\'s quests for that side), both, Attune\'s that the page shows as a prerequisite in a quest\'s chain, then the rest each way.');
	out.push('');
	out.push('| Dungeon | Side | Attune | Ours | Both | In a chain | Attune only | Ours only |');
	out.push('|---|---|---:|---:|---:|---:|---:|---:|');
	for (const r of rows) out.push(`| ${r.name}${r.key ? '' : ' (no instance)'} | ${r.faction} | ${r.attune} | ${r.ours} | ${r.both} | ${r.chain} | ${r.attuneOnly.length} | ${r.oursOnly.length} |`);
	out.push('');
	const none = rows.filter((r) => !r.key).map((r) => r.name);
	if (none.length) {
		out.push(`Attune groups with no journal instance: ${[...new Set(none)].join(', ')} (no \`Map\` instance row in the Forever client${build ? ` build ${build}` : ''}; Attune lists no quests for them).`);
		out.push('');
	}
	out.push('## Attune only');
	out.push('');
	for (const r of rows) {
		if (!r.attuneOnly.length) continue;
		out.push(`### ${r.name} (${r.faction})`);
		out.push('');
		for (const q of r.attuneOnly) out.push(`- ${q.id} ${q.title || '?'}: ${q.why}`);
		out.push('');
	}
	out.push('## Ours only');
	out.push('');
	for (const r of rows) {
		if (!r.oursOnly.length) continue;
		out.push(`### ${r.name} (${r.faction})`);
		out.push('');
		for (const q of r.oursOnly) out.push(`- ${q.id} ${q.title || '?'}: ${q.why}`);
		out.push('');
	}
	out.push('## Rewards');
	out.push('');
	out.push(`${rewards.checked} journal quests with a web quest database list row or an Attune reward row; ${rewards.match} show the same choices and fixed rewards as both, ${rewards.differ.length} differ from one of them:`);
	out.push('');
	const ids = (s) => (s ? `choose ${s.choice.join(', ') || '-'}; get ${s.fixed.join(', ') || '-'}` : 'n/a');
	for (const d of rewards.differ) out.push(`- ${d.key} ${d.id} ${d.title}: ours ${ids(d.ours)} | web ${ids(d.web)} | Attune ${ids(d.attune)}`);
	out.push('');
	return out.join('\n');
}

module.exports = { auditDungeonQuests, ALIAS };
