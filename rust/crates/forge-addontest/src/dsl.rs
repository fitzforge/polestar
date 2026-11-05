//! Guide fixtures: the compiler's test data (tests/fixtures/dsl), compiling `.guide` text with forge-guide,
//! and building compiled guides into a pack folder the addon loads.

use crate::run::root;
use crate::tmp::TempDir;
use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::project::{FileContent, Source};
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::rc::Rc;

/// tests/fixtures/dsl/data: the compiler's test data.
pub fn data_dir() -> PathBuf {
	root().join("tests/fixtures/dsl/data")
}

thread_local! {
	static FIXTURE: Rc<Data> = Rc::new(forge_guide::data::load_data(&data_dir()).expect("tests/fixtures/dsl/data"));
}

/// The fixture data (loaded once per test thread).
pub fn fixture_data() -> Rc<Data> {
	FIXTURE.with(Rc::clone)
}

const HEADER: [&str; 5] = ["guide t/main", "title Test", "faction Alliance", "levels 1-10", "zone Elwynn Forest"];

/// Guide text from lines; without a `guide` line the default header (t/main, Alliance, 1-10, Elwynn Forest)
/// is prepended.
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

/// Line number (1-based) of the first line equal to `needle` (both trimmed) in `text`.
pub fn line_of(text: &str, needle: &str) -> usize {
	text.split('\n').position(|l| l.trim() == needle.trim()).unwrap_or_else(|| panic!("line not found: {needle}")) + 1
}

/// What [`compile`] gives: the guides (forge-guide values; [`plain`] makes JSON of them), the diagnostics,
/// errors and warnings as "file:line: message" in sorted order, and all of them as the CLI prints them.
pub struct Compiled {
	pub guides: Vec<V>,
	pub diag: Diagnostics,
	pub errors: Vec<String>,
	pub warnings: Vec<String>,
	pub text: String,
}

fn line_str(n: f64) -> String {
	if n.fract() == 0.0 {
		format!("{}", n as i64)
	} else {
		n.to_string()
	}
}

/// Compiles `.guide` sources (file name, text) against `data`; the guides belong to `pack` (ours when None).
pub fn compile_with(sources: &[(&str, &str)], data: &Data, pack: Option<&str>) -> Compiled {
	let list: Vec<Source> = sources.iter().map(|(file, text)| Source { source: String::new(), file: file.to_string(), text: text.to_string() }).collect();
	let mut diag = Diagnostics::new();
	let opts = forge_guide::project::CompileOpts { pack: pack.map(String::from), author: None, context: None, pack_dir: None };
	let c = forge_guide::project::compile_sources(&list, data, &mut diag, &opts);
	let sorted = diag.sorted();
	let strip = |d: &forge_guide::diag::Diag| format!("{}:{}: {}", d.file.as_deref().unwrap_or("undefined"), line_str(d.line), d.message);
	Compiled {
		guides: c.guides,
		errors: sorted.iter().filter(|d| d.severity == "error").map(strip).collect(),
		warnings: sorted.iter().filter(|d| d.severity == "warning").map(strip).collect(),
		text: sorted.iter().map(forge_guide::diag::format).collect::<Vec<_>>().join("\n"),
		diag,
	}
}

/// Compiles one source, `test.guide`, against the fixture data, as ours.
pub fn compile(text: &str) -> Compiled {
	compile_with(&[("test.guide", text)], &fixture_data(), None)
}

/// A JSON-plain copy of a compiled value (JSON.parse(JSON.stringify(v))).
pub fn plain(v: &V) -> Value {
	serde_json::from_str(&forge_guide::js::stringify(v, None)).expect("JSON of a compiled value")
}

/// Our pack's manifest (guides/pack.json).
pub fn our_manifest() -> V {
	let (m, diags) = forge_guide::manifest::read_manifest(&root().join("guides"), true);
	m.unwrap_or_else(|| panic!("guides/pack.json: {diags:?}"))
}

/// A pack built into a temp folder (removed on drop): `dir` is the addon folder (named after the
/// manifest's folder), `files` what was written (names relative to it, `../` for the faction parts, race
/// parts and texts addons beside it), `scripts` the files its TOC loads, absolute, in load order, then each
/// part's Guides.lua.
pub struct TestPack {
	pub dir: PathBuf,
	pub files: Vec<(String, FileContent)>,
	pub scripts: Vec<PathBuf>,
	pub tmp: TempDir,
}

impl TestPack {
	/// A written file's text by its name in `files`.
	pub fn text(&self, name: &str) -> &str {
		match self.files.iter().find(|(n, _)| n == name) {
			Some((_, FileContent::Text(t))) => t,
			_ => panic!("no text file {name} in the pack"),
		}
	}

