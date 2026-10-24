//! Assembles the release's tables in the clean schema from the tier's facts and the public
//! inputs, with each value's provenance for the private sidecar.

use std::collections::{BTreeMap, BTreeSet};

use forge_core::frames::{Frame, MapFrames, Projector};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::{json, Map, Value};

use super::inputs::{BuildData, Cm, Factoruide, Kb, Tdb};
use super::tier::{independent_label, Ctx, Pick};

#[derive(Clone, Debug, PartialEq)]
pub struct Prov {
	pub sources: Vec<String>,
	pub confidence: String,
}

impl Prov {
	pub fn of(sources: &[&str]) -> Prov {
		Prov { sources: sources.iter().map(|s| s.to_string()).collect(), confidence: "high".into() }
	}
	fn labels(sources: Vec<String>) -> Prov {
		Prov { sources, confidence: "high".into() }
	}
	fn backed(&self) -> bool {
		self.sources.iter().any(|s| independent_label(s))
	}
}

/// One row: its fields (sorted on write) and each field's provenance (`_row` for the row).
pub struct Rec {
	pub row: BTreeMap<String, Value>,
	pub prov: Vec<(String, Prov)>,
}

/// A value the tier could not publish.
pub struct Cut {
	pub table: &'static str,
	pub key: String,
	pub field: String,
	pub value: String,
	pub sources: Vec<String>,
}

#[derive(Default)]
pub struct Tables {
	pub by: BTreeMap<&'static str, Vec<Rec>>,
	pub cuts: Vec<Cut>,
	/// Coverage lines (name, of, with).
	pub coverage: Vec<(String, usize, usize)>,
	/// Mechanics / steps rows held back (kind -> count).
	pub held: BTreeMap<String, usize>,
}

pub struct Inputs<'a> {
	pub kb: Option<&'a Kb>,
	pub factoruide: Option<&'a Factoruide>,
	pub cm: Option<&'a Cm>,
	pub tdb: Option<&'a Tdb>,
	/// The public build with QuestieDB (entities, quest links, spawns).
	pub data: &'a BuildData,
	/// The public build without QuestieDB (drops).
	pub drops: &'a BuildData,
	/// The corrections (applied in build-only mode, for entries with an accepted source kind).
	pub corrections: Option<&'a Value>,
	/// The rewritten quest notes (quest-notes.json: per quest its steps and notes): the release's
	/// steps and notes come from it instead of the KB's steps when given.
	pub notes: Option<&'a Value>,
	/// 8-word shingles of the local page-text evidence quotes: steps that run one are held.
	pub evidence: Option<&'a FxHashSet<u64>>,
}

/// The tier label of a correction's `source.kind` (a check in game counts as a recording).
pub fn correction_label(kind: &str) -> &str {
	match kind {
		"recording" | "in-game-check" => "recorder",
		k => k,
	}
}

/// Mechanic / step origins the own layer may come from (`game-data` and `community` are the
/// bases of rewritten quest notes).
pub const OWN_OK: &[&str] = &["server", "forever-data", "correction", "client", "game-data", "community"];

const RACE_A: u64 = 1 | 4 | 8 | 64 | (1 << 32);
const RACE_H: u64 = 2 | 16 | 32 | 128 | (1 << 33);
const RACE_BITS: [(u64, &str); 10] =
	[(1, "Human"), (2, "Orc"), (4, "Dwarf"), (8, "NightElf"), (16, "Undead"), (32, "Tauren"), (64, "Gnome"), (128, "Troll"), (1 << 32, "HighOrderSkyborne"), (1 << 33, "WindshaperSkyborne")];
const CLASS_BITS: [(i64, &str); 9] = [(1, "Warrior"), (2, "Paladin"), (4, "Hunter"), (8, "Rogue"), (16, "Priest"), (64, "Shaman"), (128, "Mage"), (256, "Warlock"), (1024, "Druid")];

