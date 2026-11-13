//! The step browser (addon/Polestar/UI/StepList.lua), end to end: a guide compiled from DSL, loaded by the real
//! addon (Core, Theme, Nav, UI) and driven in the stub world. A click on the navigator's step number swaps the step
//! card for a scrolling list of every step (the along step, which has no number, is left out). A card names its
//! people and a line per goal as the step card words them, six at most then "+N more", wrapping and growing to fit;
//! done goals and steps are ticked as progress comes in while it is open. The live step is marked; a click on a card
//! looks at that step and closes the list, as do a second click on the step number and Escape. The list is in every
//! look, the compact window too.

use forge_addontest::dsl::{compile_with, fixture_data, write_our_test_pack, TestPack};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::json;

const GUIDE: &str = r#"guide forever/alliance/human/01-northshire
title Northshire Valley
faction Alliance
race Human
levels 1-6
zone Elwynn Forest

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
  accept 7

step Kobolds on the way
  along until back
  kill 6 x10 quest 7.1

step Kobold camp
  goto 47.6,35.1 "Kobold camp"
  note Stay on the road past the old watchtower, then follow the stream north to where the kobolds dig for candles.
  note Pull one at a time.
  note Mind the patrol.
  note Candles drop often.
  note The cave is deeper than it looks.
  note Rest before the cave.
  note Hand in at the abbey.

step Back to the abbey
  label back
  turnin 7
"#;

fn compile_pack() -> TestPack {
	compile_guide(GUIDE)
}

fn compile_guide(guide: &str) -> TestPack {
	let data = fixture_data();
	let r = compile_with(&[("steplist.guide", guide)], &data, None);
	let errors: Vec<String> = r.diag.errors().into_iter().map(forge_guide::diag::format).collect();
	assert_eq!(errors, Vec::<String>::new());
	write_our_test_pack(&r.guides)
}

const BEFORE: &str = r#"
				local w = stub.world
				w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
				w.moveTo(1429, 48.5, 42.5)"#;

const SCRIPT: &str = r#"
				stub.login()
				stub.advance(0.5)
				local GF = Polestar.UI.GuideFrame
				local E = Polestar.Engine
				local SL = Polestar.UI.StepList
				local hit = GF.parts.nav.Steps.Hit
				local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
				local function listed() return SL.frame ~= nil and SL.frame:IsShown() end
				local function snap(tag)
					local cards, marked, viewed = {}, {}, {}
					for i = 1, SL.n do
						local r = SL.rows[i]
						local lines, icons, coloured, wrapped = {}, {}, false, false
						for j = 1, r.psN do
							local fs = r.G[j].Text
							local t = fs:GetText()
							lines[j] = plain(t)
							coloured = coloured or t:find("|c", 1, true) ~= nil
							icons[j] = r.G[j].Icon:GetTexture() == Polestar.Theme.Media("check") and "tick" or "verb"
							if fs:GetStringHeight() > fs:GetLineHeight() * 1.5 then wrapped = true end
						end
						cards[#cards + 1] = { step = r.psIndex, tab = plain(r.Tab:GetText()), lines = lines, icons = icons, coloured = coloured,
							more = r.More:IsShown() and r.More:GetText() or false, wrapped = wrapped, h = r:GetHeight(), done = r.Tick:IsShown(),
							live = r.Live:IsShown() }
						if r.Mark:IsShown() then marked[#marked + 1] = r.psIndex end
						if r.View:IsShown() then viewed[#viewed + 1] = r.psIndex end
					end
					emit({ tag = tag, list = listed(), card = GF.parts.card:IsShown(), on = SL.On(), step = E.GetStepIndex(),
						cards = cards, marked = marked, viewed = viewed })
				end
				local function click() hit:GetScript("OnMouseUp")(hit, "LeftButton"); stub.advance(0.3) end
				snap("closed")
				click()
				snap("open")
				-- Progress while it is open: the first step done, the second half done.
				stub.world.accept(783)
				stub.advance(0.5)
				stub.world.turnIn(783)
				stub.advance(0.5)
				snap("progress")
				local r = SL.rows[2]
				r:GetScript("OnClick")(r)
				stub.advance(0.3)
				snap("clicked")
				-- Every look: the list in place of the card, and the card back once it closes.
				for _, skin in ipairs({ "polestar", "hearth", "forever", "blizzard", "classic", "halo" }) do
					Polestar.Set("ui.skin", skin)
					stub.advance(0.3)
					click()
					local o = { skin = skin, list = listed(), card = GF.parts.card:IsShown(), n = SL.n }
					click()
					o.after = { list = listed(), card = GF.parts.card:IsShown() }
					emit(o)
				end
				Polestar.Set("ui.skin", "polestar")
				stub.advance(0.3)
				-- Escape hides the list: it closes.
				click()
				local esc = { on = listed() }
				SL.frame:Hide()
				stub.advance(0.3)
				esc.after = { on = listed(), open = SL.On(), card = GF.parts.card:IsShown() }
				emit({ escape = esc })
				-- The compact window keeps the list: every step, a click looks at one and closes it.
				Polestar.Set("ui.compact", true)
				stub.advance(0.3)
				click()
				local function compactSnap() return { list = listed(), card = GF.parts.card:IsShown(), n = SL.n,
					first = SL.n > 0 and SL.rows[1]:IsShown() and plain(SL.rows[1].Tab:GetText()) or false, h = SL.frame:GetHeight() } end
				local open = compactSnap()
				local c = SL.rows[1]
				c:GetScript("OnClick")(c)
				stub.advance(0.3)
				emit({ compact = true, open = open, clicked = compactSnap(), step = E.GetStepIndex() })"#;

fn run_script(script: &str) -> Vec<serde_json::Value> {
	run_guide(compile_pack(), script)
}

fn run_guide(pack: TestPack, script: &str) -> Vec<serde_json::Value> {
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: BEFORE.into(), addons: vec![Addon::name("Polestar")], script: "\n\t\t\t\t".to_string() + &loads + script, ..Default::default() })
}

