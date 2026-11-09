//! The route lines' look (Maps/RouteLines.lua, Maps/RouteStrokes.lua) set on the settings window's Route lines page
//! (Maps/RouteOptions.lua): each setting changes the real lines on the world map and the minimap, the page holds the
//! controls the Line style window held (the gear beside "Route lines" opens it), and its preview paints with the maps'
//! own painters, running no OnUpdate while hidden, still or under reduced motion.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

fn f(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

fn near(a: f64, b: f64) -> bool {
	(a - b).abs() < 1e-6
}

// The painters with Nav against tests/lua/stub_nav.lua (map 9000: 2000 yd across, origin at its centre), the line
// style, and a route whose walk has a known path (two bends) and a later flight.
const PAINTED: &str = r#"
local N, R, nav = Polestar.Nav, Polestar.RouteLines, stub.nav
local function target(wx, wy)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, "Target")
end
WorldMapFrame:GetCanvas():SetSize(1000, 1000)
local geom = { legs = {
	{ kind = "walk", pts = { { 0, 0, 0 }, { 0, 50, -100 }, { 0, 0, -200 }, { 0, 60, -300 } }, current = true },
	{ kind = "flight", pts = { { 0, 60, -300 }, { 0, 60, -700 } } },
} }
N.GetRouteGeometry = function() return geom end
local function worldPin()
	local p = R.GetWorldFrame()
	if p and p:IsShown() then return p end
end
local function shown(owner)
	local n = 0
	for _, line in ipairs(owner and owner.lines or {}) do if line:IsShown() then n = n + 1 end end
	return n
end
-- The world map's strokes as painted: the walk's first line piece (soft shadow), the flight's dashes, chevron arms,
-- and the walk's faded tail behind the player.
local function look()
	local pin, s = worldPin(), R.GetStrokes("world")
	local r = { n = s.n, soft = 0, dashes = 0, arms = 0, tail = 0, shown = shown(pin) }
	for i = 1, s.n do
		if s.soft[i] then
			r.soft = r.soft + 1
			if s.alpha[i] < 1 then r.tail = r.tail + 1 end
			if not r.walk and s.alpha[i] == 1 then
				local line, outline = pin.lines[i], pin.outlines[i]
				local lr, lg, lb = line:GetVertexColor()
				r.walk = { lr, lg, lb }
				r.width, r.alpha, r.strokeAlpha, r.outline = line:GetThickness(), line:GetAlpha(), s.alpha[i], outline:IsShown()
			end
		elseif s.under[i] > 0 and not s.dot[i] then
			r.dashes = r.dashes + 1
			if not r.flight then
				local cr, cg, cb = pin.lines[i]:GetVertexColor()
				r.flight, r.flightAlpha = { cr, cg, cb }, s.alpha[i]
			end
		elseif s.under[i] == 0 and not s.dot[i] then
			r.arms = r.arms + 1
		end
	end
	return r
end
Polestar.Set("nav.travel", false)
nav.viewRadius = 400
-- Halfway along the walk's first stretch: the walked stretch lies behind.
nav.place(25, -50)
target(60, -700)
Polestar.Fire("NAV_ROUTE_GEOMETRY")
nav.showWorldMap(9000)
stub.advance(1)
"#;

fn painted(script: &str) -> Value {
	let lines = Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml", "Maps/FlightPaths.lua", "Maps/RouteStrokes.lua", "Maps/RouteSparkle.lua", "Maps/RouteLines.lua"]);
	emitted(&RunAddon { stubs: vec!["stub_nav.lua"], addons: vec![lines], login: true, script: format!("{PAINTED}{script}"), ..Default::default() }).remove(0)
}

