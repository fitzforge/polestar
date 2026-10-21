'use strict';
// `when` on a step (docs/GUIDE_FORMAT.md, "Conditions checked during play"):
// the step applies only while each of its predicates holds when the route
// reaches it. The addon checks them (addon/Polestar/Core/Engine.lua,
// Own.whenFails) and keeps the outcome once the route has moved past the step.
//
// parseWhen(rest) -> { value } | { error }
//   rest: the line after `when`, as written. One predicate per `when` line:
//   level<N  level<=N  level>N  level>=N     the character's level; N may be a
//                                             point inside a level: 12.5, 12+2500
//   [!]onquest <quest>[,<quest>...]           any of the quests is in the log (! none is)
//   [!]complete <quest>                       the quest is in the log, ready to turn in
//   [!]turnedin <quest>                       the quest is handed in
//   [!]available <quest>                      the quest can be taken now
//   [!]has <item> [xN]                        the bags hold N (default 1) or more
//   [!]upgrade <item>                         Polestar's gear advice rates the item an upgrade
//   [!]zone "<Name>"  [!]subzone "<Name>"     the zone or subzone text reads so
//   [!]bound "<Location>"                     the hearthstone is bound there
//   [!]dungeon "<Name>"                       the player chose to run that dungeon
//   money<A  money<=A  money>A  money>=A     the character's money; A as copper or 1g50s / 7s / 25c
//   [!]done <label>                           the step so labelled was completed, not skipped
//   [!]skill <Profession> <N>                 the profession's skill rank is N or more
//   [!]cooldown item <item>                   the item (or spell) is on cooldown, the global
//   [!]cooldown spell <spell>                 cooldown aside
//   [!]group <quest>                          the player chose to do that group quest (! to skip it);
//                                             the route waits at the step until they answer
// value = { k, neg?, op?, n?, frac?, q?, item?, spell?, name?, label? }; `q` is a list for onquest.

const { levelPoint } = require('../game/xp');
const { readMoney } = require('./money');

const INT_RE = /^\d+$/;
const KINDS = ['level', 'money', 'onquest', 'complete', 'turnedin', 'available', 'has', 'upgrade', 'zone', 'subzone', 'bound', 'dungeon', 'done', 'skill', 'cooldown', 'group'];
// A step label, as parse.js reads `label <name>`.
const LABEL_RE = /^[A-Za-z0-9_-]+$/;
const QUEST_ONE = new Set(['complete', 'turnedin', 'available', 'group']);
const PLACE = new Set(['zone', 'subzone', 'bound']);
const USAGE = `predicates: level<N, level>=N, money>=1s, [!]onquest <quest>, [!]complete <quest>, [!]turnedin <quest>, [!]available <quest>, [!]has <item> [xN], [!]upgrade <item>, [!]zone "<Name>", [!]subzone "<Name>", [!]bound "<Location>", [!]dungeon "<Name>", [!]done <label>, [!]skill <Profession> <N>, [!]cooldown item <item>, [!]cooldown spell <spell>, [!]group <quest>`;