#[test]
fn the_step_number_opens_every_step_in_place_of_the_card_marks_the_live_one_and_a_click_looks_at_a_step_in_every_look() {
	let out = run_script(SCRIPT);
	let (closed, open, progress, clicked) = (&out[0], &out[1], &out[2], &out[3]);

	// Closed: the card, no list built yet.
	assert_eq!((closed["card"].clone(), closed["list"].clone(), closed["on"].clone()), (json!(true), json!(false), json!(false)), "{closed}");

	// Open: every step but the along one (no number), in order, headed with its number; the live step marked.
	assert_eq!((open["list"].clone(), open["card"].clone(), open["on"].clone()), (json!(true), json!(false), json!(true)), "{open}");
	let steps: Vec<_> = open["cards"].as_array().unwrap().iter().map(|c| c["step"].clone()).collect();
	assert_eq!(steps, vec![json!(1), json!(2), json!(4), json!(5)]);
	let tabs: Vec<_> = open["cards"].as_array().unwrap().iter().map(|c| c["tab"].clone()).collect();
	assert_eq!(tabs, vec![json!("1 \u{b7} Deputy Willem"), json!("2 \u{b7} Marshal McBride"), json!("3 \u{b7} Kobold camp"), json!("4 \u{b7} Back to the abbey")]);
	// Each card: its people ("Talk to …", the name in the NPC colour) and a line per goal as the card words it.
	let lines: Vec<_> = open["cards"].as_array().unwrap().iter().map(|c| c["lines"].clone()).collect();
	assert_eq!(lines[0], json!(["Talk to Deputy Willem", "Accept \u{201c}A Threat Within\u{201d}"]));
	assert_eq!(lines[1], json!(["Talk to Marshal McBride", "Turn in \u{201c}A Threat Within\u{201d}", "Accept \u{201c}Kobold Camp Cleanup\u{201d}"]));
	assert_eq!(open["cards"][0]["coloured"], true);
	assert_eq!(open["cards"][0]["icons"], json!(["verb", "verb"]));
	assert_eq!(open["cards"][0]["live"], true);
	// Past six lines the rest is one "+N more"; a long line wraps and its card grows to fit.
	let camp = &open["cards"][2];
	assert_eq!(camp["lines"].as_array().unwrap().len(), 6);
	assert_eq!(camp["lines"][0], "Go to Kobold camp");
	assert_eq!(camp["more"], "+2 more");
	assert_eq!(camp["wrapped"], true);
	assert!(camp["h"].as_f64().unwrap() > open["cards"][1]["h"].as_f64().unwrap() + 3.0 * 14.0, "{}", camp["h"]);
	assert!(open["cards"][1]["h"].as_f64().unwrap() > open["cards"][0]["h"].as_f64().unwrap());
	assert_eq!(open["marked"], json!([1]));
	assert_eq!(open["viewed"], json!([1]));

	// Progress while open: a finished step (not the one looked at) is one muted line, its number, title and tick, no
	// goals; in the live one the done goal is ticked.
	let (first, second) = (&progress["cards"][0], &progress["cards"][1]);
	assert_eq!((first["done"].clone(), first["coloured"].clone(), first["h"].clone()), (json!(true), json!(false), json!(20)), "{first}");
	assert_eq!(first["tab"], "1 \u{b7} Deputy Willem");
	assert_eq!(first["lines"].as_array().map_or_else(|| first["lines"].as_object().map_or(0, |o| o.len()), |a| a.len()), 0, "{first}");
	assert_eq!((second["done"].clone(), second["icons"].clone(), second["live"].clone()), (json!(false), json!(["verb", "tick", "verb"]), json!(true)));
	assert_eq!(progress["marked"], json!([2]));

	// A click looks at that step and closes the list.
	assert_eq!(clicked["step"], 2);
	assert_eq!((clicked["list"].clone(), clicked["card"].clone(), clicked["on"].clone()), (json!(false), json!(true), json!(false)), "{clicked}");

	// Every look: the step number opens the list in place of the card, and a second click brings the card back.
	for (i, skin) in ["polestar", "hearth", "forever", "blizzard", "classic", "halo"].iter().enumerate() {
		let o = &out[4 + i];
		assert_eq!(o["skin"], *skin);
		assert_eq!((o["list"].clone(), o["card"].clone(), o["n"].clone()), (json!(true), json!(false), json!(4)), "{skin}: {o}");
		assert_eq!((o["after"]["list"].clone(), o["after"]["card"].clone()), (json!(false), json!(true)), "{skin}: {o}");
	}

	// Escape (the game hides the frame) closes it.
	let esc = &out[10]["escape"];
	assert_eq!(esc["on"], true, "{esc}");
	assert_eq!(esc["after"], json!({ "on": false, "open": false, "card": true }), "{esc}");

	// Compact: the list too, every step; a click looks at one and closes it.
	let compact = &out[11];
	let (copen, cclicked) = (&compact["open"], &compact["clicked"]);
	assert_eq!((copen["list"].clone(), copen["card"].clone()), (json!(true), json!(false)), "{copen}");
	assert_eq!((copen["n"].clone(), copen["first"].clone()), (json!(4), json!("1 \u{b7} Deputy Willem")), "{copen}");
	assert!(copen["h"].as_f64().unwrap() >= 120.0, "{copen}");
	assert_eq!(compact["step"], 1);
	assert_eq!((cclicked["list"].clone(), cclicked["card"].clone()), (json!(false), json!(true)), "{cclicked}");
}

