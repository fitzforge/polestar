// MapView: the planner's WebGL2 map (spec section 6).
//
//   const map = new MapView(canvas, { artBase: '/art' });
//   await map.init();
//   map.setMode('continent' | 'world'); map.setContinent(c);
//   map.view                         // { mode, c, x, y, zoom, wx, wy }
//   map.setView({ c, x, y, zoom }, { animate });
//   map.fitWorld(c, [[wx, wy], ...], { padding });
//   map.toScreen(c, wx, wy)          // { x, y } CSS px in the canvas | null (continent not shown)
//   map.toWorld(sx, sy)              // { c, wx, wy }
//   map.setLayer(name, on);          // terrain, zoneArt, route, labels, spawns, grid, walkable, roads, hubs, aids
//   map.setNav({ tiles } | null);     // the Walkable layer's tiles: { [c]: ['col_row'] } (GET /nav/index.json)
//   map.setRoads({ tiles } | null);   // the Roads layer's tiles: { [c]: ['col_row'] } (GET /nav/roads/index.json)
//   map.setHubs(hubs | null);         // the Hubs layer (GET /nav/hubs.json): { [c]: [{ id, side, name, disks: [[x, y, r]] }] }
//   map.setAids(aids | null);         // the arrow aids (GET /nav/aids.json): crossings, chains
//   map.setRoute([{ c, pts /* Float32Array wx,wy,... */, mode, step, state }]);
//   map.setScene({ areas, dots, markers, rings });
//   map.setCharacter({ c, wx, wy } | null);
//   map.setHandles([{ id, c, wx, wy, r, label, kind }]);
//   map.setLegHit(fn | null);        // route legs that can be bent (see 'leg')
//   map.on('pick' | 'handle' | 'view' | 'marker' | 'leg', fn);   // returns an unsubscribe function
//
// Units: x, y are plane coordinates on continent c (X = -wy, Y = -wx, yards,
// east right, north up); zoom is CSS px per yard, clamped between the whole
// continent (whole world in world mode) and 12. In world mode every
// continent of the art index is laid out side by side (Kalimdor left of
// Eastern Kingdoms, the others below), offsets in whole ADT tiles.
//
// Events:
//   pick   { c, wx, wy, sx, sy, hit, event }  click without drag; hit = { type: 'marker', marker }
//          | { type: 'handle', handle, part } | null
//   marker { marker, step }                   a marker was clicked
//   handle { id, phase: 'start'|'move'|'end', part: 'point'|'ring', c, wx, wy, r, handle }
//          drag of a handle (part 'ring' changes r); the handle follows the pointer until
//          the next setHandles
//   view   map.view, on camera changes (at most every 100 ms, plus a trailing one)
//   leg    { leg, c, wx, wy } a route leg was clicked or dragged and dropped:
//          the point to put a waypoint at. setLegHit(fn): fn(sx, sy) ->
//          { key, c, pts (Float32Array wx,wy,...), from: { wx, wy }, to: { wx, wy },
//          sx, sy (the nearest point on it) } | null; the hovered leg is drawn
//          in the accent with an add mark, a drag bends it (from -> pointer -> to).
//
// Additions to the spec: setView also takes { c, wx, wy, zoom }; any field
// left out keeps its value. fitWorld options { padding = 48, animate = true,
// maxZoom = 2.5 } (pts may be a flat Float32Array; none fits the continent).
// zoomBy(factor, { animate = true }) zooms about the centre. resize()
// re-measures (a ResizeObserver does it anyway). destroy() releases
// everything. stats: { path: 's3tc' | 'worker' | null, frameMs (CPU, EMA),
// tiles }. Constructor options: artBase ('/art'), c (initial continent, 0),
// compressed (false forces the worker path). Layers default on except
// zoneArt, grid, walkable, roads, hubs and aids; the grid is drawn whenever there is no
// terrain art. The Walkable and Roads layers draw under the route from WALKABLE_ZOOM;
// the Hubs layer under the route too: each hub's disks as translucent circles
// in its side's colour (Alliance npc blue, Horde danger red), its name at its first disk;
// the aids draw over it: a crossing as its two ends' rings joined by a long
// dash, its caption at its middle; a chain as a line through its nodes'
// rings, its name at its first node and the node captions.
// Route mode is a MODES name or number (teleport is not drawn); a marker is
// a pin of the atlas (icons.js): { icon: { kind, key } | null, glyph, tint }
// (tint a colour token); markers { active } grow 1.3x inside an accent ring
// and get a label pill, { done } recede; handles carry a tint and with
// explicit === false are hollow; dots and areas carry a tint, kind 'alt'
// fainter; a handle { selected } is labelled first. Option reserved() ->
// client rects the labels keep clear of (the page's map controls). The character is the Polestar arrow, turned to { heading }
// (radians clockwise from north on screen). The clear colour is the art's
// sea colour (the tiles' own filler) when art is present, else --sea.

import { ADT, parseColor, cssOf } from './gl.js';
import { Terrain, ZoneArt, Quad, WalkableTiles } from './tiles.js';
import { RouteLayer, CircleProgram, MarkerLayer, GridLayer, circle, CIRCLE_STRIDE } from './layers.js';
import { PinAtlas } from './icons.js';
import { Overlay } from './labels.js';

const MAX_ZOOM = 12;
const GAP = 2 * ADT;
const GRID = [-32 * ADT, -32 * ADT, 32 * ADT, 32 * ADT];
const ZONE_LABELS = [0.012, 1.5];   // zoom range of zone labels; continent names below

// Colours the renderer reads from the page's tokens once at init.
const COLORS = {
	sea: '--sea', route: '--route', routePast: '--route-past', routeFuture: '--route-future',
	routeFly: '--route-fly', routeBoat: '--route-boat', routeSwim: '--route-swim', routeClimb: '--route-climb',
	aid: '--nav-aid', accent: '--accent', shade: '--shade', ink: '--ink',
};
const PIN = 24;          // a pin's size in CSS px
const PIN_ACTIVE = 31;   // the current goal's pin (1.3x)
const ARROW = 40;

const pm = (c, a = 1) => [c[0] * c[3] * a, c[1] * c[3] * a, c[2] * c[3] * a, c[3] * a];
const NONE = [0, 0, 0, 0];
const ease = (t) => (t < 0.5 ? 4 * t * t * t : 1 - (-2 * t + 2) ** 3 / 2);

export class MapView {
	constructor(canvas, opts = {}) {
		this.canvas = canvas;
		this.opts = opts;
		this.artBase = (opts.artBase ?? '/art').replace(/\/$/, '');
		this.listeners = {};
		this.layers = { terrain: true, zoneArt: false, route: true, labels: true, spawns: true, grid: false, walkable: false, roads: false, hubs: false, aids: false };
		this.navTiles = null;
		this.roadTiles = null;
		this.hubs = null;
		this.aids = null;
		this.mode = 'continent';
		this.c = Number(opts.c ?? 0);
		this.cam = { x: 0, y: 0, zoom: 0.02 };
		this.W = 0;
		this.H = 0;
		this.dpr = 1;
		this.routes = [];
		this.scene = { areas: [], dots: [], markers: [], rings: [] };
		this.handles = [];
		this.legHit = null;
		this.legShown = null;     // the leg drawn hovered or bent: { leg, bend: { wx, wy } | null }
		this.character = null;
		this.index = null;
		this.offsets = new Map();
		this.rects = new Map();
		this.dataExt = new Map();
		this.pointers = new Map();
		this.press = null;
		this.pinch = null;
		this.drag = null;          // handle drag override { id, c, wx, wy, r }
		this.hover = null;
		this.anim = null;
		this.wheel = null;
		this.inertia = null;
		this.stats = { path: null, frameMs: 0, tiles: 0 };
		this._raf = 0;
		this._dirty = true;
		this._overlayDirty = true;
		this._viewDirty = false;
		this._lastView = 0;
		this._lastT = 0;
		this._fitPending = true;
	}

