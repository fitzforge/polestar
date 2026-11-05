//! Stable ids for quest steps and notes, and the note-fix records that survive regeneration
//! (forever-db/corrections/notes.json, applied by `forge data publish`, listed in the generated
//! corrections/LEDGER.md).
//!
//! An id is `<quest>:<s|n>:<h>`, `h` the first 8 hex digits of sha1 over the row's identity parts
//! (a step: action, its targets and items sorted, its place's target; a note: kind, the ids it
//! names, its place's target). The text is not part of it, so a reworded row keeps its id, and
//! the order is not either, so a reordered list keeps its ids. Rows sharing an identity get `-2`,
//! `-3`, ... in generation order.
//!
//! A record, keyed by the id it fixes (an `add` by any name of the contributor's), does one of
//! `set` (fields: fact, basis, place, count for steps, kind for notes), `drop`, `add` (a new row,
//! id from the same rule) or `promote` ("game-data": a confirmed community row ships at normal
//! confidence), with `source` { kind, ref } and an own-words `note`. Its status in the ledger:
//! applied, stale (its row is gone, or the release already says what it says) or conflicting
//! (it cannot be applied as written: two things at once, a field the row does not have, a row
//! that changed since the record was written (`was`), an `add` landing on another record's id).

use std::collections::{BTreeMap, BTreeSet};

use serde_json::{json, Map, Value};

use super::tables::{Prov, Rec, Tables};

/// The record source kinds (the corrections' kinds, plus recordings and checks by players).
pub const SOURCE_KINDS: &[&str] = &["in-game-check", "recording", "client", "eg", "cmangos", "tdb", "questie", "pfquest"];

pub const NOTE_KINDS: &[&str] = &["timer", "spawn", "danger", "requirement", "tip"];

fn hash8(s: &str) -> String {
	sha1_smol::Sha1::from(s).digest().bytes().iter().take(4).map(|b| format!("{b:02x}")).collect()
}

fn joined(mut parts: Vec<String>) -> String {
	parts.sort();
	parts.dedup();
	parts.join(",")
}

/// A step's identity: action, targets (type:id), items, the place's target (kind:id).
pub fn step_identity(action: &str, targets: &[(String, i64)], items: &[i64], place: Option<(&str, i64)>) -> String {
	format!(
		"step|{action}|{}|{}|{}",
		joined(targets.iter().map(|(t, i)| format!("{t}:{i}")).collect()),
		joined(items.iter().map(|i| i.to_string()).collect()),
		place.map(|(k, i)| format!("{k}:{i}")).unwrap_or_default()
	)
}

/// A note's identity: kind, the ids it names (type:id), the place's target (kind:id).
pub fn note_identity(kind: &str, subjects: &[(String, i64)], place: Option<(&str, i64)>) -> String {
	format!("note|{kind}|{}|{}", joined(subjects.iter().map(|(t, i)| format!("{t}:{i}")).collect()), place.map(|(k, i)| format!("{k}:{i}")).unwrap_or_default())
}

/// The id's stem (without the sequence suffix): `<quest>:<s|n>:<h>`.
pub fn id_stem(quest: i64, step: bool, identity: &str) -> String {
	format!("{quest}:{}:{}", if step { "s" } else { "n" }, hash8(identity))
}

/// Ids for identities in generation order: the first of a stem gets the stem, later ones `-2`, `-3`.
#[derive(Default)]
pub struct Ids {
	seen: BTreeMap<String, usize>,
}

impl Ids {
	pub fn next(&mut self, quest: i64, step: bool, identity: &str) -> String {
		let stem = id_stem(quest, step, identity);
		let n = self.seen.entry(stem.clone()).or_insert(0);
		*n += 1;
		if *n == 1 {
			stem
		} else {
			format!("{stem}-{n}")
		}
	}
}

