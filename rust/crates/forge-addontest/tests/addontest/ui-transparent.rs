//! The guide window's Transparent style (addon/Polestar/UI/GuideFrame.lua, GF.VEIL; Theme.Scrim): the backing
//! behind the text (soft, dark or off) and where it lies, the step bar kept shown (ui.barShown, first written by
//! Saulo, soulrocha, in #1146), the tick boxes on the world, and the Standard style left exactly as it was. Against
//! the real Core + Theme + UI manifests and the fake Engine (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// Lua helpers: a region's rect resolved from its anchors the way the client lays them out (the stub keeps the
// anchors only), the backing's state, and what the step bar shows.
const HELPERS: &str = r#"
local P = GF.parts
local function rectOf(r)
	if r == nil or r == UIParent then return { l = 0, b = 0, r = UIParent:GetWidth(), t = UIParent:GetHeight() } end
	local L, R, T, B, cx, cy
	-- A scroll child sits at its scroll frame's top left, moved up by the scroll.
	local sf = r:GetParent()
	if #r.points == 0 and sf and sf.scrollChild == r then
		local o = rectOf(sf)
		L, T = o.l, o.t + sf:GetVerticalScroll()
	end
	for _, p in ipairs(r.points) do
		local o = rectOf(p.rel or r:GetParent())
		local rp = p.relPoint
		local px = rp:find("LEFT") and o.l or rp:find("RIGHT") and o.r or (o.l + o.r) / 2
		local py = rp:find("TOP") and o.t or rp:find("BOTTOM") and o.b or (o.b + o.t) / 2
		px, py = px + p.x, py + p.y
		if p.point:find("LEFT") then L = px elseif p.point:find("RIGHT") then R = px else cx = px end
		if p.point:find("TOP") then T = py elseif p.point:find("BOTTOM") then B = py else cy = py end
	end
	local w, h = r:GetWidth(), r:GetHeight()
	L = L or (R and R - w) or (cx or 0) - w / 2
	R = R or L + w
	T = T or (B and B + h) or (cy or 0) + h / 2
	B = B or T - h
	return { l = L, r = R, t = T, b = B }
end
-- The solid middle of a scrim (inside its feather) and the band its rise covers on one edge.
local function core(s)
	local q, k = rectOf(s), GF.VEIL_FEATHER
	return { l = q.l + k, r = q.r - k, t = q.t - k, b = q.b + k }
end
local function alphaOf(s) return select(4, s.parts[1]:GetVertexColor()) end
local function shownShades()
	local n = 0
	for _, s in pairs(GF.shades) do if s.shown then n = n + 1 end end
	return n
end
local function backing()
	return { body = GF.veil:IsShown(), bar = P.band.Veil:IsShown(), alpha = alphaOf(GF.veil), barAlpha = alphaOf(P.band.Veil), shades = shownShades() }
end
local function state()
	return { title = P.nav.Title:GetAlpha(), steps = P.nav.Steps:GetAlpha(), strip = P.strip:GetAlpha(), grip = GF.grip:GetAlpha(),
		veil = P.band.Veil:GetAlpha(), barVeil = P.band.Veil:IsShown() }
end
-- Every string on screen under `root`, with its resolved rect.
local function shownTexts(root, out)
	out = out or {}
	if not root:IsVisible() then return out end
	for _, r in ipairs(root.regions or {}) do
		if r:GetObjectType() == "FontString" and r:IsShown() and (r:GetText() or "") ~= "" then out[#out + 1] = { fs = r, rect = rectOf(r) } end
	end
	for _, c in ipairs(root.children or {}) do shownTexts(c, out) end
	return out
end
-- The strings of `root` that leave the scrim's solid middle: none, when the backing holds them all.
local function outside(root, s)
	local c, bad = core(s), {}
	for _, x in ipairs(shownTexts(root)) do
		local q = x.rect
		if q.l < c.l - 0.01 or q.r > c.r + 0.01 or q.t > c.t + 0.01 or q.b < c.b - 0.01 then bad[#bad + 1] = x.fs:GetText() end
	end
	return bad
end
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\nlocal F = PolestarGuideFrame\n{HELPERS}\n{script}"),
		..Default::default()
	})
}

