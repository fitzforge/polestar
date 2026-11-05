//! The writer gate's comparison (`forge writer gate-diff`, run by `rust/scripts/writer-gate.sh`): the
//! guides a previous writer and a new one wrote from the same saved routes, each judged by the same
//! judge, compared by what is wrong rather than by line number. The new writer fails the gate when it
//! has a blocker the previous writer did not have:
//!
//! - `check`: a `forge judge check` blocker, keyed by start, rule, guide file, the written line it names
//!   (coordinates and decimals left out) and its message (line numbers, coordinates, yards and minutes
//!   left out), so a blocker that only moved lines is the same blocker;
//! - `seed`: a player-report check (`forge judge seed-tests`) that fails on the start's written tree;
//! - `records`: a places or guide-fixes record the writer reports as not applying (stale, conflicting);
//! - `write`: the writer refused the start (an error, or a tree the pack check refuses).
//!
//! The same key met by more classes than before counts as new too (`spread`). Warnings are counted per
//! rule, never gating.
//!
//! A run folder holds one folder per route set, each with `check.json` (`forge judge check --out`) and
//! `guides/` as `forge writer apply-routes` writes it (`<Start>/forever/...`, `<Start>.status`: `ok` or
//! why the writer failed, `<Start>.log`: the writer's log), with `<Start>.seed.json` (`forge judge
//! seed-tests --json`) beside them.

use regex::Regex;
use rustc_hash::FxHashMap;
use serde::Serialize;
use serde_json::Value;
use std::collections::{BTreeMap, BTreeSet};
use std::path::Path;
use std::sync::LazyLock;

/// One thing wrong in one start's written guides.
#[derive(Clone, Debug, PartialEq, Serialize)]
pub struct Item {
	pub set: String,
	pub start: String,
	/// `check`, `seed`, `records` or `write`.
	pub kind: &'static str,
	/// What it is, without where (line numbers) and by how much (yards, minutes).
	pub key: String,
	/// The classes it holds for (empty: every class).
	#[serde(skip_serializing_if = "Vec::is_empty")]
	pub classes: Vec<String>,
	/// As the judge or the writer said it, with the line.
	pub text: String,
}

/// One route set's items and its warning counts per rule.
#[derive(Debug, Default)]
pub struct SetRun {
	pub items: Vec<Item>,
	pub warns: BTreeMap<String, usize>,
	pub starts: BTreeSet<String>,
}

static COORDS: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"-?\d+(?:\.\d+)?,-?\d+(?:\.\d+)?").unwrap());
static GUIDE_LINE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"(\.guide):\d+(?:-\d+)?").unwrap());
static AMOUNT: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"[+-]?\d+(?:\.\d+)?\s*(?:(yd|yards|min|sec|s|h)\b|(%))").unwrap());
static DECIMAL: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\d+\.\d+").unwrap());
static INDEX: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\b(step|goal|steps|goals) \d+(?::\d+)?").unwrap());
static SPACES: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\s+").unwrap());

/// A written line as a key: its words and whole numbers (quest and item ids, counts), not its
/// coordinates or decimals (levels, shares), which a neighbouring change moves.
pub fn line_key(line: &str) -> String {
	let s = COORDS.replace_all(line.trim(), "x,y");
	let s = DECIMAL.replace_all(&s, "N");
	SPACES.replace_all(&s, " ").into_owned()
}

/// A judge message as a key: guide references without their line numbers, no coordinates, amounts
/// (yards, minutes, shares) or decimals, no step or goal indices.
pub fn message_key(msg: &str) -> String {
	let s = GUIDE_LINE.replace_all(msg, "$1");
	let s = COORDS.replace_all(&s, "x,y");
	let s = AMOUNT.replace_all(&s, "N $1$2");
	let s = DECIMAL.replace_all(&s, "N");
	let s = INDEX.replace_all(&s, "$1 N");
	SPACES.replace_all(s.trim(), " ").into_owned()
}

fn read_json(f: &Path) -> Result<Value, String> {
	let b = std::fs::read(f).map_err(|e| format!("{}: {e}", f.display()))?;
	serde_json::from_slice(&b).map_err(|e| format!("{}: {e}", f.display()))
}

