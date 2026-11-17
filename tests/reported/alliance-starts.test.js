'use strict';
// Player-reported guide fixes: the Alliance start zones (Elwynn Forest, Dun Morogh, Teldrassil, the Alliance Zephras Isle).
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	at, buildSimPack, compiled, compileSources, darkshoreBoth, DATA, DUN_MOROGHS, DWARF_DUN_MOROGH, ELWYNN, everyone,
	forClass, goals, is, loadCorrections, loadData, located, NE_DARKSHORE, nightElf, OFFICIAL_DIR, PLACES, playGuide,
	questGoalStatus, refData, ROOT, SIMULATE, skip, stepTips, stepView, TELDRASSIL, yards, ZEPHRAS_ALLIANCE,
} = require('./helpers');

const { tokeniseGuides } = require('../../tools/lib/dsl/tokens');

// --- Kharanos to Brewnall (thmastin, recorded runs): no NPC is walked away from and back to.

const LETTERS = [3106, 3112, 3107, 3108, 3109, 3113, 3110, 98574, 98581, 3114, 3115];

// Found in the translation review: the Skyborne Alliance start's notes for a warlock name Briarthorn, Ironforge's
// warlock trainer (NPC 5172). The name alone took the token of the herb Briarthorn (item 2450), so a German client
// read "Wilddornrose in Eisenschmiede"; the notes carry the trainer's own token.
test("Zephras Isle (Alliance): the warlock's training notes name the trainer Briarthorn, not the herb", { skip }, () => {
	const guide = compiled('forever/alliance/skyborne/01-zephras-isle.guide');
	const notes = tokeniseGuides([guide], refData())
		.guides[0].steps.flatMap((step) => step.goals)
		.map((goal) => goal.note || '')
		.filter((note) => note.includes('has no warlock trainer'));
	assert.equal(notes.length, 2, 'both villages\' notes');
	for (const note of notes) assert.match(note, /^\{npc:5172\} in \{zone:1455\}; /, note);
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

// --- Timed-quest sweep (2026-11-08): Iverron's Antidote (3522) lasts five minutes. It was taken from Dirania at the foot of
// Aldrassil before Tenaron's turn-in at the top, the moonwell and the climb back to Tenaron; players' recordings show 2 timer
// fails and 4 abandons among 24 characters. It is taken on the way down after Crown of the Earth (921), in the hand-in's step.
test(`${TELDRASSIL}: Iverron's Antidote is taken after the last Tenaron visit and carried straight to Iverron`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, 'accept 3522 (Iverron\'s Antidote)', is('accept', 3522));
	const hand = at(list, 'turnin 3522', is('turnin', 3522));
	assert.ok(at(list, 'turnin 921 (Crown of the Earth)', is('turnin', 921)) < take, 'the antidote is taken after the last climb to Tenaron');
	assert.equal(list[take].s, list[hand].s, 'taken in the step that hands it in');
	assert.deepEqual(list.slice(take + 1, hand).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'nothing between the accept and the hand-in');
	// Final route review 0.3.6: the moonwell step before Tenaron no longer meets Iverron, and its title says so.
	const phial = fs.readFileSync(path.join(OFFICIAL_DIR, TELDRASSIL), 'utf8').split(/\n(?=step )/).find((s) => /use 5185 /.test(s));
	assert.ok(!/^step .*Iverron/.test(phial), `the moonwell step's title doesn't name Iverron (${phial.split('\n')[0]})`);
});

test(`${TELDRASSIL}: Pynte's report (#647): Teldrassil is taken from the Oracle Tree Bark on The Oracle Tree's turn-in and handed to Fandral with Crown of the Earth`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const bark = at(list, 'turnin 98398 (The Oracle Tree)', is('turnin', 98398));
	const take = at(list, 'accept 940 (Teldrassil)', is('accept', 940));
	assert.equal(take, bark + 1, 'taken straight after The Oracle Tree is handed in');
	assert.ok(everyone(list[take]), 'for every class');
	assert.ok(yards(list[take].goal, list[bark].goal) < 5, 'at the same Oracle Tree Bark, not back at Arynia');
	const fandral = at(list, 'turnin 935 (Crown of the Earth)', is('turnin', 935));
	const hand = at(list, 'turnin 940 (Teldrassil)', is('turnin', 940));
	assert.equal(list[hand].step, list[fandral].step, 'handed in on the Darnassus visit that already goes to Fandral');
	assert.ok(yards(list[hand].goal, list[fandral].goal) < 5, 'to Fandral himself');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: Supplies to Tannok is taken from Hands Springsprocket at the tunnel, leaving Coldridge Valley`, { skip }, () => {
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

// --- Coldridge Valley (thmastin, PR #16): the valley is never walked back to.

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Grik'nir comes after Anvilmar, and the journal and Nori's mug are handed in on one camp visit`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const griknir = at(list, "Grelin Whitebeard's Journal (Grik'nir)", (g) => g.t === 'collect' && g.item === 2004);
	assert.ok(at(list, 'turnin 3364 (Scalding Mornbrew Delivery, Anvilmar)', is('turnin', 3364)) < griknir, 'Anvilmar comes before Grik\'nir');
	const journal = at(list, 'turnin 218 (The Stolen Journal)', is('turnin', 218));
	const mug = at(list, 'turnin 3365 (Bring Back the Mug)', is('turnin', 3365));
	assert.ok(griknir < journal && griknir < mug, 'both are handed in after Grik\'nir');
	assert.equal(list[journal].step, list[mug].step, 'the journal and the mug are handed in on one visit to Grelin\'s camp');
	// Grund and Gozwin is done in the valley, not on a return after Rumbleshot. Since the level tidy (0.4.0) it
	// comes after the troll cave (its Snow Leopard Prowler is level 6), from Anvilmar on the way to the tunnel.
	assert.ok(at(list, 'turnin 97277 (Grund and Gozwin)', is('turnin', 97277)) < at(list, 'turnin 282 (Thalos)', is('turnin', 282)), 'Grund and Gozwin is handed in before the tunnel out of the valley');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: The Adventurer is taken from Thalos at the tunnel and turned in at Eric before The Great Outdoors`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const take = at(list, 'accept 96628 (The Adventurer)', is('accept', 96628));
	const thalos = at(list, 'turnin 282 (Senir\'s Observations, Thalos)', is('turnin', 282));
	assert.equal(list[take].step, list[thalos].step, 'taken at the tunnel, on the way out of the valley');
	const give = at(list, 'turnin 96628 (The Adventurer)', is('turnin', 96628));
	assert.equal(list[give].goal.npcName, 'Eric Brighthammer', 'turned in at Eric');
	assert.ok(give < at(list, 'accept 96608 (The Great Outdoors)', is('accept', 96608)), 'before The Great Outdoors, which it leads to');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Sten's quests and the class letter are taken before Balir, then Anvilmar is entered once`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const balir = at(list, 'accept 170 (A New Threat, Balir)', is('accept', 170));
	assert.ok(at(list, 'accept 233 (Coldridge Valley Mail Delivery, Sten)', is('accept', 233)) < balir, 'the mail delivery before Balir');
	// The race's own letters (Forever's race mask: Dwarf 4, Gnome 64).
	refData();
	const mask = DUN_MOROGH === DWARF_DUN_MOROGH ? 4 : 64;
	for (const q of LETTERS.filter((q) => refData().quests[q].races & mask)) {
		const take = at(list, `accept ${q} (class letter)`, is('accept', q));
		const give = at(list, `turnin ${q} (class letter)`, is('turnin', q));
		assert.ok(take < balir && balir < give, `letter ${q}: taken from Sten before Balir, handed in inside after him`);
		assert.equal(list[take].step, list[balir].step, `letter ${q} on the same visit`);
	}
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Bring Back the Mug is taken from Durnan with the Mornbrew, before Felix`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const mornbrew = at(list, 'turnin 3364 (Scalding Mornbrew Delivery)', is('turnin', 3364));
	assert.equal(at(list, 'accept 3365 (Bring Back the Mug)', is('accept', 3365)), mornbrew + 1, 'Durnan\'s follow-up right after the Mornbrew');
	assert.ok(mornbrew < at(list, 'turnin 3361 (A Refugee\'s Quandary, Felix)', is('turnin', 3361)), 'Felix after Durnan, at the door');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Kharanos is done outside first (Eric before Tharek), then the distillery, training last`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const eric = at(list, 'turnin 96628 (The Adventurer, Eric)', is('turnin', 96628));
	const tharek = at(list, 'accept 400 (Tools for Steelgrill, Tharek)', is('accept', 400));
	const tannok = at(list, 'turnin 2160 (Supplies to Tannok)', is('turnin', 2160));
	assert.ok(eric < tharek && tharek < tannok, 'Eric\'s campfire, then Tharek\'s forge, then inside');
	const inside = list.filter(({ step }) => step === list[tannok].step);
	assert.equal(inside[inside.length - 1].goal.t, 'train', 'class training is the last goal of the distillery visit');
	// The bind is made on a Kharanos visit (the first or the return), for the arrow's hearth back to it.
	const bind = at(list, 'sethome (the Thunderbrew Distillery)', (g) => g.t === 'sethome');
	assert.ok(located(list[bind]), 'the bind leads to the innkeeper');
	assert.ok(tannok < bind, 'bound in Kharanos');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Camping 101: Cooking waits for the return to Kharanos, the lesson before the turn-in`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const lesson = at(list, 'train Cooking', (g) => g.t === 'train' && g.skillLine === 185);
	const camping = at(list, 'turnin 96629 (Camping 101: Cooking)', is('turnin', 96629));
	assert.ok(lesson < camping, 'Gremlock teaches Cooking before taking the quest');
	assert.ok(at(list, 'Crag Boar Rib', (g) => g.t === 'collect' && g.item === 2886) < lesson, 'on the return with the ribs, not on arrival');
	assert.equal(list[camping].step, list[at(list, 'turnin 384 (Beer Basted Boar Ribs)', is('turnin', 384))].step, 'on the same visit as the ribs');
});

// --- Flow audit (2026-11-07): Dun Morogh's quarry was stopped at up to six
// times (each of Those Blasted Troggs!, the powder keg, the powder, the smith's
// hides and The Public Servant handed in on a stop of its own), with the
// Bonesnappers listed along the way though they share the quarry with the
// Skullthumpers; Kharanos was entered four times in a row for Senir, the malt,
// Tognus, the malt again and the cooking lesson; Razzle's cogs were listed along
// the whole walk west and twice more. Now the quarry troggs are one step,
// Foreman Stonebrow, Senator Mehr and Thesten take their quests on the first
// return before Helm's Bed Lake, Kharanos is one stop with one malt, and the
// cogs are collected with the Leper Gnomes.
for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: flow audit: the quarry troggs in one step and handed in on the first return, Kharanos once, no along lists for the cogs or the Bonesnappers`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const skull = at(list, 'kill 1115 (Skullthumpers)', (g) => g.t === 'kill' && g.quest === 432);
	const bone = at(list, 'kill 1117 (Bonesnappers)', (g) => g.t === 'kill' && g.quest === 433);
	assert.equal(list[bone].step, list[skull].step, 'the Bonesnappers with the Skullthumpers');
	const t432 = at(list, 'turnin 432', is('turnin', 432));
	assert.equal(list[at(list, 'turnin 433', is('turnin', 433))].step, list[t432].step, 'Stonebrow and Mehr on one stop');
	assert.ok(t432 < at(list, 'the Stolen Blasting Powder', (g) => g.t === 'collect' && g.item === 267415), 'before the powder');
	assert.ok(t432 < at(list, 'kill 6123 (Dark Iron Spies)', (g) => g.t === 'kill' && g.quest === 96390), 'before the spies');
	assert.equal(list.filter(({ goal }) => goal.t === 'buy' && goal.item === 2894).length, 1, 'one Rhapsody Malt');
	const senir = at(list, 'turnin 98323', is('turnin', 98323));
	assert.equal(list[senir].step, list[at(list, 'accept 287', is('accept', 287))].step, 'Senir once: Secure the Mountain in, Frostmane Hold out');
	const { steps } = compiled(DUN_MOROGH);
	assert.deepEqual(steps.filter((st) => st.along && st.goals.some((g) => [412, 433].includes(g.quest))).map((st) => st.title), [], 'no along list for the cogs or the Bonesnappers');
	assert.equal(list.filter(({ goal }) => goal.t === 'collect' && goal.item === 3083).length, 1, 'the cogs listed once');
});

