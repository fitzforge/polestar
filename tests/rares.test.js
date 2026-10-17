'use strict';
// The Rares module: the decision every sighting goes through (Rares.Decide),
// the live detection paths (nameplates, target, mouseover, vignettes) with
// their throttles, combat hold and alert cooldown, the "last seen" history,
// and the map pin selection (Rares.BuildPins) and layers. Real Core, Theme,
// Nav, Lookup and Rares files over tests/lua/stub_world.lua and
// stub_rares.lua; the Codex is the sample pack (tests/fixtures/codex/
// sample.json), loaded the way the client loads it.

const { test, before, after } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack, sampleCodex } = require('./helpers/codex');

const codex = sampleCodex();
const FILES = { name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Lookup/Lookup.xml', 'Rares/Rares.xml'] };
const MAPS = Object.entries(codex.frames)
	.map(([id, f]) => `w.addMap(${id}, { name = ${JSON.stringify(codex.zones[id].name)}, c = ${f.c}, left = ${f.left}, right = ${f.right}, top = ${f.top}, bottom = ${f.bottom} })`)
	.join('\n');

let pack;
before(() => {
	pack = writeCodexPack(codex);
});
after(() => pack && pack.cleanup());

function run(script, opts = {}) {
	const { settings, setup = '', withPack = true, at = [1429, 88, 78], level = 10 } = opts;
	return runAddon({
		stubs: ['stub_world.lua', 'stub_rares.lua'],
		before: `${withPack ? pack.stubLua : ''}
local w = stub.world
${MAPS}
w.moveTo(${at.join(', ')})
w.setLevel(${level})
${setup}`,
		addons: [FILES],
		saved: settings ? { Polestar: `PolestarDB = { schema = 1, settings = { rares = ${settings} } }` } : undefined,
		login: true,
		script: `local R = Polestar.Rares
local got = {}
Polestar.On("RARE_SPOTTED", function(a) got[#got + 1] = a end)
local function names() local out = {} for i, a in ipairs(got) do out[i] = a.name end return out end
${script}`,
	}).emitted;
}

// ------------------------------------------------------------- the decision

test('Decide: every reason a sighting is skipped, recorded, held or alerted', () => {
	const [out] = run(`
local defaults = { enabled = true, vignettes = true, nameplates = true, target = true, mouseover = true, alerts = true,
	treasureAlerts = true, cooldown = 10, combatAlerts = false, ignored = false }
local function ctx(over, extra)
	local cfg = {}
	for k, v in pairs(defaults) do cfg[k] = v end
	for k, v in pairs(over or {}) do cfg[k] = v end
	local c = { get = function(k) return cfg[k] end, now = 100000, history = {}, inCombat = false, inInstance = false,
		known = function(kind, id) return id == 61 end }
	for k, v in pairs(extra or {}) do c[k] = v end
	return c
end
local function d(s, over, extra) local a, r = R.Decide(s, ctx(over, extra)); return { a, r } end
local rare = { source = "nameplate", kind = "rare", id = 99, name = "Morgaine the Sly", classification = "rare" }
local function with(t) local s = {} for k, v in pairs(rare) do s[k] = v end for k, v in pairs(t) do s[k] = v end return s end
emit({
	alert = d(rare),
	rareElite = d(with({ classification = "rareelite" })),
	off = d(rare, { enabled = false }),
	instance = d(rare, nil, { inInstance = true }),
	sourceOff = d(rare, { nameplates = false }),
	targetOff = d(with({ source = "target" }), { target = false }),
	player = d(with({ player = true })),
	elite = d(with({ classification = "elite" })),
	normalKnown = d(with({ classification = "normal", id = 61 })),
	vignette = d(with({ source = "vignette", classification = nil })),
	noKey = d({ source = "nameplate", kind = "rare", classification = "rare" }),
	ignored = d(rare, { ignored = { ["rare:99"] = true } }),
	dead = d(with({ dead = true })),
	alertsOff = d(rare, { alerts = false }),
	treasure = d({ source = "vignette", kind = "treasure", id = 2843, name = "Battered Chest" }),
	treasuresOff = d({ source = "vignette", kind = "treasure", id = 2843 }, { treasureAlerts = false }),
	cooling = d(rare, nil, { history = { ["rare:99"] = { alerted = 100000 - 5 * 60 } } }),
	cooled = d(rare, nil, { history = { ["rare:99"] = { alerted = 100000 - 11 * 60 } } }),
	combat = d(rare, nil, { inCombat = true }),
	combatOn = d(rare, { combatAlerts = true }, { inCombat = true }),
	keys = { R.Key("rare", 61), R.Key("treasure", 2843), R.Key("rare", nil, "Some Name"), R.Key("rare") },
})`);
	assert.deepEqual(out.alert, ['alert']);
	assert.deepEqual(out.rareElite, ['alert']);
	assert.deepEqual(out.off, ['skip', 'off']);
	assert.deepEqual(out.instance, ['skip', 'instance']);
	assert.deepEqual(out.sourceOff, ['skip', 'source']);
	assert.deepEqual(out.targetOff, ['skip', 'source']);
	assert.deepEqual(out.player, ['skip', 'player']);
	assert.deepEqual(out.elite, ['skip', 'notRare'], 'an elite that is not a rare is passed over');
	assert.deepEqual(out.normalKnown, ['alert'], 'a Codex rare counts even when the client calls it normal');
	assert.deepEqual(out.vignette, ['alert'], 'a creature vignette is a rare by the client\'s word');
	assert.deepEqual(out.noKey, ['skip', 'unknown']);
	assert.deepEqual(out.ignored, ['skip', 'ignored']);
	assert.deepEqual(out.dead, ['record', 'dead']);
	assert.deepEqual(out.alertsOff, ['record', 'alertsOff']);
	assert.deepEqual(out.treasure, ['alert']);
	assert.deepEqual(out.treasuresOff, ['record', 'treasuresOff']);
	assert.deepEqual(out.cooling, ['record', 'cooldown']);
	assert.deepEqual(out.cooled, ['alert']);
	assert.deepEqual(out.combat, ['hold', 'combat']);
	assert.deepEqual(out.combatOn, ['alert']);
	assert.deepEqual(out.keys, ['rare:61', 'treasure:2843', 'name:Some Name']);
});

// ---------------------------------------------------- detection and cooldown

test('a rare nameplate alerts once: sound, history, debounce, then the per-rare cooldown', () => {
	const out = run(`
local U = stub.rares
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
local a = got[1]
emit({ n = #got, name = a.name, level = a.level, kind = a.kind, inSight = a.inSight, zone = a.zone, sounds = #stub.sounds })
local e = R.History()["rare:61"]
emit({ name = e.name, n = e.n, src = e.src, map = e.map, x = e.x, alerted = e.alerted == e.t })
-- The same plate again at once: the GUID was just looked at.
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit({ n = #got, seen = R.History()["rare:61"].n })
-- A few seconds on, targeted: seen again, but inside the cooldown.
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
U.unit("target", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = #got, seen = R.History()["rare:61"].n })
-- Past the 10 minute cooldown it alerts again.
stub.advance(11 * 60)
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = #got, source = got[#got].source, sounds = #stub.sounds })`);
	assert.deepEqual(out[0], { n: 1, name: 'Thuros Lightfingers', level: 11, kind: 'rare', inSight: true, zone: 'Elwynn Forest', sounds: 1 });
	assert.deepEqual(out[1], { name: 'Thuros Lightfingers', n: 1, src: 'nameplate', map: 1429, x: 88, alerted: true });
	assert.deepEqual(out[2], { n: 1, seen: 1 });
	assert.deepEqual(out[3], { n: 1, seen: 2 });
	assert.deepEqual(out[4], { n: 2, source: 'target', sounds: 2 });
});

test('Nearby: a spotted rare stays while the client shows it, goes when it dies or is out of sight', () => {
	const out = run(`
local U = stub.rares
local fired = 0
Polestar.On("RARE_NEARBY", function() fired = fired + 1 end)
emit(#R.Nearby())
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit({ R.Nearby()[1], #R.Nearby(), fired })
-- Past the time a sighting is trusted, the plate still shows it: it stays.
stub.advance(60)
emit(#R.Nearby())
-- Dead on the plate and seen again: gone at once.
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare", dead = true })
stub.advance(4)
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit(#R.Nearby())
-- Alive again, then out of sight for good.
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.advance(4)
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit(#R.Nearby())
U.clear("nameplate1")
stub.advance(60)
emit(#R.Nearby())
-- A treasure and an ordinary mob never list.
U.unit("nameplate2", { npc = 257, name = "Kobold Worker", level = 3, class = "normal" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
emit(#R.Nearby())`);
	assert.equal(out[0], 0);
	assert.deepEqual(out[1], ['Thuros Lightfingers', 1, 1]);
	assert.equal(out[2], 1);
	assert.equal(out[3], 0);
	assert.equal(out[4], 1);
	assert.equal(out[5], 0);
	assert.equal(out[6], 0);
});

test('ordinary mobs, players, pets, secret GUIDs and turned-off paths raise nothing', () => {
	const [out] = run(`
local U = stub.rares
U.unit("nameplate1", { npc = 257, name = "Kobold Worker", level = 3, class = "normal" })
U.unit("nameplate2", { npc = 300, name = "Elite Guard", level = 30, class = "elite" })
U.unit("nameplate3", { guid = "Player-1-0000BEEF", name = "Someone", level = 10, class = "rare", player = true })
U.unit("nameplate4", { npc = 99, name = "Tamed Rare", level = 10, class = "rare", controlled = true })
U.unit("nameplate5", { npc = 100, name = "Hidden", level = 10, class = "rare", secret = true })
for i = 1, 5 do stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate" .. i) end
Polestar.Set("rares.mouseover", false)
U.unit("mouseover", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("UPDATE_MOUSEOVER_UNIT")
local n = 0
for _ in pairs(R.History()) do n = n + 1 end
emit({ alerts = #got, history = n, paths = R.Detect.Paths() })`);
	assert.equal(out.alerts, 0);
	assert.equal(out.history, 0);
	assert.deepEqual(out.paths, { vignettes: true, nameplates: true, target: true });
});

test('a Codex rare the client calls normal is caught once the Codex is loaded', () => {
	const [out] = run(`
local U = stub.rares
U.unit("target", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "normal" })
stub.fire("PLAYER_TARGET_CHANGED")
local before = #got
Polestar.Codex.Load()
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
local a = got[1]
emit({ before = before, after = #got, loot = a.loot, map = a.map, x = a.x, f = a.f })`);
	// The rare is in sight, so the waypoint is where it was seen, not a spawn; its loot is counted.
	assert.deepEqual(out, { before: 0, after: 1, loot: 2, map: 1429, x: 88 });
});

test('a rare in sight sets its waypoint where it was seen, not at a known spawn across the zone', () => {
	// Thuros's spawns are at 89.4 and 69.6; the player meets it walking at 75, 60.
	const [out] = run(`
local U = stub.rares
Polestar.Codex.Load()
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
local a = got[1]
local facts = R.Toast.Facts(a)
PolestarRareToast.Waypoint:Click()
local t = Polestar.Nav.GetTarget()
emit({ map = a.map, x = a.x, y = a.y, spawn = a.spawnYards or false, facts = facts, target = { t.map, t.x, t.y } })`, { at: [1429, 75, 60] });
	assert.deepEqual(out, { map: 1429, x: 75, y: 60, spawn: false, facts: 'Level 11 Rare  \u00b7  in sight  \u00b7  Elwynn Forest', target: [1429, 75, 60] });
});

test('a vignette without a position: its nearest known spawn, said so, and the live position once the vignette has one', () => {
	const out = run(`
local U = stub.rares
Polestar.Codex.Load()
-- On the minimap, but no position on the player's map yet.
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers" })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local a = got[1]
emit({ map = a.map, x = a.x, f = a.f, spawn = a.spawnYards and math.floor(a.spawnYards + 0.5), inSight = a.inSight or false, facts = R.Toast.Facts(a) })
-- By the click it has one: the waypoint goes there, not to the spawn.
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 80, y = 70 })
PolestarRareToast.Waypoint:Click()
local t = Polestar.Nav.GetTarget()
emit({ t.map, t.x, t.y, t.f or false })`);
	assert.deepEqual(out[0], { map: 1429, x: 89.4, f: 'e', spawn: 57, inSight: false, facts: 'Level 11 Rare  \u00b7  known spawn 55 yd  \u00b7  Elwynn Forest' });
	assert.deepEqual(out[1], [1429, 80, 70, false]);
});

test('a vignette without a position and no spawn on this continent offers no waypoint, never a spawn it cannot measure', () => {
	const [out] = run(`
local U = stub.rares
Polestar.Codex.Load()
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers" })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local a = got[1]
emit({ n = #got, map = a.map or false, button = PolestarRareToast.Waypoint:IsShown() })`, { at: [1438, 50, 50] });
	assert.deepEqual(out, { n: 1, map: false, button: false });
});

test('a vignette the player\'s subzone map lacks is placed on its parent map', () => {
	const [out] = run(`
local U = stub.rares
local z = stub.world.maps[1429]
stub.world.addMap(9001, { name = "Fargodeep Mine", c = z.c, left = z.left, right = z.right, top = z.top, bottom = z.bottom, parent = 1429, mapType = 5 })
stub.world.moveTo(9001, 88, 78)
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 90, y = 78 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local a = got[1]
emit({ map = a.map, x = a.x, y = a.y, spawn = a.spawnYards or false })`);
	assert.deepEqual(out, { map: 1429, x: 90, y: 78, spawn: false });
});

test('in combat an alert waits for the fight to end, and is dropped when stale', () => {
	const out = run(`
local U = stub.rares
stub.inCombat = true
U.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
emit({ during = #got, seen = R.History()["rare:61"] ~= nil, held = R.Held() ~= nil })
stub.advance(10)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ after = #got, name = got[1] and got[1].name, alerted = R.History()["rare:61"].alerted ~= nil })
-- A second fight, with the rare met over a minute before it ends: no alert.
stub.advance(11 * 60)
stub.inCombat = true
U.unit("nameplate2", { npc = 79, name = "Narg the Taskmaster", level = 10, class = "rareelite" })
stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
stub.advance(90)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ after = #got })`);
	assert.deepEqual(out[0], { during: 0, seen: true, held: true });
	assert.deepEqual(out[1], { after: 1, name: 'Thuros Lightfingers', alerted: true });
	assert.deepEqual(out[2], { after: 1 });
});

test('vignettes: a creature is a rare at its exact distance, a game object a treasure; the scan waits out combat', () => {
	const out = run(`
local U = stub.rares
-- 2 map percent east of the player on Elwynn: about 69 yards.
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 90, y = 78 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local a = got[1]
emit({ kind = a.kind, yards = math.floor(a.yards + 0.5), map = a.map, x = a.x, inSight = a.inSight or false })
U.vignette("V2", { object = 2843, name = "Battered Chest", map = 1429, x = 88, y = 80 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V2", false)
emit({ n = #got })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V2", true)
emit({ n = #got, kind = got[2].kind, name = got[2].name, key = got[2].key })
-- VIGNETTES_UPDATED scans the list two seconds later, never in combat.
U.vignette("V3", { npc = 79, name = "Narg the Taskmaster", map = 1429, x = 70, y = 70 })
stub.inCombat = true
stub.fire("VIGNETTES_UPDATED")
stub.advance(3)
emit({ n = #got })
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(3)
emit({ n = #got, last = got[#got].name })`);
	assert.deepEqual(out[0], { kind: 'rare', yards: 69, map: 1429, x: 90, inSight: false });
	assert.deepEqual(out[1], { n: 1 }, 'a vignette leaving the minimap is not a sighting');
	assert.deepEqual(out[2], { n: 2, kind: 'treasure', name: 'Battered Chest', key: 'treasure:2843' });
	assert.deepEqual(out[3], { n: 2 });
	assert.deepEqual(out[4], { n: 3, last: 'Narg the Taskmaster' });
});

test('nothing is detected inside an instance, and Rares off unwires every path', () => {
	const out = run(`
local U = stub.rares
stub.world.inInstance = true
U.unit("target", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = #got })
stub.world.inInstance = false
Polestar.Set("rares.enabled", false)
stub.advance(4)
stub.fire("PLAYER_TARGET_CHANGED")
emit({ n = #got, paths = R.Detect.Paths() })`);
	assert.deepEqual(out[0], { n: 0 });
	assert.deepEqual(out[1], { n: 0, paths: {} });
});

test('the toast shows the alert: name, facts line, actions; Show rare opens the section event', () => {
	const [out] = run(`
local U = stub.rares
local opened
Polestar.On("SHOW_RARES", function(kind, id) opened = { kind, id } end)
Polestar.Codex.Load()
U.vignette("V1", { npc = 61, name = "Thuros Lightfingers", map = 1429, x = 90, y = 78 })
stub.fire("VIGNETTE_MINIMAP_UPDATED", "V1", true)
local f = PolestarRareToast
local shown = f:IsShown()
local facts = R.Toast.Facts(got[1])
local name = f.Name:GetText()
local label = f.Open.Label:GetText()
f.Open:Click()
emit({ shown = shown, name = name, facts = facts, label = label, opened = opened, hidden = not f:IsShown() })`);
	assert.equal(out.shown, true);
	assert.equal(out.name, 'Thuros Lightfingers');
	assert.equal(out.facts, 'Level 11 Rare  \u00b7  70 yd  \u00b7  Elwynn Forest');
	assert.equal(out.label, 'Show rare');
	assert.deepEqual(out.opened, ['rare', 61]);
	assert.equal(out.hidden, true);
});

test('the treasure toast names what it opens: Show treasure', () => {
	const [out] = run(`
Polestar.Codex.Load()
Polestar.Fire("RARE_SPOTTED", R.AlertOf({ source = "vignette", kind = "treasure", id = 2843, name = "Battered Chest" }, { map = 1429, x = 79.6, y = 55.7 }, true))
emit({ label = PolestarRareToast.Open.Label:GetText() })`);
	assert.equal(out.label, 'Show treasure');
});

// ------------------------------------------------------------ the section

test('signature drop: one the Codex knows only from this rare first, then quality, then item level', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua', 'stub_rares.lua'],
		before: pack.stubLua,
		addons: [{ name: 'Polestar', files: [...FILES.files.slice(0, -1), 'UI/UI.xml', 'Rares/Rares.xml'] }],
		login: true,
		script: `Polestar.Codex.Load()
local R, sig = Polestar.Rares, Polestar.UI.RaresSection.Signature
local rec = R.Info("rare", 61)
local real = sig(rec, R.Codex(false))
-- Fakes: a better green from a quest beats nothing exclusive; an exclusive white beats it.
local items = {
	[1] = { quality = 2, reqLevel = 12, sources = { { type = "quest", quest = 9 } } },
	[2] = { quality = 2, reqLevel = 8, sources = { { type = "drop", npc = 7 }, { type = "vendor", npc = 3 } } },
	[3] = { quality = 1, reqLevel = 1, sources = { { type = "drop", npc = 7 } } },
	[4] = { quality = 4, reqLevel = 60, sources = {} },
}
local C = { Item = function(id) return items[id] end }
emit({ loot = rec.loot, real = real,
	shared = sig({ kind = "rare", id = 7, loot = { 2, 1 } }, C),
	exclusive = sig({ kind = "rare", id = 7, loot = { 1, 2, 3 } }, C),
	unknown = sig({ kind = "rare", id = 7, loot = { 1, 4 } }, C) })`,
	}).emitted;
	assert.deepEqual(out.loot, [1933, 2933]);
	assert.equal(out.real, 1933, "Thuros: Staff of Conjuring (his alone), not Seal of Wrynn (a quest reward)");
	assert.equal(out.shared, 1, 'no exclusive drop: the higher item level');
	assert.equal(out.exclusive, 3, 'its own drop first, whatever its quality');
	assert.equal(out.unknown, 4, 'no known source is not exclusive: quality decides');
});