/// The items of one route set's folder in a run.
pub fn read_set(dir: &Path, set: &str) -> Result<SetRun, String> {
	let mut run = SetRun::default();
	let check = read_json(&dir.join("check.json"))?;
	let mut lines: FxHashMap<String, Option<Vec<String>>> = FxHashMap::default();
	for s in check["starts"].as_array().into_iter().flatten() {
		if let Some(s) = s["start"].as_str() {
			run.starts.insert(s.to_string());
		}
	}
	for v in check["violations"].as_array().into_iter().flatten() {
		let (start, file, rule, level, msg) =
			(v["start"].as_str().unwrap_or(""), v["file"].as_str().unwrap_or(""), v["rule"].as_str().unwrap_or(""), v["level"].as_str().unwrap_or(""), v["message"].as_str().unwrap_or(""));
		if level == "warn" {
			*run.warns.entry(rule.to_string()).or_default() += 1;
		}
		if level != "blocker" {
			continue;
		}
		let n = v["line"].as_u64().unwrap_or(0) as usize;
		let text = if file.ends_with(".guide") && n > 0 {
			let ls = lines
				.entry(format!("{start}/{file}"))
				.or_insert_with(|| std::fs::read_to_string(dir.join("guides").join(start).join("forever").join(file)).ok().map(|t| t.lines().map(str::to_string).collect()));
			ls.as_ref().and_then(|ls| ls.get(n - 1)).cloned().unwrap_or_default()
		} else {
			String::new()
		};
		let classes: Vec<String> = v["classes"].as_array().into_iter().flatten().filter_map(|c| c.as_str().map(str::to_string)).collect();
		run.items.push(Item {
			set: set.to_string(),
			start: start.to_string(),
			kind: "check",
			key: format!("{rule} | {file} | {} | {}", line_key(&text), message_key(msg)),
			classes,
			text: format!("{rule} {file}:{n}: {msg}{}", if text.trim().is_empty() { String::new() } else { format!("  (line: `{}`)", text.trim()) }),
		});
	}
	// The writer's own files per start, for every start it was asked to write.
	let guides = dir.join("guides");
	let mut names: BTreeSet<String> = BTreeSet::new();
	for e in std::fs::read_dir(&guides).map_err(|e| format!("{}: {e}", guides.display()))?.flatten() {
		let f = e.file_name().to_string_lossy().into_owned();
		if let Some(s) = f.strip_suffix(".status") {
			names.insert(s.to_string());
		}
	}
	for start in &names {
		run.starts.insert(start.clone());
		let item = |kind: &'static str, key: String, text: String| Item { set: set.to_string(), start: start.clone(), kind, key, classes: Vec::new(), text };
		let status = std::fs::read_to_string(guides.join(format!("{start}.status"))).unwrap_or_default();
		if status.trim() != "ok" {
			run.items.push(item("write", "the writer failed".into(), format!("the writer failed: {}", status.trim())));
			continue;
		}
		let log = std::fs::read_to_string(guides.join(format!("{start}.log"))).unwrap_or_default();
		for l in log.lines() {
			// `fixes: <file> <id>: <state> (<detail>)` (forge_writer::run: records that do not apply).
			let Some(rest) = l.strip_prefix("fixes: ") else { continue };
			let Some((what, state)) = rest.split_once(": ") else { continue };
			let state = state.split(" (").next().unwrap_or(state);
			run.items.push(item("records", format!("{what}: {state}"), l.to_string()));
		}
		if let Ok(seed) = read_json(&guides.join(format!("{start}.seed.json"))) {
			for t in seed["tests"].as_array().into_iter().flatten() {
				let skipped = !t["skipped"].is_null();
				if t["passed"].as_bool() == Some(false) && !skipped {
					let name = t["name"].as_str().unwrap_or("");
					let first = t["failures"].as_array().and_then(|f| f.first()).and_then(Value::as_str).unwrap_or("");
					run.items.push(item("seed", name.to_string(), format!("{name}: {first}")));
				}
			}
		}
	}
	Ok(run)
}

