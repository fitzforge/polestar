'use strict';
// The README's route charts, from the simulator. Scores Polestar's guides
// in-process under the simulator's model (tools/lib/sim/compare.js, the same
// scoring as `sim compare`) and writes nothing outside docs/assets/charts:
//   levels.svg   hours to each level, per faction: the guides and an earlier
//                set of them, a release (and the best route found when the sim results match)
//   starts.svg   hours to 60 and hours of grinding, per start
//
// The best route found and the consensus route are drawn only when the
// results and consensus in --sim were searched on the world being scored
// (compare() refuses stale results; consensus is checked here), so every
// number in a chart comes from one world.
//
//   node tools/polestar.js readme charts --draft <dir|git rev> [--draft-label <text>] [--sim <dir>] [--guides <dir>]
//
// o.draft is the earlier guides to compare against: a guides folder, or a git
// revision whose guides/ is extracted to a temporary folder (the README uses
// the first release, v0.1.0); o['draft-label'] names them in the charts.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { execFileSync } = require('node:child_process');
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
	draft: '#7d84a0',
	best: '#f7f8fd',
	consensus: '#94c9ff',
};
const f1 = (v) => (Math.round(v * 10) / 10).toFixed(1);
const f2 = (v) => String(Math.round(v * 100) / 100);
const H = 3600;

function draftGuides(spec) {
	if (fs.existsSync(spec) && fs.statSync(spec).isDirectory()) return { dir: path.resolve(spec), label: spec, cleanup() {} };
	const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-guides-'));
	const tar = execFileSync('git', ['archive', spec, 'guides'], { cwd: ROOT, maxBuffer: 1 << 30 });
	execFileSync('tar', ['-x', '-C', tmp], { input: tar });
	const rev = execFileSync('git', ['rev-parse', '--short', spec], { cwd: ROOT, encoding: 'utf8' }).trim();
	return { dir: path.join(tmp, 'guides'), label: rev, cleanup: () => fs.rmSync(tmp, { recursive: true, force: true }) };
}

// -> { worldHash, factions: [{ faction, starts: [{ race, best?, consensus?, guides, draft }] }] }
// Each series: { timeTo: { level: seconds }, seconds, grind }.
async function score(o) {
	const sim = require('../lib/sim');
	const { compare } = require('../lib/sim/compare');
	const { dataHash, worldFile } = require('../lib/sim/world');
	const simDir = path.resolve(o.sim || path.join(ROOT, 'data', 'sim'));
	const base = { ...sim.DEFAULTS, simDir, offline: true, quiet: true };
	const hash = dataHash(base.dataDir, base.sourcesDir);
	for (const faction of ['Horde', 'Alliance']) {
		// Never let scoring rebuild (and write) a world: refuse a stale one.
		const file = worldFile(simDir, faction);
		const w = fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null;
		if (!w || w.dataHash !== hash) throw new Error(`${path.relative(ROOT, file)} is not built on the current data (${hash.slice(0, 12)}): run \`forge walks world . data/local/nav4 data/sim <faction>\` first`);
	}
	const prev = draftGuides(o.draft);
	const series = (row) => row && { timeTo: Object.fromEntries(Object.entries(row.timeTo).map(([l, t]) => [Number(l), t])), seconds: row.seconds, grind: row.grindSeconds };
	const factions = [];
	try {
		for (const faction of ['Horde', 'Alliance']) {
			const cur = await compare({ ...base, faction, guidesDir: o.guides ? path.resolve(o.guides) : undefined });
			const old = await compare({ ...base, faction, guidesDir: prev.dir });
			const cfile = path.join(simDir, `consensus-${faction.toLowerCase()}.json`);
			const cons = fs.existsSync(cfile) ? JSON.parse(fs.readFileSync(cfile, 'utf8')) : null;
			const consOk = cons && cons.worldHash === hash;
			const starts = cur.map((c) => {
				const p = old.find((x) => x.race === c.race);
				const row = (r, id) => r && r.rows.find((x) => x.id === id);
				const cr = consOk && cons.races.find((x) => x.race === c.race);
				return {
					race: c.race,
					best: series(row(c, 'best')),
					consensus: cr ? { timeTo: cr.consensusTimeTo, seconds: cr.consensusHours * H } : null,
					guides: series(row(c, 'polestar')),
					draft: series(row(p, 'polestar')),
				};
			});
			for (const s of starts) if (!s.guides || !s.draft) throw new Error(`${faction} ${s.race}: the guides did not score`);
			factions.push({ faction, starts });
		}
	} finally {
		prev.cleanup();
	}
	const tag = /^v(\d+\.\d+\.\d+)$/.exec(o.draft || '');
	const draftName = o['draft-label'] || (tag ? `Polestar ${tag[1]}` : 'Earlier guides');
	return { worldHash: hash, draft: prev.label, draftName, factions };
}

