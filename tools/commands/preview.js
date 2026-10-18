'use strict';
// Renders the addon's UI without the game. Each scene runs the REAL Core,
// Theme and UI Lua (loaded through the TOC/XML manifests, as the client does)
// against the test client stub plus tools/preview/stub.lua, with the fake
// Engine and sample guides from tests/lua/stub_ui.lua; the dumped geometry is
// drawn to SVG by tools/preview/render.js.

const fs = require('node:fs');
const path = require('node:path');
const os = require('node:os');
const { runAddon } = require('../../tests/helpers/lua');
const { writeCodexPack, sampleCodex } = require('../../tests/helpers/codex');
const { buildQuestDB, writeQuestDB } = require('../lib/questdb/build');
const { Font } = require('../preview/font');
const { svg, compose, TextureCache } = require('../preview/render');
const { header } = require('../lib/generated');

const { ROOT } = require('../lib/paths');
const ADDON = path.join(ROOT, 'addon', 'Polestar');
const OUT = path.join(ROOT, 'docs', 'preview');
const PREVIEW_HEADER = header('svg', 'preview', "the addon's Lua and the client stubs in tests/lua");
const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Gear/Gear.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml'];
// The reward panel scenes also run QoL, which owns the marks.
const REWARD_FILES = [...FILES, 'QoL/QoL.xml'];

// Gear sample data, written for the preview (names and numbers are samples,
// not taken from any addon): a Human warrior at 6 in Northshire, a few
// leveling items with quest, drop and craft sources, the reward choices of
// "Kobold Camp Cleanup" (7) and "Wolves Across the Border" (33).
const GEAR_SETUP = `local W = stub.world or {}
UnitRace = function() return "Human", "Human", 1 end
UnitFactionGroup = function() return "Alliance", "Alliance" end
UnitLevel = function() return 6 end
UnitClass = function() return "Warrior", "WARRIOR", 1 end
local worn = { [1] = "item:9150", [5] = "item:9151", [7] = "item:9152" }
GetInventoryItemLink = function(unit, slot) return worn[slot] end
local G = Polestar.Gear
Polestar.ItemDB.Register({ schema = 1, build = "preview" }, {
	[9150] = "1 4 1 1 4 2 armor20", [9151] = "5 4 1 1 4 2 armor40", [9152] = "7 4 1 1 4 2 armor30",
	[9101] = "5 8 5 2 4 3 str3 sta2 armor90", [9102] = "5 8 5 2 4 1 int3 spi2 armor25", [9103] = "7 7 5 1 4 3 armor70",
	[9104] = "13 9 6 2 2 7 str2 dmin7 dmax13 speed2200", [9105] = "16 8 5 2 4 1 sta2 armor12", [9106] = "10 9 7 2 4 3 str2 armor55",
	[9107] = "8 7 4 1 4 2 agi1 armor35",
})
Polestar.ItemDB.RegisterLeveling({ source = "preview" }, {
	professions = { "Alchemy", "Blacksmithing", "Enchanting", "Engineering", "Leatherworking", "Tailoring" },
	names = { [9101] = "Militia Chain Vest", [9102] = "Acolyte's Robe", [9103] = "Kobold Mining Leggings", [9104] = "Northshire Shortsword",
		[9105] = "Woolen Cape", [9106] = "Gauntlets of the Watch", [9107] = "Tracker's Boots" },
	src = { [9101] = "q7", [9102] = "q7", [9103] = "q7", [9104] = "d257x84z12", [9105] = "c2397p6s75", [9106] = "q33", [9107] = "q33" },
	race = {},
	quests = { [7] = "6 3 1 12 0 0 0|9101,9102,9103||Kobold Camp Cleanup", [33] = "7 4 1 12 0 0 0|9106,9107||Wolves Across the Border" },
	npcs = { [257] = "Kobold Worker" },
	zones = { [12] = "Elwynn Forest" },
})
G.RefreshPlayer()`;

// The client's reward panel for quest 7's choices, drawn in flat colours (the
// preview has no client art): QuestInfo's choice buttons as
// LargeQuestRewardItemButtonTemplate lays them out (147×41, a 39px icon at the
// top left with its quality border, the name slot beside it; two to a row,
// 1px apart), on parchment. QoL's marks are drawn by the real QoL/Rewards.lua;
// sell prices are samples. Runs after GEAR_SETUP.
const REWARD_PANEL = `local QoL = Polestar.QoL
local PRICE = { [9101] = 45, [9102] = 38, [9103] = 52, [9104] = 60 }
QoL.Client.SellPrice = function(item) return PRICE[tonumber(tostring(item):match("item:(%d+)") or item)] end
local CHOICES = { 9101, 9102, 9103, 9104 }
local NAMES = { [9101] = "Militia Chain Vest", [9102] = "Acolyte's Robe", [9103] = "Kobold Mining Leggings", [9104] = "Northshire Shortsword" }
local QUALITY = { [9101] = { 0.12, 1, 0 }, [9102] = { 0.12, 1, 0 }, [9103] = { 1, 1, 1 }, [9104] = { 0.12, 1, 0 } }
local ICON = { [9101] = { 0.36, 0.38, 0.42 }, [9102] = { 0.42, 0.3, 0.5 }, [9103] = { 0.45, 0.36, 0.24 }, [9104] = { 0.5, 0.52, 0.56 } }
GetNumQuestChoices = function() return #CHOICES end
GetQuestItemInfo = function(kind, i) local id = CHOICES[i]; return NAMES[id], 0, 1, 2, true, id end
GetQuestItemLink = function(kind, i) local id = CHOICES[i]; return id and "item:" .. id end
GetQuestMoneyToGet = function() return 0 end
local P = CreateFrame("Frame", "QuestInfoRewardsFrame", UIParent)
P:SetSize(318, 134)
P:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
local paper = P:CreateTexture(nil, "BACKGROUND")
paper:SetAllPoints()
paper:SetColorTexture(0.86, 0.78, 0.6, 1)
local head = P:CreateFontString(nil, "ARTWORK")
Polestar.Theme.Font(head, "heading")
head:SetTextColor(0.24, 0.16, 0.06, 1)
head:SetPoint("TOPLEFT", P, "TOPLEFT", 12, -12)
head:SetText("Choose your reward:")
P.RewardButtons = {}
for i, id in ipairs(CHOICES) do
	local b = CreateFrame("Button", nil, P)
	b:SetSize(147, 41)
	b:SetPoint("TOPLEFT", P, "TOPLEFT", 12 + ((i - 1) % 2) * 148, -36 - math.floor((i - 1) / 2) * 43)
	b.Icon = b:CreateTexture(nil, "BACKGROUND")
	b.Icon:SetSize(39, 39)
	b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
	b.Icon:SetColorTexture(ICON[id][1], ICON[id][2], ICON[id][3], 1)
	local slot = b:CreateTexture(nil, "BACKGROUND")
	slot:SetPoint("TOPLEFT", b.Icon, "TOPRIGHT", 0, -2)
	slot:SetSize(106, 35)
	slot:SetColorTexture(0.2, 0.15, 0.1, 0.88)
	local edge = CreateFrame("Frame", nil, b)
	edge:SetAllPoints(b.Icon)
	Polestar.Theme.Border(edge, QUALITY[id][1], QUALITY[id][2], QUALITY[id][3], 1)
	b.Name = b:CreateFontString(nil, "BORDER")
	Polestar.Theme.Font(b.Name, "label")
	b.Name:SetTextColor(1, 1, 1, 1)
	b.Name:SetPoint("LEFT", slot, "LEFT", 8, 0)
	b.Name:SetWidth(92)
	b.Name:SetJustifyH("LEFT")
	b.Name:SetText(NAMES[id])
	b.type, b.objectType = "choice", "item"
	b:SetID(i)
	P.RewardButtons[i] = b
end
QoL.Rewards.OnQuestComplete()`;

const FONT_FILES = ['Inter-Regular.ttf', 'Inter-Medium.ttf', 'Inter-SemiBold.ttf', 'FiraSans-Regular.ttf', 'FiraSans-Medium.ttf', 'FiraSans-SemiBold.ttf'];
// Fonts the preview cannot ship (EllesmereUI's, the client's) are set in the
// nearest Inter weight; widths are measured in the same face that is drawn.
const FALLBACK = 'Inter-Medium.ttf';

function loadFonts() {
	const fonts = {};
	for (const f of FONT_FILES) fonts[f] = new Font(path.join(ADDON, 'Media', 'Fonts', f));
	return new Proxy(fonts, { get: (t, k) => t[k] || t[FALLBACK] });
}

// Advance widths (em) for every code point the UI can plausibly show, and
// `extra` ones (tools/preview/fit.js: the translations' scripts).
function metricsLua(fonts, extra = []) {
	const cps = [];
	for (let c = 32; c < 127; c++) cps.push(c);
	for (let c = 0xa0; c < 0x180; c++) cps.push(c);
	cps.push(0x2013, 0x2014, 0x2018, 0x2019, 0x201c, 0x201d, 0x2026, 0x2022, 0x00b7, 0x00d7, 0x2192);
	for (const c of extra) if (!cps.includes(c)) cps.push(c);
	const parts = FONT_FILES.map((file) => {
		const f = fonts[file];
		const adv = cps.map((c) => `[${c}]=${f.advanceEm(c).toFixed(5)}`).join(',');
		return `[${JSON.stringify(file)}]={upm=${f.upm},fallback=${f.advanceEm(0x6e).toFixed(5)},adv={${adv}}}`;
	});
	return `preview = { metrics = { ${parts.join(',')} }, fallbackFont = ${JSON.stringify(FALLBACK)} }`;
}

