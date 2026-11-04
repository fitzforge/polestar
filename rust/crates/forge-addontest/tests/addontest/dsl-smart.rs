//! Smart targets: `train <Profession> [Rank]`, `train class`, `buy … nearest`, `vendor nearest`, `sethome nearest`
//! compile to candidate sets (docs/ARCHITECTURE.md "Smart logic"); `qlvl`/`pre` on accepts for the engine's
//! grey-quest skipping; a quest's profession on its goals for the engine's profession gate. What the compiler
//! writes is forge-guide's (rust/crates/forge-guide/tests/dsl_smart.rs); here: the engine reading it (`forge data
//! trainers`: rust/crates/forge-data/tests/data/trainers.rs).

use forge_addontest::tmp::TempDir;
use forge_addontest::{dsl, emitted, is_match, lua_string, Addon, RunAddon, TEST_PACK};
use forge_guide::data::Data;
use forge_guide::js::{parse_json, stringify, V};
use serde_json::{json, Value};
use std::fs;
use std::path::Path;

fn head(faction: Option<&str>, extra: &[&str]) -> Vec<String> {
	let mut v = vec!["guide t/s".to_string(), "title S".to_string()];
	if let Some(f) = faction {
		v.push(format!("faction {f}"));
	}
	v.push("levels 1-60".into());
	v.push("zone Elwynn Forest".into());
	v.extend(extra.iter().map(|s| s.to_string()));
	v.push(String::new());
	v
}

fn goals_of(lines: &[String], data: &Data) -> (dsl::Compiled, Vec<Value>) {
	let text = format!("{}\n", lines.join("\n"));
	let r = dsl::compile_with(&[("test.guide", &text)], data, None);
	let g = r.guides.first().map(|guide| guide.get("steps").items().iter().flat_map(|s| s.get("goals").items()).map(|x| dsl::plain(&x)).collect()).unwrap_or_default();
	(r, g)
}

fn only(list: &[String], re: &str) -> Vec<String> {
	list.iter().filter(|m| is_match(m, re)).cloned().collect()
}

fn jv(text: &str) -> V {
	parse_json(text).expect("JSON")
}

fn table(raw: &[(String, V)], name: &str) -> V {
	raw.iter().find(|(f, _)| f == name).map(|(_, v)| v.clone()).unwrap_or_else(|| panic!("no {name}"))
}

// A copy of the fixture data folder with edits applied: edit(raw) mutates parsed JSON by file name.
fn data_with(edit: impl FnOnce(&[(String, V)])) -> (TempDir, Data) {
	let dir = TempDir::new("polestar-data-");
	let src = dsl::data_dir();
	let mut names: Vec<String> = fs::read_dir(&src).unwrap().map(|e| e.unwrap().file_name().to_string_lossy().into_owned()).collect();
	names.sort();
	let mut raw = Vec::new();
	for f in names {
		let text = fs::read_to_string(src.join(&f)).unwrap();
		raw.push((f, jv(&text)));
	}
	edit(&raw);
	for (f, v) in &raw {
		fs::write(dir.path().join(f), stringify(v, None)).unwrap();
	}
	let data = forge_guide::data::load_data(dir.path()).unwrap();
	(dir, data)
}

fn find_guide_files(base: &Path, sub: &Path, out: &mut Vec<String>) {
	for entry in fs::read_dir(base.join(sub)).unwrap() {
		let entry = entry.unwrap();
		let name = entry.file_name().to_string_lossy().into_owned();
		let rel = sub.join(&name);
		if entry.file_type().unwrap().is_dir() {
			if !name.starts_with('.') && !["dist", "drafts", "node_modules"].contains(&name.as_str()) {
				find_guide_files(base, &rel, out);
			}
		} else if name.ends_with(".guide") {
			out.push(rel.to_string_lossy().replace('\\', "/"));
		}
	}
}