/// Only the player's own close closes the list. When the window hides (Alt-Z, combat, the setting), the client runs
/// the list's OnHide while the list itself stays shown: it stays open and comes back with the window.
#[test]
fn the_step_list_comes_back_with_the_window_a_hide_of_the_window_is_not_a_close() {
	let out = run_script(
		r#"
				stub.login()
				stub.advance(0.5)
				local GF = Polestar.UI.GuideFrame
				local SL = Polestar.UI.StepList
				SL.Toggle(true)
				stub.advance(0.3)
				local open = SL.frame:IsShown()
				-- The window hides: the client runs the shown list's OnHide with it (the stub's Hide does not cascade).
				GF.frame:Hide()
				SL.frame:GetScript("OnHide")(SL.frame)
				-- Still open, but its own frame hidden too: Escape is not spent on a list nobody sees.
				local hidden = { on = SL.On(), shown = SL.frame:IsShown() }
				-- Drawn again while the window is hidden (progress in combat): it stays hidden.
				GF.Render()
				hidden.drawn = SL.frame:IsShown()
				GF.frame:Show()
				stub.advance(0.3)
				emit({ open = open, hidden = hidden, back = SL.frame:IsShown() and SL.frame:IsVisible() })"#,
	);
	assert_eq!(out[0], json!({ "open": true, "hidden": { "on": true, "shown": false, "drawn": false }, "back": true }), "{}", out[0]);
}

