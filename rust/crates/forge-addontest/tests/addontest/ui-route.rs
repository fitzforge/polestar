//! The route choice window (addon/Polestar/UI/RouteChoice.lua) against the real Core + Theme + UI manifests and
//! the fake Engine of tests/lua/stub_ui.lua, given the choice data Engine.GetRouteChoice returns.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const CHOICE: &str = r#"
local E = Polestar.Engine
CHOSEN = nil
E.GetRouteChoice = function(id)
	if id ~= "tirisfal" then return nil end
	return { from = "tirisfal", fromTitle = "Tirisfal Glades", recommended = "silverpine", joinsAt = "Stonetalon Mountains", options = {
		{ id = "silverpine", title = "Silverpine Forest", zoneName = "Silverpine Forest", minLevel = 10, maxLevel = 18, recommended = true,
			seconds = 140, quests = 44, pitch = "Undercity's backyard.", pros = { "Compact", "Quiet" }, cons = { "Fewer quests" } },
		{ id = "barrens", title = "The Barrens", zoneName = "The Barrens", minLevel = 10, maxLevel = 20, seconds = 610, quests = 57,
			pitch = "The Horde's crossroads, where every road out of Orgrimmar and Thunder Bluff meets.",
			pros = { "Most quests", "Flight paths", "Dungeon nearby", "Group finder" }, cons = { "Busy", "Long runs", "Kill-stealing" } },
	} }
end
E.ChooseRoute = function(from, to) CHOSEN = from .. ">" .. to; return true end
E.PendingRouteChoice = function() return "tirisfal" end
RC = Polestar.UI.RouteChoice
function cardFor(id)
	for _, f in ipairs(stub.frames) do if f.psId == id and f:IsShown() then return f end end
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &FILES)], script: ["uistub.install()", "stub.login()", CHOICE, script].join("\n"), ..Default::default() })
		.remove(0)
}

