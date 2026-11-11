//! The guide window's own look (addon/Polestar/UI/GuideFrame.lua, GF.LOOK and GF.ApplyLook; the settings window's
//! Guide window page and its preview, UI/Looks/GuideWindow.lua): every guideWindow.* setting left at its default
//! keeps the window exactly as the skin draws it; each one changed reaches the live window at once (sizes,
//! padding, spacing, parts shown, colours, ground, border, outline, fading); the preview lays its step card out by
//! the same numbers and never touches the live window. Against the real Core + Theme + UI manifests and the fake
//! Engine (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const HELPERS: &str = r#"
local P = GF.parts
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
local function size(fs) return select(2, fs:GetFont()) end
local function flags(fs) return select(3, fs:GetFont()) or "" end
local function firstRow()
	for _, r in ipairs(GF.rows) do if r:IsShown() and r.psGoal then return r end end
end
local function pointX(region)
	local p = region.points and region.points[1]
	return p and p.x
end
-- What the window shows of the parts the look touches.
local function snapshot()
	local r = firstRow()
	local _, _, _, iconX, iconY = r.Icon:GetPoint(1)
	return {
		height = math.floor(F:GetHeight() + 0.5), strip = P.strip:IsShown() and P.strip:GetHeight() or 0, nav = P.nav:GetHeight(),
		foot = P.foot:IsShown(), line = P.line:GetHeight(), pct = P.foot.Pct:IsShown(),
		rowH = r:GetHeight(), rowText = size(r.Text), rowTextX = pointX(r.Text), icon = r.Icon:GetWidth(), iconY = iconY,
		check = r.Check:GetWidth(), name = size(P.person.Name), tip = size(P.tip.Text), count = size(P.nav.Steps.Count),
		steps = P.nav.Steps:IsShown(), skip = P.nav.Skip:IsShown(), report = P.nav.Report:IsShown(),
		markW = r.Mark:GetWidth(), markA = r.Mark:GetAlpha(), personMarkW = P.person.Mark:GetWidth(),
		bgColor = F.psBgColor or false, bgAlpha = F.psBgAlpha or false, noBorder = F.psNoBorder or false,
		alpha = F:GetAlpha(),
	}
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\nlocal GF = Polestar.UI.GuideFrame\nlocal F = PolestarGuideFrame\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn at_their_defaults_the_look_settings_leave_the_window_as_the_skin_draws_it() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local stored = Polestar.DB().settings.guideWindow
		local M = GF.Metrics()
		local before = snapshot()
		-- Every setting set to its own default changes nothing and stores nothing.
		for k, v in pairs(GF.LOOK) do Polestar.Set("guideWindow." .. k, v) end
		emit({ metrics = { pad = M.pad, tabH = M.tabH, navH = M.navH, progH = M.progH, icon = M.icon, textX = M.textX, check = M.check,
				rowPad = M.rowPad, upRow = M.upRow, upToggle = M.upToggle, glyphY = M.glyphY },
			before = before, after = snapshot(), stored = stored == nil and next(Polestar.DB().settings.guideWindow or {}) == nil,
			accent = { Polestar.Theme.Color("accent") }, mark = { firstRow().Mark:GetVertexColor() }, fill = { P.line.Fill:GetVertexColor() } })"#);
	assert_eq!(
		out["metrics"],
		json!({ "pad": 14, "tabH": 28, "navH": 34, "progH": 26, "icon": 15, "textX": 39, "check": 18, "rowPad": 0, "upRow": 24, "upToggle": 30, "glyphY": 12 }),
		"the house style's sizes, as before the look settings"
	);
	assert_eq!(out["before"], out["after"], "re-setting every default repaints nothing differently");
	assert_eq!(out["stored"], true, "a value equal to its default is never stored");
	let b = &out["before"];
	assert_eq!(b["rowText"], 14, "goal text at the goal role's size");
	assert_eq!(b["name"], 15, "the person at the name role's size");
	assert_eq!(b["tip"], 12, "the tip at the note role's size");
	assert_eq!(b["iconY"], -12, "the goal glyph where it always sat");
	assert_eq!(b["markW"], 2, "the 2px target bar");
	assert_eq!(b["markA"], 1);
	assert_eq!(b["line"], 3, "the 3px progress line");
	assert_eq!(b["strip"], 28);
	assert_eq!(b["nav"], 34);
	assert_eq!(b["foot"], true);
	assert_eq!(b["pct"], true);
	assert_eq!(b["steps"], true);
	assert_eq!(b["skip"], true);
	assert_eq!(b["report"], true);
	assert_eq!(b["bgColor"], false, "the shared ground");
	assert_eq!(b["bgAlpha"], false);
	assert_eq!(b["noBorder"], false);
	assert_eq!(b["alpha"], 1);
	for i in 0..3 {
		assert_eq!(out["mark"][i], out["accent"][i], "the target bar in the accent");
		assert_eq!(out["fill"][i], out["accent"][i], "the progress fill in the accent");
	}
}

