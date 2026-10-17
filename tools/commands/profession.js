'use strict';
// node tools/polestar.js profession build|draft|gathering ...

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('node:util');

const { ROOT, DATA } = require('../lib/paths');

const usage = `usage: node tools/polestar.js profession build [options]
       node tools/polestar.js profession draft <Profession> [options]
       node tools/polestar.js profession gathering build|check [options]

build: writes data/forever/professions.json from the Forever client's tables
(wago.tools CSV, wow_classic_beta 1.60+: SkillLine, SkillLineAbility,
SpellName, SpellEffect, SpellReagents, SpellTotems, SpellCastingRequirements,
SpellFocusObject, ItemSparse, Item, ItemEffect, ItemXItemEffect; the newest
Classic Era build fills the spells and items they lack) and
data/forever/{items,npcs,objects}.json. Trainers come from a curated name
list checked against npcs.json.

  --offline            use cached tables only
  --build <version>    wago.tools Forever build (default: newest listed)
  --data <dir>         reference data (default data/forever)
  --sources <dir>      source cache (default data/sources)
  --out <file>         default <data>/professions.json

draft: prints (or writes) a 1-300 guide for a crafting profession (Alchemy,
Blacksmithing, Enchanting, Engineering, Leatherworking, Tailoring): the
cheapest sensible recipe chain by expected crafts and material cost, with
trainer visits, recipes to learn, materials to buy or gather, and skill
checkpoints at 75/150/225/300.

  --data <dir>         reference data (default data/forever)
  --out [file]         write the guide (default guides/forever/professions/<name>.guide)
  --quiet              no plan summary on stderr

gathering build: rewrites the six generated guides in guides/forever/professions
(mining, herbalism, skinning, fishing, cooking, first-aid) from their specs in
tools/lib/professions/gathering/specs.js and data/forever (node spawns,
professions, items, npcs, objects). Run \`compile\` afterwards.
gathering check: builds them in memory and exits 1 when a committed guide
differs (writes nothing).

  --data <dir>         reference data (default data/forever)
  --stdout             print the guides instead of writing them (build only)`;

function fail(msg) {
	console.error(`${msg}\n\n${usage}`);
	return 2;
}

async function runBuild(rest) {
	let values;
	try {
		({ values } = parseArgs({
			args: rest,
			options: { offline: { type: 'boolean' }, build: { type: 'string' }, data: { type: 'string' }, sources: { type: 'string' }, out: { type: 'string' } },
			strict: true,
		}));
	} catch (err) {
		return fail(err.message);
	}
	const { buildProfessions } = require('../lib/professions/build');
	const abs = (p) => (p ? path.resolve(p) : undefined);
	const res = await buildProfessions({
		offline: values.offline,
		build: values.build,
		dataDir: abs(values.data),
		sourcesDir: abs(values.sources),
		outFile: abs(values.out),
		log: (m) => console.error(m),
	});
	for (const w of res.warnings) console.error(`warning: ${w}`);
	const lines = Object.values(res.report).map((r) => {
		const skipped = Object.entries(r.skipped).map(([k, n]) => `${n} ${k}`).join(', ');
		return `  ${r.name.padEnd(15)} ${String(r.recipes).padStart(4)} recipes${skipped ? ` (left out: ${skipped})` : ''}`;
	});
	const era = res.eraBuild ? ` (gaps filled from Classic Era ${res.eraBuild})` : '';
	console.log(`wrote ${path.relative(process.cwd(), res.outFile) || res.outFile} from Forever build ${res.build}${era}:\n${lines.join('\n')}`);
	return 0;
}

