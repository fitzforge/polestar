//! English on a non-English client (`i18n leaks`, docs/TRANSLATING.md, "English left on screen"; port
//! of tools/lib/i18n/leaks.js). The addon runs under Lua 5.1 on the client stub (tests/lua, through
//! forge-addontest) in each locale, with its shipped translations, names pack and guide texts, and
//! lua/leaks.lua making every name the client itself gives a placeholder with no word in it. Scenes
//! drive the windows: the guide window step by step, the picker, Options, Lookup, Dungeons, Rares,
//! talents, tooltips, the slash commands. Every text the addons put up (font strings, buttons,
//! tooltips, chat, popups, menus) is recorded; a Latin word of three or more letters that is not one
//! of the locale's own words (those of its translations, names pack and guide texts) nor on the allow
//! list (data/i18n/leaks-allow.json) is English left on screen.
//!
//! Each locale and scene runs in a Lua state of its own, as many at a time as asked (default one per
//! core). The addons and the reference data are the checkout's (`root`); the client stub is
//! forge-addontest's (tests/lua of the checkout forge was built from).

use crate::{plural, DATA_DIR};
use forge_addontest::run::{dir_files, run_addon_output, Addon, RunAddon};
use forge_guide::js::{cmp_utf16, json_quote, parse_json, stringify, Obj, V};
use forge_guide::locales::LOCALE_CODES;
use regex::Regex;
use std::collections::{HashMap, HashSet};
use std::path::{Path, PathBuf};
use std::sync::LazyLock;

/// The detector, run before any addon file.
const DETECTOR: &str = include_str!("../lua/leaks.lua");

pub fn allow_file(root: &Path) -> PathBuf {
	root.join(DATA_DIR).join("leaks-allow.json")
}

pub fn baseline_file(root: &Path) -> PathBuf {
	root.join(DATA_DIR).join("leaks-baseline.json")
}

/// The ids whose every name in a language is the English one, per locale and kind (the names build
/// writes it; local, not shipped).
pub fn same_as_english_file(root: &Path) -> PathBuf {
	root.join("data/local/names-same-as-english.json")
}

/// A JSON string, as a Lua literal (the JS wrote JSON.stringify into the Lua).
fn s(text: &str) -> String {
	let mut out = String::new();
	json_quote(&mut out, text);
	out
}

fn lua_list(a: &[String]) -> String {
	format!("{{ {} }}", a.iter().map(|x| s(x)).collect::<Vec<_>>().join(", "))
}

/// A JS string's length (UTF-16 code units).
fn len16(t: &str) -> usize {
	t.encode_utf16().count()
}

/// `t.slice(0, n)` of a JS string.
fn slice16(t: &str, n: usize) -> String {
	String::from_utf16_lossy(&t.encode_utf16().take(n).collect::<Vec<_>>())
}

/// `list.length > max ? list.slice(0, max - 3) + "..." : list`.
fn clip(t: &str, max: usize) -> String {
	if len16(t) > max {
		format!("{}...", slice16(t, max - 3))
	} else {
		t.to_string()
	}
}

/// The guides the `guide` scene shows by default: a starting zone (names as tokens in every text), a
/// zone with collect goals, a profession guide.
pub const GUIDES: [&str; 3] = ["forever/alliance/human/01-elwynn-forest", "forever/alliance/02-westfall", "forever/professions/first-aid"];

/// One scene: what it shows and the Lua that drives it.
#[derive(Clone, Default)]
pub struct Scene {
	pub name: String,
	pub about: String,
	/// Data packs it needs besides the Codex and the quest database ("codex", "questdb").
	pub needs: Vec<&'static str>,
	/// Lua run before the addons load.
	pub before: String,
	/// More stubs of tests/lua.
	pub stubs: Vec<&'static str>,
	/// (addon, saved variables Lua).
	pub saved: Vec<(String, String)>,
	/// The addons to load (default Polestar and Polestar_Guides).
	pub addons: Vec<&'static str>,
	/// The Recorder alone: no world, no packs.
	pub recorder: bool,
	/// Loads the walking map (Polestar_Nav).
	pub nav: bool,
	/// Every step and goal shows, whatever class, race or faction it is for.
	pub every_step: bool,
	/// The scene's Lua (after login).
	pub script: String,
}

/// The scenes' names, in order.
pub const SCENE_NAMES: [&str; 14] = ["guide", "guides", "welcome", "picker", "options", "lookup", "dungeons", "rares", "talents", "journey", "tooltips", "slash", "more", "recorder"];

