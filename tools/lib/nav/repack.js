'use strict';
// The steps of tools/nav/repack.sh that work on the packed files (docs/nav/REPACK.md):
//   node tools/lib/nav/repack.js graft <base AddOns> <plain AddOns> <new AddOns> <output AddOns>
//   node tools/lib/nav/repack.js record <AddOns> <work dir> <base AddOns> <plain AddOns> [<role>=<file>...]
//   node tools/lib/nav/repack.js compare <repacked AddOns> <AddOns>
// graft: 0.4.2's shipped maps (the base) are a plain `forge nav pack` (the plain pack) with layers appended to a
// few files (detail lanes, the rope bridges' chokepoints, the ground pages of local walks) and three ground
// sidecars (TerminalGround.lua). Copies the new plain pack to the output with each appended layer after the same
// file, the base's file whole where the new pack left that file as the plain one was, the sidecars, and the
// manifest's sha256 of each grafted file replaced (written with two-space indents, as the base's was).
// record: PACK.json's `repack`: the pins of each step and the sha256 of the inputs.
// compare: every file PACK.json lists (and PACK.json itself) byte for byte, and the files of the maps' folders
// it does not list.
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');

const MANIFEST = 'Polestar_Nav/PACK.json';
const SIDECARS = ['Polestar_Nav/Nav/TerminalGround.lua', 'Polestar_Nav_EK/TerminalGround.lua', 'Polestar_Nav_Kalimdor/TerminalGround.lua'];
// The folders that hold nothing but the packed maps (Polestar_Nav's own code lives beside Nav/).
const PACK_DIRS = ['Polestar_Nav/Nav', 'Polestar_Nav_EK', 'Polestar_Nav_Kalimdor'];

const sha = (bytes) => crypto.createHash('sha256').update(bytes).digest('hex');
const full = (key) => (key.startsWith('Nav/') ? `Polestar_Nav/${key}` : key);
const manifestOf = (dir) => JSON.parse(fs.readFileSync(path.join(dir, MANIFEST), 'utf8'));

// A file of a pack, checked against that pack's manifest.
function listed(dir, files, key) {
	const bytes = fs.readFileSync(path.join(dir, full(key)));
	assert.equal(sha(bytes), files[key], `${path.join(dir, full(key))}: not the file its PACK.json lists`);
	return bytes;
}

function graft(base, plain, fresh, out) {
	assert(!fs.existsSync(out), `${out} exists`);
	const mb = manifestOf(base).files, mp = manifestOf(plain).files;
	fs.cpSync(fresh, out, { recursive: true });
	const manifestFile = path.join(out, MANIFEST);
	let text = fs.readFileSync(manifestFile, 'utf8');
	const mn = JSON.parse(text).files;
	const grafted = {};
	for (const key of Object.keys(mb).sort()) {
		if (mb[key] === mp[key]) continue;
		assert(key in mp && key in mn, `${key}: in the base but not in both plain packs`);
		const b = listed(base, mb, key), p = listed(plain, mp, key), n = listed(out, mn, key);
		let data;
		if (n.equals(p)) {
			data = b; // the new pack left this file as it was: the base's whole
			grafted[key] = 'kept';
		} else {
			assert(b.subarray(0, p.length).equals(p), `${key}: the new pack changed it, and the base's is not the plain one with a layer appended`);
			data = Buffer.concat([n, b.subarray(p.length)]);
			grafted[key] = b.length - p.length;
		}
		fs.writeFileSync(path.join(out, full(key)), data);
		assert.equal(text.split(mn[key]).length, 2, `${key}: its sha256 is not once in the new manifest`);
		text = text.replace(mn[key], sha(data));
	}
	fs.writeFileSync(manifestFile, `${JSON.stringify(JSON.parse(text), null, 2)}\n`);
	for (const file of SIDECARS) {
		fs.mkdirSync(path.dirname(path.join(out, file)), { recursive: true });
		fs.copyFileSync(path.join(base, file), path.join(out, file));
	}
	return grafted;
}

