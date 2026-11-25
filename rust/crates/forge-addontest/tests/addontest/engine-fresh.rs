//! Fresh start (#1562): a leveling guide's compiled `fresh` header (forge_guide::fresh) as the Engine reads it
//! (Engine.FreshFor, Engine.FreshStart), "Suggested for you" (Guides.Suggestions) and the guide window's banner
//! (UI/GuideFrameBanner.lua). Stub world; the window on the full addon; the Wetlands case compiles the shipped
//! Alliance guides with data/forever (skipped with a note without it).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Human", "Human", "MAGE", "Mage", "Alliance", 6
"#;

// Elwynn Forest leads to Westfall, whose header says 60% of its quest XP (10,000) hinges on four of Elwynn's
// quests, and Redridge's 40% of 5,000 on one. Darkshore fits level 6 too, with no header. Loch Modan's header
// names Dun Morogh, a guide for Dwarves; Hillsbrad's a guide with a long title.
const GUIDES: &str = r#"
local function steps(n)
	local out = {}
	for i = 1, n do out[i] = { title = "Stop " .. i, goals = { { t = "goto", map = 1429, x = 30 + i, y = 50 } } } end
	return out
end
local function g(id, t) t.id = "test/" .. id; t.pack = "test"; t.faction = "Alliance"; t.steps = t.steps or steps(6); Polestar.RegisterGuide(t) end
g("elwynn", { title = "Elwynn Forest", minLevel = 1, maxLevel = 10, next = "test/westfall", steps = steps(3) })
g("westfall", { title = "Westfall", minLevel = 5, maxLevel = 8, fresh = { from = "test/elwynn", share = 60, xp = 10000, needs = { 1, 2, 3, 4 } } })
g("redridge", { title = "Redridge Mountains", minLevel = 5, maxLevel = 12, steps = steps(3),
	fresh = { from = "test/elwynn", share = 40, xp = 5000, needs = { 5 } } })
g("darkshore", { title = "Darkshore", minLevel = 5, maxLevel = 12 })
g("dunmorogh", { title = "Dun Morogh", races = { "Dwarf" }, minLevel = 1, maxLevel = 10 })
g("lochmodan", { title = "Loch Modan", minLevel = 5, maxLevel = 12, fresh = { from = "test/dunmorogh", share = 80, xp = 8000, needs = { 6 } } })
g("long", { title = "Loch Modan, Redridge Mountains & Westfall", minLevel = 1, maxLevel = 10 })
g("hillsbrad", { title = "Hillsbrad Foothills", minLevel = 5, maxLevel = 12, fresh = { from = "test/long", share = 50, xp = 5000, needs = { 7 } } })
"#;

const HELPERS: &str = r#"
E, G = Polestar.Engine, Polestar.Guides
function flush() stub.advance(0.25) end
function ids()
	local list, active = E.GetTabs()
	local out = {}
	for i, t in ipairs(list) do out[i] = t.guideId end
	return { tabs = out, active = active }
end
function at(id) for i, t in ipairs(E.GetTabs()) do if t.guideId == id then return i end end end
function fresh(id) return E.FreshFor(G.Get(id)) or false end
"#;

fn run(addons: Vec<Addon>, script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: WORLD.to_string(), addons, script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", script].join("\n"), ..Default::default() })
		.remove(0)
}

// A level 6 character with none of Westfall's four quests gets the whole 60%. One done and one in the log leave
// 30%, still a note; three, 15%: none.
// "Suggested for you" ranks Westfall and Redridge after the others for the level, though Westfall's range is the
// narrowest; Loch Modan's header names a guide no Human plays, so it gives neither a note nor a lower place. At
// Redridge's top level, no note.
#[test]
fn the_share_left_scales_by_the_quests_done_or_held_and_suggested_ranks_such_a_guide_after_the_others() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Core.xml"])],
		r#"
		local w = stub.world
		local r = {}
		r.first = { G.Suggestions(), fresh("test/westfall"), fresh("test/redridge"), fresh("test/lochmodan") }
		w.complete({ 1 }); w.onQuest(2, { 1 })
		r.two = fresh("test/westfall")
		w.complete({ 3 })
		r.three = { G.Suggestions(), fresh("test/westfall") }
		w.setLevel(12); flush()
		r.top = fresh("test/redridge")
		emit(r)
	"#,
	);
	assert_eq!(out["first"][0], json!(["test/darkshore", "test/lochmodan", "test/elwynn", "test/long", "test/westfall", "test/redridge", "test/hillsbrad"]), "{out}");
	assert_eq!(out["first"][1], json!({ "guideId": "test/westfall", "from": "test/elwynn", "fromTitle": "Elwynn Forest", "share": 60 }));
	assert_eq!(out["first"][2], json!({ "guideId": "test/redridge", "from": "test/elwynn", "fromTitle": "Elwynn Forest", "share": 40 }));
	assert_eq!(out["first"][3], false, "Dun Morogh is a Dwarf's guide");
	assert_eq!(out["two"], json!({ "guideId": "test/westfall", "from": "test/elwynn", "fromTitle": "Elwynn Forest", "share": 30 }));
	assert_eq!(out["three"], json!([["test/westfall", "test/darkshore", "test/lochmodan", "test/elwynn", "test/long", "test/redridge", "test/hillsbrad"], false]));
	assert_eq!(out["top"], false, "at the guide's top level");
}

