'use strict';
// pfQuest (github.com/shagu/pfQuest, MIT, (c) Eric Mauser "Shagu") as a data
// source: locate or shallow-clone the repository, confirm its license, and
// load its vanilla database through Lua 5.1.
//
// Layout (inspected at 104f356, 2026-10): db/init.lua declares pfDB; data
// files assign pfDB[<db>]["data"] (quests, units, objects, items, refloot,
// areatrigger), pfDB["meta"] is assigned whole, and db/enUS/<db>.lua assigns
// pfDB[<db>]["enUS"] (names; quests carry T title, O objective text, D text).
// "-tbc"/"-wotlk" files are other expansions and are not loaded.

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { luaToJson } = require('../lua');

const REPO = 'https://github.com/shagu/pfQuest';
const DATA_FILES = ['quests', 'units', 'objects', 'items', 'refloot', 'areatrigger', 'meta'];
const LOC_FILES = ['quests', 'units', 'objects', 'items'];
const REQUIRED = ['quests', 'units', 'objects', 'items'];

function git(args, cwd) {
	return spawnSync('git', args, { cwd, encoding: 'utf8' });
}

// Clone or update the cache clone. Returns { dir, revision, warnings }.
function ensurePfQuest({ dir, explicit = false, offline = false, log = () => {} }) {
	const warnings = [];
	const exists = fs.existsSync(path.join(dir, 'db'));
	if (!exists) {
		if (explicit) throw new Error(`pfQuest directory ${dir} has no db/ folder`);
		if (offline) throw new Error(`--offline: no cached pfQuest at ${dir} (run once without --offline)`);
		log(`cloning ${REPO} into ${dir}`);
		fs.mkdirSync(path.dirname(dir), { recursive: true });
		const r = git(['clone', '--depth', '1', REPO, dir]);
		if (r.status !== 0) throw new Error(`git clone ${REPO} failed: ${(r.stderr || r.error || '').toString().trim()}`);
	} else if (!explicit && !offline) {
		const r = git(['pull', '--ff-only', '--quiet'], dir);
		if (r.status !== 0) warnings.push(`pfQuest: could not update cache clone (${(r.stderr || '').trim()}); using it as is`);
	}
	// Only a checkout rooted at dir has a revision of its own (a plain folder
	// inside another repository would report that repository's HEAD).
	const top = git(['rev-parse', '--show-toplevel'], dir);
	const rooted = top.status === 0 && fs.realpathSync(top.stdout.trim()) === fs.realpathSync(dir);
	const rev = rooted ? git(['rev-parse', 'HEAD'], dir) : null;
	const revision = rev && rev.status === 0 ? rev.stdout.trim() : null;
	if (!revision) warnings.push(`pfQuest: ${dir} is not a git checkout; revision unknown`);
	return { dir, revision, warnings };
}

// Throws unless the checkout's license is MIT. Returns { license, copyright, notice }.
function checkLicense(dir) {
	const file = ['LICENSE', 'LICENSE.md', 'LICENSE.txt'].map((f) => path.join(dir, f)).find((f) => fs.existsSync(f));
	if (!file) throw new Error(`pfQuest: no LICENSE file in ${dir}; refusing to use it`);
	const notice = fs.readFileSync(file, 'utf8').replace(/\r\n/g, '\n').trim();
	const mit = /^MIT License\b/.test(notice) && /Permission is hereby granted, free of charge/.test(notice) && /THE SOFTWARE IS PROVIDED "AS IS"/.test(notice);
	if (!mit) throw new Error(`pfQuest: ${path.basename(file)} is not the MIT license; refusing to use it`);
	const copyright = (notice.split('\n').find((l) => /^Copyright\b/i.test(l.trim())) || '').trim() || null;
	return { license: 'MIT', copyright, notice };
}

const PRELUDE = `
pfDB = setmetatable({}, { __index = function(t, k) local v = {} rawset(t, k, v) return v end })
`;

// Every id-keyed table comes back as a sorted list of {key, value} pairs so
// that tables whose keys happen to be 1..n are not mistaken for arrays.
const EXPR = `
local function cmp(a, b)
  local ta, tb = type(a), type(b)
  if ta ~= tb then return ta < tb end
  return a < b
end
local function list(t)
  local out = {}
  if type(t) ~= "table" then return out end
  local keys = {}
  for k in pairs(t) do keys[#keys + 1] = k end
  table.sort(keys, cmp)
  for i, k in ipairs(keys) do out[i] = { k, t[k] } end
  return out
end
local function data(name) return rawget(pfDB, name) and pfDB[name].data or {} end
local function loc(name) return rawget(pfDB, name) and pfDB[name].enUS or {} end
local items = {}
for i, p in ipairs(list(data("items"))) do
  local r = type(p[2]) == "table" and p[2] or {}
  items[i] = { p[1], { U = list(r.U), O = list(r.O), V = list(r.V), R = list(r.R) } }
end
local refloot = {}
for i, p in ipairs(list(data("refloot"))) do
  local r = type(p[2]) == "table" and p[2] or {}
  refloot[i] = { p[1], { U = list(r.U), O = list(r.O) } }
end
local meta = {}
for _, p in ipairs(list(rawget(pfDB, "meta") or {})) do
  if type(p[2]) == "table" then meta[#meta + 1] = { p[1], list(p[2]) } end
end
return {
  quests = list(data("quests")), units = list(data("units")), objects = list(data("objects")),
  items = items, refloot = refloot, areatrigger = list(data("areatrigger")), meta = meta,
  loc = { quests = list(loc("quests")), units = list(loc("units")), objects = list(loc("objects")), items = list(loc("items")) },
}
`;

