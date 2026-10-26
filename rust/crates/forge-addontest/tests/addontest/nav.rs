//! Navigation (addon/Polestar/Nav): target model, arrow geometry and states, minimap projection, world map
//! pins, TomTom/Blizzard bridges, live settings. Runs the real Core/Init.lua + Nav/Nav.xml against
//! tests/lua/stub_nav.lua.

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::{json, Value};
use std::f64::consts::PI;

// Shared Lua locals for every script.
const PRELUDE: &str = r#"
local N = Polestar.Nav
local A = N.arrow
local Pins = Polestar.Pins
local function targetPin() return Pins.GetMinimapFrames("nav.target")[1] end
local nav = stub.nav
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "T")
end
local function wp(wx, wy, label, extra)
	local m, x, y = nav.mapPoint(wx, wy)
	local t = { map = m, x = x, y = y, label = label, stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 }
	for k, v in pairs(extra or {}) do t[k] = v end
	return t
end
local function pinPoint()
	local f = targetPin()
	if not f then return { shown = false } end
	local _, _, _, x, y = f:GetPoint(1)
	return { x = x, y = y, edge = f.edge:IsShown(), edgeRot = f.edge:GetRotation(), shown = f:IsShown() }
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run_themed(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}{script}"),
		..Default::default()
	})
	.remove(0)
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

// Smallest signed difference between two angles.
fn angle_diff(a: f64, b: f64) -> f64 {
	let d = (((a - b) % (2.0 * PI)) + 3.0 * PI) % (2.0 * PI) - PI;
	d.abs()
}

fn near(actual: f64, expected: f64, eps: f64, msg: &str) {
	assert!((actual - expected).abs() <= eps, "{msg} expected {expected}, got {actual}");
}

// Sheet frame for a heading, as the 3D arrow must show it (frame i = i * 3.6 degrees CCW).
const FRAMES: i64 = 100;
fn frame_of(a: f64) -> i64 {
	let pos = (((a % (2.0 * PI)) + 2.0 * PI) % (2.0 * PI)) / ((2.0 * PI) / FRAMES as f64);
	((pos.round() as i64 % FRAMES) + FRAMES) % FRAMES
}

fn round3(x: f64) -> Value {
	let r = (x * 1000.0).round() / 1000.0;
	if r.fract() == 0.0 {
		json!(r as i64)
	} else {
		json!(r)
	}
}

fn r3(c: &Value) -> Value {
	Value::Array(c.as_array().unwrap().iter().take(3).map(|v| round3(num(v))).collect())
}

fn mmss(t: &str) -> f64 {
	let parts: Vec<f64> = t.split(':').map(|p| p.parse::<f64>().unwrap_or(f64::NAN)).collect();
	parts[0] * 60.0 + parts[1]
}

