//! `forge data codex` (the port of the JS `codex build`), offline: data/forever/*.json + the Forever
//! client's cached wago.tools tables + the cached web facts + the installed ForeverLevelingBiS +
//! Polestar's guides and curated tables -> data/forever/codex/*.json and the pack
//! addon/Polestar_Codex. Byte for byte the JS build's output. `--local-extras` (`Options::local_extras`)
//! also merges the installed AtlasLoot and RareScanner and dungeons.json, skips the web facts, and
//! marks the build local (this machine only).
//!
//! A release build compares itself with the last `--local-extras` build when one exists
//! (`parity_against`, default data/local/codex-extras) and records the match per kind in meta.json
//! (`parity`); the comparison's own report files (data/local/codex-parity.json/.md) are not written.

pub mod atlasloot;
pub mod attune;
pub mod client;
pub mod instances;
pub mod journal;
pub mod memory;
pub mod merge;
pub mod pack;
pub mod parity;
pub mod rarescanner;
pub mod spawns;
pub mod util;

use std::path::{Path, PathBuf};
use std::sync::LazyLock;
use std::time::Instant;

use forge_guide::js::{parse_json, stringify, Obj, V};
use regex::Regex;

use client::{ClientFacts, ERA_BUILD, ERA_TABLES, TABLES};
use instances::GuideGoto;
use util::{kstr, sort_keys_deep};

#[derive(Clone)]
pub struct Options {
	/// The checkout: data/codex/*.json, guides/, package.json, addon/Polestar/Lookup/Codex.lua.
	pub root: PathBuf,
	/// data/forever (default <root>/data/forever).
	pub data_dir: PathBuf,
	/// data/sources (default <root>/data/sources).
	pub sources_dir: PathBuf,
	/// The Forever client's Interface/AddOns (None: detected).
	pub addons: Option<PathBuf>,
	/// wago.tools Forever build (None: the newest cached one holding every table).
	pub build: Option<String>,
	/// meta.json builtAt (None: data/forever/meta.json's).
	pub built_at: Option<String>,
	/// The pack's version (None: package.json's).
	pub version: Option<String>,
	/// The `--local-extras` build to compare with (None: none; the CLI passes
	/// <root>/data/local/codex-extras); used when it holds meta.json.
	pub parity_against: Option<PathBuf>,
	/// Measure the pack's memory in Lua 5.1 (meta.pack.memoryKB...).
	pub measure: bool,
	/// meta.pack.loadMs as given (the measured time otherwise: it differs run to run).
	pub load_ms: Option<f64>,
	/// The working directory messages name paths relative to.
	pub cwd: PathBuf,
	/// Also merge the installed AtlasLoot, RareScanner and data/forever/dungeons.json: a build for
	/// this machine only (its meta says so and `pack` refuses it).
	pub local_extras: bool,
}

impl Options {
	pub fn new(root: &Path) -> Options {
		Options {
			root: root.to_path_buf(),
			data_dir: root.join("data").join("forever"),
			sources_dir: root.join("data").join("sources"),
			addons: None,
			build: None,
			built_at: None,
			version: None,
			parity_against: Some(root.join("data").join("local").join("codex-extras")),
			measure: true,
			load_ms: None,
			cwd: std::env::current_dir().unwrap_or_else(|_| root.to_path_buf()),
			local_extras: false,
		}
	}
}

pub struct Output {
	/// data/forever/codex/<name>.json, by file name.
	pub json: Vec<(String, String)>,
	/// The pack's files (TOC order, then the TOC and LICENSE-DATA.txt).
	pub pack: Vec<(String, String)>,
	pub meta: V,
	pub warnings: Vec<String>,
	/// The JS command's report lines (stdout).
	pub report: Vec<String>,
}

pub struct Forever {
	pub items: V,
	pub npcs: V,
	pub objects: V,
	pub quests: V,
	pub zones: V,
	pub factions: V,
	pub professions: V,
	pub trainers: V,
	pub map_frames: V,
	pub meta: V,
	pub instances: V,
	/// dungeons.json (a --local-extras build only; null otherwise).
	pub dungeons: V,
}