// ------------------------------------------------------------ pin selection

test('BuildPins: one pin per distinct spawn; grey and placeless rares left out; recent and elite marked', () => {
	const [out] = run(`
local list = {
	{ kind = "rare", id = 1, name = "Low", level = 3, spawns = { { map = 1429, x = 10, y = 10 } } },
	{ kind = "rare", id = 2, name = "Twice", level = 15, spawns = { { map = 1429, x = 20, y = 20, f = "e" }, { map = 1429, x = 20.8, y = 20.5 }, { map = 1429, x = 40, y = 40 }, { map = 1436, x = 20, y = 20 } } },
	{ kind = "rare", id = 3, name = "Third", level = 12, levelMax = 14, spawns = { { map = 1429, x = 50, y = 50 } } },
	{ kind = "rare", id = 4, name = "Big", level = 14, elite = true, spawns = { { map = 1429, x = 60, y = 60 } } },
	{ kind = "rare", id = 5, name = "Nowhere", level = 14, spawns = {} },
	{ kind = "rare", id = 6, name = "Seen", level = 16, spawns = { { map = 1429, x = 70, y = 70 } } },
}
local function sum(pins)
	local out = {}
	for i, p in ipairs(pins) do out[i] = { p.id, p.map, p.x, p.f or false, p.icon, p.ring and true or false, p.glow or false, p.priority } end
	return out
end
local base = { kind = "rare", list = list, level = 20, now = 100000,
	history = { ["rare:6"] = { t = 100000 - 600 }, ["rare:4"] = { t = 100000 - 3 * 86400 } } }
local all = R.BuildPins(base)
base.hideGrey = true
local grey = R.BuildPins(base)
local tre = R.BuildPins({ kind = "treasure", list = { { kind = "treasure", id = 2843, name = "Battered Chest", spawns = { { map = 1429, x = 63.5, y = 56.1, f = "e" } } } } })
emit({ all = sum(all), grey = sum(grey), greyLevel = { R.GreyLevel(5), R.GreyLevel(20), R.GreyLevel(45), R.GreyLevel(60) },
	treasure = { tre[1].icon, tre[1].kind, tre[1].key, tre[1].size }, color = all[1].color, tip = type(all[1].tooltip) })`);
	assert.deepEqual(out.all, [
		[1, 1429, 10, false, 'qol-target', false, false, 2],
		[2, 1429, 20, 'e', 'qol-target', false, false, 2],
		[2, 1429, 40, false, 'qol-target', false, false, 2],
		[2, 1436, 20, false, 'qol-target', false, false, 2],
		[3, 1429, 50, false, 'qol-target', false, false, 2],
		[4, 1429, 60, false, 'qol-target', true, false, 3],
		[6, 1429, 70, false, 'qol-target', false, true, 4],
	]);
	assert.deepEqual(out.grey.map((p) => p[0]), [2, 2, 2, 3, 4, 6], 'level 3 is grey at 20 (grey up to 13)');
	assert.deepEqual(out.greyLevel, [0, 13, 35, 51]);
	assert.deepEqual(out.treasure, ['icon-treasure', 'treasure', 'treasure:2843', 13]);
	assert.equal(out.tip, 'function');
});

