//! The compiler's test fixtures (tests/fixtures/dsl at the repository root) and helpers to compile guides
//! from them: the Rust side of the guide feature tests (each test file names the behaviour it covers).
#![allow(dead_code)]

use forge_guide::data::{load_data, Data, Raw};
use forge_guide::diag::{format, Diag, Diagnostics};
use forge_guide::js::{parse_json, stringify, V};
use forge_guide::obj;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use rustc_hash::FxHashMap;
use serde_json::{Map, Value};
use std::path::{Path, PathBuf};

pub fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

/// tests/fixtures/dsl.
pub fn fixtures() -> PathBuf {
	repo().join("tests/fixtures/dsl")
}

pub fn data_dir() -> PathBuf {
	fixtures().join("data")
}

/// tests/fixtures/packs/<name>.
pub fn pack_fixture(name: &str) -> PathBuf {
	repo().join("tests/fixtures/packs").join(name)
}

/// The fixture data (tests/fixtures/dsl/data).
pub fn fixture_data() -> Data {
	load_data(&data_dir()).unwrap()
}

/// The fixture data's tables as JSON, by file name without `.json` (quests, npcs, map-frames, ...).
pub fn tables() -> Map<String, Value> {
	let mut out = Map::new();
	for e in std::fs::read_dir(data_dir()).unwrap().flatten() {
		let name = e.file_name().to_string_lossy().into_owned();
		if let Some(stem) = name.strip_suffix(".json") {
			out.insert(stem.to_string(), serde_json::from_slice(&std::fs::read(e.path()).unwrap()).unwrap());
		}
	}
	out
}

/// The JS value of a JSON value.
pub fn v(j: &Value) -> V {
	parse_json(&j.to_string()).unwrap()
}

/// `new Data(tables, { dir })`: data from these tables only (none missing), with solo.js instances
/// (`{ areas, maps }`) and an AreaTable (`{ build, byId, byName }`), each Null when absent.
pub fn data_from(tables: &Map<String, Value>, instances: Value, areas: Value) -> Data {
	let raw = Raw { tables: tables.iter().map(|(k, t)| (k.clone(), v(t))).collect::<FxHashMap<_, _>>(), instances: v(&instances), areas: v(&areas) };
	Data::new(raw, Some(data_dir().to_string_lossy().into_owned()), Vec::new())
}

/// An AreaTable of (id, name, parent) rows as data/areas.js loadAreas gives it.
pub fn areas(rows: &[(u32, &str, u32)]) -> Value {
	let mut by_id = Map::new();
	let mut by_name: Map<String, Value> = Map::new();
	for &(id, name, parent) in rows {
		let a = serde_json::json!({ "id": id, "name": name, "c": 0, "parent": parent });
		by_id.insert(id.to_string(), a.clone());
		by_name.entry(name.to_lowercase()).or_insert_with(|| Value::Array(Vec::new())).as_array_mut().unwrap().push(a);
	}
	serde_json::json!({ "build": "test", "byId": by_id, "byName": by_name })
}

pub const HEADER: [&str; 5] = ["guide t/main", "title Test", "faction Alliance", "levels 1-10", "zone Elwynn Forest"];

/// Guide text from lines; without a `guide` line the default header is prepended.
pub fn guide_text(lines: &[&str]) -> String {
	if lines.first().is_some_and(|l| l.starts_with("guide ")) {
		format!("{}\n", lines.join("\n"))
	} else {
		let mut all: Vec<&str> = HEADER.to_vec();
		all.push("");
		all.extend_from_slice(lines);
		format!("{}\n", all.join("\n"))
	}
}

/// Line number (1-based) of the first line equal to `needle` (both trimmed).
pub fn line_of(text: &str, needle: &str) -> usize {
	text.split('\n').position(|l| l.trim() == needle.trim()).unwrap_or_else(|| panic!("line not found: {needle}")) + 1
}

fn line_str(n: f64) -> String {
	if n.fract() == 0.0 {
		format!("{}", n as i64)
	} else {
		format!("{n}")
	}
}

/// "file:line: message".
pub fn strip(d: &Diag) -> String {
	format!("{}:{}: {}", d.file.as_deref().unwrap_or("undefined"), line_str(d.line), d.message)
}

/// "line: message" (parse's errors).
pub fn at_line(d: &Diag) -> String {
	format!("{}: {}", line_str(d.line), d.message)
}

pub struct Compiled {
	pub guides: Vec<V>,
	pub diag: Diagnostics,
	pub errors: Vec<String>,
	pub warnings: Vec<String>,
	pub text: String,
}

