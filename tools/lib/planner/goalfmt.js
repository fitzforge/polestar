'use strict';
// Goal fields <-> goal line text, and the verb schema the planner's goal
// editor is built from (docs/ARCHITECTURE.md, "Route planner").
//
// goalFields(goal)              -> fields: the parse output (tools/lib/dsl/parse.js) minus
//                                  `line`/`zone`, `only` replaced by `onlyText` (the condition list as written)
// formatGoal(fields)            -> the canonical goal line, without indent; parsing it gives the same goal
//                                  (throws an Error for fields no line can express)
// parseGoalLine(text)           -> { goal | null, errors: [message] }: one goal line parsed on its own
// verbSchema()                  -> { verbs: { <verb>: { positional: [field], modifiers: [field], note: field } } }
//                                  field = { key, type, label, required?, kind?, values?, mod?, keys? }
// formatCoord(v, yardsPerPercent) -> '39.5': one decimal, two when one would move the point
//                                  more than 4 yards (no yardsPerPercent: up to two)

const { isDeepStrictEqual } = require('node:util');
const { lexLine } = require('../dsl/lexer');
const { parseGuide, MODS, MOD_WORDS, RANKS, QUALITIES, STANDINGS } = require('../dsl/parse');
const { parseConditions } = require('../dsl/conditions');
const { Diagnostics } = require('../dsl/diag');

const STANDING_NAMES = Object.keys(STANDINGS);
const cap = (w) => w.charAt(0).toUpperCase() + w.slice(1);

// Fields the parser derives from how a line is written; a caller may leave them out.
const DERIVED = ['explicitCoords', 'npcExplicit', 'objectExplicit', 'itemExplicit', 'skillQuoted', 'factionQuoted'];
const NUMERIC = ['quest', 'oi', 'npc', 'object', 'item', 'x', 'y', 'coordMap', 'r', 'count', 'minLevel', 'untilSkill', 'criteria', 'rewardXp', 'rewardMoney', 'level', 'spell', 'factionId', 'standing', 'achievement', 'rank'];
const NUM_TEXT = /^-?\d+(?:\.\d+)?$/;

// Verbs whose positional arguments include the key (written there unless `<key>Explicit`).
const POSITIONAL_ID = {
	npc: ['kill', 'talk', 'train', 'vendor'],
	object: ['interact'],
	item: ['collect', 'use', 'buy'],
};
const QUEST_POSITIONAL = ['accept', 'turnin', 'complete'];
const XY_POSITIONAL = ['goto', 'explore'];
const MOD_WORD_SET = new Set(MOD_WORDS);