// Desperate Times on the Alliance Zephras guide (0.4.0 audit): Ayessa Dawnsinger, the Horde's leader the quest needs,
// shows hostile to every recorded Alliance Skyborne (10 people) and still talks to them (25 of 25 completions talked
// to both leaders). The step says so, as the Horde guide's step does for Elaadrin.
test('Zephras Isle (Alliance): Desperate Times says Ayessa shows red but talks to you, and the quest needs both leaders', { skip }, () => {
	const tips = stepTips('forever/alliance/skyborne/01-zephras-isle.guide', /^\s+talk 251968 quest 92640\.2\b/).join(' ');
	assert.match(tips, /Ayessa's name shows red to you, but she talks to you all the same, and the quest needs both/);
});

// Dwarf Hunters (0.4.0 audit): Taming the Beast (6064) is taken on the walk back to Grif Wildheart after Misty Pine,
// where the Hunter is past level 10, not at the Kharanos east stop, where the guide made them wait for level 10.
test(`${DWARF_DUN_MOROGH}: a Hunter takes Taming the Beast on the return to Kharanos, with no wait for level 10 on the way east`, { skip }, () => {
	const list = goals(DWARF_DUN_MOROGH);
	const take = at(list, 'accept 6064', is('accept', 6064));
	assert.equal(list[take].s, list[at(list, 'kill 1126 (tame)', (g) => g.t === 'kill' && g.quest === 6064)].s, 'taken on the Taming the Beast step');
	assert.ok(take > at(list, 'turnin 99161 (Father Gavin)', is('turnin', 99161)), 'after Misty Pine Refuge');
	const kharanos = list[at(list, 'turnin 412 (Razzle)', is('turnin', 412))].step;
	assert.ok(!kharanos.goals.some((g) => g.t === 'level' && /HUNTER|Hunter/.test(JSON.stringify(g.only || {}))), 'no level gate for Hunters on the Kharanos east stop');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: The Reports is taken from Senir with Frostmane Hold and handed to the senator on the way to the tram`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const accept = at(list, 'accept 291 (The Reports)', is('accept', 291));
	assert.equal(accept, at(list, 'turnin 287 (Frostmane Hold)', is('turnin', 287)) + 1, 'taken right after Frostmane Hold is handed in');
	const turnin = at(list, 'turnin 291 (Senator Barin Redstone)', is('turnin', 291));
	assert.ok(turnin > accept, 'handed in later');
	// Final route review (2026-11-08): Ironforge is one round of the city, so the senator is a stop of that round,
	// in Ironforge before the tram, not a step of its own after it.
	const tram = at(list, 'goto Deeprun Tram', (g) => g.t === 'goto' && g.text === 'Deeprun Tram');
	assert.ok(turnin < tram, 'handed in before the tram');
	assert.equal(list[turnin].goal.map, 1455, 'in Ironforge');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: kills on the way are counted on the way and finished after`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	for (const [quest, npc, along, name] of [
		// A Favor for Evershine's bears were also counted on the walk to Frostmane Hold; since the level tidy (0.4.0)
		// the Hold comes after Brewnall's second visit, and the bears are a step of their own on the first.
		[99160, 276003, (g) => g.t === 'collect' && g.quest === 99162, "Rime's Wrath's elementals, with Treacherous Cold's rifles"],
	]) {
		const kills = list.filter(({ goal }) => (goal.t === 'kill' || goal.t === 'collect') && goal.quest === quest && goal.npc === npc);
		const early = kills.find(({ goal }) => goal.optional);
		assert.ok(early, `${name}: an optional kill goal`);
		// Counted on the way: in that step, or in an `along` list open through it (from before it to its label after it).
		const there = at(list, name, along);
		const until = early.step.along && list.findIndex(({ step }) => step.label === early.step.along);
		assert.ok(early.step === list[there].step || (early.step.along && list.indexOf(early) < there && until > there), `${name}: in that step, or listed along the way through it`);
		const later = kills.find(({ goal }) => !goal.optional);
		assert.ok(later && later.step !== early.step && !later.step.along && list.indexOf(later) > list.indexOf(early), `${name}: a required kill goal in a later step finishes it`);
	}
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Ammo for Rumbleshot is taken beside Beldin and handed in before the walk back to Kharanos`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	assert.equal(at(list, 'accept 5541 (Loslor Rudge)', is('accept', 5541)), at(list, 'turnin 400 (Beldin)', is('turnin', 400)) + 1, 'Loslor right after Beldin');
	assert.ok(at(list, 'turnin 5541 (Hegnar Rumbleshot)', is('turnin', 5541)) < at(list, 'turnin 98321 (Tognus Flintfire)', is('turnin', 98321)), 'Hegnar before the walk back to Kharanos');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Gretchen comes first and the Grizzled Den is walked once for the shipments and Cornelius`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const shipments = at(list, "Flintfire's Shipment", (g) => g.t === 'collect' && g.item === 280413);
	assert.ok(at(list, 'accept 98319 (Secure the Mountain, Gretchen)', is('accept', 98319)) < shipments, 'Gretchen before the den');
	assert.equal(list[at(list, 'complete 98319 (Cornelius)', is('complete', 98319))].step, list[shipments].step, 'Cornelius on the same trip');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: at Brewnall Gretta's dock comes first, and the village before Frostmane Hold`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const rejold = at(list, 'turnin 318 (Evershine, Rejold)', is('turnin', 318));
	const village = list.filter(({ step }) => step === list[rejold].step);
	assert.deepEqual([village[0].goal.t, village[0].goal.quest], ['accept', 98326], 'Gretta\'s Frosthowl first');
	assert.ok(at(list, 'accept 319 (A Favor for Evershine)', is('accept', 319)) < at(list, 'Frostmane Headhunter', (g) => g.t === 'kill' && g.target === 'Frostmane Headhunter'), 'Evershine\'s animals are in the log on the way to the Hold');
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
for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Beer Basted Boar Ribs is offered without Cooking, on arrival in Kharanos`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const ribs = list.filter(({ goal }) => goal.quest === 384);
	assert.deepEqual(ribs.map(({ goal }) => [goal.t, goal.profLine]), [
		['accept', undefined],
		['collect', undefined],
		['turnin', undefined],
	]);
	const take = at(list, 'accept 384', is('accept', 384));
	assert.ok(take < at(list, 'turnin 96629 (Camping 101: Cooking)', is('turnin', 96629)), '384 is taken before the cooking lesson');
	// A Dwarf Paladin; Gnomes have no Paladins, so a Gnome Warrior.
	const who = DUN_MOROGH === DWARF_DUN_MOROGH
		? { race: 'Dwarf', raceName: 'Dwarf', faction: 'Alliance', cls: 'PALADIN', className: 'Paladin', level: 6 }
		: { race: 'Gnome', raceName: 'Gnome', faction: 'Alliance', cls: 'WARRIOR', className: 'Warrior', level: 6 };
	const status = questGoalStatus(DUN_MOROGH, 384, who);
	assert.equal(status.length, 3);
	assert.ok(status.every((s) => !s.endsWith(' na')), `a ${who.race} without Cooking sees 384: ${status.join(', ')}`);
});

// Onrevax (#820) and bob (#823): the Applejack Still (91736) never enters the
// quest log: clicking it with four Shiny Red Apples hands it in on the spot
// and gives the Thunder Applejack, which Sergeant De Vries needs for An Apple
// Treat. The still comes once, after Homer Stonefield sells the apples, and no
// step waits on `when onquest 91736`, which never holds. GrosGorey (#2312)
// saw While Here offer An Apple Treat before collecting the Applejack: neither
// quest has an accept window, so both must be direct hand-ins. twisted (#2561,
// 0.4.0) stood beside De Vries on a hand-in he never offered: the Applejack
// was not in the bags (players' recordings: the still skipped, the Applejack
// drunk, the guide placed past the still). The hand-in is a step of its own,
// shown only while the Applejack is in the bags, and the still's step only
// with four apples and An Apple Treat still to do.
test(`${ELWYNN}: Applejack reports (#820, #823, #2312, #2561): direct hand-ins after the Stonefield apples, with no early accept`, { skip }, () => {
	const { steps } = compiled(ELWYNN);
	const has = (st, pred) => st.goals.some(pred);
	const still = steps.map((st, i) => [st, i]).filter(([st]) => has(st, (g) => g.quest === 91736));
	assert.equal(still.length, 1, 'one step for the still');
	const [step, at] = still[0];
	assert.ok(has(step, is('turnin', 91736)) && has(step, (g) => g.t === 'collect' && g.item === 247824), 'the still hands in and gives the Applejack in that step');
	for (const quest of [91736, 91738]) {
		const mine = steps.flatMap((st) => st.goals).filter((g) => g.quest === quest);
		assert.equal(mine.length, 1, `${quest}: one hand-in, with no accept or tracked objective`);
		assert.ok(mine[0].t === 'turnin' && mine[0].direct, `${quest}: handed in without entering the quest log`);
		for (const st of steps) assert.ok(!(st.when || []).some((p) => ['onquest', 'complete'].includes(p.k) && [].concat(p.q).includes(quest)), `${quest}: no condition waits on the quest log`);
	}
	const apples = steps.findIndex((st) => has(st, (g) => g.t === 'buy' && g.item === 4536));
	const deVries = steps.findIndex((st) => has(st, is('turnin', 91738)));
	assert.ok(steps.findIndex((st) => has(st, is('turnin', 87))) <= apples && apples < at && at < deVries, 'Stonefield apples, the still, then De Vries');
	const gate = (st) => st.when || [];
	const holds = (st, item, n) => gate(st).some((p) => p.k === 'has' && !p.neg && p.item === item && (p.n || 1) === n);
	assert.ok(holds(step, 4536, 4), 'the still shows only with four Shiny Red Apples in the bags');
	assert.ok(gate(step).some((p) => p.k === 'turnedin' && p.neg && [].concat(p.q).includes(91738)), 'and only while An Apple Treat is still to do');
	const dv = steps[deVries];
	assert.ok(holds(dv, 247824, 1), "De Vries' step shows only with the Thunder Applejack in the bags");
	assert.deepEqual(dv.goals.map((g) => `${g.t} ${g.quest}`), ['turnin 91738'], "the hand-in is De Vries' step alone");
	const rainer = steps.findIndex((st) => has(st, is('turnin', 239)));
	assert.ok(rainer >= 0 && rainer < deVries && !gate(steps[rainer]).some((p) => p.k === 'has'), "Deputy Rainer's quests hold the route whatever the bags hold");
	for (const pred of [is('accept', 109), is('accept', 11)]) assert.ok(has(steps[rainer], pred), "Rainer's accepts stay on his step");
});

// Hand-in sweep (2026-11-16, after Kerlonian's escort): Shhh! We're Hunting Kobolds (91772) had its six Kobold Tracks
// only in the accept's note, so after Tordrin the window went on to Marshal Dughan's hand-in. The tracks are a goal of
// the accept's step, on the road to Goldshire.
test(`${ELWYNN}: Shhh! We're Hunting Kobolds counts the Kobold Tracks before the hand-in to Marshal Dughan`, { skip }, () => {
	const list = goals(ELWYNN);
	const accept = at(list, 'accept 91772', is('accept', 91772));
	const tracks = at(list, 'interact 563442 (91772.1)', (g) => g.t === 'interact' && g.quest === 91772 && g.object === 563442);
	assert.equal(list[tracks].s, list[accept].s, "in the accept's step");
	assert.ok(accept < tracks && tracks < at(list, 'turnin 91772', is('turnin', 91772)), 'accept, the tracks, then the hand-in');
});

// Croaky (level 11 elite) killed players 4 times at levels 8-9 on the Downstream
// step (players' recordings; 12 deaths in the archive by #977). His head stays an
// optional extra (#221), collected only in the steps for players who group for it
// (#979); the river step everyone plays still says he is an elite and to leave him
// without a group (an elite is a group choice at any level: 0.4.0 level tidy).
test(`${ELWYNN}: Croaky's Head is collected only by groups, and the river step warns he is a level 11 elite, for a group only`, { skip }, () => {
	const steps = compiled(ELWYNN).steps;
	const heads = steps.filter((st) => st.goals.some((g) => g.t === 'collect' && g.item === 247826));
	assert.ok(heads.length > 0, 'the head is still an optional goal');
	for (const st of heads) assert.ok((st.when || []).some((p) => p.k === 'group'), `"${st.title}" collects the head without asking for a group`);
	const river = steps.find((st) => !(st.when || []).length && st.goals.some(is('collect', 91733)));
	assert.ok(river, "the river step of Ormin Pelford's Waterlogged tools");
	const tip = [].concat(river.note || []).join(' ');
	assert.match(tip, /level 11 elite/, tip);
	assert.match(tip, /Only go for his head with a group;/, tip);
	assert.doesNotMatch(tip, /once you're level 10/, tip);
});

// Swelling Forces (98013, level 20 naga) needs Return to Onu (950), which only
// the shared Darkshore hands in: the Night Elf start's own Darkshore left it
// unoffered at about 13 and walked to the naga for it.
test('Night Elf Darkshore: Swelling Forces waits for the shared Darkshore visit, after Return to Onu', { skip }, () => {
	assert.ok(!goals('forever/alliance/nightelf/02-darkshore.guide').some(({ goal }) => goal.quest === 98013), 'not in the Night Elf start\'s own Darkshore');
	const list = darkshoreBoth();
	assert.ok(at(list, 'turnin 950', is('turnin', 950)) < at(list, 'accept 98013', is('accept', 98013)), 'the shared Darkshore takes it after Return to Onu');
});

test(`${TELDRASSIL}: Pynte's report: Zenn's Bidding is taken on the walk down to Dolanaar that passes Zenn (#89)`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, "accept 488 (Zenn's Bidding)", is('accept', 488));
	assert.ok(at(list, 'accept 2159 (Porthannius, leaving Shadowglen)', is('accept', 2159)) < take, 'after Porthannius');
	assert.ok(take < at(list, 'turnin 96630 (Lyreena Duskblade in Dolanaar)', is('turnin', 96630)), 'before the first Dolanaar stop');
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
		for (const sp of refData().spawns('object', object).filter((x) => x.map === 1438)) {
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

// Escaping Ban'ethil is an escort: taken first, Lynessa sets off before the
// den is done. It is taken once the relics and The Sleeping Druid's chain are.
test(`${TELDRASSIL}: Pynte's report: Escaping Ban'ethil is taken after the relics and The Sleeping Druid's chain (#334)`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const escort = at(list, "accept 99053 (Escaping Ban'ethil)", is('accept', 99053));
	assert.ok(at(list, 'accept 2541 (The Sleeping Druid)', is('accept', 2541)) < escort, 'The Sleeping Druid is taken first');
	assert.ok(at(list, 'turnin 2561 (Druid of the Claw)', is('turnin', 2561)) < escort, 'the chain is handed in before the escort');
	for (const item of [3405, 3406, 3407, 3408]) assert.ok(at(list, `relic ${item}`, (g) => g.t === 'collect' && g.item === item) < escort, `relic ${item} before the escort`);
	assert.ok(escort < at(list, 'complete 99053', is('complete', 99053)), 'taken before the walk out');
});

// Visur's report (#848): Valanaar turn-ins sent the player to Dondallion Whisperwind for The
// Missing Scholar (92850), but only Fillion Flamebreeze (253285), who stands beside him, takes it.
// A correction had added Dondallion as a second ender; with the corrections applied, as
// `data build` does, the hand-in leads to Fillion.
test(`${ZEPHRAS_ALLIANCE}: Visur's report (#848): The Missing Scholar is handed in to Fillion Flamebreeze, not Dondallion Whisperwind`, { skip }, () => {
	const corrected = loadData(DATA);
	const fix = loadCorrections().quests['92850'];
	if (fix) Object.assign(corrected.quest(92850), fix.set);
	assert.deepEqual(corrected.quest(92850).end.npc, [253285], 'Fillion Flamebreeze is the only ender');
	const file = path.join(OFFICIAL_DIR, ZEPHRAS_ALLIANCE);
	const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], corrected);
	const turnin = guides[0].steps.flatMap((step) => step.goals).find(is('turnin', 92850));
	assert.ok(turnin, 'The Missing Scholar is handed in');
	assert.equal(turnin.npc, 253285, 'handed in to Fillion Flamebreeze');
});

// --- Steps the arrow cannot lead (rikette, #140): an objective step written
// only as bare `complete` lines has no place, so the arrow points nowhere.
// The objectives go on kill, collect and interact goals (or a placed
// `complete` for a place to reach), which the data locates.

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: rikette's report: the Grizzled Den leads the arrow to the wendigo cave`, { skip }, () => {
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

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: Rumbleshot's Ammo leads to the Ammo Crate by Mountaineer Gretchen, not to Hegnar`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const ammo = list.find(({ goal: g }) => g.t === 'collect' && g.quest === 5541);
	assert.ok(ammo && located(ammo), 'the ammo has a place');
	assert.ok(yards(ammo.goal, { map: ammo.goal.map, x: 44.13, y: 56.95 }) < 30, `the ammo is at the crate (${ammo.goal.x},${ammo.goal.y})`);
});

