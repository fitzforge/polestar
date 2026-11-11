//! What's new (addon/Polestar/UI/WhatsNew.lua) against the real Core + Theme + UI manifests and the fake Engine of
//! tests/lua/stub_ui.lua: once per account on the first login after an update (PolestarDB.whatsNewSeen older than
//! the newest notes, or missing on an account from before the window), never on a fresh install (the welcome
//! instead), not again once seen; held back in combat, in an instance and while the welcome is up; reopened by
//! /polestar whatsnew; "Open the guide list" opens the guide list on its home view.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// An account that saw the 0.3.6 notes, updated to 0.3.7.
const UPDATED: &str = "PolestarDB = { schema = 1, settings = {}, welcomeSeen = 1, whatsNewSeen = \"0.3.6\" }";
// An account from before the window: no flag at all.
const OLD_ACCOUNT: &str = "PolestarDB = { schema = 1, settings = {}, welcomeSeen = 1 }";
const CHAR_SEEN: &str = "PolestarCharDB = { schema = 1, welcomeSeen = 1 }";

// uistub.install marks the welcome and the notes seen for every other UI test; here the account and the
// character keep what their saved variables (and the addon loading) made of them.
const HEAD: &str = r#"local savedSeen = PolestarDB and PolestarDB.welcomeSeen
local savedChar = PolestarCharDB and PolestarCharDB.welcomeSeen
local savedNew = PolestarDB and PolestarDB.whatsNewSeen
uistub.install()
Polestar.DB().welcomeSeen = savedSeen
Polestar.CharState().welcomeSeen = savedChar
Polestar.DB().whatsNewSeen = savedNew"#;

const TAIL: &str = r#"stub.login()
local WN = Polestar.UI.WhatsNew
function shown() return PolestarWhatsNew ~= nil and PolestarWhatsNew:IsShown() end
function welcome() return PolestarWelcome ~= nil and PolestarWelcome:IsShown() end
function plain(s) return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end"#;

