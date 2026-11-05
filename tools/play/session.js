'use strict';
// One playground session: a long-lived Lua 5.1 process running the real
// addons (Polestar, Polestar_Guides, and the data packs Polestar_QuestDB,
// Polestar_ItemDB and Polestar_Codex loaded on demand when built, and
// Polestar_Nav, the walking engine, its maps decoded by
// tests/lua/stub_encoding.lua) against the
// test client stub, the stub world and the preview overlay, driven through
// tools/play/driver.lua. Each interaction runs one Lua chunk, lets stub time
// run, dumps the visible frames and draws them with tools/preview/render.js,
// returning the SVG, the hit map (tools/play/public/hit.js) and the state.
// `packs`: other guide packs' built folders (absolute), loaded by their TOC
// after Polestar_Guides, as the client loads them.
//
//   const s = new Session({ dataDir, artDir, config, packs });
//   await s.start();
//   const frame = await s.act({ type: 'click', id, x, y });   // { svg, glyphs, hits, state, errors, timing }
//   await s.stop({ save: true });
//
// The character and their SavedVariables live in dataDir (data/play/):
//   config.json                    race, class, faction, EllesmereUI on/off
//   SavedVariables/Polestar.lua    PolestarDB, as the client writes it
//   Character/Polestar.lua         PolestarCharDB
//   world.lua                      the stub world (level, place, quest log...)

const { spawn } = require('node:child_process');
const crypto = require('node:crypto');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { findLua } = require('../lib/lua');
const { tocFiles, dirFiles } = require('../../tests/helpers/lua');
const { localPacks } = require('../../tests/helpers/profile');
const { SIMULATE, HOME, luaValue } = require('../lib/playtest');
const { Font } = require('../preview/font');
const { svg, TextureCache, readTGA, png } = require('../preview/render');

const { ROOT, DATA } = require('../lib/paths');
const STUBS = path.join(ROOT, 'tests', 'lua');
const MEDIA = path.join(ROOT, 'addon', 'Polestar', 'Media');
const FOREVER = DATA;
const SCREEN = { x: 0, y: 0, w: 1920, h: 1080 };

const FONT_FILES = ['Inter-Regular.ttf', 'Inter-Medium.ttf', 'Inter-SemiBold.ttf'];
const FALLBACK = 'Inter-Medium.ttf';

const CLASS_IDS = { WARRIOR: 1, PALADIN: 2, HUNTER: 3, ROGUE: 4, PRIEST: 5, SHAMAN: 7, MAGE: 8, WARLOCK: 9, DRUID: 11 };
const CLASS_NAMES = { WARRIOR: 'Warrior', PALADIN: 'Paladin', HUNTER: 'Hunter', ROGUE: 'Rogue', PRIEST: 'Priest', SHAMAN: 'Shaman', MAGE: 'Mage', WARLOCK: 'Warlock', DRUID: 'Druid' };
const RACE_NAMES = { Human: 'Human', Orc: 'Orc', Dwarf: 'Dwarf', NightElf: 'Night Elf', Scourge: 'Undead', Tauren: 'Tauren', Gnome: 'Gnome', Troll: 'Troll', Skyborne: 'Skyborne' };

// The goal logic of the guide simulator (tools/lib/playtest.js): its
// setup and act(), without the loop that plays the whole guide.
const SIM_CUT = 'local visited, stuck, guard';
function simActSource() {
	const cut = SIMULATE.indexOf(SIM_CUT);
	if (cut < 0) throw new Error(`tools/lib/playtest.js SIMULATE no longer has "${SIM_CUT}": update tools/play/session.js`);
	return SIMULATE.slice(0, cut);
}

function luaString(s) {
	return '"' + String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n').replace(/\r/g, '\\r') + '"';
}

// ---------------------------------------------------------------------------
// Shared, built once per process: fonts and their metrics, reference data.

