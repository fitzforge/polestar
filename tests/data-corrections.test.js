'use strict';
// forever-db/corrections: a correction that gives a quest its
// prerequisites must leave the quest blocked by them. QuestieDB's split
// fields win over pfQuest's `pre` once either is present (prereqs.js), so a
// `set` with `pre` and an empty `preAny` but no `preAll` blocks nothing.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const { loadCorrections, loadPublicCorrections, overlayCorrections, PUBLIC_DIR, SECTIONS, SOURCE_KINDS } = require('../tools/lib/data/corrections');

const corrections = loadPublicCorrections();
const { blockingPrereqs, closedByOf } = require('../tools/lib/data/prereqs');

test('every public correction names an independent source, and its note cites no web page', () => {
	const bad = [];
	for (const section of SECTIONS) {
		for (const [id, entry] of Object.entries(corrections[section] || {})) {
			const sources = [].concat(entry.source || []);
			if (!sources.length || !sources.every((s) => SOURCE_KINDS.includes(s.kind) && typeof s.ref === 'string' && s.ref)) bad.push(`${section} ${id}: source`);
			if (typeof entry.note !== 'string' || /https?:|\[race=|snapshot/i.test(entry.note)) bad.push(`${section} ${id}: note`);
		}
	}
	assert.deepEqual(bad, []);
});

test('the corrections are one file per section in forever-db/corrections', () => {
	for (const s of SECTIONS) assert.ok(fs.existsSync(path.join(PUBLIC_DIR, `${s}.json`)), `${s}.json`);
	assert.ok(!fs.existsSync(path.join(__dirname, '..', 'tools', 'lib', 'data', 'corrections.json')), 'the old single file is gone');
});

// JSON keeps the last of two entries with the same id, silently: a second "92474" entry added for its objectives
// dropped the first one's race fix (2026-11-17). Each id is one entry per file.
test('no correction file has the same id twice', () => {
	const dup = [];
	for (const s of SECTIONS) {
		const seen = new Set();
		for (const m of fs.readFileSync(path.join(PUBLIC_DIR, `${s}.json`), 'utf8').matchAll(/^\t"([^"]+)":/gm)) {
			if (seen.has(m[1])) dup.push(`${s}.json ${m[1]}`);
			seen.add(m[1]);
		}
	}
	assert.deepEqual(dup, []);
});

test('Gnomish Garbage counts five discards, not five Wastewander Rogue kills (#3159)', () => {
	const [goal] = corrections.quests[97536].set.objectives;
	assert.deepEqual([goal.type, goal.id, goal.count], ['event', null, 5]);
	const [step] = require('../data/mechanics-public.json').quests[97536].steps;
	assert.deepEqual([step.action, step.item, step.count], ['use-item', 278194, goal.count]);
});

test('A Reliquary of Purity opens at Rabine Saturna only after a Dire Maul visit (#3104, #3270)', () => {
	const [step] = require('../data/mechanics-public.json').quests[5527].steps;
	assert.deepEqual([step.action, step.target.type, step.target.id], ['accept', 'npc', 11801]);
	assert.match(step.fact, /inside Dire Maul once/);
});

test('Goblin Lockpicks is a one-talk hand-in at Veenix, only while The Horn of Xelthos is in the log (#3161, #3213)', () => {
	assert.equal(corrections.quests[78270].set.direct, true);
	const [step] = require('../data/mechanics-public.json').quests[78270].steps;
	assert.deepEqual([step.action, step.target.type, step.target.id], ['turnin', 'npc', 4086]);
	assert.match(step.fact, /only while The Horn of Xelthos is in your quest log/);
});

test('Burbik Gearspanner sells no Fishing Pole: off its vendor list (#3037)', () => {
	assert.deepEqual(corrections.items[6256].removeVendors, [5163]);
});

