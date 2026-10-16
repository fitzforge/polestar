'use strict';
// NPC and object names in the client's language (Core/LocalNames.lua) from
// the committed Polestar_Names pack, loaded on demand the way the client
// loads it: the guide's steps, the arrow's label, the "not offered" text and
// the target button name the client's NPCs; English stays where the pack has
// no name, in an English client (which never loads the pack) and while a
// fight holds the load back. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, dirFiles, ROOT } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };
const PACK_DIR = path.join(ROOT, 'addon', 'Polestar_Names');
const LOCALES = /^## X-Locales: (.*)$/m.exec(fs.readFileSync(path.join(PACK_DIR, 'Polestar_Names.toc'), 'utf8'))[1];

// `loads` lists every LoadAddOn the addon asks for.
const TRACK = `
loads = {}
do
	local load = C_AddOns.LoadAddOn
	function C_AddOns.LoadAddOn(name) loads[#loads + 1] = name return load(name) end
end
`;

// The pack is installed: its TOC readable, LoadAddOn runs its files.
const INSTALLED = `
stub.addonMeta.Polestar_Names = { ["X-Locales"] = ${JSON.stringify(LOCALES)} }
stub.packs.Polestar_Names = { ${dirFiles(PACK_DIR).map((f) => JSON.stringify(f)).join(', ')} }
`;

const WORLD = `
local w = stub.world
w.addMap(1436, { name = "Westfall", c = 0, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.moveTo(1436, 50, 50)
w.race, w.faction, w.class, w.className, w.level = "Human", "Alliance", "WARRIOR", "Warrior", 12
`;

// NPC 491 and object 20352 have French names in the pack, NPC 114 too (a kill
// target); 999001 is no NPC the pack knows.
const GUIDE = `
Polestar.RegisterGuide({ id = "test/names", pack = "test", title = "Names", faction = "Alliance", minLevel = 10, maxLevel = 20, steps = {
	{ title = "Sentinel Hill", goals = {
		{ t = "talk", npc = 491, npcName = "Quartermaster Lewis", map = 1436, x = 51, y = 50 },
		{ t = "accept", quest = 9, title = "The Killing Fields", npc = 491, npcName = "Quartermaster Lewis", map = 1436, x = 51, y = 50 },
		{ t = "kill", target = "Harvest Watcher", npc = 114, count = 20, quest = 9, oi = 1 },
		{ t = "interact", object = 20352, objName = "Circle of Imprisonment" },
		{ t = "talk", npc = 999001, npcName = "Fixture Nobody" },
	} },
	{ goals = { { t = "level", level = 30 } } },
} })
`;

function run({ locale = 'frFR', installed = true, before = '', addons = [CORE], script }) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_packs.lua'],
		before: `function GetLocale() return ${JSON.stringify(locale)} end\n${installed ? INSTALLED : ''}\n${TRACK}${WORLD}${before}`,
		addons,
		script: `${TEST_PACK}
${TEST_SOURCE}
${GUIDE}
			E = Polestar.Engine
			function texts()
				local out = {}
				for g, v in ipairs(E.GetStepView(1).goals) do out[g] = v.text end
				return out
			end
			function details()
				local out = {}
				for g, v in ipairs(E.GetStepView(1).goals) do out[g] = v.detail or false end
				return out
			end
			stub.login()
			E.SetGuide("test/names")
			Polestar.Set("behavior.autoAccept", false)
			stub.advance(0.25)
			${script}`,
	}).emitted;
}

test('French client: the steps and the arrow name the NPCs and objects in French, from the pack loaded once', () => {
	const [out, offer] = run({
		script: `
			local wp = E.GetWaypoint()
			emit({ texts = texts(), details = details(), wp = wp and wp.label, loads = loads, packLoads = stub.packLoads.Polestar_Names,
				lewis = Polestar.LocalName("npc", 491, "Quartermaster Lewis"), loaded = Polestar.LocalNames.IsLoaded() })
			stub.world.gossip(491, { available = {} }); stub.world.close(); stub.advance(0.25)
			emit(E.GetStepView(1).goals[2].unavailableText or false)`,
	});
	assert.deepEqual(out.texts, ['Talk to Intendant Lewis', 'Accept The Killing Fields', 'Kill Gardien des moissons', "Click Cercle d'emprisonnement", 'Talk to Fixture Nobody']);
	assert.equal(out.details[1], 'from Intendant Lewis');
	assert.match(out.wp, /Intendant Lewis/, "the arrow's label");
	assert.deepEqual(out.loads, ['Polestar_Names']);
	assert.equal(out.packLoads, 1);
	assert.equal(out.lewis, 'Intendant Lewis');
	assert.equal(out.loaded, true);
	assert.equal(offer, 'Not offered by Intendant Lewis');
});

test('French client: an NPC the pack has no name for keeps its English name', () => {
	const [out] = run({ script: 'emit(texts())' });
	assert.equal(out[4], 'Talk to Fixture Nobody');
	assert.equal(out[0], 'Talk to Intendant Lewis');
});

test('English client: the pack is never loaded and the guide reads English', () => {
	const [out] = run({
		locale: 'enUS',
		script: `emit({ texts = texts(), loads = #loads, loaded = Polestar.LocalNames.IsLoaded(),
			lewis = Polestar.LocalName("npc", 491, "Quartermaster Lewis") })`,
	});
	assert.deepEqual(out.texts, ['Talk to Quartermaster Lewis', 'Accept The Killing Fields', 'Kill Harvest Watcher', 'Click Circle of Imprisonment', 'Talk to Fixture Nobody']);
	assert.equal(out.loads, 0);
	assert.equal(out.loaded, false);
	assert.equal(out.lewis, 'Quartermaster Lewis');
});

test('French client without the pack installed: English, and no load is tried', () => {
	const [out] = run({ installed: false, script: 'emit({ texts = texts(), loads = #loads })' });
	assert.equal(out.texts[0], 'Talk to Quartermaster Lewis');
	assert.equal(out.loads, 0);
});

test('in combat the pack waits for the fight to end, English meanwhile; then it loads and NAMES_CHANGED fires', () => {
	const [out] = run({
		before: 'stub.inCombat = true',
		script: `
			local r = { during = texts()[1], loadsDuring = #loads }
			local fired = 0
			Polestar.On("NAMES_CHANGED", function() fired = fired + 1 end)
			stub.inCombat = false
			stub.fire("PLAYER_REGEN_ENABLED")
			r.fired = fired
			r.after = texts()[1]
			r.packLoads = stub.packLoads.Polestar_Names
			stub.fire("PLAYER_REGEN_ENABLED")
			r.firedAgain = fired
			emit(r)`,
	});
	assert.equal(out.during, 'Talk to Quartermaster Lewis');
	assert.equal(out.loadsDuring, 0);
	assert.equal(out.fired, 1);
	assert.equal(out.after, 'Talk to Intendant Lewis');
	assert.equal(out.packLoads, 1);
	assert.equal(out.firedAgain, 1, 'once');
});

test("French client: the target button's macro names the kill target in French, so /targetexact finds it", () => {
	const qol = { name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'QoL/QoL.xml'] };
	const [fr] = run({ addons: [qol], script: 'emit(Polestar.QoL.Buttons.TargetNames())' });
	assert.deepEqual(fr, ['Gardien des moissons']);
	const [en] = run({ locale: 'enUS', addons: [qol], script: 'emit(Polestar.QoL.Buttons.TargetNames())' });
	assert.deepEqual(en, ['Harvest Watcher']);
});