let shared = null;
function sharedData() {
	if (shared) return shared;
	const fonts = {};
	for (const f of FONT_FILES) fonts[f] = new Font(path.join(MEDIA, 'Fonts', f));
	const proxy = new Proxy(fonts, { get: (t, k) => t[k] || t[FALLBACK] });
	const cps = [];
	for (let c = 32; c < 127; c++) cps.push(c);
	for (let c = 0xa0; c < 0x180; c++) cps.push(c);
	cps.push(0x2013, 0x2014, 0x2018, 0x2019, 0x201c, 0x201d, 0x2026, 0x2022, 0x00b7, 0x00d7, 0x2192);
	const parts = FONT_FILES.map((file) => {
		const f = fonts[file];
		const adv = cps.map((c) => `[${c}]=${f.advanceEm(c).toFixed(5)}`).join(',');
		return `[${JSON.stringify(file)}]={upm=${f.upm},fallback=${f.advanceEm(0x6e).toFixed(5)},adv={${adv}}}`;
	});
	const metrics = `preview = { metrics = { ${parts.join(',')} }, fallbackFont = ${JSON.stringify(FALLBACK)} }`;
	const races = JSON.parse(fs.readFileSync(path.join(FOREVER, 'races.json'), 'utf8'));
	const frameTables = JSON.parse(fs.readFileSync(path.join(FOREVER, 'map-frames.json'), 'utf8'));
	const frames = { ...(frameTables.forever || {}), ...frameTables.era };
	const zonesJson = JSON.parse(fs.readFileSync(path.join(FOREVER, 'zones.json'), 'utf8'));
	const zones = Object.entries(frames)
		.map(([id, f]) => ({ id: Number(id), name: (zonesJson[id] && zonesJson[id].name) || '', c: f.c }))
		.filter((z) => z.name);
	const mapsLua = Object.entries(frames)
		.map(([id, f]) => `w.addMap(${id}, { name = ${luaString((zonesJson[id] && zonesJson[id].name) || '')}, c = ${f.c}, left = ${f.left}, right = ${f.right}, top = ${f.top}, bottom = ${f.bottom} })`)
		.join('\n');
	shared = { fonts: proxy, metrics, races, zones, mapsLua };
	return shared;
}

// ---------------------------------------------------------------------------
// Textures served by URL (/tex/<hash>.png), so a frame's SVG stays small and
// the browser caches each tinted crop once.

class UrlTextures extends TextureCache {
	constructor(mediaDir, clientArt) {
		super(mediaDir, clientArt);
		this.byHash = new Map();
		this.hashOf = new Map();
		this.pngs = new Map();
	}
	uri(name, tint, tc, desat = 0) {
		if (!this.load(name)) return null;
		const key = `${name}|${tint.join(',')}|${tc ? tc.join(',') : ''}|${desat}`;
		let h = this.hashOf.get(key);
		if (!h) {
			h = crypto.createHash('sha1').update(key).digest('hex').slice(0, 16);
			this.hashOf.set(key, h);
			this.byHash.set(h, [name, tint, tc, desat]);
		}
		return `/tex/${h}.png`;
	}
	png(hash) {
		if (this.pngs.has(hash)) return this.pngs.get(hash);
		const args = this.byHash.get(hash);
		if (!args) return null;
		const u = super.uri(...args);
		const buf = u ? Buffer.from(u.slice(u.indexOf(',') + 1), 'base64') : null;
		this.pngs.set(hash, buf);
		return buf;
	}
}

// A zone's whole painting (its art layer's tiles), from the local art cache.
function zoneArtPng(artDir, mapID, cache) {
	if (!artDir) return null;
	if (cache.has(mapID)) return cache.get(mapID);
	let out = null;
	try {
		const maps = JSON.parse(fs.readFileSync(path.join(artDir, 'maps.json'), 'utf8'));
		const m = maps[mapID];
		if (m && m.layer && m.textures) {
			const { layerWidth: W, layerHeight: H, tileWidth: tw, tileHeight: th } = m.layer;
			const cols = Math.ceil(W / tw);
			const px = Buffer.alloc(W * H * 4);
			m.textures.forEach((fid, i) => {
				const file = path.join(artDir, `${fid}.tga`);
				if (!fs.existsSync(file)) return;
				const t = readTGA(file);
				const ox = (i % cols) * tw, oy = Math.floor(i / cols) * th;
				for (let y = 0; y < Math.min(th, t.h, H - oy); y++) {
					for (let x = 0; x < Math.min(tw, t.w, W - ox); x++) {
						const s = (Math.floor((y * t.h) / th) * t.w + Math.floor((x * t.w) / tw)) * 4;
						const d = ((oy + y) * W + ox + x) * 4;
						px[d] = t.px[s]; px[d + 1] = t.px[s + 1]; px[d + 2] = t.px[s + 2]; px[d + 3] = 255;
					}
				}
			});
			out = png(W, H, px);
		}
	} catch {
		out = null;
	}
	cache.set(mapID, out);
	return out;
}