pub struct Inputs {
	pub forever: Forever,
	/// The installed AtlasLoot and RareScanner (a --local-extras build only).
	pub atlasloot: Option<V>,
	pub rarescanner: Option<V>,
	pub local_extras: bool,
	/// ForeverLevelingBiS: { meta, items, quests } (JS shapes).
	pub flbis: Option<V>,
	pub client: Option<ClientFacts>,
	/// The cached web facts: { npc, object, item, spell, listed }.
	pub web: Option<V>,
	pub curated: Vec<f64>,
	pub curated_gates: V,
	pub entrances: Vec<GuideGoto>,
	pub entrance_table: V,
	pub rep_table: V,
	pub attunement_table: V,
	pub journal_quests: Vec<V>,
	pub warnings: Vec<String>,
}

fn read_json(file: &Path, optional: bool, cwd: &Path) -> Result<V, String> {
	if !file.exists() {
		if optional {
			return Ok(V::Null);
		}
		return Err(format!("missing {} (run `forge data build` first)", crate::jsv::relative(cwd, file)));
	}
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))
}

fn or_obj(v: V) -> V {
	if v.truthy() {
		v
	} else {
		V::obj()
	}
}

/// The cached web facts under `sourcesDir` (port of the JS loader).
pub fn load_web(sources: &Path) -> Result<V, String> {
	let out = Obj::new();
	for ty in ["npc", "object", "item", "spell"] {
		let t = Obj::new();
		let dir = sources.join("web").join("codex").join(ty);
		if dir.exists() {
			let mut files: Vec<String> = std::fs::read_dir(&dir).map_err(|e| e.to_string())?.flatten().map(|e| e.file_name().to_string_lossy().to_string()).collect();
			files.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
			for f in files {
				if !f.ends_with(".json") {
					continue;
				}
				let facts = parse_json(&std::fs::read_to_string(dir.join(&f)).map_err(|e| e.to_string())?)?;
				if !facts.get("notFound").truthy() {
					t.set(&kstr(&facts.get("id")), facts);
				}
			}
		}
		out.set(ty, V::Obj(t));
	}
	let listed = Obj::new();
	for ty in ["npc", "object", "item"] {
		let file = sources.join("web").join("codex").join("lists").join(format!("{ty}.json"));
		if !file.exists() {
			continue;
		}
		let rows = Obj::new();
		let v = parse_json(&std::fs::read_to_string(&file).map_err(|e| e.to_string())?)?;
		for c in v.get("chunks").items() {
			for r in c.get("rows").items() {
				rows.set(&kstr(&r.get("id")), r);
			}
		}
		listed.set(ty, V::Obj(rows));
	}
	out.set("listed", V::Obj(listed));
	Ok(V::Obj(out))
}

/// `isWebCitation(c)` (tools/lib/codex/web.js): a curated table's citation of the web quest
/// database, `{ edition: "forever" | "classic", kind, id }` or `{ edition, kind: "guide", ref }`,
/// with an optional string `note`.
pub fn is_web_citation(c: &V) -> bool {
	if !c.is_obj() || !matches!(c.get("edition").as_str(), Some("forever" | "classic")) {
		return false;
	}
	let note = c.get("note");
	if !note.is_undef() && !note.is_str() {
		return false;
	}
	let id = c.get("id");
	match c.get("kind").as_str() {
		Some("guide") => c.get("ref").as_str().is_some_and(|r| !r.is_empty()) && id.is_undef(),
		Some("quest" | "npc" | "item" | "object" | "zone" | "spell") => id.is_num() && forge_guide::js::is_integer(id.num()) && id.num() > 0.0 && c.get("ref").is_undef(),
		_ => false,
	}
}

/// Every .guide file under dir, by path (build.js guideTexts).
fn guide_texts(dir: &Path) -> Vec<String> {
	let mut out = Vec::new();
	fn walk(d: &Path, out: &mut Vec<String>) {
		let Ok(rd) = std::fs::read_dir(d) else { return };
		let mut ents: Vec<_> = rd.flatten().collect();
		ents.sort_by(|a, b| forge_guide::js::cmp_utf16(&a.file_name().to_string_lossy(), &b.file_name().to_string_lossy()));
		for e in ents {
			let p = e.path();
			if e.file_type().is_ok_and(|t| t.is_dir()) {
				walk(&p, out);
			} else if e.file_name().to_string_lossy().ends_with(".guide") {
				if let Ok(t) = std::fs::read_to_string(&p) {
					out.push(t);
				}
			}
		}
	}
	walk(dir, &mut out);
	out
}

fn collects_of(text: &str) -> Vec<f64> {
	static RE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"(?mR)^collects\s+(.+)$").unwrap());
	static SPLIT: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"[\s,]+").unwrap());
	match RE.captures(text) {
		Some(m) => SPLIT.split(&m[1]).filter(|id| !id.is_empty() && id.bytes().all(|b| b.is_ascii_digit())).map(forge_guide::js::str_to_num).collect(),
		None => Vec::new(),
	}
}

