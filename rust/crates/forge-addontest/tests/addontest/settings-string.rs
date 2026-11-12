//! Settings strings (addon/Polestar/Core/SettingsString.lua, #1031): the settings a player changed as one line
//! of text, read back on the Import page (UI/Import.lua) and applied with Undo; over the real Core, Theme and
//! UI, so the Options pages' own controls decide what a string may hold.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const SETUP: &str = r#"
uistub.install()
stub.login()
SS, IV = Polestar.SettingsString, Polestar.UI.Import
function paste(text)
	local box = IV.parts.Box
	box:SetText(text)
	box:GetScript("OnTextChanged")(box, true)
end
-- A friend's changes: a slider, a dropdown, a colour and a toggle on the Options pages (a colour of one's own
-- also turns off matching EllesmereUI's accent, ui.matchAccent), and two settings that are no preference to
-- share (the window shown, the arrow's position).
function changeSome()
	Polestar.Set("ui.upcoming", 4)
	Polestar.Set("ui.combat", "fade")
	Polestar.Set("ui.accent", { 0.2, 0.4, 0.6 })
	Polestar.Set("behavior.offerClassQuests", false)
	Polestar.Set("ui.shown", false)
	Polestar.Set("nav.arrowPos", { point = "TOP", x = 1, y = 2 })
end
function now()
	return { upcoming = Polestar.Get("ui.upcoming"), combat = Polestar.Get("ui.combat"), accent = Polestar.Get("ui.accent"),
		offer = Polestar.Get("behavior.offerClassQuests") }
end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua", "stub_encoding.lua"], addons: vec![Addon::files("Polestar", &FILES)], script: format!("{SETUP}\n{script}"), ..Default::default() })
}

