//! #1390: every Polestar frame follows Appearance > Windows > Skin, live. The whole addon is loaded, its frames
//! are built (the flight timer, the instance tracker, the dungeon tracker, the party panel, the confirm dialog,
//! the toasts, the welcome, copy and Materials windows), and the skin is switched through every choice: each
//! skinned frame is painted in the skin in use (one hidden by a closed window above it as that window shows), the
//! floating ones on the window skin (Halo's veil, not a menu's fill), and the quest item and
//! travel buttons' hover wash follows the skin's. A dungeon guide's regions outside the dungeon (the picture, the
//! level, the pick-ups, the way in with its button) follow it too.

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
	out.skins[key] = s
end
emit(out)
"#;

fn run() -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::name("Polestar")], login: true, script: SCRIPT.into(), ..Default::default() }).remove(0)
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
	}
	assert_ne!(skins["polestar"]["wash"], skins["hearth"]["wash"], "the skins' hover washes differ");
	assert!(skins["polestar"]["item"] != json!(false), "the quest item button was built");
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
