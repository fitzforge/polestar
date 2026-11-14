'use strict';
// The flow audit and the route-feel gate (tools/flow-audit.js, tools/lib/flow/, docs/ROUTE-FEEL.md) on made-up guides
// and made-up reference data: no compiled guides or data/forever needed.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { runAudit } = require('../tools/lib/flow/audit');
const { Walk, Router, whenOk } = require('../tools/lib/flow/walk');
const { loadData, pyRound } = require('../tools/lib/flow/data');
const { compare, reasonFor } = require('../tools/lib/flow/gate');
const { modesOf } = require('../tools/flow-audit');

// Map 1 is 100,000 yd across: 1% is 1,000 yd, 0.01% is 10 yd; walking is 7 yd/s. The audits here walk every leg
// (longFly 0; the command counts a leg over 2,500 yd as flown).
function dataDir(t) {
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'flow-audit-'));
	t.after(() => fs.rmSync(dir, { recursive: true, force: true }));
	const write = (f, v) => fs.writeFileSync(path.join(dir, f), JSON.stringify(v));
	write('map-frames.json', { era: { 1: { c: 0, top: 0, bottom: 100000, left: 0, right: 100000 } } });
	write('quests.json', {
		1: { level: 5, xp: 100, objectives: [{ type: 'monster' }] },
		2: { level: 5, xp: 100, objectives: [{ type: 'monster' }] },
		3: { level: 5, xp: 100, objectives: [{ type: 'monster' }] },
		4: { level: 5, xp: 100, objectives: [{ type: 'monster' }] },
		10: { level: 5, xp: 100, objectives: [{ type: 'monster' }] },
		11: { level: 5, xp: 100, objectives: [{ type: 'monster' }] },
	});
	write('races.json', { Orc: { Horde: { classes: ['WARRIOR'] } } });
	write('travel.json', { taxi: { nodes: [{ id: 5, c: 0, wx: 20000, wy: 20000 }] }, inns: [] });
	write('zones.json', { 1: { name: 'Testland' } });
	return dir;
}

const at = (x, y) => ({ map: 1, x, y });
const accept = (quest, npc, x, y) => ({ t: 'accept', quest, title: `Quest ${quest}`, npc, npcName: `Npc ${npc}`, ...at(x, y) });
const turnin = (quest, npc, x, y) => ({ t: 'turnin', quest, title: `Quest ${quest}`, npc, npcName: `Npc ${npc}`, ...at(x, y) });
const kill = (quest, x, y) => ({ t: 'kill', quest, title: `Quest ${quest}`, oi: 1, npc: 99, target: 'Boar', count: 1, ...at(x, y) });
const goto_ = (x, y) => ({ t: 'goto', ...at(x, y) });
const guide = (id, steps, extra = {}) => ({ id, category: 'Leveling', faction: 'Horde', steps: steps.map((goals) => (Array.isArray(goals) ? { goals } : goals)), ...extra });

// A camp at (10, 10): giver 1 of quests 1, 3 and 4; giver 2, 20 yd away, of quest 2, which the route takes only after a
// trip east and back. Quest 3 is worked and handed in two guides later, an hour's walk north; quest 4 never.
function chainGuides() {
	return [
		guide('test/a', [
			[accept(1, 1, 10, 10), accept(3, 1, 10, 10), accept(4, 1, 10, 10)],
			[kill(1, 14, 10)],
			[turnin(1, 1, 10, 10)],
			[goto_(13, 10)],
			[accept(2, 2, 10.02, 10)],
			[kill(2, 10.5, 10)],
			[turnin(2, 2, 10.02, 10)],
		], { races: ['Orc'], next: 'test/b' }),
		guide('test/b', [[goto_(10, 40)]], { next: 'test/c' }),
		guide('test/c', [[kill(3, 10, 45)], [turnin(3, 7, 10, 45.02)]]),
	];
}

test('a giver walked past and taken after a trip away is a passed giver, and the trip back an avoidable backtrack', (t) => {
	const res = runAudit({ guides: chainGuides(), legs: {} }, dataDir(t), { dynamic: null, longFly: 0 });
	const a = res.guides['test/a'];
	const passed = a.findings.filter((f) => f.type === 'passed-giver');
	assert.deepEqual(passed.map((f) => [f.quest, f.tier, f.take_step]), [[2, 'near', 5]]);
	assert.ok(a.backtracks.some((b) => b.avoidable && b.step === 5), 'the walk back to the camp is an avoidable backtrack');
	assert.equal(a.mean.passed_givers_near, 1);
	assert.equal(res.branches.length, 1);
	assert.deepEqual(res.branches[0].chain, ['test/a', 'test/b', 'test/c']);
});

