//! One shared route per faction (Fitz's structure; `forge guide publish` takes one tree): from the
//! planner's join (the Barrens, Westfall: `shared.joinStep`) to 60, every start of a faction gets the
//! same shared guides, byte for byte. Per-race differences are `only` lines.
//!
//! - **One shared order.** The canonical start's tail (`shared.canonical`), its lines in its own race
//!   guide moved to the same line of the shared guide (Orc and Troll's own Barrens guide stops at the
//!   Crossroads at 12, RevH1), with every other start's extra events (its own quests, its riding
//!   trainer) after the shared event they follow there, without their travel.
//! - **One writing.** The shared guides are written once, from the canonical start's run on that
//!   order; every start's run takes them. A quest only some starts do in the shared order is theirs:
//!   its lines get `only <their races>`.
//! - **Arrivals are the start's.** The travel steps that open a start's join guide (the boat from
//!   Auberdine, a flight) go to the end of its own last guide; the shared join guide starts at its
//!   first goal.

use crate::guide::{is_goal, next_of, races_of};
use crate::input::{Order, OrderT, Route, SoloFallback};
use crate::jsre::{head_ws, is_step, split_comment, starts_nonspace};
use crate::re;
use rustc_hash::{FxHashMap, FxHashSet};
use std::collections::{BTreeMap, BTreeSet};

/// A start of the faction: its name (`Skyborne-horde`) and route.
pub struct Start<'a> {
	pub name: String,
	pub route: &'a Route,
}

/// The race a start's name stands for (`Skyborne-horde` -> `Skyborne`).
pub fn race_of(start: &str) -> String {
	start.split('-').next().unwrap_or(start).to_string()
}

/// The planner's join step of a route (its shared tail's first event).
pub fn join_step(r: &Route) -> Option<usize> {
	r.shared.as_ref()?.get("joinStep")?.as_u64().map(|v| v as usize)
}

/// The faction's canonical start (`shared.canonical`).
pub fn canonical(r: &Route) -> Option<String> {
	r.shared.as_ref()?.get("canonical")?.as_str().map(str::to_string)
}

type EvKey = (OrderT, Option<u32>, Option<u32>, Option<String>);

fn key(o: &Order) -> EvKey {
	(o.t, o.q, o.task, o.from.clone())
}

fn file_of(from: Option<&str>) -> Option<&str> {
	from.and_then(|f| f.rsplit_once(':')).map(|f| f.0)
}

/// What the faction's shared order reads beyond the routes.
pub struct Facts<'a> {
	/// Whether a route `from` file (`guides/forever/....guide`) is a guide with a `race` header.
	pub race_file: &'a dyn Fn(&str) -> bool,
	/// Whether a start's race may take a quest (the data's race mask).
	pub takes: &'a dyn Fn(u32, &str) -> bool,
	/// Yards between two events' points (infinite when unknown).
	pub yd: &'a dyn Fn(&Order, &Order) -> f64,
}

/// Another start's quest joins the shared order when it needs no detour from it: its events within
/// this many yards of the shared events around them.
pub const EXTRA_NEAR_YD: f64 = 400.0;

/// The faction's shared order.
pub struct SharedOrder {
	pub tail: Vec<Order>,
	/// Per quest in it, the starts that do it there.
	pub by_quest: FxHashMap<u32, BTreeSet<String>>,
	/// Per start, the quests it carries in from its own guides whose shared-route events need a detour
	/// off the shared order: it does not take them (the planner's to put on the shared route).
	pub left_out: FxHashMap<String, FxHashSet<u32>>,
}

/// The faction's shared order. Another start's own events join it after the shared event they follow
/// there, when they are a quest's (not its riding or class training, which v1's own steps for its race
/// and class give) and stand by the shared events around them; the rest is the planner's to put on the
/// one shared route.
pub fn faction_tail(starts: &[Start], facts: &Facts) -> Option<SharedOrder> {
	let mut left_out: FxHashMap<String, FxHashSet<u32>> = FxHashMap::default();
	let race_file = facts.race_file;
	let canon_name = canonical(starts.first()?.route)?;
	let canon = starts.iter().find(|s| s.name == canon_name)?;
	let tail = |s: &Start| -> Option<Vec<Order>> { Some(s.route.order[join_step(s.route)?.min(s.route.order.len())..].to_vec()) };
	// The shared guide's line of an event some start has in its own race guide: the same event of
	// another start, read in a shared guide.
	let mut shared_from: FxHashMap<(OrderT, Option<u32>, Option<u32>), String> = FxHashMap::default();
	let mut tails: Vec<(String, Vec<Order>)> = Vec::new();
	for s in starts {
		let t = tail(s)?;
		for o in &t {
			if let Some(f) = o.from.as_deref().filter(|f| file_of(Some(f)).is_some_and(|f| !race_file(f))) {
				shared_from.entry((o.t, o.q, o.task)).or_insert_with(|| f.to_string());
			}
		}
		tails.push((s.name.clone(), t));
	}
	for (_, t) in tails.iter_mut() {
		for o in t.iter_mut() {
			if file_of(o.from.as_deref()).is_some_and(race_file) {
				// (A quest only the start's own race guide has a line for is written as an added one,
				// in the shared guide, where the shared order takes it: Orc and Troll's Barrens guide
				// ends at the Crossroads. A level or training event has no quest to find its shared line
				// by: it is the route's own top-up or training stop at its own target, never another
				// start's (Orc's grind to 16 is not Silverpine's grind to 19, F1).)
				let to = match o.t {
					OrderT::Level => Some("inserted".to_string()),
					OrderT::Train => Some("train stop".to_string()),
					_ => shared_from.get(&(o.t, o.q, o.task)).cloned().or_else(|| matches!(o.t, OrderT::Accept | OrderT::Turnin | OrderT::Task).then(|| "inserted".to_string())),
				};
				if let Some(f) = to {
					o.from = Some(f);
				}
			}
		}
	}
	let base: Vec<Order> = tails.iter().find(|(n, _)| *n == canon.name)?.1.clone();
	let mut at: FxHashMap<EvKey, usize> = FxHashMap::default();
	for (i, o) in base.iter().enumerate() {
		at.entry(key(o)).or_insert(i);
	}
	// Extras after the shared event they follow (slot i + 1 is after base[i]).
	let mut after: Vec<Vec<Order>> = vec![Vec::new(); base.len() + 1];
	let mut added: FxHashSet<EvKey> = FxHashSet::default();
	let mut by_quest: FxHashMap<u32, BTreeSet<String>> = FxHashMap::default();
	let mut carried_by: FxHashMap<String, FxHashSet<u32>> = FxHashMap::default();
	let near = |slot: usize, o: &Order| [slot.checked_sub(1), Some(slot)].into_iter().flatten().filter_map(|i| base.get(i)).any(|b| (facts.yd)(o, b) <= EXTRA_NEAR_YD);
	// Each start's kept extras with their slots.
	let mut kept_by: Vec<(&[Order], Vec<(usize, &Order)>)> = Vec::new();
	for ((name, t), s) in tails.iter().zip(starts) {
		let j = join_step(s.route).unwrap_or(0).min(s.route.order.len());
		let carried: FxHashSet<u32> = s.route.order[..j].iter().filter(|o| o.t == OrderT::Accept).filter_map(|o| o.q).collect();
		carried_by.insert(name.clone(), carried.clone());
		// The extras, by slot.
		let mut slot = 0;
		let mut extras: Vec<(usize, &Order)> = Vec::new();
		for o in t {
			match at.get(&key(o)) {
				Some(&i) => slot = i + 1,
				None => extras.push((slot, o)),
			}
		}
		// (Near where its chain puts it: the Dwarves' Testing the Wells accept, after the Gold Coast in
		// their route, is near the first Sentinel Hill stop it goes to, c18g; else only the Night Elves'
		// order of it counted.)
		let cand: Vec<(usize, &Order)> = extras.iter().copied().filter(|(_, o)| o.q.is_some()).collect();
		let spots0 = chain_slots(t, &cand, &base, &FxHashMap::default(), &near, facts.yd);
		let mut keep: FxHashMap<u32, bool> = FxHashMap::default();
		for (&(_, o), &(sl, _)) in cand.iter().zip(&spots0) {
			let Some(q) = o.q else { continue };
			let k = keep.entry(q).or_insert(true);
			*k &= matches!(o.t, OrderT::Accept | OrderT::Turnin | OrderT::Task) && near(sl, o);
		}
		let out_q: FxHashSet<u32> = keep.iter().filter(|(q, k)| !**k && carried.contains(q)).map(|(q, _)| *q).collect();
		if !out_q.is_empty() {
			left_out.insert(name.clone(), out_q);
		}
		for o in t {
			if let Some(q) = o.q.filter(|&q| (facts.takes)(q, &race_of(name)) && (at.contains_key(&key(o)) || keep.get(&q) == Some(&true))) {
				by_quest.entry(q).or_default().insert(name.clone());
			}
		}
		let kept: Vec<(usize, &Order)> = extras.into_iter().filter(|(_, o)| o.q.is_some_and(|q| keep.get(&q) == Some(&true))).collect();
		kept_by.push((t.as_slice(), kept));
	}
	// Where starts disagree on an extra's slot, the slot most of them give it (ties: the earlier start,
	// the canonical one first): Testing the Wells' hand-in after Blanchy's oats with the Murloc Gills,
	// as the Dwarves, Gnomes and Skyborne have it, not straight after the vials as the Night Elves do
	// (c18g Westfall). Each start's slots keep its own chain in order first ([`chain_slots`]).
	let mut votes: FxHashMap<EvKey, Vec<(usize, usize)>> = FxHashMap::default();
	for (t, kept) in &kept_by {
		for ((_, o), (sl, _)) in kept.iter().zip(chain_slots(t, kept, &base, &FxHashMap::default(), &near, facts.yd)) {
			let v = votes.entry(key(o)).or_default();
			match v.iter_mut().find(|(s, _)| *s == sl) {
				Some(x) => x.1 += 1,
				None => v.push((sl, 1)),
			}
		}
	}
	// (max_by_key keeps the last of equals: the reversed list's last is the first start's slot.) Only an
	// event several starts have is pinned there; one start's own extra stays free to follow its chain.
	let pinned: FxHashMap<EvKey, usize> =
		votes.into_iter().filter(|(_, v)| v.iter().map(|x| x.1).sum::<usize>() > 1).map(|(k, v)| (k, v.iter().rev().max_by_key(|x| x.1).map_or(0, |x| x.0))).collect();
	// Then every start's chain is kept in order around those slots (the Tauren's Monogrammed Sash before
	// the Cutlass most starts take earlier, c18g Azshara).
	let mut fixed: FxHashMap<EvKey, usize> = FxHashMap::default();
	for (t, kept) in &kept_by {
		let free: Vec<usize> = kept.iter().enumerate().filter(|(_, (_, o))| !fixed.contains_key(&key(o))).map(|(i, _)| i).collect();
		let mut placed = pinned.clone();
		placed.extend(fixed.iter().map(|(k, v)| (k.clone(), *v)));
		let spots = chain_slots(t, kept, &base, &placed, &near, facts.yd);
		for (i, (sl, before)) in spots.into_iter().enumerate() {
			let o = kept[i].1;
			if !free.contains(&i) || !added.insert(key(o)) {
				continue;
			}
			let mut e = o.clone();
			// (Its travel is its start's way there, not everyone's.)
			e.items = None;
			e.extra = true;
			let k = before.iter().filter_map(|b| after[sl].iter().position(|x| key(x) == *b)).min().unwrap_or(after[sl].len());
			after[sl].insert(k, e);
			fixed.insert(key(o), sl);
		}
	}
	// A quest the shared order never accepts is for the starts that carry it in from their own guides
	// (Telf's Call of Fire 1525, taken in Mulgore: Tauren Shamans, not Skyborne ones, S5).
	let accepted_here: FxHashSet<u32> = base.iter().chain(after.iter().flatten()).filter(|o| o.t == OrderT::Accept).filter_map(|o| o.q).collect();
	for (q, who) in by_quest.iter_mut() {
		if accepted_here.contains(q) {
			continue;
		}
		let holders: BTreeSet<String> = who.iter().filter(|n| carried_by.get(*n).is_some_and(|c| c.contains(q))).cloned().collect();
		if !holders.is_empty() {
			*who = holders;
		}
	}
	let mut out = Vec::with_capacity(base.len() + added.len());
	for (i, extra) in after.into_iter().enumerate() {
		out.extend(extra);
		if let Some(o) = base.get(i) {
			out.push(o.clone());
		}
	}
	Some(SharedOrder { tail: out, by_quest, left_out })
}

