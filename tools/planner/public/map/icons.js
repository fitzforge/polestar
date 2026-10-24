// The pin atlas: one 1024 x 1024 texture of 64 px cells drawn on demand.
// A pin is a dark scrim disc holding the goal's game icon (a square icon
// inset in a circle mask, a cut-out ui icon whole) or, while that loads or
// when it is missing, the verb's Polestar glyph tinted by its subject
// colour. Cell 1 holds the current pin's glow, cell 0 the character's arrow (the Polestar Nav arrow in
// the accent over its glow). Cells are kept least-recently-used: the game
// has thousands of icons, a route shows a few dozen at a time.
//
//   const atlas = new PinAtlas(gl, { color: (token) => css, onChange });
//   atlas.cell({ icon: { kind, key } | null, glyph: 'icon-kill', tint: 'danger' }) -> index
//   atlas.ARROW                         // the arrow's cell
//   atlas.tex, atlas.cols, atlas.rows   // for MarkerLayer

import { iconUrl } from '../ui/dom.js';
export { iconUrl };

export const CELL = 64;
const COLS = 16;
const SIZE = CELL * COLS;
const R = 30;          // the disc
const INSET = 25;      // a square icon's circle mask
const GLYPH = 34;      // a glyph's size in the disc
const CUT = 40;        // a cut-out ui icon's size in the disc

// Image loads shared by every cell: url -> Promise<HTMLImageElement | null>.
const images = new Map();
function load(url) {
	if (!images.has(url)) {
		images.set(url, new Promise((resolve) => {
			const img = new Image();
			img.decoding = 'async';
			img.onload = () => resolve(img);
			img.onerror = () => resolve(null);
			img.src = url;
		}));
	}
	return images.get(url);
}
const loaded = new Map();   // url -> HTMLImageElement | null, once settled
function ready(url) {
	if (loaded.has(url)) return loaded.get(url);
	load(url).then((img) => loaded.set(url, img));
	return undefined;
}

export const glyphUrl = (name) => `/glyph/${name}.png?px=64`;
// ui textures are cut-outs at their own shapes; the rest are square icons.
const isSquare = (spec) => spec.kind !== 'ui' || spec.key === 'hearthstone';

export class PinAtlas {
	constructor(gl, { color, onChange }) {
		this.gl = gl;
		this.color = color;
		this.onChange = onChange || (() => {});
		this.cols = COLS;
		this.rows = COLS;
		this.cells = new Map();   // key -> cell index (insertion order = recency)
		this.free = [];
		for (let i = COLS * COLS - 1; i >= 2; i--) this.free.push(i);
		this.ARROW = 0;
		this.GLOW = 1;
		this.scratch = document.createElement('canvas');
		this.scratch.width = this.scratch.height = CELL;
		this.tint = document.createElement('canvas');
		this.tint.width = this.tint.height = CELL;
		const tex = gl.createTexture();
		gl.bindTexture(gl.TEXTURE_2D, tex);
		gl.texStorage2D(gl.TEXTURE_2D, Math.log2(SIZE) + 1, gl.RGBA8, SIZE, SIZE);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
		this.tex = tex;
		this._mips = 0;
		this._drawArrow();
		this._drawGlow();
	}

	// The Starlight glow of the current pin: the Nav glow in the accent at 50%.
	_drawGlow() {
		load('/media/Nav/glow.png').then((img) => {
			if (!img) return;
			const g = this._begin();
			const t = this.tint.getContext('2d');
			t.clearRect(0, 0, CELL, CELL);
			t.drawImage(img, 0, 0, CELL, CELL);
			t.globalCompositeOperation = 'source-in';
			t.fillStyle = this.color('accent');
			t.fillRect(0, 0, CELL, CELL);
			t.globalCompositeOperation = 'source-over';
			g.globalAlpha = 0.5;
			g.drawImage(this.tint, 0, 0);
			g.globalAlpha = 1;
			this._upload(this.GLOW);
			this.onChange();
		});
	}

	// The cell of a pin, drawn now with what has loaded and again as the rest arrives.
	cell(pin) {
		const key = `${pin.icon ? iconUrl(pin.icon) : ''}|${pin.glyph}|${pin.tint}`;
		let i = this.cells.get(key);
		if (i !== undefined) {
			this.cells.delete(key);
			this.cells.set(key, i);
			return i;
		}
		if (this.free.length) i = this.free.pop();
		else {
			const [oldest, cell] = this.cells.entries().next().value;
			this.cells.delete(oldest);
			i = cell;
		}
		this.cells.set(key, i);
		this._drawPin(i, key, pin);
		return i;
	}