// An Enticing Offer: the quest log lists the blood before the petals, so each
// collect counts its own objective (Bashidian Twotao, #279).
test(`${ELWYNN}: Bashidian Twotao's report (#279): the bait ingredients count their own objectives`, { skip }, () => {
	const oi = (item) => goals(ELWYNN).find(({ goal }) => goal.t === 'collect' && goal.quest === 99130 && goal.item === item).goal.oi;
	assert.equal(oi(286215), 1, 'Vial of Animal Blood is objective 1');
	assert.equal(oi(286214), 2, 'Duskweed Petal is objective 2');
});

// --- Northshire Abbey (Zepheriel, #310): Skirmish at Echo Ridge is taken from
// Marshal McBride when Investigate Echo Ridge is handed in to him, not after
// Brother Paxton in the library and a walk back.
test(`${ELWYNN}: Zepheriel's report (#310): Skirmish at Echo Ridge is taken from McBride before Brother Paxton, with nobody between`, { skip }, () => {
	const list = goals(ELWYNN);
	const handed = at(list, 'turnin 15 (Investigate Echo Ridge)', is('turnin', 15));
	const take = at(list, 'accept 21 (Skirmish at Echo Ridge)', is('accept', 21));
	assert.ok(handed < take, 'Investigate Echo Ridge is handed in first');
	assert.equal(list[take].goal.npc, list[handed].goal.npc, 'both at Marshal McBride');
	assert.deepEqual(list.slice(handed + 1, take).filter(located).map(({ goal }) => `${goal.t} ${goal.quest} at ${goal.npcName || goal.npc}`), [], 'nobody else between them');
	assert.ok(take < at(list, 'turnin 91743 (Rascally Rodents)', is('turnin', 91743)), 'Skirmish at Echo Ridge is taken before Brother Paxton');
});

// --- Croaky's Head (Syfin, #221): Croaky, a named elite, roams the murloc
// shore south of the Eastvale bridge, along the river where the first east
// loop searches for Ormin Pelford's Waterlogged tools. Its head starts Croaky's
// Head for Merell Ross at Ridgepoint Tower, a short way east. The loot is an
// optional goal of a step of its own for players who group for it (#979: in the
// river step for everyone it cost 12 recorded deaths at 8-9); the accept
// (optional) and the Ridgepoint Tower turn-in are steps of their own for a
// player who answers the group question with "do" (as one who loots the head
// does when the route asks), and the turn-in holds only a player who took the
// quest (an optional accept vouches for nobody who did not).

test(`${ELWYNN}: Syfin's report (#221): Croaky's Head is an optional extra; Ridgepoint Tower holds and leads the arrow only with the head`, { skip }, () => {
	const pack = buildSimPack([ELWYNN]);
	try {
		const g = pack.guides[0];
		refData();
		const [x, y] = refData().npcs[248277].spawns[1429].pts[0];
		// Recorded from the simulated player's own actions, once the engine has
		// settled: the first Waterlogged tool (the river step is live; with the
		// head, it is looted and right-clicked there), and any hand-in of
		// Croaky's Head (the step it is handed in from, and where the arrow
		// leads). The game takes no turn-in for a quest the player does not hold.
		const watch = (head) => `
			local E, w = Polestar.Engine, stub.world
			local murlocs, ridge = false, false
			local progress, turnIn = w.progress, w.turnIn
			w.progress = function(q, ...)
				if q == 91733 and not murlocs then
					murlocs = {}
					if ${head} then
						w.addItem(247826, 1)
						w.accept(91740, {}, "Croaky's Head")
						stub.advance(0.6)
					end
					for _, v in ipairs(E.GetStepView(E.GetStepIndex()).goals) do
						if v.quest == 91740 or v.item == 247826 then murlocs[#murlocs + 1] = v.t .. " " .. tostring(v.optional) end
					end
					for i, s in ipairs(SIM_GUIDE.steps) do
						for _, v in ipairs(s.goals) do
							if v.t == "accept" and v.quest == 91740 then murlocs[#murlocs + 1] = "accept " .. tostring(v.optional) end
						end
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
		// Without the head, skipping the group quest; with it, as one who does it. (#1415: a player who answers "Do it
		// with a group" is led to Croaky, whose head the step now waits for, so "do" without the head is no longer a path.)
		for (const [head, groups] of [[false, 'skip'], [true, 'do']]) {
			const [out, got] = playGuide(pack, g, { race: 'Human', faction: 'Alliance', cls: 'WARRIOR', groups, script: watch(head) });
			const who = `${head ? 'with the head' : 'without the head'}, answering ${groups}`;
			assert.equal(out.stuck, undefined, `${who}: not stuck: ${JSON.stringify(out.stuck)}`);
			assert.ok(out.done, `${who}: plays to the end`);
			assert.deepEqual(got.murlocs, ['accept true'], `${who}: the head is no goal of the river step (groups only, #979), its accept optional`);
			assert.equal(got.done, head, `${who}: Croaky's Head ${head ? 'is' : 'is not'} handed in`);
			if (head) {
				assert.equal(got.ridge && got.ridge.title, 'Ridgepoint Tower', 'with the head: handed in at the Ridgepoint Tower step');
				assert.equal(got.ridge.status, 'active', 'the turn-in holds the step');
				assert.ok(got.ridge.wp && yards(got.ridge.wp, { map: 1429, x, y }) <= 5, `the arrow leads to Merell Ross at Ridgepoint Tower: ${JSON.stringify(got.ridge.wp)}`);
				assert.equal(got.later, 'done');
			} else {
				assert.equal(got.ridge, false, `${who}: Ridgepoint Tower is passed, nothing is handed in there`);
				assert.ok(['na', 'skipped'].includes(got.later), `${who}: the turn-in is not this player's: ${got.later}`);
			}
		}
	} finally {
		pack.dispose();
	}
});

// --- Elwynn (zeike, #553): the Gold Pickup Schedule that starts The Collector
// (123) drops from Gruff Swiftbite, a rare (86%; the Runts and Outrunners of
// Riverpaw Gnoll Bounty 3%), at Forest's Edge, the last stop before Westfall.
// The step waits for the armbands, not for him. The Collector's turn-in
// (Marshal Dughan, Goldshire) and Manhunt (147, Morgan the Collector in the
// east) would each be a trip back across Elwynn, so both are left out
// (c17 wrote 123's turn-in into Westfall with no way back).
test(`${ELWYNN}: zeike's report (#553): Forest's Edge does not wait for the rare Gruff Swiftbite; The Collector and Manhunt are left out`, { skip }, () => {
	const list = goals(ELWYNN);
	const s = list[at(list, 'the armbands (782)', (g) => g.t === 'collect' && g.item === 782)].s;
	assert.ok(list.some(({ s: n, goal }) => n === s && goal.t === 'collect' && goal.quest === 11 && !goal.optional), 'the armbands hold the step');
	assert.deepEqual(list.filter(({ goal }) => goal.item === 1307 || goal.item === 2239 || [123, 147].includes(goal.quest)).map(({ goal }) => `${goal.t} ${goal.quest || goal.item}`), [], 'no Schedule, Collector or Manhunt goal');
});