test('pin layers follow the settings: minimap kinds load the Codex after login, world kinds wait for the world map', () => {
	const off = run(`
stub.advance(6)
emit({ codex = Polestar.Codex.IsLoaded(), rare = Polestar.Pins.GetLayer("rares.rare") ~= nil })`, { settings: '{ worldRares = true, worldTreasures = true }' });
	// World-map pins alone wait for the world map: nothing loads at login.
	assert.deepEqual(off[0], { codex: false, rare: false });

	const on = run(`
local opts, calls = {}, 0
local set = Polestar.Pins.SetLayer
Polestar.Pins.SetLayer = function(name, pins, o) calls = calls + 1; opts[name] = { n = #pins, world = o.world, minimap = o.minimap } return set(name, pins, o) end
stub.advance(6)
emit({ codex = Polestar.Codex.IsLoaded(), rare = opts["rares.rare"], treasure = opts["rares.treasure"] })
WorldMapFrame:Show()
stub.advance(0.1)
emit({ treasure = opts["rares.treasure"] })
Polestar.Set("rares.worldTreasures", false)
emit({ treasure = Polestar.Pins.GetLayer("rares.treasure") ~= nil, rare = opts["rares.rare"] })
Polestar.Set("rares.ignored", { ["rare:61"] = true })
emit({ rare = opts["rares.rare"] })`, { settings: '{ worldRares = true, worldTreasures = true, minimapRares = true }' });
	assert.equal(on[0].codex, true);
	// The sample Codex: 1 placed rare (2 spawns), 1 treasure (2 spawns). The
	// treasure layer is world-map only, so it waits for the map to open.
	assert.deepEqual(on[0].rare, { n: 2, world: true, minimap: true });
	assert.equal(on[0].treasure, undefined);
	assert.deepEqual(on[1].treasure, { n: 2, world: true, minimap: false });
	assert.deepEqual(on[2], { treasure: false, rare: { n: 2, world: true, minimap: true } });
	assert.equal(on[3].rare.n, 2, 'muting alerts keeps the rare on the map');
});

test('loading the Codex decodes nothing for the pins until a layer is due, and never inside the load', () => {
	const [out] = run(`
local decoded = 0
local info = R.Info
R.Info = function(...) decoded = decoded + 1 return info(...) end
Polestar.Codex.Load()
local during = decoded
stub.advance(1)
local idle = decoded
-- A minimap kind turned on: the build starts on the next frame, in batches.
Polestar.Set("rares.minimapRares", true)
local sync = decoded
stub.advance(0.1)
emit({ during = during, idle = idle, sync = sync, built = decoded > 0, layer = Polestar.Pins.GetLayer("rares.rare") ~= nil })`);
	assert.deepEqual(out, { during: 0, idle: 0, sync: 0, built: true, layer: true });
});