// Scenes: Lua run after the fakes are installed and the player logged in.
// Each panel is one run; `roots` names the frames to draw.
const GUIDE = ['PolestarGuideFrame'];
const OPTIONS = ['PolestarOptions'];
const PICKER = ['PolestarPicker'];
// Lookup scenes run the real Search, Codex and Lookup runtime over the
// synthetic Codex pack of tests/fixtures/codex/sample.json (panel.codex: the
// stubbed client loads it when asked, as the game does; without it the pack
// is missing). The character: a level 60 Night Elf hunter in Dolanaar, and a
// stand-in for Nav's travel estimate (a run on one map, a long trip across).
const HUNTER = `uistub.player.level, uistub.player.race, uistub.player.class = 60, "NightElf", "HUNTER"`;
function lookupScene(script, player = HUNTER) {
	return `${player}
Polestar.Compat.GetPlayerMapPosition = function() return 1438, 55.6, 52.4 end
Polestar.Nav.EstimateTravel = function(from, to)
	if from.map ~= to.map then return 1500 end
	return math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2) * 9
end
${script}`;
}
// The sample Codex, plus one mount of Era vendor stock retired in Forever
// (codex build marks such stock `status: "retired"`), for the scenes only.
function previewCodex() {
	const codex = sampleCodex();
	codex.items['12302'] = {
		id: 12302, name: 'Reins of the Frostsaber', quality: 4, kind: 'mount', spell: 16056, reqLevel: 60, status: 'retired',
		repFaction: null, repStanding: null, reqSkill: null, reqSkillRank: null,
		sources: [{ type: 'vendor', npc: 4730, cost: 1000000, from: ['pfquest'] }],
	};
	return codex;
}
let codexPack = null;
function codexStub() {
	if (!codexPack) codexPack = writeCodexPack(previewCodex());
	return codexPack.stubLua;
}
// Dungeons scenes (panel.dungeons): the synthetic fixture
// tests/fixtures/codex/dungeons.json (game names, sample numbers: Wailing
// Caverns with its quests and bosses, the Deadmines, a Forever dungeon with
// nothing known) as a Codex pack carrying Dungeons1.lua, loaded when the
// section asks. POLESTAR_DUNGEONS_PACK: a Dungeons1.lua built by `codex build`
// (local, never committed) used instead of the fixture's; it needs
// POLESTAR_CLIENT_ART, so those renders land outside the repository.
const DUNGEONS_PACK = process.env.POLESTAR_DUNGEONS_PACK || null;
let dungeonsPack = null;
function dungeonsStub() {
	if (!dungeonsPack) {
		const { buildJournal, emitJournal } = require('../lib/codex/journal');
		const f = JSON.parse(fs.readFileSync(path.join(ROOT, 'tests', 'fixtures', 'codex', 'dungeons.json'), 'utf8'));
		const files = DUNGEONS_PACK ? [{ name: 'Dungeons1.lua', text: fs.readFileSync(DUNGEONS_PACK, 'utf8') }] : emitJournal(buildJournal(f.inputs, f.codex));
		dungeonsPack = writeCodexPack(f.codex, { extraFiles: files });
	}
	return dungeonsPack.stubLua;
}
// The character: a level 20 Tauren druid in the Barrens. The client's quest
// difficulty colours (Blizzard_FrameXMLBase/Constants.lua), and a quest
// state for a few quests: one done, one in the log, one ready to turn in.
const DUNGEONS_SETUP = `uistub.player.level, uistub.player.race, uistub.player.class, uistub.player.faction = 20, "Tauren", "DRUID", "Horde"
OpenWorldMap = OpenWorldMap or function() end
UnitRace = function() return "Tauren", "Tauren", 6 end
UnitFactionGroup = function() return "Horde", "Horde" end
UnitLevel = function() return 20 end
QuestDifficultyColors = {
	impossible = { r = 1, g = 0.1, b = 0.1 }, verydifficult = { r = 1, g = 0.5, b = 0.25 }, difficult = { r = 1, g = 0.82, b = 0 },
	standard = { r = 0.25, g = 0.75, b = 0.25 }, trivial = { r = 0.5, g = 0.5, b = 0.5 },
}
local done, log, ready = { [1490] = true, [870] = true }, { [914] = true }, { [1486] = true }
Polestar.Compat.IsQuestCompleted = function(id) return done[id] or false end
Polestar.Compat.IsOnQuest = function(id) return (log[id] or ready[id]) and true or false end
Polestar.Compat.IsQuestReadyForTurnIn = function(id) return ready[id] or false end
Polestar.Compat.GetPlayerMapPosition = function() return 1413, 51, 30 end`;
function dungeonsScene(script) {
	return `${clientArtLua()}${DUNGEONS_SETUP}\nPolestar.UI.ShowPicker()\nlocal DS = Polestar.UI.DungeonsSection\n${script}`;
}
// Rares scenes (panel.rares): the sample Codex plus a few Elwynn Forest and
// Teldrassil rares and a treasure (names from the game; levels, places and
// loot are sample numbers written for the preview, not taken from any addon),
// with the Rares files loaded after the UI. A level 10 Human in Elwynn
// Forest, near the vineyard; three sightings in this realm's history.
let raresPack = null;
function raresStub() {
	if (!raresPack) {
		const c = sampleCodex();
		const rare = (id, name, level, map, x, y, loot, extra = {}) => {
			c.npcs[id] = { id, name, level, levelMax: null, faction: null, rare: true, elite: false, boss: false, instance: null, roles: [], loot, spawns: [{ map, x, y, f: 'e' }], ...extra };
		};
		c.npcs[61].loot = [1933, 2589, 2933, 750];
		c.npcs[61].spawns.push({ map: 1429, x: 79.8, y: 69.1, f: 'e' });
		rare(99, 'Morgaine the Sly', 10, 1429, 30.4, 64.5, [2589]);
		rare(100, 'Gruff Swiftbite', 12, 1429, 26.1, 93.2, [750, 2589]);
		rare(471, 'Mother Fang', 10, 1429, 62.1, 50.3, [2589], { elite: true });
		rare(472, 'Fedfennel', 12, 1429, 69.3, 79.6, [2589]);
		rare(79, 'Narg the Taskmaster', 10, 1429, 78.9, 56.2, [2589, 750]);
		rare(14428, 'Uruson', 7, 1438, 49.6, 23.4, [2589]);
		c.items[2589] = { id: 2589, name: 'Linen Cloth', quality: 1, kind: 'item', spell: null, reqLevel: null,
			sources: [61, 99, 100, 471, 472, 79].map((npc) => ({ type: 'drop', npc, chance: 22, from: ['pfquest'] })) };
		c.items[1933].sources[0].chance = 8.5;
		c.objects[2843].loot = [1179, 2589];
		raresPack = writeCodexPack(c);
	}
	return raresPack.stubLua;
}
const RARES_SETUP = `uistub.player.level = 10
UnitLevel = function() return 10 end
Polestar.Compat.GetPlayerMapPosition = function() return 1429, 86.5, 76.8 end
local R = Polestar.Rares
local now = GetServerTime()
R.Record({ kind = "rare", id = 61, name = "Thuros Lightfingers", level = 11, source = "vignette" }, { map = 1429, x = 89.2, y = 79.1 }, now - 2 * 3600, true)
R.Record({ kind = "rare", id = 471, name = "Mother Fang", level = 10, source = "nameplate" }, { map = 1429, x = 62.4, y = 50.1 }, now - 26 * 3600, true)
R.Record({ kind = "treasure", id = 2843, name = "Battered Chest", source = "vignette" }, { map = 1429, x = 79.6, y = 55.7 }, now - 3 * 86400, false)
Polestar.Codex.Load()`;
function raresScene(script) {
	return `${clientArtLua()}${RARES_SETUP}\n${script}`;
}
const RARES_FILES = [...FILES, 'Rares/Rares.xml'];
const TOAST = ['PolestarRareToast'];
// The guide menu's sample library: pitches, pros and cons on a few guides,
// Westfall on its real map (art with POLESTAR_CLIENT_ART), and leveling
// guides past 30 so the folders show the bands. Pitches written for the
// preview, not taken from any guide; ids, titles and levels are the shipped
// guides'.
const PICKER_SETUP = `local U = uistub.guides
local function about(id, pitch, pros, cons) local g = U[id]; g.pitch, g.pros, g.cons = pitch, pros, cons end
about("forever/alliance/human/01-elwynn-forest", "From Northshire Abbey down to Goldshire and the farms around it: short runs, an inn at the crossroads, and Westfall waiting to the west.",
	{ "Every quest giver within a short walk of Goldshire", "The inn is on the way to everything" }, { "Busy at peak hours" })
about("forever/alliance/02-westfall", "Farmland overrun by the Defias Brotherhood, with Sentinel Hill at its heart and the Deadmines at the end.",
	{ "A compact zone: most camps sit near Sentinel Hill", "Leads straight into the Deadmines", "A flight path at Sentinel Hill" }, { "Long walks to the coast", "Harvest Watchers crowd the fields" })
-- Where Engine.GuideFocus puts each guide, found the Engine's way: the first
-- goal on the guide's zone map, of its step when a tab has it open, else of
-- the guide (the guide's own percent: the stub Compat converts no frames).
-- The sample Westfall has no goals; its start is the guide file's.
local START = { ["forever/alliance/02-westfall"] = { 57, 47.17 } }
local function onZone(g, step)
	for _, goal in ipairs(step and step.goals or {}) do
		if goal.map == g.zone and goal.x and goal.y then return goal.x, goal.y end
	end
end
Polestar.Engine.GuideFocus = function(id)
	local g = U[id]
	if not g then return nil end
	for _, t in ipairs((Polestar.Engine.GetTabs())) do
		if t.guideId == id and t.stepIndex then
			local x, y = onZone(g, g.steps[t.stepIndex])
			if x then return x, y end
		end
	end
	if START[id] then return START[id][1], START[id][2] end
	for _, step in ipairs(g.steps) do
		local x, y = onZone(g, step)
		if x then return x, y end
	end
end
local function add(id, title, faction, lo, hi, zoneName, zone, n)
	local steps = {}
	for i = 1, n or 30 do steps[i] = { title = title .. " " .. i, goals = { { t = "note", text = "Step " .. i, status = "pending" } } } end
	U[id] = { id = id, title = title, faction = faction, minLevel = lo, maxLevel = hi, category = "Leveling", zone = zone or 0, zoneName = zoneName, steps = steps }
	table.insert(uistub.order, id)
end
add("forever/alliance/30-40/02-desolace", "Desolace", "Alliance", 31, 34, "Desolace", 1443)
add("forever/alliance/30-40/04-stranglethorn-vale", "Stranglethorn Vale", "Alliance", 34, 38, "Stranglethorn Vale", 1434)
add("forever/alliance/40-50/04-tanaris", "Tanaris", "Alliance", 45, 47, "Tanaris", 1446)
add("forever/horde/30-40/01-desolace", "Desolace & Hillsbrad Foothills", "Horde", 30, 33, "Desolace", 1443)
-- The Horde road from Durotar through the Barrens: compiled guides frozen in
-- tests/fixtures/preview/guides.lua, so the facts (quests, zones, the guide
-- after it) are real ones and a recompile of the shipped guides leaves the
-- renders alone. They replace the samples of the same id.
do
	local register, defs = Polestar.RegisterGuide, {}
	Polestar.RegisterGuide = function(def) defs[def.id] = def end
	dofile("tests/fixtures/preview/guides.lua")
	Polestar.RegisterGuide = register
	for _, rel in ipairs({ "orc-troll/01-durotar", "orc-troll/02-the-barrens", "02-the-barrens", "03-silverpine-forest", "04-the-barrens", "05-stonetalon-mountains" }) do
		local def = defs["forever/horde/" .. rel]
		if not U[def.id] then table.insert(uistub.order, def.id) end
		U[def.id] = def
	end
end`;
function pickerScene(script) {
	return `${clientArtLua()}${PICKER_SETUP}\n${script}`;
}
// Three guides open as tabs, the leveling one active.
const TABS = 'uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }, 1)';
// A route for the journey panel (UI/JourneyPanel.lua): the Nav fake gains a
// three-leg trip (Shortest Path Forever's example, 36:48 and 8.0k yd), the
// Great Lift's departures untimed until `timed`.
const JOURNEY = `Polestar.RegisterDefaults("nav", { distanceUnit = "yards", journeySteps = true, journeyOpen = true })
local Nav = Polestar.Nav
JR = { ci = 1, ps = 670, py = 3000, timed = false }
JR.legs = {
	{ kind = "walk", step = "lift", label = "Walk to The Great Lift, Top", seconds = 670, yards = 3000, to = { name = "The Great Lift, Top" } },
	{ kind = "lift", lift = 7, side = "top", label = "Take The Great Lift", seconds = 25, yards = 60, to = { name = "The Great Lift, Bottom" } },
	{ kind = "walk", label = "Walk to Silithus", seconds = 1513, yards = 4940, to = { name = "Silithus" } },
}
Nav.travel = { Active = function() return true end, Progress = function() return JR.ps, JR.py end }
function Nav.GetRoute() return JR.legs, JR.ci end
Nav.prompts = { MenuItems = function() return { { text = "Mark this leg done" } } end, OpenMenu = function() end }
Polestar.Transit = { Now = function() return 1000 end, NextDeparture = function() return 15, 10, JR.timed end }
uistub.target = { label = "Silithus" }
${TABS}
Polestar.Fire("ROUTE_CHANGED", JR.legs)`;
// The game's gamepad interface with a gamepad plugged in (labels "Letters":
// Xbox; "Shapes": PlayStation), LT acting as Shift, and a few saved bindings
// for the Key bindings tab.
const PAD = (labels = 'Letters') => `Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }
C_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }
C_GamePad = { IsEnabled = function() return true end, GetAllDeviceIDs = function() return { 1 } end,
	GetActiveDeviceID = function() return 1 end, GetDeviceMappedState = function() return { labelStyle = "${labels}" } end }
stub.cvars.GamePadEmulateShift = "PADLTRIGGER"
local saved = { PAD3 = "CLICK PolestarQuestItemButton:LeftButton", ["SHIFT-PADDRIGHT"] = "POLESTAR_NEXT", ["SHIFT-PADDLEFT"] = "POLESTAR_PREV", N = "POLESTAR_TOGGLE" }
function GetBindingKey(action)
	local keys = {}
	for k, a in pairs(saved) do if a == action then keys[#keys + 1] = k end end
	table.sort(keys)
	return unpack(keys)
end`;
// The gamepad's ring, hint bar and B chip, moved to the window holding the gamepad.
const PAD_UI = ['PolestarPadRing', 'PolestarPadHints', 'PolestarPadBadge'];
const PAD_GUIDE = [...GUIDE, ...PAD_UI];
const PAD_OPTIONS = [...OPTIONS, ...PAD_UI];
const HOVER = 'PolestarGuideFrame.IsMouseOver = function() return true end; Polestar.UI.GuideFrame.HoverIn()';
const RECORDER = `stub.addonsLoaded.Polestar_Recorder = true
PolestarRecorderDB = { enabled = true, current = "s2", sessions = {
	s1 = { char = { name = "Testchar" }, events = {} },
	s2 = { char = { name = "Testchar" }, events = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} } } } }`;
// A module registering its controls into a declared page, the way Quests,
// Gear, Maps and QoL do.
const REGISTERED = `Polestar.RegisterDefaults("qol", { mapObjectives = true, markerScale = 1, markerColor = { 1, 0.82, 0.3 } })
Polestar.RegisterOptions({ page = "Questing", tab = "Quests", section = "Quest database", controls = {
	{ kind = "toggle", key = "qol.mapObjectives", label = "Objective markers", help = "Show quest objectives on the world map." },
	{ kind = "slider", key = "qol.markerScale", label = "Marker size", min = 0.5, max = 2, step = 0.05, format = function(v) return math.floor(v * 100 + 0.5) .. "%" end },
	{ kind = "color", key = "qol.markerColor", label = "Marker colour" },
} })`;
// Every module that registers options, for the pages they fill.
const MODULE_FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml', 'QoL/QoL.xml', 'Lookup/Lookup.xml',
	'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml'];
