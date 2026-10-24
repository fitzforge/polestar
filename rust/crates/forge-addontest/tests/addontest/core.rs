//! Core plumbing (addon/Polestar/Core/Init.lua): message bus, settings, lifecycle, slash commands.

use forge_addontest::{emitted, fake_locale, Addon, RunAddon};
use serde_json::{json, Value};
use std::collections::BTreeMap;
use std::path::Path;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua"])
}

#[test]
fn a_handler_removed_during_dispatch_does_not_make_the_bus_skip_the_next_one() {
	let out = emitted(&RunAddon {
		addons: vec![core()],
		script: r#"
			local calls = {}
			local a
			a = Polestar.On("X", function() calls[#calls + 1] = "a"; Polestar.Off(a) end)
			Polestar.On("X", function() calls[#calls + 1] = "b" end)
			Polestar.Fire("X")
			Polestar.Fire("X")
			emit(calls)"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!(["a", "b", "b"]));
}

#[test]
fn one_failing_handler_does_not_stop_the_others() {
	let out = emitted(&RunAddon {
		addons: vec![core()],
		script: r#"
			local errors, calls = {}, {}
			geterrorhandler = function() return function(e) errors[#errors + 1] = tostring(e) end end
			Polestar.On("X", function() error("boom") end)
			Polestar.On("X", function(v) calls[#calls + 1] = v end)
			Polestar.Fire("X", 7)
			emit({ errors = #errors, calls = calls })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "errors": 1, "calls": [7] }));
}

#[test]
fn settings_fall_back_to_defaults_store_only_non_default_values_and_announce_changes() {
	let out = emitted(&RunAddon {
		addons: vec![core()],
		script: r#"
			Polestar.RegisterDefaults("ui", { scale = 1, locked = false })
			local seen = {}
			Polestar.On("SETTING_CHANGED", function(p, v) seen[#seen + 1] = p .. "=" .. tostring(v) end)
			local before = Polestar.Get("ui.scale")
			Polestar.Set("ui.scale", 1.25)
			local stored = PolestarDB.settings.ui.scale
			Polestar.Set("ui.scale", 1)
			emit({ before = before, stored = stored, cleared = PolestarDB.settings.ui.scale == nil, now = Polestar.Get("ui.scale"), seen = seen })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "before": 1, "stored": 1.25, "cleared": true, "now": 1, "seen": ["ui.scale=1.25", "ui.scale=1"] }));
}

#[test]
fn settings_survive_savedvariables_coming_back_nil_after_a_cold_restart() {
	let out = emitted(&RunAddon {
		addons: vec![core()],
		script: r#"
			Polestar.RegisterDefaults("nav", { arrow = true })
			Polestar.Set("nav.arrow", false)
			PolestarDB = nil      -- the client failed to restore the file
			PolestarCharDB = nil
			local state = Polestar.CharState()
			emit({ arrow = Polestar.Get("nav.arrow"), manual = type(state.manual), flags = type(state.flags) })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "arrow": true, "manual": "table", "flags": "table" }));
}

#[test]
fn restored_savedvariables_are_used_once_addon_loaded_fires() {
	let out = emitted(&RunAddon {
		addons: vec![core()],
		saved: vec![("Polestar".into(), "PolestarDB = { schema = 1, settings = { ui = { scale = 0.9 } } }".into())],
		script: r#"
			Polestar.RegisterDefaults("ui", { scale = 1 })
			emit(Polestar.Get("ui.scale"))"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], 0.9);
}

#[test]
fn init_and_login_callbacks_run_in_order_and_late_registrations_run_at_once() {
	let out = emitted(&RunAddon {
		before: "__order = {}".into(),
		addons: vec![Addon::files("Polestar", &["Core/Init.lua"])],
		login: true,
		script: r#"
			Polestar.OnLogin(function() __order[#__order + 1] = "late-login" end)
			emit(__order)"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!(["late-login"]));

	let ordered = emitted(&RunAddon {
		before: r#"
			__order = {}
			local realLoad = loadfile
			loadfile = function(path)
				local chunk, err = realLoad(path)
				if not chunk then return nil, err end
				return function(...)
					chunk(...)
					local ns = Polestar
					ns.OnInit(function() __order[#__order + 1] = "init1" end)
					ns.OnLogin(function() __order[#__order + 1] = "login1" end)
					ns.OnInit(function() __order[#__order + 1] = "init2" end)
					ns.OnLogin(function() __order[#__order + 1] = "login2" end)
				end
			end"#
			.into(),
		addons: vec![core()],
		script: r#"
			__order[#__order + 1] = "loaded"
			stub.login()
			emit(__order)"#
			.into(),
		..Default::default()
	});
	assert_eq!(ordered[0], json!(["init1", "init2", "loaded", "login1", "login2"]));
}

#[test]
fn slash_command_bare_toggles_the_frame_names_dispatch_with_the_rest_of_the_line_unknown_prints_help() {
	let out = emitted(&RunAddon {
		addons: vec![core()],
		script: r#"
			local got = {}
			Polestar.On("TOGGLE_FRAME", function() got[#got + 1] = "toggle" end)
			Polestar.RegisterCommand("Goto", function(rest) got[#got + 1] = "goto:" .. rest end, "help text")
			SlashCmdList.POLESTAR("")
			SlashCmdList.POLESTAR("  goto   12 extra  ")
			local before = #stub.messages
			SlashCmdList.POLESTAR("nope")
			local printed = table.concat(stub.messages, "\n", before + 1)
			emit({ got = got, mentionsUnknown = printed:find("nope", 1, true) ~= nil, listsGoto = printed:find("/polestar goto", 1, true) ~= nil })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "got": ["toggle", "goto:12 extra"], "mentionsUnknown": true, "listsGoto": true }));
}

#[test]
fn polestar_help_prints_each_line_in_the_client_language_core_s_own_commands_too() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: fake_locale(
			"itIT",
			&[
				("Commands", "Befehle"),
				("Show the guide window", "Guide-Fenster anzeigen"),
				("Open settings", "Einstellungen öffnen"),
				("Toggle debug output", "Debug-Ausgabe umschalten"),
				("Look at the step before", "Vorherigen Schritt ansehen"),
			],
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"
			SlashCmdList.POLESTAR("help")
			local lines = {}
			for _, m in ipairs(stub.messages) do
				local name, help = m:match("/polestar (%S+)  |cff8a8f98(.*)|r$")
				if name then lines[name] = help end
			end
			emit({ title = stub.messages[1]:find("Befehle", 1, true) ~= nil, show = lines.show, options = lines.options, debug = lines.debug, prev = lines.prev, hide = lines.hide })"#
			.into(),
		..Default::default()
	});
	assert_eq!(
		out[0],
		json!({
			"title": true,
			"show": "Guide-Fenster anzeigen",
			"options": "Einstellungen öffnen",
			"debug": "Debug-Ausgabe umschalten",
			"prev": "Vorherigen Schritt ansehen",
			"hide": "Hide the guide window",
		})
	);
}

#[test]
fn lc_a_word_with_two_meanings_has_a_key_per_meaning_english_while_untranslated() {
	let run = |strings: &[(&str, &str)]| -> Value {
		emitted(&RunAddon {
			before: fake_locale("itIT", strings),
			addons: vec![core()],
			script: r#"emit({ button = Polestar.L["Back"], chest = Polestar.LC("boss", "Chest") })"#.into(),
			..Default::default()
		})
		.remove(0)
	};
	assert_eq!(run(&[("Back", "Indietro"), ("boss: Chest", "Forziere")]), json!({ "button": "Indietro", "chest": "Forziere" }));
	assert_eq!(run(&[("Back", "Indietro")]), json!({ "button": "Indietro", "chest": "Chest" }));
}

#[test]
fn registering_an_event_the_client_does_not_know_returns_false_instead_of_erroring() {
	let out = emitted(&RunAddon {
		addons: vec![core()],
		script: r#"
			local real = stub.Methods.RegisterEvent
			stub.Methods.RegisterEvent = function(self, ev)
				if ev == "NOT_A_FOREVER_EVENT" then error("Attempt to register unknown event") end
				return real(self, ev)
			end
			local ok1 = Polestar.RegisterEvent("NOT_A_FOREVER_EVENT", function() end)
			local hits = 0
			local ok2 = Polestar.RegisterEvent("QUEST_ACCEPTED", function(_, id) hits = hits + id end)
			stub.fire("QUEST_ACCEPTED", 5)
			emit({ ok1 = ok1, ok2 = ok2, hits = hits })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "ok1": false, "ok2": true, "hits": 5 }));
}

#[test]
fn every_slash_command_is_registered_by_exactly_one_module_a_second_registration_would_silently_replace_the_first() {
	let root = forge_addontest::run::addons_dir();
	let re = regex::Regex::new(r#"RegisterCommand\("([^"]+)""#).unwrap();
	let mut seen: BTreeMap<String, Vec<String>> = BTreeMap::new();
	fn walk(dir: &Path, root: &Path, re: &regex::Regex, seen: &mut BTreeMap<String, Vec<String>>) {
		for e in std::fs::read_dir(dir).unwrap() {
			let e = e.unwrap();
			let p = e.path();
			if e.file_type().unwrap().is_dir() {
				walk(&p, root, re, seen);
			} else if e.file_name().to_string_lossy().ends_with(".lua") {
				let text = std::fs::read_to_string(&p).unwrap();
				for m in re.captures_iter(&text) {
					let name = m[1].to_lowercase();
					seen.entry(name).or_default().push(p.strip_prefix(root).unwrap().display().to_string());
				}
			}
		}
	}
	walk(&root, &root, &re, &mut seen);
	let dupes: Vec<String> = seen.iter().filter(|(_, files)| files.len() > 1).map(|(name, files)| format!("{name}: {}", files.join(", "))).collect();
	assert_eq!(dupes, Vec::<String>::new());
}

#[test]
fn formatdistance_yards_or_metres_rounding_kilometres_from_1000_m_and_the_rares_form() {
	let out = emitted(&RunAddon {
		addons: vec![core()],
		script: r#"
			local F = Polestar.FormatDistance
			Polestar.RegisterDefaults("nav", { distanceUnit = "yards" })
			local rares = { round = 5, compact = true }
			local yd = { F(120.4), F(0.6), F(1500), F(83, rares), F(998, rares), F(1500, rares) }
			Polestar.Set("nav.distanceUnit", "metres")
			local m = { F(120.4), F(0.6), F(1093), F(1094), F(1500), F(83, rares), F(1092, rares), F(1500, rares) }
			emit({ yd = yd, m = m })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0]["yd"], json!(["120 yd", "1 yd", "1500 yd", "85 yd", "1000 yd", "1.5k yd"]));
	// 0.9144 m to the yard: 1093 yd = 999.4 m, 1094 yd = 1000.4 m; with rares' rounding 1092 yd = 998.5 m reads 1000 m, so 1.0 km.
	assert_eq!(out[0]["m"], json!(["110 m", "1 m", "999 m", "1.0 km", "1.4 km", "75 m", "1.0 km", "1.4 km"]));
}
