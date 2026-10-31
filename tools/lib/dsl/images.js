'use strict';
// Step pictures (docs/GUIDE_FORMAT.md, `image`): a TGA or BLP file in the
// pack folder, shown in the step's tip area of the guide window.
//
// parseImagePath(text) -> { path, ext } | { error, hint }
//   the path rules (the runtime's in Core/Guides.lua, checkImage): inside the
//   pack folder, folders and the name of letters, digits, `_` and `-`
//   separated by `/`, a `.tga` or `.blp` extension or none. `path` has no
//   extension; `ext` is the one written (lower case) or null.
// checkImages(guides, packDir, diag) — compile time, before the guides'
//   texts are tokenised: finds each step's file in the pack folder (a warning
//   when it is not there), fills in the size the author left out from the
//   file's header, and warns about a size that is not a power of two.
// imageFiles(guides) -> [[rel, abs]] — the files the addon folder carries,
//   sorted by rel, each at its path in the pack folder.

const fs = require('node:fs');
const path = require('node:path');

// The texture files the client draws for an addon.
const IMAGE_EXTS = ['.tga', '.blp'];
const SEGMENT_RE = /^[A-Za-z0-9_-]+$/;
const SIZE_RE = /^(\d+)x(\d+)$/;
const EXAMPLE = 'image media/fargodeep-mine.tga';

function parseImagePath(text) {
	const s = String(text);
	const shown = `image path "${s}"`;
	if (/^[\\/]/.test(s) || /^[A-Za-z]:/.test(s)) return { error: `${shown} is absolute`, hint: `write it from the pack folder: \`${EXAMPLE}\`` };
	if (s.includes('\\')) return { error: `${shown} has a \\`, hint: `separate folders with /: \`${EXAMPLE}\`` };
	const parts = s.split('/');
	if (parts.some((p) => p === '..' || p === '.')) return { error: `${shown} leaves the pack folder`, hint: `put the picture inside the pack folder and write its path from there: \`${EXAMPLE}\`` };
	const last = parts[parts.length - 1];
	const dot = last.lastIndexOf('.');
	let ext = null;
	if (dot >= 0) {
		ext = last.slice(dot).toLowerCase();
		if (!IMAGE_EXTS.includes(ext)) return { error: `${shown}: the game draws .tga and .blp pictures, not ${ext}`, hint: 'save the picture as a .tga file (or .blp)' };
		parts[parts.length - 1] = last.slice(0, dot);
	}
	if (parts.some((p) => !SEGMENT_RE.test(p))) return { error: `${shown} has a character the game's paths do not take`, hint: 'name the folders and the file with letters, digits, _ and - only' };
	return { path: parts.join('/'), ext };
}

// "512x256" -> { w, h } | null.
function parseImageSize(text) {
	const m = SIZE_RE.exec(String(text));
	if (!m) return null;
	const w = Number(m[1]);
	const h = Number(m[2]);
	return w > 0 && h > 0 ? { w, h } : null;
}

// The file a step's picture names (spec: parseImagePath's), found in the
// pack folder: the extension written, else .tga, then .blp; the name as
// written, the extension in any case. A folder that is a link out of the
// pack folder holds none. -> absolute path | null.
function findImage(packDir, spec) {
	const parts = spec.path.split('/');
	const name = parts.pop();
	const dir = path.join(packDir, ...parts);
	let entries;
	try {
		const rel = path.relative(fs.realpathSync(packDir), fs.realpathSync(dir));
		if (rel.startsWith('..') || path.isAbsolute(rel)) return null;
		entries = fs.readdirSync(dir, { withFileTypes: true });
	} catch {
		return null;
	}
	for (const ext of spec.ext ? [spec.ext] : IMAGE_EXTS) {
		const hit = entries.find((e) => e.isFile() && e.name.length === name.length + ext.length && e.name.startsWith(name) && e.name.slice(name.length).toLowerCase() === ext);
		if (hit) return path.join(dir, hit.name);
	}
	return null;
}

// A TGA's or BLP's size from its header -> { w, h } | null. TGA: 16-bit
// width and height at bytes 12 and 14; BLP1/BLP2: 32-bit at 12 and 16.
function imageSize(file) {
	let buf;
	try {
		const fd = fs.openSync(file, 'r');
		try {
			buf = Buffer.alloc(20);
			buf = buf.subarray(0, fs.readSync(fd, buf, 0, 20, 0));
		} finally {
			fs.closeSync(fd);
		}
	} catch {
		return null;
	}
	const magic = buf.subarray(0, 4).toString('latin1');
	let w = 0;
	let h = 0;
	if ((magic === 'BLP1' || magic === 'BLP2') && buf.length >= 20) {
		w = buf.readUInt32LE(12);
		h = buf.readUInt32LE(16);
	} else if (path.extname(file).toLowerCase() === '.tga' && buf.length >= 18 && [1, 2, 3, 9, 10, 11].includes(buf[2])) {
		w = buf.readUInt16LE(12);
		h = buf.readUInt16LE(14);
	}
	return w > 0 && h > 0 ? { w, h } : null;
}

function powerOfTwo(n) {
	return n > 0 && (n & (n - 1)) === 0;
}

function checkImages(guides, packDir, diag) {
	for (const g of guides) {
		const file = g._ast && g._ast.file;
		for (const step of g.steps || []) {
			const spec = step._imageSpec;
			if (!spec || !step.image) continue;
			const where = spec.path + (spec.ext || '');
			const abs = findImage(packDir, spec);
			if (!abs) {
				const tried = spec.ext ? `${spec.path}${spec.ext}` : IMAGE_EXTS.map((e) => `${spec.path}${e}`).join(' or ');
				diag.warn(file, spec.line, `image ${where}: the pack folder has no ${tried}, so the step shows no picture`, 'put the picture in the pack folder at that path (a .tga or .blp file), or fix the path');
				continue;
			}
			const rel = path.relative(packDir, abs).split(path.sep).join('/');
			hidden(step, '_imageFile', { abs, rel });
			const size = imageSize(abs);
			if (!size) {
				if (step.image.w === undefined) diag.warn(file, spec.line, `image ${rel} is not a TGA or BLP picture Polestar can read the size of`, 'save it as a .tga file, or give its size: `image <path> <width>x<height>`');
				continue;
			}
			if (!powerOfTwo(size.w) || !powerOfTwo(size.h)) {
				diag.warn(file, spec.line, `image ${rel} is ${size.w}x${size.h}: the game may not draw a texture whose sides are not powers of two`, 'save it at a size such as 512x256 or 512x512');
			}
			if (step.image.w === undefined) {
				step.image.w = size.w;
				step.image.h = size.h;
			}
		}
	}
}

function imageFiles(guides) {
	const out = new Map();
	for (const g of guides) {
		for (const step of g.steps || []) {
			const f = step._imageFile;
			if (f) out.set(f.rel, f.abs);
		}
	}
	return [...out].sort((a, b) => (a[0] < b[0] ? -1 : a[0] > b[0] ? 1 : 0));
}

function hidden(obj, key, value) {
	Object.defineProperty(obj, key, { value, enumerable: false, configurable: true, writable: true });
}

module.exports = { IMAGE_EXTS, parseImagePath, parseImageSize, checkImages, imageFiles, imageSize };
