'use strict';
// node tools/lib/nav/import-regions.js <derived AddOns folder> <output AddOns folder>
// Import the reviewed, already baked 70532 walking maps, never client archives, player files or addon code.
// Input pins cover the forge nav pack after the reviewed occupied_floor cluster rebuilds (forge-nav/examples)
// and the three derived terminal-mask sidecars. PACK.json records the manifest before the rebuild as well.
// The region transform is lossless: neither floor topology nor the compressed evidence pages are recomputed.
// Each region's pages travel as one string in its continent's part (Polestar_Nav itself for map 2991), which
// Routing/PathGrid.lua (unpackRegion) turns back into the same page strings the first time a walk needs one.
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');

const sha = bytes => crypto.createHash('sha256').update(bytes).digest('hex');
const hash = (key, bytes) => key.endsWith('.toc')
	? sha(bytes.toString('utf8').split('\n').filter(l => !/^## (?:Version|(?:Title|Notes)(?:-[a-z]{2}[A-Z]{2})?):/.test(l)).join('\n'))
	: sha(bytes);
const inputManifest = '2517c1d6771f0bc311be697d623034773622e803f94444b2531ba136b6c33cf5';
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
		// A cost search needs coarse floors but not a sector's detailed local geometry: even rows hold
		// floors and odd rows evidence for the same 8 x 4 tiles, each unpacked on its own first use.
		const r = 2 * Math.floor(row / 8) + (floorPages ? 0 : 1), c = Math.floor(col / 4);
		assert(r >= 0 && r < 16 && c >= 0 && c < 16, `bad tile: ${map}:${row}:${col}`);
		const name = `${map}_${r}_${c}`;
		if (!regions.has(name)) regions.set(name, { map, r, c, fields: new Map() });
		return [regions.get(name), 16 * r + c];
	}
	function add(group, field, index, value) {
		if (!group.fields.has(field)) group.fields.set(field, []);
		group.fields.get(field).push([index, value]);
	}
	// A packed floor entry's Lua table of block literals ({"...", "..."}) as its blocks' bytes.
	function blocks(rhs) {
		const parts = [], re = /"((?:[^"\\]|\\\d{3})*)"/g;
		for (let m; (m = re.exec(rhs));) parts.push(Buffer.from(m[1].replace(/\\(\d{3})/g, (_, d) => String.fromCharCode(Number(d))), 'latin1'));
		assert.equal(`{${parts.map(p => `"${literal(p)}"`).join(', ')}}`, rhs, 'unrecognized floor blocks');
		return parts;
	}
	// One region as one string: its fields' names ("packed.floor,localWalk.ground:"), then each page: its
	// field (1 byte, from 1), key (3), block count (1; 0 for a lone string rather than a list of blocks), and
	// each block's length (3) before its bytes.
	function blob(fields) {
		const names = [...fields.keys()], out = [Buffer.from(`${names.join(',')}:`, 'latin1')];
		names.forEach((field, f) => {
			for (const [key, value] of fields.get(field)) {
				const list = Array.isArray(value) ? value : [value];
				assert(Number.isInteger(key) && key >= 0 && key < 2 ** 24 && list.length > 0 && list.length < 256, `bad page: ${field}[${key}]`);
				const head = Buffer.alloc(5);
				head[0] = f + 1; head.writeUIntBE(key, 1, 3); head[4] = Array.isArray(value) ? list.length : 0;
				out.push(head);
				for (const b of list) {
					assert(b.length < 2 ** 24);
					const size = Buffer.alloc(3);
					size.writeUIntBE(b.length, 0, 3);
					out.push(size, b);
				}
			}
		});
		return Buffer.concat(out);
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
			add(group, member, k, raw);
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
			index = `data.localWalk={}\ndata.detailMap=${map}\ndata.regions={}\n`;
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
			add(group,'packed.floor',Number(key),blocks(rhs));
			return `data.packed.floor[${key}] = ${id}`;
		});
		if (first || text.length !== bytes.length) text = text.replace('Do not edit: rebuild with that command.', 'Regional layout: node tools/lib/nav/import-regions.js.');
		write(key, Buffer.from(text+index,'latin1'), files);
	}
	for (const [name, {map, r, c, fields}] of [...regions].sort(([a],[b]) => a < b ? -1 : 1)) {
		const lines = [
			`-- Generated by \`node tools/lib/nav/import-regions.js\`: map ${map}, region ${r},${c}, derived walking grid ${manifest.grid.build}, packed ${manifest.date}.`,
			'-- Its pages as one string, unpacked by Routing/PathGrid.lua the first time a walk needs one of them.',
			`local d = PolestarPathData and PolestarPathData[${map}]`,
			`if d and d.regions then d.regions[${16 * r + c}] = "${literal(blob(fields))}" end`,
		];
		write(map === 2991 ? `Nav/Region${name}.lua` : `${part[map]}/Region${name}.lua`, Buffer.from(lines.join('\n')+'\n','latin1'), files);
	}
	write('Polestar_Nav/Polestar_Nav.toc', Buffer.from(toc), loaders);
	const navFiles = Object.keys(files).filter(k => k.startsWith('Nav/')).map(k => k.slice(4));
	const scripts = navFiles.filter(n => n !== 'Chokepoints.lua').concat(navFiles.filter(n => n === 'Chokepoints.lua'));
	write('Nav/Nav.xml', Buffer.from(['<Ui xmlns="http://www.blizzard.com/wow/ui/">', `\t<!-- Written by ${manifest.generator}: Polestar's walking maps (PACK.json), then the chokepoints. -->`, ...scripts.map(n => `\t<Script file="${n}"/>`), '</Ui>', ''].join('\n')), loaders);
	for (const folder of [part[0], part[1]]) {
		const key = `${folder}/${folder}.toc`;
		const head = fs.readFileSync(path.join(dest,key),'utf8').split('\n').filter(l => l.startsWith('#'));
		const names = Object.keys(files).filter(k => k.startsWith(folder+'/')).map(k => k.split('/')[1]);
		write(key,Buffer.from([...head,'',...names,''].join('\n')),loaders);
	}
	// 0.4.2 shipped each region as its own load-on-demand addon (Polestar_Nav_R<map>_<row>_<col>). Remove
	// those folders when they are exactly what that import wrote; anything else must be reconciled by hand.
	if (previous.import && previous.import.manifestSha256 === inputManifest && Array.isArray(previous.regions)) {
		for (const name of previous.regions) {
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
	delete manifest.regions;
	Object.assign(manifest, { files, loaders, import: { command: 'node tools/lib/nav/import-regions.js', manifestSha256: inputManifest, terminalSha256: terminal } });
	write('Polestar_Nav/PACK.json',Buffer.from(JSON.stringify(manifest,null,'\t')+'\n'));
	console.log(`${regions.size} regions, ${Object.keys(files).length} data parts, ${Object.keys(loaders).length} loaders`);
}
if (require.main === module) {
	const [source, dest] = process.argv.slice(2);
	assert(source && dest, 'usage: node tools/lib/nav/import-regions.js <derived AddOns> <output AddOns>');
	importRegions(source,dest);
}
