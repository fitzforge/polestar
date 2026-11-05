'use strict';
// The Lua program engine-chain.js hands lua5.1, written out for an in-process
// interpreter instead of run (tests/engine_rilua.rs):
//
//   node engine-program.js <out dir> <guides root> <first guide file> <race> <faction> <class> <data dir> [stop|skip]
//
// engine-chain.js runs as is with tests/helpers/lua.js's runAddon swapped for
// one that keeps the program: <out dir>/program.lua, the compiled pack copied
// to <out dir>/pack (the program's paths point there) and <out dir>/files.json
// (the chain's guide files, as engine-chain.js lists them). The program ends
// at its closing emit(...), which becomes RESULT = stub.json(...): the trace
// JSON in a global, nothing printed.

const fs = require('node:fs');
const path = require('node:path');

const WT = path.resolve(__dirname, '../../../../..');
const CHAIN = path.join(__dirname, 'engine-chain.js');
const [outDir, root, first, race, faction, cls, dataDir, mode = 'stop'] = process.argv.slice(2);

const helpers = require(path.join(WT, 'tests/helpers/lua.js'));
let kept = false;
helpers.runAddon = (opts) => {
	const packDir = path.join(outDir, 'pack');
	fs.rmSync(outDir, { recursive: true, force: true });
	fs.mkdirSync(outDir, { recursive: true });
	let program = helpers.buildProgram(opts);
	const tmp = program.match(/"([^"]*polestar-sim-[^"/]+)/)[1];
	fs.cpSync(tmp, packDir, { recursive: true });
	program = program.split(tmp).join(packDir);
	const at = program.lastIndexOf('emit({ trace = TRACE');
	if (at < 0) throw new Error('closing emit not found');
	const close = program.indexOf('\n', at);
	program = `${program.slice(0, at)}RESULT = stub.json(${program.slice(at + 'emit('.length, close < 0 ? undefined : close)}\n`;
	fs.writeFileSync(path.join(outDir, 'program.lua'), program);
	kept = true;
	return { emitted: [{ trace: [], level: 0 }] };
};
const scratch = `${outDir}.chain.json`;
process.argv = [process.argv[0], CHAIN, root, first, race, faction, cls, dataDir, scratch, mode];
require(CHAIN);
if (!kept) throw new Error('engine-chain.js did not run the addon');
fs.writeFileSync(path.join(outDir, 'files.json'), JSON.stringify(JSON.parse(fs.readFileSync(scratch, 'utf8')).files));
fs.rmSync(scratch, { force: true });
