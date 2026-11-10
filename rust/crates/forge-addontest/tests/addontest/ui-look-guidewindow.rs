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
		script: format!("uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\nlocal F = PolestarGuideFrame\n{HELPERS}\n{script}"),
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
		json!({ "pad": 12, "tabH": 26, "navH": 30, "progH": 14, "icon": 13, "textX": 32, "check": 13, "rowPad": 0, "upRow": 18, "upToggle": 22, "glyphY": 8 }),
		"the house style's dense step card sizes, as before the look settings"
	);
	assert_eq!(out["before"], out["after"], "re-setting every default repaints nothing differently");
	assert_eq!(out["stored"], true, "a value equal to its default is never stored");
	let b = &out["before"];
	assert_eq!(b["rowText"], 11.5, "goal text at the cardGoal role's size");
	assert_eq!(b["name"], 12.5, "the person at the cardName role's size");
	assert_eq!(b["tip"], 10, "the tip at the cardNote role's size");
	assert_eq!(b["iconY"], -8, "the goal glyph on the dense row's first line");
	assert_eq!(b["markW"], 2, "the 2px target bar");
	assert_eq!(b["markA"], 1);
	assert_eq!(b["line"], 4, "the house look's 4px progress line");
	assert_eq!(b["strip"], 26);
	assert_eq!(b["nav"], 30);
	assert_eq!(b["foot"], true);
	assert_eq!(b["pct"], true);
	assert_eq!(b["steps"], true);
	assert_eq!(b["skip"], true);
	assert_eq!(b["report"], false, "the bug report is in the ⋯ menu; the option puts it on the navigator");
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
	assert_eq!(out["goal"]["rowText"], 17.5, "goals at 150% of 11.5: {}", out["goal"]);
	assert!(n(&out["goal"]["rowH"]) > n(&b["rowH"]), "the row grows with its text");
	assert!(n(&out["goal"]["iconY"]) < n(&b["iconY"]), "the glyph follows the larger first line down");
	assert_eq!(out["goal"]["name"], b["name"], "only the goals change size");
	assert_eq!(out["title"]["name"], 17.5, "the person at 140% of 12.5");
	assert_eq!(out["title"]["rowText"], b["rowText"]);
	assert_eq!(out["note"]["tip"], 15, "the tip at 150% of 10");
	assert_eq!(out["bar"]["count"], 18, "the step number at 150%");
	assert_eq!(n(&out["pad"]["rowTextX"]), n(&b["rowTextX"]) + 6.0, "inner padding moves the text in");
	// The dense row's text is 16.5px tall, held up to the 18px least height; 4px above and below grow it to 25.
	assert_eq!(n(&out["rows"]["rowH"]), n(&b["rowH"]) + 7.0, "goal spacing adds room above and below each goal");
	assert_eq!(out["glyph"]["icon"], 26, "goal glyphs at 200%");
	assert_eq!(out["check"]["check"], 20, "tick boxes at 150%");
	assert_eq!(out["tabs"]["strip"], 39, "the tab bar at 150%");
	assert_eq!(out["nav"]["nav"], 45, "the step bar at 150%");
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
		local rules = { strip = P.strip.Rule:IsShown(), after = P.after.Rule:GetAlpha() }
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
	assert_eq!(
		h["height"].as_f64().unwrap(),
		b["height"].as_f64().unwrap() - 26.0 - 14.0,
		"the window loses the tab bar's and the progress bar's height"
	);
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
	assert_eq!(out["rules"], json!({ "strip": false, "after": 0 }), "dividers off");
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
			window = f.Window ~= F, scale = f.psScale })"#);
	assert_eq!(out["h"], 290);
	let b = &out["before"];
	let a = &out["after"];
	assert_eq!(b["text"], 11.5, "the preview's goals at the cardGoal role's size, as the live card");
	assert_eq!(b["name"], 12.5);
	assert_eq!(b["x"], 42, "its text at the window's TEXT_X, one step (10) in under the title");
	assert_eq!(b["mark"], 2);
	assert_eq!(b["w"], 340, "the window's own width");
	assert!(b["line"].as_str().unwrap().contains("3/8"), "the demo goal drawn by UI.GoalLine: {}", b["line"]);
	assert_eq!(a["text"], 17.5, "goal size follows");
	assert_eq!(a["name"], 17.5, "person size follows");
	assert_eq!(a["x"], 48, "padding follows");
	assert_eq!(a["mark"], 5, "the target bar follows");
	assert_eq!(a["strip"], false);
	assert_eq!(a["foot"], false);
	assert_eq!(a["w"], 420, "width follows");
	assert!(a["rowH"].as_f64().unwrap() > b["rowH"].as_f64().unwrap());
	assert_eq!(out["rows"], true, "no row added to the live window");
	assert_eq!(out["window"], true, "the preview draws its own window");
	assert_eq!(out["liveText"], 17.5, "the live window followed the same setting");
}

