'use strict';
// Player-reported guide fixes, pinned so a route refresh (re-applying a new
// simulator route to the hand-written guides) cannot silently undo them.
// Each case names the report it protects and checks behaviour on the guide
// compiled with the real reference data: goal order and where the arrow
// leads, not the guide's wording. The timed quest items have their own lint
// rule (tests/lint-timed.test.js); the Fargodeep Mine and Blackfathom Deeps
// mouths are in tests/guides-caves.test.js.
//
// Needs data/forever (node tools/polestar.js data build); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { compileSources, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { loadData } = require('../tools/lib/dsl/data');
const { DATA, SOURCES } = require('../tools/lib/paths');
const { loadWowhead } = require('../tools/lib/codex/wowhead');
const { runAddon } = require('./helpers/lua');
const { writeTestPack } = require('./helpers/dsl');
const { buildSimPack, playGuide, SIMULATE } = require('../tools/lib/playtest');

const skip = needs('quests.json', 'npcs.json', 'objects.json', 'map-frames.json');

const DUROTAR = 'forever/horde/orc-troll/01-durotar.guide';
const DUN_MOROGH = 'forever/alliance/dwarf-gnome/01-dun-morogh.guide';
const TELDRASSIL = 'forever/alliance/nightelf/01-teldrassil.guide';
const ELWYNN = 'forever/alliance/human/01-elwynn-forest.guide';
const MULGORE = 'forever/horde/tauren/01-mulgore.guide';
const TIRISFAL = 'forever/horde/undead/01-tirisfal-glades.guide';

let data;
const memo = new Map();
// The guide compiled with the reference data (its parse tree is `_ast`).
function compiled(guide) {
	if (!memo.has(guide)) {
		data = data || loadData(DATA);
		const file = path.join(OFFICIAL_DIR, guide);
		const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], data);
		assert.equal(guides.length, 1, `${guide} compiles`);
		memo.set(guide, guides[0]);
	}
	return memo.get(guide);
}
// The guide's goals in order, as { step, goal, s } (`s`: the step's number, as the Engine counts them).
function goals(guide) {
	return compiled(guide).steps.flatMap((step, s) => step.goals.map((goal) => ({ step, goal, s: s + 1 })));
}
// Every guide of ours, as paths relative to guides/ with forward slashes.
function allGuides() {
	const walk = (dir) => fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(dir, e.name)) : e.name.endsWith('.guide') ? [path.join(dir, e.name)] : []));
	return walk(path.join(OFFICIAL_DIR, 'forever')).map((file) => path.relative(OFFICIAL_DIR, file).split(path.sep).join('/'));
}

// Index of the first goal matching, asserted present.
function at(list, what, pred) {
	const i = list.findIndex(({ goal }) => pred(goal));
	assert.ok(i >= 0, `${what} is in the guide`);
	return i;
}
const is = (t, quest) => (g) => g.t === t && g.quest === quest;
const located = ({ goal }) => goal.map != null && goal.x != null;
// Goals every character of the guide does (no `only` on the goal or its step).
const everyone = ({ step, goal }) => !step.only && !goal.only;
// Goals a character of this class does (an `only` naming classes on the goal or its step must list it).
const forClass = (cls) => ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.classes || o.classes.includes(cls));

// Yards between two compiled points on one map (Era frame).
function yards(a, b) {
	const f = data.eraFrame(a.map);
	assert.ok(f && a.map === b.map, `points on one map with an Era frame (${a.map}, ${b.map})`);
	return Math.hypot(((f.right - f.left) * (a.x - b.x)) / 100, ((f.bottom - f.top) * (a.y - b.y)) / 100);
}

// --- Durotar (Tom): Sting of the Scorpid and the cactus apples come along to Sarkoth.

test(`${DUROTAR}: Tom's report: Cutting Teeth is turned in and Sting of the Scorpid and Galgar's Cactus Apple Surprise accepted before Sarkoth`, { skip }, () => {
	const list = goals(DUROTAR);
	const sarkoth = at(list, "Sarkoth's Mangled Claw", (g) => g.t === 'collect' && g.quest === 790);
	assert.ok(at(list, 'turnin 788 (Cutting Teeth)', is('turnin', 788)) < sarkoth, 'Cutting Teeth is handed in before Sarkoth');
	assert.ok(at(list, 'accept 789 (Sting of the Scorpid)', is('accept', 789)) < sarkoth, 'Sting of the Scorpid is taken before Sarkoth');
	assert.ok(at(list, "accept 4402 (Galgar's Cactus Apple Surprise)", is('accept', 4402)) < sarkoth, 'the cactus apples are taken before Sarkoth');
	// Their objectives are done on Sarkoth's slope, before going back to the Den.
	const back = at(list, 'turnin 804 (Sarkoth)', is('turnin', 804));
	for (const q of [789, 4402]) assert.ok(at(list, `the objective of ${q}`, (g) => g.t === 'collect' && g.quest === q) < back, `${q}'s objective is done before the Den`);
});

// --- Caves (Tom): the arrow leads to a cave's mouth before anyone inside it.

// The Den: Kzan Thornslash stands at the back of the cave, behind Gornek just inside it.
test(`${DUROTAR}: Tom's report: the arrow's last waypoint before Kzan Thornslash is the Den's mouth`, { skip }, () => {
	const list = goals(DUROTAR);
	const kzan = at(list, 'turnin 97279 (Wayward Weapons)', is('turnin', 97279));
	const last = list.slice(0, kzan).reverse().find(({ goal }) => goal.t === 'goto');
	assert.ok(last, 'a goto comes before Kzan');
	const { map, x, y } = last.goal;
	assert.deepEqual({ map, x, y }, { map: 1411, x: 42.4, y: 68.6 });
	// Whatever the arrow points at between the mouth and Kzan is inside the Den's mouth, not across the hill.
	const between = list.slice(list.indexOf(last) + 1, kzan).filter(located).filter(everyone);
	for (const { goal } of between) assert.ok(yards(goal, last.goal) < 40, `${goal.t} ${goal.quest || ''} lies by the mouth`);
});

const CAVES = [
	// Thazz'ril's Pick and Yarrog Baneshadow: "Go in the cave (45 56)".
	{ cave: 'the Burning Blade Coven (the pick)', guide: DUROTAR, target: (g) => g.t === 'collect' && g.item === 16332, mouth: { map: 1411, x: 45, y: 56 } },
	{ cave: 'Skull Rock', guide: DUROTAR, target: (g) => g.t === 'collect' && g.item === 4871, mouth: { map: 1411, x: 55, y: 10 } },
	// The troll cave's mouth as marked in game (thmastin, PR #16); Wowhead's comments put it at 26,79.
	{ cave: 'the Coldridge troll cave', guide: DUN_MOROGH, target: (g) => g.t === 'collect' && g.item === 2004, mouth: { map: 1426, x: 26.93, y: 80.03 } },
	{ cave: 'the Jasperlode Mine', guide: ELWYNN, target: (g) => g.t === 'complete' && g.quest === 76, mouth: { map: 1429, x: 61.6, y: 54.1 } },
	{ cave: 'Shadowthread Cave', guide: TELDRASSIL, target: (g) => g.t === 'collect' && g.item === 5167, mouth: { map: 1438, x: 57, y: 32 } },
	{ cave: 'Fel Rock', guide: TELDRASSIL, target: (g) => g.t === 'collect' && g.item === 5221, mouth: { map: 1438, x: 54, y: 52 } },
	// The Webbed Victims are freed inside the cave.
	{ cave: "Night Web's Hollow", guide: TIRISFAL, target: (g) => g.t === 'goto' && g.x === 24.8 && g.y === 59.6, mouth: { map: 1420, x: 26, y: 60 } },
];

for (const c of CAVES) {
	test(`${c.guide}: Tom's report: the arrow reaches ${c.cave} through its mouth at ${c.mouth.x},${c.mouth.y}`, { skip }, () => {
		const list = goals(c.guide);
		const i = at(list, c.cave, c.target);
		const before = list.slice(0, i).reverse().find(located);
		assert.ok(before, 'a located goal comes before the target');
		const { t, map, x, y } = before.goal;
		assert.deepEqual({ t, map, x, y }, { t: 'goto', ...c.mouth }, `the waypoint before "${list[i].step.title}" is the mouth`);
	});
}

// --- Durotar (Gruko, #240): the Burning Blade Coven in one trip. Vile Familiars
// is handed in and Burning Blade Medallion taken first, so Yarrog comes right
// after Thazz'ril's Pick inside the cave instead of a walk back to the Den and in again.
test(`${DUROTAR}: Gruko's report (#240): Thazz'ril's Pick and Yarrog are done on one trip into the Burning Blade Coven, for every class`, { skip }, () => {
	const all = goals(DUROTAR);
	for (const cls of ['WARRIOR', 'HUNTER', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK']) {
		const list = all.filter(forClass(cls));
		const pick = at(list, "Thazz'ril's Pick", (g) => g.t === 'collect' && g.item === 16332);
		const yarrog = at(list, 'the Burning Blade Medallion', (g) => g.t === 'collect' && g.item === 4859);
		assert.ok(at(list, 'accept 794 (Burning Blade Medallion)', is('accept', 794)) < pick, `${cls}: the Medallion is taken before the cave`);
		assert.ok(pick < yarrog, `${cls}: the pick, then Yarrog`);
		assert.deepEqual(list.slice(pick + 1, yarrog).filter(located).map(({ goal }) => `${goal.t} ${goal.quest || goal.text}`), [], `${cls}: nothing outside the cave between the pick and Yarrog`);
	}
});

// --- The starting glens: one delivery quest no longer sends you off and back.

test(`${TELDRASSIL}: Dolanaar Delivery is taken from Porthannius after the Shadowglen quests, on the way out to Dolanaar`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, 'accept 2159 (Dolanaar Delivery)', is('accept', 2159));
	// Shadowglen's last turn-ins: Crown of the Earth at Tenaron, Iverron's Antidote.
	for (const q of [921, 3522, 917, 457, 456]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < take, `turnin ${q} comes before the delivery`);
	const keldamyr = list[at(list, 'turnin 2159', is('turnin', 2159))].goal;
	const tenaron = list[at(list, 'turnin 921', is('turnin', 921))].goal;
	const porthannius = list[take].goal;
	// Porthannius stands between the tree and Dolanaar, and the next stop is Dolanaar.
	assert.ok(yards(porthannius, keldamyr) < yards(tenaron, keldamyr), 'Porthannius is on the way down to Dolanaar');
	const next = list.slice(take + 1).filter(located).find(everyone);
	assert.ok(yards(next.goal, keldamyr) < yards(next.goal, tenaron), `the next stop (${next.goal.t} ${next.goal.quest}) is in Dolanaar`);
});

