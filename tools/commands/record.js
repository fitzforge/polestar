'use strict';
// `record`: data/recordings sessions -> draft guides, trails and the route report.
// The Recorder's files become data/recordings with `forge record import` (this
// PC's game) or `forge record pull` (the recording server): docs/RECORDING.md.

const fs = require('node:fs');
const path = require('node:path');
const { draftGuide } = require('../lib/recording/draft');
const { buildReport, formatReport } = require('../lib/recording/report');
const { trailsOf } = require('../lib/recording/trail');
const { resolvePack } = require('../lib/pack/locate');
const { printDiagnostics } = require('../lib/cli');
const { ROOT } = require('../lib/paths');

const DEFAULT_OUT = path.join(ROOT, 'data', 'recordings');
const IMPORT_HINT = 'run "forge record import" (or "forge record pull")';

const usage = `usage: node tools/polestar.js record <subcommand> [options]

Sessions come from the Polestar Recorder through forge (docs/RECORDING.md):
"forge record import" reads this PC's game, "forge record pull" the recording
server; both write data/recordings/<session>.json.

  draft <session|file>   Write a draft guide from a session key or JSON file
                         to <pack>/drafts/<faction>-<race>-<date>-<time>.guide: the
                         pack is --pack, else the nearest pack.json, else our
                         guides/; another pack's draft id starts with "<pack id>/"
  list                   List the sessions in data/recordings
  trail <session|file>   The session's position trails (/psrec trail) as JSON:
                         [{ label, start, end, reason, points: [{ t, map, x, y,
                         speed, mounted, swimming, falling, indoors, flying }] }],
                         to stdout or --out <file.json>
  report                 Measure the guides from recorded play (Polestar + Recorder):
                         per step passes, median/p75 time, XP, XP/hr, combat share,
                         deaths, turn-ins, travel; per guide time, levels, XP/hr;
                         the slowest steps, steps far over the guide's median step
                         time, and detours (far travel for little XP)

options:
  --out <dir|file>       draft: output .guide file or folder (default <pack>/drafts);
                         trail: output .json file
  --pack <dir>           draft: the pack the draft belongs to
  --recordings <dir>     where sessions are read (default data/recordings)
  --force                draft: overwrite an existing draft
  --guide <text>         report: only guides whose id or title contains <text>
  --top <n>              report: length of the ranked lists (default 10)
  --json                 report: print the report as JSON`;

// A session file's name for a session key (session keys are file names).
function safeName(s) {
	return String(s).replace(/[^\p{L}\p{N}_.-]+/gu, '_').replace(/^\.+/, '_');
}

// Session files of a recordings folder (config.json and dot files are not sessions).
function sessionFiles(dir) {
	return fs.existsSync(dir) ? fs.readdirSync(dir).filter((f) => f.endsWith('.json') && !f.startsWith('.') && f !== 'config.json').sort() : [];
}

function parse(argv) {
	const opts = { out: null, recordings: null, force: false, guide: null, top: 10, json: false, positional: [] };
	for (let i = 0; i < argv.length; i++) {
		const a = argv[i];
		const value = () => {
			if (i + 1 >= argv.length) throw new Error(`${a} needs a value`);
			return argv[++i];
		};
		if (a === '--out') opts.out = value();
		else if (a === '--recordings') opts.recordings = value();
		else if (a === '--force') opts.force = true;
		else if (a === '--pack') opts.pack = value();
		else if (a === '--guide') opts.guide = value();
		else if (a === '--top') {
			opts.top = Number(value());
			if (!Number.isInteger(opts.top) || opts.top < 1) throw new Error('--top needs a positive integer');
		} else if (a === '--json') opts.json = true;
		else if (a.startsWith('--')) throw new Error(`unknown option ${a}`);
		else opts.positional.push(a);
	}
	return opts;
}

function rel(p) {
	const r = path.relative(process.cwd(), p);
	return r && !r.startsWith('..') ? r : p;
}

function resolveSession(arg, opts) {
	if (fs.existsSync(arg) && fs.statSync(arg).isFile()) return path.resolve(arg);
	const dir = path.resolve(opts.recordings || DEFAULT_OUT);
	const file = path.join(dir, `${safeName(arg.replace(/\.json$/, ''))}.json`);
	if (fs.existsSync(file)) return file;
	throw new Error(`no session "${arg}" (looked for ${rel(file)}); run "record list", or ${IMPORT_HINT}`);
}

