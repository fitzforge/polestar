'use strict';
// A guide's source as data (docs/PACK_FORMAT.md, "Source tree"): what an
// import string's `source` carries, so Polestar Studio can edit the guide and
// `polestar decode` can write it back as a .guide file.
//
// toTree(guide) -> tree   guide: parseGuide's result (its `rawLines` and goal `spans`)
// toText(tree) -> string  the .guide text; throws an Error on a tree it cannot
//                         write as lines that read back to that same tree
//
//   tree   = { v: 1, header: { <key>: string | [string] }, steps: [step] }
//   step   = { title, id?, label?, along?, background?, zone?, only?, when?: [string], skipto?: [string],
//              image?, loop?, tip?, goals: [goal], zoneEnd? }
//   goal   = { verb, args: [string], mods: [[name, ...values]], note?, zone? }
//
// Values are kept as written, so toText(toTree(parseGuide(t))) compiles to
// the same guide as t:
// - a header or step value is the text after its keyword, without the
//   comment; a value that is one quoted string is that string unquoted (as
//   tools/lib/planner/source.js's `value`), except a zone name that would
//   read as `map <uiMapID>` bare: it keeps its quotes (`"Map 5"`, a name;
//   `map 1429`, the map). `title` is '' on a bare `step`;
//   `along` is '' or `until <label>`, `loop` is ''. The repeatable header keys
//   (TREE_KEYS.headerLists) hold one entry per line, in order; `tip` holds
//   one line of text per tip line, joined with "\n".
// - a goal's `args` are its positional tokens and each modifier's values its
//   tokens, as written: a quoted token keeps its quotes and escapes. The
//   free text of a `note` or `task` goal written without quotes is one arg.
//   A modifier is [name, ...tokens] with name as parse.js's MODS names it;
//   the `at`, `count`, `text` and `frame` modifiers are their tokens alone
//   (`@x,y`, `xN`, `"text"`, `era`/`live`), the others the tokens after
//   their keyword. `note` is the ` -- ` note.
// - a step's `zone` is its last `zone` line before its first goal; a goal's
//   `zone`, a `zone` line written between the step's goals, before this one;
//   `zoneEnd`, a `zone` line after the step's last goal (the zone the steps
//   after it start in, as a guide moves on after a flight), written last.
// Comments and blank lines are dropped; toText writes two-space indents, one
// blank line before each step and every key in TREE_KEYS order, then parses
// what it wrote: a text with a parse error, or one that reads back as another
// tree (a `#` or ` -- ` inside a token, an unquoted name of several words,
// several tokens in one value), is refused, naming the first part that differs.

const { isDeepStrictEqual } = require('node:util');
const { lexLine } = require('../dsl/lexer');
const { parseGuide, HEADER_KEYS, STEP_KEYS, MODS, VERBS } = require('../dsl/parse');
const { Diagnostics } = require('../dsl/diag');
const { valueOf, safeText } = require('../planner/source');

const HEADER_LISTS = ['next', 'reward', 'credits', 'pro', 'con'];
const TREE_KEYS = {
	tree: ['v', 'header', 'steps'],
	header: HEADER_KEYS,
	headerLists: HEADER_LISTS,
	step: ['title', 'id', 'label', 'along', 'background', 'zone', 'only', 'when', 'skipto', 'image', 'loop', 'tip', 'goals', 'zoneEnd'],
	stepLists: ['when', 'skipto'],
	goal: ['verb', 'args', 'mods', 'note', 'zone'],
};
const VERSION = 1;
// Modifiers written as their tokens alone, without a keyword.
const BARE_MODS = new Set(['at', 'count', 'text', 'frame']);
const MOD_NAMES = new Set(Object.values(MODS).flat());
const LINE_BREAK = /[\r\n]/;

// An object with `keys` in that order, those that are set.
function ordered(obj, keys) {
	const out = {};
	for (const k of keys) if (obj[k] !== undefined) out[k] = obj[k];
	return out;
}

// A tree with every object's keys in TREE_KEYS order.
function normal(header, steps) {
	return {
		v: VERSION,
		header: ordered(header, HEADER_KEYS),
		steps: steps.map((s) => ({ ...ordered(s, TREE_KEYS.step), goals: s.goals.map((g) => ordered(g, TREE_KEYS.goal)) })),
	};
}

// A `zone` line's value: valueOf, but a quoted name that reads as the map
// form bare keeps its quotes.
function zoneValue(line, lex) {
	const t = lex.tokens[1];
	if (lex.tokens.length === 2 && t.quoted && /^map(\s|$)/i.test(t.text)) return line.slice(t.start, t.end);
	return valueOf(line, lex);
}