#[test]
fn the_settings_window_has_the_guide_window_page_with_its_controls() {
	let out = run(r#"
		Polestar.UI.ShowOptions("guidewindow")
		local O = Polestar.UI.Options
		local page
		for _, p in ipairs(O.Pages()) do if p.key == "guidewindow" then page = p end end
		local c = O.Controls("guidewindow")
		local keys = {}
		for k in pairs(c) do if type(k) == "string" and (k:find("^guideWindow%.") or k:find("^ui%.")) then keys[#keys + 1] = k end end
		table.sort(keys)
		emit({ tabs = page and page.tabs or false, keys = keys })"#);
	let tabs = out["tabs"].as_array().expect("the page is listed");
	assert!(tabs.len() >= 4, "Window, Text, Parts, Motion: {:?}", tabs);
	let keys: Vec<&str> = out["keys"].as_array().unwrap().iter().map(|k| k.as_str().unwrap()).collect();
	for k in ["ui.style", "ui.backing", "ui.barShown", "ui.scale", "ui.width", "ui.opacity", "guideWindow.idleAlpha", "guideWindow.bgOpacity"] {
		assert!(keys.contains(&k), "{k} on the Window tab: {:?}", keys);
	}
}

// A registered skin on the house base takes the dense card and can size its roles (`fontSizes.cardGoal`), and its
// `guideTitle` hook dresses the navigator: the title bar and the close square shown, the band hidden, the menu
// moved in for the square, the rule in titleLine. The transparent window and the other skins keep the house title.
#[test]
fn a_registered_skin_sizes_the_card_s_roles_and_its_guide_title_hook_dresses_the_navigator() {
	let out = run(r##"
		local T = Polestar.Theme
		local ok, why = T.RegisterSkin("titled", { name = "Titled", addon = "Test_Titled", base = "polestar", fontSizes = { cardGoal = 13 },
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
				goal = size(firstRow().Text), rule = string.format("%02x%02x%02x", r * 255 + 0.5, g * 255 + 0.5, b * 255 + 0.5) }
		end
		local house = title()
		Polestar.Set("ui.skin", "titled")
		local titled = title()
		titled.card = GF.Metrics().card
		local f = Polestar.UI.GuideWindowPreview(UIParent)
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
	assert_eq!(h["goal"], 11.5);
	let t = &out["titled"];
	assert_eq!(t["card"], true, "a skin on the house base takes the dense card");
	assert_eq!(t["goal"], 13, "fontSizes.cardGoal sizes the card's goals");
	assert_eq!((t["bar"].clone(), t["close"].clone(), t["band"].clone(), t["menu"].clone()), (json!(true), json!(true), json!(false), json!(-26)), "the hook's title: {t}");
	assert_eq!(t["rule"], "43331e", "the rule under a title bar in titleLine");
	assert_eq!((t["previewBar"].clone(), t["previewClose"].clone()), (json!(true), json!(true)), "the Looks preview runs the same hook");
	let c = &out["clear"];
	assert_eq!((c["bar"].clone(), c["close"].clone(), c["band"].clone()), (json!(false), json!(false), json!(false)), "the transparent window draws no title: {c}");
	assert_eq!(out["back"], out["house"], "back on the house skin, its own title");
}
