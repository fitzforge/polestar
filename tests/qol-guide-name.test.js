'use strict';
// A guide name uses the same macro and mark cycle as the target button,
// while resolving only the clicked goal's chosen NPC or explicit source.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

function run(script) {
	return runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true,
		script: `local B, q = Polestar.QoL.Buttons, stub.qol
		local function set(k, v) Polestar.Set("qol." .. k, v); stub.runTimers() end
		set("guideNameTarget", true)
		${script}` }).emitted;
}

test('guide name: one localized chosen NPC uses the shared macro, with marking off by default', () => {
	const out = run(`
		emit({ Polestar.GetDefault("qol.guideNameTarget"), Polestar.GetDefault("qol.markTarget") })
		Polestar.Names = { Npc = function(id) return ({ [10] = "Loup gris", [20] = "Maître des griffons" })[id] end }
		Polestar.QoL.CurrentStep = function() error("must not inspect other goals") end
		local function result(goal, raw)
			local macro, name, kind = B.GuideNameMacro(goal, raw)
			emit({ macro, name, kind, macro == B.TargetMacro({ name }, 1, B.MarkLine(kind)) })
		end
		result({ t = "kill", npc = 10, subject = "Grey Wolf" }, { npc = 99, target = "Unrelated Wolf" })
		result({ t = "talk", npc = 20, npcName = "Gryphon Master" })
		result({ t = "kill", subject = "O'Brien's Wolf" })
	`);
	assert.deepEqual(out[0], [false, false]);
	assert.deepEqual(out.slice(1).map((row) => row.slice(1)), [
		['Loup gris', 'mob', true], ['Maître des griffons', 'npc', true], ["O'Brien's Wolf", 'mob', true],
	]);
	for (const [macro, name] of out.slice(1)) {
		assert.equal(macro, `/cleartarget [nocombat]\n/targetexact ${name}\n/cleartarget [dead]`);
	}
});

test('guide name: collect resolves its chosen or explicit NPC source, never the item or other droppers', () => {
	const out = run(`
		Polestar.Names = { Npc = function(id) return ({ [10] = "Araignée choisie", [20] = "Loup source" })[id] end }
		Polestar.QuestDB = { IsLoaded = function() error("must not inspect unrelated droppers") end }
		local function result(goal, raw)
			local macro, name, kind = B.GuideNameMacro(goal, raw)
			emit(macro and { name, kind } or false)
		end
		result({ t = "collect", npc = 10, subject = "Spider Silk", source = { kind = "npc", name = "Other Spider" } },
			{ fromNpcs = { { npc = 99, npcName = "Another Spider" } } })
		result({ t = "collect", subject = "Wolf Meat", source = { kind = "npc", name = "Loup source", also = "Other Wolf" } })
		result({ t = "collect", subject = "Wolf Meat" }, { fromId = 20, from = "Source Wolf", fromKind = "npc" })
		result({ t = "collect", subject = "Oats", source = { kind = "object", name = "Sack of Oats" } })
		result({ t = "collect", subject = "Spider Silk", fromNpcs = { { npc = 10, npcName = "Spider" } } })
		result({ t = "collect", subject = "Spider Silk" })
	`);
	assert.deepEqual(out, [['Araignée choisie', 'mob'], ['Loup source', 'mob'], ['Loup source', 'mob'], false, false, false]);
});

test('guide name: chosen IDs and names stay together; a missing chosen NPC never becomes another dropper', () => {
	const out = run(`
		Polestar.Names = { Npc = function(id) return id == 99 and "Raw NPC" or nil end }
		local function result(goal, raw)
			local macro, name = B.GuideNameMacro(goal, raw)
			emit(macro and name or false)
		end
		result({ t = "collect", npcName = "Chosen NPC" }, { npc = 99, npcName = "Raw NPC", from = "Source NPC" })
		result({ t = "kill", npc = 10, subject = "View NPC" }, { npc = 99, target = "Raw NPC" })
		result({ t = "collect", npc = 10, source = { kind = "npc", name = "Other NPC" } }, { npc = 99 })
		result({ t = "talk", npc = 10 }, { npc = 99, npcName = "Raw NPC" })
		result({ t = "collect", source = { kind = "npc", name = "Primary NPC", also = "Other NPC" } })
		result({ t = "collect" }, { from = "Primary NPC", fromAlso = "Other NPC", fromKind = "npc" })
	`);
	assert.deepEqual(out, ['Chosen NPC', 'View NPC', false, false, 'Primary NPC', 'Primary NPC']);
});

test('guide name: unavailable names and control characters use the shared safety check; disabling removes the action', () => {
	const out = run(String.raw`
		local rejected = {}
		for _, goal in ipairs({ {}, { t = "note", npcName = "Wolf" }, { t = "talk" },
			{ t = "kill", subject = "" }, { t = "kill", subject = 123 } }) do
			rejected[#rejected + 1] = B.GuideNameMacro(goal) == nil
		end
		for _, name in ipairs({ "Wolf\n/run Unsafe()", "Wolf\rOther", "Wolf\tOther", "Wolf\0Other", "Wolf\127Other" }) do
			rejected[#rejected + 1] = not B.MacroSafeName(name) and B.GuideNameMacro({ t = "kill", subject = name }) == nil
		end
		emit(rejected)
		emit(B.GuideNameMacro(nil) == nil)
		set("guideNameTarget", false)
		emit(B.GuideNameMacro({ t = "kill", subject = "Wolf" }) == nil)
	`);
	assert.deepEqual(out[0], Array(10).fill(true));
	assert.deepEqual(out.slice(1), [true, true]);
});

