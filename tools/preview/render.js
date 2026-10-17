'use strict';
// Draws a frame dump (tools/preview/stub.lua) as SVG: resolves anchors the way
// the client does, orders frames by strata and level and regions by layer,
// tints the addon's real TGA textures, and sets text as Inter glyph paths with
// the client's wrapping, justification, colour codes and shadows.

const fs = require('node:fs');
const path = require('node:path');
const { deflate } = require('./deflate');

const H = { LEFT: 0, CENTER: 0.5, RIGHT: 1, TOPLEFT: 0, TOP: 0.5, TOPRIGHT: 1, BOTTOMLEFT: 0, BOTTOM: 0.5, BOTTOMRIGHT: 1 };
const V = { TOP: 0, CENTER: 0.5, BOTTOM: 1, TOPLEFT: 0, LEFT: 0.5, TOPRIGHT: 0, RIGHT: 0.5, BOTTOMLEFT: 1, BOTTOMRIGHT: 1 };
const STRATA = { BACKGROUND: 0, LOW: 1, MEDIUM: 2, HIGH: 3, DIALOG: 4, FULLSCREEN: 5, FULLSCREEN_DIALOG: 6, TOOLTIP: 7 };
const LAYER = { BACKGROUND: 0, BORDER: 1, ARTWORK: 2, OVERLAY: 3, HIGHLIGHT: 4 };
// Regions draw inside their frame; a Line is one, with its own two ends.
const isRegion = (o) => o.kind === 'Texture' || o.kind === 'FontString' || o.kind === 'Line';

// ---------------------------------------------------------------------------
// Textures

function readTGA(file) {
	const b = fs.readFileSync(file);
	const w = b.readUInt16LE(12), h = b.readUInt16LE(14);
	const topLeft = (b[17] & 0x20) !== 0;
	const px = Buffer.alloc(w * h * 4);
	for (let y = 0; y < h; y++) {
		const sy = topLeft ? y : h - 1 - y;
		for (let x = 0; x < w; x++) {
			const s = 18 + (sy * w + x) * 4, d = (y * w + x) * 4;
			px[d] = b[s + 2]; px[d + 1] = b[s + 1]; px[d + 2] = b[s]; px[d + 3] = b[s + 3];
		}
	}
	return { w, h, px };
}

const CRC = (() => {
	const t = new Uint32Array(256);
	for (let n = 0; n < 256; n++) {
		let c = n;
		for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
		t[n] = c >>> 0;
	}
	return t;
})();
function crc32(buf) {
	let c = 0xffffffff;
	for (const v of buf) c = CRC[(c ^ v) & 0xff] ^ (c >>> 8);
	return (c ^ 0xffffffff) >>> 0;
}
function png(w, h, rgba) {
	const chunk = (type, data) => {
		const len = Buffer.alloc(4);
		len.writeUInt32BE(data.length);
		const td = Buffer.concat([Buffer.from(type, 'latin1'), data]);
		const crc = Buffer.alloc(4);
		crc.writeUInt32BE(crc32(td));
		return Buffer.concat([len, td, crc]);
	};
	const ihdr = Buffer.alloc(13);
	ihdr.writeUInt32BE(w, 0);
	ihdr.writeUInt32BE(h, 4);
	ihdr[8] = 8; ihdr[9] = 6;
	const raw = Buffer.alloc((w * 4 + 1) * h);
	for (let y = 0; y < h; y++) rgba.copy(raw, y * (w * 4 + 1) + 1, y * w * 4, (y + 1) * w * 4);
	return Buffer.concat([Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]), chunk('IHDR', ihdr), chunk('IDAT', deflate(raw)), chunk('IEND', Buffer.alloc(0))]);
}