test('a quest handed in two guides after its pick-up is carried far, an hour before its work is early, and one never handed in is listed', (t) => {
	const res = runAudit({ guides: chainGuides(), legs: {} }, dataDir(t), { dynamic: null, longFly: 0 });
	const a = res.guides['test/a'];
	assert.deepEqual(a.carried.map((c) => [c.quest, c.to_gid, c.span, c.far]), [[3, 'test/c', 3, true]]);
	assert.deepEqual(a.early.map((c) => [c.quest, c.work_gid]), [[3, 'test/c']]);
	assert.ok(a.early[0].min >= 60);
	assert.deepEqual(a.never.map((c) => c.quest), [4]);
	const b = res.branches[0];
	assert.equal(b.carried_far, 1);
	assert.equal(b.never_handed, 1);
	assert.ok(b.log_mean > 0);
});

test('the walk reads the character state the guides gate on: a taxi pair plays one side, has counts items, knows never holds', (t) => {
	const data = loadData(dataDir(t));
	const g = guide('test/w', [
		[{ t: 'getfp', node: 5, location: 'Camp', ...at(10, 10) }],
		{ when: [{ k: 'taxi', node: 5, name: 'Camp' }], goals: [goto_(11, 10)] },
		{ when: [{ k: 'taxi', node: 5, name: 'Camp', neg: true }], goals: [goto_(12, 10)] },
		[{ t: 'collect', item: 77, count: 2, ...at(11.1, 10) }],
		{ when: [{ k: 'has', item: 77, n: 2 }], goals: [goto_(11.2, 10)] },
		{ when: [{ k: 'has', item: 77, n: 3 }], goals: [goto_(11.3, 10)] },
		{ when: [{ k: 'knows', spell: 1 }], goals: [goto_(11.4, 10)] },
		{ when: [{ k: 'knows', spell: 1, neg: true }], goals: [goto_(11.5, 10)] },
		[{ t: 'sethome', location: 'Camp Inn', area: 9, ...at(10, 10) }],
		{ when: [{ k: 'bound', name: 'Camp Inn', area: 9 }], goals: [goto_(11.6, 10)] },
		{ when: [{ k: 'bound', name: 'Camp Inn', area: 9, neg: true }], goals: [goto_(11.7, 10)] },
	], { races: ['Orc'] });
	const w = new Walk({ chain: ['test/w'], race: 'Orc', cls: 'WARRIOR', guides: new Map([[g.id, g]]), legs: {}, data });
	assert.deepEqual([...new Set(w.entries.map((e) => e.step))], [1, 2, 4, 5, 8, 9, 10]);
	assert.equal(whenOk([{ k: 'group' }], 30), false);
	assert.equal(whenOk([{ k: 'dungeon', map: 43 }], 30, null, '43,47'), true);
	assert.equal(whenOk([{ k: 'dungeon', map: 43 }], 30, null, ''), false);
	// `when dungeon "X" all`: only when X is run with every quest; a plain dungeon step in both styles
	assert.equal(whenOk([{ k: 'dungeon', map: 43, all: true }], 30, null, 'all', 'all'), true);
	assert.equal(whenOk([{ k: 'dungeon', map: 43, all: true }], 30, null, 'all', 'way'), false);
	assert.equal(whenOk([{ k: 'dungeon', map: 43 }], 30, null, 'all', 'way'), true);
	assert.equal(whenOk([{ k: 'dungeon', map: 43, neg: true }], 30, null, '', 'way'), true);
});

test('a route choice is taken where a guide offers it, and nextWhen picks the option that holds at the level', () => {
	const g = { next: 'x/a', nextChoices: ['x/a', 'polestar-experimental/riverglades-horde-1'] };
	assert.equal(new Router('g', []).nextOf(g, 40), 'x/a');
	assert.equal(new Router('g', ['riverglades']).nextOf(g, 40), 'polestar-experimental/riverglades-horde-1');
	const byLevel = { next: 'x/high', nextChoices: ['x/high', 'x/low'], nextWhen: { 'x/high': [{ k: 'level', op: '>=', n: 43 }], 'x/low': [{ k: 'level', op: '<', n: 43 }] } };
	assert.equal(new Router('g').nextOf(byLevel, 42), 'x/low');
	assert.equal(new Router('g').nextOf(byLevel, 43), 'x/high');
});

