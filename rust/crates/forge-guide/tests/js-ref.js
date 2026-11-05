'use strict';
// Parity reference for the Rust compiler: runs this worktree's JS compiler (tools/lib) on a guides folder
// with our pack.json and writes what `compile` would write (even when there are errors, so a guide with
// one stale-data error still gives bytes to compare) plus the lint diagnostics as `--format json`.
// usage: node rust/crates/forge-guide/tests/js-ref.js <guides dir> <out dir> [--data <dir>]
const fs = require('node:fs');
const path = require('node:path');
const ROOT = path.resolve(__dirname, '../../../..');
const { commandPack } = require(path.join(ROOT, 'tools/lib/pack/locate'));
const { compileProject, buildPackFiles } = require(path.join(ROOT, 'tools/lib/dsl/project'));
const { packTranslations } = require(path.join(ROOT, 'tools/lib/i18n/guides'));
const { formatDiagnostics } = require(path.join(ROOT, 'tools/lib/dsl/diag'));

const [guidesDir, outDir] = process.argv.slice(2);
const di = process.argv.indexOf('--data');
const dataDir = di > 0 ? path.resolve(process.argv[di + 1]) : path.join(ROOT, 'data/forever');
const pack = commandPack({ guides: guidesDir });
const t0 = process.hrtime.bigint();
const r = compileProject({ packDir: pack.dir, manifest: pack.manifest, dataDir });
const t1 = process.hrtime.bigint();
const { translations, warnings } = packTranslations(pack.dir, pack.manifest, r.guides);
for (const w of warnings) r.diag.warn(w.file, 0, w.message);
const files = buildPackFiles({ guides: r.guides, manifest: pack.manifest, data: r.data, translations, retired: r.retired });
const t2 = process.hrtime.bigint();
fs.rmSync(outDir, { recursive: true, force: true });
const pkg = path.join(outDir, 'pack');
for (const [name, content] of Object.entries(files)) {
	const file = path.join(pkg, name);
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, content);
}
fs.writeFileSync(path.join(outDir, 'diagnostics.json'), formatDiagnostics(r.diag.sorted(), 'json') + '\n');
console.error(`js: compile ${Number(t1 - t0) / 1e6} ms, emit ${Number(t2 - t1) / 1e6} ms, ${r.guides.length} guides, ${r.diag.list.length} diagnostics`);
