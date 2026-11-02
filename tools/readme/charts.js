'use strict';
// The README's route chart, from the route checker. Reads two `forge judge
// check` results (check.json): the guides being shipped and an earlier set,
// both played by the same checker, and writes nothing outside
// docs/assets/charts:
//   starts.svg   hours to 60 and hours of grinding, per start, as the
//                checker plays the written guides (feel.written)
//
//   node tools/polestar.js readme charts --check <dir|file> --base <dir|file> [--label <text>] [--base-label <text>]
//
// A level-by-level chart is not drawn: check.json holds each start's totals,
// not its hours to each level.

const fs = require('node:fs');
const path = require('node:path');
const { Outliner } = require('./outline');
const { C: BRAND } = require('./brand');
const { header } = require('../lib/generated');
const { CHARTS, exportPngs } = require('./png');

const { ROOT } = require('../lib/paths');
const OUT = path.join(ROOT, 'docs', 'assets', 'charts');

const C = {
	...BRAND,
	hair: 'rgba(255,255,255,0.1)',
	grid: 'rgba(255,255,255,0.06)',
	guides: BRAND.accent,
	base: '#7d84a0',
};
const f1 = (v) => (Math.round(v * 10) / 10).toFixed(1);
const f2 = (v) => String(Math.round(v * 100) / 100);

// The starts in the order the README lists them, by faction.
const FACTIONS = [
	{ faction: 'Horde', starts: ['Orc', 'Troll', 'Tauren', 'Undead', 'Skyborne-horde'] },
	{ faction: 'Alliance', starts: ['Human', 'Dwarf', 'Gnome', 'NightElf', 'Skyborne-alliance'] },
];
const raceName = (start) => ({ 'Skyborne-horde': 'Skyborne', 'Skyborne-alliance': 'Skyborne', NightElf: 'Night Elf' })[start] || start;

// check.json (a file, or the folder `forge judge check --out` wrote) ->
// { start: { hours, grind } } from each start's written walk.
function readCheck(spec) {
	const file = fs.existsSync(spec) && fs.statSync(spec).isDirectory() ? path.join(spec, 'check.json') : spec;
	const json = JSON.parse(fs.readFileSync(file, 'utf8'));
	const out = {};
	for (const s of json.starts || []) {
		const w = s.feel && s.feel.written;
		if (w) out[s.start] = { hours: w.hours, grind: w.grindMin / 60 };
	}
	return out;
}

// -> { label, baseLabel, factions: [{ faction, starts: [{ start, guides, base }] }] }
function load(o) {
	const cur = readCheck(path.resolve(o.check));
	const old = readCheck(path.resolve(o.base));
	const factions = FACTIONS.map(({ faction, starts }) => ({
		faction,
		starts: starts.map((start) => {
			if (!cur[start] || !old[start]) throw new Error(`${start}: missing from ${cur[start] ? o.base : o.check} (no feel.written)`);
			return { start, guides: cur[start], base: old[start] };
		}),
	}));
	return { label: o.label || 'These guides', baseLabel: o['base-label'] || 'Earlier guides', factions };
}

// A card in Polestar's world: the window ground under a starlit band, the
// title and subtitle at 32/32, a hairline where the content begins.
function card(o, { W, Hh, title, subtitle, body, legend = '' }) {
	// Outline the header first: defs() lists only the glyphs placed so far.
	const head = [
		o.text(title, { font: 'semibold', size: 24, x: 32, y: 52, fill: C.text }),
		o.text(subtitle, { font: 'regular', size: 15, x: 32, y: 80, fill: C.textDim }),
	].join('\n');
	return `<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${Hh}" viewBox="0 0 ${W} ${Hh}" role="img" aria-label="${title}">
<title>${title}</title>
<defs>
<linearGradient id="sky" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${C.sky}"/><stop offset="1" stop-color="${C.sky}" stop-opacity="0"/></linearGradient>
${o.defs()}
</defs>
<rect width="${W}" height="${Hh}" fill="${C.bg}"/>
<rect width="${W}" height="104" fill="url(#sky)"/>
${head}
${legend}
<rect y="104" width="${W}" height="1" fill="${C.hair}"/>
${body}
</svg>
`;
}

// Legend entries right-aligned in the band: [{ label, color }], as dots.
function legend(o, entries, W) {
	let x = W - 32;
	const out = [];
	for (const e of [...entries].reverse()) {
		const w = o.width(e.label, { font: 'medium', size: 14 });
		x -= w;
		out.push(o.text(e.label, { font: 'medium', size: 14, x, y: 57, fill: C.textDim }));
		x -= 10;
		out.push(`<circle cx="${f2(x - 5)}" cy="52" r="4.5" fill="${e.color}"/>`);
		x -= 10 + 24;
	}
	return out.join('\n');
}