const REGISTER_RESULTS: &str = r#"
			@TEST_PACK@
			local results = {}
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) local ok, e = real(g); results[#results + 1] = ok and "ok" or e; return ok, e end
			assert(loadfile(@FILE@))("Polestar_Guides", {})
			emit({ results = results })"#;

const REGISTER_GUIDE: &str = r#"
			@TEST_PACK@
			local got, results = nil, {}
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) got = g; local ok, e = real(g); results[#results + 1] = ok and "ok" or e; return ok, e end
			assert(loadfile(@FILE@))("Polestar_Guides", {})
			emit({ results = results, guide = got })"#;

const FRAMES: &str = r#"
			local frames, guides = {}, {}
			Polestar.RegisterPack = function() end
			Polestar.RegisterMapFrames = function(t) for k, v in pairs(t.era) do frames[k] = v end end
			Polestar.RegisterGuide = function(g) guides[#guides + 1] = g end
			for _, f in ipairs({ @ORDER@ }) do assert(loadfile(f))("Polestar_Guides", {}) end
			local missing, era, seen = {}, 0, {}
			local function walk(t, where)
				if seen[t] then return end
				seen[t] = true
				if t.f == "e" then
					era = era + 1
					if not frames[t.map] then missing[#missing + 1] = where .. " map " .. tostring(t.map) end
				end
				for k, v in pairs(t) do if type(v) == "table" then walk(v, where .. "." .. tostring(k)) end end
			end
			for _, g in ipairs(guides) do walk(g, g.id) end
			local candidateMaps = {}
			for _, g in ipairs(guides) do
				if g.id == "t/d" then
					for _, goal in ipairs(g.steps[1].goals) do
						for _, c in ipairs(goal.candidates or {}) do candidateMaps[c.map] = true end
					end
				end
			end
			local maps = {}
			for m in pairs(candidateMaps) do maps[#maps + 1] = m end
			table.sort(maps)
			emit({ missing = table.concat(missing, "; "), era = era, candidateMaps = maps })"#;

#[test]
fn every_goal_of_a_quest_that_needs_a_profession_carries_it_a_leveling_guide_warns_on_its_non_optional_goals_unless_it_trains_the_profession_first() {
	// Kobold Camp Cleanup (7) needs Mining 50, Wolves Across the Border (33) Mining with no level (rank 1).
	let (_dir, data) = data_with(|raw| {
		let quests = table(raw, "quests.json");
		let q7 = quests.get("7");
		q7.set("skill", jv("186"));
		q7.set("skillLevel", jv("50"));
		q7.set("pre", jv("[]"));
		quests.get("33").set("skill", jv("186"));
	});
	let src = |category: &str, lines: &[&str]| -> Vec<String> {
		let cat = format!("category {category}");
		let mut v = head(Some("Alliance"), &[&cat]);
		v.push("step S".into());
		v.extend(lines.iter().map(|s| s.to_string()));
		v
	};
	let steps = ["  accept 7", "  kill 6 quest 7", "  turnin 7 optional", "  accept 33 optional", "  accept 9500"];
	let (r, g) = goals_of(&src("Leveling", &steps), &data);
	let got: Vec<Value> = g.iter().map(|x| json!([x["t"], x["profLine"], x["profName"], x["profRank"]])).collect();
	assert_eq!(
		got,
		vec![json!(["accept", 186, "Mining", 50]), json!(["kill", 186, "Mining", 50]), json!(["turnin", 186, "Mining", 50]), json!(["accept", 186, "Mining", 1]), json!(["accept", null, null, null]),]
	);
	let text = format!("{}\n", src("Leveling", &steps).join("\n"));
	let warned = only(&r.warnings, "needs Mining");
	assert_eq!(
		warned,
		vec![
			format!(
				"test.guide:{}: quest 7 (Kobold Camp Cleanup) needs Mining 50, and the guide does not train it before here: characters without it never see this goal",
				dsl::line_of(&text, "accept 7")
			),
			format!(
				"test.guide:{}: quest 7 (Kobold Camp Cleanup) needs Mining 50, and the guide does not train it before here: characters without it never see this goal",
				dsl::line_of(&text, "kill 6 quest 7")
			),
		]
	);
	// Trained earlier in the guide (levelled to the quest's rank above 1), or another category: no warning.
	let warns = |category: &str, lines: &[&str]| only(&goals_of(&src(category, lines), &data).0.warnings, "needs Mining").len();
	assert_eq!(warns("Leveling", &["  train Mining", "  accept 33"]), 0);
	assert_eq!(warns("Leveling", &["  train Mining", "  accept 7"]), 1);
	assert_eq!(warns("Leveling", &["  skill Mining 50", "  accept 7"]), 0);
	assert_eq!(warns("Class", &steps), 0);
	// The Core's registry takes the new fields.
	let test_text = text.replacen("guide t/", "guide test/", 1);
	let pack = dsl::compile_with(&[("test.guide", &test_text)], &data, Some("test"));
	let tp = dsl::write_test_pack(&pack.guides, &data, &dsl::our_manifest());
	let file = tp.dir.join(tp.guides_of("test/s"));
	assert!(is_match(&fs::read_to_string(&file).unwrap(), r#"profLine = 186, profName = "Mining", profRank = 50"#));
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: REGISTER_RESULTS.replace("@TEST_PACK@", TEST_PACK).replace("@FILE@", &lua_string(&file.to_string_lossy())),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["results"], json!(["ok"]));
}

#[test]
fn smart_goals_emit_lua_the_real_engine_registry_accepts_and_round_trip() {
	let mut src = head(None, &[]);
	for l in ["step S", "  train Mining", "  train class", "  buy 159 nearest", "  vendor nearest", "  sethome nearest", "  accept 9500"] {
		src.push(l.to_string());
	}
	let text = format!("{}\n", src.join("\n")).replacen("guide t/", "guide test/", 1);
	let r = dsl::compile_with(&[("test.guide", &text)], &dsl::fixture_data(), Some("test"));
	assert_eq!(r.errors, Vec::<String>::new());
	let tp = dsl::write_our_test_pack(&r.guides);
	let file = tp.dir.join(tp.guides_of("test/s"));
	let lua = fs::read_to_string(&file).unwrap();
	assert!(is_match(
		&lua,
		r#"\{ t = "train", class = true, candidates = \{ \{ npc = 911, npcName = "Llane Beshere", map = 1429, x = 50\.2, y = 42\.3, f = "e", faction = "A", classes = \{ "WARRIOR" \} \}"#
	));
	assert!(is_match(&lua, r#"\{ t = "accept", quest = 9500, title = "Either Way", npc = 823, npcName = "Deputy Willem", minLevel = 1, qlvl = 3, pre = \{ 9201, 783 \},"#));
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: REGISTER_GUIDE.replace("@TEST_PACK@", TEST_PACK).replace("@FILE@", &lua_string(&file.to_string_lossy())),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["results"], json!(["ok"]));
	assert_eq!(out["guide"], dsl::plain(&r.guides[0]));
}

#[test]
fn every_era_frame_coordinate_in_an_emitted_pack_candidates_included_has_its_map_frame_registered() {
	// A Durotar guide whose trainer candidates stand in Elwynn, Stormwind and
	// Dun Morogh: those maps' frames must ship too, or the engine cannot place them.
	let durotar = format!(
		"{}\n",
		["guide t/d", "title D", "levels 1-60", "zone Durotar", "", "step S", "  train First Aid Apprentice", "  train Mining", "  train class", "  vendor nearest", "  sethome nearest"].join("\n")
	);
	let guides_dir = dsl::data_dir().parent().unwrap().join("guides");
	let mut fixture_guides = Vec::new();
	find_guide_files(&guides_dir, Path::new(""), &mut fixture_guides);
	fixture_guides.sort();
	let mut sources: Vec<(String, String)> = vec![("d.guide".to_string(), durotar)];
	for f in &fixture_guides {
		sources.push((f.clone(), fs::read_to_string(guides_dir.join(f)).unwrap()));
	}
	let list: Vec<(&str, &str)> = sources.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let r = dsl::compile_with(&list, &dsl::fixture_data(), None);
	assert_eq!(r.errors, Vec::<String>::new());
	let tp = dsl::write_our_test_pack(&r.guides);
	let order = tp.scripts.iter().map(|f| lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", ");
	let out = emitted(&RunAddon { addons: vec![Addon::files("Polestar", &["Core/Init.lua"])], script: FRAMES.replace("@ORDER@", &order), ..Default::default() }).remove(0);
	assert_eq!(out["missing"], "");
	assert!(out["era"].as_f64().unwrap() > 20.0, "{}", out["era"]);
	// The repro's shape: candidates on maps other than the guide's own zone.
	let maps = out["candidateMaps"].as_array().unwrap();
	assert!(maps.contains(&json!(1429)) && maps.contains(&json!(1426)), "{}", maps.iter().map(|m| m.to_string()).collect::<Vec<_>>().join(","));
	assert!(is_match(tp.text("MapFrames.lua"), r"\[1426\] = "));
}