/// Where a start's kept extras go in the shared order: (slot, the events of its slot it goes before).
/// Each goes after the shared event it follows in the start's route, unless a later event of its
/// chain (the same quest or the same group) stands earlier in the shared order (added there, or by
/// another start): then it goes no later than that one, at the last slot back from there where the
/// player stands beside its place (an accept or hand-in: right after a shared accept or hand-in
/// within [`EXTRA_NEAR_YD`]), never before a shared hand-in the start made before it. Alba's Testing
/// the Wells, taken at Sentinel Hill after the Gold Coast in the Dwarves' route, was written after
/// its own vials and hand-in (R10, c18g Westfall): it goes to the first Sentinel Hill stop, beside
/// Scout Galiaan. Tauren's Monogrammed Sash was written after The Captain's Cutlass that the Trolls'
/// route had added (not-ready, c18g Azshara).
fn chain_slots(
	t: &[Order],
	kept: &[(usize, &Order)],
	base: &[Order],
	placed: &FxHashMap<EvKey, usize>,
	near: &dyn Fn(usize, &Order) -> bool,
	yd: &dyn Fn(&Order, &Order) -> f64,
) -> Vec<(usize, Vec<EvKey>)> {
	let ix: Vec<usize> = kept.iter().map(|(_, o)| t.iter().position(|x| std::ptr::eq(x, *o)).unwrap_or(0)).collect();
	let at_t: FxHashMap<EvKey, usize> = t.iter().enumerate().map(|(i, o)| (key(o), i)).collect();
	let related = |a: usize, b: usize| {
		let (x, y) = (kept[a].1, kept[b].1);
		x.q == y.q || (x.group.is_some() && x.group == y.group)
	};
	let npc = |o: &Order| matches!(o.t, OrderT::Accept | OrderT::Turnin);
	let beside = |s: usize, o: &Order| if npc(o) { s.checked_sub(1).and_then(|i| base.get(i)).is_some_and(|b| npc(b) && yd(o, b) <= EXTRA_NEAR_YD) } else { near(s, o) };
	let n = kept.len();
	let mut out: Vec<(usize, Vec<EvKey>)> = vec![(0, Vec::new()); n];
	for k in (0..n).rev() {
		let o = kept[k].1;
		if let Some(&s) = placed.get(&key(o)) {
			out[k] = (s, vec![key(o)]);
			continue;
		}
		let sl = kept[k].0;
		let cap = ((k + 1)..n).filter(|&m| related(k, m)).map(|m| out[m].0).min().filter(|&c| c < sl);
		let Some(cap) = cap else {
			out[k] = (sl, (k + 1..n).filter(|&m| related(k, m) && out[m].0 == sl).flat_map(|m| out[m].1.clone()).collect());
			continue;
		};
		// No earlier than the earlier events of its chain, nor before a shared hand-in made before it.
		let lb = (0..k).filter(|&j| related(j, k)).map(|j| placed.get(&key(kept[j].1)).copied().unwrap_or(kept[j].0)).max().unwrap_or(0).min(cap);
		let mut s = cap;
		let mut at = None;
		loop {
			if beside(s, o) {
				at = Some(s);
				break;
			}
			if s <= lb || base.get(s - 1).is_some_and(|b| b.t == OrderT::Turnin && at_t.get(&key(b)).is_some_and(|&i| i < ix[k])) {
				break;
			}
			s -= 1;
		}
		let s = at.unwrap_or(cap);
		out[k] = (s, (k + 1..n).filter(|&m| related(k, m) && out[m].0 == s).flat_map(|m| out[m].1.clone()).collect());
	}
	out
}

/// `r` with its tail replaced by the faction's shared order. The start's own way to its join event
/// (its hearth and zeppelin from Brill to the Crossroads) stays its own: the shared event carries the
/// canonical start's way there (Orc's walk from Durotar), U4. It is the way to the shared order's
/// first event, wherever the start's own join event falls in it: the Gnomes' tram to Stormwind and
/// walk to Ozwin at Saldean's Farm (their own first Westfall event, the shared order's sixth) was
/// written at Saldean's after the walk in from Elwynn, and their guide walked from Kharanos to the
/// Jansen Stead, c17.
pub fn with_tail(r: &Route, tail: &[Order]) -> Route {
	let j = join_step(r).unwrap_or(r.order.len()).min(r.order.len());
	let mut order = r.order[..j].to_vec();
	let at = order.len();
	order.extend(tail.iter().cloned());
	if let Some(own) = r.order.get(j) {
		let k = order[at..].iter().position(|o| key(o) == key(own)).unwrap_or(0);
		let first_pt = order.get(at).and_then(|o| o.pt);
		if let Some(first) = order.get_mut(at) {
			first.items = own.items.clone();
			// (The way's end: the first event's place, not the own event's further on.)
			if let (true, Some(p), Some(its)) = (k > 0, first_pt, first.items.as_mut()) {
				for x in its.iter_mut().filter(|x| x.t == crate::input::ItemT::Network && x.to == own.pt) {
					x.to = Some(p);
					if let Some(l) = x.legs.as_mut().and_then(|ls| ls.last_mut()).filter(|l| !matches!(l.k.as_deref(), Some("fly") | Some("ride")) && l.node.is_none()) {
						l.to = Some(p);
					}
				}
			}
		}
	}
	for (i, o) in order.iter_mut().enumerate() {
		o.ix = Some(i);
	}
	// (A solo fallback after an event of the tail: after that event in the shared order.)
	let solo_fallback = r
		.solo_fallback
		.iter()
		.filter_map(|f| {
			let a = f.after?;
			if a < j {
				return Some(f.clone());
			}
			let own = key(r.order.get(a)?);
			let k = order[at..].iter().position(|o| key(o) == own)?;
			Some(SoloFallback { after: Some(at + k), ..f.clone() })
		})
		.collect();
	Route { order, solo_fallback, ..r.clone() }
}

/// Ways for a work the shared guide gives some races only carry their `only` (Rev14 item 4): a step
/// whose goals are travel (goto, fly, hearth) with no audience of its own, followed by steps whose work
/// is all some races' (each goal `only` races, or its step), takes the union of those races; so does a
/// step's waypoint `goto` beside work all theirs. The Night Elves' Darkshore no longer sends them to
/// Stormwind's dock or the bears for the other starts' quests. `races`: the faction's starts' races.
pub fn gate_ways(text: &str, races: &[String]) -> String {
	let only_re = regex::Regex::new(r"\sonly\s+([!A-Za-z,]+)\s*$").unwrap();
	let step_only_re = regex::Regex::new(r"^\s+only\s+([!A-Za-z,]+)\s*$").unwrap();
	let race_list = |list: &str| -> Option<BTreeSet<String>> {
		let rs: BTreeSet<String> = list.split(',').map(str::trim).filter(|x| races.iter().any(|r| r == x)).map(str::to_string).collect();
		(!rs.is_empty()).then_some(rs)
	};
	let lines: Vec<String> = text.split('\n').map(str::to_string).collect();
	// Steps: (start, step-level races, has when, goal lines).
	struct S {
		s: usize,
		races: Option<BTreeSet<String>>,
		gated: bool,
		goals: Vec<usize>,
	}
	let mut steps: Vec<S> = Vec::new();
	let mut i = 0;
	while i < lines.len() {
		if !is_step(&lines[i]) {
			i += 1;
			continue;
		}
		let mut e = i + 1;
		while e < lines.len() && !is_step(&lines[e]) && !starts_nonspace(&lines[e]) {
			e += 1;
		}
		let mut races_s = None;
		let mut gated = false;
		let mut goals = Vec::new();
		for k in i + 1..e {
			let code = split_comment(&lines[k]).0;
			if let Some(m) = step_only_re.captures(code) {
				gated = true;
				races_s = race_list(&m[1]);
			} else if matches!(head_ws(code), Some("when")) {
				gated = true;
			} else if is_goal(code) {
				goals.push(k);
			}
		}
		steps.push(S { s: i, races: races_s, gated, goals });
		i = e;
	}
	let travel = |k: usize| matches!(head_ws(split_comment(&lines[k]).0), Some("goto" | "fly" | "hearth"));
	let line_races = |k: usize| only_re.captures(split_comment(&lines[k]).0).and_then(|m| race_list(&m[1]));
	// A step's work audience: the union of its non-travel goals' races, None if any is everyone's.
	let work_races = |st: &S| -> Option<Option<BTreeSet<String>>> {
		let work: Vec<usize> = st.goals.iter().copied().filter(|&k| !travel(k)).collect();
		if work.is_empty() {
			return None;
		}
		let mut u = BTreeSet::new();
		for k in work {
			match line_races(k).or_else(|| st.races.clone()) {
				Some(r) => u.extend(r),
				None => return Some(None),
			}
		}
		Some(Some(u))
	};
	let all: BTreeSet<String> = races.iter().cloned().collect();
	let mut add_step_only: Vec<(usize, BTreeSet<String>)> = Vec::new();
	let mut add_line_only: Vec<(usize, BTreeSet<String>)> = Vec::new();
	for (n, st) in steps.iter().enumerate() {
		if st.gated || st.goals.is_empty() {
			continue;
		}
		let ways: Vec<usize> = st.goals.iter().copied().filter(|&k| travel(k) && line_races(k).is_none() && only_re.captures(split_comment(&lines[k]).0).is_none()).collect();
		if ways.is_empty() {
			continue;
		}
		match work_races(st) {
			// (A waypoint beside work all some races'.)
			Some(Some(u)) if u != all => add_line_only.extend(ways.into_iter().map(|k| (k, u.clone()))),
			Some(_) => {}
			// (A way step: the work it leads to, up to the next step with work.)
			None => {
				let Some(next) = steps[n + 1..].iter().find(|t| work_races(t).is_some()) else { continue };
				if let Some(Some(u)) = work_races(next) {
					if u != all {
						add_step_only.push((st.s, u));
					}
				}
			}
		}
	}
	if add_step_only.is_empty() && add_line_only.is_empty() {
		return text.to_string();
	}
	let mut out = lines.clone();
	for (k, u) in &add_line_only {
		let (code, rest) = split_comment(&lines[*k]);
		out[*k] = format!("{} only {}{rest}", code.trim_end(), u.iter().cloned().collect::<Vec<_>>().join(","));
	}
	for (s, u) in add_step_only.iter().rev() {
		out.insert(s + 1, format!("  only {}", u.iter().cloned().collect::<Vec<_>>().join(",")));
	}
	out.join("\n")
}

/// A shared guide's lines of quests only some starts do in the shared order get `only <their races>`
/// (with a line's own classes: `only Undead,Warlock`); so do the lines of a quest the data's race mask
/// closes to some races of the faction (`races_for`: the races it opens to, None: all), the Paladins'
/// Tome of Divinity for Humans. One audience per quest: a line with a race list of its own takes its
/// quest's accept's (Testing the Wells' goals, `only Dwarf,Gnome,Skyborne` in v1, are the Night Elves'
/// too, as its accept is; the Druids' Principal Source hand-in stays theirs, its accept in a Night Elf
/// Druid step). A quest accepted in another guide keeps its lines' own lists.
pub fn tag_audiences(text: &str, by_quest: &FxHashMap<u32, BTreeSet<String>>, all_starts: usize, races_for: &dyn Fn(u32) -> Option<Vec<String>>) -> String {
	let races_all = ["Orc", "Troll", "Tauren", "Undead", "Skyborne", "Human", "Dwarf", "Gnome", "NightElf"];
	let quest_re = regex::Regex::new(r"^\s+(?:accept|turnin|complete)\s+(\d+)\b|\bquest\s+(\d+)\b").unwrap();
	let accept_re = regex::Regex::new(r"^\s+accept\s+(\d+)\b").unwrap();
	let only_re = regex::Regex::new(r"\sonly\s+([A-Za-z,]+)").unwrap();
	let step_only_re = regex::Regex::new(r"^\s+only\s+([A-Za-z,]+)\s*$").unwrap();
	let races_in = |list: &str| -> Vec<String> { list.split(',').map(str::trim).filter(|x| races_all.contains(x)).map(str::to_string).collect() };
	let lines: Vec<&str> = text.split('\n').collect();
	// Who a line is for, by the shared order and the data.
	let who_of = |q: u32| -> Option<Vec<String>> {
		let starts = by_quest.get(&q).filter(|s| s.len() < all_starts).map(|s| s.iter().map(|s| race_of(s)).collect::<BTreeSet<String>>());
		let mask = races_for(q).map(|v| v.into_iter().collect::<BTreeSet<String>>());
		let who = match (starts, mask) {
			(Some(a), Some(b)) => Some(a.intersection(&b).cloned().collect()),
			(a, b) => a.or(b),
		};
		who.filter(|r: &BTreeSet<String>| !r.is_empty()).map(|r| r.into_iter().collect())
	};
	// Each accept's audience: its own race list, else its step's, else who it is for.
	let mut accept_races: FxHashMap<u32, Vec<String>> = FxHashMap::default();
	let mut step_races: Option<Vec<String>> = None;
	for l in &lines {
		if is_step(l) {
			step_races = None;
			continue;
		}
		let code = split_comment(l).0;
		if let Some(m) = step_only_re.captures(code) {
			step_races = Some(races_in(&m[1])).filter(|r| !r.is_empty());
			continue;
		}
		let Some(q) = accept_re.captures(code).and_then(|m| m[1].parse::<u32>().ok()) else { continue };
		let own = only_re.captures(code).map(|m| races_in(&m[1])).filter(|r| !r.is_empty());
		if let Some(r) = own.or_else(|| step_races.clone()).or_else(|| who_of(q)) {
			accept_races.entry(q).or_insert(r);
		}
	}
	let mut out: Vec<String> = Vec::new();
	for l in &lines {
		let (code, comment) = split_comment(l);
		let q = quest_re.captures(code).filter(|_| is_goal(code)).and_then(|m| m.get(1).or(m.get(2))).and_then(|m| m.as_str().parse::<u32>().ok());
		let Some(q) = q else {
			out.push(l.to_string());
			continue;
		};
		let new = match only_re.captures(code) {
			Some(m) if !races_in(&m[1]).is_empty() => match accept_races.get(&q) {
				Some(list) => {
					let r = m.get(1).unwrap();
					let classes: Vec<&str> = r.as_str().split(',').map(str::trim).filter(|x| !races_all.contains(x)).collect();
					let all: Vec<String> = list.iter().cloned().chain(classes.iter().map(|c| c.to_string())).collect();
					format!("{}{}{}{}", &code[..r.start()], all.join(","), &code[r.end()..], comment)
				}
				None => l.to_string(),
			},
			own => {
				let Some(list) = accept_races.get(&q).cloned().or_else(|| who_of(q)) else {
					out.push(l.to_string());
					continue;
				};
				match own {
					Some(m) => {
						let r = m.get(1).unwrap();
						format!("{}{},{}{}{}", &code[..r.start()], list.join(","), r.as_str(), &code[r.end()..], comment)
					}
					None => format!("{} only {}{comment}", code.trim_end(), list.join(",")),
				}
			}
		};
		out.push(new);
	}
	out.join("\n")
}