	/// The name in `files` of the Guides.lua that registers guide `id`: the pack's own, or the part it
	/// went into (Polestar's own pack keeps each faction's guides in a part, format 8).
	pub fn guides_of(&self, id: &str) -> &str {
		let needle = format!("\n\t\t\tid = \"{id}\",\n");
		self.files
			.iter()
			.find(|(n, c)| n.ends_with("Guides.lua") && matches!(c, FileContent::Text(t) if t.contains(&needle)))
			.map(|(n, _)| n.as_str())
			.unwrap_or_else(|| panic!("no Guides.lua in the pack registers {id}"))
	}
}

/// Writes a pack's files into `dir` (a fresh folder; `../<addon>/<file>` names go beside it).
pub fn write_pack_dir(dir: &Path, files: &[(String, FileContent)]) {
	for (name, content) in files {
		let file = dir.join(name);
		std::fs::create_dir_all(file.parent().unwrap()).unwrap();
		match content {
			FileContent::Text(t) => std::fs::write(&file, t),
			FileContent::Bytes(b) => std::fs::write(&file, b),
		}
		.unwrap_or_else(|e| panic!("{}: {e}", file.display()));
	}
}

/// Builds compiled guides into a pack folder (the JS helpers' writeTestPack / writePackInto).
pub fn write_test_pack(guides: &[V], data: &Data, manifest: &V) -> TestPack {
	let tmp = TempDir::new("polestar-pack-");
	let dir = tmp.path().join(manifest.get("folder").to_js_string());
	let iface = forge_guide::project::core_interface(root()).expect("core interface");
	let files = forge_guide::project::build_pack_files(guides, manifest, data, None, &V::obj(), &[], &iface, Vec::new());
	write_pack_dir(&dir, &files);
	let mut parts: Vec<&str> = files.iter().map(|(n, _)| n.as_str()).filter(|n| n.starts_with("../") && n.ends_with("/Guides.lua")).collect();
	parts.sort();
	let mut scripts: Vec<PathBuf> = crate::run::toc_entries(&dir).expect("pack TOC").iter().map(|f| dir.join(f)).collect();
	scripts.extend(parts.iter().map(|p| dir.join(p)));
	TestPack { dir, files, scripts, tmp }
}

/// [`write_test_pack`] with the fixture data and our manifest.
pub fn write_our_test_pack(guides: &[V]) -> TestPack {
	write_test_pack(guides, &fixture_data(), &our_manifest())
}

/// Builds the pack folder `pack_dir` (its pack.json, guides, retired.json; no context) against the fixture
/// data, as the pack build does for a community pack. Errors are in `project.diag`; `files` is None then.
pub fn build_pack(pack_dir: &Path) -> forge_guide::project::Built {
	let (manifest, extra) = forge_guide::manifest::read_manifest(pack_dir, false);
	let manifest = manifest.unwrap_or_else(|| panic!("{}: {extra:?}", pack_dir.display()));
	let opts = forge_guide::project::BuildOpts { include_drafts: false, context: None, force: false };
	forge_guide::project::build_pack(root(), pack_dir, &manifest, extra, &fixture_data(), Diagnostics::new(), opts).unwrap_or_else(|e| panic!("{e}"))
}

fn jv(v: Value) -> V {
	forge_guide::js::parse_json(&v.to_string()).expect("JSON")
}

/// `{ ...base, ...extra }` for an object value.
fn spread(base: &V, extra: Value) -> V {
	let o = base.as_obj().map(forge_guide::js::Obj::spread).unwrap_or_default();
	if let Value::Object(m) = extra {
		for (k, v) in m {
			o.set(&k, jv(v));
		}
	}
	V::Obj(o)
}

fn data_with(base: &Data, tables: Vec<(&str, V)>, instances: V) -> Data {
	let mut t: rustc_hash::FxHashMap<String, V> = rustc_hash::FxHashMap::default();
	for (k, v) in [
		("objects", base.objects.clone()),
		("zones", base.zones.clone()),
		("map-frames", base.map_frames.clone()),
		("meta", base.meta.clone()),
		("npcs", base.npcs.clone()),
		("items", base.items.clone()),
		("quests", base.quests.clone()),
	] {
		t.insert(k.to_string(), v);
	}
	for (k, v) in tables {
		t.insert(k.to_string(), v);
	}
	Data::new(forge_guide::data::Raw { tables: t, instances, areas: V::Null }, base.dir.clone(), Vec::new())
}

