//! Quick settings (addon/Polestar/UI/QuickSettings.lua): the guide window menu's entry before Options opens a small popover
//! by the menu button with the settings changed mid-play (lock, opacity, arrow, auto-accept, auto turn-in, route
//! lines), each writing its setting; "All settings…" opens the settings window; Escape's list, a click outside and
//! the gamepad's B close it. Core only: against the real Core + Theme + UI manifests and the fake Engine
//! (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!(
			r#"uistub.install()
stub.login()
local GF, UI, W = Polestar.UI.GuideFrame, Polestar.UI, Polestar.Widgets
local QS = UI.QuickSettings
-- Maps/RouteLines.lua registers nav.routeLines in the game; these manifests leave Maps out.
Polestar.RegisterDefaults("nav", {{ routeLines = true }})
local function menuItems()
	local out = {{}}
	for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() then out[#out + 1] = r.Text:GetText() end end
	return out
end
local function menuPick(text)
	GF.menuButton:Click()
	for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == text then r:Click() return r end end
end
{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_menu_s_entry_before_options_opens_the_popover_by_the_button_with_the_mid_play_settings() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local built = PolestarQuickSettings ~= nil
		GF.menuButton:Click()
		local items, first = menuItems(), nil
		for i, t in ipairs(items) do if t == "Options" then first = items[i - 1] end end
		W.HideMenu()
		menuPick("Quick settings")
		local P = PolestarQuickSettings
		local _, rel, relPoint = P:GetPoint(1)
		local keys = {}
		for _, c in ipairs(QS.ROWS) do if QS.Rows()[c.key] then keys[#keys + 1] = c.key end end
		local rows = QS.Rows()
		emit({ built = built, first = first, shown = P:IsShown(), menu = PolestarMenu:IsShown(), anchored = rel == GF.menuButton,
			relPoint = relPoint, width = P:GetWidth(), keys = keys, rowH = rows["ui.locked"]:GetHeight(),
			labels = { rows["ui.locked"].Label:GetText(), rows["ui.opacity"].Label:GetText(), rows["behavior.autoTurnin"].Label:GetText() },
			all = P.All.Label and P.All.Label:GetText() or P.All:GetText() })"#);
	assert_eq!(out["built"], false, "nothing built before first open");
	assert_eq!(out["first"], "Quick settings", "just before Options: the menu's other entries keep their places");
	assert_eq!(out["shown"], true);
	assert_eq!(out["menu"], false, "the menu closes for it");
	assert_eq!(out["anchored"], true, "it opens by the menu button");
	assert_eq!(out["relPoint"], "BOTTOMRIGHT");
	assert_eq!(out["width"], 280);
	assert_eq!(out["keys"], json!(["ui.locked", "ui.opacity", "nav.arrow", "behavior.autoAccept", "behavior.autoTurnin", "nav.routeLines"]));
	assert_eq!(out["rowH"], 32);
	assert_eq!(out["labels"], json!(["Lock window", "Opacity", "Auto turn-in"]));
	assert_eq!(out["all"], "All settings\u{2026}");
}

#[test]
fn its_rows_write_their_settings_and_the_window_follows() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		QS.Show(GF.menuButton)
		local rows = QS.Rows()
		rows["ui.locked"]:Click()
		rows["behavior.autoAccept"]:Click()
		rows["nav.routeLines"]:Click()
		stub.RunScript(rows["ui.opacity"].Slider, "OnValueChanged", 0.6, true)
		emit({ locked = Polestar.Get("ui.locked"), grip = GF.grip:IsShown(), accept = Polestar.Get("behavior.autoAccept"),
			lines = Polestar.Get("nav.routeLines"), opacity = Polestar.Get("ui.opacity"), alpha = PolestarGuideFrame:GetAlpha(),
			turnin = Polestar.Get("behavior.autoTurnin"), arrow = Polestar.Get("nav.arrow") })"#);
	assert_eq!(out["locked"], true);
	assert_eq!(out["grip"], false, "the lock takes the resize grip away at once");
	assert_eq!(out["accept"], false);
	assert_eq!(out["lines"], false);
	assert_eq!(out["opacity"], 0.6);
	assert_eq!(out["alpha"], 0.6, "the guide window fades with it");
	assert_eq!(out["turnin"], true, "untouched settings stay");
	assert_eq!(out["arrow"], true);
}

#[test]
fn all_settings_opens_the_settings_window_and_escape_or_a_click_outside_closes_it() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local asked = {}
		Polestar.On("SHOW_OPTIONS", function(key) asked[#asked + 1] = key or "" end)
		local P = QS.Show(GF.menuButton)
		P.All:Click()
		local afterAll = P:IsShown()
		QS.Show(GF.menuButton)
		local escape = false
		for _, name in ipairs(UISpecialFrames or {}) do if name == "PolestarQuickSettings" then escape = true end end
		P.Catcher:Click()
		local afterOutside = P:IsShown()
		QS.Toggle(GF.menuButton)
		local reopened = P:IsShown()
		QS.Toggle(GF.menuButton)
		emit({ asked = #asked, afterAll = afterAll, escape = escape, afterOutside = afterOutside, reopened = reopened, toggled = P:IsShown() })"#);
	assert_eq!(out["asked"], 1, "All settings… asks for the settings window once");
	assert_eq!(out["afterAll"], false, "and closes the popover");
	assert_eq!(out["escape"], true, "Escape closes it (UISpecialFrames)");
	assert_eq!(out["afterOutside"], false, "a click outside closes it");
	assert_eq!(out["reopened"], true);
	assert_eq!(out["toggled"], false, "the button's second press closes it");
}
