//! The route choice window (addon/Polestar/UI/RouteChoice.lua) against the real Core + Theme + UI manifests and
//! the fake Engine of tests/lua/stub_ui.lua, given the choice data Engine.GetRouteChoice returns.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];
// With the map pins (Nav), which draw each route's start on its painting.
const PIN_FILES: [&str; 4] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "UI/UI.xml"];

// The choices a test can show, by the guide they follow: a choice whose routes meet again (Tirisfal Glades,
// two routes; Winterspring, three), and a zone choice whose routes each go on to a guide of their own
// (Badlands: Stranglethorn Vale, or the experimental Riverglades in a zone Forever added). A test changes
// CHOICES before it fires; PENDING is the choice the guide window is waiting on.
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
			thenId = "feralas", thenGuideTitle = "Feralas & Tanaris", thenLevel = 43 },
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
	for _, f in ipairs(stub.frames) do if f.psId == id and f:IsShown() and rawget(f, "Pennant") then return f end end
end
-- A string without its colour escapes.
function plain(s) return (tostring(s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
function shownBullets(list) local n = 0 for _, l in ipairs(list) do if l.Text:IsShown() then n = n + 1 end end return n end
local function bytes(r, g, b) return { math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5) } end
function colorOf(fs) return bytes(fs:GetTextColor()) end
function tokenOf(name) return bytes(Polestar.Theme.Color(name)) end
"#;

fn run_with(files: &[&str], script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", files)], script: ["uistub.install()", "stub.login()", CHOICE, script].join("\n"), ..Default::default() })
		.remove(0)
}

fn run(script: &str) -> Value {
	run_with(&FILES, script)
}

#[test]
fn route_choice_opens_one_card_per_zone_its_facts_at_one_height_across_cards_capped_pros_and_cons_the_recommended_one_leads() {
	let out = run(r#"
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		local F = PolestarRouteChoice
		local s, b = cardFor("silverpine"), cardFor("barrens")
		local function y(region) local _, _, _, _, py = region:GetPoint(1) return py end
		local cells = s.Stats.Cells
		stub.RunScript(b, "OnEnter")
		local tip = GameTooltip.lines
		emit({
			shown = F:IsShown(), subtitle = F.Subtitle:GetText(),
			names = { s.Name:GetText(), b.Name:GetText() },
			facts = { plain(cells[1].Text:GetText()), plain(cells[2].Text:GetText()), plain(cells[3].Text:GetText()) },
			trip = cells[2].Text:GetText(), textHex = Polestar.Theme.Hex("text"),
			glyphs = { cells[1].Glyph:GetTexture(), cells[2].Glyph:GetTexture(), cells[3].Glyph:GetTexture() },
			statsY = { y(s.Stats), y(b.Stats) }, ruleY = { y(s.Rule), y(b.Rule) }, consY = { y(s.Cons[1].Text), y(b.Cons[1].Text) },
			tag = s.Tag:IsShown() and s.Tag.Text:GetText(), otherTag = b.Tag:IsShown(),
			pros = { s.Pros[1].Text:GetText(), s.Pros[2].Text:GetText() }, cons = b.Cons[2].Text:GetText(),
			bShown = { pros = shownBullets(b.Pros), cons = shownBullets(b.Cons) },
			tip = tip, closeTip = F.Close.psTip,
			primary = s.Go.psPrimary or false, otherPrimary = b.Go.psPrimary or false,
			ring = { s.Ring[1]:IsShown(), b.Ring[1]:IsShown() },
			button = s.Go.Label:GetText(), sameHeight = s:GetHeight() == b:GetHeight(),
		})"#);
	assert_eq!(out["shown"], true);
	assert_eq!(out["subtitle"], "You finished Tirisfal Glades. Both routes meet again in Stonetalon Mountains.");
	assert_eq!(out["names"], json!(["Silverpine Forest", "The Barrens"]));
	assert_eq!(out["facts"], json!(["10–18", "~2 min", "44 quests"]), "the levels, the trip, the quests");
	assert!(text(&out["trip"]).contains(&format!("|c{}2|r", text(&out["textHex"]))), "the number in text, the words dim: {}", out["trip"]);
	let glyphs: Vec<&str> = out["glyphs"].as_array().unwrap().iter().map(text).collect();
	assert!(glyphs[0].ends_with("icon-level") && glyphs[1].ends_with("icon-clock") && glyphs[2].ends_with("icon-accept"), "{glyphs:?}");
	assert_eq!(out["statsY"][0], out["statsY"][1], "the facts line up");
	assert_eq!(out["ruleY"][0], out["ruleY"][1], "pitches of different lengths still meet one rule");
	assert_eq!(out["consY"][0], out["consY"][1], "cons start on the same line");
	assert_eq!(out["tag"], "Recommended");
	assert_eq!(out["otherTag"], false);
	assert_eq!(out["pros"], json!(["Compact", "Quiet"]));
	assert_eq!(out["cons"], "Long runs");
	assert_eq!(out["bShown"], json!({ "pros": 3, "cons": 2 }), "at most 3 pros and 2 cons on the card, one line each");
	let tip = out["tip"].as_array().unwrap();
	assert!(tip.iter().any(|l| is_match(text(l), "Group finder")) && tip.iter().any(|l| is_match(text(l), "Kill-stealing")), "the full lists are in the tooltip");
	assert!(tip.iter().any(|l| text(l) == "10–20  ·  ~10 min away  ·  57 quests"), "the facts whole in the tooltip: {tip:?}");
	assert_eq!(out["closeTip"], "Close");
	assert_eq!(out["primary"], true);
	assert_eq!(out["otherPrimary"], false);
	assert_eq!(out["ring"], json!([true, false]), "the recommended card's accent outline");
	assert_eq!(out["button"], "Level in Silverpine Forest");
	assert_eq!(out["sameHeight"], true);
}

#[test]
fn the_header_says_where_the_routes_meet_again_or_when_each_goes_its_own_way_asks_where_to_level_next() {
	let out = run(r#"
		local out = {}
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		out.two = PolestarRouteChoice.Subtitle:GetText()
		PENDING = "winterspring"
		Polestar.Fire("ROUTE_CHOICE", "winterspring")
		out.three = PolestarRouteChoice.Subtitle:GetText()
		PENDING = "badlands"
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
			"own": "You finished Badlands. Pick where you want to level next.",
			"again": "Pick where you want to level next.",
		})
	);
}

