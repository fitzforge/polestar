'use strict';
// `node tools/polestar.js studio`: the Feature Studio. Renders scripted
// scenarios (tools/studio/scenarios) with the real addons to PNG/SVG, serves
// them on a local page that re-renders when the addon's Lua changes, and
// manages the local client art cache. See tools/studio/studio.js.

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('../lib/cli');

const usage = [
	'usage: node tools/polestar.js studio [scenario[/shot] ...] [options]',
	'       node tools/polestar.js studio list',
	'       node tools/polestar.js studio art [status | pull <fileID|atlas|path> ... | import <dir> ...]',
	'',
	'Renders each shot of the scenarios named (all when none) with the real',
	'addons, the stub client and the local client art: <out>/<scenario>-<shot>.svg,',
	'.png and -closeup.png (the shot\'s frames at 2x; PNGs need rsvg-convert).',
	'',
	'  --checkout <dir>  render that checkout\'s addon (another branch\'s worktree)',
	'                    and its tests/lua stubs; the studio itself is this one',
	'  --out <dir>       where renders go (default data/local/studio, gitignored:',
	'                    renders with client art hold Blizzard art)',
	'  --world <image>   a 1920x1080 still behind the UI (your own screenshot), not',
	'                    plain dark',
	'  --offline         no download: client art and tables from the cache only',
	'  --locale <code>   render in that client language (deDE, ruRU, koKR, zhCN...):',
	'                    its language folder loads as the client loads it; files',
	'                    are <scenario>-<shot>-<code>.*. CJK and Hangul measure',
	'                    1em (the preview faces have no such glyphs)',
	'  --fit             list the text the shot\'s frames cut or let cross their',
	'                    edges (the i18n fit audit; CJK and Hangul 1em)',
	'  --serve           the studio page on http://127.0.0.1:<port>: pick a shot, it',
	'                    re-renders when the addon or a scenario changes',
	'  --port <n>        the page\'s port (default 4848)',
	'',
	'The art cache ($POLESTAR_STUDIO_ART, else ~/.cache/polestar-art) holds client',
	'textures, atlases, fonts and tables for local renders only; `studio art import`',
	'merges an older cache (tools/preview\'s POLESTAR_CLIENT_ART folder, a FRIZQT__.TTF).',
].join('\n');

function resolveCheckout(dir) {
	const root = path.resolve(dir);
	const addon = fs.existsSync(path.join(root, 'addon', 'Polestar')) ? path.join(root, 'addon') : fs.existsSync(path.join(root, 'Polestar')) ? root : null;
	if (!addon) throw new Error(`--checkout ${dir}: no addon/Polestar there`);
	return { root: addon === root ? path.dirname(root) : root, addon };
}

async function artCommand(args) {
	const art = require('../studio/art');
	const [sub = 'status', ...rest] = args;
	if (sub === 'status') {
		const s = art.status();
		console.log(`${s.dir}\n  ${s.textures} textures, ${s.atlases} atlases, ${s.files} interface files, ${s.maps} maps, fonts: ${s.fonts.join(', ') || 'none'}`);
		return 0;
	}
	if (sub === 'pull') {
		const r = await art.pull(rest);
		console.log(`${r.got.length} in the cache${r.missing.length ? `; not found: ${r.missing.join(', ')}` : ''}`);
		return r.missing.length ? 1 : 0;
	}
	if (sub === 'import') {
		for (const d of rest) {
			const r = art.importDir(path.resolve(d));
			console.log(`${d}: ${r.textures} textures, ${r.fonts} fonts${r.lists.length ? `, ${r.lists.join(', ')}` : ''}`);
		}
		return 0;
	}
	console.error(usage);
	return 2;
}

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { flags: ['--offline', '--serve', '--fit'], options: ['--checkout', '--out', '--world', '--port', '--locale'] });
	if (error) {
		console.error(`${error}\n\n${usage}`);
		return 2;
	}
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	if (positional[0] === 'art') return artCommand(positional.slice(1));
	let stubsDir = null;
	if (opts.checkout) {
		const c = resolveCheckout(opts.checkout);
		// tests/helpers/lua reads POLESTAR_ADDON_DIR when first loaded, which
		// tools/polestar.js has done by now (other commands load it): run
		// again in a child process that starts with it set.
		if (path.resolve(process.env.POLESTAR_ADDON_DIR || '') !== c.addon) {
			const { spawnSync } = require('node:child_process');
			const r = spawnSync(process.execPath, [path.join(__dirname, '..', 'polestar.js'), 'studio', ...argv], {
				stdio: 'inherit', env: { ...process.env, POLESTAR_ADDON_DIR: c.addon },
			});
			return r.status ?? 1;
		}
		stubsDir = path.join(c.root, 'tests', 'lua');
	}
	const studio = require('../studio/studio');
	if (positional[0] === 'list') {
		for (const name of studio.listScenarios()) {
			const sc = studio.loadScenario(name);
			console.log(`${name}: ${sc.title}`);
			for (const [k, shot] of Object.entries(sc.shots)) console.log(`  ${name}/${k}: ${shot.title || ''}`);
		}
		return 0;
	}
	if (opts.locale !== undefined) {
		const { checkLocale } = require('../lib/i18n/locales');
		try {
			if (opts.locale !== 'enUS') checkLocale(opts.locale);
		} catch (err) {
			console.error(err.message);
			return 2;
		}
	}
	const run = { outDir: path.resolve(opts.out || studio.DEFAULT_OUT), world: opts.world ? path.resolve(opts.world) : null, offline: !!opts.offline, stubsDir, locale: opts.locale || null, fit: !!opts.fit };
	if (opts.serve) {
		const port = opts.port === undefined ? 4848 : Number(opts.port);
		if (!Number.isInteger(port) || port < 0 || port > 65535) {
			console.error('--port needs a port number');
			return 2;
		}
		const { serve } = require('../studio/server');
		const s = await serve({ ...run, port, only: positional });
		console.log(`Polestar studio: ${s.url}  (renders in ${path.relative(process.cwd(), run.outDir) || '.'}; Ctrl-C to stop)`);
		await new Promise((resolve) => {
			process.once('SIGINT', resolve);
			process.once('SIGTERM', resolve);
		});
		s.close();
		return 0;
	}
	const wanted = positional.length ? positional : studio.listScenarios();
	let failed = 0;
	for (const want of wanted) {
		const [name, shotName] = want.split('/');
		let sc;
		try {
			sc = studio.loadScenario(name);
		} catch (err) {
			console.error(err.message);
			return 2;
		}
		for (const shot of shotName ? [shotName] : Object.keys(sc.shots)) {
			try {
				const r = await studio.runShot(sc, shot, { ...run, log: (m) => console.error(`  ${m}`) });
				for (const f of [r.closeup, r.png || r.svg]) if (f) console.log(path.relative(process.cwd(), f));
				// What the shot's script returned (a check's answer), when anything.
				if (r.result !== undefined && r.result !== null && r.result !== true) console.log(`  ${name}/${shot}: ${JSON.stringify(r.result)}`);
				for (const f of r.fit || []) console.log(`  ${name}/${shot}: fit: ${f}`);
				if (r.errors.length) failed++;
			} catch (err) {
				console.error(err.message);
				failed++;
			}
		}
	}
	return failed ? 1 : 0;
}

module.exports = { name: 'studio', summary: 'Render scripted scenarios of the real addon to PNG (the Feature Studio), live on a local page', usage, run };
