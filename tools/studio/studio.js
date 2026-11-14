'use strict';
// The Feature Studio's runner: one shot of a scenario (tools/studio/scenarios)
// rendered with the REAL addons. A shot runs the playground's Lua session
// (tools/play/session.js: Polestar, Polestar_Guides and the faction's guide
// part loaded by their TOCs, the local data packs on demand, over the test
// client stub and the stub world) plus tools/studio/client.lua (client data
// from the Forever client's tables), sets the scenario's character, place,
// guide and world up, runs the shot's script, and draws the whole screen
// with tools/preview/render.js: an SVG, a PNG (rsvg-convert, when
// installed) and a 2x close-up of the shot's capture frames.
//
//   const { listScenarios, loadScenario, runShot } = require('./studio');
//   await runShot(scenario, 'card', { outDir, world, offline, log })
//     -> { svg, png, closeup, errors, step, result }
//
// Client art (icons, atlases, the game font) comes from the local art cache
// (tools/studio/art.js); a texture it lacks is drawn as a grey placeholder
// with a diagonal stripe, so a render without client art says so. A render
// with client art holds Blizzard art: it is written under data/local/ (or
// --out), never into the repository.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { execFileSync } = require('node:child_process');

const { ROOT } = require('../lib/paths');
const art = require('./art');
const clientData = require('./clientdata');
const { luaValue } = require('../lib/playtest');

const SCENARIOS = path.join(__dirname, 'scenarios');
const CLIENT_LUA = path.join(__dirname, 'client.lua');
const EARLY_LUA = path.join(__dirname, 'early.lua');
const RACE_BITS = { Human: 1, Orc: 2, Dwarf: 4, NightElf: 8, Scourge: 16, Tauren: 32, Gnome: 64, Troll: 128 };

// Required late: tests/helpers/lua reads POLESTAR_ADDON_DIR when first loaded
// (the command sets it for --checkout before anything here runs).
const late = () => ({
	...require('../play/session'),
	...require('../preview/render'),
	Font: require('../preview/font').Font,
	ADDONS: require('../../tests/helpers/lua').ADDONS,
});

function listScenarios() {
	return fs.readdirSync(SCENARIOS).filter((f) => f.endsWith('.js')).map((f) => f.replace(/\.js$/, '')).sort();
}

function loadScenario(name) {
	const file = path.join(SCENARIOS, `${name}.js`);
	if (!fs.existsSync(file)) throw new Error(`studio: no scenario "${name}" (tools/studio/scenarios: ${listScenarios().join(', ')})`);
	delete require.cache[require.resolve(file)];
	const sc = require(file);
	return { name, ...sc };
}

const q = (s) => JSON.stringify(String(s));
const luaList = (a) => `{ ${a.map(Number).join(', ')} }`;

// The game font, measured and drawn in its own face, when the cache has it.
function withClientFonts(L) {
	const d = L.sharedData();
	if (d.studioFonts) return d;
	d.studioFonts = true;
	const faces = [];
	const file = art.font('FRIZQT__.TTF');
	if (file) faces.push(['FRIZQT__.TTF', file]);
	// Polestar's own faces beyond the playground's three Inter weights (Open
	// Sans, Fira Sans: the skins' and the ui.font choices) and a skin addon's
	// own fonts (addon/Polestar_Skin_*/Fonts, the Skin API's `font = { regular
	// = path, ... }`), by file name, as the preview does: else they are
	// measured and drawn in the fallback face.
	const addons = L.ADDONS;
	const fontDirs = [path.join(addons, 'Polestar', 'Media', 'Fonts')];
	for (const folder of fs.existsSync(addons) ? fs.readdirSync(addons) : []) {
		if (folder.startsWith('Polestar_Skin_')) fontDirs.push(path.join(addons, folder, 'Fonts'));
	}
	for (const dir of fontDirs) {
		if (!fs.existsSync(dir)) continue;
		for (const f of fs.readdirSync(dir)) if (/\.ttf$/i.test(f)) faces.push([f, path.join(dir, f)]);
	}
	const cps = [];
	for (let c = 32; c < 127; c++) cps.push(c);
	for (let c = 0xa0; c < 0x180; c++) cps.push(c);
	cps.push(0x2013, 0x2014, 0x2018, 0x2019, 0x201c, 0x201d, 0x2026, 0x2022, 0x00b7, 0x00d7, 0x2192);
	for (const [name, ttf] of faces) {
		// `in`, not a read: the fonts proxy answers any name with the fallback face.
		if (name in d.fonts) continue;
		const f = new L.Font(ttf);
		d.fonts[name] = f;
		const adv = cps.map((c) => `[${c}]=${f.advanceEm(c).toFixed(5)}`).join(',');
		d.metrics += `\npreview.metrics[${JSON.stringify(name)}] = { upm = ${f.upm}, fallback = ${f.advanceEm(0x6e).toFixed(5)}, adv = { ${adv} } }`;
	}
	return d;
}