test(`${DUN_MOROGH}: Supplies to Tannok is taken from Hands Springsprocket at the tunnel, leaving Coldridge Valley`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const take = at(list, 'accept 2160 (Supplies to Tannok)', is('accept', 2160));
	// After the valley's last quests (Bring Back the Mug at Nori, the journal at Grelin).
	for (const q of [3365, 218, 170, 183]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < take, `turnin ${q} comes before Supplies to Tannok`);
	// Beside Mountaineer Thalos at the tunnel's mouth.
	const thalos = list[at(list, 'turnin 282 (Mountaineer Thalos)', is('turnin', 282))].goal;
	assert.ok(yards(list[take].goal, thalos) < 40, 'Hands Springsprocket is taken at the tunnel, beside Thalos');
	const before = list.slice(0, take).reverse().filter(located).find(everyone);
	assert.ok(yards(before.goal, thalos) < 40, 'the stop before it is at the tunnel too');
});

test(`${MULGORE}: A Task Unfinished at Antur Fallow starts the cougar hunt, with no walk back into the camp`, { skip }, () => {
	const list = goals(MULGORE);
	const take = at(list, 'accept 1656 (A Task Unfinished)', is('accept', 1656));
	const hunt = at(list, 'the cougar hunt (750)', (g) => g.quest === 750 && g.t !== 'accept' && g.t !== 'turnin');
	assert.ok(take < hunt, 'Antur comes before the hunt');
	assert.equal(list[take].step, list[hunt].step, "Antur's quest opens the hunt's step: the hunt starts at his end of the camp");
	assert.deepEqual(list.slice(take + 1, hunt).filter(located).filter(everyone).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'the hunt follows Antur straight away');
	assert.ok(hunt < at(list, 'turnin 750', is('turnin', 750)), 'the hunt ends at Grull');
});

// --- Bandarion Keep (Mike_, 0.2.3): Hilda the Breaker and Ephram Barbaro offer their quests to Paladins only.

test(`${TIRISFAL}: Mike_'s report: only Paladins are sent to Hilda the Breaker and Ephram Barbaro at Bandarion Keep`, { skip }, () => {
	const list = goals(TIRISFAL);
	const keep = [246389, 259190]; // Hilda the Breaker, Ephram Barbaro
	const mage = list.filter(forClass('MAGE'));
	assert.deepEqual(mage.filter(({ goal }) => keep.includes(goal.npc)).map(({ goal }) => `${goal.t} ${goal.quest} (${goal.npcName})`), [], 'a Mage meets neither giver');
	assert.deepEqual(mage.filter(({ goal }) => goal.quest === 99152 || goal.quest === 99153).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'nor any goal of their quests');
	// The Shadowvale elixir bottles stay for everyone (at asserts the goal is there).
	at(mage, 'collect 268801 (Bottle of Whispering Elixir)', (g) => g.t === 'collect' && g.quest === 95314);
	const paladin = list.filter(forClass('PALADIN'));
	for (const q of [99152, 99153]) {
		const take = at(paladin, `accept ${q} for a Paladin`, is('accept', q));
		assert.ok(keep.includes(paladin[take].goal.npc), `a Paladin takes ${q} at the keep`);
		assert.ok(take < at(paladin, `turnin ${q} for a Paladin`, is('turnin', q)));
	}
});

// --- Coldridge Valley (thmastin, PR #16): the valley is never walked back to.

test(`${DUN_MOROGH}: thmastin's report: Grik'nir comes after Anvilmar, and the journal and Nori's mug are handed in on one camp visit`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const griknir = at(list, "Grelin Whitebeard's Journal (Grik'nir)", (g) => g.t === 'collect' && g.item === 2004);
	assert.ok(at(list, 'turnin 3364 (Scalding Mornbrew Delivery, Anvilmar)', is('turnin', 3364)) < griknir, 'Anvilmar comes before Grik\'nir');
	const journal = at(list, 'turnin 218 (The Stolen Journal)', is('turnin', 218));
	const mug = at(list, 'turnin 3365 (Bring Back the Mug)', is('turnin', 3365));
	assert.ok(griknir < journal && griknir < mug, 'both are handed in after Grik\'nir');
	assert.equal(list[journal].step, list[mug].step, 'the journal and the mug are handed in on one visit to Grelin\'s camp');
	// Grund and Gozwin is done in the valley, before the troll cave, not on a return after Rumbleshot.
	assert.ok(at(list, 'turnin 97277 (Grund and Gozwin)', is('turnin', 97277)) < griknir, 'Grund and Gozwin is handed in before the troll cave');
});

test(`${DUN_MOROGH}: thmastin's report: The Adventurer is taken from Thalos at the tunnel and turned in at Eric before The Great Outdoors`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const take = at(list, 'accept 96628 (The Adventurer)', is('accept', 96628));
	const thalos = at(list, 'turnin 282 (Senir\'s Observations, Thalos)', is('turnin', 282));
	assert.equal(list[take].step, list[thalos].step, 'taken at the tunnel, on the way out of the valley');
	const give = at(list, 'turnin 96628 (The Adventurer)', is('turnin', 96628));
	assert.equal(list[give].goal.npcName, 'Eric Brighthammer', 'turned in at Eric');
	assert.ok(give < at(list, 'accept 96608 (The Great Outdoors)', is('accept', 96608)), 'before The Great Outdoors, which it leads to');
});

// --- Darkshore (Wogi): a Human at 20 was sent to grey quests.

// Darkshore and the guides after it, played by the Engine for a level-`level`
// Human with "Skip grey quests" on: the accepts it leaves out as grey
// (`skipped`), and each grey accept it keeps with the quest it says it opens
// and that line (`kept`).
function greyInDarkshore(level) {
	data = data || loadData(DATA);
	const files = ['03-darkshore', '04-redridge-mountains', '05-duskwood', '06-ashenvale', '07-thousand-needles']
		.map((n) => path.join(OFFICIAL_DIR, 'forever/alliance', `${n}.guide`));
	const { guides } = compileSources(files.map((file) => ({ file, text: fs.readFileSync(file, 'utf8') })), data);
	const { dir, scripts } = writeTestPack(guides, data);
	try {
		const loads = scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
				w.level = ${level}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = true, autoSelectGuide = false } } }' },
			script: `do local ns = {}
				${loads}
				end
				stub.login(); stub.advance(0.5)
				local E = Polestar.Engine
				E.SetGuide("forever/alliance/03-darkshore")
				local skipped, kept = {}, {}
				for i = 1, #E.GetGuide().steps do
					for _, g in ipairs(E.GetStepView(i).goals) do
						if g.skippedGrey then skipped[#skipped + 1] = g.quest end
						if g.keptGrey then kept[tostring(g.quest)] = { g.keptGrey, g.keptGreyText } end
					end
				end
				emit({ skipped = skipped, kept = kept })`,
		});
		// An empty Lua table comes back as {}.
		const { skipped, kept } = emitted[0];
		return { skipped: Object.values(skipped), kept };
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

test('forever/alliance/03-darkshore.guide: Wogi\'s report: with Skip grey quests on, a Human at 20 leaves out the grey quests, keeps the Buzzbox chain, and one on the route\'s level keeps them all', { skip }, () => {
	// At 20, quests of level 13 and below are grey. Buzzbox 827 (983, level
	// 10) and Buzzbox 411 (1001, 12) open Buzzbox 323 and 525, the first
	// Washed Ashore (3524, 13) the second, and the two grey beached remains
	// (4722, 4723) Holy Diver: they stay.
	assert.deepEqual(greyInDarkshore(20).skipped.sort((a, b) => a - b), [953, 954, 955, 956, 957, 958, 98025]);
	// The simulator's Human reaches Darkshore at 16 to 18: Buzzbox 827 is
	// already grey then, and stays for its chain.
	assert.deepEqual(greyInDarkshore(17).skipped, []);
});

test('forever/alliance/03-darkshore.guide: XooVe\'s report (#216): a grey quest Skip grey quests keeps says which quest it opens', { skip }, () => {
	// At 20 Buzzbox 323 (1002, level 14) is the nearest quest still worth
	// doing that 827 and 411 lead to; at 22 only Buzzbox 525 (1003, 16) is.
	const at20 = greyInDarkshore(20).kept;
	assert.deepEqual(at20['983'], [1002, 'Grey, kept: opens Buzzbox 323']);
	assert.deepEqual(at20['1001'], [1002, 'Grey, kept: opens Buzzbox 323']);
	const at22 = greyInDarkshore(22).kept;
	assert.deepEqual(at22['983'], [1003, 'Grey, kept: opens Buzzbox 525']);
	// At 23 the whole chain is grey and left out: nothing kept says so.
	const at23 = greyInDarkshore(23);
	assert.equal(at23.kept['983'], undefined);
	assert.ok(at23.skipped.includes(983));
});

// --- Tirisfal (a Scourge Priest): the guide sent them to turn in Discipline
// (99134) without one Deathguard motivated. Its step was only a `goto` to
// Brill, done on arrival, so nothing waited for the quest. The same holds for
// the other event and escort objectives written as a `goto`.

test(`a Priest's report: an event or escort objective holds its step until the quest is complete`, { skip }, () => {
	for (const [guide, quest] of [[TIRISFAL, 99134], [TIRISFAL, 98389], [TIRISFAL, 99144], [DUROTAR, 99123], [TELDRASSIL, 99053]]) {
		const list = goals(guide);
		const accept = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		const complete = at(list, `${guide}: complete ${quest}`, is('complete', quest));
		const turnin = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
		assert.ok(accept < complete && complete < turnin, `${guide}: ${quest} is completed between its accept and its turn-in`);
	}
});

// --- Durotar (AndarKerran): A Pain in the Neck (96873) is for enchanters.

// A guide played by the Engine for one character (`who`: race, raceName,
// faction, cls, className, level), with `before` (Lua, `w` the stub world)
// run before login and `after` once the guide is open: what `script` (Lua,
// `E` the Engine) emits.
function engineRun(guide, who, { before = '', after = '', script }) {
	data = data || loadData(DATA);
	const file = path.join(OFFICIAL_DIR, guide);
	const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], data);
	const { dir, scripts } = writeTestPack(guides, data);
	try {
		const loads = scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = "${who.race}", "${who.raceName}", "${who.faction}", "${who.cls}", "${who.className}"
				w.level = ${who.level}
				${before}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }' },
			script: `do local ns = {}
				${loads}
				end
				stub.login(); stub.advance(0.5)
				local E = Polestar.Engine
				E.SetGuide("${guide.replace(/\.guide$/, '')}")
				${after}
				stub.advance(0.5)
				${script}`,
		});
		return emitted[0];
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

