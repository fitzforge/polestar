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