function artMaps(artDir) {
	if (!artDir) return {};
	try {
		return JSON.parse(fs.readFileSync(path.join(artDir, 'maps.json'), 'utf8'));
	} catch {
		return {};
	}
}

// ---------------------------------------------------------------------------
// Hit map: the mouse- and wheel-enabled frames as drawn, back to front, each
// clipped by its clipping ancestors (tools/play/public/hit.js tests it).

function intersect(a, b) {
	const x = Math.max(a[0], b[0]), y = Math.max(a[1], b[1]);
	const r = Math.min(a[0] + a[2], b[0] + b[2]), btm = Math.min(a[1] + a[3], b[1] + b[3]);
	return [x, y, Math.max(0, r - x), Math.max(0, btm - y)];
}
const round = (v) => Math.round(v * 10) / 10;

function hitMap(layout) {
	const { frames, rects, clipOf } = layout;
	const hits = [];
	for (const f of frames) {
		if (!f.mouse && !f.wheel) continue;
		const r = rects.get(f.id);
		if (!r || r.w <= 0 || r.h <= 0) continue;
		let clip = null;
		for (let c = clipOf(f); c; c = clipOf(c)) {
			const cr = rects.get(c.id);
			const box = [cr.x, cr.y, cr.w, cr.h];
			clip = clip ? intersect(clip, box) : box;
		}
		const h = { id: f.id, r: [round(r.x), round(r.y), round(r.w), round(r.h)] };
		if (clip) h.c = clip.map(round);
		if (f.mouse) h.m = 1;
		if (f.wheel) h.w = 1;
		if (f.drag) h.d = 1;
		if (f.disabled) h.x = 1;
		if (f.kind !== 'Frame') h.k = f.kind;
		if (f.name) h.n = f.name;
		hits.push(h);
	}
	return hits;
}

// ---------------------------------------------------------------------------
// The session

const ADVANCE = { hover: 0.25, leave: 0.25, dragMove: 0.05, dragStart: 0.05, render: 0, default: 0.4 };

class Session {
	constructor({ dataDir, artDir = null, config = {}, packs = [], timeoutMs = 60000, log = () => {} }) {
		this.dataDir = dataDir;
		this.packs = packs;
		this.artDir = artDir && fs.existsSync(path.join(artDir, 'maps.json')) ? artDir : null;
		this.config = config;
		this.timeoutMs = timeoutMs;
		this.log = log;
		this.data = sharedData();
		this.textures = new UrlTextures(path.join(MEDIA, 'UI'), this.artDir);
		this.glyphs = { glyphs: new Set(), defs: [] };
		this.art = artMaps(this.artDir);
		this.proc = null;
		this.queue = Promise.resolve();
		this.pending = null;
		this.buffer = '';
		this.errorSeq = 0;
		this.lastSave = Date.now();
		this.generation = 0;
		this.crashes = [];
	}

	file(...p) {
		return path.join(this.dataDir, ...p);
	}

	// The character: config.json, or a fresh level 1 Human warrior.
	character() {
		const races = this.data.races;
		let { race = 'Human', cls = 'WARRIOR', faction } = this.config;
		if (!races[race]) race = 'Human';
		const factions = Object.keys(races[race]);
		if (!factions.includes(faction)) faction = factions[0];
		if (!races[race][faction].classes.includes(cls)) cls = races[race][faction].classes[0];
		return { race, cls, faction, id: races[race][faction].id };
	}