#[test]
fn soft_by_default_shades_each_line_with_no_box_dark_is_the_boxed_backing_and_off_is_the_outlined_text_alone() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local standard = backing()
		Polestar.Set("ui.style", "transparent")
		local soft = backing()
		Polestar.Set("ui.backing", "dark")
		local dark = backing()
		Polestar.Set("ui.backing", "none")
		local off = backing()
		Polestar.Set("ui.backing", "soft")
		Polestar.Set("ui.style", "standard")
		emit({ standard = standard, soft = soft, dark = dark, off = off, back = backing(), defaultBacking = Polestar.Get("ui.backing"),
			scrim = { Polestar.Theme.Color("scrim") }, colour = { GF.veil.parts[9]:GetVertexColor() } })"#)
	.remove(0);
	assert_eq!(out["defaultBacking"], "soft", "new and existing players get the soft backing");
	assert_eq!(out["standard"]["body"], false, "the Standard style has its own ground");
	assert_eq!(out["standard"]["bar"], false);
	assert_eq!(out["soft"]["body"], false, "soft: no box behind the window");
	assert_eq!(out["soft"]["bar"], false);
	assert!(out["soft"]["shades"].as_u64().unwrap() >= 5, "soft: a shade behind each line: {}", out["soft"]);
	assert_eq!(out["dark"], json!({ "body": true, "bar": true, "alpha": 0.68, "barAlpha": 0.68, "shades": 0 }));
	assert_eq!(out["off"]["body"], false, "off: the outlined text alone on the world, as before");
	assert_eq!(out["off"]["bar"], false);
	assert_eq!(out["off"]["shades"], 0);
	assert_eq!(out["back"]["body"], false, "back to Standard, the backing goes");
	assert_eq!(out["back"]["bar"], false);
	assert_eq!(out["back"]["shades"], 0);
	let scrim = out["scrim"].as_array().unwrap();
	let colour = out["colour"].as_array().unwrap();
	for i in 0..3 {
		assert_eq!(colour[i], scrim[i], "the backing is the scheme's scrim colour");
	}
}

#[test]
fn the_dark_backing_holds_every_string_of_the_step_on_its_solid_middle_and_the_step_bar_on_its_own() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.style", "transparent")
		Polestar.Set("ui.backing", "dark")
		Polestar.Set("ui.barShown", true)
		local function check()
			local bar = outside(P.strip, P.band.Veil)
			for _, s in ipairs(outside(P.nav, P.band.Veil)) do bar[#bar + 1] = s end
			local body = outside(P.body, GF.veil)
			for _, s in ipairs(outside(P.foot, GF.veil)) do body[#body + 1] = s end
			return { bar = table.concat(bar, " | "), body = table.concat(body, " | "), barTexts = #shownTexts(P.strip) + #shownTexts(P.nav),
				bodyTexts = #shownTexts(P.body) + #shownTexts(P.foot), tabs = #shownTexts(P.strip),
				countShown = P.nav.Steps.Count:IsVisible(), count = P.nav.Steps.Count:GetText() }
		end
		local down = check()
		uistub.setStep(4)
		local hub = check()
		P.tip:Click()
		local tip = check()
		Polestar.Set("ui.width", 260)
		local narrow = check()
		Polestar.Set("ui.compact", true)
		local compact = check()
		Polestar.Set("ui.compact", false)
		Polestar.Set("ui.width", 560)
		Polestar.Set("ui.growUp", true)
		Polestar.Set("ui.barsBottom", true)
		uistub.setStep(3)
		local flipped = check()
		emit({ down = down, hub = hub, tip = tip, narrow = narrow, compact = compact, flipped = flipped })"#)
	.remove(0);
	for case in ["down", "hub", "tip", "narrow", "compact", "flipped"] {
		let c = &out[case];
		// Compact mode hides the tabs, and at 260px the title yields its space to the toolbar buttons.
		let compact = case == "compact";
		assert!(c["barTexts"].as_u64().unwrap() >= if compact { 2 } else { 3 }, "{case}: the toolbar's strings are on screen");
		assert_eq!(c["countShown"], true, "{case}: the step count stays visible");
		assert!(c["count"].as_str().unwrap().contains(" / "), "{case}: the step count is populated");
		if compact {
			assert_eq!(c["tabs"], 0, "compact: the tab strip is hidden");
		} else {
			assert!(c["tabs"].as_u64().unwrap() >= 1, "{case}: the tab strip is populated");
		}
		assert!(c["bodyTexts"].as_u64().unwrap() >= 5, "{case}: the step's strings are on screen");
		assert_eq!(c["bar"], "", "{case}: the tabs and the step bar sit on the bar's backing");
		assert_eq!(c["body"], "", "{case}: every string of the step sits on the body's backing");
	}
}

#[test]
fn where_the_two_backings_meet_one_rises_as_the_other_falls_over_the_same_band_in_both_bar_positions() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.style", "transparent")
		Polestar.Set("ui.backing", "dark")
		local function seam(flip)
			local v, b, k, c = rectOf(GF.veil), rectOf(P.band.Veil), GF.VEIL_FEATHER, GF.veil.psClear
			local edge = flip and rectOf(P.nav).t or rectOf(P.nav).b
			-- The body's rise: clear at its edge for c, solid k in. The bar's fall mirrors it.
			if flip then
				return { bodyClear = v.b + c, bodySolid = v.b + k, barClear = b.t - c, barSolid = b.t - k, edge = edge }
			end
			return { bodyClear = v.t - c, bodySolid = v.t - k, barClear = b.b + c, barSolid = b.b + k, edge = edge }
		end
		local down = seam(false)
		Polestar.Set("ui.growUp", true)
		Polestar.Set("ui.barsBottom", true)
		emit({ down = down, up = seam(true) })"#)
	.remove(0);
	for case in ["down", "up"] {
		let s = &out[case];
		let n = |k: &str| s[k].as_f64().unwrap();
		assert!((n("bodyClear") - n("barSolid")).abs() < 0.01, "{case}: the body's backing starts where the bar's is still solid: {s}");
		assert!((n("bodySolid") - n("barClear")).abs() < 0.01, "{case}: the body's backing is solid where the bar's has gone: {s}");
		assert!(((n("bodyClear") + n("bodySolid")) / 2.0 - n("edge")).abs() < 1.01, "{case}: the band is centred on the navigator's inner edge: {s}");
	}
}