/// A title that fails the sanity check: digits in parentheses ("(123)"), lowercase letters glued
/// to a closing bracket or quote at the end ("...)aa"), or a trailing junk word ("aa", "asdf").
pub fn junk_title(s: &str) -> bool {
	thread_local! {
		static RE: regex::Regex = regex::Regex::new(r#"\(\d+\)|[)\]"][a-z]+$|(?-u:\b)(aa+|zz+|xx+|asdf)$"#).unwrap();
	}
	RE.with(|r| r.is_match(s.trim()))
}

/// Placeholder names and titles (test, unused, not-yet-implemented rows).
pub fn placeholder(s: &str) -> bool {
	thread_local! {
		static RE: [regex::Regex; 2] = [
			regex::Regex::new(r"(?i)<UNUSED>|\[UNUSED\]|<NYI>|<TXT>|\[DNT\]|\[PH\]|(?-u:\b)DEPRECATED(?-u:\b)|(?-u:\b)UNUSED(?-u:\b)|^zz|Reuse Me").unwrap(),
			regex::Regex::new(r"(?-u:\b)TEST(?-u:\b)|(?-u:\b)OLD(?-u:\b)|(?i)\(old\)$").unwrap(),
		];
	}
	RE.with(|r| r.iter().any(|r| r.is_match(s)))
}

fn races_mask(v: &str) -> Option<u64> {
	let r = v.split(" (").next().unwrap_or("");
	match r {
		"any" => return Some(0),
		"alliance" => return Some(RACE_A),
		"horde" => return Some(RACE_H),
		"no-playable-race" | "" => return None,
		_ => {}
	}
	let mut m = 0;
	for n in r.split('/') {
		m |= RACE_BITS.iter().find(|(_, x)| *x == n)?.0;
	}
	Some(m)
}

fn classes_mask(v: &str) -> Option<i64> {
	if v == "any" {
		return Some(0);
	}
	let mut m = 0;
	for n in v.split('/') {
		m |= CLASS_BITS.iter().find(|(_, x)| *x == n)?.0;
	}
	Some(m)
}

fn int_value(s: &str) -> Option<i64> {
	let n: f64 = s.trim().parse().ok()?;
	(n.fract() == 0.0 && n > 0.0 && n != 9999.0).then_some(n as i64)
}

fn num(v: f64) -> Value {
	if v.fract() == 0.0 && v.abs() < 1e15 {
		Value::from(v as i64)
	} else {
		Value::from(v)
	}
}

fn round_to(v: f64, step: f64) -> f64 {
	let r = (v / step).round() * step;
	// Clean binary noise (0.1 * 3).
	(r * 10.0).round() / 10.0
}

fn vi(v: &Value) -> Option<i64> {
	v.as_i64().or_else(|| v.as_f64().filter(|f| f.fract() == 0.0).map(|f| f as i64))
}

fn ids(v: Option<&Value>) -> Vec<i64> {
	v.and_then(Value::as_array).into_iter().flatten().filter_map(vi).collect()
}

/// A quest's core fields before assembly.
#[derive(Default)]
struct Core {
	fields: Vec<(&'static str, Value, Prov)>,
	starts: Vec<(String, i64, Prov)>,
	ends: Vec<(String, i64, Prov)>,
	objectives: Vec<(BTreeMap<String, Value>, Prov)>,
	/// Placeholder check text (the source title even when it is not published).
	title_hint: String,
}

fn ents(v: &str) -> Vec<(String, i64)> {
	if v.is_empty() || v == "none" {
		return Vec::new();
	}
	v.split(',')
		.filter_map(|t| {
			let (k, i) = t.split_once(':')?;
			Some((k.to_string(), int_value(i)?))
		})
		.collect()
}

fn objective_rows(v: &str) -> Vec<BTreeMap<String, Value>> {
	if v.is_empty() || v == "none" {
		return Vec::new();
	}
	let mut out = Vec::new();
	for t in v.split(';').filter(|t| !t.is_empty()) {
		let mut p = t.split(':');
		let kind = match p.next() {
			Some("c") => "kill",
			Some("i") => "item",
			Some("o") => "object",
			Some("e") => "event",
			Some("x") => "talk",
			_ => continue,
		};
		let mut r = BTreeMap::new();
		r.insert("kind".to_string(), json!(kind));
		if let Some(t) = p.next().and_then(int_value) {
			r.insert("target".into(), json!(t));
		}
		if let Some(c) = p.next().and_then(int_value) {
			r.insert("count".into(), json!(c));
		}
		out.push(r);
	}
	out
}

struct Asm<'a> {
	inp: &'a Inputs<'a>,
	ctx: Option<Ctx<'a>>,
	t: Tables,
}

impl Asm<'_> {
	fn cut(&mut self, table: &'static str, key: String, field: &str, value: String, sources: Vec<String>) {
		self.t.cuts.push(Cut { table, key, field: field.to_string(), value, sources });
	}

	/// The tier pick of one KB fact, as (value, provenance).
	fn fact(&mut self, table: &'static str, f: &super::inputs::Fact) -> Option<(String, Prov)> {
		let ctx = self.ctx.as_ref()?;
		match ctx.pick(&f.kind, f.id, &f.field, &f.value, &f.source, &f.confidence) {
			Pick::Keep { value, sources, confidence, .. } => Some((value, Prov { sources, confidence })),
			Pick::Cut { value, sources } => {
				self.cut(table, f.id.to_string(), &f.field.clone(), value, sources);
				None
			}
		}
	}

	fn quest_core_kb(&mut self, facts: &[&super::inputs::Fact]) -> Core {
		let mut c = Core::default();
		for f in facts {
			if f.field == "title" {
				c.title_hint = f.value.clone();
			}
			if !matches!(f.field.as_str(), "title" | "level" | "min_level" | "xp" | "races" | "classes" | "side" | "start" | "end" | "objectives") {
				continue;
			}
			let Some((v, p)) = self.fact("quest", f) else { continue };
			match f.field.as_str() {
				"title" if !v.is_empty() => c.fields.push(("title", json!(v), p)),
				"level" => {
					if let Some(n) = int_value(&v) {
						c.fields.push(("level", json!(n), p))
					}
				}
				"min_level" => {
					if let Some(n) = int_value(&v) {
						c.fields.push(("min_level", json!(n), p))
					}
				}
				"xp" => {
					if let Some(n) = int_value(&v) {
						c.fields.push(("xp", json!(n), p))
					}
				}
				"races" => {
					if let Some(m) = races_mask(&v) {
						c.fields.push(("races", json!(m), p))
					}
				}
				"classes" => {
					if let Some(m) = classes_mask(&v) {
						c.fields.push(("classes", json!(m), p))
					}
				}
				"side" => {
					let s = match v.as_str() {
						"both" => 0,
						"A" => 1,
						"H" => 2,
						_ => continue,
					};
					c.fields.push(("side", json!(s), p))
				}
				"start" => c.starts.extend(ents(&v).into_iter().map(|(k, i)| (k, i, p.clone()))),
				"end" => c.ends.extend(ents(&v).into_iter().filter(|(k, _)| k != "item").map(|(k, i)| (k, i, p.clone()))),
				"objectives" => c.objectives.extend(objective_rows(&v).into_iter().map(|r| (r, p.clone()))),
				_ => {}
			}
		}
		c
	}

	/// Build-only mode: the public build's quest row (corrections with an accepted source applied).
	fn quest_core_build(&mut self, id: i64, q: &Value) -> Core {
		let mut c = Core { title_hint: q.get("title").and_then(Value::as_str).unwrap_or("").to_string(), ..Default::default() };
		let base = Prov::labels(self.inp.data.labels(q));
		let set = self.correction_set("quests", id);
		let field = |k: &str| -> (Option<Value>, Prov) {
			match &set {
				Some((s, p)) if s.contains_key(k) => (s.get(k).cloned(), p.clone()),
				_ => (q.get(k).cloned(), base.clone()),
			}
		};
		let (v, p) = field("title");
		if let Some(s) = v.as_ref().and_then(Value::as_str).filter(|s| !s.is_empty()) {
			c.fields.push(("title", json!(s), p));
		}
		for (k, name) in [("level", "level"), ("minLevel", "min_level"), ("xp", "xp")] {
			let (v, p) = field(k);
			if let Some(n) = v.as_ref().and_then(vi).filter(|n| *n > 0 && *n != 9999) {
				c.fields.push((name, json!(n), p));
			}
		}
		for k in ["races", "classes"] {
			let (v, p) = field(k);
			match v {
				Some(Value::Null) | None => c.fields.push((if k == "races" { "races" } else { "classes" }, json!(0), p)),
				Some(x) => {
					if let Some(n) = x.as_u64().or_else(|| x.as_f64().map(|f| f as u64)) {
						c.fields.push((if k == "races" { "races" } else { "classes" }, json!(n), p));
					}
				}
			}
		}
		for (k, is_start) in [("start", true), ("end", false)] {
			let (v, p) = field(k);
			let Some(v) = v else { continue };
			for kind in ["npc", "object", "item"] {
				if !is_start && kind == "item" {
					continue;
				}
				for i in ids(v.get(kind)) {
					let e = (kind.to_string(), i, p.clone());
					if is_start {
						c.starts.push(e)
					} else {
						c.ends.push(e)
					}
				}
			}
		}
		let (v, p) = field("objectives");
		for o in v.as_ref().and_then(Value::as_array).into_iter().flatten() {
			let kind = match o.get("type").and_then(Value::as_str) {
				Some(k @ ("kill" | "item" | "object" | "event" | "talk")) => k,
				_ => continue,
			};
			let mut r = BTreeMap::new();
			r.insert("kind".to_string(), json!(kind));
			if let Some(t) = o.get("id").and_then(vi).filter(|n| *n > 0) {
				r.insert("target".into(), json!(t));
			}
			if let Some(n) = o.get("count").and_then(vi).filter(|n| *n > 0) {
				r.insert("count".into(), json!(n));
			}
			c.objectives.push((r, p.clone()));
		}
		c
	}

	/// The `set` of a correction entry whose `source` (one `{ kind, ref }` or a list of them) names
	/// an independent check; its provenance is each such check.
	fn correction_set(&self, table: &str, id: i64) -> Option<(Map<String, Value>, Prov)> {
		let e = self.inp.corrections?.get(table)?.get(id.to_string())?;
		// Every independent kind the entry names, as a tier label (a check in game counts as a recording).
		let source = e.get("source")?;
		let mut labels = vec!["correction"];
		for s in source.as_array().map(|a| a.iter().collect()).unwrap_or_else(|| vec![source]) {
			let Some(label) = s.get("kind").and_then(Value::as_str).map(correction_label).filter(|l| independent_label(l)) else {
				continue;
			};
			if !labels.contains(&label) {
				labels.push(label);
			}
		}
		if labels.len() == 1 {
			return None;
		}
		Some((e.get("set")?.as_object()?.clone(), Prov::of(&labels)))
	}
}