impl Compiled {
	/// The warnings holding `needle`.
	pub fn warned(&self, needle: &str) -> Vec<String> {
		self.warnings.iter().filter(|w| w.contains(needle)).cloned().collect()
	}
	pub fn erred(&self, needle: &str) -> Vec<String> {
		self.errors.iter().filter(|w| w.contains(needle)).cloned().collect()
	}
	pub fn diagnostics(&self) -> Vec<String> {
		self.diag.sorted().iter().map(strip).collect()
	}
}

/// compile({ file: text }, data, { pack }): the guides belong to `pack` (ours when None).
pub fn compile_files(files: &[(&str, &str)], data: &Data, pack: Option<&str>) -> Compiled {
	let sources: Vec<Source> = files.iter().map(|(f, t)| Source { source: String::new(), file: f.to_string(), text: t.to_string() }).collect();
	let mut diag = Diagnostics::new();
	let opts = CompileOpts { pack: pack.map(String::from), author: None, context: None, pack_dir: None };
	let c = compile_sources(&sources, data, &mut diag, &opts);
	finish(c.guides, diag)
}

pub fn finish(guides: Vec<V>, diag: Diagnostics) -> Compiled {
	let sorted = diag.sorted();
	let errors = sorted.iter().filter(|d| d.severity == "error").map(strip).collect();
	let warnings = sorted.iter().filter(|d| d.severity == "warning").map(strip).collect();
	let text = sorted.iter().map(format).collect::<Vec<_>>().join("\n");
	Compiled { guides, diag, errors, warnings, text }
}

/// One `test.guide` against the fixture data, its pictures looked up in `pack_dir`.
pub fn compile_in(text: &str, pack_dir: &Path) -> Compiled {
	let sources = vec![Source { source: String::new(), file: "test.guide".into(), text: text.into() }];
	let mut diag = Diagnostics::new();
	let opts = CompileOpts { pack: None, author: None, context: None, pack_dir: Some(pack_dir.to_path_buf()) };
	let c = compile_sources(&sources, &fixture_data(), &mut diag, &opts);
	finish(c.guides, diag)
}

/// A copy of a fixture data folder (tests/fixtures/<name>) with `edit` applied to its parsed files (by file
/// name, with `.json`).
pub fn data_dir_with(name: &str, from: &Path, edit: impl FnOnce(&mut Map<String, Value>)) -> PathBuf {
	let out = scratch(name);
	let mut raw = Map::new();
	for e in std::fs::read_dir(from).unwrap().flatten() {
		raw.insert(e.file_name().to_string_lossy().into_owned(), serde_json::from_slice(&std::fs::read(e.path()).unwrap()).unwrap());
	}
	edit(&mut raw);
	for (f, x) in &raw {
		std::fs::write(out.join(f), x.to_string()).unwrap();
	}
	out
}

/// One `test.guide` against the fixture data.
pub fn compile(text: &str) -> Compiled {
	compile_files(&[("test.guide", text)], &fixture_data(), None)
}

/// Several files against the fixture data.
pub fn compile_map(files: &[(&str, &str)]) -> Compiled {
	compile_files(files, &fixture_data(), None)
}

/// Lines joined with "\n" (a JS `[...].join('\n')`).
pub fn lines(l: &[&str]) -> String {
	l.join("\n")
}

impl Compiled {
	/// The guide with this id.
	pub fn guide(&self, id: &str) -> V {
		self.guides.iter().find(|g| g.get("id").as_str() == Some(id)).cloned().unwrap_or_else(|| panic!("no guide {id}"))
	}
	/// plain(guides[0].steps).
	pub fn steps(&self) -> Vec<Value> {
		plain(&self.guides[0].get("steps")).as_array().unwrap().clone()
	}
}

pub fn compile_with(text: &str, data: &Data) -> Compiled {
	compile_files(&[("test.guide", text)], data, None)
}

/// parseGuide on `x.guide` -> (ast, its errors as "line: message").
pub fn parse(text: &str) -> (V, Vec<String>) {
	let mut diag = Diagnostics::new();
	let ast = forge_guide::parse::parse_guide(text, "x.guide", &mut diag);
	let errors = diag.sorted().iter().filter(|d| d.severity == "error").map(at_line).collect();
	(ast, errors)
}

/// parseGuide -> (ast, every diagnostic as "severity line: message").
pub fn parse_all(text: &str, file: &str) -> (V, Diagnostics) {
	let mut diag = Diagnostics::new();
	let ast = forge_guide::parse::parse_guide(text, file, &mut diag);
	(ast, diag)
}

/// A JSON-plain copy (JSON.parse(JSON.stringify(v))): no hidden bookkeeping, no undefined fields.
pub fn plain(x: &V) -> Value {
	if x.is_undef() {
		return Value::Null;
	}
	serde_json::from_str(&stringify(x, None)).unwrap()
}

