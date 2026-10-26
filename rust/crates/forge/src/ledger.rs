//! The fixes ledger: every fix record in the checkout the build applied, and what became of it.
//! Written on every `forge build` (`<out>/fixes.json`, `<out>/fixes.md`, and a "Fixes" section at
//! the end of `report.md`), so a fix that no longer applies is listed instead of silently lost.
//!
//! - **Inputs**: the commit of each folder the build read (the checkout whose fixes it applies,
//!   the guides, the root, the data root), with a warning when they come from different checkouts.
//! - **forever-db/corrections**: per entry, from the data stage: `applied`, `created`, `redundant`
//!   (the merged sources already say the same; it can go), `unused` (matched nothing); per
//!   mechanics fix, whether the build's `mechanics.json` carries it; plus every error
//!   `forge data check-corrections` finds.
//! - **mechanics-public.json**: per entry, whether the build's `mechanics.json` carries it.
//! - **route-fixes.json**: per rule and start, `applied`, `left out` (the start's v1 order breaks
//!   it, so the cut did not keep it) or not for that start (none of its quests are there).
//! - **places.json, guide-fixes.json**: per record and start, from the guides stage's fix pass
//!   (`<guides>/<start>.fixes.json`): `applied`, `redundant` (the written guides already say it),
//!   `stale` (its quest is in the route but no line anchors it), `conflicting`, or not for that start.
//! - **Player-report checks**: the seed tests that pass on v1's guides and fail on a written tree.
//!
//! A *blocking* row is an error, an unused correction, a stale mechanic, a route rule left out, a
//! stale or conflicting place or guide fix, or a player-report check the written guides undo. `forge build --strict` fails on any.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use serde::Serialize;
use serde_json::{json, Value};

