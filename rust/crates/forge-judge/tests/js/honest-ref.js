'use strict';
// Parity reference for the Rust honest playtest (src/honest.rs): `playtest --honest` as the CLI runs it on an
// official pack folder (tools/lib/playtest.js playtest({ official: true, honest: true })), the findings as JSON.
// usage: node honest-ref.js <pack dir> <filter|-> <out.json> --data <dir> --kb <file>
const fs = require('node:fs');
const path = require('node:path');
// POLESTAR_HONEST_JS: another JS tree to take the reference from (default: this checkout's).
const ROOT = process.env.POLESTAR_HONEST_JS ? path.resolve(process.env.POLESTAR_HONEST_JS) : path.resolve(__dirname, '../../../../..');
const { playtest } = require(path.join(ROOT, 'tools/lib/playtest'));

const [dir, filter, out] = process.argv.slice(2);
const opt = (k) => {
	const i = process.argv.indexOf(k);
	return i > 0 ? process.argv[i + 1] : null;
};
(async () => {
	const t0 = process.hrtime.bigint();
	const r = await playtest({ dir: path.resolve(dir), manifest: {}, official: true, filter: filter === '-' ? null : filter, honest: true, dataDir: path.resolve(opt('--data')), kb: opt('--kb') ? path.resolve(opt('--kb')) : null });
	const ms = Number(process.hrtime.bigint() - t0) / 1e6;
	if (r.diag.hasErrors()) console.error(r.diag.errors.slice(0, 5));
	const findings = (r.findings || []).map(({ rule, severity, guide, line, step, title, reason, repair, race, cls }) => ({ rule, severity, guide, line, step, title, reason, repair, race, cls }));
	fs.mkdirSync(path.dirname(path.resolve(out)), { recursive: true });
	fs.writeFileSync(out, JSON.stringify({ ms, played: r.played, findings }, null, 1) + '\n');
	console.error(`js honest: ${r.played} guides, ${findings.length} findings, ${ms.toFixed(0)} ms`);
})();