/// Adds a row; a row without its own `_row` provenance (an entity row) is held by the sources of
/// its fields.
fn push(t: &mut Tables, table: &'static str, row: BTreeMap<String, Value>, mut prov: Vec<(String, Prov)>) {
	if !prov.iter().any(|(f, _)| f == "_row") {
		let mut s: Vec<String> = Vec::new();
		for (_, p) in &prov {
			for x in &p.sources {
				if !s.contains(x) {
					s.push(x.clone());
				}
			}
		}
		prov.push(("_row".into(), Prov::labels(s)));
	}
	t.by.entry(table).or_default().push(Rec { row, prov });
}

fn row_of(pairs: &[(&str, Value)]) -> BTreeMap<String, Value> {
	pairs.iter().map(|(k, v)| (k.to_string(), v.clone())).collect()
}

/// A world point from a build spawn (uiMap percent in its frame).
fn world(pr: &Projector, map: u32, x: f64, y: f64, f: &str) -> Option<(i64, f64, f64)> {
	let known = pr.era_bounds(map).is_some() || pr.live_bounds(map).is_some();
	if !known {
		return None;
	}
	let p = pr.point(map, x, y, Frame::parse(f));
	(p.c >= 0).then_some((p.c, p.wx, p.wy))
}

/// A quest-notes place ({kind, id, map (uiMap), x, y (percent), frame}) in world yards, and its
/// target (kind, id).
fn notes_place(pr: &Projector, p: &Value) -> (Option<Value>, Option<(String, i64)>) {
	let target = (|| Some((p.get("kind")?.as_str()?.to_string(), p.get("id")?.as_i64()?)))();
	let at = (|| {
		let ui = u32::try_from(p.get("map")?.as_i64()?).ok()?;
		let (m, wx, wy) = world(pr, ui, p.get("x")?.as_f64()?, p.get("y")?.as_f64()?, p.get("frame").and_then(Value::as_str).unwrap_or("e"))?;
		Some(json!({"map": m, "x": num(round_to(wx, 0.5)), "y": num(round_to(wy, 0.5))}))
	})();
	(at, target)
}

/// Steps and notes from quest-notes.json: ids over every generated row in the file's order, then
/// the rows of published quests whose text quotes no page text; community rows unconfirmed.
fn quest_notes(t: &mut Tables, qn: &Value, quests: &BTreeSet<i64>, pr: &Projector, quotes_page: &dyn Fn(&str) -> bool) {
	let mut by: Vec<(i64, &Value)> = qn.get("quests").and_then(Value::as_object).into_iter().flatten().filter_map(|(k, v)| Some((k.parse::<i64>().ok()?, v))).collect();
	by.sort_by_key(|(q, _)| *q);
	let mut ids = super::notes::Ids::default();
	let ints = |v: Option<&Value>| -> Vec<i64> { v.and_then(Value::as_array).into_iter().flatten().filter_map(Value::as_i64).filter(|i| *i > 0).collect() };
	for (q, entry) in by {
		let published = quests.contains(&q);
		let mut n = 0i64;
		for s in entry.get("steps").and_then(Value::as_array).into_iter().flatten() {
			let action = s.get("action").and_then(Value::as_str).unwrap_or("");
			let targets: Vec<(String, i64)> =
				s.get("targets").and_then(Value::as_array).into_iter().flatten().filter_map(|t| Some((t.get("type")?.as_str()?.to_string(), t.get("id")?.as_i64()?))).collect();
			let items = ints(s.get("items"));
			let (place, target) = s.get("place").filter(|p| p.is_object()).map(|p| notes_place(pr, p)).unwrap_or((None, None));
			let id = ids.next(q, true, &super::notes::step_identity(action, &targets, &items, target.as_ref().map(|(k, i)| (k.as_str(), *i))));
			let fact = s.get("fact").and_then(Value::as_str).unwrap_or("");
			let basis = s.get("basis").and_then(Value::as_str).unwrap_or("");
			if !published || action.is_empty() || !matches!(basis, "game-data" | "community") || quotes_page(fact) {
				*t.held.entry(format!("step {action}")).or_default() += 1;
				continue;
			}
			n += 1;
			let p = Prov::of(&[basis]);
			let mut r = row_of(&[("quest", json!(q)), ("n", json!(n)), ("id", json!(id)), ("action", json!(action))]);
			if let Some((k, i)) = targets.first() {
				r.insert("target_kind".into(), json!(k));
				r.insert("target".into(), json!(i));
			}
			if let Some(c) = s.get("count").and_then(Value::as_i64).filter(|c| *c > 0) {
				r.insert("count".into(), json!(c));
			}
			if let Some(pl) = place {
				r.insert("place".into(), pl);
			}
			if !fact.is_empty() {
				r.insert("text".into(), json!(fact));
			}
			if basis == "community" {
				r.insert("confidence".into(), json!("unconfirmed"));
			}
			let pv = std::iter::once("_row".to_string()).chain(r.keys().filter(|k| !matches!(k.as_str(), "quest" | "n")).cloned()).map(|k| (k, p.clone())).collect();
			push(t, "step", r, pv);
		}
		for o in entry.get("notes").and_then(Value::as_array).into_iter().flatten() {
			let kind = o.get("kind").and_then(Value::as_str).unwrap_or("");
			let mut subjects: Vec<(String, i64)> =
				o.get("targets").and_then(Value::as_array).into_iter().flatten().filter_map(|t| Some((t.get("type")?.as_str()?.to_string(), t.get("id")?.as_i64()?))).collect();
			subjects.extend(ints(o.get("items")).into_iter().map(|i| ("item".to_string(), i)));
			let (place, target) = o.get("place").filter(|p| p.is_object()).map(|p| notes_place(pr, p)).unwrap_or((None, None));
			let id = ids.next(q, false, &super::notes::note_identity(kind, &subjects, target.as_ref().map(|(k, i)| (k.as_str(), *i))));
			let fact = o.get("fact").and_then(Value::as_str).unwrap_or("");
			let basis = o.get("basis").and_then(Value::as_str).unwrap_or("");
			if !published || !super::notes::NOTE_KINDS.contains(&kind) || fact.is_empty() || !matches!(basis, "game-data" | "community") || quotes_page(fact) {
				*t.held.entry(format!("note {kind}")).or_default() += 1;
				continue;
			}
			let p = Prov::of(&[basis]);
			let mut r = row_of(&[("quest", json!(q)), ("id", json!(id)), ("kind", json!(kind)), ("text", json!(fact))]);
			if let Some(pl) = place {
				r.insert("place".into(), pl);
			}
			if basis == "community" {
				r.insert("confidence".into(), json!("unconfirmed"));
			}
			let pv = std::iter::once("_row".to_string()).chain(r.keys().filter(|k| !matches!(k.as_str(), "quest" | "id")).cloned()).map(|k| (k, p.clone())).collect();
			push(t, "note", r, pv);
		}
	}
}