// Textures: Polestar's media from the checkout being rendered, client art
// from the cache, a placeholder for client art the cache lacks.
function textureCache(L) {
	const placeholder = (() => {
		const n = 32, px = Buffer.alloc(n * n * 4);
		for (let y = 0; y < n; y++) {
			for (let x = 0; x < n; x++) {
				const stripe = Math.abs(x - y) < 2 || x === 0 || y === 0 || x === n - 1 || y === n - 1;
				const v = stripe ? 150 : 70;
				px.set([v, v, v + 6, 255], (y * n + x) * 4);
			}
		}
		return { w: n, h: n, px };
	})();
	class StudioTextures extends L.TextureCache {
		load(name) {
			const t = super.load(name);
			if (t || !/^fid:\d+$/.test(name)) return t;
			this.src.set(name, placeholder);
			return placeholder;
		}
	}
	return new StudioTextures(path.join(L.ADDONS, 'Polestar', 'Media', 'UI'), art.dir());
}

// The class trainer's spells below `level` that the race may learn, and the
// ones every character of the class starts with.
function trainedBelow(cls, race, level) {
	const L = late();
	const cs = clientData.classSpells(L.ADDONS, cls);
	const bit = RACE_BITS[race] || 0;
	const ids = [];
	for (const [l, list] of Object.entries(cs)) {
		if (Number(l) >= level) continue;
		for (const e of list) if (!e.races || (e.races & bit)) ids.push(e.id);
	}
	return ids;
}

// The client data and art a scenario needs, gathered before the session.
async function prepare(sc, offline) {
	const ch = sc.character;
	const book = sc.spellbook ? [...(sc.spellbook.trainerBelow ? trainedBelow(ch.cls, ch.race, sc.spellbook.trainerBelow) : []), ...(sc.spellbook.extra || [])] : [];
	const spells = [...book, ...((sc.data && sc.data.spells) || [])];
	if (sc.data && sc.data.classSpells) {
		for (const list of Object.values(clientData.classSpells(late().ADDONS, ch.cls))) for (const e of list) spells.push(e.id);
	}
	const items = [...((sc.data && sc.data.items) || []), ...(sc.bags || []).map((b) => b[0])];
	const data = await clientData.luaData({ spells, items });
	const pulled = await art.pull([...new Set([...data.icons, ...(sc.art || [])])], { offline });
	// The atlases whose sheets the cache holds (SetAtlas, C_Texture.GetAtlasInfo).
	const atlases = art.readJson(path.join(art.dir(), 'atlases.json'), {});
	const rows = Object.entries(atlases).filter(([, a]) => art.has(art.dir(), a.file))
		.map(([k, a]) => `[${q(k)}] = { ${a.file}, ${a.w}, ${a.h}, ${a.l}, ${a.r}, ${a.t}, ${a.b} }`);
	const atlasLua = rows.length ? `STUDIO_ATLAS = { ${rows.join(', ')} }\n` : '';
	// The interface files the cache holds (SetTexture / SetStatusBarTexture by
	// path, as the game's looks name the vanilla art).
	const files = Object.entries(art.readJson(path.join(art.dir(), 'files.json'), {})).filter(([, fid]) => art.has(art.dir(), fid))
		.map(([k, fid]) => `[${q(k)}] = ${fid}`);
	const filesLua = files.length ? `STUDIO_FILES = { ${files.join(', ')} }\n` : '';
	return { book, lua: data.lua + atlasLua + filesLua, missingArt: pulled.missing };
}

