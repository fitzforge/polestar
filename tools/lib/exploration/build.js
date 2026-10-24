'use strict';
// Builds the exploration guides (guides/forever/exploration/*.guide) from the
// Forever client's map tables (areas.js), data/forever (zones, map frames,
// flight masters) and the zone order in spec.js:
//
//   node tools/polestar.js exploration build    # rewrite guides/forever/exploration/*.guide
//   node tools/polestar.js exploration check    # exit 1 when a guide is out of date

const fs = require('node:fs');
const path = require('node:path');
const { loadAreas } = require('./areas');
const { GUIDES, TOWNS, CAUTIONS, ISLANDS, LEGACY_NOTE } = require('./spec');
const P = require('./plan');
const { header } = require('../generated');

const { ROOT, DATA, SOURCES } = require('../paths');
const OUT_DIR = path.join(ROOT, 'guides', 'forever', 'exploration');
const ID_PREFIX = 'forever/exploration/';
const FACTIONS = ['Alliance', 'Horde'];

function readJson(dir, name) {
	const file = path.join(dir, `${name}.json`);
	if (!fs.existsSync(file)) throw new Error(`${path.relative(process.cwd(), file)} missing (forge data build / travel build)`);
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

function quote(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"')}"`;
}

function wrap(text, width) {
	const out = [];
	let line = '';
	for (const word of text.split(/\s+/)) {
		if (line && line.length + 1 + word.length > width) {
			out.push(line);
			line = word;
		} else {
			line = line ? `${line} ${word}` : word;
		}
	}
	if (line) out.push(line);
	return out;
}

// Continent UiMap ID by name: the type-2 maps that parent zone maps, or an
// island zone map (its own continent).
function continentId(ctx, name) {
	const ids = new Set(Object.values(ctx.continents));
	const z = Object.values(ctx.zones).find((m) => (m.type === 2 || (m.type === 3 && ISLANDS.includes(m.name))) && m.name === name && ids.has(m.id));
	if (!z) throw new Error(`exploration spec: unknown continent "${name}"`);
	return z.id;
}

function sideLines(lines, side) {
	const out = [];
	if (lines.both) out.push({ text: lines.both, only: null });
	for (const f of FACTIONS) if (lines[f] && (!side || side === f)) out.push({ text: lines[f], only: side ? null : f });
	return out;
}

function zoneTip(v) {
	const n = v.steps.reduce((s, c) => s + c.length, 0);
	const parts = [`${n} ${n === 1 ? 'area' : 'areas'} to discover here`];
	if (v.levels) parts[0] += v.levels[0] === v.levels[1] ? `, level ${v.levels[0]}.` : `, levels ${v.levels[0]}-${v.levels[1]}.`;
	else parts[0] += '.';
	if (v.tip) parts.push(v.tip);
	return parts.join(' ');
}

function renderGuide(ctx, guide, blocks) {
	const cont = continentId(ctx, guide.continent);
	const count = new Set(blocks.flatMap((b) => b.visits.flatMap((v) => v.steps.flat().map((o) => o.overlay)))).size;
	const L = [];
	L.push(header('guide', 'exploration build', "the client's map tables, data/forever and tools/lib/exploration/spec.js"));
	L.push(`guide ${ID_PREFIX}${guide.id}`);
	L.push(`title ${guide.title}`);
	L.push('category Exploration');
	L.push('coords era');
	L.push(`levels ${guide.levels[0]}-${guide.levels[1]}`);
	L.push(`zone map ${cont}`);
	if (guide.next) L.push(`next ${ID_PREFIX}${guide.next}`);
	L.push('');
	const intro = [
		`Every discoverable area of ${guide.zonesSummary} (${count} map overlays), for both factions.`,
		"Each `explore` point is the centre of the area's map overlay hit rect in the Forever client's tables",
		`(WorldMapOverlay, UiMapXMapArt, UiMap, AreaTable via wago.tools, build ${ctx.build}), in the map's live frame`,
		'(written `live` where Forever moved the map or added it, else the Era frame it equals); area levels are',
		'AreaTable.ExplorationLevel; flight masters come from data/forever/travel.json. Zone order and travel lines are',
		'tools/lib/exploration/spec.js; inside a zone the areas are a shortest tour from where you arrive towards the next zone.',
	].join(' ');
	for (const line of wrap(intro, 78)) L.push(`# ${line}`);
	for (const b of blocks) {
		if (b.side) {
			L.push('');
			L.push(`# ---------------------------------------------------------------- ${b.side}`);
		}
		b.visits.forEach((v, vi) => {
			v.steps.forEach((goals, si) => {
				L.push('');
				L.push(`step ${v.zone}${v.steps.length > 1 ? ` (${si + 1}/${v.steps.length})` : ''}`);
				if (b.side) L.push(`  only ${b.side}`);
				// A name two maps share (Zephras Isle) is written by its uiMapID.
				const shared = Object.values(ctx.zones).filter((z) => z.name === v.zone).length > 1;
				L.push(`  zone ${shared ? `map ${v.map}` : v.zone}`);
				if (si === 0) {
					const intro = vi === 0 ? [guide.intro.both, b.side && guide.intro[b.side]].filter(Boolean).join(' ') : '';
					L.push(`  tip ${intro ? `${intro} ` : ''}${zoneTip(v)}`);
					if (vi === 0) L.push(`  note ${quote(LEGACY_NOTE)}`);
					for (const t of sideLines(v.travel, b.side)) L.push(`  note ${quote(t.text)}${t.only ? ` only ${t.only}` : ''}`);
					const fpLists = b.side ? [{ list: [...v.fps.both, ...v.fps[b.side]], only: null }] : [{ list: v.fps.both, only: null }, ...FACTIONS.map((f) => ({ list: v.fps[f], only: f }))];
					for (const { list, only } of fpLists) {
						if (!list.length) continue;
						L.push(`  note ${quote(`Flight ${list.length > 1 ? 'paths' : 'path'} here: ${list.join(', ')}.`)}${only ? ` only ${only}` : ''}`);
					}
				}
				for (const o of goals) {
					const note = o.notes.length ? ` -- ${o.notes.join('; ')}` : '';
					L.push(`  explore ${o.x},${o.y} ${quote(P.areaLabel(o))}${ctx.live.has(v.map) ? ' live' : ''}${note}`);
				}
			});
		});
	}
	return `${L.join('\n')}\n`;
}

