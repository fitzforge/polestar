'use strict';
// The .guide source model and its edit operations
// (docs/ARCHITECTURE.md, "Route planner").
//
// model(text, file) -> { ok, diagnostics, coords: 'era'|'live', header: { <key>: { line, raw, value } }
//                        (pro/con: arrays of those), steps: [Step] }
//   Step = { index, line, end, lead, title, tip, only, zone /* in effect at the step's start: { name } | { map } | null */,
//            directives: [{ kind: 'zone'|'only'|'tip'|'image'|'when'|'label'|'along'|'skipto', line, raw, value }], goals: [{ line, verb, raw, fields, spans }] }
//   `raw` is the whole line as in the file (spans index into it); `value` the text after the keyword;
//   `lead` the first of the comment lines directly above the step line (= `line` without);
//   `end` the step's last line that is not blank and not a column-0 comment.
// apply(text, op, file, track = []) -> { text, select: { line } | null, track, steps }; throws EditError
//   track: 1-based lines of `text` to follow; the result's `track` holds where
//   each is now (null: removed). steps: after a step op, old step index -> new
//   (null: deleted); null after any other op (step indexes are unchanged).
// zoneAt(text, line) -> the zone in effect just before 1-based `line` (past the
//   end: after the last line): { name } | { map } | null
//
// Ops (`step` = Step.index, `index` = 0-based position after the op):
//   setCoords { line, x, y, map?, frame?, zoneMap?, yards? }  setRadius { line, r }
//   setGoal { line, fields }  insertGoal { step, index, fields }  deleteGoal { line }  moveGoal { line, step, index }
//   setStep { step, title?, tip?, only?, zone? }  insertStep { index, title, goals }  deleteStep { step }
//   moveStep { step, index }  setHeader { key, value }
// Every result is re-parsed; one with more parse errors than its input is refused.
// Text values written into a line (titles, tips, zones, conditions, header
// values, goal fields and notes) must be one line: \r, \n, U+2028 and U+2029
// are refused (a tip given as several lines becomes one `tip` line each).
// valueOf(line, lex) -> the text after the line's keyword (one quoted string
//   unquoted); safeText(s) -> s as a line writes it back (bare, else quoted).
//   Shared with tools/lib/pack/sourcetree.js.

const { parseGuide, MODS, HEADER_KEYS, STEP_KEYS } = require('../dsl/parse');
const { lexLine } = require('../dsl/lexer');
const { Diagnostics } = require('../dsl/diag');
const { goalFields, formatGoal, parseGoalLine, fieldDiff, normalizeFields, formatCoord, quote } = require('./goalfmt');

class EditError extends Error {
	constructor(message) {
		super(message);
		this.name = 'EditError';
	}
}

// Verbs whose goals never use the zone (no place).
const PLACELESS = ['hearth', 'fly', 'level', 'abandon', 'destroy'];
const DEFAULT_INDENT = '  ';

// --- text <-> lines

function splitText(text) {
	const bom = text.startsWith('\uFEFF') ? '\uFEFF' : '';
	const body = bom ? text.slice(1) : text;
	const eol = body.includes('\r\n') ? '\r\n' : '\n';
	const lines = body.split(/\r?\n/);
	const final = lines.length > 1 && lines[lines.length - 1] === '';
	if (final) lines.pop();
	return { bom, eol, final, lines, mark: null, track: [] };
}

function joinText(doc) {
	return doc.bom + doc.lines.join(doc.eol) + (doc.final ? doc.eol : '');
}

// Line edits that keep `doc.mark` (a 0-based line index) on the same line,
// and each `doc.track` entry too (null once its line is removed).
function insertLines(doc, at, arr) {
	doc.lines.splice(at, 0, ...arr);
	if (doc.mark !== null && doc.mark >= at) doc.mark += arr.length;
	doc.track = doc.track.map((t) => (t !== null && t >= at ? t + arr.length : t));
}

function removeLines(doc, at, n) {
	doc.lines.splice(at, n);
	if (doc.mark !== null && doc.mark >= at) doc.mark = doc.mark >= at + n ? doc.mark - n : at;
	doc.track = doc.track.map((t) => (t === null || t < at ? t : t >= at + n ? t - n : null));
}

