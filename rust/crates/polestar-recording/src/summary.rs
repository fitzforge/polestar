//! What a set of chunks holds, in numbers (the Polestar Client's "what was sent" view and the server's
//! per-contributor totals). Labels for people are the UI's job.

use std::collections::{BTreeMap, BTreeSet};

use serde::{Deserialize, Serialize};

use crate::record::{Chunk, Kind, Record};

#[derive(Clone, Debug, Default, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Summary {
	pub chunks: u64,
	pub records: u64,
	/// Records by kind (wire names).
	pub by_kind: BTreeMap<String, u64>,
	pub skipped_unknown: u64,
	pub quests_accepted: u64,
	pub quests_turned_in: u64,
	/// Distinct quests seen in any quest record.
	pub quests: u64,
	pub kills: u64,
	pub loot_windows: u64,
	/// Distinct creatures killed or seen.
	pub unique_creatures: u64,
	/// Distinct vendors, trainers and flight masters whose windows were opened.
	pub vendors: u64,
	pub trainers: u64,
	pub flightmasters: u64,
	pub deaths: u64,
	/// Yards walked, ridden or swum (from `pos` records on maps with known bounds; flights,
	/// boats and jumps faster than 40 yd/s are left out).
	pub distance_yards: f64,
	/// First and last record (epoch seconds).
	pub first: Option<f64>,
	pub last: Option<f64>,
	/// Seconds covered by the chunks (sum per character of last - first record of each chunk).
	pub seconds: f64,
	pub characters: Vec<CharacterSummary>,
}

/// A character, by its random id: never a name.
#[derive(Clone, Debug, Default, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CharacterSummary {
	pub char_id: String,
	pub race: String,
	pub class: String,
	pub faction: String,
	/// Lowest and highest level seen.
	pub level_min: Option<u32>,
	pub level_max: Option<u32>,
	pub chunks: u64,
}

/// Map bounds in yards: (width, height).
fn map_size(fields: &str) -> Option<(u32, f64, f64)> {
	let f: Vec<&str> = fields.split('\t').collect();
	if f.len() < 8 {
		return None;
	}
	let n = |i: usize| f[i].parse::<f64>().ok();
	let (top, left, bottom, right) = (n(4)?, n(5)?, n(6)?, n(7)?);
	let (w, h) = ((right - left).abs(), (bottom - top).abs());
	(w > 0.0 && h > 0.0).then_some((f[0].parse().ok()?, w, h))
}

const MAX_SPEED: f64 = 40.0;

pub fn summarize(chunks: &[Chunk]) -> Summary {
	summarize_with_maps(chunks, &BTreeMap::new())
}