	async init() {
		const gl = this.canvas.getContext('webgl2', {
			alpha: false, antialias: false, depth: false, stencil: true, premultipliedAlpha: true,
			preserveDrawingBuffer: false, powerPreference: 'high-performance',
		});
		if (!gl) throw new Error('WebGL2 is not available');
		this.gl = gl;
		this._css = getComputedStyle(document.documentElement);
		this._tokens = new Map();
		this.colors = {};
		for (const [k, v] of Object.entries(COLORS)) this.colors[k] = this.token(v.slice(2));
		try {
			const res = await fetch(`${this.artBase}/index.json`);
			this.index = res.ok ? await res.json() : null;
		} catch {
			this.index = null;
		}
		if (this.index?.tile?.sea) this.colors.sea = [...this.index.tile.sea.map((v) => v / 255), 1];
		if (this.index && this.opts.c === undefined && !this.index.continents?.[this.c]) {
			const first = Object.keys(this.index.continents || {})[0];
			if (first !== undefined) this.c = Number(first);
		}
		this._initGL();
		this.overlay = new Overlay(this.canvas);
		this._bind();
		this._layout();
		this.resize();
		this.requestRender();
		return this;
	}

	_initGL() {
		const gl = this.gl;
		this.quad = new Quad(gl);
		this.terrain = this.index ? new Terrain(gl, {
			artBase: this.artBase, index: this.index, compressed: this.opts.compressed ?? null,
			onChange: () => this.requestRender(),
		}) : null;
		this.zoneArt = this.index ? new ZoneArt(gl, { artBase: this.artBase, index: this.index, onChange: () => this.requestRender() }) : null;
		this.stats.path = this.terrain ? this.terrain.path : null;
		this.grid = new GridLayer(gl);
		this.route = new RouteLayer(gl);
		this.route.setColors(this.colors);
		// the hovered or bent leg: the current-leg style, thicker
		this.preview = new RouteLayer(gl);
		this.preview.setColors(this.colors);
		this.preview.styles.style[8] = 3.25;
		this.walkable = this.navTiles ? new WalkableTiles(gl, { tiles: this.navTiles, onChange: () => this.requestRender() }) : null;
		this.roads = this.roadTiles ? new WalkableTiles(gl, { base: '/nav/roads', tiles: this.roadTiles, onChange: () => this.requestRender() }) : null;
		// the arrow aids: crossings as boat-like long dashes, chains as solid lines, in the aid colour
		this.aidRoute = new RouteLayer(gl);
		const aid = this.colors.aid;
		this.aidRoute.setColors({ ...this.colors, route: aid, routePast: aid, routeFuture: aid, routeFly: aid, routeBoat: aid });
		this.circles = new CircleProgram(gl);
		this.inst = {
			areas: this.circles.instances(), rings: this.circles.instances(), dots: this.circles.instances(),
			handles: this.circles.instances(), aidRings: this.circles.instances(), hubDisks: this.circles.instances(),
		};
		this.inst.pinRings = this.circles.instances();
		this.markers = new MarkerLayer(gl);
		this.markers.atlas = new PinAtlas(gl, { color: (t) => cssOf(this.token(t)), onChange: () => this.requestRender() });
		this.inst.arrow = this.markers.instances();
		this.inst.glow = this.markers.instances();
		this._charData = new Float32Array(7);
		this._dirty = true;
	}

	// ---- public API ------------------------------------------------------

	on(name, fn) {
		(this.listeners[name] ||= new Set()).add(fn);
		return () => this.off(name, fn);
	}

	off(name, fn) { this.listeners[name]?.delete(fn); }

	_emit(name, payload) {
		for (const fn of this.listeners[name] || []) {
			try { fn(payload); } catch (err) { console.error(err); }
		}
	}

	get view() {
		const c = this._centerC();
		const o = this._off(c) || { ox: 0, oy: 0 };
		const x = this.cam.x - o.ox, y = this.cam.y - o.oy;
		return { mode: this.mode, c, x, y, zoom: this.cam.zoom, wx: -y, wy: -x };
	}

	setMode(mode) {
		if (mode !== 'world' && mode !== 'continent') throw new Error(`map mode: ${mode}`);
		if (mode === this.mode) return;
		this._stop();
		if (mode === 'world') {
			const o = this.offsets.get(this.c) || { ox: 0, oy: 0 };
			this.mode = 'world';
			this.cam.x += o.ox;
			this.cam.y += o.oy;
			this._changed(true);
			const b = this._bounds();
			this._tween(this._fitCam(b, 24, Infinity));
		} else {
			const c = this._centerC();
			const o = this.offsets.get(c) || { ox: 0, oy: 0 };
			this.mode = 'continent';
			this.c = c;
			this.cam.x -= o.ox;
			this.cam.y -= o.oy;
			this._changed(true);
		}
	}

	setContinent(c) {
		c = Number(c);
		if (this.mode === 'world') {
			this.c = c;
			const r = this._rect(c), o = this._off(c);
			this._tween(this._fitCam([r[0] + o.ox, r[1] + o.oy, r[2] + o.ox, r[3] + o.oy], 24, Infinity));
			return;
		}
		if (c === this.c) return;
		this._stop();
		this.c = c;
		this._fit(this._rect(c), 24, Infinity);
		this._changed(true);
	}

	setView(v, { animate = false } = {}) {
		const c = v.c === undefined || v.c === null ? this._centerC() : Number(v.c);
		if (this.mode === 'continent' && c !== this.c) {
			this._stop();
			this.c = c;
			this._changed(true);
		}
		const o = this._off(c) || { ox: 0, oy: 0 };
		const cur = this.view;
		let x = v.x, y = v.y;
		if (x === undefined && v.wy !== undefined) x = -v.wy;
		if (y === undefined && v.wx !== undefined) y = -v.wx;
		const to = {
			x: (x ?? (c === cur.c ? cur.x : this.cam.x - o.ox)) + o.ox,
			y: (y ?? (c === cur.c ? cur.y : this.cam.y - o.oy)) + o.oy,
			zoom: v.zoom ?? this.cam.zoom,
		};
		this._fitPending = false;
		if (animate) this._tween(to);
		else {
			this._stop();
			Object.assign(this.cam, to);
			this._clamp();
			this._changed();
		}
	}