fn run_with(script: &str, saved: Option<String>, before: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		script: format!("{HEAD}\n{before}\n{TAIL}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn updated() -> Option<String> {
	Some(format!("{UPDATED}\n{CHAR_SEEN}"))
}

#[test]
fn after_an_update_it_shows_once_a_few_seconds_after_login_and_got_it_closes_it_for_good() {
	let out = run_with(
		r#"
		local atLogin = shown()
		stub.advance(4)
		local after = shown()
		local title = PolestarWhatsNew.Hero.Title:GetText()
		local flag = PolestarDB.whatsNewSeen
		PolestarWhatsNew.GotIt:Click()
		emit({ atLogin = atLogin, after = after, title = title, flag = flag, closed = not shown(), latest = WN.LATEST,
			welcome = welcome() })"#,
		updated(),
		"",
	);
	assert_eq!(
		out,
		json!({ "atLogin": false, "after": true, "title": "What's new in Polestar 0.3.7", "flag": "0.3.7", "closed": true,
			"latest": "0.3.7", "welcome": false }),
		"opening it marks the account, so a reload or logout with it up does not repeat it"
	);
	// The next login, with what the first one saved.
	let again = run_with(
		"stub.advance(10)\nemit({ shown = shown() })",
		Some(format!("PolestarDB = {{ schema = 1, settings = {{}}, welcomeSeen = 1, whatsNewSeen = \"{}\" }}\n{CHAR_SEEN}", out["flag"].as_str().unwrap())),
		"",
	);
	assert_eq!(again["shown"], false, "not again after Got it");
}

#[test]
fn an_account_from_before_the_window_has_updated_so_it_shows() {
	let out = run_with("stub.advance(4)\nemit({ shown = shown(), flag = PolestarDB.whatsNewSeen })", Some(format!("{OLD_ACCOUNT}\n{CHAR_SEEN}")), "");
	assert_eq!(out, json!({ "shown": true, "flag": "0.3.7" }));
}

#[test]
fn the_newest_notes_are_0_3_7_and_an_account_that_saw_0_3_6_gets_them_at_login() {
	let out = run_with(
		r#"
		local versions = {}
		for i, entry in ipairs(WN.NOTES) do versions[i] = entry.version end
		local atLogin = { shown = shown(), flag = PolestarDB.whatsNewSeen }
		stub.advance(4)
		emit({ versions = versions, latest = WN.LATEST, atLogin = atLogin, shown = shown(),
			title = PolestarWhatsNew.Hero.Title:GetText(), flag = PolestarDB.whatsNewSeen })"#,
		updated(),
		"",
	);
	assert_eq!(out["versions"][0], "0.3.7", "0.3.7's notes come first, the newest: {}", out["versions"]);
	assert_eq!(out["versions"][1], "0.3.6", "0.3.6's stay behind them");
	assert_eq!(out["latest"], "0.3.7");
	assert_eq!(out["atLogin"], json!({ "shown": false, "flag": "0.3.6" }), "not before its few seconds");
	assert_eq!(out["shown"], true, "an account that read 0.3.6's notes gets 0.3.7's at login");
	assert_eq!(out["title"], "What's new in Polestar 0.3.7");
	assert_eq!(out["flag"], "0.3.7", "and is marked as having seen them");
}

#[test]
fn a_fresh_install_gets_the_welcome_not_whats_new_even_after_the_welcome_closes() {
	let out = run_with(
		r#"
		stub.advance(4)
		local during = { welcome = welcome(), shown = shown() }
		PolestarWelcome.Skip:Click()
		stub.advance(10)
		emit({ during = during, after = shown(), flag = PolestarDB.whatsNewSeen })"#,
		None,
		"",
	);
	assert_eq!(out, json!({ "during": { "welcome": true, "shown": false }, "after": false, "flag": "0.3.7" }));
}

#[test]
fn in_combat_it_waits_for_the_fight_to_end() {
	let out = run_with(
		r#"
		stub.advance(4)
		local during = { shown = shown(), flag = PolestarDB.whatsNewSeen }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ during = during, after = shown(), flag = PolestarDB.whatsNewSeen })"#,
		updated(),
		"stub.inCombat = true",
	);
	assert_eq!(out, json!({ "during": { "shown": false, "flag": "0.3.6" }, "after": true, "flag": "0.3.7" }));
}

#[test]
fn a_new_character_on_an_updated_account_gets_the_welcome_first_and_whats_new_once_it_closes() {
	let out = run_with(
		r#"
		stub.advance(4)
		local during = { welcome = welcome(), shown = shown() }
		stub.advance(10)
		local still = shown()
		PolestarWelcome.Skip:Click()
		emit({ during = during, still = still, after = shown(), welcome = welcome() })"#,
		Some(UPDATED.to_string()),
		"",
	);
	assert_eq!(out, json!({ "during": { "welcome": true, "shown": false }, "still": false, "after": true, "welcome": false }));
}

#[test]
fn in_an_instance_or_battleground_it_waits_until_the_player_is_back_in_the_world() {
	let out = run_with(
		r#"
		stub.advance(4)
		local during = shown()
		uistub.instance = nil
		stub.fire("PLAYER_ENTERING_WORLD")
		stub.advance(4)
		emit({ during = during, after = shown() })"#,
		updated(),
		"uistub.instance = \"pvp\"",
	);
	assert_eq!(out, json!({ "during": false, "after": true }));
}

#[test]
fn polestar_whatsnew_and_about_reopen_it_once_seen() {
	let out = run_with(
		r#"
		stub.advance(10)
		local atLogin = shown()
		SlashCmdList.POLESTAR("whatsnew")
		local slash = shown()
		PolestarWhatsNew:Hide()
		Polestar.Fire("SHOW_WHATSNEW")
		emit({ atLogin = atLogin, slash = slash, event = shown() })"#,
		Some(format!("PolestarDB = {{ schema = 1, settings = {{}}, welcomeSeen = 1, whatsNewSeen = \"0.3.7\" }}\n{CHAR_SEEN}")),
		"",
	);
	assert_eq!(out, json!({ "atLogin": false, "slash": true, "event": true }));
}

