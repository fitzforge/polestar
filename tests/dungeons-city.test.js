'use strict';
// City dungeons belong to their own faction (Fitz, #2026): the Alliance never gets Ragefire Chasm (in
// Orgrimmar) or the Ruins of Lordaeron (the Undercity's ruins), the Horde never The Hall of Thanes (in
// Ironforge) or the Stockade (in Stormwind). The addon reads one rule for it (Engine.EnemyCityDungeon); these
// cases hold the route's data to it: no run, pick-up or hand-in of data/dungeon-runs.json and no `when dungeon`
// step of a leveling guide gives a faction the other's city dungeon. With data/forever, the Codex journal is
// swept for any other dungeon whose way in lies inside a capital.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs, DATA } = require('./helpers/data');
const { runAddon } = require('./helpers/lua');

const ROOT = path.join(__dirname, '..');
// names (the guides' and the journal's) -> { map: the instance's Map id, side: whose city it is }
const CITY = [
	{ names: ['Ragefire Chasm'], map: 389, side: 'Horde' },
	{ names: ['Ruins of Lordaeron'], map: 2999, side: 'Horde' },
	{ names: ['The Hall of Thanes'], map: 3065, side: 'Alliance' },
	{ names: ['The Stockade', 'Stormwind Stockade'], map: 34, side: 'Alliance' },
];
// The capitals' world map ids and whose they are.
const CAPITALS = { 1453: 'Alliance', 1455: 'Alliance', 1457: 'Alliance', 1454: 'Horde', 1456: 'Horde', 1458: 'Horde' };

const key = (s) => String(s).trim().toLowerCase().replace(/^the\s+/, '');
const cityOf = (name) => CITY.find((c) => c.names.some((n) => key(n) === key(name)));
const enemy = (name, faction) => {
	const c = cityOf(name);
	return Boolean(c && c.side !== faction);
};

test("the addon's rule is the one these cases check: each side's enemy city dungeons by instance map", () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		login: true,
		script: `local E, out = Polestar.Engine, {}
for _, map in ipairs({ ${CITY.map((c) => c.map).join(', ')}, 36, 43 }) do
	out[tostring(map)] = { A = E.EnemyCityDungeon(map, "A") and true or false, H = E.EnemyCityDungeon(map, "H") and true or false }
end
emit(out)`,
	}).emitted;
	const want = { 36: { A: false, H: false }, 43: { A: false, H: false } };
	for (const c of CITY) want[c.map] = { A: c.side === 'Horde', H: c.side === 'Alliance' };
	assert.deepEqual(out, want);
});

test('data/dungeon-runs.json gives no faction a run, pick-up or hand-in in the other faction\'s city dungeon', () => {
	const file = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'dungeon-runs.json'), 'utf8'));
	const bad = [];
	for (const run of file.runs) {
		assert.ok(run.faction === 'Alliance' || run.faction === 'Horde', `${run.dungeon}: a run is one faction's (${run.faction})`);
		if (enemy(run.dungeon, run.faction)) bad.push(`${run.faction}: a run of ${run.dungeon}`);
		const dir = `forever/${run.faction.toLowerCase()}/`;
		const guides = [run.run.guide, ...(run.pickups || []).map((p) => (p.after && p.after.guide) || p.guide), ...(run.handins || []).map((h) => h.guide)];
		for (const g of guides) if (!g.startsWith(dir)) bad.push(`${run.faction}: ${run.dungeon} has a step in ${g}`);
	}
	assert.deepEqual(bad, []);
});

test("no leveling guide has a `when dungeon` step for its faction's enemy city dungeon", () => {
	const guides = path.join(ROOT, 'guides', 'forever');
	const walk = (dir) => fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(dir, e.name)) : e.name.endsWith('.guide') ? [path.join(dir, e.name)] : []));
	const bad = [];
	for (const file of walk(guides)) {
		const text = fs.readFileSync(file, 'utf8');
		const rel = path.relative(guides, file).split(path.sep).join('/');
		const faction = rel.startsWith('alliance/') ? 'Alliance' : rel.startsWith('horde/') ? 'Horde' : (/^faction\s+(Alliance|Horde)\s*$/m.exec(text) || [])[1];
		for (const m of text.matchAll(/^\s*when dungeon "([^"]+)"/gm)) {
			if (!faction ? cityOf(m[1]) : enemy(m[1], faction)) bad.push(`${rel}: ${m[1]}`);
		}
	}
	assert.deepEqual(bad, []);
});

test('the Codex journal: every dungeon whose way in lies inside a capital is a city dungeon of that capital\'s side', { skip: needs('codex/journal.json') }, () => {
	const { dungeons } = JSON.parse(fs.readFileSync(path.join(DATA, 'codex', 'journal.json'), 'utf8'));
	const list = Array.isArray(dungeons) ? dungeons : Object.entries(dungeons).map(([k, d]) => ({ key: k, ...d }));
	const inCapital = list.filter((d) => d.kind !== 'raid' && d.entrance && CAPITALS[d.entrance.map]);
	assert.ok(inCapital.length >= 3, 'the journal has the capitals\' dungeons');
	for (const d of inCapital) {
		const c = CITY.find((x) => x.map === d.map);
		assert.ok(c, `${d.name}: its way in is inside a capital (map ${d.entrance.map}), so it is a city dungeon`);
		assert.equal(c.side, CAPITALS[d.entrance.map], `${d.name}: the city is the ${CAPITALS[d.entrance.map]}'s`);
	}
	for (const c of CITY) {
		const d = list.find((x) => x.map === c.map);
		assert.ok(d && c.names.some((n) => key(n) === key(d.name)), `${c.names[0]} is the journal's map ${c.map}`);
	}
});
