#!/usr/bin/env node
'use strict';
// Test selection: the test files a change can break, so a loop runs those
// instead of the whole suite. `npm test` (every file) stays the CI gate.
//
//   node tools/testsel.js                 changes vs HEAD: `git diff HEAD` and untracked files
//   node tools/testsel.js --base main     plus everything committed since main (main...HEAD)
//   node tools/testsel.js <path>...       these files instead of git's
//   --run            then run them, one `node --test <file>` process each, several at once while
//                    free memory allows (runFiles); the failing files' output; exit 1 on a failure
//   --jobs N         --run: at most N files at once (default half the cores)
//   --reserve GB     --run: start another file only while more than GB are available (default 6)
//   --json           print the mapping as JSON
//   --all-unmapped   a changed file that selects no test runs the whole suite instead
//
// How a changed file maps to tests/**/*.test.js, first matching rule wins; every
// rule but the first also takes the tests that read the path (the last rule):

const RULES = [
	{ kind: 'test', when: (f) => TEST_RE.test(f), map: 'a test file: itself' },
	{ kind: 'js', when: (f) => /\.c?js$/.test(f), map: 'tests whose require closure (tools/lib/requires.js) holds it; a test running the CLI also holds tools/polestar.js and the commands it names (every command when it names none)' },
	{ kind: 'cli', when: (f) => f === 'package.json', map: 'tests running the CLI' },
	{ kind: 'tooldata', when: (f) => f.startsWith('tools/'), map: 'tools/** not .js (json, lua, templates): tests whose closure holds a .js in its folder naming it (any .js there when none does)' },
	{ kind: 'addon', when: (f) => f.startsWith('addon/'), map: 'addon/<A>/x.lua|xml|toc: runAddon tests loading A whole, x, or a manifest of A that loads x; tests calling a tool that runs the addon' },
	{ kind: 'stub', when: (f) => f.startsWith('tests/lua/'), map: 'tests/lua/x: tests naming x; every runAddon test when helpers/lua.js loads x itself; tests calling a tool that runs the addon with x' },
	{ kind: 'guides', when: (f) => f.startsWith('guides/'), map: 'guides*.test.js' },
	{ kind: 'path', when: () => true, map: "tests reading the path (fixtures, data, docs, …): a path string, path.join over a known root, or a helper's path constant" },
];
// A file that selects no test is listed as unmapped.

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { directRequires, requireClosure } = require('./lib/requires');

const ROOT = path.join(__dirname, '..');
const TESTS = path.join(ROOT, 'tests');
const LOADER = path.join(TESTS, 'helpers', 'lua.js');
const CLI = path.join(ROOT, 'tools', 'polestar.js');
const COMMANDS = path.join(ROOT, 'tools', 'commands');
const TEST_RE = /^tests\/.*\.test\.js$/;

const rel = (abs) => path.relative(ROOT, abs).split(path.sep).join('/');
const abs = (r) => path.join(ROOT, r);
const once = (fn) => {
	let v;
	let done = false;
	return () => (done ? v : ((done = true), (v = fn())));
};
const memo = (fn) => {
	const m = new Map();
	return (k) => {
		if (!m.has(k)) m.set(k, fn(k));
		return m.get(k);
	};
};
const esc = (s) => s.replace(/[$]/g, '\\$');
// lexed code without its require statements, to tell an imported name's uses from its import
const withoutRequires = (code) => code.replace(/\b(?:const|let|var)\s*(?:\{[^}]*\}|[\w$]+)\s*=\s*require\([^)]*\)(?:\.[\w$]+)?/g, '');

function walk(dir, keep, out = []) {
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) walk(p, keep, out);
		else if (keep(e.name)) out.push(p);
	}
	return out;
}