// Every zone map with overlays on a continent must be in each faction's
// routes across that continent's guides, and every town or hazard named in
// spec.js must be an area of the client tables.
function checkSpec(ctx) {
	const errors = [];
	const byCont = {};
	for (const g of GUIDES) {
		const c = continentId(ctx, g.continent);
		for (const f of FACTIONS) {
			const route = g.routes[f] || g.routes.both;
			if (!route) continue;
			const key = `${c}:${f}`;
			byCont[key] = byCont[key] || new Set();
			for (const v of route.visits) byCont[key].add(ctx.zoneId.get(v.zone));
		}
	}
	for (const [key, seen] of Object.entries(byCont)) {
		const [c, f] = key.split(':');
		for (const map of Object.keys(ctx.areas)) {
			if (String(ctx.continents[map]) !== c || seen.has(Number(map))) continue;
			errors.push(`${f}: ${ctx.zones[map].name} (${map}) is in no exploration guide`);
		}
	}
	const known = new Set(Object.values(ctx.areas).flatMap((list) => list.flatMap((o) => o.areas.map((a) => a.name))));
	for (const name of [...TOWNS.Alliance, ...TOWNS.Horde, ...Object.keys(CAUTIONS)]) {
		if (!known.has(name)) errors.push(`"${name}" is not a map area in the client tables`);
	}
	if (errors.length) throw new Error(`exploration spec:\n  ${errors.join('\n  ')}`);
}

// Area (overlay) counts per continent name.
function continentCounts(ctx) {
	const out = {};
	for (const [map, list] of Object.entries(ctx.areas)) {
		const name = ctx.zones[ctx.continents[map]].name;
		out[name] = (out[name] || 0) + list.length;
	}
	return out;
}

// -> { files: { 'name.guide': text }, counts, build, warnings }
async function buildAll({ dataDir = DATA, sourcesDir = SOURCES, offline = false, build, log } = {}) {
	const zones = readJson(dataDir, 'zones');
	const islands = Object.values(zones).filter((z) => z.type === 3 && ISLANDS.includes(z.name) && z.parent).map((z) => z.id);
	const loaded = await loadAreas({ sourcesDir, offline, build, log, islands });
	const ctx = P.context({
		areas: loaded.areas,
		continents: loaded.continents,
		zones,
		frames: readJson(dataDir, 'map-frames'),
		travel: readJson(dataDir, 'travel'),
	});
	ctx.build = loaded.build;
	checkSpec(ctx);
	const files = {};
	for (const g of GUIDES) {
		const blocks = P.planGuide(ctx, g);
		const zones = [...new Set(blocks.flatMap((b) => b.visits.map((v) => v.zone)))];
		files[`${g.id}.guide`] = renderGuide(ctx, { ...g, zonesSummary: zones.join(', ') }, blocks);
	}
	return { files, counts: continentCounts(ctx), build: loaded.build, warnings: loaded.warnings };
}

module.exports = { buildAll, renderGuide, checkSpec, continentCounts, OUT_DIR };
