//! `forge data talents build|check` (port of tools/lib/talents/build.js and commands/talents.js):
//! the talent plans in talents/forever/<class>.json (picks by talent name, one per level) resolved
//! against the Forever client's trait tables, replayed point by point under the client's rules,
//! and written as addon/Polestar/Talents/Builds.lua with a snapshot of each tree.
//!
//! Forever's three-column trees are one C_Traits tree per class:
//!   SkillLineXTraitTree  SkillLineID (class skill line) -> TraitTreeID
//!   TraitNode            ID, TraitTreeID, PosX, PosY (columns by PosX, rows by PosY)
//!   TraitNodeXTraitNodeEntry -> TraitNodeEntry (MaxRanks, TraitDefinitionID)
//!   TraitDefinition      SpellID (name from SpellName)
//!   TraitNodeGroupXTraitNode, TraitNodeGroupXTraitCond -> TraitCond: a node group gated on
//!                        points spent (CondType 0, SpentAmountRequired) in TraitNodeGroupID
//!   TraitEdge            LeftTraitNodeID -> RightTraitNodeID (an arrow); Type 0 is drawn only
//!                        (VisualOnly); of several arrows into one talent, any one will do

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use forge_guide::js::V;
use rustc_hash::FxHashMap;

use crate::jsv::{col_num, col_str, Rows};

/// The Forever client build the trees are read from. Raise it, rebuild, and review the diff when
/// the client's talents change.
pub const BUILD: &str = "1.60.1.70450";
/// Whether an arrow needs the talent before it at full rank ("full") or one rank ("started").
pub const PREREQ_RULE: &str = "full";
pub const COMMAND: &str = "forge data talents build";

pub const TABLES: [&str; 10] = [
	"SkillLineXTraitTree",
	"TraitNode",
	"TraitNodeEntry",
	"TraitDefinition",
	"TraitNodeXTraitNodeEntry",
	"TraitNodeGroupXTraitNode",
	"TraitNodeGroupXTraitCond",
	"TraitCond",
	"TraitEdge",
	"SpellName",
];

/// Each class's tree, by its class skill line (SkillLineXTraitTree).
const CLASSES: [(&str, i64); 9] = [("DRUID", 574), ("HUNTER", 50), ("MAGE", 237), ("PALADIN", 184), ("PRIEST", 613), ("ROGUE", 38), ("SHAMAN", 373), ("WARLOCK", 354), ("WARRIOR", 26)];
const FIRST_LEVEL: i64 = 10;
/// PosX distance that separates two spec columns.
const COLUMN_GAP: f64 = 1200.0;
/// PosX (or PosY) within this is one column (or row) of a spec.
const SAME_X: f64 = 100.0;
const VISUAL_ONLY: f64 = 0.0;
const REQUIRED: f64 = 3.0;
/// A stray copy of a talent sits more than this many times the tree's furthest PosX or PosY out.
const STRAY_FAR: f64 = 2.0;

/// `Number(v) || 0`.
fn num(r: &crate::jsv::Row, c: &str) -> f64 {
	let n = col_num(r, c);
	if n.is_nan() {
		0.0
	} else {
		n
	}
}

pub type Tables = FxHashMap<String, Rows>;

#[derive(Clone)]
pub struct Node {
	pub entry: f64,
	pub max: f64,
	pub spell: f64,
	pub name: String,
	pub x: f64,
	pub y: f64,
	pub spec: usize,
	pub row: usize,
	pub col: usize,
}

#[derive(Clone, Copy)]
pub struct Gate {
	pub group: f64,
	pub need: f64,
}

pub struct Facts {
	pub tree: f64,
	pub strays: Vec<i64>,
	pub nodes: BTreeMap<i64, Node>,
	pub specs: Vec<Vec<i64>>,
	pub groups: BTreeMap<i64, Vec<i64>>,
	pub gates: BTreeMap<i64, Vec<Gate>>,
	/// (from, to), sorted by to then from.
	pub edges: Vec<(i64, i64)>,
}

