'use strict';
// The names packs' sources beside DingDB and pfQuest (`i18n names`): what is
// cached of Wowhead's Forever database in each language
// (tools/lib/i18n/names-wowhead.js: list pages and tooltips, bracketed names
// dropped), the client's tables, and which source wins an id
// (tools/lib/i18n/names.js buildNames).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const wh = require('../tools/lib/i18n/names-wowhead');
const { LOCALE_PATHS } = require('../tools/lib/codex/wowhead');
const names = require('../tools/lib/i18n/names');
const { LOCALE_CODES } = require('../tools/lib/i18n/locales');

const T0 = '2026-10-16T00:00:00.000Z';
const T1 = '2026-10-17T00:00:00.000Z';

const writeJson = (file, value) => {
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, JSON.stringify(value));
};

test('every client language has its Wowhead path (the names packs\' credit)', () => {
	assert.deepEqual(Object.keys(LOCALE_PATHS).sort(), [...LOCALE_CODES].sort());
});

test('cached Wowhead lists: each language\'s rows, the English list\'s names beside them; a bracketed name is none', () => {
	const sourcesDir = tmpdir('polestar-names-wh-');
	writeJson(wh.englishListFile(sourcesDir, 'npc'), { type: 'npc', chunks: [{ lo: 0, hi: 200, rows: [{ id: 5, name: 'Npc 5 ' }, { id: 7, name: 'Npc 7' }] }] });
	writeJson(wh.localeListFile(sourcesDir, 'ruRU', 'npc'), { type: 'npc', chunks: [
		{ lo: 0, hi: 100, fetchedAt: T1, rows: [{ id: 5, name: 'Нпс 5' }, { id: 7, name: '[Npc 7]' }] },
		{ lo: 100, hi: 200, fetchedAt: T0, rows: [{ id: 150, name: 'Нпс 150' }, { id: 151, name: '[PH] Нпс' }] },
	] });
	const ru = wh.loadWowheadNames(sourcesDir, 'ruRU');
	assert.deepEqual([...ru.names.npc], [[5, 'Нпс 5'], [150, 'Нпс 150']], 'the bracketed [Npc 7] and the [PH] placeholder are no names');
	assert.ok(ru.listed.npc.has(7), 'but they are listed');
	assert.deepEqual([...ru.english.npc], [[5, 'Npc 5'], [7, 'Npc 7']]);
	assert.deepEqual(ru.fetched, { first: T0, last: T1 });
});

test('cached Wowhead tooltips: a name no list gave, a 404 none, a quest\'s objective line read', () => {
	const sourcesDir = tmpdir('polestar-names-tip-');
	writeJson(wh.localeListFile(sourcesDir, 'ruRU', 'npc'), { type: 'npc', chunks: [{ lo: 0, hi: 300, fetchedAt: T0, rows: [{ id: 250, name: 'Список 250' }] }] });
	writeJson(wh.tooltipFile(sourcesDir, 'ruRU', 'npc', 250), { id: 250, name: 'Tip 250', fetchedAt: T0 });
	writeJson(wh.tooltipFile(sourcesDir, 'ruRU', 'npc', 251), { id: 251, name: 'Tip 251', fetchedAt: T1 });
	writeJson(wh.tooltipFile(sourcesDir, 'ruRU', 'npc', 404), { id: 404, notFound: true, fetchedAt: T1 });
	writeJson(wh.tooltipFile(sourcesDir, 'ruRU', 'quest', 92742), {
		id: 92742, name: 'Задание', fetchedAt: T0,
		tooltip: '<table><tr><td><b class="q">Задание</b><br />Убейте всех в лагере.<br /><br /><span class="q">Requirements:</span></td></tr></table>',
	});
	const ru = wh.loadWowheadNames(sourcesDir, 'ruRU');
	assert.equal(ru.names.npc.get(250), 'Список 250', 'the list row first');
	assert.equal(ru.names.npc.get(251), 'Tip 251');
	assert.equal(ru.names.npc.has(404), false);
	assert.equal(ru.names.quest.get(92742), 'Задание');
	assert.equal(ru.objective.get(92742), 'Убейте всех в лагере.');
	assert.deepEqual(ru.fetched, { first: T0, last: T1 });
});

test('no Wowhead cache: no names, nothing read', () => {
	const de = wh.loadWowheadNames(tmpdir('polestar-names-none-'), 'deDE');
	assert.deepEqual([de.names.npc.size, de.listed.quest.size, de.objective.size, de.fetched], [0, 0, 0, null]);
});