fn is_id(key: &str) -> Option<(i64, bool)> {
	let mut it = key.splitn(3, ':');
	let q = it.next()?.parse::<i64>().ok().filter(|q| *q > 0)?;
	let kind = it.next()?;
	let rest = it.next()?;
	let (h, seq) = rest.split_once('-').map_or((rest, None), |(h, s)| (h, Some(s)));
	let ok = h.len() == 8 && h.chars().all(|c| c.is_ascii_hexdigit() && !c.is_ascii_uppercase()) && seq.is_none_or(|s| s.parse::<u32>().is_ok_and(|n| n >= 2));
	match (ok, kind) {
		(true, "s") => Some((q, true)),
		(true, "n") => Some((q, false)),
		_ => None,
	}
}

#[derive(Clone, Debug, PartialEq)]
pub struct LedgerRow {
	pub record: String,
	pub action: String,
	/// The row's id (an `add`: the id it got).
	pub id: String,
	/// applied | stale | conflicting
	pub status: &'static str,
	pub detail: String,
}

enum Act {
	Set(Map<String, Value>, Option<Map<String, Value>>),
	Drop,
	Promote,
	Add { quest: i64, step: bool, row: BTreeMap<String, Value>, identity: String, fact: String },
}

/// A record's shape problems (empty: well formed), and what it does.
fn parse(key: &str, r: &Value) -> Result<Act, String> {
	let o = r.as_object().ok_or("not an object")?;
	for k in o.keys() {
		if !["set", "drop", "add", "promote", "source", "note", "was"].contains(&k.as_str()) {
			return Err(format!("unknown key {k} (allowed: set, drop, add, promote, was, source, note)"));
		}
	}
	let sources: Vec<&Value> = match o.get("source") {
		Some(Value::Array(a)) => a.iter().collect(),
		Some(v) => vec![v],
		None => return Err("no source: { kind, ref }".into()),
	};
	if sources.is_empty() {
		return Err("no source: { kind, ref }".into());
	}
	for s in sources {
		let kind = s.get("kind").and_then(Value::as_str).unwrap_or("");
		if !SOURCE_KINDS.contains(&kind) {
			return Err(format!("source.kind '{kind}' is not one of {}", SOURCE_KINDS.join(", ")));
		}
		if s.get("ref").and_then(Value::as_str).is_none_or(|r| r.trim().is_empty()) {
			return Err("source.ref is empty: an issue link or a recording id".into());
		}
	}
	if o.get("note").and_then(Value::as_str).is_none_or(|n| n.trim().is_empty()) {
		return Err("no note: what the record fixes, in our own words".into());
	}
	let acts: Vec<&str> = ["set", "drop", "add", "promote"].into_iter().filter(|k| o.contains_key(*k)).collect();
	if acts.len() != 1 {
		return Err(format!("a record does one of set, drop, add, promote (this one: {})", if acts.is_empty() { "none".into() } else { acts.join(" and ") }));
	}
	if acts[0] != "add" && is_id(key).is_none() {
		return Err(format!("{key} is not a step or note id (<quest>:s:<8 hex> or <quest>:n:<8 hex>)"));
	}
	let step = is_id(key).is_some_and(|(_, s)| s);
	match acts[0] {
		"drop" => {
			if o["drop"] != json!(true) {
				return Err("drop is true".into());
			}
			Ok(Act::Drop)
		}
		"promote" => {
			if o["promote"] != json!("game-data") {
				return Err("promote is \"game-data\"".into());
			}
			Ok(Act::Promote)
		}
		"set" => {
			let s = o["set"].as_object().filter(|s| !s.is_empty()).ok_or("set is an object of fields")?;
			let allowed: &[&str] = if step { &["fact", "basis", "place", "count"] } else { &["fact", "basis", "place", "kind"] };
			for (k, v) in s {
				if !allowed.contains(&k.as_str()) {
					return Err(format!("set.{k}: a {} has no such field (allowed: {})", if step { "step" } else { "note" }, allowed.join(", ")));
				}
				field_ok(k, v)?;
			}
			let was = match o.get("was") {
				Some(w) => Some(w.as_object().ok_or("was is an object of fields")?.clone()),
				None => None,
			};
			Ok(Act::Set(s.clone(), was))
		}
		_ => {
			let a = o["add"].as_object().ok_or("add is an object")?;
			let quest = a.get("quest").and_then(Value::as_i64).filter(|q| *q > 0).ok_or("add.quest is a quest id")?;
			let fact = a.get("fact").and_then(Value::as_str).filter(|f| !f.trim().is_empty()).ok_or("add.fact is the text")?.to_string();
			let basis = a.get("basis").and_then(Value::as_str).unwrap_or("");
			field_ok("basis", &json!(basis)).map_err(|_| "add.basis is game-data or community".to_string())?;
			let ids = |k: &str| -> Result<Vec<(String, i64)>, String> {
				let mut out = Vec::new();
				for t in a.get(k).and_then(Value::as_array).into_iter().flatten() {
					match (t.get("type").and_then(Value::as_str), t.get("id").and_then(Value::as_i64)) {
						(Some(ty), Some(id)) if id > 0 => out.push((ty.to_string(), id)),
						_ => return Err(format!("add.{k}: [{{ type, id }}]")),
					}
				}
				Ok(out)
			};
			let targets = ids("targets")?;
			let items: Vec<i64> = a.get("items").and_then(Value::as_array).into_iter().flatten().filter_map(Value::as_i64).collect();
			let mut row = BTreeMap::new();
			row.insert("quest".to_string(), json!(quest));
			row.insert("text".to_string(), json!(fact));
			if basis == "community" {
				row.insert("confidence".into(), json!("unconfirmed"));
			}
			if let Some(p) = a.get("place") {
				field_ok("place", p)?;
				row.insert("place".into(), p.clone());
			}
			let (step, identity) = match (a.get("action").and_then(Value::as_str), a.get("kind").and_then(Value::as_str)) {
				(Some(action), None) => {
					row.insert("action".into(), json!(action));
					if let Some((t, i)) = targets.first() {
						row.insert("target_kind".into(), json!(t));
						row.insert("target".into(), json!(i));
					}
					if let Some(c) = a.get("count") {
						field_ok("count", c)?;
						row.insert("count".into(), c.clone());
					}
					(true, step_identity(action, &targets, &items, None))
				}
				(None, Some(kind)) => {
					field_ok("kind", &json!(kind))?;
					row.insert("kind".into(), json!(kind));
					let mut subjects = targets.clone();
					subjects.extend(items.iter().map(|i| ("item".to_string(), *i)));
					(false, note_identity(kind, &subjects, None))
				}
				_ => return Err("add has an action (a step) or a kind (a note), not both".into()),
			};
			Ok(Act::Add { quest, step, row, identity, fact })
		}
	}
}

