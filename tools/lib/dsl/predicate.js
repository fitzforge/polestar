'use strict';
// tools/lib/dsl/predicate.js: the `when` expression language of format-2
// guides, parsed from lexer tokens into the closed predicate AST that
// addon/Polestar/Core/Predicate.lua evaluates.
// Names that need data (professions, factions) stay as strings here; the
// resolver turns them into ids later.

const { parseConditions } = require('./conditions');

// Grammar keywords, matched case-insensitively on the token text.
const KEYWORDS = new Set(['onquest', 'ready', 'turnedin', 'has', 'level', 'skill', 'rep', 'zone', 'not', 'and', 'or']);
const ATOM_KEYWORDS = new Set(['onquest', 'ready', 'turnedin', 'has', 'level', 'skill', 'rep', 'zone']);
const OPERATORS = new Set(['>=', '>', '<=', '<', '==', '!=']);
// Reputation standings as the client numbers them (1 Hated .. 8 Exalted).
const STANDINGS = { hated: 1, hostile: 2, unfriendly: 3, neutral: 4, friendly: 5, honored: 6, revered: 7, exalted: 8 };
const INT_RE = /^\d+$/;
const COUNT_RE = /^x\d+$/i;

// The lowercased keyword of an unquoted token (quoted tokens have none).
function word(tok) {
	return tok && !tok.quoted ? tok.text.toLowerCase() : null;
}

// Stop at the first error: every failure throws and is caught by
// parsePredicate, so no partial AST is ever returned.
function fail(message) {
	throw new Error(message);
}

// Unquoted tokens are split on whitespace only, so "(onquest" and "7)"
// arrive whole. Peel leading "(" and trailing ")" off them into single-char
// tokens; quoted tokens pass through untouched.
function splitParens(tokens) {
	const out = [];
	for (const t of tokens) {
		if (t.quoted) {
			out.push(t);
			continue;
		}
		const open = (t.text.match(/^\(+/) || [''])[0];
		const close = (t.text.match(/\)+$/) || [''])[0];
		const body = t.text.slice(open.length, t.text.length - close.length);
		for (let k = 0; k < open.length; k++) out.push({ text: '(', quoted: false });
		if (body) out.push({ text: body, quoted: false });
		for (let k = 0; k < close.length; k++) out.push({ text: ')', quoted: false });
	}
	return out;
}

// expr := and ( 'or' and )*   — one child returns it bare, several become 'any'.
function parseExpr(s) {
	const parts = [parseAnd(s)];
	while (word(peek(s)) === 'or') {
		s.i++;
		parts.push(parseAnd(s));
	}
	return parts.length === 1 ? parts[0] : ['any', ...parts];
}

// and := unary ( 'and' unary )* — same single-child rule as expr.
function parseAnd(s) {
	const parts = [parseUnary(s)];
	while (word(peek(s)) === 'and') {
		s.i++;
		parts.push(parseUnary(s));
	}
	return parts.length === 1 ? parts[0] : ['all', ...parts];
}

// unary := 'not' unary | '(' expr ')' | atom. Parentheses only group, so the
// inner node is returned without a wrapper.
function parseUnary(s) {
	const tok = peek(s);
	if (!tok) fail('expected a condition');
	if (word(tok) === 'not') {
		s.i++;
		return ['not', parseUnary(s)];
	}
	if (tok.text === '(') {
		s.i++;
		const inner = parseExpr(s);
		const close = peek(s);
		if (!close) fail('missing ")"');
		if (close.text !== ')') fail(`missing ")" before "${close.text}"`);
		s.i++;
		return inner;
	}
	return parseAtom(s);
}

function peek(s) {
	return s.i < s.toks.length ? s.toks[s.i] : null;
}

// atom := quest atom | item atom | comparison atom | zone atom | character list.
function parseAtom(s) {
	const tok = peek(s);
	if (!tok) fail('expected a condition');
	if (tok.quoted) fail(`expected a condition, got the quoted "${tok.text}"`);
	const w = word(tok);
	if (tok.text === ')') fail('expected a condition before ")"');
	if (!ATOM_KEYWORDS.has(w)) return parseCharacterList(s); // not a keyword: a Warrior/Dwarf/Alliance list
	s.i++;
	switch (w) {
		case 'onquest':
		case 'ready':
		case 'turnedin':
			return [w, readPositiveInt(s, 'quest id')];
		case 'has': {
			const item = readPositiveInt(s, 'item id');
			let count = 1;
			const tok2 = peek(s);
			if (tok2 && !tok2.quoted && COUNT_RE.test(tok2.text)) {
				s.i++;
				count = Number(tok2.text.slice(1));
				if (count < 1) fail(`count must be at least 1 ("${tok2.text}")`);
			}
			return ['item', item, '>=', count];
		}
		case 'level':
			return ['level', readOperator(s, 'level'), readNumber(s, 'level')];
		case 'skill':
			return ['skill', readName(s, 'profession'), readOperator(s, 'skill'), readNumber(s, 'skill')];
		case 'rep':
			return ['rep', readName(s, 'faction'), readOperator(s, 'rep'), readStanding(s)];
		default: {
			const tok2 = peek(s);
			if (!tok2) fail('expected a zone name');
			if (!tok2.quoted) fail(`zone needs a quoted zone name ("${tok2.text}")`);
			s.i++;
			return ['zone', tok2.text];
		}
	}
}

