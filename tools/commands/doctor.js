'use strict';
// doctor: checks what the toolchain needs, one line per check;
// each failing check prints its fix for Windows, macOS and Linux.

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { parseArgs } = require('../lib/cli');
const { format } = require('../lib/dsl/diag');
const { DATA } = require('../lib/paths');
const { findLua } = require('../lib/lua');
const { detectAddonsDirs, pickAddonsDir, isDir } = require('../lib/addons');
const { findPackDir, resolvePack, packArgument } = require('../lib/pack/locate');

const usage = `usage: node tools/polestar.js doctor [<dir> | --pack <dir>]

Checks what the Polestar tools need, one line per check (\`ok\` or \`fix\`,
with the fix for Windows, macOS and Linux):
  node      Node 24 or newer (every command)
  lua       a Lua 5.1 interpreter: lua5.1, LuaJIT, or a \`lua\` that is 5.1
            (play and playtest; $LUA picks one)
  data      the reference data, data/forever/ (every guide command)
  addons    the game's AddOns folder: $WOW_FOREVER_ADDONS, else the client
            install finds (install and dev; or pass them --dest)
  pack.json inside a pack (or given its folder), the pack's manifest
Exit code 1 when the Node or reference-data check fails, else 0.`;

const SYSTEMS = [
	['win32', 'Windows'],
	['darwin', 'macOS'],
	['linux', 'Linux'],
];

const FIX = {
	node: {
		win32: 'winget install OpenJS.NodeJS.LTS (or the installer from https://nodejs.org), then open a new terminal',
		darwin: 'brew install node (or the installer from https://nodejs.org)',
		linux: 'install Node 24 from your package manager or https://nodejs.org, or with nvm: nvm install 24',
	},
	lua: {
		win32: 'winget install DEVCOM.LuaJIT, then open a new terminal (or set LUA to a Lua 5.1 interpreter)',
		darwin: 'brew install luajit (or set LUA to a Lua 5.1 interpreter)',
		linux: 'sudo apt install lua5.1 (Debian, Ubuntu), sudo pacman -S lua51 (Arch) or sudo dnf install luajit (Fedora; or sudo dnf install compat-lua, then export LUA=lua-5.1)',
	},
	data: {
		win32: 'in the Polestar folder: forge data build',
		darwin: 'in the Polestar folder: forge data build',
		linux: 'in the Polestar folder: forge data build',
	},
	addons: {
		win32: 'setx WOW_FOREVER_ADDONS "C:\\Program Files (x86)\\World of Warcraft\\_forever_\\Interface\\AddOns", then open a new terminal; or pass --dest <folder>',
		darwin: 'add export WOW_FOREVER_ADDONS="/Applications/World of Warcraft/_forever_/Interface/AddOns" to ~/.zshrc; or pass --dest <folder>',
		linux: 'add export WOW_FOREVER_ADDONS="<Wine prefix>/drive_c/Program Files (x86)/World of Warcraft/_forever_/Interface/AddOns" to ~/.bashrc; or pass --dest <folder>',
	},
};

function defaultLuaVersion(bin) {
	const r = spawnSync(bin, ['-e', 'io.write(jit and jit.version or _VERSION)'], { encoding: 'utf8' });
	return r.status === 0 ? r.stdout.trim() : '';
}

// The checks -> [{ check, ok, detail, fixes?: { platform: text }, extra?: [line] }].
function checks(opts, env) {
	const out = [];
	const major = Number(String(env.nodeVersion).split('.')[0]);
	out.push(major >= 24 ? { check: 'node', ok: true, detail: `Node ${env.nodeVersion}` } : { check: 'node', ok: false, detail: `Node ${env.nodeVersion} is too old: Polestar needs 24 or newer`, fixes: FIX.node });

	let lua = null;
	try {
		lua = env.findLua();
	} catch {
		lua = null;
	}
	out.push(
		lua
			? { check: 'lua', ok: true, detail: `${lua} (${env.luaVersion(lua) || 'Lua 5.1'})` }
			: { check: 'lua', ok: false, detail: 'no Lua 5.1 interpreter found (tried $LUA, lua5.1, luajit, lua); play and playtest need one', fixes: FIX.lua },
	);

	const races = path.join(env.dataDir, 'races.json');
	out.push(fs.existsSync(races) ? { check: 'data', ok: true, detail: env.dataDir } : { check: 'data', ok: false, detail: `no reference data (${races} is missing)`, fixes: FIX.data });

	const fromVar = env.vars.WOW_FOREVER_ADDONS;
	if (fromVar) {
		out.push(isDir(fromVar) ? { check: 'addons', ok: true, detail: `${fromVar} ($WOW_FOREVER_ADDONS)` } : { check: 'addons', ok: false, detail: `$WOW_FOREVER_ADDONS (${fromVar}) is not a folder`, fixes: FIX.addons });
	} else {
		// The client install would pick (tools/lib/addons.js pickAddonsDir).
		const { pick, several } = pickAddonsDir(env.detectAddons());
		if (pick) out.push({ check: 'addons', ok: true, detail: `${pick.addons} (found)` });
		else if (several) out.push({ check: 'addons', ok: false, detail: `${several.length} Forever clients found (${several.map((f) => f.addons).join(', ')}); choose one`, fixes: FIX.addons });
		else out.push({ check: 'addons', ok: false, detail: 'no World of Warcraft: Forever client found under your home folder', fixes: FIX.addons });
	}

	const packDir = opts.pack ? path.resolve(env.cwd, opts.pack) : findPackDir(env.cwd);
	if (packDir) {
		// Our guides/ is told apart by its real path (resolvePack).
		const { manifest, diags } = resolvePack({ pack: packDir });
		const errors = diags.filter((d) => d.severity === 'error').length;
		out.push(
			manifest
				? { check: 'pack.json', ok: true, detail: `${manifest.id} ${manifest.version} (${path.join(packDir, 'pack.json')})`, extra: diags.map(format) }
				: { check: 'pack.json', ok: false, detail: `${errors} error${errors === 1 ? '' : 's'} in ${path.join(packDir, 'pack.json')}`, extra: diags.map(format) },
		);
	}
	return out;
}

async function run(argv, env = {}) {
	const { opts, positional, error } = parseArgs(argv, { options: ['--pack'] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const arg = error ? {} : packArgument(opts, positional, env.cwd || process.cwd());
	if (error || arg.error) {
		console.error(`${error || arg.error}\n\n${usage}`);
		return 2;
	}
	opts.pack = arg.pack;
	env = {
		platform: process.platform,
		nodeVersion: process.versions.node,
		findLua,
		luaVersion: defaultLuaVersion,
		dataDir: DATA,
		detectAddons: () => detectAddonsDirs(),
		cwd: process.cwd(),
		vars: process.env,
		...env,
	};
	const results = checks(opts, env);
	for (const r of results) {
		console.log(`${r.ok ? 'ok ' : 'fix'} ${r.check}: ${r.detail}`);
		for (const line of r.extra || []) for (const l of line.split('\n')) console.log(`    ${l}`);
		if (r.fixes) {
			for (const [platform, name] of SYSTEMS) console.log(`    ${name}: ${r.fixes[platform]}${platform === env.platform ? '  (this system)' : ''}`);
		}
	}
	const fatal = results.some((r) => !r.ok && (r.check === 'node' || r.check === 'data'));
	return fatal ? 1 : 0;
}

module.exports = { name: 'doctor', summary: 'Check Node, Lua, the reference data, the AddOns folder and pack.json', usage, run };