class TextureCache {
	// clientArt: an optional folder of client textures decoded to <fileID>.tga
	// (local previews only; never committed). Without it, client-file
	// textures are not drawn.
	constructor(mediaDir, clientArt = null) {
		this.dir = mediaDir;
		this.clientArt = clientArt;
		this.src = new Map();
		this.uris = new Map();
	}
	load(name) {
		if (!this.src.has(name)) {
			const fid = /^fid:(\d+)$/.exec(name);
			// "Nav/<name>": Polestar's Media/Nav textures (pins, glow, arrow).
			const nav = /^Nav\/([\w-]+)$/.exec(name);
			const file = fid ? (this.clientArt ? path.join(this.clientArt, `${fid[1]}.tga`) : null)
				: nav ? path.join(this.dir, '..', 'Nav', nav[1] + '.tga') : path.join(this.dir, name + '.tga');
			this.src.set(name, file && fs.existsSync(file) ? readTGA(file) : null);
		}
		return this.src.get(name);
	}
	// A tinted, cropped (and optionally desaturated) PNG data URI.
	uri(name, tint, tc, desat = 0) {
		const key = `${name}|${tint.join(',')}|${tc ? tc.join(',') : ''}|${desat}`;
		if (this.uris.has(key)) return this.uris.get(key);
		const t = this.load(name);
		if (!t) return null;
		let [l, r, top, bottom] = tc ? (tc.length >= 8 ? [tc[0], tc[6], tc[1], tc[7]] : tc) : [0, 1, 0, 1];
		const x0 = Math.round(l * t.w), x1 = Math.round(r * t.w), y0 = Math.round(top * t.h), y1 = Math.round(bottom * t.h);
		const w = Math.max(1, x1 - x0), h = Math.max(1, y1 - y0);
		const out = Buffer.alloc(w * h * 4);
		for (let y = 0; y < h; y++) {
			for (let x = 0; x < w; x++) {
				const s = ((y0 + y) * t.w + (x0 + x)) * 4, d = (y * w + x) * 4;
				let cr = t.px[s], cg = t.px[s + 1], cb = t.px[s + 2];
				if (desat > 0) {
					const lum = 0.299 * cr + 0.587 * cg + 0.114 * cb;
					cr += (lum - cr) * desat;
					cg += (lum - cg) * desat;
					cb += (lum - cb) * desat;
				}
				out[d] = Math.round(cr * tint[0]);
				out[d + 1] = Math.round(cg * tint[1]);
				out[d + 2] = Math.round(cb * tint[2]);
				out[d + 3] = Math.round(t.px[s + 3] * tint[3]);
			}
		}
		const u = 'data:image/png;base64,' + png(w, h, out).toString('base64');
		this.uris.set(key, u);
		return u;
	}
}

// ---------------------------------------------------------------------------
// Layout

function measure(fonts, font, text) {
	const f = fonts[font[0]];
	let w = 0;
	for (const ch of text) w += f.advanceEm(ch.codePointAt(0));
	return w * font[1];
}

function plain(s) {
	return String(s ?? '').replace(/\|\|/g, '\u0001').replace(/\|c[0-9a-fA-F]{8}/g, '').replace(/\|r/g, '').replace(/\u0001/g, '|');
}

// Greedy wrap, same rule as stub.lua: at spaces, and between any two CJK
// characters (ideographs, kana, their punctuation), as the client wraps them.
const CJK = /[\u2e80-\u9fff\uf900-\ufaff\ufe30-\ufe4f\uff00-\uffef]/u;
const PIECES = /[\u2e80-\u9fff\uf900-\ufaff\ufe30-\ufe4f\uff00-\uffef]|[^\u2e80-\u9fff\uf900-\ufaff\ufe30-\ufe4f\uff00-\uffef]+/gu;
function wrap(fonts, font, text, width) {
	const lines = [];
	for (const para of text.split('\n')) {
		let line = '';
		for (const word of para.split(/\s+/).filter(Boolean)) {
			const pieces = CJK.test(word) ? word.match(PIECES) : [word];
			pieces.forEach((piece, i) => {
				const cand = line ? line + (i === 0 ? ' ' : '') + piece : piece;
				if (line && measure(fonts, font, cand) > width + 0.01) {
					lines.push(line);
					line = piece;
				} else line = cand;
			});
		}
		lines.push(line);
	}
	return lines;
}