// The status of each goal of `quest` ("accept na", ...), with `skills` (Lua)
// set before login and `after` run once the guide is open.
function questGoalStatus(guide, quest, who, { skills = '', after = '' } = {}) {
	return Object.values(engineRun(guide, who, {
		before: skills,
		after,
		script: `local out = {}
			for i = 1, #E.GetGuide().steps do
				for _, g in ipairs(E.GetStepView(i).goals) do
					if g.quest == ${quest} then out[#out + 1] = g.t .. " " .. g.status end
				end
			end
			emit(out)`,
	})); // an empty Lua table comes back as {}
}

// What the guide window shows for step `s`: its goals ({ t, quest, status,
// text, optional }) and its groups (the goal numbers of each, in order), with
// `before` (Lua) setting up the world before login.
function stepView(guide, who, s, before = '') {
	const v = engineRun(guide, who, {
		before,
		script: `local v = E.GetStepView(${s})
			local out = { groups = {}, goals = {} }
			for k, grp in ipairs(v.groups) do out.groups[k] = grp.goals end
			for k, g in ipairs(v.goals) do
				out.goals[k] = { t = g.t, quest = g.quest or 0, status = g.status, text = g.text or "", optional = g.optional }
			end
			emit(out)`,
	});
	return { goals: v.goals, groups: v.groups };
}

const TROLL_WARRIOR = { race: 'Troll', raceName: 'Troll', faction: 'Horde', cls: 'WARRIOR', className: 'Warrior', level: 12 };
const painInTheNeck = (opts) => questGoalStatus(DUROTAR, 96873, TROLL_WARRIOR, opts);

test(`${DUROTAR}: AndarKerran's report: A Pain in the Neck is not offered to a Troll Warrior without Enchanting, and is to an enchanter`, { skip }, () => {
	// Pa'zula offers it to enchanters only (QuestieDB: Enchanting 1): every goal carries the profession.
	const pain = goals(DUROTAR).filter(({ goal }) => goal.quest === 96873);
	assert.deepEqual(pain.map(({ goal }) => [goal.t, goal.profLine, goal.profName, goal.profRank]), [
		['accept', 333, 'Enchanting', 1],
		['complete', 333, 'Enchanting', 1],
		['turnin', 333, 'Enchanting', 1],
	]);
	// Hidden ("na", like another class's goals), not offered and then skipped.
	assert.deepEqual(painInTheNeck(), ['accept na', 'complete na', 'turnin na']);
	// An enchanter is offered it. Its accept is optional, so the complete and
	// the turn-in are theirs only once they take it (#221).
	const offered = ['accept pending', 'complete na', 'turnin na'];
	assert.deepEqual(painInTheNeck({ skills: 'w.skills[333] = { name = "Enchanting", rank = 1, maxRank = 75 }' }), offered);
	// Learning Enchanting during the session brings the accept back.
	assert.deepEqual(painInTheNeck({ after: 'stub.world.learnSkill(333, "Enchanting", 1, 75)' }), offered);
});

// Recipe of the Kaldorei (4161) is offered to cooks only (QuestieDB's Forever
// store: Cooking 1): Teldrassil teaches Cooking at Zarrin's door first.
test(`${TELDRASSIL}: Recipe of the Kaldorei is taken after the guide teaches Cooking`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, 'accept 4161', is('accept', 4161));
	assert.equal(list[take].goal.profName, 'Cooking', '4161 needs Cooking');
	assert.ok(at(list, 'turnin 96634 (Camping 101: Cooking)', is('turnin', 96634)) < take, '4161 after the cooking lesson');
	assert.ok(at(list, 'train Cooking', (g) => g.t === 'train' && g.skillLine === 185) < take, '4161 after training Cooking');
});

// --- Dun Morogh (thmastin): Beer Basted Boar Ribs (384) is for everyone.

// Ragnar Thunderbrew offers it to a Dwarf Paladin without Cooking (Camping
// 101: Cooking still in the log). QuestieDB's Forever store lists no skill for
// it; only pfQuest's Classic data lists Cooking, which does not gate.
test(`${DUN_MOROGH}: thmastin's report: Beer Basted Boar Ribs is offered without Cooking, on arrival in Kharanos`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const ribs = list.filter(({ goal }) => goal.quest === 384);
	assert.deepEqual(ribs.map(({ goal }) => [goal.t, goal.profLine]), [
		['accept', undefined],
		['collect', undefined],
		['turnin', undefined],
	]);
	const take = at(list, 'accept 384', is('accept', 384));
	assert.ok(take < at(list, 'turnin 96629 (Camping 101: Cooking)', is('turnin', 96629)), '384 is taken before the cooking lesson');
	const dwarf = { race: 'Dwarf', raceName: 'Dwarf', faction: 'Alliance', cls: 'PALADIN', className: 'Paladin', level: 6 };
	const status = questGoalStatus(DUN_MOROGH, 384, dwarf);
	assert.equal(status.length, 3);
	assert.ok(status.every((s) => !s.endsWith(' na')), `a Dwarf without Cooking sees 384: ${status.join(', ')}`);
});

// --- The Barrens (Hotline, a Scourge Mage): Walton offered neither Unwelcome
// Guests nor Trouble in the Valley, and Vrang no Hermit Tanner. They are one
// chain: Vrang's Bruised Pride and Lion Hides and Vrang's Game, then The
// Hermit Tanner up to Walton, then Trouble in the Valley, then Unwelcome Guests.

const BARRENS = 'forever/horde/04-the-barrens.guide';

test('Hotline\'s report: Walton and Vrang\'s quests come in the order the game offers them', { skip }, () => {
	const list = goals(BARRENS);
	const order = [
		['accept', 95494], ['accept', 95507], ['turnin', 95494], ['turnin', 95507],
		['accept', 95495], ['turnin', 95495], ['accept', 95621], ['turnin', 95621],
		['accept', 95508], ['complete', 95508], ['turnin', 95508],
	].map(([t, q]) => at(list, `${t} ${q}`, is(t, q)));
	assert.deepEqual(order, [...order].sort((a, b) => a - b), 'each goal comes after the one before it in the chain');
});

// --- The Barrens (Fitz, a Scourge Warlock, #70): at the Crossroads the guide
// sent them to Sergra Darkthorn for Jorn Skyseer (3261), which needs The
// Angry Scytheclaws (905), the end of her chain in forever/horde/02-the-barrens.
// Without it the accept and Jorn's turn-in read as skipped from the start, so
// neither the focus nor the arrow goes there; with it they are open.
test(`${BARRENS}: Fitz's report: Jorn Skyseer is passed by while The Angry Scytheclaws is missing, and open once it is done`, { skip }, () => {
	const warlock = { race: 'Scourge', raceName: 'Undead', faction: 'Horde', cls: 'WARLOCK', className: 'Warlock', level: 21 };
	const accept = at(goals(BARRENS), 'accept 3261 (Jorn Skyseer)', is('accept', 3261));
	assert.deepEqual(goals(BARRENS)[accept].goal.pre, [905], 'Jorn Skyseer needs The Angry Scytheclaws');
	const missing = questGoalStatus(BARRENS, 3261, warlock);
	assert.deepEqual(missing, ['accept skipped', 'turnin skipped']);
	const done = questGoalStatus(BARRENS, 3261, warlock, { skills: 'w.complete({ 905 })' });
	assert.equal(done.length, 2);
	assert.ok(done.every((s) => !s.endsWith(' skipped') && !s.endsWith(' na')), `with 905 done Jorn Skyseer is open: ${done.join(', ')}`);
});

// --- Forever chains the quest data has no prerequisite for, so the guide took
// a follow-up at the same visit as the quest before it and the giver did not
// offer it: Baine's chain in Mulgore (Kori, #112) and Mull's report (#51),
// Bandarion Keep (whiteswag, #128) and Linnea's second Rear Guard Patrol (#51)
// in Tirisfal, Alther's Mill in Redridge (#126's report), The State of the
// Mines in Westfall (SouthernStyleSims, #143), Scout Support in Hillsbrad
// (Taako, #148) and Stopping the Cycle in the Wetlands (#51). The #128 sweep
// against the Forever quest chains found Quinn's potions in Silverpine (Wild
// Eyes and Return to Quinn (Again) after Return to Quinn) and, at 30-40, Bloom
// of the Heavens, Sentiments of the Lost, Shared Fury and Friend of the Kirin
// Tor, each taken without the part before it. Each accept comes after every
// quest it follows is handed in; the optional ones may be left out, never
// taken early.

const WESTFALL = 'forever/alliance/02-westfall.guide';
const REDRIDGE = 'forever/alliance/04-redridge-mountains.guide';
const HILLSBRAD_HORDE = 'forever/horde/06-hillsbrad-foothills.guide';
const SILVERPINE = 'forever/horde/03-silverpine-forest.guide';
const HILLSBRAD_ALLIANCE = 'forever/alliance/30-40/01-hillsbrad-foothills.guide';
const ASHENVALE_30 = 'forever/alliance/30-40/03-ashenvale.guide';
const ARATHI = 'forever/alliance/30-40/05-arathi-highlands.guide';
const DARKSHORE = 'forever/alliance/03-darkshore.guide';
const THOUSAND_NEEDLES = 'forever/alliance/07-thousand-needles.guide';

test('Forever follow-ups are taken only once the quests before them are handed in', { skip }, () => {
	for (const [guide, quest, after, optional] of [
		[MULGORE, 99081, [99079]],
		[MULGORE, 99101, [99081]],
		[MULGORE, 99080, [99101]],
		[MULGORE, 99082, [99080]],
		[MULGORE, 98435, [760]],
		[TIRISFAL, 96899, [96897, 96898]],
		[TIRISFAL, 99156, [356], true],
		[REDRIDGE, 98386, [89]],
		[WESTFALL, 92745, [92742]],
		[HILLSBRAD_HORDE, 98094, [528]],
		[SILVERPINE, 91920, [430]],
		[SILVERPINE, 91921, [91920], true],
		[HILLSBRAD_ALLIANCE, 98209, [98208], true],
		[HILLSBRAD_ALLIANCE, 88758, [88757], true],
		[HILLSBRAD_ALLIANCE, 98297, [98291], true],
		[ASHENVALE_30, 98418, [98417], true],
		[ARATHI, 92459, [92458], true],
		// The #51 sweep: Holy Diver after all nine beached remains, Ivar the
		// Foul after Return to Quinn (Again); 92911 and 98298 are left out.
		[DARKSHORE, 87760, [4722, 4723, 4725, 4727, 4728, 4730, 4731, 4732, 4733]],
		[SILVERPINE, 425, [91921]],
		[SILVERPINE, 98298, [99], true],
		[WESTFALL, 92911, [92910], true],
		// Lou-Saydus (#225): Forever puts From the Ashes between War Banners
		// and Nek'rosh's Gambit, so Captain Stoutfist did not offer 465 when
		// War Banners was handed in.
		[THOUSAND_NEEDLES, 98221, [464]],
		[THOUSAND_NEEDLES, 465, [98221]],
	]) {
		const list = goals(guide);
		const take = list.findIndex(({ goal }) => is('accept', quest)(goal));
		if (take < 0 && optional) continue;
		assert.ok(take >= 0, `${guide}: accept ${quest} is in the guide`);
		for (const pre of after) {
			assert.ok(at(list, `${guide}: turnin ${pre}`, is('turnin', pre)) < take, `${guide}: ${quest} is taken after ${pre} is handed in`);
		}
	}
});