const testFiles = once(() => walk(TESTS, (n) => n.endsWith('.test.js')).sort());
const topLevel = once(() => new Set(fs.readdirSync(ROOT)));
const addonNames = once(() => new Set(fs.readdirSync(path.join(ROOT, 'addon'))));
const commands = once(() => new Map(fs.readdirSync(COMMANDS).filter((f) => f.endsWith('.js')).map((f) => [f.slice(0, -3), path.join(COMMANDS, f)])));
const text = memo((file) => fs.readFileSync(file, 'utf8'));

// ---- reading JavaScript: strings, comments and regexes told apart ----

// code: the source with comments dropped and each string literal replaced by
// \x01<index>\x01; strs[index]: { v: the value (a template's text before its
// first ${}), full: no ${} in it, lead: the identifier of a template that opens with ${ident} }
function lex(src) {
	const strs = [];
	let code = '';
	let i = 0;
	let last = '';
	const n = src.length;
	const put = (s) => {
		code += `\x01${strs.length}\x01`;
		strs.push(s);
		last = 'a';
	};
	const quoted = (q) => {
		let v = '';
		let j = i + 1;
		while (j < n && src[j] !== q && src[j] !== '\n') {
			if (src[j] === '\\') {
				v += src[j + 1];
				j += 2;
			} else v += src[j++];
		}
		i = j + 1;
		return v;
	};
	// a template from its backtick; returns its raw text without the backticks. Its
	// ${} expressions are lexed as code (their strings recorded) and left out of `code`.
	const template = () => {
		const start = ++i;
		while (i < n && src[i] !== '`') {
			if (src[i] === '\\') i += 2;
			else if (src[i] === '$' && src[i + 1] === '{') {
				i += 2;
				const keep = [code, last];
				last = '(';
				scan(true);
				[code, last] = keep;
			} else i++;
		}
		return src.slice(start, i++);
	};
	// code up to the end, or up to and past the '}' that closes a template's ${
	function scan(untilBrace) {
		let depth = 0;
		while (i < n) {
			const c = src[i];
			const d = src[i + 1];
			if (untilBrace && c === '}' && depth-- === 0) {
				i++;
				return;
			}
			if (untilBrace && c === '{') depth++;
			if (c === '/' && d === '/') {
				while (i < n && src[i] !== '\n') i++;
			} else if (c === '/' && d === '*') {
				const e = src.indexOf('*/', i + 2);
				i = e < 0 ? n : e + 2;
				code += ' ';
			} else if (c === '/' && (last === '' || '(,=:[!&|?{};+-*%<>~^'.includes(last) || /\b(return|typeof|case|of|in|void|throw|delete)\s*$/.test(code.slice(-12)))) {
				let j = i + 1;
				let cls = false;
				while (j < n && src[j] !== '\n' && (cls || src[j] !== '/')) {
					if (src[j] === '\\') j++;
					else if (src[j] === '[') cls = true;
					else if (src[j] === ']') cls = false;
					j++;
				}
				j++;
				while (j < n && /[a-z]/.test(src[j])) j++;
				i = j;
				code += '/re/';
				last = 'a';
			} else if (c === "'" || c === '"') {
				put({ v: quoted(c), full: true, lead: null });
			} else if (c === '`') {
				const raw = template();
				const at = raw.indexOf('${');
				const lead = /^\$\{\s*([A-Za-z_$][\w$]*)\s*\}([^$]*)/.exec(raw);
				put({ v: at < 0 ? raw : raw.slice(0, at), full: at < 0, lead: lead ? { id: lead[1], rest: lead[2] } : null });
			} else {
				code += c;
				if (!/\s/.test(c)) last = c;
				i++;
			}
		}
	}
	scan(false);
	return { code, strs };
}

// The comma-separated arguments of the call whose '(' is at code[open].
function callArgs(code, open) {
	const args = [];
	let depth = 0;
	let start = open + 1;
	for (let i = open; i < code.length; i++) {
		const c = code[i];
		if (c === '(' || c === '[' || c === '{') depth++;
		else if (c === ')' || c === ']' || c === '}') {
			if (--depth === 0) {
				args.push(code.slice(start, i).trim());
				return args.filter(Boolean);
			}
		} else if (c === ',' && depth === 1) {
			args.push(code.slice(start, i).trim());
			start = i + 1;
		}
	}
	return args.filter(Boolean);
}