	fitWorld(c, pts, { padding = 48, animate = true, maxZoom = 2.5 } = {}) {
		c = Number(c);
		if (this.mode === 'continent' && c !== this.c) {
			this._stop();
			this.c = c;
			this._changed(true);
			animate = false;
		}
		let x0 = Infinity, y0 = Infinity, x1 = -Infinity, y1 = -Infinity;
		const add = (wx, wy) => {
			if (!Number.isFinite(wx) || !Number.isFinite(wy)) return;
			x0 = Math.min(x0, -wy); x1 = Math.max(x1, -wy);
			y0 = Math.min(y0, -wx); y1 = Math.max(y1, -wx);
		};
		if (pts && typeof pts[0] === 'number') for (let i = 0; i + 1 < pts.length; i += 2) add(pts[i], pts[i + 1]);
		else for (const p of pts || []) add(p[0], p[1]);
		const o = this._off(c) || { ox: 0, oy: 0 };
		const rect = x0 <= x1 ? [x0, y0, x1, y1] : this._rect(c);
		if (x0 > x1) maxZoom = Infinity;
		const to = this._fitCam([rect[0] + o.ox, rect[1] + o.oy, rect[2] + o.ox, rect[3] + o.oy], padding, maxZoom);
		this._fitPending = false;
		if (animate) this._tween(to);
		else {
			this._stop();
			Object.assign(this.cam, to);
			this._clamp();
			this._changed();
		}
	}

	zoomBy(factor, { animate = true } = {}) {
		const to = { x: this.cam.x, y: this.cam.y, zoom: this.cam.zoom * factor };
		if (animate) this._tween(to);
		else {
			this._stop();
			Object.assign(this.cam, to);
			this._clamp();
			this._changed();
		}
	}

	toScreen(c, wx, wy) {
		const o = this._off(Number(c));
		if (!o) return null;
		return {
			x: (-wy + o.ox - this.cam.x) * this.cam.zoom + this.W / 2,
			y: (-wx + o.oy - this.cam.y) * this.cam.zoom + this.H / 2,
		};
	}

	toWorld(sx, sy) {
		const X = (sx - this.W / 2) / this.cam.zoom + this.cam.x;
		const Y = (sy - this.H / 2) / this.cam.zoom + this.cam.y;
		const c = this.mode === 'continent' ? this.c : this._contAt(X, Y);
		const o = this._off(c) || { ox: 0, oy: 0 };
		return { c, wx: -(Y - o.oy), wy: -(X - o.ox) };
	}

	setLayer(name, on) {
		if (!(name in this.layers)) throw new Error(`map layer: ${name}`);
		this.layers[name] = !!on;
		this._dirty = true;
		this._overlayDirty = true;
		this.requestRender();
	}

	setNav(nav) {
		this.navTiles = nav?.tiles || null;
		this.walkable?.dispose();
		this.walkable = this.gl && this.navTiles ? new WalkableTiles(this.gl, { tiles: this.navTiles, onChange: () => this.requestRender() }) : null;
		this.requestRender();
	}

	setRoads(roads) {
		this.roadTiles = roads?.tiles || null;
		this.roads?.dispose();
		this.roads = this.gl && this.roadTiles ? new WalkableTiles(this.gl, { base: '/nav/roads', tiles: this.roadTiles, onChange: () => this.requestRender() }) : null;
		this.requestRender();
	}

	setHubs(hubs) {
		this.hubs = hubs || null;
		this._dirty = true;
		this._overlayDirty = true;
		this.requestRender();
	}

	setAids(aids) {
		this.aids = aids || null;
		this._dirty = true;
		this._overlayDirty = true;
		this.requestRender();
	}

	setRoute(routes) {
		this.routes = routes || [];
		if (this.legShown && !this.press) {
			this._legHeld = false;
			this._showLeg(null);
		}
		this._extents();
		this._changed(true);
	}

	setScene(scene) {
		this.scene = { areas: scene?.areas || [], dots: scene?.dots || [], markers: scene?.markers || [], rings: scene?.rings || [] };
		this._extents();
		this._changed(true);
	}

	setCharacter(ch) {
		this.character = ch || null;
		this.requestRender();
	}

	setHandles(handles) {
		this.handles = handles || [];
		this._overlayDirty = true;
		if (this.drag && !this.press?.dragging) this.drag = null;
		this._extents();
		this._changed(true);
	}

	resize() {
		const r = this.canvas.getBoundingClientRect();
		this._target = { w: r.width, h: r.height, pw: Math.round(r.width * devicePixelRatio), ph: Math.round(r.height * devicePixelRatio) };
		this.requestRender();
	}

	requestRender() {
		if (this._raf || this.destroyed) return;
		this._raf = requestAnimationFrame((t) => {
			this._raf = 0;
			this._frame(t);
		});
	}

	destroy() {
		this.destroyed = true;
		cancelAnimationFrame(this._raf);
		clearTimeout(this._viewTimer);
		this._ro?.disconnect();
		for (const [t, ev, fn, o] of this._handlers || []) t.removeEventListener(ev, fn, o);
		this.terrain?.dispose();
		this.zoneArt?.dispose();
		this.walkable?.dispose();
		this.roads?.dispose();
		this.overlay?.dispose();
		this.listeners = {};
	}

	// ---- layout and camera ----------------------------------------------

	// Plane rect of continent c: art tile bounds, else the data's extent, else the whole grid.
	_rect(c) {
		const ci = this.index?.continents?.[c];
		if (ci?.bounds) {
			const b = ci.bounds;
			return [(b.minCol - 32) * ADT, (b.minRow - 32) * ADT, (b.maxCol - 31) * ADT, (b.maxRow - 31) * ADT];
		}
		const e = this.dataExt.get(c);
		if (e) {
			const s = (v, f) => f(v / ADT) * ADT;
			return [s(e[0], Math.floor) - ADT, s(e[1], Math.floor) - ADT, s(e[2], Math.ceil) + ADT, s(e[3], Math.ceil) + ADT];
		}
		return GRID;
	}

	_layout() {
		const cs = new Set(Object.keys(this.index?.continents || {}).map(Number));
		for (const c of this.dataExt.keys()) cs.add(c);
		cs.add(this.c);
		const first = [1, 0].filter((c) => cs.has(c));
		const rest = [...cs].filter((c) => !first.includes(c)).sort((a, b) => a - b);
		const rows = first.length ? [first, rest] : [rest];
		const before = JSON.stringify([...this.offsets]);
		this.offsets = new Map();
		let left = null, y = 0;
		for (const row of rows) {
			if (!row.length) continue;
			let x = left, bottom = -Infinity;
			for (const c of row) {
				const r = this._rect(c);
				let ox, oy;
				if (x === null) { ox = 0; oy = 0; left = r[0]; y = r[1]; }
				else { ox = x - r[0]; oy = y - r[1]; }
				this.offsets.set(c, { ox, oy });
				x = r[2] + ox + GAP;
				bottom = Math.max(bottom, r[3] + oy);
			}
			y = bottom + GAP;
		}
		return before !== JSON.stringify([...this.offsets]);
	}

	_off(c) {
		if (this.mode === 'continent') return c === this.c ? { ox: 0, oy: 0 } : null;
		return this.offsets.get(c) || null;
	}

	_shown() {
		if (this.mode === 'continent') return [{ c: this.c, ox: 0, oy: 0 }];
		return [...this.offsets].map(([c, o]) => ({ c, ...o }));
	}

	_contAt(X, Y) {
		let best = this.c, bd = Infinity;
		for (const [c, o] of this.offsets) {
			const r = this._rect(c);
			const dx = Math.max(r[0] + o.ox - X, 0, X - r[2] - o.ox), dy = Math.max(r[1] + o.oy - Y, 0, Y - r[3] - o.oy);
			const d = Math.hypot(dx, dy);
			if (d < bd) { bd = d; best = c; }
		}
		return best;
	}

