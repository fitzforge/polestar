//! The committed addon/Polestar_Guides/Guides.lua and its faction parts (Polestar_Guides_Alliance, _Horde),
//! loaded the way the game loads them, hold what `compile` writes from the .guide sources: every goal inside
//! its step's `goals`, every goal a kind the engine knows, and per guide the source's steps with their goal
//! kinds and quests in order. A hunk of Guides.lua spliced by hand can break that and still be valid Lua: a
//! goal left between `title =` and `goals = {`, or a step's `goals` left open so the next step becomes one of
//! its goals. The game loads either without an error and never shows those goals. Needs no reference data,
//! so CI runs it.

use forge_addontest::run::{addons_dir, root};
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use forge_guide::diag::Diagnostics;
use forge_guide::emit::GOAL_KEYS;
use forge_guide::parse::parse_guide;
use forge_guide::project::find_guide_files;
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::sync::OnceLock;

const HINT: &str = "Guides.lua comes from `forge guide compile`, never a hand edit (CONTRIBUTING.md, \"Fixing a guide\")";

fn pack_dir() -> PathBuf {
	addons_dir().join("Polestar_Guides")
}

fn official_dir() -> PathBuf {
	root().join("guides")
}

struct SrcStep {
	title: String,
	goals: Vec<String>,
}

struct SrcGuide {
	file: String,
	steps: Vec<SrcStep>,
}

/// A JS Map: entries in insertion order.
type Sources = Vec<(String, SrcGuide)>;
type CompiledSteps = Vec<(String, Vec<Vec<String>>)>;

fn get<'a, T>(m: &'a [(String, T)], k: &str) -> Option<&'a T> {
	m.iter().find(|(key, _)| key == k).map(|(_, v)| v)
}

fn set<T>(m: &mut Vec<(String, T)>, k: String, v: T) {
	match m.iter_mut().find(|(key, _)| *key == k) {
		Some(e) => e.1 = v,
		None => m.push((k, v)),
	}
}

// Per step of every source guide: "<verb> <quest>" for each goal, in order.
fn source_guides() -> Sources {
	let dir = official_dir();
	let mut out = Vec::new();
	for file in find_guide_files(&dir, false) {
		let src = std::fs::read_to_string(dir.join(&file)).unwrap_or_else(|e| panic!("{file}: {e}"));
		let guide = parse_guide(&src, &file, &mut Diagnostics::new());
		let steps = guide
			.get("steps")
			.items()
			.iter()
			.map(|s| SrcStep {
				title: s.get("title").to_js_string(),
				goals: s
					.get("goals")
					.items()
					.iter()
					.map(|g| {
						let q = g.get("quest");
						if q.is_nullish() {
							g.get("verb").to_js_string()
						} else {
							format!("{} {}", g.get("verb").to_js_string(), q.to_js_string())
						}
					})
					.collect(),
			})
			.collect();
		set(&mut out, guide.get("id").to_js_string(), SrcGuide { file, steps });
	}
	out
}

fn lua_str(s: &str) -> String {
	serde_json::to_string(s).unwrap()
}