/// What the ledger reads.
pub struct Inputs<'a> {
	pub checkout: &'a Path,
	pub guides: &'a Path,
	pub root: &'a Path,
	pub data_root: Option<&'a Path>,
	/// The route fixes file the routes stage used.
	pub route_fixes: &'a Path,
	/// The build's data/forever.
	pub data_dir: &'a Path,
	pub routes_dir: &'a Path,
	/// The guides stage's output: `<start>/` trees and `<start>.fixes.json` (the fix pass's rows).
	pub written: &'a Path,
	/// The data stage's per-correction rows (None: the data was imported, not built).
	pub corrections: Option<&'a Path>,
	pub starts: Vec<String>,
	pub report_json: &'a Path,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Source {
	pub role: &'static str,
	pub path: PathBuf,
	/// The git checkout holding it, its commit and uncommitted changes under it.
	pub checkout: Option<PathBuf>,
	pub commit: Option<String>,
	pub dirty: Vec<String>,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Row {
	/// Where in the file (`quests.940`, `deliberate.pairs[3]`, `mechanics.114`).
	pub at: String,
	pub state: String,
	/// Issue numbers the entry names.
	pub issues: Vec<u32>,
	pub detail: String,
	/// Route rules: the state at each start.
	#[serde(skip_serializing_if = "BTreeMap::is_empty")]
	pub starts: BTreeMap<String, String>,
	pub blocking: bool,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct FileLedger {
	pub file: String,
	pub rows: Vec<Row>,
	/// Why the file was not checked, when it was not.
	pub skipped: Option<String>,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Ledger {
	pub sources: Vec<Source>,
	/// Corrections from the maintainer's private overlay the data build applied (its meta.json
	/// `counts.correctionsPrivate`; 0 in every public build: those never ship in the data pack).
	pub private_corrections: u64,
	pub warnings: Vec<String>,
	pub files: Vec<FileLedger>,
}

impl Ledger {
	/// Rows that fail `--strict`.
	pub fn blocking(&self) -> Vec<(&str, &Row)> {
		self.files.iter().flat_map(|f| f.rows.iter().filter(|r| r.blocking).map(move |r| (f.file.as_str(), r))).collect()
	}

	/// Count of rows per state, over every file.
	pub fn counts(&self) -> BTreeMap<String, usize> {
		let mut c = BTreeMap::new();
		for r in self.files.iter().flat_map(|f| &f.rows) {
			*c.entry(r.state.clone()).or_insert(0) += 1;
		}
		c
	}
}

fn git(dir: &Path, args: &[&str]) -> Option<String> {
	let out = std::process::Command::new("git").arg("-C").arg(dir).args(args).output().ok()?;
	out.status.success().then(|| String::from_utf8_lossy(&out.stdout).trim_end().to_string())
}

/// The git checkout, commit and uncommitted paths of `path` (`paths` under its checkout, or all).
pub fn source(role: &'static str, path: &Path, paths: &[&str]) -> Source {
	let dir = if path.is_dir() { path.to_path_buf() } else { path.parent().map_or_else(|| path.to_path_buf(), Path::to_path_buf) };
	let top = git(&dir, &["rev-parse", "--show-toplevel"]).map(PathBuf::from);
	let commit = top.as_ref().and_then(|t| git(t, &["rev-parse", "--short=12", "HEAD"]));
	let dirty = top
		.as_ref()
		.and_then(|t| {
			let rel: Vec<String> = if paths.is_empty() {
				vec![path.strip_prefix(t).map_or(".".into(), |r| if r.as_os_str().is_empty() { ".".into() } else { r.display().to_string() })]
			} else {
				paths.iter().map(|p| p.to_string()).collect()
			};
			let mut args = vec!["status", "--porcelain", "--"];
			args.extend(rel.iter().map(String::as_str));
			git(t, &args)
		})
		.map(|s| s.lines().map(|l| l.get(3..).unwrap_or(l).to_string()).collect())
		.unwrap_or_default();
	Source { role, path: path.to_path_buf(), checkout: top, commit, dirty }
}

fn issues(text: &str) -> Vec<u32> {
	let mut out: Vec<u32> = Vec::new();
	let b = text.as_bytes();
	let mut i = 0;
	while i < b.len() {
		if b[i] == b'#' {
			let j = b[i + 1..].iter().take_while(|c| c.is_ascii_digit()).count();
			if j > 0 {
				if let Ok(n) = text[i + 1..i + 1 + j].parse() {
					if !out.contains(&n) {
						out.push(n);
					}
				}
			}
			i += j + 1;
		} else {
			i += 1;
		}
	}
	out
}

fn issue_of(e: &Value) -> Vec<u32> {
	let mut v = issues(&[&e["note"], &e["why"], &e["reason"]].iter().filter_map(|x| x.as_str()).collect::<Vec<_>>().join(" "));
	match &e["issue"] {
		Value::Number(n) => v.extend(n.as_u64().map(|n| n as u32)),
		Value::String(s) => v.extend(issues(s).into_iter().chain(s.parse().ok())),
		_ => {}
	}
	v.dedup();
	v
}

fn row(at: String, state: &str, issues: Vec<u32>, detail: String, blocking: bool) -> Row {
	Row { at, state: state.into(), issues, detail, starts: BTreeMap::new(), blocking }
}

fn read_json(p: &Path) -> Option<Value> {
	serde_json::from_slice(&std::fs::read(p).ok()?).ok()
}

/// forever-db/corrections: the data stage's rows, the mechanics fixes the build's mechanics.json
/// carries, the entries' issues, and check-corrections' errors.
fn corrections(inp: &Inputs, dir: &Path, findings: &[forge_data::corrections::Finding]) -> FileLedger {
	let label = forge_data::corrections::DIR.to_string();
	let doc = forge_data::corrections::read_text(dir).ok().and_then(|t| serde_json::from_str::<Value>(&t).ok()).unwrap_or(Value::Null);
	let mut rows = Vec::new();
	let skipped = match inp.corrections.and_then(read_json) {
		None => Some("the data was imported (--data), not built: what each correction did is not known".to_string()),
		Some(Value::Array(list)) => {
			for e in list {
				let (sec, id, state) = (e["section"].as_str().unwrap_or(""), e["id"].as_str().unwrap_or(""), e["state"].as_str().unwrap_or(""));
				let at = format!("{sec}.{id}");
				let entry = &doc[sec][id];
				rows.push(row(at, state, issue_of(entry), e["detail"].as_str().unwrap_or("").into(), state == "unused"));
			}
			None
		}
		Some(_) => Some("the data stage's rows are unreadable".into()),
	};
	rows.extend(mechanics_fixes(inp, &doc["mechanics"]));
	for f in findings.iter().filter(|f| f.severity == "error" && f.file == label) {
		let entry = f.at.split('.').take(2).collect::<Vec<_>>().join(".");
		match rows.iter_mut().find(|r| r.at == entry) {
			Some(r) => {
				r.state = "error".into();
				r.detail = format!("{}: {}", f.at, f.message);
				r.blocking = true;
			}
			None => rows.push(row(f.at.clone(), "error", Vec::new(), f.message.clone(), true)),
		}
	}
	FileLedger { file: label, rows, skipped }
}

const MECH_STALE: &str = "not in the build's mechanics.json: rebuild the knowledge base (forge data build --kb)";

/// The corrections' mechanics fixes: whether the build's mechanics.json carries each.
fn mechanics_fixes(inp: &Inputs, fixes: &Value) -> Vec<Row> {
	let built = read_json(&inp.data_dir.join("mechanics.json"));
	let mut rows = Vec::new();
	for (id, e) in fixes.as_object().into_iter().flatten() {
		let q = built.as_ref().map(|b| &b["quests"][id]);
		let params_in = e["params"]
			.as_array()
			.into_iter()
			.flatten()
			.all(|p| q.and_then(|q| q["params"].as_array()).is_some_and(|have| have.iter().any(|h| h["kind"] == p["kind"] && h["item"] == p["item"] && h["source"] == "correction")));
		let steps_in = e["steps"].as_object().into_iter().flatten().all(|(n, st)| {
			q.and_then(|q| q["steps"].as_array())
				.is_some_and(|have| have.iter().any(|h| h["n"].as_u64().map(|x| x.to_string()).as_deref() == Some(n) && st["set"].as_object().into_iter().flatten().all(|(k, v)| &h[k] == v)))
		});
		let (state, detail) = match built {
			None => ("not checked", "the build has no mechanics.json".to_string()),
			Some(_) if params_in && steps_in => ("applied", String::new()),
			Some(_) => ("stale", MECH_STALE.to_string()),
		};
		rows.push(row(format!("mechanics.{id}"), state, issue_of(e), detail, state == "stale"));
	}
	rows
}

/// mechanics-public.json: whether the build's mechanics.json carries each entry.
fn mechanics(inp: &Inputs, file: &Path) -> FileLedger {
	let label = "data/mechanics-public.json".to_string();
	let Some(doc) = read_json(file) else { return FileLedger { file: label, rows: Vec::new(), skipped: Some("no such file".into()) } };
	let built = read_json(&inp.data_dir.join("mechanics.json"));
	let mut rows = Vec::new();
	let stale = MECH_STALE;
	for (id, e) in doc["quests"].as_object().into_iter().flatten() {
		let q = built.as_ref().map(|b| &b["quests"][id]);
		let kinds_in =
			e["kinds"].as_array().into_iter().flatten().all(|k| {
				q.and_then(|q| q["kinds"].as_array()).is_some_and(|have| have.iter().any(|h| h["kind"] == k["kind"] && h["sources"].as_array().is_some_and(|s| s.iter().any(|x| x == "public"))))
			});
		let (state, detail) = match built {
			None => ("not checked", "the build has no mechanics.json".to_string()),
			Some(_) if kinds_in => ("applied", String::new()),
			Some(_) => ("stale", format!("{stale}; or the server's data refutes a kind")),
		};
		rows.push(row(format!("quests.{id}"), state, issue_of(e), detail, state == "stale"));
	}
	FileLedger { file: label, rows, skipped: None }
}

/// A step `[kind, quest, ...]` as (kind, quest).
fn step(v: &Value) -> Option<(&str, u64)> {
	Some((v.get(0)?.as_str()?, v.get(1)?.as_u64()?))
}

/// One route rule: where it is, the quests it names, and how a "left out" note names it.
struct Rule<'a> {
	at: String,
	entry: &'a Value,
	quests: Vec<u64>,
	/// A substring of the routes stage's note when v1's order breaks the rule.
	left_out: Option<String>,
}

fn route_rules(doc: &Value) -> Vec<Rule<'_>> {
	let mut out = Vec::new();
	let d = &doc["deliberate"];
	let o = &doc["overrides"];
	for (sec, base) in [("pairs", d), ("together", d), ("after", d)] {
		for (i, e) in base[sec].as_array().into_iter().flatten().enumerate() {
			let (a, b) = (step(&e["a"]), step(&e["b"]));
			let quests = a.iter().chain(b.iter()).map(|x| x.1).collect();
			let left_out = match (sec, a, b) {
				("pairs", Some(a), Some(b)) => Some(format!("v1 breaks deliberate pair: {} {} before {} {}: left out", a.0, a.1, b.0, b.1)),
				("together", Some(a), Some(b)) => Some(format!("v1 breaks together {} {}: left out", a.1, b.1)),
				("after", _, _) => e["why"].as_str().filter(|w| !w.is_empty()).map(|w| format!("({w}): left out")),
				_ => None,
			};
			out.push(Rule { at: format!("deliberate.{sec}[{i}]"), entry: e, quests, left_out });
		}
	}
	for (i, e) in d["stay"].as_array().into_iter().flatten().enumerate() {
		out.push(Rule {
			at: format!("deliberate.stay[{i}]"),
			entry: e,
			quests: step(&e["s"]).map(|x| x.1).into_iter().collect(),
			left_out: e["why"].as_str().filter(|w| !w.is_empty()).map(|w| format!("({w}): left out")),
		});
	}
	for (i, e) in d["southward"].as_array().into_iter().flatten().enumerate() {
		let q = step(&e["until"]).map(|x| x.1);
		out.push(Rule { at: format!("deliberate.southward[{i}]"), entry: e, quests: q.into_iter().collect(), left_out: q.map(|q| format!("v1 breaks the southward rule before {q}: left out")) });
	}
	for sec in ["keep", "never", "optional"] {
		for (i, e) in d[sec].as_array().into_iter().flatten().enumerate() {
			out.push(Rule { at: format!("deliberate.{sec}[{i}]"), entry: e, quests: e["q"].as_u64().into_iter().collect(), left_out: None });
		}
	}
	for sec in ["include", "skip"] {
		for (i, e) in o[sec].as_array().into_iter().flatten().enumerate() {
			out.push(Rule { at: format!("overrides.{sec}[{i}]"), entry: e, quests: e["q"].as_u64().into_iter().collect(), left_out: None });
		}
	}
	for (i, e) in o["revert"].as_array().into_iter().flatten().enumerate() {
		let q = e["q"].as_u64().or_else(|| step(&e["s"]).map(|x| x.1));
		out.push(Rule { at: format!("overrides.revert[{i}]"), entry: e, quests: q.into_iter().collect(), left_out: None });
	}
	for (i, e) in o["pairs"].as_array().into_iter().flatten().enumerate() {
		let (a, b) = (step(&e["a"]), step(&e["b"]));
		let left_out = a.zip(b).map(|(a, b)| format!("v1 breaks deliberate pair: {} {} before {} {}: left out", a.0, a.1, b.0, b.1));
		out.push(Rule { at: format!("overrides.pairs[{i}]"), entry: e, quests: a.iter().chain(b.iter()).map(|x| x.1).collect(), left_out });
	}
	out
}