/// The guide ids of our compiled guides, in order: addon/Polestar_Guides/Guides.lua and its faction parts
/// (Polestar_Guides_Alliance, _Horde; format 8) when present.
pub fn guide_ids(root: &Path) -> Result<Vec<String>, String> {
	static ID: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"(?m)^\t\t\tid = "([^"]+)""#).unwrap());
	let mut out: Vec<String> = Vec::new();
	for name in ["Polestar_Guides", "Polestar_Guides_Alliance", "Polestar_Guides_Horde"] {
		let file = root.join("addon").join(name).join("Guides.lua");
		if name != "Polestar_Guides" && !file.exists() {
			continue;
		}
		let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
		for m in ID.captures_iter(&text) {
			if !out.iter().any(|x| x == &m[1]) {
				out.push(m[1].to_string());
			}
		}
	}
	Ok(out)
}

/// The guide window on `ids`, every step shown and its frames hovered.
fn guide_script(ids: &[String], hover: bool) -> String {
	format!(
		r#"
local E = Polestar.Engine
for _, id in ipairs({}) do
	leaks.try(id, function()
		E.SetGuide(id)
		stub.advance(0.3)
		if PolestarGuideFrame then PolestarGuideFrame:Show() end
		for i = 1, E.GetStepCount() do
			leaks.scene(id .. " step " .. i)
			E.Goto(i)
			stub.advance(0.2)
			{}
		end
	end)
end"#,
		lua_list(ids),
		if hover { "leaks.hover(\"PolestarGuideFrame\")" } else { "" }
	)
}

/// The scene `name`; `guides`: the guide scene's guides (default GUIDES). Err: an unknown scene.
pub fn scene(root: &Path, name: &str, guides: &[String]) -> Result<Scene, String> {
	let g0 = s(GUIDES[0]);
	let base = Scene { name: name.to_string(), ..Scene::default() };
	Ok(match name {
		"guide" => Scene {
			about: "the guide window on a few guides (every step, whatever class, race or faction it is for; every tooltip); --guide names others".into(),
			every_step: true,
			script: guide_script(&if guides.is_empty() { GUIDES.iter().map(|g| g.to_string()).collect() } else { guides.to_vec() }, true),
			..base
		},
		"guides" => Scene {
			about: "the guide window on every guide, every step whatever class, race or faction it is for (no tooltips; slow)".into(),
			every_step: true,
			script: guide_script(&guide_ids(root)?, false),
			..base
		},
		"welcome" => Scene {
			about: "the welcome and setup windows, route choices, the report and Discord windows".into(),
			script: format!(
				r#"
leaks.try("welcome", function() Polestar.UI.Welcome.Show("welcome"); stub.advance(0.5); leaks.hover() end)
leaks.try("setup", function() Polestar.UI.Welcome.Show("setup"); stub.advance(0.5); leaks.hover() end)
leaks.try("route choice", function()
	for _, id in ipairs({}) do
		if Polestar.Engine.GetRouteChoice(id) then leaks.scene("route choice " .. id); Polestar.UI.ShowRouteChoice(id); stub.advance(0.3); leaks.hover() end
	end
end)
leaks.try("report", function() Polestar.Engine.SetGuide({g0}); stub.advance(0.3); Polestar.UI.ShowReport(); stub.advance(0.3); leaks.hover() end)
leaks.try("discord", function() Polestar.UI.ShowDiscord(); stub.advance(0.3); leaks.hover() end)"#,
				lua_list(&guide_ids(root)?)
			),
			..base
		},
		"picker" => Scene {
			about: "the guide picker: its sections, categories, views, factions, searches and selections".into(),
			script: format!(
				r#"
local UI, P = Polestar.UI, Polestar.UI.Picker
leaks.try("picker", function()
	UI.ShowPicker(); stub.advance(0.5); leaks.hover()
	for _, s in ipairs(P.Sections()) do leaks.try("picker section " .. tostring(s.key), function() P.ShowSection(s.key); stub.advance(0.3); leaks.hover() end) end
	P.ShowSection(P.Sections()[1].key)
	for _, c in ipairs({{ "Leveling", "Professions", "Reputation", "Class", "Dungeons", "Collectibles", "Miscellaneous", "Events", "Mounts", "Pets" }}) do
		leaks.try("picker category " .. c, function() P.SetCategory(c); stub.advance(0.2); leaks.hover() end)
	end
	for _, v in ipairs({{ "list", "cards", "map", "grid" }}) do leaks.try("picker view " .. v, function() P.SetView(v); stub.advance(0.2); leaks.hover() end) end
	for _, f in ipairs({{ "Horde", "Alliance" }}) do leaks.try("picker faction " .. f, function() Polestar.Set("ui.pickerFaction", f); UI.ShowPicker(); stub.advance(0.2); leaks.hover() end) end
	for _, q in ipairs({{ "westfall", "hogger", "linen", "deadmines", "saber", "zzzz" }}) do leaks.try("picker search " .. q, function() leaks.typed(q); P.SetQuery(q); stub.advance(0.3); leaks.hover() end) end
	for _, id in ipairs({}) do leaks.try("picker select " .. id, function() P.SetQuery(""); P.Select(id); stub.advance(0.2); leaks.hover() end) end
end)"#,
				lua_list(&guide_ids(root)?.into_iter().step_by(7).collect::<Vec<_>>())
			),
			..base
		},
		"options" => Scene {
			about: "Options: every page and tab".into(),
			script: r#"
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
end)"#
				.into(),
			..base
		},
		"lookup" => Scene {
			about: "Lookup: searches, their results and sources, and things looked up by id".into(),
			needs: vec!["codex", "questdb"],
			before: "stub.world.level = 60".into(),
			script: r#"
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
end)"#
				.into(),
			..base
		},
		"dungeons" => Scene {
			about: "Dungeons: the list by faction, every dungeon on every tab".into(),
			needs: vec!["codex"],
			before: "stub.world.level = 20".into(),
			script: r#"
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
end)"#
				.into(),
			..base
		},
		"rares" => Scene {
			about: "Rares: its tabs, a rare and a treasure, the spotted toast".into(),
			needs: vec!["codex"],
			before: "stub.world.level = 10".into(),
			script: r#"
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
end)"#
				.into(),
			..base
		},
		"talents" => Scene {
			about: "Talents: every class with its builds, and the talent frame".into(),
			stubs: vec!["stub_talents.lua"],
			// No player class at load: Talents keeps every class's plans, so the loop below sees all nine.
			before: "stub.talents.class = nil".into(),
			script: r#"
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
end)"#
				.into(),
			..base
		},
		"journey" => Scene {
			about: "the journey planner and its route to a few far places".into(),
			nav: true,
			saved: vec![("Polestar".into(), "PolestarDB = { schema = 1, settings = { nav = { journeySteps = true, journeyOpen = true, distanceUnit = \"yards\" } } }".into())],
			script: format!(
				r#"
leaks.try("journey", function()
	local N = Polestar.Nav
	Polestar.Engine.SetGuide({g0}); stub.advance(0.5)
	for _, t in ipairs({{ {{ 1453, 60, 70, "Stormwind" }}, {{ 1457, 40, 50, "Darnassus" }}, {{ 1437, 10, 60, "Menethil" }}, {{ 1454, 50, 50, "Orgrimmar" }}, {{ 1413, 52, 30, "Crossroads" }}, {{ 1446, 50, 30, "Tanaris" }} }}) do
		leaks.try("journey to " .. t[4], function()
			if Polestar.Journey and Polestar.Journey.PlanTo then Polestar.Journey.PlanTo(t[1], t[2], t[3], nil, "e") else N.SetTarget(t[1], t[2], t[3], nil, "e") end
			stub.advance(5.5)
			leaks.hover()
		end)
	end
	leaks.try("/polestar route", function() SlashCmdList.POLESTAR("route") end)
end)"#
			),
			..base
		},
		"tooltips" => Scene {
			about: "Polestar's lines in the game's unit, object and item tooltips".into(),
			needs: vec!["codex", "questdb"],
			before: "stub.world.level = 60".into(),
			script: r#"
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
end)"#
				.into(),
			..base
		},
		"slash" => Scene {
			about: "every /polestar command and its help, and the other slash commands".into(),
			script: format!(
				r#"
leaks.try("slash", function()
	Polestar.Engine.SetGuide({g0}); stub.advance(0.5)
	local S = SlashCmdList.POLESTAR
	for _, c in ipairs({{ "", "help", "status", "where", "tabs", "tab 9", "path", "route", "xp", "questdb", "near", "near trainer", "near bogus", "near innkeeper", "near flight", "gear", "gear help", "gear bogus",
		"instances", "instances help", "arrow", "arrow help", "way", "way 1 2", "way bogus", "way Westfall 50 50 Sentinel", "dungeons", "dungeons bogus", "lookup", "lookup hogger", "mount", "rares", "rares help", "rares bogus", "talents",
		"guide", "guide bogus", "guide forever/alliance/02-westfall", "skipleg", "unknowncommand", "debug", "debug", "show", "hide", "next", "prev", "skip", "close", "welcome", "report", "discord", "packs", "options", "guides", "reset" }}) do
		leaks.try("/polestar " .. c, function() leaks.typed(c); S(c); stub.advance(0.2) end)
	end
	for k, fn in pairs(SlashCmdList) do if k ~= "POLESTAR" then leaks.try("/" .. k:lower(), function() fn(""); fn("help") end) end end
end)"#
			),
			..base
		},
		"more" => Scene {
			about: "quest tooltips, the nearby menu, alerts, the arrow, the world map, XP and instance windows".into(),
			nav: true,
			before: "stub.world.level = 5".into(),
			script: format!(
				r#"
leaks.try("more", function()
	local w = stub.world
	Polestar.Set("qol.questTooltips", true)
	Polestar.Engine.SetGuide({g0}); stub.advance(0.5)
	w.accept(7, {{ 10 }}); w.accept(33, {{ 8 }}); w.accept(15, {{ 1 }}); stub.advance(1)
	stub.fire("QUEST_LOG_UPDATE"); stub.advance(1)
	local H = Polestar.Hooks
	local guid
	UnitGUID = (function(o) return function(u) if u == "mouseover" then return guid end return o(u) end end)(UnitGUID)
	GameTooltip.GetUnit = function() return "x", "mouseover" end
	for _, npc in ipairs({{ 6, 257, 299, 80, 197, 196 }}) do
		leaks.try("quest tooltip unit " .. npc, function() guid = "Creature-0-1-0-1-" .. npc .. "-0000ABCD"; GameTooltip:SetOwner(UIParent); H.OnUnitTooltip(GameTooltip, {{ guid = guid }}) end)
	end
	for _, item in ipairs({{ 750, 752, 1307 }}) do
		leaks.try("quest tooltip item " .. item, function() GameTooltip:SetOwner(UIParent); GameTooltip.GetItem = function() return "x", "item:" .. item end; H.OnItemTooltip(GameTooltip, {{ id = item }}) end)
	end
	leaks.try("nearby menu", function() Polestar.Set("nav.nearbyMenu", true); Polestar.Nav.nearby.AddMenu(nil, leaks.menu()) end)
	leaks.try("alerts", function() if Polestar.Nav.alerts then Polestar.Nav.alerts.ShowSample(); stub.advance(2) end end)
	leaks.try("arrow", function() leaks.hover() end)
	leaks.try("prompts", function() local P = Polestar.Nav.prompts; for _, it in ipairs(P and P.MenuItems and P.MenuItems() or {{}}) do leaks.rec("menu", it.text); leaks.rec("menu", it.tip) end end)
	leaks.try("world map", function()
		for _, m in ipairs({{ 1415, 1429, 1436, 1414, 947 }}) do
			leaks.scene("world map " .. m)
			stub.worldMapID = m; WorldMapFrame:Show()
			for p in pairs(WorldMapFrame.dataProviders or {{}}) do if p.RefreshAllData then pcall(p.RefreshAllData, p) end end
			stub.advance(0.5); leaks.hover(); WorldMapFrame:Hide()
		end
	end)
	leaks.try("/polestar xp", function() SlashCmdList.POLESTAR("xp"); stub.advance(1); leaks.hover() end)
	leaks.try("/polestar instances", function() SlashCmdList.POLESTAR("instances"); stub.advance(1); leaks.hover() end)
end)"#
			),
			..base
		},
		"recorder" => Scene {
			about: "Polestar Recorder: its slash commands".into(),
			stubs: vec!["stub_recorder.lua"],
			addons: vec!["Polestar_Recorder"],
			recorder: true,
			script: r#"
leaks.try("recorder", function()
	for _, c in ipairs({ "", "help", "status", "on", "off", "new", "list", "note test", "mark", "finds", "progress", "route", "clear", "bogus" }) do
		leaks.try("/psrec " .. c, function() leaks.typed(c); SlashCmdList.POLESTARREC(c); stub.advance(0.2) end)
	end
	leaks.hover()
end)"#
				.into(),
			..base
		},
		_ => return Err(format!("unknown scene \"{name}\": one of {}", SCENE_NAMES.join(", "))),
	})
}