#[test]
fn sizes_text_and_spacing_apply_to_the_live_window_at_once() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local base = snapshot()
		local function with(key, value)
			Polestar.Set("guideWindow." .. key, value)
			local s = snapshot()
			Polestar.Set("guideWindow." .. key, nil)
			return s
		end
		emit({ base = base,
			goal = with("goalSize", 1.5), title = with("titleSize", 1.4), note = with("noteSize", 1.5), bar = with("barTextSize", 1.5),
			pad = with("padding", 6), rows = with("rowSpacing", 4), glyph = with("glyphSize", 2), check = with("checkSize", 1.5),
			tabs = with("tabHeight", 1.5), nav = with("navHeight", 1.5), line = with("progressHeight", 8),
			back = snapshot() })"#);
	let b = &out["base"];
	let n = |v: &Value| v.as_f64().unwrap();
	assert_eq!(out["goal"]["rowText"], 21, "goals at 150%: {}", out["goal"]);
	assert!(n(&out["goal"]["rowH"]) > n(&b["rowH"]), "the row grows with its text");
	assert!(n(&out["goal"]["iconY"]) < n(&b["iconY"]), "the glyph follows the larger first line down");
	assert_eq!(out["goal"]["name"], b["name"], "only the goals change size");
	assert_eq!(out["title"]["name"], 21, "the person at 140%");
	assert_eq!(out["title"]["rowText"], b["rowText"]);
	assert_eq!(out["note"]["tip"], 18, "the tip at 150%");
	assert_eq!(out["bar"]["count"], 18, "the step number at 150%");
	assert_eq!(n(&out["pad"]["rowTextX"]), n(&b["rowTextX"]) + 6.0, "inner padding moves the text in");
	assert_eq!(n(&out["rows"]["rowH"]), n(&b["rowH"]) + 8.0, "goal spacing adds room above and below each goal");
	assert_eq!(out["glyph"]["icon"], 30, "goal glyphs at 200%");
	assert_eq!(out["check"]["check"], 27, "tick boxes at 150%");
	assert_eq!(out["tabs"]["strip"], 42, "the tab bar at 150%");
	assert_eq!(out["nav"]["nav"], 51, "the step bar at 150%");
	assert_eq!(out["line"]["line"], 8, "the progress line's thickness");
	assert!(n(&out["goal"]["height"]) > n(&b["height"]), "the window grows with its content");
	assert_eq!(out["back"], out["base"], "back to the defaults, the window is as it was");
}

