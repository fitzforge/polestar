//! The guide window (addon/Polestar/UI/GuideFrame.lua) against the real Core + Theme + UI manifests and a
//! contract-faithful fake Engine (with tabs), Guides and Nav (tests/lua/stub_ui.lua).

use std::collections::HashSet;

use forge_addontest::{emitted, fake_locale, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// Lua helpers shared by the scripts below.
const HELPERS: &str = r#"
local function visibleRows()
	local out = {}
	for _, r in ipairs(GF.rows) do if r:IsShown() then out[#out + 1] = r end end
	return out
end
local function rowFor(subject)
	for _, r in ipairs(visibleRows()) do
		if r.psGoal and r.psGoal.subject == subject then return r end
	end
end
-- The card's summary lines on screen, top to bottom (UI/GuideFrame.lua: a person, the persons done, "N done").
local function shownLines()
	local out = {}
	for _, l in ipairs(GF.lines) do
		if l:IsShown() then
			local t = l.Text:GetText() or ""
			out[#out + 1] = { key = l.psKey, text = t, plain = (t:gsub("|c%x%x%x%x%x%x%x%x", "")):gsub("|r", ""),
				icon = l.Icon:GetTexture():match("([%w-]+)$"), open = l.Chevron:GetTexture():match("chevron%-up") ~= nil }
		end
	end
	return out
end
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do
		if uistub.calls[i][1] == name then return uistub.calls[i] end
	end
end
local function shownTabs()
	local out = {}
	for _, b in ipairs(GF.tabs) do if b:IsShown() then out[#out + 1] = b end end
	return out
end
local function menuPick(text)
	GF.menuButton:Click()
	for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == text then r:Click() return r end end
end
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
"#;

// Run `script` after the fakes are installed and the player logged in.
fn run_with(script: &str, before: &str, install: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install({install})\nstub.login()\nlocal GF, UI, W = Polestar.UI.GuideFrame, Polestar.UI, Polestar.Widgets\nlocal F = PolestarGuideFrame\n{HELPERS}\n{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, "", "")
}

/// The first three entries of an array (`.slice(0, 3)`).
fn rgb(v: &Value) -> Value {
	Value::Array(v.as_array().unwrap()[..3].to_vec())
}

/// `rows.map((r) => r[key])`.
fn pluck(v: &Value, key: &str) -> Value {
	v.as_array().unwrap().iter().map(|x| x[key].clone()).collect()
}

/// Whether an array holds the string (`.includes(s)`).
fn has(v: &Value, s: &str) -> bool {
	v.as_array().unwrap().iter().any(|x| x.as_str() == Some(s))
}

fn joined(v: &Value) -> String {
	v.as_array().unwrap().iter().map(text).collect::<Vec<_>>().join(" | ")
}

fn f(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

/// A number as the emitted JSON would hold it (integers as integers).
fn num(x: f64) -> Value {
	if x.fract() == 0.0 {
		json!(x as i64)
	} else {
		json!(x)
	}
}

#[test]
fn a_field_step_reads_as_one_focus_the_step_title_its_few_objectives_with_counters_right_after_the_text_the_next_person() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local rows = {}
		for _, r in ipairs(visibleRows()) do
			local tr, tg, tb = r.Icon:GetVertexColor()
			local cr, cg, cb = r.Text:GetTextColor()
			rows[#rows + 1] = {
				subject = r.psGoal.subject,
				icon = r.Icon:GetTexture():match("([%w-]+)$"),
				iconColor = { tr, tg, tb }, textColor = { cr, cg, cb },
				check = r.Check:IsShown(),
				text = r.Text:GetText(),
				sub = r.Sub:IsShown() and r.Sub:GetText() or false,
				size = select(2, r.Text:GetFont()),
			}
		end
		local P = GF.parts
		emit({ rows = rows, lines = shownLines(), accent = { Polestar.Theme.Accent() }, success = { Polestar.Theme.Color("success") },
			text = { Polestar.Theme.Color("text") }, muted = { Polestar.Theme.Color("textMuted") }, dim = { Polestar.Theme.Color("textDim") },
			textHex = Polestar.Theme.Hex("text"), accentHex = Polestar.Theme.Hex("accent"),
			person = P.person.Name:GetText(), where = P.person.Where:GetText(),
			personIcon = P.person.Icon:GetTexture():match("([%w-]+)$"),
			tip = P.tip:IsShown() and P.tip.Text:GetText(), count = P.nav.Steps.Count:GetText(),
			after = P.after.Text:GetText(), persons = P.after.Count:GetText(),
			upnext = P.upnext:IsShown(), pct = P.foot.Pct:GetText(), footShown = P.foot:IsShown() })"#)
	.remove(0);
	assert_eq!(out["person"], "Kobold Camp", "a field group is named by its step");
	assert_eq!(out["where"], "Elwynn Forest");
	assert_eq!(out["personIcon"], "icon-goto", "a field group is a place");
	assert_eq!(out["count"], "3 / 8", "the navigator says where you are");
	assert_eq!(pluck(&out["rows"], "subject"), json!(["Kobold Vermin", "Tough Wolf Meat"]), "the focus's open goals; the done ones fold into a line (#843)");
	// The quest taken from the earlier quest-giver stays on the card (#741, #739), as the line of the persons
	// done; the reached "Go to" is counted on the focus's done line.
	let lines = out["lines"].as_array().unwrap();
	assert_eq!(pluck(&out["lines"], "key"), json!(["before", "done"]));
	assert!(is_match(text(&lines[0]["text"]), r"^\|c[0-9a-f]{8}Eagan Peltskinner\|r$"), "the person done with, in the NPC colour");
	assert_eq!(lines[0]["icon"], "check");
	assert_eq!(lines[1]["text"], "1 done");
	assert_eq!(lines[1]["icon"], "check");
	let rows = out["rows"].as_array().unwrap();
	let (kill, collect) = (&rows[0], &rows[1]);
	assert_eq!(kill["sub"], false, "the focus's own goals do not repeat the header");
	assert_eq!(kill["icon"], "icon-kill");
	assert_eq!(kill["iconColor"], rgb(&out["accent"]), "the current goal's glyph alone takes the accent");
	assert_eq!(collect["iconColor"], rgb(&out["dim"]), "the other open goals' glyphs sit in textDim");
	assert_eq!(kill["textColor"], rgb(&out["text"]), "open goals are white");
	assert!(is_match(text(&kill["text"]), r"^Kill \|c[0-9a-f]{8}Kobold Vermin\|r {2}\|c[0-9a-f]{8}7/10\|r$"), "the counter follows the text");
	assert!(text(&kill["text"]).ends_with(&format!("|c{}7/10|r", text(&out["textHex"]))), "an open counter reads in the text colour, not the accent");
	assert!(!text(&kill["text"]).contains(text(&out["accentHex"])));
	assert!(is_match(text(&collect["text"]), r"3/8\|r$"));
	assert_eq!(kill["size"], 14, "goal text is 14px");
	assert!(is_match(text(&out["tip"]), r"^Kobolds wander"));
	assert!(is_match(text(&out["after"]), r"^Then: \|c[0-9a-f]{8}Marshal McBride\|r$"), "the next step's first person");
	assert_eq!(out["persons"], "", "a field group is not a person");
	assert_eq!(out["upnext"], false, "Up next is off by default");
	assert_eq!(out["footShown"], true);
	assert_eq!(out["pct"], "29%", "2 of the 7 steps that apply are done");
}

#[test]
fn a_hub_reads_one_person_at_a_time_name_in_npc_colour_the_others_on_a_line_each_then_the_next_person() {
	let out = run(r#"
		local function snap()
			local P = GF.parts
			local names, subs, dimmed = {}, {}, {}
			local dr, dg, db = Polestar.Theme.Color("textDim")
			for _, r in ipairs(visibleRows()) do
				names[#names + 1] = r.psGoal.subject
				subs[#subs + 1] = r.Sub:IsShown() and r.Sub:GetText() or false
				local tr, tg, tb = r.Text:GetTextColor()
				dimmed[#dimmed + 1] = tr == dr and tg == dg and tb == db
			end
			local nr, ng, nb = P.person.Name:GetTextColor()
			return { person = P.person.Name:GetText(), color = { nr, ng, nb }, npc = { Polestar.Theme.Color("npc") },
				icon = P.person.Icon:GetTexture():match("([%w-]+)$"), goals = names, subs = subs, dimmed = dimmed, lines = shownLines(),
				after = P.after:IsShown() and P.after.Text:GetText() or false, persons = P.after.Count:GetText(), mark = P.person.Mark:IsShown(),
				markW = P.person.Mark:GetWidth(), iconColor = { P.person.Icon:GetVertexColor() }, dim = { Polestar.Theme.Color("textDim") },
				sliding = Polestar.Anim.IsRunning(P.card, "offset") }
		end
		uistub.setGuide(uistub.elwynn, 4)
		stub.advance(1)
		emit(snap())
		uistub.goal(4, 1).status = "done"
		uistub.goal(4, 2).status = "done"
		uistub.update()
		emit(snap())
		uistub.goal(4, 3).status = "done"
		uistub.update()
		local s = snap()
		stub.RunScript(GF.parts.person, "OnClick", "LeftButton")
		s.target = { lastCall("AimGoal"), lastCall("ReleaseTarget"), lastCall("SetTarget") or false }
		emit(s)"#);
	let (first, second, third) = (&out[0], &out[1], &out[2]);
	let plain = |v: &Value| -> Vec<String> { v.as_array().unwrap().iter().map(|l| text(&l["plain"]).to_string()).collect() };
	assert_eq!(first["person"], "Marshal McBride");
	assert_eq!(first["color"], rgb(&first["npc"]));
	assert_eq!(first["icon"], "icon-talk");
	// The focus's goals in the text colour; every other person of the hub one line, what is left to do there
	// counted (#843).
	assert_eq!(first["goals"], json!(["Kobold Camp Cleanup", "Investigate Echo Ridge"]));
	assert_eq!(first["dimmed"], json!([false, false]));
	assert_eq!(first["subs"][0], false, "the focus's goals do not repeat the header");
	assert_eq!(plain(&first["lines"]), ["Then: Eagan Peltskinner  ·  Turn in “Wolves Across the Border”", "Then: Brother Neals  ·  Talk to Brother Neals"]);
	assert!(is_match(text(&first["lines"][0]["text"]), r"^Then: \|c[0-9a-f]{8}Eagan Peltskinner\|r"), "the person in the NPC colour");
	assert_eq!(first["after"], false, "the lines name the persons to come: no second \"Then:\", no \"Person 1 of 3\"");
	assert_eq!(first["mark"], true, "the arrow points at this person");
	assert_eq!(first["markW"], 2, "the 2px selection bar used across Polestar");
	assert_eq!(rgb(&first["iconColor"]), rgb(&first["dim"]), "the person glyph steps back; the name carries the colour");
	assert_eq!(second["person"], "Eagan Peltskinner");
	assert_eq!(second["goals"], json!(["Wolves Across the Border"]));
	assert_eq!(plain(&second["lines"]), ["Marshal McBride", "Then: Brother Neals  ·  Talk to Brother Neals"], "the person done with stays on the card, on one line");
	assert_eq!(second["lines"][0]["key"], "before");
	assert_eq!(second["sliding"], true, "the next person slides in");
	assert_eq!(third["person"], "Brother Neals");
	assert_eq!(plain(&third["lines"]), ["Marshal McBride, Eagan Peltskinner"]);
	assert!(is_match(text(&third["after"]), r"^Then: \|c[0-9a-f]{8}Goldshire\|r$"), "after the last person: the next step");
	assert_eq!(third["persons"], "");
	assert_eq!(
		third["target"],
		json!([["AimGoal", 4, 4], ["ReleaseTarget"], false]),
		"a click on the header leads the arrow to the person's open goal through the Engine, as a click on its line does (#1653)"
	);
}

#[test]
fn a_done_step_viewed_with_prev_lists_all_its_goals_under_the_step_title_checked_with_no_arrow_mark() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 4)
		for g = 1, 4 do uistub.goal(4, g).status = "done" end
		uistub.update()
		local names, marks = {}, 0
		for _, r in ipairs(visibleRows()) do
			names[#names + 1] = r.psGoal.subject .. ":" .. r.psGoal.status
			if r.Mark:IsShown() then marks = marks + 1 end
		end
		emit({ person = GF.parts.person.Name:GetText(), goals = names, marks = marks, personMark = GF.parts.person.Mark:IsShown() })"#)
	.remove(0);
	assert_eq!(
		out,
		json!({
			"person": "Back to the Abbey",
			"goals": ["Kobold Camp Cleanup:done", "Investigate Echo Ridge:done", "Wolves Across the Border:done", "Brother Neals:done"],
			"marks": 0,
			"personMark": false,
		})
	);
}

#[test]
fn an_accept_the_game_does_not_confirm_says_so_on_its_line_first() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 4)
		uistub.goal(4, 2).noticeText = "Not offered by Marshal McBride? Report it with /polestar"
		uistub.update()
		local r = rowFor("Investigate Echo Ridge")
		local cr, cg, cb = r.Sub:GetTextColor()
		emit({ sub = r.Sub:IsShown() and r.Sub:GetText() or false, color = { cr, cg, cb }, dim = { Polestar.Theme.Color("textDim") } })"#)
	.remove(0);
	assert!(text(&out["sub"]).starts_with("Not offered by Marshal McBride? Report it with /polestar"), "{}", text(&out["sub"]));
	assert_eq!(rgb(&out["color"]), rgb(&out["dim"]), "kept readable, like an unavailable quest's reason");
}

#[test]
fn with_expand_step_tips_off_the_tip_is_one_line_until_clicked() {
	let out = run(r#"
		Polestar.Set("ui.width", 300)
		Polestar.Set("ui.notesOpen", false)
		uistub.setGuide(uistub.elwynn, 3)
		local tip = GF.parts.tip
		local closed = { open = tip.psOpen, h = tip:GetHeight() }
		tip:Click()
		local open = { open = tip.psOpen, h = tip:GetHeight() }
		uistub.setStep(4)
		uistub.setStep(3)
		emit({ closed = closed, open = open, reset = { open = tip.psOpen, h = tip:GetHeight() } })"#)
	.remove(0);
	assert_eq!(out["closed"]["open"], false);
	assert_eq!(out["open"]["open"], true);
	assert!(f(&out["open"]["h"]) > f(&out["closed"]["h"]), "opened, the tip shows in full");
	assert_eq!(out["reset"], out["closed"], "a new step starts with the tip collapsed");
}

#[test]
fn step_tips_start_on_one_line_by_default_with_expand_step_tips_on_in_full() {
	let out = run(r#"
		Polestar.Set("ui.width", 300)
		uistub.setGuide(uistub.elwynn, 3)
		local tip = GF.parts.tip
		local byDefault = tip.psOpen
		local closedH = tip:GetHeight()
		Polestar.Set("ui.notesOpen", true)
		local now = tip.psOpen
		Polestar.Set("ui.notesOpen", false)
		local off = tip.psOpen
		Polestar.Set("ui.notesOpen", true)
		tip:Click()
		local clicked = tip.psOpen
		uistub.setStep(4)
		uistub.setStep(3)
		emit({ byDefault = byDefault, off = off, closedH = closedH, now = now, clicked = clicked, next = tip.psOpen, h = tip:GetHeight() })"#)
	.remove(0);
	assert_eq!(out["byDefault"], false, "a new player sees the tip on one line, not a wall of text");
	assert_eq!(out["off"], false, "turning it off folds the tip on screen");
	assert_eq!(out["now"], true, "turning it on opens the tip on screen");
	assert_eq!(out["clicked"], false, "a click still folds it");
	assert_eq!(out["next"], true, "the next step starts open again");
	assert!(f(&out["h"]) > f(&out["closedH"]));
}

// A pack's picture on a sample step, as Guides.lua registers it.
fn picture(step: i32, size: Option<(i32, i32)>) -> String {
	let size = size.map(|(w, h)| format!(", w = {w}, h = {h}")).unwrap_or_default();
	format!(r#"uistub.guides[uistub.elwynn].steps[{step}].image = {{ file = "media\\cave"{size}, texture = "Interface\\AddOns\\PolestarPack_Joe\\media\\cave" }}"#)
}

#[test]
fn a_step_picture_shows_under_the_opened_tip_as_wide_as_the_text_column_with_its_aspect_kept_and_folds_away_with_the_tip() {
	let script = r#"
		Polestar.Set("ui.width", 300)
		Polestar.Set("ui.notesOpen", true)
		uistub.setGuide(uistub.elwynn, 3)
		local tip, img = GF.parts.tip, GF.parts.tip.Image
		local plain = { shown = img:IsShown(), h = tip:GetHeight() }
		${PICTURE(3, 512, 256)}
		GF.Render()
		local open = { shown = img:IsShown(), w = img:GetWidth(), h = img:GetHeight(), texture = img:GetTexture(), tipH = tip:GetHeight(), text = tip.Text:GetText() }
		tip:Click()
		local closed = { shown = img:IsShown(), tipH = tip:GetHeight() }
		tip:Click()
		emit({ plain = plain, open = open, closed = closed, again = img:IsShown() })"#
		.replace("${PICTURE(3, 512, 256)}", &picture(3, Some((512, 256))));
	let out = run(&script).remove(0);
	assert_eq!(out["plain"]["shown"], false, "a step without a picture shows none");
	let w = 300 - 39 - 14;
	let h = (w as f64 / 2.0 + 0.5).floor();
	assert_eq!(
		out["open"],
		json!({
			"shown": true,
			"w": w,
			"h": h as i64,
			"texture": r"Interface\AddOns\PolestarPack_Joe\media\cave",
			"tipH": num(f(&out["plain"]["h"]) + h + 6.0),
			"text": "Kobolds wander the mine entrance. Pull them one at a time; the vermin hit softly but come in pairs.",
		})
	);
	assert_eq!(out["closed"]["shown"], false, "folded to one line, the tip hides its picture");
	assert!(f(&out["closed"]["tipH"]) < f(&out["plain"]["h"]));
	assert_eq!(out["again"], true);
}

#[test]
fn a_tall_picture_stops_at_160_high_one_with_no_tip_reads_picture_of_this_spot_one_without_a_size_is_drawn_2_1() {
	let script = r#"
		Polestar.Set("ui.width", 300)
		Polestar.Set("ui.notesOpen", true)
		${PICTURE(5, 256, 256)}
		uistub.setGuide(uistub.elwynn, 5)
		local tip, img = GF.parts.tip, GF.parts.tip.Image
		local square = { tip = tip:IsShown(), text = tip.Text:GetText(), w = img:GetWidth(), h = img:GetHeight() }
		${PICTURE(5)}
		GF.Render()
		emit({ square = square, unsized = { w = img:GetWidth(), h = img:GetHeight() } })"#
		.replace("${PICTURE(5, 256, 256)}", &picture(5, Some((256, 256))))
		.replace("${PICTURE(5)}", &picture(5, None));
	let out = run(&script).remove(0);
	assert_eq!(out["square"], json!({ "tip": true, "text": "Picture of this spot", "w": 160, "h": 160 }));
	assert_eq!(out["unsized"], json!({ "w": 247, "h": 124 }));
}

#[test]
fn a_picture_the_client_cannot_load_or_with_step_tips_off_leaves_the_tip_as_it_is_without_one() {
	let script = r#"
		Polestar.Set("ui.width", 300)
		uistub.setGuide(uistub.elwynn, 3)
		local tip, img = GF.parts.tip, GF.parts.tip.Image
		local plainH = tip:GetHeight()
		local set = img.SetTexture
		img.SetTexture = function(self, path) set(self, path); return path == nil end
		${PICTURE(3, 512, 256)}
		${PICTURE(5, 512, 256)}
		GF.Render()
		local broken = { shown = img:IsShown(), h = tip:GetHeight() }
		uistub.setStep(5)
		local alone = tip:IsShown()
		img.SetTexture = set
		Polestar.Set("ui.showNotes", false)
		emit({ plainH = plainH, broken = broken, alone = alone, off = { tip = tip:IsShown(), img = img:IsShown() } })"#
		.replace("${PICTURE(3, 512, 256)}", &picture(3, Some((512, 256))))
		.replace("${PICTURE(5, 512, 256)}", &picture(5, Some((512, 256))));
	let out = run(&script).remove(0);
	assert_eq!(out["broken"], json!({ "shown": false, "h": out["plainH"].clone() }));
	assert_eq!(out["alone"], false, "a step whose only tip is a picture that does not load shows no tip");
	assert_eq!(out["off"], json!({ "tip": false, "img": false }));
}

#[test]
fn step_updated_refills_the_same_rows_in_place_and_a_newly_done_goal_pops() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		local frames = uistub.frameCount()
		local before = rowFor("Kobold Vermin")
		uistub.goal(3, 3).progress.cur = 8
		uistub.update()
		local text = rowFor("Kobold Vermin").Text:GetText()
		uistub.goal(3, 3).progress.cur = 10
		uistub.goal(3, 3).status = "done"
		uistub.update()
		local after = rowFor("Kobold Vermin")
		local popping = Polestar.Anim.IsRunning(after.Icon, "size")
		stub.advance(1)
		emit({ same = before == after, framesAdded = uistub.frameCount() - frames, text = text, doneText = after.Text:GetText(),
			icon = after.Icon:GetTexture():match("([%w-]+)$"), popping = popping, settled = Polestar.Anim.Active(),
			size = after.Icon:GetWidth(), successHex = Polestar.Theme.Hex("success") })"#)
	.remove(0);
	assert_eq!(out["same"], true);
	assert_eq!(out["framesAdded"], 0, "no frames are created for an update");
	assert!(is_match(text(&out["text"]), r"8/10\|r$"));
	assert_eq!(out["doneText"], format!("Kill Kobold Vermin  |c{}10/10|r", text(&out["successHex"])).as_str(), "done: plain text, the count kept in success");
	assert_eq!(out["icon"], "check");
	assert_eq!(out["popping"], true);
	assert_eq!(out["settled"], 0, "the tween driver stops once settled");
	assert_eq!(out["size"], 15);
}

#[test]
fn a_hidden_window_does_no_work_on_step_messages_and_shows_the_current_step_when_opened() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		F:Hide()
		local calls = #uistub.calls
		uistub.setStep(4)
		uistub.update()
		local asked = #uistub.calls - calls
		local stale = rowFor("Kobold Vermin") ~= nil
		F:Show()
		emit({ asked = asked, stale = stale, shown = rowFor("Kobold Vermin") ~= nil, rows = #visibleRows() })"#)
	.remove(0);
	assert_eq!(out["asked"], 0, "no Engine reads while hidden");
	assert_eq!(out["stale"], true, "the hidden window kept its old rows");
	assert_eq!(out["shown"], false, "opening it renders the step the Engine is on now");
	assert!(f(&out["rows"]) > 0.0);
}

#[test]
fn left_click_on_a_goal_of_the_step_aims_the_arrow_at_it_right_click_a_menu_on_a_quest_line_and_the_box_tick_any_goal_done_and_back() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local collect = rowFor("Tough Wolf Meat")
		stub.RunScript(collect, "OnClick", "LeftButton")
		local aimed = { lastCall("AimGoal"), lastCall("ReleaseTarget"), lastCall("SetTarget") or false }
		local target = Polestar.Nav.GetTarget()
		local marked = collect.Mark:IsShown()
		stub.RunScript(rowFor("Kobold Vermin"), "OnClick", "RightButton")
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Tick it done" then r:Click() end end
		local tickedKill = { lastCall("ToggleGoal"), rowFor("Kobold Vermin").Check:IsShown() }
		for g = 1, 3 do uistub.goal(4, g).status = "done" end
		uistub.setStep(4)
		stub.RunScript(rowFor("Brother Neals"), "OnClick", "RightButton")
		local toggled = lastCall("ToggleGoal")
		local checked = rowFor("Brother Neals").Check:GetChecked()
		rowFor("Brother Neals").Check:Click()
		emit({ aimed = aimed, target = { target.goalIndex, target.x }, marked = marked, tickedKill = tickedKill, toggled = toggled,
			checked = checked, after = rowFor("Brother Neals").Check:GetChecked() })"#)
	.remove(0);
	assert_eq!(out["aimed"], json!([["AimGoal", 3, 4], ["ReleaseTarget"], false]), "the Engine leads the arrow there; no point by hand");
	assert_eq!(out["target"], json!([4, 46]));
	assert_eq!(out["marked"], true, "the targeted row carries the accent mark");
	assert_eq!(out["tickedKill"], json!([["ToggleGoal", 3, 3], true]), "a quest goal ticks too");
	assert_eq!(out["toggled"], json!(["ToggleGoal", 4, 4]));
	assert_eq!(out["checked"], true);
	assert_eq!(out["after"], false, "the box follows the engine, which flipped it back");
}

// #1385: a click on a goal whose quest is not taken yet (Engine.AimGoal answers false, "accept", its title) leaves
// the arrow with the Engine, on the accept: no point set by hand, and the player reads "Take <quest> first".
#[test]
fn left_click_on_a_goal_whose_quest_is_not_taken_yet_says_take_it_first_and_sets_no_point_by_hand() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		Polestar.Engine.AimGoal = function(s, g)
			table.insert(uistub.calls, { "AimGoal", s, g })
			return false, "accept", "Wolves Across the Border"
		end
		local said = {}
		function UIErrorsFrame.AddMessage(_, message) said[#said + 1] = message end
		local calls = #uistub.calls
		stub.RunScript(rowFor("Tough Wolf Meat"), "OnClick", "LeftButton")
		local after = {}
		for i = calls + 1, #uistub.calls do after[#after + 1] = uistub.calls[i][1] end
		emit({ calls = after, said = table.concat(said, " | ") })"#)
	.remove(0);
	assert_eq!(out["calls"], json!(["AimGoal", "ReleaseTarget"]), "the Engine keeps the arrow; no SetTarget");
	assert_eq!(out["said"], "Take “Wolves Across the Border” first", "said once, where the game says what can't be done");
}

// #1653: the header of the step the guide is on (here the Discarded Fishing Toolbox, a quest-starting object with
// three places) leads the arrow through the Engine to its first open goal, as a click on that goal's line does, so a
// click on the arrow still moves on to the next place. It used to set a point by hand, which held the arrow on one
// place. Where the Engine can't lead there, the header still points at its place.
#[test]
fn a_click_on_the_header_aims_the_arrow_at_the_group_s_open_goal_through_the_engine_not_a_point_by_hand() {
	let out = run(r#"
		local id = "forever/alliance/test-loch"
		uistub.guides[id] = { id = id, pack = "guides", title = "Loch Modan", faction = "Alliance", category = "Leveling", minLevel = 10, maxLevel = 20,
			zone = 1432, zoneName = "Loch Modan", author = "Polestar", version = 1, steps = {
			{ title = "The loch", goals = {
				{ t = "accept", verb = "Accept", subject = "Silver of the Waves", subjectKind = "quest", quest = 86614, object = 665289,
					objectName = "Discarded Fishing Toolbox", map = 1432, x = 48.1, y = 39.7, spots = 3, status = "active" },
			} },
			{ title = "Thelsamar", goals = {
				{ t = "turnin", verb = "Turn in", subject = "Silver of the Waves", subjectKind = "quest", quest = 86614, npc = 1, npcName = "Khara Deepwater",
					map = 1432, x = 37.0, y = 46.0, status = "pending" },
			} },
		} }
		uistub.setGuide(id, 1)
		local P = GF.parts
		local r = { name = P.person.Name:GetText() }
		stub.RunScript(P.person, "OnClick", "LeftButton")
		local t = Polestar.Nav.GetTarget()
		r.aimed = { lastCall("AimGoal"), lastCall("ReleaseTarget"), lastCall("SetTarget") or false, t.stepIndex, t.goalIndex }
		-- The Engine can't lead there: the header's place, by hand.
		Polestar.Engine.AimGoal = function() return false end
		stub.RunScript(P.person, "OnClick", "LeftButton")
		r.byHand = lastCall("SetTarget")
		emit(r)"#)
	.remove(0);
	assert_eq!(out["name"], "Discarded Fishing Toolbox");
	assert_eq!(out["aimed"], json!([["AimGoal", 1, 1], ["ReleaseTarget"], false, 1, 1]), "the Engine's waypoint, with its spots; no point by hand");
	assert_eq!(out["byHand"], json!(["SetTarget", 1432, 48.1, 39.7, "Discarded Fishing Toolbox"]));
}

// Skip this quest (Engine.SkipQuest): a quest's line, right-clicked, offers its tick and the quest's skip. The
// card moves on, so a banner offers the undo; a skipped quest's line reads so, its accept shows Undo, and a
// right-click brings it back. A line with no quest ticks.
#[test]
fn right_click_on_a_quest_line_tick_it_done_or_skip_this_quest_the_banner_undo_or_a_right_click_bring_it_back() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		for g = 1, 3 do uistub.goal(4, g).status = "done" end
		uistub.goal(4, 2).status = "active"
		uistub.setStep(4)
		local B = GF.parts.banner
		local function menu()
			local out = {}
			for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then out[#out + 1] = r.Text:GetText() end end
			return out
		end
		local function pick(text) for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == text then r:Click() end end end
		local echo = rowFor("Investigate Echo Ridge")
		stub.RunScript(echo, "OnEnter")
		local tip = GameTooltip.lines
		stub.RunScript(echo, "OnClick", "RightButton")
		local items = menu()
		pick("Skip this quest")
		local skipped = { call = lastCall("SkipQuest"), banner = B:IsShown() and B.Text:GetText() or false, undo = B.Jump.Label:GetText() }
		B.Jump:Click()
		local undone = { call = lastCall("SkipQuest"), banner = B:IsShown() }
		-- Skipped again, with the rest of the step done: the card shows every line.
		Polestar.Engine.SkipQuest(15, true)
		GF.DismissBanner()
		uistub.goal(4, 4).status = "done"; Polestar.Fire("STEP_UPDATED", 4)
		echo = rowFor("Investigate Echo Ridge")
		local line = { undo = echo.Skip:IsShown() and echo.Skip.Label:GetText() or false }
		stub.RunScript(echo, "OnEnter")
		line.tip = GameTooltip.lines
		echo.Skip:Click()
		line.call = lastCall("SkipQuest")
		Polestar.Engine.SkipQuest(15, true)
		GF.DismissBanner()
		stub.RunScript(rowFor("Investigate Echo Ridge"), "OnClick", "RightButton")
		local back = { call = lastCall("SkipQuest"), menu = PolestarMenu:IsShown() }
		-- Skipped again: every line shows; Brother Neals has no quest.
		Polestar.Engine.SkipQuest(15, true)
		GF.DismissBanner()
		stub.RunScript(rowFor("Brother Neals"), "OnClick", "RightButton")
		emit({ tip = tip, items = items, skipped = skipped, undone = undone, line = line, back = back, neals = { lastCall("ToggleGoal"), PolestarMenu:IsShown() } })"#)
	.remove(0);
	assert!(has(&out["tip"], "Right-click to tick it done or skip this quest"), "{}", joined(&out["tip"]));
	assert_eq!(out["items"], json!(["Tick it done", "Skip this quest"]));
	assert_eq!(
		out["skipped"],
		json!({
			"call": ["SkipQuest", 15, true],
			"banner": "Skipped “Investigate Echo Ridge”  ·  and the quests that follow from it",
			"undo": "Undo",
		})
	);
	assert_eq!(out["undone"], json!({ "call": ["SkipQuest", 15, false], "banner": false }));
	assert_eq!(out["line"]["undo"], "Undo", "the skipped accept shows Undo");
	assert!(has(&out["line"]["tip"], "Right-click to bring this quest back"));
	assert_eq!(out["line"]["call"], json!(["SkipQuest", 15, false]));
	assert_eq!(out["back"], json!({ "call": ["SkipQuest", 15, false], "menu": false }), "a right-click brings a skipped quest back, no menu");
	assert_eq!(out["neals"], json!([["ToggleGoal", 4, 4], false]), "a line with no quest ticks on right-click, as before");
}

// Show in quest log (Quests/QuestLogLink.lua): a quest's line, right-clicked, offers the game's quest log at that
// quest between its tick and its skip; picking it goes through Polestar.ShowInQuestLog.
#[test]
fn right_click_on_a_quest_line_offers_show_in_quest_log_which_opens_the_log_at_that_quest() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml", "Quests/QuestLogLink.lua"])],
		script: format!(
			"uistub.install()\nstub.login()\nlocal GF, UI, W = Polestar.UI.GuideFrame, Polestar.UI, Polestar.Widgets\nlocal F = PolestarGuideFrame\n{HELPERS}\n{}",
			r#"
		local C, opened, asked = Polestar.Compat, {}, {}
		C.CanOpenQuestLog = function() return true end
		C.IsOnQuest = function(q) return q == 15 end
		C.OpenQuestLog = function(q) opened[#opened + 1] = q; return true end
		local show = Polestar.ShowInQuestLog
		Polestar.ShowInQuestLog = function(q) asked[#asked + 1] = q; return show(q) end
		uistub.setGuide(uistub.elwynn, 3)
		for g = 1, 3 do uistub.goal(4, g).status = "done" end
		uistub.goal(4, 2).status = "active"
		uistub.setStep(4)
		stub.RunScript(rowFor("Investigate Echo Ridge"), "OnClick", "RightButton")
		local items = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then items[#items + 1] = r.Text:GetText() end end
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Show in quest log" then r:Click() end end
		emit({ items = items, asked = asked, opened = opened, skip = lastCall("SkipQuest") or false })"#
		),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["items"], json!(["Tick it done", "Show in quest log", "Skip this quest"]));
	assert_eq!(out["asked"], json!([15]), "the menu row calls Polestar.ShowInQuestLog");
	assert_eq!(out["opened"], json!([15]), "the quest log opens at that quest");
	assert_eq!(out["skip"], false, "nothing skipped");
}

#[test]
fn hovering_a_goal_explains_it_detail_quest_npc_location_and_what_clicks_do() {
	let lines = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		for g = 1, 3 do uistub.goal(4, g).status = "done" end
		uistub.setStep(4)
		stub.RunScript(rowFor("Brother Neals"), "OnEnter")
		emit(GameTooltip.lines)"#)
	.remove(0);
	assert_eq!(lines[0], "Talk to Brother Neals");
	assert!(has(&lines, "in the abbey bell tower"), "the detail moved into the tooltip");
	assert!(lines.as_array().unwrap().iter().any(|l| is_match(text(l), r"^NPC \| Brother Neals")));
	assert!(has(&lines, "Location | Elwynn Forest  49.6, 40.4"));
	assert!(has(&lines, "Click to point the arrow here"));
	assert!(has(&lines, "Right-click to tick it done"));
}

// #1247: an accept's tooltip names the level its quest needs (red while the character is below it) and the
// prerequisites not handed in yet (Engine.AcceptGate); with nothing to say, neither line.
#[test]
fn an_accept_s_tooltip_shows_the_level_its_quest_needs_and_the_quests_it_still_needs() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		for g = 1, 3 do uistub.goal(4, g).status = "done" end
		uistub.goal(4, 2).status = "active"
		local danger = "|c" .. Polestar.Theme.Hex("danger")
		local function hover()
			local row = rowFor("Investigate Echo Ridge")
			stub.RunScript(row, "OnEnter")
			local plain, red = {}, {}
			for _, l in ipairs(GameTooltip.lines) do
				local p = l:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
				plain[#plain + 1] = p
				if l:find(danger, 1, true) then red[#red + 1] = p end
			end
			return { plain = plain, red = red }
		end
		local r = {}
		-- Below the level, a prerequisite and one of two others missing.
		uistub.goal(4, 2).gate = { level = 7, short = true, needs = { "Kobold Camp Cleanup", "Bounty on Murlocs or Report to Goldshire" } }
		uistub.setStep(4)
		r.short = hover()
		-- At the level, the prerequisites done.
		uistub.goal(4, 2).gate = { level = 7, short = false, needs = {} }
		Polestar.Fire("STEP_UPDATED", 4)
		r.met = hover()
		-- Nothing known.
		uistub.goal(4, 2).gate = nil
		Polestar.Fire("STEP_UPDATED", 4)
		r.none = hover()
		emit(r)"#)
	.remove(0);
	let short = &out["short"];
	assert!(has(&short["plain"], "Level | Requires level 7"), "{}", joined(&short["plain"]));
	assert!(has(&short["plain"], "Needs | Kobold Camp Cleanup, Bounty on Murlocs or Report to Goldshire"), "{}", joined(&short["plain"]));
	assert_eq!(short["red"], json!(["Level | Requires level 7", "Needs | Kobold Camp Cleanup, Bounty on Murlocs or Report to Goldshire"]));
	let met = &out["met"];
	assert!(has(&met["plain"], "Level | Requires level 7"), "{}", joined(&met["plain"]));
	assert!(met["red"] == json!([]) || met["red"] == json!({}), "met: not red: {}", met["red"]);
	assert!(!joined(&met["plain"]).contains("Needs"), "no prerequisite left: no Needs line");
	let none = joined(&out["none"]["plain"]);
	assert!(!none.contains("Level |") && !none.contains("Needs |"), "nothing known: neither line: {none}");
	assert!(none.contains("Quest | Investigate Echo Ridge"), "the rest of the tooltip as before: {none}");
}

#[test]
fn the_step_navigator_and_the_up_next_list_drive_the_engine_a_step_change_animates_then_stops() {
	let out = run(r#"
		Polestar.Set("ui.upcoming", 3)
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		local N = GF.parts.nav
		N.Next:Click()
		local count = N.Steps.Count:GetText()
		local animating = Polestar.Anim.Active() > 0 and GF.parts.card:GetAlpha() < 1
		stub.advance(1)
		local settled = { Polestar.Anim.Active(), GF.parts.card:GetAlpha() }
		N.Prev:Click()
		local collapsed = GF.parts.upnext:IsShown() and GF.parts.upnext.Toggle.Label:GetText()
		GF.parts.upnext.Toggle:Click()
		local open = Polestar.Get("ui.upcomingOpen")
		local shown = {}
		for _, r in ipairs(GF.upRows) do if r:IsShown() then shown[#shown + 1] = r.psIndex end end
		GF.upRows[1]:Click()
		emit({ count = count, animating = animating, settled = settled, collapsed = collapsed, open = open, shown = shown,
			calls = uistub.calls })"#)
	.remove(0);
	assert_eq!(out["count"], "4 / 8");
	assert_eq!(out["animating"], true);
	assert_eq!(out["settled"], json!([0, 1]));
	assert_eq!(out["collapsed"], "Up next \u{b7} 3 steps", "turned on, it starts collapsed");
	assert_eq!(out["open"], true);
	assert_eq!(out["shown"], json!([4, 5, 7]), "the mage-only step 6 does not apply");
	let names: Value = out["calls"].as_array().unwrap().iter().map(|c| c[0].clone()).collect();
	assert_eq!(names, json!(["Next", "Prev", "Goto"]));
	assert_eq!(out["calls"][2], json!(["Goto", 4]));
}

#[test]
fn reduced_motion_a_step_change_lands_without_movement() {
	let out = run(r#"
		Polestar.Set("ui.reduceMotion", true)
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		GF.parts.nav.Next:Click()
		local p = GF.parts.card.points[#GF.parts.card.points]
		emit({ y = p.y, offsetRunning = Polestar.Anim.IsRunning(GF.parts.card, "offset") })"#)
	.remove(0);
	assert_eq!(out, json!({ "y": 0, "offsetRunning": false }));
}

#[test]
fn settings_apply_live_scale_opacity_lock_compact_upcoming_shown() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local h0 = F:GetHeight()
		Polestar.Set("ui.scale", 1.3)
		Polestar.Set("ui.opacity", 0.5)
		Polestar.Set("ui.locked", true)
		stub.RunScript(GF.parts.nav, "OnDragStart")
		local movedWhileLocked = F.moving == true
		Polestar.Set("ui.compact", true)
		local P = GF.parts
		local compact = { strip = P.strip:IsShown(), after = P.after:IsShown(), tip = P.tip:IsShown(), rows = #visibleRows(),
			foot = P.foot:IsShown(), h = F:GetHeight() }
		Polestar.Set("ui.compact", false)
		Polestar.Set("ui.upcoming", 4)
		Polestar.Set("ui.upcomingOpen", true)
		local upIdx = {}
		for _, r in ipairs(GF.upRows) do if r:IsShown() then upIdx[#upIdx + 1] = r.psIndex end end
		Polestar.Fire("TOGGLE_FRAME")
		local afterToggle = F:IsShown()
		Polestar.Fire("SHOW_FRAME")
		emit({ scale = F:GetScale(), alpha = F:GetAlpha(), grip = GF.grip:IsShown(), movedWhileLocked = movedWhileLocked,
			compact = compact, h0 = h0, upcoming = upIdx, afterToggle = afterToggle, shown = F:IsShown(), stored = Polestar.Get("ui.shown") })"#)
	.remove(0);
	assert_eq!(out["scale"], 1.3);
	assert_eq!(out["alpha"], 0.5);
	assert_eq!(out["grip"], false, "locked: no resize grip");
	assert_eq!(out["movedWhileLocked"], false);
	let mut compact = out["compact"].clone();
	compact.as_object_mut().unwrap().remove("h");
	assert_eq!(compact, json!({ "strip": false, "after": false, "tip": false, "rows": 2, "foot": true }), "compact keeps the navigator, the focus's open goals and the progress bar");
	assert!(f(&out["compact"]["h"]) < f(&out["h0"]), "compact mode is shorter");
	assert_eq!(out["upcoming"], json!([4, 5, 7, 8]));
	assert_eq!(out["afterToggle"], false);
	assert_eq!(out["shown"], true);
	assert_eq!(out["stored"], true);
}

#[test]
fn dragging_saves_the_position_the_grip_resizes_width_within_bounds() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		F.x, F.y = 1500, 300
		stub.RunScript(GF.parts.nav, "OnDragStart")
		local moving = F.moving
		local top = F:GetTop()
		stub.RunScript(GF.parts.nav, "OnDragStop")
		local pos = Polestar.Get("ui.pos")
		stub.cursor = { 100, 500 }
		stub.RunScript(GF.grip, "OnMouseDown", "LeftButton")
		stub.cursor = { 180, 500 }
		stub.advance(0.1)
		local live = F:GetWidth()
		stub.cursor = { 2000, 500 }
		stub.advance(0.1)
		stub.RunScript(GF.grip, "OnMouseUp", "LeftButton")
		emit({ moving = moving, pos = pos, top = top, live = live, width = Polestar.Get("ui.width"),
			polling = GF.grip:GetScript("OnUpdate") ~= nil, point = { F:GetPoint(1) } })"#)
	.remove(0);
	assert_eq!(out["moving"], true);
	assert_eq!(out["pos"], json!([1500, out["top"].clone()]), "saved as the top-left corner");
	assert_eq!(out["live"], 420, "width follows the cursor while dragging");
	assert_eq!(out["width"], 560, "and is clamped to the maximum");
	assert_eq!(out["polling"], false, "no OnUpdate once released");
	assert_eq!(out["point"][0], "TOPLEFT");
}

#[test]
fn grow_upward_pins_the_window_by_its_bottom_left_turning_it_on_or_off_keeps_the_window_in_place() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		F.x, F.y = 1500, 300
		Polestar.Set("ui.growUp", true)
		local on, onPoint = Polestar.Get("ui.pos"), { F:GetPoint(1) }
		F.x, F.y = 900, 120
		stub.RunScript(GF.parts.nav, "OnDragStart")
		stub.RunScript(GF.parts.nav, "OnDragStop")
		local dragged = Polestar.Get("ui.pos")
		stub.cursor = { 100, 500 }
		stub.RunScript(GF.grip, "OnMouseDown", "LeftButton")
		local resizePoint = { F:GetPoint(1) }
		stub.RunScript(GF.grip, "OnMouseUp", "LeftButton")
		Polestar.Set("ui.pos", nil)
		local resetPoint = { F:GetPoint(1) }
		F.x, F.y = 900, 120
		Polestar.Set("ui.growUp", false)
		emit({ on = on, onPoint = onPoint, dragged = dragged, resizePoint = resizePoint, resetPoint = resetPoint,
			off = Polestar.Get("ui.pos"), offPoint = { F:GetPoint(1) }, top = F:GetTop() })"#)
	.remove(0);
	assert_eq!(out["on"], json!([1500, 300]), "turning it on saves the bottom-left where the window stands");
	assert_eq!(out["onPoint"][0], "BOTTOMLEFT");
	assert_eq!(out["dragged"], json!([900, 120]), "dragging saves the bottom-left");
	assert_eq!(out["resizePoint"][0], "BOTTOMLEFT", "resizing the width keeps the bottom edge pinned");
	assert_eq!(out["resetPoint"][0], "BOTTOMRIGHT", "reset puts it in the bottom-right corner");
	assert_eq!(out["resetPoint"][2], "BOTTOMRIGHT");
	assert_eq!(out["off"], json!([900, out["top"].clone()]), "turning it off saves the top-left where the window stands");
	assert_eq!(out["offPoint"][0], "TOPLEFT");
}

#[test]
fn bar_at_the_bottom_needs_grow_upward_then_the_tabs_navigator_and_progress_stack_at_the_bottom() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		-- GetPoint also returns a frame: emit only the anchor strings, not its whole object graph.
		local function at() return { strip = GF.parts.strip:GetPoint(1), foot = select(3, GF.parts.foot:GetPoint(1)), nav = GF.parts.nav:GetPoint(1) } end
		local normal = at()
		Polestar.Set("ui.barsBottom", true)
		local withoutGrow = at()
		Polestar.Set("ui.growUp", true)
		local flipped = at()
		Polestar.Set("ui.barsBottom", false)
		emit({ normal = normal, withoutGrow = withoutGrow, flipped = flipped, back = at() })"#)
	.remove(0);
	let pt = |o: &Value| json!([o["strip"].clone(), o["foot"].clone(), o["nav"].clone()]);
	assert_eq!(pt(&out["normal"]), json!(["TOPLEFT", "BOTTOMLEFT", "TOPLEFT"]), "default: tabs on top, foot at the bottom");
	assert_eq!(pt(&out["withoutGrow"]), json!(["TOPLEFT", "BOTTOMLEFT", "TOPLEFT"]), "without grow upward the option changes nothing");
	assert_eq!(pt(&out["flipped"]), json!(["BOTTOMLEFT", "TOPLEFT", "BOTTOMLEFT"]), "flipped: tabs at the bottom, the navigator and the foot stacked above them");
	assert_eq!(pt(&out["back"]), json!(["TOPLEFT", "BOTTOMLEFT", "TOPLEFT"]), "turning it off restores the order");
}

// thmastin (#666): with Grow upward the window is pinned by its bottom edge.
// A step that would push its top past the top of the screen made the game
// move the whole window down (its screen clamp), bar and all. The window now
// ends at the top of the screen: the goals area scrolls, as under the height
// cap, and when even that is too tall the step list is clipped at the bars.
#[test]
fn grow_upward_the_window_ends_at_the_top_of_the_screen_and_keeps_its_bottom_edge_where_it_is_pinned() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		Polestar.Set("ui.maxHeight", 0.9)
		Polestar.Set("ui.growUp", true)
		Polestar.Set("ui.barsBottom", true)
		Polestar.Set("ui.pos", { 1500, 100 })
		local goals = GF.parts.goals
		local full, fullOver = F:GetHeight(), goals.psOver
		local clips = {}
		GF.parts.body.SetClipsChildren = function(_, on) clips[#clips + 1] = on end
		local function at(y)
			Polestar.Set("ui.pos", { 1500, y })
			local p, _, rp, _, py = F:GetPoint(1)
			return { y = y, h = F:GetHeight(), point = { p, rp, py }, over = goals.psOver, cut = clips[#clips] }
		end
		local top = UIParent:GetTop()
		local near = at(top - full + 20)
		local tight = at(top - 150)
		local back = at(100)
		emit({ full = full, fullOver = fullOver, top = top, near = near, tight = tight, back = back })"#)
	.remove(0);
	let top = f(&out["top"]);
	assert!(f(&out["full"]) >= 160.0, "the step is tall enough to be cut: {}", out["full"]);
	assert_eq!(out["fullOver"], false, "with room the goals area shows everything");
	for k in ["near", "tight"] {
		let s = &out[k];
		assert_eq!(s["point"][0], "BOTTOMLEFT", "{k}: still pinned by its bottom-left corner");
		assert_eq!(s["point"][2], s["y"], "{k}: where the player put it");
	}
	// 20 px short, the goals area ends on a whole goal under the top of the screen (as under the height cap), so the
	// window ends at most a goal row below it; with 150 px it is clipped at the top of the screen.
	let near = &out["near"];
	let room = top - f(&near["y"]);
	assert!(f(&near["h"]) <= room && f(&near["h"]) > room - 60.0, "near: the window ends at the top of the screen or a row under it, not past it ({near})");
	assert_eq!(f(&out["tight"]["h"]), top - f(&out["tight"]["y"]), "tight: the window ends at the top of the screen ({})", out["tight"]);
	assert_eq!(out["near"]["over"], true, "20 px short: the goals area scrolls ({})", out["near"]);
	assert_eq!(out["near"]["cut"], false, "and nothing is clipped");
	assert_eq!(out["tight"]["cut"], true, "150 px of room: the step list is clipped at the bars ({})", out["tight"]);
	assert_eq!(out["back"]["h"], out["full"], "with room again the window has its full height");
	assert_eq!(out["back"]["over"], false, "the goals area shows everything again");
	assert_eq!(out["back"]["cut"], false, "and nothing is clipped");
}

#[test]
fn bar_at_the_bottom_a_tab_opened_while_it_is_on_has_its_highlight_on_the_top_edge_from_the_render_that_makes_it() {
	let out = run(r#"
		Polestar.Set("ui.growUp", true)
		Polestar.Set("ui.barsBottom", true)
		local points, render = {}, GF.RenderTabs
		GF.RenderTabs = function(...)
			render(...)
			for _, b in ipairs(shownTabs()) do points[#points + 1] = b.Bar:GetPoint(1) end
		end
		uistub.openTabs(TABS, 1)
		GF.RenderTabs = render
		emit({ points = points })"#)
	.remove(0);
	let points = out["points"].as_array().unwrap();
	assert!(points.len() >= 2, "the tabs were rendered");
	for p in points {
		assert_eq!(*p, "TOPLEFT", "a new tab's highlight sits on the edge next to the navigator");
	}
}

#[test]
fn combat_by_default_the_window_stays_as_it_is_fade_dims_it_hide_hides_it_both_restore_afterwards() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(1)
		local steady = F:GetAlpha()
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(1)
		Polestar.Set("ui.combat", "fade")
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(1)
		local faded = F:GetAlpha()
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(1)
		local restored = F:GetAlpha()
		Polestar.Set("ui.combat", "hide")
		stub.fire("PLAYER_REGEN_DISABLED")
		local hidden = not F:IsShown()
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ steady = steady, faded = faded, restored = restored, hidden = hidden, shown = F:IsShown() })"#)
	.remove(0);
	assert_eq!(out["steady"], 1, "no fade on every pull unless the player asks for it");
	assert!((f(&out["faded"]) - 0.35).abs() < 1e-9);
	assert_eq!(out["restored"], 1);
	assert_eq!(out["hidden"], true);
	assert_eq!(out["shown"], true);
}

#[test]
fn empty_states_no_guides_no_guide_open_with_suggestion_guide_complete() {
	let out = run(r#"
		local function state()
			local e = GF.parts.empty
			return { shown = e:IsShown(), title = e.Title:GetText(), text = e.Text:GetText(),
				primary = e.Primary:IsShown() and e.Primary.Label:GetText() or false,
				secondary = e.Secondary:IsShown() and e.Secondary.Label:GetText() or false, card = GF.parts.card:IsShown() }
		end
		local order = uistub.order
		uistub.order = {}
		Polestar.Fire("GUIDES_REGISTERED")
		emit(state())
		uistub.order = order
		Polestar.Fire("GUIDES_REGISTERED")
		emit(state())
		GF.parts.empty.Primary:Click()
		uistub.complete()
		local s = state()
		GF.parts.empty.Primary:Click()
		s.calls = uistub.calls
		emit(s)"#);
	let (no_guides, no_guide, complete) = (&out[0], &out[1], &out[2]);
	assert_eq!(no_guides["title"], "No guides installed");
	assert_eq!(no_guides["primary"], false);
	assert_eq!(no_guides["card"], false);
	assert_eq!(no_guide["title"], "No guide open");
	assert!(is_match(text(&no_guide["text"]), r"Elwynn Forest"));
	assert_eq!(no_guide["primary"], "Start guide");
	assert_eq!(no_guide["secondary"], "Browse guides");
	assert_eq!(complete["title"], "Guide complete");
	assert!(is_match(text(&complete["text"]), r"Westfall"));
	assert_eq!(complete["primary"], "Continue");
	let calls: Value = complete["calls"].as_array().unwrap().iter().map(|c| Value::Array(c.as_array().unwrap().iter().take(2).cloned().collect())).collect();
	assert_eq!(calls, json!([["OpenTab", "forever/alliance/human/01-elwynn-forest"], ["SetGuide", "forever/alliance/02-westfall"]]), "start opens a tab; continue replaces the guide in the same tab");
}

#[test]
fn tab_strip_one_tab_per_open_guide_select_close_move_and_opens_the_picker_for_a_new_tab() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local tabs = shownTabs()
		local titles, ranges, widths = {}, {}, {}
		for i, b in ipairs(tabs) do titles[i] = b.Label:GetText(); ranges[i] = b.Range:GetText(); widths[i] = b:GetWidth() end
		local activeBar = { tabs[1].Bar:IsShown(), tabs[2].Bar:IsShown() }
		local titleInNav = GF.parts.nav.Title:IsShown()
		tabs[2]:Click()
		local afterSelect = { title = GF.parts.nav.Title:GetText(), count = GF.parts.nav.Steps.Count:GetText(), bar = shownTabs()[2].Bar:IsShown() }
		-- Right-click: tab options.
		stub.RunScript(shownTabs()[1], "OnClick", "RightButton")
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Move right" then r:Click() end end
		local moved = lastCall("MoveTab")
		shownTabs()[3].Close:Click()
		local closed = { n = #shownTabs(), call = lastCall("CloseTab") }
		GF.parts.strip.Add:Click()
		local pickerNewTab = PolestarPicker:IsShown() and Polestar.UI.Picker.IsNewTabMode()
		emit({ titles = titles, ranges = ranges, widths = widths, activeBar = activeBar, titleInNav = titleInNav, afterSelect = afterSelect, moved = moved,
			closed = closed, pickerNewTab = pickerNewTab })"#)
	.remove(0);
	assert_eq!(out["titles"], json!(["Elwynn Forest", "Tailoring 1-300", "Stormwind Reputation"]));
	assert_eq!(out["ranges"], json!(["(1–13)", "(5–60)", "(12–60)"]), "each tab names its levels after the title, as the guide menu rows do");
	assert!(f(&out["widths"][0]) > f(&out["widths"][1]), "the active tab gets the room to read its title");
	assert_eq!(out["activeBar"], json!([true, false]));
	assert_eq!(out["titleInNav"], false, "the tab names the guide; the navigator does not repeat it");
	assert_eq!(out["afterSelect"], json!({ "title": "Tailoring 1-300", "count": "2 / 4", "bar": true }));
	assert_eq!(out["moved"], json!(["MoveTab", 1, 2]));
	assert_eq!(out["closed"], json!({ "n": 2, "call": ["CloseTab", 3] }));
	assert_eq!(out["pickerNewTab"], true);
}

#[test]
fn a_tab_s_right_click_menu_has_choose_guide_it_makes_that_tab_active_and_opens_the_picker_to_replace_its_guide() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		stub.RunScript(shownTabs()[3], "OnClick", "RightButton")
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Choose guide" then r:Click() end end
		emit({ select = lastCall("SelectTab"), picker = PolestarPicker:IsShown(), newTab = Polestar.UI.Picker.IsNewTabMode() })"#)
	.remove(0);
	assert_eq!(out["select"], json!(["SelectTab", 3]));
	assert_eq!(out["picker"], true);
	assert_eq!(out["newTab"], false, "the picked guide replaces the tab's guide instead of opening another tab");
}

// A player on Discord asked how to close a guide tab: the strip's close button was invisible until hovered. It shows
// faintly at rest, in full under the pointer, and still closes its tab.
#[test]
fn a_tab_s_close_button_shows_faintly_at_rest_and_in_full_under_the_pointer() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local b = shownTabs()[2]
		local r = { rest = b.Close:GetAlpha(), shown = b.Close:IsShown() }
		stub.RunScript(b, "OnEnter")
		r.hover = b.Close:GetAlpha()
		stub.RunScript(b, "OnLeave")
		r.left = b.Close:GetAlpha()
		stub.RunScript(b.Close, "OnEnter")
		r.overButton = b.Close:GetAlpha()
		stub.RunScript(b.Close, "OnLeave")
		r.offButton = b.Close:GetAlpha()
		b.Close:Click()
		r.call = lastCall("CloseTab")
		emit(r)"#)
	.remove(0);
	assert_eq!(out["shown"], true);
	assert!(f(&out["rest"]) > 0.2 && f(&out["rest"]) < 0.6, "faint at rest: {}", out["rest"]);
	assert_eq!(out["hover"], 1.0);
	assert_eq!(out["left"], out["rest"]);
	assert_eq!(out["overButton"], 1.0);
	assert_eq!(out["offButton"], out["rest"]);
	assert_eq!(out["call"], json!(["CloseTab", 2]));
}

#[test]
fn a_narrow_tab_truncates_its_title_and_keeps_its_level_range_whole_also_with_the_close_button_shown() {
	let out = run(r#"
		Polestar.Set("ui.width", 300)
		uistub.openTabs(TABS, 1)
		local b = shownTabs()[1]
		local function measure()
			local _, _, _, x = b.Range:GetPoint(1)
			return { range = b.Range:IsShown() and b.Range:GetText(), rangeWhole = b.Range:GetStringWidth() == b.Range:GetUnboundedStringWidth(),
				titleCut = b.Label:IsShown() and b.Label:GetStringWidth() < b.Label:GetUnboundedStringWidth(),
				right = 9 + 12 + x + b.Range:GetStringWidth(), width = b:GetWidth() }
		end
		local rest = measure()
		stub.RunScript(b, "OnEnter")
		local hover = measure()
		stub.RunScript(b, "OnLeave")
		emit({ rest = rest, hover = hover, after = measure() })"#)
	.remove(0);
	// The close button shows at rest now (faintly), so the label clears it in every state.
	for (state, pad) in [("rest", 20.0), ("hover", 20.0), ("after", 20.0)] {
		let m = &out[state];
		assert_eq!(m["range"], "(1–13)", "{state}");
		assert_eq!(m["rangeWhole"], true, "{state}: the range is not cut");
		assert_eq!(m["titleCut"], true, "{state}: the title truncates instead");
		assert!(f(&m["right"]) <= f(&m["width"]) - pad, "{state}: the range ends {} inside {}", m["right"], f(&m["width"]) - pad);
	}
}

// The skins' design review (0.3.8): in the game looks a narrow tab's title and range ran up to its close, 3 units
// short of the red button. Its text ends 6 clear of the close's ink in every one (Blizzard's close is now its
// glyph, as the damage meter's header buttons are), and Classic's red button rests at full strength, not faded to
// mud; the others keep the house's faint rest.
#[test]
fn in_the_game_looks_a_narrow_tab_s_text_ends_6_clear_of_its_close_and_classic_s_close_rests_whole() {
	let out = run(r#"
		Polestar.Set("ui.width", 300)
		uistub.openTabs(TABS, 1)
		local out = {}
		for _, look in ipairs({ "forever", "blizzard", "classic" }) do
			Polestar.Set("ui.skin", look)
			GF.Render()
			local b = shownTabs()[1]
			local c = b.Close
			-- Along the tab, from its left edge (the stub lays out no frames: the anchors' offsets). The range's
			-- right end: the glyph 9 in and 12 wide, the range its offset right of the glyph.
			local _, _, _, rx = b.Range:GetPoint(1)
			local rangeRight = 9 + 12 + rx + b.Range:GetStringWidth()
			-- The close's right side: its offset from the tab's right (or from its art's host, inset from it).
			local _, rel, _, cx = c:GetPoint(1)
			local hostIn = 0
			if rel ~= b then local _, _, _, hx = rel:GetPoint(2); hostIn = hx end
			local closeRight = b:GetWidth() + cx + hostIn
			-- The close's ink: Blizzard's glyph, else the red button's 14, on the button's middle.
			local ink = look == "blizzard" and c.Icon:GetWidth() or 14
			local inkLeft = closeRight - c:GetWidth() / 2 - ink / 2
			out[look] = { gap = inkLeft - rangeRight, range = b.Range:IsShown(),
				cut = b.Label:IsShown() and b.Label:GetStringWidth() < b.Label:GetUnboundedStringWidth(), rest = c:GetAlpha(),
				glyph = c.Icon:GetAlpha(), at = { rx, cx, hostIn, b:GetWidth(), c:GetWidth(), ink } }
		end
		emit(out)"#)
	.remove(0);
	for look in ["forever", "blizzard", "classic"] {
		let m = &out[look];
		assert_eq!(m["range"], true, "{look}: the range shows");
		assert_eq!(m["cut"], true, "{look}: the title truncates (the tight case)");
		assert!(f(&m["gap"]) >= 6.0, "{look}: the text ends {} before the close's ink: {m}", m["gap"]);
	}
	assert_eq!(out["blizzard"]["glyph"], 1.0, "Blizzard's close is its glyph, as the meter's header buttons are");
	assert_eq!(out["classic"]["rest"], 1.0, "Classic's red button at rest as the game draws it");
	assert!(f(&out["forever"]["rest"]) < 0.6 && f(&out["blizzard"]["rest"]) < 0.6, "the others keep the faint rest");
}

// A look chosen with the window open lays its tabs out at once as a window opened in that look does, not in the
// last look's fonts and sizes until the next redraw: the tabs' places and widths, their titles' cut and fonts, the
// level range's and the close's places, the close's rest. Every look in turn, then the text grown, each against a
// fresh window opened in it (the looks lay their tabs out differently, so the comparison has something to catch).
#[test]
fn a_look_chosen_with_the_window_open_lays_its_tabs_out_as_a_window_opened_in_it_does() {
	const MEASURE: &str = r#"
		local function measure()
			local m = {}
			for i, b in ipairs(shownTabs()) do
				local _, _, _, x = b:GetPoint(1)
				local _, _, _, rx = b.Range:GetPoint(1)
				local _, host, _, cx = b.Close:GetPoint(1)
				m[i] = { x = x, width = b:GetWidth(), height = b:GetHeight(), title = b.Label:IsShown() and b.Label:GetText(),
					titleWidth = b.Label:GetStringWidth(), titleFont = { b.Label:GetFont() }, range = b.Range:IsShown() and rx,
					rangeWidth = b.Range:GetStringWidth(), rangeFont = { b.Range:GetFont() }, close = cx, closeOnTab = host == b,
					closeWidth = b.Close:GetWidth(), closeRest = b.Close:GetAlpha() }
			end
			return m
		end
		Polestar.Set("ui.width", 300)"#;
	let looks = ["forever", "blizzard", "classic", "hearth", "halo", "polestar"];
	let list = looks.map(|l| format!("{l:?}")).join(", ");
	let live = run(&format!(
		r#"{MEASURE}
		uistub.openTabs(TABS, 1)
		local out = {{}}
		for _, look in ipairs({{ {list} }}) do
			Polestar.Set("ui.skin", look)
			out[look] = measure()
		end
		Polestar.Set("ui.textSize", 1.25)
		out.grown = measure()
		emit(out)"#
	))
	.remove(0);
	let fresh = |setting: &str| run(&format!("{MEASURE}\n{setting}\nuistub.openTabs(TABS, 1)\nemit(measure())")).remove(0);
	for look in looks {
		let opened = fresh(&format!("Polestar.Set(\"ui.skin\", {look:?})"));
		assert_eq!(live[look], opened, "{look}: the tabs once it is chosen, against a window opened in it");
	}
	assert_eq!(live["grown"], fresh("Polestar.Set(\"ui.textSize\", 1.25)"), "the text grown with the window open");
	assert_ne!(live["forever"], live["polestar"], "the looks lay their tabs out differently");
	assert_ne!(live["grown"], live["polestar"], "the grown text lays them out differently");
}

#[test]
fn without_the_engine_tabs_api_the_strip_stays_hidden_and_the_navigator_names_the_guide() {
	let out = run_with(
		r#"
		uistub.setGuide(uistub.elwynn, 3)
		emit({ strip = GF.parts.strip:IsShown(), title = GF.parts.nav.Title:IsShown() and GF.parts.nav.Title:GetText(), rows = #visibleRows() })"#,
		"",
		"{ noTabs = true }",
	)
	.remove(0);
	assert_eq!(out, json!({ "strip": false, "title": "Elwynn Forest", "rows": 2 }), "the focus's two open goals");
}

#[test]
fn transparent_mode_no_fills_or_borders_outlined_text_chrome_only_while_the_cursor_is_over_the_window() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local function chromeAlpha()
			local a = {}
			for i, c in ipairs(GF.chrome) do a[i] = c:GetAlpha() end
			return a
		end
		Polestar.Set("ui.style", "transparent")
		local skin = F.psSkin
		local bare = { bg = skin.bg:IsShown(), border = F.psBorder[1]:IsShown(), shadow = F.psShadow:IsShown(), band = GF.parts.band:IsShown() }
		local _, _, flags = GF.parts.person.Name:GetFont()
		local _, _, goalFlags = visibleRows()[1].Text:GetFont()
		local rest = chromeAlpha()
		local steps = false
		for _, c in ipairs(GF.chrome) do if c == GF.parts.nav.Steps then steps = true end end
		local track = GF.parts.line.Track
		local clearTrack = { shown = track:IsShown(), a = select(4, track:GetVertexColor()) }
		F.IsMouseOver = function() return true end
		stub.RunScript(F, "OnEnter")
		stub.advance(0.5)
		local hover = chromeAlpha()
		local watching = GF.IsHovering()
		F.IsMouseOver = function() return false end
		stub.advance(0.5)
		local left = chromeAlpha()
		Polestar.Set("ui.style", "standard")
		local _, _, flagsAfter = GF.parts.person.Name:GetFont()
		emit({ bare = bare, flags = flags, goalFlags = goalFlags, rest = rest, hover = hover, watching = watching, left = left,
			hovering = GF.IsHovering(), restored = { bg = skin.bg:IsShown(), band = GF.parts.band:IsShown(), alpha = chromeAlpha() },
			flagsAfter = flagsAfter, count = #GF.chrome, steps = steps, clearTrack = clearTrack,
			track = select(4, track:GetVertexColor()), progressWash = select(4, Polestar.Theme.Wash("progress")) })"#)
	.remove(0);
	let count = out["count"].as_u64().unwrap() as usize;
	let all = |v: i32| Value::Array(vec![json!(v); count]);
	assert_eq!(out["bare"], json!({ "bg": false, "border": false, "shadow": false, "band": false }));
	assert_eq!(out["flags"], "OUTLINE");
	assert_eq!(out["goalFlags"], "OUTLINE");
	assert_eq!(out["rest"], all(0), "tabs, the navigator, menu and grip are hidden at rest");
	assert_eq!(out["steps"], true, "the step number fades with its chevrons, never alone");
	assert_eq!(out["clearTrack"], json!({ "shown": true, "a": 0.15 }), "the progress track stays as a faint ink line");
	assert_eq!(out["track"], out["progressWash"], "standard style: the house wash");
	assert_eq!(out["hover"], all(1));
	assert_eq!(out["watching"], true);
	assert_eq!(out["left"], all(0), "they fade once the cursor leaves");
	assert_eq!(out["hovering"], false);
	assert_eq!(out["restored"], json!({ "bg": true, "band": true, "alpha": all(1) }));
	assert_eq!(out["flagsAfter"], "");
}

#[test]
fn a_goal_with_alternative_trainers_shows_where_it_is_and_cycles_to_the_next() {
	let out = run(r#"
		uistub.openTabs({ { uistub.tailoring, 1 } }, 1)
		uistub.goal(1, 1).status = "active"
		uistub.update()
		local r = visibleRows()[1]
		local before = { sub = r.Sub:IsShown(), alt = r.Alt:IsShown(), person = GF.parts.person.Name:GetText(), where = GF.parts.person.Where:GetText() }
		stub.RunScript(r, "OnEnter")
		local tip = GameTooltip.lines
		r.Alt:Click()
		local after = visibleRows()[1]
		emit({ before = before, tip = tip, call = lastCall("CycleCandidate"), subject = after.psGoal.subject, sub = after.Sub:IsShown(),
			person = GF.parts.person.Name:GetText(), where = GF.parts.person.Where:GetText(),
			alone = Polestar.UI.GoalSubline(after.psGoal) })"#)
	.remove(0);
	assert_eq!(out["before"], json!({ "sub": false, "alt": true, "person": "Georgio Bolero", "where": "Stormwind City" }), "the person names the zone; the goal does not repeat it");
	assert!(has(&out["tip"], "2 others nearby; the arrow button switches to the next."));
	assert_eq!(out["call"], json!(["CycleCandidate", 1, 1]));
	assert_eq!(out["subject"], "Eldrin");
	assert_eq!(out["sub"], false);
	assert_eq!(out["person"], "Eldrin", "the person follows the chosen trainer");
	assert_eq!(out["where"], "Elwynn Forest");
	assert_eq!(out["alone"], "Elwynn Forest", "without a person above, the goal names its zone");
}

// Vendor is a page too (Nearby.VendorPage): what to buy, each to its nearest
// seller; Back returns to the services.
#[test]
fn the_nearby_menu_opens_the_vendor_page_a_pick_goes_to_the_nearest_seller_of_it_back_returns() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local B = GF.nearbyButton
		local function rows()
			local out = {}
			for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then out[#out + 1] = r end end
			return out
		end
		local function pick(text)
			for _, r in ipairs(rows()) do if r.Text:GetText() == text then r:Click() return r end end
		end
		B:Click()
		pick("Vendor  \226\128\186")
		local page = {}
		for _, r in ipairs(rows()) do page[#page + 1] = r.Text:GetText() end
		pick("Arrows")
		local go = lastCall("NearbyGo")
		B:Click()
		pick("Vendor  \226\128\186")
		pick("Nearest")
		local nearest = lastCall("NearbyGo")
		B:Click()
		pick("Vendor  \226\128\186")
		pick("Back")
		emit({ page = page, go = go, nearest = nearest, back = rows()[1].Text:GetText() })"#)
	.remove(0);
	assert_eq!(out["page"], json!(["Back", "Nearest", "Food & drink", "Arrows"]));
	assert_eq!(out["go"], json!(["NearbyGo", "arrows"]));
	assert_eq!(out["nearest"], json!(["NearbyGo", "vendor"]));
	assert_eq!(out["back"], "Vendor  \u{203a}");
}

#[test]
fn the_nearby_menu_opens_a_page_of_weapons_known_ones_and_those_not_yet_at_this_level_are_off_a_pick_goes_to_the_master_back_returns() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local B = GF.nearbyButton
		local function rows()
			local out = {}
			for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then out[#out + 1] = r end end
			return out
		end
		local function pick(text)
			for _, r in ipairs(rows()) do if r.Text:GetText() == text then r:Click() return r end end
		end
		B:Click()
		pick("Weapon master  \226\128\186")
		local page = {}
		for _, r in ipairs(rows()) do page[#page + 1] = { r.Text:GetText(), r.psItem.disabled and true or false } end
		pick("Daggers (known)")
		local stillOpen = PolestarMenu:IsShown()
		pick("Swords")
		local go = lastCall("NearbyGo")
		B:Click()
		pick("Weapon master  \226\128\186")
		pick("Back")
		local back = rows()[1].Text:GetText()
		emit({ page = page, stillOpen = stillOpen, go = go, back = back })"#)
	.remove(0);
	assert_eq!(out["page"], json!([["Back", false], ["Swords", false], ["Daggers (known)", true], ["Polearms (from level 20)", true]]));
	assert_eq!(out["stillOpen"], true, "a weapon already known does nothing");
	assert_eq!(out["go"], json!(["NearbyGo", "weapon", 43]));
	assert_eq!(out["back"], "Vendor  \u{203a}", "Back shows the services again");
}

#[test]
fn on_the_way_to_a_nearby_service_a_banner_and_the_nearby_menu_offer_the_way_back_to_the_guide() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local B = GF.parts.banner
		local before = B:IsShown()
		uistub.trip = { name = "Innkeeper Farley", label = "Innkeeper" }
		Polestar.Fire("NAV_TRIP", uistub.trip)
		local shown = { B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText(), B.Close:IsShown() }
		GF.nearbyButton:Click()
		local first = PolestarMenu.rows[1].Text:GetText()
		W.HideMenu()
		B.Jump:Click()
		local ended = lastCall("EndTrip") ~= nil
		emit({ before = before, shown = shown, first = first, ended = ended, after = B:IsShown() })"#)
	.remove(0);
	assert_eq!(out["before"], false);
	assert_eq!(out["shown"], json!([true, "On the way to Innkeeper Farley (Innkeeper).", "Back to the guide", false]));
	assert_eq!(out["first"], "Back to the guide");
	assert_eq!(out["ended"], true);
	assert_eq!(out["after"], false, "the banner goes with the trip");
}

#[test]
fn guide_outleveled_a_dismissible_banner_offers_the_better_guide_in_the_same_tab() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local h0 = F:GetHeight()
		Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall")
		local shown = { B:IsShown(), B.Jump.Label:GetText(), F:GetHeight() > h0 }
		shownTabs()[2]:Click()
		local otherTab = B:IsShown()
		shownTabs()[1]:Click()
		local back = B:IsShown()
		B.Close:Click()
		local dismissed = B:IsShown()
		Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall")
		B.Jump:Click()
		emit({ shown = shown, otherTab = otherTab, back = back, dismissed = dismissed, jump = lastCall("SetGuide"),
			after = B:IsShown(), header = GF.parts.nav.Title:GetText(), tabs = #shownTabs() })"#)
	.remove(0);
	assert_eq!(out["shown"], json!([true, "Jump to Westfall", true]));
	assert_eq!(out["otherTab"], false, "only on the out-levelled guide");
	assert_eq!(out["back"], true);
	assert_eq!(out["dismissed"], false);
	assert_eq!(out["jump"], json!(["SetGuide", "forever/alliance/02-westfall"]));
	assert_eq!(out["after"], false);
	assert_eq!(out["header"], "Westfall");
	assert_eq!(out["tabs"], 3, "the jump replaced the guide in its tab");
}

#[test]
fn non_leveling_guides_name_their_category_and_a_place_only_when_the_guide_has_a_faction() {
	let out = run(r#"
		uistub.openTabs({ { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 }, { "forever/professions/first-aid", 1 } }, 1)
		local metas = {}
		for i = 1, 3 do
			shownTabs()[i]:Click()
			metas[i] = GF.parts.nav.psMeta
		end
		emit(metas)"#)
	.remove(0);
	assert_eq!(out, json!(["Professions  \u{b7}  Levels 5\u{2013}60", "Reputation  \u{b7}  Stormwind City  \u{b7}  Levels 12\u{2013}60", "Professions  \u{b7}  Levels 5\u{2013}60",]));
}

#[test]
fn guide_lookup_button_follows_toolbar_skin_and_transparent_chrome_1528() {
	let out = run(r#"
		local nav = GF.parts.nav
		local B = nav.Lookup
		assert(type(B) == "table", "the guide window has a Lookup button")
		local function relOf(f) local _, rel = f:GetPoint(1) return rel end
		local empty = { shown = B:IsShown(), lookup = relOf(B) == nav.Menu, nearby = relOf(nav.Nearby) == B }
		uistub.setGuide(uistub.elwynn, 3)
		local order = { lookup = relOf(B) == nav.Menu, report = relOf(nav.Report) == B, nearby = relOf(nav.Nearby) == nav.Report }
		local sizes = {}
		Polestar.Theme._testShowHidden = true
		for _, skin in ipairs(Polestar.Theme.SkinChoices()) do
			Polestar.Set("ui.skin", skin.value)
			sizes[#sizes + 1] = { B:GetWidth() == nav.Menu:GetWidth(), B:GetHeight() == nav.Menu:GetHeight(), B.Icon:GetWidth() == nav.Menu.Icon:GetWidth() }
		end
		Polestar.Set("ui.skin", "polestar")
		Polestar.Set("ui.style", "transparent")
		local rest = B:GetAlpha()
		F.IsMouseOver = function() return true end
		stub.RunScript(B, "OnEnter")
		stub.advance(.5)
		local hover = B:GetAlpha()
		local tip = GameTooltip.lines
		Polestar.Set("ui.compact", true)
		local compact = B:IsShown()
		Polestar.Set("ui.width", 260)
		local narrow = { lookup = B:IsShown(), title = nav.Title:IsShown() }
		Polestar.Set("ui.width", 340)
		local wide = nav.Title:IsShown()
		emit({ empty = empty, order = order, sizes = sizes, rest = rest, hover = hover, tip = tip, compact = compact, narrow = narrow, wide = wide })"#)
	.remove(0);
	assert_eq!(out["empty"], json!({ "shown": true, "lookup": true, "nearby": true }));
	assert_eq!(out["order"], json!({ "lookup": true, "report": true, "nearby": true }));
	assert_eq!(out["sizes"].as_array().unwrap().len(), 6);
	assert!(out["sizes"].as_array().unwrap().iter().all(|s| s == &json!([true, true, true])), "the button follows every skin's metrics");
	assert_eq!(out["rest"], 0);
	assert_eq!(out["hover"], 1);
	assert!(has(&out["tip"], "Lookup"));
	assert_eq!(out["compact"], true);
	assert_eq!(out["narrow"], json!({ "lookup": true, "title": false }), "the narrow compact title cannot overlap the controls");
	assert_eq!(out["wide"], true, "the guide title returns when it has room");
}

#[test]
fn the_header_carries_nearby_services_between_skip_and_the_bug_its_menu_points_the_arrow_nothing_in_combat_and_an_option_hides_it() {
	let out = run(r#"
		local nav, B = GF.parts.nav, GF.nearbyButton
		local function rows()
			local out = {}
			for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then out[#out + 1] = r end end
			return out
		end
		local function texts()
			local out = {}
			for _, r in ipairs(rows()) do out[#out + 1] = r.Text:GetText() end
			return out
		end
		local function relOf(f) local _, rel = f:GetPoint(1) return rel end
		local noGuide = { shown = B:IsShown(), rel = relOf(B) == nav.Lookup }
		uistub.setGuide(uistub.elwynn, 3)
		local order = { skip = relOf(nav.Skip) == B, nearby = relOf(B) == nav.Report, report = relOf(nav.Report) == nav.Lookup }
		B:Click()
		local items = texts()
		for _, r in ipairs(rows()) do if r.Text:GetText() == "Mining trainer" then r:Click() end end
		local mining = lastCall("NearbyGo")
		B:Click()
		for _, r in ipairs(rows()) do if r.Text:GetText() == "Innkeeper" then r:Click() end end
		local inn = lastCall("NearbyGo")
		stub.inCombat = true
		B:Click()
		local disabled = 0
		for _, r in ipairs(rows()) do if not r.psItem.disabled then disabled = disabled + 1 end end
		W.HideMenu()
		stub.inCombat = false
		Polestar.Set("nav.nearbyButton", false)
		local off = B:IsShown()
		-- Off, Skip moves up to the bug, and stays there on the next step.
		local skipOff = { now = relOf(nav.Skip) == nav.Report }
		uistub.setGuide(uistub.elwynn, 4)
		skipOff.nextStep = relOf(nav.Skip) == nav.Report
		Polestar.Set("nav.nearbyButton", true)
		skipOff.backOn = relOf(nav.Skip) == B
		emit({ noGuide = noGuide, order = order, items = items, mining = mining, inn = inn, enabledInCombat = disabled, off = off, skipOff = skipOff })"#)
	.remove(0);
	assert_eq!(out["noGuide"], json!({ "shown": true, "rel": true }), "without a guide it sits by Lookup");
	assert_eq!(out["order"], json!({ "skip": true, "nearby": true, "report": true }), "Skip, Nearby, the bug, Lookup, the menu");
	assert_eq!(out["items"], json!(["Vendor  \u{203a}", "Innkeeper", "Mining trainer", "Weapon master  \u{203a}", "Bank"]));
	assert_eq!(out["mining"], json!(["NearbyGo", "trainer", 186]));
	assert_eq!(out["inn"], json!(["NearbyGo", "innkeeper"]));
	assert_eq!(out["enabledInCombat"], 0, "in combat every entry is off");
	assert_eq!(out["off"], false);
	assert_eq!(out["skipOff"], json!({ "now": true, "nextStep": true, "backOn": true }), "with the button off, Skip sits by the bug");
}

#[test]
fn the_header_menu_picker_new_tab_compact_transparent_lock_destructive_items_ask_twice() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		GF.menuButton:Click()
		local items = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then items[#items + 1] = r.Text:GetText() end end
		GF.menuButton:Click()
		menuPick("Lock window")
		menuPick("Transparent")
		local style = Polestar.Get("ui.style")
		local reset = menuPick("Reset guide progress")
		local armed = { label = reset.Text:GetText(), open = PolestarMenu:IsShown() }
		reset:Click()
		menuPick("Choose guide")
		local picker = PolestarPicker:IsShown()
		menuPick("Options")
		emit({ items = items, locked = Polestar.Get("ui.locked"), style = style, armed = armed, reset = lastCall("ResetProgress"),
			picker = picker, options = PolestarOptions:IsShown(), pickerAfter = PolestarPicker:IsShown() })"#)
	.remove(0);
	assert_eq!(
		out["items"],
		json!([
			"Choose guide",
			"Open in new tab",
			"Skip this step",
			"Report a problem",
			"Compact mode",
			"Transparent",
			"Lock window",
			"Reset guide progress",
			"Quick settings",
			"Options",
			"Pause",
			"Hide window"
		])
	);
	assert_eq!(out["locked"], true);
	assert_eq!(out["style"], "transparent");
	assert_eq!(out["armed"], json!({ "label": "Click again to confirm", "open": true }));
	assert_eq!(out["reset"], json!(["ResetProgress"]));
	assert_eq!(out["picker"], true);
	assert_eq!(out["options"], true);
	assert_eq!(out["pickerAfter"], true, "the settings window is a window of its own: the guide menu stays");
}

#[test]
fn the_menu_offers_the_quest_log_cleanup_with_its_count_and_hides_it_when_there_is_nothing_to_clean() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local list = { { quest = 77, title = "Stray", status = "unplanned" }, { quest = 78, title = "Old", status = "grey" } }
		Polestar.RoutePlan.Unneeded = function() return list end
		local function items()
			GF.menuButton:Click()
			local out = {}
			for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then out[#out + 1] = r.Text:GetText() end end
			GF.menuButton:Click()
			return out
		end
		local two = items()
		local before = PolestarQuestRoom and PolestarQuestRoom:IsShown() or false
		menuPick("Clean up quest log (2)")
		local opened = PolestarQuestRoom and PolestarQuestRoom:IsShown() or false
		PolestarQuestRoom:Hide()
		list = {}
		local none = items()
		Polestar.RoutePlan.Unneeded = function() return nil end
		emit({ two = two, before = before, opened = opened, none = none, unsettled = items() })"#)
	.remove(0);
	assert_eq!(out["two"][4], "Clean up quest log (2)", "right after Report a problem");
	assert_eq!(out["before"], false);
	assert_eq!(out["opened"], true, "the entry opens the cleanup window");
	for key in ["none", "unsettled"] {
		assert!(!joined(&out[key]).contains("Clean up quest log"), "{key}: no entry with nothing to list");
	}
}

// The catch-up (GUIDE_PLACED, fired for a guide just opened): the window shows each step before the one placed
// in turn, in full, then that one; not for a single step. The Engine's step never moves.
#[test]
fn the_catch_up_shows_every_step_up_to_the_one_placed_each_time_a_guide_opened_is_placed() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 4)
		local nav, Count = GF.parts.nav, GF.parts.nav.Steps.Count
		Polestar.Fire("GUIDE_PLACED", uistub.elwynn, 4, {})
		local rolling = { GF.catchingUp, GF.ShownStep() }
		stub.advance(0.6)
		GF.Render()
		local mid = { count = Count:GetText(), shown = GF.ShownStep(), engine = Polestar.Engine.GetStepIndex() }
		stub.advance(3)
		local done = { GF.catchingUp or false, Count:GetText(), GF.parts.card:GetAlpha(), GF.ShownStep() }
		Polestar.Fire("GUIDE_PLACED", uistub.elwynn, 4, {})
		local again = GF.catchingUp ~= nil
		stub.advance(3)
		Polestar.Fire("GUIDE_PLACED", uistub.elwynn, 2, {})
		local single = GF.catchingUp ~= nil
		emit({ rolling = rolling, mid = mid, done = done, again = again, single = single })"#)
	.remove(0);
	assert_eq!(out["rolling"], json!(["steps", 1]), "it starts on step 1");
	let shown = f(&out["mid"]["shown"]);
	assert!((1.0..=3.0).contains(&shown), "a step gone over is shown in full ({})", out["mid"]["shown"]);
	let total = text(&out["done"][1]).split(" / ").nth(1).unwrap_or("");
	assert_eq!(out["mid"]["count"], format!("{} / {}", out["mid"]["shown"], total).as_str());
	assert_eq!(out["mid"]["engine"], 4, "the Engine stays on the step placed");
	assert_eq!(out["done"][0], false);
	assert!(is_match(text(&out["done"][1]), r"^4 / \d+$"));
	assert_eq!(out["done"][2], 1);
	assert_eq!(out["done"][3], 4);
	assert_eq!(out["again"], true, "the guide opened again: it goes over the steps again");
	assert_eq!(out["single"], false, "a single step passed: nothing rolls");
}

fn by_t<'a>(rows: &'a Value, t: &str) -> Vec<&'a Value> {
	rows.as_array().unwrap().iter().filter(|r| r["t"] == t).collect()
}

#[test]
fn profession_reputation_and_achievement_goals_own_colours_icons_progress_bars() {
	let out = run(r#"
		local function snapshot()
			local out = {}
			for _, r in ipairs(visibleRows()) do
				local b = r.psBar
				local bar = b and b:IsShown() and {
					label = b.Label:IsShown() and b.Label:GetText() or false,
					frac = b.Fill:GetWidth() / b.Track:GetWidth(),
				} or false
				local text = r.Text:GetText()
				out[#out + 1] = { t = r.psGoal.t, icon = r.Icon:GetTexture():match("([%w-]+)$"), text = text,
					progress = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):match("(%d+/%d+)$") or false, bar = bar, h = r:GetHeight() }
			end
			return out
		end
		uistub.setGuide(uistub.tailoring, 2)
		emit(snapshot())
		uistub.setGuide(uistub.stormwindRep, 2)
		emit(snapshot())
		local s = {}
		local hex = {}
		for _, k in ipairs({ "skill", "spell", "faction", "area", "achievement" }) do hex[k] = Polestar.Theme.Hex(k) end
		s.hex = hex
		stub.RunScript(rowFor("Stormwind"), "OnEnter")
		s.tip = GameTooltip.lines
		emit(s)"#);
	let (prof, rep_rows, rep) = (&out[0], &out[1], &out[2]);
	let crafts = by_t(prof, "craft");
	let (until_rank, counted) = (crafts[0], crafts[1]);
	assert_eq!(until_rank["icon"], "icon-craft");
	assert_eq!(until_rank["progress"], false, "a skill rank reads as a bar, not a bare number");
	assert_eq!(until_rank["bar"]["label"], "Tailoring  38/50");
	assert!((f(&until_rank["bar"]["frac"]) - 38.0 / 50.0).abs() < 0.01);
	assert!(f(&until_rank["h"]) > f(&counted["h"]), "the bar adds a line");
	assert_eq!(counted["progress"], "1/3");
	assert_eq!(counted["bar"], false);
	let skill = by_t(prof, "skill")[0];
	assert_eq!(skill["icon"], "icon-skill");
	assert_eq!(skill["bar"]["label"], "38/75");
	assert!(is_match(text(&until_rank["text"]), &format!(r"^Craft \|c{}Bolt of Linen Cloth\|r$", text(&rep["hex"]["spell"]))), "ranks count on their bar only");
	let standing = by_t(rep_rows, "rep")[0];
	assert_eq!(standing["icon"], "icon-rep");
	assert_eq!(standing["bar"]["label"], "Friendly  2150/6000");
	let achieve = by_t(rep_rows, "achieve")[0];
	assert_eq!(achieve["progress"], "3/5");
	assert!((f(&achieve["bar"]["frac"]) - 0.6).abs() < 0.01);
	let hexes: HashSet<String> = rep["hex"].as_object().unwrap().values().map(|v| v.to_string()).collect();
	assert!(hexes.len() == 5, "each new subject kind has its own colour");
	assert!(has(&rep["tip"], "Reputation | Friendly  2150/6000  \u{203A}  Honored"));
}

#[test]
fn xp_pace_from_the_qol_tracker_rate_and_time_to_level_hidden_when_off_or_maxed() {
	let out = run(r#"
		local stats = { rate = 3400, timeToLevel = 3900, maxed = false }
		Polestar.QoL = {
			GetXPStats = function() return stats end,
			Duration = function(s) return string.format("%dh %02dm", math.floor(s / 3600), math.floor(s % 3600 / 60)) end,
			XP = { Short = function(n) return string.format("%.1fk", n / 1000) end, Summary = function() return "Level 12 45.3%" end },
		}
		uistub.setGuide(uistub.elwynn, 3)
		local h0 = F:GetHeight()
		Polestar.Fire("QOL_XP_UPDATED", stats)
		local xp = GF.xp
		local on = { shown = xp:IsShown(), text = xp.Text:GetText(), taller = F:GetHeight() > h0 }
		stub.RunScript(xp, "OnEnter")
		local tip = GameTooltip.lines
		Polestar.Set("ui.compact", true)
		local compact = xp:IsShown()
		Polestar.Set("ui.compact", false)
		local back = xp:IsShown()
		stats.maxed = true
		Polestar.Fire("QOL_XP_UPDATED", stats)
		local maxed = xp:IsShown()
		Polestar.Fire("QOL_XP_UPDATED", nil)
		Polestar.QoL.GetXPStats = function() return nil end
		Polestar.Fire("QOL_XP_UPDATED", nil)
		emit({ on = on, tip = tip, compact = compact, back = back, maxed = maxed, off = xp:IsShown(), h = F:GetHeight() == h0 })"#)
	.remove(0);
	assert_eq!(out["on"], json!({ "shown": true, "text": "3.4k XP/h  \u{b7}  1h 05m to level", "taller": true }));
	// The hover repeats the whole line (a narrow window cuts it with "...") above the summary.
	assert_eq!(out["tip"], json!(["Experience", "3.4k XP/h  \u{b7}  1h 05m to level", "Level 12 45.3%"]));
	assert_eq!(out["compact"], false);
	assert_eq!(out["back"], true);
	assert_eq!(out["maxed"], false);
	assert_eq!(out["off"], false);
	assert_eq!(out["h"], true);
}

// Boosted Rest and the sleeping bag (QoL/Rest.Parts) on a short line of their own under the XP line, so the pace
// note (which almost always shows) never pushes them out of sight: the row grows by that line, the line fits the
// default window's slot (its width less the paddings and the icon), the hover repeats it, and alone it takes the
// XP line's place. Nothing to say: no line, and no row for it alone.
#[test]
fn xp_row_puts_boosted_rest_and_the_sleeping_bag_on_their_own_line_that_fits_the_default_width() {
	let out = run(r#"
		local stats = { rate = 3400, maxed = false }
		local rest = {}
		Polestar.QoL = {
			GetXPStats = function() return stats end,
			XP = { Short = function(n) return string.format("%.1fk", n / 1000) end, Summary = function() return "Level 12" end },
			Rest = { Parts = function() return rest end },
		}
		local pace = GF.PaceText
		GF.PaceText = function() return "Behind by 1.9 levels: step 97 grinds to level 21.5 (~0h 30m)" end
		uistub.setGuide(uistub.elwynn, 3)
		Polestar.Fire("QOL_REST_UPDATED", true)
		local xp = GF.xp
		local h1 = xp:GetHeight()
		local first = { shown = xp:IsShown(), rest = xp.Rest:IsShown() }
		rest = { "Boosted Rest: 42m", "Sleeping bag: 12m" }
		local fh = F:GetHeight()
		Polestar.Fire("QOL_REST_UPDATED", true)
		local slot = F:GetWidth() - 2 * 14 - 11 - 7
		stub.RunScript(xp, "OnEnter")
		local two = { text = xp.Text:GetText() ~= nil and not xp.Text:GetText():find("Boosted", 1, true), rest = xp.Rest:IsShown() and xp.Rest:GetText(),
			fits = xp.Rest:GetUnboundedStringWidth() <= slot, grew = xp:GetHeight() > h1 and F:GetHeight() > fh, tip = GameTooltip.lines, width = F:GetWidth() }
		stats = nil
		GF.PaceText = function() return nil end
		Polestar.QoL.GetXPStats = function() return nil end
		Polestar.Fire("QOL_REST_UPDATED", false)
		local alone = { shown = xp:IsShown(), text = xp.Text:GetText(), rest = xp.Rest:IsShown(), h = xp:GetHeight() == h1 }
		rest = {}
		Polestar.Fire("QOL_REST_UPDATED", true)
		GF.PaceText = pace
		emit({ first = first, two = two, alone = alone, none = xp:IsShown() })"#)
	.remove(0);
	assert_eq!(out["first"], json!({ "shown": true, "rest": false }), "nothing to say: the XP line alone");
	assert_eq!(out["two"]["width"], 340, "the default window width");
	assert_eq!(out["two"]["text"], true, "not appended to the XP line");
	assert_eq!(out["two"]["rest"], "Boosted Rest: 42m  \u{b7}  Sleeping bag: 12m");
	assert_eq!(out["two"]["fits"], true, "the line fits its slot at the default width");
	assert_eq!(out["two"]["grew"], true, "the row grows by the line");
	assert!(out["two"]["tip"].as_array().unwrap().iter().any(|l| l == "Boosted Rest: 42m  \u{b7}  Sleeping bag: 12m"), "the hover repeats it: {}", out["two"]["tip"]);
	assert_eq!(out["alone"], json!({ "shown": true, "text": "Boosted Rest: 42m  \u{b7}  Sleeping bag: 12m", "rest": false, "h": true }), "alone: in the XP line's place");
	assert_eq!(out["none"], false);
}

// Where the player stands (GF.PaceText over Levels.Pace, whose sums levels.rs checks): always one line, calm
// when on pace (up to a level short: Fitz, 0.3.6, a few bars short is no warning) or when a `level` goal ahead
// grinds the gap, in the warning colour when more than a level short with nothing in the guide making it up;
// grinding time from the tracker's XP an hour when there is one. A hard quest is named only on its own step.
#[test]
fn the_pace_line_says_on_pace_behind_with_a_grind_coming_behind_with_none_and_names_a_quest_too_hard() {
	let out = run(r#"
		local stats = { rate = 3400, maxed = false }
		Polestar.QoL = {
			GetXPStats = function() return stats end,
			Duration = function(s) return string.format("%dh %02dm", math.floor(s / 3600), math.floor(s % 3600 / 60)) end,
			XP = { Short = function(n) return string.format("%.1fk", n / 1000) end, Summary = function() return "" end },
		}
		uistub.setGuide(uistub.elwynn, 3)
		local pace
		Polestar.Levels.Pace = function() return pace end
		local function line(p, s) pace = p; return GF.PaceText(s) or false end
		local out = {}
		out.onPace = line({ target = 20, step = 32, reach = 20.1, bars = 0, short = 0, xp = 0, kind = "goal", live = 30 }, stats)
		out.ahead = line({ target = 24, step = 21, reach = 25.3, bars = 0, short = 0, xp = 0, kind = "end", live = 3 }, stats)
		out.atTop = line({ target = 21, step = 97, reach = 21, bars = 0, short = 0, xp = 0, kind = "end", live = 22 }, stats)
		local grind = { target = 20, step = 32, reach = 18.8, bars = 24, short = 1.2, xp = 1700, kind = "goal", live = 30 }
		out.grind = line(grind, stats)
		out.grindNoRate = line(grind, nil)
		out.bars = line({ target = 18.5, step = 12, reach = 18.2, bars = 6, short = 0.3, xp = 850, kind = "goal", live = 10 }, stats)
		local short = { target = 24, step = 21, reach = 21.6, bars = 48, short = 2.4, xp = 6800, kind = "end", live = 3 }
		out.none = line(short, stats)
		out.noneNoRate = line(short, nil)
		local hard = { target = 24, step = 21, reach = 20.4, bars = 72, short = 3.6, xp = 9000, kind = "end", live = 18,
			hard = { quest = 219, title = "Missing In Action", level = 25, step = 20, reach = 20.06, need = 23, xp = 3400 } }
		out.hard = line(hard, stats)
		out.hardNoRate = line(hard, nil)
		hard.live = 20
		out.hardNow = line(hard, stats)
		-- On pace for the guide's top (a Discord report, Ashenvale & Silverpine 21-22 at 21): the route's own hard
		-- quest, not the character's lag.
		local route = { target = 22, step = 29, reach = 22.5, bars = 0, short = 0, xp = 0, kind = "end", live = 3,
			hard = { quest = 6503, title = "Ashenvale Outrunners", level = 24, step = 4, reach = 21.34, need = 22, xp = 2000 } }
		out.hardOnPace = line(route, stats)
		out.hardOnPaceNoRate = line(route, nil)
		route.live = 4
		out.hardOnPaceNow = line(route, nil)
		pace = grind
		Polestar.Fire("QOL_XP_UPDATED", stats)
		out.row = GF.xp:IsShown() and GF.xp.Text:GetText()
		out.nothing = line(nil, stats)
		out.warn = Polestar.Theme.Hex("warning")
		emit(out)"#)
	.remove(0);
	let warn = |s: &str| format!("|c{}{s}|r", text(&out["warn"]));
	assert_eq!(out["onPace"], "On pace for level 20 by step 32", "on target: calm, as before");
	assert_eq!(out["ahead"], "On pace for level 25.3 by step 21", "past the guide's top: where the route gets you, not the top");
	assert_eq!(out["atTop"], "On pace for level 21 by step 97", "exactly the top: the top");
	// Behind with a `level` goal ahead: how far, and that the guide grinds it there; not a warning.
	assert_eq!(out["grind"], "Behind by 1.2 levels: step 32 grinds to level 20 (≈0h 30m)");
	assert_eq!(out["grindNoRate"], "Behind by 1.2 levels: step 32 grinds to level 20");
	assert_eq!(out["bars"], "On pace for level 18.5 by step 12", "under a level short: on pace, no warning");
	// Behind with no grind step: the guide's end level, and how long to grind on the way.
	assert_eq!(out["none"], warn("Behind by 2.4 levels for level 24 by step 21: grind ≈2h 00m before then").as_str());
	assert_eq!(out["noneNoRate"], warn("Behind by 2.4 levels for level 24 by step 21, and no grind step ahead").as_str());
	// A quest 3+ levels over you is named only on its own step; before it, the plain line.
	assert_eq!(out["hard"], warn("Behind by 3.6 levels for level 24 by step 21: grind ≈2h 38m before then").as_str());
	assert_eq!(out["hardNoRate"], warn("Behind by 3.6 levels for level 24 by step 21, and no grind step ahead").as_str());
	assert_eq!(out["hardNow"], warn("Behind: “Missing In Action” (25) at step 20, you're 20.0; grind ≈1h 00m first").as_str());
	// The same quest with the character on pace for the target: "On pace", calm, the quest only on its step.
	assert_eq!(out["hardOnPace"], "On pace for level 22.5 by step 29");
	assert_eq!(out["hardOnPaceNoRate"], "On pace for level 22.5 by step 29");
	assert_eq!(out["hardOnPaceNow"], "On pace, but “Ashenvale Outrunners” (24) at step 4 is hard: you're 21.3; reach 22 first");
	assert_eq!(out["row"], "3.4k XP/h  \u{b7}  Behind by 1.2 levels: step 32 grinds to level 20 (≈0h 30m)", "one line in the XP row");
	assert_eq!(out["nothing"], false, "no target and no Codex: no line");
}

// A step with work on a quest 3 or more levels above the character says so under its header (Levels.StepHint),
// in a calm colour (Fitz, 0.3.6: never red; players read it as being behind).
#[test]
fn a_step_with_a_quest_well_over_your_level_says_so_under_its_header() {
	let out = run(r#"
		uistub.player.xp, uistub.player.xpMax = 450, 2800
		local kill = uistub.guides[uistub.elwynn].steps[3].goals[3]
		kill.qlvl = 9
		uistub.setGuide(uistub.elwynn, 3)
		local hint = GF.parts.person.Level
		local red = { shown = hint:IsShown(), text = hint:GetText(), color = { hint:GetTextColor() } }
		uistub.setStep(7)
		local none = hint:IsShown()
		emit({ red = red, none = none, calm = { Polestar.Theme.Color("textDim") } })"#)
	.remove(0);
	assert_eq!(out["red"]["shown"], true);
	assert_eq!(out["red"]["text"], "Level 9 quest: you're 4.1", "level 4, 16% in: cut to one place");
	assert_eq!(rgb(&out["red"]["color"]), rgb(&out["calm"]), "5 levels over: calm, never red");
	assert_eq!(out["none"], false, "Echo Ridge's quest has no level known over yours: no line");
}

#[test]
fn goal_lines_render_the_engine_text_author_overrides_and_counts_survive_the_subject_keeps_its_colour() {
	let out = run(r#"
		local UI = Polestar.UI
		local hex = Polestar.Theme.Hex("npc")
		emit({
			override = UI.GoalText({ t = "train", verb = "Learn new spells from", subject = "your class trainer", subjectKind = "text", text = "Learn Charge and Rend", status = "active" }),
			count = UI.GoalText({ t = "kill", verb = "Kill", subject = "Young Wolf", subjectKind = "npc", text = "Kill 5 Young Wolf", status = "active" }),
			note = UI.GoalText({ t = "note", verb = "", subject = "Watch for patrols", subjectKind = "text", text = "Watch for patrols", status = "pending" }),
			plain = UI.GoalText({ t = "talk", verb = "Talk to", subject = "Brother Neals", subjectKind = "npc", status = "active" }),
			done = UI.GoalText({ t = "kill", verb = "Kill", subject = "Young Wolf", subjectKind = "npc", text = "Kill 5 Young Wolf", status = "done" }),
			hex = hex })"#)
	.remove(0);
	let hex = text(&out["hex"]);
	assert_eq!(out["override"], "Learn Charge and Rend");
	assert_eq!(out["count"], format!("Kill 5 |c{hex}Young Wolf|r").as_str());
	assert_eq!(out["note"], "Watch for patrols", "no leading space on notes");
	assert_eq!(out["plain"], format!("Talk to |c{hex}Brother Neals|r").as_str());
	assert_eq!(out["done"], "Kill 5 Young Wolf");
}

#[test]
fn a_dismissed_nav_target_marks_no_row_no_fall_back_to_the_engine_waypoint() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local function marked()
			local n = 0
			for _, r in ipairs(visibleRows()) do if r.Mark:IsShown() then n = n + 1 end end
			return n
		end
		local before = marked()
		Polestar.Nav.GetTarget = function() return nil end
		Polestar.Fire("WAYPOINT_CHANGED", nil)
		emit({ before = before, after = marked() })"#)
	.remove(0);
	assert_eq!(out, json!({ "before": 1, "after": 0 }));
}

#[test]
fn combat_state_is_read_at_login_so_a_reload_mid_fight_still_fades_or_hides_the_window() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: r#"uistub.install()
			stub.inCombat = true
			Polestar.Set("ui.combat", "hide")
			stub.login()
			local hidden = not PolestarGuideFrame:IsShown()
			stub.inCombat = false
			stub.fire("PLAYER_REGEN_ENABLED")
			emit({ hidden = hidden, shown = PolestarGuideFrame:IsShown() })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "hidden": true, "shown": true }));
}

// Through a loading screen into an instance of `kind` ("party", "raid", "pvp", ...), or out of it with nil.
// told(): how many times chat had the one-time "hides in dungeons and battlegrounds" line.
const ENTER: &str = r#"
local function enter(kind)
	uistub.instance = kind
	stub.fire("PLAYER_ENTERING_WORLD", false, false)
end
local function told()
	local n = 0
	for _, m in ipairs(stub.messages) do if m:find("hides in dungeons and battlegrounds", 1, true) then n = n + 1 end end
	return n
end
-- The notices the window's hint put up (Nav/Alerts.lua's ShowNotice), and how often one was taken down.
local notices, noticeHides = {}, 0
Polestar.Nav.alerts = {
	ShowNotice = function(title, line, seconds) notices[#notices + 1] = { title, line, seconds } end,
	HideNotice = function() noticeHides = noticeHides + 1 end,
}
"#;

// Tangens (Discord): healing in Wailing Caverns, the window was in the way the whole run. A profile that never
// touched the setting hides it in a dungeon, a raid, a battleground and an arena, and leaving brings it back.
#[test]
fn in_dungeons_and_battlegrounds_a_fresh_profile_hides_the_window_in_a_dungeon_raid_battleground_and_arena_and_it_comes_back_on_leaving() {
	let out = run(&[
		ENTER,
		r#"
		uistub.setGuide(uistub.elwynn, 3)
		local stored = PolestarDB.settings.ui and PolestarDB.settings.ui.instance
		local hidden = {}
		for _, kind in ipairs({ "party", "raid", "pvp", "arena" }) do
			enter(kind)
			hidden[kind] = not F:IsShown()
			enter(nil)
			hidden[kind .. " left"] = not F:IsShown()
		end
		enter("scenario")
		local scenario = F:IsShown()
		enter(nil)
		emit({ stored = stored or false, hidden = hidden, scenario = scenario, shown = Polestar.Get("ui.shown") })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(
		out,
		json!({ "stored": false, "scenario": true, "shown": true, "hidden": {
			"party": true, "party left": false, "raid": true, "raid left": false, "pvp": true, "pvp left": false, "arena": true, "arena left": false } })
	);
}

// Players who chose "Keep visible" keep it (a stored choice beats the new default); turning it to Hide there hides it at once.
#[test]
fn in_dungeons_and_battlegrounds_a_stored_keep_visible_choice_is_kept_and_the_window_stays() {
	let out = run_with(
		&[
			ENTER,
			r#"
		enter("party")
		local dungeon = F:IsShown()
		enter("pvp")
		local battleground = F:IsShown()
		Polestar.Set("ui.instance", "hide")
		local turnedOn = F:IsShown()
		emit({ dungeon = dungeon, battleground = battleground, turnedOn = turnedOn, told = told() })"#,
		]
		.concat(),
		r#"PolestarDB = { schema = 1, settings = { ui = { instance = "show" } } }"#,
		"",
	)
	.remove(0);
	assert_eq!(out, json!({ "dungeon": true, "battleground": true, "turnedOn": false, "told": 0 }));
}

// While the window waits out an instance, what goes with it (action buttons, party panel, alerts: ns.GuideShown)
// goes too, and comes back with /polestar there.
#[test]
fn in_dungeons_and_battlegrounds_what_goes_with_the_guide_goes_while_it_waits_and_comes_back_with_polestar() {
	let out = run(&[
		ENTER,
		r#"
		local fired = {}
		Polestar.On("GUIDE_SHOWN", function(shown) fired[#fired + 1] = shown end)
		local outside = Polestar.GuideShown()
		enter("pvp")
		local inside = Polestar.GuideShown()
		Polestar.Fire("TOGGLE_FRAME")
		local opened = Polestar.GuideShown()
		enter(nil)
		emit({ outside = outside, inside = inside, opened = opened, left = Polestar.GuideShown(), fired = fired })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out, json!({ "outside": true, "inside": false, "opened": true, "left": true, "fired": [false, true] }));
}

// The first time on the account the window hides itself on the way in, a notice at the top of the screen says
// how to bring it back and one chat line says where the setting is; never again, and never when it did not
// hide (Keep visible, or the window off anyway). Showing the window takes the notice down.
#[test]
fn in_dungeons_and_battlegrounds_the_first_hide_on_the_account_shows_once_how_to_show_it() {
	let line = "The guide window hides in dungeons and battlegrounds. Type /polestar to show it. Change it in Options > Guide > Window.";
	let out = run(&[
		ENTER,
		r#"
		local function last() return (stub.messages[#stub.messages] or ""):gsub("^.-Polestar|r: ", "") end
		Polestar.Set("ui.instance", "show")
		enter("party")
		enter(nil)
		local keptVisible = told()
		Polestar.Set("ui.instance", "hide")
		Polestar.Set("ui.shown", false)
		enter("party")
		enter(nil)
		local windowOff = told()
		Polestar.Fire("SHOW_FRAME")
		enter("party")
		local first, text = told(), last()
		local before = noticeHides
		Polestar.Fire("TOGGLE_FRAME")
		local takenDown = noticeHides > before
		enter(nil)
		enter("pvp")
		enter("raid")
		emit({ keptVisible = keptVisible, windowOff = windowOff, first = first, text = text, after = told(), notices = notices,
			takenDown = takenDown, saved = PolestarDB.instanceHint })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out["notices"][0], json!(["Polestar is hidden here", "Type /polestar to show it.", 12]));
	assert_eq!(out["notices"].as_array().unwrap().len(), 1, "one notice: {}", out["notices"]);
	assert_eq!(out["takenDown"], true, "opening the window there takes the notice down");
	assert_eq!(out, json!({ "keptVisible": 0, "windowOff": 0, "first": 1, "text": line, "after": 1, "notices": out["notices"], "takenDown": true, "saved": true }));
}

#[test]
fn in_dungeons_and_battlegrounds_the_hint_is_not_shown_again_on_an_account_already_hinted() {
	let out =
		run_with(&[ENTER, r#"enter("party"); emit({ hidden = not F:IsShown(), told = told(), notices = #notices })"#].concat(), r#"PolestarDB = { schema = 1, instanceHint = true }"#, "").remove(0);
	assert_eq!(out, json!({ "hidden": true, "told": 0, "notices": 0 }));
}

// Accounts told by the old chat line alone (instanceHideTold) see the on-screen notice once; the old flag goes.
#[test]
fn in_dungeons_and_battlegrounds_an_account_told_by_the_old_chat_line_sees_the_notice_once() {
	let out = run_with(
		&[ENTER, r#"enter("party"); enter(nil); enter("party"); emit({ told = told(), notices = #notices, hint = PolestarDB.instanceHint, old = PolestarDB.instanceHideTold })"#].concat(),
		r#"PolestarDB = { schema = 1, instanceHideTold = true }"#,
		"",
	)
	.remove(0);
	assert_eq!(out, json!({ "told": 1, "notices": 1, "hint": true }));
}

// The how-to names what this player has: the minimap button's menu when the button is on (its click hides or
// shows all of Polestar), the toggle's key when bound, else /polestar; with the gamepad interface (no slash
// commands) never /polestar.
#[test]
fn in_dungeons_and_battlegrounds_the_hint_names_the_minimap_button_the_key_binding_or_polestar() {
	let out = run(r#"
		local key
		function GetBindingKey(action) if action == "POLESTAR_TOGGLE" then return key end end
		local function how(button, k, pad)
			Polestar.Set("maps.minimapButton", button)
			key = k
			local gamepad = Polestar.GamepadUI
			if pad then Polestar.GamepadUI = function() return true end end
			local s = GF.HowToShow()
			Polestar.GamepadUI = gamepad
			return s
		end
		emit({ how(true, "CTRL-P"), how(true, nil), how(false, "CTRL-P"), how(false, nil), how(false, "PAD1", true), how(false, nil, true), how(true, nil, true) })"#)
	.remove(0);
	assert_eq!(
		out,
		json!([
			"Press CTRL-P, or right-click the minimap button and pick Guide window, to show it.",
			"Right-click the minimap button and pick Guide window to show it.",
			"Press CTRL-P or type /polestar to show it.",
			"Type /polestar to show it.",
			"Press PAD1 to show it.",
			"Turn on the minimap button or bind a key to show it.",
			"Right-click the minimap button and pick Guide window to show it.",
		])
	);
}

#[test]
fn in_dungeons_polestar_the_key_binding_or_the_minimap_button_opens_the_window_there_until_you_leave_and_closes_it_again_without_turning_it_off() {
	let out = run(&[
		ENTER,
		r#"
		Polestar.Set("ui.instance", "hide")
		enter("party")
		Polestar.Fire("TOGGLE_FRAME")
		local opened, storedOpen = F:IsShown(), Polestar.Get("ui.shown")
		enter("party")
		local loadingScreen = F:IsShown()
		Polestar.Fire("TOGGLE_FRAME")
		local closed, storedClosed = F:IsShown(), Polestar.Get("ui.shown")
		Polestar.Fire("TOGGLE_FRAME")
		enter(nil)
		local outside = F:IsShown()
		enter("party")
		local nextVisit = F:IsShown()
		emit({ opened = opened, storedOpen = storedOpen, loadingScreen = loadingScreen, closed = closed,
			storedClosed = storedClosed, outside = outside, nextVisit = nextVisit })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out, json!({ "opened": true, "storedOpen": true, "loadingScreen": true, "closed": false, "storedClosed": true, "outside": true, "nextVisit": false }));
}

#[test]
fn in_dungeons_a_guide_picked_there_polestar_show_or_the_show_the_window_switch_opens_the_window_for_the_visit() {
	let out = run(&[
		ENTER,
		r#"
		Polestar.Set("ui.instance", "hide")
		enter("party")
		Polestar.Fire("SHOW_FRAME")
		local shown = F:IsShown()
		enter(nil)
		enter("party")
		Polestar.Set("ui.shown", false)
		Polestar.Set("ui.shown", true)
		emit({ shown = shown, switched = F:IsShown() })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out, json!({ "shown": true, "switched": true }));
}

#[test]
fn in_dungeons_a_window_hidden_by_hand_stays_hidden_after_leaving() {
	let out = run(&[
		ENTER,
		r#"
		Polestar.Set("ui.instance", "hide")
		Polestar.Set("ui.shown", false)
		enter("party")
		enter(nil)
		emit({ shown = F:IsShown(), stored = Polestar.Get("ui.shown") })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out, json!({ "shown": false, "stored": false }));
}

#[test]
fn in_dungeons_a_window_off_on_the_way_in_opened_and_closed_there_with_polestar_stays_off_after_leaving() {
	let out = run(&[
		ENTER,
		r#"
		Polestar.Set("ui.instance", "hide")
		Polestar.Set("ui.shown", false)
		enter("party")
		Polestar.Fire("TOGGLE_FRAME")
		local opened = F:IsShown()
		Polestar.Fire("TOGGLE_FRAME")
		local closed = F:IsShown()
		enter(nil)
		emit({ opened = opened, closed = closed, shown = F:IsShown(), stored = Polestar.Get("ui.shown") })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out, json!({ "opened": true, "closed": false, "shown": false, "stored": false }));
}

#[test]
fn in_dungeons_a_fight_there_does_not_bring_the_window_back_and_in_combat_still_hides_one_opened_by_hand() {
	let out = run(&[
		ENTER,
		r#"
		Polestar.Set("ui.instance", "hide")
		Polestar.Set("ui.combat", "hide")
		enter("party")
		stub.fire("PLAYER_REGEN_DISABLED")
		local fight = F:IsShown()
		stub.fire("PLAYER_REGEN_ENABLED")
		local afterFight = F:IsShown()
		Polestar.Fire("TOGGLE_FRAME")
		stub.fire("PLAYER_REGEN_DISABLED")
		local openedFight = F:IsShown()
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ fight = fight, afterFight = afterFight, openedFight = openedFight, openedAfter = F:IsShown() })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out, json!({ "fight": false, "afterFight": false, "openedFight": false, "openedAfter": true }));
}

#[test]
fn in_dungeons_a_reload_inside_still_hides_the_window() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: r#"uistub.install()
			uistub.instance = "party"
			Polestar.Set("ui.instance", "hide")
			stub.login()
			local hidden = not PolestarGuideFrame:IsShown()
			uistub.instance = nil
			stub.fire("PLAYER_ENTERING_WORLD", false, false)
			emit({ hidden = hidden, shown = PolestarGuideFrame:IsShown() })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "hidden": true, "shown": true }));
}

#[test]
fn an_unavailable_quest_stays_readable_but_muted_says_why_and_drops_its_counters_and_arrow_mark() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 3)
		g.status, g.unavailable, g.unavailableText = "skipped", "pre", "Needs The Demon Seed first"
		uistub.update()
		local r = rowFor("Kobold Vermin")
		local _, _, _, a = r.Text:GetTextColor()
		emit({ text = r.Text:GetText(), detail = r.Sub:GetText(), progress = false, mark = r.Mark:IsShown(),
			color = { r.Text:GetTextColor() }, muted = { Polestar.Theme.Color("textMuted") }, alpha = a,
			fallback = Polestar.UI.GoalDetail({ unavailable = "offer" }) })"#)
	.remove(0);
	assert_eq!(out["text"], "Kill Kobold Vermin", "plain, no subject colour");
	assert_eq!(out["detail"], "Needs The Demon Seed first");
	assert_eq!(out["progress"], false);
	assert_eq!(out["mark"], false);
	assert_eq!(rgb(&out["color"]), rgb(&out["muted"]));
	assert_eq!(out["alpha"], 1, "muted colour, full opacity: still readable");
	assert_eq!(out["fallback"], "Not offered");
}

#[test]
fn a_grey_accept_skip_grey_quests_keeps_says_which_quest_it_opens_on_its_row_and_in_its_tooltip() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 4)
		local g = uistub.goal(4, 2)
		g.keptGrey, g.keptGreyText = 18, "Grey, kept: opens Brotherhood of Thieves"
		uistub.update()
		local r = rowFor("Investigate Echo Ridge")
		emit({ sub = r and r.Sub:GetText() or false, line = Polestar.UI.GoalSubline(g), detail = Polestar.UI.GoalDetail(g),
			plain = Polestar.UI.GoalSubline(uistub.goal(4, 4)) or false })"#)
	.remove(0);
	assert_eq!(out["line"], "Grey, kept: opens Brotherhood of Thieves");
	assert_eq!(out["sub"], out["line"], "shown under the goal in the window");
	assert!(is_match(text(&out["detail"]), r"Grey, kept: opens Brotherhood of Thieves"));
	let plain = match out["plain"].as_str() {
		Some(s) => s.to_string(),
		None => out["plain"].to_string(),
	};
	assert!(!is_match(&plain, r"Grey, kept"));
}

#[test]
fn a_farm_spot_collect_goal_names_its_mobs_their_levels_and_zone_and_cycles_to_the_next_spot() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 4)
		g.npcName, g.lvl, g.alternatives, g.detail = "Young Wolf", { min = 2, max = 4 }, 2, nil
		g.candidates = { { npcName = "Young Wolf", map = 1429, x = 46, y = 38.5 }, { npcName = "Timber Wolf", map = 1429, x = 40, y = 60 } }
		uistub.update()
		local r = rowFor("Tough Wolf Meat")
		local before = { detail = r.Sub:GetText(), alt = r.Alt:IsShown(), progress = r.Text:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):match("(%d+/%d+)$") }
		local elsewhere = Polestar.UI.GoalSubline(r.psGoal, 1453)
		r.Alt:Click()
		emit({ before = before, call = lastCall("CycleCandidate"), elsewhere = elsewhere })"#)
	.remove(0);
	assert_eq!(out["before"], json!({ "detail": "from Young Wolf (lvl 2\u{2013}4)", "alt": true, "progress": "3/8" }), "the zone is already named above the goals");
	assert_eq!(out["elsewhere"], "from Young Wolf (lvl 2\u{2013}4)  \u{b7}  Elwynn Forest", "a spot in another zone names it");
	assert_eq!(out["call"], json!(["CycleCandidate", 3, 4]));
}

#[test]
fn an_area_objective_says_its_mobs_are_all_over_the_area_and_its_row_button_moves_to_the_next_spot() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 3)
		g.spots, g.spread = 12, true
		uistub.update()
		local r = rowFor("Kobold Vermin")
		local before = { sub = r.Sub:GetText(), alt = r.Alt:IsShown() }
		stub.RunScript(r.Alt, "OnEnter")
		local tip = GameTooltip.lines
		r.Alt:Click()
		local collect = Polestar.UI.GoalSubline({ t = "collect", spots = 5, spread = true, status = "active" })
		local camp = Polestar.UI.GoalSubline({ t = "kill", subject = "Kobold Vermin", spots = 3, status = "active" })
		emit({ before = before, tip = tip, call = lastCall("CycleSpot"), collect = collect, camp = camp or false })"#)
	.remove(0);
	assert_eq!(out["before"], json!({ "sub": "Kobold Vermin all over this area: 12 spots", "alt": true }));
	assert!(has(&out["tip"], "Next spot"), "{}", out["tip"]);
	assert_eq!(out["call"], json!(["CycleSpot", 3, 3]));
	assert_eq!(out["collect"], "Found all over this area: 5 spots");
	assert_eq!(out["camp"], false, "a camp (not spread) says nothing extra");
}

// A goal of exact points (#1944: an object's known spawns, `exact` on the goal view) says under it how many
// places the target stands at and that the arrow leads to each; its row button moves to the next.
#[test]
fn a_goal_of_exact_points_says_how_many_known_places_and_that_the_arrow_leads_to_each_1944() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 3)
		g.spots, g.exact = 16, true
		uistub.update()
		local r = rowFor("Kobold Vermin")
		emit({ sub = r.Sub:GetText(), alt = r.Alt:IsShown(),
			one = Polestar.UI.GoalSubline({ t = "collect", spots = 1, exact = true, status = "active" }) or false,
			done = Polestar.UI.GoalSubline({ t = "collect", spots = 9, exact = true, status = "done" }) or false })"#)
	.remove(0);
	assert_eq!(out["sub"], "16 known places: the arrow leads to each in turn");
	assert_eq!(out["alt"], true, "the row's button moves to the next point");
	assert_eq!(out["one"], false, "a single point says nothing more");
	assert_eq!(out["done"], false, "a done goal neither");
}

// The Engine flags a quest started by an item (the collect stands for it, `starterOf`; the accept is `folded`)
// and a "Go to" that names the step (`header`). The window shows one line, the quest, saying how the item is
// got; the header stands for the Go to and carries the arrow's mark.
#[test]
fn a_quest_started_by_a_dropped_item_reads_as_one_line_the_quest_the_go_to_naming_the_step_is_the_header() {
	let out = run(r#"
		local scroll = { item = "Runed Scroll", note = "Aean Swiftriver", source = { name = "Aean Swiftriver", kind = "npc", rank = 2, enemy = true } }
		local fog = { id = "t/fog", pack = "guides", title = "Southern Barrens", minLevel = 20, maxLevel = 30, steps = {
			{ title = "Field of Giants", goals = {
				{ t = "goto", verb = "Go to", subject = "Field of Giants", subjectKind = "place", text = "Go to Field of Giants", header = true, map = 1429, x = 44.7, y = 70.7, status = "active" },
				{ t = "collect", verb = "Collect", subject = "Runed Scroll", subjectKind = "item", item = 10621, note = "Aean Swiftriver", map = 1429, x = 46, y = 70, status = "active",
					starter = scroll, starterOf = 3, source = scroll.source, optional = true },
				{ t = "accept", verb = "Accept", subject = "The Runed Scroll", subjectKind = "quest", quest = 3513, item = 10621, note = "Keep it: Kadrak", folded = true, status = "active", optional = true },
			} },
		} }
		uistub.guides[fog.id] = fog
		uistub.setGuide(fog.id, 1)
		Polestar.Nav.SetTarget(1429, 44.7, 70.7, "Field of Giants")
		uistub.update()
		local rows = {}
		for _, r in ipairs(visibleRows()) do
			rows[#rows + 1] = { text = r.Text:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), sub = r.Sub:GetText(), icon = r.Icon:GetTexture():match("([%w-]+)$"), index = r.psGoal.index }
		end
		local P = GF.parts
		local headerMark = P.person.Mark:IsShown()
		-- With the scroll in the bags the accept stands alone and says to right-click it.
		local g2, g3 = uistub.goal(1, 2), uistub.goal(1, 3)
		g2.status, g2.starter, g2.starterOf, g2.folded = "done", nil, nil, true
		g3.folded, g3.starter = nil, { item = "Runed Scroll", held = true }
		uistub.update()
		local held = {}
		for _, r in ipairs(visibleRows()) do held[#held + 1] = r.Sub:GetText() end
		emit({ rows = rows, header = P.person.Name:GetText(), headerMark = headerMark, held = held })"#)
	.remove(0);
	assert_eq!(
		out["rows"],
		json!([{ "text": "Accept “The Runed Scroll”  optional", "sub": "Runed Scroll: kill Aean Swiftriver (rare elite)  \u{b7}  Keep it: Kadrak", "icon": "icon-accept", "index": 2 }]),
		"one row: the quest, worded as the accept and tagged optional, acting as the collect (index 2)"
	);
	assert_eq!(out["header"], "Field of Giants");
	assert_eq!(out["headerMark"], true, "the arrow on the Go to marks the header");
	assert_eq!(out["held"], json!(["Runed Scroll: in your bags, right-click it  \u{b7}  Keep it: Kadrak"]));
}

// `when group` (Engine.GroupQuestion): the banner asks at the group quest the live step waits on; Skip it is
// the default (the accent link, the gamepad's first focus), Do it with a group the other answer; it cannot be
// dismissed.
const ASK: &str = r#"
		uistub.groupQuestion = { quest = 6284, title = "Arachnophobia" }
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local shown = { B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText(), B.Later:IsShown() and B.Later.Label:GetText(), B.Close:IsShown(), B.Jump.psDefault == true }
		GF.DismissBanner()
		local kept = B:IsShown()"#;

#[test]
fn a_group_quest_banner_asks_skip_it_or_do_it_with_a_group_and_cannot_be_dismissed() {
	let skip = run(&[
		ASK,
		r#"
		B.Jump:Click()
		emit({ shown = shown, kept = kept, call = lastCall("AnswerGroup"), after = B:IsShown(), flag = B.Jump.psDefault or false })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(skip["shown"], json!([true, "Group quest: “Arachnophobia”\nIt needs a group. Skip it and the guide keeps to the solo route.", "Skip it", "Do it with a group", false, true]));
	assert_eq!(skip["kept"], true, "dismissing does not answer");
	assert_eq!(skip["call"], json!(["AnswerGroup", 6284, "skip"]));
	assert_eq!(skip["after"], false);
	assert_eq!(skip["flag"], false, "no default mark once answered");
	let group = run(&[
		ASK,
		r#"
		B.Later:Click()
		emit({ call = lastCall("AnswerGroup"), after = B:IsShown() })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(group, json!({ "call": ["AnswerGroup", 6284, "do"], "after": false }));
}

// Dungeons in the route, Ask me (Engine.DungeonQuestion): the banner asks at the dungeon the live step waits on, Run
// it (the main link, the gamepad's first focus) or Skip it; it cannot be dismissed. Each answer goes to
// Engine.ChooseDungeon for that dungeon.
const DUNGEON_ASK: &str = r#"
		uistub.dungeonQuestion = { map = 36, name = "The Deadmines", quests = 2, runIn = 4 }
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local shown = { B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText(), B.Later:IsShown() and B.Later.Label:GetText(), B.Close:IsShown(), B.Jump.psDefault == true }
		GF.DismissBanner()
		local kept = B:IsShown()"#;

#[test]
fn dungeon_route_ask_banner_offers_run_it_or_skip_it_and_cannot_be_dismissed() {
	let run_it = run(&[
		DUNGEON_ASK,
		r#"
		B.Jump:Click()
		emit({ shown = shown, kept = kept, call = lastCall("ChooseDungeon"), after = B:IsShown() })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(
		run_it["shown"],
		json!([
			true,
			"Dungeon on your way: The Deadmines, for a group of five.\nThe guide picks up 2 quests for it and runs it in about 4 steps.\nSkip it and the guide keeps to the solo route.",
			"Run it",
			"Skip it",
			false,
			true
		])
	);
	assert_eq!(run_it["kept"], true, "dismissing does not answer");
	assert_eq!(run_it["call"], json!(["ChooseDungeon", 36, true]));
	assert_eq!(run_it["after"], false);
	let skip = run(&[
		DUNGEON_ASK,
		r#"
		B.Later:Click()
		emit({ call = lastCall("ChooseDungeon"), after = B:IsShown() })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(skip, json!({ "call": ["ChooseDungeon", 36, false], "after": false }));
}

// At a chosen dungeon's run, outside it (Engine.DungeonRun), the banner's link is "No group? Skip it"
// (Engine.SkipDungeon); the quests kept in the log are named once after, until closed. Inside the instance the
// link is gone. A few steps before a run (Engine.DungeonSoon) the window says to start looking for a group, until
// closed for that dungeon.
#[test]
fn dungeon_route_no_group_skip_it_at_the_run_names_the_quests_kept_soon_says_to_look_for_a_group() {
	let out = run(r#"
		uistub.dungeonRun = { map = 36, name = "The Deadmines" }
		uistub.dungeonKept = { "Oh Brother. . .", "Red Silk Bandanas" }
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local atRun = { B.Text:GetText(), B.Jump.Label:GetText(), B.Close:IsShown(), B.Jump.psDefault == true }
		local realInside = Polestar.Compat.IsInInstance
		Polestar.Compat.IsInInstance = function() return true end
		GF.Layout()
		local inside = B:IsShown() and B.psKind or false
		Polestar.Compat.IsInInstance = realInside
		GF.Layout()
		B.Jump:Click()
		local call = lastCall("SkipDungeon")
		local keptText, keptClose = B:IsShown() and B.Text:GetText(), B.Close:IsShown()
		B.Close:Click()
		local gone = B:IsShown()
		uistub.dungeonRun = nil
		uistub.dungeonSoon = { map = 43, name = "Wailing Caverns", steps = 3 }
		GF.Layout()
		local soon = { B:IsShown(), B.Text:GetText(), B.Jump:IsShown(), B.Close:IsShown() }
		uistub.dungeonSoon = { map = 43, name = "Wailing Caverns", steps = 1 }
		GF.Layout()
		local oneAhead = B.Text:GetText()
		B.Close:Click()
		emit({ atRun = atRun, inside = inside, call = call, kept = keptText, keptClose = keptClose, gone = gone, soon = soon, oneAhead = oneAhead, soonAfter = B:IsShown() })"#)
	.remove(0);
	assert_eq!(
		out["atRun"],
		json!([
			"The Deadmines: a group of five runs it in about an hour.\nNo group? Skip it: the guide goes on with the solo route, and its quests stay in your log.",
			"No group? Skip it",
			false,
			true
		])
	);
	assert_eq!(out["inside"], false, "inside the instance the run's banner is gone");
	assert_eq!(out["call"], json!(["SkipDungeon", 36]));
	assert_eq!(out["kept"], "Kept in your log: “Oh Brother. . .”, “Red Silk Bandanas”\nIf you run it later, the dungeon's page has a hand-in guide for them.");
	assert_eq!(out["keptClose"], true);
	assert_eq!(out["gone"], false);
	assert_eq!(out["soon"], json!([true, "Wailing Caverns in 3 steps: start looking for a group.", false, true]));
	assert_eq!(out["oneAhead"], "Wailing Caverns next: start looking for a group.");
	assert_eq!(out["soonAfter"], false, "closed for this dungeon");
}

#[test]
fn train_due_shows_a_training_banner_after_the_out_levelled_offer_show_takes_the_player_there_on_a_trip_later_dismisses() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local trainer = { npc = 914, npcName = "Ander Germaine", map = 1453, x = 79.6, y = 70.2, z = 96.5 }
		Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall")
		Polestar.Fire("TRAIN_DUE", 12, trainer)
		local first = B.Jump.Label:GetText()
		B.Close:Click()
		local second = { text = B.Text:GetText(), show = B.Jump.Label:GetText(), later = B.Later:IsShown(), close = B.Close:IsShown() }
		B.Jump:Click()
		local target = lastCall("SetTarget")
		local trip = lastCall("StartTrip")
		local afterShow, aimed = { B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText() }, { uistub.target.stop, uistub.target.z }
		B.Jump:Click() -- back to the guide
		Polestar.Fire("TRAIN_DUE", 14, trainer)
		B.Later:Click()
		emit({ first = first, second = second, target = target, trip = trip, aimed = aimed, afterShow = afterShow, afterLater = B:IsShown() })"#)
	.remove(0);
	assert_eq!(out["first"], "Jump to Westfall", "the out-levelled offer goes first");
	assert_eq!(
		out["second"],
		json!({
			"text": "Level 12  \u{b7}  new Warrior skills  \u{b7}  Ander Germaine, Stormwind City",
			"show": "Show",
			"later": true,
			"close": false,
		})
	);
	assert_eq!(out["target"], json!(["SetTarget", 1453, 79.6, 70.2, "Ander Germaine"]));
	assert_eq!(out["aimed"], json!(["trainer", 96.5]), "the trainer's stop kind and height (#180)");
	assert_eq!(out["trip"], json!(["StartTrip", "Ander Germaine", "Class trainer"]), "a trip: it ends at the trainer (#1686)");
	assert_eq!(out["afterShow"], json!([true, "On the way to Ander Germaine (Class trainer).", "Back to the guide"]));
	assert_eq!(out["afterLater"], false);
}

#[test]
fn the_training_banner_says_how_many_steps_ahead_the_guide_trains_the_class_or_that_it_does_not_668() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local trainer = { npc = 914, npcName = "Ander Germaine", map = 1453, x = 79.6, y = 70.2 }
		uistub.trainStop = { 14, "Thunderbrew Distillery" }
		Polestar.Fire("TRAIN_DUE", 12, trainer)
		local ahead = B.Text:GetText()
		uistub.trainStop = { 12 }
		GF.Layout()
		local untitled = B.Text:GetText()
		uistub.trainStop = { false }
		GF.Layout()
		emit({ ahead = ahead, untitled = untitled, none = B.Text:GetText() })"#)
	.remove(0);
	let first = "Level 12  \u{b7}  new Warrior skills  \u{b7}  Ander Germaine, Stormwind City";
	assert_eq!(
		out,
		json!({
			"ahead": format!("{first}\nThe guide trains you in 14 steps (Thunderbrew Distillery)."),
			"untitled": format!("{first}\nThe guide trains you in 12 steps."),
			"none": format!("{first}\nThe guide has no class training ahead."),
		})
	);
}

// A level-18 Tauren at the Crossroads was told "Jen'shan, Durotar" while the guide trains in Orgrimmar in 10
// steps: with the guide's own stop within 10 steps the banner names that and no other trainer, and has no Show.
#[test]
fn with_the_guide_s_training_stop_within_10_steps_the_banner_names_it_and_no_other_trainer() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local jenshan = { npc = 3169, npcName = "Jen'shan", map = 1411, x = 42.5, y = 69 }
		uistub.trainStop = { 10, "Orgrimmar" }
		Polestar.Fire("TRAIN_DUE", 18, jenshan)
		local function seen() return { text = B.Text:GetText(), show = B.Jump:IsShown(), later = B.Later:IsShown() } end
		local near = seen()
		uistub.trainStop = { 1, "Orgrimmar" }
		GF.Layout()
		local here = seen()
		-- 11 steps: the planner's pick, live, over the notice's.
		uistub.trainStop = { 11, "Orgrimmar" }
		uistub.plannerTrainer = { npc = 3171, npcName = "Thotar", map = 1411, x = 51.8, y = 43.5 }
		GF.Layout()
		local far = seen()
		B.Jump:Click()
		emit({ near = near, here = here, far = far, target = lastCall("SetTarget") })"#)
	.remove(0);
	let head = "Level 18  \u{b7}  new Warrior skills";
	assert_eq!(out["near"], json!({ "text": format!("{head}\nThe guide trains you in 10 steps (Orgrimmar)."), "show": false, "later": true }));
	assert_eq!(out["here"], json!({ "text": format!("{head}\nYour guide's current step trains you."), "show": false, "later": true }));
	assert_eq!(out["far"], json!({ "text": format!("{head}  \u{b7}  Thotar, Durotar\nThe guide trains you in 11 steps (Orgrimmar)."), "show": true, "later": true }));
	assert_eq!(out["target"], json!(["SetTarget", 1411, 51.8, 43.5, "Thotar"]));
}

// The player's own word (owner feedback): an optional goal says so in the warning colour and skips in one
// click; Skip in the navigator skips the step with an undo in the banner; a skipped step shown later offers to
// unskip it; looking at another step than the live one offers the way back.
#[test]
fn an_optional_goal_is_tagged_in_the_warning_colour_and_skips_in_one_click_then_reads_skipped_with_an_undo() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 4)
		g.optional = true
		uistub.update()
		local r = rowFor("Tough Wolf Meat")
		local before = { text = r.Text:GetText(), skip = r.Skip:IsShown() and r.Skip.Label:GetText(), check = r.Check:IsShown() }
		r.Skip:Click()
		local call = lastCall("SkipGoal")
		r = rowFor("Tough Wolf Meat")
		local after = { text = r.Text:GetText(), skip = r.Skip:IsShown() and r.Skip.Label:GetText(), check = r.Check:IsShown(),
			icon = r.Icon:GetTexture():match("([%w-]+)$") }
		r.Skip:Click()
		emit({ warning = Polestar.Theme.Hex("warning"), muted = Polestar.Theme.Hex("textMuted"), before = before, call = call, after = after,
			back = rowFor("Tough Wolf Meat").psGoal.status })"#)
	.remove(0);
	let before_text = text(&out["before"]["text"]);
	assert!(before_text.ends_with(&format!("|c{}optional|r", text(&out["warning"]))), "{before_text}");
	assert_eq!(out["before"]["skip"], "Skip");
	assert_eq!(out["before"]["check"], true, "it ticks like any goal");
	assert_eq!(out["call"], json!(["SkipGoal", 3, 4]));
	let after_text = text(&out["after"]["text"]);
	assert!(after_text.ends_with(&format!("|c{}skipped|r", text(&out["muted"]))), "{after_text}");
	assert_eq!(json!([out["after"]["skip"].clone(), out["after"]["check"].clone(), out["after"]["icon"].clone()]), json!(["Undo", false, "skip"]));
	assert_eq!(out["back"], "active", "Undo brings it back");
}

#[test]
fn the_current_goal_is_the_one_the_engine_names_past_the_required_goals_an_optional_one_leads_before_the_area_s_go_to() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local g2, g4 = uistub.goal(3, 2), uistub.goal(3, 4)
		g2.status, g2.header = "active", true
		g4.optional = true
		uistub.goal(3, 3).status = "done"
		uistub.update()
		local accent = Polestar.Theme.Hex("accent")
		local function hex(t) local r, g, b = t:GetVertexColor(); return string.format("ff%02x%02x%02x", r * 255 + 0.5, g * 255 + 0.5, b * 255 + 0.5) end
		emit({ accent = accent, wolf = hex(rowFor("Tough Wolf Meat").Icon), kobold = hex(rowFor("Kobold Vermin").Icon) })"#)
	.remove(0);
	assert_eq!(out["wolf"], out["accent"], "the optional wolf meat is current");
	assert_ne!(out["kobold"], out["accent"]);
}

#[test]
fn skip_in_the_navigator_skips_the_step_shown_and_the_banner_undoes_it() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local N, B = GF.parts.nav, GF.parts.banner
		local shown = { N.Skip:IsShown(), N.Skip.Label:GetText() }
		N.Skip:Click()
		local skipped = { lastCall("Skip"), Polestar.Engine.GetStepIndex(), B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText() }
		B.Jump:Click()
		emit({ shown = shown, skipped = skipped, undo = lastCall("Unskip"), at = Polestar.Engine.GetStepIndex(), banner = B:IsShown() })"#)
	.remove(0);
	assert_eq!(out["shown"], json!([true, "Skip"]));
	assert_eq!(out["skipped"], json!([["Skip"], 4, true, "Skipped Step 3  \u{b7}  Kobold Camp", "Undo"]));
	assert_eq!(out["undo"], json!(["Unskip", 3]));
	assert_eq!(out["at"], 3);
	assert_eq!(out["banner"], false);
}

#[test]
fn looking_at_another_step_than_the_live_one_offers_the_way_back_a_skipped_step_offers_to_unskip_it() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local N, B = GF.parts.nav, GF.parts.banner
		uistub.live = 3
		N.Next:Click()
		local ahead = { B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText() }
		B.Jump:Click()
		local back = lastCall("Goto")
		uistub.live = 4
		uistub.skipped[3] = true
		uistub.setStep(3)
		local skipped = { B.Text:GetText(), B.Jump.Label:GetText(), N.Skip:IsEnabled() }
		B.Jump:Click()
		emit({ ahead = ahead, back = back, skipped = skipped, unskip = lastCall("Unskip") })"#)
	.remove(0);
	assert_eq!(out["ahead"], json!([true, "Looking ahead. The guide is at step 3.", "Back to step 3"]));
	assert_eq!(out["back"], json!(["Goto", 3]));
	assert_eq!(out["skipped"], json!(["You skipped this step.", "Unskip it", false]));
	assert_eq!(out["unskip"], json!(["Unskip", 3]));
}

// Fitz, testing 0.3.3: the "Looking ahead" banner's Dismiss button did nothing (GF.DismissBanner took the banner for
// one that is answered, never dismissed). Dismissed, it stays away on that step; another step brings it back.
#[test]
fn dismiss_closes_the_looking_ahead_banner_for_that_step_and_another_step_brings_it_back() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local N, B = GF.parts.nav, GF.parts.banner
		uistub.live = 3
		N.Next:Click()
		local ahead = { B:IsShown(), B.Close:IsShown() }
		B.Close:Click()
		local dismissed = B:IsShown()
		uistub.update()
		local stays = B:IsShown()
		N.Next:Click()
		local next = B:IsShown() and B.Text:GetText()
		emit({ ahead = ahead, dismissed = dismissed, stays = stays, next = next })"#)
	.remove(0);
	assert_eq!(out["ahead"], json!([true, true]), "the banner and its Dismiss button");
	assert_eq!(out["dismissed"], false, "Dismiss closes it");
	assert_eq!(out["stays"], false, "it stays closed on that step");
	assert_eq!(out["next"], "Looking ahead. The guide is at step 3.", "the next step has its own banner");
}

#[test]
fn the_next_spot_of_an_area_objective_takes_the_arrow_there_over_a_point_picked_by_hand() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local g = uistub.goal(3, 3)
		g.spots, g.spread = 12, true
		uistub.update()
		Polestar.Nav.SetTarget(1429, 50, 50, "By hand")
		rowFor("Kobold Vermin").Alt:Click()
		emit({ cycle = lastCall("CycleSpot"), release = lastCall("ReleaseTarget"), target = Polestar.Nav.GetTarget().label })"#)
	.remove(0);
	assert_eq!(out["cycle"], json!(["CycleSpot", 3, 3]));
	assert_eq!(out["release"], json!(["ReleaseTarget"]));
	assert_ne!(out["target"], "By hand");
}

#[test]
fn labels_kept_in_tables_are_in_the_client_language_the_group_line_and_the_guide_menu_s_tabs() {
	let out = run_with(
		r#"
		UI.ShowPicker()
		local tabs = {}
		for _, b in ipairs(PolestarPicker.tabButtons) do if b:IsShown() then tabs[#tabs + 1] = b.Label:GetText() end end
		emit({ elite = UI.GroupLine({ party = { kind = "elite", rank = 2 } }), tabs = tabs, title = PolestarPicker.Title:GetText() })"#,
		&fake_locale("itIT", &[("Rare elite: group advised", "Rarer Elite: Gruppe empfohlen"), ("Home", "Start"), ("Browse", "Stöbern"), ("Current", "Aktuell"), ("Recent", "Zuletzt")]),
		"",
	)
	.remove(0);
	assert!(is_match(text(&out["elite"]), r"\|c\w+Rarer Elite: Gruppe empfohlen\|r"));
	assert_eq!(out["tabs"], json!(["Start", "Stöbern", "Aktuell", "Zuletzt"]));
	assert_eq!(out["title"], "Start");
}

#[test]
fn an_escort_quest_s_open_goal_says_the_npc_may_have_to_respawn_in_the_dungeon_colour_once_per_card_not_once_done_or_skipped() {
	let out = run(r#"
		local function line(goal, noEscort) return UI.GoalSubline(goal, nil, nil, nil, noEscort) or false end
		local open = { t = "accept", quest = 309, status = "active", escort = true }
		emit({
			open = line(open),
			again = line(open, true),
			hex = Polestar.Theme.Hex("dungeon"),
			done = line({ t = "accept", quest = 309, status = "done", escort = true }),
			skipped = line({ t = "complete", quest = 309, status = "skipped", escort = true }),
			plain = line({ t = "accept", quest = 7, status = "active" }),
			starter = UI.ReadingGoal({ goals = { open } }, { t = "collect", status = "active", starterOf = 1 }).escort,
		})"#)
	.remove(0);
	assert_eq!(out["open"], format!("|c{}Escort: if the NPC is not there, wait for it to respawn|r", text(&out["hex"])).as_str());
	assert_eq!(out["again"], false);
	assert_eq!(out["done"], false);
	assert_eq!(out["skipped"], false);
	assert_eq!(out["plain"], false);
	assert_eq!(out["starter"], true, "an item-started escort reads as its accept, line included");
}

// 0.3.7 (Fitz, option 4A): a dungeon's way in says where to find a group, with the player's key for the client's group
// finder (TOGGLEGROUPFINDER) as the client names it, else without a key; once per card, never once done, inside an
// instance or in a full party.
#[test]
fn a_dungeon_entrance_says_need_a_group_with_the_group_finder_key_not_inside_or_in_a_full_party() {
	let out = run(r#"
		local key, inside, members = "I", false, 0
		function GetBindingKey(action) if action == "TOGGLEGROUPFINDER" then return key end end
		function GetBindingText(k) return k == "CTRL-G" and "Ctrl-G" or k end
		function IsInInstance() return inside end
		function GetNumSubgroupMembers() return members end
		local function line(goal, noFinder) return UI.GoalSubline(goal, nil, nil, nil, nil, noFinder) or false end
		local enter = { t = "goto", text = "Enter Wailing Caverns", status = "active", entrance = true }
		local out = { hex = Polestar.Theme.Hex("dungeon"), open = line(enter), again = line(enter, true),
			done = line({ t = "goto", status = "done", entrance = true }), plain = line({ t = "goto", status = "active" }) }
		members = 3; out.three = line(enter)
		members = 4; out.full = line(enter)
		members = 0; inside = true; out.inside = line(enter)
		inside = false; key = "CTRL-G"; out.named = line(enter)
		key = nil; out.unbound = line(enter)
		emit(out)"#)
	.remove(0);
	let hex = text(&out["hex"]).to_string();
	assert_eq!(out["open"], format!("|c{hex}Need a group? Press I for the group finder.|r").as_str());
	assert_eq!(out["three"], out["open"], "a party of four still may want a fifth");
	assert_eq!(out["named"], format!("|c{hex}Need a group? Press Ctrl-G for the group finder.|r").as_str());
	assert_eq!(out["unbound"], format!("|c{hex}Need a group? Open the group finder.|r").as_str());
	for k in ["again", "done", "plain", "full", "inside"] {
		assert_eq!(out[k], false, "{k}: {out}");
	}
}

#[test]
fn a_collect_whose_line_already_names_its_source_has_no_source_line_under_it_author_text_keeps_it() {
	let out = run(r#"
		local src = { name = "Grell", also = "Grellkin", kind = "npc", enemy = true }
		local named = { t = "collect", text = "Kill Grell or Grellkin for Fel Moss", subject = "Fel Moss", status = "active", source = setmetatable({ inText = true }, { __index = src }) }
		local authored = { t = "collect", text = "Get the moss", subject = "Fel Moss", status = "active", source = src }
		emit({ named = UI.GoalSubline(named) or false, authored = UI.GoalSubline(authored) or false })"#)
	.remove(0);
	assert_eq!(out["named"], false);
	assert_eq!(out["authored"], "Kill Grell or Grellkin");
}

#[test]
fn a_quest_to_complete_reads_as_its_objectives_each_with_its_count_and_keeps_its_note_under_it() {
	let out = run(r#"
		local goal = { t = "complete", quest = 747, status = "active", progress = { cur = 3, max = 14, kind = "count" },
			objectiveLines = { { text = "Plainstrider Meat", cur = 3, max = 7 }, { text = "Plainstrider Feathers", cur = 0, max = 7 } }, note = "Plainstriders roam the grass" }
		local function plain(s) return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
		emit({ line = plain(UI.GoalLine(goal)), sub = UI.GoalSubline(goal) })"#)
	.remove(0);
	assert_eq!(out["line"], "Plainstrider Meat  3/7\nPlainstrider Feathers  0/7", "#942: the objectives are the goal's line, not the sum");
	assert_eq!(out["sub"], "Plainstriders roam the grass");
}

// "Up next" on a finished guide is where the hand-off goes now (Engine.NextGuide): the remembered or only option
// offered, none when no `next` option is offered (one with `when` that does not hold).
#[test]
fn guide_complete_up_next_names_where_the_hand_off_goes_now_and_asks_for_a_guide_when_none_is_offered() {
	let out = run(r#"
		local function state()
			local e = GF.parts.empty
			return { text = e.Text:GetText(), primary = e.Primary:IsShown() and e.Primary.Label:GetText() or false }
		end
		GF.parts.empty.Primary:Click()
		Polestar.Engine.NextGuide = function() return "forever/alliance/03-darkshore" end
		uistub.complete()
		emit(state())
		Polestar.Engine.NextGuide = function() return nil end
		Polestar.Fire("STEP_CHANGED", nil)
		emit(state())"#);
	let (next, none) = (&out[0], &out[1]);
	assert!(is_match(text(&next["text"]), r"Darkshore"));
	assert_eq!(next["primary"], "Continue");
	assert_eq!(*none, json!({ "text": "Nice work. Pick your next guide to keep going.", "primary": "Choose a guide" }));
}

#[test]
fn the_wheel_over_the_step_number_scrubs_through_the_steps_shift_by_ten_back_on_the_live_step_after_a_pause_and_a_click_opens_the_step_list() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		uistub.live = 3
		local hit = GF.parts.nav.Steps.Hit
		local function at() return Polestar.Engine.GetStepIndex() end
		stub.RunScript(hit, "OnMouseWheel", -1)
		local seen = { at() }
		stub.RunScript(hit, "OnMouseWheel", 1); stub.RunScript(hit, "OnMouseWheel", 1)
		seen[#seen + 1] = at()
		stub.advance(4.5)
		seen[#seen + 1] = at()
		stub.keys.shift = true
		stub.RunScript(hit, "OnMouseWheel", -1)
		stub.keys.shift = false
		seen[#seen + 1] = at()
		stub.RunScript(hit, "OnMouseUp", "LeftButton")
		local SL = UI.StepList
		local rows = {}
		for i = 1, SL.n do local r = SL.rows[i]; if r:IsShown() then rows[#rows + 1] = r.psIndex end end
		emit({ seen = seen, rows = rows, list = SL.frame:IsShown(), card = GF.parts.card:IsShown() })
	"#);
	assert_eq!(out[0]["seen"], json!([4, 2, 3, 8]), "down looks on, up back; after the pause the live step; Shift goes ten, to the last");
	assert_eq!((out[0]["list"].clone(), out[0]["card"].clone()), (json!(true), json!(false)), "a click opens the step list in place of the card: {}", out[0]);
	assert_eq!(out[0]["rows"], json!([1, 2, 3, 4, 5, 7, 8]), "every step; step 6 is the Mage's alone and is left out");
}

// #1030 (soulrocha): pointing at the goals' scroll bar and away wakes it without a Lua error. Its OnEnter and OnLeave
// hooks are set in build(), outside the block that holds the local barWake, so they reach it as GF.BarWake; 0.3.3
// to 0.3.5 called a nil global there ("GuideFrame.lua:4294: attempt to call a nil value").
#[test]
fn pointing_at_the_goals_scroll_bar_and_away_wakes_it_without_an_error_1030() {
	let out = run(r#"
		local bar = GF.parts.goals.Bar
		local okEnter, errEnter = pcall(stub.RunScript, bar, "OnEnter")
		local okLeave, errLeave = pcall(stub.RunScript, bar, "OnLeave")
		emit({ enter = okEnter, leave = okLeave, err = tostring(errEnter or errLeave or "") })
	"#);
	assert_eq!(out[0]["enter"], true, "OnEnter: {}", out[0]["err"]);
	assert_eq!(out[0]["leave"], true, "OnLeave: {}", out[0]["err"]);
}

// ---------------------------------------------------------------------------
// The floating button (UI/Launcher.lua)
// ---------------------------------------------------------------------------

// Off by default (no frame); on, beside the window's default corner: click hides or shows all of Polestar (as
// the minimap button does), right-click opens Polestar's menu, a drag moves it anywhere and saves where
// (ui.launcherPos); with Lock arrow and buttons only a Shift-drag does.
#[test]
fn floating_button_off_by_default_on_it_hides_and_shows_polestar_opens_the_menu_and_a_drag_moves_it() {
	let out = run(r#"
		local before = PolestarLauncher ~= nil
		local fired, menu = {}, nil
		Polestar.On("POLESTAR_HIDDEN", function(hidden) fired[#fired + 1] = hidden end)
		Polestar.Maps = { ShowMenu = function(anchor) menu = anchor end, PaintHidden = function() end, ButtonTip = function() end }
		Polestar.Set("ui.launcher", true)
		local b = PolestarLauncher
		local function at() local p, rel, rp, x, y = b:GetPoint(1); return { p, rel == UIParent, rp, x, y } end
		local start, shown = at(), b:IsShown()
		b:Click("LeftButton")
		b:Click("RightButton")
		b.x, b.y = 100, 200
		b:GetScript("OnDragStart")(b)
		local moving = b.moving
		b:GetScript("OnDragStop")(b)
		local saved, moved = Polestar.Get("ui.launcherPos"), at()
		Polestar.Set("ui.lockHud", true)
		b:GetScript("OnDragStart")(b)
		local locked = b.moving
		stub.keys.shift = true
		b:GetScript("OnDragStart")(b)
		local shiftDrag = b.moving
		b:GetScript("OnDragStop")(b)
		stub.keys.shift = false
		Polestar.Set("ui.launcher", false)
		emit({ before = before, start = start, shown = shown, fired = fired, menu = menu == b, moving = moving, saved = saved, moved = moved,
			locked = locked, shiftDrag = shiftDrag, off = not b:IsShown() })"#)
	.remove(0);
	assert_eq!(out["before"], false, "no frame while off");
	assert_eq!(out["start"], json!(["CENTER", true, "TOPRIGHT", -440, -256]), "beside the window's default corner");
	assert_eq!(out["shown"], true);
	assert_eq!(out["fired"], json!([true]), "a click hides Polestar; the button stays, the way back");
	assert_eq!(out["menu"], true, "right-click opens Polestar's menu at the button");
	assert_eq!(out["moving"], true);
	// The 32 x 32 button's centre, from the screen's bottom-left corner.
	assert_eq!(out["saved"], json!([116, 216]));
	assert_eq!(out["moved"], json!(["CENTER", true, "BOTTOMLEFT", 116, 216]));
	assert_eq!(out["locked"], false, "Lock arrow and buttons: a plain drag does nothing");
	assert_eq!(out["shiftDrag"], true, "a Shift-drag still moves it");
	assert_eq!(out["off"], true);
}

// It follows the window's own rules: hidden in a fight when the window hides in combat, hidden in a dungeon or
// battleground the window waits out and back once the player opens the window there or leaves; it stays when
// the window is only faded or kept, and when the player hid the window (it is the way back).
#[test]
fn floating_button_hides_in_combat_and_instances_as_the_window_does_and_stays_when_the_window_is_hidden_by_hand() {
	let out = run(&[
		ENTER,
		r#"
		Polestar.Set("ui.launcher", true)
		local b = PolestarLauncher
		local r = {}
		Polestar.Set("ui.shown", false)
		r.windowHidden = b:IsShown()
		Polestar.Fire("SHOW_FRAME")
		stub.fire("PLAYER_REGEN_DISABLED")
		r.fightShow = b:IsShown()
		stub.fire("PLAYER_REGEN_ENABLED")
		Polestar.Set("ui.combat", "fade")
		stub.fire("PLAYER_REGEN_DISABLED")
		r.fightFade = b:IsShown()
		stub.fire("PLAYER_REGEN_ENABLED")
		Polestar.Set("ui.combat", "hide")
		stub.fire("PLAYER_REGEN_DISABLED")
		r.fightHide = b:IsShown()
		stub.fire("PLAYER_REGEN_ENABLED")
		r.afterFight = b:IsShown()
		enter("party")
		r.dungeon = b:IsShown()
		Polestar.Fire("TOGGLE_FRAME")
		r.openedThere = b:IsShown()
		enter(nil)
		r.left = b:IsShown()
		Polestar.Set("ui.instance", "show")
		enter("pvp")
		r.keepVisible = b:IsShown()
		emit(r)"#,
	]
	.concat())
	.remove(0);
	assert_eq!(
		out,
		json!({ "windowHidden": true, "fightShow": true, "fightFade": true, "fightHide": false, "afterFight": true,
			"dungeon": false, "openedThere": true, "left": true, "keepVisible": true })
	);
}

// 0.3.6: the floating button's hover is the minimap button's, its 25 % in its colour, so nothing
// that sets its regions back to full alpha turns it into an opaque disc over the logo.
#[test]
fn floating_button_hover_is_a_quarter_strong_accent_disc_even_with_its_regions_at_full_alpha() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		local b = PolestarLauncher
		local function strength() local _, _, _, a = b.Hover:GetVertexColor(); return (a or 1) * b.Hover:GetAlpha() end
		local r = { file = b.Hover:GetTexture(), layer = b.Hover:GetDrawLayer(), rest = strength() }
		for _, region in ipairs({ b:GetRegions() }) do region:SetAlpha(1) end
		r.full = strength()
		Polestar.Theme.Refresh()
		r.repainted = strength()
		emit(r)"#);
	let r = &out[0];
	assert!(r["file"].as_str().unwrap().ends_with("Polestar\\Media\\UI\\circle"));
	assert_eq!(r["layer"], "HIGHLIGHT");
	for k in ["rest", "full", "repainted"] {
		assert!((r[k].as_f64().unwrap() - 0.25).abs() < 1e-6, "{k}: {}", r[k]);
	}
}

// #1684's sweep: in the client a texture's SetAlpha and its colour's alpha are one value. A kit showed the house
// glyph of an icon button again with SetAlpha(1) after the theme had coloured it, so a disabled button's 35 % glyph
// drew at full strength; and a glyph a kit hid under its own art (SetAlpha(0)) came back over that art as soon as the
// button recoloured it (the cursor leaving it). Shown, the glyph takes its colour back; hidden, it stays hidden.
#[test]
fn an_icon_button_s_glyph_keeps_its_disabled_strength_and_stays_under_a_kit_s_art() {
	let out = run(r#"
		local function alpha(b) return select(4, b.Icon:GetVertexColor()) end
		local off = W.IconButton(UIParent, "chevron-left", 22)
		W.SetIconState(off, false, false)
		local house = alpha(off)
		Polestar.Theme.Refresh()
		local refreshed = alpha(off)
		Polestar.Set("ui.skin", "classic")
		local arrow = W.IconButton(UIParent, "chevron-left", 22)
		W.SetFramed(arrow, "red")
		W.SetIconState(arrow, false, false)
		local veiled = alpha(arrow)
		stub.RunScript(arrow, "OnLeave")
		local left = alpha(arrow)
		Polestar.Set("ui.skin", "forever")
		local close = W.IconButton(UIParent, "close", 22)
		Polestar.Theme.Refresh()
		stub.RunScript(close, "OnLeave")
		local closeLeft = alpha(close)
		Polestar.Set("ui.skin", "polestar")
		emit({ house = house, refreshed = refreshed, veiled = veiled, left = left, closeLeft = closeLeft, back = alpha(arrow) })"#);
	let r = &out[0];
	assert_eq!(r["house"], 0.35, "a disabled button's glyph at 35 %");
	assert_eq!(r["refreshed"], 0.35, "still 35 % after a theme repaint: {r}");
	assert_eq!(r["veiled"], 0, "Classic's page arrow art stands in for the glyph: {r}");
	assert_eq!(r["left"], 0, "and the glyph stays hidden when the button recolours it: {r}");
	assert_eq!(r["closeLeft"], 0, "a kit's close art: the glyph stays hidden: {r}");
	assert_eq!(r["back"], 0.35, "back in the house style, the disabled arrow's glyph shows at 35 %: {r}");
}

// A layout reads the banner's notice once: GF.Layout's own read decides whether the banner shows and lays it out
// (GF.LayoutBanner), where it was read a second time right after. Each read asks the Engine and the route plan
// (the log's room: Engine.GetStepView, every quest's hand-in) again. The banner reads as before.
#[test]
fn a_layout_reads_the_banner_notice_once_and_the_banner_reads_as_before() {
	let out = run(r#"
		uistub.groupQuestion = { quest = 6284, title = "Arachnophobia" }
		uistub.openTabs(TABS, 1)
		local E = Polestar.Engine
		local asked, ask = 0, E.GroupQuestion
		E.GroupQuestion = function(...) asked = asked + 1; return ask(...) end
		GF.Layout()
		local B = GF.parts.banner
		local r = { asks = asked, shown = { B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText(), B.psKind } }
		uistub.groupQuestion = nil
		asked = 0
		GF.Layout()
		r.none = { asked, B:IsShown() }
		emit(r)
	"#)
	.remove(0);
	assert_eq!(out["asks"], 1, "one read of the notice per layout: {out}");
	assert_eq!(out["shown"], json!([true, "Group quest: “Arachnophobia”\nIt needs a group. Skip it and the guide keeps to the solo route.", "Skip it", "group"]));
	assert_eq!(out["none"], json!([1, false]), "no notice: one read, no banner");
}

// The progress bar's count from Engine.ProgressSoon: while the Engine counts it over the next frames, the bar keeps its
// last count (and a layout lays it out at that count); the count lands through one call, for every ask since.
#[test]
fn the_progress_bar_keeps_its_count_while_the_engine_counts_and_paints_the_new_one_when_it_lands() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local E = Polestar.Engine
		local answer, asked = { 3, 10 }, {}
		E.ProgressSoon = function(fn)
			if answer then return answer[1], answer[2] end
			asked[#asked + 1] = fn
			return nil
		end
		local P = GF.parts
		GF.PaintProgress(false)
		local first = P.foot.Pct:GetText()
		answer = nil
		GF.PaintProgress(true)
		GF.Layout()
		local counting = P.foot.Pct:GetText()
		answer = { 7, 10 }
		asked[1]()
		emit({ first = first, counting = counting, same = asked[1] == asked[2], landed = P.foot.Pct:GetText(), done = P.foot.psDone })
	"#)
	.remove(0);
	assert_eq!(out["first"], "30%");
	assert_eq!(out["counting"], "30%", "the last count while the Engine counts: {out}");
	assert_eq!(out["same"], true, "one painter for every ask: {out}");
	assert_eq!(out["landed"], "70%");
	assert_eq!(out["done"], 7);
}
