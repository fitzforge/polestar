'use strict';
// The planner's GET routes (tools/planner/server.js) as static files under
// www/, so the browser planner needs nothing but a static file server, and
// the walk legs (tools/planner/navpool.js) its timelines need, routed ahead.
// A build step in Node because glyph and PNG rendering, the TGA decode and
// the nav router that returns points live only in tools/ (JS).
//
//   node rust/crates/forge-wasm/www-build/export-assets.js [options]
//
//   --out <dir>          the www root (default rust/crates/forge-wasm/www)
//   --local <dir>        data/local of a checkout with the planner art, icons,
//                        nav grid and nav layers (default <repo>/data/local)
//   --art, --icons, --nav, --roads <dir>, --hubs <file>
//                        each source alone (default under --local:
//                        planner/art, planner/icons, nav, nav-layers/roads,
//                        nav-layers/hubs.json)
//   --data <dir>         reference data (default <repo>/data/forever)
//   --sources <dir>      cached sources: TaxiPathNode for the flight paths and
//                        QuestXP for the timelines (default <repo>/data/sources)
//   --sim <dir>          the simulator dir with params.json (default <repo>/data/sim)
//   --set <name>=<pack dir>@<Race>,<Race>   (repeatable) a guide set whose
//                        timelines are routed: per race, the page's default
//                        character as that race and the start the page picks
//   --refs <dir>         also write each set's fully routed timeline_get
//                        (timeline-<set>-<race>.{summary,full}.json) and its
//                        command (args-<set>-<race>.json: { name, args, context })
//   --routes-cache <f>   where newly routed legs are appended (default navpool's
//                        own <nav>/routes-<build>.jsonl); read besides that one
//   --workers <n>        nav router workers (default 6)
//   --copy               copy the art, fonts and icons (default: symlinks)
//   --only <stages>      comma-separated of art, nav, own, icons, flights, legs
//
// Writes, under --out (paths as the server's routes; generated, git-ignored):
//   art/index.json, art/zones/<uiMapID>.png, art/tiles/<c>/<L>/<tx>_<ty>.bc1
//     (the .bc1.gz bytes as they are: the page inflates them)
//   nav/index.json, nav/tile/<c>/<col>_<row>.png, nav/aids.json,
//   nav/roads/index.json, nav/roads/tile/<c>/<col>_<row>.png, nav/hubs.json
//   glyph/<name>.png (every glyph at 128 px), emblem.png (128 px), band.png,
//   band-stars.png, fonts/<file>.ttf, media/<UI|Nav>/<name>.png
//   icon/<kind>/<key>.png: every icon in the local icon cache, by its
//     canonical key (icons.js keyOf: skills lower-case with dashes, classes
//     upper case, races <Race>-<sex>); nothing is fetched
//   bundle/flights.json.gz: Workspace.flightPaths() as { [pathId]: [[wx, wy]] }
//   nav/legs/index.json { build, continents: { [c]: { file, count, bytes } } }
//     and nav/legs/<c>.json.gz: { [leg key]: route } with navpool's key
//     (`c:wx:wy>c:wx:wy|profile`) and route as its provider returns it: the
//     route cache of the nav build plus every leg the --set timelines walk,
//     routed until a rebuild misses none
//
// Each set is loaded as our own pack (as the planner of a checkout with
// those guides would), and --sources stands in for <repo>/data/sources
// (timeline.js reads its QuestXP from there): run() sets tools/lib/paths
// SOURCES before the timeline module loads.
//
// Library: run(opts) -> summary, opts as the flags in camelCase
// (sets: [{ name, dir, races }]).

const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');

const ROOT = path.resolve(__dirname, '..', '..', '..', '..');
const TOOLS = path.join(ROOT, 'tools');
const paths = require(path.join(TOOLS, 'lib', 'paths'));

const STAGES = ['art', 'nav', 'own', 'icons', 'flights', 'legs'];
const GLYPH_PX = 128;
// The page's character before it picks one for a guide (commands.js DEFAULT_CHARACTER).
const PAGE_CLASS = 'WARRIOR';

const rel = (p) => path.relative(process.cwd(), p) || '.';

function writeFile(file, data) {
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, data);
}