/// route-fixes.json: each rule at each start, from the start's route (its quests and the notes
/// naming the rules its v1 order breaks).
fn route_fixes(inp: &Inputs) -> FileLedger {
	let label = inp.route_fixes.strip_prefix(inp.checkout).map_or_else(|_| inp.route_fixes.display().to_string(), |p| p.display().to_string());
	let Some(doc) = read_json(inp.route_fixes) else { return FileLedger { file: label, rows: Vec::new(), skipped: Some("unreadable".into()) } };
	// Per start: the quests it can do (in its route or its skip ledger), and its notes.
	let mut starts: Vec<(String, std::collections::HashSet<u64>, Vec<String>)> = Vec::new();
	for s in &inp.starts {
		let Some(r) = read_json(&inp.routes_dir.join(format!("{s}.json"))) else { continue };
		let mut qs: std::collections::HashSet<u64> = r["order"].as_array().into_iter().flatten().filter_map(|e| e["q"].as_u64()).collect();
		if let Some(sk) = read_json(&inp.routes_dir.join(format!("{s}.skips.json"))) {
			let list = sk.as_array().cloned().or_else(|| sk["skips"].as_array().cloned()).unwrap_or_default();
			qs.extend(list.iter().filter_map(|e| e["q"].as_u64()));
		}
		let notes = r["feasibility"].as_array().into_iter().flatten().filter_map(|e| e["note"].as_str().map(String::from)).collect();
		starts.push((s.clone(), qs, notes));
	}
	if starts.is_empty() {
		return FileLedger { file: label, rows: Vec::new(), skipped: Some("no routes were cut".into()) };
	}
	let mut rows = Vec::new();
	for rule in route_rules(&doc) {
		let mut per = BTreeMap::new();
		for (s, qs, notes) in &starts {
			let here = rule.quests.iter().any(|q| qs.contains(q));
			let broken = rule.left_out.as_ref().is_some_and(|l| notes.iter().any(|n| n.contains(l.as_str())));
			per.insert(
				s.clone(),
				if broken {
					"left out"
				} else if here {
					"applied"
				} else {
					"not for this start"
				}
				.to_string(),
			);
		}
		let left: Vec<&String> = per.iter().filter(|(_, v)| *v == "left out").map(|(k, _)| k).collect();
		let state = if !left.is_empty() {
			"left out"
		} else if per.values().any(|v| v == "applied") {
			"applied"
		} else {
			"not for these starts"
		};
		let detail =
			if left.is_empty() { String::new() } else { format!("v1's order breaks it at {}: the cut does not keep it there", left.iter().map(|s| s.as_str()).collect::<Vec<_>>().join(", ")) };
		let mut r = row(rule.at, state, issue_of(rule.entry), detail, state == "left out");
		r.starts = per;
		rows.push(r);
	}
	FileLedger { file: label, rows, skipped: None }
}