/// The comparison of a new writer's items with a previous writer's.
#[derive(Debug, Default, Serialize)]
pub struct Outcome {
	/// In the new run's items more often than in the previous run's: fails the gate.
	pub new: Vec<Item>,
	/// The same key met by classes the previous run did not meet it for: fails the gate.
	pub spread: Vec<(Item, Vec<String>)>,
	/// In the previous run's items more often than in the new run's.
	pub gone: Vec<Item>,
	/// (set, start, findings left out) for each start the previous writer refused: the new run's findings
	/// there have nothing to be compared with (the refusal itself shows under `gone` when the new writer
	/// writes the start).
	pub no_baseline: Vec<(String, String, usize)>,
}

impl Outcome {
	pub fn passes(&self) -> bool {
		self.new.is_empty() && self.spread.is_empty()
	}
}

type Group<'a> = BTreeMap<(&'a str, &'a str, &'static str, &'a str), Vec<&'a Item>>;

fn group(items: &[Item]) -> Group<'_> {
	let mut g: Group = BTreeMap::new();
	for i in items {
		g.entry((i.set.as_str(), i.start.as_str(), i.kind, i.key.as_str())).or_default().push(i);
	}
	g
}

/// The classes a group of items holds for (None: every class).
fn classes(items: &[&Item]) -> Option<BTreeSet<String>> {
	if items.iter().any(|i| i.classes.is_empty()) {
		return None;
	}
	Some(items.iter().flat_map(|i| i.classes.iter().cloned()).collect())
}

/// `cand` against `base`, key by key (a key met more often is new that many times). A start the
/// previous writer refused has no baseline: only the new writer's own refusal of it is compared.
pub fn compare(base: &[Item], cand: &[Item]) -> Outcome {
	let refused: BTreeSet<(&str, &str)> = base.iter().filter(|i| i.kind == "write").map(|i| (i.set.as_str(), i.start.as_str())).collect();
	let mut out = Outcome::default();
	let mut skipped: BTreeMap<(&str, &str), usize> = BTreeMap::new();
	let cand: Vec<Item> = cand
		.iter()
		.filter(|i| {
			let k = (i.set.as_str(), i.start.as_str());
			let skip = i.kind != "write" && refused.contains(&k);
			if skip {
				*skipped.entry(k).or_default() += 1;
			}
			!skip
		})
		.cloned()
		.collect();
	out.no_baseline = refused.iter().map(|&(s, st)| (s.to_string(), st.to_string(), skipped.get(&(s, st)).copied().unwrap_or(0))).collect();
	let (gb, gc) = (group(base), group(&cand));
	for (k, c) in &gc {
		let b = gb.get(k).map_or(&[][..], Vec::as_slice);
		if c.len() > b.len() {
			out.new.extend(c[b.len()..].iter().map(|i| (*i).clone()));
		}
		if b.is_empty() {
			continue;
		}
		let more: Vec<String> = match (classes(b), classes(c)) {
			(None, _) => Vec::new(),
			(Some(_), None) => vec!["every class".to_string()],
			(Some(bc), Some(cc)) => cc.difference(&bc).cloned().collect(),
		};
		if !more.is_empty() {
			out.spread.push(((*c[0]).clone(), more));
		}
	}
	for (k, b) in &gb {
		let n = gc.get(k).map_or(0, Vec::len);
		if b.len() > n {
			out.gone.extend(b[n..].iter().map(|i| (*i).clone()));
		}
	}
	out
}