// The guide ends or another one opens with the list open: the list closes, and the next guide opens on its card.
#[test]
fn the_step_list_closes_when_the_guide_goes_and_the_next_guide_opens_on_its_card() {
	let out = run_script(
		r#"
				stub.login()
				stub.advance(0.5)
				local GF = Polestar.UI.GuideFrame
				local E = Polestar.Engine
				local SL = Polestar.UI.StepList
				local id = E.GetGuide().id
				SL.Toggle(true)
				stub.advance(0.3)
				local open = SL.On()
				E.SetGuide(nil)
				stub.advance(0.3)
				local gone = SL.On()
				E.SetGuide(id)
				stub.advance(0.5)
				emit({ open = open, gone = gone, back = SL.On(), list = SL.frame:IsShown(), card = GF.parts.card:IsShown() })"#,
	);
	assert_eq!(out[0], json!({ "open": true, "gone": false, "back": false, "list": false, "card": true }), "{}", out[0]);
}

// A profession guide's skill ranges head their cards (#1713's `section`): the first card under each range carries
// the heading, the range the player's skill is in in the accent colour, the passed one muted.
const SECTIONS: &str = r#"guide forever/professions/first-aid-list
title First Aid 1-75
category Professions
levels 1-60
zone Elwynn Forest

section First Aid 1-40

step Learn First Aid
  train First Aid Apprentice

step Linen Bandage
  craft 3275 until 40

section First Aid 40-75

step Heavy Linen Bandage
  learn 3276

step Heavy Linen Bandage (40-75)
  craft 3276 until 75
"#;

#[test]
fn a_profession_guide_s_skill_ranges_head_their_cards_the_current_one_in_the_accent() {
	let out = run_guide(
		compile_guide(SECTIONS),
		r#"
				stub.world.learnSkill(129, "First Aid", 45, 75)
				stub.login()
				stub.advance(0.5)
				local E = Polestar.Engine
				local SL = Polestar.UI.StepList
				E.SetGuide("forever/professions/first-aid-list")
				stub.advance(0.5)
				SL.Toggle(true)
				stub.advance(0.3)
				local heads = {}
				for i = 1, SL.n do
					local r = SL.rows[i]
					heads[#heads + 1] = { step = r.psIndex, head = r.Head:IsShown() and r.Head:GetText() or false,
						state = r.psHead and r.psHead.state or false, above = r.Head:IsShown() and select(2, r.Head:GetPoint(1)) == r or false }
				end
				emit({ n = SL.n, heads = heads })"#,
	);
	assert_eq!(
		out[0]["heads"],
		json!([
			{ "step": 1, "head": "First Aid 1-40", "state": "done", "above": true },
			{ "step": 2, "head": false, "state": false, "above": false },
			{ "step": 3, "head": "First Aid 40-75", "state": "current", "above": true },
			{ "step": 4, "head": false, "state": false, "above": false },
		]),
		"{}",
		out[0]
	);
}

const SKIPS: &str = r#"guide forever/alliance/human/02-skips
title Skips
faction Alliance
race Human
levels 1-6
zone Elwynn Forest

step Marshal McBride
  accept 7

step Deputy Willem
  when !turnedin 783
  accept 783

step For Mages only
  only Mage
  when level>=50
  goto 47.0,40.0 "Mage trainer"

step Marshal McBride again
  when !turnedin 783
  turnin 783

step Not yet
  when level>=50
  goto 48.0,42.0 "Northshire Abbey"

