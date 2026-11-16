'use strict';
// A repeatable quest's hand-in in the real Engine: the client never flags such a quest
// completed, so the guide keeps the hand-in itself (CharState().handed, Engine.lua Own.handed)
// and the quest's steps stay done after a reload. Each guide is compiled from the fixture data
// and played against the stub world (tests/helpers/play-guide.js).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { playGuide, SAVED_ID } = require('./helpers/play-guide');

const PLAIN = ['step Take it', '  accept 783', 'step Hand it in', '  turnin 783', 'step Then', '  task "Go on"'];
const REPEATABLE = 'w.repeatable[783] = true';
const LOG = 'stub.fire("QUEST_LOG_UPDATE") snap()';

test('a hand-in the client never flags is kept for the guide across a reload', () => {
	const [handed, kept] = playGuide(PLAIN, `w.accept(783, {})
		w.turnIn(783)
		snap()
		emit({ handed = PolestarCharDB.handed["${SAVED_ID}"][783] })`, REPEATABLE);
	assert.equal(handed.live, 3);
	assert.equal(kept.handed, true);
	const [fresh] = playGuide(PLAIN, 'snap()', REPEATABLE);
	assert.equal(fresh.live, 1, 'nothing stored: the quest is to take');
	const [later] = playGuide(PLAIN, LOG, REPEATABLE, `PolestarCharDB = { schema = 1, handed = { ["${SAVED_ID}"] = { [783] = true } } }`);
	assert.equal(later.live, 3, 'the next session reads the stored hand-in');
});

test('the hand-in is kept for the guide it was made in, not for another guide with the same quest', () => {
	const [other] = playGuide(PLAIN, LOG, REPEATABLE, 'PolestarCharDB = { schema = 1, handed = { ["forever/other"] = { [783] = true } } }');
	assert.equal(other.live, 1);
});

// A guide that only hands quest 783 in: its accept is another guide's. The compiler refuses such
// a guide on its own, so this one is registered as compiled, in a pack of its own.
const ORPHAN = `Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
	Polestar.RegisterGuide({ id = "test/orphan", pack = "test", title = "Orphan", minLevel = 1, maxLevel = 10, steps = {
		{ title = "Hand it in", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Then", goals = { { t = "level", level = 9 } } },
	} })
	E.SetGuide("test/orphan")
	stub.fire("QUEST_LOG_UPDATE")
	stub.advance(0.6)
	local function status() return E.GetStepView(1).goals[1].status end`;

test('a hand-in with no accept in the guide is another route\'s work: nothing is stored, and it is forgotten at a reload as before', () => {
	const [out] = playGuide(PLAIN, `${ORPHAN}
		local before = status()
		stub.fire("QUEST_TURNED_IN", 783, 0, 0)
		stub.advance(0.6)
		emit({ before = before, after = status(), stored = PolestarCharDB.handed and PolestarCharDB.handed["test/orphan"] and 1 or 0 })`, REPEATABLE);
	assert.equal(out.before, 'na', 'a turn-in with no accept is orphaned');
	assert.equal(out.after, 'done', 'the session saw the hand-in');
	assert.equal(out.stored, 0);
	const [later] = playGuide(PLAIN, `${ORPHAN}
		emit({ status = status() })`, REPEATABLE);
	assert.equal(later.status, 'na', 'the next session knows nothing of it');
});

test('a quest of no goal of the guide is not stored', () => {
	const [out] = playGuide(PLAIN, `w.accept(7, { 10 })
		w.turnIn(7)
		stub.advance(0.5)
		emit({ stored = PolestarCharDB.handed and 1 or 0 })`, 'w.repeatable[7] = true');
	assert.equal(out.stored, 0);
});

test('resetting the guide opens a repeatable hand-in again', () => {
	const [handed, reset] = playGuide(PLAIN, `w.accept(783, {})
		w.turnIn(783)
		snap()
		E.ResetProgress()
		snap()`, REPEATABLE);
	assert.equal(handed.live, 3);
	assert.equal(reset.live, 1);
});

test('a hand-in the client flags is not kept: the entry is dropped once the client knows', () => {
	const [kept] = playGuide(PLAIN, `stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.5)
		emit({ kept = PolestarCharDB.handed and 1 or 0 })`, 'w.completed[783] = true; w.completed[7] = true',
		`PolestarCharDB = { schema = 1, handed = { ["${SAVED_ID}"] = { [783] = true }, ["forever/other"] = { [7] = true } } }`);
	assert.equal(kept.kept, 0, 'flagged since: nothing left to remember, for this guide or another');
});

test('an ordinary quest handed in is done as before, with or without a reload', () => {
	const [handed] = playGuide(PLAIN, `w.accept(783, {})
		w.turnIn(783)
		snap()`);
	assert.equal(handed.live, 3);
	const [later] = playGuide(PLAIN, LOG, 'w.completed[783] = true');
	assert.equal(later.live, 3);
});
