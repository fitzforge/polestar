'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function alongRows(along, after = '') {
	const { emitted } = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `
			uistub.install()
			stub.login()
			uistub.setGuide(uistub.elwynn, 3)
			local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
			E.GetAlong = function() return ${along} end
			GF.Update()
			local rows = {}
			for _, row in ipairs(GF.alongRows) do
				if row:IsShown() then
					rows[#rows + 1] = { step = row.psStep, goal = row.psGoal, pin = row.psPin, place = row.psPlace }
				end
			end
			emit(rows)
			${after}
		`,
	});
	return emitted;
}

test('the guide window shows each along-the-way objective once', () => {
	const [rows] = alongRows(`{
		{ index = 1, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue" },
		} },
		{ index = 2, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue" },
			{ t = "collect", quest = 496, oi = 2, item = 3477, index = 2, text = "Creeper Ichor" },
		} },
	}`);
	assert.deepEqual(rows, [{ step: 1, goal: 1 }, { step: 2, goal: 2 }]);
});

test('an along row that hides a pinned quest\'s row keeps its pin: a right-click unpins', () => {
	const [rows, unpinned] = alongRows(`{
		{ index = 1, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue" },
		} },
		{ pin = 496, title = "Elixir of Suffering", goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, step = 7, text = "Gray Bear Tongue" },
		} },
	}`, `
		local calls = {}
		E.PinQuest = function(quest, on) calls[#calls + 1] = { quest, on } end
		local row = GF.alongRows[1]
		row:GetScript("OnClick")(row, "RightButton")
		emit(calls)
	`);
	assert.deepEqual(rows, [{ step: 1, goal: 1, pin: 496 }]);
	assert.deepEqual(unpinned, [[496, false]]);
});

test('the same objective with another count is a row of its own', () => {
	const [rows] = alongRows(`{
		{ index = 1, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue", progress = { cur = 3, max = 10 } },
		} },
		{ index = 2, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue", progress = { cur = 3, max = 10 } },
		} },
		{ index = 3, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue", progress = { cur = 3, max = 20 } },
		} },
	}`);
	assert.deepEqual(rows, [{ step: 1, goal: 1 }, { step: 3, goal: 1 }]);
});

test('a row with no place takes the step, goal and place of the duplicate it hides', () => {
	const [rows] = alongRows(`{
		{ index = 1, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue" },
		} },
		{ index = 2, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 4, text = "Gray Bear Tongue", map = 1424, x = 55.1, y = 34.2 },
		} },
		{ index = 3, goals = {
			{ t = "collect", quest = 496, oi = 1, item = 3476, index = 2, text = "Gray Bear Tongue", map = 1424, x = 60, y = 40 },
		} },
	}`);
	assert.deepEqual(rows, [{ step: 2, goal: 4, place: true }]);
});