test('Damp Note requires The Essence of Aku\'Mai on the recorded Priestess drop, not on its follow-up quest (#1923)', () => {
	assert.deepEqual(corrections.items[16790].dropRequires, { npc: { 4802: [6563] } });
	assert.match(corrections.items[16790].source.ref, /#1923.*6820003090/);
	assert.notEqual(corrections.quests[6564]?.set?.pre?.includes(6563), true, 'accepting the root is enough; it is not a completion prerequisite');
});

// #3918 (Deadshot): a Gnome Mage held Forever's An Earnest Proposition 84149 while the Lookup guide for the chain
// waited for the Classic 8907, since 8922 did not follow 84149 and the data gave it no class or objectives. Every
// version players' quest logs held or Deliana and Mokvar offered (game build 70959) is one of A Supernatural Device's
// prerequisites on its side, for its class, with the side's samples and the class's bracers, given and taken back by
// the side's giver.
test('A Supernatural Device follows every recorded class version of An Earnest Proposition (#3918, #3081)', () => {
	const SAMPLE = { 8922: 21928, 8923: 22381 };
	const GIVER = { 8922: 230319, 8923: 230317 };
	const versions = [
		[84149, 8922, 128, 16683], // Mage: Magister's Bindings
		[84150, 8922, 2, 16722], // Paladin: Lightforge Bracers
		[84152, 8922, 8, 16710], // Rogue: Shadowcraft Bracers
		[84160, 8923, 64, 16671], // Shaman: Bindings of Elements
		[84161, 8923, 256, 16703], // Warlock: Dreadmist Bracers
		[97411, 8923, 2, 16722], // Paladin (Horde): Lightforge Bracers
	];
	for (const [id, device, cls, bracers] of versions) {
		assert.ok(corrections.quests[device].set.preAny.includes(id), `${device} follows ${id}`);
		const { set, remove } = corrections.quests[id];
		assert.ok(!remove, `${id} stays in the data`);
		assert.equal(set.classes, cls, `${id}'s class`);
		assert.equal(set.next, device, `${id} leads to ${device}`);
		assert.deepEqual(set.objectives.map((o) => [o.id, o.count]), [[SAMPLE[device], 15], [bracers, 1]], `${id}'s objectives`);
		for (const end of [set.start, set.end].filter(Boolean)) assert.deepEqual(end.npc, [GIVER[device]], `${id} at its side's giver`);
	}
});

// #4025 (Tauren Druid, 84155), #3765 (Night Elf Druid, 84147), #4016: the versions no recording had yet carried no
// class, so the Lookup chain sent every class without one in its log to the first of them (the Hunter's 84148, the
// Druid's 84155), which the giver never offers it; and the Alliance Druid's 84147 had left the data. Each side's
// A Supernatural Device now follows one version per class, and each version names its class and that class's bracers.
test('A Supernatural Device follows one class-locked An Earnest Proposition per class on each side (#4025, #3765)', () => {
	const BRACERS = { 1: 16735, 2: 16722, 4: 16681, 8: 16710, 16: 16697, 64: 16671, 128: 16683, 256: 16703, 1024: 16714 };
	const SAMPLE = { 8922: 21928, 8923: 22381 };
	for (const device of [8922, 8923]) {
		const classes = [];
		for (const id of corrections.quests[device].set.preAny) {
			const entry = corrections.quests[id];
			assert.ok(entry && entry.set && !entry.remove, `${id} has a record and stays in the data`);
			const { classes: cls, next, objectives } = entry.set;
			assert.ok(BRACERS[cls], `${id} names one class`);
			classes.push(cls);
			assert.equal(next, device, `${id} leads to ${device}`);
			assert.deepEqual(objectives.map((o) => [o.id, o.count]), [[SAMPLE[device], 15], [BRACERS[cls], 1]], `${id}: the samples and its class's bracers`);
		}
		assert.deepEqual(classes.slice().sort((a, b) => a - b), Object.keys(BRACERS).map(Number), `${device}: one version per class`);
	}
	assert.ok(corrections.quests[8922].set.preAny.includes(84147), 'the Alliance Druid version 84147 leads to 8922');
});

// #4169 (Swiftfyre, Skyborne Hunter 58): the Blackrock Spire pick-up guide's step at Deliana listed five copies of
// Just Compensation, none of them offered, and waited on them. Forever's copies of the Dungeon Set 2 chain's
// class quests had no class and no prerequisite, so every class saw every copy from the first step. Each copy now
// names its class (by its set pieces) and the quest before it (as the Classic copy for that class has it), and
// the Classic copies that a Forever copy for the same class replaces, at the Classic Deliana or Mokvar whom
// players never meet, leave the data.
test('Dungeon Set 2: each Forever copy of Just Compensation, Anthion\'s Parting Words and Saving the Best for Last has its class and prerequisite (#4169)', () => {
	// id: [class, the quest before it]
	const copies = { 84163: [1024, 8977], 84164: [4, 8977], 84165: [128, 8977], 84166: [2, 8977], 84167: [16, 8977], 84168: [8, 8977], 84169: [256, 8977], 84170: [1, 8977], 97448: [64, 8977],
		84171: [1024, 8978], 84172: [4, 8978], 84173: [128, 8978], 84174: [16, 8978], 84175: [8, 8978], 84176: [64, 8978], 84177: [256, 8978], 84178: [1, 8978], 97412: [2, 8978],
		84179: [1024, 9015], 84180: [4, 9015], 84181: [128, 9015], 84182: [2, 9015], 84183: [16, 9015], 84184: [8, 9015], 84186: [1, 9015],
		84187: [1024, 9015], 84188: [4, 9015], 84189: [128, 9015], 84190: [16, 9015], 84191: [8, 9015], 84192: [64, 9015], 84193: [256, 9015], 84194: [1, 9015],
		84195: [1024, 8997], 84196: [4, 8997], 84200: [8, 8997], 84202: [1, 8997], 84203: [1024, 8998], 84208: [64, 8998], 84210: [1, 8998] };
	for (const [id, [cls, pre]] of Object.entries(copies)) {
		const entry = corrections.quests[id];
		assert.ok(entry && entry.set && !entry.remove, `${id} has a record`);
		assert.equal(entry.set.classes, cls, `${id}'s class`);
		assert.deepEqual(entry.set.preAny, [pre], `${id} after ${pre}`);
	}
	for (const id of [8951, 8952, 8953, 8954, 8955, 8956, 8957, 8959, 9016, 9017, 9018, 9019, 9020, 9021, 9022, 8999, 9000, 9004, 9006, 9007, 9011, 9013]) {
		assert.equal(corrections.quests[id] && corrections.quests[id].remove, true, `the Classic copy ${id} leaves the data`);
	}
});

// #4169's sweep: Bodley's class-group quests (four versions each, by class group, per the server's world database
// and Factoruide) had no class in the data, so every class saw all four at his step, as at Deliana.
test('Bodley gives each class group its own Components of Importance and Valthalak amulet quests (#4169)', () => {
	const groups = { 8962: 129, 8963: 1280, 8964: 12, 8965: 82, 8966: 129, 8967: 1280, 8968: 12, 8969: 82,
		8985: 9, 8986: 1090, 8987: 144, 8988: 260, 8989: 1090, 8990: 9, 8991: 144, 8992: 260 };
	for (const [id, cls] of Object.entries(groups)) {
		assert.equal(corrections.quests[id] && corrections.quests[id].set && corrections.quests[id].set.classes, cls, `${id}'s classes`);
	}
	// The four of each set together are every class, once.
	for (const set of [[8962, 8963, 8964, 8965], [8966, 8967, 8968, 8969], [8985, 8986, 8987, 8988], [8989, 8990, 8991, 8992]]) {
		assert.equal(set.reduce((m, id) => m + groups[id], 0), 1503, `${set}: every class once`);
	}
});

// #4169's sweep: Forever's Horde Paladin charger chain at Danitha Morr had no prerequisites, so Justice and
// Retribution (97185, on the Dire Maul and Scholomance pick-up pages) read as open for every Horde Paladin; and
// the Alliance's The Darkreaver Menace (97169, Scholomance) had no class or prerequisite, unlike the Horde's
// Shaman-only 7668 after 7667.
test('the Horde Paladin charger chain and the Alliance Darkreaver Menace have their prerequisites (#4169)', () => {
	const after = { 97175: 97174, 97177: 97175, 97176: 97177, 97182: 97176, 97179: 97178, 97180: 97179, 97184: 97183, 97185: 97184, 97169: 97168 };
	for (const [id, pre] of Object.entries(after)) {
		assert.deepEqual(corrections.quests[id] && corrections.quests[id].set && corrections.quests[id].set.preAny, [pre], `${id} after ${pre}`);
	}
	assert.equal(corrections.quests[97169].set.classes, 64, 'The Darkreaver Menace 97169 is the Shaman\'s');
});

// #4169's hotfix build: removing the Classic Anthion's Parting Words copies took Bodley's Unfortunate Fate's
// prerequisites with them (the Horde's 9032 had none left, the Alliance's 8960 only the Warlock's 8958). It
// follows any class's Forever copy now.
test('Bodley\'s Unfortunate Fate follows Forever\'s Anthion\'s Parting Words on each side (#4169)', () => {
	assert.deepEqual(corrections.quests[8960].set.preAny, [84179, 84180, 84181, 84182, 84183, 84184, 84186, 8958]);
	assert.deepEqual(corrections.quests[9032].set.preAny, [84187, 84188, 84189, 84190, 84191, 84192, 84193, 84194]);
	for (const id of [8960, 9032]) assert.deepEqual(corrections.quests[id].set.pre, [], `${id}: no all-of prerequisite left over`);
});

// The check behind it: a quest whose prerequisite the corrections remove keeps a prerequisite the corrections
// give it, unless another of its prerequisites stays. Reads the built data (skips without it).
test('no quest loses all its prerequisites to a removal without a record that gives it new ones (#4169)', { skip: require('./helpers/data').needs('quests.json') }, () => {
	const built = JSON.parse(fs.readFileSync(path.join(require('./helpers/data').DATA, 'quests.json'), 'utf8'));
	const removed = new Set(Object.entries(corrections.quests).filter(([, e]) => e && e.remove).map(([id]) => Number(id)));
	const bad = [];
	for (const [id, q] of Object.entries(built)) {
		if (removed.has(Number(id))) continue;
		const set = (corrections.quests[id] && corrections.quests[id].set) || {};
		for (const f of ['pre', 'preAny', 'preAll']) {
			const v = Array.isArray(q[f]) ? q[f] : [];
			if (!v.some((x) => removed.has(x))) continue;
			const left = v.filter((x) => !removed.has(x));
			const given = ['pre', 'preAny', 'preAll'].some((k) => Array.isArray(set[k]) && set[k].length && !set[k].some((x) => removed.has(x)));
			if (!given && (left.length === 0 || left.length < v.length / 2)) bad.push(`${id} ${f}: ${v.join(',')} -> ${left.join(',') || 'none'}`);
		}
	}
	assert.deepEqual(bad, []);
});

// #4169's hotfix build: with the Classic Anthion's Parting Words and Saving the Best for Last copies gone, the tier
// 0.5 pieces they reward had no quest source left (Lookup: "no known source"). Each Forever copy that replaces one
// rewards what the Classic copy for that class does (the server dump's RewardItem1-4).
test('Forever\'s Set 2 copies reward the pieces of the Classic copies they replace (#4169)', () => {
	const rewards = { 84179: [22107, 22111, 22112], 84187: [22107, 22111, 22112], 84180: [22016, 22017, 22061], 84188: [22016, 22017, 22061],
		84181: [22064, 22067, 22068], 84189: [22064, 22067, 22068], 84182: [22087, 22092, 22093], 84183: [22082, 22084, 22085], 84190: [22082, 22084, 22085],
		84184: [22003, 22007, 22008], 84191: [22003, 22007, 22008], 84192: [22096, 22100, 22101], 84193: [22072, 22073, 22076],
		84186: [21995, 22000, 22001], 84194: [21995, 22000, 22001], 84195: [22109, 22113], 84203: [22109, 22113], 84196: [22013, 22060],
		84200: [22005, 22009], 84202: [21997, 21999], 84210: [21997, 21999], 84208: [22097, 22102] };
	for (const [id, items] of Object.entries(rewards)) {
		const r = corrections.quests[id] && corrections.quests[id].set && corrections.quests[id].set.rewards;
		assert.deepEqual(r && r.items, items, `${id}'s reward items`);
	}
});

// The check behind it: an item whose only sources in the built Codex are quests the corrections remove must get a
// quest source back from a record (a `set.rewards` naming it), or Lookup reads "no known source" after the next
// build. Reads the built Codex (skips without it).
test('no item loses its only quest sources to a removal without a record that rewards it again (#4169)', { skip: require('./helpers/data').needs('codex/items.json') }, () => {
	const items = JSON.parse(fs.readFileSync(path.join(require('./helpers/data').DATA, 'codex', 'items.json'), 'utf8'));
	const removed = new Set(Object.entries(corrections.quests).filter(([, e]) => e && e.remove).map(([id]) => Number(id)));
	const rewarded = new Set();
	for (const e of Object.values(corrections.quests)) {
		const r = e && e.set && e.set.rewards;
		for (const it of [...((r && r.items) || []), ...((r && r.choices) || [])]) rewarded.add(it);
	}
	const bad = [];
	for (const [id, it] of Object.entries(items)) {
		const sources = it.sources || [];
		if (!sources.length || !sources.every((s) => s.type === 'quest' && removed.has(s.quest))) continue;
		if (!rewarded.has(Number(id))) bad.push(`${id} ${it.name}: only from ${sources.map((s) => s.quest).join(', ')}`);
	}
	assert.deepEqual(bad, []);
});

// #4169's hotfix build: the corrections removed the Classic Saving the Best for Last copies (8999, 9000, 9004,
// 9006, 9007, 9011, 9013) that the Legacy Challenges guide still accepted, and the guide no longer compiled
// ("quest 8999 is not in data"). No guide (guides/, experimental/) may accept, turn in or name in a `quest N`
// objective a quest the corrections remove.
test('no guide accepts, turns in or works on a quest the corrections remove (#4169)', () => {
	const removed = new Set(Object.entries(corrections.quests).filter(([, e]) => e && e.remove).map(([id]) => Number(id)));
	const root = path.join(__dirname, '..');
	const files = [];
	const walk = (dir) => {
		if (!fs.existsSync(dir)) return;
		for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
			const p = path.join(dir, e.name);
			if (e.isDirectory()) walk(p);
			else if (e.name.endsWith('.guide')) files.push(p);
		}
	};
	walk(path.join(root, 'guides'));
	walk(path.join(root, 'experimental'));
	const bad = [];
	for (const file of files) {
		fs.readFileSync(file, 'utf8').split('\n').forEach((line, i) => {
			const code = line.split('--')[0];
			if (code.trimStart().startsWith('#')) return;
			for (const m of code.matchAll(/^\s*(?:accept|turnin)\s+(\d+)|\bquest\s+(\d+)/g)) {
				const id = Number(m[1] || m[2]);
				if (removed.has(id)) bad.push(`${path.relative(root, file)}:${i + 1}: ${id}`);
			}
		});
	}
	assert.ok(files.length > 100, 'the guides are read');
	assert.deepEqual(bad, []);
});

test('the overlay takes mechanics flat or under quests; mechanics 603 and 1064 stay private', () => {
	const out = overlayCorrections({ mechanics: {} }, { mechanics: { quests: { 603: { note: 'nested' } }, 1064: { note: 'flat' } } });
	assert.deepEqual(Object.keys(out.mechanics).sort(), ['1064', '603']);
	assert.ok(!('603' in corrections.mechanics) && !('1064' in corrections.mechanics));
});

test('the private overlay adds its entries and merges shared ones field by field', () => {
	const pub = { _about: 'public', quests: { 1: { set: { start: { npc: [2] } }, source: { kind: 'tdb', ref: 'x' }, note: 'a' } }, npcs: {} };
	const priv = { _about: 'private', quests: { 1: { set: { races: 8 }, note: 'b' }, 3: { set: { xp: 10 }, note: 'c' } }, objects: { 4: { addSpawns: {}, note: 'd' } } };
	assert.deepEqual(overlayCorrections(pub, priv), {
		_about: 'public',
		quests: { 1: { set: { start: { npc: [2] }, races: 8 }, source: { kind: 'tdb', ref: 'x' }, note: 'b' }, 3: { set: { xp: 10 }, note: 'c' } },
		npcs: {},
		objects: { 4: { addSpawns: {}, note: 'd' } },
	});
	assert.deepEqual(pub.quests[1].set, { start: { npc: [2] } }, 'the public corrections stay as they were');
});

test('data build reads the overlay from data/local only when it is there, or the file it is given', () => {
	const root = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-corr-'));
	assert.deepEqual(loadCorrections({ root }), corrections, 'no overlay: the public corrections alone');
	fs.mkdirSync(path.join(root, 'data', 'local'), { recursive: true });
	const file = path.join(root, 'data', 'local', 'corrections-private.json');
	fs.writeFileSync(file, JSON.stringify({ quests: { 1: { set: { xp: 1 }, note: 'private' } } }));
	assert.deepEqual(loadCorrections({ root }).quests[1], { set: { xp: 1 }, note: 'private' });
	assert.deepEqual(loadCorrections({ root, privateFile: false }), corrections, '--no-corrections-private');
	assert.deepEqual(loadCorrections({ privateFile: file }).quests[1].note, 'private', '--corrections-private <file>');
	fs.rmSync(root, { recursive: true, force: true });
});

