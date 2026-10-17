'use strict';
// `i18n names`: the names of Polestar's data in each client language, as one
// load-on-demand addon per language, addon/Polestar_Names_<locale>
// (docs/ARCHITECTURE.md, "Names"; the runtime side is
// addon/Polestar/Core/Names.lua).
//
// Kinds: quest, npc, object and item (the ids the data names), and map
// (instances), encounter (dungeon bosses and events), faction, taxi (flight
// points) and objective (a quest's objective text, for the dungeon quests
// whose objective is an event no name covers).
//
// Sources, per id, the first one with a name winning:
//   1. The Forever client's own tables in that language, from wago.tools
//      (names-wago.js): items (ItemSparse), map, encounter, faction, taxi.
//   2. Wowhead's Forever database in that language (names-wowhead.js): its
//      list pages and tooltips, read only from what is already cached in
//      data/sources/wowhead/names, when present.
//      The only source for the names of Forever's own quests, NPCs and
//      objects.
//   3. DingDB (Ding/DB/Locales/<locale>.lua of Ding! by Yendi, GPL-3.0, used
//      with his permission: THIRD_PARTY.md), cloned into data/sources/ding
//      and pinned: the checkout must sit at DING.commit and every file must
//      have the sha256 below, or the build stops. Moving the pin is an edit
//      here, after reading what changed. Its base data comes from QuestieDB,
//      so --no-questie leaves it out.
//   4. pfQuest's db/<locale> (MIT; Era names, no esMX), the cache clone
//      `data build` uses (data/sources/pfQuest), for the names DingDB lacks.
//      A pfQuest name equal to its English one is no translation and is
//      skipped.
// Only the ids Polestar's data names are kept: the compiled guides
// (addon/Polestar_Guides/Guides.lua), the quest database
// (addon/Polestar_QuestDB), the Codex's data (data/forever/codex) and the
// travel data's flight points (addon/Polestar/Nav/TravelData.lua).

const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { luaToJson } = require('../lua');
const { header } = require('../generated');
const { checkLicense, REPO: PFQUEST_REPO } = require('../data/pfquest');
const { ROOT, DATA, SOURCES } = require('../paths');
const { luaString } = require('./files');
const { LOCALES, LOCALE_CODES } = require('./locales');
const { tocLines } = require('./toc');

const NAME_KINDS = ['quest', 'npc', 'object', 'item'];
const EXTRA_KINDS = ['map', 'encounter', 'faction', 'taxi', 'objective'];
const PACK_KINDS = [...NAME_KINDS, ...EXTRA_KINDS];
const SOURCE_KEYS = ['wago', 'wowhead', 'ding', 'pfquest'];
const ADDON_PREFIX = 'Polestar_Names_';
const CHUNK = 1000; // names per add() call

// DingDB at Ding v1.8.1. CREDITS.md ships beside the names.
const DING = {
	repo: 'https://github.com/moust4ki/DingGuideWoWForever',
	version: 'v1.8.1',
	commit: 'fb0a06a43d054ab53b67e8d7af9743a9f8953ac3',
	files: {
		'Ding/DB/CREDITS.md': 'd32ce3d857766e88d0afd94d39eb0d4e3317ccc5538a46720f0ac743dfd64ab9',
		'Ding/DB/Locales/deDE.lua': 'a2f4ebd5caaadf07c1704c494b3a41442211298d61f527201eb0ab4af2d7d1ec',
		'Ding/DB/Locales/esES.lua': '6bcc8a55f21723c641f7b8daa275649c548ea3eb08df3793197e75c4579ecf66',
		'Ding/DB/Locales/esMX.lua': '380da93d12f47ede6b8e248a8d8096431de6a8865e9cd5cf8ff775cb78a90ceb',
		'Ding/DB/Locales/frFR.lua': '5ba47c1ed481e9367c283adab21296103a63c3abe18dcfe7719e44f2d57d2469',
		'Ding/DB/Locales/koKR.lua': '8efe170a161c47ed64b1e4d0c9048773f6e2ce594906e95fa005c63940375f45',
		'Ding/DB/Locales/ptBR.lua': 'e9c320db5293eabf638158daae947585878811e7ec493fa5763759c83f1cd1dd',
		'Ding/DB/Locales/ruRU.lua': '3a7ec4e35701a690282ed0b5ec91240c8c7c62b1f0a32d0000e780f5d52f8636',
		'Ding/DB/Locales/zhCN.lua': 'c159cf9b6e2f4aa644fde6afc801168faf44273a4358ff7859ef3be5f9139646',
		'Ding/DB/Locales/zhTW.lua': '61fb6753b026f50314583cd6cbd90eb5e2332c839d0de2ab2eb4122756312b4b',
	},
};
const CREDITS = 'Ding/DB/CREDITS.md';
const dingFile = (locale) => `Ding/DB/Locales/${locale}.lua`;

