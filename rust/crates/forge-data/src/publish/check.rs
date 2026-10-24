//! `forge data publish --check <release>`: the guard every release passes before it ships.
//! (a) every published value has independent support in the private sidecar; (b) no file holds a
//! guard word; (c) no key or value names a KB source label; (d) no fingerprint of copied data;
//! (e) every row validates against its table's schema; (f) no text field runs 8 words of a
//! local evidence quote; (g) no note-fix record conflicts (corrections/LEDGER.md; a stale one is a
//! warning). The corrections (the given ones, else the release's own) are checked too: every
//! entry's `source`, one `{ kind, ref }` or a list of them, and its shape (`forge data
//! check-corrections`'s rules).

use std::path::{Path, PathBuf};

use rustc_hash::FxHashSet;
use serde_json::Value;

use super::release::release_files;
use super::schema::{self, TABLES};
use super::tables::OWN_OK;
use super::tier::independent_label;

const PACK_SPEC: &str = include_str!("../../../forge/src/pack-spec.json");

/// Player handles named in pin notes (matched as whole words, case-sensitive).
const HANDLES: &[&str] = &["XooVe", "Pynte", "Nittepitte", "Saydus", "Gruko", "Zepheriel", "Kori", "Taako", "Yendi", "Wogi", "Hotline"];

/// Every KB / build source label (none may appear as a key or a value).
pub const SOURCE_LABELS: &[&str] = &[
	"recorder",
	"correction",
	"tdb",
	"tdb.inherited",
	"eg",
	"eg.observed",
	"eg.objectives",
	"page",
	"foreverdb",
	"foreverdb.seen",
	"foreverdb.vendor",
	"foreverdb.xp",
	"foreverdb.classic",
	"forevervo.seen",
	"questie",
	"questie-forever",
	"client",
	"client.cache",
	"factoruide",
	"factoruide.web",
	"factoruide.collector",
	"web",
	"classic",
	"pfquest",
	"cmangos",
	"polestar-correction",
	"server-forever",
	"player-notes",
	"quest-text",
	"forever-data",
];

/// Credits NOTICE.md must name; exempt from the guard there only.
const NOTICE_CREDITS: &[&str] = &["questie"];

#[derive(Default)]
pub struct CheckOptions {
	pub provenance: Option<PathBuf>,
	pub evidence: Option<PathBuf>,
	pub corrections: Option<PathBuf>,
}

/// The guard words: pack-spec's `never` and `neverText`, the site's name and host, and fixed
/// phrases. The flag is false for `never`'s file and folder names that are also plain words in
/// game names (an item called "Codex of ..."): those are not looked for inside names and titles.
pub fn guard_words() -> Vec<(String, bool)> {
	let mut w: Vec<(String, bool)> = Vec::new();
	if let Ok(spec) = serde_json::from_str::<Value>(PACK_SPEC) {
		let list = |k: &str| -> Vec<String> { spec.get(k).and_then(Value::as_array).into_iter().flatten().filter_map(Value::as_str).map(str::to_lowercase).collect() };
		let text = list("neverText");
		for s in list("never") {
			let in_names = text.contains(&s) || !s.chars().all(char::is_alphabetic);
			w.push((s, in_names));
		}
		w.extend(text.into_iter().map(|s| (s, true)));
	}
	let site = ["wow", "head"].concat();
	w.push((format!("{site}.com"), true));
	w.push((site, true));
	w.push(("comment".into(), true));
	w.push(("forever's quest data".into(), true));
	w.push(("questie".into(), true));
	// A word on both lists keeps the stricter reading (looked for inside names too).
	w.sort_by(|a, b| a.0.cmp(&b.0).then(b.1.cmp(&a.1)));
	w.dedup_by(|a, b| a.0 == b.0);
	w
}

/// A data file's text with the name and title values blanked.
fn without_names(text: &str) -> String {
	text.lines()
		.map(|l| match serde_json::from_str::<Value>(l) {
			Ok(Value::Object(mut o)) => {
				for f in TEXT_FIELDS {
					o.remove(*f);
				}
				Value::Object(o).to_string()
			}
			_ => l.to_string(),
		})
		.collect::<Vec<_>>()
		.join("\n")
}

pub fn words(s: &str) -> Vec<String> {
	s.split(|c: char| !c.is_alphanumeric() && c != '\'').filter(|w| !w.is_empty()).map(|w| w.to_lowercase()).collect()
}