/// [`summarize`] with the SavedVariables `maps` table for distances (`map` records in the
/// chunks count too).
pub fn summarize_with_maps(chunks: &[Chunk], maps: &BTreeMap<u32, String>) -> Summary {
	let mut s = Summary::default();
	let mut sizes: BTreeMap<u32, (f64, f64)> = BTreeMap::new();
	for v in maps.values() {
		if let Some((id, w, h)) = map_size(v) {
			sizes.insert(id, (w, h));
		}
	}
	for c in chunks {
		for r in c.records.iter().filter(|r| r.kind == Kind::Map) {
			if let Some((id, w, h)) = map_size(&r.fields.join("\t")) {
				sizes.insert(id, (w, h));
			}
		}
	}
	let mut quests = BTreeSet::new();
	let mut creatures = BTreeSet::new();
	let (mut vendors, mut trainers, mut fms) = (BTreeSet::new(), BTreeSet::new(), BTreeSet::new());
	let mut chars: BTreeMap<String, CharacterSummary> = BTreeMap::new();
	let mut order: Vec<&Chunk> = chunks.iter().collect();
	order.sort_by(|a, b| a.char_id.cmp(&b.char_id).then(a.epoch.cmp(&b.epoch)).then(a.seq.cmp(&b.seq)));
	let mut last_pos: Option<(String, u32, f64, f64, f64)> = None;
	for c in order {
		s.chunks += 1;
		s.skipped_unknown += c.skipped_unknown as u64;
		let ch = chars.entry(c.char_id.clone()).or_insert_with(|| CharacterSummary { char_id: c.char_id.clone(), ..Default::default() });
		ch.chunks += 1;
		if let (Some(a), Some(b)) = (c.records.first(), c.records.last()) {
			s.seconds += b.t - a.t;
		}
		for r in &c.records {
			s.records += 1;
			*s.by_kind.entry(r.kind.as_str().to_string()).or_insert(0) += 1;
			s.first = Some(s.first.map_or(r.t, |f| f.min(r.t)));
			s.last = Some(s.last.map_or(r.t, |l| l.max(r.t)));
			if let Some(q) = r.int("q").filter(|_| r.kind != Kind::Kill) {
				quests.insert(q);
			}
			let level = |ch: &mut CharacterSummary, r: &Record| {
				if let Some(l) = r.int("level").and_then(|l| u32::try_from(l).ok()).filter(|l| *l > 0) {
					ch.level_min = Some(ch.level_min.map_or(l, |m| m.min(l)));
					ch.level_max = Some(ch.level_max.map_or(l, |m| m.max(l)));
				}
			};
			match r.kind {
				Kind::Session => {
					for (field, slot) in [("race", &mut ch.race), ("class", &mut ch.class), ("faction", &mut ch.faction)] {
						if !r.get(field).is_empty() {
							*slot = r.get(field).to_string();
						}
					}
					level(ch, r);
				}
				Kind::Level => level(ch, r),
				Kind::Accept => s.quests_accepted += 1,
				Kind::Turnin => s.quests_turned_in += 1,
				Kind::Kill => {
					s.kills += 1;
					creatures.insert(r.get("npcId").to_string());
				}
				Kind::Unit | Kind::Rare => {
					creatures.insert(r.get("npcId").to_string());
				}
				Kind::Loot => s.loot_windows += 1,
				Kind::Death => s.deaths += 1,
				Kind::Vendor => {
					vendors.insert(r.get("npcId").to_string());
				}
				Kind::Trainer => {
					trainers.insert(r.get("npcId").to_string());
				}
				Kind::Flightmaster => {
					fms.insert(r.get("npcId").to_string());
				}
				Kind::Taxi | Kind::Ride => last_pos = None,
				Kind::Pos => {
					let Some(p) = r.pos() else {
						last_pos = None;
						continue;
					};
					let (x, y) = p.percent();
					if let Some((cid, map, lx, ly, lt)) = &last_pos {
						if *cid == c.char_id && *map == p.map {
							if let Some((w, h)) = sizes.get(&p.map) {
								let d = (((x - lx) * w) / 100.0).hypot(((y - ly) * h) / 100.0);
								let dt = r.t - lt;
								if dt > 0.0 && d / dt <= MAX_SPEED {
									s.distance_yards += d;
								}
							}
						}
					}
					last_pos = Some((c.char_id.clone(), p.map, x, y, r.t));
				}
				_ => {}
			}
		}
	}
	s.distance_yards = s.distance_yards.round();
	s.quests = quests.len() as u64;
	s.unique_creatures = creatures.len() as u64;
	s.vendors = vendors.len() as u64;
	s.trainers = trainers.len() as u64;
	s.flightmasters = fms.len() as u64;
	s.characters = chars.into_values().collect();
	s
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::record::decode_chunk;

	#[test]
	fn counts_and_distance() {
		let c = decode_chunk(concat!(
			"chunk\t0\t1\t1700000000\tabcdefghij\n",
			"session\t0\tabcdefghij\tScourge\tWARRIOR\tHorde\t2\t5\tenUS\t62345\t11508\t3\t\t2.0.0\t\t\n",
			"map\t0\t1420\t3\t1415\t0\t1000\t1000\t0\t0\n",
			"pos\t10\t1420\t1000\t1000\t0\t70\n",
			"pos\t50\t1420\t1300\t1400\t0\t70\n",
			"accept\t60\t364\tc\t1568\t\t\t\t5\t\t\t\t\n",
			"kill\t70\t1501\t2\tn\t\t\t\t40\t\t0\t\n",
			"kill\t80\t1501\t2\tn\t\t\t\t40\t\t0\t\n",
			"level\t90\t6\t\t\t\t3600\n",
			"vendor\t95\t3\t\t\t\t\n",
		))
		.unwrap();
		let s = summarize(&[c]);
		assert_eq!((s.records, s.kills, s.quests_accepted, s.unique_creatures, s.vendors, s.quests), (9, 2, 1, 1, 1, 1));
		// 3% and 4% of a 1000 yd map: 50 yd in 4 s.
		assert_eq!(s.distance_yards, 50.0);
		assert_eq!(s.characters[0].class, "WARRIOR");
		assert_eq!((s.characters[0].level_min, s.characters[0].level_max), (Some(5), Some(6)));
		assert_eq!(s.by_kind["kill"], 2);
	}
}