step Kobold camp
  kill 6 x10 quest 7.1

step Late catch-up
  when !turnedin 783
  goto 48.0,42.0 "Northshire Abbey"

step Back to the abbey
  turnin 7

step Last catch-up
  when !turnedin 783
  goto 48.0,42.0 "Northshire Abbey"
"#;

/// Login (with A Threat Within handed in when `done`), load the guide, define `snap(tag)`: the open list's
/// cards (number/title tab, step, lines, a run card's steps and summary, the section head).
fn skips_prelude(done: bool) -> String {
	prelude(SKIPS_ID, if done { "stub.world.complete({ 783 })" } else { "" })
}

const SKIPS_ID: &str = "forever/alliance/human/02-skips";

/// Login after `setup`, load guide `id`, define `snap(tag)` (see skips_prelude).
fn prelude(id: &str, setup: &str) -> String {
	format!(
		r#"
				{}
				stub.login()
				stub.advance(0.5)
				local E = Polestar.Engine
				local SL = Polestar.UI.StepList
				E.SetGuide("{}")
				stub.advance(0.5)
				local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
				local function snap(tag)
					local cards = {{}}
					for i = 1, SL.n do
						local r = SL.rows[i]
						local lines = {{}}
						for j = 1, r.psN do lines[j] = plain(r.G[j].Text:GetText()) end
						cards[i] = {{ step = r.psIndex or false, tab = plain(r.Tab:GetText()), lines = lines,
							run = r.psRun and r.psRun.steps or false, summary = r.psSummary or false,
							head = r.Head:IsShown() and plain(r.Head:GetText()) or false,
							more = r.More:IsShown() and r.More:GetText() or false, h = r:GetHeight(), shown = r:IsShown() }}
					end
					emit({{ tag = tag, n = SL.n, cards = cards }})
				end"#,
		setup, id
	)
}

fn tabs(o: &serde_json::Value) -> Vec<serde_json::Value> {
	o["cards"].as_array().unwrap().iter().map(|c| c["tab"].clone()).collect()
}

const DONE_TABS: [&str; 6] =
	["1 \u{b7} Marshal McBride", "2\u{2013}4 \u{b7} Skipped for you", "5 \u{b7} Kobold camp", "6 \u{b7} Skipped for you", "7 \u{b7} Back to the abbey", "8 \u{b7} Skipped for you"];

