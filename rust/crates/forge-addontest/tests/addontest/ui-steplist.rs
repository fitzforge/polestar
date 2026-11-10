//! The guide window's step list, end to end: a guide compiled from DSL, loaded by the real addon (Core, Theme,
//! Nav, UI) and driven in the stub world. The navigator's list button swaps the step card for a scrolling list
//! of every step (the along step, which has no number, is left out). A card names its people and a line per goal
//! as the step card words them, six at most then "+N more", wrapping and growing to fit; done goals and steps are
//! ticked as progress comes in while it is open. The live step is marked; a click on a card looks at that step
//! and closes the list. The list is in every look, the compact window too. The step card's dress (its own ground,
//! the 18px goal rows; no tab, the navigator numbers the step) belongs to the house look: the other looks keep the
//! plain card and 24px rows, transparent drops the ground.

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
	let data = fixture_data();
	let r = compile_with(&[("steplist.guide", GUIDE)], &data, None);
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
				local SL = GF.stepList
				local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
				-- The step card's dress: its ground and the first goal row's height.
				local function dress()
					local row
					for _, r in ipairs(GF.rows) do if r:IsShown() and r.psStatus ~= "done" and r.psStatus ~= "skipped" then row = r:GetHeight() break end end
					return { ground = GF.parts.card.Ground:IsShown(), row = row }
				end
				local function snap(tag)
					local cards, marked, viewed = {}, {}, {}
					for i = 1, SL.n do
						local r = SL.rows[i]
						local lines, coloured = {}, false
				for j = 1, r.psN do
					local t = r.G[j].Text:GetText()
					lines[j] = plain(t)
					coloured = coloured or t:find("|c", 1, true) ~= nil
				end
				local icons = {}
				for j = 1, r.psN do icons[j] = r.G[j].Icon:GetTexture() == Polestar.Theme.Media("check") and "tick" or "verb" end
				local wrapped = false
				for j = 1, r.psN do
					local t = r.G[j].Text
					if t:GetStringHeight() > t:GetLineHeight() * 1.5 then wrapped = true end
				end
				cards[#cards + 1] = { step = r.psIndex, tab = plain(r.Tab:GetText()), lines = lines, icons = icons, coloured = coloured,
					more = r.More:IsShown() and r.More:GetText() or false, wrapped = wrapped, h = r:GetHeight(), done = r.Tick:IsShown(), shown = r:IsShown() }
						if r.Mark:IsShown() then marked[#marked + 1] = r.psIndex end
						if r.View:IsShown() then viewed[#viewed + 1] = r.psIndex end
					end
					emit({
						tag = tag,
						list = SL.frame:IsShown(),
						card = GF.parts.card:IsShown(),
						button = GF.listButton:IsShown(),
						setting = Polestar.Get("ui.stepList"),
						step = E.GetStepIndex(),
						dress = dress(),
						cards = cards, marked = marked, viewed = viewed,
					})
				end
				snap("closed")
				local counter = GF.parts.nav.Steps.Hit
				counter:GetScript("OnMouseUp")(counter, "LeftButton")
				stub.advance(0.3)
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
				for _, skin in ipairs({ "hearth", "forever", "blizzard", "classic", "halo" }) do
					Polestar.Set("ui.skin", skin)
					Polestar.Set("ui.stepList", true)
					stub.advance(0.3)
					local s = GF.stepList
					local o = { skin = skin, button = GF.listButton:IsShown(), list = s.frame:IsShown(), card = GF.parts.card:IsShown() }
					-- The card's dress, back on the card.
					Polestar.Set("ui.stepList", false)
					stub.advance(0.3)
					o.dress = dress()
					emit(o)
				end
				Polestar.Set("ui.skin", "polestar")
				Polestar.Set("ui.style", "transparent")
				stub.advance(0.3)
				emit({ transparent = true, dress = dress() })
				Polestar.Set("ui.style", "standard")
				Polestar.Set("ui.stepList", true)
				Polestar.Set("ui.compact", true)
				stub.advance(0.3)
				local function compactSnap() return { button = GF.listButton:IsShown(), list = SL.frame:IsShown(), card = GF.parts.card:IsShown(), n = SL.n, first = SL.n > 0 and SL.rows[1]:IsShown() and plain(SL.rows[1].Tab:GetText()) or false, h = SL.frame:GetHeight() } end
				-- The counter opens and closes the same list; the live card is tagged; Escape closes it.
				local function listed() return SL.frame:IsShown() end
				Polestar.Set("ui.compact", false)
				Polestar.Set("ui.stepList", false)
				stub.advance(0.3)
				local hit = GF.parts.nav.Steps.Hit
				hit:GetScript("OnMouseUp")(hit, "LeftButton")
				stub.advance(0.3)
				local viaCounter = { on = listed(), setting = Polestar.Get("ui.stepList"), live = {} }
				for i = 1, SL.n do viaCounter.live[#viaCounter.live + 1] = SL.rows[i].Live:IsShown() end
				SL.frame:Hide()
				stub.advance(0.3)
				viaCounter.escape = { on = listed(), setting = Polestar.Get("ui.stepList") }
				Polestar.Set("ui.stepList", true)
				stub.advance(0.3)
				hit:GetScript("OnMouseUp")(hit, "LeftButton")
				stub.advance(0.3)
				viaCounter.closed = { on = listed(), setting = Polestar.Get("ui.stepList") }
				emit({ counter = viaCounter })
				Polestar.Set("ui.compact", true)
				Polestar.Set("ui.stepList", true)
				stub.advance(0.3)
				local open = compactSnap()
				local c = SL.rows[1]
				c:GetScript("OnClick")(c)
				stub.advance(0.3)
				emit({ compact = true, open = open, clicked = compactSnap(), step = E.GetStepIndex() })"#;

#[test]
fn the_step_list_swaps_the_card_for_every_step_marks_the_live_one_and_a_click_looks_at_a_step_in_every_look() {
	let pack = compile_pack();
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let out =
		emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: BEFORE.into(), addons: vec![Addon::name("Polestar")], script: "\n\t\t\t\t".to_string() + &loads + SCRIPT, ..Default::default() });
	let (closed, open, progress, clicked) = (&out[0], &out[1], &out[2], &out[3]);

	// Closed: the card, no layers button (the step number opens the list), no cards read.
	assert_eq!(closed["card"], true);
	assert_eq!(closed["list"], false);
	assert_eq!(closed["button"], false);
	assert_eq!(closed["setting"], false);

	// Open: every step but the along one (no number), in order, tabbed with its number; the live step marked.
	assert_eq!(open["list"], true);
	assert_eq!(open["card"], false);
	assert_eq!(open["setting"], true);
	let steps: Vec<_> = open["cards"].as_array().unwrap().iter().map(|c| c["step"].clone()).collect();
	assert_eq!(steps, vec![json!(1), json!(2), json!(4), json!(5)]);
	let tabs: Vec<_> = open["cards"].as_array().unwrap().iter().map(|c| c["tab"].clone()).collect();
	assert_eq!(tabs, vec![json!("1 \u{b7} Deputy Willem"), json!("2 \u{b7} Marshal McBride"), json!("3 \u{b7} Kobold camp"), json!("4 \u{b7} Back to the abbey")]);
	// Each card: its people ("Talk to …", the name in the NPC colour) and a line per goal as the card words it.
	let lines: Vec<_> = open["cards"].as_array().unwrap().iter().map(|c| c["lines"].clone()).collect();
	assert_eq!(lines[0], json!(["Talk to Deputy Willem", "Accept “A Threat Within”"]));
	assert_eq!(lines[1], json!(["Talk to Marshal McBride", "Turn in “A Threat Within”", "Accept “Kobold Camp Cleanup”"]));
	assert_eq!(open["cards"][0]["coloured"], true);
	// Past six lines the rest is one "+N more"; a long line wraps and its card grows to fit.
	let camp = &open["cards"][2];
	assert_eq!(camp["lines"].as_array().unwrap().len(), 6);
	assert_eq!(camp["lines"][0], "Go to Kobold camp");
	assert_eq!(camp["more"], "+2 more");
	assert_eq!(camp["wrapped"], true);
	assert!(camp["h"].as_f64().unwrap() > open["cards"][1]["h"].as_f64().unwrap() + 3.0 * 14.0, "{}", camp["h"]);
	assert!(open["cards"][1]["h"].as_f64().unwrap() > open["cards"][0]["h"].as_f64().unwrap());
	assert_eq!(open["cards"][0]["icons"], json!(["verb", "verb"]));

	// Progress while open: the done step ticked and plain; in the live one, the done goal ticked.
	let (first, second) = (&progress["cards"][0], &progress["cards"][1]);
	// A finished step (not the one looked at) is one muted line: its number, title and tick, no goals.
	assert_eq!((first["done"].clone(), first["coloured"].clone(), first["h"].clone()), (json!(true), json!(false), json!(20)), "{first}");
	assert_eq!(first["tab"], "1 \u{b7} Deputy Willem");
	assert!(f_len(&first["lines"]) == 0, "{first}");
	assert_eq!((second["done"].clone(), second["icons"].clone()), (json!(false), json!(["verb", "tick", "verb"])));
	assert_eq!(progress["marked"], json!([2]));
	assert_eq!(open["marked"], json!([1]));
	assert_eq!(open["viewed"], json!([1]));

	// A click looks at that step and closes the list.
	assert_eq!(clicked["step"], 2);
	assert_eq!(clicked["list"], false);
	assert_eq!(clicked["card"], true);
	assert_eq!(clicked["setting"], false);

	// The house look's step card: its own ground, denser goal rows, no tab (the navigator numbers the step).
	assert_eq!(closed["dress"], json!({ "ground": true, "row": 18 }));

	// The game's looks and Halo: the list too, in place of the card (no button, the step number opens it).
	for (i, skin) in ["hearth", "forever", "blizzard", "classic", "halo"].iter().enumerate() {
		let o = &out[4 + i];
		assert_eq!(o["skin"], *skin);
		assert_eq!((o["button"].clone(), o["list"].clone(), o["card"].clone()), (json!(false), json!(true), json!(false)), "{skin}");
		// Their step card keeps its own dress: no ground, the 24px goal rows.
		assert_eq!(o["dress"]["ground"], false, "{skin}");
		assert!(o["dress"]["row"].as_f64().unwrap() >= 24.0, "{skin}: {}", o["dress"]["row"]);
	}

	// Transparent: the grounds go.
	assert_eq!(out[9]["dress"]["ground"], false);

	// The compact window keeps the list (from the step number): every step, a click looks at one and closes it.
	let counter = &out[10]["counter"];
	assert_eq!((counter["on"].clone(), counter["setting"].clone()), (json!(true), json!(true)), "the counter opens the list: {counter}");
	assert_eq!(counter["live"], json!([false, true, false, false]), "only the live step (the second, after the hand-in) is tagged: {counter}");
	assert_eq!((counter["escape"]["on"].clone(), counter["escape"]["setting"].clone()), (json!(false), json!(false)), "Escape closes it: {counter}");
	assert_eq!((counter["closed"]["on"].clone(), counter["closed"]["setting"].clone()), (json!(false), json!(false)), "and the counter closes it: {counter}");
	let compact = &out[11];
	let (copen, cclicked) = (&compact["open"], &compact["clicked"]);
	assert_eq!((copen["button"].clone(), copen["list"].clone(), copen["card"].clone()), (json!(false), json!(true), json!(false)), "{copen}");
	assert_eq!((copen["n"].clone(), copen["first"].clone()), (json!(4), json!("1 \u{b7} Deputy Willem")), "{copen}");
	assert!(copen["h"].as_f64().unwrap() >= 120.0, "{copen}");
	assert_eq!(compact["step"], 1);
	assert_eq!((cclicked["button"].clone(), cclicked["list"].clone(), cclicked["card"].clone()), (json!(false), json!(false), json!(true)), "{cclicked}");
}

fn f_len(v: &serde_json::Value) -> usize {
	v.as_array().map_or_else(|| v.as_object().map_or(0, |o| o.len()), |a| a.len())
}

/// Only the player's own close turns the list off. When the window hides (Alt-Z, combat, the setting), the client
/// runs the list's OnHide while the list itself stays shown: the setting stays on and the list comes back with it.
#[test]
fn the_step_list_comes_back_with_the_window_a_hide_of_the_window_is_not_a_close() {
	let pack = compile_pack();
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let script = r#"
				stub.login()
				stub.advance(0.5)
				local GF = Polestar.UI.GuideFrame
				local SL = GF.stepList
				Polestar.Set("ui.stepList", true)
				stub.advance(0.3)
				local open = SL.frame:IsShown()
				-- The window hides: the client runs the shown list's OnHide with it (the stub's Hide does not cascade).
				GF.frame:Hide()
				SL.frame:GetScript("OnHide")(SL.frame)
				local hidden = Polestar.Get("ui.stepList")
				GF.frame:Show()
				stub.advance(0.3)
				emit({ open = open, hidden = hidden, back = SL.frame:IsShown() and SL.frame:IsVisible() })"#;
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: BEFORE.into(),
		addons: vec![Addon::name("Polestar")],
		script: "\n\t\t\t\t".to_string() + &loads + script,
		..Default::default()
	});
	assert_eq!(out[0], json!({ "open": true, "hidden": true, "back": true }), "{}", out[0]);
}
