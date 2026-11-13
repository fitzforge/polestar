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
	assert!(copen["h"].as_f64().unwrap() > 0.0, "{copen}");
	assert_eq!(compact["step"], 1);
	assert_eq!((cclicked["list"].clone(), cclicked["card"].clone()), (json!(false), json!(true)), "{cclicked}");
}

// Browsing swaps the content of the existing window: a long list scrolls inside it, and a short list leaves
// spare space. Neither case changes the height the player was already using (#1835).
fn browser_heights(guide: &str) -> Vec<serde_json::Value> {
	run_guide(
		compile_guide(guide),
		r#"
				stub.login()
				stub.advance(0.5)
				local GF, SL = Polestar.UI.GuideFrame, Polestar.UI.StepList
				for _, compact in ipairs({ false, true }) do
					for _, growUp in ipairs({ false, true }) do
						Polestar.Set("ui.compact", compact)
						Polestar.Set("ui.growUp", growUp)
						stub.advance(0.5)
						local before = GF.frame:GetHeight()
						SL.Toggle(true)
						stub.advance(0.3)
						local opened = GF.frame:GetHeight()
						local sc = SL.scroll
						local content, view, bar = sc.psContent, sc.psView, sc.Bar:IsShown()
						Polestar.Widgets.ScrollTo(sc, content)
						local scrolled = sc:GetVerticalScroll()
						GF.Render()
						stub.advance(0.3)
						local refreshed = GF.frame:GetHeight()
						SL.Toggle(false)
						stub.advance(0.3)
						local closed = GF.frame:GetHeight()
						SL.Toggle(true)
						stub.advance(0.3)
						local reopened = GF.frame:GetHeight()
						SL.Toggle(false)
						stub.advance(0.3)
						emit({ compact = compact, growUp = growUp, before = before, opened = opened, refreshed = refreshed,
							closed = closed, reopened = reopened, content = content, view = view, bar = bar, scrolled = scrolled })
					end
				end"#,
	)
}

#[test]
fn a_long_step_browser_keeps_the_window_height_and_scrolls_in_normal_and_compact_modes() {
	let out = browser_heights(GUIDE);
	assert_eq!(out.len(), 4);
	for state in &out {
		for stage in ["opened", "refreshed", "closed", "reopened"] {
			assert_eq!(state[stage], state["before"], "{stage}: {state}");
		}
		assert!(state["content"].as_f64().unwrap() > state["view"].as_f64().unwrap(), "{state}");
		assert_eq!(state["bar"], true, "{state}");
		assert!(state["scrolled"].as_f64().unwrap() > 0.0, "{state}");
	}
}

#[test]
fn a_one_goal_browser_keeps_a_small_window_height_and_its_card_accessible() {
	let mut guide = GUIDE.split("step Deputy Willem").next().unwrap().to_owned();
	guide.push_str("step Deputy Willem\n  accept 783\n");
	let out = browser_heights(&guide);
	assert_eq!(out.len(), 4);
	for state in &out {
		for stage in ["opened", "refreshed", "closed", "reopened"] {
			assert_eq!(state[stage], state["before"], "{stage}: {state}");
		}
		let view = state["view"].as_f64().unwrap();
		let content = state["content"].as_f64().unwrap();
		assert!(view > 0.0 && view < 120.0, "a small window is not enlarged to the old list minimum: {state}");
		assert_eq!(state["bar"], content > view, "{state}");
		assert_eq!(state["scrolled"].as_f64().unwrap(), (content - view).max(0.0), "the whole card remains reachable: {state}");
	}
}

#[test]
fn a_short_step_browser_keeps_the_window_height_instead_of_shrinking_to_its_cards() {
	let mut guide = GUIDE.split("step Deputy Willem").next().unwrap().to_owned();
	guide.push_str("step A long step\n");
	for i in 1..=18 {
		guide.push_str(&format!("  goto 47.6,35.1 \"Destination {i}\"\n"));
	}
	let out = browser_heights(&guide);
	assert_eq!(out.len(), 4);
	for state in &out {
		for stage in ["opened", "refreshed", "closed", "reopened"] {
			assert_eq!(state[stage], state["before"], "{stage}: {state}");
		}
		assert!(state["content"].as_f64().unwrap() < state["view"].as_f64().unwrap(), "{state}");
		assert_eq!(state["bar"], false, "{state}");
		assert_eq!(state["scrolled"], 0, "{state}");
	}
}

