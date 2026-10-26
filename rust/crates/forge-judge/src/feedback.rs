//! `forge judge feedback`: player reports into the route's overrides, every build.
//!
//! Reads data/local/research/RouteFeedback.json (rows mined from GitHub threads: `inputs` of type
//! insert / drop / constraint with a written `spec`) and the GitHub issues labelled `guide` (via `gh api`,
//! cached in a JSON file; offline the cache is used, so the output is the same for the same inputs), and
//! writes route-fixes `overrides` entries the sim reads (data/route-fixes.json; forge-sim order.rs:
//! `include`, `skip`, `revert` and `pairs`, a step before another, the shape of `deliberate.pairs`).
//!
//! Each generated entry carries its source (`F01`, `#647`) and `applied`: true when the sim already
//! honours it (an override line it reads, or a pair already in `deliberate` or `overrides`). Specs the parser does
//! not read (free text: "same visit as", "on the walk", class gates) are listed under `manual` with the
//! reason, never guessed. An issue opts in to a machine entry with a fenced ```route-override block of
//! JSON (`{"include"|"skip"|"pairs": [...]}`); other new issues are listed under `untriaged`.
//!
//! Spec forms read (quests by id; `{a,b}` a set; `task N` the quest's work):
//! - insert: `accept N ... after (accept|turnin|task) M` -> include {q: N, after}; `N ...` alone -> include {q: N}.
//! - drop: `never N` / `N never mandatory` / `N out` -> skip {q: N}.
//! - constraint: a chain `X < Y < Z` of `(accept|turnin|task) N` or `(accept|turnin|task) {N,M}` -> pairs.

use std::collections::BTreeSet;

use regex::Regex;
use serde::Serialize;
use serde_json::{json, Value};

/// One generated override line.
#[derive(Clone, Debug, Serialize, PartialEq)]
pub struct Entry {
	/// `include`, `skip` or `pairs`.
	pub section: String,
	pub line: Value,
	pub source: String,
	pub applied: bool,
}

/// What could not be read into an entry.
#[derive(Clone, Debug, Serialize, PartialEq)]
pub struct Manual {
	pub source: String,
	pub kind: String,
	pub spec: String,
	pub why: String,
}

#[derive(Clone, Debug, Serialize)]
pub struct Output {
	/// The route fixes' `overrides`: the base lines, then the generated ones (each with `source`).
	pub overrides: Value,
	pub entries: Vec<Entry>,
	pub manual: Vec<Manual>,
	/// Issues labelled `guide` that RouteFeedback does not cite and that carry no route-override block.
	pub untriaged: Vec<Value>,
	/// Where the issues came from: `gh`, `cache` (offline or gh failed) or `none`.
	pub issues_from: String,
}

fn step(kind: &str, q: u64) -> Value {
	json!([kind, q])
}

/// `(accept|turnin|task) N` or `... {N,M}` or `... N/M` -> the steps (words after the ids, a comment, ignored).
fn steps_of(s: &str) -> Option<Vec<Value>> {
	let re = Regex::new(r"^\s*(accept|turnin|task|complete)\s+(\{[\d,\s]+\}|\d+(?:/\d+)*)(?:\s|$)").unwrap();
	let m = re.captures(s)?;
	let kind = if &m[1] == "complete" { "task" } else { &m[1] };
	let ids: Vec<u64> = m[2].trim_matches(|c| c == '{' || c == '}').split([',', '/']).filter_map(|x| x.trim().parse().ok()).collect();
	if ids.is_empty() {
		return None;
	}
	Some(ids.into_iter().map(|q| step(kind, q)).collect())
}

/// Split at `sep` outside `{...}` and `(...)`.
fn split_top(s: &str, sep: &str) -> Vec<String> {
	let (mut out, mut cur, mut depth) = (Vec::new(), String::new(), 0i32);
	let mut i = 0;
	let b = s.as_bytes();
	while i < b.len() {
		let c = b[i] as char;
		if c == '{' || c == '(' {
			depth += 1;
		} else if c == '}' || c == ')' {
			depth -= 1;
		}
		if depth == 0 && s[i..].starts_with(sep) {
			out.push(std::mem::take(&mut cur));
			i += sep.len();
			continue;
		}
		cur.push(c);
		i += 1;
	}
	out.push(cur);
	out
}

