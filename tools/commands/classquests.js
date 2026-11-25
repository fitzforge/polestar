'use strict';
// node tools/polestar.js classquests build|check
//
// Which class quest chains Polestar alerts for (#3925): the hand-written list
// data/codex/class-quests.json names, for every Class guide (`category
// Class`), why the class quest banner (QoL/ClassQuests.lua), the level-up
// heads-up (UI/ClassToast.lua) and the class card (UI/ClassCard.lua) speak up
// for it (a spell, an ability, a mount, a key, an unlock, or an item chain on
// the hand-picked worth-it list), or that it is optional: no alert, listed in
// the guide menu in its class's folder of optional class quests, and never a
// feeder of a leveling guide (Core/Engine.lua). This writes the optional
// guides and the quests only they take into
// addon/Polestar/Core/ClassQuestList.lua; `check` exits 1 when the committed
// file differs.

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('node:util');
const { header, reportSync } = require('../lib/generated');
const { parseGuide } = require('../lib/dsl/parse');
const { ROOT } = require('../lib/paths');

const usage = `usage: node tools/polestar.js classquests build [--list <file>] [--guides <dir>]
       node tools/polestar.js classquests check [--list <file>] [--guides <dir>]

build: writes addon/Polestar/Core/ClassQuestList.lua from the list and the
Class guides' quests. check: exits 1 when the committed file differs.

  --list <file>    the list (default: data/codex/class-quests.json)
  --guides <dir>   the guides (default: guides/)`;

const LIST = path.join(ROOT, 'data', 'codex', 'class-quests.json');
const OUT_DIR = path.join(ROOT, 'addon', 'Polestar', 'Core');
const OUT_NAME = 'ClassQuestList.lua';
// Why a chain is prompted; "optional" is the one that is not.
const PROMPTS = ['spell', 'ability', 'mount', 'key', 'unlock', 'worth', 'optional'];

function walkGuides(dir, out = []) {
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) walkGuides(p, out);
		else if (e.name.endsWith('.guide')) out.push(p);
	}
	return out.sort();
}

// The Class guides under dir: [{ id, file, classes (the header's), quests (accept/turnin/complete ids, in order) }].
function classGuides(dir) {
	const diag = { error() {}, warn() {}, push() {} };
	const out = [];
	for (const file of walkGuides(dir)) {
		const text = fs.readFileSync(file, 'utf8');
		if (!/^category Class\s*$/m.test(text)) continue;
		const g = parseGuide(text, file, diag);
		if (!g || !g.header || g.header.category !== 'Class') continue;
		const quests = [];
		for (const step of g.steps || []) {
			for (const goal of step.goals || []) {
				const q = Number(goal.quest);
				if (q && ['accept', 'turnin', 'complete'].includes(goal.verb) && !quests.includes(q)) quests.push(q);
			}
		}
		out.push({ id: g.id, file: path.relative(ROOT, file), classes: g.header.classes || [], quests });
	}
	return out;
}

// The list checked against the guides. -> { prompt: { id -> kind }, optional: { quest -> guide id } }
// Throws on a guide the list misses, a row for no guide, an unknown prompt, a
// worth row with no reason, or a row with no reward.
function buildClassQuestList(list, guides) {
	const errors = [];
	const rows = new Map();
	for (const r of list.guides || []) {
		if (rows.has(r.guide)) errors.push(`${r.guide}: listed twice`);
		rows.set(r.guide, r);
		if (!PROMPTS.includes(r.prompt)) errors.push(`${r.guide}: prompt "${r.prompt}" is none of ${PROMPTS.join(', ')}`);
		if ((r.worth || r.prompt === 'worth') && !(r.worth && typeof r.reason === 'string' && r.reason.trim())) errors.push(`${r.guide}: a worth-it chain needs worth: true and a one-line reason`);
		if (r.worth && r.prompt === 'optional') errors.push(`${r.guide}: a worth-it chain is never optional`);
		if (typeof r.reward !== 'string' || !r.reward.trim()) errors.push(`${r.guide}: no reward named`);
	}
	const ids = new Set(guides.map((g) => g.id));
	for (const g of guides) if (!rows.has(g.id)) errors.push(`${g.id} (${g.file}): a Class guide data/codex/class-quests.json does not list`);
	for (const id of rows.keys()) if (!ids.has(id)) errors.push(`${id}: listed, but no Class guide has that id`);
	if (errors.length) throw new Error(`class-quests.json:\n  ${errors.join('\n  ')}`);
	const prompt = {};
	for (const g of guides) prompt[g.id] = rows.get(g.id).prompt;
	// A quest any prompted guide takes stays prompted.
	const prompted = new Set();
	for (const g of guides) if (prompt[g.id] !== 'optional') for (const q of g.quests) prompted.add(q);
	const optional = {};
	for (const g of guides) {
		if (prompt[g.id] !== 'optional') continue;
		for (const q of g.quests) if (!prompted.has(q) && !(q in optional)) optional[q] = g.id;
	}
	return { prompt, optional };
}

