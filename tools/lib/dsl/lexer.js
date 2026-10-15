'use strict';
// Line lexer for the .guide format (docs/GUIDE_FORMAT.md, "Lexical rules").
//
// lexLine(text) -> { tokens, note, end, error }
//   tokens: [{ text, quoted, start, end }]  (start/end are offsets into text)
//   note:   text after ` -- ` (trimmed) or null
//   end:    offset where the line's content stops (comment or note start)
//   error:  message for the first lexical error, or null
//
// `#` starts a comment at line start or after whitespace, outside quotes.
// ` -- ` (whitespace, two dashes, whitespace) starts a player-facing note;
// the rest of the line is the note verbatim. Quoted tokens support `\"` and
// `\\` escapes only.

function isSpace(c) {
	return c === ' ' || c === '\t';
}

function lexLine(text) {
	const tokens = [];
	let note = null;
	let end = text.length;
	let i = 0;
	const n = text.length;
	while (i < n) {
		const c = text[i];
		if (isSpace(c)) {
			i++;
			continue;
		}
		// Here i is the start of a token, preceded by whitespace or line start.
		if (c === '#') {
			end = i;
			break;
		}
		if (c === '-' && text[i + 1] === '-' && (i + 2 === n || isSpace(text[i + 2]))) {
			end = i;
			note = text.slice(i + 2).trim();
			break;
		}
		if (c === '"') {
			let value = '';
			let j = i + 1;
			let closed = false;
			while (j < n) {
				const d = text[j];
				if (d === '\\') {
					const e = text[j + 1];
					if (e === '"' || e === '\\') {
						value += e;
						j += 2;
						continue;
					}
					return { tokens, note, end, error: e === undefined ? 'unterminated string' : `unknown escape \\${e} in string (only \\" and \\\\ are allowed)` };
				}
				if (d === '"') {
					closed = true;
					break;
				}
				value += d;
				j++;
			}
			if (!closed) return { tokens, note, end, error: 'unterminated string' };
			// Closing parentheses may follow a quote directly: `(zone "Duskwood")`.
			let k = j + 1;
			while (k < n && text[k] === ')') k++;
			if (k < n && !isSpace(text[k])) {
				return { tokens, note, end, error: `unexpected "${text[k]}" after closing quote` };
			}
			tokens.push({ text: value, quoted: true, start: i, end: j + 1 });
			if (k > j + 1) tokens.push({ text: text.slice(j + 1, k), quoted: false, start: j + 1, end: k });
			i = k;
			continue;
		}
		let j = i;
		while (j < n && !isSpace(text[j])) {
			if (text[j] === '"') return { tokens, note, end, error: 'a quote must start a new token' };
			j++;
		}
		tokens.push({ text: text.slice(i, j), quoted: false, start: i, end: j });
		i = j;
	}
	return { tokens, note, end, error: null };
}

module.exports = { lexLine };
