'use strict';
// The game's names in each language, Names.lua in the language folders
// addon/Polestar_<locale> (tools/lib/i18n/toc.js languageAddon), are built by
// `forge data names` (rust/crates/forge-data/src/names.rs; docs/ARCHITECTURE.md,
// "Names"; the runtime side is addon/Polestar/Core/Names.lua). What stays here
// is what the JS tools still read: the file of the ids whose every
// name is the English one (`i18n leaks`), and usedIds, the ids Polestar's data
// names (the compiled guides, the quest database, the Codex).

const fs = require('node:fs');
const path = require('node:path');
const { luaToJson } = require('../lua');
const { ROOT, DATA } = require('../paths');

const NAME_KINDS = ['quest', 'npc', 'object', 'item'];

const DEFAULTS = {
	guides: path.join(ROOT, 'addon', 'Polestar_Guides', 'Guides.lua'),
	questdb: path.join(ROOT, 'addon', 'Polestar_QuestDB'),
	codex: path.join(DATA, 'codex'),
};

// The ids whose every name in a language is the English one, per locale and
// kind (`forge data names` writes it on a build into addon/).
const SAME_AS_ENGLISH = path.join(ROOT, 'data', 'local', 'names-same-as-english.json');

const LIST = `
local function list(set)
  local l = {}
  for id in pairs(set) do l[#l + 1] = id end
  table.sort(l)
  return l
end
return { quest = list(__ids.quest), npc = list(__ids.npc), object = list(__ids.object), item = list(__ids.item) }`;

// Every compiled guide's goals, candidates, reagents and rewards: the keys
// quest, npc, object and item, the quests of pre, preAll and closedBy (one id
// or a list) and of preTitles (its keys), and a collect's sources (fromId,
// fromAlsoId, of kind fromKind).
const GUIDE_WALK = `
__ids = { quest = {}, npc = {}, object = {}, item = {} }
local KIND = { quest = "quest", npc = "npc", object = "object", item = "item" }
local QUESTS = { pre = true, preAll = true, closedBy = true }
local function add(kind, v) if type(v) == "number" then __ids[kind][v] = true end end
local function walk(t)
  for k, v in pairs(t) do
    if KIND[k] then add(KIND[k], v)
    elseif QUESTS[k] then
      if type(v) == "table" then for _, q in ipairs(v) do add("quest", q) end else add("quest", v) end
    elseif k == "preTitles" and type(v) == "table" then
      for q in pairs(v) do add("quest", q) end
    elseif k == "names" and type(v) == "table" then
      -- The prose's tokens, {kind:id}: names the guide's texts show.
      for key in pairs(v) do
        local kind, id = tostring(key):match("^(%l+):(%d+)$")
        if KIND[kind] then add(KIND[kind], tonumber(id)) end
      end
    end
    if type(v) == "table" then walk(v) end
  end
  local from = (t.fromKind == "npc" or t.fromKind == "object") and t.fromKind or "npc"
  add(from, t.fromId)
  add(from, t.fromAlsoId)
end
Polestar = { RegisterGuide = function(g) if type(g) == "table" then walk(g) end return true end }
`;

const QUESTDB_ADD = `
__ids = { quest = {}, npc = {}, object = {}, item = {} }
local KIND = { quests = "quest", npcs = "npc", objects = "object", items = "item" }
Polestar = { QuestDB = { AddChunk = function(kind, lo, hi, text)
  local into = KIND[kind] and __ids[KIND[kind]]
  if into and type(text) == "string" then for id in text:gmatch("\\n(%-?%d+)\\t") do into[tonumber(id)] = true end end
end } }
`;

const QUESTDB_FILES = ['Quests.lua', 'Npcs.lua', 'Objects.lua', 'Items.lua'];
const CODEX_FILES = { quest: 'quests.json', npc: 'npcs.json', object: 'objects.json', item: 'items.json' };

function toSets(raw) {
	return Object.fromEntries(NAME_KINDS.map((k) => [k, new Set((Array.isArray(raw[k]) ? raw[k] : []).map(Number))]));
}

// { guides: Guides.lua, questdb: addon folder, codex: data/forever/codex }
// -> { quest, npc, object, item: Set of ids, counts: { guides, questdb, codex: { kind: n } } }
function usedIds({ guides = DEFAULTS.guides, questdb = DEFAULTS.questdb, codex = DEFAULTS.codex } = {}) {
	if (!fs.existsSync(guides)) throw new Error(`no compiled guides at ${guides}: run forge guide compile, or pass --guides <Guides.lua>`);
	const qFiles = QUESTDB_FILES.map((f) => path.join(questdb, f));
	if (qFiles.some((f) => !fs.existsSync(f))) {
		throw new Error(`the quest database is not built (no ${path.join(questdb, 'Quests.lua')}): run forge data questdb, or pass --questdb <Polestar_QuestDB folder>`);
	}
	const cFiles = Object.fromEntries(Object.entries(CODEX_FILES).map(([k, f]) => [k, path.join(codex, f)]));
	if (Object.values(cFiles).some((f) => !fs.existsSync(f))) {
		throw new Error(`the Codex data is not built (no ${cFiles.quest}): run forge data codex, or pass --codex <data/forever/codex folder>`);
	}
	const sources = {
		guides: toSets(luaToJson({ files: [guides], prelude: GUIDE_WALK, expr: LIST })),
		questdb: toSets(luaToJson({ files: qFiles, prelude: QUESTDB_ADD, expr: LIST })),
		codex: Object.fromEntries(Object.entries(cFiles).map(([k, f]) => [k, new Set(Object.keys(JSON.parse(fs.readFileSync(f, 'utf8'))).map(Number).filter(Number.isFinite))])),
	};
	const out = { counts: {} };
	for (const kind of NAME_KINDS) out[kind] = new Set();
	for (const [src, sets] of Object.entries(sources)) {
		out.counts[src] = {};
		for (const kind of NAME_KINDS) {
			out.counts[src][kind] = sets[kind].size;
			for (const id of sets[kind]) out[kind].add(id);
		}
	}
	return out;
}

module.exports = { NAME_KINDS, DEFAULTS, SAME_AS_ENGLISH, usedIds };
