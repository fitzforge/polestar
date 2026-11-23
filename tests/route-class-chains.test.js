'use strict';
// Every class quest the leveling route takes is there for every race the
// quest data lets take it with that class: no `only <Race>` line on the route
// leaves out a race (Skyborne, Forever's Undead Paladins and Dwarf Shamans,
// ...) whose players can take the chain, unless that race has its own
// version of the chain on its route (EQUIVALENT below, each checked against
// the guides and players' recordings).
//
// Found from gate 3's 6127 row on 0.3.7's candidate: the Druid chains to
// Aquatic Form (Horde 27, 28, 30, 31; Alliance 26, 29, 272, 5061) and Cure
// Poison (Horde 6126-6130; Alliance 6121-6125) named Tauren or Night Elves
// alone, though Forever opens them to Skyborne Druids
// (forever-db/corrections/quests.json) and recorded Skyborne Druids took
// them, from the class guides only; two reached 26 and 27 without either.
//
// A class quest: a classes mask of one to three classes. The route: the
// faction's leveling guides; a race's start guides count for that race only.
// Needs data/forever (quests.json, races.json).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.join(__dirname, '..');
const DATA = path.join(ROOT, 'data', 'forever');
const GUIDES = path.join(ROOT, 'guides', 'forever');
const CLASS_BIT = { WARRIOR: 1, PALADIN: 2, HUNTER: 4, ROGUE: 8, PRIEST: 16, SHAMAN: 64, MAGE: 128, WARLOCK: 256, DRUID: 1024 };
const GUIDE_RACE = { Scourge: 'Undead' }; // races.json name -> the guides' `only` name
const START_DIR = { orc: 'Orc', troll: 'Troll', tauren: 'Tauren', undead: 'Scourge', skyborne: 'Skyborne', human: 'Human', dwarf: 'Dwarf', gnome: 'Gnome', nightelf: 'NightElf' };
const RACE_WORDS = new Set(['Human', 'Dwarf', 'Gnome', 'NightElf', 'Orc', 'Troll', 'Tauren', 'Undead', 'Skyborne']);

// "<race>/<faction>/<CLASS>" left out of a quest on purpose: it has its own
// version of the chain on its route.
const EQUIVALENT = {
	// Call of Fire: Skyborne Shamans take Sessaria Skystride's 97243-97257 on Zephras Isle (recorded at 10-12).
	1525: ['Skyborne/Horde/SHAMAN'], 1526: ['Skyborne/Horde/SHAMAN'], 1527: ['Skyborne/Horde/SHAMAN'],
	// Defensive Stance: Undead Warriors take Ulag the Cleaver (1819) in Tirisfal, Skyborne Warriors Seena
	// Skybreaker's 94003 on Zephras Isle.
	1498: ['Scourge/Horde/WARRIOR', 'Skyborne/Horde/WARRIOR'],
	1502: ['Scourge/Horde/WARRIOR', 'Skyborne/Horde/WARRIOR'],
	1503: ['Scourge/Horde/WARRIOR', 'Skyborne/Horde/WARRIOR'],
	// Night Elf Warriors take Elanaria's 1683/1684 in Teldrassil, Skyborne Warriors 94003 on Zephras Isle.
	1638: ['NightElf/Alliance/WARRIOR', 'Skyborne/Alliance/WARRIOR'],
	1639: ['NightElf/Alliance/WARRIOR', 'Skyborne/Alliance/WARRIOR'],
	1640: ['NightElf/Alliance/WARRIOR', 'Skyborne/Alliance/WARRIOR'],
	1665: ['NightElf/Alliance/WARRIOR', 'Skyborne/Alliance/WARRIOR'],
};

