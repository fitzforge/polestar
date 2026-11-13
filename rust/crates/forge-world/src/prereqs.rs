//! The prerequisites that actually block a quest (port of tools/lib/data/prereqs.js), shared by
//! the world, the compiler and the judge.
//!
//! Never blocking: a breadcrumb (in the quest's `breadcrumbs`, or whose `breadcrumbFor` is the
//! quest: an any-of group holding one is optional as a whole), the quest itself and any quest
//! exclusive with it (either side's `excl`), the quest's `parent`, and a quest nobody can start.
//! With a split (`preAll` or `preAny` present) `all = preAll.filter(blocks)`, `any = preAny`;
//! else `any = pre`.

use crate::data::Quest;
use std::collections::BTreeMap;

fn ids(v: &[i64]) -> impl Iterator<Item = i64> + '_ {
	v.iter().copied().filter(|&n| n > 0)
}

fn startable(q: &Quest) -> bool {
	ids(&q.start.npc).next().is_some() || ids(&q.start.object).next().is_some() || ids(&q.start.item).next().is_some()
}

/// `{ all, any }`: every id in `all` must be turned in, and one of `any` when non-empty.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Blocking {
	pub all: Vec<i64>,
	pub any: Vec<i64>,
}

/// prereqs.js blockingPrereqs(quest, questOf).
pub fn blocking_prereqs<'q>(quest: &Quest, quest_of: &dyn Fn(i64) -> Option<&'q Quest>) -> Blocking {
	let id = quest.id as i64;
	let is_crumb = |p: i64| -> bool {
		if ids(&quest.breadcrumbs).any(|c| c == p) {
			return true;
		}
		quest_of(p).is_some_and(|pq| pq.breadcrumb_for == Some(id as f64))
	};
	let mut never: Vec<i64> = vec![id];
	never.extend(ids(&quest.excl));
	if let Some(p) = quest.parent.filter(|p| *p > 0.0) {
		never.push(p as i64);
	}
	let blocks = |p: i64| -> bool {
		if never.contains(&p) || is_crumb(p) {
			return false;
		}
		match quest_of(p) {
			None => true,
			Some(pq) => !ids(&pq.excl).any(|e| e == id) && startable(pq),
		}
	};
	let split = quest.pre_all.is_some() || quest.pre_any.is_some();
	let all: Vec<i64> = if split { ids(quest.pre_all.as_deref().unwrap_or(&[])).filter(|&p| blocks(p)).collect() } else { Vec::new() };
	let group: Vec<i64> = if split { ids(quest.pre_any.as_deref().unwrap_or(&[])).collect() } else { ids(&quest.pre).collect() };
	let any = if group.iter().any(|&p| is_crumb(p)) { Vec::new() } else { group.into_iter().filter(|&p| blocks(p)).collect() };
	Blocking { all, any }
}

/// prereqs.js closedByOf: the quests that close `id` for good once taken or done: its
/// `breadcrumbFor`, every quest listing it in `breadcrumbs`, and its `excl`.
pub struct ClosedBy {
	leads_to: BTreeMap<i64, Vec<i64>>,
}

impl ClosedBy {
	pub fn new(quests: &BTreeMap<u32, Quest>) -> ClosedBy {
		let mut leads_to: BTreeMap<i64, Vec<i64>> = BTreeMap::new();
		for (tid, t) in quests {
			for c in ids(&t.breadcrumbs) {
				leads_to.entry(c).or_default().push(*tid as i64);
			}
		}
		ClosedBy { leads_to }
	}

	pub fn of(&self, id: i64, quests: &BTreeMap<u32, Quest>) -> Vec<i64> {
		let q = u32::try_from(id).ok().and_then(|i| quests.get(&i));
		let mut out = Vec::new();
		let bf = q.and_then(|q| q.breadcrumb_for).filter(|b| b.fract() == 0.0).map(|b| b as i64);
		let excl: Vec<i64> = q.map(|q| ids(&q.excl).collect()).unwrap_or_default();
		for c in bf.into_iter().chain(self.leads_to.get(&id).into_iter().flatten().copied()).chain(excl) {
			if c > 0 && c != id && !out.contains(&c) {
				out.push(c);
			}
		}
		out
	}
}

/// The breadcrumbs leading to each quest, by either link: the quest's own `breadcrumbs` and every
/// quest whose `breadcrumbFor` is it. A breadcrumb never blocks its target as a prerequisite, but
/// while it is in the log the game holds the target back until it is handed in (or abandoned):
/// in players' recordings, The Forgotten Pools (870) was offered to 30 people who never had The
/// Barrens Oases (886) and refused to 12 while 886 was in their log; over the data's 55 pure
/// breadcrumbs, 68 such refusals against 1 offer.
#[derive(Clone, Debug, Default)]
pub struct CrumbIndex {
	of: BTreeMap<i64, Vec<i64>>,
}

impl CrumbIndex {
	pub fn new(quests: &BTreeMap<u32, Quest>) -> CrumbIndex {
		let mut of: BTreeMap<i64, Vec<i64>> = BTreeMap::new();
		let mut add = |t: i64, c: i64| {
			if t > 0 && c > 0 && t != c {
				let v = of.entry(t).or_default();
				if !v.contains(&c) {
					v.push(c);
				}
			}
		};
		for (&id, q) in quests {
			for c in ids(&q.breadcrumbs) {
				add(id as i64, c);
			}
			if let Some(t) = q.breadcrumb_for.filter(|t| t.fract() == 0.0 && *t > 0.0) {
				add(t as i64, id as i64);
			}
		}
		for v in of.values_mut() {
			v.sort_unstable();
		}
		CrumbIndex { of }
	}

	/// The breadcrumbs leading to quest `id` (sorted; empty for none).
	pub fn of(&self, id: i64) -> &[i64] {
		self.of.get(&id).map_or(&[], Vec::as_slice)
	}

	/// Every (breadcrumb, target) pair, by target then breadcrumb.
	pub fn pairs(&self) -> Vec<(i64, i64)> {
		self.of.iter().flat_map(|(&t, cs)| cs.iter().map(move |&c| (c, t))).collect()
	}
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::data::Ends;

	fn quest(id: u32, breadcrumbs: &[i64], breadcrumb_for: Option<f64>) -> Quest {
		Quest { id, start: Ends { npc: vec![1], ..Default::default() }, breadcrumbs: breadcrumbs.to_vec(), breadcrumb_for, ..Default::default() }
	}

	// A breadcrumb counts by either link: the target's `breadcrumbs` (1198 for 1200) or the
	// breadcrumb's `breadcrumbFor` (469 for 484, a correction); a quest listing itself is no breadcrumb.
	#[test]
	fn crumb_index_reads_both_links() {
		let quests: BTreeMap<u32, Quest> = [quest(1200, &[1198], None), quest(1198, &[], None), quest(484, &[], None), quest(469, &[], Some(484.0)), quest(8414, &[8414], None), quest(886, &[], Some(870.0)), quest(870, &[886], None)]
			.into_iter()
			.map(|q| (q.id, q))
			.collect();
		let ix = CrumbIndex::new(&quests);
		assert_eq!(ix.of(1200), &[1198]);
		assert_eq!(ix.of(484), &[469]);
		assert_eq!(ix.of(870), &[886], "listed once when both links name it");
		assert!(ix.of(8414).is_empty());
		assert!(ix.of(886).is_empty());
		assert_eq!(ix.pairs(), vec![(469, 484), (886, 870), (1198, 1200)]);
	}
}