const LINE_BREAK = /[\r\n\u2028\u2029]/;

// `value` when it is one line, else an EditError naming `what`.
function oneLine(value, what) {
	if (typeof value === 'string' && LINE_BREAK.test(value)) throw new EditError(`${what} must be one line (no line breaks)`);
	return value;
}

const isBlank = (line) => !line.trim();
const indentOf = (line) => /^[ \t]*/.exec(line)[0];

// The text after a line's first token, as written (no comment), or ''.
function valueOf(line, lex) {
	const t = lex.tokens[1];
	if (!t) return '';
	if (lex.tokens.length === 2 && t.quoted) return t.text;
	return line.slice(t.start, lex.end).trim();
}

function zoneSpec(line, lex) {
	const toks = lex.tokens;
	if (toks[1] && !toks[1].quoted && toks[1].text.toLowerCase() === 'map' && toks[2] && /^\d+$/.test(toks[2].text)) return { map: Number(toks[2].text) };
	const name = valueOf(line, lex);
	return name ? { name } : null;
}

// --- the structure of a file

// Each line's kind: blank, comment, header, step, directive, goal (any other
// indented line) or other.
function classify(lines) {
	let inSteps = false;
	return lines.map((line) => {
		const lex = lexLine(line);
		const indented = /^[ \t]/.test(line);
		const tok = lex.tokens[0];
		const kw = tok && !tok.quoted ? tok.text.toLowerCase() : null;
		let kind;
		if (isBlank(line)) kind = 'blank';
		else if (lex.error) kind = 'other';
		else if (!lex.tokens.length) kind = lex.note === null ? 'comment' : 'other';
		else if (!indented && kw === 'step') {
			kind = 'step';
			inSteps = true;
		} else if (!indented) kind = inSteps ? 'other' : 'header';
		else if (STEP_KEYS.includes(kw)) kind = 'directive';
		else kind = 'goal';
		return { kind, lex, kw, indented };
	});
}

function analyze(text, file) {
	const doc = splitText(text);
	const diag = new Diagnostics();
	const guide = parseGuide(text, file, diag);
	const info = classify(doc.lines);
	const lines = doc.lines;
	const header = {};
	let coords = 'era';
	const starts = [];
	info.forEach((x, i) => {
		if (x.kind === 'step') starts.push(i);
		if (x.kind === 'header' && HEADER_KEYS.includes(x.kw)) {
			const entry = { line: i + 1, raw: lines[i], value: valueOf(lines[i], x.lex) };
			if (x.kw === 'pro' || x.kw === 'con') (header[x.kw] = header[x.kw] || []).push(entry);
			else if (!header[x.kw]) header[x.kw] = entry;
		}
	});
	if (guide && guide.header.coords) coords = guide.header.coords;
	const parsed = new Map((guide ? guide.steps : []).map((s) => [s.line, s]));
	// Zone in effect while walking the file.
	let zone = null;
	const steps = [];
	let si = 0;
	for (let i = 0; i < lines.length; i++) {
		const x = info[i];
		if (x.kw === 'zone' && (x.kind === 'header' || x.kind === 'directive')) {
			const spec = zoneSpec(lines[i], x.lex);
			if (spec) zone = { ...spec, line: i + 1 };
		}
		if (x.kind !== 'step') continue;
		const s = i;
		let lead = s;
		while (lead > 0 && info[lead - 1].kind === 'comment') lead--;
		// The next step's leading comments are not this step's.
		let limit = si + 1 < starts.length ? starts[si + 1] : lines.length;
		while (limit - 1 > s && info[limit - 1].kind === 'comment' && si + 1 < starts.length) limit--;
		let end = s;
		for (let k = s + 1; k < limit; k++) if (info[k].kind !== 'blank' && !(info[k].kind === 'comment' && !info[k].indented)) end = k;
		const p = parsed.get(s + 1);
		const directives = [];
		for (let k = s + 1; k <= end; k++) {
			if (info[k].kind === 'directive') directives.push({ kind: info[k].kw, line: k + 1, raw: lines[k], value: valueOf(lines[k], info[k].lex) });
		}
		const onlyDir = directives.find((d) => d.kind === 'only');
		steps.push({
			index: si,
			line: s + 1,
			end: end + 1,
			lead: lead + 1,
			title: p ? p.title : valueOf(lines[s], x.lex) || null,
			tip: p ? p.tip : null,
			only: onlyDir ? onlyDir.value : null,
			zone: zone ? (zone.map !== undefined ? { map: zone.map, line: zone.line } : { name: zone.name, line: zone.line }) : null,
			directives,
			goals: (p ? p.goals : []).map((g) => ({ line: g.line, verb: g.verb, raw: lines[g.line - 1], fields: goalFields(g), spans: g.spans, zone: g.zone })),
		});
		si++;
	}
	return { doc, diag, guide, info, header, coords, steps, errors: diag.errors };
}

