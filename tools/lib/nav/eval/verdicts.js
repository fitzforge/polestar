'use strict';
// Two `nav eval --out` reports of the same corpus (baseline, candidate) side by side: per route its verdict (pass when
// every expectation passes, FAIL when any fails, n/a otherwise), the flips, and the candidate's failing details.
//
//   node tools/lib/nav/eval/verdicts.js <base.json> <cand.json> [--md]
//
// Prints a markdown table (route, issue, tags, base, cand, the candidate's yards and failing expectations), then
// a count line: "<label>: base P/N pass, cand P/N pass; fixed F, broken B". Routes with no expectations are left out.

const fs = require('node:fs');

const verdict = (r) => {
	const v = r.verdicts || [];
	if (v.some((x) => x.pass === false)) return 'FAIL';
	if (v.some((x) => x.pass === null)) return 'n/a';
	return 'pass';
};

function diff(base, cand) {
	const b = new Map(base.routes.map((r) => [r.id, r]));
	const rows = [];
	for (const r of cand.routes) {
		if (!(r.expect || []).length) continue;
		const br = b.get(r.id);
		const was = br ? verdict(br) : 'absent';
		const now = verdict(r);
		const fails = (r.verdicts || []).filter((x) => x.pass !== true).map((x) => `${x.pass === null ? 'n/a' : 'FAIL'} ${x.detail}`);
		rows.push({ id: r.id, issue: r.issue || '', tags: (r.tags || []).join(' '), was, now, yards: r.result && r.result.ok ? Math.round(r.metrics ? r.metrics.yards : 0) : null, fails });
	}
	return rows;
}

function main(argv) {
	const [a, c] = argv.filter((x) => !x.startsWith('--'));
	const base = JSON.parse(fs.readFileSync(a, 'utf8'));
	const cand = JSON.parse(fs.readFileSync(c, 'utf8'));
	const rows = diff(base, cand);
	const out = ['| route | issue | tags | base | cand | cand yd | cand failing |', '|---|---|---|---|---|---|---|'];
	for (const r of rows) out.push(`| ${r.id} | ${r.issue} | ${r.tags} | ${r.was} | ${r.was !== r.now ? `**${r.now}**` : r.now} | ${r.yards === null ? 'none' : r.yards} | ${r.fails.join('; ').replace(/\|/g, '/')} |`);
	const n = rows.length;
	const bp = rows.filter((r) => r.was === 'pass').length;
	const cp = rows.filter((r) => r.now === 'pass').length;
	const fixed = rows.filter((r) => r.was !== 'pass' && r.now === 'pass').map((r) => r.id);
	const broken = rows.filter((r) => r.was === 'pass' && r.now !== 'pass').map((r) => r.id);
	const uw = rows.filter((r) => r.tags.includes('underworld'));
	out.push('', `base ${bp}/${n} pass, cand ${cp}/${n} pass; fixed ${fixed.length}${fixed.length ? ` (${fixed.join(', ')})` : ''}, broken ${broken.length}${broken.length ? ` (${broken.join(', ')})` : ''}; underworld: base ${uw.filter((r) => r.was === 'pass').length}/${uw.length}, cand ${uw.filter((r) => r.now === 'pass').length}/${uw.length}`);
	const init = (r) => (r.init ? `load ${r.init.loadMs} ms, packed ${r.init.packedKB} KB after loading, Lua KB max during searches ${Math.max(0, ...r.routes.map((x) => (x.result && x.result.kb) || 0))}` : 'n/a');
	out.push(`base harness: ${init(base)}`, `cand harness: ${init(cand)}`);
	console.log(out.join('\n'));
}

if (require.main === module) main(process.argv.slice(2));

module.exports = { diff, verdict };
