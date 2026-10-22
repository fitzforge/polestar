'use strict';
// Polestar in OpenMap's own interface (Nav/OpenMap.lua, Maps/OpenMapLink.lua):
// a switch per map layer in its menu, Polestar's journal on its dungeon card,
// and nothing at all without OpenMap.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Init.lua', 'Core/Compat.lua', 'Nav/MapCanvas.lua', 'Nav/OpenMap.lua', 'Maps/Maps.lua', 'Maps/OpenMapLink.lua'];

function linked(script, { openMap = true } = {}) {
	return runAddon({
		addons: [{ name: 'Polestar', files: FILES }],
		before: openMap ? `
OpenMapAPI = { major = 1, version = 3, toggles = {}, order = {} }
local OM = OpenMapAPI
function OM.IsStitched() return true end
function OM.WorldFromMap() end
function OM.MapFromWorld() end
function OM.RegisterCallback() end
function OM.RegisterMenuToggle(owner, spec)
	if not OM.toggles[spec.id] then OM.order[#OM.order + 1] = spec.id end
	OM.toggles[spec.id] = spec
	spec.owner = owner
end
function OM.RegisterDungeonSection(owner, fn) OM.section, OM.sectionOwner = fn, owner end` : '',
		login: true,
		script,
	}).emitted;
}

test('OpenMap\'s menu gets a switch per Polestar layer, under "Polestar", each driving its setting', () => {
	const [out] = linked(`
		local OM = OpenMapAPI
		local dungeons = OM.toggles.dungeons
		local r = { order = OM.order, section = dungeons.section, owner = dungeons.owner, before = dungeons.get() }
		dungeons.set(false)
		r.setting, r.after = Polestar.Get("maps.omDungeonPins"), dungeons.get()
		r.own = Polestar.Get("maps.dungeonPins") or false
		r.lookTab = OM.toggles.lineFlow.tab
		emit(r)`);
	for (const id of ['guidePins', 'routeLines', 'dungeons', 'flightMasters', 'docks', 'inns', 'services', 'network', 'stepPreview', 'lineFlow', 'lineLabels', 'atTarget']) {
		assert.ok(Object.values(out.order).includes(id), `a switch for ${id}`);
	}
	assert.equal(out.section, 'Polestar');
	assert.equal(out.owner, 'Polestar');
	assert.equal(out.before, true, 'on by default');
	assert.equal(out.setting, false, 'OpenMap\'s switch has its own setting');
	assert.equal(out.own, false, 'Polestar\'s own setting is left as it was');
	assert.equal(out.after, false);
	assert.equal(out.lookTab, 'look');
});

test('the dungeon card lists the dungeon\'s quests for this character, in the log, done or to pick up, and its attunements', () => {
	const [out] = linked(`
		local done, log = { [101] = true }, { [102] = true }
		Polestar.Maps.Faction = function() return 1 end
		Polestar.Compat.IsQuestCompleted = function(id) return done[id] or false end
		Polestar.Compat.IsOnQuest = function(id) return log[id] or false end
		Polestar.Dungeons = {
			IsEnabled = function() return true end,
			Load = function() return true end,
			Find = function(name) return name == "The Deadmines" and "deadmines" or nil end,
			Quests = function(key) return {
				{ id = 101, title = "Red Silk Bandanas", level = 17 },
				{ id = 102, title = "The Defias Brotherhood", level = 22 },
				{ id = 103, title = "Collecting Memories", level = 18 },
			} end,
			Attunements = function() return { { name = "Key to the Deadmines" } } end,
		}
		local title, lines = OpenMapAPI.section({ instances = { { name = "The Deadmines" } } })
		local none = OpenMapAPI.section({ instances = { { name = "Nowhere" } } })
		emit({ title = title, lines = lines, none = none == nil, owner = OpenMapAPI.sectionOwner })`);
	assert.equal(out.title, 'Polestar');
	assert.equal(out.owner, 'Polestar');
	const plain = Object.values(out.lines).map((l) => l.replace(/\|c\w{8}|\|r/g, ''));
	assert.equal(plain[0], '2 quests to do, 1 in your log');
	assert.ok(plain.some((l) => l === '[17] Red Silk Bandanas (done)'));
	assert.ok(plain.some((l) => l === '[22] The Defias Brotherhood (in your log)'));
	assert.ok(plain.some((l) => l === '[18] Collecting Memories'));
	assert.ok(plain.some((l) => l === 'Attunement: Key to the Deadmines'));
	assert.ok(plain.some((l) => l === 'Full page: /polestar dungeons The Deadmines'));
	assert.equal(out.none, true, 'a dungeon Polestar does not know adds nothing');
});

test('without OpenMap nothing is registered and nothing breaks', () => {
	const [out] = linked(`
		local OM = Polestar.OpenMap
		emit({ api = OM.API() == nil, stitched = OM.Stitched() == nil, fit = OM.Fit(947, 0) == nil, show = OM.Show(0, 0, 0) })`, { openMap: false });
	assert.deepEqual(out, { api: true, stitched: true, fit: true, show: false });
});

test('with OpenMap the icon layers are its menu\'s: on until switched off there, and Polestar\'s options show them ticked and greyed', () => {
	const [withOM] = linked(`
		local M = Polestar.Maps
		local c = M.LayerToggle({ kind = "toggle", key = "maps.dungeonPins", label = "Dungeon entrances", help = "Marks them." })
		local r = { on = M.LayerOn("maps.dungeonPins"), own = Polestar.Get("maps.dungeonPins"), shown = c.get(), greyed = c.disabled(), help = c.help }
		OpenMapAPI.toggles.dungeons.set(false)
		r.off = M.LayerOn("maps.dungeonPins")
		r.path = M.LayerPath("maps.omDungeonPins", "maps.dungeonPins")
		emit(r)`);
	assert.equal(withOM.own, false, 'Polestar\'s own switch stays off');
	assert.equal(withOM.on, true, 'on: OpenMap\'s switch, on by default');
	assert.equal(withOM.shown, true);
	assert.equal(withOM.greyed, true);
	assert.match(withOM.help, /OpenMap's menu/);
	assert.equal(withOM.off, false, 'switched off in OpenMap\'s menu');
	assert.equal(withOM.path, true);
	const [without] = linked(`
		local M = Polestar.Maps
		local c = M.LayerToggle({ kind = "toggle", key = "maps.dungeonPins", label = "Dungeon entrances", help = "Marks them." })
		local r = { on = M.LayerOn("maps.dungeonPins"), shown = c.get(), greyed = c.disabled() }
		Polestar.Set("maps.dungeonPins", true)
		r.after = M.LayerOn("maps.dungeonPins")
		emit(r)`, { openMap: false });
	assert.deepEqual(without, { on: false, shown: false, greyed: false, after: true });
});