const DEFAULTS = {
	ding: path.join(SOURCES, 'ding'),
	pfquest: path.join(SOURCES, 'pfQuest'),
	guides: path.join(ROOT, 'addon', 'Polestar_Guides', 'Guides.lua'),
	questdb: path.join(ROOT, 'addon', 'Polestar_QuestDB'),
	codex: path.join(DATA, 'codex'),
	travel: path.join(ROOT, 'addon', 'Polestar', 'Nav', 'TravelData.lua'),
	chokepoints: path.join(ROOT, 'addon', 'Polestar_Nav', 'Nav', 'Chokepoints.lua'),
	sources: SOURCES,
	out: path.join(ROOT, 'addon'),
};

const sha256 = (file) => crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');

function git(args, cwd) {
	return spawnSync('git', args, { cwd, encoding: 'utf8' });
}

// The commit a checkout rooted at dir is at, or null (not a checkout of its own).
function revisionOf(dir) {
	const top = git(['rev-parse', '--show-toplevel'], dir);
	if (top.status !== 0 || fs.realpathSync(top.stdout.trim()) !== fs.realpathSync(dir)) return null;
	const rev = git(['rev-parse', 'HEAD'], dir);
	return rev.status === 0 ? rev.stdout.trim() : null;
}

// Clones DingDB into dir when it is not there (not with `explicit`, a folder
// the user named, or `offline`), moves the cache clone to the pinned commit,
// and checks every pinned file's sha256. A named folder is used as it is: at
// another commit, or with a file that differs, it stops the build.
// -> { dir, revision (null for a folder that is no checkout), pin, files: [{ path, sha256 }] }
function ensureDing({ dir = DEFAULTS.ding, explicit = false, offline = false, pin = DING, log = () => {} } = {}) {
	if (!fs.existsSync(path.join(dir, 'Ding', 'DB'))) {
		if (explicit) throw new Error(`DingDB: ${dir} has no Ding/DB folder`);
		if (offline) throw new Error(`--offline: no cached DingDB at ${dir} (run once without --offline)`);
		log(`cloning ${pin.repo} into ${dir}`);
		fs.mkdirSync(path.dirname(dir), { recursive: true });
		const r = git(['clone', '--quiet', pin.repo, dir]);
		if (r.status !== 0) throw new Error(`git clone ${pin.repo} failed: ${(r.stderr || r.error || '').toString().trim()}`);
	}
	let revision = revisionOf(dir);
	if (!explicit && !revision) throw new Error(`DingDB: ${dir} is not a git checkout; delete it to clone again, or pass --ding <dir>`);
	if (revision && revision !== pin.commit) {
		if (explicit) throw new Error(`DingDB: ${dir} is at ${revision}, the pin is ${pin.commit} (${pin.version}): check that out, or move the pin (DING in tools/lib/i18n/names.js)`);
		let r = git(['-c', 'advice.detachedHead=false', 'checkout', '--quiet', pin.commit], dir);
		if (r.status !== 0 && !offline) {
			log(`fetching ${pin.repo} for ${pin.commit}`);
			git(['fetch', '--quiet', 'origin'], dir);
			r = git(['-c', 'advice.detachedHead=false', 'checkout', '--quiet', pin.commit], dir);
		}
		if (r.status !== 0) throw new Error(`DingDB: cannot check out ${pin.commit} in ${dir}: ${(r.stderr || '').trim()}`);
		revision = revisionOf(dir);
	}
	const files = [];
	for (const rel of Object.keys(pin.files).sort()) {
		const file = path.join(dir, rel);
		if (!fs.existsSync(file)) throw new Error(`DingDB: ${rel} is missing from ${dir}`);
		const got = sha256(file);
		if (got !== pin.files[rel]) {
			throw new Error(`DingDB: ${rel} has sha256 ${got}, the pin (${pin.version}, ${pin.commit.slice(0, 7)}) says ${pin.files[rel]}: read what changed, then move the pin (DING in tools/lib/i18n/names.js)`);
		}
		files.push({ path: rel, sha256: got });
	}
	return { dir, revision, pin, files };
}

