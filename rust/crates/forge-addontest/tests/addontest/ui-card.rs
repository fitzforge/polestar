//! The guide window's card one person at a time (#843): the focus's goals in full, every other person of the step
//! on one summary line that opens in place, finished goals folding into "✓ N done" (pop, hold, fold, count), the
//! height cap with its scroll, Along the way not repeating the step, and "Show the whole step". Against the real
//! Core + Theme + UI manifests and the fake Engine (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const HELPERS: &str = r#"
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", "")):gsub("|r", "") end
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
local function subjects()
	local out = {}
	for _, r in ipairs(visibleRows()) do out[#out + 1] = r.psGoal.subject end
	return out
end
-- The goals area top to bottom: a row's subject, a line's text (plain), "+" on an opened line.
local function items()
	local out = {}
	for _, f in ipairs(GF.CardItems()) do
		if f.psLine then
			local open = f.Chevron:GetTexture():match("chevron%-up") and "+" or ""
			out[#out + 1] = "[" .. plain(f.Text:GetText()) .. "]" .. open
		else
			out[#out + 1] = f.psGoal.subject
		end
	end
	return out
end
local function lineFor(needle)
	for _, l in ipairs(GF.lines) do
		if l:IsShown() and plain(l.Text:GetText()):find(needle, 1, true) then return l end
	end
end
local function sameColor(fs, name)
	local r, g, b = fs:GetTextColor()
	local tr, tg, tb = Polestar.Theme.Color(name)
	return math.abs(r - tr) < 0.002 and math.abs(g - tg) < 0.002 and math.abs(b - tb) < 0.002
end
-- A step shaped like Dun Morogh's Brewnall Village for a gnome (#843, the reporter's screenshot): three persons,
-- then the field work, 13 goals. A sample: its names and ids are Classic's where they exist.
local function brewnall()
	local function G(t, f) f.t = t; return f end
	local DM = 1426
	local steps = uistub.guides[uistub.elwynn].steps
	steps[#steps + 1] = { title = "Brewnall Village", note = "Gretta Ganter's dock is the first stop.", goals = {
		G("accept", { verb = "Accept", subject = "Gretta's errand", subjectKind = "quest", quest = 98326, npc = 1, npcName = "Gretta Ganter", map = DM, x = 30.2, y = 45.7, status = "active" }),
		G("accept", { verb = "Accept", subject = "Bitter Rivals", subjectKind = "quest", quest = 310, npc = 1374, npcName = "Marleth Barleybrew", map = DM, x = 30.2, y = 45.8, status = "active" }),
		G("turnin", { verb = "Turn in", subject = "Evershine", subjectKind = "quest", quest = 318, npc = 1373, npcName = "Rejold Barleybrew", map = DM, x = 30.2, y = 45.9, status = "active" }),
		G("accept", { verb = "Accept", subject = "The Perfect Stout", subjectKind = "quest", quest = 315, npc = 1373, npcName = "Rejold Barleybrew", map = DM, x = 30.2, y = 45.9, status = "pending" }),
		G("accept", { verb = "Accept", subject = "A Favor for Evershine", subjectKind = "quest", quest = 319, npc = 1373, npcName = "Rejold Barleybrew", map = DM, x = 30.2, y = 45.9, status = "pending" }),
		G("kill", { verb = "Kill", subject = "Ice Claw Bear", subjectKind = "npc", npc = 1196, quest = 319, optional = true, progress = { cur = 0, max = 6 }, status = "pending" }),
		G("kill", { verb = "Kill", subject = "Elder Crag Boar", subjectKind = "npc", npc = 1127, quest = 319, optional = true, progress = { cur = 0, max = 8 }, status = "pending" }),
		G("kill", { verb = "Kill", subject = "Snow Leopard", subjectKind = "npc", npc = 1201, quest = 319, optional = true, progress = { cur = 0, max = 8 }, status = "pending" }),
		G("kill", { verb = "Kill", subject = "Elder Crag Boars", subjectKind = "npc", npc = 1127, quest = 319, progress = { cur = 0, max = 8 }, status = "pending" }),
		G("kill", { verb = "Kill", subject = "Snow Leopards", subjectKind = "npc", npc = 1201, quest = 319, progress = { cur = 0, max = 8 }, status = "pending" }),
		G("collect", { verb = "Collect", subject = "Restabilization Cog", subjectKind = "item", item = 3083, quest = 412, progress = { cur = 0, max = 1 }, status = "active" }),
		G("collect", { verb = "Collect", subject = "Gyromechanic Gear", subjectKind = "item", item = 3084, quest = 412, progress = { cur = 0, max = 1 }, status = "active" }),
		G("goto", { verb = "Go to", subject = "Frostmane Hold", subjectKind = "place", map = DM, x = 25.1, y = 50.9, status = "pending" }),
	} }
	return #steps
end
-- Every 0.05 s for `seconds`, fn(t) (t from now).
local function frames(seconds, fn)
	local t = 0
	while t < seconds - 1e-9 do
		stub.advance(0.05)
		t = t + 0.05
		fn(t)
	end
end
"#;

fn run_with(script: &str, before: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\nlocal GF, UI = Polestar.UI.GuideFrame, Polestar.UI\nlocal F = PolestarGuideFrame\n{HELPERS}\n{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, "")
}

/// The game's looks keep the plain card (24px lines, "Then out here" folded). The house look's dense card, its
/// field work open under the goals, has its own tests.
fn run_hearth(script: &str) -> Vec<Value> {
	run(&format!("Polestar.Set(\"ui.skin\", \"hearth\")\n{script}"))
}

fn f(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

fn strings(v: &Value) -> Vec<String> {
	v.as_array().unwrap().iter().map(|x| text(x).to_string()).collect()
}

#[test]
fn a_brewnall_hub_shows_the_first_person_s_goal_and_one_line_for_each_other_person_and_the_field_work() {
	let out = run_hearth(r#"
		uistub.setGuide(uistub.elwynn, brewnall())
		stub.advance(1)
		local P = GF.parts
		local calm = { person = P.person.Name:GetText(), items = items(), after = P.after:IsShown(), h = F:GetHeight() }
		Polestar.Set("ui.wholeStep", true)
		local whole = { items = items(), after = plain(P.after.Text:GetText()), persons = P.after.Count:GetText(), h = F:GetHeight() }
		Polestar.Set("ui.wholeStep", false)
		emit({ calm = calm, whole = whole, back = items() })"#)
	.remove(0);
	let calm = &out["calm"];
	assert_eq!(calm["person"], "Gretta Ganter");
	assert_eq!(
		strings(&calm["items"]),
		["Gretta's errand", "[Then: Marleth Barleybrew  ·  Accept “Bitter Rivals”]", "[Then: Rejold Barleybrew  ·  1 hand-in, 2 quests]", "[Then out here: 7 kills and items]",],
		"the person to talk to now in full; every other person and the field work on one line: one or two goals named, more counted"
	);
	assert!(calm["items"].as_array().unwrap().len() <= 5);
	assert_eq!(calm["after"], false, "the lines already say who comes next");
	// "Show the whole step": the list as before, with "Then:" and the count of persons.
	assert_eq!(out["whole"]["items"].as_array().unwrap().len(), 13);
	assert!(!strings(&out["whole"]["items"]).iter().any(|s| s.starts_with('[')), "no summary lines");
	assert_eq!(out["whole"]["after"], "Then: Marleth Barleybrew");
	assert_eq!(out["whole"]["persons"], "Person 1 of 3");
	assert!(f(&out["calm"]["h"]) < f(&out["whole"]["h"]) - 150.0, "the card is far shorter: {} vs {}", out["calm"]["h"], out["whole"]["h"]);
	assert_eq!(out["back"], out["calm"]["items"], "turned off again, the card reads one person at a time");
}

#[test]
fn a_summary_line_opens_its_person_s_goals_in_place_a_second_click_or_the_focus_moving_on_closes_it() {
	let out = run_hearth(r#"
		local s = brewnall()
		uistub.setGuide(uistub.elwynn, s)
		local line = lineFor("Rejold")
		stub.RunScript(line, "OnClick", "LeftButton")
		local opened = items()
		stub.RunScript(lineFor("Rejold"), "OnClick", "LeftButton")
		local closed = items()
		stub.RunScript(lineFor("Rejold"), "OnClick", "LeftButton")
		uistub.goal(s, 1).status = "done"
		uistub.update()
		emit({ opened = opened, closed = closed, moved = items(), person = GF.parts.person.Name:GetText() })"#)
	.remove(0);
	assert_eq!(
		strings(&out["opened"]),
		[
			"Gretta's errand",
			"[Then: Marleth Barleybrew  ·  Accept “Bitter Rivals”]",
			"[Then: Rejold Barleybrew]+",
			"Evershine",
			"The Perfect Stout",
			"A Favor for Evershine",
			"[Then out here: 7 kills and items]",
		],
		"a look ahead: Rejold's goals right under his line, which then names only him"
	);
	assert_eq!(
		strings(&out["closed"]),
		["Gretta's errand", "[Then: Marleth Barleybrew  ·  Accept “Bitter Rivals”]", "[Then: Rejold Barleybrew  ·  1 hand-in, 2 quests]", "[Then out here: 7 kills and items]"]
	);
	assert_eq!(out["person"], "Marleth Barleybrew");
	assert_eq!(
		strings(&out["moved"]),
		["[Gretta Ganter]", "Bitter Rivals", "[Then: Rejold Barleybrew  ·  1 hand-in, 2 quests]", "[Then out here: 7 kills and items]"],
		"the next person opens by itself; the one opened by hand closes; the person done is one line"
	);
}

#[test]
fn a_person_whose_goals_another_person_splits_reads_on_one_summary_line() {
	// Shaped like Darkshore's Auberdine step: Thundris Windweaver's accepts with another person's between them.
	let out = run(r#"
		local function G(t, f) f.t = t; f.subjectKind = "quest"; f.map = 1439; return f end
		local steps = uistub.guides[uistub.elwynn].steps
		steps[#steps + 1] = { title = "Auberdine", goals = {
			G("accept", { verb = "Accept", subject = "Deep Ocean, Vast Sea", quest = 982, npc = 6301, npcName = "Gorbold Steelhand", status = "active" }),
			G("accept", { verb = "Accept", subject = "Bashal'Aran", quest = 954, npc = 3649, npcName = "Thundris Windweaver", status = "active" }),
			G("accept", { verb = "Accept", subject = "Expanding Horizons", quest = 97914, npc = 3649, npcName = "Thundris Windweaver", status = "active" }),
			G("accept", { verb = "Accept", subject = "The Tower of Althalaxx", quest = 965, npc = 3657, npcName = "Sentinel Elissa Starbreeze", status = "active" }),
			G("accept", { verb = "Accept", subject = "Tools of the Highborne", quest = 958, npc = 3649, npcName = "Thundris Windweaver", status = "active" }),
		} }
		local s = #steps
		uistub.setGuide(uistub.elwynn, s)
		local ahead = items()
		for gi = 1, 3 do uistub.goal(s, gi).status = "done" end
		uistub.update()
		local between = items()
		stub.RunScript(lineFor("Thundris"), "OnClick", "LeftButton")
		emit({ ahead = ahead, between = between, opened = items(), person = GF.parts.person.Name:GetText() })"#)
	.remove(0);
	assert_eq!(
		strings(&out["ahead"]),
		["Deep Ocean, Vast Sea", "[Then: Thundris Windweaver  ·  3 quests]", "[Then: Sentinel Elissa Starbreeze  ·  Accept “The Tower of Althalaxx”]"],
		"Thundris's three accepts on his one line, before the person who splits them"
	);
	assert_eq!(out["person"], "Sentinel Elissa Starbreeze");
	assert_eq!(
		strings(&out["between"]),
		["[Gorbold Steelhand]", "The Tower of Althalaxx", "[Then: Thundris Windweaver  ·  Accept “Tools of the Highborne”]"],
		"Thundris still has a quest to give: not a done person, one line for him"
	);
	assert_eq!(
		strings(&out["opened"]),
		["[Gorbold Steelhand]", "The Tower of Althalaxx", "[Then: Thundris Windweaver]+", "Bashal'Aran", "Expanding Horizons", "Tools of the Highborne",],
		"opened, his line lists all his goals in written order"
	);
}

// The field step (Elwynn, step 3): Kobold Vermin turns done while the window shows it.
const FOLD: &str = r#"
		uistub.setGuide(uistub.elwynn, 3)
		stub.advance(1)
		local frames0 = uistub.frameCount()
		uistub.goal(3, 3).progress.cur = 10
		uistub.goal(3, 3).status = "done"
		uistub.update()
		local h0 = F:GetHeight()
		local row = rowFor("Kobold Vermin")
		local at0 = { shown = row ~= nil, popping = Polestar.Anim.IsRunning(row.Icon, "size"), icon = row.Icon:GetTexture():match("([%w-]+)$"),
			done = plain(lineFor("done").Text:GetText()) }
		local samples = {}
		frames(1.2, function(t)
			local r = rowFor("Kobold Vermin")
			local done = lineFor("done")
			samples[#samples + 1] = { t = t, row = r ~= nil and r:IsShown(), k = r and (r.psK or 1) or 0, a = r and r:GetAlpha() or 0,
				h = F:GetHeight(), done = plain(done.Text:GetText()), glow = not sameColor(done.Text, "textDim") }
		end)
		stub.advance(1)
		emit({ at0 = at0, samples = samples, h0 = h0, rows = subjects(), lines = items(), folding = GF.Folding(), tweens = Polestar.Anim.Active(),
			framesAdded = uistub.frameCount() - frames0, glowAfter = not sameColor(lineFor("done").Text, "textDim") })"#;

#[test]
fn a_goal_turning_done_pops_holds_then_folds_shut_while_the_rows_below_glide_up_and_done_counts_it_with_a_glow() {
	let out = run_hearth(FOLD).remove(0);
	assert_eq!(out["at0"], json!({ "shown": true, "popping": true, "icon": "check", "done": "1 done" }), "the moment it turns done: its check pops, the row stays");
	let samples = out["samples"].as_array().unwrap();
	let at = |s: &Value| f(&s["t"]);
	// Hold (0.75 s): the row stays whole and opaque so the player sees the check.
	for s in samples.iter().filter(|s| at(s) < 0.749) {
		assert_eq!((f(&s["k"]), f(&s["a"])), (1.0, 1.0), "held at {}", at(s));
	}
	// Fold (0.3 s, ease-out): its height share and alpha only fall; the text is gone before the row has shut.
	let folding: Vec<&Value> = samples.iter().filter(|s| at(s) > 0.76 && s["row"] == true).collect();
	assert!(folding.len() >= 4, "several frames of motion: {}", folding.len());
	for w in folding.windows(2) {
		assert!(f(&w[1]["k"]) < f(&w[0]["k"]) && f(&w[1]["a"]) <= f(&w[0]["a"]), "{} -> {}", w[0], w[1]);
	}
	assert!(folding.iter().any(|s| f(&s["a"]) == 0.0 && f(&s["k"]) > 0.0), "faded before shut");
	// The window glides: its height only falls, by less than half the row a frame (stub frames are 50 ms),
	// never a jump of the row.
	let h0 = f(&out["h0"]);
	let end = f(&samples.last().unwrap()["h"]);
	assert!(h0 - end >= 20.0, "the row's height is gone: {h0} -> {end}");
	let mut last = h0;
	for s in samples {
		let h = f(&s["h"]);
		assert!(h <= last + 0.01, "the window never grows back: {} at {}", h, at(s));
		assert!(last - h < (h0 - end) * 0.5, "no jump: {} -> {} at {}", last, h, at(s));
		last = h;
	}
	// Then the count: "2 done", its text glowing in the accent and back.
	let landed = samples.iter().find(|s| s["row"] == false).expect("the row folded away");
	assert!(at(landed) > 1.0 && at(landed) < 1.15, "lands after hold + fold: {}", at(landed));
	assert_eq!(landed["done"], "2 done");
	assert_eq!(landed["glow"], true, "the new count glows");
	assert_eq!(out["glowAfter"], false, "and settles in textDim");
	assert_eq!(out["rows"], json!(["Tough Wolf Meat"]));
	assert_eq!(out["lines"], json!(["[Eagan Peltskinner]", "[2 done]", "Tough Wolf Meat"]));
	assert_eq!(out["folding"], false, "the fold driver stops once nothing moves");
	assert_eq!(out["tweens"], 0);
	assert_eq!(out["framesAdded"], 0, "folding creates no frames");
}

#[test]
fn with_reduced_motion_a_goal_turning_done_only_fades_then_the_count_changes() {
	let out = run(&format!("Polestar.Set(\"ui.reduceMotion\", true)\n{FOLD}")).remove(0);
	let samples = out["samples"].as_array().unwrap();
	let h0 = f(&out["h0"]);
	let visible: Vec<&Value> = samples.iter().filter(|s| s["row"] == true).collect();
	for s in &visible {
		assert_eq!(f(&s["k"]), 1.0, "no height motion at {}", s["t"]);
		assert_eq!(f(&s["h"]), h0, "the window holds still while the row fades at {}", s["t"]);
	}
	assert!(visible.iter().any(|s| f(&s["a"]) < 1.0 && f(&s["a"]) > 0.0), "it fades");
	let landed = samples.iter().find(|s| s["row"] == false).expect("the row is gone");
	assert!(f(&landed["t"]) > 0.9 && f(&landed["t"]) < 1.05, "after the hold and a short fade: {}", landed["t"]);
	assert_eq!(landed["done"], "2 done");
	assert_eq!(landed["glow"], false, "no glow");
	assert_eq!(out["rows"], json!(["Tough Wolf Meat"]));
	assert_eq!(out["folding"], false);
}

#[test]
fn goals_done_together_fold_one_after_another_a_beat_apart_into_one_count() {
	let out = run_hearth(r#"
		local s = brewnall()
		local goals = uistub.guides[uistub.elwynn].steps[s].goals
		for g = 1, 5 do goals[g].status = "done" end
		for g = 6, 10 do goals[g].status = "active" end
		uistub.setGuide(uistub.elwynn, s)
		stub.advance(1)
		local before = items()
		uistub.goal(s, 9).status = "done"
		uistub.goal(s, 10).status = "done"
		uistub.goal(s, 11).status = "done"
		uistub.update()
		local mid
		frames(0.9, function(t)
			if not mid and t >= 0.85 - 1e-9 then
				mid = {}
				for _, name in ipairs({ "Elder Crag Boars", "Snow Leopards", "Restabilization Cog" }) do
					local r = rowFor(name)
					mid[#mid + 1] = r and (r.psK or 1) or 0
				end
			end
		end)
		stub.advance(1)
		emit({ before = before, mid = mid, after = items(), folding = GF.Folding() })"#)
	.remove(0);
	assert_eq!(strings(&out["before"])[0], "[Gretta Ganter, Marleth Barleybrew, Rejold Barleybrew]", "the persons done: one line");
	let mid: Vec<f64> = out["mid"].as_array().unwrap().iter().map(f).collect();
	assert!(mid[0] < mid[1] && mid[1] < mid[2] && mid[2] <= 1.0, "staggered, first folds first: {mid:?}");
	assert!(mid[0] > 0.0, "one movement, not one after the other finished: {mid:?}");
	assert_eq!(
		strings(&out["after"]),
		["[Gretta Ganter, Marleth Barleybrew, Rejold Barleybrew]", "[3 done]", "Ice Claw Bear", "Elder Crag Boar", "Snow Leopard", "Gyromechanic Gear", "Frostmane Hold"]
	);
	assert_eq!(out["folding"], false);
}

#[test]
fn the_done_line_opens_the_finished_goals_dimmed_for_review_and_closes_again() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		stub.RunScript(lineFor("done"), "OnClick", "LeftButton")
		local opened = items()
		local camp = rowFor("the Kobold Camp")
		local dimmed = sameColor(camp.Text, "textMuted")
		stub.RunScript(lineFor("done"), "OnClick", "LeftButton")
		emit({ opened = opened, dimmed = dimmed, closed = items() })"#)
	.remove(0);
	assert_eq!(strings(&out["opened"]), ["[Eagan Peltskinner]", "[1 done]+", "the Kobold Camp", "Kobold Vermin", "Tough Wolf Meat"]);
	assert_eq!(out["dimmed"], true);
	assert_eq!(strings(&out["closed"]), ["[Eagan Peltskinner]", "[1 done]", "Kobold Vermin", "Tough Wolf Meat"]);
}

#[test]
fn the_window_stops_at_its_height_cap_the_goals_scroll_and_the_current_goal_is_scrolled_into_view() {
	let out = run_hearth(r#"
		local s = brewnall()
		for g = 1, 5 do uistub.guides[uistub.elwynn].steps[s].goals[g].status = "done" end
		Polestar.Set("ui.maxHeight", 0.3)
		Polestar.Set("ui.wholeStep", true)
		uistub.setGuide(uistub.elwynn, s)
		stub.advance(1)
		local goals = GF.parts.goals
		local cur = rowFor("Elder Crag Boars")
		local top, view, scroll = GF.ItemTop(cur), goals.psViewH, goals:GetVerticalScroll()
		local capped = { h = F:GetHeight(), cap = GF.CapHeight(), over = goals.psOver, wheel = goals.mouseWheel, bar = goals.Bar:IsShown(),
			barAlpha = goals.Bar:GetAlpha(), scroll = scroll, inView = top >= scroll - 0.5 and top + cur:GetHeight() <= scroll + view + 0.5,
			content = goals.psContentH, view = view }
		stub.advance(3)
		local idleAlpha = goals.Bar:GetAlpha()
		stub.RunScript(goals, "OnMouseWheel", 1)
		local wheeled = { scroll = goals:GetVerticalScroll() }
		stub.advance(0.2)
		wheeled.alpha = goals.Bar:GetAlpha()
		Polestar.Set("ui.width", 260)
		local narrow = F:GetHeight()
		Polestar.Set("ui.maxHeight", 0.9)
		local roomy = { h = F:GetHeight(), over = goals.psOver, wheel = goals.mouseWheel }
		Polestar.Set("ui.wholeStep", false)
		Polestar.Set("ui.width", 340)
		Polestar.Set("ui.maxHeight", 0.3)
		emit({ capped = capped, idleAlpha = idleAlpha, wheeled = wheeled, narrow = narrow, roomy = roomy,
			calm = { h = F:GetHeight(), content = goals.psContentH } })"#)
	.remove(0);
	let c = &out["capped"];
	assert_eq!(f(&c["cap"]), 1080.0 * 0.3, "30% of the screen at scale 1");
	assert!(f(&c["h"]) <= f(&c["cap"]) + 0.5, "the window stops at the cap: {}", c["h"]);
	assert_eq!(c["over"], true);
	assert!(f(&c["content"]) > f(&c["view"]));
	assert_eq!(c["wheel"], true, "the wheel scrolls the goals");
	assert_eq!(c["bar"], true, "a thin bar shows there is more");
	assert!(f(&c["scroll"]) > 0.0, "scrolled to the current goal, low in the list");
	assert_eq!(c["inView"], true);
	assert_eq!(f(&out["idleAlpha"]), 0.0, "the bar fades out when idle");
	assert!(f(&out["wheeled"]["scroll"]) < f(&c["scroll"]), "the wheel scrolls up");
	assert!(f(&out["wheeled"]["alpha"]) > 0.0, "and wakes the bar");
	assert!(f(&out["narrow"]) <= f(&c["cap"]) + 0.5, "a narrower window still keeps to the cap");
	assert_eq!(out["roomy"]["over"], false, "with room the step shows whole");
	assert_eq!(out["roomy"]["wheel"], false, "and the wheel is the camera's again");
	assert!(f(&out["roomy"]["h"]) > f(&c["h"]));
	assert!(f(&out["calm"]["content"]) < f(&c["content"]) - 100.0, "one person at a time is far shorter than the whole step");
	assert!(f(&out["calm"]["h"]) <= f(&c["cap"]) + 0.5);
}

#[test]
fn along_the_way_leaves_out_goals_the_step_on_screen_lists_itself() {
	let out = run(r#"
		local steps = uistub.guides[uistub.elwynn].steps
		steps[#steps + 1] = { title = "On the way", goals = {
			{ t = "kill", verb = "Kill", subject = "Kobold Vermin", subjectKind = "npc", npc = 6, quest = 7, progress = { cur = 7, max = 10 }, status = "active" },
			{ t = "collect", verb = "Collect", subject = "Tough Wolf Meat", subjectKind = "item", item = 750, quest = 33, progress = { cur = 3, max = 8 }, status = "active" },
			{ t = "kill", verb = "Kill", subject = "Young Wolf", subjectKind = "npc", npc = 299, quest = 33, progress = { cur = 0, max = 4 }, status = "active" },
		} }
		uistub.along = { { #steps, { 1, 2, 3 } } }
		uistub.setGuide(uistub.elwynn, 3)
		local shown = {}
		for _, r in ipairs(GF.alongRows) do if r:IsShown() then shown[#shown + 1] = plain(r.Text:GetText()) end end
		uistub.setGuide(uistub.elwynn, 5)
		local elsewhere = 0
		for _, r in ipairs(GF.alongRows) do if r:IsShown() then elsewhere = elsewhere + 1 end end
		emit({ shown = shown, elsewhere = elsewhere })"#)
	.remove(0);
	assert_eq!(out["shown"], json!(["Kill Young Wolf  0/4"]), "the step's own kill and item are not said twice");
	assert_eq!(out["elsewhere"], 3, "on a step that does not list them, all three");
}

#[test]
fn the_options_offer_show_the_whole_step_and_a_maximum_height_in_guide_window() {
	let out = run(r#"
		UI.ShowOptions("guide")
		local O = UI.Options
		local widgets = O.Controls("guide", "Window")
		local found = {}
		for _, q in ipairs({ "whole step", "maximum height" }) do
			for _, g in ipairs(O.Search(q)) do
				for _, c in ipairs(g.controls) do
					if c.key == "ui.wholeStep" or c.key == "ui.maxHeight" then
						found[c.key] = { title = g.title, kind = c.kind, min = c.min, max = c.max, label = c.label }
					end
				end
			end
		end
		emit({ found = found, widgets = { whole = widgets["ui.wholeStep"] ~= nil, max = widgets["ui.maxHeight"] ~= nil },
			defaults = { whole = Polestar.Get("ui.wholeStep"), max = Polestar.Get("ui.maxHeight") } })"#)
	.remove(0);
	assert_eq!(out["defaults"], json!({ "whole": false, "max": 0.5 }), "one person at a time and half the screen by default");
	assert_eq!(out["widgets"], json!({ "whole": true, "max": true }));
	assert_eq!(out["found"]["ui.wholeStep"], json!({ "title": "Guide  \u{b7}  Window", "kind": "toggle", "label": "Show the whole step" }));
	assert_eq!(out["found"]["ui.maxHeight"], json!({ "title": "Guide  \u{b7}  Window", "kind": "slider", "min": 0.3, "max": 0.9, "label": "Maximum height" }));
	assert!(is_match(text(&out["found"]["ui.maxHeight"]["title"]), "Window$"));
}

// A town hub of eight persons (Darkshore's Auberdine has seventeen): past three lines the rest share one.
#[test]
fn past_three_persons_the_rest_of_a_hub_share_one_more_line_that_opens_and_closes_in_place() {
	let out = run(r#"
		local steps = uistub.guides[uistub.elwynn].steps
		local goals = {}
		local names = { "Ada", "Bram", "Cora", "Dain", "Edda", "Finn", "Gil", "Hale" }
		for i, who in ipairs(names) do
			goals[#goals + 1] = { t = "accept", verb = "Accept", subject = "Quest " .. i, subjectKind = "quest", quest = 900 + i, npc = 800 + i, npcName = who, status = "active" }
		end
		-- Finn has a hand-in too; Gil's quest is done already, Hale's does not apply to this character.
		table.insert(goals, 7, { t = "turnin", verb = "Turn in", subject = "Old Quest", subjectKind = "quest", quest = 899, npc = 806, npcName = "Finn", status = "active" })
		goals[8].status = "done"
		goals[9].status = "na"
		goals[#goals + 1] = { t = "talk", verb = "Talk to", subject = "Hale", subjectKind = "npc", npc = 808, npcName = "Hale", status = "active" }
		steps[#steps + 1] = { title = "Town", goals = goals }
		uistub.setGuide(uistub.elwynn, #steps)
		local closed = items()
		stub.RunScript(lineFor("more people"), "OnClick", "LeftButton")
		local opened = items()
		stub.RunScript(lineFor("Edda"), "OnClick", "LeftButton")
		local deeper = items()
		stub.RunScript(lineFor("more people"), "OnClick", "LeftButton")
		emit({ closed = closed, opened = opened, deeper = deeper, again = items() })"#)
	.remove(0);
	let closed = ["Quest 1", "[Then: Bram  ·  Accept “Quest 2”]", "[Then: Cora  ·  Accept “Quest 3”]", "[Then: Dain  ·  Accept “Quest 4”]", "[+ 4 more people  ·  2 quests, 1 hand-in, 1 task]"];
	assert_eq!(strings(&out["closed"]), closed, "only the goals that apply and are still open are counted");
	assert_eq!(
		strings(&out["opened"]),
		[
			"Quest 1",
			"[Then: Bram  ·  Accept “Quest 2”]",
			"[Then: Cora  ·  Accept “Quest 3”]",
			"[Then: Dain  ·  Accept “Quest 4”]",
			"[+ 4 more people  ·  2 quests, 1 hand-in, 1 task]+",
			"[Then: Edda  ·  Accept “Quest 5”]",
			"[Then: Finn  ·  Accept “Quest 6”, Turn in “Old Quest”]",
			"[Gil]",
			"[Then: Hale  ·  Talk to Hale]",
		]
	);
	assert!(strings(&out["deeper"]).contains(&"Quest 5".to_string()), "a line inside opens its goals too");
	assert_eq!(strings(&out["again"]), closed);
}

// One or two goals left: the line names them, the quest in the quest colour as on a row; three or more: counts.
#[test]
fn a_summary_line_names_one_or_two_goals_and_counts_three_or_more() {
	let out = run_hearth(r#"
		local s = brewnall()
		local goals = uistub.guides[uistub.elwynn].steps[s].goals
		goals[1].status = "done"
		-- Rejold: two goals left; the field work: one kill and the "Go to", which is not named beside it.
		goals[4].status = "done"
		for _, g in ipairs({ 6, 7, 8, 9, 11, 12 }) do goals[g].status = "done" end
		uistub.setGuide(uistub.elwynn, s)
		local two = items()
		local rejold = lineFor("Rejold").Text:GetText()
		goals[4].status = "pending"
		goals[10].status = "done"
		uistub.update()
		emit({ two = two, rejold = rejold, quest = Polestar.Theme.Hex("quest"), three = items() })"#)
	.remove(0);
	assert_eq!(strings(&out["two"]), ["[Gretta Ganter]", "Bitter Rivals", "[Then: Rejold Barleybrew  ·  Turn in “Evershine”, Accept “A Favor for Evershine”]", "[Then out here: Kill Snow Leopards]"]);
	assert!(text(&out["rejold"]).contains(&format!("|c{}Evershine|r", text(&out["quest"]))), "the quest in the quest colour: {}", out["rejold"]);
	assert_eq!(
		strings(&out["three"]),
		["[Gretta Ganter]", "Bitter Rivals", "[Then: Rejold Barleybrew  ·  1 hand-in, 2 quests]", "[Then out here: Go to Frostmane Hold]"],
		"three goals: counted; with only the \"Go to\" left, it is named"
	);
}

// Darkshore's "Fine Crab Chunks on the way" (#942): an along step has no card of its own; the steps after it list
// its goals under "Along the way", whose heading says until which step when every row ends at the same one.
#[test]
fn along_the_way_says_until_which_step_its_goals_are_listed() {
	let out = run(r#"
		local steps = uistub.guides[uistub.elwynn].steps
		local crab = #steps + 1
		steps[crab] = { title = "Fine Crab Chunks on the way", along = "q1138", untilStep = 5, goals = {
			{ t = "collect", verb = "Collect", subject = "Fine Crab Chunks", subjectKind = "item", item = 12237, quest = 1138, progress = { cur = 0, max = 6 }, map = 1439, x = 36.4, y = 47.0, status = "active" },
		} }
		steps[crab + 1] = { title = "Linen on the way", along = true, goals = {
			{ t = "collect", verb = "Collect", subject = "Linen Cloth", subjectKind = "item", item = 2589, progress = { cur = 0, max = 1 }, status = "active" },
		} }
		local A = GF.parts.along
		uistub.along = { { crab, { 1 } } }
		uistub.setGuide(uistub.elwynn, 3)
		local one = { shown = A:IsShown(), heading = plain(A.Label:GetText()) }
		uistub.along = { { crab, { 1 } }, { crab + 1, { 1 } } }
		uistub.setGuide(uistub.elwynn, 4)
		emit({ one = one, mixed = plain(A.Label:GetText()) })"#)
	.remove(0);
	assert_eq!(out["one"], json!({ "shown": true, "heading": "Along the way, until step 5" }));
	assert_eq!(out["mixed"], "Along the way", "rows ending at different steps (or when done): the plain heading");
}

// Elwynn's step 42, "Goldshire" (`when group 91775`, `turnin 91775 optional`, #942): looked at ahead, a step with
// nothing for this character says why instead of showing only its title.
#[test]
fn a_step_with_nothing_for_the_character_says_why_under_its_title() {
	let out = run(r#"
		local steps = uistub.guides[uistub.elwynn].steps
		steps[#steps + 1] = { title = "Goldshire", why = "Only if you do Book Return with a group", goals = {
			{ t = "turnin", verb = "Turn in", subject = "Book Return", subjectKind = "quest", quest = 91775, npc = 295, npcName = "Innkeeper Farley", optional = true, status = "na" },
		} }
		local s = #steps
		uistub.live = 1
		uistub.setGuide(uistub.elwynn, s)
		local P = GF.parts
		local skipped = { why = P.person.Why:IsShown() and plain(P.person.Why:GetText()) or false, name = P.person.Name:GetText(), items = items() }
		uistub.setGuide(uistub.elwynn, 3)
		emit({ skipped = skipped, field = P.person.Why:IsShown() })"#)
	.remove(0);
	assert_eq!(out["skipped"]["why"], "Only if you do Book Return with a group");
	assert_eq!(out["skipped"]["name"], "Goldshire");
	assert_eq!(out["field"], false);
}

// Darkshore's Auberdine (#942): WANTED: Jai'vhanel and WANTED: Murkdeep! start from one poster, which Forever names
// "WANTED: Murkdeep!". Its header is the goal's note naming the poster, not the other quest's title.
#[test]
fn an_object_named_like_one_of_its_quests_is_headed_by_the_note_naming_it_or_a_neutral_label() {
	let out = run(r#"
		local steps = uistub.guides[uistub.elwynn].steps
		local function poster(quest, subject, note)
			return { t = "accept", verb = "Accept", subject = subject, subjectKind = "quest", quest = quest, object = 175320, objectName = "WANTED: Murkdeep!", note = note, map = 1439, x = 37.2, y = 44.2, status = "active" }
		end
		local function header(goals)
			steps[#steps + 1] = { title = "Auberdine", goals = goals }
			uistub.setGuide(uistub.elwynn, #steps)
			return GF.parts.person.Name:GetText()
		end
		emit({
			both = header({ poster(98025, "WANTED: Jai'vhanel", "The WANTED poster outside the inn"), poster(4740, "WANTED: Murkdeep!", "The WANTED poster") }),
			bare = header({ poster(98025, "WANTED: Jai'vhanel"), poster(4740, "WANTED: Murkdeep!") }),
			own = header({ poster(4740, "WANTED: Murkdeep!", "The WANTED poster") }),
		})"#)
	.remove(0);
	assert_eq!(out["both"], "The WANTED poster outside the inn", "the note that names the poster");
	assert_eq!(out["bare"], "The object here", "no such note: a neutral label");
	assert_eq!(out["own"], "WANTED: Murkdeep!", "its only quest's own title is no confusion");
}

// Darkshore's Auberdine step (#942): Thundris Windweaver is the focus, then Naram's vendor goal, then Thundris again.
// His later accept reads with him, not on a second "Then: Thundris Windweaver" line under the focus.
#[test]
fn the_focus_person_s_later_goals_read_with_the_focus_not_on_a_line_of_their_own() {
	let out = run_hearth(r#"
		local function G(t, f) f.t = t; f.map = 1439; return f end
		local steps = uistub.guides[uistub.elwynn].steps
		steps[#steps + 1] = { title = "Auberdine", goals = {
			G("accept", { verb = "Accept", subject = "Bashal'Aran", subjectKind = "quest", quest = 954, npc = 3649, npcName = "Thundris Windweaver", status = "active" }),
			G("accept", { verb = "Accept", subject = "Expanding Horizons", subjectKind = "quest", quest = 97914, npc = 3649, npcName = "Thundris Windweaver", status = "active" }),
			G("vendor", { verb = "Sell junk at", subject = "Naram Longclaw", subjectKind = "npc", npc = 6034, npcName = "Naram Longclaw", status = "active" }),
			G("accept", { verb = "Accept", subject = "Tools of the Highborne", subjectKind = "quest", quest = 958, npc = 3649, npcName = "Thundris Windweaver", status = "active" }),
			G("accept", { verb = "Accept", subject = "Deep Ocean, Vast Sea", subjectKind = "quest", quest = 982, npc = 6301, npcName = "Gorbold Steelhand", status = "active" }),
		} }
		local s = #steps
		uistub.setGuide(uistub.elwynn, s)
		local focus = { person = GF.parts.person.Name:GetText(), items = items() }
		uistub.goal(s, 4).status = "done"
		uistub.setGuide(uistub.elwynn, 3)
		uistub.setGuide(uistub.elwynn, s)
		local took = items()
		uistub.goal(s, 1).status = "done"
		uistub.goal(s, 2).status = "done"
		uistub.goal(s, 4).status = "active"
		uistub.update()
		local naram = { person = GF.parts.person.Name:GetText(), items = items() }
		-- Field work between: coming back to him is another visit, a line of its own as before.
		steps[#steps + 1] = { title = "Marshal McBride", goals = {
			G("accept", { verb = "Accept", subject = "The Vineyard Walk", subjectKind = "quest", quest = 9700, npc = 197, npcName = "Marshal McBride", status = "active" }),
			G("kill", { verb = "Kill", subject = "Kobold Vermin", subjectKind = "npc", npc = 6, quest = 9700, progress = { cur = 0, max = 3 }, status = "active" }),
			G("turnin", { verb = "Turn in", subject = "The Vineyard Walk", subjectKind = "quest", quest = 9700, npc = 197, npcName = "Marshal McBride", status = "active" }),
		} }
		uistub.setGuide(uistub.elwynn, #steps)
		emit({ focus = focus, took = took, naram = naram, trip = items() })"#)
	.remove(0);
	assert_eq!(out["focus"]["person"], "Thundris Windweaver");
	assert_eq!(
		strings(&out["focus"]["items"]),
		["Bashal'Aran", "Expanding Horizons", "Tools of the Highborne", "[Then: Naram Longclaw  ·  Sell junk at Naram Longclaw]", "[Then: Gorbold Steelhand  ·  Accept “Deep Ocean, Vast Sea”]"],
		"all three of his accepts under him, the vendor after"
	);
	assert_eq!(
		strings(&out["took"]),
		["[1 done]", "Bashal'Aran", "Expanding Horizons", "[Then: Naram Longclaw  ·  Sell junk at Naram Longclaw]", "[Then: Gorbold Steelhand  ·  Accept “Deep Ocean, Vast Sea”]"],
		"one of them taken folds with the focus's done goals"
	);
	assert_eq!(out["naram"]["person"], "Naram Longclaw");
	assert_eq!(
		strings(&out["naram"]["items"]),
		["Naram Longclaw", "[Then: Thundris Windweaver  ·  Accept “Tools of the Highborne”]", "[Then: Gorbold Steelhand  ·  Accept “Deep Ocean, Vast Sea”]"],
		"once his first goals are done and the focus moves on, what he still has reads after it as before"
	);
	assert_eq!(
		strings(&out["trip"]),
		["The Vineyard Walk", "[Then out here: Kill Kobold Vermin]", "[Then: Marshal McBride  ·  Turn in “The Vineyard Walk”]"],
		"with field work between, the hand-in is a later visit"
	);
}

// Darkshore's "Plagued bears" (#942): `complete 2118` read "Complete Plagued Lands", which says nothing. A
// `complete` goal reads as its quest's objective lines (the Engine's `objectiveLines`), each with its count,
// "Use Tharnariun's Hope:" first while the item the quest hands over is in the bags (`useItem`); the guide's note
// stays the line under it. Without either it keeps "Complete <quest>".
#[test]
fn a_complete_goal_reads_as_its_objectives_with_use_item_first() {
	let out = run(r#"
		local steps = uistub.guides[uistub.elwynn].steps
		local function complete(f)
			f.t, f.verb, f.subject, f.subjectKind, f.status = "complete", "Complete", f.subject, "quest", "active"
			return f
		end
		steps[#steps + 1] = { title = "Plagued bears", goals = {
			complete({ subject = "Plagued Lands", quest = 2118, note = "the Rabid Thistle Bears nearest Tharnariun", useItem = "Tharnariun's Hope",
				objectiveLines = { { text = "Rabid Thistle Bear Captured", cur = 0, max = 1 } }, progress = { cur = 0, max = 1 } }),
			complete({ subject = "The Hunt Begins", quest = 747, objectiveLines = { { text = "Plainstrider Meat", cur = 3, max = 7 }, { text = "Plainstrider Feathers", cur = 7, max = 7 } },
				progress = { cur = 10, max = 14 } }),
			complete({ subject = "A Humble Task", quest = 752 }),
		} }
		uistub.setGuide(uistub.elwynn, #steps)
		local function row(subject)
			local r = rowFor(subject)
			return { text = plain(r.Text:GetText()), sub = r.Sub:IsShown() and plain(r.Sub:GetText()) or false }
		end
		emit({ bears = row("Plagued Lands"), hunt = row("The Hunt Begins"), humble = row("A Humble Task") })"#)
	.remove(0);
	assert_eq!(
		out["bears"],
		json!({ "text": "Use Tharnariun's Hope: Rabid Thistle Bear Captured  0/1", "sub": "the Rabid Thistle Bears nearest Tharnariun" }),
		"the game's objective, the item to use first, the guide's note under it"
	);
	assert_eq!(out["hunt"]["text"], "Plainstrider Meat  3/7\nPlainstrider Feathers  7/7", "a line per objective, each with its count, not the sum");
	assert_eq!(out["humble"]["text"], "Complete “A Humble Task”", "no objective text: the old label");
}

// The Warlock's "The Binding" in Stormwind, as a player on Discord saw it in 0.3.3: Gakin the Darkbinder, then the
// Bloodstone Choker and the Voidwalker out at the circle, then Gakin again.
const BINDING: &str = r#"
	local function G(t, f) f.t = t; return f end
	local SW = 1453
	local steps = uistub.guides[uistub.elwynn].steps
	steps[#steps + 1] = { title = "The Binding", goals = {
		G("turnin", { verb = "Turn in", subject = "Surena Caledon", subjectKind = "quest", quest = 1688, npc = 6122, npcName = "Gakin the Darkbinder", map = SW, x = 25.4, y = 78.6, status = "active" }),
		G("use", { verb = "Use", subject = "Bloodstone Choker", subjectKind = "item", item = 6928, quest = 1689, map = SW, x = 25.0, y = 77.4, status = "pending" }),
		G("kill", { verb = "Kill", subject = "Summoned Voidwalker", subjectKind = "npc", npc = 5676, quest = 1689, progress = { cur = 0, max = 1 }, status = "pending" }),
		G("turnin", { verb = "Turn in", subject = "The Binding", subjectKind = "quest", quest = 1689, npc = 6122, npcName = "Gakin the Darkbinder", map = SW, x = 25.4, y = 78.6, status = "pending" }),
	} }
	local s = #steps
	uistub.setGuide(uistub.elwynn, s)
	-- A string's lines as drawn, whether it is cut short with "…", its row's height and where the next item starts.
	local function measure(l, nextOf)
		local fs = l.Text
		local nxt = nextOf and nextOf(l)
		return { text = plain(fs:GetText()), wrap = fs:GetWordWrap(), lines = math.floor(fs:GetStringHeight() / fs:GetLineHeight() + 0.5),
			cut = fs:IsTruncated(), h = l:GetHeight(), gap = nxt and (nxt - l:GetHeight()) or false }
	end
	local function cardNext(l) return GF.ItemTop(GF.CardItems()[l.psAt + 1]) - GF.ItemTop(l) end
"#;

// A player on Discord (0.3.3): "is there a way to have text wrap?" The look-ahead lines cut off mid-word:
// "Then out here: Use Bloodstone Choker, Kill …", "Then: Gakin the Darkbinder · Turn in The Bi…". A line too
// long for one line wraps to a second, its row growing by it and the rows under it moving down; only text
// longer than two lines ends in "…". In the house look the lines after the focus are a footnote instead: one small
// line, cut short with "…" (SL.Quiet); its chevron lists the goals.
#[test]
fn a_look_ahead_line_too_long_for_one_line_wraps_to_two_and_only_past_two_ends_in_an_ellipsis() {
	let out = run(&format!(
		r#"Polestar.Set("ui.skin", "hearth")
		{BINDING}
		local here = lineFor("out here")
		local out = {{ here = measure(here, cardNext), gakin = measure(lineFor("Gakin"), false), lineH = GF.CARD.lineH, one = here.Text:GetLineHeight() }}
		uistub.goal(s, 2).subject = "Bloodstone Choker of the Very Long Name That Goes On and On Past Any Window"
		uistub.goal(s, 3).subject = "Summoned Voidwalker of the Equally Long Name That Goes On Past Any Window"
		uistub.update()
		out.long = measure(lineFor("out here"), false)
		Polestar.Set("ui.skin", "polestar")
		uistub.update()
		out.house = measure(lineFor("out here"), cardNext)
		out.quietH = GF.CARD.quietH
		emit(out)"#
	))
	.remove(0);
	let here = &out["here"];
	assert_eq!(here["text"], "Then out here: Use Bloodstone Choker, Kill Summoned Voidwalker");
	assert_eq!(here["wrap"], true, "the line wraps: {here}");
	assert_eq!(here["lines"], 2, "on two lines: {here}");
	assert_eq!(here["cut"], false, "nothing cut off with \u{2026}: {here}");
	assert_eq!(f(&here["h"]), f(&out["lineH"]) + f(&out["one"]), "the row is one line taller: {here}");
	assert_eq!(f(&here["gap"]), 0.0, "the next item starts right under the taller row: {here}");
	let gakin = &out["gakin"];
	assert_eq!(gakin["text"], "Then: Gakin the Darkbinder  \u{b7}  Turn in “The Binding”");
	assert_eq!(gakin["cut"], false, "Gakin's line is whole too: {gakin}");
	let long = &out["long"];
	assert_eq!(long["lines"], 2, "never more than two lines: {long}");
	assert_eq!(long["cut"], true, "past two lines it ends in \u{2026}: {long}");
	assert_eq!(long["h"], here["h"]);
	let house = &out["house"];
	assert_eq!((house["lines"].clone(), house["cut"].clone()), (json!(1), json!(true)), "the house look: one line, cut with \u{2026}: {house}");
	assert_eq!(f(&house["h"]), f(&out["quietH"]), "on a short row: {house}");
	assert_eq!(f(&house["gap"]), 0.0, "the next item right under it: {house}");
}

// The compact window of the house look keeps the live goals and one quiet "Then" line: no progress bar, no tip,
// the step list button stays.
#[test]
fn the_dense_compact_window_is_the_live_goals_and_one_quiet_then_line() {
	let out = run(&format!(
		r#"{BINDING}
		local P = GF.parts
		local standard = {{ items = items(), foot = P.foot:IsShown() }}
		Polestar.Set("ui.compact", true)
		uistub.update()
		local compact = {{ items = items(), foot = P.foot:IsShown(), tip = P.tip:IsShown(), list = GF.listButton:IsShown(), h = F:GetHeight() }}
		emit({{ standard = standard, compact = compact }})"#
	))
	.remove(0);
	assert_eq!(out["standard"]["foot"], true);
	let c = &out["compact"];
	assert_eq!(strings(&c["items"]).len(), 2, "the live goal and one line: {c}");
	assert!(strings(&c["items"])[1].starts_with("[Then"), "{c}");
	assert_eq!((c["foot"].clone(), c["tip"].clone(), c["list"].clone()), (json!(false), json!(false), json!(false)), "no progress bar, no tip, no list button (the step number opens the list): {c}");
}

// A player on Discord (0.3.3): "there's some duplication with this way". Opened, a look-ahead line repeated
// the goals listed right under it ("Then out here: Use Bloodstone Choker, Kill Summoned Voidwalker" over "Use
// Bloodstone Choker" and "Kill Summoned Voidwalker"). Opened, the line is only the place or the person.
#[test]
fn an_opened_look_ahead_line_names_only_the_place_or_person_and_no_goal_reads_twice() {
	let out = run_hearth(&format!(
		r#"{BINDING}
		stub.RunScript(lineFor("out here"), "OnClick", "LeftButton")
		local here = items()
		stub.RunScript(lineFor("out here"), "OnClick", "LeftButton")
		stub.RunScript(lineFor("Gakin"), "OnClick", "LeftButton")
		emit({{ here = here, gakin = items() }})"#
	))
	.remove(0);
	assert_eq!(strings(&out["here"]), ["Surena Caledon", "[Then out here]+", "Bloodstone Choker", "Summoned Voidwalker", "[Then: Gakin the Darkbinder  \u{b7}  Turn in “The Binding”]"]);
	assert_eq!(strings(&out["gakin"]), ["Surena Caledon", "[Then out here: Use Bloodstone Choker, Kill Summoned Voidwalker]", "[Then: Gakin the Darkbinder]+", "The Binding"]);
	for case in ["here", "gakin"] {
		let items = strings(&out[case]);
		let opened = items.iter().position(|s| s.ends_with("]+")).unwrap();
		for row in items[opened + 1..].iter().take_while(|s| !s.starts_with('[')) {
			assert!(!items[opened].contains(row.as_str()), "{row} reads on the opened line too: {}", items[opened]);
		}
	}
}

// The window's other look-ahead rows (Along the way, Up next, the "Then:" line naming the next step) wrap the
// same way instead of cutting the goal or the step's name off mid-word.
#[test]
fn along_the_way_up_next_and_the_next_step_s_line_wrap_to_two_lines() {
	let out = run(r#"
		local steps = uistub.guides[uistub.elwynn].steps
		steps[7].title = "Echo Ridge Mine, the kobold tunnels past the Northshire vineyards"
		steps[#steps + 1] = { title = "On the way", goals = {
			{ t = "kill", verb = "Kill", subject = "Kobold Vermin at the Echo Ridge Mine entrance", subjectKind = "npc", npc = 6, quest = 7, progress = { cur = 7, max = 10 }, status = "active" },
			{ t = "kill", verb = "Kill", subject = "Young Wolf", subjectKind = "npc", npc = 299, quest = 33, progress = { cur = 0, max = 4 }, status = "active" },
		} }
		uistub.along = { { #steps, { 1, 2 } } }
		Polestar.Set("ui.upcoming", 3)
		Polestar.Set("ui.upcomingOpen", true)
		uistub.setGuide(uistub.elwynn, 5)
		local function measure(r, fs, nxt)
			return { text = plain(fs:GetText()), lines = math.floor(fs:GetStringHeight() / fs:GetLineHeight() + 0.5), cut = fs:IsTruncated(), h = r:GetHeight(),
				gap = (nxt and nxt:IsShown()) and select(5, r:GetPoint(1)) - select(5, nxt:GetPoint(1)) - r:GetHeight() or false }
		end
		local function row(pool, i) return measure(pool[i], pool[i].Text, pool[i + 1]) end
		local after = GF.parts.after
		emit({ along = row(GF.alongRows, 1), up = row(GF.upRows, 1), short = row(GF.alongRows, 2), upShort = row(GF.upRows, 2),
			after = measure(after, after.Text, nil), afterShown = after:IsShown() })"#)
	.remove(0);
	for (case, short) in [("along", "short"), ("up", "upShort"), ("after", "")] {
		let r = &out[case];
		assert_eq!(r["lines"], 2, "{case} wraps to two lines: {r}");
		assert_eq!(r["cut"], false, "{case} is not cut off: {r}");
		if !short.is_empty() {
			assert_eq!(out[short]["lines"], 1, "a short row stays one line: {}", out[short]);
			assert!(f(&r["h"]) > f(&out[short]["h"]), "{case}'s row grows by its second line: {r}");
		}
		if r["gap"] != false {
			assert_eq!(f(&r["gap"]), 0.0, "the next row starts right under it: {r}");
		}
	}
	assert!(text(&out["along"]["text"]).contains("Echo Ridge Mine entrance"), "{}", out["along"]);
	assert!(text(&out["up"]["text"]).contains("Northshire vineyards"), "{}", out["up"]);
	assert_eq!(out["afterShown"], true);
	assert_eq!(out["after"]["text"], "Then: Echo Ridge Mine, the kobold tunnels past the Northshire vineyards");
	assert!(f(&out["after"]["h"]) > 28.0, "the line grows by its second line: {}", out["after"]);
}