function setupLua(sc, book) {
	const ch = sc.character, p = sc.place || {}, g = sc.guide;
	const settings = Object.entries(sc.settings || {}).map(([k, v]) => `Polestar.Set(${q(k)}, ${luaValue(v)})`).join('\n');
	return `local w = stub.world
${settings}
w.setLevel(${ch.level})
stub.advance(3)
for _, id in ipairs(${luaList(book)}) do w.spells[id] = true end
${ch.money != null ? `w.setMoney(${Number(ch.money)})` : ''}
for _, id in ipairs(${luaList(sc.completed || [])}) do w.completed[id] = true end
${p.map ? `w.moveTo(${p.map}, ${p.x}, ${p.y}); play.syncZone()` : ''}
${p.zone ? `w.zone, w.subzone = ${q(p.zone)}, ${q(p.subzone || '')}` : ''}
-- The data packs load as the client loads them when asked (the quest database
-- answers a member's level and class; the Codex the dungeons and levels).
for _, pack in ipairs({ "Polestar_QuestDB", "Polestar_Codex", "Polestar_ItemDB" }) do
	if Polestar.Data and Polestar.Data.Pack then pcall(Polestar.Data.Pack, pack) end
end
Polestar.Set("ui.shown", true)
if Polestar.UI.Welcome and Polestar.UI.Welcome.IsShown() then Polestar.UI.Welcome.Hide() end
${sc.window ? `Polestar.Set("ui.pos", { ${sc.window[0]}, ${sc.window[1]} })` : ''}
${g ? `Polestar.Engine.SetGuide(${q(g.id)})
stub.advance(1)
${g.step ? `Polestar.Engine.Goto(${g.step})` : ''}
${g.play ? `for _ = 1, ${g.play} do
	local r = play.playStep()
	if r == "noguide" then break elseif r == "stuck" then Polestar.Engine.Next(); stub.advance(0.6) end
end
-- The simulator's XP may have levelled the character: back to the scenario's level.
w.level = ${ch.level}` : ''}
${g.hours ? `stub.advance(${g.hours * 3600})` : ''}` : ''}
for _, b in ipairs(${luaValue(sc.bags || [])}) do studio.bag(b[1], b[2], b[3]) end
stub.advance(1)
studio.clearHeadsUps()
-- The chat stand-in shows what the scenario says, not the stub's start-up lines.
stub.messages = {}
${sc.setup || ''}
return Polestar.Engine.GetStepIndex()`;
}

// The screen box of the frames named and everything drawn inside them
// (labels hanging out of a button count), shown ones only, each cut to the
// frames that clip it (a scroll frame, a zoomed map canvas) as it is drawn.
function bbox(layout, names) {
	const box = [Infinity, Infinity, -Infinity, -Infinity];
	const roots = new Set();
	for (const o of layout.byId.values()) if (names.includes(o.name) && o.shown) roots.add(o.id);
	const inside = (o) => {
		for (let cur = o; cur; cur = cur.parent != null ? layout.byId.get(cur.parent) : null) {
			if (!cur.shown) return false;
			if (roots.has(cur.id)) return true;
		}
		return false;
	};
	for (const o of layout.byId.values()) {
		if (!inside(o)) continue;
		const r = layout.rects.get(o.id);
		if (!r || !r.w || !r.h) continue;
		let x0 = r.x, y0 = r.y, x1 = r.x + r.w, y1 = r.y + r.h;
		for (let c = layout.clipOf(o); c; c = layout.clipOf(c)) {
			const cr = layout.rects.get(c.id);
			if (!cr) continue;
			x0 = Math.max(x0, cr.x); y0 = Math.max(y0, cr.y);
			x1 = Math.min(x1, cr.x + cr.w); y1 = Math.min(y1, cr.y + cr.h);
		}
		if (x1 <= x0 || y1 <= y0) continue;
		box[0] = Math.min(box[0], x0 - layout.ox); box[1] = Math.min(box[1], y0 - layout.oy);
		box[2] = Math.max(box[2], x1 - layout.ox); box[3] = Math.max(box[3], y1 - layout.oy);
	}
	return Number.isFinite(box[0]) ? box : null;
}

function hasRsvg() {
	try {
		execFileSync('rsvg-convert', ['--version'], { stdio: 'ignore' });
		return true;
	} catch {
		return false;
	}
}

