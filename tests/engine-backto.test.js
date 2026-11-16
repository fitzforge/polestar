'use strict';
// A step's `backto` (pack format 11; docs/GUIDE_FORMAT.md, "Going back") in the real Engine:
// once the step is done, the route goes back to the labelled step and the steps from there
// through it open again, while the predicate holds. A round opens a repeatable quest's kept
// hand-in again for its guide (tests/engine-handed.test.js). Each guide is compiled from the
// fixture data and played against the stub world as a level-5 character
// (tests/helpers/play-guide.js). The compiler side: tests/dsl-backto.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { playGuide, statuses, SAVED_ID } = require('./helpers/play-guide');

// Quest 783 taken and handed in again and again, until level 6.
const ROUND = [
	'step Take it', '  label round', '  accept 783',
	'step Hand it in', '  turnin 783', '  backto round when level<6',
	'step Then', '  task "Go on"',
];
const REPEATABLE = 'w.repeatable[783] = true';

test('a repeatable quest goes round until the predicate stops holding', () => {
	const [start, taken, again, second, done] = playGuide(ROUND,
		`snap()
		w.accept(783, {})
		snap()
		w.turnIn(783)
		snap()
		w.accept(783, {})
		w.turnIn(783)
		snap()
		w.accept(783, {})
		w.setLevel(6)
		w.turnIn(783)
		snap()`, REPEATABLE);
	assert.equal(start.live, 1);
	assert.equal(taken.live, 2);
	assert.equal(again.live, 1, 'handed in below level 6: back to the accept');
	assert.notEqual(statuses(again, 1)[0], 'done', 'the accept is open again');
	assert.notEqual(statuses(again, 2)[0], 'done', 'and so is the hand-in');
	assert.equal(second.live, 1, 'a second round');
	assert.equal(done.live, 3, 'level 6: the route goes on');
});

test('a round with nothing to do twice goes on: a quest the game flags as completed', () => {
	const [once] = playGuide(ROUND, `w.accept(783, {})
		w.turnIn(783)
		snap()`);
	assert.equal(once.live, 3);
});

test('without a predicate the round repeats until its steps no longer apply', () => {
	const lines = [
		'step Take it', '  label round', '  when level<6', '  accept 783',
		'step Hand it in', '  when level<6', '  turnin 783', '  backto round',
		'step Then', '  task "Go on"',
	];
	const [again, done] = playGuide(lines, `w.accept(783, {})
		w.turnIn(783)
		snap()
		w.accept(783, {})
		w.setLevel(6)
		snap()`, REPEATABLE);
	assert.equal(again.live, 1);
	assert.equal(done.live, 3, 'the steps of the round no longer apply');
});

test('a tick starts the round again: the tick is forgotten with the round', () => {
	const lines = ['step Farm', '  label farm', '  task "Clear the camp"', 'step Back for more', '  task "Go round again"', '  backto farm', 'step Then', '  task "Go on"'];
	const [one, two, back] = playGuide(lines, `stub.fire("QUEST_LOG_UPDATE")
		E.ToggleGoal(1, 1)
		snap()
		E.ToggleGoal(2, 1)
		snap()
		E.ToggleGoal(1, 1)
		snap()`);
	assert.equal(one.live, 2);
	assert.equal(two.live, 1, 'ticking the second step opens the first again');
	assert.notEqual(statuses(two, 2)[0], 'done');
	assert.equal(back.live, 2);
});

test('the player leaves a round by skipping the step that goes back', () => {
	const [again, left] = playGuide(ROUND, `w.accept(783, {})
		w.turnIn(783)
		snap()
		w.accept(783, {})
		snap()
		E.Skip()
		snap()`, REPEATABLE).filter((_, i) => i !== 1);
	assert.equal(again.live, 1);
	assert.equal(left.live, 3, 'the hand-in step skipped: the route goes on');
});