test('every prerequisite correction blocks the quest until its prerequisites are turned in', () => {
	const dead = [];
	for (const [id, entry] of Object.entries(corrections.quests || {})) {
		const set = entry && entry.set;
		if (!set || !['pre', 'preAll', 'preAny'].some((k) => Array.isArray(set[k]) && set[k].length > 0)) continue;
		const { all, any } = blockingPrereqs({ id: Number(id), start: { npc: [1] }, ...set });
		if (all.length === 0 && any.length === 0) dead.push(id);
	}
	assert.deepEqual(dead, [], `corrections that set prerequisites but block nothing: ${dead.join(', ')}`);
});

// A timed quest's `limit` (seconds once taken): the Forever TDB's TimeAllowed through the data build's KB step, a
// Forever quest's from a correction. Dynamic Questing takes a timed quest early only when the walk still fits.
test('Grace of An\'she and Mu\'sha allows ten minutes; a time limit is a whole number of seconds', () => {
	assert.equal(corrections.quests[95805].set.limit, 600);
	const bad = Object.entries(corrections.quests).filter(([, e]) => e.set && 'limit' in e.set && !(Number.isInteger(e.set.limit) && e.set.limit > 0));
	assert.deepEqual(bad.map(([id]) => id), []);
});

test('A Void Path allows four minutes from the accept: the game times it (players\' recordings), its text says how long', () => {
	const entry = corrections.quests[98252];
	assert.equal(entry.set.limit, 240);
	assert.ok([].concat(entry.source).some((s) => s.kind === 'recording' && /timer/.test(s.ref)), 'a recording source for the timer');
});

test('the release data carries time limits: 95805 600 s, Scalding Mornbrew Delivery the TDB\'s 300 s, none on an untimed quest', (t) => {
	const file = path.join(__dirname, '..', 'data', 'forever', 'quests.json');
	if (!fs.existsSync(file)) return t.skip('no data/forever');
	const quests = JSON.parse(fs.readFileSync(file, 'utf8'));
	if (!Object.values(quests).some((q) => q.limit)) return t.skip('data/forever was built without the KB step (no time limits)');
	assert.deepEqual([quests[95805].limit, quests[3364].limit, quests[755].limit], [600, 300, undefined]);
});

test('Highland Hides waits for Young Crocolisk Skins, not Daily Delivery (#533)', () => {
	const { all, any } = blockingPrereqs({ id: 98815, start: { npc: [2094] }, ...corrections.quests[98815].set });
	assert.deepEqual({ all, any }, { all: [], any: [484] });
});

test('The Wrath of Rath\'mael waits for the second Rear Guard Patrol, which waits for the first (#849)', () => {
	const { all, any } = blockingPrereqs({ id: 92422, start: { npc: [251001] }, ...corrections.quests[92422].set });
	assert.deepEqual({ all, any }, { all: [], any: [99156] });
	assert.deepEqual(corrections.quests[99156].set.preAny, [356]);
});

test('A Void Path waits for Never Coming Back, handed in to the same giver (#1002, #984)', () => {
	const entry = corrections.quests[98252];
	assert.ok(entry, 'a correction for A Void Path');
	const { all, any } = blockingPrereqs({ id: 98252, start: { npc: [267214] }, ...entry.set });
	assert.deepEqual({ all, any }, { all: [], any: [98251] });
});

test('Moonbrook Espionage waits for Murloc Gills as well as The State of the Mines (#991)', () => {
	const { all, any } = blockingPrereqs({ id: 92747, start: { npc: [253092] }, ...corrections.quests[92747].set });
	assert.deepEqual({ all, any }, { all: [92744], any: [92745] });
});

test('Explosive Consultation waits for A Dynamite Plan as well as the second Detonation at a Distance (#3357)', () => {
	const { all } = blockingPrereqs({ id: 92752, start: { npc: [11026] }, preAny: [92751], ...corrections.quests[92752].set });
	assert.deepEqual(all, [92749, 92751]);
});

test('Report to Sen\'jin Village is Forgotten Loa Idols\' breadcrumb, not its prerequisite (#3214, #796)', () => {
	const set = corrections.quests[97225].set;
	assert.deepEqual(blockingPrereqs({ id: 97225, start: { npc: [3304] }, pre: [805], ...set }), { all: [], any: [] });
	assert.deepEqual(set.breadcrumbs, [805], 'held back while 805 is in the log');
});

// The hand-in guide leads to a placed objective with no id before the hand-in (Dungeons/Handin.lua, talksLeft).
test('More Valuable Than Gold\'s treasure is placed at Connery\'s Trunk, where it is handed in (#3382)', () => {
	const [o] = corrections.quests[96337].set.objectives;
	assert.deepEqual([o.type, o.id, o.map, o.x, o.y], ['event', null, 1436, 43.4, 67.9]);
});

test('The State of the Mines waits for both Testing the Wells and Murloc Gills (dungeon pre-quest sweep)', () => {
	const { all, any } = blockingPrereqs({ id: 92745, start: { npc: [253092] }, ...corrections.quests[92745].set });
	assert.deepEqual({ all, any }, { all: [92742, 92744], any: [] });
});

test('the Moonsilver Blade chain before Old Fire-Eye is taken in order (dungeon pre-quest sweep)', () => {
	const chain = [[95036, 259620, 95034], [95111, 248840, 95036], [95125, 3539, 95111], [95126, 3539, 95125]];
	for (const [id, npc, pre] of chain) {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		assert.deepEqual(blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set }), { all: [], any: [pre] }, `${id} after ${pre}`);
	}
});

test('The New Plague waits for the A Recipe For Death chain, handed in to its last part (#867)', () => {
	const entry = corrections.quests[95216];
	assert.ok(entry, 'a correction for The New Plague');
	const { all, any } = blockingPrereqs({ id: 95216, start: { npc: [11835] }, ...entry.set });
	assert.deepEqual({ all, any }, { all: [], any: [451] });
});

test('Crocs of the Sky waits for Apprentice\'s Duties, and The Shamed Lieutenant for A Friend of the Family (#872 sweep)', () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	assert.deepEqual(blocks(98072, 2094), { all: [], any: [471] }, 'James Halloran, Menethil Harbor');
	assert.deepEqual(blocks(98219, 928), { all: [], any: [98191] }, 'Lord Grayson Shadowbreaker, Stormwind');
});

// Bennistrov (#1354): Highlord Bolvar Fordragon's A Friend of the Family (98191) is offered only once Captain
// Stoutfist's (98190) is handed in to him. Without the prerequisite the guide still sent a player who had skipped
// 98190 to Bolvar for 98191. The follow-up sweep (players' recordings: taken only after the quest before, refused
// before it; a second source agreeing) found the same gap in these chains.
test('Follow-ups wait for the quest before them, so a skipped one takes its follow-up with it (#1354 sweep)', () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	for (const [id, npc, any, who] of [
		[98191, 1748, [98190], 'Highlord Bolvar Fordragon, Stormwind (#1354)'],
		[98394, 11802, [98393], 'Dendrite Starblaze, Moonglade (Druid cat form)'],
		[98396, 11957, [98394], 'the Great Cat Spirit'],
		[98731, 11957, [98396], 'the Great Cat Spirit'],
		[98397, 11802, [98731, 98738], 'Dendrite Starblaze: either blessing'],
		[78089, 3663, [78088], 'Delgren the Purifier (Paladin cloak)'],
		[78090, 5492, [78089], 'Katherine the Pure'],
		[78091, 5495, [78090], 'Ursula Deline: Earning Your Salt'],
		[78092, 5495, [78091], 'Ursula Deline'],
		[91859, 248840, [91858], 'Trevan Rol (Lumina Windsinger chain)'],
		[91860, 259611, [91859], 'Deathguard Baldren'],
		[96204, 248755, [91862], 'Lumina Windsinger'],
		[95034, 259620, [96204], 'Lumina Windsinger'],
		[96264, 259023, [94789], 'Veyric Thunderhame (Shaman Call of Air)'],
		[92519, 12920, [97539], 'Doctor Gregory Victor, Hammerfall'],
		[92457, 269127, [92432], 'Image of Archmage Modera (Kirin Tor)'],
		[95770, 2519, [95748], 'Kin\'weelay: Locating the Lost City after The Gurubashi Legends of Old'],
	]) assert.deepEqual(blocks(id, npc), { all: [], any }, who);
	const fenris = corrections.quests[91861];
	assert.ok(fenris, 'a correction for 91861');
	assert.deepEqual(blockingPrereqs({ id: 91861, start: { object: [566037] }, ...fenris.set }), { all: [], any: [91860] }, 'the Charred Remains');
});

test('Seeking Caitlin is closed by Lost in the Thicket Things, its breadcrumb target (#533)', () => {
	const quests = { 95737: { id: 95737, ...corrections.quests[95737].set }, 95647: { id: 95647 } };
	assert.deepEqual(closedByOf(95737, quests), [95647]);
});

test('Daily Delivery is closed by Young Crocolisk Skins, its breadcrumb target (#615)', () => {
	const quests = { 469: { id: 469, ...corrections.quests[469].set }, 484: { id: 484 } };
	assert.deepEqual(closedByOf(469, quests), [484]);
});

// J's report (#1643): Connor Rivers stops offering James Hyal once They Call Him Smiling Jim is handed in (the world
// DB's quest conditions), so the correction closes it on 1282 as well as on the quest it leads to.
test('James Hyal is closed by They Call Him Smiling Jim as well as by its second part (#1643)', () => {
	const quests = { 1301: { id: 1301, breadcrumbFor: 1302, ...corrections.quests[1301].set }, 1302: { id: 1302, breadcrumbs: [1301], excl: [1282] }, 1282: { id: 1282, excl: [1302] } };
	assert.deepEqual(closedByOf(1301, quests), [1302, 1282]);
});

test('Benedict\'s Chest opens with Benedict\'s Key (#467)', () => {
	assert.deepEqual(corrections.objects[3239].set.lock, { item: 4882 });
});

// #2014: Forever moved Henrig Lonebrow's Journal about 110 yd south of its old spot (every recorded loot since
// 2026-11-10 lies there); the Razorfen Kraul pick-up guide's collect step pointed at the old one.
test("Henrig Lonebrow's Journal lies where players loot it now, its old spot gone (#2014)", () => {
	assert.deepEqual(corrections.objects[19861].set.spawns, { 1441: { f: 'e', pts: [[31.29, 28.05]] } });
});

