'use strict';
// English on a non-English client (`i18n leaks`, docs/TRANSLATING.md,
// "English left on screen"). The addon runs under Lua 5.1 on the client stub
// (tests/lua) in each locale, with its shipped translations, names pack and
// guide texts, and leaks.lua making every name the client itself gives a
// placeholder with no word in it. Scenes drive the windows: the guide window
// step by step, the picker, Options, Lookup, Dungeons, Rares, talents,
// tooltips, the slash commands. Every text the addons put up (font strings,
// buttons, tooltips, chat, popups, menus) is recorded; a Latin word of three
// or more letters that is not one of the locale's own words (those of its
// translations, names pack and guide texts) nor on the allow list
// (leaks-allow.json) is English left on screen.
//
//   const { findLeaks, SCENES } = require('./leaks');
//   const runs = await findLeaks(['ruRU'], ['options', 'guide']);
//   // -> [{ locale, scene, leaks: [{ text, words, kind, site, scenes, source }], errors, texts, skipped }]
//
// Each locale and scene runs in a process of its own (node leaks.js
// <locale> <scene> [<guide id>...]), as many at a time as there are cores.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { ROOT } = require('../paths');
const { LOCALE_CODES } = require('./locales');

const ADDON = path.join(ROOT, 'addon');
const DATA = path.join(ROOT, 'data', 'forever');
const ALLOW_FILE = path.join(__dirname, 'leaks-allow.json');
const BASELINE_FILE = path.join(__dirname, 'leaks-baseline.json');
const DETECTOR = path.join(__dirname, 'leaks.lua');

const S = (s) => JSON.stringify(s);
const luaList = (a) => `{ ${a.map(S).join(', ')} }`;

// The data packs built on the developer's machine (not in a clone).
const built = (name) => fs.existsSync(path.join(ADDON, name, `${name}.toc`));
// The Codex and the quest database are built (a developer's machine, not CI).
const fullData = () => built('Polestar_Codex') && built('Polestar_QuestDB');
const NEEDS = {
	codex: () => (built('Polestar_Codex') ? false : 'addon/Polestar_Codex is not built (node tools/polestar.js codex build)'),
	questdb: () => (built('Polestar_QuestDB') ? false : 'addon/Polestar_QuestDB is not built (node tools/polestar.js questdb build)'),
};