/// A constraint spec into pairs: every `;`- or `, `-separated part a chain `A < B < C` (a link that is
/// not a step, `grind to 28`, is passed over: A < grind < B still says A < B). A part with fewer than two
/// step links is manual.
fn pairs_of(spec: &str) -> (Vec<(Value, Value)>, Vec<String>) {
	let (mut pairs, mut bad) = (Vec::new(), Vec::new());
	let no_parens = Regex::new(r"\([^)]*\)").unwrap().replace_all(spec, "").into_owned();
	for part in split_top(&no_parens, ";").iter().flat_map(|p| split_top(p, ", ")) {
		let part = part.trim().to_string();
		if part.is_empty() {
			continue;
		}
		let links: Vec<String> = split_top(&part, "<");
		let chain: Vec<Vec<Value>> = links.iter().filter_map(|l| steps_of(l)).collect();
		if links.len() < 2 || chain.len() < 2 {
			bad.push(part);
			continue;
		}
		for w in chain.windows(2) {
			for a in &w[0] {
				for b in &w[1] {
					pairs.push((a.clone(), b.clone()));
				}
			}
		}
	}
	(pairs, bad)
}

/// A pair's key, `kind q < kind q`.
fn pair_key(a: &Value, b: &Value) -> String {
	format!("{} {} < {} {}", a[0].as_str().unwrap_or(""), a[1], b[0].as_str().unwrap_or(""), b[1])
}

/// The overrides from the feedback rows, the issues and the route fixes (`base`: data/route-fixes.json's
/// `overrides`; `deliberate`: its `deliberate`).
pub fn run(feedback: &Value, issues: &[Value], issues_from: &str, base: &Value, deliberate: &Value) -> Output {
	let mut entries: Vec<Entry> = Vec::new();
	let mut manual: Vec<Manual> = Vec::new();
	let have_pairs: BTreeSet<String> = deliberate["pairs"].as_array().into_iter().chain(base["pairs"].as_array()).flatten().map(|p| pair_key(&p["a"], &p["b"])).collect();
	let base_q = |sec: &str| -> BTreeSet<u64> { base[sec].as_array().into_iter().flatten().filter_map(|r| r["q"].as_u64()).collect() };
	let (base_inc, base_skip) = (base_q("include"), base_q("skip"));
	let never: BTreeSet<u64> = deliberate["never"].as_array().into_iter().flatten().filter_map(|r| r.as_u64().or_else(|| r["q"].as_u64())).collect();
	let insert_re = Regex::new(r"^\s*(?:accept\s+)?(\d+)\b(?:.*?\bafter\s+(accept|turnin|task)\s+(\d+))?").unwrap();
	let drop_re = Regex::new(r"(?:\bnever\s+(\d+)\b|^\s*(\d+)\b.*\b(?:never mandatory|out)\b)").unwrap();
	let mut add = |section: &str, line: Value, source: &str, applied: bool| {
		let e = Entry { section: section.into(), line, source: source.into(), applied };
		if !entries.contains(&e) {
			entries.push(e);
		}
	};
	for row in feedback["rows"].as_array().into_iter().flatten() {
		let id = row["id"].as_str().unwrap_or("");
		let refs: Vec<String> = row["refs"].as_array().into_iter().flatten().filter_map(|r| r.as_str().map(str::to_string)).collect();
		let issue = refs.iter().find(|r| r.starts_with('#')).cloned().unwrap_or_default();
		let why = row["why"].as_str().unwrap_or("").to_string();
		for inp in row["inputs"].as_array().into_iter().flatten() {
			let kind = inp["type"].as_str().unwrap_or("");
			let spec = inp["spec"].as_str().unwrap_or("").to_string();
			let man = |manual: &mut Vec<Manual>, w: &str| manual.push(Manual { source: id.into(), kind: kind.into(), spec: spec.clone(), why: w.into() });
			match kind {
				"insert" => match insert_re.captures(&spec).filter(|_| !spec.contains("keep only if") && !spec.contains("optional only")) {
					Some(m) => {
						let q: u64 = m[1].parse().unwrap();
						let mut line = json!({ "q": q, "reason": why, "issue": issue, "source": id });
						if let (Some(k), Some(a)) = (m.get(2), m.get(3)) {
							line["after"] = json!([k.as_str(), a.as_str().parse::<u64>().unwrap()]);
						}
						add("include", line, id, base_inc.contains(&q));
					}
					None => man(&mut manual, "an insert the parser does not read (conditional or free text)"),
				},
				"drop" => {
					// Each `;`-separated part one quest left out.
					let mut any = false;
					for part in spec.split(';') {
						if let Some(m) = drop_re.captures(part) {
							let q: u64 = m.get(1).or(m.get(2)).unwrap().as_str().parse().unwrap();
							add("skip", json!({ "q": q, "reason": why, "issue": issue, "source": id }), id, base_skip.contains(&q) || never.contains(&q));
							any = true;
						}
					}
					if !any {
						man(&mut manual, "a drop the parser does not read");
					}
				}
				"constraint" => {
					let (pairs, bad) = pairs_of(&spec);
					for (a, b) in pairs {
						let k = pair_key(&a, &b);
						add("pairs", json!({ "a": a, "b": b, "why": format!("{id} {issue}: {why}"), "source": id }), id, have_pairs.contains(&k));
					}
					for b in bad {
						manual.push(Manual { source: id.into(), kind: kind.into(), spec: b, why: "not a chain of `accept|turnin|task N` (same visit, along, gates: say it as A < B)".into() });
					}
				}
				_ => {}
			}
		}
	}
	// Issues: a ```route-override block is read as given; issues RouteFeedback cites are covered there.
	let cited: BTreeSet<String> =
		feedback["rows"].as_array().into_iter().flatten().flat_map(|r| r["refs"].as_array().cloned().unwrap_or_default()).filter_map(|r| r.as_str().map(str::to_string)).collect();
	let block = Regex::new(r"(?s)```route-override\s*\n(.*?)```").unwrap();
	let mut untriaged = Vec::new();
	let mut issues: Vec<&Value> = issues.iter().collect();
	issues.sort_by_key(|i| i["number"].as_u64().unwrap_or(0));
	for iss in issues {
		let n = iss["number"].as_u64().unwrap_or(0);
		let src = format!("#{n}");
		let body = iss["body"].as_str().unwrap_or("");
		if let Some(m) = block.captures(body) {
			match serde_json::from_str::<Value>(&m[1]) {
				Ok(doc) => {
					for sec in ["include", "skip", "pairs"] {
						for l in doc[sec].as_array().into_iter().flatten() {
							let mut l = l.clone();
							l["source"] = json!(src);
							if sec != "pairs" {
								l["issue"] = json!(src);
							}
							let applied = match sec {
								"include" => l["q"].as_u64().is_some_and(|q| base_inc.contains(&q)),
								"skip" => l["q"].as_u64().is_some_and(|q| base_skip.contains(&q)),
								_ => have_pairs.contains(&pair_key(&l["a"], &l["b"])),
							};
							add(sec, l, &src, applied);
						}
					}
				}
				Err(e) => manual.push(Manual { source: src.clone(), kind: "issue".into(), spec: m[1].trim().to_string(), why: format!("route-override block is not JSON: {e}") }),
			}
			continue;
		}
		if !cited.contains(&src) {
			untriaged.push(json!({ "number": n, "title": iss["title"], "state": iss["state"], "url": iss["html_url"] }));
		}
	}
	// The document: base lines, then the generated ones not applied yet.
	let mut doc = base.clone();
	for sec in ["include", "skip", "pairs"] {
		let mut list = doc[sec].as_array().cloned().unwrap_or_default();
		for e in entries.iter().filter(|e| e.section == sec && !e.applied) {
			list.push(e.line.clone());
		}
		doc[sec] = Value::Array(list);
	}
	if doc["revert"].is_null() {
		doc["revert"] = json!([]);
	}
	Output { overrides: doc, entries, manual, untriaged, issues_from: issues_from.into() }
}