const emptyKinds = () => Object.fromEntries(NAME_KINDS.map((k) => [k, new Map()]));

// DingDB's names of each locale whose file the pin lists, read by Lua the way
// Ding loads them (the file returns at once unless GetLocale() is its
// language). -> { [locale]: { quest, npc, object, item: Map id -> name } }
function readDing(ding, locales) {
	const out = {};
	for (const l of locales) out[l] = emptyKinds();
	const wanted = locales.filter((l) => ding.pin.files[dingFile(l)]);
	if (!wanted.length) return out;
	const calls = wanted.map((l) => `read(${luaString(path.join(ding.dir, dingFile(l)))}, ${luaString(l)})`).join('\n');
	const raw = luaToJson({
		expr: `
local out = {}
local function list(t)
  local l = {}
  for id, name in pairs(t) do
    if type(id) == "number" and type(name) == "string" then l[#l + 1] = { id, name } end
  end
  return l
end
local function read(file, locale)
  GetLocale = function() return locale end
  local Ding = { DB = { names = { quests = {}, npcs = {}, objects = {}, items = {} } } }
  local ok, err = __polestar_loaddata(file, "Ding", Ding)
  if not ok then error(err, 0) end
  local n = Ding.DB.names
  out[locale] = { quest = list(n.quests), npc = list(n.npcs), object = list(n.objects), item = list(n.items) }
end
${calls}
return out`,
	});
	for (const l of wanted) {
		for (const kind of NAME_KINDS) {
			const list = Array.isArray(raw[l] && raw[l][kind]) ? raw[l][kind] : [];
			for (const [id, name] of list.sort((a, b) => a[0] - b[0])) out[l][kind].set(Number(id), name);
		}
	}
	return out;
}

