//! Native entry points: the knowledge base from SQLite, and a pack folder played as `playtest --honest`
//! plays our own pack (tools/lib/playtest.js playtest({ official: true, honest: true })).

use super::{arriving, honest_play, kb_from_rows, personas, Finding, HonestOpts, Kb, KbStep, Persona};
use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::project::{compile_sources, find_guide_files, CompileOpts, Source};
use std::path::Path;

/// loadKb: `steps where drives = 1 and n is not null order by quest, n` from `file`; None when the file
/// is not there.
pub fn load_kb(file: &Path) -> Result<Option<Kb>, String> {
	if !file.exists() {
		return Ok(None);
	}
	let db = rusqlite::Connection::open_with_flags(file, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(|e| format!("{}: {e}", file.display()))?;
	let mut st =
		db.prepare("select quest, n, action, target_kind, target, item, fact from steps where drives = 1 and n is not null order by quest, n").map_err(|e| format!("{}: {e}", file.display()))?;
	let rows = st
		.query_map([], |r| {
			Ok((r.get::<_, i64>(0)?, KbStep { n: r.get(1)?, action: r.get::<_, Option<String>>(2)?.unwrap_or_default(), kind: r.get(3)?, target: r.get(4)?, item: r.get(5)?, fact: r.get(6)? }))
		})
		.map_err(|e| format!("{}: {e}", file.display()))?;
	let mut list = Vec::new();
	for r in rows {
		list.push(r.map_err(|e| format!("{}: {e}", file.display()))?);
	}
	Ok(Some(kb_from_rows(list)))
}

/// Which guides and characters a pack run plays.
#[derive(Clone, Debug, Default)]
pub struct PackRun {
	/// Guides whose path or id contains this (playtest `--filter`); None: all.
	pub filter: Option<String>,
	/// Only personas of this faction ("Horde", "Alliance").
	pub faction: Option<String>,
	/// Only personas of this race (file or label: "Orc", "Undead", "NightElf").
	pub race: Option<String>,
	/// The classes to play instead of each guide's own choice (playtest `--class`).
	pub classes: Option<Vec<String>>,
}

pub struct PackResult {
	pub findings: Vec<Finding>,
	/// Guides played (the filter's).
	pub played: usize,
}

/// headerLinks: the guide id (`guide <id>`) and `next` ids of a .guide text.
fn header_links(text: &str) -> (Option<String>, Vec<String>) {
	let mut id = None;
	let mut next = Vec::new();
	let mut got_next = false;
	for line in text.split('\n') {
		let line = line.strip_suffix('\r').unwrap_or(line);
		if id.is_none() {
			if let Some(rest) = line.strip_prefix("guide") {
				if rest.starts_with(char::is_whitespace) {
					id = rest.split_whitespace().next().map(str::to_string);
				}
			}
		}
		if !got_next {
			if let Some(rest) = line.strip_prefix("next") {
				if rest.starts_with(char::is_whitespace) && !rest.trim().is_empty() {
					got_next = true;
					next = rest.split(|c: char| c.is_whitespace() || c == ',').filter(|s| !s.is_empty()).map(str::to_string).collect();
				}
			}
		}
	}
	(id, next)
}

/// withChain: every file connected to a target through `next` (either way), the targets included, sorted.
fn with_chain(texts: &[(String, String)], targets: &[String]) -> Vec<String> {
	use rustc_hash::{FxHashMap, FxHashSet};
	let mut id_of: FxHashMap<&str, Option<String>> = FxHashMap::default();
	let mut file_of: FxHashMap<String, &str> = FxHashMap::default();
	let mut next_of: FxHashMap<&str, Vec<String>> = FxHashMap::default();
	let mut into: FxHashMap<String, Vec<&str>> = FxHashMap::default();
	for (rel, text) in texts {
		let (id, next) = header_links(text);
		if let Some(id) = &id {
			file_of.insert(id.clone(), rel);
		}
		for n in &next {
			into.entry(n.clone()).or_default().push(rel);
		}
		id_of.insert(rel, id);
		next_of.insert(rel, next);
	}
	let mut set: FxHashSet<String> = targets.iter().cloned().collect();
	let mut queue: Vec<String> = targets.to_vec();
	while let Some(rel) = queue.pop() {
		let mut linked: Vec<&str> = id_of.get(rel.as_str()).and_then(|i| i.as_ref()).and_then(|i| into.get(i)).cloned().unwrap_or_default();
		for n in next_of.get(rel.as_str()).map(Vec::as_slice).unwrap_or(&[]) {
			if let Some(f) = file_of.get(n) {
				linked.push(f);
			}
		}
		for o in linked {
			if set.insert(o.to_string()) {
				queue.push(o.to_string());
			}
		}
	}
	let mut out: Vec<String> = set.into_iter().collect();
	out.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
	out
}

fn race_file(r: &str) -> String {
	match r {
		"Undead" => "Scourge".into(),
		"Night Elf" => "NightElf".into(),
		r => r.into(),
	}
}

/// `playtest <pack dir> --honest [--filter f]` on a pack folder of ours, limited to a faction and race:
/// compile the filter's guides with their `next` chain, then play every chain holding one of them.
pub fn play_pack(pack_dir: &Path, data: &Data, kb: Option<&Kb>, run: &PackRun, opts: &HonestOpts) -> Result<PackResult, String> {
	let all = find_guide_files(pack_dir, false);
	let texts: Vec<(String, String)> = all.iter().map(|rel| (rel.clone(), std::fs::read_to_string(pack_dir.join(rel)).unwrap_or_default())).collect();
	let wanted: Vec<String> = texts
		.iter()
		.filter(|(rel, text)| match &run.filter {
			None => true,
			Some(f) => rel.contains(f.as_str()) || header_links(text).0.is_some_and(|id| id.contains(f.as_str())),
		})
		.map(|(rel, _)| rel.clone())
		.collect();
	let shown = forge_guide::project::shown(pack_dir);
	let by_rel: rustc_hash::FxHashMap<&str, &str> = texts.iter().map(|(r, t)| (r.as_str(), t.as_str())).collect();
	let sources: Vec<Source> =
		with_chain(&texts, &wanted).into_iter().map(|rel| Source { file: format!("{shown}/{rel}"), text: by_rel.get(rel.as_str()).copied().unwrap_or("").to_string(), source: rel }).collect();
	let mut diag = Diagnostics::new();
	let compiled = compile_sources(&sources, data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None });
	if diag.has_errors() {
		let first: Vec<String> = diag.list.iter().filter(|d| d.severity == "error").take(5).map(|d| format!("{}:{} {}", d.file.as_deref().unwrap_or(""), d.line, d.message)).collect();
		return Err(format!("the pack has errors:\n{}", first.join("\n")));
	}
	let guides = compiled.guides;
	let play: Vec<String> = guides.iter().filter(|g| wanted.iter().any(|w| g.hidden("_ast").get("source").as_str() == Some(w.as_str()))).map(|g| g.get("id").to_js_string()).collect();
	let arr = arriving(&guides);
	let race = run.race.as_deref().map(race_file);
	let personas_of = |root: &forge_guide::js::V| -> Vec<Persona> {
		personas(data, root, &arr, run.classes.as_deref()).into_iter().filter(|p| run.faction.as_ref().is_none_or(|f| *f == p.faction) && race.as_ref().is_none_or(|r| *r == p.race)).collect()
	};
	let findings = honest_play(&guides, data, &personas_of, kb, Some(&play), opts);
	Ok(PackResult { findings, played: play.len() })
}
