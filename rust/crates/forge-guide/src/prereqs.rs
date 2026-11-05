//! Port of tools/lib/data/prereqs.js.
//! The prerequisites that actually block a quest, from a quests.json record (breadcrumbs, exclusive
//! quests, the parent and unstartable quests never block), and the quests that close a quest for good.

use crate::js::{is_integer, str_to_num, V};
use crate::obj;
use std::cell::RefCell;

fn ids(v: &V) -> Vec<f64> {
	if !v.is_arr() {
		return Vec::new();
	}
	v.items().iter().map(|x| x.num()).filter(|n| is_integer(*n) && *n > 0.0).collect()
}

fn startable(q: &V) -> bool {
	let s = q.get("start");
	!ids(&s.get("npc")).is_empty() || !ids(&s.get("object")).is_empty() || !ids(&s.get("item")).is_empty()
}

/// `blockingPrereqs(quest, questOf)`: quest = the quests.json record; quest_of(id) -> another record or
/// Null. -> { all: [ids], any: [ids] }.
pub fn blocking_prereqs(quest: &V, quest_of: &dyn Fn(&V) -> V) -> V {
	if !quest.truthy() {
		return obj! { "all" => V::arr(), "any" => V::arr() }.into();
	}
	let id = quest.get("id").num();
	let crumbs = ids(&quest.get("breadcrumbs"));
	let is_crumb = |p: f64| -> bool {
		if crumbs.contains(&p) {
			return true;
		}
		let pq = quest_of(&V::Num(p));
		pq.truthy() && pq.get("breadcrumbFor").num() == id
	};
	let mut never = vec![id];
	never.extend(ids(&quest.get("excl")));
	if quest.get("parent").num() > 0.0 {
		never.push(quest.get("parent").num());
	}
	let blocks = |p: f64| -> bool {
		if never.contains(&p) || is_crumb(p) {
			return false;
		}
		let pq = quest_of(&V::Num(p));
		if !pq.truthy() {
			return true;
		}
		!ids(&pq.get("excl")).contains(&id) && startable(&pq)
	};
	let has_split = quest.get("preAll").is_arr() || quest.get("preAny").is_arr();
	let all: Vec<f64> = if has_split { ids(&quest.get("preAll")).into_iter().filter(|p| blocks(*p)).collect() } else { Vec::new() };
	let any_group = if has_split { ids(&quest.get("preAny")) } else { ids(&quest.get("pre")) };
	let any: Vec<f64> = if any_group.iter().any(|p| is_crumb(*p)) { Vec::new() } else { any_group.into_iter().filter(|p| blocks(*p)).collect() };
	let to_v = |v: Vec<f64>| -> V { v.into_iter().map(V::Num).collect::<Vec<V>>().into() };
	obj! { "all" => to_v(all), "any" => to_v(any) }.into()
}

thread_local! {
	// leadsToIndex (a WeakMap by quests object): the object (kept alive so its address stays unique) and
	// its index breadcrumb id -> [quest ids].
	static LEADS_TO: RefCell<Vec<(V, Vec<(f64, Vec<f64>)>)>> = const { RefCell::new(Vec::new()) };
}

fn leads_to(quests: &V, id: f64) -> Vec<f64> {
	LEADS_TO.with(|cell| {
		let mut cache = cell.borrow_mut();
		if let Some((_, index)) = cache.iter().find(|(q, _)| q.strict_eq(quests)) {
			return index.iter().find(|(c, _)| *c == id).map(|(_, l)| l.clone()).unwrap_or_default();
		}
		let mut index: Vec<(f64, Vec<f64>)> = Vec::new();
		for (tid, t) in quests.entries() {
			let b = if t.truthy() { t.get("breadcrumbs") } else { V::Undef };
			for c in ids(&b) {
				match index.iter_mut().find(|(k, _)| *k == c) {
					Some(e) => e.1.push(str_to_num(&tid)),
					None => index.push((c, vec![str_to_num(&tid)])),
				}
			}
		}
		let out = index.iter().find(|(c, _)| *c == id).map(|(_, l)| l.clone()).unwrap_or_default();
		if quests.is_object() {
			cache.push((quests.clone(), index));
		}
		out
	})
}

/// `closedByOf(id, quests)`: quests = id -> record (quests.json). -> [ids], without the quest itself.
pub fn closed_by_of(id: &V, quests: &V) -> Vec<f64> {
	let id = id.num();
	let quest = quests.get(&crate::js::num_str(id));
	let mut cands = vec![quest.get("breadcrumbFor").num()];
	cands.extend(leads_to(quests, id));
	cands.extend(ids(&quest.get("excl")));
	let mut out: Vec<f64> = Vec::new();
	for c in cands {
		if is_integer(c) && c > 0.0 && c != id && !out.contains(&c) {
			out.push(c);
		}
	}
	out
}