/// `curatedCollects(dir)`.
fn curated_collects(texts: &[String]) -> Vec<f64> {
	let mut out: Vec<f64> = Vec::new();
	for t in texts {
		for id in collects_of(t) {
			if !out.contains(&id) {
				out.push(id);
			}
		}
	}
	out.sort_by(|a, b| util::by_num(*a, *b));
	out
}

/// `curatedRepGates(dir)`: the vendor gates the guides under `dir` state (in a guide that collects an
/// item, the last `rep` goal before `buy <item> npc <id>`) -> { item: [{ npc, faction, factionName, standing }] }.
pub fn curated_rep_gates_in(dir: &Path) -> V {
	curated_rep_gates(&guide_texts(dir))
}

fn curated_rep_gates(texts: &[String]) -> V {
	static COMMENT: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\s--.*$").unwrap());
	static REP: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"^rep\s+(?:([0-9]+)\s+)?(?:"([^"]+)"\s+)?([A-Za-z]+)$"#).unwrap());
	static BUY: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"^buy\s+([0-9]+)(?-u:\b).*(?-u:\b)npc\s+([0-9]+)").unwrap());
	const STANDINGS: [(&str, f64); 8] = [("hated", 1.0), ("hostile", 2.0), ("unfriendly", 3.0), ("neutral", 4.0), ("friendly", 5.0), ("honored", 6.0), ("revered", 7.0), ("exalted", 8.0)];
	let out = Obj::new();
	for text in texts {
		let collects = collects_of(text);
		if collects.is_empty() {
			continue;
		}
		let mut rep: Option<(V, V, f64)> = None;
		for line in text.split('\n') {
			let line = line.strip_suffix('\r').unwrap_or(line);
			let goal = COMMENT.replace(line, "");
			let goal = goal.trim_matches(util::is_js_space);
			if let Some(r) = REP.captures(goal) {
				let st = STANDINGS.iter().find(|(n, _)| *n == r[3].to_lowercase()).map(|(_, s)| *s);
				if let Some(st) = st {
					if r.get(1).is_some() || r.get(2).is_some() {
						rep = Some((r.get(1).map(|m| V::Num(forge_guide::js::str_to_num(m.as_str()))).unwrap_or(V::Null), r.get(2).map(|m| V::str(m.as_str())).unwrap_or(V::Null), st));
						continue;
					}
				}
			}
			if let (Some(b), Some(rep)) = (BUY.captures(goal), rep.as_ref()) {
				let item = forge_guide::js::str_to_num(&b[1]);
				if collects.contains(&item) {
					let o = Obj::new();
					o.set("npc", forge_guide::js::str_to_num(&b[2]));
					o.set("faction", rep.0.clone());
					o.set("factionName", rep.1.clone());
					o.set("standing", rep.2);
					let l = out.get(&b[1]);
					let l = if l.is_arr() {
						l
					} else {
						let a = V::arr();
						out.set(&b[1], a.clone());
						a
					};
					l.push(V::Obj(o));
				}
			}
		}
	}
	V::Obj(out)
}

/// `loadRepGateTable()`.
fn load_rep_gate_table(file: &Path) -> Result<V, String> {
	let out = Obj::new();
	if !file.exists() {
		return Ok(V::Obj(out));
	}
	let raw = parse_json(&std::fs::read_to_string(file).map_err(|e| e.to_string())?)?;
	let is_int = |v: &V| v.is_num() && forge_guide::js::is_integer(v.num());
	for g in raw.get("gates").items() {
		let npcs = g.get("npcs");
		let quest = g.get("quest");
		let wh = if npcs.is_arr() && !npcs.is_empty() && npcs.items().iter().all(is_int) { !quest.truthy() } else { is_int(&quest) && !npcs.truthy() };
		let st = g.get("standing");
		let src = g.get("source");
		let cited = if let Some(s) = src.as_str() { s.starts_with("https://") } else { is_web_citation(&src) };
		if !is_int(&g.get("item")) || !is_int(&g.get("faction")) || !(st.num() >= 1.0 && st.num() <= 8.0) || !wh || !cited {
			return Err(format!("repgates.json: bad row {}", stringify(&g, None)));
		}
		let k = kstr(&g.get("item"));
		let l = out.get(&k);
		let l = if l.is_arr() {
			l
		} else {
			let a = V::arr();
			out.set(&k, a.clone());
			a
		};
		l.push(g);
	}
	Ok(V::Obj(out))
}