/// The steps that open a guide with travel only (goal lines `goto`, `fly`, `hearth`), and the rest.
/// -> (the guide less those steps, the steps' lines).
pub fn split_arrival(text: &str) -> (String, Vec<String>) {
	let lines: Vec<&str> = text.split('\n').collect();
	let Some(first) = lines.iter().position(|l| is_step(l)) else { return (text.to_string(), Vec::new()) };
	let mut i = first;
	let mut cut = first;
	while i < lines.len() && is_step(lines[i]) {
		let mut j = i + 1;
		while j < lines.len() && !is_step(lines[j]) && !starts_nonspace(lines[j]) {
			j += 1;
		}
		let goals: Vec<&str> = lines[i + 1..j].iter().copied().filter(|l| is_goal(split_comment(l).0)).collect();
		// (A step only some characters play, before everyone's way in, is the start's too: the
		// Warriors' Defensive Stance in Stormwind before the boat's arrival lines, N6. Only up to the
		// last travel step: some characters' steps after it stay in the guide.)
		let for_some = lines[i + 1..j].iter().any(|l| head_ws(l) == Some("only"));
		let travel = !goals.is_empty() && goals.iter().all(|l| matches!(head_ws(l), Some("goto" | "fly" | "hearth")));
		if goals.is_empty() || !(for_some || travel) {
			break;
		}
		if travel {
			cut = j;
		}
		// (Comments and blank lines before the next step.)
		i = j;
		while i < lines.len() && !is_step(lines[i]) {
			i += 1;
		}
		if i < lines.len() && is_step(lines[i]) {
			continue;
		}
		break;
	}
	if cut == first {
		return (text.to_string(), Vec::new());
	}
	let moved: Vec<String> = lines[first..cut].iter().map(|s| s.to_string()).collect();
	let mut rest: Vec<&str> = lines[..first].to_vec();
	// (Blank lines between the moved steps and the first kept one go.)
	let mut k = cut;
	while k < lines.len() && lines[k].trim().is_empty() {
		k += 1;
	}
	rest.extend_from_slice(&lines[k..]);
	(rest.join("\n"), moved)
}

/// Whether a guide file's text is shared (no `race` header).
pub fn is_shared(text: &str) -> bool {
	let header: Vec<String> = text.split('\n').take_while(|l| !is_step(l)).map(str::to_string).collect();
	races_of(&header).is_empty()
}

/// A start's written tree with the faction's shared guides: `own` the start's run, `canon` the
/// canonical start's, `v1` the guides read. `join` is the shared join guide's id
/// (`forever/horde/02-the-barrens`). `finish` runs on the shared guides last (every race's and class's
/// own ways: [`audience_travel`]); it must not depend on the start.
#[allow(clippy::too_many_arguments)]
pub fn adopt(
	own: &mut BTreeMap<String, String>,
	canon: &BTreeMap<String, String>,
	v1: &BTreeMap<String, String>,
	by_quest: &FxHashMap<u32, BTreeSet<String>>,
	all_starts: usize,
	join: &str,
	races_for: &dyn Fn(u32) -> Option<Vec<String>>,
	route_files: &FxHashSet<String>,
	own_shared: &[String],
	finish: &mut dyn FnMut(&mut BTreeMap<String, String>),
) {
	let mut out: BTreeMap<String, String> = BTreeMap::new();
	let join_rel = format!("{join}.guide");
	// The shared guides the start's own part plays before the join (Night Elves' Darkshore to about
	// 14): its own run's writing of them, kept as the start's own guides.
	let own_copies: Vec<(String, String)> = own_shared.iter().filter(|r| **r != join_rel).filter_map(|r| own.get(r).map(|t| (r.clone(), t.clone()))).collect();
	// The start's own arrival, from its own run's join guide.
	let arrival = own.get(&join_rel).map(|t| split_arrival(t).1).unwrap_or_default();
	let shared: Vec<String> = own.keys().chain(canon.keys()).filter(|r| v1.get(*r).or(canon.get(*r)).is_some_and(|t| is_shared(t))).cloned().collect::<BTreeSet<_>>().into_iter().collect();
	// (The faction's starts' races: every start in the shared order.)
	let faction_races: Vec<String> = by_quest.values().flatten().map(|s| race_of(s)).collect::<BTreeSet<_>>().into_iter().collect();
	let mut texts: BTreeMap<String, String> = BTreeMap::new();
	for rel in &shared {
		let Some(text) = canon.get(rel).or(v1.get(rel)) else { continue };
		// (The race masks are read on the guides written, not on v1's guides the route leaves alone.)
		let none = |_: u32| None;
		let mut t = gate_ways(&tag_audiences(text, by_quest, all_starts, if canon.get(rel) != v1.get(rel) { races_for } else { &none }), &faction_races);
		if *rel == join_rel {
			t = split_arrival(&t).0;
		}
		texts.insert(rel.clone(), t);
	}
	// Quests the shared guides take somewhere; a line of one ahead of its accept on the shared chain
	// (an accept moved later for the start that takes it: Krusk's 1361 for Tauren), or of a quest some
	// starts carry in from their own guides (the Moonkin Stone for Night Elves), is for whoever holds
	// the quest: `when onquest`.
	let accept_re = regex::Regex::new(r"(?m)^\s+accept\s+(\d+)\b").unwrap();
	let line_re = regex::Regex::new(r"^\s+(accept|turnin|complete)\s+(\d+)\b|\bquest\s+(\d+)\b").unwrap();
	let accepted: FxHashSet<u32> = texts.values().flat_map(|t| accept_re.captures_iter(t).filter_map(|m| m[1].parse::<u32>().ok()).collect::<Vec<_>>()).collect();
	let carried: FxHashSet<u32> = by_quest.iter().filter(|(q, s)| s.len() < all_starts && !accepted.contains(q)).map(|(q, _)| *q).collect();
	let mut chain: Vec<String> = Vec::new();
	let mut at = Some(join_rel.clone());
	while let Some(r) = at.take().filter(|r| texts.contains_key(r) && !chain.contains(r)) {
		at = next_of(&texts[&r]).map(|n| format!("{n}.guide"));
		chain.push(r);
	}
	let mut taken: FxHashSet<u32> = FxHashSet::default();
	for rel in shared.iter().filter(|r| !chain.contains(r)) {
		if let Some(t) = texts.get(rel) {
			out.insert(rel.clone(), isolate_carried(t, &carried));
		}
	}
	for rel in &chain {
		let t = &texts[rel];
		let mut early = carried.clone();
		for l in t.split('\n') {
			let Some(m) = line_re.captures(split_comment(l).0).filter(|_| is_goal(split_comment(l).0)) else { continue };
			let q: Option<u32> = m.get(2).or(m.get(3)).and_then(|x| x.as_str().parse().ok());
			let Some(q) = q else { continue };
			if m.get(1).is_some_and(|v| v.as_str() == "accept") {
				taken.insert(q);
			} else if !taken.contains(&q) && accepted.contains(&q) {
				early.insert(q);
			}
		}
		out.insert(rel.clone(), isolate_carried(t, &early));
	}
	finish(&mut out);
	own.extend(out);
	let mut route_files = route_files.clone();
	for (rel, text) in own_copies {
		if let Some(new_rel) = own_guide_of(own, &rel, &text, join, &route_files) {
			// (The class steps the shared guide's later part has for the start too are its: the Night Elf
			// Druids' Darkshore trips once, at the levels the shared tail plays them, Rev14 item 6.)
			let race = races_of(&own[&new_rel].split('\n').take_while(|l| !is_step(l)).map(str::to_string).collect::<Vec<_>>()).into_iter().next();
			if let (Some(race), Some(tail)) = (race, own.get(&rel).cloned()) {
				let t = drop_tail_class_lines(&own[&new_rel], &tail, &race);
				own.insert(new_rel.clone(), t);
			}
			route_files.insert(new_rel);
		}
	}
	// The start's own guides just before the join guide that have no line of the start's route
	// (`route_files`: the guides its order names; Orc and Troll's Barrens guide, whose quests the
	// shared order takes in the shared guides) keep only their class steps (Thun'grim Firegaze, Call
	// of Fire: the shared guides do not have them for those races); with none, the guide goes and the
	// guide before it, one of the route's, hands over to the join guide.
	while let Some(last) = own.iter().find(|(r, t)| !is_shared(t) && next_of(t).as_deref() == Some(join) && !route_files.contains(*r)).map(|(r, _)| r.clone()) {
		let last_id = last.trim_end_matches(".guide").to_string();
		let Some(prev) = own.iter().find(|(r, t)| **r != last && !is_shared(t) && next_of(t).as_deref() == Some(last_id.as_str()) && route_files.contains(*r)).map(|(r, _)| r.clone()) else { break };
		let class_steps = class_steps_only(&own[&last]);
		if let Some(kept) = class_steps {
			// (Played where the guide before it ends: its levels are that level, Troll's class stop at
			// the Crossroads at 12.)
			let end = own[&prev].split('\n').take_while(|l| !is_step(l)).find_map(|l| l.strip_prefix("levels ")).and_then(|l| l.split_once('-')).map(|(_, b)| b.trim().to_string());
			own.insert(last, class_stop_header(&kept, end.as_deref()));
			break;
		}
		own.remove(&last);
		let t = own.get_mut(&prev).unwrap();
		*t = t.split('\n').map(|l| if l.trim_end() == format!("next {last_id}") { format!("next {join}") } else { l.to_string() }).collect::<Vec<_>>().join("\n");
	}
	if arrival.is_empty() {
		return;
	}
	// The start's last own guide: the one whose `next` is the join guide.
	// (The start's own route guides first: the tree also holds other starts' v1 guides leading there.)
	let leads = |r: &String, t: &String| !is_shared(t) && next_of(t).as_deref() == Some(join) && !r.is_empty();
	let last = own.iter().find(|(r, t)| leads(r, t) && route_files.contains(*r)).or_else(|| own.iter().find(|(r, t)| leads(r, t))).map(|(r, _)| r.clone());
	let Some(last) = last else { return };
	let t = own.get_mut(&last).unwrap();
	let trimmed = t.trim_end_matches('\n').to_string();
	*t = format!("{trimmed}\n\n{}\n", arrival.join("\n").trim_end());
}

/// `own` (a start's own copy of a shared guide's early part) less its lines for some races or classes
/// only (`only NightElf,Druid`, on the line or its step) that `tail` (the shared guide, later in the
/// start's chain) has for `race` too: each such quest's lines are the tail's, and a step left with no
/// quest line goes, with the travel-only steps for the same characters just before it.
pub fn drop_tail_class_lines(own: &str, tail: &str, race: &str) -> String {
	use forge_guide::conditions::Audience;
	let only_re = regex::Regex::new(r"\sonly\s+([!A-Za-z,]+)\s*$").unwrap();
	let step_only_re = regex::Regex::new(r"^\s+only\s+([!A-Za-z,]+)\s*$").unwrap();
	let key_re = regex::Regex::new(r"^\s+(accept|turnin|complete)\s+(\d+)\b|\bquest\s+(\d+)\b").unwrap();
	let item_re = regex::Regex::new(r"^\s+(?:collect|use)\s+(\d+)\b").unwrap();
	let key = |code: &str| -> Option<(String, u32)> {
		let Some(m) = key_re.captures(code) else {
			// (A class quest's item line of its own: the Half Pendant's lockbox.)
			return item_re.captures(code).and_then(|m| Some(("item".to_string(), m[1].parse().ok()?)));
		};
		match (m.get(1), m.get(2), m.get(3)) {
			(Some(v), Some(q), _) => Some((v.as_str().to_string(), q.as_str().parse().ok()?)),
			(_, _, Some(q)) => Some(("work".into(), q.as_str().parse().ok()?)),
			_ => None,
		}
	};
	// Steps: (start, end, the step's `only`).
	let steps_of = |lines: &[&str]| -> Vec<(usize, usize, Option<String>)> {
		let mut out = Vec::new();
		let mut i = 0;
		while i < lines.len() {
			if !is_step(lines[i]) {
				i += 1;
				continue;
			}
			let mut e = i + 1;
			while e < lines.len() && !is_step(lines[e]) && !starts_nonspace(lines[e]) {
				e += 1;
			}
			let only = lines[i + 1..e].iter().find_map(|l| step_only_re.captures(split_comment(l).0).map(|m| m[1].to_string()));
			out.push((i, e, only));
			i = e;
		}
		out
	};
	let tl: Vec<&str> = tail.split('\n').collect();
	let mut theirs: FxHashSet<(String, u32)> = FxHashSet::default();
	for (s, e, only) in steps_of(&tl) {
		for l in &tl[s + 1..e] {
			let code = split_comment(l).0;
			if !is_goal(code) {
				continue;
			}
			let aud = only_re.captures(code).map(|m| m[1].to_string()).or_else(|| only.clone());
			if aud.as_deref().is_none_or(|a| Audience::parse(a).race_in(race)) {
				if let Some(k) = key(code) {
					theirs.insert(k);
				}
			}
		}
	}
	let ol: Vec<&str> = own.split('\n').collect();
	let steps = steps_of(&ol);
	let mut drop: FxHashSet<usize> = FxHashSet::default();
	let mut gone_steps: Vec<usize> = Vec::new();
	for (n, (s, e, only)) in steps.iter().enumerate() {
		let mut quest_lines = 0;
		let mut dropped = 0;
		for k in s + 1..*e {
			let code = split_comment(ol[k]).0;
			if !is_goal(code) {
				continue;
			}
			let Some(kq) = key(code) else { continue };
			quest_lines += 1;
			let restricted = only_re.captures(code).is_some() || only.is_some();
			if restricted && theirs.contains(&kq) {
				drop.insert(k);
				dropped += 1;
			}
		}
		// (Every quest line gone from a step for those characters only, or every goal of any step.)
		let goals = (s + 1..*e).filter(|&k| is_goal(split_comment(ol[k]).0)).count();
		if dropped > 0 && ((dropped == quest_lines && only.is_some()) || dropped == goals) {
			gone_steps.push(n);
		}
	}
	let travel_only = |s: usize, e: usize| {
		ol[s + 1..e].iter().all(|l| {
			let code = split_comment(l).0;
			!is_goal(code) || matches!(head_ws(code), Some("goto" | "fly" | "hearth"))
		})
	};
	// (The same characters: the classes of the `only`, the start's race implied: `only Druid` and
	// `only NightElf,Druid` in a Night Elf's own copy.)
	let classes_of = |o: &Option<String>| -> Option<Vec<String>> {
		let cs: Vec<String> = o.as_deref()?.split(',').map(str::trim).filter(|c| forge_guide::conditions::class_file_of(c).is_some()).map(str::to_string).collect();
		(!cs.is_empty()).then_some(cs)
	};
	let mut gone: FxHashSet<usize> = FxHashSet::default();
	for &n in &gone_steps {
		gone.insert(n);
		let cls = classes_of(&steps[n].2);
		let same = |m: usize| cls.is_some() && classes_of(&steps[m].2) == cls && travel_only(steps[m].0, steps[m].1);
		// The travel there before it, and back after it.
		let mut m = n;
		while m > 0 && same(m - 1) {
			m -= 1;
			gone.insert(m);
		}
		let mut m = n + 1;
		while m < steps.len() && (gone_steps.contains(&m) || same(m)) {
			gone.insert(m);
			m += 1;
		}
	}
	// (And a class's travel step left with no work of that class anywhere in the copy: the Druids'
	// "To Darnassus" flight back to Auberdine once their Darnassus trip is the shared tail's.)
	let work_classes: FxHashSet<String> = steps
		.iter()
		.enumerate()
		.filter(|(n, _)| !gone.contains(n))
		.flat_map(|(_, (s, e, only))| {
			let mut cs: Vec<String> = Vec::new();
			for k in s + 1..*e {
				let code = split_comment(ol[k]).0;
				if !is_goal(code) || drop.contains(&k) || matches!(head_ws(code), Some("goto" | "fly" | "hearth")) {
					continue;
				}
				let line_cls = classes_of(&only_re.captures(code).map(|m| m[1].to_string()));
				cs.extend(line_cls.or_else(|| classes_of(only)).unwrap_or_default());
			}
			cs
		})
		.collect();
	// (Or the tail's own step of that name and audience, its work there: the copy kept only its travel,
	// the Druids' "To Darnassus" flight back with its hand-ins the tail's.)
	let tail_steps = steps_of(&tl);
	let tail_has = |title: &str, only: &Option<String>| {
		tail_steps.iter().any(|(ts, te, to)| {
			tl[*ts] == title
				&& to == only
				&& tl[ts + 1..*te].iter().any(|l| {
					let code = split_comment(l).0;
					is_goal(code) && !matches!(head_ws(code), Some("goto" | "fly" | "hearth"))
				})
		})
	};
	for (n, (s, e, only)) in steps.iter().enumerate() {
		if let Some(cls) = classes_of(only) {
			if travel_only(*s, *e) && (!cls.iter().any(|c| work_classes.contains(c)) || tail_has(ol[*s], only)) {
				gone.insert(n);
			}
		}
	}
	if drop.is_empty() && gone.is_empty() {
		return own.to_string();
	}
	let mut out: Vec<&str> = Vec::with_capacity(ol.len());
	let mut i = 0;
	while i < ol.len() {
		if let Some(n) = steps.iter().position(|st| st.0 == i).filter(|n| gone.contains(n)) {
			i = steps[n].1;
			// (The blank line before the next step, once.)
			while out.last().is_some_and(|l| l.trim().is_empty()) && ol.get(i).is_some_and(|l| l.trim().is_empty()) {
				i += 1;
			}
			continue;
		}
		if !drop.contains(&i) {
			out.push(ol[i]);
		}
		i += 1;
	}
	out.join("\n")
}