// Renders shot `shotName` of scenario `sc` into outDir/<scenario>-<shot>.{svg,png}.
// stubsDir: another checkout's tests/lua, where the scenario's stubs are looked for first.
async function runShot(sc, shotName, { outDir, world = null, offline = false, stubsDir = null, log = () => {} } = {}) {
	const shot = sc.shots[shotName];
	if (!shot) throw new Error(`studio: scenario "${sc.name}" has no shot "${shotName}" (${Object.keys(sc.shots).join(', ')})`);
	const L = late();
	const d = withClientFonts(L);
	const prep = await prepare(sc, offline);
	if (prep.missingArt.length) log(`client art not found (drawn as placeholders): ${prep.missingArt.join(', ')}`);
	const dataDir = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-studio-'));
	// The client data and the studio's client load with the stubs, before the
	// addons, as the game's are there before any addon.
	const dataFile = path.join(dataDir, 'studio-data.lua');
	fs.writeFileSync(dataFile, prep.lua);
	const ch = sc.character;
	const s = new L.Session({
		dataDir, artDir: art.dir(), config: { race: ch.race, cls: ch.cls, faction: ch.faction },
		stubs: [dataFile, EARLY_LUA, CLIENT_LUA, ...(sc.stubs || []).map((f) => (stubsDir && fs.existsSync(path.join(stubsDir, f)) ? path.join(stubsDir, f) : f))], timeoutMs: 180000, log,
	});
	await s.start();
	try {
		const call = async (code, label) => {
			const r = await s.call(code, 180000);
			if (!r.ok) throw new Error(`studio: ${sc.name}/${shotName}: ${label}: ${r.error}${r.trace ? `\n${r.trace}` : ''}`);
			return r.value;
		};
		// preview.enableTooltips() (after the stubs) made GameTooltip the drawn one: the game's lines on it again.
		await call('studio.installTips(GameTooltip)\nreturn true', 'client data');
		const step = await call(setupLua(sc, prep.book), 'setup');
		log(`${sc.name}/${shotName}: step ${step}`);
		// What the shot's script returns comes back as `result` (a probe's numbers).
		const result = await call(`local __r = (function()\n${shot.lua || ''}\nend)()\nstub.advance(0.3)\nreturn __r`, 'shot');
		const snap = await call('return play.snapshot(0.3, 0)', 'snapshot');
		const errors = snap.errors || [];
		for (const e of errors) log(`Lua error: ${e.msg || JSON.stringify(e)}`);

		const glyphs = { glyphs: new Set(), defs: [] };
		const pic = L.svg(snap.dump, { fonts: d.fonts, textures: textureCache(L), roots: (o) => o.name === 'UIParent', prefix: 's', shared: glyphs, viewport: L.SCREEN });
		const W = L.SCREEN.w, H = L.SCREEN.h;
		const bg = world
			? `<image width="${W}" height="${H}" preserveAspectRatio="xMidYMid slice" href="data:image/${/\.png$/i.test(world) ? 'png' : 'jpeg'};base64,${fs.readFileSync(world).toString('base64')}"/>`
			: `<defs><radialGradient id="studio-bg" cx="50%" cy="45%" r="75%"><stop offset="0" stop-color="#1b1f27"/><stop offset="1" stop-color="#0a0c10"/></radialGradient></defs><rect x="0" y="0" width="${W}" height="${H}" fill="url(#studio-bg)"/>`;
		const body = `<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="${W}" height="${H}" viewBox="0 0 ${W} ${H}">${bg}<defs>${pic.defs}\n${glyphs.defs.join('\n')}</defs>${pic.body}</svg>`;

		fs.mkdirSync(outDir, { recursive: true });
		const base = path.join(outDir, `${sc.name}-${shotName}`);
		const out = { svg: `${base}.svg`, png: null, closeup: null, errors, step, result };
		fs.writeFileSync(out.svg, body);
		if (hasRsvg()) {
			out.png = `${base}.png`;
			execFileSync('rsvg-convert', ['-o', out.png, out.svg]);
			const box = bbox(pic.layout, shot.capture || sc.capture || ['PolestarGuideFrame']);
			if (box) {
				const pad = shot.pad || sc.pad || 24;
				const x0 = Math.max(0, Math.floor(box[0] - pad)), y0 = Math.max(0, Math.floor(box[1] - pad));
				const w = Math.min(W - x0, Math.ceil(box[2] + pad) - x0), h = Math.min(H - y0, Math.ceil(box[3] + pad) - y0);
				// The close-up: the capture frames' region at 2x, cut from a 2x render of the same SVG.
				const crop = body.replace(`width="${W}" height="${H}" viewBox="0 0 ${W} ${H}"`, `width="${w * 2}" height="${h * 2}" viewBox="${x0} ${y0} ${w} ${h}"`);
				const cropFile = `${base}-closeup.svg`;
				fs.writeFileSync(cropFile, crop);
				out.closeup = `${base}-closeup.png`;
				execFileSync('rsvg-convert', ['-o', out.closeup, cropFile]);
				fs.rmSync(cropFile);
			}
		}
		return out;
	} finally {
		s.kill();
		if (s.programFile) fs.rmSync(s.programFile, { force: true });
		fs.rmSync(dataDir, { recursive: true, force: true });
	}
}

// The default output folder: under data/local/ (gitignored), since renders
// with client art hold Blizzard art.
const DEFAULT_OUT = path.join(ROOT, 'data', 'local', 'studio');

module.exports = { listScenarios, loadScenario, runShot, DEFAULT_OUT, SCENARIOS };