	_centerC() { return this.mode === 'continent' ? this.c : this._contAt(this.cam.x, this.cam.y); }

	_bounds() {
		if (this.mode === 'continent') return this._rect(this.c);
		let b = null;
		for (const [c, o] of this.offsets) {
			const r = this._rect(c);
			const q = [r[0] + o.ox, r[1] + o.oy, r[2] + o.ox, r[3] + o.oy];
			b = b ? [Math.min(b[0], q[0]), Math.min(b[1], q[1]), Math.max(b[2], q[2]), Math.max(b[3], q[3])] : q;
		}
		return b || GRID;
	}

	_size() {
		if (!this.W) {
			this.W = this.canvas.clientWidth || 800;
			this.H = this.canvas.clientHeight || 600;
		}
	}

	_minZoom() {
		this._size();
		const b = this._bounds();
		return Math.min(this.W / (b[2] - b[0]), this.H / (b[3] - b[1])) * 0.9;
	}

	_fitCam(b, padding, maxZoom) {
		this._size();
		const w = Math.max(b[2] - b[0], 1), h = Math.max(b[3] - b[1], 1);
		const zoom = Math.min((this.W - 2 * padding) / w, (this.H - 2 * padding) / h, maxZoom);
		return { x: (b[0] + b[2]) / 2, y: (b[1] + b[3]) / 2, zoom: Math.max(zoom, 1e-4) };
	}

	_fit(b, padding, maxZoom) {
		Object.assign(this.cam, this._fitCam(b, padding, maxZoom));
		this._clamp();
	}

	_clampZoom(z) { return Math.max(this._minZoom(), Math.min(MAX_ZOOM, z)); }

	_clamp(cam = this.cam) {
		cam.zoom = this._clampZoom(cam.zoom);
		const b = this._bounds();
		cam.x = Math.max(b[0], Math.min(b[2], cam.x));
		cam.y = Math.max(b[1], Math.min(b[3], cam.y));
		return cam;
	}

	_zoomAt(sx, sy, zoom) {
		zoom = this._clampZoom(zoom);
		const X = (sx - this.W / 2) / this.cam.zoom + this.cam.x;
		const Y = (sy - this.H / 2) / this.cam.zoom + this.cam.y;
		this.cam.zoom = zoom;
		this.cam.x = X - (sx - this.W / 2) / zoom;
		this.cam.y = Y - (sy - this.H / 2) / zoom;
		this._clamp();
		this._changed();
	}

	_tween(to) {
		this._stop();
		const target = this._clamp({ ...to });
		const from = { ...this.cam };
		const far = Math.hypot(target.x - from.x, target.y - from.y) * Math.min(target.zoom, from.zoom) / Math.max(this.W, 1);
		this.anim = { from, to: target, t0: performance.now(), dur: Math.min(400, 250 + 150 * Math.min(1, far + Math.abs(Math.log2(target.zoom / from.zoom)) / 4)) };
		this.requestRender();
	}

	_stop() {
		this.anim = null;
		this.wheel = null;
		this.inertia = null;
	}

	_changed(data = false) {
		if (data) {
			this._layout();
			this._dirty = true;
		}
		this._overlayDirty = true;
		this._viewDirty = true;
		this.requestRender();
	}

	// Plane extents of the data per continent (continent rects without art).
	_extents() {
		const ext = new Map();
		const add = (c, wx, wy) => {
			c = Number(c);
			if (this.index?.continents?.[c] || !Number.isFinite(wx) || !Number.isFinite(wy)) return;
			const e = ext.get(c);
			const X = -wy, Y = -wx;
			if (!e) ext.set(c, [X, Y, X, Y]);
			else { e[0] = Math.min(e[0], X); e[1] = Math.min(e[1], Y); e[2] = Math.max(e[2], X); e[3] = Math.max(e[3], Y); }
		};
		for (const r of this.routes) for (let i = 0; i + 1 < (r.pts?.length || 0); i += 2) add(r.c, r.pts[i], r.pts[i + 1]);
		for (const k of ['areas', 'dots', 'markers', 'rings']) for (const p of this.scene[k]) add(p.c, p.wx, p.wy);
		for (const h of this.handles) add(h.c, h.wx, h.wy);
		this.dataExt = ext;
	}

	// ---- per-frame -------------------------------------------------------

	_animate(now) {
		const dt = Math.min(64, this._lastT ? now - this._lastT : 16);
		this._lastT = now;
		let more = false;
		if (this.anim) {
			const a = this.anim;
			const t = Math.min(1, (performance.now() - a.t0) / a.dur), e = ease(t);
			this.cam.zoom = Math.exp(Math.log(a.from.zoom) + (Math.log(a.to.zoom) - Math.log(a.from.zoom)) * e);
			this.cam.x = a.from.x + (a.to.x - a.from.x) * e;
			this.cam.y = a.from.y + (a.to.y - a.from.y) * e;
			if (t >= 1) this.anim = null;
			else more = true;
			this._changed();
		}
		if (this.wheel) {
			const w = this.wheel;
			const lz = Math.log(this.cam.zoom);
			const nz = lz + (w.target - lz) * (1 - Math.exp(-dt / 55));
			if (Math.abs(w.target - nz) < 0.002) {
				this._zoomAt(w.sx, w.sy, Math.exp(w.target));
				this.wheel = null;
			} else {
				this._zoomAt(w.sx, w.sy, Math.exp(nz));
				more = true;
			}
		}
		if (this.inertia) {
			const v = this.inertia;
			this.cam.x -= (v.vx * dt) / this.cam.zoom;
			this.cam.y -= (v.vy * dt) / this.cam.zoom;
			const k = Math.exp(-dt / 300);
			v.vx *= k;
			v.vy *= k;
			this._clamp();
			this._changed();
			if (Math.hypot(v.vx, v.vy) < 0.015) this.inertia = null;
			else more = true;
		}
		return more;
	}

	_syncSize() {
		const t = this._target;
		if (!t) return;
		this._target = null;
		const c = this.canvas;
		if (c.width !== t.pw || c.height !== t.ph) {
			c.width = Math.max(1, t.pw);
			c.height = Math.max(1, t.ph);
		}
		this.W = t.w;
		this.H = t.h;
		this.overlay.place();
		if (this.W > 0 && this._fitPending) {
			this._fitPending = false;
			this._fit(this._rect(this.c), 24, Infinity);
		}
		this._clamp();
		this._changed();
	}