// The full addon. Westfall opened fresh: the banner offers the guide its quests follow on from, with "Open Elwynn
// Forest" (no percent, no minutes: #3879). Dismissed, it is gone for Westfall, even back on its tab, while Redridge
// still has its own; Redridge's link opens Elwynn Forest in a new tab, and taken, Redridge's note is gone too. Past
// Westfall's first third (step 4 of 6) there is none. A guide's long title in the link is cut short to the text's
// column; the text names it whole.
#[test]
fn the_window_says_it_until_dismissed_for_that_guide_and_its_link_opens_the_earlier_guide_in_a_new_tab() {
	let out = run(
		vec![Addon::name("Polestar")],
		r#"
		local GF = Polestar.UI.GuideFrame
		local B = GF.parts.banner
		Polestar.Set("ui.shown", true)
		stub.fire("QUEST_LOG_UPDATE"); flush()
		local function banner()
			return B:IsShown() and B.psKind == "fresh" and { B.Text:GetText(), B.Jump:IsShown() and B.Jump.Label:GetText() or false } or false
		end
		local r = {}
		E.OpenTab("test/westfall"); flush()
		r.note = banner()
		B.Close:Click(); flush()
		r.dismissed = { banner(), E.FreshStart() ~= nil }
		E.OpenTab("test/redridge"); flush()
		r.other = banner()
		B.Jump:Click(); flush()
		r.opened = ids()
		E.SelectTab(at("test/redridge")); flush()
		r.taken = banner()
		E.SelectTab(at("test/westfall")); flush()
		r.still = banner()
		for s = 1, 3 do E.ToggleGoal(s, 1); flush() end
		r.later = { E.GetLiveStep(), E.FreshStart() or false }
		E.OpenTab("test/hillsbrad"); flush()
		r.long = { banner(), B.Jump.Label:IsTruncated(), B.Jump:GetWidth() <= B.Text:GetWidth() }
		emit(r)
	"#,
	);
	let offer = |from: &str| format!("Some of this guide's quests follow on from {from}. Start there for the full set, or carry on here; the guide fills in with nearby quests.");
	assert_eq!(out["note"], json!([offer("Elwynn Forest"), "Open Elwynn Forest"]));
	assert_eq!(out["dismissed"], json!([false, true]), "dismissed, not gone from the Engine");
	assert_eq!(out["other"], json!([offer("Elwynn Forest"), "Open Elwynn Forest"]));
	assert_eq!(out["opened"], json!({ "tabs": ["test/darkshore", "test/westfall", "test/redridge", "test/elwynn"], "active": 4 }), "after the login's tab");
	assert_eq!(out["taken"], false);
	assert_eq!(out["still"], false, "dismissed for Westfall for the session");
	assert_eq!(out["later"], json!([4, false]));
	assert_eq!(out["long"], json!([[offer("Loch Modan, Redridge Mountains & Westfall"), "Open Loch Modan, Redridge Mountains & Westfall"], true, true]));
}

const WETLANDS: &str = "forever/alliance/06-wetlands";
const ASHENVALE: &str = "forever/alliance/06-ashenvale";