test('per id the client\'s tables win, then Wowhead, then DingDB, then pfQuest; the extra kinds come from the client\'s tables', () => {
	const m = (o) => new Map(Object.entries(o).map(([k, v]) => [Number(k), v]));
	const ids = {
		quest: new Set([1, 2]), npc: new Set([1, 2, 3, 4]), object: new Set(), item: new Set([10, 11]),
		map: new Set([36]), encounter: null, faction: new Set([72]), taxi: new Set([2]), objective: new Set([1, 2]),
	};
	const wago = { ruRU: { item: m({ 10: 'Клиент 10' }), map: m({ 36: 'Мертвые копи', 999: 'x' }), encounter: m({ 230: 'Событие' }), faction: m({ 72: 'Штормград' }), taxi: m({ 2: 'Штормград, Элвиннский лес' }) } };
	const wowhead = { ruRU: { names: { quest: m({ 2: 'Вовхед 2' }), npc: m({ 1: 'Вовхед 1' }), object: m({}), item: m({ 10: 'Вовхед 10', 11: 'Вовхед 11' }) }, objective: m({ 2: 'Цель Вовхеда' }) } };
	const ding = { ruRU: { quest: m({ 1: 'Динг 1' }), npc: m({ 1: 'Динг 1', 2: 'Динг 2' }), object: m({}), item: m({}) } };
	const pf = {
		ruRU: { quest: m({}), npc: m({ 3: 'Пф 3', 4: 'Same' }), object: m({}), item: m({}), objective: m({ 1: 'Убить$Bвсех', 2: 'Пф цель' }) },
		enUS: { quest: m({}), npc: m({ 4: 'Same' }), object: m({}), item: m({}), objective: m({ 1: 'Kill all' }) },
	};
	const out = names.buildNames({ locales: ['ruRU'], ids, ding, pf, wago, wowhead }).ruRU;
	const obj = (k) => Object.fromEntries(out.names[k]);
	assert.deepEqual(obj('item'), { 10: 'Клиент 10', 11: 'Вовхед 11' }, 'the client table first, Wowhead for the rest');
	assert.deepEqual(obj('npc'), { 1: 'Вовхед 1', 2: 'Динг 2', 3: 'Пф 3' }, 'Wowhead before DingDB; a pfQuest name equal to its English one is none');
	assert.deepEqual(obj('quest'), { 1: 'Динг 1', 2: 'Вовхед 2' });
	assert.deepEqual(obj('objective'), { 1: 'Убить всех', 2: 'Цель Вовхеда' }, 'pfQuest\'s $B is a space; Wowhead first');
	assert.deepEqual([obj('map'), obj('encounter'), obj('faction'), obj('taxi')], [{ 36: 'Мертвые копи' }, { 230: 'Событие' }, { 72: 'Штормград' }, { 2: 'Штормград, Элвиннский лес' }],
		'only the ids Polestar names; every encounter');
	assert.deepEqual(out.from.npc, { wago: 0, wowhead: 1, ding: 1, pfquest: 1 });
	assert.deepEqual(out.from.item, { wago: 1, wowhead: 1, ding: 0, pfquest: 0 });
});

test('the extra ids: instance maps, factions, flight points, lift objects and the dungeon quests with an event objective', () => {
	const dir = tmpdir('polestar-names-extra-');
	const codex = path.join(dir, 'codex');
	fs.mkdirSync(codex);
	fs.writeFileSync(path.join(codex, 'instances.json'), JSON.stringify({ deadmines: { map: 36 }, brd: { map: 230 } }));
	fs.writeFileSync(path.join(codex, 'factions.json'), JSON.stringify({ 72: { id: 72 }, 76: { id: 76 } }));
	fs.writeFileSync(path.join(codex, 'quests.json'), JSON.stringify({
		155: { objectives: [{ type: 'event', id: 78, text: 'Escort' }] },
		166: { objectives: [{ type: 'monster', id: 639 }] },
		200: { objectives: [{ type: 'event', id: 1 }] },
	}));
	fs.writeFileSync(path.join(codex, 'journal.json'), JSON.stringify({ dungeons: { deadmines: { bosses: [{ quests: [{ id: 155 }, { id: 166 }] }] } } }));
	const travel = path.join(dir, 'TravelData.lua');
	fs.writeFileSync(travel, 'local ADDON, ns = ...\nlocal N = ns.Nav\nN.RegisterTravelData({ taxi = { {2,0,1,2,1453,1,2,1,"Stormwind"}, {4,0,1,2,1436,1,2,1,"Sentinel Hill"} } })\nN.RegisterCrossings({})\n');
	const chokepoints = path.join(dir, 'Chokepoints.lua');
	fs.writeFileSync(chokepoints, '{ kind = "lift", liftObject = 4170 },\n{ kind = "lift", liftObject = 20649 },\n');
	const extra = names.extraIds({ codex, travel, chokepoints });
	const sorted = (s) => [...s].sort((a, b) => a - b);
	assert.deepEqual([sorted(extra.map), sorted(extra.faction), sorted(extra.taxi), sorted(extra.liftObject), sorted(extra.objective)],
		[[36, 230], [72, 76], [2, 4], [4170, 20649], [155]]);
	assert.equal(extra.encounter, null, 'every encounter the client has');
	assert.deepEqual(sorted(names.extraIds({ codex: path.join(dir, 'none'), travel: path.join(dir, 'none.lua'), chokepoints }).map), [], 'missing inputs leave a kind empty');
});

