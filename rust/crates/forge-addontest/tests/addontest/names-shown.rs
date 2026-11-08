//! Names from the guide or the data shown in the client's language on a fake
//! Russian client (`forge i18n leaks`, "English name from the guide or data,
//! Polestar.Names not asked"): a `complete` goal's objectives read ahead of the
//! quest log (the guide window's rows, its folded lists' tooltips and its
//! "Then:" line all read them), the pace line's quest and the class-quest
//! card's giver. An English client keeps the data's English.

use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::names::{names_pack, NamesPack};
use forge_addontest::{emitted, lua_string, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// The sample Codex plus Elwynn's The Binding (kill 5676), Camping 101 (Tomas, 1430), The Great Outdoors
// (two events) and the Undead Warlock's Voidwalker start, 1478 from Ageron Kargal (5724) in Tirisfal.
fn codex() -> CodexPack {
	let mut c = sample_codex();
	let quest = |id: i64, title: &str, start: i64, objectives: Value| {
		let mut q = c["quests"]["33"].clone();
		q["id"] = json!(id);
		q["title"] = json!(title);
		q["level"] = json!(10);
		q["faction"] = Value::Null;
		q["pre"] = json!([]);
		q["start"] = json!({ "npc": [start], "object": [], "item": [] });
		q["objectives"] = objectives;
		q
	};
	let npc = |id: i64, name: &str, map: i64, x: f64, y: f64| {
		let mut n = c["npcs"]["196"].clone();
		n["id"] = json!(id);
		n["name"] = json!(name);
		n["spawns"] = json!([{ "map": map, "x": x, "y": y, "f": "e" }]);
		n
	};
	let add = [
		("1689", quest(1689, "The Binding", 6122, json!([{ "type": "kill", "id": 5676, "count": 1, "text": "Summoned Voidwalker" }]))),
		("96626", quest(96626, "Camping 101: Cooking", 1430, json!([{ "type": "kill", "id": 1430, "count": null, "text": "Tomas" }]))),
		(
			"95998",
			quest(
				95998,
				"The Great Outdoors",
				1430,
				json!([{ "type": "event", "id": null, "count": 1, "text": "Sit near the campfire (Optional)" }, { "type": "event", "id": null, "count": 1, "text": "Gain the Boosted Rest buff" }]),
			),
		),
		("1478", quest(1478, "Halgar's Summons", 5724, json!([]))),
	];
	let npcs =
		[npc(5676, "Summoned Voidwalker", 1453, 25.1, 77.4), npc(1430, "Tomas", 1429, 44.4, 66.0), npc(5724, "Ageron Kargal", 1420, 61.6, 52.7), npc(6122, "Gakin the Darkbinder", 1453, 25.4, 78.3)];
	for (id, q) in add {
		c["quests"][id] = q;
	}
	for n in npcs {
		let id = n["id"].to_string();
		c["npcs"][id] = n;
	}
	write_codex_pack(&c, &CodexOpts::default())
}

fn ru_pack() -> NamesPack {
	names_pack(
		"ruRU",
		&[
			("quest", &[(1689, "Узы"), (96626, "Походы 101: кулинария"), (95998, "На свежем воздухе"), (1478, "Призыв Халгара")]),
			("npc", &[(5676, "Призванный демон Бездны"), (1430, "Томас"), (5724, "Агерон Каргал"), (6122, "Гакин Темный Заклинатель")]),
		],
	)
}

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/shown", pack = "test", title = "Shown", minLevel = 1, maxLevel = 20,
	steps = {
		{ title = "Goldshire", goals = {
			{ t = "accept", quest = 1689, title = "The Binding", qlvl = 10, npc = 6122, npcName = "Gakin the Darkbinder" },
			{ t = "accept", quest = 96626, title = "Camping 101: Cooking", npc = 1430, npcName = "Tomas" },
			{ t = "accept", quest = 95998, title = "The Great Outdoors", npc = 1430, npcName = "Tomas" },
		} },
		{ title = "Out of town", goals = {
			{ t = "complete", quest = 1689, title = "The Binding", qlvl = 10, objs = { { text = "Summoned Voidwalker", count = 1 } } },
			{ t = "complete", quest = 96626, title = "Camping 101: Cooking", objs = { { text = "Tomas", count = 1 } } },
			{ t = "complete", quest = 95998, title = "The Great Outdoors",
				objs = { { text = "Sit near the campfire (Optional)", count = 1 }, { text = "Gain the Boosted Rest buff", count = 1 } } },
		} },
	},
})
"#;