#[test]
fn the_colours_thickness_opacity_and_outline_set_on_the_page_paint_the_real_world_map_lines() {
	let out = painted(
		r#"
		local r = { before = look() }
		Polestar.Set("nav.walkColor", { 1, 0, 0 })
		Polestar.Set("nav.flightColor", { 0, 0, 1 })
		Polestar.Set("nav.lineWidth", 10)
		Polestar.Set("nav.worldRouteAlpha", 0.5)
		stub.advance(0.5)
		r.after = look()
		r.mmOpacity = R.GetMinimapFrame().opacity
		local mr, mg, mb = R.GetMinimapFrame().lines[1]:GetVertexColor()
		r.mmWalk = { mr, mg, mb }
		Polestar.Set("nav.lineOutline", 0)
		stub.advance(0.5)
		r.bare = look()
		Polestar.Set("nav.lineOutline", nil)
		Polestar.Set("nav.walkColor", nil)
		stub.advance(0.5)
		r.reset = look()
		emit(r)"#,
	);
	let (before, after) = (&out["before"], &out["after"]);
	assert_eq!(after["walk"], json!([1, 0, 0]), "the walk in its own colour: {after}");
	assert_eq!(after["flight"], json!([0, 0, 1]), "the flight in its own colour");
	assert_ne!(before["walk"], json!([1, 0, 0]));
	assert_eq!(out["mmWalk"], json!([1, 0, 0]), "the minimap's walk too");
	assert!(near(f(&after["width"]) / f(&before["width"]), 10.0 / 4.0), "thickness 10 px from 4: {} from {}", after["width"], before["width"]);
	assert!(near(f(&before["alpha"]), f(&before["strokeAlpha"])), "full opacity by default");
	assert!(near(f(&after["alpha"]), 0.5 * f(&after["strokeAlpha"])), "world map at 50%: {}", after["alpha"]);
	assert_eq!(out["mmOpacity"], 1, "the minimap keeps its own opacity");
	assert_eq!(after["outline"], true, "the soft shadow under the line by default");
	assert_eq!(out["bare"]["outline"], false, "outline 0%: none");
	assert_eq!(out["reset"]["outline"], true);
	assert_eq!(out["reset"]["walk"], before["walk"], "right-click: the theme's colour again");
}

#[test]
fn later_legs_the_walked_stretch_dashed_flights_and_chevrons_follow_their_settings() {
	let out = painted(
		r#"
		local r = { before = look() }
		Polestar.Set("nav.laterAlpha", 0.8); stub.advance(0.5); r.later = look()
		Polestar.Set("nav.laterAlpha", 0); stub.advance(0.5); r.hidden = look()
		Polestar.Set("nav.laterAlpha", nil)
		Polestar.Set("nav.walkedFade", false); stub.advance(0.5); r.noTail = look()
		Polestar.Set("nav.walkedFade", nil)
		Polestar.Set("nav.flightDash", false); stub.advance(0.5); r.solid = look()
		Polestar.Set("nav.flightDash", nil)
		Polestar.Set("nav.routeChevrons", true); stub.advance(0.5); r.chevrons = look()
		Polestar.Set("nav.worldRoute", false); stub.advance(0.5)
		r.worldOff, r.minimap = worldPin() == nil, R.GetStrokes("minimap").n
		emit(r)"#,
	);
	let before = &out["before"];
	assert!(near(f(&before["flightAlpha"]), 0.4), "the later flight at 40% by default: {before}");
	assert!(near(f(&out["later"]["flightAlpha"]), 0.8), "later legs at 80%");
	assert_eq!(out["hidden"]["dashes"], 0, "later legs at 0%: only the leg in hand");
	assert!(f(&out["hidden"]["soft"]) > 0.0);
	assert!(f(&before["tail"]) > 0.0, "the walked stretch fades behind the player: {before}");
	assert_eq!(out["noTail"]["tail"], 0, "walked fade off: no tail");
	assert_eq!(out["solid"]["dashes"], 0, "dashed flights off: no dashes");
	assert!(f(&out["solid"]["soft"]) > f(&before["soft"]), "the flight a line as the walk's");
	assert_eq!(before["arms"], 0, "no chevrons by default");
	assert!(f(&out["chevrons"]["arms"]) > 0.0, "direction marks on");
	assert_eq!(out["worldOff"], true, "off the world map");
	assert!(f(&out["minimap"]) > 0.0, "still on the minimap");
}