test('a round of one step: a direct hand-in repeated while the bags hold another round\'s worth', () => {
	// Two pieces of meat a hand-in: six in the bags are three hand-ins.
	const lines = ['step Two at a time', '  label again', '  turnin 783 direct', '  backto again when has 750 x2', 'step Then', '  task "Go on"'];
	const out = playGuide(lines, `local function left(n)
			w.items[750] = n > 0 and n or nil
			stub.fire("BAG_UPDATE", 0)
			stub.fire("BAG_UPDATE_DELAYED")
		end
		snap()
		left(4) w.turnIn(783)
		snap()
		left(2) w.turnIn(783)
		snap()
		left(0) w.turnIn(783)
		snap()`, `${REPEATABLE}; w.items[750] = 6`);
	assert.deepEqual(out.map((o) => o.live), [1, 1, 1, 2]);
	assert.deepEqual(out.slice(0, 3).map((o) => statuses(o, 1)[0] === 'done'), [false, false, false], 'open again after each hand-in while two are left');
});

const PLAIN = ['step Take it', '  accept 783', 'step Hand it in', '  turnin 783', 'step Then', '  task "Go on"'];

test('a round reads the hand-in kept for its guide after a reload: it opens it again while its predicate holds, and stays ended once it ended', () => {
	const LOG = 'stub.fire("QUEST_LOG_UPDATE") snap()';
	const stored = `PolestarCharDB = { schema = 1, handed = { ["${SAVED_ID}"] = { [783] = true } } }`;
	const [plain] = playGuide(PLAIN, LOG, REPEATABLE, stored);
	assert.equal(plain.live, 3, 'without a round the stored hand-in stands (tests/engine-handed.test.js)');
	const [round] = playGuide(ROUND, LOG, REPEATABLE, stored);
	assert.equal(round.live, 1, 'a round whose predicate holds opens it again');
	const [over] = playGuide(ROUND, LOG, `${REPEATABLE}; w.level = 6`, stored);
	assert.equal(over.live, 3, 'a round that ended stays ended');
});

test('a step done for good goes back once, then on, and stays so across a reload', () => {
	const lines = ['step Choose', '  label choose', '  task "Choose again"', 'step Take it', '  accept 783', 'step Hand it in', '  turnin 783', '  backto choose', 'step Then', '  task "Go on"'];
	const [back, on, kept] = playGuide(lines, `stub.fire("QUEST_LOG_UPDATE")
		E.ToggleGoal(1, 1)
		w.accept(783, {})
		w.turnIn(783)
		snap()
		E.Skip()
		snap()
		emit({ on = PolestarCharDB.when["${SAVED_ID}"][3] })`);
	assert.equal(back.live, 1, 'the hand-in sends the route back to the choice');
	assert.notEqual(statuses(back, 1)[0], 'done');
	assert.equal(on.live, 4, 'the choice skipped: the hand-in, done for good, sends nobody back again');
	assert.equal(kept.on, 'on');
	const saved = (when) => `PolestarCharDB = { schema = 1, skipped = { ["${SAVED_ID}"] = { [1] = true } }, when = { ["${SAVED_ID}"] = { ${when} } } }`;
	const [later] = playGuide(lines, 'stub.fire("QUEST_LOG_UPDATE") snap()', 'w.completed[783] = true', saved('[3] = "on"'));
	assert.equal(later.live, 4);
	const [asked] = playGuide(lines, 'stub.fire("QUEST_LOG_UPDATE") snap()', 'w.completed[783] = true', saved(''));
	assert.equal(asked.live, 1, 'without the stored outcome the hand-in would send the route back at every login');
});

test('rounds inside a round: a hand-in done for good stays passed when the wider round opens again', () => {
	const lines = [
		'step Choose', '  label choose', '  task "Choose"', 'step Told', '  label told', '  backto choose', '  task "Again"',
		'step Take one', '  accept 783', 'step Hand one in', '  turnin 783', '  backto told',
		'step Take two', '  accept 7', 'step Hand two in', '  turnin 7', '  backto told', 'step Then', '  task "Go on"',
	];
	const lives = playGuide(lines, `stub.fire("QUEST_LOG_UPDATE")
		E.ToggleGoal(1, 1)
		E.Skip()
		w.accept(783, {}) w.turnIn(783)
		snap()
		E.Skip()
		snap()
		w.accept(7, { 10 }) w.turnIn(7)
		snap()
		E.Skip()
		snap()`).map((o) => o.live);
	assert.deepEqual(lives, [2, 5, 2, 7]);
});

