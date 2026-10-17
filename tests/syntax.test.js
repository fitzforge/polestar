'use strict';
// Static checks over every addon folder: each Lua file compiles under Lua 5.1,
// writes no globals outside the allowlist, and is loaded by a manifest; every
// manifest reference exists.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const { tocEntries, xmlFiles, ADDONS, ROOT } = require('./helpers/lua');

const ALLOWED_GLOBAL = /^(Polestar|PolestarDB|PolestarCharDB|PolestarRecorderDB|PolestarRecorder_Command|Polestar_NavEngine|PolestarPathData|PolestarNavChokepoints|SLASH_POLESTAR\d+|SLASH_POLESTARREC\d+|SLASH_POLESTARWAY\d+|BINDING_HEADER_POLESTAR|BINDING_NAME_POLESTAR_\w+)$/;
// Globals one file may write: the TomTom stand-in owns `TomTom` while TomTom is not installed.
const FILE_GLOBALS = { 'addon/Polestar/Nav/Journey.lua': new Set(['TomTom']) };

function luac() {
	for (const bin of [process.env.LUAC, 'luac5.1', 'luac'].filter(Boolean)) {
		const r = spawnSync(bin, ['-v'], { encoding: 'utf8' });
		if (r.status === 0 && /5\.1/.test(r.stdout + r.stderr)) return bin;
	}
	return null;
}

function walk(dir, ext) {
	const out = [];
	for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
		const p = path.join(dir, entry.name);
		if (entry.isDirectory()) out.push(...walk(p, ext));
		else if (entry.name.toLowerCase().endsWith(ext)) out.push(p);
	}
	return out;
}

const addonDirs = fs
	.readdirSync(ADDONS, { withFileTypes: true })
	.filter((e) => e.isDirectory())
	.map((e) => path.join(ADDONS, e.name));
const luaFiles = addonDirs.flatMap((d) => walk(d, '.lua'));
const LUAC = luac();

test('every addon Lua file compiles under Lua 5.1', { skip: !LUAC && 'luac5.1 not installed' }, () => {
	const failures = [];
	for (const file of luaFiles) {
		const r = spawnSync(LUAC, ['-p', file], { encoding: 'utf8' });
		if (r.status !== 0) failures.push(r.stderr.trim());
	}
	assert.deepEqual(failures, []);
});

test('addon code only writes allowlisted globals', { skip: !LUAC && 'luac5.1 not installed' }, () => {
	const violations = [];
	for (const file of luaFiles) {
		const r = spawnSync(LUAC, ['-l', '-p', file], { encoding: 'utf8', maxBuffer: 256 * 1024 * 1024 });
		for (const m of r.stdout.matchAll(/SETGLOBAL\s+\d+\s+-?\d+\s*;\s*(\S+)/g)) {
			const own = FILE_GLOBALS[path.relative(ROOT, file).split(path.sep).join('/')];
			if (!ALLOWED_GLOBAL.test(m[1]) && !(own && own.has(m[1]))) violations.push(`${path.relative(ROOT, file)}: ${m[1]}`);
		}
	}
	assert.deepEqual([...new Set(violations)], []);
});

test('manifests reference existing files and load every Lua file', () => {
	const problems = [];
	for (const dir of addonDirs) {
		let loaded;
		try {
			loaded = new Set();
			for (const rel of tocEntries(dir)) {
				const target = path.join(dir, rel.replace(/\\/g, '/'));
				if (!fs.existsSync(target)) {
					problems.push(`${path.relative(ROOT, dir)}: TOC lists missing ${rel}`);
					continue;
				}
				if (target.toLowerCase().endsWith('.xml')) {
					loaded.add(target);
					for (const f of xmlFiles(target)) loaded.add(f);
				} else loaded.add(target);
			}
		} catch (err) {
			problems.push(err.message);
			continue;
		}
		for (const file of walk(dir, '.lua')) {
			if (!loaded.has(file)) problems.push(`${path.relative(ROOT, file)} is not loaded by any manifest`);
		}
	}
	assert.deepEqual(problems, []);
});
