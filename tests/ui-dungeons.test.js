'use strict';
// The Dungeons section of the hub (addon/Polestar/UI/Dungeons.lua) over the
// real Dungeons runtime and the synthetic Codex pack of
// tests/fixtures/codex/dungeons.json (Wailing Caverns with its quests and
// bosses, the Deadmines, a Forever dungeon with nothing known), against the
// fake Engine of tests/lua/stub_ui.lua. The character: a level 20 Tauren.

const { test, before, after } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack } = require('./helpers/codex');
const { buildJournal, emitJournal } = require('../tools/lib/codex/journal');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Gear/Gear.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml'];
const fixture = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures', 'codex', 'dungeons.json'), 'utf8'));

let pack;
before(() => {
	pack = writeCodexPack(fixture.codex, { extraFiles: emitJournal(buildJournal(fixture.inputs, fixture.codex)) });
});
after(() => pack && pack.cleanup());

const SETUP = `uistub.player.level, uistub.player.race, uistub.player.class, uistub.player.faction = 20, "Tauren", "DRUID", "Horde"
OpenWorldMap = function(map) uistub.worldMap = map end
local done, log = { [1490] = true }, { [914] = true }
Polestar.Compat.IsQuestCompleted = function(id) return done[id] or false end
Polestar.Compat.IsOnQuest = function(id) return log[id] or false end
Polestar.Compat.IsQuestReadyForTurnIn = function() return false end
local DS, P = Polestar.UI.DungeonsSection, Polestar.UI.Picker
local function navs()
	local out = {}
	for _, b in ipairs(PolestarPicker.navButtons) do
		if b:IsShown() then out[#out + 1] = { b.psKey, b.Label:GetText(), b.Count:IsShown() and b.Count:GetText() or "" } end
	end
	return out
end
local function cardNames()
	local out = {}
	for _, c in ipairs(DS.cards) do if c:IsShown() then out[#out + 1] = c.Name:GetText() end end
	return out
end
local function tabs()
	local out = {}
	for _, t in ipairs(PolestarPicker.tabButtons) do if t:IsShown() then out[#out + 1] = t.Label:GetText() end end
	return out
end
local function segs()
	local _, _, _, s = DS.Frames()
	local out = {}
	for _, b in ipairs(s) do out[#out + 1] = { b.psKey, b:IsShown(), b.Selected:IsShown() } end
	return out
end
local function block(id)
	for _, b in ipairs(DS.blocks) do if b:IsShown() and b.psQuest == id then return b end end
end
local function shownTexts(pool, field)
	local out = {}
	for _, r in ipairs(pool) do if r:IsShown() then out[#out + 1] = r[field]:GetText() end end
	return out
end
-- The shown chain rows, tiles or chips of every drawn quest block.
local function kids(field)
	local out = {}
	for _, b in ipairs(DS.blocks) do
		if b:IsShown() then for _, k in ipairs(b[field]) do if k:IsShown() then out[#out + 1] = k end end end
	end
	return out
end
local function chipTexts()
	local out = {}
	for _, c in ipairs(kids("Chips")) do out[#out + 1] = c.Text:GetText() end
	return out
end
local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
`;

