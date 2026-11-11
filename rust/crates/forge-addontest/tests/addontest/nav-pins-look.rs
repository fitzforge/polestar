//! The Map pins look settings (Settings > Map pins, Nav/PinsOptions.lua): the numbered pins of the steps
//! ahead (Silverina asked for bigger ones), the target, every mark's size and opacity on each surface, the
//! areas; each with real effect on the pins Polestar.Pins draws, the defaults drawing exactly as before,
//! and the page's preview painting sandbox pins with Pins' own code.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const PRELUDE: &str = r#"
local N = Polestar.Nav
local Pins = Polestar.Pins
local nav = stub.nav
local scroll = WorldMapFrame.ScrollContainer
local function at(wx, wy, extra)
	local m, x, y = nav.mapPoint(wx, wy)
	local p = { map = m, x = x, y = y }
	for k, v in pairs(extra or {}) do p[k] = v end
	return p
end
local function rgba(t) local r, g, b, a = t:GetVertexColor() return { r, g, b, a } end
local function r3(v) return math.floor(v * 1000 + 0.5) / 1000 end
-- The live steps ahead: step 3 is the live one, 4 to 7 ahead on map 9000.
local function steps(n)
	local views = { [3] = { status = "current", goals = {} } }
	for s = 4, 3 + n do views[s] = { title = "S" .. s, status = "upcoming", goals = { { map = 9000, x = 10 * s, y = 50, status = "pending" } } } end
	Polestar.Engine = { GetLiveStep = function() return 3 end, GetStepCount = function() return 3 + n end, GetStepView = function(i) return views[i] end }
end
-- The world map's numbered pins, left to right: size, size on screen, number font, colours.
local function drawn()
	stub.advance(0.05)
	stub.runMapFrame(WorldMapFrame, 0)
	local r = {}
	for _, f in ipairs(nav.pins()) do
		if f.data.layer.name == "nav.upcoming" then
			local _, font, outline = f.text:GetFont()
			local tr, tg, tb = f.text:GetTextColor()
			local c = rgba(f.fill)
			r[#r + 1] = { x = f.data.x, w = r3(f.width), screen = r3(f.width * f.scale * (scroll.currentScale or 1)),
				font = r3(font or 0), outline = outline, text = f.text:IsShown() and f.text:GetText() or false,
				number = { r3(tr), r3(tg), r3(tb) }, fill = { r3(c[1]), r3(c[2]), r3(c[3]), r3(c[4]) } }
		end
	end
	table.sort(r, function(a, b) return a.x < b.x end)
	for _, p in ipairs(r) do p.x = nil end
	return r
end
"#;

// The Map pins page is the settings window's (Polestar_Options): its file, after the pins' own, and the
// settings window's preview stage it draws on (UI/Preview.lua).
fn run(script: &str) -> Value {
	let page = forge_addontest::run::addons_dir().join("Polestar_Options/Nav/PinsOptions.lua").to_string_lossy().into_owned();
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml", "../Polestar_Options/UI/Preview.lua", &page])],
		login: true,
		script: format!("{PRELUDE}{script}"),
		..Default::default()
	})
	.remove(0)
}