// Six more pages from third-party modules, in the game font: the list
// scrolls in its own area, clear of the version and the stage chip.
const MANY_PAGES = `Polestar.Set("ui.font", "game")
Polestar.RegisterDefaults("extra", { on = true })
for i, name in ipairs({ "Professions", "Reputation", "Achievements", "Collections", "Talents", "Keybinds" }) do
	Polestar.RegisterOptions({ page = name, icon = "gear", order = 70 + i, controls = { { kind = "toggle", key = "extra.on", label = "Enabled" } } })
end`;
// A look of your own: the accent on a 2px border, no band, no shadow, and
// the arrow in your own colours.
const CUSTOM_LOOK = `Polestar.Set("ui.borderAccent", true); Polestar.Set("ui.borderSize", 2); Polestar.Set("ui.band", false); Polestar.Set("ui.shadow", false)
Polestar.Set("nav.arrowColor", { 0.45, 0.7, 1 }); Polestar.Set("nav.arrowNearColor", { 1, 0.55, 0.85 })`;
// The Community guides page over the real registry (uistub.realGuides in place
// of stub_ui's fake): ours and Joe's on, Ann's with two problems, Sam's
// too new for this Polestar, Kim's turned off in the AddOns list.
const PACKS_ADDONS = `stub.addons = {
	{ name = "Polestar", loaded = true }, { name = "Polestar_Guides", loaded = true }, { name = "JoeRoutes", loaded = true },
	{ name = "AnnDungeons", loaded = true }, { name = "SamProfessions", reason = "INTERFACE_VERSION" }, { name = "KimQuests", reason = "DISABLED", enabled = false },
}
stub.addonMeta.Polestar = { ["X-Website"] = "https://github.com/polestar-wow/polestar" }
stub.addonMeta.Polestar_Guides = { ["X-Polestar-Pack"] = "guides", ["X-Polestar-Format"] = "1" }
stub.addonMeta.JoeRoutes = { ["X-Polestar-Pack"] = "joe", ["X-Polestar-Format"] = "1" }
stub.addonMeta.AnnDungeons = { ["X-Polestar-Pack"] = "ann", ["X-Polestar-Format"] = "1" }
stub.addonMeta.SamProfessions = { ["X-Polestar-Pack"] = "sam", ["X-Polestar-Format"] = "3", ["X-Polestar-Needs"] = "0.3.0", Title = "Sam's Professions", Author = "Sam", Version = "0.9.0", ["X-License"] = "MIT" }
stub.addonMeta.KimQuests = { ["X-Polestar-Pack"] = "kim", ["X-Polestar-Format"] = "1", Title = "Kim's Quests", Author = "Kim", Version = "2.1.0", ["X-License"] = "CC0-1.0", ["X-Website"] = "https://github.com/kim/quests" }`;
const PACKS_SCENE = `local realGuides = uistub.realGuides
Polestar.Guides = realGuides
local function guide(id, pack, n, extra)
	for i = 1, n do
		local g = { id = id .. i, pack = pack, title = id .. i, minLevel = 1, maxLevel = 10, steps = { { goals = { { t = "level", level = 2 } } } } }
		for k, v in pairs(extra or {}) do g[k] = v end
		Polestar.RegisterGuide(g)
	end
end
Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "0.1.0", license = "GPL-3.0" })
guide("forever/g", "guides", 173)
Polestar.RegisterPack({ addon = "JoeRoutes", id = "joe", format = 1, title = "Joe's Routes", author = "Joe", version = "1.2.0", license = "CC-BY-4.0",
	website = "https://github.com/joe/routes", source = "Written from my own play" })
guide("joe/r", "joe", 58)
Polestar.RegisterPack({ addon = "AnnDungeons", id = "ann", format = 1, title = "Ann's Dungeons", author = "Ann", version = "0.4.0", license = "MIT" })
guide("ann/d", "ann", 12, { category = "Dungeons" })
guide("dungeons/deadmines", "ann", 1)
Polestar.RegisterGuide({ id = "ann/broken", pack = "ann", title = "Broken", steps = {} })
realGuides.ScanInstalled()`;
// The guide menu over the same registry: Joe's Routes listed under Community
// guides, its Westfall selected with the author's credits in the details.
const PACKS_PICKER = `Polestar.Guides = uistub.realGuides
local function guide(id, pack, title, zone, minL, maxL)
	local steps = {}
	for i = 1, 6 * (maxL - minL) do steps[i] = { goals = { { t = "level", level = maxL } } } end
	Polestar.RegisterGuide({ id = id, pack = pack, title = title, zone = zone, faction = "Alliance", category = "Leveling", minLevel = minL, maxLevel = maxL, steps = steps })
end
Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "0.1.0", license = "GPL-3.0" })
guide("forever/alliance/02-westfall", "guides", "Westfall", "Westfall", 10, 15)
Polestar.RegisterPack({ addon = "JoeRoutes", id = "joe", format = 1, title = "Joe's Routes", author = "Joe", version = "1.2.0", license = "CC-BY-4.0",
	website = "https://github.com/joe/routes", source = "Written from my own play" })
guide("joe/elwynn", "joe", "Elwynn Forest", "Elwynn Forest", 1, 10)
guide("joe/westfall", "joe", "Westfall", "Westfall", 10, 15)
guide("joe/redridge", "joe", "Redridge Mountains", "Redridge Mountains", 15, 20)
guide("joe/duskwood", "joe", "Duskwood", "Duskwood", 20, 25)
Polestar.RegisterPack({ addon = "AnnDungeons", id = "ann", format = 1, title = "Ann's Dungeons", author = "Ann", version = "0.4.0", license = "MIT" })
Polestar.RegisterGuide({ id = "ann/deadmines", pack = "ann", title = "The Deadmines", category = "Dungeons", minLevel = 17, maxLevel = 23, steps = { { goals = { { t = "level", level = 23 } } } } })
uistub.realGuides.ScanInstalled()`;

// The route choice window, filled the way Engine.GetRouteChoice fills it, with
// each zone's pitch, pros and cons read from its guide file. The shipped
// leveling guides follow one shared route (no choice), so the scene uses the
// frozen guides of tests/fixtures/placement, which offered one.
const ROUTE = ['PolestarRouteChoice'];
const ROUTE_GUIDES = path.join(ROOT, 'tests', 'fixtures', 'placement', 'forever');
function luaOf(v) {
	if (v === null || v === undefined) return 'nil';
	if (typeof v === 'number' || typeof v === 'boolean') return String(v);
	if (typeof v === 'string') return JSON.stringify(v);
	if (Array.isArray(v)) return `{ ${v.map(luaOf).join(', ')} }`;
	return `{ ${Object.entries(v).map(([k, x]) => `${k} = ${luaOf(x)}`).join(', ')} }`;
}
function routeOption(rel, extra) {
	const text = fs.readFileSync(path.join(ROUTE_GUIDES, rel), 'utf8');
	const all = (k) => [...text.matchAll(new RegExp(`^${k} (.+)$`, 'gm'))].map((m) => m[1].trim());
	const [min, max] = all('levels')[0].split('-').map(Number);
	const title = all('title')[0];
	return { id: all('guide')[0], title, zoneName: all('zone')[0], minLevel: min, maxLevel: max, pitch: all('pitch')[0], pros: all('pro'), cons: all('con'), ...extra };
}
// POLESTAR_CLIENT_ART: a local folder holding map art decoded from the game
// client (<fileID>.tga, base tiles and every overlay tile, plus maps.json:
// { [uiMapID]: { artID, layer, textures } }). With it, the route cards and the
// guide menu show each zone's real painting, unfogged by UI/ZoneArtOverlays.lua
// when artID matches, and every preview is written into <folder>/preview/
// instead of docs/preview/, so Blizzard art never lands in the repository.
// Without it, the cards show the night band.
const CLIENT_ART = process.env.POLESTAR_CLIENT_ART || null;
function clientArtLua() {
	if (!CLIENT_ART) return '';
	const maps = JSON.parse(fs.readFileSync(path.join(CLIENT_ART, 'maps.json'), 'utf8'));
	const entries = Object.entries(maps).map(([id, m]) => `[${id}] = ${luaOf(m)}`);
	return `C_Map = C_Map or {}
local ART = { ${entries.join(', ')} }
C_Map.GetMapArtLayers = function(id) local m = ART[id]; return m and { m.layer } or {} end
C_Map.GetMapArtLayerTextures = function(id) local m = ART[id]; return m and m.textures or {} end
C_Map.GetMapArtID = function(id) local m = ART[id]; return m and m.artID end
`;
}
// With POLESTAR_CLIENT_ART holding atlases.json ({ [lower-case atlas element]:
// { file, w, h, l, r, t, b } }, the Forever client's members) and files.json
// ({ [lower-case "interface\\...\\name"]: fileID }), the game's own UI art is
// drawn too: SetAtlas, C_Texture.GetAtlasInfo and SetTexture by path resolve
// to file IDs, so the game's looks (Theme/GameSkins.lua) can be checked
// before a client run. Only textures decoded into the folder are listed.
let uiArtLua;
function clientUiArtLua() {
	if (uiArtLua !== undefined) return uiArtLua;
	uiArtLua = '';
	const atlasFile = CLIENT_ART && path.join(CLIENT_ART, 'atlases.json');
	if (!atlasFile || !fs.existsSync(atlasFile)) return uiArtLua;
	const have = (fid) => fs.existsSync(path.join(CLIENT_ART, `${fid}.tga`));
	const atlases = Object.entries(JSON.parse(fs.readFileSync(atlasFile, 'utf8')))
		.filter(([, a]) => have(a.file))
		.map(([k, a]) => `[${JSON.stringify(k)}] = { ${a.file}, ${a.w}, ${a.h}, ${a.l}, ${a.r}, ${a.t}, ${a.b} }`);
	const files = Object.entries(JSON.parse(fs.readFileSync(path.join(CLIENT_ART, 'files.json'), 'utf8')))
		.filter(([, fid]) => have(fid))
		.map(([k, fid]) => `[${JSON.stringify(k)}] = ${fid}`);
	uiArtLua = `local ATLAS = { ${atlases.join(', ')} }
local FILES = { ${files.join(', ')} }
C_Texture = C_Texture or {}
C_Texture.GetAtlasInfo = function(n)
	local a = type(n) == "string" and ATLAS[n:lower()]
	if a then return { file = a[1], width = a[2], height = a[3], leftTexCoord = a[4], rightTexCoord = a[5], topTexCoord = a[6], bottomTexCoord = a[7] } end
end
local M = stub.Methods
local setTexture = M.SetTexture
M.SetTexture = function(self, p, ...)
	if type(p) == "string" then
		local fid = FILES[(p:lower():gsub("/", "\\\\"):gsub("%.blp$", ""))]
		if fid then p = fid end
	end
	return setTexture(self, p, ...)
end
M.SetAtlas = function(self, n, useSize)
	local a = type(n) == "string" and ATLAS[n:lower()]
	self.atlas = n
	if not a then return false end
	setTexture(self, a[1])
	self.texCoord = { a[4], a[5], a[6], a[7] }
	if useSize then self:SetSize(a[2], a[3]) end
	return true
end
`;
	return uiArtLua;
}
function routeScene(from, fromTitle, options, joinsAt) {
	const choice = { from, fromTitle, recommended: options.find((o) => o.recommended).id, joinsAt, options };
	return `${clientArtLua()}local E = Polestar.Engine
E.GetRouteChoice = function() return ${luaOf(choice)} end
E.PendingRouteChoice = function() return ${JSON.stringify(from)} end
Polestar.UI.ShowRouteChoice(${JSON.stringify(from)})`;
}
// zone: the guide's uiMapID; focusX/Y: where the route starts on it (live frame).
const UNDEAD_CHOICE = routeScene('forever/horde/undead/01-tirisfal-glades', 'Tirisfal Glades', [
	routeOption('horde/02-barrens.guide', { recommended: true, seconds: 610, quests: 43, zone: 1413, focusX: 51.5, focusY: 30.3 }),
	routeOption('horde/02-silverpine.guide', { seconds: 140, quests: 40, zone: 1421, focusX: 42.8, focusY: 40.9 }),
], 'Hillsbrad Foothills');