function quote(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"')}"`;
}

// A coordinate as written: the number itself, integers with `.0`.
function coordText(v) {
	const n = Number(v);
	let s = Number.isInteger(n) ? n.toFixed(1) : String(n);
	if (/e/i.test(s)) s = n.toFixed(4).replace(/0+$/, '').replace(/\.$/, '.0');
	return s === '-0.0' ? '0.0' : s;
}

function formatCoord(v, yardsPerPercent) {
	const n = Number(v);
	const one = Math.round(n * 10) / 10;
	const two = Math.round(n * 100) / 100;
	const ypp = Number(yardsPerPercent);
	const pick = ypp > 0 && Math.abs(one - n) * ypp <= 4 ? one : two;
	const s = pick.toFixed(2).replace(/0$/, '');
	return s === '-0.0' ? '0.0' : s;
}

// copper -> '1g50s' (always readable by parse.js's readMoney).
function moneyText(copper) {
	const c = Math.round(Number(copper));
	const g = Math.floor(c / 10000);
	const s = Math.floor((c % 10000) / 100);
	const k = c % 100;
	return `${g ? `${g}g` : ''}${s ? `${s}s` : ''}${k ? `${k}c` : ''}` || '0';
}

function readMoneyText(text) {
	const m = /^(?:(\d+)g)?\s*(?:(\d+)s)?\s*(?:(\d+)c)?$/i.exec(String(text).trim());
	if (!m || !(m[1] || m[2] || m[3])) return text;
	return Number(m[1] || 0) * 10000 + Number(m[2] || 0) * 100 + Number(m[3] || 0);
}

// The condition list of a parsed `only` object (used when no text was kept).
function conditionText(c) {
	if (!c) return '';
	return [...(c.factions || []), ...(c.races || []), ...(c.classes || []).map((f) => cap(f.toLowerCase()))].join(',');
}

function onlyTextOf(goal) {
	const span = goal.spans && goal.spans.mods.find((m) => m.mod === 'only');
	return span && span.text ? span.text : conditionText(goal.only);
}

function goalFields(goal) {
	const out = {};
	for (const [k, v] of Object.entries(goal)) {
		if (k === 'line' || k === 'zone') continue;
		if (k === 'only') {
			out.onlyText = onlyTextOf(goal);
			continue;
		}
		out[k] = v && typeof v === 'object' ? structuredClone(v) : v;
	}
	return out;
}

// Fields from a caller: empty values dropped, numbers from text, names to
// their numbers (standing, rank, money), verb and frame lower-case, note and
// profession trimmed; a parser flag (DERIVED) goes when its field has gone:
// explicitCoords without x/y, <k>Explicit without k or on a verb that takes no
// `k` modifier, skillQuoted without a skill, factionQuoted without a faction
// name or with a faction id.
function normalizeFields(fields) {
	const out = {};
	for (const [k, v0] of Object.entries(fields || {})) {
		let v = v0;
		if (v === undefined || v === null || v === '' || v === false) continue;
		if (Array.isArray(v) && !v.length) continue;
		if (typeof v === 'string' && !v.trim()) continue;
		if (k === 'standing' && typeof v === 'string' && Object.hasOwn(STANDINGS, v.toLowerCase())) v = STANDINGS[v.toLowerCase()];
		if (k === 'rank' && typeof v === 'string' && RANKS.includes(v.toLowerCase())) v = RANKS.indexOf(v.toLowerCase()) + 1;
		if (k === 'rewardMoney' && typeof v === 'string' && !NUM_TEXT.test(v.trim())) v = readMoneyText(v);
		if (NUMERIC.includes(k) && typeof v === 'string' && NUM_TEXT.test(v.trim())) v = Number(v);
		if ((k === 'verb' || k === 'frame') && typeof v === 'string') v = v.trim().toLowerCase();
		if ((k === 'note' || k === 'profession') && typeof v === 'string') v = v.trim();
		if (k === 'rewardItems' || k === 'rewardChoices') {
			v = v.map((it) => {
				const o = { item: Number(it.item) };
				if (it.itemName) o.itemName = String(it.itemName);
				if (it.quality !== undefined && it.quality !== null && it.quality !== '') {
					o.quality = typeof it.quality === 'string' && QUALITIES.includes(it.quality.toLowerCase()) ? QUALITIES.indexOf(it.quality.toLowerCase()) : Number(it.quality);
				}
				return o;
			});
		}
		if (k === 'group' && typeof v !== 'object') v = v === true ? {} : { size: Number(v) };
		out[k] = v;
	}
	if (out.explicitCoords && out.x === undefined && out.y === undefined) delete out.explicitCoords;
	const mods = typeof out.verb === 'string' && Object.hasOwn(MODS, out.verb) ? MODS[out.verb] : null;
	for (const k of ['npc', 'object', 'item']) {
		if (out[`${k}Explicit`] && (out[k] === undefined || (mods && !mods.includes(k)))) delete out[`${k}Explicit`];
	}
	if (out.skillQuoted && out.skill === undefined) delete out.skillQuoted;
	if (out.factionQuoted && (out.factionName === undefined || out.factionId !== undefined)) delete out.factionQuoted;
	return out;
}

// The first field (key path) holding a text with a line break, or null.
function lineBreakField(v, key) {
	if (typeof v === 'string') return /[\r\n\u2028\u2029]/.test(v) ? key : null;
	if (!v || typeof v !== 'object') return null;
	for (const [k, x] of Object.entries(v)) {
		const found = lineBreakField(x, key ? `${key}.${k}` : k);
		if (found) return found;
	}
	return null;
}

// Unquoted words read back as `text` by `reader(tokens)`, else null.
function bareWords(text, accept) {
	const lex = lexLine(text);
	if (lex.error || lex.note !== null || lex.end !== text.length || !lex.tokens.length) return null;
	if (lex.tokens.some((t) => t.quoted) || lex.tokens.map((t) => t.text).join(' ') !== text) return null;
	return accept(lex.tokens) ? text : null;
}

function positionalTokens(verb, f) {
	const out = [];
	const name = (k) => {
		if (f[k] !== undefined) out.push(quote(f[k]));
	};
	const id = (k) => {
		if (f[k] !== undefined) out.push(String(f[k]));
	};
	const idHere = (k) => f[k] !== undefined && !f[`${k}Explicit`];
	switch (verb) {
		case 'accept':
		case 'turnin':
		case 'complete':
			id('quest');
			name('title');
			break;
		case 'kill':
			if (idHere('npc')) id('npc');
			name('target');
			break;
		case 'collect':
		case 'use':
		case 'buy':
			id('item');
			name('itemName');
			break;
		case 'talk':
			id('npc');
			name('npcName');
			break;
		case 'interact':
			id('object');
			name('objName');
			break;
		case 'train':
		case 'vendor':
			if (idHere('npc')) {
				id('npc');
				name('npcName');
			} else if (verb === 'vendor' && f.nearest) out.push('nearest');
			else if (verb === 'train' && f.classTrain) out.push('class');
			else if (verb === 'train' && f.profession !== undefined) {
				const prof = bareWords(String(f.profession), (toks) => toks.every((t) => !/^[@"]|^x\d+$/i.test(t.text) && !MOD_WORD_SET.has(t.text.toLowerCase())));
				if (prof === null) throw new Error(`profession "${f.profession}" cannot be written in \`train\``);
				out.push(prof);
				if (f.rank !== undefined) out.push(cap(RANKS[f.rank - 1] || String(f.rank)));
			}
			break;
		case 'goto':
		case 'explore':
			if (f.x !== undefined || f.y !== undefined) out.push(`${coordText(f.x)},${coordText(f.y)}`);
			name('text');
			break;
		case 'sethome':
		case 'hearth':
		case 'getfp':
		case 'fly':
			if (verb === 'sethome' && f.nearest) out.push('nearest');
			else name('location');
			break;
		case 'level':
			id('level');
			break;
		case 'note':
			// Written by formatGoal: bare only when nothing follows.
			break;
		case 'skill':
			if (f.skill !== undefined) {
				const bare = f.skillQuoted ? null : bareWords(String(f.skill), (toks) => toks.every((t) => !/^\d+$/.test(t.text)));
				out.push(bare === null ? quote(f.skill) : bare);
			}
			id('level');
			break;
		case 'learn':
		case 'craft':
			id('spell');
			name('spellName');
			break;
		case 'rep':
			if (f.factionId !== undefined) {
				id('factionId');
				name('factionName');
			} else if (f.factionName !== undefined) {
				const bare = f.factionQuoted ? null : bareWords(String(f.factionName), (toks) => toks.every((t) => !/^\d+$/.test(t.text) && !Object.hasOwn(STANDINGS, t.text.toLowerCase())));
				out.push(bare === null ? quote(f.factionName) : bare);
			}
			if (f.standing !== undefined) out.push(cap(STANDING_NAMES[f.standing - 1] || String(f.standing)));
			break;
		case 'achieve':
			id('achievement');
			name('achievementName');
			break;
	}
	return out;
}