fn field_ok(k: &str, v: &Value) -> Result<(), String> {
	let ok = match k {
		"fact" => v.as_str().is_some_and(|s| !s.trim().is_empty()),
		"basis" => matches!(v.as_str(), Some("game-data" | "community")),
		"count" => v.as_i64().is_some_and(|n| n > 0),
		"kind" => v.as_str().is_some_and(|s| NOTE_KINDS.contains(&s)),
		"place" => super::schema::validate(super::schema::table("note").unwrap(), &json!({"quest": 1, "id": "x", "kind": "tip", "text": "x", "place": v})).is_ok(),
		_ => false,
	};
	if ok {
		Ok(())
	} else {
		Err(format!("{k}: {v} is not valid (fact: text; basis: game-data or community; place: {{map, x, y}} in world yards; count: a positive number; kind: {})", NOTE_KINDS.join(", ")))
	}
}

/// Shape problems of a notes.json text, as (record, problem); for `forge data check-corrections`.
pub fn shape_problems(v: &Value) -> Vec<(String, String)> {
	let Some(o) = v.as_object() else { return vec![(String::new(), "notes.json is an object keyed by id".into())] };
	o.iter().filter(|(k, _)| !k.starts_with('_')).filter_map(|(k, r)| parse(k, r).err().map(|e| (k.clone(), e))).collect()
}

/// The release row a `set` field writes, as (column, value; None removes it).
fn column(k: &str, v: &Value) -> (&'static str, Option<Value>) {
	match k {
		"fact" => ("text", Some(v.clone())),
		"basis" => ("confidence", (v == "community").then(|| json!("unconfirmed"))),
		"place" => ("place", Some(v.clone())),
		"count" => ("count", Some(v.clone())),
		_ => ("kind", Some(v.clone())),
	}
}