fn strays(nodes: &BTreeMap<i64, Node>) -> Vec<i64> {
	let mut by_spell: FxHashMap<u64, usize> = FxHashMap::default();
	for n in nodes.values() {
		*by_spell.entry(n.spell.to_bits()).or_default() += 1;
	}
	let mut out = Vec::new();
	for (&id, n) in nodes {
		if n.spell == 0.0 || by_spell[&n.spell.to_bits()] < 2 {
			continue;
		}
		let others = nodes.iter().filter(|(o, _)| **o != id).map(|(_, o)| o);
		let max_x = others.clone().map(|o| o.x).fold(f64::NEG_INFINITY, f64::max);
		let max_y = others.map(|o| o.y).fold(f64::NEG_INFINITY, f64::max);
		if n.x > STRAY_FAR * max_x || n.y > STRAY_FAR * max_y {
			out.push(id);
		}
	}
	out
}

/// Sorted distinct values, a new cluster wherever the gap exceeds `gap`.
fn clusters(values: impl Iterator<Item = f64>, gap: f64) -> Vec<Vec<f64>> {
	let mut v: Vec<f64> = values.collect();
	v.sort_by(f64::total_cmp);
	v.dedup();
	let mut out: Vec<Vec<f64>> = Vec::new();
	for x in v {
		match out.last_mut() {
			Some(last) if x - last[last.len() - 1] <= gap => last.push(x),
			_ => out.push(vec![x]),
		}
	}
	out
}

