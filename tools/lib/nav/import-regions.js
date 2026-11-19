'use strict';
// node tools/lib/nav/import-regions.js <derived AddOns folder> <output AddOns folder>
// Import the reviewed, already baked 70532 walking maps, never client archives, player files or addon code.
// Input pins cover the complete forge nav pack manifest and the three derived terminal-mask sidecars.
// The region transform is lossless: neither floor topology nor the compressed evidence pages are recomputed.
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');

const sha = bytes => crypto.createHash('sha256').update(bytes).digest('hex');
const hash = (key, bytes) => key.endsWith('.toc')
	? sha(bytes.toString('utf8').split('\n').filter(l => !/^## (?:Version|(?:Title|Notes)(?:-[a-z]{2}[A-Z]{2})?):/.test(l)).join('\n'))
	: sha(bytes);
const inputManifest = 'bcbe88bbe5a93e8d483150433273ca606721c35d84570d8c8525825f2bec3088';
const terminal = {
	0: '38288a037e6fb2397f1cd26f36cd9f8bfa74a743508c3408e12db62ff40cff7a',
	1: '823b7365bf07629fc79c187decf2921f18e6dd518255b9ad1266d5814e842a75',
	2991: '57bd4204fda6f28c808931e65e9d1a19f267bb2e556e250628b58f899cda342a',
};
const part = { 0: 'Polestar_Nav_EK', 1: 'Polestar_Nav_Kalimdor', 2991: 'Nav' };
const full = key => key.startsWith('Nav/') ? `Polestar_Nav/${key}` : key;
function pinned(root, key, digest) {
	const buf = fs.readFileSync(path.join(root, key));
	assert.equal(sha(buf), digest, `unrecognized input: ${key}`);
	return buf;
}
function literal(bytes) {
	// Match forge-nav's zlib_literals; the remaining bytes are valid Lua 5.1 string contents as-is.
	return bytes.toString('latin1').replace(/[\x00\n\r\x1a"\\]/g, s => `\\${String(s.charCodeAt(0)).padStart(3, '0')}`);
}
function importRegions(source, dest) {
	assert.notEqual(fs.realpathSync(source), fs.realpathSync(dest), 'use a separate output folder');
	const manifest = JSON.parse(pinned(source, 'Polestar_Nav/PACK.json', inputManifest));
	const outputManifest = path.join(dest, 'Polestar_Nav/PACK.json');
	const previous = fs.existsSync(outputManifest) ? JSON.parse(fs.readFileSync(outputManifest, 'utf8')) : {};
	const files = {}, loaders = {}, regions = new Map(), metadata = new Map();
	const toc = fs.readFileSync(path.join(dest, 'Polestar_Nav/Polestar_Nav.toc'), 'utf8');
	const header = key => { const value = toc.split('\n').find(l => l.startsWith(`## ${key}: `)); assert(value); return value; };
	function write(key, buf, into) {
		const target = path.join(dest, full(key));
		fs.mkdirSync(path.dirname(target), { recursive: true });
		if (!fs.existsSync(target) || !buf.equals(fs.readFileSync(target))) {
			const tmp = `${target}.${process.pid}.tmp`;
			fs.writeFileSync(tmp, buf, { flag: 'wx' });
			fs.renameSync(tmp, target);
		}
		if (into) into[key] = hash(key, buf);
	}
	function region(map, row, col, floorPages) {
		// A cost search needs coarse floors but not a sector's detailed local geometry. Both are
		// real LoD addons: even rows hold floors and odd rows evidence for the same 8 x 4 tiles.
		const r = 2 * Math.floor(row / 8) + (floorPages ? 0 : 1), c = Math.floor(col / 4);
		assert(r >= 0 && r < 16 && c >= 0 && c < 16, `bad tile: ${map}:${row}:${col}`);
		const name = `Polestar_Nav_R${map}_${r}_${c}`;
		if (!regions.has(name)) regions.set(name, { map, fields: new Map() });
		return [regions.get(name), 16 * r + c];
	}
	function add(group, field, index, rhs) {
		if (!group.fields.has(field)) group.fields.set(field, []);
		group.fields.get(field).push(`[${index}]=${rhs},`);
	}
	function tile(field, k) {
		if (field === 'ground') return [Math.floor(k/64), k%64];
		if (field === 'nativeTerrain' || field === 'terminalGround') return tile('ground', Math.floor(k/16));
		const r = Math.floor(k/1024), c = k%1024;
		if (field === 'astraSurfaces' || field === 'solidColumns') return [Math.floor(r/16), Math.floor(c/16)];
		if (field === 'obstructionBounds') return [Math.floor(k/512), k%512].map(v => Math.floor(32 - (v-256+.5)*.24));
		assert(field === 'lines' || field === 'approachLines');
		return [r,c].map(v => Math.floor(32 + ((v+.5)*64-17067)*3/1600));
	}
	function detail(text, map, refs) {
		let field;
		for (const line of text.split('\n')) {
			const decl = /^(?:PolestarPathData\[\d+\]\.)?(\w+)=\{$/.exec(line);
			if (decl) { field = decl[1]; continue; }
			if (!line || line === '}' || line === '},') continue;
			const m = /^\[(\d+)\]="([a-zA-Z0-9+/=]+)",$/.exec(line);
			assert(m && field, `unrecognized ${map} page`);
			const k = Number(m[1]), [group,id] = region(map, ...tile(field,k));
			const member = ['ground','lines'].includes(field) ? `localWalk.${field}` : field;
			const raw = Buffer.from(m[2], 'base64');
			assert.equal(raw.toString('base64'), m[2]);
			add(group, member, k, `"${literal(raw)}"`);
			if (!refs.has(member)) refs.set(member, []);
			refs.get(member).push([k, id]);
		}
	}
	for (const [key, digest] of Object.entries(manifest.files)) {
		const bytes = pinned(source, full(key), digest);
		const meta = /Nav\/Nav(\d+)\.lua$/.exec(key);
		if (meta) {
			const text = bytes.toString('utf8');
			const num = n => Number(new RegExp(`\\b${n} = (-?\\d+),`).exec(text)[1]);
			metadata.set(+meta[1], [num('cx0'),num('cy0'),num('ny')]);
		}
		const m = /\/Nav(\d+)_(\d+)\.lua$/.exec(key);
		if (!m) { write(key, bytes, files); continue; }
		const map = +m[1], [cx,cy,ny] = metadata.get(map), first = m[2] === '1';
		let text = bytes.toString('latin1'), index = '';
		if (first) {
			const at = text.indexOf(`PolestarPathData[${map}].localWalk={`);
			assert(at >= 0);
			const refs = new Map();
			detail(text.slice(at), map, refs);
			detail(pinned(source, full(`${part[map]}/TerminalGround.lua`), terminal[map]).toString('ascii'), map, refs);
			text = text.slice(0,at);
			index = `data.localWalk={}\ndata.detailMap=${map}\n`;
			for (const [field, entries] of refs) {
				// Fixed-width sorted keys let the client find an exact page without expanding the directory.
				const rows = Buffer.allocUnsafe(4*entries.length);
				entries.sort((a,b) => a[0]-b[0]).forEach(([k,id], i) => {
					assert(i === 0 || k > entries[i-1][0]);
					rows.writeUIntBE(k,4*i,3); rows[4*i+3] = id;
				});
				index += `data.${field}={detailMap=${map},directory="${literal(rows)}"}\n`;
			}
		}
		text = text.replace(/^data\.packed\.floor\[(\d+)\] = (\{[^\n]+\})$/gm, (_, key, rhs) => {
			const k = Number(key)-1;
			const [group,id] = region(map,31-cx-Math.floor(k/ny),31-cy-(k%ny),true);
			add(group,'packed.floor',key,rhs);
			return `data.packed.floor[${key}] = ${id}`;
		});
		if (first || text.length !== bytes.length) text = text.replace('Do not edit: rebuild with that command.', 'Regional layout: node tools/lib/nav/import-regions.js.');
		write(key, Buffer.from(text+index,'latin1'), files);
	}
	for (const [name, {map, fields}] of [...regions].sort(([a],[b]) => a < b ? -1 : 1)) {
		// Assign to existing tables: other regions of this map remain untouched.
		const lines = [`-- Generated by \`node tools/lib/nav/import-regions.js\`: map ${map}, derived walking grid ${manifest.grid.build}, packed ${manifest.date}.`, `local d = PolestarPathData[${map}]`, 'if not d then return end'];
		for (const [field, entries] of fields) {
			lines.push(`local t = d.${field}`);
			for (const entry of entries) lines.push(`t${entry.slice(0,-1)}`);
		}
		write(`${name}/Pages.lua`, Buffer.from(lines.join('\n')+'\n','latin1'), files);
		const [,row,col] = name.slice('Polestar_Nav_R'.length).split('_');
		const suffix = ` [${map}:${row},${col}]`;
		const labels = toc.split('\n').filter(l => /^## (?:Title|Notes)-[a-z]{2}[A-Z]{2}:/.test(l)).map(l => l.startsWith('## Title-') ? l+suffix : l);
		const dep = map === 2991 ? 'Polestar_Nav' : part[map];
		write(`${name}/${name}.toc`, Buffer.from([header('Interface'), header('Title')+suffix, '## Notes: Regional walking map data. Loaded by Polestar Nav when needed.', ...labels, header('Version'), '## Group: Polestar', '## Category: Polestar', '## LoadOnDemand: 1', `## Dependencies: ${dep}`, '## X-License: GPL-3.0-or-later', '', 'Pages.lua', ''].join('\n')), loaders);
	}
	write('Polestar_Nav/Polestar_Nav.toc', Buffer.from(toc), loaders);
	const navFiles = Object.keys(files).filter(k => k.startsWith('Nav/')).map(k => k.slice(4));
	write('Nav/Nav.xml', Buffer.from(['<Ui xmlns="http://www.blizzard.com/wow/ui/">', `\t<!-- Written by ${manifest.generator}: Polestar's walking maps (PACK.json), then the chokepoints. -->`, ...navFiles.map(n => `\t<Script file="${n}"/>`), '</Ui>', ''].join('\n')), loaders);
	for (const folder of [part[0], part[1]]) {
		const key = `${folder}/${folder}.toc`;
		const head = fs.readFileSync(path.join(dest,key),'utf8').split('\n').filter(l => l.startsWith('#'));
		const names = Object.keys(files).filter(k => k.startsWith(folder+'/')).map(k => k.split('/')[1]);
		write(key,Buffer.from([...head,'',...names,''].join('\n')),loaders);
	}
	// Remove only obsolete outputs of an earlier import of these same derived inputs. A foreign
	// folder or hand-modified payload must be reconciled explicitly, not silently deleted.
	if (previous.import && previous.import.manifestSha256 === inputManifest) {
		for (const name of previous.regions) {
			if (regions.has(name)) continue;
			assert(/^Polestar_Nav_R(?:0|1|2991)_(?:[0-9]|1[0-5])_(?:[0-9]|1[0-5])$/.test(name));
			const dir = path.join(dest, name);
			if (!fs.existsSync(dir)) continue;
			assert.deepEqual(fs.readdirSync(dir).sort(), ['Pages.lua', `${name}.toc`]);
			pinned(dest, `${name}/Pages.lua`, previous.files[`${name}/Pages.lua`]);
			const tocKey = `${name}/${name}.toc`;
			assert.equal(hash(tocKey, fs.readFileSync(path.join(dest, tocKey))), previous.loaders[tocKey], `modified obsolete loader: ${tocKey}`);
			fs.unlinkSync(path.join(dir, 'Pages.lua'));
			fs.unlinkSync(path.join(dir, `${name}.toc`));
			fs.rmdirSync(dir);
		}
	}
	for (const [map, folder] of Object.entries(part)) {
		const key = full(`${folder}/TerminalGround.lua`);
		if (fs.existsSync(path.join(dest, key))) {
			pinned(dest, key, terminal[map]);
			fs.unlinkSync(path.join(dest, key));
		}
	}
	Object.assign(manifest, { files, loaders, regions: [...regions.keys()].sort(), import: { command: 'node tools/lib/nav/import-regions.js', manifestSha256: inputManifest, terminalSha256: terminal } });
	write('Polestar_Nav/PACK.json',Buffer.from(JSON.stringify(manifest,null,'\t')+'\n'));
	console.log(`${regions.size} regions, ${Object.keys(files).length} data parts, ${Object.keys(loaders).length} loaders`);
}
if (require.main === module) {
	const [source, dest] = process.argv.slice(2);
	assert(source && dest, 'usage: node tools/lib/nav/import-regions.js <derived AddOns> <output AddOns>');
	importRegions(source,dest);
}