const raceName = (r, faction) => (r === 'Skyborne' ? `Skyborne (${faction})` : r === 'NightElf' ? 'Night Elf' : r);

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

// Legend entries right-aligned in the band: [{ label, color, kind }].
function legend(o, entries, W) {
	let x = W - 32;
	const out = [];
	for (const e of [...entries].reverse()) {
		const w = o.width(e.label, { font: 'medium', size: 14 });
		x -= w;
		out.push(o.text(e.label, { font: 'medium', size: 14, x, y: 57, fill: C.textDim }));
		x -= 10;
		if (e.kind === 'dot') out.push(`<circle cx="${f2(x - 5)}" cy="52" r="4.5" fill="${e.color}"/>`);
		else out.push(`<line x1="${x - 20}" y1="52" x2="${x}" y2="52" stroke="${e.color}" stroke-width="${e.width || 2.5}"${e.dash ? ` stroke-dasharray="${e.dash}"` : ''}/>`);
		x -= e.kind === 'dot' ? 10 : 20;
		x -= 24;
	}
	return out.join('\n');
}

function levelsChart(o, data) {
	const W = 1200, Hh = 700;
	const panelW = 496, top = 150, plotH = 300;
	const stripTop = top + plotH + 112, stripH = 72;
	const maxH = Math.ceil(Math.max(...data.factions.flatMap((f) => f.starts.map((s) => s.draft.seconds / H))) / 20) * 20;
	const body = [];
	const has = (k) => data.factions.every((f) => f.starts.every((s) => s[k]));
	const meanAt = (f, key, l) => {
		const ts = f.starts.map((s) => s[key].timeTo[l]).filter((t) => t != null);
		return ts.length === f.starts.length ? ts.reduce((a, b) => a + b, 0) / ts.length / H : null;
	};
	// Hours the guides are ahead of the earlier draft at each level.
	const ahead = data.factions.map((f) => {
		const out = [];
		for (let l = 2; l <= 60; l++) {
			const p = meanAt(f, 'draft', l), g = meanAt(f, 'guides', l);
			if (p != null && g != null) out.push([l, p - g]);
		}
		return out;
	});
	const span = Math.ceil(Math.max(...ahead.flat().map(([, d]) => Math.abs(d))) / 2) * 2;
	data.factions.forEach((f, fi) => {
		const x0 = 80 + fi * (panelW + 96);
		const X = (h) => x0 + (h / maxH) * panelW;
		const Y = (l) => top + plotH - ((l - 1) / 59) * plotH;
		body.push(o.text(f.faction, { font: 'semibold', size: 17, x: x0, y: top - 18, fill: C.text }));
		body.push(o.text(`mean of ${f.starts.map((s) => raceName(s.race, f.faction).replace(/ \(.*/, '')).join(', ')}`, { font: 'regular', size: 13, x: x0 + panelW, y: top - 18, anchor: 'end', fill: C.textMuted }));
		for (let l = 10; l <= 60; l += 10) {
			body.push(`<rect x="${x0}" y="${f2(Y(l))}" width="${panelW}" height="1" fill="${C.grid}"/>`);
			body.push(o.text(String(l), { font: 'medium', size: 13, x: x0 - 12, y: Y(l) + 4.5, anchor: 'end', fill: C.textMuted }));
		}
		for (let h = 0; h <= maxH; h += 20) {
			if (h) body.push(`<rect x="${f2(X(h))}" y="${top}" width="1" height="${plotH}" fill="${C.grid}"/>`);
			body.push(o.text(`${h}`, { font: 'medium', size: 13, x: X(h), y: top + plotH + 24, anchor: 'middle', fill: C.textMuted }));
		}
		body.push(`<rect x="${x0}" y="${top + plotH}" width="${panelW}" height="1" fill="${C.hair}"/>`);
		body.push(o.text('hours played', { font: 'regular', size: 13, x: x0 + panelW, y: top + plotH + 48, anchor: 'end', fill: C.textMuted }));
		const curve = (key, color, width, dash) => {
			const pts = [];
			const lo = [], hi = [];
			for (let l = 2; l <= 60; l++) {
				const ts = f.starts.map((s) => s[key].timeTo[l]).filter((t) => t != null);
				if (ts.length !== f.starts.length) continue;
				const mean = ts.reduce((a, b) => a + b, 0) / ts.length;
				pts.push([X(mean / H), Y(l)]);
				lo.push([X(Math.min(...ts) / H), Y(l)]);
				hi.push([X(Math.max(...ts) / H), Y(l)]);
			}
			const p = (a) => a.map(([x, y]) => `${f2(x)},${f2(y)}`).join(' ');
			body.push(`<polygon points="${p(lo)} ${p([...hi].reverse())}" fill="${color}" fill-opacity="0.14"/>`);
			body.push(`<polyline points="${p([[X(0), Y(1)], ...pts])}" fill="none" stroke="${color}" stroke-width="${width}" stroke-linejoin="round"${dash ? ` stroke-dasharray="${dash}"` : ''}/>`);
		};
		curve('draft', C.draft, 2);
		if (has('best')) curve('best', C.best, 1.5, '5 4');
		curve('guides', C.guides, 2.5);
		if (has('consensus')) {
			for (const l of [10, 20, 30, 40, 50, 60]) {
				const mean = f.starts.reduce((a, s) => a + s.consensus.timeTo[l], 0) / f.starts.length;
				body.push(`<circle cx="${f2(X(mean / H))}" cy="${f2(Y(l))}" r="3.5" fill="${C.consensus}"/>`);
			}
		}
		// Hours to 60 across the starts, under the panel title's line.
		const rng = (k) => {
			const v = f.starts.map((s) => s[k].seconds / H);
			const a = f1(Math.min(...v)), b = f1(Math.max(...v));
			return a === b ? `${a} h` : `${a}\u2013${b} h`;
		};
		const notes = [['guides', 'Guides', C.guides], ['draft', data.draftName, C.draft]];
		if (has('best')) notes.splice(1, 0, ['best', 'Best found', C.best]);
		notes.forEach(([k, label, color], i) => {
			const y = top + 196 + i * 24;
			const xr = x0 + panelW - 16;
			body.push(o.text(rng(k), { font: 'semibold', size: 14, x: xr, y, anchor: 'end', fill: color }));
			body.push(o.text(label, { font: 'medium', size: 14, x: xr - 100, y, anchor: 'end', fill: C.textDim }));
		});
		// The strip: hours ahead of the earlier guides, by level.
		const SX = (l) => x0 + ((l - 1) / 59) * panelW;
		const SY = (d) => stripTop + stripH / 2 - (d / span) * (stripH / 2);
		body.push(o.text(`Hours ahead of ${data.draftName}, by level`, { font: 'medium', size: 13, x: x0, y: stripTop - 16, fill: C.textDim }));
		body.push(`<rect x="${x0}" y="${stripTop}" width="${panelW}" height="${stripH}" fill="#000005" fill-opacity="0.18"/>`);
		body.push(`<rect x="${x0}" y="${f2(SY(0))}" width="${panelW}" height="1" fill="${C.hair}"/>`);
		for (const d of [-span, span]) body.push(o.text(`${d > 0 ? '+' : '\u2212'}${Math.abs(d)}`, { font: 'medium', size: 12, x: x0 - 10, y: SY(d) + (d > 0 ? 10 : 0), anchor: 'end', fill: C.textMuted }));
		for (let l = 10; l <= 60; l += 10) body.push(o.text(String(l), { font: 'medium', size: 12, x: SX(l), y: stripTop + stripH + 20, anchor: 'middle', fill: C.textMuted }));
		const pts = ahead[fi].map(([l, d]) => `${f2(SX(l))},${f2(SY(d))}`);
		const area = `${f2(SX(ahead[fi][0][0]))},${f2(SY(0))} ${pts.join(' ')} ${f2(SX(ahead[fi][ahead[fi].length - 1][0]))},${f2(SY(0))}`;
		const id = `ahead${fi}`;
		body.push(`<clipPath id="${id}u"><rect x="${x0}" y="${stripTop}" width="${panelW}" height="${f2(SY(0) - stripTop)}"/></clipPath>`);
		body.push(`<clipPath id="${id}d"><rect x="${x0}" y="${f2(SY(0))}" width="${panelW}" height="${f2(stripTop + stripH - SY(0))}"/></clipPath>`);
		body.push(`<polygon points="${area}" fill="${C.guides}" fill-opacity="0.35" clip-path="url(#${id}u)"/>`);
		body.push(`<polygon points="${area}" fill="${C.draft}" fill-opacity="0.45" clip-path="url(#${id}d)"/>`);
		body.push(`<polyline points="${pts.join(' ')}" fill="none" stroke="${C.guides}" stroke-width="1.5" stroke-linejoin="round"/>`);
	});
	const entries = [{ label: 'Guides', color: C.guides }];
	if (has('best')) entries.push({ label: 'Best found', color: C.best, width: 1.5, dash: '5 4' });
	if (has('consensus')) entries.push({ label: 'Consensus', color: C.consensus, kind: 'dot' });
	entries.push({ label: data.draftName, color: C.draft, width: 2 });
	return card(o, {
		W, Hh,
		title: 'Level by hours played',
		subtitle: `Simulator estimates in /played hours, solo, world ${data.worldHash.slice(0, 8)}; bands span the starts`,
		legend: legend(o, entries, W),
		body: body.join('\n'),
	});
}