#[test]
fn open_the_guide_list_closes_it_and_opens_the_guide_list_on_its_home_view_with_suggested_for_you() {
	let out = run_with(
		r#"
		Polestar.UI.Picker.SetView("browse")
		stub.advance(4)
		local before = shown()
		PolestarWhatsNew.GuideList:Click()
		emit({ before = before, closed = not shown(), picker = PolestarPicker ~= nil and PolestarPicker:IsShown(),
			view = Polestar.UI.Picker.View() })"#,
		updated(),
		"",
	);
	assert_eq!(out, json!({ "before": true, "closed": true, "picker": true, "view": "home" }));
}

#[test]
fn it_says_what_changed_in_ten_notes_in_order_and_scrolls_them_within_one_screen() {
	let out = run_with(
		r#"
		WN.Show()
		local F = PolestarWhatsNew
		local notes = {}
		for i, n in ipairs(F.Body.Notes) do
			if n.Head:IsShown() then notes[i] = { head = n.Head:GetText(), text = plain(n.Text:GetText()) } end
		end
		local escape = false
		for _, n in ipairs(UISpecialFrames) do if n == "PolestarWhatsNew" then escape = true end end
		local sf = F.Scroll
		local view, content, barAtTop, top = sf.psView, sf.psContent, sf.Bar:IsShown(), sf:GetVerticalScroll()
		sf:GetScript("OnMouseWheel")(sf, -100)
		local bottom = sf:GetVerticalScroll()
		emit({ notes = notes, site = F.Site:GetText(), gotIt = F.GotIt.Label:GetText(), list = F.GuideList.Label:GetText(),
			escape = escape, height = F:GetHeight(), view = view, content = content, bar = barAtTop, top = top,
			bottom = bottom })"#,
		updated(),
		"",
	);
	assert_eq!(
		out["notes"],
		json!([
			{ "head": "A steadier arrow", "text": "Keeps up on slopes and ledges, takes the faster flight, and no turning back after you land." },
			{ "head": "Smoother indoors", "text": "No more stutter in the Undercity, buildings and caves; less work in the background." },
			{ "head": "Update notice", "text": "At login, a card says when a newer Polestar is out and how to update." },
			{ "head": "New spells", "text": "A level-up card lists what to train; Train All learns it (thanks RikyZ90); Upgrade updates your bars." },
			{ "head": "Quest helpers", "text": "Loot that starts a quest glows on the quest item button; timed quests count down." },
			{ "head": "Hide it all", "text": "A click on the minimap button hides all of Polestar; another brings it back." },
			{ "head": "Browse all steps", "text": "Click the step number to see every step of the guide (thanks TTik3r and aalejandrofer)." },
			{ "head": "Profession guides", "text": "Rebuilt on Forever's trainers, and they start where your skill is." },
			{ "head": "Fully translated", "text": "All of 0.3.7 in 9 languages, with thanks to our translators." },
			{ "head": "Fixes from your reports", "text": "Routes, trainers, dungeons and more. Found something off? Type /polestar report." },
		])
	);
	assert_eq!(out["site"], "Full notes: polestar.guide");
	assert_eq!(out["gotIt"], "Got it");
	assert_eq!(out["list"], "Open the guide list");
	assert_eq!(out["escape"], true, "Escape closes it");
	let h = out["height"].as_f64().unwrap();
	assert!(h > 300.0 && h <= 440.0, "the window keeps its size with five notes; the list scrolls instead: {h}");
	let (view, content) = (out["view"].as_f64().unwrap(), out["content"].as_f64().unwrap());
	assert!(content > view, "ten notes are more than the window holds, so the list scrolls: {content} in {view}");
	assert_eq!(out["bar"], true, "the scroll bar shows");
	assert_eq!(out["top"], 0.0, "it opens at the first note");
	assert_eq!(out["bottom"].as_f64().unwrap(), content - view, "the wheel reaches the last note and stops there");
}