// file -> dest, a symlink (absolute target) or a copy.
function place(src, dest, copy) {
	fs.mkdirSync(path.dirname(dest), { recursive: true });
	fs.rmSync(dest, { recursive: true, force: true });
	if (copy) fs.cpSync(src, dest, { recursive: true, dereference: true });
	else fs.symlinkSync(path.resolve(src), dest);
}

// A fresh output directory (links in it are removed, not followed).
function fresh(dir) {
	fs.rmSync(dir, { recursive: true, force: true });
	fs.mkdirSync(dir, { recursive: true });
}

const gzipJson = (value) => zlib.gzipSync(JSON.stringify(value), { level: 9 });

// --- art -----------------------------------------------------------------

function exportArt({ out, artDir, copy }) {
	const dest = path.join(out, 'art');
	fresh(dest);
	place(path.join(artDir, 'index.json'), path.join(dest, 'index.json'), copy);
	place(path.join(artDir, 'zones'), path.join(dest, 'zones'), copy);
	let tiles = 0;
	const tilesDir = path.join(artDir, 'tiles');
	for (const c of fs.readdirSync(tilesDir)) {
		for (const L of fs.readdirSync(path.join(tilesDir, c))) {
			for (const f of fs.readdirSync(path.join(tilesDir, c, L))) {
				const m = /^(\d+_\d+)\.bc1\.gz$/.exec(f);
				if (!m) continue;
				place(path.join(tilesDir, c, L, f), path.join(dest, 'tiles', c, L, `${m[1]}.bc1`), copy);
				tiles++;
			}
		}
	}
	return { tiles, zones: fs.readdirSync(path.join(artDir, 'zones')).filter((f) => f.endsWith('.png')).length };
}

// --- nav overlays --------------------------------------------------------

function exportNav({ out, nav, ws, roadsDir, hubsFile, log }) {
	const roads = require(path.join(TOOLS, 'lib', 'nav', 'layers', 'roads'));
	const dest = path.join(out, 'nav');
	for (const d of ['tile', 'roads', 'index.json', 'aids.json', 'hubs.json']) fs.rmSync(path.join(dest, d), { recursive: true, force: true });
	const info = nav.info();
	if (!info.available) throw new Error(`no navigation grid in ${nav.dir}`);
	const continents = Object.fromEntries(Object.entries(nav.index.continents).map(([c, v]) => [c, v.tiles || []]));
	writeFile(path.join(dest, 'index.json'), JSON.stringify({ build: info.build, continents }));
	const summary = { build: info.build, tiles: 0, missingTiles: [], roads: 0, aids: false, hubs: false };
	for (const [c, list] of Object.entries(continents)) {
		for (const t of list) {
			const [col, row] = t.split('_').map(Number);
			const png = nav.walkable(Number(c), col, row);
			if (!png) summary.missingTiles.push(`${c}:${t}`);
			else {
				writeFile(path.join(dest, 'tile', c, `${t}.png`), png);
				summary.tiles++;
			}
		}
	}
	const aids = ws.navAids();
	if (aids) {
		writeFile(path.join(dest, 'aids.json'), JSON.stringify(aids));
		summary.aids = true;
	}
	const roadsIndex = path.join(roadsDir, 'index.json');
	if (fs.existsSync(roadsIndex)) {
		const index = JSON.parse(fs.readFileSync(roadsIndex, 'utf8'));
		writeFile(path.join(dest, 'roads', 'index.json'), JSON.stringify(index));
		for (const [c, list] of Object.entries(index.continents || {})) {
			for (const t of list) {
				const [col, row] = t.split('_').map(Number);
				const w = roads.roadWeights(Number(c), col, row, roadsDir);
				if (!w) continue;
				writeFile(path.join(dest, 'roads', 'tile', c, `${t}.png`), roads.roadsPng(w));
				summary.roads++;
			}
		}
	} else log(`no roads layer at ${rel(roadsIndex)}`);
	if (fs.existsSync(hubsFile)) {
		const doc = JSON.parse(fs.readFileSync(hubsFile, 'utf8'));
		const hubs = {};
		for (const c of doc.maps || []) hubs[c] = doc[c] || [];
		writeFile(path.join(dest, 'hubs.json'), JSON.stringify(hubs));
		summary.hubs = true;
	} else log(`no hubs layer at ${rel(hubsFile)}`);
	return summary;
}