// #2466: the Ancient Egg's world point is inside both The Hinterlands' and Arathi Highlands' map frames, and it was
// read in Arathi's (81.3,26.2), so the Sunken Temple pick-up guide's collect step led to Hammerfall. Players loot it
// in The Hinterlands.
test('The Ancient Egg lies in The Hinterlands, where players loot it, not on Arathi Highlands\' map (#2466)', () => {
	assert.deepEqual(corrections.objects[175889].set.spawns, { 1425: { f: 'e', pts: [[57.48, 86.69]] } });
});

// #1992, #2007: Archmage Tervosh and Lady Jaina Proudmoore show at Sentry Point and North Point Tower only to players on
// The Missing Diplomat; the corrections had made those spots their spawns, so the Maraudon pick-up guide sent everyone to
// North Point Tower for Shadowshard Fragments. Their spawns are Theramore's tower; the chain's steps keep their own spots.
test('Archmage Tervosh and Lady Jaina stand in Theramore\'s tower; the Missing Diplomat spots are no spawns of theirs (#1992)', () => {
	assert.deepEqual(corrections.npcs[4967].set.spawns, { 1445: { f: 'e', pts: [[66.42, 49.26]] } }, 'Archmage Tervosh');
	assert.deepEqual(corrections.npcs[4968].set.spawns, { 1445: { f: 'e', pts: [[66.27, 49.04]] } }, 'Lady Jaina Proudmoore');
});

// The 0.4.0 moved-object sweep (players' recorded loot spots against the data's spawns, in world yards through each
// map's own frame): quest objects every player loots where the data had no place, or only one place of several.
test('quest objects stand where players loot them: Krom\'zar\'s Banner, the coffers, the Magenta Caps, the Box of Assorted Parts', () => {
	const at = (id, map) => corrections.objects[id].addSpawns[map];
	assert.deepEqual(at(164690, 1413), { f: 'e', pts: [[44.44, 28.15]] }, "Krom'zar's Banner, which had no place (12 people loot it there)");
	assert.equal(at(103574, 1458).pts.length, 7, 'the Undercity coffers, which had no place');
	const caps = at(128293, 1418).pts;
	for (const p of [[37.57, 15.25], [38.22, 17.03], [41.01, 15.01], [34.04, 24.42]]) assert.ok(caps.some((q) => q[0] === p[0] && q[1] === p[1]), `Magenta Cap Clusters at ${p}`);
	const box = at(19019, 1436).pts;
	for (const p of [[43.98, 67.79], [44.9, 71.1], [26.46, 72.78]]) assert.ok(box.some((q) => q[0] === p[0] && q[1] === p[1]), `Box of Assorted Parts at ${p}`);
	assert.ok(at(19019, 1413).pts.some((q) => q[0] === 61.92 && q[1] === 3.62), 'and in the Barrens where players loot it');
});

// Merkanex (#2861): the City of Dalaran pick-up guide sent a Horde player up the stairs to the guards for Dalaran
// Patrols, and to 16,77 for the slaves. Players kill both around the ruins outside the dome, none south of 68.
test('Dalaran Summoners and Elemental Slaves stand around the ruins outside the dome, none at 10-20,73-81 (#2861)', () => {
	for (const id of [2358, 2359]) {
		const pts = corrections.npcs[id].addSpawns[1416].pts;
		assert.ok(pts.length >= 20, `npc ${id}: the recorded kill spots`);
		for (const [x, y] of pts) assert.ok(x >= 16 && x <= 28 && y >= 49 && y <= 67, `npc ${id}: ${x},${y} outside the ruins`);
	}
});

test('The Glowing Shard\'s one line is to speak with Sputtervalve in Ratchet, so its hand-in guide goes there first (#1326)', () => {
	assert.deepEqual(corrections.quests[6981].set.objectives, [{ type: 'talk', id: 3442, count: 1, text: 'Speak with someone in Ratchet about the Glowing Shard' }]);
});

test('dungeon turn-in NPCs the data placed nowhere stand where players hand in to them (#1326 sweep)', () => {
	assert.deepEqual(corrections.npcs[13155].set.spawns, { 1437: { f: 'e', pts: [[51.41, 59.23]] } }, 'Deathstalker Agent: Dragonmaw Rumors and Open the Maw, Wetlands');
	// Stormwind City's spots in the frame of the map the game shows (live, with the harbour): read in the older map's
	// frame they lie about 100 yd south, toward the Trade District, and the arrow led away from her (#1870).
	assert.deepEqual(corrections.npcs[15991].set.spawns, { 1453: { f: 'l', pts: [[68.15, 29], [70.18, 29.86]] } }, 'Lady Dena Kennedy: Crest of Lordaeron, Stormwind City');
});

test('the Dalaran traitors stand in the camp south of their Classic spot, where players kill them (#1633)', () => {
	const at = (id) => corrections.npcs[id].set.spawns;
	assert.deepEqual(at(2414), { 1416: { f: 'l', pts: [[16.8, 89.4]] }, 1424: { f: 'l', pts: [[23.6, 26.7]] } }, 'Kegan Darkmar: Bloodstone Oval');
	assert.deepEqual([2411, 2412, 2413].map((id) => at(id)[1416].pts), [[[19.5, 90]], [[19.6, 90.9]], [[19.3, 91.5]]], 'Ricter, Alina and Dermot');
	for (const id of [2411, 2412, 2413, 2414]) assert.ok(at(id)[1424], `npc ${id}: its Hillsbrad Foothills spot moves too`);
});

test('dungeon quests started or handed in inside the dungeon name the NPC there, and the instance it stands in', () => {
	const q = (id) => corrections.quests[id] && corrections.quests[id].set;
	const inst = (id) => corrections.npcs[id] && corrections.npcs[id].set.instances;
	assert.deepEqual([q(95250).start.npc, q(95250).end.npc, inst(265701)], [[265701], [265701], [2999]], 'Abominable Creatures: Captain Truman, Ruins of Lordaeron');
	assert.deepEqual([q(96987).start.npc, q(96987).end.npc, inst(268743)], [[268743], [268743], [2959]], 'Opportunistic Education: Rexxie Copperclutch, City of Dalaran');
	assert.deepEqual([q(95647).end.npc, q(95647).objectives, inst(262681)], [[262681], [{ type: 'talk', id: 262681, count: 1, text: 'Ardin Grassman' }], [2998]], 'Lost in the Thicket Things: handed in to Ardin Grassman inside, not Caitlin');
	assert.deepEqual([q(95772).end.npc, inst(262465)], [[262465], [2998]], 'Songblade Search: handed in to Daewyn Songblade inside, not Dorin');
	assert.deepEqual(blockingPrereqs({ id: 95795, ...q(95795) }), { all: [], any: [95772] }, 'Fallen in the Fen: from Daewyn, after Songblade Search');
	assert.deepEqual(q(95795).start.npc, [262465]);
	assert.deepEqual(blockingPrereqs({ id: 95809, ...q(95809) }), { all: [], any: [95647] }, 'Heartwoven: from Ardin, after Lost in the Thicket Things');
	assert.deepEqual(q(95809).start.npc, [262681]);
	assert.deepEqual(q(98824).objectives, [{ type: 'item', id: 287959, count: 1, text: 'Titan Relic' }], "Prehistoric Prism: the relic Whelgar hands over, not Lost Relic Carry's");
});

test('Dalaran Patrols waits for both Prison Break In and Key to the City, Shrewd Negotiations for Heart of Disruption (#1837)', () => {
	const blocks = (id) => blockingPrereqs({ id, start: { npc: [2410] }, ...corrections.quests[id].set });
	assert.deepEqual(blocks(545), { all: [544, 93680], any: [] }, 'Magus Wordeen Voidglare: Dalaran Patrols');
	assert.deepEqual(blocks(97287), { all: [], any: [96984] }, 'Magus Wordeen Voidglare: Shrewd Negotiations');
});

// Ataxia (#2337): Nerlokh offers Khan Jehn only once his Valley of Bones chain is done, ending with Checking Things Out
// (93122), whose quest data names Khan Jehn as its next quest; the data had no prerequisite, so the quest read as open
// from the first visit to him (0.3.7.2's centaur reputation guide sent players to take it there).
test('Khan Jehn waits for Checking Things Out, the end of Nerlokh\'s chain (#2337)', () => {
	const blocks = (id) => blockingPrereqs({ id, start: { npc: [253177] }, ...corrections.quests[id].set });
	assert.deepEqual(blocks(93128), { all: [93122], any: [] }, 'Nerlokh: Khan Jehn');
	assert.equal(corrections.quests[93128].set.races, null, 'still open to every race');
});

// Sable (#2507): Shadumbra walks a long path through Raynewood Retreat, and the kill step pointed only at her spawn at
// its western end (57.5,56.05). Her points follow the path players kill her on, from the road to its north-east end;
// the two other Ashenvale hunt targets walk paths too (Forever's world database, players' recordings).
test('Shadumbra has her whole path through Raynewood Retreat, not one spot at its western end (#2507)', () => {
	const pts = corrections.npcs[12677]?.set?.spawns?.[1440]?.pts || [];
	assert.ok(pts.some(([x, y]) => x === 57.5 && y === 56.05), 'her spawn stays one of them');
	assert.ok(pts.some(([x, y]) => x > 61 && y < 50.5), 'the north-east end, where the report found her');
	assert.ok(pts.length >= 4, `points along the path: ${JSON.stringify(pts)}`);
	for (const [id, name] of [[12678, 'Ursangous'], [12676, 'Sharptalon']]) {
		assert.ok((corrections.npcs[id]?.set?.spawns?.[1440]?.pts || []).length >= 4, `${name}: points along his path`);
	}
});