	_drawPin(i, key, pin) {
		const iconU = pin.icon ? iconUrl(pin.icon) : null;
		const glyphU = glyphUrl(pin.glyph || 'icon-note');
		const icon = iconU ? ready(iconU) : null;
		const glyph = ready(glyphU);
		const g = this._begin();
		g.beginPath();
		g.arc(CELL / 2, CELL / 2, R, 0, Math.PI * 2);
		g.fillStyle = this.color('pin-ground');
		g.globalAlpha = 0.92;
		g.fill();
		g.globalAlpha = 1;
		g.lineWidth = 1.5;
		g.strokeStyle = this.color('border');
		g.stroke();
		if (icon) this._icon(g, icon, isSquare(pin.icon));
		else if (glyph) this._glyph(g, glyph, this.color(pin.tint || 'textDim'), GLYPH);
		this._upload(i);
		// Redraw once what was missing has settled (the icon, else the glyph).
		const pending = [];
		if (iconU && icon === undefined) pending.push(load(iconU));
		if (!icon && glyph === undefined) pending.push(load(glyphU));
		if (pending.length) {
			Promise.all(pending).then(() => {
				// let ready() record the settled loads first
				queueMicrotask(() => {
					if (this.cells.get(key) !== i) return;
					this._drawPin(i, key, pin);
					this.onChange();
				});
			});
		}
	}

	_icon(g, img, square) {
		const c = CELL / 2;
		if (square) {
			g.save();
			g.beginPath();
			g.arc(c, c, INSET, 0, Math.PI * 2);
			g.clip();
			g.drawImage(img, c - INSET, c - INSET, INSET * 2, INSET * 2);
			g.restore();
			return;
		}
		const s = CUT / Math.max(img.width, img.height);
		const w = img.width * s, h = img.height * s;
		g.imageSmoothingEnabled = img.width >= CUT;
		g.drawImage(img, c - w / 2, c - h / 2, w, h);
		g.imageSmoothingEnabled = true;
	}

	// A white glyph painted in `color` (source-in on a second canvas).
	_glyph(g, img, color, size) {
		const t = this.tint.getContext('2d');
		t.clearRect(0, 0, CELL, CELL);
		t.globalCompositeOperation = 'source-over';
		t.drawImage(img, (CELL - size) / 2, (CELL - size) / 2, size, size);
		t.globalCompositeOperation = 'source-in';
		t.fillStyle = color;
		t.fillRect(0, 0, CELL, CELL);
		t.globalCompositeOperation = 'source-over';
		g.drawImage(this.tint, 0, 0);
	}

	// The arrow: its glow in the accent at 45%, the arrow multiplied by the accent.
	_drawArrow() {
		Promise.all([load('/media/Nav/arrow-glow.png'), load('/media/Nav/arrow.png')]).then(([glow, arrow]) => {
			const g = this._begin();
			const accent = this.color('accent');
			if (glow) {
				const t = this.tint.getContext('2d');
				t.clearRect(0, 0, CELL, CELL);
				t.drawImage(glow, 0, 0, CELL, CELL);
				t.globalCompositeOperation = 'source-in';
				t.fillStyle = accent;
				t.fillRect(0, 0, CELL, CELL);
				t.globalCompositeOperation = 'source-over';
				g.globalAlpha = 0.45;
				g.drawImage(this.tint, 0, 0);
				g.globalAlpha = 1;
			}
			if (arrow) {
				const t = this.tint.getContext('2d');
				t.clearRect(0, 0, CELL, CELL);
				t.drawImage(arrow, 8, 8, CELL - 16, CELL - 16);
				t.globalCompositeOperation = 'multiply';
				t.fillStyle = accent;
				t.fillRect(0, 0, CELL, CELL);
				t.globalCompositeOperation = 'destination-in';
				t.drawImage(arrow, 8, 8, CELL - 16, CELL - 16);
				t.globalCompositeOperation = 'source-over';
				g.drawImage(this.tint, 0, 0);
			}
			this._upload(this.ARROW);
			this.onChange();
		});
	}

	_begin() {
		const g = this.scratch.getContext('2d');
		g.clearRect(0, 0, CELL, CELL);
		return g;
	}

	_upload(i) {
		const gl = this.gl;
		gl.bindTexture(gl.TEXTURE_2D, this.tex);
		gl.pixelStorei(gl.UNPACK_PREMULTIPLY_ALPHA_WEBGL, true);
		gl.texSubImage2D(gl.TEXTURE_2D, 0, (i % COLS) * CELL, Math.floor(i / COLS) * CELL, gl.RGBA, gl.UNSIGNED_BYTE, this.scratch);
		gl.pixelStorei(gl.UNPACK_PREMULTIPLY_ALPHA_WEBGL, false);
		// Mips once per frame at most (several cells often land together).
		if (!this._mips) {
			this._mips = requestAnimationFrame(() => {
				this._mips = 0;
				gl.bindTexture(gl.TEXTURE_2D, this.tex);
				gl.generateMipmap(gl.TEXTURE_2D);
				this.onChange();
			});
		}
	}
}