function loadJson(dir, name) {
	const file = path.join(dir, `${name}.json`);
	if (!fs.existsSync(file)) throw new Error(`${path.relative(process.cwd(), file)} missing (node tools/polestar.js ${name === 'professions' ? 'profession build' : 'data build'})`);
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

async function runDraft(rest) {
	let values;
	let positionals;
	// `--out` may come with or without a file name.
	const args = rest.slice();
	const outAt = args.indexOf('--out');
	let outDefault = false;
	if (outAt >= 0 && (outAt === args.length - 1 || args[outAt + 1].startsWith('--'))) {
		args.splice(outAt, 1);
		outDefault = true;
	}
	try {
		({ values, positionals } = parseArgs({
			args,
			options: { data: { type: 'string' }, out: { type: 'string' }, quiet: { type: 'boolean' } },
			allowPositionals: true,
			strict: true,
		}));
	} catch (err) {
		return fail(err.message);
	}
	if (positionals.length !== 1) return fail('draft needs one profession name');
	const { draftGuide } = require('../lib/professions/guide');
	const dataDir = path.resolve(values.data || DATA);
	const data = {
		professions: loadJson(dataDir, 'professions'),
		npcs: loadJson(dataDir, 'npcs'),
		objects: loadJson(dataDir, 'objects'),
		zones: loadJson(dataDir, 'zones'),
		items: loadJson(dataDir, 'items'),
		quests: loadJson(dataDir, 'quests'),
		mapFrames: loadJson(dataDir, 'map-frames'),
	};
	// Where the compiler can place `collect <item> nearest`: the same farm spots
	// it compiles (tools/lib/dsl/farmspots.js), so a drafted step never fails
	// lint for want of a qualifying dropper. -> { Alliance, Horde }: the lowest
	// mob level among the spots that side may use, or null when there is none.
	const { loadData } = require('../lib/dsl/data');
	const { farmSpots } = require('../lib/dsl/farmspots');
	const compiled = loadData(dataDir);
	const lowest = (list) => (list.length ? Math.min(...list.map((s) => s.lvl.min)) : null);
	data.farmable = (item) => {
		const spots = farmSpots(compiled, item);
		return {
			Alliance: lowest(spots.filter((s) => s.faction === 'A' || s.faction === 'AH')),
			Horde: lowest(spots.filter((s) => s.faction === 'H' || s.faction === 'AH')),
		};
	};
	const { text, plan } = draftGuide(positionals[0], data);
	if (!values.quiet) {
		console.error(`${plan.profession.name}: ${plan.segments.length} segments, about ${(plan.total / 10000).toFixed(1)}g of materials (heuristic)`);
		for (const s of plan.segments) console.error(`  ${String(s.from).padStart(3)}-${String(s.to).padEnd(3)} ${s.recipe.name} x${s.count}`);
	}
	const out = outDefault ? path.join(ROOT, 'guides', 'forever', 'professions', `${plan.profession.name.toLowerCase()}.guide`) : values.out ? path.resolve(values.out) : null;
	if (out) {
		fs.mkdirSync(path.dirname(out), { recursive: true });
		fs.writeFileSync(out, text);
		if (!values.quiet) console.error(`wrote ${path.relative(process.cwd(), out)}`);
	} else {
		process.stdout.write(text);
	}
	return 0;
}

function runGathering(rest) {
	let values;
	let positionals;
	try {
		({ values, positionals } = parseArgs({ args: rest, options: { data: { type: 'string' }, stdout: { type: 'boolean' } }, allowPositionals: true, strict: true }));
	} catch (err) {
		return fail(err.message);
	}
	const [mode, ...extra] = positionals;
	if (mode !== 'build' && mode !== 'check') return fail(mode ? `unknown gathering subcommand "${mode}"` : 'gathering needs build or check');
	if (extra.length) return fail(`unexpected argument "${extra[0]}"`);
	if (values.stdout && mode === 'check') return fail('--stdout goes with gathering build');
	const { buildAll, OUT_DIR } = require('../lib/professions/gathering/build');
	const { context } = require('../lib/professions/gathering/common');
	const files = buildAll(context(values.data ? path.resolve(values.data) : undefined));
	if (values.stdout) {
		for (const [name, text] of Object.entries(files)) process.stdout.write(`==> ${name}\n${text}\n`);
		return 0;
	}
	const { reportSync } = require('../lib/generated');
	return reportSync(files, OUT_DIR, { check: mode === 'check', command: 'profession gathering build' });
}

async function run(argv) {
	const [sub, ...rest] = argv;
	if (sub === 'build') return runBuild(rest);
	if (sub === 'draft') return runDraft(rest);
	if (sub === 'gathering') return runGathering(rest);
	return fail(sub ? `unknown subcommand "${sub}"` : 'missing subcommand');
}

module.exports = { name: 'profession', summary: 'Build professions.json; draft a crafting guide; build or check the generated gathering guides', usage, run };