function resolve(objects, fonts) {
	// Lua's empty tables arrive as {}.
	for (const o of objects) if (!Array.isArray(o.points)) o.points = [];
	const byId = new Map(objects.map((o) => [o.id, o]));
	const scrollParent = new Map();
	for (const o of objects) if (o.scrollChild) scrollParent.set(o.scrollChild, o);

	const effScale = new Map();
	const scaleOf = (o) => {
		if (effScale.has(o.id)) return effScale.get(o.id);
		const p = o.parent != null ? byId.get(o.parent) : null;
		const s = (isRegion(o) ? 1 : o.scale || 1) * (p ? scaleOf(p) : 1);
		effScale.set(o.id, s);
		return s;
	};

	// Intrinsic text size.
	for (const o of objects) {
		if (o.kind !== 'FontString') continue;
		const text = plain(o.text);
		o.plain = text;
		const hasH = o.points.some((p) => H[p.point] === 0) && o.points.some((p) => H[p.point] === 1);
		o.intrinsicW = Math.max(0, ...text.split('\n').map((l) => measure(fonts, o.font, l)));
		o.anchoredW = hasH;
	}

	const rects = new Map();
	const visiting = new Set();
	function rectOf(o) {
		if (rects.has(o.id)) return rects.get(o.id);
		if (visiting.has(o.id)) return { x: 0, y: 0, w: 0, h: 0 };
		visiting.add(o.id);
		const s = scaleOf(o);
		const parent = o.parent != null ? byId.get(o.parent) : null;
		let r;
		const sp = scrollParent.get(o.id);
		if (o.name === 'UIParent') r = { x: 0, y: 0, w: o.w || 1920, h: o.h || 1080 };
		else if (sp) {
			const pr = rectOf(sp);
			r = { x: pr.x, y: pr.y - (sp.vscroll || 0) * s, w: (o.w || 0) * s, h: (o.h || 0) * s };
		} else if (!o.points.length) {
			const pr = parent ? rectOf(parent) : { x: 0, y: 0, w: 0, h: 0 };
			r = { x: pr.x, y: pr.y, w: (o.w || 0) * s, h: (o.h || 0) * s };
		} else {
			let left = null, right = null, top = null, bottom = null, cx = null, cy = null;
			for (const p of o.points) {
				const rel = p.rel != null ? byId.get(p.rel) : parent;
				const base = rel ? rectOf(rel) : { x: 0, y: 0, w: 0, h: 0 };
				const ax = base.x + base.w * (H[p.relPoint] ?? 0) + p.x * s;
				const ay = base.y + base.h * (V[p.relPoint] ?? 0) - p.y * s;
				const hx = H[p.point] ?? 0, vy = V[p.point] ?? 0;
				if (hx === 0) left = ax; else if (hx === 1) right = ax; else cx = ax;
				if (vy === 0) top = ay; else if (vy === 1) bottom = ay; else cy = ay;
			}
			let w = left !== null && right !== null ? right - left : (o.w != null ? o.w * s : null);
			let h = top !== null && bottom !== null ? bottom - top : (o.h != null ? o.h * s : null);
			if (o.kind === 'FontString') {
				if (w == null) w = o.intrinsicW * s;
				const lw = w / s;
				const lines = o.wrap && lw > 0 ? wrap(fonts, o.font, o.plain, lw) : o.plain.split('\n');
				o.lines = o.maxLines ? lines.slice(0, o.maxLines) : lines;
				if (h == null) h = (o.lines.length * o.font[1] + (o.lines.length - 1) * (o.spacing || 0)) * s;
			}
			w = w ?? 0;
			h = h ?? 0;
			if (left === null) left = right !== null ? right - w : cx !== null ? cx - w / 2 : 0;
			if (top === null) top = bottom !== null ? bottom - h : cy !== null ? cy - h / 2 : 0;
			r = { x: left, y: top, w, h };
		}
		if (o.kind === 'FontString' && !o.lines) {
			const lw = r.w / s;
			o.lines = o.wrap && lw > 0 ? wrap(fonts, o.font, o.plain, lw) : o.plain.split('\n');
		}
		visiting.delete(o.id);
		rects.set(o.id, r);
		return r;
	}
	for (const o of objects) rectOf(o);

	// Slider thumbs sit where the value puts them.
	for (const o of objects) {
		if (!o.thumbTexture) continue;
		const t = byId.get(o.thumbTexture);
		const sr = rects.get(o.id);
		const s = scaleOf(t);
		const tw = (t.w || 0) * s, th = (t.h || 0) * s;
		const lo = o.minValue ?? 0, hi = o.maxValue ?? 1;
		const frac = hi > lo ? Math.min(1, Math.max(0, ((o.value ?? lo) - lo) / (hi - lo))) : 0;
		rects.set(t.id, { x: sr.x + frac * (sr.w - tw), y: sr.y + (sr.h - th) / 2, w: tw, h: th });
	}
	return { byId, rects, scaleOf };
}

// ---------------------------------------------------------------------------
// Drawing

const f2 = (v) => (Math.round(v * 100) / 100).toString();
function rgba(c, alpha = 1) {
	const [r, g, b, a = 1] = c;
	return { fill: `rgb(${Math.round(r * 255)},${Math.round(g * 255)},${Math.round(b * 255)})`, opacity: Math.max(0, Math.min(1, a * alpha)) };
}

function textureName(p) {
	if (p === null || p === undefined) return null;
	// A client file id (map tiles, icons): drawn only from a local art cache.
	if (typeof p === 'number' || /^\d+$/.test(String(p))) return `fid:${p}`;
	const m = /Polestar\\Media\\UI\\([\w-]+)$/.exec(p);
	if (m) return m[1];
	const nav = /Polestar\\Media\\Nav\\([\w-]+)$/.exec(p);
	if (nav) return `Nav/${nav[1]}`;
	if (/WHITE8X8/i.test(p)) return 'white';
	return null;
}

// Parse a string with |c..|r codes into coloured runs per line.
function runs(line, base) {
	const out = [];
	const stack = [];
	let color = base;
	let buf = '';
	const s = line.replace(/\|\|/g, '\u0001');
	for (let i = 0; i < s.length; ) {
		if (s[i] === '|' && s[i + 1] === 'c' && /^[0-9a-fA-F]{8}$/.test(s.slice(i + 2, i + 10))) {
			if (buf) out.push({ text: buf, color });
			buf = '';
			stack.push(color);
			const hex = s.slice(i + 4, i + 10);
			color = [parseInt(hex.slice(0, 2), 16) / 255, parseInt(hex.slice(2, 4), 16) / 255, parseInt(hex.slice(4, 6), 16) / 255, base[3]];
			i += 10;
		} else if (s[i] === '|' && s[i + 1] === 'r') {
			if (buf) out.push({ text: buf, color });
			buf = '';
			color = stack.pop() || base;
			i += 2;
		} else {
			buf += s[i] === '\u0001' ? '|' : s[i];
			i += 1;
		}
	}
	if (buf) out.push({ text: buf, color });
	return out;
}