// Verbs with an optional quoted name right after their id ([id key, name
// key]): a "text" label written there would read as that name.
const NAME_SLOT = {
	accept: ['quest', 'title'], turnin: ['quest', 'title'], complete: ['quest', 'title'], kill: ['npc', 'target'],
	collect: ['item', 'itemName'], use: ['item', 'itemName'], buy: ['item', 'itemName'], talk: ['npc', 'npcName'],
	interact: ['object', 'objName'], train: ['npc', 'npcName'], vendor: ['npc', 'npcName'], learn: ['spell', 'spellName'],
	craft: ['spell', 'spellName'], achieve: ['achievement', 'achievementName'],
};

function rewardText(word, items) {
	return [word, ...items.map((it) => [String(it.item), it.itemName !== undefined ? quote(it.itemName) : null, it.quality !== undefined ? QUALITIES[it.quality] || String(it.quality) : null].filter(Boolean).join(' '))].join(' ');
}

function formatGoal(fields) {
	const broken = lineBreakField(fields, '');
	if (broken) throw new Error(`the field \`${broken}\` must be one line (no line breaks)`);
	const f = normalizeFields(fields);
	const verb = f.verb;
	if (typeof verb !== 'string' || !Object.hasOwn(MODS, verb)) throw new Error(`unknown verb "${fields && fields.verb}"`);
	const pos = positionalTokens(verb, f);
	const mods = [];
	const push = (mod, text) => mods.push({ mod, text });
	if (!XY_POSITIONAL.includes(verb) && (f.x !== undefined || f.y !== undefined)) push('at', `@${coordText(f.x)},${coordText(f.y)}`);
	if (f.coordMap !== undefined) push('map', `map ${f.coordMap}`);
	if (f.r !== undefined) push('r', `r ${Number(f.r)}`);
	if (f.frame !== undefined) push('frame', f.frame);
	for (const k of ['npc', 'object', 'item']) {
		if (f[k] !== undefined && (f[`${k}Explicit`] || !POSITIONAL_ID[k].includes(verb))) push(k, `${k} ${f[k]}`);
	}
	if (!QUEST_POSITIONAL.includes(verb) && f.quest !== undefined) push('quest', `quest ${f.quest}${f.oi !== undefined ? `.${f.oi}` : ''}`);
	else if (f.oi !== undefined) throw new Error('an objective (`oi`) needs a quest link');
	if (f.count !== undefined) push('count', `x${f.count}`);
	if (f.minLevel !== undefined) push('lvl', `lvl ${f.minLevel}`);
	if (f.untilSkill !== undefined) push('until', `until ${f.untilSkill}`);
	if (f.criteria !== undefined) push('criteria', `criteria ${f.criteria}`);
	if (f.nearest && verb !== 'sethome' && verb !== 'vendor') push('nearest', 'nearest');
	if (f.rewardChoices) push('choose', rewardText('choose', f.rewardChoices));
	if (f.rewardItems) push('reward', rewardText('reward', f.rewardItems));
	if (f.rewardXp !== undefined) push('xp', `xp ${f.rewardXp}`);
	if (f.rewardMoney !== undefined) push('money', `money ${moneyText(f.rewardMoney)}`);
	if (f.direct && verb === 'turnin') push('direct', 'direct');
	if (f.group) push('group', f.group.size !== undefined ? `group ${f.group.size}` : 'group');
	const label = f.text !== undefined && !XY_POSITIONAL.includes(verb) && verb !== 'note' ? quote(f.text) : null;
	if (f.optional) push('optional', 'optional');
	const onlyText = f.onlyText !== undefined ? String(f.onlyText) : f.only ? conditionText(f.only) : '';
	if (onlyText) push('only', `only ${onlyText.trim().replace(/\s*,\s*/g, ',')}`);
	if (label !== null) {
		// "text" goes before `optional`/`only`, but never where a quoted token
		// would read as something else: right after a reward list (an item
		// name) or right after the verb's id (its name).
		let at = mods.findIndex((m) => m.mod === 'optional' || m.mod === 'only');
		if (at < 0) at = mods.length;
		const prev = at > 0 ? mods[at - 1].mod : null;
		if (prev === 'reward' || prev === 'choose') at = mods.findIndex((m) => m.mod === 'choose' || m.mod === 'reward');
		const before = at > 0 ? mods[at - 1].mod : null;
		const slot = NAME_SLOT[verb];
		if (before === null && slot && f[slot[0]] !== undefined && !f[`${slot[0]}Explicit`] && f[slot[1]] === undefined) {
			const later = mods.findIndex((m) => m.mod === 'optional' || m.mod === 'only');
			if (later < 0) throw new Error(`a "text" label right after \`${verb}\`'s id reads as its name; give the name too, or another modifier`);
			at = later + 1;
		}
		mods.splice(at, 0, { mod: 'text', text: label });
	}
	let line = [verb, ...pos, ...mods.map((m) => m.text)].join(' ');
	if (verb === 'note' && f.text !== undefined) {
		const bare = `note ${f.text}`;
		const lex = lexLine(bare);
		const plain = !mods.length && !lex.error && lex.note === null && lex.tokens.length > 1 && !lex.tokens[1].quoted && bare.slice(lex.tokens[1].start, lex.end).trim() === f.text;
		line = plain ? bare : ['note', quote(f.text), ...mods.map((m) => m.text)].join(' ');
	}
	if (f.note !== undefined) line += ` -- ${f.note}`;
	return line;
}