// --- Flight to Auberdine (Pynte, #402, #403): Vesprystus flies you to
// Auberdine for free once you have the quest ("speak with me again when you
// are ready to fly"), so the guide takes his flight, not the boat. Return to
// Nessa (6343) is taken from Laird and handed to Nessa in Rut'theran by every
// class (Druids on their own Rut'theran stop).
test(`${TELDRASSIL}: Pynte's report: Flight to Auberdine is flown with Vesprystus, not the boat, and Return to Nessa is handed in (#402, #403)`, { skip }, () => {
	for (const cls of ['WARRIOR', 'HUNTER', 'ROGUE', 'PRIEST', 'DRUID']) {
		const list = goals(TELDRASSIL).filter(forClass(cls));
		const take = at(list, 'accept 6342 (Flight to Auberdine)', is('accept', 6342));
		const travel = list.slice(take + 1).find(({ goal }) => ['goto', 'fly', 'hearth'].includes(goal.t));
		assert.ok(travel && travel.goal.t === 'fly' && travel.goal.location === 'Auberdine', `${cls}: the travel after accepting 6342 is the flight to Auberdine`);
		const give = at(list, 'turnin 6342 (Flight to Auberdine)', is('turnin', 6342));
		assert.ok(list.indexOf(travel) < give, `${cls}: 6342 is handed in after the flight`);
		assert.ok(!list.slice(take, give).some(({ goal }) => goal.t === 'goto'), `${cls}: no walk to a boat between taking 6342 and handing it in`);
		const back = at(list, 'accept 6343 (Return to Nessa)', is('accept', 6343));
		assert.ok(give < back, `${cls}: Return to Nessa is taken from Laird after 6342`);
		assert.ok(back < at(list, 'turnin 6343 (Return to Nessa)', is('turnin', 6343)), `${cls}: Return to Nessa is handed in`);
	}
});

// Pynte (#327): "Timberling Seeds quest points me to the north of Teldrassil
// instead of just around the quest giver." XrayAlpha's diagnosis: QuestieDB's
// server drop table gives the Elder Timberling (level 10) 100% for the seed and
// the Timberlings round Denalan (level 5) 37%, so only the Elder counted as
// likely and the arrow went 1,400 yards north. A dropper 3 or more levels above
// the quest no longer sets the likely-dropper bar where it would crowd out the
// ones near the quest's level (resolve.js, levelSplit). The Southsea Kidnapper
// stood alone on Pirate Hats Ahoy! with pfQuest's 50% against 10% for the other
// pirates; it does not drop the hat (corrections.json removeDrops). Both tests
// are XrayAlpha's.

test(`${TELDRASSIL}: Pynte's report (#327): the Timberling Seed arrow stays round Denalan with the Timberlings, not with the Elder Timberlings in the north`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const { goal } = list[at(list, 'the Timberling Seed collect', (g) => g.t === 'collect' && g.quest === 918 && g.item === 5168)];
	const ids = (goal.fromNpcs || []).map((n) => n.npc);
	assert.notEqual(goal.from, 'Elder Timberling', 'the goal names the Timberlings, not the Elder');
	assert.ok(ids.includes(2022), `the Timberlings (2022) are among the droppers (${ids.join(', ')})`);
	assert.ok(!ids.includes(2030), 'the Elder Timberling (2030) is not');
	const denalan = { map: 1438, x: 60.9, y: 68.49 };
	assert.ok(yards(goal, denalan) <= 150, `the arrow at ${goal.x},${goal.y} is by Denalan, not ${Math.round(yards(goal, denalan))} yd off`);
});

// --- Teldrassil (#555): Soft Saber Pelts (87288) accepted from Aldia on first Dolanaar
// stop so both Nightsaber quests are done in one east loop
test(`${TELDRASSIL}: #555: Soft Saber Pelts accept comes before Zenn's Bidding turn-in, so both Nightsaber quests share the first east loop`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const accept87288 = list.find(({ goal }) => goal.t === 'accept' && goal.quest === 87288);
	const turnin488 = list.find(({ goal }) => goal.t === 'turnin' && goal.quest === 488);
	assert.ok(accept87288, 'accept 87288 is in the guide');
	assert.ok(accept87288.s < turnin488.s, 'accept 87288 (Soft Saber Pelts) comes before turnin 488 (Zenn\'s Bidding), not after it');
	// Both collect goals are in the same step
	const coll488 = list.find(({ goal }) => goal.t === 'collect' && goal.quest === 488 && goal.item === 3409);
	const coll87288 = list.find(({ goal }) => goal.t === 'collect' && goal.quest === 87288);
	assert.ok(coll87288, 'collect 280087 quest 87288.1 is in the guide');
	assert.equal(coll488.s, coll87288.s, 'Nightsaber Fang (488.1) and Nightsaber Pelt (87288.1) are in the same step');
});

// --- Teldrassil (#619): Ferocitas drops the Gnarlpine Necklace, and Tallonkai's
// Jewel is only in the bags once the necklace is opened.
test(`${TELDRASSIL}: #619: the Gnarlpine Necklace is looted from Ferocitas before the jewel is collected`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const necklace = at(list, 'collect 8049 (Gnarlpine Necklace)', (g) => g.t === 'collect' && g.item === 8049 && !g.quest);
	const jewel = at(list, 'collect 8050 quest 2459 (Tallonkai\'s Jewel)', (g) => g.t === 'collect' && g.item === 8050 && g.quest === 2459);
	assert.ok(necklace < jewel, 'the necklace comes before the jewel');
	assert.equal(list[necklace].s, list[jewel].s, 'on the Ferocitas step');
	assert.ok(located(list[necklace]), 'the arrow leads to Ferocitas for the necklace');
});

// --- Flow audit (2026-11-07): Teldrassil killed Ferocitas' mystics, went on
// to the Oracle Glade, Ursal and Lake Al'Ameth, then walked back east to the
// same camp for Ferocitas' necklace and the jewel, and back to Dolanaar for
// Tallonkai alone. The necklace and the jewel come with the mystics; Tallonkai
// takes the jewel as the walk west to the Oracle Glade passes through
// Dolanaar (#1087). The guide's last step told Night Elves to take the boat to
// Stormwind before their own Darkshore guide: it goes, the boat is that guide's.
test(`${TELDRASSIL}: flow audit: Ferocitas' camp once, Tallonkai's jewel on the way through Dolanaar, no boat before Darkshore`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const mystics = at(list, 'kill 7235 (Gnarlpine Mystics)', (g) => g.t === 'kill' && g.quest === 2459);
	const jewel = at(list, 'collect 8050 (Tallonkai\'s Jewel)', (g) => g.t === 'collect' && g.item === 8050);
	assert.equal(list[jewel].s, list[mystics].s, 'the jewel on the mystics\' step');
	const tallonkai = at(list, 'turnin 2459', is('turnin', 2459));
	assert.ok(jewel < tallonkai, 'the jewel is handed in after the camp');
	assert.ok(tallonkai < at(list, 'accept 937 (The Enchanted Glade)', is('accept', 937)), 'on the way to the Oracle Glade, before Arynia');
	const { steps } = compiled(TELDRASSIL);
	assert.ok(!steps.some((st) => /boat/i.test(st.title || '')), 'no boat step in Teldrassil');
	assert.ok(steps.at(-1).goals.length > 0, 'the last step has something to do');
});

// --- Flow re-order (2026-11-07, #1087): Teldrassil sent players back and
// forth. Aldrassil -> north for The Balance of Nature's kills -> back to
// Ilthalaine -> north again to the cave; Dolanaar -> the Fel Cones east ->
// back to Dolanaar to train -> west; the Oracle Glade's moonwell visited three
// times before the Amethyst Phial was filled; two along lists. Now one trip
// north (kills, venom sacs, Iverron), the cones on the road east to Zenn after
// the west loop, training on the Dolanaar stop, the phial on arrival, a
// Warrior's Nessa Shadowsong on the first walk into Darnassus, and no along
// steps.
test(`${TELDRASSIL}: flow re-order: one trip north from Aldrassil, the cones on the road east, the phial on arrival, no along steps`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const { steps } = compiled(TELDRASSIL);
	assert.deepEqual(steps.filter((st) => st.along).map((st) => st.title), [], 'no along steps');
	const kills = at(list, 'kill 2032 (Mangy Nightsabers)', (g) => g.t === 'kill' && g.quest === 457);
	const sacs = at(list, 'collect 5166 (Webwood Venom Sacs)', (g) => g.t === 'collect' && g.quest === 916);
	assert.equal(list[sacs].s, list[kills].s, 'the north kills and the venom sacs in one step');
	assert.equal(list[at(list, 'turnin 457', is('turnin', 457))].s, list[at(list, 'turnin 916', is('turnin', 916))].s, 'The Balance of Nature handed in with the venom sacs');
	const cones = at(list, 'collect 3418 (Fel Cones)', (g) => g.t === 'collect' && g.quest === 489);
	assert.ok(at(list, 'turnin 483 (The Relics of Wakening)', is('turnin', 483)) < cones, 'the cones after the west loop');
	assert.equal(list[cones].s, list[at(list, 'turnin 489', is('turnin', 489))].s, 'the cones on Zenn\'s step');
	const relics = at(list, 'accept 483', is('accept', 483));
	assert.ok(list.some(({ goal, s }) => s === list[relics].s && goal.t === 'train' && goal.class), 'training on the Dolanaar stop that gives the relics');
	const phial = at(list, 'collect 18151 (Amethyst Phial)', (g) => g.t === 'collect' && g.quest === 7383);
	assert.equal(list[phial].s, list[at(list, 'accept 937', is('accept', 937))].s, 'the phial filled on the first moonwell stop');
	const warrior = list.filter(forClass('WARRIOR'));
	assert.ok(at(warrior, 'accept 6344 (Warrior)', is('accept', 6344)) < at(warrior, 'turnin 1684 (Elanaria)', is('turnin', 1684)), 'a Warrior takes Nessa Shadowsong on the first walk into Darnassus');
});

// Nittepitte (#613): "Since Collecting Kelp starts an RP events, it should be
// suggested to be turned in [...] before turning in Baited for Success."
// Handing in Collecting Kelp (112) starts William Pestle's brewing scene before
// he offers The Escape (114); cmangos classic-db's quest-end script runs it
// for 5 seconds. Helene and Jason stand on the lake shore on the way in, so
// they stay first, and Marshal Dughan's turn-ins, a few yards from William,
// fill the wait.

test(`${ELWYNN}: Nittepitte's report (#613): Marshal Dughan's turn-ins come between Collecting Kelp and The Escape, while William Pestle brews`, { skip }, () => {
	const list = goals(ELWYNN);
	const kelp = at(list, 'turnin 112', is('turnin', 112));
	const escape = at(list, 'accept 114', is('accept', 114));
	const dughan = at(list, 'turnin 39', is('turnin', 39));
	assert.ok(at(list, 'turnin 99131', is('turnin', 99131)) < kelp, 'Baited for Success is handed to Jason on the way in');
	assert.ok(kelp < dughan && dughan < escape, 'Collecting Kelp, then Dughan, then The Escape');
	assert.equal(list[kelp].s, list[escape].s, 'all in the same Goldshire step');
});

// Nittepitte (#612): "it should tell you to pick up Mining Tools while
// discovering the Jasperlode Mine." The step led to the mine's far end first,
// then out to the Kobold Geomancers, and only then back in for the Mining
// Tools, which lie along the tunnel from the entrance. The tools now come
// first, on the walk in; the geomancers on the way out.

