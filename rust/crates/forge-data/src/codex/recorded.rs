//! The Codex's recorded item sources: `data/codex/recorded.json`, a snapshot of what players'
//! Polestar Recorder sessions saw, exported from a recordings folder with
//! `forge data codex --recordings <dir>` and committed, so a build reads only the snapshot and gives
//! the same Codex on every machine.
//!
//! Only the sessions of players that count go in, by the data build's own rule
//! ([`crate::recordings::read_recordings`]: a server contributor counts once established, the
//! maintainer's own and vouched-for files always; config.json's `minBuild`, `minVoters` and
//! thresholds apply), and every value is a fact without who recorded it:
//!
//! - `drops`/`objects`: per NPC or object, each item its loot windows held, with the number of
//!   counted players who saw it and a `chance` (percent, the median of each player's own share of
//!   loot windows) only on trusted evidence: `minVoters` players, or a vouched one, each with at
//!   least [`MIN_WINDOWS`] loot windows of that NPC or object. NPC loot from a gathering skill
//!   (skinning, herbs, ore) is left out.
//! - `vendors`: per NPC, the items its merchant window listed.
//! - `rewards`: per quest, the reward items and choices its accept window showed, the list most
//!   counted players saw (a tie leaves the quest out), with `voters` and `trusted` (`minVoters`
//!   players agree on it, or a vouched one recorded it).
//!
//! The merge (`codex::merge`) adds a recorded drop, object, vendor or reward source like any other
//! input's, under the provenance `recordings`; a quest's trusted reward list replaces the other
//! inputs' rewards for that quest, an untrusted one only fills a quest no other input gives
//! rewards for.

use std::collections::{BTreeMap, BTreeSet};
use std::path::Path;

use forge_guide::js::{parse_json, stringify, Obj, V};
use indexmap::IndexSet;

use super::util::{math_round, nums};
use crate::recordings::{read_recordings, trusted, Recordings};

/// The snapshot's file in data/codex.
pub const FILE: &str = "recorded.json";
/// Loot windows a player needs of an NPC or object before their share counts toward a chance.
pub const MIN_WINDOWS: usize = 10;

fn pos_int(v: &V) -> Option<i64> {
	let n = v.as_num()?;
	(n.is_finite() && n > 0.0 && n.fract() == 0.0).then_some(n as i64)
}

fn median(mut v: Vec<f64>) -> f64 {
	v.sort_by(|a, b| a.partial_cmp(b).unwrap());
	let n = v.len();
	if n % 2 == 1 {
		v[n / 2]
	} else {
		(v[n / 2 - 1] + v[n / 2]) / 2.0
	}
}

#[derive(Default)]
struct Loot {
	/// voter -> loot windows of this source.
	windows: BTreeMap<String, usize>,
	/// item -> voter -> windows holding it.
	items: BTreeMap<i64, BTreeMap<String, usize>>,
}

