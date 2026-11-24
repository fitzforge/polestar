'use strict';
// A guide written in a test, compiled from the fixture data and played in the real Engine
// against the stub world (tests/lua/stub_world.lua).
//
//   const { playGuide, statuses } = require('./helpers/play-guide');
//   const [before, after] = playGuide(['step One', '  accept 783', 'step Two', '  task "Go on"'],
//     `snap()
//     w.accept(783, {})
//     snap()`);
//
// `lines` are the guide's steps; the character is a level-5 Human Warrior. `script` is Lua run
// once the guide is loaded, with `w` the stub world, `E` the Engine and `snap()`, which lets the
// Engine catch up and emits { live, steps = { { status, applies, goals = { { status, manual,
// cur, max } } } } }. `before` is Lua run on the stub world before the character logs in;
// `saved` is Lua that sets PolestarCharDB (what an earlier session left: SAVED_ID is the guide's
// id). A table the script emits itself comes back as it is.
// -> the snapshots, in order.

const assert = require('node:assert/strict');
const fs = require('node:fs');
const { runAddon } = require('./lua');
const { guideText, compile, writeTestPack, fixtureData } = require('./dsl');

const SAVED_ID = 'forever/test/main';

function playGuide(lines, script, before = '', saved = '') {
	// The test pack is Polestar's own (`guides`), which owns the `forever/` ids.
	const r = compile(guideText(['guide forever/test/main', 'title Test', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', '', ...lines]));
	assert.deepEqual(r.errors, []);
	const [guide] = r.guides;
	const { dir, scripts } = writeTestPack([guide], fixtureData());
	try {
		const loads = scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
				w.level = 5
				${before}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: `PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }\n${saved}` },
			script: `do local ns = {}
				${loads}
				end
				stub.login(); stub.advance(0.5)
				local w, E = stub.world, Polestar.Engine
				E.SetGuide(${JSON.stringify(guide.id)})
				stub.advance(0.5)
				local function snap()
					stub.advance(0.5)
					local steps = {}
					for s = 1, ${guide.steps.length} do
						local v = E.GetStepView(s)
						local goals = {}
						for g, goal in ipairs(v.goals) do
							local p = goal.progress
							goals[g] = { status = goal.status, manual = goal.manual, cur = p and p.cur or -1, max = p and p.max or -1 }
						end
						steps[s] = { status = v.status, applies = E.Applies(s), goals = goals }
					end
					emit({ live = E.GetLiveStep() or 0, steps = steps })
				end
				${script}`,
		});
		return emitted.map((e) => (e.steps ? { live: e.live, steps: Object.values(e.steps).map((s) => ({ ...s, goals: Object.values(s.goals) })) } : e));
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

// The goal statuses of step s (1-based) in a snapshot.
const statuses = (snapshot, s) => snapshot.steps[s - 1].goals.map((g) => g.status);

module.exports = { playGuide, statuses, SAVED_ID };