// Quest markers: the real Core, Theme, Nav (Pins) and Quests modules over
// the fixture quest database of tests/fixtures/questdb (built by `questdb
// build` into a temporary folder, as tests/quests.test.js does), with the
// client world of tests/lua/stub_world.lua and stub_quests.lua. A level 4
// Human in Elwynn Forest at the abbey, on a kill quest (7), an item quest with
// drops, a crate and a vendor (60), an object and an exploration objective
// (18), and one ready to hand in (33). No Blizzard art: the world map is a
// plain ground with a 10% grid and the zone name; the minimap a dark disc.
const QUEST_FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml'];
const QUEST_STUBS = ['stub_world.lua', 'stub_quests.lua'];
let questDbDir = null;
function questDbLua() {
	if (!questDbDir) {
		questDbDir = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-preview-questdb-'));
		writeQuestDB(buildQuestDB({ dataDir: path.join(ROOT, 'tests', 'fixtures', 'questdb') }), questDbDir);
		process.on('exit', () => fs.rmSync(questDbDir, { recursive: true, force: true }));
	}
	const files = ['MapFrames.lua', 'Quests.lua', 'Npcs.lua', 'Objects.lua', 'Items.lua'].map((f) => JSON.stringify(path.join(questDbDir, f)));
	return `stub.quests.dbFiles = { ${files.join(', ')} }`;
}
const MAP_W = 700, MAP_H = 470;
// Runs before the addon files: the world, then the map canvas (the shape of
// Blizzard_MapCanvas Polestar reads, tests/lua/wow_stub.lua's world map with
// its own canvas) sized like the world map's, and the minimap's ground. Map
// percent to canvas pixels: x * MAP_W, y * MAP_H from the top left.
const QUEST_PLAYER = { x: 46.4, y: 39.6 };
// The zone a scene plays in (default: Elwynn at the abbey); `frame` its
// world bounds, the same in the Era frame.
const ELWYNN = { map: 1429, name: 'Elwynn Forest', frame: 'c = 0, left = 1500, right = -1500, top = 500, bottom = -1500', player: QUEST_PLAYER };
function questWorld(place = ELWYNN) {
	return `${questDbLua()}
local w = stub.world
w.addMap(${place.map}, { name = "${place.name}", ${place.frame} })
w.moveTo(${place.map}, ${place.player.x}, ${place.player.y})
for q, t in pairs({ [7] = "Kobold Camp Cleanup", [18] = "Gathering Wood", [33] = "Wolves Across the Border", [60] = "Kobold Candles" }) do w.titles[q] = t end
w.complete({ 14 }); w.setLevel(4)
stub.worldMapID = ${place.map}
local FONT = "Interface\\\\AddOns\\\\Polestar\\\\Media\\\\Fonts\\\\Inter-SemiBold.ttf"
local NAV = "Interface\\\\AddOns\\\\Polestar\\\\Media\\\\Nav\\\\"

local map = WorldMapFrame
map:SetSize(${MAP_W}, ${MAP_H})
map:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
map:Show()
map.ScrollContainer:SetAllPoints(map)
local canvas = CreateFrame("Frame", nil, map.ScrollContainer)
canvas:SetPoint("TOPLEFT", map, "TOPLEFT", 0, 0)
canvas:SetSize(${MAP_W}, ${MAP_H})
canvas:SetClipsChildren(true)
local edge = map:CreateTexture(nil, "BACKGROUND")
edge:SetPoint("TOPLEFT", -1, 1); edge:SetPoint("BOTTOMRIGHT", 1, -1)
edge:SetColorTexture(0.03, 0.03, 0.04, 1)
local ground = canvas:CreateTexture(nil, "BACKGROUND")
ground:SetAllPoints(canvas)
ground:SetColorTexture(0.2, 0.24, 0.18, 1)
for i = 1, 9 do
	local v = canvas:CreateTexture(nil, "BORDER")
	v:SetColorTexture(1, 1, 1, 0.05); v:SetSize(1, ${MAP_H}); v:SetPoint("TOPLEFT", canvas, "TOPLEFT", i * ${MAP_W / 10}, 0)
	local h = canvas:CreateTexture(nil, "BORDER")
	h:SetColorTexture(1, 1, 1, 0.05); h:SetSize(${MAP_W}, 1); h:SetPoint("TOPLEFT", canvas, "TOPLEFT", 0, -i * ${MAP_H / 10})
end
local name = canvas:CreateFontString(nil, "ARTWORK")
name:SetFont(FONT, 15, ""); name:SetTextColor(0.93, 0.89, 0.78, 0.6)
name:SetPoint("TOPLEFT", canvas, "TOPLEFT", 14, -12); name:SetText("${place.name}")
function map.GetCanvas() return canvas end
-- Blizzard_WorldMap orders QUEST_BLOB far below SUPER_TRACKED_QUEST, both
-- under the player's unit pin.
local levels = { GetValidFrameLevel = function(_, t) return canvas:GetFrameLevel() + (t == "PIN_FRAME_LEVEL_QUEST_BLOB" and 2 or 20) end }
function map.GetPinFrameLevelsManager() return levels end
-- The player, as the world map's own unit pin draws it: above every pin.
local me = CreateFrame("Frame", nil, canvas)
me:SetFrameLevel(100); me:SetSize(22, 22)
me:SetPoint("CENTER", canvas, "TOPLEFT", ${(place.player.x / 100) * MAP_W}, ${-(place.player.y / 100) * MAP_H})
local meArrow = me:CreateTexture(nil, "OVERLAY")
meArrow:SetAllPoints(me); meArrow:SetTexture(NAV .. "arrow"); meArrow:SetRotation(0.4)

Minimap:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
stub.minimapZoom = 2
-- pin-fill's disc covers 42 of its 64 pixels.
local rim = Minimap:CreateTexture(nil, "BACKGROUND", nil, -1)
rim:SetTexture(NAV .. "pin-fill"); rim:SetVertexColor(0.04, 0.04, 0.05, 1)
rim:SetPoint("CENTER"); rim:SetSize(146 * 64 / 42, 146 * 64 / 42)
local disc = Minimap:CreateTexture(nil, "BACKGROUND")
disc:SetTexture(NAV .. "pin-fill"); disc:SetVertexColor(0.2, 0.24, 0.18, 1)
disc:SetPoint("CENTER"); disc:SetSize(140 * 64 / 42, 140 * 64 / 42)
-- The client draws the player arrow at the centre, above the pins.
local player = CreateFrame("Frame", nil, Minimap)
player:SetFrameLevel(100); player:SetSize(22, 22); player:SetPoint("CENTER")
local arrow = player:CreateTexture(nil, "OVERLAY")
arrow:SetAllPoints(player); arrow:SetTexture(NAV .. "arrow"); arrow:SetRotation(0.4)`;
}
// After login: the marker layers turned on (off by default), the quest log,
// then the markers settle (Quests' 0.2 s throttle).
const QUEST_LOG = `local w = stub.world
for _, k in ipairs({ "mapObjectives", "minimapObjectives", "objectiveAreas", "turnInMarkers", "availableQuests" }) do Polestar.Set("qol." .. k, true) end
stub.advance(0.3)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } }); w.progress(7, 1, 3)
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } }); w.progress(60, 1, 2)
w.accept(18, { { text = "Bundle of Wood: 0/1", type = "object", required = 1 }, { text = "Scout the farm", type = "event", required = 1 } })
w.accept(33, { { text = "Tough Wolf Meat: 0/8", type = "item", required = 8 } }); w.finish(33)
stub.advance(0.3)`;
// A guide on the step that takes on the kobolds and hands in the wolf meat:
// those quests' markers are highlighted, the others dimmed (qol.guideDim).
const QUEST_GUIDE = `Polestar.RegisterPack({ addon = "Polestar_Preview", id = "preview", format = 1, title = "Preview", author = "Polestar", version = "1", license = "GPL-3.0-only" })
Polestar.RegisterGuide({ id = "preview/elwynn", pack = "preview", title = "Elwynn Forest", faction = "Alliance", minLevel = 1, maxLevel = 10, zone = 1429, steps = {
	{ title = "Kobold Camp", goals = {
		{ t = "kill", quest = 7, target = "Kobold Vermin", count = 10, map = 1429, x = 47.8, y = 35.8 },
		{ t = "turnin", quest = 33, title = "Wolves Across the Border", npc = 196, npcName = "Eagan Peltskinner", map = 1429, x = 48.9, y = 40.2 },
	} },
} })
Polestar.Set("qol.guideDim", true)
Polestar.Engine.SetGuide("preview/elwynn")
stub.advance(0.3)`;
// A route into the next zone: Westfall west of the sample Elwynn, joined by
// one crossing on the border, so the walk goes to the crossing first (its
// caption is the default, "Go to <zone>") and the trail dots run to it.
const TRAVEL = `local w = stub.world
local WESTFALL = { name = "Westfall", c = 0, left = 4500, right = 1500, top = 500, bottom = -1500 }
w.addMap(1436, WESTFALL)
Polestar.Nav.RegisterCrossings({ complete = true,
	zones = { [1429] = w.maps[1429], [1436] = WESTFALL },
	crossings = { { id = "border", a = { map = 1429, c = 0, wx = -700, wy = 1460, r = 15 }, b = { map = 1436, c = 0, wx = -700, wy = 1540, r = 15 } } } })
Polestar.Nav.SetTarget(1436, 60, 45, "Sentinel Hill")
stub.advance(1)`;
// Spawn areas: Teldrassil's "The Balance of Nature" as the pack compiles it
// (`spots`: every place each goal's mobs and objects spawn), the player in
// the Grells' woods west of Aldrassil, no quest markers on. The arrow on the
// Fel Moss: the woods its Grells roam as one region and a lone Grell's place,
// in the arrow's colour; the Nightsabers', Thistle Boars' and Gnarlpine
// Totems' regions fainter (a place only the Nightsabers' other spawn covers
// fainter still). On the minimap the Fel Moss region, cut at the rim.
const TELDRASSIL = {
	map: 1438, name: 'Teldrassil', frame: 'c = 1, left = 3814.583, right = -1277.083, top = 11831.25, bottom = 8437.5', player: { x: 55.3, y: 42.4 },
};
const AREAS = `local w = stub.world
Polestar.RegisterMapFrames({ era = { [1438] = { ${TELDRASSIL.frame} } } })
w.setLevel(3)
w.titles[456], w.titles[459], w.titles[97977] = "The Balance of Nature", "The Woodland Protector", "Nature's Call"
w.accept(456, { { text = "Young Nightsaber slain: 0/7", type = "monster", required = 7 }, { text = "Young Thistle Boar slain: 0/4", type = "monster", required = 4 } })
w.progress(456, 1, 2)
w.accept(459, { { text = "Fel Moss: 0/8", type = "item", required = 8 } }); w.progress(459, 1, 3)
w.accept(97977, { { text = "Gnarlpine Totem destroyed: 0/1", type = "object", required = 1 } })
stub.advance(0.3)
Polestar.RegisterPack({ addon = "Polestar_Preview", id = "preview", format = 1, title = "Preview", author = "Polestar", version = "1", license = "GPL-3.0-only" })
Polestar.RegisterGuide({ id = "preview/areas", pack = "preview", title = "Teldrassil", faction = "Alliance", minLevel = 1, maxLevel = 10, zone = 1438, steps = {
	{ title = "The Balance of Nature", goals = {
		{ t = "kill", quest = 456, title = "The Balance of Nature", target = "Young Nightsaber", npc = 2031, count = 7, oi = 1, map = 1438, x = 57.87, y = 44.69, f = "e", spots = { { x = 57.2, y = 44.6, r = 35, n = 2 }, { x = 58.5, y = 46.1, r = 23, n = 3 }, { x = 61.3, y = 44.9, r = 63, n = 7 }, { x = 61.5, y = 40.1, r = 30, n = 2 }, { x = 62.4, y = 42.1, r = 50, n = 5 }, { x = 64.3, y = 41.3, r = 29, n = 2 }, { x = 57.9, y = 39, r = 15, n = 1, alt = true } } },
		{ t = "kill", quest = 456, title = "The Balance of Nature", target = "Young Thistle Boar", npc = 1984, count = 4, oi = 2, map = 1438, x = 57.44, y = 45.02, f = "e", spots = { { x = 57.1, y = 45, r = 34, n = 3 }, { x = 59, y = 44.7, r = 47, n = 4 }, { x = 55.7, y = 42.4, r = 48, n = 6 }, { x = 60.9, y = 46, r = 18, n = 2 }, { x = 61.7, y = 42.6, r = 51, n = 4 }, { x = 57.8, y = 42.4, r = 15, n = 1, alt = true }, { x = 57.6, y = 39.5, r = 15, n = 1, alt = true }, { x = 63.2, y = 42.2, r = 15, n = 1, alt = true } } },
		{ t = "collect", quest = 459, title = "The Woodland Protector", item = 3297, itemName = "Fel Moss", count = 8, oi = 1, map = 1438, x = 56.16, y = 45.81, f = "e", spots = { { x = 55.9, y = 45.9, r = 40, n = 6 }, { x = 54.6, y = 44.1, r = 40, n = 6 }, { x = 55.8, y = 41.6, r = 40, n = 1 }, { x = 56.2, y = 38.5, r = 40, n = 1 }, { x = 54.4, y = 39.1, r = 40, n = 7 }, { x = 56.3, y = 34.6, r = 40, n = 1 }, { x = 59.6, y = 35, r = 40, n = 1 }, { x = 62.3, y = 35.7, r = 40, n = 1 }, { x = 64.2, y = 42.2, r = 40, n = 1 } }, spread = true, from = "Grellkin", fromKind = "npc", fromAlso = "Grell" },
		{ t = "interact", quest = 97977, title = "Nature's Call", object = 668482, objName = "Gnarlpine Totem", oi = 1, map = 1438, x = 56, y = 46.1, f = "e", spots = { { x = 56, y = 46.1, r = 15, n = 1 }, { x = 55.2, y = 44.2, r = 36, n = 2 }, { x = 56.2, y = 39.4, r = 15, n = 1 }, { x = 54.6, y = 39.7, r = 26, n = 2 } }, note = "Gnarlpine Totem" },
	} },
} })
Polestar.Engine.SetGuide("preview/areas")
stub.advance(0.3)
Polestar.Engine.AimGoal(1, 3)
stub.advance(0.3)`;
function questScene(roots, script, place) {
	// `before` is read when the panel runs, so the database is only built for these scenes.
	return { roots, stubs: QUEST_STUBS, files: QUEST_FILES, get before() { return questWorld(place); }, script };
}
// Group content (the compiled `group`, the goal view's `party`): a class
// guide whose route needs a group, its Felwood step (elites; the author's
// "group 3" on the boss) and its Dire Maul step (two goals of one run, said
// once), next to one that needs none. Names from the shipped warlock mount
// guides; the steps are written for the preview.
const GROUP_GUIDES = `local function G(t, f) f.t = t; return f end
local DM = { kind = "dungeon", name = "Dire Maul" }
local function class(id, title, group, steps)
	uistub.guides[id] = { id = id, pack = "guides", title = title, classes = { "WARLOCK" }, minLevel = 60, maxLevel = 60, category = "Class", folder = "Warlock",
		zone = 1428, zoneName = "Burning Steppes", author = "Polestar", version = 1, group = group, steps = steps }
	table.insert(uistub.order, id)
end
class("forever/collectibles/mounts/neutral/warlock-dreadsteed", "Warlock Dreadsteed", true, {
	{ title = "Shadow Hold", goals = {
		G("kill", { verb = "Kill", subject = "Jaedenar Legionnaires", subjectKind = "npc", npc = 9862, progress = { cur = 2, max = 6 }, party = { kind = "elite", rank = 1 }, status = "active" }),
		G("kill", { verb = "Kill", subject = "Prince Xavalis", subjectKind = "npc", npc = 9876, party = { kind = "group", size = 3 }, status = "active" }),
	} },
	{ title = "Dire Maul", goals = {
		G("kill", { verb = "Kill", subject = "Xorothian Dreadsteed", subjectKind = "npc", npc = 14502, progress = { cur = 0, max = 1 }, party = DM, status = "active" }),
		G("complete", { verb = "Complete", subject = "Dreadsteed of Xoroth", subjectKind = "quest", quest = 7631, party = DM, status = "active" }),
	} },
})
class("forever/collectibles/mounts/neutral/warlock-felsteed", "Warlock Felsteed", nil, {
	{ title = "Gorzeeki Wildeyes", goals = { G("note", { text = "Step 1", status = "pending" }) } },
})
local DREADSTEED = "forever/collectibles/mounts/neutral/warlock-dreadsteed"
uistub.guides[DREADSTEED].reward = { { spell = 23161, spellName = "Summon Dreadsteed" } }
uistub.guides[DREADSTEED].why = "Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."
uistub.guides["forever/collectibles/mounts/neutral/warlock-felsteed"].reward = { { spell = 5784, spellName = "Summon Felsteed" } }
uistub.player.class, uistub.player.level = "WARLOCK", 60`;
// A level 12 shaman and two Class guides: Call of Water opens at 20
// (Engine.StartGate, stubbed as the engine would answer), Call of Earth now.
const NOT_YET_GUIDES = `local function G(t, f) f.t = t; return f end
local function class(id, title, lo, hi, steps)
	uistub.guides[id] = { id = id, pack = "guides", title = title, classes = { "SHAMAN" }, minLevel = lo, maxLevel = hi, category = "Class", folder = "Shaman",
		zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = steps }
	table.insert(uistub.order, id)
end
class("forever/class/shaman/call-of-water-horde", "Call of Water (Horde)", 20, 23, {
	{ title = "Searn Firewarder", goals = { G("accept", { verb = "Accept", subject = "Call of Water", subjectKind = "quest", quest = 1528, status = "active" }) } },
})
class("forever/class/shaman/call-of-earth-horde", "Call of Earth (Horde)", 4, 10, {
	{ title = "Canaga Earthcaller", goals = { G("accept", { verb = "Accept", subject = "Call of Earth", subjectKind = "quest", quest = 1516, status = "active" }) } },
})
local WATER = "forever/class/shaman/call-of-water-horde"
Polestar.Engine.StartGate = function(id)
	if id == WATER then return { level = 20, giver = "Searn Firewarder", map = 1454 } end
end
uistub.player.class, uistub.player.level = "SHAMAN", 12`;
// Class guides (`reward`, `why`): what the chain gives leads the details, a
// choice of rare items and a demon minion beside the mount. Rewards and why
// lines as the shipped warlock guides have them; steps written for the preview.
const CLASS_GUIDES = `${GROUP_GUIDES}
class("forever/class/warlock/impsys-request", "An Imp's Request", true, {
	{ title = "Impsy", goals = { G("note", { text = "Step 1", status = "pending" }) } },
	{ title = "The Sunken Temple", goals = { G("note", { text = "Step 2", status = "pending" }) } },
})
local IMPSY = uistub.guides["forever/class/warlock/impsys-request"]
IMPSY.minLevel, IMPSY.maxLevel, IMPSY.zone, IMPSY.zoneName = 50, 54, 1448, "Felwood"
IMPSY.reward = { { item = 20536, itemName = "Soul Harvester", quality = 3, choice = true }, { item = 20534, itemName = "Abyss Shard", quality = 3, choice = true },
	{ item = 20530, itemName = "Robes of Servitude", quality = 3, choice = true } }
IMPSY.why = "A staff, off-hand or robe for your 50s; Impsy's own errand, not a step of the Dreadsteed chain."
class("forever/class/warlock/incubus-horde", "Incubus (Horde)", nil, {
	{ title = "Devourer of Souls", goals = { G("note", { text = "Step 1", status = "pending" }) } },
})
local INCUBUS = uistub.guides["forever/class/warlock/incubus-horde"]
INCUBUS.minLevel, INCUBUS.maxLevel, INCUBUS.faction, INCUBUS.zone, INCUBUS.zoneName = 20, 28, "Horde", 1454, "Orgrimmar"
INCUBUS.reward = { { spell = 713, spellName = "Summon Incubus" }, { item = 22243, itemName = "Small Soul Pouch", quality = 2 } }
INCUBUS.why = "A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."`;
const SCENES = [
	{
		file: 'guide.svg',
		title: 'Guide window: a field step; a hub, one person at a time (first, then the second); the tip opened',
		panels: [
			{ roots: GUIDE, script: TABS },
			{ roots: GUIDE, script: `${TABS}; uistub.setStep(4)` },
			{ roots: GUIDE, script: `${TABS}; uistub.goal(4, 1).status = "done"; uistub.goal(4, 2).status = "done"; uistub.setStep(4)` },
			{ roots: GUIDE, script: `${TABS}; Polestar.UI.GuideFrame.parts.tip:Click()` },
		],
	},
	{
		file: 'skins-guide.svg',
		title: 'Skins: the guide window in Polestar, Halo and Hearth',
		backdrop: 'terrain',
		panels: [
			{ roots: GUIDE, script: TABS },
			{ roots: GUIDE, script: `Polestar.Set("ui.skin", "halo"); ${TABS}` },
			{ roots: GUIDE, script: `Polestar.Set("ui.skin", "hearth"); ${TABS}` },
		],
	},
	{
		file: 'skins-states.svg',
		title: 'Skins: a hub step, transparent and the header menu, in Halo and Hearth',
		backdrop: 'terrain',
		panels: [
			{ roots: GUIDE, script: `Polestar.Set("ui.skin", "halo"); ${TABS}; uistub.setStep(4)` },
			{ roots: GUIDE, script: `Polestar.Set("ui.skin", "halo"); Polestar.Set("ui.style", "transparent"); ${TABS}; ${HOVER}` },
			{ roots: [...GUIDE, 'PolestarMenu'], script: `Polestar.Set("ui.skin", "halo"); ${TABS}; stub.RunScript(Polestar.UI.GuideFrame.menuButton, "OnClick", "LeftButton")` },
			{ roots: GUIDE, script: `Polestar.Set("ui.skin", "hearth"); ${TABS}; uistub.setStep(4)` },
			{ roots: [...GUIDE, 'PolestarMenu'], script: `Polestar.Set("ui.skin", "hearth"); ${TABS}; stub.RunScript(Polestar.UI.GuideFrame.menuButton, "OnClick", "LeftButton")` },
		],
	},
	{
		file: 'guide-transparent.svg',
		title: 'Transparent mode over a bright world: at rest, and with the cursor over it',
		backdrop: 'terrain',
		panels: [
			{ roots: GUIDE, script: `Polestar.Set("ui.style", "transparent"); ${TABS}` },
			{ roots: GUIDE, script: `Polestar.Set("ui.style", "transparent"); ${TABS}; ${HOVER}` },
		],
	},
	{
		file: 'guide-compact.svg',
		title: 'Compact mode: standard and transparent',
		panels: [
			{ roots: GUIDE, script: `Polestar.Set("ui.compact", true); ${TABS}` },
			{ roots: GUIDE, script: `Polestar.Set("ui.compact", true); Polestar.Set("ui.style", "transparent"); ${TABS}` },
		],
		backdrop: 'terrain',
	},
	{
		file: 'guide-states.svg',
		title: 'No guide open, guide complete, out-levelled banner, header menu',
		panels: [
			{ roots: GUIDE, script: 'Polestar.Engine.SetGuide(nil)' },
			{ roots: GUIDE, script: `${TABS}; uistub.complete()` },
			{ roots: GUIDE, script: `${TABS}; Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall")` },
			{ roots: [...GUIDE, 'PolestarMenu'], script: `${TABS}; stub.RunScript(Polestar.UI.GuideFrame.menuButton, "OnClick", "LeftButton")` },
		],
	},
	{
		file: 'route-choice.svg',
		title: 'Choose your path: an Undead after Tirisfal Glades; the guide window while the choice waits',
		panels: [
			{ roots: ROUTE, script: UNDEAD_CHOICE },
			{ roots: GUIDE, script: `${TABS}; uistub.complete(); Polestar.Engine.PendingRouteChoice = function() return "forever/horde/undead/01-tirisfal-glades" end; Polestar.UI.GuideFrame.Render()` },
		],
	},
	{
		file: 'welcome.svg',
		title: 'The welcome, once per new character after login: Hello, Make it yours and Route style (on the account\'s first), Your first guide',
		panels: [
			{ roots: ['PolestarWelcome'], script: 'Polestar.UI.Welcome.Show("welcome")' },
			{ roots: ['PolestarWelcome'], script: 'Polestar.UI.Welcome.Show("setup")' },
			{ roots: ['PolestarWelcome'], script: 'Polestar.UI.Welcome.Show("route")' },
			{ roots: ['PolestarWelcome'], get script() { return `${clientArtLua()}Polestar.UI.Welcome.Show("start")`; } },
		],
	},
	{
		file: 'guide-professions.svg',
		title: 'Profession and reputation guides: chosen trainer with alternatives, skill bar, reputation bar',
		panels: [
			{ roots: GUIDE, script: 'uistub.openTabs({ { uistub.tailoring, 1 } }, 1); uistub.goal(1, 1).status = "active"; uistub.update()' },
			{ roots: GUIDE, script: 'uistub.openTabs({ { uistub.tailoring, 2 } }, 1)' },
			{ roots: GUIDE, script: 'uistub.openTabs({ { uistub.stormwindRep, 2 } }, 1)' },
		],
	},
	{
		file: 'guide-smart.svg',
		title: 'Smart logic: training reminder, an unavailable quest, a farm spot with alternatives',
		panels: [
			{
				roots: GUIDE,
				script: `${TABS}; Polestar.Fire("TRAIN_DUE", 12, { npc = 914, npcName = "Ander Germaine", map = 1453, x = 79.6, y = 70.2 })`,
			},
			{
				roots: GUIDE,
				script: `${TABS}; local g = uistub.goal(4, 2); g.status, g.unavailable, g.unavailableText = "skipped", "level", "Needs level 7"
uistub.setStep(4)`,
			},
			{
				roots: GUIDE,
				script: `${TABS}; local f = uistub.goal(3, 4); f.npcName, f.lvl, f.alternatives, f.detail = "Young Wolf", { min = 2, max = 4 }, 2, nil
f.candidates = { { npcName = "Young Wolf", map = 1429, x = 46, y = 38.5 } }
uistub.update()`,
			},
		],
	},
	{
		file: 'journey.svg',
		title: 'The journey under the focus: walking to the Great Lift (36:48, 8.0k yd, the lift untimed); on the lift, timed; collapsed to its totals',
		panels: [
			{ roots: GUIDE, script: JOURNEY },
			{ roots: GUIDE, script: `${JOURNEY}; JR.timed = true; JR.ci = 2; JR.ps = 25; JR.py = 60; Polestar.Fire("ROUTE_ADVANCED", JR.legs, 2)` },
			{ roots: GUIDE, script: `${JOURNEY}; Polestar.Set("nav.journeyOpen", false)` },
		],
	},
	{
		file: 'guide-group.svg',
		title: 'Group content: elites and an author\'s group size; a dungeon run said once; the guide menu\'s Group chip',
		panels: [
			{ roots: GUIDE, script: `${GROUP_GUIDES}; uistub.openTabs({ { DREADSTEED, 1 } }, 1)` },
			{ roots: GUIDE, script: `${GROUP_GUIDES}; uistub.openTabs({ { DREADSTEED, 2 } }, 1)` },
			{
				roots: PICKER,
				script: pickerScene(`${GROUP_GUIDES}; uistub.openTabs({ { DREADSTEED, 2 } }, 1); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Class")
Polestar.UI.Picker.Select(DREADSTEED)`),
			},
		],
	},
	{
		file: 'class-not-yet.svg',
		title: 'A Class guide opened too early: the guide window says from which level and who starts it; the guide menu\'s row says "From level 20"',
		panels: [
			{ roots: GUIDE, script: `${NOT_YET_GUIDES}; uistub.openTabs({ { WATER, 1 } }, 1)` },
			{
				roots: PICKER,
				script: pickerScene(`${NOT_YET_GUIDES}; Polestar.Set("ui.pickerFaction", "Horde"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Class")
Polestar.UI.Picker.Select("forever/class/shaman/call-of-earth-horde")`),
			},
		],
	},
	{
		file: 'picker-class.svg',
		title: 'Class guides in the guide menu: the details lead with what the chain gives and why (a mount spell; a choice of rare items; a demon and its soul bag)',
		panels: [
			{
				roots: PICKER,
				script: pickerScene(`${CLASS_GUIDES}; Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Class")
Polestar.UI.Picker.Select(DREADSTEED)`),
			},
			{
				roots: PICKER,
				script: pickerScene(`${CLASS_GUIDES}; Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Class")
Polestar.UI.Picker.Select("forever/class/warlock/impsys-request")`),
			},
			{
				roots: PICKER,
				script: pickerScene(`${CLASS_GUIDES}; Polestar.Set("ui.pickerFaction", "All"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Class")
Polestar.UI.Picker.Select("forever/class/warlock/incubus-horde")`),
			},
		],
	},
	{
		file: 'report.svg',
		title: 'Report a problem (the guide window\'s bug button): what went wrong, the right spot to mark, the report for the Polestar Discord, or a filled-in issue on GitHub; the invite on its own (the sidebar\'s Discord mark)',
		panels: [
			{
				roots: ['PolestarReport'],
				script: `${TABS}; Polestar.UI.ShowReport()
local d = PolestarReport.Desc
d:SetText("The vermin were all on the far side of the camp, by the tents.")
stub.RunScript(d, "OnTextChanged", true)`,
			},
			{ roots: ['PolestarCopy'], script: 'Polestar.UI.ShowDiscord()' },
		],
	},
	{
		file: 'guide-ellesmere.svg',
		title: 'With EllesmereUI: Polestar follows its accent and font by default; every colour stays editable',
		panels: [
			{ eui: true, roots: GUIDE, script: `stub.setAccent(0.6, 0.48, 1); ${TABS}` },
			{ eui: true, roots: OPTIONS, script: 'stub.setAccent(0.6, 0.48, 1); Polestar.UI.ShowOptions("appearance")' },
		],
	},
	{
		file: 'schemes.svg',
		title: 'Colour schemes on the guide window: Dusk (default), Night, Graphite, EllesmereUI; and your own ground, accent and brightness',
		panels: [
			{ roots: GUIDE, script: `${TABS}; uistub.setStep(4)` },
			{ roots: GUIDE, script: `Polestar.Set("ui.scheme", "night"); ${TABS}; uistub.setStep(4)` },
			{ roots: GUIDE, script: `Polestar.Set("ui.scheme", "graphite"); ${TABS}; uistub.setStep(4)` },
			{ eui: true, roots: GUIDE, script: `stub.setAccent(0.6, 0.48, 1); Polestar.Set("ui.scheme", "ellesmere"); ${TABS}; uistub.setStep(4)` },
			{ roots: GUIDE, script: `Polestar.Set("ui.bgColor", { 0.08, 0.2, 0.2 }); Polestar.Set("ui.accent", { 0.45, 0.85, 0.8 }); Polestar.Set("ui.brightness", 0.3); ${TABS}; uistub.setStep(4)` },
		],
	},
	{
		file: 'schemes-options.svg',
		title: 'Options > Appearance in each scheme: Dusk, Night, Graphite, and EllesmereUI installed (its scheme, follow toggles, its font offered)',
		panels: [
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("appearance")' },
			{ roots: OPTIONS, script: 'Polestar.Set("ui.scheme", "night"); Polestar.UI.ShowOptions("appearance")' },
			{ roots: OPTIONS, script: 'Polestar.Set("ui.scheme", "graphite"); Polestar.UI.ShowOptions("appearance")' },
			{ eui: true, roots: OPTIONS, script: 'stub.setAccent(0.6, 0.48, 1); Polestar.Set("ui.scheme", "ellesmere"); Polestar.UI.ShowOptions("appearance")' },
		],
	},
	{
		file: 'schemes-picker.svg',
		title: 'The guide menu in Dusk (default), Night, Graphite, and EllesmereUI with its purple accent',
		panels: [
			{ roots: PICKER, script: pickerScene(`${TABS}; Polestar.Set("ui.pickerFaction", "All"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Leveling"); Polestar.UI.Picker.Select("forever/alliance/02-westfall")`) },
			{ roots: PICKER, script: pickerScene(`Polestar.Set("ui.scheme", "night"); ${TABS}; Polestar.Set("ui.pickerFaction", "All"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Leveling"); Polestar.UI.Picker.Select("forever/alliance/02-westfall")`) },
			{ roots: PICKER, script: pickerScene(`Polestar.Set("ui.scheme", "graphite"); ${TABS}; Polestar.Set("ui.pickerFaction", "All"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Leveling"); Polestar.UI.Picker.Select("forever/alliance/02-westfall")`) },
			{ eui: true, roots: PICKER, script: pickerScene(`stub.setAccent(0.6, 0.48, 1); Polestar.Set("ui.scheme", "ellesmere"); ${TABS}; Polestar.Set("ui.pickerFaction", "All"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Leveling"); Polestar.UI.Picker.Select("forever/alliance/02-westfall")`) },
		],
	},
	{
		file: 'options.svg',
		title: 'Options: Guide (Window, Arrow & routes, Automation)',
		panels: [
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("guide")' },
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("guide"); Polestar.UI.Options.Select("guide", "Arrow & routes")' },
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("guide"); Polestar.UI.Options.Select("guide", "Automation")' },
		],
	},
	{
		file: 'skins-options.svg',
		title: 'Skins: Options in Halo and Hearth (Guide, Window; Appearance, Windows with the Skin setting)',
		panels: [
			{ roots: OPTIONS, script: 'Polestar.Set("ui.skin", "halo"); Polestar.UI.ShowOptions("guide")' },
			{ roots: OPTIONS, script: 'Polestar.Set("ui.skin", "halo"); Polestar.UI.ShowOptions("appearance"); Polestar.UI.Options.Select("appearance", "Windows")' },
			{ roots: OPTIONS, script: 'Polestar.Set("ui.skin", "hearth"); Polestar.UI.ShowOptions("guide")' },
			{ roots: OPTIONS, script: 'Polestar.Set("ui.skin", "hearth"); Polestar.UI.ShowOptions("appearance"); Polestar.UI.Options.Select("appearance", "Windows")' },
		],
	},
	{
		file: 'gamepad-guide.svg',
		title: 'Focus mode on the guide window (Browse the guide with the gamepad): the first open goal; down a line on a hub step; up into the navigator with PlayStation buttons',
		panels: [
			{ roots: PAD_GUIDE, before: PAD(), script: `${TABS}; Polestar.Gamepad.StartFocus()` },
			{ roots: PAD_GUIDE, before: PAD(), script: `${TABS}; uistub.setStep(4); Polestar.Gamepad.StartFocus(); Polestar.Gamepad.Dispatch("PADDDOWN")` },
			{ roots: PAD_GUIDE, before: PAD('Shapes'), script: `${TABS}; Polestar.Gamepad.StartFocus(); Polestar.Gamepad.Dispatch("PADDUP")` },
		],
	},
	{
		file: 'gamepad-options.svg',
		title: 'Options with a gamepad: the Gamepad page (a dropdown focused, D-pad left / right steps it), a binding row on its Key bindings tab (chips for buttons, chords and keys), and a slider with PlayStation buttons; B sits on the close button',
		panels: [
			{ roots: PAD_OPTIONS, before: PAD(), script: 'Polestar.UI.ShowOptions("gamepad"); stub.advance(0.3)' },
			{ roots: PAD_OPTIONS, before: PAD(), script: 'Polestar.UI.ShowOptions("gamepad"); stub.advance(0.3); Polestar.Gamepad.Dispatch("PADRSHOULDER"); stub.advance(0.3); Polestar.Gamepad.Dispatch("PADDDOWN")' },
			{
				roots: PAD_OPTIONS, before: PAD('Shapes'),
				script: `Polestar.UI.ShowOptions("guide"); stub.advance(0.3)
local G = Polestar.Gamepad
for _ = 1, 30 do
	local f = G.Focused(PolestarOptions)
	if f and f.psStep then break end
	G.Dispatch("PADDDOWN")
end`,
			},
		],
	},
	{
		file: 'gamepad-hub.svg',
		title: 'The guide menu with a gamepad: the focus starts on the selected guide (X loads it, LB / RB step the sections); a dropdown\'s choices in the shared menu, the current one focused',
		panels: [
			{ roots: [...PICKER, ...PAD_UI], before: PAD(), script: pickerScene(`${TABS}; Polestar.UI.ShowPicker(); Polestar.UI.Picker.Select(uistub.elwynn); stub.advance(0.3)`) },
			{ roots: [...PAD_OPTIONS, 'PolestarMenu'], before: PAD(), script: 'Polestar.UI.ShowOptions("gamepad"); stub.advance(0.3); Polestar.Gamepad.Dispatch("PAD1")' },
		],
	},
	{
		file: 'options-appearance.svg',
		title: 'Options: Appearance (Colour & type, Windows, Arrow); then a look of your own: an accent border 2px thick, no band, no shadow, your own arrow colours',
		panels: [
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("appearance")' },
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("appearance"); Polestar.UI.Options.Select("appearance", "Windows")' },
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("appearance"); Polestar.UI.Options.Select("appearance", "Arrow")' },
			{ roots: OPTIONS, script: `${CUSTOM_LOOK}; Polestar.UI.ShowOptions("appearance"); Polestar.UI.Options.Select("appearance", "Windows")` },
			{ roots: GUIDE, script: `${CUSTOM_LOOK}; ${TABS}; uistub.setStep(4)` },
		],
	},
	{
		file: 'options-modules.svg',
		title: 'Options: pages the modules fill: Map, Questing, Discovery, Quality of Life',
		panels: [
			{ files: MODULE_FILES, roots: OPTIONS, script: 'Polestar.UI.ShowOptions("map")' },
			{ files: MODULE_FILES, roots: OPTIONS, script: 'Polestar.UI.ShowOptions("questing")' },
			{ files: MODULE_FILES, roots: OPTIONS, script: 'Polestar.UI.ShowOptions("discovery"); Polestar.UI.Options.Select("discovery", "Rares")' },
			{ files: MODULE_FILES, roots: OPTIONS, script: 'Polestar.UI.ShowOptions("qualityoflife")' },
		],
	},
	{
		file: 'options-more.svg',
		title: 'Options: Recorder and About, at the foot of the list',
		panels: [
			{ roots: OPTIONS, before: RECORDER, script: 'Polestar.UI.ShowOptions("recorder")' },
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("about")' },
		],
	},
	{
		file: 'options-integrations.svg',
		title: 'Options: Integrations: Questie\'s section while Questie is loaded; with no supported addon, one line says so',
		panels: [
			{ roots: OPTIONS, script: 'stub.addonsLoaded.Questie = true; Polestar.UI.ShowOptions("integrations")' },
			{ roots: OPTIONS, script: 'Polestar.UI.ShowOptions("integrations")' },
		],
	},
	{
		file: 'options-packs.svg',
		title: 'Options: Community guides: ours and a community addon on, one with problems and its report, one turned off, one too new; where suggestions come from',
		panels: [
			{ roots: OPTIONS, before: PACKS_ADDONS, script: `${PACKS_SCENE}; Polestar.UI.ShowOptions("guidepacks")` },
			{ roots: OPTIONS, before: PACKS_ADDONS, script: `${PACKS_SCENE}; Polestar.UI.ShowOptions("guidepacks")
				for _, r in ipairs(Polestar.UI.Packs.view.rows) do if r:IsShown() and r.psRecord.id == "ann" then r.ShowList:Click(); r.CopyReport:Click() end end` },
		],
	},
	{
		file: 'options-search.svg',
		title: 'Options: a module\'s registered controls, search across pages, and a crowded sidebar in the game font that scrolls clear of the version',
		panels: [
			{ roots: OPTIONS, script: `${REGISTERED}; Polestar.UI.ShowOptions("questing")` },
			{ roots: OPTIONS, script: `${REGISTERED}; Polestar.UI.ShowOptions(); local box = Polestar.UI.Options.frame.Search; box:SetText("arrow"); stub.RunScript(box, "OnTextChanged", true)` },
			{ files: MODULE_FILES, roots: OPTIONS, script: `${MANY_PAGES}; Polestar.UI.ShowOptions("about")` },
		],
	},
	{
		file: 'skins-more.svg',
		title: 'Skins: the welcome, the journey and the route choice in Halo, then in Hearth',
		backdrop: 'terrain',
		panels: [
			{ roots: ['PolestarWelcome'], script: 'Polestar.Set("ui.skin", "halo"); Polestar.UI.Welcome.Show("welcome")' },
			{ roots: GUIDE, script: `Polestar.Set("ui.skin", "halo"); ${JOURNEY}` },
			{ roots: ROUTE, script: `Polestar.Set("ui.skin", "halo"); ${UNDEAD_CHOICE}` },
			{ roots: ['PolestarWelcome'], script: 'Polestar.Set("ui.skin", "hearth"); Polestar.UI.Welcome.Show("welcome")' },
			{ roots: GUIDE, script: `Polestar.Set("ui.skin", "hearth"); ${JOURNEY}` },
			{ roots: ROUTE, script: `Polestar.Set("ui.skin", "hearth"); ${UNDEAD_CHOICE}` },
		],
	},
	{
		file: 'skins-dungeons.svg',
		title: 'Skins: the dungeon journal in Halo and Hearth',
		panels: [
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Set("ui.skin", "halo"); Polestar.Dungeons.Open("wailing-caverns")') },
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Set("ui.skin", "hearth"); Polestar.Dungeons.Open("wailing-caverns")') },
		],
	},
	{
		file: 'skins-picker.svg',
		title: 'Skins: the guide menu in Halo and Hearth',
		panels: [
			{ roots: PICKER, script: pickerScene(`Polestar.Set("ui.skin", "halo"); ${TABS}; Polestar.UI.ShowPicker(); Polestar.UI.Picker.Select(uistub.elwynn)`) },
			{ roots: PICKER, script: pickerScene(`Polestar.Set("ui.skin", "hearth"); ${TABS}; Polestar.UI.ShowPicker(); Polestar.UI.Picker.Select(uistub.elwynn)`) },
		],
	},
	{
		file: 'skins-new.svg',
		title: 'Skins: the welcome\'s Route style page, Options\' Community guides, the gamepad\'s focus and hints, and the report window, in Halo and Hearth',
		panels: ['halo', 'hearth'].flatMap((k) => [
			{ roots: ['PolestarWelcome'], script: `Polestar.Set("ui.skin", "${k}"); Polestar.UI.Welcome.Show("route")` },
			{ roots: OPTIONS, before: PACKS_ADDONS, script: `Polestar.Set("ui.skin", "${k}"); ${PACKS_SCENE}; Polestar.UI.ShowOptions("guidepacks")` },
			{ roots: PAD_OPTIONS, before: PAD(), script: `Polestar.Set("ui.skin", "${k}"); Polestar.UI.ShowOptions("gamepad"); stub.advance(0.3)` },
			{ roots: ['PolestarReport'], script: `Polestar.Set("ui.skin", "${k}"); ${TABS}; Polestar.UI.ShowReport()` },
		]),
	},
	// The game's looks draw the client's own art: rendered only with
	// POLESTAR_CLIENT_ART (local: true), so it never lands in docs/preview.
	...['forever', 'blizzard', 'classic'].map((k) => ({
		file: `skins-game-${k}.svg`,
		title: `Skins: ${k}: the guide window (a hub step, the menu), Options (Guide, Appearance, Community guides, Gamepad), the welcome's Route style page and the report window`,
		backdrop: 'terrain',
		local: true,
		panels: [
			{ roots: GUIDE, script: `Polestar.Set("ui.skin", "${k}"); ${TABS}; uistub.setStep(4)` },
			{ roots: [...GUIDE, 'PolestarMenu'], script: `Polestar.Set("ui.skin", "${k}"); ${TABS}; stub.RunScript(Polestar.UI.GuideFrame.menuButton, "OnClick", "LeftButton")` },
			{ roots: OPTIONS, script: `Polestar.Set("ui.skin", "${k}"); Polestar.UI.ShowOptions("guide")` },
			{ roots: OPTIONS, script: `Polestar.Set("ui.skin", "${k}"); Polestar.UI.ShowOptions("appearance"); Polestar.UI.Options.Select("appearance", "Windows")` },
			{ roots: OPTIONS, before: PACKS_ADDONS, script: `Polestar.Set("ui.skin", "${k}"); ${PACKS_SCENE}; Polestar.UI.ShowOptions("guidepacks")` },
			{ roots: PAD_OPTIONS, before: PAD(), script: `Polestar.Set("ui.skin", "${k}"); Polestar.UI.ShowOptions("gamepad"); stub.advance(0.3)` },
			{ roots: ['PolestarWelcome'], script: `Polestar.Set("ui.skin", "${k}"); Polestar.UI.Welcome.Show("route")` },
			{ roots: ['PolestarReport'], script: `Polestar.Set("ui.skin", "${k}"); ${TABS}; Polestar.UI.ShowReport()` },
		],
	})),
	{
		file: 'picker.svg',
		title: 'Guide menu: Home (Continue, Suggested) with the details; Leveling folders by faction and band',
		panels: [
			{
				roots: PICKER,
				script: pickerScene(`${TABS}; Polestar.UI.ShowPicker(); Polestar.UI.Picker.Select(uistub.elwynn)`),
			},
			{
				roots: PICKER,
				script: pickerScene(`${TABS}; Polestar.Set("ui.pickerFaction", "All"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Leveling")
Polestar.UI.Picker.Select("forever/alliance/02-westfall")`),
			},
		],
	},
	{
		file: 'picker-packs.svg',
		title: 'Guide menu: a community addon under Community guides, its guide credited to its author',
		panels: [
			{
				roots: PICKER,
				before: PACKS_ADDONS,
				script: `${PACKS_PICKER}; Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("pack:joe"); Polestar.UI.Picker.Select("joe/westfall")`,
			},
		],
	},
	{
		file: 'picker-views.svg',
		title: 'Guide menu: Current (the open tabs) and Recent (the last guides loaded)',
		panels: [
			{
				roots: PICKER,
				script: pickerScene(`${TABS}; Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetView("current"); Polestar.UI.Picker.Select(uistub.tailoring)`),
			},
			{
				roots: PICKER,
				script: pickerScene(`${TABS}; Polestar.CharState().ui = { recentGuides = { "forever/alliance/02-westfall", uistub.elwynn, "forever/alliance/dwarf-gnome/01-dun-morogh", "forever/alliance/nightelf/01-teldrassil" } }
Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetView("recent"); Polestar.UI.Picker.Select("forever/alliance/02-westfall")`),
			},
		],
	},
	{
		file: 'picker-search.svg',
		title: 'Guide menu: Favourites (star on), and a search with its first result selected',
		panels: [
			{
				roots: PICKER,
				script: pickerScene(`${TABS}; Polestar.CharState().ui = { favoriteGuides = { ["forever/alliance/02-westfall"] = true, ["forever/collectibles/mounts/alliance/horse"] = true } }
Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Favorites"); Polestar.UI.Picker.Select("forever/alliance/02-westfall")`),
			},
			{
				roots: PICKER,
				script: pickerScene(`${TABS}; Polestar.UI.ShowPicker(); local box = Polestar.UI.Picker.search; box:SetText("elwynn"); stub.RunScript(box, "OnTextChanged", true)`),
			},
		],
	},
	{
		file: 'picker-art.svg',
		title: 'Guide menu zone art: the Durotar starter at its first stop; The Barrens (19\u201324) open at step 13, on that step',
		panels: [
			{
				roots: PICKER,
				script: pickerScene(`Polestar.Set("ui.pickerFaction", "Horde"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Leveling")
Polestar.UI.Picker.Select("forever/horde/orc-troll/01-durotar")`),
			},
			{
				roots: PICKER,
				script: pickerScene(`uistub.openTabs({ { "forever/horde/04-the-barrens", 13 } }, 1); Polestar.Set("ui.pickerFaction", "Horde"); Polestar.UI.ShowPicker()
Polestar.UI.Picker.SetCategory("Leveling"); Polestar.UI.Picker.Select("forever/horde/04-the-barrens")`),
			},
		],
	},
	{
		file: 'hub.svg',
		title: 'The hub: sections on the rail (Guides, Lookup, Dungeons, Rares) with Options at its foot; the sidebar holds the wordmark, the search and the section\'s own index on one edge',
		panels: [
			{ roots: PICKER, script: pickerScene(`${TABS}; Polestar.Set("ui.pickerFaction", "All"); Polestar.UI.ShowPicker(); Polestar.UI.Picker.SetCategory("Leveling"); Polestar.UI.Picker.Select("forever/alliance/02-westfall")`) },
			{ codex: true, roots: PICKER, script: lookupScene('Polestar.Lookup.Show("saber")') },
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Dungeons.Open()') },
		],
	},
	{
		file: 'lookup.svg',
		title: 'Lookup in the hub, over the sample Codex: "saber" with a vendor mount selected; the Winterspring Frostsaber, reputation or a limited vendor, its best source chosen; an empty search: the recent lookups',
		panels: [
			{ codex: true, roots: PICKER, script: lookupScene('Polestar.Lookup.Show("saber")') },
			{ codex: true, roots: PICKER, script: lookupScene('Polestar.Lookup.Show(nil, "mount", 13086); Polestar.UI.Lookup.SelectSource(1)') },
			{ codex: true, roots: PICKER, script: lookupScene('Polestar.Lookup.Show(nil, "mount", 8631); Polestar.Lookup.Show(nil, "npc", 448); Polestar.Lookup.Show(nil, "mount", 13335); Polestar.UI.Picker.SetQuery("")') },
		],
	},
	{
		file: 'lookup-retired.svg',
		title: 'Lookup: "frostsaber" with the retired Reins of the Frostsaber last, dimmed with its chip; its details for reference, no guide',
		panels: [
			{ codex: true, roots: PICKER, script: lookupScene('Polestar.Lookup.Show("frostsaber"); Polestar.UI.Lookup.Select("mount", 12302)') },
		],
	},
	{
		file: 'lookup-drop.svg',
		title: "Lookup: Deathcharger's Reins for a level 4 character, a rare drop out of reach, saying why",
		panels: [{ codex: true, roots: PICKER, script: lookupScene('Polestar.Lookup.Show(nil, "mount", 13335); Polestar.UI.Lookup.SelectSource(1)', '') }],
	},
	{
		file: 'lookup-missing.svg',
		title: 'Lookup without the Codex pack: opened; a search only the Codex could answer; a guide still found',
		panels: [
			{ roots: PICKER, script: lookupScene('Polestar.UI.ShowLookup()') },
			{ roots: PICKER, script: lookupScene('Polestar.Lookup.Show("saber")') },
			{ roots: PICKER, script: lookupScene('Polestar.Lookup.Show("westfall")') },
		],
	},
	{
		file: 'picker-codex.svg',
		title: 'Guide search in the hub: the guides that match, then what the Codex holds (a few per kind) and a way into Lookup',
		panels: [
			{ codex: true, roots: PICKER, script: pickerScene(lookupScene(`${TABS}; Polestar.UI.ShowPicker(); local box = Polestar.UI.Picker.search; box:SetText("elwynn"); stub.RunScript(box, "OnTextChanged", true)`)) },
			{ codex: true, roots: PICKER, script: pickerScene(lookupScene(`${TABS}; Polestar.UI.ShowPicker(); local box = Polestar.UI.Picker.search; box:SetText("wol"); stub.RunScript(box, "OnTextChanged", true)`)) },
		],
	},
	{
		file: 'gear-pick.svg',
		title: 'The reward pick under turn-in goals: an upgrade (chevron, gain) and, with nothing better, the best of the choices',
		panels: [
			{ roots: GUIDE, script: `${GEAR_SETUP}\n${TABS}; uistub.setStep(4)` },
			{ roots: GUIDE, script: `${GEAR_SETUP}\nworn[5] = "item:9101"; worn[7] = "item:9103"; worn[10] = "item:9106"; worn[8] = "item:9107"; Polestar.Gear.Invalidate("equipment")\n${TABS}; uistub.setStep(4)` },
		],
	},
	{
		file: 'quest-rewards.svg',
		title: "The game's reward panel: a green arrow on each upgrade, the one to take framed in the accent; with no upgrade, the coin on the one that sells for most",
		panels: [
			{ roots: ['QuestInfoRewardsFrame'], files: REWARD_FILES, script: `${GEAR_SETUP}\n${REWARD_PANEL}` },
			{ roots: ['QuestInfoRewardsFrame'], files: REWARD_FILES, script: `${GEAR_SETUP}\nworn[5] = "item:9101"; worn[7] = "item:9103"; worn[16] = "item:9104"; Polestar.Gear.Invalidate("equipment")\n${REWARD_PANEL}` },
		],
	},
	{
		file: 'quests-map.svg',
		title: 'Quest markers on the world map: givers, kill, item (drops, crate, vendor), object and exploration objectives, a turn-in; then a guide step highlighting its quests and dimming the rest',
		panels: [
			questScene(['WorldMapFrame'], QUEST_LOG),
			questScene(['WorldMapFrame'], `${QUEST_LOG}\n${QUEST_GUIDE}`),
		],
	},
	{
		file: 'quests-minimap.svg',
		title: 'Quest markers on the minimap around the player: nearby objectives, givers and the turn-in; then with the guide step highlighted',
		panels: [
			questScene(['Minimap'], QUEST_LOG),
			questScene(['Minimap'], `${QUEST_LOG}\n${QUEST_GUIDE}`),
		],
	},
	{
		file: 'travel.svg',
		title: 'Travel: the arrow (Arrow scale 160%) on a route into the next zone, its leg captioned ("Go to Westfall"), and the trail dots on the world map from the player to the zone crossing; then the arrow where the game gives no position (the Deeprun Tram)',
		panels: [
			questScene(['PolestarNavArrow'], `Polestar.Set("nav.arrowScale", 1.6)\n${TRAVEL}`),
			questScene(['WorldMapFrame'], TRAVEL),
			questScene(['PolestarNavArrow'], `Polestar.Set("nav.arrowScale", 1.6)\n${TRAVEL}\nstub.world.map = nil\nstub.advance(0.2)`),
		],
	},
	{
		file: 'nav-areas.svg',
		title: "Spawn regions: Teldrassil's The Balance of Nature, the arrow on the Fel Moss. On the world map every place the step's mobs and objects spawn is a region: the Grells' woods west and north of Aldrassil and a lone Grell's place in the arrow's colour, the Nightsabers', Thistle Boars' and Gnarlpine Totems' regions fainter; on the minimap the Fel Moss region around the player, cut at the rim",
		panels: [
			questScene(['WorldMapFrame'], AREAS, TELDRASSIL),
			questScene(['Minimap'], AREAS, TELDRASSIL),
		],
	},
	{
		file: 'dungeons.svg',
		title: 'Dungeons in the hub: Home for a level 20 Tauren (the dungeons for your level, faction filter Horde); Wailing Caverns, its Quests tab',
		panels: [
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Dungeons.Open()') },
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Dungeons.Open("wailing-caverns")') },
		],
	},
	{
		file: 'dungeons-bosses.svg',
		title: 'Wailing Caverns: the Bosses tab (kill order and the quests each serves) and the Map tab (the entrance and the quest givers near it); All dungeons with the filter on All',
		panels: [
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Dungeons.Open("wailing-caverns"); DS.SetTab("bosses")') },
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Dungeons.Open("wailing-caverns"); DS.SetTab("map")') },
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Dungeons.Open(); DS.SetFaction("All"); DS.SetBand("all")') },
		],
	},
	{
		file: 'dungeons-attune.svg',
		title: 'The Attunement tab: Wailing Caverns\' attunement with the first quest done and the second in the log, and "Guide me through it"; the Deadmines\' keys with the filter on All',
		panels: [
			{ dungeons: true, roots: PICKER, script: dungeonsScene('done[90001] = true; log[90002] = true; Polestar.Dungeons.Open("wailing-caverns"); DS.SetTab("attune")') },
			{ dungeons: true, roots: PICKER, script: dungeonsScene('DS.SetFaction("All"); Polestar.Dungeons.Open("deadmines"); DS.SetTab("attune")') },
		],
	},
	{
		file: 'dungeons-small.svg',
		title: 'The hub at its smallest (menu scale 0.7): Wailing Caverns, Quests; without the Codex pack',
		panels: [
			{ dungeons: true, roots: PICKER, script: dungeonsScene('Polestar.Set("ui.menuScale", 0.7); Polestar.Dungeons.Open("wailing-caverns")') },
			{ roots: PICKER, script: dungeonsScene('Polestar.Dungeons.Open()') },
		],
	},
	{
		file: 'rares.svg',
		title: 'Rares in the hub: Elwynn Forest\'s rares by zone, Thuros Lightfingers with its signature drop, its spawns and when it was last met; the Seen list',
		panels: [
			{ rares: true, files: RARES_FILES, roots: PICKER, script: raresScene('Polestar.Rares.Show("rare", 61)') },
			{ rares: true, files: RARES_FILES, roots: PICKER, script: raresScene('Polestar.Rares.Show(); Polestar.UI.RaresSection.SetTab("seen")') },
		],
	},
	{
		file: 'rares-toast.svg',
		title: 'The rare alert over the world: a rare on the minimap at its distance; a rare elite in sight; a treasure',
		backdrop: 'terrain',
		panels: [
			{ rares: true, files: RARES_FILES, roots: TOAST, script: raresScene('local a = Polestar.Rares.AlertOf({ source = "vignette", kind = "rare", id = 61, name = "Thuros Lightfingers", level = 11 }, { map = 1429, x = 89.2, y = 79.1 }, true); a.yards = 87; Polestar.Fire("RARE_SPOTTED", a); stub.advance(4)') },
			{ rares: true, files: RARES_FILES, roots: TOAST, script: raresScene('Polestar.Fire("RARE_SPOTTED", Polestar.Rares.AlertOf({ source = "nameplate", kind = "rare", id = 471, name = "Mother Fang", level = 10, classification = "rareelite" }, nil, false)); stub.advance(12)') },
			{ rares: true, files: RARES_FILES, roots: TOAST, script: raresScene('local a = Polestar.Rares.AlertOf({ source = "vignette", kind = "treasure", id = 2843, name = "Battered Chest" }, { map = 1429, x = 79.6, y = 55.7 }, true); a.yards = 412; Polestar.Fire("RARE_SPOTTED", a)') },
		],
	},
];

