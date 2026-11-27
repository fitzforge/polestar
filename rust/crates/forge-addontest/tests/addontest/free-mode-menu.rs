//! Free mode in the main window (addon/Polestar/UI/FreeMode.lua, Polestar_FreeMode/Page.lua): its menu item right under
//! Guides with its running figure, and its three pages, the sidebar's three entries whether Free mode is on or off:
//! Main page (the hero: the log's first quests in Free mode's order as stars; off one Activate at its centre and the
//! three points, every time, used before or not; on the same hero with "Free mode is on · following N quests" over one
//! Turn off Free mode that goes back to the guide named on the line under it), Your quests (on or off: the route
//! numbered in Free mode's order, the quest it leads to marked while on, the order, the hand-in card and the NPC lines
//! over finished quests, the quests left out folded with Bring back; off, Activate beside it) and About Free mode (its
//! four drawn beats, when to use it, the way back). The game's quest tooltip on hover and gamepad focus, the tab and
//! header glyphs, a gamepad on the pages and the world map's click on a held quest's pin while Free mode is on. The
//! choices are Free mode's own saved state (CharState().free).
//!
//! The Codex is tests/fixtures/codex/free-mode.json with the Highland Ogre an elite (Ogre Menace takes a group): a
//! Human Warrior at level 20 at Marshal Hale's camp (map 9001), 7001-7007 around it (Marshal Hale takes 7001 and
//! 7007) and 7101-7108 in Merrow Fields (map 9002).

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::questdb::{build_db, fixture_dir};
use forge_addontest::{emitted, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

thread_local! {
	static PACK: CodexPack = {
		let mut codex = fixture("free-mode.json");
		codex["npcs"]["5014"]["elite"] = json!(true);
		write_codex_pack(&codex, &CodexOpts::default())
	};
}

fn maps() -> String {
	let codex = fixture("free-mode.json");
	let mut frames: Vec<(&String, &Value)> = codex["frames"].as_object().unwrap().iter().collect();
	frames.sort_by_key(|(id, _)| id.parse::<u64>().unwrap_or(u64::MAX));
	frames
		.into_iter()
		.map(|(id, f)| {
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&codex["zones"][id.as_str()]["name"]).unwrap(),
				f["c"],
				f["left"],
				f["right"],
				f["top"],
				f["bottom"]
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

// The quests as the log takes them, the step titles in order, the page and its rows.
const HELPERS: &str = r#"
local E, F, UI = Polestar.Engine, Polestar.Free, Polestar.UI
local Q = {
	[7001] = { { text = "Ridge Gnoll slain: 0/5", required = 5 } },
	[7002] = { { text = "Boar Tusk: 0/4", required = 4, type = "item" } },
	[7003] = { { text = "Marsh Lurker slain: 0/6", required = 6 } },
	[7004] = { { text = "Highland Ogre slain: 0/3", required = 3 } },
	[7101] = { { text = "Thing: 0/1", required = 1 } },
	[7102] = { { text = "Thing: 0/1", required = 1 } },
	[7007] = { { text = "Ridge Gnoll slain: 0/3", required = 3 } },
}
local TITLE = { [7001] = "Gnoll Trouble", [7002] = "Boar Hunt", [7003] = "Lurkers in the Marsh", [7004] = "Ogre Menace",
	[7101] = "Merrow's Errand", [7102] = "Oake's Fields", [7007] = "Gnoll Bounty" }
local function route()
	Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
	assert(Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 60, steps = {
		{ title = "Go west", goals = { { t = "goto", map = 9001, x = 10, y = 90, text = "West camp" } } },
	} }))
	E.SetGuide("test/route")
end
local function take(...)
	for _, q in ipairs({ ... }) do w.accept(q, Q[q], TITLE[q]) end
	stub.advance(1)
end
local function finish(q, n) w.progress(q, 1, n or 1); stub.advance(1) end
local function titles()
	local out = {}
	for i = 1, E.GetStepCount() do out[i] = E.GetStepView(i).title end
	return out
end
local function page()
	UI.ShowFreeMode("main")
	stub.advance(0.3)
	return F.Page
end
local function quests()
	UI.ShowFreeMode("quests")
	stub.advance(0.3)
	return F.Page
end
local function rowOf(q)
	for _, r in ipairs(F.Page.rows) do if r:IsShown() and r.psQuest == q then return r end end
end
local function shownTitles()
	local out = {}
	for _, r in ipairs(F.Page.Shown()) do out[#out + 1] = r.title end
	return out
end
"#;

fn run_with(script: &str, stubs: Vec<&'static str>) -> Vec<Value> {
	let pack = PACK.with(|p| p.stub_lua.clone());
	let before = format!(
		"{pack}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = 20, \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"WARRIOR\", \"Warrior\"\nw.moveTo(9001, 50, 50)\n",
		maps()
	);
	emitted(&RunAddon { stubs, before, addons: vec![Addon::name("Polestar")], login: true, script: format!("{HELPERS}{script}"), ..Default::default() })
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, vec!["stub_world.lua"])
}

// A Lua list of numbers (an empty table is emitted as {}).
fn nums(v: &Value) -> Vec<i64> {
	v.as_array().map(|a| a.iter().map(|n| n.as_i64().unwrap()).collect()).unwrap_or_default()
}

fn strs(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|s| text(s).to_string()).collect()).unwrap_or_default()
}

