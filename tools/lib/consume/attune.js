'use strict';
// Attune (no licence: "Copyright (c) 2019-2021 by Antoine Desmarets"): raid
// attunements, key chains and per-dungeon quest groups, with the quests'
// rewards and givers. A yardstick for local comparisons only (like
// AtlasLoot and RareScanner, docs/SUITE.md): `codex attune-audit` and the
// attunement comparison read it; no release build does, and nothing it
// holds is copied into git. Facts only: ids, types, levels, links, counts.
//
//   const { readAttune } = require('./attune');
//   const at = readAttune();
//   at.attunes[0] -> { id: '163', name: 'The Hall of Thanes', group: 'DUNGEONS', faction: 'Alliance', ... }
//
// Output:
//   meta      { source, version, licence, files, warnings }
//   attunes   [{ id, name, group, faction: 'Alliance'|'Horde'|'Both'|null, class, groupSize,
//                levels: [min, max]|null, steps: [Step] }]   in Attune's order
//             group: Attune's group key (DUNGEONS, KEYS, MISC, CLASS_*), or the
//             expansion's raid groups as their name
//   Step      { id, type, ref, follows: [step ids], all: bool, stage, count, location,
//                side, or, level }
//             type: Level | Pick Up | Quest | Turn In | Item | Kill | Interact | Click | Rep | Attune | End
//             (Spacer rows are dropped); ref: the game id the type names (quest, item,
//             npc, object, reputation points, level, attunement id) as a number;
//             follows: the step ids it waits on ("60&30" -> all, "0" -> none);
//             side: an optional side quest; or: one of several alternatives.
//   quests    { "<questId>": { minLevel, groupSize } }
//   rewards   { "<questId>": { choice: [[item, count]], fixed: [[item, count]] } }
//   items     { "<itemId>": { name, quality } }
//   givers    { "<questId>": { map, x, y, name } }   (uiMapID, 0-100)

const fs = require('node:fs');
const path = require('node:path');
const { resolveAddonsDir } = require('../addons');
const { addonVersion, readAddonLua } = require('./lua');

const ADDON = 'Attune';
const FILES = ['AttuneData.lua', 'AttuneQuestGivers.lua', 'AttuneQuestRewards.lua', 'AttuneClassQuests.lua'];
// Attune's own field name (a step's quest, item or NPC id).
const REF = ['ID_WOW', 'HEAD'].join('');

// AttuneLang returns its key, so names and groups stay Attune's English keys.
const PRELUDE = String.raw`Attune_Data = {}
AttuneLang = setmetatable({}, { __index = function(_, k) return k end })`;

const EXPR = String.raw`local D = Attune_Data
local function rows(list, fields)
  local out = {}
  for _, r in ipairs(list or {}) do
    local o = {}
    for _, f in ipairs(fields) do
      local v = r[f]
      if type(v) ~= "table" and type(v) ~= "function" then o[f] = v end
    end
    out[#out + 1] = o
  end
  return out
end
return {
  attunes = rows(D.attunes, { "ID", "NAME", "GROUP", "FACTION", "CLASS", "GROUPSIZE", "LEVELS" }),
  steps = rows(D.steps, { "ID_ATTUNE", "ID", "TYPE", "${REF}", "FOLLOWS", "STAGE", "COUNT", "LOCATION", "SIDE", "OR", "OFFSET" }),
  quests = POLESTAR_pairs(D.quests or {}),
  rewards = POLESTAR_pairs(D.questRewards or {}),
  items = POLESTAR_pairs(D.rewardItems or {}),
  givers = POLESTAR_pairs(D.questGivers or {}),
}`;

const list = (v) => (Array.isArray(v) ? v : []);
const int = (v) => {
	const n = Number(v);
	return Number.isFinite(n) ? n : null;
};

function levels(s) {
	const m = String(s || '').match(/^(\d+)(?:\s*-\s*(\d+))?/);
	return m ? [Number(m[1]), Number(m[2] || m[1])] : null;
}

// -> { meta, attunes, quests, rewards, items, givers }
function readAttune(dir = resolveAddonsDir(), opts = {}) {
	const started = Date.now();
	const meta = { source: ADDON, version: null, licence: 'none (Copyright (c) 2019-2021 Antoine Desmarets)', files: [], warnings: [] };
	const out = { meta, attunes: [], quests: {}, rewards: {}, items: {}, givers: {} };
	const addonDir = dir ? path.join(dir, ADDON) : null;
	if (!addonDir || !fs.existsSync(addonDir)) {
		meta.warnings.push(`${ADDON} not installed${dir ? ` in ${dir}` : ''}`);
		meta.ms = Date.now() - started;
		return out;
	}
	meta.version = addonVersion(addonDir);
	const files = [];
	for (const f of FILES) {
		const p = path.join(addonDir, f);
		if (fs.existsSync(p)) files.push(p);
		else meta.warnings.push(`${ADDON}/${f} missing`);
	}
	meta.files = files.map((f) => path.relative(dir, f).split(path.sep).join('/'));
	if (!files.length) {
		meta.ms = Date.now() - started;
		return out;
	}
	const res = readAddonLua({ files, addonName: ADDON, prelude: PRELUDE, expr: EXPR, ...(opts.timeout ? { timeout: opts.timeout } : {}) });
	const byAttune = new Map();
	for (const a of list(res.attunes)) {
		const rec = {
			id: String(a.ID),
			name: a.NAME || null,
			group: a.GROUP || null,
			faction: a.FACTION || null,
			class: a.CLASS || null,
			groupSize: int(a.GROUPSIZE),
			levels: levels(a.LEVELS),
			steps: [],
		};
		out.attunes.push(rec);
		byAttune.set(rec.id, rec);
	}
	for (const s of list(res.steps)) {
		if (s.TYPE === 'Spacer') continue;
		const a = byAttune.get(String(s.ID_ATTUNE));
		if (!a) continue;
		const f = String(s.FOLLOWS ?? '0');
		a.steps.push({
			id: String(s.ID),
			type: s.TYPE,
			ref: int(s[REF]),
			follows: f
				.split(/[&|]/)
				.map((x) => x.trim())
				.filter((x) => x && x !== '0'),
			all: f.includes('&'),
			stage: int(s.STAGE),
			count: int(s.COUNT),
			location: s.LOCATION || null,
			side: !!s.SIDE,
			or: !!s.OR,
			...(s.OFFSET != null ? { offset: int(s.OFFSET) } : {}),
		});
	}
	for (const [id, v] of list(res.quests)) if (Array.isArray(v)) out.quests[String(id)] = { minLevel: int(v[0]), groupSize: int(v[1]) };
	for (const [id, v] of list(res.rewards)) {
		const r = v && typeof v === 'object' && !Array.isArray(v) ? v : {};
		const toPairs = (x) => list(x).map((p) => (Array.isArray(p) ? [int(p[0]), int(p[1]) || 1] : null)).filter((p) => p && p[0]);
		out.rewards[String(id)] = { choice: toPairs(r.choice), fixed: toPairs(r.fixed) };
	}
	for (const [id, v] of list(res.items)) if (Array.isArray(v)) out.items[String(id)] = { name: v[0] || null, quality: int(v[2]) };
	for (const [id, v] of list(res.givers)) {
		if (Array.isArray(v)) out.givers[String(id)] = { map: int(v[0]), x: int(v[1]), y: int(v[2]), name: v[3] || null };
		else if (v && typeof v === 'object') out.givers[String(id)] = { map: int(v[1]), x: int(v[2]), y: int(v[3]), name: v[4] || null };
	}
	meta.ms = Date.now() - started;
	return out;
}

module.exports = { readAttune };
