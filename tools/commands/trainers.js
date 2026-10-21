'use strict';
// trainers build: data/forever/trainers.json, the class trainers `train class`
// chooses from (see tools/lib/dsl/trainers.js for the sources), and
// addon/Polestar/Core/ClassTrainers.lua, the same trainers placed on the map
// (one per town and class) for the Engine's class-training reminder, plus
// every trainer's id by class for Engine.IsClassTrainer.
// trainers spells: addon/Polestar/Core/ClassSpells.lua alone, the spells a
// class trainer teaches and their levels (tools/lib/dsl/classspells.js), from
// the client tables of the build the reference data pins (fetched from
// wago.tools when not cached).

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs, resolvePath } = require('../lib/cli');
const { ROOT } = require('../lib/paths');
const { loadData } = require('../lib/dsl/data');
const { buildTrainers } = require('../lib/dsl/trainers');
const { buildCandidates } = require('../lib/dsl/candidates');
const { emitClassTrainers } = require('../lib/dsl/emit');
const { buildClassSpells, emitClassSpells } = require('../lib/dsl/classspells');
const { cachedTable } = require('../lib/data/wago');
const { SOURCES } = require('../lib/paths');

const usage = `usage: node tools/polestar.js trainers build [options]
       node tools/polestar.js trainers spells [--data <dir>] [--spells <file>] [--offline]

Builds data/forever/trainers.json, the class trainers \`train class\` picks from:
every \`train <npcId> only <Class>\` goal under guides/, recorded trainer visits
in data/recordings (by the recording character's class), and Polestar's curated
list of capital and starting-town trainers, each verified by name and map
against npcs.json. Without the file, compile uses the curated list alone.
Also writes addon/Polestar/Core/ClassTrainers.lua: one trainer per town and
class, with positions and map frames, for the class-training reminder, and
every class trainer's npc id by class, for Engine.IsClassTrainer.

\`trainers spells\` writes addon/Polestar/Core/ClassSpells.lua alone: the spells
each class learns at a trainer and their levels, from the Forever client tables
of the build data/forever pins (SkillLineAbility, SkillLine, SpellLevels,
SpellName; fetched from wago.tools into data/sources/wago/<build>/ when not
cached).

options:
  --guides <dir>      guide sources (default guides/)
  --data <dir>        reference data, also the output folder (default data/forever/)
  --recordings <dir>  normalized recordings (default data/recordings/)
  --out <file>        output file (default <data>/trainers.json)
  --lua <file>        Lua output (default addon/Polestar/Core/ClassTrainers.lua)
  --spells <file>     class spells output (default addon/Polestar/Core/ClassSpells.lua)
  --offline           use only cached client tables`;

function writeAtomic(file, text) {
	fs.mkdirSync(path.dirname(file), { recursive: true });
	const tmp = `${file}.tmp-${process.pid}`;
	fs.writeFileSync(tmp, text);
	fs.renameSync(tmp, file);
}