pub fn tree_facts(t: &Tables, cls: &str) -> Result<Facts, String> {
	let rows = |n: &str| t.get(n).map(Vec::as_slice).unwrap_or(&[]);
	let skill = CLASSES.iter().find(|c| c.0 == cls).ok_or_else(|| format!("talents: no tree known for class {cls}"))?.1;
	let link = rows("SkillLineXTraitTree").iter().find(|r| num(r, "SkillLineID") == skill as f64).ok_or_else(|| format!("talents: no TraitTree for skill line {skill}"))?;
	let tree = num(link, "TraitTreeID");
	let mut spells: FxHashMap<u64, &str> = FxHashMap::default();
	for r in rows("SpellName") {
		spells.insert(num(r, "ID").to_bits(), col_str(r, "Name_lang"));
	}
	let defs: FxHashMap<u64, &crate::jsv::Row> = rows("TraitDefinition").iter().map(|r| (num(r, "ID").to_bits(), r)).collect();
	let entries: FxHashMap<u64, &crate::jsv::Row> = rows("TraitNodeEntry").iter().map(|r| (num(r, "ID").to_bits(), r)).collect();
	let mut entry_of: FxHashMap<u64, f64> = FxHashMap::default();
	for r in rows("TraitNodeXTraitNodeEntry") {
		let k = num(r, "TraitNodeID").to_bits();
		if !entry_of.contains_key(&k) || num(r, "_Index") == 0.0 {
			entry_of.insert(k, num(r, "TraitNodeEntryID"));
		}
	}
	let mut nodes: BTreeMap<i64, Node> = BTreeMap::new();
	for r in rows("TraitNode").iter().filter(|r| num(r, "TraitTreeID") == tree) {
		let id = num(r, "ID");
		let Some(entry) = entry_of.get(&id.to_bits()).and_then(|e| entries.get(&e.to_bits())) else { continue };
		let def = defs.get(&num(entry, "TraitDefinitionID").to_bits());
		let spell = def.map(|d| num(d, "SpellID")).unwrap_or(0.0);
		let name = def.map(|d| col_str(d, "OverrideName_lang")).filter(|s| !s.is_empty()).or_else(|| spells.get(&spell.to_bits()).copied()).unwrap_or("");
		nodes.insert(id as i64, Node { entry: num(entry, "ID"), max: num(entry, "MaxRanks"), spell, name: name.to_string(), x: num(r, "PosX"), y: num(r, "PosY"), spec: 0, row: 0, col: 0 });
	}
	let dropped = strays(&nodes);
	for id in &dropped {
		nodes.remove(id);
	}
	let spec_cols = clusters(nodes.values().map(|n| n.x), COLUMN_GAP);
	// PosY a few units apart (Warlock's 2120 and 2130) is one row.
	let row_groups = clusters(nodes.values().map(|n| n.y), SAME_X);
	let mut specs: Vec<Vec<i64>> = vec![Vec::new(); spec_cols.len()];
	for (&id, n) in nodes.iter_mut() {
		let s = spec_cols.iter().position(|c| c.contains(&n.x)).unwrap_or(0);
		let cols = clusters(spec_cols[s].iter().copied(), SAME_X);
		n.spec = s + 1;
		n.row = row_groups.iter().position(|r| r.contains(&n.y)).map_or(0, |i| i + 1);
		n.col = cols.iter().position(|c| c.contains(&n.x)).map_or(0, |i| i + 1);
		specs[s].push(id);
	}
	// Gates: a node in a gated group needs points spent in the counted group.
	let conds: FxHashMap<u64, &crate::jsv::Row> = rows("TraitCond").iter().filter(|r| num(r, "CondType") == 0.0 && num(r, "SpentAmountRequired") > 0.0).map(|r| (num(r, "ID").to_bits(), r)).collect();
	let mut conds_of: FxHashMap<u64, Vec<Gate>> = FxHashMap::default();
	for r in rows("TraitNodeGroupXTraitCond") {
		let Some(c) = conds.get(&num(r, "TraitCondID").to_bits()) else { continue };
		conds_of.entry(num(r, "TraitNodeGroupID").to_bits()).or_default().push(Gate { group: num(c, "TraitNodeGroupID"), need: num(c, "SpentAmountRequired") });
	}
	let mut members: FxHashMap<u64, Vec<i64>> = FxHashMap::default();
	let mut gates: BTreeMap<i64, Vec<Gate>> = BTreeMap::new();
	for r in rows("TraitNodeGroupXTraitNode") {
		let id = num(r, "TraitNodeID") as i64;
		let g = num(r, "TraitNodeGroupID");
		if !nodes.contains_key(&id) {
			continue;
		}
		members.entry(g.to_bits()).or_default().push(id);
		for gate in conds_of.get(&g.to_bits()).into_iter().flatten() {
			gates.entry(id).or_default().push(*gate);
		}
	}
	let mut groups: BTreeMap<i64, Vec<i64>> = BTreeMap::new();
	for list in gates.values() {
		for g in list {
			let mut m = members.get(&g.group.to_bits()).cloned().unwrap_or_default();
			m.sort();
			groups.insert(g.group as i64, m);
		}
	}
	for list in gates.values_mut() {
		list.sort_by(|a, b| a.need.total_cmp(&b.need).then(a.group.total_cmp(&b.group)));
	}
	let mut edges: Vec<(i64, i64, f64)> = rows("TraitEdge")
		.iter()
		.filter(|r| num(r, "Type") != VISUAL_ONLY && nodes.contains_key(&(num(r, "LeftTraitNodeID") as i64)) && nodes.contains_key(&(num(r, "RightTraitNodeID") as i64)))
		.map(|r| (num(r, "LeftTraitNodeID") as i64, num(r, "RightTraitNodeID") as i64, num(r, "Type")))
		.collect();
	edges.sort_by(|a, b| a.1.cmp(&b.1).then(a.0.cmp(&b.0)));
	// A Required arrow must be met whatever else leads in; the replay knows only "any one arrow".
	for (i, e) in edges.iter().enumerate() {
		if e.2 == REQUIRED && edges.iter().enumerate().any(|(j, o)| j != i && o.1 == e.1) {
			return Err(format!("talents: node {} has a Required arrow beside others, which the replay does not model", e.1));
		}
	}
	Ok(Facts { tree, strays: dropped, nodes, specs, groups, gates, edges: edges.into_iter().map(|e| (e.0, e.1)).collect() })
}

pub struct Pick {
	pub level: i64,
	pub node: i64,
	pub rank: i64,
}

pub struct Build {
	pub key: String,
	pub spec: String,
	pub split: String,
	pub link: String,
	pub picks: Vec<Pick>,
	pub notes: BTreeMap<i64, String>,
}