/// places.json or guide-fixes.json: each record at each start, from the fix pass's rows.
fn records(inp: &Inputs, file: &Path, kind: &str, list_key: &str) -> FileLedger {
	let label = file.strip_prefix(inp.checkout).map_or_else(|_| file.display().to_string(), |p| p.display().to_string());
	let Some(doc) = read_json(file) else { return FileLedger { file: label, rows: Vec::new(), skipped: Some("absent".into()) } };
	let per_start: Vec<(String, Vec<Value>)> =
		inp.starts.iter().filter_map(|s| read_json(&inp.written.join(format!("{s}.fixes.json"))).map(|v| (s.clone(), v.as_array().cloned().unwrap_or_default()))).collect();
	if per_start.is_empty() {
		return FileLedger { file: label, rows: Vec::new(), skipped: Some("no guides were written".into()) };
	}
	let rank = |s: &str| match s {
		"conflicting" => 5,
		"stale" => 4,
		"applied" => 3,
		"redundant" => 2,
		_ => 1,
	};
	let mut rows = Vec::new();
	for (i, r) in doc[list_key].as_array().into_iter().flatten().enumerate() {
		let id = r["id"].as_str().unwrap_or("").to_string();
		let mut per = BTreeMap::new();
		let mut details = Vec::new();
		for (s, list) in &per_start {
			let Some(x) = list.iter().find(|x| x["file"] == kind && x["id"] == id.as_str()) else { continue };
			let st = x["state"].as_str().unwrap_or("").to_string();
			if matches!(st.as_str(), "stale" | "conflicting") {
				details.push(format!("{s}: {}", x["detail"].as_str().unwrap_or("")));
			}
			if st == "applied" || st == "redundant" {
				let at: Vec<&str> = x["lines"].as_array().into_iter().flatten().filter_map(Value::as_str).collect();
				if details.is_empty() && !at.is_empty() {
					details.push(at.join(", "));
				}
			}
			per.insert(s.clone(), st);
		}
		let state = per.values().max_by_key(|s| rank(s)).map_or("not for these starts".to_string(), |s| if s == "not for this start" { "not for these starts".into() } else { s.clone() });
		let blocking = matches!(state.as_str(), "stale" | "conflicting");
		let mut row = row(if id.is_empty() { format!("{list_key}[{i}]") } else { id }, &state, issue_of(r), details.join("; "), blocking);
		row.starts = per;
		rows.push(row);
	}
	FileLedger { file: label, rows, skipped: None }
}

