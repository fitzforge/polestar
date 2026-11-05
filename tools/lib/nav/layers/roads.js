'use strict';
// The roads layer's files for the planner (tools/planner/server.js): per grid column, how much of the
// ground the client paints with a road texture. `forge nav layers roads` builds them (docs/forge/nav.md):
// one file per ADT tile, data/local/nav-layers/roads/<c>/<col>_<row>.bin, 65536 bytes, the weight 0-255
// of column (i, j) at j * 256 + i (the grid's column order); a column is road from 128.
//
//   roadWeights(c, col, row, dir?) -> Uint8Array(65536) | null (tile not built)
//   roadsPng(weights) -> PNG Buffer (the planner's Roads layer)

const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('../../paths');

const ROADS_DIR = path.join(ROOT, 'data', 'local', 'nav-layers', 'roads');
const COLUMNS = 65536;
const ROAD = 128;

const tileFile = (dir, c, col, row) => path.join(dir, String(c), `${col}_${row}.bin`);

function roadWeights(c, col, row, dir = ROADS_DIR) {
	const file = tileFile(dir, c, col, row);
	if (!fs.existsSync(file)) return null;
	const b = fs.readFileSync(file);
	if (b.length !== COLUMNS) throw new Error(`${file}: ${b.length} bytes, not ${COLUMNS}`);
	return new Uint8Array(b.buffer, b.byteOffset, b.length);
}

// Road weights -> a 256 x 256 RGBA PNG: the page's success green
// (docs/DESIGN.md), strong on road columns (>= 128), faint below.
function roadsPng(w) {
	const { encodePng } = require('../../planner/art/png');
	const px = new Uint8Array(COLUMNS * 4);
	for (let k = 0; k < COLUMNS; k++) {
		if (!w[k]) continue;
		px[k * 4] = 0x6b;
		px[k * 4 + 1] = 0xd9;
		px[k * 4 + 2] = 0x99;
		px[k * 4 + 3] = w[k] >= ROAD ? 200 : Math.round(w[k] * 0.6);
	}
	return encodePng(px, 256, 256);
}

module.exports = { roadWeights, roadsPng, ROADS_DIR, ROAD };