// --- Polestar's own art, fonts, addon textures ----------------------------

function exportOwn({ out, copy }) {
	const glyphs = require(path.join(TOOLS, 'planner', 'glyphs'));
	const glyphDir = path.join(out, 'glyph');
	fresh(glyphDir);
	for (const name of glyphs.NAMES) writeFile(path.join(glyphDir, `${name}.png`), glyphs.renderGlyph(name, GLYPH_PX));
	writeFile(path.join(out, 'emblem.png'), glyphs.renderEmblem(GLYPH_PX));
	const band = glyphs.renderBand();
	writeFile(path.join(out, 'band.png'), band.band);
	writeFile(path.join(out, 'band-stars.png'), band.stars);

	const media = path.join(ROOT, 'addon', 'Polestar', 'Media');
	const fontDir = path.join(out, 'fonts');
	fresh(fontDir);
	const fonts = fs.readdirSync(path.join(media, 'Fonts')).filter((f) => /^[A-Za-z0-9-]+\.ttf$/.test(f));
	for (const f of fonts) place(path.join(media, 'Fonts', f), path.join(fontDir, f), copy);

	const mediaDir = path.join(out, 'media');
	fresh(mediaDir);
	let textures = 0;
	for (const group of ['UI', 'Nav']) {
		for (const f of fs.readdirSync(path.join(media, group))) {
			const m = /^([a-z0-9-]+)\.tga$/.exec(f);
			const png = m && glyphs.mediaPng(group, m[1]);
			if (!png) continue;
			writeFile(path.join(mediaDir, group, `${m[1]}.png`), png);
			textures++;
		}
	}
	return { glyphs: glyphs.NAMES.length, fonts: fonts.length, textures };
}

// --- game icons (the local cache only) ------------------------------------

function exportIcons({ out, iconsDir, copy }) {
	const { keyOf, KINDS, UI } = require(path.join(TOOLS, 'planner', 'icons'));
	const dest = path.join(out, 'icon');
	fresh(dest);
	const counts = {};
	for (const kind of KINDS) {
		const dir = path.join(iconsDir, kind);
		if (!fs.existsSync(dir)) continue;
		for (const f of fs.readdirSync(dir)) {
			const m = /^(.+)\.png$/.exec(f);
			if (!m || keyOf(kind, m[1]) !== m[1]) continue;
			place(path.join(dir, f), path.join(dest, kind, f), copy);
			counts[kind] = (counts[kind] || 0) + 1;
		}
	}
	const missingUi = Object.keys(UI).filter((k) => !fs.existsSync(path.join(dest, 'ui', `${k}.png`)));
	return { counts, missingUi };
}

// --- flights ----------------------------------------------------------------

function exportFlights({ out, ws }) {
	const flights = ws.flightPaths();
	if (!flights) throw new Error(`no flight paths: TaxiPathNode.csv of travel build ${ws.travel && ws.travel.build} is not under ${ws.sourcesDir}`);
	writeFile(path.join(out, 'bundle', 'flights.json.gz'), gzipJson(Object.fromEntries(flights)));
	return { paths: flights.size };
}

// --- timelines and their legs -----------------------------------------------

// A Workspace over one guide set, the set as our own pack.
function openSet({ dir, dataDir, simDir, navDir, sourcesDir, log }) {
	const { Workspace } = require(path.join(TOOLS, 'planner', 'workspace'));
	const { readManifest } = require(path.join(TOOLS, 'lib', 'pack', 'manifest'));
	const ours = path.resolve(dir);
	class SetWorkspace extends Workspace {
		addPack(packDir) {
			const official = path.resolve(packDir) === ours;
			const { manifest, diags } = readManifest(packDir, { official });
			if (!manifest) throw new Error(`${packDir}: ${diags.filter((d) => d.severity === 'error').map((d) => d.message).join('; ')}`);
			this.packs.push({ id: manifest.id, title: manifest.title, dir: packDir, official, manifest, diags });
		}
	}
	return new SetWorkspace({ dataDir, officialDir: ours, simDir, navDir, sourcesDir, watch: false, log });
}