// Logan (#2672) and a Korean report (#1237): Nikova Raskol walks a loop through Old Town, and the Stockade's pick-up
// guide pointed at one corner of it (76.4,63.7) while players met her anywhere on it. #2519: quest givers and enders
// who walk a path of 140 yd or more in Forever's world database, have one spot in the data and no walk circle, and
// whom 3 or more people met more than 25 yd from that spot in players' recordings, get points along their path.
test('quest givers who walk a path have points along it, not one spot (#2519, #2672, #1237)', () => {
	const nikova = corrections.npcs[1721]?.set?.spawns?.[1453];
	assert.equal(nikova?.f, 'l', "Nikova's points are in the live frame, as her spot");
	const pts = nikova?.pts || [];
	assert.ok(pts.some(([x, y]) => x > 76 && y > 63), 'the corner the guide pointed at stays one of them');
	for (const [x, y, where] of [[73, 55, 'north end'], [76, 60, 'east side'], [71, 59, 'west side']]) {
		assert.ok(pts.some(([px, py]) => Math.hypot(px - x, py - y) < 1.5), `her loop's ${where} (${x},${y}), where players met her`);
	}
	for (const [id, map, name] of [[1481, 1437, 'Bart Tidewater'], [1742, 1420, 'Deathguard Bartholomew'], [2616, 1445, 'Privateer Groy'], [3140, 1411, 'Lar Prowltusk'], [5639, 1454, 'Craven Drok']]) {
		assert.ok((corrections.npcs[id]?.set?.spawns?.[map]?.pts || []).length >= 3, `${name}: points along the path`);
	}
});

test('Daniel Stitchsong stands at the reported Three Corners spot in live coordinates (#1966)', () => {
	assert.deepEqual(corrections.npcs[256734]?.addSpawns, {
		1433: { f: 'l', pts: [[9.96, 72.71]] },
	}, 'replace the old Redridge point rather than keeping it as another destination');
});

// rockzors (#1235), JonnyDisco (#1250): Image of Archmage Modera offers Heart of Disruption only once the level 30 lead-in
// is handed in to her: An Alarming Request (92432) for the Alliance, Blood in the Streets (92434) for the Horde. The data
// had the lead-ins as optional, so the City of Dalaran pick-up guide sent level 28 characters to Silverpine for nothing.
test('Heart of Disruption waits for An Alarming Request (Alliance) and Blood in the Streets (Horde) (#1235, #1250)', () => {
	const blocks = (id) => blockingPrereqs({ id, start: { npc: [269127] }, ...corrections.quests[id].set });
	assert.deepEqual(blocks(92458), { all: [], any: [92432] }, 'Alliance: after An Alarming Request');
	assert.deepEqual(blocks(96984), { all: [], any: [92434] }, 'Horde: after Blood in the Streets');
});

// Kaxe (#2774): Aza'bek, who sells the Soothing Spices for "Swamp Eye" Jarl, stands still at the Crossroads (one TDB
// spawn, no path), and 56 people opened the vendor window there. The merged data had five points over about 220 yd, and the
// Horde Dustwallow Marsh guide's `buy 3713 nearest` pointed at one of them, 64 yd from the vendor.
test('Aza\'bek has one Crossroads spot, not five points across the hill (#2774)', () => {
	assert.deepEqual(corrections.npcs[248198]?.set?.spawns, {
		1413: { f: 'e', pts: [[49.74, 29.35]] },
	});
});

// Logan (#2851): Veyric Thunderhame, who takes Call of Air (94789), stands only in Arathi Highlands (12 people opened his
// window at 59.8,27.6, none met him in Ironforge). The merged data also gave him Eldrun Stormbreaker's Ironforge spot, so
// While you're here offered the hand-in beside Eldrun.
test('Veyric Thunderhame stands only in Arathi Highlands, not at Eldrun Stormbreaker\'s spot (#2851)', () => {
	assert.deepEqual(corrections.npcs[259023]?.set?.spawns, {
		1417: { f: 'l', pts: [[59.72, 27.59]] },
	});
});

test('class quests the data left open are locked to their class, and Magma or Lava? is open to everyone (class-quest card)', () => {
	const classes = (id) => corrections.quests[id] && corrections.quests[id].set.classes;
	assert.deepEqual([78261, 78307].map(classes), [8, 8], 'The Horn of Xelthos: Rogue');
	assert.equal(classes(93797), 128, 'Boughs in the Wind: Mage');
	assert.deepEqual([98341, 98404, 98738].map(classes), [1024, 1024, 1024], 'the Great Windborne Cat Spirit chain: Druid');
	const lava = corrections.quests[84396].set;
	assert.ok('classes' in lava && lava.classes === null, 'Magma or Lava?: no class limit');
	assert.ok('races' in lava && lava.races === null, 'Magma or Lava?: no race limit');
	assert.deepEqual(lava.end, { npc: [5497, 7825], object: [] }, 'its enders stay');
});

// #1490: The Great Outdoors' corrections gave it The Adventurer as its prerequisite, but the quest data also names The
// Adventurer as its breadcrumb (The Great Outdoors' `breadcrumbs`, The Adventurer's `breadcrumbFor`), and a breadcrumb
// never blocks, so the Codex had no prerequisite. Players' recordings: every Great Outdoors giver refuses it until The
// Adventurer is handed in. The corrections clear both breadcrumb links, so the prerequisite stands over the data's.
test('The Great Outdoors waits for The Adventurer, whatever breadcrumb links the data has (#1490)', () => {
	const pairs = { 95998: 96627, 96101: 96638, 96604: 96652, 96605: 96659, 96606: 96630, 96607: 96656, 96608: 96628 };
	for (const [g, a] of Object.entries(pairs).map(([g, a]) => [Number(g), a])) {
		const ge = corrections.quests[g];
		const ae = corrections.quests[a];
		assert.ok(ge && ae, `corrections for ${g} and ${a}`);
		// The records as the merged data has them (questie: breadcrumb links both ways), with the corrections applied.
		const quest = { id: g, start: { npc: [1] }, breadcrumbs: [a], ...ge.set };
		const adventurer = { id: a, start: { npc: [2] }, breadcrumbFor: g, ...ae.set };
		const { all, any } = blockingPrereqs(quest, (id) => (id === a ? adventurer : null));
		assert.deepEqual({ all, any }, { all: [], any: [a] }, `${g} after ${a}`);
	}
});

// Gnomeregan's pick-up guide (a Discord report, 2026-11-13): The Day After came into the log but was never handed in,
// so Ozzie Togglevolt had no Gnogaine to give. The quest data names The Day After as Gnogaine's prerequisite and as its
// breadcrumb, and a breadcrumb never blocks; players' recordings: all 28 people who took Gnogaine handed The Day After
// in first. The corrections clear the breadcrumb links, so the prerequisite stands and the guide hands it in on the way.
test('Gnogaine waits for The Day After, whatever breadcrumb links the data has (Gnomeregan pick-up)', () => {
	const quest = { id: 2926, start: { npc: [1268] }, pre: [2927], breadcrumbs: [2927], ...corrections.quests[2926].set };
	const dayAfter = { id: 2927, start: { npc: [6569] }, breadcrumbFor: 2926, ...corrections.quests[2927].set };
	const { all, any } = blockingPrereqs(quest, (id) => (id === 2927 ? dayAfter : null));
	assert.deepEqual({ all, any }, { all: [], any: [2927] });
});

// #2667 (GDcontroller, the Wildwood Chain's item guide): the guide started at Kaela Shadowspear, who did not offer On
// Guard in Stonetalon's second part (1085) before the first (1070, Sentinel Thenysil in Astranaar) was handed in, so it
// took two trips. The quest data names 1070 as 1085's prerequisite and as its breadcrumb, and a breadcrumb never blocks;
// players' recordings: all 58 people who took 1085 had handed 1070 in to Kaela seconds before. The corrections clear the
// breadcrumb links, so the prerequisite stands and the chain starts at Thenysil.
test('On Guard in Stonetalon waits for its first part, whatever breadcrumb links the data has (#2667)', () => {
	const quest = { id: 1085, start: { npc: [4080] }, pre: [1070], preAny: [1070], breadcrumbs: [1070], ...corrections.quests[1085].set };
	const first = { id: 1070, start: { npc: [4079] }, breadcrumbFor: 1085, ...corrections.quests[1070].set };
	const { all, any } = blockingPrereqs(quest, (id) => (id === 1070 ? first : null));
	assert.deepEqual({ all, any }, { all: [], any: [1070] });
});

// The 1.0.13 quest database's trace XP against our data (2026-11-08): 45 quests differed, every one confirmed by
// players' recorded hand-ins at a full-XP level, but for Harvesting the Harvesters (92911): one hand-in in the 2026-11-08
// count and none in the recordings archive now, so it stays as the data has it until a second source agrees. The corrections hold the recorded values, so the level model gets them.
test('quest XP the recordings confirm is held by the corrections (1.0.13 trace XP check)', () => {
	const xp = {
		91723: 525, 91732: 320, 91740: 875, 91745: 25, 91758: 35, 91772: 360, 92750: 120, 92751: 120, 95495: 140, 95507: 1000,
		95508: 1350, 95805: 360, 96130: 340, 96139: 1400, 96241: 2350, 96259: 2350, 96260: 1750, 96825: 550, 96874: 850, 97242: 110,
		97246: 110, 97249: 110, 97253: 1050, 97282: 850, 97326: 550, 97914: 625, 97926: 625, 97944: 270, 98094: 1000, 98251: 1400,
		98252: 925, 98298: 1150, 98319: 350, 99048: 80, 99049: 390, 99052: 1100, 99080: 875, 99082: 90, 99108: 270, 99127: 480,
		99131: 65, 99143: 480, 99159: 350, 99160: 525,
	};
	const got = Object.fromEntries(Object.keys(xp).map((q) => [q, corrections.quests[q] && corrections.quests[q].set.xp]));
	assert.deepEqual(got, Object.fromEntries(Object.entries(xp).map(([q, v]) => [q, v])));
});

test('Call of Fire has its third giver, The Horn of Xelthos its horn, and A Simmering Storm\'s chain stays Horde only (1.0.13 review)', () => {
	assert.deepEqual(corrections.quests[94449].set.start.npc, [258098, 258113, 257446], 'Teo Hammerstorm in Dun Morogh gives Call of Fire too');
	assert.deepEqual(corrections.quests[78261].set.objectives, [{ type: 'item', id: 210183, count: 1, text: 'Horn of Xelthos' }]);
	for (const q of [97281, 97282]) assert.equal(corrections.quests[q] && corrections.quests[q].set.races, 8589934770, `${q}: Horde races`);
});