#[test]
fn parts_colours_ground_and_border_follow_their_settings() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local base = snapshot()
		Polestar.Set("guideWindow.tabs", false)
		Polestar.Set("guideWindow.stepCount", false)
		Polestar.Set("guideWindow.skipButton", false)
		Polestar.Set("guideWindow.reportButton", false)
		Polestar.Set("guideWindow.progress", false)
		local hidden = snapshot()
		hidden.title = P.nav.Title:IsShown()
		Polestar.Set("guideWindow.progress", true)
		Polestar.Set("guideWindow.progressPct", false)
		local noPct = snapshot()
		Polestar.Set("guideWindow.targetBarColor", { 1, 0, 0 })
		Polestar.Set("guideWindow.targetBarWidth", 4)
		Polestar.Set("guideWindow.progressColor", { 0, 0, 1 })
		local painted = snapshot()
		painted.markColor = { firstRow().Mark:GetVertexColor() }
		painted.fill = { P.line.Fill:GetVertexColor() }
		Polestar.Set("guideWindow.targetBar", false)
		local noMark = snapshot()
		Polestar.Set("guideWindow.bgColor", { 0.2, 0.1, 0.3 })
		Polestar.Set("guideWindow.bgOpacity", 0.5)
		Polestar.Set("guideWindow.border", false)
		local ground = snapshot()
		Polestar.Set("guideWindow.rules", false)
		local rules = { strip = P.strip.Rule:IsShown(), after = P.after.Rule:IsShown() }
		emit({ base = base, hidden = hidden, noPct = noPct, painted = painted, noMark = noMark, ground = ground, rules = rules,
			vertex = { F.psSkin.bg:GetVertexColor() } })"#);
	let b = &out["base"];
	let h = &out["hidden"];
	assert_eq!(h["strip"], 0, "no tabs");
	assert_eq!(h["steps"], false, "no step number");
	assert_eq!(h["title"], true, "the guide's title names the guide instead");
	assert_eq!(h["skip"], false);
	assert_eq!(h["report"], false);
	assert_eq!(h["foot"], false, "no progress bar");
	assert_eq!(h["height"].as_f64().unwrap(), b["height"].as_f64().unwrap() - 28.0 - 26.0, "the window loses the tab bar's and the progress bar's height");
	assert_eq!(out["noPct"]["pct"], false);
	assert_eq!(out["painted"]["markW"], 4);
	assert_eq!(out["painted"]["personMarkW"], 4, "the person's bar too");
	assert_eq!(out["painted"]["markColor"], json!([1, 0, 0, 1]));
	assert_eq!(out["painted"]["fill"], json!([0, 0, 1, 1]));
	assert_eq!(out["noMark"]["markA"], 0, "the target bar off");
	assert_eq!(out["ground"]["bgColor"], json!([0.2, 0.1, 0.3]));
	assert_eq!(out["ground"]["bgAlpha"], 0.5);
	assert_eq!(out["ground"]["noBorder"], true);
	let v = out["vertex"].as_array().unwrap();
	assert_eq!(v[0], 0.2, "the skin paints this window's own ground: {:?}", v);
	assert_eq!(v[3], 0.5);
	assert_eq!(out["rules"], json!({ "strip": false, "after": false }), "dividers off");
}