// The page's character for a race: its default (Human WARRIOR) moved to the
// race as library.js characterFor does (the class kept when the race can be it).
function characterOf(ws, race) {
	const sides = ws.data.races[race];
	if (!sides) throw new Error(`no race "${race}"`);
	const [faction, r] = Object.entries(sides)[0];
	const classes = r.classes || [];
	return { race, cls: classes.includes(PAGE_CLASS) ? PAGE_CLASS : classes[0], faction };
}

// The characters a set's entries name: `Race` (the page's character for it; its references are
// written), `Race/CLASS` (that class, the race's first side) or `*` (every race, side and class
// races.json allows: the page's whole character picker).
function charactersOf(ws, entries) {
	const out = [];
	const seen = new Set();
	const add = (race, character, ref) => {
		const k = `${character.race}|${character.cls}|${character.faction}`;
		if (seen.has(k)) return;
		seen.add(k);
		out.push({ race, character, ref });
	};
	for (const e of entries) {
		if (e === '*') {
			for (const [race, sides] of Object.entries(ws.data.races || {})) {
				for (const [faction, r] of Object.entries(sides)) for (const cls of r.classes || []) add(`${race}-${cls}-${faction}`, { race, cls, faction }, false);
			}
		} else if (e.includes('/')) {
			const [race, cls] = e.split('/');
			const ch = characterOf(ws, race);
			add(`${race}-${cls}`, { ...ch, cls }, false);
		} else add(e, characterOf(ws, e), true);
	}
	return out;
}

// The start the page takes for a character (commands.js defaultStart): our
// first leveling guide for them that no other guide hands over to.
function startOf(ws, ch) {
	const list = ws.list();
	const named = new Set(list.flatMap((g) => g.nextChoices || (g.next ? [g.next] : [])));
	const fits = (g) => (!g.faction || g.faction === ch.faction) && (!g.races || g.races.includes(ch.race)) && (!g.classes || g.classes.includes(ch.cls));
	const first = list.find((g) => g.category === 'Leveling' && !named.has(g.id) && fits(g)) || list.find(fits);
	if (!first) throw new Error(`no guide for ${ch.race} ${ch.cls}`);
	return first.id;
}

// timeline_get until a build misses no leg -> { summary, full, rounds }.
async function routedTimeline(ws, nav, args, log) {
	const commands = require(path.join(TOOLS, 'planner', 'commands'));
	for (let round = 1; ; round++) {
		const full = await commands.run(ws, 'timeline_get', { ...args, view: 'full' });
		if (!full.routing || !full.routing.pending) {
			const summary = await commands.run(ws, 'timeline_get', { ...args, view: 'summary' });
			return { summary, full, rounds: round };
		}
		const id = full.routing.id;
		log(`  round ${round}: routing ${full.routing.pending} legs`);
		const tick = setInterval(() => {
			const gib = (process.memoryUsage().rss / 1024 ** 3).toFixed(1);
			log(`    ${full.routing.done} done, ${full.routing.pending} pending (rss ${gib} GiB)`);
		}, 30000);
		await new Promise((resolve) => {
			const on = (e) => {
				if (e && e.routed === id) {
					ws.off('changed', on);
					resolve();
				}
			};
			ws.on('changed', on);
		});
		clearInterval(tick);
	}
}