function pairsOf(v) {
	return Array.isArray(v) ? v : [];
}

// -> raw database: { quests: Map, units: Map, objects: Map, items: Map,
//    refloot: Map, areatrigger: Map, meta: Map<category, Map<id, faction>>,
//    loc: { quests, units, objects, items } (Maps) }
function loadPfQuest(dir) {
	const db = path.join(dir, 'db');
	const files = [];
	for (const name of DATA_FILES) {
		const f = path.join(db, `${name}.lua`);
		if (fs.existsSync(f)) files.push(f);
		else if (REQUIRED.includes(name)) throw new Error(`pfQuest: missing ${path.relative(dir, f)}`);
	}
	for (const name of LOC_FILES) {
		const f = path.join(db, 'enUS', `${name}.lua`);
		if (fs.existsSync(f)) files.push(f);
		else throw new Error(`pfQuest: missing ${path.relative(dir, f)}`);
	}
	const raw = luaToJson({ files, prelude: PRELUDE, expr: EXPR });
	const toMap = (list) => new Map(pairsOf(list).map(([k, v]) => [Number(k), v]));
	const items = new Map();
	for (const [id, r] of pairsOf(raw.items)) {
		items.set(Number(id), { U: toMap(r.U), O: toMap(r.O), V: toMap(r.V), R: toMap(r.R) });
	}
	const refloot = new Map();
	for (const [id, r] of pairsOf(raw.refloot)) refloot.set(Number(id), { U: toMap(r.U), O: toMap(r.O) });
	const meta = new Map();
	for (const [cat, list] of pairsOf(raw.meta)) meta.set(String(cat), toMap(list));
	return {
		quests: toMap(raw.quests),
		units: toMap(raw.units),
		objects: toMap(raw.objects),
		items,
		refloot,
		areatrigger: toMap(raw.areatrigger),
		meta,
		loc: {
			quests: toMap(raw.loc.quests),
			units: toMap(raw.loc.units),
			objects: toMap(raw.loc.objects),
			items: toMap(raw.loc.items),
		},
	};
}

// Names in other client languages: db/<locale>/{quests,units,objects,items}.lua
// assign pfDB[<db>][<locale>] (a quest's title is its T, its objective text
// its O). pfQuest has no esMX: a locale without a folder comes back empty.
// -> { [locale]: { quest, npc, object, item, objective: Map id -> text } }
const NAME_FILES = { quest: 'quests', npc: 'units', object: 'objects', item: 'items' };

function loadPfQuestNames(dir, locales) {
	const out = {};
	for (const locale of locales) {
		const byKind = {};
		for (const kind of [...Object.keys(NAME_FILES), 'objective']) byKind[kind] = new Map();
		out[locale] = byKind;
		const folder = path.join(dir, 'db', locale);
		if (!fs.existsSync(folder)) continue;
		const files = Object.values(NAME_FILES).map((f) => path.join(folder, `${f}.lua`)).filter((f) => fs.existsSync(f));
		const kinds = Object.entries(NAME_FILES).map(([k, db]) => `${k} = ${JSON.stringify(db)}`).join(', ');
		const raw = luaToJson({
			files,
			prelude: PRELUDE,
			expr: `
local out = { objective = {} }
for kind, db in pairs({ ${kinds} }) do
  local list = {}
  local t = rawget(pfDB, db) and rawget(pfDB[db], ${JSON.stringify(locale)}) or {}
  for id, v in pairs(t) do
    local name = type(v) == "table" and v.T or v
    if type(id) == "number" and type(name) == "string" then list[#list + 1] = { id, name } end
    if kind == "quest" and type(id) == "number" and type(v) == "table" and type(v.O) == "string" then
      out.objective[#out.objective + 1] = { id, v.O }
    end
  end
  out[kind] = list
end
return out`,
		});
		for (const kind of Object.keys(byKind)) {
			const list = pairsOf(raw[kind]).slice().sort((a, b) => a[0] - b[0]);
			for (const [id, name] of list) byKind[kind].set(Number(id), name);
		}
	}
	return out;
}

module.exports = { REPO, ensurePfQuest, checkLicense, loadPfQuest, loadPfQuestNames };