#[test]
fn transparent_outline_backing_strength_idle_fade_and_hiding_on_a_flight() {
	let out = run(r#"
		local onTaxi = false
		UnitOnTaxi = function() return onTaxi end
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.style", "transparent")
		local thin = flags(firstRow().Text)
		Polestar.Set("guideWindow.outline", "thick")
		local thick = flags(firstRow().Text)
		Polestar.Set("guideWindow.outline", "shadow")
		local shadow = flags(firstRow().Text)
		Polestar.Set("ui.backing", "dark")
		Polestar.Set("guideWindow.veil", 0.9)
		local veil = { GF.veil.parts[1]:GetVertexColor() }
		Polestar.Set("ui.style", "standard")
		local standard = flags(firstRow().Text)
		Polestar.Set("guideWindow.idleAlpha", 0.4)
		local away = F:GetAlpha()
		GF.HoverIn()
		GF.ApplyAlpha(false)
		local over = F:GetAlpha()
		Polestar.Set("guideWindow.hideTaxi", true)
		onTaxi = true
		Polestar.Fire("SETTING_CHANGED", "guideWindow.hideTaxi")
		local flying = F:IsShown()
		onTaxi = false
		GF.ApplyVisibility()
		emit({ thin = thin, thick = thick, shadow = shadow, veil = veil[4], standard = standard, away = away, over = over,
			flying = flying, landed = F:IsShown() })"#);
	assert_eq!(out["thin"], "OUTLINE", "the transparent style's thin outline by default");
	assert_eq!(out["thick"], "THICKOUTLINE");
	assert_eq!(out["shadow"], "", "the drop shadow alone");
	assert_eq!(out["veil"], 0.9, "the dark backing at the player's strength");
	assert_eq!(out["standard"], "", "the Standard style draws no outline whatever the setting");
	assert_eq!(out["away"], 0.4, "faded while the cursor is away");
	assert_eq!(out["over"], 1, "in full under the cursor");
	assert_eq!(out["flying"], false, "hidden on a flight");
	assert_eq!(out["landed"], true, "back on landing");
}

#[test]
fn the_preview_lays_out_a_step_card_by_the_windows_numbers_without_touching_the_live_window() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local live = snapshot()
		local rows = #GF.rows
		local f = Polestar.UI.GuideWindowPreview(UIParent)
		local h = f:Layout(900)
		local r = f.Rows[2]
		local function card()
			local _, _, _, x = r.Text:GetPoint(1)
			return { text = size(r.Text), name = size(f.Person.Name), x = x, rowH = r:GetHeight(), mark = r.Mark:GetWidth(),
				strip = f.Strip:IsShown(), foot = f.Foot:IsShown(), w = f.Window:GetWidth(), line = r.Text:GetText() }
		end
		local before = card()
		-- At its own size the window is taller than the band: a change scrolls to its part.
		Polestar.Set("guideWindow.progressHeight", 6)
		local footScroll = f.psScroll
		Polestar.Set("guideWindow.tabHeight", 1.1)
		local topScroll = f.psScroll
		Polestar.Set("guideWindow.progressHeight", nil)
		Polestar.Set("guideWindow.tabHeight", nil)
		Polestar.Set("guideWindow.goalSize", 1.5)
		Polestar.Set("guideWindow.titleSize", 1.4)
		Polestar.Set("guideWindow.padding", 6)
		Polestar.Set("guideWindow.targetBarWidth", 5)
		Polestar.Set("guideWindow.tabs", false)
		Polestar.Set("guideWindow.progress", false)
		Polestar.Set("ui.width", 420)
		local after = card()
		local liveRow = firstRow()
		emit({ h = h, before = before, after = after, rows = #GF.rows == rows, liveText = size(liveRow.Text),
			window = f.Window ~= F, scale = f.psScale, footScroll = footScroll, topScroll = topScroll, hot = f.psHot or false })"#);
	assert_eq!(out["h"], 250);
	let b = &out["before"];
	let a = &out["after"];
	assert_eq!(b["text"], 14, "the preview's goals at the goal role's size");
	assert_eq!(b["name"], 15);
	assert_eq!(b["x"], 39, "its text at the window's TEXT_X");
	assert_eq!(b["mark"], 2);
	assert_eq!(b["w"], 340, "the window's own width");
	assert!(b["line"].as_str().unwrap().contains("3/8"), "the demo goal drawn by UI.GoalLine: {}", b["line"]);
	assert_eq!(a["text"], 21, "goal size follows");
	assert_eq!(a["name"], 21, "person size follows");
	assert_eq!(a["x"], 45, "padding follows");
	assert_eq!(a["mark"], 5, "the target bar follows");
	assert_eq!(a["strip"], false);
	assert_eq!(a["foot"], false);
	assert_eq!(a["w"], 420, "width follows");
	assert!(a["rowH"].as_f64().unwrap() > b["rowH"].as_f64().unwrap());
	assert_eq!(out["rows"], true, "no row added to the live window");
	assert_eq!(out["window"], true, "the preview draws its own window");
	assert_eq!(out["liveText"], 21, "the live window followed the same setting");
	assert_eq!(out["scale"], 1, "drawn at 100%");
	assert!(out["footScroll"].as_f64().unwrap() > 0.0, "scrolled down to the progress bar it edits");
	assert_eq!(out["topScroll"], 0, "back up to the bars");
	assert_eq!(out["hot"], true, "the parts are hotspots that jump to their rows");
}

