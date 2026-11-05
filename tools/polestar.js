#!/usr/bin/env node
'use strict';
// Polestar's command line. Each command is a module in tools/commands/
// exporting { name, summary, usage, run(argv) -> exit code }; this file only
// finds and dispatches them, so adding a command never edits a shared file.
// `<command> ... --help` (or -h) prints the command's usage and never runs it.
//
//   node tools/polestar.js help
//   node tools/polestar.js help <command>

const fs = require('node:fs');
const path = require('node:path');

const DIR = path.join(__dirname, 'commands');

// Commands that moved to forge (rust/): the forge command to run instead.
const MOVED = {
	changelog: 'forge changelog <add|check|show|build> [--root <dir>] [--name <slug>] [--text <entry>] [--date <date>] (forge changelog --help)',
	compile: 'forge guide compile [<dir>] [--pack <dir>] [--data <dir>] [--out <dir>] [--no-data] [--include-drafts] [--format text|json|github] (forge guide --help)',
	credits: 'forge release credits [--root <dir>] (forge release credits --help)',
	guidecheck: 'forge guide check <dir> [--json] [--fix] [--data <dir>] (forge guide --help)',
	lint: 'forge guide lint [<dir>] [--pack <dir>] [--data <dir>] [--sim <dir>] [--no-data] [--include-drafts] [--format text|json|github] (forge guide --help)',
	pack: 'forge release pack [<dir>] [--pack <dir>] [--data <dir>] [--context <dir>] [--context-data <dir>] [--dist <dir>] [--no-data] (forge release pack --help)',
	release: 'forge release notes <x.y.z> [--root <dir>] [--out <dir>] (forge release --help)',
	version: 'forge release version [<x.y.z>] [--root <dir>] [--addons <dir>] (forge release version --help)',
};

function load() {
	const cmds = new Map();
	if (!fs.existsSync(DIR)) return cmds;
	for (const file of fs.readdirSync(DIR).sort()) {
		if (!file.endsWith('.js')) continue;
		const mod = require(path.join(DIR, file));
		if (!mod || typeof mod.run !== 'function' || !mod.name) {
			throw new Error(`tools/commands/${file} must export { name, summary, usage, run }`);
		}
		if (cmds.has(mod.name)) throw new Error(`duplicate command "${mod.name}" in tools/commands/${file}`);
		cmds.set(mod.name, mod);
	}
	return cmds;
}

function overview(cmds) {
	const names = [...cmds.keys()];
	const width = Math.max(4, ...names.map((n) => n.length));
	return [
		'usage: node tools/polestar.js <command> [args]',
		'',
		'commands:',
		...names.map((n) => `  ${n.padEnd(width)}  ${cmds.get(n).summary || ''}`),
		'',
		'node tools/polestar.js help <command> for details',
		'',
		'moved to forge:',
		...Object.entries(MOVED).map(([n, f]) => `  ${n.padEnd(width)}  ${f.split(' ').slice(0, 3).join(' ')}`),
	].join('\n');
}

async function main(argv) {
	const cmds = load();
	const [name, ...rest] = argv;
	if (!name || name === 'help' || name === '--help' || name === '-h') {
		const target = name === 'help' && rest[0] ? cmds.get(rest[0]) : null;
		if (name === 'help' && MOVED[rest[0]]) {
			console.error(`polestar ${rest[0]} moved to forge: ${MOVED[rest[0]]}`);
			return 2;
		}
		if (name === 'help' && rest[0] && !target) {
			console.error(`unknown command "${rest[0]}"`);
			return 2;
		}
		console.log(target ? target.usage || target.summary || target.name : overview(cmds));
		return 0;
	}
	const moved = MOVED[name];
	if (moved) {
		console.error(`polestar ${name} moved to forge: ${moved}`);
		return 2;
	}
	const cmd = cmds.get(name);
	if (!cmd) {
		console.error(`unknown command "${name}"\n\n${overview(cmds)}`);
		return 2;
	}
	// Asking for help never does work: `<command> [anything] --help` prints the
	// usage before the command sees its arguments, so no command can take the
	// flag for an input and build, write or download.
	if (rest.includes('--help') || rest.includes('-h')) {
		console.log(cmd.usage || cmd.summary || cmd.name);
		return 0;
	}
	const code = await cmd.run(rest);
	return typeof code === 'number' ? code : 0;
}

if (require.main === module) {
	main(process.argv.slice(2)).then(
		(code) => {
			process.exitCode = code;
		},
		(err) => {
			console.error(err && err.stack ? err.stack : String(err));
			process.exitCode = 1;
		},
	);
}

module.exports = { main, load, MOVED };
