'use strict';
// Parser for .guide files (docs/GUIDE_FORMAT.md). Produces a syntax tree with
// line numbers; filling from reference data happens in resolve.js.
//
// parseGuide(text, file, diag) -> guide | null
//   guide = { file, id, line, header: { ... }, lines: { <headerKey>: line, pros: [line], cons: [line], rewards: [line], nextOf: { <id>: line } }, steps: [step] }
//   (header.next: the `next` guide ids in order; header.nextWhen: { <id>: predicate with its line } for `next <id> when ...`)
//   step  = { line, title, only, tip, image?, when?: [predicate], label?, along?, skipto?, goals: [goal] }
//   (image: { path, ext, w, h, line }, images.js parseImagePath; w/h null unless written)
//   (when: tools/lib/dsl/when.js predicates, each with its line; only on a step that has one;
//   label: the step's name; along: true, or the label `along until` names; labelLine/alongLine: their lines;
//   skipto: [{ to, when: predicate, line }], the step's `skipto <label> when <predicate>` lines in order)
//   goal  = { line, verb, zone, note, ...positional/modifier fields }
// `zone` on a goal is the zone spec in effect ({ name } | { map }, with line),
// shared by every goal under the same header/step `zone` line.
// Each goal also carries a non-enumerable `spans` (character offsets into its
// line, [start, end)) for editors (tools/lib/planner/source.js):
//   { verb: [s, e], positional: [s, e] | null, coords: [s, e] | null,
//     mods: [{ mod, start, end, text? }], note: [s, e] | null, comment: [s, e] | null }
// `coords`: the goto/explore positional coordinates or the whole `@x,y`
// modifier; `mods` names each modifier as MODS does (`text` on `only`: its
// condition list as written); `note` runs from the ` -- ` dashes.

const { lexLine } = require('./lexer');
const { parseConditions, FACTIONS } = require('./conditions');
const { parseWhen } = require('./when');
const { readMoney } = require('./money');
const { parseImagePath, parseImageSize } = require('./images');
const { levelPoint } = require('../game/xp');

// Slash-separated segments, none empty (an empty one would make a hidden `.lua` file).
const ID_RE = /^[a-z0-9_-]+(?:\/[a-z0-9_-]+)*$/;
const INT_RE = /^\d+$/;
const NUM_RE = /^-?\d+(?:\.\d+)?$/;
const COORD_RE = /^(-?\d+(?:\.\d+)?),(-?\d+(?:\.\d+)?)$/;
// A step label (`label camp`, `along until camp`): letters, digits, `-` and `_`, as written.
const LABEL_RE = /^[A-Za-z0-9_-]+$/;

const HEADER_KEYS = ['guide', 'title', 'levels', 'zone', 'faction', 'race', 'class', 'next', 'category', 'folder', 'keywords', 'collects', 'reward', 'why', 'author', 'version', 'coords', 'pitch', 'pro', 'con'];
// Lines inside a step that are not goals.
// `loop`: the step's `goto` points are the spawn areas of its kill, collect
// and interact goals (resolve.js, applyLoop).
// `skipto <label> when <predicate>`: when the route reaches the step and the
// predicate holds, it jumps to the labelled step (resolve.js, checkLabels).
const STEP_KEYS = ['zone', 'only', 'tip', 'image', 'when', 'label', 'along', 'skipto', 'loop'];

// `group [N]`: the goal needs a group (of N players), shown in the guide window.
const COMMON = ['text', 'optional', 'only', 'group'];
// `frame` = the `era` / `live` modifiers: which map frame explicit coordinates are in.
const COORDS = ['at', 'map', 'r', 'frame'];
const MODS = {
	accept: [...COMMON, ...COORDS, 'npc', 'object', 'item', 'lvl'],
	// `reward`/`choose`/`xp`/`money`: what the turn-in pays, shown on the goal.
	// `direct`: handed in straight from the NPC's window, with no accept.
	turnin: [...COMMON, ...COORDS, 'npc', 'object', 'reward', 'choose', 'xp', 'money', 'direct'],
	complete: [...COMMON, ...COORDS],
	kill: [...COMMON, ...COORDS, 'npc', 'quest', 'count'],
	collect: [...COMMON, ...COORDS, 'npc', 'quest', 'count', 'nearest'],
	goto: [...COMMON, 'map', 'r', 'frame'],
	talk: [...COMMON, ...COORDS],
	interact: [...COMMON, ...COORDS, 'quest'],
	use: [...COMMON, ...COORDS, 'quest'],
	sethome: [...COMMON, ...COORDS, 'npc'],
	hearth: [...COMMON],
	getfp: [...COMMON, ...COORDS, 'npc'],
	fly: [...COMMON],
	train: [...COMMON, ...COORDS, 'npc'],
	buy: [...COMMON, ...COORDS, 'npc', 'count', 'nearest'],
	vendor: [...COMMON, ...COORDS, 'npc'],
	level: [...COMMON],
	// `money <amount>`: hold that much; `task "<text>"`: done when the player ticks it.
	money: ['text', 'optional', 'only'],
	task: ['optional', 'only', ...COORDS],
	note: ['optional', 'only', ...COORDS],
	skill: [...COMMON, ...COORDS],
	learn: [...COMMON, ...COORDS, 'npc', 'item', 'nearest'],
	craft: [...COMMON, ...COORDS, 'count', 'until'],
	rep: [...COMMON, ...COORDS],
	explore: [...COMMON, 'map', 'r', 'frame'],
	achieve: [...COMMON, ...COORDS, 'criteria'],
};
const VERBS = Object.keys(MODS);
const MOD_LABEL = { at: '@x,y', count: 'xN', text: '"text"', until: 'until <N>', criteria: 'criteria <n>', frame: 'era`/`live', xp: 'xp <N>', money: 'money <amount>', group: 'group [N]' };
const MOD_WORDS = ['map', 'npc', 'object', 'item', 'quest', 'r', 'lvl', 'optional', 'only', 'until', 'criteria', 'era', 'live', 'nearest', 'reward', 'choose', 'xp', 'money', 'group', 'direct'];
// A party or raid: 2 to 40 players.
const GROUP_MIN = 2;
const GROUP_MAX = 40;