function record(dest, work, base, plain, inputs) {
	const file = path.join(dest, MANIFEST);
	const manifest = JSON.parse(fs.readFileSync(file, 'utf8'));
	const pin = (dir) => sha(fs.readFileSync(path.join(dir, MANIFEST)));
	delete manifest.repack;
	manifest.repack = {
		command: 'tools/nav/repack.sh',
		inputs: Object.fromEntries(inputs.map(([role, input]) => [role, sha(fs.readFileSync(input))])),
		packManifestSha256: pin(path.join(work, 'pack')),
		graft: { baseManifestSha256: pin(base), plainManifestSha256: pin(plain), sidecars: SIDECARS },
		derivedManifestSha256: pin(path.join(work, 'derived')),
		rebuiltManifestSha256: pin(path.join(work, 'rebuilt')),
	};
	fs.writeFileSync(file, `${JSON.stringify(manifest, null, '\t')}\n`);
	return manifest.repack;
}

function compare(repacked, shipped) {
	const manifest = manifestOf(repacked);
	const keys = [...Object.keys(manifest.files), ...Object.keys(manifest.loaders || {})].map(full).concat(MANIFEST);
	const differ = [], missing = [];
	for (const key of keys) {
		const target = path.join(shipped, key);
		if (!fs.existsSync(target)) missing.push(key);
		else if (!fs.readFileSync(target).equals(fs.readFileSync(path.join(repacked, key)))) differ.push(key);
	}
	const known = new Set(keys);
	const unlisted = PACK_DIRS.flatMap((dir) => (fs.existsSync(path.join(shipped, dir)) ? fs.readdirSync(path.join(shipped, dir)).sort().map((f) => `${dir}/${f}`) : []))
		.filter((key) => !known.has(key) && !key.endsWith('.toc'));
	// PACK.json's top-level fields that differ, to say which step's record moved.
	let fields = [];
	if (differ.includes(MANIFEST)) {
		const a = manifest, b = manifestOf(shipped);
		fields = [...new Set([...Object.keys(a), ...Object.keys(b)])].filter((k) => JSON.stringify(a[k]) !== JSON.stringify(b[k]));
	}
	return { files: keys.length, differ, missing, unlisted, fields };
}

if (require.main === module) {
	const [cmd, ...args] = process.argv.slice(2);
	if (cmd === 'graft' && args.length === 4) {
		for (const [key, what] of Object.entries(graft(...args))) console.log(`graft ${key}: ${what === 'kept' ? 'left as it was by the new pack, the base\'s kept' : `+${what} bytes appended`}`);
	} else if (cmd === 'record' && args.length >= 4) {
		const inputs = args.slice(4).map((a) => {
			const at = a.indexOf('=');
			assert(at > 0, `not <role>=<file>: ${a}`);
			return [a.slice(0, at), a.slice(at + 1)];
		});
		console.log(JSON.stringify(record(args[0], args[1], args[2], args[3], inputs), null, '\t'));
	} else if (cmd === 'compare' && args.length === 2) {
		const r = compare(...args);
		for (const key of r.differ) console.log(`differs: ${key}`);
		for (const key of r.missing) console.log(`missing: ${key}`);
		for (const key of r.unlisted) console.log(`not in PACK.json: ${key}`);
		if (r.fields.length) console.log(`PACK.json fields that differ: ${r.fields.join(', ')}`);
		const same = !r.differ.length && !r.missing.length && !r.unlisted.length;
		console.log(same ? `${r.files} files, byte for byte the same` : `${r.files} files: ${r.differ.length} differ, ${r.missing.length} missing, ${r.unlisted.length} not in PACK.json`);
		process.exitCode = same ? 0 : 1;
	} else {
		console.error('usage: node tools/lib/nav/repack.js graft <base> <plain> <new> <out> | record <AddOns> <work> <base> <plain> [<role>=<file>...] | compare <repacked> <AddOns>');
		process.exitCode = 2;
	}
}

module.exports = { graft, record, compare, MANIFEST, SIDECARS };
