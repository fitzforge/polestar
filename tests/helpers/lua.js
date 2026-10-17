'use strict';
// Runs addon Lua under a real Lua 5.1 against tests/lua/wow_stub.lua.
//
//   const { runAddon } = require('./helpers/lua');
//   const [result] = runAddon({
//     stubs: ['stub_world.lua'],             // extra files from tests/lua/, after wow_stub.lua
//     before: 'stub.world.setLevel(3)',      // Lua run after the stubs, before any addon file
//     addons: ['Polestar', 'Polestar_Guides'],
//     saved: { Polestar: 'PolestarDB = { schema = 1, settings = {} }' },  // restored before ADDON_LOADED
//     login: true,                           // fire PLAYER_LOGIN / PLAYER_ENTERING_WORLD after loading
//     script: 'emit(Polestar.Engine.GetStepIndex())',
//   }).emitted;
//
// Addons load the way the client loads them: every file listed by the TOC, XML
// manifests expanded in order, each chunk called with (addonName, namespace).
// An addon entry may be { name, files: [...] } (paths relative to the addon
// folder, .xml expanded) to load a subset, or { name, dir } to load the addon
// folder `dir` (outside addon/, e.g. a pack built into a temp folder) by its
// TOC. emit(value) prints one JSON line; runAddon returns those values parsed,
// in order. A Lua error fails loudly. Each addon file's chunk is listed in
// stub.addonSources: wow_stub.lua's map guard tells addon code by it.

const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { findLua } = require('../../tools/lib/lua');

const ROOT = path.join(__dirname, '..', '..');
// POLESTAR_ADDON_DIR loads the addons from another copy (A/B profiling against
// an earlier build, tests/helpers/profile.js).
const ADDONS = process.env.POLESTAR_ADDON_DIR ? path.resolve(process.env.POLESTAR_ADDON_DIR) : path.join(ROOT, 'addon');
const STUBS = path.join(ROOT, 'tests', 'lua');

function norm(p) {
	return p.replace(/\\/g, '/');
}

// Files an XML manifest loads, in order. Only <Script file> and <Include file>
// are used by Polestar's manifests.
function xmlFiles(xmlPath) {
	const dir = path.dirname(xmlPath);
	const text = fs.readFileSync(xmlPath, 'utf8').replace(/<!--[\s\S]*?-->/g, '');
	const out = [];
	const re = /<(Script|Include)\s+file\s*=\s*"([^"]+)"\s*\/?>/g;
	let m;
	while ((m = re.exec(text))) {
		const target = path.join(dir, norm(m[2]));
		if (!fs.existsSync(target)) throw new Error(`${path.relative(ROOT, xmlPath)} references missing ${m[2]}`);
		if (m[1] === 'Include' || target.toLowerCase().endsWith('.xml')) out.push(...xmlFiles(target));
		else out.push(target);
	}
	return out;
}

function expand(addonDir, entries) {
	const out = [];
	for (const rel of entries) {
		const target = path.join(addonDir, norm(rel));
		if (!fs.existsSync(target)) throw new Error(`${path.relative(ROOT, addonDir)}: missing ${rel}`);
		if (target.toLowerCase().endsWith('.xml')) out.push(...xmlFiles(target));
		else out.push(target);
	}
	return out;
}

// The TOC's file list (lines that are not blank, comments or ## metadata).
function tocEntries(addonDir) {
	const name = path.basename(addonDir);
	const toc = path.join(addonDir, `${name}.toc`);
	if (!fs.existsSync(toc)) throw new Error(`no TOC at ${path.relative(ROOT, toc)}`);
	return fs
		.readFileSync(toc, 'utf8')
		.split(/\r?\n/)
		.map((l) => l.trim())
		.filter((l) => l && !l.startsWith('#'));
}

// The files an addon folder's TOC loads, in order (the folder may be anywhere).
function dirFiles(dir) {
	return expand(dir, tocEntries(dir));
}

function tocFiles(addonName) {
	return dirFiles(path.join(ADDONS, addonName));
}

function luaString(s) {
	return '"' + String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n') + '"';
}

function buildProgram(opts) {
	const lines = [];
	lines.push(`package.path = ${luaString(STUBS + '/?.lua;')} .. package.path`);
	lines.push(`dofile(${luaString(path.join(STUBS, 'wow_stub.lua'))})`);
	for (const s of opts.stubs || []) lines.push(`dofile(${luaString(path.join(STUBS, s))})`);
	if (opts.before) lines.push(opts.before);
	lines.push(`local function __load(name, files, saved)
  local ns = {}
  for _, f in ipairs(files) do
    local chunk, err = loadfile(f)
    if not chunk then error(err, 0) end
    stub.addonSources["@" .. f] = name
    chunk(name, ns)
  end
  if saved then saved() end
  stub.addonLoaded(name)
  return ns
end`);
	for (const entry of opts.addons || []) {
		const name = typeof entry === 'string' ? entry : entry.name;
		const files = entry.dir ? expand(entry.dir, tocEntries(entry.dir)) : typeof entry === 'string' || !entry.files ? tocFiles(name) : expand(path.join(ADDONS, name), entry.files);
		const saved = opts.saved && opts.saved[name] ? `function() ${opts.saved[name]} end` : 'nil';
		lines.push(`__load(${luaString(name)}, { ${files.map(luaString).join(', ')} }, ${saved})`);
	}
	if (opts.login) lines.push('stub.login()');
	if (opts.script) lines.push(opts.script);
	return lines.join('\n');
}

function runAddon(opts = {}) {
	const program = buildProgram(opts);
	const file = path.join(os.tmpdir(), `polestar-test-${process.pid}-${Date.now()}-${Math.random().toString(36).slice(2)}.lua`);
	fs.writeFileSync(file, program);
	try {
		const r = spawnSync(findLua(), [file], { encoding: 'utf8', cwd: ROOT, maxBuffer: 64 * 1024 * 1024 });
		if (r.error) throw r.error;
		if (r.status !== 0) {
			const err = new Error(`Lua failed (exit ${r.status}):\n${r.stderr}\n${r.stdout}`);
			err.stdout = r.stdout;
			err.stderr = r.stderr;
			throw err;
		}
		const emitted = [];
		for (const line of r.stdout.split('\n')) {
			if (line.startsWith('@@JSON ')) emitted.push(JSON.parse(line.slice(7)));
		}
		return { emitted, stdout: r.stdout, stderr: r.stderr };
	} finally {
		fs.rmSync(file, { force: true });
	}
}

module.exports = { runAddon, tocFiles, dirFiles, tocEntries, xmlFiles, ROOT, ADDONS };