function goalOf(g, line) {
	const lex = lexLine(line);
	const toks = lex.tokens;
	const written = (t) => line.slice(t.start, t.end);
	const within = (s, e) => toks.filter((t) => t.start >= s && t.end <= e).map(written);
	const sp = g.spans;
	let args = [];
	if (sp.positional) {
		const [s, e] = sp.positional;
		args = (g.verb === 'note' || g.verb === 'task') && !toks[1].quoted ? [line.slice(s, e)] : within(s, e);
	}
	const mods = sp.mods.map((m) => {
		const ts = within(m.start, m.end);
		return [m.mod, ...(BARE_MODS.has(m.mod) ? ts : ts.slice(1))];
	});
	const out = { verb: g.verb, args, mods };
	if (lex.note !== null) out.note = lex.note;
	return out;
}

function toTree(guide) {
	const lines = guide && guide.rawLines;
	if (!lines) throw new Error('toTree takes a guide parseGuide returned');
	const parsed = new Map();
	for (const s of guide.steps) for (const g of s.goals) parsed.set(g.line, g);
	const header = {};
	const steps = [];
	let step = null;
	let zone = null; // a zone line after a goal: the next goal's, else the step's zoneEnd
	const close = () => {
		if (zone) step.zoneEnd = zone.value;
		zone = null;
	};
	lines.forEach((line, idx) => {
		const ln = idx + 1;
		const lex = lexLine(line);
		if (lex.error || !lex.tokens.length) return;
		const kw = lex.tokens[0].quoted ? null : lex.tokens[0].text.toLowerCase();
		const value = kw === 'zone' ? zoneValue(line, lex) : valueOf(line, lex);
		if (!/^[ \t]/.test(line)) {
			if (kw === 'step') {
				close();
				step = { title: value, goals: [] };
				steps.push(step);
			} else if (!step && HEADER_KEYS.includes(kw)) {
				if (HEADER_LISTS.includes(kw)) (header[kw] ||= []).push(value);
				else if (header[kw] === undefined) header[kw] = value;
			}
			return;
		}
		if (!step) return;
		if (!STEP_KEYS.includes(kw)) {
			const g = parsed.get(ln);
			if (!g) return;
			const goal = goalOf(g, line);
			if (zone) goal.zone = zone.value;
			zone = null;
			step.goals.push(goal);
			return;
		}
		if (kw === 'zone') {
			if (step.goals.length) zone = { value, ln };
			else step.zone = value;
		} else if (kw === 'when' || kw === 'skipto') (step[kw] ||= []).push(value);
		else if (kw === 'tip') step.tip = step.tip === undefined ? value : `${step.tip}\n${value}`;
		else if (step[kw] === undefined) step[kw] = value;
	});
	close();
	return normal(header, steps);
}

// --- writing

function fail(where, msg) {
	throw new Error(`source tree: ${where} ${msg}`);
}

function str(v, where) {
	if (typeof v !== 'string') fail(where, 'must be a string');
	if (LINE_BREAK.test(v)) fail(where, 'holds a line break');
	return v;
}

function list(v, where) {
	if (!Array.isArray(v)) fail(where, 'must be a list');
	return v.map((x, i) => str(x, `${where}[${i + 1}]`));
}

function plainObject(v, where) {
	if (!v || typeof v !== 'object' || Array.isArray(v)) fail(where, 'must be an object');
	return v;
}

// `key value`, or the key alone for ''. A zone value in the map form, or kept
// quoted (zoneValue), is written as it is.
function keyLine(key, value) {
	if (value === '') return key;
	if (key === 'zone' && (/^map(\s|$)/i.test(value) || value.startsWith('"'))) return `zone ${value}`;
	return `${key} ${safeText(value)}`;
}

function goalLine(g, where) {
	plainObject(g, where);
	for (const k of Object.keys(g)) if (!TREE_KEYS.goal.includes(k)) fail(where, `has an unknown goal key "${k}"`);
	const verb = str(g.verb, `${where}.verb`);
	if (!VERBS.includes(verb)) fail(where, `has an unknown verb "${verb}"`);
	const parts = [verb, ...list(g.args, `${where}.args`)];
	if (!Array.isArray(g.mods)) fail(`${where}.mods`, 'must be a list');
	g.mods.forEach((m, i) => {
		const [name, ...values] = list(m, `${where}.mods[${i + 1}]`);
		if (!MOD_NAMES.has(name)) fail(`${where}.mods[${i + 1}]`, `has an unknown modifier "${name}"`);
		parts.push(...(BARE_MODS.has(name) ? values : [name, ...values]));
	});
	let text = `  ${parts.join(' ')}`;
	if (g.note !== undefined) text += ` -- ${str(g.note, `${where}.note`)}`;
	return text;
}

