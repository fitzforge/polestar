//! The route choice window (addon/Polestar/UI/RouteChoice.lua) against the real Core + Theme + UI manifests and
//! the fake Engine of tests/lua/stub_ui.lua, given the choice data Engine.GetRouteChoice returns.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The choices a test can show, by the guide they follow: a choice whose routes meet again (Tirisfal Glades,
// two routes; Winterspring, three), and a zone choice whose recommended route goes on to a guide of its own
// and whose other, the experimental Riverglades in a zone Forever added, comes back to it (Badlands). A test
// changes CHOICES before it fires; PENDING is the choice the guide window is waiting on.
const CHOICE: &str = r#"
local E = Polestar.Engine
CHOSEN = nil
PENDING = "tirisfal"
local function copy(t)
	if type(t) ~= "table" then return t end
	local o = {}
	for k, v in pairs(t) do o[k] = copy(v) end
	return o
end
CHOICES = {
	tirisfal = { from = "tirisfal", fromTitle = "Tirisfal Glades", recommended = "silverpine", joinsAt = "Stonetalon Mountains", options = {
		{ id = "silverpine", title = "Silverpine Forest", zoneName = "Silverpine Forest", minLevel = 10, maxLevel = 18, recommended = true,
			seconds = 140, quests = 44, pitch = "Undercity's backyard.", pros = { "Compact", "Quiet" }, cons = { "Fewer quests" } },
		{ id = "barrens", title = "The Barrens", zoneName = "The Barrens", minLevel = 10, maxLevel = 20, seconds = 610, quests = 57,
			pitch = "The Horde's crossroads, where every road out of Orgrimmar and Thunder Bluff meets.",
			pros = { "Most quests", "Flight paths", "Dungeon nearby", "Group finder" }, cons = { "Busy", "Long runs", "Kill-stealing" } },
	} },
	badlands = { from = "badlands", fromTitle = "Badlands", recommended = "stv", options = {
		{ id = "stv", title = "Stranglethorn Vale & Swamp of Sorrows", zoneName = "Stranglethorn Vale", minLevel = 39, maxLevel = 43, recommended = true,
			seconds = 720, quests = 41, pitch = "Nesingwary's hunts.", pros = { "Quick to reach" }, cons = { "Busy" },
			thenId = "feralas", thenGuideTitle = "Stranglethorn Vale, Swamp of Sorrows, Tanaris & Feralas", thenLevel = 43 },
		{ id = "riverglades", title = "Riverglades", zoneName = "Riverglades", minLevel = 37, maxLevel = 43, seconds = 540, quests = 69,
			experimental = true, newInForever = true, pitch = "A new Forever zone.", pros = { "All in one zone" }, cons = { "New guide" },
			thenId = "stv", thenGuideTitle = "Stranglethorn Vale & Swamp of Sorrows", thenLevel = 43 },
	} },
	winterspring = { from = "winterspring", fromTitle = "Winterspring", recommended = "epl", joinsAt = "Silithus", options = {
		{ id = "epl", title = "Eastern Plaguelands", minLevel = 54, maxLevel = 56, recommended = true, quests = 30 },
		{ id = "wpl", title = "Western Plaguelands", minLevel = 53, maxLevel = 56, quests = 28 },
		{ id = "hyjal", title = "Mount Hyjal", minLevel = 56, maxLevel = 58, quests = 33, experimental = true },
	} },
}
E.GetRouteChoice = function(id) return copy(CHOICES[id]) end
E.ChooseRoute = function(from, to) CHOSEN = from .. ">" .. to; return true end
E.PendingRouteChoice = function() return PENDING end
RC = Polestar.UI.RouteChoice
function cardFor(id)
	for _, f in ipairs(stub.frames) do if f.psId == id and f:IsShown() and rawget(f, "Facts") then return f end end