const STR = /^\x01(\d+)\x01$/;
const JOIN = /\bpath\.(?:join|resolve)\s*\(/g;

// path.join/resolve(base, 'a', 'b', …) -> absolute path, as far as it is known:
// the base an identifier with a known path, __dirname, or a string (from the
// repository, where the tests run); later arguments kept up to the first that
// is not a string (a template keeps its text before ${}).
function evalJoin(args, a, dir) {
	if (!args.length) return null;
	let base;
	const s0 = STR.exec(args[0]);
	if (args[0] === '__dirname') base = dir;
	else if (a.env.has(args[0])) base = a.env.get(args[0]);
	else if (s0 && a.strs[+s0[1]].full) base = path.resolve(ROOT, a.strs[+s0[1]].v);
	else return null;
	for (const arg of args.slice(1)) {
		const m = STR.exec(arg);
		if (!m) break;
		const s = a.strs[+m[1]];
		if (s.v) base = path.join(base, s.v);
		if (!s.full) break;
	}
	return base;
}

// A module read for paths: env (name -> absolute path: consts built by
// path.join/resolve, __dirname, and path constants imported from local
// modules), imports (name -> the local module it came from), decls (top-level
// declarations' code ranges, to tell which of a helper's exports reads what).
const busy = new Set();
const analyse = memo((file) => {
	busy.add(file);
	const a = { file, ...lex(text(file)), env: new Map(), imports: new Map(), decls: [] };
	const dir = path.dirname(file);
	const req = (idx) => {
		const spec = a.strs[+idx].v;
		if (!/^\.{1,2}\//.test(spec)) return null;
		try {
			return require.resolve(path.resolve(dir, spec));
		} catch {
			return null;
		}
	};
	for (const m of a.code.matchAll(/\b(?:const|let|var)\s*\{([^}]*)\}\s*=\s*require\(\s*\x01(\d+)\x01\s*\)/g)) {
		const mod = req(m[2]);
		if (!mod) continue;
		for (const part of m[1].split(',')) {
			const [from, to = from] = part.split(':').map((x) => x.trim());
			if (/^[\w$]+$/.test(to)) a.imports.set(to, { mod, name: from });
		}
	}
	for (const m of a.code.matchAll(/\b(?:const|let|var)\s+([\w$]+)\s*=\s*require\(\s*\x01(\d+)\x01\s*\)(?:\.([\w$]+))?/g)) {
		const mod = req(m[2]);
		if (mod) a.imports.set(m[1], { mod, name: m[3] || null });
	}
	for (const [name, { mod, name: from }] of a.imports) {
		// only UPPER_CASE names are taken for path constants (ROOT, DATA_DIR): no need to read the rest
		if (!from || !/^[A-Z][A-Z0-9_]*$/.test(from) || !/\.c?js$/.test(mod) || busy.has(mod)) continue;
		const p = analyse(mod).env.get(from);
		if (p) a.env.set(name, p);
	}
	// consts: a name assigned more than one path (or a path and something else) is left out
	const assigns = new Map();
	for (const m of a.code.matchAll(/\b(?:const|let|var)\s+([\w$]+)\s*=\s*([^;\n]*)/g)) {
		if (a.imports.has(m[1])) continue;
		if (!assigns.has(m[1])) assigns.set(m[1], []);
		assigns.get(m[1]).push({ expr: m[2], at: m.index + m[0].length - m[2].length });
	}
	for (let pass = 0; pass < 3; pass++) {
		for (const [name, list] of assigns) {
			const vals = list.map(({ expr, at }) => {
				if (expr.trim() === '__dirname') return dir;
				const calls = [...expr.matchAll(JOIN)];
				if (!calls.length) return null;
				const c = calls[calls.length - 1];
				return evalJoin(callArgs(a.code, at + c.index + c[0].length - 1), a, dir);
			});
			if (vals[0] && vals.every((v) => v === vals[0])) a.env.set(name, vals[0]);
		}
	}
	const tops = [...a.code.matchAll(/^(?:async\s+)?(?:function\s*\*?\s*|const\s+|let\s+|class\s+)([\w$]+)/gm)];
	const exportsAt = a.code.search(/^module\.exports\b/m);
	const stop = exportsAt < 0 ? a.code.length : exportsAt;
	tops.forEach((m, k) => a.decls.push({ name: m[1], start: m.index, end: Math.min(stop, k + 1 < tops.length ? tops[k + 1].index : a.code.length) }));
	busy.delete(file);
	return a;
});

// The paths (relative to the repository) a code range of a module reads.
function rangeMentions(a, start, end, out) {
	const dir = path.dirname(a.file);
	const add = (p) => {
		if (!p) return;
		const r = rel(p);
		if (!r || r === 'tests' || r.startsWith('..') || path.isAbsolute(r)) return;
		out.add(r.replace(/\/+$/, ''));
	};
	const code = a.code.slice(start, end);
	for (const m of code.matchAll(JOIN)) add(evalJoin(callArgs(code, m.index + m[0].length - 1), a, dir));
	for (const m of code.matchAll(/\x01(\d+)\x01/g)) {
		if (/require\(\s*$/.test(code.slice(Math.max(0, m.index - 12), m.index))) continue;
		const s = a.strs[+m[1]];
		if (s.lead && a.env.has(s.lead.id) && /^\/[\w@./-]*$/.test(s.lead.rest)) add(path.join(a.env.get(s.lead.id), s.lead.rest));
		let v = s.v;
		if (!/^[\w@.-]*\/[\w@./-]*$/.test(v)) continue;
		v = v.replace(/^(\.{1,2}\/)+/, '');
		const top = v.split('/')[0];
		if (a.file.startsWith(TESTS) && ['fixtures', 'lua', 'helpers'].includes(top)) v = `tests/${v}`;
		else if (!topLevel().has(top)) continue;
		add(abs(v));
	}
	const uses = withoutRequires(code);
	for (const [name, p] of a.env) if (new RegExp(`(?<![\\w$.])${esc(name)}\\b`).test(uses)) add(p);
}

// Whether a module's code (not its comments) has a string naming the file `name`.
const names = (file, name) => analyse(file).strs.some((s) => s.v === name || s.v.endsWith(`/${name}`) || (s.lead && s.lead.rest.endsWith(`/${name}`)));

// What a test reads and runs, from its own source and the parts of tests/helpers
// it imports (helpers/lua.js left out: it is the loader every addon test shares).
const sources = memo((test) => {
	const a = analyse(test);
	const parts = [{ a, start: 0, end: a.code.length }];
	const helpers = new Map();
	for (const { mod, name } of a.imports.values()) {
		if (!mod.startsWith(path.join(TESTS, 'helpers')) || mod === LOADER || !/\.c?js$/.test(mod)) continue;
		if (!helpers.has(mod)) helpers.set(mod, new Set());
		helpers.get(mod).add(name);
	}
	for (const [mod, names] of helpers) {
		const h = analyse(mod);
		if (names.has(null)) parts.push({ a: h, start: 0, end: h.code.length });
		else for (const d of h.decls) if (names.has(d.name)) parts.push({ a: h, start: d.start, end: d.end });
	}
	const s = { parts, mentions: new Set(), strings: new Set(), runsAddon: false, wholeAddons: new Set(), spawnsCli: false, cmds: new Set(), raw: '' };
	for (const { a: m, start, end } of parts) {
		rangeMentions(m, start, end, s.mentions);
		const code = m.code.slice(start, end);
		if (/\brunAddon\s*\(/.test(code)) s.runsAddon = true;
		const vals = [];
		for (const t of code.matchAll(/\x01(\d+)\x01/g)) {
			const str = m.strs[+t[1]];
			vals.push(str.v);
			if (!str.full) continue;
			s.strings.add(str.v);
			if (addonNames().has(str.v) && !/name\s*:\s*$/.test(code.slice(Math.max(0, t.index - 12), t.index))) s.wholeAddons.add(str.v);
		}
		// the test's own text whole; a helper part by its strings
		s.raw += m === a ? text(m.file) : vals.join('\n');
		// the command a test runs: polestar(['lint', …]), cli('lint', …), [CLI, 'lint', …], [path.join(…, 'polestar.js'), 'lint', …]
		for (const t of code.matchAll(/(?:\(\s*\[|\bcli\s*\(|\[\s*CLI\s*,)\s*\x01(\d+)\x01/g)) {
			const v = m.strs[+t[1]].v;
			if (commands().has(v)) s.cmds.add(v);
		}
		for (const t of code.matchAll(/\x01(\d+)\x01(?=\s*\)?\s*,\s*\x01(\d+)\x01)/g)) {
			const v = m.strs[+t[2]].v;
			if (m.strs[+t[1]].v.endsWith('polestar.js') && commands().has(v)) s.cmds.add(v);
		}
	}
	// a test runs the CLI when it (or the helper part it calls: helpers/cli.js polestar) names tools/polestar.js
	if (s.mentions.has('tools/polestar.js')) s.spawnsCli = true;
	return s;
});

// A test's require closure, and the files it holds only because it runs the
// CLI: tools/polestar.js loads tools/commands/*.js by name.
const closure = memo((test) => {
	const base = new Set(requireClosure([test]));
	const s = sources(test);
	if (!s.spawnsCli && !base.has(CLI)) return { base, all: base, cli: false };
	const cmds = s.cmds.size ? [...s.cmds].map((c) => commands().get(c)) : [...commands().values()];
	return { base, all: new Set(requireClosure([test, CLI, ...cmds])), cli: true };
});

// Modules that run addon Lua: those that require helpers/lua.js (runners), and
// those that require a runner.
const isRunner = memo((file) => file !== LOADER && !file.startsWith(TESTS) && directRequires(file).includes(LOADER));
const runsVia = memo((file) => (isRunner(file) ? file : directRequires(file).find(isRunner) || null));
// A runner's top-level functions that run Lua: those calling runAddon or
// spawning a process, and those calling one of them.
const runningDecls = memo((file) => {
	const a = analyse(file);
	const run = new Set();
	for (let grew = true; grew; ) {
		grew = false;
		for (const d of a.decls) {
			if (run.has(d.name)) continue;
			const code = a.code.slice(d.start, d.end);
			if (/\b(?:runAddon|spawn|spawnSync|execFileSync)\s*\(/.test(code) || [...run].some((n) => new RegExp(`(?<![\\w$.])${esc(n)}\\s*\\(`).test(code))) {
				run.add(d.name);
				grew = true;
			}
		}
	}
	return run;
});

// The tool a test runs the addon through: a runner function the test (or an
// imported helper part) calls, a module it uses that requires a runner, or a
// CLI command it runs that is (or requires) a runner.
const addonTool = memo((test) => {
	const s = sources(test);
	for (const { a, start, end } of s.parts) {
		const code = withoutRequires(a.code.slice(start, end));
		for (const [name, { mod, name: from }] of a.imports) {
			// a helper's parts are read themselves
			if (mod.startsWith(TESTS)) continue;
			if (!/\.c?js$/.test(mod) || !new RegExp(`(?<![\\w$.])${esc(name)}\\b`).test(code)) continue;
			if (!isRunner(mod)) {
				if (runsVia(mod)) return runsVia(mod);
				continue;
			}
			const used = from ? [from] : [...code.matchAll(new RegExp(`(?<![\\w$.])${esc(name)}\\.([\\w$]+)`, 'g'))].map((m) => m[1]);
			if (used.some((u) => runningDecls(mod).has(u))) return mod;
		}
	}
	if (closure(test).cli) for (const c of s.cmds) if (runsVia(commands().get(c))) return runsVia(commands().get(c));
	return null;
});

// addon/<A>: the XML manifests (relative to the addon) that load inner, directly or through an Include.
const manifests = memo((addon) => {
	const dir = path.join(ROOT, 'addon', addon);
	const loads = new Map();
	if (!fs.existsSync(dir)) return loads;
	for (const x of walk(dir, (n) => n.toLowerCase().endsWith('.xml'))) {
		const body = text(x).replace(/<!--[\s\S]*?-->/g, '');
		const files = [...body.matchAll(/<(?:Script|Include)\s+file\s*=\s*"([^"]+)"/g)].map((m) => path.relative(dir, path.join(path.dirname(x), m[1].replace(/\\/g, '/'))).split(path.sep).join('/'));
		loads.set(path.relative(dir, x).split(path.sep).join('/'), files);
	}
	return loads;
});
function manifestsHolding(addon, inner) {
	const loads = manifests(addon);
	const out = new Set();
	let grew = true;
	while (grew) {
		grew = false;
		for (const [x, files] of loads) if (!out.has(x) && files.some((f) => f === inner || out.has(f))) out.add(x), (grew = true);
	}
	return [...out];
}

const SELECT = {
	test(f, add) {
		if (fs.existsSync(abs(f))) add(abs(f), 'changed');
		return true; // a deleted test is nothing to run, not unmapped
	},
	js(f, add) {
		const file = abs(f);
		for (const t of testFiles()) {
			const c = closure(t);
			if (c.base.has(file)) add(t, `requires ${f}`);
			else if (c.all.has(file)) add(t, `runs the CLI, which loads ${f}`);
		}
	},
	cli(f, add) {
		for (const t of testFiles()) if (closure(t).cli) add(t, `runs the CLI (${f})`);
	},
	tooldata(f, add) {
		const file = abs(f);
		const dir = path.dirname(file);
		const name = path.basename(f);
		// the .js beside it that name it; all of them when none does (a folder read whole)
		const beside = fs.existsSync(dir) ? fs.readdirSync(dir).filter((x) => /\.c?js$/.test(x)).map((x) => path.join(dir, x)) : [];
		const namers = beside.filter((m) => names(m, name));
		const users = new Set(namers.length ? namers : beside);
		for (const t of testFiles()) {
			const { all } = closure(t);
			if (all.has(file)) add(t, `requires ${f}`);
			else for (const m of all) if (users.has(m)) {
				add(t, `uses ${rel(m)}, beside ${f}`);
				break;
			}
		}
	},
	addon(f, add) {
		const [, A, ...rest] = f.split('/');
		const inner = rest.join('/');
		// what the client loads: code and manifests (a texture or a text file is read by path)
		if (!/\.(lua|xml|toc)$/i.test(inner)) return;
		const held = [inner, ...manifestsHolding(A, inner)];
		for (const t of testFiles()) {
			const s = sources(t);
			if (s.runsAddon) {
				if (s.wholeAddons.has(A)) add(t, `loads ${A}`);
				else {
					const x = held.find((h) => s.strings.has(h));
					if (x) add(t, `loads ${A}/${x}`);
				}
			}
			const tool = addonTool(t);
			if (tool) add(t, `runs the addon through ${rel(tool)}`);
		}
	},
	stub(f, add) {
		const name = path.basename(f);
		const loaderLoads = names(LOADER, name);
		for (const t of testFiles()) {
			const s = sources(t);
			if (s.raw.includes(name)) add(t, `names ${name}`);
			else if (s.runsAddon && loaderLoads) add(t, `runs the addon (helpers/lua.js loads ${name})`);
			else {
				const tool = addonTool(t);
				if (tool && (loaderLoads || names(tool, name))) add(t, `runs the addon through ${rel(tool)}`);
			}
		}
	},
	guides(f, add) {
		for (const t of testFiles()) if (path.basename(t).startsWith('guides')) add(t, 'a guides test');
	},
	path(f, add) {
		for (const t of testFiles())
			for (const m of sources(t).mentions)
				if (f === m || f.startsWith(`${m}/`)) {
					add(t, `reads ${m}`);
					break;
				}
	},
};

// changed: paths relative to the repository -> { selected: Map(test abs -> [reason]), unmapped, total }
function select(changed, { allUnmapped = false } = {}) {
	const selected = new Map();
	const unmapped = [];
	for (const f of changed) {
		let hits = 0;
		const add = (t, why) => {
			hits++;
			if (!selected.has(t)) selected.set(t, []);
			const list = selected.get(t);
			if (!list.includes(why)) list.push(why);
		};
		const rule = RULES.find((r) => r.when(f));
		const done = SELECT[rule.kind](f, add);
		if (rule.kind !== 'test' && rule.kind !== 'path') SELECT.path(f, add);
		if (!hits && !done) unmapped.push(f);
	}
	if (allUnmapped && unmapped.length) for (const t of testFiles()) if (!selected.has(t)) selected.set(t, ['unmapped change: the whole suite']);
	const sorted = new Map([...selected].sort(([a], [b]) => (a < b ? -1 : 1)));
	return { selected: sorted, unmapped, total: testFiles().length };
}

function git(args) {
	const r = spawnSync('git', args, { cwd: ROOT, encoding: 'utf8' });
	if (r.status !== 0) throw new Error(`git ${args.join(' ')}: ${(r.stderr || '').trim()}`);
	return r.stdout.split('\n').filter(Boolean);
}

function changedFiles(base) {
	const files = [...git(['diff', '--name-only', '--no-renames', 'HEAD']), ...git(['ls-files', '--others', '--exclude-standard'])];
	if (base) files.push(...git(['diff', '--name-only', '--no-renames', `${base}...HEAD`]));
	return [...new Set(files)].sort();
}

// Runs test files, each as `node --test <file>` in a process of its own, up to `jobs` at once,
// starting another only while the available memory stays over `reserveGb` (one large sim test
// holds 2-3 GB): the run is capped by free memory, not by the number of files. A file's output
// is printed when it fails. -> Promise of the exit code (1 when any file failed)
// Available memory: the machine's, or less when this process runs in a capped cgroup (a lane's
// systemd scope, its slice): the least headroom (memory.max - memory.current) up the tree.
function memAvailableGb() {
	let gb;
	try {
		const m = /MemAvailable:\s+(\d+) kB/.exec(fs.readFileSync('/proc/meminfo', 'utf8'));
		if (m) gb = Number(m[1]) / 2 ** 20;
	} catch {
		// not Linux
	}
	if (gb === undefined) return require('node:os').freemem() / 2 ** 30;
	try {
		let dir = path.join('/sys/fs/cgroup', fs.readFileSync('/proc/self/cgroup', 'utf8').trim().split(':').pop());
		for (; dir.startsWith('/sys/fs/cgroup/'); dir = path.dirname(dir)) {
			const max = fs.readFileSync(path.join(dir, 'memory.max'), 'utf8').trim();
			if (max === 'max') continue;
			const cur = Number(fs.readFileSync(path.join(dir, 'memory.current'), 'utf8'));
			gb = Math.min(gb, (Number(max) - cur) / 2 ** 30);
		}
	} catch {
		// no cgroup v2 memory controller here
	}
	return gb;
}
function runFiles(files, { jobs = Math.max(1, Math.floor(require('node:os').availableParallelism() / 2)), reserveGb = 6, timeoutSec = 600, cwd = ROOT, log = console.log, memAvailable = memAvailableGb } = {}) {
	const { spawn } = require('node:child_process');
	const queue = [...files];
	let running = 0;
	let failed = 0;
	const t0 = Date.now();
	return new Promise((resolve) => {
		const next = () => {
			while (queue.length && running < jobs && (running === 0 || memAvailable() > reserveGb)) {
				const file = queue.shift();
				const t = Date.now();
				running++;
				// A file runs as a test run of its own, also when this runner is inside one (node --test).
				const env = { ...process.env };
				delete env.NODE_TEST_CONTEXT;
				const child = spawn(process.execPath, ['--test', `--test-timeout=${timeoutSec * 1000}`, file], { cwd, env, stdio: ['ignore', 'pipe', 'pipe'] });
				let out = '';
				child.stdout.on('data', (d) => (out += d));
				child.stderr.on('data', (d) => (out += d));
				child.on('close', (code) => {
					running--;
					const s = ((Date.now() - t) / 1000).toFixed(1);
					if (code === 0) log(`ok    ${file} (${s} s)`);
					else {
						failed++;
						log(`FAIL  ${file} (${s} s, exit ${code})\n${out}`);
					}
					if (!queue.length && !running) {
						log(`${files.length - failed} of ${files.length} files passed in ${((Date.now() - t0) / 1000).toFixed(1)} s`);
						resolve(failed ? 1 : 0);
					} else next();
				});
			}
			// Waiting for memory: look again in a second.
			if (queue.length && running < jobs && running > 0) setTimeout(next, 1000).unref();
		};
		if (!files.length) resolve(0);
		else next();
	});
}

function main(argv) {
	const opts = { run: false, json: false, base: null, allUnmapped: false, paths: [], jobs: undefined, reserveGb: undefined };
	for (let i = 0; i < argv.length; i++) {
		const a = argv[i];
		if (a === '--run') opts.run = true;
		else if (a === '--json') opts.json = true;
		else if (a === '--all-unmapped') opts.allUnmapped = true;
		else if (a === '--base') opts.base = argv[++i];
		else if (a === '--jobs') opts.jobs = Number(argv[++i]);
		else if (a === '--reserve') opts.reserveGb = Number(argv[++i]);
		else if (a === '-h' || a === '--help') {
			console.log(fs.readFileSync(__filename, 'utf8').split('\n').slice(2, 15).map((l) => l.replace(/^\/\/ ?/, '')).join('\n'));
			return 0;
		} else if (a.startsWith('-')) {
			console.error(`testsel: unknown option ${a}`);
			return 2;
		} else opts.paths.push(rel(path.resolve(a)));
	}
	if (opts.base === undefined) {
		console.error('testsel: --base needs a revision');
		return 2;
	}
	const changed = opts.paths.length ? opts.paths : changedFiles(opts.base);
	const { selected, unmapped, total } = select(changed, opts);
	const files = [...selected.keys()].map(rel);
	if (opts.json) {
		console.log(JSON.stringify({ changed, total, selected: Object.fromEntries([...selected].map(([t, why]) => [rel(t), why])), unmapped }, null, '\t'));
	} else {
		console.log(`${selected.size} of ${total} test files (${changed.length} changed file${changed.length === 1 ? '' : 's'})`);
		for (const [t, why] of selected) console.log(`  ${rel(t)}  ${why[0]}${why.length > 1 ? ` (+${why.length - 1})` : ''}`);
		if (unmapped.length) {
			console.log(`unmapped (no test selected${opts.allUnmapped ? '; running the whole suite' : ''}):`);
			for (const f of unmapped) console.log(`  ${f}`);
		}
	}
	if (!opts.run) return 0;
	if (!files.length) {
		console.log('nothing to run');
		return 0;
	}
	return runFiles(files, { jobs: opts.jobs, reserveGb: opts.reserveGb });
}

if (require.main === module) Promise.resolve(main(process.argv.slice(2))).then((code) => (process.exitCode = code));

module.exports = { RULES, select, changedFiles, main, runFiles };