test('guide name: the complete shared macro must fit 255 bytes, with and without marks or multibyte names', () => {
	const out = run(`
		for _, marking in ipairs({ false, true }) do
			set("markTarget", marking)
			for _, kind in ipairs({ "mob", "npc" }) do
				local overhead = #B.TargetMacro({ "W" }, 1, B.MarkLine(kind)) - 1
				local budget = 255 - overhead
				for _, unit in ipairs({ "W", "狼" }) do
					local name = string.rep(unit, math.floor(budget / #unit)) .. string.rep("W", budget % #unit)
					local goal = { t = kind == "mob" and "kill" or "talk", npcName = name }
					local macro, resolved = B.GuideNameMacro(goal)
					goal.npcName = name .. "W"
					emit({ macro and #macro or 0, resolved == name, B.GuideNameMacro(goal) == nil })
				end
			end
		end
	`);
	assert.equal(out.length, 8);
	for (const row of out) assert.deepEqual(row, [255, true, true]);
});

test('guide name: kills and collect sources use mob marks; all NPC verbs use NPC marks', () => {
	const out = run(`
		set("markTarget", true)
		set("markMob", "6")
		set("markNpc", "4")
		for _, verb in ipairs({ "kill", "collect", "accept", "turnin", "talk", "train", "vendor", "buy", "sethome", "getfp", "learn" }) do
			local macro, name, kind = B.GuideNameMacro({ t = verb, npcName = "Chosen NPC" })
			emit({ kind, macro:match("[~!]%d$"), macro == B.TargetMacro({ name }, 1, B.MarkLine(kind)) })
		end
		set("markTarget", false)
		emit(B.GuideNameMacro({ t = "talk", npcName = "Chosen NPC" }))
	`);
	assert.deepEqual(out.slice(0, 2), [['mob', '!6', true], ['mob', '!6', true]]);
	for (const row of out.slice(2, 11)) assert.deepEqual(row, ['npc', '!4', true]);
	assert.equal(out[11], '/cleartarget [nocombat]\n/targetexact Chosen NPC\n/cleartarget [dead]');
});

test('mark cycle: guide names, target button and step key advance together without losing name cycles', () => {
	const out = run(`
		set("markTarget", true)
		set("markMob", "cycle")
		q.step({ { t = "kill", target = "Wolf" }, { t = "kill", target = "Boar" } })
		local t, s, changes = PolestarTargetButton, PolestarStepButton, {}
		Polestar.On("QOL_TARGET_MARK_CHANGED", function(kind) changes[#changes + 1] = kind end)
		local function snapshot()
			local macro = B.GuideNameMacro({ t = "kill", subject = "Wolf" })
			emit({ t:GetAttribute("macrotext"):match("/targetexact ([^\\n]+)"), s:GetAttribute("macrotext"):match("/targetexact ([^\\n]+)"),
				t:GetAttribute("macrotext"):match("[~!]%d$"), s:GetAttribute("macrotext"):match("[~!]%d$"), macro:match("[~!]%d$") })
		end
		snapshot()
		assert(B.AdvanceMark("mob"))
		snapshot()
		q.click(t, true)
		q.click(t, false)
		snapshot()
		q.click(s, true)
		q.click(s, false)
		snapshot()
		emit(changes)
	`);
	assert.deepEqual(out, [
		['Wolf', 'Wolf', '~2', '~2', '~2'], ['Wolf', 'Wolf', '~3', '~3', '~3'],
		['Boar', 'Wolf', '~4', '~4', '~4'], ['Boar', 'Boar', '~5', '~5', '~5'],
		['mob', 'mob', 'mob'],
	]);
});

test('mark cycle: NPCs skip the fixed mob icon; off and fixed settings do not advance or notify', () => {
	const out = run(`
		local changes = {}
		Polestar.On("QOL_TARGET_MARK_CHANGED", function(kind) changes[#changes + 1] = kind end)
		emit(B.AdvanceMark("mob"))
		set("markTarget", true)
		emit(B.AdvanceMark("mob"))
		emit(B.AdvanceMark(nil))
		set("markNpc", "cycle")
		q.step({ { t = "talk", npcName = "Innkeeper" } })
		local seen = {}
		for i = 1, 8 do
			local macro = B.GuideNameMacro({ t = "talk", npcName = "Innkeeper" })
			assert(macro == PolestarStepButton:GetAttribute("macrotext"))
			seen[#seen + 1] = macro:match("[~!]%d$")
			assert(B.AdvanceMark("npc"))
		end
		emit(seen)
		emit(changes)
	`);
	assert.deepEqual(out.slice(0, 3), [false, false, false]);
	assert.deepEqual(out[3], ['~1', '~2', '~3', '~4', '~5', '~6', '~7', '~1']);
	assert.deepEqual(out[4], Array(8).fill('npc'));
});

test('mark cycle: existing target and step macros stay frozen in combat, then apply the latest cycle once safe', () => {
	const out = run(`
		set("markTarget", true)
		set("markMob", "cycle")
		q.step({ { t = "kill", target = "Wolf" }, { t = "kill", target = "Boar" } })
		local t, s = PolestarTargetButton, PolestarStepButton
		local oldT, oldS = t:GetAttribute("macrotext"), s:GetAttribute("macrotext")
		q.combat(true)
		q.click(t, false)
		q.click(s, false)
		emit({ t:GetAttribute("macrotext") == oldT, s:GetAttribute("macrotext") == oldS })
		q.combat(false)
		emit({ t:GetAttribute("macrotext"):match("/targetexact ([^\\n]+)"), s:GetAttribute("macrotext"):match("/targetexact ([^\\n]+)"),
			t:GetAttribute("macrotext"):match("[~!]%d$"), s:GetAttribute("macrotext"):match("[~!]%d$") })
	`);
	assert.deepEqual(out, [[true, true], ['Boar', 'Boar', '~4', '~4']]);
});