/// The snapshot of `recs` (every session already marked by `establish`).
pub fn snapshot(recs: &Recordings) -> V {
	let min_voters = recs.min_voters;
	let mut loot: [BTreeMap<i64, Loot>; 2] = [BTreeMap::new(), BTreeMap::new()];
	let mut vendors: BTreeMap<i64, BTreeMap<i64, BTreeSet<String>>> = BTreeMap::new();
	// quest -> voter -> (items, choices), the voter's latest accept window.
	let mut rewards: BTreeMap<i64, BTreeMap<String, (Vec<i64>, Vec<i64>)>> = BTreeMap::new();
	let (mut counted, mut through) = (0usize, 0f64);
	let mut voters: BTreeSet<String> = BTreeSet::new();
	for r in recs.iter() {
		if let Some(t) = r.rec.get("received").as_num().filter(|t| t.is_finite()) {
			through = through.max(t);
		}
		if !r.counts {
			continue;
		}
		counted += 1;
		let who = r.voter();
		voters.insert(who.clone());
		for ev in r.rec.get("events").items() {
			match ev.get("e").as_str() {
				Some("drop") => {
					let (k, id) = match (pos_int(&ev.get("npc")), pos_int(&ev.get("object"))) {
						(Some(n), _) if !ev.get("gather").truthy() => (0, n),
						(Some(_), _) => continue,
						(None, Some(o)) => (1, o),
						_ => continue,
					};
					let l = loot[k].entry(id).or_default();
					*l.windows.entry(who.clone()).or_default() += 1;
					let seen: BTreeSet<i64> = ev.get("items").items().iter().filter_map(|i| pos_int(&i.get("item"))).collect();
					for item in seen {
						*l.items.entry(item).or_default().entry(who.clone()).or_default() += 1;
					}
				}
				Some("vendor") => {
					let Some(npc) = pos_int(&ev.get("npc")) else { continue };
					for i in ev.get("items").items() {
						if let Some(item) = pos_int(&i.get("item")) {
							vendors.entry(npc).or_default().entry(item).or_default().insert(who.clone());
						}
					}
				}
				Some("accept") => {
					let Some(q) = pos_int(&ev.get("q")) else { continue };
					let ids = |k: &str| -> Vec<i64> {
						let mut v: Vec<i64> = ev.get(k).items().iter().filter_map(pos_int).collect();
						v.sort_unstable();
						v.dedup();
						v
					};
					rewards.entry(q).or_default().insert(who.clone(), (ids("items"), ids("choices")));
				}
				_ => {}
			}
		}
	}
	let out = Obj::new();
	let meta = Obj::new();
	meta.set("sessions", recs.len());
	meta.set("counted", counted);
	meta.set("voters", voters.len());
	meta.set("minVoters", min_voters);
	meta.set("minWindows", MIN_WINDOWS);
	meta.set("through", if through > 0.0 { V::Num(through) } else { V::Null });
	out.set("meta", V::Obj(meta));
	for (k, name) in [(0, "drops"), (1, "objects")] {
		let o = Obj::new();
		for (id, l) in &loot[k] {
			let its = Obj::new();
			for (item, by) in &l.items {
				let e = Obj::new();
				e.set("voters", by.len());
				// Each player with enough loot windows of their own: their share.
				let shares: Vec<(String, f64)> = by
					.keys()
					.filter_map(|w| {
						let n = *l.windows.get(w)?;
						(n >= MIN_WINDOWS).then(|| (w.clone(), by[w] as f64 / n as f64 * 100.0))
					})
					.collect();
				let whose: IndexSet<String> = shares.iter().map(|(w, _)| w.clone()).collect();
				// Players with enough windows who never saw the item count as 0%.
				let mut all: Vec<f64> = shares.iter().map(|(_, s)| *s).collect();
				let zero: Vec<String> = l.windows.iter().filter(|(w, n)| **n >= MIN_WINDOWS && !by.contains_key(*w)).map(|(w, _)| w.clone()).collect();
				all.extend(zero.iter().map(|_| 0.0));
				let mut every = whose.clone();
				every.extend(zero);
				let chance = if trusted(&every, min_voters) && !all.is_empty() { math_round(median(all) * 100.0) / 100.0 } else { 0.0 };
				e.set("chance", if chance > 0.0 { V::Num(chance) } else { V::Null });
				its.set(&item.to_string(), V::Obj(e));
			}
			let src = Obj::new();
			src.set("windows", l.windows.values().sum::<usize>());
			src.set("items", V::Obj(its));
			o.set(&id.to_string(), V::Obj(src));
		}
		out.set(name, V::Obj(o));
	}
	let v = Obj::new();
	for (npc, items) in &vendors {
		v.set(&npc.to_string(), nums(&items.keys().map(|i| *i as f64).collect::<Vec<f64>>()));
	}
	out.set("vendors", V::Obj(v));
	let rw = Obj::new();
	for (q, by) in &rewards {
		// The list most players saw; a tie between lists leaves the quest out.
		let mut ballot: BTreeMap<&(Vec<i64>, Vec<i64>), IndexSet<String>> = BTreeMap::new();
		for (w, list) in by {
			ballot.entry(list).or_default().insert(w.clone());
		}
		let best = ballot.values().map(IndexSet::len).max().unwrap_or(0);
		let top: Vec<_> = ballot.iter().filter(|(_, ws)| ws.len() == best).collect();
		if top.len() != 1 {
			continue;
		}
		let ((items, choices), ws) = top[0];
		if items.is_empty() && choices.is_empty() {
			continue;
		}
		let e = Obj::new();
		e.set("items", nums(&items.iter().map(|i| *i as f64).collect::<Vec<f64>>()));
		e.set("choices", nums(&choices.iter().map(|i| *i as f64).collect::<Vec<f64>>()));
		e.set("voters", ws.len());
		e.set("trusted", trusted(ws, min_voters));
		rw.set(&q.to_string(), V::Obj(e));
	}
	out.set("rewards", V::Obj(rw));
	V::Obj(out)
}

/// `forge data codex --recordings <dir>`: the snapshot of the recordings in `dir`, as the file's
/// text.
pub fn export(dir: &Path) -> Result<String, String> {
	let recs = read_recordings(dir)?;
	Ok(format!("{}\n", stringify(&snapshot(&recs), Some("\t"))))
}

/// The committed snapshot (an empty one when the file is missing).
pub fn load(file: &Path) -> Result<V, String> {
	if !file.exists() {
		return Ok(V::obj());
	}
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))
}