	_frame(now) {
		if (this.destroyed || this.lost) return;
		const t0 = performance.now();
		this._syncSize();
		let more = this._animate(now);
		if (!this.W || !this.H) return;
		const gl = this.gl;
		this.dpr = this.canvas.width / this.W;
		if (this._dirty) this._rebuild();
		const lod = Math.round(Math.log2(this.cam.zoom));
		if (lod !== this._routeLod) {
			// Rebuilt per zoom octave: points closer than ~0.6 px merge.
			this._routeLod = lod;
			this.route.set(this.routes, (c) => this._off(Number(c)), 0.6 / 2 ** (lod + 0.5));
		}
		const cam = this.cam;
		const f = {
			cx: cam.x, cy: cam.y, zoom: cam.zoom, dpr: this.dpr, W: this.W, H: this.H,
			x0: cam.x - this.W / 2 / cam.zoom, x1: cam.x + this.W / 2 / cam.zoom,
			y0: cam.y - this.H / 2 / cam.zoom, y1: cam.y + this.H / 2 / cam.zoom,
			conts: this._shown(),
		};
		gl.viewport(0, 0, this.canvas.width, this.canvas.height);
		const sea = this.colors.sea;
		gl.clearColor(sea[0], sea[1], sea[2], 1);
		gl.clearStencil(0);
		gl.clear(gl.COLOR_BUFFER_BIT | gl.STENCIL_BUFFER_BIT);
		if (this.terrain && this.layers.terrain) more = this.terrain.draw(f, this.quad) || more;
		gl.enable(gl.BLEND);
		gl.blendFunc(gl.ONE, gl.ONE_MINUS_SRC_ALPHA);
		if (this.zoneArt && this.layers.zoneArt) more = this.zoneArt.draw(f, this.quad) || more;
		if (this.layers.grid || !this.terrain || !this.layers.terrain) this.grid.draw(f);
		if (this.walkable && this.layers.walkable) more = this.walkable.draw(f, this.quad) || more;
		if (this.roads && this.layers.roads) more = this.roads.draw(f, this.quad) || more;
		this.circles.drawUnion(f, this.inst.areas);
		if (this.hubs && this.layers.hubs) this.circles.draw(f, this.inst.hubDisks);
		if (this.layers.route) this.route.draw(f);
		if (this.legShown) this.preview.draw(f);
		if (this.aids && this.layers.aids) {
			this.aidRoute.draw(f);
			this.circles.draw(f, this.inst.aidRings);
		}
		this.circles.draw(f, this.inst.rings);
		if (this.layers.spawns) this.circles.draw(f, this.inst.dots);
		this.markers.draw(f, this.inst.glow);
		this.markers.draw(f);
		this.circles.draw(f, this.inst.pinRings);
		this.circles.draw(f, this.inst.handles);
		this._drawCharacter(f);
		if (this._overlayDirty) this._updateOverlay();
		this._emitView();
		this.stats.tiles = this.terrain ? this.terrain.ready : 0;
		const ms = performance.now() - t0;
		this.stats.lastMs = ms;
		this.stats.frameMs = this.stats.frameMs ? this.stats.frameMs * 0.9 + ms * 0.1 : ms;
		if (more) this.requestRender();
	}

	// A colour token of the page (without its --) as [r, g, b, a].
	token(name) {
		if (!this._tokens.has(name)) this._tokens.set(name, parseColor(this._css.getPropertyValue(`--${name}`), '#ffffff'));
		return this._tokens.get(name);
	}

	// The character: the Polestar arrow over its glow, turned to its heading.
	_drawCharacter(f) {
		const ch = this.character;
		if (!ch) return;
		const o = this._off(Number(ch.c));
		if (!o) return;
		const d = this._charData;
		d[0] = -ch.wy + o.ox; d[1] = -ch.wx + o.oy;
		d[2] = this.markers.atlas.ARROW; d[3] = ARROW; d[4] = 1; d[5] = 0; d[6] = ch.heading || 0;
		this.inst.arrow.set(d, 1);
		this.markers.draw(f, this.inst.arrow);
	}

	_rebuild() {
		this._dirty = false;
		const off = (c) => this._off(Number(c));
		const col = this.colors;
		this._routeLod = null;
		// areas
		const s = this.scene;
		let d = new Float32Array(Math.max(1, s.areas.length) * CIRCLE_STRIDE), k = 0;
		for (const a of s.areas) {
			const o = off(a.c);
			if (!o || !(a.r > 0)) continue;
			const alt = a.kind === 'alt';
			const c = this.token(a.tint || 'place');
			k = circle(d, k, -a.wy + o.ox, -a.wx + o.oy, a.r, 0, pm(c, alt ? 0.14 : 0.32), pm(c, alt ? 0.3 : 0.55), 1, 0, 0, 4);
		}
		this.inst.areas.set(d, k / CIRCLE_STRIDE);
		// rings
		d = new Float32Array(Math.max(1, s.rings.length) * CIRCLE_STRIDE);
		k = 0;
		for (const r of s.rings) {
			const o = off(r.c);
			if (!o || !(r.r > 0)) continue;
			k = circle(d, k, -r.wy + o.ox, -r.wx + o.oy, r.r, 0, NONE, pm(col.accent, 0.8), 1.5, 6, 4, 5);
		}
		this.inst.rings.set(d, k / CIRCLE_STRIDE);
		// dots
		d = new Float32Array(Math.max(1, s.dots.length) * CIRCLE_STRIDE);
		k = 0;
		for (const p of s.dots) {
			const o = off(p.c);
			if (!o) continue;
			const faint = p.kind === 'alt' || p.kind === 'done';
			const fill = faint ? pm(this.token('textMuted'), 0.7) : pm(this.token(p.tint || 'danger'));
			k = circle(d, k, -p.wy + o.ox, -p.wx + o.oy, 0, 3, fill, pm(col.shade, 0.6), 1);
		}
		this.inst.dots.set(d, k / CIRCLE_STRIDE);
		// markers: done, then the rest, active last (on top)
		const order = (m) => (m.active ? 2 : m.done ? 0 : 1);
		this._markers = s.markers.filter((m) => off(m.c)).sort((a, b) => order(a) - order(b));
		d = new Float32Array(Math.max(1, this._markers.length) * 7);
		const rings = new Float32Array(Math.max(1, this._markers.length) * 2 * CIRCLE_STRIDE);
		const glow = new Float32Array(Math.max(1, this._markers.length) * 7);
		let kr = 0;
		let kg = 0;
		k = 0;
		const atlas = this.markers.atlas;
		for (const m of this._markers) {
			const o = off(m.c);
			const x = -m.wy + o.ox, y = -m.wx + o.oy;
			d[k++] = x; d[k++] = y;
			d[k++] = atlas.cell(m);
			d[k++] = m.active ? PIN_ACTIVE : PIN;
			d[k++] = m.done && !m.active ? 0.6 : 1;
			d[k++] = m.done && !m.active ? 1 : 0;
			d[k++] = 0;
			if (m.active) {
				// a scrim rim just outside the gold ring, so the glow reads on light ground
				kr = circle(rings, kr, x, y, 0, PIN_ACTIVE / 2 + 4, NONE, pm(this.token('scrim'), 0.85), 2.5);
				kr = circle(rings, kr, x, y, 0, PIN_ACTIVE / 2 + 1.5, NONE, pm(col.accent), 2);
				// the Starlight glow: the guiding mark's halo in the accent at 50%
				glow[kg++] = x; glow[kg++] = y; glow[kg++] = atlas.GLOW; glow[kg++] = PIN_ACTIVE * 2.4; glow[kg++] = 1; glow[kg++] = 0; glow[kg++] = 0;
			}
		}
		this.inst.glow.set(glow, kg / 7);
		this.markers.inst.set(d, k / 7);
		this.inst.pinRings.set(rings, kr / CIRCLE_STRIDE);
		this._rebuildHandles();
		this._rebuildAids();
		this._rebuildHubs();
	}