function model(text, file = 'guide') {
	const a = analyze(text, file);
	return {
		ok: !a.errors.length,
		diagnostics: a.diag.sorted(),
		coords: a.coords,
		header: a.header,
		steps: a.steps.map((s) => ({ ...s, goals: s.goals.map(({ zone, ...g }) => g) })),
	};
}

// --- lookups

function stepAt(a, index) {
	const i = Number(index);
	if (!Number.isInteger(i) || !a.steps[i]) throw new EditError(`no step ${index} (the guide has ${a.steps.length})`);
	return a.steps[i];
}

function goalAt(a, line) {
	const ln = Number(line);
	if (!Number.isInteger(ln) || ln < 1 || ln > a.doc.lines.length) throw new EditError(`no line ${line}`);
	for (const step of a.steps) {
		const goal = step.goals.find((g) => g.line === ln);
		if (goal) return { step, goal };
	}
	throw new EditError(`line ${ln} is not a goal`);
}

function goalIndent(a, step) {
	const first = step.goals[0] || step.directives[0];
	if (first) return indentOf(first.raw) || DEFAULT_INDENT;
	const any = a.steps.find((s) => s.goals.length);
	return any ? indentOf(any.goals[0].raw) || DEFAULT_INDENT : DEFAULT_INDENT;
}

// The column the step's goal notes are aligned to (0: none).
function noteColumn(step) {
	let col = 0;
	for (const g of step.goals) if (g.spans && g.spans.note) col = Math.max(col, g.spans.note[0]);
	return col;
}

// Text for a step title, tip or header value: bare when it reads back the
// same, else quoted.
function safeText(s) {
	const text = String(s);
	const probe = `x ${text}`;
	const lex = lexLine(probe);
	if (!lex.error && lex.note === null && lex.tokens.length > 1 && valueOf(probe, lex) === text && !(lex.tokens.length === 2 && lex.tokens[1].quoted)) return text;
	return quote(text);
}

// `content` followed by a ` -- note` or `# comment` tail starting at `col`
// when it fits (aligned notes stay aligned), else one space after it.
function withTail(content, tail, col) {
	if (!tail) return content;
	const pad = col > content.length + 1 ? col - content.length : 1;
	return content + ' '.repeat(pad) + tail;
}

// The line's content end (after its last token), its tail (note or comment)
// and the column the tail starts at when it is aligned (gap > 1 space), else 0.
function lineParts(line) {
	const lex = lexLine(line);
	const last = lex.tokens[lex.tokens.length - 1];
	const contentEnd = last ? last.end : indentOf(line).length;
	const trimmed = line.replace(/\s+$/, '');
	const tailStart = lex.end < trimmed.length ? lex.end : null;
	const tail = tailStart === null ? null : trimmed.slice(tailStart);
	const gap = tailStart === null ? '' : line.slice(contentEnd, tailStart);
	return { lex, contentEnd, tail, col: gap.length > 1 && !gap.includes('\t') ? tailStart : 0, gap };
}