// Item qualities as the client numbers them (Enum.ItemQuality).
const QUALITIES = ['poor', 'common', 'uncommon', 'rare', 'epic', 'legendary', 'artifact', 'heirloom'];

// `reward`/`choose` list from tokens[i]: `<itemId> ["Item name"] [quality]`
// entries, one after another. -> { items: [{ item, itemName?, quality? }], next } | { error }
function readRewardList(tokens, i, word) {
	const items = [];
	let k = i;
	while (k < tokens.length && !tokens[k].quoted && INT_RE.test(tokens[k].text)) {
		const it = { item: Number(tokens[k].text) };
		if (it.item <= 0) return { error: `malformed item id "${tokens[k].text}" in \`${word}\`` };
		k++;
		if (tokens[k] && tokens[k].quoted) {
			if (!tokens[k].text) return { error: `empty item name in \`${word}\`` };
			it.itemName = tokens[k].text;
			k++;
		}
		if (tokens[k] && !tokens[k].quoted && QUALITIES.includes(tokens[k].text.toLowerCase())) {
			it.quality = QUALITIES.indexOf(tokens[k].text.toLowerCase());
			k++;
		}
		if (items.some((o) => o.item === it.item)) return { error: `\`${word}\` lists item ${it.item} twice` };
		items.push(it);
	}
	if (!items.length) return { error: `\`${word}\` needs item ids: ${word} <itemId> ["Item name"] [quality] ...` };
	return { items, next: k };
}

// Profession ranks in trainer order (rank 1..4).
const RANKS = ['apprentice', 'journeyman', 'expert', 'artisan'];

// Tokens that start the modifier part of a goal line.
function isModifierToken(tok) {
	if (!tok || tok.quoted) return true;
	const w = tok.text.toLowerCase();
	return MOD_WORDS.includes(w) || w.startsWith('@') || /^x\d+$/.test(w);
}

// Reputation standings as the client numbers them (1 Hated .. 8 Exalted).
const STANDINGS = { hated: 1, hostile: 2, unfriendly: 3, neutral: 4, friendly: 5, honored: 6, revered: 7, exalted: 8 };

// A standing token -> { value } | { error } | null (not a standing at all).
function readStanding(tok) {
	if (!tok || tok.quoted) return null;
	const word = tok.text.toLowerCase();
	if (Object.hasOwn(STANDINGS, word)) return { value: STANDINGS[word] };
	if (!INT_RE.test(tok.text)) return null;
	const n = Number(tok.text);
	return n >= 1 && n <= 8 ? { value: n } : { error: `standing ${tok.text} is out of range (1-8, or Hated..Exalted)` };
}

// Unquoted words up to (not including) the first token `stop` accepts.
function wordsUntil(toks, i, stop) {
	const words = [];
	while (i < toks.length && !toks[i].quoted && !stop(toks[i])) words.push(toks[i++].text);
	return { text: words.join(' '), next: i };
}

function unquoteRest(line, lex, from) {
	const toks = lex.tokens.slice(from);
	if (!toks.length) return '';
	if (toks.length === 1 && toks[0].quoted) return toks[0].text;
	return line.slice(toks[0].start, lex.end).trim();
}

// `image <path> [<w>x<h>]`: the step's picture, at most one per step.
function parseImage(step, toks, ln, err) {
	const usage = 'image media/<name>.tga [<width>x<height>]';
	if (step.image) return err(ln, `duplicate \`image\` in step (first on line ${step.image.line}): a step shows one picture`);
	const args = toks.slice(1);
	if (!args.length) return err(ln, '`image` needs the picture\'s path in the pack folder', usage);
	if (args.length > 2) return err(ln, `unexpected "${args[2].text}" after the picture's size`, usage);
	const p = parseImagePath(args[0].text);
	if (p.error) return err(ln, p.error, p.hint);
	let size = null;
	if (args[1]) {
		size = args[1].quoted ? null : parseImageSize(args[1].text);
		if (!size) return err(ln, `malformed picture size "${args[1].text}"`, 'write it as <width>x<height> in pixels, such as 512x256');
	}
	step.image = { path: p.path, ext: p.ext, w: size ? size.w : null, h: size ? size.h : null, line: ln };
}

// Read "x,y" starting at tokens[i] whose text (after an optional "@") is
// `first`. Accepts "x,y", "x, y", "x ,y" and "x , y". Returns { x, y, next } or
// { error }.
function readCoords(tokens, i, first) {
	let text = first;
	let k = i + 1;
	if (text === '') {
		if (k >= tokens.length || tokens[k].quoted) return { error: 'expected coordinates x,y' };
		text = tokens[k].text;
		k++;
	}
	if (!COORD_RE.test(text)) {
		if (/^-?\d+(?:\.\d+)?,$/.test(text) && k < tokens.length && !tokens[k].quoted) {
			text += tokens[k].text;
			k++;
		} else if (NUM_RE.test(text) && k < tokens.length && !tokens[k].quoted && tokens[k].text.startsWith(',')) {
			text += tokens[k].text;
			k++;
			if (text.endsWith(',') && k < tokens.length && !tokens[k].quoted) {
				text += tokens[k].text;
				k++;
			}
		}
	}
	const m = COORD_RE.exec(text);
	if (!m) return { error: `malformed coordinates "${text}" (expected x,y)` };
	return { x: Number(m[1]), y: Number(m[2]), next: k };
}