// The Wetlands case (#1562). The Alliance guides as shipped up to Wetlands, Ashenvale, Ironforge & Stormwind City
// (29-31 since the 0.4.2 route round): the shared route and the races' starting zones, compiled with data/forever.
// Most of the quest XP its header says follows on from earlier guides hinges on quests Ashenvale, Wetlands &
// Stonetalon Mountains (22-25) takes, the Wetlands quests its Menethil visit starts. A Human Warrior at 22 who played
// none of the guides before it opens Wetlands: the window says so (the share scaled by the part of `needs` the
// guide's plan does not take on the way and that is not grey at 22: on the 0.4.2 route, Young Crocolisk Skins (484)
// at Menethil, one of the eight, leaves 29.75%, which counts as 30%), and the link opens Ashenvale, a guide for
// their level, in a new tab.
#[test]
fn wetlands_opened_fresh_at_22_points_to_ashenvale_wetlands_and_stonetalon() {
	use forge_addontest::dsl::{compile_with, our_manifest, plain, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let dir = root().join("guides");
	let later = ["/30-40/", "/40-50/", "/50-60/"];
	let texts: Vec<(String, String)> = forge_guide::project::find_guide_files(&dir, false)
		.into_iter()
		.filter(|f| f.starts_with("forever/alliance/") && !later.iter().any(|d| f.contains(d)))
		.map(|f| (format!("guides/{f}"), std::fs::read_to_string(dir.join(&f)).unwrap()))
		.collect();
	let sources: Vec<(&str, &str)> = texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let compiled = compile_with(&sources, &data, None);
	let wetlands = compiled.guides.iter().find(|g| g.get("id").as_str() == Some(WETLANDS)).expect("the Wetlands guide");
	let header = plain(&wetlands.get("fresh"));
	assert_eq!(header["from"], ASHENVALE, "{header}");
	let (share, xp) = (header["share"].as_f64().unwrap(), header["xp"].as_f64().unwrap());
	let needs: Vec<i64> = header["needs"].as_array().unwrap().iter().map(|q| q.as_i64().unwrap()).collect();
	assert!(share >= 30.0, "{header}");
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let script = format!(
		r#"do local ns = {{}}
{}
end
for id, b in pairs((Polestar.MapFrames or {{}}).era or {{}}) do stub.world.addMap(id, b) end
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
local B = GF.parts.banner
Polestar.Set("ui.shown", true)
E.SetGuide("{WETLANDS}"); stub.advance(0.25)
local onWay = {{}}
for _, step in ipairs(Polestar.Guides.Get("{WETLANDS}").steps) do
	if step.feeder then for _, goal in ipairs(step.goals) do if goal.t == "accept" then onWay[#onWay + 1] = goal.quest end end end
end
local r = {{ note = E.FreshStart() or false, live = E.GetLiveStep() or false, onWay = onWay }}
r.banner = B:IsShown() and B.psKind == "fresh" and {{ B.Text:GetText(), B.Jump.Label:GetText() }} or false
B.Jump:Click(); stub.advance(0.25)
local list, active = E.GetTabs()
r.opened = list[active] and list[active].guideId or false
emit(r)
"#,
		loads.join("\n")
	);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"local w = stub.world
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Human", "Human", "WARRIOR", "Warrior", "Alliance", 22"#
			.into(),
		addons: vec![Addon::name("Polestar")],
		script,
		..Default::default()
	})
	.remove(0);
	let title = "Ashenvale, Stonetalon Mountains & Wetlands";
	let taken = |q: i64| out["onWay"].as_array().is_some_and(|a| a.iter().any(|v| v.as_i64() == Some(q)));
	let on_way = needs.iter().filter(|q| taken(**q)).count();
	let left = share * (1.0 - on_way as f64 / needs.len() as f64);
	let shown = (left + 0.5).floor() as i64;
	assert!(shown >= 30, "the share left reads 30% or more: {left} ({on_way} of {needs:?} on the way): {out}");
	// Of what is left, the share counts only quests not grey at 22 (#3879): at most the share left.
	let note = &out["note"];
	assert_eq!((&note["guideId"], &note["from"], &note["fromTitle"]), (&json!(WETLANDS), &json!(ASHENVALE), &json!(title)), "{out}");
	let counted = note["share"].as_i64().unwrap_or(0);
	assert!((30..=shown).contains(&counted), "{counted} of {shown}: {out}");
	assert!(xp > 0.0);
	let text = format!("Some of this guide's quests follow on from {title}. Start there for the full set, or carry on here; the guide fills in with nearby quests.");
	assert_eq!(out["banner"], json!([text, format!("Open {title}")]));
	assert_eq!(out["opened"], ASHENVALE);
}

// #3879 (Fitz on preview5): a level 25 with no Barrens history opened The Barrens & Stonetalon Mountains (24-27)
// and was told 42% of its quest XP follows on from The Barrens, whose quests it counts are level 18-23. The share
// counts only the quests of `needs` not grey for the character, each by the XP it pays at their level (their level
// from The Barrens' own accepts): at 25, 959 and 1491 (18) are grey and 1062 (19) pays 80%, so 48% of the header
// reads 48 x 5.8 / 8 = 35%; at 19 all eight pay in full, 48%. The shipped Horde pack.
fn barrens_fresh(level: u32) -> Value {
	let dir = forge_addontest::run::addons_dir();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("local w = stub.world\nw.race, w.faction, w.class, w.className, w.level = \"Orc\", \"Horde\", \"WARRIOR\", \"WARRIOR\", {level}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde"))],
		script: r#"
local E, G = Polestar.Engine, Polestar.Guides
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
E.SetGuide("forever/horde/04-the-barrens"); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
local g = G.Get("forever/horde/04-the-barrens")
emit({ header = g.fresh.share, fresh = E.FreshFor(g) or false })"#
			.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_fresh_start_counts_only_follow_on_quests_not_grey_for_the_character_3879() {
	let at25 = barrens_fresh(25);
	assert_eq!(at25["header"], 48, "{at25}");
	assert_eq!(at25["fresh"]["share"], 35, "{at25}");
	let at19 = barrens_fresh(19);
	assert_eq!(at19["fresh"]["from"], "forever/horde/02-the-barrens", "{at19}");
	assert_eq!(at19["fresh"]["share"], 48, "{at19}");
}