// Replace spans of a line's content ([{ start, end, text }], text '' removes
// the span and the blanks before it) and append tokens at the content end;
// the note/comment tail keeps its place.
function editLine(line, repl, appends) {
	const p = lineParts(line);
	let head = line.slice(0, p.contentEnd);
	for (const r of [...repl].sort((a, b) => b.start - a.start)) {
		let s = r.start;
		if (r.text === '') while (s > 0 && /[ \t]/.test(head[s - 1])) s--;
		head = head.slice(0, s) + r.text + head.slice(r.end);
	}
	if (appends.length) head += ` ${appends.join(' ')}`;
	if (p.tail === null) return head;
	if (p.col) return withTail(head, p.tail, p.col);
	return head + (p.gap || ' ') + p.tail;
}

// A goal line from fields: checked to parse back to them.
function goalLine(fields) {
	let text;
	try {
		text = formatGoal(fields);
	} catch (e) {
		throw new EditError(e.message);
	}
	const r = parseGoalLine(text);
	if (!r.goal) throw new EditError(`\`${text}\` does not parse: ${r.errors.join('; ')}`);
	const diff = fieldDiff(fields, r.goal);
	if (diff) throw new EditError(`\`${text}\` does not keep the field \`${diff}\``);
	return text;
}

// A goal line from fields with their `note`: { content (the goal), tail
// (`-- note`, or null without one) }, both checked to read back.
function goalParts(fields) {
	const { note, ...rest } = fields;
	const content = goalLine(rest);
	oneLine(note, 'a note');
	const n = normalizeFields({ note });
	if (n.note === undefined) return { content, tail: null };
	const r = parseGoalLine(`${content} -- ${n.note}`);
	if (!r.goal || r.goal.note !== n.note) throw new EditError(`note "${n.note}" does not read back`);
	return { content, tail: `-- ${n.note}` };
}

// --- goal ops

function modSpan(goal, mod) {
	return goal.spans.mods.find((m) => m.mod === mod) || null;
}

function setCoords(a, op) {
	const { goal } = goalAt(a, op.line);
	const verb = goal.verb;
	const positional = verb === 'goto' || verb === 'explore';
	if (!positional && !(Object.hasOwn(MODS, verb) && MODS[verb].includes('at'))) throw new EditError(`\`${verb}\` takes no coordinates`);
	const x = Number(op.x);
	const y = Number(op.y);
	if (op.x === null || op.y === null || !Number.isFinite(x) || !Number.isFinite(y)) throw new EditError('setCoords needs numbers x and y');
	const yards = op.yards;
	const xs = formatCoord(x, typeof yards === 'number' ? yards : yards && yards.x);
	const ys = formatCoord(y, typeof yards === 'number' ? yards : yards && yards.y);
	const want = { ...goal.fields, x: Number(xs), y: Number(ys), explicitCoords: true };
	const repl = [];
	const appends = [];
	const sp = goal.spans;
	if (positional) repl.push({ start: sp.coords[0], end: sp.coords[1], text: `${xs},${ys}` });
	else if (sp.coords) repl.push({ start: sp.coords[0], end: sp.coords[1], text: `@${xs},${ys}` });
	else appends.push(`@${xs},${ys}`);
	const setMod = (mod, key, value, text) => {
		const span = modSpan(goal, mod);
		if (value === null) {
			delete want[key];
			if (span) repl.push({ start: span.start, end: span.end, text: '' });
		} else {
			want[key] = value;
			if (span) repl.push({ start: span.start, end: span.end, text });
			else appends.push(text);
		}
	};
	if (op.map !== undefined) {
		let m = op.map === null || op.map === '' ? null : Number(op.map);
		if (m !== null && !(Number.isInteger(m) && m > 0)) throw new EditError(`malformed map id "${op.map}"`);
		const zone = goal.zone;
		if (m !== null && ((zone && zone.map === m) || (op.zoneMap != null && Number(op.zoneMap) === m))) m = null;
		setMod('map', 'coordMap', m, `map ${m}`);
	}
	if (op.frame !== undefined) {
		let f = op.frame ? String(op.frame).toLowerCase() : null;
		if (f !== null && f !== 'era' && f !== 'live') throw new EditError(`frame must be era or live, not "${op.frame}"`);
		if (f === a.coords) f = null;
		setMod('frame', 'frame', f, f);
	}
	const lines = a.doc.lines;
	const i = goal.line - 1;
	let next = editLine(lines[i], repl, appends);
	const back = parseGoalLine(next);
	// A minimal edit that reads back differently (a bare `note` text swallows
	// what follows it) falls back to writing the whole goal.
	if (!back.goal || fieldDiff(want, back.goal)) next = rewriteGoal(lines[i], want);
	lines[i] = next;
	a.doc.mark = i;
}