#[test]
fn off_by_default_a_transparent_window_away_from_the_cursor_hides_its_bar_and_the_dark_bar_backing_fades_with_it() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		Polestar.Set("ui.style", "transparent")
		Polestar.Set("ui.backing", "dark")
		local rest = state()
		F.IsMouseOver = function() return true end
		stub.RunScript(F, "OnEnter")
		stub.advance(0.5)
		local hover = state()
		F.IsMouseOver = function() return false end
		stub.advance(0.5)
		emit({ rest = rest, hover = hover, left = state(), shown = Polestar.Get("ui.barShown") })"#)
	.remove(0);
	assert_eq!(out["shown"], false);
	assert_eq!(out["rest"], json!({ "title": 0, "steps": 0, "strip": 0, "grip": 0, "veil": 0, "barVeil": true }));
	assert_eq!(out["hover"], json!({ "title": 1, "steps": 1, "strip": 1, "grip": 1, "veil": 1, "barVeil": true }));
	assert_eq!(out["left"], out["rest"], "they fade together once the cursor leaves");
}

#[test]
fn keep_the_bar_shown_holds_the_tabs_the_step_bar_and_their_backing_on_screen_the_grip_still_waits_for_the_cursor() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		Polestar.Set("ui.style", "transparent")
		Polestar.Set("ui.backing", "dark")
		Polestar.Set("ui.barShown", true)
		local on = state()
		F.IsMouseOver = function() return true end
		stub.RunScript(F, "OnEnter")
		stub.advance(0.5)
		F.IsMouseOver = function() return false end
		stub.advance(0.5)
		local left = state()
		Polestar.Set("ui.barShown", false)
		emit({ on = on, left = left, off = state() })"#)
	.remove(0);
	assert_eq!(out["on"], json!({ "title": 1, "steps": 1, "strip": 1, "grip": 0, "veil": 1, "barVeil": true }));
	assert_eq!(out["left"], out["on"], "leaving the window fades only the grip");
	assert_eq!(out["off"], json!({ "title": 0, "steps": 0, "strip": 0, "grip": 0, "veil": 0, "barVeil": true }), "turned off: back to hover only");
}