test('QuestieDB 1.0.14 race lists narrower than the server keep the server\'s races: Zephras Isle, both Skyborne, the Horde Skyborne village, Call of Fire, the Horde Shaman chain', () => {
	const races = (id) => (corrections.quests[id] && 'races' in corrections.quests[id].set ? corrections.quests[id].set.races : undefined);
	const SKYBORNE = 2 ** 32 + 2 ** 33;
	const HORDE = 2 + 16 + 32 + 128 + 2 ** 33;
	const ALLIANCE = 1 + 4 + 8 + 64 + 2 ** 32;
	const zephras = [92460, 92461, 92462, 92463, 92472, 92516, 92550, 92553, 92682, 92685, 93160, 93165, 93317, 93320, 93926, 93951, 94486, 94489, 94568, 94897, 96101];
	assert.deepEqual(zephras.filter((id) => races(id) !== null), [], 'the Zephras Isle quests both Skyborne starts take have no race limit');
	assert.deepEqual([92474, 94003, 94006, 98404].map(races), [SKYBORNE, SKYBORNE, SKYBORNE, SKYBORNE], 'Alliance and Horde Skyborne');
	assert.deepEqual([92514, 92595].map(races), [HORDE, HORDE], "Welcome to Shen'dar Village and The Windshapers: the Horde, not Tauren only");
	assert.deepEqual([94449, 94466, 94467, 94468, 97916].map(races), [ALLIANCE, ALLIANCE, ALLIANCE, ALLIANCE, ALLIANCE], 'Call of Fire and Camping 101: Blacksmithing: the Alliance');
	assert.deepEqual([79361, 79442, 79365].map(races), [HORDE, HORDE, HORDE], 'the Horde Shaman Call of Air chain: Horde Skyborne Shamans too');
});

// #1832: The Drowned City's quests came with QuestieDB 1.0.14, some givers and enders only through Factoruide; players'
// recordings agree on every one, so the corrections hold them (a later quest data scrape can't drop them).
test("The Drowned City's quests keep the givers and enders players use (#1832)", () => {
	const ends = (id) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return [entry.set.start.npc, entry.set.end.npc];
	};
	for (const [id, giver, ender, who] of [
		[95775, 2519, 2519, "Kin'weelay: The Drowned City"],
		[95776, 2464, 2464, "Commander Aggro'gosh: The Only Good Brinescale..."],
		[95786, 739, 2277, 'Brother Nimetz to Loremaster Dibbs: An Acquaintance in Southshore'],
		[95787, 2277, 2277, 'Loremaster Dibbs: Take Two With Water'],
		[95788, 2277, 2277, 'Loremaster Dibbs: Magics of the Drowned City'],
		[95789, 773, 773, 'Krazek: Shady Saltseers'],
		[95791, 773, 773, 'Krazek: The Saltseer Captain'],
		[96774, 264074, 264074, "Mazu'kon: Ancient Gurubashi Idol"],
		[97130, 31439, 31439, 'Archmage Timear: Ancient Gurubashi Secrets'],
	]) assert.deepEqual(ends(id), [[giver], [ender]], who);
});

// #1832: players are offered Loremaster Dibbs's two Drowned City quests only once they hand him An Acquaintance in
// Southshore, which Brother Nimetz offers when Troll Witchery is handed in; The Only Good Brinescale... only once
// Enemies in the Water is handed in. Without them the pick-up guide sent players to givers who don't offer the quest.
test("The Drowned City's quests wait for their lead-ins, so the pick-up guide takes those first (#1832)", () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	for (const [id, npc, any, who] of [
		[95786, 739, [205], 'An Acquaintance in Southshore after Troll Witchery'],
		[95787, 2277, [95786], 'Take Two With Water after An Acquaintance in Southshore'],
		[95788, 2277, [95786], 'Magics of the Drowned City after An Acquaintance in Southshore'],
		[95776, 2464, [95773], 'The Only Good Brinescale... after Enemies in the Water'],
	]) assert.deepEqual(blocks(id, npc), { all: [], any }, who);
});

// The Drowned City's follow-ups (QuestieDB 1.0.16): players are offered them only when they hand the dungeon quest
// in, never while it is still in the log. Without the prerequisite the dungeon's hand-in guide, which looks for the
// quests a hand-in opens, never offered them at the turn-in.
test("The Drowned City's follow-ups come with the dungeon quests' hand-ins, so the hand-in guide offers them", () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	for (const [id, npc, any, who] of [
		[96078, 2519, [95775], "A Tale Spun Around the Fire after The Drowned City (Kin'weelay)"],
		[95798, 2277, [95788], 'The Web of Magic after Magics of the Drowned City (Loremaster Dibbs)'],
		[95799, 2277, [95787], "Findings for the Explorer's League after Take Two With Water (Loremaster Dibbs)"],
	]) assert.deepEqual(blocks(id, npc), { all: [], any }, who);
});

// Strange Pylons (Shen'dralas, QuestieDB 1.0.16): the quest log lists one line per pylon, the western one first;
// the merged data had only the temple's, as line 1, so a goal tied to line 1 would count the western pylon.
test("Strange Pylons keeps the quest log's three pylon lines in their order (Shen'dralas)", () => {
	const entry = corrections.quests[92914];
	assert.ok(entry, 'a correction for 92914');
	const lines = entry.set.objectives;
	assert.deepEqual(lines.map((o) => o.text), ['Western pylon found', 'Eastern pylon found', 'Temple pylon found']);
	assert.ok(lines.every((o) => o.type === 'event' && o.count === 1 && o.map === 2652), 'three events on the Shen\'dralas map');
});

test('Open the Maw waits for Dragonmaw Rumors, so the Excavation Site pick-up guide takes Zaruk\'s lead-in first (#1939)', () => {
	const entry = corrections.quests[95682];
	assert.ok(entry, 'a correction for 95682');
	assert.deepEqual(blockingPrereqs({ id: 95682, start: { npc: [13155] }, ...entry.set }), { all: [], any: [95663] });
});

test('every Camping 101 profession quest asks for the skill at 20, not a talk with the trainer (#1952)', () => {
	const ids = [96031, 96044, 96045, 96046, 96047, 96050, 96055, 96056, 96057, 96058, 96059, 96102, 97899, 97900, 97901, 97902, 97903,
		97904, 97905, 97906, 97907, 97908, 97915, 97916, 97917, 97918, 97919, 97920, 97921, 97922, 97923, 97924, 97925, 97927, 97928,
		97929, 97930, 97931, 97932, 97933, 97934, 97935, 97936, 97937, 97938, 97939, 97940, 97941, 97942, 97943, 97944, 97946, 97948,
		97949, 97950, 97951, 97952, 97953, 97954, 97955, 97956, 97957, 97958, 97959, 97960, 97961, 97963, 97964, 97965, 97967, 97968,
		97969, 97970, 97971, 97972, 97973, 98284, 98285, 98286, 98287];
	const bad = ids.filter((id) => {
		const objs = corrections.quests[id] && corrections.quests[id].set.objectives;
		return !(objs && objs.length === 1 && objs[0].type === 'event' && /^Raise your [a-z ]+ skill to 20$/.test(objs[0].text));
	});
	assert.deepEqual(bad, []);
});

// The 0.3.8 XP review (players' recorded hand-ins at a full-XP level, builds 70790-70888): three quests whose
// data value no recorded hand-in pays. The Grand Betrayal's earlier correction held the 70170 build's value.
test('quest XP the recordings confirm is held by the corrections (0.3.8 XP review)', () => {
	const xp = { 421: 875, 2929: 6200, 96261: 3050 };
	const got = Object.fromEntries(Object.keys(xp).map((q) => [q, corrections.quests[q] && corrections.quests[q].set.xp]));
	assert.deepEqual(got, Object.fromEntries(Object.entries(xp).map(([q, v]) => [q, v])));
	assert.deepEqual(corrections.quests[96261].set.preAny, [96259], "The Broodmother's prerequisite stays");
});

test('Hyjal tracks each seed cast separately and credits the decision at Felflick (#3170, #3121, #3194)', () => {
	const wrecks = corrections.quests[93747].set.objectives;
	assert.deepEqual(wrecks.map(o => [o.text, o.type, o.count]), [
		['Ruined Ballista reclaimed', 'event', 1],
		['Ruined Catapult reclaimed', 'event', 1],
		['Ruined Flying Machine reclaimed', 'event', 1],
	]);
	assert.deepEqual(corrections.quests[96322].set.objectives, [
		{ type: 'talk', id: 263757, count: 1, text: 'Decide What to do with Felflick' },
	]);
});

test('A Matter of Time asks for fifteen Temporal Parasites in both the goal and its instructions (#3046)', () => {
	const { objectives: [goal], objectiveText } = corrections.quests[4971].set;
	assert.deepEqual([goal.type, goal.id, goal.count], ['kill', 10717, 15]);
	assert.ok(objectiveText.includes(`${goal.count} Temporal Parasites`));
});

test("Burkrum's stock at Splintertree Post has no ammunition or ammo bags (#3189)", () => {
	for (const item of [2102, 2512, 2515, 2516, 2519, 3030, 3033, 5439, 11285, 11362]) {
		assert.ok(corrections.items[item]?.removeVendors.includes(6028), `item ${item} still lists Burkrum`);
	}
});

test("Champion's Hall quartermasters sell and repair gear, but offer no inn or auction services (#2984, #3168)", () => {
	for (const npc of [12777, 12782]) assert.deepEqual(corrections.npcs[npc].set.roles, ['repair', 'vendor']);
});

// #3112: the Crossroads stall is an auctioneer, a banker or a mailbox by the day (Auctioneer Quickcoin 258878,
// Steamwheedle Courier 258879 and Uninspected Shipment 258880 share their two spawn points; recordings meet both
// the auctioneer and the banker there), so the cooking guide's Auction House goal stalled on the other days.
// Sweep of NPCs sharing every spawn point with another: this stall is the only one that takes turns.
test('The Crossroads stall that changes by the day gives no Auction House or bank goal (#3112)', () => {
	for (const npc of [258878, 258880]) assert.deepEqual(corrections.npcs[npc].set.roles, [], `npc ${npc}`);
});

// #3032: Nearby services' nearest vendor led to Orphan Matron Nightingale, whose vendor flag carries only the
// Children's Week foods; 36 people's recorded windows with her had no merchant window.
test('Orphan Matron Nightingale is no everyday vendor (#3032)', () => {
	assert.deepEqual(corrections.npcs[14450].set.roles, []);
});

// #3241: Lookup's step for Powering the Pylons (96018) said "Elite: group advised" at the Mana Sieve's altar. The
// Codex marks an object's objective when hostile elites stand within 40 yards of it, and an elite with no side counts
// as hostile: the altar's Pylon Protectors (level 61) have none in the merged data, yet players' recordings show them
// neutral to all 64 people who met them, never fought. Sweep: every elite with no side that marks a Codex objective,
// checked against the recordings; these six more were seen only neutral or friendly and never killed.
test('elites players only ever saw neutral are neutral to both sides, so no objective beside them reads "group advised" (#3241)', () => {
	for (const npc of [252695, 11102, 266878, 266880, 271742, 270571, 269699]) {
		assert.equal(corrections.npcs[npc]?.set?.faction, 'AH', `npc ${npc}: neutral to both sides`);
	}
});

