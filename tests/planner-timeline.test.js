'use strict';
// The planner's playback (tools/lib/planner/timeline.js): clock, XP, skips,
// travel and the route through `next`.

const test = require('node:test');
const assert = require('node:assert');
const path = require('node:path');
const { compile, fixtureData, guideText } = require('./helpers/dsl');
const { needs, DATA } = require('./helpers/data');
const { buildTimeline, routeOf, loadParams, MODES } = require('../tools/lib/planner/timeline');
const { Geo } = require('../tools/lib/planner/geo');

// Priors only (no calibration file), the Warrior's class factor.
const PARAMS = loadParams({ simDir: path.join(__dirname, 'no-such-sim-dir'), cls: 'WARRIOR' });
const HUMAN = { race: 'Human', cls: 'WARRIOR', faction: 'Alliance' };

// Compiled guides by id; `strict`: the guides must compile without errors.
function guidesOf(sources, strict = true) {
	const { guides, errors } = compile(sources);
	if (strict) assert.deepStrictEqual(errors, []);
	return new Map(guides.map((g) => [g.id, g]));
}

function play(lines, { strict = true, ...opts } = {}) {
	const guides = guidesOf(guideText(lines), strict);
	const data = fixtureData();
	return buildTimeline({
		guides, data, geo: new Geo(data.mapFrames, data.zones), params: PARAMS, travel: {}, questXp: null,
		start: 't/main', character: HUMAN, ...opts,
	});
}

const goalAt = (tl, line) => tl.steps.flatMap((s) => s.goals).find((g) => g.line === line);

test('time and the track only move forward, and every step covers its samples', () => {
	const tl = play([
		'step Kobolds',
		'  accept 7',
		'  goto 47.6,35.1 "Kobold camp"',
		'  kill 6 x10 quest 7.1',
		'step Back',
		'  turnin 7',
	]);
	const { t, c, x, y, m } = tl.track;
	assert.ok(t.length > 10);
	assert.strictEqual(new Set([t.length, c.length, x.length, y.length, m.length]).size, 1);
	for (let i = 1; i < t.length; i++) assert.ok(t[i] >= t[i - 1], `track time goes back at ${i}`);
	for (let i = 1; i < tl.events.length; i++) assert.ok(tl.events[i].t >= tl.events[i - 1].t);
	let prevEnd = 0;
	for (const s of tl.steps) {
		assert.ok(s.start >= prevEnd && s.end >= s.start);
		assert.ok(s.k0 <= s.k1 && s.k1 < t.length);
		assert.ok(t[s.k1] <= s.end + 1e-9);
		prevEnd = s.end;
	}
	assert.ok(m.includes(MODES.walk) && m.includes(MODES.fight));
	assert.strictEqual(tl.totals.quests, 1);
	assert.ok(Math.abs(tl.totals.seconds - tl.steps[tl.steps.length - 1].end) < 0.01);
	// The step state is the character at the step's start.
	const back = tl.steps[1].state.log.find((q) => q.id === 7);
	assert.deepStrictEqual(back.objectives, [{ text: 'Kobold Vermin slain', cur: 10, max: 10 }]);
	assert.strictEqual(back.ready, true);
});

test('a turn-in pays the quest XP and each level gained waits levelOverhead', () => {
	const tl = play(['step Veteran', '  accept 9300', '  turnin 9300']);
	const turnin = goalAt(tl, 9);
	// 1500 XP from level 1: 400 to level 2, 900 to level 3, 200 into level 3.
	assert.strictEqual(turnin.xp, 1500 * PARAMS.questXpScale);
	assert.deepStrictEqual(tl.steps[0].dings, [2, 3]);
	assert.strictEqual(tl.totals.level, 3);
	assert.strictEqual(tl.totals.xp, 200);
	assert.strictEqual(turnin.split.wait, 2 * PARAMS.levelOverhead);
	assert.strictEqual(turnin.split.interact, PARAMS.talkSec);
	assert.deepStrictEqual(tl.events.filter((e) => e.type === 'ding').map((e) => e.level), [2, 3]);
	const ev = tl.events.find((e) => e.type === 'turnin');
	assert.strictEqual(ev.gain, 1500);
	assert.strictEqual(ev.level, 3);
});

