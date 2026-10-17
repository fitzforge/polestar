'use strict';
// The official guides compiled once with the real reference data, and a
// compiled guide played in the real Engine for one character. For the tests
// that check a pattern across every guide (tests/guides-patterns.test.js).
// Needs data/forever (helpers/data.js `needs`).

const fs = require('node:fs');
const { compileProject, OFFICIAL_DIR } = require('../../tools/lib/dsl/project');
const { readManifest } = require('../../tools/lib/pack/manifest');
const { DATA } = require('../../tools/lib/paths');
const { runAddon } = require('./lua');
const { writeTestPack } = require('./dsl');

let compiled;
// { guides, data, diag }: every guide under guides/ (drafts excluded), the
// legacy ones left out.
function officialGuides() {
	if (!compiled) {
		const { manifest } = readManifest(OFFICIAL_DIR, { official: true });
		const { guides, data, diag } = compileProject({ packDir: OFFICIAL_DIR, manifest, dataDir: DATA });
		compiled = { guides: guides.filter((g) => !g.id.startsWith('forever/legacy/')), data, diag };
	}
	return compiled;
}

// `guide` (compiled) played by the Engine for `who` ({ race, raceName,
// faction, cls, className, level }): for each step number in `steps`, the
// step's focus group (1-based, or null) and its groups ({ kind, npc, object,
// name, map, x, y, f, goals (1-based goal numbers), pending }), right after
// the guide is opened with nothing done.
function stepGroups(guide, data, who, steps) {
	const { dir, scripts } = writeTestPack([guide], data);
	try {
		const loads = scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = ${JSON.stringify(who.race)}, ${JSON.stringify(who.raceName)}, ${JSON.stringify(who.faction)}, ${JSON.stringify(who.cls)}, ${JSON.stringify(who.className)}
				w.level = ${who.level}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }' },
			script: `do local ns = {}
				${loads}
				end
				stub.login(); stub.advance(0.5)
				local E = Polestar.Engine
				E.SetGuide(${JSON.stringify(guide.id)})
				stub.advance(0.5)
				local out = {}
				for k, s in ipairs({ ${steps.join(', ')} }) do
					local v = E.GetStepView(s)
					local groups = {}
					for i, grp in ipairs(v.groups) do
						groups[i] = { kind = grp.kind, npc = grp.npc or 0, object = grp.object or 0, name = grp.name or "",
							map = grp.map or 0, x = grp.x or -1, y = grp.y or -1, f = grp.f or "", goals = grp.goals, pending = grp.pending }
					end
					out[k] = { focus = v.focus or 0, groups = groups }
				end
				emit(out)`,
		});
		// An empty Lua table comes back as {}.
		return Object.values(emitted[0]).map((v) => ({
			focus: v.focus || null,
			groups: Object.values(v.groups).map((g) => ({
				...g,
				goals: Object.values(g.goals),
				npc: g.npc || null,
				object: g.object || null,
				map: g.map || null,
				x: g.x < 0 ? null : g.x,
				y: g.y < 0 ? null : g.y,
				f: g.f || undefined,
			})),
		}));
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

module.exports = { officialGuides, stepGroups };
