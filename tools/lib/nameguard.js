'use strict';
// The name guard: tracked files must not name the web quest databases the
// project no longer cites (a web quest database, its quest-chain mirror and a
// talents site's quest cache), except the files listed in
// data/nameguard-allow.json with why. The names are built from parts
// here, so this file does not name them itself.
//
//   names()                       -> the guarded names, lower case
//   pattern()                     -> a case-insensitive extended regex for git grep
//   mentions(cwd)                 -> tracked text files that name one (git grep), sorted
//   checkMentions(found, allow)   -> { unexpected: files not allowed, stale: allowed files that no longer name one }
//   loadAllow(file?)              -> { [path]: kind }
//
// The allowlist only shrinks. Its original excluded entries (BASELINE: the
// first 16 hex digits of each path's SHA-256) may keep their kind as the
// string "excluded". Any other entry must be
// { "kind": "excluded", "reason": "<why>" }, and is added only when the
// maintainers agree in review.

const fs = require('node:fs');
const path = require('node:path');
const { execFileSync } = require('node:child_process');

const ALLOW = path.join(__dirname, '..', '..', 'data', 'nameguard-allow.json');
const crypto = require('node:crypto');
const KINDS = new Set(['excluded']);
const pathKey = (f) => crypto.createHash('sha256').update(f).digest('hex').slice(0, 16);

const BASELINE = {
	excluded: new Set([
	'24f760f284f7aff3',
	'2a509b722cbd9700',
	'3cd8a9846b693e61',
	'615d27be8cfbea99',
	'6cd765a9d05b7029',
	'817599e36010c225',
	'880ebdec3382573f',
	'a0a4f3aa5e196ac5',
	'a6b8bc32627de735',
	'a8ceb9273adad7aa',
	'b3482da48d457eda',
	'b39f1d47a06821cc',
	'b70104f90ea38882',
	'beddac776885b6fe',
	'c7ce2df9a41557f6',
	'c952409b82bd1105',
	'e59ea7d2c25fa26c',
	'e90bf3e495a3b224',
	'eba283c7379a1755',
	'fba0df8a41e3544a',
	]),
};

function names() {
	return [['wow', 'head'], ['forever', 'changes'], ['wowforever', 'talents']].map((p) => p.join(''));
}

function pattern() {
	return names().join('|');
}

function mentions(cwd) {
	let out;
	try {
		out = execFileSync('git', ['grep', '-l', '-I', '-i', '-E', pattern()], { cwd, encoding: 'utf8', maxBuffer: 64 << 20 });
	} catch (err) {
		// git grep exits 1 when nothing matches.
		if (err.status === 1) return [];
		throw err;
	}
	return out.split('\n').filter(Boolean).sort();
}

function loadAllow(file = ALLOW) {
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	const name = path.basename(file);
	const out = {};
	for (const [f, v] of Object.entries(doc.files || {})) {
		const key = pathKey(f);
		if (typeof v === 'string') {
			if (!KINDS.has(v)) throw new Error(`${name}: ${f}: kind "${v}" is none of ${[...KINDS].join(', ')}`);
			if (!BASELINE[v].has(key)) {
				throw new Error(`${name}: ${f}: "${v}" is not one of the guard's original entries; the allowlist only shrinks (a new entry must be { "kind": "excluded", "reason": "..." }, agreed by the maintainers in review)`);
			}
			out[f] = v;
			continue;
		}
		if (!v || v.kind !== 'excluded' || typeof v.reason !== 'string' || !v.reason.trim()) {
			throw new Error(`${name}: ${f}: a new entry must be { "kind": "excluded", "reason": "..." }`);
		}
		out[f] = 'excluded';
	}
	return out;
}

function checkMentions(found, allow) {
	const seen = new Set(found);
	return {
		unexpected: found.filter((f) => !Object.hasOwn(allow, f)),
		stale: Object.keys(allow).filter((f) => !seen.has(f)).sort(),
	};
}

module.exports = { names, pattern, mentions, loadAllow, checkMentions, pathKey, ALLOW };