/// `loadInputs(opts)` (a release build, offline).
pub fn load_inputs(opts: &Options, log: &dyn Fn(&str)) -> Result<Inputs, String> {
	let d = &opts.data_dir;
	let j = |f: &str, opt: bool| read_json(&d.join(f), opt, &opts.cwd);
	let forever = Forever {
		items: j("items.json", false)?,
		npcs: j("npcs.json", false)?,
		objects: j("objects.json", false)?,
		quests: j("quests.json", false)?,
		zones: j("zones.json", false)?,
		factions: j("factions.json", false)?,
		professions: or_obj(j("professions.json", true)?),
		trainers: or_obj(j("trainers.json", true)?),
		map_frames: or_obj(j("map-frames.json", true)?),
		meta: or_obj(j("meta.json", true)?),
		instances: or_obj(j("instances.json", true)?),
		dungeons: if opts.local_extras { j("dungeons.json", true)? } else { V::Null },
	};
	// Forever's cached web facts, release builds only.
	let web = if opts.local_extras { None } else { Some(load_web(&opts.sources_dir)?) };
	let mut warnings = Vec::new();
	let (mut atlasloot, mut rarescanner) = (None, None);
	let dir = match &opts.addons {
		Some(p) => p.is_dir().then(|| std::path::absolute(p).unwrap_or_else(|_| p.clone())),
		None => crate::questie::search_addons_dirs().into_iter().next(),
	};
	let mut flbis = None;
	match &dir {
		None => warnings.push(format!("no Forever AddOns folder found (pass --addons): ForeverLevelingBiS{} skipped", if opts.local_extras { ", AtlasLoot and RareScanner" } else { "" })),
		Some(dir) => {
			log(&format!("reading addons in {}", dir.display()));
			if opts.local_extras {
				let al = atlasloot::read_atlasloot(dir)?;
				let rs = rarescanner::read_rarescanner(dir)?;
				for w in al.get("meta").get("warnings").items().into_iter().chain(rs.get("meta").get("warnings").items()) {
					warnings.push(w.to_js_string());
				}
				atlasloot = Some(al);
				rarescanner = Some(rs);
			}
			let flb_dir = dir.join("ForeverLevelingBiS");
			if let Some(refusal) = crate::gear::flb::not_mit_refusal(&flb_dir) {
				return Err(refusal);
			}
			match crate::gear::flb::read_forever_leveling_bis(&flb_dir) {
				Ok(f) => {
					let o = Obj::new();
					o.set("meta", V::Obj(f.meta));
					o.set("items", V::Obj(f.items));
					o.set("quests", V::Obj(f.quests));
					flbis = Some(V::Obj(o));
				}
				Err(e) => warnings.push(e),
			}
		}
	}
	let build = match &opts.build {
		Some(b) => b.clone(),
		None => client::newest_forever_build(&opts.sources_dir, &TABLES)?,
	};
	log(&format!("Forever client build {build}{}", if opts.build.is_some() { " (--build)" } else { "" }));
	let tables = client::load_tables(&opts.sources_dir, &build, &TABLES, &opts.cwd)?;
	let mut cl = client::client_facts(&tables, &build);
	cl.instance_maps = client::instance_maps_of(tables.get("Map").map(Vec::as_slice).unwrap_or(&[]), tables.get("AreaTable").map(Vec::as_slice).unwrap_or(&[]));
	let mut era_maps = None;
	match client::load_tables(&opts.sources_dir, ERA_BUILD, &ERA_TABLES, &opts.cwd) {
		Ok(era) => {
			let era_items = client::client_facts(&era, ERA_BUILD).items;
			let mut filled = 0;
			for (id, mut it) in era_items {
				if cl.items.contains_key(&id) {
					continue;
				}
				it.era = true;
				cl.items.insert(id, it);
				filled += 1;
			}
			cl.era_build = Some(ERA_BUILD.to_string());
			log(&format!("{filled} items only in the Era client tables ({ERA_BUILD})"));
			era_maps = era.get("Map").cloned();
		}
		Err(e) => warnings.push(format!("Era client tables {ERA_BUILD}: {e}")),
	}
	cl.instances = Some(client::instance_facts(&tables, era_maps.as_deref()));
	let guides = opts.root.join("guides");
	let texts = guide_texts(&guides);
	let lib = opts.root.join("data").join("codex");
	let read = |f: &str| std::fs::read_to_string(lib.join(f)).map_err(|e| format!("{}: {e}", lib.join(f).display()));
	let entrance_table = if lib.join("entrances.json").exists() { instances::load_entrance_table(&read("entrances.json")?)? } else { V::obj() };
	let att = parse_json(&read("attunements.json")?)?;
	let attunement_table = Obj::new();
	for k in ["attunements", "inside", "removed"] {
		let v = att.get(k);
		attunement_table.set(k, if v.truthy() { v } else { V::arr() });
	}
	let journal_quests = if lib.join("journal-quests.json").exists() { journal::load_journal_quests(&read("journal-quests.json")?)? } else { Vec::new() };
	Ok(Inputs {
		forever,
		atlasloot,
		rarescanner,
		local_extras: opts.local_extras,
		flbis,
		client: Some(cl),
		web,
		curated: curated_collects(&texts),
		curated_gates: curated_rep_gates(&texts),
		entrances: instances::curated_entrances(&guides),
		entrance_table,
		rep_table: load_rep_gate_table(&lib.join("repgates.json"))?,
		attunement_table: V::Obj(attunement_table),
		journal_quests,
		warnings,
	})
}

