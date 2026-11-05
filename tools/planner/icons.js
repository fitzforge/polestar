'use strict';
// The game's own icons for the planner page, from the Forever client
// (`wow_classic_beta`): client textures by fileDataID through
// tools/lib/planner/art/casc.js (cached under data/sources/casc/), decoded from
// BLP and written as PNG under data/local/planner/icons/<kind>/<key>.png.
// Local only, like the map art: never committed, packed or shipped
// (THIRD_PARTY.md).
//
//   const icons = openIcons({ sourcesDir, outDir, product, offline, fetchImpl, casc });
//   await icons.icon('item', '750')  -> PNG Buffer, or null (no such icon)
//   icons.info()                     -> { ui: [keys], kinds: [kinds], available }
//
// Kinds (keys checked by keyOf(kind, key), which also gives the cache name):
//   fdid:<n>          any texture by fileDataID, its full frame
//   item:<id>         Item.IconFileDataID
//   spell:<id>        SpellMisc.SpellIconFileDataID (the row of DifficultyID 0 first)
//   skill:<id|name>   SkillLine.SpellIconFileID, by ID or DisplayName_lang ("Mining", "First Aid")
//   class:<FILE>      ChrClasses.IconFileDataID by Filename (WARRIOR ... DRUID)
//   race:<File>-<sex> interface/icons/achievement_character_<race>_<sex> (Scourge
//                     -> undead, NightElf -> nightelf); Skyborne, which has none,
//                     its character frame portrait (interface/characterframe/
//                     temporaryportrait-<sex>-skyborne); female falls back to male
//   ui:<key>          a named client texture, the UI table below (by path or
//                     fileDataID; `cell` [x, y, w, h] cuts one cell of an atlas)
//
// Tables are the Forever build's (the one CASC serves), cached as
// data/sources/wago/<build>/<Table>.csv (tools/lib/data/wago.js cachedTable).
// Paths resolve to fileDataIDs through wago.tools' file search
// (`/api/files?search=<term>&branch=<product>`, JSON { fdid: path }; slow,
// tens of seconds): a UI texture searches its whole folder, the race icons
// their common prefix, an Interface/Icons path its own name, and every path
// found under the term is kept in <outDir>/paths.json (null: not in the
// client), so a folder is searched once.
//
// Interface/Icons textures are cropped to the inset the game's UI shows
// (texcoords 0.07-0.93) and box-filtered to 64 px; other UI textures keep
// their full frame and size. A miss (unknown id, no icon, file not in the
// client) is cached as <key>.miss so it answers fast; a network failure is
// not cached and throws. Offline: only what is cached (CASC files and tables
// included); anything else is null and not remembered.

const fs = require('node:fs');
const path = require('node:path');
const { SOURCES, ROOT } = require('../lib/paths');
const { cachedTable } = require('../lib/data/wago');
const { openCasc, fetchRetry } = require('../lib/planner/art/casc');
const { decodeBlp } = require('../lib/planner/art/blp');
const { encodePng } = require('../lib/planner/art/png');
const { CLASS_FILES, RACE_FILES } = require('../lib/game/races');

const DEFAULT_OUT = path.join(ROOT, 'data', 'local', 'planner', 'icons');
const ICON_PX = 64;
const INSET = 0.07;
const filesUrl = (search, product) => `https://wago.tools/api/files?search=${encodeURIComponent(search)}&branch=${encodeURIComponent(product)}`;

