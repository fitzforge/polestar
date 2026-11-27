//! #1390: every Polestar frame follows Appearance > Windows > Skin, live. The whole addon is loaded, its frames
//! are built (the flight timer, the instance tracker, the dungeon tracker, the party panel, the confirm dialog,
//! the toasts, the welcome, copy and Materials windows), and the skin is switched through every choice: each
//! skinned frame is painted in the skin in use (one hidden by a closed window above it as that window shows), the
//! floating ones on the window skin (Halo's veil, not a menu's fill), and the quest item and
//! travel buttons' hover wash follows the skin's. A dungeon guide's regions outside the dungeon (the picture, the
//! level, the pick-ups, the way in with its button) follow it too.
//! A profession guide's regions (UI/GuideFrameKindCraft.lua) are swept too: the craft row's Open button, a way's
//! button and the shopping list's button, in every built-in look and every look of Polestar_Skins.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const SCRIPT: &str = r#"
local T, W = Polestar.Theme, Polestar.Widgets
T._testShowHidden = true
-- Build what is built on demand. The party panel shows only with someone in the party heard running Polestar.
Polestar.Party.IsLive = function() return true end
Polestar.Party.Roster = function() return { { name = "Ana", unit = "party1", level = 12 } } end
Polestar.Set("party.panel", true)
W.Modal({ title = "Reset?", text = "Sure?", action = "Reset" })
Polestar.Nav.alerts.ShowSample()
Polestar.Rares.Toast.Show({ kind = "rare", name = "Mother Fang", map = 1429, x = 50, y = 50 })
Polestar.UI.ShowCopy("Copy", "text")
Polestar.UI.Materials.Show()
-- The dungeon tracker on its sample run (UI/DungeonTracker.lua), floating: the guide window is not shown.
Polestar.UI.DungeonTracker.ShowSample()
-- A profession guide in the guide window (its kind's regions, UI/GuideFrameKindCraft.lua): Tailoring 87, the craft
-- step's Open Tailoring, the get step's ways with their buttons, the shopping list's Buy the whole list.
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "test/craft", pack = "test", title = "Tailoring 1-300", minLevel = 5, maxLevel = 60, category = "Professions",
	sections = { { skill = "Tailoring", skillLine = 197, from = 75, to = 150 } },
	steps = {
		{ title = "Get Wool Cloth", section = 1, goals = {
			{ t = "collect", item = 2592, itemName = "Wool Cloth", count = 288, gather = { min = 15, max = 30 } },
			{ t = "auction", item = 2592, itemName = "Wool Cloth", count = 288 } } },
		{ title = "Woolen Cape to 100", section = 1, goals = { { t = "craft", spell = 2402, spellName = "Woolen Cape", item = 2584, itemName = "Woolen Cape",
			skillLine = 197, untilSkill = 100, yellow = 80, grey = 115, reagents = { { item = 2592, itemName = "Wool Cloth", count = 3 } } } } },
	} })
Polestar.Compat.GetSkillRank = function(line) if line == 197 or line == "Tailoring" then return 87, 150 end return nil end
w.items[2592] = 9
Polestar.Set("ui.shown", true)
Polestar.Engine.SetGuide("test/craft")
stub.advance(1)
local GF = Polestar.UI.GuideFrame
Polestar.Engine.Goto(2); stub.advance(0.5)
GF.Render(); GF.Layout()
Polestar.Engine.Goto(1); stub.advance(0.5)
GF.Render(); GF.Layout()
local stretch, get, shop = GF.RegionFrame("stretch"), GF.RegionFrame("get"), GF.RegionFrame("shopping")
local kind = {
	open = stretch and stretch.Row.psOpen, way = get and get.Ways[1] and get.Ways[1].psButton, buy = shop and shop.Buy,
}
local function kindSkins()
	local k = {}
	for name, f in pairs(kind) do k[name] = f and f.psSkin and f.psSkin.skin or false end
	return k