fn source(name: &str, version: V, licence: V) -> V {
	let o = Obj::new();
	o.set("name", name);
	o.set("version", version);
	o.set("licence", licence);
	V::Obj(o)
}

fn first_truthy(vals: &[V]) -> V {
	vals.iter().find(|v| v.truthy()).cloned().unwrap_or(V::Null)
}

/// `sourcesMeta(inputs)`.
fn sources_meta(inputs: &Inputs) -> V {
	let mut out = Vec::new();
	for s in inputs.forever.meta.get("sources").items() {
		out.push(source(&s.get("name").to_js_string(), first_truthy(&[s.get("revision"), s.get("version")]), first_truthy(&[s.get("license"), s.get("licence")])));
	}
	for (x, name, licence) in [(&inputs.atlasloot, "AtlasLootClassic", "GPL-2.0"), (&inputs.rarescanner, "RareScanner", "All Rights Reserved"), (&inputs.flbis, "ForeverLevelingBiS", "MIT")] {
		if let Some(x) = x {
			let m = x.get("meta");
			out.push(source(name, first_truthy(&[m.get("version")]), first_truthy(&[m.get("licence"), V::str(licence)])));
		}
	}
	let d = &inputs.forever.dungeons;
	if d.truthy() && d.get("source").truthy() {
		let s = d.get("source");
		let n = s.get("name");
		out.push(source(&format!("dungeons.json ({})", if n.truthy() { n.to_js_string() } else { "DungeonJournal".to_string() }), first_truthy(&[s.get("version")]), V::str("All Rights Reserved")));
	}
	if let Some(wh) = &inputs.web {
		let n = wh.get("npc").len() + wh.get("object").len() + wh.get("item").len();
		let listed = if wh.get("listed").get("npc").truthy() { wh.get("listed").get("npc").len() } else { 0 };
		if n > 0 || listed > 0 {
			out.push(source(
				&format!("The web quest database's Forever pages: NPC and object pages, item tooltips{}", if listed > 0 { ", NPC list levels" } else { "" }),
				V::str(&format!("{n} entities{}; cache data/sources/web/codex", if listed > 0 { format!(", {listed} listed NPCs") } else { String::new() })),
				V::str("Public web pages; facts only (levels, classification, positions, drop counts, requirements)"),
			));
		}
	}
	let ne = inputs.entrance_table.len();
	if ne > 0 && inputs.atlasloot.is_none() {
		out.push(source(
			"Curated instance entrances (data/codex/entrances.json): QuestieDB Forever dungeon table, warcraft.wiki.gg, the web quest database (Forever pages)",
			V::str(&format!("{ne} entrances")),
			V::str("Facts only (coordinates), each entry with its source"),
		));
	}
	let nr = inputs.rep_table.len();
	if nr > 0 {
		out.push(source(
			"Curated reputation gates (data/codex/repgates.json): warcraft.wiki.gg, the web quest database's Classic reputation guides, QuestieDB",
			V::str(&format!("{nr} items")),
			V::str("Facts only (standings), each row with its source"),
		));
	}
	let na = inputs.attunement_table.get("attunements").len();
	if na > 0 {
		out.push(source(
			"Curated attunement goals (data/codex/attunements.json): the web quest database (Forever pages), warcraft.wiki.gg",
			V::str(&format!("{na} attunements")),
			V::str("Facts only (quest and item ids), each entry with its sources"),
		));
	}
	let nj = inputs.journal_quests.len();
	if nj > 0 {
		out.push(source(
			"Curated Dungeons journal quests (data/codex/journal-quests.json): the web quest database (Forever pages)",
			V::str(&format!("{nj} quests")),
			V::str("Facts only (quest ids and instances), each row with its source"),
		));
	}
	if let Some(cl) = &inputs.client {
		out.push(source("World of Warcraft: Forever client tables via wago.tools", V::str(&cl.build), V::str("Blizzard Entertainment game data, facts only")));
		if let Some(eb) = &cl.era_build {
			out.push(source(
				"World of Warcraft Classic Era client item tables via wago.tools (items missing from the Forever tables)",
				V::str(eb),
				V::str("Blizzard Entertainment game data, facts only"),
			));
		}
	}
	V::from(out)
}