/// A plan's picks by name -> node ids.
fn resolve_build(f: &Facts, order: &[String], b: &V) -> (Vec<Pick>, BTreeMap<i64, String>, Vec<String>) {
	let mut errors = Vec::new();
	let mut picks = Vec::new();
	let mut notes = BTreeMap::new();
	for (i, p) in b.get("picks").items().iter().enumerate() {
		let (tree, talent) = (p.get("tree").to_js_string(), p.get("talent").to_js_string());
		let where_ = format!("{} pick {} (level {}, {talent})", b.get("key").to_js_string(), i + 1, p.get("level").to_js_string());
		let Some(spec) = order.iter().position(|o| *o == tree) else {
			errors.push(format!("{where_}: unknown tree \"{tree}\""));
			continue;
		};
		let hits: Vec<i64> = f.specs[spec].iter().copied().filter(|id| f.nodes[id].name == talent).collect();
		if hits.len() != 1 {
			errors.push(format!("{where_}: {} {tree} talent named \"{talent}\"", if hits.is_empty() { "no" } else { "more than one" }));
			continue;
		}
		let level = p.get("level").num() as i64;
		picks.push(Pick { level, node: hits[0], rank: p.get("rank").num() as i64 });
		if p.get("note").truthy() {
			notes.insert(level, p.get("note").to_js_string());
		}
	}
	(picks, notes, errors)
}

fn fmt(n: f64) -> String {
	forge_guide::js::num_str(n)
}

/// Every pick under the client's rules: one point per level from 10, the next rank of its talent,
/// the tier gate met and an arrow into it satisfied.
pub fn replay(f: &Facts, picks: &[Pick], prereq: &str) -> Vec<String> {
	let mut errors = Vec::new();
	let mut ranks: FxHashMap<i64, i64> = FxHashMap::default();
	for (i, p) in picks.iter().enumerate() {
		let Some(n) = f.nodes.get(&p.node) else {
			errors.push(format!("pick {} (level {}, {}): node {} is not in tree {}", i + 1, p.level, p.node, p.node, fmt(f.tree)));
			continue;
		};
		let where_ = format!("pick {} (level {}, {})", i + 1, p.level, n.name);
		if p.level != FIRST_LEVEL + i as i64 {
			errors.push(format!("{where_}: expected level {}", FIRST_LEVEL + i as i64));
		}
		let have = ranks.get(&p.node).copied().unwrap_or(0);
		if p.rank != have + 1 {
			errors.push(format!("{where_}: rank {} after {have}", p.rank));
		}
		if p.rank as f64 > n.max {
			errors.push(format!("{where_}: rank {} of {}", p.rank, fmt(n.max)));
		}
		let spent = |g: f64| -> i64 { f.groups.get(&(g as i64)).into_iter().flatten().map(|id| ranks.get(id).copied().unwrap_or(0)).sum() };
		for g in f.gates.get(&p.node).into_iter().flatten() {
			if (spent(g.group) as f64) < g.need {
				errors.push(format!("{where_}: needs {} points in its tree, has {}", fmt(g.need), spent(g.group)));
			}
		}
		let into: Vec<&(i64, i64)> = f.edges.iter().filter(|e| e.1 == p.node).collect();
		let need = |e: &(i64, i64)| if prereq == "full" { f.nodes[&e.0].max } else { 1.0 };
		if !into.is_empty() && !into.iter().any(|e| ranks.get(&e.0).copied().unwrap_or(0) as f64 >= need(e)) {
			let list: Vec<String> = into.iter().map(|e| format!("{} {}/{}", f.nodes[&e.0].name, fmt(need(e)), fmt(f.nodes[&e.0].max))).collect();
			errors.push(format!("{where_}: needs {}", list.join(" or ")));
		}
		ranks.insert(p.node, p.rank);
	}
	errors
}

fn lua_str(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n"))
}

