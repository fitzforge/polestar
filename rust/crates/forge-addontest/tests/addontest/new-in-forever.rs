//! The "New in Forever" mark (addon/Polestar/Quests/NewQuests.lua, ids from NewQuestIds.lua, `forge data
//! newquests`): a small ∞ in the accent colour after the name of a quest Forever added, on the guide window's goal
//! rows and their tooltip, the "While you're here" rows and toast, the Codex's quest page and result rows, and the
//! quest lines of tooltips (quests.rs); ui.newInForever (Options > Guide > Window, "What it shows") turns it off.
//! The ids' resident cost stays within its budget.

use forge_addontest::{emitted, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const GLYPH: &str = "icon-forever";

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.level = 20
w.moveTo(1429, 48, 42)
"#;

// One step: take Crimson Crate Delivery (98240, Forever's) and A Threat Within (783, Classic's).
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/new", pack = "test", title = "New", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "Two quests", goals = {
			{ t = "accept", quest = 98240, title = "Crimson Crate Delivery", npc = 2094, npcName = "James Halloran", map = 1429, x = 48.2, y = 42.0 },
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.3, y = 42.0 },
		} },
		{ title = "End", goals = { { t = "level", level = 30 } } },
	},
})
"#;

const HELPERS: &str = r#"
local GF, UI = Polestar.UI.GuideFrame, Polestar.UI
local function rows()
	local out = {}
	for _, r in ipairs(GF.rows) do
		if r:IsShown() then out[#out + 1] = r.Text:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
	end
	return out
end
local function tipLines(f)
	local out = {}
	local show = Polestar.Widgets.Tooltip
	Polestar.Widgets.Tooltip = function(_, _, title, lines)
		out[#out + 1] = title
		for _, l in ipairs(lines or {}) do out[#out + 1] = type(l) == "table" and (l[1] or ((l.left or "") .. " | " .. (l.right or ""))) or l end
	end
	f:GetScript("OnEnter")(f)
	Polestar.Widgets.Tooltip = show
	return out
end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![(
			"Polestar".into(),
			r#"PolestarCharDB = { schema = 1, guide = "test/new" }
PolestarDB = { schema = 1, settings = { ui = { wholeStep = true } } }"#
				.into(),
		)],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, HELPERS, script].join("\n"),
		..Default::default()
	})
}

fn strs(v: &Value) -> Vec<String> {
	v.as_array().unwrap_or_else(|| panic!("not a list: {v}")).iter().map(|s| text(s).to_string()).collect()
}