// The reminder's trainers (one per town and class, both factions) with their
// frames, and every class trainer's id by class for Engine.IsClassTrainer.
function classTrainersLua(data, trainers) {
	const entries = Object.values(trainers).map((t) => ({ npc: t.id, classes: t.classes }));
	const { candidates } = buildCandidates(data, entries, { sides: ['Alliance', 'Horde'], ref: null });
	const frames = {};
	for (const c of candidates) {
		const fr = data.eraFrame(c.map);
		if (fr) frames[c.map] = { c: fr.c, left: fr.left, right: fr.right, top: fr.top, bottom: fr.bottom };
	}
	const sorted = candidates.slice().sort((a, b) => a.npc - b.npc || a.map - b.map);
	const byClass = {};
	for (const t of Object.values(trainers)) for (const cls of t.classes) (byClass[cls] ||= []).push(t.id);
	for (const ids of Object.values(byClass)) ids.sort((a, b) => a - b);
	return { lua: emitClassTrainers(sorted, frames, byClass), count: sorted.length, ids: Object.keys(trainers).length };
}

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { flags: ['--offline'], options: ['--guides', '--data', '--recordings', '--out', '--lua', '--spells'] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	if (error || positional.length !== 1 || !['build', 'spells'].includes(positional[0])) {
		console.error(`${error || 'expected `trainers build` or `trainers spells`'}\n\n${usage}`);
		return 2;
	}
	const dataDir = resolvePath(opts.data, 'data/forever', ROOT);
	if (!fs.existsSync(path.join(dataDir, 'npcs.json'))) {
		console.error(`no npcs.json in ${dataDir} (run \`node tools/polestar.js data build\` first)`);
		return 1;
	}
	const data = loadData(dataDir);
	if (positional[0] === 'spells') return writeClassSpells(data, opts);
	const { trainers, report } = buildTrainers({
		data,
		guidesDir: resolvePath(opts.guides, 'guides', ROOT),
		recordingsDir: resolvePath(opts.recordings, 'data/recordings', ROOT),
	});
	const out = opts.out ? path.resolve(opts.out) : path.join(dataDir, 'trainers.json');
	writeAtomic(out, `${JSON.stringify(trainers, null, '\t')}\n`);
	for (const [cls, name, map] of report.unverified) console.warn(`warning: curated ${cls} trainer "${name}" not found on map ${map} in npcs.json; skipped`);
	console.log(
		`wrote ${out}: ${Object.keys(trainers).length} class trainers (curated ${report.curated}, from guides ${report.guide} goals, from recordings ${report.record} npcs)`,
	);
	const luaFile = opts.lua ? path.resolve(opts.lua) : path.join(ROOT, 'addon', 'Polestar', 'Core', 'ClassTrainers.lua');
	const { lua, count, ids } = classTrainersLua(data, trainers);
	writeAtomic(luaFile, lua);
	console.log(`wrote ${luaFile}: ${count} trainer positions, ${ids} class trainer ids`);
	return 0;
}

async function writeClassSpells(data, opts) {
	const build = pinnedBuild(data);
	if (!build) {
		console.error('no Forever client build pinned in meta.json (run `node tools/polestar.js data build` first)');
		return 1;
	}
	const tables = {};
	for (const table of SPELL_TABLES) {
		tables[table] = await cachedTable({
			sourcesDir: SOURCES, build, table, offline: !!opts.offline,
			get: async (url) => {
				const res = await fetch(url, { headers: { 'user-agent': 'polestar-data-build' } });
				if (!res.ok) throw new Error(`GET ${url}: HTTP ${res.status}`);
				return res.text();
			},
			log: (m) => console.log(m),
		});
	}
	const byClass = buildClassSpells(tables);
	const spellsFile = opts.spells ? path.resolve(opts.spells) : path.join(ROOT, 'addon', 'Polestar', 'Core', 'ClassSpells.lua');
	writeAtomic(spellsFile, emitClassSpells(byClass, build));
	const total = Object.values(byClass).reduce((n, l) => n + l.length, 0);
	console.log(`wrote ${spellsFile}: ${total} trainer spells over ${Object.keys(byClass).length} classes (client build ${build})`);
	return 0;
}

const SPELL_TABLES = ['SkillLineAbility', 'SkillLine', 'SpellLevels', 'SpellName'];

// The Forever client build the reference data was built from (meta.json).
function pinnedBuild(data) {
	const src = ((data.meta && data.meta.sources) || []).find((x) => x && /^World of Warcraft: Forever client tables/.test(String(x.name)));
	const m = src && /(\d+\.\d+\.\d+\.\d+)/.exec(String(src.revision || ''));
	return m ? m[1] : null;
}

module.exports = { name: 'trainers', summary: 'Build trainers.json and Core/ClassTrainers.lua (class trainers); `spells`: Core/ClassSpells.lua (trainer spells)', usage, run };