// #3028: Test of Lore's only line is to answer Braug Dimspirit's question, and a wrong answer teleports you to Camp
// Taurajo; the Scarlet Monastery pick-up guide never said the answer. The mechanics record is the Codex's `how`, the
// note Lookup shows on the step.
test('Test of Lore says to answer Braug Dimspirit with Neltharion (#3028)', () => {
	const [step] = require('../data/mechanics-public.json').quests[6627].steps;
	assert.deepEqual([step.action, step.target], ['talk', { type: 'npc', id: 4489 }]);
	assert.match(step.fact, /Neltharion/);
	assert.match(step.fact, /Camp Taurajo/);
});

// #3069 (gidi, the Scarlet Monastery pick-up guide): the step for the first Test of Lore (1154) pointed at its book,
// the Legacy of the Aspects, and never said the book lies underground, at the bottom of the Dor'Danil Barrow Den. The
// mechanics record is the Codex's `how`, the note Lookup shows on the step.
test("Test of Lore says its book lies at the bottom of the Dor'Danil Barrow Den (#3069)", () => {
	const [step] = require('../data/mechanics-public.json').quests[1154].steps;
	assert.equal(step.action, 'explore');
	assert.match(step.fact, /Dor'Danil Barrow Den/);
	assert.match(step.fact, /descend to the bottom/);
	assert.match(step.fact, /Legacy of the Aspects/);
});

// #1820: Nearby services' "Bows & guns" at Grom'gol led to Innkeeper Thulbek (5814), who sells food, drink and
// fish only (the Forever TDB's vendor list, 4 people's recorded merchant windows). pfQuest alone listed him as a
// vendor of Hunter's Boomstick (2511) and a repairer. Sweep over every Codex `sells:ranged` and `repair` NPC
// (TDB, QuestieDB 1.0.14, recorded windows): he is the only spawned one.
test('Innkeeper Thulbek sells no bow or gun and does not repair (#1820)', () => {
	assert.deepEqual(corrections.items[2511].removeVendors, [5814]);
	assert.deepEqual(corrections.npcs[5814].set.roles, ['innkeeper', 'vendor']);
});

test('the release data and Codex give Innkeeper Thulbek no Bows & guns or repair role (#1820)', (t) => {
	const dir = path.join(__dirname, '..', 'data', 'forever');
	if (!fs.existsSync(path.join(dir, 'items.json'))) return t.skip('no data/forever');
	const read = (f) => JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
	assert.ok(!read('items.json')[2511].vendors.includes(5814), "Hunter's Boomstick: not sold by him");
	assert.deepEqual(read('npcs.json')[5814].roles, ['innkeeper', 'vendor']);
	const codex = path.join(dir, 'codex', 'npcs.json');
	if (fs.existsSync(codex)) assert.deepEqual(JSON.parse(fs.readFileSync(codex, 'utf8'))[5814].roles, ['innkeeper', 'sells:food', 'vendor']);
});

// #1997: Lightforge Ingots (526) follows The Lost Ingots (324). The merged data listed 526 in 324's `excl`, so 324
// blocked nothing and the Codex gave 526 no prerequisite: Lookup's pick-up guide sent players to Glorin Steelbrow
// before the chain. The Forever TDB has no exclusive group for either.
test('Lightforge Ingots waits for The Lost Ingots, which does not close it (#1997)', () => {
	const lost = { id: 324, start: { object: [2734] }, preAny: [321], excl: [526], ...corrections.quests[324].set };
	const ingots = { id: 526, start: { npc: [1217] }, ...corrections.quests[526].set };
	assert.deepEqual(blockingPrereqs(ingots, (id) => (id === 324 ? lost : null)), { all: [], any: [324] });
});

// #2010: Nearby's stable master search named one on another continent to a Skyborne Hunter on Zephras Isle. Seven
// Forever NPCs whose title reads Stable Master (Genn Fairweather at the Fairweather Stables in Valanaar among them)
// had no stable master role in the merged data. Sweep: every spawned NPC titled stable master in data/forever.
test('every stable master by title has the stable master role (#2010)', () => {
	for (const id of [43408, 256410, 256673, 259190, 259859, 260525, 265756]) {
		assert.ok(corrections.npcs[id] && corrections.npcs[id].set.roles.includes('stablemaster'), `npc ${id}`);
	}
	assert.deepEqual(corrections.npcs[265756].set.roles, ['repair', 'stablemaster', 'trainer', 'vendor'], 'Genn Fairweather keeps his other roles');
});

// #2199: Fiery Menace! counts npc 5858, which the game calls the Searing Lava Spider ("Searing Lava Spider slain" in the
// quest log, each tick a kill of 5858); the merged data kept its Classic name, Greater Lava Spider, so the step named a
// spider no one sees. Sweep (the names of quest NPCs where the client's own name differs from the data's): Velarok
// Windblade (8479), whose Divine Retribution reads "Velarok Story", was still Kalaran Windblade on his goals.
test('the Searing Lava Spider and Velarok Windblade have the names the game shows (#2199)', () => {
	assert.equal(corrections.npcs[5858].set.name, 'Searing Lava Spider');
	assert.equal(corrections.npcs[8479].set.name, 'Velarok Windblade');
	assert.ok(!corrections.npcs[5857], 'npc 5857 keeps its own name');
});

// #1575 (danger gate census): QuestieDB places Infernal 278863, a level 30 elite, at 133 points in the starting zones
// and capitals. No player has met it or died to it there, while 337 people's recordings logged other creatures within
// 40 yd of those points; the danger gate flagged the starting zones' quests, and the compiler's "Elite: group advised"
// (an object's work among hostile elites) would mark For Honor and An Enticing Offer. It stands nowhere.
test('Infernal 278863 stands nowhere players go: no spawns (#1575)', () => {
	assert.deepEqual(corrections.npcs[278863].set, { spawns: {} });
});

// Blood of My Blood (93429, Karana at the Harborage) had no objective in the data, so the Fallow Sanctuary step's kill
// line could not count. Players' recordings tick its one line ("Lost One slain" x10) on a kill of any of the
// sanctuary's Lost One Hunters, Muckdwellers, Seers and Riftseekers.
test('Blood of My Blood counts 10 of any Fallow Sanctuary Lost One', () => {
	const [o, ...rest] = corrections.quests[93429].set.objectives;
	assert.deepEqual(rest, []);
	assert.equal(o.type, 'kill');
	assert.equal(o.count, 10);
	assert.deepEqual(o.credit, [759, 760, 761, 762]);
	assert.ok(o.credit.includes(o.id), 'the kill names one of the credited Lost Ones');
});

// Dungeon quests whose Forever XP is about twice the Classic QuestXP the merged data has (#394), corrected from dated
// in-game evidence. (Restored after 0.4.0: the JS data builder's case went with the builder; the corrections and the
// release data still carry it.)
test('corrections give dungeon quests their Forever XP over the Classic QuestXP (#394)', (t) => {
	const xp = { 377: 4400, 959: 2650, 1486: 3100 }; // Crime and Punishment (The Stockade), Trouble at the Docks and Deviate Hides (Wailing Caverns)
	for (const [q, want] of Object.entries(xp)) assert.equal(corrections.quests[q].set.xp, want, `${q} in the corrections`);
	const file = path.join(__dirname, '..', 'data', 'forever', 'quests.json');
	if (!fs.existsSync(file)) return t.skip('no data/forever');
	const quests = JSON.parse(fs.readFileSync(file, 'utf8'));
	for (const [q, want] of Object.entries(xp)) assert.equal(quests[q].xp, want, `${q} in the release data`);
});

// MgM's report (#462): QuestieDB's Forever store gives Deviate Hides (1486) an Orgrimmar Mailbox and Poor Old Blanchy
// (151) a Stormwind one as a second giver, so the Wailing Caverns pick-up page sent a player from Tirisfal to the
// Orgrimmar mailbox. Forever's quest data has only the NPC. (Restored after 0.4.0, as #394's.)
test("MgM's report: the corrections leave Nalpak and Verna Furlbrow as the only givers, not the mailboxes (#462)", (t) => {
	assert.deepEqual(corrections.quests[1486].set.start, { npc: [5767], object: [], item: [] });
	assert.deepEqual(corrections.quests[151].set.start, { npc: [238], object: [], item: [] });
	const file = path.join(__dirname, '..', 'data', 'forever', 'quests.json');
	if (!fs.existsSync(file)) return t.skip('no data/forever');
	const quests = JSON.parse(fs.readFileSync(file, 'utf8'));
	assert.deepEqual([quests[1486].start, quests[151].start], [{ npc: [5767], object: [], item: [] }, { npc: [238], object: [], item: [] }]);
});

// --- Reports fixed in earlier releases that had no test of their own (regression audit after 0.4.0).

// Indexmatch, Bennistrov (#1410, #1411, #1572): the Image of Archmage Modera stands only at the Kirin Tor camp on the
// Silverpine lake shore; a second spot by Dalaran's sewer entrance in Alterac sent players there.
test('the Image of Archmage Modera stands only at the Kirin Tor camp in Silverpine (#1410, #1572)', () => {
	assert.deepEqual(corrections.npcs[269127].set.spawns, { 1421: { f: 'e', pts: [[68.62, 45.18]] } });
});

// Aducan (#2464): the data had Overmaster Pyron only on the whole Eastern Kingdoms map; he stands in Searing Gorge's
// Grinding Quarry.
test('Overmaster Pyron stands in Searing Gorge\'s Grinding Quarry (#2464)', () => {
	const spawns = corrections.npcs[9026].set.spawns;
	assert.deepEqual(Object.keys(spawns), ['1427']);
	for (const [x, y] of spawns[1427].pts) assert.ok(x > 22 && x < 30 && y > 72 && y < 86, `${x},${y} in the quarry`);
});

// Merlin, Steffen (#1487, #1321): Starving Arcane and Heart of Disruption are offered only after An Alarming Request
// (level 30) is handed in to the Image of Archmage Modera.
test('Starving Arcane and Heart of Disruption wait for An Alarming Request (#1487, #1321)', () => {
	for (const q of [92457, 92458]) {
		const { all, any } = blockingPrereqs({ id: q, start: { npc: [269127] }, ...corrections.quests[q].set });
		assert.deepEqual([...all, ...any], [92432], `${q}`);
	}
});

// Colored McLovin (#2389): the last Unending Torment step pointed at Faranell; the serum is given at a spot in the
// Apothecarium.
test('Unending Torment\'s serum is given at its Apothecarium spot (#2389)', () => {
	const [o] = corrections.quests[97292].set.objectives;
	assert.deepEqual([o.type, o.map, o.x, o.y], ['event', 1458, 44.9, 62.9]);
});

// Facts the release data takes from the merged sources and players' recordings rather than a correction.
// swork1 (#2256): Howin Kindfeather offers Death to the Dragonmaw only once Trying Times is handed in. Smitty (#2437):
// Open the Maw only after Dragonmaw Rumors. rAmandaK (#2508): Trouble in the Deeps is the lead-in to The Essence of
// Aku'Mai, so Lookup skips it once that is taken.
test('the release data: Death to the Dragonmaw (#2256) and Open the Maw (#2437) wait for their quests, Trouble in the Deeps leads to The Essence of Aku\'Mai (#2508)', (t) => {
	const file = path.join(__dirname, '..', 'data', 'forever', 'quests.json');
	if (!fs.existsSync(file)) return t.skip('no data/forever');
	const quests = JSON.parse(fs.readFileSync(file, 'utf8'));
	const pre = (q) => { const { all, any } = blockingPrereqs(quests[q]); return [...all, ...any]; };
	assert.ok(pre(98291).includes(98246), 'Death to the Dragonmaw after Trying Times');
	assert.ok(pre(95682).includes(95663), 'Open the Maw after Dragonmaw Rumors');
	assert.equal(quests[6562].breadcrumbFor, 6563);
});

// bsolca (#3102): Bloodpetal Poison's goal named the Workers, Reavers and Hive Guards for the Gorishi Sting; players'
// recordings tick the line only on Wasps and Stingers.
test('Gorishi Sting is not dropped by the Gorishi Workers, Reavers or Hive Guards (#3102)', () => {
	assert.deepEqual(corrections.items[22435].removeDrops, { npc: [6552, 6553, 10040] });
});

// Soggy (#3235): The Super Snapper FX read "Kill Gammerita (elite)"; the snapshot comes from using the camera on her.
test('Snapshot of Gammerita is no drop of Gammerita: the Super Snapper FX takes it (#3235)', () => {
	assert.deepEqual(corrections.items[9330].removeDrops, { npc: [7977] });
});

test('In Demand - Ancient Elven Curiosities is offered from level 60, as the live server says (#3072)', () => {
	assert.equal(corrections.quests[96076].set.minLevel, 60);
});

// The Codex's `how` (the public mechanics' facts) is what a Lookup pick-up step says beyond the objectives (#2714).
test('pick-up steps say what the objectives leave out: the Twilight Key (#3266), Maraudon (#3243), Franclorn the ghost (#3009), the slimes\' chests (#3002)', () => {
	const { quests } = require('../data/mechanics-public.json');
	const how = (q) => (quests[q]?.steps ?? []).map((s) => s.fact).join(' ');
	assert.match(how(94748), /Twilight Champions .* drop the Twilight Key/);
	assert.match(how(93404), /inside Maraudon/);
	assert.match(how(3801), /ghost only a dead character can see/);
	assert.match(how(1027), /Rotting Slimes .* leave a Rusty Chest/);
});

// Rockout (#3545): My Little Friends' specimens are caught with the Bug Catching Net, not looted, so the goal read
// "Kill Hay Weevil". The public mechanics name the net and the three insects it works on.
test('My Little Friends: each specimen is a use of the Bug Catching Net on its insect, not a kill (#3545)', () => {
	const m = require('../data/mechanics-public.json').quests[93176];
	assert.deepEqual(m.params, [{ kind: 'use-item-on-mob', item: 213562, npcs: [217588, 217589, 217590] }]);
	assert.deepEqual(m.steps.map((s) => [s.n, s.action, s.target.id, s.item.id]), [[1, 'use-item', 217588, 213562], [2, 'use-item', 217589, 213562], [3, 'use-item', 217590, 213562]]);
});

// Gindry (#3546): Tooga gives Oasis only once Tooga's Quest is handed in at Torta.
test('Oasis comes after Tooga\'s Quest (#3546)', () => {
	assert.deepEqual(corrections.quests[97540].set.pre, [1560]);
});

// #3171, #3392, #3522: the live server describes none of Duke Hydraxis's chain, nor Attunement to the Core, and two
// players at 56 and 60 were offered nothing by him: the quests leave the data until the Molten Core opens.
test('Duke Hydraxis\'s chain and Attunement to the Core leave the data while the Molten Core is closed (#3171, #3392, #3522)', () => {
	for (const q of [6804, 6805, 6821, 6822, 6823, 6824, 7486, 7848]) {
		assert.equal(corrections.quests[q].remove, true, `quest ${q}`);
		assert.ok(corrections.quests[q].source.some((s) => s.kind === 'eg'), `quest ${q}: the live scans`);
	}
});

// Zack (#3338): Scout Bloodfist and Rifleman Torrig are not in the world, and nobody has done their quests.
test('The Silithus scouts\' quests leave the data: 9415, 9416 and the Scouring the Desert pair (#3338)', () => {
	for (const q of [9415, 9416, 9419, 9422]) assert.equal(corrections.quests[q].remove, true, `quest ${q}`);
});

// PierreAnken (#3192): Ignatz offers the Horde's Stinky's Escape from level 36; the Alliance's stays at 30.
test('Stinky\'s Escape (Horde) is offered from level 36 (#3192)', () => {
	assert.equal(corrections.quests[1270].set.minLevel, 36);
	assert.equal(corrections.quests[1222], undefined);
});

// Sugawolf (#3601): Pix Xizzix offers one In Demand quest a week; the data knew only 96076. All four are known now.
test('Pix Xizzix\'s four In Demand quests are in the data (#3601)', () => {
	for (const q of [96075, 96087, 96088]) {
		const s = corrections.quests[q].set;
		assert.deepEqual([s.start.npc, s.end.npc, s.minLevel, s.objectives.length], [[227853], [227853], 60, 3], `quest ${q}`);
	}
});

// #2465, #3138, #3601, #558: what the game hides behind a condition, for the engine (#3658).
test('Seeking the Kor Gem counts as done by An Underrated Talent; Zorbin sells after Zapped Giants; Pix\'s In Demand quests rotate; Franclorn is a ghost (#2465, #3138, #3601, #558)', () => {
	assert.deepEqual(corrections.quests[95042].set.doneBy, [95111]);
	assert.equal(corrections.npcs[14637].set.vendorAfter, 7003);
	for (const q of [96075, 96076, 96087, 96088]) assert.equal(corrections.quests[q].set.rotation, 'pix-weekly', `quest ${q}`);
	assert.equal(corrections.npcs[8888].set.ghostOnly, true);
});

// Everlast (#3301): Melizza offers her escort in the Maraudine camp, not along its path.
test('Melizza Brimbuzzle stands only in the Maraudine camp (#3301)', () => {
	for (const [x, y] of corrections.npcs[12277].set.spawns[1443].pts) assert.ok(x < 34.5 && y < 55, `${x},${y}`);
});

// Stö (#3531): Blademaster's Bonfires is two bonfires lit, with their objects and spots.
test('Blademaster\'s Bonfires: the south and southeast bonfires are its objectives, placed where players light them (#3531)', () => {
	assert.deepEqual(corrections.quests[96959].set.objectives.map((o) => [o.type, o.id]), [['object', 656668], ['object', 656669]]);
	assert.deepEqual(corrections.objects[656668].addSpawns[2482].pts, [[49.1, 36.02]]);
	assert.deepEqual(corrections.objects[656669].addSpawns[2482].pts, [[54.84, 40.0]]);
});

// gidi_ (#3676): Biting the Hand's second part, leading Fuzzle out of Sunnyglade, is an escort its text never names.
test('Biting the Hand (94963) is an escort (#3676)', () => {
	assert.equal(corrections.quests[94963].set.escort, true);
});

// cjtylr (#3739): The Return of the King? had no objective, so the pick-up guide sent players straight back to Sully.
test('The Return of the King? (95198) has its eavesdropping objective at the Theramore Mage Tower (#3739)', () => {
	const [o, ...rest] = corrections.quests[95198].set.objectives;
	assert.equal(rest.length, 0, 'one objective');
	assert.equal(o.text, "Relieve Jaina's guard and eavesdrop");
	assert.equal(o.map, 1445);
});

// devanpy (#3773): Twilight Tablet Fragments lie on the ground; the elementals pfQuest lists at 100 never drop them.
test('Twilight Tablet Fragment (20378) drops from no elemental (#3773)', () => {
	assert.deepEqual(corrections.items[20378].removeDrops.npc, [11744, 11746, 14455]);
});

// #3706: Horde Triage (6622) takes place at Doctor Gregory Victor in Hammerfall, Arathi Highlands (1417),
// not at the Alliance clinic in Theramore Isle (1445).
test('Horde Triage (6622) is completed at Doctor Gregory Victor in Hammerfall (#3706)', () => {
	const objs = corrections.quests[6622].set.objectives;
	assert.ok(objs && objs.length === 1, 'one objective');
	assert.equal(objs[0].type, 'event');
	assert.equal(objs[0].map, 1417);
	assert.deepEqual([objs[0].x, objs[0].y], [73.4, 36.8]);
});

// 司徒王朗 (#4157): Mother's Milk's line "Milked" ticks when Ragged John milks a player Mother Smolderweb has poisoned;
// typed as a talk, the Blackrock Spire hand-in guide sent players to talk to him without the poison.
test("Mother's Milk (4866) is an event, not a talk at Ragged John (#4157)", () => {
	const objs = corrections.quests[4866].set.objectives;
	assert.equal(objs.length, 1, 'one objective');
	assert.deepEqual([objs[0].type, objs[0].id, objs[0].text], ['event', null, 'Milked']);
	assert.ok(!('map' in objs[0]), 'no place: the hand-in guide lists it as not finished');
});

// Moduki (#4188): Kodo Roundup's kodos are tamed with the Kodo Kombobulator and counted at Smeed's camp; the quest
// guide said "Kill Aged Kodo".
test('Kodo Roundup (5561) is a use of the Kodo Kombobulator on the kodos, then a talk at the camp (#4188)', () => {
	const m = require('../data/mechanics-public.json').quests[5561];
	assert.ok(m.kinds.some((k) => k.kind === 'use-item-on-mob' && k.confidence === 'high'));
	const [p] = m.params;
	assert.deepEqual([p.item, p.npcs], [13892, corrections.quests[5561].set.objectives[0].credit]);
	assert.deepEqual(m.steps.map((s) => s.action), ['use-item', 'talk']);
	assert.match(m.steps[0].fact, /Don't kill it/);
});