function run(script, { withPack = true } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		before: withPack ? pack.stubLua : '',
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\n${SETUP}\n${script}`,
	}).emitted;
}

test('SHOW_DUNGEON(nil) opens the hub at Home: level bands in the sidebar, the dungeons for your level as cards, the faction filter yours first', () => {
	const [out] = run(`
		Polestar.Dungeons.Open()
		emit({ section = P.Section(), navs = navs(), cards = cardNames(), segs = segs(), title = PolestarPicker.Title:GetText(),
			sub = PolestarPicker.Subtitle:GetText(), tabRow = PolestarPicker.TabRow:IsShown(), shown = DS.Shown(),
			stats = DS.cards[1].Stats:GetText(), chip = DS.cards[1].Yours:IsShown() })`);
	assert.equal(out.section, 'Dungeons');
	assert.deepEqual(out.navs, [
		['level', 'For your level', '1'], ['all', 'All dungeons', '3'],
		['10', '10\u201320', '2'], ['20', '20\u201330', ''], ['30', '30\u201340', ''], ['40', '40\u201350', ''], ['50', '50\u201360', '1'],
	]);
	assert.deepEqual(out.cards, ['Wailing Caverns'], 'the Deadmines (Alliance quests only) is not a Horde dungeon for your level');
	assert.deepEqual(out.segs, [['Horde', true, true], ['Alliance', true, false], ['All', true, false]]);
	assert.equal(out.title, 'For your level');
	assert.match(out.sub, /^Level 20 .+ 1 dungeon to run now$/);
	assert.equal(out.tabRow, true, 'the tab row stays for the faction filter');
	assert.equal(out.shown.band, 'level');
	assert.equal(out.stats, '17\u201324  \u00b7  The Barrens  \u00b7  4 quests');
	assert.equal(out.chip, false, 'no "Your level" chip where every card is');
});

test('Home: All dungeons groups by band; the faction filter changes the counts; search narrows and Enter opens the first', () => {
	const [out] = run(`
		Polestar.Dungeons.Open()
		DS.SetBand("all")
		local deadmines = DS.cards[1].Stats:GetText()
		local all = { cards = cardNames(), heads = DS.Shown().heads, title = PolestarPicker.Title:GetText(), yours = DS.cards[2].Yours:IsShown(),
			forever = DS.cards[3].Forever:IsShown() }
		DS.SetFaction("All")
		local both = DS.cards[2].Stats:GetText()
		DS.SetFaction("Alliance")
		local alliance = { DS.cards[1].Stats:GetText(), segs() }
		local box = Polestar.UI.Picker.search
		box:SetText("wail"); stub.RunScript(box, "OnTextChanged", true)
		local found = { cards = cardNames(), title = PolestarPicker.Title:GetText(), sub = PolestarPicker.Subtitle:GetText() }
		DS.Enter()
		emit({ deadmines = deadmines, all = all, both = both, alliance = alliance, found = found, page = DS.Page(), tab = DS.Tab() })`);
	assert.deepEqual(out.all.cards, ['The Deadmines', 'Wailing Caverns', 'Blackmaw Hold']);
	assert.match(out.deadmines, /No Horde quests$/, 'never "0 quests"');
	assert.equal(out.all.heads, 2);
	assert.equal(out.all.title, 'Dungeons');
	assert.equal(out.all.yours, true, 'your level is marked under All');
	assert.equal(out.all.forever, true);
	assert.match(out.both, /3 Alliance, 4 Horde quests$/);
	assert.match(out.alliance[0], /1 quest$/);
	assert.deepEqual(out.alliance[1][1], ['Alliance', true, true]);
	assert.deepEqual(out.found.cards, ['Wailing Caverns']);
	assert.equal(out.found.title, 'Search');
	assert.equal(out.page, 'wailing-caverns');
	assert.equal(out.tab, 'quests');
});

// A French client whose names pack lands with Home open: the cards take the
// names Dungeons.List gives from then on.
test('Home: a names pack landing late renames the cards', () => {
	const [out] = run(`
		Polestar.Dungeons.Open()
		DS.SetBand("all")
		local before = cardNames()
		local list = Polestar.Dungeons.List
		Polestar.Dungeons.List = function(...)
			local out = {}
			for i, d in ipairs(list(...)) do
				local c = {}
				for k, v in pairs(d) do c[k] = v end
				if c.name == "Wailing Caverns" then c.name = "Cavernes des Lamentations" end
				out[i] = c
			end
			return out
		end
		Polestar.Fire("NAMES_LOADED")
		emit({ before = before, after = cardNames() })`);
	assert.ok(out.before.includes('Wailing Caverns'));
	assert.ok(out.after.includes('Cavernes des Lamentations'));
});

test('A page: the painting header with the name, facts and actions; tabs with counts; Guide me and Show on map act', () => {
	const [out] = run(`
		-- Nothing in the log: the hand-in stays away, so "Show on map" keeps its place among three actions.
		log[914] = nil
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		local head = { pg.Title:GetText(), pg.Sub:GetText(), pg.GoQuiet:IsShown(), pg.MapBtn:IsShown(), pg.Back:IsShown(), pg.Forever:IsShown(),
			PolestarPicker.Title:GetText(), PolestarPicker.Title:GetAlpha(), PolestarPicker.Band:IsShown(), pg.Art:IsShown() }
		local nav = {}
		Polestar.Nav.SetTarget = function(map, x, y, label) nav = { map, x, y, label } return true end
		pg.GoQuiet:Click()
		pg.MapBtn:Click()
		pg.Back:Click()
		emit({ head = head, tabs = (function() DS.Open("wailing-caverns") return tabs() end)(), nav = nav, map = uistub.worldMap,
			back = (function() DS.Home() return { DS.Page() or false, PolestarPicker.Title:GetAlpha(), PolestarPicker.Band:IsShown(), pg:IsShown() } end)() })`);
	// The facts break between two facts where the actions leave too little room.
	assert.deepEqual(out.head, ['Wailing Caverns', 'Levels 17\u201324  \u00b7  The Barrens  \u00b7  10 players\n4 bosses', true, true, true, false,
		'Wailing Caverns', 0, false, true]);
	assert.deepEqual(out.tabs, ['Quests  4', 'Attunement', 'Bosses  4', 'Map'], 'the fixture gives Wailing Caverns an attunement');
	assert.deepEqual(out.nav, [1413, 46, 36.4, 'Wailing Caverns']);
	assert.equal(out.map, 1413);
	assert.deepEqual(out.back, [false, 1, true, false]);
});

test('A page with quests to pick up: "Pick up the quests" is the primary action, the entrance second; with none left, "Nothing to pick up" says why', () => {
	const [open, none] = run(`
		local printed = {}
		Polestar.Print = function(...) printed[#printed + 1] = table.concat({ ... }, " ") end
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		local function shown(b) return b:IsShown() and b.Label:GetText() or false end
		-- Right to left: the first shown button holds the band's corner.
		local function corner() for _, b in ipairs({ pg.Pickup, pg.Go, pg.PickupNone, pg.GoQuiet, pg.MapBtn }) do
			if b:IsShown() then local p = { b:GetPoint(1) } if p[1] == "BOTTOMRIGHT" then return b.Label:GetText() end end end end
		emit({ pickup = shown(pg.Pickup), go = shown(pg.Go), quiet = shown(pg.GoQuiet), none = shown(pg.PickupNone), corner = corner(),
			tip = { pg.Pickup.psTip, pg.Pickup.psTipLines } })
		done[1486], done[959] = true, true
		DS.Render()
		pg.PickupNone:Click()
		emit({ pickup = shown(pg.Pickup), go = shown(pg.Go), none = shown(pg.PickupNone), corner = corner(), tip = pg.PickupNone.psTipLines, printed = printed,
			tabs = #Polestar.Engine.GetTabs() })`);
	assert.deepEqual([open.pickup, open.go, open.quiet, open.none, open.corner],
		['Pick up the quests', false, 'Guide me to the entrance', false, 'Pick up the quests']);
	assert.equal(open.tip[0], 'Pick up the quests');
	assert.deepEqual(open.tip[1], [
		'A guide to the 2 quests here you can take, with what comes before them, ending at the entrance.',
		'1 more is in your log already.',
		'It opens in a new tab.',
	], 'Deviate Hides and Trouble at the Docks; Leaders of the Fang is in the log; the Glowing Shard starts inside');
	assert.deepEqual([none.pickup, none.go, none.none, none.corner], [false, 'Guide me to the entrance', 'Nothing to pick up', 'Guide me to the entrance']);
	assert.match(none.tip[0], /^Nothing to pick up before the run/);
	assert.deepEqual(none.printed, [none.tip[0]], 'the action says so');
	assert.equal(none.tabs, 0, 'and opens no guide');
});

test('"Hand in the quests" shows only while one of the page\'s quests is in the log, leads once one is finished, and opens the hand-in guide; nothing finished says what is open', () => {
	const [open, gone, ready, done2] = run(`
		local printed = {}
		Polestar.Print = function(...) printed[#printed + 1] = table.concat({ ... }, " ") end
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		local function shown(b) return b:IsShown() and b.Label:GetText() or false end
		local function corner() for _, b in ipairs({ pg.HandIn, pg.HandInQuiet, pg.Pickup, pg.PickupQuiet, pg.Go, pg.PickupNone, pg.GoQuiet, pg.MapBtn }) do
			if b:IsShown() then local p = { b:GetPoint(1) } if p[1] == "BOTTOMRIGHT" then return b.Label:GetText() end end end end
		-- Leaders of the Fang is in the log, its gems still to get.
		pg.HandInQuiet:Click()
		emit({ lead = shown(pg.HandIn), quiet = shown(pg.HandInQuiet), corner = corner(), tip = pg.HandInQuiet.psTipLines, printed = printed,
			tabs = #Polestar.Engine.GetTabs(), fits = pg.Sub:GetWidth() > 0, map = pg.MapBtn:IsShown(), go = shown(pg.GoQuiet) })
		log[914] = nil
		DS.Render()
		emit({ lead = shown(pg.HandIn), quiet = shown(pg.HandInQuiet) })
		log[914] = true
		Polestar.Compat.IsQuestReadyForTurnIn = function(id) return id == 914 end
		local asked = {}
		Polestar.Dungeons.HandIn = function(key) asked[#asked + 1] = key return "lookup/handin/" .. key end
		DS.Render()
		emit({ lead = shown(pg.HandIn), quiet = shown(pg.HandInQuiet), pickup = shown(pg.Pickup), pickupQuiet = shown(pg.PickupQuiet),
			corner = corner(), tip = pg.HandIn.psTipLines, fits = pg.Sub:GetWidth() > 0 })
		pg.HandIn:Click()
		emit({ asked = asked, hub = PolestarPicker:IsShown() })`);
	assert.deepEqual([open.lead, open.quiet, open.corner], [false, 'Hand in the quests', 'Pick up the quests'], 'beside "Pick up the quests", which leads');
	assert.deepEqual(open.tip, ['Not finished yet: Leaders of the Fang.']);
	assert.deepEqual(open.printed, [open.tip[0]], 'the action says so');
	assert.equal(open.tabs, 0, 'and opens no guide');
	assert.deepEqual([open.go, open.map], ['Guide me to the entrance', false], 'three actions at most: "Show on map" gives way');
	assert.equal(open.fits, true, 'the facts keep their room');
	assert.deepEqual(gone, { lead: false, quiet: false }, 'nothing in the log: no hand-in');
	assert.deepEqual([ready.lead, ready.quiet, ready.pickup, ready.pickupQuiet, ready.corner],
		['Hand in the quests', false, false, 'Pick up the quests', 'Hand in the quests']);
	assert.deepEqual(ready.tip, ['A guide to where the 1 finished quest here is turned in, and the follow-ups it opens there.', 'It opens in a new tab.']);
	assert.equal(ready.fits, true);
	assert.deepEqual(done2, { asked: ['wailing-caverns'], hub: false }, 'the guide opens and the hub steps aside');
});

test('A finished pick-up guide offers the hand-in while the dungeon\'s quests are in the log', () => {
	const [offer, none] = run(`
		local GF = Polestar.UI.GuideFrame
		local id = "lookup/pickup/wailing-caverns"
		uistub.guides[id] = { id = id, pack = "lookup", title = "Wailing Caverns: pick up the quests", category = "Lookup",
			lookup = { kind = "pickup", id = "wailing-caverns" }, steps = { { title = "Wailing Caverns", goals = { { t = "note", text = "n" } } } } }
		local asked = {}
		Polestar.Dungeons.HandIn = function(key) asked[#asked + 1] = key return "lookup/handin/" .. key end
		uistub.setGuide(id)
		uistub.complete()
		local e = GF.parts.empty
		local function state() return { title = e.Title:GetText(), text = e.Text:GetText(), primary = e.Primary:IsShown() and e.Primary.Label:GetText() or false,
			secondary = e.Secondary:IsShown() and e.Secondary.Label:GetText() or false } end
		local s = state()
		e.Primary:Click()
		s.asked = asked
		emit(s)
		log[914] = nil
		uistub.complete()
		emit(state())`);
	assert.deepEqual(offer, {
		title: 'Guide complete', text: "After the run: a guide to where this dungeon's quests are turned in, and the follow-ups there.",
		primary: 'Hand in the quests', secondary: 'Choose a guide', asked: ['wailing-caverns'],
	});
	assert.equal(none.primary, 'Choose a guide', 'nothing in the log: the usual end');
});

test('Quests: the giver line is a link; with a prerequisite still to do it points at that one', () => {
	const [out] = run(`
		done[1490], log[914] = nil, nil
		Polestar.Dungeons.Open("wailing-caverns")
		local pins = {}
		Polestar.Nav.SetTarget = function(map, x, y, label) pins[#pins + 1] = { map, x, y, label } return true end
		local fang, hides = block(914), block(1486)
		fang.StartLink:Click()
		hides.StartLink:Click()
		emit({ pins = pins, fang = { fang.StartLink.psTip, fang.StartLink.psTipLines[1], fang.StartPin.psTip },
			hides = { hides.StartLink.psTip, hides.StartLink.psTipLines[1] } })`);
	assert.deepEqual(out.pins, [[1413, 52.2, 31.9, 'Tonga Runetotem'], [1413, 46, 35.7, 'Nalpak']]);
	assert.deepEqual(out.fang, ['Set the arrow to Tonga Runetotem', 'First pick up Nara Wildmane, which comes before this quest.', 'Set the arrow to Tonga Runetotem']);
	assert.deepEqual(out.hides, ['Set the arrow to Nalpak', 'Where this quest starts.']);
});

test('Quests: one block per quest with state, level, flags, objective, start and end pins, the chain, choice tiles and reward chips', () => {
	const [out] = run(`
		Polestar.Dungeons.Open("wailing-caverns")
		local fang = block(914)
		local hides = block(1486)
		local shard = block(6981)
		local pins = {}
		Polestar.Nav.SetTarget = function(map, x, y, label) pins[#pins + 1] = { map, x, y, label } return true end
		fang.StartPin:Click()
		for _, r in ipairs(kids("Chains")) do r.Pin:Click() end
		local tile
		for _, t in ipairs(kids("Tiles")) do if t.psID == 6505 then tile = t end end
		stub.RunScript(tile, "OnEnter")
		emit({ shown = DS.Shown(), order = (function() local t = {} for _, b in ipairs(DS.blocks) do if b:IsShown() then t[#t + 1] = b.psQuest end end return t end)(),
			fang = { fang.Title:GetText(), fang.Meta:GetText(), fang.State:IsShown() and fang.State.Text:GetText(), fang.Faction.Text:GetText(),
				plain(fang.Start:GetText()), plain(fang.End:GetText()), fang.ChainLabel:IsShown(), fang.ChooseLabel:IsShown(), fang.GetLabel:IsShown() },
			hides = { hides.Obj:GetText(), hides.State:IsShown(), hides.Faction:IsShown() },
			shard = { shard.Meta:GetText(), plain(shard.Start:GetText()), shard.GetLabel:IsShown(), shard.StartPin:IsEnabled() },
			chain = shownTexts(kids("Chains"), "Title"), chainSub = shownTexts(kids("Chains"), "Sub"),
			chainGlyph = kids("Chains")[1].Glyph:GetTexture(),
			tiles = shownTexts(kids("Tiles"), "Name"), chips = chipTexts(), pins = pins,
			tip = GameTooltip.owner == tile })`);
	assert.deepEqual(out.order, [1486, 959, 914, 6981], 'level order; the hidden errand stays out');
	assert.equal(out.shown.quests, out.order.length);
	assert.deepEqual(out.fang, ['Leaders of the Fang', 'Level 22  \u00b7  Requires level 18  \u00b7  Shareable', 'In your log', 'Horde',
		'Nara Wildmane  \u00b7  Thunder Bluff', 'Nara Wildmane  \u00b7  Thunder Bluff', true, true, false]);
	assert.equal(out.hides[1], false, 'an open quest carries no state chip');
	assert.equal(out.hides[2], false, 'no faction mark on a quest for both');
	assert.match(out.shard[0], /Picked up inside the dungeon/);
	assert.match(out.shard[0], /Not shareable/);
	assert.equal(out.shard[1], 'Glowing Shard  \u00b7  drops from Mutanus the Devourer');
	assert.equal(out.shard[2], true, 'a fixed reward under "You get"');
	assert.deepEqual(out.chain, ['Nara Wildmane']);
	assert.match(out.chainSub[0], /^Level 20  \u00b7  Tonga Runetotem, The Barrens$/);
	assert.match(out.chainGlyph, /check$/, 'a done chain quest is checked');
	assert.ok(out.tiles.includes('Crescent Staff') && out.tiles.includes('Wingblade'));
	assert.ok(out.tiles.includes('2 x Necklace of Calisea'), 'a reward given twice says how many');
	assert.ok(out.chips.includes('2,350 XP'));
	assert.ok(out.chips.some((c) => /^\+250 /.test(c)), 'reputation');
	assert.ok(out.chips.some((c) => /^\d+s$/.test(c) || /\d+g/.test(c)), 'money');
	assert.deepEqual(out.pins[0], [1456, 75.6, 31.2, 'Nara Wildmane']);
	assert.deepEqual(out.pins[1], [1413, 52.2, 31.9, 'Tonga Runetotem']);
	assert.equal(out.tip, true, 'item hover shows the game tooltip');
});

test('Quests: too low shows the level it opens at; the other faction is counted when none are left', () => {
	const [out] = run(`
		uistub.player.level = 12
		Polestar.Dungeons.Open("wailing-caverns")
		local fang = block(914)
		DS.SetFaction("Alliance")
		Polestar.Dungeons.Open("deadmines")
		local _, _, pg = DS.Frames()
		local dm = { DS.Shown().quests, pg.EmptyTitle:IsShown() }
		DS.SetFaction("Horde")
		emit({ low = { fang.State.Text:GetText(), fang.Glyph:GetTexture() }, dm = dm, empty = { DS.Shown().quests, pg.EmptyTitle:GetText(), pg.EmptyNote:GetText() } })`);
	assert.equal(out.low[0], 'From level 18');
	assert.match(out.low[1], /lock$/);
	assert.deepEqual(out.dm, [1, false]);
	assert.equal(out.empty[0], 0);
	assert.equal(out.empty[1], 'No quests for you here');
	assert.match(out.empty[2], /^1 quest here is for the Alliance/);
});

test('Bosses: kill order, level and the quests each serves; a quest line opens the Quests tab at it', () => {
	const [out] = run(`
		Polestar.Dungeons.Open("wailing-caverns")
		DS.SetTab("bosses")
		local names = shownTexts(DS.bossRows, "Name")
		local levels = shownTexts(DS.bossRows, "Level")
		local ties = {}
		for _, t in ipairs(DS.ties) do if t:IsShown() then ties[#ties + 1] = plain(t.Text:GetText()) end end
		local first
		for _, t in ipairs(DS.ties) do if t:IsShown() then first = t break end end
		local q = first.psQuest
		first:Click()
		emit({ names = names, levels = levels, ties = ties, tab = DS.Tab(), quest = q, blocks = DS.Shown().blocks, bosses = (function() return #DS.bossRows end)() })`);
	assert.deepEqual(out.names, ['Lady Anacondra', 'Kresh', 'Lord Cobrahn', 'Mutanus the Devourer']);
	assert.deepEqual(out.levels, ['Level 20', 'Level 20', 'Level 20', 'Level 22']);
	assert.ok(out.ties.length >= 2);
	assert.ok(out.ties.some((t) => /Leaders of the Fang/.test(t)));
	assert.ok(out.ties.includes('Drops Glowing Shard, which starts The Glowing Shard'));
	assert.equal(out.tab, 'quests');
	assert.ok(out.blocks > 0);
});

test('Map: the entrance on its zone with the quest givers there', () => {
	const [out] = run(`
		-- The Barrens' painting: one art layer of 4x3 tiles.
		C_Map = C_Map or {}
		C_Map.GetMapArtLayers = function(id) if id == 1413 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end return {} end
		C_Map.GetMapArtLayerTextures = function(id) if id == 1413 then local t = {} for i = 1, 12 do t[i] = 100 + i end return t end return {} end
		Polestar.Dungeons.Open("wailing-caverns")
		DS.SetTab("map")
		local _, _, pg = DS.Frames()
		emit({ shown = DS.Shown(), note = pg.MapNote:GetText(), art = pg.MapArt:IsShown(), blocks = (function() for _, b in ipairs(DS.blocks) do if b:IsShown() then return true end end return false end)() })`);
	assert.equal(out.shown.map, 'entrance');
	assert.equal(out.shown.givers, 2, 'Nalpak (two quests) and Crane Operator Bigglefuzz; the shard starts inside');
	assert.match(out.note, /^The entrance, on The Barrens \(46\.0, 36\.4\)\./);
	assert.equal(out.art, true);
	assert.equal(out.blocks, false, 'the other tabs\u2019 rows are hidden');
});

test('Speed: pages reuse pooled frames, only cards in view are painted, open and tab switches stay fast', () => {
	const [out] = run(`
		-- Thirty more dungeons, so Home scrolls.
		local extra = {}
		for i = 1, 30 do extra["extra-" .. i] = { name = "Extra " .. i, kind = "dungeon", minLevel = 10 + i, maxLevel = 14 + i, zone = 1413, entrance = { map = 1413, x = 40, y = 40 }, quests = { A = 1, H = 1 }, bosses = 1 } end
		Polestar.Dungeons.Load()
		Polestar.Dungeons.Register("dungeon", extra, {})
		Polestar.Fire("CODEX_LOADED")
		local clock = os.clock
		local t0 = clock()
		Polestar.Dungeons.Open()
		local tHome = clock() - t0
		DS.SetBand("all")
		local cards, painted = DS.Shown().cards, DS.Shown().painted
		t0 = clock()
		DS.Open("wailing-caverns")
		local tOpen = clock() - t0
		t0 = clock()
		DS.SetTab("bosses"); DS.SetTab("map"); DS.SetTab("quests")
		local tTabs = (clock() - t0) / 3
		local frames = #stub.frames
		DS.Open("deadmines"); DS.Open("wailing-caverns"); DS.SetTab("bosses"); DS.SetTab("map"); DS.SetTab("quests")
		local grew = #stub.frames - frames
		-- A page of forty quests draws only the blocks in view, the rest as they scroll in.
		local qs = {}
		for i = 1, 40 do
			qs[i] = string.format('{id=%d,title="Errand %d",level=%d,minLevel=%d,objectives={{k="item",id=1,n=8,name="Things"}},start={kind="npc",id=1,name="Giver",map=1413,x=50,y=50},finish={kind="npc",id=1,name="Giver",map=1413,x=50,y=50},chain={},rewards={items={},xp=900,rep={}}}', 90000 + i, i, 20 + i % 5, 15)
		end
		Polestar.Dungeons.Register("dungeon", { big = { name = "Big Hold", kind = "dungeon", minLevel = 20, maxLevel = 25, quests = { A = 40, H = 40 }, bosses = 0 } },
			{ big = "return {quests={" .. table.concat(qs, ",") .. "},chain={},bosses={}}" })
		t0 = clock()
		DS.Open("big")
		local tBig = clock() - t0
		local first = DS.Shown().blocks
		local _, _, pg = DS.Frames()
		pg.Scroll:SetVerticalScroll(4000)
		DS.PaintQuests()
		emit({ cards = cards, painted = painted, grew = grew, tHome = tHome, tOpen = tOpen, tTabs = tTabs, tBig = tBig,
			big = { DS.Shown().quests, first, DS.Shown().blocks } })`);
	assert.equal(out.cards, 33);
	assert.ok(out.painted > 0 && out.painted < 16, `only the cards in view are painted (${out.painted})`);
	assert.equal(out.grew, 0, 'reopening and switching tabs creates no frames');
	assert.equal(out.big[0], 40);
	assert.ok(out.big[1] > 0 && out.big[1] < 15, `only the blocks in view are drawn (${out.big[1]})`);
	assert.ok(out.big[2] > out.big[1], 'scrolling draws more');
	for (const k of ['tHome', 'tOpen', 'tTabs', 'tBig']) assert.ok(out[k] < 0.25, `${k} ${out[k]}s`);
});

test('Without the Codex pack: an empty state that says where to get the release; leaving the section restores the header', () => {
	const [out] = run(`
		Polestar.Dungeons.Open("wailing-caverns")
		local _, home = DS.Frames()
		local empty = { DS.Shown().empty, home.EmptyTitle:GetText(), home.EmptyNote:GetText(), home.Watermark:IsVisible() }
		P.ShowSection("Guides")
		emit({ empty = empty, title = PolestarPicker.Title:GetAlpha(), band = PolestarPicker.Band:IsShown(), segs = segs() })`, { withPack: false });
	assert.equal(out.empty[0], 'missing');
	assert.match(out.empty[2], /not installed.*Releases page.*not "Source code"/, 'points at the release download, not the source zip');
	assert.equal(out.empty[3], true);
	assert.equal(out.title, 1);
	assert.equal(out.band, true);
	assert.ok(out.segs.every((s) => s[1] === false), 'the faction filter goes with the section');
});

test('review P3-13: "Show on map" in combat says in chat why the map stays shut, and opens it once combat is over', () => {
	const [out] = run(`
		local printed = {}
		Polestar.Print = function(...) printed[#printed + 1] = table.concat({ ... }, " ") end
		uistub.worldMap = nil
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		stub.inCombat = true
		pg.MapBtn:Click()
		local inCombat = { map = uistub.worldMap or false, printed = printed[1] or false }
		stub.inCombat = false
		pg.MapBtn:Click()
		emit({ inCombat = inCombat, after = uistub.worldMap or false, lines = #printed })`);
	assert.equal(out.inCombat.map, false, 'nothing opens in combat');
	assert.match(out.inCombat.printed, /map can't open in combat/);
	assert.equal(out.after, 1413);
	assert.equal(out.lines, 1, 'the out-of-combat click prints nothing');
});

test('a French client: a dungeon page and the Codex name quests, NPCs and items in French; English where French has none', () => {
	const { namesPack } = require('./helpers/names');
	const fr = namesPack('frFR', {
		quest: { 1486: 'Peaux déviantes' },
		npc: { 5767: 'Nalpak (fr)', 3671: 'Dame Anacondra', 234: 'Gryan Forte-Manteau' },
		item: { 6480: 'Jambières déviantes lisses', 9739: "Gemme d'Anacondra" },
	});
	const [page, codex, learned] = runAddon({
		stubs: ['stub_ui.lua'],
		before: `function GetLocale() return "frFR" end
do
	local load = loadfile
	function loadfile(file)
		if file:match("[/\\\\]Locales[/\\\\]%a%a%u%u%.lua$") then return function() end end
		return load(file)
	end
end
${fr.stubLua}
${pack.stubLua}`,
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()
local D = Polestar.Dungeons
local q = D.Quest("wailing-caverns", 1486)
local b = D.Bosses("wailing-caverns")
emit({ q.title, q.start.name, q.rewards.items[1].name, q.rewards.items[2].name, b[1].name, b[1].quests[1].itemName, b[2].name })
local C = Polestar.Codex
emit({ C.Npc(234).name, C.Name("npc", 234), C.Name("npc", 639) })
local guids = { target = "Creature-0-1-0-1-5767-0000AB", mouseover = "Creature-0-1-0-1-639-0000CD" }
local named = { target = "Nalpak (client)", mouseover = "Edwin VanCleef (client)" }
UnitGUID = function(u) return guids[u] end
UnitName = function(u) return named[u] end
UnitPlayerControlled = function() return false end
Polestar.Compat.Readable = function(v) return v end
stub.fire("PLAYER_TARGET_CHANGED"); stub.fire("UPDATE_MOUSEOVER_UNIT")
emit({ D.Quest("wailing-caverns", 1486).start.name, C.Npc(639).name })`,
	}).emitted;
	assert.deepEqual(page, ['Peaux déviantes', 'Nalpak (fr)', 'Jambières déviantes lisses', 'Deviate Hide Pack', 'Dame Anacondra', "Gemme d'Anacondra", 'Kresh']);
	assert.deepEqual(codex, ['Gryan Forte-Manteau', 'Gryan Forte-Manteau', 'Edwin VanCleef']);
	assert.deepEqual(learned, ['Nalpak (client)', 'Edwin VanCleef (client)'], 'an open page and decoded records pick up names learned in play');
});
