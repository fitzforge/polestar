'use strict';
// node tools/polestar.js data build [options]

const path = require('node:path');
const { parseArgs } = require('node:util');
const { buildData } = require('../lib/data/build');
const { detectQuestie, questieDbDir } = require('../lib/data/questie');

const usage = `usage: node tools/polestar.js data build [options]

Builds data/forever/*.json (quests, npcs, objects, items, zones, map-frames,
factions, meta) from pfQuest (MIT), QuestieDB's Forever store (installed with
Questie for the Forever client; read locally, facts only ship), Blizzard
Classic Era and Forever client tables (wago.tools CSV) and
data/recordings/*.json. Precedence: recordings > questie-forever > pfQuest.
Also spawnz.json: every NPC and object spawn's height on Eastern Kingdoms and
Kalimdor from CMaNGOS classic-db (GPL-3.0, facts), which the compiler gives
goals at an NPC or object; with --offline and no cached dump it is left out
with a warning. Downloads are cached under data/sources/.

options:
  --offline            use cached sources only (no git, no HTTP)
  --pfquest <dir>      use this pfQuest checkout as is (default: cache clone)
  --questie <dir>      QuestieDB folder (or the AddOns folder holding it)
                       (default: auto-detected in the Forever client, as \`install\` finds it)
  --no-questie         build without QuestieDB
  --build <version>    wago.tools Classic Era build (default: newest listed)
  --forever-build <v>  wago.tools Forever build (default: newest 1.60+ wow_classic_beta)
  --no-forever         skip the Forever client tables (zones and frames from Era only)
  --no-web-xp          skip quest XP lookups on wowforevertalents.com / foreverchanges.pro
                       for quests QuestieDB has no XP for (results cached in data/sources/webxp/)
  --no-wowhead         skip Wowhead Forever's change notes (XP, levels) and its XP for quests
                       still without any (the zone lists cached in data/sources/wowhead/,
                       when present)
  --recordings <dir>   recordings folder (default: data/recordings)
  --out <dir>          output folder (default: data/forever)
  --sources <dir>      source cache folder (default: data/sources)
  --cap <n>            max spawn points per entity per map (default 24)
  --built-at <iso>     timestamp for meta.json (default: now, or SOURCE_DATE_EPOCH)`;

async function run(argv) {
	const [sub, ...rest] = argv;
	if (sub !== 'build') {
		console.error(sub ? `unknown subcommand "${sub}"\n\n${usage}` : usage);
		return 2;
	}
	let values;
	try {
		({ values } = parseArgs({
			args: rest,
			options: {
				offline: { type: 'boolean' },
				pfquest: { type: 'string' },
				questie: { type: 'string' },
				'no-questie': { type: 'boolean' },
				build: { type: 'string' },
				'forever-build': { type: 'string' },
				'no-forever': { type: 'boolean' },
				'no-web-xp': { type: 'boolean' },
				'no-wowhead': { type: 'boolean' },
				recordings: { type: 'string' },
				out: { type: 'string' },
				sources: { type: 'string' },
				cap: { type: 'string' },
				'built-at': { type: 'string' },
			},
			strict: true,
		}));
	} catch (err) {
		console.error(`${err.message}\n\n${usage}`);
		return 2;
	}
	const cap = values.cap !== undefined ? Number(values.cap) : undefined;
	if (cap !== undefined && !(Number.isInteger(cap) && cap > 0)) {
		console.error('--cap must be a positive integer');
		return 2;
	}
	const abs = (p) => (p ? path.resolve(p) : undefined);
	let questieDir;
	if (values.questie) {
		questieDir = questieDbDir(abs(values.questie));
		if (!questieDir) {
			console.error(`--questie ${values.questie}: no QuestieDB_Forever.toc there or in its QuestieDB folder`);
			return 2;
		}
	} else if (!values['no-questie']) {
		questieDir = detectQuestie() || undefined;
		console.error(questieDir ? `QuestieDB: ${questieDir}` : 'QuestieDB: not found in a Forever client; building without it (pass --questie <dir>)');
	}
	const { outDir, meta } = await buildData({
		offline: values.offline,
		pfquestDir: abs(values.pfquest),
		questieDir,
		build: values.build,
		forever: !values['no-forever'],
		foreverBuild: values['forever-build'],
		webXp: !values['no-web-xp'],
		wowhead: !values['no-wowhead'],
		recordingsDir: abs(values.recordings),
		outDir: abs(values.out),
		sourcesDir: abs(values.sources),
		cap,
		builtAt: values['built-at'],
		log: (msg) => console.error(msg),
	});
	for (const w of meta.warnings) console.error(`warning: ${w}`);
	const c = meta.counts;
	const total = Object.values(meta.files).reduce((a, b) => a + b, 0);
	console.log(
		`wrote ${path.relative(process.cwd(), outDir) || '.'}: ${c.quests} quests, ${c.npcs} npcs, ${c.objects} objects, ${c.items} items, ` +
			`${c.zones} zones, ${c.mapFrames} map frames, ${c.factions} factions, ${c.recordings} recordings (${(total / 1048576).toFixed(1)} MiB)` +
			(c.questieQuests !== undefined ? `; QuestieDB: ${c.questieQuests} quests (${c.questieOnlyQuests} Forever-only), ${c.questsWithXp} with xp` : ''),
	);
	return 0;
}

module.exports = { name: 'data', summary: 'Build reference data (data/forever/*.json) from pfQuest, QuestieDB, Blizzard map tables and recordings', usage, run };