	program() {
		const d = this.data;
		const ch = this.character();
		const packs = localPacks();
		const lines = [];
		const dof = (f) => lines.push(`dofile(${luaString(f)})`);
		lines.push(`package.path = ${luaString(STUBS + '/?.lua;')} .. package.path`);
		// stub_encoding.lua: C_EncodingUtil, which Polestar_Nav's packed walking maps are decoded with.
		for (const s of ['wow_stub.lua', 'stub_world.lua', 'stub_encoding.lua', ...packs.stubs]) dof(path.join(STUBS, s));
		lines.push('local w = stub.world', d.mapsLua);
		if (this.artDir) {
			const entries = Object.entries(this.art).map(([id, m]) => `[${id}] = ${luaValue(m)}`);
			lines.push(`local ART = { ${entries.join(', ')} }
C_Map.GetMapArtLayers = function(id) local m = ART[id]; return m and { m.layer } or {} end
C_Map.GetMapArtLayerTextures = function(id) local m = ART[id]; return m and m.textures or {} end
C_Map.GetMapArtID = function(id) local m = ART[id]; return m and m.artID end`);
		}
		lines.push(packs.before);
		// Our guides' faction parts (format 8) load on demand, as in the client: Polestar loads the
		// character's faction's once Polestar_Guides is in (Core/Guides.lua), the other's when asked.
		for (const part of ['Polestar_Guides_Alliance', 'Polestar_Guides_Horde']) {
			if (fs.existsSync(path.join(ROOT, 'addon', part, `${part}.toc`))) lines.push(`stub.packs.${part} = { ${tocFiles(part).map(luaString).join(', ')} }`);
		}
		// Polestar_Nav loads on demand, as in the client: Data.Pack loads it at login (Nav/Walk.lua).
		if (fs.existsSync(path.join(ROOT, 'addon', 'Polestar_Nav', 'Polestar_Nav.toc'))) {
			lines.push(`stub.packs.Polestar_Nav = { ${tocFiles('Polestar_Nav').map(luaString).join(', ')} }`);
		}
		lines.push(d.metrics);
		dof(path.join(ROOT, 'tools', 'preview', 'stub.lua'));
		lines.push('preview.enableTooltips()');
		if (this.config.eui) lines.push('stub.withEllesmere()');
		dof(path.join(__dirname, 'driver.lua'));
		lines.push(`play.installSim(${luaString(simActSource())})`);
		// The character, then their world as they left it.
		const home = HOME[ch.race] || HOME.Human;
		const zone = d.zones.find((z) => z.id === home[0]);
		lines.push(`w.race, w.raceName, w.raceID = ${luaString(ch.race)}, ${luaString(RACE_NAMES[ch.race] || ch.race)}, ${ch.id}
w.class, w.className, w.classID = ${luaString(ch.cls)}, ${luaString(CLASS_NAMES[ch.cls])}, ${CLASS_IDS[ch.cls] || 1}
w.faction = ${luaString(ch.faction)}
w.level = 1
w.moveTo(${home[0]}, ${home[1]}, ${home[2]})
w.zone, w.subzone = ${luaString(zone ? zone.name : '')}, ""`);
		const world = this.file('world.lua');
		if (fs.existsSync(world)) lines.push(`play.restoreWorld(dofile(${luaString(world)}))`);
		lines.push(`local function __load(name, files, saved)
	local ns = {}
	for _, f in ipairs(files) do
		local chunk, err = loadfile(f)
		if not chunk then error(err, 0) end
		chunk(name, ns)
	end
	for _, f in ipairs(saved) do dofile(f) end
	stub.addonLoaded(name)
end`);
		const sv = [this.file('SavedVariables', 'Polestar.lua'), this.file('Character', 'Polestar.lua')].filter((f) => fs.existsSync(f));
		lines.push(`__load("Polestar", { ${tocFiles('Polestar').map(luaString).join(', ')} }, { ${sv.map(luaString).join(', ')} })`);
		lines.push(`__load("Polestar_Guides", { ${tocFiles('Polestar_Guides').map(luaString).join(', ')} }, {})`);
		// The local crossings addon loads with Polestar in the client when it is built.
		if (fs.existsSync(path.join(ROOT, 'addon', 'Polestar_Travel', 'Polestar_Travel.toc'))) {
			lines.push(`__load("Polestar_Travel", { ${tocFiles('Polestar_Travel').map(luaString).join(', ')} }, {})`);
		}
		for (const dir of this.packs) lines.push(`__load(${luaString(path.basename(dir))}, { ${dirFiles(dir).map(luaString).join(', ')} }, {})`);
		lines.push('stub.login()', 'stub.advance(1)', 'play.serve()');
		return lines.join('\n');
	}

