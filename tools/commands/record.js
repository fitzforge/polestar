'use strict';
// `record`: Polestar Recorder sessions -> data/recordings -> draft guides.

const fs = require('node:fs');
const path = require('node:path');
const {
	DEFAULT_OUT,
	defaultWtfDirs,
	findSavedVariables,
	importFile,
	safeName,
} = require('../lib/recording/import');
const { watchSavedVariables } = require('../lib/recording/watch');
const { draftGuide } = require('../lib/recording/draft');
const { buildReport, formatReport } = require('../lib/recording/report');
const { resolvePack } = require('../lib/pack/locate');
const { printDiagnostics } = require('../lib/cli');

const usage = `usage: node tools/polestar.js record <subcommand> [options]

  import                 Archive and convert the recorder's SavedVariables:
                         raw copy -> data/recordings/raw/<timestamp>-<account>.lua,
                         one JSON per session -> data/recordings/<session>.json
                         (a session already on disk keeps the longer event list);
                         --anonymize for a file a player sent in: no name or
                         realm (a hash keys the character), no raw copy
  watch                  Import again whenever the client rewrites the file
                         (keeps sessions safe from the cold-start SavedVariables reset)
  draft <session|file>   Write a draft guide from a session key or JSON file
                         to <pack>/drafts/<faction>-<race>-<date>-<time>.guide: the
                         pack is --pack, else the nearest pack.json, else our
                         guides/; another pack's draft id starts with "<pack id>/"
  list                   List imported sessions
  report                 Measure the guides from recorded play (Polestar + Recorder):
                         per step passes, median/p75 time, XP, XP/hr, combat share,
                         deaths, turn-ins, travel; per guide time, levels, XP/hr;
                         the slowest steps, steps far over the guide's median step
                         time, and detours (far travel for little XP)

options:
  --sv <file>            SavedVariables file to use (repeatable); skips auto-detection
  --wtf <dir>            WTF folder to search (default: the detected Forever client's,
                         e.g. <Wine prefix>/drive_c/Program Files (x86)/World of Warcraft/_forever_/WTF;
                         POLESTAR_WTF overrides)
  --out <dir|file>       import/watch/list: recordings folder (default data/recordings);
                         draft: output .guide file or folder (default <pack>/drafts)
  --pack <dir>           draft: the pack the draft belongs to
  --recordings <dir>     draft/report: where sessions are read (default data/recordings)
  --interval <ms>        watch: polling interval (default 1000)
  --force                draft: overwrite an existing draft
  --anonymize            import: drop character names and realms (see import)
  --guide <text>         report: only guides whose id or title contains <text>
  --top <n>              report: length of the ranked lists (default 10)
  --json                 report: print the report as JSON`;