/// The player-report checks (seed tests) that pass on v1's guides and fail on a written tree.
fn checks(inp: &Inputs) -> FileLedger {
	let label = "player-report checks (forge judge seed-tests)".to_string();
	let Some(r) = read_json(inp.report_json) else { return FileLedger { file: label, rows: Vec::new(), skipped: Some("no report.json".into()) } };
	let v1_failed: Vec<&str> = r["v1Checks"]["failed"].as_array().into_iter().flatten().filter_map(Value::as_str).collect();
	let mut undone: BTreeMap<String, Vec<String>> = BTreeMap::new();
	let mut any = false;
	for s in r["starts"].as_array().into_iter().flatten() {
		let Some(c) = s["checks"].as_object() else { continue };
		any = true;
		let name = s["route"].as_str().and_then(|p| Path::new(p).file_stem()).map(|x| x.to_string_lossy().into_owned()).unwrap_or_default();
		for f in c.get("failed").and_then(Value::as_array).into_iter().flatten().filter_map(Value::as_str) {
			if !v1_failed.contains(&f) {
				undone.entry(f.to_string()).or_default().push(name.clone());
			}
		}
	}
	if !any {
		return FileLedger { file: label, rows: Vec::new(), skipped: Some("the report ran no checks".into()) };
	}
	let rows = undone
		.into_iter()
		.map(|(test, starts)| {
			let mut r = row(test.clone(), "undone", issues(&test), format!("passes on v1's guides, fails on the written guides of {}", starts.join(", ")), true);
			r.starts = starts.into_iter().map(|s| (s, "fails".to_string())).collect();
			r
		})
		.collect();
	FileLedger { file: label, rows, skipped: None }
}

