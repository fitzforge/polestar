//! The first run: no saved variables at all, a new level-1 character logs in. Install (the frame
//! PolestarWelcome) opens by itself shortly after login; the player clicks Next through every page (the Targeting
//! page whose preview could not paint itself in 0.4.0, #2592) and Finish. No Lua error, nothing in chat, no sound
//! or alert, nothing done for the player; each page opens in bounded work; what was chosen is saved, and the next
//! login keeps it and does not show Install again.

use crate::common::{play, release_or_skip, Play};
use crate::questlog::empty;
use serde_json::Value;

/// Lua: the run's first login. Clicks through Install (choosing the third route style on "Your route" when the
/// page has its style cards) and emits what it saw, and the saved variables after logout.
const FIRST: &str = r#"
local atLogin = Scene.since(Scene.atLogin)
local s = Scene.snap()
-- #2592: a control bound to a setting (Widgets.Bind) paints itself at once, so it needs its Refresh first.
local unpainted = {}
local W = Polestar.Widgets
local bind = W and W.Bind
if bind then
	W.Bind = function(control, path, ...)
		if type(control) == "table" and rawget(control, "Refresh") == nil then unpainted[#unpainted + 1] = tostring(path) end
		return bind(control, path, ...)
	end
end
local wait = Scene.work(function() stub.advance(5) end)
local F = PolestarWelcome
local shown = F ~= nil and F:IsShown()
local pages, picked = {}, nil
if shown then
	for _ = 1, 15 do
		local key, at, count, title = Polestar.UI.Welcome.Page()
		if key == "route" and F.Styles and F.Styles[3] then
			F.Styles[3]:Click()
			picked = Polestar.Get("nav.routeStyle")
		end
		local last = not F.Next:IsShown()
		local button = last and F.Finish or F.Next
		local cost = Scene.work(function() button:Click(); stub.advance(0.2) end)
		pages[#pages + 1] = { key = tostring(key), at = at, count = count, title = tostring(title), click = last and "Finish" or "Next", ms = cost.ms, kb = cost.kb }
		if not F:IsShown() then break end
	end
end
if bind then W.Bind = bind end
stub.advance(3)
local d = Scene.since(s)
stub.fire("PLAYER_LOGOUT")
emit({ shown = shown, open = F ~= nil and F:IsShown(), pages = pages, picked = picked or false, unpainted = unpainted,
	waitMs = wait.ms, loginMs = ScenesQ.loginMs(), loginLines = atLogin.lines,
	lines = d.lines, sounds = d.soundIds, alerts = d.alerts, actions = d.actions,
	account = PolestarDB.welcomeSeen or false, char = PolestarCharDB.welcomeSeen or false,
	saved = ScenesQ.saved({ "PolestarDB", "PolestarCharDB" }) })
"#;

fn new_character(saved: Vec<(String, String)>, script: &str) -> Value {
	play(&Play { stubs: vec!["stub_scenes_quests.lua"], before: "Scene.atLogin = Scene.snap()".into(), saved, script: script.into(), ..Default::default() })
		.into_iter()
		.next()
		.expect("the scene emitted nothing")
}

#[test]
fn a_new_character_gets_install_and_every_page_through_finish_works_2592() {
	let Some(_) = release_or_skip() else { return };
	let out = new_character(vec![], FIRST);
	let saved = out["saved"].as_str().unwrap_or_default().to_string();
	let mut shown = out.clone();
	shown["saved"] = Value::from(format!("{} bytes", saved.len()));
	println!("{}", serde_json::to_string_pretty(&shown).unwrap());
	assert_eq!(out["shown"], true, "Install did not open within 5 s of a new character's first login: {shown}");
	let pages = out["pages"].as_array().cloned().unwrap_or_default();
	let keys: Vec<&str> = pages.iter().filter_map(|p| p["key"].as_str()).collect();
	let count = pages.first().and_then(|p| p["count"].as_u64()).unwrap_or(0) as usize;
	assert!(count >= 5 && pages.len() == count, "clicked through {} of {count} pages ({keys:?}): {shown}", pages.len());
	assert!(keys.contains(&"targeting"), "no Targeting page (#2592's): {keys:?}");
	assert_eq!(pages.last().map(|p| p["click"].clone()), Some(Value::from("Finish")), "the last page ends with Finish: {shown}");
	assert_eq!(out["open"], false, "Install is still open after Finish: {shown}");
	assert!(empty(&out["unpainted"]), "#2592: controls bound before they could paint themselves (a Lua error in game): {}", out["unpainted"]);
	assert!(empty(&out["loginLines"]), "chat lines at a new character's login: {}", out["loginLines"]);
	assert!(empty(&out["lines"]), "chat lines while clicking through Install: {}", out["lines"]);
	assert!(empty(&out["sounds"]), "sounds while clicking through Install: {}", out["sounds"]);
	assert!(empty(&out["alerts"]), "alerts while clicking through Install: {}", out["alerts"]);
	assert!(empty(&out["actions"]), "automatic actions during Install: {}", out["actions"]);
	assert!(
		out["account"].as_u64().is_some_and(|v| v >= 1) && out["char"].as_u64().is_some_and(|v| v >= 1),
		"Install's flags not saved after Finish (account {}, character {})",
		out["account"],
		out["char"]
	);
	let picked = out["picked"].as_str().map(str::to_string);
	if let Some(p) = &picked {
		assert!(saved.contains(&format!("routeStyle=\"{p}\"")), "the route style chosen in Install ({p}) is not in the saved PolestarDB: {saved}");
	}
	for p in &pages {
		let ms = p["ms"].as_f64().unwrap_or(f64::NAN);
		// Each page is built the first time it shows; "Your route" draws its demo map.
		forge_addontest::assert_timing!(ms < PAGE_MS, "Install's page after \"{}\" took {ms:.1} ms to open (budget {PAGE_MS} ms): {shown}", p["title"]);
	}
	let login = out["loginMs"].as_f64().unwrap_or(f64::NAN);
	forge_addontest::assert_timing!(login < LOGIN_MS, "a new character's login took {login:.0} ms (budget {LOGIN_MS} ms)");

	// The next login, with what the first one saved: Install stays closed, the choice is kept.
	let again = new_character(
		vec![("Polestar".into(), saved)],
		"stub.advance(10)\nemit({ open = PolestarWelcome ~= nil and PolestarWelcome:IsShown(), style = Polestar.Get('nav.routeStyle'), lines = Scene.since(Scene.atLogin).lines })",
	);
	assert_eq!(again["open"], false, "Install opened again at the next login: {again}");
	if let Some(p) = picked {
		assert_eq!(again["style"], Value::from(p), "the route style chosen in Install was not kept: {again}");
	}
	assert!(empty(&again["lines"]), "chat lines at the next login: {again}");
}

/// Budgets (CPU ms, quiet machine), about 5x 0.4.1.1's: a page (its slowest, "Your route" with its demo map,
/// 55-80 ms; the others 20 ms); a new character's login, PLAYER_LOGIN through its timers (300 ms).
const PAGE_MS: f64 = 300.0;
const LOGIN_MS: f64 = 1500.0;