fn set_prov(rec: &mut Rec, col: &str, p: &Prov) {
	rec.prov.retain(|(f, _)| f != col);
	rec.prov.push((col.to_string(), p.clone()));
}

/// Applies the records to the step and note tables; the ledger rows sorted by record.
pub fn apply(t: &mut Tables, records: &Value, published: &BTreeSet<i64>) -> Vec<LedgerRow> {
	let corr = Prov::of(&["correction"]);
	let mut out: Vec<LedgerRow> = Vec::new();
	let Some(recs) = records.as_object() else { return out };
	let mut keys: Vec<&String> = recs.keys().filter(|k| !k.starts_with('_')).collect();
	keys.sort();
	let mut parsed: Vec<(String, Result<Act, String>)> = keys.iter().map(|k| ((*k).clone(), parse(k, &recs[*k]))).collect();
	// Every id the generator wrote (adds never take one, even a dropped one).
	let mut taken: BTreeSet<String> = BTreeSet::new();
	for table in ["step", "note"] {
		for r in t.by.get(table).into_iter().flatten() {
			if let Some(id) = r.row.get("id").and_then(Value::as_str) {
				taken.insert(id.to_string());
			}
		}
	}
	let find = |t: &Tables, id: &str| -> Option<(&'static str, usize)> {
		let table = if is_id(id)?.1 { "step" } else { "note" };
		t.by.get(table)?.iter().position(|r| r.row.get("id").and_then(Value::as_str) == Some(id)).map(|i| (table, i))
	};
	// adds: their ids first, so an add landing on another record's key conflicts with it
	let mut add_ids: BTreeMap<String, String> = BTreeMap::new();
	for (k, a) in &parsed {
		if let Ok(Act::Add { quest, step, identity, .. }) = a {
			let stem = id_stem(*quest, *step, identity);
			let mut id = stem.clone();
			let mut n = 1;
			while taken.contains(&id) || add_ids.values().any(|v| *v == id) {
				n += 1;
				id = format!("{stem}-{n}");
			}
			add_ids.insert(k.clone(), id);
		}
	}
	let clash: BTreeSet<String> = add_ids.iter().filter(|(k, id)| recs.contains_key(id.as_str()) && *id != *k).flat_map(|(k, id)| [k.clone(), id.clone()]).collect();
	for (key, a) in parsed.iter_mut() {
		let k: &str = key.as_str();
		let mut row = |action: &str, id: &str, status: &'static str, detail: String| out.push(LedgerRow { record: k.to_string(), action: action.into(), id: id.into(), status, detail });
		let a = match a {
			Err(e) => {
				row("?", "", "conflicting", e.clone());
				continue;
			}
			Ok(a) => a,
		};
		if clash.contains(k) {
			let other = add_ids.get(k).cloned().unwrap_or_else(|| add_ids.iter().find(|(_, v)| v.as_str() == k).map(|(x, _)| x.clone()).unwrap_or_default());
			let id = add_ids.get(k).map_or(k, String::as_str);
			row(
				match a {
					Act::Add { .. } => "add",
					Act::Set(..) => "set",
					Act::Drop => "drop",
					Act::Promote => "promote",
				},
				id,
				"conflicting",
				format!("an add and another record name the same id ({other})"),
			);
			continue;
		}
		match a {
			Act::Drop => match find(t, k) {
				None => row("drop", k, "stale", "no such row in this release".into()),
				Some((table, i)) => {
					t.by.get_mut(table).unwrap().remove(i);
					row("drop", k, "applied", String::new());
				}
			},
			Act::Promote => match find(t, k) {
				None => row("promote", k, "stale", "no such row in this release".into()),
				Some((table, i)) => {
					let r = &mut t.by.get_mut(table).unwrap()[i];
					if r.row.remove("confidence").is_some() {
						r.prov.retain(|(f, _)| f != "confidence");
						set_prov(r, "_row", &corr);
						row("promote", k, "applied", "community -> game-data".into());
					} else {
						row("promote", k, "stale", "already game data".into());
					}
				}
			},
			Act::Set(s, was) => {
				let fields: Vec<&String> = s.keys().collect();
				let what = format!("set {}", fields.iter().map(|f| f.as_str()).collect::<Vec<_>>().join(", "));
				match find(t, k) {
					None => row(&what, k, "stale", "no such row in this release".into()),
					Some((table, i)) => {
						let r = &mut t.by.get_mut(table).unwrap()[i];
						let current = |f: &str, v: &Value| -> bool {
							let (col, want) = column(f, v);
							r.row.get(col) == want.as_ref()
						};
						if s.iter().all(|(f, v)| current(f, v)) {
							row(&what, k, "stale", "the release already says this".into());
							continue;
						}
						if let Some(w) = was {
							if let Some((f, _)) = w.iter().find(|(f, v)| !current(f, v) && s.get(*f).is_none_or(|sv| !current(f, sv))) {
								row(&what, k, "conflicting", format!("the row's {f} changed since the record was written (was)"));
								continue;
							}
						}
						for (f, v) in s.iter() {
							let (col, want) = column(f, v);
							match want {
								Some(v) => {
									r.row.insert(col.into(), v);
									set_prov(r, col, &corr);
								}
								None => {
									r.row.remove(col);
									r.prov.retain(|(x, _)| x != col);
								}
							}
						}
						row(&what, k, "applied", String::new());
					}
				}
			}
			Act::Add { quest, step, row: new, fact, .. } => {
				let id = add_ids[k].clone();
				let table = if *step { "step" } else { "note" };
				if !published.contains(quest) {
					row("add", &id, "stale", format!("quest {quest} is not in this release"));
					continue;
				}
				let stem = id.split('-').next().unwrap_or(&id).to_string();
				let have =
					t.by.get(table).into_iter().flatten().any(|r| {
						r.row.get("id").and_then(Value::as_str).is_some_and(|x| x.split('-').next() == Some(stem.as_str())) && r.row.get("text").and_then(Value::as_str) == Some(fact.as_str())
					});
				if have {
					row("add", &id, "stale", "the release already has this row".into());
					continue;
				}
				let mut new = std::mem::take(new);
				new.insert("id".into(), json!(id));
				if *step {
					let n =
						t.by.get("step")
							.into_iter()
							.flatten()
							.filter(|r| r.row.get("quest").and_then(Value::as_i64) == Some(*quest))
							.filter_map(|r| r.row.get("n").and_then(Value::as_i64))
							.max()
							.unwrap_or(0) + 1;
					new.insert("n".into(), json!(n));
				}
				let prov: Vec<(String, Prov)> =
					std::iter::once("_row".to_string()).chain(new.keys().filter(|c| !matches!(c.as_str(), "quest" | "n" | "id")).cloned()).map(|c| (c, corr.clone())).collect();
				t.by.entry(table).or_default().push(Rec { row: new, prov });
				row("add", &id, "applied", String::new());
			}
		}
	}
	out
}