// The addon keeps only what it asks (Polestar's core at login has a memory budget, options-memory.rs): the
// optional guides and their quests, each a space-separated list in one string, read with string.find.
function toLua({ prompt, optional }) {
	const ids = Object.keys(prompt).filter((id) => prompt[id] === 'optional').sort();
	const qs = Object.keys(optional).map(Number).sort((a, b) => a - b);
	const chunks = (list, n) => {
		const lines = [];
		for (let i = 0; i < list.length; i += n) lines.push(list.slice(i, i + n).join(' '));
		if (!lines.length) return ['\t\t" ",'];
		return lines.map((l, i) => `\t\t${JSON.stringify((i === 0 ? ' ' : '') + l + ' ')}${i < lines.length - 1 ? ' ..' : ','}`);
	};
	return [
		header('lua', 'classquests build', 'data/codex/class-quests.json and the Class guides in guides/'),
		'-- Which class quest chains are optional (#3925): no alert, no feeder, listed apart in the guide menu. Every Class',
		'-- guide not named here is alerted for (data/codex/class-quests.json says why). Read by QoL/ClassQuests.lua,',
		'-- UI/ClassToast.lua, UI/ClassCard.lua, UI/Picker.lua and the leveling guides\' feeders (Core/Engine.lua).',
		'',
		'local ADDON, ns = ...',
		'local find = string.find',
		'',
		'local List = {',
		'\t-- The optional Class guides\' ids.',
		'\tguides =',
		...chunks(ids, 2),
		'\t-- The quests only optional Class guides take. A quest open to every class (Zardeth\'s errand before the Dread',
		'\t-- Mage Hat) is here too: each reader also asks whether it is a class quest.',
		'\tquests =',
		...chunks(qs, 16),
		'}',
		'',
		'-- Whether Class guide `id` is optional.',
		'function List.OptionalGuide(id)',
		'\treturn type(id) == "string" and find(List.guides, " " .. id .. " ", 1, true) ~= nil',
		'end',
		'',
		'-- Whether quest `q` is taken only by optional Class guides.',
		'function List.OptionalQuest(q)',
		'\treturn type(q) == "number" and find(List.quests, " " .. q .. " ", 1, true) ~= nil',
		'end',
		'',
		'ns.ClassQuestList = List',
		'',
	].join('\n');
}

module.exports = {
	name: 'classquests',
	summary: 'Build the list of class quest chains Polestar alerts for (Core/ClassQuestList.lua)',
	usage,
	PROMPTS,
	classGuides,
	buildClassQuestList,
	toLua,
	run(argv) {
		let values, positionals;
		try {
			({ values, positionals } = parseArgs({ args: argv, options: { list: { type: 'string' }, guides: { type: 'string' } }, allowPositionals: true, strict: true }));
		} catch (err) {
			console.error(`${err.message}\n\n${usage}`);
			return 2;
		}
		const [sub, ...extra] = positionals;
		if ((sub !== 'build' && sub !== 'check') || extra.length) {
			console.error(usage);
			return 2;
		}
		const list = JSON.parse(fs.readFileSync(path.resolve(values.list || LIST), 'utf8'));
		const guides = classGuides(path.resolve(values.guides || path.join(ROOT, 'guides')));
		let data;
		try {
			data = buildClassQuestList(list, guides);
		} catch (err) {
			console.error(err.message);
			return 1;
		}
		return reportSync({ [OUT_NAME]: toLua(data) }, OUT_DIR, { check: sub === 'check', command: 'classquests build' });
	},
};