function parse(argv) {
	const opts = { sv: [], wtf: null, out: null, recordings: null, interval: 1000, force: false, anonymize: false, guide: null, top: 10, json: false, positional: [] };
	for (let i = 0; i < argv.length; i++) {
		const a = argv[i];
		const value = () => {
			if (i + 1 >= argv.length) throw new Error(`${a} needs a value`);
			return argv[++i];
		};
		if (a === '--sv') opts.sv.push(value());
		else if (a === '--wtf') opts.wtf = value();
		else if (a === '--out') opts.out = value();
		else if (a === '--recordings') opts.recordings = value();
		else if (a === '--interval') opts.interval = Number(value());
		else if (a === '--force') opts.force = true;
		else if (a === '--anonymize') opts.anonymize = true;
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

function svFiles(opts) {
	const files = findSavedVariables({ sv: opts.sv, wtf: opts.wtf });
	if (!files.length) {
		const searched = opts.wtf ? [opts.wtf] : defaultWtfDirs();
		console.error(`no Polestar_Recorder SavedVariables found; searched:\n${searched.map((d) => `  ${d}/Account/*/SavedVariables/`).join('\n')}\nUse --sv <file> or --wtf <dir>.`);
	}
	return files;
}

function rel(p) {
	const r = path.relative(process.cwd(), p);
	return r && !r.startsWith('..') ? r : p;
}

function report(result, missing = []) {
	const by = { new: 0, updated: 0, unchanged: 0 };
	for (const s of result.sessions) by[s.status]++;
	console.log(
		`${result.account}: ${result.sessions.length} session(s) — ${by.new} new, ${by.updated} updated, ${by.unchanged} unchanged; raw ${result.archive.path === null ? 'not kept (anonymized)' : `${result.archive.created ? 'archived to' : 'unchanged at'} ${rel(result.archive.path)}`}`,
	);
	for (const s of result.sessions) if (s.status !== 'unchanged') console.log(`  ${s.status.padEnd(7)} ${rel(s.file)} (${s.session.events.length} events)`);
	if (missing.length) {
		console.warn(
			`  warning: ${missing.length} session(s) vanished from the SavedVariables file (cold-start reset?); their JSON is kept: ${missing.join(', ')}`,
		);
	}
}

function doImport(opts) {
	const files = svFiles(opts);
	if (!files.length) return 1;
	const outDir = path.resolve(opts.out || DEFAULT_OUT);
	for (const file of files) report(importFile(file, { outDir, anonymize: opts.anonymize }));
	return 0;
}

function doWatch(opts) {
	const files = svFiles(opts);
	if (!files.length) return 1;
	const outDir = path.resolve(opts.out || DEFAULT_OUT);
	console.log(`watching ${files.map(rel).join(', ')} (Ctrl+C to stop)`);
	const watcher = watchSavedVariables(files, {
		outDir,
		interval: opts.interval,
		onImport: report,
		onError: (err, file) => console.error(`import of ${rel(file)} failed: ${err.message}`),
	});
	return new Promise((resolve) => {
		const stop = () => {
			watcher.close();
			resolve(0);
		};
		process.once('SIGINT', stop);
		process.once('SIGTERM', stop);
	});
}

function resolveSession(arg, opts) {
	if (fs.existsSync(arg) && fs.statSync(arg).isFile()) return path.resolve(arg);
	const dir = path.resolve(opts.recordings || DEFAULT_OUT);
	const file = path.join(dir, `${safeName(arg.replace(/\.json$/, ''))}.json`);
	if (fs.existsSync(file)) return file;
	throw new Error(`no session "${arg}" (looked for ${rel(file)}); run "record list"`);
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
	const dir = path.resolve(opts.out || DEFAULT_OUT);
	const files = fs.existsSync(dir) ? fs.readdirSync(dir).filter((f) => f.endsWith('.json')).sort() : [];
	if (!files.length) {
		console.log(`no sessions in ${rel(dir)}; run "record import"`);
		return 0;
	}
	for (const f of files) {
		const s = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
		const c = s.char || {};
		const when = typeof s.started === 'number' ? new Date(s.started * 1000).toISOString().replace('T', ' ').slice(0, 16) : '?';
		const minutes = typeof s.started === 'number' && typeof s.ended === 'number' ? Math.round((s.ended - s.started) / 60) : '?';
		console.log(`${s.session.padEnd(28)} ${when} UTC  ${String(minutes).padStart(4)} min  ${String(s.events.length).padStart(6)} events  ${c.name || '?'} ${c.race || ''} ${c.class || ''} ${c.faction || ''}`);
	}
	return 0;
}

function readSessions(dir) {
	if (!fs.existsSync(dir)) return [];
	const out = [];
	for (const f of fs.readdirSync(dir).filter((x) => x.endsWith('.json')).sort()) {
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
		console.error(`no sessions in ${rel(dir)}; run "record import"`);
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
	summary: 'Polestar Recorder sessions: import, watch, draft guides, measure routes (report)',
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
					return doImport(opts);
				case 'watch':
					return await doWatch(opts);
				case 'draft':
					return doDraft(opts);
				case 'list':
					return doList(opts);
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