/// corrections/LEDGER.md.
pub fn ledger_md(rows: &[LedgerRow]) -> String {
	let n = |s: &str| rows.iter().filter(|r| r.status == s).count();
	let mut s = format!(
		"# Note fixes ledger\n\nGenerated by `forge data publish` from `notes.json`: what each note-fix record did to this\nrelease. Do not edit; fix the record instead. `forge data publish --check` fails on a conflicting\nrecord and warns on a stale one.\n\nApplied {}, stale {}, conflicting {}.\n",
		n("applied"),
		n("stale"),
		n("conflicting")
	);
	if rows.is_empty() {
		s.push_str("\nNo records.\n");
		return s;
	}
	s.push_str("\n| record | action | id | status | detail |\n|---|---|---|---|---|\n");
	let esc = |x: &str| x.replace('|', "\\|").replace('\n', " ");
	for r in rows {
		s.push_str(&format!("| `{}` | {} | `{}` | {} | {} |\n", esc(&r.record), esc(&r.action), esc(&r.id), r.status, esc(&r.detail)));
	}
	s
}

/// The (record, status, detail) rows of a LEDGER.md.
pub fn ledger_parse(text: &str) -> Vec<(String, String, String)> {
	text.lines()
		.filter(|l| l.starts_with("| `"))
		.filter_map(|l| {
			let cells: Vec<&str> = l.trim_matches('|').split(" | ").map(str::trim).collect();
			(cells.len() >= 5).then(|| (cells[0].trim_matches('`').to_string(), cells[3].to_string(), cells[4].to_string()))
		})
		.collect()
}