/// Guides.lua of these guides (emitGuides([{ guide, source: null }])).
pub fn emit(guides: &[V]) -> String {
	let entries: Vec<V> = guides.iter().map(|g| obj! { "guide" => g.clone(), "source" => V::Null }.into()).collect();
	forge_guide::emit::emit_guides(&entries, false)
}

/// The first guide's step goals, plain: steps[i].goals[0] for each step.
pub fn first_goals(c: &Compiled) -> Vec<Value> {
	plain(&c.guides[0].get("steps")).as_array().unwrap().iter().map(|s| s["goals"][0].clone()).collect()
}

pub fn re(pattern: &str) -> regex::Regex {
	regex::Regex::new(pattern).unwrap()
}

/// assert.match.
#[track_caller]
pub fn assert_match(text: &str, pattern: &str) {
	assert!(re(pattern).is_match(text), "no match for /{pattern}/ in:\n{text}");
}

#[track_caller]
pub fn assert_no_match(text: &str, pattern: &str) {
	assert!(!re(pattern).is_match(text), "unexpected match for /{pattern}/ in:\n{text}");
}

/// A fresh scratch folder under the target dir.
pub fn scratch(name: &str) -> PathBuf {
	// Unique per call: tests run in parallel threads and may ask for the same name.
	static N: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
	let n = N.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("{name}-{}-{n}", std::process::id()));
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

/// Writes `files` (relative path -> text) under `dir`.
pub fn write_tree(dir: &Path, files: &[(&str, &str)]) {
	for (rel, text) in files {
		let p = dir.join(rel);
		std::fs::create_dir_all(p.parent().unwrap()).unwrap();
		std::fs::write(p, text).unwrap();
	}
}

/// quests[7] of the fixture with these fields over it (the JS `{ ...base.quests[7], ... }`).
fn quest_like_7(t: &Map<String, Value>, more: Value) -> Value {
	let mut q = t["quests"]["7"].clone();
	for (k, x) in more.as_object().unwrap() {
		q[k] = x.clone();
	}
	q
}