test(`${ELWYNN}: Nittepitte's report (#612): the Mining Tools are picked up on the walk into the Jasperlode Mine, before its far end`, { skip }, () => {
	const list = goals(ELWYNN);
	const tools = at(list, 'collect 247816', (g) => g.t === 'collect' && g.item === 247816 && g.quest === 91732);
	const explore = at(list, 'complete 76', is('complete', 76));
	const geomancers = at(list, 'kill 476', is('kill', 91723));
	assert.equal(list[tools].s, list[explore].s, 'one step in the mine');
	assert.ok(tools < explore && explore < geomancers, 'the tools, then the far end, then the geomancers');
	const entrance = list.slice(0, tools).reverse().find(({ goal }) => goal.t === 'goto');
	assert.ok(entrance, 'the step before is the walk to the entrance');
	const spots = list[tools].goal.spots || [list[tools].goal];
	for (const s of spots) {
		assert.ok(yards(entrance.goal, { map: list[tools].goal.map, ...s }) < yards(entrance.goal, list[explore].goal), `the tools at ${s.x},${s.y} lie between the entrance and the far end`);
	}
});

// --- The Quarry's Smith (TP1186, #727): Frast Dokner asks for 12 Copper
// Bars, then 4 Toughened Boar Hides. The merged data kept only the hides,
// so `quest 95217.1` tracked the hides against the Copper Bars line
// (corrections.json 95217 restores both, as `data build` applies it).
for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: TP1186's report (#727): the Toughened Boar Hides read their own line of The Quarry's Smith, not the Copper Bars`, { skip }, () => {
	const corrected = loadData(DATA);
	const fix = loadCorrections().quests['95217'];
	assert.ok(fix, 'the corrections correct 95217');
	Object.assign(corrected.quest(95217), fix.set);
	const file = path.join(OFFICIAL_DIR, DUN_MOROGH);
	const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], corrected);
	const hides = guides[0].steps.flatMap((step) => step.goals).find((g) => g.t === 'collect' && g.item === 267416);
	assert.deepEqual(corrected.quest(95217).objectives.map((o) => o.id), [2840, 267416], 'Copper Bars first, the hides second');
	assert.equal(hides.quest, 95217);
	assert.equal(hides.oi, 2, 'the hides read line 2');
});
// The bones for Washed Ashore are picked on the Long Wash south of Auberdine at
// the end of Teldrassil, and the walk back north passes Gwennyth first: she
// takes them then, not on the next guide's first stop after the Return to
// Nessa flight.
test(`${TELDRASSIL}: flow audit: Washed Ashore is handed to Gwennyth on the walk back from the Long Wash`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const bones = at(list, 'the Sea Creature Bones', (g) => g.t === 'collect' && g.item === 12242);
	const turnin = at(list, 'turnin 3524', is('turnin', 3524));
	assert.ok(bones < turnin, 'the bones, then Gwennyth');
	assert.ok(turnin < at(list, 'accept 954', is('accept', 954)), 'Gwennyth first on the way into Auberdine, before Thundris');
	// Not again in the Night Elf Darkshore, except as its catch-up (#2635) for a Night Elf who skipped Teldrassil.
	const again = goals(NE_DARKSHORE).filter(({ goal }) => is('turnin', 3524)(goal));
	assert.ok(again.every(({ step }) => (step.when || []).some((p) => p.k === 'turnedin' && p.neg && p.q === 3524)), 'not again in the Night Elf Darkshore for a Night Elf who handed it in');
});
test(`${NE_DARKSHORE}: flow audit: Bashal'Aran is finished before the boat, and the sea is crossed once`, { skip }, () => {
	for (const cls of ['WARRIOR', 'HUNTER', 'ROGUE', 'PRIEST', 'DRUID', 'MAGE', 'PALADIN', 'WARLOCK', 'SHAMAN']) {
		const list = goals(NE_DARKSHORE).filter(nightElf).filter(forClass(cls));
		const boats = list.map((e, i) => (e.goal.t === 'goto' && /^Boat to /.test(e.goal.text || '') ? i : -1)).filter((i) => i >= 0);
		assert.equal(boats.length, 1, `a ${cls} takes one boat`);
		const flame = at(list, `the Ancient Flame for a ${cls}`, (g) => g.t === 'interact' && g.quest === 957);
		const asterion = at(list, `turnin 957 for a ${cls}`, is('turnin', 957));
		const terenthis = at(list, `turnin 985 for a ${cls}`, is('turnin', 985));
		assert.ok(at(list, `accept 4728 for a ${cls}`, is('accept', 4728)) < flame, `a ${cls}: the southern beach, then Ameth'Aran's flame`);
		assert.ok(flame < asterion && asterion < terenthis && terenthis < boats[0], `a ${cls}: the flame, Asterion and Auberdine before the boat`);
		assert.ok(list.slice(boats[0] + 1).every(({ goal }) => goal.map == null || goal.map !== list[flame].goal.map), `a ${cls}: nothing in Darkshore after the boat`);
		const bear = at(list, `the Plagued Lands bear for a ${cls}`, (g) => g.t === 'complete' && g.quest === 2118);
		const camp = at(list, `the furbolg camp for a ${cls}`, (g) => g.t === 'complete' && g.quest === 984);
		assert.equal(list[bear].step, list[camp].step, `a ${cls}: the bear is captured on the way to the furbolg camp`);
		assert.ok(camp < at(list, `accept 953 for a ${cls}`, is('accept', 953)), `a ${cls}: before Ameth'Aran`);
	}
});

test("Recordings (#977): Croaky's Head, a level 11 elite's drop, is collected only by players grouping for it, not in Elwynn's step for everyone", { skip }, () => {
	// 12 recorded deaths to Croaky at levels 8-9 with the optional head in the solo step.
	const list = goals('forever/alliance/human/01-elwynn-forest.guide');
	const heads = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 247826);
	assert.ok(heads.length > 0, "the head is still collected by groups");
	for (const { step } of heads) {
		assert.ok([].concat(step.when || []).some((w) => w.k === 'group'), `"${step.title}" collects the head without asking for a group`);
	}
});

test('Recordings (starting-zone review 0.3.6): Crystal Lake\'s murloc step warns that the murlocs pull in groups', { skip }, () => {
	// 30 recorded deaths of 17 people at Elwynn's murloc camp (Slimy Menace 99128, about level 6-7 on the route).
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8'));
	assert.ok(fixes.fixes.some((f) => f.at && f.at.quest === 99128 && /one at a time/.test(f.tip || '')), 'the tip is a guide-fixes record');
	const list = goals('forever/alliance/human/01-elwynn-forest.guide');
	const kills = list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 99128);
	assert.ok(kills.length > 0, 'the murlocs are killed in Elwynn');
	for (const { step } of kills) {
		assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), /one at a time/, `"${step.title}" warns about pulling several murlocs`);
	}
});

// --- Flow audit (2026-11-07, Elwynn Forest): the first Goldshire stop zig-zagged (the inn, Remy, back to the
// inn, then Dughan across the road); Baited for Success was carried past Jason Mathers on the walk east and
// handed in on the walk back, as was the kelp from the murlocs that walk passes; Princess waited for a second
// trip south after the logging camp; and the end went Goldshire -> Westbrook -> back to Goldshire -> the
// gnolls -> Westbrook -> Maybell and the Stonefield Farm -> the still -> Westbrook. Now: Dughan, Remy, then the
// inn; Jason and the kelp on the walk east; Princess with Downstream; and Goldshire -> Maybell -> the
// Stonefield Farm -> the still -> Westbrook -> the gnolls -> Westbrook, as the seed has it.
test(`${ELWYNN}: flow audit: Goldshire in walking order, Jason and the kelp on the walk east, Princess with Downstream, one pass to Westbrook`, { skip }, () => {
	const list = goals(ELWYNN);
	const idx = (what, t, q) => at(list, what, is(t, q));
	const farley = idx('turnin 2158', 'turnin', 2158);
	for (const [t, q] of [['turnin', 54], ['accept', 47]]) {
		const i = idx(`${t} ${q}`, t, q);
		assert.ok(i < farley && list[i].s === list[farley].s, `${t} ${q} before Innkeeper Farley on the first Goldshire stop`);
	}
	const tower = idx('accept 91723', 'accept', 91723);
	assert.ok(idx('turnin 99131', 'turnin', 99131) < tower, 'Baited for Success handed to Jason on the walk east');
	assert.ok(at(list, 'the kelp', (g) => g.t === 'collect' && g.item === 1256) < tower, 'the kelp on the walk east');
	const collar = list[at(list, 'the Brass Collar', (g) => g.t === 'collect' && g.item === 1006)];
	const saw = list[at(list, 'the Waterlogged Saw', (g) => g.t === 'collect' && g.item === 247813)];
	assert.equal(collar.s, saw.s, 'Princess in the Downstream step');
	const westbrook = idx('turnin 239', 'turnin', 239);
	for (const [t, q] of [['turnin', 114], ['turnin', 87], ['turnin', 88], ['accept', 1685]]) assert.ok(idx(`${t} ${q}`, t, q) < westbrook, `${t} ${q} before Westbrook Garrison`);
	assert.deepEqual(list.slice(westbrook).filter(({ step }) => /Goldshire/.test(step.title || '')).map(({ s }) => s), [], 'no walk back to Goldshire after Westbrook');
	assert.deepEqual(compiled(ELWYNN).steps.filter((st) => st.along).map((st) => st.title), [], 'no along-the-way lists');
});

// --- Flow re-order (2026-11-07, Alliance starts 1-20): the walks below crossed back over ground for one
// hand-in. Northshire: Garrick's head went to Willem on a trip back to the Abbey steps between Garrick's camp
// and Milly in the vineyard; now Milly first, Willem with Skirmish at Echo Ridge on the Abbey visit after the
// mine.
test(`${ELWYNN}: flow re-order: Milly's Harvest at Milly, Garrick's head on the Abbey visit after the mine`, { skip }, () => {
	const list = goals(ELWYNN);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	assert.ok(idx('turnin', 3904) < idx('turnin', 6), "Milly's Harvest before Garrick's head");
	assert.equal(list[idx('turnin', 6)].s, list[idx('turnin', 21)].s, 'Garrick handed in with Skirmish at Echo Ridge');
});

// Coldridge and Kharanos: the Dwarf guide took the five-minute Scalding Mornbrew before the troll whelps and
// Felix's parts, and both starts walked to Steelgrill's Depot for Stocking Jetsteam alone, then came back after
// the Grizzled Den for The Grizzled Den. Now the Mornbrew is the last thing taken at Grelin's camp before Anvilmar.
// Since the level tidy (0.4.0) the den comes after Brewnall (its Elder Wendigos and Shamans are level 8), so The
// Grizzled Den is handed to Pilot Stonegear on the depot stop that already hands Return to Bellowfiz to the pilot
// beside him: still no depot stop of its own.
for (const guide of DUN_MOROGHS) {
	test(`${guide}: flow re-order: the Mornbrew taken last at Grelin's camp, no depot stop for one pilot`, { skip }, () => {
		const list = goals(guide);
		const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
		const brew = idx('accept', 3364);
		assert.ok(idx('turnin', 182) < brew, 'the whelps are handed in before the Mornbrew is taken');
		assert.ok(list.slice(brew + 1, idx('turnin', 3364)).every(({ goal }) => !['kill', 'collect'].includes(goal.t)), 'no field work while the Mornbrew cools');
		assert.equal(list[idx('turnin', 320)].s, list[idx('turnin', 313)].s, 'Return to Bellowfiz and The Grizzled Den on one depot stop');
		assert.ok(at(list, 'the Wendigo Manes', (g) => g.t === 'collect' && g.item === 2671) < idx('turnin', 313), 'after the den');
	});
}