/// `summarize(codex)` -> (counts, coverage).
fn summarize(m: &merge::Merged) -> (V, V) {
	let names = ["item", "mount", "pet", "recipe", "tabard", "npc", "rare", "quest", "zone", "instance", "treasure", "object"];
	let mut counts = [0usize; 12];
	let ix = |n: &str| names.iter().position(|x| *x == n).unwrap();
	let mut with_source = 0;
	let items = m.items.values();
	for it in &items {
		counts[ix(&it.get("kind").to_js_string())] += 1;
		if !it.get("sources").items().is_empty() {
			with_source += 1;
		}
	}
	for n in m.npcs.values() {
		counts[ix(if n.get("rare").truthy() { "rare" } else { "npc" })] += 1;
	}
	for o in m.objects.values() {
		counts[ix(if o.get("treasure").truthy() { "treasure" } else { "object" })] += 1;
	}
	counts[ix("quest")] = m.quests.len();
	counts[ix("zone")] = m.zones.len();
	counts[ix("instance")] = m.instances.len();
	let c = Obj::new();
	for (i, n) in names.iter().enumerate() {
		c.set(n, counts[i]);
	}
	let cov = Obj::new();
	cov.set("items", items.len());
	cov.set("withSource", with_source);
	cov.set("share", if items.is_empty() { 0.0 } else { util::math_round((with_source as f64 / items.len() as f64) * 1000.0) / 1000.0 });
	(V::Obj(c), V::Obj(cov))
}

fn package_version(root: &Path) -> String {
	std::fs::read_to_string(root.join("package.json")).ok().and_then(|t| parse_json(&t).ok()).map(|v| v.get("version")).filter(V::truthy).map(|v| v.to_js_string()).unwrap_or_else(|| "0.0.0".into())
}

/// `buildCodex(opts)`: every output file's text (nothing is written).
pub fn build(opts: &Options) -> Result<Output, String> {
	build_logged(opts, &|_| {})
}

pub fn build_logged(opts: &Options, log: &dyn Fn(&str)) -> Result<Output, String> {
	let t0 = Instant::now();
	let inputs = load_inputs(opts, log)?;
	build_from(opts, &inputs, t0, log)
}

/// `buildCodex({ inputs })`: the build over inputs already loaded (no comparison with another build:
/// `opts.parity_against` is not read).
pub fn build_inputs(opts: &Options, inputs: &Inputs) -> Result<Output, String> {
	let opts = Options { parity_against: None, ..opts.clone() };
	build_from(&opts, inputs, Instant::now(), &|_| {})
}

