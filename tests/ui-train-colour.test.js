'use strict';
// A training goal's own colour (#1669): its trainer or skill wears the
// Theme token "train" (House.SHARED; a skin may recolour it, the player's
// Settings > Theme > Names pick wins), where a talk goal's person wears npc.
// Its glyph is the train verb's own (Theme.VerbIcon).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `uistub.install()
		stub.login()
		local T, UI = Polestar.Theme, Polestar.UI
		local function goal(t, kind, status)
			return { t = t, status = status or "active", verb = "Learn new spells from", subject = "Brother Wilhelm",
				subjectKind = kind, text = "Learn new spells from Brother Wilhelm" }
		end
		${script}`,
	}).emitted[0];
}

test('a train goal\'s trainer wears the train colour, a talk goal\'s person npc; done, no colour; the player\'s pick wins', () => {
	const out = run(`
		local r = {
			train = UI.GoalLine(goal("train", "npc")), talk = UI.GoalLine(goal("talk", "npc")),
			done = UI.GoalLine(goal("train", "npc", "done")), skill = UI.GoalLine(goal("train", "skill")),
			trainHex = T.Hex("train"), npcHex = T.Hex("npc"),
			subject = false, icon = T.VerbIcon("train"), note = T.VerbIcon("note"),
		}
		for _, n in ipairs(T.SUBJECTS) do if n == "train" then r.subject = true end end
		Polestar.Set("ui.colors.train", { 1, 0.6, 1 })
		r.picked, r.pickedHex = UI.GoalLine(goal("train", "npc")), T.Hex("train")
		emit(r)`);
	assert.notEqual(out.trainHex, out.npcHex, 'its own colour, not the npc one');
	assert.equal(out.train, `Learn new spells from |c${out.trainHex}Brother Wilhelm|r`);
	assert.equal(out.skill, `Learn new spells from |c${out.trainHex}Brother Wilhelm|r`, 'a skill to learn too');
	assert.equal(out.talk, `Learn new spells from |c${out.npcHex}Brother Wilhelm|r`);
	assert.equal(out.done, 'Learn new spells from Brother Wilhelm');
	assert.equal(out.subject, true, 'listed with the Names colours a player may set');
	assert.equal(out.pickedHex, 'ffff99ff');
	assert.equal(out.picked, 'Learn new spells from |cffff99ffBrother Wilhelm|r');
	assert.match(out.icon, /icon-train$/);
	assert.notEqual(out.icon, out.note);
});
