'use strict';
// Running the command line from tests: polestar() runs it as a child process,
// quiet() runs a command module in-process with its console output captured,
// and fakeAddons() lays out addon folders for pack and install tests.

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { TOC_MARKER } = require('../../tools/lib/pack/format');

const ROOT = path.join(__dirname, '..', '..');
const CLI = path.join(ROOT, 'tools', 'polestar.js');

// polestar(['lint', ...], { cwd, env, input }) -> spawnSync's result, text
// output. `env` adds to (or, with undefined, removes from) the test's own.
function polestar(args, { cwd = ROOT, env = {}, input } = {}) {
	const full = { ...process.env, ...env };
	for (const k of Object.keys(full)) if (full[k] === undefined) delete full[k];
	return spawnSync(process.execPath, [CLI, ...args], { cwd, env: full, input, encoding: 'utf8' });
}

// The forge binary the guide commands moved to: $FORGE, else this checkout's
// release build (rust/target/release/forge), else null (the test skips: forge
// is not built here).
function forgeBin() {
	if (process.env.FORGE) return process.env.FORGE;
	const built = path.join(ROOT, 'rust', 'target', 'release', process.platform === 'win32' ? 'forge.exe' : 'forge');
	return fs.existsSync(built) ? built : null;
}

// forge(['guide', 'lint', ...], { cwd }) -> spawnSync's result, or null without a forge binary.
function forge(args, { cwd = ROOT } = {}) {
	const bin = forgeBin();
	return bin ? spawnSync(bin, args, { cwd, encoding: 'utf8' }) : null;
}

// Run fn with console output captured; returns { result, out }.
async function quiet(fn) {
	const out = [];
	const saved = { log: console.log, warn: console.warn, error: console.error };
	console.log = console.warn = console.error = (...a) => out.push(a.join(' '));
	try {
		const result = await fn();
		return { result, out: out.join('\n') };
	} finally {
		Object.assign(console, saved);
	}
}

// Minimal addon folders with TOCs, for pack/install tests; Polestar_Guides is
// a generated pack (its TOC carries the marker) without guides.
function fakeAddons(root, names = ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_Recorder'], version = '0.1.0') {
	for (const n of names) {
		const dir = path.join(root, n);
		fs.mkdirSync(dir, { recursive: true });
		const files = n === 'Polestar_Guides' ? `${TOC_MARKER}\n\nPack.lua\nMapFrames.lua\nGuides.lua` : '\nMain.lua';
		fs.writeFileSync(path.join(dir, `${n}.toc`), `## Interface: 16001\n## Title: ${n}\n## Version: ${version}\n${files}\n`);
		if (n !== 'Polestar_Guides') fs.writeFileSync(path.join(dir, 'Main.lua'), `local ADDON, ns = ...\n-- ${n}\n`);
		// A release-safe Codex as `forge release pack` checks it (forge-release addons.rs codex_refusal).
		if (n === 'Polestar_Codex') {
			fs.writeFileSync(path.join(dir, 'Meta.lua'), 'C.Register("meta", {\n\tlocalExtras = false,\n\tsources = {\n\t\t{\n\t\t\tname = "pfQuest",\n\t\t},\n\t},\n})\n');
			fs.writeFileSync(path.join(dir, 'LICENSE-DATA.txt'), 'Polestar Codex: third-party notices\n');
		}
		fs.writeFileSync(path.join(dir, '.hidden'), 'not shipped\n');
	}
	return root;
}

module.exports = { CLI, polestar, forge, forgeBin, quiet, fakeAddons };
