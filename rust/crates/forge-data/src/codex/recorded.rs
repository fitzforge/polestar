//! The Codex's recorded item sources: `data/codex/recorded.json`, a snapshot of what players'
//! Polestar Recorder sessions saw, exported from a recordings folder with
//! `forge data codex --recordings <dir>` and committed, so a build reads only the snapshot and gives
//! the same Codex on every machine.
//!
//! Who counts is the trusted-recordings rule, as `forge record learn` reads the archive: a session
//! counts when its player is established ([`crate::recordings::establish_heads`]: a server
//! contributor once the server has seen 3 days of it and uploads on 3 days, the maintainer's own
//! and vouched-for files always; config.json's `minBuild`, `minVoters` and thresholds apply);
//! contributors config.json's `exclude` lists, or IngestAudit's verdicts mark `exclude` or
//! `suspect`, never count; and a player is a person, the server's cohort merged with every
//! contributor the verdicts say is the same person, with one vote per fact. The folder is read one
//! session at a time, twice: who counts, then what they saw. Every value is a fact without who
//! recorded it:
//!
//! - `drops`/`objects`: per NPC or object, each item its loot windows held, with the number of
//!   people who saw it (`voters`), a `chance` ([`crate::recordings::drop_chance`]: percent, the
//!   median of each person's own share of kills or loot windows) only on trusted evidence
//!   (`minVoters` people, or a vouched one, each with at least [`MIN_WINDOWS`] kills, or loot
//!   windows for an object, of that source), and `trusted` when `minVoters` people saw it, a vouched
//!   one did, or a trusted chance backs it. NPC loot from a gathering skill (skinning, herbs, ore) is
//!   left out.
//! - `vendors`: per NPC, each item its merchant window listed, with `voters` and `trusted`.
//! - `rewards`: per quest, the reward items and choices its quest frames showed
//!   ([`crate::recordings::observe_reward`] and [`crate::recordings::Ballot::decide`]: a turn-in
//!   ranks over an accept per person, vouched evidence ranks first, and the first recorded breaks a
//!   tie), with `voters` and `trusted` (`minVoters` people agree on it, or a vouched one recorded
//!   it).
//!
//! The merge (`codex::merge`) adds a recorded fact under the provenance `recordings`, by one rule: it
//! changes what the Codex says only when it is `trusted`; otherwise it only confirms another input
//! (a drop, object or vendor source the same NPC or object already has there). A trusted reward
//! list stands in for the web lists' rewards for that quest; an untrusted one adds nothing.

use std::collections::{BTreeMap, BTreeSet};
use std::path::Path;

use forge_guide::js::{parse_json, stringify, Obj, V};
use indexmap::{IndexMap, IndexSet};
use rustc_hash::FxHashMap;

use crate::learn::{read_verdicts, session_files, Verdicts};
use crate::recordings::{drop_chance, drop_samples, establish_heads, observe_reward, read_config, reward_ballot, trusted, vouched, Head, MIN_KILLS};

/// The snapshot's file in data/codex.
pub const FILE: &str = "recorded.json";
/// Kills (or loot windows, for an object) a person needs of a source before their share counts
/// toward a trusted drop chance.
pub const MIN_WINDOWS: usize = MIN_KILLS as usize;

fn pos_int(v: &V) -> Option<i64> {
	let n = v.as_num()?;
	(n.is_finite() && n > 0.0 && n.fract() == 0.0).then_some(n as i64)
}

#[derive(Default)]
struct Loot {
	/// person -> loot windows of this source.
	windows: IndexMap<usize, f64>,
	/// item -> person -> windows holding it.
	items: BTreeMap<i64, IndexMap<usize, f64>>,
}

/// What the snapshot gathers from the sessions that count, per person (an index into `people`).
#[derive(Default)]
struct Gather {
	/// The people whose sessions count, by name ([`crate::recordings::trusted`] reads names).
	people: IndexSet<String>,
	kills: BTreeMap<i64, IndexMap<usize, f64>>,
	loot: [BTreeMap<i64, Loot>; 2],
	vendors: BTreeMap<i64, BTreeMap<i64, BTreeSet<usize>>>,
	rewards: BTreeMap<i64, IndexMap<String, (u8, V)>>,
	counted: usize,
}

