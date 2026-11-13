//! The settings window's Buttons page (addon/Polestar_Options/QoL/ButtonsOptions.lua) and the looks it sets: the
//! action buttons' sizes, spacing, layout, backing, border, text, opacity and glow (QoL/Buttons.lua), the
//! floating button (UI/Launcher.lua) and the minimap button (Maps/MinimapButton.lua). The secure buttons
//! move and size only out of combat; the previews draw the same faces on plain frames, never a secure one.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const QOL_FILES: [&str; 4] = ["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"];

const MODS: [&str; 10] =
	["Core/Core.xml", "Theme/Theme.xml", "Quests/Quests.xml", "Gear/Gear.xml", "Maps/Maps.xml", "QoL/QoL.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml", "UI/UI.xml", "Rares/Rares.xml"];

const QOL_PRELUDE: &str = r#"
local q = stub.qol
local QoL = Polestar.QoL
local B = QoL.Buttons
local item, hearth, target, rare = PolestarQuestItemButton, PolestarHearthButton, PolestarTargetButton, PolestarRareButton
local function pt(b) local _, _, _, x, y = b:GetPoint(1); return { x, y } end
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
"#;

/// The live action buttons, with the QoL stubs (secure frames refuse protected calls in combat).
fn run_qol(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_qol.lua"], addons: vec![Addon::files("Polestar", &QOL_FILES)], login: true, script: format!("{QOL_PRELUDE}{script}"), ..Default::default() }).remove(0)
}