// --- Silverpine (Wyatt R, #161; Rupert, #229): Dalar Dawnweaver did not offer
// Stop the Spread to an Undead at 19 or a Tauren at 21 on the route, though
// the data gives it to every Horde race with no prerequisite.

test(`Rupert's and Wyatt R's reports: no guide sends you to Dalar Dawnweaver or the refugees for Stop the Spread (#229, #161)`, { skip }, () => {
	for (const guide of allGuides()) {
		const asked = goals(guide).filter(({ goal }) => goal.quest === 98299);
		assert.deepEqual(asked.map(({ goal }) => goal.t), [], `${guide} has no goal for 98299`);
	}
});

test(`${HILLSBRAD_ALLIANCE}: Lou-Saydus's report: Nek'rosh's Gambit, taken after From the Ashes in ${THOUSAND_NEEDLES}, is handed in on the Wetlands loop (#225)`, { skip }, () => {
	const needles = goals(THOUSAND_NEEDLES);
	assert.equal(needles.findIndex(({ goal }) => is('turnin', 465)(goal)), -1, 'the catapult is not lit in the guide that takes the quest');
	const done = at(needles, 'complete 98221', is('complete', 98221));
	assert.ok(located(needles[done]), 'the attack plans have a place');
	const list = goals(HILLSBRAD_ALLIANCE);
	assert.equal(list.findIndex(({ goal }) => is('accept', 98221)(goal)), -1, 'From the Ashes is not taken again');
	const lit = at(list, 'turnin 465', is('turnin', 465));
	assert.ok(at(list, 'turnin 98230', is('turnin', 98230)) < lit, 'after Howin');
	assert.ok(lit < at(list, 'accept 98223', is('accept', 98223)), 'before the Tattered Spellbook');
});

// --- Westfall (#144): Alba Fairmoon's Toxic Soil chain is not for Humans on
// Forever (Wowhead Forever: Dwarf, Night Elf, Gnome, Skyborne).

test(`${WESTFALL}: Alba Fairmoon's chain is not given to Humans (#144)`, { skip }, () => {
	const chain = new Set([92742, 92744, 92745, 92747, 92748]);
	const list = goals(WESTFALL).filter(({ goal }) => chain.has(goal.quest));
	assert.ok(list.length > 0, 'the chain is in the guide');
	for (const { step, goal } of list) {
		const races = [step.only, goal.only].flatMap((o) => (o && o.races) || []);
		assert.ok(races.length && !races.includes('Human'), `${goal.t} ${goal.quest} is for its races only, not Humans`);
	}
});

// --- Darkshore (XooVe, #213): the first loop walked past a Beached Sea
// Creature from Asterion to Buzzbox 411 and the second loop came back for it.

test(`${DARKSHORE}: XooVe's report: the Beached Sea Creature by Bashal'Aran is taken on the walk from Asterion to Buzzbox 411 (#213)`, { skip }, () => {
	const list = goals(DARKSHORE);
	const take = at(list, 'accept 4723 (Beached Sea Creature)', is('accept', 4723));
	assert.equal(list[take].step.title, "Bashal'Aran", "it is taken in the Bashal'Aran step");
	assert.ok(at(list, 'accept 957 (Asterion)', is('accept', 957)) < take, 'after Asterion');
	assert.ok(take < at(list, 'turnin 1001 (Buzzbox 411)', is('turnin', 1001)), 'before Buzzbox 411');
	// Handed in at the first hearth, with the Beached Sea Turtle, before the second loop.
	const handIn = at(list, 'turnin 4723', is('turnin', 4723));
	assert.equal(list[handIn].step, list[at(list, 'turnin 4722', is('turnin', 4722))].step, 'handed in with 4722');
	assert.ok(handIn < at(list, 'accept 4728', is('accept', 4728)), 'before the second loop');
});

test(`${TELDRASSIL}: Pynte's report: Zenn's Bidding is taken on the walk down to Dolanaar that passes Zenn (#89)`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, "accept 488 (Zenn's Bidding)", is('accept', 488));
	assert.ok(at(list, 'accept 2159 (Porthannius, leaving Shadowglen)', is('accept', 2159)) < take, 'after Porthannius');
	assert.ok(take < at(list, 'turnin 96630 (Lyreena Duskblade in Dolanaar)', is('turnin', 96630)), 'before the first Dolanaar stop');
});

const BADLANDS = 'forever/alliance/30-40/06-badlands.guide';
test(`${BADLANDS}: the same pattern as #89: Book of the Ancients is taken from Azore on the way to Karnitol's Chest, not on a walk back from it`, { skip }, () => {
	const list = goals(BADLANDS);
	const take = at(list, 'accept 6027 (Book of the Ancients)', is('accept', 6027));
	assert.ok(at(list, 'accept 1454 (Nijel\'s Point)', is('accept', 1454)) < take, 'after Nijel\'s Point');
	assert.ok(take < at(list, "turnin 1454 (Karnitol's Chest)", is('turnin', 1454)), 'before the chest');
});

// The same pattern elsewhere: a quest taken where the route already stands,
// instead of on a walk back to its giver later.
const STRANGLETHORN_HORDE = 'forever/horde/30-40/02-stranglethorn-vale.guide';
const TANARIS_ALLIANCE = 'forever/alliance/40-50/04-tanaris.guide';

test('#213: quests whose giver the route already stands at are taken there, not on a walk back', { skip }, () => {
	for (const [guide, quest, withGoal, what] of [
		[TIRISFAL, 365, is('accept', 590), "Calvin's duel at Solliden"],
		[TANARIS_ALLIANCE, 2781, is('accept', 2875), "Andre Firebeard's poster at Steamwheedle Port"],
		[STRANGLETHORN_HORDE, 192, is('turnin', 191), "Panther Mastery's second turn-in"],
	]) {
		const list = goals(guide);
		const take = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		assert.equal(list[take].step, list[at(list, `${guide}: ${what}`, withGoal)].step, `${guide}: ${quest} is taken at ${what}`);
	}
});

// Every leveling guide with a profession quest still plays to the end for a
// character who already has the profession (tests/guides.test.js plays them
// all without one).
test('the leveling guides with profession quests play to the end for a character with the profession', { skip }, () => {
	const pack = buildSimPack([DUROTAR, DUN_MOROGH, TELDRASSIL, ELWYNN]);
	try {
		const learn = (line, name) => `w.skills[${line}] = { name = "${name}", rank = 1, maxRank = 75 }`;
		for (const [guide, race, faction, skills, quest] of [
			[DUROTAR, 'Troll', 'Horde', learn(333, 'Enchanting'), null],
			[DUN_MOROGH, 'Dwarf', 'Alliance', `${learn(185, 'Cooking')} ${learn(164, 'Blacksmithing')}`, 384],
			[TELDRASSIL, 'NightElf', 'Alliance', learn(185, 'Cooking'), 4161],
			[ELWYNN, 'Human', 'Alliance', learn(393, 'Skinning'), null],
		]) {
			const g = pack.guides.find((x) => `${x.id}.guide` === guide);
			assert.ok(g, `${guide} compiles`);
			const [out, done] = playGuide(pack, g, { race, faction, cls: 'WARRIOR', before: skills, script: `${SIMULATE}\nemit({ quest = ${quest || 0} > 0 and C_QuestLog.IsQuestFlaggedCompleted(${quest || 0}) or false })` });
			assert.equal(out.stuck, undefined, `${guide} (${race}) is not stuck: ${JSON.stringify(out.stuck)}`);
			assert.ok(out.done, `${guide} (${race}) plays to the end`);
			if (quest) assert.equal(done.quest, true, `${guide}: a cook does ${quest}`);
		}
	} finally {
		pack.dispose();
	}
});

// --- Quests the guide accepted and turned in with nothing between waiting for
// their objectives, so the guide moved on to the turn-in with the quest
// unfinished: Camping 101: Cooking in Mulgore and Dun Morogh (speak with the
// cook) and, for the Alliance, It's a Secret to Everybody in Un'Goro (the
// Horde guide collects the compass, map and key).

const UN_GORO_ALLIANCE = 'forever/alliance/40-50/07-un-goro-crater.guide';

test('a quest with objectives is completed or collected between its accept and its turn-in', { skip }, () => {
	for (const [guide, quest, t, count] of [
		[MULGORE, 96661, 'complete', 1],
		[DUN_MOROGH, 96629, 'complete', 1],
		[UN_GORO_ALLIANCE, 3845, 'collect', 3],
	]) {
		const list = goals(guide);
		const accept = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		const turnin = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
		const between = list.slice(accept + 1, turnin).filter(({ goal }) => is(t, quest)(goal));
		assert.equal(between.length, count, `${guide}: ${count} ${t} goal(s) for ${quest} between its accept and its turn-in`);
	}
});

// --- Shadowglen (Pynte, 0.2.4): the first pickups, the totems and the class sigils.

// Conservator Ilthalaine stands beside the start, on the line from Melithar
// down to Tarindrella: the guide no longer sends you past him first.
test(`${TELDRASSIL}: Pynte's report: Conservator Ilthalaine's quest is taken before Melithar's`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const ilthalaine = at(list, 'accept 456 (The Balance of Nature)', is('accept', 456));
	const melithar = at(list, 'accept 458 (The Woodland Protector)', is('accept', 458));
	assert.equal(list[ilthalaine].s, 1, 'taken in the opening step');
	assert.ok(ilthalaine < melithar, 'Ilthalaine before Melithar');
	assert.equal(list.find(located).goal.npc, 2079, 'the arrow first leads to Conservator Ilthalaine');
});

