//! Missable quests (addon/Polestar/Core/Closes.lua): what taking a quest closes for good, the chat line on the
//! quest window, and Automation leaving such an accept to the player (behavior.warnClosing).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

// 164 is a breadcrumb to 95; 97 also closes it. The Night Elf accept and the second "Sven's Revenge" are
// closed by 95 too, but a Human never loses them: one is not his, the other is the same quest.
const GUIDE_BODY: &str = r#"Polestar.RegisterGuide({
	id = "test/closes", pack = "test", title = "Closes", minLevel = 1, maxLevel = 30,
	steps = {
		{ goals = {
			{ t = "accept", quest = 164, title = "Deliveries to Sven", closedBy = { 95, 97 }, preTitles = { [95] = "Sven's Revenge", [97] = "Other Way" } },
			{ t = "accept", quest = 5673, title = "Elune's Grace", closedBy = { 95 }, preTitles = { [95] = "Sven's Revenge" }, only = { races = { "NightElf" } } },
			{ t = "accept", quest = 96, title = "Sven's Revenge", closedBy = { 95 }, preTitles = { [95] = "Sven's Revenge" } },
		} },
		{ goals = { { t = "accept", quest = 95, title = "Sven's Revenge" } } },
	},
})
"#;

fn guide() -> String {
	format!("\n{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE_BODY}")
}

const MAP: &str = r#"w = stub.world; w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); w.moveTo(1429, 48, 42)"#;

const TAIL: &str = r#"
local accepted = {}
for _, x in ipairs(w.calls) do if x[1] == "AcceptQuest" then accepted[#accepted + 1] = x[2] end end
local said = {}
for _, m in ipairs(stub.messages) do if m:find("for good", 1, true) then said[#said + 1] = m:gsub("^.-|r: ", "") end end
emit({ accepted = accepted, said = said })"#;

fn run(before: &str, addons: Vec<Addon>, script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: format!("{MAP}\n{before}"), addons, script: format!("{}\nstub.login()\n{script}{TAIL}", guide()), ..Default::default() }).remove(0)
}

const OFFER: &str = r#"w.questDetail(311, 95, { title = "Sven's Revenge" })"#;

const WARN: &str = r#"Polestar.Set("behavior.warnClosing", true)"#;

fn warn_offer() -> String {
	format!("{WARN}\n{OFFER}")
}

#[test]
fn off_by_default_the_guide_quest_is_accepted_and_nothing_is_said() {
	let out = run("", vec![core()], OFFER);
	assert_eq!(out, json!({ "accepted": [95], "said": {} }));
}

#[test]
fn on_offering_a_quest_that_closes_another_for_good_names_it_and_leaves_the_accept_to_the_player() {
	let out = run("", vec![core()], &warn_offer());
	assert_eq!(out, json!({ "accepted": {}, "said": ["Taking Sven's Revenge closes Deliveries to Sven for good."] }));
}

#[test]
fn nothing_to_lose_once_the_closed_quest_is_done_or_already_closed_by_another_quest() {
	let done = run("w.complete({ 164 })", vec![core()], &warn_offer());
	let closed = run("w.complete({ 97 })", vec![core()], &warn_offer());
	assert_eq!(json!([done, closed]), json!([{ "accepted": [95], "said": {} }, { "accepted": [95], "said": {} }]));
}

#[test]
fn the_warning_stands_without_quest_automation_and_a_quest_the_game_accepts_itself_gets_none() {
	let script = r#"
			Polestar.Set("behavior.warnClosing", true)
			Polestar.Set("behavior.autoAccept", false)
			OFFER
			w.close()
			w.questDetail(311, 95, { title = "Sven's Revenge", auto = true })"#
		.replace("OFFER", OFFER);
	let out = run("", vec![core()], &script);
	assert_eq!(out, json!({ "accepted": {}, "said": ["Taking Sven's Revenge closes Deliveries to Sven for good."] }));
}

