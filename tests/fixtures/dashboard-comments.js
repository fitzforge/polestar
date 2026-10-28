'use strict';
// The local dashboard's comment store (data/local/dashboard/lib/comments.js,
// never committed), as much of it as tools/planner/review.js uses: DIR, FITZ,
// add(key, { from, text }) appending a JSON line to DIR/<key>.jsonl.
const fs = require('node:fs');
const path = require('node:path');

const DIR = path.join(__dirname, '..', 'comments');
const FITZ = 'Fitz';

function add(key, { from, text }) {
	const c = { id: String(Date.now()), at: new Date().toISOString(), from, text, status: 'new' };
	fs.mkdirSync(DIR, { recursive: true });
	fs.appendFileSync(path.join(DIR, `${key}.jsonl`), `${JSON.stringify(c)}\n`);
	return c;
}

module.exports = { DIR, FITZ, add };