function parseGuide(text, file, diag) {
	const lines = text.replace(/^\uFEFF/, '').split(/\r?\n/);
	const guide = { file, id: null, line: 0, header: {}, lines: {}, steps: [] };
	let zone = null; // zone spec in effect
	let step = null;
	let sawContent = false;

	const err = (ln, msg, hint) => diag.error(file, ln, msg, hint);
	const warn = (ln, msg, hint) => diag.warn(file, ln, msg, hint);

	for (let idx = 0; idx < lines.length; idx++) {
		const ln = idx + 1;
		const line = lines[idx];
		const lex = lexLine(line);
		if (lex.error) {
			err(ln, lex.error);
			continue;
		}
		const toks = lex.tokens;
		// An empty name, title, label or note would make the engine reject the whole guide.
		if (toks.some((t) => t.quoted && !t.text.trim())) {
			err(ln, 'empty quoted string (names, titles, labels and notes need text)');
			// A `step ""` line still opens its step so the lines under it stay attached.
			const opensStep = !/^[ \t]/.test(line) && !toks[0].quoted && toks[0].text.toLowerCase() === 'step';
			if (!opensStep) continue;
		}
		if (!toks.length) {
			if (lex.note !== null) err(ln, 'a ` -- ` note must follow a goal on the same line');
			continue;
		}
		const indented = /^[ \t]/.test(line);
		const kw = toks[0].quoted ? null : toks[0].text.toLowerCase();

		if (!sawContent) {
			sawContent = true;
			// Report once; the rest of the file still parses so later errors show too.
			if (indented || kw !== 'guide') err(ln, 'a guide must start with `guide <id>` in column 0');
		}

		if (!indented) {
			// Report, then keep the line's content so one mistake yields one error.
			if (lex.note !== null) err(ln, 'notes (` -- `) are only allowed on goal lines');
			if (kw === 'step') {
				step = { line: ln, title: unquoteRest(line, lex, 1) || null, only: null, tip: null, goals: [] };
				guide.steps.push(step);
				continue;
			}
			if (step) {
				err(ln, `unexpected \`${toks[0].text}\` in column 0 after the first step (indent step lines; header keys belong before the first step)`);
				continue;
			}
			if (!kw || !HEADER_KEYS.includes(kw)) {
				err(ln, `unknown header key "${toks[0].text}"`, `header keys: ${HEADER_KEYS.join(', ')}`);
				continue;
			}
			const repeatable = kw === 'pro' || kw === 'con' || kw === 'reward' || kw === 'next';
			if (guide.lines[kw] && !repeatable) {
				err(ln, `duplicate header key \`${kw}\` (first on line ${guide.lines[kw]})`);
				continue;
			}
			if (!guide.lines[kw]) guide.lines[kw] = ln;
			parseHeader(guide, kw, line, lex, ln, err, warn);
			if (kw === 'zone' && guide.header.zone) zone = guide.header.zone;
			continue;
		}

		// Indented line.
		if (!step) {
			err(ln, 'indented line before the first `step`');
			continue;
		}
		if (STEP_KEYS.includes(kw)) {
			if (lex.note !== null) err(ln, 'notes (` -- `) are only allowed on goal lines');
			if (kw === 'zone') {
				const spec = parseZoneSpec(line, lex, ln, err);
				if (spec) zone = step.zone = spec; // the step's last `zone` line (resolve.js: who is in which zone)
			} else if (kw === 'only') {
				if (step.only) {
					err(ln, 'duplicate `only` in step');
					continue;
				}
				const rest = line.slice(toks[1] ? toks[1].start : lex.end, lex.end).trim();
				if (!rest) {
					err(ln, '`only` needs a condition list');
					continue;
				}
				const c = parseConditions(rest.replace(/\s*,\s*/g, ','), 'any');
				c.errors.forEach((e) => err(ln, e));
				c.warnings.forEach((w) => warn(ln, w));
				if (!c.errors.length) step.only = c.value;
			} else if (kw === 'when') {
				const w = parseWhen(line.slice(toks[1] ? toks[1].start : lex.end, lex.end));
				if (w.error) err(ln, w.error, w.hint);
				else (step.when ||= []).push({ ...w.value, line: ln });
			} else if (kw === 'label') {
				if (step.label) {
					err(ln, 'duplicate `label` in step');
					continue;
				}
				if (toks.length !== 2 || toks[1].quoted) {
					err(ln, '`label` needs a name: label <name>');
					continue;
				}
				if (!LABEL_RE.test(toks[1].text)) {
					err(ln, `malformed label "${toks[1].text}" (letters, digits, - and _)`);
					continue;
				}
				step.label = toks[1].text;
				step.labelLine = ln;
			} else if (kw === 'along') {
				if (step.along !== undefined) {
					err(ln, 'duplicate `along` in step');
					continue;
				}
				if (toks.length === 1) {
					step.along = true;
				} else if (toks.length === 3 && !toks[1].quoted && toks[1].text.toLowerCase() === 'until' && !toks[2].quoted && LABEL_RE.test(toks[2].text)) {
					step.along = toks[2].text;
				} else {
					err(ln, '`along` takes nothing or `until <label>`');
					continue;
				}
				step.alongLine = ln;
			} else if (kw === 'skipto') {
				const usage = '`skipto` needs a label and a predicate: skipto <label> when <predicate>';
				if (toks.length < 4 || toks[1].quoted || toks[2].quoted || toks[2].text.toLowerCase() !== 'when') {
					err(ln, usage);
					continue;
				}
				if (!LABEL_RE.test(toks[1].text)) {
					err(ln, `malformed label "${toks[1].text}" (letters, digits, - and _)`);
					continue;
				}
				const w = parseWhen(line.slice(toks[3].start, lex.end));
				if (w.error) err(ln, `\`skipto\`: ${w.error}`, w.hint);
				else if (w.value.k === 'group') err(ln, '`skipto` cannot wait for an answer: `group` asks the player at a step', 'put `when group <quest>` on the steps of that quest instead');
				else (step.skipto ||= []).push({ to: toks[1].text, when: { ...w.value, line: ln }, line: ln });
			} else if (kw === 'image') {
				parseImage(step, toks, ln, err);
			} else if (kw === 'loop') {
				if (toks.length > 1) err(ln, '`loop` takes nothing');
				else if (step.loop) err(ln, 'duplicate `loop` in step');
				else step.loop = ln;
			} else {
				const tip = unquoteRest(line, lex, 1);
				if (!tip) {
					err(ln, '`tip` needs text');
					continue;
				}
				step.tip = step.tip ? `${step.tip}\n${tip}` : tip;
			}
			continue;
		}
		if (!kw || !Object.hasOwn(MODS, kw)) {
			err(ln, toks[0].quoted ? 'expected a verb, found a string' : `unknown verb "${toks[0].text}"`, `verbs: ${VERBS.join(', ')}`);
			continue;
		}
		const goal = parseGoal(kw, line, lex, ln, err, warn);
		if (goal) {
			goal.zone = zone;
			step.goals.push(goal);
		}
	}

	if (!guide.lines.guide) {
		if (!sawContent) err(1, 'empty guide file (expected `guide <id>`)');
		return null;
	}
	for (const key of ['title', 'levels', 'zone']) {
		if (!guide.lines[key]) err(guide.line, `missing required header \`${key}\``);
	}
	if (!guide.steps.length) err(guide.line, 'guide has no steps');
	for (const s of guide.steps) {
		if (!s.goals.length) err(s.line, 'step has no goals');
	}
	return guide;
}