// panel.stubs / panel.files: other client stubs and manifests than the UI's
// (stub_ui.lua's fake Engine and guides, installed after load).
function dumpPanel(panel, prelude) {
	const before = [prelude, `dofile(${JSON.stringify(path.join(ROOT, 'tools', 'preview', 'stub.lua'))})`];
	before.push(clientUiArtLua());
	if (panel.eui) before.push('stub.withEllesmere()');
	if (panel.before) before.push(panel.before);
	if (panel.codex) before.push(codexStub());
	if (panel.dungeons) before.push(dungeonsStub());
	if (panel.rares) before.push(raresStub());
	const { emitted } = runAddon({
		stubs: panel.stubs || ['stub_ui.lua'],
		before: before.join('\n'),
		addons: [{ name: 'Polestar', files: panel.files || FILES }],
		script: `${panel.stubs ? '' : 'uistub.install()\n'}stub.login()\n${panel.script}\nstub.advance(1)\npreview.emit()`,
	});
	const dump = emitted[emitted.length - 1];
	if (!dump || !dump.objects) throw new Error('preview: the scene emitted no frames');
	return dump;
}

// The scenes' temporary Codex, Dungeons and Rares packs, removed after a
// scene's panels are dumped.
function cleanupPacks() {
	if (codexPack) codexPack.cleanup();
	codexPack = null;
	if (dungeonsPack) dungeonsPack.cleanup();
	dungeonsPack = null;
	if (raresPack) raresPack.cleanup();
	raresPack = null;
}