// ui:<key> -> a client path (no extension) or an item whose icon it is.
// Verified on wago.tools for wow_classic_beta 1.60.1.70374 (fdid in the comment).
const UI = {
	// Quest givers and gossip.
	'quest-available': { path: 'interface/gossipframe/availablequesticon' }, // 132049
	'quest-turnin': { path: 'interface/gossipframe/activequesticon' }, // 132048
	'quest-incomplete': { fdid: 365195 }, // interface/gossipframe/incompletequesticon: the grey ?
	// The minimap's quest marks: 32 px cells of interface/minimap/objecticons (136435).
	'mark-available': { fdid: 136435, cell: [32, 32, 32, 32] }, // yellow !
	'mark-turnin': { fdid: 136435, cell: [64, 32, 32, 32] }, // yellow ?
	'mark-low': { fdid: 136435, cell: [128, 96, 32, 32] }, // the dimmed !
	talk: { path: 'interface/gossipframe/gossipgossipicon' }, // 132053
	// Minimap tracking: the town services.
	flightmaster: { path: 'interface/minimap/tracking/flightmaster' }, // 136456
	innkeeper: { path: 'interface/minimap/tracking/innkeeper' }, // 136458
	food: { path: 'interface/minimap/tracking/food' }, // 136457 (vendor)
	repair: { path: 'interface/minimap/tracking/repair' }, // 136465
	class: { path: 'interface/minimap/tracking/class' }, // 136455 (class trainer)
	profession: { path: 'interface/minimap/tracking/profession' }, // 136463
	mailbox: { path: 'interface/minimap/tracking/mailbox' }, // 136459
	banker: { path: 'interface/minimap/tracking/banker' }, // 136453
	auctioneer: { path: 'interface/minimap/tracking/auctioneer' }, // 136452
	reagents: { path: 'interface/minimap/tracking/reagents' }, // 136464
	poisons: { path: 'interface/minimap/tracking/poisons' }, // 136462
	stablemaster: { path: 'interface/minimap/tracking/stablemaster' }, // 136466
	skull: { path: 'interface/targetingframe/ui-raidtargetingicon_8' }, // 137008
	hearthstone: { item: 6948 }, // Hearthstone's icon
	// Goal verbs: the game's cursors where it has one, else an icon.
	kill: { path: 'interface/cursor/attack' }, // 131013
	collect: { path: 'interface/cursor/pickup' }, // 131027 (the loot hand)
	interact: { path: 'interface/cursor/interact' }, // 131021 (the cogwheel)
	use: { path: 'interface/cursor/cast' }, // 131015
	buy: { path: 'interface/cursor/buy' }, // 131014
	trainer: { path: 'interface/cursor/trainer' }, // 131040
	explore: { path: 'interface/icons/inv_misc_map_01' }, // 134269
	level: { path: 'interface/icons/achievement_level_10' }, // 236562
	note: { path: 'interface/icons/inv_misc_note_01' }, // 134327
	// Travel.
	boat: { path: 'interface/icons/inv_garrison_cargoship' }, // 1126431
	zeppelin: { path: 'interface/icons/inv_zeppelinmount' }, // 1519491
	tram: { path: 'interface/minimap/vehicle-silvershardmines-minecart' }, // 651946
	dungeon: { path: 'interface/lfgframe/lfgicon-dungeon' }, // 136334 (an entrance)
	raid: { path: 'interface/lfgframe/lfgicon-raid' }, // 136351
};

const KINDS = ['fdid', 'item', 'spell', 'skill', 'class', 'race', 'ui'];
const RACE_ICON = { Scourge: 'undead', NightElf: 'nightelf' };
const CLASS_SET = new Set(CLASS_FILES);
const RACE_BY_LOWER = new Map(RACE_FILES.map((r) => [r.toLowerCase(), r]));