#[test]
fn tick_boxes_on_the_world_get_the_scrim_inside_and_an_ink_edge_and_the_standard_box_back_after() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local function box()
			for _, r in ipairs(GF.rows) do
				if r:IsShown() and r.Check:IsShown() then
					local d = r.Check.psSkin.box
					return { fill = { d.psSkin.bg:GetVertexColor() }, edge = d.psBorder and d.psBorder[1]:IsShown() and { d.psBorder[1]:GetVertexColor() } or false }
				end
			end
		end
		local before = box()
		Polestar.Set("ui.style", "transparent")
		local clear = box()
		uistub.setStep(4)
		local fresh = box()
		Polestar.Set("ui.style", "standard")
		emit({ before = before, clear = clear, fresh = fresh, after = box(), scrim = { Polestar.Theme.Color("scrim") }, dim = { Polestar.Theme.Color("textDim") } })"#)
	.remove(0);
	let rgb = |v: &Value| Value::Array(v.as_array().unwrap()[..3].to_vec());
	for case in ["clear", "fresh"] {
		assert_eq!(rgb(&out[case]["fill"]), rgb(&out["scrim"]), "{case}: the scrim inside the box");
		assert_eq!(out[case]["fill"][3], 0.6, "{case}");
		assert_eq!(rgb(&out[case]["edge"]), rgb(&out["dim"]), "{case}: an ink edge round it");
		assert_eq!(out[case]["edge"][3], 0.7, "{case}");
	}
	assert_eq!(out["after"], out["before"], "back in Standard, the house box");
	assert_eq!(out["before"]["fill"][3], 0.35);
}

