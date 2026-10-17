'use strict';
// The committed addon/Polestar_Guides/Guides.lua, loaded the way the game
// loads it, holds what `compile` writes from the .guide sources: every goal
// inside its step's `goals`, every goal a kind the engine knows, and per guide
// the source's steps with their goal kinds and quests in order. A hunk of
// Guides.lua spliced by hand can break that and still be valid Lua: a goal
// left between `title =` and `goals = {`, or a step's `goals` left open so the
// next step becomes one of its goals. The game loads either without an error
// and never shows those goals. Needs no reference data, so CI runs it.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');
const { findGuideFiles, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { GOAL_KEYS } = require('../tools/lib/dsl/emit');

const PACK_DIR = path.join(ADDONS, 'Polestar_Guides');
const HINT = 'Guides.lua comes from `node tools/polestar.js compile`, never a hand edit (CONTRIBUTING.md, "Fixing a guide")';

// Per step of every source guide: "<verb> <quest>" for each goal, in order.
function sourceGuides() {
	const out = new Map();
	for (const file of findGuideFiles(OFFICIAL_DIR)) {
		const guide = parseGuide(fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8'), file, new Diagnostics());
		const steps = guide.steps.map((s) => ({ title: s.title, goals: s.goals.map((g) => (g.quest == null ? g.verb : `${g.verb} ${g.quest}`)) }));
		out.set(guide.id, { file, steps });
	}
	return out;
}

const luaStr = (s) => JSON.stringify(String(s));

// Loads Polestar's core and the pack in `dir` through the real registry, then
// runs the pack's Guides.lua again with RegisterGuide capturing each table as
// written, and walks those. -> { problems, shape, steps: Map id -> [{ title, goals }] }
function load(dir) {
	const goalKeys = GOAL_KEYS.map((k) => `[${luaStr(k)}] = true`).join(', ');
	const [registry, ...guides] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }, { name: 'Polestar_Guides', dir }],
		script: `
local G = Polestar.Guides
local r = G.Pack("guides")
local problems = {}
for _, p in ipairs(r and r.problems or {}) do problems[#problems + 1] = p.message end
emit({ status = r and r.status or "missing", problems = problems })

local GOAL_KEYS = { ${goalKeys} }
local raw = {}
local register = Polestar.RegisterGuide
Polestar.RegisterGuide = function(def) raw[#raw + 1] = def end
dofile(${luaStr(path.join(dir, 'Guides.lua'))})
Polestar.RegisterGuide = register

local function isIndex(k, n) return type(k) == "number" and k >= 1 and k <= n and k % 1 == 0 end
local function goalShaped(v)
	return type(v) == "table" and (v.t ~= nil or v.goals ~= nil or (type(v[1]) == "table" and v[1].t ~= nil))
end
for _, def in ipairs(raw) do
	local bad, steps = {}, {}
	local function add(msg) bad[#bad + 1] = msg end
	for k, v in pairs(def) do
		if type(k) ~= "string" then add("entry [" .. tostring(k) .. "] outside steps")
		elseif k ~= "steps" and goalShaped(v) then add(k .. " holds a step or goal") end
	end
	local list = type(def.steps) == "table" and def.steps or {}
	for k in pairs(list) do
		if not isIndex(k, #list) then add("steps holds a non-step entry [" .. tostring(k) .. "]") end
	end
	for s = 1, #list do
		local step = list[s]
		local at = ("step %d"):format(s)
		if type(step) == "table" and type(step.title) == "string" then at = at .. " (" .. step.title .. ")" end
		local kinds = {}
		if type(step) ~= "table" then
			add(at .. ": not a table")
		else
			for k, v in pairs(step) do
				if type(k) ~= "string" then add(at .. ": entry [" .. tostring(k) .. "] outside goals")
				elseif k ~= "goals" and goalShaped(v) then add(at .. ": " .. k .. " holds a goal") end
			end
			local goals = type(step.goals) == "table" and step.goals or {}
			if type(step.goals) ~= "table" then add(at .. ": no goals") end
			for k in pairs(goals) do
				if not isIndex(k, #goals) then add(at .. ": goals holds a non-goal entry [" .. tostring(k) .. "]") end
			end
			for i = 1, #goals do
				local goal = goals[i]
				local where = ("%s goal %d"):format(at, i)
				if type(goal) ~= "table" then
					add(where .. ": not a table")
					kinds[i] = "?"
				else
					if not G.VERBS[goal.t] then add(where .. ": unknown kind t = " .. tostring(goal.t)) end
					for k in pairs(goal) do
						if not GOAL_KEYS[k] then add(where .. ": key [" .. tostring(k) .. "] that compile never writes") end
					end
					kinds[i] = goal.quest ~= nil and (tostring(goal.t) .. " " .. tostring(goal.quest)) or tostring(goal.t)
				end
			end
		end
		steps[s] = { title = type(step) == "table" and step.title or nil, goals = kinds }
	end
	emit({ id = tostring(def.id), bad = bad, steps = steps })
end`,
	}).emitted;
	const arr = (v) => (Array.isArray(v) ? v : []);
	const problems = registry.status === 'on' ? arr(registry.problems) : [`pack guides: ${registry.status}`, ...arr(registry.problems)];
	const shape = [];
	const steps = new Map();
	for (const g of guides) {
		for (const msg of arr(g.bad)) shape.push(`${g.id}: ${msg}`);
		if (steps.has(g.id)) shape.push(`${g.id}: registered twice`);
		steps.set(g.id, arr(g.steps).map((s) => ({ title: s.title, goals: arr(s.goals) })));
	}
	return { problems, shape, steps };
}

