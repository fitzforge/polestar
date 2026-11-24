'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };
const MENU = String.raw`
	local menus = {}
	Menu = { ModifyMenu = function(tag, fn) menus[tag] = fn end }
	function targetMenu(context)
		local action
		local root = { CreateButton = function(_, label, fn)
			assert(label == "Add to Target List")
			action = fn
		end }
		context = context or { fromTargetFrame = true, unit = "target" }
		menus.MENU_UNIT_TARGET(nil, root, context)
		return action
	end
	function UnitGUID(unit)
		local t = stub.qol.target
		if unit == "target" and t then return t.guid end
	end
	function UnitPlayerControlled(unit)
		local t = stub.qol.target
		return unit == "target" and t and t.controlled or false
	end
`;

function run(script) {
	return runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], before: MENU, login: true,
		script: String.raw`
			local B, q = Polestar.QoL.Buttons, stub.qol
			local function names()
				local result = {}
				for _, row in ipairs(B.rows) do
					if row:IsShown() then result[#result + 1] = row.applied end
				end
				return table.concat(result, ", ")
			end
			local function mob(name, id)
				q.target = { name = name, hostile = true, npc = id, guid = "Creature-0-1-0-1-" .. id .. "-001" }
			end
			local function click(row, button)
				q.mouseClick(B.rows[row], button); stub.runTimers()
			end
			local function add()
				assert(targetMenu())(); stub.runTimers()
			end
		` + script }).emitted;
}

test('a target menu adds an attackable creature once and a row right-click only removes it', () => {
	assert.deepEqual(run(`
		mob("Forest Wolf", 47)
		add()
		emit(names())
		emit(targetMenu() == nil)
		emit(B.TargetInfo("Forest Wolf").npc)
		click(1, "LeftButton")
		emit(q.ran[1][2]:find("Forest Wolf", 1, true) ~= nil)
		click(1, "RightButton")
		emit(names())
		emit(#q.ran)
	`), ['Forest Wolf', true, 47, true, '', 1]);
});

test('the menu skips other frames, friends, pets, players, secret values and stale targets', () => {
	assert.deepEqual(run(`
		mob("Forest Wolf", 47)
		emit(targetMenu({ unit = "target" }) == nil)
		emit(targetMenu({ fromTargetFrame = true, unit = "focus" }) == nil)
		local stale = assert(targetMenu())
		mob("Forest Wolf", 48)
		stale(); stub.runTimers()
		emit(names())
		q.target.hostile = false
		emit(targetMenu() == nil)
		q.target.hostile, q.target.controlled = true, true
		emit(targetMenu() == nil)
		q.target.controlled, q.target.guid = false, "Player-1-23"
		emit(targetMenu() == nil)
		mob("Forest Wolf", 47)
		issecretvalue = function(value) return value == q.target.guid end
		emit(targetMenu() == nil)
	`), [true, true, '', true, true, true, true]);
});

test('guide dismissals refill the list and expire on step change while manual targets stay', () => {
	assert.deepEqual(run(`
		local goals = {
			{ t = "kill", target = "Guide A" },
			{ t = "kill", target = "Guide B" },
			{ t = "kill", target = "Guide C" },
		}
		Polestar.Set("qol.targetRows", 2)
		q.step(goals, 1)
		mob("Manual Mob", 47); add()
		emit(names())
		click(2, "RightButton")
		Polestar.Fire("STEP_UPDATED"); stub.runTimers()
		emit(names())
		q.step(goals, 2)
		emit(names())
		Polestar.Set("qol.targetSimple", true); stub.runTimers()
		emit(names())
		emit(targetMenu() == nil)
	`), ['Manual Mob, Guide A', 'Manual Mob, Guide B', 'Manual Mob, Guide A', '', true]);
});

test('a folded row removes its displayed name after combat and keeps the other names', () => {
	assert.deepEqual(run(`
		mob("Forest Wolf", 47); add()
		mob("Young Bear", 48); add()
		stub.RunScript(B.anchor, "OnClick", "LeftButton"); stub.runTimers()
		emit(names())
		q.combat(true)
		stub.cvars.ActionButtonUseKeyDown = true
		click(1, "RightButton")
		emit(names())
		emit(#q.ran)
		q.combat(false); stub.runTimers()
		emit(names())
	`), ['Young Bear', 'Young Bear', 0, 'Forest Wolf']);
});

test('a combat-held row can be dismissed without hiding that name on the next step', () => {
	assert.deepEqual(run(`
		local goals = { { t = "kill", target = "Forest Wolf" } }
		q.step(goals, 1)
		q.combat(true)
		q.step(goals, 2)
		click(1, "RightButton")
		emit(names())
		q.combat(false); stub.runTimers()
		emit(names())
		click(1, "RightButton")
		emit(names())
		mob("Forest Wolf", 47); add()
		emit(names())
	`), ['Forest Wolf', 'Forest Wolf', '', 'Forest Wolf']);
});