/// Each scene's name and what it shows (for the help).
pub fn scene_about(root: &Path) -> Vec<(String, String)> {
	SCENE_NAMES.iter().map(|n| (n.to_string(), scene(root, n, &[]).map(|s| s.about).unwrap_or_default())).collect()
}

// ------------------------------------------------------------ allow list

/// `s` with the characters a regular expression gives a meaning escaped (the JS escapeRe).
fn escape_re(s: &str) -> String {
	let mut out = String::new();
	for c in s.chars() {
		if ".*+?^${}()|[]\\".contains(c) {
			out.push('\\');
		}
		out.push(c);
	}
	out
}

/// A JavaScript `u` regular expression in fancy-regex's terms: `\w`, `\d` and `\b` mean ASCII there.
fn js_regex(p: &str) -> String {
	const WORD: &str = "0-9A-Za-z_";
	let mut out = String::new();
	let mut class = false;
	let mut it = p.chars().peekable();
	while let Some(c) = it.next() {
		match c {
			'\\' => {
				let Some(n) = it.next() else {
					out.push('\\');
					break;
				};
				match (n, class) {
					('w', false) => out.push_str(&format!("[{WORD}]")),
					('w', true) => out.push_str(WORD),
					('W', false) => out.push_str(&format!("[^{WORD}]")),
					('d', false) => out.push_str("[0-9]"),
					('d', true) => out.push_str("0-9"),
					('D', false) => out.push_str("[^0-9]"),
					('b', false) => out.push_str(&format!("(?:(?<=[{WORD}])(?![{WORD}])|(?<![{WORD}])(?=[{WORD}]))")),
					_ => {
						out.push('\\');
						out.push(n);
					}
				}
			}
			'[' if !class => {
				class = true;
				out.push(c);
				if it.peek() == Some(&'^') {
					out.push(it.next().unwrap());
				}
				if it.peek() == Some(&']') {
					out.push_str("\\]");
					it.next();
				}
			}
			']' if class => {
				class = false;
				out.push(c);
			}
			_ => out.push(c),
		}
	}
	out
}

fn compile(p: &str) -> Result<fancy_regex::Regex, String> {
	fancy_regex::Regex::new(&js_regex(p)).map_err(|e| format!("{p}: {e}"))
}

/// The /polestar commands the addon registers (ns.RegisterCommand("name", ...)), in the order the
/// folders list their files.
fn command_words(root: &Path) -> Vec<String> {
	static RE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"RegisterCommand\("([a-z]+)""#).unwrap());
	fn walk(dir: &Path, out: &mut Vec<String>) {
		let Ok(rd) = std::fs::read_dir(dir) else { return };
		for e in rd.flatten() {
			let name = e.file_name().to_string_lossy().into_owned();
			if e.file_type().is_ok_and(|t| t.is_dir()) {
				if name != "Locales" {
					walk(&e.path(), out);
				}
			} else if name.ends_with(".lua") {
				let text = std::fs::read_to_string(e.path()).unwrap_or_default();
				for m in RE.captures_iter(&text) {
					if !out.iter().any(|x| x == &m[1]) {
						out.push(m[1].to_string());
					}
				}
			}
		}
	}
	let mut out = Vec::new();
	walk(&root.join("addon/Polestar"), &mut out);
	out
}

fn by_length_desc(mut v: Vec<String>) -> Vec<String> {
	v.sort_by_key(|x| std::cmp::Reverse(len16(x)));
	v
}

fn unique(v: impl IntoIterator<Item = String>) -> Vec<String> {
	let mut out: Vec<String> = Vec::new();
	for x in v {
		if !out.contains(&x) {
			out.push(x);
		}
	}
	out
}

/// What is cut out of a text before its words are looked at: for every locale, and per locale.
pub struct Allow {
	pub all: Vec<fancy_regex::Regex>,
	pub locale: HashMap<String, Vec<fancy_regex::Regex>>,
	/// The products and terms (longest first), the slash commands' arguments and the products' words, for
	/// the Lua side.
	lua: String,
}

/// The allow list (data/i18n/leaks-allow.json): products and terms that stay as they are, patterns
/// (regular expressions in JavaScript's `u` syntax; {ARGS} and {COMMANDS} stand for the slash
/// commands' arguments and the registered commands), and per locale the names the game keeps in
/// English there.
pub fn load_allow(root: &Path) -> Result<Allow, String> {
	let file = allow_file(root);
	let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	let raw = parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	let strs = |k: &str| raw.get(k).items().iter().map(|x| x.to_js_string()).collect::<Vec<_>>();
	// Whole words of Latin letters: a Korean particle may follow ("Codex가").
	let word = |s: &str| compile(&format!("(?<![A-Za-z0-9]){}(?![A-Za-z0-9])", escape_re(s)));
	let list = |items: Vec<String>| -> Result<Vec<fancy_regex::Regex>, String> { by_length_desc(items).iter().filter(|x| !x.is_empty()).map(|x| word(x)).collect() };
	let commands = command_words(root);
	let args = by_length_desc(unique(commands.iter().cloned().chain(strs("slashArguments")))).iter().map(|x| escape_re(x)).collect::<Vec<_>>().join("|");
	let cmds = by_length_desc(commands.clone()).iter().map(|x| escape_re(x)).collect::<Vec<_>>().join("|");
	let mut all = Vec::new();
	for (_, p) in raw.get("patterns").entries() {
		let p = p.to_js_string().replace("{ARGS}", &format!("(?:{args})(?![\\p{{L}}\\p{{N}}])")).replace("{COMMANDS}", &format!("(?:{cmds})"));
		all.push(compile(&p)?);
	}
	let mut products = strs("products");
	products.extend(strs("terms"));
	all.extend(list(products.clone())?);
	let mut locale = HashMap::new();
	for (code, entries) in raw.get("locales").entries() {
		if !LOCALE_CODES.contains(&&*code) {
			return Err(format!("{DATA_DIR}/leaks-allow.json: unknown locale \"{code}\""));
		}
		locale.insert(code.to_string(), list(entries.items().iter().map(|x| x.to_js_string()).collect())?);
	}
	// For the Lua side: text it cuts before it learns a translation's words.
	let products = by_length_desc(products);
	let slash = unique(commands.into_iter().chain(strs("slashArguments")));
	static LATIN3: LazyLock<Regex> = LazyLock::new(|| Regex::new("[a-z]{3,}").unwrap());
	let words = unique(products.iter().flat_map(|p| LATIN3.find_iter(&p.to_lowercase()).map(|m| m.as_str().to_string()).collect::<Vec<_>>()));
	let lua = format!(
		"products = {}, slashArgs = {{ {} }}, allowWords = {{ {} }}",
		lua_list(&products),
		slash.iter().map(|a| format!("[{}] = true", s(a))).collect::<Vec<_>>().join(", "),
		words.iter().map(|w| format!("[{}] = true", s(w))).collect::<Vec<_>>().join(", ")
	);
	Ok(Allow { all, locale, lua })
}