	async start() {
		this.generation++;
		fs.mkdirSync(this.dataDir, { recursive: true });
		// A restart's program replaces the last one; stop() removes the final file.
		if (this.programFile) fs.rmSync(this.programFile, { force: true });
		const file = path.join(os.tmpdir(), `polestar-play-${process.pid}-${this.generation}.lua`);
		fs.writeFileSync(file, this.program());
		this.programFile = file;
		const t0 = Date.now();
		const proc = spawn(findLua(), [file], { cwd: ROOT, stdio: ['pipe', 'pipe', 'pipe'] });
		this.proc = proc;
		this.buffer = '';
		this.stderr = '';
		proc.stdout.setEncoding('utf8');
		proc.stdout.on('data', (chunk) => this.onData(chunk));
		proc.stderr.setEncoding('utf8');
		proc.stderr.on('data', (chunk) => {
			this.stderr = (this.stderr + chunk).slice(-8000);
		});
		proc.on('exit', (code, signal) => this.onExit(proc, code, signal));
		const ready = await this.wait(this.timeoutMs);
		if (!ready.ok) {
			// A child that never got ready (or hangs) would keep play running.
			this.kill();
			fs.rmSync(file, { force: true });
			this.programFile = null;
			throw new Error(`Lua session failed to start: ${ready.error}`);
		}
		this.startMs = Date.now() - t0;
		this.log(`session ready in ${this.startMs} ms`);
		return this;
	}

	onData(chunk) {
		this.buffer += chunk;
		let nl;
		while ((nl = this.buffer.indexOf('\n')) >= 0) {
			const line = this.buffer.slice(0, nl);
			this.buffer = this.buffer.slice(nl + 1);
			if (!line.startsWith('@@R ')) continue;
			const p = this.pending;
			this.pending = null;
			if (!p) continue;
			clearTimeout(p.timer);
			try {
				p.resolve(JSON.parse(line.slice(4)));
			} catch (err) {
				p.resolve({ ok: false, error: `bad reply from Lua: ${err.message}` });
			}
		}
	}

	onExit(proc, code, signal) {
		if (proc !== this.proc) return;
		this.proc = null;
		const p = this.pending;
		this.pending = null;
		const why = `Lua exited (${signal || `code ${code}`})${this.stderr ? `:\n${this.stderr.trim()}` : ''}`;
		this.lastExit = why;
		if (p) {
			clearTimeout(p.timer);
			p.resolve({ ok: false, error: why, crashed: true });
		}
	}

	wait(timeoutMs) {
		return new Promise((resolve) => {
			const timer = setTimeout(() => {
				this.pending = null;
				resolve({ ok: false, error: `no reply in ${timeoutMs} ms`, timeout: true });
			}, timeoutMs);
			this.pending = { resolve, timer };
		});
	}

	// Runs one Lua chunk (serialized with every other call); -> the reply.
	call(code, timeoutMs = this.timeoutMs) {
		const run = async () => {
			if (!this.proc) return { ok: false, error: this.lastExit || 'no Lua session', crashed: true };
			const reply = this.wait(timeoutMs);
			this.proc.stdin.write(`${Buffer.byteLength(code)}\n${code}`);
			const r = await reply;
			if (r.timeout) {
				this.kill();
				r.crashed = true;
			}
			return r;
		};
		const p = this.queue.then(run, run);
		this.queue = p.catch(() => {});
		return p;
	}

	kill() {
		const proc = this.proc;
		this.proc = null;
		if (proc) proc.kill('SIGKILL');
	}

