// Synthetic world fixtures for the Rust parity test: data sets of tests/fixtures/sim/synthetic.js
// and the JS buildWorld output for both factions (no grid: heights none).
const ROOT = process.env.POLESTAR_JS;
if (!ROOT) {
	console.error('usage: POLESTAR_JS=<checkout whose tools/ and tests/fixtures/sim are the JS reference> node gen-synthetic.js');
	process.exit(2);
}
const fs = require('node:fs');
const path = require('node:path');
const syn = require(ROOT + '/tests/fixtures/sim/synthetic');
const { buildWorld } = require(ROOT + '/tools/lib/sim/world');
const OUT = path.resolve(__dirname, '../fixtures/synthetic');
for (const [set, data, starts] of [['base', syn.makeData(), syn.START], ['rules', syn.makeRulesData(), syn.RULES_START]]) {
	const dir = path.join(OUT, set);
	fs.mkdirSync(dir, { recursive: true });
	for (const [k, v] of Object.entries(data)) fs.writeFileSync(path.join(dir, `${k}.json`), JSON.stringify(v));
	fs.writeFileSync(path.join(dir, 'starts.json'), JSON.stringify(starts));
	for (const faction of ['Horde', 'Alliance']) {
		const w = buildWorld(data, { faction, extraStarts: starts });
		fs.writeFileSync(path.join(dir, `world-${faction.toLowerCase()}.json`), JSON.stringify(w));
	}
}