function setRadius(a, op) {
	const { goal } = goalAt(a, op.line);
	if (goal.verb !== 'goto' && goal.verb !== 'explore') throw new EditError(`setRadius is for \`goto\`/\`explore\`, not \`${goal.verb}\``);
	const want = { ...goal.fields };
	const span = modSpan(goal, 'r');
	const repl = [];
	const appends = [];
	if (op.r === null || op.r === undefined || op.r === '') {
		delete want.r;
		if (span) repl.push({ start: span.start, end: span.end, text: '' });
	} else {
		const r = Math.round(Number(op.r) * 10) / 10;
		if (!(r > 0)) throw new EditError(`radius must be yards > 0, not "${op.r}"`);
		want.r = r;
		if (span) repl.push({ start: span.start, end: span.end, text: `r ${r}` });
		else appends.push(`r ${r}`);
	}
	const i = goal.line - 1;
	let next = editLine(a.doc.lines[i], repl, appends);
	const back = parseGoalLine(next);
	if (!back.goal || fieldDiff(want, back.goal)) next = rewriteGoal(a.doc.lines[i], want);
	a.doc.lines[i] = next;
	a.doc.mark = i;
}

// A goal line rewritten from fields, keeping its indent and its note's
// column; the note is `fields.note` (absent: none). A trailing comment stays
// when there is no note; with one it would read as part of the note, so the
// caller gets it back as `comment`.
function rewriteGoal(line, fields) {
	const p = lineParts(line);
	const { content, tail } = goalParts(fields);
	const oldComment = p.tail !== null && !p.tail.startsWith('--') ? p.tail : null;
	return withTail(indentOf(line) + content, tail === null ? oldComment : tail, p.col);
}

function setGoal(a, op) {
	const { goal } = goalAt(a, op.line);
	if (!op.fields || typeof op.fields !== 'object') throw new EditError('setGoal needs fields');
	const fields = { ...op.fields };
	if (!('note' in fields)) fields.note = goal.fields.note;
	if (!fields.verb) fields.verb = goal.verb;
	const i = goal.line - 1;
	const line = a.doc.lines[i];
	const p = lineParts(line);
	const comment = p.tail !== null && !p.tail.startsWith('--') ? p.tail : null;
	a.doc.lines[i] = rewriteGoal(line, fields);
	a.doc.mark = i;
	// A comment that would now read as part of the note moves above the goal.
	if (comment && normalizeFields({ note: fields.note }).note !== undefined) insertLines(a.doc, i, [indentOf(line) + comment]);
}

// The 0-based line index a goal inserted at `index` of `step` goes to.
function goalSlot(step, index) {
	const n = step.goals.length;
	const k = index === undefined || index === null ? n : Number(index);
	if (!Number.isInteger(k) || k < 0 || k > n) throw new EditError(`goal index ${index} is out of range (0-${n})`);
	if (k < n) return step.goals[k].line - 1;
	if (n) return step.goals[n - 1].line;
	return step.end;
}

function insertGoal(a, op) {
	const step = stepAt(a, op.step);
	if (!op.fields || typeof op.fields !== 'object') throw new EditError('insertGoal needs fields');
	const { content, tail } = goalParts(op.fields);
	const text = withTail(goalIndent(a, step) + content, tail, noteColumn(step));
	const at = goalSlot(step, op.index);
	insertLines(a.doc, at, [text]);
	a.doc.mark = at;
}

function deleteGoal(a, op) {
	const { step, goal } = goalAt(a, op.line);
	const k = step.goals.indexOf(goal);
	const other = step.goals[k + 1] || step.goals[k - 1] || null;
	a.doc.mark = other ? other.line - 1 : null;
	removeLines(a.doc, goal.line - 1, 1);
}