/// The whole ledger.
pub fn run(inp: &Inputs) -> Ledger {
	let record_files = [forge_data::corrections::DIR, "data/mechanics-public.json", "data/route-fixes.json", "data/places.json", "data/guide-fixes.json"];
	let mut sources = vec![source("checkout", inp.checkout, &record_files), source("guides", inp.guides, &[])];
	if inp.root != inp.checkout {
		sources.push(source("root", inp.root, &[]));
	}
	if let Some(d) = inp.data_root.filter(|d| *d != inp.checkout && *d != inp.root) {
		sources.push(source("data root", d, &[]));
	}
	let mut warnings = Vec::new();
	let ck = &sources[0];
	if ck.checkout.is_none() {
		warnings.push(format!("the checkout {} is not a git checkout: the fixes' commit is unknown", inp.checkout.display()));
	}
	for s in &sources[1..] {
		if s.checkout.is_some() && s.checkout != ck.checkout {
			warnings.push(format!(
				"the {} come from {} at {}, the fixes from {} at {}: a fix merged into one and not the other is missing from this build",
				if s.role == "guides" { "guides".to_string() } else { format!("{}'s files", s.role) },
				s.checkout.as_ref().map_or(String::new(), |p| p.display().to_string()),
				s.commit.as_deref().unwrap_or("?"),
				ck.checkout.as_ref().map_or(String::new(), |p| p.display().to_string()),
				ck.commit.as_deref().unwrap_or("?"),
			));
		}
	}
	for s in &sources {
		if !s.dirty.is_empty() {
			let more = if s.dirty.len() > 5 { format!(" and {} more", s.dirty.len() - 5) } else { String::new() };
			warnings.push(format!(
				"uncommitted changes in the {} ({}): {}{more}",
				s.role,
				s.checkout.as_ref().map_or(String::new(), |p| p.display().to_string()),
				s.dirty[..s.dirty.len().min(5)].join(", ")
			));
		}
	}
	let corrections_dir = forge_data::corrections::locate(inp.checkout);
	let mechanics_file = inp.checkout.join("data/mechanics-public.json");
	let text = |p: &Path| std::fs::read_to_string(p).ok();
	let (places_file, guide_fixes_file) = (inp.checkout.join(forge_writer::native::PLACES), inp.checkout.join(forge_writer::native::GUIDE_FIXES));
	let (ct, mt, rt, pt, gt) = (forge_data::corrections::read_text(&corrections_dir).ok(), text(&mechanics_file), text(inp.route_fixes), text(&places_file), text(&guide_fixes_file));
	let tables = forge_data::corrections::Tables::load(inp.data_dir).unwrap_or(None);
	let rlabel = "data/route-fixes.json";
	let findings = forge_data::corrections::check(&forge_data::corrections::CheckInputs {
		corrections: ct.as_deref().map(|t| (forge_data::corrections::DIR, t)),
		mechanics: mt.as_deref().map(|t| ("data/mechanics-public.json", t)),
		route_fixes: rt.as_deref().map(|t| (rlabel, t)),
		places: pt.as_deref().map(|t| (forge_writer::native::PLACES, t)),
		guide_fixes: gt.as_deref().map(|t| (forge_writer::native::GUIDE_FIXES, t)),
		data: tables.as_ref(),
	});
	let mut files = vec![corrections(inp, &corrections_dir, &findings), mechanics(inp, &mechanics_file)];
	let mut rf = route_fixes(inp);
	let mut pl = records(inp, &places_file, "places", "places");
	let mut gf = records(inp, &guide_fixes_file, "guide-fixes", "fixes");
	for f in findings.iter().filter(|f| f.severity == "error" && f.file != forge_data::corrections::DIR) {
		let target = if f.file == rlabel {
			&mut rf
		} else if f.file == forge_writer::native::PLACES {
			&mut pl
		} else if f.file == forge_writer::native::GUIDE_FIXES {
			&mut gf
		} else {
			&mut files[1]
		};
		match target.rows.iter_mut().find(|r| f.at.starts_with(&r.at)) {
			Some(r) => {
				r.state = "error".into();
				r.detail = format!("{}: {}", f.at, f.message);
				r.blocking = true;
			}
			None => target.rows.push(row(f.at.clone(), "error", Vec::new(), f.message.clone(), true)),
		}
	}
	files.push(rf);
	files.push(pl);
	files.push(gf);
	files.push(checks(inp));
	let private_corrections = read_json(&inp.data_dir.join("meta.json")).and_then(|m| m["counts"]["correctionsPrivate"].as_u64()).unwrap_or(0);
	Ledger { sources, private_corrections, warnings, files }
}

