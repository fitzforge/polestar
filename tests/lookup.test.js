'use strict';
// The Lookup runtime: Lookup.Sources ranking for the character (faction,
// race, class, level, professions, reputation, distance, drop chance),
// curated and generated guides, Search over guides and Codex entities,
// Polestar.Hooks (tooltip lines, item clicks), the mount spotter, tooltip
// source lines, Alt-click and the options page. The Codex is a synthetic pack
// (tests/fixtures/codex/lookup.json) loaded the way the client loads it.

const { test, before, after } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');
const { writeCodexPack } = require('./helpers/codex');

const FIXTURE = path.join(__dirname, 'fixtures', 'codex', 'lookup.json');
const codex = JSON.parse(fs.readFileSync(FIXTURE, 'utf8'));
const ADDON = { name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Lookup.xml'] };

// The stub world draws the fixture's maps with the same bounds as their Era
// frames, so live and Era coordinates agree.
const MAPS = Object.entries(codex.frames)
	.map(([id, f]) => `w.addMap(${id}, { name = ${JSON.stringify(codex.zones[id].name)}, c = ${f.c}, left = ${f.left}, right = ${f.right}, top = ${f.top}, bottom = ${f.bottom} })`)
	.join('\n');

let pack;
before(() => {
	pack = writeCodexPack(codex);
});
after(() => pack && pack.cleanup());

function run(script, opts = {}) {
	const { level = 20, race = 'Human', faction = 'Alliance', cls = 'WARRIOR', at = [9001, 50, 50], withPack = true, files = ADDON, saved, setup = '' } = opts;
	return runAddon({
		stubs: ['stub_world.lua', 'stub_lookup_runtime.lua'],
		before: `${withPack ? pack.stubLua : ''}
local w = stub.world
${MAPS}
w.level, w.race, w.raceName, w.faction = ${level}, ${JSON.stringify(race)}, ${JSON.stringify(race)}, ${JSON.stringify(faction)}
w.class, w.className = ${JSON.stringify(cls)}, ${JSON.stringify(cls)}
w.moveTo(${at.join(', ')})
${setup}`,
		addons: [files],
		saved: saved ? { Polestar: saved } : undefined,
		login: true,
		script: `
local function rows(kind, id)
	local list, entity = Polestar.Lookup.Sources(kind, id)
	local out = {}
	for i, r in ipairs(list) do
		out[i] = { type = r.type, label = r.label, detail = r.detail, available = r.available, why = r.why, whyText = r.whyText,
			travel = r.travel and math.floor(r.travel + 0.5), effort = r.effort and math.floor(r.effort + 0.5), chance = r.chance,
			map = r.map, x = r.x, y = r.y, guideable = r.guideable, trainer = r.trainer, price = r.price }
	end
	return out, entity
end
${script}`,
	}).emitted;
}

const pick = (list, keys) => list.map((r) => Object.fromEntries(keys.map((k) => [k, r[k]])));

// ---------------------------------------------------------------------------
// Sources
// ---------------------------------------------------------------------------

test('sources: the other faction is unavailable, the nearer vendor ranks first', () => {
	const [list, horde] = run(`emit((rows("mount", 8000)))`).concat(
		run(`emit((rows("mount", 8000)))`, { race: 'Orc', faction: 'Horde' }),
	);
	assert.deepEqual(pick(list, ['label', 'available', 'why', 'detail']), [
		{ label: 'Mira Saddler', available: true, why: undefined, detail: 'Vendor \u00b7 Amber Vale' },
		{ label: 'Tobin Far', available: true, why: undefined, detail: 'Vendor \u00b7 Ember Hollow' },
		{ label: 'Grosh Saddler', available: false, why: 'faction', detail: 'Vendor \u00b7 Amber Vale' },
	]);
	assert.ok(list[0].travel < list[1].travel, 'Mira is nearer than Tobin');
	assert.equal(list[0].price, 100000);
	assert.equal(list[2].whyText, 'Horde only');
	assert.deepEqual(pick(horde, ['label', 'available']), [
		{ label: 'Grosh Saddler', available: true },
		{ label: 'Mira Saddler', available: false },
		{ label: 'Tobin Far', available: false },
	]);
});

test('sources: required item level, quest minLevel and mob level gate a source', () => {
	const [low, peril, grumble] = run(`
		emit((rows("mount", 8000)))
		emit((rows("item", 8002)))
		emit((rows("item", 8007)))
	`, { level: 15 });
	assert.ok(low.every((r) => !r.available));
	assert.ok(low.filter((r) => r.label !== 'Grosh Saddler').every((r) => r.why === 'level' && r.whyText === 'Requires level 20'));
	assert.deepEqual(pick(peril, ['type', 'available', 'why', 'whyText']), [
		{ type: 'drop', available: true, why: undefined, whyText: undefined },
		{ type: 'quest', available: false, why: 'level', whyText: 'Requires level 30' },
	]);
	assert.deepEqual(pick(grumble, ['available', 'why']), [{ available: false, why: 'level' }]);
	const [ok] = run(`emit((rows("mount", 8000)))`, { level: 20 });
	assert.ok(ok[0].available);
});

test('sources: professions gate crafts unless the character can still learn them', () => {
	const script = `emit((rows("item", 8005)))`;
	const [none] = run(script);
	const [full] = run(script, { setup: 'w.learnSkill(164, "Blacksmithing", 50, 75); w.learnSkill(186, "Mining", 60, 75)' });
	const [low] = run(script, { setup: 'w.learnSkill(197, "Tailoring", 80, 150)' });
	const [high] = run(script, { setup: 'w.learnSkill(197, "Tailoring", 120, 150)' });
	const [stubbed] = run(`
		Polestar.Compat.GetSkillRank = function(line) if line == 197 then return 150, 225 end end
		emit((rows("item", 8005)))
	`);
	assert.deepEqual(pick(none, ['available', 'label', 'trainer', 'map']), [{ available: true, label: 'Tailoring 100', trainer: 5010, map: 9001 }]);
	assert.deepEqual(pick(full, ['available', 'why', 'whyText']), [{ available: false, why: 'profession', whyText: 'Requires Tailoring' }]);
	assert.ok(low[0].available && high[0].available && stubbed[0].available);
	assert.ok(none[0].effort > low[0].effort, 'learning the profession costs more than skilling up');
	assert.ok(low[0].effort > high[0].effort, 'missing skill points cost effort');
	assert.equal(high[0].effort, stubbed[0].effort);
});

test('sources: reputation and the faction of a reputation gate a source', () => {
	const [before, wolf] = run(`emit((rows("tabard", 8006))); emit((rows("mount", 8012)))`);
	const [after] = run(`emit((rows("tabard", 8006)))`, { setup: 'w.setRep(9100, "Vale Wardens", 7, 0, 0, 21000)' });
	assert.deepEqual(pick(before, ['available', 'why', 'label', 'detail']), [
		{ available: false, why: 'reputation', label: 'Vale Wardens', detail: 'Reputation \u00b7 Revered' },
	]);
	assert.equal(before[0].whyText, 'Requires Revered (Neutral)');
	assert.equal(before[0].effort, 3 * 14400);
	assert.deepEqual(pick(after, ['available', 'effort']), [{ available: true, effort: 0 }]);
	assert.deepEqual(pick(wolf, ['available', 'why']), [{ available: false, why: 'faction' }]);
});

test('sources: a vendor that sells only at a standing or a skill rank', () => {
	const script = `emit((rows("mount", 8016))); emit((rows("recipe", 8017)))`;
	const [reins, pattern] = run(script);
	const [reinsOk, patternOk] = run(script, {
		setup: 'w.setRep(9100, "Vale Wardens", 8, 0, 0, 1000); w.learnSkill(197, "Tailoring", 130, 150)',
	});
	const [, patternLow] = run(script, { setup: 'w.learnSkill(197, "Tailoring", 100, 150)' });
	assert.deepEqual(pick(reins, ['type', 'label', 'available', 'why', 'whyText', 'effort']), [
		{ type: 'vendor', label: 'Quartermaster Ilsa', available: false, why: 'reputation', whyText: 'Requires Exalted (Vale Wardens)', effort: 4 * 14400 },
	]);
	assert.deepEqual(pick(pattern, ['type', 'available', 'why', 'whyText']), [
		{ type: 'vendor', available: false, why: 'profession', whyText: 'Requires Tailoring 125' },
	]);
	assert.ok(pattern[0].effort > patternLow[0].effort, 'fewer missing skill points cost less');
	assert.equal(patternLow[0].why, 'profession');
	assert.deepEqual(pick(reinsOk, ['available', 'effort']), [{ available: true, effort: 0 }]);
	assert.deepEqual(pick(patternOk, ['available', 'effort']), [{ available: true, effort: 0 }]);
});

test('sources: a quest whose rewards need a standing (QuestieDB requiredMinRep) gates its reward row', () => {
	const script = `emit((rows("item", 8018)))`;
	const [band] = run(script);
	const [bandOk] = run(script, { setup: 'w.setRep(9100, "Vale Wardens", 6, 0, 0, 12000)' });
	assert.deepEqual(pick(band, ['type', 'label', 'available', 'why', 'whyText']), [
		{ type: 'quest', label: "The Wardens' Commission", available: false, why: 'reputation', whyText: 'Requires Honored (Vale Wardens)' },
	]);
	assert.ok(band[0].effort >= 2 * 14400, 'the missing standings cost the grind');
	assert.deepEqual(pick(bandOk, ['available', 'why']), [{ available: true, why: undefined }]);
});

test('sources: a better drop chance ranks first; race, class and unknown races', () => {
	const [tusk, totem, charger] = run(`emit((rows("item", 8004))); emit((rows("item", 8003))); emit((rows("mount", 8011)))`);
	assert.deepEqual(pick(tusk, ['label', 'chance']), [{ label: 'Bristle Boar', chance: 50 }, { label: 'Thornback Boar', chance: 5 }]);
	assert.ok(Math.abs(tusk[1].effort / tusk[0].effort - 10) < 0.01, 'expected kills scale with 100 / chance');
	assert.deepEqual(pick(totem, ['available', 'why']), [{ available: false, why: 'race' }, { available: false, why: 'race' }]);
	assert.deepEqual(pick(charger, ['available', 'why', 'whyText']), [{ available: false, why: 'class', whyText: 'Class mount' }]);
	// A race the Era masks do not know (a Forever race) is never excluded by them.
	const [newRace] = run(`emit((rows("item", 8003)))`, { race: 'Dracthyr' });
	assert.ok(newRace.every((r) => r.available));
	const [paladin] = run(`emit((rows("mount", 8011)))`, { cls: 'PALADIN' });
	assert.ok(paladin[0].available);
});

test('sources: rare, instance, object, world drop and container rows', () => {
	const [rare, crypt, chest, world] = run(`
		emit((rows("item", 8014))); emit((rows("item", 8008))); emit((rows("item", 8009))); emit((rows("item", 8015)))
	`);
	assert.equal(rare[0].label, 'Gnash the Unseen');
	assert.ok(rare[0].effort > 4 * 1800, 'a rare waits for its respawn');
	assert.deepEqual(pick(crypt, ['label', 'detail', 'map', 'x', 'y', 'guideable', 'available']), [
		{ label: 'Lord Ashcroft', detail: 'Drop \u00b7 Ashen Crypt', map: 9001, x: 30, y: 70, guideable: true, available: true },
	]);
	assert.equal(crypt[0].effort, 5 * 2400);
	assert.deepEqual(pick(chest, ['label', 'detail', 'chance', 'guideable']), [{ label: 'Weathered Chest', detail: 'Treasure \u00b7 Amber Vale', chance: 40, guideable: true }]);
	assert.deepEqual(pick(world, ['label', 'detail', 'guideable']), [{ label: 'World drop', detail: 'World drop \u00b7 Level 10-30', guideable: false }]);
});

test('sources: NPCs, quests, dungeons and zones give location rows', () => {
	const [npc, quest, inst, zone] = run(`
		emit((rows("rare", 5011)))
		emit((rows("quest", 7001)))
		emit((rows("instance", "ashen_crypt")))
		local list, z = rows("zone", 9001); emit({ n = #list, name = z.name })
	`);
	assert.deepEqual(pick(npc, ['type', 'label', 'detail', 'map', 'x', 'y']), [
		{ type: 'spawn', label: 'Gnash the Unseen', detail: 'Amber Vale \u00b7 Level 21', map: 9001, x: 70, y: 30 },
	]);
	assert.deepEqual(pick(quest, ['type', 'label', 'detail', 'available', 'guideable']), [
		{ type: 'start', label: 'Elder Rowan', detail: 'Starts the quest \u00b7 Amber Vale', available: true, guideable: true },
		{ type: 'end', label: 'Captain Hale', detail: 'Ends the quest \u00b7 Amber Vale', available: true, guideable: true },
	]);
	assert.deepEqual(pick(inst, ['type', 'label', 'detail', 'map']), [{ type: 'entrance', label: 'Ashen Crypt', detail: 'Entrance \u00b7 Amber Vale', map: 9001 }]);
	assert.deepEqual(zone, { n: 0, name: 'Amber Vale' });
});

// A French client whose names pack lands after the first look: the Codex
// names Elder Rowan in French from then on, and so must the cached rows.
test('sources: a names pack landing late renames the cached rows', () => {
	const [before, after] = run(`
		local label = function() return rows("quest", 7001)[1].label end
		emit(label())
		local N = Polestar.Names
		N.Localised = function() return true end
		local cached = N.Cached
		N.Cached = function(kind, id) if kind == "npc" and id == 5008 then return "Ancien Rowan" end return cached(kind, id) end
		Polestar.Fire("NAMES_LOADED")
		emit(label())
	`);
	assert.equal(before, 'Elder Rowan');
	assert.equal(after, 'Ancien Rowan');
});

test('sources: an already finished quest is not offered as available', () => {
	const [list] = run(`emit((rows("item", 8001)))`, { level: 20, setup: 'w.complete({ 7002 })' });
	assert.deepEqual(pick(list, ['available', 'why', 'whyText']), [{ available: false, why: 'done', whyText: 'Already done' }]);
});

// ---------------------------------------------------------------------------
// Guides: curated and generated
// ---------------------------------------------------------------------------

const GUIDES = `
${TEST_PACK}
${TEST_SOURCE}
local function g(id, extra)
	local def = { id = id, pack = "test", title = id, category = "Collectibles", steps = { { goals = { { t = "note", text = "x" } } } } }
	for k, v in pairs(extra) do def[k] = v end
	assert(Polestar.RegisterGuide(def))
end
g("test/horde-strider", { faction = "Horde", collects = { 8000 } })
g("test/alliance-strider", { faction = "Alliance", collects = { 8000, 8013 } })
g("test/shadowsteed", { keywords = { "Warlock", "Summon Shadowsteed" } })
-- A leveling guide makes the test pack a suggestion source (TEST_SOURCE).
g("test/route", { category = "Leveling", minLevel = 1, maxLevel = 60 })
`;

test('curated guides: the one for this character, and class mounts by keyword', () => {
	const [alliance, spell, none, opened, tabs] = run(`${GUIDES}
		local L = Polestar.Lookup
		emit(L.CuratedGuide("mount", 8000)); emit(L.CuratedGuide("spell", 9503)); emit(L.CuratedGuide("item", 8004) or false)
		emit(L.Guide("pet", 8013))
		local t = Polestar.Engine.GetTabs(); emit({ t[#t].guideId, Polestar.Engine.GetGuide().id })
	`);
	assert.equal(alliance, 'test/alliance-strider');
	assert.equal(spell, 'test/shadowsteed');
	assert.equal(none, false);
	assert.equal(opened, 'test/alliance-strider');
	assert.deepEqual(tabs, ['test/alliance-strider', 'test/alliance-strider']);
	const [horde] = run(`${GUIDES} emit(Polestar.Lookup.CuratedGuide("mount", 8000))`, { race: 'Orc', faction: 'Horde' });
	assert.equal(horde, 'test/horde-strider');
});

test('generated guides: registered unsaved in pack "lookup", opened in a tab, rebuilt for another source', () => {
	const [first, def, second, tabs, step] = run(`
		local L = Polestar.Lookup
		emit({ L.Guide("item", 8004) })
		local g = Polestar.Guides.Get("lookup/item/8004")
		emit({ pack = g.pack, category = g.category, title = g.title, steps = #g.steps, step1 = g.steps[1].title,
			goals = { g.steps[1].goals[1].t, g.steps[1].goals[2].t, g.steps[1].goals[3].t }, pack2 = Polestar.Guides.Pack("lookup").id })
		emit({ L.Guide("item", 8004, 2) })
		local t = Polestar.Engine.GetTabs(); local ids = {}
		for i, x in ipairs(t) do ids[i] = x.guideId end
		emit(ids)
		emit(Polestar.Engine.GetGuide().steps[1].title)
	`);
	assert.deepEqual(first, ['lookup/item/8004']);
	assert.deepEqual(def, { pack: 'lookup', category: 'Lookup', title: 'Boar Tusk', steps: 1, step1: 'Bristle Boar', goals: ['goto', 'kill', 'collect'], pack2: 'lookup' });
	assert.deepEqual(second, ['lookup/item/8004']);
	assert.deepEqual(tabs, ['lookup/item/8004']);
	assert.equal(step, 'Thornback Boar');
});

test('Polestar holds the internal lookup pack from load: a pack claiming it later is refused, listed, and Lookup still works', () => {
	const [claim, rows, held, opened] = run(`
		emit({ Polestar.RegisterPack({ addon = "SneakyLookup", id = "lookup", format = 1, title = "Mine", author = "X", version = "1", license = "MIT", internal = true }) })
		stub.addonLoaded("SneakyLookup")
		local rows = {}
		for _, r in ipairs(Polestar.Guides.Packs()) do rows[#rows + 1] = { id = r.id, addon = r.addon or false, status = r.status, reason = r.reason or false } end
		emit(rows)
		local p = Polestar.Guides.Pack("lookup")
		emit({ internal = p.internal or false, status = p.status, addon = p.addon or false })
		emit({ Polestar.Lookup.Guide("item", 8004) })
	`);
	assert.equal(claim[0], false);
	const sneaky = rows.filter((r) => r.addon === 'SneakyLookup');
	assert.equal(sneaky.length, 1, JSON.stringify(rows));
	assert.equal(sneaky[0].status, 'refused');
	assert.match(sneaky[0].reason, /internal/);
	assert.deepEqual(held, { internal: true, status: 'on', addon: false });
	assert.deepEqual(opened, ['lookup/item/8004']);
});

test('generated guides: no guide for sources without a place; disabled module', () => {
	const [world, disabled] = run(`
		local function try(...) local id, why = Polestar.Lookup.Guide(...); return { id = id or false, why = why or false } end
		emit(try("item", 8015))
		Polestar.Set("lookup.enabled", false)
		emit(try("item", 8004))
	`);
	assert.deepEqual(world, { id: false, why: 'noguide' });
	assert.deepEqual(disabled, { id: false, why: 'disabled' });
});

test('generated guides: a saved Lookup tab is rebuilt before the Engine reopens tabs', () => {
	const [tabs, active] = run(`
		local t = Polestar.Engine.GetTabs(); local ids = {}
		for i, x in ipairs(t) do ids[i] = x.guideId end
		emit(ids); emit(Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id)
	`, { saved: 'PolestarCharDB = { schema = 1, tabs = { "lookup/item/8004", "lookup/mount/8000" }, activeTab = 2 }' });
	assert.deepEqual(tabs, ['lookup/item/8004', 'lookup/mount/8000']);
	assert.equal(active, 'lookup/mount/8000');
});

// ---------------------------------------------------------------------------
// Search
// ---------------------------------------------------------------------------

const SEARCH_GUIDES = `
${TEST_PACK}
${TEST_SOURCE}
assert(Polestar.RegisterGuide({ id = "test/pathfinder", pack = "test", title = "Amber Vale Pathfinder", zoneName = "Amber Vale", minLevel = 15, maxLevel = 20,
	keywords = { "strider" }, steps = { { goals = { { t = "note", text = "x" } } } } }))
assert(Polestar.RegisterGuide({ id = "lookup/item/1", pack = "lookup", title = "Amber Generated", steps = { { goals = { { t = "note", text = "x" } } } } }))
local function q(text, opts)
	local res, counts = Polestar.Search.Query(text, opts)
	local out = {}
	for i, r in ipairs(res) do out[i] = { kind = r.kind, id = r.id, title = r.title, subtitle = r.subtitle, quality = r.quality } end
	return { res = out, counts = counts }
end
`;

test('search: tiers, kind order, guides with keywords, filters and counts', () => {
	const [amber, exact, boar, npcOnly, strider, rider, words, accent, status] = run(`${SEARCH_GUIDES}
		emit(q("amber")); emit(q("Amber Vale")); emit(q("boar")); emit(q("boar", { kinds = { npc = true } }))
		emit(q("strider")); emit(q("rider")); emit(q("reins strider")); emit(q("M\\195\\174RA"))
		emit({ Polestar.Search.Status() })
	`);
	const titles = (r) => r.res.map((x) => `${x.kind}:${x.title}`);
	assert.deepEqual(titles(amber), ['guide:Amber Vale Pathfinder', 'mount:Amber Strider Reins', 'zone:Amber Vale']);
	assert.deepEqual(amber.res[0], { kind: 'guide', id: 'test/pathfinder', title: 'Amber Vale Pathfinder', subtitle: 'Amber Vale \u00b7 15-20' });
	assert.deepEqual(amber.res[1], { kind: 'mount', id: 8000, title: 'Amber Strider Reins', subtitle: 'Vendor \u00b7 Amber Vale', quality: 3 });
	assert.deepEqual(titles(exact).slice(0, 2), ['zone:Amber Vale', 'guide:Amber Vale Pathfinder']);
	assert.deepEqual(titles(boar), ['item:Boar Tusk', 'npc:Bristle Boar', 'npc:Thornback Boar']);
	assert.deepEqual(boar.counts, { item: 1, npc: 2 });
	assert.equal(boar.res[1].subtitle, 'Amber Vale \u00b7 Level 18');
	assert.deepEqual(titles(npcOnly), ['npc:Bristle Boar', 'npc:Thornback Boar']);
	assert.deepEqual(titles(strider), ['guide:Amber Vale Pathfinder', 'mount:Amber Strider Reins']);
	assert.deepEqual(titles(rider), ['mount:Amber Strider Reins', 'guide:Amber Vale Pathfinder']);
	assert.deepEqual(titles(words), ['mount:Amber Strider Reins']);
	assert.deepEqual(titles(accent), ['npc:Mira Saddler']);
	assert.deepEqual(status, [true]);
});

test('search: folding, quests and dungeons, limits, a missing Codex pack, Lookup switched off', () => {
	const [fold, quest, crypt, limited, status] = run(`${SEARCH_GUIDES}
		emit(Polestar.Search.Fold("\\195\\129mber V\\195\\161le's  Path-finder"))
		emit(q("trouble")); emit(q("crypt")); emit(q("a", { limit = 2 }))
		emit({ Polestar.Search.Status() })
	`);
	assert.equal(fold, ' amber vales path finder');
	assert.deepEqual(quest.res, [{ kind: 'quest', id: 7001, title: 'Trouble in the Vale', subtitle: 'Level 18 \u00b7 Amber Vale' }]);
	assert.deepEqual(crypt.res.map((r) => [r.kind, r.title, r.subtitle]), [
		['item', 'Crypt Blade', 'Drop \u00b7 Ashen Crypt'],
		['instance', 'Ashen Crypt', 'Dungeon \u00b7 18-26'],
	]);
	assert.equal(limited.res.length, 2);
	assert.deepEqual(status, [true]);
	const [st0, res, st1] = run(`${SEARCH_GUIDES}
		emit({ Polestar.Search.Status() }); emit(q("amber")); emit({ Polestar.Search.Status() })
	`, { withPack: false });
	assert.deepEqual(st0, [false, 'notloaded']);
	assert.deepEqual(res.res.map((r) => r.kind), ['guide'], 'without the pack only guides are found');
	assert.deepEqual(st1, [false, 'missing']);
	const [offStatus, offRes, loaded] = run(`${SEARCH_GUIDES}
		Polestar.Set("lookup.enabled", false)
		emit({ Polestar.Search.Status() }); emit(q("amber")); emit(Polestar.Codex.IsLoaded())
	`);
	assert.deepEqual(offStatus, [false, 'off']);
	assert.deepEqual(offRes.res.map((r) => r.kind), ['guide']);
	assert.equal(loaded, false, 'a switched-off Lookup never loads the Codex');
});

test('search and sources: obtainable before retired, curated-guide-backed before name match', () => {
	// Three sabers: a short name no longer sold (retired), a plain one, and one
	// a curated guide collects; plus a pet with no known source.
	const extra = JSON.parse(JSON.stringify(codex));
	const vendor = extra.items[8000].sources[0];
	extra.items[8100] = { id: 8100, name: 'Saber Reins', quality: 4, kind: 'mount', spell: null, reqLevel: null, status: 'retired', sources: [{ ...vendor }] };
	extra.items[8101] = { id: 8101, name: 'Reins of the Plain Saber', quality: 3, kind: 'mount', spell: null, reqLevel: null, sources: [{ ...vendor }] };
	extra.items[8102] = { id: 8102, name: 'Reins of the Striped Saber', quality: 3, kind: 'mount', spell: null, reqLevel: null, sources: [{ ...vendor }] };
	extra.items[8103] = { id: 8103, name: 'Saber Kitten', quality: 1, kind: 'pet', spell: null, reqLevel: null, status: 'nosource', sources: [] };
	const own = writeCodexPack(extra);
	try {
		const [res, rows, guide] = run(`
			${TEST_PACK}
${TEST_SOURCE}
			assert(Polestar.RegisterGuide({ id = "test/sabers", pack = "test", title = "Striped Sabers", collects = { 8102 },
				steps = { { goals = { { t = "note", text = "x" } } } } }))
			local res = Polestar.Search.Query("saber")
			local out = {}
			for i, r in ipairs(res) do out[i] = { kind = r.kind, id = r.id, status = r.status or false, curated = r.curated or false } end
			emit(out)
			local list = Polestar.Lookup.Sources("mount", 8100)
			emit({ available = list[1].available, why = list[1].why, whyText = list[1].whyText, guideable = list[1].guideable })
			local id, why = Polestar.Lookup.Guide("mount", 8100)
			emit({ id = id or false, why = why or false })
		`, { withPack: false, setup: own.stubLua });
		assert.deepEqual(res.filter((r) => r.kind !== 'guide'), [
			{ kind: 'mount', id: 8102, status: false, curated: true },
			{ kind: 'mount', id: 8101, status: false, curated: false },
			{ kind: 'mount', id: 8100, status: 'retired', curated: false },
			{ kind: 'pet', id: 8103, status: 'nosource', curated: false },
		]);
		assert.deepEqual(rows, { available: false, why: 'retired', whyText: 'No longer obtainable', guideable: false });
		assert.deepEqual(guide, { id: false, why: 'noguide' });
	} finally {
		own.cleanup();
	}
});

test('search: an item only a third pack collects ranks as curated only while that pack is the suggestion source', () => {
	const extra = JSON.parse(JSON.stringify(codex));
	const vendor = extra.items[8000].sources[0];
	extra.items[8102] = { id: 8102, name: 'Reins of the Striped Saber', quality: 3, kind: 'mount', spell: null, reqLevel: null, sources: [{ ...vendor }] };
	const own = writeCodexPack(extra);
	try {
		const [before, after] = run(`
			${TEST_PACK}
${TEST_SOURCE}
			Polestar.RegisterPack({ addon = "Polestar_Other", id = "other", format = 1, title = "Other", author = "O", version = "1", license = "MIT" })
			local function g(id, extra)
				local def = { id = id, pack = "other", title = id, steps = { { goals = { { t = "note", text = "x" } } } } }
				for k, v in pairs(extra) do def[k] = v end
				assert(Polestar.RegisterGuide(def))
			end
			g("other/sabers", { category = "Collectibles", collects = { 8102 } })
			g("other/route", { category = "Leveling", minLevel = 1, maxLevel = 60 })
			local function flag()
				for _, r in ipairs(Polestar.Search.Query("striped saber")) do
					if r.kind == "mount" and r.id == 8102 then return r.curated or false end
				end
				return "missing"
			end
			emit(flag())
			Polestar.Set("behavior.suggestFrom", "other")
			emit(flag())
		`, { withPack: false, setup: own.stubLua });
		assert.equal(before, false, 'no curated guide opens for it from another pack');
		assert.equal(after, true);
	} finally {
		own.cleanup();
	}
});

test('search: one-letter queries read name prefixes only, capped; paging with offset; lazy subtitles', () => {
	const [one, page1, page2, lazy] = run(`
		local names = {}
		for i = 1, 400 do names[i] = { 100000 + i, (i % 2 == 0 and "Kestrel " or "Old Kestrel ") .. i } end
		local lines = {}
		for i, e in ipairs(names) do lines[i] = "\\2" .. Polestar.Search.Fold(e[2]):sub(2) .. "\\1" .. e[1] .. ",2,," .. #e[2] .. "\\n" end
		local blob = table.concat(lines)
		local byId = {}
		for _, e in ipairs(names) do byId[e[1]] = e[2] end
		local none = function() return nil end
		Polestar.Codex = { IsLoaded = function() return true end, Load = function() return true end,
			Index = function(kind) if kind == "item" then return blob end end,
			Name = function(kind, id) return byId[id] end,
			Item = none, Npc = none, Quest = none, Object = none, Instance = none, Zone = none, Faction = none, Spell = none }
		local res, counts, more = Polestar.Search.Query("k", { kinds = { item = true } })
		emit({ n = #res, count = counts.item, more = more.item or false, first = res[1] and res[1].title })
		local a = Polestar.Search.Query("kestrel", { kinds = { item = true }, perKind = 50, subtitles = false })
		local b = Polestar.Search.Query("kestrel", { kinds = { item = true }, perKind = 50, offset = 50, subtitles = false })
		emit({ n = #a, first = a[1].title, last = a[#a].title }); emit({ n = #b, first = b[1].title })
		local calls = 0
		Polestar.Lookup = { Subtitle = function(kind, id) calls = calls + 1; return "Sub " .. id end }
		local c = Polestar.Search.Query("kestrel 3", { kinds = { item = true }, subtitles = false })
		local before = calls
		local s1 = Polestar.Search.Subtitle(c[1]); Polestar.Search.Subtitle(c[1])
		emit({ before = before, after = calls, s1 = s1 })
	`, { withPack: false });
	assert.deepEqual(one, { n: 60, count: 200, more: false, first: 'Kestrel 2' }, 'one letter: names starting with k only, not the word "Kestrel" in "Old Kestrel"');
	assert.deepEqual(page1, { n: 50, first: 'Kestrel 2', last: 'Kestrel 100' });
	assert.equal(page2.n, 50);
	assert.notEqual(page2.first, page1.first);
	assert.deepEqual(lazy, { before: 0, after: 1, s1: 'Sub 100030' });
});

// Search speed without pinning one machine's: a keystroke is timed against
// the same run's cost of scanning every name once (one plain find over each
// index, what any search must do), and 25,000 names against 2,500. A search
// rebuilding its index per keystroke (a Lua pass over every line) costs far
// more than a few C scans; a quadratic one grows ~100x over 10x the names.
// Each figure is the median of several batches, each batch long enough for
// a coarse os.clock (Windows: 1 ms).
test('search: a keystroke costs a few scans of the names and grows linearly from 2,500 to 25,000', () => {
	const [small, large] = run(`
		local syll = { "ka", "lo", "mi", "ra", "tor", "vel", "shi", "dun", "gar", "eth", "ul", "bri", "sta", "zor", "nim", "pe" }
		local queries = { "k", "ka", "tor", "torvel", "mi ra", "shidun", "zz", "gar eth", "Velka", "a", "nimpe sta", "ulbri" }
		local function median(fn, batches)
			local t = {}
			for b = 1, batches do
				local c = os.clock()
				fn()
				t[b] = os.clock() - c
			end
			table.sort(t)
			return t[math.ceil(batches / 2)]
		end
		local function measure(scale)
			local seed = 7
			local function rnd(n) seed = (seed * 1103515245 + 12345) % 2147483648; return seed % n + 1 end
			local function word() local s = ""; for _ = 1, rnd(3) + 1 do s = s .. syll[rnd(#syll)] end return s:sub(1, 1):upper() .. s:sub(2) end
			local plan = { item = 15000 * scale, npc = 6000 * scale, quest = 3800 * scale, mount = 200 * scale }
			local blobs, names = {}, {}
			for kind, n in pairs(plan) do
				local lines = {}
				names[kind] = {}
				for i = 1, n do
					local name = word() .. " " .. word() .. (rnd(3) == 1 and (" " .. word()) or "")
					names[kind][i] = name
					lines[i] = "\\2" .. Polestar.Search.Fold(name):sub(2) .. "\\1" .. i .. ",2,," .. #name .. "\\n"
				end
				blobs[kind] = table.concat(lines)
			end
			local none = function() return nil end
			Polestar.Codex = { IsLoaded = function() return true end, Load = function() return true end,
				Index = function(kind) return blobs[kind] end,
				Name = function(kind, id) return names[kind] and names[kind][id] end,
				Item = none, Npc = none, Quest = none, Object = none, Instance = none, Zone = none, Faction = none, Spell = none }
			Polestar.Search.Query("warmup", { subtitles = false })
			-- The batches: every query 4 times; 40 scans of every index.
			local keys = median(function()
				for _ = 1, 4 do for _, text in ipairs(queries) do Polestar.Search.Query(text, { subtitles = false }) end end
			end, 7) / (4 * #queries)
			local scan = median(function()
				for _ = 1, 40 do for _, blob in pairs(blobs) do string.find(blob, "\\2qqqq", 1, true) end end
			end, 7) / 40
			return { key = keys * 1000, scan = scan * 1000 }
		end
		emit(measure(0.1))
		emit(measure(1))
	`, { withPack: false });
	const ms = (t) => `keystroke ${t.key.toFixed(3)} ms, one scan ${t.scan.toFixed(3)} ms`;
	// Here (Linux, lua5.1): a keystroke ~3 scans, 25,000 names ~2.5x 2,500;
	// a Lua pass over every line alone costs ~35 scans.
	assert.ok(large.key < 12 * Math.max(large.scan, 0.01), `25,000 names: ${ms(large)}: more than 12 scans a keystroke`);
	assert.ok(large.key < 15 * Math.max(small.key, 0.01), `25,000 names ${ms(large)} vs 2,500 ${ms(small)}: grows faster than the names`);
});

// ---------------------------------------------------------------------------
// Hooks
// ---------------------------------------------------------------------------

test('hooks: item lines once per tooltip show, in order, errors isolated, forbidden and secret skipped', () => {
	const [once, cleared, forbidden, secret, other, ref, replaced] = run(`
		local H = Polestar.Hooks
		H.ItemLines("a", function(tt, link, id) H.AddLine(tt, "A " .. id, link and "link" or nil) end)
		H.ItemLines("b", function() error("boom") end)
		H.ItemLines("c", function(tt, link, id) H.AddLine(tt, "C " .. id) end)
		local tt = GameTooltip
		tt:SetOwner(UIParent)
		lookuprt.showItem(tt, 1234, "|cffffffff|Hitem:1234::::::::20:::::|h[Thing]|h|r")
		lookuprt.showItem(tt, 1234, "|cffffffff|Hitem:1234::::::::20:::::|h[Thing]|h|r")
		emit(tt.lines)
		tt:SetOwner(UIParent)
		lookuprt.showItem(tt, 1234, nil)
		emit(tt.lines)
		tt:SetOwner(UIParent); tt.forbidden = true
		lookuprt.showItem(tt, 1234, nil); emit(#tt.lines); tt.forbidden = nil
		tt:SetOwner(UIParent)
		lookuprt.showItem(tt, lookuprt.SECRET, lookuprt.SECRET); emit(#tt.lines)
		local shop = CreateFrame("GameTooltip", "ShoppingTooltip1", UIParent)
		shop.lines = {}; shop.AddLine = GameTooltip.AddLine; shop.NumLines = GameTooltip.NumLines
		lookuprt.showItem(shop, 1234, nil); emit(#shop.lines)
		ItemRefTooltip:SetOwner(UIParent)
		lookuprt.showItem(ItemRefTooltip, 99, nil); emit(ItemRefTooltip.lines)
		H.ItemLines("a", function(tt, link, id) H.AddLine(tt, "A2 " .. id) end)
		H.ItemLines("c", nil)
		tt:SetOwner(UIParent)
		lookuprt.showItem(tt, 5, nil); emit(tt.lines)
	`, { withPack: false });
	assert.deepEqual(once, ['A 1234 | link', 'C 1234']);
	assert.deepEqual(cleared, ['A 1234', 'C 1234']);
	assert.equal(forbidden, 0);
	assert.equal(secret, 0);
	assert.equal(other, 0);
	assert.deepEqual(ref, ['A 99', 'C 99']);
	assert.deepEqual(replaced, ['A2 5']);
});

test('hooks: unit lines get the unit token; item clicks get the item id', () => {
	const [unit, clicks] = run(`
		local H = Polestar.Hooks
		local seen = {}
		H.UnitLines("t", function(tt, unit) seen[#seen + 1] = unit; H.AddLine(tt, "U " .. unit) end)
		lookuprt.units.mouseover = { guid = "Player-1-00000042", player = true }
		GameTooltip:SetOwner(UIParent)
		lookuprt.showUnit(GameTooltip, "mouseover")
		lookuprt.showUnit(GameTooltip, "mouseover")
		emit({ seen = seen, lines = GameTooltip.lines })
		local got = {}
		H.ItemClick("t", function(link, id) got[#got + 1] = id end)
		lookuprt.clickItem("|cff1eff00|Hitem:8004::::::::20:::::|h[Boar Tusk]|h|r")
		lookuprt.clickItem("|cffffd000|Henchant:1234|h[Enchant]|h|r")
		lookuprt.clickItem(lookuprt.SECRET)
		emit(got)
	`, { withPack: false });
	assert.deepEqual(unit, { seen: ['mouseover'], lines: ['U mouseover'] });
	assert.deepEqual(clicks, [8004]);
});

test('hooks: object lines get the object id (data or GUID) and name, secret-safe', () => {
	const out = run(`
		local H = Polestar.Hooks
		local seen = {}
		H.ObjectLines("q", function(tt, id, name) seen[#seen + 1] = { id or false, name or false }; H.AddLine(tt, "O " .. tostring(id)) end)
		local function show(data) GameTooltip:SetOwner(UIParent); lookuprt.showObject(GameTooltip, data); return #GameTooltip.lines end
		emit(show({ id = 2843, lines = { { leftText = "Battered Chest" } } }))
		emit(show({ guid = "GameObject-0-4372-0-17-6002-0000123456", lines = { { leftText = "Supply Crate" } } }))
		emit(show({ guid = "Creature-0-4372-0-17-6002-0000123456", lines = { { leftText = "Mailbox" } } }))
		emit(show({ id = lookuprt.SECRET, guid = lookuprt.SECRET, lines = lookuprt.SECRET }))
		GameTooltip.forbidden = true; emit(show({ id = 1 })); GameTooltip.forbidden = nil
		lookuprt.showObject(ItemRefTooltip, { id = 5 })
		emit(seen)
	`, { withPack: false });
	assert.deepEqual(out, [1, 1, 1, 0, 0, [[2843, 'Battered Chest'], [6002, 'Supply Crate'], [false, 'Mailbox']]]);
});

// ---------------------------------------------------------------------------
// Spotter, tooltip lines, Alt-click, commands
// ---------------------------------------------------------------------------

const MOUNTED = `
lookuprt.units.target = { guid = "Player-1-0000BEEF", player = true }
lookuprt.auras.target = { { spellId = 1243, name = "Fortitude" }, { spellId = 9500, name = "Amber Strider", icon = 132226 } }
`;

test('spotter: a player\'s mount from their auras, secret-safe', () => {
	const out = run(`${MOUNTED}
		local L = Polestar.Lookup
		emit(L.UnitMount("target"))
		lookuprt.auras.target = { { spellId = 9503, name = "Summon Shadowsteed" } }; emit(L.UnitMount("target"))
		lookuprt.auras.target = { { spellId = 7777, name = "Gale" } }; lookuprt.journal[7777] = { id = 55, name = "Swift Gale", icon = 7 }
		emit(L.UnitMount("target"))
		lookuprt.auras.target = { { spellId = lookuprt.SECRET, name = "?" }, { spellId = 9500, name = "Amber Strider" } }; emit(L.UnitMount("target") or false)
		lookuprt.auras.target = { { spellId = 9500, name = "Amber Strider" } }
		lookuprt.auraError = true; emit(L.UnitMount("target") or false); lookuprt.auraError = nil
		lookuprt.units.target.player = false; emit(L.UnitMount("target") or false)
		lookuprt.units.target.player = true; lookuprt.units.target.secretPlayer = true; emit(L.UnitMount("target") or false)
	`);
	assert.deepEqual(out, [
		{ spell: 9500, item: 8000, name: 'Amber Strider', icon: 132226 },
		{ spell: 9503, name: 'Summon Shadowsteed', class: 'WARLOCK' },
		{ spell: 7777, name: 'Swift Gale', icon: 7 },
		false, false, false, false,
	]);
});

test('spotter: MOUNT_SPOTTED, the unit tooltip line and /polestar mount', () => {
	const [spotted, lines, shown, classMount, nothing, lookupCmd, off] = run(`${MOUNTED}
		local got = {}
		Polestar.On("MOUNT_SPOTTED", function(unit, info) got[#got + 1] = { unit, info.item } end)
		local shows = {}
		Polestar.On("SHOW_LOOKUP", function(q, kind, id) shows[#shows + 1] = { q or false, kind or false, id or false } end)
		stub.fire("PLAYER_TARGET_CHANGED")
		emit(got)
		GameTooltip:SetOwner(UIParent); lookuprt.showUnit(GameTooltip, "target"); emit(GameTooltip.lines)
		SlashCmdList.POLESTAR("mount"); emit(shows[#shows])
		lookuprt.auras.target = { { spellId = 9503, name = "Summon Shadowsteed" } }
		SlashCmdList.POLESTAR("mount"); emit(shows[#shows])
		lookuprt.auras.target = {}
		local before = #stub.messages; SlashCmdList.POLESTAR("mount"); emit(stub.messages[#stub.messages])
		SlashCmdList.POLESTAR("lookup boar tusk"); emit(shows[#shows])
		Polestar.Set("lookup.mounts", false)
		lookuprt.auras.target = { { spellId = 9500, name = "Amber Strider" } }
		got = {}; stub.fire("PLAYER_TARGET_CHANGED")
		GameTooltip:SetOwner(UIParent); lookuprt.showUnit(GameTooltip, "target")
		emit({ #got, #GameTooltip.lines })
	`);
	assert.deepEqual(spotted, [['target', 8000]]);
	assert.deepEqual(lines, ['Mount: Amber Strider | Vendor \u00b7 Amber Vale', '/pole mount: how to get it']);
	assert.deepEqual(shown, [false, 'mount', 8000]);
	assert.deepEqual(classMount, ['Summon Shadowsteed', false, false]);
	assert.match(nothing, /No mount found/);
	assert.deepEqual(lookupCmd, ['boar tusk', false, false]);
	assert.deepEqual(off, [0, 0]);
});

test('item tooltips: the best sources, the Alt-click hint, and the settings', () => {
	const [strider, peril, world, noTip, disabled] = run(`
		local function show(id)
			GameTooltip:SetOwner(UIParent)
			lookuprt.showItem(GameTooltip, id, "|cffffffff|Hitem:" .. id .. "::::::::20:::::|h[x]|h|r")
			return GameTooltip.lines
		end
		emit(show(8000)); emit(show(8002)); emit(show(8015))
		Polestar.Set("lookup.tooltip", false); emit(#show(8000)); Polestar.Set("lookup.tooltip", true)
		Polestar.Set("lookup.enabled", false); emit(#show(8000))
	`);
	assert.deepEqual(strider, ['From Mira Saddler | Vendor \u00b7 Amber Vale', 'Alt-click: guide me']);
	assert.deepEqual(peril, ['From Bristle Boar | Drop \u00b7 Amber Vale', 'From High Peril | Requires level 30', 'Alt-click: guide me']);
	assert.deepEqual(world, ['From World drop | World drop \u00b7 Level 10-30']);
	assert.equal(noTip, 0);
	assert.equal(disabled, 0);
});

test('Alt-click: opens a guide for the item, else the Lookup window; only a plain Alt left-click', () => {
	const [opened, shown, shift, right, off] = run(`
		local shows = {}
		Polestar.On("SHOW_LOOKUP", function(q, kind, id) shows[#shows + 1] = { q or false, kind or false, id or false } end)
		local function link(id) return "|cffffffff|Hitem:" .. id .. "::::::::20:::::|h[x]|h|r" end
		local function tabs() local t, ids = Polestar.Engine.GetTabs(), {}; for i, x in ipairs(t) do ids[i] = x.guideId end; return ids end
		stub.keys.alt = true
		lookuprt.clickItem(link(8004)); emit(tabs())
		lookuprt.clickItem(link(8015)); emit(shows)
		stub.keys.shift = true; lookuprt.clickItem(link(8009)); stub.keys.shift = false; emit(tabs())
		lookuprt.button = "RightButton"; lookuprt.clickItem(link(8009)); lookuprt.button = "LeftButton"; emit(tabs())
		Polestar.Set("lookup.altClick", false); lookuprt.clickItem(link(8009)); emit(tabs())
	`);
	assert.deepEqual(opened, ['lookup/item/8004']);
	assert.deepEqual(shown, [[false, 'item', 8015]]);
	assert.deepEqual(shift, ['lookup/item/8004']);
	assert.deepEqual(right, ['lookup/item/8004']);
	assert.deepEqual(off, ['lookup/item/8004']);
});

test('options: the Lookup tab of Discovery and its defaults', () => {
	const [controls, defaults] = run(`
		local out = {}
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.page == "Discovery" and spec.tab == "Lookup" then
				for _, c in ipairs(spec.controls) do out[#out + 1] = { key = c.key, kind = c.kind, label = c.label, help = c.help ~= nil } end
			end
		end
		emit(out)
		emit({ Polestar.Get("lookup.enabled"), Polestar.Get("lookup.tooltip"), Polestar.Get("lookup.altClick"), Polestar.Get("lookup.mounts") })
	`, { files: { name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Lookup/Lookup.xml'] } });
	assert.deepEqual(controls.map((c) => c.key), ['lookup.enabled', 'lookup.tooltip', 'lookup.altClick', 'lookup.mounts']);
	assert.ok(controls.every((c) => c.kind === 'toggle' && c.label && c.help));
	assert.deepEqual(defaults, [true, true, true, true]);
});