/// What reading the sessions found besides their facts: the snapshot's `meta`.
struct Read {
	/// Sessions of a counted build (`minBuild`).
	sessions: usize,
	/// Of them, sessions of contributors config.json or the verdicts leave out.
	excluded: usize,
	/// The newest session's arrival on the server.
	through: f64,
	/// The verdicts' `generated` stamp.
	verdicts: Option<String>,
	min_voters: usize,
}

impl Gather {
	/// One counted session of `person`.
	fn add(&mut self, person: &str, rec: &V) {
		self.counted += 1;
		let p = match self.people.get_index_of(person) {
			Some(i) => i,
			None => self.people.insert_full(person.to_string()).0,
		};
		let schema2 = rec.get("schema").as_num() == Some(2.0);
		for ev in rec.get("events").items() {
			match ev.get("e").as_str() {
				Some("slain") => {
					if let Some(npc) = pos_int(&ev.get("npc")).filter(|_| !ev.get("denied").truthy()) {
						*self.kills.entry(npc).or_default().entry(p).or_insert(0.0) += 1.0;
					}
				}
				Some("kill") if schema2 => {
					if let Some(npc) = pos_int(&ev.get("npc")).filter(|_| !ev.get("denied").truthy()) {
						*self.kills.entry(npc).or_default().entry(p).or_insert(0.0) += 1.0;
					}
				}
				Some("drop") => {
					let (k, id) = match (pos_int(&ev.get("npc")), pos_int(&ev.get("object"))) {
						(Some(n), _) if !ev.get("gather").truthy() => (0, n),
						(Some(_), _) => continue,
						(None, Some(o)) => (1, o),
						_ => continue,
					};
					let l = self.loot[k].entry(id).or_default();
					*l.windows.entry(p).or_insert(0.0) += 1.0;
					let seen: BTreeSet<i64> = ev.get("items").items().iter().filter_map(|i| pos_int(&i.get("item"))).collect();
					for item in seen {
						*l.items.entry(item).or_default().entry(p).or_insert(0.0) += 1.0;
					}
				}
				Some("vendor") => {
					let Some(npc) = pos_int(&ev.get("npc")) else { continue };
					for i in ev.get("items").items() {
						if let Some(item) = pos_int(&i.get("item")) {
							self.vendors.entry(npc).or_default().entry(item).or_default().insert(p);
						}
					}
				}
				Some("accept") => {
					if let Some(q) = pos_int(&ev.get("q")) {
						observe_reward(self.rewards.entry(q).or_default(), &ev, 1, person);
					}
				}
				Some("turnin") => {
					if let Some(q) = pos_int(&ev.get("q")) {
						observe_reward(self.rewards.entry(q).or_default(), &ev, 2, person);
					}
				}
				_ => {}
			}
		}
	}