// A bare word list like "Warrior" or "Dwarf,Paladin" reuses the `only`
// condition parser; anything it cannot name is not a condition here.
function parseCharacterList(s) {
	const tok = s.toks[s.i++];
	const r = parseConditions(tok.text, 'any');
	if (r.errors.length || r.warnings.length) fail(`unknown condition "${tok.text}"`);
	const nodes = [];
	if (r.value.classes) nodes.push(['class', r.value.classes]);
	if (r.value.races) nodes.push(['race', r.value.races]);
	if (r.value.factions) {
		if (r.value.factions.length === 1) nodes.push(['faction', r.value.factions[0]]);
		else nodes.push(['any', ...r.value.factions.map((f) => ['faction', f])]);
	}
	if (!nodes.length) fail(`unknown condition "${tok.text}"`);
	return nodes.length === 1 ? nodes[0] : ['all', ...nodes];
}

// A positive integer token (quest and item ids).
function readPositiveInt(s, what) {
	const tok = peek(s);
	if (!tok) fail(`expected a positive ${what}`);
	if (tok.quoted || !INT_RE.test(tok.text) || Number(tok.text) < 1) fail(`${what} must be a positive integer ("${tok.text}")`);
	s.i++;
	return Number(tok.text);
}

// A name: one quoted token, a purely numeric id, or words up to the operator
// (keywords and parens also stop the name so "skill Mining and level >= 5"
// reads as skill "Mining", not a name containing "and").
function readName(s, what) {
	const tok = peek(s);
	if (!tok) fail(`expected a ${what} name`);
	if (tok.quoted) {
		s.i++;
		return tok.text;
	}
	if (INT_RE.test(tok.text)) {
		s.i++;
		return Number(tok.text);
	}
	const words = [];
	while (s.i < s.toks.length) {
		const t = s.toks[s.i];
		if (t.quoted || OPERATORS.has(t.text) || KEYWORDS.has(word(t)) || t.text === '(' || t.text === ')') break;
		words.push(t.text);
		s.i++;
	}
	if (!words.length) fail(`expected a ${what} name`);
	return words.join(' ');
}

function readOperator(s, what) {
	const tok = peek(s);
	if (!tok) fail(`expected an operator after ${what}`);
	if (tok.quoted || !OPERATORS.has(tok.text)) fail(`${what} needs an operator (>=, >, <=, <, ==, !=), got "${tok.text}"`);
	s.i++;
	return tok.text === '!=' ? '~=' : tok.text; // Lua has no !=
}

// A non-negative integer token (level and skill values).
function readNumber(s, what) {
	const tok = peek(s);
	if (!tok) fail(`expected a number after ${what}`);
	if (tok.quoted || !INT_RE.test(tok.text)) fail(`${what} needs a number, got "${tok.text}"`);
	s.i++;
	return Number(tok.text);
}

function readStanding(s) {
	const tok = peek(s);
	if (!tok) fail('expected a standing');
	if (!tok.quoted) {
		const w = word(tok);
		if (STANDINGS[w]) {
			s.i++;
			return STANDINGS[w];
		}
		if (INT_RE.test(tok.text)) {
			const n = Number(tok.text);
			if (n >= 1 && n <= 8) {
				s.i++;
				return n;
			}
		}
	}
	fail(`expected a standing (Hated..Exalted or 1-8), got "${tok.text}"`);
}

function parsePredicate(tokens) {
	if (!tokens.length) return { value: null, errors: ['empty when expression'] };
	const s = { toks: splitParens(tokens), i: 0 };
	if (!s.toks.length) return { value: null, errors: ['empty when expression'] };
	let value;
	try {
		value = parseExpr(s);
		if (s.i < s.toks.length) fail(`unexpected "${s.toks[s.i].text}"`);
	} catch (e) {
		return { value: null, errors: [e.message] };
	}
	return { value, errors: [] };
}

// The AST as a Lua table literal. luaString is required inside the function
// because emit may later require this module (a top-level require would be
// circular).
function toLua(ast) {
	const { luaString } = require('./emit');
	if (Array.isArray(ast)) return '{ ' + ast.map(toLua).join(', ') + ' }';
	if (typeof ast === 'number') return String(ast);
	return luaString(ast);
}

module.exports = { parsePredicate, toLua };