fn build_from(opts: &Options, inputs: &Inputs, t0: Instant, log: &dyn Fn(&str)) -> Result<Output, String> {
	log("merging");
	let m = merge::merge_codex(inputs);
	let (counts, coverage) = summarize(&m);
	let cl = inputs.client.as_ref();
	let meta = Obj::new();
	meta.set("schema", pack::SCHEMA);
	let built_at = opts.built_at.clone().map(|s| V::str(&s)).unwrap_or_else(|| {
		let b = inputs.forever.meta.get("builtAt");
		if b.truthy() {
			b
		} else {
			V::Null
		}
	});
	meta.set("builtAt", built_at);
	meta.set("build", cl.map(|c| V::str(&c.build)).unwrap_or(V::Null));
	// A --local-extras build (AtlasLoot, RareScanner, DungeonJournal): never released.
	let local_extras = inputs.local_extras || inputs.atlasloot.is_some() || inputs.rarescanner.is_some() || inputs.forever.dungeons.truthy();
	meta.set("localExtras", local_extras);
	meta.set("sources", sources_meta(inputs));
	meta.set("counts", counts);
	meta.set("coverage", coverage);
	meta.set("pack", V::Null);
	let version = opts.version.clone().unwrap_or_else(|| package_version(&opts.root));

	let jc = journal::Codex {
		instances: V::Obj(m.instances.clone()),
		quests: V::Obj(m.quests.clone()),
		npcs: V::Obj(m.npcs.clone()),
		items: V::Obj(m.items.clone()),
		objects: V::Obj(m.objects.clone()),
		factions: V::Obj(m.factions.clone()),
		zones: V::Obj(m.zones.clone()),
	};
	let frames_forever = {
		let f = inputs.forever.map_frames.get("forever");
		if f.truthy() {
			f
		} else {
			V::obj()
		}
	};
	let (journal, journal_warnings) = journal::build_journal(
		&journal::JournalInputs {
			maps: cl.map(|c| c.instance_maps.as_slice()).unwrap_or(&[]),
			frames: &frames_forever,
			fv_quests: &inputs.forever.quests,
			fv_objects: &inputs.forever.objects,
			fv_zones: &inputs.forever.zones,
			fv_dungeons: &inputs.forever.dungeons,
			journal_quests: &inputs.journal_quests,
			attunement_table: &inputs.attunement_table,
		},
		&jc,
	);
	let extra = vec![("Dungeons1.lua".to_string(), journal::emit_journal(&journal))];

	let mut report = Vec::new();
	if let Some(against) = opts.parity_against.as_ref().filter(|a| !local_extras && a.join("meta.json").exists()) {
		let theirs = parity::read_codex(against)?;
		let web = inputs.web.clone().unwrap_or_else(|| {
			let o = Obj::new();
			for k in ["npc", "object", "item"] {
				o.set(k, V::obj());
			}
			V::Obj(o)
		});
		let verify = parity::Verify {
			web,
			client_instances: cl.map(|c| c.instance_maps.iter().map(|mm| norm_verify(&mm.name)).collect()).unwrap_or_default(),
			instance_areas: cl.map(|c| c.instance_maps.iter().flat_map(|mm| mm.inner.iter().map(|a| *a as i64)).collect()),
		};
		let summary = parity::compare_summary(
			&parity::Ours {
				instances: &jc.instances,
				items: &jc.items,
				npcs: &jc.npcs,
				objects: &jc.objects,
				journal: &journal,
				no_pvp: &m.no_pvp,
				cut_drop: &V::Obj(m.cut_drop.clone()),
				cut_rare: &V::Obj(m.cut_rare.clone()),
				cut_treasure: &V::Obj(m.cut_treasure.clone()),
			},
			&theirs,
			Some(&verify),
		);
		meta.set("parity", summary);
	}
	let meta_v = V::Obj(meta.clone());
	let pack_files = pack::emit_pack(
		&pack::PackCodex {
			items: &jc.items,
			npcs: &jc.npcs,
			objects: &jc.objects,
			quests: &jc.quests,
			instances: &jc.instances,
			zones: &jc.zones,
			factions: &jc.factions,
			spells: &V::Obj(m.spells.clone()),
			meta: &meta_v,
			frames: &V::Obj(m.frames.clone()),
		},
		&version,
		&meta.get("build"),
		&extra,
	)?;
	let bytes: usize = pack_files.iter().map(|(_, t)| t.len()).sum();
	let mem = if opts.measure {
		log("measuring pack memory");
		let order = pack::pack_order(&pack_files);
		Some(memory::measure(&opts.root.join("addon").join("Polestar").join("Lookup").join("Codex.lua"), &order, &pack_files)?)
	} else {
		None
	};
	let p = Obj::new();
	p.set("files", pack_files.len());
	p.set("bytes", bytes);
	p.set("memoryKB", mem.as_ref().map(|m| V::Num(m.raw_kb)).unwrap_or(V::Null));
	p.set("memoryKBDecoded", mem.as_ref().map(|m| V::Num(m.decoded_kb)).unwrap_or(V::Null));
	p.set("loadMs", mem.as_ref().map(|m| V::Num(opts.load_ms.unwrap_or(m.load_ms))).unwrap_or(V::Null));
	meta.set("pack", V::Obj(p));

	let outs: [(&str, V); 11] = [
		("meta", meta_v.clone()),
		("items", jc.items.clone()),
		("npcs", jc.npcs.clone()),
		("objects", jc.objects.clone()),
		("quests", jc.quests.clone()),
		("instances", jc.instances.clone()),
		("zones", jc.zones.clone()),
		("factions", jc.factions.clone()),
		("spells", V::Obj(m.spells.clone())),
		("frames", V::Obj(m.frames.clone())),
		("journal", journal.clone()),
	];
	let json: Vec<(String, String)> = outs.iter().map(|(n, v)| (format!("{n}.json"), format!("{}\n", stringify(&sort_keys_deep(v), Some("\t"))))).collect();

	let mut warnings = inputs.warnings.clone();
	warnings.extend(m.warnings.iter().cloned());
	warnings.extend(journal_warnings);

	// The command's report (tools/commands/codex.js runBuild).
	let ms = t0.elapsed().as_secs_f64() * 1000.0;
	report.push(format!("built the Codex (client build {}) in {} s", meta.get("build").to_js_string(), forge_guide::js::to_fixed(ms / 1000.0, 1)));
	report.push(format!("counts: {}", meta.get("counts").as_obj().map(|c| c.entries().iter().map(|(k, n)| format!("{} {k}", n.to_js_string())).collect::<Vec<_>>().join(", ")).unwrap_or_default()));
	let c = meta.get("coverage");
	report.push(format!("coverage: {} of {} items have a source ({}%)", c.get("withSource").to_js_string(), c.get("items").to_js_string(), forge_guide::js::to_fixed(c.get("share").num() * 100.0, 1)));
	let kb = |n: f64| format!("{} KiB", forge_guide::js::to_fixed(n / 1024.0, 0));
	let memtxt = match &mem {
		None => "not measured".to_string(),
		Some(mm) => format!(
			"{} KiB loaded in {} ms (lua5.1), {} KiB with every record decoded",
			forge_guide::js::to_fixed(mm.raw_kb, 0),
			forge_guide::js::to_fixed(mm.load_ms, 0),
			forge_guide::js::to_fixed(mm.decoded_kb, 0)
		),
	};
	report.push(format!("pack: {} files, {}; memory {memtxt}", pack_files.len(), kb(bytes as f64)));
	if local_extras {
		report.push("local build (--local-extras): not for release; `pack` refuses it".to_string());
	}
	report.push(format!(
		"sources: {}",
		meta.get("sources")
			.items()
			.iter()
			.map(|s| format!("{}{}", s.get("name").to_js_string(), if s.get("version").truthy() { format!(" {}", s.get("version").to_js_string()) } else { String::new() }))
			.collect::<Vec<_>>()
			.join("; ")
	));
	Ok(Output { json, pack: pack_files, meta: meta_v, warnings, report })
}