/// A shared guide `rel` the start's own part plays before the join guide `join`, written by its own
/// run as `text`, made one of the start's own guides: `<the start's folder>/<NN>-<stem>` numbered
/// after the start's guide that leads to it, with that guide's `race` header, chained between it and
/// the join guide (Night Elves: `nightelf/01-teldrassil` -> `nightelf/02-darkshore` -> `02-westfall`).
/// The shared guide stays the faction's. Only the start's own route guides (`route_files`) count: the
/// tree also holds v1's other starts' guides (Dun Morogh in the Night Elf tree), which lead to the join
/// too. -> the new guide's file.
fn own_guide_of(own: &mut BTreeMap<String, String>, rel: &str, text: &str, join: &str, route_files: &FxHashSet<String>) -> Option<String> {
	let id = rel.trim_end_matches(".guide");
	// (The start's guide that leads there: its `next` is the shared guide or the join guide.)
	let prev = own.iter().find(|(r, t)| route_files.contains(*r) && !is_shared(t) && next_of(t).is_some_and(|n| n == id || n == join)).map(|(r, _)| r.clone())?;
	let prev_text = own[&prev].clone();
	let race = prev_text.split('\n').take_while(|l| !is_step(l)).find(|l| l.starts_with("race "))?.to_string();
	let (dir, prev_name) = prev.trim_end_matches(".guide").rsplit_once('/')?;
	let num: u32 = prev_name.split('-').next()?.parse().ok()?;
	let stem = id.rsplit('/').next()?;
	let stem = stem.split_once('-').filter(|(n, _)| n.chars().all(|c| c.is_ascii_digit())).map_or(stem, |(_, s)| s);
	let new_id = format!("{dir}/{:02}-{stem}", num + 1);
	let lines: Vec<&str> = text.split('\n').collect();
	let first = lines.iter().position(|l| is_step(l)).unwrap_or(lines.len());
	let mut head: Vec<String> = Vec::new();
	let mut has_next = false;
	for l in &lines[..first] {
		if l.starts_with("guide ") {
			head.push(format!("guide {new_id}"));
		} else if l.starts_with("race ") {
			continue;
		} else if l.starts_with("next ") {
			head.push(format!("next {join}"));
			has_next = true;
		} else {
			head.push(l.to_string());
		}
		if l.starts_with("title ") {
			head.push(race.clone());
		}
	}
	if !has_next {
		let at = head.iter().position(|l| l.trim().is_empty() || l.starts_with('#')).unwrap_or(head.len());
		head.insert(at, format!("next {join}"));
	}
	head.extend(lines[first..].iter().map(|l| l.to_string()));
	own.insert(format!("{new_id}.guide"), head.join("\n"));
	let t = own.get_mut(&prev).unwrap();
	*t = t.split('\n').map(|l| if l.starts_with("next ") { format!("next {new_id}") } else { l.to_string() }).collect::<Vec<_>>().join("\n");
	Some(format!("{new_id}.guide"))
}

/// A guide less every step that is not some classes' own (`only Warrior`, `only Orc,Troll,Shaman`):
/// None when it has no such step.
fn class_steps_only(text: &str) -> Option<String> {
	let only_re = regex::Regex::new(r"(?:^|\s)only\s+([!A-Za-z,]+)").unwrap();
	let lines: Vec<&str> = text.split('\n').collect();
	let first = lines.iter().position(|l| is_step(l))?;
	let mut out: Vec<&str> = lines[..first].to_vec();
	let mut any = false;
	let mut i = first;
	while i < lines.len() {
		let mut j = i + 1;
		while j < lines.len() && !is_step(lines[j]) {
			j += 1;
		}
		// (The step's own lines; comments after it go with the next step.)
		let mut end = i + 1;
		while end < j && !starts_nonspace(lines[end]) && !lines[end].trim().is_empty() {
			end += 1;
		}
		let class = lines[i + 1..end].iter().any(|l| l.trim_start().starts_with("only") && only_re.captures(l).is_some_and(|m| m[1].split(',').any(|c| crate::apply::CLASSES.contains(&c.trim()))));
		let is_class = |l: &str| only_re.captures(l).is_some_and(|m| m[1].split(',').any(|c| crate::apply::CLASSES.contains(&c.trim())));
		if class {
			out.push("");
			out.extend_from_slice(&lines[i..end]);
			any = true;
		} else if lines[i + 1..end].iter().any(|l| !l.trim_start().starts_with("only") && is_goal(split_comment(l).0) && is_class(split_comment(l).0)) {
			// (A step for everyone with some classes' lines: those lines, in its place, Warriors'
			// Fixed Steel collect at the Sludge Fen.)
			out.push("");
			out.push(lines[i]);
			out.extend(lines[i + 1..end].iter().filter(|l| matches!(head_ws(l), Some("zone")) || (is_goal(split_comment(l).0) && is_class(split_comment(l).0))));
			any = true;
		}
		i = j;
	}
	any.then(|| out.join("\n").trim_end().to_string() + "\n")
}

/// A class stop's header (from [`class_steps_only`]): its keys, `levels <end>-<end>` when the guide
/// before it ends at `end`, and the writer's note instead of the seed's notes.
fn class_stop_header(text: &str, end: Option<&str>) -> String {
	let lines: Vec<&str> = text.split('\n').collect();
	let first = lines.iter().position(|l| is_step(l)).unwrap_or(lines.len());
	let mut out: Vec<String> = lines[..first]
		.iter()
		.filter(|l| !l.trim().is_empty() && !l.starts_with('#'))
		.map(|l| match (l.strip_prefix("levels "), end) {
			(Some(_), Some(e)) => format!("levels {e}-{e}"),
			_ => l.to_string(),
		})
		.collect();
	out.push(String::new());
	out.extend(crate::apply::GENERATED_NOTE.iter().map(|l| l.to_string()));
	out.push(String::new());
	out.extend(lines[first..].iter().map(|l| l.to_string()));
	out.join("\n")
}

