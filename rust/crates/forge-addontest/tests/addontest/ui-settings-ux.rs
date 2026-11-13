//! The settings window's ways around (addon/Polestar_Options/UI/Options.lua and its kit): a setting's Move into
//! Move frames, against the real addon's modules.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const ALL: [&str; 11] = [
	"Core/Core.xml",
	"Theme/Theme.xml",
	"Nav/Nav.xml",
	"Quests/Quests.xml",
	"Gear/Gear.xml",
	"Maps/Maps.xml",
	"QoL/QoL.xml",
	"Lookup/Lookup.xml",
	"Dungeons/Dungeons.xml",
	"UI/UI.xml",
	"Rares/Rares.xml",
];

const HELPERS: &str = r#"
local W, M = Polestar.Widgets, Polestar.Movers
-- A setting's widget wherever its page and tab are: its page opened there.
local function ctl(key)
	for _, c in ipairs(O.AllControls()) do
		if c.key == key then
			O.Select(c.page.key, c.tab or "")
			return O.view.cache[c] or O.view.extras[c], c
		end
	end
end
-- A shown section card by its title.
local function cardOf(name)
	for _, card in ipairs(O.view.cards) do if card:IsShown() and card.Title:GetText() == name then return card end end
end
"#;

// The real addon's modules; the settings window's addon loads before the stub's fake Nav stands in, as in the game.
fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &ALL)],
		script: format!("Polestar.UI.LoadOptions()\nuistub.install()\nstub.login()\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// A setting that places a frame carries a Move: on its row (the floating button) or in its section's header (the
// flight timer's, Look > Trackers). A click hides the window, opens Move frames with that frame's box picked and
// pulsing a few times; Save and exit brings the window back on its page, the row lit. Move is off while the frame
// has no box (its feature off); an alert in the alerts' line picks the line; in a fight nothing opens.
#[test]
fn a_settings_move_opens_move_frames_with_its_frame_picked_and_pulsing_and_brings_the_window_back() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		UI.ShowOptions("guide")
		local w = ctl("ui.launcher")
		local move = rawget(w, "MoveButton")
		local row = { has = move ~= nil, shown = move and move:IsShown() or false, on = move and move:IsEnabled() or false,
			label = move and move.Label:GetText() or false, inCogColumn = rawget(w, "Cog") == move }
		local page = O.page.key
		move:Click()
		local box = M.Box("launcher")
		local during = { settings = PolestarOptions:IsShown(), unlocked = M.IsUnlocked(), selected = M.Selected() or false,
			pulse = box.PulseLayer:IsShown() }
		stub.advance(4)
		local pulsed = not box.PulseLayer:IsShown()
		M.Save()
		local after = { settings = PolestarOptions:IsShown(), page = O.page.key == page, lit = rawget(w, "psFlash") ~= nil and w.psFlash:IsShown() }
		Polestar.Set("ui.launcher", false)
		local off = move:IsEnabled()
		Polestar.Set("ui.launcher", true)
		-- A section's Move, in its header after its switch.
		Polestar.Set("maps.flightTimer", true)
		O.Select("trackers", "Travel")
		local card = cardOf("Flight timer")
		local header = { shown = card.Move:IsShown(), on = card.Move:IsEnabled(), right = select(2, card.Move:GetPoint(1)) == card.Header }
		card.Move:Click()
		local section = { settings = PolestarOptions:IsShown(), selected = M.Selected() or false }
		M.Save()
		-- The alerts lined up: the rare alert's Move picks their line.
		Polestar.Set("toasts.stack", true)
		O.MoveFrame("rareAlert")
		local line = M.Selected() or false
		M.Save()
		-- In a fight: nothing opens, the window stays.
		stub.inCombat = true
		local fought = { O.MoveFrame("launcher"), PolestarOptions:IsShown(), M.IsUnlocked() }
		stub.inCombat = false
		emit({ row = row, during = during, pulsed = pulsed, after = after, off = off, header = header, section = section, line = line, fought = fought })"#);
	assert_eq!(out["row"], json!({ "has": true, "shown": true, "on": true, "label": "Move", "inCogColumn": true }), "the row's Move, in the cog's column");
	assert_eq!(out["during"], json!({ "settings": false, "unlocked": true, "selected": "launcher", "pulse": true }));
	assert_eq!(out["pulsed"], true, "the pulse ends by itself");
	assert_eq!(out["after"], json!({ "settings": true, "page": true, "lit": true }), "the window back on its page, the row lit");
	assert_eq!(out["off"], false, "the floating button off: no box, Move off");
	assert_eq!(out["header"], json!({ "shown": true, "on": true, "right": true }), "the flight timer's section has its Move in the header");
	assert_eq!(out["section"], json!({ "settings": false, "selected": "flightTimer" }));
	assert_eq!(out["line"], "toastLine", "an alert in the line: the line's box");
	assert_eq!(out["fought"], json!([false, true, false]), "in a fight: refused, the window stays");
}