/// The words of `plain` the allow list leaves, among `flagged` (the Lua side's: not one of the
/// locale's own words).
pub fn leak_words(plain: &str, flagged: &[String], allow: &Allow, locale: &str) -> Vec<String> {
	static WORD: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"[\p{L}\p{M}]+").unwrap());
	let mut text = plain.to_string();
	for re in allow.all.iter().chain(allow.locale.get(locale).into_iter().flatten()) {
		text = re.replace_all(&text, " ").into_owned();
	}
	let want: HashSet<String> = flagged.iter().map(|w| w.to_lowercase()).collect();
	let mut out: Vec<String> = Vec::new();
	for m in WORD.find_iter(&text) {
		let w = m.as_str();
		if w.len() >= 3 && w.bytes().all(|b| b.is_ascii_alphabetic()) && want.contains(&w.to_lowercase()) && !out.iter().any(|x| x == w) {
			out.push(w.to_string());
		}
	}
	out
}

// ------------------------------------------------------------ one run

/// The addon folder `name` of the checkout is built (its TOC is there).
fn built(root: &Path, name: &str) -> bool {
	root.join("addon").join(name).join(format!("{name}.toc")).exists()
}

/// The Codex and the quest database are built (a developer's machine, not CI).
pub fn full_data(root: &Path) -> bool {
	built(root, "Polestar_Codex") && built(root, "Polestar_QuestDB")
}

/// Why `scene` cannot run: every scene needs the Codex and the quest database (built on the
/// developer's machine): without them the addon is an incomplete install, with its own warnings.
pub fn scene_skip(root: &Path, scene: &Scene) -> Option<String> {
	for n in ["codex", "questdb"].into_iter().chain(scene.needs.iter().copied()) {
		match n {
			"codex" if !built(root, "Polestar_Codex") => return Some("addon/Polestar_Codex is not built (forge data codex)".into()),
			"questdb" if !built(root, "Polestar_QuestDB") => return Some("addon/Polestar_QuestDB is not built (forge data questdb)".into()),
			_ => {}
		}
	}
	None
}

/// The installed addons (stub.addons: the install check finds them) and the load-on-demand packs
/// C_AddOns.LoadAddOn loads (stub.packs).
fn packs_lua(root: &Path, locale: &str, scene: &Scene) -> Result<String, String> {
	if scene.recorder {
		return Ok(String::new());
	}
	let mut names: Vec<String> = ["Polestar_QuestDB", "Polestar_Codex", "Polestar_ItemDB"].iter().map(|x| x.to_string()).collect();
	// The walking map (Polestar_Nav) plans paths in the background, seconds of Lua each step: only the
	// scenes about travel load it.
	if scene.nav {
		names.push("Polestar_Nav".into());
	}
	// The language folder: our guides' texts and the game's names in this language.
	names.push(forge_guide::toc::language_addon(locale));
	// Our pack's faction parts (format 8): both, loaded after login (run_scene), as before the split.
	names.extend(["Polestar_Guides_Alliance", "Polestar_Guides_Horde"].map(String::from));
	let mut packs = Vec::new();
	for n in names {
		if built(root, &n) {
			let files: Vec<String> = dir_files(&root.join("addon").join(&n))?.iter().map(|f| f.to_string_lossy().into_owned()).collect();
			packs.push((n, files));
		}
	}
	let mut installed = vec!["Polestar".to_string(), "Polestar_Guides".to_string()];
	installed.extend(packs.iter().map(|(n, _)| n.clone()));
	let mut lines = vec![format!("stub.addons = {{ {} }}", installed.iter().map(|n| format!("{{ name = {} }}", s(n))).collect::<Vec<_>>().join(", "))];
	for (k, files) in &packs {
		lines.push(format!("stub.packs[{}] = {}", s(k), lua_list(files)));
	}
	Ok(lines.join("\n"))
}