	/// The snapshot.
	fn finish(self, read: &Read) -> V {
		let min_voters = read.min_voters;
		let name = |p: &usize| self.people[*p].clone();
		let out = Obj::new();
		let meta = Obj::new();
		meta.set("sessions", read.sessions);
		meta.set("counted", self.counted);
		meta.set("voters", self.people.len());
		meta.set("excluded", read.excluded);
		meta.set("verdicts", read.verdicts.as_deref().map_or(V::Null, V::str));
		meta.set("minVoters", min_voters);
		meta.set("minWindows", MIN_WINDOWS);
		meta.set("through", if read.through > 0.0 { V::Num(read.through) } else { V::Null });
		out.set("meta", V::Obj(meta));
		for (k, kind) in [(0, "drops"), (1, "objects")] {
			let o = Obj::new();
			for (id, l) in &self.loot[k] {
				let of_by = drop_samples(k == 0, Some(&l.windows), self.kills.get(id));
				let its = Obj::new();
				for (item, by) in &l.items {
					let chance = drop_chance(&of_by, by, min_voters, name).filter(|dc| dc.trusted).map(|dc| dc.chance);
					let e = Obj::new();
					e.set("voters", by.len());
					e.set("chance", chance.map_or(V::Null, V::Num));
					e.set("trusted", chance.is_some() || backed(&self.people, by.keys(), min_voters));
					its.set(&item.to_string(), V::Obj(e));
				}
				let src = Obj::new();
				src.set("windows", l.windows.values().sum::<f64>() as usize);
				src.set("items", V::Obj(its));
				o.set(&id.to_string(), V::Obj(src));
			}
			out.set(kind, V::Obj(o));
		}
		let v = Obj::new();
		for (npc, items) in &self.vendors {
			let its = Obj::new();
			for (item, by) in items {
				let e = Obj::new();
				e.set("voters", by.len());
				e.set("trusted", backed(&self.people, by.iter(), min_voters));
				its.set(&item.to_string(), V::Obj(e));
			}
			v.set(&npc.to_string(), V::Obj(its));
		}
		out.set("vendors", V::Obj(v));
		let rw = Obj::new();
		for (q, by) in &self.rewards {
			let ballot = reward_ballot(by);
			let Some((r, tr)) = ballot.decide(false, min_voters) else { continue };
			if r.get("items").items().is_empty() && r.get("choices").items().is_empty() {
				continue;
			}
			let (_, ws) = ballot.best().unwrap();
			let e = Obj::new();
			e.set("items", r.get("items"));
			e.set("choices", r.get("choices"));
			e.set("voters", ws.len());
			e.set("trusted", tr);
			rw.set(&q.to_string(), V::Obj(e));
		}
		out.set("rewards", V::Obj(rw));
		V::Obj(out)
	}
}

/// Whether these people's evidence is trusted ([`trusted`]: `min` of them, or a vouched one).
fn backed<'a>(people: &IndexSet<String>, by: impl Iterator<Item = &'a usize>, min: usize) -> bool {
	trusted(&by.map(|p| people[*p].clone()).collect::<IndexSet<String>>(), min)
}

fn find(parent: &mut [usize], mut i: usize) -> usize {
	while parent[i] != i {
		parent[i] = parent[parent[i]];
		i = parent[i];
	}
	i
}

/// The person each session (its header, after [`establish_heads`]) is, and whether that person
/// counts: the session's voter (the server's cohort, else the contributor), merged with every
/// contributor the verdicts say is the same person; a person counts when any of its sessions
/// does. A person is named after a vouched voter of it when it has one (`local`, `sent-*`:
/// [`crate::recordings::trusted`] reads names), else after its first voter.
fn people(heads: &[Head], counts: &[bool], v: &Verdicts) -> Vec<(String, bool)> {
	let mut ix: FxHashMap<String, usize> = FxHashMap::default();
	let mut names: Vec<String> = Vec::new();
	let mut parent: Vec<usize> = Vec::new();
	let mut node = |s: String, names: &mut Vec<String>, parent: &mut Vec<usize>| -> usize {
		*ix.entry(s).or_insert_with_key(|k| {
			names.push(k.clone());
			parent.push(parent.len());
			parent.len() - 1
		})
	};
	let mut base: Vec<usize> = Vec::with_capacity(heads.len());
	for h in heads {
		let a = node(h.voter(), &mut names, &mut parent);
		if let Some(p) = v.person.get(&h.contributor) {
			let b = node(format!("person\0{p}"), &mut names, &mut parent);
			let (ra, rb) = (find(&mut parent, a), find(&mut parent, b));
			if ra != rb {
				// The smaller index roots the group: always a session's voter, made before its person.
				parent[ra.max(rb)] = ra.min(rb);
			}
		}
		base.push(a);
	}
	let roots: Vec<usize> = base.iter().map(|a| find(&mut parent, *a)).collect();
	let mut named: FxHashMap<usize, usize> = FxHashMap::default();
	let mut counted: FxHashMap<usize, bool> = FxHashMap::default();
	for ((a, r), c) in base.iter().zip(&roots).zip(counts) {
		if vouched(&names[*a]) {
			named.entry(*r).or_insert(*a);
		}
		*counted.entry(*r).or_default() |= *c;
	}
	roots.iter().map(|r| (names[*named.get(r).unwrap_or(r)].clone(), counted[r])).collect()
}