/// The gate's report: the verdict and counts first, then what is new, what spread, what went, and the
/// warning counts per rule.
pub fn markdown(sets: &[(String, SetRun, SetRun)], o: &Outcome, labels: (&str, &str)) -> String {
	let mut m = String::new();
	m.push_str(&format!("# Writer gate: {}\n\n", if o.passes() { "PASS" } else { "FAIL" }));
	m.push_str(&format!("Previous writer: {}\nNew writer: {}\n\n", labels.0, labels.1));
	m.push_str("| set | blockers before | after | new | spread | gone | seed new | records new | writer failed |\n|---|---|---|---|---|---|---|---|---|\n");
	for (set, b, c) in sets {
		let n = |v: &[Item], k: &str| v.iter().filter(|i| &i.set == set && i.kind == k).count();
		let cnt = |r: &SetRun| r.items.iter().filter(|i| i.kind == "check").count();
		m.push_str(&format!(
			"| {set} | {} | {} | {} | {} | {} | {} | {} | {} |\n",
			cnt(b),
			cnt(c),
			n(&o.new, "check"),
			o.spread.iter().filter(|(i, _)| &i.set == set).count(),
			o.gone.iter().filter(|i| &i.set == set).count(),
			n(&o.new, "seed"),
			n(&o.new, "records"),
			n(&o.new, "write"),
		));
	}
	let list = |m: &mut String, title: &str, items: &mut dyn Iterator<Item = (&Item, String)>| {
		let mut by: BTreeMap<(String, String), Vec<String>> = BTreeMap::new();
		for (i, extra) in items {
			let cls = if i.classes.is_empty() { String::new() } else { format!(" [{}]", i.classes.join(", ")) };
			by.entry((i.set.clone(), i.start.clone())).or_default().push(format!("- {} {}{cls}{extra}", i.kind, i.text));
		}
		if by.is_empty() {
			return;
		}
		m.push_str(&format!("\n## {title}\n"));
		for ((set, start), v) in by {
			m.push_str(&format!("\n### {set} {start}\n\n{}\n", v.join("\n")));
		}
	};
	list(&mut m, "New (fails the gate)", &mut o.new.iter().map(|i| (i, String::new())));
	list(&mut m, "Met by more classes (fails the gate)", &mut o.spread.iter().map(|(i, more)| (i, format!(" — now also {}", more.join(", ")))));
	list(&mut m, "Gone", &mut o.gone.iter().map(|i| (i, String::new())));
	if !o.no_baseline.is_empty() {
		m.push_str("\n## Not compared: the previous writer refused these starts\n\n");
		for (set, start, n) in &o.no_baseline {
			m.push_str(&format!("- {set} {start}: {n} finding(s) of the new writer left out of the comparison\n"));
		}
	}
	let rules: BTreeSet<&String> = sets.iter().flat_map(|(_, b, c)| b.warns.keys().chain(c.warns.keys())).collect();
	if !rules.is_empty() {
		m.push_str("\n## Warnings (before → after, not gating)\n\n| rule |");
		for (set, ..) in sets {
			m.push_str(&format!(" {set} |"));
		}
		m.push_str(&format!("\n|---|{}\n", "---|".repeat(sets.len())));
		for r in rules {
			m.push_str(&format!("| {r} |"));
			for (_, b, c) in sets {
				let (x, y) = (b.warns.get(r).copied().unwrap_or(0), c.warns.get(r).copied().unwrap_or(0));
				m.push_str(&if x == y { format!(" {x} |") } else { format!(" {x} → {y} |") });
			}
			m.push('\n');
		}
	}
	m
}

#[cfg(test)]
mod tests {
	use super::*;

	fn item(start: &str, key: &str, classes: &[&str]) -> Item {
		Item { set: "c17".into(), start: start.into(), kind: "check", key: key.into(), classes: classes.iter().map(|c| c.to_string()).collect(), text: key.into() }
	}

	#[test]
	fn a_blocker_that_only_moved_lines_keeps_its_key() {
		let a = message_key("back at the place left at horde/04-the-barrens.guide:419 after a trip to horde/04-the-barrens.guide:429-434: nothing done here");
		let b = message_key("back at the place left at horde/04-the-barrens.guide:425 after a trip to horde/04-the-barrens.guide:431-440: nothing done here");
		assert_eq!(a, b);
		assert_eq!(a, "back at the place left at horde/04-the-barrens.guide after a trip to horde/04-the-barrens.guide: nothing done here");
		assert_eq!(
			message_key("Astranaar: fly to Astranaar with no flight master where the guide leaves the player (Ashenvale 26.2,38.7): the nearest learnt one is Auberdine, 3177 yd away"),
			"Astranaar: fly to Astranaar with no flight master where the guide leaves the player (Ashenvale x,y): the nearest learnt one is Auberdine, N yd away"
		);
		assert_eq!(line_key("  goto 40.52,30.1 \"Marshal Dughan\""), "goto x,y \"Marshal Dughan\"");
		// Quest ids and counts stay: another quest is another blocker.
		assert_eq!(message_key("Facing Negolash (618) accepted before it can be"), "Facing Negolash (618) accepted before it can be");
		assert_ne!(line_key("turnin 618"), line_key("turnin 8554"));
	}

