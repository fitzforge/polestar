//! The route order's fixes before writing (timed items, item-started accepts) and the passes
//! over the written guides (accepts before their work, item turn-ins after their items,
//! hearths the route is not bound for, travel lines per audience, riding words).

use crate::apply::{line_only, qkey, quest_of, ALL_RACES, CLASSES};
use crate::guide::{is_goal, Key, Step};
use crate::input::{Data, ItemT, Order, OrderT, World};
use forge_core::jsnum::js_hypot;
use crate::jsre::{head_ws, is_step, split_comment, starts_nonspace, trim, trim_end};
use crate::re;
use rustc_hash::{FxHashMap, FxHashSet};
use std::collections::BTreeMap;

/// Lines less the steps left with no goal.
pub fn no_empty_steps(out: Vec<String>) -> Vec<String> {
	let mut res = Vec::with_capacity(out.len());
	let mut i = 0;
	while i < out.len() {
		if is_step(&out[i]) {
			let mut j = i + 1;
			while j < out.len() && !is_step(&out[j]) && !starts_nonspace(&out[j]) {
				j += 1;
			}
			if !out[i + 1..j].iter().any(|l| is_goal(l)) {
				i = j;
				continue;
			}
			// A step named for a hearth whose hearth the route's travel took out is named for the
			// place (v1's "Hearth to Auberdine" turn-ins after the route's own hearth step).
			if let Some(place) = out[i].strip_prefix("step Hearth to ") {
				if !out[i + 1..j].iter().any(|l| crate::re!(r"^\s+hearth\s").is_match(l)) {
					res.push(format!("step {place}"));
					i += 1;
					continue;
				}
			}
		}
		res.push(out[i].clone());
		i += 1;
	}
	res
}

