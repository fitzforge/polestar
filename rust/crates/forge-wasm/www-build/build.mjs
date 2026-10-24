// The browser planner's page and backend (www/), from the Node planner's page and code:
//   node build.mjs            copy tools/planner/public to www/ with overlay/ over it (api.js answered by
//                             the backend worker; wasm-ui.js, wasm-ui.css added) and bundle backend/backend.js
//                             (tools/planner/workspace.js, commands.js and their tools/lib modules, with
//                             the node: modules the browser lacks shimmed) to www/backend.js.
// The rest of www/ comes from `wasm-pack build` (pkg/), `cargo run --bin bundle` (bundle/) and
// export-assets.js (art/, nav/, glyph/, icon/, fonts/, media/); www/build.sh runs them all.

import { build } from 'esbuild';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, '../../../..');
const www = path.resolve(here, '../www');
const page = path.join(root, 'tools/planner/public');

export async function run({ minify = true } = {}) {
	fs.mkdirSync(www, { recursive: true });
	fs.cpSync(page, www, { recursive: true, filter: (src) => path.relative(page, src) !== 'api.js' });
	for (const f of fs.readdirSync(path.join(here, 'overlay'))) fs.copyFileSync(path.join(here, 'overlay', f), path.join(www, f));
	const index = fs.readFileSync(path.join(page, 'index.html'), 'utf8');
	const add = '<link rel="stylesheet" href="/wasm-ui.css">\n<script type="module" src="/wasm-ui.js"></script>\n</head>';
	if (!index.includes('</head>')) throw new Error('index.html has no </head>');
	fs.writeFileSync(path.join(www, 'index.html'), index.replace('</head>', add));

	const shim = (name) => path.join(here, 'backend/shims', name);
	const node = path.join(here, 'node_modules');
	const map = {
		fs: shim('fs.js'),
		path: path.join(node, 'path-browserify/index.js'),
		crypto: shim('crypto.js'),
		util: shim('util.js'),
		events: path.join(node, 'events/events.js'),
	};
	const result = await build({
		entryPoints: [path.join(here, 'backend/backend.js')],
		outfile: path.join(www, 'backend.js'),
		bundle: true,
		format: 'esm',
		platform: 'browser',
		target: 'es2022',
		minify,
		sourcemap: true,
		metafile: true,
		inject: [shim('process.js')],
		define: { __dirname: '"/repo/tools/lib"', 'process.env.NODE_ENV': '"production"' },
		external: ['./pkg/*'],
		logLevel: 'warning',
		plugins: [{
			name: 'node-shims',
			setup(b) {
				b.onResolve({ filter: /^(node:)?[a-z_]+(\/[a-z]+)?$/ }, (a) => {
					const name = a.path.replace(/^node:/, '');
					if (map[name]) return { path: map[name] };
					if (a.path.startsWith('node:') || ['os', 'zlib', 'http', 'https', 'net', 'child_process', 'worker_threads', 'readline', 'stream', 'url', 'assert', 'perf_hooks', 'v8', 'vm', 'tty', 'dns', 'fs/promises'].includes(name)) return { path: shim('missing.js') };
					return undefined;
				});
			},
		}],
	});
	const out = result.metafile.outputs[path.relative(process.cwd(), path.join(www, 'backend.js'))] || Object.values(result.metafile.outputs).find((o) => o.entryPoint);
	return { www, backendBytes: out ? out.bytes : null, inputs: Object.keys(result.metafile.inputs).length };
}

if (import.meta.url === `file://${process.argv[1]}`) {
	run({ minify: !process.argv.includes('--dev') }).then((r) => console.log(`www: ${r.www}; backend.js ${r.backendBytes} bytes from ${r.inputs} modules`), (e) => {
		console.error(e.message || e);
		process.exit(1);
	});
}