// #1224 (Dwarf Hunter, Coldridge Valley): the Frostmane Troll Whelps for The Troll Cave were an along list
// before Grelin's hand-in, and the field step held only for Felix's three parts, so the route moved on to Grelin
// with the whelp count short. The whelps are now goals of the Coldridge field step, with Felix's parts.
for (const guide of DUN_MOROGHS) {
	test(`${guide}: #1224: the troll whelps are worked in the Coldridge field step with Felix's parts, before Grelin`, { skip }, () => {
		const list = goals(guide);
		const whelps = at(list, 'kill 706 (Frostmane Troll Whelp) for 182', (g) => g.t === 'kill' && g.npc === 706 && g.quest === 182);
		assert.ok(!list[whelps].step.along, 'the whelps are not an along list');
		assert.equal(list[whelps].s, list[at(list, "Felix's Chest", (g) => g.t === 'collect' && g.item === 16313)].s, "in the step with Felix's parts");
		assert.ok(whelps < at(list, 'turnin 182', is('turnin', 182)), 'before Grelin takes The Troll Cave back');
		assert.equal(list.filter(({ goal }) => goal.t === 'kill' && goal.npc === 706 && goal.quest === 182).length, 1, 'one whelp goal');
	});
}

// Zephras Isle (Alliance): from the Ursera den the guide went to Hanaa first and walked back north to the
// grove; now the grove's hand-ins, then Hanaa on the way south to Shen'dar.
test(`${ZEPHRAS_ALLIANCE}: flow re-order: Aetheen and Valreaa before Hanaa, on the way south`, { skip }, () => {
	const list = goals(ZEPHRAS_ALLIANCE);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	assert.ok(idx('turnin', 92470) < idx('accept', 92544), 'Aetheen before Hanaa');
	assert.ok(idx('turnin', 92473) < idx('accept', 92544), 'Valreaa before Hanaa');
	assert.ok(idx('turnin', 92544) < idx('turnin', 92472), 'Hanaa before Shen\'dar');
});

// Teldrassil: Zenn's Bidding is handed in on the walk east from Dolanaar, before Starbreeze and the lake; the step's tip
// sent players to Zenn "north from the lake", which comes after.
test(`${TELDRASSIL}: Zenn's hand-in step does not send players there from Lake Al'Ameth, which comes after it`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const zenn = at(list, 'turnin 488', is('turnin', 488));
	assert.ok(zenn < at(list, 'turnin 997', is('turnin', 997)), 'Zenn before Denalan at the lake');
	assert.ok(!/from the lake/i.test(String(list[zenn].step.note || '')), 'the tip matches the walk');
});

// Starting-zone review 0.3.6 (Alliance 1-12): the level 5 Priest robe chains ride on stops the start guides
// already make: the trainer's letter on the start area's last stop at 5, the town trainer on the first town
// stop (with a quest everyone takes there), the wounded NPC on a walk the route makes, the robe on the next
// stop at the town trainer. Priests only (route-fixes include 5621-5626).
test('Alliance starting zones: the level 5 Priest robe quests ride on stops the route already makes', { skip }, () => {
	const chains = [
		['forever/alliance/human/01-elwynn-forest.guide', 5623, 5624, is('accept', 60)],
		['forever/alliance/dwarf/01-dun-morogh.guide', 5626, 5625, is('accept', 99158)],
		['forever/alliance/gnome/01-dun-morogh.guide', 5626, 5625, is('accept', 99158)],
		['forever/alliance/nightelf/01-teldrassil.guide', 5622, 5621, is('accept', 98391)],
	];
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	for (const [guide, letter, garments, townGoal] of chains) {
		for (const q of [letter, garments]) assert.ok(fixes.overrides.include.some((r) => r.q === q), `${q} is a route-fixes include`);
		const list = goals(guide);
		const take = at(list, `${guide}: accept ${letter}`, is('accept', letter));
		const deliver = at(list, `${guide}: turnin ${letter}`, is('turnin', letter));
		const accept = at(list, `${guide}: accept ${garments}`, is('accept', garments));
		const heal = at(list, `${guide}: heal the wounded NPC`, (g) => g.t === 'kill' && g.quest === garments);
		const robe = at(list, `${guide}: turnin ${garments}`, is('turnin', garments));
		assert.ok(take < deliver && deliver < accept && accept < heal && heal < robe, `${guide}: letter, town trainer, wounded NPC, robe in that order`);
		for (const i of [take, deliver, accept, heal, robe]) {
			assert.ok(forClass('PRIEST')(list[i]) && !forClass('WARRIOR')(list[i]), `${guide}: ${list[i].goal.t} ${list[i].goal.quest} is for Priests only`);
		}
		const town = at(list, `${guide}: the town stop`, townGoal);
		assert.equal(list[deliver].step, list[town].step, `${guide}: the letter goes in on the town stop everyone makes`);
		assert.ok(list.slice(heal + 1, robe).some(everyone), `${guide}: the robe waits for the next town stop, no trip back for it`);
	}
});

// Starting-zone review 0.3.6 (Alliance 1-12): the profession Camping 101 quests from each start campfire (270 XP,
// one per profession), handed in on a stop the guide already makes (route-fixes include). #1559: auto-accept never
// takes an optional accept, and the campfire step's required accept ends the step before it, so each is a required
// accept in its own `when skill` step right after the campfire's steps, and each hand-in a required turn-in in a
// `when onquest` step at the trainer: the profession-holder's auto-accept and auto turn-in take them, everyone else
// never sees them (same form as the Horde starts).
test('Alliance starting zones: profession Camping 101s from the campfire, for those with the skill, handed in on existing stops', { skip }, () => {
	const sets = [
		['forever/alliance/human/01-elwynn-forest.guide', 95998, [97924, 97922, 97920, 97919, 97916]],
		['forever/alliance/nightelf/01-teldrassil.guide', 96606, [97938, 97944, 97942, 97949, 97946]],
		['forever/alliance/dwarf/01-dun-morogh.guide', 96608, [96044, 96047, 96046, 96058]],
		['forever/alliance/gnome/01-dun-morogh.guide', 96608, [96044, 96047, 96046, 96058]],
		['forever/alliance/skyborne/01-zephras-isle.guide', 96101, [97963, 97964, 97965, 97967, 97969, 97970, 97971, 97973, 98286]],
	];
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	// Eric Brighthammer offers Blacksmithing only once Supplies to Tannok is handed in: its step follows that stop.
	const waitsFor = { 96044: 2160 };
	for (const [guide, sit, quests] of sets) {
		const list = goals(guide);
		const sat = at(list, `${guide}: turnin ${sit}`, is('turnin', sit));
		for (const q of quests) {
			assert.ok(fixes.overrides.include.some((r) => r.q === q), `${q} is a route-fixes include`);
			const take = at(list, `${guide}: accept ${q}`, is('accept', q));
			const give = at(list, `${guide}: turnin ${q}`, is('turnin', q));
			assert.ok(sat < take && take < give, `${guide}: ${q} is taken after the /sit quest and handed in later`);
			assert.ok(!list[take].goal.optional && !list[give].goal.optional, `${guide}: ${q} is required, so auto-accept and auto turn-in take it (#1559)`);
			const when = (i) => [].concat(list[i].step.when || []);
			assert.ok(when(take).some((w) => w.k === 'skill' && !w.neg), `${guide}: ${q} is offered only with the profession`);
			assert.ok(when(give).some((w) => w.k === 'onquest' && !w.neg && [].concat(w.q).includes(q)), `${guide}: ${q}'s hand-in shows only with the quest in the log`);
			const from = waitsFor[q] ? at(list, `${guide}: turnin ${waitsFor[q]}`, is('turnin', waitsFor[q])) : sat;
			const between = list.slice(from + 1, take);
			assert.ok(between.every(({ step }) => step === list[from].step || [].concat(step.when || []).some((w) => w.k === 'skill')), `${guide}: ${q}'s step follows the campfire step directly (or the stop its giver waits for)`);
		}
	}
});

// Starting-zone review 0.3.6: Elwynn's last Goldshire stop goes Dughan, Smith Argus beside him, then back into the
// inn for William Pestle's The Escape (after the #613 brewing scene) and the inn's class letters: one pass.
test('Elwynn: the last Goldshire stop takes Smith Argus with Dughan, before going back into the inn for William Pestle', { skip }, () => {
	const list = goals('forever/alliance/human/01-elwynn-forest.guide');
	const dughan = at(list, 'turnin 39', is('turnin', 39));
	const argus = at(list, 'accept 1097', is('accept', 1097));
	const escape = at(list, 'accept 114', is('accept', 114));
	assert.ok(dughan < argus && argus < escape, 'Dughan, Argus, then William');
	assert.equal(list[argus].step, list[escape].step, 'one Goldshire stop');
});

// Final route review follow-up (2026-11-08): the Dwarf and Gnome starts crossed Ironforge five times after the
// Thelsamar gryphon (a bare goto to Tinker Town's mailbox, back to the Great Forge for the flight path, the Hall of
// Arms, the Forlorn Cavern, the Military Ward, the High Seat, then the tram). Now one round: Great Forge, Tinker Town,
// the Forlorn Cavern, the Mystic Ward, the High Seat, the Military Ward, the tram.
for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: final review: Ironforge in one round of the city`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const gryth = at(list, 'turnin 6388', is('turnin', 6388));
	const fp = at(list, 'getfp Ironforge', (g) => g.t === 'getfp' && /Ironforge/.test(g.location || g.text || ''));
	assert.equal(list[fp].step, list[gryth].step, 'the flight path with Gryth');
	const tram = at(list, 'goto Deeprun Tram', (g) => g.t === 'goto' && g.text === 'Deeprun Tram');
	const city = list.slice(gryth, tram + 1);
	assert.ok(!city.some(({ goal }) => goal.t === 'goto' && goal.text === 'Ironforge'), 'no bare goto into Tinker Town');
	const order = [is('accept', 97263), is('turnin', 97263), is('turnin', 291)].map((p, k) => at(list, `stop ${k}`, p));
	assert.ok(gryth < order[0] && order[0] < order[1] && order[1] < order[2] && order[2] < tram, 'Tinker Town, Eldrun, the senator, the tram');
	const trains = city.filter(({ goal }) => goal.t === 'train' && goal.class === true).map(({ goal }) => goal);
	assert.ok(trains.every((g) => g.only), 'each trainer stop names its classes');
});

// Recorded spots (2026-11-09): Aamelia Windfield's quests are given and handed in at her farmhouse (12-13 people each),
// not at her second spawn up the field; the cultist ears come from Vayn's own camp (13 people).
test(`${ZEPHRAS_ALLIANCE}: #1415: Aamelia's quests at her farmhouse; the cultist ears at Vayn's camp`, { skip }, () => {
	const list = goals(ZEPHRAS_ALLIANCE);
	for (const [t, q] of [['turnin', 92679], ['turnin', 92682], ['turnin', 92683], ['turnin', 92684], ['accept', 92685], ['turnin', 92685], ['turnin', 92698], ['accept', 92693]]) {
		const { goal } = list[at(list, `${t} ${q}`, is(t, q))];
		assert.ok(Math.hypot(goal.x - 46.7, goal.y - 81.95) < 0.5, `${t} ${q} at the farmhouse (${goal.x},${goal.y})`);
	}
	const ids = new Set(PLACES().map((p) => p.id));
	for (const id of ['zephras-aamelia-92679-ender', 'zephras-aamelia-92685-giver', 'zephras-aamelia-92693-giver']) assert.ok(ids.has(id), `data/places.json ${id}`);
	const ears = list[at(list, 'collect 258771', (g) => g.t === 'collect' && g.quest === 93165)].goal;
	assert.ok(Math.hypot(ears.x - 63.7, ears.y - 37.1) < 1.5, `the ears lead to Vayn's camp (${ears.x},${ears.y})`);
	const eggs = list[at(list, 'collect 6889', (g) => g.t === 'collect' && g.quest === 92553 && g.item === 6889)].goal;
	assert.ok(Math.hypot(eggs.x - 42.1, eggs.y - 39.4) < 1.5, `the Small Eggs lead to the Galestriders by the village (${eggs.x},${eggs.y})`);
});