/// Every module with a button on the page, and the options window.
fn run_ui(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &MODS)],
		script: format!("uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\nlocal UI, O, B = Polestar.UI, Polestar.UI.Options, Polestar.QoL.Buttons\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn n(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

/// An empty Lua list (it emits as `{}`).
fn empty(v: &Value) -> bool {
	v.as_array().is_some_and(|a| a.is_empty()) || v.as_object().is_some_and(|o| o.is_empty())
}

// Sizes, spacing and the row layout move the live buttons out of combat; backing, border, texts, font size and
// outline, small icons, opacity in and out of combat and the glow repaint them.
#[test]
fn buttons_look_settings_apply_to_the_live_action_buttons_out_of_combat() {
	let out = run_qol(
		r#"
		local r = {}
		r.before = { item:GetWidth(), pt(hearth), pt(target) }
		Polestar.Set("buttons.itemSize", 48)
		Polestar.Set("buttons.spacing", 4)
		Polestar.Set("buttons.layout", "row")
		r.row = { item:GetWidth(), target:GetWidth(), pt(hearth), pt(target), pt(rare) }
		Polestar.Set("buttons.layout", "rowReverse")
		r.reverse = { pt(hearth), pt(target) }

		Polestar.Set("buttons.backing", "none")
		r.bgNone = item.Bg:IsShown()
		Polestar.Set("buttons.backing", "panel")
		Polestar.Set("buttons.backingColor", { 0.2, 0.4, 0.6, 0.5 })
		r.bg = rgba(item.Bg)
		Polestar.Set("buttons.borderColor", { 1, 0, 0 })
		r.border = rgba(item.psBorder[1])
		Polestar.Set("buttons.border", false)
		r.borderOff = rgba(item.psBorder[1])[4]
		Polestar.Set("buttons.hotkey", false)
		Polestar.Set("buttons.count", false)
		Polestar.Set("buttons.cooldownText", false)
		r.texts = { item.Hotkey:IsShown(), item.Count:IsShown(), item.Cooldown.noCooldownCount or false }

		-- The single button's name (beside the target list the rows show the names).
		Polestar.Set("qol.targetSimple", true)
		q.step({ { t = "kill", target = "Murloc" }, { t = "kill", target = "Gnoll" } })
		local _, s0 = target.Label:GetFont()
		Polestar.Set("buttons.labelScale", 1.5)
		local _, s1 = target.Label:GetFont()
		Polestar.Set("buttons.labelOutline", "thick")
		local _, _, flags = target.Label:GetFont()
		Polestar.Set("buttons.miniSize", 20)
		r.text = { s1 / s0, flags, target.Label:GetText(), target.Minis[1]:GetWidth() }

		Polestar.Set("buttons.idleAlpha", 0.4)
		Polestar.Set("buttons.alpha", 0.8)
		r.alpha = { item:GetAlpha() }
		q.combat(true)
		r.alpha[2] = item:GetAlpha()
		q.combat(false)
		r.alpha[3] = item:GetAlpha()
		item:GetScript("OnEnter")(item)
		r.alpha[4] = item:GetAlpha()
		item:GetScript("OnLeave")(item)

		q.items[900] = { name = "Torch" }
		q.addItem(0, 1, 900, 2)
		q.step({ { t = "use", item = 900, quest = 7 } })
		r.glowOff = item.psGlow ~= nil and item.psGlow:IsShown()
		Polestar.Set("buttons.glow", true)
		r.glowOn = item.psGlow ~= nil and item.psGlow:IsShown()
		emit(r)"#,
	);
	assert_eq!(out["before"], json!([36, [0, 44], [0, -44]]), "the 0.3.6 column out of the box");
	// 48/2 + 4 + 36/2 = 46 from the quest item button; the rare 36/2 + 4 + 36/2 further.
	assert_eq!(out["row"], json!([48, 36, [-46, 0], [46, 0], [86, 0]]));
	assert_eq!(out["reverse"], json!([[46, 0], [-46, 0]]));
	assert_eq!(out["bgNone"], false, "no backing: the icon alone");
	assert_eq!(out["bg"], json!([0.2, 0.4, 0.6, 0.5]));
	assert_eq!(out["border"], json!([1, 0, 0, 1]));
	assert_eq!(out["borderOff"], 0);
	assert_eq!(out["texts"], json!([false, false, true]), "key, count and cooldown numbers off");
	let text = &out["text"];
	assert!((n(&text[0]) - 1.5).abs() < 0.1, "the name at 150%: {}", text[0]);
	assert_eq!(text[1], "THICKOUTLINE");
	assert_eq!(text[2], "Murloc");
	assert_eq!(text[3], 20, "the small icons at their size");
	assert_eq!(out["alpha"], json!([0.4, 0.8, 0.4, 1]), "out of combat, in combat, after, under the mouse");
	assert_eq!(out["glowOff"], false);
	assert_eq!(out["glowOn"], true, "the quest item in the bags and in range glows");
}

// In a fight the size, layout and scale wait for PLAYER_REGEN_ENABLED (no protected call: SetSize is refused
// on a secure frame then, as SetPoint and SetScale are), while the backing repaints at once.
#[test]
fn buttons_sizes_and_layout_wait_out_combat_the_look_changes_at_once() {
	let out = run_qol(
		r#"
		local M = stub.Methods
		local setSize = M.SetSize
		M.SetSize = function(self, ...)
			if self.secure and stub.inCombat then error("protected call in combat: " .. tostring(self.name) .. ":SetSize", 2) end
			return setSize(self, ...)
		end
		q.step({ { t = "kill", target = "Murloc" } })
		q.combat(true)
		Polestar.Set("buttons.targetSize", 50)
		Polestar.Set("buttons.layout", "row")
		Polestar.Set("qol.buttonScale", 1.2)
		Polestar.Set("buttons.backing", "dark")
		local scrim = { Polestar.Theme.Color("scrim") }
		local r = { fight = { target:GetWidth(), pt(target), target:GetScale(), QoL.HasQueued("place") } }
		local bg = rgba(target.Bg)
		r.darkAtOnce = bg[1] == scrim[1] and bg[2] == scrim[2] and bg[3] == scrim[3]
		q.combat(false)
		r.after = { target:GetWidth(), pt(target), target:GetScale(), QoL.HasQueued("place") }
		emit(r)"#,
	);
	assert_eq!(out["fight"], json!([36, [0, -44], 1, true]), "nothing protected moved in the fight");
	assert_eq!(out["darkAtOnce"], true);
	// 36/2 + 8 + 50/2 = 51 to the right of the quest item button.
	assert_eq!(out["after"], json!([50, [51, 0], 1.2, false]));
}

// The page: key "buttons", order 25 in the look group, laid out on the v2 grid (FIXES-V2): one section per
// element, every section at least two rows, at most one switch and one swatch beside a control, each button's
// and the floating and minimap buttons' on/off beside their size, secondary knobs behind cogs, short labels, at
// most two (i), nothing dimmed at defaults. The old button looks moved here from Questing, which keeps the
// toggles and a way to the page. Every row (extras and cog rows too) has help and search words, every new one
// the new mark, and every key a default (else the window would leave the row out).
#[test]
fn buttons_page_registers_every_button_look_with_defaults_new_badges_search_and_help() {
	let out = run_ui(
		r#"
		local r = { keys = {}, missing = {}, bare = {}, questing = {}, sections = {}, long = {}, info = 0, toggles = 0, extras = {}, more = {},
			thin = {}, crowded = {}, dim = {} }
		local function see(c)
			if not c.key then return end
			r.keys[#r.keys + 1] = c.key
			if Polestar.GetDefault(c.key) == nil then r.missing[#r.missing + 1] = c.key end
			local fresh = c.key:find("^buttons%.") or c.key:find("^ui%.launcher.") or c.key:find("^maps%.minimapButton.")
			if not (c.search and c.search ~= "" and c.help and c.help ~= "") or (fresh and c.new ~= "0.3.8") then r.bare[#r.bare + 1] = c.key end
		end
		-- The deep tabs' registrations (Essentials stands for their rows: settings-essentials.rs).
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.page == "Buttons" and spec.tab ~= "Essentials" then
				if spec.key then r.head = { spec.key, spec.order, spec.group } end
				r.sections[#r.sections + 1] = spec.section
				if spec.toggle then r.toggles = r.toggles + 1 end
				local halves = 0
				for _, c in ipairs(spec.controls) do
					see(c)
					halves = halves + (c.wide and 2 or 1)
					if c.info then r.info = r.info + 1 end
					if c.disabled and c.disabled() then r.dim[#r.dim + 1] = c.key or c.label end
					local label = type(c.label) == "string" and c.label or ""
					local _, words = label:gsub("%S+", "")
					if words > 3 then r.long[#r.long + 1] = label end
					local switches, swatches = 0, 0
					for _, x in ipairs(c.extras or {}) do
						see(x)
						r.extras[c.key] = x.key
						if x.kind == "toggle" then switches = switches + 1 elseif x.kind == "color" then swatches = swatches + 1 end
					end
					if switches > 1 or swatches > 1 then r.crowded[#r.crowded + 1] = c.key end
					for _, x in ipairs(c.more or {}) do see(x); r.more[c.key] = x.key end
				end
				if halves < 3 then r.thin[#r.thin + 1] = spec.section end
			end
		end
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.page == "Questing" and spec.tab == "Buttons" then
				for _, c in ipairs(spec.controls) do r.questing[#r.questing + 1] = c.key or c.label end
			end
		end
		UI.ShowOptions("buttons")
		O.Select("buttons", "Action buttons")
		local shown = O.Controls("buttons", "Action buttons")
		r.shown = { shown["qol.buttonScale"] ~= nil, shown["buttons.targetSize"] ~= nil, shown["buttons.backing"] ~= nil, shown["buttons.glow"] ~= nil }
		O.Select("buttons", "Launcher & minimap")
		local other = O.Controls("buttons", "Launcher & minimap")
		r.other = { other["ui.launcherSize"] ~= nil, other["maps.minimapButtonIcon"] ~= nil }
		-- The switch beside the floating button's size turns it on.
		other["ui.launcher"]:Click()
		r.launcherOn = Polestar.Get("ui.launcher")
		-- An inline switch beside a size row, and a cog's popup.
		O.Select("buttons", "Action buttons")
		shown = O.Controls("buttons", "Action buttons")
		shown["qol.itemButton"]:Click()
		r.itemOff = Polestar.Get("qol.itemButton")
		shown["buttons.border"].Cog:Click()
		r.cog = O.MoreControls()["buttons.borderSize"] ~= nil
		emit(r)"#,
	);
	assert_eq!(out["head"], json!(["buttons", 25, "look"]));
	assert!(empty(&out["missing"]), "every key has a default: {}", out["missing"]);
	assert!(empty(&out["bare"]), "every row: help and search words, new ones the new mark: {}", out["bare"]);
	assert!(empty(&out["long"]), "short labels: {}", out["long"]);
	assert!(n(&out["info"]) <= 2.0, "at most two (i): {}", out["info"]);
	assert!(empty(&out["thin"]), "no one-row section: {}", out["thin"]);
	assert!(empty(&out["crowded"]), "at most one switch and one swatch beside a control: {}", out["crowded"]);
	assert!(empty(&out["dim"]), "nothing dimmed at defaults: {}", out["dim"]);
	assert_eq!(out["sections"], json!(["Button set", "Buttons", "Plate", "Text", "Floating & minimap"]), "one section per element");
	assert_eq!(out["toggles"], 0, "the on/off switches sit beside their sizes");
	for (main, extra) in [
		("buttons.itemSize", "qol.itemButton"),
		("buttons.hearthSize", "qol.hearthButton"),
		("buttons.targetSize", "qol.targetButton"),
		("buttons.rareSize", "qol.rareButton"),
		("buttons.backing", "buttons.backingColor"),
		("buttons.border", "buttons.borderColor"),
		("buttons.glow", "buttons.glowColor"),
		("ui.launcherSize", "ui.launcher"),
		("maps.minimapButtonSize", "maps.minimapButton"),
	] {
		assert_eq!(out["extras"][main], extra, "{extra} beside {main}");
	}
	for (main, cog) in [("buttons.border", "buttons.borderSize"), ("buttons.labelScale", "buttons.labelOutline"), ("qol.targetPlate", "buttons.miniSize"), ("buttons.hotkey", "buttons.hotkeyScale")] {
		assert_eq!(out["more"][main], cog, "{cog} behind {main}'s cog");
	}
	let keys: Vec<&str> = out["keys"].as_array().unwrap().iter().map(|k| k.as_str().unwrap()).collect();
	for k in [
		"qol.buttonScale",
		"qol.buttonTextSide",
		"qol.targetPlate",
		"qol.itemButton",
		"qol.hearthButton",
		"qol.targetButton",
		"qol.rareButton",
		"ui.launcher",
		"maps.minimapButton",
		"buttons.itemSize",
		"buttons.hearthSize",
		"buttons.targetSize",
		"buttons.rareSize",
		"buttons.bagSize",
		"buttons.spacing",
		"buttons.layout",
		"buttons.padding",
		"buttons.backing",
		"buttons.backingColor",
		"buttons.border",
		"buttons.borderColor",
		"buttons.borderSize",
		"buttons.hoverColor",
		"buttons.labelScale",
		"buttons.labelOutline",
		"buttons.miniSize",
		"buttons.hotkey",
		"buttons.hotkeyScale",
		"buttons.count",
		"buttons.cooldownText",
		"buttons.idleAlpha",
		"buttons.alpha",
		"buttons.glow",
		"buttons.glowColor",
		"ui.launcherSize",
		"ui.launcherAlpha",
		"ui.launcherIcon",
		"ui.launcherBack",
		"maps.minimapButtonSize",
		"maps.minimapButtonIcon",
	] {
		assert!(keys.contains(&k), "{k} on the Buttons page");
	}
	let questing = out["questing"].as_array().unwrap();
	assert!(!questing.contains(&json!("qol.buttonScale")) && !questing.contains(&json!("qol.buttonTextSide")), "looks left Questing: {questing:?}");
	assert!(questing.contains(&json!("qol.targetButton")) && questing.contains(&json!("Button look")), "{questing:?}");
	assert_eq!(out["shown"], json!([true, true, true, true]));
	assert_eq!(out["other"], json!([true, true]));
	assert_eq!(out["launcherOn"], true, "the switch beside the floating button's size sets ui.launcher");
	assert_eq!(out["itemOff"], false, "the switch beside Quest item size turns the button off");
	assert_eq!(out["cog"], true, "the border's cog opens its thickness");
}

// The previews draw the real faces with the current values on plain frames: no secure template is ever made,
// they follow the settings as they change, and the live buttons are none of theirs (no floating button exists
// for them).
#[test]
fn buttons_previews_draw_the_real_faces_on_plain_frames_and_make_no_secure_frame() {
	let out = run_ui(
		r#"
		local made, create = {}, CreateFrame
		CreateFrame = function(kind, name, parent, template, ...)
			made[#made + 1] = template or "none"
			return create(kind, name, parent, template, ...)
		end
		local f = B.ActionPreview(UIParent)
		local height = f:Layout(640)
		local faces, combat = f.Faces()
		local l = B.LauncherPreview(UIParent)
		l:Layout(640)
		local launcher, minimap = l.Faces()
		local r = { height = height, secure = {} }
		for _, t in ipairs(made) do if tostring(t):find("Secure") then r.secure[#r.secure + 1] = t end end
		r.made = #made
		r.faces = { faces.hearth.psKind, faces.item.psKind, faces.target.psKind, combat.psKind, faces.item.psLive or false, faces.item:GetName() or "plain" }
		r.target = { faces.target.Label:GetText(), faces.target.Minis[1]:IsShown() }
		Polestar.Set("buttons.itemSize", 50)
		Polestar.Set("buttons.backing", "none")
		Polestar.Set("buttons.idleAlpha", 0.5)
		Polestar.Set("buttons.alpha", 0.3)
		r.follow = { faces.item:GetWidth(), faces.item.Bg:IsShown(), faces.item:GetParent():GetAlpha(), combat:GetParent():GetAlpha() }
		Polestar.Set("ui.launcherSize", 48)
		Polestar.Set("ui.launcherIcon", "white")
		Polestar.Set("maps.minimapButtonIcon", "accent")
		Polestar.Set("maps.minimapButtonSize", 40)
		r.launcher = { launcher:GetWidth(), launcher.Icon:GetTexture(), minimap.Icon:GetTexture(), minimap:GetWidth(), PolestarLauncher == nil }
		CreateFrame = create
		-- Each part of the previews is a hotspot to its row; a click jumps there without an error.
		r.hot = {}
		for _, p in ipairs({ f, l }) do
			for key in pairs(p.psHotspots or {}) do r.hot[#r.hot + 1] = key end
		end
		table.sort(r.hot)
		UI.ShowOptions("buttons")
		local btn = f.psHotspots["buttons.itemSize"]
		btn:GetScript("OnClick")(btn)
		emit(r)"#,
	);
	assert!(empty(&out["secure"]), "no secure template in a preview: {}", out["secure"]);
	assert!(n(&out["height"]) > 0.0);
	assert!(n(&out["made"]) >= 6.0, "the previews made their own frames: {}", out["made"]);
	assert_eq!(out["faces"], json!(["hearth", "item", "target", "item", false, "plain"]));
	assert_eq!(out["target"], json!(["Rot Hide Mongrel", true]), "the target face with its name and the next names' icons");
	assert_eq!(out["follow"], json!([50, false, 0.5, 0.3]), "size, backing and both opacities follow");
	let l = &out["launcher"];
	assert_eq!(l[0], 48);
	assert!(l[1].as_str().unwrap().ends_with("emblem") && l[2].as_str().unwrap().ends_with("emblem"), "{l}");
	assert_eq!(l[3], 40);
	assert_eq!(l[4], true, "the preview never builds the live floating button");
	assert_eq!(
		out["hot"],
		json!(["buttons.alpha", "buttons.hearthSize", "buttons.itemSize", "buttons.targetSize", "maps.minimapButtonSize", "qol.buttonTextSide", "ui.launcherSize"]),
		"every part of the previews leads to its row"
	);
}

// The Action buttons preview draws the target list where the screen has it (#1704): beside the target face, the
// Polestar mark in its place and the rows (Buttons.NewListFaces: plain frames, drawn by the live rows' code), the
// first one close in green, the rare button moved clear of them; in a row (buttons.layout) under it. Simple target
// button brings back the single face.
#[test]
fn buttons_preview_draws_the_target_list_beside_the_target_face_and_the_single_face_with_simple_target_button() {
	let out = run_ui(
		r#"
		local f = B.ActionPreview(UIParent)
		f:Layout(640)
		local faces = f.Faces()
		local list = f.List()
		local r1 = list.rows[1]
		local r = {}
		r.list = { faces.target:IsShown(), list.mark:IsShown(), r1:IsShown(), r1.Name:GetText(), r1.Count:GetText(), r1.Near:IsShown(),
			list.rows[3].Name:GetText(), select(2, r1:GetPoint(1)) == faces.target, r1:GetName() or "plain" }
		r.rare = select(5, faces.rare:GetPoint(1))
		Polestar.Set("buttons.layout", "row")
		f:Layout(640)
		r.row = { (r1:GetPoint(1)), (select(3, r1:GetPoint(1))), (select(4, faces.rare:GetPoint(1))) }
		Polestar.Set("buttons.layout", "column")
		Polestar.Set("qol.targetSimple", true)
		f:Layout(640)
		r.simple = { faces.target:IsShown(), list.mark:IsShown(), r1:IsShown(), faces.target.Label:GetText() }
		emit(r)"#,
	);
	assert_eq!(out["list"], json!([false, true, true, "Rot Hide Mongrel", "3/8", true, "Executor Zygand", true, "plain"]), "the mark and the rows in the target face's place, the first one close");
	assert_eq!(out["rare"], -146, "the rare button clear of three rows, as on the screen");
	assert_eq!(out["row"], json!(["TOPLEFT", "BOTTOMLEFT", 232]), "in a row the rows hang under the target face, the rare button past them");
	assert_eq!(out["simple"], json!([true, false, false, "Rot Hide Mongrel"]), "Simple target button: the single face again");
}

// Move frames' box for the quest buttons covers the target list's rows while they show (Buttons.ListRows,
// Buttons.ListRect), as the set's screen clamp does: wider by the rows beside the target button, back once they go.
#[test]
fn move_frames_box_for_the_quest_buttons_covers_the_target_list_s_rows_while_they_show() {
	let out = run_ui(
		r#"
		local M = Polestar.Movers
		local function size() local _, _, w, h = M.Rect("buttons"); return { math.floor(w + 0.5), math.floor(h + 0.5) } end
		local view, raw = nil, nil
		Polestar.QoL.CurrentStep = function() return view, raw end
		local before = size()
		raw = { { t = "kill", target = "Kobold Vermin" }, { t = "kill", target = "Kobold Worker" } }
		view = { index = 1, status = "current", goals = {} }
		for i, g in ipairs(raw) do view.goals[i] = { index = i, t = g.t, status = "active", subject = g.target } end
		B.Refresh()
		stub.runTimers()
		local rows = B.ListRows()
		local with = size()
		emit({ before = before, rows = rows, with = with })"#,
	);
	assert_eq!(out["rows"], 2);
	let d = |i: usize| out["with"][i].as_f64().unwrap() - out["before"][i].as_f64().unwrap();
	// Two rows (30 + 2 + 30) beside the target button add the 8 spacing and their 180 to the column's right; they
	// end 62 under its top (-26), so the rare button goes to -88 - 8 - 18 = -114, its foot 26 under its slot's.
	assert_eq!(d(0), 188.0, "{out}");
	assert_eq!(d(1), 26.0, "{out}");
}