function moveGoal(a, op) {
	const { goal } = goalAt(a, op.line);
	const target = stepAt(a, op.step);
	const i = goal.line - 1;
	const text = a.doc.lines[i];
	// The target's goals without the moved one, as they sit after its removal.
	const shift = (ln) => (ln - 1 > i ? ln - 1 : ln);
	const t = {
		end: shift(target.end),
		goals: target.goals.filter((g) => g !== goal).map((g) => ({ line: shift(g.line) })),
	};
	const moved = a.doc.track.map((ln) => ln === i);
	removeLines(a.doc, i, 1);
	const at = goalSlot(t, op.index);
	insertLines(a.doc, at, [goalIndent(a, target) + text.replace(/^[ \t]+/, '')]);
	a.doc.track = a.doc.track.map((ln, k) => (moved[k] ? at : ln));
	a.doc.mark = at;
}

// --- step ops

function setStep(a0, op, file) {
	let a = a0;
	const index = stepAt(a, op.step).index;
	const reread = () => {
		a = rescan(a, file);
		return a.steps[index];
	};
	const firstGoalLine = (step) => (step.goals.length ? step.goals[0].line : step.end + 1);
	const leading = (step) => step.directives.filter((d) => d.line < firstGoalLine(step));
	const put = (kind, values, find) => {
		let step = reread();
		const indent = goalIndent(a, step);
		const old = find(step);
		const lines = values.map((v) => `${indent}${kind} ${v}`);
		if (old.length) {
			const at = old[0].line - 1;
			for (const d of [...old].reverse()) removeLines(a.doc, d.line - 1, 1);
			insertLines(a.doc, at, lines);
			return;
		}
		if (!lines.length) return;
		// New directives go after the leading ones that come first (zone, then only, then tip).
		const order = ['zone', 'only', 'tip'];
		const before = leading(step).filter((d) => order.indexOf(d.kind) <= order.indexOf(kind));
		insertLines(a.doc, before.length ? before[before.length - 1].line : step.line, lines);
	};
	const empty = (v) => v === null || v === '';
	oneLine(op.zone && typeof op.zone === 'object' ? op.zone.name : op.zone, 'the zone');
	oneLine(op.only, 'the `only` conditions');
	oneLine(op.title, 'the step title');
	const tips = op.tip === undefined || empty(op.tip) ? [] : String(op.tip).split(/\r?\n/).filter((t) => t.trim()).map((t) => safeText(oneLine(t, 'each tip line')));
	if (op.zone !== undefined) {
		let value = null;
		if (!empty(op.zone)) {
			if (typeof op.zone === 'object') value = op.zone.map !== undefined ? `map ${Number(op.zone.map)}` : safeText(op.zone.name);
			else value = String(op.zone).trim();
		}
		put('zone', value === null ? [] : [value], (s) => leading(s).filter((d) => d.kind === 'zone').slice(0, 1));
	}
	if (op.only !== undefined) put('only', empty(op.only) ? [] : [String(op.only).trim()], (s) => s.directives.filter((d) => d.kind === 'only'));
	if (op.tip !== undefined) put('tip', tips, (s) => s.directives.filter((d) => d.kind === 'tip'));
	const step = reread();
	if (op.title !== undefined) {
		const i = step.line - 1;
		const p = lineParts(a.doc.lines[i]);
		const head = empty(op.title) ? 'step' : `step ${safeText(op.title)}`;
		a.doc.lines[i] = p.tail === null ? head : `${head} ${p.tail}`;
	}
	a.doc.mark = step.line - 1;
	a0.doc = a.doc;
}

// Remove lines [from, to] (0-based) and leave one blank line at the seam.
function cutBlock(doc, from, to) {
	const block = doc.lines.slice(from, to + 1);
	removeLines(doc, from, to - from + 1);
	while (from > 0 && from < doc.lines.length && isBlank(doc.lines[from - 1]) && isBlank(doc.lines[from])) removeLines(doc, from, 1);
	if (from >= doc.lines.length) while (doc.lines.length && isBlank(doc.lines[doc.lines.length - 1])) removeLines(doc, doc.lines.length - 1, 1);
	return block;
}