	// The arrow aids: crossing ends and chain nodes as rings of their radius
	// (at least 4 px), a crossing's ends joined by a long dash, a chain's
	// nodes by a solid line.
	_rebuildAids() {
		const a = this.aids;
		const off = (c) => this._off(Number(c));
		const lines = [];
		const ends = [];
		for (const x of a?.crossings || []) {
			lines.push({ c: x.a.c, pts: new Float32Array([x.a.wx, x.a.wy, x.b.wx, x.b.wy]), mode: 'boat', state: 'current' });
			ends.push(x.a, x.b);
		}
		for (const ch of a?.chains || []) {
			lines.push({ c: ch.c, pts: new Float32Array(ch.nodes.flatMap((n) => [n.wx, n.wy])), mode: 'walk', state: 'current' });
			ends.push(...ch.nodes);
		}
		this.aidRoute.set(lines, off, 0);
		const d = new Float32Array(Math.max(1, ends.length) * CIRCLE_STRIDE);
		let k = 0;
		const aid = this.colors.aid;
		for (const p of ends) {
			const o = off(p.c);
			if (!o) continue;
			k = circle(d, k, -p.wy + o.ox, -p.wx + o.oy, p.r || 0, 0, pm(aid, 0.1), pm(aid, 0.9), 1.5, 0, 0, 4);
		}
		this.inst.aidRings.set(d, k / CIRCLE_STRIDE);
	}

	// The hostile hubs: every disk of a hub as a translucent circle in its side's colour.
	_rebuildHubs() {
		const list = [];
		for (const [c, hubs] of Object.entries(this.hubs || {})) if (Array.isArray(hubs)) for (const h of hubs) list.push([Number(c), h]);
		const d = new Float32Array(Math.max(1, list.reduce((n, [, h]) => n + h.disks.length, 0)) * CIRCLE_STRIDE);
		let k = 0;
		for (const [c, h] of list) {
			const o = this._off(c);
			if (!o) continue;
			const col = this.token(h.side === 'Horde' ? 'danger' : 'npc');
			for (const [x, y, r] of h.disks) k = circle(d, k, -y + o.ox, -x + o.oy, r, 0, pm(col, 0.12), pm(col, 0.45), 1, 0, 0, 4);
		}
		this.inst.hubDisks.set(d, k / CIRCLE_STRIDE);
	}

	_handleAt(h) {
		return this.drag && this.drag.id === h.id ? { ...h, ...this.drag } : h;
	}

	_rebuildHandles() {
		const d = new Float32Array(Math.max(1, this.handles.length * 2) * CIRCLE_STRIDE);
		let k = 0;
		for (const h0 of this.handles) {
			const h = this._handleAt(h0);
			const o = this._off(Number(h.c));
			if (!o) continue;
			const x = -h.wy + o.ox, y = -h.wx + o.oy;
			const hot = this.hover && this.hover.handle?.id === h.id ? this.hover.part : null;
			if (h.r != null && h.r > 0) k = circle(d, k, x, y, h.r, 0, pm(this.colors.ink, 0.05), hot === 'ring' ? pm(this.colors.accent) : pm(this.colors.ink, 0.8), hot === 'ring' ? 2.5 : 1.5, 0, 0, 4);
		}
		for (const h0 of this.handles) {
			const h = this._handleAt(h0);
			const o = this._off(Number(h.c));
			if (!o) continue;
			const x = -h.wy + o.ox, y = -h.wx + o.oy;
			const hot = this.hover && this.hover.handle?.id === h.id && this.hover.part === 'point';
			const fill = h.explicit === false ? pm(this.token('scrim'), 0.55) : pm(this.token(h.tint || 'place'));
			k = circle(d, k, x, y, 0, hot ? 9 : 7.5, fill, pm(hot ? this.colors.accent : this.colors.ink), 2);
		}
		this.inst.handles.set(d, k / CIRCLE_STRIDE);
		this._overlayDirty = true;
	}

	_updateOverlay() {
		this._overlayDirty = false;
		const items = [];
		const z = this.cam.zoom;
		// Every drawn pin disc (as drawn + 2 px) is an obstacle for labels.
		const pins = [];
		for (const m of this._markers || []) {
			const p = this.toScreen(m.c, m.wx, m.wy);
			if (p) pins.push([p.x, p.y, (m.active ? PIN_ACTIVE / 2 + 5.25 : PIN / 2) + 2]);
		}
		for (const h0 of this.handles) {
			const h = this._handleAt(h0);
			const p = this.toScreen(h.c, h.wx, h.wy);
			if (p) pins.push([p.x, p.y, 9 + 2]);
		}
		// Pill labels first, by priority (the active goal, then the step's
		// handles); they collide with each other and with the map's controls.
		if (this.layers.labels) {
			// One label per goal: a goal with an edit handle is labelled by its handle.
			const handled = new Set(this.handles.map((h) => h.label));
			for (const m of this._markers || []) {
				if (!m.active || !m.label || handled.has(m.label)) continue;
				const p = this.toScreen(m.c, m.wx, m.wy);
				if (!p) continue;
				items.push({ key: `m:${m.step}:${m.label}:${m.wx}:${m.wy}`, text: m.label, cls: 'mv-pill', x: p.x, y: p.y, anchor: 'pin', r: 22, collide: true });
			}
		}
		const hs = [...this.handles].sort((a, b) => !!b.selected - !!a.selected);
		for (const h0 of hs) {
			if (!h0.label) continue;
			const h = this._handleAt(h0);
			const p = this.toScreen(h.c, h.wx, h.wy);
			if (!p) continue;
			items.push({ key: `h:${h.id}`, text: h.label, cls: 'mv-pill mv-handle', x: p.x, y: p.y, anchor: 'pin', r: 12, collide: true });
		}
		if (this.hubs && this.layers.hubs) {
			for (const [c, hubs] of Object.entries(this.hubs)) {
				if (!Array.isArray(hubs)) continue;
				for (const h of hubs) {
					const [x, y] = h.disks[0];
					const p = this.toScreen(Number(c), x, y);
					if (p) items.push({ key: `hub:${h.id}`, text: h.name, cls: `mv-hub ${h.side === 'Horde' ? 'horde' : 'alliance'}`, x: p.x, y: p.y, anchor: 'pin', r: 8, collide: true });
				}
			}
		}
		if (this.aids && this.layers.aids) {
			const at = (c, wx, wy, key, text) => {
				const p = this.toScreen(c, wx, wy);
				if (p && text) items.push({ key, text, cls: 'mv-aid', x: p.x, y: p.y, anchor: 'pin', r: 8, collide: true });
			};
			for (const x of this.aids.crossings) at(x.a.c, (x.a.wx + x.b.wx) / 2, (x.a.wy + x.b.wy) / 2, `x:${x.id}:${x.a.wx}`, x.ab || x.ba || x.id);
			for (const ch of this.aids.chains) {
				at(ch.c, ch.nodes[0].wx, ch.nodes[0].wy, `ch:${ch.id}`, ch.name || ch.id);
				ch.nodes.forEach((n, i) => i > 0 && at(ch.c, n.wx, n.wy, `cn:${ch.id}:${i}`, n.caption));
			}
		}
		if (this.layers.labels && this.index) {
			const shown = new Map(this._shown().map((s) => [s.c, s]));
			if (z < ZONE_LABELS[0]) {
				for (const [c, ci] of Object.entries(this.index.continents || {})) {
					const o = shown.get(Number(c));
					if (!o) continue;
					const r = this._rect(Number(c));
					items.push({ key: `c:${c}`, text: ci.name, cls: 'mv-zone mv-cont', collide: true,
						x: ((r[0] + r[2]) / 2 + o.ox - this.cam.x) * z + this.W / 2, y: ((r[1] + r[3]) / 2 + o.oy - this.cam.y) * z + this.H / 2 });
				}
			} else if (z <= ZONE_LABELS[1]) {
				for (const zn of this.zoneArt?.zones || []) {
					const o = shown.get(Number(zn.c));
					if (!o) continue;
					const sw = (zn.x1 - zn.x0) * z;
					if (sw < 40) continue;
					items.push({ key: `z:${zn.id}`, text: zn.name, cls: 'mv-zone', collide: true,
						x: ((zn.x0 + zn.x1) / 2 + o.ox - this.cam.x) * z + this.W / 2, y: ((zn.y0 + zn.y1) / 2 + o.oy - this.cam.y) * z + this.H / 2 });
				}
			}
		}
		this.overlay.update(items, this.W, this.H, this.opts.reserved ? this.opts.reserved() : [], pins);
	}