test('with dungeons in the route, a pick-up stop there only for a dungeon quest is a dungeon trip; without them it is not walked', (t) => {
	const guides = [guide('test/d', [
		[accept(10, 1, 10, 10)],
		{ when: [{ k: 'dungeon', name: 'Wailing Caverns', map: 43 }], goals: [accept(11, 3, 10, 13)] },
		[kill(10, 10.3, 10)],
		[turnin(10, 1, 10, 10)],
	], { races: ['Orc'] })];
	const dir = dataDir(t);
	const run = runAudit({ guides, legs: {} }, dir, { dynamic: null, longFly: 0, dungeons: 'all' });
	const exc = run.guides['test/d'].dng_exc;
	assert.deepEqual(exc.map((x) => [x.type, x.step, x.dungeon]), [['dungeon-pick-up', 2, 'Wailing Caverns']]);
	assert.ok(exc[0].min > 10, `a 3,000 yd trip each way costs over 10 minutes (${exc[0].min})`);
	assert.equal(run.branches[0].dng_trips, 1);
	const skip = runAudit({ guides, legs: {} }, dir, { dynamic: null, longFly: 0, dungeons: '' });
	assert.deepEqual(skip.guides['test/d'].dng_exc, []);
	assert.equal(skip.branches[0].dng_quests, 0);
});

test('a step or goal for the other faction is not played: a shared guide\'s `only Alliance` lines stay out of a Horde walk', (t) => {
	const guides = [guide('test/f', [
		[accept(10, 1, 10, 10)],
		{ only: { factions: ['Alliance'] }, goals: [accept(11, 3, 10, 13)] },
		[{ ...accept(1, 4, 10, 11), only: { factions: ['Alliance'] } }, { ...accept(2, 4, 10, 11), only: { factions: ['Horde'] } }],
		[kill(10, 10.3, 10)],
		[turnin(10, 1, 10, 10)],
	], { races: ['Orc'] })];
	const run = runAudit({ guides, legs: {} }, dataDir(t), { dynamic: null, longFly: 0 });
	assert.equal(run.branches[0].log_max, 2, 'quests 10 and 2 only');
	assert.equal(run.branches[0].never_handed, 1, 'quest 2; quests 1 and 11 are the Alliance\'s');
});

test('the modes cover the default route, each route choice the compiled guides hold and all of them; with dungeons, both dungeon styles too', () => {
	const exp = (id) => ({ id: `polestar-experimental/${id}`, category: 'Leveling', faction: 'Horde' });
	const compiled = { guides: [
		{ id: 'forever/horde/a', category: 'Leveling', faction: 'Horde', nextChoices: ['forever/horde/b', 'polestar-experimental/riverglades-horde-1'] },
		{ id: 'forever/horde/c', category: 'Leveling', faction: 'Horde', nextChoices: ['forever/horde/d', 'polestar-experimental/shendralas'] },
		{ id: 'forever/horde/e', category: 'Leveling', faction: 'Horde', nextChoices: ['forever/horde/f', 'polestar-experimental/not-compiled'] },
		exp('riverglades-horde-1'), exp('shendralas'),
	] };
	assert.deepEqual(modesOf(compiled, 'Horde').map((m) => m.mode), ['skip', 'riverglades', 'shendralas', 'riverglades+shendralas']);
	assert.deepEqual(modesOf(compiled, 'Horde', { dungeons: true }).map((m) => m.mode),
		['skip', 'riverglades', 'shendralas', 'riverglades+shendralas', 'run', 'run+riverglades', 'run+shendralas', 'run+riverglades+shendralas',
			'run-way', 'run-way+riverglades', 'run-way+shendralas', 'run-way+riverglades+shendralas']);
	assert.deepEqual(modesOf(compiled, 'Alliance').map((m) => [m.mode, m.dungeons, m.dungeonQuests]), [['skip', '', 'all']]);
	assert.deepEqual(modesOf(compiled, 'Alliance', { dungeons: true }).map((m) => [m.mode, m.dungeons, m.dungeonQuests]), [['skip', '', 'all'], ['run', 'all', 'all'], ['run-way', 'all', 'way']]);
});

// A made-up audit: one guide's means, one branch with one zone.
function audit({ score = {}, zone = {}, branch = {} } = {}) {
	const mean = { quests: 20, flow_cost_min: 1, retrace_min: 2, hub_zigzag_yd: 0, passed_givers_near: 1, passed_enders: 0, deferred: 0, missed_merges: 0,
		backtracks_avoidable: 0, reversals: 3, thin_hub_visits: 1, ...score };
	return {
		guides: { 'forever/horde/a': { mean } },
		branches: [{ branch: 'Orc/WARRIOR', hours: 80, log_max: 20, carried_far: 5, carried_hours: 100, ...branch, zones: { Z: {
			quests: 20, flow_cost_min: 1, retrace_km: 1, hub_zigzag_yd: 0, passed_givers_near: 1, passed_enders: 0, deferred: 0, missed_merges: 0,
			backtracks_avoidable: 0, backtracks: 2, reversals: 3, thin_hub_visits: 1, hub_revisits_avoidable: 0, hub_visits: 4, hub_interactions: 9, ...zone,
		} } }],
	};
}