// Final route review 0.3.6: the group branch's WANTED: Vulgara the Insatiable (93318) was handed to Danarii Bellowveil
// after Valanaar's inn, a walk back north-west to Shen'dar and south-east again. It goes to her on the Shen'dar stop
// after the hippogryph loop, where her own quest (92551) is handed in, before the road to Fendaal and Valanaar.
test(`${ZEPHRAS_ALLIANCE}: the Vulgara bounty is handed in on the Shen'dar stop, before the road to Valanaar`, { skip }, () => {
	const list = goals(ZEPHRAS_ALLIANCE);
	const hand = at(list, 'turnin 93318', is('turnin', 93318));
	assert.ok((list[hand].step.when || []).some((p) => p.k === 'group' && !p.neg), 'on the group branch');
	assert.ok(list[at(list, 'turnin 92551 (Danarii Bellowveil)', is('turnin', 92551))].s < list[hand].s, 'after the hippogryph loop brings you back to Shen\'dar');
	assert.ok(hand < at(list, 'accept 98512 (Fendaal Windstone)', is('accept', 98512)), 'before the road south-east to Valanaar');
});

// Night Elves landed in Auberdine at the end of Teldrassil and killed Tide Crawlers on the Long Wash for Gwennyth's
// bones, but Buzzbox 827 (983, Crawler Legs) was taken from Wizbang in the next guide and its legs gathered on the same
// beach in 03-darkshore at 15 (flow audit: Wizbang passed at 5 yd, a missed merge on the crawlers). Taken and done on
// that first beach walk now (#1415).
test(`${TELDRASSIL}: #1415: Buzzbox 827 is taken on the first Auberdine stop and its crawler legs gathered on the Long Wash`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, 'accept 983', is('accept', 983));
	assert.equal(list[take].step, list[at(list, 'accept 3524', is('accept', 3524))].step, 'with Gwennyth\'s quest');
	const legs = at(list, 'collect 5385', (g) => g.t === 'collect' && g.item === 5385);
	assert.equal(list[legs].step, list[at(list, 'the bones', (g) => g.t === 'collect' && g.item === 12242)].step, 'on the bones step');
	assert.ok(legs < at(list, 'turnin 983', is('turnin', 983)), 'handed to the Buzzbox there');
});

// Position sweep (0.3.6, the patrol check): Mountaineer Kadrell walks the road through Thelsamar (his
// spawn 34.17,47.84, a 97 yd walk). The data's point, 32.63,49.74, is the south end of the road, 55 yd from his spawn,
// so his goals got no walk circle and players met him 60-90 yd from the arrow (35 people, most at 34-36,46-48). His
// goals point within 15 yd of his spawn, where the compiler draws his walk.
test('Loch Modan (Dwarf, Gnome): Mountaineer Kadrell\'s goals point at his walk through Thelsamar', { skip }, () => {
	for (const f of ['forever/alliance/dwarf/01-dun-morogh.guide', 'forever/alliance/gnome/01-dun-morogh.guide']) {
		const g = goals(f);
		for (const [what, pred] of [['turnin 414', is('turnin', 414)], ['accept 416', is('accept', 416)], ['accept 1339', is('accept', 1339)], ['turnin 416', is('turnin', 416)]]) {
			const goal = g[at(g, what, pred)].goal;
			assert.ok(goal.map === 1432 && Math.abs(goal.x - 33.8) < 0.3 && Math.abs(goal.y - 48.3) < 0.3, `${f} ${what} at Kadrell's walk (${goal.x},${goal.y})`);
		}
	}
});

// Position sweep (0.3.6, the patrol check): Sentinel Shayla Nightbreeze walks the road west of Dolanaar
// (10 people took her bounty and 13 handed it in along the road from 41.3,50.8 to 38.2,54.4, half of them 70-130 yd
// from the arrow); the steps said she stands beside the gate.
test('Teldrassil: Shayla\'s steps say she walks the road', { skip }, () => {
	const g = goals('forever/alliance/nightelf/01-teldrassil.guide');
	for (const [what, pred] of [['accept 490', is('accept', 490)], ['turnin 490', is('turnin', 490)]]) {
		const step = g[at(g, what, pred)].step;
		assert.match(step.note || '', /walks (?:this stretch of )?(?:the )?road/, `${what}: the tip says she walks`);
		assert.doesNotMatch(step.note || '', /stands beside/, `${what}: not "stands beside"`);
	}
});

// Players' route (0.3.6): Twisted Hatred (98403, 900 XP), Tallonkai's Forever follow-up to Twisted Hatred
// (932), is a group quest (Xethorr the Wicked is a level 12 elite): offered on the jewel's hand-in to Tallonkai, its
// Befouled Webwoods and Xethorr sit north-west of Dolanaar on the way to the Oracle Glade once Shayla's hand-in moved to the
// walk south from the glade to Ursal (shorter for everyone). 0.4.0 audit: the accept is for groups only, like the other
// group quests (with it in a solo log, While you're here could offer the elite), and it goes back to Tallonkai on the
// next Dolanaar stop, upstairs in the same inn, before Lake Al'Ameth and Ursal.
test(`${TELDRASSIL}: Twisted Hatred's webwoods on the way to the Oracle Glade for groups, handed in on the next Dolanaar stop`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, 'accept 98403', is('accept', 98403));
	const jewel = at(list, 'turnin 2459', is('turnin', 2459));
	assert.ok(jewel < take && list[take].s === list[jewel].s + 1, "offered right after the jewel's hand-in");
	assert.ok((list[take].step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(98403) && !p.neg), 'the accept is under when group 98403');
	const webs = at(list, 'kill 272096', (g) => g.t === 'kill' && g.quest === 98403);
	const moss = at(list, 'collect 281023', (g) => g.t === 'collect' && g.quest === 98403);
	const glade = at(list, 'accept 937', is('accept', 937));
	assert.ok(jewel < webs && webs < glade && list[moss].s === list[webs].s, 'between the jewel hand-in at Dolanaar and the glade');
	assert.ok((list[webs].step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(98403) && !p.neg), 'Xethorr is elite: under when group 98403');
	const hand = at(list, 'turnin 98403', is('turnin', 98403));
	assert.ok(hand > at(list, 'accept 99050 (Byancie)', is('accept', 99050)), 'handed to Tallonkai on the Dolanaar stop after the glade');
	assert.ok(hand < at(list, 'kill 486 (Ursal)', (g) => g.t === 'kill' && g.quest === 486), 'before Lake Al\'Ameth and Ursal');
	assert.ok((list[hand].step.when || []).some((p) => p.k === 'complete' && !p.neg), 'only once the quest is done');
});

// #1867 (Teldrassil, Camping 101: Skinning, 97949): Lyreena didn't offer it because the character already knew Camp
// Chair, the Skinning camp item a trainer teaches from skill 20, yet the step waited for the quest. Every start
// guide's Camping 101 step now applies only while its profession's camp item is unknown (`when !knows <spell>`),
// besides `when skill <profession> 1`.
test(`${TELDRASSIL}: #1867: Camping 101: Skinning is skipped once Camp Chair is known`, { skip }, () => {
	const elf = { race: 'NightElf', raceName: 'Night Elf', faction: 'Alliance', cls: 'DRUID', className: 'Druid', level: 6 };
	const skinner = 'w.skills[393] = { name = "Skinning", rank = 1, maxRank = 75 }';
	const open = questGoalStatus(TELDRASSIL, 97949, elf, { skills: skinner });
	const known = questGoalStatus(TELDRASSIL, 97949, elf, { skills: `${skinner}; w.spells[1229517] = true` });
	const accept = (list) => list.find((v) => v.startsWith('accept '));
	assert.ok(accept(open) && !/ (na|skipped)$/.test(accept(open)), `a skinner without Camp Chair still gets the step: ${accept(open)}`);
	assert.match(accept(known) || '', / (na|skipped)$/, 'with Camp Chair known the step does not apply');
});

// Alliance 1-12 audit (0.4.0, #2025): Night Elves took Marshal Dughan's Further Concerns (35) at the end of their
// Darkshore guide, but nothing on their route works Guard Thomas' chain (Westfall's east-Elwynn loop is the Dwarves'
// and Gnomes'); in players' recordings 12 Night Elves took it and 1 handed it in. A Fishy Peril (40) stays: Remy and
// Dughan stand side by side.
test(`${NE_DARKSHORE}: Night Elves no longer take Further Concerns; A Fishy Peril stays`, { skip }, () => {
	const list = goals(NE_DARKSHORE).filter(nightElf);
	assert.ok(!list.some(({ goal }) => is('accept', 35)(goal)), 'no accept 35 in the Night Elf Darkshore');
	assert.ok(at(list, 'accept 40', is('accept', 40)) < at(list, 'turnin 40', is('turnin', 40)), 'A Fishy Peril taken and handed in');
});

// Alliance 1-12 audit (0.4.0, #2025): a Night Elf who loads nightelf/02-darkshore without Teldrassil's Long Wash
// took Buzzbox 827 (983) from Wizbang and carried it, a level 10 quest, to 03-darkshore at about 17. The crawlers
// and Buzzbox 827 are on the beach the guide's turtle step already walks: the legs and the hand-in are there, only
// while the quest is carried (Teldrassil's players hand it in on the Long Wash).
test(`${NE_DARKSHORE}: Buzzbox 827 is handed in on the beach before the first loop, only while carried`, { skip }, () => {
	const list = goals(NE_DARKSHORE).filter(nightElf);
	const take = at(list, 'accept 983', is('accept', 983));
	const give = at(list, 'turnin 983', is('turnin', 983));
	assert.ok(take < give && give < at(list, 'turnin 954', is('turnin', 954)), 'taken in Auberdine, handed in before Bashal\'Aran');
	assert.ok(list[give].step.when.some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(983)), 'only while 983 is carried');
	assert.ok(list.slice(take, give).some(({ goal }) => goal.t === 'collect' && goal.item === 5385), 'the Crawler Legs first');
});

// Alliance 1-12 audit (0.4.0, #2025): class training skipped at a capital visit right after a ding. Night Elves
// trained last in Dolanaar (~11) and next in Goldshire (~14.5), though their last Darnassus visit (~12) walks past
// every Night Elf class's trainers (13 people trained there at 12 on their own, players' recordings); Alliance
// Skyborne trained last in Valanaar (~13.5) and next at Westfall's end (~16), though they walk Stormwind at ~14
// (5 trained there on their own).
test('Alliance starts: training on the last Darnassus visit (Night Elves) and the Stormwind walk (Skyborne)', { skip }, () => {
	for (const [guide, zone, map, from, classes] of [
		[TELDRASSIL, 'Darnassus', 1457, 12, ['WARRIOR', 'HUNTER', 'ROGUE', 'PRIEST', 'DRUID']],
		[ZEPHRAS_ALLIANCE, 'Stormwind City', 1453, 14, ['WARRIOR', 'HUNTER', 'ROGUE', 'MAGE', 'DRUID']],
	]) {
		for (const cls of classes) {
			const list = goals(guide).filter(forClass(cls));
			const gated = (step) => (step.when || []).some((p) => p.k === 'level' && p.op === '>=' && !p.neg && p.n === from);
			const train = list.filter(({ step, goal }) => goal.t === 'train' && gated(step));
			assert.equal(train.length, 1, `${guide}: a ${cls} trains once from level ${from} (in ${zone})`);
			assert.ok((train[0].goal.candidates || []).some((c) => c.map === map && c.classes.includes(cls)), `${guide}: ${cls}: a trainer in ${zone}`);
		}
	}
});

// Alliance 1-12 audit (0.4.0, #2025): a Gnome Warlock walked from Gakin in Stormwind to Surena Caledon at the
// Brackwell Pumpkin Patch and back for The Binding, then Westfall's east-Elwynn loop walked the same road to the
// bridge and Brackwell again. The Dun Morogh guides now end with 1688 taken from Gakin; Surena's Choker and The
// Binding are on 02-westfall's east-Elwynn loop (about 1,000 yd less walking).
test('Dun Morogh (Gnome): Surena Caledon is taken from Gakin, her choker and The Binding are left to Westfall', { skip }, () => {
	for (const guide of ['forever/alliance/gnome/01-dun-morogh.guide', 'forever/alliance/dwarf/01-dun-morogh.guide']) {
		const list = goals(guide).filter(forClass('WARLOCK'));
		assert.ok(at(list, 'turnin 1715', is('turnin', 1715)) < at(list, 'accept 1688', is('accept', 1688)), `${guide}: 1715, then 1688 at Gakin`);
		assert.ok(!list.some(({ goal }) => goal.quest === 1689 || (goal.t === 'collect' && goal.item === 6810) || is('turnin', 1688)(goal)), `${guide}: no Surena walk or Binding`);
	}
});