	_emitView() {
		if (!this._viewDirty) return;
		const now = performance.now();
		const wait = 100 - (now - this._lastView);
		if (wait > 0) {
			if (!this._viewTimer) this._viewTimer = setTimeout(() => { this._viewTimer = 0; this._emitView(); }, wait);
			return;
		}
		this._viewDirty = false;
		this._lastView = now;
		this._emit('view', this.view);
	}

	// ---- interaction -----------------------------------------------------

	_bind() {
		const c = this.canvas;
		if (!c.hasAttribute('tabindex')) {
			c.tabIndex = 0;
			c.style.outline = 'none';
		}
		c.style.touchAction = 'none';
		c.style.cursor = 'grab';
		this._handlers = [];
		const on = (t, ev, fn, o) => {
			t.addEventListener(ev, fn, o);
			this._handlers.push([t, ev, fn, o]);
		};
		on(c, 'pointerdown', (e) => this._down(e));
		on(c, 'pointermove', (e) => this._move(e));
		on(c, 'pointerup', (e) => this._up(e, false));
		on(c, 'pointercancel', (e) => this._up(e, true));
		on(c, 'pointerleave', () => { if (!this.press) this._setHover(null); });
		on(c, 'wheel', (e) => this._wheel(e), { passive: false });
		on(c, 'dblclick', (e) => this._dbl(e));
		on(c, 'keydown', (e) => this._key(e));
		on(c, 'contextmenu', (e) => e.preventDefault());
		on(c, 'webglcontextlost', (e) => { e.preventDefault(); this.lost = true; });
		on(c, 'webglcontextrestored', () => {
			this.lost = false;
			// the old textures died with the context; dispose() also stops
			// their loads from creating textures on the new one
			this.terrain?.dispose();
			this.zoneArt?.dispose();
			this.walkable?.dispose();
			this.roads?.dispose();
			this._initGL();
			this.requestRender();
		});
		this._ro = new ResizeObserver(() => this.resize());
		this._ro.observe(c);
	}

	_xy(e) {
		const r = this.canvas.getBoundingClientRect();
		return [e.clientX - r.left, e.clientY - r.top];
	}

	_hit(sx, sy) {
		const z = this.cam.zoom;
		for (let i = this.handles.length - 1; i >= 0; i--) {
			const h = this._handleAt(this.handles[i]);
			const p = this.toScreen(h.c, h.wx, h.wy);
			if (p && Math.hypot(p.x - sx, p.y - sy) <= 11) return { type: 'handle', handle: this.handles[i], part: 'point' };
		}
		for (let i = this.handles.length - 1; i >= 0; i--) {
			const h = this._handleAt(this.handles[i]);
			if (h.r == null || !(h.r > 0)) continue;
			const p = this.toScreen(h.c, h.wx, h.wy);
			if (p && Math.abs(Math.hypot(p.x - sx, p.y - sy) - Math.max(h.r * z, 4)) <= 6) return { type: 'handle', handle: this.handles[i], part: 'ring' };
		}
		const ms = this._markers || [];
		for (let i = ms.length - 1; i >= 0; i--) {
			const m = ms[i];
			const p = this.toScreen(m.c, m.wx, m.wy);
			if (p && Math.hypot(p.x - sx, p.y - sy) <= (m.active ? 16 : 12.5) + 2) return { type: 'marker', marker: m };
		}
		const leg = this.legHit ? this.legHit(sx, sy) : null;
		if (leg) return { type: 'leg', leg };
		return null;
	}

	setLegHit(fn) {
		this.legHit = fn || null;
		if (!fn) {
			this._legHeld = false;
			this._showLeg(null);
		}
	}

	// A refused bend: drop the held preview.
	releaseLeg() {
		this._legHeld = false;
		this._showLeg(null);
	}

	// Draws `leg` hovered (bend null: its own path) or bent through bend; null hides it.
	_showLeg(leg, bend = null, at = null) {
		this.legShown = leg ? { leg, bend } : null;
		if (leg) {
			const pts = bend ? new Float32Array([leg.from.wx, leg.from.wy, bend.wx, bend.wy, leg.to.wx, leg.to.wy]) : leg.pts;
			this.preview.set([{ c: leg.c, pts, mode: 'walk', state: 'current' }], (c) => this._off(Number(c)), 0);
		}
		this._addMark(leg && at ? at : null);
		this.requestRender();
	}

	// The add mark under the pointer on a leg: the pin-add glyph on a disc.
	_addMark(at) {
		if (!this._add) {
			this._add = document.createElement('div');
			this._add.className = 'mv-add';
			this.overlay.el.appendChild(this._add);
		}
		this._add.style.display = at ? '' : 'none';
		if (at) this._add.style.transform = `translate3d(${Math.round(at.x)}px, ${Math.round(at.y)}px, 0)`;
	}

	_setHover(hit) {
		if (hit?.type === 'leg') {
			if (!this.press) this._showLeg(hit.leg, null, { x: hit.leg.sx, y: hit.leg.sy });
		} else if (this.legShown && !this.press?.dragging && !this._legHeld) this._showLeg(null);
		const key = (h) => (h ? `${h.type}:${h.handle?.id ?? ''}:${h.part ?? ''}:${h.marker ? this._markers.indexOf(h.marker) : ''}:${h.leg ? h.leg.key : ''}` : '');
		if (key(hit) === key(this.hover)) return;
		this.hover = hit;
		this.canvas.style.cursor = !hit ? 'grab' : hit.type === 'marker' ? 'pointer' : hit.type === 'leg' ? 'copy' : hit.part === 'ring' ? 'ew-resize' : 'move';
		this._rebuildHandles();
		this.requestRender();
	}

	_down(e) {
		if (e.button !== 0 && e.pointerType === 'mouse') return;
		this.canvas.setPointerCapture(e.pointerId);
		this.canvas.focus({ preventScroll: true });
		const [sx, sy] = this._xy(e);
		this.pointers.set(e.pointerId, { sx, sy });
		this._stop();
		if (this.pointers.size === 2) {
			if (this.press?.dragging && this.press.hit?.type === 'handle') this._endHandle();
			this.press = null;
			const [a, b] = [...this.pointers.values()];
			this.pinch = { d: Math.hypot(a.sx - b.sx, a.sy - b.sy), mx: (a.sx + b.sx) / 2, my: (a.sy + b.sy) / 2 };
			return;
		}
		if (this.pointers.size > 2) return;
		const hit = this._hit(sx, sy);
		this.press = { id: e.pointerId, x0: sx, y0: sy, sx, sy, hit, dragging: false, samples: [[performance.now(), sx, sy]] };
	}