/// The fixture data plus group content (docs/GUIDE_FORMAT.md, "Group content"): 95003 Elite Kobold (rank 1)
/// is already there; 95030 is a friendly rank-1 talk credit, 95040 a boss and 95041 a raid boss, both with no
/// open-world spawn. Item 95100 drops only from the Elite Kobold, 95101 also from a normal kobold. Quests 9600
/// and 9603 (dungeon area, their boss inside) and 9601 (raid area) are instance quests; 9602 has the dungeon's
/// area but is done outside (a breadcrumb). Area 7001 is the Hollow Deeps, 7002 Molten Core; uiMap 9900 is
/// drawn on the Hollow Deeps.
pub fn group_data() -> Data {
	use serde_json::json;
	let mut t = tables();
	let npcs = t.get_mut("npcs").unwrap();
	npcs["95030"] = json!({ "id": 95030, "name": "Friendly Sage", "level": 55, "rank": 1, "faction": "AH", "spawns": { "1429": { "f": "e", "pts": [[40, 40]] } } });
	npcs["95040"] = json!({ "id": 95040, "name": "Hollow Lord", "level": 30, "rank": 3, "faction": null, "spawns": {} });
	npcs["95041"] = json!({ "id": 95041, "name": "Fire Lord", "level": 63, "rank": 3, "faction": null, "spawns": {} });
	let items = t.get_mut("items").unwrap();
	items["95100"] = json!({ "id": 95100, "name": "Elite Tusk", "drops": { "npc": { "95003": 60 }, "object": {} }, "vendors": [] });
	items["95101"] = json!({ "id": 95101, "name": "Kobold Tusk", "drops": { "npc": { "95003": 60, "95002": 10 }, "object": {} }, "vendors": [] });
	let boss = |id: u32, name: &str| json!([{ "type": "kill", "id": id, "count": 1, "text": format!("{name} slain") }]);
	let qs = [
		(9600, "Into the Hollow", 7001, boss(95040, "Hollow Lord")),
		(9601, "The Fire Lord", 7002, boss(95041, "Fire Lord")),
		(9602, "Rumours of the Hollow", 7001, json!([{ "type": "kill", "id": 6, "count": 2, "text": "Kobold Vermin slain" }])),
		(9603, "Hollow Relics", 7001, boss(95040, "Hollow Lord")),
	];
	for (id, title, area, objectives) in qs {
		let q = quest_like_7(&t, json!({ "id": id, "title": title, "area": area, "pre": [], "objectives": objectives }));
		t.get_mut("quests").unwrap()[id.to_string()] = q;
	}
	let keep: Map<String, Value> = t.into_iter().filter(|(k, _)| ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"].contains(&k.as_str())).collect();
	let instances = json!({ "areas": { "7001": { "kind": "dungeon", "name": "Hollow Deeps" }, "7002": { "kind": "raid", "name": "Molten Core" } }, "maps": { "9900": { "kind": "dungeon", "name": "Hollow Deeps" } } });
	data_from(&keep, instances, Value::Null)
}

/// The fixture data plus escort quests (docs/GUIDE_FORMAT.md, "Escort quests"), each given and taken back by
/// Marshal McBride: 9700 says escort in its event objective and also has a kill; 9701 has no objectives and
/// says it in its objective text; 9702 is worded otherwise and marked `escort` (a corrections fix); 9703 says
/// escort in an objective copied from another quest and is marked not one; 9704 is an event that is no escort.
pub fn escort_data() -> Data {
	use serde_json::json;
	let mut t = tables();
	let event = |text: &str| json!([{ "type": "event", "id": null, "count": null, "text": text }]);
	let qs = [
		json!({ "id": 9700, "title": "The Vineyard Walk", "objectives": [{ "type": "event", "id": null, "count": null, "text": "Escort Brother Danil to the vineyard" }, { "type": "kill", "id": 6, "count": 3, "text": "Kobold Vermin slain" }] }),
		json!({ "id": 9701, "title": "Out of the Abbey", "objectives": [], "objectiveText": "Escort Khelden Bremen out of the abbey, then tell Marshal McBride." }),
		json!({ "id": 9702, "title": "To the Road", "objectives": event("Protect Dermot Johns until you reach the road"), "escort": true }),
		json!({ "id": 9703, "title": "Lost Dermot", "objectives": event("Escort Dermot Johns to the road"), "objectiveText": "Find Dermot Johns.", "escort": false }),
		json!({ "id": 9704, "title": "The Vigil", "objectives": event("Keep the vigil at the abbey") }),
	];
	for more in qs {
		let mut base = json!({ "pre": [], "objectiveText": "" });
		for (k, x) in more.as_object().unwrap() {
			base[k] = x.clone();
		}
		let id = more["id"].to_string();
		let q = quest_like_7(&t, base);
		t.get_mut("quests").unwrap()[id] = q;
	}
	let keep: Map<String, Value> = t.into_iter().filter(|(k, _)| ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"].contains(&k.as_str())).collect();
	data_from(&keep, Value::Null, Value::Null)
}

/// Guides.lua with each guide's source named `test.guide`.
pub fn emit_sourced(guides: &[V]) -> String {
	let entries: Vec<V> = guides.iter().map(|g| obj! { "guide" => g.clone(), "source" => "test.guide" }.into()).collect();
	forge_guide::emit::emit_guides(&entries, false)
}

/// The repository's reference data folder, when built (tests on it skip otherwise).
pub fn reference_data(file: &str) -> Option<PathBuf> {
	let d = repo().join("data/forever");
	d.join(file).exists().then_some(d)
}

/// A pack fixture's manifest (pack.json read as another pack's).
pub fn manifest_of(dir: &Path) -> V {
	forge_guide::manifest::read_manifest(dir, false).0.expect("a valid pack.json")
}

/// buildPackFiles({ guides, manifest, data }) -> file name -> text (bytes as lossy text).
pub fn pack_files(guides: &[V], manifest: &V, data: &Data) -> std::collections::BTreeMap<String, String> {
	let iface = forge_guide::project::core_interface(&repo()).unwrap();
	forge_guide::project::build_pack_files(guides, manifest, data, None, &V::obj(), &[], &iface, Vec::new())
		.into_iter()
		.map(|(k, c)| {
			let t = match c {
				forge_guide::project::FileContent::Text(t) => t,
				forge_guide::project::FileContent::Bytes(b) => String::from_utf8_lossy(&b).into_owned(),
			};
			(k, t)
		})
		.collect()
}

/// The text of the one file whose name ends with `suffix`.
pub fn file_ending(files: &std::collections::BTreeMap<String, String>, suffix: &str) -> String {
	files.iter().find(|(k, _)| k.ends_with(suffix)).map(|(_, t)| t.clone()).unwrap_or_else(|| panic!("no *{suffix}"))
}

/// A deep copy of the guides with `f` applied to the first guide's first step (the JS
/// `guides.map((g) => ({ ...g, steps: ... }))` copies the format tests make).
pub fn with_first_step(guides: &[V], f: impl Fn(&V)) -> Vec<V> {
	let copy: Vec<V> = guides.iter().map(V::json_clone).collect();
	f(&copy[0].get("steps").at(0));
	copy
}

/// compileProject of a pack fixture with the fixture data (no context).
pub fn compile_pack_fixture(name: &str) -> forge_guide::project::Project {
	let dir = pack_fixture(name);
	forge_guide::project::compile_project(&dir, &manifest_of(&dir), &fixture_data(), Diagnostics::new(), false, None)
}