function doDraft(opts) {
	const [arg] = opts.positional;
	if (!arg) {
		console.error('record draft needs a session key or a recording JSON file');
		return 2;
	}
	const file = resolveSession(arg, opts);
	const session = JSON.parse(fs.readFileSync(file, 'utf8'));
	const pack = resolvePack({ pack: opts.pack });
	if (!pack.manifest) {
		printDiagnostics(pack.diags);
		console.error(`record draft: ${path.join(pack.dir, 'pack.json')} is invalid`);
		return 1;
	}
	const { id, name, text } = draftGuide(session, { pack: pack.manifest.id });
	let out = path.join(pack.dir, 'drafts', `${name}.guide`);
	if (opts.out) out = opts.out.endsWith('.guide') ? path.resolve(opts.out) : path.join(path.resolve(opts.out), `${name}.guide`);
	if (fs.existsSync(out) && !opts.force) {
		console.error(`${rel(out)} exists (an author may have edited it); use --force to overwrite`);
		return 1;
	}
	fs.mkdirSync(path.dirname(out), { recursive: true });
	fs.writeFileSync(out, text);
	const steps = text.split('\n').filter((l) => /^step\b/.test(l)).length;
	console.log(`wrote ${rel(out)} (${id}, ${steps} steps)`);
	return 0;
}

function doList(opts) {
	const dir = path.resolve(opts.recordings || DEFAULT_OUT);
	const files = sessionFiles(dir);
	if (!files.length) {
		console.log(`no sessions in ${rel(dir)}; ${IMPORT_HINT}`);
		return 0;
	}
	for (const f of files) {
		const s = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
		const c = s.char || {};
		const when = typeof s.started === 'number' ? new Date(s.started * 1000).toISOString().replace('T', ' ').slice(0, 16) : '?';
		const minutes = typeof s.started === 'number' && typeof s.ended === 'number' ? Math.round((s.ended - s.started) / 60) : '?';
		const who = c.id || s.charId || c.name || '?';
		console.log(`${s.session.padEnd(28)} ${when} UTC  ${String(minutes).padStart(4)} min  ${String(s.events.length).padStart(6)} events  ${who} ${c.race || ''} ${c.class || ''} ${c.faction || ''}`);
	}
	return 0;
}

function doTrail(opts) {
	const [arg] = opts.positional;
	if (!arg) {
		console.error('record trail needs a session key or a recording JSON file');
		return 2;
	}
	const session = JSON.parse(fs.readFileSync(resolveSession(arg, opts), 'utf8'));
	const trails = trailsOf(session);
	const text = `${JSON.stringify(trails, null, '\t')}\n`;
	if (!opts.out) {
		process.stdout.write(text);
		return 0;
	}
	const out = path.resolve(opts.out);
	fs.mkdirSync(path.dirname(out), { recursive: true });
	fs.writeFileSync(out, text);
	const points = trails.reduce((n, t) => n + t.points.length, 0);
	console.log(`wrote ${rel(out)} (${trails.length} trail(s), ${points} points)`);
	return 0;
}

function readSessions(dir) {
	if (!fs.existsSync(dir)) return [];
	const out = [];
	for (const f of sessionFiles(dir)) {
		let s;
		try {
			s = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
		} catch (err) {
			throw new Error(`${rel(path.join(dir, f))}: ${err.message}`);
		}
		if (s && Array.isArray(s.events)) out.push(s);
	}
	return out;
}

function doReport(opts) {
	const dir = path.resolve(opts.recordings || DEFAULT_OUT);
	const sessions = readSessions(dir);
	if (!sessions.length) {
		console.error(`no sessions in ${rel(dir)}; ${IMPORT_HINT}`);
		return 1;
	}
	const report = buildReport(sessions, { guide: opts.guide, top: opts.top });
	if (opts.json) console.log(JSON.stringify(report, null, '\t'));
	else process.stdout.write(formatReport(report));
	if (opts.guide && !report.guides.length) {
		console.error(`no recorded guide matches "${opts.guide}"`);
		return 1;
	}
	return 0;
}

module.exports = {
	name: 'record',
	summary: 'Recorded sessions (forge record import|pull): draft guides, trails, measure routes (report)',
	usage,
	async run(argv) {
		const [sub, ...rest] = argv;
		let opts;
		try {
			opts = parse(rest);
		} catch (err) {
			console.error(`${err.message}\n\n${usage}`);
			return 2;
		}
		try {
			switch (sub) {
				case 'import':
				case 'watch':
					console.error(`record ${sub} moved to forge: ${IMPORT_HINT} (docs/RECORDING.md)`);
					return 2;
				case 'draft':
					return doDraft(opts);
				case 'list':
					return doList(opts);
				case 'trail':
					return doTrail(opts);
				case 'report':
					return doReport(opts);
				default:
					console.error(sub ? `unknown subcommand "${sub}"\n\n${usage}` : usage);
					return 2;
			}
		} catch (err) {
			console.error(err.message);
			return 1;
		}
	},
};