/// A way step (nothing but a goto, for everyone) into a zone the guide leaves again at once for the
/// zone it came from, with nothing done there: a trip for nobody (A1c: everyone sent from Orgrimmar
/// to Thunder Bluff and straight back, the trainers there being a class's own step).
pub fn no_dead_end_legs(out: Vec<String>) -> Vec<String> {
	struct S {
		start: usize,
		end: usize,
		zone: Option<String>,
		way: bool,
	}
	let mut steps: Vec<S> = Vec::new();
	let mut zone: Option<String> = None;
	let mut i = 0;
	while i < out.len() {
		if !is_step(&out[i]) {
			if let Some(z) = crate::re!(r"^zone\s+(.+)$").captures(&out[i]) {
				zone = Some(trim(&z[1]).to_string());
			}
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < out.len() && !is_step(&out[j]) && !starts_nonspace(&out[j]) {
			j += 1;
		}
		let body = &out[i + 1..j];
		if let Some(z) = body.iter().find_map(|l| crate::re!(r"^\s+zone\s+(.+)$").captures(l).map(|m| trim(&m[1]).to_string())) {
			zone = Some(z);
		}
		let goals: Vec<&String> = body.iter().filter(|l| is_goal(l)).collect();
		let way = !goals.is_empty() && goals.iter().all(|l| crate::re!(r"^\s+goto\s").is_match(l) && !l.contains(" only ")) && !body.iter().any(|l| crate::re!(r"^\s+(only|when)\s").is_match(l));
		steps.push(S { start: i, end: j, zone: zone.clone(), way });
		i = j;
	}
	let mut drop: Vec<(usize, usize)> = Vec::new();
	for k in 1..steps.len().saturating_sub(1) {
		let (p, s, n) = (&steps[k - 1], &steps[k], &steps[k + 1]);
		if s.way && s.zone.is_some() && p.zone == n.zone && s.zone != p.zone {
			drop.push((s.start, s.end));
		}
	}
	if drop.is_empty() {
		return out;
	}
	out.into_iter().enumerate().filter(|(i, _)| !drop.iter().any(|&(a, b)| (a..b).contains(i))).map(|(_, l)| l).collect()
}

/// A class's trip that does nothing: its travel-only step out (`only Warlock`, goto and fly) and its
/// travel-only step back for the same classes, with no step between for any of them, both go (the
/// Warlocks' and Rogues' Ratchet -> Orgrimmar -> Ratchet flights whose class step the route holds for
/// a later visit, FlowDiag 1). A step between for everyone, or one naming any of those classes or
/// any race, ends the search.
pub fn no_class_round_trips(out: Vec<String>) -> Vec<String> {
	struct S {
		start: usize,
		end: usize,
		only: Option<Vec<String>>,
		travel: bool,
	}
	let only_re = crate::re!(r"^\s+only\s+([A-Za-z,!]+)\s*$");
	let mut steps: Vec<S> = Vec::new();
	let mut i = 0;
	while i < out.len() {
		if !is_step(&out[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < out.len() && !is_step(&out[j]) && !starts_nonspace(&out[j]) {
			j += 1;
		}
		let body = &out[i + 1..j];
		let only = body.iter().find_map(|l| only_re.captures(split_comment(l).0).map(|m| m[1].split(',').map(|x| trim(x).to_string()).collect::<Vec<_>>()));
		let goals: Vec<&String> = body.iter().filter(|l| is_goal(l)).collect();
		let travel = !goals.is_empty() && goals.iter().all(|l| matches!(head_ws(l), Some("goto" | "fly")) && line_only(l).is_none()) && goals.iter().any(|l| head_ws(l) == Some("fly"));
		steps.push(S { start: i, end: j, only, travel });
		i = j;
	}
	fn classes_only(o: &Option<Vec<String>>) -> Option<&Vec<String>> {
		o.as_ref().filter(|v| v.iter().all(|c| CLASSES.contains(&c.as_str())))
	}
	let mut drop: Vec<(usize, usize)> = Vec::new();
	let mut used = vec![false; steps.len()];
	for a in 0..steps.len() {
		let Some(cl) = classes_only(&steps[a].only).filter(|_| steps[a].travel && !used[a]) else { continue };
		for b in a + 1..steps.len() {
			let o = &steps[b].only;
			let disjoint = classes_only(o).is_some_and(|v| !v.iter().any(|c| cl.contains(c)));
			if disjoint {
				continue;
			}
			if steps[b].travel && o.as_ref() == Some(cl) && !used[b] {
				used[a] = true;
				used[b] = true;
				drop.push((steps[a].start, steps[a].end));
				drop.push((steps[b].start, steps[b].end));
			}
			break;
		}
	}
	if drop.is_empty() {
		return out;
	}
	out.into_iter().enumerate().filter(|(i, _)| !drop.iter().any(|&(a, b)| (a..b).contains(i))).map(|(_, l)| l).collect()
}

/// v1's bare `collect N` of an item one of the route's quests asks for, and only one: tagged with
/// that quest (`collect 5075 x1 quest 5052`), so the line is that quest's work and waits for its
/// accept (Blood Shards at the Bristleback camps).
pub fn tag_quest_collects(files: &mut [String], data: &Data, in_route: &FxHashSet<u32>) {
	let mut by_item: FxHashMap<u32, Vec<u32>> = FxHashMap::default();
	for &q in in_route {
		let Some(r) = data.quests.get(&q) else { continue };
		for o in r.objectives() {
			if let Some(id) = o.id.filter(|_| o.is("item")) {
				let v = by_item.entry(id as u32).or_default();
				if !v.contains(&q) {
					v.push(q);
				}
			}
		}
	}
	let re = crate::re!(r"^(\s+collect\s+(\d+)\b[^-]*?)(\s*(?:--.*)?)$");
	// (Only after the quest's accept, read in the chain's order.)
	let mut taken: FxHashSet<u32> = FxHashSet::default();
	for f in files.iter_mut() {
		let mut changed = false;
		let lines: Vec<String> = f
			.split('\n')
			.map(|l| {
				if let Some(m) = crate::re!(r"^\s+accept\s+(\d+)\b").captures(l) {
					taken.extend(m[1].parse::<u32>().ok());
				}
				let Some(m) = re.captures(l).filter(|_| !crate::re!(r"\bquest\s+\d").is_match(split_comment(l).0)) else { return l.to_string() };
				let Some(&[q]) = m[2].parse::<u32>().ok().and_then(|id| by_item.get(&id)).map(Vec::as_slice).filter(|v| taken.contains(&v[0])) else { return l.to_string() };
				changed = true;
				let code = trim_end(&m[1]);
				let (code, opt) = match code.strip_suffix(" optional") {
					Some(c) => (trim_end(c), " optional"),
					None => (code, ""),
				};
				format!("{code} quest {q}{opt}{}", &m[3])
			})
			.collect();
		if changed {
			*f = lines.join("\n");
		}
	}
}

/// Consecutive pieces of the same place, split only because the route's order runs through them
/// (four "Auberdine" steps in a row, A13): one step. The first must not travel on (goto, fly, hearth)
/// nor be for some characters only; the second adds no tip, label, condition or zone of its own.
/// A piece that ends with v1's boat or zeppelin goto still joins: the goto goes last, after the
/// town's last piece (Thundris' Blackwood hand-in after "Boat to Stormwind", A15).
pub fn same_place_pieces(out: Vec<String>) -> Vec<String> {
	fn put_tail(res: &mut Vec<String>, tail: &mut Vec<String>) {
		if tail.is_empty() {
			return;
		}
		let at = res.len() - res.iter().rev().take_while(|l| l.trim().is_empty()).count();
		res.splice(at..at, std::mem::take(tail));
	}
	let transport = |l: &str| crate::re!(r#"(?i)^\s+goto\s.*"(?:Boat|Zeppelin|Tram|Ship) to"#).is_match(l) && !l.contains(" only ");
	let mut res: Vec<String> = Vec::with_capacity(out.len());
	// (Index in `res` of the last step's title, its zone after it, and whether a piece may join it.)
	let mut last: Option<(usize, bool)> = None;
	let mut tail: Vec<String> = Vec::new();
	let mut zone: Option<String> = None;
	let mut i = 0;
	while i < out.len() {
		if !is_step(&out[i]) {
			if let Some(z) = crate::re!(r"^zone\s+(.+)$").captures(&out[i]) {
				zone = Some(trim(&z[1]).to_string());
			}
			if starts_nonspace(&out[i]) {
				put_tail(&mut res, &mut tail);
				last = None;
			}
			res.push(out[i].clone());
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < out.len() && !is_step(&out[j]) && !starts_nonspace(&out[j]) {
			j += 1;
		}
		let body = &out[i + 1..j];
		let own_zone = |l: &String| crate::re!(r"^\s+zone\s+(.+)$").captures(l).map(|m| trim(&m[1]).to_string());
		let joins = last.is_some_and(|(t, ok)| ok && res[t] == out[i])
			&& !body.iter().any(|l| crate::re!(r"^\s+(tip|label|along|when|only|image|loop)\b").is_match(l))
			&& body.iter().filter_map(own_zone).all(|z| Some(&z) == zone.as_ref());
		// (Its trailing boat goto, the step's only travel: kept for the end of the run.)
		let goals: Vec<usize> = (0..body.len()).filter(|&k| is_goal(&body[k])).collect();
		let trail = goals.iter().rev().take_while(|&&k| transport(&body[k])).count();
		let deferred: Vec<usize> = if trail > 0 && trail < goals.len() { goals[goals.len() - trail..].to_vec() } else { Vec::new() };
		let travels = goals.iter().any(|&k| !deferred.contains(&k) && crate::re!(r"^\s+(goto|fly|hearth)\s").is_match(&body[k]));
		if joins {
			// Drop the blank lines between them, then the piece's lines but its zone.
			while res.last().is_some_and(|l| l.trim().is_empty()) {
				res.pop();
			}
			res.extend(body.iter().enumerate().filter(|(k, l)| own_zone(l).is_none() && !l.trim().is_empty() && !deferred.contains(k)).map(|(_, l)| l.clone()));
			let trailing: Vec<String> = body.iter().rev().take_while(|l| l.trim().is_empty()).cloned().collect();
			res.extend(trailing);
		} else {
			put_tail(&mut res, &mut tail);
			let t = res.len();
			res.push(out[i].clone());
			res.extend(body.iter().enumerate().filter(|(k, _)| !deferred.contains(k)).map(|(_, l)| l.clone()));
			last = Some((t, true));
		}
		tail.extend(deferred.iter().map(|&k| body[k].clone()));
		for l in body {
			if let Some(z) = own_zone(l) {
				zone = Some(z);
			}
		}
		// (A piece that travels on, or is someone's only, ends the run.)
		if travels || body.iter().any(|l| crate::re!(r"^\s+(only|when)\s").is_match(l) || l.contains(" only ")) {
			put_tail(&mut res, &mut tail);
			last = None;
		}
		i = j;
	}
	put_tail(&mut res, &mut tail);
	res
}

type Del = Vec<FxHashSet<usize>>;
type Ins = Vec<FxHashMap<usize, Vec<String>>>;

/// Write texts back with lines deleted and inserted after; steps left with no goal go.
fn rewrite(files: &mut [String], texts: &[Vec<String>], del: &Del, ins: &Ins) {
	for (fi, lines) in texts.iter().enumerate() {
		if del[fi].is_empty() && ins[fi].is_empty() {
			continue;
		}
		let mut out = Vec::with_capacity(lines.len());
		for (li, l) in lines.iter().enumerate() {
			if !del[fi].contains(&li) {
				out.push(l.clone());
			}
			if let Some(x) = ins[fi].get(&li) {
				out.extend(x.iter().cloned());
			}
		}
		files[fi] = no_empty_steps(out).join("\n");
	}
}

fn split_lines(files: &[String]) -> Vec<Vec<String>> {
	files.iter().map(|f| f.split('\n').map(str::to_string).collect()).collect()
}

/// A route quest's hand-in kept for some classes in a step of their own (the Druids' Return to Nessa
/// in Darnassus, #402) that the route's order now puts before the quest's accept (the accept moved to
/// the Darkshore arrival): it goes, and the route's own hand-in in a step for the other classes
/// (`only !Druid`) is theirs too, so no hand-in comes before its accept.
pub fn premature_class_turnins(files: &mut [String], in_route: &FxHashSet<u32>) {
	const CLASSES: [&str; 9] = ["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Druid"];
	let texts = split_lines(files);
	let mut first_accept: FxHashMap<u32, (usize, usize)> = FxHashMap::default();
	for (fi, lines) in texts.iter().enumerate() {
		for (li, l) in lines.iter().enumerate() {
			if is_goal(l) && head_ws(l) == Some("accept") {
				if let Some(q) = quest_of(l) {
					first_accept.entry(q).or_insert((fi, li));
				}
			}
		}
	}
	let only_list = |l: &str| trim(&crate::re!(r"^\s+only\s+").replace(split_comment(l).0, "")).to_string();
	let mut del: Del = vec![FxHashSet::default(); texts.len()];
	let mut opened: Vec<(u32, Vec<String>)> = Vec::new();
	for (fi, lines) in texts.iter().enumerate() {
		let mut step_only: Option<String> = None;
		for (li, l) in lines.iter().enumerate() {
			if is_step(l) || starts_nonspace(l) {
				step_only = None;
				continue;
			}
			if head_ws(l) == Some("only") {
				step_only = Some(only_list(l));
				continue;
			}
			if head_ws(l) != Some("turnin") {
				continue;
			}
			let Some(q) = quest_of(l).filter(|q| in_route.contains(q)) else { continue };
			if first_accept.get(&q).is_none_or(|&acc| (fi, li) > acc) {
				continue;
			}
			let list = line_only(l).map(str::to_string).or_else(|| step_only.clone());
			let classes: Vec<String> = list.iter().flat_map(|s| s.split(',')).map(|c| trim(c).to_string()).collect();
			if !classes.is_empty() && classes.iter().all(|c| CLASSES.contains(&c.as_str())) {
				del[fi].insert(li);
				opened.push((q, classes));
			}
		}
	}
	if opened.is_empty() {
		return;
	}
	let mut set: Vec<FxHashMap<usize, String>> = vec![FxHashMap::default(); texts.len()];
	for (fi, lines) in texts.iter().enumerate() {
		let mut only_at: Option<usize> = None;
		for (li, l) in lines.iter().enumerate() {
			if is_step(l) || starts_nonspace(l) {
				only_at = None;
				continue;
			}
			if head_ws(l) == Some("only") {
				only_at = Some(li);
				continue;
			}
			let (Some(oi), Some(q)) = (only_at, quest_of(l).filter(|_| head_ws(l) == Some("turnin") && !del[fi].contains(&li))) else { continue };
			let Some((_, classes)) = opened.iter().find(|(x, _)| *x == q) else { continue };
			let kept: Vec<String> = only_list(&lines[oi]).split(',').map(|c| trim(c).to_string()).filter(|c| !c.strip_prefix('!').is_some_and(|x| classes.iter().any(|k| k == x))).collect();
			if kept.is_empty() {
				del[fi].insert(oi);
			} else {
				set[fi].insert(oi, format!("  only {}", kept.join(",")));
			}
		}
	}
	set_then_rewrite(files, texts, del, set);
}

/// Quests the route does not take: a line working or handing one in that ended up before its
/// accept moves to right after the accept; a step left with no goal goes.
pub fn fix_order(files: &mut [String], in_route: &FxHashSet<u32>, may: &dyn Fn(usize, usize) -> bool) {
	let texts = split_lines(files);
	let mut at: FxHashMap<u32, (usize, usize)> = FxHashMap::default();
	let mut early: Vec<(u32, Vec<(usize, usize)>)> = Vec::new();
	let mut early_idx: FxHashMap<u32, usize> = FxHashMap::default();
	for (fi, lines) in texts.iter().enumerate() {
		for (li, l) in lines.iter().enumerate() {
			if !is_goal(l) {
				continue;
			}
			let Some(q) = quest_of(l) else { continue };
			if in_route.contains(&q) {
				continue;
			}
			if head_ws(l) == Some("accept") {
				at.entry(q).or_insert((fi, li));
			} else if !at.contains_key(&q) {
				let k = *early_idx.entry(q).or_insert_with(|| {
					early.push((q, Vec::new()));
					early.len() - 1
				});
				early[k].1.push((fi, li));
			}
		}
	}
	let mut del: Del = vec![FxHashSet::default(); texts.len()];
	let mut ins: Ins = vec![FxHashMap::default(); texts.len()];
	for (q, xs) in &early {
		let Some(&(afi, ali)) = at.get(q) else { continue };
		for &(fi, li) in xs {
			if !may(afi, fi) {
				continue;
			}
			del[fi].insert(li);
			ins[afi].entry(ali).or_default().push(texts[fi][li].clone());
		}
	}
	rewrite(files, &texts, &del, &ins);
}

fn order_key(o: &Order) -> Option<Key> {
	o.key
}

/// Timed items keep their chain together: the route's items between the goal that gets one
/// and the turn-in of a quest that spends it move to after that turn-in. When the getter is the
/// spender's own task and the route passes its place on the way to the spender's later events, the
/// getter goes there instead (Kerlonian's chest, its horn good for 25 minutes, taken at 19 where
/// the route escorts him at 25 on the way from Auberdine to Maestra's Post: not the escort and the
/// hand-in at 19 with a walk back, A2).
pub fn timed_order(order: Vec<Order>, steps: &[Step], named: &FxHashSet<Key>, anchor_of: &FxHashMap<Key, Key>, data: &Data, world: &World) -> Vec<Order> {
	// (The getter on the way: this much longer than the walk between the two events it goes between.)
	const ON_WAY_YD: f64 = 300.0;
	// (The spender's place: the events this near its first one there.)
	const PLACE_YD: f64 = 300.0;
	let pt = |o: &Order| o.pt.and_then(|p| world.points.get(p as usize)).copied();
	let d = |a: &crate::input::Pt, b: &crate::input::Pt| if a.c == b.c { js_hypot(a.wx - b.wx, a.wy - b.wy) } else { f64::INFINITY };
	let timed = |id: f64| data.items.get(&(id as u32)).is_some_and(|it| it.duration.is_some_and(|d| d != 0.0 && !d.is_nan()));
	let mut spends: FxHashMap<u32, FxHashSet<u32>> = FxHashMap::default();
	for (q, rec) in &data.quests {
		for o in rec.objectives() {
			if let Some(id) = o.id.filter(|_| o.is("item")) {
				if timed(id) {
					spends.entry(id as u32).or_default().insert(*q);
				}
			}
		}
	}
	if spends.is_empty() {
		return order;
	}
	let mut out = order;
	struct Getter {
		item: u32,
		anchor: Key,
	}
	let mut getters: Vec<Getter> = Vec::new();
	for st in steps {
		for l in &st.lines {
			let Some(m) = re!(r"^\s+(?:buy|collect)\s+(\d+)\b").captures(&l.text) else { continue };
			let Some(item) = m[1].parse::<u32>().ok().filter(|i| spends.contains_key(i)) else { continue };
			let key = l.key();
			let a = if named.contains(&key) { Some(key) } else { anchor_of.get(&key).copied() };
			if let Some(a) = a {
				getters.push(Getter { item, anchor: a });
			}
		}
	}
	for (gi, gt) in getters.iter().enumerate() {
		let Some(g) = out.iter().position(|o| order_key(o) == Some(gt.anchor)) else { continue };
		let qs = &spends[&gt.item];
		// Up to the last spender's turn-in before the item's next getter.
		let mut next = out.len();
		for (g2i, g2) in getters.iter().enumerate() {
			if g2i == gi || g2.item != gt.item {
				continue;
			}
			if let Some(k) = out.iter().position(|o| order_key(o) == Some(g2.anchor)) {
				if k > g && k < next {
					next = k;
				}
			}
		}
		let mut s: Option<usize> = None;
		for i in g + 1..next {
			if out[i].t == OrderT::Turnin && out[i].q.is_some_and(|q| qs.contains(&q)) {
				s = Some(i);
			}
		}
		let Some(s) = s else { continue };
		// The getter deferred: before the spender's first event after it, or an event at that place
		// before it, where the route passes nearest the getter.
		let travels = |o: &Order| o.items().iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network | ItemT::Deathskip));
		let own = out[g].t == OrderT::Task && out[g].q.is_some_and(|q| qs.contains(&q)) && !travels(&out[g]);
		let k0 = (g + 1..=s).find(|&i| out[i].q.is_some_and(|q| qs.contains(&q))).unwrap_or(s);
		let defer = own.then(|| {
			let (gp, place) = (pt(&out[g])?, pt(&out[k0])?);
			let mut best: Option<(usize, f64)> = None;
			let mut c = k0;
			while c > g + 1 {
				if let (Some(a), Some(b)) = (pt(&out[c - 1]), pt(&out[c])) {
					let detour = d(&a, &gp) + d(&gp, &b) - d(&a, &b);
					if detour <= ON_WAY_YD && best.is_none_or(|(_, bd)| detour < bd) {
						best = Some((c, detour));
					}
				}
				if pt(&out[c - 1]).is_none_or(|p| d(&p, &place) > PLACE_YD) {
					break;
				}
				c -= 1;
			}
			best.map(|(c, _)| c)
		});
		if let Some(c) = defer.flatten() {
			let mut getter = out[g].clone();
			getter.lvl = out[c].lvl;
			let mut n = Vec::with_capacity(out.len());
			n.extend(out[..g].iter().cloned());
			n.extend(out[g + 1..c].iter().cloned());
			n.push(getter);
			n.extend(out[c..].iter().cloned());
			out = n;
			continue;
		}
		let mut keep = Vec::new();
		let mut moved = Vec::new();
		for o in &out[g + 1..s] {
			if o.q.is_some_and(|q| qs.contains(&q)) {
				keep.push(o.clone());
			} else {
				moved.push(o.clone());
			}
		}
		if moved.is_empty() {
			continue;
		}
		let mut n = Vec::with_capacity(out.len());
		n.extend(out[..=g].iter().cloned());
		n.extend(keep);
		n.push(out[s].clone());
		n.extend(moved);
		n.extend(out[s + 1..].iter().cloned());
		out = n;
	}
	out
}

/// The accept of a quest an item starts, in the v1 step that collects the item, goes right
/// after the route's event the collect line is written with (Croaky's Head, #221).
pub fn item_accepts(order: Vec<Order>, steps: &[Step], named: &FxHashSet<Key>, anchor_of: &FxHashMap<Key, Key>, data: &Data) -> Vec<Order> {
	let mut starts_by: BTreeMap<u32, Vec<u32>> = BTreeMap::new();
	let mut any = false;
	for (q, rec) in &data.quests {
		for &it in rec.start_items() {
			starts_by.entry(it).or_default().push(*q);
			any = true;
		}
	}
	if !any {
		return order;
	}
	let mut out = order;
	for st in steps {
		let step_keys: FxHashSet<Key> = st.lines.iter().map(|l| l.key()).collect();
		for l in &st.lines {
			let Some(m) = re!(r"^\s+collect\s+(\d+)\b.*\boptional\b").captures(&l.text) else { continue };
			let Some(qs) = m[1].parse::<u32>().ok().and_then(|i| starts_by.get(&i)) else { continue };
			let key = l.key();
			let a = if named.contains(&key) { Some(key) } else { anchor_of.get(&key).copied() };
			let Some(a) = a.filter(|a| a.0 == st.file) else { continue };
			for &q in qs {
				let ai = out.iter().position(|o| o.t == OrderT::Accept && o.q == Some(q) && order_key(o).is_some_and(|k| step_keys.contains(&k)));
				let gi = out.iter().position(|o| order_key(o) == Some(a));
				let (Some(ai), Some(gi)) = (ai, gi) else { continue };
				// Earlier only: never past the events that came before it.
				if ai <= gi + 1 {
					continue;
				}
				let acc = out.remove(ai);
				let at = out.iter().position(|o| order_key(o) == Some(a)).unwrap();
				out.insert(at + 1, acc);
			}
		}
	}
	out
}

/// An item turn-in of a quest the route does not work itself that the chain reaches before any
/// line getting the item while one comes later: the turn-in moves to a step of its own right
/// after the step of the last such line it waits for. So too an item-started accept.
pub fn fix_item_turnins(files: &mut [String], data: &Data, world: &World, may: &dyn Fn(usize, usize) -> bool, worked: &FxHashSet<u32>, route_qs: &FxHashSet<u32>) {
	let texts = split_lines(files);
	let mut map_of: FxHashMap<&str, u32> = FxHashMap::default();
	for (m, z) in &world.zones {
		map_of.insert(z.as_str(), *m);
	}
	let mut flat: Vec<(usize, usize)> = Vec::new();
	for (fi, lines) in texts.iter().enumerate() {
		for li in 0..lines.len() {
			flat.push((fi, li));
		}
	}
	let mut gets: FxHashMap<u32, Vec<usize>> = FxHashMap::default();
	for (i, &(fi, li)) in flat.iter().enumerate() {
		if let Some(m) = re!(r"^\s+(?:buy|collect)\s+(\d+)\b").captures(&texts[fi][li]) {
			if let Ok(x) = m[1].parse() {
				gets.entry(x).or_default().push(i);
			}
		}
	}
	let step_end = |fi: usize, li: usize| -> usize {
		let lines = &texts[fi];
		let mut e = li;
		while e + 1 < lines.len() && !is_step(&lines[e + 1]) && !starts_nonspace(&lines[e + 1]) {
			e += 1;
		}
		while e > li && trim(&lines[e]).is_empty() {
			e -= 1;
		}
		e
	};
	let step_start = |fi: usize, li: usize| -> usize {
		let mut b = li;
		while b > 0 && !is_step(&texts[fi][b]) {
			b -= 1;
		}
		b
	};
	let zone_at = |fi: usize, li: usize| -> Option<String> {
		for b in (0..=li).rev() {
			if let Some(m) = re!(r"^\s*zone\s+(.+?)\s*$").captures(&texts[fi][b]) {
				return Some(m[1].to_string());
			}
		}
		None
	};
	let mut del: Del = vec![FxHashSet::default(); texts.len()];
	let mut ins: Ins = vec![FxHashMap::default(); texts.len()];
	for (i, &(xfi, xli)) in flat.iter().enumerate() {
		let xl = &texts[xfi][xli];
		// An item-started accept before any line getting its item while one comes later.
		if let Some(ma) = re!(r"^\s+accept\s+(\d+)\b").captures(xl) {
			if ma[1].parse().is_ok_and(|q: u32| route_qs.contains(&q)) {
				continue;
			}
			let its = qkey(&ma[1]).and_then(|q| data.quests.get(&q)).map_or(&[][..], |r| r.start_items());
			let gs: Vec<usize> = its.iter().flat_map(|it| gets.get(it).cloned().unwrap_or_default()).collect();
			if its.is_empty() || gs.is_empty() || gs.iter().any(|&j| j < i) {
				continue;
			}
			let (tfi, tli) = flat[*gs.iter().min().unwrap()];
			if !may(tfi, xfi) {
				continue;
			}
			del[xfi].insert(xli);
			ins[tfi].entry(tli).or_default().push(xl.clone());
			continue;
		}
		let Some(m) = re!(r"^\s+turnin\s+(\d+)\b").captures(xl) else { continue };
		if re!(r"\bdirect\b").is_match(xl) || m[1].parse().is_ok_and(|q: u32| worked.contains(&q)) {
			continue;
		}
		let rec = qkey(&m[1]).and_then(|q| data.quests.get(&q));
		let mut wait: Option<usize> = None;
		for o in rec.into_iter().flat_map(|r| r.objectives()) {
			if !o.is("item") {
				continue;
			}
			let gs = o.id.and_then(|id| gets.get(&(id as u32)));
			let Some(gs) = gs.filter(|g| !g.is_empty()) else { continue };
			if gs.iter().any(|&j| j < i) {
				continue;
			}
			wait = Some(wait.map_or(gs[0], |w: usize| w.max(gs[0])));
		}
		let Some(wait) = wait else { continue };
		let (tfi, tli) = flat[wait];
		if !may(tfi, xfi) {
			continue;
		}
		let end = step_end(tfi, tli);
		let t0 = &texts[xfi][step_start(xfi, xli)];
		let title = if t0.is_empty() { format!("step Turn in {}", &m[1]) } else { t0.clone() };
		let mut line = xl.clone();
		let z = zone_at(xfi, xli);
		if re!(r"@\s*[\d.]+\s*,").is_match(&line) && !re!(r"\bmap \d+").is_match(&line) {
			if let Some(mm) = z.as_deref().and_then(|z| map_of.get(z)) {
				line = re!(r"(@\s*[\d.]+\s*,\s*[\d.]+)").replace(&line, format!("${{1}} map {mm}")).into_owned();
			}
		}
		del[xfi].insert(xli);
		let e = ins[tfi].entry(end).or_default();
		e.push(String::new());
		e.push(title);
		if let Some(zz) = z.as_ref() {
			if !zz.is_empty() && Some(zz) != zone_at(tfi, end).as_ref() {
				e.push(format!("  zone {zz}"));
			}
		}
		e.push(line);
	}
	rewrite(files, &texts, &del, &ins);
}

fn race_list(list: Option<&str>) -> Vec<&str> {
	list.map_or(Vec::new(), |l| l.split(',').map(trim).filter(|x| ALL_RACES.contains(&x.strip_prefix('!').unwrap_or(x))).collect())
}

fn class_only(list: Option<&str>) -> bool {
	list.is_some_and(|l| l.split(',').any(|x| matches!(trim(x), "Warrior" | "Paladin" | "Hunter" | "Rogue" | "Priest" | "Shaman" | "Mage" | "Warlock" | "Druid")))
}

fn others(l: &str, other_races: &[String]) -> String {
	let (code, rest) = split_comment(l);
	format!("{} only {}{}", trim_end(code), other_races.join(","), rest)
}

/// Lines set in place, then deleted (with steps left with no goal) as the JS passes write them.
fn set_then_rewrite(files: &mut [String], mut texts: Vec<Vec<String>>, del: Del, set: Vec<FxHashMap<usize, String>>) {
	for (fi, lines) in texts.iter_mut().enumerate() {
		for (&j, l) in &set[fi] {
			lines[j] = l.clone();
		}
		if !set[fi].is_empty() && del[fi].is_empty() {
			files[fi] = lines.join("\n");
		}
	}
	let ins: Ins = vec![FxHashMap::default(); texts.len()];
	rewrite(files, &texts, &del, &ins);
}

/// A hearth the route's races are not bound for goes for them (and a flight right after it in
/// its step); for the other races v1's line stays (`only` theirs).
pub fn fix_hearths(files: &mut [String], route_races: &[String], other_races: &[String], shared: &[bool]) {
	let texts = split_lines(files);
	let mut del: Del = vec![FxHashSet::default(); texts.len()];
	let mut set: Vec<FxHashMap<usize, String>> = vec![FxHashMap::default(); texts.len()];
	// all: every route character; some: at least one.
	let sees = |list: Option<&str>| -> (bool, bool) {
		let Some(l) = list.filter(|l| !l.is_empty()) else { return (true, true) };
		let rs = race_list(Some(l));
		let neg: Vec<&str> = rs.iter().filter_map(|r| r.strip_prefix('!')).collect();
		let pos: Vec<&str> = rs.iter().copied().filter(|r| !r.starts_with('!')).collect();
		let has = |v: &[&str], r: &String| v.contains(&r.as_str());
		let race_all = rs.is_empty() || if !pos.is_empty() { route_races.iter().all(|r| has(&pos, r)) } else { !route_races.iter().any(|r| has(&neg, r)) };
		let race_some = rs.is_empty() || if !pos.is_empty() { route_races.iter().any(|r| has(&pos, r)) } else { !route_races.iter().all(|r| has(&neg, r)) };
		(race_all && !class_only(Some(l)), race_some)
	};
	let mut bound: Option<String> = None;
	for (fi, lines) in texts.iter().enumerate() {
		let mut step_list: Option<String> = None;
		let mut drop_fly = false;
		for (li, l) in lines.iter().enumerate() {
			if is_step(l) {
				step_list = None;
				drop_fly = false;
				continue;
			}
			if let Some(so) = re!(r"^\s+only\s+(\S+)\s*$").captures(l) {
				step_list = Some(so[1].to_string());
				continue;
			}
			let st = sees(step_list.as_deref());
			let own = line_only(l);
			let ln = sees(own);
			let all = st.0 && ln.0;
			let some = st.1 && ln.1;
			if let Some(b) = re!(r#"^\s+sethome\s+(?:"([^"]+)"|(\S+))"#).captures(l) {
				if all {
					bound = Some(b.get(1).or(b.get(2)).unwrap().as_str().to_string());
				}
			}
			let h = re!(r#"^\s+hearth\s+"([^"]+)""#).captures(l);
			let bad = h.as_ref().is_some_and(|h| some && bound.as_deref() != Some("nearest") && bound.as_deref() != Some(&h[1]));
			let fly = drop_fly && head_ws(l) == Some("fly") && some;
			if h.is_some() && !bad {
				drop_fly = false;
			}
			if !bad && !fly {
				continue;
			}
			if bad {
				drop_fly = true;
			}
			// For everyone (no race list) in a guide the other races play: theirs.
			let for_others = race_list(own).is_empty() && race_list(step_list.as_deref()).is_empty() && shared[fi] && !other_races.is_empty();
			if for_others {
				set[fi].insert(li, others(l, other_races));
			} else {
				del[fi].insert(li);
			}
		}
	}
	set_then_rewrite(files, texts, del, set);
}

/// Travel lines written per audience in one step: one for the route's races beside the same
/// line for everyone goes; two for complementary races become one for everyone (#171).
pub fn dedupe_only(files: &mut [String], faction_races: &[String]) {
	let texts = split_lines(files);
	let mut del: Del = vec![FxHashSet::default(); texts.len()];
	let mut set: Vec<FxHashMap<usize, String>> = vec![FxHashMap::default(); texts.len()];
	struct X {
		j: usize,
		core: String,
		only: Option<Vec<String>>,
		indent: String,
		comment: String,
	}
	let split = |j: usize, l: &str| -> X {
		let (code, rest) = split_comment(l);
		let m = re!(r"^(.*?)\s+only\s+(\S+)\s*$").captures(code);
		let core = trim(m.as_ref().map_or(code, |m| m.get(1).unwrap().as_str())).to_string();
		let only = m.as_ref().map(|m| m[2].split(',').map(str::to_string).collect());
		let indent = re!(r"^\s*").find(l).map_or("", |m| m.as_str()).to_string();
		X { j, core, only, indent, comment: rest.to_string() }
	};
	for (fi, lines) in texts.iter().enumerate() {
		let mut start = 0;
		for i in 0..=lines.len() {
			if i < lines.len() && !is_step(&lines[i]) {
				continue;
			}
			let mut by: Vec<(String, Vec<X>)> = Vec::new();
			for (j, l) in lines.iter().enumerate().take(i).skip(start) {
				if !matches!(head_ws(l), Some("getfp" | "sethome" | "hearth")) {
					continue;
				}
				let x = split(j, l);
				match by.iter_mut().find(|(c, _)| *c == x.core) {
					Some((_, v)) => v.push(x),
					None => by.push((x.core.clone(), vec![x])),
				}
			}
			for (_, xs) in &by {
				if xs.len() < 2 {
					continue;
				}
				let all = xs.iter().position(|x| x.only.is_none());
				let races: FxHashSet<&str> = xs.iter().flat_map(|x| x.only.iter().flatten().map(String::as_str)).collect();
				if all.is_some() || (!faction_races.is_empty() && faction_races.iter().all(|r| races.contains(r.as_str()))) {
					let keep = all.unwrap_or(0);
					for (k, x) in xs.iter().enumerate() {
						if k != keep {
							del[fi].insert(x.j);
						}
					}
					if all.is_none() {
						let x = &xs[keep];
						set[fi].insert(x.j, format!("{}{}{}", x.indent, x.core, x.comment));
					}
				}
			}
			start = i;
		}
	}
	set_then_rewrite(files, texts, del, set);
}

const RIDING_LEVEL: u32 = 40;

/// A line of a class quest in a step written for everyone gets its classes (`only Priest`): a hand-in
/// moved into a step of its own after its item (Ogtinc's Ichor of Undeath, W-01) lost its step's `only`.
pub fn class_only_lines(files: &mut [String], data: &Data) {
	for f in files.iter_mut() {
		let mut lines: Vec<String> = f.split('\n').map(str::to_string).collect();
		let mut step_only = false;
		let mut changed = false;
		for l in lines.iter_mut() {
			if is_step(l) || starts_nonspace(l) {
				step_only = false;
				continue;
			}
			if head_ws(l) == Some("only") {
				step_only = true;
				continue;
			}
			if step_only || !is_goal(l) {
				continue;
			}
			let (code, _) = split_comment(l);
			if re!(r"\sonly\s+\S").is_match(code) {
				continue;
			}
			let Some(mask) = quest_of(l).and_then(|q| data.quests.get(&q)).and_then(|d| d.classes).filter(|m| *m > 0.0 && m.fract() == 0.0).map(|m| m as u32) else { continue };
			let names: Vec<String> = forge_core::CLASSES.iter().filter(|c| mask & c.bit != 0).map(|c| format!("{}{}", c.key[..1].to_uppercase(), &c.key[1..])).collect();
			if names.is_empty() || names.len() >= forge_core::CLASSES.len() {
				continue;
			}
			let tail = re!(r"\s--\s.*$").find(l).map_or(String::new(), |m| m.as_str().to_string());
			*l = format!("{} only {}{tail}", trim_end(code), names.join(","));
			changed = true;
		}
		if changed {
			*f = lines.join("\n");
		}
	}
}

/// A tip or note carried from a guide played at riding level (40) into one played below it
/// does not tell you to ride (#404). v1's own lines of the guide are left as they are.
pub fn no_riding(files: &mut [String], sources: &[&str]) {
	for (fi, f) in files.iter_mut().enumerate() {
		let Some(lv) = re!(r"(?m)^levels\s+(\d+)").captures(f) else { continue };
		if lv[1].parse::<u64>().map_or(true, |l| l >= RIDING_LEVEL as u64) {
			continue;
		}
		let own: FxHashSet<&str> = sources[fi].split('\n').collect();
		let lines: Vec<&str> = f.split('\n').collect();
		let mut changed = false;
		let out: Vec<String> = lines
			.iter()
			.map(|l| {
				if own.contains(l)
					|| !re!(r"^\s+(tip|note)\s|\s--\s").is_match(l)
					|| re!(r"(?i)\bride (?:it\b|(?:the |a |on the |up a |down the )?(?:boat|ferry|zeppelin|tram|Deeprun Tram|lift|elevator|airship|flight|hippogryph|gryphon|wind rider|bat|taxi))")
						.is_match(l)
					// (Learning to ride is about riding: not "learn to head" at "the walking trainer".)
					|| re!(r"(?i)\blearn(?:s|ing)? to ride\b|\briding (?:trainer|skill|lesson|instructor|master)\b|\bApprentice Riding\b|\bmount\b").is_match(l)
				{
					return l.to_string();
				}
				let n = re!(r"\b(Ride|ride|Rides|rides|Riding|riding|Rode|rode)\b").replace_all(l, |c: &regex::Captures| {
					match &c[1] {
						"Ride" => "Head",
						"ride" => "head",
						"Rides" => "Heads",
						"rides" => "heads",
						"Riding" => "Walking",
						"riding" => "walking",
						"Rode" => "Went",
						_ => "went",
					}
					.to_string()
				});
				if n != *l {
					changed = true;
				}
				n.into_owned()
			})
			.collect();
		if changed {
			*f = out.join("\n");
		}
	}
}

/// A tip that walks the player back along the road ("Walk back west along the road") right after a
/// step that flew them on: they arrive by air, the walk is v1's way, not theirs. The sentence goes;
/// a tip left with nothing goes.
pub fn no_walk_after_flight(files: &mut [String]) {
	for f in files.iter_mut() {
		let lines: Vec<&str> = f.split('\n').collect();
		let mut out: Vec<String> = Vec::with_capacity(lines.len());
		let mut flew = false;
		let mut prev_flew = false;
		let mut changed = false;
		for l in &lines {
			if is_step(l) {
				prev_flew = flew;
				flew = false;
				out.push(l.to_string());
				continue;
			}
			if head_ws(l) == Some("fly") {
				flew = true;
			} else if is_goal(l) && head_ws(l) != Some("zone") && head_ws(l) != Some("only") {
				flew = false;
			}
			if prev_flew {
				if let Some(m) = re!(r"^(\s+tip\s+)(.*)$").captures(l) {
					let body = m[2].to_string();
					let kept: Vec<&str> = crate::jsre::split_sentences(&body).into_iter().filter(|s| !re!(r"(?i)^\s*(?:(?:walk|head|ride|go|run)\s+)?back\b").is_match(s)).collect();
					if kept.len() != crate::jsre::split_sentences(&body).len() {
						changed = true;
						if !kept.is_empty() {
							out.push(format!("{}{}", &m[1], kept.join(" ")));
						}
						continue;
					}
				}
			}
			out.push(l.to_string());
		}
		if changed {
			*f = out.join("\n");
		}
	}
}

/// The route's bind or flight path written into a step whose v1 line already binds or learns it
/// there (`sethome "Goldshire"` and `sethome "Goldshire" npc 295`): one line, v1's with its NPC. A
/// flight path learned again later in the guide, after a step for everyone learned it (Darkshire's,
/// once in Duskwood's first step, again with a step moved in from a later guide), goes; so does the
/// step it leaves with no goal.
pub fn one_service_line(files: &mut [String]) {
	let svc = |l: &str| -> Option<(String, String, bool)> {
		let code = split_comment(l).0;
		let m = re!(r#"^\s+(sethome|getfp)\s+"([^"]+)"(.*)$"#).captures(code)?;
		let rest = m[3].to_string();
		let npc = re!(r"\bnpc\s+\d").is_match(&rest);
		let audience = re!(r"\bnpc\s+\d+").replace(&rest, "").split_whitespace().collect::<Vec<_>>().join(" ");
		Some((format!("{} {} {}", &m[1], &m[2], audience), m[1].to_string(), npc))
	};
	// (Across the chain's guides, in order: a flight path learned in one guide is not learned again at
	// the next one's start, Feathermoon's written at the end of Badlands and again in Feralas.)
	let mut learned: FxHashSet<String> = FxHashSet::default();
	for f in files.iter_mut() {
		let lines: Vec<&str> = f.split('\n').collect();
		let mut drop: FxHashSet<usize> = FxHashSet::default();
		let mut start = 0;
		for i in 0..=lines.len() {
			if i == lines.len() || is_step(lines[i]) {
				// (In one step: a plain line goes when one with its NPC says the same.)
				let block: Vec<usize> = (start..i).collect();
				for &a in &block {
					let Some((ka, _, false)) = svc(lines[a]) else { continue };
					if block.iter().any(|&b| b != a && svc(lines[b]).is_some_and(|(kb, _, npc)| npc && kb == ka)) {
						drop.insert(a);
					}
				}
				start = i;
			}
		}
		// (A getfp after one for everyone, a step without `only` or `when`: (place) learned.)
		let mut start = 0;
		for i in 0..=lines.len() {
			if i < lines.len() && !is_step(lines[i]) {
				continue;
			}
			if start < i && is_step(lines[start]) {
				let block: Vec<usize> = (start + 1..i).collect();
				let gated = block.iter().any(|&b| matches!(head_ws(lines[b]), Some("only" | "when")));
				let mut gone: Vec<usize> = Vec::new();
				let mut seen: Vec<String> = Vec::new();
				for &b in &block {
					let Some((_, kind, _)) = svc(lines[b]) else { continue };
					if kind != "getfp" || drop.contains(&b) {
						continue;
					}
					let place = re!(r#""([^"]+)""#).captures(lines[b]).map(|m| m[1].to_string()).unwrap_or_default();
					if learned.contains(&place) {
						gone.push(b);
					} else if !gated && !re!(r"\sonly\s").is_match(split_comment(lines[b]).0) {
						seen.push(place);
					}
				}
				learned.extend(seen);
				drop.extend(gone.iter().copied());
				let goals_left = block.iter().any(|&b| !drop.contains(&b) && is_goal(split_comment(lines[b]).0));
				if !gone.is_empty() && !goals_left {
					// (The step's own lines; the comments and blank lines after it stay.)
					let end = block.iter().rposition(|&b| !starts_nonspace(lines[b]) && !lines[b].trim().is_empty()).map_or(0, |p| p + 1);
					drop.insert(start);
					drop.extend(block[..end].iter().copied());
				}
			}
			start = i;
		}
		if !drop.is_empty() {
			*f = lines.iter().enumerate().filter(|(i, _)| !drop.contains(i)).map(|(_, l)| *l).collect::<Vec<_>>().join("\n");
		}
	}
}

/// A `train class` in the step right after one that trains the same classes or more (the route's
/// Ironforge trainer, then v1's Kharanos step at the same level, a walk back out of the city and in
/// again; three Orgrimmar steps in a row, each training): the second goes. A step it leaves with only
/// some classes' lines is theirs (`only Hunter,Priest,Shaman`); one it leaves with nothing goes.
pub fn repeat_training(files: &mut [String]) {
	// (The classes a training line is for: None for everyone; not a training line, or for some
	// races: no set.)
	let trained = |l: &str| -> Option<Option<Vec<String>>> {
		let m = re!(r"^\s+train\s+class(?:\s+only\s+(\S+))?\s*$").captures(split_comment(l).0)?;
		match m.get(1) {
			None => Some(None),
			Some(list) => {
				let cl: Vec<String> = list.as_str().split(',').map(|c| trim(c).to_string()).collect();
				cl.iter().all(|c| CLASSES.contains(&c.as_str())).then_some(Some(cl))
			}
		}
	};
	let covered = |prev: &Option<Vec<String>>, this: &Option<Vec<String>>| match (prev, this) {
		(None, _) => true,
		(Some(p), Some(t)) => t.iter().all(|c| p.contains(c)),
		(Some(_), None) => false,
	};
	for f in files.iter_mut() {
		let lines: Vec<&str> = f.split('\n').collect();
		let mut out: Vec<String> = Vec::with_capacity(lines.len());
		let mut changed = false;
		// (The classes the last step for everyone trained.)
		let mut prev: Option<Option<Vec<String>>> = None;
		let mut i = 0;
		while i < lines.len() {
			if !is_step(lines[i]) {
				out.push(lines[i].to_string());
				i += 1;
				continue;
			}
			let mut j = i + 1;
			while j < lines.len() && !lines[j].trim().is_empty() && !is_step(lines[j]) && !starts_nonspace(lines[j]) {
				j += 1;
			}
			let body = &lines[i + 1..j];
			let gated = body.iter().any(|l| head_ws(l) == Some("only"));
			let again = |l: &str| !gated && trained(l).zip(prev.as_ref()).is_some_and(|(t, p)| covered(p, &t));
			if body.iter().any(|l| again(l)) {
				changed = true;
				let rest: Vec<&str> = body.iter().copied().filter(|l| !again(l)).collect();
				let goals: Vec<&str> = rest.iter().copied().filter(|l| is_goal(l)).collect();
				if !goals.is_empty() {
					out.push(lines[i].to_string());
					// (Every line some classes': the step is theirs.)
					let classes: Option<Vec<&str>> = goals.iter().try_fold(Vec::new(), |mut acc: Vec<&str>, l| {
						let cl: Vec<&str> = line_only(l)?.split(',').map(trim).filter(|c| CLASSES.contains(c)).collect();
						(!cl.is_empty()).then(|| {
							acc.extend(cl.into_iter().filter(|c| !acc.contains(c)).collect::<Vec<_>>());
							acc
						})
					});
					if let Some(cl) = classes {
						out.push(format!("  only {}", cl.join(",")));
					}
					out.extend(rest.iter().map(|l| l.to_string()));
				}
				i = j;
				continue;
			}
			if !gated {
				prev = body.iter().find_map(|l| trained(l));
			}
			out.extend(lines[i..j].iter().map(|l| l.to_string()));
			i = j;
		}
		if changed {
			*f = out.join("\n");
		}
	}
}

/// A step for everyone whose every goal is some classes' (`turnin 1534 only Shaman`, the Shamans'
/// Brine hand-in in the Barrens between two Ashenvale steps) is theirs: `only <those classes>`, so
/// its zone is theirs alone, and the next step for everyone names the zone the others are in.
pub fn class_only_steps(files: &mut [String]) {
	let zone_of = |l: &str| re!(r"^\s*zone\s+(.+?)\s*$").captures(split_comment(l).0).map(|m| m[1].to_string());
	for f in files.iter_mut() {
		let lines: Vec<String> = f.split('\n').map(str::to_string).collect();
		let mut ins: Vec<(usize, String)> = Vec::new();
		// (The zone everyone reads coordinates in, and the one to name again after a step now theirs.)
		let mut ctx: Option<String> = None;
		let mut restate: Option<String> = None;
		let mut i = 0;
		while i < lines.len() {
			if !is_step(&lines[i]) {
				if starts_nonspace(&lines[i]) {
					if let Some(z) = zone_of(&lines[i]) {
						ctx = Some(z);
					}
				}
				i += 1;
				continue;
			}
			let mut j = i + 1;
			while j < lines.len() && !lines[j].trim().is_empty() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
				j += 1;
			}
			let body = &lines[i + 1..j];
			let gated = body.iter().any(|l| head_ws(l) == Some("only"));
			let goals: Vec<&String> = body.iter().filter(|l| is_goal(l)).collect();
			let own_zone = body.iter().find_map(|l| zone_of(l));
			let classes: Option<Vec<&str>> = (!gated && !goals.is_empty())
				.then(|| {
					goals.iter().try_fold(Vec::new(), |mut acc: Vec<&str>, l| {
						let list: Vec<&str> = line_only(l)?.split(',').map(trim).collect();
						list.iter().all(|c| CLASSES.contains(c)).then(|| {
							acc.extend(list.into_iter().filter(|c| !acc.contains(c)).collect::<Vec<_>>());
							acc
						})
					})
				})
				.flatten();
			if let Some(cl) = classes {
				ins.push((i + 1, format!("  only {}", cl.join(","))));
				if own_zone.is_some() && own_zone != ctx {
					restate = restate.or(ctx.clone());
				}
			} else if !gated {
				match own_zone {
					Some(z) => ctx = Some(z),
					None => {
						if let Some(z) = &restate {
							ins.push((i + 1, format!("  zone {z}")));
						}
					}
				}
				restate = None;
			}
			i = j;
		}
		if ins.is_empty() {
			continue;
		}
		let mut lines = lines;
		for (at, l) in ins.into_iter().rev() {
			lines.insert(at, l);
		}
		*f = lines.join("\n");
	}
}

/// A quest's lines written before the hand-in of a prerequisite (the data's `pre`, all of them, and
/// `preAny`, one of them) go after that hand-in, in steps of their own after its step: each keeps its
/// v1 step's title, `only` and zone, so it reads on its own map, and the step after them names the zone
/// it read before. Its follow-ups then follow it the same way (Call of Fire 1526, then 1527): the
/// chain moves as a unit, in the seed's order. The Undead Warlocks' Binding (1471) after Creature of
/// the Void (1473) is handed in. Not the route's own quests (`route_q`): their order is the route's.
/// Returns the quests moved: (file, quest).
/// `may(dst, src)`: a quest's lines move from guide `src` into a later guide `dst` (same players).
pub fn prereq_order(files: &mut [String], data: &Data, route_q: &FxHashSet<u32>, may: &dyn Fn(usize, usize) -> bool) -> Vec<(usize, u32)> {
	let acc_re = re!(r"^\s+accept\s+(\d+)\b");
	let tin_re = re!(r"^\s+turnin\s+(\d+)\b");
	let zone_re = re!(r"^\s*zone\s+(.+?)\s*$");
	let pres = |q: u32| -> (Vec<u32>, Vec<u32>) {
		let Some(r) = data.quests.get(&q) else { return (Vec::new(), Vec::new()) };
		let ids = |v: &Option<Vec<serde_json::Value>>| -> Vec<i64> { v.iter().flatten().filter_map(|x| x.as_i64()).collect() };
		let pre = ids(&r.pre);
		let all: Vec<u32> = pre.iter().filter(|&&p| p > 0).map(|&p| p as u32).collect();
		let mut any: Vec<u32> = pre.iter().filter(|&&p| p < 0).map(|p| (-p) as u32).collect();
		any.extend(ids(&r.pre_any).into_iter().filter(|&p| p > 0).map(|p| p as u32));
		(all, any)
	};
	let refs = |l: &str, q: u32| -> bool {
		let code = split_comment(l).0;
		quest_of(l) == Some(q) || re!(r"^\s+complete\s+(\d+)\b").captures(code).is_some_and(|m| m[1].parse::<u32>().ok() == Some(q))
	};
	let mut handed_before: FxHashSet<u32> = FxHashSet::default();
	let mut moved = Vec::new();
	// (A prerequisite handed in in a later guide: the quest's lines go there, after that hand-in's step,
	// F3: News of Dogran taken in one Barrens guide, Gan'rul's hand-in it needs in the next.) -> per
	// guide, (prerequisite, steps to insert after its hand-in's step).
	let mut pending: FxHashMap<usize, Vec<(u32, u32, Vec<String>)>> = FxHashMap::default();
	let turnins_of = |f: &str| -> FxHashSet<u32> { f.split('\n').filter_map(|l| tin_re.captures(split_comment(l).0).and_then(|m| m[1].parse::<u32>().ok())).collect() };
	let mut later_turnins: Vec<FxHashSet<u32>> = files.iter().map(|f| turnins_of(f)).collect();
	for fi in 0..files.len() {
		let mut lines: Vec<String> = files[fi].split('\n').map(str::to_string).collect();
		for (p, q, block) in pending.remove(&fi).unwrap_or_default() {
			let Some(t) = lines.iter().position(|x| tin_re.captures(split_comment(x).0).is_some_and(|m| m[1].parse::<u32>().ok() == Some(p))) else { continue };
			let mut e = t + 1;
			while e < lines.len() && !is_step(&lines[e]) && !starts_nonspace(&lines[e]) && !lines[e].trim().is_empty() {
				e += 1;
			}
			// (The quest's own lines here before that hand-in go after its accept too: Speak with
			// Thun'grim's hand-in.)
			let early: Vec<usize> = (0..t).filter(|&x| is_goal(&lines[x]) && refs(&lines[x], q)).collect();
			let mut ins = vec![String::new()];
			ins.extend(block);
			// (Each with its step's title, `only`, `when` and zone.)
			let mut last_step: Option<usize> = None;
			for &x in &early {
				let s = (0..=x).rev().find(|&y| is_step(&lines[y])).unwrap_or(0);
				if last_step != Some(s) {
					ins.push(String::new());
					ins.push(lines[s].clone());
					let se = (s + 1..lines.len()).find(|&y| is_step(&lines[y]) || starts_nonspace(&lines[y])).unwrap_or(lines.len());
					ins.extend(lines[s + 1..se].iter().filter(|l| matches!(head_ws(l), Some("only" | "when" | "zone"))).cloned());
					last_step = Some(s);
				}
				ins.push(lines[x].clone());
			}
			lines.splice(e..e, ins);
			if !early.is_empty() {
				let gone: FxHashSet<usize> = early.into_iter().collect();
				lines = no_empty_steps(lines.into_iter().enumerate().filter(|(x, _)| !gone.contains(x)).map(|(_, l)| l).collect());
			}
		}
		for _ in 0..40 {
			// The steps: (start, end, zone in effect).
			let mut steps: Vec<(usize, usize, Option<String>)> = Vec::new();
			let mut ctx: Option<String> = None;
			let mut i = 0;
			while i < lines.len() {
				if !is_step(&lines[i]) {
					if let Some(m) = zone_re.captures(split_comment(&lines[i]).0) {
						ctx = Some(m[1].to_string());
					}
					i += 1;
					continue;
				}
				let mut j = i + 1;
				while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
					j += 1;
				}
				if let Some(z) = lines[i + 1..j].iter().find_map(|l| zone_re.captures(split_comment(l).0).map(|m| m[1].to_string())) {
					ctx = Some(z);
				}
				steps.push((i, j, ctx.clone()));
				i = j;
			}
			let step_of = |k: usize| steps.iter().position(|s| s.0 < k && k < s.1);
			// The first accept ahead of a prerequisite's hand-in that comes later in the guide.
			let mut found: Option<(usize, u32, usize)> = None;
			for (k, l) in lines.iter().enumerate() {
				let Some(q) = acc_re.captures(split_comment(l).0).and_then(|m| m[1].parse::<u32>().ok()).filter(|q| !route_q.contains(q)) else { continue };
				let (all, any) = pres(q);
				let done_by = |p: u32, upto: usize| handed_before.contains(&p) || lines[..upto].iter().any(|x| tin_re.captures(split_comment(x).0).is_some_and(|m| m[1].parse::<u32>().ok() == Some(p)));
				let later = |p: u32| lines[k..].iter().position(|x| tin_re.captures(split_comment(x).0).is_some_and(|m| m[1].parse::<u32>().ok() == Some(p))).map(|d| k + d);
				let mut need: Option<usize> = None;
				for &p in &all {
					if !done_by(p, k) {
						if let Some(t) = later(p) {
							need = Some(need.map_or(t, |n| n.max(t)));
						}
					}
				}
				if !any.is_empty() && !any.iter().any(|&p| done_by(p, k)) {
					if let Some(t) = any.iter().filter_map(|&p| later(p)).min() {
						need = Some(need.map_or(t, |n| n.max(t)));
					}
				}
				if let Some(t) = need {
					found = Some((k, q, t));
					break;
				}
			}
			let Some((k, q, t)) = found else { break };
			let (Some(ts), Some(ks)) = (step_of(t), step_of(k)) else { break };
			// The lines to move: the quest's before the hand-in, and in the accept's step the lines with
			// no quest of their own between them (the Runes of Summoning's `use`).
			let mut take: Vec<usize> = (0..t).filter(|&x| is_goal(&lines[x]) && refs(&lines[x], q)).collect();
			let (s0, s1, _) = steps[ks];
			if let Some(&last) = take.iter().filter(|&&x| x < s1).max() {
				take.extend((k + 1..last).filter(|&x| x > s0 && is_goal(&lines[x]) && quest_of(&lines[x]).is_none() && acc_re.captures(&lines[x]).is_none() && tin_re.captures(&lines[x]).is_none()));
			}
			take.sort();
			take.dedup();
			// New steps after the hand-in's step, one per source step, in order.
			let mut ins: Vec<String> = Vec::new();
			let mut src: Vec<usize> = take.iter().filter_map(|&x| step_of(x)).collect();
			src.dedup();
			for si in src {
				let (a, b, z) = &steps[si];
				ins.push(String::new());
				ins.push(lines[*a].clone());
				if let Some(o) = lines[a + 1..*b].iter().find(|l| head_ws(l) == Some("only")) {
					ins.push(o.clone());
				}
				if let Some(z) = z {
					ins.push(format!("  zone {z}"));
				}
				ins.extend(take.iter().filter(|&&x| x > *a && x < *b).map(|&x| lines[x].clone()));
			}
			// (The step after them reads where the hand-in's step did.)
			let (_, te, tz) = steps[ts].clone();
			let next_named = steps.get(ts + 1).is_some_and(|n| lines[n.0 + 1..n.1].iter().any(|l| head_ws(l) == Some("zone")));
			let restate = steps.get(ts + 1).filter(|_| !next_named).map(|n| n.0);
			let mut out: Vec<String> = Vec::with_capacity(lines.len() + ins.len() + 2);
			let take_set: FxHashSet<usize> = take.iter().copied().collect();
			// (Source steps left with no goal and no label go.)
			let emptied: FxHashSet<usize> = steps
				.iter()
				.enumerate()
				.filter(|(_, s)| (s.0 + 1..s.1).any(|x| take_set.contains(&x)) && !(s.0 + 1..s.1).any(|x| !take_set.contains(&x) && (is_goal(&lines[x]) || head_ws(&lines[x]) == Some("label"))))
				.map(|(i, _)| i)
				.collect();
			for (x, l) in lines.iter().enumerate() {
				if take_set.contains(&x) {
					continue;
				}
				if let Some(si) = steps.iter().position(|s| s.0 <= x && x < s.1) {
					if emptied.contains(&si) && si != ts {
						continue;
					}
				}
				if x == te {
					out.extend(ins.iter().cloned());
					if restate.is_none() || te >= lines.len() {
						out.push(String::new());
					}
				}
				out.push(l.clone());
				if Some(x) == restate {
					if let Some(z) = &tz {
						out.push(format!("  zone {z}"));
					}
				}
			}
			if te >= lines.len() {
				out.extend(ins);
			}
			lines = out;
			moved.push((fi, q));
		}
		// (Accepts still ahead of a prerequisite handed in in a later guide only.)
		let mut handed_here: FxHashSet<u32> = handed_before.clone();
		let mut take: FxHashSet<usize> = FxHashSet::default();
		for k in 0..lines.len() {
			if take.contains(&k) {
				continue;
			}
			if let Some(q) = tin_re.captures(split_comment(&lines[k]).0).and_then(|m| m[1].parse::<u32>().ok()) {
				handed_here.insert(q);
				continue;
			}
			let Some(q) = acc_re.captures(split_comment(&lines[k]).0).and_then(|m| m[1].parse::<u32>().ok()).filter(|q| !route_q.contains(q)) else { continue };
			let (all, any) = pres(q);
			let missing: Vec<u32> = all.iter().copied().filter(|p| !handed_here.contains(p)).collect();
			let any_missing = !any.is_empty() && !any.iter().any(|p| handed_here.contains(p));
			let Some((gj, p)) = missing.iter().chain(any.iter().filter(|_| any_missing)).find_map(|&p| (fi + 1..files.len()).find(|&g| later_turnins[g].contains(&p)).filter(|&g| may(g, fi)).map(|g| (g, p))) else { continue };
			// (The quest's lines in this guide, each with its step's title, `only` and zone.)
			let mut block: Vec<String> = Vec::new();
			let mut last_step: Option<usize> = None;
			for x in k..lines.len() {
				if !(is_goal(&lines[x]) && refs(&lines[x], q)) {
					continue;
				}
				let s = (0..=x).rev().find(|&y| is_step(&lines[y])).unwrap_or(0);
				if last_step != Some(s) {
					if last_step.is_some() {
						block.push(String::new());
					}
					block.push(lines[s].clone());
					let e = (s + 1..lines.len()).find(|&y| is_step(&lines[y]) || starts_nonspace(&lines[y])).unwrap_or(lines.len());
					block.extend(lines[s + 1..e].iter().filter(|l| matches!(head_ws(l), Some("only" | "zone"))).cloned());
					last_step = Some(s);
				}
				block.push(lines[x].clone());
				take.insert(x);
			}
			// (Its own hand-in, moved with it, opens the quests after it there too: Ken'zigla's Draught
			// after News of Dogran.)
			later_turnins[gj].extend(block.iter().filter_map(|l| tin_re.captures(split_comment(l).0).and_then(|m| m[1].parse::<u32>().ok())));
			moved.push((fi, q));
			pending.entry(gj).or_default().push((p, q, block));
		}
		if !take.is_empty() {
			lines = no_empty_steps(lines.into_iter().enumerate().filter(|(x, _)| !take.contains(x)).map(|(_, l)| l).collect());
		}
		for l in &lines {
			if let Some(q) = tin_re.captures(split_comment(l).0).and_then(|m| m[1].parse::<u32>().ok()) {
				handed_before.insert(q);
			}
		}
		files[fi] = lines.join("\n");
	}
	moved
}

/// In a guide some races play (`race Skyborne`), an `only` list of classes names only the classes
/// those races play (`playable(race)`: class labels); a list left with every one of them goes (a
/// step's own `only` line with it); one left with none stays as written (W3: `only Warrior,Paladin,…`
/// in the Skyborne isle guide). -> the guide, when a list changed.
pub fn playable_only(text: &str, playable: &dyn Fn(&str) -> Vec<String>) -> Option<String> {
	let header: Vec<&str> = text.split('\n').take_while(|l| !is_step(l)).collect();
	let races: Vec<&str> = header.iter().find_map(|l| l.strip_prefix("race "))?.split(',').map(trim).collect();
	let mut can: Vec<String> = Vec::new();
	for r in &races {
		for c in playable(r) {
			if !can.contains(&c) {
				can.push(c);
			}
		}
	}
	if can.is_empty() {
		return None;
	}
	let only_re = crate::re!(r"^(.*?\sonly\s+)([A-Za-z,]+)(.*)$");
	let mut changed = false;
	let out: Vec<String> = text
		.split('\n')
		.filter_map(|l| {
			let (code, comment) = split_comment(l);
			let Some(m) = only_re.captures(code) else { return Some(l.to_string()) };
			let list: Vec<&str> = m[2].split(',').map(trim).collect();
			if !list.iter().all(|c| CLASSES.contains(c)) {
				return Some(l.to_string());
			}
			let kept: Vec<&str> = list.iter().copied().filter(|c| can.iter().any(|x| x == c)).collect();
			if kept.len() == list.len() || kept.is_empty() {
				return Some(l.to_string());
			}
			changed = true;
			if kept.len() == can.len() {
				// (Every class these races play: the line is everyone's; a step's own `only` line goes.)
				let head = m[1].trim_end().strip_suffix("only").map(|h| h.trim_end().to_string()).unwrap_or_default();
				return (!head.trim().is_empty()).then(|| format!("{head}{}{comment}", &m[3]));
			}
			Some(format!("{}{}{}{comment}", &m[1], kept.join(","), &m[3]))
		})
		.collect();
	changed.then(|| out.join("\n"))
}

/// A class's step whose every line is some races' only (`only Priest`, `turnin 5654 only Troll,Priest`:
/// Ur'kyo's Hex of Weakness for Troll Priests) is those characters' step, and so is its class's way
/// there and back around it (the travel-only steps right before and after it with the same `only`):
/// an Undead Priest no longer takes the zeppelin to Orgrimmar for nothing.
pub fn class_trip_audience(out: Vec<String>) -> Vec<String> {
	let only_re = crate::re!(r"^\s+only\s+([!A-Za-z,]+)\s*$");
	let mut steps: Vec<(usize, usize)> = Vec::new();
	let mut i = 0;
	while i < out.len() {
		if !is_step(&out[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < out.len() && !is_step(&out[j]) && !starts_nonspace(&out[j]) {
			j += 1;
		}
		steps.push((i, j));
		i = j;
	}
	let step_only = |s: (usize, usize)| -> Option<(usize, String)> { (s.0 + 1..s.1).find_map(|k| only_re.captures(split_comment(&out[k]).0).map(|m| (k, m[1].to_string()))) };
	let classes = |l: &str| l.split(',').all(|c| CLASSES.contains(&trim(c)));
	let goals = |s: (usize, usize)| -> Vec<usize> { (s.0 + 1..s.1).filter(|&k| is_goal(&out[k])).collect() };
	let travel = |s: (usize, usize)| -> bool {
		let g = goals(s);
		!g.is_empty() && g.iter().all(|&k| matches!(head_ws(&out[k]), Some("goto" | "fly" | "hearth")))
	};
	let mut set: Vec<(usize, String)> = Vec::new();
	for (n, &s) in steps.iter().enumerate() {
		let Some((_, list)) = step_only(s).filter(|(_, l)| classes(l)) else { continue };
		let g: Vec<usize> = goals(s).into_iter().filter(|&k| !matches!(head_ws(&out[k]), Some("goto" | "fly" | "hearth" | "note" | "level"))).collect();
		if g.is_empty() {
			continue;
		}
		let lists: Vec<Option<String>> = g.iter().map(|&k| line_only(&out[k]).map(str::to_string)).collect();
		let Some(Some(first)) = lists.first().cloned() else { continue };
		if !lists.iter().all(|l| l.as_deref() == Some(first.as_str())) || classes(&first) || first.contains('!') {
			continue;
		}
		// (Its races and the step's classes.)
		let races: Vec<&str> = first.split(',').map(trim).filter(|x| ALL_RACES.contains(x)).collect();
		let mut cls: Vec<&str> = first.split(',').map(trim).filter(|x| CLASSES.contains(x)).collect();
		if cls.is_empty() {
			cls = list.split(',').map(trim).collect();
		}
		if races.is_empty() {
			continue;
		}
		let new = races.iter().chain(cls.iter()).copied().collect::<Vec<_>>().join(",");
		let mut run = vec![n];
		for m in (0..n).rev() {
			if travel(steps[m]) && step_only(steps[m]).is_some_and(|(_, l)| l == list) {
				run.push(m);
			} else {
				break;
			}
		}
		for m in n + 1..steps.len() {
			if travel(steps[m]) && step_only(steps[m]).is_some_and(|(_, l)| l == list) {
				run.push(m);
			} else {
				break;
			}
		}
		for m in run {
			if let Some((k, _)) = step_only(steps[m]) {
				set.push((k, new.clone()));
			}
		}
	}
	if set.is_empty() {
		return out;
	}
	let mut out = out;
	for (k, list) in set {
		out[k] = format!("  only {list}");
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;

	fn lines(s: &[&str]) -> Vec<String> {
		s.iter().map(|x| x.to_string()).collect()
	}

	#[test]
	fn a_class_accept_waits_for_its_prerequisite_handed_in_in_a_later_guide() {
		// RevH1-3 F3: News of Dogran (1510) taken in the Barrens before Gan'rul's hand-in of its
		// prerequisite (1509) in the next guide.
		let q: crate::input::Quest = serde_json::from_value(serde_json::json!({ "pre": [1509] })).unwrap();
		let mut data = Data::default();
		data.quests.insert(1510, q);
		data.quests.insert(1511, serde_json::from_value(serde_json::json!({ "pre": [1510] })).unwrap());
		let mut files = vec![
			"step Camp\n  accept 1\n\nstep Logmar\n  only Warlock\n  accept 1510\n  turnin 1510\n  accept 1511".to_string(),
			"step Far\n  when onquest 1511\n  turnin 1511\n\nstep Orgrimmar\n  turnin 1509 only Warlock\n  accept 2\n\nstep On".to_string(),
		];
		prereq_order(&mut files, &data, &FxHashSet::default(), &|_, _| true);
		assert!(!files[0].contains("1510") && files[0].contains("accept 1"), "{files:#?}");
		let (t, a) = (files[1].find("turnin 1509").unwrap(), files[1].find("accept 1510").unwrap());
		assert!(t < a && files[1].contains("step Logmar\n  only Warlock\n  accept 1510\n  turnin 1510"), "{files:#?}");
		// (The quest after it, opened by its hand-in, goes with it.)
		assert!(!files[0].contains("1511") && files[1].find("accept 1511").unwrap() > files[1].find("turnin 1510").unwrap(), "{files:#?}");
		// (Its hand-in already in that guide before the prerequisite's goes after its accept, with its step's `when`.)
		assert!(files[1].find("step Far\n  when onquest 1511\n  turnin 1511").unwrap() > files[1].find("accept 1511").unwrap(), "{files:#?}");
	}

	#[test]
	fn an_only_list_names_only_the_classes_the_guides_races_play() {
		// RevSkyA3 W3: `only Warrior,Paladin,Hunter,Rogue,Priest,Shaman,Warlock` in the Skyborne isle guide.
		let playable = |r: &str| if r == "Skyborne" { ["Warrior", "Hunter", "Rogue", "Mage", "Druid"].map(String::from).to_vec() } else { Vec::new() };
		let t = "guide g\nrace Skyborne\n\nstep A\n  only Warrior,Paladin,Hunter,Rogue,Priest,Shaman,Warlock\n  train class\n  accept 1 only Mage,Priest\n  accept 2 only Priest";
		let out = playable_only(t, &playable).unwrap();
		assert!(out.contains("\n  only Warrior,Hunter,Rogue\n") && out.contains("accept 1 only Mage\n") && out.contains("accept 2 only Priest"), "{out}");
	}

	#[test]
	fn a_class_trip_for_some_races_only_is_theirs() {
		// c14 Undead: every Priest took the zeppelin to Orgrimmar for Ur'kyo's Hex of Weakness, a Troll
		// Priest's hand-in (silverpine:76 bounce).
		let g = lines(&[
			"step Sepulcher", "  accept 1", "",
			"step Tirisfal Glades", "  only Priest", "  goto 60.7,58.9 \"Tirisfal Glades\"", "",
			"step Zeppelin to Orgrimmar", "  only Priest", "  goto 60.7,58.9 \"Zeppelin to Orgrimmar\"", "",
			"step Orgrimmar class quests", "  only Priest", "  zone Orgrimmar", "  turnin 5654 only Troll,Priest", "",
			"step Sepulcher", "  accept 2",
		]);
		let out = class_trip_audience(g);
		assert_eq!(out.iter().filter(|l| *l == "  only Troll,Priest").count(), 3, "{out:#?}");
		assert!(!out.iter().any(|l| l == "  only Priest"), "{out:#?}");
	}

	#[test]
	fn a_class_trip_with_nothing_to_do_goes() {
		// FlowDiag 1: the Warlocks fly Ratchet -> Orgrimmar -> Ratchet with their class step held for
		// later; the Priests' trip has Ur'kyo between and stays.
		let g = lines(&[
			"step Ratchet", "  turnin 1", "",
			"step Fly to Orgrimmar", "  only Warlock", "  goto 63.1,37.1 \"Ratchet flight master\"", "  fly \"Orgrimmar\"", "",
			"step Fly to Orgrimmar", "  only Priest", "  goto 63.1,37.1 \"Ratchet flight master\"", "  fly \"Orgrimmar\"", "",
			"step Ur'kyo", "  only Priest", "  accept 5680", "",
			"step Back to Ratchet", "  only Warlock", "  goto 45.3,63.7 \"Orgrimmar flight master\"", "  fly \"Ratchet\"", "",
			"step Back to Ratchet", "  only Priest", "  goto 45.3,63.7 \"Orgrimmar flight master\"", "  fly \"Ratchet\"", "",
			"step Ratchet", "  accept 2",
		]);
		let out = no_class_round_trips(g);
		assert!(!out.iter().any(|l| l == "  only Warlock"), "{out:#?}");
		assert_eq!(out.iter().filter(|l| *l == "  only Priest").count(), 3, "{out:#?}");
	}

	#[test]
	fn a_class_trip_with_everyones_step_between_stays() {
		let g = lines(&["step Out", "  only Warlock", "  fly \"Orgrimmar\"", "", "step Everyone", "  accept 3", "", "step Back", "  only Warlock", "  fly \"Ratchet\""]);
		assert_eq!(no_class_round_trips(g.clone()), g);
	}

	#[test]
	fn a_flight_path_learned_at_one_guides_end_is_not_learned_again_at_the_next_ones_start() {
		// FlowDiag 6: Feathermoon's `getfp` at the end of Badlands and again opening Feralas.
		let mut files = vec!["step Feathermoon\n  getfp \"Feathermoon\"\n  accept 1".to_string(), "step Feathermoon\n  getfp \"Feathermoon\"\n  accept 2".to_string()];
		one_service_line(&mut files);
		assert!(!files[1].contains("getfp") && files[1].contains("accept 2"), "{files:#?}");
	}

	#[test]
	fn a_bare_collect_of_a_route_quests_item_is_tagged_after_its_accept() {
		// FlowDiag 10: v1's `collect 5075 x1` for Blood Shards (5052).
		let q: crate::input::Quest = serde_json::from_value(serde_json::json!({ "objectives": [{ "type": "item", "id": 5075 }] })).unwrap();
		let mut data = Data::default();
		data.quests.insert(5052, q);
		let route: FxHashSet<u32> = [5052].into_iter().collect();
		let mut files = vec!["step A\n  collect 5075 x1\n\nstep Camp\n  accept 5052\n\nstep Camps\n  collect 5075 x1 -- shards".to_string()];
		tag_quest_collects(&mut files, &data, &route);
		assert_eq!(files[0], "step A\n  collect 5075 x1\n\nstep Camp\n  accept 5052\n\nstep Camps\n  collect 5075 x1 quest 5052 -- shards");
	}
}