// The Gnarlpine Totems are collected in the field like the Fel Moss, from
// both totem objects, so the window shows them with the kills, not after.
test(`${TELDRASSIL}: Pynte's report: the Gnarlpine Totems are open together with the kills and the Fel Moss, at both totem objects`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const totems = list[at(list, 'the Gnarlpine Totems (97977)', (g) => g.quest === 97977 && g.t !== 'accept' && g.t !== 'turnin')];
	const spots = totems.goal.spots || [];
	for (const object of [668482, 668493]) {
		for (const sp of data.spawns('object', object).filter((x) => x.map === 1438)) {
			for (const [x, y] of [...sp.pts, ...sp.more]) {
				const pt = { map: 1438, x, y };
				assert.ok(spots.some((o) => yards({ map: 1438, x: o.x, y: o.y }, pt) <= o.r + 1), `the totem ${object} at ${x},${y} lies in one of the goal's spots`);
			}
		}
	}
	// The report's state: one boar kill left to do, the boars and the moss done, one totem of four.
	const nightElf = { race: 'NightElf', raceName: 'Night Elf', faction: 'Alliance', cls: 'ROGUE', className: 'Rogue', level: 2 };
	const view = stepView(TELDRASSIL, nightElf, totems.s, `w.complete({ 458 })
		w.onQuest(456, { { required = 7, fulfilled = 3 }, { required = 4, fulfilled = 4 } })
		w.onQuest(459, { { required = 8, fulfilled = 8 } })
		w.onQuest(97977, { { required = 4, fulfilled = 1 } })`);
	assert.equal(view.groups.length, 1, `the step is one group: ${JSON.stringify(view.groups)}`);
	const open = view.goals.filter((g) => g.status === 'active').map((g) => g.quest);
	assert.deepEqual(open, [456, 97977], 'the Nightsabers and the totems are open at the same time');
});

// The sigil is taken once The Balance of Nature is in, and handed to the
// trainer on the visit after Shadowthread Cave, with the class training.
test(`${TELDRASSIL}: Pynte's report: each class's sigil is handed to its trainer at the training stop after Shadowthread Cave`, { skip }, () => {
	for (const [quest, cls] of [[3116, 'WARRIOR'], [3117, 'HUNTER'], [3118, 'ROGUE'], [3119, 'PRIEST'], [3120, 'DRUID']]) {
		const list = goals(TELDRASSIL).filter(forClass(cls));
		const take = at(list, `accept ${quest} (${cls})`, is('accept', quest));
		const give = at(list, `turnin ${quest} (${cls})`, is('turnin', quest));
		assert.ok(at(list, 'turnin 456 (The Balance of Nature)', is('turnin', 456)) < take, `${cls}: the sigil is taken once The Balance of Nature is handed in`);
		assert.ok(take < at(list, 'Webwood Venom Sacs (916)', (g) => g.t === 'collect' && g.quest === 916), `${cls}: taken before the cave`);
		assert.ok(at(list, 'turnin 916 (Webwood Venom)', is('turnin', 916)) < give, `${cls}: handed in after the cave`);
		const train = list.findIndex(({ goal }, i) => i > give && goal.t === 'train' && goal.class);
		assert.ok(train > give && list[train].s === list[give].s, `${cls}: handed in on the training stop, before the training`);
		assert.ok(!list.slice(take, give).some(({ goal }) => goal.t === 'train' && goal.class), `${cls}: no class training between the sigil's accept and its turn-in`);
	}
});

// --- Darkshire (Yendi, 0.2.3): part 1 of Look to the Stars needs a Bronze Tube.

const NEEDLES = 'forever/alliance/07-thousand-needles.guide';

test(`${NEEDLES}: Yendi's report: Herble's Bronze Tube is offered before Look to the Stars is handed in, without holding the step`, { skip }, () => {
	const list = goals(NEEDLES);
	const give = at(list, 'turnin 174 (Look to the Stars)', is('turnin', 174));
	const buy = at(list, 'buy 4371 (Bronze Tube)', (g) => g.t === 'buy' && g.item === 4371);
	assert.ok(buy < give && list[buy].s === list[give].s, 'bought on the same stop, before the turn-in');
	assert.equal(list[buy].goal.npc, 3133, 'from Herble Baubbletump, beside Viktori');
	// A player who has the tube, or who already handed it in, is not held by it.
	assert.equal(list[buy].goal.optional, true, 'the buy is optional');
});

// --- Zephras Isle (Sato, 0.2.3).

const ZEPHRAS_HORDE = 'forever/horde/skyborne/01-zephras-isle.guide';
const ZEPHRAS_ALLIANCE = 'forever/alliance/skyborne/01-zephras-isle.guide';
const SKYBORNE_HORDE = { race: 'Skyborne', raceName: 'Skyborne', faction: 'Horde', cls: 'ROGUE', className: 'Rogue', level: 6 };
const SKYBORNE_ALLIANCE = { race: 'Skyborne', raceName: 'Skyborne', faction: 'Alliance', cls: 'ROGUE', className: 'Rogue', level: 4 };
// Zephras Isle has no Era frame: points compare in map percent.
const close = (a, b, pct) => a.map === b.map && Math.hypot(a.x - b.x, a.y - b.y) <= pct;

// The Great Outdoors: /sit by Raan's campfire for Boosted Rest; nothing to click.
test('Sato\'s report: The Great Outdoors on Zephras Isle is done by sitting at Raan\'s campfire, not by clicking it', { skip }, () => {
	data = data || loadData(DATA);
	const fire = data.spawns('object', 460003).find((x) => x.map === 2521);
	for (const guide of [ZEPHRAS_HORDE, ZEPHRAS_ALLIANCE]) {
		const list = goals(guide);
		assert.deepEqual(list.filter(({ goal }) => goal.quest === 96101 && goal.t === 'interact').map(({ s }) => s), [], `${guide}: no click goal`);
		const take = at(list, `${guide}: accept 96101`, is('accept', 96101));
		const sit = at(list, `${guide}: complete 96101`, is('complete', 96101));
		assert.ok(take < sit && sit < at(list, `${guide}: turnin 96101`, is('turnin', 96101)), `${guide}: done between its accept and its turn-in`);
		assert.ok(close(list[sit].goal, { map: 2521, x: fire.pts[0][0], y: fire.pts[0][1] }, 0.3), `${guide}: the arrow leads to Raan's campfire`);
	}
});

// The Gift of Skysight and Reading the Ley Lines are the racial spells cast
// at the place: the line says so, and still counts from the quest log.
test('Sato\'s report: the Skysight and Read Ley Line objectives tell you to cast the racial, and tick from the quest log', { skip }, () => {
	for (const [guide, who, quest, spell] of [[ZEPHRAS_HORDE, SKYBORNE_HORDE, 92598, 'Skysight'], [ZEPHRAS_ALLIANCE, SKYBORNE_ALLIANCE, 92597, 'Read Leyline']]) {
		const list = goals(guide);
		const i = at(list, `${guide}: the objective of ${quest}`, (g) => g.quest === quest && g.oi === 1);
		const view = stepView(guide, who, list[i].s, `w.onQuest(${quest}, { { required = 1, fulfilled = 1 } })`);
		const line = view.goals.find((g) => g.quest === quest && g.t !== 'accept' && g.t !== 'turnin');
		assert.ok(!/^Click\b/.test(line.text) && line.text.includes(spell), `${guide}: "${line.text}" names ${spell}, not a click`);
		assert.equal(line.status, 'done', `${guide}: ticked once the quest log counts it`);
	}
});

// Welcome to Shen'dar Village: talking to Illaya before the step counts.
test(`${ZEPHRAS_HORDE}: Sato's report: Welcome to Shen'dar Village follows its objectives, and is taken before Illaya's talk`, { skip }, () => {
	const list = goals(ZEPHRAS_HORDE);
	assert.ok(at(list, 'accept 92514', is('accept', 92514)) < at(list, 'complete 92595 (talk to Illaya)', is('complete', 92595)), 'taken before the talk to Illaya for The Windshapers, which counts for it too');
	const step = list[at(list, 'turnin 92514', is('turnin', 92514))].s;
	assert.deepEqual(list.filter(({ s, goal }) => s === step && goal.t === 'talk').map(({ goal }) => goal.npc), [], 'no bare talk goal that only counts during the step');
	const objectives = (illaya, coriella) => stepView(ZEPHRAS_HORDE, SKYBORNE_HORDE, step, `w.complete({ 92595 })
		w.onQuest(92514, { { required = 1, fulfilled = ${illaya} }, { required = 1, fulfilled = ${coriella} } })`)
		.goals.filter((g) => g.quest === 92514 && g.t !== 'turnin').map((g) => g.status);
	assert.deepEqual(objectives(1, 0).map((st) => st === 'done'), [true, false], 'Illaya done earlier, Coriella still to do');
	assert.ok(objectives(1, 1).every((st) => st === 'done'), 'both done: only the turn-in is left');
});

// Aggressive Encroachment: the Scrawny Ursera are on the slope west of
// Thendal Village (Wowhead Forever), not in the village.
test('Sato\'s report: the Scrawny Ursera step leads to the slope west of Thendal Village', { skip }, () => {
	const corrections = require('../tools/lib/data/corrections.json');
	const wowhead = corrections.npcs[250926].addSpawns[2521].pts;
	assert.ok(wowhead.every(([x]) => x <= 41.6), 'the corrected spawns are all west of the village');
	for (const guide of [ZEPHRAS_HORDE, ZEPHRAS_ALLIANCE]) {
		const list = goals(guide);
		const { goal } = list[at(list, `${guide}: Scrawny Ursera Claw`, (g) => g.t === 'collect' && g.item === 251918)];
		assert.ok(wowhead.some(([x, y]) => close(goal, { map: 2521, x, y }, 0.3)), `${guide}: the arrow's point ${goal.x},${goal.y} is at a Scrawny Ursera spawn`);
		for (const sp of (goal.spots || []).filter((o) => !o.alt)) assert.ok(sp.x <= 41.7, `${guide}: the spot ${sp.x},${sp.y} is west of the village`);
	}
});

// --- Strays (#175, Phear): a mob or two on their own, hundreds of yards from the camp
// that holds the rest, drew the point and the arrow away from the camp the step is about.