/// The stub world: every map the guides know (their MapFrames.lua), the player in Northshire, the
/// Recorder present.
fn world_lua(root: &Path) -> Result<String, String> {
	static MAP: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\[([0-9]+)\] = \{ c = (-?[0-9]+), left = (-?[0-9.]+), right = (-?[0-9.]+), top = (-?[0-9.]+), bottom = (-?[0-9.]+) \}").unwrap());
	let file = root.join("addon/Polestar_Guides/MapFrames.lua");
	let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	// A clone has no reference data: no parents.
	let zones = std::fs::read_to_string(root.join("data/forever/zones.json")).ok().and_then(|t| parse_json(&t).ok()).unwrap_or_else(V::obj);
	let mut seen = HashSet::new();
	let mut maps = Vec::new();
	for m in MAP.captures_iter(&text) {
		if !seen.insert(m[1].to_string()) {
			continue;
		}
		let z = zones.get(&m[1]);
		let or = |v: V, d: &str| if v.truthy() { v.to_js_string() } else { d.to_string() };
		let name = z.get("name");
		let name = if name.truthy() { name.to_js_string() } else { format!("Map {}", &m[1]) };
		maps.push(format!(
			"w.addMap({}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {}, parent = {}, mapType = {} }})",
			&m[1],
			s(&name),
			&m[2],
			&m[3],
			&m[4],
			&m[5],
			&m[6],
			or(z.get("parent"), "0"),
			or(z.get("type"), "3")
		));
	}
	Ok(format!(
		"local w = stub.world
{}
w.moveTo(1429, 48.5, 42.5)
w.zone, w.subzone = \"Elwynn Forest\", \"Northshire Valley\"
OpenWorldMap = OpenWorldMap or function() end
QuestDifficultyColors = {{ impossible = {{ r = 1, g = 0.1, b = 0.1 }}, verydifficult = {{ r = 1, g = 0.5, b = 0.25 }}, difficult = {{ r = 1, g = 0.82, b = 0 }}, standard = {{ r = 0.25, g = 0.75, b = 0.25 }}, trivial = {{ r = 0.5, g = 0.5, b = 0.5 }} }}
function GetQuestDifficultyColor() return {{ r = 1, g = 1, b = 0 }} end
stub.addonsLoaded.Polestar_Recorder = true
PolestarRecorderDB = {{ schema = 2, enabled = true, install = \"k3j9x0q2m7ab\", seq = 9, acked = 7, chunks = {{ [8] = (\"x\"):rep(3072), [9] = (\"x\"):rep(2048) }}, maps = {{}} }}",
		maps.join("\n")
	))
}

/// One locale, one scene on the addon -> the Lua side's dump (JSON text): { texts, candidates, errors,
/// missedNames, missedEnglish } (and `all`, every text, with `all`).
pub fn run_scene(root: &Path, locale: &str, scene: &Scene, allow: &Allow, all: bool) -> Result<String, String> {
	let before = [
		format!("LEAKS = {{ locale = {}, all = {all}, everyStep = {}, {} }}", s(locale), scene.every_step, allow.lua),
		"stub.packs = stub.packs or {}".into(),
		packs_lua(root, locale, scene)?,
		if scene.recorder { String::new() } else { world_lua(root)? },
		scene.before.clone(),
		format!("assert(loadstring({}, \"=leaks.lua\"))()", forge_addontest::run::lua_string(DETECTOR)),
	]
	.join("\n");
	let mut stubs: Vec<&'static str> = if scene.recorder { Vec::new() } else { vec!["stub_world.lua", "stub_encoding.lua", "stub_packs.lua"] };
	stubs.extend(scene.stubs.iter().copied());
	let addons: Vec<&str> = if scene.addons.is_empty() { vec!["Polestar", "Polestar_Guides"] } else { scene.addons.clone() };
	let opts = RunAddon {
		stubs,
		before,
		addons: addons.iter().map(|a| Addon::dir(a, root.join("addon").join(a))).collect(),
		saved: scene.saved.clone(),
		login: false,
		// Both factions' guides, as before the faction parts (Polestar loads the other side's when asked).
		script: format!("leaks.hookPolestar()\nleaks.scene(\"login\")\nstub.login()\nif Polestar.Guides and Polestar.Guides.LoadFaction then Polestar.Guides.LoadFaction(\"All\") end\nstub.advance(1)\n{}\nleaks.dump()", scene.script),
	};
	let out = run_addon_output(&opts)?;
	for line in out.stdout.split('\n') {
		if let Some(j) = line.strip_prefix("@@JSON ") {
			let v = parse_json(j).map_err(|e| format!("{locale} {}: {e}", scene.name))?;
			if v.get("leaks").truthy() {
				return Ok(j.to_string());
			}
		}
	}
	Err(format!("{locale} {}: the scene emitted nothing", scene.name))
}

// ------------------------------------------------------------ checking a run

/// The English names of the reference data (data/forever), each table read once.
pub struct DataNames {
	dir: PathBuf,
	tables: HashMap<&'static str, V>,
	index: Option<(HashMap<String, String>, bool)>,
}

const DATA_FILES: [(&str, &str); 5] = [("npc", "npcs.json"), ("object", "objects.json"), ("item", "items.json"), ("quest", "quests.json"), ("encounter", "codex/instances.json")];

fn has_three_latin(s: &str) -> bool {
	static RE: LazyLock<Regex> = LazyLock::new(|| Regex::new("[A-Za-z]{3}").unwrap());
	RE.is_match(s)
}

impl DataNames {
	pub fn new(root: &Path) -> DataNames {
		DataNames { dir: root.join("data/forever"), tables: HashMap::new(), index: None }
	}

	/// kind -> { id: name }.
	fn table(&mut self, kind: &'static str) -> V {
		if let Some(t) = self.tables.get(kind) {
			return t.clone();
		}
		let file = DATA_FILES.iter().find(|(k, _)| *k == kind).map(|(_, f)| self.dir.join(f)).unwrap();
		let doc = std::fs::read_to_string(&file).ok().and_then(|t| parse_json(&t).ok()).unwrap_or_else(V::obj);
		let names = Obj::new();
		if kind == "encounter" {
			// Dungeon encounters: the bosses of codex/instances.json.
			for inst in doc.values() {
				for b in inst.get("bosses").items() {
					if b.get("encounter").truthy() && b.get("name").truthy() {
						names.set(&b.get("encounter").to_js_string(), b.get("name"));
					}
				}
			}
		} else {
			for (id, v) in doc.entries() {
				let n = if v.get("name").truthy() { v.get("name") } else { v.get("title") };
				if v.truthy() && n.truthy() {
					names.set_str(id, n);
				}
			}
		}
		let v = V::Obj(names);
		self.tables.insert(kind, v.clone());
		v
	}

	/// The English the reference data gives the missed names: [("kind:id", name)].
	fn names(&mut self, keys: &[String]) -> Vec<(String, String)> {
		let mut out: Vec<(String, String)> = Vec::new();
		for k in keys {
			let Some((kind, id)) = k.split_once(':') else { continue };
			let Some((kind, _)) = DATA_FILES.iter().find(|(x, _)| *x == kind) else { continue };
			let name = self.table(kind).get(id.split(':').next().unwrap_or(id));
			if let Some(n) = name.as_str().filter(|n| has_three_latin(n)) {
				match out.iter_mut().find(|(x, _)| x == k) {
					Some(e) => e.1 = n.to_string(),
					None => out.push((k.clone(), n.to_string())),
				}
			}
		}
		out
	}

	/// The longest run of words in `plain` that is a name of the reference data -> ("kind:id", English).
	fn name_in(&mut self, plain: &str) -> Option<(String, String)> {
		if self.index.is_none() {
			let mut index = HashMap::new();
			for (kind, _) in DATA_FILES {
				for (id, name) in self.table(kind).entries() {
					let name = name.to_js_string();
					if has_three_latin(&name) && !index.contains_key(&name) {
						index.insert(name, format!("{kind}:{id}"));
					}
				}
			}
			let empty = index.is_empty();
			self.index = Some((index, empty));
		}
		let (index, empty) = self.index.as_ref().unwrap();
		if *empty {
			return None;
		}
		static SPLIT: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"[\s()«»"“”·:;,]+"#).unwrap());
		static END: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"[.!?]+$").unwrap());
		let words: Vec<&str> = SPLIT.split(plain).filter(|w| !w.is_empty()).collect();
		let mut best: Option<(String, String)> = None;
		for i in 0..words.len() {
			for j in (i + 1..=words.len().min(i + 8)).rev() {
				let joined = words[i..j].join(" ");
				let s = END.replace(&joined, "").into_owned();
				if best.as_ref().is_none_or(|b| len16(&s) > len16(&b.1)) {
					if let Some(name) = index.get(&s) {
						best = Some((name.clone(), s));
						break;
					}
				}
			}
		}
		best
	}
}

/// The names no source has in a language (leaks-baseline.json): { about, reasons, entries: { [locale]:
/// { ["kind:id"]: { reason, scenes, english } } } }. A text whose English is only such names is no
/// leak; an entry whose scenes all ran in its locale without it showing is stale (the file only
/// shrinks).
pub fn load_baseline(root: &Path) -> Result<V, String> {
	let file = baseline_file(root);
	let Ok(text) = std::fs::read_to_string(&file) else { return Ok(V::Obj(forge_guide::obj! { "reasons" => V::obj(), "entries" => V::obj() })) };
	let raw = parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	for code in raw.get("entries").keys() {
		if !LOCALE_CODES.contains(&&*code) {
			return Err(format!("{DATA_DIR}/leaks-baseline.json: unknown locale \"{code}\""));
		}
	}
	let out = Obj::new();
	if !raw.get("about").is_undef() {
		out.set("about", raw.get("about"));
	}
	out.set("reasons", if raw.get("reasons").truthy() { raw.get("reasons") } else { V::obj() });
	out.set("entries", if raw.get("entries").truthy() { raw.get("entries") } else { V::obj() });
	Ok(V::Obj(out))
}

/// The Lua side's JSON writes an empty list as {}.
fn list(v: &V) -> Vec<V> {
	if v.is_arr() {
		v.items()
	} else {
		Vec::new()
	}
}

fn strings(v: &V) -> Vec<String> {
	list(v).iter().map(|x| x.to_js_string()).collect()
}