function startsChart(o, data) {
	const W = 1200;
	const top = 168, row = 34, groupGap = 44;
	const labelX = 32, aX = 220, aW = 520, bX = 840, bW = 300;
	const all = data.factions.flatMap((f) => f.starts);
	const has = (k) => all.every((s) => s[k]);
	const hrs = all.flatMap((s) => [s.guides, s.draft, s.best, s.consensus].filter(Boolean).map((x) => x.seconds / H));
	const lo = Math.floor((Math.min(...hrs) - 1) / 5) * 5, hi = Math.ceil((Math.max(...hrs) + 1) / 5) * 5;
	const gMax = Math.ceil(Math.max(...all.flatMap((s) => [s.guides.grind, s.draft.grind])) / H / 10) * 10;
	const XA = (h) => aX + ((h - lo) / (hi - lo)) * aW;
	const XB = (h) => bX + (h / gMax) * bW;
	const body = [];
	const rows = 8, Hh = top + rows * row + groupGap + 48;
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
			body.push(o.text(raceName(s.race, f.faction), { font: 'medium', size: 15, x: labelX, y: cy + 5, fill: C.text }));
			const g = s.guides.seconds / H, p = s.draft.seconds / H;
			body.push(`<line x1="${f2(XA(g))}" y1="${cy}" x2="${f2(XA(p))}" y2="${cy}" stroke="${C.draft}" stroke-opacity="0.5" stroke-width="2"/>`);
			body.push(`<circle cx="${f2(XA(p))}" cy="${cy}" r="5" fill="${C.draft}"/>`);
			if (s.best) body.push(`<circle cx="${f2(XA(s.best.seconds / H))}" cy="${cy}" r="5" fill="none" stroke="${C.best}" stroke-width="1.5"/>`);
			if (s.consensus) body.push(`<circle cx="${f2(XA(s.consensus.seconds / H))}" cy="${cy}" r="3" fill="${C.consensus}"/>`);
			body.push(`<circle cx="${f2(XA(g))}" cy="${cy}" r="6" fill="${C.guides}"/>`);
			body.push(o.text(f1(g), { font: 'semibold', size: 13, x: XA(Math.min(g, p)) - 14, y: cy + 4.5, anchor: 'end', fill: C.guides }));
			body.push(o.text(f1(p), { font: 'medium', size: 13, x: XA(Math.max(g, p)) + 14, y: cy + 4.5, fill: C.textMuted }));
			const gg = s.guides.grind / H, pg = s.draft.grind / H;
			body.push(`<rect x="${bX}" y="${cy - 9}" width="${f2(XB(pg) - bX)}" height="7" fill="${C.draft}"/>`);
			body.push(`<rect x="${bX}" y="${cy + 1}" width="${f2(XB(gg) - bX)}" height="7" fill="${C.guides}"/>`);
			body.push(o.text(f1(pg), { font: 'medium', size: 12, x: XB(pg) + 8, y: cy - 1.5, fill: C.textMuted }));
			body.push(o.text(f1(gg), { font: 'semibold', size: 12, x: XB(gg) + 8, y: cy + 8.5, fill: C.guides }));
			y += row;
		}
	});
	const entries = [{ label: 'Guides', color: C.guides, kind: 'dot' }];
	if (has('best')) entries.push({ label: 'Best found', color: C.best, kind: 'dot' });
	if (has('consensus')) entries.push({ label: 'Consensus', color: C.consensus, kind: 'dot' });
	entries.push({ label: data.draftName, color: C.draft, kind: 'dot' });
	return card(o, {
		W, Hh,
		title: 'Per start: hours to 60 and grinding',
		subtitle: `Simulator estimates in /played hours, solo, world ${data.worldHash.slice(0, 8)}`,
		legend: legend(o, entries, W),
		body: body.join('\n'),
	});
}