test('Phear\'s report: a kill or collect leads to the camp that holds its mobs, not a stray one or two far from it', { skip }, () => {
	// [guide, the goal, the camp's x and y range (map percent)]
	const cases = [
		[DUN_MOROGH, 'Frostmane Headhunter (Frostmane Hold)', (g) => g.t === 'kill' && g.npc === 1123 && g.quest === 287, [20, 27, 49, 56]],
		['forever/alliance/03-darkshore.guide', 'Grizzled Scalp', (g) => g.t === 'collect' && g.item === 5414, [37, 46, 69, 83]],
		['forever/alliance/50-60/02-felwood.guide', 'Jadefire Hellcaller (Jadefire Run)', (g) => g.t === 'kill' && g.npc === 7111, [38, 44, 13, 23]],
		['forever/horde/05-stonetalon-mountains.guide', 'Stonetalon Sap', (g) => g.t === 'collect' && g.item === 5582, [32, 41, 9, 21]],
		['forever/horde/50-60/01-un-goro-crater.guide', 'Bloodpetal Lasher (east side)', (g) => g.t === 'kill' && g.npc === 6509, [55, 77, 20, 50]],
		['forever/horde/50-60/01-un-goro-crater.guide', 'Bloodpetal Thresher (east side)', (g) => g.t === 'kill' && g.npc === 6511, [55, 77, 20, 50]],
		['forever/horde/40-50/03-feralas.guide', 'Marsh Flesheater (huts on the western shore)', (g) => g.t === 'kill' && g.npc === 751, [60, 75, 75, 100]],
	];
	const inCamp = ([x0, x1, y0, y1]) => (p) => p.x >= x0 && p.x <= x1 && p.y >= y0 && p.y <= y1;
	for (const [guide, what, pred, camp] of cases) {
		for (const { goal } of goals(guide).filter(({ goal }) => pred(goal))) {
			assert.ok(inCamp(camp)(goal), `${guide}: ${what}: the point ${goal.x},${goal.y} is at the camp`);
			const arrow = goal.spots.filter((s) => !s.alt);
			assert.ok(arrow.length && arrow.every(inCamp(camp)), `${guide}: ${what}: the arrow picks only the camp: ${JSON.stringify(goal.spots)}`);
			assert.ok(goal.spots.some((s) => s.alt && !inCamp(camp)(s)), `${guide}: ${what}: the strays stay alternatives`);
		}
		assert.ok(goals(guide).some(({ goal }) => pred(goal)), `${guide}: ${what} is in the guide`);
	}
	// Not strays: a sparse trail of single spawns (the Lingering Highborne through the ruins), spawns all
	// over a zone (Scourgestones, the OOX beacon) and a target with six spawns or fewer (Pristine Black
	// Diamond). The walk still starts at the spawn nearest the previous goal, a spot the arrow searches.
	const kept = [
		['forever/alliance/50-60/01-burning-steppes.guide', 7972],
		['forever/class/priest/blood-of-morphaz.guide', 7972],
		['forever/alliance/50-60/03-winterspring.guide', 12840],
		['forever/horde/50-60/01-un-goro-crater.guide', 12840],
		['forever/horde/40-50/02-feralas.guide', 8705],
		['forever/class/shaman/darkreaver.guide', 18335],
	];
	for (const [guide, item] of kept) {
		const list = goals(guide);
		const { goal } = list[at(list, `${guide}: collect ${item}`, (g) => g.t === 'collect' && g.item === item)];
		const first = goal.spots[0];
		assert.ok(!first.alt && first.n === 1 && Math.hypot(first.x - goal.x, first.y - goal.y) <= 0.1, `${guide}: collect ${item}: the walk starts at the point ${goal.x},${goal.y}: ${JSON.stringify(first)}`);
	}
	const ichor = goals('forever/alliance/50-60/01-burning-steppes.guide').find(({ goal }) => goal.item === 7972).goal;
	const trail = ichor.spots.filter((s) => s.x >= 34 && s.x <= 41 && s.y >= 45 && s.y <= 62);
	assert.equal(trail.length, 6, JSON.stringify(ichor.spots));
	assert.ok(trail.every((s) => !s.alt), 'every spot of the Highborne trail is searched');
});

// The goals the stray rule moved, checked against their steps (#175 review): the
// Grizzled Scalps are taken where the bears are, and cloth the guide says to buy
// leads to the Auction House, not to the guards and mobs that happen to drop it.

test('forever/alliance/03-darkshore.guide: the Grizzled Scalps are collected in the step at the Grove, where the bears are and Buzzbox 525 takes them', { skip }, () => {
	const list = goals('forever/alliance/03-darkshore.guide');
	const i = at(list, 'Grizzled Scalp', (g) => g.t === 'collect' && g.item === 5414);
	const turnin = at(list, 'turnin 1003', is('turnin', 1003));
	assert.equal(list[i].step, list[turnin].step, 'one step: the bears and Buzzbox 525');
	assert.ok(i < turnin);
	assert.ok(yards(list[i].goal, list[turnin].goal) < 300, `the scalps' point ${list[i].goal.x},${list[i].goal.y} is near Buzzbox 525`);
});

test('the cloth the guides tell you to buy leads to the Auction House: the capitals\' cloth donations and Grimand\'s Runecloth', { skip }, () => {
	// The auctioneers: Stormwind's Trade District (live frame) and Ironforge's (Era frame).
	const ah = { 1453: { x: 61.2, y: 71.3 }, 1455: { x: 24.2, y: 74.7 } };
	const cases = [
		['forever/alliance/50-60/06-silithus.guide', [7793, 7794, 7795, 7807, 7808, 7809, 7811, 7802, 7803, 7804, 7805]],
		['forever/collectibles/mounts/alliance/paladin-charger.guide', [7642]],
	];
	for (const [guide, quests] of cases) {
		for (const quest of quests) {
			const list = goals(guide).filter(({ goal }) => goal.t === 'collect' && goal.quest === quest && [2592, 4306, 4338, 14047].includes(goal.item));
			assert.ok(list.length, `${guide}: the cloth of ${quest}`);
			for (const { goal } of list) {
				const at_ = ah[goal.map];
				assert.ok(at_ && goal.x === at_.x && goal.y === at_.y, `${guide}: ${quest} ${goal.itemName}: the point ${goal.map} ${goal.x},${goal.y} is the Auction House`);
				for (const s of (goal.spots || []).filter((o) => !o.alt)) assert.deepEqual([s.x, s.y], [at_.x, at_.y], `${guide}: ${quest}: the arrow picks only the Auction House`);
			}
		}
	}
});

// --- Steps the arrow cannot lead (rikette, #140): an objective step written
// only as bare `complete` lines has no place, so the arrow points nowhere.
// The objectives go on kill, collect and interact goals (or a placed
// `complete` for a place to reach), which the data locates.

test(`${DUN_MOROGH}: rikette's report: the Grizzled Den leads the arrow to the wendigo cave`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const den = list.filter(({ step }) => step.title === 'The Grizzled Den');
	assert.ok(den.length, 'the Grizzled Den step is in the guide');
	for (const quest of [98321, 313]) {
		const goal = den.find(({ goal: g }) => g.quest === quest && g.t === 'collect');
		assert.ok(goal && located(goal), `the den's objective of ${quest} has a place`);
		// The cave lies south-west of Kharanos (46,51), around 41-44,47-50.
		assert.ok(yards(goal.goal, { map: goal.goal.map, x: 42, y: 48.5 }) < 250, `${quest} leads into the den (${goal.goal.x},${goal.goal.y})`);
	}
});

// Escorts and events start at their NPC in the step before and follow it, so
// a bare `complete` is right there: the arrow has the NPC to lead to.
const FOLLOWS_AN_NPC = new Set([
	5821, // Bodyguard for Hire: the Gizelton caravan escort (Desolace)
	665, // Sunken Treasure: escort Doctor Draxlegauge (Arathi Highlands)
	660, // Hints of a New Plague?: escort Kinelory (Arathi Highlands)
	4491, // A Little Help From My Friends: escort Ringo (Un'Goro Crater)
	863, // The Escape: escort Wizzlecrank (The Barrens)
	7622, // The Balance of Light and Shadow: the event at Eris Havenfire
]);

test('every step with a quest objective to do has a goal the arrow can lead to', { skip }, () => {
	const offenders = [];
	for (const guide of allGuides()) {
		const steps = [...new Set(goals(guide).map(({ step }) => step))];
		steps.forEach((step, i) => {
			const open = step.goals.filter((g) => g.t === 'complete' && !FOLLOWS_AN_NPC.has(g.quest));
			if (open.length && !step.goals.some((g) => g.map != null && g.x != null)) offenders.push(`${guide} step ${i + 1} (${step.title}): complete ${open.map((g) => g.quest).join(', ')}`);
		});
	}
	assert.deepEqual(offenders, [], 'steps whose objectives have no place');
});

// A turn-in's place does not lead to the objective (Dun Morogh, Rumbleshot's
// Ammo: the arrow sent players to Hegnar while the Ammo Crate stands by
// Mountaineer Gretchen). When the data knows where every objective of a quest
// is (an item that drops from a spawned NPC or object, an object to use, or a
// place to reach: an area trigger with a position, like The Red Crystal's
// "Locate the large, red crystal", #241), a bare `complete` is not enough: the
// step needs a placed goal of its own for that quest (`collect <item> quest
// <id>.<n>`, `interact`, `complete <id> @x,y`) or a questless one (`goto`,
// `use @x,y`).
const OBJECTIVE_WITHOUT_A_PLACE = new Set([
	339, 340, 341, 342, // Green Hills of Stranglethorn: pages drop at random across the zone
	96605, 96608, // The Great Outdoors: the campfire is built with a spell, not clicked
	6134, // Ghost-o-plasm Round Up: the spectres come to the Ghost Magnets in the Kodo Graveyard, not their data spawn
	1149, // Test of Faith: the leap is from the planks beside Dorn Plainstalker (54,41.5); the data's trigger lies at 26.4,32.9, far from him
	1699, // The Rethban Gauntlet: the trigger is at the first fork inside the Rethban Caverns, and its mouth is not marked yet (tests/guides-caves.test.js)
]);

test('Rumbleshot\'s Ammo, The Red Crystal: every objective the data can place has a goal of its own, not only the turn-in', { skip }, () => {
	const placed = (g) => g.map != null && g.x != null;
	const spawned = (x) => !!x && Object.keys(x.spawns || {}).length > 0;
	const knownPlace = (o) =>
		o.type === 'item'
			? Object.keys(data.items[o.id]?.drops?.npc || {}).some((n) => spawned(data.npcs[n])) || Object.keys(data.items[o.id]?.drops?.object || {}).some((n) => spawned(data.objects[n]))
			: o.type === 'object'
				? spawned(data.objects[o.id])
				: o.type === 'event' && o.id != null && placed(o); // an area trigger; an escort's or a script's event has no id
	const offenders = [];
	for (const guide of allGuides()) {
		compiled(guide).steps.forEach((step, i) => {
			for (const g of step.goals) {
				if (g.t !== 'complete' || placed(g) || OBJECTIVE_WITHOUT_A_PLACE.has(g.quest)) continue;
				const objectives = data.quests[g.quest]?.objectives || [];
				if (!objectives.length || !objectives.every(knownPlace)) continue;
				const leads = (o) => placed(o) && (o.quest === g.quest ? o.t !== 'accept' && o.t !== 'turnin' : o.quest == null && (o.t === 'goto' || o.t === 'use'));
				if (step.goals.some(leads)) continue;
				offenders.push(`${guide} step ${i + 1} (${step.title}): complete ${g.quest}`);
			}
		});
	}
	assert.deepEqual(offenders, [], 'objectives led to only by their turn-in, or not at all');
});

