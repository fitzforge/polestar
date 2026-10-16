'use strict';
// node tools/polestar.js names build [options]

const path = require('node:path');
const { parseArgs } = require('node:util');

// One locale file is loaded on demand into a client of that language: keep it small.
const SIZE_BUDGET = 256 * 1024;

const usage = `usage: node tools/polestar.js names build [options]

Writes the load-on-demand data addon addon/Polestar_Names: the names of the
NPCs and objects Polestar's guides name (the compiled guides and class
trainers), in each language the game client has, one <locale>.lua per
language; a client loads only its own. From QuestieDB's Forever store (its
localization blocks, read from the installed copy; facts only), then pfQuest's
locale databases (MIT). A name equal to the English is left out; an NPC
renamed for Forever keeps its English. Size budget: ${SIZE_BUDGET / 1024} KiB per locale.

  --questie <dir>      QuestieDB folder (or the AddOns folder holding it; default: detected)
  --no-questie         build without QuestieDB
  --pfquest <dir>      pfQuest checkout (default data/sources/pfQuest, as \`data build\` caches it)
  --out <dir>          default addon/Polestar_Names`;

function fail(msg) {
	console.error(`${msg}\n\n${usage}`);
	return 2;
}

async function runBuild(rest) {
	let values;
	try {
		({ values } = parseArgs({
			args: rest,
			options: { questie: { type: 'string' }, 'no-questie': { type: 'boolean' }, pfquest: { type: 'string' }, out: { type: 'string' } },
			strict: true,
		}));
	} catch (err) {
		return fail(err.message);
	}
	const fs = require('node:fs');
	const { detectQuestie, questieDbDir } = require('../lib/data/questie');
	const { SOURCES } = require('../lib/paths');
	const { buildNames } = require('../lib/names/build');
	const abs = (p) => (p ? path.resolve(p) : undefined);
	let questieDir;
	if (values.questie) {
		questieDir = questieDbDir(abs(values.questie));
		if (!questieDir) return fail(`--questie ${values.questie}: no QuestieDB_Forever.toc there or in its QuestieDB folder`);
	} else if (!values['no-questie']) {
		questieDir = detectQuestie() || undefined;
		console.error(questieDir ? `QuestieDB: ${questieDir}` : 'QuestieDB: not found in a Forever client; building without it (pass --questie <dir>)');
	}
	const pfquestDir = abs(values.pfquest) || path.join(SOURCES, 'pfQuest');
	if (!fs.existsSync(path.join(pfquestDir, 'db'))) return fail(`pfQuest: no db/ folder in ${pfquestDir} (run \`data build\` once, or pass --pfquest <dir>)`);
	let res;
	try {
		res = buildNames({ questieDir, pfquestDir, outDir: abs(values.out), log: (m) => console.error(m) });
	} catch (err) {
		console.error(`error: ${err.message}`);
		return 1;
	}
	let over = 0;
	for (const [locale, s] of Object.entries(res.locales)) {
		const kib = (s.bytes / 1024).toFixed(0);
		console.log(`${locale}: ${s.npc} NPCs, ${s.object} objects (${s.questie} from QuestieDB, ${s.pfquest} from pfQuest; ${s.renamed} renamed for Forever kept English), ${kib} KiB`);
		if (s.bytes > SIZE_BUDGET) {
			console.error(`error: ${locale}.lua is ${kib} KiB, over the ${SIZE_BUDGET / 1024} KiB budget`);
			over++;
		}
	}
	console.log(`wrote ${path.relative(process.cwd(), res.outDir) || res.outDir} for ${res.used.npc} NPCs and ${res.used.object} objects`);
	return over ? 1 : 0;
}

async function run(argv) {
	const [sub, ...rest] = argv;
	if (sub === 'build') return runBuild(rest);
	return fail(sub ? `unknown subcommand "${sub}"` : 'missing subcommand');
}

module.exports = { name: 'names', summary: "Build the Polestar_Names data addon (NPC and object names in the client's language)", usage, run, SIZE_BUDGET };