	// The Lua for one action (see tools/play/public/app.js for who sends what).
	actionLua(a) {
		const n = (v, d = 0) => (Number.isFinite(Number(v)) ? Number(v) : d);
		const id = a.id == null ? 'nil' : n(a.id);
		const btn = luaString(a.button === 'RightButton' ? 'RightButton' : 'LeftButton');
		const xy = `${n(a.x)}, ${n(a.y)}`;
		switch (a.type) {
			case 'render': return '';
			case 'hover': return `play.hover(${id}, ${xy})`;
			case 'leave': return 'play.hover(nil)';
			case 'click': return `play.hover(${id}, ${xy}); play.click(${id}, ${btn}, ${xy})`;
			case 'wheel': return `play.wheel(${id}, ${n(a.delta) > 0 ? 1 : -1}, ${xy})`;
			case 'dragStart': return `play.dragStart(${id}, ${btn}, ${xy}, ${n(a.x0, a.x)}, ${n(a.y0, a.y)})`;
			case 'dragMove': return `play.dragMove(${xy})`;
			case 'dragStop': return `play.dragStop(${xy})`;
			case 'key': return `play.key(${luaString(String(a.key || ''))}, ${a.text == null ? 'nil' : luaString(String(a.text))})`;
			case 'slash': return `play.slash(${luaString(String(a.text || ''))})`;
			case 'set': return `Polestar.Set(${luaString(String(a.path))}, ${a.value == null ? 'nil' : luaValue(a.value)})`;
			case 'resetLook': return `for _, k in ipairs({ "style", "compact", "scale", "width", "bgOpacity", "opacity", "scheme", "accent", "bgColor", "brightness", "upcoming", "upcomingOpen", "showNotes", "menuScale", "font", "locked", "pos" }) do Polestar.Set("ui." .. k, Polestar.GetDefault("ui." .. k)) end`;
			case 'goal': return 'return play.doGoal()';
			case 'step': return 'return play.playStep()';
			case 'guide': return 'return play.playGuide()';
			case 'gotoStep': return `Polestar.Engine.Goto(${n(a.step, 1)})`;
			case 'prevStep': return 'Polestar.Engine.Prev()';
			case 'nextStep': return 'Polestar.Engine.Next()';
			case 'loadGuide': return `Polestar.Engine.SetGuide(${luaString(String(a.guide))})`;
			case 'tip': return 'local p = Polestar.UI.GuideFrame.parts; if p and p.tip and p.tip.shown then p.tip:Click() end';
			case 'time': return `stub.advance(${Math.max(0, Math.min(3600, n(a.seconds, 60)))})`;
			case 'level': return `stub.world.setLevel(${Math.max(1, Math.min(60, Math.round(n(a.level, 1))))})`;
			case 'move': return `stub.world.moveTo(${n(a.map)}, ${n(a.x, 50)}, ${n(a.y, 50)}); play.syncZone()`;
			case 'quest': {
				const q = Math.round(n(a.quest));
				switch (a.op) {
					case 'accept': return `local w = stub.world; if not w.log[${q}] and not w.completed[${q}] then w.accept(${q}, {}) end`;
					case 'complete': return `stub.world.finish(${q})`;
					case 'turnin': return `local w = stub.world; if w.log[${q}] then w.finish(${q}) end; w.turnIn(${q})`;
					case 'abandon': return `stub.world.abandon(${q})`;
					default: return '';
				}
			}
			case 'state': return this.stateLua(a.state);
			case 'open': return this.openLua(String(a.what || ''), a.arg);
			case 'popup': return `play.popup(${n(a.index, 1)}, ${luaString(a.choice === 'accept' ? 'accept' : 'cancel')})`;
			case 'close': return 'play.closeSpecial()';
			default: throw new Error(`unknown action "${a.type}"`);
		}
	}

	stateLua(which) {
		switch (which) {
			// The waiting route choice: the active guide's, else play a guide that
			// offers one (the active one when it does) to its end.
			case 'route': return `local E, G = Polestar.Engine, Polestar.Guides
local from = E.PendingRouteChoice()
if from then Polestar.Fire("ROUTE_CHOICE", from); return "shown" end
local g = E.GetGuide()
if not (g and g.nextChoices) then
	local me = Polestar.Compat.GetPlayerInfo()
	for _, h in ipairs(G.List()) do
		local full = G.Get(h.id)
		if full and full.nextChoices and G.GuideMatches(full, me) then g = full; break end
	end
	if not g then return "none" end
	E.SetGuide(g.id)
	stub.advance(0.6)
end
local r = play.playGuide()
if E.OfferRouteChoice() then return "shown" end
return r`;
			case 'outlevel': return `local E, G = Polestar.Engine, Polestar.Guides
local g = E.GetGuide()
if not g then return "noguide" end
local to = g.next or (g.nextChoices and g.nextChoices[1]) or G.Suggest()
if to == g.id then to = nil end
Polestar.Fire("GUIDE_OUTLEVELED", g.id, to)`;
			case 'train': return `local E = Polestar.Engine
local t = E.NearestClassTrainer and E.NearestClassTrainer()
Polestar.Fire("TRAIN_DUE", stub.world.level, t or { npcName = "your class trainer" })`;
			case 'clearBanners': return 'Polestar.Fire("CLASS_TRAINED"); local GF = Polestar.UI.GuideFrame; if GF.notices then GF.notices.outlevel = nil end; GF.Layout()';
			case 'doneStep': return `local E = Polestar.Engine
local i = E.GetStepIndex()
if not i then return "noguide" end
play.playStep()
E.Goto(i)`;
			default: throw new Error(`unknown state "${which}"`);
		}
	}