fn squash(t: &str) -> String {
	static WS: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\s+").unwrap());
	WS.replace_all(t, " ").trim().to_string()
}

/// One run's result (a JS object: { locale, scene, texts, leaks, errors, baselined, fullData }, or
/// { locale, scene, skipped }).
pub type Run = V;

/// Where a leak's English came from: the Lua side's best source (the one whose English it holds the
/// most of), a name the reference data gives a missed id if longer, a name of the reference data the
/// text holds; else the line that set it.
fn source_of(c: &V, kept: &V, names: &[(String, String)], classify: bool, missed: &HashSet<String>, data: &mut DataNames) -> V {
	let from = c.get("from");
	let mut best: Option<V> = (from.truthy() && from.get("match").truthy()).then(|| from.clone());
	let plain = c.get("plain").to_js_string();
	for (key, en) in names {
		if best.as_ref().is_none_or(|b| len16(en) > len16(&b.get("match").to_js_string())) && plain.contains(en.as_str()) {
			best = Some(V::Obj(forge_guide::obj! { "kind" => "name", "name" => key.as_str(), "english" => en.as_str(), "match" => en.as_str() }));
		}
	}
	if best.is_none() && classify {
		if let Some((name, english)) = data.name_in(&plain) {
			let kind = if missed.contains(&name) { "name" } else { "unasked" };
			best = Some(V::Obj(forge_guide::obj! { "kind" => kind, "name" => name.as_str(), "english" => english.as_str(), "match" => english.as_str() }));
		}
	}
	let site = list(&c.get("site"));
	let place = site.first().filter(|x| x.truthy()).map_or_else(|| "?".to_string(), |x| x.to_js_string());
	let kind = best.as_ref().map(|b| b.get("kind").to_js_string()).unwrap_or_default();
	let o = |pairs: Vec<(&str, V)>| {
		let o = Obj::new();
		for (k, v) in pairs {
			o.set(k, v);
		}
		V::Obj(o)
	};
	// English a translation keeps (names it writes as in English), unless an untranslated string or
	// guide text explains it.
	if kept.truthy() && !(kind == "interface" || kind == "guide") {
		return o(vec![("kind", "kept".into()), ("english", kept.clone()), ("where", place.into())]);
	}
	let Some(best) = best else { return o(vec![("kind", "code".into()), ("where", place.into())]) };
	match kind.as_str() {
		"interface" => {
			let sites = list(&best.get("sites"));
			let w = sites.first().filter(|x| x.truthy()).map_or(place, |x| x.to_js_string());
			o(vec![("kind", "interface".into()), ("key", best.get("key")), ("addon", best.get("addon")), ("where", w.into())])
		}
		"guide" => o(vec![("kind", "guide".into()), ("guide", best.get("guide")), ("english", best.get("english")), ("where", place.into())]),
		"name" | "unasked" => o(vec![("kind", kind.as_str().into()), ("name", best.get("name")), ("english", best.get("english")), ("where", place.into())]),
		_ => o(vec![("kind", "code".into()), ("where", place.into())]),
	}
}

/// Options of [`check_run`].
pub struct Check<'a> {
	/// Also by the reference data's names, when built.
	pub classify: bool,
	pub baseline: &'a V,
	pub full_data: bool,
}

/// One run's leaks: its candidates less what the allow list allows and the baseline's names, each with
/// its source. -> { locale, scene, texts, leaks, errors, baselined: ["kind:id" the baseline let
/// through], fullData }
pub fn check_run(locale: &str, scene: &str, dump: &V, allow: &Allow, opts: &Check, data: &mut DataNames) -> Run {
	let missed: HashSet<String> = strings(&dump.get("missedNames")).into_iter().collect();
	let mut english: Vec<(String, String)> = Vec::new();
	let put = |list: &mut Vec<(String, String)>, k: String, v: String| match list.iter_mut().find(|(x, _)| *x == k) {
		Some(e) => e.1 = v,
		None => list.push((k, v)),
	};
	if opts.classify {
		for (k, v) in data.names(&strings(&dump.get("missedNames"))) {
			put(&mut english, k, v);
		}
	}
	for (k, v) in dump.get("missedEnglish").entries() {
		put(&mut english, k.to_string(), v.to_js_string());
	}
	let known = opts.baseline.get("entries").get(locale);
	// A baseline name's English, kept in its entry: without the built data (CI) too.
	for (key, e) in known.entries() {
		if e.get("english").truthy() && !english.iter().any(|(k, v)| *k == *key && !v.is_empty()) && !key.starts_with("text:") {
			put(&mut english, key.to_string(), e.get("english").to_js_string());
		}
	}
	let known_has = |k: &str| known.get(k).truthy();
	let mut used: Vec<String> = Vec::new();
	let leaks = forge_guide::js::Arr::new();
	for c in list(&dump.get("candidates")) {
		let plain = c.get("plain").to_js_string();
		let words = leak_words(&plain, &strings(&c.get("words")), allow, locale);
		if words.is_empty() {
			continue;
		}
		// The missed names the text holds, the longest first.
		let mut held: Vec<(String, String)> = Vec::new();
		for n in list(&c.get("names")) {
			let (k, en) = (n.get("name").to_js_string(), n.get("english").to_js_string());
			match held.iter_mut().find(|(x, _)| *x == k) {
				Some(e) => e.1 = en,
				None => held.push((k, en)),
			}
		}
		for (key, en) in &english {
			if !held.iter().any(|(k, _)| k == key) && plain.contains(en.as_str()) {
				held.push((key.clone(), en.clone()));
			}
		}
		held.sort_by_key(|(_, en)| std::cmp::Reverse(len16(en)));
		let names = held;
		let (mut rest, mut all) = (plain.clone(), plain.clone());
		for (key, en) in &names {
			all = all.replace(en.as_str(), " ");
			if known_has(key) {
				rest = rest.replace(en.as_str(), " ");
				if !used.contains(key) {
					used.push(key.clone());
				}
			}
		}
		let keeps = c.get("keeps");
		let keeps = if keeps.is_object() { keeps } else { V::obj() };
		let all_kept = |ws: &[String]| !ws.is_empty() && ws.iter().all(|w| keeps.get(&w.to_lowercase()).truthy());
		let text_key = format!("text:{}", squash(&plain));
		let words = leak_words(&rest, &words, allow, locale);
		if words.is_empty() {
			continue;
		}
		// Its English, once the baseline's names are cut, is all words a translation keeps, and the
		// baseline has the text.
		let kept = if all_kept(&words) { keeps.get(&words[0].to_lowercase()) } else { V::Null };
		let source = source_of(&c, &kept, &english, opts.classify, &missed, data);
		// (Never an untranslated interface string or guide text.)
		let sk = source.get("kind").to_js_string();
		let untranslated = sk == "interface" || sk == "guide";
		if !untranslated && kept.truthy() && known_has(&text_key) {
			if !used.contains(&text_key) {
				used.push(text_key);
			}
			continue;
		}
		// What `--update-baseline` may take: the text's missed names, and the text itself when what is
		// left once they are cut is all kept English.
		let left = if names.is_empty() { words.clone() } else { leak_words(&all, &words, allow, locale) };
		let kept_text = !untranslated && all_kept(&left);
		let takes = !untranslated && (left.is_empty() || kept_text);
		let name_english = Obj::new();
		for (k, en) in &names {
			name_english.set(k, en.as_str());
		}
		let l = Obj::new();
		l.set("text", squash(&c.get("text").to_js_string()));
		l.set("words", V::from(words.iter().map(|w| V::from(w.as_str())).collect::<Vec<_>>()));
		l.set("kind", c.get("kind"));
		l.set("site", V::from(list(&c.get("site"))));
		l.set("scenes", V::from(list(&c.get("scenes"))));
		l.set("source", source);
		l.set("names", V::from(if takes { names.iter().map(|(k, _)| V::from(k.as_str())).collect::<Vec<_>>() } else { Vec::new() }));
		l.set("nameEnglish", name_english);
		l.set("textKey", if kept_text { V::from(text_key) } else { V::Null });
		leaks.push(l);
	}
	V::Obj(forge_guide::obj! {
		"locale" => locale,
		"scene" => scene,
		"texts" => dump.get("texts"),
		"leaks" => V::Arr(leaks),
		"errors" => V::from(list(&dump.get("errors"))),
		"baselined" => V::from(used.into_iter().map(V::from).collect::<Vec<_>>()),
		"fullData" => opts.full_data
	})
}