#[test]
fn steps_that_keep_their_number_but_do_not_apply_share_one_card_per_run_that_says_why() {
	// #1940: a player who handed in A Threat Within in an earlier guide opens this one; the catch-up steps for it
	// (`when !turnedin 783`) keep their numbers but do not apply. The list used to jump from 1 to 5 with no word.
	let out = run_guide(
		compile_guide(SKIPS),
		&(skips_prelude(true)
			+ r#"
				SL.Toggle(true)
				stub.advance(0.3)
				snap("open")
				-- A click on a run's card does nothing: there is no one step to look at.
				local before = E.GetStepIndex()
				local r = SL.rows[2]
				r:GetScript("OnClick")(r)
				stub.advance(0.3)
				emit({ tag = "clicked", open = SL.frame:IsShown(), same = E.GetStepIndex() == before })
				-- Every look and the compact window draw the same cards.
				for _, skin in ipairs({ "hearth", "forever", "blizzard", "classic", "halo", "polestar" }) do
					Polestar.Set("ui.skin", skin)
					stub.advance(0.3)
					SL.Toggle(true)
					stub.advance(0.3)
					snap(skin)
				end
				Polestar.Set("ui.compact", true)
				stub.advance(0.3)
				SL.Toggle(true)
				stub.advance(0.3)
				snap("compact")"#),
	);
	let open = &out[0];
	let want: Vec<serde_json::Value> = DONE_TABS.iter().map(|t| json!(t)).collect();
	assert_eq!(tabs(open), want, "{open}");
	// A run: no step of its own, a line per distinct reason in order, its steps (not the one hidden for this
	// character, which has no number) for the hover, and how many.
	let run = &open["cards"][1];
	assert_eq!(run["step"], false, "{run}");
	assert_eq!(run["lines"], json!(["Only before \u{201c}A Threat Within\u{201d} is handed in", "Only from level 50"]), "{run}");
	assert_eq!(run["run"], json!(["2 \u{b7} Deputy Willem", "3 \u{b7} Marshal McBride again", "4 \u{b7} Not yet"]), "{run}");
	assert_eq!(run["summary"], "These 3 steps do not apply to you now", "{run}");
	// A one-step run, and the guide's last steps as a run at the end.
	let one = &open["cards"][3];
	assert_eq!((one["run"].clone(), one["summary"].clone()), (json!(["6 \u{b7} Late catch-up"]), json!("This step does not apply to you now")), "{one}");
	assert_eq!(open["cards"][5]["run"], json!(["8 \u{b7} Last catch-up"]), "{open}");
	let steps: Vec<_> = open["cards"].as_array().unwrap().iter().map(|c| c["step"].clone()).collect();
	assert_eq!(steps, vec![json!(1), json!(false), json!(6), json!(false), json!(8), json!(false)]);
	assert_eq!((out[1]["open"].clone(), out[1]["same"].clone()), (json!(true), json!(true)), "{}", out[1]);
	for o in &out[2..] {
		assert_eq!(tabs(o), want, "{}: {o}", o["tag"]);
		let (run, one) = (&o["cards"][1], &o["cards"][3]);
		assert_eq!((run["shown"].clone(), run["lines"].as_array().map_or(0, |a| a.len())), (json!(true), 2), "{}: {run}", o["tag"]);
		assert!(run["h"].as_f64().unwrap() > one["h"].as_f64().unwrap(), "{}: two reasons are taller than one: {o}", o["tag"]);
	}
}

#[test]
fn a_step_that_does_not_apply_and_says_no_why_ends_the_run() {
	// A step `na` with no reason (Own.gone) has no card, as before; the runs on either side are separate cards, so
	// a card's numbers never name a step it does not list.
	let out = run_guide(
		compile_guide(SKIPS),
		&(skips_prelude(true)
			+ r#"
				local view = E.GetStepView
				E.GetStepView = function(i)
					local v = view(i)
					if v and v.title == "Marshal McBride again" then v.why = nil end
					return v
				end
				SL.Toggle(true)
				stub.advance(0.3)
				snap("open")"#),
	);
	let o = &out[0];
	assert_eq!(&tabs(o)[..3], &[json!("1 \u{b7} Marshal McBride"), json!("2 \u{b7} Skipped for you"), json!("4 \u{b7} Skipped for you")], "{o}");
	assert_eq!((o["cards"][1]["run"].clone(), o["cards"][2]["run"].clone()), (json!(["2 \u{b7} Deputy Willem"]), json!(["4 \u{b7} Not yet"])), "{o}");
}

#[test]
fn the_open_list_follows_a_later_step_whose_when_starts_holding() {
	// The list is open on the character with A Threat Within handed in; reaching level 50 makes "Not yet" apply,
	// which changes neither the step on screen, the live step nor the steps done: its card leaves the run at once.
	let out = run_guide(
		compile_guide(SKIPS),
		&(skips_prelude(true)
			+ r#"
				SL.Toggle(true)
				stub.advance(0.3)
				snap("before")
				local at, live, done = E.GetStepIndex(), E.GetLiveStep(), E.GetProgress()
				stub.world.setLevel(50)
				stub.advance(0.5)
				emit({ tag = "moved", at = E.GetStepIndex() ~= at, live = E.GetLiveStep() ~= live, done = E.GetProgress() ~= done })
				snap("after")"#),
	);
	let want: Vec<serde_json::Value> = DONE_TABS.iter().map(|t| json!(t)).collect();
	assert_eq!(tabs(&out[0]), want, "{}", out[0]);
	assert_eq!(out[1], json!({ "tag": "moved", "at": false, "live": false, "done": false }));
	assert_eq!(
		tabs(&out[2]),
		vec![
			json!("1 \u{b7} Marshal McBride"),
			json!("2\u{2013}3 \u{b7} Skipped for you"),
			json!("4 \u{b7} Not yet"),
			json!("5 \u{b7} Kobold camp"),
			json!("6 \u{b7} Skipped for you"),
			json!("7 \u{b7} Back to the abbey"),
			json!("8 \u{b7} Skipped for you"),
		],
		"{}",
		out[2]
	);
}

#[test]
fn a_character_every_step_applies_to_sees_each_as_its_own_card() {
	// Behaviour unchanged (passes on next too): at level 50 with A Threat Within not handed in, every step this
	// character can see applies and is its own card; the step hidden for it (index 3, `only Mage`) has none.
	let out = run_guide(
		compile_guide(SKIPS),
		&(prelude(SKIPS_ID, "stub.world.level = 50")
			+ r#"
				SL.Toggle(true)
				stub.advance(0.3)
				snap("open")"#),
	);
	let steps: Vec<_> = out[0]["cards"].as_array().unwrap().iter().map(|c| c["step"].clone()).collect();
	assert_eq!(steps, vec![json!(1), json!(2), json!(4), json!(5), json!(6), json!(7), json!(8), json!(9)], "{}", out[0]);
}

const SWAP: &str = r#"guide forever/alliance/human/03-swap
title Swap
faction Alliance
race Human
levels 1-12
zone Elwynn Forest

step Deputy Willem
  accept 783

step Under ten
  when level<10
  goto 48.0,42.0 "Northshire Abbey"

step Ten and up
  when level>=10
  goto 47.0,40.0 "Northshire Vineyards"

step Marshal McBride
  turnin 783
"#;

#[test]
fn the_open_list_follows_one_step_starting_to_apply_as_another_stops() {
	// Level 10 turns "Under ten" off and "Ten and up" on in one go: the steps done, their total, the step on screen
	// and the live step stay as they were, and the cards still trade places.
	let out = run_guide(
		compile_guide(SWAP),
		&(prelude("forever/alliance/human/03-swap", "stub.world.level = 5")
			+ r#"
				SL.Toggle(true)
				stub.advance(0.3)
				snap("before")
				local d0, t0 = E.GetProgress()
				local at, live = E.GetStepIndex(), E.GetLiveStep()
				stub.world.setLevel(10)
				stub.advance(0.5)
				local d1, t1 = E.GetProgress()
				emit({ tag = "moved", at = E.GetStepIndex() ~= at, live = E.GetLiveStep() ~= live, done = d1 ~= d0, total = t1 ~= t0 })
				snap("after")"#),
	);
	assert_eq!(tabs(&out[0]), vec![json!("1 \u{b7} Deputy Willem"), json!("2 \u{b7} Under ten"), json!("3 \u{b7} Skipped for you"), json!("4 \u{b7} Marshal McBride")], "{}", out[0]);
	assert_eq!(out[1], json!({ "tag": "moved", "at": false, "live": false, "done": false, "total": false }));
	assert_eq!(tabs(&out[2]), vec![json!("1 \u{b7} Deputy Willem"), json!("2 \u{b7} Skipped for you"), json!("3 \u{b7} Ten and up"), json!("4 \u{b7} Marshal McBride")], "{}", out[2]);
	assert_eq!(out[2]["cards"][1]["lines"], json!(["Only below level 10"]), "{}", out[2]);
}

const CAPS: &str = r#"guide forever/alliance/human/04-caps
title Caps
faction Alliance
race Human
levels 1-60
zone Elwynn Forest

step Deputy Willem
  accept 783

step At 50
  when level>=50
  goto 48.0,42.0 "Northshire Abbey"

step At 51
  when level>=51
  goto 48.0,42.0 "Northshire Abbey"

step At 52
  when level>=52
  goto 48.0,42.0 "Northshire Abbey"

step At 53
  when level>=53
  goto 48.0,42.0 "Northshire Abbey"

step At 54
  when level>=54
  goto 48.0,42.0 "Northshire Abbey"

step At 55
  when level>=55
  goto 48.0,42.0 "Northshire Abbey"

step At 56
  when level>=56
  goto 48.0,42.0 "Northshire Abbey"

step Marshal McBride
  turnin 783
"#;

#[test]
fn a_run_with_more_reasons_than_a_card_holds_lists_six_then_more() {
	let out = run_guide(
		compile_guide(CAPS),
		&(prelude("forever/alliance/human/04-caps", "")
			+ r#"
				SL.Toggle(true)
				stub.advance(0.3)
				snap("open")"#),
	);
	let run = &out[0]["cards"][1];
	assert_eq!(run["tab"], "2\u{2013}8 \u{b7} Skipped for you", "{run}");
	let lines: Vec<String> = (50..56).map(|n| format!("Only from level {n}")).collect();
	assert_eq!(run["lines"], json!(lines), "{run}");
	assert_eq!(run["more"], "+1 more", "{run}");
}

const SECTION_SKIPS: &str = r#"guide forever/professions/first-aid-skips
title First Aid 1-75
category Professions
levels 1-60
zone Elwynn Forest

section First Aid 1-40

step Learn First Aid
  train First Aid Apprentice

step Later
  when level>=50
  goto 48.0,42.0 "Northshire Abbey"

section First Aid 40-75

step Heavy Linen Bandage
  learn 3276
"#;

#[test]
fn a_run_before_a_skill_range_leaves_the_range_s_head_on_its_first_shown_step() {
	let out = run_guide(
		compile_guide(SECTION_SKIPS),
		&(prelude("forever/professions/first-aid-skips", r#"stub.world.learnSkill(129, "First Aid", 45, 75)"#)
			+ r#"
				SL.Toggle(true)
				stub.advance(0.3)
				snap("open")"#),
	);
	let cards = out[0]["cards"].as_array().unwrap();
	let heads: Vec<_> = cards.iter().map(|c| (c["tab"].clone(), c["head"].clone())).collect();
	assert_eq!(
		heads,
		vec![(json!("1 \u{b7} Learn First Aid"), json!("First Aid 1-40")), (json!("2 \u{b7} Skipped for you"), json!(false)), (json!("3 \u{b7} Heavy Linen Bandage"), json!("First Aid 40-75")),],
		"{}",
		out[0]
	);
}

#[test]
fn a_step_s_gate_is_nil_when_it_applies_0_when_not_for_this_character_else_its_first_failing_when() {
	// Engine.StepGate, which the list's redraw signature reads for every step: step 3 is `only Mage` with a `when`
	// that fails too (0, not the predicate), step 5's only predicate fails (1).
	let out = run_guide(
		compile_guide(SKIPS),
		&(skips_prelude(true)
			+ r#"
				local g = {}
				for i = 1, 9 do g[i] = E.StepGate(i) or false end
				emit({ gates = g })"#),
	);
	assert_eq!(out[0]["gates"], json!([false, 1, 0, 1, 1, false, 1, false, 1]), "{}", out[0]);
}

#[test]
fn a_run_card_s_reasons_follow_names_that_arrive_while_the_list_is_open() {
	// A quest's localized name can arrive after the list is drawn (Names: one redraw per burst, Names.revision);
	// nothing else moves, and the run card's reason still takes the new name.
	let out = run_guide(
		compile_guide(SKIPS),
		&(skips_prelude(true)
			+ r#"
				SL.Toggle(true)
				stub.advance(0.3)
				snap("before")
				local view = E.GetStepView
				E.GetStepView = function(i)
					local v = view(i)
					if v and v.why then v.why = v.why:gsub("A Threat Within", "Une menace interne") end
					return v
				end
				-- What Names' redraw does for a burst of arrivals: the revision, then STEP_UPDATED.
				Polestar.Names.revision = Polestar.Names.revision + 1
				Polestar.Fire("STEP_UPDATED", E.GetStepIndex())
				stub.advance(0.3)
				snap("after")"#),
	);
	assert_eq!(out[0]["cards"][1]["lines"][0], "Only before \u{201c}A Threat Within\u{201d} is handed in", "{}", out[0]);
	assert_eq!(out[1]["cards"][1]["lines"][0], "Only before \u{201c}Une menace interne\u{201d} is handed in", "{}", out[1]);
}
