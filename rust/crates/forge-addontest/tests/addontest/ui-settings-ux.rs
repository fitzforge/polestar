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
-- A shown footer button by its label.
local function footerButton(text)
	for _, side in ipairs({ "left", "right" }) do
		for _, b in ipairs(PolestarOptions.footerButtons[side]) do if b:IsShown() and b.Label:GetText() == text then return b end end
	end
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

// A reset can be taken back once: after a row's right-click, a section's Reset or the page's, a chip in the footer
// says what was reset (in place of the thanks line) with an Undo that puts every setting back as it was; a new
// reset takes its place, it goes by itself after ten seconds, and a row already at its default offers nothing.
#[test]
fn a_reset_offers_one_undo_in_the_footer_for_a_while() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		UI.ShowOptions("guide")
		local w = ctl("ui.launcher")
		w:Click("RightButton")
		local chip = PolestarOptions.UndoChip
		local row = { value = Polestar.Get("ui.launcher"), shown = chip:IsShown(), text = chip.Text:GetText(),
			thanks = PolestarOptions.ThanksLink:IsShown() }
		chip.Undo:Click()
		local undone = { Polestar.Get("ui.launcher"), chip:IsShown() }
		-- Already at its default: nothing to undo.
		ctl("ui.combat"):Click("RightButton")
		local idle = chip:IsShown()
		-- A section's Reset (three settings or fewer: at once).
		Polestar.Set("ui.launcher", false)
		Polestar.Set("ui.combat", "hide")
		Polestar.Set("ui.instance", "show")
		ctl("ui.combat")
		cardOf("Show and hide").Reset:Click()
		local section = { Polestar.Get("ui.combat"), Polestar.Get("ui.instance"), chip.Text:GetText() }
		stub.advance(11)
		local gone = { chip:IsShown(), O.Undo(), Polestar.Get("ui.combat") }
		-- The page's Reset, through its question.
		Polestar.Set("ui.combat", "fade")
		footerButton("Reset page"):Click()
		PolestarModal.Box.Action:Click()
		local page = { Polestar.Get("ui.combat"), chip:IsShown() }
		O.Undo()
		emit({ row = row, undone = undone, idle = idle, section = section, gone = gone, page = page, back = Polestar.Get("ui.combat") })"#);
	assert_eq!(out["row"], json!({ "value": false, "shown": true, "text": "Floating button reset.", "thanks": false }));
	assert_eq!(out["undone"], json!([true, false]), "Undo puts it back and the chip goes");
	assert_eq!(out["idle"], false, "a row at its default: no Undo");
	assert_eq!(out["section"], json!(["show", "hide", "2 settings reset."]), "both back to their defaults");
	assert_eq!(out["gone"], json!([false, false, "show"]), "gone after ten seconds, nothing left to undo");
	assert_eq!(out["page"], json!(["show", true]));
	assert_eq!(out["back"], "fade", "the page's settings back");
}

// A sound list can be heard before a pick: each choice has a speaker that plays it without choosing it, and resting
// the pointer on a choice a moment plays it too (leaving first plays nothing). A list that is no sound has none.
#[test]
fn a_sound_lists_choices_play_from_their_speaker_without_being_picked() {
	let out = run(r#"
		Polestar.Set("rares.enabled", true)
		Polestar.Set("rares.alerts", true)
		Polestar.Set("rares.sound", true)
		Polestar.Set("rares.soundKit", "raid")
		UI.ShowOptions("alerts")
		local row = ctl("rares.soundKit")
		row.Button:Click()
		local rows = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then rows[#rows + 1] = r end end
		local speakers = 0
		for _, r in ipairs(rows) do if rawget(r, "Speaker") and r.Speaker:IsShown() then speakers = speakers + 1 end end
		stub.sounds = {}
		rows[3].Speaker:Click()
		local played = { #stub.sounds, Polestar.Get("rares.soundKit"), PolestarMenu:IsShown() }
		stub.sounds = {}
		stub.RunScript(rows[2], "OnEnter")
		stub.advance(0.7)
		local dwelt = #stub.sounds
		stub.sounds = {}
		stub.RunScript(rows[1], "OnEnter")
		stub.RunScript(rows[1], "OnLeave")
		stub.advance(0.7)
		local left = #stub.sounds
		Polestar.Widgets.HideMenu()
		-- A list of no sounds: no speakers.
		local other = ctl("toasts.headsup.place")
		other.Button:Click()
		local none = 0
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and rawget(r, "Speaker") and r.Speaker:IsShown() then none = none + 1 end end
		emit({ rows = #rows, speakers = speakers, played = played, dwelt = dwelt, left = left, none = none })"#);
	assert_eq!(out["rows"], 3);
	assert_eq!(out["speakers"], 3, "a speaker on each sound");
	assert_eq!(out["played"], json!([1, "raid", true]), "the speaker plays it; the choice stays and the list stays open");
	assert_eq!(out["dwelt"], 1, "resting on a choice plays it");
	assert_eq!(out["left"], 0, "leaving first plays nothing");
	assert_eq!(out["none"], 0, "no speaker on a list of no sounds");
}