/// The snapshot's line in meta.json `sources` (and LICENSE-DATA.txt), when it holds any fact.
pub fn source_meta(rec: &V) -> Option<V> {
	let n = rec.get("drops").len() + rec.get("objects").len() + rec.get("vendors").len() + rec.get("rewards").len();
	if n == 0 {
		return None;
	}
	let m = rec.get("meta");
	let o = Obj::new();
	o.set("name", "Polestar Recorder sessions (data/codex/recorded.json): loot, merchant and quest reward windows");
	o.set(
		"version",
		V::str(&format!(
			"{} sessions of {} counted players; {} NPCs, {} objects, {} vendors, {} quests",
			m.get("counted").to_js_string(),
			m.get("voters").to_js_string(),
			rec.get("drops").len(),
			rec.get("objects").len(),
			rec.get("vendors").len(),
			rec.get("rewards").len()
		)),
	);
	o.set("licence", "Polestar's own recordings: CC BY 4.0; facts only, no player data");
	Some(V::Obj(o))
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::recordings::Recording;

	fn session(who: &str, counts: bool, events: &str) -> Recording {
		let rec = parse_json(&format!(r#"{{"schema":2,"contributor":"{who}","events":[{events}]}}"#)).unwrap();
		Recording { file: format!("{who}.json"), rec, counts }
	}

	fn windows(npc: i64, n: usize, with: usize, item: i64) -> String {
		(0..n)
			.map(
				|i| {
					if i < with {
						format!(r#"{{"e":"drop","npc":{npc},"items":[{{"item":{item},"count":1}},{{"item":2589,"count":1}}]}}"#)
					} else {
						format!(r#"{{"e":"drop","npc":{npc},"items":[]}}"#)
					}
				},
			)
			.collect::<Vec<_>>()
			.join(",")
	}

	#[test]
	fn the_snapshot_keeps_counted_players_facts_and_gives_a_chance_only_on_trusted_evidence() {
		let accept = |q: i64, items: &str, choices: &str| format!(r#"{{"e":"accept","q":{q},"items":[{items}],"choices":[{choices}]}}"#);
		let list = vec![
			session(
				"p1",
				true,
				&[
					windows(100, 10, 2, 5),
					windows(101, 3, 3, 7),
					r#"{"e":"drop","npc":200,"gather":"skin","items":[{"item":2318,"count":1}]}"#.into(),
					accept(7, "", "1,2"),
					accept(8, "3", ""),
					accept(9, "5", ""),
				]
				.join(","),
			),
			session("p2", true, &[windows(100, 10, 3, 5), accept(7, "", "2,1"), accept(8, "4", "")].join(",")),
			session("p3", true, &[windows(100, 20, 8, 5), accept(7, "", "1,2"), r#"{"e":"drop","object":3000,"items":[{"item":2770,"count":2}]}"#.into()].join(",")),
			session("p4", false, &[r#"{"e":"vendor","npc":945,"items":[{"item":2131,"price":54,"stack":1,"qty":-1}]}"#.to_string(), accept(10, "6", "")].join(",")),
			session("p1", true, r#"{"e":"vendor","npc":945,"items":[{"item":2130,"price":54,"stack":1,"qty":-1}]}"#),
		];
		let snap = snapshot(&Recordings { list, min_voters: 3 });
		let s = |v: &V| stringify(v, None);
		// Three players with ten windows each: 20%, 30%, 40%.
		assert_eq!(s(&snap.get("drops").get("100").get("items").get("5")), r#"{"voters":3,"chance":30}"#);
		assert_eq!(s(&snap.get("drops").get("100").get("windows")), "40");
		// One player with three windows: the row, no chance.
		assert_eq!(s(&snap.get("drops").get("101").get("items").get("7")), r#"{"voters":1,"chance":null}"#);
		assert!(snap.get("drops").get("200").is_undef(), "skinning is no drop");
		assert_eq!(s(&snap.get("objects").get("3000").get("items")), r#"{"2770":{"voters":1,"chance":null}}"#);
		// A player who does not count is left out.
		assert_eq!(s(&snap.get("vendors")), r#"{"945":[2130]}"#);
		assert!(snap.get("rewards").get("10").is_undef());
		assert_eq!(s(&snap.get("rewards").get("7")), r#"{"items":[],"choices":[1,2],"voters":3,"trusted":true}"#);
		assert!(snap.get("rewards").get("8").is_undef(), "two players, two lists: a tie");
		assert_eq!(s(&snap.get("rewards").get("9")), r#"{"items":[5],"choices":[],"voters":1,"trusted":false}"#);
		assert_eq!(s(&snap.get("meta")), r#"{"sessions":5,"counted":4,"voters":3,"minVoters":3,"minWindows":10,"through":null}"#);
	}
}