function parseZoneSpec(line, lex, ln, err) {
	const toks = lex.tokens;
	if (toks.length < 2) {
		err(ln, '`zone` needs a zone name or `map <uiMapID>`');
		return null;
	}
	if (!toks[1].quoted && toks[1].text.toLowerCase() === 'map') {
		if (toks.length !== 3 || toks[2].quoted || !INT_RE.test(toks[2].text) || Number(toks[2].text) <= 0) {
			err(ln, 'malformed `zone map <uiMapID>`');
			return null;
		}
		return { map: Number(toks[2].text), line: ln };
	}
	return { name: unquoteRest(line, lex, 1), line: ln };
}

function parseHeader(guide, kw, line, lex, ln, err, warn) {
	const toks = lex.tokens;
	const h = guide.header;
	const rest = unquoteRest(line, lex, 1);
	if (kw !== 'zone' && !rest) {
		err(ln, `\`${kw}\` needs a value`);
		return;
	}
	switch (kw) {
		case 'guide':
			guide.line = ln;
			if (toks.length !== 2 || toks[1].quoted || !ID_RE.test(toks[1].text)) {
				err(ln, `malformed guide id "${rest}" (allowed: a-z 0-9 _ - in segments separated by single /)`);
				guide.id = rest || null;
				return;
			}
			guide.id = toks[1].text;
			return;
		case 'title':
		case 'category':
		case 'author':
		case 'pitch':
		case 'why':
		case 'folder':
			h[kw] = rest;
			return;
		case 'keywords': {
			// `keywords a, b, c`: extra search words for the guide menu.
			const words = rest.split(',').map((w) => w.trim());
			if (words.some((w) => !w)) {
				err(ln, '`keywords` has an empty entry (expected a comma list of words)');
				return;
			}
			const seen = new Set();
			for (const w of words) {
				if (seen.has(w.toLowerCase())) warn(ln, `\`keywords\` lists "${w}" twice`);
				seen.add(w.toLowerCase());
			}
			h.keywords = words.filter((w, i) => words.findIndex((o) => o.toLowerCase() === w.toLowerCase()) === i);
			return;
		}
		case 'collects': {
			// `collects 2414, 5655`: the items this guide obtains (Lookup opens it for them).
			const ids = rest.split(',').map((w) => w.trim());
			const bad = ids.find((id) => !INT_RE.test(id) || Number(id) <= 0);
			if (bad !== undefined) {
				err(ln, `malformed item id "${bad}" in \`collects\` (expected a comma list of item ids)`);
				return;
			}
			const nums = ids.map(Number);
			if (new Set(nums).size !== nums.length) {
				err(ln, '`collects` names the same item twice');
				return;
			}
			h.collects = nums;
			return;
		}
		case 'reward': {
			// What the guide's goal gives, for the guide menu: `reward item <id>
			// ["Name"] [quality] ...` (several items on one line: a choice of
			// one), `reward spell <id> ["Name"]` or `reward text <words>`.
			const kind = toks[1].quoted ? '' : toks[1].text.toLowerCase();
			let entries;
			if (kind === 'item') {
				const r = readRewardList(toks, 2, 'reward item');
				if (r.error) return err(ln, r.error);
				if (r.next < toks.length) return err(ln, `unexpected "${toks[r.next].text}" in \`reward item\` (expected <itemId> ["Item name"] [quality] ...)`);
				const choice = r.items.length > 1;
				entries = r.items.map((it) => (choice ? { ...it, choice: true } : it));
			} else if (kind === 'spell') {
				const id = toks[2];
				if (!id || id.quoted || !INT_RE.test(id.text) || Number(id.text) <= 0 || toks.length > 4 || (toks[3] && !toks[3].quoted)) {
					return err(ln, 'malformed `reward spell` (expected reward spell <spellId> ["Spell name"])');
				}
				entries = [{ spell: Number(id.text), spellName: toks[3] ? toks[3].text : undefined }];
			} else if (kind === 'text') {
				const text = unquoteRest(line, lex, 2);
				if (!text) return err(ln, '`reward text` needs words');
				entries = [{ text }];
			} else {
				return err(ln, `unknown reward kind "${toks[1].text}" (expected \`reward item\`, \`reward spell\` or \`reward text\`)`);
			}
			(h.reward = h.reward || []).push(...entries.map((e) => ({ ...e, line: ln })));
			(guide.lines.rewards = guide.lines.rewards || []).push(ln);
			return;
		}
		case 'pro':
		case 'con': {
			const key = kw === 'pro' ? 'pros' : 'cons';
			(h[key] = h[key] || []).push(rest);
			(guide.lines[key] = guide.lines[key] || []).push(ln);
			return;
		}
		case 'levels': {
			const m = /^(\d+)\s*-\s*(\d+)$/.exec(rest);
			if (!m || Number(m[1]) < 1 || Number(m[1]) > Number(m[2])) {
				err(ln, `malformed levels "${rest}" (expected <min>-<max>, min ≤ max)`);
				return;
			}
			h.levels = { min: Number(m[1]), max: Number(m[2]) };
			return;
		}
		case 'zone': {
			const spec = parseZoneSpec(line, lex, ln, err);
			if (spec) h.zone = spec;
			return;
		}
		case 'faction': {
			const f = FACTIONS[rest.toLowerCase()];
			if (!f) {
				err(ln, `faction must be Alliance or Horde, not "${rest}"`);
				return;
			}
			h.faction = f;
			return;
		}
		case 'race':
		case 'class': {
			const c = parseConditions(rest.replace(/\s*,\s*/g, ','), kw);
			c.errors.forEach((e) => err(ln, e));
			c.warnings.forEach((w) => warn(ln, w));
			if (!c.errors.length) h[kw === 'race' ? 'races' : 'classes'] = kw === 'race' ? c.value.races : c.value.classes;
			return;
		}
		case 'next': {
			// `next <id>[, <id>...]`: the guides to continue with, in order, the
			// first being the author's default; more than one is a choice of
			// route. `next <id> when <predicate>` (when.js) offers that one guide
			// only while the predicate holds at the hand-off. The line repeats,
			// each adding its guides; a guide is named once.
			const w = toks.findIndex((t, k) => k >= 2 && !t.quoted && t.text.toLowerCase() === 'when');
			const idToks = toks.slice(1, w === -1 ? toks.length : w);
			const idText = w === -1 ? rest : line.slice(idToks[0].start, idToks[idToks.length - 1].end);
			const ids = idText.split(/[\s,]+/).filter(Boolean);
			const bad = idToks.some((t) => t.quoted) ? idText : ids.find((id) => !ID_RE.test(id));
			if (bad !== undefined || !ids.length) {
				err(ln, `malformed guide id "${bad !== undefined ? bad : idText}" in \`next\``);
				return;
			}
			let when = null;
			if (w !== -1) {
				if (ids.length !== 1) {
					err(ln, '`next ... when` names one guide: `next <id> when <predicate>`, one line per guide');
					return;
				}
				const p = parseWhen(toks[w + 1] ? line.slice(toks[w + 1].start, lex.end) : '');
				if (p.error) {
					err(ln, p.error, p.hint);
					return;
				}
				when = { ...p.value, line: ln };
			}
			const all = [...(h.next || []), ...ids];
			if (new Set(all).size !== all.length) {
				err(ln, '`next` names the same guide twice');
				return;
			}
			h.next = all;
			for (const id of ids) (guide.lines.nextOf ||= {})[id] = ln;
			if (when) (h.nextWhen ||= {})[ids[0]] = when;
			return;
		}
		case 'version':
			if (!INT_RE.test(rest)) {
				err(ln, `version must be an integer, not "${rest}"`);
				return;
			}
			h.version = Number(rest);
			return;
		case 'coords': {
			const c = rest.toLowerCase();
			if (c !== 'era' && c !== 'live') {
				err(ln, `coords must be era or live, not "${rest}"`);
				return;
			}
			h.coords = c;
			return;
		}
	}
}