/// The ledger as markdown: inputs, warnings, counts, then every row that is not plainly applied.
pub fn markdown(l: &Ledger) -> String {
	let mut s = String::from("## Fixes\n\nEvery fix record in the checkout, and what this build did with it (`fixes.json` has every row).\n\n");
	s.push_str("| Input | Checkout | Commit | Uncommitted |\n|---|---|---|---|\n");
	for x in &l.sources {
		s.push_str(&format!(
			"| {} | {} | {} | {} |\n",
			x.role,
			x.checkout.as_ref().map_or_else(|| format!("{} (not git)", x.path.display()), |p| p.display().to_string()),
			x.commit.as_deref().unwrap_or("-"),
			if x.dirty.is_empty() { "-".to_string() } else { x.dirty.len().to_string() }
		));
	}
	s.push_str(&if l.private_corrections == 0 {
		"\nPrivate corrections: none (a public build; the maintainer's release build adds its private overlay).\n".to_string()
	} else {
		format!("\nPrivate corrections: {} applied from the maintainer's overlay (never in the data pack).\n", l.private_corrections)
	});
	for w in &l.warnings {
		s.push_str(&format!("\n**Warning:** {w}\n"));
	}
	s.push('\n');
	for f in &l.files {
		if let Some(why) = &f.skipped {
			s.push_str(&format!("**{}**: not checked ({why}).\n\n", f.file));
			continue;
		}
		let mut counts: BTreeMap<&str, usize> = BTreeMap::new();
		for r in &f.rows {
			*counts.entry(r.state.as_str()).or_insert(0) += 1;
		}
		let c = counts.iter().map(|(k, v)| format!("{v} {k}")).collect::<Vec<_>>().join(", ");
		s.push_str(&format!("**{}**: {}.\n\n", f.file, if c.is_empty() { "nothing to check".into() } else { c }));
		let shown: Vec<&Row> = f.rows.iter().filter(|r| r.blocking || r.state == "redundant").collect();
		if !shown.is_empty() {
			s.push_str("| Entry | State | Issues | Detail |\n|---|---|---|---|\n");
			for r in shown {
				let iss = r.issues.iter().map(|n| format!("#{n}")).collect::<Vec<_>>().join(" ");
				s.push_str(&format!("| {} | {} | {} | {} |\n", r.at.replace('|', "\\|"), r.state, iss, r.detail.replace('|', "\\|")));
			}
			s.push('\n');
		}
	}
	let b = l.blocking().len();
	s.push_str(&if b == 0 {
		"No fix is stale, in conflict or undone.\n".to_string()
	} else {
		format!("**{b} fix(es) no longer apply** (rows above with state error, unused, stale, left out or undone): `forge build --strict` fails on them.\n")
	});
	s
}