#[test]
fn the_dots_size_and_spacing_and_the_draw_in_switch_change_the_real_lines() {
	let out = painted(
		r#"
		Polestar.Set("nav.lineStyle", "dots")
		stub.advance(1)
		local function dots()
			local s, pin = R.GetStrokes("world"), worldPin()
			local first, second
			for i = 1, s.n do
				if s.dot[i] then
					if not first then first = i elseif not second then second = i end
				end
			end
			local gap = math.sqrt(((s.x1[second] + s.x2[second]) - (s.x1[first] + s.x2[first])) ^ 2 + ((s.y1[second] + s.y2[second]) - (s.y1[first] + s.y2[first])) ^ 2) / 2
			return { width = pin.lines[first]:GetThickness(), gap = gap, n = s.n }
		end
		local r = { before = dots() }
		Polestar.Set("nav.dotSize", 8)
		Polestar.Set("nav.dotSpacing", 18)
		stub.advance(0.5)
		r.after = dots()
		Polestar.Set("nav.dotSize", 99)
		stub.advance(0.5)
		r.clamped = dots()
		-- A new goal with the draw-in off: whole at once.
		Polestar.Set("nav.lineStyle", "line")
		Polestar.Set("nav.drawIn", false)
		geom.legs[1].pts[4] = { 0, 80, -320 }
		geom.legs[2].pts[1] = { 0, 80, -320 }
		target(80, -700)
		Polestar.Fire("NAV_ROUTE_GEOMETRY")
		stub.advance(0.05)
		r.noDrawIn = { shown(worldPin()), R.GetStrokes("world").n }
		emit(r)"#,
	);
	let (before, after) = (&out["before"], &out["after"]);
	assert!(near(f(&after["width"]) / f(&before["width"]), 2.0), "dots twice as big: {after} from {before}");
	assert!((f(&before["gap"]) - 9.0).abs() < 0.5, "9 px apart by default: {before}");
	assert!((f(&after["gap"]) - 18.0).abs() < 0.5, "18 px apart: {after}");
	assert!(f(&after["n"]) < f(&before["n"]), "fewer dots further apart");
	assert!(near(f(&out["clamped"]["width"]) / f(&before["width"]), 10.0 / 4.0), "no bigger than 10 px");
	assert_eq!(out["noDrawIn"][0], out["noDrawIn"][1], "draw-in off: the whole route at once");
}

// ---------------------------------------------------------------------------------------------------------------
// The page in the settings window.
// ---------------------------------------------------------------------------------------------------------------

const PAGE_FILES: [&str; 5] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml", "UI/UI.xml"];