/// The fixture data plus group content (helpers/dsl.js groupData; docs/GUIDE_FORMAT.md, "Group content"):
/// 95003 Elite Kobold (rank 1) is already there; 95030 is a friendly rank-1 talk credit, 95040 a boss and
/// 95041 a raid boss, both with no open-world spawn. Item 95100 drops only from the Elite Kobold, 95101 also
/// from a normal kobold. Quests 9600 and 9603 (dungeon area, their boss inside) and 9601 (raid area) are
/// instance quests; 9602 has the dungeon's area but is done outside (a breadcrumb). Marshal McBride gives and
/// takes back every one. Area 7001 is the Hollow Deeps, 7002 Molten Core; uiMap 9900 is drawn on the Hollow
/// Deeps.
pub fn group_data() -> Data {
	let base = fixture_data();
	let npcs = spread(
		&base.npcs,
		serde_json::json!({
			"95030": { "id": 95030, "name": "Friendly Sage", "level": 55, "rank": 1, "faction": "AH", "spawns": { "1429": { "f": "e", "pts": [[40, 40]] } } },
			"95040": { "id": 95040, "name": "Hollow Lord", "level": 30, "rank": 3, "faction": null, "spawns": {} },
			"95041": { "id": 95041, "name": "Fire Lord", "level": 63, "rank": 3, "faction": null, "spawns": {} },
		}),
	);
	let items = spread(
		&base.items,
		serde_json::json!({
			"95100": { "id": 95100, "name": "Elite Tusk", "drops": { "npc": { "95003": 60 }, "object": {} }, "vendors": [] },
			"95101": { "id": 95101, "name": "Kobold Tusk", "drops": { "npc": { "95003": 60, "95002": 10 }, "object": {} }, "vendors": [] },
		}),
	);
	let q7 = base.quests.get("7");
	let quest = |id: u32, title: &str, area: u32, objectives: Value| spread(&q7, serde_json::json!({ "id": id, "title": title, "area": area, "pre": [], "objectives": objectives }));
	let boss = |id: u32, name: &str| serde_json::json!([{ "type": "kill", "id": id, "count": 1, "text": format!("{name} slain") }]);
	let quests = spread(&base.quests, Value::Null);
	for (id, q) in [
		(9600, quest(9600, "Into the Hollow", 7001, boss(95040, "Hollow Lord"))),
		(9601, quest(9601, "The Fire Lord", 7002, boss(95041, "Fire Lord"))),
		(9602, quest(9602, "Rumours of the Hollow", 7001, serde_json::json!([{ "type": "kill", "id": 6, "count": 2, "text": "Kobold Vermin slain" }]))),
		(9603, quest(9603, "Hollow Relics", 7001, boss(95040, "Hollow Lord"))),
	] {
		quests.set(&id.to_string(), q);
	}
	let instances = jv(serde_json::json!({
		"areas": { "7001": { "kind": "dungeon", "name": "Hollow Deeps" }, "7002": { "kind": "raid", "name": "Molten Core" } },
		"maps": { "9900": { "kind": "dungeon", "name": "Hollow Deeps" } },
	}));
	data_with(&base, vec![("quests", quests), ("npcs", npcs), ("items", items)], instances)
}

/// The fixture data plus escort quests (helpers/dsl.js escortData; docs/GUIDE_FORMAT.md, "Escort quests"),
/// each given and taken back by Marshal McBride: 9700 says escort in its event objective and also has a kill;
/// 9701 has no objectives and says it in its objective text; 9702 is worded otherwise and marked `escort`;
/// 9703 says escort in an objective copied from another quest and is marked not one; 9704 is an event that is
/// no escort.
pub fn escort_data() -> Data {
	let base = fixture_data();
	let q7 = base.quests.get("7");
	let quest = |id: u32, title: &str, objectives: Value, more: Value| {
		let q = spread(&q7, serde_json::json!({ "id": id, "title": title, "pre": [], "objectives": objectives, "objectiveText": "" }));
		spread(&q, more)
	};
	let event = |text: &str| serde_json::json!({ "type": "event", "id": null, "count": null, "text": text });
	let quests = spread(&base.quests, Value::Null);
	for (id, q) in [
		(
			9700,
			quest(9700, "The Vineyard Walk", serde_json::json!([event("Escort Brother Danil to the vineyard"), { "type": "kill", "id": 6, "count": 3, "text": "Kobold Vermin slain" }]), Value::Null),
		),
		(9701, quest(9701, "Out of the Abbey", serde_json::json!([]), serde_json::json!({ "objectiveText": "Escort Khelden Bremen out of the abbey, then tell Marshal McBride." }))),
		(9702, quest(9702, "To the Road", serde_json::json!([event("Protect Dermot Johns until you reach the road")]), serde_json::json!({ "escort": true }))),
		(9703, quest(9703, "Lost Dermot", serde_json::json!([event("Escort Dermot Johns to the road")]), serde_json::json!({ "objectiveText": "Find Dermot Johns.", "escort": false }))),
		(9704, quest(9704, "The Vigil", serde_json::json!([event("Keep the vigil at the abbey")]), Value::Null)),
	] {
		quests.set(&id.to_string(), q);
	}
	data_with(&base, vec![("quests", quests)], V::Null)
}