test('a turn-in of a quest never accepted is skipped', () => {
	// The compiler already flags this line; the planner still plays the guide.
	const tl = play(['step Turn in', '  turnin 9300'], { strict: false });
	const g = goalAt(tl, 8);
	assert.strictEqual(g.skip, 'quest not in log');
	assert.strictEqual(g.xp, 0);
	assert.strictEqual(g.end - g.start, 0);
	assert.strictEqual(tl.totals.level, 1);
});

test('`only` and the quest class mask exclude a goal for another class', () => {
	const tl = play(['step Errands', '  accept 9500 only Hunter', '  accept 9101', '  accept 9201']);
	const [onlyHunter, hunterQuest, open] = tl.steps[0].goals;
	assert.strictEqual(onlyHunter.applies, false);
	assert.strictEqual(onlyHunter.skip, 'not for this character');
	assert.strictEqual(hunterQuest.applies, false);
	assert.strictEqual(open.applies, true);
	assert.deepStrictEqual(tl.events.filter((e) => e.type === 'accept').map((e) => e.quest.id), [9201]);
});

test('hearth teleports to the bind point and waits out the cooldown', () => {
	const tl = play([
		'step Bind',
		'  sethome "Goldshire" npc 295',
		'step Out',
		'  goto 48.9,41.6',
		'step Home',
		'  hearth "Goldshire"',
		'step Out again',
		'  goto 48.9,41.6',
		'step Home again',
		'  hearth "Goldshire"',
	]);
	const bind = tl.events.find((e) => e.type === 'bind');
	assert.ok(bind);
	const [first, second] = tl.steps.filter((s) => s.title.startsWith('Home'));
	for (const s of [first, second]) {
		const k = s.k1;
		assert.strictEqual(tl.track.m[k], MODES.teleport);
		assert.ok(Math.abs(tl.track.x[k] - bind.wx) < 0.2 && Math.abs(tl.track.y[k] - bind.wy) < 0.2);
	}
	assert.strictEqual(first.goals[0].split.wait, 0);
	assert.strictEqual(second.state.hearthReady, false);
	const hearths = tl.events.filter((e) => e.type === 'hearth');
	assert.strictEqual(hearths.length, 2);
	// The second cast starts when the stone is ready again.
	assert.ok(Math.abs(hearths[1].t - (hearths[0].readyAt + PARAMS.hearthCast)) < 0.02);
	assert.ok(second.goals[0].split.wait > 0);
	assert.ok(tl.warnings.some((w) => /cooldown/.test(w.message)));
});

test('hearth without a bind point is skipped with a warning', () => {
	const tl = play(['step Home', '  hearth "Goldshire"']);
	assert.strictEqual(tl.steps[0].goals[0].skip, 'no bind point');
	assert.ok(tl.warnings.some((w) => /bind/.test(w.message)));
});

test('a kill goal takes combat time in proportion to its count', () => {
	// Level 10: Kobold Vermin (level 1) are grey, so no level changes the kill time.
	const tl = play(['step Few', '  kill 6 x2', 'step Many', '  kill 6 x8'], { startLevel: 10 });
	const [few, many] = tl.steps.map((s) => s.goals[0]);
	assert.ok(few.split.combat > 0);
	assert.ok(Math.abs(many.split.combat / few.split.combat - 4) < 1e-3);
	assert.ok(Math.abs(few.kills - 2 * (1 + PARAMS.extraKill)) < 0.01);
	assert.strictEqual(few.spawns.kind, 'npc');
	assert.strictEqual(few.spawns.id, 6);
	assert.strictEqual(tl.events.filter((e) => e.type === 'kill' && e.s === 1).length, Math.ceil(8 * (1 + PARAMS.extraKill)));
});

