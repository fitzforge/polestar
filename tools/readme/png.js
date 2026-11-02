'use strict';
// PNG copies of the README's art for pages that do not show SVG reliably
// (the CurseForge listing, docs/curseforge): each SVG rendered by
// rsvg-convert (librsvg) at a set width. The SVGs hold their text as
// outlines, so the renders need no fonts. Without rsvg-convert nothing is
// written and the commands to run are printed instead.

const path = require('node:path');
const { spawnSync } = require('node:child_process');

const { ROOT } = require('../lib/paths');
const DIR = 'docs/curseforge/images';

// [svg, png, width] per file, paths from the repository root; the height
// follows the SVG's aspect ratio. The banner is the dark one, its edges
// dissolving into the page: CurseForge's pages are dark.
const BRAND = [
	['docs/assets/avatar.svg', `${DIR}/logo-1024.png`, 1024],
	['docs/assets/avatar.svg', `${DIR}/logo-400.png`, 400],
	['docs/assets/banner-dark.svg', `${DIR}/banner.png`, 2560],
];
const CHARTS = [
	['docs/assets/charts/starts.svg', `${DIR}/starts.png`, 2400],
];

const args = (svg, png, width) => ['-w', String(width), '-o', png, svg];

function hasRsvg() {
	const r = spawnSync('rsvg-convert', ['--version'], { encoding: 'utf8' });
	return !r.error && r.status === 0;
}

function exportPngs(jobs) {
	if (!hasRsvg()) {
		console.log(`rsvg-convert (librsvg) not found: no PNGs written. To write them, run from the repository root:\n  mkdir -p ${DIR}`);
		for (const [svg, png, width] of jobs) console.log(`  rsvg-convert ${args(svg, png, width).join(' ')}`);
		return;
	}
	require('node:fs').mkdirSync(path.join(ROOT, DIR), { recursive: true });
	for (const [svg, png, width] of jobs) {
		const r = spawnSync('rsvg-convert', args(svg, png, width), { cwd: ROOT, encoding: 'utf8' });
		if (r.status !== 0) throw new Error(`rsvg-convert ${svg}: ${r.stderr.trim()}`);
		console.log(`${png} (${width} wide)`);
	}
}

module.exports = { BRAND, CHARTS, exportPngs };
