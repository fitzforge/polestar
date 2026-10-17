// DOM overlay above the canvas: label pills of the active markers and of
// the handles, then zone and continent labels (uppercase, letter-spaced),
// all placed greedily without overlaps and clear of the map's controls.
// Elements are pooled per key and only moved (transform) when the camera
// changes.

const STYLE = `
.mv-overlay { position: absolute; pointer-events: none; overflow: hidden; contain: strict; z-index: 1;
	font: 500 11px/1.25 var(--font); }
.mv-l { position: absolute; left: 0; top: 0; white-space: nowrap; will-change: transform; }
.mv-zone { color: var(--text); text-transform: uppercase; letter-spacing: 0.12em; font-weight: 600; font-size: 11px;
	text-shadow: var(--text-on-art), 0 0 6px var(--shade); }
.mv-cont { font-size: 13px; letter-spacing: 0.2em; color: var(--textDim); }
.mv-pill { background: var(--panel); color: var(--text); border: 1px solid var(--border); padding: 2px 7px 3px; font-size: 12px; }
.mv-handle { border-color: var(--focus); font-weight: 600; }
.mv-aid { color: var(--nav-aid); font-size: 11px; text-shadow: var(--text-on-art), 0 0 6px var(--shade); }
.mv-hub { font-size: 11px; font-weight: 600; text-shadow: var(--text-on-art), 0 0 6px var(--shade); }
.mv-hub.alliance { color: var(--npc); }
.mv-hub.horde { color: var(--danger); }
.mv-add { position: absolute; left: -11px; top: -11px; width: 22px; height: 22px; border-radius: 50%;
	background: var(--scrim); border: 1.5px solid var(--accent); will-change: transform; }
.mv-add::after { content: ''; position: absolute; inset: 3px; background: var(--accent);
	-webkit-mask: url('/glyph/pin-add.png?px=48') center / contain no-repeat; mask: url('/glyph/pin-add.png?px=48') center / contain no-repeat; }
`;

let styled = false;

export class Overlay {
	constructor(canvas) {
		if (!styled) {
			const s = document.createElement('style');
			s.textContent = STYLE;
			document.head.appendChild(s);
			styled = true;
		}
		const parent = canvas.parentElement;
		if (getComputedStyle(parent).position === 'static') parent.style.position = 'relative';
		this.canvas = canvas;
		this.el = document.createElement('div');
		this.el.className = 'mv-overlay';
		canvas.insertAdjacentElement('afterend', this.el);
		this.pool = new Map();   // key -> { el, w, h, text, cls, seen }
		this.gen = 0;
	}

	place() {
		const c = this.canvas;
		Object.assign(this.el.style, {
			left: `${c.offsetLeft}px`, top: `${c.offsetTop}px`,
			width: `${c.clientWidth}px`, height: `${c.clientHeight}px`,
		});
	}

	// items: [{ key, text, cls, x, y, anchor: 'center' | 'pin', r, collide }],
	// placed greedily in order (the first wins). A 'pin' label tries the
	// right, left, below and above of its point (r px clear of it); a
	// colliding label that fits nowhere is dropped. Labels stay inside the
	// map, off `reserved` ([{ left, top, right, bottom }] in client px: the
	// map's own controls) and off `pins` ([x, y, r] in canvas px: every drawn
	// pin disc), except a pin at the label's own anchor.
	update(items, W, H, reserved = [], pins = []) {
		const gen = ++this.gen;
		const cr = this.canvas.getBoundingClientRect();
		const boxes = reserved.map((r) => [r.left - cr.left - 4, r.top - cr.top - 4, r.right - cr.left + 4, r.bottom - cr.top + 4]);
		const fresh = [];
		for (const it of items) {
			let e = this.pool.get(it.key);
			if (!e) {
				const el = document.createElement('div');
				this.el.appendChild(el);
				e = { el, w: 0, h: 0, text: null, cls: null };
				this.pool.set(it.key, e);
			}
			if (e.text !== it.text) { e.el.textContent = it.text; e.text = it.text; e.w = 0; }
			const cls = `mv-l ${it.cls}`;
			if (e.cls !== cls) { e.el.className = cls; e.cls = cls; e.w = 0; }
			if (!e.w) fresh.push(e);
			e.seen = gen;
			e.it = it;
		}
		for (const e of fresh) {
			e.el.style.visibility = 'hidden';
			e.el.style.display = '';
			e.tf = undefined;
		}
		for (const e of fresh) { e.w = e.el.offsetWidth; e.h = e.el.offsetHeight; }
		const M = 4;
		const free = (x, y, w, h, it) => {
			if (x < M || y < M || x + w > W - M || y + h > H - M) return false;
			for (const b of boxes) if (x < b[2] && x + w > b[0] && y < b[3] && y + h > b[1]) return false;
			for (const [px, py, r] of pins) {
				if (it.anchor === 'pin' && Math.abs(px - it.x) < 1 && Math.abs(py - it.y) < 1) continue;
				const dx = px - Math.max(x, Math.min(px, x + w)), dy = py - Math.max(y, Math.min(py, y + h));
				if (dx * dx + dy * dy < r * r) return false;
			}
			return true;
		};
		for (const it of items) {
			const e = this.pool.get(it.key);
			const { w, h } = e;
			let spot = null;
			if (it.anchor === 'pin') {
				const r = it.r || 12;
				const tries = [[it.x + r, it.y - h / 2], [it.x - r - w, it.y - h / 2], [it.x - w / 2, it.y + r], [it.x - w / 2, it.y - r - h]];
				spot = tries.find(([x, y]) => free(x, y, w, h, it)) || null;
			} else {
				const x = it.x - w / 2, y = it.y - h / 2;
				if (it.collide ? free(x, y, w, h, it) : x < W && y < H && x + w > 0 && y + h > 0) spot = [x, y];
			}
			if (spot && it.collide) boxes.push([spot[0] - 6, spot[1] - 3, spot[0] + w + 6, spot[1] + h + 3]);
			const tf = spot ? `translate3d(${Math.round(spot[0])}px, ${Math.round(spot[1])}px, 0)` : null;
			if (tf === e.tf) continue;
			if (spot) {
				e.el.style.transform = tf;
				if (e.tf === undefined || e.tf === null) {
					e.el.style.visibility = 'visible';
					e.el.style.display = '';
				}
			} else {
				e.el.style.display = 'none';
			}
			e.tf = tf;
		}
		for (const [key, e] of this.pool) {
			if (e.seen === gen) continue;
			e.el.remove();
			this.pool.delete(key);
		}
	}

	dispose() { this.el.remove(); this.pool.clear(); }
}