pub fn shingle_hash(ws: &[String]) -> u64 {
	use std::hash::{Hash, Hasher};
	let mut h = rustc_hash::FxHasher::default();
	ws.hash(&mut h);
	h.finish()
}

/// The evidence quotes of page text (comments and quest text); quotes of our own structured
/// data (`from: data`, `server`) are not site text.
fn quotes(v: &Value, out: &mut Vec<String>) {
	const PAGE: [&str; 6] = ["comment", "description", "objectives", "completion", "progress", "page"];
	match v {
		Value::Object(o) => {
			if let Some(s) = o.get("quote").and_then(Value::as_str) {
				let from = o.get("from").and_then(Value::as_str).unwrap_or("page");
				if PAGE.iter().any(|p| from.starts_with(p)) {
					out.push(s.to_string());
				}
			}
			for (k, x) in o {
				if k != "quote" {
					quotes(x, out);
				}
			}
		}
		Value::Array(a) => a.iter().for_each(|x| quotes(x, out)),
		_ => {}
	}
}

pub fn evidence_shingles(dir: &Path) -> Result<FxHashSet<u64>, String> {
	let mut set = FxHashSet::default();
	for f in std::fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))? {
		let p = f.map_err(|e| e.to_string())?.path();
		if p.extension().and_then(|e| e.to_str()) != Some("json") {
			continue;
		}
		let Ok(v) = serde_json::from_slice::<Value>(&std::fs::read(&p).unwrap_or_default()) else { continue };
		let mut q = Vec::new();
		quotes(&v, &mut q);
		for s in q {
			let w = words(&s);
			for win in w.windows(8) {
				set.insert(shingle_hash(win));
			}
		}
	}
	Ok(set)
}

fn decimals(n: &serde_json::Number) -> usize {
	let s = n.to_string();
	if s.contains('e') || s.contains('E') {
		return 99;
	}
	s.split_once('.').map_or(0, |(_, d)| d.len())
}

fn percent_grid(v: &Value) -> bool {
	let Some(n) = v.as_number() else { return false };
	let s = n.to_string();
	let f = n.as_f64().unwrap_or(-1.0);
	match s.split_once('.') {
		Some((_, d)) if d.len() == 1 => (0.0..=100.0).contains(&f) && matches!(d, "2" | "4" | "6" | "8"),
		_ => false,
	}
}

/// The site block's keys in the site's order, as a subsequence of an object's keys.
fn site_key_order(o: &serde_json::Map<String, Value>) -> bool {
	const ORDER: [&str; 7] = ["zone", "type", "side", "choices", "items", "money", "rep"];
	let mut i = 0;
	for k in o.keys() {
		if i < ORDER.len() && k == ORDER[i] {
			i += 1;
		}
	}
	i == ORDER.len()
}

fn walk_objects(v: &Value, f: &mut dyn FnMut(&serde_json::Map<String, Value>)) {
	match v {
		Value::Object(o) => {
			f(o);
			o.values().for_each(|x| walk_objects(x, f));
		}
		Value::Array(a) => a.iter().for_each(|x| walk_objects(x, f)),
		_ => {}
	}
}

const TEXT_FIELDS: &[&str] = &["title", "name", "subname", "text"];

fn handle_hit(text: &str) -> Option<&'static str> {
	HANDLES.iter().copied().find(|h| text.split(|c: char| !c.is_alphanumeric()).any(|w| w == *h))
}

