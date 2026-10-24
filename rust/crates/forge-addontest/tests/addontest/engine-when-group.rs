//! `when group <quest>` during play (addon/Polestar/Core/Engine.lua): the player answers "do this group quest?"
//! once per quest, per character (CharState().groupQuests, Engine.AnswerGroup). Unanswered, the step applies but
//! is not done, so the route waits there and automation leaves the quest alone; "skip" makes `when group` fail
//! (its turn-in goes with it, orphaned) and `when !group` hold, "do" the other way round. The answer is never
//! guessed from the quest log. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest, A Threat
//! Within 783 in the log), as tests/engine-when-dungeon.rs.

use forge_addontest::{emitted, is_match, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.titles[7] = "Kobold Camp Cleanup"
w.onQuest(783, {})
"#;

// Step 1 offers group quest 7 (Kobold Camp Cleanup, standing in for a group quest), step 2 hands it in, step 3
// hands in A Threat Within.
const GROUP_GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/group", pack = "test", title = "Group", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Group quest", when = { { k = "group", q = 7 } }, goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Hand it in", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

// A solo and a group way to the same objective of A Threat Within, already in the log: step 1 for those who
// skip, step 2 for those who group.
const PAIR_GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/group", pack = "test", title = "Group", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "The solo way", when = { { k = "group", q = 783, neg = true } }, goals = { { t = "task", text = "Pull one at a time" } } },
		{ title = "With a group", when = { { k = "group", q = 783 } }, goals = { { t = "task", text = "Clear the camp" } } },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function at() return E.GetLiveStep() end
"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

struct Opts<'a> {
	guide: &'a str,
	saved: Value,
	before: &'a str,
	db: &'a str,
	script: &'a str,
}

fn opts(script: &str) -> Opts<'_> {
	Opts { guide: GROUP_GUIDE, saved: json!({ "schema": 1, "guide": "test/group" }), before: "", db: "", script }
}

fn run(o: Opts) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{}", o.before),
		addons: vec![core()],
		saved: vec![("Polestar".into(), format!("{}PolestarCharDB = {}", o.db, lua_value(&o.saved)))],
		script: [TEST_PACK, TEST_SOURCE, o.guide, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, o.script].join("\n"),
		..Default::default()
	})
}

#[test]
fn unanswered_the_route_waits_at_the_group_step_and_asks_about_its_quest() {
	let out = run(opts("local q, title = E.GroupQuestion(); emit({ at = at(), q = q, title = title, answer = E.GroupAnswer(7) or false })"));
	assert_eq!(out[0], json!({ "at": 1, "q": 7, "title": "Kobold Camp Cleanup", "answer": false }));
}