// The shipped ids: Forever's own quests (the Wetlands' Crimson Crate Delivery, Riverglades' and Shen'dralas' before
// the data build holds them) are marked; Classic's never are, nor the Classic Era's later ones pfQuest lacks (a
// Love is in the Air quest, a library book of the seasons) nor a Classic id Forever reused in a new zone.
#[test]
fn the_shipped_ids_hold_forever_quests_and_never_classic_ones() {
	let out = run(r#"
		local N = Polestar.NewQuests
		local ids = { 98240, 93786, 93787, 92841, 92846, 783, 7, 5722, 65593, 78124, 0, -1, 999999 }
		local got = {}
		for i, id in ipairs(ids) do got[i] = N.IsNew(id) end
		emit({ got = got, count = N.Count(), str = N.IsNew("98240") })"#);
	assert_eq!(out[0]["got"], json!([true, true, true, true, true, false, false, false, false, false, false, false, false]), "{}", out[0]);
	assert_eq!(out[0]["str"], true, "an id as text reads too");
	let n = out[0]["count"].as_i64().unwrap();
	assert!((1500..4000).contains(&n), "{n} ids");
}

#[test]
fn a_forever_quest_s_goal_row_and_its_tooltip_carry_the_mark_a_classic_one_does_not_and_the_option_takes_it_away() {
	let out = run(r#"
		emit(rows())
		local first
		for _, r in ipairs(GF.rows) do if r:IsShown() then first = first or r end end
		emit(tipLines(first))
		emit({ default = Polestar.Get("ui.newInForever"), glyph = Polestar.NewQuests.Glyph() })
		Polestar.Set("ui.newInForever", false)
		emit(rows())
		emit(tipLines(first))
		Polestar.Set("ui.newInForever", true)
		emit(rows())"#);
	let on = strs(&out[0]);
	assert!(on[0].starts_with("Accept \u{201c}Crimson Crate Delivery\u{201d} |T") && on[0].contains(GLYPH), "the mark after the closing quote mark: {on:?}");
	assert_eq!(on[1], "Accept \u{201c}A Threat Within\u{201d}", "a Classic quest: no mark");
	let tip = strs(&out[1]);
	assert!(tip.iter().any(|l| l.contains(GLYPH) && l.ends_with(" New in Forever")), "the goal's tooltip says so: {tip:?}");
	assert_eq!(out[2]["default"], true, "on by default");
	let glyph = text(&out[2]["glyph"]);
	assert_eq!(glyph, "|TInterface\\AddOns\\Polestar\\Media\\UI\\icon-forever:8:16:0:0|t", "16x8, in its own colours");
	assert_eq!(strs(&out[3])[0], "Accept \u{201c}Crimson Crate Delivery\u{201d}", "turned off: gone at once");
	assert!(!strs(&out[4]).iter().any(|l| l.contains("New in Forever")), "{}", out[4]);
	assert_eq!(strs(&out[5]), on, "back on");
}

// A hand-in "While you're here" line names its quest: the mark follows the quoted name on the window's row, its
// tooltip and the toast; a line of work (no quest name) has none.
#[test]
fn a_while_you_re_here_hand_in_of_a_forever_quest_carries_the_mark_on_its_row_tooltip_and_toast() {
	let out = run(r#"
		local function view(q, title)
			local quoted = Polestar.Quoted(title)
			return { here = "turnin", t = "turnin", quest = q, step = 2, index = 1, yards = 40,
				hereText = "Hand in " .. quoted .. " to Marshal Dughan", hereTitle = quoted }
		end
		local list = { view(98240, "Crimson Crate Delivery"), view(783, "A Threat Within") }
		GF.FillHere({ GetWhileHereList = function() return list end })
		local H = GF.parts.here
		emit({ H.Rows[1].Text:GetText(), H.Rows[2].Text:GetText() })
		emit(tipLines(H.Rows[1]))
		Polestar.UI.WhileHereToast.Show(list[1])
		-- The line as shown: the house look's band over the card.
		local toast = PolestarWhileHereToast
		emit(((toast.psHouse and toast.psHouse:IsShown()) and toast.psHouse or toast).Text:GetText())
		Polestar.Set("ui.newInForever", false)
		emit(UI.HereText(list[1]))"#);
	let rows = strs(&out[0]);
	assert!(rows[0].starts_with("Hand in \u{201c}Crimson Crate Delivery\u{201d} |T") && rows[0].ends_with("|t to Marshal Dughan"), "{rows:?}");
	assert_eq!(rows[1], "Hand in \u{201c}A Threat Within\u{201d} to Marshal Dughan");
	let tip = strs(&out[1]);
	assert!(tip[0].contains(GLYPH) && tip.iter().any(|l| l.ends_with(" New in Forever")), "{tip:?}");
	assert!(text(&out[2]).contains(GLYPH), "the toast: {}", out[2]);
	assert_eq!(text(&out[3]), "Hand in \u{201c}Crimson Crate Delivery\u{201d} to Marshal Dughan");
}

// Options > Guide > Window ("What it shows"): the toggle shows the setting (on by default), writes it and follows a
// change made elsewhere.
#[test]
fn the_option_sits_with_what_the_guide_window_shows_on_by_default() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Quests/NewQuests.lua", "UI/UI.xml"])],
		script: r#"uistub.install()
stub.login()
Polestar.UI.LoadOptions()
local UI, O = Polestar.UI, Polestar.UI.Options
UI.ShowOptions("guide")
local c = O.Controls("guide")["ui.newInForever"]
local on = c and c.checked
if c then c:Click() end
local after = Polestar.Get("ui.newInForever")
Polestar.Set("ui.newInForever", true)
emit({ found = c ~= nil, on = on, after = after, followed = c and c.checked })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "found": true, "on": true, "after": false, "followed": true }));
}