/// One class's T.Register({ ... }) call. The summary and the per-level notes are literal L["..."]
/// keys, so `i18n keys` lists them.
fn emit_register(f: &Facts, source: &V, order: &[String], builds: &[Build], prereq: &str) -> Vec<String> {
	let s = |k: &str| lua_str(&source.get(k).to_js_string());
	let mut l = vec!["T.Register({".to_string()];
	l.push(format!("\tclass = {}, tree = {}, prereq = {},", s("class"), fmt(f.tree), lua_str(prereq)));
	l.push(format!("\tsource = L[{}], url = {},", s("source"), s("sourceUrl")));
	l.push(format!("\tsummary = L[{}],", s("summary")));
	l.push(format!("\tspecs = {{ {} }},", order.iter().map(|o| lua_str(o)).collect::<Vec<_>>().join(", ")));
	l.push("\t-- node = { entry, max ranks, spell, spec column, row, column, name }".into());
	l.push("\tnodes = {".into());
	for (id, n) in &f.nodes {
		l.push(format!("\t\t[{id}] = {{ {}, {}, {}, {}, {}, {}, {} }},", fmt(n.entry), fmt(n.max), fmt(n.spell), n.spec, n.row, n.col, lua_str(&n.name)));
	}
	l.push("\t},".into());
	l.push("\t-- node = { { counted group, points }, ... }".into());
	l.push("\tgates = {".into());
	for (id, gs) in &f.gates {
		l.push(format!("\t\t[{id}] = {{ {} }},", gs.iter().map(|g| format!("{{ {}, {} }}", fmt(g.group), fmt(g.need))).collect::<Vec<_>>().join(", ")));
	}
	l.push("\t},".into());
	l.push("\tgroups = {".into());
	for (g, m) in &f.groups {
		l.push(format!("\t\t[{g}] = {{ {} }},", m.iter().map(i64::to_string).collect::<Vec<_>>().join(", ")));
	}
	l.push("\t},".into());
	l.push("\t-- { from, to }: the arrow's target needs its source first".into());
	l.push(format!("\tedges = {{ {} }},", f.edges.iter().map(|e| format!("{{ {}, {} }}", e.0, e.1)).collect::<Vec<_>>().join(", ")));
	l.push("\tbuilds = {".into());
	for b in builds {
		l.push("\t\t{".into());
		let spec = order.iter().position(|o| *o == b.spec).map_or(0, |i| i + 1);
		l.push(format!("\t\t\tkey = {}, spec = {spec}, split = {}, link = {},", lua_str(&b.key), lua_str(&b.split), lua_str(&b.link)));
		l.push("\t\t\t-- in order, one point each: { node, rank }".into());
		l.push("\t\t\tpicks = {".into());
		for chunk in b.picks.chunks(6) {
			l.push(format!("\t\t\t\t{}", chunk.iter().map(|p| format!("{{ {}, {} }},", p.node, p.rank)).collect::<Vec<_>>().join(" ")));
		}
		l.push("\t\t\t},".into());
		l.push("\t\t\tnotes = {".into());
		for (lv, note) in &b.notes {
			l.push(format!("\t\t\t\t[{lv}] = L[{}],", lua_str(note)));
		}
		l.push("\t\t\t},".into());
		l.push("\t\t},".into());
	}
	l.push("\t},".into());
	l.push("})".into());
	l
}

pub struct ClassResult {
	pub class: String,
	pub facts: Facts,
	pub builds: Vec<Build>,
}

pub struct Output {
	pub lua: String,
	pub errors: Vec<String>,
	pub results: Vec<ClassResult>,
}

