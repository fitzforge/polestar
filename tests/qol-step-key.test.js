'use strict';
// The step key also targets the mobs of the While you're here rows (#1316):
// after the step's own names, one from each row nearest first, as many as fit
// the macro; changed only out of combat; off with behavior.whileHereStepKey.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

// rows(list): the While you're here rows, nearest first, each a goal view
// with `step` and `index` and its raw goal as `raw`. names(): the names the
// step key's macro targets, in order.
function run(script) {
	return runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true,
		script: `local B, q = Polestar.QoL.Buttons, stub.qol
		Polestar.Set("behavior.whileHereStepKey", true)
		local shown = {}
		q.Engine.GetWhileHereList = function()
			local out = {}
			for i, r in ipairs(shown) do out[i] = r end
			return out
		end
		q.Engine.AlongGoal = function(s, g)
			for _, r in ipairs(shown) do
				if r.step == s and r.index == g then return r.raw end
			end
		end
		local function rows(list)
			shown = list
			for i, r in ipairs(shown) do
				r.step, r.index, r.status = r.step or 20 + i, r.index or 1, r.status or "active"
				r.raw = r.raw or {}
			end
			Polestar.Fire("WHILE_HERE_CHANGED")
			stub.runTimers()
		end
		local function names()
			local out = {}
			for name in (PolestarStepButton:GetAttribute("macrotext") or ""):gmatch("/targetexact [^\\n]-([^\\n%]]+)\\n") do
				out[#out + 1] = (name:gsub("^%s+", ""))
			end
			return out
		end
		${script}` }).emitted;
}

test('step key: the step\'s own names first, then one mob from each row nearest first, no name twice', () => {
	const out = run(`
		q.step({ { t = "kill", target = "Wolf" }, { t = "kill", target = "Boar" } })
		emit(names())
		rows({
			{ t = "kill", subject = "Boar" },
			{ t = "collect", npc = 7, npcName = "Kobold Miner", raw = { fromNpcs = { { npcName = "Kobold Tunneler" } } } },
			{ t = "kill", subject = "Murloc" },
			{ t = "interact", subject = "Cart" },
		})
		emit(names())
		emit(PolestarStepButton:GetAttribute("macrotext"):sub(1, 23))
	`);
	assert.deepEqual(out[0], ['Wolf', 'Boar']);
	// Boar is the step's own already; a row's second name comes after every
	// row's first; the interact row has no mob.
	assert.deepEqual(out[1], ['Wolf', 'Boar', 'Kobold Miner', 'Murloc']);
	assert.equal(out[2], '/cleartarget [nocombat]');
});

test('step key: with nothing else to do it targets the rows\' mobs; an item or an NPC keeps the key', () => {
	const out = run(`
		q.step({ { t = "goto", location = "Goldshire" } })
		emit(PolestarStepButton:GetAttribute("macrotext") or false)
		rows({ { t = "kill", subject = "Murloc" }, { t = "kill", subject = "Kobold Vermin" } })
		emit(names())
		q.addItem(0, 1, 900, 1)
		q.step({ { t = "use", item = 900 } })
		emit({ PolestarStepButton:GetAttribute("type"), PolestarStepButton:GetAttribute("item") })
		q.step({ { t = "talk", npcName = "Marshal McBride" } })
		emit(names())
	`);
	assert.equal(out[0], false);
	assert.deepEqual(out[1], ['Murloc', 'Kobold Vermin']);
	assert.deepEqual(out[2], ['item', 'item:900']);
	assert.deepEqual(out[3], ['Marshal McBride']);
});

test('step key: the rows\' names past the macro limit are left out, never the step\'s own', () => {
	const out = run(`
		-- 31 bytes each: the macro holds three (240 bytes), not four (316).
		local long = string.rep("W", 30)
		q.step({ { t = "kill", target = long .. "1" }, { t = "kill", target = long .. "2" } })
		rows({ { t = "kill", subject = long .. "3" }, { t = "kill", subject = long .. "4" } })
		local macro = PolestarStepButton:GetAttribute("macrotext")
		local got = names()
		for i = 1, #got do got[i] = got[i]:sub(-1) end
		emit({ #macro <= 255, got })
	`);
	assert.deepEqual(out[0], [true, ['1', '2', '3']]);
});

test('step key: rows that change in a fight leave the macro alone until it ends', () => {
	const out = run(`
		q.step({ { t = "kill", target = "Wolf" } })
		rows({ { t = "kill", subject = "Murloc" } })
		local before = PolestarStepButton:GetAttribute("macrotext")
		q.combat(true)
		rows({ { t = "kill", subject = "Kobold Vermin" } })
		emit(PolestarStepButton:GetAttribute("macrotext") == before)
		q.combat(false)
		emit(names())
	`);
	assert.deepEqual(out, [true, ['Wolf', 'Kobold Vermin']]);
});

test('step key: with behavior.whileHereStepKey off it targets only the step\'s own; on again, the rows come back', () => {
	const out = run(`
		q.step({ { t = "kill", target = "Wolf" } })
		rows({ { t = "kill", subject = "Murloc" } })
		Polestar.Set("behavior.whileHereStepKey", false)
		stub.runTimers()
		emit(names())
		q.step({ { t = "goto", location = "Goldshire" } })
		emit(PolestarStepButton:GetAttribute("macrotext") or false)
		Polestar.Set("behavior.whileHereStepKey", true)
		stub.runTimers()
		emit(names())
	`);
	assert.deepEqual(out, [['Wolf'], false, ['Murloc']]);
});