// One goal line parsed on its own (inside a minimal guide).
function parseGoalLine(text) {
	const diag = new Diagnostics();
	const src = ['guide t/x', 'title T', 'levels 1-2', 'zone Z', 'step S', `  ${String(text).replace(/^[ \t]+/, '')}`].join('\n');
	const g = parseGuide(src, 'line', diag);
	const goal = g && g.steps[0] && g.steps[0].goals[0];
	return { goal: goal || null, errors: diag.errors.filter((d) => d.line === 6).map((d) => d.message) };
}

// The first field where `fields` and a parsed goal differ, or null.
function fieldDiff(fields, goal) {
	const want = normalizeFields(fields);
	const got = goalFields(goal);
	for (const k of new Set([...Object.keys(want), ...Object.keys(got)])) {
		if (DERIVED.includes(k) && !(k in want)) continue;
		if (k === 'onlyText') {
			const a = k in want ? parseConditions(String(want[k]).replace(/\s*,\s*/g, ','), 'any').value : null;
			const b = k in got ? parseConditions(String(got[k]).replace(/\s*,\s*/g, ','), 'any').value : null;
			if (!isDeepStrictEqual(a, b)) return k;
			continue;
		}
		if (!isDeepStrictEqual(want[k], got[k])) return k;
	}
	return null;
}