async function exportLegs({ out, nav, sets, dataDir, simDir, navDir, sourcesDir, refsDir, log }) {
	const result = { timelines: [], routeSeconds: 0 };
	const t0 = Date.now();
	for (const set of sets) {
		const ws = openSet({ dir: set.dir, dataDir, simDir, navDir, sourcesDir, log });
		ws.nav = nav; // one router for every set
		try {
			for (const { race, character, ref } of charactersOf(ws, set.races)) {
				let start;
				try {
					start = startOf(ws, character);
				} catch (err) {
					log(`timeline ${set.name} ${character.race} ${character.cls} ${character.faction}: ${err.message}, skipped`);
					continue;
				}
				const args = { start, character, choices: {}, startLevel: null, optional: false };
				log(`timeline ${set.name} ${race}: ${args.start} as ${character.race} ${character.cls}`);
				const { summary, full, rounds } = await routedTimeline(ws, nav, args, log);
				const totals = summary.totals || {};
				result.timelines.push({ set: set.name, race, start: args.start, character, rounds, legs: totals.legs, routed: totals.routed, pending: summary.nav && summary.nav.routing ? summary.nav.routing.pending : 0 });
				if (refsDir && ref) {
					const base = `${set.name}-${race.toLowerCase()}`;
					writeFile(path.join(refsDir, `timeline-${base}.summary.json`), JSON.stringify(summary, null, '\t'));
					writeFile(path.join(refsDir, `timeline-${base}.full.json`), JSON.stringify(full));
					const context = { guides: path.resolve(set.dir), dataDir: path.resolve(dataDir), simDir: path.resolve(simDir), navDir: path.resolve(navDir), sourcesDir: path.resolve(sourcesDir), navBuild: nav.build };
					writeFile(path.join(refsDir, `args-${base}.json`), JSON.stringify({ name: 'timeline_get', args, context }, null, '\t'));
				}
			}
		} finally {
			ws.nav = null; // not closed with the workspace
			ws.close();
		}
	}
	result.routeSeconds = Math.round((Date.now() - t0) / 1000);

	// Every leg the router knows for this build: its cache and this run's.
	const byC = new Map();
	let errors = 0;
	const add = (k, r) => {
		const c = k.slice(0, k.indexOf(':'));
		if (!byC.has(c)) byC.set(c, {});
		byC.get(c)[k] = r;
	};
	for (const [k, r] of nav.cache) add(k, r);
	for (const [k, r] of nav.errors) {
		add(k, r);
		errors++;
	}
	const dest = path.join(out, 'nav', 'legs');
	fresh(dest);
	const index = { build: nav.build, continents: {} };
	for (const [c, legs] of [...byC].sort((a, b) => Number(a[0]) - Number(b[0]))) {
		const file = `${c}.json.gz`;
		const data = gzipJson(legs);
		writeFile(path.join(dest, file), data);
		index.continents[c] = { file, count: Object.keys(legs).length, bytes: data.length };
	}
	writeFile(path.join(dest, 'index.json'), JSON.stringify(index));
	result.build = nav.build;
	result.legs = index.continents;
	result.errors = errors;
	return result;
}

// --- run --------------------------------------------------------------------

