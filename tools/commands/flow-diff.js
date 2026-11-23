'use strict';
// flow-diff: what a change does to the leveling route's flow, played through
// the engine on both trees (tools/lib/flowdiff/, docs/ROUTE-FEEL.md "Flow diff").

const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { parseArgs } = require('../lib/cli');
const { parseLevelOffset } = require('../lib/playtest-level');
const { ROOT, DATA, SOURCES } = require('../lib/paths');
const { Proj } = require('../lib/flow/data');
const { measure, compare, narrow, renderMd } = require('../lib/flowdiff/analyse');

const usage = `usage: node tools/polestar.js flow-diff --base <ref> [--head <ref>] [options]

Plays the leveling route on two trees, each with its own compiler, addon and
playtest (the plain playtest's simulated player, one race and class per
guide), and reports what changed in its flow, per guide that plays
differently:

  zone visits     the zones in the order the play walks them, and every NEW
                  revisit: back into a zone the route (that start's default
                  route, across guides) had already left
  one-quest trips a step whose only work is one quest, more than --trip-yd
                  yards (or a zone) from the work before and after it
  carried         each quest's accept guide -> hand-in guide; spans that grew
  travel          minutes walking (the baked legs where both trees have them
                  fresh, else straight lines) and flying
  moved quests    an accept or hand-in in another step: old place -> new place

Prints a markdown table for the pull request body (--md writes it to a file)
and the whole diff as JSON with --out. Exit code 1 when the head adds a
revisit or a one-quest trip that the allow file doesn't name with a reason,
2 on a usage error or a tree that can't be played.

Without --head the working tree is the head (uncommitted edits included).
Both trees play against the same reference data (--data), so only the
guides and the engine differ, unless --base-data gives the base its own: a
release's guides on the data that release shipped with, whose quests the
newer data may have dropped. A play of a guide whose compiled form and
engine didn't change comes from the cache.

options:
  --base <ref>        the tree before the change (e.g. origin/next)
  --head <ref>        the tree after it (default: the working tree)
  --guides <list>     report only guides whose id contains one of these
                      (comma list); the route is played up to them
  --class <c>         the class each guide is played as when the race can be
                      it (default Warrior; a guide's class header wins)
  --skip-quest <ids>  the player skips these quests (Engine.SkipQuest, comma
                      list), as a player whose drop never came would
  --level-offset <n>  play a character n levels ahead of each guide's level
                      (negative: behind), as playtest --level-offset; its plays
                      are cached apart from the plain ones
  --trip-yd <n>       how far a one-quest step must be from its neighbours'
                      work to count as a trip (default 300)
  --allow <file>      accepted new revisits and trips (default the head's
                      data/flow-diff-allow.json)
  --data <dir>        reference data (default data/forever)
  --base-data <dir>   reference data the base plays on (default --data): the
                      release's own when the base is a release tag
  --out <file>        the diff as JSON
  --md <file>         the markdown table (default: printed)
  --work <dir>        where the trees are checked out (default a temp folder,
                      removed afterwards)
  --cache <dir>       plays kept between runs (default <tmp>/polestar-flow-diff-cache)
  --workers <n>       Lua processes per tree (default: the playtest's)`;

const list = (s) => (s ? String(s).split(',').map((x) => x.trim()).filter(Boolean) : []);

function git(args, opts = {}) {
	const r = spawnSync('git', args, { cwd: ROOT, encoding: 'utf8', maxBuffer: 1 << 30, ...opts });
	if (r.status !== 0) throw new Error(`git ${args.join(' ')}: ${(r.stderr || '').trim()}`);
	return r.stdout;
}

// The tree of `ref` checked out (only what the play reads) under `work`, with
// the reference data linked in -> its folder.
function checkout(ref, work, data) {
	const sha = git(['rev-parse', '--verify', `${ref}^{commit}`]).trim();
	const dir = path.join(work, sha.slice(0, 12));
	if (!fs.existsSync(path.join(dir, '.complete'))) {
		fs.rmSync(dir, { recursive: true, force: true });
		fs.mkdirSync(dir, { recursive: true });
		const paths = ['addon/Polestar', 'tools', 'tests/helpers', 'tests/lua', 'guides', 'experimental', 'data'].filter((p) => git(['ls-tree', '--name-only', sha, p]).trim());
		const tar = spawnSync('sh', ['-c', `git archive ${sha} -- ${paths.join(' ')} ':(exclude)guides/locales' | tar -x -C "${dir}"`], { cwd: ROOT, encoding: 'utf8' });
		if (tar.status !== 0) throw new Error(`git archive ${ref}: ${tar.stderr}`);
		fs.writeFileSync(path.join(dir, '.complete'), sha);
	}
	link(dir, data);
	return { dir, sha };
}

// data/forever (and data/sources beside it, which the compiler reads) in a checked-out tree.
function link(dir, data) {
	fs.mkdirSync(path.join(dir, 'data'), { recursive: true });
	for (const [name, target] of [
		['forever', data],
		['sources', fs.existsSync(path.join(data, '..', 'sources')) ? path.join(data, '..', 'sources') : SOURCES],
	]) {
		const at = path.join(dir, 'data', name);
		const st = fs.lstatSync(at, { throwIfNoEntry: false });
		if (st && st.isSymbolicLink()) fs.unlinkSync(at);
		else if (st) continue;
		if (fs.existsSync(target)) fs.symlinkSync(fs.realpathSync(target), at);
	}
}