// --- the schema

const ID_KIND = { quest: 'quest', npc: 'npc', object: 'object', item: 'item', spell: 'spell', achievement: 'achievement', factionId: 'faction' };
const fld = (key, type, label, extra = {}) => ({ key, type, label, ...extra });
const idf = (key, label, required) => fld(key, 'id', label, { required, kind: ID_KIND[key] });
const xy = (extra) => fld('xy', 'coords', 'Coordinates x,y', { keys: ['x', 'y'], ...extra });

const POSITIONAL = {
	accept: [idf('quest', 'Quest', true), fld('title', 'text', 'Quest title', { required: false })],
	kill: [idf('npc', 'NPC', false), fld('target', 'text', 'Target name', { required: false })],
	collect: [idf('item', 'Item', true), fld('itemName', 'text', 'Item name', { required: false })],
	talk: [idf('npc', 'NPC', true), fld('npcName', 'text', 'NPC name', { required: false })],
	interact: [idf('object', 'Object', true), fld('objName', 'text', 'Object name', { required: false })],
	train: [
		idf('npc', 'Trainer', false),
		fld('npcName', 'text', 'Trainer name', { required: false }),
		fld('classTrain', 'bool', 'Class trainer', { required: false }),
		fld('profession', 'text', 'Profession', { required: false }),
		fld('rank', 'enum', 'Rank', { required: false, values: RANKS.map((r, i) => ({ value: i + 1, label: cap(r) })) }),
	],
	vendor: [idf('npc', 'Vendor', false), fld('npcName', 'text', 'Vendor name', { required: false }), fld('nearest', 'bool', 'Nearest vendor', { required: false })],
	goto: [xy({ required: true }), fld('text', 'text', 'Label', { required: false })],
	sethome: [fld('location', 'text', 'Inn location', { required: false, kind: 'inn' }), fld('nearest', 'bool', 'Nearest inn', { required: false })],
	hearth: [fld('location', 'text', 'Location', { required: true, kind: 'inn' })],
	getfp: [fld('location', 'text', 'Flight point', { required: true, kind: 'flight' })],
	fly: [fld('location', 'text', 'Destination', { required: true, kind: 'flight' })],
	level: [fld('level', 'int', 'Level', { required: true })],
	note: [fld('text', 'text', 'Text', { required: true })],
	skill: [fld('skill', 'text', 'Profession', { required: true }), fld('level', 'int', 'Skill rank', { required: true })],
	learn: [idf('spell', 'Spell', true), fld('spellName', 'text', 'Spell name', { required: false })],
	rep: [
		idf('factionId', 'Faction', false),
		fld('factionName', 'text', 'Faction name', { required: false }),
		fld('standing', 'enum', 'Standing', { required: true, values: STANDING_NAMES.map((s, i) => ({ value: i + 1, label: cap(s) })) }),
	],
	achieve: [idf('achievement', 'Achievement', true), fld('achievementName', 'text', 'Achievement name', { required: false })],
};
POSITIONAL.turnin = POSITIONAL.accept;
POSITIONAL.complete = POSITIONAL.accept;
POSITIONAL.use = POSITIONAL.collect;
POSITIONAL.buy = POSITIONAL.collect;
POSITIONAL.explore = POSITIONAL.goto;
POSITIONAL.craft = POSITIONAL.learn;