function parseId(tok, what, ln, err) {
	if (!tok || tok.quoted || !INT_RE.test(tok.text) || Number(tok.text) <= 0) {
		err(ln, `malformed ${what} id "${tok ? tok.text : ''}"`);
		return null;
	}
	return Number(tok.text);
}

// Positional arguments per verb. Returns the index of the first modifier
// token, or -1 after reporting an error.
function parsePositional(verb, goal, toks, line, lex, ln, err, spans) {
	let i = 1;
	const t = toks[i];
	const quotedAt = (k) => toks[k] && toks[k].quoted;
	switch (verb) {
		case 'accept':
		case 'turnin':
		case 'complete': {
			if (!t) return err(ln, `\`${verb}\` needs a quest id`), -1;
			goal.quest = parseId(t, 'quest', ln, err);
			if (goal.quest === null) return -1;
			i++;
			if (quotedAt(i)) goal.title = toks[i++].text;
			return i;
		}
		case 'kill': {
			if (!t) return err(ln, '`kill` needs an npc id or "Target name"'), -1;
			if (t.quoted) {
				goal.target = t.text;
				return i + 1;
			}
			goal.npc = parseId(t, 'npc', ln, err);
			if (goal.npc === null) return -1;
			i++;
			if (quotedAt(i)) goal.target = toks[i++].text;
			return i;
		}
		case 'collect':
		case 'use':
		case 'buy': {
			if (!t) return err(ln, `\`${verb}\` needs an item id`), -1;
			goal.item = parseId(t, 'item', ln, err);
			if (goal.item === null) return -1;
			i++;
			if (quotedAt(i)) goal.itemName = toks[i++].text;
			return i;
		}
		case 'talk': {
			if (!t) return err(ln, '`talk` needs an npc id'), -1;
			goal.npc = parseId(t, 'npc', ln, err);
			if (goal.npc === null) return -1;
			i++;
			if (quotedAt(i)) goal.npcName = toks[i++].text;
			return i;
		}
		case 'interact': {
			if (!t) return err(ln, '`interact` needs an object id'), -1;
			goal.object = parseId(t, 'object', ln, err);
			if (goal.object === null) return -1;
			i++;
			if (quotedAt(i)) goal.objName = toks[i++].text;
			return i;
		}
		case 'train':
		case 'vendor': {
			if (t && !t.quoted && INT_RE.test(t.text)) {
				goal.npc = parseId(t, 'npc', ln, err);
				if (goal.npc === null) return -1;
				i++;
				if (quotedAt(i)) goal.npcName = toks[i++].text;
				return i;
			}
			if (verb === 'vendor') {
				if (t && !t.quoted && t.text.toLowerCase() === 'nearest') {
					goal.nearest = true;
					return i + 1;
				}
				return i;
			}
			if (t && !t.quoted && t.text.toLowerCase() === 'class') {
				goal.classTrain = true;
				return i + 1;
			}
			// `train <Profession> [Rank]`: words up to the first modifier.
			const words = [];
			while (i < toks.length && !isModifierToken(toks[i])) words.push(toks[i++].text);
			if (words.length) {
				const last = words[words.length - 1].toLowerCase();
				if (words.length > 1 && RANKS.includes(last)) {
					goal.rank = RANKS.indexOf(last) + 1;
					words.pop();
				}
				goal.profession = words.join(' ');
			}
			return i;
		}
		case 'goto': {
			if (!t || t.quoted) return err(ln, '`goto` needs coordinates x,y'), -1;
			const c = readCoords(toks, i, t.text);
			if (c.error) return err(ln, c.error), -1;
			goal.x = c.x;
			goal.y = c.y;
			goal.explicitCoords = true;
			i = c.next;
			spans.coords = [toks[1].start, toks[i - 1].end];
			if (quotedAt(i)) goal.text = toks[i++].text;
			return i;
		}
		case 'sethome':
		case 'hearth':
		case 'getfp':
		case 'fly': {
			if (!t) return err(ln, `\`${verb}\` needs a "Location"${verb === 'sethome' ? ' or `nearest`' : ''}`), -1;
			if (verb === 'sethome' && !t.quoted && t.text.toLowerCase() === 'nearest') {
				goal.nearest = true;
				return i + 1;
			}
			goal.location = t.text;
			if (!goal.location) return err(ln, `\`${verb}\` needs a non-empty location`), -1;
			return i + 1;
		}
		case 'level': {
			// `level 12`, `level 12.5` (halfway through 12) or `level 12+2500`
			// (2500 XP into 12): level, frac and the XP as written (levelXp).
			const p = t && !t.quoted ? levelPoint(t.text) : null;
			if (p && p.error) return err(ln, p.error), -1;
			if (!p || p.level < 1) return err(ln, `malformed level "${t ? t.text : ''}"`), -1;
			goal.level = p.level;
			if (p.frac) goal.frac = p.frac;
			if (p.xp !== undefined) goal.levelXp = p.xp;
			return i + 1;
		}
		case 'money': {
			const v = t && !t.quoted ? readMoney(t.text) : null;
			if (v === null || v <= 0) return err(ln, `malformed amount "${t ? t.text : ''}" (expected copper or 1g50s / 7s / 25c)`, '`money` needs an amount: money <amount>'), -1;
			goal.money = v;
			return i + 1;
		}
		case 'task': {
			if (!t) return err(ln, '`task` needs text: task "<what to do>"'), -1;
			if (t.quoted) {
				goal.text = t.text;
				return i + 1;
			}
			goal.text = line.slice(t.start, lex.end).trim();
			return toks.length;
		}
		case 'note': {
			if (!t) return err(ln, '`note` needs text'), -1;
			if (t.quoted) {
				goal.text = t.text;
				return i + 1;
			}
			goal.text = line.slice(t.start, lex.end).trim();
			return toks.length;
		}
		case 'skill': {
			const usage = '`skill` needs a profession and a rank: skill <Profession> <N>';
			if (!t) return err(ln, usage), -1;
			if (t.quoted) {
				goal.skill = t.text;
				goal.skillQuoted = true;
				i++;
			} else {
				const w = wordsUntil(toks, i, (tk) => INT_RE.test(tk.text));
				goal.skill = w.text;
				i = w.next;
			}
			const n = toks[i];
			if (!goal.skill || !n || n.quoted || !INT_RE.test(n.text) || Number(n.text) < 1) return err(ln, goal.skill && n && !n.quoted && /^\d/.test(n.text) ? `malformed skill rank "${n.text}"` : usage), -1;
			goal.level = Number(n.text);
			return i + 1;
		}
		case 'learn':
		case 'craft': {
			if (!t) return err(ln, `\`${verb}\` needs a spell id`), -1;
			goal.spell = parseId(t, 'spell', ln, err);
			if (goal.spell === null) return -1;
			i++;
			if (quotedAt(i)) goal.spellName = toks[i++].text;
			return i;
		}
		case 'rep': {
			const usage = '`rep` needs a faction and a standing: rep <Faction> <Standing> or rep <factionId> <Standing>';
			if (!t) return err(ln, usage), -1;
			if (!t.quoted && INT_RE.test(t.text)) {
				goal.factionId = parseId(t, 'faction', ln, err);
				if (goal.factionId === null) return -1;
				i++;
				if (quotedAt(i)) goal.factionName = toks[i++].text;
			} else if (t.quoted) {
				goal.factionName = t.text;
				goal.factionQuoted = true;
				i++;
			} else {
				const w = wordsUntil(toks, i, (tk) => readStanding(tk) !== null);
				goal.factionName = w.text;
				i = w.next;
			}
			if (goal.factionId === undefined && !goal.factionName) return err(ln, usage), -1;
			const s = readStanding(toks[i]);
			if (!s) return err(ln, toks[i] ? `unknown standing "${toks[i].text}" (Hated, Hostile, Unfriendly, Neutral, Friendly, Honored, Revered, Exalted, or 1-8)` : usage), -1;
			if (s.error) return err(ln, s.error), -1;
			goal.standing = s.value;
			return i + 1;
		}
		case 'explore': {
			if (!t || t.quoted) return err(ln, '`explore` needs coordinates x,y'), -1;
			const c = readCoords(toks, i, t.text);
			if (c.error) return err(ln, c.error), -1;
			goal.x = c.x;
			goal.y = c.y;
			goal.explicitCoords = true;
			i = c.next;
			spans.coords = [toks[1].start, toks[i - 1].end];
			if (quotedAt(i)) goal.text = toks[i++].text;
			return i;
		}
		case 'achieve': {
			if (!t) return err(ln, '`achieve` needs an achievement id'), -1;
			goal.achievement = parseId(t, 'achievement', ln, err);
			if (goal.achievement === null) return -1;
			i++;
			if (quotedAt(i)) goal.achievementName = toks[i++].text;
			return i;
		}
	}
	return i;
}