fn run(locale: Option<&str>, script: &str) -> Vec<Value> {
	let pack = ru_pack();
	let codex = codex();
	let locale = locale.map(|l| format!("function GetLocale() return {} end", lua_string(l))).unwrap_or_default();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!(
			r#"{locale}
{}
{}
function C_QuestLog.RequestLoadQuestByID() end
local w = stub.world
w.addMap(1429, {{ name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }})
w.moveTo(1429, 48, 42)
"#,
			pack.stub_lua, codex.stub_lua
		),
		addons: vec![Addon::name("Polestar")],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\nstub.login()\nstub.advance(0.6)\n{script}"),
		..Default::default()
	})
}

// The step's goals as the window reads them (UI.GoalLine: its rows and the folded lists' tooltips;
// UI.GoalText: "Then:"), then every text the shown window holds.
const WINDOW: &str = r#"
local E, UI = Polestar.Engine, Polestar.UI
E.SetGuide("test/shown"); stub.advance(0.3)
local goals = {}
for i, g in ipairs(E.GetStepView(2).goals) do
	goals[i] = { line = UI.GoalLine(g):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), text = UI.GoalText(g):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") }
end
emit(goals)
E.Goto(2)
if PolestarGuideFrame then PolestarGuideFrame:Show() end
stub.advance(0.3)
local all = {}
for _, fs in ipairs(stub.strings) do
	if type(fs.text) == "string" and fs.text ~= "" then all[#all + 1] = fs.text end
end
emit(table.concat(all, "\n"))"#;

fn shown(v: &Value) -> &str {
	v.as_str().unwrap()
}

#[test]
fn a_russian_client_reads_a_complete_goal_s_objectives_ahead_of_the_log_by_the_names_they_count_and_one_with_no_name_as_complete_its_quest() {
	let out = run(Some("ruRU"), WINDOW);
	let goals = out[0].as_array().unwrap();
	assert!(shown(&goals[0]["line"]).starts_with("Призванный демон Бездны"), "{}", goals[0]);
	assert!(shown(&goals[0]["text"]).starts_with("Призванный демон Бездны"), "{}", goals[0]);
	assert!(shown(&goals[1]["line"]).starts_with("Томас"), "{}", goals[1]);
	// Events have no name to give: the quest, in the client's words.
	assert!(shown(&goals[2]["line"]).contains("На свежем воздухе"), "{}", goals[2]);
	assert!(!shown(&goals[2]["line"]).contains("campfire"), "{}", goals[2]);
	let window = shown(&out[1]);
	assert!(window.contains("Призванный демон Бездны") && window.contains("Томас"), "{window}");
	for english in ["Summoned Voidwalker", "Tomas", "campfire", "Boosted Rest"] {
		assert!(!window.contains(english), "the window shows {english}:\n{window}");
	}
}

#[test]
fn an_english_client_reads_the_data_s_objectives_as_before() {
	let out = run(None, WINDOW);
	let lines: Vec<String> = out[0].as_array().unwrap().iter().map(|g| shown(&g["line"]).to_string()).collect();
	assert!(lines[0].starts_with("Summoned Voidwalker"), "{lines:?}");
	assert!(lines[1].starts_with("Tomas"), "{lines:?}");
	assert!(lines[2].contains("Sit near the campfire (Optional)") && lines[2].contains("Gain the Boosted Rest buff"), "{lines:?}");
}

#[test]
fn the_pace_line_names_its_quest_in_the_client_s_words() {
	let script = r#"
local E = Polestar.Engine
E.SetGuide("test/shown"); stub.advance(0.3)
local h = Polestar.Levels.StepHint(1)
emit({ title = h and h.title or false, quest = h and h.quest or false })"#;
	assert_eq!(run(Some("ruRU"), script)[0], json!({ "title": "Узы", "quest": 1689 }));
	assert_eq!(run(None, script)[0], json!({ "title": "The Binding", "quest": 1689 }));
}

#[test]
fn the_class_quest_card_names_its_giver_in_the_client_s_words_and_points_the_arrow_at_that_name() {
	let script = r#"
local w = stub.world
w.class, w.className, w.race, w.raceName, w.faction = "WARLOCK", "Warlock", "Scourge", "Undead", "Horde"
w.level = 10
local m = Polestar.UI.ClassToast.Model(1478)
emit({ giver = m and m.giver or false, who = m and m.who or false })"#;
	let ru = run(Some("ruRU"), script).remove(0);
	assert!(shown(&ru["giver"]).contains("Агерон Каргал"), "{ru}");
	assert_eq!(ru["who"], "Агерон Каргал");
	let en = run(None, script).remove(0);
	assert!(shown(&en["giver"]).contains("Ageron Kargal"), "{en}");
	assert_eq!(en["who"], "Ageron Kargal");
}
