//! The Hearth skin (Theme.lua SKIN_PALETTES.hearth, its painters in Polestar_Looks/Hearth.lua, the hearth
//! branches of Theme/Widgets.lua and UI/GuideFrame.lua): an inn by the fire, drawn in Polestar's own art. Every surface
//! takes it: the guide window (its tabs, mantel, framed buttons, tick boxes and progress line), the controls
//! (planks, switches, sliders, dropdowns, edit boxes, scroll bars), menus and the toasts; the transparent style
//! puts the board and its light away; the game's looks are untouched by it.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", FILES)],
		script: format!("uistub.install()\nstub.login()\nlocal T, W = Polestar.Theme, Polestar.Widgets\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn round(list: &Value) -> Vec<f64> {
	list.as_array().unwrap().iter().map(|v| (v.as_f64().unwrap() * 1000.0).round() / 1000.0).collect()
}

fn rgb(list: &Value) -> Vec<f64> {
	round(list)[..3].to_vec()
}

#[test]
fn hearth_draws_the_guide_window_as_a_lit_board_planks_for_its_tabs_and_buttons_the_house_switches_and_line() {
	let out = run(r#"
		local GF = Polestar.UI.GuideFrame
		Polestar.Set("ui.skin", "hearth")
		uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 } }, 1)
		local F, P = GF.frame, GF.parts
		local k = F.psSkin.kit
		local out = {}
		out.window = { board = k.board:IsShown(), ember = k.ember:IsShown(), emberAlpha = select(4, k.ember:GetVertexColor()),
			bg = F.psSkin.bg == nil or not F.psSkin.bg:IsShown(), border = F.psBorder[1]:IsShown(), shadow = F.psShadow:IsShown() }
		out.emberColor = { k.ember:GetVertexColor() }
		-- the mantel under the tabs, and its copper rule
		out.mantel = { shown = P.nav.TitleBar:IsShown(), rule = { P.nav.Rule:GetVertexColor() } }
		local _, _, _, x, y = P.nav.TitleBar:GetPoint(1)
		out.mantelAt = { x, y }
		-- the tabs: the active one a plank with the accent bar, the rest bare
		local active, rest
		for _, b in ipairs(GF.tabs) do
			if b:IsShown() then
				if b.psActive then active = b elseif not rest then rest = b end
			end
		end
		out.activeTab = { plank = active.psFrameTex:IsShown(), bar = active.Bar:IsShown(), wash = active.Selected:IsShown(), label = { active.Label:GetTextColor() } }
		out.restTab = { plank = rest.psFrameTex:IsShown(), bar = rest.Bar:IsShown(), label = { rest.Label:GetTextColor() } }
		-- the step buttons and the menu button carry their framed planks
		out.prev = { frame = P.nav.Prev.psFrame:IsShown(), edge = { P.nav.Prev.psBorder[1]:GetVertexColor() }, size = P.nav.Prev:GetWidth() }
		out.menu = { frame = P.nav.Menu.psFrame:IsShown(), size = { P.nav.Menu:GetWidth(), P.nav.Menu:GetHeight() } }
		-- the progress line, not the game's status bar
		out.foot = { line = P.foot.Line:IsShown(), status = rawget(P.foot, "Status") == nil or not P.foot.Status:IsShown(), h = P.foot:GetHeight() }
		-- a goal's tick box: a copper-edged recess, 15 a side
		local row
		for _, r in ipairs(GF.rows) do if r:IsShown() and r.Check:IsShown() then row = r break end end
		local box = row.Check.psSkin.box
		out.check = { size = box:GetWidth(), edge = { box.psBorder[1]:GetVertexColor() }, fill = { box.psSkin.bg:GetVertexColor() } }
		-- the person's rule and the glyph of the goal to do now
		out.personRule = P.person.Rule:IsShown()
		emit(out)"#);
	let w = &out["window"];
	assert_eq!(w["board"], true, "the gradient board");
	assert_eq!(w["ember"], true, "the ember light");
	assert_eq!(w["bg"], true, "the house's flat fill is not shown under it");
	assert_eq!(w["border"], true, "the copper hairline (the window border setting)");
	assert_eq!(w["shadow"], true, "the house drop shadow");
	assert_eq!(rgb(&out["emberColor"]), [1.0, 0.478, 0.18], "the light is the ember token");
	assert!((0.19..=0.21).contains(&w["emberAlpha"].as_f64().unwrap()), "the guide window sits nearer the fire than a big window ({})", w["emberAlpha"]);
	assert_eq!(out["mantel"]["shown"], true, "the mantel band under the tabs");
	assert_eq!(out["mantelAt"], json!([0, 0]), "the band spans the navigator edge to edge");
	assert_eq!(rgb(&out["mantel"]["rule"]), [0.604, 0.392, 0.188], "its rule in the copper titleLine, #9A6430");
	let a = &out["activeTab"];
	assert_eq!(a["plank"], true, "the active tab stands on a plank");
	assert_eq!(a["bar"], true, "with the accent bar along the seam");
	assert_eq!(a["wash"], false, "no house wash under it");
	assert_eq!(rgb(&a["label"]), [1.0, 0.851, 0.627], "its label in the firelit gold");
	let r = &out["restTab"];
	assert_eq!(r["plank"], false, "the other tabs are bare");
	assert_eq!(r["bar"], false);
	assert_eq!(rgb(&r["label"]), [0.702, 0.616, 0.475], "in tabRest");
	assert_eq!(out["prev"]["frame"], true, "‹ on its plank");
	assert_eq!(rgb(&out["prev"]["edge"]), [0.69, 0.478, 0.235], "edged in copper");
	assert_eq!(out["prev"]["size"], 22);
	assert_eq!(out["menu"]["frame"], true);
	assert_eq!(out["menu"]["size"], json!([24, 22]));
	assert_eq!(out["foot"], json!({ "line": true, "status": true, "h": 20 }), "the house's slim line in a 20-high footer");
	assert_eq!(out["check"]["size"], 15);
	assert_eq!(rgb(&out["check"]["edge"]), [0.69, 0.478, 0.235], "the box token, #B07A3C");
	assert_eq!(round(&out["check"]["fill"]), [0.078, 0.039, 0.016, 0.55], "inputBg: the recess");
	assert_eq!(out["personRule"], true, "the person's name over a copper separator");
}