// The first part of tree `a` that differs from `b` ('header.title',
// 'steps[2]', 'steps[2].tip', 'steps[2].goals[1]'), or null.
function firstDiff(a, b) {
	for (const k of new Set([...Object.keys(a.header), ...Object.keys(b.header)])) {
		if (!isDeepStrictEqual(a.header[k], b.header[k])) return `header.${k}`;
	}
	for (let i = 0; i < Math.max(a.steps.length, b.steps.length); i++) {
		const where = `steps[${i + 1}]`;
		const s = a.steps[i];
		const t = b.steps[i];
		if (!s || !t) return where;
		for (const k of TREE_KEYS.step) {
			if (k !== 'goals' && !isDeepStrictEqual(s[k], t[k])) return `${where}.${k}`;
		}
		for (let j = 0; j < Math.max(s.goals.length, t.goals.length); j++) {
			if (!isDeepStrictEqual(s.goals[j], t.goals[j])) return `${where}.goals[${j + 1}]`;
		}
	}
	return null;
}

function toText(tree) {
	plainObject(tree, 'the tree');
	if (tree.v !== VERSION) fail('the tree', `has version ${JSON.stringify(tree.v)}; this Polestar writes version ${VERSION}`);
	const header = plainObject(tree.header, 'header');
	const out = [];
	const from = []; // the tree part each line of `out` writes
	const put = (where, line) => {
		out.push(line);
		from.push(where);
	};
	for (const k of Object.keys(header)) if (!HEADER_KEYS.includes(k)) fail('header', `has an unknown header key "${k}"`);
	for (const key of HEADER_KEYS) {
		const v = header[key];
		if (v === undefined) continue;
		const values = HEADER_LISTS.includes(key) ? list(v, `header.${key}`) : [str(v, `header.${key}`)];
		for (const x of values) put(`header.${key}`, keyLine(key, x));
	}
	if (!Array.isArray(tree.steps)) fail('steps', 'must be a list');
	tree.steps.forEach((s, i) => {
		const where = `steps[${i + 1}]`;
		plainObject(s, where);
		for (const k of Object.keys(s)) if (!TREE_KEYS.step.includes(k)) fail(where, `has an unknown step key "${k}"`);
		put(where, '');
		put(where, keyLine('step', str(s.title, `${where}.title`)));
		for (const key of TREE_KEYS.step) {
			const v = s[key];
			if (v === undefined || key === 'title' || key === 'goals' || key === 'zoneEnd') continue;
			const at = `${where}.${key}`;
			if (key === 'tip') {
				if (typeof v !== 'string') fail(at, 'must be a string');
				v.split('\n').forEach((t) => put(at, `  ${keyLine('tip', str(t, at))}`));
			} else if (TREE_KEYS.stepLists.includes(key)) list(v, at).forEach((x) => put(at, `  ${keyLine(key, x)}`));
			else put(at, `  ${keyLine(key, str(v, at))}`);
		}
		if (!Array.isArray(s.goals)) fail(`${where}.goals`, 'must be a list');
		s.goals.forEach((g, j) => {
			const at = `${where}.goals[${j + 1}]`;
			if (g && g.zone !== undefined) put(at, `  ${keyLine('zone', str(g.zone, `${at}.zone`))}`);
			put(at, goalLine(g, at));
		});
		if (s.zoneEnd !== undefined) put(`${where}.zoneEnd`, `  ${keyLine('zone', str(s.zoneEnd, `${where}.zoneEnd`))}`);
	});
	const text = `${out.join('\n')}\n`;
	// What was written must read back as this very tree.
	const diag = new Diagnostics();
	const guide = parseGuide(text, 'source tree', diag);
	const e = diag.errors[0];
	if (e) fail(from[e.line - 1] || 'the tree', `does not write as a line that parses: ${e.message} (\`${out[e.line - 1] ?? ''}\`)`);
	if (!guide) fail('the tree', 'writes no guide');
	let back;
	try {
		back = toTree(guide);
	} catch (err) {
		fail('the tree', `does not read back: ${err.message}`);
	}
	const want = normal(header, tree.steps);
	const diff = firstDiff(want, back);
	if (diff) fail(diff, 'does not read back the same from the text it writes (a `#` or ` -- ` inside a value, an unquoted name of several words, several tokens in one value?)');
	return text;
}

module.exports = { toTree, toText, TREE_KEYS };