// --- The ids Polestar's data names -------------------------------------------

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
Polestar = { QuestDB = { AddData = function(kind, records)
  local into = KIND[kind] and __ids[KIND[kind]]
  if into and type(records) == "table" then for id in pairs(records) do if type(id) == "number" then into[id] = true end end end
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
	if (!fs.existsSync(guides)) throw new Error(`no compiled guides at ${guides}: run node tools/polestar.js compile, or pass --guides <Guides.lua>`);
	const qFiles = QUESTDB_FILES.map((f) => path.join(questdb, f));
	if (qFiles.some((f) => !fs.existsSync(f))) {
		throw new Error(`the quest database is not built (no ${path.join(questdb, 'Quests.lua')}): run node tools/polestar.js questdb build, or pass --questdb <Polestar_QuestDB folder>`);
	}
	const cFiles = Object.fromEntries(Object.entries(CODEX_FILES).map(([k, f]) => [k, path.join(codex, f)]));
	if (Object.values(cFiles).some((f) => !fs.existsSync(f))) {
		throw new Error(`the Codex data is not built (no ${cFiles.quest}): run node tools/polestar.js codex build, or pass --codex <data/forever/codex folder>`);
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

const readJsonIf = (file) => (fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null);

// The ids of the kinds beside quest, npc, object and item: instance maps
// (codex instances.json), every encounter the client has (null: no list),
// factions (codex factions.json), flight points (TravelData.lua's taxi rows)
// and the objectives of the dungeon quests (journal.json) with an objective
// that is an event, or names nothing by id (codex quests.json); and
// liftObject, the lifts' game objects the walking map's chokepoints name
// (Polestar_Nav's Chokepoints.lua, `liftObject = <id>`), more object ids. A
// missing input leaves its kind empty.
// -> { map, faction, taxi, objective, liftObject: Set, encounter: null }
function extraIds({ codex = DEFAULTS.codex, travel = DEFAULTS.travel, chokepoints = DEFAULTS.chokepoints } = {}) {
	const out = { map: new Set(), encounter: null, faction: new Set(), taxi: new Set(), objective: new Set(), liftObject: new Set() };
	const instances = readJsonIf(path.join(codex, 'instances.json')) || {};
	for (const i of Object.values(instances)) if (Number(i.map) > 0) out.map.add(Number(i.map));
	const factions = readJsonIf(path.join(codex, 'factions.json')) || {};
	for (const id of Object.keys(factions)) if (Number(id) > 0) out.faction.add(Number(id));
	if (fs.existsSync(chokepoints)) {
		for (const m of fs.readFileSync(chokepoints, 'utf8').matchAll(/\bliftObject\s*=\s*(\d+)/g)) out.liftObject.add(Number(m[1]));
	}
	if (fs.existsSync(travel)) {
		const ids = luaToJson({
			files: [],
			expr: `
local ids = {}
local Nav = setmetatable({ RegisterTravelData = function(d)
  for _, t in ipairs(type(d) == "table" and d.taxi or {}) do if type(t[1]) == "number" then ids[#ids + 1] = t[1] end end
end }, { __index = function() return function() end end })
local ns = { Nav = Nav }
local ok, err = __polestar_loaddata(${luaString(travel)}, "Polestar", ns)
if not ok then error(err, 0) end
return ids`,
		});
		for (const id of Array.isArray(ids) ? ids : []) out.taxi.add(Number(id));
	}
	const journal = readJsonIf(path.join(codex, 'journal.json'));
	const quests = readJsonIf(path.join(codex, 'quests.json')) || {};
	const inJournal = new Set();
	const walk = (v, key) => {
		if (Array.isArray(v)) for (const x of v) walk(x, key);
		else if (v && typeof v === 'object') {
			if (typeof v.id === 'number' && quests[v.id]) inJournal.add(v.id);
			for (const [k, x] of Object.entries(v)) walk(x, k);
		} else if (typeof v === 'number' && /quest|chain|pre/i.test(key || '') && quests[v]) inJournal.add(v);
	};
	if (journal) walk(journal.dungeons || journal);
	for (const id of inJournal) {
		if ((quests[id].objectives || []).some((o) => o && (o.type === 'event' || o.id == null))) out.objective.add(id);
	}
	return out;
}

// --- Merging ------------------------------------------------------------------

// A name as it is written into the pack: every run of white space (a line
// break too) one space, none at the ends.
const clean = (s) => (typeof s === 'string' ? s.replace(/\s+/g, ' ').trim() : '');
// pfQuest's objective text: its $B line breaks as spaces (other $ tokens stay).
const objectiveText = (s) => clean(typeof s === 'string' ? s.replace(/\$[Bb]/g, ' ') : s);
// Markers of content the game does not use (test, placeholder, retired), in
// English and the client languages: a name holding one is no name.
const PLACEHOLDER = /\[(?:PH|TMP|UNUSED|NOT USED|DEPRECATED|NYI|DNT|INUTILIS[ÉE]|P[ÉE]RIM[ÉE]|OBSOLETO|VERALTET)\]|<(?:NYI|TXT|UNUSED|PH|TMP|DEPRECATED)>|\((?:PH|TMP|NYI|DNT|UNUSED|DEPRECATED|TEST|JEFFTEST|OLD\d*|тест|시험용|测试|測試)\)|^zzOLD|\bDEPRECATED\b/iu;
const usable = (s) => Boolean(s) && !PLACEHOLDER.test(s);

// English names to tell a translation from a string left in English:
// { kind: Map id -> name | Set of names }. addEnglish merges into one.
function addEnglish(english, kind, id, name) {
	const n = clean(name);
	if (!n) return;
	const m = (english[kind] = english[kind] || new Map());
	const had = m.get(id);
	if (had instanceof Set) had.add(n);
	else m.set(id, new Set(had ? [had, n] : [n]));
}

// ids: usedIds' with extraIds' kinds; ding: readDing's result or null
// (--no-questie); pf: loadPfQuestNames' with enUS among its locales; wago:
// loadClientNames' names ({ [locale]: { item, map, encounter, faction, taxi } })
// or null; wowhead: { [locale]: loadWowheadNames' } or null; english: the
// English names (addEnglish), with pfQuest's enUS and Wowhead's English lists
// beside them. Per id the first source with a name that is no English name
// wins, so any real translation beats a string some source left in English;
// an id whose names are all English gets none (the English shows anyway). A
// name with a placeholder marker is none.
// -> { [locale]: { names: { kind: Map id -> name } (sorted by id),
// english: { kind: Set of the ids whose every name is English },
// from: { kind: { wago, wowhead, ding, pfquest } } } }
function buildNames({ locales = LOCALE_CODES, ids, ding = null, pf = null, wago = null, wowhead = null, english = {} }) {
	const out = {};
	const en = pf && pf.enUS;
	for (const locale of locales) {
		const w = wago && wago[locale];
		const h = wowhead && wowhead[locale];
		const d = ding && ding[locale];
		const p = pf && pf[locale];
		const names = Object.fromEntries(PACK_KINDS.map((k) => [k, new Map()]));
		const englishOnly = Object.fromEntries(PACK_KINDS.map((k) => [k, new Set()]));
		const from = Object.fromEntries(PACK_KINDS.map((k) => [k, Object.fromEntries(SOURCE_KEYS.map((s) => [s, 0]))]));
		for (const kind of PACK_KINDS) {
			let list = ids[kind];
			if (list === undefined) continue;
			// null: every id the client table has (encounters).
			if (list === null) list = w && w[kind] ? w[kind].keys() : [];
			const get = (src, id) => {
				const m = src && src[kind];
				return m ? m.get(id) : undefined;
			};
			const text = kind === 'objective' ? objectiveText : clean;
			for (const id of [...list].sort((a, b) => a - b)) {
				const englishNames = new Set();
				for (const v of [get(english, id), get(en, id), get(h && h.english, id)]) {
					for (const n of v instanceof Set ? v : [v]) if (text(n)) englishNames.add(text(n));
				}
				const candidates = kind === 'objective'
					? [['wowhead', h && h.objective && h.objective.get(id)], ['pfquest', get(p, id)]]
					: [['wago', get(w, id)], ['wowhead', get(h && h.names, id)], ['ding', get(d, id)], ['pfquest', get(p, id)]];
				const named = candidates.map(([s, v]) => [s, text(v)]).filter(([, v]) => usable(v));
				const hit = named.find(([, v]) => !englishNames.has(v));
				if (!hit) {
					if (named.length) englishOnly[kind].add(id);
					continue;
				}
				names[kind].set(id, hit[1]);
				from[kind][hit[0]]++;
			}
		}
		out[locale] = { names, english: englishOnly, from };
	}
	return out;
}

const total = (built) => PACK_KINDS.reduce((n, k) => n + (built.names[k] ? built.names[k].size : 0), 0);

// --- Output -------------------------------------------------------------------

function sourceLabel(sources) {
	const parts = [];
	if (sources.wago) parts.push(`the client's tables (${Object.values(sources.wago.builds).join(', ')}, wago.tools)`);
	if (sources.wowhead) parts.push('Wowhead');
	if (sources.ding) parts.push(`DingDB ${sources.ding.pin.version}`);
	parts.push(`pfQuest${sources.pf && sources.pf.revision ? ` ${sources.pf.revision.slice(0, 7)}` : ''}`);
	return parts.length > 1 ? `${parts.slice(0, -1).join(', ')} and ${parts[parts.length - 1]}` : parts[0];
}

const KIND_WORDS = {
	quest: ['quest', 'quests'], npc: ['NPC', 'NPCs'], object: ['object', 'objects'], item: ['item', 'items'],
	map: ['instance', 'instances'], encounter: ['encounter', 'encounters'], faction: ['faction', 'factions'],
	taxi: ['flight point', 'flight points'], objective: ['quest objective', 'quest objectives'],
};

function licenseText(locale, built, sources) {
	const { language } = LOCALES[locale];
	const counts = (src) => {
		const parts = PACK_KINDS.filter((k) => built.from[k] && built.from[k][src]).map((k) => `${built.from[k][src]} ${KIND_WORDS[k][built.from[k][src] === 1 ? 0 : 1]}`);
		return parts.length ? parts.join(', ') : 'none';
	};
	const out = [
		`Polestar names (${locale}): third-party notices`,
		'='.repeat(`Polestar names (${locale}): third-party notices`.length),
		'',
		`The names in this folder (quests, NPCs, objects, items, instances, dungeon`,
		`encounters, factions, flight points and some quest objectives) are the game's`,
		`texts in ${language}, for Polestar. Names and texts of the game belong to`,
		'Blizzard Entertainment. They come from the sources below, in this order, the',
		'first one with a name for an id winning.',
		'',
	];
	const { wago, wowhead, ding, pf } = sources;
	if (wago) {
		out.push('World of Warcraft client tables, via wago.tools', '-----------------------------------------------');
		const builds = { forever: 'World of Warcraft: Forever (wow_classic_beta)', era: 'Classic Era (wow_classic_era), for the items Forever\'s table lacks' };
		for (const [product, build] of Object.entries(wago.builds)) out.push(`Build: ${build}, ${builds[product] || product}`);
		for (const url of [...wago.urls].sort()) out.push(`Table: ${url.replace('<locale>', locale)}`);
		out.push('The client\'s own strings: names only.', `Names taken: ${counts('wago')}.`, '');
	}
	const wh = wowhead && wowhead[locale];
	if (wh) {
		out.push('Wowhead, World of Warcraft: Forever database', '--------------------------------------------');
		out.push(`URL: https://www.wowhead.com/forever/${require('../codex/wowhead').LOCALE_PATHS[locale]}/ (list pages; tooltips from nether.wowhead.com/forever)`);
		if (wh.fetched) out.push(`Read: ${wh.fetched.first.slice(0, 10)} to ${wh.fetched.last.slice(0, 10)}`);
		out.push('Public web pages; the game\'s names only (facts), credited in THIRD_PARTY.md.', `Names taken: ${counts('wowhead')}.`, '');
	}
	if (ding) {
		out.push('DingDB, the game database of Ding! by Yendi (@moust4ki)', '-------------------------------------------------------');
		out.push(`URL: ${ding.pin.repo}`, `Version: ${ding.pin.version}, commit ${ding.pin.commit}`);
		for (const f of ding.files.filter((x) => x.path === dingFile(locale) || x.path === CREDITS)) out.push(`File: ${f.path} (sha256 ${f.sha256})`);
		out.push(
			'License: GPL-3.0 (Copyright Yendi), used in Polestar with his permission',
			'(THIRD_PARTY.md in the Polestar repository).',
			`Names taken: ${counts('ding')}.`,
			'DingDB\'s base data is generated from Questie and QuestieDB: see CREDITS.md',
			'beside this file.',
			'',
		);
	} else {
		out.push('Built with --no-questie: no names from DingDB (whose base data comes from', 'QuestieDB).', '');
	}
	out.push('pfQuest database by Shagu', '-------------------------');
	out.push(`URL: ${PFQUEST_REPO}`);
	if (pf && pf.revision) out.push(`Revision: ${pf.revision}`);
	out.push(`Files: db/${locale}/{quests,units,objects,items}.lua`, 'License: MIT', `Names taken: ${counts('pfquest')} (the ones the sources above lack).`);
	const notice = pf && pf.dir ? checkLicense(pf.dir).notice : null;
	if (notice) out.push('', notice);
	out.push('');
	return out.join('\n');
}

// One language's addon folder: { file name: text }.
function emitNamesAddon(locale, built, { version = require('../../../package.json').version, iface = null, sources }) {
	const { coreInterface } = require('../dsl/project');
	const { language } = LOCALES[locale];
	const name = `${ADDON_PREFIX}${locale}`;
	const from = sourceLabel(sources);
	const files = {};
	files[`${name}.toc`] = [
		`## Interface: ${iface || coreInterface()}`,
		`## Title: Polestar Names (${locale})`,
		`## Notes: Names of quests, NPCs, objects, items, instances and more in ${language} for Polestar. Loaded on demand on a ${language} client.`,
		...tocLines(name),
		'## Author: Polestar',
		'## X-License: GPL-3.0-only',
		`## Version: ${version}`,
		'## Category: Quests',
		'## LoadOnDemand: 1',
		'## Dependencies: Polestar',
		'',
		'Names.lua',
		'',
	].join('\n');
	const lines = [
		header('lua', 'i18n names', from),
		`-- Names in ${language} (${locale}) for Polestar.Names (addon/Polestar/Core/Names.lua),`,
		'-- by kind. Sources and licences: LICENSE-DATA.txt.',
		'',
		'local add = Polestar and Polestar.Names and Polestar.Names.Add',
		'if not add then return end',
		'',
	];
	for (const kind of PACK_KINDS) {
		const entries = [...(built.names[kind] || [])];
		for (let i = 0; i < entries.length; i += CHUNK) {
			lines.push(`add(${luaString(locale)}, ${luaString(kind)}, {`);
			for (const [id, n] of entries.slice(i, i + CHUNK)) lines.push(`[${id}]=${luaString(n)},`);
			lines.push('})');
		}
	}
	files['Names.lua'] = lines.join('\n') + '\n';
	files['LICENSE-DATA.txt'] = licenseText(locale, built, sources);
	if (sources.ding) files['CREDITS.md'] = fs.readFileSync(path.join(sources.ding.dir, CREDITS), 'utf8');
	return files;
}

// Writes each language with names into addonsDir/Polestar_Names_<locale>
// (files the folder no longer gets are removed) and removes the folder of a
// language left without any. -> [{ locale, dir, bytes }] for those written.
// The ids whose every name is the English one, per locale and kind, merged
// into SAME_AS_ENGLISH (the locales built this run replace theirs).
const SAME_AS_ENGLISH = path.join(ROOT, 'data', 'local', 'names-same-as-english.json');
function writeSameAsEnglish(out, file = SAME_AS_ENGLISH) {
	const doc = readJsonIf(file) || {};
	for (const [locale, built] of Object.entries(out)) {
		doc[locale] = Object.fromEntries(Object.entries(built.english).filter(([, s]) => s.size).map(([k, s]) => [k, [...s].sort((a, b) => a - b)]));
	}
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, `${JSON.stringify(doc)}\n`);
}

function writeNamesAddons(out, addonsDir, { sources, version, iface } = {}) {
	const written = [];
	for (const locale of Object.keys(out).sort()) {
		const dir = path.join(addonsDir, `${ADDON_PREFIX}${locale}`);
		if (total(out[locale]) === 0) {
			fs.rmSync(dir, { recursive: true, force: true });
			continue;
		}
		const files = emitNamesAddon(locale, out[locale], { sources, version, iface });
		fs.mkdirSync(dir, { recursive: true });
		for (const f of fs.readdirSync(dir)) if (!(f in files)) fs.rmSync(path.join(dir, f), { recursive: true, force: true });
		let bytes = 0;
		for (const [f, text] of Object.entries(files)) {
			fs.writeFileSync(path.join(dir, f), text);
			bytes += Buffer.byteLength(text);
		}
		written.push({ locale, dir, bytes, luaBytes: Buffer.byteLength(files['Names.lua']) });
	}
	return written;
}

module.exports = {
	DING, NAME_KINDS, EXTRA_KINDS, PACK_KINDS, SOURCE_KEYS, ADDON_PREFIX, DEFAULTS,
	ensureDing, readDing, usedIds, extraIds, buildNames, addEnglish, clean, emitNamesAddon, writeNamesAddons, writeSameAsEnglish, SAME_AS_ENGLISH, total, sourceLabel,
};