#[test]
fn free_mode_is_a_menu_item_right_under_guides_with_its_running_figure_and_a_page_whose_header_fits() {
	let out = run(r#"
UI.ShowPicker()
stub.advance(0.3)
local P = UI.Picker
local keys, icon, label = {}, nil, nil
for _, s in ipairs(P.Sections()) do
	keys[#keys + 1] = s.key
	if s.key == "FreeMode" then icon, label = s.icon, s.label end
end
local rail = {}
for _, b in ipairs(PolestarPicker.railButtons or {}) do
	if b:IsShown() and b.psKey ~= "Options" then rail[#rail + 1] = b.psKey end
end
P.ShowSection("FreeMode")
stub.advance(0.3)
local nav = {}
for _, b in ipairs(PolestarPicker.navButtons or {}) do if b:IsShown() then nav[#nav + 1] = b.psKey end end
local labels = {}
for _, it in ipairs((F.Page.Nav())) do labels[#labels + 1] = it.label end
emit({ keys = keys, rail = rail, icon = icon, label = label, section = P.Section(), page = F.Page ~= nil, title = PolestarPicker.Title:GetText(),
	subtitle = PolestarPicker.Subtitle:GetText(), nav = nav, labels = labels, shown = F.Page.Shown().page })
"#);
	let o = &out[0];
	let keys = strs(&o["keys"]);
	assert_eq!(keys[0], "Guides");
	assert_eq!(keys[1], "FreeMode", "right under Guides: {keys:?}");
	assert_eq!(keys[2], "Lookup", "and before Lookup: {keys:?}");
	assert_eq!(strs(&o["rail"])[..2], ["Guides", "FreeMode"]);
	assert_eq!(text(&o["icon"]), "icon-freemode", "the running figure");
	assert_eq!(text(&o["label"]), "Free mode");
	assert_eq!(text(&o["section"]), "FreeMode");
	assert!(truthy(&o["page"]), "the page loads with its folder");
	assert_eq!(text(&o["title"]), "Free mode");
	assert_eq!(text(&o["subtitle"]), "Your own quests, planned for you.", "whole, no ellipsis (try4 cut it off)");
	assert_eq!(strs(&o["nav"]), ["main", "quests", "about"], "the sidebar holds the section's three pages, not a lone Free mode row");
	assert_eq!(strs(&o["labels"]), ["Main page", "Your quests", "About Free mode"]);
	assert_eq!(text(&o["shown"]), "main", "it opens on the Main page");
}

#[test]
fn off_the_main_page_is_a_hero_activate_at_its_centre_under_the_log_in_its_order_as_a_constellation() {
	let out = run(r#"
take(7001, 7002, 7003, 7101)
local P = page()
local s = P.Shown()
local H = F.Hero.parts
local order = {}
for _, r in ipairs(F.Route()) do order[#order + 1] = r.title end
local rows = {}
for _, r in ipairs(s) do rows[#rows + 1] = { r.n, r.title } end
local labels = {}
for i = 1, 3 do labels[i] = H.Labels[i].title:IsShown() and H.Labels[i].title:GetText() or false end
local got = { page = s.page, on = s.on, hero = s.hero, lead = s.lead, more = s.more, start = s.start, note = s.note, rows = rows, order = order, labels = labels,
	intro = { H.Title:IsShown(), H.Lead:IsShown(), H.Points[1]:IsShown(), H.Points[3]:IsShown(), H.Back:IsShown(), H.Emblem:IsShown() },
	button = P.parts.Start:IsShown() and P.parts.Start.Label:GetText() or false, order_shown = P.parts.Near:IsShown(),
	stop = P.parts.Stop:IsShown(), status = H.Status:IsShown() }
P.parts.Start:Click()
stub.advance(1)
got.after = { F.IsOn(), P.Shown().page, P.Shown().stop or false }
emit(got)
"#);
	let o = &out[0];
	assert_eq!(text(&o["page"]), "main");
	assert_eq!(o["on"], false);
	assert_eq!(text(&o["hero"]), "sky", "the constellation by default");
	assert_eq!(o["intro"], json!([true, true, true, true, true, true]), "the tagline and lead, the three points, the line under the button, the emblem");
	let order = strs(&o["order"]);
	assert_eq!(o["rows"], json!([[1, order[0]], [2, order[1]], [3, order[2]]]), "the first three in Free mode's own order");
	assert_eq!(o["labels"], json!([order[0], order[1], order[2]]), "a star each, named, in that order");
	let lead = text(&o["lead"]);
	assert_eq!(lead, format!("Free mode would start with {}", order[0]));
	assert_eq!(o["more"], 1);
	assert_eq!(text(&o["button"]), "Activate Free mode", "one big Activate");
	assert_eq!(text(&o["start"]), "Activate Free mode");
	assert_eq!(text(&o["note"]), "Turn it off any time, here or from the guide window's menu.");
	assert_eq!(o["order_shown"], false, "the order is Your quests'");
	assert_eq!((o["stop"].clone(), o["status"].clone()), (json!(false), json!(false)), "no Turn off or state line while off");
	assert_eq!(o["after"], json!([true, "main", "Turn off Free mode"]), "on, the same page with Turn off");
}

#[test]
fn after_a_first_use_and_off_again_the_main_page_is_the_same_intro_every_time_with_no_order_or_folds_of_its_own() {
	let out = run(r#"
take(7001, 7002, 7003, 7101)
local P = page()
local H = F.Hero.parts
local function keys()
	local k = {}
	for _, it in ipairs((P.Nav())) do k[#k + 1] = it.key end
	return k
end
local function intro()
	P.Render()
	local s = P.Shown()
	return { page = s.page, on = s.on, hero = s.hero, lead = s.lead, more = s.more, start = s.start, count = #s, note = s.note,
		title = H.Title:IsShown(), points = H.Points[1]:IsShown() and H.Points[3]:IsShown(), emblem = H.Emblem:IsShown(),
		order = P.parts.Near:IsShown(), left_out = P.parts.OutH:IsShown(), route = P.parts.RouteH:IsShown(),
		button = P.parts.Start:IsShown() and P.parts.Start.Label:GetText() or false, nav = keys() }
end
local first = intro()
P.parts.Start:Click()
stub.advance(1)
local on = { F.IsOn(), P.Shown().page, keys() }
F.Stop()
stub.advance(1)
local again = intro()
emit({ first = first, on = on, again = again, kept = F.Used ~= nil or F.MarkUsed ~= nil })
"#);
	let o = &out[0];
	assert_eq!(o["on"], json!([true, "main", ["main", "quests", "about"]]), "on: the same page, the same sidebar");
	assert_eq!(o["again"], o["first"], "used before, the page is the very same intro: {o}");
	let a = &o["again"];
	assert_eq!(text(&a["page"]), "main");
	assert_eq!(a["on"], false);
	assert_eq!(text(&a["start"]), "Activate Free mode");
	assert_eq!(text(&a["button"]), "Activate Free mode");
	assert_eq!(a["count"], 3, "the first three it would take");
	assert_eq!(a["more"], 1);
	assert_eq!((a["title"].clone(), a["points"].clone(), a["emblem"].clone()), (json!(true), json!(true), json!(true)), "the tagline, the three points, the emblem");
	assert_eq!((a["order"].clone(), a["left_out"].clone(), a["route"].clone()), (json!(false), json!(false), json!(false)), "no order, folds or route rows on the Main page");
	assert_eq!(strs(&a["nav"]), ["main", "quests", "about"], "the same sidebar off as on");
	assert_eq!(o["kept"], false, "nothing remembers a first use any more");
}

// The hero's three compositions (the dev switch PolestarDB.devFreeHero), and with an empty log: Activate is centred in the column, the emblem in the accent, the preview the first three quests.
#[test]
fn every_hero_composition_centres_activate_under_the_emblem_in_the_accent() {
	let out = run(r#"
take(7001, 7002, 7003, 7101)
local P = page()
local H = F.Hero.parts
local T = Polestar.Theme
local function same(a, b)
	for i = 1, 3 do if math.abs(a[i] - b[i]) > 0.002 then return false end end
	return true
end
local out = {}
for _, d in ipairs({ "sky", "polaris", "seal", "nope" }) do
	Polestar.DB().devFreeHero = d
	P.Render()
	local s = P.Shown()
	local b = P.parts.Start
	local _, _, _, x = b:GetPoint(1)
	local mid = P.parts.Start:GetParent():GetWidth() / 2
	out[#out + 1] = { d = d, hero = s.hero, page = s.page, label = b.Label:GetText(), h = b:GetHeight(),
		centred = math.abs(x + b:GetWidth() / 2 - mid) < 1, accent = same({ H.Emblem:GetVertexColor() }, { T.Color("accent") }),
		rows = #s, lead = s.lead or false }
end
Polestar.DB().devFreeHero = nil
for _, q in ipairs({ 7001, 7002, 7003, 7101 }) do stub.world.abandon(q) end
stub.advance(1)
P.Render()
out[#out + 1] = { empty = P.Shown().empty or false, label = P.parts.Start:IsShown() and P.parts.Start.Label:GetText() or false }
emit(out)
"#);
	let all = out[0].as_array().unwrap();
	for o in &all[..4] {
		let d = text(&o["d"]);
		assert_eq!(text(&o["hero"]), if d == "nope" { "sky" } else { d }, "an unknown switch is the default");
		assert_eq!(text(&o["page"]), "main");
		assert_eq!(text(&o["label"]), "Activate Free mode", "{d}");
		assert_eq!(o["h"], 44, "{d}: the big button");
		assert_eq!(o["centred"], true, "{d}: Activate centred in the column");
		assert_eq!(o["accent"], true, "{d}: the emblem wears the accent");
		assert_eq!(o["rows"], 3, "{d}: the first three quests");
		assert!(text(&o["lead"]).starts_with("Free mode would start with "), "{d}: {}", o["lead"]);
	}
	assert_eq!(all[4], json!({ "empty": true, "label": "Activate Free mode" }), "an empty log: the sky says how to fill it");
}

// On, the Main page is the same hero: the stars are the route's first quests, the state line over one Turn off Free
// mode, centred and as big as Activate, and the guide it goes back to as a plain line under it, in every composition.
// Turn off hands the arrow back to that guide and the page is the intro again. No "Back to <guide>" button anywhere.
#[test]
fn on_the_main_page_is_the_same_hero_with_the_state_and_one_turn_off_that_returns_to_the_guide() {
	let out = run(r#"
route()
take(7001, 7002, 7003)
assert(F.Start())
stub.advance(1)
local P = page()
local H = F.Hero.parts
local out = { looks = {} }
for _, d in ipairs({ "sky", "polaris", "seal" }) do
	Polestar.DB().devFreeHero = d
	P.Render()
	local s = P.Shown()
	local b = P.parts.Stop
	local _, _, _, x = b:GetPoint(1)
	local mid = b:GetParent():GetWidth() / 2
	out.looks[#out.looks + 1] = { d = d, page = s.page, on = s.on, status = s.status, stop = s.stop, note = s.note, start = s.start or false,
		label = b:IsShown() and b.Label:GetText() or false, h = b:GetHeight(), centred = math.abs(x + b:GetWidth() / 2 - mid) < 1,
		activate = P.parts.Start:IsShown(), statusShown = H.Status:IsShown() and H.StatusIcon:IsShown(), stars = #s, lead = s.lead or false }
end
Polestar.DB().devFreeHero = nil
local backs = {}
for k, f in pairs(P.parts) do
	if type(f) == "table" and f.Label and f:IsShown() and (f.Label:GetText() or ""):find("^Back to") then backs[#backs + 1] = k end
end
out.backs, out.back = backs, P.parts.Back ~= nil
P.parts.Stop:Click()
stub.advance(1)
out.after = { E.GetGuide().id, F.IsOn(), P.Shown().page, P.Shown().start or false }
emit(out)
"#);
	let o = &out[0];
	for l in o["looks"].as_array().unwrap() {
		let d = text(&l["d"]);
		assert_eq!(text(&l["page"]), "main", "{d}");
		assert_eq!(l["on"], true, "{d}");
		assert_eq!(text(&l["status"]), "Free mode is on \u{b7} following 3 quests", "{d}: the state, plainly");
		assert_eq!(l["statusShown"], true, "{d}: the state line and its running figure are drawn");
		assert_eq!(text(&l["stop"]), "Turn off Free mode", "{d}");
		assert_eq!(text(&l["label"]), "Turn off Free mode", "{d}: one Turn off");
		assert_eq!(l["h"], 44, "{d}: as big as Activate");
		assert_eq!(l["centred"], true, "{d}: at the hero's centre");
		assert_eq!(text(&l["note"]), "Takes you back to Route", "{d}: the guide it goes back to, as a plain line");
		assert_eq!((l["activate"].clone(), l["start"].clone()), (json!(false), json!(false)), "{d}: no Activate while on");
		assert_eq!(l["stars"], 3, "{d}: the route's first three");
		assert!(text(&l["lead"]).starts_with("Free mode is leading you to "), "{d}: {}", l["lead"]);
	}
	assert!(strs(&o["backs"]).is_empty(), "no Back to <guide> button: {}", o["backs"]);
	assert_eq!(o["back"], false, "the Back button is gone");
	assert_eq!(o["after"], json!(["test/route", false, "main", "Activate Free mode"]), "Turn off hands the arrow back; the page is the intro again");
}

#[test]
fn your_quests_on_follows_the_route_numbered_in_free_mode_s_order_the_current_quest_marked() {
	let out = run(r#"
route()
take(7001, 7002, 7003)
finish(7001, 2)
assert(F.Start())
stub.advance(1)
local P = quests()
local s = P.Shown()
local rows, byTitle = {}, {}
for _, r in ipairs(s) do
	rows[#rows + 1] = { n = r.n, title = r.title, current = r.current and true or false }
	byTitle[r.title] = { progress = r.progress, zone = r.zone, walk = r.travel ~= nil, xp = (r.xp or 0) > 0 }
end
local first = rowOf(s[1].quest)
local second = rowOf(s[2].quest)
emit({ page = s.page, status = s.status, start = s.start or false, activate = P.parts.Activate:IsShown(), stop = P.parts.Stop:IsShown(),
	rows = rows, gnoll = byTitle["Gnoll Trouble"], steps = titles(), marked = { first.Sel:IsShown(), first.Bar:IsShown(), second.Sel:IsShown() } })
"#);
	let o = &out[0];
	assert_eq!(text(&o["page"]), "quests");
	assert_eq!(text(&o["status"]), "Free mode is on \u{b7} following 3 quests");
	assert_eq!((o["start"].clone(), o["activate"].clone(), o["stop"].clone()), (json!(false), json!(false), json!(false)), "on and off are the Main page's");
	let steps = strs(&o["steps"]);
	let rows = o["rows"].as_array().unwrap();
	for (i, r) in rows.iter().enumerate() {
		assert_eq!(r["n"], i + 1);
		assert_eq!(text(&r["title"]), steps[i], "numbered in the order the arrow takes them: {o}");
		assert_eq!(r["current"], i == 0, "only the quest the arrow leads to now is marked");
	}
	assert_eq!(o["marked"], json!([true, true, false]));
	assert_eq!(o["gnoll"], json!({ "progress": "2/5", "zone": "Hale's Reach", "walk": true, "xp": true }));
}

// Off, Your quests is the same list: every quest in the order Free mode would take them, with their progress, walk,
// XP, zone, flag and tick, the order and the hand-in card, nothing marked as led to, and Activate beside the state.
#[test]
fn your_quests_off_is_the_same_list_in_the_order_free_mode_would_take_with_activate() {
	let out = run(r#"
take(7001, 7002, 7003)
finish(7001, 5)
local P = quests()
local s = P.Shown()
local rows, marked = {}, false
for _, r in ipairs(s) do
	rows[#rows + 1] = r.title
	if r.current then marked = true end
end
local order = {}
for _, r in ipairs(F.Route()) do order[#order + 1] = r.title end
local r = rowOf(7002)
local got = { page = s.page, on = s.on, status = s.status, start = s.start, activate = P.parts.Activate:IsShown() and P.parts.Activate.Label:GetText() or false,
	rows = rows, order = order, marked = marked, near = P.parts.Near:IsShown(), handin = s.handin.shown, controls = { r.Pin:IsShown(), r.Check:IsShown(), r.Zone:IsShown(), r.XP:IsShown() } }
r.Pin:Click()
stub.advance(1)
got.pinned, got.first = F.Pinned(), P.Shown()[1].title
P.parts.Activate:Click()
stub.advance(1)
got.after = { F.IsOn(), P.Shown().page, P.Shown().status }
emit(got)
"#);
	let o = &out[0];
	assert_eq!(text(&o["page"]), "quests");
	assert_eq!(o["on"], false);
	assert_eq!(text(&o["status"]), "Free mode is off \u{b7} the order it would take");
	assert_eq!(text(&o["start"]), "Activate Free mode");
	assert_eq!(text(&o["activate"]), "Activate Free mode");
	assert_eq!(o["rows"], o["order"], "every quest, in Free mode's order");
	assert_eq!(o["rows"].as_array().unwrap().len(), 3);
	assert_eq!(o["marked"], false, "nothing is led to while off");
	assert_eq!(o["near"], true, "the order");
	assert_eq!(o["handin"], true, "the hand-in card");
	assert_eq!(o["controls"], json!([true, true, true, true]), "the full rows: flag, tick, zone, XP");
	assert_eq!(o["pinned"], 7002, "the flag pins it off too");
	assert_eq!(text(&o["first"]), "Boar Hunt", "and the order follows");
	assert_eq!(o["after"], json!([true, "quests", "Free mode is on \u{b7} following 3 quests"]), "Activate turns it on in place");
}

// try4: "most XP for the trip" stood on all five rows and "ready to hand in" beside Ready. A why line says only what
// tells its row from the others: a reason every shown row has goes (the first row keeps its strongest), a Ready row
// never repeats it, two reasons at most; the tooltip keeps them all.
#[test]
fn the_route_s_why_lines_say_only_what_tells_a_row_from_the_others() {
	let out = run(r#"
take(7001, 7007, 7002, 7003, 7101)
finish(7001, 5)
finish(7007, 3)
finish(7101)
finish(7002, 2)
assert(F.Start())
stub.advance(1)
local P = quests()
local rows, all = {}, {}
local list = F.Route()
for i, r in ipairs(P.Shown()) do
	rows[i] = { why = r.why or false, ready = r.ready and true or false }
	local texts = {}
	for _, x in ipairs(F.ReasonList(list, i)) do texts[#texts + 1] = x.text end
	all[i] = texts
end
local r = rowOf(P.Shown()[2].quest)
r:GetScript("OnEnter")(r)
emit({ rows = rows, all = all, tip = GameTooltip.lines })
"#);
	let o = &out[0];
	let rows = o["rows"].as_array().unwrap();
	assert!(rows.len() >= 3, "{o}");
	let whys: Vec<Vec<String>> = rows.iter().map(|r| r["why"].as_str().map(|s| s.split(" \u{b7} ").map(String::from).collect()).unwrap_or_default()).collect();
	assert!(!whys[0].is_empty(), "the current row keeps its strongest reason: {o}");
	for (i, w) in whys.iter().enumerate() {
		assert!(w.len() <= 2, "two reasons at most: {o}");
		if rows[i]["ready"] == true {
			assert!(!w.contains(&"ready to hand in".to_string()), "a Ready row never says it again: {o}");
		}
	}
	// The case the rule is for: a reason Order.Why gives every row is not shown on the rows after the first.
	let all: Vec<Vec<String>> = o["all"].as_array().unwrap().iter().map(strs).collect();
	let shared: Vec<&String> = all[0].iter().filter(|t| all.iter().all(|a| a.contains(t))).collect();
	assert!(!shared.is_empty(), "the log gives every row a reason in common: {o}");
	for t in &shared {
		for w in whys.iter().skip(1) {
			assert!(!w.contains(t), "{t} is on every row, so not shown: {o}");
		}
	}
	let tip = strs(&o["tip"]);
	assert!(tip.iter().any(|l| shared.iter().any(|t| l.contains(t.as_str()))), "the tooltip keeps every reason: {tip:?}");
}

// Fitz, try6 (1244 px hub): the progress column cut "Ready" to "Rea…". The count's width is its longest text's, measured
// in the look's number font at every draw: "Ready" (in any language), "888/888", never cut, whatever the look.
#[test]
fn a_row_s_progress_column_is_as_wide_as_its_longest_text_whatever_the_hub_s_width_look_or_language() {
	let out = run(r#"
take(7001, 7002, 7003)
finish(7001, 5)
finish(7002, 2)
assert(F.Start())
stub.advance(1)
local P = quests()
local function measure()
	P.Render()
	local out = {}
	for _, r in ipairs(P.rows) do
		if r:IsShown() then
			local c = r.Count
			out[#out + 1] = { text = c:GetText(), need = c:GetUnboundedStringWidth(), have = c:GetWidth(), title = r.Title:GetWidth(), shown = c:IsShown() }
		end
	end
	return out
end
local got = { hub = {}, looks = {}, long = {} }
for _, w in ipairs({ 1244, 900 }) do
	PolestarPicker:SetSize(w, 760)
	got.hub[#got.hub + 1] = { w = w, rows = measure() }
end
for _, look in ipairs({ "polestar", "halo", "hearth", "forever", "blizzard", "classic" }) do
	Polestar.Set("ui.skin", look)
	stub.advance(0.3)
	got.looks[#got.looks + 1] = { look = look, rows = measure() }
end
Polestar.L["Ready"] = "Ready to hand in now"
got.long = measure()
rawset(Polestar.L, "Ready", nil)
emit(got)
"#);
	let o = &out[0];
	let check = |what: &str, rows: &Value| {
		let rows = rows.as_array().unwrap();
		assert!(rows.len() >= 3, "{what}: {o}");
		for r in rows {
			if r["shown"] == json!(true) {
				let (need, have) = (r["need"].as_f64().unwrap(), r["have"].as_f64().unwrap());
				assert!(have >= need, "{what}: {} is {need} wide in a {have} wide column: {o}", text(&r["text"]));
				assert!(r["title"].as_f64().unwrap() >= 80.0, "{what}: the title keeps its room: {o}");
			}
		}
	};
	for h in o["hub"].as_array().unwrap() {
		check(&format!("hub {}", h["w"]), &h["rows"]);
	}
	for l in o["looks"].as_array().unwrap() {
		check(&format!("look {}", text(&l["look"])), &l["rows"]);
	}
	check("a long Ready", &o["long"]);
	assert!(o["long"].as_array().unwrap().iter().any(|r| text(&r["text"]) == "Ready to hand in now"), "the long text is on a row: {o}");
}

#[test]
fn finished_quests_one_npc_takes_stand_under_its_name_and_the_hand_in_card_counts_them_with_the_trip() {
	let out = run(r#"
take(7001, 7007, 7002, 7003)
finish(7001, 5)
finish(7007, 3)
assert(F.Start())
stub.advance(1)
local P = quests()
local s = P.Shown()
local ready = {}
for _, r in ipairs(s) do if r.ready then ready[#ready + 1] = r.progress end end
emit({ groups = s.groups, line = P.groups[1] and P.groups[1].Text:GetText() or false, ready = ready, handin = s.handin })
"#);
	let o = &out[0];
	let groups = o["groups"].as_array().unwrap();
	assert_eq!(groups.len(), 1, "{o}");
	assert_eq!(text(&groups[0]["npc"]), "Marshal Hale");
	let mut qs: Vec<i64> = groups[0]["quests"].as_array().unwrap().iter().map(|v| v.as_i64().unwrap()).collect();
	qs.sort();
	assert_eq!(qs, [7001, 7007], "both finished quests under the NPC who takes them");
	assert!(text(&o["line"]).contains("Marshal Hale"), "{o}");
	assert_eq!(strs(&o["ready"]), ["ready", "ready"]);
	assert_eq!(o["handin"]["count"], 2);
	assert_eq!(text(&o["handin"]["text"]), "Hand in finished quests (2)");
	let sub = text(&o["handin"]["sub"]);
	assert!(sub.starts_with("About ") && sub.ends_with(" min, 1 stop"), "the trip's time and its one stop: {sub}");
}

#[test]
fn the_order_choice_is_the_free_pick_setting_with_a_line_on_what_it_does() {
	let out = run(r#"
take(7001, 7002)
assert(F.Start())
stub.advance(1)
local P = quests()
P.parts.XP:Click()
stub.advance(0.5)
local xp = { Polestar.Get("free.pick"), P.Shown().pick, P.Shown().rule }
P.parts.Near:Click()
stub.advance(0.5)
emit({ xp = xp, near = { Polestar.Get("free.pick"), P.Shown().pick, P.Shown().rule } })
"#);
	assert_eq!(out[0]["xp"], json!(["xp", "xp", "The most XP for each minute of walking and work first."]));
	assert_eq!(out[0]["near"], json!(["near", "near", "The quest you reach soonest first, its neighbours after it."]));
}

#[test]
fn the_tick_leaves_a_quest_out_into_its_folded_section_bring_back_returns_it_and_the_flag_pins_it_first() {
	let out = run(r#"
take(7001, 7002, 7003)
assert(F.Start())
stub.advance(1)
local normal = titles()
local P = quests()
-- Untick Gnoll Trouble: out of the route, under Left out (folded).
rowOf(7001).Check:Click()
stub.advance(1)
local left = { titles = titles(), shown = shownTitles(), out = F.LeftOut(), section = P.Shown().out, open = P.Shown().outOpen, count = P.parts.OutH.Count:GetText() }
P.parts.OutH:Click()
stub.advance(0.1)
left.opened = P.Shown().outOpen
local orow
for _, r in ipairs(P.outRows) do if r:IsShown() then orow = r end end
left.row = orow.Title:GetText()
orow.Back:Click()
stub.advance(1)
local back = { titles = titles(), out = F.LeftOut(), shown = shownTitles() }
-- Pin the far one: it comes first, whatever the order.
rowOf(7003).Pin:Click()
stub.advance(1)
local pinned = { titles = titles(), pinned = F.Pinned(), first = P.Shown()[1].title, flag = P.Shown()[1].pinned }
local saved = Polestar.CharState().free
local state = { pin = saved.pin, out = saved.out[7001] }
rowOf(7003):Click()
stub.advance(1)
emit({ normal = normal, left = left, back = back, pinned = pinned, state = state, unpinned = { titles = titles(), pinned = F.Pinned() or false } })
"#);
	let o = &out[0];
	assert_eq!(strs(&o["normal"])[0], "Gnoll Trouble");
	assert_eq!(strs(&o["left"]["titles"]), ["Boar Hunt", "Lurkers in the Marsh"], "{o}");
	assert_eq!(o["left"]["shown"], o["left"]["titles"], "the route shows what the arrow takes");
	assert_eq!(nums(&o["left"]["out"]), vec![7001]);
	assert_eq!(nums(&o["left"]["section"]), vec![7001], "under Left out");
	assert_eq!(o["left"]["open"], false, "folded");
	assert_eq!(text(&o["left"]["count"]), "1");
	assert_eq!(o["left"]["opened"], true);
	assert_eq!(text(&o["left"]["row"]), "Gnoll Trouble");
	assert!(nums(&o["back"]["out"]).is_empty(), "Bring back");
	assert_eq!(strs(&o["back"]["titles"])[0], "Gnoll Trouble");
	assert_eq!(o["back"]["shown"], o["back"]["titles"]);
	assert_eq!(strs(&o["pinned"]["titles"])[0], "Lurkers in the Marsh");
	assert_eq!(o["pinned"]["pinned"], 7003);
	assert_eq!(text(&o["pinned"]["first"]), "Lurkers in the Marsh");
	assert_eq!(o["pinned"]["flag"], true);
	assert_eq!(o["state"], json!({ "pin": 7003 }), "Free mode's own saved state, no second store");
	assert_eq!(strs(&o["unpinned"]["titles"])[0], "Gnoll Trouble", "a click on the pinned row unpins it");
	assert_eq!(o["unpinned"]["pinned"], false);
}

#[test]
fn the_quick_actions_leave_out_a_zone_or_the_quests_that_take_a_group_and_one_button_brings_them_back() {
	let out = run(r#"
take(7001, 7004, 7101, 7102)
assert(F.Start())
stub.advance(1)
local P = quests()
local zones = {}
for _, z in ipairs(F.Zones()) do zones[#zones + 1] = { z.name, #z.quests } end
local before = P.Shown().actions
-- The group action: Ogre Menace (an elite objective).
P.parts.Group:Click()
stub.advance(1)
local group = { out = F.LeftOut(), titles = titles(), actions = P.Shown().actions }
-- The zone action: the zone's menu, then its row.
P.parts.Zone:Click()
local items = {}
for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then items[#items + 1] = r.Text:GetText() end end
for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText():find("Merrow", 1, true) then r:Click() break end end
stub.advance(1)
local zone = { out = F.LeftOut(), titles = titles(), actions = P.Shown().actions, back = P.parts.BackAll.Label:GetText() }
P.parts.BackAll:Click()
stub.advance(1)
emit({ zones = zones, before = before, group = group, items = items, zone = zone, after = { out = F.LeftOut(), titles = titles() } })
"#);
	let o = &out[0];
	assert_eq!(o["zones"], json!([["Hale's Reach", 2], ["Merrow Fields", 2]]), "the zones of the quests in the loop, the busiest first, then by name");
	assert_eq!(o["before"], json!({ "zones": 2, "group": 1, "out": 0 }));
	assert_eq!(nums(&o["group"]["out"]), vec![7004]);
	assert!(!strs(&o["group"]["titles"]).contains(&"Ogre Menace".to_string()));
	assert_eq!(o["group"]["actions"]["group"], 0);
	assert_eq!(strs(&o["items"]), ["Merrow Fields (2)", "Hale's Reach (1)"]);
	assert_eq!(nums(&o["zone"]["out"]), vec![7004, 7101, 7102]);
	assert_eq!(strs(&o["zone"]["titles"]), ["Gnoll Trouble"]);
	assert_eq!(text(&o["zone"]["back"]), "Bring back left-out quests (3)");
	assert!(nums(&o["after"]["out"]).is_empty());
	assert_eq!(strs(&o["after"]["titles"]).len(), 4);
}

#[test]
fn the_hand_in_card_shows_only_with_finished_quests_and_opens_the_shortest_trip_guide() {
	let out = run(r#"
take(7001, 7002)
local P = quests()
local none = { P.Shown().handin.shown, P.parts.Handin:IsShown() }
finish(7001, 5)
finish(7002, 4)
stub.advance(0.5)
local two = { P.Shown().handin.text, P.Shown().handin.shown }
P.parts.Handin:Click()
stub.advance(1)
local tabs = {}
for _, t in ipairs(E.GetTabs()) do tabs[#tabs + 1] = t.guideId end
emit({ none = none, two = two, tabs = tabs, guide = E.GetGuide().id })
"#);
	let o = &out[0];
	assert_eq!(o["none"], json!([false, false]), "no card with nothing to hand in");
	assert_eq!(o["two"], json!(["Hand in finished quests (2)", true]));
	assert_eq!(text(&o["guide"]), "lookup/carried/log");
	assert!(strs(&o["tabs"]).contains(&"lookup/carried/log".to_string()));
}

#[test]
fn hovering_a_row_or_a_gamepad_focus_on_it_shows_the_game_s_quest_tooltip_with_where_why_and_objectives() {
	let out = run(r#"
take(7001, 7002)
finish(7001, 2)
assert(F.Start())
stub.advance(1)
local P = quests()
local r = rowOf(7001)
r:GetScript("OnEnter")(r)
local hover = { owner = GameTooltip:GetOwner() == r, link = GameTooltip.link, lines = GameTooltip.lines, shown = P.Shown().tip }
r:GetScript("OnLeave")(r)
local gone = P.Shown().tip or false
local r2 = rowOf(7002)
r2.psOnPadFocus(r2, true)
local pad = { owner = GameTooltip:GetOwner() == r2, link = GameTooltip.link }
r2.psOnPadFocus(r2, false)
emit({ hover = hover, gone = gone, pad = pad, padGone = P.Shown().tip or false })
"#);
	let o = &out[0];
	assert_eq!(o["hover"]["owner"], true);
	assert_eq!(text(&o["hover"]["link"]), "quest:7001", "the game's own quest tooltip");
	let lines = strs(&o["hover"]["lines"]);
	assert!(lines.iter().any(|l| l.starts_with("Hale's Reach")), "where: {lines:?}");
	assert!(lines.iter().any(|l| l.contains("Ridge Gnoll slain")), "the objectives: {lines:?}");
	assert_eq!(o["hover"]["shown"], 7001);
	assert_eq!(o["gone"], false);
	assert_eq!(o["pad"], json!({ "owner": true, "link": "quest:7002" }), "a gamepad's focus shows it too");
	assert_eq!(o["padGone"], false);
}

// The sidebar's three entries are pages, not places on one page: each click shows its own page from its top, on and
// off, with the entry marked. Your quests works while Free mode is off (try7: its click did nothing).
#[test]
fn every_sidebar_entry_shows_its_own_page_on_and_off_and_your_quests_works_off() {
	let out = run(r#"
take(7001, 7002)
finish(7001, 5)
local function nav()
	local items = {}
	for _, b in ipairs(PolestarPicker.navButtons) do
		if b:IsShown() then items[#items + 1] = { b.psKey, b.Count:IsShown() and b.Count:GetText() or "" } end
	end
	return items
end
local function click(key)
	for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() and b.psKey == key then b:Click() end end
	stub.advance(0.1)
	local active
	for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() and b.psOn then active = b.psKey end end
	local s = F.Page.Shown()
	return { active = active, page = s.page, hero = F.Hero.parts.Title:IsShown(), rows = #s, near = F.Page.parts.Near:IsShown(), beats = s.beats and #s.beats or 0 }
end
local function walk() return { nav = nav(), main = click("main"), quests = click("quests"), about = click("about") } end
page()
local off = walk()
assert(F.Start())
stub.advance(1)
F.LeaveOut(7002, true)
stub.advance(1)
page()
local on = walk()
emit({ off = off, on = on })
"#);
	let o = &out[0];
	assert_eq!(o["off"]["nav"], json!([["main", ""], ["quests", "2"], ["about", ""]]), "the same three entries off");
	assert_eq!(o["on"]["nav"], json!([["main", ""], ["quests", "1"], ["about", ""]]), "and on (Left out is Your quests', not an entry)");
	for (state, n) in [("off", 2), ("on", 1)] {
		let w = &o[state];
		for key in ["main", "quests", "about"] {
			assert_eq!(text(&w[key]["active"]), key, "{state}: {key} is marked");
			assert_eq!(text(&w[key]["page"]), key, "{state}: {key} shows its own page");
		}
		assert_eq!((w["main"]["hero"].clone(), w["main"]["near"].clone()), (json!(true), json!(false)), "{state}: the Main page is the hero");
		assert_eq!((w["quests"]["hero"].clone(), w["quests"]["near"].clone(), w["quests"]["rows"].clone()), (json!(false), json!(true), json!(n)), "{state}: Your quests is the list");
		assert_eq!((w["about"]["hero"].clone(), w["about"]["near"].clone(), w["about"]["beats"].clone()), (json!(false), json!(false), json!(4)), "{state}: About is its own page");
	}
}

#[test]
fn a_gamepad_reaches_activate_then_the_order_and_every_row_a_pins_a_row_x_leaves_it_out_and_its_focus_shows_the_tooltip() {
	let out = run_with(
		r#"
Polestar.Set("gamepad.withMouse", true)
stub.advance(3)
if PolestarWelcome then PolestarWelcome:Hide() end
take(7001, 7002, 7003)
local G = Polestar.Gamepad
page()
stub.advance(0.3)
local owner = G.owner and G.owner:GetName()
local function collect()
	local reach = {}
	for _, c in ipairs(G.Collect(PolestarPicker)) do
		if c.psQuest then reach[#reach + 1] = c.psQuest elseif c == F.Page.parts.Start then reach[#reach + 1] = "start"
		elseif c == F.Page.parts.Activate then reach[#reach + 1] = "activate" elseif c == F.Page.parts.Near then reach[#reach + 1] = "near" end
	end
	return reach
end
local off = collect()
quests()
local offQuests = collect()
assert(F.Start())
stub.advance(1)
quests()
stub.advance(0.3)
local reach = collect()
stub.press("PADDDOWN")
local row = rowOf(7002)
G.SetFocus(PolestarPicker, row)
stub.advance(0.1)
local focused = G.Focused(PolestarPicker) == row
local tip = GameTooltip:GetOwner() == row
local label = row.psPadLabel
stub.press("PAD1")
stub.advance(0.5)
local pinned = F.Pinned()
local still = G.Focused(PolestarPicker) == rowOf(7002)
stub.press("PAD1")
stub.advance(0.5)
local unpinned = F.Pinned() or false
local xlabel = row.psPadXLabel()
stub.press("PAD3")
stub.advance(0.5)
emit({ off = off, offQuests = offQuests, reach = reach, focused = focused, tip = tip, label = label, pinned = pinned, still = still, unpinned = unpinned, xlabel = xlabel, left = F.LeftOut(), owner = owner })
"#,
		vec!["stub_world.lua", "stub_gamepad.lua"],
	);
	let o = &out[0];
	let reach: Vec<String> = o["reach"].as_array().unwrap().iter().map(|v| v.to_string()).collect();
	assert_eq!(o["off"], json!(["start"]), "off: Activate is in the gamepad's reach on the Main page");
	let off_quests: Vec<String> = o["offQuests"].as_array().unwrap().iter().map(|v| v.to_string()).collect();
	for want in ["\"activate\"", "\"near\"", "7001", "7002", "7003"] {
		assert!(off_quests.contains(&want.to_string()), "off, Your quests is in the gamepad's reach, {want} too: {o}");
	}
	for want in ["\"near\"", "7001", "7002", "7003"] {
		assert!(reach.contains(&want.to_string()), "the page is in the gamepad's reach, {want} too: {o}");
	}
	assert_eq!(text(&o["owner"]), "PolestarPicker");
	assert_eq!(o["focused"], true);
	assert_eq!(o["tip"], true, "the focus shows the quest's tooltip");
	assert_eq!(text(&o["label"]), "Pin to the top");
	assert_eq!(o["pinned"], 7002, "A pins it");
	assert_eq!(o["still"], true, "the focus stays on its quest as the route reorders");
	assert_eq!(o["unpinned"], false, "A again unpins it");
	assert_eq!(text(&o["xlabel"]), "Leave out", "the hint says what X does");
	assert_eq!(nums(&o["left"]), vec![7002], "X leaves it out");
}

#[test]
fn the_free_mode_tab_and_header_wear_the_running_figure_the_hand_in_tab_its_question_mark_a_leveling_tab_its_chevrons() {
	let out = run(r#"
route()
take(7001)
finish(7001, 5)
assert(Polestar.Handins.Start())
stub.advance(1)
assert(F.Start())
stub.advance(1)
local GF = UI.GuideFrame
GF.Layout()
local icons = {}
for i, t in ipairs(E.GetTabs()) do
	local b = GF.tabs[i]
	icons[#icons + 1] = { t.guideId, b and b.psIcon or false }
end
emit({ icons = icons, header = UI.GuideGlyph() or false, leveling = UI.GuideGlyph("test/route") or false })
"#);
	let o = &out[0];
	assert_eq!(o["icons"], json!([["test/route", "icon-level"], ["lookup/carried/log", "icon-turnin"], ["lookup/free/log", "icon-freemode"]]));
	assert_eq!(text(&o["header"]), "icon-freemode", "the window's header glyph while Free mode is in front (Atlas's emblem spot)");
	assert_eq!(o["leveling"], false, "a leveling guide keeps the emblem");
}

#[test]
fn the_running_figure_is_one_32_px_glyph_wherever_free_mode_shows() {
	// The texture: drawn in tools/media/ui.js, 32×32 (a power of two), 32-bit, white and tinted at runtime; the dotted
	// route it replaces is gone.
	let media = forge_addontest::run::root().join("addon/Polestar/Media/UI");
	let tga = std::fs::read(media.join("icon-freemode.tga")).expect("icon-freemode.tga");
	let (w, h, bpp) = (u16::from_le_bytes([tga[12], tga[13]]), u16::from_le_bytes([tga[14], tga[15]]), tga[16]);
	assert_eq!((w, h, bpp), (32, 32, 32));
	assert!(!media.join("icon-ownpath.tga").exists(), "the old glyph is gone");
	let out = run(r#"
route()
take(7001)
local menuOff = F.MenuItems()[1].icon
assert(F.Start())
stub.advance(1)
local GF = UI.GuideFrame
GF.Refill()
local banner = tostring(GF.parts.banner.Icon:GetTexture())
local menuOn = F.MenuItems()[1].icon
local section
for _, s in ipairs(UI.Picker.Sections()) do if s.key == "FreeMode" then section = s.icon end end
Polestar.Fire("SHOW_OPTIONS")
stub.advance(0.3)
local settings
for _, x in ipairs(Polestar.UI.Options.AllControls()) do if x.kind == "button" and x.label == "Free mode" then settings = x.icon end end
local P = page()
emit({ menuOff = menuOff, menuOn = menuOn, banner = banner, section = section, settings = settings, start = tostring(P.parts.Start.Icon:GetTexture()) })
"#);
	let o = &out[0];
	for k in ["menuOff", "menuOn", "section", "settings"] {
		assert_eq!(text(&o[k]), "icon-freemode", "{k}");
	}
	for k in ["banner", "start"] {
		assert!(text(&o[k]).ends_with("icon-freemode"), "{k}: {}", o[k]);
	}
}

// While Free mode is on, a click on a held quest's pin on the world map pins it first; off, the pins carry no line for
// it and a click does nothing of Free mode's (free when unused).
#[test]
fn a_click_on_a_held_quest_s_pin_on_the_world_map_makes_it_free_mode_s_first_quest_and_again_unpins_it() {
	let db = build_db(&fixture_dir());
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua"],
		before: format!(
			"stub.quests.dbFiles = {}\nlocal w = stub.world\nw.addMap(1429, {{ name = \"Elwynn Forest\", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }})\nw.moveTo(1429, 48, 40)\nfor q, t in pairs({{ [7] = \"Kobold Camp Cleanup\", [18] = \"Gathering Wood\" }}) do w.titles[q] = t end",
			db.lua_files()
		),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), "PolestarDB = { schema = 1, settings = { qol = { mapObjectives = true, turnInMarkers = true } } }".into())],
		script: r#"
local w, sq, F = stub.world, stub.quests, Polestar.Free
sq.installPins()
stub.login()
stub.advance(0.3)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(18, { { text = "Wood: 0/4", type = "item", required = 4 } })
stub.advance(1)
local pins = sq.pins.layers["quests.objectives"].pins
local function pinOf(q)
	for _, p in ipairs(pins) do
		for _, r in ipairs(p.refs) do if r.q == q then return p end end
	end
end
local p7, p18 = pinOf(7), pinOf(18)
local function lines(p)
	local out = {}
	local tt = { AddLine = function(_, text) out[#out + 1] = text end }
	p.tooltip(tt)
	return out[#out]
end
-- Off: no line, and a click pins nothing.
local hintOff = lines(p7)
p7.onClick("LeftButton")
local off = F.Pinned() or false
-- On (the folder loaded, its tab stood in for).
F.Load()
F.IsOn = function() return true end
local hint = lines(p7)
p7.onClick("LeftButton")
local first = F.Pinned()
local hintPinned = lines(p7)
p18.onClick("LeftButton")
local second = F.Pinned()
p18.onClick("LeftButton")
local third = F.Pinned() or false
p7.onClick("RightButton")
local right = F.Pinned() or false
IsShiftKeyDown = function() return true end
p7.onClick("LeftButton")
local shifted = F.Pinned() or false
IsShiftKeyDown = function() return false end
p7.onClick("LeftButton", {})
emit({ hintOff = hintOff, off = off, hint = hint, hintPinned = hintPinned, first = first, second = second, third = third, right = right, shifted = shifted, minimap = F.Pinned() or false })
"#
		.into(),
		..Default::default()
	});
	let o = &out[0];
	assert_eq!(text(&o["hintOff"]), "  Kobold Vermin: 0/10", "off: the pin's tooltip ends at its progress");
	assert_eq!(o["off"], false, "off: a click pins nothing");
	assert_eq!(text(&o["hint"]), "Click to make it Free mode's first quest");
	assert_eq!(o["first"], 7, "a click pins the quest");
	assert_eq!(text(&o["hintPinned"]), "Click to unpin it from Free mode");
	assert_eq!(o["second"], 18, "another quest's pin takes the first place");
	assert_eq!(o["third"], false, "clicked again, unpinned");
	assert_eq!(o["right"], false, "the right button is the map's");
	assert_eq!(o["shifted"], false, "Shift-click is Journey's");
	assert_eq!(o["minimap"], false, "mouse on the world map only");
}