function parseGoal(verb, line, lex, ln, err, warn) {
	const toks = lex.tokens;
	const goal = { line: ln, verb };
	const contentEnd = line.replace(/\s+$/, '').length;
	const tail = lex.end < contentEnd ? [lex.end, contentEnd] : null;
	const spans = { verb: [toks[0].start, toks[0].end], positional: null, coords: null, mods: [], note: lex.note !== null ? tail : null, comment: lex.note === null ? tail : null };
	if (lex.note !== null) {
		if (!lex.note) return err(ln, 'empty ` -- ` note'), null;
		goal.note = lex.note;
	}
	let i = parsePositional(verb, goal, toks, line, lex, ln, err, spans);
	if (i < 0) return null;
	if (i > 1) spans.positional = [toks[1].start, toks[i - 1].end];
	// The modifier being read (named by `use`) and its first token.
	let cur = null;
	let curStart = i;
	const flush = () => {
		if (!cur) return;
		const span = { mod: cur, start: toks[curStart].start, end: toks[i - 1].end };
		if (cur === 'only') span.text = line.slice(toks[curStart + 1].start, span.end);
		if (cur === 'at') spans.coords = [span.start, span.end];
		spans.mods.push(span);
		cur = null;
	};
	const allowed = MODS[verb];
	const seen = new Set();
	const use = (mod) => {
		if (!allowed.includes(mod)) {
			err(ln, `\`${MOD_LABEL[mod] || mod}\` does not apply to \`${verb}\``);
			return false;
		}
		if (seen.has(mod)) {
			err(ln, `duplicate \`${MOD_LABEL[mod] || mod}\``);
			return false;
		}
		seen.add(mod);
		cur = mod;
		return true;
	};
	const intArg = (k, what) => {
		const tok = toks[k];
		if (!tok || tok.quoted || !INT_RE.test(tok.text) || Number(tok.text) <= 0) {
			err(ln, `malformed ${what} "${tok ? tok.text : ''}"`);
			return null;
		}
		return Number(tok.text);
	};
	let ok = true;
	while (i < toks.length && ok) {
		flush();
		curStart = i;
		const tok = toks[i];
		if (tok.quoted) {
			if (!use('text')) return null;
			if (goal.text !== undefined) {
				err(ln, 'duplicate `"text"`');
				return null;
			}
			goal.text = tok.text;
			i++;
			continue;
		}
		const word = tok.text.toLowerCase();
		if (word.startsWith('@')) {
			if (!use('at')) return null;
			const c = readCoords(toks, i, tok.text.slice(1));
			if (c.error) return err(ln, c.error), null;
			goal.x = c.x;
			goal.y = c.y;
			goal.explicitCoords = true;
			i = c.next;
			continue;
		}
		const cm = /^x(\d+)$/.exec(word);
		if (cm) {
			if (!use('count')) return null;
			if (Number(cm[1]) <= 0) return err(ln, `malformed count "${tok.text}"`), null;
			goal.count = Number(cm[1]);
			i++;
			continue;
		}
		switch (word) {
			case 'map': {
				if (!use('map')) return null;
				const v = intArg(i + 1, 'map id');
				if (v === null) return null;
				goal.coordMap = v;
				i += 2;
				continue;
			}
			case 'npc':
			case 'object':
			case 'item': {
				if (!use(word)) return null;
				if (goal[word] !== undefined) return err(ln, `\`${word}\` already given positionally`), null;
				const v = intArg(i + 1, `${word} id`);
				if (v === null) return null;
				goal[word] = v;
				goal[`${word}Explicit`] = true;
				i += 2;
				continue;
			}
			case 'quest': {
				if (!use('quest')) return null;
				const q = toks[i + 1];
				const m = q && !q.quoted ? /^(\d+)(?:\.(\d+))?$/.exec(q.text) : null;
				if (!m || Number(m[1]) <= 0 || (m[2] !== undefined && Number(m[2]) <= 0)) {
					return err(ln, `malformed quest link "${q ? q.text : ''}" (expected <id> or <id>.<objective>)`), null;
				}
				goal.quest = Number(m[1]);
				if (m[2] !== undefined) goal.oi = Number(m[2]);
				i += 2;
				continue;
			}
			case 'r': {
				if (!use('r')) return null;
				const tk = toks[i + 1];
				if (!tk || tk.quoted || !NUM_RE.test(tk.text) || Number(tk.text) <= 0) {
					return err(ln, `malformed radius "${tk ? tk.text : ''}" (yards > 0)`), null;
				}
				goal.r = Number(tk.text);
				i += 2;
				continue;
			}
			case 'lvl': {
				if (!use('lvl')) return null;
				const v = intArg(i + 1, 'level');
				if (v === null) return null;
				goal.minLevel = v;
				i += 2;
				continue;
			}
			case 'reward':
			case 'choose': {
				if (!use(word)) return null;
				const r = readRewardList(toks, i + 1, word);
				if (r.error) return err(ln, r.error), null;
				goal[word === 'reward' ? 'rewardItems' : 'rewardChoices'] = r.items;
				i = r.next;
				continue;
			}
			case 'xp': {
				if (!use('xp')) return null;
				const v = intArg(i + 1, 'xp amount');
				if (v === null) return null;
				goal.rewardXp = v;
				i += 2;
				continue;
			}
			case 'money': {
				if (!use('money')) return null;
				const tk = toks[i + 1];
				const v = tk && !tk.quoted ? readMoney(tk.text) : null;
				if (!v) return err(ln, `malformed money "${tk ? tk.text : ''}" (copper, or e.g. 1g50s, 7s)`), null;
				goal.rewardMoney = v;
				i += 2;
				continue;
			}
			case 'until':
			case 'criteria': {
				if (!use(word)) return null;
				const v = intArg(i + 1, word === 'until' ? 'skill rank' : 'criterion index');
				if (v === null) return null;
				goal[word === 'until' ? 'untilSkill' : 'criteria'] = v;
				i += 2;
				continue;
			}
			case 'era':
			case 'live':
				if (!use('frame')) return null;
				goal.frame = word;
				i++;
				continue;
			case 'nearest':
				if (!use('nearest')) return null;
				goal.nearest = true;
				i++;
				continue;
			case 'optional':
				if (!use('optional')) return null;
				goal.optional = true;
				i++;
				continue;
			case 'direct':
				if (!use('direct')) return null;
				goal.direct = true;
				i++;
				continue;
			case 'group': {
				if (!use('group')) return null;
				// The size is optional: a next token that starts like a number is one.
				const tk = toks[i + 1];
				if (tk && !tk.quoted && /^[-+.\d]/.test(tk.text)) {
					const n = INT_RE.test(tk.text) ? Number(tk.text) : NaN;
					if (!(n >= GROUP_MIN && n <= GROUP_MAX)) {
						return err(ln, `malformed group size "${tk.text}" (${GROUP_MIN} to ${GROUP_MAX} players)`), null;
					}
					goal.group = { size: n };
					i += 2;
				} else {
					goal.group = {};
					i++;
				}
				continue;
			}
			case 'only': {
				if (!use('only')) return null;
				let list = '';
				let k = i + 1;
				// Take one token, plus more while the list is visibly continued by commas.
				while (k < toks.length && !toks[k].quoted) {
					list += toks[k].text;
					k++;
					if (!(list.endsWith(',') || (toks[k] && !toks[k].quoted && toks[k].text.startsWith(',')))) break;
				}
				if (!list) return err(ln, '`only` needs a condition list'), null;
				const c = parseConditions(list, 'any');
				c.errors.forEach((e) => err(ln, e));
				c.warnings.forEach((w) => warn(ln, w));
				if (c.errors.length) return null;
				goal.only = c.value;
				i = k;
				continue;
			}
		}
		err(ln, MOD_WORDS.includes(word) ? `\`${word}\` does not apply to \`${verb}\`` : `unknown modifier "${tok.text}"`);
		ok = false;
	}
	if (!ok) return null;
	flush();
	if (goal.count !== undefined && goal.untilSkill !== undefined) return err(ln, 'use either `xN` or `until <N>`, not both'), null;
	if (goal.nearest && goal.npc !== undefined) return err(ln, '`nearest` picks the NPC at runtime; drop `npc`, or drop `nearest` to keep that NPC'), null;
	if (goal.classTrain && goal.npc !== undefined) return err(ln, '`train class` picks the trainer at runtime; drop `npc`'), null;
	Object.defineProperty(goal, 'spans', { value: spans, enumerable: false, writable: true, configurable: true });
	return goal;
}

module.exports = { parseGuide, VERBS, MODS, MOD_WORDS, HEADER_KEYS, STEP_KEYS, ID_RE, RANKS, QUALITIES, STANDINGS };
