//! A hand-in straight from the bags gated on carrying what it asks for (#2561: An Apple Treat, 91738, handed to
//! Sergeant De Vries only with the Thunder Applejack in the bags; addon/Polestar/Core/Engine.lua, `when has`,
//! Own.hereDirect). The step holds the route only while the bags hold the item, so no path leaves the player on a
//! hand-in the giver never offers: the still skipped, the Applejack drunk on the way, the still without four
//! apples, An Apple Treat already done. A hand-in the route passed without the item comes back as a "While you're
//! here" line at its giver once the item is in the bags, and auto turn-in takes it there; without the item no line
//! ever offers it (#2312). Real Core manifest, stub world; the steps are Elwynn Forest's Stonefield-to-Westbrook
//! stretch as 0.4.0.1 writes it.
//!
//! Elwynn here is 3000 yd across (30 yd per map percent on x) and 2000 yd high (20 yd per percent on y).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "PALADIN", "Paladin"
w.level = 12
w.zone, w.subzone = "Elwynn Forest", "Westbrook Garrison"
w.moveTo(1429, 24.3, 72.5)
w.titles[91736] = "Applejack Still"; w.titles[91738] = "An Apple Treat"; w.titles[109] = "Report to Gryan Stoutmantle"
w.onQuest(11, { 1 }, "Riverpaw Gnoll Bounty")
"#;