#[test]
fn the_standard_style_draws_exactly_as_before_after_a_round_trip_through_transparent_with_every_option_set() {
	let out = run(r#"
		-- Every region the window draws (shown, under shown frames), in creation order: alpha, colour, anchors,
		-- size, text and its font. Hidden regions draw nothing (the soft shades made on the way stay hidden).
		local function snapshot()
			local out = {}
			local function walk(f)
				for _, r in ipairs(f.regions or {}) do
					if r:IsShown() then
						local e = { k = r:GetObjectType(), a = r:GetAlpha(), w = r:GetWidth(), h = r:GetHeight(), rect = rectOf(r) }
						if r.GetVertexColor then e.c = { r:GetVertexColor() } end
						if r.GetText then e.text = r:GetText(); e.font = { r:GetFont() }; e.tc = { r:GetTextColor() } end
						out[#out + 1] = e
					end
				end
				for _, c in ipairs(f.children or {}) do
					if c:IsShown() then
						out[#out + 1] = { k = c:GetObjectType(), a = c:GetAlpha(), rect = rectOf(c) }
						walk(c)
					end
				end
			end
			walk(F)
			return out
		end
		local function eq(p, q)
			if type(p) ~= type(q) then return false end
			if type(p) ~= "table" then return p == q or (type(p) == "number" and math.abs(p - q) < 1e-9) end
			for k, v in pairs(p) do if not eq(v, q[k]) then return false end end
			for k in pairs(q) do if p[k] == nil then return false end end
			return true
		end
		local result = {}
		for _, skin in ipairs({ "polestar", "halo", "hearth" }) do
			Polestar.Set("ui.skin", skin)
			uistub.openTabs(TABS, 1)
			local before = snapshot()
			Polestar.Set("ui.style", "transparent")
			Polestar.Set("ui.backing", "dark")
			Polestar.Set("ui.barShown", true)
			Polestar.Set("ui.style", "standard")
			local after = snapshot()
			local diffs = {}
			for i = 1, math.max(#before, #after) do
				if not eq(before[i], after[i]) then diffs[#diffs + 1] = i end
			end
			result[skin] = { count = #before, diffs = table.concat(diffs, ","), veil = GF.veil:IsShown() or P.band.Veil:IsShown() }
		end
		emit(result)"#)
	.remove(0);
	for skin in ["polestar", "halo", "hearth"] {
		let r = &out[skin];
		assert!(r["count"].as_u64().unwrap() > 100, "{skin}: the whole window was compared");
		assert_eq!(r["diffs"], "", "{skin}: no region of the Standard window changed");
		assert_eq!(r["veil"], false, "{skin}: no backing in Standard");
	}
}

#[test]
fn the_dark_backing_follows_the_scheme() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.style", "transparent")
		Polestar.Set("ui.backing", "dark")
		Polestar.Set("ui.scheme", "graphite")
		emit({ veil = { GF.veil.parts[1]:GetVertexColor() }, bar = { P.band.Veil.parts[9]:GetVertexColor() }, scrim = { Polestar.Theme.Color("scrim") } })"#)
	.remove(0);
	for part in ["veil", "bar"] {
		for i in 0..3 {
			assert_eq!(out[part][i], out["scrim"][i], "{part}: the scheme's scrim colour");
		}
		assert_eq!(out[part][3], 0.68);
	}
}

#[test]
fn soft_shades_follow_each_string_its_size_its_text_shown_state_and_alpha_and_never_cover_empty_room() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.style", "transparent")
		local IX, IY = GF.SHADE_INSET.x, GF.SHADE_INSET.y
		-- Every string on screen has its shade, sized to its own text (not its box) and anchored to it;
		-- no shade is shown for a string that is not.
		local function check()
			local miss, wrong, stray, n = {}, {}, {}, 0
			local onScreen = {}
			for _, x in ipairs(shownTexts(F)) do
				local fs, s = x.fs, GF.shades[x.fs]
				onScreen[fs] = true
				n = n + 1
				if not (s and s.shown) then
					miss[#miss + 1] = fs:GetText()
				else
					local m = s.parts[1]
					local w = math.min(fs:GetStringWidth(), fs:GetWidth() > 0 and fs:GetWidth() or math.huge)
					local ok = m.points[1].rel == fs and math.abs(m:GetWidth() - math.max(1, w - 2 * IX)) < 0.01
						and math.abs(m:GetHeight() - math.max(1, fs:GetStringHeight() - 2 * IY)) < 0.01
						and math.abs(select(4, m:GetVertexColor()) - GF.SHADE) < 1e-6
					if not ok then wrong[#wrong + 1] = fs:GetText() end
				end
			end
			for fs, s in pairs(GF.shades) do
				if s.shown and not (onScreen[fs] or not fs:GetParent():IsVisible()) then stray[#stray + 1] = tostring(fs:GetText()) end
			end
			return { n = n, miss = table.concat(miss, " | "), wrong = table.concat(wrong, " | "), stray = table.concat(stray, " | ") }
		end
		local first = check()
		uistub.setStep(4)
		stub.advance(0.1)
		local hub = check()
		-- A string emptied or hidden without a layout loses its shade on the next frame.
		local fs = shownTexts(P.body)[1].fs
		fs:SetText("")
		stub.advance(0.1)
		local emptied = GF.shades[fs].shown
		fs:SetText("Back again")
		stub.advance(0.1)
		local back = GF.shades[fs].shown
		fs:Hide()
		stub.advance(0.1)
		local hidden = GF.shades[fs].shown
		fs:Show()
		stub.advance(0.1)
		fs:SetAlpha(0.3)
		local faded = GF.shades[fs].parts[5]:GetAlpha()
		fs:SetAlpha(1)
		Polestar.Set("ui.backing", "dark")
		local dark = shownShades()
		Polestar.Set("ui.backing", "soft")
		Polestar.Set("ui.style", "standard")
		emit({ first = first, hub = hub, emptied = emptied, back = back, hidden = hidden, faded = faded, dark = dark, standard = shownShades() })"#)
	.remove(0);
	for case in ["first", "hub"] {
		let c = &out[case];
		assert!(c["n"].as_u64().unwrap() >= 8, "{case}: strings on screen");
		assert_eq!(c["miss"], "", "{case}: every string on screen has its shade");
		assert_eq!(c["wrong"], "", "{case}: each shade is its text's size, on it, at the soft strength");
		assert_eq!(c["stray"], "", "{case}: no shade behind a string that is not on screen");
	}
	assert_eq!(out["emptied"], false, "an emptied string's shade goes");
	assert_eq!(out["back"], true, "and comes back with its text");
	assert_eq!(out["hidden"], false, "a hidden string's shade goes");
	assert_eq!(out["faded"], 0.3, "a string's alpha carries to its shade");
	assert_eq!(out["dark"], 0, "Dark: the box, no line shades");
	assert_eq!(out["standard"], 0, "Standard: no shades");
}