function guideIds() {
	const text = fs.readFileSync(path.join(ADDON, 'Polestar_Guides', 'Guides.lua'), 'utf8');
	return [...new Set([...text.matchAll(/^\t\t\tid = "([^"]+)"/gm)].map((m) => m[1]))];
}

// The guides the `guide` scene shows by default: a starting zone (names as
// tokens in every text), a zone with collect goals, a profession guide.
const GUIDES = ['forever/alliance/human/01-elwynn-forest', 'forever/alliance/02-westfall', 'forever/professions/first-aid'];

// The stub world: every map the guides know (their MapFrames.lua), the player
// in Northshire, the Recorder present.
function worldLua() {
	const text = fs.readFileSync(path.join(ADDON, 'Polestar_Guides', 'MapFrames.lua'), 'utf8');
	let zones = {};
	try { zones = JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')); } catch { /* a clone: no parents */ }
	const maps = new Map();
	for (const m of text.matchAll(/\[(\d+)\] = \{ c = (-?\d+), left = (-?[\d.]+), right = (-?[\d.]+), top = (-?[\d.]+), bottom = (-?[\d.]+) \}/g)) {
		if (maps.has(m[1])) continue;
		const z = zones[m[1]] || {};
		maps.set(m[1], `w.addMap(${m[1]}, { name = ${S(z.name || `Map ${m[1]}`)}, c = ${m[2]}, left = ${m[3]}, right = ${m[4]}, top = ${m[5]}, bottom = ${m[6]}, parent = ${z.parent || 0}, mapType = ${z.type || 3} })`);
	}
	return `local w = stub.world
${[...maps.values()].join('\n')}
w.moveTo(1429, 48.5, 42.5)
w.zone, w.subzone = "Elwynn Forest", "Northshire Valley"
OpenWorldMap = OpenWorldMap or function() end
QuestDifficultyColors = { impossible = { r = 1, g = 0.1, b = 0.1 }, verydifficult = { r = 1, g = 0.5, b = 0.25 }, difficult = { r = 1, g = 0.82, b = 0 }, standard = { r = 0.25, g = 0.75, b = 0.25 }, trivial = { r = 0.5, g = 0.5, b = 0.5 } }
function GetQuestDifficultyColor() return { r = 1, g = 1, b = 0 } end
stub.addonsLoaded.Polestar_Recorder = true
PolestarRecorderDB = { enabled = true, current = "s2", sessions = { s1 = { char = { name = "⟦p⟧" }, events = {} }, s2 = { char = { name = "⟦p⟧" }, events = { {}, {}, {} } } } }`;
}

// The guide window on `ids`, every step shown and its frames hovered.
function guideScript(ids, { hover = true } = {}) {
	return `
local E = Polestar.Engine
for _, id in ipairs(${luaList(ids)}) do
	leaks.try(id, function()
		E.SetGuide(id)
		stub.advance(0.3)
		if PolestarGuideFrame then PolestarGuideFrame:Show() end
		for i = 1, E.GetStepCount() do
			leaks.scene(id .. " step " .. i)
			E.Goto(i)
			stub.advance(0.2)
			${hover ? 'leaks.hover("PolestarGuideFrame")' : ''}
		end
	end)
end`;
}

// Each scene: { about, needs?, stubs?, saved?, addons?, script(guides) }.
const SCENES = {
	guide: {
		about: 'the guide window on a few guides (every step, whatever class, race or faction it is for; every tooltip); --guide names others',
		everyStep: true,
		script: (ids) => guideScript(ids && ids.length ? ids : GUIDES),
	},
	guides: {
		about: 'the guide window on every guide, every step whatever class, race or faction it is for (no tooltips; slow)',
		everyStep: true,
		script: () => guideScript(guideIds(), { hover: false }),
	},
	welcome: {
		about: 'the welcome and setup windows, route choices, the report and Discord windows',
		script: () => `
leaks.try("welcome", function() Polestar.UI.Welcome.Show("welcome"); stub.advance(0.5); leaks.hover() end)
leaks.try("setup", function() Polestar.UI.Welcome.Show("setup"); stub.advance(0.5); leaks.hover() end)
leaks.try("route choice", function()
	for _, id in ipairs(${luaList(guideIds())}) do
		if Polestar.Engine.GetRouteChoice(id) then leaks.scene("route choice " .. id); Polestar.UI.ShowRouteChoice(id); stub.advance(0.3); leaks.hover() end
	end
end)
leaks.try("report", function() Polestar.Engine.SetGuide(${S(GUIDES[0])}); stub.advance(0.3); Polestar.UI.ShowReport(); stub.advance(0.3); leaks.hover() end)
leaks.try("discord", function() Polestar.UI.ShowDiscord(); stub.advance(0.3); leaks.hover() end)`,
	},
	picker: {
		about: 'the guide picker: its sections, categories, views, factions, searches and selections',
		script: () => `
local UI, P = Polestar.UI, Polestar.UI.Picker
leaks.try("picker", function()
	UI.ShowPicker(); stub.advance(0.5); leaks.hover()
	for _, s in ipairs(P.Sections()) do leaks.try("picker section " .. tostring(s.key), function() P.ShowSection(s.key); stub.advance(0.3); leaks.hover() end) end
	P.ShowSection(P.Sections()[1].key)
	for _, c in ipairs({ "Leveling", "Professions", "Reputation", "Class", "Dungeons", "Collectibles", "Events", "Mounts", "Pets" }) do
		leaks.try("picker category " .. c, function() P.SetCategory(c); stub.advance(0.2); leaks.hover() end)
	end
	for _, v in ipairs({ "list", "cards", "map", "grid" }) do leaks.try("picker view " .. v, function() P.SetView(v); stub.advance(0.2); leaks.hover() end) end
	for _, f in ipairs({ "Horde", "Alliance" }) do leaks.try("picker faction " .. f, function() Polestar.Set("ui.pickerFaction", f); UI.ShowPicker(); stub.advance(0.2); leaks.hover() end) end
	for _, q in ipairs({ "westfall", "hogger", "linen", "deadmines", "saber", "zzzz" }) do leaks.try("picker search " .. q, function() leaks.typed(q); P.SetQuery(q); stub.advance(0.3); leaks.hover() end) end
	for _, id in ipairs(${luaList(guideIds().filter((_, i) => i % 7 === 0))}) do leaks.try("picker select " .. id, function() P.SetQuery(""); P.Select(id); stub.advance(0.2); leaks.hover() end) end
end)`,
	},
	options: {
		about: 'Options: every page and tab',
		script: () => `
leaks.try("options", function()
	Polestar.UI.ShowOptions(); stub.advance(0.3)
	for _, p in ipairs(Polestar.UI.Options.Pages()) do
		local tabs = (type(p.tabs) == "table" and #p.tabs > 0) and p.tabs or { false }
		for _, t in ipairs(tabs) do
			leaks.try("options " .. p.key .. (t and (" > " .. t) or ""), function()
				Polestar.UI.ShowOptions(p.key)
				if t then Polestar.UI.Options.Select(p.key, t) end
				stub.advance(0.3)
				leaks.hover()
			end)
		end
	end
end)`,
	},
	lookup: {
		about: 'Lookup: searches, their results and sources, and things looked up by id',
		needs: ['codex', 'questdb'],
		before: 'stub.world.level = 60',
		script: () => `
local LK = Polestar.UI.Lookup
leaks.try("lookup", function()
	Polestar.UI.ShowLookup(); stub.advance(0.5); leaks.hover()
	for _, q in ipairs({ "saber", "westfall", "hogger", "linen cloth", "deadmines", "tabard", "recipe", "pet", "argent", "stormwind", "kobold", "mooncloth", "riding" }) do
		leaks.try("lookup " .. q, function()
			leaks.typed(q); Polestar.Lookup.Show(q); stub.advance(0.5); leaks.hover()
			for i = 1, 3 do
				leaks.try("lookup " .. q .. " result " .. i, function()
					if LK.SelectRow then LK.SelectRow(i) end
					stub.advance(0.2)
					if LK.SelectSource then for s = 1, 3 do pcall(LK.SelectSource, s) end end
					leaks.hover()
				end)
			end
		end)
	end
	for _, pair in ipairs({ { "mount", 13086 }, { "mount", 8631 }, { "npc", 448 }, { "item", 2589 }, { "item", 19019 }, { "quest", 176 }, { "zone", 1429 }, { "pet", 8485 }, { "tabard", 5976 }, { "recipe", 2553 }, { "npc", 61 } }) do
		leaks.try("lookup " .. pair[1] .. " " .. pair[2], function()
			Polestar.Lookup.Show(nil, pair[1], pair[2]); stub.advance(0.5)
			if LK.SelectSource then for s = 1, 4 do pcall(LK.SelectSource, s); stub.advance(0.1) end end
			leaks.hover()
		end)
	end
end)`,
	},
	dungeons: {
		about: 'Dungeons: the list by faction, every dungeon on every tab',
		needs: ['codex'],
		before: 'stub.world.level = 20',
		script: () => `
leaks.try("dungeons", function()
	Polestar.UI.ShowPicker()
	Polestar.Dungeons.Open(); stub.advance(0.5); leaks.hover()
	local DS = Polestar.UI.DungeonsSection
	for _, f in ipairs({ "All", "Horde", "Alliance" }) do leaks.try("dungeons " .. f, function() DS.SetFaction(f); DS.SetBand("all"); stub.advance(0.2); leaks.hover() end) end
	local keys = {}
	for _, d in ipairs(Polestar.Dungeons.List and Polestar.Dungeons.List() or {}) do keys[#keys + 1] = type(d) == "table" and d.key or d end
	for _, k in ipairs(keys) do
		leaks.try("dungeon " .. k, function()
			Polestar.Dungeons.Open(k); stub.advance(0.3); leaks.hover()
			for _, t in ipairs({ "quests", "bosses", "map", "attune", "loot", "overview" }) do leaks.try("dungeon " .. k .. " " .. t, function() DS.SetTab(t); stub.advance(0.2); leaks.hover() end) end
		end)
	end
end)`,
	},
	rares: {
		about: 'Rares: its tabs, a rare and a treasure, the spotted toast',
		needs: ['codex'],
		before: 'stub.world.level = 10',
		script: () => `
leaks.try("rares", function()
	local R = Polestar.Rares
	if Polestar.Codex and Polestar.Codex.Load then Polestar.Codex.Load() end
	local now = GetServerTime()
	R.Record({ kind = "rare", id = 61, name = leaks.P("v", 61), level = 11, source = "vignette" }, { map = 1429, x = 89.2, y = 79.1 }, now - 7200, true)
	R.Record({ kind = "treasure", id = 2843, name = leaks.P("v", 2843), source = "vignette" }, { map = 1429, x = 79.6, y = 55.7 }, now - 3 * 86400, false)
	R.Show(); stub.advance(0.5); leaks.hover()
	for _, t in ipairs({ "zone", "seen", "all", "treasures", "rares", "map" }) do leaks.try("rares tab " .. t, function() Polestar.UI.RaresSection.SetTab(t); stub.advance(0.2); leaks.hover() end) end
	leaks.try("rare 61", function() R.Show("rare", 61); stub.advance(0.3); leaks.hover() end)
	leaks.try("rare 471", function() R.Show("rare", 471); stub.advance(0.3); leaks.hover() end)
	leaks.try("rare toast", function()
		local a = R.AlertOf({ source = "vignette", kind = "rare", id = 61, name = leaks.P("v", 61), level = 11 }, { map = 1429, x = 89.2, y = 79.1 }, true); a.yards = 87
		Polestar.Fire("RARE_SPOTTED", a); stub.advance(1); leaks.hover()
		Polestar.Fire("RARE_SPOTTED", R.AlertOf({ source = "vignette", kind = "treasure", id = 2843, name = leaks.P("v", 2843) }, { map = 1429, x = 79.6, y = 55.7 }, true)); stub.advance(1); leaks.hover()
	end)
	leaks.try("rares sample", function() R.ShowSample(); stub.advance(1) end)
end)`,
	},
	talents: {
		about: 'Talents: every class with its builds, and the talent frame',
		stubs: ['stub_talents.lua'],
		script: () => `
leaks.try("talents", function()
	local T, TS = Polestar.Talents, stub.talents
	for _, cls in ipairs({ "PALADIN", "WARRIOR", "MAGE", "HUNTER", "ROGUE", "PRIEST", "WARLOCK", "DRUID", "SHAMAN" }) do
		local data = T.Data(cls)
		if data then
			leaks.try("talents " .. cls, function()
				TS.class, TS.className = cls, leaks.P("c", cls)
				TS.useSnapshot(data)
				for id, n in pairs(TS.nodes) do n.name = leaks.P("t", id) end
				if data.builds and data.builds[1] then TS.learn(data.builds[1], 5) end
				T.Refresh()
				Polestar.UI.ShowPicker(); T.Show(); stub.advance(0.5); leaks.hover()
				local TV = Polestar.UI.TalentsView
				if TV and TV.SetTab then for i = 1, 4 do leaks.try("talents " .. cls .. " tab " .. i, function() TV.SetTab(tostring(i)); stub.advance(0.2); leaks.hover() end) end end
				if TS.openFrame then TS.openFrame(); stub.advance(0.5); leaks.hover() end
			end)
		end
	end
end)`,
	},
	journey: {
		about: 'the journey planner and its route to a few far places',
		nav: true,
		saved: { Polestar: 'PolestarDB = { schema = 1, settings = { nav = { journeySteps = true, journeyOpen = true, distanceUnit = "yards" } } }' },
		script: () => `
leaks.try("journey", function()
	local N = Polestar.Nav
	Polestar.Engine.SetGuide(${S(GUIDES[0])}); stub.advance(0.5)
	for _, t in ipairs({ { 1453, 60, 70, "Stormwind" }, { 1457, 40, 50, "Darnassus" }, { 1437, 10, 60, "Menethil" }, { 1454, 50, 50, "Orgrimmar" }, { 1413, 52, 30, "Crossroads" }, { 1446, 50, 30, "Tanaris" } }) do
		leaks.try("journey to " .. t[4], function()
			if Polestar.Journey and Polestar.Journey.PlanTo then Polestar.Journey.PlanTo(t[1], t[2], t[3], nil, "e") else N.SetTarget(t[1], t[2], t[3], nil, "e") end
			stub.advance(5.5)
			leaks.hover()
		end)
	end
	leaks.try("/polestar route", function() SlashCmdList.POLESTAR("route") end)
end)`,
	},
	tooltips: {
		about: "Polestar's lines in the game's unit, object and item tooltips",
		needs: ['codex', 'questdb'],
		before: 'stub.world.level = 60',
		script: () => `
leaks.try("tooltips", function()
	local H = Polestar.Hooks
	local guid
	local oGUID = UnitGUID
	UnitGUID = function(u) if u == "mouseover" then return guid end return oGUID(u) end
	UnitExists = function(u) return u == "mouseover" or u == "player" end
	UnitIsPlayer = function(u) return u == "player" end
	GameTooltip.GetUnit = function() return "x", "mouseover" end
	for _, npc in ipairs({ 448, 197, 6, 61, 299, 1501, 3100, 11946, 1747, 4730, 384, 352, 2409, 10181, 7999, 3057, 1222 }) do
		leaks.try("unit tooltip " .. npc, function()
			guid = "Creature-0-1-0-1-" .. npc .. "-0000ABCD"
			GameTooltip:SetOwner(UIParent); GameTooltip:AddLine(leaks.P("u", npc))
			H.OnUnitTooltip(GameTooltip, { guid = guid })
		end)
	end
	for _, obj in ipairs({ 2843, 1731, 3640, 1617, 2041, 103711 }) do
		leaks.try("object tooltip " .. obj, function()
			GameTooltip:SetOwner(UIParent)
			H.OnObjectTooltip(GameTooltip, { id = obj, lines = { { leftText = leaks.P("o", obj) } } })
		end)
	end
	for _, item in ipairs({ 13086, 8631, 2589, 750, 1179, 19019, 18803, 5976, 2553, 4306, 14047, 2318, 12302, 1933, 2933, 7005, 6948, 5175, 2770, 3576, 2840, 12359, 20725, 4338 }) do
		leaks.try("item tooltip " .. item, function()
			GameTooltip:SetOwner(UIParent)
			GameTooltip.GetItem = function() return "x", "|cffffffff|Hitem:" .. item .. "::::::::60:::::|h[x]|h|r" end
			H.OnItemTooltip(GameTooltip, { id = item })
		end)
	end
end)`,
	},
	slash: {
		about: 'every /polestar command and its help, and the other slash commands',
		script: () => `
leaks.try("slash", function()
	Polestar.Engine.SetGuide(${S(GUIDES[0])}); stub.advance(0.5)
	local S = SlashCmdList.POLESTAR
	for _, c in ipairs({ "", "help", "status", "where", "tabs", "tab 9", "path", "route", "xp", "questdb", "near", "near trainer", "near bogus", "near innkeeper", "near flight", "gear", "gear help", "gear bogus",
		"instances", "instances help", "arrow", "arrow help", "way", "way 1 2", "way bogus", "way Westfall 50 50 Sentinel", "dungeons", "dungeons bogus", "lookup", "lookup hogger", "mount", "rares", "rares help", "rares bogus", "talents",
		"guide", "guide bogus", "guide forever/alliance/02-westfall", "skipleg", "unknowncommand", "debug", "debug", "show", "hide", "next", "prev", "skip", "close", "welcome", "report", "discord", "packs", "options", "guides", "reset" }) do
		leaks.try("/polestar " .. c, function() leaks.typed(c); S(c); stub.advance(0.2) end)
	end
	for k, fn in pairs(SlashCmdList) do if k ~= "POLESTAR" then leaks.try("/" .. k:lower(), function() fn(""); fn("help") end) end end
end)`,
	},
	more: {
		about: 'quest tooltips, the nearby menu, alerts, the arrow, the world map, XP and instance windows',
		nav: true,
		before: 'stub.world.level = 5',
		script: () => `
leaks.try("more", function()
	local w = stub.world
	Polestar.Set("qol.questTooltips", true)
	Polestar.Engine.SetGuide(${S(GUIDES[0])}); stub.advance(0.5)
	w.accept(7, { 10 }); w.accept(33, { 8 }); w.accept(15, { 1 }); stub.advance(1)
	stub.fire("QUEST_LOG_UPDATE"); stub.advance(1)
	local H = Polestar.Hooks
	local guid
	UnitGUID = (function(o) return function(u) if u == "mouseover" then return guid end return o(u) end end)(UnitGUID)
	GameTooltip.GetUnit = function() return "x", "mouseover" end
	for _, npc in ipairs({ 6, 257, 299, 80, 197, 196 }) do
		leaks.try("quest tooltip unit " .. npc, function() guid = "Creature-0-1-0-1-" .. npc .. "-0000ABCD"; GameTooltip:SetOwner(UIParent); H.OnUnitTooltip(GameTooltip, { guid = guid }) end)
	end
	for _, item in ipairs({ 750, 752, 1307 }) do
		leaks.try("quest tooltip item " .. item, function() GameTooltip:SetOwner(UIParent); GameTooltip.GetItem = function() return "x", "item:" .. item end; H.OnItemTooltip(GameTooltip, { id = item }) end)
	end
	leaks.try("nearby menu", function() Polestar.Set("nav.nearbyMenu", true); Polestar.Nav.nearby.AddMenu(nil, leaks.menu()) end)
	leaks.try("alerts", function() if Polestar.Nav.alerts then Polestar.Nav.alerts.ShowSample(); stub.advance(2) end end)
	leaks.try("arrow", function() leaks.hover() end)
	leaks.try("prompts", function() local P = Polestar.Nav.prompts; for _, it in ipairs(P and P.MenuItems and P.MenuItems() or {}) do leaks.rec("menu", it.text); leaks.rec("menu", it.tip) end end)
	leaks.try("world map", function()
		for _, m in ipairs({ 1415, 1429, 1436, 1414, 947 }) do
			leaks.scene("world map " .. m)
			stub.worldMapID = m; WorldMapFrame:Show()
			for p in pairs(WorldMapFrame.dataProviders or {}) do if p.RefreshAllData then pcall(p.RefreshAllData, p) end end
			stub.advance(0.5); leaks.hover(); WorldMapFrame:Hide()
		end
	end)
	leaks.try("/polestar xp", function() SlashCmdList.POLESTAR("xp"); stub.advance(1); leaks.hover() end)
	leaks.try("/polestar instances", function() SlashCmdList.POLESTAR("instances"); stub.advance(1); leaks.hover() end)
end)`,
	},
	recorder: {
		about: 'Polestar Recorder: its slash commands',
		stubs: ['stub_recorder.lua'],
		addons: ['Polestar_Recorder'],
		recorder: true,
		script: () => `
leaks.try("recorder", function()
	for _, c in ipairs({ "", "help", "status", "on", "off", "new", "list", "note test", "mark", "finds", "progress", "route", "clear", "bogus" }) do
		leaks.try("/psrec " .. c, function() leaks.typed(c); SlashCmdList.POLESTARREC(c); stub.advance(0.2) end)
	end
	leaks.hover()
end)`,
	},
};

// The test's scenes and npm test's subset.
const SCENE_NAMES = Object.keys(SCENES);

// --- allow list ---------------------------------------------------------------

const escapeRe = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

// The /polestar commands the addon registers (ns.RegisterCommand("name", ...)).
function commandWords() {
	const out = new Set();
	const walk = (dir) => {
		for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
			const p = path.join(dir, e.name);
			if (e.isDirectory()) { if (e.name !== 'Locales') walk(p); } else if (e.name.endsWith('.lua')) {
				for (const m of fs.readFileSync(p, 'utf8').matchAll(/RegisterCommand\("([a-z]+)"/g)) out.add(m[1]);
			}
		}
	};
	walk(path.join(ADDON, 'Polestar'));
	return out;
}

// -> { all: RegExp[], locale: { [code]: RegExp[] } }: what is cut out of a
// text before its words are looked at.
function loadAllow(file = ALLOW_FILE) {
	const raw = JSON.parse(fs.readFileSync(file, 'utf8'));
	// Whole words of Latin letters: a Korean particle may follow ("Codex가").
	const word = (s) => new RegExp(`(?<![A-Za-z0-9])${escapeRe(s)}(?![A-Za-z0-9])`, 'gu');
	// The longest first: "Polestar Recorder" before "Polestar".
	const list = (...lists) => lists.flat().filter(Boolean).sort((a, b) => b.length - a.length).map(word);
	// {ARGS}: the words a slash command takes (every registered command, slashArguments).
	const args = [...new Set([...commandWords(), ...(raw.slashArguments || [])])].sort((a, b) => b.length - a.length).map(escapeRe).join('|');
	const cmds = [...commandWords()].sort((a, b) => b.length - a.length).map(escapeRe).join('|');
	const pattern = (p) => new RegExp(p.replace(/\{ARGS\}/g, `(?:${args})(?![\\p{L}\\p{N}])`).replace(/\{COMMANDS\}/g, `(?:${cmds})`), 'gu');
	const all = [...Object.values(raw.patterns || {}).map(pattern), ...list(raw.products, raw.terms)];
	const locale = {};
	for (const [code, entries] of Object.entries(raw.locales || {})) {
		if (!LOCALE_CODES.includes(code)) throw new Error(`${path.relative(ROOT, file)}: unknown locale "${code}"`);
		locale[code] = list(entries);
	}
	return { all, locale };
}

// The words of `plain` the allow list leaves, among `flagged` (the Lua
// side's: not one of the locale's own words).
function leakWords(plain, flagged, allow, locale) {
	let s = plain;
	for (const re of [...allow.all, ...(allow.locale[locale] || [])]) s = s.replace(re, ' ');
	const want = new Set(flagged.map((w) => w.toLowerCase()));
	const out = [];
	for (const w of s.match(/[\p{L}\p{M}]+/gu) || []) {
		if (/^[A-Za-z]{3,}$/.test(w) && want.has(w.toLowerCase()) && !out.includes(w)) out.push(w);
	}
	return out;
}

// --- one run ------------------------------------------------------------------

// The installed addons (stub.addons: the install check finds them) and the
// load-on-demand packs C_AddOns.LoadAddOn loads (stub.packs).
function packsLua(locale, scene) {
	if (scene.recorder) return '';
	const { dirFiles } = require('../../../tests/helpers/lua');
	const packs = {};
	// The walking map (Polestar_Nav) plans paths in the background, seconds
	// of Lua each step: only the scenes about travel load it.
	for (const name of ['Polestar_QuestDB', 'Polestar_Codex', 'Polestar_ItemDB', ...(scene.nav ? ['Polestar_Nav'] : []), `Polestar_Names_${locale}`, `Polestar_Guides_${locale}`]) {
		if (built(name)) packs[name] = dirFiles(path.join(ADDON, name));
	}
	const installed = ['Polestar', 'Polestar_Guides', ...Object.keys(packs)];
	return [
		`stub.addons = { ${installed.map((n) => `{ name = ${S(n)} }`).join(', ')} }`,
		...Object.entries(packs).map(([k, files]) => `stub.packs[${S(k)}] = ${luaList(files)}`),
	].join('\n');
}

// The allow list's products and terms and the slash commands' arguments,
// for the Lua side: text it cuts before it learns a translation's words.
function allowLua() {
	const raw = JSON.parse(fs.readFileSync(ALLOW_FILE, 'utf8'));
	const products = [...(raw.products || []), ...(raw.terms || [])].sort((a, b) => b.length - a.length);
	const args = [...new Set([...commandWords(), ...(raw.slashArguments || [])])];
	const allowWords = [...new Set(products.flatMap((p) => p.toLowerCase().match(/[a-z]{3,}/g) || []))];
	return `products = ${luaList(products)}, slashArgs = { ${args.map((a) => `[${S(a)}] = true`).join(', ')} }, allowWords = { ${allowWords.map((w) => `[${S(w)}] = true`).join(', ')} }`;
}

// One locale, one scene -> { texts, candidates, errors, missedNames } (and
// `all`, every text, with { all: true }).
function runScene(locale, name, guides = [], opts = {}) {
	const { runAddon } = require('../../../tests/helpers/lua');
	const scene = SCENES[name];
	const before = [
		`LEAKS = { locale = ${S(locale)}, all = ${opts.all ? 'true' : 'false'}, everyStep = ${scene.everyStep ? 'true' : 'false'}, ${allowLua()} }`,
		'stub.packs = stub.packs or {}',
		packsLua(locale, scene),
		scene.recorder ? '' : worldLua(),
		scene.before || '',
		`dofile(${S(DETECTOR)})`,
	].join('\n');
	const r = runAddon({
		stubs: [...(scene.recorder ? [] : ['stub_world.lua', 'stub_encoding.lua', 'stub_packs.lua']), ...(scene.stubs || [])],
		before,
		addons: scene.addons || ['Polestar', 'Polestar_Guides'],
		saved: scene.saved,
		script: `leaks.hookPolestar()\nleaks.scene("login")\nstub.login()\nstub.advance(1)\n${scene.script(guides)}\nleaks.dump()`,
	});
	const dump = r.emitted.find((x) => x && x.leaks);
	if (!dump) throw new Error(`${locale} ${name}: the scene emitted nothing`);
	return dump;
}

// The English names of the reference data, when it is built (each file read
// once): kind -> { id -> name }.
const dataCache = {};
function dataTable(kind) {
	if (!(kind in dataCache)) {
		const f = path.join(DATA, DATA_FILES[kind]);
		const names = {};
		const doc = fs.existsSync(f) ? JSON.parse(fs.readFileSync(f, 'utf8')) : {};
		if (kind === 'encounter') {
			// Dungeon encounters: the bosses of codex/instances.json.
			for (const inst of Object.values(doc)) for (const b of (inst && inst.bosses) || []) if (b.encounter && b.name) names[b.encounter] = b.name;
		} else {
			for (const [id, v] of Object.entries(doc)) if (v && (v.name || v.title)) names[id] = v.name || v.title;
		}
		dataCache[kind] = names;
	}
	return dataCache[kind];
}
const DATA_FILES = { npc: 'npcs.json', object: 'objects.json', item: 'items.json', quest: 'quests.json', encounter: 'codex/instances.json' };

// The English the reference data gives the missed names: { "kind:id": name }.
function dataNames(keys) {
	const out = {};
	for (const k of keys) {
		const [kind, id] = k.split(':');
		if (!DATA_FILES[kind]) continue;
		const name = dataTable(kind)[id];
		if (typeof name === 'string' && /[A-Za-z]{3}/.test(name)) out[k] = name;
	}
	return out;
}

// English name -> "kind:id" over the whole reference data (built once).
let nameIndex = null;
function dataNameIndex() {
	if (!nameIndex) {
		nameIndex = new Map();
		for (const kind of Object.keys(DATA_FILES)) {
			for (const [id, name] of Object.entries(dataTable(kind))) if (/[A-Za-z]{3}/.test(name) && !nameIndex.has(name)) nameIndex.set(name, `${kind}:${id}`);
		}
	}
	return nameIndex;
}

// The longest run of words in `plain` that is a name of the reference data.
function nameIn(plain) {
	const index = dataNameIndex();
	if (!index.size) return null;
	const words = plain.split(/[\s()«»"“”·:;,]+/).filter(Boolean);
	let best = null;
	for (let i = 0; i < words.length; i++) {
		for (let j = Math.min(words.length, i + 8); j > i; j--) {
			const s = words.slice(i, j).join(' ').replace(/[.!?]+$/, '');
			if ((!best || s.length > best.english.length) && index.has(s)) { best = { name: index.get(s), english: s }; break; }
		}
	}
	return best;
}

// The Lua side's JSON writes an empty list as {}.
const list = (v) => (Array.isArray(v) ? v : []);

// Where a leak's English came from: the Lua side's best source (the one whose
// English it holds the most of), a name the reference data gives a missed
// id if longer, a name of the reference data the text holds; else the line
// that set it.
function sourceOf(c, names, classify, missed) {
	let best = c.from && c.from.match ? c.from : null;
	for (const [key, en] of Object.entries(names)) {
		if ((!best || en.length > best.match.length) && c.plain.includes(en)) best = { kind: 'name', name: key, english: en, match: en };
	}
	if (!best && classify) {
		const n = nameIn(c.plain);
		if (n) best = { kind: missed.has(n.name) ? 'name' : 'unasked', ...n, match: n.english };
	}
	const where = list(c.site)[0] || '?';
	// English a translation keeps (names it writes as in English), unless an
	// untranslated string or guide text explains it.
	if (c.kept && !(best && (best.kind === 'interface' || best.kind === 'guide'))) return { kind: 'kept', english: c.kept, where };
	if (best && best.kind === 'interface') return { kind: 'interface', key: best.key, addon: best.addon, where: list(best.sites)[0] || where };
	if (best && best.kind === 'guide') return { kind: 'guide', guide: best.guide, english: best.english, where };
	if (best && (best.kind === 'name' || best.kind === 'unasked')) return { kind: best.kind, name: best.name, english: best.english, where };
	return { kind: 'code', where };
}

// --- baseline -----------------------------------------------------------------

// Names no source has in a language (leaks-baseline.json): { reasons, entries:
// { [locale]: { ["kind:id"]: { reason, scenes } } } }. A text whose English
// is only such names is no leak; an entry whose scenes all ran in its locale
// without it showing is stale (the file only shrinks).
function loadBaseline(file = BASELINE_FILE) {
	if (!fs.existsSync(file)) return { reasons: {}, entries: {} };
	const raw = JSON.parse(fs.readFileSync(file, 'utf8'));
	for (const code of Object.keys(raw.entries || {})) if (!LOCALE_CODES.includes(code)) throw new Error(`${path.relative(ROOT, file)}: unknown locale "${code}"`);
	return { about: raw.about, reasons: raw.reasons || {}, entries: raw.entries || {} };
}

const cutAll = (s, en) => s.split(en).join(' ');

// One run's leaks: its candidates less what the allow list allows and the
// baseline's names, each with its source (`classify`: also by the reference
// data's names, when built). -> { locale, scene, texts, leaks, errors,
// baselined: ["kind:id" the baseline let through] }
function checkRun(locale, name, dump, allow = loadAllow(), { classify = true, baseline = loadBaseline() } = {}) {
	const missed = new Set(list(dump.missedNames));
	const english = { ...(classify ? dataNames(missed) : {}), ...(dump.missedEnglish || {}) };
	const known = (baseline.entries || {})[locale] || {};
	// A baseline name's English, kept in its entry: without the built data (CI) too.
	for (const [key, e] of Object.entries(known)) if (e.english && !english[key] && !key.startsWith('text:')) english[key] = e.english;
	const used = new Set();
	const leaks = [];
	for (const c of list(dump.candidates)) {
		let words = leakWords(c.plain, list(c.words), allow, locale);
		if (!words.length) continue;
		// The missed names the text holds, the longest first.
		const held = new Map(list(c.names).map((n) => [n.name, n.english]));
		for (const [key, en] of Object.entries(english)) if (!held.has(key) && c.plain.includes(en)) held.set(key, en);
		const names = [...held].sort((a, b) => b[1].length - a[1].length);
		let rest = c.plain, all = c.plain;
		const hit = [];
		for (const [key, en] of names) {
			all = cutAll(all, en);
			if (known[key]) { rest = cutAll(rest, en); hit.push(key); }
		}
		// A baseline name the text holds still shows, leak or not.
		for (const k of hit) used.add(k);
		const keeps = c.keeps && typeof c.keeps === 'object' ? c.keeps : {};
		const allKept = (ws) => ws.length > 0 && ws.every((w) => keeps[w.toLowerCase()]);
		const textKey = `text:${c.plain.replace(/\s+/g, ' ').trim()}`;
		words = leakWords(rest, words, allow, locale);
		if (!words.length) continue;
		// Its English, once the baseline's names are cut, is all words a
		// translation keeps, and the baseline has the text.
		c.kept = allKept(words) ? keeps[words[0].toLowerCase()] : null;
		const source = sourceOf(c, english, classify, missed);
		// (Never an untranslated interface string or guide text.)
		const untranslated = source.kind === 'interface' || source.kind === 'guide';
		if (!untranslated && c.kept && known[textKey]) { used.add(textKey); continue; }
		// What `--update-baseline` may take: the text's missed names, and the
		// text itself when what is left once they are cut is all kept English.
		const left = names.length ? leakWords(all, words, allow, locale) : words;
		const keptText = !untranslated && allKept(left);
		const takes = !untranslated && (left.length === 0 || keptText);
		leaks.push({ text: c.text.replace(/\s+/g, ' ').trim(), words, kind: c.kind, site: list(c.site), scenes: list(c.scenes), source, names: takes ? names.map(([k]) => k) : [], nameEnglish: Object.fromEntries(names), textKey: keptText ? textKey : null });
	}
	return { locale, scene: name, texts: dump.texts, leaks, errors: list(dump.errors), baselined: [...used], fullData: fullData() };
}

// Baseline entries no run let through though every scene they show in ran in
// their locale with the locally built data packs (without the Codex and the
// quest database a scene shows fewer names, so it proves nothing stale):
// [{ locale, key, entry }].
function staleBaseline(results, baseline = loadBaseline()) {
	const ran = new Set(results.filter((r) => !r.skipped && r.fullData).map((r) => `${r.locale}\u0000${r.scene}`));
	const used = new Set(results.flatMap((r) => (r.baselined || []).map((k) => `${r.locale}\u0000${k}`)));
	const out = [];
	for (const [locale, entries] of Object.entries(baseline.entries)) {
		for (const [key, entry] of Object.entries(entries)) {
			const scenes = list(entry.scenes);
			if (scenes.length && scenes.every((s) => ran.has(`${locale}\u0000${s}`)) && !used.has(`${locale}\u0000${key}`)) out.push({ locale, key, entry });
		}
	}
	return out;
}

// The baseline after these runs: stale entries gone, every name-only leak
// (missed names no source has) added with the scenes it showed in.
// A name's reason: "same-as-english" when its every name in the language is
// the English one (`i18n names` writes those ids to SAME_AS_ENGLISH), else
// "no-source".
function baselineReason() {
	const { SAME_AS_ENGLISH } = require('./names');
	const same = fs.existsSync(SAME_AS_ENGLISH) ? JSON.parse(fs.readFileSync(SAME_AS_ENGLISH, 'utf8')) : {};
	const sets = {};
	return (locale, key) => {
		if (key.startsWith('text:')) return 'kept-english';
		const [kind, id] = key.split(':');
		const k = `${locale} ${kind}`;
		if (!sets[k]) sets[k] = new Set(((same[locale] || {})[kind] || []).map(String));
		return sets[k].has(id) ? 'same-as-english' : 'no-source';
	};
}

function updatedBaseline(results, baseline = loadBaseline(), reasonOf = baselineReason()) {
	const entries = JSON.parse(JSON.stringify(baseline.entries));
	for (const s of staleBaseline(results, baseline)) delete entries[s.locale][s.key];
	const add = (locale, key, scene, english) => {
		const e = ((entries[locale] = entries[locale] || {})[key] = entries[locale][key] || { reason: reasonOf(locale, key), scenes: [] });
		e.reason = reasonOf(locale, key);
		if (english) e.english = english;
		if (!e.scenes.includes(scene)) e.scenes.push(scene);
		e.scenes.sort();
	};
	for (const r of results) {
		for (const k of r.baselined || []) add(r.locale, k, r.scene);
		for (const l of r.leaks || []) {
			for (const k of l.names) add(r.locale, k, r.scene, l.nameEnglish && l.nameEnglish[k]);
			if (l.textKey) add(r.locale, l.textKey, r.scene);
		}
	}
	const sorted = {};
	for (const locale of Object.keys(entries).sort()) {
		const keys = Object.keys(entries[locale]).sort((a, b) => a.localeCompare(b, 'en', { numeric: true }));
		if (keys.length) sorted[locale] = Object.fromEntries(keys.map((k) => [k, entries[locale][k]]));
	}
	return { about: baseline.about, reasons: baseline.reasons, entries: sorted };
}

// --- many runs ----------------------------------------------------------------

// Every scene needs the Codex and the quest database (built on the
// developer's machine): without them the addon is an incomplete install, with
// its own warnings, and the baseline's names are not known by their English.
function sceneSkip(name) {
	for (const n of ['codex', 'questdb', ...(SCENES[name].needs || [])]) {
		const why = NEEDS[n]();
		if (why) return why;
	}
	return false;
}

// Every locale with every scene, `jobs` processes at a time (default: the
// cores). -> [{ locale, scene, texts, leaks, errors } | { locale, scene, skipped }]
async function findLeaks(locales, scenes, { guides = [], jobs, onResult } = {}) {
	const { spawn } = require('node:child_process');
	for (const s of scenes) if (!SCENES[s]) throw new Error(`unknown scene "${s}": one of ${SCENE_NAMES.join(', ')}`);
	const allow = loadAllow();
	const baseline = loadBaseline();
	const work = [];
	for (const scene of scenes) for (const locale of locales) work.push({ locale, scene });
	const results = new Array(work.length);
	const limit = Math.max(1, jobs || (os.availableParallelism ? os.availableParallelism() : os.cpus().length));
	let next = 0;
	const one = (i) => new Promise((ok, fail) => {
		const { locale, scene } = work[i];
		const skipped = sceneSkip(scene);
		if (skipped) return ok({ locale, scene, skipped });
		const child = spawn(process.execPath, [__filename, locale, scene, ...guides], { stdio: ['ignore', 'pipe', 'pipe'] });
		let out = '', err = '';
		child.stdout.on('data', (d) => (out += d));
		child.stderr.on('data', (d) => (err += d));
		child.on('close', (code) => {
			if (code !== 0) return fail(new Error(`${locale} ${scene}: ${err.trim() || `exit ${code}`}`));
			ok(checkRun(locale, scene, JSON.parse(out), allow, { baseline }));
		});
	});
	const lane = async () => {
		while (next < work.length) {
			const i = next++;
			results[i] = await one(i);
			if (onResult) onResult(results[i]);
		}
	};
	await Promise.all(Array.from({ length: Math.min(limit, work.length) }, lane));
	return results;
}

function sourceLabel(s) {
	if (s.kind === 'interface') return `interface string not translated (${s.addon}): ${JSON.stringify(s.key)}`;
	if (s.kind === 'guide') return `guide text not translated: ${s.guide}`;
	if (s.kind === 'name') return `name missing from the names pack, shown at ${s.where}`;
	if (s.kind === 'kept') return `English a translation keeps (as in ${JSON.stringify(s.english.length > 60 ? `${s.english.slice(0, 57)}...` : s.english)}), shown at ${s.where}`;
	if (s.kind === 'unasked') return `English name from the guide or data, Polestar.Names not asked, shown at ${s.where}`;
	return `English in the code: ${s.where}`;
}

// Leaks of many runs grouped by where they came from, then by their English
// words: [{ key, source, entries: Map(words -> { locales: Map(locale ->
// example text), scenes: Set, sites: Set }) }], the largest group first.
function groupBySource(results) {
	const groups = new Map();
	for (const r of results) {
		for (const l of r.leaks || []) {
			const key = sourceLabel(l.source);
			if (!groups.has(key)) groups.set(key, { key, source: l.source, entries: new Map() });
			const g = groups.get(key);
			const w = l.words.join(' ');
			if (!g.entries.has(w)) g.entries.set(w, { locales: new Map(), scenes: new Set(), sites: new Set() });
			const e = g.entries.get(w);
			if (!e.locales.has(r.locale)) e.locales.set(r.locale, l.text);
			for (const sc of l.scenes) e.scenes.add(`${r.scene}: ${sc}`);
			if (l.site[0]) e.sites.add(l.site.join(' < '));
		}
	}
	return [...groups.values()].sort((a, b) => b.entries.size - a.entries.size || a.key.localeCompare(b.key));
}

module.exports = { SCENES, SCENE_NAMES, GUIDES, ALLOW_FILE, BASELINE_FILE, loadAllow, loadBaseline, leakWords, runScene, checkRun, staleBaseline, updatedBaseline, findLeaks, groupBySource, guideIds };

// One locale and scene as the Lua side's JSON, for findLeaks:
// node leaks.js <locale> <scene> [<guide id>...]
if (require.main === module) {
	const [locale, scene, ...guides] = process.argv.slice(2);
	process.stdout.write(JSON.stringify(runScene(locale, scene, guides)));
}