const MODIFIER_FIELDS = {
	at: [xy({ mod: 'at' })],
	map: [fld('coordMap', 'int', 'Map (uiMapID)')],
	r: [fld('r', 'number', 'Radius (yards)')],
	frame: [fld('frame', 'enum', 'Coordinate frame', { values: [{ value: 'era', label: 'Era' }, { value: 'live', label: 'Live' }] })],
	npc: [idf('npc', 'NPC')],
	object: [idf('object', 'Object')],
	item: [idf('item', 'Item')],
	quest: [idf('quest', 'Quest'), fld('oi', 'int', 'Objective')],
	count: [fld('count', 'int', 'Count')],
	lvl: [fld('minLevel', 'int', 'Minimum level')],
	until: [fld('untilSkill', 'int', 'Until skill')],
	criteria: [fld('criteria', 'int', 'Criterion')],
	nearest: [fld('nearest', 'bool', 'Nearest')],
	choose: [fld('rewardChoices', 'items', 'Reward choices')],
	reward: [fld('rewardItems', 'items', 'Rewards')],
	xp: [fld('rewardXp', 'int', 'XP')],
	money: [fld('rewardMoney', 'money', 'Money (copper)')],
	direct: [fld('direct', 'bool', 'Handed in without an accept')],
	group: [fld('group', 'group', 'Group')],
	text: [fld('text', 'text', 'Label')],
	optional: [fld('optional', 'bool', 'Optional')],
	only: [fld('onlyText', 'text', 'Only for')],
};
// Modifier order of the schema = the order formatGoal writes them.
const MOD_ORDER = ['at', 'map', 'r', 'frame', 'npc', 'object', 'item', 'quest', 'count', 'lvl', 'until', 'criteria', 'nearest', 'choose', 'reward', 'xp', 'money', 'direct', 'group', 'text', 'optional', 'only'];

function verbSchema() {
	const verbs = {};
	for (const verb of Object.keys(MODS)) {
		const positional = (POSITIONAL[verb] || []).map((p) => ({ ...p }));
		const has = new Set(positional.map((p) => p.key));
		const modifiers = [];
		for (const mod of MOD_ORDER) {
			if (!MODS[verb].includes(mod)) continue;
			// The verb's own positional fields (goto's label, kill's npc id) are not repeated.
			for (const m of MODIFIER_FIELDS[mod]) if (!has.has(m.key)) modifiers.push({ ...m, mod });
		}
		verbs[verb] = { positional, modifiers, note: fld('note', 'text', 'Note (-- ...)') };
	}
	return { verbs };
}

module.exports = { goalFields, formatGoal, parseGoalLine, fieldDiff, normalizeFields, verbSchema, formatCoord, quote };