#[test]
fn routes_going_on_to_guides_of_their_own_say_which_an_experimental_guide_wears_its_chip_and_a_try_button() {
	let out = run(r#"
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local s, r = cardFor("stv"), cardFor("riverglades")
		local function thenOf(c)
			return { shown = c.Then:IsShown(), rule = c.ThenRule:IsShown(), label = c.Then.Label:GetText(), title = c.Then.Title:GetText(),
				level = c.Then.Level:GetText(), glyph = c.Then.Glyph:IsShown() }
		end
		local function card(c)
			return { tag = c.Tag:IsShown() and c.Tag.Text:GetText(), tagColor = colorOf(c.Tag.Text), go = c.Go.Label:GetText(),
				primary = c.Go.psPrimary or false, ring = c.Ring[1]:IsShown(), ["then"] = thenOf(c) }
		end
		local out = { stv = card(s), riverglades = card(r), accent = tokenOf("accent"), warning = tokenOf("warning") }
		-- Every route meeting again in one guide: the header says so, no card has a "Then" line.
		PENDING = "tirisfal"
		Polestar.Fire("ROUTE_CHOICE", "tirisfal")
		out.joined = { cardFor("silverpine").Then:IsShown(), cardFor("barrens").Then:IsShown() }
		-- A route that goes on to no guide of ours has no line; the others keep theirs, and the cards their height.
		-- The route open now says so, and keeps it. A guide with a pitch only has no rule over pros and cons.
		CHOICES.badlands.options[2].thenGuideTitle = nil
		CHOICES.badlands.options[1].open = true
		CHOICES.badlands.options[1].pros, CHOICES.badlands.options[1].cons = nil, nil
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		s, r = cardFor("stv"), cardFor("riverglades")
		out.lone = { stv = s.Then:IsShown(), riverglades = r.Then:IsShown(), sameHeight = s:GetHeight() == r:GetHeight(),
			goY = { select(5, s.Go:GetPoint(1)), select(5, r.Go:GetPoint(1)) }, rules = { s.Rule:IsShown(), r.Rule:IsShown() } }
		out.open = { tag = s.Tag.Text:GetText(), go = s.Go.Label:GetText(), primary = s.Go.psPrimary or false }
		emit(out)"#);
	let then_line = |title: &str| json!({ "shown": true, "rule": true, "label": "Then:", "title": title, "level": "43", "glyph": true });
	assert_eq!(out["stv"]["then"], then_line("Feralas & Tanaris"));
	assert_eq!(out["riverglades"]["then"], then_line("Stranglethorn Vale & Swamp of Sorrows"));
	assert_eq!(out["stv"]["tag"], "Recommended");
	assert_eq!(out["stv"]["tagColor"], out["accent"]);
	assert_eq!(out["stv"]["go"], "Level in Stranglethorn Vale");
	assert_eq!(out["stv"]["primary"], true);
	assert_eq!(out["stv"]["ring"], true);
	assert_eq!(out["riverglades"]["tag"], "Experimental");
	assert_eq!(out["riverglades"]["tagColor"], out["warning"], "the experimental chip in the warning colour");
	assert_eq!(out["riverglades"]["go"], "Try Riverglades");
	assert_eq!(out["riverglades"]["primary"], false, "an experimental guide is never the one the window leads with");
	assert_eq!(out["riverglades"]["ring"], false);
	assert_eq!(out["joined"], json!([false, false]));
	assert_eq!(out["lone"]["stv"], true);
	assert_eq!(out["lone"]["riverglades"], false);
	assert_eq!(out["lone"]["sameHeight"], true);
	assert_eq!(out["lone"]["goY"][0], out["lone"]["goY"][1], "the buttons line up");
	assert_eq!(out["lone"]["rules"], json!([false, true]), "no rule over an empty list");
	assert_eq!(out["open"], json!({ "tag": "Your current route", "go": "Keep this route", "primary": false }));
}

#[test]
fn the_forever_pennant_hangs_on_a_zone_forever_added_follows_the_new_in_forever_mark_and_says_what_it_means() {
	let out = run(r#"
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local s, r = cardFor("stv"), cardFor("riverglades")
		local p = r.Pennant
		local _, rel, relPoint = p:GetPoint(1)
		local out = { shown = { r.Pennant:IsShown(), s.Pennant:IsShown() }, onArt = rel == r.Art, relPoint = relPoint,
			mark = p.Mark:GetTexture() }
		-- The setting that shows the mark beside quests, changed while the window is open.
		Polestar.Set("ui.newInForever", false)
		out.off = r.Pennant:IsShown()
		Polestar.Set("ui.newInForever", true)
		out.on = r.Pennant:IsShown()
		stub.RunScript(p, "OnEnter")
		out.tip = GameTooltip.lines
		stub.RunScript(p, "OnClick", "LeftButton")
		out.chosen = CHOSEN
		emit(out)"#);
	assert_eq!(out["shown"], json!([true, false]), "on Riverglades only");
	assert_eq!(out["onArt"], true);
	assert_eq!(out["relPoint"], "TOPRIGHT", "hanging from the painting's top edge, on the right");
	assert!(text(&out["mark"]).ends_with("icon-forever"), "the mark beside quests: {}", out["mark"]);
	assert_eq!(out["off"], false);
	assert_eq!(out["on"], true);
	assert_eq!(out["tip"], json!(["New in Forever", "Most of its quests are new in Forever."]));
	assert_eq!(out["chosen"], "badlands>riverglades", "a click on it chooses the card");
}

#[test]
fn a_long_next_guide_title_is_cut_to_the_card_and_whole_in_its_tooltip_a_detour_is_the_first_con() {
	let out = run(r#"
		CHOICES.badlands.options[2].detour = "Desolace"
		CHOICES.badlands.options[2].cons = { "New guide", "Long" }
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local s, r = cardFor("stv"), cardFor("riverglades")
		local T = r.Then
		stub.RunScript(r, "OnEnter")
		emit({ title = T.Title:GetText(), cut = T.Title:IsTruncated(), short = s.Then.Title:IsTruncated(),
			used = T.Label:GetStringWidth() + 6 + T.Title:GetWidth() + 10 + 12 + 3 + T.Level:GetStringWidth(), room = T:GetWidth(),
			cons = { r.Cons[1].Text:GetText(), r.Cons[2].Text:GetText() }, consShown = shownBullets(r.Cons),
			tip = GameTooltip.lines })"#);
	assert_eq!(out["title"], "Stranglethorn Vale & Swamp of Sorrows");
	assert_eq!(out["cut"], true, "cut with an ellipsis where it meets the level");
	assert_eq!(out["short"], false);
	assert!(out["used"].as_f64().unwrap() <= out["room"].as_f64().unwrap(), "the line fits the card: {} of {}", out["used"], out["room"]);
	assert_eq!(out["cons"], json!(["A detour through Desolace", "New guide"]));
	assert_eq!(out["consShown"], 2);
	let tip: Vec<&str> = out["tip"].as_array().unwrap().iter().map(text).collect();
	assert_eq!(tip[0], "Riverglades");
	assert!(tip.contains(&"Then: Stranglethorn Vale & Swamp of Sorrows  ·  Level 43"), "the next guide whole: {tip:?}");
	assert!(tip.iter().any(|l| l.ends_with("Long")), "every con in the tooltip: {tip:?}");
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
		local function cells(c)
			local t = {}
			for i = 1, 3 do if c.Stats.Cells[i].Text:IsShown() then t[#t + 1] = plain(c.Stats.Cells[i].Text:GetText()) end end
			return t
		end
		local function divs(c) return { c.Stats.Divs[1]:IsShown(), c.Stats.Divs[2]:IsShown() } end
		stub.RunScript(r, "OnEnter")
		emit({ stv = cells(s), stvDivs = divs(s), riverglades = cells(r), rgDivs = divs(r), tip = GameTooltip.lines[2] })"#);
	assert_eq!(out["stv"], json!(["39–43", "Right here", "41 quests"]));
	assert_eq!(out["stvDivs"], json!([true, true]));
	assert_eq!(out["riverglades"], json!(["37–43", "Far away"]), "no quest count: no cell for it");
	assert_eq!(out["rgDivs"], json!([true, false]));
	assert_eq!(out["tip"], "37–43  ·  A long trip from here");
}

#[test]
fn the_route_start_is_the_world_maps_waypoint_mark_on_the_painting() {
	let out = run_with(
		&PIN_FILES,
		r#"
		C_Map = C_Map or {}
		C_Map.GetMapArtLayers = function(id)
			if id == 2548 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256, minScale = 1, maxScale = 1, additionalZoomSteps = 0 } } end
			return {}
		end
		C_Map.GetMapArtLayerTextures = function() local t = {} for i = 1, 12 do t[i] = 100000 + i end return t end
		local o = CHOICES.badlands.options
		o[2].zone, o[2].focusX, o[2].focusY = 2548, 75.6, 50.2
		o[1].zone = 9999
		PENDING = "badlands"
		Polestar.Fire("ROUTE_CHOICE", "badlands")
		local s, r = cardFor("stv"), cardFor("riverglades")
		local p, cv = r.Pin, r.Art.psCanvas
		local _, rel, relPoint, x, y = p:GetPoint(1)
		local ar, ag, ab = Polestar.Theme.Color("arrow")
		local ir, ig, ib = p.icon:GetVertexColor()
		emit({ shown = p:IsShown(), onArt = rel == r.Art, relPoint = relPoint, at = { x, y },
			want = { math.floor(cv[1] + cv[3] * 0.756 + 0.5), -math.floor(cv[2] + cv[4] * 0.502 + 0.5) },
			mark = p.mapMark or false, icon = p.icon:GetTexture(), sameColor = math.abs(ir - ar) + math.abs(ig - ag) + math.abs(ib - ab) < 0.01,
			medal = p.medal:IsShown(), glow = p.glow:IsShown(), noArt = s.Pin:IsShown() })"#,
	);
	assert_eq!(out["shown"], true);
	assert_eq!(out["onArt"], true);
	assert_eq!(out["relPoint"], "TOPLEFT");
	assert_eq!(out["at"], out["want"], "on the route's start, in map percent of the painting");
	assert_eq!(out["mark"], true, "a map mark, as the world map draws the waypoint");
	assert!(text(&out["icon"]).ends_with("icon-target"), "{}", out["icon"]);
	assert_eq!(out["sameColor"], true, "in the arrow's colour");
	assert_eq!(out["medal"], true, "on the look's medallion");
	assert_eq!(out["glow"], true);
	assert_eq!(out["noArt"], false, "no painting, no mark");
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
