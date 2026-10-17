'use strict';
// `i18n names`: the names Wowhead's Forever database gives in each client
// language (docs/TRANSLATING.md, "Names"). Its database is the Forever
// client's, so it holds the names of Forever's own quests, NPCs, objects and
// items, which neither DingDB nor pfQuest has.
//
// Builds read what is cached in data/sources/wowhead/:
// - list pages per language: data/sources/wowhead/names/<locale>/lists/<type>.json;
// - the English lists, to tell a translation from a name left in English:
//   data/sources/wowhead/codex/lists for npcs, objects and items,
//   data/sources/wowhead/names/enUS/lists for quests;
// - tooltips for ids no list held: data/sources/wowhead/names/<locale>/<type>/<id>.json.
// A missing cache reads as no names.
//
// Wowhead marks a name it has no translation for with brackets
// ("[Alba Fairmoon]"): those are no names. An unbracketed name equal to the
// English one is the language's own (German keeps many proper names).

const fs = require('node:fs');
const path = require('node:path');

const TYPES = ['quest', 'npc', 'object', 'item'];

const namesDir = (sourcesDir, locale) => path.join(sourcesDir, 'wowhead', 'names', locale);
const localeListFile = (sourcesDir, locale, type) => path.join(namesDir(sourcesDir, locale), 'lists', `${type}.json`);
const tooltipFile = (sourcesDir, locale, type, id) => path.join(namesDir(sourcesDir, locale), type, `${id}.json`);
// The English list: the Codex's, quests our own.
const englishListFile = (sourcesDir, type) => (type === 'quest'
	? localeListFile(sourcesDir, 'enUS', type)
	: path.join(sourcesDir, 'wowhead', 'codex', 'lists', `${type}.json`));

const readJson = (file) => (fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null);

const unhtml = (s) => String(s)
	.replace(/<br\s*\/?>/gi, '\n')
	.replace(/<[^>]*>/g, '')
	.replace(/&#0?39;/g, "'")
	.replace(/&quot;/g, '"')
	.replace(/&nbsp;/g, ' ')
	.replace(/&lt;/g, '<')
	.replace(/&gt;/g, '>')
	.replace(/&amp;/g, '&');

// A name Wowhead has in this language: not empty, not "[English]" (no
// translation), not a "[PH] ..." placeholder.
function realName(name) {
	const s = typeof name === 'string' ? name.trim() : '';
	return s && !/^\[.*\]$/.test(s) && !/^\[PH\]/i.test(s) ? s : null;
}

// A quest tooltip's objective text: the paragraph after the title, before
// the requirements.
function questObjective(tooltip) {
	if (typeof tooltip !== 'string') return null;
	const body = tooltip.replace(/^[\s\S]*?<b class="q">[\s\S]*?<\/b>/, '');
	const text = unhtml(body.split(/<span class="q">/)[0]).split(/\n\s*\n/).map((s) => s.replace(/\s+/g, ' ').trim()).find((s) => s);
	return text || null;
}

// Everything cached for one language: { names: { type: Map id -> name },
// english: { type: Map id -> Wowhead's English name } (the build tells a
// translation from a string left in English by it), listed: { type: Set of
// ids a list row holds, named or not }, objective: Map quest id -> text
// (tooltips), fetched: { first, last } (ISO dates) }.
function loadWowheadNames(sourcesDir, locale) {
	const names = Object.fromEntries(TYPES.map((t) => [t, new Map()]));
	const english = Object.fromEntries(TYPES.map((t) => [t, new Map()]));
	const listed = Object.fromEntries(TYPES.map((t) => [t, new Set()]));
	const objective = new Map();
	const dates = [];
	for (const type of TYPES) {
		const en = readJson(englishListFile(sourcesDir, type));
		for (const c of (en && en.chunks) || []) for (const r of c.rows || []) if (r.name) english[type].set(r.id, String(r.name).trim());
		const take = (id, name) => names[type].set(id, name);
		const list = readJson(localeListFile(sourcesDir, locale, type));
		for (const c of (list && list.chunks) || []) {
			if (c.fetchedAt) dates.push(c.fetchedAt);
			for (const r of c.rows || []) {
				listed[type].add(r.id);
				const n = realName(r.name);
				if (n) take(r.id, n);
			}
		}
		const dir = path.join(namesDir(sourcesDir, locale), type);
		if (!fs.existsSync(dir)) continue;
		for (const f of fs.readdirSync(dir)) {
			if (!f.endsWith('.json')) continue;
			const t = readJson(path.join(dir, f));
			if (!t || t.notFound) continue;
			if (t.fetchedAt) dates.push(t.fetchedAt);
			const n = realName(t.name);
			if (n && !names[type].has(t.id)) take(t.id, n);
			if (type === 'quest' && n) {
				const o = questObjective(t.tooltip);
				if (o) objective.set(t.id, o);
			}
		}
	}
	dates.sort();
	return { names, english, listed, objective, fetched: dates.length ? { first: dates[0], last: dates[dates.length - 1] } : null };
}

module.exports = { loadWowheadNames, localeListFile, tooltipFile, englishListFile };
