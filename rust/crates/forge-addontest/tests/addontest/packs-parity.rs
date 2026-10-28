//! Lint and the runtime refuse the same guides: for every reason Polestar.RegisterGuide refuses a guide
//! (Core/Guides.lua validate() and the pack rules), a .guide under tests/fixtures/packs/parity/ that lint
//! rejects, and its compiled twin (hand-written below) that the runtime refuses. The verb reasons are derived
//! by running the validator over its own verb table (Guides.VERBS), so a verb or required field added to Core
//! without a fixture here fails this test.

use forge_addontest::run::root;
use forge_addontest::{dsl, emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};
use std::collections::HashSet;
use std::path::{Path, PathBuf};
use std::process::Command;

fn parity() -> PathBuf {
	root().join("tests/fixtures/packs/parity")
}

fn context() -> PathBuf {
	root().join("tests/fixtures/packs/context")
}

// The registry's refusal of a guide outside its pack's prefix.
const OUTSIDE: &str = "Guide forever/parity-outside was refused: its id must start with parity/.";

enum Twin {
	Goal(&'static str),
	Def(&'static str),
	Id(&'static str),
}

struct Case {
	file: &'static str,
	reason: &'static str,
	lint: &'static str,
	twin: Twin,
}

const fn goal(file: &'static str, reason: &'static str, lint: &'static str, goal: &'static str) -> Case {
	Case { file, reason, lint, twin: Twin::Goal(goal) }
}

const fn def(file: &'static str, reason: &'static str, lint: &'static str, def: &'static str) -> Case {
	Case { file, reason, lint, twin: Twin::Def(def) }
}

const fn id(file: &'static str, reason: &'static str, lint: &'static str, id: &'static str) -> Case {
	Case { file, reason, lint, twin: Twin::Id(id) }
}

// The runtime's refusal reasons this test covers: { file (under guides/), reason (RegisterGuide's error,
// "step 1 goal 1: " dropped), lint (a message lint gives for the file), goal (the compiled goal, Lua) | def (the
// whole compiled guide, Lua, without id/pack/title) | id }.
const CASES: &[Case] = &[
	goal("accept-quest", "accept needs quest", r"`accept` needs a quest id", r#"{ t = "accept", title = "A Threat Within" }"#),
	goal("accept-title", "accept needs title", r"quest 999999 is not in data", r#"{ t = "accept", quest = 999999 }"#),
	goal("turnin-quest", "turnin needs quest", r"`turnin` needs a quest id", r#"{ t = "turnin", title = "A Threat Within" }"#),
	goal("turnin-title", "turnin needs title", r"quest 999999 is not in data", r#"{ t = "turnin", quest = 999999 }"#),
	goal("abandon-quest", "abandon needs quest", r"`abandon` needs a quest id", r#"{ t = "abandon", title = "A Threat Within" }"#),
	goal("abandon-title", "abandon needs title", r"quest 999999 is not in data", r#"{ t = "abandon", quest = 999999 }"#),
	goal("destroy-item", "destroy needs item", r"`destroy` needs an item id", r#"{ t = "destroy", itemName = "Hearthstone" }"#),
	goal("destroy-itemname", "destroy needs itemName", r"item 999999 is not in data", r#"{ t = "destroy", item = 999999 }"#),
	goal("complete-quest", "complete needs quest", r"`complete` needs a quest id", r#"{ t = "complete", title = "A Threat Within" }"#),
	goal("complete-title", "complete needs title", r"quest 999999 is not in data", r#"{ t = "complete", quest = 999999 }"#),
	goal("kill-target", "kill needs target", r#"`kill` needs an npc id or "Target name""#, r#"{ t = "kill" }"#),
	goal("collect-item", "collect needs item", r"`collect` needs an item id", r#"{ t = "collect", itemName = "Linen Cloth" }"#),
	goal("collect-itemname", "collect needs itemName", r"item 999999 is not in data", r#"{ t = "collect", item = 999999 }"#),
	goal("goto-map", "goto needs map", r"coordinates need a zone", r#"{ t = "goto", x = 50, y = 50 }"#),
	goal("goto-x", "goto needs x", r#"malformed coordinates ",50""#, r#"{ t = "goto", map = 1429, y = 50 }"#),
	goal("goto-y", "goto needs y", r#"malformed coordinates "50,""#, r#"{ t = "goto", map = 1429, x = 50 }"#),
	goal("talk-npc", "talk needs npc", r"`talk` needs an npc id", r#"{ t = "talk", npcName = "Marshal McBride" }"#),
	goal("talk-npcname", "talk needs npcName", r"npc 999999 is not in data", r#"{ t = "talk", npc = 999999 }"#),
	goal("interact-object", "interact needs object", r"`interact` needs an object id", r#"{ t = "interact", objName = "Kobold Crate" }"#),
	goal("interact-objname", "interact needs objName", r"object 999999 is not in data", r#"{ t = "interact", object = 999999 }"#),
	goal("use-item", "use needs item", r"`use` needs an item id", r#"{ t = "use", itemName = "Hearthstone" }"#),
	goal("use-itemname", "use needs itemName", r"item 999999 is not in data", r#"{ t = "use", item = 999999 }"#),
	goal("sethome-location", "sethome needs location", r#"`sethome` needs a "Location" or `nearest`"#, r#"{ t = "sethome" }"#),
	goal("hearth-location", "hearth needs location", r#"`hearth` needs a "Location""#, r#"{ t = "hearth" }"#),
	goal("getfp-location", "getfp needs location", r#"`getfp` needs a "Location""#, r#"{ t = "getfp" }"#),
	goal("fly-location", "fly needs location", r#"`fly` needs a "Location""#, r#"{ t = "fly" }"#),
	goal("die-location", "die needs location", r#"`die` needs a "Location""#, r#"{ t = "die", map = 1429, x = 50, y = 50 }"#),
	goal("die-map", "die needs map", r"coordinates need a zone", r#"{ t = "die", location = "Goldshire", x = 50, y = 50 }"#),
	goal("die-x", "die needs x", r#"malformed coordinates ",50""#, r#"{ t = "die", location = "Goldshire", map = 1429, y = 50 }"#),
	goal("die-y", "die needs y", r#"malformed coordinates "50,""#, r#"{ t = "die", location = "Goldshire", map = 1429, x = 50 }"#),
	goal("enter-location", "enter needs location", r#"`enter` needs a "Location""#, r#"{ t = "enter" }"#),
	goal("buy-item", "buy needs item", r"`buy` needs an item id", r#"{ t = "buy", itemName = "Refreshing Spring Water" }"#),
	goal("buy-itemname", "buy needs itemName", r"item 999999 is not in data", r#"{ t = "buy", item = 999999 }"#),
	goal("level-level", "level needs level", r#"malformed level """#, r#"{ t = "level" }"#),
	goal("money-money", "money needs money", r#"malformed amount """#, r#"{ t = "money" }"#),
	goal("wait-seconds", "wait needs seconds", r#"malformed seconds """#, r#"{ t = "wait" }"#),
	goal("task-text", "task needs text", r"`task` needs text", r#"{ t = "task" }"#),
	goal("note-text", "note needs text", r"`note` needs text", r#"{ t = "note" }"#),
	goal("skill-skill", "skill needs skill", r"`skill` needs a profession and a rank", r#"{ t = "skill", level = 75 }"#),
	goal("skill-level", "skill needs level", r"`skill` needs a profession and a rank", r#"{ t = "skill", skill = "First Aid" }"#),
	goal("learn-spell", "learn needs spell", r"`learn` needs a spell id", r#"{ t = "learn", spellName = "First Aid" }"#),
	goal("learn-spellname", "learn needs spellName", r"spell 999999 is not in data", r#"{ t = "learn", spell = 999999 }"#),
	goal("cast-spell", "cast needs spell", r"`cast` needs a spell id", r#"{ t = "cast", spellName = "Basic Campfire" }"#),
	goal("cast-spellname", "cast needs spellName", r"spell 999999 is not in data", r#"{ t = "cast", spell = 999999 }"#),
	goal("craft-spell", "craft needs spell", r"`craft` needs a spell id", r#"{ t = "craft", spellName = "Linen Bandage" }"#),
	goal("craft-spellname", "craft needs spellName", r"spell 999999 is not in data", r#"{ t = "craft", spell = 999999 }"#),
	goal("rep-faction", "rep needs faction", r#"unknown faction "Made Up""#, r#"{ t = "rep", factionName = "Made Up", standing = 5 }"#),
	goal("rep-factionname", "rep needs factionName", r"faction 999999 is not in data", r#"{ t = "rep", faction = 999999, standing = 5 }"#),
	goal("rep-standing", "rep needs standing", r"`rep` needs a faction and a standing", r#"{ t = "rep", faction = 69, factionName = "Darnassus" }"#),
	goal("explore-map", "explore needs map", r"coordinates need a zone", r#"{ t = "explore", x = 50, y = 50 }"#),
	goal("explore-x", "explore needs x", r#"malformed coordinates ",50""#, r#"{ t = "explore", map = 1429, y = 50 }"#),
	goal("explore-y", "explore needs y", r#"malformed coordinates "50,""#, r#"{ t = "explore", map = 1429, x = 50 }"#),
	goal("achieve-achievement", "achieve needs achievement", r"`achieve` needs an achievement id", r#"{ t = "achieve", achievementName = "Level 10" }"#),
	goal("achieve-achievementname", "achieve needs achievementName", r"achievement 999999 has no reference data", r#"{ t = "achieve", achievement = 999999 }"#),
	// Not derived from the verb table: the rest of the runtime's rules.
	goal("unknown-verb", "unknown verb fish", r#"unknown verb "fish""#, r#"{ t = "fish" }"#),
	goal("coords-range", "coordinates outside 0-100", r"coordinates 150,50 are outside 0-100", r#"{ t = "goto", map = 1429, x = 150, y = 50 }"#),
	def("step-no-goals", "step 1 has no goals", r"step has no goals", r#"{ steps = { { goals = {} }, { goals = { { t = "level", level = 2 } } } } }"#),
	def(
		"step-image",
		"step 1: bad image",
		r#"image path "\.\./outside\.tga" leaves the pack folder"#,
		r#"{ steps = { { image = { file = "..\\outside" }, goals = { { t = "level", level = 2 } } } } }"#,
	),
	def("guide-no-steps", "no steps", r"guide has no steps", r#"{ steps = {} }"#),
	id("id-outside", OUTSIDE, r#"is outside pack "parity""#, "forever/parity-outside"),
];

// Generic reasons the runtime gives whatever the verb table holds; every other goal-level reason is derived
// from Guides.VERBS below.
const GENERIC: [&str; 6] = ["unknown verb fish", "coordinates outside 0-100", "step 1 has no goals", "step 1: bad image", "no steps", OUTSIDE];

// Lua: the runtime's verb reasons, derived from Guides.VERBS: for each verb a goal with every required field
// filled (its own checker picks a number or a string), then that goal without each field in turn; a filled
// goal that still fails gives its own reason (sethome's location rule).
const DERIVE: &str = r#"
local G = Polestar.Guides
local function wrap(goal) return { id = "parity/x", title = "x", steps = { { goals = { goal } } } } end
local function reasonOf(goal)
	local err = G.Validate(wrap(goal))
	return err and (err:gsub("^step 1 goal 1: ", "")) or nil
end
local out = {}
for verb, rules in pairs(G.VERBS) do
	local filled = { t = verb }
	for field, check in pairs(rules) do filled[field] = check(1) and 1 or "x" end
	local own = reasonOf(filled)
	if own then out[#out + 1] = own end
	for field in pairs(rules) do
		local goal = {}
		for k, v in pairs(filled) do goal[k] = v end
		goal[field] = nil
		out[#out + 1] = reasonOf(goal) or (verb .. " accepts a goal without " .. field)
	end
end
table.sort(out)
emit(out)
"#;

const ID_DEF: &str = r#"{ id = "@ID@", pack = "parity", title = "T", steps = { { goals = { { t = "level", level = 2 } } } } }"#;
const DEF_DEF: &str = r#"(function() local d = @DEF@; d.id = @ID@; d.pack = "parity"; d.title = "T"; return d end)()"#;
const GOAL_DEF: &str = r#"{ id = @ID@, pack = "parity", title = "T", steps = { { goals = { { t = "level", level = 2 }, @GOAL@ } } } }"#;

const REGISTER: &str = r#"do local ok, err = Polestar.RegisterGuide(@DEF@); refused[#refused + 1] = { ok = ok, err = err } end"#;

const SCRIPT: &str = r#"
assert(Polestar.RegisterPack({ addon = "ParityAddon", id = "parity", format = 1, title = "Parity", author = "Tests", version = "1.0.0", license = "CC0-1.0" }))
@DERIVE@
refused = {}
@REGISTER@
emit(refused)
"#;

fn compiled_def(c: &Case) -> String {
	let id = format!("\"parity/{}\"", c.file);
	match c.twin {
		Twin::Id(i) => ID_DEF.replace("@ID@", i),
		Twin::Def(d) => DEF_DEF.replace("@ID@", &id).replace("@DEF@", d),
		Twin::Goal(g) => GOAL_DEF.replace("@ID@", &id).replace("@GOAL@", g),
	}
}

fn runtime() -> (Vec<String>, Vec<Value>) {
	let register = CASES.iter().map(|c| REGISTER.replace("@DEF@", &compiled_def(c))).collect::<Vec<_>>().join("\n");
	let script = SCRIPT.replace("@DERIVE@", DERIVE).replace("@REGISTER@", &register);
	let out = emitted(&RunAddon { addons: vec![Addon::files("Polestar", &["Core/Core.xml"])], login: false, script, ..Default::default() });
	let derived = out[0].as_array().expect("derived reasons").iter().map(|v| v.as_str().expect("a reason").to_string()).collect();
	let refused = out[1].as_array().expect("refusals").clone();
	(derived, refused)
}

/// The forge binary: $FORGE, else rust/target/*/forge.
fn forge_bin() -> Option<PathBuf> {
	if let Ok(f) = std::env::var("FORGE") {
		if !f.is_empty() {
			return Some(PathBuf::from(f));
		}
	}
	let mut dirs: Vec<PathBuf> = std::fs::read_dir(root().join("rust/target")).ok()?.filter_map(|e| e.ok().map(|e| e.path())).collect();
	dirs.sort();
	dirs.into_iter().map(|d| d.join("forge")).find(|f| f.is_file())
}

#[test]
fn every_refusal_reason_of_the_runtime_has_a_parity_fixture() {
	let (derived, _) = runtime();
	let covered: HashSet<&str> = CASES.iter().map(|c| c.reason).collect();
	let all: Vec<&str> = derived.iter().map(String::as_str).chain(GENERIC.iter().copied()).collect();
	let missing: Vec<&str> = all.iter().copied().filter(|r| !covered.contains(r)).collect();
	assert_eq!(missing, Vec::<&str>::new(), "Core/Guides.lua refuses guides for these reasons, but tests/fixtures/packs/parity/ has no fixture for them");
	// Every verb case is one the runtime still gives.
	let known: HashSet<&str> = all.into_iter().collect();
	let unknown: Vec<&str> = CASES.iter().filter(|c| !known.contains(c.reason)).map(|c| c.reason).collect();
	assert_eq!(unknown, Vec::<&str>::new());
}

#[test]
fn the_runtime_refuses_each_compiled_twin_for_its_reason() {
	let (_, refused) = runtime();
	assert_eq!(refused.len(), CASES.len());
	let prefix = regex::Regex::new(r"^step 1 goal \d+: ").unwrap();
	for (i, c) in CASES.iter().enumerate() {
		assert_eq!(refused[i]["ok"], false, "{}: the runtime accepted it", c.file);
		let err = match &refused[i]["err"] {
			Value::String(s) => s.clone(),
			Value::Null => "undefined".to_string(),
			v => v.to_string(),
		};
		assert_eq!(prefix.replace(&err, "").to_string(), c.reason, "{}", c.file);
	}
}

#[test]
fn lint_rejects_each_parity_fixture_for_the_matching_reason() {
	let Some(bin) = forge_bin() else {
		eprintln!("skipped: no forge build (lint is forge guide lint)");
		return;
	};
	let mut files: Vec<String> = std::fs::read_dir(parity().join("guides")).expect("parity guides").map(|e| e.unwrap().file_name().to_string_lossy().into_owned()).collect();
	files.sort();
	let mut want: Vec<String> = CASES.iter().map(|c| format!("{}.guide", c.file)).collect();
	want.sort();
	assert_eq!(files, want, "one fixture per case, no strays");
	let data = dsl::data_dir();
	let r = Command::new(&bin)
		.arg("guide")
		.arg("lint")
		.arg("--pack")
		.arg(parity())
		.arg("--data")
		.arg(&data)
		.arg("--context")
		.arg(context())
		.arg("--context-data")
		.arg(&data)
		.arg("--format")
		.arg("json")
		.output()
		.unwrap_or_else(|e| panic!("{}: {e}", bin.display()));
	let stderr = String::from_utf8_lossy(&r.stderr);
	assert_eq!(r.status.code(), Some(1), "{}", stderr);
	let doc: Value = serde_json::from_slice(&r.stdout).expect("lint JSON");
	let diags = doc["diagnostics"].as_array().expect("diagnostics");
	for c in CASES {
		let name = format!("{}.guide", c.file);
		let errors: Vec<&Value> = diags.iter().filter(|d| d["severity"] == "error" && Path::new(text(&d["file"])).file_name().is_some_and(|f| f.to_string_lossy() == name)).collect();
		let messages: Vec<&str> = errors.iter().map(|d| text(&d["message"])).collect();
		assert!(messages.iter().any(|m| is_match(m, c.lint)), "{}.guide: lint gave {}", c.file, json!(messages));
	}
}