test('a name some source left in English never beats a translation, whichever source has it; an id named only in English gets none', () => {
	const m = (o) => new Map(Object.entries(o).map(([k, v]) => [Number(k), v]));
	const ids = { quest: new Set(), npc: new Set([1, 2, 3, 4]), object: new Set(), item: new Set([10]) };
	const english = {};
	for (const [id, n] of [[1, 'Dolanaar Sentinel'], [2, 'Hogger'], [3, 'Grund Drokda'], [4, 'Alba Fairmoon']]) names.addEnglish(english, 'npc', id, n);
	names.addEnglish(english, 'item', 10, 'Squirrel Nut');
	const wago = { zhCN: { item: m({ 10: 'Squirrel Nut' }) } };
	const wowhead = { zhCN: { names: { npc: m({ 1: 'Dolanaar Sentinel', 4: '阿尔巴·晴月' }) } } };
	const ding = { zhCN: { npc: m({ 1: '泰达希尔卫兵', 2: 'Hogger', 3: 'Grund Drokda' }), item: m({}) } };
	const pf = { zhCN: { npc: m({ 2: '霍格' }), item: m({ 10: '松鼠坚果' }) }, enUS: { npc: m({}), item: m({}) } };
	const out = names.buildNames({ locales: ['zhCN'], ids, ding, pf, wago, wowhead, english }).zhCN;
	assert.deepEqual(Object.fromEntries(out.names.npc), { 1: '泰达希尔卫兵', 2: '霍格', 4: '阿尔巴·晴月' }, 'Wowhead\'s and DingDB\'s English give way to the next translation');
	assert.deepEqual(Object.fromEntries(out.names.item), { 10: '松鼠坚果' }, 'the client table\'s English too');
	assert.deepEqual([...out.english.npc], [3], 'named only in English: nothing stored, the English shows');
});

test('names are written with one space for every run of white space, line breaks too; placeholder and test names are none', () => {
	assert.equal(names.clean('  Avis de\n recherche\t:  "Lardeur" '), 'Avis de recherche : "Lardeur"');
	const m = (o) => new Map(Object.entries(o).map(([k, v]) => [Number(k), v]));
	const ids = { quest: new Set(), npc: new Set(), object: new Set(), item: new Set([1, 2, 3, 4, 5, 6, 7]), objective: new Set([9]) };
	const pf = {
		frFR: {
			item: m({ 1: '[PH] Épée', 2: 'Épée [PÉRIMÉ]', 3: 'Bâton (DNT)', 4: '<NYI> Bottes', 5: 'Hache\nde  guerre', 6: '[INUTILISÉ] Anneau', 7: 'Bouclier (test)' }),
			objective: m({ 9: 'Tuez$Bles kobolds.' }),
		},
		enUS: { item: m({}), objective: m({}) },
	};
	const out = names.buildNames({ locales: ['frFR'], ids, pf }).frFR;
	assert.deepEqual(Object.fromEntries(out.names.item), { 5: 'Hache de guerre' });
	assert.equal(out.names.objective.get(9), 'Tuez les kobolds.');
});

test('the client tables come from a build holding every table in English and every language asked; none stops the build', async () => {
	const { loadClientNames } = require('../tools/lib/i18n/names-wago');
	const sourcesDir = tmpdir('polestar-names-wago-');
	const csv = (rows, field) => `ID,${field}\n${rows.map(([id, n]) => `${id},${n}`).join('\n')}\n`;
	const TABLES = { ItemSparse: 'Display_lang', Map: 'MapName_lang', DungeonEncounter: 'Name_lang', Faction: 'Name_lang', TaxiNodes: 'Name_lang' };
	const write = (build, locale, tables, names_) => {
		for (const t of tables) {
			const dir = path.join(sourcesDir, 'wago', build, ...(locale ? [locale] : []));
			fs.mkdirSync(dir, { recursive: true });
			fs.writeFileSync(path.join(dir, `${t}.csv`), csv([[1, names_[t] || `${t} ${locale || 'en'}`]], TABLES[t]));
		}
	};
	const all = Object.keys(TABLES);
	// 1.60.1.2 is newer but lacks ruRU's TaxiNodes: 1.60.1.1 is the one read.
	for (const l of [null, 'ruRU']) write('1.60.1.1', l, all, {});
	write('1.60.1.2', null, all, {});
	write('1.60.1.2', 'ruRU', all.filter((t) => t !== 'TaxiNodes'), {});
	for (const l of [null, 'ruRU']) write('1.15.9.1', l, ['ItemSparse'], { ItemSparse: l ? 'Эра' : 'Era' });
	const got = await loadClientNames({ sourcesDir, locales: ['ruRU'], offline: true });
	assert.deepEqual(got.builds, { forever: '1.60.1.1', era: '1.15.9.1' });
	assert.equal(got.names.ruRU.taxi.get(1), 'TaxiNodes ruRU');
	assert.equal(got.english.map.get(1), 'Map en');
	await assert.rejects(loadClientNames({ sourcesDir, locales: ['deDE'], offline: true }), /no forever client tables/);
});