// 1 Homer's apples · 2 the still: four apples and An Apple Treat still to do · 3 Deputy Rainer (an accept that
// holds the route for everyone) · 4 De Vries: only with the Applejack · 5 the gnolls south of the garrison.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/apple", pack = "test", title = "Apple", faction = "Alliance", minLevel = 1, maxLevel = 12,
	steps = {
		{ title = "The Stonefield Farm", goals = { { t = "buy", item = 4536, itemName = "Shiny Red Apple", count = 4, npc = 894, npcName = "Homer Stonefield", map = 1429, x = 33.69, y = 82.9 } } },
		{ title = "The Applejack Still", when = { { k = "has", item = 4536, n = 4 }, { k = "turnedin", q = 91738, neg = true } }, goals = {
			{ t = "turnin", quest = 91736, title = "Applejack Still", object = 562131, objName = "Applejack Still", map = 1429, x = 24.55, y = 58.04, optional = true, direct = true },
			{ t = "collect", item = 247824, itemName = "Thunder Applejack", count = 1, map = 1429, x = 24.6, y = 58.0 },
		} },
		{ title = "Westbrook Garrison", goals = { { t = "accept", quest = 109, title = "Report to Gryan Stoutmantle", npc = 963, npcName = "Deputy Rainer", map = 1429, x = 24.23, y = 74.45 } } },
		{ title = "Sergeant De Vries", when = { { k = "has", item = 247824, n = 1 } }, goals = {
			{ t = "turnin", quest = 91738, title = "An Apple Treat", npc = 955, npcName = "Sergeant De Vries", map = 1429, x = 24.08, y = 73.2, direct = true },
		} },
		{ title = "Forest's Edge", goals = { { t = "kill", target = "Riverpaw Runt", npc = 97, count = 1, quest = 11, oi = 1, map = 1429, x = 25, y = 85 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.6) end
function at(x, y) w.moveTo(1429, x, y); stub.advance(0.6) end
-- The live step, each step's status, whether the guide wants An Apple Treat handed in, and De Vries' While you're
-- here candidates (step 4) and the line about An Apple Treat (other lines, Rainer's pick-up or the gnolls, aside).
function state()
	local status = {}
	for i = 1, 5 do status[i] = E.GetStepView(i).status end
	local cands = {}
	for _, c in ipairs(E.GetWhileHereCandidates()) do
		if c.step == 4 then cands[#cands + 1] = c.step .. ":" .. c.index .. ":" .. c.kind end
	end
	local here = "none"
	for _, v in ipairs(E.GetWhileHereList()) do
		if v.hereText and v.hereText:find("An Apple Treat", 1, true) then here = v.hereText end
	end
	return { live = E.GetLiveStep(), status = status, wants = E.WantsQuest("direct", 91738), cands = table.concat(cands, " "), here = here }
end
"#;

fn run(before: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/apple" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

// #2561: the still skipped (or the guide placed past it), no Applejack in the bags. Rainer's accept holds the route;
// once it is in, the route goes on to the gnolls and De Vries' step is passed, never live.
#[test]
fn without_the_applejack_de_vries_never_holds_the_route_2561() {
	let out = run(
		"",
		r#"
		E.SkipUpTo(3); flush()
		emit(state())
		w.accept(109); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0]["live"], 3, "{out:?}");
	assert_eq!(out[0]["status"][3], "na", "De Vries' step does not apply without the Applejack: {out:?}");
	assert_eq!(out[1]["live"], 5, "{out:?}");
	assert_eq!(out[1]["status"][3], "skipped", "{out:?}");
	assert_eq!(out[1]["wants"], false, "{out:?}");
	assert_eq!(out[1]["cands"], "", "nothing offers An Apple Treat: {out:?}");
}

// The straight path: the Applejack from the still is in the bags, De Vries' step holds the route and his hand-in
// (the Applejack going with it) ends it, read as done.
#[test]
fn with_the_applejack_de_vries_holds_the_route_until_the_hand_in() {
	let out = run(
		"w.addItem(247824, 1)",
		r#"
		E.SkipUpTo(3); flush()
		w.accept(109); flush()
		at(24.08, 73.2)
		emit(state())
		w.removeItem(247824); w.turnIn(91738, 625); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0]["live"], 4, "{out:?}");
	assert_eq!(out[0]["status"][3], "current", "{out:?}");
	assert_eq!(out[0]["wants"], true, "auto turn-in takes it from De Vries' offers: {out:?}");
	assert_eq!(out[1]["live"], 5, "{out:?}");
	assert_eq!(out[1]["status"][3], "done", "{out:?}");
}

// The Applejack drunk on the way (two players in the recordings): De Vries' step lets go before the route gets there.
#[test]
fn the_applejack_drunk_on_the_way_lets_de_vries_go() {
	let out = run(
		"w.addItem(247824, 1)",
		r#"
		E.SkipUpTo(3); flush()
		emit(state())
		w.removeItem(247824); flush()
		w.accept(109); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0]["status"][3], "upcoming", "{out:?}");
	assert_eq!(out[1]["live"], 5, "{out:?}");
}

// The still holds the route only with four apples in the bags (an apple eaten on the way: three) and An Apple Treat
// still to do.
#[test]
fn the_still_holds_the_route_only_with_four_apples_and_the_treat_to_do() {
	let three = run("w.addItem(4536, 3)", "E.SkipUpTo(2); flush(); emit(state())");
	assert_eq!(three[0]["live"], 3, "three apples: on to Rainer: {three:?}");
	assert_eq!(three[0]["status"][1], "skipped", "{three:?}");
	let four = run("w.addItem(4536, 4)", "E.SkipUpTo(2); flush(); emit(state())");
	assert_eq!(four[0]["live"], 2, "{four:?}");
	let done = run("w.addItem(4536, 4); w.complete({ 91738 })", "E.SkipUpTo(2); flush(); emit(state())");
	assert_eq!(done[0]["live"], 3, "An Apple Treat done: no second Applejack: {done:?}");
}

// #2312: at the still (live) with the apples and no Applejack, standing by De Vries, nothing offers An Apple Treat.
#[test]
fn no_line_offers_an_apple_treat_without_the_applejack_2312() {
	let out = run(
		"w.addItem(4536, 4)",
		r#"
		E.SkipUpTo(2); flush()
		at(24.1, 73.3)
		emit(state())
	"#,
	);
	assert_eq!(out[0]["live"], 2, "{out:?}");
	assert_eq!(out[0]["cands"], "", "{out:?}");
	assert_eq!(out[0]["here"], "none", "{out:?}");
	assert_eq!(out[0]["wants"], false, "{out:?}");
}

// The hand-in the route passed without the Applejack comes back once it is in the bags: a While you're here line at
// De Vries (the step itself stays passed), which auto turn-in takes; it goes again when the Applejack does.
#[test]
fn a_passed_hand_in_is_offered_again_once_the_applejack_is_in_the_bags() {
	let out = run(
		"",
		r#"
		E.SkipUpTo(3); flush()
		w.accept(109); flush()
		at(24.1, 73.3)
		emit(state())
		w.addItem(247824, 1); flush(); flush()
		emit(state())
		w.removeItem(247824); flush(); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0]["live"], 5, "{out:?}");
	assert_eq!(out[0]["cands"], "", "{out:?}");
	assert_eq!(out[1]["live"], 5, "the route does not go back: {out:?}");
	assert_eq!(out[1]["cands"], "4:1:turnin", "{out:?}");
	assert_eq!(out[1]["here"], "Hand in “An Apple Treat” to Sergeant De Vries", "{out:?}");
	assert_eq!(out[1]["wants"], true, "auto turn-in takes it: {out:?}");
	assert_eq!(out[2]["cands"], "", "{out:?}");
	assert_eq!(out[2]["wants"], false, "{out:?}");
}

// A hand-in ahead whose item is in the bags is a line like a later step's quest ready to hand in; the live step's own
// never is, and one handed in never comes back (a second Applejack in the bags: De Vries' line stays gone).
#[test]
fn an_applejack_carried_ahead_of_de_vries_step_is_a_hand_in_line_and_a_done_one_never() {
	let out = run(
		"w.addItem(247824, 1)",
		r#"
		E.SkipUpTo(3); flush()
		at(24.1, 73.3)
		emit(state())
		w.turnIn(91738, 625); flush(); flush()
		emit(state())
	"#,
	);
	assert_eq!(out[0]["live"], 3, "{out:?}");
	assert_eq!(out[0]["cands"], "4:1:turnin", "{out:?}");
	assert_eq!(out[1]["cands"], "", "{out:?}");
}

// ---------------------------------------------------------------------------------------------------------------
// The shipped Elwynn Forest guide (guides/forever/alliance/human/01-elwynn-forest.guide compiled with data/forever;
// skipped with a note without it), in #2561's state: a Human Paladin at 14 in the Westbrook Garrison, Westbrook
// Needs Help! handed in, Report to Gryan Stoutmantle and Riverpaw Gnoll Bounty in the log. `apple`: Lua run before
// login (the bags). `upgrade`: the save is 0.4.0's, where De Vries' hand-in shared Rainer's step and the player was
// there (Own.remap with Core/LegacySteps.lua carries it to 0.4.0.1's steps); else the guide is opened fresh.

const ELWYNN: &str = "forever/alliance/human/01-elwynn-forest";

// Own.stepParts' text of a compiled step: each goal's verb and its first id.
fn part(step: &Value) -> String {
	let id = |g: &Value| -> String {
		for k in ["quest", "npc", "item", "spell", "object", "faction", "achievement", "level", "location", "map"] {
			match &g[k] {
				Value::Number(n) => return n.as_i64().map_or_else(|| n.to_string(), |i| i.to_string()),
				Value::String(s) => return s.clone(),
				_ => {}
			}
		}
		String::new()
	};
	step["goals"].as_array().unwrap().iter().map(|g| format!("{}:{}", g["t"].as_str().unwrap(), id(g))).collect::<Vec<_>>().join(",")
}

// Own.hash: djb2 over the bytes, mod 2^32.
fn djb2(s: &str) -> u64 {
	s.bytes().fold(5381u64, |x, b| (x * 33 + b as u64) % 4294967296)
}

fn elwynn(apple: &str, upgrade: bool) -> Option<Value> {
	use forge_addontest::dsl::{compile_with, our_manifest, plain, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.exists() {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = format!("guides/{ELWYNN}.guide");
	let text = std::fs::read_to_string(root().join(&file)).unwrap();
	let compiled = compile_with(&[(file.as_str(), text.as_str())], &data, None);
	let guide = plain(&compiled.guides[0]);
	let steps = guide["steps"].as_array().unwrap();
	let rainer = steps.iter().position(|s| part(s).contains("turnin:239")).expect("Rainer's step");
	assert_eq!(steps[rainer + 1]["title"], "Sergeant De Vries", "De Vries' step follows Rainer's");
	// The quests behind Rainer's step: handed in there, or carried on.
	let mut done = std::collections::BTreeSet::new();
	let mut carried = std::collections::BTreeSet::new();
	for s in &steps[..rainer] {
		for g in s["goals"].as_array().unwrap() {
			let Some(q) = g["quest"].as_u64() else { continue };
			match g["t"].as_str() {
				Some("turnin") => {
					done.insert(q);
					carried.remove(&q);
				}
				Some("accept") if !done.contains(&q) => {
					carried.insert(q);
				}
				_ => {}
			}
		}
	}
	done.insert(239);
	let saved = if upgrade {
		// 0.4.0's steps: Rainer's and De Vries' as one.
		let mut old: Vec<String> = steps.iter().map(part).collect();
		let merged = format!("{},{}", old[rainer], old[rainer + 1]);
		old.splice(rainer..rainer + 2, [merged]);
		let shape = format!("{}-{}", old.len(), djb2(&old.join("|")));
		let keys: Vec<String> = old.iter().map(|p| djb2(p).to_string()).collect();
		// Every goal behind Rainer's step checked off, as the route latched them; the view on Rainer's step.
		let mut manual = Vec::new();
		for (i, s) in steps[..rainer].iter().enumerate() {
			for g in 1..=s["goals"].as_array().unwrap().len() {
				manual.push(format!("[\"{}:{g}\"] = true", i + 1));
			}
		}
		format!(
			r#"PolestarCharDB = {{ schema = 1, tabs = {{ "{ELWYNN}" }}, activeTab = 1, shapes = {{ ["{ELWYNN}"] = "{shape}" }},
	stepKeys = {{ ["{ELWYNN}"] = {{ {} }} }}, manual = {{ ["{ELWYNN}"] = {{ {} }} }}, pins = {{ ["{ELWYNN}"] = {{ step = {} }} }} }}"#,
			keys.join(", "),
			manual.join(", "),
			rainer + 1
		)
	} else {
		"PolestarCharDB = { schema = 1 }".to_string()
	};
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let mut maps = String::new();
	for (id, f) in data.map_frames.get("forever").as_obj().map(|o| o.entries()).unwrap_or_default() {
		maps.push_str(&format!(
			"w.addMap({id}, {{ name = \"\", c = {}, left = {}, right = {}, top = {}, bottom = {} }})\n",
			f.get("c").to_js_string(),
			f.get("left").to_js_string(),
			f.get("right").to_js_string(),
			f.get("top").to_js_string(),
			f.get("bottom").to_js_string()
		));
	}
	let done: Vec<String> = done.iter().map(u64::to_string).collect();
	let carried: String = carried.iter().map(|q| format!("w.onQuest({q}, {{}})\n")).collect();
	let before = format!(
		"local w = stub.world\n{maps}w.race, w.raceName, w.faction = \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"PALADIN\", \"Paladin\"\nw.level = 14\n\
		 w.zone, w.subzone = \"Elwynn Forest\", \"Westbrook Garrison\"\nw.moveTo(1429, 24.12, 73.13)\nw.complete({{ {} }})\n{carried}w.onQuest(109, {{}})\nw.onQuest(11, {{ {{ required = 8, fulfilled = 0 }} }})\n{apple}\n",
		done.join(", ")
	);
	let open = if upgrade { String::new() } else { format!("E.SetGuide(\"{ELWYNN}\"); stub.advance(0.25)\nE.SkipUpTo({})", rainer + 1) };
	let script = format!(
		r#"do local ns = {{}}
{}
end
E = Polestar.Engine
stub.login(); stub.advance(0.25)
{open}
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
local function titleOf(i) return g.steps[i] and g.steps[i].title or false end
local still
for i, st in ipairs(g.steps) do if st.title == "The Applejack Still" then still = i end end
emit({{ guide = g.id, live = titleOf(E.GetLiveStep()), liveStep = E.GetLiveStep(), rainer = {}, still = E.GetStepView(still).status,
	devries = E.GetStepView({}).status, wants = E.WantsQuest("direct", 91738) }})"#,
		loads.join("\n"),
		rainer + 1,
		rainer + 2
	);
	Some(emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], saved: vec![("Polestar".into(), saved)], script, ..Default::default() }).remove(0))
}