// Danger at the spot (#1575), Alliance 1-12 audit (0.4.0): warnings where players died on the current route.
test('Alliance starts: Careful tips at Frostmane Hold, Stonesplinter Valley, Ban\'ethil Barrow and Elder Finseer\'s river', { skip }, () => {
	for (const [guide, pred, says] of [
		['forever/alliance/dwarf/01-dun-morogh.guide', (g) => g.t === 'kill' && g.quest === 287, /Frostmane Hideskinners/],
		['forever/alliance/gnome/01-dun-morogh.guide', (g) => g.t === 'kill' && g.quest === 287, /Frostmane Hideskinners/],
		['forever/alliance/dwarf/01-dun-morogh.guide', (g) => g.t === 'kill' && g.quest === 224, /Headsplitter/],
		['forever/alliance/gnome/01-dun-morogh.guide', (g) => g.t === 'kill' && g.quest === 224, /Headsplitter/],
		[TELDRASSIL, (g) => g.t === 'collect' && g.quest === 483, /Gnarlpine Defenders/],
		[ELWYNN, (g) => g.t === 'collect' && g.quest === 91751, /Elder Finseer/],
	]) {
		const list = goals(guide);
		const { step } = list[at(list, `${guide}: ${says}`, pred)];
		assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), says, `${guide}: "${step.title}" warns`);
	}
});

// #1952: a Camping 101 profession quest asks for the profession at 20 before its trainer takes it; at skill 1-5 the
// Alliance start guides' trainer step right after the campfire waited for an objective the player could not finish
// there. Each in-zone trainer hand-in step now shows only once the quest is complete (`when complete <q>`), and the
// accept step says the trainer takes it at 20; While-here offers the hand-in on a later pass.
test('#1952: the Alliance start guides\' Camping 101 trainer steps wait until the quest is complete', { skip }, () => {
	const starts = [ELWYNN, 'forever/alliance/dwarf/01-dun-morogh.guide', 'forever/alliance/gnome/01-dun-morogh.guide', TELDRASSIL, ZEPHRAS_ALLIANCE];
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	let n = 0;
	for (const file of starts) {
		const list = goals(file);
		for (const { step, goal } of list) {
			if (goal.t !== 'turnin' || !/^Camping 101: (?!Cooking)/.test(goal.title || '')) continue;
			n += 1;
			const when = step.when || [];
			assert.ok(when.some((p) => p.k === 'complete' && !p.neg && p.q === goal.quest), `${file}: turnin ${goal.quest} waits until the quest is complete`);
			assert.ok(fixes.some((f) => f.faction === 'Alliance' && f.at && f.at.quest === goal.quest && f.at.goal === 'turnin' && f.when === `complete ${goal.quest}`), `${goal.quest}: a record the build keeps`);
			const take = list.find((e) => e.goal.t === 'accept' && e.goal.quest === goal.quest);
			assert.match([take.step.note, take.step.tip].flat().filter(Boolean).join(' '), / skill is 20/, `${file}: accept ${goal.quest} says the trainer takes it at 20`);
		}
	}
	assert.ok(n >= 27, `${n} in-zone Camping 101 hand-ins found`);
});

// Alliance 1-12 route feel (0.4.0, #2025): The Red Crystal (4811) waited for Night Elf Darkshore's first steps, a
// second walk to Sentinel Glynda in Auberdine's main street. It is taken on Teldrassil's first Auberdine stop, with
// the WANTED poster a few steps from her (level 12 needed; the route reaches that stop at 12.5 or more), not at the
// end of the second stop, which then walked back past the poster. Night Elf Darkshore keeps its accept for a player
// who loads it fresh.
test(`${TELDRASSIL}: The Red Crystal is taken on the first Auberdine stop, with the WANTED poster`, { skip }, () => {
	const list = goals(TELDRASSIL).filter(forClass('WARRIOR'));
	const take = list[at(list, 'accept 4811', is('accept', 4811))];
	assert.ok(take.step.goals.some(is('accept', 98025)) && take.step.goals.some(is('turnin', 6342)), 'the first stop: Laird and the WANTED poster');
	assert.ok(at(list, 'accept 4811', is('accept', 4811)) < at(list, 'accept 954', is('accept', 954)), 'before the second stop');
	const ne = goals(NE_DARKSHORE).filter(nightElf);
	assert.ok(at(ne, 'accept 4811', is('accept', 4811)) < at(ne, 'crystal', (g) => g.quest === 4811 && g.t === 'interact'), 'Night Elf Darkshore keeps the accept before the crystal');
});

// Level tidy (0.4.0), Dun Morogh: the Snow Leopard Prowler (6) came at a recorded 4.8, the Grizzled Den's Elder
// Wendigos and Shamans (8) at 6.3, the Leper Gnomes (8-10) and Frostmane Hold's Hideskinners (9-10) at 8.3, and
// Call of Fire's Stonesplinter Seers (13-14) right after the tunnel at 12. Grund comes after Grik'nir, the den once
// after Brewnall with Frosthowl's fish, the gnomes and the Hold after Brewnall's second visit, and the Shamans' Fire
// Tar and Reagent Pouch after the Silver Stream Mine.
for (const guide of DUN_MOROGHS) {
	test(`${guide}: level tidy: Gozwin, the Grizzled Den, the Leper Gnomes, Frostmane Hold and Call of Fire at the player's level`, { skip }, () => {
		const list = goals(guide);
		const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
		assert.ok(idx('turnin', 218) < idx('accept', 97277), 'Grund and Gozwin after The Stolen Journal');
		const manes = at(list, 'the Wendigo Manes', (g) => g.t === 'collect' && g.item === 2671);
		assert.ok(idx('turnin', 319) < manes, 'the den after Brewnall\'s first visit');
		assert.equal(list[manes].s, list[at(list, 'Sack of Fish', (g) => g.t === 'collect' && g.item === 280426)].s, 'one den visit, with Frosthowl');
		assert.ok(list.filter(({ goal }) => goal.t === 'collect' && goal.item === 2671).length === 1, 'the den is entered once');
		for (const [what, pred] of [['the cogs', (g) => g.t === 'collect' && g.item === 3083], ['the Headhunters', (g) => g.t === 'kill' && g.quest === 287]]) {
			assert.ok(idx('turnin', 315) < at(list, what, pred), `${what} after Brewnall's second visit`);
		}
		const mine = idx('collect', 307);
		const shaman = list.filter(({ goal }) => goal.quest === 94466 && goal.t === 'collect');
		assert.equal(shaman.length, 2, 'the Fire Tar and the Reagent Pouch');
		for (const e of shaman) assert.ok(list.indexOf(e) > mine, `Call of Fire's ${e.goal.item} after the Silver Stream Mine's crates`);
	});
}

// Level tidy (0.4.0), Elwynn Forest: the grind top-ups named Kobold Miners (6-7) at 5.77 and Prowlers (9-10) at
// 8.85, and the river step sent players at the Prowlers at a recorded 8.5. The grinds are on Stonetusk Boars (5-6)
// and Gray Forest Wolves (7-8), and the Prowlers wait for the walk back to Guard Thomas.
test(`${ELWYNN}: level tidy: grinds at the player's level, the Prowlers on the walk back to Guard Thomas`, { skip }, () => {
	const list = goals(ELWYNN);
	const grind = (title) => list.find(({ step, goal }) => step.title === title && goal.t === 'level');
	assert.equal(grind('Level 5.77').goal.note, 'grind on Stonetusk Boar');
	assert.equal(grind('Level 8.85').goal.note, 'grind on Gray Forest Wolf');
	const prowlers = list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 52 && goal.npc === 118);
	assert.equal(prowlers.length, 1, 'the Prowlers in one step');
	assert.ok(list.indexOf(prowlers[0]) > at(list, 'turnin 91723', is('turnin', 91723)), 'after the Jasperlode Mine, with Guard Thomas');
	assert.match(JSON.stringify(list[at(list, 'accept 5545', is('accept', 5545))].step), /Elmpaw/, 'the logging camp warns about Elmpaw, a level 12 elite');
});

// Level tidy (0.4.0), Teldrassil: the Grells (2-3) came in one field step with the level 1 beasts, Ursal (12)
// at a recorded 10.8 and Witchmother Arysa (12) at 10.5. The Grells come after The Balance of Nature's kills,
// Ursal after Lake Al'Ameth, and Arysa after Lady Sathrah.
test(`${TELDRASSIL}: level tidy: the Grells, Ursal and Witchmother Arysa at the player's level`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const moss = at(list, 'Fel Moss', (g) => g.t === 'collect' && g.item === 3297);
	assert.ok(list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 456).every((e) => list.indexOf(e) < moss && e.s < list[moss].s), 'the beasts first, in their own step');
	assert.ok(at(list, 'turnin 930', is('turnin', 930)) < at(list, 'kill Ursal', (g) => g.t === 'kill' && g.quest === 486), 'Ursal after Lake Al\'Ameth');
	assert.ok(at(list, 'Silvery Spinnerets', (g) => g.t === 'collect' && g.item === 8344) < at(list, "Arysa's Amulet", (g) => g.t === 'collect' && g.item === 280834), 'Arysa after Lady Sathrah');
	const rage = at(list, 'kill Rageclaw', (g) => g.t === 'kill' && g.quest === 2561);
	assert.ok(list[rage].s > list[at(list, 'relic 3408', (g) => g.t === 'collect' && g.item === 3408)].s, 'Rageclaw in a step of his own, after the relics');
});

// #2268 (thmastin, Dwarf Shaman 11): the Empty Powder Keg's quest, Stolen Blasting Powder (95213), was handed in on the
// quarry stop as an optional line beside Those Blasted Troggs! and The Public Servant; with those two in, nothing held
// the step, and the window moved on to Helm's Bed Lake while 95213 sat complete in the log, Thesten's follow-up (95214)
// never taken. The hand-in and the follow-up's accept now have a step of their own, shown while 95213 is carried.
test('#2268: Dun Morogh holds Quarrymaster Thesten for the powder keg\'s quest before Helm\'s Bed Lake', { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.ok(fixes.some((f) => f.at && f.at.quest === 95213 && f.at.goal === 'turnin' && f.split), 'a split record the build keeps');
	assert.ok(fixes.some((f) => f.at && f.at.quest === 95213 && f.at.goal === 'turnin' && f.when === 'onquest 95213'), 'a when record the build keeps');
	for (const guide of DUN_MOROGHS) {
		const list = goals(guide);
		const give = at(list, 'turnin 95213', is('turnin', 95213));
		const take = at(list, 'accept 95214', is('accept', 95214));
		const { step } = list[give];
		assert.ok(step.when.some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(95213)), `${guide}: shown while 95213 is carried`);
		assert.ok(!list[give].goal.optional && !list[take].goal.optional, `${guide}: the hand-in and the follow-up hold the step`);
		assert.equal(list[take].step, step, `${guide}: 95214 taken on the same step`);
		assert.ok(take < at(list, 'powder at the lake', (g) => g.t === 'collect' && g.item === 267415), `${guide}: before Helm's Bed Lake`);
	}
});

// Erik (#1483): the Human Warlock's trip to Stormwind read only "Go to Stormwind"; it names where it leads.
test('#1483: Elwynn Forest: the Warlock\'s Stormwind walk names Gakin the Darkbinder', { skip }, () => {
	const list = goals(ELWYNN);
	const walk = list.find(({ goal }) => goal.t === 'goto' && goal.map === 1453 && /Gakin/.test(goal.text || ''));
	assert.ok(walk, 'a goto named for Gakin');
	assert.ok(at(list, 'turnin 1685', is('turnin', 1685)) > list.indexOf(walk), 'then the hand-in to him');
});