/// `forge data codex --recordings <dir> [--verdicts <verdict.json>]`: the snapshot of the recordings
/// in `dir` (`verdicts`: IngestAudit's), as the file's text, and a line saying what it read.
pub fn export(dir: &Path, verdicts: Option<&Path>) -> Result<(String, String), String> {
	let cfg = read_config(dir)?;
	let v = match verdicts {
		Some(f) => read_verdicts(f)?,
		None => Verdicts::default(),
	};
	let files = session_files(dir)?;
	let read = |f: &str| -> Result<Option<V>, String> {
		let p = dir.join(f);
		let text = std::fs::read_to_string(&p).map_err(|e| format!("{}: {e}", p.display()))?;
		Ok(parse_json(&text).ok().filter(|rec| matches!(rec.get("schema").as_num(), Some(1.0) | Some(2.0)) && rec.get("events").is_arr()))
	};
	// Who counts and who is one person, from each session's header (its events dropped once read).
	let mut r = Read { sessions: 0, excluded: 0, through: 0.0, verdicts: v.generated.clone(), min_voters: cfg.min_voters };
	let (mut heads, mut kept, mut unreadable) = (Vec::new(), Vec::new(), 0usize);
	for (i, f) in files.iter().enumerate() {
		let Some(rec) = read(f)? else {
			unreadable += 1;
			continue;
		};
		if let (Some(min), Some(build)) = (cfg.min_build, rec.get("build").as_num()) {
			if build < min {
				continue;
			}
		}
		r.sessions += 1;
		if let Some(t) = rec.get("received").as_num().filter(|t| t.is_finite()) {
			r.through = r.through.max(t);
		}
		let head = Head::of(&rec);
		if cfg.exclude.contains(&head.contributor) || v.out.contains(&head.contributor) {
			r.excluded += 1;
			continue;
		}
		heads.push(head);
		kept.push(i);
	}
	let counts = establish_heads(&mut heads, cfg.establish);
	let who = people(&heads, &counts, &v);
	// What the sessions that count saw, one session at a time.
	let mut g = Gather::default();
	for (i, (person, counted)) in kept.iter().zip(&who) {
		if !*counted {
			continue;
		}
		let Some(rec) = read(&files[*i])? else { continue };
		g.add(person, &rec);
	}
	let summary = format!(
		"{} sessions read ({} of contributors left out by config.json or the verdicts, {} unreadable files); {} counted, from {} people; verdicts {}",
		r.sessions,
		r.excluded,
		unreadable,
		g.counted,
		g.people.len(),
		r.verdicts.as_deref().unwrap_or("none")
	);
	Ok((format!("{}\n", stringify(&g.finish(&r), Some("\t"))), summary))
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
	use crate::recordings::{apply_recordings, Db, Recording, Recordings};
	use crate::spawns::DEFAULTS;

	/// The snapshot of sessions already marked by `establish`, one person per [`Recording::voter`] (what
	/// `export` gathers once it knows who counts).
	fn snapshot(recs: &Recordings) -> V {
		let mut g = Gather::default();
		let mut through = 0f64;
		for r in recs.iter() {
			if let Some(t) = r.rec.get("received").as_num().filter(|t| t.is_finite()) {
				through = through.max(t);
			}
			if r.counts {
				g.add(&r.voter(), &r.rec);
			}
		}
		g.finish(&Read { sessions: recs.len(), excluded: 0, through, verdicts: None, min_voters: recs.min_voters })
	}

	fn session(who: &str, counts: bool, events: &str) -> Recording {
		let rec = parse_json(&format!(r#"{{"schema":2,"contributor":"{who}","locale":"enUS","events":[{events}]}}"#)).unwrap();
		Recording { file: format!("{who}.json"), rec, counts }
	}

	fn kills_and_drops(npc: i64, kills: usize, drops: usize, item: i64) -> String {
		(0..kills)
			.flat_map(|i| {
				let mut v = vec![format!(r#"{{"e":"kill","npc":{npc},"cls":"normal"}}"#)];
				if i < drops {
					v.push(format!(r#"{{"e":"drop","npc":{npc},"items":[{{"item":{item},"count":1}},{{"item":2589,"count":1}}]}}"#));
				}
				v
			})
			.collect::<Vec<_>>()
			.join(",")
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
		let turnin = |q: i64, items: &str, choices: &str| format!(r#"{{"e":"turnin","q":{q},"items":[{items}],"choices":[{choices}]}}"#);
		let list = vec![
			session(
				"p1",
				true,
				&[
					kills_and_drops(100, 10, 2, 5),
					kills_and_drops(101, 3, 3, 7),
					r#"{"e":"drop","npc":200,"gather":"skin","items":[{"item":2318,"count":1}]}"#.into(),
					accept(7, "", "1,2"),
					accept(8, "3", ""),
					accept(9, "5", ""),
				]
				.join(","),
			),
			session("p2", true, &[kills_and_drops(100, 10, 3, 5), accept(7, "", "9"), turnin(7, "", "1,2"), accept(8, "4", "")].join(",")),
			session("p3", true, &[windows(100, 20, 8, 5), accept(7, "", "1,2"), r#"{"e":"drop","object":3000,"items":[{"item":2770,"count":2}]}"#.into()].join(",")),
			session("p4", false, &[r#"{"e":"vendor","npc":945,"items":[{"item":2131,"price":54,"stack":1,"qty":-1}]}"#.to_string(), accept(10, "6", "")].join(",")),
			session("p1", true, r#"{"e":"vendor","npc":945,"items":[{"item":2130,"price":54,"stack":1,"qty":-1}]}"#),
		];
		let snap = snapshot(&Recordings { list, min_voters: 3 });
		let s = |v: &V| stringify(v, None);
		// Three players with ten kills/windows each: 20%, 30%, 40%.
		assert_eq!(s(&snap.get("drops").get("100").get("items").get("5")), r#"{"voters":3,"chance":30,"trusted":true}"#);
		assert_eq!(s(&snap.get("drops").get("100").get("windows")), "25");
		// One player with three kills: the row, no chance.
		assert_eq!(s(&snap.get("drops").get("101").get("items").get("7")), r#"{"voters":1,"chance":null,"trusted":false}"#);
		assert!(snap.get("drops").get("200").is_undef(), "skinning is no drop");
		assert_eq!(s(&snap.get("objects").get("3000").get("items")), r#"{"2770":{"voters":1,"chance":null,"trusted":false}}"#);
		// A player who does not count is left out.
		assert_eq!(s(&snap.get("vendors")), r#"{"945":{"2130":{"voters":1,"trusted":false}}}"#);
		assert!(snap.get("rewards").get("10").is_undef());
		assert_eq!(s(&snap.get("rewards").get("7")), r#"{"items":[],"choices":[1,2],"voters":3,"trusted":true}"#);
		assert_eq!(s(&snap.get("rewards").get("8")), r#"{"items":[3],"choices":[],"voters":1,"trusted":false}"#, "a tie keeps the first recorded list");
		assert_eq!(s(&snap.get("rewards").get("9")), r#"{"items":[5],"choices":[],"voters":1,"trusted":false}"#);
		assert_eq!(s(&snap.get("meta")), r#"{"sessions":5,"counted":4,"voters":3,"excluded":0,"verdicts":null,"minVoters":3,"minWindows":10,"through":null}"#);
	}

	#[test]
	fn the_snapshot_and_the_data_build_give_the_same_drop_chances_and_quest_rewards_for_the_same_sessions() {
		let accept = |q: i64, items: &str, choices: &str| format!(r#"{{"e":"accept","q":{q},"items":[{items}],"choices":[{choices}]}}"#);
		let turnin = |q: i64, items: &str, choices: &str| format!(r#"{{"e":"turnin","q":{q},"items":[{items}],"choices":[{choices}]}}"#);
		let obj_drops = |obj: i64, n: usize, with: usize, item: i64| {
			(0..n)
				.map(|i| if i < with { format!(r#"{{"e":"drop","object":{obj},"items":[{{"item":{item},"count":1}}]}}"#) } else { format!(r#"{{"e":"drop","object":{obj},"items":[]}}"#) })
				.collect::<Vec<_>>()
				.join(",")
		};
		let list = vec![
			session(
				"aaaaaaaaaaaaaaaa",
				true,
				&[
					// 20 kills (plus one denied kill that does not count), 2 drops -> 10%.
					kills_and_drops(1501, 20, 2, 2933),
					r#"{"e":"kill","npc":1501,"cls":"normal","denied":true}"#.into(),
					// 10 kills of 1502 with no drops -> 0% share.
					kills_and_drops(1502, 10, 0, 2933),
					obj_drops(3000, 10, 1, 2770),
					// Quest 7: turn-in (weight 2) beats accept (weight 1), and a later accept does not overwrite it.
					accept(7, "", "99"),
					turnin(7, "10", "1,2"),
					accept(7, "", "88"),
					// Quest 8: two unvouched lists tie; first recorded wins (untrusted).
					accept(8, "3", "30"),
					// Quest 9: two unvouched players vs one vouched player; vouched wins (trusted).
					accept(9, "5", ""),
				]
				.join(","),
			),
			session(
				"bbbbbbbbbbbbbbbb",
				true,
				&[
					// 20 kills, 5 drops -> 25%.
					kills_and_drops(1501, 20, 5, 2933),
					kills_and_drops(1502, 10, 2, 2933),
					obj_drops(3000, 10, 3, 2770),
					// A schema-2 turn-in without frame items/choices/rewardMoney keeps the accept's rewards.
					accept(7, "10", "1,2"),
					r#"{"e":"turnin","q":7,"xpReward":450,"money":100}"#.into(),
					accept(8, "4", "40"),
					accept(9, "5", ""),
				]
				.join(","),
			),
			session(
				"cccccccccccccccc",
				true,
				&[
					// 400 kills, 400 drops -> 100% outlier; median of [10%, 25%, 100%] is 25%.
					kills_and_drops(1501, 400, 400, 2933),
					kills_and_drops(1502, 10, 4, 2933),
					obj_drops(3000, 20, 10, 2770),
					turnin(7, "10", "1,2"),
				]
				.join(","),
			),
			session("sent-alice", true, &accept(9, "6", "60")),
		];
		let recs = Recordings { list, min_voters: 3 };
		let snap = snapshot(&recs);

		let obj = |j: &str| match parse_json(j).unwrap() {
			V::Obj(o) => o,
			_ => unreachable!(),
		};
		let quests = obj(r#"{
			"7":{"id":7,"title":"Q7","level":5,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[],"rewards":{"items":[1],"choices":[],"money":null},"source":["pfquest"]},
			"8":{"id":8,"title":"Q8","level":5,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[],"source":["pfquest"]},
			"9":{"id":9,"title":"Q9","level":5,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[],"rewards":{"items":[1],"choices":[],"money":null},"source":["pfquest"]}
		}"#);
		let npcs = obj(r#"{"1501":{"id":1501,"name":"A","spawns":{}},"1502":{"id":1502,"name":"B","spawns":{}}}"#);
		let objects = obj(r#"{"3000":{"id":3000,"name":"Chest","spawns":{}}}"#);
		let items = obj(r#"{
			"2933":{"id":2933,"name":"Seal","drops":{"npc":{"1501":1,"1502":1},"object":{}},"vendors":[]},
			"2589":{"id":2589,"name":"Linen","drops":{"npc":{"1501":1,"1502":1},"object":{}},"vendors":[]},
			"2770":{"id":2770,"name":"Copper","drops":{"npc":{},"object":{"3000":1}},"vendors":[]}
		}"#);
		let (zones, factions, instances) = (obj("{}"), obj("{}"), obj("{}"));
		let db = Db { quests: &quests, npcs: &npcs, objects: &objects, items: &items, zones: &zones, factions: &factions, instances: &instances };
		apply_recordings(&db, &recs.list, &V::obj(), recs.min_voters, DEFAULTS, &|_| false, false);

		let s = |v: &V| stringify(v, None);
		for (npc, expected) in [("1501", 25.0), ("1502", 20.0)] {
			let data_chance = items.get("2933").get("drops").get("npc").get(npc).as_num();
			let codex_chance = snap.get("drops").get(npc).get("items").get("2933").get("chance").as_num();
			assert_eq!(data_chance, Some(expected), "npc {npc}");
			assert_eq!(codex_chance, data_chance, "npc {npc}");
		}
		let data_obj = items.get("2770").get("drops").get("object").get("3000").as_num();
		let codex_obj = snap.get("objects").get("3000").get("items").get("2770").get("chance").as_num();
		assert_eq!(data_obj, Some(30.0));
		assert_eq!(codex_obj, data_obj);

		for (q, expected_items, expected_choices, expected_trusted) in [("7", "[10]", "[1,2]", true), ("8", "[3]", "[30]", false), ("9", "[6]", "[60]", true)] {
			let dr = quests.get(q).get("rewards");
			let cr = snap.get("rewards").get(q);
			assert_eq!(s(&dr.get("items")), expected_items, "quest {q} items");
			assert_eq!(s(&dr.get("choices")), expected_choices, "quest {q} choices");
			assert_eq!(s(&cr.get("items")), s(&dr.get("items")), "quest {q} items match");
			assert_eq!(s(&cr.get("choices")), s(&dr.get("choices")), "quest {q} choices match");
			assert_eq!(cr.get("trusted").truthy(), expected_trusted, "quest {q} trusted");
			let tag = if expected_trusted { "recorder:rewards" } else { "recorder-gap:rewards" };
			assert!(quests.get(q).get("source").items().iter().any(|x| x.as_str() == Some(tag)), "quest {q} source tag {tag}");
		}
	}

	// The archive as `forge data codex --recordings` reads it: IngestAudit's verdicts set a suspect contributor
	// aside and make two contributors one person, so four players' merchant windows are two people's, too few to
	// change the Codex.
	#[test]
	fn the_export_leaves_out_the_contributors_the_verdicts_set_aside_and_counts_one_vote_per_person() {
		let tmp = std::env::temp_dir().join(format!("forge-codex-recorded-export-{}", std::process::id()));
		let dir = tmp.join("archive");
		let _ = std::fs::remove_dir_all(&tmp);
		std::fs::create_dir_all(&dir).unwrap();
		// Everyone is established at once (the thresholds at 0), so only the verdicts decide.
		std::fs::write(dir.join("config.json"), r#"{"minContributorDays":0,"minContributorChunks":0,"minContributorUploadDays":0,"minContributorPos":0,"minContributorKills":0}"#).unwrap();
		let window = r#"{"e":"vendor","npc":945,"items":[{"item":2130,"price":54,"stack":1,"qty":-1}]}"#;
		for (file, who) in [("1.json", "aaaa"), ("2.json", "bbbb"), ("3.json", "cccc"), ("4.json", "dddd")] {
			let head = r#""received":1794000000,"contributorSince":1794000000,"contributorChunks":1,"uploadDays":1"#;
			std::fs::write(dir.join(file), format!(r#"{{"schema":2,"contributor":"{who}",{head},"events":[{window}]}}"#)).unwrap();
		}
		let verdicts = tmp.join("verdict.json");
		std::fs::write(
			&verdicts,
			r#"{"generated":"2026-11-11-2300","contributors":{"aaaa":{"status":"ok","person":"p1"},"bbbb":{"status":"watch","person":"p1"},"cccc":{"status":"suspect","person":"p2"},"dddd":{"status":"ok","person":"p3"}},"rerolled":{}}"#,
		)
		.unwrap();
		let snap = |v: Option<&Path>| parse_json(&export(&dir, v).unwrap().0).unwrap();
		let s = |v: &V| stringify(v, None);
		assert_eq!(s(&snap(None).get("vendors")), r#"{"945":{"2130":{"voters":4,"trusted":true}}}"#, "without the verdicts: four players");
		let with = snap(Some(&verdicts));
		assert_eq!(s(&with.get("vendors")), r#"{"945":{"2130":{"voters":2,"trusted":false}}}"#);
		assert_eq!(s(&with.get("meta")), r#"{"sessions":4,"counted":3,"voters":2,"excluded":1,"verdicts":"2026-11-11-2300","minVoters":3,"minWindows":10,"through":1794000000}"#);
		std::fs::remove_dir_all(&tmp).unwrap();
	}
}