#[test]
fn the_settings_window_lays_the_page_out_by_element_with_inline_switches_swatches_and_cogs() {
	let out = run(r#"
		Polestar.Set("ui.style", "transparent") -- the backing and its cog are for the transparent style
		Polestar.UI.ShowOptions("guidewindow")
		local O = Polestar.UI.Options
		local page
		for _, p in ipairs(O.Pages()) do if p.key == "guidewindow" then page = p end end
		local function keysOf(c)
			local keys = {}
			for k in pairs(c) do if type(k) == "string" and (k:find("^guideWindow%.") or k:find("^ui%.")) then keys[#keys + 1] = k end end
			table.sort(keys)
			return keys
		end
		local window = O.Controls("guidewindow", "Window")
		-- What only the Transparent style uses sits behind the Style row's cog,
		-- the step slide's speed behind its own.
		window["ui.style"].Cog:Click()
		local styleMore = keysOf(O.MoreControls())
		window["guideWindow.stepAnim"].Cog:Click()
		local slideMore = keysOf(O.MoreControls())
		O.Select("guidewindow", "Parts")
		emit({ tabs = page and page.tabs or false, window = keysOf(window), parts = keysOf(O.Controls("guidewindow", "Parts")),
			styleMore = styleMore, slideMore = slideMore })"#);
	assert_eq!(out["tabs"], json!(["Window", "Parts"]), "the frame as a whole, then its parts in the window's order");
	let has = |list: &str, k: &str| out[list].as_array().unwrap().iter().any(|v| v == k);
	for k in ["ui.style", "ui.scale", "ui.width", "ui.opacity", "guideWindow.idleAlpha", "guideWindow.bgOpacity", "guideWindow.bgColor", "ui.combat", "guideWindow.hideTaxi"] {
		assert!(has("window", k), "{k} on the Window tab: {}", out["window"]);
	}
	for k in [
		"guideWindow.tabs",
		"guideWindow.targetBar",
		"guideWindow.targetBarColor",
		"guideWindow.progress",
		"guideWindow.progressColor",
		"ui.showNotes",
		"guideWindow.goalSize",
		"guideWindow.titleSize",
		"ui.upcoming",
		"guideWindow.noteSize",
	] {
		assert!(has("parts", k), "{k} on the Parts tab (inline switches and swatches included): {}", out["parts"]);
	}
	assert_eq!(out["styleMore"], json!(["guideWindow.outline", "guideWindow.shade", "guideWindow.veil", "ui.backing", "ui.barShown"]), "the transparent style's settings in the Style cog");
	assert_eq!(out["slideMore"], json!(["guideWindow.animSpeed"]), "the slide's speed in its cog");
}

// A registered skin's `guideTitle` hook dresses the navigator: the title bar and the close square shown, the band
// hidden, the menu moved in for the square, the rule in titleLine. The transparent window and the other skins keep
// the house title.
#[test]
fn a_registered_skin_s_guide_title_hook_dresses_the_navigator() {
	let out = run(r##"
		local T = Polestar.Theme
		local ok, why = T.RegisterSkin("titled", { name = "Titled", addon = "Test_Titled", base = "polestar",
			tokens = { titleLine = "#43331E", closeFill = "#9C211D" },
			hooks = { guideTitle = function(nav, parts)
				parts.bar:Show()
				parts.close:Show()
				parts.band:Hide()
				parts.menuRight = 26
			end } })
		uistub.openTabs(TABS, 1)
		local function title()
			local _, _, _, mx = P.nav.Menu:GetPoint(1)
			local r, g, b = P.nav.Rule:GetVertexColor()
			return { bar = P.nav.TitleBar:IsShown(), close = P.nav.Close:IsShown(), band = P.band:IsShown(), menu = mx,
				rule = string.format("%02x%02x%02x", r * 255 + 0.5, g * 255 + 0.5, b * 255 + 0.5) }
		end
		local house = title()
		Polestar.Set("ui.skin", "titled")
		local titled = title()
		local before, wasShown = #stub.messages, Polestar.Get("ui.shown")
		P.nav.Close:Click()
		titled.closed = { was = wasShown, shown = Polestar.Get("ui.shown"), printed = table.concat(stub.messages, "\n", before + 1) }
		Polestar.Set("ui.shown", true)
		local f =Polestar.UI.GuideWindowPreview(UIParent)
		f:Layout(900)
		titled.previewBar, titled.previewClose = f.Nav.TitleBar:IsShown(), f.Nav.Close:IsShown()
		Polestar.Set("ui.style", "transparent")
		local clear = title()
		Polestar.Set("ui.style", "standard")
		Polestar.Set("ui.skin", "polestar")
		emit({ ok = ok, why = why or false, house = house, titled = titled, clear = clear, back = title() })"##);
	assert_eq!(out["ok"], true, "registered: {}", out["why"]);
	let h = &out["house"];
	assert_eq!((h["bar"].clone(), h["close"].clone(), h["band"].clone(), h["menu"].clone()), (json!(false), json!(false), json!(true), json!(-8)), "the house title: {h}");
	let t = &out["titled"];
	assert_eq!((t["bar"].clone(), t["close"].clone(), t["band"].clone(), t["menu"].clone()), (json!(true), json!(true), json!(false), json!(-26)), "the hook's title: {t}");
	assert_eq!(t["rule"], "43331e", "the rule under a title bar in titleLine");
	let x = &t["closed"];
	assert_eq!((x["was"].clone(), x["shown"].clone()), (json!(true), json!(false)), "the close square hides the window: {x}");
	assert!(x["printed"].as_str().unwrap_or("").contains("Type /polestar to bring it back."), "and says how to bring it back: {x}");
	assert_eq!((t["previewBar"].clone(), t["previewClose"].clone()), (json!(true), json!(true)), "the Looks preview runs the same hook");
	let c = &out["clear"];
	assert_eq!((c["bar"].clone(), c["close"].clone(), c["band"].clone()), (json!(false), json!(false), json!(false)), "the transparent window draws no title: {c}");
	assert_eq!(out["back"], out["house"], "back on the house skin, its own title");
}

// Skin API 2's guide window hooks: a skin dresses each goal row once painted (guideRow), takes room of its own
// under the window's parts (guideLayout: the window grows by its answer), hears every render with the step on
// screen (guideRender), paints its own progress (guideProgress) and gives the heads-up card the frame to sit on
// (guideAnchor). Without the skin, nothing of it stays.
#[test]
fn a_registered_skin_s_guide_window_hooks_dress_rows_add_room_follow_renders_and_anchor_the_heads_up() {
	let out = run(r##"
		local T = Polestar.Theme
		local seen = { rows = 0, renders = 0 }
		local cards
		local ok, why = T.RegisterSkin("dense", { name = "Dense", addon = "Test_Dense", base = "polestar",
			hooks = {
				guideRow = function(row, goal, info)
					seen.rows = seen.rows + 1
					row.psDense = goal.t .. (info.current and ":current" or "")
				end,
				guideLayout = function(parts, width, y)
					cards = cards or CreateFrame("Frame", nil, parts.window)
					cards:ClearAllPoints()
					cards:SetPoint("BOTTOMLEFT", parts.window, "TOPLEFT", 0, 0)
					cards:SetSize(width, 30)
					seen.layoutY = y
					return 20
				end,
				guideRender = function(view, parts) seen.renders = seen.renders + 1; seen.step = view and view.index or false; seen.parts = parts.window == F end,
				guideProgress = function(foot, frac) seen.frac = frac end,
				guideAnchor = function() return cards end,
			} })
		uistub.openTabs(TABS, 1)
		local before = math.floor(F:GetHeight() + 0.5)
		Polestar.Set("ui.skin", "dense")
		GF.Render()
		local after = math.floor(F:GetHeight() + 0.5)
		local r = firstRow()
		local CT = Polestar.UI.ClassToast
		CT.ShowCard({ head = "LEVEL 10", title = "Something ready", act = { label = "Go", run = function() end } })
		local _, rel = CT.frame:GetPoint(1)
		local onCards = rel == cards
		CT.Hide()
		Polestar.Set("ui.skin", "polestar")
		GF.Render()
		emit({ ok = ok, why = why or false, before = before, after = after, dense = r.psDense or false, rows = seen.rows > 0,
			renders = seen.renders > 0, step = seen.step, parts = seen.parts, frac = seen.frac ~= nil, layoutY = seen.layoutY ~= nil,
			onCards = onCards, back = math.floor(F:GetHeight() + 0.5), v = T.API_VERSION,
			caps = { T.HasCapability("surfaces.guideRow"), T.HasCapability("surfaces.guideLayout"), T.HasCapability("surfaces.guideRender"),
				T.HasCapability("surfaces.guideProgress"), T.HasCapability("surfaces.guideAnchor"), T.HasCapability("guideParts") } })"##);
	assert_eq!(out["ok"], true, "registered: {}", out["why"]);
	assert_eq!(out["v"], 2);
	assert_eq!(out["caps"], json!([true, true, true, true, true, true]));
	assert_eq!(
		(out["rows"].clone(), out["renders"].clone(), out["parts"].clone(), out["frac"].clone(), out["layoutY"].clone()),
		(json!(true), json!(true), json!(true), json!(true), json!(true)),
		"{out}"
	);
	assert!(out["dense"].as_str().unwrap_or("").len() > 1, "the row was dressed: {}", out["dense"]);
	assert_eq!(out["step"], 3, "the step on screen");
	assert_eq!(n(&out["after"]) - n(&out["before"]), 20.0, "the window grew by the skin's room");
	assert_eq!(out["onCards"], true, "the heads-up card sits on the skin's frame");
	assert_eq!(out["back"], out["before"], "back on the house skin, its own height");
}

fn n(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}