#[test]
fn an_export_holds_only_the_changed_options_settings_and_applies_on_another_install_with_undo() {
	let out = run(r#"
		changeSome()
		local s, n = SS.Export()
		emit({ n = n, raw = Polestar.Import.Unpack(s, "!PSS1!", 32768) })
		-- A friend with every setting at its default.
		Polestar.ResetSettings()
		local info = SS.Read(s)
		local lines = {}
		for _, ch in ipairs(info.changes) do lines[#lines + 1] = ch.label .. ": " .. ch.oldText .. " -> " .. ch.newText end
		emit({ lines = lines, skipped = info.skipped, unchanged = info.unchanged })
		local events, seen = {}, {}
		Polestar.On("SETTING_CHANGED", function(path) if not seen[path] then seen[path] = true events[#events + 1] = path end end)
		local applied = SS.Apply(info)
		table.sort(events)
		emit({ applied = applied, now = now(), undo = SS.CanUndo(), events = events })
		emit({ back = SS.Undo(), now = now(), stored = Polestar.DB().settings.ui and Polestar.DB().settings.ui.upcoming or "none", undo = SS.CanUndo() })
		-- Read again where the settings already match: nothing to change.
		SS.Apply(SS.Read(s))
		local again = SS.Read(s)
		emit({ changes = #again.changes, unchanged = again.unchanged })
	"#);
	assert_eq!(
		out[0],
		json!({ "n": 5, "raw": r#"{"format":1,"settings":{"behavior.offerClassQuests":false,"ui.accent":[0.2,0.4,0.6],"ui.combat":"fade","ui.matchAccent":false,"ui.upcoming":4}}"# }),
		"sorted keys; the window's shown state and the arrow's position stay out"
	);
	assert_eq!(
		out[1],
		json!({
			"lines": ["Accent colour: Default -> |cff336699#336699|r", "In combat: Keep visible -> Fade out", "Match EllesmereUI accent: On -> Off", "Offer class quests: On -> Off", "Upcoming steps: 0 -> 4"],
			"skipped": {},
			"unchanged": 0,
		})
	);
	assert_eq!(
		out[2],
		json!({ "applied": 5, "now": { "upcoming": 4, "combat": "fade", "accent": [0.2, 0.4, 0.6], "offer": false }, "undo": true, "events": ["behavior.offerClassQuests", "ui.accent", "ui.combat", "ui.matchAccent", "ui.upcoming"] })
	);
	assert_eq!(
		out[3],
		json!({ "back": 5, "now": { "upcoming": 0, "combat": "show", "accent": false, "offer": true }, "stored": "none", "undo": false }),
		"Undo puts the defaults back as defaults, not stored copies"
	);
	assert_eq!(out[4], json!({ "changes": 0, "unchanged": 5 }));
}

#[test]
fn a_value_that_does_not_fit_its_control_or_a_key_without_one_is_skipped_and_a_damaged_string_is_refused() {
	let out = run(r#"
		local s = SS.Pack('{"format":1,"settings":{"ui.combat":"hide","ui.upcoming":9,"ui.textSize":"big","ui.instance":"explode",'
			.. '"ui.accent":[2,0,0],"ui.borderColor":[0.1,0.2],"ui.shown":false,"nav.arrowPos":{"point":"TOP"},"ui.madeUp":true,"behavior.skipGrey":1}}')
		local info = SS.Read(s)
		emit({ changes = #info.changes, key = info.changes[1].key, skipped = info.skipped })
		local function why(text) local ok, r = SS.Read(text) return ok and "read" or r end
		local body = s:sub(16)
		emit({
			tampered = why(s:sub(1, 20) .. (s:sub(21, 21) == "A" and "B" or "A") .. s:sub(22)),
			truncated = why(s:sub(1, #s - 8)),
			newer = why("!PSS2!" .. s:sub(7)),
			newerFormat = why(SS.Pack('{"format":2,"settings":{}}')),
			notSettings = why(SS.Pack('{"format":1,"guide":{}}')),
			guide = why("!PS1!00000000!AAAA"),
			wrapped = why(s:sub(1, 30) .. "\n  " .. s:sub(31)),
			long = why("!PSS1!" .. string.rep("A", 20001)),
		})
	"#);
	assert_eq!(
		out[0],
		json!({
			"changes": 1,
			"key": "ui.combat",
			"skipped": ["behavior.skipGrey", "nav.arrowPos", "ui.accent", "ui.borderColor", "ui.instance", "ui.madeUp", "ui.shown", "ui.textSize", "ui.upcoming"],
		}),
		"only the dropdown's own choice goes in"
	);
	let damaged = "This import string is damaged or incomplete. Copy the whole string again.";
	let newer = "This settings string needs a newer Polestar.";
	assert_eq!(
		out[1],
		json!({
			"tampered": damaged,
			"truncated": damaged,
			"newer": newer,
			"newerFormat": newer,
			"notSettings": damaged,
			"guide": "This is not a Polestar import string.",
			"wrapped": "read",
			"long": "This settings string is too long: Polestar reads up to 20000 characters.",
		})
	);
}

#[test]
fn the_import_page_previews_a_settings_string_applies_it_and_offers_undo() {
	let out = run(r#"
		changeSome()
		local s = SS.Export()
		Polestar.ResetSettings()
		IV.Show()
		paste(s)
		local shown = IV.Shown()
		emit({ preview = shown.preview, note = shown.note, button = shown.button, undo = shown.undo, skipped = shown.skipped or false })
		IV.parts.Apply:Click()
		shown = IV.Shown()
		emit({ done = shown.done, preview = shown.preview or false, undo = shown.undo, combat = Polestar.Get("ui.combat") })
		IV.parts.Undo:Click()
		shown = IV.Shown()
		emit({ done = shown.done, undo = shown.undo, combat = Polestar.Get("ui.combat") })
		-- One that matches: nothing to apply. One with a key from elsewhere: named, escaped.
		Polestar.Set("ui.combat", "hide")
		paste(SS.Pack('{"format":1,"settings":{"ui.combat":"hide","|cffff0000x|r":true}}'))
		shown = IV.Shown()
		emit({ preview = shown.preview, note = shown.note, button = shown.button or false, skipped = shown.skipped })
	"#);
	assert_eq!(
		out[0],
		json!({
			"preview": "Polestar settings  ·  5 changes",
			"note": "Accent colour: Default → |cff336699#336699|r\nIn combat: Keep visible → Fade out\nMatch EllesmereUI accent: On → Off\nOffer class quests: On → Off\nUpcoming steps: 0 → 4",
			"button": "Apply",
			"undo": false,
			"skipped": false,
		}),
		"nothing changes before Apply"
	);
	assert_eq!(out[1], json!({ "done": "Applied 5 settings. Undo the last settings import puts them back.", "preview": false, "undo": true, "combat": "fade" }));
	assert_eq!(out[2], json!({ "done": "Put back 5 settings.", "undo": false, "combat": "show" }));
	assert_eq!(
		out[3],
		json!({
			"preview": "Polestar settings  ·  no changes",
			"note": "Your settings already match this string.",
			"button": false,
			"skipped": "Skipped 1 setting this Polestar does not have or cannot take: ||cffff0000x||r.",
		})
	);
}

#[test]
fn options_export_settings_opens_the_copy_window_with_the_string_and_how_many_it_holds() {
	let out = run(r#"
		local shown = {}
		Polestar.UI.ShowCopy = function(title, text, opts) shown[#shown + 1] = { title = title, prefix = text:sub(1, 6), hint = opts.hint, icon = opts.icon } end
		local O = Polestar.UI.Options
		O.ExportSettings()
		Polestar.Set("ui.combat", "fade")
		O.ExportSettings()
		changeSome()
		O.ExportSettings()
		emit(shown)
	"#);
	assert_eq!(
		out[0],
		json!([
			{ "title": "Your Polestar settings", "prefix": "!PSS1!", "icon": "sliders", "hint": "Your settings are all at their defaults, so this string changes nothing. Copy it with Ctrl+C (Cmd+C on a Mac)." },
			{ "title": "Your Polestar settings", "prefix": "!PSS1!", "icon": "sliders", "hint": "1 changed setting. Copy it with Ctrl+C (Cmd+C on a Mac); a friend pastes it on the Import page." },
			{ "title": "Your Polestar settings", "prefix": "!PSS1!", "icon": "sliders", "hint": "5 changed settings. Copy them with Ctrl+C (Cmd+C on a Mac); a friend pastes them on the Import page." },
		])
	);
}

#[test]
fn a_colour_source_the_string_turns_on_lists_the_ones_it_turns_off_and_undo_puts_them_back() {
	let out = run(r#"
		-- A friend with an accent and a border colour of their own (#1069 review).
		Polestar.Set("ui.accent", { 0.2, 0.4, 0.6 })
		Polestar.Set("ui.borderColor", { 0.5, 0.5, 0.5 })
		local s = SS.Export()
		-- Here: Class colour and the accent border on.
		Polestar.ResetSettings()
		Polestar.Set("ui.classAccent", true)
		Polestar.Set("ui.borderAccent", true)
		local function state()
			return { accent = Polestar.Get("ui.accent"), class = Polestar.Get("ui.classAccent"), match = Polestar.Get("ui.matchAccent"),
				border = Polestar.Get("ui.borderColor"), borderAccent = Polestar.Get("ui.borderAccent") }
		end
		local info = SS.Read(s)
		local lines = {}
		for _, ch in ipairs(info.changes) do lines[#lines + 1] = ch.label .. ": " .. ch.oldText .. " -> " .. ch.newText end
		emit({ lines = lines, unchanged = info.unchanged })
		emit({ applied = SS.Apply(info), now = state() })
		emit({ back = SS.Undo(), now = state() })
	"#);
	assert_eq!(
		out[0],
		json!({
			"lines": ["Accent border: On -> Off", "Accent colour: Default -> |cff336699#336699|r", "Border colour: Default -> |cff808080#808080|r", "Class colour: On -> Off"],
			"unchanged": 1,
		}),
		"the sources the friend's colours turn off are in the preview; Match EllesmereUI accent is already off here"
	);
	assert_eq!(out[1], json!({ "applied": 4, "now": { "accent": [0.2, 0.4, 0.6], "class": false, "match": false, "border": [0.5, 0.5, 0.5], "borderAccent": false } }));
	assert_eq!(out[2], json!({ "back": 4, "now": { "accent": false, "class": true, "match": false, "border": false, "borderAccent": true } }), "Class colour and the accent border are back on");
}

#[test]
fn undo_also_puts_back_a_setting_a_listener_changed_during_apply() {
	let out = run(r#"
		-- A listener outside the string's keys: offering class quests off also turns the upcoming steps to 2.
		Polestar.On("SETTING_CHANGED", function(path, value)
			if path == "behavior.offerClassQuests" and value == false then Polestar.Set("ui.upcoming", 2) end
		end)
		local s = SS.Pack('{"format":1,"settings":{"behavior.offerClassQuests":false}}')
		Polestar.Set("ui.upcoming", 5)
		SS.Apply(SS.Read(s))
		local mid = Polestar.Get("ui.upcoming")
		SS.Undo()
		emit({ mid = mid, upcoming = Polestar.Get("ui.upcoming"), offer = Polestar.Get("behavior.offerClassQuests") })
	"#);
	assert_eq!(out[0], json!({ "mid": 2, "upcoming": 5, "offer": true }));
}

#[test]
fn a_string_whose_settings_are_a_list_is_read_with_its_entries_skipped_not_a_lua_error() {
	let out = run(r#"
		local s = SS.Pack('{"format":1,"settings":[true,"ui.combat"]}')
		local ok, info = pcall(SS.Read, s)
		emit({ ok = ok, changes = ok and #info.changes or tostring(info), skipped = ok and info.skipped or false })
		IV.Show()
		local pasted = pcall(paste, s)
		emit({ pasted = pasted, skipped = IV.Shown().skipped or false })
	"#);
	assert_eq!(out[0], json!({ "ok": true, "changes": 0, "skipped": ["1", "2"] }));
	assert_eq!(out[1], json!({ "pasted": true, "skipped": "Skipped 2 settings this Polestar does not have or cannot take: 1, 2." }));
}

#[test]
fn reset_all_settings_drops_undo_and_resetting_one_section_drops_that_section_s() {
	let out = run(r#"
		local s = SS.Pack('{"format":1,"settings":{"ui.combat":"fade","behavior.offerClassQuests":false}}')
		local function keys()
			local u, out = Polestar.DB().settingsUndo, {}
			for k in pairs(u or {}) do out[#out + 1] = k end
			table.sort(out)
			return out
		end
		SS.Apply(SS.Read(s))
		local before = keys()
		Polestar.ResetSettings("ui")
		emit({ before = before, after = keys(), undo = SS.CanUndo() })
		Polestar.ResetSettings()
		IV.Show()
		emit({ undo = SS.CanUndo(), button = IV.Shown().undo, back = SS.Undo(), offer = Polestar.Get("behavior.offerClassQuests") })
	"#);
	assert_eq!(out[0], json!({ "before": ["behavior.offerClassQuests", "ui.combat"], "after": ["behavior.offerClassQuests"], "undo": true }));
	assert_eq!(out[1], json!({ "undo": false, "button": false, "back": 0, "offer": true }), "Undo after the reset would put the import back on top of it");
}