/// The lines of a quest some starts carry in from their own guides (accepted there, handed in on the
/// shared route: Darkshore's Moonkin Stone for Night Elves) go to a step of their own after theirs,
/// `when onquest Q`: the step is for whoever holds the quest, whatever guide they took it in.
pub fn isolate_carried(text: &str, carried: &FxHashSet<u32>) -> String {
	if carried.is_empty() {
		return text.to_string();
	}
	let quest_re = regex::Regex::new(r"^\s+(?:turnin|complete)\s+(\d+)\b|\bquest\s+(\d+)\b").unwrap();
	let q_of = |l: &str| {
		let code = split_comment(l).0;
		quest_re.captures(code).filter(|_| is_goal(code)).and_then(|m| m.get(1).or(m.get(2))).and_then(|m| m.as_str().parse::<u32>().ok()).filter(|q| carried.contains(q))
	};
	let lines: Vec<&str> = text.split('\n').collect();
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	let mut i = 0;
	while i < lines.len() {
		if !is_step(lines[i]) {
			out.push(lines[i].to_string());
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(lines[j]) && !starts_nonspace(lines[j]) {
			j += 1;
		}
		let body = &lines[i + 1..j];
		let moved: BTreeMap<u32, Vec<&str>> = body.iter().filter_map(|l| Some((q_of(l)?, *l))).fold(BTreeMap::new(), |mut m, (q, l)| {
			m.entry(q).or_insert_with(Vec::new).push(l);
			m
		});
		if moved.is_empty() {
			out.extend(lines[i..j].iter().map(|l| l.to_string()));
			i = j;
			continue;
		}
		let kept: Vec<&str> = body.iter().copied().filter(|l| q_of(l).is_none()).collect();
		let has_goal = kept.iter().any(|l| is_goal(split_comment(l).0));
		// (The step's `only`, `zone` and `when` lines go with each step made of it: the moved lines were
		// under its conditions, the Skyborne's Hogger collect under `when group 176`, c16. Not a `when
		// onquest`, which each such step writes for its own quest.)
		let heads: Vec<String> = body.iter().filter(|l| matches!(head_ws(l), Some("only" | "zone" | "when")) && !l.trim_start().starts_with("when onquest")).map(|l| l.to_string()).collect();
		// (A quest whose lines come before the step's other goals goes in a step before it: Thrall's
		// 95350 hand-in before his follow-ups' accepts, c14 Skyborne, not after them.)
		let first_goal = body.iter().position(|l| q_of(l).is_none() && is_goal(split_comment(l).0)).unwrap_or(body.len());
		let before: Vec<u32> = moved.keys().copied().filter(|q| body.iter().position(|l| q_of(l) == Some(*q)).is_some_and(|p| p < first_goal)).collect();
		for q in before.iter().filter(|_| has_goal) {
			if !out.last().is_some_and(|l| l.trim().is_empty()) {
				out.push(String::new());
			}
			out.push(lines[i].to_string());
			out.extend(heads.iter().cloned());
			out.push(format!("  when onquest {q}"));
			out.extend(moved[q].iter().map(|l| l.to_string()));
			out.push(String::new());
		}
		let moved: BTreeMap<u32, Vec<&str>> = moved.into_iter().filter(|(q, _)| !has_goal || !before.contains(q)).collect();
		// (The step's closing flight path or bind, after the carried lines in the step: after their
		// `when` step too, in a step of its own; else the arrow leaves for the flight master and comes back
		// to the same NPC: the Skyborne Druids' Moonglade flight path before Sheldras' welcome, c15.)
		let end = kept.iter().rposition(|l| !l.trim().is_empty()).map_or(0, |p| p + 1);
		let service = |l: &str| matches!(head_ws(split_comment(l).0), Some("getfp" | "sethome"));
		let last_moved = body.iter().rposition(|l| q_of(l).is_some_and(|q| moved.contains_key(&q)));
		let mut tail_at = end;
		while tail_at > 0 && (service(kept[tail_at - 1]) || kept[tail_at - 1].trim().is_empty()) {
			tail_at -= 1;
		}
		let tail_after = last_moved.is_some_and(|m| kept[tail_at..end].iter().filter(|l| service(l)).all(|l| body.iter().position(|b| b == l).is_some_and(|p| p > m)));
		let (main_end, tail): (usize, Vec<&str>) = if has_goal && !moved.is_empty() && tail_after && tail_at < end && kept[..tail_at].iter().any(|l| is_goal(split_comment(l).0)) {
			(tail_at, kept[tail_at..end].iter().copied().filter(|l| service(l)).collect())
		} else {
			(end, Vec::new())
		};
		if has_goal {
			out.push(lines[i].to_string());
			out.extend(kept[..main_end].iter().map(|l| l.to_string()));
		}
		for (q, ls) in &moved {
			if has_goal || !out.last().is_some_and(|l| l.trim().is_empty()) {
				out.push(String::new());
			}
			out.push(lines[i].to_string());
			out.extend(heads.iter().cloned());
			out.push(format!("  when onquest {q}"));
			out.extend(ls.iter().map(|l| l.to_string()));
		}
		if !tail.is_empty() {
			out.push(String::new());
			out.push(lines[i].to_string());
			out.extend(heads.iter().cloned());
			out.extend(tail.iter().map(|l| l.to_string()));
		}
		if has_goal || !moved.is_empty() {
			let blank_after = kept.iter().rposition(|l| !l.trim().is_empty()).map_or(0, |p| p + 1);
			out.extend(kept[blank_after..].iter().map(|l| l.to_string()));
		}
		i = j;
	}
	out.join("\n")
}

/// A race's or class's own way on the one shared route: the shared guides played as every race of
/// the faction (from its v1 start guides, through `starts`' first guides), and as each class some
/// shared line is `only`, and each R1 failure on a shared guide gets that player's way, `only` them
/// (travel.rs's repair rounds; a line of the way that is not theirs, `only` the others). The same
/// legs for several races are one step. `shared` maps the shared guides to their texts; `v1` is the
/// guides read.
pub fn audience_travel(
	shared: &mut BTreeMap<String, String>,
	v1: &BTreeMap<String, String>,
	starts: &[(String, String)],
	faction: &str,
	data: &forge_guide::data::Data,
	walks: Option<&dyn crate::engine::WalkYards>,
) -> Vec<String> {
	let mut log = Vec::new();
	let races: Vec<String> = starts.iter().map(|(s, _)| race_of(s)).collect();
	let only_re = regex::Regex::new(r"\sonly\s+([A-Za-z,]+)").unwrap();
	let classes_named: BTreeSet<String> = shared
		.values()
		.flat_map(|t| t.split('\n').filter_map(|l| only_re.captures(l).map(|m| m[1].to_string())).collect::<Vec<_>>())
		.flat_map(|l| l.split(',').map(str::to_string).collect::<Vec<_>>())
		.filter(|x| forge_core::class_by_file(&x.to_uppercase()).is_some())
		.collect();
	// (Twice over the starts when the first pass wrote ways: a start repaired before another's ways
	// changed the shared lines it plays is played again on them: the Dwarves' `fly "Astranaar"` from
	// Maestra's Post, left by their pass before the others gated it to them, c17 30-40/03-ashenvale:81.)
	for pass in 0..2 {
		let mut wrote = false;
		for ((start, first), race) in starts.iter().zip(&races) {
			// The tree played: v1's guides, the shared ones written; the chain from the start's first guide.
			// (A step of a start's own v1 guide whose quest lines the shared guides now have learns no
			// flight path: the shared guides do, for whoever needs it. Orc and Troll's Ratchet step: its
			// getfp left the Trolls' written guide with the step, so the shared Ratchet getfp skipped
			// them, c18g R1 at Ratchet.)
			let have = quest_lines(shared.values().map(String::as_str));
			let mut tree: BTreeMap<String, String> = v1.iter().map(|(k, v)| (k.clone(), if shared.contains_key(k) || is_shared(v) { v.clone() } else { drop_shared_flight_paths(v, &have) })).collect();
			tree.extend(shared.iter().map(|(k, v)| (k.clone(), v.clone())));
			let mut chain: Vec<String> = Vec::new();
			let mut at = Some(first.clone());
			while let Some(f) = at.take().filter(|f| tree.contains_key(f) && !chain.contains(f)) {
				at = next_of(&tree[&f]).map(|n| format!("{n}.guide"));
				chain.push(f);
			}
			let race_file = forge_core::RACES.iter().find(|r| r.key.eq_ignore_ascii_case(race) || r.file.eq_ignore_ascii_case(race)).map_or(race.as_str(), |r| r.file);
			let playable = forge_judge::honest::playable_classes(data, race_file, faction);
			let mut personas: Vec<Option<String>> = vec![None];
			personas.extend(playable.iter().filter(|c| c.as_str() != "WARRIOR" && classes_named.contains(&forge_core::class_label(c))).map(|c| Some(c.clone())));
			let others: Vec<String> = races.iter().filter(|r| *r != race).cloned().collect();
			let shared_files: Vec<String> = shared.keys().cloned().collect();
			for cls in personas {
				let mut rr = vec![race.clone()];
				// (A class's way leaves everyone else's lines as they are: its own way goes before them.)
				let other = match &cls {
					Some(c) => {
						rr.push(forge_core::class_label(c));
						races.clone()
					}
					None => others.clone(),
				};
				let t = crate::travel::Travel { chain: chain.clone(), route_races: rr, other_races: other, shared: shared_files.clone(), faction: Some(faction.to_string()), cls: cls.clone() };
				let rep = crate::travel::repair_rounds(&mut tree, v1, &t, data, walks);
				wrote |= rep.fixed > 0;
				if rep.fixed > 0 || !rep.left.is_empty() {
					log.push(format!("shared route: {start} {}: {} ways written, {} left", cls.as_deref().unwrap_or("all classes"), rep.fixed, rep.left.len()));
					log.extend(rep.log.iter().filter(|l| l.starts_with("  ")).map(|l| format!("shared route:   {start} {l}")));
					log.extend(rep.left.iter().map(|(f, l, why)| format!("shared route:   {start} left {f}:{l} {why}")));
				}
			}
			for (k, v) in shared.iter_mut() {
				if let Some(t) = tree.get(k) {
					*v = t.clone();
				}
			}
		}
		if pass == 0 && !wrote {
			break;
		}
	}
	// (Every character of the faction: each start's race with each class it can play.)
	let combos: Vec<(String, String)> = races
		.iter()
		.flat_map(|race| {
			let file = forge_core::RACES.iter().find(|r| r.key.eq_ignore_ascii_case(race) || r.file.eq_ignore_ascii_case(race)).map_or(race.as_str(), |r| r.file);
			forge_judge::honest::playable_classes(data, file, faction).into_iter().map(move |c| (race.clone(), c))
		})
		.collect();
	for v in shared.values_mut() {
		*v = collapse_audience_steps(&merge_gated_steps(&merge_gated_lines(v), &races), &combos, faction);
	}
	log
}

/// The (verb, quest) of every accept, turnin and complete goal in `texts`.
fn quest_lines<'a>(texts: impl Iterator<Item = &'a str>) -> FxHashSet<(String, u32)> {
	let re = regex::Regex::new(r"^\s+(accept|turnin|complete)\s+(\d+)\b").unwrap();
	texts.flat_map(|t| t.split('\n')).filter_map(|l| re.captures(split_comment(l).0).and_then(|m| Some((m[1].to_string(), m[2].parse().ok()?)))).collect()
}

/// `text` (a start's own guide) less the flight paths (`getfp`) of each step whose quest lines
/// (accept, turnin, complete; at least one) are all in `have`: the shared guides do them, and learn
/// the flight path there. (The step's place stays: where the start's own chain leaves the player.)
fn drop_shared_flight_paths(text: &str, have: &FxHashSet<(String, u32)>) -> String {
	let lines: Vec<&str> = text.split('\n').collect();
	let mut out: Vec<&str> = Vec::with_capacity(lines.len());
	let mut i = 0;
	while i < lines.len() {
		if !is_step(lines[i]) {
			out.push(lines[i]);
			i += 1;
			continue;
		}
		let j = (i + 1..lines.len()).find(|&k| is_step(lines[k]) || starts_nonspace(lines[k])).unwrap_or(lines.len());
		let qs = quest_lines(lines[i + 1..j].iter().copied());
		let theirs = !qs.is_empty() && qs.iter().all(|x| have.contains(x));
		out.extend(lines[i..j].iter().filter(|l| !(theirs && head_ws(split_comment(l).0) == Some("getfp"))));
		i = j;
	}
	out.join("\n")
}

/// Lines side by side the same but for their `only` races, with the same classes, are one line for
/// all their races (each class's way leaves the line `only Orc,!Shaman`, then `only Troll,!Shaman`:
/// `only Orc,Troll,!Shaman`).
pub fn merge_gated_lines(text: &str) -> String {
	use forge_guide::conditions::{same_race, Audience};
	let only_re = regex::Regex::new(r"^(.*?)\sonly\s+([!A-Za-z,]+)\s*$").unwrap();
	// (The line without its list, its audience, its comment.)
	let parts = |l: &str| -> Option<(String, Audience, String)> {
		let (code, rest) = split_comment(l);
		let m = only_re.captures(code)?;
		let a = Audience::parse(&m[2]);
		a.races.is_some().then(|| (m[1].to_string(), a, rest.to_string()))
	};
	let mut out: Vec<String> = Vec::new();
	for l in text.split('\n') {
		if let (Some((code, a, rest)), Some(prev)) = (parts(l), out.last().and_then(|p| parts(p))) {
			let (pcode, mut pa, prest) = prev;
			if code == pcode && rest == prest && a.classes == pa.classes && a.factions == pa.factions && is_goal(split_comment(l).0) {
				let rs = pa.races.get_or_insert_with(Vec::new);
				for r in a.races.unwrap_or_default() {
					if !rs.iter().any(|x| same_race(x, &r)) {
						rs.push(r);
					}
				}
				*out.last_mut().unwrap() = format!("{pcode} only {}{prest}", pa.render().unwrap_or_default());
				continue;
			}
		}
		out.push(l.to_string());
	}
	out.join("\n")
}