// Map wrapped plain lines back onto the coloured source, so colours survive
// wrapping: walk the source and the plain lines together.
function colouredLines(src, lines, base) {
	const all = runs(String(src ?? '').replace(/\n/g, ' \n '), base);
	const chars = [];
	for (const r of all) for (const ch of r.text) chars.push({ ch, color: r.color });
	const out = [];
	let k = 0;
	for (const line of lines) {
		const lr = [];
		for (const ch of line) {
			while (k < chars.length && chars[k].ch !== ch) k++;
			const c = k < chars.length ? chars[k].color : base;
			const last = lr[lr.length - 1];
			if (last && last.color === c) last.text += ch;
			else lr.push({ text: ch, color: c });
			k++;
		}
		out.push(lr);
	}
	return out;
}

// roots: frame names to draw (with their descendants), or a predicate on a
// dumped object. viewport: { x, y, w, h } in screen pixels to draw instead of
// the roots' bounding box (tools/play draws the whole screen).
function svg(dump, { fonts, textures, roots, margin = 28, prefix = 'p', shared, viewport = null }) {
	const objects = dump.objects;
	const { byId, rects, scaleOf } = resolve(objects, fonts);

	const isRoot = typeof roots === 'function' ? roots : (o) => roots.includes(o.name);
	const rootOf = new Map();
	const findRoot = (o) => {
		if (rootOf.has(o.id)) return rootOf.get(o.id);
		let cur = o, res = null;
		while (cur) {
			if (isRoot(cur)) { res = cur; break; }
			cur = cur.parent != null ? byId.get(cur.parent) : null;
		}
		rootOf.set(o.id, res);
		return res;
	};
	const visible = (o) => {
		let cur = o;
		while (cur) {
			if (!cur.shown) return false;
			cur = cur.parent != null ? byId.get(cur.parent) : null;
		}
		return true;
	};
	const alphaOf = (o) => {
		let a = 1, cur = o;
		while (cur) {
			a *= cur.alpha ?? 1;
			cur = cur.parent != null ? byId.get(cur.parent) : null;
		}
		return a;
	};

	// Frame order: strata, then level (explicit or parent + 1), then creation.
	const levels = new Map();
	const levelOf = (o) => {
		if (levels.has(o.id)) return levels.get(o.id);
		const p = o.parent != null ? byId.get(o.parent) : null;
		const l = o.level != null ? o.level : p ? levelOf(p) + 1 : 0;
		levels.set(o.id, l);
		return l;
	};
	const strataOf = (o) => {
		let cur = o;
		while (cur) {
			if (cur.strata) return STRATA[cur.strata] ?? 2;
			cur = cur.parent != null ? byId.get(cur.parent) : null;
		}
		return 2;
	};

	const frames = objects.filter((o) => !isRegion(o) && findRoot(o) && visible(o));
	frames.sort((a, b) => strataOf(a) - strataOf(b) || levelOf(a) - levelOf(b) || a.seq - b.seq);
	const regionsOf = new Map();
	for (const o of objects) {
		if (!isRegion(o)) continue;
		if (!regionsOf.has(o.parent)) regionsOf.set(o.parent, []);
		regionsOf.get(o.parent).push(o);
	}
	// Button state textures: the checked texture shows only when checked.
	const hiddenRegions = new Set();
	for (const o of objects) {
		if (o.checkedTexture && !o.checked) hiddenRegions.add(o.checkedTexture);
	}

	const clipOf = (o) => {
		let cur = o.parent != null ? byId.get(o.parent) : null;
		while (cur) {
			if (cur.clips) return cur;
			cur = cur.parent != null ? byId.get(cur.parent) : null;
		}
		return null;
	};

	// Bounding box of the roots (with shadow room).
	let bx0 = Infinity, by0 = Infinity, bx1 = -Infinity, by1 = -Infinity;
	for (const o of objects) {
		if (!isRoot(o) || !visible(o)) continue;
		const r = rects.get(o.id);
		bx0 = Math.min(bx0, r.x); by0 = Math.min(by0, r.y); bx1 = Math.max(bx1, r.x + r.w); by1 = Math.max(by1, r.y + r.h);
	}
	const ox = viewport ? viewport.x : bx0 - margin, oy = viewport ? viewport.y : by0 - margin;
	const W = viewport ? viewport.w : Math.ceil(bx1 - bx0 + margin * 2), Hh = viewport ? viewport.h : Math.ceil(by1 - by0 + margin * 2);

	const defs = [];
	const clipIds = new Map();
	const body = [];

	// A region inside nested clipping frames is clipped by all of them, as in
	// the client: the clip path is the intersection of their rects.
	const clipAttr = (o) => {
		const c = clipOf(o);
		if (!c) return '';
		if (!clipIds.has(c.id)) {
			const r0 = rects.get(c.id);
			let x0 = r0.x, y0 = r0.y, x1 = r0.x + r0.w, y1 = r0.y + r0.h;
			for (let a = clipOf(c); a; a = clipOf(a)) {
				const r = rects.get(a.id);
				x0 = Math.max(x0, r.x); y0 = Math.max(y0, r.y);
				x1 = Math.min(x1, r.x + r.w); y1 = Math.min(y1, r.y + r.h);
			}
			const id = `${prefix}c${c.id}`;
			defs.push(`<clipPath id="${id}"><rect x="${f2(x0 - ox)}" y="${f2(y0 - oy)}" width="${f2(Math.max(0, x1 - x0))}" height="${f2(Math.max(0, y1 - y0))}"/></clipPath>`);
			clipIds.set(c.id, id);
		}
		return ` clip-path="url(#${clipIds.get(c.id)})"`;
	};

	// A mask texture (AddMaskTexture) shows its texture's region only where
	// the mask's alpha is: an SVG mask over the mask's own rectangle, nothing
	// outside it (the client's CLAMPTOBLACKADDITIVE).
	const maskIds = new Map();
	const maskAttr = (o) => {
		const m = o.mask != null ? byId.get(o.mask) : null;
		const mr = m && rects.get(m.id);
		const name = m && textureName(m.texture);
		if (!mr || !name) return '';
		if (!maskIds.has(m.id)) {
			const id = `${prefix}m${m.id}`;
			const box = `x="${f2(mr.x - ox)}" y="${f2(mr.y - oy)}" width="${f2(mr.w)}" height="${f2(mr.h)}"`;
			const uri = name === 'white' ? null : textures.uri(name, [1, 1, 1, 1], null, 0);
			const shape = uri ? `<image ${box} preserveAspectRatio="none" href="${uri}"/>` : `<rect ${box} fill="#fff"/>`;
			defs.push(`<mask id="${id}" maskUnits="userSpaceOnUse" ${box}>${shape}</mask>`);
			maskIds.set(m.id, id);
		}
		return ` mask="url(#${maskIds.get(m.id)})"`;
	};

	const rect = (r, c, alpha, clip = '') => {
		const { fill, opacity } = rgba(c, alpha);
		if (opacity <= 0.001 || r.w <= 0 || r.h <= 0) return;
		body.push(`<rect x="${f2(r.x - ox)}" y="${f2(r.y - oy)}" width="${f2(r.w)}" height="${f2(r.h)}" fill="${fill}" fill-opacity="${f2(opacity)}"${clip}/>`);
	};
	const border = (r, c, alpha, clip = '') => {
		rect({ x: r.x, y: r.y, w: r.w, h: 1 }, c, alpha, clip);
		rect({ x: r.x, y: r.y + r.h - 1, w: r.w, h: 1 }, c, alpha, clip);
		rect({ x: r.x, y: r.y + 1, w: 1, h: r.h - 2 }, c, alpha, clip);
		rect({ x: r.x + r.w - 1, y: r.y + 1, w: 1, h: r.h - 2 }, c, alpha, clip);
	};

	// What EllesmereUI's primitives would paint (approximated from its look:
	// flat panel fill, 1px dark border, accent details).
	const accent = dump.accent || [0.05, 0.82, 0.62];
	const PANEL = [0.07, 0.07, 0.08, 0.95];
	function euiPaint(o, r, a, clip) {
		switch (o.euiSkin) {
			case 'Shell':
				rect({ x: r.x - 10, y: r.y - 10, w: r.w + 20, h: r.h + 20 }, [0, 0, 0, 0.18], a, clip);
				rect(r, PANEL, a, clip);
				border(r, [0, 0, 0, 1], a, clip);
				break;
			case 'Panel':
				rect(r, o.euiOpts && o.euiOpts.inset ? [0, 0, 0, 0.25] : PANEL, a, clip);
				if (!(o.euiOpts && o.euiOpts.noBorder)) border(r, [0, 0, 0, 1], a, clip);
				break;
			case 'Button':
				rect(r, [0.1, 0.1, 0.11, 0.95], a, clip);
				border(r, [0, 0, 0, 1], a, clip);
				break;
			case 'EditBox':
				rect(r, [0.02, 0.02, 0.02, 0.9], a, clip);
				border(r, [0, 0, 0, 1], a, clip);
				break;
			case 'Checkbox': {
				const b = { x: r.x + r.w / 2 - 7, y: r.y + r.h / 2 - 7, w: 14, h: 14 };
				rect(b, [0.03, 0.03, 0.03, 1], a, clip);
				border(b, [0.25, 0.25, 0.25, 1], a, clip);
				if (o.checked) rect({ x: b.x + 3, y: b.y + 3, w: 8, h: 8 }, [...accent, 1], a, clip);
				break;
			}
			case 'Tab':
				if (o.euiSelected) rect({ x: r.x, y: r.y + r.h - 1, w: r.w, h: 1 }, [...accent, 1], a, clip);
				break;
			default:
				break;
		}
	}

	function drawTexture(t, a) {
		if (hiddenRegions.has(t.id)) return;
		if (t.layer === 'HIGHLIGHT') {
			const p = byId.get(t.parent);
			if (!p || !p.hover) return;
		}
		const r = rects.get(t.id);
		if (!r || r.w <= 0 || r.h <= 0) return;
		const clip = clipAttr(t) + maskAttr(t);
		const vc = t.vertexColor || [1, 1, 1, 1];
		if (t.color) {
			rect(r, [t.color[0] * vc[0], t.color[1] * vc[1], t.color[2] * vc[2], (t.color[3] ?? 1) * (vc[3] ?? 1)], a * (t.alpha ?? 1), clip);
			return;
		}
		const name = textureName(t.texture);
		if (!name) return;
		if (name === 'white' && !t.texCoord && t.gradient) {
			// SetGradient: VERTICAL runs from min (bottom) to max (top), HORIZONTAL left to right.
			const g = t.gradient;
			const id = `${prefix}g${t.id}`;
			const vertical = g.orientation === 'VERTICAL';
			const stop = (c, off) => `<stop offset="${off}" stop-color="rgb(${Math.round(c[0] * 255)},${Math.round(c[1] * 255)},${Math.round(c[2] * 255)})" stop-opacity="${f2(c[3] ?? 1)}"/>`;
			defs.push(`<linearGradient id="${id}" x1="0" y1="${vertical ? 1 : 0}" x2="${vertical ? 0 : 1}" y2="0">${stop(g.min, 0)}${stop(g.max, 1)}</linearGradient>`);
			const op = Math.max(0, Math.min(1, a * (t.alpha ?? 1)));
			if (op > 0.001) body.push(`<rect x="${f2(r.x - ox)}" y="${f2(r.y - oy)}" width="${f2(r.w)}" height="${f2(r.h)}" fill="url(#${id})" opacity="${f2(op)}"${clip}/>`);
			return;
		}
		if (name === 'white' && t.vertexOffset) {
			// SetVertexOffset bends the quad: its corners (upper left, lower
			// left, upper right, lower right) moved in UI units, y up. Pieces
			// share edges exactly in game; crispEdges keeps the SVG renderer's
			// own anti-aliasing from drawing seams between them.
			const s = scaleOf(t);
			const v = t.vertexOffset;
			const at = (i, x, y) => `${f2(x - ox + v[2 * i] * s)},${f2(y - oy - v[2 * i + 1] * s)}`;
			const pts = [at(0, r.x, r.y), at(2, r.x + r.w, r.y), at(3, r.x + r.w, r.y + r.h), at(1, r.x, r.y + r.h)].join(' ');
			const { fill, opacity } = rgba(vc, a * (t.alpha ?? 1));
			if (opacity > 0.001) body.push(`<polygon points="${pts}" fill="${fill}" fill-opacity="${f2(opacity)}" shape-rendering="crispEdges"${clip}/>`);
			return;
		}
		if (name === 'white' && !t.texCoord) {
			rect(r, vc, a * (t.alpha ?? 1), clip);
			return;
		}
		const uri = textures.uri(name, [vc[0], vc[1], vc[2], 1], t.texCoord, t.desaturation || 0);
		if (!uri) return;
		const op = Math.max(0, Math.min(1, (vc[3] ?? 1) * a * (t.alpha ?? 1)));
		if (op <= 0.001) return;
		// SetRotation (radians, counter-clockwise) turns about the centre;
		// ADD blending lightens what is under it.
		const turn = t.rotation ? ` transform="rotate(${f2((-t.rotation * 180) / Math.PI)} ${f2(r.x - ox + r.w / 2)} ${f2(r.y - oy + r.h / 2)})"` : '';
		const blend = t.blend === 'ADD' ? ' style="mix-blend-mode:screen"' : '';
		// A clip path resolves in the user space of the element using it, so a
		// turned image is clipped on an untransformed wrapper.
		const img = (own) => `<image x="${f2(r.x - ox)}" y="${f2(r.y - oy)}" width="${f2(r.w)}" height="${f2(r.h)}" preserveAspectRatio="none" opacity="${f2(op)}" href="${uri}"${turn}${blend}${own}/>`;
		body.push(turn && clip ? `<g${clip}>${img('')}</g>` : img(clip));
	}

	// A Line: a stroke `thickness` wide between its two ends, each a point of
	// a frame plus an offset (the client's Line:SetStartPoint/SetEndPoint), in
	// its colour, or its texture stretched along it (route breadcrumbs).
	function drawLine(t, a) {
		const L = t.line;
		if (!L || !L.from || !L.to) return;
		const s = scaleOf(t);
		const end = (p) => {
			const rel = byId.get(p.rel != null ? p.rel : t.parent);
			const b = rel && rects.get(rel.id);
			return b ? [b.x + b.w * (H[p.point] ?? 0) + p.x * s - ox, b.y + b.h * (V[p.point] ?? 0) - p.y * s - oy] : null;
		};
		const p1 = end(L.from), p2 = end(L.to);
		if (!p1 || !p2) return;
		const len = Math.hypot(p2[0] - p1[0], p2[1] - p1[1]);
		const width = (L.thickness || 1) * s;
		if (len <= 0 || width <= 0) return;
		const clip = clipAttr(t);
		const vc = t.vertexColor || [1, 1, 1, 1];
		const c = t.color ? [t.color[0] * vc[0], t.color[1] * vc[1], t.color[2] * vc[2], (t.color[3] ?? 1) * (vc[3] ?? 1)] : vc;
		const name = t.color ? 'white' : textureName(t.texture);
		if (!name) return;
		const op = Math.max(0, Math.min(1, (c[3] ?? 1) * a * (t.alpha ?? 1)));
		if (op <= 0.001) return;
		if (name === 'white') {
			const { fill } = rgba(c, 1);
			body.push(`<line x1="${f2(p1[0])}" y1="${f2(p1[1])}" x2="${f2(p2[0])}" y2="${f2(p2[1])}" stroke="${fill}" stroke-opacity="${f2(op)}" stroke-width="${f2(width)}"${clip}/>`);
			return;
		}
		const uri = textures.uri(name, [c[0], c[1], c[2], 1], t.texCoord, t.desaturation || 0);
		if (!uri) return;
		const turn = `translate(${f2((p1[0] + p2[0]) / 2)} ${f2((p1[1] + p2[1]) / 2)}) rotate(${f2((Math.atan2(p2[1] - p1[1], p2[0] - p1[0]) * 180) / Math.PI)})`;
		const img = `<image x="${f2(-len / 2)}" y="${f2(-width / 2)}" width="${f2(len)}" height="${f2(width)}" preserveAspectRatio="none" opacity="${f2(op)}" href="${uri}" transform="${turn}"/>`;
		body.push(clip ? `<g${clip}>${img}</g>` : img);
	}

	function drawText(t, a) {
		if (!t.text || !t.lines) return;
		const r = rects.get(t.id);
		const s = scaleOf(t);
		const font = fonts[t.font[0]];
		const size = t.font[1] * s;
		const base = t.textColor || [1, 1, 1, 1];
		const alpha = a * (t.alpha ?? 1);
		if (alpha <= 0.001) return;
		let lines = t.lines;
		// Non-wrapping text wider than its box truncates with an ellipsis.
		if (!t.wrap && r.w > 0) {
			lines = lines.map((l) => {
				if (measure(fonts, t.font, l) * s <= r.w + 0.5) return l;
				let cut = l;
				while (cut.length && measure(fonts, t.font, cut + '...') * s > r.w) cut = cut.slice(0, -1);
				return cut.replace(/\s+$/, '') + '...';
			});
		}
		const colored = colouredLines(t.text, lines, base);
		const lineH = t.font[1] * s;
		const spacing = (t.spacing || 0) * s;
		const blockH = lines.length * lineH + (lines.length - 1) * spacing;
		let y0 = r.y;
		if (t.justifyV === 'MIDDLE') y0 = r.y + (r.h - blockH) / 2;
		else if (t.justifyV === 'BOTTOM') y0 = r.y + r.h - blockH;
		const asc = font.ascender / (font.ascender - font.descender);
		const clip = clipAttr(t);
		const scale = size / font.upm;
		const passes = [];
		if (t.shadow && t.shadowColor) passes.push({ dx: t.shadow[0] * s, dy: -t.shadow[1] * s, color: t.shadowColor });
		passes.push(null);
		for (const pass of passes) {
			colored.forEach((lr, i) => {
				const lineW = lr.reduce((w, run) => w + measure(fonts, t.font, run.text) * s, 0);
				let x = r.x;
				if (t.justifyH === 'CENTER') x = r.x + (r.w - lineW) / 2;
				else if (t.justifyH === 'RIGHT') x = r.x + r.w - lineW;
				const baseline = y0 + i * (lineH + spacing) + lineH * 0.86;
				for (const run of lr) {
					const c = pass ? pass.color : run.color;
					const { fill, opacity } = rgba(c, alpha * (pass ? (c[3] ?? 1) * (run.color[3] ?? 1) : 1));
					if (opacity > 0.001) {
						const uses = [];
						let gx = 0;
						for (const ch of run.text) {
							const gid = font.glyphId(ch.codePointAt(0));
							const key = `${t.font[0]}-${gid}`;
							if (!shared.glyphs.has(key)) {
								shared.glyphs.add(key);
								shared.defs.push(`<path id="g${key.replace(/[^\w-]/g, '')}" d="${font.path(gid)}"/>`);
							}
							if (ch !== ' ') uses.push(`<use href="#g${key.replace(/[^\w-]/g, '')}" x="${f2(gx / scale)}"/>`);
							gx += font.advanceEm(ch.codePointAt(0)) * size;
						}
						const px = x - ox + (pass ? pass.dx : 0), py = baseline - oy + (pass ? pass.dy : 0);
						const outline = !pass && /OUTLINE/.test(t.font[2] || '');
						const stroke = outline ? ` stroke="#000" stroke-opacity="${f2(Math.min(1, opacity * 0.95))}" stroke-width="${f2(1.6 / scale)}" stroke-linejoin="round" paint-order="stroke"` : '';
						const g = `<g transform="translate(${f2(px)} ${f2(py)}) scale(${scale.toFixed(6)})" fill="${fill}" fill-opacity="${f2(opacity)}"${stroke}>${uses.join('')}</g>`;
						// A clip path resolves in the user space of the element using it,
						// so it goes on an untransformed wrapper.
						body.push(clip ? `<g${clip}>${g}</g>` : g);
					}
					x += measure(fonts, t.font, run.text) * s;
				}
			});
		}
	}

	for (const f of frames) {
		const a = alphaOf(f);
		if (a <= 0.001) continue;
		const r = rects.get(f.id);
		if (f.euiSkin) euiPaint(f, r, a, clipAttr(f));
		const regs = (regionsOf.get(f.id) || []).filter((o) => o.shown !== false);
		regs.sort((x, y) => (LAYER[x.layer] ?? 2) - (LAYER[y.layer] ?? 2) || (x.sublayer || 0) - (y.sublayer || 0) || x.seq - y.seq);
		for (const reg of regs) {
			const ra = a;
			if (reg.kind === 'Texture') drawTexture(reg, ra);
			else if (reg.kind === 'Line') drawLine(reg, ra);
			else drawText(reg, ra);
		}
	}

	return {
		width: W,
		height: Hh,
		defs: defs.join('\n'),
		body: body.join('\n'),
		// What was laid out, for callers that hit-test the drawing (tools/play):
		// the drawn frames back to front, every rect, and the order keys.
		layout: { frames, byId, rects, ox, oy, strataOf, levelOf, alphaOf, clipOf },
	};
}