pub fn assemble(inp: &Inputs) -> Result<Tables, String> {
	let mut a = Asm { inp, ctx: inp.kb.map(|kb| Ctx { kb, factoruide: inp.factoruide }), t: Tables::default() };
	let data = inp.data;
	let disabled: FxHashSet<i64> = inp.tdb.map(|t| t.disabled.clone()).unwrap_or_default();

	// ---- quests
	let mut cores: BTreeMap<i64, Core> = BTreeMap::new();
	if let Some(kb) = inp.kb {
		let mut by: BTreeMap<(String, i64), Vec<&super::inputs::Fact>> = BTreeMap::new();
		for f in &kb.facts {
			by.entry((f.kind.clone(), f.id)).or_default().push(f);
		}
		let titles: FxHashMap<i64, &str> = kb.quests.iter().map(|(i, t)| (*i, t.as_str())).collect();
		for (id, _) in &kb.quests {
			let facts = by.get(&("quest".to_string(), *id)).cloned().unwrap_or_default();
			let mut c = a.quest_core_kb(&facts);
			if c.title_hint.is_empty() {
				c.title_hint = titles.get(id).copied().unwrap_or("").to_string();
			}
			cores.insert(*id, c);
		}
	} else {
		for (k, q) in &data.quests {
			let Ok(id) = k.parse::<i64>() else { continue };
			let c = a.quest_core_build(id, q);
			cores.insert(id, c);
		}
	}
	cores.retain(|id, c| !disabled.contains(id) && !placeholder(&c.title_hint));
	// Junk quests: a title that fails the sanity check and no confirmed giver or turn-in.
	let before = cores.len();
	cores.retain(|_, c| !(junk_title(&c.title_hint) && (c.starts.is_empty() || c.ends.is_empty())));
	if before > cores.len() {
		a.t.held.insert("quest: junk title without a confirmed giver and turn-in".into(), before - cores.len());
	}
	cores.retain(|_, c| !c.fields.is_empty() || !c.starts.is_empty() || !c.ends.is_empty() || !c.objectives.is_empty());
	let quest_ids: BTreeSet<i64> = cores.keys().copied().collect();

	let mut ref_npc: FxHashSet<i64> = FxHashSet::default();
	let mut ref_obj: FxHashSet<i64> = FxHashSet::default();
	let mut ref_item: FxHashSet<i64> = FxHashSet::default();
	let mut relevant_items: FxHashSet<i64> = FxHashSet::default();
	let empty_obj = Value::Null;
	for (id, c) in &cores {
		let bq = data.quests.get(&id.to_string()).unwrap_or(&empty_obj);
		let bl = Prov::labels(data.labels(bq));
		let cmq = inp.cm.and_then(|cm| cm.quest.get(id));
		let tq = inp.tdb.and_then(|t| t.quest.get(id));
		let mut row = BTreeMap::new();
		let mut prov = Vec::new();
		row.insert("id".to_string(), json!(id));
		let mut has_side = false;
		let mut races = None;
		for (k, v, p) in &c.fields {
			if *k == "side" {
				has_side = true;
			}
			if *k == "races" {
				races = Some((v.as_u64().unwrap_or(0), p.clone()));
			}
			row.insert(k.to_string(), v.clone());
			prov.push((k.to_string(), p.clone()));
		}
		if !has_side {
			if let Some((m, p)) = races {
				let s = if m == 0 || (m & RACE_A != 0 && m & RACE_H != 0) {
					0
				} else if m & RACE_A != 0 {
					1
				} else {
					2
				};
				row.insert("side".into(), json!(s));
				prov.push(("side".into(), p));
			}
		}
		// zone, type, money, repeatable
		if let Some(z) = bq.get("area").and_then(vi).filter(|z| *z > 0).filter(|_| bl.backed()) {
			row.insert("zone_area".into(), json!(z));
			prov.push(("zone_area".into(), bl.clone()));
		} else if let Some(z) = tq.map(|t| t.sort).filter(|z| *z > 0) {
			row.insert("zone_area".into(), json!(z));
			prov.push(("zone_area".into(), Prov::of(&["tdb"])));
		} else if let Some(z) = cmq.map(|q| q.zone).filter(|z| *z > 0) {
			row.insert("zone_area".into(), json!(z));
			prov.push(("zone_area".into(), Prov::of(&["cmangos"])));
		}
		if let Some(t) = tq {
			row.insert("type".into(), json!(t.info));
			prov.push(("type".into(), Prov::of(&["tdb"])));
		} else if let Some(q) = cmq {
			row.insert("type".into(), json!(q.info));
			prov.push(("type".into(), Prov::of(&["cmangos"])));
		}
		if let Some(m) = inp.tdb.and_then(|t| t.money.get(id)) {
			row.insert("money_copper".into(), json!(m));
			prov.push(("money_copper".into(), Prov::of(&["tdb"])));
		} else if let Some(m) = cmq.map(|q| q.money).filter(|m| *m > 0) {
			row.insert("money_copper".into(), json!(m));
			prov.push(("money_copper".into(), Prov::of(&["cmangos"])));
		}
		let mut rep: Vec<String> = Vec::new();
		if bq.get("repeatable").and_then(Value::as_bool) == Some(true) && bl.backed() {
			rep.extend(bl.sources.iter().cloned());
		}
		if tq.is_some_and(|t| t.repeatable) {
			rep.push("tdb".into());
		}
		if cmq.is_some_and(|q| q.repeatable) {
			rep.push("cmangos".into());
		}
		if rep.iter().any(|s| independent_label(s)) {
			row.insert("repeatable".into(), json!(true));
			prov.push(("repeatable".into(), Prov::labels(rep)));
		}
		// A quest row is held by its fields' sources, and by its givers', turn-ins' and objectives'.
		let mut held: Vec<String> = Vec::new();
		for p in prov.iter().map(|(_, p)| p).chain(c.starts.iter().map(|x| &x.2)).chain(c.ends.iter().map(|x| &x.2)).chain(c.objectives.iter().map(|x| &x.1)) {
			for s in &p.sources {
				if !held.contains(s) {
					held.push(s.clone());
				}
			}
		}
		prov.push(("_row".into(), Prov::labels(held)));
		push(&mut a.t, "quest", row, prov);

		let mut seen = FxHashSet::default();
		for (k, i, p) in &c.starts {
			if seen.insert((k.clone(), *i)) {
				match k.as_str() {
					"npc" => ref_npc.insert(*i),
					"object" => ref_obj.insert(*i),
					_ => {
						relevant_items.insert(*i);
						ref_item.insert(*i)
					}
				};
				push(&mut a.t, "quest_start", row_of(&[("quest", json!(id)), ("kind", json!(k)), ("id", json!(i))]), vec![("_row".into(), p.clone())]);
			}
		}
		let mut seen = FxHashSet::default();
		for (k, i, p) in &c.ends {
			if seen.insert((k.clone(), *i)) {
				if k == "npc" {
					ref_npc.insert(*i);
				} else {
					ref_obj.insert(*i);
				}
				push(&mut a.t, "quest_end", row_of(&[("quest", json!(id)), ("kind", json!(k)), ("id", json!(i))]), vec![("_row".into(), p.clone())]);
			}
		}
		for (n, (o, p)) in c.objectives.iter().enumerate() {
			let mut r = o.clone();
			if let Some(t) = r.get("target").and_then(vi) {
				match r.get("kind").and_then(Value::as_str) {
					Some("kill") => {
						ref_npc.insert(t);
					}
					Some("object") => {
						ref_obj.insert(t);
					}
					Some("item") => {
						ref_item.insert(t);
						relevant_items.insert(t);
					}
					_ => {}
				}
			}
			let fields: Vec<String> = r.keys().cloned().collect();
			r.insert("quest".into(), json!(id));
			r.insert("n".into(), json!(n + 1));
			let mut pv = vec![("_row".to_string(), p.clone())];
			pv.extend(fields.into_iter().map(|f| (f, p.clone())));
			push(&mut a.t, "quest_objective", r, pv);
		}
		// prerequisites
		let mut pre: BTreeMap<i64, (&str, bool)> = BTreeMap::new();
		if bl.backed() {
			for p in ids(bq.get("preAll")) {
				pre.insert(p, ("all", false));
			}
			for p in ids(bq.get("preAny")) {
				pre.entry(p).or_insert(("any", false));
			}
			for p in ids(bq.get("pre")) {
				pre.entry(p).or_insert(("all", false));
			}
			for b in ids(bq.get("breadcrumbs")) {
				pre.entry(b).or_insert(("any", true)).1 = true;
			}
		}
		for (p, (mode, bc)) in pre {
			if p == *id || !quest_ids.contains(&p) {
				continue;
			}
			let mut src = bl.sources.clone();
			if cmq.is_some_and(|q| q.prev.abs() == p) || inp.cm.and_then(|cm| cm.quest.get(&p)).is_some_and(|q| q.breadcrumb_for == *id) {
				src.push("cmangos".into());
			}
			if tq.is_some_and(|t| t.prev.abs() == p) || inp.tdb.and_then(|t| t.quest.get(&p)).is_some_and(|q| q.breadcrumb_for == *id) {
				src.push("tdb".into());
			}
			let pr = Prov::labels(src);
			let mut r = row_of(&[("quest", json!(id)), ("pre", json!(p)), ("mode", json!(mode))]);
			let mut pv = vec![("_row".to_string(), pr.clone()), ("mode".to_string(), pr.clone())];
			if bc {
				r.insert("breadcrumb".into(), json!(true));
				pv.push(("breadcrumb".into(), pr));
			}
			push(&mut a.t, "quest_prereq", r, pv);
		}
		// rewards
		let rewards: Vec<(&str, i64, Option<i64>, &str)> = if let Some(t) = tq.filter(|t| !t.rewards.is_empty()) {
			t.rewards.iter().map(|(k, i, n)| (*k, *i, *n, "tdb")).collect()
		} else if let Some(q) = cmq {
			q.rewards.iter().map(|(k, i, n)| (*k, *i, Some(*n), "cmangos")).collect()
		} else {
			Vec::new()
		};
		let mut seen = FxHashSet::default();
		for (k, i, n, src) in rewards {
			if !seen.insert((k, i)) {
				continue;
			}
			if k != "rep" {
				ref_item.insert(i);
			}
			let pr = Prov::of(&[src]);
			let mut r = row_of(&[("quest", json!(id)), ("kind", json!(k)), ("id", json!(i))]);
			let mut pv = vec![("_row".to_string(), pr.clone())];
			if let Some(n) = n.filter(|n| *n != 0) {
				r.insert("count".into(), json!(n));
				pv.push(("count".into(), pr));
			}
			push(&mut a.t, "quest_reward", r, pv);
		}
	}

	// ---- npcs
	let mut npc_ids: BTreeSet<i64> = BTreeSet::new();
	let kb_facts: FxHashMap<(&str, i64), Vec<&super::inputs::Fact>> = inp
		.kb
		.map(|kb| {
			let mut m: FxHashMap<(&str, i64), Vec<&super::inputs::Fact>> = FxHashMap::default();
			for f in &kb.facts {
				m.entry((f.kind.as_str(), f.id)).or_default().push(f);
			}
			m
		})
		.unwrap_or_default();
	let npc_list: Vec<(i64, String)> = match inp.kb {
		Some(kb) => kb.npcs.clone(),
		None => data.npcs.iter().filter_map(|(k, v)| Some((k.parse().ok()?, v.get("name").and_then(Value::as_str).unwrap_or("").to_string()))).collect(),
	};
	let mut listed: FxHashSet<i64> = npc_list.iter().map(|(i, _)| *i).collect();
	let mut npcs_all = npc_list;
	for i in &ref_npc {
		if listed.insert(*i) {
			npcs_all.push((*i, String::new()));
		}
	}
	npcs_all.sort();
	for (id, hint) in npcs_all {
		let bn = data.npcs.get(&id.to_string()).unwrap_or(&empty_obj);
		let bl = Prov::labels(data.labels(bn));
		let mut row = BTreeMap::new();
		let mut prov = Vec::new();
		let mut name_hint = hint;
		if inp.kb.is_some() {
			let facts = kb_facts.get(&("npc", id)).cloned().unwrap_or_default();
			for f in facts {
				if f.field == "name" {
					name_hint = f.value.clone();
				}
				if !matches!(f.field.as_str(), "name" | "subname" | "npc_level") {
					continue;
				}
				let Some((v, p)) = a.fact("npc", f) else { continue };
				match f.field.as_str() {
					// "NULL": a source's empty subname written out as text
					"name" | "subname" if !v.is_empty() && v != "NULL" => {
						row.insert(f.field.clone(), json!(v));
						prov.push((f.field.clone(), p));
					}
					"npc_level" => {
						let mut it = v.split('-').map(int_value);
						let lo = it.next().flatten();
						let hi = it.next().flatten().or(lo);
						if let (Some(lo), Some(hi)) = (lo, hi) {
							row.insert("level_min".into(), json!(lo));
							row.insert("level_max".into(), json!(hi));
							prov.push(("level_min".into(), p.clone()));
							prov.push(("level_max".into(), p));
						}
					}
					_ => {}
				}
			}
		} else if bl.backed() {
			let set = a.correction_set("npcs", id);
			let get = |k: &str| -> (Option<Value>, Prov) {
				match &set {
					Some((s, p)) if s.contains_key(k) => (s.get(k).cloned(), p.clone()),
					_ => (bn.get(k).cloned(), bl.clone()),
				}
			};
			for (k, name) in [("name", "name"), ("subName", "subname")] {
				let (v, p) = get(k);
				if let Some(s) = v.as_ref().and_then(Value::as_str).filter(|s| !s.is_empty() && *s != "NULL") {
					row.insert(name.into(), json!(s));
					prov.push((name.into(), p));
				}
			}
			let (lo, p) = get("level");
			if let Some(lo) = lo.as_ref().and_then(vi).filter(|n| *n > 0 && *n != 9999) {
				let hi = get("levelMax").0.as_ref().and_then(vi).filter(|n| *n >= lo && *n != 9999).unwrap_or(lo);
				row.insert("level_min".into(), json!(lo));
				row.insert("level_max".into(), json!(hi));
				prov.push(("level_min".into(), p.clone()));
				prov.push(("level_max".into(), p));
			}
		}
		if let Some((f, _)) = inp.tdb.and_then(|t| t.npc.get(&id)).filter(|(f, _)| *f > 0) {
			row.insert("faction_template".into(), json!(f));
			prov.push(("faction_template".into(), Prov::of(&["tdb"])));
		} else if let Some(n) = inp.cm.and_then(|c| c.npc.get(&id)).filter(|n| n.faction > 0) {
			row.insert("faction_template".into(), json!(n.faction));
			prov.push(("faction_template".into(), Prov::of(&["cmangos"])));
		}
		let rank_set = if inp.kb.is_none() { a.correction_set("npcs", id).filter(|(s, _)| s.contains_key("rank")) } else { None };
		if let Some((s, p)) = rank_set {
			if let Some(r) = s.get("rank").and_then(vi).filter(|r| (0..=4).contains(r)) {
				row.insert("rank".into(), json!(r));
				prov.push(("rank".into(), p));
			}
		} else if let Some(r) = bn.get("rank").and_then(vi).filter(|_| bl.backed()) {
			row.insert("rank".into(), json!(r));
			prov.push(("rank".into(), bl.clone()));
		} else if let Some(r) = inp.tdb.and_then(|t| t.npc.get(&id)).map(|x| x.1) {
			row.insert("rank".into(), json!(r));
			prov.push(("rank".into(), Prov::of(&["tdb"])));
		} else if let Some(r) = inp.cm.and_then(|c| c.npc.get(&id)).and_then(|n| n.rank) {
			row.insert("rank".into(), json!(r));
			prov.push(("rank".into(), Prov::of(&["cmangos"])));
		}
		let name = row.get("name").and_then(Value::as_str).map(String::from).unwrap_or(name_hint);
		if row.is_empty() || (placeholder(&name) && !ref_npc.contains(&id)) {
			continue;
		}
		row.insert("id".into(), json!(id));
		npc_ids.insert(id);
		push(&mut a.t, "npc", row, prov);
	}

	// ---- objects
	let mut obj_ids: BTreeSet<i64> = BTreeSet::new();
	let mut objs: BTreeSet<i64> = match inp.kb {
		Some(kb) => kb.objects.iter().map(|(i, _)| *i).collect(),
		None => data.objects.keys().filter_map(|k| k.parse().ok()).collect(),
	};
	objs.extend(ref_obj.iter().copied());
	for id in objs {
		let bo = data.objects.get(&id.to_string()).unwrap_or(&empty_obj);
		let bl = Prov::labels(data.labels(bo));
		let tdb_o = inp.tdb.and_then(|t| t.object.get(&id));
		let cm_o = inp.cm.and_then(|c| c.object.get(&id));
		let mut row = BTreeMap::new();
		let mut prov = Vec::new();
		let bname = bo.get("name").and_then(Value::as_str).filter(|s| !s.is_empty());
		if let Some(n) = bname.filter(|_| bl.backed()) {
			let mut s = bl.sources.clone();
			if tdb_o.is_some_and(|o| o.0 == n) {
				s.push("tdb".into());
			}
			if cm_o.is_some_and(|o| o.0 == n) {
				s.push("cmangos".into());
			}
			row.insert("name".into(), json!(n));
			prov.push(("name".into(), Prov::labels(s)));
		} else if let Some(o) = tdb_o.filter(|o| !o.0.is_empty()) {
			row.insert("name".into(), json!(o.0));
			prov.push(("name".into(), Prov::of(&["tdb"])));
		} else if let Some(o) = cm_o.filter(|o| !o.0.is_empty()) {
			row.insert("name".into(), json!(o.0));
			prov.push(("name".into(), Prov::of(&["cmangos"])));
		}
		if let Some(o) = tdb_o {
			row.insert("type".into(), json!(o.1));
			prov.push(("type".into(), Prov::of(&["tdb"])));
		} else if let Some(o) = cm_o {
			row.insert("type".into(), json!(o.1));
			prov.push(("type".into(), Prov::of(&["cmangos"])));
		}
		let name = row.get("name").and_then(Value::as_str).or(bname).unwrap_or("").to_string();
		if row.is_empty() || (placeholder(&name) && !ref_obj.contains(&id)) {
			continue;
		}
		row.insert("id".into(), json!(id));
		obj_ids.insert(id);
		push(&mut a.t, "object", row, prov);
	}

	// ---- items
	let mut item_ids: BTreeSet<i64> = BTreeSet::new();
	let mut items: BTreeSet<i64> = match inp.kb {
		Some(kb) => kb.items.iter().map(|(i, _)| *i).collect(),
		None => data.items.keys().filter_map(|k| k.parse().ok()).collect(),
	};
	items.extend(ref_item.iter().copied());
	for id in items {
		let bi = data.items.get(&id.to_string()).unwrap_or(&empty_obj);
		let bl = Prov::labels(data.labels(bi));
		let cm_n = inp.cm.and_then(|c| c.item.get(&id));
		let mut row = BTreeMap::new();
		let mut prov = Vec::new();
		let bname = bi.get("name").and_then(Value::as_str).filter(|s| !s.is_empty());
		if let Some(n) = bname.filter(|_| bl.backed()) {
			let mut s = bl.sources.clone();
			if cm_n.is_some_and(|c| c == n) {
				s.push("cmangos".into());
			}
			row.insert("name".into(), json!(n));
			prov.push(("name".into(), Prov::labels(s)));
		} else if let Some(n) = cm_n.filter(|n| !n.is_empty()) {
			row.insert("name".into(), json!(n));
			prov.push(("name".into(), Prov::of(&["cmangos"])));
		}
		if bi.get("questItem").and_then(Value::as_bool) == Some(true) && bl.backed() {
			row.insert("quest_item".into(), json!(true));
			prov.push(("quest_item".into(), bl.clone()));
			relevant_items.insert(id);
		}
		let name = row.get("name").and_then(Value::as_str).or(bname).unwrap_or("").to_string();
		if row.is_empty() || (placeholder(&name) && !ref_item.contains(&id)) {
			continue;
		}
		row.insert("id".into(), json!(id));
		item_ids.insert(id);
		push(&mut a.t, "item", row, prov);
	}

	// ---- item sources (quest-relevant items only)
	let mut pairs: BTreeMap<(i64, &str, i64), (Vec<String>, Option<(f64, &str)>)> = BTreeMap::new();
	for (k, it) in &inp.drops.items {
		let Ok(item) = k.parse::<i64>() else { continue };
		if !relevant_items.contains(&item) || !item_ids.contains(&item) {
			continue;
		}
		for kind in ["npc", "object"] {
			for (e, ch) in it.get("drops").and_then(|d| d.get(kind)).and_then(Value::as_object).into_iter().flatten() {
				let Ok(e) = e.parse::<i64>() else { continue };
				let s = pairs.entry((item, kind, e)).or_default();
				s.0.push("pfquest".into());
				if let Some(c) = ch.as_f64() {
					s.1 = Some((c, "pfquest"));
				}
			}
		}
		for c in ids(it.get("containers")) {
			pairs.entry((item, "item", c)).or_default().0.push("pfquest".into());
		}
	}
	if let Some(cm) = inp.cm {
		for (item, kind, e, ch) in &cm.loot {
			if !relevant_items.contains(item) || !item_ids.contains(item) {
				continue;
			}
			let s = pairs.entry((*item, kind, *e)).or_default();
			if !s.0.iter().any(|x| x == "cmangos") {
				s.0.push("cmangos".into());
			}
			if *ch > 0.0 && s.1.is_none_or(|(_, src)| src != "cmangos") {
				s.1 = Some((*ch, "cmangos"));
			}
		}
	}
	for ((item, kind, e), (src, ch)) in pairs {
		let present = match kind {
			"npc" => npc_ids.contains(&e),
			"object" => obj_ids.contains(&e),
			_ => item_ids.contains(&e),
		};
		if !present {
			continue;
		}
		let mut r = row_of(&[("item", json!(item)), ("kind", json!(kind)), ("id", json!(e))]);
		let mut pv = vec![("_row".to_string(), Prov::labels(src))];
		if let Some((c, s)) = ch {
			let c = round_to(c, 0.1);
			if c > 0.0 {
				r.insert("chance".into(), num(c));
				pv.push(("chance".into(), Prov::of(&[s])));
			}
		}
		push(&mut a.t, "item_source", r, pv);
	}

	// ---- spawns
	let frames = MapFrames::from_json(&data.frames).map_err(|e| format!("map-frames.json: {e}"))?;
	let pr = Projector::new(&frames);
	for (kind, table, set) in [("npc", &data.npcs, &npc_ids), ("object", &data.objects, &obj_ids)] {
		let cmz = data.spawnz.get(kind);
		for id in set {
			let row = table.get(&id.to_string()).unwrap_or(&empty_obj);
			let bl = Prov::labels(data.labels(row));
			// cm points: map -> [(x, y, z)]
			let mut cm_pts: BTreeMap<i64, Vec<(f64, f64, f64)>> = BTreeMap::new();
			for p in cmz.and_then(|z| z.get(id.to_string())).and_then(Value::as_array).into_iter().flatten() {
				let v: Vec<f64> = p.as_array().into_iter().flatten().filter_map(Value::as_f64).collect();
				if v.len() >= 4 {
					cm_pts.entry(v[0] as i64).or_default().push((v[1], v[2], v[3]));
				}
			}
			let mut pts: BTreeMap<i64, Vec<(f64, f64, Option<f64>, &Prov)>> = BTreeMap::new();
			let cm_prov = Prov::of(&["cmangos"]);
			if bl.backed() {
				for (ui, sp) in row.get("spawns").and_then(Value::as_object).into_iter().flatten() {
					let Ok(ui) = ui.parse::<u32>() else { continue };
					let f = sp.get("f").and_then(Value::as_str).unwrap_or("e");
					for p in sp.get("pts").and_then(Value::as_array).into_iter().flatten() {
						let (Some(x), Some(y)) = (p.get(0).and_then(Value::as_f64), p.get(1).and_then(Value::as_f64)) else { continue };
						if let Some((m, wx, wy)) = world(&pr, ui, x, y, f) {
							let z = cm_pts.get(&m).and_then(|l| l.iter().map(|c| ((c.0 - wx).hypot(c.1 - wy), c.2)).filter(|(d, _)| *d <= 3.0).min_by(|a, b| a.0.total_cmp(&b.0)).map(|x| x.1));
							pts.entry(m).or_default().push((wx, wy, z, &bl));
						}
					}
				}
			}
			if pts.is_empty() {
				for (m, l) in &cm_pts {
					for (x, y, z) in l {
						pts.entry(*m).or_default().push((*x, *y, Some(*z), &cm_prov));
					}
				}
			}
			for (m, l) in pts {
				let mut kept: Vec<(f64, f64, Option<f64>, &Prov)> = Vec::new();
				for p in l {
					if !kept.iter().any(|k| (k.0 - p.0).hypot(k.1 - p.1) <= 1.0) {
						kept.push(p);
					}
				}
				let mut out: Vec<(f64, f64, Option<f64>, &Prov)> = kept.into_iter().map(|(x, y, z, p)| (round_to(x, 0.5), round_to(y, 0.5), z.map(|z| round_to(z, 0.1)), p)).collect();
				out.sort_by(|a, b| a.0.total_cmp(&b.0).then(a.1.total_cmp(&b.1)));
				out.dedup_by(|a, b| a.0 == b.0 && a.1 == b.1);
				for (n, (x, y, z, p)) in out.into_iter().enumerate() {
					let mut r = row_of(&[("kind", json!(kind)), ("id", json!(id)), ("map", json!(m)), ("n", json!(n + 1)), ("x", num(x)), ("y", num(y))]);
					let mut pv = vec![("_row".to_string(), p.clone()), ("x".into(), p.clone()), ("y".into(), p.clone())];
					if let Some(z) = z {
						r.insert("z".into(), num(z));
						pv.push(("z".into(), cm_prov.clone()));
					}
					push(&mut a.t, "spawn", r, pv);
				}
			}
		}
	}

	// ---- map frames: the in-game client's (Forever's), else Classic's
	let mut ui: BTreeMap<i64, (i64, f64, f64, f64, f64)> = BTreeMap::new();
	for set in [&frames.forever, &frames.era] {
		for (k, b) in set {
			let (Ok(m), Some(r)) = (k.parse::<i64>(), b.rect()) else { continue };
			if r.c >= 0 && r.left != r.right && r.top != r.bottom {
				ui.entry(m).or_insert((r.c, r.left, r.right, r.top, r.bottom));
			}
		}
	}
	for (m, (c, l, r, t, b)) in ui {
		let row = row_of(&[("ui_map", json!(m)), ("map", json!(c)), ("left", num(l)), ("right", num(r)), ("top", num(t)), ("bottom", num(b))]);
		let pv = std::iter::once("_row".to_string()).chain(row.keys().filter(|k| *k != "ui_map").cloned()).map(|k| (k, Prov::of(&["client"]))).collect();
		push(&mut a.t, "ui_map", row, pv);
	}

	// ---- mechanics (our own layer)
	if let Some(kb) = inp.kb {
		let mut seen = FxHashSet::default();
		for m in &kb.mechanics {
			let own: Vec<String> = m.sources.iter().filter(|s| OWN_OK.contains(&s.as_str())).cloned().collect();
			if m.status != "kept" || own.is_empty() || !quest_ids.contains(&m.quest) {
				*a.t.held.entry(format!("mechanic {}", m.kind)).or_default() += 1;
				continue;
			}
			if !seen.insert((m.quest, m.kind.clone())) {
				continue;
			}
			let pr = Prov { sources: own, confidence: m.confidence.clone() };
			let r = row_of(&[("quest", json!(m.quest)), ("kind", json!(m.kind)), ("params", json!({"drives_route": m.drives != 0}))]);
			push(&mut a.t, "mechanic", r, vec![("_row".into(), pr.clone()), ("params".into(), pr)]);
		}
	}

	// ---- steps and notes (our own layer), each with its stable id (publish::notes)
	let quotes_page = |text: &str| inp.evidence.is_some_and(|sh| super::check::words(text).windows(8).any(|w| sh.contains(&super::check::shingle_hash(w))));
	if let Some(qn) = inp.notes {
		quest_notes(&mut a.t, qn, &quest_ids, &pr, &quotes_page);
	} else if let Some(steps) = inp.kb.and_then(|kb| kb.steps.as_ref()) {
		// Rewritten notes (a `basis`): game-data rows ship as they are, community rows marked
		// unconfirmed. Before those: only high steps from structured sources whose evidence
		// quotes no page text.
		const PAGE_TEXT: [&str; 6] = ["comment", "description", "objectives", "completion", "progress", "page"];
		// Gotchas carry no step number: they are numbered after the quest's last step.
		let mut next_n: FxHashMap<i64, i64> = FxHashMap::default();
		for s in steps {
			let e = next_n.entry(s.quest).or_insert(1);
			*e = (*e).max(s.n + 1);
		}
		// Ids over every generated step in the KB's order, so a step held today does not move
		// another's id when it ships later.
		let mut ids = super::notes::Ids::default();
		for s in steps {
			let place_json = serde_json::from_str::<Value>(&s.place).ok();
			let targets: Vec<(String, i64)> = (s.target > 0).then(|| (if s.target_kind.is_empty() { "npc".to_string() } else { s.target_kind.clone() }, s.target)).into_iter().collect();
			let items: Vec<i64> = (s.item > 0).then_some(s.item).into_iter().collect();
			let place_target = place_json.as_ref().and_then(|p| Some((p.get("kind")?.as_str()?.to_string(), p.get("id")?.as_i64()?)));
			let id = ids.next(s.quest, true, &super::notes::step_identity(&s.action, &targets, &items, place_target.as_ref().map(|(k, i)| (k.as_str(), *i))));
			let ev = s.evidence.to_lowercase();
			let ok = match s.basis.as_str() {
				"game-data" | "community" => true,
				"" => s.confidence == "high" && OWN_OK.contains(&s.source.as_str()) && !PAGE_TEXT.iter().any(|w| ev.contains(w)),
				_ => false,
			};
			if !ok || quotes_page(&s.text) || !quest_ids.contains(&s.quest) || s.action.is_empty() {
				*a.t.held.entry(format!("step {}", s.action)).or_default() += 1;
				continue;
			}
			// place: zone-map percent by zone name -> world yards on the continent.
			let place = place_json.as_ref().and_then(|p| {
				let (x, y) = (p.get("x")?.as_f64()?, p.get("y")?.as_f64()?);
				let ui = *data.zone_ids.get(p.get("zone")?.as_str()?)?;
				let (m, wx, wy) = world(&pr, ui, x, y, "e")?;
				Some(json!({"map": m, "x": num(round_to(wx, 0.5)), "y": num(round_to(wy, 0.5))}))
			});
			let origin = if s.basis.is_empty() { s.source.clone() } else { s.basis.clone() };
			let pr = Prov { sources: vec![origin], confidence: s.confidence.clone() };
			let n = if s.n > 0 {
				s.n
			} else {
				let e = next_n.get_mut(&s.quest).expect("quest");
				*e += 1;
				*e - 1
			};
			let mut r = row_of(&[("quest", json!(s.quest)), ("n", json!(n)), ("id", json!(id)), ("action", json!(s.action))]);
			let mut pv = vec![("_row".to_string(), pr.clone()), ("action".to_string(), pr.clone()), ("id".to_string(), pr.clone())];
			if let Some(p) = place {
				r.insert("place".into(), p);
				pv.push(("place".into(), pr.clone()));
			}
			for (k, v) in [
				("target_kind", (!s.target_kind.is_empty()).then(|| json!(s.target_kind))),
				("target", (s.target > 0).then(|| json!(s.target))),
				("count", (s.count > 0).then(|| json!(s.count))),
				("text", (!s.text.is_empty()).then(|| json!(s.text))),
			] {
				if let Some(v) = v {
					r.insert(k.into(), v);
					pv.push((k.into(), pr.clone()));
				}
			}
			if s.basis == "community" {
				r.insert("confidence".into(), json!("unconfirmed"));
				pv.push(("confidence".into(), pr.clone()));
			}
			push(&mut a.t, "step", r, pv);
		}
	}

	coverage(&mut a.t, inp, &quest_ids, &npc_ids);
	Ok(a.t)
}

