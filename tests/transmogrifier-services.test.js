'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

test('legacy Codex transmogrifiers feed faction-safe POIs and Nearby services', () => {
	assert.ok(fs.existsSync(path.join(__dirname, '..', 'addon', 'Polestar', 'Media', 'Map', 'icon-transmog.tga')));
	const [result] = runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua'],
		before: 'stub.maps.useWorld(); stub.maps.place(0, 0); stub.world.faction = "Alliance"',
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.xml', 'Lookup/Codex.lua'] }],
		script: `
local C, M, Near = Polestar.Codex, Polestar.Maps, Polestar.Nav.nearby
C.Register("meta", { sources = {} })
C.Register("npc", "\\n" .. [[
7\t\tVendor
270513\t\tSpellweaver Thaldris
270581\t\tFyrenz Vishonar
270582\t\tMon'ye]], "\\n" .. [[
7\t20;20;A;;;vendor;;9000,l,700,500
270513\t20;20;A;;;;;9000,l,550,500
270581\t20;20;A;;;transmogrifier;;9000,l,500,500
270582\t20;20;H;;;;;9000,l,520,500]], 7, 270582)
C.Register("role", "\\n" .. [[
vendor\t\t7
transmogrifier\t\t270581]])
local ids = C.WithRole("transmogrifier")
local source = M.ServiceSource()
local enemy = source.read(270582) == nil
local records = {}
for _, id in ipairs(source.ids) do
  local rec = source.read(id)
  if rec then records[#records + 1] = rec end
end
local before = #M.BuildServicePins(records)
Polestar.Set("maps.serviceFilters.transmogrifier", true)
local pins = M.BuildServicePins(records)
local found, reason = Near.Find("transmogrifier")
pins[1].onClick("LeftButton")
local pinTarget = Polestar.Nav.GetTarget()
local alias = Near.Go("transmog")
local nearTarget = Polestar.Nav.GetTarget()
local button
for _, item in ipairs(Near.MenuItems()) do if item.key == "transmogrifier" then button = item.label end end
stub.world.faction = "Horde"
Polestar.Fire("NAMES_LOADED")
local horde = M.ServiceSource()
local hordeRecords = {}
for _, id in ipairs(horde.ids) do
  local rec = horde.read(id)
  if rec then hordeRecords[#hordeRecords + 1] = rec end
end
local hordePins = M.BuildServicePins(hordeRecords)
local hordeNear = Near.Find("transmogrifier")
emit({ids = ids, roles = C.Npc(270513).roles, noDuplicate = #C.Npc(270581).roles == 1,
  enemy = enemy, before = before, pins = #pins,
  first = pins[1] and pins[1].category, icon = pins[1] and pins[1].icon,
  nearby = found and found.id, reason = reason, alias = alias,
  pinX = pinTarget and pinTarget.x, nearX = nearTarget and nearTarget.x, button = button,
  hordePins = #hordePins, hordeId = hordePins[1] and hordePins[1].id,
  hordeNear = hordeNear and hordeNear.id})`,
	}).emitted;
	assert.deepEqual(result.ids, [270513, 270581, 270582]);
	assert.deepEqual(result.roles, ['transmogrifier']);
	assert.equal(result.noDuplicate, true);
	assert.equal(result.enemy, true);
	assert.equal(result.before, 0);
	assert.equal(result.pins, 2);
	assert.equal(result.first, 'transmogrifier');
	assert.equal(result.icon, 'map:transmog');
	assert.equal(result.nearby, 270581, JSON.stringify(result));
	assert.equal(result.alias, true);
	assert.equal(result.pinX, 55);
	assert.equal(result.nearX, 50);
	assert.equal(result.button, 'Transmogrifier');
	assert.equal(result.hordePins, 1);
	assert.equal(result.hordeId, 270582);
	assert.equal(result.hordeNear, 270582);
});