/// In a run of travel steps each `only` some races (goals `goto`, `fly`, `hearth`; nothing but
/// comments and blank lines between), a step with the same title and lines and the same classes as an
/// earlier one in the run goes, its races added to that one's (the zeppelin to the Undercity for
/// Undead and Skyborne: one step); a step for every race of the faction is for everyone. Not past a
/// step of its own races between (theirs would come before their way there): then the earlier one
/// goes, its races added to the later one's, when none of its characters has a step between.
pub fn merge_gated_steps(text: &str, all_races: &[String]) -> String {
	let only_re = regex::Regex::new(r"^\s+only\s+([A-Za-z,]+)\s*$").unwrap();
	let is_class = |x: &str| forge_core::class_by_file(&x.to_uppercase()).is_some();
	let lines: Vec<&str> = text.split('\n').collect();
	// The parts: other lines, or a step (its lines).
	enum Part {
		Line(String),
		Step { lines: Vec<String>, gate: Option<(Vec<String>, Vec<String>, Vec<String>)> },
	}
	let mut parts: Vec<Part> = Vec::new();
	let mut i = 0;
	while i < lines.len() {
		if !is_step(lines[i]) {
			parts.push(Part::Line(lines[i].to_string()));
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(lines[j]) && !starts_nonspace(lines[j]) {
			j += 1;
		}
		let step: Vec<String> = lines[i..j].iter().map(|l| l.to_string()).collect();
		let body: Vec<&str> = lines[i + 1..j].iter().copied().filter(|l| !l.trim().is_empty()).collect();
		let onlys: Vec<&str> = body.iter().copied().filter(|l| only_re.is_match(l)).collect();
		let goals: Vec<&str> = body.iter().copied().filter(|l| is_goal(split_comment(l).0)).collect();
		let travel = !goals.is_empty() && goals.iter().all(|l| matches!(head_ws(l), Some("goto" | "fly" | "hearth")));
		let gate = match onlys.as_slice() {
			[o] if travel => {
				let list = &only_re.captures(o).unwrap()[1];
				let (c, r): (Vec<String>, Vec<String>) = list.split(',').map(str::to_string).partition(|x| is_class(x));
				let rest: Vec<String> = std::iter::once(lines[i].to_string()).chain(body.iter().filter(|l| !only_re.is_match(l)).map(|l| l.to_string())).collect();
				(!r.is_empty()).then_some((rest, r, c))
			}
			_ => None,
		};
		parts.push(Part::Step { lines: step, gate });
		i = j;
	}
	// Merge within runs.
	let mut run: Vec<usize> = Vec::new();
	let mut drop: FxHashSet<usize> = FxHashSet::default();
	for k in 0..parts.len() {
		match &parts[k] {
			Part::Line(l) if l.trim().is_empty() || l.starts_with('#') => continue,
			Part::Line(_) | Part::Step { gate: None, .. } => run.clear(),
			Part::Step { gate: Some((rest, r, c)), .. } => {
				let (rest, r, c) = (rest.clone(), r.clone(), c.clone());
				// (Whether a step's lines leave: a flight, a hearth, or the goto to a boat, zeppelin or tram.)
				let leaves = |ls: &[String]| ls.iter().any(|l| matches!(head_ws(l), Some("fly" | "hearth")) || (head_ws(l) == Some("goto") && re!(r#""(Boat|Zeppelin|Tram|Ship) to "#).is_match(l)));
				let flies = |ls: &[String]| ls.iter().any(|l| matches!(head_ws(l), Some("fly" | "hearth")));
				// (Some of the characters of races `r` and classes `c` see step m, a flight or hearth of
				// theirs, or any travel of theirs when the step merged leaves: its races and classes meet
				// theirs, a list without classes being every class.)
				let departs = leaves(&rest);
				let meets = |m: usize, r: &[String], c: &[String]| matches!(&parts[m], Part::Step { gate: Some((mrest, mr, mc)), .. } if mr.iter().any(|x| r.contains(x)) && (mc.is_empty() || c.is_empty() || mc.iter().any(|x| c.contains(x))) && (departs || flies(mrest)));
				// (A step of its own characters between: the Gnomes' flight to Thelsamar before their walk
				// into the Badlands, which the Dwarves walk first; the Gnome Warriors' boat from Ratchet
				// before their flight from Booty Bay to Darkshire, which the Dwarves take first.)
				let between = |e: usize, r: &[String], c: &[String]| run.iter().any(|&m| m > e && meets(m, r, c));
				let same = run.iter().copied().find(|&e| matches!(&parts[e], Part::Step { gate: Some((er, _, ec)), .. } if *er == rest && *ec == c));
				let races_of = |e: usize| match &parts[e] {
					Part::Step { gate: Some((_, er, _)), .. } => er.clone(),
					_ => Vec::new(),
				};
				// (e's races, then those of k it lacks.)
				let both = |e: usize| {
					let mut er = races_of(e);
					for x in &r {
						if !er.contains(x) {
							er.push(x.clone());
						}
					}
					er
				};
				match same {
					Some(e) if !between(e, &r, &c) => {
						let er = both(e);
						if let Part::Step { gate: Some((_, x, _)), .. } = &mut parts[e] {
							*x = er;
						}
						drop.insert(k);
					}
					// (The earlier copy at the later one's place: everyone it was for passes nothing of
					// theirs on the way there.)
					Some(e) if !between(e, &races_of(e), &c) => {
						let er = both(e);
						if let Part::Step { gate: Some((_, x, _)), .. } = &mut parts[k] {
							*x = er;
						}
						drop.insert(e);
						run.retain(|&m| m != e);
						run.push(k);
					}
					_ => run.push(k),
				}
			}
		}
	}
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	for (k, p) in parts.into_iter().enumerate() {
		match p {
			Part::Line(l) => out.push(l),
			Part::Step { .. } if drop.contains(&k) => {}
			Part::Step { lines, gate: None } => out.extend(lines),
			Part::Step { lines, gate: Some((_, r, c)) } => {
				let everyone = all_races.iter().all(|x| r.contains(x));
				let list: Vec<String> = if everyone { c.clone() } else { r.iter().chain(c.iter()).cloned().collect() };
				for l in lines {
					if only_re.is_match(&l) {
						if !list.is_empty() {
							out.push(format!("  only {}", list.join(",")));
						}
					} else {
						out.push(l);
					}
				}
			}
		}
	}
	out.join("\n")
}

/// Travel steps alike but for their audiences (title and lines the same less the step's `only` and
/// the goals' own `only`), whose audiences together are every character of the faction (`combos`:
/// race, class), are one step for everyone, at the first one's place (else the last's) when no
/// character sees a step of its own between: the 13 per-race and per-class copies of one
/// "Winterspring" goto the repair wrote for each character (c15 Alliance 50-60/03-winterspring), the
/// Horde's Tirisfal and zeppelin gotos out of the Eastern Plaguelands.
pub fn collapse_audience_steps(text: &str, combos: &[(String, String)], faction: &str) -> String {
	use forge_guide::conditions::Audience;
	let only_re = regex::Regex::new(r"^\s+only\s+([!A-Za-z,]+)\s*$").unwrap();
	let line_only_re = regex::Regex::new(r"^(.*?)\s+only\s+([!A-Za-z,]+)\s*$").unwrap();
	let lines: Vec<&str> = text.split('\n').collect();
	struct St {
		start: usize,
		end: usize,
		aud: Audience,
		/// (title and lines less audiences) for a travel step some characters see; None otherwise.
		key: Option<Vec<String>>,
	}
	let mut steps: Vec<St> = Vec::new();
	let mut i = 0;
	while i < lines.len() {
		if !is_step(lines[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(lines[j]) && !starts_nonspace(lines[j]) {
			j += 1;
		}
		let body: Vec<&str> = lines[i + 1..j].iter().copied().filter(|l| !l.trim().is_empty()).collect();
		let onlys: Vec<&str> = body.iter().copied().filter(|l| only_re.is_match(l)).collect();
		let step_aud = onlys.first().map_or_else(Audience::default, |o| Audience::parse(&only_re.captures(o).unwrap()[1]));
		let goals: Vec<&str> = body.iter().copied().filter(|l| is_goal(split_comment(l).0)).collect();
		let travel = !goals.is_empty() && goals.iter().all(|l| matches!(head_ws(l), Some("goto" | "fly" | "hearth")));
		// The goals' own lists, one for all of them.
		let goal_lists: BTreeSet<Option<String>> = goals.iter().map(|l| line_only_re.captures(split_comment(l).0).map(|m| m[2].to_string())).collect();
		let mut aud = step_aud.clone();
		let mut key = None;
		if travel && onlys.len() <= 1 && goal_lists.len() == 1 {
			if let Some(Some(gl)) = goal_lists.iter().next() {
				aud = aud.and(&Audience::parse(gl));
			}
			if aud != Audience::default() {
				let strip = |l: &str| -> String {
					let (code, rest) = split_comment(l);
					match line_only_re.captures(code).filter(|_| is_goal(code)) {
						Some(m) => format!("{}{rest}", &m[1]),
						None => l.to_string(),
					}
				};
				key = Some(std::iter::once(lines[i].to_string()).chain(body.iter().filter(|l| !only_re.is_match(l)).map(|l| strip(l))).collect());
			}
		}
		steps.push(St { start: i, end: j, aud, key });
		i = j;
	}
	let sees = |a: &Audience, (r, c): &(String, String)| a.admits(r, c, faction);
	let mut drop: FxHashSet<usize> = FxHashSet::default();
	// The step that stands for a group, everyone's now.
	let mut everyone: FxHashSet<usize> = FxHashSet::default();
	for s in 0..steps.len() {
		let Some(key) = steps[s].key.clone() else { continue };
		if drop.contains(&s) || everyone.contains(&s) {
			continue;
		}
		let group: Vec<usize> = (s..steps.len()).filter(|&k| !drop.contains(&k) && !everyone.contains(&k) && steps[k].key.as_ref() == Some(&key)).collect();
		if group.len() < 2 || !combos.iter().all(|p| group.iter().any(|&k| sees(&steps[k].aud, p))) {
			continue;
		}
		// A character's own steps between its copy and where the one step stands: not passed.
		let seen_between = |a: usize, b: usize, p: &(String, String)| (a + 1..b).any(|k| !drop.contains(&k) && !group.contains(&k) && (everyone.contains(&k) || sees(&steps[k].aud, p)));
		let first = group[0];
		let last = *group.last().unwrap();
		let at = if group.iter().all(|&k| combos.iter().filter(|p| sees(&steps[k].aud, p)).all(|p| !seen_between(first, k, p))) {
			first
		} else if group.iter().all(|&k| combos.iter().filter(|p| sees(&steps[k].aud, p)).all(|p| !seen_between(k, last, p))) {
			last
		} else {
			continue;
		};
		for &k in &group {
			if k != at {
				drop.insert(k);
			}
		}
		everyone.insert(at);
	}
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	let mut k = 0;
	let mut i = 0;
	while i < lines.len() {
		match steps.get(k) {
			Some(st) if st.start == i => {
				if everyone.contains(&k) {
					out.extend(st.key.clone().unwrap());
					// (The blank lines after the step's last line stay.)
					out.extend(lines[i + 1..st.end].iter().rev().take_while(|l| l.trim().is_empty()).map(|l| l.to_string()));
				} else if drop.contains(&k) {
					// (With the blank lines after it.)
				} else {
					out.extend(lines[i..st.end].iter().map(|l| l.to_string()));
				}
				i = st.end;
				k += 1;
			}
			_ => {
				out.push(lines[i].to_string());
				i += 1;
			}
		}
	}
	out.join("\n")
}

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::json;

	#[test]
	fn the_own_copy_leaves_the_class_steps_the_shared_tail_has_for_the_start() {
		// Rev14 item 6: the Night Elf Druids' A Lesson to Learn trip and Cure Poison lines were in both their
		// own Darkshore and the shared Darkshore after Westfall.
		let own = "guide g/ne/02\nrace NightElf\n\nstep Auberdine\n  accept 954\n\nstep Fly to Rut'theran Village\n  only NightElf,Druid\n  fly \"Rut'theran Village\"\n\nstep A Lesson to Learn\n  only NightElf,Druid\n  accept 26\n\nstep To Darnassus\n  only Druid\n  tip Fly back to Auberdine.\n  fly \"Auberdine\"\n\nstep Cliffspring Falls\n  collect 1 quest 954\n  collect 15845 quest 6122.1 only NightElf,Druid\n\nstep Lockbox\n  tip Under the water.\n  collect 15845 quest 6122.1 only NightElf,Druid\n\nstep The beach\n  accept 983\n\nstep Back to Auberdine\n  only Druid\n  fly \"Auberdine\"\n";
		let tail = "guide g/03\n\nstep Darnassus\n  only NightElf,Druid\n  accept 26\n\nstep Falls\n  collect 15845 quest 6122.1 only NightElf,Druid\n";
		let out = drop_tail_class_lines(own, tail, "NightElf");
		assert!(
			!out.contains("accept 26") && !out.contains("Rut'theran") && !out.contains("6122") && !out.contains("Lockbox") && !out.contains("To Darnassus") && !out.contains("Back to Auberdine"),
			"{out}"
		);
		assert!(out.contains("accept 954") && out.contains("collect 1 quest 954") && out.contains("accept 983"), "{out}");
		// (Another race's: kept.)
		assert_eq!(drop_tail_class_lines(own, tail, "Human"), own);
		// (A copy whose class step kept only its travel, its hand-ins the tail's.)
		let own2 =
			"guide g/ne/02\nrace NightElf\n\nstep Auberdine\n  accept 954\n  collect 1 quest 6123 only Druid\n\nstep To Darnassus\n  only Druid\n  fly \"Auberdine\"\n\nstep Beach\n  accept 983\n";
		let tail2 = "guide g/03\n\nstep To Darnassus\n  only Druid\n  turnin 98397\n  fly \"Auberdine\"\n";
		let out2 = drop_tail_class_lines(own2, tail2, "NightElf");
		assert!(!out2.contains("To Darnassus") && out2.contains("accept 983") && out2.contains("collect 1 quest 6123"), "{out2}");
	}

	#[test]
	fn a_start_guide_the_route_leaves_untouched_goes_and_the_one_before_hands_over() {
		// RevOrcTroll3 T1: Orc and Troll's own Barrens guide, whose quests the shared order takes in the
		// shared guides, was written as v1 had it, and Durotar's `next` pointed at it.
		let durotar = "guide g/orc/01\nrace Orc,Troll\nnext g/orc/02\n\nstep Razor Hill\n  accept 1\n";
		let orc2 = "guide g/orc/02\nrace Orc,Troll\nnext g/02\n\nstep Crossroads\n  accept 2\n";
		let shared = "guide g/02\n\nstep Crossroads\n  accept 3\n";
		let v1: BTreeMap<String, String> = [("g/orc/01.guide", durotar), ("g/orc/02.guide", orc2), ("g/02.guide", shared)].iter().map(|(a, b)| (a.to_string(), b.to_string())).collect();
		// (The engine may still add lines to the guide the route names no line of: it is in the played chain.)
		let mut own = v1.clone();
		own.insert("g/orc/02.guide".into(), orc2.replace("accept 2", "accept 2\n  along"));
		let canon = own.clone();
		let route_files: FxHashSet<String> = ["g/orc/01.guide".to_string()].into_iter().collect();
		adopt(&mut own, &canon, &v1, &FxHashMap::default(), 1, "g/02", &|_| None, &route_files, &[], &mut |_| {});
		assert!(!own.contains_key("g/orc/02.guide"), "{own:#?}");
		assert!(own["g/orc/01.guide"].contains("\nnext g/02\n"), "{own:#?}");
	}

	#[test]
	fn a_start_guide_the_route_leaves_keeps_only_its_class_steps() {
		// T1 with Orc and Troll's class chains (Thun'grim Firegaze, Call of Fire), which the shared
		// guides do not carry for them: those steps stay, the rest goes.
		let durotar = "guide g/orc/01\nrace Orc,Troll\nnext g/orc/02\n\nstep Razor Hill\n  accept 1\n";
		let orc2 = "guide g/orc/02\nrace Orc,Troll\nnext g/02\n\nstep Crossroads\n  accept 2\n  collect 6534 quest 1503.1 only Warrior\n\nstep Thun'grim\n  only Warrior\n  turnin 1502\n";
		let shared = "guide g/02\n\nstep Crossroads\n  accept 3\n";
		let v1: BTreeMap<String, String> = [("g/orc/01.guide", durotar), ("g/orc/02.guide", orc2), ("g/02.guide", shared)].iter().map(|(a, b)| (a.to_string(), b.to_string())).collect();
		let mut own = v1.clone();
		let canon = own.clone();
		let route_files: FxHashSet<String> = ["g/orc/01.guide".to_string()].into_iter().collect();
		adopt(&mut own, &canon, &v1, &FxHashMap::default(), 1, "g/02", &|_| None, &route_files, &[], &mut |_| {});
		let t = &own["g/orc/02.guide"];
		assert!(!t.contains("accept 2") && t.contains("  turnin 1502") && t.contains("step Crossroads\n  collect 6534 quest 1503.1 only Warrior"), "{t}");
		assert!(own["g/orc/01.guide"].contains("\nnext g/orc/02\n"));
	}

	#[test]
	fn a_shared_guide_the_start_plays_before_the_join_is_its_own_guide() {
		// Night Elves do Darkshore to about 14 as part of their own start: their run's Darkshore is
		// their own guide between Teldrassil and Westfall; the shared Darkshore stays the canon's.
		let teldrassil = "guide g/ne/01-teldrassil\ntitle Teldrassil\nrace NightElf\nnext g/03-darkshore\n\nstep Dolanaar\n  accept 1\n";
		let darkshore_v1 = "guide g/03-darkshore\ntitle Darkshore\nnext g/02-westfall\n\nstep Auberdine\n  accept 2\n";
		let westfall = "guide g/02-westfall\ntitle Westfall\n\nstep Sentinel Hill\n  accept 3\n";
		// (Another start's v1 guide in the tree also leads to the join and sorts first: c14 wrote the
		// Night Elves' Darkshore as `dwarf-gnome/02-darkshore` with the Dwarves' race.)
		let dun_morogh = "guide g/dg/01-dun-morogh\ntitle Dun Morogh\nrace Dwarf,Gnome\nnext g/02-westfall\n\nstep Kharanos\n  accept 7\n";
		let v1: BTreeMap<String, String> =
			[("g/dg/01-dun-morogh.guide", dun_morogh), ("g/ne/01-teldrassil.guide", teldrassil), ("g/03-darkshore.guide", darkshore_v1), ("g/02-westfall.guide", westfall)]
				.iter()
				.map(|(a, b)| (a.to_string(), b.to_string()))
				.collect();
		let mut own = v1.clone();
		own.insert("g/ne/01-teldrassil.guide".into(), teldrassil.replace("accept 1", "accept 1\n  accept 4"));
		own.insert("g/03-darkshore.guide".into(), darkshore_v1.replace("accept 2", "accept 2\n  accept 5"));
		let mut canon = v1.clone();
		canon.insert("g/03-darkshore.guide".into(), darkshore_v1.replace("accept 2", "accept 2\n  accept 6"));
		let route_files: FxHashSet<String> = ["g/ne/01-teldrassil.guide".to_string(), "g/03-darkshore.guide".to_string()].into_iter().collect();
		adopt(&mut own, &canon, &v1, &FxHashMap::default(), 1, "g/02-westfall", &|_| None, &route_files, &["g/03-darkshore.guide".to_string()], &mut |_| {});
		let mine = own.get("g/ne/02-darkshore.guide").expect("own Darkshore guide");
		assert!(mine.contains("guide g/ne/02-darkshore\n") && mine.contains("\nrace NightElf\n") && mine.contains("\nnext g/02-westfall\n") && mine.contains("accept 5"), "{mine}");
		assert!(own["g/ne/01-teldrassil.guide"].contains("\nnext g/ne/02-darkshore\n"), "{own:#?}");
		assert!(own["g/03-darkshore.guide"].contains("accept 6") && !own["g/03-darkshore.guide"].contains("accept 5"));
		assert!(!own.contains_key("g/dg/02-darkshore.guide") && own["g/dg/01-dun-morogh.guide"].contains("\nnext g/02-westfall\n"), "{own:#?}");
	}

	#[test]
	fn a_class_step_before_everyones_way_in_goes_with_the_arrival() {
		// RevNightElf3 N6: the Warriors' Defensive Stance in Stormwind came before the boat's arrival
		// lines in the join guide, so the arrival stopped at it and everyone's boat was lost.
		let t = "guide g\n\nstep Fly\n  only Warrior\n  fly \"Auberdine\"\n\nstep Defensive Stance\n  only Warrior\n  accept 1638\n\nstep Boat\n  goto 30.8,40.9 \"Boat to Stormwind Harbor\"\n\nstep Sentinel Hill\n  accept 36\n\nstep Paladin\n  only Paladin\n  accept 9\n";
		let (rest, moved) = split_arrival(t);
		assert!(moved.iter().any(|l| l.contains("Boat to Stormwind")) && moved.iter().any(|l| l == "  accept 1638"), "{moved:?}");
		assert!(rest.contains("step Sentinel Hill") && rest.contains("accept 9"), "{rest}");
		// (A class step after the last way in stays in the guide.)
		let (rest2, moved2) = split_arrival("guide g\n\nstep Boat\n  goto 1,1 \"Boat\"\n\nstep Paladin\n  only Paladin\n  accept 9\n\nstep Hill\n  accept 36\n");
		assert!(rest2.contains("accept 9") && !moved2.iter().any(|l| l.contains("accept 9")), "{rest2}");
	}

	#[test]
	fn a_split_shared_guides_later_quests_are_still_the_starts_own_tail() {
		// Rev14NightElf A1: Darkshore on both sides of the Night Elves' join. Their own part's quest (21,
		// at most 14) is the other starts' in the shared guide; their tail's quest (22) is theirs too.
		let r = |canon: &str, js: usize, order: serde_json::Value| -> Route {
			serde_json::from_value(json!({ "shared": { "canonical": canon, "joinAt": "02-westfall", "joinStep": js }, "order": order })).unwrap()
		};
		let human = r(
			"Human",
			0,
			json!([{ "t": "accept", "q": 36, "from": "guides/g/02-westfall.guide:9" }, { "t": "accept", "q": 21, "from": "guides/g/03-darkshore.guide:9" }, { "t": "accept", "q": 22, "from": "guides/g/03-darkshore.guide:20" }]),
		);
		let ne = r(
			"Human",
			1,
			json!([{ "t": "accept", "q": 21, "from": "guides/g/03-darkshore.guide:9" }, { "t": "accept", "q": 36, "from": "guides/g/02-westfall.guide:9" }, { "t": "accept", "q": 22, "from": "guides/g/03-darkshore.guide:20" }]),
		);
		let starts = [Start { name: "Human".into(), route: &human }, Start { name: "NightElf".into(), route: &ne }];
		let facts = Facts { race_file: &|_: &str| false, takes: &|_, _| true, yd: &|_, _| 0.0 };
		let s = faction_tail(&starts, &facts).unwrap();
		assert_eq!(s.by_quest[&21].iter().cloned().collect::<Vec<_>>(), ["Human"]);
		assert_eq!(s.by_quest[&22].iter().cloned().collect::<Vec<_>>(), ["Human", "NightElf"]);
	}

	#[test]
	fn a_way_to_work_some_races_alone_do_is_theirs() {
		// Rev14 (4), Night Elves' Darkshore: the boat to Auberdine and the bears' goto, whose work is
		// `only Dwarf,Gnome,Human,Skyborne`, still sent Night Elves there.
		let races: Vec<String> = ["Human", "Dwarf", "NightElf"].iter().map(|s| s.to_string()).collect();
		let t = "step Boat\n  goto 22.7,56.7 \"Boat to Auberdine\"\n\nstep Auberdine\n  accept 1 only Dwarf,Human\n  accept 2 only Human\n\nstep Bears\n  goto 39.9,53.9\n  complete 984 only Dwarf,Human\n\nstep Hill\n  goto 50.0,50.0 \"Hill\"\n\nstep Everyone\n  accept 3\n";
		let out = gate_ways(t, &races);
		assert!(out.contains("step Boat\n  only Dwarf,Human\n"), "{out}");
		assert!(out.contains("  goto 39.9,53.9 only Dwarf,Human"), "{out}");
		assert!(out.contains("step Hill\n  goto 50.0,50.0"), "{out}");
	}

	#[test]
	fn a_steps_closing_flight_path_goes_after_its_carried_hand_in() {
		// c15 Skyborne Druids: Dendrite's step ended with the Moonglade flight path; Sheldras' welcome (a
		// carried hand-in at Dendrite) went in a `when` step after it: to the flight master and back.
		let carried: FxHashSet<u32> = [94914].into_iter().collect();
		let t = "step Dendrite Starblaze\n  only Druid\n  accept 98341 only Skyborne\n  turnin 94914 only Skyborne\n  getfp \"Moonglade\"\n\nstep Next\n  accept 1\n";
		let out = isolate_carried(t, &carried);
		assert!(out.find("turnin 94914").unwrap() < out.find("getfp").unwrap(), "{out}");
		assert!(out.find("accept 98341").unwrap() < out.find("turnin 94914").unwrap(), "{out}");
	}

	#[test]
	fn a_carried_hand_in_before_the_steps_other_goals_goes_in_a_step_before_it() {
		// c14 Skyborne: Thrall's 95350 hand-in (carried from the isle) came after the follow-ups' accepts
		// in the Valley of Wisdom: not ready.
		let carried: FxHashSet<u32> = [95350].into_iter().collect();
		let t = "step Valley of Wisdom\n  tip Thrall stands in Grommash Hold.\n  turnin 95350 only Skyborne\n  accept 98024 only Skyborne\n\nstep Next\n  accept 1\n";
		let out = isolate_carried(t, &carried);
		let h = out.find("turnin 95350").unwrap();
		assert!(h < out.find("accept 98024").unwrap(), "{out}");
		assert!(out[..h].contains("when onquest 95350"), "{out}");
	}

	#[test]
	fn a_carried_quests_step_keeps_the_steps_when_lines() {
		// c16 Skyborne-alliance: Hogger's claw (176, an elite group quest the Skyborne carry in from the
		// isle) in Westfall's shared guide lost its step's `when group 176` when moved to its `when
		// onquest` step; the pack check refuses an elite's drop with no `when group`.
		let carried: FxHashSet<u32> = [176].into_iter().collect();
		let t = "step Wanted: Hogger\n  zone Elwynn Forest\n  when group 176\n  collect 1931 quest 176.1 only Skyborne\n\nstep Next\n  accept 1\n";
		let out = isolate_carried(t, &carried);
		let c = out.find("collect 1931").unwrap();
		let s = out[..c].rfind("step ").unwrap();
		assert!(out[s..c].contains("when group 176") && out[s..c].contains("when onquest 176"), "{out}");
	}

	#[test]
	fn a_quest_the_shared_order_never_accepts_is_for_the_starts_that_carry_it() {
		// RevSkyH3 S5: Telf's 1525 hand-in in the shared Barrens guide, accepted in Mulgore by Tauren
		// only, was written for every start's Shamans.
		let r = |order: serde_json::Value| -> Route { serde_json::from_value(json!({ "shared": { "canonical": "Tauren", "joinStep": 1 }, "order": order })).unwrap() };
		let tauren = r(json!([{ "t": "accept", "q": 1525, "from": "guides/g/tauren/01.guide:9" }, { "t": "turnin", "q": 1525, "from": "guides/g/02.guide:20" }]));
		let sky = r(json!([{ "t": "accept", "q": 7, "from": "guides/g/sky/01.guide:9" }, { "t": "turnin", "q": 1525, "from": "guides/g/02.guide:20" }]));
		let starts = [Start { name: "Tauren".into(), route: &tauren }, Start { name: "Skyborne-horde".into(), route: &sky }];
		let facts = Facts { race_file: &|f: &str| f.contains("/tauren/") || f.contains("/sky/"), takes: &|_, _| true, yd: &|_, _| 0.0 };
		let s = faction_tail(&starts, &facts).unwrap();
		assert_eq!(s.by_quest[&1525].iter().cloned().collect::<Vec<_>>(), ["Tauren"]);
	}

	#[test]
	fn the_same_way_for_two_races_is_not_merged_past_one_races_own_step() {
		// c14 Gnome: the Dwarves' walk into the Badlands and the Gnomes' (after their flight to
		// Thelsamar) became one step before the Gnomes' flight.
		let races: Vec<String> = ["Human", "Dwarf", "Gnome"].iter().map(|s| s.to_string()).collect();
		let text =
			"step Badlands\n  only Dwarf\n  goto 50.9,62.4 \"Badlands\"\n\nstep Fly to Thelsamar\n  only Gnome\n  fly \"Thelsamar\"\n\nstep Badlands\n  only Gnome\n  goto 50.9,62.4 \"Badlands\"\n";
		let out = merge_gated_steps(text, &races);
		let fly = out.find("fly \"Thelsamar\"").unwrap();
		assert!(out[fly..].contains("goto 50.9,62.4"), "{out}");
	}

	#[test]
	fn the_same_way_merged_past_another_races_own_ride_stands_after_it() {
		// Alliance 40-50/01-stranglethorn-vale:181-286: the Gnomes' flight from Booty Bay to Darkshire
		// was merged into the Dwarves', before the Gnome Warriors' boat from Ratchet to Booty Bay: they
		// were sent to Booty Bay's flight master while still in the Barrens. The one step stands after
		// every race's boat.
		let races: Vec<String> = ["Human", "Dwarf", "Gnome"].iter().map(|s| s.to_string()).collect();
		let text = "step Boat to Booty Bay\n  only Dwarf\n  goto 63.4,38.5 \"Boat to Booty Bay\"\n\nstep Fly to Darkshire\n  only Dwarf\n  goto 27.5,77.7 \"Booty Bay flight master\"\n  fly \"Darkshire\"\n\nstep Boat to Booty Bay\n  only Gnome,Warrior\n  goto 63.4,38.5 \"Boat to Booty Bay\"\n\nstep Fly to Darkshire\n  only Gnome\n  goto 27.5,77.7 \"Booty Bay flight master\"\n  fly \"Darkshire\"\n";
		let out = merge_gated_steps(text, &races);
		assert_eq!(out.matches("fly \"Darkshire\"").count(), 1, "{out}");
		let fly = out.find("step Fly to Darkshire\n  only Dwarf,Gnome\n").unwrap_or_else(|| panic!("{out}"));
		assert!(out[..fly].contains("only Gnome,Warrior\n  goto 63.4,38.5"), "{out}");
	}

	#[test]
	fn a_start_guides_level_event_keeps_its_own_target() {
		// RevH1-3 F1: Orc's grind to 16 in its own Barrens guide became Silverpine's grind to 19, the
		// shared order's line of the same (level, no quest) event.
		let r = |order: serde_json::Value| -> Route { serde_json::from_value(json!({ "shared": { "canonical": "Orc", "joinStep": 0 }, "order": order })).unwrap() };
		let orc = r(json!([{ "t": "level", "from": "guides/g/orc/02.guide:9", "lvl": 16 }, { "t": "level", "from": "guides/g/03.guide:290", "lvl": 19 }]));
		let starts = [Start { name: "Orc".into(), route: &orc }];
		let facts = Facts { race_file: &|f: &str| f.contains("/orc/"), takes: &|_, _| true, yd: &|_, _| 0.0 };
		let t = faction_tail(&starts, &facts).unwrap().tail;
		assert_eq!(t[0].from.as_deref(), Some("inserted"), "{t:#?}");
		assert_eq!(t[1].from.as_deref(), Some("guides/g/03.guide:290"));
	}

	#[test]
	fn a_start_keeps_its_own_way_to_the_shared_route() {
		// RevUndead3 U4: Undead hearth to Brill and take the zeppelin to the Crossroads; the shared
		// order's first event carried Orc's way there, and the Undead hand-off lost its hearth.
		let undead: Route = serde_json::from_value(json!({ "shared": { "canonical": "Orc", "joinStep": 1 }, "order": [
			{ "t": "turnin", "q": 1, "from": "guides/g/undead/01.guide:9" },
			{ "t": "accept", "q": 844, "from": "guides/g/02.guide:76", "items": [{ "t": "hearth", "inn": 8, "to": 7738 }] }
		] }))
		.unwrap();
		let tail: Vec<Order> = serde_json::from_value(
			json!([{ "t": "accept", "q": 844, "from": "guides/g/02.guide:76", "items": [{ "t": "network", "from": 1, "to": 7738 }] }, { "t": "accept", "q": 869, "from": "guides/g/02.guide:82" }]),
		)
		.unwrap();
		let r = with_tail(&undead, &tail);
		assert_eq!(r.order.len(), 3);
		assert_eq!(r.order[1].items().iter().map(|x| x.t).collect::<Vec<_>>(), vec![crate::input::ItemT::Hearth], "{:#?}", r.order);
	}

	#[test]
	fn a_starts_own_way_leads_to_the_shared_orders_first_event() {
		// c17 Gnome: the tram to Stormwind and the walk to Ozwin (the Gnomes' own first Westfall event,
		// the shared order's sixth) went onto Ozwin's accept at Saldean's Farm; the guide walked from
		// Kharanos straight to the Jansen Stead.
		let gnome: Route = serde_json::from_value(json!({ "shared": { "canonical": "Human", "joinStep": 1 }, "order": [
			{ "t": "turnin", "q": 1, "from": "guides/g/dg/01.guide:9" },
			{ "t": "accept", "q": 92909, "pt": 29097, "from": "guides/g/02.guide:147", "items": [{ "t": "network", "from": 30161, "to": 29097, "legs": [{ "k": "walk", "to": 48, "node": 51 }, { "k": "ride", "ride": 19, "from": 51, "to": 50 }, { "k": "walk", "to": 0, "node": 0 }, { "k": "walk", "to": 29097 }] }, { "t": "getfp", "node": 0 }] }
		] }))
		.unwrap();
		let tail: Vec<Order> =
			serde_json::from_value(json!([{ "t": "accept", "q": 36, "pt": 2480, "from": "guides/g/02.guide:135" }, { "t": "accept", "q": 92909, "pt": 29097, "from": "guides/g/02.guide:147" }]))
				.unwrap();
		let r = with_tail(&gnome, &tail);
		let first = r.order[1].items();
		assert_eq!(first.iter().map(|x| x.t).collect::<Vec<_>>(), vec![crate::input::ItemT::Network, crate::input::ItemT::Getfp], "{:#?}", r.order);
		assert_eq!((first[0].to, first[0].legs.as_ref().unwrap()[3].to), (Some(2480), Some(2480)));
		assert!(r.order[2].items().is_empty());
	}

	fn ev(t: &str, q: u32, pt: u32) -> serde_json::Value {
		json!({ "t": t, "q": q, "pt": pt, "from": "guides/g/02.guide:1" })
	}

	fn tail_of(starts: &[Start]) -> Vec<(OrderT, u32)> {
		// Points within 20 of each other stand side by side.
		let facts = Facts { race_file: &|_: &str| false, takes: &|_, _| true, yd: &|a: &Order, b: &Order| if a.pt.zip(b.pt).is_some_and(|(x, y)| x.abs_diff(y) <= 20) { 10.0 } else { 1000.0 } };
		faction_tail(starts, &facts).unwrap().tail.iter().map(|o| (o.t, o.q.unwrap())).collect()
	}

	#[test]
	fn an_extra_accept_goes_before_its_own_work_beside_a_shared_stop_at_its_giver() {
		// c18g Westfall (Dwarf, Gnome, Night Elf, Skyborne): Alba's Testing the Wells (92742), taken in
		// their route after Galiaan's Gold Coast kills (153), was written there, after its own vials and
		// hand-in, which follow Saldean's hand-in (9) in the shared order: R10. It goes to the first
		// Sentinel Hill stop (Galiaan's accept; Alba stands beside him).
		let r = |order: serde_json::Value| -> Route { serde_json::from_value(json!({ "shared": { "canonical": "Human", "joinStep": 0 }, "order": order })).unwrap() };
		// (The Gold Coast's next shared event (38) is far too: on its own slot the quest was not kept.)
		let human = r(json!([ev("accept", 153, 1), ev("task", 12, 100), ev("task", 9, 200), ev("turnin", 9, 300), ev("task", 153, 400), ev("task", 38, 600), ev("turnin", 12, 5)]));
		let dwarf = r(json!([
			ev("accept", 153, 1),
			ev("task", 12, 100),
			ev("task", 153, 400),
			ev("accept", 92742, 2),
			ev("task", 9, 200),
			ev("turnin", 9, 300),
			ev("task", 92742, 290),
			ev("task", 38, 600),
			ev("turnin", 12, 5),
			ev("turnin", 92742, 2)
		]));
		let t = tail_of(&[Start { name: "Human".into(), route: &human }, Start { name: "Dwarf".into(), route: &dwarf }]);
		use OrderT::*;
		assert_eq!(t, vec![(Accept, 153), (Accept, 92742), (Task, 12), (Task, 9), (Turnin, 9), (Task, 92742), (Task, 153), (Task, 38), (Turnin, 12), (Turnin, 92742)]);
	}

	#[test]
	fn an_extra_chain_start_goes_before_the_follow_up_another_start_added() {
		// c18g Azshara (Tauren): The Monogrammed Sash (8552) was written after The Captain's Cutlass
		// (8553, same group), which the Trolls' route had added earlier in the shared order: not-ready.
		let r = |order: serde_json::Value| -> Route { serde_json::from_value(json!({ "shared": { "canonical": "Orc", "joinStep": 0 }, "order": order })).unwrap() };
		let g = |t: &str, q: u32, pt: u32| -> serde_json::Value {
			let mut e = ev(t, q, pt);
			e["group"] = json!(8552);
			e
		};
		let orc = r(json!([ev("turnin", 2932, 100), ev("accept", 589, 300), ev("accept", 588, 100), ev("turnin", 2874, 300)]));
		let troll = r(json!([ev("turnin", 2932, 100), ev("accept", 589, 300), g("accept", 8553, 305), g("turnin", 8553, 306), ev("accept", 588, 100), ev("turnin", 2874, 300)]));
		let tauren = r(json!([
			ev("turnin", 2932, 100),
			ev("accept", 589, 300),
			ev("accept", 588, 100),
			g("accept", 8552, 295),
			g("turnin", 8552, 305),
			g("accept", 8553, 305),
			g("turnin", 8553, 306),
			ev("turnin", 2874, 300)
		]));
		let t = tail_of(&[Start { name: "Orc".into(), route: &orc }, Start { name: "Troll".into(), route: &troll }, Start { name: "Tauren".into(), route: &tauren }]);
		use OrderT::*;
		assert_eq!(t, vec![(Turnin, 2932), (Accept, 589), (Accept, 8552), (Turnin, 8552), (Accept, 8553), (Turnin, 8553), (Accept, 588), (Turnin, 2874)]);
	}

	#[test]
	fn an_extra_goes_where_most_starts_have_it() {
		// c18g Westfall: the Night Elves hand Testing the Wells (92742) in right after the vials, the
		// Dwarves and Gnomes after Blanchy's oats (151) with Galiaan (153); the first start's slot won, and
		// the Murloc Gills hand-in, which follows its seed lines, went on a Sentinel Hill trip of its own.
		let r = |order: serde_json::Value| -> Route { serde_json::from_value(json!({ "shared": { "canonical": "Human", "joinStep": 0 }, "order": order })).unwrap() };
		let human = r(json!([ev("accept", 153, 1), ev("task", 9, 200), ev("turnin", 9, 300), ev("turnin", 151, 10), ev("turnin", 153, 5)]));
		let ne = r(json!([
			ev("accept", 153, 1),
			ev("accept", 92742, 2),
			ev("task", 9, 200),
			ev("turnin", 9, 300),
			ev("task", 92742, 290),
			ev("turnin", 92742, 2),
			ev("turnin", 151, 10),
			ev("turnin", 153, 5)
		]));
		let dwarf = r(json!([
			ev("accept", 153, 1),
			ev("accept", 92742, 2),
			ev("task", 9, 200),
			ev("turnin", 9, 300),
			ev("task", 92742, 290),
			ev("turnin", 151, 10),
			ev("turnin", 153, 5),
			ev("turnin", 92742, 2)
		]));
		let starts = [
			Start { name: "Human".into(), route: &human },
			Start { name: "NightElf".into(), route: &ne },
			Start { name: "Dwarf".into(), route: &dwarf },
			Start { name: "Gnome".into(), route: &dwarf },
		];
		use OrderT::*;
		assert_eq!(tail_of(&starts), vec![(Accept, 153), (Accept, 92742), (Task, 9), (Turnin, 9), (Task, 92742), (Turnin, 151), (Turnin, 153), (Turnin, 92742)]);
	}

	#[test]
	fn an_own_guides_step_the_shared_guides_do_learns_no_flight_path_in_the_ways_played() {
		// c18g Troll R1 at Ratchet: v1's Orc and Troll Barrens guide learns Ratchet's flight path in the
		// step whose quests (887, 1492) the shared Barrens guide now takes, so the shared guide's ways
		// counted them as knowing it; the Trolls' written guide no longer has that step.
		let own = "guide g/orc/02\nrace Orc\n\nstep Thun'grim\n  getfp \"Crossroads\"\n  turnin 1502\n\nstep Ratchet\n  getfp \"Ratchet\"\n  sethome \"Ratchet\"\n  accept 887\n  turnin 1492 -- Dizzywig\n\n# Back\nstep Crossroads\n  turnin 1503\n";
		let shared = "guide g/02\n\nstep Ratchet\n  accept 887 -- Gazlowe\n  turnin 1492\n";
		let have = quest_lines([shared].into_iter());
		let t = drop_shared_flight_paths(own, &have);
		assert_eq!(t, own.replace("  getfp \"Ratchet\"\n", ""));
	}

	fn combos() -> Vec<(String, String)> {
		[("Dwarf", "WARRIOR"), ("Dwarf", "PALADIN"), ("Human", "WARRIOR"), ("Human", "PALADIN")].iter().map(|(r, c)| (r.to_string(), c.to_string())).collect()
	}

	#[test]
	fn copies_of_one_way_for_every_character_are_one_step_for_everyone() {
		// c15 Alliance 50-60/03-winterspring:54-119: one goto per race and class the repair played.
		let t = "step Winterspring\n  only Dwarf\n  zone Winterspring\n  goto 62.3,36.6 \"Winterspring\" only Warrior\n\nstep Winterspring\n  only Human\n  zone Winterspring\n  goto 62.3,36.6 \"Winterspring\"\n\nstep Winterspring\n  only Dwarf,Paladin\n  zone Winterspring\n  goto 62.3,36.6 \"Winterspring\"\n\nstep Everlook\n  accept 5\n";
		assert_eq!(collapse_audience_steps(t, &combos(), "Alliance"), "step Winterspring\n  zone Winterspring\n  goto 62.3,36.6 \"Winterspring\"\n\nstep Everlook\n  accept 5\n");
		// Not every character: they stay.
		let some = "step W\n  only Dwarf\n  goto 1,1 \"W\" only Warrior\n\nstep W\n  only Human\n  goto 1,1 \"W\"\n";
		assert_eq!(collapse_audience_steps(some, &combos(), "Alliance"), some);
	}

	#[test]
	fn the_one_step_stands_where_no_character_passes_a_step_of_its_own() {
		// The Humans fly first: the one goto goes after their flight, where the Dwarves' copy waited.
		let t = "step W\n  only Dwarf\n  goto 1,1 \"W\"\n\nstep Fly to Moonglade\n  only Human\n  fly \"Moonglade\"\n\nstep W\n  only Human\n  goto 1,1 \"W\"\n";
		assert_eq!(collapse_audience_steps(t, &combos(), "Alliance"), "step Fly to Moonglade\n  only Human\n  fly \"Moonglade\"\n\nstep W\n  goto 1,1 \"W\"\n");
		// c15 Horde 50-60/05-eastern-plaguelands:164-292: pairs of the walk to the tower and the zeppelin.
		let pairs = "step T\n  only Dwarf\n  goto 2,2 \"T\"\n\nstep Z\n  only Dwarf\n  goto 2,2 \"Zeppelin\"\n\nstep T\n  only Human\n  goto 2,2 \"T\"\n\nstep Z\n  only Human\n  goto 2,2 \"Zeppelin\"\n\nstep Fly\n  fly \"X\"\n";
		assert_eq!(collapse_audience_steps(pairs, &combos(), "Alliance"), "step T\n  goto 2,2 \"T\"\n\nstep Z\n  goto 2,2 \"Zeppelin\"\n\nstep Fly\n  fly \"X\"\n");
	}

	#[test]
	fn a_class_stop_reads_the_level_it_is_played_at_not_the_seeds() {
		// c19p Troll: its own Barrens guide, the Warriors' and Shamans' stop at the Crossroads at 12,
		// kept the seed's `levels 11-17` and the seed's notes on the hand-made route.
		let seed = "guide forever/horde/orc-troll/02-the-barrens\ntitle The Barrens\nrace Orc,Troll\nlevels 11-17\nnext forever/horde/02-the-barrens\n\n# Route: the consensus Orc route, checked by hand.\n\nstep Crossroads\n  accept 1\n\nstep Thun'grim\n  only Warrior\n  turnin 1502\n";
		let kept = class_steps_only(seed).unwrap();
		let t = class_stop_header(&kept, Some("12"));
		assert!(t.starts_with("guide forever/horde/orc-troll/02-the-barrens\ntitle The Barrens\nrace Orc,Troll\nlevels 12-12\nnext forever/horde/02-the-barrens\n\n# Forge's route search"), "{t}");
		assert!(!t.contains("# Route") && !t.contains("accept 1") && t.ends_with("step Thun'grim\n  only Warrior\n  turnin 1502\n"), "{t}");
	}
}