#[cfg(test)]
mod tests {
	use super::*;

	fn rec(row: Value) -> Rec {
		let row: BTreeMap<String, Value> = row.as_object().unwrap().iter().map(|(k, v)| (k.clone(), v.clone())).collect();
		Rec { row, prov: vec![("_row".into(), Prov::of(&["game-data"]))] }
	}

	fn ids_of(steps: &[(&str, Vec<(String, i64)>, Vec<i64>)]) -> Vec<String> {
		let mut ids = Ids::default();
		steps.iter().map(|(a, t, i)| ids.next(7, true, &step_identity(a, t, i, None))).collect()
	}

	#[test]
	fn ids_survive_rewording_and_reordering() {
		let kill = ("kill", vec![("npc".to_string(), 10)], vec![]);
		let loot = ("loot", vec![("item".to_string(), 20), ("npc".to_string(), 10)], vec![20]);
		let turn = ("turn-in", vec![("npc".to_string(), 11)], vec![20]);
		let a = ids_of(&[kill.clone(), loot.clone(), turn.clone()]);
		// reordered: each row keeps its id
		let b = ids_of(&[turn.clone(), kill.clone(), loot.clone()]);
		assert_eq!(a[0], b[1]);
		assert_eq!(a[1], b[2]);
		assert_eq!(a[2], b[0]);
		// targets listed in another order: the same identity
		let loot2 = ("loot", vec![("npc".to_string(), 10), ("item".to_string(), 20)], vec![20]);
		assert_eq!(ids_of(&[loot2])[0], a[1]);
		// the text is not part of the identity at all (the shape of an id)
		assert!(a[0].starts_with("7:s:") && a[0].len() == "7:s:".len() + 8, "{}", a[0]);
		// two rows with one identity: -2 in generation order
		let c = ids_of(&[kill.clone(), kill.clone(), kill]);
		assert_eq!(c[1], format!("{}-2", c[0]));
		assert_eq!(c[2], format!("{}-3", c[0]));
		// a note's id: kind, subjects, place target
		let n1 = id_stem(7, false, &note_identity("timer", &[], None));
		let n2 = id_stem(7, false, &note_identity("timer", &[], Some(("npc", 5))));
		assert!(n1.starts_with("7:n:") && n1 != n2);
	}

	fn table() -> Tables {
		let mut t = Tables::default();
		let mut ids = Ids::default();
		let s1 = ids.next(7, true, &step_identity("kill", &[("npc".into(), 10)], &[], None));
		let s2 = ids.next(7, true, &step_identity("turn-in", &[("npc".into(), 11)], &[], None));
		let n1 = ids.next(7, false, &note_identity("tip", &[], None));
		t.by.insert(
			"step",
			vec![
				rec(json!({"quest": 7, "n": 1, "id": s1, "action": "kill", "text": "Kill ten wolves."})),
				rec(json!({"quest": 7, "n": 2, "id": s2, "action": "turn-in", "text": "Hand it in.", "confidence": "unconfirmed"})),
			],
		);
		t.by.insert("note", vec![rec(json!({"quest": 7, "id": n1, "kind": "tip", "text": "Go at night.", "confidence": "unconfirmed"}))]);
		t
	}

	fn src() -> Value {
		json!({"kind": "in-game-check", "ref": "issue 1"})
	}