test(`${DARKSHORE}: Twerkjob's report: The Red Crystal leads the arrow to the crystal on the eastern ridge (#241)`, { skip }, () => {
	const list = goals(DARKSHORE);
	const complete = list[at(list, 'complete 4811 (The Red Crystal)', is('complete', 4811))];
	// The step's first placed goal for the quest, past its accept: where the arrow leads.
	const lead = list.find(({ step, goal: g }) => step === complete.step && g.quest === 4811 && g.t !== 'accept' && g.t !== 'turnin' && located({ goal: g }));
	assert.ok(lead, 'the red crystal step has a goal the arrow can lead to');
	// "Locate the large, red crystal on Darkshore's eastern mountain range", the quest's area trigger.
	const crystal = data.quests[4811].objectives.find((o) => o.type === 'event');
	assert.ok(yards(lead.goal, crystal) < 30, `the arrow leads to the crystal (${lead.goal.x},${lead.goal.y})`);
});

test(`${DUN_MOROGH}: Rumbleshot's Ammo leads to the Ammo Crate by Mountaineer Gretchen, not to Hegnar`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const ammo = list.find(({ goal: g }) => g.t === 'collect' && g.quest === 5541);
	assert.ok(ammo && located(ammo), 'the ammo has a place');
	assert.ok(yards(ammo.goal, { map: ammo.goal.map, x: 44.13, y: 56.95 }) < 30, `the ammo is at the crate (${ammo.goal.x},${ammo.goal.y})`);
});

test('legacy-challenges: Return to Bodley is turned in before Back to the Beginning is taken', { skip }, () => {
	const list = goals('forever/legacy/legacy-challenges.guide');
	const bodley = at(list, 'turnin 8996', (g) => g.t === 'turnin' && g.quest === 8996);
	for (const quest of [8997, 8998]) assert.ok(bodley < at(list, `accept ${quest}`, (g) => g.t === 'accept' && g.quest === quest), `8996 before ${quest}`);
});

// --- Boats in open water (Fitz's playtest at the Auberdine pier): a boat's
// stop in travel.json is where the ship stands (TaxiPathNode), most of them in
// open water 12-14 yd off the pier. A goto there completes only within 8 yd of
// it, so the step cannot finish without swimming and the arrow points into the
// sea. Every goto at a transport (within 40 yd of its stop) is on walkable
// ground: dry deck, pier or platform within 8 yd, on the navigation grid.

const NAV = path.join(__dirname, '..', 'data', 'local', 'nav');
const navIndex = fs.existsSync(path.join(NAV, 'index.json')) ? JSON.parse(fs.readFileSync(path.join(NAV, 'index.json'), 'utf8')) : null;
const navSkip =
	skip ||
	needs('travel.json', 'zones.json') ||
	(!navIndex ? 'no navigation build in data/local/nav (node tools/polestar.js nav build)' : navIndex.version !== require('../tools/lib/nav/grid/format').VERSION ? `data/local/nav is tile version ${navIndex.version}: rebuild it (node tools/polestar.js nav build)` : false);

test("Fitz's playtest: every goto at a boat, zeppelin or tram stop is on its deck or pier, not in the water", { skip: navSkip }, () => {
	const { openNav } = require('../tools/lib/nav/path');
	const { FLAG, TILE_CELLS, cellOf } = require('../tools/lib/nav/grid/format');
	const { Geo } = require('../tools/lib/planner/geo');
	const read = (f) => JSON.parse(fs.readFileSync(path.join(DATA, f), 'utf8'));
	const nav = openNav({ dir: NAV });
	const geo = new Geo(read('map-frames.json'), read('zones.json'));
	const stops = read('travel.json').transports.flatMap((t) => ['a', 'b'].map((side) => ({ id: `${t.id} (${t[side].name})`, ...t[side] })));
	// A dry walkable surface in the cell at (wx, wy): not swim or blocked, above any water there, in a region the
	// router snaps to (not a pocket under the deck).
	const dry = (c, wx, wy) => {
		const a = cellOf(wx, wy);
		const t = nav.tile(c, a.col, a.row);
		if (!t) return false;
		const k = a.j * TILE_CELLS + a.i;
		const s = [];
		for (let e = t.first[k]; e < t.first[k + 1]; e++) s.push({ e, z: t.z[e], f: t.flags[e] });
		const water = Math.max(-Infinity, ...s.filter((q) => q.f & FLAG.SWIM).map((q) => q.z));
		return s.some((q) => !(q.f & (FLAG.SWIM | FLAG.BLOCKED)) && q.z > water && (nav.regionSize(c, a.col, a.row, q.e) ?? 1000) >= 1000);
	};
	const nearDry = (c, wx, wy) => {
		if (dry(c, wx, wy)) return true;
		for (let r = 2; r <= 8; r += 2) for (let deg = 0; deg < 360; deg += 15) if (dry(c, wx + r * Math.cos((deg * Math.PI) / 180), wy + r * Math.sin((deg * Math.PI) / 180))) return true;
		return false;
	};
	const offenders = new Set();
	let checked = 0;
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.t !== 'goto') continue;
			const w = geo.toWorld(goal.map, goal.x, goal.y, goal.f || 'l');
			if (!w) continue;
			const stop = stops.find((s) => s.c === w.c && Math.hypot(s.wx - w.wx, s.wy - w.wy) <= 40);
			if (!stop) continue;
			checked++;
			if (!nearDry(w.c, w.wx, w.wy)) offenders.add(`${guide} step "${step.title}": goto ${goal.x},${goal.y} "${goal.text}" by ${stop.id}`);
		}
	}
	assert.ok(checked >= 10, `the guides' transport gotos are found (${checked})`);
	assert.deepEqual([...offenders], [], 'transport gotos with no deck or pier within 8 yd');
});

// --- Typed coordinates on the wrong map (Fitz's playtest: Darkshore's "Boat to
// Stormwind" pointed into Moonglade). Coordinates without `map` are on the zone
// in effect, and a `zone` line holds for the steps after it, even when its step
// is for some characters only: the Night Elf Druids' Moonglade trip set zone
// Moonglade for the rest of Darkshore, and a Paladin trip set Thunder Bluff for
// the Barrens Warlocks' summoning circle in Orgrimmar. Each such goal is on the
// zone every character who sees it is in: the last `zone` line of the steps
// that character sees.

test("Fitz's playtest: typed coordinates are on the zone of every character who sees them", { skip: skip || needs('races.json') }, () => {
	const { characterKeys } = require('../tools/lib/dsl/conditions');
	const races = JSON.parse(fs.readFileSync(path.join(DATA, 'races.json'), 'utf8'));
	const classesOf = (race, side) => (races[race] && races[race][side] ? races[race][side].classes : null);
	const offenders = [];
	for (const guide of allGuides()) {
		const g = compiled(guide);
		const ast = g._ast;
		const lines = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').split(/\r?\n/);
		const zoneAt = (ln) => (ln ? lines[ln - 1].trim() : 'no zone');
		const head = { factions: ast.header.faction ? [ast.header.faction] : null, races: ast.header.races || null, classes: ast.header.classes || null };
		// Every step's `zone` lines, with who sees the step.
		const zoneLines = ast.steps.flatMap((s, i) => {
			const end = i + 1 < ast.steps.length ? ast.steps[i + 1].line : lines.length + 1;
			const who = characterKeys([head, s.only], classesOf);
			const out = [];
			for (let ln = s.line + 1; ln < end; ln++) if (/^\s+zone\b/.test(lines[ln - 1])) out.push({ ln, who });
			return out;
		});
		ast.steps.forEach((s, si) => {
			s.goals.forEach((ag, gi) => {
				if (!ag.explicitCoords || ag.coordMap !== undefined) return;
				const compiledZone = zoneAt(ag.zone && ag.zone.line);
				const elsewhere = new Set();
				for (const k of characterKeys([head, s.only, ag.only], classesOf)) {
					let ln = ast.header.zone ? ast.header.zone.line : null;
					for (const z of zoneLines) if (z.ln < ag.line && z.who.has(k)) ln = z.ln;
					if (zoneAt(ln) !== compiledZone) elsewhere.add(zoneAt(ln));
				}
				const goal = g.steps[si].goals[gi];
				if (elsewhere.size) offenders.push(`${guide}:${ag.line} (${goal.t} ${goal.x},${goal.y}) is on ${compiledZone}, for characters in ${[...elsewhere].join(', ')}`);
			});
		});
	}
	assert.deepEqual(offenders, [], 'typed coordinates on a zone some of their characters are not in');
});

// --- Hearths on another guide's bind (#171): Hillsbrad's "Hearth to Tarren
// Mill" relied on the bind the Stonetalon guide makes, so a player who
// skipped it, or started Hillsbrad from the picker, was told to hearth with a
// Hearthstone set to Camp Taurajo. A guide that hearths to an inn binds there
// itself first, on a step everyone plays (a goal that ticks at once for a
// player already bound). The guides below never pass the inn before their
// hearth, so a bind there would add a detour; they still rely on the guide
// before them.
const HEARTH_ON_AN_EARLIER_BIND = new Set([
	// Enters the Badlands from Ironband's dig site in south-east Loch Modan; Thelsamar is off the way.
	'forever/alliance/30-40/06-badlands.guide Stoutlager Inn',
	// Starts at the Broken Pillar and goes down into the crater; Gadgetzan is to the north.
	'forever/horde/50-60/01-un-goro-crater.guide Gadgetzan',
]);

test('#171: every hearth is to an inn the guide binds at first', { skip }, () => {
	const offenders = [];
	for (const guide of allGuides()) {
		const bound = new Set();
		for (const { step, goal } of goals(guide)) {
			if (goal.t === 'sethome' && everyone({ step, goal })) bound.add(goal.location);
			const key = `${guide} ${goal.location}`;
			if (goal.t === 'hearth' && !bound.has(goal.location) && !HEARTH_ON_AN_EARLIER_BIND.has(key)) offenders.push(`${key} (step ${step.title})`);
		}
	}
	assert.deepEqual(offenders, [], 'hearths to an inn the guide has not bound at');
});

// --- Croaky's Head (Syfin, #221): Croaky, a named elite, roams the murloc
// shore south of the Eastvale bridge, where the second east loop collects the
// Torn Murloc Fins. Its head starts Croaky's Head for Merell Ross at
// Ridgepoint Tower, a short way east. The loot and the accept are optional
// goals of the murloc step; the turn-in is a plain goal of a Ridgepoint Tower
// step, which holds only a player who took the quest (an optional accept
// vouches for nobody who did not).