	openLua(what, arg) {
		switch (what) {
			// side: beside the guide window (at its default place), as if dragged there.
			case 'hub': return `Polestar.UI.ShowPicker(); Polestar.UI.Picker.ShowSection("Guides")${arg === 'side' ? '\nif PolestarPicker then PolestarPicker:ClearAllPoints(); PolestarPicker:SetPoint("LEFT", UIParent, "LEFT", 48, 40) end' : ''}`;
			case 'section': return `Polestar.UI.ShowPicker(); Polestar.UI.Picker.ShowSection(${luaString(String(arg || 'Guides'))})`;
			case 'lookup': return `Polestar.UI.ShowPicker(); Polestar.UI.Picker.ShowSection("Lookup")${arg ? `; Polestar.UI.Picker.SetQuery(${luaString(String(arg))})` : ''}`;
			case 'guide': return 'Polestar.Set("ui.shown", true)';
			case 'options': return `Polestar.UI.ShowOptions(${arg ? luaString(String(arg)) : ''})`;
			case 'map': return 'play.toggleMap()';
			case 'route': return 'Polestar.Engine.OfferRouteChoice()';
			default: throw new Error(`unknown window "${what}"`);
		}
	}

	// One interaction: run it, let time pass, draw. `known`: glyph defs the
	// page already has.
	async act(action = { type: 'render' }, known = 0) {
		const t0 = process.hrtime.bigint();
		const code = this.actionLua(action);
		const dt = action.type === 'time' ? 0.1 : (ADVANCE[action.type] ?? ADVANCE.default);
		const timeout = action.type === 'guide' || action.state === 'route' ? 180000 : this.timeoutMs;
		const reply = await this.call(`local r = (function() ${code}\nend)()
local snap = play.snapshot(${dt}, ${this.errorSeq})
snap.result = r
return snap`, timeout);
		const t1 = process.hrtime.bigint();
		if (!reply.ok) {
			if (reply.crashed) return { crashed: true, error: reply.error };
			return { failed: true, error: reply.error, trace: reply.trace };
		}
		const out = this.draw(reply.value, known);
		const t2 = process.hrtime.bigint();
		out.result = reply.value.result;
		out.timing = { lua: Number(t1 - t0) / 1e6, luaCpu: reply.ms, render: Number(t2 - t1) / 1e6 };
		out.timing.total = out.timing.lua + out.timing.render;
		return out;
	}

	draw(snap, known = 0) {
		const errors = snap.errors || [];
		for (const e of errors) this.errorSeq = Math.max(this.errorSeq, e.n);
		const pic = svg(snap.dump, {
			fonts: this.data.fonts, textures: this.textures, roots: (o) => o.name === 'UIParent',
			prefix: 's', shared: this.glyphs, viewport: SCREEN,
		});
		const body = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${SCREEN.w} ${SCREEN.h}" preserveAspectRatio="xMidYMid meet"><defs>${pic.defs}</defs>${pic.body}</svg>`;
		return {
			svg: body,
			glyphs: this.glyphs.defs.slice(known),
			glyphBase: known,
			glyphCount: this.glyphs.defs.length,
			hits: hitMap(pic.layout),
			state: snap.state,
			errors,
		};
	}

	// SavedVariables and the world, written the way the client writes them.
	async save({ logout = false } = {}) {
		if (!this.proc) return false;
		const r = await this.call(`${logout ? 'stub.fire("PLAYER_LOGOUT")\n' : ''}return { db = play.savedVariables({ "PolestarDB" }), char = play.savedVariables({ "PolestarCharDB" }), world = play.worldSnapshot() }`);
		if (!r.ok) return false;
		const write = (rel, text) => {
			const f = this.file(...rel);
			fs.mkdirSync(path.dirname(f), { recursive: true });
			fs.writeFileSync(f, text);
		};
		write(['SavedVariables', 'Polestar.lua'], r.value.db);
		write(['Character', 'Polestar.lua'], r.value.char);
		write(['world.lua'], r.value.world);
		this.lastSave = Date.now();
		return true;
	}

	async stop({ save = true } = {}) {
		if (save) await this.save({ logout: true }).catch(() => {});
		this.kill();
		if (this.programFile) fs.rmSync(this.programFile, { force: true });
	}

	// Frame artwork for the page.
	texture(hash) {
		return this.textures.png(hash);
	}
	zoneArt(mapID) {
		return zoneArtPng(this.artDir, mapID, this.zoneArtCache || (this.zoneArtCache = new Map()));
	}
}

module.exports = { Session, hitMap, sharedData, simActSource, CLASS_NAMES, RACE_NAMES, SCREEN };