	#[test]
	fn records_apply_go_stale_conflict_and_promote() {
		let mut t = table();
		let s1 = t.by["step"][0].row["id"].as_str().unwrap().to_string();
		let s2 = t.by["step"][1].row["id"].as_str().unwrap().to_string();
		let n1 = t.by["note"][0].row["id"].as_str().unwrap().to_string();
		let add_id = id_stem(7, false, &note_identity("danger", &[("npc".into(), 12)], None));
		let records = json!({
			s1.clone(): {"set": {"fact": "Kill ten grey wolves."}, "source": src(), "note": "the wolves are grey"},
			s2.clone(): {"promote": "game-data", "source": src(), "note": "checked in game"},
			n1.clone(): {"drop": true, "source": src(), "note": "wrong"},
			"7:s:00000000": {"drop": true, "source": src(), "note": "a row that is gone"},
			"7:n:00000001": {"set": {"fact": "x"}, "drop": true, "source": src(), "note": "two things"},
			"7:s:00000002": {"set": {"kind": "tip"}, "source": src(), "note": "a step has no kind"},
			"new-danger": {"add": {"quest": 7, "kind": "danger", "fact": "An elite patrols the road.", "basis": "community", "targets": [{"type": "npc", "id": 12}]}, "source": src(), "note": "seen"},
			"new-elsewhere": {"add": {"quest": 99, "action": "talk", "fact": "Talk to him.", "basis": "community"}, "source": src(), "note": "seen"},
			"no-source": {"add": {"quest": 7, "action": "talk", "fact": "Talk."}, "note": "seen"}
		});
		let ledger = apply(&mut t, &records, &BTreeSet::from([7]));
		let status = |k: &str| ledger.iter().find(|r| r.record == k).map(|r| r.status).unwrap();
		assert_eq!(status(&s1), "applied");
		assert_eq!(t.by["step"][0].row["text"], "Kill ten grey wolves.");
		assert_eq!(t.by["step"][0].row["id"], s1.as_str(), "a set keeps the id");
		assert_eq!(status(&s2), "applied");
		assert!(!t.by["step"][1].row.contains_key("confidence"), "promoted: no longer unconfirmed");
		assert_eq!(status(&n1), "applied");
		assert!(!t.by["note"].iter().any(|r| r.row["id"] == n1.as_str()));
		assert_eq!(status("7:s:00000000"), "stale");
		assert_eq!(status("7:n:00000001"), "conflicting");
		assert_eq!(status("7:s:00000002"), "conflicting");
		assert_eq!(status("new-danger"), "applied");
		let added = t.by["note"].iter().find(|r| r.row["id"] == add_id.as_str()).expect("added note");
		assert_eq!(added.row["confidence"], "unconfirmed");
		assert_eq!(status("new-elsewhere"), "stale");
		assert_eq!(status("no-source"), "conflicting");
		// the same records again on the fixed release: the set and the promote are stale now
		let again = apply(&mut t, &records, &BTreeSet::from([7]));
		let status = |k: &str| again.iter().find(|r| r.record == k).map(|r| r.status).unwrap();
		assert_eq!(status(&s1), "stale");
		assert_eq!(status(&s2), "stale");
		assert_eq!(status("new-danger"), "stale");
		// the ledger round-trips through its markdown
		let md = ledger_md(&ledger);
		let parsed = ledger_parse(&md);
		assert_eq!(parsed.len(), ledger.len());
		assert!(parsed.iter().any(|(k, s, _)| *k == s1 && s == "applied"));
	}

	#[test]
	fn a_record_written_against_an_old_row_conflicts() {
		let mut t = table();
		let s1 = t.by["step"][0].row["id"].as_str().unwrap().to_string();
		let records = json!({ s1.clone(): {"set": {"fact": "Kill ten grey wolves."}, "was": {"fact": "Kill wolves."}, "source": src(), "note": "x"} });
		let ledger = apply(&mut t, &records, &BTreeSet::from([7]));
		assert_eq!(ledger[0].status, "conflicting", "{ledger:?}");
		assert_eq!(t.by["step"][0].row["text"], "Kill ten wolves.");
		// an add landing on the id another record names
		let mut t = table();
		let n1 = t.by["note"][0].row["id"].as_str().unwrap().to_string();
		t.by.get_mut("note").unwrap().clear();
		let records = json!({
			n1.clone(): {"set": {"fact": "Go by day."}, "source": src(), "note": "x"},
			"again": {"add": {"quest": 7, "kind": "tip", "fact": "Go by day.", "basis": "community"}, "source": src(), "note": "x"}
		});
		let ledger = apply(&mut t, &records, &BTreeSet::from([7]));
		assert!(ledger.iter().all(|r| r.status == "conflicting"), "{ledger:?}");
	}
}