// The canonical cache name of a kind's key, or null when the key is not one.
function keyOf(kind, key) {
	if (typeof key !== 'string') return null;
	switch (kind) {
		case 'fdid':
			return /^[1-9]\d{0,9}$/.test(key) ? key : null;
		case 'item':
		case 'spell':
			return /^[1-9]\d{0,7}$/.test(key) ? key : null;
		case 'skill':
			if (/^[1-9]\d{0,5}$/.test(key)) return key;
			return /^[A-Za-z][A-Za-z' -]{0,39}$/.test(key) ? key.toLowerCase().replace(/[^a-z]+/g, '-') : null;
		case 'class':
			return CLASS_SET.has(key.toUpperCase()) ? key.toUpperCase() : null;
		case 'race': {
			const m = /^([A-Za-z]+)-(male|female)$/i.exec(key);
			const race = m && RACE_BY_LOWER.get(m[1].toLowerCase());
			return race ? `${race}-${m[2].toLowerCase()}` : null;
		}
		case 'ui':
			return Object.hasOwn(UI, key) ? key : null;
		default:
			return null;
	}
}

// Offline and not cached: not a miss, nothing to remember.
class NotCached extends Error {}

// rgba (w x h) region [x0, x0 + cw) x [y0, y0 + ch) -> n x n, each output pixel
// the area-weighted mean of the source it covers (alpha-weighted colour).
function resizeBox(rgba, w, h, x0, y0, cw, ch, n) {
	const out = new Uint8Array(n * n * 4);
	const fx = cw / n, fy = ch / n;
	for (let y = 0; y < n; y++) {
		const ya = y0 + y * fy, yb = ya + fy;
		for (let x = 0; x < n; x++) {
			const xa = x0 + x * fx, xb = xa + fx;
			let r = 0, g = 0, b = 0, a = 0, wsum = 0;
			for (let iy = Math.floor(ya); iy < Math.ceil(yb); iy++) {
				const wy = Math.min(yb, iy + 1) - Math.max(ya, iy);
				const sy = Math.max(0, Math.min(h - 1, iy));
				for (let ix = Math.floor(xa); ix < Math.ceil(xb); ix++) {
					const wgt = wy * (Math.min(xb, ix + 1) - Math.max(xa, ix));
					if (wgt <= 0) continue;
					const i = (sy * w + Math.max(0, Math.min(w - 1, ix))) * 4;
					const sa = rgba[i + 3] * wgt;
					r += rgba[i] * sa;
					g += rgba[i + 1] * sa;
					b += rgba[i + 2] * sa;
					a += sa;
					wsum += wgt;
				}
			}
			const o = (y * n + x) * 4;
			if (a > 0) {
				out[o] = Math.round(r / a);
				out[o + 1] = Math.round(g / a);
				out[o + 2] = Math.round(b / a);
			}
			out[o + 3] = Math.round(a / wsum);
		}
	}
	return out;
}

// A BLP -> PNG; crop: true, the Interface/Icons inset at ICON_PX; [x, y, s, s],
// that square cell at its own size; else the full frame.
function blpToPng(buf, crop) {
	const blp = decodeBlp(buf, { levels: 1 });
	const { width: w, height: h, rgba } = blp.mips[0];
	if (!crop) return encodePng(rgba, w, h);
	if (Array.isArray(crop)) {
		const [x, y, s] = crop;
		return encodePng(resizeBox(rgba, w, h, x, y, s, s, s), s, s);
	}
	return encodePng(resizeBox(rgba, w, h, INSET * w, INSET * h, (1 - 2 * INSET) * w, (1 - 2 * INSET) * h, ICON_PX), ICON_PX, ICON_PX);
}

function writeAtomic(file, data) {
	fs.mkdirSync(path.dirname(file), { recursive: true });
	const tmp = `${file}.${process.pid}.tmp`;
	fs.writeFileSync(tmp, data);
	fs.renameSync(tmp, file);
}

// opts: { sourcesDir, outDir, product, offline, fetchImpl, casc (a ready
// Casc-like { build, get(fdid) }, else openCasc's) }
function openIcons({ sourcesDir = SOURCES, outDir = DEFAULT_OUT, product = 'wow_classic_beta', offline = false, fetchImpl = globalThis.fetch, casc = null } = {}) {
	let cascP = null;
	function getCasc() {
		if (!cascP) {
			cascP = casc ? Promise.resolve(casc) : openCasc({ sourcesDir, product, offline, fetchImpl });
			cascP.catch(() => {
				cascP = null;
			});
		}
		return cascP;
	}

	// --- client tables (per build) ---
	const tables = new Map(); // name -> Promise of an index
	async function csvRows(name) {
		const { build } = await getCasc().catch((err) => {
			throw offline ? new NotCached(err.message) : err;
		});
		const get = async (url) => (await fetchRetry(url, { fetchImpl })).toString('utf8');
		return cachedTable({ sourcesDir, build, table: name, offline, get, missing: () => new NotCached(`--offline: ${name}.csv of ${build} is not cached`) });
	}
	function index(name, build) {
		if (!tables.has(name)) {
			const p = csvRows(name).then(build);
			p.catch(() => tables.delete(name));
			tables.set(name, p);
		}
		return tables.get(name);
	}
	const num = (v) => {
		const n = Number(v);
		return Number.isInteger(n) && n > 0 ? n : 0;
	};
	const items = () => index('Item', (rows) => new Map(rows.map((r) => [r.ID, num(r.IconFileDataID)])));
	const spells = () =>
		index('SpellMisc', (rows) => {
			const m = new Map();
			for (const r of rows) {
				const icon = num(r.SpellIconFileDataID);
				if (icon && (!m.has(r.SpellID) || r.DifficultyID === '0')) m.set(r.SpellID, icon);
			}
			return m;
		});
	const skills = () =>
		index('SkillLine', (rows) => {
			const byId = new Map(), byName = new Map();
			// Top-level lines first (Mining 186 before its tier 2946), then by ID.
			const sorted = rows.slice().sort((a, b) => (num(a.ParentSkillLineID) ? 1 : 0) - (num(b.ParentSkillLineID) ? 1 : 0) || Number(a.ID) - Number(b.ID));
			for (const r of sorted) {
				const icon = num(r.SpellIconFileID);
				byId.set(r.ID, icon);
				const name = keyOf('skill', String(r.DisplayName_lang || ''));
				if (icon && name && !byName.has(name)) byName.set(name, icon);
			}
			return { byId, byName };
		});
	const classes = () => index('ChrClasses', (rows) => new Map(rows.map((r) => [String(r.Filename).toUpperCase(), num(r.IconFileDataID)])));

	// --- client paths ---
	const pathsFile = path.join(outDir, 'paths.json');
	let paths = {};
	try {
		paths = JSON.parse(fs.readFileSync(pathsFile, 'utf8'));
	} catch {
		paths = {};
	}
	// One search answers many paths: a UI texture's whole folder, the race
	// icons' common prefix; an Interface/Icons path (a folder of tens of
	// thousands) its own name.
	const termOf = (p) => (p.startsWith('interface/icons/achievement_character_') ? 'interface/icons/achievement_character_' : p.startsWith('interface/icons/') ? p : p.slice(0, p.lastIndexOf('/') + 1));
	const searches = new Map(); // search term -> Promise
	const savePaths = () => writeAtomic(pathsFile, `${JSON.stringify(paths, null, '\t')}\n`);
	async function fdidOfPath(p) {
		const file = `${p}.blp`;
		if (Object.hasOwn(paths, file)) return paths[file];
		if (offline) throw new NotCached(`--offline: ${file} is not resolved yet`);
		const term = termOf(p);
		if (!searches.has(term)) {
			const s = (async () => {
				const found = JSON.parse((await fetchRetry(filesUrl(term, product), { fetchImpl, timeout: 180000 })).toString('utf8'));
				for (const [id, name] of Object.entries(found && typeof found === 'object' ? found : {})) {
					if (num(id) && typeof name === 'string' && name.toLowerCase().startsWith(term)) paths[name.toLowerCase()] = num(id);
				}
			})();
			searches.set(term, s);
			s.finally(() => searches.delete(term)).catch(() => {});
		}
		await searches.get(term);
		if (!Object.hasOwn(paths, file)) paths[file] = null;
		savePaths();
		return paths[file];
	}

	// kind, canonical key -> { fdid, crop } | null (no icon)
	async function resolve(kind, key) {
		const icon = (fdid) => (fdid ? { fdid, crop: true } : null);
		const byPath = async (p) => {
			const fdid = await fdidOfPath(p);
			return fdid ? { fdid, crop: p.startsWith('interface/icons/') } : null;
		};
		switch (kind) {
			case 'fdid':
				return { fdid: Number(key), crop: false };
			case 'item':
				return icon((await items()).get(key));
			case 'spell':
				return icon((await spells()).get(key));
			case 'skill': {
				const s = await skills();
				return icon(/^\d+$/.test(key) ? s.byId.get(key) : s.byName.get(key));
			}
			case 'class':
				return icon((await classes()).get(key));
			case 'race': {
				const [race, sex] = key.split('-');
				const p = (x) => (race === 'Skyborne' ? `interface/characterframe/temporaryportrait-${x}-skyborne` : `interface/icons/achievement_character_${RACE_ICON[race] || race.toLowerCase()}_${x}`);
				return (await byPath(p(sex))) || (sex === 'female' ? byPath(p('male')) : null);
			}
			case 'ui': {
				const e = UI[key];
				if (e.fdid) return { fdid: e.fdid, crop: e.cell || false };
				return e.item ? icon((await items()).get(String(e.item))) : byPath(e.path);
			}
			default:
				return null;
		}
	}

	async function render(kind, key) {
		const png = path.join(outDir, kind, `${key}.png`);
		const miss = path.join(outDir, kind, `${key}.miss`);
		if (fs.existsSync(png)) return fs.readFileSync(png);
		if (fs.existsSync(miss)) return null;
		let out = null;
		try {
			const r = await resolve(kind, key);
			if (r) {
				let buf = null;
				try {
					buf = await (await getCasc()).get(r.fdid);
				} catch (err) {
					if (err.status !== 404) throw offline ? new NotCached(err.message) : err;
				}
				if (buf) {
					try {
						out = blpToPng(buf, r.crop);
					} catch {
						out = null; // not a texture we read (BLP1, JPEG, not a BLP)
					}
				}
			}
		} catch (err) {
			if (err instanceof NotCached) return null;
			throw err;
		}
		if (out) writeAtomic(png, out);
		else writeAtomic(miss, '');
		return out;
	}

	const pending = new Map(); // `${kind}/${key}` -> Promise
	function icon(kind, rawKey) {
		const key = keyOf(kind, rawKey);
		if (!key) return Promise.resolve(null);
		const id = `${kind}/${key}`;
		if (!pending.has(id)) {
			const p = render(kind, key);
			pending.set(id, p);
			p.finally(() => pending.delete(id)).catch(() => {});
		}
		return pending.get(id);
	}

	function info() {
		const available = !offline || fs.existsSync(outDir) || fs.existsSync(path.join(sourcesDir, 'casc', product));
		return { ui: Object.keys(UI), kinds: KINDS.slice(), available };
	}

	return { icon, info, outDir };
}

module.exports = { openIcons, keyOf, resizeBox, blpToPng, KINDS, UI, DEFAULT_OUT, ICON_PX };