/// Baseline entries no run let through though every scene they show in ran in their locale with the
/// locally built data packs (without the Codex and the quest database a scene shows fewer names, so it
/// proves nothing stale): (locale, key, entry).
pub fn stale_baseline(results: &[Run], baseline: &V) -> Vec<(String, String, V)> {
	let ran: HashSet<String> =
		results.iter().filter(|r| !r.get("skipped").truthy() && r.get("fullData").truthy()).map(|r| format!("{}\0{}", r.get("locale").to_js_string(), r.get("scene").to_js_string())).collect();
	let used: HashSet<String> = results.iter().flat_map(|r| strings(&r.get("baselined")).into_iter().map(move |k| format!("{}\0{k}", r.get("locale").to_js_string()))).collect();
	let mut out = Vec::new();
	for (locale, entries) in baseline.get("entries").entries() {
		for (key, entry) in entries.entries() {
			let scenes = strings(&entry.get("scenes"));
			if !scenes.is_empty() && scenes.iter().all(|s| ran.contains(&format!("{locale}\0{s}"))) && !used.contains(&format!("{locale}\0{key}")) {
				out.push((locale.to_string(), key.to_string(), entry));
			}
		}
	}
	out
}

/// A baseline name's reason: "kept-english" for a text, "same-as-english" when its every name in the
/// language is the English one (the names build writes those ids), else "no-source".
pub fn baseline_reason(root: &Path) -> impl FnMut(&str, &str) -> String {
	let same = std::fs::read_to_string(same_as_english_file(root)).ok().and_then(|t| parse_json(&t).ok()).unwrap_or_else(V::obj);
	let mut sets: HashMap<String, HashSet<String>> = HashMap::new();
	move |locale: &str, key: &str| {
		if key.starts_with("text:") {
			return "kept-english".into();
		}
		let (kind, id) = key.split_once(':').unwrap_or((key, ""));
		let id = id.split(':').next().unwrap_or(id);
		let set = sets.entry(format!("{locale} {kind}")).or_insert_with(|| same.get(locale).get(kind).items().iter().map(|x| x.to_js_string()).collect());
		if set.contains(id) {
			"same-as-english".into()
		} else {
			"no-source".into()
		}
	}
}

/// `a.localeCompare(b, 'en', { numeric })` for the baseline's keys and the groups' labels: ICU's root
/// order on the ASCII the keys hold (white space, then punctuation and symbols in its order, then
/// digits, by value when `numeric`, then letters, case second and lower case first), accents after.
pub fn locale_compare(a: &str, b: &str, numeric: bool) -> std::cmp::Ordering {
	use std::cmp::Ordering;
	const PUNCT: &str = "_-,;:!?.'\"()[]{}@*/\\&#%`^+<=>|~$";
	// Primary: (class, weight); digits runs by value with `numeric`.
	#[derive(PartialEq, PartialOrd)]
	enum P {
		Space(u32),
		Punct(u32),
		Other(u32),
		Num(String),
		Letter(char),
	}
	fn primary(s: &str, numeric: bool) -> Vec<P> {
		let folded: Vec<char> = crate::glossary::fold(s).chars().collect();
		let mut out = Vec::new();
		let mut i = 0;
		while i < folded.len() {
			let c = folded[i];
			if c.is_ascii_digit() {
				if numeric {
					let start = i;
					while i < folded.len() && folded[i].is_ascii_digit() {
						i += 1;
					}
					let digits: String = folded[start..i].iter().collect::<String>().trim_start_matches('0').to_string();
					// Shorter runs are smaller; equal lengths compare as text.
					out.push(P::Num(format!("{:0>40}", digits)));
					continue;
				}
				out.push(P::Num(c.to_string()));
			} else if c.is_whitespace() {
				out.push(P::Space(c as u32));
			} else if let Some(k) = PUNCT.find(c) {
				out.push(P::Punct(k as u32));
			} else if c.is_alphabetic() {
				out.push(P::Letter(c));
			} else {
				out.push(P::Other(c as u32));
			}
			i += 1;
		}
		out
	}
	let (pa, pb) = (primary(a, numeric), primary(b, numeric));
	for (x, y) in pa.iter().zip(&pb) {
		match x.partial_cmp(y) {
			Some(Ordering::Equal) | None => {}
			Some(o) => return o,
		}
	}
	match pa.len().cmp(&pb.len()) {
		Ordering::Equal => {}
		o => return o,
	}
	// Accents, then case (lower first), then the code points.
	let nfd = |s: &str| -> String { unicode_normalization::UnicodeNormalization::nfd(s).collect::<String>().to_lowercase() };
	match nfd(a).cmp(&nfd(b)) {
		Ordering::Equal => {}
		o => return o,
	}
	let case = |s: &str| s.chars().map(|c| c.is_uppercase()).collect::<Vec<_>>();
	match case(a).cmp(&case(b)) {
		Ordering::Equal => a.cmp(b),
		o => o,
	}
}

/// The baseline after these runs: stale entries gone, every name-only leak (missed names no source
/// has) added with the scenes it showed in.
pub fn updated_baseline(results: &[Run], baseline: &V, reason_of: &mut dyn FnMut(&str, &str) -> String) -> V {
	let entries = baseline.get("entries").json_clone();
	for (locale, key, _) in stale_baseline(results, baseline) {
		if let Some(o) = entries.get(&locale).as_obj() {
			o.delete(&key);
		}
	}
	let mut add = |locale: &str, key: &str, scene: &str, english: Option<String>| {
		if !entries.get(locale).truthy() {
			entries.set(locale, V::obj());
		}
		let l = entries.get(locale);
		if !l.get(key).truthy() {
			l.set(key, V::Obj(forge_guide::obj! { "reason" => reason_of(locale, key), "scenes" => V::arr() }));
		}
		let e = l.get(key);
		e.set("reason", reason_of(locale, key));
		if let Some(en) = english.filter(|x| !x.is_empty()) {
			e.set("english", en);
		}
		let mut scenes = strings(&e.get("scenes"));
		if !scenes.iter().any(|x| x == scene) {
			scenes.push(scene.to_string());
		}
		scenes.sort_by(|a, b| cmp_utf16(a, b));
		e.set("scenes", V::from(scenes.into_iter().map(V::from).collect::<Vec<_>>()));
	};
	for r in results {
		let (locale, scene) = (r.get("locale").to_js_string(), r.get("scene").to_js_string());
		for k in strings(&r.get("baselined")) {
			add(&locale, &k, &scene, None);
		}
		for l in list(&r.get("leaks")) {
			for k in strings(&l.get("names")) {
				let en = l.get("nameEnglish").get(&k);
				add(&locale, &k, &scene, en.truthy().then(|| en.to_js_string()));
			}
			if l.get("textKey").truthy() {
				add(&locale, &l.get("textKey").to_js_string(), &scene, None);
			}
		}
	}
	let sorted = Obj::new();
	let mut locales: Vec<String> = entries.keys().iter().map(|k| k.to_string()).collect();
	locales.sort_by(|a, b| cmp_utf16(a, b));
	for locale in locales {
		let l = entries.get(&locale);
		let mut keys: Vec<String> = l.keys().iter().map(|k| k.to_string()).collect();
		keys.sort_by(|a, b| locale_compare(a, b, true));
		if !keys.is_empty() {
			let o = Obj::new();
			for k in keys {
				o.set(&k, l.get(&k));
			}
			sorted.set(&locale, o);
		}
	}
	let out = Obj::new();
	if !baseline.get("about").is_undef() {
		out.set("about", baseline.get("about"));
	}
	out.set("reasons", baseline.get("reasons"));
	out.set("entries", sorted);
	V::Obj(out)
}

