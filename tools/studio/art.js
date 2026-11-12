'use strict';
// The studio's local client art cache: Blizzard art read from the Forever
// client's files for local renders only, never committed, never uploaded.
//
// The folder ($POLESTAR_STUDIO_ART, else $XDG_CACHE_HOME/polestar-art, else
// ~/.cache/polestar-art) holds, as tools/preview's TextureCache and
// tools/play's Session read them:
//   <fileID>.tga       decoded textures (icons, UI sheets, map tiles)
//   maps.json          { [uiMapID]: { artID, layer, textures } } (zone art; {} when none)
//   atlases.json       { [lower-case atlas element]: { file, w, h, l, r, t, b } }
//   files.json         { [lower-case "interface\\...\\name"]: fileID }
//   fonts/<FILE>.TTF   the client's fonts (FRIZQT__.TTF: the game font)
//   casc/              raw client files by fileID (tools/lib/planner/art/casc.js)
//   tables/<build>/    client tables (wago.tools CSV) the stub data needs that
//                      data/sources/wago lacks
//
//   art.dir() -> the folder (created, with an empty maps.json)
//   await art.pull([fid | atlas element | interface path, ...], { offline }) -> { got, missing }
//   art.importDir(dir) -> counts      (an older cache: tools/preview's POLESTAR_CLIENT_ART, ...)
//   art.status() -> { dir, textures, atlases, files, maps, fonts }

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const { ROOT } = require('../lib/paths');

const BUILD = '1.60.1.70532';
const PRODUCT = 'wow_classic_beta';

function dir() {
	const d = process.env.POLESTAR_STUDIO_ART
		|| path.join(process.env.XDG_CACHE_HOME || path.join(os.homedir(), '.cache'), 'polestar-art');
	fs.mkdirSync(path.join(d, 'fonts'), { recursive: true });
	if (!fs.existsSync(path.join(d, 'maps.json'))) fs.writeFileSync(path.join(d, 'maps.json'), '{}');
	if (path.resolve(d).startsWith(path.resolve(ROOT) + path.sep) && !path.resolve(d).startsWith(path.join(path.resolve(ROOT), 'data', 'local') + path.sep)) {
		throw new Error(`studio: the art cache ${d} is inside the checkout; it holds Blizzard art and must stay out of the repository (use data/local/ or a folder outside)`);
	}
	return d;
}

function readJson(file, fallback) {
	try {
		return JSON.parse(fs.readFileSync(file, 'utf8'));
	} catch {
		return fallback;
	}
}

const has = (d, fid) => fs.existsSync(path.join(d, `${fid}.tga`));

function writeTga(file, w, h, rgba) {
	const b = Buffer.alloc(18 + w * h * 4);
	b[2] = 2;
	b.writeUInt16LE(w, 12);
	b.writeUInt16LE(h, 14);
	b[16] = 32;
	b[17] = 0x28;
	for (let i = 0; i < w * h; i++) {
		b[18 + i * 4] = rgba[i * 4 + 2];
		b[18 + i * 4 + 1] = rgba[i * 4 + 1];
		b[18 + i * 4 + 2] = rgba[i * 4];
		b[18 + i * 4 + 3] = rgba[i * 4 + 3];
	}
	fs.writeFileSync(file, b);
}

// A name -> file ID: a number, an atlas element, or an interface path.
function resolveName(d, name) {
	if (typeof name === 'number' || /^\d+$/.test(String(name))) return Number(name);
	const key = String(name).toLowerCase();
	const atlas = readJson(path.join(d, 'atlases.json'), {})[key];
	if (atlas) return atlas.file;
	const fid = readJson(path.join(d, 'files.json'), {})[key.replace(/\//g, '\\').replace(/\.blp$/, '')];
	return fid || null;
}

// Decodes the client files `names` into the cache (each fetched once, from
// wago.tools' copy of the Forever build; `offline`: from the casc/ folder only).
async function pull(names, { offline = false } = {}) {
	const d = dir();
	const want = new Set();
	const missing = [];
	for (const n of names) {
		const fid = resolveName(d, n);
		if (fid) want.add(fid);
		else missing.push(String(n));
	}
	const todo = [...want].filter((fid) => !has(d, fid));
	if (todo.length) {
		const { openCasc } = require('../lib/planner/art/casc');
		const { decodeBlp } = require('../lib/planner/art/blp');
		const casc = await openCasc({ sourcesDir: d, product: PRODUCT, build: BUILD, offline });
		for (const fid of todo) {
			try {
				const blp = decodeBlp(await casc.get(fid), { levels: 1 });
				const m = blp.mips[0];
				writeTga(path.join(d, `${fid}.tga`), m.width, m.height, Buffer.from(m.rgba.buffer, m.rgba.byteOffset, m.rgba.byteLength));
			} catch (err) {
				missing.push(`${fid} (${err.message})`);
			}
		}
	}
	return { got: [...want].filter((fid) => has(d, fid)), missing };
}

// Copies another cache's textures, fonts and tables in (reflinked where the
// file system can), and merges its maps/atlases/files lists.
function importDir(src) {
	const d = dir();
	const out = { textures: 0, fonts: 0, lists: [] };
	for (const f of fs.readdirSync(src)) {
		const from = path.join(src, f);
		if (/^\d+\.tga$/.test(f) && !fs.existsSync(path.join(d, f))) {
			fs.copyFileSync(from, path.join(d, f), fs.constants.COPYFILE_FICLONE);
			out.textures++;
		} else if (/\.ttf$/i.test(f) && fs.statSync(from).isFile()) {
			fs.copyFileSync(from, path.join(d, 'fonts', f.toUpperCase().replace(/\.TTF$/, '.TTF')), fs.constants.COPYFILE_FICLONE);
			out.fonts++;
		} else if (['maps.json', 'atlases.json', 'files.json'].includes(f)) {
			const merged = { ...readJson(path.join(d, f), {}), ...readJson(from, {}) };
			fs.writeFileSync(path.join(d, f), JSON.stringify(merged));
			out.lists.push(`${f} (${Object.keys(merged).length})`);
		}
	}
	return out;
}

function status() {
	const d = dir();
	const files = fs.readdirSync(d);
	return {
		dir: d,
		textures: files.filter((f) => /^\d+\.tga$/.test(f)).length,
		atlases: Object.keys(readJson(path.join(d, 'atlases.json'), {})).length,
		files: Object.keys(readJson(path.join(d, 'files.json'), {})).length,
		maps: Object.keys(readJson(path.join(d, 'maps.json'), {})).length,
		fonts: fs.readdirSync(path.join(d, 'fonts')),
	};
}

// The client font file `name` ("FRIZQT__.TTF") in the cache, or null.
function font(name) {
	const f = path.join(dir(), 'fonts', name);
	return fs.existsSync(f) ? f : null;
}

module.exports = { dir, pull, importDir, status, font, readJson, has, BUILD };