// Differences between the compiled guides and the sources: missing or extra
// guides, step counts, and per step the goal kinds and quests in order.
function diff(compiled, sources) {
	const out = [];
	for (const [id, src] of sources) {
		const steps = compiled.get(id);
		if (!steps) {
			out.push(`${id}: in ${src.file} but not in Guides.lua`);
			continue;
		}
		const first = src.steps.findIndex((s, i) => !steps[i] || JSON.stringify(s.goals) !== JSON.stringify(steps[i].goals));
		if (steps.length !== src.steps.length) {
			const at = first >= 0 ? `; first difference at step ${first + 1} (${src.steps[first].title})` : '';
			out.push(`${id}: ${steps.length} steps compiled, ${src.steps.length} in ${src.file}${at}`);
			continue;
		}
		src.steps.forEach((s, i) => {
			if (JSON.stringify(s.goals) !== JSON.stringify(steps[i].goals)) {
				out.push(`${id} step ${i + 1} (${s.title}): compiled [${steps[i].goals.join(', ')}], source [${s.goals.join(', ')}]`);
			}
		});
	}
	for (const id of compiled.keys()) if (!sources.has(id)) out.push(`${id}: in Guides.lua but no source`);
	return out;
}

let sources;
let committed;
function setup() {
	sources ??= sourceGuides();
	committed ??= load(PACK_DIR);
}

test('the committed Polestar_Guides registers every guide with no problems', () => {
	setup();
	assert.ok(committed.steps.size > 100, `found ${committed.steps.size} guides`);
	assert.deepEqual(committed.problems, [], HINT);
});

test('every compiled goal sits in its step\'s goals and is a kind the engine knows', () => {
	setup();
	assert.deepEqual(committed.shape, [], HINT);
});

test('every compiled guide has its source\'s steps, goal kinds and quests', () => {
	setup();
	assert.deepEqual(diff(committed.steps, sources), [], HINT);
});

// The two hand-splice shapes this test exists for, made from a copy of the
// committed file: each must fail the checks above.
function brokenCopy(edit) {
	const dir = path.join(tmpdir(), 'Polestar_Guides');
	fs.cpSync(PACK_DIR, dir, { recursive: true });
	const file = path.join(dir, 'Guides.lua');
	const lines = fs.readFileSync(file, 'utf8').split('\n');
	edit(lines);
	fs.writeFileSync(file, lines.join('\n'));
	return dir;
}

const GOALS_OPEN = '\t\t\t\t\tgoals = {';
const GOALS_CLOSE = '\t\t\t\t\t},';
const STEP_CLOSE = '\t\t\t\t},';
const STEP_OPEN = '\t\t\t\t{';
const isGoal = (line) => line.startsWith('\t\t\t\t\t\t{ t = ');

test('a goal spliced in before goals = { fails the checks', () => {
	setup();
	let id;
	const dir = brokenCopy((lines) => {
		const i = lines.findIndex((l, j) => l === GOALS_OPEN && isGoal(lines[j + 1]) && isGoal(lines[j + 2]));
		id = lines.slice(0, i).findLast((l) => l.startsWith('\t\t\tid = ')).match(/"(.+)"/)[1];
		lines.splice(i, 0, lines.splice(i + 1, 1)[0]);
	});
	const broken = load(dir);
	assert.deepEqual(broken.problems, committed.problems, 'the registry takes it without a word');
	assert.match(broken.shape.join('\n'), new RegExp(`^${id}: step \\d+ \\(.+\\): entry \\[1\\] outside goals$`, 'm'));
	assert.match(diff(broken.steps, sources).join('\n'), new RegExp(`^${id} step \\d+ `, 'm'));
});

test('a step left open so the next step becomes its goal fails the checks', () => {
	setup();
	let id;
	const dir = brokenCopy((lines) => {
		// Drop one step's closers and put them back after the next step.
		const i = lines.findIndex((l, j) => l === GOALS_CLOSE && lines[j + 1] === STEP_CLOSE && lines[j + 2] === STEP_OPEN);
		id = lines.slice(0, i).findLast((l) => l.startsWith('\t\t\tid = ')).match(/"(.+)"/)[1];
		const closers = lines.splice(i, 2);
		const end = lines.indexOf(STEP_CLOSE, i);
		lines.splice(end + 1, 0, ...closers);
	});
	const broken = load(dir);
	assert.match(broken.problems.join('\n'), new RegExp(`Guide ${id} was refused`), 'the registry refuses the guide, silently in game');
	assert.match(broken.shape.join('\n'), new RegExp(`^${id}: step \\d+ \\(.+\\) goal \\d+: unknown kind t = nil$`, 'm'));
	assert.match(diff(broken.steps, sources).join('\n'), new RegExp(`^${id}: \\d+ steps compiled, \\d+ in `, 'm'));
});
