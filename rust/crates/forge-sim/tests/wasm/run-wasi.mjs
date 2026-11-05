// Runs target/wasm32-wasip1/release/sim-hash.wasm under node's WASI with the sim dir, the seeds and
// the checkout's data/ (route-fixes.json) preopened: node run-wasi.mjs <wasm> <sim dir> <seed dir> <seed file> [args...]
import { readFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { WASI } from 'node:wasi';
const [wasmFile, simDir, seedDir, seedFile, ...rest] = process.argv.slice(2);
const dataDir = fileURLToPath(new URL('../../../../../data', import.meta.url));
const wasi = new WASI({
	version: 'preview1',
	args: ['sim-hash', '/sim', `/seeds/${seedFile}`, ...rest],
	env: { POLESTAR_ROUTE_FIXES: '/data/route-fixes.json' },
	preopens: { '/sim': simDir, '/seeds': seedDir, '/data': dataDir },
});
const mod = await WebAssembly.compile(await readFile(wasmFile));
const inst = await WebAssembly.instantiate(mod, wasi.getImportObject());
wasi.start(inst);