#[test]
fn arrow_points_at_the_target_relative_to_facing_in_all_four_quadrants_in_both_styles() {
	let out = run(r#"
		local cases = {
			{ "N", 100, 0, 0 }, { "W", 0, 100, 0 }, { "S", -100, 0, 0 }, { "E", 0, -100, 0 },
			{ "NE", 100, -100, 0 }, { "NW", 100, 100, 0 }, { "SW", -100, 100, 0 }, { "SE", -100, -100, 0 },
			{ "N facing W", 100, 0, math.pi / 2 }, { "E facing W", 0, -100, math.pi / 2 },
			{ "N facing E", 100, 0, 3 * math.pi / 2 }, { "SW facing S", -100, 100, math.pi },
		}
		local out = {}
		for _, style in ipairs({ "3d", "flat" }) do
			Polestar.Set("nav.arrowStyle", style)
			for _, c in ipairs(cases) do
				nav.facing = c[4]
				target(c[2], c[3])
				stub.advance(1.5)
				local _, _, rel = N.Sample()
				out[#out + 1] = { style = style, name = c[1], angle = A.GetAngle(), frame = A.GetFrame() or false,
					rotation = A.body:GetRotation(), facet = A.facet:GetRotation(), rel = rel,
					sheet = A.sheet:IsShown(), body = A.body:IsShown() }
			end
		end
		emit(out)"#);
	let expected: [(&str, f64); 12] = [
		("N", 0.0),
		("W", PI / 2.0),
		("S", PI),
		("E", -PI / 2.0),
		("NE", -PI / 4.0),
		("NW", PI / 4.0),
		("SW", (3.0 * PI) / 4.0),
		("SE", (-3.0 * PI) / 4.0),
		("N facing W", -PI / 2.0),
		("E facing W", PI),
		("N facing E", PI / 2.0),
		("SW facing S", -PI / 4.0),
	];
	let out = out.as_array().unwrap();
	assert_eq!(out.len(), 2 * expected.len());
	for c in out {
		let name = text(&c["name"]);
		let want = expected.iter().find(|e| e.0 == name).unwrap().1;
		let rel = num(&c["rel"]);
		let angle = num(&c["angle"]);
		assert!(angle_diff(rel, want) < 1e-9, "{name}: bearing {rel}");
		assert!(angle_diff(angle, want) < 1e-3, "{name}: arrow heading {angle}");
		if c["style"] == "3d" {
			let pos = ((((angle % (2.0 * PI)) + 2.0 * PI) % (2.0 * PI)) / (2.0 * PI)) * FRAMES as f64;
			let tie = ((pos % 1.0) - 0.5).abs() < 1e-3; // 45 degrees sits exactly between two frames
			let neighbours = [pos.floor() as i64 % FRAMES, pos.ceil() as i64 % FRAMES];
			let frame = &c["frame"];
			let ok = *frame == frame_of(angle) || (tie && neighbours.iter().any(|&n| *frame == n));
			assert!(ok, "{name}: sheet frame {frame} for heading {angle}");
			assert_eq!(json!([c["sheet"], c["body"]]), json!([true, false]));
		} else {
			let rotation = num(&c["rotation"]);
			assert!(angle_diff(rotation, want) < 1e-3, "{name}: flat rotation {rotation}");
			assert_eq!(c["facet"], c["rotation"], "{name}: facet layer turns with the body");
			assert_eq!(c["frame"], false);
			assert_eq!(json!([c["sheet"], c["body"]]), json!([false, true]));
		}
	}
}

#[test]
fn turning_is_damped_a_new_bearing_eases_in_the_short_way_round_at_most_max_turn_a_second_turning_the_camera_moves_the_arrow_at_once() {
	let out = run(r#"
		target(100, 0)
		stub.advance(1)
		local before = A.GetAngle()
		local frames = { A.GetFrame() }
		nav.place(100, 100)                 -- the player steps west of it: the target is now to the right
		local early, later
		for i = 1, 44 do
			stub.advance(0.05)
			if i == 2 then early = A.GetAngle() elseif i == 4 then later = A.GetAngle() end
			if A.GetFrame() ~= frames[#frames] then frames[#frames + 1] = A.GetFrame() end
		end
		local settled = A.GetAngle()
		nav.facing = -math.pi / 2           -- turn to face east: the target is straight ahead
		stub.advance(0.05)
		emit({ before = before, early = early, later = later, settled = settled, faced = A.GetAngle(), frames = frames })"#);
	near(num(&out["before"]), 0.0, 1e-6, "before");
	let early = num(&out["early"]);
	let later = num(&out["later"]);
	assert!(early < 0.0 && early > -PI / 2.0, "early {early} is partway, clockwise");
	assert!(early >= -3.5 * 0.1 - 1e-6, "no faster than MAX_TURN (3.5 rad/s): {early} after 0.1 s");
	assert!(later < early && later > -PI / 2.0, "later {later} keeps closing in");
	near(num(&out["settled"]), -PI / 2.0, 1e-3, "settled");
	near(num(&out["faced"]), 0.0, 1e-3, "turning the camera: straight ahead within one frame");
	// The 3D frames wrap 0 -> 99 -> ... -> 75: clockwise, never through the back half.
	let frames: Vec<i64> = out["frames"].as_array().unwrap().iter().map(|v| v.as_i64().unwrap()).collect();
	assert_eq!(frames[0], 0);
	assert_eq!(frames[frames.len() - 1], 75);
	assert!(frames.len() > 4, "passes through intermediate frames: {frames:?}");
	for fr in &frames[1..] {
		assert!(*fr >= 75 && *fr <= 99, "frame {fr} stays on the short side");
	}
	for i in 2..frames.len() {
		assert!(frames[i] < frames[i - 1], "frames decrease: {frames:?}");
	}
}

#[test]
fn switching_nav_arrowstyle_live_keeps_heading_colour_and_the_arrived_state() {
	let out = run(r#"
		local r = {}
		local function snap()
			return { style = A.GetStyle(), sheet = A.sheet:IsShown(), spec = A.sheetSpec:IsShown(), body = A.body:IsShown(),
				facet = A.facet:IsShown(), frame = A.GetFrame() or false, rotation = A.body:GetRotation(),
				tint = { A.sheet:GetVertexColor() }, bodyTint = { A.body:GetVertexColor() }, mode = A.GetMode() }
		end
		target(0, 100)                      -- west: heading +90 degrees
		stub.advance(1)
		r.solid = snap()
		Polestar.Set("nav.arrowStyle", "flat")
		r.flat = snap()
		Polestar.Set("nav.arrowStyle", "3d")
		r.back = snap()
		nav.place(0, 96)                    -- arrive
		stub.advance(0.2)
		r.arrived3d = snap()
		Polestar.Set("nav.arrowStyle", "flat")
		r.arrivedFlat = snap()
		r.default = Polestar.GetDefault("nav.arrowStyle")
		emit(r)"#);
	assert_eq!(out["default"], "skin", "the skin's arrow by default: the 3D one in the house style");
	let solid = &out["solid"];
	assert_eq!(json!([solid["style"], solid["sheet"], solid["spec"], solid["body"], solid["frame"]]), json!(["3d", true, true, false, 25]));
	let flat = &out["flat"];
	assert_eq!(json!([flat["style"], flat["sheet"], flat["spec"], flat["body"], flat["facet"], flat["frame"]]), json!(["flat", false, false, true, true, false]));
	assert!(angle_diff(num(&flat["rotation"]), PI / 2.0) < 1e-3, "flat dart takes over the heading");
	assert_eq!(flat["bodyTint"], solid["tint"], "colour carries over");
	let back = &out["back"];
	assert_eq!(json!([back["sheet"], back["body"], back["frame"]]), json!([true, false, 25]));
	for s in [&out["arrived3d"], &out["arrivedFlat"]] {
		assert_eq!(s["mode"], "arrived");
		assert_eq!(json!([s["sheet"], s["spec"], s["body"], s["facet"]]), json!([false, false, false, false]));
	}
}

#[test]
fn distance_is_in_yards_and_the_colour_shifts_from_accent_to_success_as_you_close_in() {
	let out = run(r#"
		target(300, 400)                   -- 500 yd
		stub.advance(0.2)
		local far = { A.body:GetVertexColor() }
		local farText = A.distText:GetText()
		nav.place(282, 376)                -- (18, 24) short: 30 yd
		stub.advance(0.2)
		emit({ farText = farText, far = far, near = { A.body:GetVertexColor() }, nearText = A.distText:GetText(), dist = N.GetDistance() })"#);
	assert_eq!(out["farText"], "500 yd");
	assert_eq!(out["nearText"], "30 yd");
	near(num(&out["dist"]), 30.0, 1e-9, "");
	// Fallback palette (no Theme loaded): accent 0.902,0.729,0.4 (Dusk gold); success 0.42,0.85,0.6.
	near(num(&out["far"][0]), 0.902, 1e-6, "");
	near(num(&out["far"][2]), 0.4, 1e-6, "");
	let near0 = num(&out["near"][0]);
	let near2 = num(&out["near"][2]);
	assert!(near0 < num(&out["far"][0]), "red channel moved toward success ({near0})");
	assert!(near2 > num(&out["far"][2]), "blue channel moved toward success ({near2})");
}

#[test]
fn in_metres_the_arrow_redraws_its_distance_at_once_without_waiting_for_it_to_change() {
	let out = run(r#"
		target(300, 400)                   -- 500 yd
		stub.advance(0.2)
		local yards = A.distText:GetText()
		Polestar.Set("nav.distanceUnit", "metres")
		emit({ yards = yards, metres = A.distText:GetText() })"#);
	assert_eq!(out, json!({ "yards": "500 yd", "metres": "457 m" }));
}

#[test]
fn era_frame_targets_convert_through_the_registered_era_bounds() {
	let out = run(r#"
		-- Era frame of map 9000 is offset from the live one: era (50, 50) is world (30, -40).
		Polestar.RegisterMapFrames({ era = { [9000] = { c = 0, top = 1030, bottom = -970, left = 960, right = -1040 } } })
		N.SetTarget(9000, 50, 50, "Era point", "e")
		local era = N.GetDistance()
		local _, _, rel = N.Sample()
		N.SetTarget(9000, 50, 50, "Live point")
		emit({ era = era, rel = rel, live = N.GetDistance(), liveCoords = { N.LiveCoords({ map = 9000, x = 50, y = 50, f = "e" }) } })"#);
	near(num(&out["era"]), 50.0, 1e-9, "era distance");
	near(num(&out["rel"]), (-40f64).atan2(30.0), 1e-9, "era bearing");
	near(num(&out["live"]), 0.0, 1e-9, "live distance");
	assert_eq!(out["liveCoords"], json!([9000, 52, 48.5]));
}

#[test]
fn reaching_the_target_switches_to_the_arrived_state_with_hysteresis_one_chime_and_one_nav_arrived() {
	let out = run(r#"
		local seen, arrivals = {}, 0
		Polestar.On("NAV_ARRIVED", function(t) if t == N.GetTarget() then arrivals = arrivals + 1 end end)
		target(20, 0)
		stub.advance(0.2)
		seen[#seen + 1] = { A.GetMode(), A.distText:GetText(), #stub.sounds }
		nav.place(15, 0)                   -- 5 yd: inside the 8 yd radius
		stub.advance(0.2)
		seen[#seen + 1] = { A.GetMode(), A.distText:GetText(), #stub.sounds, A.ring:IsShown(), A.body:IsShown() }
		nav.place(10, 0)                   -- 10 yd: still arrived (hysteresis)
		stub.advance(0.2)
		seen[#seen + 1] = { A.GetMode(), #stub.sounds }
		nav.place(0, 0)                    -- 20 yd: travelling again
		stub.advance(0.2)
		seen[#seen + 1] = { A.GetMode(), A.distText:GetText(), A.ring:IsShown() }
		Polestar.Set("nav.arrivalSound", false)
		nav.place(18, 0)
		stub.advance(0.2)
		seen[#seen + 1] = { A.GetMode(), #stub.sounds }
		seen[#seen + 1] = arrivals
		emit(seen)"#);
	assert_eq!(out, json!([["travel", "20 yd", 0], ["arrived", "Arrived", 1, true, false], ["arrived", 1], ["travel", "20 yd", false], ["arrived", 1], 2]));
}

// The player's arrow colours, with Theme loaded: the arrow wears its own colour far away and the near colour
// on arrival (both styles, the ring), the target's pin follows the arrow live, and a colour too dark to read
// as the arrow's text is lifted for the text alone.
// The catch-up (CATCH_UP from the guide window): an hourglass in the dial's place that turns over, the dial
// and its text hidden; the arrow comes back.
#[test]
fn during_the_catch_up_the_arrow_shows_an_hourglass_turning_over_then_comes_back() {
	let out = run_themed(
		r#"
		local function tex(t) return (t:GetTexture() or ""):match("([^\\]+)$") end
		target(300, 400)
		stub.advance(0.2)
		Polestar.Fire("CATCH_UP", true)
		local busy = { glass = A.glass:IsShown(), dial = A.dial:GetAlpha(), text = A.distText:GetAlpha(), tex = tex(A.glassBody), sand = tex(A.glassSand), busy = A.IsBusy() }
		stub.advance(0.3)
		local upright = A.glassBody:GetRotation()
		stub.advance(0.35)
		local turning = A.glassBody:GetRotation()
		Polestar.Fire("CATCH_UP", false)
		emit({ busy = busy, upright = upright, turning = turning, after = { glass = A.glass:IsShown(), dial = A.dial:GetAlpha(), text = A.distText:GetAlpha(), busy = A.IsBusy() } })"#,
	);
	assert_eq!(out["busy"], json!({ "glass": true, "dial": 0, "text": 0, "tex": "hourglass", "sand": "hourglass-sand", "busy": true }));
	assert_eq!(out["upright"], 0, "upright first");
	let turning = num(&out["turning"]);
	assert!(turning > 0.0 && turning < PI, "then turning over ({turning})");
	assert_eq!(out["after"], json!({ "glass": false, "dial": 1, "text": 1, "busy": false }));
}

#[test]
fn the_skins_darts_the_skin_s_arrow_by_default_accent_far_and_arrival_green_within_40_m_hearth_s_baked_gold_then_the_ring_and_the_check() {
	let out = run_themed(
		r#"
		local function rgb(t) local r, g, b = t:GetVertexColor() return { r, g, b } end
		local function tex(t) return (t:GetTexture() or ""):match("([^\\]+)$") end
		local out = {}
		target(300, 400)
		stub.advance(0.2)
		out.house = A.GetStyle()
		Polestar.Set("ui.skin", "halo")
		stub.advance(0.2)
		out.halo = { style = A.GetStyle(), dart = A.dart:IsShown(), sheet = A.sheet:IsShown(), tint = rgb(A.dart), edge = rgb(A.dartEdge) }
		nav.place(300, 360)                -- 40 yd away: inside 40 m
		stub.advance(0.2)
		out.haloNear = { tint = rgb(A.dart), edge = rgb(A.dartEdge) }
		Polestar.Set("ui.skin", "hearth")
		nav.place(300, 0)
		stub.advance(0.2)
		out.bliz = { style = A.GetStyle(), tex = tex(A.dart), tint = rgb(A.dart), edge = rgb(A.dartEdge) }
		nav.place(300, 360)
		stub.advance(0.2)
		out.blizNear = { tex = tex(A.dart), tint = rgb(A.dart) }
		nav.place(300, 398)                -- arrive
		stub.advance(0.2)
		out.arrived = { mode = A.GetMode(), ring = A.skinRing:IsShown(), houseRing = A.ring:IsShown(), check = A.skinCheck:IsShown(), dart = A.dart:IsShown() }
		stub.advance(0.7)
		out.checked = A.skinCheck:IsShown()
		Polestar.Set("nav.arrowStyle", "flat")
		out.flat = A.GetStyle()
		Polestar.Set("nav.arrowStyle", "skin")
		out.looks = {}
		Polestar.Theme._testShowHidden = true
		for _, k in ipairs({ "forever", "blizzard", "classic" }) do
			Polestar.Set("ui.skin", k)
			out.looks[#out.looks + 1] = A.GetStyle()
		end
		emit(out)"#,
	);
	assert_eq!(out["house"], "3d");
	let mut halo = out["halo"].clone();
	halo["tint"] = r3(&out["halo"]["tint"]);
	halo["edge"] = r3(&out["halo"]["edge"]);
	assert_eq!(halo, json!({ "style": "halo", "dart": true, "sheet": false, "tint": [1, 0.82, 0], "edge": [0.09, 0.075, 0.055] }), "Halo: the gold dart #FFD100, edged #17130E");
	assert_eq!(r3(&out["haloNear"]["tint"]), json!([0.373, 0.816, 0.408]), "within 40 m: the arrival green #5FD068");
	assert_eq!(r3(&out["haloNear"]["edge"]), json!([0.043, 0.102, 0.047]));
	let mut bliz = out["bliz"].clone();
	bliz["tint"] = r3(&out["bliz"]["tint"]);
	bliz["edge"] = r3(&out["bliz"]["edge"]);
	assert_eq!(bliz, json!({ "style": "hearth", "tex": "dart-gold", "tint": [1, 1, 1], "edge": [0.165, 0.102, 0] }), "Hearth: the baked gold gradient, edged #2A1A00");
	assert_eq!(json!({ "tex": out["blizNear"]["tex"], "tint": r3(&out["blizNear"]["tint"]) }), json!({ "tex": "dart", "tint": [0.345, 0.753, 0.29] }), "up close: #58C04A");
	assert_eq!(out["arrived"], json!({ "mode": "arrived", "ring": true, "houseRing": false, "check": false, "dart": false }));
	assert_eq!(out["checked"], true, "the check follows the ring");
	assert_eq!(out["flat"], "flat", "a style picked by hand stays");
	assert_eq!(out["looks"], json!(["hearth", "hearth", "hearth"]), "the game's looks take Hearth's gold dart");
}

#[test]
fn chosen_arrow_colours_far_and_near_both_styles_and_the_arrival_ring_the_target_pin_follows_dark_picks_stay_legible() {
	let out = run_themed(
		r#"
		local T = Polestar.Theme
		local function rgb(t) local r, g, b = t:GetVertexColor() return { r, g, b } end
		Polestar.Set("nav.arrowColor", { 0.2, 0.45, 1 })
		Polestar.Set("nav.arrowNearColor", { 1, 0.4, 0.8 })
		target(300, 400)
		stub.advance(0.2)
		local out = { far3d = rgb(A.sheet), pinFar = rgb(targetPin().edge) }
		Polestar.Set("nav.arrowStyle", "flat")
		out.farFlat = rgb(A.body)
		nav.place(299, 399)
		stub.advance(0.2)
		out.mode, out.ring = A.GetMode(), rgb(A.ring)
		local r, g, b = A.distText:GetTextColor()
		out.arrivedText, out.nearText = { r, g, b }, { T.Color("arrowNearText") }
		out.arrivedContrast = T.Contrast(out.arrivedText, T.LightestGround())
		Polestar.Set("nav.arrowColor", { 0.9, 0.3, 0.1 })
		stub.advance(0.1)
		out.pinLive = rgb(targetPin().edge)
		-- A navy pick: the arrow keeps it, the text that wears it is lifted.
		Polestar.Set("nav.arrowNearColor", { 0.05, 0.05, 0.2 })
		local dark = { T.Color("arrowNear") }
		local text = { T.Color("arrowNearText") }
		out.darkKept = { dark[1], dark[2], dark[3] }
		out.darkContrast = T.Contrast(text, T.LightestGround())
		Polestar.Set("nav.arrowNearColor", { 0.95, 0.95, 0.85 })
		local light = { T.Color("arrowNearText") }
		out.lightText = { light[1], light[2], light[3] }
		Polestar.Set("nav.arrowColor", nil)
		Polestar.Set("nav.arrowNearColor", nil)
		out.resetFar, out.resetNear, out.accent, out.success = { T.Color("arrow") }, { T.Color("arrowNear") }, { T.Accent() }, { T.Color("success") }
		emit(out)"#,
	);
	assert_eq!(r3(&out["far3d"]), json!([0.2, 0.45, 1]), "the 3D arrow wears its own colour far away");
	assert_eq!(r3(&out["farFlat"]), json!([0.2, 0.45, 1]), "so does the flat arrow");
	assert_eq!(r3(&out["pinFar"]), json!([0.2, 0.45, 1]), "the target pin follows the arrow");
	assert_eq!(out["mode"], "arrived");
	assert_eq!(r3(&out["ring"]), json!([1, 0.4, 0.8]), "the arrival ring wears the near colour");
	assert_eq!(r3(&out["arrivedText"]), r3(&out["nearText"]), "\"Arrived\" wears the near colour's legible form");
	let arrived_contrast = num(&out["arrivedContrast"]);
	assert!(arrived_contrast >= 4.5 - 1e-6, "\"Arrived\" reads at {arrived_contrast:.2}:1");
	assert_eq!(r3(&out["pinLive"]), json!([0.9, 0.3, 0.1]), "the pin repaints live");
	assert_eq!(r3(&out["darkKept"]), json!([0.05, 0.05, 0.2]), "the arrow keeps a dark pick");
	let dark_contrast = num(&out["darkContrast"]);
	assert!(dark_contrast >= 4.5, "its text is lifted to {dark_contrast:.2}:1");
	assert_eq!(r3(&out["lightText"]), json!([0.95, 0.95, 0.85]), "a light pick is left alone");
	assert_eq!(r3(&out["resetFar"]), r3(&out["accent"]), "reset: the accent again");
	assert_eq!(r3(&out["resetNear"]), r3(&out["success"]), "reset: success again");
}

#[test]
fn an_area_target_is_arrived_anywhere_inside_it_shows_the_distance_to_its_edge_outside_and_draws_its_area_under_the_target_pin() {
	let out = run(r#"
		WorldMapFrame.Child:SetSize(1000, 1000)
		local seen = {}
		local function snap()
			seen[#seen + 1] = { A.GetMode(), A.distText:GetText(), A.labelText:GetText(), math.floor(N.GetDistance() + 0.5) }
		end
		nav.setWaypoint(wp(200, 0, "Kill Bristlebacks", { kind = "kill", area = 60 }))
		stub.advance(0.2); snap()                     -- 200 yd from the centre: 140 to the edge
		nav.place(150, 0); stub.advance(0.2); snap()  -- 50 from the centre: inside
		nav.place(260, 0); stub.advance(0.2); snap()  -- 60 on the far side: on the edge
		nav.place(125, 0); stub.advance(0.2); snap()  -- 75: 15 past the edge
		nav.showWorldMap(9000)
		local areas = nav.pins("areas")
		local r = { seen = seen, areas = #areas }
		r.size = math.floor(areas[1].width + 0.5)
		r.at = { nav.worldPoint(areas[1]) }
		for _, pin in ipairs(nav.pins()) do
			if pin.data.layer.name == "nav.target" then r.pin = { nav.worldPoint(pin) } end
		end
		nav.setWaypoint(wp(100, 0, "A point"))
		r.pointAreas = #nav.pins("areas")
		emit(r)"#);
	assert_eq!(
		out["seen"],
		json!([
			["travel", "140 yd", "Kill Bristlebacks", 140],
			["arrived", "Arrived", "Kill Bristlebacks", 0],
			["arrived", "Arrived", "Kill Bristlebacks", 0],
			["travel", "15 yd", "Kill Bristlebacks", 15]
		])
	);
	assert_eq!(out["areas"], 1);
	assert_eq!(out["size"], 60, "diameter: 2 x 60 yd = 6 % of a 1000 px canvas");
	assert_eq!(out["at"], out["pin"], "the disc sits under the target pin");
	assert_eq!(out["pointAreas"], 0, "a point target draws no disc");
}

// An area objective's waypoint with three spots at world (200, 0), (0, 300) and (-200, 0), the first one
// current; the stub Engine's CycleSpot records calls and moves the waypoint as the real one does.
const SEARCH: &str = r#"
local spotsAt = { { 200, 0 }, { 0, 300 }, { -200, 0 } }
local spots = {}
for i, p in ipairs(spotsAt) do
	local _, x, y = nav.mapPoint(p[1], p[2])
	spots[i] = { x = x, y = y, r = 60, n = 2 }
end
local cycled = {}
local function searchWp(i)
	return wp(spotsAt[i][1], spotsAt[i][2], "Collect Raptor Head", { kind = "collect", area = 60, search = true, spots = spots, spot = i })
end
function nav.Engine.CycleSpot(step, goal, index)
	cycled[#cycled + 1] = { step, goal, index or 0 }
	local i = index or (nav.engine.waypoint.spot % #spots + 1)
	nav.setWaypoint(searchWp(i))
	return i
end
"#;

#[test]
fn an_area_objective_never_says_arrived_inside_a_spot_the_arrow_says_to_search_here_and_how_to_move_on() {
	let out = run(&[
		SEARCH,
		r#"
		local seen = {}
		local function snap()
			seen[#seen + 1] = { A.GetMode(), A.distText:GetText(), A.labelText:GetText(), A.etaText:IsShown() and A.etaText:GetText() or false, A.ring:IsShown() }
		end
		nav.setWaypoint(searchWp(1))
		stub.advance(0.2); snap()                      -- 200 yd out: travelling
		nav.place(170, 0); stub.advance(0.2); snap()   -- inside the spot
		emit(seen)"#,
	]
	.concat());
	assert_eq!(out, json!([["travel", "140 yd", "Collect Raptor Head", false, false], ["search", "Search here", "Collect Raptor Head", "Click the arrow for the next spot", true]]));
}

#[test]
fn clicking_an_area_objective_s_arrow_moves_to_the_next_spot_a_drag_only_moves_the_arrow() {
	let out = run(&[
		SEARCH,
		r#"
		nav.setWaypoint(searchWp(1))
		stub.advance(0.2)
		local f = A.frame
		local function click()
			stub.RunScript(f, "OnMouseDown", "LeftButton")
			stub.RunScript(f, "OnMouseUp", "LeftButton")
		end
		local r = {}
		click()
		r.afterClick = { #cycled, N.GetTarget().spot }
		stub.RunScript(f, "OnMouseDown", "LeftButton")
		stub.RunScript(f, "OnDragStart")
		stub.RunScript(f, "OnDragStop")
		stub.RunScript(f, "OnMouseUp", "LeftButton")
		r.afterDrag = { #cycled, N.GetTarget().spot }
		target(50, 50)                                  -- a plain point: clicks do nothing
		click()
		r.plain = #cycled
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "afterClick": [1, 2], "afterDrag": [1, 2], "plain": 1 }));
}

#[test]
fn the_world_map_marks_every_other_spot_of_an_area_objective_clicking_one_searches_there_next() {
	let out = run(&[
		SEARCH,
		r#"
		nav.setWaypoint(searchWp(1))
		nav.showWorldMap(9000)
		local r = { marks = {} }
		local marks = {}
		for _, pin in ipairs(nav.pins()) do
			if pin.data.layer.name == "nav.spots" then
				marks[#marks + 1] = pin
				r.marks[#r.marks + 1] = { pin.data.x / 100, pin.data.y / 100, nav.tooltipOf(pin)[2] }
			end
		end
		nav.click(marks[2], "LeftButton")
		r.cycled = cycled[1]
		r.spot = N.GetTarget().spot
		local after = 0
		for _, pin in ipairs(nav.pins()) do if pin.data.layer.name == "nav.spots" then after = after + 1 end end
		r.after = after
		Polestar.Set("nav.worldPins", false)
		r.off = #nav.pins()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["marks"], json!([[0.35, 0.5, "Spot 2 of 3"], [0.5, 0.6, "Spot 3 of 3"]]));
	assert_eq!(out["cycled"], json!([1, 1, 3]));
	assert_eq!(out["spot"], 3);
	assert_eq!(out["after"], 2, "marks rebuilt around the new spot");
	assert_eq!(out["off"], 0);
}

#[test]
fn the_other_places_a_target_spawns_are_marked_fainter_and_smaller_and_say_so() {
	let out = run(&[
		SEARCH,
		r#"
		spots[3].alt = true
		nav.setWaypoint(searchWp(1))
		nav.showWorldMap(9000)
		local marks = {}
		for _, pin in ipairs(nav.pins()) do
			if pin.data.layer.name == "nav.spots" then
				local tip = nav.tooltipOf(pin)
				marks[#marks + 1] = { tip[2], tip[3], math.floor(pin.width * 10 + 0.5) / 10 }
			end
		end
		emit(marks)"#,
	]
	.concat());
	assert_eq!(out.as_array().unwrap().len(), 2);
	let camp = &out[0];
	let alt = &out[1];
	assert_eq!(json!([camp[0], camp[1]]), json!(["Spot 2 of 3", "Click to search here next"]));
	assert_eq!(json!([alt[0], alt[1]]), json!(["Spot 3 of 3", "It also spawns here"]));
	assert!(num(&alt[2]) < num(&camp[2]), "the alt mark is smaller ({} vs {})", alt[2], camp[2]);
}

#[test]
fn the_regions_the_step_s_open_goals_spawn_in_are_on_the_map_the_target_s_goal_s_on_the_minimap_too() {
	let out = run(&[
		SEARCH,
		r#"
		spots[2].x, spots[2].y = select(2, nav.mapPoint(0, 250))        -- 250 yd west: its region reaches into the minimap
		spots[3].alt = true
		local function spot(wx, wy, r, alt)
			local _, x, y = nav.mapPoint(wx, wy)
			return { x = x, y = y, r = r, n = 3, alt = alt }
		end
		local guide = { steps = { { goals = {
			{ t = "collect", map = 9000, spots = spots },
			{ t = "kill", map = 9000, spots = { spot(100, 100, 40), spot(150, -150, 30), spot(-300, 0, 15, true) } },
			{ t = "kill", map = 9000, spots = { spot(-100, -100, 40) } },
			{ t = "goto", map = 9000, x = 40, y = 40 },
		} } } }
		function nav.Engine.GetGuide() return guide end
		nav.engine.views[1] = { index = 1, goals = {
			{ index = 1, status = "active", text = "Collect Raptor Head", map = 9000, x = spots[1].x, y = spots[1].y },
			{ index = 2, status = "active", text = "Kill Raptors", map = 9000, x = 45, y = 45 },
			{ index = 3, status = "done", text = "Kill Boars", map = 9000, x = 55, y = 55 },
			{ index = 4, status = "pending", text = "Go there", map = 9000, x = 40, y = 40 },
		} }
		local function alphas(layer)
			local r = {}
			for _, p in ipairs(Pins.GetLayer(layer) or {}) do r[#r + 1] = { #p.hull / 2, math.floor(p.color[4] * 100 + 0.5), p.areaOnly } end
			return r
		end
		local function minimap()
			return { #Pins.GetMinimapAreas("nav.target"), #Pins.GetMinimapHulls("nav.areas"), #Pins.GetMinimapHulls("nav.goalAreas") }
		end
		nav.setWaypoint(searchWp(1))
		nav.showWorldMap(9000)
		stub.advance(0.3)
		local r = {}
		r.world = { #nav.pins("hulls"), #nav.pins("areas") }
		r.own, r.others = alphas("nav.areas"), alphas("nav.goalAreas")
		local ar, ag, ab = N.RGB("arrow")
		local pr = N.RGB("place")
		r.ownColor = Pins.GetLayer("nav.areas")[1].color[1] == ar and Pins.GetLayer("nav.areas")[1].color[3] == ab
		r.otherColor = Pins.GetLayer("nav.goalAreas")[1].color[1] == pr
		r.minimap = minimap()
		N.NextSpot(2)                                                    -- the target moves on: the regions stay
		stub.advance(0.3)
		r.cycled = { N.GetTarget().spot, #Pins.GetLayer("nav.areas"), Pins.GetLayer("nav.target")[1].area == nil }
		N.SetTarget(9000, 30, 30, "Somewhere")                          -- a point picked by hand: every goal's regions in the goals' colour
		stub.advance(0.3)
		r.manual = { Pins.GetLayer("nav.areas") ~= nil, #Pins.GetLayer("nav.goalAreas") }
		N.ReleaseTarget()
		Polestar.Set("nav.minimapPins", false)
		stub.advance(0.3)
		r.minimapOff = minimap()
		Polestar.Set("nav.worldPins", false)
		r.worldOff = #nav.pins("hulls")
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["world"], json!([6, 0]), "every open goal's regions, none for a done goal; no disc under the target: its region covers it");
	assert_eq!(
		out["own"],
		json!([[8, 100, true], [8, 100, true], [8, 60, true]]),
		"the target's goal: a region per place (too far apart to join; small ones are 8-gons), the other places it spawns fainter"
	);
	assert_eq!(out["others"], json!([[8, 60, true], [8, 60, true], [8, 35, true]]), "the other goal's regions, a step fainter");
	assert_eq!(out["ownColor"], true, "the target's goal wears the arrow's colour");
	assert_eq!(out["otherColor"], true, "the other goals wear their pins' colour");
	assert_eq!(out["minimap"], json!([0, 3, 0]), "the minimap: the target's goal's regions in reach, not the other goals'");
	assert_eq!(out["cycled"], json!([2, 3, true]));
	assert_eq!(out["manual"], json!([false, 6]));
	assert_eq!(out["minimapOff"], json!([0, 0, 0]));
	assert_eq!(out["worldOff"], 0);
}

// Teldrassil's "The Balance of Nature" as the pack compiles it (Era frame of map 1438: 5092 x 3394 yd).
const TELDRASSIL: &str = r#"
local frame = { c = 1, left = 3814.583, right = -1277.083, top = 11831.25, bottom = 8437.5 }
nav.era[1438], nav.maps[1438] = frame, frame
local goals = {
	{ t = "kill", quest = 456, target = "Young Nightsaber", npc = 2031, count = 7, oi = 1, map = 1438, x = 57.87, y = 44.69, f = "e", spots = { { x = 57.2, y = 44.6, r = 35, n = 2 }, { x = 58.5, y = 46.1, r = 23, n = 3 }, { x = 61.3, y = 44.9, r = 63, n = 7 }, { x = 61.5, y = 40.1, r = 30, n = 2 }, { x = 62.4, y = 42.1, r = 50, n = 5 }, { x = 64.3, y = 41.3, r = 29, n = 2 }, { x = 57.9, y = 39, r = 15, n = 1, alt = true } } },
	{ t = "kill", quest = 456, target = "Young Thistle Boar", npc = 1984, count = 4, oi = 2, map = 1438, x = 57.44, y = 45.02, f = "e", spots = { { x = 57.1, y = 45, r = 34, n = 3 }, { x = 59, y = 44.7, r = 47, n = 4 }, { x = 55.7, y = 42.4, r = 48, n = 6 }, { x = 60.9, y = 46, r = 18, n = 2 }, { x = 61.7, y = 42.6, r = 51, n = 4 }, { x = 57.8, y = 42.4, r = 15, n = 1, alt = true }, { x = 57.6, y = 39.5, r = 15, n = 1, alt = true }, { x = 63.2, y = 42.2, r = 15, n = 1, alt = true } } },
	{ t = "collect", quest = 459, item = 3297, itemName = "Fel Moss", count = 8, oi = 1, map = 1438, x = 56.16, y = 45.81, f = "e", spots = { { x = 55.9, y = 45.9, r = 40, n = 6 }, { x = 54.6, y = 44.1, r = 40, n = 6 }, { x = 55.8, y = 41.6, r = 40, n = 1 }, { x = 56.2, y = 38.5, r = 40, n = 1 }, { x = 54.4, y = 39.1, r = 40, n = 7 }, { x = 56.3, y = 34.6, r = 40, n = 1 }, { x = 59.6, y = 35, r = 40, n = 1 }, { x = 62.3, y = 35.7, r = 40, n = 1 }, { x = 64.2, y = 42.2, r = 40, n = 1 } }, spread = true },
	{ t = "interact", quest = 97977, object = 668482, objName = "Gnarlpine Totem", oi = 1, map = 1438, x = 56, y = 46.1, f = "e", spots = { { x = 56, y = 46.1, r = 15, n = 1 }, { x = 55.2, y = 44.2, r = 36, n = 2 }, { x = 56.2, y = 39.4, r = 15, n = 1 }, { x = 54.6, y = 39.7, r = 26, n = 2 } } },
}
local guide = { steps = { { goals = goals } } }
function nav.Engine.GetGuide() return guide end
local views = {}
for i, g in ipairs(goals) do views[i] = { index = i, status = "active", text = g.target or g.itemName or g.objName, map = 1438, x = g.x, y = g.y, f = "e" } end
nav.engine.views[1] = { index = 1, goals = views }
-- Is (x, y) inside the convex polygon { x1, y1, ... }?
local function inside(poly, x, y)
	local sign = 0
	for i = 1, #poly, 2 do
		local j = i + 2 > #poly and 1 or i + 2
		local c = (poly[j] - poly[i]) * (y - poly[i + 1]) - (poly[j + 1] - poly[i + 1]) * (x - poly[i])
		local s = c > 0 and 1 or c < 0 and -1 or 0
		if s ~= 0 then
			if sign ~= 0 and s ~= sign then return false end
			sign = s
		end
	end
	return true
end
"#;

#[test]
fn a_teldrassil_step_s_spawn_regions_cover_every_spawn_of_its_goals_and_read_at_world_map_scale() {
	let out = run(&[
		TELDRASSIL,
		r#"
		local r = { goals = {} }
		for g, goal in ipairs(goals) do
			local regions = N.layers.Regions(goal)
			-- Every spot's disc (its spawns lie in it) inside one region, checked
			-- at 32 points on its rim.
			local covered = 0
			for _, s in ipairs(goal.spots) do
				local c, wx, wy = nav.Compat.MapToWorld(1438, s.x, s.y, "e")
				for _, rg in ipairs(regions) do
					local all = true
					for k = 0, 31 do
						local a = k * math.pi / 16
						if not inside(rg.hull, wx + s.r * math.cos(a), wy + s.r * math.sin(a)) then all = false; break end
					end
					if all then covered = covered + 1; break end
				end
			end
			local spans = {}
			for i, rg in ipairs(regions) do
				local x0, x1, y0, y1 = math.huge, -math.huge, math.huge, -math.huge
				for k = 1, #rg.hull, 2 do
					x0, x1 = math.min(x0, rg.hull[k]), math.max(x1, rg.hull[k])
					y0, y1 = math.min(y0, rg.hull[k + 1]), math.max(y1, rg.hull[k + 1])
				end
				spans[i] = { math.floor(y1 - y0 + 0.5), math.floor(x1 - x0 + 0.5), rg.n, rg.alt }
			end
			r.goals[g] = { spots = #goal.spots, covered = covered, regions = spans }
		end
		-- The arrow on Fel Moss; the world map open on Teldrassil at its art's size.
		local moss = goals[3]
		nav.setWaypoint({ map = 1438, x = moss.spots[1].x, y = moss.spots[1].y, f = "e", label = "Fel Moss", stepIndex = 1, goalIndex = 3,
			kind = "collect", r = 8, area = 40, search = true, spots = moss.spots, spot = 1 })
		WorldMapFrame.Child:SetSize(1002, 668)
		nav.showWorldMap(1438)
		stub.advance(0.3)
		r.world = {}
		for _, pin in ipairs(nav.pins("hulls")) do
			local _, _, _, fill = pin.texs[1]:GetVertexColor()
			local _, _, _, rim = pin.texs[pin.used]:GetVertexColor()
			r.world[#r.world + 1] = { pin.data.layer.name, math.floor(pin.width + 0.5), math.floor(pin.height + 0.5),
				math.floor(fill * 100 + 0.5), math.floor(rim * 100 + 0.5) }
		end
		r.target = { #nav.pins("areas"), Pins.GetLayer("nav.target")[1].area == nil }
		r.stats = Pins.AreaStats()
		emit(r)"#,
	]
	.concat());
	let goals = out["goals"].as_array().unwrap();
	for (g, goal) in goals.iter().enumerate() {
		assert_eq!(goal["covered"], goal["spots"], "goal {}: every spot's spawns lie in a region", g + 1);
	}
	let lens: Vec<usize> = goals.iter().map(|g| g["regions"].as_array().unwrap().len()).collect();
	assert_eq!(lens, vec![2, 1, 2, 1], "the camps around Aldrassil are one region each; a lone far spawn is its own");
	let moss = &goals[2]["regions"][0];
	let lone = &goals[2]["regions"][1];
	assert!(num(&moss[0]) >= 450.0 && num(&moss[1]) >= 450.0, "Fel Moss: the Grells' woods west and north of the tree, about 500 x 480 yd ({moss})");
	assert_eq!(json!([moss[2], moss[3]]), json!([24, false]));
	assert_eq!(json!([lone[2], lone[3]]), json!([1, false]));
	// The 0.2.4 discs: a 40 yd spot on this 1002-unit canvas was 2 x 40 / 5092 x 1002 = 16 units wide, under a
	// 22 px target pin. The region the arrow's goal spawns in is six times that.
	let world = out["world"].as_array().unwrap();
	let mut own: Vec<&Value> = world.iter().filter(|p| p[0] == "nav.areas").collect();
	own.sort_by(|a, b| num(&b[1]).partial_cmp(&num(&a[1])).unwrap());
	assert_eq!(own.len(), 2);
	assert!(num(&own[0][1]) >= 96.0 && num(&own[0][2]) >= 90.0, "the Fel Moss region spans about 100 x 95 canvas units ({})", own[0]);
	assert_eq!(Value::from(own[0].as_array().unwrap()[3..].to_vec()), json!([20, 70]), "the arrow's goal: fill 0.2, rim 0.7");
	let mut others: Vec<Value> = world.iter().filter(|p| p[0] == "nav.goalAreas").map(|p| Value::from(p.as_array().unwrap()[3..].to_vec())).collect();
	others.sort_by_key(|v| v.to_string());
	let mut want = vec![json!([12, 42]), json!([12, 42]), json!([12, 42]), json!([7, 24])];
	want.sort_by_key(|v| v.to_string());
	assert_eq!(others, want, "the step's other goals' regions, fainter (fill 0.12, rim 0.42), a place only the Nightsabers' alternatives cover fainter still");
	assert_eq!(out["target"], json!([0, true]), "no disc under the target: its region covers it");
	assert_eq!(out["stats"]["world"]["hulls"], 6);
}

#[test]
fn hidden_on_a_taxi_in_an_instance_and_without_a_target_zone_name_on_another_continent() {
	let out = run(r#"
		local seen = {}
		local function snap(tag) seen[#seen + 1] = { tag, A.frame:IsShown(), A.GetMode() or "hidden", A.distText:GetText() } end
		target(100, 0)
		stub.advance(0.1); snap("start")
		nav.taxi = true
		stub.advance(0.1); snap("taxi")
		nav.taxi = false
		stub.advance(1.1); snap("landed")
		nav.instance = true
		Polestar.Nav.Refresh(); snap("instance")
		nav.instance = false
		stub.advance(1.1); snap("left instance")
		nav.place(0, 0, 1)                 -- other continent
		stub.advance(0.1); snap("far")
		seen[#seen + 1] = { "far dial", A.dial:IsShown(), A.etaText:IsShown() }
		nav.place(0, 0, 0)
		stub.advance(0.1); snap("back")
		N.ClearTarget()
		snap("cleared")
		emit(seen)"#);
	assert_eq!(
		out,
		json!([
			["start", true, "travel", "100 yd"],
			["taxi", false, "hidden", "100 yd"],
			["landed", true, "travel", "100 yd"],
			["instance", false, "hidden", "100 yd"],
			["left instance", true, "travel", "100 yd"],
			["far", true, "far", "Testshire"],
			["far dial", false, true],
			["back", true, "travel", "100 yd"],
			["cleared", false, "hidden", "100 yd"]
		])
	);
}

// The Deeprun Tram is a map of its own with no world map: the client gives no player position there (nor in
// some loading moments). The arrow says so over the target's label instead of vanishing, and points again
// once a position returns.
#[test]
fn without_a_player_position_the_arrow_says_so_keeps_the_label_and_points_again_when_one_returns() {
	let out = run(r#"
		local seen = {}
		local function snap(tag)
			seen[#seen + 1] = { tag, A.frame:IsShown(), A.GetMode() or "hidden", A.distText:GetText(), A.labelText:GetText(),
				A.dial:IsShown(), A.etaText:IsShown() }
		end
		target(100, 0, "Nightbane Shadow Weavers")
		stub.advance(0.1); snap("start")
		nav.player = nil
		stub.advance(0.1); snap("no position")
		seen[#seen + 1] = { "state", (N.Sample()), N.GetDistance() or false }
		nav.place(0, 0, 0)
		stub.advance(0.1); snap("back")
		N.ClearTarget()
		nav.player = nil
		stub.advance(1.1)
		seen[#seen + 1] = { "no target", A.frame:IsShown(), A.GetMode() or "hidden" }
		emit(seen)"#);
	assert_eq!(
		out,
		json!([
			["start", true, "travel", "100 yd", "Nightbane Shadow Weavers", true, false],
			["no position", true, "nopos", "No position here", "Nightbane Shadow Weavers", false, false],
			["state", "nopos", false],
			["back", true, "travel", "100 yd", "Nightbane Shadow Weavers", true, false],
			["no target", false, "hidden"]
		])
	);
}

#[test]
fn releasetarget_drops_only_the_override_and_guides_to_the_engine_waypoint_again() {
	let out = run(r#"
		local seen = {}
		local function snap() local t = N.GetTarget(); seen[#seen + 1] = t and t.label or "nil" end
		nav.setWaypoint(wp(100, 0, "Engine A"))
		N.ReleaseTarget(); snap()                     -- no override: nothing changes
		local m, x, y = nav.mapPoint(0, 100)
		N.SetTarget(m, x, y, "Corpse"); snap()
		N.ReleaseTarget(); snap()
		emit({ seen = seen, override = N.IsOverride() })"#);
	assert_eq!(out["seen"], json!(["Engine A", "Corpse", "Engine A"]));
	assert_eq!(out["override"], false);
}

#[test]
fn settarget_overrides_the_engine_waypoint_until_the_step_changes() {
	let out = run(r#"
		local announced = {}
		Polestar.On("WAYPOINT_CHANGED", function(w) announced[#announced + 1] = w and w.label or "nil" end)
		local seen = {}
		local function snap() local t = N.GetTarget(); seen[#seen + 1] = t and t.label or "nil" end
		nav.setWaypoint(wp(100, 0, "Engine A")); snap()
		local m, x, y = nav.mapPoint(0, 100)
		N.SetTarget(m, x, y, "Mine"); snap()
		nav.setWaypoint(wp(50, 0, "Engine A2")); snap()     -- same step, engine moved on
		nav.changeStep(2, wp(0, -50, "Engine B", { stepIndex = 2 })); snap()
		N.ClearTarget(); snap()                             -- dismiss the engine waypoint
		nav.setWaypoint(wp(0, -50, "Engine B", { stepIndex = 2 })); snap()   -- same point: stays dismissed
		nav.setWaypoint(wp(0, -80, "Engine C", { stepIndex = 2, goalIndex = 2 })); snap()
		emit({ seen = seen, announced = announced, override = N.IsOverride() })"#);
	assert_eq!(out["seen"], json!(["Engine A", "Mine", "Mine", "Engine B", "nil", "nil", "Engine C"]));
	// Engine announcements, plus Nav's own when it sets/clears an override.
	assert_eq!(out["announced"], json!(["Engine A", "Mine", "Engine A2", "Engine B", "nil", "Engine B", "Engine C"]));
	assert_eq!(out["override"], false);
}

#[test]
fn polestar_way_decimal_points_or_commas_in_both_a_comma_separator_labels_range_0_100_empty_clears_a_decimal_comma_in_one_is_refused_it_could_be_x_y_and_a_numeric_label() {
	let out = run(r#"
		nav.place(0, 0)
		local function way(line)
			N.SetTarget(9000, 1, 1, "Before")
			local before = #stub.messages
			SlashCmdList.POLESTAR("way " .. line)
			local t = N.GetTarget()
			return { t and t.x or false, t and t.y or false, t and t.label or false, #stub.messages > before }
		end
		local r = {}
		for _, line in ipairs({ "45 30", "45,30", "45, 30", "45.5 30.2", "45.5 30", "45 30.2", "45,5 30,2",
			"45 30 Camp", "45,30 Camp", "45, 30 Camp", "45,5 30,2 Camp", "45,30 2nd camp", "45 30 50", "0 100",
			"45,5 30", "45 30,2", "45,30 50", "45,30 2 camp", "45,5 30 Camp", "45.5 30,2",
			"100.5 30", "45 101", "45,5 300,2", "abc", "45", "45 .", "45.5.5 30", "" }) do
			r[line] = way(line)
		end
		emit(r)"#);
	fn usage(o: &Value) -> bool {
		o[2] == "Before" && o[3] == true
	}
	fn at(o: &Value, x: f64, y: f64, label: &str) {
		near(num(&o[0]), x, 1e-9, "x");
		near(num(&o[1]), y, 1e-9, "y");
		assert_eq!(o[2], label);
		assert_eq!(o[3], false, "no usage message");
	}
	at(&out["45 30"], 45.0, 30.0, "Waypoint");
	at(&out["45,30"], 45.0, 30.0, "Waypoint");
	at(&out["45, 30"], 45.0, 30.0, "Waypoint");
	at(&out["45.5 30.2"], 45.5, 30.2, "Waypoint");
	at(&out["45.5 30"], 45.5, 30.0, "Waypoint");
	at(&out["45 30.2"], 45.0, 30.2, "Waypoint");
	at(&out["45,5 30,2"], 45.5, 30.2, "Waypoint");
	at(&out["45 30 Camp"], 45.0, 30.0, "Camp");
	at(&out["45,30 Camp"], 45.0, 30.0, "Camp");
	at(&out["45, 30 Camp"], 45.0, 30.0, "Camp");
	at(&out["45,5 30,2 Camp"], 45.5, 30.2, "Camp");
	at(&out["45,30 2nd camp"], 45.0, 30.0, "2nd camp");
	at(&out["45 30 50"], 45.0, 30.0, "50");
	at(&out["0 100"], 0.0, 100.0, "Waypoint");
	// A decimal comma in one coordinate only is x,y and a numeric label or a decimal x and y: refused rather
	// than guessed.
	for line in ["45,5 30", "45 30,2", "45,30 50", "45,30 2 camp", "45,5 30 Camp", "45.5 30,2", "100.5 30", "45 101", "45,5 300,2", "abc", "45", "45 .", "45.5.5 30"] {
		assert!(usage(&out[line]), "{line}: usage, target kept ({})", out[line]);
	}
	assert_eq!(out[""], json!([false, false, false, false]), "empty clears without a message");
}

#[test]
fn minimap_projection_honours_view_radius_rotation_and_clamps_to_the_rim() {
	let out = run(r#"
		local r = {}
		nav.viewRadius = 200               -- 140 px minimap: 0.35 px per yard
		SetCVar("rotateMinimap", "0")
		target(100, 0); stub.advance(0.1); r.north = pinPoint()
		target(0, 100); stub.advance(0.1); r.west = pinPoint()
		nav.facing = math.pi / 2           -- facing west; must not matter on a fixed minimap
		target(-60, -80); stub.advance(0.1); r.southeast = pinPoint()
		SetCVar("rotateMinimap", "1")
		target(0, 100); stub.advance(0.1); r.rotWest = pinPoint()
		target(100, 0); stub.advance(0.1); r.rotNorth = pinPoint()
		SetCVar("rotateMinimap", "0")
		nav.facing = 0
		target(0, -900); stub.advance(0.1); r.farEast = pinPoint()
		GetMinimapShape = function() return "SQUARE" end
		target(900, -900); stub.advance(0.1); r.squareCorner = pinPoint()
		GetMinimapShape = nil
		nav.viewRadius = nil               -- no C_Minimap radius: zoom tables
		stub.minimapZoom = 5
		target(50, 0); stub.advance(0.1); r.zoom5 = pinPoint()
		nav.indoors = true
		stub.minimapZoom = 0
		stub.advance(0.25); r.indoor0 = pinPoint()
		emit(r)"#);
	let s = 0.35;
	let e = 1e-6;
	near(num(&out["north"]["x"]), 0.0, e, "");
	near(num(&out["north"]["y"]), 100.0 * s, e, "");
	near(num(&out["west"]["x"]), -100.0 * s, e, "");
	near(num(&out["west"]["y"]), 0.0, e, "");
	near(num(&out["southeast"]["x"]), 80.0 * s, e, "");
	near(num(&out["southeast"]["y"]), -60.0 * s, e, "");
	assert_eq!(out["north"]["edge"], false);
	// Rotating minimap facing west: west is up, north is to the right.
	near(num(&out["rotWest"]["x"]), 0.0, e, "");
	near(num(&out["rotWest"]["y"]), 100.0 * s, e, "");
	near(num(&out["rotNorth"]["x"]), 100.0 * s, e, "");
	near(num(&out["rotNorth"]["y"]), 0.0, e, "");
	// Out of range: pinned to the rim, pointer turned outward (east = -90 degrees).
	let limit = 70.0 - 14.0 * 1.4 * 0.35;
	near(num(&out["farEast"]["x"]), limit, e, "");
	near(num(&out["farEast"]["y"]), 0.0, e, "");
	assert_eq!(out["farEast"]["edge"], true);
	near(num(&out["farEast"]["edgeRot"]), -PI / 2.0, e, "");
	near(num(&out["squareCorner"]["x"]), limit, e, "");
	near(num(&out["squareCorner"]["y"]), limit, e, "");
	// Zoom level 5 outdoors spans 133.3 yd; indoors zoom 0 spans 300 yd.
	near(num(&out["zoom5"]["y"]), 50.0 * (70.0 / (400.0 / 6.0)), 1e-6, "");
	near(num(&out["indoor0"]["y"]), 50.0 * (70.0 / 150.0), 1e-6, "");
	assert_eq!(out["zoom5"]["edge"], false);
}

#[test]
fn tomtom_mirrors_the_target_one_waypoint_replaced_on_change_removed_when_cleared_or_disabled() {
	let out = run(r#"
		nav.withTomTom()
		Polestar.RegisterMapFrames({ era = { [9000] = { c = 0, top = 1030, bottom = -970, left = 960, right = -1040 } } })
		target(100, 0, "First")
		target(0, 100, "Second")
		N.SetTarget(9000, 50, 50, "Era", "e")
		N.ClearTarget()
		target(-100, 0, "Third")
		Polestar.Set("nav.useTomTomArrow", true)
		local arrowWithTomTom = A.frame:IsShown()
		Polestar.Set("nav.tomtom", false)
		emit({ calls = TomTom.calls, arrowWithTomTom = arrowWithTomTom, arrowAfter = A.frame:IsShown() })"#);
	let calls: Vec<String> = out["calls"]
		.as_array()
		.unwrap()
		.iter()
		.map(|c| if c["op"] == "add" { format!("add#{} {} {},{} crazy={}", c["id"], text(&c["title"]), c["x"], c["y"], c["crazy"]) } else { format!("remove#{}", c["id"]) })
		.collect();
	assert_eq!(
		calls,
		vec![
			"add#1 First 0.5,0.45 crazy=false",
			"remove#1",
			"add#2 Second 0.45,0.5 crazy=false",
			"remove#2",
			"add#3 Era 0.52,0.485 crazy=false",
			"remove#3",
			"add#4 Third 0.5,0.55 crazy=false",
			"remove#4",
			"add#5 Third 0.5,0.55 crazy=true",
			"remove#5",
		]
	);
	// Polestar draws its own pins, so TomTom's are off.
	assert_eq!(out["calls"][0]["minimap"], false);
	assert_eq!(out["calls"][0]["world"], false);
	assert_eq!(out["arrowWithTomTom"], false, "TomTom arrow replaces ours");
	assert_eq!(out["arrowAfter"], true, "ours returns when the bridge is off");
}

#[test]
fn the_arrow_takes_the_mouse_on_its_dial_only_and_the_hover_wash_sits_behind_the_dial() {
	let out = run(r#"
		local l, r, t, b = A.frame:GetHitRectInsets()
		local _, rel = A.mover:GetPoint(1)
		stub.RunScript(A.frame, "OnEnter")
		emit({ insets = { l, r, t, b }, washOnDial = rel == A.dial, washShown = A.mover:IsShown(), mouse = A.frame:IsMouseEnabled() })"#);
	// The frame is 200 wide and 64 + 52 tall; the dial is the 64 x 64 at its top centre.
	assert_eq!(out["insets"], json!([68, 68, 0, 52]), "the text under the dial does not catch the mouse");
	assert_eq!(out["washOnDial"], true, "the wash covers the dial, not the whole frame");
	assert_eq!(out["washShown"], true, "hovering still shows it");
	assert_eq!(out["mouse"], true, "the arrow is still movable");
}

#[test]
fn without_the_dial_the_text_under_it_takes_the_mouse_and_the_hover_wash() {
	let out = run(r#"
		local seen = {}
		local function snap(tag)
			local l, r, t, b = A.frame:GetHitRectInsets()
			local _, rel = A.mover:GetPoint(1)
			seen[#seen + 1] = { tag, A.GetMode() or "hidden", A.dial:IsShown(), { l, r, t, b }, rel == A.dial }
		end
		target(100, 0, "Nightbane Shadow Weavers")
		stub.advance(0.1); snap("travel")
		nav.place(0, 0, 1)                 -- other continent
		stub.advance(0.1); snap("far")
		nav.player = nil
		stub.advance(0.1); snap("no position")
		nav.place(0, 0, 0)
		stub.advance(0.1); snap("back")
		emit(seen)"#);
	// The frame is 200 wide and 64 + 52 tall: the dial at its top, the text under it.
	assert_eq!(
		out,
		json!([
			["travel", "travel", true, [68, 68, 0, 52], true],
			["far", "far", false, [0, 0, 64, 0], false],
			["no position", "nopos", false, [0, 0, 64, 0], false],
			["back", "travel", true, [68, 68, 0, 52], true]
		])
	);
}

#[test]
fn settings_apply_live_scale_alpha_visibility_pins_position_and_blizzard_waypoint_the_arrow_is_always_movable() {
	let out = run(r#"
		local r = {}
		target(100, 0)
		stub.advance(0.1)
		Polestar.Set("nav.arrowScale", 1.5)
		Polestar.Set("nav.arrowAlpha", 0.6)
		-- A lock saved by an older build is ignored: the arrow takes the mouse and drags.
		PolestarDB.settings.nav.arrowLocked = true
		Polestar.Set("nav.arrowScale", 1.5)
		r.scale, r.alpha, r.mouse = A.frame:GetScale(), A.frame:GetAlpha(), A.frame:IsMouseEnabled()
		stub.RunScript(A.frame, "OnDragStart")
		r.drags = A.frame:IsMovable() and A.frame.moving == true
		A.frame:StopMovingOrSizing()
		Polestar.Set("nav.arrow", false)
		r.hidden = not A.frame:IsShown()
		Polestar.Set("nav.arrow", true)
		r.back = A.frame:IsShown()
		Polestar.Set("nav.minimapPins", false)
		r.pinOff = targetPin() == nil
		Polestar.Set("nav.minimapPins", true)
		r.pinOn = targetPin() ~= nil and targetPin():IsShown()

		-- Dragging saves the position; it is re-applied from settings.
		A.frame:ClearAllPoints()
		A.frame:SetPoint("CENTER", UIParent, "CENTER", 120, -40)
		stub.RunScript(A.frame, "OnDragStop")
		r.saved = PolestarDB.settings.nav.arrowPos
		A.frame:ClearAllPoints()
		Polestar.Set("nav.arrowScale", 1)
		local p, _, rp, x, y = A.frame:GetPoint(1)
		r.reapplied = { p, rp, x, y }
		N.ResetArrowPosition()
		p, _, rp, x, y = A.frame:GetPoint(1)
		r.reset = { p, rp, x, y }

		Polestar.Set("nav.blizzardWaypoint", true)
		target(0, 100, "Blizz")
		Polestar.Set("nav.blizzardWaypoint", false)
		r.userWaypoints = nav.userWaypoints
		emit(r)"#);
	assert_eq!(out["scale"], 1.5);
	assert_eq!(out["alpha"], 0.6);
	assert_eq!(out["mouse"], true, "the arrow always takes the mouse");
	assert_eq!(out["drags"], true, "a drag moves it, whatever an old lock says");
	assert_eq!(out["hidden"], true);
	assert_eq!(out["back"], true);
	assert_eq!(out["pinOff"], true);
	assert_eq!(out["pinOn"], true);
	assert_eq!(out["saved"], json!({ "point": "CENTER", "relPoint": "CENTER", "x": 120, "y": -40 }));
	assert_eq!(out["reapplied"], json!(["CENTER", "CENTER", 120, -40]));
	assert_eq!(out["reset"], json!(["TOP", "TOP", 0, -140]));
	assert_eq!(out["userWaypoints"], json!([["set", 9000, 0.5, 0.45], ["track", true], ["set", 9000, 0.45, 0.5], ["track", true], ["clear"]]));
}

#[test]
fn with_the_lock_on_only_a_shift_drag_moves_the_arrow_and_the_movable_wash_shows_only_with_shift_held() {
	let out = run(r#"
		local r = {}
		target(100, 0)
		stub.advance(0.1)
		local f = A.frame
		local function hover()
			stub.RunScript(f, "OnEnter")
			local seen = { A.mover:IsShown(), GameTooltip.lines[2] }
			stub.RunScript(f, "OnLeave")
			return seen
		end
		local function drag()
			stub.RunScript(f, "OnDragStart")
			local started = f.moving == true
			f:StopMovingOrSizing()
			return started
		end
		r.unlocked = { drag(), hover() }
		Polestar.Set("ui.lockHud", true)
		r.locked = { drag(), hover() }
		r.mouse = f:IsMouseEnabled()
		stub.keys.shift = true
		r.shift = { drag(), hover() }
		-- Shift let go mid-drag: the drag carries on and its end saves the spot.
		stub.RunScript(f, "OnDragStart")
		stub.keys.shift = false
		f:ClearAllPoints()
		f:SetPoint("CENTER", UIParent, "CENTER", 80, 20)
		stub.RunScript(f, "OnDragStop")
		r.saved = PolestarDB.settings.nav.arrowPos
		r.stopped = f.moving
		emit(r)"#);
	assert_eq!(out["unlocked"], json!([true, [true, "Drag to move."]]), "off by default: a plain drag moves it");
	assert_eq!(out["locked"], json!([false, [false, "Shift-drag to move."]]), "locked: a plain drag does nothing, no wash");
	assert_eq!(out["mouse"], true, "locked, the arrow still takes the mouse for clicks");
	assert_eq!(out["shift"], json!([true, [true, "Shift-drag to move."]]), "locked: Shift-drag moves it");
	assert_eq!(out["saved"], json!({ "point": "CENTER", "relPoint": "CENTER", "x": 80, "y": 20 }));
	assert_eq!(out["stopped"], false);
}

#[test]
fn with_the_lock_on_a_drag_that_does_not_move_the_arrow_does_not_save_its_spot() {
	let out = run(r#"
		target(100, 0)
		stub.advance(0.1)
		local f = A.frame
		Polestar.Set("ui.lockHud", true)
		stub.RunScript(f, "OnDragStart")
		stub.RunScript(f, "OnDragStop")
		local refused = Polestar.Get("nav.arrowPos") == nil
		stub.keys.shift = true
		stub.RunScript(f, "OnDragStart")
		stub.RunScript(f, "OnDragStop")
		emit({ refused = refused, shift = Polestar.Get("nav.arrowPos") ~= nil })"#);
	assert_eq!(out["refused"], true, "a plain drag on the locked arrow leaves nav.arrowPos alone");
	assert_eq!(out["shift"], true, "a Shift-drag still saves the spot");
}

#[test]
fn eta_appears_while_closing_in_at_running_speed() {
	let out = run(r#"
		target(300, 0)
		stub.advance(0.2)
		local before = A.etaText:IsShown()
		for _ = 1, 40 do                   -- 7 yd/s for 2 s
			nav.place(nav.player.wx + 0.35, 0)
			stub.advance(0.05)
		end
		local shown, text = A.etaText:IsShown(), A.etaText:GetText()
		local _, size = A.etaText:GetFont()
		local color = { A.etaText:GetTextColor() }
		Polestar.Set("nav.arrowEta", false)
		emit({ before = before, shown = shown, text = text, off = not A.etaText:IsShown(), size = size, color = color,
			mover = { N.Wash("mover") } })"#);
	assert_eq!(out["before"], false);
	assert_eq!(out["shown"], true);
	assert_eq!(out["off"], true, "nav.arrowEta off hides it immediately");
	assert_eq!(out["size"], 12, "the ETA line is 12px");
	// Fallback palette (no Theme loaded): text 0.969,0.973,0.992 (Dusk), here at 80%.
	assert_eq!(out["color"], json!([0.969, 0.973, 0.992, 0.8]), "the ETA reads in text at 80%");
	assert_eq!(out["mover"], json!([1, 1, 1, 0.06]), "the movable hint is the ink \"mover\" wash");
	// 286 yd left at ~7 yd/s: about 41 s.
	let eta = text(&out["text"]);
	let secs = mmss(eta);
	assert!((36.0..=46.0).contains(&secs), "ETA {eta}");
}

#[test]
fn world_map_pins_target_and_open_goals_on_the_viewed_map_with_tooltip_and_click_to_target() {
	let out = run(r#"
		local m, x, y = nav.mapPoint(100, 0)
		nav.engine.views[1] = { index = 1, goals = {
			{ index = 1, status = "active", text = "Target goal", map = m, x = x, y = y },
			{ index = 2, status = "pending", text = "Other goal", map = 9000, x = 60, y = 60 },
			{ index = 3, status = "done", text = "Done goal", map = 9000, x = 70, y = 70 },
			{ index = 4, status = "active", text = "Elsewhere", map = 9001, x = 50, y = 50 },
		} }
		nav.setWaypoint(wp(100, 0, "Target goal"))
		nav.showWorldMap(9000)
		local pins = nav.pins()
		local r = { count = #pins, pins = {} }
		for _, pin in ipairs(pins) do
			r.pins[#r.pins + 1] = { layer = pin.data.layer.name, label = nav.tooltipOf(pin)[1], x = pin.data.x / 100, y = pin.data.y / 100,
				size = math.floor(pin.width * 10 + 0.5) / 10, shown = pin:IsShown() }
		end
		r.tooltip = nav.tooltipOf(pins[1])
		nav.click(pins[2], "LeftButton")
		r.retarget = N.GetTarget().label
		r.after = #nav.pins()
		Polestar.Set("nav.worldPins", false)
		r.off = #nav.pins()
		nav.showWorldMap(9001)
		Polestar.Set("nav.worldPins", true)
		r.otherMap = #nav.pins()
		emit(r)"#);
	assert_eq!(out["count"], 2);
	assert_eq!(out["pins"][0], json!({ "layer": "nav.target", "label": "Target goal", "x": 0.5, "y": 0.45, "size": 22.4, "shown": true }));
	assert_eq!(out["pins"][1], json!({ "layer": "nav.goals", "label": "Other goal", "x": 0.6, "y": 0.6, "size": 16, "shown": true }));
	assert_eq!(out["tooltip"], json!(["Target goal", "100 yd"]));
	assert_eq!(out["retarget"], "Other goal");
	assert_eq!(out["after"], 2, "pins rebuilt around the new target");
	assert_eq!(out["off"], 0);
	assert_eq!(out["otherMap"], 1, "only the goal on the viewed map");
}

#[test]
fn a_step_change_waits_for_the_engine_waypoint_no_stale_re_apply_no_second_chime_no_tomtom_churn() {
	let out = run(r#"
		nav.withTomTom()
		local announced = {}
		Polestar.On("WAYPOINT_CHANGED", function(w) announced[#announced + 1] = w and w.label or "nil" end)
		-- The real Engine order: STEP_CHANGED while the old waypoint is still stored,
		-- then the new waypoint and WAYPOINT_CHANGED.
		local function engineStep(i, w)
			nav.engine.step = i
			Polestar.Fire("STEP_CHANGED", i)
			nav.engine.waypoint = w
			Polestar.Fire("WAYPOINT_CHANGED", w)
		end
		nav.setWaypoint(wp(20, 0, "Goto A"))
		nav.place(15, 0)                                 -- arrive at A
		stub.advance(0.2)
		local chimes = #stub.sounds
		local calls = #TomTom.calls
		engineStep(2, wp(300, 0, "Next B", { stepIndex = 2 }))
		stub.advance(0.2)
		local r = { chimesAfter = #stub.sounds - chimes, tomtom = {}, target = N.GetTarget().label }
		for i = calls + 1, #TomTom.calls do
			local c = TomTom.calls[i]
			r.tomtom[#r.tomtom + 1] = c.op .. (c.title and (" " .. c.title) or "")
		end
		-- With an override held, the step change drops it once the new waypoint is known.
		local m, x, y = nav.mapPoint(0, 300)
		N.SetTarget(m, x, y, "Mine")
		engineStep(3, wp(-300, 0, "Next C", { stepIndex = 3 }))
		stub.advance(0.1)
		r.afterOverride = N.GetTarget().label
		-- Same waypoint, no WAYPOINT_CHANGED: the override still goes, after the dispatch.
		N.SetTarget(m, x, y, "Mine again")
		nav.engine.step = 4
		Polestar.Fire("STEP_CHANGED", 4)
		r.duringDispatch = N.GetTarget().label
		stub.advance(0.1)
		r.settled = N.GetTarget().label
		r.announced = announced
		emit(r)"#);
	assert_eq!(out["chimesAfter"], 0, "arriving once chimes once");
	assert_eq!(out["tomtom"], json!(["remove", "add Next B"]), "one swap straight to the new point");
	assert_eq!(out["target"], "Next B");
	assert_eq!(out["afterOverride"], "Next C");
	assert_eq!(out["duringDispatch"], "Mine again");
	assert_eq!(out["settled"], "Next C");
	assert_eq!(out["announced"], json!(["Goto A", "Next B", "Mine", "Next C", "Mine again", "Next C"]));
}

#[test]
fn the_eta_closing_speed_ignores_out_of_band_refreshes() {
	let out = run(r#"
		target(600, 0)
		stub.advance(0.2)
		local etas = {}
		for i = 1, 100 do                                -- 7 yd/s for 5 s, refreshing every 0.5 s
			nav.place(nav.player.wx + 0.35, 0)
			stub.advance(0.05)
			if i % 10 == 5 then A:Refresh() end
			if i > 60 and i % 10 == 0 then etas[#etas + 1] = A.etaText:GetText() end
		end
		emit({ etas = etas, dist = N.GetDistance() })"#);
	let secs: Vec<f64> = out["etas"].as_array().unwrap().iter().map(|t| mmss(text(t))).collect();
	let expected = num(&out["dist"]) / 7.0;
	for s in &secs {
		assert!((s - expected).abs() <= 4.0, "ETA {s} s vs {expected:.0} s ({})", out["etas"]);
	}
}

#[test]
fn polestar_way_without_a_position_here_says_so_not_how_to_type_it() {
	let out = run(r#"
		local function way(msg)
			stub.messages = {}
			SlashCmdList.POLESTAR(msg)
			local t = N.GetTarget()
			return { msgs = #stub.messages > 0 and stub.messages or "none", target = t and t.label or "nil" }
		end
		local r = {}
		nav.place(0, 0, 1)                 -- other continent: the game gives no map position
		r.noPosition = way("way 40 60 Mine")
		nav.place(0, 0, 0)
		r.malformed = way("way 40")
		r.valid = way("way 40 60 Mine")
		emit(r)"#);
	assert_eq!(
		out["noPosition"],
		json!({
			"msgs": ["|cff4fd1c5Polestar|r: No position here: the game gives none in instances and on some maps."],
			"target": "nil"
		})
	);
	assert_eq!(out["malformed"], json!({ "msgs": ["|cff4fd1c5Polestar|r: Usage: /polestar way <x> <y> [label]"], "target": "nil" }));
	assert_eq!(out["valid"], json!({ "msgs": "none", "target": "Mine" }));
}