async function write(o) {
	const data = await score(o);
	fs.mkdirSync(OUT, { recursive: true });
	const files = { 'levels.svg': levelsChart(new Outliner('l'), data), 'starts.svg': startsChart(new Outliner('s'), data) };
	for (const [name, text] of Object.entries(files)) {
		const source = `data/sim and guides/, compared with ${data.draftName} (the options are in tools/README.md)`;
		fs.writeFileSync(path.join(OUT, name), `${header('svg', 'readme charts', source)}\n${text}`);
		console.log(`docs/assets/charts/${name} (${(Buffer.byteLength(text) / 1024).toFixed(1)} KB)`);
	}
	exportPngs(CHARTS);
	for (const f of data.factions) {
		for (const s of f.starts) {
			const h = (x) => (x ? `${f1(x.seconds / H)} h` : '-');
			const g = (x) => (x && x.grind != null ? ` (${f1(x.grind / H)})` : '');
			console.log(`${f.faction.padEnd(8)} ${s.race.padEnd(9)} best ${h(s.best)}  consensus ${h(s.consensus)}  guides ${h(s.guides)}${g(s.guides)}  draft ${h(s.draft)}${g(s.draft)}`);
		}
	}
	console.log(`world ${data.worldHash.slice(0, 12)}, compared with ${data.draftName} (${data.draft})`);
}

module.exports = { score, levelsChart, startsChart, write };