test(`${ELWYNN}: Syfin's report (#221): Croaky's Head is an optional extra; Ridgepoint Tower holds and leads the arrow only with the head`, { skip }, () => {
	const pack = buildSimPack([ELWYNN]);
	try {
		const g = pack.guides[0];
		data = data || loadData(DATA);
		const [x, y] = data.npcs[248277].spawns[1429].pts[0];
		// Recorded from the simulated player's own actions, once the engine has
		// settled: the first Torn Murloc Fin (the murloc step is live; with the
		// head, it is looted and right-clicked there), and any hand-in of
		// Croaky's Head (the step it is handed in from, and where the arrow
		// leads). The game takes no turn-in for a quest the player does not hold.
		const watch = (head) => `
			local E, w = Polestar.Engine, stub.world
			local murlocs, ridge = false, false
			local progress, turnIn = w.progress, w.turnIn
			w.progress = function(q, ...)
				if q == 46 and not murlocs then
					murlocs = {}
					if ${head} then
						w.addItem(247826, 1)
						w.accept(91740, {}, "Croaky's Head")
						stub.advance(0.6)
					end
					for _, v in ipairs(E.GetStepView(E.GetStepIndex()).goals) do
						if v.quest == 91740 or v.item == 247826 then murlocs[#murlocs + 1] = v.t .. " " .. tostring(v.optional) end
					end
				end
				return progress(q, ...)
			end
			w.turnIn = function(q, ...)
				if q == 91740 then
					local i, wp = E.GetStepIndex(), E.GetWaypoint()
					ridge = { title = E.GetStepView(i).title, status = E.GetStepView(i).goals[1].status, wp = wp and { map = wp.map, x = wp.x, y = wp.y } or false }
					if not w.log[q] then return end
				end
				return turnIn(q, ...)
			end
			${SIMULATE}
			local view
			for i, s in ipairs(SIM_GUIDE.steps) do if s.title == "Ridgepoint Tower" then view = E.GetStepView(i).goals[1].status end end
			emit({ murlocs = murlocs, ridge = ridge, later = view or false, done = C_QuestLog.IsQuestFlaggedCompleted(91740) })`;
		for (const head of [false, true]) {
			const [out, got] = playGuide(pack, g, { race: 'Human', faction: 'Alliance', cls: 'WARRIOR', script: watch(head) });
			const who = head ? 'with the head' : 'without the head';
			assert.equal(out.stuck, undefined, `${who}: not stuck: ${JSON.stringify(out.stuck)}`);
			assert.ok(out.done, `${who}: plays to the end`);
			assert.deepEqual(got.murlocs, ['collect true', 'accept true'], `${who}: the head and its accept are optional goals of the murloc step`);
			assert.equal(got.done, head, `${who}: Croaky's Head ${head ? 'is' : 'is not'} handed in`);
			if (head) {
				assert.equal(got.ridge && got.ridge.title, 'Ridgepoint Tower', 'with the head: handed in at the Ridgepoint Tower step');
				assert.equal(got.ridge.status, 'active', 'the turn-in holds the step');
				assert.ok(got.ridge.wp && yards(got.ridge.wp, { map: 1429, x, y }) <= 5, `the arrow leads to Merell Ross at Ridgepoint Tower: ${JSON.stringify(got.ridge.wp)}`);
				assert.equal(got.later, 'done');
			} else {
				assert.equal(got.ridge, false, 'without the head: Ridgepoint Tower is passed, nothing is handed in there');
				assert.equal(got.later, 'na', "without the head: the turn-in is not this player's");
			}
		}
	} finally {
		pack.dispose();
	}
});

// --- A goal on a neighbour's map (#246): Kadrak stands at the Mor'shan
// Rampart, in the Barrens (Wowhead Forever; AreaTable puts the Rampart, 1703,
// under the Barrens), where the Barrens and Ashenvale maps overlap. The step's
// `zone Ashenvale` put him on Ashenvale's map, so the travel planner took him
// for a target in Ashenvale and sent players on the Gold Road through the
// zone crossing to its Ashenvale end, 110 yd past him, and back.
const STONETALON_HORDE = 'forever/horde/05-stonetalon-mountains.guide';

test(`${STONETALON_HORDE}: #246: Kadrak's goals are on the Barrens' map, and the Ashenvale steps after them on Ashenvale's`, { skip }, () => {
	const list = goals(STONETALON_HORDE);
	const kadrak = [is('turnin', 6541), is('accept', 6543), is('turnin', 6543)].map((p, i) => list[at(list, `Kadrak goal ${i + 1}`, p)].goal);
	for (const g of kadrak) assert.equal(g.map, 1413, `${g.t} ${g.quest} is on The Barrens (1413), not ${g.map}`);
	const scout = list[at(list, 'the Warsong Scout Update', (g) => g.t === 'collect' && g.item === 16764)].goal;
	assert.equal(scout.map, 1440, 'the Warsong Scout is still in Ashenvale');
});

// Tirion's quests have two givers in the data: Tirion Fordring (1855) at his
// hut on the Thondroril, and Lord Tirion Fordring (12126), who stands in
// Hearthglen only during the In Dreams event. On Western Plaguelands' map the
// compiler picked the one spawned there, 12126, and sent players into the
// Scarlet town (the Alliance Western Plaguelands and Horde Felwood guides).
test('#246: every goal with Tirion leads to Tirion Fordring at his hut, never to Lord Tirion Fordring in Hearthglen', { skip }, () => {
	const tirion = [5542, 5543, 5544, 5742, 5781];
	const found = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (!tirion.includes(goal.quest) || !['accept', 'turnin'].includes(goal.t)) continue;
			found.push(`${guide} ${goal.t} ${goal.quest}`);
			const picked = { npc: goal.npc, map: goal.map };
			assert.deepEqual(picked, { npc: 1855, map: 1423 }, `${guide} (step ${step.title}) ${goal.t} ${goal.quest}: Tirion Fordring on the Eastern Plaguelands' map`);
		}
	}
	for (const guide of ['forever/alliance/50-60/04-western-plaguelands.guide', 'forever/horde/50-60/02-felwood.guide']) {
		for (const q of [5542, 5543, 5544]) assert.ok(found.includes(`${guide} accept ${q}`), `${guide} takes ${q} from Tirion`);
	}
});

// The same pattern everywhere: where the zone maps overlap, the data spawns an
// NPC or object at one spot on both maps, and the step's zone picks the map.
// A goal on the map of a zone Wowhead Forever does not list it in, while the
// data has it at that spot on a map of one Wowhead lists, routes the player
// standing beside it through the crossing to the other zone and back (the
// travel planner takes the target's zone from its map). Drops count when no
// dropper is listed in the goal's zone. Needs Wowhead Forever's list cache
// (data/sources/wowhead/codex, `polestar codex build`).
const NEIGHBOUR_MAP = new Set([
	// The optional hand-in at Garush shares a step with the Alliance's at Pureheart in Western Plaguelands.
	'forever/reputation/argent-dawn.guide talk npc 10839',
]);
const wowheadLists = fs.existsSync(path.join(SOURCES, 'wowhead', 'codex', 'lists', 'npc.json'));

test('#246: no NPC or object goal is on a neighbouring zone\'s map where the two maps overlap', { skip: skip || (!wowheadLists && 'no Wowhead Forever list cache (data/sources/wowhead/codex/lists)') }, () => {
	const wh = loadWowhead(SOURCES).listed;
	data = data || loadData(DATA);
	const area = (map) => data.zone(map) && data.zone(map).areaId;
	const world = (map, x, y, f) => {
		const fr = (f === 'e' ? data.mapFrames.era : data.mapFrames.forever || {})[map] || data.eraFrame(map);
		return fr && { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * y) / 100, wy: fr.left + ((fr.right - fr.left) * x) / 100 };
	};
	const listedIn = (kind, id) => (wh[kind] && wh[kind][id] && wh[kind][id].location) || [];
	const offenders = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.map == null || goal.x == null) continue;
			let sources = ['npc', 'object'].filter((k) => typeof goal[k] === 'number').map((k) => [k, goal[k]]);
			if (!sources.length && goal.t === 'collect' && goal.item) {
				const drops = (data.item(goal.item) || {}).drops || {};
				sources = ['npc', 'object'].flatMap((k) => Object.keys(drops[k] || {}).map((id) => [k, Number(id)]));
			}
			const zone = area(goal.map);
			if (!sources.length || sources.some(([k, id]) => listedIn(k, id).length === 0 || listedIn(k, id).includes(zone))) continue;
			const points = [goal, ...(goal.spots || [])].map((p) => world(goal.map, p.x, p.y, goal.f)).filter(Boolean);
			const elsewhere = sources.some(([k, id]) => data.spawns(k, id).some((s) => s.map !== goal.map && listedIn(k, id).includes(area(s.map))
				&& s.pts.some((p) => {
					const w = world(s.map, p[0], p[1], s.f);
					return w && points.some((g) => g.c === w.c && Math.hypot(g.wx - w.wx, g.wy - w.wy) <= 60);
				})));
			const key = `${guide} ${goal.t} ${sources.length === 1 ? sources[0].join(' ') : `item ${goal.item}`}`;
			if (elsewhere && !NEIGHBOUR_MAP.has(key)) offenders.push(`${key} (step ${step.title}, map ${goal.map})`);
		}
	}
	assert.deepEqual([...new Set(offenders)], [], 'goals on the map of a zone Wowhead Forever does not place them in');
});

// --- Raider's Bow (Lyngtoft, #289): the Durotar guide sent the arrow 124 yd
// south-west of the bow, to where QuestieDB 1.0.5 had it; 1.0.6 moved it to
// 59.4,56.4, where the player found it. A quest item that lies on the ground
// at a few fixed spots is collected where one of them is: the arrow leads
// within 1 map unit of its object's spawn.
const AWAY_FROM_ITS_OBJECTS = new Set([
	// Fish from pools: the schools drift along the shore, and the step points at a stretch of it.
	'forever/professions/fishing.guide 16968',
	'forever/professions/fishing.guide 16969',
	'forever/professions/fishing.guide 16970',
	// The data has the book at 14.0,24.2 (pfQuest and QuestieDB agree); the guide says the
	// Terrordale inn at 17.4,31.1. Not checked in game yet; left for its own fix.
	'forever/horde/50-60/01-un-goro-crater.guide 15884',
]);
test("#289: a quest item picked up from objects is collected at one of the objects' spawns", { skip }, () => {
	data = data || loadData(DATA);
	const offenders = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.t !== 'collect' || goal.map == null || goal.x == null) continue;
			const item = data.item(goal.item);
			if (!item || !item.questItem || !item.drops) continue;
			const objects = Object.keys(item.drops.object || {});
			if (!objects.length || Object.keys(item.drops.npc || {}).length) continue;
			const pts = objects.flatMap((id) => data.spawns('object', Number(id)).filter((s) => s.map === goal.map).flatMap((s) => s.pts));
			if (!pts.length) continue;
			const near = Math.min(...[goal, ...(goal.spots || [])].flatMap((g) => pts.map((p) => Math.hypot(p[0] - g.x, p[1] - g.y))));
			if (near > 1 && !AWAY_FROM_ITS_OBJECTS.has(`${guide} ${goal.item}`)) offenders.push(`${guide} collect ${goal.item} @${goal.x},${goal.y} (step ${step.title}) is ${near.toFixed(2)} from its objects`);
		}
	}
	assert.deepEqual(offenders, [], 'quest items collected away from the objects that hold them');
});