#[test]
fn a_step_whose_goals_are_done_still_waits_for_the_answer() {
	// Step 1 asks about A Threat Within, already in the log: its accept is done.
	let guide = GROUP_GUIDE.replacen(r#"{ k = "group", q = 7 }"#, r#"{ k = "group", q = 783 }"#, 1).replacen(
		r#"{ t = "accept", quest = 7, title = "Kobold Camp Cleanup""#,
		r#"{ t = "accept", quest = 783, title = "A Threat Within""#,
		1,
	);
	let out = run(Opts { guide: &guide, ..opts(r#"emit(at()); E.AnswerGroup(783, "do"); flush(); emit(at())"#) });
	assert_eq!(out[0], 1);
	assert_eq!(out[1], 3);
}

#[test]
fn skip_passes_the_step_and_its_turn_in_goes_with_it_do_keeps_the_quest_on_the_route() {
	let out = run(opts(
		r#"E.AnswerGroup(7, "skip"); flush(); emit({ at = at(), s1 = E.GetStepView(1).status, q = E.GroupQuestion() or false }); stub.fire("PLAYER_LOGOUT"); emit(PolestarCharDB.groupQuests)"#,
	));
	assert_eq!(out[0], json!({ "at": 3, "s1": "skipped", "q": false }));
	assert_eq!(out[1], json!({ "7": "skip" }));
	let done = run(opts(r#"E.AnswerGroup(7, "do"); flush(); emit({ at = at(), s1 = E.GetStepView(1).status, q = E.GroupQuestion() or false })"#));
	assert_eq!(done[0], json!({ "at": 1, "s1": "current", "q": false }));
}

#[test]
fn the_answer_is_kept_per_character_and_asked_for_no_more() {
	let out = run(Opts { saved: json!({ "schema": 1, "guide": "test/group", "groupQuests": { "7": "skip" } }), ..opts("emit({ at = at(), q = E.GroupQuestion() or false })") });
	assert_eq!(out[0], json!({ "at": 3, "q": false }));
}

#[test]
fn a_solo_alternative_unanswered_waits_at_the_first_skip_takes_the_solo_way_do_the_group_way() {
	let waiting = run(Opts { guide: PAIR_GUIDE, ..opts("emit({ at = at(), q = E.GroupQuestion() or false })") });
	assert_eq!(waiting[0], json!({ "at": 1, "q": 783 }));
	let solo = run(Opts { guide: PAIR_GUIDE, ..opts(r#"E.AnswerGroup(783, "skip"); flush(); emit({ at = at(), s2 = E.GetStepView(2).status })"#) });
	assert_eq!(solo[0], json!({ "at": 1, "s2": "na" }));
	let group = run(Opts { guide: PAIR_GUIDE, ..opts(r#"E.AnswerGroup(783, "do"); flush(); emit({ at = at(), s1 = E.GetStepView(1).status })"#) });
	assert_eq!(group[0], json!({ "at": 2, "s1": "skipped" }));
}

#[test]
fn automation_takes_no_unanswered_group_quest_after_do_it_does() {
	let out = run(opts(r#"emit(E.WantsQuest("accept", 7)); E.AnswerGroup(7, "do"); flush(); emit(E.WantsQuest("accept", 7))"#));
	assert_eq!(out[0], false);
	assert_eq!(out[1], true);
}

#[test]
fn an_unknown_answer_is_ignored_once_the_route_has_passed_the_step_a_new_answer_leaves_its_stored_outcome() {
	let out = run(opts(
		r#"E.AnswerGroup(7, "skip"); flush(); E.AnswerGroup(7, "maybe"); local kept = E.GroupAnswer(7); E.AnswerGroup(7, "do"); flush(); emit({ kept = kept, at = at(), s1 = E.GetStepView(1).status })"#,
	));
	assert_eq!(out[0], json!({ "kept": "skip", "at": 3, "s1": "skipped" }));
}

#[test]
fn an_along_step_does_not_wait_for_an_answer() {
	let guide = GROUP_GUIDE.replacen(r#"{ title = "Group quest", when"#, r#"{ title = "Group quest", along = true, when"#, 1);
	let out = run(Opts { guide: &guide, ..opts("emit({ at = at(), q = E.GroupQuestion() or false })") });
	assert_eq!(out[0], json!({ "at": 2, "q": false }));
}

#[test]
fn a_group_quest_with_nothing_to_do_now_does_not_hold_the_route_one_not_open_yet_is_asked_about_once_it_opens() {
	let ask = "emit({ at = at(), q = E.GroupQuestion() or false })";
	// Handed in already.
	let done = run(Opts { before: "w.complete({ 7 })", ..opts(ask) });
	assert_eq!(done[0], json!({ "at": 3, "q": false }));
	// Skipped by the player (Skip quest).
	let skipped = run(Opts { saved: json!({ "schema": 1, "guide": "test/group", "skippedQuests": { "7": true } }), ..opts(ask) });
	assert_eq!(skipped[0], json!({ "at": 3, "q": false }));
	// Grey, left out by the catch-up ("Skip grey quests").
	let grey = GROUP_GUIDE.replacen(r#"{ t = "accept", quest = 7,"#, r#"{ t = "accept", quest = 7, qlvl = 2,"#, 1).replacen("maxLevel = 10", "maxLevel = 30", 1);
	let left = run(Opts { guide: &grey, before: "w.setLevel(20)", db: "PolestarDB = { schema = 1, settings = { behavior = { skipGrey = true } } }; ", ..opts(ask) });
	assert_eq!(left[0], json!({ "at": 3, "q": false }));
	// Above the character's level: passed for now, asked about at that level.
	let high = GROUP_GUIDE.replacen(r#"{ t = "accept", quest = 7,"#, r#"{ t = "accept", quest = 7, minLevel = 5,"#, 1);
	let script = format!(r#"{ask}; stub.world.setLevel(5); stub.fire("PLAYER_LEVEL_UP", 5); stub.advance(1.5); {ask}"#);
	let out = run(Opts { guide: &high, ..opts(&script) });
	assert_eq!(out[0], json!({ "at": 3, "q": false }));
	assert_eq!(out[1], json!({ "at": 1, "q": 7 }));
}

#[test]
fn guides_validate_takes_group_with_one_quest_id_on_a_step_and_refuses_it_on_a_next_option_or_a_skipto() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![core()],
		script: r#"
			local V = Polestar.Guides.Validate
			local function g(step, extra) local d = { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { step, { label = "end", goals = { { t = "note", text = "y" } } } } }; for k, v in pairs(extra or {}) do d[k] = v end; return d end
			local note = { { t = "note", text = "x" } }
			emit({
				ok = V(g({ when = { { k = "group", q = 7, neg = true } }, goals = note })) or "ok",
				noQuest = V(g({ when = { { k = "group" } }, goals = note })) or "ok",
				skipto = V(g({ skipto = { { to = "end", when = { k = "group", q = 7 } } }, goals = note })) or "ok",
				nextWhen = V(g({ goals = note }, { next = "t/w", nextChoices = { "t/w" }, nextWhen = { ["t/w"] = { { k = "group", q = 7 } } } })) or "ok",
			})
		"#
		.into(),
		..Default::default()
	});
	let rows = &out[0];
	assert_eq!(rows["ok"], "ok");
	assert!(is_match(rows["noQuest"].as_str().unwrap(), r"bad when"));
	assert!(is_match(rows["skipto"].as_str().unwrap(), r"bad skipto"));
	assert!(is_match(rows["nextWhen"].as_str().unwrap(), r"bad nextWhen"));
}

#[test]
fn groupquests_lists_the_group_quests_of_this_character_s_guides_once_each_the_options_tab_answers_them() {
	// An Alliance Warrior: the Horde guide's quest and the Mage-only step's are not listed.
	let guides = r#"
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", faction = "Alliance", minLevel = 1, maxLevel = 10, steps = {
	{ when = { { k = "group", q = 7 } }, goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
	{ when = { { k = "group", q = 7, neg = true } }, goals = { { t = "note", text = "Solo" } } },
	{ only = { classes = { "MAGE" } }, when = { { k = "group", q = 9 } }, goals = { { t = "note", text = "Mages" } } },
} })
Polestar.RegisterGuide({ id = "test/h", pack = "test", title = "H", faction = "Horde", minLevel = 1, maxLevel = 10, steps = {
	{ when = { { k = "group", q = 8 } }, goals = { { t = "note", text = "Horde" } } },
} })
"#;
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Dungeons/Dungeons.xml"])],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			guides,
			r#"stub.login()
			emit(Polestar.Engine.GroupQuests())
			local out = {}
			for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
				if spec.page == "Discovery" and spec.tab == "Group quests" then
					for _, c in ipairs(spec.controls) do
						local before = c.get()
						c.set(true)
						out[#out + 1] = { label = c.label(), before = before, after = Polestar.Engine.GroupAnswer(7) }
						c.set(false)
						out[#out].off = Polestar.Engine.GroupAnswer(7)
					end
				end
			end
			emit(out)
		"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0], json!([{ "quest": 7, "title": "Kobold Camp Cleanup" }]));
	assert_eq!(out[1], json!([{ "label": "Kobold Camp Cleanup", "before": false, "after": "do", "off": "skip" }]));
}