/// Runs every check; returns the findings (empty: the release passes) and notes on skipped checks.
pub fn check(dir: &Path, o: &CheckOptions) -> Result<(Vec<String>, Vec<String>), String> {
	let mut find: Vec<String> = Vec::new();
	let mut notes: Vec<String> = Vec::new();
	if !dir.join("index.json").is_file() {
		return Err(format!("{}: no index.json (not a release folder)", dir.display()));
	}
	let labels: FxHashSet<String> = SOURCE_LABELS.iter().map(|s| s.to_lowercase()).collect();
	let guard = guard_words();
	let shingles = match &o.evidence {
		Some(d) if d.is_dir() => Some(evidence_shingles(d)?),
		_ => {
			notes.push("(f) skipped: no --evidence folder".into());
			None
		}
	};
	// Runs inside the game's own names and titles (independently sourced) do not count: a quote
	// may name a quest.
	let mut name_shingles: FxHashSet<u64> = FxHashSet::default();
	if shingles.is_some() {
		for t in ["quest", "npc", "object", "item"] {
			for l in std::fs::read_to_string(dir.join("data").join(format!("{t}.jsonl"))).unwrap_or_default().lines() {
				let Ok(v) = serde_json::from_str::<Value>(l) else { continue };
				for f in ["title", "name", "subname"] {
					if let Some(s) = v.get(f).and_then(Value::as_str) {
						name_shingles.extend(words(s).windows(8).map(shingle_hash));
					}
				}
			}
		}
	}
	let side = match &o.provenance {
		Some(p) if p.is_file() => {
			let canon_dir = dir.canonicalize().map_err(|e| e.to_string())?;
			if p.canonicalize().map_err(|e| e.to_string())?.starts_with(&canon_dir) {
				find.push(format!("(a) the sidecar {} is inside the release", p.display()));
			}
			Some(super::inputs::open_ro(p)?)
		}
		Some(p) => return Err(format!("--provenance {}: not found", p.display())),
		None => {
			notes.push("(a) skipped: no --provenance sidecar".into());
			None
		}
	};

	// (b) guard words in every file
	for f in release_files(dir)? {
		let rel = f.strip_prefix(dir).unwrap().to_string_lossy().to_string();
		if f.extension().and_then(|e| e.to_str()) == Some("sqlite") {
			find.push(format!("(a) {rel}: a sqlite file inside the release"));
		}
		let text = String::from_utf8_lossy(&std::fs::read(&f).map_err(|e| format!("{}: {e}", f.display()))?).to_string();
		let low = text.to_lowercase();
		let low_bare = if rel.ends_with(".jsonl") { without_names(&low) } else { low.clone() };
		for (w, in_names) in &guard {
			// NOTICE.md credits its sources; a correction's source.kind names the one it was checked
			// against, and README.md lists those kinds for contributors.
			if (rel == "NOTICE.md" || rel == "README.md" || rel.starts_with("corrections/")) && NOTICE_CREDITS.contains(&w.as_str()) {
				continue;
			}
			let hay = if *in_names { &low } else { &low_bare };
			let n = hay.matches(w.as_str()).count();
			if n > 0 {
				let line = hay.lines().position(|l| l.contains(w.as_str())).map_or(0, |i| i + 1);
				find.push(format!("(b) {rel}:{line}: guard word '{w}' ({n}x)"));
			}
		}
		if let Some(h) = handle_hit(&text) {
			find.push(format!("(b) {rel}: player handle '{h}'"));
		}
		if f.extension().and_then(|e| e.to_str()) == Some("json") {
			if let Ok(v) = serde_json::from_str::<Value>(&text) {
				walk_objects(&v, &mut |o| {
					if site_key_order(o) {
						find.push(format!("(d) {rel}: an object with the site block's key order"));
					}
				});
			}
		}
	}

	// rows: (a) (c) (d) (e) (f)
	let mut stmt = match &side {
		Some(db) => Some(db.prepare("select value, sources from prov where tbl = ? and key = ? and field = ?").map_err(|e| e.to_string())?),
		None => None,
	};
	let known: FxHashSet<String> = TABLES.iter().map(|t| format!("{}.jsonl", t.name)).collect();
	for e in std::fs::read_dir(dir.join("data")).map_err(|e| format!("{}: {e}", dir.join("data").display()))? {
		let name = e.map_err(|e| e.to_string())?.file_name().to_string_lossy().to_string();
		if !known.contains(&name) {
			find.push(format!("(e) data/{name}: not a table of the schema"));
		}
	}
	for def in TABLES {
		let p = dir.join("data").join(format!("{}.jsonl", def.name));
		let Ok(text) = std::fs::read_to_string(&p) else {
			find.push(format!("(e) data/{}.jsonl missing", def.name));
			continue;
		};
		let mut per = 0usize;
		let mut report = |find: &mut Vec<String>, s: String| {
			per += 1;
			if per <= 20 {
				find.push(s);
			} else if per == 21 {
				find.push(format!("… more findings in data/{}.jsonl", def.name));
			}
		};
		for (i, line) in text.lines().enumerate() {
			let at = format!("data/{}.jsonl:{}", def.name, i + 1);
			let v: Value = match serde_json::from_str(line) {
				Ok(v) => v,
				Err(e) => {
					report(&mut find, format!("(e) {at}: {e}"));
					continue;
				}
			};
			if let Err(e) = schema::validate(def, &v) {
				report(&mut find, format!("(e) {at}: {e}"));
			}
			let Some(row) = v.as_object() else { continue };
			let keys: Vec<&String> = row.keys().collect();
			let sorted = keys.windows(2).all(|w| w[0] <= w[1]);
			if !sorted {
				report(&mut find, format!("(e) {at}: keys not sorted"));
			}
			// (c)
			walk_objects(&v, &mut |o| {
				for (k, x) in o {
					if labels.contains(&k.to_lowercase()) {
						report(&mut find, format!("(c) {at}: key '{k}' names a source"));
					}
					if let Some(s) = x.as_str() {
						if labels.contains(&s.to_lowercase()) {
							report(&mut find, format!("(c) {at}: value '{s}' names a source"));
						}
					}
				}
			});
			// (d)
			for (k, x) in row {
				if k.contains("level") && x.as_i64() == Some(9999) {
					report(&mut find, format!("(d) {at}: {k} 9999"));
				}
				if k == "chance" && x.as_number().is_some_and(|n| decimals(n) > 2) {
					report(&mut find, format!("(d) {at}: chance {x} has more than 2 decimals"));
				}
			}
			let pts: Vec<&Value> = match def.name {
				"spawn" => vec![row.get("x"), row.get("y")].into_iter().flatten().collect(),
				"step" => row.get("place").map(|p| vec![p.get("x"), p.get("y")].into_iter().flatten().collect()).unwrap_or_default(),
				_ => vec![],
			};
			if pts.len() == 2 && pts.iter().all(|p| percent_grid(p)) {
				report(&mut find, format!("(d) {at}: coordinates on a 0.2 percent grid"));
			}
			// (f)
			if let Some(sh) = &shingles {
				for f in TEXT_FIELDS {
					if let Some(s) = row.get(*f).and_then(Value::as_str) {
						let w = words(s);
						if w.windows(8).map(shingle_hash).any(|h| sh.contains(&h) && !name_shingles.contains(&h)) {
							report(&mut find, format!("(f) {at}: {f} runs 8 words of an evidence quote"));
						}
					}
				}
			}
			// (a)
			if let Some(st) = stmt.as_mut() {
				let key = schema::key_of(def, row);
				let mut fields: Vec<String> = row.keys().filter(|k| !def.key.contains(&k.as_str())).cloned().collect();
				fields.push("_row".into());
				for f in fields {
					let got: Option<(String, String)> = st.query_row(rusqlite::params![def.name, key, f], |r| Ok((r.get(0)?, r.get(1)?))).ok();
					let Some((value, sources)) = got else {
						report(&mut find, format!("(a) {at}: {f} has no provenance"));
						continue;
					};
					let want = if f == "_row" { v.clone() } else { row[&f].clone() };
					if serde_json::from_str::<Value>(&value).ok().as_ref() != Some(&want) {
						report(&mut find, format!("(a) {at}: {f} differs from its provenance value"));
					}
					let ok = sources.split(',').any(|s| if def.own_layer { OWN_OK.contains(&s) } else { independent_label(s) });
					if !ok {
						report(&mut find, format!("(a) {at}: {f} has no independent source ({sources})"));
					}
				}
			}
		}
	}

	// note fixes: corrections/LEDGER.md (a conflicting record fails, a stale one is a note)
	match std::fs::read_to_string(dir.join("corrections").join("LEDGER.md")) {
		Ok(text) => {
			for (record, status, detail) in super::notes::ledger_parse(&text) {
				match status.as_str() {
					"conflicting" => find.push(format!("(g) corrections/notes.json {record}: conflicting ({detail})")),
					"stale" => notes.push(format!("warning: corrections/notes.json {record}: stale ({detail})")),
					_ => {}
				}
			}
		}
		Err(_) => notes.push("(g) skipped: no corrections/LEDGER.md".into()),
	}
	// corrections entries (the given ones, else the release's own): the contract `forge data
	// check-corrections` enforces (shape and sources; ids are not checked here, the release has no
	// data/forever).
	let own = dir.join("corrections");
	let given = o.corrections.clone().or_else(|| own.join("quests.json").is_file().then_some(own));
	if let Some(c) = &given {
		let text = crate::corrections::read_text(c)?;
		let label = c.display().to_string();
		let inp = crate::corrections::CheckInputs { corrections: Some((&label, &text)), mechanics: None, route_fixes: None, places: None, guide_fixes: None, data: None };
		for f in crate::corrections::check(&inp).into_iter().filter(|f| f.severity == "error") {
			find.push(format!("corrections {}: {}", f.at, f.message));
		}
	}
	Ok((find, notes))
}