// Silverina: "can the numbered map pins be bigger?" The size, the number, the colours, the fade and the count
// reach the real upcoming pins on the world map; bigger pins pass the usual 28 px cap on screen.
#[test]
fn the_numbered_pins_size_number_colours_fade_and_count_apply_to_the_real_upcoming_pins_on_the_world_map() {
	let out = run(r#"
		local out = {}
		steps(3)
		Polestar.Set("ui.upcoming", 3)                 -- Up next shows three
		Polestar.Set("nav.upcomingPins", true)
		nav.showWorldMap(9000)
		out.default = drawn()
		out.accent = { Polestar.Theme.Accent() }
		for i = 1, 3 do out.accent[i] = r3(out.accent[i]) end
		Polestar.Set("nav.stepPinSize", 3)
		Polestar.Set("nav.stepNumberSize", 1.5)
		Polestar.Set("nav.stepNumberColor", { 1, 0, 0 })
		Polestar.Set("nav.stepNumberOutline", "THICKOUTLINE")
		Polestar.Set("nav.stepColorMode", "own")
		Polestar.Set("nav.stepColor", { 0, 0, 1 })
		Polestar.Set("nav.stepAlpha", 0.8)
		Polestar.Set("nav.stepFadeTo", 0.2)
		out.big = drawn()
		Polestar.Set("nav.upcomingCount", 2)
		Polestar.Set("nav.stepNumbers", false)
		out.two = drawn()
		out.minimap = #Pins.GetMinimapFrames("nav.upcoming")
		Polestar.Set("nav.upcomingMinimap", false)
		stub.advance(0.05)
		out.minimapOff = #Pins.GetMinimapFrames("nav.upcoming")
		out.worldStill = #drawn()
		emit(out)"#);
	let a = &out["accent"];
	let fill = |alpha: Value| json!([a[0], a[1], a[2], alpha]);
	// The defaults draw as before: 15 px in the accent, at 0.7 zoomed out, white 9 px numbers, 1 to 0.35.
	assert_eq!(
		out["default"],
		json!([
			{ "w": 15, "screen": 10.5, "font": 9, "outline": "OUTLINE", "text": "4", "number": [1, 1, 1], "fill": fill(json!(1)) },
			{ "w": 15, "screen": 10.5, "font": 9, "outline": "OUTLINE", "text": "5", "number": [1, 1, 1], "fill": fill(json!(0.675)) },
			{ "w": 15, "screen": 10.5, "font": 9, "outline": "OUTLINE", "text": "6", "number": [1, 1, 1], "fill": fill(json!(0.35)) },
		])
	);
	// 300%: 45 px, 31.5 on screen (past the old 28 cap), numbers 0.6 x 45 x 1.5, red, thick; blue from 0.8 to 0.2.
	assert_eq!(
		out["big"],
		json!([
			{ "w": 45, "screen": 31.5, "font": 40.5, "outline": "THICKOUTLINE", "text": "4", "number": [1, 0, 0], "fill": [0, 0, 1, 0.8] },
			{ "w": 45, "screen": 31.5, "font": 40.5, "outline": "THICKOUTLINE", "text": "5", "number": [1, 0, 0], "fill": [0, 0, 1, 0.5] },
			{ "w": 45, "screen": 31.5, "font": 40.5, "outline": "THICKOUTLINE", "text": "6", "number": [1, 0, 0], "fill": [0, 0, 1, 0.2] },
		])
	);
	assert_eq!(out["two"].as_array().unwrap().len(), 2, "two steps ahead");
	assert_eq!(out["two"][0]["text"], false, "numbers off");
	assert_eq!(out["two"][1]["fill"], json!([0, 0, 1, 0.2]), "the farthest of two at the fade's end");
	assert_eq!(out["minimap"], 2, "on the minimap by default");
	assert_eq!(json!([out["minimapOff"], out["worldStill"]]), json!([0, 2]), "minimap off, the world map keeps them");
}

// Every Polestar mark on the world map scales with nav.worldIconSize, its 28 px cap with it, and takes
// nav.worldPinAlpha; the minimap's take their own opacity and may stop fading over the player's arrow; areas
// take their opacity and an own colour.
#[test]
fn world_icon_size_scales_every_mark_and_its_cap_and_the_opacities_reach_both_surfaces_and_the_areas() {
	let out = run(r#"
		nav.viewRadius = 200
		nav.place(0, 0)
		Pins.SetLayer("marks", {
			at(20, 20, { icon = "map:kill", size = 16, minimapSize = 14, tooltip = "Kill" }),
			at(-20, 20, { icon = "map:quest-turnin", size = 23.4, tooltip = "Turn in" }),
			at(0, 0, { icon = "map:quest-turnin", minimapSize = 14, tooltip = "On" }),
			at(60, 60, { area = 60, areaOnly = true, color = { 1, 0.5, 0.5, 1 } }),
		})
		local function world()
			stub.runMapFrame(WorldMapFrame, 0)
			local r = {}
			for _, f in ipairs(nav.pins()) do
				r[f.data.pin.tooltip] = { medal = r3(f.medal.width * f.scale * (scroll.currentScale or 1)), alpha = f:GetAlpha() or 1 }
			end
			local a = nav.pins("areas")[1]
			r.area = a and rgba(a.tex)
			return r
		end
		local function minimap()
			stub.advance(0.3)
			local r = {}
			for _, f in ipairs(Pins.GetMinimapFrames("marks")) do r[f.pin.tooltip] = r3(f:GetAlpha() or 1) end
			return r
		end
		local out = { defaults = {} }
		for _, k in ipairs({ "worldIconSize", "worldPinAlpha", "minimapPinAlpha", "minimapArrowFade", "areaAlpha", "areaColor",
			"medalColor", "pinBacking", "badgeSize", "stepPinSize", "upcomingCount", "targetPinSize", "targetGlow", "targetPulse" }) do
			out.defaults[k] = Polestar.Get("nav." .. k)
		end
		nav.showWorldMap(9000)
		out.world = world()
		out.mm = minimap()
		Polestar.Set("nav.worldIconSize", 2)
		Polestar.Set("nav.worldPinAlpha", 0.5)
		Polestar.Set("nav.areaAlpha", 0.64)
		Polestar.Set("nav.areaColor", { 0, 1, 0 })
		out.bigWorld = world()
		scroll.currentScale, scroll.zoomPercent = 8, 1; stub.runMapFrame(WorldMapFrame, 0)
		out.bigZoomed = world()
		Polestar.Set("nav.minimapPinAlpha", 0.5)
		Polestar.Set("nav.minimapArrowFade", false)
		out.mmSet = minimap()
		emit(out)"#);
	assert_eq!(
		out["defaults"],
		json!({ "worldIconSize": 1, "worldPinAlpha": 1, "minimapPinAlpha": 1, "minimapArrowFade": true, "areaAlpha": 0.32,
			"areaColor": false, "medalColor": false, "pinBacking": false, "badgeSize": 1, "stepPinSize": 1, "upcomingCount": 0,
			"targetPinSize": 1, "targetGlow": true, "targetPulse": false })
	);
	// Defaults as before: a 16 px mark's 22 px medallion at 0.7, the 23.4 px one's 32; the area at 0.32.
	assert_eq!(out["world"]["Kill"], json!({ "medal": 15.4, "alpha": 1 }));
	assert_eq!(out["world"]["Turn in"]["medal"], json!(22.4));
	assert_eq!(out["world"]["area"], json!([1, 0.5, 0.5, 0.32]));
	assert_eq!(out["mm"]["On"], json!(0.3), "over the arrow: 30%");
	// 200%: medallions of 44 and 66 px at 0.7; zoomed in 0.9, the cap of 56 holding the larger.
	assert_eq!(out["bigWorld"]["Kill"], json!({ "medal": 30.8, "alpha": 0.5 }));
	assert_eq!(out["bigWorld"]["Turn in"]["medal"], json!(46.2));
	assert_eq!(out["bigZoomed"]["Kill"]["medal"], json!(39.6));
	assert_eq!(out["bigZoomed"]["Turn in"]["medal"], json!(56), "the cap grows with the size");
	assert_eq!(out["bigWorld"]["area"], json!([0, 1, 0, 0.64]), "own colour, own opacity");
	assert_eq!(out["mmSet"]["On"], json!(0.5), "no fade over the arrow, at the minimap's opacity");
	assert_eq!(out["mmSet"]["Kill"], json!(0.5));
}

// The target pin: its size, glow and pulse (a client animation, none under Reduce motion).
#[test]
fn the_target_pin_takes_its_size_glow_and_pulse_and_reduce_motion_stops_the_pulse() {
	let out = run(r#"
		local m, x, y = nav.mapPoint(40, 0)
		N.SetTarget(m, x, y, "Goal")
		nav.showWorldMap(9000)
		local function target()
			stub.advance(0.05)
			stub.runMapFrame(WorldMapFrame, 0)
			for _, f in ipairs(nav.pins()) do
				if f.data.layer.name == "nav.target" then
					return { w = r3(f.width), glow = f.glow:IsShown(), pulsing = f.pulsing or false, plays = f.pulse and f.pulse.plays or 0 }
				end
			end
		end
		local out = { default = target() }
		Polestar.Set("nav.targetPinSize", 2)
		Polestar.Set("nav.targetPulse", true)
		out.big = target()
		Polestar.Set("ui.reduceMotion", true)
		out.reduced = target()
		Polestar.Set("ui.reduceMotion", false)
		Polestar.Set("nav.targetGlow", false)
		out.noGlow = target()
		emit(out)"#);
	assert_eq!(out["default"], json!({ "w": 22.4, "glow": true, "pulsing": false, "plays": 0 }), "16 x 1.4, glowing, still");
	assert_eq!(out["big"]["w"], json!(44.8));
	assert_eq!(json!([out["big"]["glow"], out["big"]["pulsing"]]), json!([true, true]));
	assert!(out["big"]["plays"].as_f64().unwrap() >= 1.0, "the pulse plays");
	assert_eq!(out["reduced"]["pulsing"], false, "Reduce motion: no pulse");
	assert_eq!(json!([out["noGlow"]["glow"], out["noGlow"]["pulsing"]]), json!([false, false]));
}

// The page's previews: Pins' own builder and paint on sandbox frames (never the live pins), repainted by their
// settings while shown, else on the next show. Pins: the numbered pins at their true size on a route, shown as a
// sample while off, a "Pin size" inset of 100% against yours. Icons: the marks at full size, one with its badge.
// The page (layout v2: section toggles, extras, cogs) holds every setting a player could set, each new one with
// search words and help (its tooltip).
#[test]
fn the_preview_paints_sandbox_pins_with_the_pins_code_and_repaints_only_while_shown() {
	let out = run(r#"
		local out = {}
		local P = N.PinsPreview(UIParent)          -- the stub takes addon frames under UIParent
		P:Show()
		out.height = P:Layout(900)
		local M = P.Map
		local s1 = M.steps[1]
		local count = math.min(5, N.upcoming.Count())
		out.live = #nav.pins() == 0 and s1:GetParent() ~= WorldMapFrame.Child
		out.sample = { Polestar.Get("nav.upcomingPins"), s1:IsShown(), count >= 3 }
		-- Zoomed in by default: a 15 px pin at 0.9 on screen, its number legible.
		out.steps = { r3(s1.width), r3(s1.width * s1.scale), s1.text:GetText(), r3(rgba(M.steps[count].fill)[4]) }
		out.target = { glow = M.target.glow:IsShown(), icon = M.target.icon.texture:match("icon%-[%a-]+$") }
		Polestar.Set("nav.stepPinSize", 2)
		out.repainted = r3(s1.width)
		out.inset = { r3(M.inset.base.width), r3(M.inset.yours.width) }
		P:Hide()
		Polestar.Set("nav.stepPinSize", 2.5)
		out.hidden = r3(s1.width)
		P:Show()
		out.shown = r3(s1.width)
		-- The zoom switch: zoomed out draws them at 0.7.
		P.Zoom:GetChildren():Click()
		out.zoomedOut = r3(s1.scale)
		out.updates = P:GetScript("OnUpdate") == nil
		local I = N.PinsIconsPreview(UIParent)
		I:Show()
		I:Layout(900)
		local badged
		for _, m in ipairs(I.Marks) do if m.badge.text:IsShown() then badged = m.badge.text:GetText() end end
		out.icons = { #I.Marks, r3(I.Marks[1].medal.width * I.Marks[1].scale), badged }
		local n, page, keys, sections = 0, nil, {}, {}
		local function visit(c)
			n = n + 1
			if c.key then keys[#keys + 1] = c.key end
			if c.new and not (c.search and c.help) then out.missing = c.key end
			if c.key and Polestar.GetDefault(c.key) == nil then out.noDefault = c.key end
			for _, e in ipairs(c.extras or {}) do visit(e) end
			for _, e in ipairs(c.more or {}) do visit(e) end
		end
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.page == Polestar.L["Map pins"] then
				if spec.key then page = { key = spec.key, order = spec.order, group = spec.group } end
				sections[#sections + 1] = spec.tab .. " / " .. spec.section .. (spec.toggle and " [" .. spec.toggle.key .. "]" or "")
				if spec.toggle then visit(spec.toggle) end
				for _, c in ipairs(spec.controls) do visit(c) end
			end
		end
		table.sort(keys)
		out.page, out.controls, out.keys, out.sections = page, n, keys, sections
		emit(out)"#);
	assert_eq!(out["height"], json!(196));
	assert_eq!(out["live"], true, "sandbox pins, not the world map's");
	assert_eq!(out["sample"], json!([false, true, true]), "numbered pins drawn as a sample while off");
	assert_eq!(out["steps"], json!([15, 13.5, "2", 0.35]), "true on-map size zoomed in; the farthest at the fade's end");
	assert_eq!(out["target"], json!({ "glow": true, "icon": "icon-target" }));
	assert_eq!(json!([out["repainted"], out["hidden"], out["shown"]]), json!([30, 30, 37.5]), "repaints while shown, else on show");
	assert_eq!(out["inset"], json!([15, 30]), "Pin size: 100% beside yours");
	assert_eq!(out["zoomedOut"], json!(0.7));
	assert_eq!(out["updates"], true, "no OnUpdate");
	assert_eq!(out["icons"], json!([6, 19.8, "3"]), "six marks, a 22 px medallion zoomed in, a group's badge");
	assert_eq!(out["page"], json!({ "key": "mappins", "order": 23, "group": "look" }));
	assert_eq!(
		out["sections"],
		json!(["Pins / Target pin", "Pins / Numbered pins [nav.upcomingPins]", "Icons / Icons", "Icons / Medallions",]),
		"two tabs, a section per element, the first card live at defaults"
	);
	// Nothing a player could set is gone: every Map pins setting is on the page once (extras and cogs included).
	let mut want: Vec<&str> = vec![
		"nav.areaAlpha",
		"nav.areaColor",
		"nav.badgeSize",
		"nav.mapIcons",
		"nav.medalColor",
		"nav.minimapArrowFade",
		"nav.minimapIconSize",
		"nav.minimapPinAlpha",
		"nav.minimapPins",
		"nav.pinBacking",
		"nav.pulseSeconds",
		"nav.stepAlpha",
		"nav.stepColor",
		"nav.stepColorMode",
		"nav.stepFadeTo",
		"nav.stepNumberColor",
		"nav.stepNumberOutline",
		"nav.stepNumberSize",
		"nav.stepNumbers",
		"nav.stepPinSize",
		"nav.stepRingColor",
		"nav.targetGlow",
		"nav.targetPinSize",
		"nav.targetPulse",
		"nav.trailDotAlpha",
		"nav.trailDotSize",
		"nav.trailDots",
		"nav.upcomingCount",
		"nav.upcomingMinimap",
		"nav.upcomingPins",
		"nav.worldIconSize",
		"nav.worldPinAlpha",
		"nav.worldPins",
		"nav.stepMinimapSize",
	];
	want.sort();
	assert_eq!(out["keys"], json!(want));
	assert_eq!(out.get("missing"), None, "every new row has search words and help");
	assert_eq!(out.get("noDefault"), None, "every row's key has a default");
}

const PAGE_FILES: [&str; 5] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml", "UI/UI.xml"];

fn page(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &PAGE_FILES)],
		script: format!("uistub.install({{ noNav = true }})\nstub.login()\nPolestar.UI.LoadOptions()\nlocal UI, O, W = Polestar.UI, Polestar.UI.Options, Polestar.Widgets\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// In the window (layout v2, FIXES-V2): the Pins tab opens on the target, live at defaults; the numbered pins' on/off
// is their section's header switch and dims their rows while off; one switch and one swatch at most per row, the
// rim colour and the outline behind cogs, the pulse and its speed behind the glow's; help is the row's tooltip; a
// click on a part of the preview jumps to its row.
#[test]
fn in_the_window_the_numbered_pins_switch_heads_its_section_and_extras_and_cogs_set_their_own_settings() {
	let out = page(
		r#"
		local flashed
		local flash = O.Flash
		O.Flash = function(w, ...) flashed = w.psControl and w.psControl.key; return flash(w, ...) end
		-- Opens row's cog (a second click on the same cog closes it) -> whether every key is in it.
		local function cog(row, ...)
			if not (row and row.Cog) then return false end
			row.Cog:Click()
			local shown = O.MoreControls()
			for _, key in ipairs({ ... }) do if shown[key] == nil then return false end end
			return true
		end
		UI.ShowOptions("mappins")
		O.Select("mappins", "Pins")
		local m = O.Controls("mappins", "Pins")
		local r = { have = {} }
		for _, k in ipairs({ "nav.targetPinSize", "nav.targetGlow", "nav.worldPins", "nav.minimapPins", "nav.areaAlpha", "nav.areaColor",
			"nav.upcomingPins", "nav.stepPinSize", "nav.stepColorMode", "nav.stepColor", "nav.stepNumberSize", "nav.stepNumberColor",
			"nav.stepNumbers", "nav.upcomingCount", "nav.stepAlpha", "nav.stepFadeTo", "nav.upcomingMinimap", "nav.stepMinimapSize" }) do
			r.have[#r.have + 1] = m[k] ~= nil
		end
		-- The trail stands in for route lines: its row shows once they are off.
		r.trailHidden = m["nav.trailDotSize"] == nil or not m["nav.trailDotSize"]:IsShown()
		r.targetLive = W.Enabled(m["nav.targetPinSize"])
		r.offRow = W.Enabled(m["nav.stepPinSize"])
		m["nav.upcomingPins"]:Click()
		r.on = Polestar.Get("nav.upcomingPins")
		r.onRow = W.Enabled(m["nav.stepPinSize"])
		-- The numbers' own switch: off dims their size, the switch itself stays live.
		m["nav.stepNumbers"]:Click()
		r.numbersOff = { Polestar.Get("nav.stepNumbers"), W.Enabled(m["nav.stepNumberSize"]), W.Enabled(m["nav.stepNumbers"]) }
		m["nav.stepNumbers"]:Click("RightButton")
		r.numbersReset = Polestar.Get("nav.stepNumbers")
		r.cogs = { cog(m["nav.stepNumberSize"], "nav.stepNumberOutline"), cog(m["nav.stepPinSize"], "nav.stepRingColor"),
			cog(m["nav.targetGlow"], "nav.targetPulse", "nav.pulseSeconds") }
		-- The own colour swatch waits for "Own colour".
		r.ownBefore = W.Enabled(m["nav.stepColor"])
		Polestar.Set("nav.stepColorMode", "own")
		r.ownAfter = W.Enabled(m["nav.stepColor"])
		-- Help is the tooltip.
		local spec
		for _, s in ipairs(W.OptionsRegistry) do
			for _, c in ipairs(s.controls) do if c.key == "nav.stepPinSize" then spec = c end end
		end
		Polestar.Set("nav.stepPinSize", 2)
		local tip = O.TipOf(spec)(m["nav.stepPinSize"])
		r.tip = { type(tip[1]) == "string" and tip[1]:find("numbered pins") ~= nil, #tip }
		-- The previews' parts jump to their rows.
		local function preview(field)
			for _, f in ipairs(stub.frames) do if rawget(f, "psHotspots") and rawget(f, field) then return f end end
		end
		local P = preview("Map")
		r.hotspots = P and #P.psHotspots or 0
		for _, h in ipairs(P and P.psHotspots or {}) do
			if h[1] == "nav.targetPinSize" then h[2]:GetScript("OnClick")(h[2]) end
		end
		r.jumpedTarget = flashed
		O.Select("mappins", "Icons")
		local I = preview("Marks")
		for _, h in ipairs(I and I.psHotspots or {}) do
			if h[1] == "nav.badgeSize" then h[2]:GetScript("OnClick")(h[2]) end
		end
		r.jumpedBadge = flashed
		emit(r)"#,
	);
	assert!(out["have"].as_array().unwrap().iter().all(|v| v == true), "every setting of the Pins tab on it: {}", out["have"]);
	assert_eq!(out["trailHidden"], true, "no trail row while route lines draw the way");
	assert_eq!(out["targetLive"], true, "the first card is live at defaults");
	assert_eq!(json!([out["offRow"], out["on"], out["onRow"]]), json!([false, true, true]), "the header switch dims and wakes the rows");
	assert_eq!(out["numbersOff"], json!([false, false, true]), "numbers off: their size dims, their switch stays live");
	assert_eq!(out["numbersReset"], true, "right-click resets the inline switch");
	assert_eq!(out["cogs"], json!([true, true, true]), "outline, rim colour, pulse and its speed behind cogs");
	assert_eq!(json!([out["ownBefore"], out["ownAfter"]]), json!([false, true]));
	assert_eq!(out["tip"], json!([true, 2]), "help, then the reset hint");
	assert!(out["hotspots"].as_f64().unwrap() >= 5.0, "parts of the preview are click targets");
	assert_eq!(json!([out["jumpedTarget"], out["jumpedBadge"]]), json!(["nav.targetPinSize", "nav.badgeSize"]));
}