end
function shownChips(c)
	local t = {}
	for _, ch in ipairs(c.Chips) do if ch:IsShown() then t[#t + 1] = ch.Text:GetText() end end
	return t
end
-- A string without its colour escapes.
function plain(s) return (tostring(s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
function shownBullets(list) local n = 0 for _, l in ipairs(list) do if l.Text:IsShown() then n = n + 1 end end return n end
local function bytes(r, g, b) return { math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5) } end
function colorOf(fs) return bytes(fs:GetTextColor()) end
function tokenOf(name) return bytes(Polestar.Theme.Color(name)) end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &FILES)], script: ["uistub.install()", "stub.login()", CHOICE, script].join("\n"), ..Default::default() })
		.remove(0)
}

#[test]
fn route_choice_opens_one_card_per_zone_its_rows_at_one_height_across_cards_3_pros_and_1_con_the_recommended_one_leads() {
	let out = run(r#"
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		local F = PolestarRouteChoice
		local s, b = cardFor("silverpine"), cardFor("barrens")
		local function y(region) local _, _, _, _, py = region:GetPoint(1) return py end
		stub.RunScript(b, "OnEnter")
		local tip = GameTooltip.lines
		emit({
			shown = F:IsShown(), subtitle = F.Subtitle:GetText(),
			names = { s.Name:GetText(), b.Name:GetText() },
			facts = { plain(s.Facts:GetText()), plain(b.Facts:GetText()) },
			trip = s.Facts:GetText(), textHex = Polestar.Theme.Hex("text"),
			factsY = { y(s.Facts), y(b.Facts) }, pitchY = { y(s.Pitch), y(b.Pitch) }, ruleY = { y(s.Rule), y(b.Rule) },
			prosY = { y(s.Pros[1].Text), y(b.Pros[1].Text) }, consY = { y(s.Cons[1].Text), y(b.Cons[1].Text) },
			chips = { shownChips(s), #shownChips(b) },
			pros = { s.Pros[1].Text:GetText(), s.Pros[2].Text:GetText() }, con = b.Cons[1].Text:GetText(),
			bShown = { pros = shownBullets(b.Pros), cons = shownBullets(b.Cons) },
			tip = tip, closeTip = F.Close.psTip,
			primary = s.Go.psPrimary or false, otherPrimary = b.Go.psPrimary or false,
			ring = { s.Ring[1]:IsShown(), b.Ring[1]:IsShown() },
			button = s.Go.Label:GetText(), sameHeight = s:GetHeight() == b:GetHeight(),
			goY = { select(5, s.Go:GetPoint(1)), select(5, b.Go:GetPoint(1)) },
		})"#);
	assert_eq!(out["shown"], true);
	assert_eq!(out["subtitle"], "You finished Tirisfal Glades. Both routes meet again in Stonetalon Mountains.");
	assert_eq!(out["names"], json!(["Silverpine Forest", "The Barrens"]));
	assert_eq!(out["facts"], json!(["10–18  ·  ≈2 min away  ·  44 quests", "10–20  ·  ≈10 min away  ·  57 quests"]), "one line: the levels, the trip, the quests");
	assert!(text(&out["trip"]).contains(&format!("|c{}≈2|r", text(&out["textHex"]))), "the number (with its \"about\" sign) in text, the words dim: {}", out["trip"]);
	for row in ["factsY", "pitchY", "ruleY", "prosY", "consY", "goY"] {
		assert_eq!(out[row][0], out[row][1], "{row}: every row at one height on both cards (one card without a chip, pitches of different lengths)");
	}
	assert_eq!(out["chips"], json!([["Recommended"], 0]));
	assert_eq!(out["pros"], json!(["Compact", "Quiet"]));
	assert_eq!(out["con"], "Busy");
	assert_eq!(out["bShown"], json!({ "pros": 3, "cons": 1 }), "at most 3 pros and 1 con on the card");
	let tip = out["tip"].as_array().unwrap();
	assert!(tip.iter().any(|l| is_match(text(l), "Group finder")) && tip.iter().any(|l| is_match(text(l), "Kill-stealing")), "the full lists are in the tooltip");
	assert!(tip.iter().any(|l| text(l) == "10–20  ·  ≈10 min away  ·  57 quests"), "the facts whole in the tooltip: {tip:?}");
	assert_eq!(out["closeTip"], "Close");
	assert_eq!(out["primary"], true);
	assert_eq!(out["otherPrimary"], false);
	assert_eq!(out["ring"], json!([true, false]), "the recommended card's accent outline");
	assert_eq!(out["button"], "Level in Silverpine Forest");
	assert_eq!(out["sameHeight"], true);
}

// A pro or con stays on one line: one too long for the card is cut (the tooltip has it whole), never wrapped, so
// the rows and buttons line up whatever the copy. A window taller than the screen (a large UI scale) shrinks to fit.
#[test]
fn a_long_pro_stays_on_one_line_the_cards_stay_aligned_and_a_window_taller_than_the_screen_shrinks_to_fit() {
	let out = run(r#"
		local long = "One zone and one hub, Farholde Keep with its flight path and inn, in place of Desolace's south loop"
		CHOICES.badlands.options[2].pros = { long, "Short" }
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local F = PolestarRouteChoice
		local s, r = cardFor("stv"), cardFor("riverglades")
		local function y(region) local _, _, _, _, py = region:GetPoint(1) return py end
		local p1 = r.Pros[1].Text
		local out = {
			oneLine = not p1:GetWordWrap(), cut = p1:IsTruncated(), text = p1:GetText(),
			step = y(r.Pros[2].Text) - y(p1), consY = { y(s.Cons[1].Text), y(r.Cons[1].Text) }, sameHeight = s:GetHeight() == r:GetHeight(),
			goY = { y(s.Go), y(r.Go) }, scale = F:GetScale(),
		}
		RC.Hide()
		UIParent.height = 600
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		out.small = { scale = F:GetScale(), fits = F:GetHeight() * F:GetScale() <= 600 - 32 + 0.01 }
		UIParent.height = 1080
		emit(out)"#);
	assert_eq!(out["oneLine"], true, "the long pro keeps to one line: {out}");
	assert_eq!(out["cut"], true, "cut with an ellipsis");
	assert_eq!(out["step"], -18, "the next pro one line below");
	assert_eq!(out["consY"][0], out["consY"][1], "cons start on the same line");
	assert_eq!(out["sameHeight"], true);
	assert_eq!(out["goY"][0], out["goY"][1], "the buttons line up");
	assert_eq!(out["scale"], 1.0, "on a 1080 screen it fits as it is");
	assert!(out["small"]["scale"].as_f64().unwrap() < 1.0, "{out}");
	assert_eq!(out["small"]["fits"], true, "shrunk to fit a short screen: {out}");
}

#[test]
fn the_header_says_where_the_routes_meet_again_or_which_route_comes_back_to_another_else_asks_where_to_level_next() {
	let out = run(r#"
		local out = {}
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		out.two = PolestarRouteChoice.Subtitle:GetText()
		PENDING = "winterspring"
		Polestar.Fire("ROUTE_CHOICE", "winterspring")
		out.three = PolestarRouteChoice.Subtitle:GetText()
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		out.back = PolestarRouteChoice.Subtitle:GetText()
		CHOICES.badlands.options[2].thenId = "ungoro"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		out.own = PolestarRouteChoice.Subtitle:GetText()
		-- Opened again from /polestar path while the guide window waits on another choice: no "You finished".
		PENDING = "tirisfal"
		RC.Show("badlands")
		out.again = PolestarRouteChoice.Subtitle:GetText()
		emit(out)"#);
	assert_eq!(
		out,
		json!({
			"two": "You finished Tirisfal Glades. Both routes meet again in Stonetalon Mountains.",
			"three": "You finished Winterspring. Every route meets again in Silithus.",
			"back": "You finished Badlands. Riverglades brings you back to Stranglethorn Vale.",
			"own": "You finished Badlands. Pick where you want to level next.",
			"again": "Pick where you want to level next.",
		})
	);
}

#[test]
fn the_chips_say_recommended_or_experimental_and_new_in_forever_every_button_says_level_in_the_open_route_keeps() {
	let out = run(r#"
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local s, r = cardFor("stv"), cardFor("riverglades")
		local function card(c)
			return { chips = shownChips(c), chipColor = colorOf(c.Chips[1].Text), go = c.Go.Label:GetText(),
				primary = c.Go.psPrimary or false, ring = c.Ring[1]:IsShown(), thenRow = rawget(c, "Then") ~= nil }
		end
		local out = { stv = card(s), riverglades = card(r), accent = tokenOf("accent"), experimental = tokenOf("experimental") }
		local fc = r.Chips[2]
		local _, rel, relPoint = fc.Mark:GetPoint(1)
		out.foreverChip = { mark = fc.Mark:IsShown(), tex = fc.Mark:GetTexture(), beforeText = rel == fc.Text and relPoint == "LEFT",
			firstMark = r.Chips[1].Mark:IsShown() }
		-- The route open now says so, and keeps it. A guide with a pitch only: no rule over pros and cons, the
		-- cards keep one height and their buttons one line.
		CHOICES.badlands.options[1].open = true
		CHOICES.badlands.options[1].pros, CHOICES.badlands.options[1].cons = nil, nil
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		s, r = cardFor("stv"), cardFor("riverglades")
		out.lone = { sameHeight = s:GetHeight() == r:GetHeight(), goY = { select(5, s.Go:GetPoint(1)), select(5, r.Go:GetPoint(1)) },
			rules = { s.Rule:IsShown(), r.Rule:IsShown() } }
		out.open = { chips = shownChips(s), go = s.Go.Label:GetText(), primary = s.Go.psPrimary or false }
		emit(out)"#);
	assert_eq!(out["stv"]["chips"], json!(["Recommended"]));
	assert_eq!(out["stv"]["chipColor"], out["accent"]);
	assert_eq!(out["stv"]["go"], "Level in Stranglethorn Vale");
	assert_eq!(out["stv"]["primary"], true);
	assert_eq!(out["stv"]["ring"], true);
	assert_eq!(out["stv"]["thenRow"], false, "no Then row: the header says where the routes go on");
	assert_eq!(out["riverglades"]["chips"], json!(["Experimental", "New in Forever"]));
	assert_eq!(out["riverglades"]["chipColor"], out["experimental"], "the experimental chip in its own purple");
	assert_eq!(out["riverglades"]["go"], "Level in Riverglades");
	assert_eq!(out["riverglades"]["primary"], false, "an experimental guide is never the one the window leads with");
	assert_eq!(out["riverglades"]["ring"], false);
	assert_eq!(out["foreverChip"]["mark"], true);
	assert!(text(&out["foreverChip"]["tex"]).ends_with("icon-forever"), "{}", out["foreverChip"]["tex"]);
	assert_eq!(out["foreverChip"]["beforeText"], true, "the mark before \"New in Forever\"");
	assert_eq!(out["foreverChip"]["firstMark"], false);
	assert_eq!(out["lone"]["sameHeight"], true);
	assert_eq!(out["lone"]["goY"][0], out["lone"]["goY"][1], "the buttons line up");
	assert_eq!(out["lone"]["rules"], json!([false, true]), "no rule over an empty list");
	assert_eq!(out["open"], json!({ "chips": ["Your current route"], "go": "Keep this route", "primary": false }));
}

#[test]
fn the_forever_mark_follows_the_name_of_a_zone_forever_added_and_the_new_in_forever_setting() {
	let out = run(r#"
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local s, r = cardFor("stv"), cardFor("riverglades")
		local m = r.Mark
		local point, rel, relPoint, x = m:GetPoint(1)
		local out = { shown = { r.Mark:IsShown(), s.Mark:IsShown() }, after = rel == r.Name and point == "LEFT" and relPoint == "RIGHT" and x > 0,
			onArt = m:GetParent() == r.Art.Over, tex = m:GetTexture(), nameCut = r.Name:IsTruncated() }
		-- The setting that shows the mark beside quests, changed while the window is open.
		Polestar.Set("ui.newInForever", false)
		out.off = { mark = r.Mark:IsShown(), chips = shownChips(r) }
		Polestar.Set("ui.newInForever", true)
		out.on = { mark = r.Mark:IsShown(), chips = shownChips(r) }
		-- A name too long for the painting is cut; the mark stays on it, right after.
		CHOICES.badlands.options[2].zoneName = "The Shimmering Riverglades of the Southern Badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		r = cardFor("riverglades")
		out.long = { cut = r.Name:IsTruncated(), fits = r.Name:GetWidth() + 8 + r.Mark:GetWidth() <= r.Art:GetWidth() - 16 + 0.01 }
		emit(out)"#);
	assert_eq!(out["shown"], json!([true, false]), "on Riverglades only");
	assert_eq!(out["after"], true, "right after the zone's name");
	assert_eq!(out["onArt"], true);
	assert!(text(&out["tex"]).ends_with("icon-forever"), "the mark beside quests: {}", out["tex"]);
	assert_eq!(out["nameCut"], false);
	assert_eq!(out["off"], json!({ "mark": false, "chips": ["Experimental"] }));
	assert_eq!(out["on"], json!({ "mark": true, "chips": ["Experimental", "New in Forever"] }));
	assert_eq!(out["long"], json!({ "cut": true, "fits": true }));
}

#[test]
fn the_card_shows_the_authors_con_its_tooltip_every_con_a_detour_first_and_the_guide_the_route_goes_on_to() {
	let out = run(r#"
		CHOICES.badlands.options[2].detour = "Desolace"
		CHOICES.badlands.options[2].cons = { "New guide", "Long" }
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local r = cardFor("riverglades")
		stub.RunScript(r, "OnEnter")
		local out = { con = r.Cons[1].Text:GetText(), consShown = shownBullets(r.Cons), tip = GameTooltip.lines }
		-- Routes that meet again: the header says where, no tooltip repeats it.
		PENDING = "tirisfal"
		CHOICES.tirisfal.options[2].thenGuideTitle = "Stonetalon Mountains"
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		stub.RunScript(cardFor("barrens"), "OnEnter")
		out.joinedTip = GameTooltip.lines
		emit(out)"#);
	assert_eq!(out["con"], "New guide");
	assert_eq!(out["consShown"], 1);
	let tip: Vec<&str> = out["tip"].as_array().unwrap().iter().map(text).collect();
	assert_eq!(tip[0], "Riverglades");
	let detour = tip.iter().position(|l| l.ends_with("A detour through Desolace")).expect("the detour in the tooltip");
	let first = tip.iter().position(|l| l.ends_with("New guide")).unwrap();
	assert!(detour < first, "the detour first: {tip:?}");
	assert!(tip.iter().any(|l| l.ends_with("Long")), "every con in the tooltip: {tip:?}");
	assert!(tip.contains(&"Then: Stranglethorn Vale & Swamp of Sorrows  ·  Level 43"), "the next guide whole: {tip:?}");
	let joined: Vec<&str> = out["joinedTip"].as_array().unwrap().iter().map(text).collect();
	assert!(!joined.iter().any(|l| l.starts_with("Then:")), "{joined:?}");
}

#[test]
fn the_facts_say_right_here_or_far_away_and_leave_out_what_is_not_known() {
	let out = run(r#"
		local o = CHOICES.badlands.options
		o[1].seconds, o[2].seconds = 30, 6000
		o[2].quests = nil
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local s, r = cardFor("stv"), cardFor("riverglades")
		stub.RunScript(r, "OnEnter")
		emit({ stv = plain(s.Facts:GetText()), riverglades = plain(r.Facts:GetText()), tip = GameTooltip.lines[2] })"#);
	assert_eq!(out["stv"], "39–43  ·  Right here  ·  41 quests");
	assert_eq!(out["riverglades"], "37–43  ·  Far away", "no quest count: nothing for it");
	assert_eq!(out["tip"], "37–43  ·  A long trip from here");
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