// The Codex: a quest's result row and its page carry the mark after the name, the page says "New in Forever"
// among its facts. The fake Codex of tests/lua/stub_lookup.lua, with its quest 4970 marked.
#[test]
fn a_forever_quest_s_codex_row_and_page_carry_the_mark_and_say_so() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_lookup.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Quests/NewQuests.lua", "UI/UI.xml"])],
		script: r#"uistub.install()
lookupstub.install()
stub.login()
Polestar.NewQuests.Register(6, "004970")
local LK = Polestar.UI.Lookup
Polestar.Lookup.Show("saber")
local rows = {}
for _, f in ipairs(stub.frames) do
	if rawget(f, "Sub") and rawget(f, "Title") and f:IsShown() and f:GetParent() == LK.results.Child then rows[#rows + 1] = f end
end
local row
for _, r in ipairs(rows) do if (r.Title:GetText() or ""):find("Frostsaber Provisions", 1, true) then row = r end end
local rowText = row and row.Title:GetText() or false
if row then row:Click() end
local facts = {}
for _, f in ipairs(LK.details.Facts or {}) do if f.Value:IsShown() then facts[#facts + 1] = f.Label:GetText() .. " | " .. f.Value:GetText() end end
emit({ row = rowText, title = LK.details.Title:GetText(), facts = facts })
Polestar.Set("ui.newInForever", false)
emit({ title = LK.details.Title:GetText() })"#
			.into(),
		..Default::default()
	});
	let row = text(&out[0]["row"]);
	assert!(row.starts_with("Frostsaber Provisions |T") && row.contains(GLYPH), "{row}");
	let title = text(&out[0]["title"]);
	assert!(title.starts_with("Frostsaber Provisions |T") && title.contains(GLYPH), "{title}");
	assert!(strs(&out[0]["facts"]).iter().any(|f| f.starts_with("Origin | |T") && f.ends_with(" New in Forever")), "{}", out[0]["facts"]);
	assert_eq!(text(&out[1]["title"]), "Frostsaber Provisions", "turned off, the open page drops it");
}

// The memory budget: the shipped ids resident once loaded, under Lua 5.1 as the client counts it.
const BUDGET_KB: f64 = 16.0;

#[test]
fn the_ids_stay_within_their_memory_budget() {
	let file = forge_addontest::run::root().join("addon/Polestar/Quests/NewQuestIds.lua");
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Quests/NewQuests.lua"])],
		script: format!(
			r#"
local N = Polestar.NewQuests
collectgarbage("collect"); collectgarbage("collect")
local before = collectgarbage("count")
assert(loadfile({file}))("Polestar", Polestar)
collectgarbage("collect"); collectgarbage("collect")
emit({{ kb = collectgarbage("count") - before, n = N.Count(), hit = N.IsNew(98240) }})"#,
			file = forge_addontest::run::lua_string(&file.to_string_lossy())
		),
		..Default::default()
	});
	let v = &out[0];
	assert_eq!(v["hit"], true, "{v}");
	let kb = v["kb"].as_f64().unwrap();
	eprintln!("NewQuestIds.lua: {} ids, {kb:.1} KB resident (budget {BUDGET_KB} KB)", v["n"]);
	assert!(kb <= BUDGET_KB, "{kb:.1} KB over the {BUDGET_KB} KB budget");
}