async function run(opts = {}) {
	const local = path.resolve(opts.local || path.join(ROOT, 'data', 'local'));
	const o = {
		out: path.resolve(opts.out || path.join(__dirname, '..', 'www')),
		artDir: path.resolve(opts.art || path.join(local, 'planner', 'art')),
		iconsDir: path.resolve(opts.icons || path.join(local, 'planner', 'icons')),
		navDir: path.resolve(opts.nav || path.join(local, 'nav')),
		roadsDir: path.resolve(opts.roads || path.join(local, 'nav-layers', 'roads')),
		hubsFile: path.resolve(opts.hubs || path.join(local, 'nav-layers', 'hubs.json')),
		dataDir: path.resolve(opts.data || paths.DATA),
		sourcesDir: path.resolve(opts.sources || paths.SOURCES),
		simDir: path.resolve(opts.sim || path.join(ROOT, 'data', 'sim')),
		sets: opts.sets || [],
		refsDir: opts.refs ? path.resolve(opts.refs) : null,
		routesCache: opts.routesCache ? path.resolve(opts.routesCache) : null,
		workers: opts.workers || 6,
		copy: !!opts.copy,
		only: new Set(opts.only && opts.only.length ? opts.only : STAGES),
		log: opts.log || (() => {}),
	};
	for (const s of o.only) if (!STAGES.includes(s)) throw new Error(`no stage "${s}" (stages: ${STAGES.join(', ')})`);
	if (o.only.has('legs') && !o.sets.length) throw new Error('legs: no --set to route');
	// timeline.js reads QuestXP under SOURCES when it loads.
	if (Object.keys(require.cache).some((k) => k.endsWith(path.join('lib', 'planner', 'timeline.js')))) throw new Error('tools/lib/planner/timeline.js is loaded already: --sources cannot apply');
	paths.SOURCES = o.sourcesDir;
	const log = o.log;
	const summary = { out: o.out };

	if (o.only.has('art')) {
		summary.art = exportArt(o);
		log(`art: ${summary.art.tiles} tiles, ${summary.art.zones} zones`);
	}
	if (o.only.has('own')) {
		summary.own = exportOwn(o);
		log(`own: ${summary.own.glyphs} glyphs, ${summary.own.fonts} fonts, ${summary.own.textures} textures`);
	}
	if (o.only.has('icons')) {
		summary.icons = exportIcons(o);
		log(`icons: ${JSON.stringify(summary.icons.counts)}${summary.icons.missingUi.length ? `; not cached: ui ${summary.icons.missingUi.join(', ')}` : ''}`);
	}
	const needWs = o.only.has('nav') || o.only.has('flights');
	const needNav = o.only.has('nav') || o.only.has('legs');
	let nav = null;
	if (needNav) {
		const { NavRoutes } = require(path.join(TOOLS, 'planner', 'navpool'));
		nav = new NavRoutes({ dir: o.navDir, workers: o.workers, log });
		if (o.routesCache) {
			let n = 0;
			if (fs.existsSync(o.routesCache)) {
				for (const line of fs.readFileSync(o.routesCache, 'utf8').split('\n')) {
					if (!line) continue;
					try {
						const { k, r } = JSON.parse(line);
						nav.cache.set(k, r);
						n++;
					} catch {
						// a torn last line
					}
				}
			}
			log(`nav routes: ${n} cached legs from ${rel(o.routesCache)}`);
			fs.mkdirSync(path.dirname(o.routesCache), { recursive: true });
			nav.file = () => o.routesCache;
		}
	}
	try {
		if (needWs) {
			const base = o.sets[0] ? o.sets[0].dir : null;
			if (!base) throw new Error('nav/flights: a --set is needed (its workspace places the aids and reads travel)');
			const ws = openSet({ dir: base, dataDir: o.dataDir, simDir: o.simDir, navDir: o.navDir, sourcesDir: o.sourcesDir, log });
			try {
				if (o.only.has('nav')) {
					summary.nav = exportNav({ ...o, nav, ws });
					log(`nav: build ${summary.nav.build}, ${summary.nav.tiles} walkable tiles, ${summary.nav.roads} road tiles, aids ${summary.nav.aids}, hubs ${summary.nav.hubs}`);
				}
				if (o.only.has('flights')) {
					summary.flights = exportFlights({ out: o.out, ws });
					log(`flights: ${summary.flights.paths} paths`);
				}
			} finally {
				ws.close();
			}
		}
		if (o.only.has('legs')) {
			summary.legs = await exportLegs({ ...o, nav });
			log(`legs: build ${summary.legs.build}, ${JSON.stringify(summary.legs.legs)}, ${summary.legs.errors} errors, routed in ${summary.legs.routeSeconds} s`);
		}
	} finally {
		if (nav) nav.close();
	}
	return summary;
}

// --- CLI ---------------------------------------------------------------------

function parseArgs(argv) {
	const opts = { sets: [] };
	const camel = (s) => s.replace(/-([a-z])/g, (_, c) => c.toUpperCase());
	for (let i = 0; i < argv.length; i++) {
		const a = argv[i];
		if (a === '--copy') opts.copy = true;
		else if (a === '--set') {
			const m = /^([\w-]+)=(.+)@([A-Za-z,*/]+)$/.exec(argv[++i] || '');
			if (!m) throw new Error('--set <name>=<pack dir>@<Race>[,<Race>/<CLASS>,*]');
			opts.sets.push({ name: m[1], dir: m[2], races: m[3].split(',') });
		} else if (a === '--only') opts.only = String(argv[++i] || '').split(',').filter(Boolean);
		else if (a === '--workers') opts.workers = Number(argv[++i]);
		else if (/^--(out|local|art|icons|nav|roads|hubs|data|sources|sim|refs|routes-cache)$/.test(a)) opts[camel(a.slice(2))] = argv[++i];
		else throw new Error(`unknown argument "${a}"`);
	}
	return opts;
}

if (require.main === module) {
	let opts;
	try {
		opts = parseArgs(process.argv.slice(2));
	} catch (err) {
		console.error(err.message);
		process.exit(2);
	}
	run({ ...opts, log: (m) => console.log(m) }).then(
		(s) => {
			console.log(JSON.stringify(s, null, 2));
			process.exit(0);
		},
		(err) => {
			console.error(err.stack || err);
			process.exit(1);
		},
	);
}

module.exports = { run, parseArgs };