	#[test]
	fn new_gone_and_spread() {
		let base = vec![item("Orc", "a", &[]), item("Orc", "b", &["Warlock"]), item("Orc", "c", &[]), item("Human", "d", &["Mage"])];
		let cand = vec![item("Orc", "a", &[]), item("Orc", "a", &[]), item("Orc", "b", &["Warlock", "Mage"]), item("Troll", "c", &[]), item("Human", "d", &[])];
		let o = compare(&base, &cand);
		// A second `a` and Troll's `c` are new; Orc's `c` went; `b` reached Mages, Human's `d` every class.
		assert_eq!(o.new.iter().map(|i| (i.start.as_str(), i.key.as_str())).collect::<Vec<_>>(), [("Orc", "a"), ("Troll", "c")]);
		assert_eq!(o.gone.iter().map(|i| (i.start.as_str(), i.key.as_str())).collect::<Vec<_>>(), [("Orc", "c")]);
		let spread: Vec<(&str, Vec<String>)> = o.spread.iter().map(|(i, m)| (i.key.as_str(), m.clone())).collect();
		assert_eq!(spread, [("d", vec!["every class".to_string()]), ("b", vec!["Mage".to_string()])]);
		assert!(!o.passes());
		assert!(compare(&base, &base).passes());
	}

	#[test]
	fn a_start_the_previous_writer_refused_is_not_compared() {
		let refused = Item { kind: "write", ..item("Orc", "the writer failed", &[]) };
		let base = vec![refused.clone(), item("Troll", "a", &[])];
		let cand = vec![item("Orc", "a", &[]), item("Orc", "b", &[]), item("Troll", "a", &[])];
		let o = compare(&base, &cand);
		// Orc's findings have no baseline; the refusal that went is listed as gone; the gate passes.
		assert!(o.passes(), "{o:?}");
		assert_eq!(o.no_baseline, [("c17".to_string(), "Orc".to_string(), 2)]);
		assert_eq!(o.gone.iter().map(|i| i.kind).collect::<Vec<_>>(), ["write"]);
		// Refused by both: nothing new.
		assert!(compare(&base, &[refused, item("Troll", "a", &[])]).passes());
	}

	#[test]
	fn reads_a_set_folder() {
		let dir = std::env::temp_dir().join(format!("forge-gate-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&dir);
		std::fs::create_dir_all(dir.join("guides/Orc/forever/horde")).unwrap();
		std::fs::write(dir.join("guides/Orc/forever/horde/a.guide"), "step A\n  goto 1.5,2.5 \"Grunt\"\n  turnin 8554\n").unwrap();
		let check = serde_json::json!({
			"starts": [{ "start": "Orc" }],
			"violations": [
				{ "start": "Orc", "file": "horde/a.guide", "line": 3, "rule": "not-ready", "level": "blocker", "message": "Facing Negolash (8554) at horde/a.guide:3" },
				{ "start": "Orc", "file": "horde/a.guide", "line": 2, "rule": "merge", "level": "warn", "message": "m" },
			]
		});
		std::fs::write(dir.join("check.json"), check.to_string()).unwrap();
		std::fs::write(dir.join("guides/Orc.status"), "ok\n").unwrap();
		std::fs::write(dir.join("guides/Orc.log"), "engine: R1 along 3\nfixes: data/places.json quests.940: stale (no line anchors it)\n").unwrap();
		std::fs::write(
			dir.join("guides/Orc.seed.json"),
			serde_json::json!({ "tests": [{ "name": "#171 hearths", "passed": false, "skipped": null, "failures": ["x"] }, { "name": "#2", "passed": true }] }).to_string(),
		)
		.unwrap();
		std::fs::write(dir.join("guides/Troll.status"), "failed: exit 1\n").unwrap();
		let r = read_set(&dir, "c17").unwrap();
		let keys: Vec<(&str, &str, &str)> = r.items.iter().map(|i| (i.start.as_str(), i.kind, i.key.as_str())).collect();
		assert_eq!(
			keys,
			[
				("Orc", "check", "not-ready | horde/a.guide | turnin 8554 | Facing Negolash (8554) at horde/a.guide"),
				("Orc", "records", "data/places.json quests.940: stale"),
				("Orc", "seed", "#171 hearths"),
				("Troll", "write", "the writer failed"),
			]
		);
		assert_eq!(r.warns.get("merge"), Some(&1));
		std::fs::remove_dir_all(&dir).unwrap();
	}
}
