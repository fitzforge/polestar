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
				size = select(2, r.Text:GetFont()),
			}
		end
		local P = GF.parts
		emit({ rows = rows, accent = { Polestar.Theme.Accent() }, success = { Polestar.Theme.Color("success") },
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
	assert_eq!(pluck(&out["rows"], "subject"), json!(["the Kobold Camp", "Kobold Vermin", "Tough Wolf Meat"]), "only the focus group: the earlier quest-giver is not listed");
	let rows = out["rows"].as_array().unwrap();
	let (go, kill, collect) = (&rows[0], &rows[1], &rows[2]);
	assert_eq!(go["icon"], "check");
	assert_eq!(go["iconColor"], rgb(&out["success"]));
	assert_eq!(go["textColor"], rgb(&out["muted"]), "done goals dim");
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
fn a_hub_reads_one_person_at_a_time_name_in_npc_colour_only_their_goals_then_the_next_person() {
	let out = run(r#"
		local function snap()
			local P = GF.parts
			local names = {}
			for _, r in ipairs(visibleRows()) do names[#names + 1] = r.psGoal.subject end
			local nr, ng, nb = P.person.Name:GetTextColor()
			return { person = P.person.Name:GetText(), color = { nr, ng, nb }, npc = { Polestar.Theme.Color("npc") },
				icon = P.person.Icon:GetTexture():match("([%w-]+)$"), goals = names,
				after = P.after.Text:GetText(), persons = P.after.Count:GetText(), mark = P.person.Mark:IsShown(),
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
		s.target = lastCall("SetTarget")
		emit(s)"#);
	let (first, second, third) = (&out[0], &out[1], &out[2]);
	assert_eq!(first["person"], "Marshal McBride");
	assert_eq!(first["color"], rgb(&first["npc"]));
	assert_eq!(first["icon"], "icon-talk");
	assert_eq!(first["goals"], json!(["Kobold Camp Cleanup", "Investigate Echo Ridge"]));
	assert!(is_match(text(&first["after"]), r"^Then: \|c[0-9a-f]{8}Eagan Peltskinner\|r$"));
	assert_eq!(first["persons"], "Person 1 of 3");
	assert_eq!(first["mark"], true, "the arrow points at this person");
	assert_eq!(first["markW"], 2, "the 2px selection bar used across Polestar");
	assert_eq!(rgb(&first["iconColor"]), rgb(&first["dim"]), "the person glyph steps back; the name carries the colour");
	assert_eq!(second["person"], "Eagan Peltskinner");
	assert_eq!(second["goals"], json!(["Wolves Across the Border"]));
	assert_eq!(second["persons"], "Person 2 of 3");
	assert_eq!(second["sliding"], true, "the next person slides in");
	assert_eq!(third["person"], "Brother Neals");
	assert_eq!(third["persons"], "Person 3 of 3");
	assert!(is_match(text(&third["after"]), r"^Then: \|c[0-9a-f]{8}Goldshire\|r$"), "after the last person: the next step");
	assert_eq!(third["target"], json!(["SetTarget", 1429, 49.6, 40.4, "Brother Neals"]));
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
fn step_tips_start_open_by_default_with_expand_step_tips_off_on_one_line() {
	let out = run(r#"
		Polestar.Set("ui.width", 300)
		uistub.setGuide(uistub.elwynn, 3)
		local tip = GF.parts.tip
		local byDefault = tip.psOpen
		Polestar.Set("ui.notesOpen", false)
		local closedH = tip:GetHeight()
		local off = tip.psOpen
		Polestar.Set("ui.notesOpen", true)
		local now = tip.psOpen
		tip:Click()
		local clicked = tip.psOpen
		uistub.setStep(4)
		uistub.setStep(3)
		emit({ byDefault = byDefault, off = off, closedH = closedH, now = now, clicked = clicked, next = tip.psOpen, h = tip:GetHeight() })"#)
	.remove(0);
	assert_eq!(out["byDefault"], true, "a new player sees the tip in full");
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
			"banner": "Skipped Investigate Echo Ridge  ·  and the quests that follow from it",
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
	assert_eq!(compact, json!({ "strip": false, "after": false, "tip": false, "rows": 3, "foot": true }), "compact keeps the navigator, the focus goals and the progress bar");
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
		local function at() return { strip = { GF.parts.strip:GetPoint(1) }, foot = { GF.parts.foot:GetPoint(1) }, nav = { GF.parts.nav:GetPoint(1) } } end
		local normal = at()
		Polestar.Set("ui.barsBottom", true)
		local withoutGrow = at()
		Polestar.Set("ui.growUp", true)
		local flipped = at()
		Polestar.Set("ui.barsBottom", false)
		emit({ normal = normal, withoutGrow = withoutGrow, flipped = flipped, back = at() })"#)
	.remove(0);
	let pt = |o: &Value| json!([o["strip"][0].clone(), o["foot"][2].clone(), o["nav"][0].clone()]);
	assert_eq!(pt(&out["normal"]), json!(["TOPLEFT", "BOTTOMLEFT", "TOPLEFT"]), "default: tabs on top, foot at the bottom");
	assert_eq!(pt(&out["withoutGrow"]), json!(["TOPLEFT", "BOTTOMLEFT", "TOPLEFT"]), "without grow upward the option changes nothing");
	assert_eq!(pt(&out["flipped"]), json!(["BOTTOMLEFT", "TOPLEFT", "BOTTOMLEFT"]), "flipped: tabs at the bottom, the navigator and the foot stacked above them");
	assert_eq!(pt(&out["back"]), json!(["TOPLEFT", "BOTTOMLEFT", "TOPLEFT"]), "turning it off restores the order");
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
	for (state, pad) in [("rest", 8.0), ("hover", 20.0), ("after", 8.0)] {
		let m = &out[state];
		assert_eq!(m["range"], "(1–13)", "{state}");
		assert_eq!(m["rangeWhole"], true, "{state}: the range is not cut");
		assert_eq!(m["titleCut"], true, "{state}: the title truncates instead");
		assert!(f(&m["right"]) <= f(&m["width"]) - pad, "{state}: the range ends {} inside {}", m["right"], f(&m["width"]) - pad);
	}
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
	assert_eq!(out, json!({ "strip": false, "title": "Elwynn Forest", "rows": 3 }));
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
	assert_eq!(out["back"], "Vendor", "Back shows the services again");
}

#[test]
fn on_the_way_to_a_nearby_service_a_banner_and_the_nearby_menu_offer_the_way_back_to_the_guide() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		local B = GF.parts.banner
		local before = B:IsShown()
		uistub.trip = { name = "Innkeeper Farley", label = "Innkeeper" }
		Polestar.Fire("NEARBY_TRIP", uistub.trip)
		local shown = { B:IsShown(), B.Text:GetText(), B.Jump.Label:GetText(), B.Close:IsShown() }
		GF.nearbyButton:Click()
		local first = PolestarMenu.rows[1].Text:GetText()
		W.HideMenu()
		B.Jump:Click()
		local ended = lastCall("NearbyEndTrip") ~= nil
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
		local noGuide = { shown = B:IsShown(), rel = relOf(B) == nav.Menu }
		uistub.setGuide(uistub.elwynn, 3)
		local order = { skip = relOf(nav.Skip) == B, nearby = relOf(B) == nav.Report, report = relOf(nav.Report) == nav.Menu }
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
	assert_eq!(out["noGuide"], json!({ "shown": true, "rel": true }), "without a guide it sits by the menu");
	assert_eq!(out["order"], json!({ "skip": true, "nearby": true, "report": true }), "Skip, Nearby, the bug, the menu");
	assert_eq!(out["items"], json!(["Vendor", "Innkeeper", "Mining trainer", "Weapon master  \u{203a}", "Bank"]));
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
		json!(["Choose guide", "Open in new tab", "Skip this step", "Report a problem", "Compact mode", "Transparent", "Lock window", "Reset guide progress", "Options", "Hide window"])
	);
	assert_eq!(out["locked"], true);
	assert_eq!(out["style"], "transparent");
	assert_eq!(out["armed"], json!({ "label": "Click again to confirm", "open": true }));
	assert_eq!(out["reset"], json!(["ResetProgress"]));
	assert_eq!(out["picker"], true);
	assert_eq!(out["options"], true);
	assert_eq!(out["pickerAfter"], false, "one dialog at a time");
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
	assert_eq!(out["tip"], json!(["Experience", "Level 12 45.3%"]));
	assert_eq!(out["compact"], false);
	assert_eq!(out["back"], true);
	assert_eq!(out["maxed"], false);
	assert_eq!(out["off"], false);
	assert_eq!(out["h"], true);
}

#[test]
fn goal_lines_render_the_engine_text_author_overrides_and_counts_survive_the_subject_keeps_its_colour() {
	let out = run(r#"
		local UI = Polestar.UI
		local hex = Polestar.Theme.Hex("npc")
		emit({
			override = UI.GoalText({ t = "train", verb = "Train at", subject = "your trainer", subjectKind = "text", text = "Learn Charge and Rend", status = "active" }),
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
const ENTER: &str = r#"
local function enter(kind)
	uistub.instance = kind
	stub.fire("PLAYER_ENTERING_WORLD", false, false)
end
"#;

#[test]
fn in_dungeons_by_default_the_window_stays_with_hide_it_hides_in_a_dungeon_and_a_raid_and_comes_back_on_leaving_the_show_setting_untouched() {
	let out = run(&[
		ENTER,
		r#"
		uistub.setGuide(uistub.elwynn, 3)
		enter("party")
		local byDefault = F:IsShown()
		enter(nil)
		Polestar.Set("ui.instance", "hide")
		local outside = F:IsShown()
		enter("party")
		local dungeon, stored = F:IsShown(), Polestar.Get("ui.shown")
		enter(nil)
		local left = F:IsShown()
		enter("raid")
		local raid = F:IsShown()
		Polestar.Set("ui.instance", "show")
		local turnedOff = F:IsShown()
		emit({ byDefault = byDefault, outside = outside, dungeon = dungeon, stored = stored, left = left, raid = raid, turnedOff = turnedOff })"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out, json!({ "byDefault": true, "outside": true, "dungeon": false, "stored": true, "left": true, "raid": false, "turnedOff": true }));
}

#[test]
fn in_dungeons_battlegrounds_arenas_and_scenarios_are_not_dungeons_and_the_window_stays() {
	let out = run(&[
		ENTER,
		r#"
		Polestar.Set("ui.instance", "hide")
		local shown = {}
		for _, kind in ipairs({ "pvp", "arena", "scenario" }) do
			enter(kind)
			shown[#shown + 1] = F:IsShown()
		end
		emit(shown)"#,
	]
	.concat())
	.remove(0);
	assert_eq!(out, json!([true, true, true]));
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
		Polestar.Fire("HIDE_FRAME")
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
		Polestar.Fire("HIDE_FRAME")
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
		json!([{ "text": "Accept The Runed Scroll  optional", "sub": "Runed Scroll: kill Aean Swiftriver (rare elite)  \u{b7}  Keep it: Kadrak", "icon": "icon-accept", "index": 2 }]),
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
	assert_eq!(skip["shown"], json!([true, "Group quest: Arachnophobia\nIt needs a group. Skip it and the guide keeps to the solo route.", "Skip it", "Do it with a group", false, true]));
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

#[test]
fn train_due_shows_a_training_banner_after_the_out_levelled_offer_show_points_the_arrow_later_dismisses() {
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
		local afterShow, aimed = B:IsShown(), { uistub.target.stop, uistub.target.z }
		Polestar.Fire("TRAIN_DUE", 14, trainer)
		B.Later:Click()
		emit({ first = first, second = second, target = target, aimed = aimed, afterShow = afterShow, afterLater = B:IsShown() })"#)
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
	assert_eq!(out["afterShow"], false);
	assert_eq!(out["afterLater"], false);
}

#[test]
fn the_training_banner_says_how_many_steps_ahead_the_guide_trains_the_class_or_that_it_does_not_668() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		local B = GF.parts.banner
		local trainer = { npc = 914, npcName = "Ander Germaine", map = 1453, x = 79.6, y = 70.2 }
		uistub.trainStop = { 5, "Thunderbrew Distillery" }
		Polestar.Fire("TRAIN_DUE", 12, trainer)
		local ahead = B.Text:GetText()
		uistub.trainStop = { 2 }
		GF.Layout()
		local untitled = B.Text:GetText()
		uistub.trainStop = { 1, "Thunderbrew Distillery" }
		GF.Layout()
		local here = B.Text:GetText()
		uistub.trainStop = { false }
		GF.Layout()
		emit({ ahead = ahead, untitled = untitled, here = here, none = B.Text:GetText() })"#)
	.remove(0);
	let first = "Level 12  \u{b7}  new Warrior skills  \u{b7}  Ander Germaine, Stormwind City";
	assert_eq!(
		out,
		json!({
			"ahead": format!("{first}\nThe guide trains you in 5 steps (Thunderbrew Distillery)."),
			"untitled": format!("{first}\nThe guide trains you in 2 steps."),
			"here": first,
			"none": format!("{first}\nThe guide has no class training ahead."),
		})
	);
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
fn a_quest_to_complete_with_several_objectives_lists_the_open_ones_under_it_before_its_note() {
	let out = run(r#"
		local goal = { t = "complete", quest = 747, status = "active", progress = { cur = 3, max = 14, kind = "count" },
			objectives = { "Plainstrider Meat: 3/7", "Plainstrider Feathers: 0/7" }, note = "Plainstriders roam the grass" }
		emit({ sub = UI.GoalSubline(goal), count = UI.GoalProgress(goal) })"#)
	.remove(0);
	assert_eq!(out["sub"], "Plainstrider Meat: 3/7  \u{b7}  Plainstrider Feathers: 0/7  \u{b7}  Plainstriders roam the grass");
	assert_eq!(out["count"], "3/14");
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