function onlyMatches(tokens, race, faction, cls) {
	if (!tokens.length) return true;
	const races = tokens.filter((t) => RACE_WORDS.has(t));
	const factions = tokens.filter((t) => t === 'Horde' || t === 'Alliance');
	const classes = tokens.filter((t) => CLASS_BIT[t.replace(/^!/, '').toUpperCase()] !== undefined);
	if (races.length && !races.includes(GUIDE_RACE[race] || race)) return false;
	if (factions.length && !factions.includes(faction)) return false;
	const pos = classes.filter((t) => !t.startsWith('!')).map((t) => t.toUpperCase());
	const neg = classes.filter((t) => t.startsWith('!')).map((t) => t.slice(1).toUpperCase());
	if (pos.length && !pos.includes(cls)) return false;
	return !neg.includes(cls);
}

// faction -> [{ quest, where, start (race or null), step, goal }] for every accept on the route.
function accepts() {
	const out = { Horde: [], Alliance: [] };
	for (const [sub, faction] of [['horde', 'Horde'], ['alliance', 'Alliance']]) {
		const dir = path.join(GUIDES, sub);
		for (const rel of fs.readdirSync(dir, { recursive: true }).filter((f) => f.endsWith('.guide'))) {
			const start = START_DIR[rel.split(path.sep)[0]] || null;
			let step = [];
			fs.readFileSync(path.join(dir, rel), 'utf8').split('\n').forEach((line, i) => {
				if (line.startsWith('step ')) step = [];
				const only = /^  only (\S+)/.exec(line);
				if (only) { step = only[1].split(','); return; }
				const m = /^  accept (\d+)(.*)$/.exec(line);
				if (!m) return;
				const goal = /\bonly (\S+)/.exec(m[2]);
				out[faction].push({ quest: Number(m[1]), where: `${sub}/${rel}:${i + 1}`, start, step, goal: goal ? goal[1].split(',') : [] });
			});
		}
	}
	return out;
}

test('every class quest on the route serves every race the data allows for that class', { skip: !fs.existsSync(path.join(DATA, 'quests.json')) && 'no data/forever' }, () => {
	let quests = JSON.parse(fs.readFileSync(path.join(DATA, 'quests.json'), 'utf8'));
	quests = quests.quests || quests;
	const races = JSON.parse(fs.readFileSync(path.join(DATA, 'races.json'), 'utf8'));
	const pairs = [];
	for (const [race, sides] of Object.entries(races)) {
		for (const [faction, e] of Object.entries(sides)) for (const cls of e.classes) pairs.push({ race, faction, bit: e.bit, cls });
	}
	const A = accepts();
	const missing = [];
	let checked = 0;
	for (const faction of ['Horde', 'Alliance']) {
		const byQuest = new Map();
		for (const a of A[faction]) byQuest.set(a.quest, [...(byQuest.get(a.quest) || []), a]);
		for (const [q, lines] of byQuest) {
			const d = quests[String(q)] || {};
			const classes = d.classes || 0;
			const nClasses = classes ? classes.toString(2).split('').filter((b) => b === '1').length : 0;
			if (nClasses < 1 || nClasses > 3) continue;
			checked++;
			for (const p of pairs) {
				if (p.faction !== faction || !(classes & CLASS_BIT[p.cls])) continue;
				if (d.races && !(BigInt(d.races) & BigInt(p.bit))) continue;
				const served = lines.some((a) => (a.start === null || a.start === p.race) && onlyMatches(a.step, p.race, faction, p.cls) && onlyMatches(a.goal, p.race, faction, p.cls));
				const key = `${p.race}/${faction}/${p.cls}`;
				if (served || (EQUIVALENT[q] || []).includes(key)) continue;
				// A start-zone chain only its own race's start guide takes: other races have their own.
				if (lines.every((a) => a.start !== null)) continue;
				missing.push(`${q} ${d.title}: ${key} (${lines.map((a) => a.where).join(', ')})`);
			}
		}
	}
	assert.ok(checked > 50, `class quests on the route: ${checked}`);
	assert.deepEqual(missing, []);
});
