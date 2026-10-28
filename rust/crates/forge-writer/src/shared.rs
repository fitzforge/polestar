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
use crate::input::{Order, OrderT, Route};
use crate::jsre::{head_ws, is_step, split_comment, starts_nonspace};
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
		let near = |slot: usize, o: &Order| [slot.checked_sub(1), Some(slot)].into_iter().flatten().filter_map(|i| base.get(i)).any(|b| (facts.yd)(o, b) <= EXTRA_NEAR_YD);
		let mut keep: FxHashMap<u32, bool> = FxHashMap::default();
		for &(sl, o) in &extras {
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
		for (sl, o) in extras {
			if o.q.is_some_and(|q| keep.get(&q) == Some(&true)) && added.insert(key(o)) {
				let mut e = o.clone();
				// (Its travel is its start's way there, not everyone's.)
				e.items = None;
				after[sl].push(e);
			}
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

/// `r` with its tail replaced by the faction's shared order. The start's own way to its join event
/// (its hearth and zeppelin from Brill to the Crossroads) stays its own: the shared event carries the
/// canonical start's way there (Orc's walk from Durotar), U4.
pub fn with_tail(r: &Route, tail: &[Order]) -> Route {
	let j = join_step(r).unwrap_or(r.order.len()).min(r.order.len());
	let mut order = r.order[..j].to_vec();
	let at = order.len();
	order.extend(tail.iter().cloned());
	if let Some(own) = r.order.get(j) {
		let k = order[at..].iter().position(|o| key(o) == key(own)).unwrap_or(0);
		if let Some(first) = order.get_mut(at + k) {
			first.items = own.items.clone();
		}
	}
	Route { order, ..r.clone() }
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
	let mut texts: BTreeMap<String, String> = BTreeMap::new();
	for rel in &shared {
		let Some(text) = canon.get(rel).or(v1.get(rel)) else { continue };
		// (The race masks are read on the guides written, not on v1's guides the route leaves alone.)
		let none = |_: u32| None;
		let mut t = tag_audiences(text, by_quest, all_starts, if canon.get(rel) != v1.get(rel) { races_for } else { &none });
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
			route_files.insert(new_rel);
		}
	}
	// The start's own guides just before the join guide that have no line of the start's route
	// (`route_files`: the guides its order names; Orc and Troll's Barrens guide, whose quests the
	// shared order takes in the shared guides) keep only their class steps (Thun'grim Firegaze, Call
	// of Fire: the shared guides do not have them for those races); with none, the guide goes and the
	// guide before it, one of the route's, hands over to the join guide.
	loop {
		let Some(last) = own.iter().find(|(r, t)| !is_shared(t) && next_of(t).as_deref() == Some(join) && !route_files.contains(*r)).map(|(r, _)| r.clone()) else { break };
		let last_id = last.trim_end_matches(".guide").to_string();
		let Some(prev) = own.iter().find(|(r, t)| **r != last && !is_shared(t) && next_of(t).as_deref() == Some(last_id.as_str()) && route_files.contains(*r)).map(|(r, _)| r.clone()) else { break };
		let class_steps = class_steps_only(&own[&last]);
		if let Some(kept) = class_steps {
			own.insert(last, kept);
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
		let heads: Vec<String> = body.iter().filter(|l| matches!(head_ws(l), Some("only" | "zone"))).map(|l| l.to_string()).collect();
		if has_goal {
			out.push(lines[i].to_string());
			let end = kept.iter().rposition(|l| !l.trim().is_empty()).map_or(0, |p| p + 1);
			out.extend(kept[..end].iter().map(|l| l.to_string()));
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
	for ((start, first), race) in starts.iter().zip(&races) {
		// The tree played: v1's guides, the shared ones written; the chain from the start's first guide.
		let mut tree: BTreeMap<String, String> = v1.clone();
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
	for v in shared.values_mut() {
		*v = merge_gated_steps(v, &races);
	}
	log
}

/// In a run of travel steps each `only` some races (goals `goto`, `fly`, `hearth`; nothing but
/// comments and blank lines between), a step with the same title and lines and the same classes as an
/// earlier one in the run goes, its races added to that one's (the zeppelin to the Undercity for
/// Undead and Skyborne: one step); a step for every race of the faction is for everyone.
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
				// (Not past a flight or hearth of its own races between: the Gnomes' flight to Thelsamar before
				// their walk into the Badlands, which the Dwarves walk first.)
				let theirs_between = |e: usize| run.iter().any(|&m| m > e && matches!(&parts[m], Part::Step { gate: Some((mrest, mr, _)), .. } if mr.iter().any(|x| r.contains(x)) && mrest.iter().any(|l| matches!(head_ws(l), Some("fly" | "hearth")))));
				let into = run.iter().copied().find(|&e| matches!(&parts[e], Part::Step { gate: Some((er, _, ec)), .. } if *er == rest && *ec == c) && !theirs_between(e));
				match into {
					Some(e) => {
						if let Part::Step { gate: Some((_, er, _)), .. } = &mut parts[e] {
							for x in r {
								if !er.contains(&x) {
									er.push(x);
								}
							}
						}
						drop.insert(k);
					}
					None => run.push(k),
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

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::json;

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
		let v1: BTreeMap<String, String> = [("g/dg/01-dun-morogh.guide", dun_morogh), ("g/ne/01-teldrassil.guide", teldrassil), ("g/03-darkshore.guide", darkshore_v1), ("g/02-westfall.guide", westfall)].iter().map(|(a, b)| (a.to_string(), b.to_string())).collect();
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
		let text = "step Badlands\n  only Dwarf\n  goto 50.9,62.4 \"Badlands\"\n\nstep Fly to Thelsamar\n  only Gnome\n  fly \"Thelsamar\"\n\nstep Badlands\n  only Gnome\n  goto 50.9,62.4 \"Badlands\"\n";
		let out = merge_gated_steps(text, &races);
		let fly = out.find("fly \"Thelsamar\"").unwrap();
		assert!(out[fly..].contains("goto 50.9,62.4"), "{out}");
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
		let tail: Vec<Order> = serde_json::from_value(json!([{ "t": "accept", "q": 844, "from": "guides/g/02.guide:76", "items": [{ "t": "network", "from": 1, "to": 7738 }] }, { "t": "accept", "q": 869, "from": "guides/g/02.guide:82" }])).unwrap();
		let r = with_tail(&undead, &tail);
		assert_eq!(r.order.len(), 3);
		assert_eq!(r.order[1].items().iter().map(|x| x.t).collect::<Vec<_>>(), vec![crate::input::ItemT::Hearth], "{:#?}", r.order);
	}
}