// #2561 as reported: at De Vries without the Applejack, the guide is on the gnolls, not on a hand-in he never offers.
#[test]
fn elwynn_at_westbrook_without_the_applejack_goes_on_to_the_gnolls_2561() {
	let Some(out) = elwynn("", false) else { return };
	assert_eq!(out["live"], "Forest's Edge", "{out}");
	assert_eq!(out["wants"], false, "{out}");
}

#[test]
fn elwynn_at_westbrook_with_the_applejack_hands_it_to_de_vries() {
	let Some(out) = elwynn("w.addItem(247824, 1)", false) else { return };
	assert_eq!(out["live"], "Sergeant De Vries", "{out}");
	assert_eq!(out["wants"], true, "{out}");
}

// Updated mid-guide: a 0.4.0 save on the Westbrook step (De Vries' hand-in then shared it) keeps the player there,
// never back at the apples or the still, and De Vries holds the route only with the Applejack.
#[test]
fn elwynn_a_0_4_0_save_at_westbrook_stays_there_and_de_vries_needs_the_applejack() {
	let Some(out) = elwynn("", true) else { return };
	assert_eq!(out["guide"], ELWYNN, "{out}");
	assert!(out["liveStep"].as_u64().unwrap() >= out["rainer"].as_u64().unwrap(), "not sent back: {out}");
	assert_eq!(out["live"], "Forest's Edge", "{out}");
	let Some(out) = elwynn("w.addItem(247824, 1)", true) else { return };
	assert_eq!(out["live"], "Sergeant De Vries", "{out}");
}
