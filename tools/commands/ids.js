'use strict';
// ids: add stable `id` lines to every step that lacks one, in place.

const fs = require('node:fs');
const path = require('node:path');
const { packCommand } = require('../lib/pack/build');
const { ROOT } = require('../lib/paths');

const usage = `usage: node tools/polestar.js ids [<dir>] [options]

For every .guide file in the pack (default: the nearest pack.json), adds an
\`id <x>\` line to each step that does not already have one. The id is 6
lowercase alphanumeric characters, deterministically derived from the file
path, step title and a counter; collisions within the guide are re-drawn.
Files that need no ids are left untouched. Prints "<file>: N ids added" for
each file changed.

options:
  <dir>, --pack <dir>   the pack folder (holding pack.json)`;

// djb2 hash of a string -> 32-bit unsigned integer.
function djb2(s) {
	let h = 5381;
	for (let i = 0; i < s.length; i++) h = ((h * 33) + s.charCodeAt(i)) >>> 0;
	return h;
}

// 6-char base36 from a 32-bit integer.
function toBase36(n) {
	return (n >>> 0).toString(36).slice(-6).padStart(6, '0');
}

// Generate a stable 6-char id for a step, re-drawn on collision.
function generateId(file, title, attempt, usedIds) {
	let id;
	for (let a = attempt; ; a++) {
		id = toBase36(djb2(`${file}:${title || ''}:${a}`));
		if (!usedIds.has(id)) return id;
	}
}

// Parse step titles and existing ids from guide text (lines).
// Returns [{ line: 0-based step line index, title: string, id: string|null }]
function parseSteps(lines) {
	const steps = [];
	for (let i = 0; i < lines.length; i++) {
		const line = lines[i];
		if (/^step\b/i.test(line)) {
			const title = line.replace(/^step\s*/i, '').trim();
			steps.push({ stepLine: i, title, id: null, idLine: null });
		} else if (steps.length > 0 && /^[ \t]/.test(line)) {
			const m = line.match(/^[ \t]+id\s+([a-z0-9]{4,8})\s*(?:#.*)?$/);
			if (m) steps[steps.length - 1].id = m[1];
		} else if (steps.length > 0 && !/^[ \t]/.test(line) && line.trim() !== '' && !/^#/.test(line)) {
			// non-indented non-blank: new section starts (another step or header would reset)
		}
	}
	return steps;
}

// Add ids to a single guide file. Returns number of ids added.
function addIdsToFile(filePath, packDir) {
	const text = fs.readFileSync(filePath, 'utf8');
	const eol = text.includes('\r\n') ? '\r\n' : '\n';
	const lines = text.split(/\r?\n/);
	const usedIds = new Set();

	// First pass: collect existing ids
	const steps = parseSteps(lines);
	for (const s of steps) {
		if (s.id) usedIds.add(s.id);
	}

	// Second pass: assign new ids
	const relFile = path.relative(packDir, filePath).replace(/\\/g, '/');
	let attempt = 0;
	const assignments = []; // { afterLine, id }
	for (const s of steps) {
		if (!s.id) {
			const id = generateId(relFile, s.title, attempt++, usedIds);
			usedIds.add(id);
			assignments.push({ afterLine: s.stepLine, id });
		}
	}

	if (!assignments.length) return 0;

	// Insert id lines after each step line (in reverse order to keep offsets valid)
	const result = [...lines];
	for (let i = assignments.length - 1; i >= 0; i--) {
		const { afterLine, id } = assignments[i];
		result.splice(afterLine + 1, 0, `  id ${id}`);
	}

	fs.writeFileSync(filePath, result.join(eol), 'utf8');
	return assignments.length;
}

// Collect .guide files recursively (excluding dist/, drafts/).
function findGuides(dir) {
	const out = [];
	const walk = (abs) => {
		for (const d of fs.readdirSync(abs, { withFileTypes: true })) {
			if (d.name.startsWith('.')) continue;
			const full = path.join(abs, d.name);
			if (d.isDirectory()) {
				if (d.name === 'node_modules' || d.name === 'dist' || d.name === 'drafts') continue;
				walk(full);
			} else if (d.isFile() && d.name.endsWith('.guide')) out.push(full);
		}
	};
	if (fs.existsSync(dir)) walk(dir);
	return out.sort();
}

async function run(argv) {
	const cmd = packCommand(argv, { name: 'ids', usage, flags: [], options: ['--pack'] });
	if (cmd.exit !== undefined) return cmd.exit;
	const { pack } = cmd;

	const packDir = pack.official ? path.join(ROOT, 'guides') : pack.dir;
	const files = findGuides(packDir);
	let totalAdded = 0;
	for (const file of files) {
		const n = addIdsToFile(file, packDir);
		if (n > 0) {
			console.log(`${path.relative(packDir, file)}: ${n} id${n === 1 ? '' : 's'} added`);
			totalAdded += n;
		}
	}
	if (totalAdded === 0) console.log('all steps already have ids');
	return 0;
}

module.exports = { name: 'ids', summary: 'Add stable step ids to every step that lacks one', usage, run };