/// build.js verifyOf's `norm`.
fn norm_verify(s: &str) -> String {
	let l = s.to_lowercase();
	let l = match l.strip_prefix("the") {
		Some(r) if r.starts_with(char::is_whitespace) => r.trim_start().to_string(),
		_ => l,
	};
	l.chars().filter(|c| c.is_ascii_lowercase() || c.is_ascii_digit()).collect()
}

/// Writes the JSON files into `out_dir` and replaces `pack_dir` as a whole (written beside it, then
/// swapped in), as build.js writeAtomic / writePackDir do.
pub fn write(out: &Output, out_dir: &Path, pack_dir: &Path) -> Result<(), String> {
	let err = |e: std::io::Error| e.to_string();
	let pid = std::process::id();
	let tmp = PathBuf::from(format!("{}.tmp-{pid}", pack_dir.display()));
	let _ = std::fs::remove_dir_all(&tmp);
	std::fs::create_dir_all(&tmp).map_err(err)?;
	for (rel, text) in &out.pack {
		std::fs::write(tmp.join(rel), text).map_err(err)?;
	}
	let old = PathBuf::from(format!("{}.old-{pid}", pack_dir.display()));
	if pack_dir.exists() {
		std::fs::rename(pack_dir, &old).map_err(err)?;
	}
	std::fs::rename(&tmp, pack_dir).map_err(err)?;
	let _ = std::fs::remove_dir_all(&old);
	std::fs::create_dir_all(out_dir).map_err(err)?;
	for (name, text) in &out.json {
		let file = out_dir.join(name);
		let t = PathBuf::from(format!("{}.tmp", file.display()));
		std::fs::write(&t, text).map_err(err)?;
		std::fs::rename(&t, &file).map_err(err)?;
	}
	Ok(())
}