const TERRAIN = `<defs>
<linearGradient id="sky" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#9fb7c9"/><stop offset="0.3" stop-color="#c9b48a"/><stop offset="0.55" stop-color="#8d7a46"/><stop offset="1" stop-color="#4f4a2a"/></linearGradient>
<filter id="grain" x="0" y="0" width="100%" height="100%"><feTurbulence type="fractalNoise" baseFrequency="0.012 0.03" numOctaves="4" seed="7"/><feColorMatrix values="0 0 0 0 0.25  0 0 0 0 0.2  0 0 0 0 0.08  0 0 0 0.9 -0.2"/></filter>
<filter id="spots" x="0" y="0" width="100%" height="100%"><feTurbulence type="turbulence" baseFrequency="0.06" numOctaves="2" seed="3"/><feColorMatrix values="0 0 0 0 0.85  0 0 0 0 0.8  0 0 0 0 0.6  0 0 0 1.4 -0.9"/></filter>
</defs>
<rect width="100%" height="100%" fill="url(#sky)"/>
<rect width="100%" height="100%" filter="url(#grain)"/>
<rect y="40%" width="100%" height="60%" filter="url(#spots)" opacity="0.6"/>`;

// Lay several rendered panels side by side on a backdrop.
// backdrop: "night" (default) or "terrain" (a sunlit savanna-like ground,
// to judge the transparent guide window against something busy).
function compose(panels, { title, shared, backdrop = 'night' } = {}) {
	const gap = 8;
	const width = panels.reduce((w, p) => w + p.width, 0) + gap * (panels.length - 1);
	const height = Math.max(...panels.map((p) => p.height));
	let x = 0;
	const groups = panels.map((p) => {
		const g = `<g transform="translate(${x} ${Math.round((height - p.height) / 2)})">\n${p.body}\n</g>`;
		x += p.width + gap;
		return g;
	});
	return `<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${width} ${height}">
${title ? `<title>${title.replace(/&/g, '&amp;').replace(/</g, '&lt;')}</title>` : ''}
<defs>
<radialGradient id="bg" cx="50%" cy="38%" r="80%"><stop offset="0" stop-color="#2a2e36"/><stop offset="1" stop-color="#121418"/></radialGradient>
${shared ? shared.defs.join('\n') : ''}
${panels.map((p) => p.defs).join('\n')}
</defs>
${backdrop === 'terrain' ? TERRAIN : '<rect width="100%" height="100%" fill="url(#bg)"/>'}
${groups.join('\n')}
</svg>
`;
}

module.exports = { svg, compose, TextureCache, readTGA, png, wrap, measure, resolve };