function play(label, tree, dataDir, opts, work) {
	const out = path.join(work, `${label}.json`);
	const job = path.join(work, `${label}-job.json`);
	fs.writeFileSync(
		job,
		JSON.stringify({
			label,
			tree,
			data: dataDir,
			out,
			guides: opts.guides.length ? opts.guides : null,
			skipQuests: opts.skipQuests,
			cls: opts.cls,
			levelOffset: opts.levelOffset,
			workers: opts.workers,
			cache: opts.cache,
		}),
	);
	const r = spawnSync(process.execPath, [path.join(__dirname, '..', 'lib', 'flowdiff', 'play.js'), job], { stdio: ['ignore', 'inherit', 'inherit'] });
	if (r.status !== 0) throw new Error(`${label}: the play failed (exit ${r.status})`);
	return JSON.parse(fs.readFileSync(out, 'utf8'));
}

function readAllow(file) {
	if (!fs.existsSync(file)) return [];
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	const rows = Array.isArray(doc.allow) ? doc.allow : [];
	for (const r of rows) {
		if (!['revisit', 'trip'].includes(r.kind) || !r.guide || !(r.kind === 'revisit' ? r.zone : r.quest || r.step) || !String(r.reason || '').trim()) {
			throw new Error(`${file}: every row needs kind (revisit or trip), guide, zone (a revisit) or quest or step (a trip) and a reason: ${JSON.stringify(r)}`);
		}
	}
	return rows;
}

// The reference data the numbers read: map frames, zone names, flight masters.
function context(data, tripYd) {
	const read = (f) => JSON.parse(fs.readFileSync(path.join(data, f), 'utf8'));
	const travel = read('travel.json');
	return {
		proj: new Proj(read('map-frames.json')),
		zones: read('zones.json'),
		nodes: new Map(travel.taxi.nodes.map((n) => [n.id, [n.c, n.wx, n.wy, n.map]])),
		tripYd,
	};
}

// Baked legs only where both trees have them fresh for the guide, so a stale
// bake on one side doesn't read as a shorter or longer walk.
function sharedLegs(a, b) {
	const out = {};
	for (const [id, g] of Object.entries(b.guides)) {
		const o = a.guides[id];
		if (g.legs && o && o.legs) out[id] = g.legs;
	}
	return out;
}

async function run(argv) {
	const { opts, error } = parseArgs(argv, { options: ['--base', '--head', '--guides', '--class', '--skip-quest', '--level-offset', '--trip-yd', '--allow', '--data', '--base-data', '--out', '--md', '--work', '--cache', '--workers'] });
	const tripYd = opts.tripYd == null ? 300 : Number(opts.tripYd);
	const workers = opts.workers == null ? null : Number(opts.workers);
	const levelOffset = parseLevelOffset(opts.levelOffset);
	const problem =
		error ||
		(!opts.base && '--base is required') ||
		(!(tripYd > 0) && '--trip-yd must be a positive number') ||
		(workers != null && !(Number.isInteger(workers) && workers > 0) && '--workers must be a positive whole number') ||
		(list(opts.skipQuest).some((q) => !/^\d+$/.test(q)) && '--skip-quest takes quest ids') ||
		levelOffset.error;
	if (problem) {
		console.error(`${problem}\n\n${usage}`);
		return 2;
	}
	const data = path.resolve(opts.data || DATA);
	const baseData = path.resolve(opts.baseData || data);
	for (const d of new Set([data, baseData])) {
		if (!fs.existsSync(path.join(d, 'quests.json'))) {
			console.error(`no reference data in ${d}: run forge data build (or pass --data / --base-data)`);
			return 2;
		}
	}
	const work = opts.work ? path.resolve(opts.work) : fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-flow-diff-'));
	fs.mkdirSync(work, { recursive: true });
	const playOpts = {
		guides: list(opts.guides),
		skipQuests: list(opts.skipQuest).map(Number),
		cls: opts.class ? String(opts.class).toUpperCase() : 'WARRIOR',
		levelOffset,
		workers,
		cache: path.resolve(opts.cache || path.join(os.tmpdir(), 'polestar-flow-diff-cache')),
	};
	try {
		const base = checkout(opts.base, work, baseData);
		const head = opts.head ? checkout(opts.head, work, data) : { dir: ROOT, sha: null };
		const a = play('base', base.dir, path.join(base.dir, 'data', 'forever'), playOpts, work);
		const b = play('head', head.dir, opts.head ? path.join(head.dir, 'data', 'forever') : data, playOpts, work);
		const legs = sharedLegs(a, b);
		const ctx = { ...context(data, tripYd), legs };
		const allow = readAllow(path.resolve(opts.allow || path.join(head.dir, 'data', 'flow-diff-allow.json')));
		const diff = compare(measure(a, ctx), measure(b, ctx), { allow });
		if (playOpts.guides.length) narrow(diff, (id) => playOpts.guides.some((f) => id.includes(f)));
		const names = { base: `${opts.base} (${base.sha.slice(0, 10)})`, head: opts.head ? `${opts.head} (${head.sha.slice(0, 10)})` : 'the working tree' };
		const md = renderMd(diff, names);
		if (opts.out) fs.writeFileSync(opts.out, `${JSON.stringify({ ...names, tripYd, skipQuests: playOpts.skipQuests, cls: playOpts.cls, levelOffset, ...diff }, null, 1)}\n`);
		if (opts.md) fs.writeFileSync(opts.md, `${md}\n`);
		else console.log(md);
		if (diff.blocking) console.error(`flow-diff: ${diff.blocking} new revisit(s) or one-quest trip(s) without a reason in the allow file`);
		return diff.blocking ? 1 : 0;
	} catch (e) {
		console.error(`flow-diff failed: ${e.message}`);
		return 2;
	} finally {
		if (!opts.work) fs.rmSync(work, { recursive: true, force: true });
	}
}

module.exports = { name: 'flow-diff', summary: "What a change does to the leveling route's flow, played on both trees", usage, run, link };