/// The issues labelled `guide`: from `gh api` (all pages) unless offline, written to `cache`; else the
/// cache; else none. -> (issues, where from).
#[cfg(feature = "native")]
pub fn issues(cache: &std::path::Path, offline: bool) -> (Vec<Value>, String) {
	if !offline {
		let out = std::process::Command::new("gh").args(["api", "--paginate", "--slurp", "repos/fitzforge/polestar/issues?labels=guide&state=all&per_page=100"]).output();
		if let Some(o) = out.ok().filter(|o| o.status.success()) {
			if let Ok(pages) = serde_json::from_slice::<Value>(&o.stdout) {
				// Pull requests come back as issues too: issues only, the fields used here.
				let list: Vec<Value> = pages
					.as_array()
					.into_iter()
					.flatten()
					.flat_map(|p| p.as_array().cloned().unwrap_or_default())
					.filter(|i| i["pull_request"].is_null())
					.map(|i| json!({ "number": i["number"], "title": i["title"], "state": i["state"], "html_url": i["html_url"], "body": i["body"] }))
					.collect();
				if let Some(dir) = cache.parent() {
					let _ = std::fs::create_dir_all(dir);
				}
				let _ = std::fs::write(cache, serde_json::to_string_pretty(&list).unwrap_or_default());
				return (list, "gh".into());
			}
		}
	}
	match std::fs::read(cache).ok().and_then(|b| serde_json::from_slice::<Vec<Value>>(&b).ok()) {
		Some(l) => (l, "cache".into()),
		None => (Vec::new(), "none".into()),
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	fn row(id: &str, inputs: Value) -> Value {
		json!({ "id": id, "refs": ["#647"], "why": "w", "inputs": inputs })
	}

	#[test]
	fn reads_inserts_drops_and_chains() {
		let fb = json!({ "rows": [
			row("F01", json!([{ "type": "insert", "spec": "accept 940 at object 673378 right after turnin 98398" }, { "type": "constraint", "spec": "turnin 940 same visit as turnin 935 (Fandral)" }])),
			row("F06", json!([{ "type": "constraint", "spec": "turnin {306,484} < grind to 28 < accept 1179" }])),
			row("F44", json!([{ "type": "constraint", "spec": "turnin 15 < accept 21 < turnin 91743" }])),
			row("F60", json!([{ "type": "drop", "spec": "never 98299; 98298 out (pre 99 elite)" }])),
			row("F13", json!([{ "type": "insert", "spec": "candidate train class stop in Stormwind; keep only if sim is faster" }])),
		] });
		let delib = json!({ "pairs": [{ "a": ["turnin", 15], "b": ["accept", 21] }], "never": [] });
		let base = json!({ "include": [], "skip": [{ "q": 98299 }], "revert": [] });
		let o = run(&fb, &[], "none", &base, &delib);
		let lines = |sec: &str| o.entries.iter().filter(|e| e.section == sec).map(|e| (e.line.clone(), e.applied)).collect::<Vec<_>>();
		assert_eq!(lines("include").len(), 1);
		assert_eq!(lines("include")[0].0["after"], json!(["turnin", 98398]));
		let pairs: Vec<(String, bool)> = o.entries.iter().filter(|e| e.section == "pairs").map(|e| (pair_key(&e.line["a"], &e.line["b"]), e.applied)).collect();
		assert_eq!(
			pairs,
			vec![("turnin 306 < accept 1179".into(), false), ("turnin 484 < accept 1179".into(), false), ("turnin 15 < accept 21".into(), true), ("accept 21 < turnin 91743".into(), false)]
		);
		// The skip the sim already has is applied; the overrides document gains only the rest.
		assert_eq!(
			lines("skip"),
			vec![(json!({ "q": 98299, "reason": "w", "issue": "#647", "source": "F60" }), true), (json!({ "q": 98298, "reason": "w", "issue": "#647", "source": "F60" }), false)]
		);
		assert_eq!(o.overrides["skip"].as_array().unwrap().len(), 2);
		assert_eq!(o.overrides["pairs"].as_array().unwrap().len(), 3);
		// Free text is manual, never guessed.
		assert!(o.manual.iter().any(|m| m.source == "F01" && m.spec.contains("same visit")));
		assert!(o.manual.iter().any(|m| m.source == "F13"));
	}

	#[test]
	fn chains_with_comments_and_commas() {
		let (p, bad) = pairs_of("turnin 112 < turnin 39/76, accept 59/239 < accept 114 (fill the wait at Dughan)");
		let keys: Vec<String> = p.iter().map(|(a, b)| pair_key(a, b)).collect();
		assert_eq!(keys, vec!["turnin 112 < turnin 39", "turnin 112 < turnin 76", "accept 59 < accept 114", "accept 239 < accept 114"]);
		assert!(bad.is_empty());
		let (p, _) = pairs_of("task 91732 < task 76 < task 91723 (inner geomancers on the way out), one visit");
		assert_eq!(p.len(), 2);
		let (p, bad) = pairs_of("task 151 on the return leg, same visit as turnin 151");
		assert!(p.is_empty() && bad.len() == 2);
	}

	#[test]
	fn issues_with_a_block_are_read_others_untriaged() {
		let fb = json!({ "rows": [row("F01", json!([]))] });
		let issues = vec![
			json!({ "number": 700, "title": "t", "state": "open", "body": "text\n```route-override\n{\"skip\": [{\"q\": 123, \"reason\": \"rare start\"}]}\n```" }),
			json!({ "number": 647, "title": "cited", "state": "closed", "body": "" }),
			json!({ "number": 701, "title": "new", "state": "open", "body": "the arrow is wrong" }),
		];
		let o = run(&fb, &issues, "cache", &json!({}), &json!({}));
		assert_eq!(o.entries.len(), 1);
		assert_eq!(o.entries[0].line["issue"], json!("#700"));
		assert_eq!(o.untriaged.len(), 1);
		assert_eq!(o.untriaged[0]["number"], json!(701));
		// Same inputs, same document.
		let o2 = run(&fb, &issues, "cache", &json!({}), &json!({}));
		assert_eq!(o.overrides, o2.overrides);
	}
}