// A name written quoted or bare: `"Razor Hill"` or `Razor Hill`.
function nameOf(text) {
	const t = text.trim();
	const q = /^"((?:[^"\\]|\\.)*)"$/.exec(t);
	if (q) return q[1].replace(/\\(["\\])/g, '$1').trim();
	return t.includes('"') ? null : t;
}

function parseWhen(rest) {
	const text = String(rest || '').trim();
	if (!text) return { error: '`when` needs a predicate', hint: USAGE };
	const lv = /^(!?)level\s*(<=|>=|<|>)\s*(\d+(?:\.\d+|\+\d+)?)$/i.exec(text);
	if (lv) {
		if (lv[1]) return { error: '`level` takes no `!`: turn the comparison around (`level>=10` for "not below 10")' };
		const p = levelPoint(lv[3]);
		if (p.error) return { error: p.error };
		if (p.level < 1 || p.level > 60) return { error: `level ${p.level} is out of range (1-60)` };
		const value = { k: 'level', op: lv[2], n: p.level };
		if (p.frac) value.frac = p.frac;
		return { value };
	}
	const mo = /^(!?)money\s*(<=|>=|<|>)\s*(\S+)$/i.exec(text);
	if (mo) {
		if (mo[1]) return { error: '`money` takes no `!`: turn the comparison around (`money<1s` for "not 1s or more")' };
		const n = readMoney(mo[3]);
		if (n === null) return { error: `malformed amount "${mo[3]}" (expected copper or 1g50s / 7s / 25c)` };
		return { value: { k: 'money', op: mo[2], n } };
	}
	const m = /^(!?)([A-Za-z]+)\b\s*(.*)$/.exec(text);
	const kind = m ? m[2].toLowerCase() : null;
	if (!kind || !KINDS.includes(kind)) return { error: `unknown \`when\` predicate "${text.split(/\s+/)[0]}"`, hint: USAGE };
	const neg = m[1] === '!';
	const args = m[3].trim();
	const value = { k: kind };
	if (neg) value.neg = true;
	if (kind === 'level') return { error: 'malformed `level` predicate (expected level<N, level<=N, level>N or level>=N)' };
	if (kind === 'money') return { error: 'malformed `money` predicate (expected money<A, money<=A, money>A or money>=A, A as copper or 1g50s / 7s / 25c)' };
	if (kind === 'onquest') {
		const ids = args.split(/\s*,\s*|\s+/).filter(Boolean);
		if (!ids.length || !ids.every((id) => INT_RE.test(id) && Number(id) > 0)) return { error: '`onquest` needs quest ids: onquest <quest>[,<quest>...]' };
		value.q = [...new Set(ids.map(Number))];
		return { value };
	}
	if (QUEST_ONE.has(kind)) {
		if (!INT_RE.test(args) || Number(args) <= 0) return { error: `\`${kind}\` needs one quest id: ${kind} <quest>` };
		value.q = Number(args);
		return { value };
	}
	if (kind === 'has') {
		const h = /^(\d+)(?:\s+x(\d+))?$/i.exec(args);
		if (!h || Number(h[1]) <= 0) return { error: '`has` needs an item id: has <item> [xN]' };
		value.item = Number(h[1]);
		const n = h[2] !== undefined ? Number(h[2]) : 1;
		if (n < 1) return { error: '`has` needs a count of 1 or more' };
		value.n = n;
		return { value };
	}
	if (kind === 'upgrade') {
		if (!INT_RE.test(args) || Number(args) <= 0) return { error: '`upgrade` needs one item id: upgrade <item>' };
		value.item = Number(args);
		return { value };
	}
	if (kind === 'done') {
		if (!LABEL_RE.test(args)) return { error: '`done` needs a step label: done <label>' };
		value.label = args;
		return { value };
	}
	if (kind === 'skill') {
		const s = /^(?:"((?:[^"\\]|\\.)*)"|([^"]+?))\s+(\d+)$/.exec(args);
		const name = s && (s[1] !== undefined ? s[1].replace(/\\(["\\])/g, '$1') : s[2]).trim();
		if (!name || Number(s[3]) < 1) return { error: '`skill` needs a profession and a rank of 1 or more: skill <Profession> <N>' };
		value.name = name;
		value.n = Number(s[3]);
		return { value };
	}
	if (kind === 'cooldown') {
		const c = /^(item|spell)\s+(\d+)$/i.exec(args);
		if (!c || Number(c[2]) <= 0) return { error: '`cooldown` needs an item or spell id: cooldown item <item> or cooldown spell <spell>' };
		value[c[1].toLowerCase()] = Number(c[2]);
		return { value };
	}
	// zone, subzone, bound, dungeon
	const name = nameOf(args);
	if (!name) return { error: `\`${kind}\` needs a name: ${kind} "<${kind === 'bound' ? 'Location' : 'Name'}>"` };
	value.name = name;
	return { value };
}

// The levels a `level` predicate admits, as [min, max]. With `frac` the
// predicate splits level n, so both sides admit it.
function levelRange(p) {
	if (p.frac) return p.op === '<' || p.op === '<=' ? [1, p.n] : [p.n, 60];
	if (p.op === '<') return [1, p.n - 1];
	if (p.op === '<=') return [1, p.n];
	if (p.op === '>') return [p.n + 1, 60];
	return [p.n, 60];
}

module.exports = { parseWhen, levelRange, PLACE, KINDS };