fn page(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &PAGE_FILES)],
		script: format!(
			"uistub.install({{ noNav = true }})\nstub.login()\nlocal UI, O, W, R = Polestar.UI, Polestar.UI.Options, Polestar.Widgets, Polestar.RouteLines\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_gear_beside_route_lines_opens_the_route_lines_page_which_holds_the_line_style_window_s_settings() {
	let out = page(
		r#"
		UI.ShowOptions("guide")
		O.Select("guide", "Arrow & routes")
		local row = O.Controls("guide", "Arrow & routes")["nav.routeLines"]
		local r = { gear = row and row.Gear ~= nil or false, window = _G.PolestarLineStyle == nil, show = UI.ShowLineStyle == nil }
		if row and row.Gear then row.Gear:Click() end
		r.page = false
		for f in pairs(R.Previews()) do if f:IsVisible() then r.page = true end end
		local keys = {}
		for _, tab in ipairs({ "Line", "Minimap", "Dots & sparkles" }) do
			O.Select("routelines", tab)
			for key in pairs(O.Controls("routelines", tab)) do keys[#keys + 1] = key end
		end
		table.sort(keys)
		r.keys = keys
		local c = O.Controls("routelines", "Dots & sparkles")
		Polestar.Set("nav.lineStyle", "dots")
		r.intensityWithDots, r.dotSizeWithDots = W.Enabled(c["nav.sparkleIntensity"]), W.Enabled(c["nav.dotSize"])
		Polestar.Set("nav.lineStyle", "sparkle")
		r.intensityWithSparkle, r.dotSizeWithSparkle = W.Enabled(c["nav.sparkleIntensity"]), W.Enabled(c["nav.dotSize"])
		c["Dazzling sparkles"].Button:Click()
		r.dazzling = Polestar.Get("nav.sparkleIntensity")
		emit(r)"#,
	);
	assert_eq!(out["gear"], true, "a gear beside the switch");
	assert_eq!(out["window"], true, "the Line style window is gone");
	assert_eq!(out["show"], true);
	assert_eq!(out["page"], true, "the gear opens the Route lines page");
	let keys = out["keys"].as_array().expect("keys");
	for key in [
		"nav.routeLines",
		"nav.worldRoute",
		"nav.lineStyle",
		"nav.lineWidth",
		"nav.lineOutline",
		"nav.flightDash",
		"nav.routeChevrons",
		"nav.dotColor",
		"nav.walkColor",
		"nav.flightColor",
		"nav.boatColor",
		"nav.zeppelinColor",
		"nav.tramColor",
		"nav.worldRouteAlpha",
		"nav.laterAlpha",
		"nav.walkedFade",
		"nav.drawIn",
		"nav.minimapRoute",
		"nav.minimapRouteAlpha",
		"nav.minimapRouteSize",
		"nav.dotSize",
		"nav.dotSpacing",
		"nav.sparkleIntensity",
		"nav.sparkleDensity",
		"nav.sparkleSubtlety",
		"nav.sparkleSize",
		"nav.sparkleFlow",
		"nav.sparkleMax",
		"nav.sparkleColor",
		"nav.sparkleLater",
		"Subtle sparkles",
		"Default sparkles",
		"Dazzling sparkles",
	] {
		assert!(keys.contains(&json!(key)), "{key} on the page: {keys:?}");
	}
	assert_eq!(out["intensityWithDots"], false, "the sparkle settings wait for the sparkles");
	assert_eq!(out["dotSizeWithDots"], true);
	assert_eq!(out["intensityWithSparkle"], true);
	assert_eq!(out["dotSizeWithSparkle"], false, "the dots' size waits for the dots");
	assert_eq!(out["dazzling"], 1, "a preset applies");
}

// Issue #1381 (moved from the Line style window): the dots' colour and the minimap line's opacity and size, the
// colour waiting for the dots, each reset by right-click; the minimap size slider follows the chosen style;
// "Route line on the minimap" stays under Map > Guide & quests too, waiting for "Guide pin on the minimap".
#[test]
fn the_dot_colour_and_the_minimap_look_reset_by_right_click_the_minimap_size_follows_the_style() {
	let out = page(
		r#"
		Polestar.Set("nav.lineStyle", "dots")
		UI.ShowOptions("routelines")
		O.Select("routelines", "Line")
		local colour = O.Controls("routelines", "Line")["nav.dotColor"]
		O.Select("routelines", "Minimap")
		local m = O.Controls("routelines", "Minimap")
		local r = { colourWithDots = W.Enabled(colour) }
		Polestar.Set("nav.lineStyle", "sparkle")
		r.colourWithSparkle = W.Enabled(colour)
		r.alphaWithSparkle, r.sizeWithSparkle = W.Enabled(m["nav.minimapRouteAlpha"]), W.Enabled(m["nav.minimapRouteSize"])
		local slider = m["nav.minimapRouteSize"]
		local function shows() return slider.Slider:GetValue() end
		Polestar.Set("nav.lineStyle", "line"); r.line = shows()
		Polestar.Set("nav.lineStyle", "dots"); r.dots = shows()
		Polestar.Set("nav.lineStyle", "sparkle"); r.sparkle = shows()
		stub.RunScript(slider.Slider, "OnValueChanged", 1.0, true)
		r.after = { Polestar.Get("nav.minimapLineSize"), Polestar.Get("nav.minimapDotsSize"), Polestar.Get("nav.minimapSparkleSize") }
		slider:Click("RightButton")
		r.sizeReset = Polestar.Get("nav.minimapSparkleSize")
		Polestar.Set("nav.lineStyle", "dots")
		Polestar.Set("nav.dotColor", "cyan")
		Polestar.Set("nav.minimapRouteAlpha", 0.4)
		colour:Click("RightButton")
		m["nav.minimapRouteAlpha"]:Click("RightButton")
		r.reset = { Polestar.Get("nav.dotColor"), Polestar.Get("nav.minimapRouteAlpha") }
		Polestar.Set("nav.walkColor", { 1, 0, 0 })
		r.colourWithOwnWalk = W.Enabled(colour)
		r.max = select(2, slider.Slider:GetMinMaxValues())
		UI.ShowOptions("map")
		O.Select("map", "Guide & quests")
		local toggle = O.Controls("map", "Guide & quests")["nav.minimapRoute"]
		r.toggleOn = toggle ~= nil and W.Enabled(toggle)
		Polestar.Set("nav.minimapPins", false)
		r.toggleWithoutPin = toggle ~= nil and W.Enabled(toggle)
		Polestar.Set("nav.minimapPins", true)
		Polestar.Set("nav.minimapRoute", false)
		if toggle then toggle:Click("RightButton") end
		r.toggleReset = Polestar.Get("nav.minimapRoute")
		emit(r)"#,
	);
	assert_eq!(out["colourWithDots"], true);
	assert_eq!(out["colourWithSparkle"], false, "the route colour waits for the dots or the line");
	assert_eq!(json!([out["alphaWithSparkle"], out["sizeWithSparkle"]]), json!([true, true]), "the minimap look holds for every style");
	assert_eq!([&out["line"], &out["dots"], &out["sparkle"]], [&json!(0.5), &json!(0.8), &json!(1.5)], "the slider follows the style");
	assert_eq!(out["after"], json!([0.5, 0.8, 1]), "only the sparkles' size changed");
	assert_eq!(out["sizeReset"], 1.5);
	assert_eq!(out["reset"], json!(["route", 1]), "right-click restores each default");
	assert_eq!(out["colourWithOwnWalk"], false, "a walk colour of your own wins over the route colour");
	assert_eq!(out["max"], 1.5, "the size stops at 150 %");
	assert_eq!(out["toggleOn"], true, "the switch is on Map > Guide & quests");
	assert_eq!(out["toggleWithoutPin"], false, "it waits for the minimap pin, which hides the line too");
	assert_eq!(out["toggleReset"], true);
}

#[test]
fn the_preview_paints_the_route_with_the_maps_painters_and_runs_no_onupdate_while_hidden_still_or_under_reduced_motion() {
	let out = page(
		r#"
		UI.ShowOptions("routelines")
		O.Select("routelines", "Line")
		local function preview()
			for f in pairs(R.Previews() or {}) do if f:IsVisible() then return f end end
		end
		local function shown(owner)
			local n = 0
			for _, line in ipairs(owner.lines) do if line:IsShown() then n = n + 1 end end
			return n
		end
		local f = preview()
		local r = { built = f ~= nil }
		if not f then emit(r) return end
		r.world, r.worldShown, r.minimap = f.strokes.n, shown(f.world), f.mmStrokes.n
		r.still = f:GetScript("OnUpdate") == nil
		Polestar.Set("nav.walkColor", { 1, 0, 0 })
		local rr, rg, rb = f.world.lines[1]:GetVertexColor()
		r.red = { rr, rg, rb }
		Polestar.Set("nav.lineWidth", 8)
		r.width = f.world.lines[1]:GetThickness()
		Polestar.Set("nav.lineStyle", "sparkle")
		stub.advance(0.2)
		r.sparkling = f:GetScript("OnUpdate") ~= nil
		r.sparkles, r.mmSparkles = f.world.sparkles, f.mm.sparkles
		r.linesWhileSparkling = shown(f.world)
		Polestar.Set("ui.reduceMotion", true)
		r.reduced = f:GetScript("OnUpdate") == nil
		r.reducedStyle = R.Style()
		Polestar.Set("ui.reduceMotion", nil)
		r.again = f:GetScript("OnUpdate") ~= nil
		UI.ShowOptions("routelines")
		_G.PolestarOptions:Hide()
		-- The client runs OnHide on every shown descendant of a frame hidden; the stub only on the frame itself.
		local onHide = f:GetScript("OnHide")
		if onHide and not f:IsVisible() then onHide(f) end
		r.hidden = f:GetScript("OnUpdate") == nil
		Polestar.Set("nav.lineWidth", 4)
		r.dirtyWhileHidden = f.dirty
		emit(r)"#,
	);
	assert_eq!(out["built"], true, "the Line tab pins its preview");
	assert!(f(&out["world"]) > 10.0 && out["worldShown"] == out["world"], "the world panel's route painted: {out}");
	assert!(f(&out["minimap"]) > 0.0, "and the minimap disc's");
	assert_eq!(out["still"], true, "no OnUpdate for a still line");
	assert_eq!(out["red"], json!([1, 0, 0]), "a setting repaints it");
	assert_eq!(out["width"], 8);
	assert_eq!(out["sparkling"], true, "sparkles animate while shown");
	assert!(f(&out["sparkles"]) > 0.0 && f(&out["mmSparkles"]) > 0.0, "sparkles on both: {out}");
	assert_eq!(out["linesWhileSparkling"], 0);
	assert_eq!(out["reduced"], true, "none under reduced motion");
	assert_eq!(out["reducedStyle"], "dots");
	assert_eq!(out["again"], true);
	assert_eq!(out["hidden"], true, "no OnUpdate once hidden");
	assert_eq!(out["dirtyWhileHidden"], true, "repainted on show, not while hidden");
}