/// The number of names in a baseline.
pub fn baseline_count(b: &V) -> usize {
	b.get("entries").values().iter().map(|e| e.keys().len()).sum()
}

/// The baseline as the file holds it.
pub fn baseline_text(b: &V) -> String {
	format!("{}\n", stringify(b, Some("\t")))
}

// ------------------------------------------------------------ many runs

/// Every locale with every scene (`scenes`, each built), `jobs` at a time (default: the cores), each
/// result as it comes (`on_result`). -> one result per (scene, locale), in that order.
pub fn find_leaks(root: &Path, locales: &[String], scenes: &[Scene], jobs: Option<usize>, on_result: &mut dyn FnMut(&Run)) -> Result<Vec<Run>, String> {
	let allow = load_allow(root)?;
	let baseline = load_baseline(root)?;
	let full = full_data(root);
	let mut work: Vec<(&Scene, &String)> = Vec::new();
	for sc in scenes {
		for l in locales {
			work.push((sc, l));
		}
	}
	let limit = jobs.unwrap_or_else(|| std::thread::available_parallelism().map_or(1, |n| n.get())).max(1).min(work.len().max(1));
	let next = std::sync::atomic::AtomicUsize::new(0);
	let (tx, rx) = std::sync::mpsc::channel::<(usize, Result<Option<String>, String>)>();
	let mut results: Vec<Option<Run>> = vec![None; work.len()];
	let mut data = DataNames::new(root);
	let mut first_err: Option<String> = None;
	std::thread::scope(|scope| {
		for _ in 0..limit {
			let tx = tx.clone();
			let (work, next, allow) = (&work, &next, &allow);
			scope.spawn(move || loop {
				let i = next.fetch_add(1, std::sync::atomic::Ordering::SeqCst);
				let Some((sc, locale)) = work.get(i) else { break };
				let r = if scene_skip(root, sc).is_some() { Ok(None) } else { run_scene(root, locale, sc, allow, false).map(Some) };
				if tx.send((i, r)).is_err() {
					break;
				}
			});
		}
		drop(tx);
		for (i, r) in rx {
			let (sc, locale) = work[i];
			let run = match r {
				Ok(None) => V::Obj(forge_guide::obj! { "locale" => locale.as_str(), "scene" => sc.name.as_str(), "skipped" => scene_skip(root, sc).unwrap_or_default() }),
				Ok(Some(json)) => match parse_json(&json) {
					Ok(dump) => check_run(locale, &sc.name, &dump, &allow, &Check { classify: true, baseline: &baseline, full_data: full }, &mut data),
					Err(e) => {
						first_err.get_or_insert(format!("{locale} {}: {e}", sc.name));
						continue;
					}
				},
				Err(e) => {
					first_err.get_or_insert(format!("{locale} {}: {e}", sc.name));
					continue;
				}
			};
			on_result(&run);
			results[i] = Some(run);
		}
	});
	if let Some(e) = first_err {
		return Err(e);
	}
	Ok(results.into_iter().map(|r| r.unwrap_or_default()).collect())
}

/// A leak source's label: where its English came from.
pub fn source_label(s: &V) -> String {
	let w = s.get("where").to_js_string();
	match s.get("kind").to_js_string().as_str() {
		"interface" => {
			let mut key = String::new();
			json_quote(&mut key, &s.get("key").to_js_string());
			format!("interface string not translated ({}): {key}", s.get("addon").to_js_string())
		}
		"guide" => format!("guide text not translated: {}", s.get("guide").to_js_string()),
		"name" => format!("name missing from the names pack, shown at {w}"),
		"kept" => {
			let mut q = String::new();
			json_quote(&mut q, &clip(&s.get("english").to_js_string(), 60));
			format!("English a translation keeps (as in {q}), shown at {w}")
		}
		"unasked" => format!("English name from the guide or data, Polestar.Names not asked, shown at {w}"),
		_ => format!("English in the code: {w}"),
	}
}

/// One group's entry: the locales with an example text each, the scenes and the sites.
pub struct GroupEntry {
	pub locales: Vec<(String, String)>,
	pub scenes: Vec<String>,
	pub sites: Vec<String>,
}

pub struct Group {
	pub key: String,
	pub source: V,
	/// By the English words.
	pub entries: Vec<(String, GroupEntry)>,
}

/// Leaks of many runs grouped by where they came from, then by their English words, the largest group
/// first.
pub fn group_by_source(results: &[Run]) -> Vec<Group> {
	let mut groups: Vec<Group> = Vec::new();
	for r in results {
		let (locale, scene) = (r.get("locale").to_js_string(), r.get("scene").to_js_string());
		for l in list(&r.get("leaks")) {
			let key = source_label(&l.get("source"));
			let gi = match groups.iter().position(|g| g.key == key) {
				Some(i) => i,
				None => {
					groups.push(Group { key: key.clone(), source: l.get("source"), entries: Vec::new() });
					groups.len() - 1
				}
			};
			let g = &mut groups[gi];
			let w = strings(&l.get("words")).join(" ");
			let ei = match g.entries.iter().position(|(x, _)| *x == w) {
				Some(i) => i,
				None => {
					g.entries.push((w, GroupEntry { locales: Vec::new(), scenes: Vec::new(), sites: Vec::new() }));
					g.entries.len() - 1
				}
			};
			let e = &mut g.entries[ei].1;
			if !e.locales.iter().any(|(x, _)| *x == locale) {
				e.locales.push((locale.clone(), l.get("text").to_js_string()));
			}
			for sc in strings(&l.get("scenes")) {
				let s = format!("{scene}: {sc}");
				if !e.scenes.contains(&s) {
					e.scenes.push(s);
				}
			}
			let site = strings(&l.get("site"));
			if site.first().is_some_and(|x| !x.is_empty()) {
				let s = site.join(" < ");
				if !e.sites.contains(&s) {
					e.sites.push(s);
				}
			}
		}
	}
	groups.sort_by(|a, b| b.entries.len().cmp(&a.entries.len()).then_with(|| locale_compare(&a.key, &b.key, false)));
	groups
}

/// The text of `JSON.stringify(s)`.
pub fn quote(text: &str) -> String {
	s(text)
}

/// For the CLI: the label of a run line on stderr.
pub fn run_line(r: &Run) -> String {
	let head = format!("{} {}: ", r.get("locale").to_js_string(), r.get("scene").to_js_string());
	if r.get("skipped").truthy() {
		return format!("{head}skipped ({})", r.get("skipped").to_js_string());
	}
	let errors = list(&r.get("errors")).len();
	format!("{head}{}{}", plural(list(&r.get("leaks")).len(), "English text"), if errors > 0 { format!(", {}", plural(errors, "error")) } else { String::new() })
}

/// The (clipped) text of a group entry's example, as the report shows it.
pub fn example(text: &str) -> String {
	clip(text, 160)
}

/// The count of a run's leaks (None when skipped).
pub fn leak_count(r: &Run) -> usize {
	list(&r.get("leaks")).len()
}

/// A run's leaks.
pub fn run_leaks(r: &Run) -> Vec<V> {
	list(&r.get("leaks"))
}

/// A run's errors.
pub fn run_errors(r: &Run) -> Vec<V> {
	list(&r.get("errors"))
}