fn coverage(t: &mut Tables, inp: &Inputs, quests: &BTreeSet<i64>, npcs: &BTreeSet<i64>) {
	let all_q = inp.kb.map(|k| k.quests.len()).unwrap_or(inp.data.quests.len());
	let with = |table: &str, f: &dyn Fn(&BTreeMap<String, Value>) -> Option<i64>| -> usize { t.by.get(table).into_iter().flatten().filter_map(|r| f(&r.row)).collect::<BTreeSet<i64>>().len() };
	let q = |r: &BTreeMap<String, Value>| r.get("quest").and_then(vi);
	let field = |name: &'static str| move |r: &BTreeMap<String, Value>| if r.contains_key(name) { r.get("id").and_then(vi) } else { None };
	let mut lines = vec![
		("quests published".to_string(), all_q, quests.len()),
		("quests with giver".into(), all_q, with("quest_start", &q)),
		("quests with turn-in".into(), all_q, with("quest_end", &q)),
		("quests with objectives".into(), all_q, with("quest_objective", &q)),
	];
	for f in ["title", "level", "min_level", "races", "classes", "side", "xp", "zone_area", "type", "money_copper"] {
		lines.push((format!("quest {f}"), all_q, with("quest", &field(f))));
	}
	// Prerequisites are empty for most quests: covered over the quests some source (the data build,
	// CMaNGOS, ForeverTDB) links to a prerequisite or breadcrumb ("known chain links").
	let all_ids: BTreeSet<i64> = match inp.kb {
		Some(k) => k.quests.iter().map(|(i, _)| *i).collect(),
		None => inp.data.quests.keys().filter_map(|k| k.parse().ok()).collect(),
	};
	let mut chained: BTreeSet<i64> = BTreeSet::new();
	for id in &all_ids {
		let linked = inp.data.quests.get(&id.to_string()).is_some_and(|bq| ["preAll", "preAny", "pre", "breadcrumbs"].iter().any(|f| !ids(bq.get(*f)).is_empty()))
			|| inp.cm.and_then(|cm| cm.quest.get(id)).is_some_and(|q| q.prev != 0)
			|| inp.tdb.and_then(|t| t.quest.get(id)).is_some_and(|q| q.prev != 0);
		if linked {
			chained.insert(*id);
		}
	}
	let crumbs_cm = inp.cm.into_iter().flat_map(|cm| cm.quest.values().map(|q| q.breadcrumb_for));
	let crumbs_tdb = inp.tdb.into_iter().flat_map(|t| t.quest.values().map(|q| q.breadcrumb_for));
	chained.extend(crumbs_cm.chain(crumbs_tdb).filter(|q| all_ids.contains(q)));
	let with_pre: BTreeSet<i64> = t.by.get("quest_prereq").into_iter().flatten().filter_map(|r| q(&r.row)).collect();
	lines.push(("quests with prerequisites (known chain links)".into(), chained.len(), with_pre.iter().filter(|i| chained.contains(i)).count()));
	let all_n = inp.kb.map(|k| k.npcs.len()).unwrap_or(inp.data.npcs.len());
	let all_o = inp.kb.map(|k| k.objects.len()).unwrap_or(inp.data.objects.len());
	lines.push(("npcs published".into(), all_n, npcs.len()));
	lines.push(("npc faction_template".into(), all_n, with("npc", &field("faction_template"))));
	lines.push(("npc level".into(), all_n, with("npc", &field("level_min"))));
	let spawned = |kind: &str| -> BTreeSet<i64> {
		t.by.get("spawn").into_iter().flatten().filter(|r| r.row.get("kind").and_then(Value::as_str) == Some(kind)).filter_map(|r| r.row.get("id").and_then(vi)).collect()
	};
	let (sn, so) = (spawned("npc"), spawned("object"));
	if let Some(kb) = inp.kb {
		lines.push(("npcs with spawns (of npcs with a known spawn)".into(), kb.npcs_with_spawns.len(), kb.npcs_with_spawns.iter().filter(|i| sn.contains(i)).count()));
		lines.push(("objects with spawns (of objects with a known spawn)".into(), kb.objects_with_spawns.len(), kb.objects_with_spawns.iter().filter(|i| so.contains(i)).count()));
		let src: BTreeSet<i64> = t.by.get("item_source").into_iter().flatten().filter_map(|r| r.row.get("item").and_then(vi)).collect();
		lines.push(("items with drop sources (of items with a known dropper)".into(), kb.drop_items.len(), kb.drop_items.iter().filter(|i| src.contains(i)).count()));
	} else {
		lines.push(("npcs with spawns".into(), all_n, sn.len()));
		lines.push(("objects with spawns".into(), all_o, so.len()));
	}
	t.coverage = lines;
}
