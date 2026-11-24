'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack } = require('./helpers/codex');
const { buildJournal, emitJournal } = require('../tools/lib/codex/journal');
const fixture = require('./fixtures/codex/dungeons.json');

test('Bosses shows one boss drop list at a time and hides it on another tab', () => {
	const { inputs, codex } = structuredClone(fixture);
	const bosses = codex.instances['wailing-caverns'].bosses;
	bosses[0].loot = [6480, 918];
	bosses[1].loot = [9738];
	const pack = writeCodexPack(codex, { extraFiles: emitJournal(buildJournal(inputs, codex)) });
	try {
		const out = runAddon({
			stubs: ['stub_ui.lua'], before: pack.stubLua,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Gear/Gear.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml'] }],
			script: `uistub.install()
stub.login()
uistub.player.level, uistub.player.race, uistub.player.class, uistub.player.faction = 20, 'Tauren', 'DRUID', 'Horde'
assert(Polestar.Codex.Load())
Polestar.Dungeons.Open('wailing-caverns')
local DS = Polestar.UI.DungeonsSection
DS.SetTab('bosses')
local empty = DS.bossRows[2].NoLoot:IsShown()
local arrowBefore = DS.bossRows[3].Loot.psIconName
DS.bossRows[1].Loot:Click()
local first = { DS.Shown().lootBoss, DS.bossLootTiles[1].psID, DS.bossLootTiles[2].psID }
DS.bossRows[3].Loot:Click()
local second = { DS.Shown().lootBoss, DS.bossLootTiles[1].psID, #DS.bossLootTiles }
local arrowOpen = DS.bossRows[3].Loot.psIconName
DS.bossRows[3].Loot:Click()
local collapsed = { DS.Shown().lootBoss or false, not DS.bossLootTiles[1]:GetParent():IsShown() }
local arrowClosed = DS.bossRows[3].Loot.psIconName
local dropLabel = DS.bossRows[3].Loot.Label:GetText()
DS.SetTab('map')
emit({ empty = empty, first = first, second = second, collapsed = collapsed, arrows = { arrowBefore, arrowOpen, arrowClosed }, dropLabel = dropLabel, hidden = not DS.bossLootTiles[1]:GetParent():IsShown() })`,
		}).emitted[0];
		assert.equal(out.empty, true);
		assert.deepEqual(out.first, [1, 6480, 918]);
		assert.deepEqual(out.second, [3, 9738, 2]);
		assert.deepEqual(out.collapsed, [false, true]);
		assert.deepEqual(out.arrows, ['chevron-right', 'chevron-down', 'chevron-right']);
		assert.equal(out.dropLabel, 'Drops (1)');
		assert.equal(out.hidden, true);
	} finally { pack.cleanup(); }
});