#[test]
fn a_night_elf_loses_the_night_elf_quest_too() {
	let out = run(r#"w.race, w.raceName = "NightElf", "Night Elf""#, vec![core()], &warn_offer());
	assert_eq!(out["said"], json!(["Taking Sven's Revenge closes Deliveries to Sven, Elune's Grace for good."]));
}

const SILITHUS: &str = r#"Polestar.RegisterGuide({
	id = "test/silithus-a", pack = "test", title = "Silithus (Alliance)", faction = "Alliance", minLevel = 55, maxLevel = 60,
	steps = { { goals = { { t = "accept", quest = 8275, title = "Taking Back Silithus", closedBy = { 8280 }, preTitles = { [8280] = "Securing the Supply Lines" } } } } },
})
Polestar.RegisterGuide({
	id = "test/silithus-h", pack = "test", title = "Silithus (Horde)", faction = "Horde", minLevel = 55, maxLevel = 60,
	steps = { { goals = { { t = "accept", quest = 8276, title = "Taking Back Silithus", closedBy = { 8280 }, preTitles = { [8280] = "Securing the Supply Lines" } } } } },
})
stub.login()
Polestar.Set("behavior.warnClosing", true)
w.questDetail(15270, 8280, { title = "Securing the Supply Lines" })
local said = {}
for _, m in ipairs(stub.messages) do if m:find("for good", 1, true) then said[#said + 1] = m:gsub("^.-|r: ", "") end end
local closes = {}
for _, e in ipairs(Polestar.Closes.For(8280) or {}) do closes[#closes + 1] = e.id end
emit({ said = said, closes = closes })"#;

// Securing the Supply Lines (8280) closes Taking Back Silithus for good: the Alliance's 8275 and the Horde's
// 8276, each taken in its own side's guide. A Horde character is told only of the Horde one.
#[test]
fn a_guide_for_the_other_faction_never_counts_a_horde_character_offered_8280_is_told_only_of_8276() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"w = stub.world; w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); w.moveTo(1429, 48, 42); w.faction, w.race, w.raceName = "Horde", "Orc", "Orc""#.into(),
		addons: vec![core()],
		script: format!("\n{TEST_PACK}\n{TEST_SOURCE}\n{SILITHUS}"),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(out["closes"], json!([8276]));
	assert_eq!(out["said"], json!(["Taking Securing the Supply Lines closes Taking Back Silithus for good."]));
}

#[test]
fn the_quest_database_adds_the_quests_no_guide_takes_read_the_way_its_links_point() {
	// 282 lists 287 in its excl and 287 lists nothing back (as in the shipped data); 283 is Horde only.
	// Layout: title, level, minLevel, races, classes, faction, start, finish, startItem, pre, excl.
	let script = r#"
			local Q = Polestar.QuestDB
			AddRecords("quests", {
				[282] = { "Senir's Observations", 5, 1, nil, nil, 1, nil, nil, nil, nil, { 287 } },
				[283] = { "Horde Errand", 5, 1, nil, nil, 2, nil, nil, nil, nil, { 287 } },
				[287] = { "Frostmane Hold", 8, 5, nil, nil, 1 },
			})
			Q.SetMeta({})
			Polestar.Set("behavior.warnClosing", true)
			w.questDetail(1965, 287, { title = "Frostmane Hold" })
			w.close()
			OFFER"#
		.replace("OFFER", OFFER);
	let script = format!("{}{script}", forge_addontest::questdb::ADD_RECORDS_LUA);
	let out = run("", vec![Addon::name("Polestar")], &script);
	assert_eq!(out["said"], json!(["Taking Frostmane Hold closes Senir's Observations for good.", "Taking Sven's Revenge closes Deliveries to Sven for good."]));
}

#[test]
fn a_quest_the_game_accepted_itself_is_still_acknowledged_by_automation() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: MAP.into(),
		addons: vec![core()],
		script: guide()
			+ "\nstub.login()"
			+ r#"
			Polestar.Set("behavior.warnClosing", true)
			w.questDetail(311, 95, { title = "Sven's Revenge", auto = true })
			local c = {}
			for _, x in ipairs(w.calls) do c[#c + 1] = x[1] end
			emit(c)"#,
		..Default::default()
	});
	assert_eq!(out[0], json!(["AcknowledgeAutoAcceptQuest"]));
}