/// Several classes' plans -> one Builds.lua, sorted by class (one plan file per class).
pub fn build_all(sources: &[V], t: &Tables, header: &str, prereq: &str) -> Result<Output, String> {
	let mut sorted: Vec<&V> = sources.iter().collect();
	sorted.sort_by(|a, b| forge_guide::js::cmp_utf16(&a.get("class").to_js_string(), &b.get("class").to_js_string()));
	let mut errors = Vec::new();
	let mut seen: Vec<String> = Vec::new();
	let mut results = Vec::new();
	let mut l = vec![header.to_string(), String::new(), "local ADDON, ns = ...".into(), "local T = ns.Talents".into(), "local L = ns.L".into()];
	for source in sorted {
		let class = source.get("class").to_js_string();
		if seen.contains(&class) {
			errors.push(format!("{class}: more than one plan file"));
			continue;
		}
		seen.push(class.clone());
		let facts = tree_facts(t, &class)?;
		let order: Vec<String> = source.get("order").items().iter().map(V::to_js_string).collect();
		let mut builds = Vec::new();
		for b in source.get("builds").items() {
			let (picks, notes, errs) = resolve_build(&facts, &order, &b);
			let key = b.get("key").to_js_string();
			if errs.is_empty() {
				errors.extend(replay(&facts, &picks, prereq).into_iter().map(|e| format!("{class} {key} {e}")));
			} else {
				errors.extend(errs.into_iter().map(|e| format!("{class} {e}")));
			}
			builds.push(Build { key, spec: b.get("spec").to_js_string(), split: b.get("split").to_js_string(), link: b.get("link").to_js_string(), picks, notes });
		}
		l.push(String::new());
		l.extend(emit_register(&facts, source, &order, &builds, prereq));
		results.push(ClassResult { class, facts, builds });
	}
	l.push(String::new());
	Ok(Output { lua: l.join("\n"), errors, results })
}

pub struct Options {
	pub plans: PathBuf,
	pub out: PathBuf,
	pub sources: PathBuf,
	pub build: String,
	pub offline: bool,
}

impl Options {
	pub fn new(root: &Path) -> Options {
		Options {
			plans: root.join("talents").join("forever"),
			out: root.join("addon").join("Polestar").join("Talents"),
			sources: root.join("data").join("sources"),
			build: BUILD.to_string(),
			offline: false,
		}
	}
}

/// Reads the plans and the trait tables and builds Builds.lua. -> (output, table warnings)
pub fn run(o: &Options, log: &dyn Fn(&str)) -> Result<(Output, Vec<String>), String> {
	let mut files: Vec<String> =
		std::fs::read_dir(&o.plans).map_err(|e| format!("{}: {e}", o.plans.display()))?.flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|f| f.ends_with(".json")).collect();
	files.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
	if files.is_empty() {
		return Err(format!("no plan files in {}", o.plans.display()));
	}
	let mut plans = Vec::new();
	for f in &files {
		let p = o.plans.join(f);
		let text = std::fs::read_to_string(&p).map_err(|e| format!("{}: {e}", p.display()))?;
		plans.push(forge_guide::js::parse_json(&text).map_err(|e| format!("{}: {e}", p.display()))?);
	}
	let from = if files.len() == 1 {
		format!("talents/forever/{}", files[0])
	} else {
		format!("talents/forever/{{{}}}.json", files.iter().map(|f| f.trim_end_matches(".json")).collect::<Vec<_>>().join(","))
	};
	let (_, tables, warnings) = crate::sources::client_tables(&o.sources, &crate::tables::ERA, Some(&o.build), &TABLES, o.offline, log)?;
	let t: Tables = tables.into_iter().collect();
	let header = forge_guide::emit::header("lua", COMMAND, &format!("{from} and the Forever {} trait tables (wago.tools)", o.build));
	Ok((build_all(&plans, &t, &header, PREREQ_RULE)?, warnings))
}

#[cfg(test)]
mod tests {
	use super::*;

	fn rows(header: &str, lines: &[&str]) -> Rows {
		crate::tables::parse_csv(&format!("{header}\n{}\n", lines.join("\n"))).unwrap()
	}