async function run(argv) {
	const only = new Set(argv.filter((a) => !a.startsWith('-')));
	// docs/preview holds renders of the checkout alone: local inputs render
	// into POLESTAR_CLIENT_ART's folder or not at all.
	const local = ['POLESTAR_DUNGEONS_PACK', 'POLESTAR_ADDON_DIR'].filter((k) => process.env[k]);
	if (local.length && !CLIENT_ART) {
		console.error(`preview: ${local.join(' and ')} would put local data in docs/preview; unset it, or set POLESTAR_CLIENT_ART to render into its folder`);
		return 2;
	}
	const fonts = loadFonts();
	const textures = new TextureCache(path.join(ADDON, 'Media', 'UI'), CLIENT_ART);
	const prelude = metricsLua(fonts);
	const outDir = CLIENT_ART ? path.join(CLIENT_ART, 'preview') : OUT;
	fs.mkdirSync(outDir, { recursive: true });
	const written = [];
	for (const scene of SCENES) {
		if (only.size && !only.has(scene.file) && !only.has(scene.file.replace(/\.svg$/, ''))) continue;
		if (scene.local && !CLIENT_ART) continue;
		const shared = { glyphs: new Set(), defs: [] };
		let panels;
		try {
			panels = scene.panels.map((p, i) => svg(dumpPanel(p, prelude), { fonts, textures, roots: p.roots, prefix: `p${i}`, shared }));
		} finally {
			cleanupPacks();
		}
		const file = path.join(outDir, scene.file);
		fs.writeFileSync(file, `${PREVIEW_HEADER}\n${compose(panels, { title: scene.title, shared, backdrop: scene.backdrop })}`);
		written.push(file);
		console.log(path.relative(ROOT, file));
	}
	if (!written.length) {
		console.error(`no preview scene named ${[...only].join(', ')}`);
		return 2;
	}
	// A full run leaves exactly the scenes' renders in the folder.
	if (!only.size) {
		const scenes = new Set(SCENES.map((s) => s.file));
		for (const f of fs.readdirSync(outDir)) {
			if (f.endsWith('.svg') && !scenes.has(f)) {
				fs.rmSync(path.join(outDir, f));
				console.log(`removed ${path.relative(ROOT, path.join(outDir, f))}`);
			}
		}
	}
	return 0;
}

module.exports = {
	name: 'preview',
	summary: 'Render the guide window, picker and options to docs/preview/*.svg',
	usage: [
		'usage: node tools/polestar.js preview [scene ...]',
		'',
		'Runs the real Theme and UI Lua against a geometry-recording client stub',
		'with sample guides and writes SVGs to docs/preview/. Scenes:',
		...SCENES.map((s) => `  ${s.file.replace(/\.svg$/, '').padEnd(16)} ${s.title}`),
	].join('\n'),
	run,
	SCENES,
	// For tests/text-fit.test.js: the scenes' dumps without drawing them.
	FILES,
	MODULE_FILES,
	loadFonts,
	metricsLua,
	dumpPanel,
	cleanupPacks,
};