end
-- The swept frames by global name: a name that is gone (a renamed frame) is reported missing, not skipped.
local NAMES = {
	timer = "PolestarFlightTimer", tracker = "PolestarInstanceTracker", party = "PolestarPartyPanel",
	modal = "PolestarModal", transit = "PolestarAlert", rare = "PolestarRareToast", copy = "PolestarCopy",
	materials = "PolestarMaterials", dungeon = "PolestarDungeonTracker",
}
local named, missing = {}, {}
for k, name in pairs(NAMES) do
	local f = _G[name]
	if f and k == "modal" then f = f.Box end
	if f then named[k] = f else missing[#missing + 1] = k end
end
table.sort(missing)
-- Every frame a skin painted.
local painted = {}
for _, f in ipairs(stub.frames) do if rawget(f, "psSkin") then painted[#painted + 1] = f end end
local function hover(b) local hl = b and rawget(b, "Hl"); return hl and { hl:GetVertexColor() } or false end
local out = { missing = table.concat(missing, ","), painted = #painted, skins = {} }
for _, key in ipairs(T.SKIN_ORDER) do
	Polestar.Set("ui.skin", key)
	-- Every skinned frame in the skin in use: one that shows at once, one hidden by a frame above it (a
	-- closed window's part) as that frame shows (each hidden frame above it shown, then hidden again).
	local stale = 0
	for _, f in ipairs(painted) do
		if f.psSkin.skin ~= key then
			if f:IsVisible() then
				stale = stale + 1
			else
				local up, p = {}, f:GetParent()
				while p do
					if not p:IsShown() then up[#up + 1] = p end
					p = p:GetParent()
				end
				for i = #up, 1, -1 do up[i]:Show() end
				if f.psSkin.skin ~= key then stale = stale + 1 end
				for i = 1, #up do up[i]:Hide() end
			end
		end
	end
	local s = { stale = stale, frames = {} }
	for k, f in pairs(named) do
		local d = f.psSkin
		s.frames[k] = {
			skin = d and d.skin or false,
			veil = d and d.veil ~= nil and d.veil:IsShown() or false,
			shadow = f.psShadow ~= nil and f.psShadow:IsShown() or false,
		}
	end
	s.item = hover(PolestarQuestItemButton)
	s.travel = hover(PolestarTravelButton)
	s.wash = { T.Wash("hover") }
	s.kind = kindSkins()
	out.skins[key] = s
end
-- Our skins (Polestar_Skins): the guide kinds' parts painted in each.
out.own = {}
for _, key in ipairs({ "vellum", "lumen", "beacon", "aurora", "hairline", "umbra", "waymark", "lanterns", "sheen", "atlas" }) do
	Polestar.Set("ui.skin", key)
	out.own[key] = { registered = T.SkinInfo(key) ~= nil, kind = kindSkins() }
end
emit(out)
"#;

fn run() -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Skins")],
		login: true,
		script: SCRIPT.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn switching_the_skin_restyles_the_flight_timer_and_every_polestar_frame_live_1390() {
	let out = run();
	assert_eq!(out["missing"], "", "every swept frame was built");
	assert!(out["painted"].as_u64().unwrap() > 10, "the sweep saw the skinned frames: {}", out["painted"]);
	let skins = out["skins"].as_object().unwrap();
	assert_eq!(skins.len(), 6);
	for (key, s) in skins {
		assert_eq!(s["stale"], 0, "{key}: every skinned frame repainted in the skin in use");
		let frames = s["frames"].as_object().unwrap();
		assert_eq!(frames.len(), 9, "{key}: every swept frame reported");
		for (name, f) in frames {
			assert_eq!(f["skin"], json!(key), "{key}: {name} painted in it");
			// The window skin: Halo's soft veil (a panel would take the menu fill), the house drop shadow.
			assert_eq!(f["veil"], json!(key == "halo"), "{key}: {name} on the window skin");
			if key == "polestar" {
				assert_eq!(f["shadow"], true, "{name}: the house window's shadow");
			}
		}
		for b in ["item", "travel"] {
			if s[b] != json!(false) {
				assert_eq!(s[b], s["wash"], "{key}: the {b} button's hover wash is the skin's");
			}
		}
		// The guide kinds' parts (UI/GuideFrameKindCraft.lua): the craft row's Open button, a way's button and the
		// shopping list's button, each in the skin in use.
		let kind = s["kind"].as_object().unwrap();
		assert_eq!(kind.len(), 3, "{key}: every kind part reported");
		for (name, skin) in kind {
			assert_eq!(skin, &json!(key), "{key}: the profession guide's {name} painted in it");
		}
	}
	assert_ne!(skins["polestar"]["wash"], skins["hearth"]["wash"], "the skins' hover washes differ");
	assert!(skins["polestar"]["item"] != json!(false), "the quest item button was built");
	let own = out["own"].as_object().unwrap();
	assert_eq!(own.len(), 10, "every skin of Polestar_Skins swept");
	for (key, s) in own {
		assert_eq!(s["registered"], true, "{key}: registered");
		for (name, skin) in s["kind"].as_object().unwrap() {
			// A skin drawn over another's painters names both ("atlas/polestar").
			let skin = skin.as_str().unwrap_or("");
			assert!(skin == key || skin.starts_with(&format!("{key}/")), "{key}: the profession guide's {name} painted in it: {skin}");
		}
	}
}

// A dungeon guide outside its dungeon (Core/KindDungeon.lua, UI/GuideFrameKindDungeon.lua): its regions in the
// window, the way in's button painted in each skin as it changes.
const DUNGEON_GUIDE: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.moveTo(1413, 52, 30)
local PAGE = { key = "wailing-caverns", name = "Wailing Caverns", map = 43, minLevel = 17, maxLevel = 24, floor = 17, players = 5,
	zoneName = "The Barrens", entrance = { map = 1413, x = 46, y = 36 } }
local D = Polestar.Dungeons
D.Load = function() return true end
D.Get = function(key) return key == PAGE.key and PAGE or nil end
D.BestAt = function() return 20 end
D.Entrance = function() return 1413, 46, 36 end
D.Attunements = function() return {} end
D.PickupPlan = function() return { dungeon = PAGE, take = {}, carried = { { id = 914 } }, skipped = {}, later = 0 } end
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "test/wc", pack = "test", title = "Wailing Caverns", kind = "dungeon", dungeon = "wailing-caverns",
	minLevel = 17, maxLevel = 24, steps = { { title = "Wailing Caverns", goals = { { t = "goto", text = "Wailing Caverns", map = 1413, x = 46, y = 36, entrance = true } } } } })
Polestar.Set("ui.shown", true)
Polestar.Engine.SetGuide("test/wc")
stub.advance(1)
local GF = Polestar.UI.GuideFrame
GF.Render()
local out = { regions = {}, skins = {} }
for _, id in ipairs({ "brief", "ready", "pickups", "entrance" }) do out.regions[id] = GF.RegionShown(id) end
local go = GF.RegionFrame("entrance").Go
for _, key in ipairs(Polestar.Theme.SKIN_ORDER) do
	Polestar.Set("ui.skin", key)
	out.skins[key] = { go = go.psSkin and go.psSkin.skin or false, shown = go:IsVisible() }
end
emit(out)
"#;

#[test]
fn a_dungeon_guides_regions_follow_the_skin() {
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::name("Polestar")], login: true, script: DUNGEON_GUIDE.into(), ..Default::default() }).remove(0);
	assert_eq!(out["regions"], json!({ "brief": true, "ready": true, "pickups": true, "entrance": true }), "the four regions show");
	for (key, s) in out["skins"].as_object().unwrap() {
		assert_eq!(s["shown"], true, "{key}: Guide me to the entrance shows");
		assert_eq!(s["go"], json!(key), "{key}: Guide me to the entrance painted in it");
	}
}