test('a hand-in still in the log holds the round: it opens once the quest has left, and no quest reads as lost', () => {
	const [held, open, asked] = playGuide(ROUND, `w.accept(783, {})
		snap()
		stub.fire("QUEST_TURNED_IN", 783, 0, 0)
		snap()
		w.log[783] = nil
		stub.fire("QUEST_REMOVED", 783, false)
		stub.fire("QUEST_LOG_UPDATE")
		snap()
		emit({ lost = E.LostQuestion() or 0 })`, REPEATABLE).slice(1);
	assert.equal(held.live, 2, 'handed in, the quest not out of the log yet: the step stays');
	assert.equal(statuses(held, 2)[0], 'done', 'done, and not opened again yet');
	assert.equal(open.live, 1);
	assert.notEqual(statuses(open, 1)[0], 'done');
	assert.equal(asked.lost, 0);
});

test('a hand-in is no quest lost, but a quest of the round abandoned in a later round is', () => {
	const out = playGuide(ROUND, `w.accept(783, {})
		w.turnIn(783)
		snap()
		emit({ lost = E.LostQuestion() or 0 })
		w.accept(783, {})
		snap()
		w.abandon(783)
		snap()
		emit({ lost = E.LostQuestion() or 0 })`, REPEATABLE);
	assert.equal(out[0].live, 1);
	assert.equal(out[1].lost, 0);
	assert.equal(out[2].live, 2);
	assert.equal(out[4].lost, 783, 'abandoned in the second round: asked as in the first');
});

test('a round opened again is forgotten with the guide\'s progress: a reset starts from the first hand-in', () => {
	const [again, reset] = playGuide(ROUND, `w.accept(783, {})
		w.turnIn(783)
		snap()
		emit({ stored = tostring(PolestarCharDB.handed["${SAVED_ID}"][783]) })
		E.ResetProgress()
		emit({ stored = PolestarCharDB.handed["${SAVED_ID}"] and 1 or 0 })`, REPEATABLE).filter((o) => o.stored !== undefined);
	assert.equal(again.stored, 'false', 'opened again for this guide, whatever the session saw');
	assert.equal(reset.stored, 0);
});

test('a quest handed in for good is still done without anything stored: the client decides first', () => {
	const [done] = playGuide(PLAIN, 'stub.fire("QUEST_LOG_UPDATE") snap()', 'w.completed[783] = true', `PolestarCharDB = { schema = 1, handed = { ["${SAVED_ID}"] = { [783] = false } } }`);
	assert.equal(done.live, 3, 'a stored "open again" never hides a quest the game flags as completed');
});

test('a step with `when` whose backto went on keeps its outcome when it opens again', () => {
	const lines = ['step A', '  label a', '  task "First"', 'step B', '  when level<6', '  task "Second"', '  backto a when has 750 x99', 'step Then', '  task "Go on"'];
	const [on, open] = playGuide(lines, `stub.fire("QUEST_LOG_UPDATE")
		E.ToggleGoal(1, 1)
		E.ToggleGoal(2, 1)
		snap()
		w.setLevel(6)
		E.ToggleGoal(2, 1)
		snap()`);
	assert.equal(on.live, 3);
	assert.equal(open.live, 2, 'unticked above the level: the step the route had passed stays');
});

test('Guides.Validate reads `backto` and refuses a malformed one', () => {
	const [out] = playGuide(['step One', '  task "A"'], `local V = Polestar.Guides.Validate
		local G = { { t = "task", text = "A" } }
		local function def(steps) return { id = "test/v", title = "V", steps = steps } end
		emit({
			ok = V(def({ { label = "a", goals = G }, { backto = { to = "a", when = { k = "has", item = 750, n = 1 } }, goals = G } })) == nil
				and V(def({ { label = "a", backto = { to = "a" }, goals = G } })) == nil,
			ahead = V(def({ { backto = { to = "b" }, goals = G }, { label = "b", goals = G } })) or "",
			nowhere = V(def({ { backto = { to = "nowhere" }, goals = G } })) or "",
			noTable = V(def({ { label = "a", backto = "a", goals = G } })) or "",
			group = V(def({ { label = "a", backto = { to = "a", when = { k = "group", q = 7 } }, goals = G } })) or "",
			along = V(def({ { label = "a", goals = G }, { along = true, backto = { to = "a" }, goals = G } })) or "",
			badWhen = V(def({ { label = "a", backto = { to = "a", when = { k = "bogus" } }, goals = G } })) or "",
		})`);
	assert.equal(out.ok, true);
	for (const k of ['ahead', 'nowhere', 'noTable', 'group', 'along', 'badWhen']) assert.match(out[k], /bad backto/, k);
});