#[test]
fn hearth_controls_are_planks_switches_grooves_and_recesses_in_polestar_s_own_art_and_primary_buttons_take_the_accent() {
	let out = run(r#"
		Polestar.Set("ui.skin", "hearth")
		local host = Polestar.UI.GuideFrame.frame
		host:SetSize(400, 400)
		local out = {}
		-- a plain text button: a plank; a primary one: the accent fill with dark ink
		local plain = W.Button(host, "Later", function() end)
		local primary = W.Button(host, "Accept", function() end, { primary = true })
		local function plank(b)
			local d, k = b.psSkin, b.psSkin.kit or {}
			return { board = k.board ~= nil and k.board:IsShown(), fill = d.bg ~= nil and d.bg:IsShown(), fillColor = d.bg and { d.bg:GetVertexColor() } or false,
				edge = { b.psBorder[1]:GetVertexColor() }, edgeShown = b.psBorder[1]:IsShown(), label = { b.Label:GetTextColor() }, h = b:GetHeight() }
		end
		out.plain, out.primary = plank(plain), plank(primary)
		-- a toggle: the house switch (track and knob), no game box
		local t = W.Toggle(host, "Switch", "ui.shadow", "desc")
		out.toggle = { knob = t.Knob:IsShown(), track = t.Track.parts[1]:IsShown(), gameBox = rawget(t, "psGameBox") ~= nil, h = t:GetHeight() }
		-- a slider: a 3-unit groove, the accent fill, a round thumb in the firelit gold
		local s = W.Slider(host, "Size", "ui.scale", 0.5, 2, 0.05, nil, "desc")
		out.slider = { trackH = s.Track:GetHeight(), fill = s.Fill:IsShown(), fillH = s.Fill:GetHeight(), thumb = s.Thumb:GetTexture(), thumbColor = { s.Thumb:GetVertexColor() }, thumbW = s.Thumb:GetWidth() }
		-- a dropdown: a plank with Polestar's chevron
		local dd = W.Dropdown(host, "Pick", "ui.font", { { value = "skin", text = "Skin" }, { value = "game", text = "Game" } }, "desc")
		local k = dd.Button.psSkin.kit or {}
		out.dropdown = { board = k.board ~= nil and k.board:IsShown(), arrow = dd.Button.Arrow:GetTexture(), arrowSize = dd.Button.Arrow:GetWidth(), h = dd.Button:GetHeight() }
		-- an edit box: the recess with a dark copper edge, the accent while focused
		local e = W.SearchBox(host, "Find", function() end)
		if e then
			out.edit = { fill = { e.psSkin.bg:GetVertexColor() }, edge = { e.psBorder[1]:GetVertexColor() } }
			T.SetFocused(e, true)
			out.editFocused = { e.psBorder[1]:GetVertexColor() }
		end
		-- a scroll bar: the house's slim thumb in the copper thumb token
		local sf = W.Scroll(host)
		sf:SetSize(200, 100)
		local bar = sf.Bar or sf.bar
		if bar then out.scroll = { w = bar:GetWidth(), thumb = { bar.Thumb:GetVertexColor() } } end
		-- a menu: the panel paint, a flat board with a dark copper edge
		W.ShowMenu(host, { { text = "One" }, { text = "Two" } })
		local m = PolestarMenu
		out.menu = { fill = { m.psSkin.bg:GetVertexColor() }, edge = { m.psBorder[1]:GetVertexColor() }, row = T.Metric("menuRow", 26) }
		emit(out)"#);
	let p = &out["plain"];
	assert_eq!(p["board"], true, "a text button is a plank (its own gradient texture)");
	assert_eq!(p["fill"], false, "the house fill stays out of sight");
	assert_eq!(rgb(&p["edge"]), [0.69, 0.478, 0.235], "edged in copper (frameEdge)");
	assert_eq!(round(&p["edge"])[3], 0.6);
	assert_eq!(rgb(&p["label"]), [0.961, 0.914, 0.827], "parchment text on the plank");
	assert_eq!(p["h"], 26);
	let pr = &out["primary"];
	assert_eq!(pr["board"], false, "a primary button has no plank");
	assert_eq!(pr["fill"], true);
	assert_eq!(rgb(&pr["fillColor"]), [1.0, 0.58, 0.251], "the ember accent fills it");
	assert_eq!(rgb(&pr["label"]), [0.122, 0.071, 0.039], "dark ink on it (onAccent)");
	assert_eq!(out["toggle"], json!({ "knob": true, "track": true, "gameBox": false, "h": 32 }), "the house switch in a 32 row, no vanilla check box");
	let s = &out["slider"];
	assert_eq!(s["trackH"], 3, "a deeper groove than the house's 2");
	assert_eq!(s["fill"], true);
	assert_eq!(s["fillH"], 3);
	assert_eq!(s["thumb"], "Interface\\AddOns\\Polestar\\Media\\UI\\circle", "Polestar's round thumb, not the game's");
	assert_eq!(rgb(&s["thumbColor"]), [1.0, 0.851, 0.627], "in the firelit gold");
	assert_eq!(s["thumbW"], 12);
	let d = &out["dropdown"];
	assert_eq!(d["board"], true, "the dropdown is a plank");
	assert_eq!(d["arrow"], "Interface\\AddOns\\Polestar\\Media\\UI\\chevron-down", "Polestar's chevron, not the game's arrow");
	assert_eq!(d["arrowSize"], 10);
	assert_eq!(d["h"], 26);
	if out["edit"] != Value::Null {
		assert_eq!(round(&out["edit"]["fill"]), [0.078, 0.039, 0.016, 0.55], "the recess (inputBg)");
		assert_eq!(rgb(&out["edit"]["edge"]), [0.353, 0.212, 0.094], "a dark copper edge at rest");
		assert_eq!(rgb(&out["editFocused"]), [1.0, 0.58, 0.251], "the accent while focused");
	}
	if out["scroll"] != Value::Null {
		assert_eq!(out["scroll"]["w"], 6, "the house's slim bar");
		assert_eq!(round(&out["scroll"]["thumb"]), [0.784, 0.565, 0.353, 0.6], "its thumb in copper");
	}
	let m = &out["menu"];
	assert_eq!(round(&m["fill"]), [0.173, 0.102, 0.059, 1.0], "the menu on the panel board, solid");
	assert_eq!(rgb(&m["edge"]), [0.353, 0.212, 0.094], "with a dark copper edge");
	assert_eq!(m["row"], 24);
}

// A button made primary after it was laid (W.RepaintButton: a confirm's action, as Every dungeon quest's warning)
// is drawn as one laid primary: the accent fill with dark ink, no plank over it; made plain again, a plank.
#[test]
fn hearth_draws_a_button_made_primary_after_it_was_laid_with_the_accent_not_a_plank() {
	let out = run(r#"
		Polestar.Set("ui.skin", "hearth")
		local function plank(b)
			local d, k = b.psSkin, b.psSkin.kit or {}
			return { board = k.board ~= nil and k.board:IsShown(), fill = d.bg ~= nil and d.bg:IsShown(), fillColor = d.bg and { d.bg:GetVertexColor() } or false,
				label = { b.Label:GetTextColor() } }
		end
		W.Modal({ title = "Every dungeon quest", text = "Be ready for more travelling.", action = "Every quest", cancel = "Only quests on my way" })
		local a = PolestarModal.Box.Action
		local modal = plank(a)
		a.psPrimary = false
		W.RepaintButton(a)
		emit({ modal = modal, plain = plank(a) })"#);
	let m = &out["modal"];
	assert_eq!(m["board"], false, "no plank over the action");
	assert_eq!(m["fill"], true);
	assert_eq!(rgb(&m["fillColor"]), [1.0, 0.58, 0.251], "the ember accent fills it");
	assert_eq!(rgb(&m["label"]), [0.122, 0.071, 0.039], "dark ink on it (onAccent)");
	assert_eq!(out["plain"]["board"], true, "made plain again: a plank");
	assert_eq!(out["plain"]["fill"], false);
}

#[test]
fn hearth_s_transparent_style_puts_the_board_and_light_away_and_a_switch_to_a_game_look_hides_them_for_its_art() {
	let out = run(r#"
		local GF = Polestar.UI.GuideFrame
		Polestar.Set("ui.skin", "hearth")
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		local F, P = GF.frame, GF.parts
		local k = F.psSkin.kit
		local function state() return { board = k.board:IsShown(), ember = k.ember:IsShown(), mantel = P.nav.TitleBar:IsShown(), border = F.psBorder[1]:IsShown() } end
		local out = { standard = state() }
		Polestar.Set("ui.style", "transparent")
		out.transparent = state()
		Polestar.Set("ui.style", "standard")
		out.back = state()
		Polestar.Set("ui.skin", "forever")
		out.forever = { board = k.board:IsShown(), ember = k.ember:IsShown(), mantel = P.nav.TitleBar:IsShown(), game = T.GameSkin() }
		Polestar.Set("ui.skin", "hearth")
		out.again = state()
		Polestar.Set("ui.skin", "halo")
		out.halo = { board = k.board:IsShown(), ember = k.ember:IsShown(), mantel = P.nav.TitleBar:IsShown() }
		emit(out)"#);
	let lit = json!({ "board": true, "ember": true, "mantel": true, "border": true });
	assert_eq!(out["standard"], lit);
	assert_eq!(out["transparent"], json!({ "board": false, "ember": false, "mantel": false, "border": false }), "transparent: text on the world alone");
	assert_eq!(out["back"], lit, "standard again: the board lit again");
	assert_eq!(out["forever"], json!({ "board": false, "ember": false, "mantel": false, "game": true }), "a game look: Hearth's pieces hidden, its own art in their place");
	assert_eq!(out["again"], lit, "and back");
	assert_eq!(out["halo"], json!({ "board": false, "ember": false, "mantel": false }), "Halo: none of Hearth's pieces");
}

#[test]
fn the_game_looks_keep_their_own_colours_sizes_and_controls_apart_from_hearth() {
	let out = run(r#"
		local function c(name) return { T.Color(name) } end
		local out = {}
		for _, skin in ipairs({ "forever", "blizzard", "classic" }) do
			Polestar.Set("ui.skin", skin)
			out[skin] = { text = c("text"), title = c("title"), success = c("success"), selected = c("selected"), npc = c("npc"),
				row = T.Metric("row", 40), menuRow = T.Metric("menuRow", 26), buttonH = T.Metric("buttonH", 28), checkbox = T.Metric("checkbox", 14),
				foot = T.Metric("guideFoot", 26), hero = { T.FontSpec("hero") }, game = T.GameSkin() }
		end
		emit(out)"#);
	for skin in ["forever", "blizzard", "classic"] {
		let s = &out[skin];
		assert_eq!(rgb(&s["text"]), [1.0, 1.0, 1.0], "{skin}: HIGHLIGHT_FONT_COLOR");
		assert_eq!(rgb(&s["title"]), [1.0, 0.82, 0.0], "{skin}: NORMAL_FONT_COLOR");
		assert_eq!(rgb(&s["success"]), [0.118, 1.0, 0.0], "{skin}: the game's green");
		// Blizzard's is the damage meter's: a white wash, gold left to the titles.
		let wash = if skin == "blizzard" { [1.0, 1.0, 1.0, 0.1] } else { [1.0, 0.82, 0.0, 0.14] };
		assert_eq!(round(&s["selected"]), wash, "{skin}: its own selection wash");
		assert_eq!(rgb(&s["npc"]), [1.0, 1.0, 1.0], "{skin}: NPC names in white, as the game's");
		assert_eq!(s["row"], 28, "{skin}: the Settings panel's rows");
		assert_eq!(s["menuRow"], 22, "{skin}");
		assert_eq!(s["buttonH"], 22, "{skin}");
		assert_eq!(s["checkbox"], 18, "{skin}");
		assert_eq!(s["foot"], 28, "{skin}: room for the 14-high status bar");
		assert_eq!(s["hero"][1], 24, "{skin}: Hero 24");
		assert_eq!(s["game"], true, "{skin}: a game skin");
	}
}

// An empty sidebar row (the guide list's Favourites before any favourite) reads as empty in Hearth, where the muted
// text stands close to the rows' own: its label muted, its glyph the faintest text colour, no count; a row with
// guides keeps the rows' glyph and label colours and its count.
#[test]
fn hearth_s_empty_sidebar_row_reads_as_empty() {
	let out = run(r#"
		Polestar.Set("ui.skin", "hearth")
		Polestar.UI.ShowPicker()
		stub.advance(0.5)
		local function hex(r, g, b) return ("%02x%02x%02x"):format(math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)) end
		local rows = {}
		for _, b in ipairs(PolestarPicker.navButtons) do
			if b:IsShown() and b.psKey then rows[b.psKey] = b end
		end
		local function look(b) return { glyph = hex(b.Icon:GetVertexColor()), label = hex(b.Label:GetTextColor()), count = b.Count:IsShown() } end
		emit({ empty = look(rows.Favorites), full = look(rows.Leveling), off = hex(T.Color("textOff")), muted = hex(T.Color("textMuted")),
			dim = hex(T.Color("textDim")), rest = hex(T.Color("navRest")) })"#);
	assert_ne!(out["off"], out["dim"], "the faintest text colour is not the rows' own: {out}");
	assert_eq!(out["empty"], json!({ "glyph": out["off"].clone(), "label": out["muted"].clone(), "count": false }), "{out}");
	assert_eq!(out["full"], json!({ "glyph": out["dim"].clone(), "label": out["rest"].clone(), "count": true }), "{out}");
}
