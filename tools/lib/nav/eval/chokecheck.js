'use strict';
// A Polestar_Nav folder's Nav/Chokepoints.lua checked (chokepoints.js): counts by kind per continent against a
// reference file (today's), the sanity problems (lift pairs, bridge sides, entries off our grid), the curated passages
// players use, and the passages a set of drawn lines (nav eval reports, broad.js runs) pass in the reference file that
// the folder's file lacks.
//
//   node tools/lib/nav/eval/chokecheck.js --nav <Polestar_Nav dir> [--ref <dir or Chokepoints.lua>] [--grid <dir>]
//     [--lines <report.json>,...]
//
// --ref defaults to the repository's addon/Polestar_Nav, --grid to data/local/nav4 (the off-grid check needs it).
// Prints markdown.

const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('../../paths');
const { load, sanity, curated, usedMissing } = require('./chokepoints');

function areaIds() {
	const dir = path.join(ROOT, 'data', 'sources', 'wago');
	if (!fs.existsSync(dir)) return null;
	const builds = fs.readdirSync(dir).filter((b) => fs.existsSync(path.join(dir, b, 'AreaTable.csv'))).sort();
	if (!builds.length) return null;
	const ids = new Set();
	for (const line of fs.readFileSync(path.join(dir, builds[builds.length - 1], 'AreaTable.csv'), 'utf8').split('\n').slice(1)) {
		const id = parseInt(line, 10);
		if (id) ids.add(id);
	}
	return ids;
}

function main(argv) {
	const { parseArgs } = require('../../cli');
	const { opts: o, error } = parseArgs(argv, { flags: [], options: ['--nav', '--ref', '--grid', '--lines'] });
	if (error || !o.nav) throw new Error(error || 'usage: chokecheck.js --nav <dir> [--ref <dir>] [--grid <dir>] [--lines a.json,b.json]');
	const cand = load(path.resolve(o.nav));
	const ref = load(path.resolve(o.ref || path.join(ROOT, 'addon', 'Polestar_Nav')));
	const out = [];
	if (!cand) {
		console.log(`No Nav/Chokepoints.lua in ${o.nav}.`);
		return;
	}
	const gridDir = path.resolve(o.grid || path.join(ROOT, 'data', 'local', 'nav4'));
	const grid = fs.existsSync(path.join(gridDir, 'index.json')) ? require('../path').openNav({ dir: gridDir, cacheTiles: 128 }) : null;
	const s = sanity(cand, { grid, areas: areaIds() });
	const r = ref ? sanity(ref, {}) : { counts: {} };
	const kinds = ['lift', 'gate', 'bridge', 'tunnel', 'cave', 'building', 'pass'];
	const conts = [...new Set([...Object.keys(s.counts), ...Object.keys(r.counts)])].sort((a, b) => a - b);
	out.push('| continent | ' + kinds.join(' | ') + ' | all |', '|---|' + kinds.map(() => '---').join('|') + '|---|');
	for (const c of conts) {
		const cell = (k) => `${(s.counts[c] || {})[k] || 0} (${(r.counts[c] || {})[k] || 0})`;
		const all = (x) => Object.values(x[c] || {}).reduce((a, b) => a + b, 0);
		out.push(`| ${c} | ${kinds.map(cell).join(' | ')} | ${all(s.counts)} (${all(r.counts)}) |`);
	}
	out.push('', 'Counts: the PR (today\'s file in brackets).', '');
	out.push(`Sanity problems: ${s.problems.length}${grid ? '' : ' (no grid: the off-grid check skipped)'}`);
	for (const p of s.problems.slice(0, 40)) out.push(`- ${p}`);
	if (s.problems.length > 40) out.push(`- ... ${s.problems.length - 40} more`);
	out.push('', 'Curated passages players use:', '');
	for (const k of curated(cand)) out.push(`- ${k.found ? 'present' : '**MISSING**'}: ${k.label} (${k.found} entries${k.missing.length ? `; missing lift objects ${k.missing.join(', ')}` : ''})`);
	if (o.lines && ref) {
		const lines = [];
		for (const f of o.lines.split(',')) {
			const doc = JSON.parse(fs.readFileSync(path.resolve(f), 'utf8'));
			for (const rt of doc.routes || []) if (rt.result && rt.result.ok) lines.push({ map: rt.map, pts: rt.result.pts });
			for (const row of doc.rows || []) if (row.ok && row.pts) lines.push({ map: row.map, pts: row.pts });
		}
		const miss = usedMissing(lines, ref, cand);
		out.push('', `Passages today's file names that the PR's ${lines.length} drawn lines pass and its file lacks: ${miss.length}`, '');
		const byKind = {};
		for (const m of miss) byKind[m.cp.kind] = (byKind[m.cp.kind] || 0) + 1;
		out.push(`By kind: ${Object.entries(byKind).map(([k, n]) => `${k} ${n}`).join(', ') || 'none'}`, '');
		for (const m of miss.slice(0, 30)) out.push(`- ${m.cp.kind} "${m.cp.name}"${m.cp.lift ? ` (${m.cp.lift} ${m.cp.liftEnd})` : ''}, ${m.cp.zone}, continent ${m.c} (${m.cp.wx}, ${m.cp.wy}, ${m.cp.z}): ${m.routes} lines`);
	}
	console.log(out.join('\n'));
}

if (require.main === module) {
	try {
		main(process.argv.slice(2));
	} catch (e) {
		console.error(e.message);
		process.exit(1);
	}
}