/// Writes fixes.json and fixes.md, and replaces the Fixes section at the end of report.md.
pub fn write(l: &Ledger, out: &Path) -> Result<(), String> {
	let md = markdown(l);
	let body = json!({ "sources": l.sources, "privateCorrections": l.private_corrections, "warnings": l.warnings, "counts": l.counts(), "blocking": l.blocking().len(), "files": l.files });
	std::fs::write(out.join("fixes.json"), serde_json::to_string_pretty(&body).map_err(|e| e.to_string())? + "\n").map_err(|e| format!("fixes.json: {e}"))?;
	std::fs::write(out.join("fixes.md"), &md).map_err(|e| format!("fixes.md: {e}"))?;
	let report = out.join("report.md");
	if let Ok(r) = std::fs::read_to_string(&report) {
		let head = r.find("\n## Fixes\n").map_or(r.as_str(), |i| &r[..i]);
		std::fs::write(&report, format!("{}\n\n{md}", head.trim_end())).map_err(|e| format!("report.md: {e}"))?;
	}
	Ok(())
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn issues_are_read_from_text() {
		assert_eq!(issues("Pynte #416 and (#229, #161), not #x"), vec![416, 229, 161]);
		assert_eq!(issue_of(&json!({ "reason": "r", "issue": "#457" })), vec![457]);
		assert_eq!(issue_of(&json!({ "why": "Tom's report", "issue": 647 })), vec![647]);
	}

	#[test]
	fn a_rule_v1_breaks_at_a_start_is_left_out_there() {
		let dir = std::env::temp_dir().join(format!("forge-ledger-{}", std::process::id()));
		let routes = dir.join("routes");
		std::fs::create_dir_all(&routes).unwrap();
		let fixes = dir.join("route-fixes.json");
		std::fs::write(
			&fixes,
			json!({ "deliberate": { "pairs": [
				{ "a": ["turnin", 788], "b": ["task", 790], "why": "Tom #1" },
				{ "a": ["accept", 10], "b": ["task", 11], "why": "elsewhere" },
				{ "a": ["accept", 20], "b": ["task", 21], "why": "Pynte #416" } ] },
				"overrides": { "skip": [{ "q": 30, "reason": "not offered", "issue": 229 }] } })
			.to_string(),
		)
		.unwrap();
		std::fs::write(
			routes.join("Orc.json"),
			json!({ "order": [{ "q": 788 }, { "q": 790 }, { "q": 20 }, { "q": 21 }], "feasibility": [{ "note": "v1 breaks deliberate pair: accept 20 before task 21: left out" }] }).to_string(),
		)
		.unwrap();
		std::fs::write(routes.join("Orc.skips.json"), json!([{ "q": 30 }]).to_string()).unwrap();
		let inp = Inputs {
			checkout: &dir,
			guides: &dir,
			root: &dir,
			data_root: None,
			route_fixes: &fixes,
			data_dir: &dir,
			routes_dir: &routes,
			written: &dir,
			corrections: None,
			starts: vec!["Orc".into()],
			report_json: &dir.join("report.json"),
		};
		let f = route_fixes(&inp);
		let st = |at: &str| f.rows.iter().find(|r| r.at == at).map(|r| (r.state.clone(), r.blocking)).unwrap();
		assert_eq!(st("deliberate.pairs[0]"), ("applied".into(), false));
		assert_eq!(st("deliberate.pairs[1]"), ("not for these starts".into(), false));
		assert_eq!(st("deliberate.pairs[2]"), ("left out".into(), true));
		assert_eq!(st("overrides.skip[0]"), ("applied".into(), false));
		assert_eq!(f.rows.iter().find(|r| r.at == "deliberate.pairs[2]").unwrap().issues, vec![416]);
		std::fs::remove_dir_all(&dir).unwrap();
	}

	#[test]
	fn places_take_the_worst_state_over_the_starts() {
		let dir = std::env::temp_dir().join(format!("forge-ledger-places-{}", std::process::id()));
		let written = dir.join("guides");
		std::fs::create_dir_all(dir.join("data")).unwrap();
		std::fs::create_dir_all(&written).unwrap();
		let places = dir.join("data/places.json");
		std::fs::write(&places, json!({ "places": [{ "id": "a", "issue": 646 }, { "id": "b" }, { "id": "c" }] }).to_string()).unwrap();
		let row = |id: &str, state: &str| json!({ "file": "places", "id": id, "state": state, "detail": "d", "issues": [], "lines": ["forever/x.guide:3"] });
		std::fs::write(written.join("Orc.fixes.json"), json!([row("a", "applied"), row("b", "not for this start"), row("c", "redundant")]).to_string()).unwrap();
		std::fs::write(written.join("Human.fixes.json"), json!([row("a", "redundant"), row("b", "not for this start"), row("c", "stale")]).to_string()).unwrap();
		let inp = Inputs {
			checkout: &dir,
			guides: &dir,
			root: &dir,
			data_root: None,
			route_fixes: &dir.join("none.json"),
			data_dir: &dir,
			routes_dir: &dir,
			written: &written,
			corrections: None,
			starts: vec!["Orc".into(), "Human".into()],
			report_json: &dir.join("report.json"),
		};
		let f = records(&inp, &places, "places", "places");
		let st: Vec<(&str, &str, bool)> = f.rows.iter().map(|r| (r.at.as_str(), r.state.as_str(), r.blocking)).collect();
		assert_eq!(st, [("a", "applied", false), ("b", "not for these starts", false), ("c", "stale", true)]);
		assert_eq!(f.rows[0].issues, vec![646]);
		std::fs::remove_dir_all(&dir).unwrap();
	}
}