const LOAD_SCRIPT: &str = r#"
local G = Polestar.Guides
local r = G.Pack("guides")
local problems = {}
for _, p in ipairs(r and r.problems or {}) do problems[#problems + 1] = p.message end
emit({ status = r and r.status or "missing", problems = problems })

local GOAL_KEYS = { @GOAL_KEYS@ }
-- Format 8 writes a goal's spots as one string.
GOAL_KEYS.spotsPacked = true
local raw = {}
local register = Polestar.RegisterGuide
Polestar.RegisterGuide = function(def) raw[#raw + 1] = def end
for _, f in ipairs({ @GUIDES_LUA@ }) do dofile(f) end
Polestar.RegisterGuide = register

local function isIndex(k, n) return type(k) == "number" and k >= 1 and k <= n and k % 1 == 0 end
local function goalShaped(v)
	return type(v) == "table" and (v.t ~= nil or v.goals ~= nil or (type(v[1]) == "table" and v[1].t ~= nil))
end
for _, def in ipairs(raw) do
	local bad, steps = {}, {}
	local function add(msg) bad[#bad + 1] = msg end
	for k, v in pairs(def) do
		if type(k) ~= "string" then add("entry [" .. tostring(k) .. "] outside steps")
		elseif k ~= "steps" and goalShaped(v) then add(k .. " holds a step or goal") end
	end
	local list = type(def.steps) == "table" and def.steps or {}
	for k in pairs(list) do
		if not isIndex(k, #list) then add("steps holds a non-step entry [" .. tostring(k) .. "]") end
	end
	for s = 1, #list do
		local step = list[s]
		local at = ("step %d"):format(s)
		if type(step) == "table" and type(step.title) == "string" then at = at .. " (" .. step.title .. ")" end
		local kinds = {}
		if type(step) ~= "table" then
			add(at .. ": not a table")
		else
			for k, v in pairs(step) do
				if type(k) ~= "string" then add(at .. ": entry [" .. tostring(k) .. "] outside goals")
				elseif k ~= "goals" and goalShaped(v) then add(at .. ": " .. k .. " holds a goal") end
			end
			local goals = type(step.goals) == "table" and step.goals or {}
			if type(step.goals) ~= "table" then add(at .. ": no goals") end
			for k in pairs(goals) do
				if not isIndex(k, #goals) then add(at .. ": goals holds a non-goal entry [" .. tostring(k) .. "]") end
			end
			for i = 1, #goals do
				local goal = goals[i]
				local where = ("%s goal %d"):format(at, i)
				if type(goal) ~= "table" then
					add(where .. ": not a table")
					kinds[i] = "?"
				else
					if not G.VERBS[goal.t] then add(where .. ": unknown kind t = " .. tostring(goal.t)) end
					for k in pairs(goal) do
						if not GOAL_KEYS[k] then add(where .. ": key [" .. tostring(k) .. "] that compile never writes") end
					end
					kinds[i] = goal.quest ~= nil and (tostring(goal.t) .. " " .. tostring(goal.quest)) or tostring(goal.t)
				end
			end
		end
		steps[s] = { title = type(step) == "table" and step.title or nil, goals = kinds }
	end
	emit({ id = tostring(def.id), bad = bad, steps = steps })
end"#;

struct Loaded {
	problems: Vec<String>,
	shape: Vec<String>,
	steps: CompiledSteps,
}

fn arr(v: &Value) -> &[Value] {
	v.as_array().map(|a| a.as_slice()).unwrap_or(&[])
}

fn str_of(v: &Value) -> String {
	v.as_str().map(String::from).unwrap_or_else(|| v.to_string())
}

// The pack in `dir` and its faction parts beside it (Polestar_Guides_Alliance, _Horde), as (addon, folder).
fn pack_parts(dir: &Path) -> Vec<(String, PathBuf)> {
	let mut out = vec![("Polestar_Guides".to_string(), dir.to_path_buf())];
	for f in forge_guide::project::FACTION_PARTS {
		let name = forge_guide::project::part_addon("Polestar_Guides", f);
		let part = dir.parent().unwrap().join(&name);
		if part.exists() {
			out.push((name, part));
		}
	}
	out
}

// Loads Polestar's core, the pack in `dir` and its faction parts through the real registry, then runs their
// Guides.lua again with RegisterGuide capturing each table as written, and walks those.
fn load(dir: &Path) -> Loaded {
	let goal_keys = GOAL_KEYS.iter().map(|k| format!("[{}] = true", lua_str(k))).collect::<Vec<_>>().join(", ");
	let parts = pack_parts(dir);
	let files = parts.iter().map(|(_, d)| lua_str(&d.join("Guides.lua").to_string_lossy())).collect::<Vec<_>>().join(", ");
	let script = LOAD_SCRIPT.replace("@GOAL_KEYS@", &goal_keys).replace("@GUIDES_LUA@", &files);
	let mut addons = vec![Addon::files("Polestar", &["Core/Core.xml"])];
	addons.extend(parts.iter().map(|(n, d)| Addon::dir(n, d.clone())));
	let out = emitted(&RunAddon { addons, script, ..Default::default() });
	let (registry, guides) = out.split_first().expect("the registry's line");
	let mut problems: Vec<String> = Vec::new();
	if text(&registry["status"]) != "on" {
		problems.push(format!("pack guides: {}", text(&registry["status"])));
	}
	problems.extend(arr(&registry["problems"]).iter().map(str_of));
	let mut shape = Vec::new();
	let mut steps: CompiledSteps = Vec::new();
	for g in guides {
		let id = str_of(&g["id"]);
		for msg in arr(&g["bad"]) {
			shape.push(format!("{id}: {}", str_of(msg)));
		}
		if get(&steps, &id).is_some() {
			shape.push(format!("{id}: registered twice"));
		}
		let list = arr(&g["steps"]).iter().map(|s| arr(&s["goals"]).iter().map(str_of).collect()).collect();
		set(&mut steps, id, list);
	}
	Loaded { problems, shape, steps }
}

// Differences between the compiled guides and the sources: missing or extra guides, step counts, and per step
// the goal kinds and quests in order.
fn diff(compiled: &CompiledSteps, sources: &Sources) -> Vec<String> {
	let mut out = Vec::new();
	for (id, src) in sources {
		let Some(steps) = get(compiled, id) else {
			out.push(format!("{id}: in {} but not in Guides.lua", src.file));
			continue;
		};
		let first = src.steps.iter().enumerate().position(|(i, s)| steps.get(i) != Some(&s.goals));
		if steps.len() != src.steps.len() {
			let at = first.map(|f| format!("; first difference at step {} ({})", f + 1, src.steps[f].title)).unwrap_or_default();
			out.push(format!("{id}: {} steps compiled, {} in {}{at}", steps.len(), src.steps.len(), src.file));
			continue;
		}
		for (i, s) in src.steps.iter().enumerate() {
			if steps[i] != s.goals {
				out.push(format!("{id} step {} ({}): compiled [{}], source [{}]", i + 1, s.title, steps[i].join(", "), s.goals.join(", ")));
			}
		}
	}
	for id in compiled.iter().map(|(id, _)| id) {
		if get(sources, id).is_none() {
			out.push(format!("{id}: in Guides.lua but no source"));
		}
	}
	out
}

static SOURCES: OnceLock<Sources> = OnceLock::new();
static COMMITTED: OnceLock<Loaded> = OnceLock::new();

fn setup() -> (&'static Sources, &'static Loaded) {
	(SOURCES.get_or_init(source_guides), COMMITTED.get_or_init(|| load(&pack_dir())))
}

#[test]
fn the_committed_polestar_guides_registers_every_guide_with_no_problems() {
	let (_, committed) = setup();
	assert!(committed.steps.len() > 100, "found {} guides", committed.steps.len());
	assert_eq!(committed.problems, Vec::<String>::new(), "{HINT}");
}

#[test]
fn every_compiled_goal_sits_in_its_step_s_goals_and_is_a_kind_the_engine_knows() {
	let (_, committed) = setup();
	assert_eq!(committed.shape, Vec::<String>::new(), "{HINT}");
}

// Contributors leave Guides.lua to the maintainer, who recompiles it after a guide change merges
// (CONTRIBUTING.md, `polestar regen`), so a pull request that changes a guide is out of step here until then:
// noted, not failed. The two checks above still fail a hand-edited file.
#[test]
fn every_compiled_guide_has_its_source_s_steps_goal_kinds_and_quests() {
	let (sources, committed) = setup();
	let stale = diff(&committed.steps, sources);
	if !stale.is_empty() {
		eprintln!(
			"Guides.lua is behind guides/ in {} place(s); the maintainer runs `node tools/polestar.js regen` after merge:\n{}",
			stale.len(),
			stale.iter().take(10).cloned().collect::<Vec<_>>().join("\n")
		);
	}
}

fn copy_dir(from: &Path, to: &Path) {
	std::fs::create_dir_all(to).unwrap();
	for e in std::fs::read_dir(from).unwrap() {
		let e = e.unwrap();
		let dest = to.join(e.file_name());
		if e.file_type().unwrap().is_dir() {
			copy_dir(&e.path(), &dest);
		} else {
			std::fs::copy(e.path(), &dest).unwrap();
		}
	}
}

// The two hand-splice shapes this test exists for, made from a copy of the committed files: each must fail the
// checks above. `edit` returns the id of the guide it broke (in the pack's own Guides.lua).
fn broken_copy(edit: impl FnOnce(&mut Vec<String>) -> String) -> (TempDir, PathBuf, String) {
	let tmp = TempDir::new("polestar-guides-");
	for (name, from) in pack_parts(&pack_dir()) {
		copy_dir(&from, &tmp.path().join(name));
	}
	let dir = tmp.path().join("Polestar_Guides");
	let file = dir.join("Guides.lua");
	let mut lines: Vec<String> = std::fs::read_to_string(&file).unwrap().split('\n').map(String::from).collect();
	let id = edit(&mut lines);
	std::fs::write(&file, lines.join("\n")).unwrap();
	(tmp, dir, id)
}

const GOALS_OPEN: &str = "\t\t\t\t\tgoals = {";
const GOALS_CLOSE: &str = "\t\t\t\t\t},";
const STEP_CLOSE: &str = "\t\t\t\t},";
const STEP_OPEN: &str = "\t\t\t\t{";

fn is_goal(line: Option<&String>) -> bool {
	line.is_some_and(|l| l.starts_with("\t\t\t\t\t\t{ t = "))
}

/// The id of the guide whose block holds line `i`.
fn guide_id_before(lines: &[String], i: usize) -> String {
	let l = lines[..i].iter().rev().find(|l| l.starts_with("\t\t\tid = ")).expect("an id line");
	let (a, b) = (l.find('"').unwrap(), l.rfind('"').unwrap());
	l[a + 1..b].to_string()
}

#[test]
fn a_goal_spliced_in_before_goals_fails_the_checks() {
	let (sources, committed) = setup();
	let (_tmp, dir, id) = broken_copy(|lines| {
		let i = (0..lines.len()).position(|j| lines[j] == GOALS_OPEN && is_goal(lines.get(j + 1)) && is_goal(lines.get(j + 2))).unwrap();
		let id = guide_id_before(lines, i);
		let l = lines.remove(i + 1);
		lines.insert(i, l);
		id
	});
	let broken = load(&dir);
	assert_eq!(broken.problems, committed.problems, "the registry takes it without a word");
	assert!(is_match(&broken.shape.join("\n"), &format!(r"(?m)^{id}: step \d+ \(.+\): entry \[1\] outside goals$")));
	assert!(is_match(&diff(&broken.steps, sources).join("\n"), &format!(r"(?m)^{id} step \d+ ")));
}

#[test]
fn a_step_left_open_so_the_next_step_becomes_its_goal_fails_the_checks() {
	let (sources, _) = setup();
	let (_tmp, dir, id) = broken_copy(|lines| {
		// Drop one step's closers and put them back after the next step.
		let i = (0..lines.len()).position(|j| lines[j] == GOALS_CLOSE && lines.get(j + 1).is_some_and(|l| l == STEP_CLOSE) && lines.get(j + 2).is_some_and(|l| l == STEP_OPEN)).unwrap();
		let id = guide_id_before(lines, i);
		let closers: Vec<String> = lines.drain(i..i + 2).collect();
		let end = i + lines[i..].iter().position(|l| l == STEP_CLOSE).unwrap();
		for (k, c) in closers.into_iter().enumerate() {
			lines.insert(end + 1 + k, c);
		}
		id
	});
	let broken = load(&dir);
	assert!(is_match(&broken.problems.join("\n"), &format!("Guide {id} was refused")), "the registry refuses the guide, silently in game");
	assert!(is_match(&broken.shape.join("\n"), &format!(r"(?m)^{id}: step \d+ \(.+\) goal \d+: unknown kind t = nil$")));
	assert!(is_match(&diff(&broken.steps, sources).join("\n"), &format!(r"(?m)^{id}: \d+ steps compiled, \d+ in ")));
}