// Insert a step block so it becomes step `index` of the steps in `a`
// (re-scanned), one blank line around it. -> the block's first line index.
function placeBlock(a, block, index) {
	const doc = a.doc;
	const steps = a.steps;
	const k = index === undefined || index === null ? steps.length : Number(index);
	if (!Number.isInteger(k) || k < 0 || k > steps.length) throw new EditError(`step index ${index} is out of range (0-${steps.length})`);
	let at;
	let lines;
	if (k < steps.length) {
		at = steps[k].lead - 1;
		lines = [...block, ''];
		if (at > 0 && !isBlank(doc.lines[at - 1])) lines.unshift('');
	} else {
		at = steps.length ? steps[steps.length - 1].end : doc.lines.length;
		lines = [...block];
		if (at > 0 && !isBlank(doc.lines[at - 1])) lines.unshift('');
		if (at < doc.lines.length && !isBlank(doc.lines[at])) lines.push('');
	}
	insertLines(doc, at, lines);
	return at + (lines[0] === '' ? 1 : 0);
}

function rescan(a, file) {
	const b = analyze(joinText(a.doc), file);
	b.doc.mark = a.doc.mark;
	b.doc.track = a.doc.track.slice();
	return b;
}

function insertStep(a, op) {
	const goals = Array.isArray(op.goals) ? op.goals : [];
	if (!goals.length) throw new EditError('a step needs at least one goal');
	oneLine(op.title, 'the step title');
	const indent = a.steps.length ? goalIndent(a, a.steps[0]) : DEFAULT_INDENT;
	const block = [op.title === undefined || op.title === null || op.title === '' ? 'step' : `step ${safeText(op.title)}`];
	for (const f of goals) {
		if (!f || typeof f !== 'object') throw new EditError('insertStep needs goal fields');
		const { content, tail } = goalParts(f);
		block.push(`${indent}${content}${tail === null ? '' : ` ${tail}`}`);
	}
	const at = placeBlock(a, block, op.index);
	// Old step i -> new step i (or i + 1 from the inserted one on).
	const k = op.index === undefined || op.index === null ? a.steps.length : Number(op.index);
	a.doc.mark = at;
	return a.steps.map((s, i) => (i < k ? i : i + 1));
}

function deleteStep(a, op) {
	const step = stepAt(a, op.step);
	cutBlock(a.doc, step.lead - 1, step.end - 1);
	a.doc.mark = null;
	return a.steps.map((s, i) => (i < step.index ? i : i > step.index ? i - 1 : null));
}

function moveStep(a, op, file) {
	const step = stepAt(a, op.step);
	const n = a.steps.length;
	const k = Number(op.index);
	if (!Number.isInteger(k) || k < 0 || k >= n) throw new EditError(`step index ${op.index} is out of range (0-${n - 1})`);
	const from = step.lead - 1;
	const to = step.end - 1;
	// Followed lines inside the moved block, as offsets from its first line.
	const inBlock = a.doc.track.map((t) => (t !== null && t >= from && t <= to ? t - from : null));
	const block = cutBlock(a.doc, from, to);
	const b = rescan(a, file);
	const at = placeBlock(b, block, k);
	a.doc = b.doc;
	a.doc.track = a.doc.track.map((t, i) => (inBlock[i] === null ? t : at + inBlock[i]));
	a.doc.mark = at + (step.line - step.lead);
	const order = a.steps.map((s, i) => i).filter((i) => i !== step.index);
	order.splice(k, 0, step.index);
	const map = new Array(n);
	order.forEach((old, now) => {
		map[old] = now;
	});
	return map;
}

