//! Dungeons in the route held back (Core/Init.lua's `ns.dungeonRoute`, off as it ships), on the shipped guides:
//! guides/ compiled with the reference data (data/forever; skipped with a note without it), and compiled again
//! with every dungeon step taken out (a step with `when dungeon "<X>"` left out whole, `when !dungeon "<X>"`
//! dropped from the solo way's step: the solo route). A character of each faction who saved Run them for every
//! dungeon and Run it for each one opens every leveling guide that has dungeon steps; one who never chose opens
//! the same guide of the solo compile. Every step the first sees (numbered, not hidden), in order, with its number,
//! title, goals and status, the step total and the live step are the second's.

use forge_addontest::dsl::{compile_with, our_manifest, plain, write_test_pack, TestPack};
use forge_addontest::run::root;
use forge_addontest::{emitted, lua_value, Addon, RunAddon};
use forge_guide::project::find_guide_files;
use serde_json::{json, Value};
use std::collections::BTreeSet;

fn when_dungeon(line: &str, neg: bool) -> bool {
	line.starts_with(char::is_whitespace) && line.trim_start().starts_with(if neg { "when !dungeon " } else { "when dungeon " })
}

/// A guide's text without its dungeons: each step with a `when dungeon "<X>"` line left out whole, each
/// `when !dungeon "<X>"` line dropped from its step.
fn solo_text(text: &str) -> String {
	let lines: Vec<&str> = text.split('\n').collect();
	let mut out: Vec<&str> = Vec::with_capacity(lines.len());
	let mut i = 0;
	while i < lines.len() {
		let l = lines[i];
		let is_step = l == "step" || (l.starts_with("step") && l[4..].starts_with(char::is_whitespace));
		if !is_step {
			out.push(l);
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && (lines[j].trim().is_empty() || lines[j].starts_with(char::is_whitespace)) {
			j += 1;
		}
		let block = &lines[i..j];
		if !block.iter().any(|b| when_dungeon(b, false)) {
			out.extend(block.iter().filter(|b| !when_dungeon(b, true)));
		}
		i = j;
	}
	out.join("\n")
}

/// Per guide id opened: { total, live, steps = { "<n>|<title>|<goals>|<status>", ... } } as the character sees it.
const READ: &str = r#"
local E, w = Polestar.Engine, stub.world
local out = {}
for _, id in ipairs(HELD_IDS) do
	local g = Polestar.Guides.Get(id)
	if g then
		w.setLevel(tonumber(g.minLevel) or 1)
		E.SetGuide(id)
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6)
		local steps = {}
		for i = 1, E.GetStepCount() do
			local n, hidden = E.StepNumber(i)
			if not hidden then
				local v = E.GetStepView(i)
				local goals = {}
				for _, gl in ipairs(E.GetGuide().steps[i].goals) do goals[#goals + 1] = tostring(gl.t) .. ":" .. tostring(gl.quest or "") end
				steps[#steps + 1] = n .. "|" .. tostring(v.title) .. "|" .. table.concat(goals, ",") .. "|" .. tostring(v.status)
			end
		end
		local live = E.GetLiveStep()
		out[id] = { total = E.StepTotal(), live = live and (E.StepNumber(live)) or false, steps = steps }
	end
end
emit(out)
"#;

fn loads(pack: &TestPack) -> String {
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	format!("do local ns = {{}}\n{}\nend", lines.join("\n"))
}

#[test]
fn held_back_every_leveling_guide_with_dungeon_steps_is_the_solo_route_whatever_is_saved() {
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let dir = root().join("guides");
	let files = find_guide_files(&dir, false);
	let texts: Vec<(String, String)> = files.iter().map(|f| (format!("guides/{f}"), std::fs::read_to_string(dir.join(f)).unwrap())).collect();
	let solo_texts: Vec<(String, String)> = texts.iter().map(|(f, t)| (f.clone(), solo_text(t))).collect();
	let sources: Vec<(&str, &str)> = texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let solo_sources: Vec<(&str, &str)> = solo_texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let real = compile_with(&sources, &data, None);
	let solo = compile_with(&solo_sources, &data, None);

	// The leveling guides with dungeon steps, and every dungeon they run.
	let mut ids: Vec<(String, String, Vec<String>)> = Vec::new();
	let mut maps: BTreeSet<i64> = BTreeSet::new();
	for g in real.guides.iter().map(plain) {
		let cat = g["category"].as_str().unwrap_or("Leveling");
		let mut has = false;
		for step in g["steps"].as_array().into_iter().flatten() {
			for p in step["when"].as_array().into_iter().flatten() {
				if p["k"] == "dungeon" {
					has = true;
					if let Some(m) = p["map"].as_i64() {
						maps.insert(m);
					}
				}
			}
		}
		if has && cat == "Leveling" {
			let races = g["races"].as_array().map(|r| r.iter().filter_map(|x| x.as_str().map(String::from)).collect()).unwrap_or_default();
			ids.push((g["id"].as_str().unwrap().to_string(), g["faction"].as_str().unwrap_or("").to_string(), races));
		}
	}
	assert!(ids.len() >= 10, "the shipped guides have dungeon steps in many leveling guides: {ids:?}");
	let real_pack = write_test_pack(&real.guides, &data, &our_manifest());
	let solo_pack = write_test_pack(&solo.guides, &data, &our_manifest());
	let answers: serde_json::Map<String, Value> = maps.iter().map(|m| (m.to_string(), Value::Bool(true))).collect();
	let saved_run = vec![(
		"Polestar".to_string(),
		format!(
			"PolestarCharDB = {}\nPolestarDB = {{ schema = 1, settings = {{ behavior = {{ dungeons = \"run\" }} }} }}",
			lua_value(&json!({ "schema": 1, "dungeons": answers }))
		),
	)];
	let (mut seen, mut diffs) = (0, Vec::new());
	for (race, class, faction) in [("Human", "WARRIOR", "Alliance"), ("Orc", "WARRIOR", "Horde")] {
		// This faction's guides (or both factions'), for this race when the guide names races.
		let mine: Vec<&String> = ids.iter().filter(|(_, f, r)| (f.is_empty() || f == faction) && (r.is_empty() || r.iter().any(|x| x == race))).map(|(id, _, _)| id).collect();
		let list = format!("HELD_IDS = {}", lua_value(&json!(mine)));
		let before = format!("local w = stub.world\nw.race, w.raceName = {race:?}, {race:?}\nw.class, w.className = {class:?}, {class:?}\nw.faction = {faction:?}\n");
		let play = |pack: &TestPack, saved: Vec<(String, String)>, switch: &str| -> Value {
			emitted(&RunAddon {
				stubs: vec!["stub_world.lua"],
				before: before.clone(),
				addons: vec![Addon::name("Polestar")],
				saved,
				script: [loads(pack), list.clone(), switch.into(), "stub.login()".into(), READ.into()].join("\n"),
				..Default::default()
			})
			.remove(0)
		};
		let held = play(&real_pack, saved_run.clone(), "");
		let skip = play(&real_pack, Vec::new(), "Polestar.dungeonRoute = true");
		let solo = play(&solo_pack, Vec::new(), "");
		assert_eq!(held, skip, "{faction}: held back with Run them saved, every guide is what Skip them gives with dungeons on");
		let (held, solo) = (held.as_object().cloned().unwrap_or_default(), solo.as_object().cloned().unwrap_or_default());
		assert_eq!(held.len(), mine.len(), "{faction}: every guide with dungeon steps opens: {:?}", held.keys().collect::<Vec<_>>());
		assert_eq!(held.keys().collect::<Vec<_>>(), solo.keys().collect::<Vec<_>>(), "{faction}: the same guides open");
		for (id, h) in &held {
			let s = &solo[id];
			if h["total"] != s["total"] {
				diffs.push(format!("{faction} {id}: {} steps, the solo route {}", h["total"], s["total"]));
			}
			if h["live"] != s["live"] {
				diffs.push(format!("{faction} {id}: opens at step {}, the solo route at {}", h["live"], s["live"]));
			}
			let (hs, ss) = (h["steps"].as_array().unwrap(), s["steps"].as_array().unwrap());
			for (a, b) in hs.iter().zip(ss.iter()) {
				if a != b {
					diffs.push(format!("{faction} {id}: {a} where the solo route has {b}"));
				}
			}
			seen += 1;
		}
	}
	assert!(seen >= 10, "the guides with dungeon steps were opened by a character of their faction ({seen})");
	assert!(diffs.is_empty(), "{} steps differ from the solo route:\n{}", diffs.len(), diffs.join("\n"));
}