	_move(e) {
		const [sx, sy] = this._xy(e);
		if (this.pointers.has(e.pointerId)) this.pointers.set(e.pointerId, { sx, sy });
		if (this.pinch && this.pointers.size >= 2) {
			const [a, b] = [...this.pointers.values()];
			const d = Math.hypot(a.sx - b.sx, a.sy - b.sy), mx = (a.sx + b.sx) / 2, my = (a.sy + b.sy) / 2;
			const p = this.pinch;
			this.cam.x -= (mx - p.mx) / this.cam.zoom;
			this.cam.y -= (my - p.my) / this.cam.zoom;
			if (p.d > 0) this._zoomAt(mx, my, this.cam.zoom * (d / p.d));
			this._clamp();
			this._changed();
			Object.assign(p, { d, mx, my });
			return;
		}
		const pr = this.press;
		if (!pr || pr.id !== e.pointerId) {
			if (!this.pointers.size) this._setHover(this._hit(sx, sy));
			return;
		}
		if (!pr.dragging && Math.hypot(sx - pr.x0, sy - pr.y0) > 3) {
			pr.dragging = true;
			if (pr.hit?.type === 'handle') {
				const h = this._handleAt(pr.hit.handle);
				const w = this._worldOn(h.c, pr.x0, pr.y0);
				pr.grab = { dwx: h.wx - w.wx, dwy: h.wy - w.wy };
				this.drag = { id: h.id, c: h.c, wx: h.wx, wy: h.wy, r: h.r ?? null };
				this._emitHandle('start', pr.hit.part);
			} else {
				this.canvas.style.cursor = 'grabbing';
			}
			if (pr.hit?.type === 'leg') this._addMark(null);
		}
		if (!pr.dragging) return;
		if (pr.hit?.type === 'handle') {
			const h = pr.hit.handle;
			const w = this._worldOn(h.c, sx, sy);
			if (pr.hit.part === 'ring') {
				this.drag.r = Math.max(1, Math.round(Math.hypot(w.wx - this.drag.wx, w.wy - this.drag.wy)));
			} else {
				this.drag.wx = w.wx + pr.grab.dwx;
				this.drag.wy = w.wy + pr.grab.dwy;
			}
			this._rebuildHandles();
			this._emitHandle('move', pr.hit.part);
			this.requestRender();
		} else if (pr.hit?.type === 'leg') {
			// rubber band: the leg bent through the pointer
			const leg = pr.hit.leg;
			const w = this._worldOn(leg.c, sx, sy);
			pr.bend = w;
			this._showLeg(leg, w);
		} else {
			this.cam.x -= (sx - pr.sx) / this.cam.zoom;
			this.cam.y -= (sy - pr.sy) / this.cam.zoom;
			this._clamp();
			this._changed();
			const now = performance.now();
			pr.samples.push([now, sx, sy]);
			while (pr.samples.length > 2 && now - pr.samples[0][0] > 100) pr.samples.shift();
		}
		pr.sx = sx;
		pr.sy = sy;
	}

	_up(e, cancel) {
		this.pointers.delete(e.pointerId);
		if (this.pinch) {
			if (this.pointers.size < 2) this.pinch = null;
			return;
		}
		const pr = this.press;
		if (!pr || pr.id !== e.pointerId) return;
		this.press = null;
		const [sx, sy] = this._xy(e);
		if (!pr.dragging) {
			if (cancel) return;
			const w = this.toWorld(sx, sy);
			const hit = pr.hit;
			if (hit?.type === 'leg') {
				const lw = this._worldOn(hit.leg.c, sx, sy);
				this._showLeg(null);
				this._emit('leg', { leg: hit.leg, c: hit.leg.c, wx: lw.wx, wy: lw.wy });
				return;
			}
			this._emit('pick', { c: w.c, wx: w.wx, wy: w.wy, sx, sy, hit, event: e });
			if (hit?.type === 'marker') this._emit('marker', { marker: hit.marker, step: hit.marker.step });
			return;
		}
		if (pr.hit?.type === 'handle') {
			this._endHandle(pr.hit.part);
			return;
		}
		if (pr.hit?.type === 'leg') {
			this.canvas.style.cursor = 'grab';
			// the bent leg stays drawn until the new route arrives (setRoute)
			if (cancel || !pr.bend) this._showLeg(null);
			else {
				this._legHeld = true;
				this._emit('leg', { leg: pr.hit.leg, c: pr.hit.leg.c, wx: pr.bend.wx, wy: pr.bend.wy });
			}
			return;
		}
		this.canvas.style.cursor = 'grab';
		const s = pr.samples, now = performance.now();
		const a = s[0], b = s[s.length - 1];
		const dt = b[0] - a[0];
		if (!cancel && dt > 0 && now - b[0] < 60) {
			const vx = (b[1] - a[1]) / dt, vy = (b[2] - a[2]) / dt;
			if (Math.hypot(vx, vy) > 0.1) {
				this.inertia = { vx, vy };
				this.requestRender();
			}
		}
	}

	_endHandle(part = 'point') {
		this._emitHandle('end', part);
	}

	_emitHandle(phase, part) {
		const d = this.drag;
		const h = this.handles.find((x) => x.id === d.id) || d;
		this._emit('handle', { id: d.id, phase, part, c: d.c, wx: d.wx, wy: d.wy, r: d.r, handle: h });
	}

	_worldOn(c, sx, sy) {
		const o = this._off(Number(c)) || { ox: 0, oy: 0 };
		const X = (sx - this.W / 2) / this.cam.zoom + this.cam.x - o.ox;
		const Y = (sy - this.H / 2) / this.cam.zoom + this.cam.y - o.oy;
		return { wx: -Y, wy: -X };
	}

	_wheel(e) {
		e.preventDefault();
		const [sx, sy] = this._xy(e);
		const dy = e.deltaMode === 1 ? e.deltaY * 40 : e.deltaMode === 2 ? e.deltaY * 800 : e.deltaY;
		const k = e.ctrlKey ? 0.01 : 0.003;
		this.anim = null;
		this.inertia = null;
		const lo = Math.log(this._minZoom()), hi = Math.log(MAX_ZOOM);
		const base = this.wheel ? this.wheel.target : Math.log(this.cam.zoom);
		this.wheel = { target: Math.max(lo, Math.min(hi, base - dy * k)), sx, sy };
		this.requestRender();
	}

	_dbl(e) {
		const [sx, sy] = this._xy(e);
		const z = this._clampZoom(this.cam.zoom * (e.shiftKey ? 0.5 : 2));
		const X = (sx - this.W / 2) / this.cam.zoom + this.cam.x;
		const Y = (sy - this.H / 2) / this.cam.zoom + this.cam.y;
		this._tween({ x: X - (sx - this.W / 2) / z, y: Y - (sy - this.H / 2) / z, zoom: z });
	}

	_key(e) {
		if (e.ctrlKey || e.metaKey || e.altKey) return;
		if (e.key === '+' || e.key === '=') this.zoomBy(1.6);
		else if (e.key === '-' || e.key === '_') this.zoomBy(1 / 1.6);
		else return;
		e.preventDefault();
	}
}