function startsChart(o, data) {
	const W = 1200;
	const top = 168, row = 34, groupGap = 44;
	const labelX = 32, aX = 220, aW = 520, bX = 840, bW = 300;
	const all = data.factions.flatMap((f) => f.starts);
	const hrs = all.flatMap((s) => [s.guides.hours, s.base.hours]);
	const lo = Math.floor((Math.min(...hrs) - 1) / 5) * 5, hi = Math.ceil((Math.max(...hrs) + 1) / 5) * 5;
	const gMax = Math.ceil(Math.max(...all.flatMap((s) => [s.guides.grind, s.base.grind])) / 10) * 10;
	const XA = (h) => aX + ((h - lo) / (hi - lo)) * aW;
	const XB = (h) => bX + (h / gMax) * bW;
	const body = [];
	const rows = all.length, Hh = top + rows * row + groupGap + 48;
	body.push(o.text('Hours to 60', { font: 'semibold', size: 17, x: aX, y: top - 38, fill: C.text }));
	body.push(o.text('Hours of grinding', { font: 'semibold', size: 17, x: bX, y: top - 38, fill: C.text }));
	const bottom = top + rows * row + groupGap - 8;
	for (let h = lo; h <= hi; h += 5) {
		body.push(`<rect x="${f2(XA(h))}" y="${top - 16}" width="1" height="${bottom - top + 16}" fill="${C.grid}"/>`);
		body.push(o.text(String(h), { font: 'medium', size: 13, x: XA(h), y: bottom + 22, anchor: 'middle', fill: C.textMuted }));
	}
	for (let h = 0; h <= gMax; h += 10) {
		body.push(`<rect x="${f2(XB(h))}" y="${top - 16}" width="1" height="${bottom - top + 16}" fill="${C.grid}"/>`);
		body.push(o.text(String(h), { font: 'medium', size: 13, x: XB(h), y: bottom + 22, anchor: 'middle', fill: C.textMuted }));
	}
	let y = top;
	data.factions.forEach((f, fi) => {
		if (fi) y += groupGap;
		body.push(o.text(f.faction.toUpperCase(), { font: 'semibold', size: 12, tracking: 0.08, x: labelX, y: y - 6, fill: C.textMuted }));
		for (const s of f.starts) {
			const cy = y + row / 2 + 4;
			body.push(`<rect x="${labelX}" y="${y + row}" width="${W - 64}" height="1" fill="${C.grid}"/>`);
			body.push(o.text(raceName(s.start), { font: 'medium', size: 15, x: labelX, y: cy + 5, fill: C.text }));
			const g = s.guides.hours, p = s.base.hours;
			body.push(`<line x1="${f2(XA(g))}" y1="${cy}" x2="${f2(XA(p))}" y2="${cy}" stroke="${C.base}" stroke-opacity="0.5" stroke-width="2"/>`);
			body.push(`<circle cx="${f2(XA(p))}" cy="${cy}" r="5" fill="${C.base}"/>`);
			body.push(`<circle cx="${f2(XA(g))}" cy="${cy}" r="6" fill="${C.guides}"/>`);
			// The labels sit outside the pair, so they never overlap the dots.
			const [gx, px] = g <= p ? [XA(g) - 14, XA(p) + 14] : [XA(g) + 14, XA(p) - 14];
			body.push(o.text(f1(g), { font: 'semibold', size: 13, x: gx, y: cy + 4.5, anchor: g <= p ? 'end' : 'start', fill: C.guides }));
			body.push(o.text(f1(p), { font: 'medium', size: 13, x: px, y: cy + 4.5, anchor: g <= p ? 'start' : 'end', fill: C.textMuted }));
			const gg = s.guides.grind, pg = s.base.grind;
			body.push(`<rect x="${bX}" y="${cy - 9}" width="${f2(XB(pg) - bX)}" height="7" fill="${C.base}"/>`);
			body.push(`<rect x="${bX}" y="${cy + 1}" width="${f2(XB(gg) - bX)}" height="7" fill="${C.guides}"/>`);
			body.push(o.text(f1(pg), { font: 'medium', size: 12, x: XB(pg) + 8, y: cy - 1.5, fill: C.textMuted }));
			body.push(o.text(f1(gg), { font: 'semibold', size: 12, x: XB(gg) + 8, y: cy + 8.5, fill: C.guides }));
			y += row;
		}
	});
	return card(o, {
		W, Hh,
		title: 'Per start: hours to 60 and grinding',
		subtitle: 'Route checker estimates in /played hours, solo, for what the guides require',
		legend: legend(o, [{ label: data.label, color: C.guides }, { label: data.baseLabel, color: C.base }], W),
		body: body.join('\n'),
	});
}

function write(o) {
	const data = load(o);
	fs.mkdirSync(OUT, { recursive: true });
	const text = startsChart(new Outliner('s'), data);
	const source = `two route checks (forge judge check, check.json): ${data.label} against ${data.baseLabel}`;
	fs.writeFileSync(path.join(OUT, 'starts.svg'), `${header('svg', 'readme charts', source)}\n${text}`);
	console.log(`docs/assets/charts/starts.svg (${(Buffer.byteLength(text) / 1024).toFixed(1)} KB)`);
	exportPngs(CHARTS);
	for (const f of data.factions) {
		for (const s of f.starts) {
			console.log(`${f.faction.padEnd(8)} ${s.start.padEnd(17)} ${data.label} ${f1(s.guides.hours)} h (${f1(s.guides.grind)})  ${data.baseLabel} ${f1(s.base.hours)} h (${f1(s.base.grind)})`);
		}
	}
}

module.exports = { load, startsChart, write };