test('routeOf follows the chosen route and falls back to the first option the character can follow', () => {
	const head = (id, extra) => [`guide ${id}`, `title ${id}`, 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', ...extra, '', 'step S', '  goto 48.9,41.6', ''].join('\n');
	const guides = guidesOf({
		'a.guide': head('t/a', ['next t/b, t/c']),
		'b.guide': head('t/b', ['race Human']),
		'c.guide': head('t/c', []),
	});
	const dwarf = { race: 'Dwarf', cls: 'WARRIOR', faction: 'Alliance' };
	assert.deepStrictEqual(routeOf({ guides, start: 't/a', character: HUMAN }), ['t/a', 't/b']);
	assert.deepStrictEqual(routeOf({ guides, start: 't/a', character: HUMAN, choices: { 't/a': 't/c' } }), ['t/a', 't/c']);
	assert.deepStrictEqual(routeOf({ guides, start: 't/a', character: dwarf }), ['t/a', 't/c']);
	// A choice the character cannot follow falls back as well.
	assert.deepStrictEqual(routeOf({ guides, start: 't/a', character: dwarf, choices: { 't/a': 't/x' } }), ['t/a', 't/c']);
	assert.deepStrictEqual(routeOf({ guides, start: 't/a', character: dwarf, choices: { 't/a': 't/b' } }), ['t/a', 't/c']);
});

test('optional goals without quest work are skipped unless the playback plays them', () => {
	const lines = ['step Kobolds', '  kill 6 x4 optional', '  goto 48.9,41.6'];
	const g = play(lines).steps[0].goals[0];
	assert.strictEqual(g.skip, 'optional');
	assert.strictEqual(g.end - g.start, 0);
	assert.strictEqual(g.kills, 0);
	const played = play(lines, { optional: true }).steps[0].goals[0];
	assert.strictEqual(played.skip, null);
	assert.ok(played.split.combat > 0 && played.kills > 0);
	// Optional quest goals play by default.
	const tl = play(['step Veteran', '  accept 9300 optional', '  turnin 9300 optional']);
	assert.deepStrictEqual(tl.steps[0].goals.map((x) => x.skip), [null, null]);
	assert.strictEqual(tl.steps[0].goals[1].xp, 1500 * PARAMS.questXpScale);
});

// The fixture data with extra quests (by id) at Marshal McBride (197).
function withQuests(extra) {
	const base = fixtureData();
	const data = Object.create(base);
	data.quest = (id) => (extra[id] ? { ...base.quest(7), pre: [], objectives: [], objectiveText: '', xp: null, ...extra[id], id: Number(id) } : base.quest(id));
	return data;
}

function playWith(data, lines, opts = {}) {
	const { guides, errors } = compile(guideText(lines), data);
	assert.deepStrictEqual(errors, []);
	return buildTimeline({
		guides: new Map(guides.map((g) => [g.id, g])), data, geo: new Geo(data.mapFrames, data.zones), params: PARAMS, travel: {}, questXp: null,
		start: 't/main', character: HUMAN, ...opts,
	});
}

test('an escort always takes escortSec; an exploration completes on arrival', () => {
	const at = { map: 1429, x: 40, y: 60 };
	const data = withQuests({
		9901: { title: 'Escort Duty', objectiveText: 'Escort the farmer home.', objectives: [{ type: 'event', count: 1, text: 'Farmer escorted', ...at }] },
		9902: { title: 'Scouting', objectiveText: 'Explore the hills.', objectives: [{ type: 'event', count: 1, text: 'Hills explored', ...at }] },
	});
	const tl = playWith(data, ['step Escort', '  accept 9901', '  complete 9901', 'step Scout', '  accept 9902', '  complete 9902']);
	const [escort, explore] = tl.steps.map((s) => s.goals[1]);
	assert.strictEqual(escort.split.combat, PARAMS.escortSec);
	assert.strictEqual(explore.split.combat, 0);
	assert.ok(explore.split.travel > 0);
	assert.ok(tl.events.some((e) => e.type === 'ready' && e.quest === 9902));
});

test('a quest level of 0 or less counts as unknown', () => {
	const data = withQuests({ 9903: { title: 'Odd', level: -1, minLevel: 10 }, 9904: { title: 'Same', level: 10, minLevel: 10 } });
	const xpOf = (id) => playWith(data, ['step Q', `  accept ${id}`, `  turnin ${id}`], { startLevel: 10 }).steps[0].goals[1].xp;
	assert.ok(xpOf(9903) > 0);
	assert.strictEqual(xpOf(9903), xpOf(9904));
});

// A deterministic route provider: a dog-leg through a point 5 yd off the
// middle, walked then swum, 100 s per leg; `fail(b)` legs answer not ok.
function fakeRoutes({ fail = () => false, pending = false } = {}) {
	const calls = [];
	const routes = (a, b, profile) => {
		calls.push({ a, b, profile });
		if (pending) return null;
		if (fail(b)) return { ok: false, reason: 'no path' };
		const mx = (a.wx + b.wx) / 2 + 5;
		const my = (a.wy + b.wy) / 2;
		const d1 = Math.hypot(mx - a.wx, my - a.wy);
		const d2 = Math.hypot(b.wx - mx, b.wy - my);
		return {
			ok: true, pts: [a.wx, a.wy, 0, mx, my, 0, b.wx, b.wy, 0], cls: [0, 2], yards: d1 + d2, seconds: 100,
			byClass: { walk: 60, swim: 40 }, falls: [{ h: 20, damage: 0.12 }],
		};
	};
	return { routes, calls };
}

const CAMP = 9; // the goto's line (the header takes lines 1-6)
const ROUTE_LINES = ['step Kobolds', '  accept 7', '  goto 47.6,35.1 "Kobold camp"', '  kill 6 x10 quest 7.1', 'step Back', '  turnin 7'];

test('routed walk legs take the route\'s seconds and follow its points', () => {
	const { routes, calls } = fakeRoutes();
	const tl = play(ROUTE_LINES, { routes, nav: { build: 'test' } });
	const tt = tl.totals;
	assert.ok(tt.legs > 0);
	assert.strictEqual(tt.routed, tt.legs);
	assert.ok(tt.hops > 0);
	assert.strictEqual(tt.hopsRouted, tt.hops);
	// Legs take 100 s each; hops 100 s each, a fractional last kill a share.
	assert.ok(tt.routeSeconds > 100 * tt.legs && tt.routeSeconds <= 100 * (tt.legs + tt.hops) + 0.01, `routeSeconds ${tt.routeSeconds}`);
	assert.strictEqual(tt.estimateSeconds, 0);
	assert.strictEqual(calls.length, tt.legs + tt.hops);
	assert.deepStrictEqual(tl.nav, { build: 'test' });
	// The profile is move.js's for the character at its level.
	assert.strictEqual(calls[0].profile.name, 'warrior 1');
	const camp = goalAt(tl, CAMP);
	assert.strictEqual(camp.split.travel, 100);
	assert.ok(!camp.estimate);
	assert.strictEqual(camp.route.byClass.walk, 60);
	assert.strictEqual(camp.route.byClass.swim, 40);
	assert.deepStrictEqual(camp.route.falls, [{ h: 20, damage: 0.12 }]);
	// The track passes the route's middle point, swimming from it on.
	const { t, x, m } = tl.track;
	assert.ok(m.includes(MODES.swim));
	const k = m.indexOf(MODES.swim);
	assert.strictEqual(m[k - 1], MODES.walk);
	for (let i = 1; i < t.length; i++) assert.ok(t[i] >= t[i - 1]);
	// 60 s of walk then 40 s of swim along the leg (seconds per class, shared by length).
	assert.ok(Math.abs(t[k] - t[k - 1] - 40) < 0.02, `swim segment ${t[k] - t[k - 1]}`);
	assert.ok(x.length === t.length);
	assert.ok(tl.steps.every((s) => !s.estimate || s.goals.every((g) => !g.routeReason)));
});

test('a leg the provider cannot route keeps the straight-line estimate and is marked', () => {
	const plain = play(ROUTE_LINES);
	const campAt = goalAt(plain, CAMP).at;
	const { routes } = fakeRoutes({ fail: (b) => Math.abs(b.wx - campAt.wx) < 1 && Math.abs(b.wy - campAt.wy) < 1 });
	const tl = play(ROUTE_LINES, { routes });
	const camp = goalAt(tl, CAMP);
	assert.strictEqual(camp.estimate, true);
	assert.strictEqual(camp.routeReason, 'no path');
	assert.ok(!camp.route);
	assert.strictEqual(tl.steps[0].estimate, true);
	// Straight: the same travel time as without a provider.
	assert.strictEqual(camp.split.travel, goalAt(plain, CAMP).split.travel);
	assert.strictEqual(tl.totals.legs, plain.totals.legs);
	assert.strictEqual(tl.totals.routed, tl.totals.legs - 1);
	assert.ok(Math.abs(tl.totals.estimateSeconds - camp.split.travel) < 0.02);
	// Without a provider every leg is straight and nothing is marked.
	assert.strictEqual(plain.totals.routed, 0);
	assert.ok(plain.totals.legs > 0);
	assert.ok(!goalAt(plain, CAMP).estimate);
	assert.strictEqual(plain.nav, null);
});

test('legs the provider does not know yet are pending straight lines', () => {
	const { routes, calls } = fakeRoutes({ pending: true });
	const tl = play(ROUTE_LINES, { routes });
	assert.strictEqual(tl.totals.routed, 0);
	assert.strictEqual(tl.totals.hopsRouted, 0);
	assert.strictEqual(calls.length, tl.totals.legs + tl.totals.hops);
	assert.strictEqual(goalAt(tl, CAMP).routeReason, 'pending');
	// Pending hops keep the spacing model: the clock is the straight-line one.
	assert.strictEqual(tl.totals.seconds, play(ROUTE_LINES).totals.seconds);
	assert.strictEqual(goalAt(tl, CAMP + 1).routeReason, 'pending');
});

test('hops between spawns in a kill area follow their routes in fight mode', () => {
	const plain = play(ROUTE_LINES);
	const { routes } = fakeRoutes();
	const tl = play(ROUTE_LINES, { routes });
	const kill = goalAt(tl, CAMP + 1);
	assert.strictEqual(kill.verb, 'kill');
	assert.ok(!kill.estimate);
	// The hops took the fake route's 100 s each (a share for a fractional last
	// kill; a hop back to the spawn just left costs no walk) instead of the
	// spacing model's walk; combat time is unchanged.
	assert.ok(kill.split.travel >= 300 && kill.split.travel > goalAt(plain, CAMP + 1).split.travel * 5, `travel ${kill.split.travel}`);
	assert.strictEqual(kill.split.combat, goalAt(plain, CAMP + 1).split.combat);
	// The hop's middle point (5 yd off the straight line) is on the track, in fight mode.
	const { t, x, y, m } = tl.track;
	const s = tl.steps[0];
	let bends = 0;
	for (let j = s.k0 + 1; j < s.k1; j++) {
		if (m[j] !== MODES.fight || m[j + 1] !== MODES.fight || t[j] <= t[j - 1]) continue;
		const mx = (x[j - 1] + x[j + 1]) / 2 + 5;
		const my = (y[j - 1] + y[j + 1]) / 2;
		if (Math.abs(x[j] - mx) < 0.2 && Math.abs(y[j] - my) < 0.2) bends++;
	}
	assert.ok(bends > 0, 'hops bend through their route points');
	// Without a provider hops are counted, none routed.
	assert.ok(plain.totals.hops > 0);
	assert.strictEqual(plain.totals.hopsRouted, 0);
});

test('a flight follows its taxi path points and keeps the flight time', () => {
	const geo = new Geo(fixtureData().mapFrames, fixtureData().zones);
	const home = geo.toWorld(1429, 48, 42, 'e');
	const other = geo.toWorld(1429, 60, 70, 'e');
	const node = (id, w, name) => ({ id, name, short: name, c: w.c, wx: w.wx, wy: w.wy, map: 1429, x: 0, y: 0, faction: 3 });
	const travel = { taxi: { nodes: [node(1, home, 'One'), node(2, other, 'Two')], legs: [{ path: 77, from: 1, to: 2, yards: 1200 }] } };
	const mid = [(home.wx + other.wx) / 2 + 300, (home.wy + other.wy) / 2];
	const flightPaths = new Map([[77, [[home.wx, home.wy], mid, [other.wx, other.wy]]]]);
	const lines = ['step Fly', '  goto 48.0,42.0', '  fly "Two"'];
	const straight = play(lines, { travel, strict: false });
	const tl = play(lines, { travel, flightPaths, strict: false });
	const fly = (x) => x.steps[0].goals[1];
	assert.strictEqual(fly(tl).split.travel, fly(straight).split.travel);
	assert.ok(Math.abs(fly(tl).split.travel - (PARAMS.flightOverhead + 1200 / 30 + 2)) < 0.05, `flight ${fly(tl).split.travel}`);
	const { x, y, m } = tl.track;
	const at = x.findIndex((v, k) => m[k] === MODES.fly && Math.abs(v - Math.round(mid[0] * 10) / 10) < 0.2 && Math.abs(y[k] - Math.round(mid[1] * 10) / 10) < 0.2);
	assert.ok(at > 0, 'the track passes the path\'s middle point');
	assert.strictEqual(straight.track.m.filter((v) => v === MODES.fly).length, 1);
});

test('a boat whose ends have board points is walked to and from the decks, not the ships\' stops in the water', () => {
	const geo = new Geo(fixtureData().mapFrames, fixtureData().zones);
	const home = geo.toWorld(1429, 48, 42, 'e');
	const far = geo.toWorld(1429, 52, 90, 'e');
	const end = (name, w, dx) => ({ name, c: w.c, wx: w.wx, wy: w.wy, map: 1429, x: 0, y: 0, f: 'e', board: { wx: w.wx + dx, wy: w.wy, z: 5.9 } });
	const travel = {
		taxi: { nodes: [], legs: [] },
		transports: [{ id: 'boat-test', kind: 'boat', faction: 3, ab: 1, ba: 1, waitA: 0, waitB: 0, a: end('Near Pier', home, 12), b: end('Far Pier', far, -12) }],
	};
	const tl = play(['step Sail', '  goto 48.0,42.0', '  goto 52.0,90.0'], { travel, strict: false });
	assert.ok(tl.events.some((e) => e.type === 'boat'), 'the boat is taken');
	const { x, y, m } = tl.track;
	const near = (k, p) => Math.abs(x[k] - p.wx) < 0.2 && Math.abs(y[k] - p.wy) < 0.2;
	const boat = m.findIndex((v) => v === MODES.boat);
	assert.ok(near(boat, travel.transports[0].b.board), `lands on the far deck: ${x[boat]}, ${y[boat]}`);
	assert.ok(near(boat - 1, travel.transports[0].a.board), `boards from the near deck: ${x[boat - 1]}, ${y[boat - 1]}`);
});

test('the Dwarf chain plays from Dun Morogh to level 55 or more', { skip: needs('quests.json', 'npcs.json', 'objects.json', 'items.json', 'zones.json', 'map-frames.json', 'travel.json') }, () => {
	const { compileProject } = require('../tools/lib/dsl/project');
	const root = path.join(__dirname, '..');
	const { guides: list, data } = compileProject({ packDir: path.join(root, 'guides'), manifest: { id: 'guides', author: 'Polestar' }, dataDir: DATA });
	const guides = new Map(list.map((g) => [g.id, g]));
	const character = { race: 'Dwarf', cls: 'WARRIOR', faction: 'Alliance' };
	const tl = buildTimeline({
		guides, data, geo: new Geo(data.mapFrames, data.zones), params: loadParams({ cls: 'WARRIOR' }), travel: data.travel,
		start: 'forever/alliance/dwarf-gnome/01-dun-morogh', character,
	});
	const json = JSON.stringify(tl);
	assert.ok(!/NaN|Infinity/.test(json), 'no NaN or Infinity');
	assert.ok(tl.totals.level >= 55, `level ${tl.totals.level}`);
	assert.ok(Number.isFinite(tl.totals.seconds) && tl.totals.seconds > 0);
	assert.ok(tl.guides.length > 10);
	assert.strictEqual(JSON.stringify(JSON.parse(json)), json);
});
