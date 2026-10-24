'use strict';
// find: look up quests, NPCs, objects, items, inns, flight points and our guides as guide lines.

const { parseArgs, resolvePath } = require('../lib/cli');
const { ROOT } = require('../lib/paths');
const { loadData } = require('../lib/dsl/data');
const { RACES, CLASSES, raceLabel, classLabel } = require('../lib/game/races');
const { find, loadGuideHeaders, KINDS, LISTED, FACTIONS } = require('../lib/find');

// The names --race and --class take.
const RACE_NAMES = [...new Set(Object.values(RACES).map((r) => raceLabel(r.file)))];
const CLASS_NAMES = Object.values(CLASSES).map((c) => classLabel(c.file));

// The reference files find searches (inns and flight points: travel.json).
const SEARCHED = ['quests.json', 'npcs.json', 'objects.json', 'items.json', 'zones.json'];
const PLACES = ['travel.json', 'zones.json'];

const usage = `usage: node tools/polestar.js find <text> [options]

Searches the reference data (quests, NPCs, objects, items, inns and flight
points) and our guides. A number matches ids exactly; other text matches
names (and a guide's id and zone, an inn's or flight point's zone), ignoring
case. Each result prints as a guide line ready to paste, with what it is in
a comment. A quest also prints its turn-in line and its objectives (the
\`quest <id>.<n>\` of an objective goal); a guide prints who it is for and
the guide its own \`next\` offers; an inn prints the name \`sethome\` and
\`hearth\` take, a flight point the one \`getfp\` and \`fly\` take:

  accept 7  # Kobold Camp Cleanup, level 2: Marshal McBride, Elwynn Forest 48.9,41.6
  turnin 7  # Kobold Camp Cleanup: Marshal McBride, Elwynn Forest 48.9,41.6
  # 7.1 = kill Kobold Vermin x10
  sethome "Goldshire"  # Innkeeper Farley (npc 295), Elwynn Forest 43.8,65.8
  getfp "Sentinel Hill"  # Sentinel Hill, Westfall, Alliance: Thor (npc 523), Westfall 56.6,52.7
  next forever/alliance/02-westfall  # Westfall (12-17), Alliance
  # its next: forever/alliance/03-darkshore

\`find --kind inn\` and \`find --kind flight\` without a text list them all.
Exit code 1 when nothing matches.

options:
  --kind <k>       only ${KINDS.join(', ')}
  --faction <f>    only what ${FACTIONS.join(' or ')} can use (quests by race,
                   NPCs and inns by who they are friendly to, flight points
                   by their side, guides by faction)
  --race <r>       only what this race can use (${RACE_NAMES.join(', ')}):
                   quests by race, NPCs, inns and flight points by side,
                   guides by faction and race
  --class <c>      only what this class can use: quests and guides by class
  --limit <n>      at most n results (default 20; a full list of inns or
                   flight points: all)
  --json           print the results as a JSON array: every result has kind,
                   id, name and line; quests level, zone, x, y, starts, ends,
                   turnin and objectives; guides levels, zone, faction,
                   races, classes and next; inns (id: the innkeeper) names,
                   npc, npcName, zone, map, x, y; flight points node (the
                   full name), faction, npc, npcName, zone, map, x, y
  --data <dir>     reference data (default data/forever/)
  --guides <dir>   our guides (default guides/)`;

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { flags: ['--json'], options: ['--kind', '--faction', '--race', '--class', '--limit', '--data', '--guides'] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const faction = opts.faction ? FACTIONS.find((f) => f.toLowerCase() === opts.faction.toLowerCase()) : null;
	const race = opts.race ? (RACES[opts.race.toLowerCase().replace(/\s+/g, '')] || {}).file || null : null;
	const cls = opts.class ? (CLASSES[opts.class.toLowerCase()] || {}).file || null : null;
	const listed = LISTED.includes(opts.kind);
	// A full list of inns or flight points is not cut short.
	const limit = opts.limit === undefined ? (listed && !positional.length ? Infinity : 20) : Number(opts.limit);
	const problem =
		error ||
		(!positional.length && !listed && 'nothing to find') ||
		(opts.kind && !KINDS.includes(opts.kind) && `--kind must be one of ${KINDS.join(', ')}`) ||
		(opts.faction && !faction && `--faction must be ${FACTIONS.join(' or ')}`) ||
		(opts.race && !race && `--race must be one of ${RACE_NAMES.join(', ')}`) ||
		(opts.class && !cls && `--class must be one of ${CLASS_NAMES.join(', ')}`) ||
		(opts.limit !== undefined && !(Number.isInteger(limit) && limit > 0) && '--limit must be a whole number above 0');
	if (problem) {
		console.error(`${problem}\n\n${usage}`);
		return 2;
	}
	const dataDir = resolvePath(opts.data, 'data/forever', ROOT);
	const data = loadData(dataDir);
	// Without the files it searches every search would come back empty: say
	// so, not "nothing matches".
	const missing = opts.kind === 'guide' ? [] : data.missing.filter((f) => (listed ? PLACES : SEARCHED).includes(f));
	if (missing.length) {
		const build = missing.includes('travel.json') && missing.length === 1 ? 'forge data travel' : 'forge data build';
		console.error(`find: the reference data in ${dataDir} is missing ${missing.join(', ')}; run ${build} (or pass --data)`);
		return 1;
	}
	const guides = opts.kind && opts.kind !== 'guide' ? [] : loadGuideHeaders(resolvePath(opts.guides, 'guides', ROOT));
	const results = find(data, guides, { text: positional.join(' '), kind: opts.kind || null, faction, race, cls, limit });
	if (opts.json) {
		console.log(JSON.stringify(results, null, '\t'));
		return results.length ? 0 : 1;
	}
	for (const r of results) {
		console.log(r.line);
		if (r.turnin) console.log(r.turnin);
		for (const note of r.notes || []) console.log(note);
	}
	if (!results.length) console.error(`nothing matches "${positional.join(' ')}"`);
	return results.length ? 0 : 1;
}

module.exports = { name: 'find', summary: 'Look up quests, NPCs, objects, items, inns, flight points and guides as guide lines', usage, run };