	/// A two-column Druid tree: 1 -> 2 (arrow), 3 gated on 5 points in group 7, a stray copy of 1.
	fn tables() -> Tables {
		let mut t = Tables::default();
		t.insert("SkillLineXTraitTree".into(), rows("SkillLineID,TraitTreeID", &["574,9"]));
		t.insert("TraitNode".into(), rows("ID,TraitTreeID,PosX,PosY", &["1,9,1000,1000", "2,9,1000,1600", "3,9,3000,1000", "4,9,30000,1000", "5,8,1000,1000"]));
		t.insert("TraitNodeXTraitNodeEntry".into(), rows("TraitNodeID,TraitNodeEntryID,_Index", &["1,11,0", "2,12,0", "3,13,0", "4,11,0", "5,11,0"]));
		t.insert("TraitNodeEntry".into(), rows("ID,MaxRanks,TraitDefinitionID", &["11,2,21", "12,1,22", "13,1,23"]));
		t.insert("TraitDefinition".into(), rows("ID,SpellID,OverrideName_lang", &["21,101,", "22,102,", "23,103,Moonkin"]));
		t.insert("SpellName".into(), rows("ID,Name_lang", &["101,Furor", "102,Swipe", "103,Moonkin Form"]));
		t.insert("TraitNodeGroupXTraitNode".into(), rows("TraitNodeGroupID,TraitNodeID", &["7,1", "7,2", "8,3"]));
		t.insert("TraitNodeGroupXTraitCond".into(), rows("TraitNodeGroupID,TraitCondID", &["8,31"]));
		t.insert("TraitCond".into(), rows("ID,CondType,SpentAmountRequired,TraitNodeGroupID", &["31,0,2,7"]));
		t.insert("TraitEdge".into(), rows("LeftTraitNodeID,RightTraitNodeID,Type", &["1,2,2", "2,1,0"]));
		t
	}

	fn plan(picks: &str) -> V {
		forge_guide::js::parse_json(&format!(
			r#"{{"class":"DRUID","source":"S","sourceUrl":"u","summary":"Sum","order":["Balance","Feral"],"builds":[{{"key":"k","spec":"Feral","split":"0/3","link":"l","picks":[{picks}]}}]}}"#
		))
		.unwrap()
	}

	#[test]
	fn resolves_and_replays_under_the_client_rules() {
		let f = tree_facts(&tables(), "DRUID").unwrap();
		assert_eq!(f.strays, vec![4], "the far-off copy of Furor is left out");
		assert_eq!(f.specs, vec![vec![1, 2], vec![3]]);
		assert_eq!((f.nodes[&2].row, f.nodes[&3].name.as_str()), (2, "Moonkin"));
		assert_eq!(f.edges, vec![(1, 2)], "a VisualOnly line gates nothing");
		let ok = plan(
			r#"{"level":10,"tree":"Balance","talent":"Furor","rank":1},{"level":11,"tree":"Balance","talent":"Furor","rank":2,"note":"N"},{"level":12,"tree":"Balance","talent":"Swipe","rank":1},{"level":13,"tree":"Feral","talent":"Moonkin","rank":1}"#,
		);
		let out = build_all(&[ok], &tables(), "-- H", PREREQ_RULE).unwrap();
		assert!(out.errors.is_empty(), "{:?}", out.errors);
		assert!(out.lua.contains("\t\t[3] = { { 7, 2 } },\n") && out.lua.contains("\tedges = { { 1, 2 } },\n") && out.lua.contains("\t\t\t\t[11] = L[\"N\"],\n"));
		let bad = plan(r#"{"level":10,"tree":"Balance","talent":"Swipe","rank":1},{"level":12,"tree":"Feral","talent":"Moonkin","rank":1},{"level":13,"tree":"Feral","talent":"Bash","rank":1}"#);
		let out = build_all(&[bad], &tables(), "-- H", PREREQ_RULE).unwrap();
		assert_eq!(out.errors, vec!["DRUID k pick 3 (level 13, Bash): no Feral talent named \"Bash\""]);
		let bad = plan(r#"{"level":10,"tree":"Balance","talent":"Swipe","rank":1},{"level":12,"tree":"Feral","talent":"Moonkin","rank":1}"#);
		let out = build_all(&[bad], &tables(), "-- H", PREREQ_RULE).unwrap();
		assert_eq!(
			out.errors,
			vec!["DRUID k pick 1 (level 10, Swipe): needs Furor 2/2", "DRUID k pick 2 (level 12, Moonkin): expected level 11", "DRUID k pick 2 (level 12, Moonkin): needs 2 points in its tree, has 1"]
		);
	}
}