#[test]
fn a_browser_near_the_top_of_the_screen_keeps_the_grow_upward_window_s_minimum_body_height() {
	let out = run_script(
		r#"
				stub.login()
				stub.advance(0.5)
				local GF, SL = Polestar.UI.GuideFrame, Polestar.UI.StepList
				Polestar.Set("ui.growUp", true)
				Polestar.Set("ui.barsBottom", true)
				local top = UIParent:GetTop()
				Polestar.Set("ui.pos", { 1500, top - 120 })
				stub.advance(0.3)
				local before = GF.frame:GetHeight()
				SL.Toggle(true)
				stub.advance(0.3)
				local opened = GF.frame:GetHeight()
				Polestar.Set("ui.pos", { 1500, top - 100 })
				stub.advance(0.3)
				local tighter = GF.frame:GetHeight()
				Polestar.Set("ui.pos", { 1500, top - 120 })
				stub.advance(0.3)
				local back = GF.frame:GetHeight()
				local point, _, _, _, bottom = GF.frame:GetPoint(1)
				SL.Toggle(false)
				stub.advance(0.3)
				emit({ before = before, opened = opened, tighter = tighter, back = back, closed = GF.frame:GetHeight(),
					point = point, bottom = bottom, pinned = top - 120 })"#,
	);
	let state = &out[0];
	assert!(state["before"].as_f64().unwrap() > 120.0, "the window retains its minimum body even with less room: {state}");
	for stage in ["opened", "tighter", "back", "closed"] {
		assert_eq!(state[stage], state["before"], "{stage}: {state}");
	}
	assert_eq!(state["point"], "BOTTOMLEFT", "{state}");
	assert_eq!(state["bottom"], state["pinned"], "the browser keeps the pinned bottom edge: {state}");
}

#[test]
fn opening_the_browser_during_a_goal_fold_keeps_its_height_and_closing_resumes_normal_sizing() {
	let out = run_script(
		r#"
				stub.login()
				stub.advance(0.5)
				local GF, SL = Polestar.UI.GuideFrame, Polestar.UI.StepList
				stub.world.accept(783)
				stub.advance(0.5)
				stub.world.turnIn(783)
				stub.advance(0.8)
				local folding, before = GF.Folding(), GF.frame:GetHeight()
				SL.Toggle(true)
				local heights = { GF.frame:GetHeight() }
				for i = 1, 12 do
					stub.advance(0.05)
					heights[#heights + 1] = GF.frame:GetHeight()
				end
				-- Choosing a different step closes the browser and lets the card fit its new contents.
				local r = SL.rows[3]
				r:GetScript("OnClick")(r)
				stub.advance(0.5)
				local closed, card, step = GF.frame:GetHeight(), GF.parts.card:IsShown(), Polestar.Engine.GetStepIndex()
				SL.Toggle(true)
				stub.advance(0.3)
				emit({ folding = folding, before = before, heights = heights, closed = closed, card = card, step = step,
					reopened = GF.frame:GetHeight() })"#,
	);
	let state = &out[0];
	assert_eq!(state["folding"], true, "the browser opens during an active goal fold: {state}");
	for height in state["heights"].as_array().unwrap() {
		assert_eq!(height, &state["before"], "the hidden card's fold must not resize the browser: {state}");
	}
	assert_eq!(state["card"], true, "{state}");
	assert_eq!(state["step"], 4, "{state}");
	assert_ne!(state["closed"], state["before"], "the selected card resumes fitting its contents: {state}");
	assert_eq!(state["reopened"], state["closed"], "reopening captures the new card's height: {state}");
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