#[test]
fn route_choice_opens_one_card_per_zone_a_stat_row_on_one_line_across_cards_capped_pros_and_cons_the_recommended_one_leads() {
	let out = run(r#"
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		local F = PolestarRouteChoice
		local s, b = cardFor("silverpine"), cardFor("barrens")
		local function y(region) local _, _, _, _, py = region:GetPoint(1) return py end
		local function shown(list) local n = 0 for _, l in ipairs(list) do if l.Text:IsShown() then n = n + 1 end end return n end
		stub.RunScript(b, "OnEnter")
		local tip = GameTooltip.lines
		emit({
			shown = F:IsShown(), subtitle = F.Subtitle:GetText(),
			names = { s.Name:GetText(), b.Name:GetText() },
			stats = s.Stats:GetText(), textHex = Polestar.Theme.Hex("text"),
			statsY = { y(s.Stats), y(b.Stats) }, ruleY = { y(s.Rule), y(b.Rule) }, consY = { y(s.Cons[1].Text), y(b.Cons[1].Text) },
			tag = s.Tag:IsShown() and s.Tag.Text:GetText(), otherTag = b.Tag:IsShown(),
			pros = { s.Pros[1].Text:GetText(), s.Pros[2].Text:GetText() }, cons = b.Cons[2].Text:GetText(),
			bShown = { pros = shown(b.Pros), cons = shown(b.Cons) },
			tip = tip, closeTip = F.Close.psTip,
			primary = s.Go.psPrimary or false, otherPrimary = b.Go.psPrimary or false,
			button = s.Go.Label:GetText(), sameHeight = s:GetHeight() == b:GetHeight(),
		})"#);
	assert_eq!(out["shown"], true);
	assert_eq!(out["subtitle"], "You finished Tirisfal Glades. Both routes meet again in Stonetalon Mountains.");
	assert_eq!(out["names"], json!(["Silverpine Forest", "The Barrens"]));
	let stats = format!("|c{}10–18|r  ·  ~2 min away  ·  44 quests", text(&out["textHex"]));
	assert_eq!(out["stats"], stats.as_str(), "levels in text, then travel and quests");
	assert_eq!(out["statsY"][0], out["statsY"][1], "the stat rows line up");
	assert_eq!(out["ruleY"][0], out["ruleY"][1], "pitches of different lengths still meet one rule");
	assert_eq!(out["consY"][0], out["consY"][1], "cons start on the same line");
	assert_eq!(out["tag"], "Recommended");
	assert_eq!(out["otherTag"], false);
	assert_eq!(out["pros"], json!(["Compact", "Quiet"]));
	assert_eq!(out["cons"], "Long runs");
	assert_eq!(out["bShown"], json!({ "pros": 3, "cons": 2 }), "at most 3 pros and 2 cons on the card, one line each");
	let tip = out["tip"].as_array().unwrap();
	assert!(tip.iter().any(|l| is_match(text(l), "Group finder")) && tip.iter().any(|l| is_match(text(l), "Kill-stealing")), "the full lists are in the tooltip");
	assert_eq!(out["closeTip"], "Close");
	assert_eq!(out["primary"], true);
	assert_eq!(out["otherPrimary"], false);
	assert_eq!(out["button"], "Level in Silverpine Forest");
	assert_eq!(out["sameHeight"], true);
}

#[test]
fn choosing_a_card_calls_engine_chooseroute_and_closes_decide_later_only_closes() {
	let out = run(r#"
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		stub.RunScript(cardFor("barrens").Go, "OnClick", "LeftButton")
		local r = { chosen = CHOSEN, shown = PolestarRouteChoice:IsShown() }
		CHOSEN = nil
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		stub.RunScript(PolestarRouteChoice.Later, "OnClick", "LeftButton")
		r.later = { chosen = CHOSEN, shown = PolestarRouteChoice:IsShown() }
		emit(r)"#);
	assert_eq!(out, json!({ "chosen": "tirisfal>barrens", "shown": false, "later": { "shown": false } }));
}

#[test]
fn in_combat_the_window_waits_for_the_fight_to_end_the_checkbox_sets_behavior_routechoice() {
	let out = run(r#"
		stub.inCombat = true
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		local r = { during = PolestarRouteChoice ~= nil and PolestarRouteChoice:IsShown() or false }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		r.after = PolestarRouteChoice:IsShown()
		local box = PolestarRouteChoice.Always
		box:SetChecked(true)
		stub.RunScript(box, "OnClick", "LeftButton")
		r.setting = Polestar.Get("behavior.routeChoice")
		r.unknown = RC.Show("elsewhere")
		emit(r)"#);
	assert_eq!(out, json!({ "during": false, "after": true, "setting": "recommended", "unknown": false }));
}

#[test]
fn each_card_shows_its_zone_painting_from_the_client_framed_on_the_route_start_unknown_maps_get_the_night_band() {
	let out = run(r#"
		-- The client's map art: Silverpine (1421) is a 4 x 3 grid of 256px tiles over a 1002 x 668 painting.
		C_Map = C_Map or {}
		C_Map.GetMapArtLayers = function(id)
			if id == 1421 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256, minScale = 1, maxScale = 1, additionalZoomSteps = 0 } } end
			return {}
		end
		C_Map.GetMapArtLayerTextures = function(id, layer)
			local t = {}
			for i = 1, 12 do t[i] = 100000 + i end
			return t
		end
		local real = Polestar.Engine.GetRouteChoice
		Polestar.Engine.GetRouteChoice = function(id)
			local c = real(id)
			if c then
				c.options[1].zone, c.options[1].focusX, c.options[1].focusY = 1421, 45, 42
				c.options[2].zone = 9999
			end
			return c
		end
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		local s, b = cardFor("silverpine"), cardFor("barrens")
		local a = s.Art
		local tiles = {}
		for _, t in ipairs(a.Tiles) do
			if t:IsShown() then
				local _, _, _, tx, ty = t:GetPoint(1)
				tiles[#tiles + 1] = { t:GetTexture(), tx, ty }
			end
		end
		local _, _, _, cx, cy = a.Canvas:GetPoint(1)
		local bShown = 0
		for _, t in ipairs(b.Art.Tiles) do if t:IsShown() then bShown = bShown + 1 end end
		emit({ tiles = tiles, focusY = a.psFocusY,
			tileW = a.Tiles[1]:GetWidth(), canvas = { a.Canvas:GetWidth(), a.Canvas:GetHeight() }, offset = { cx, cy },
			artW = a:GetWidth(), artH = a:GetHeight(), band = a.Band:IsShown(), painted = s.psArt,
			other = { painted = b.psArt, band = b.Art.Band:IsShown(), tiles = bShown },
			name = s.Name:GetText(), nameOnArt = s.Name:GetParent() == a.Over })"#);
	assert_eq!(out["painted"], true);
	assert_eq!(out["band"], false);
	let f = |v: &Value| v.as_f64().unwrap();
	let (cw, ch) = (f(&out["canvas"][0]), f(&out["canvas"][1]));
	let s = cw / 1002.0;
	// Only the tiles the card shows, each the row-major file for its place.
	let tiles = out["tiles"].as_array().unwrap();
	assert!(!tiles.is_empty() && tiles.len() < 12, "{} tiles", tiles.len());
	for t in tiles {
		let file = t[0].as_i64().unwrap();
		let (tx, ty) = (f(&t[1]), f(&t[2]));
		let i = file - 100001;
		assert!((tx - (i % 4) as f64 * 256.0 * s).abs() < 0.01 && (ty + (i / 4) as f64 * 256.0 * s).abs() < 0.01, "tile {file}");
	}
	// Zoomed past "fits the card"; the start (45%, 42%) mid-card and in the clear stretch, never past the painting's edges.
	let (aw, ah) = (f(&out["artW"]), f(&out["artH"]));
	assert!(cw > 2.0 * aw && (cw / ch - 1002.0 / 668.0).abs() < 0.01, "canvas {cw} x {ch}");
	assert!((f(&out["tileW"]) - (256.0 * cw) / 1002.0).abs() < 0.01);
	let (x, y) = (f(&out["offset"][0]), f(&out["offset"][1]));
	assert!((aw - cw..=0.0).contains(&x), "x {x}");
	assert!((0.0..=ch - ah).contains(&y), "y {y}");
	assert!((-x + aw / 2.0 - 0.45 * cw).abs() < 0.5, "the start is centred horizontally");
	assert!((0.42 * ch - y - f(&out["focusY"])).abs() < 0.5, "and sits between the top shade and the fade");
	// A map the client has no art for: the night band, no tiles.
	assert_eq!(out["other"], json!({ "painted": false, "band": true, "tiles": 0 }));
	assert_eq!(out["name"], "Silverpine Forest");
	assert_eq!(out["nameOnArt"], true);
}