function setHeader(a, op) {
	const key = String(op.key || '').toLowerCase();
	if (!HEADER_KEYS.includes(key)) throw new EditError(`unknown header key "${op.key}"`);
	const doc = a.doc;
	const lines = a.info.map((x, i) => (x.kind === 'header' && x.kw === key ? i : -1)).filter((i) => i >= 0);
	const values = (Array.isArray(op.value) ? op.value : [op.value]).filter((v) => v !== null && v !== undefined && String(v).trim() !== '');
	for (const v of values) oneLine(String(v), `the \`${key}\` value`);
	if (values.length > 1 && key !== 'pro' && key !== 'con') throw new EditError(`\`${key}\` takes one value`);
	const text = values.map((v) => `${key} ${safeText(String(v).trim())}`);
	if (lines.length) {
		const at = lines[0];
		const p = lineParts(doc.lines[at]);
		if (text.length === 1 && lines.length === 1 && p.tail !== null && !p.tail.startsWith('--')) text[0] += ` ${p.tail}`;
		for (const i of [...lines].reverse()) removeLines(doc, i, 1);
		insertLines(doc, at, text);
		doc.mark = text.length ? at : null;
		return;
	}
	if (!text.length) return;
	const last = a.info.reduce((m, x, i) => (x.kind === 'header' ? i : m), -1);
	insertLines(doc, last + 1, text);
	doc.mark = last + 1;
}

function zoneAt(text, line) {
	const doc = splitText(text);
	const info = classify(doc.lines);
	let zone = null;
	for (let i = 0; i < Math.min(line - 1, doc.lines.length); i++) {
		const x = info[i];
		if (x.kw !== 'zone' || (x.kind !== 'header' && x.kind !== 'directive')) continue;
		const spec = zoneSpec(doc.lines[i], x.lex);
		if (spec) zone = spec;
	}
	return zone;
}

// --- zone keeping

const zoneKey = (z) => (!z ? '' : z.map !== undefined ? `map:${z.map}` : `name:${String(z.name).toLowerCase()}`);
const locatedByZone = (g) => !PLACELESS.includes(g.verb) && g.fields.coordMap === undefined;

// After a step op: every step that kept its goals but now sees another zone
// gets the zone it had as its first directive. `map[old] = new` step index.
function keepZones(before, after0, map, file) {
	let after = after0;
	const raw = (z) => {
		const line = before.doc.lines[z.line - 1];
		return valueOf(line, lexLine(line));
	};
	for (let round = 0; round <= after.steps.length; round++) {
		let fixed = false;
		for (let old = 0; old < before.steps.length && !fixed; old++) {
			const now = map[old];
			if (now === null || now === undefined) continue;
			const was = before.steps[old];
			const is = after.steps[now];
			if (!is || was.goals.length !== is.goals.length) continue;
			const changed = was.goals.find((g, t) => locatedByZone(g) && g.zone && zoneKey(g.zone) !== zoneKey(is.goals[t].zone));
			if (!changed) continue;
			insertLines(after.doc, is.line, [`${goalIndent(after, is)}zone ${raw(changed.zone)}`]);
			after = rescan(after, file);
			fixed = true;
		}
		if (!fixed) break;
	}
	return after;
}

// --- apply

const OPS = { setCoords, setRadius, setGoal, insertGoal, deleteGoal, moveGoal, setStep, insertStep, deleteStep, moveStep, setHeader };

function apply(text, op, file = 'guide', track = []) {
	if (!op || typeof op !== 'object' || !Object.hasOwn(OPS, op.op)) throw new EditError(`unknown op "${op && op.op}"`);
	const before = analyze(text, file);
	const work = analyze(text, file);
	work.doc.track = track.map((ln) => (ln === null ? null : ln - 1));
	const map = OPS[op.op](work, op, file);
	let after = rescan(work, file);
	if (Array.isArray(map)) after = keepZones(before, after, map, file);
	const out = joinText(after.doc);
	if (after.errors.length > before.errors.length) {
		const known = new Set(before.errors.map((d) => d.message));
		const fresh = after.errors.find((d) => !known.has(d.message)) || after.errors[0];
		throw new EditError(`the edit would not parse: line ${fresh.line}: ${fresh.message}`);
	}
	return {
		text: out,
		select: after.doc.mark === null ? null : { line: after.doc.mark + 1 },
		track: after.doc.track.map((t) => (t === null ? null : t + 1)),
		steps: Array.isArray(map) ? map : null,
	};
}

module.exports = { model, apply, zoneAt, EditError, valueOf, safeText };