test('the gate fails a guide or a branch worse than before, and a stated reason accepts it', () => {
	const before = audit();
	assert.deepEqual(compare(before, audit()).fail, []);
	// two more givers passed: the guide's score and passed givers, and the branch is unchanged
	const worse = audit({ score: { passed_givers_near: 3 } });
	assert.deepEqual(compare(before, worse).fail.map((f) => f.check), ['score', 'passed_givers_near']);
	// one more quest carried far, an avoidable backtrack on the branch
	const branch = audit({ branch: { carried_far: 6 }, zone: { backtracks_avoidable: 1 } });
	assert.deepEqual(compare(before, branch).fail.map((f) => [f.check, f.branch]), [['back_and_forth', 'Orc/WARRIOR'], ['carried_far', 'Orc/WARRIOR']]);
	// a reason for one of them, in this mode and faction only
	const reasons = [{ check: 'carried_far', branch: '*', mode: 'skip', faction: 'Horde', reason: 'kept for the next zone on purpose' }];
	const res = compare(before, branch, reasons, { mode: 'skip', faction: 'Horde' });
	assert.deepEqual(res.fail.map((f) => f.check), ['back_and_forth']);
	assert.deepEqual(res.accepted.map((f) => [f.check, f.reason]), [['carried_far', 'kept for the next zone on purpose']]);
	assert.equal(compare(before, branch, reasons, { mode: 'run', faction: 'Horde' }).fail.length, 2);
	// small knock-on changes stay under the tolerances
	assert.deepEqual(compare(before, audit({ score: { passed_givers_near: 1.2 }, branch: { carried_hours: 104 } })).fail, []);
});

test('with dungeons on Run, detours and carried quests are reported, not gated; walked-past enders, stranded quests and a full log fail', () => {
	const run = (x) => ({ ...audit(x), dungeons: 'all' });
	const before = run();
	// the route takes every dungeon quest it can: more walking and quests carried to the run don't fail
	const detours = run({ zone: { flow_cost_min: 30, retrace_km: 3 }, branch: { carried_far: 9, carried_hours: 160 } });
	assert.deepEqual(compare(before, detours).fail, []);
	// an ender walked past with the quest done, and a quest never handed in, do
	const res = compare(before, run({ score: { passed_enders: 1 }, branch: { never_handed: 1 } }));
	assert.deepEqual(res.fail.map((f) => f.check), ['passed_enders', 'never_handed']);
	assert.equal(res.kind, 'run');
	// a log over the game's 40 fails in every mode, even when the shipped guides had it too
	assert.deepEqual(compare(audit({ branch: { log_max: 41 } }), audit({ branch: { log_max: 41 } })).fail.map((f) => f.check), ['log_cap']);
	assert.deepEqual(compare(run(), run({ branch: { log_max: 42 } })).fail.map((f) => f.check), ['log_cap']);
});

test('a guide whose quests changed by more than a quarter is compared through its branches only', () => {
	const res = compare(audit(), audit({ score: { quests: 30, passed_givers_near: 4 } }));
	assert.deepEqual(res.fail, []);
	assert.deepEqual(res.restructured, [{ guide: 'forever/horde/a', before: 20, after: 30 }]);
});

test('a reason names the guide or branch it accepts, or all of them with "*"; "run*" holds in every dungeons-on-Run mode', () => {
	const f = { check: 'score', guide: 'forever/horde/a' };
	assert.ok(reasonFor(f, [{ check: 'score', guide: 'forever/horde/a', reason: 'r' }], {}));
	assert.ok(reasonFor(f, [{ check: 'score', guide: '*', reason: 'r' }], {}));
	assert.equal(reasonFor(f, [{ check: 'score', reason: 'r' }], {}), null);
	assert.equal(reasonFor(f, [{ check: 'score', guide: 'forever/horde/b', reason: 'r' }], {}), null);
	const run = [{ check: 'score', guide: '*', mode: 'run*', reason: 'r' }];
	assert.ok(reasonFor(f, run, { mode: 'run+riverglades' }));
	assert.equal(reasonFor(f, run, { mode: 'riverglades' }), null);
});

test('numbers round as the audit always printed them: an exact tie goes to the even digit', () => {
	assert.equal(pyRound(0.125, 2), 0.12);
	assert.equal(pyRound(0.375, 2), 0.38);
	assert.equal(pyRound(2.5), 2);
	assert.equal(pyRound(0.15, 1), 0.1);
	assert.equal(pyRound(1234.5678, 1), 1234.6);
});
