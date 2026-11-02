//! The route order's fixes before writing (timed items, item-started accepts) and the passes
//! over the written guides (accepts before their work, item turn-ins after their items,
//! hearths the route is not bound for, travel lines per audience, riding words).

use crate::apply::{line_only, qkey, quest_of, ALL_RACES, CLASSES};
use crate::guide::{is_goal, Key, Step};
use crate::input::{Data, ItemT, Order, OrderT, World};
use crate::jsre::{head_ws, is_step, split_comment, starts_nonspace, trim, trim_end};
use crate::re;
use forge_core::jsnum::js_hypot;
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

/// v1's objective line of a quest the chain has handed in already, for everyone (a turn-in in a step
/// with no `only` or `when`, not `optional`): it goes, and a step it leaves with no goal with it (Rev15
/// R3: v1's Red Leather Bandana collect in Westfall's Moonbrook step after the route handed in 153 at
/// Sentinel Hill). An accept of the quest again opens it again.
pub fn work_after_turnin(files: &mut [String]) {
	let turnin_re = re!(r"^\s+turnin\s+(\d+)\b");
	let accept_re = re!(r"^\s+accept\s+(\d+)\b");
	let work_re = re!(r"^\s+(collect|kill|interact)\s.*\bquest\s+(\d+)\b");
	let mut done: FxHashSet<u32> = FxHashSet::default();
	for f in files.iter_mut() {
		let lines: Vec<String> = f.split('\n').map(str::to_string).collect();
		let mut out: Vec<String> = Vec::with_capacity(lines.len());
		let mut gated = false;
		let mut changed = false;
		for (i, l) in lines.iter().enumerate() {
			if is_step(l) {
				gated = lines[i + 1..].iter().take_while(|x| !is_step(x) && !starts_nonspace(x)).any(|x| matches!(head_ws(x), Some("only" | "when")));
			}
			let code = split_comment(l).0;
			if let Some(q) = accept_re.captures(code).and_then(|m| m[1].parse::<u32>().ok()) {
				done.remove(&q);
			}
			if let Some(q) = work_re.captures(code).and_then(|m| m[2].parse::<u32>().ok()) {
				if done.contains(&q) && !re!(r"\boptional\b").is_match(code) {
					changed = true;
					continue;
				}
			}
			if let Some(q) = turnin_re.captures(code).and_then(|m| m[1].parse::<u32>().ok()) {
				if !gated && line_only(l).is_none() && !re!(r"\boptional\b").is_match(code) {
					done.insert(q);
				}
			}
			out.push(l.clone());
		}
		if changed {
			*f = no_empty_steps(out).join("\n");
		}
	}
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

/// A ride everyone takes (`goto ... "Deeprun Tram"`, a boat or zeppelin) ending a step, before steps
/// for everyone in the same town that do not travel: the ride goes after them, the way on last (the
/// Gnomes' Gryth Thurden flight path after the Deeprun Tram goto: everyone back in Ironforge, the tram
/// line behind them, c14 R1 for Rogues and Priests).
pub fn ride_last_in_town(out: Vec<String>) -> Vec<String> {
	let ride = |l: &str| crate::re!(r#"(?i)^\s+goto\s[^"]*"[^"]*\b(?:Boat|Zeppelin|Tram|Ship)\b[^"]*""#).is_match(split_comment(l).0) && line_only(l).is_none();
	let zone_of = |body: &[String]| body.iter().find_map(|l| crate::re!(r"^\s+zone\s+(.+?)\s*$").captures(l).map(|m| m[1].to_string()));
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
	let gated = |s: (usize, usize)| out[s.0 + 1..s.1].iter().any(|l| matches!(head_ws(l), Some("only" | "when" | "loop")));
	let goals = |s: (usize, usize)| (s.0 + 1..s.1).filter(|&k| is_goal(&out[k])).collect::<Vec<_>>();
	// (Moves: the ride's line, the line after which it goes.)
	let mut moves: Vec<(usize, usize)> = Vec::new();
	let mut n = 0;
	while n < steps.len() {
		let s = steps[n];
		let g = goals(s);
		let Some(&last) = g.last() else {
			n += 1;
			continue;
		};
		if gated(s) || !ride(&out[last]) || g.len() < 2 {
			n += 1;
			continue;
		}
		let zone = zone_of(&out[s.0 + 1..s.1]);
		let mut m = n + 1;
		let mut to = None;
		while m < steps.len() {
			let t = steps[m];
			// (Nothing but blank lines between.)
			if (steps[m - 1].1..t.0).any(|k| !out[k].trim().is_empty()) || gated(t) {
				break;
			}
			let tz = zone_of(&out[t.0 + 1..t.1]);
			let tg = goals(t);
			if tg.is_empty() || (tz.is_some() && tz != zone) || tg.iter().any(|&k| matches!(head_ws(&out[k]), Some("goto" | "fly" | "hearth"))) {
				break;
			}
			to = tg.last().copied();
			m += 1;
		}
		if let Some(to) = to {
			moves.push((last, to));
		}
		n = m.max(n + 1);
	}
	if moves.is_empty() {
		return out;
	}
	let mut res: Vec<String> = Vec::with_capacity(out.len());
	let gone: FxHashSet<usize> = moves.iter().map(|m| m.0).collect();
	let after: FxHashMap<usize, usize> = moves.iter().map(|m| (m.1, m.0)).collect();
	for (k, l) in out.iter().enumerate() {
		if !gone.contains(&k) {
			res.push(l.clone());
		}
		if let Some(&r) = after.get(&k) {
			res.push(out[r].clone());
		}
	}
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

/// A `use` of the item a quest gives when taken, with no quest of its own, left before that quest's
/// accept by a pass that moved the quest's lines (Dogran's Pendant in Orgrimmar, The Binding's other
/// lines moved after the Warlocks' Ken'zigla chain into the Stonetalon guide, c15): it goes right
/// after the accept, a move only into a guide whose players include its own's.
pub fn source_item_uses(files: &mut [String], data: &Data, may: &dyn Fn(usize, usize) -> bool) {
	let gives: FxHashMap<u32, u32> = data.quests.iter().filter_map(|(q, r)| r.source_item.filter(|i| *i > 0.0).map(|i| (i as u32, *q))).collect();
	if gives.is_empty() {
		return;
	}
	let texts = split_lines(files);
	let mut first_accept: FxHashMap<u32, (usize, usize)> = FxHashMap::default();
	for (fi, lines) in texts.iter().enumerate() {
		for (li, l) in lines.iter().enumerate() {
			if head_ws(l) == Some("accept") {
				if let Some(q) = quest_of(l) {
					first_accept.entry(q).or_insert((fi, li));
				}
			}
		}
	}
	let mut del: Del = vec![FxHashSet::default(); texts.len()];
	let mut ins: Ins = vec![FxHashMap::default(); texts.len()];
	for (fi, lines) in texts.iter().enumerate() {
		for (li, l) in lines.iter().enumerate() {
			let code = split_comment(l).0;
			if re!(r"\bquest\s+\d").is_match(code) {
				continue;
			}
			let Some(item) = re!(r"^\s+use\s+(\d+)\b").captures(code).and_then(|m| m[1].parse::<u32>().ok()) else { continue };
			let Some(&(afi, ali)) = gives.get(&item).and_then(|q| first_accept.get(q)) else { continue };
			if (afi, ali) < (fi, li) || !may(afi, fi) {
				continue;
			}
			del[fi].insert(li);
			ins[afi].entry(ali).or_default().push(l.clone());
		}
	}
	rewrite(files, &texts, &del, &ins);
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

/// A step for a quest the route does not take, written before that quest's accept: a step `when
/// onquest Q`, or one whose every goal collects a quest item that drops only for Q (`item_quest`):
/// the Druids' Strange Lockbox (the Half Pendant, Trial of the Sea Lion's) at 15.5, before the Moonglade
/// accept, so the box held nothing and the Druids reached Moonglade at 23 without it, c15 Rev15H1. It
/// goes, whole, to the end of the first step after the accept that stands near it (`place`, within
/// `near_yd`), else right after the accept's step. Only into a guide whose players include its own's.
pub fn steps_after_their_quest(
	files: &mut [String],
	in_route: &FxHashSet<u32>,
	item_quest: &FxHashMap<u32, u32>,
	may: &dyn Fn(usize, usize) -> bool,
	place: &dyn Fn(&str) -> Vec<crate::input::Pt>,
	near_yd: f64,
) {
	let texts = split_lines(files);
	// Steps: (file, header line, last body line).
	let mut steps: Vec<(usize, usize, usize)> = Vec::new();
	for (fi, lines) in texts.iter().enumerate() {
		let mut i = 0;
		while i < lines.len() {
			if !is_step(&lines[i]) {
				i += 1;
				continue;
			}
			let mut e = i;
			while e + 1 < lines.len() && !is_step(&lines[e + 1]) && !starts_nonspace(&lines[e + 1]) && !trim(&lines[e + 1]).is_empty() {
				e += 1;
			}
			steps.push((fi, i, e));
			i = e + 1;
		}
	}
	let mut first_accept: FxHashMap<u32, usize> = FxHashMap::default();
	for (si, &(fi, b, e)) in steps.iter().enumerate() {
		for l in &texts[fi][b + 1..=e] {
			if head_ws(l) == Some("accept") {
				if let Some(q) = quest_of(l) {
					first_accept.entry(q).or_insert(si);
				}
			}
		}
	}
	let quest_of_step = |fi: usize, b: usize, e: usize| -> Option<u32> {
		let body = &texts[fi][b + 1..=e];
		if let Some(q) = body.iter().find_map(|l| re!(r"^\s+when\s+onquest\s+(\d+)\s*$").captures(split_comment(l).0)).and_then(|m| m[1].parse::<u32>().ok()) {
			return Some(q);
		}
		let qs: Vec<Option<u32>> = body
			.iter()
			.filter(|l| is_goal(l))
			.map(|l| re!(r"^\s+collect\s+(\d+)\b").captures(split_comment(l).0).and_then(|m| m[1].parse::<u32>().ok()).and_then(|i| item_quest.get(&i).copied()))
			.collect();
		let q = (*qs.first()?)?;
		qs.iter().all(|x| *x == Some(q)).then_some(q)
	};
	let near = |a: &[crate::input::Pt], b: &[crate::input::Pt]| a.iter().any(|p| b.iter().any(|q| p.c == q.c && js_hypot(p.wx - q.wx, p.wy - q.wy) <= near_yd));
	let pts = |fi: usize, b: usize, e: usize| -> Vec<crate::input::Pt> { texts[fi][b + 1..=e].iter().flat_map(|l| place(l)).collect() };
	let mut del: Del = vec![FxHashSet::default(); texts.len()];
	let mut ins: Ins = vec![FxHashMap::default(); texts.len()];
	for (si, &(fi, b, e)) in steps.iter().enumerate() {
		let Some(q) = quest_of_step(fi, b, e).filter(|q| !in_route.contains(q)) else { continue };
		let Some(&ai) = first_accept.get(&q).filter(|&&ai| ai > si) else { continue };
		let here = pts(fi, b, e);
		let to = *steps[ai..].iter().find(|&&(tf, tb, te)| may(tf, fi) && !here.is_empty() && near(&pts(tf, tb, te), &here)).unwrap_or(&steps[ai]);
		if !may(to.0, fi) {
			continue;
		}
		for k in b..=e {
			del[fi].insert(k);
		}
		if texts[fi].get(e + 1).is_some_and(|l| trim(l).is_empty()) {
			del[fi].insert(e + 1);
		}
		let block = ins[to.0].entry(to.2).or_default();
		block.push(String::new());
		block.extend(texts[fi][b..=e].iter().cloned());
	}
	rewrite(files, &texts, &del, &ins);
}

/// Quests the route does not take: a line working or handing one in that ended up before its
/// accept moves to right after the accept; a step left with no goal goes. A hand-in whose ender
/// stands elsewhere goes instead to the end of the first step after the accept that stands by the
/// ender (`place`: a line's NPC points), when one comes: c15's Orgrimmar training wrote Ruga's 1823
/// and Islen's 1528 right after Sorek's and Searn's accepts, a flight to Camp Taurajo and back, Rev15H1.
/// A moved line takes its step's `only` when it has none of its own.
pub fn fix_order(files: &mut [String], in_route: &FxHashSet<u32>, may: &dyn Fn(usize, usize) -> bool, place: &dyn Fn(&str) -> Vec<crate::input::Pt>) {
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
	// (A body line's step `only`, and the end of its step's body.)
	let step_of = |fi: usize, li: usize| -> (usize, usize) {
		let lines = &texts[fi];
		let mut b = li;
		while b > 0 && !is_step(&lines[b]) {
			b -= 1;
		}
		let mut e = li;
		while e + 1 < lines.len() && !is_step(&lines[e + 1]) && !starts_nonspace(&lines[e + 1]) && !trim(&lines[e + 1]).is_empty() {
			e += 1;
		}
		(b, e)
	};
	let near = |a: &[crate::input::Pt], b: &[crate::input::Pt]| a.iter().any(|p| b.iter().any(|q| p.c == q.c && js_hypot(p.wx - q.wx, p.wy - q.wy) <= crate::hub::HUB_YD));
	let mut del: Del = vec![FxHashSet::default(); texts.len()];
	let mut ins: Ins = vec![FxHashMap::default(); texts.len()];
	let mut gone: FxHashSet<u32> = FxHashSet::default();
	for (q, xs) in &early {
		let Some(&(afi, ali)) = at.get(q) else { continue };
		for &(fi, li) in xs {
			if !may(afi, fi) {
				continue;
			}
			let l = &texts[fi][li];
			let (sb, _) = step_of(fi, li);
			let step_only = |tf: usize, k: usize, e: usize| {
				(k + 1..=e).find(|&j| head_ws(&texts[tf][j]) == Some("only")).map(|j| trim(&re!(r"^\s+only\s+").replace(split_comment(&texts[tf][j]).0, "")).to_string())
			};
			// (Its audience: the accept's, the line's own `only` with its step's, that it follows; with
			// none, its own step's. The Tauren Shamans' Telf 1525 taken in the shared Barrens, its Orc
			// guide hand-in moved there `only Shaman`, sent Orc and Skyborne Shamans to Telf, c15 Rev15SkyH.)
			let (ab, a_end) = step_of(afi, ali);
			// (By kind: the accept line's races, else its step's; its classes, else its step's. Sorek's
			// `accept 1823 only Warrior` in a step for seven classes is the Warriors'.)
			let split = |list: Option<String>| -> (Vec<String>, Vec<String>) {
				let xs: Vec<String> = list.iter().flat_map(|l| l.split(',')).map(|x| trim(x).to_string()).filter(|x| !x.is_empty()).collect();
				xs.into_iter().partition(|x| !CLASSES.contains(&x.trim_start_matches('!')))
			};
			let (lr, lc) = split(line_only(&texts[afi][ali]).map(str::to_string));
			let (sr, sc) = split(step_only(afi, ab, a_end));
			let aud: Vec<String> = if lr.is_empty() { sr } else { lr }.into_iter().chain(if lc.is_empty() { sc } else { lc }).collect();
			let audience = if aud.is_empty() { line_only(l).map(str::to_string).or_else(|| step_only(fi, sb, step_of(fi, li).1)) } else { Some(aud.join(",")) };
			let line = match &audience {
				Some(a) => {
					let (code, rest) = split_comment(l);
					let base = re!(r"\s+only\s+\S+\s*$").replace(code, "").to_string();
					format!("{} only {a}{rest}", trim_end(&base))
				}
				None => l.clone(),
			};
			let ender = if head_ws(l) == Some("turnin") { place(l) } else { Vec::new() };
			let pts_of = |tf: usize, k: usize, e: usize| -> Vec<crate::input::Pt> { (k + 1..=e).flat_map(|j| place(&texts[tf][j])).collect() };
			let src_only = audience.clone();
			let mut to = (afi, ali);
			if !ender.is_empty() && !near(&pts_of(afi, ab, a_end), &ender) {
				let target = (afi..texts.len()).filter(|&tf| may(tf, fi)).find_map(|tf| {
					let from = if tf == afi { a_end + 1 } else { 0 };
					(from..texts[tf].len()).filter(|&k| is_step(&texts[tf][k])).find_map(|k| {
						let (_, e) = step_of(tf, k);
						let only = step_only(tf, k, e);
						let gated = (k + 1..=e).any(|j| head_ws(&texts[tf][j]) == Some("when"));
						(!gated && (only.is_none() || only == src_only) && near(&pts_of(tf, k, e), &ender)).then_some((tf, e))
					})
				});
				match target {
					Some(t) => to = t,
					// (An optional hand-in with no later stop by its ender is not written, nor the rest of
					// its quest: next to the accept it made a trip of its own, and an accept left open is a
					// loose end. c17's OOX-17/TN and OOX-09/HL rewards, flown to Booty Bay from Tanaris and
					// the Hinterlands and walked back, the escort after it. Its step's tip still names the
					// ender for the player who escorts the robot.)
					None if re!(r"\boptional\b").is_match(split_comment(l).0) => {
						gone.insert(*q);
						continue;
					}
					None => {}
				}
			}
			del[fi].insert(li);
			// (Not a second line of the quest where one follows its accept already.)
			let verb = head_ws(l);
			let again = (afi..texts.len()).any(|tf| {
				let from = if tf == afi { ali + 1 } else { 0 };
				texts[tf][from..].iter().any(|x| head_ws(x) == verb && quest_of(x) == Some(*q))
			});
			if !again {
				ins[to.0].entry(to.1).or_default().push(line);
			}
		}
	}
	if !gone.is_empty() {
		for (fi, lines) in texts.iter().enumerate() {
			for (li, l) in lines.iter().enumerate() {
				if is_goal(l) && quest_of(l).is_some_and(|q| gone.contains(&q)) {
					del[fi].insert(li);
				}
			}
		}
		for m in ins.iter_mut() {
			for v in m.values_mut() {
				v.retain(|l| quest_of(l).is_none_or(|q| !gone.contains(&q)));
			}
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
		let (mut tfi, mut tli) = flat[wait];
		if !may(tfi, xfi) {
			continue;
		}
		let z = zone_at(xfi, xli);
		// (In another zone than the item's: at the item guide's first later step for everyone there,
		// when one comes, not a trip from the item's place. The Shamans' Call of Water to Brine, south
		// of Camp Taurajo, written right after the Ashenvale fountain, c14 (12a).)
		if let Some(zz) = z.as_ref().filter(|zz| !zz.is_empty() && Some(*zz) != zone_at(tfi, tli).as_ref()) {
			let later = flat[wait + 1..].iter().copied().take_while(|&(fi, _)| fi == tfi).find(|&(fi, li)| {
				is_step(&texts[fi][li]) && may(fi, xfi) && {
					let e = step_end(fi, li);
					zone_at(fi, e).as_ref() == Some(zz) && !(li + 1..=e).any(|k| head_ws(&texts[fi][k]) == Some("only"))
				}
			});
			if let Some((fi, li)) = later {
				(tfi, tli) = (fi, li);
			}
		}
		let end = step_end(tfi, tli);
		let t0 = &texts[xfi][step_start(xfi, xli)];
		let title = if t0.is_empty() { format!("step Turn in {}", &m[1]) } else { t0.clone() };
		let mut line = xl.clone();
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
		// (The route's accepts after it in its step that need it handed in go with it, when none of
		// their quest's lines comes before where it goes: The Final Message to the Wildhammer after
		// Another Message's feathers, c16 Hinterlands; not Test of Strength, whose hand-in the guide
		// writes before Test of Endurance's.)
		let q: i64 = m[1].parse().unwrap_or(0);
		let needs = |a: u32| {
			data.quests.get(&a).is_some_and(|r| {
				let parent = r.parent.map(|p| p as i64);
				r.pre.iter().flatten().chain(r.pre_any.iter().flatten()).filter_map(|v| v.as_i64()).any(|p| p.abs() == q && Some(q) != parent)
			})
		};
		let to = flat.iter().position(|&p| p == (tfi, end)).unwrap_or(i);
		for k in xli + 1..=step_end(xfi, xli) {
			let Some(a) = re!(r"^\s+accept\s+(\d+)\b").captures(&texts[xfi][k]).and_then(|c| c[1].parse::<u32>().ok()) else { continue };
			let own = regex::Regex::new(&format!(r"\bquest\s+{a}\b|^\s+(?:complete|turnin)\s+{a}\b")).unwrap();
			let stranded = flat[i + 1..=to.max(i)].iter().any(|&(fi, li)| (fi, li) != (xfi, k) && own.is_match(&texts[fi][li]));
			if route_qs.contains(&a) && needs(a) && !stranded && del[xfi].insert(k) {
				e.push(texts[xfi][k].clone());
			}
		}
	}
	rewrite(files, &texts, &del, &ins);
}

fn race_list(list: Option<&str>) -> Vec<&str> {
	list.map_or(Vec::new(), |l| l.split(',').map(trim).filter(|x| ALL_RACES.contains(&x.strip_prefix('!').unwrap_or(x))).collect())
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
		let a = forge_guide::conditions::Audience::parse(l);
		(a.every_class() && route_races.iter().all(|r| a.race_in(r)), route_races.iter().any(|r| a.race_in(r)))
	};
	let mut bound: Option<String> = None;
	// Binds only some classes make, for every route race (the Druids' at Thunder Bluff before
	// Moonglade, c14 Tauren): their hearth back there is theirs, not a hearth they are not bound for.
	let mut class_bound: FxHashMap<&'static str, String> = FxHashMap::default();
	let classes_of = |step: Option<&str>, own: Option<&str>| -> Option<Vec<&'static str>> {
		let a = forge_guide::conditions::Audience::parse(step.unwrap_or("")).and(&forge_guide::conditions::Audience::parse(own.unwrap_or("")));
		let some_classes = !a.every_class() && route_races.iter().all(|r| a.race_in(r));
		a.classes.filter(|cs| some_classes && !cs.is_empty())
	};
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
				let inn = b.get(1).or(b.get(2)).unwrap().as_str().to_string();
				if all {
					bound = Some(inn);
					class_bound.clear();
				} else if let Some(cs) = classes_of(step_list.as_deref(), own) {
					for c in cs {
						class_bound.insert(c, inn.clone());
					}
				}
			}
			let h = re!(r#"^\s+hearth\s+"([^"]+)""#).captures(l);
			let class_home = h.as_ref().is_some_and(|h| classes_of(step_list.as_deref(), own).is_some_and(|cs| cs.iter().all(|c| class_bound.get(c).is_some_and(|b| b == &h[1]))));
			let bad = h.as_ref().is_some_and(|h| some && !class_home && bound.as_deref() != Some("nearest") && bound.as_deref() != Some(&h[1]));
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

/// Every goal line of a quest the route fixes keep optional (`optional`: [`crate::hub::fix_optional`],
/// the rare-drop chains: The Green Hills of Stranglethorn and its chapters, Study of the Elements:
/// Rock) but its hand-in is written `optional`: taken only by a player who has the drop, never a
/// step that waits on it (c19p: v1's `accept 338` and `accept 712` required them, 35 `rare`
/// blockers). The hand-in stays as written: it applies only to a player who has the quest done (a
/// Precessive Autocognition Assembly's Harvesting the Harvesters, handed in at Saldean's, #298).
pub fn optional_by_fixes(files: &mut [String], optional: &FxHashSet<u32>) {
	if optional.is_empty() {
		return;
	}
	for f in files.iter_mut() {
		let mut changed = false;
		let out: Vec<String> = f
			.split('\n')
			.map(|l| {
				let (code, rest) = split_comment(l);
				if !is_goal(code) || head_ws(code) == Some("turnin") || re!(r"\boptional\b").is_match(code) || !quest_of(code).is_some_and(|q| optional.contains(&q)) {
					return l.to_string();
				}
				changed = true;
				let line = format!("{} optional", code.trim_end());
				format!("{line:<w$}{rest}", w = code.len())
			})
			.collect();
		if changed {
			*f = out.join("\n");
		}
	}
}

/// Riding is learnt at level 40. The planner plays a riding step at 40 or later only (c19p: 42.5 to
/// 50 in every start's model, about 43 in the check's walk), but a player can be behind the model. A
/// step that trains at a riding trainer (the data's "Wolf Riding Instructor", "Stablemaster and
/// Riding Trainer", the Gnomes' "Mechanostrider Pilot") holds only from level 40 (`when level>=40`):
/// a player still under it passes it instead of standing at a trainer who cannot teach them. So does
/// a riding step with no trainer on the route, only its notes (`step Riding at 40`: the Skyborne's,
/// whose trainer is on Zephras Isle). A riding line in a step with other work goes into a step of its
/// own right after it, with the step's `only` and zone, so the rest of the step stays for everyone.
/// The way to a riding step and back for its characters alone (its `only`) is gated with it
/// ([`riding_trips`]), unless that trip goes on to more of theirs: the Trolls' flight to Booty Bay and
/// boat to Ratchet for Xar'Ti in Sen'jin Village, and back. Run on the guides as written, after the
/// travel repair, which writes such ways only for steps that apply.
pub fn riding_at_level(files: &mut [String], data: &Data) {
	let rider = |l: &str| {
		re!(r"^\s+train\s+(\d+)\b")
			.captures(split_comment(l).0)
			.and_then(|m| m[1].parse::<u32>().ok())
			.and_then(|n| data.npcs.get(&n))
			.and_then(|e| e.sub_name.as_deref())
			.is_some_and(|s| re!(r"(?i)\briding (?:instructor|trainer)\b|^Mechanostrider Pilot$").is_match(s))
	};
	let mount = |l: &str| matches!(head_ws(l), Some("vendor" | "buy" | "note"));
	let titled = |l: &str| re!(r"^step Riding at \d+\s*$").is_match(l);
	let gate = format!("  when level>={RIDING_LEVEL}");
	for f in files.iter_mut() {
		let lines: Vec<String> = f.split('\n').map(str::to_string).collect();
		if !lines.iter().any(|l| rider(l) || titled(l)) {
			continue;
		}
		let mut out: Vec<String> = Vec::with_capacity(lines.len() + 8);
		// (The gate lines this pass writes, by index in `out`.)
		let mut mine: Vec<usize> = Vec::new();
		let mut i = 0;
		while i < lines.len() {
			if !is_step(&lines[i]) {
				out.push(lines[i].clone());
				i += 1;
				continue;
			}
			let mut j = i + 1;
			while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
				j += 1;
			}
			let body = &lines[i + 1..j];
			let rides: Vec<usize> = (0..body.len()).filter(|&k| rider(&body[k])).collect();
			let all_mount = (0..body.len()).filter(|&k| is_goal(&body[k])).all(|k| rides.contains(&k) || mount(&body[k]));
			if (rides.is_empty() && !(titled(&lines[i]) && all_mount)) || body.iter().any(|l| re!(r"^\s+when\s+level\s*>").is_match(l)) {
				out.extend_from_slice(&lines[i..j]);
				i = j;
				continue;
			}
			// (The step's head: its `only`, zone and conditions before its first line.)
			let head = body.iter().position(|l| !matches!(head_ws(l), Some("only" | "zone" | "when"))).unwrap_or(body.len());
			out.push(lines[i].clone());
			if all_mount {
				out.extend_from_slice(&body[..head]);
				mine.push(out.len());
				out.push(gate.clone());
				out.extend_from_slice(&body[head..]);
			} else {
				let end = body.iter().rposition(|l| !l.trim().is_empty()).map_or(0, |p| p + 1);
				out.extend((0..end).filter(|k| !rides.contains(k)).map(|k| body[k].clone()));
				out.push(String::new());
				out.push("step Riding at 40".into());
				out.extend(body[..head].iter().filter(|l| matches!(head_ws(l), Some("only" | "zone"))).cloned());
				mine.push(out.len());
				out.push(gate.clone());
				out.extend(rides.iter().map(|&k| body[k].clone()));
				out.extend_from_slice(&body[end..]);
			}
			i = j;
		}
		*f = riding_trips(out, &gate, &mine).join("\n");
	}
}

/// [`riding_at_level`]'s trips: the travel-only steps right before and after each riding step it
/// gated (`mine`: its gate lines) with the same `only` get the gate too: a player under 40 neither
/// goes nor comes back. A way there with no way back of theirs right after it: their way back further
/// on, the travel-only steps of theirs, or of some of their classes, up to everyone's next step, past
/// steps for other races or for some classes of every race (the Taurens' flight back to Gadgetzan
/// after the Undead's and the Druids' trips; the Undead's from Brill, the Paladins' `only
/// Undead,Paladin,Druid`, the Warlocks' and the others', c19p Horde 40-50/02-feralas), else none
/// (the Humans' walk to Eastvale before everyone's way into Deadwind Pass): gated with it, they stay
/// with everyone. A step between for theirs and another race's (`only Troll,Orc`), or another step
/// of theirs that is not travel, keeps the trip, step and all, ungated: gated alone, it left the
/// player where the way there ends, and the next way, made for where the riding step stands, failed
/// (c19 Horde 40-50/02-feralas). A trip that goes on to more of the same characters' own steps is
/// needed anyway: the step alone.
fn riding_trips(mut out: Vec<String>, gate: &str, mine: &[usize]) -> Vec<String> {
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
	let only = |s: (usize, usize)| (s.0 + 1..s.1).take_while(|&k| !is_goal(&out[k])).find(|&k| head_ws(&out[k]) == Some("only")).map(|k| out[k].clone());
	let travel = |s: (usize, usize)| {
		let g: Vec<usize> = (s.0 + 1..s.1).filter(|&k| is_goal(&out[k])).collect();
		!g.is_empty() && g.iter().all(|&k| matches!(head_ws(&out[k]), Some("goto" | "fly" | "hearth")))
	};
	let names = |l: &str| -> Vec<String> { l.trim().trim_start_matches("only").split(',').map(|x| trim(x).to_string()).filter(|x| !x.is_empty()).collect() };
	// (Line index and what to do there: true, the gate goes in; false, this pass's gate line goes.)
	let mut edits: Vec<(usize, bool)> = Vec::new();
	for n in 0..steps.len() {
		let Some(&g) = mine.iter().find(|&&k| (steps[n].0..steps[n].1).contains(&k)) else { continue };
		let Some(o) = only(steps[n]) else { continue };
		let same = |m: usize| only(steps[m]).as_deref() == Some(o.as_str());
		let before: Vec<usize> = (0..n).rev().take_while(|&m| travel(steps[m]) && same(m)).collect();
		let mut after: Vec<usize> = (n + 1..steps.len()).take_while(|&m| travel(steps[m]) && same(m)).collect();
		let next = n + 1 + after.len();
		if next < steps.len() && same(next) {
			continue;
		}
		if !before.is_empty() && after.is_empty() {
			// (Their way back further on, past steps for others alone; or none before everyone's next
			// step. A step between for theirs and another race's, or of theirs but not travel: the trip
			// is not theirs alone.)
			let races_of = |l: &str| -> Vec<String> { names(l).into_iter().filter(|x| !x.starts_with('!') && !CLASSES.contains(&x.as_str())).collect() };
			let own = races_of(&o);
			let mut shared = false;
			for m in n + 1..steps.len() {
				let Some(om) = only(steps[m]) else { break };
				let rs = races_of(&om);
				if rs.iter().all(|r| !own.contains(r)) {
					continue;
				}
				if rs.iter().all(|r| own.contains(r)) && travel(steps[m]) {
					after.push(m);
					continue;
				}
				shared = true;
				break;
			}
			if shared {
				edits.push((g, false));
				continue;
			}
		}
		for m in before.into_iter().chain(after) {
			let (s, e) = steps[m];
			if !(s + 1..e).any(|k| re!(r"^\s+when\s+level\s*>").is_match(&out[k])) {
				edits.push(((s + 1..e).find(|&k| !matches!(head_ws(&out[k]), Some("only" | "zone" | "when"))).unwrap_or(e), true));
			}
		}
	}
	edits.sort_unstable_by_key(|e| std::cmp::Reverse(e.0));
	for (k, add) in edits {
		if add {
			out.insert(k, gate.to_string());
		} else {
			out.remove(k);
		}
	}
	out
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

/// In a step with a `level` gate before a class accept (written where the route is below the
/// accept's level), the step's hand-ins after the gate go before it: their experience is what tops
/// the level up (c14 Razor Hill, `level 10 only Warrior` and four level-10 class accepts before
/// Gar'Thok's and Cook Torka's hand-ins, A1). Not a hand-in of a quest accepted after the gate, nor
/// past a travel line; not v1's grind goals (a kill quest handed in after its grind).
pub fn hand_ins_before_level_gate(files: &mut [String]) {
	for f in files.iter_mut() {
		let mut lines: Vec<String> = f.split('\n').map(str::to_string).collect();
		let mut changed = false;
		let mut i = 0;
		while i < lines.len() {
			if !is_step(&lines[i]) {
				i += 1;
				continue;
			}
			let mut j = i + 1;
			while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
				j += 1;
			}
			if let Some(g) = (i + 1..j).find(|&k| head_ws(&lines[k]) == Some("level") && lines.get(k + 1).is_some_and(|n| head_ws(n) == Some("accept"))) {
				let mut accepted: FxHashSet<u32> = FxHashSet::default();
				let mut moved: Vec<usize> = Vec::new();
				for k in g + 1..j {
					let code = split_comment(&lines[k]).0;
					if re!(r"^\s+(goto|fly|hearth|walk|ride|boat|zeppelin|tram|die|use)\b").is_match(code) {
						break;
					}
					if let Some(m) = re!(r"^\s+accept\s+(\d+)\b").captures(code) {
						accepted.extend(m[1].parse::<u32>().ok());
					} else if let Some(q) = re!(r"^\s+turnin\s+(\d+)\b").captures(code).and_then(|m| m[1].parse::<u32>().ok()) {
						if !accepted.contains(&q) {
							moved.push(k);
						}
					}
				}
				if !moved.is_empty() {
					changed = true;
					let take: Vec<String> = moved.iter().map(|&k| lines[k].clone()).collect();
					let rest: Vec<String> = (g..j).filter(|k| !moved.contains(k)).map(|k| lines[k].clone()).collect();
					lines.splice(g..j, take.into_iter().chain(rest));
				}
			}
			i = j;
		}
		if changed {
			*f = lines.join("\n");
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
	// (Whether a step travels: a flight, a hearth or a walk somewhere, which ends a town visit.)
	let travels = |body: &[&str]| body.iter().any(|l| matches!(head_ws(l), Some("fly" | "hearth" | "goto")));
	for f in files.iter_mut() {
		let lines: Vec<&str> = f.split('\n').collect();
		let mut out: Vec<String> = Vec::with_capacity(lines.len());
		let mut changed = false;
		// (The classes the last step for everyone trained.)
		let mut prev: Option<Option<Vec<String>>> = None;
		// (The classes trained in this town visit, no travel between: a class's second training there
		// goes, the Shamans' route stop and v1's Spirit Rise step in one Thunder Bluff visit, c17 Tauren.)
		let mut visit: Vec<String> = Vec::new();
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
			// (A class's training line, all its classes trained already in this visit.)
			let twice = |l: &str| gated && trained(l).flatten().is_some_and(|t| t.iter().all(|c| visit.contains(c)));
			if body.iter().any(|l| again(l) || twice(l)) {
				changed = true;
				let rest: Vec<&str> = body.iter().copied().filter(|l| !again(l) && !twice(l)).collect();
				let goals: Vec<&str> = rest.iter().copied().filter(|l| is_goal(l)).collect();
				if !goals.is_empty() {
					out.push(lines[i].to_string());
					// (Every line some classes': the step is theirs.)
					let classes: Option<Vec<&str>> = (!gated)
						.then(|| {
							goals.iter().try_fold(Vec::new(), |mut acc: Vec<&str>, l| {
								let cl: Vec<&str> = line_only(l)?.split(',').map(trim).filter(|c| CLASSES.contains(c)).collect();
								(!cl.is_empty()).then(|| {
									acc.extend(cl.into_iter().filter(|c| !acc.contains(c)).collect::<Vec<_>>());
									acc
								})
							})
						})
						.flatten();
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
			for t in body.iter().filter_map(|l| trained(l)) {
				for c in t.unwrap_or_else(|| CLASSES.iter().map(|c| c.to_string()).collect()) {
					if !visit.contains(&c) {
						visit.push(c);
					}
				}
			}
			if travels(body) {
				visit.clear();
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
			// (The zone the step ends in: a flight's step names its landing's after the `fly`.)
			let own_zone = body.iter().filter_map(|l| zone_of(l)).next_back();
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
		// (Not its parent: that one must be in the log, not handed in, Chapter I-IV inside The Green
		// Hills of Stranglethorn.)
		let parent = r.parent.map(|p| p as i64);
		let pre: Vec<i64> = ids(&r.pre).into_iter().filter(|&p| Some(p.abs()) != parent).collect();
		let all: Vec<u32> = pre.iter().filter(|&&p| p > 0).map(|&p| p as u32).collect();
		let mut any: Vec<u32> = pre.iter().filter(|&&p| p < 0).map(|p| (-p) as u32).collect();
		any.extend(ids(&r.pre_any).into_iter().filter(|&p| p > 0 && Some(p) != parent).map(|p| p as u32));
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
				// (Its last: a flight's step names its landing's zone after the `fly`, "Fly to Crossroads" from
				// Orgrimmar; its first put `zone Orgrimmar` on the Crossroads' Darsok step after the moved
				// Warlock steps, and the next steps' coordinates read on Orgrimmar's map, c17 4921.)
				if let Some(z) = lines[i + 1..j].iter().filter_map(|l| zone_re.captures(split_comment(l).0).map(|m| m[1].to_string())).next_back() {
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
				let done_by =
					|p: u32, upto: usize| handed_before.contains(&p) || lines[..upto].iter().any(|x| tin_re.captures(split_comment(x).0).is_some_and(|m| m[1].parse::<u32>().ok() == Some(p)));
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
			// (The `level` line gating a moved accept goes with it: Ken'zigla's `level 20 only Warlock` was
			// left as a step of its own, an empty walk into Stonetalon, c17.)
			let gates: Vec<usize> = take.iter().filter(|&&x| x > 0 && acc_re.is_match(split_comment(&lines[x]).0) && head_ws(&lines[x - 1]) == Some("level")).map(|&x| x - 1).collect();
			take.extend(gates);
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
			// (After the hand-in's step and the steps right after it at its NPCs, everyone's accepts and
			// hand-ins there: the Warlocks' Ken'zigla trip after Darsok's Letter to Jin'Zil at the
			// Crossroads, not between his hand-in and his accept, then back to him, c17 dup-trip.)
			let npc_of = |l: &str| -> Option<Vec<u32>> {
				let code = split_comment(l).0;
				let m = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code)?;
				let r = data.quests.get(&m[2].parse::<u32>().ok()?)?;
				let e = if &m[1] == "accept" { r.start.as_ref() } else { r.end.as_ref() }?;
				Some(e.npc.clone())
			};
			let hub: FxHashSet<u32> = (steps[ts].0 + 1..steps[ts].1).filter_map(|x| npc_of(&lines[x])).flatten().collect();
			let mut tl = ts;
			while let Some(n) = steps.get(tl + 1) {
				let body = &lines[n.0 + 1..n.1];
				let gap_blank = lines[steps[tl].1..n.0].iter().all(|l| l.trim().is_empty());
				let own = body.iter().any(|l| matches!(head_ws(l), Some("only" | "zone" | "when" | "goto" | "fly" | "hearth" | "along" | "loop")));
				let goals: Vec<&String> = body.iter().filter(|l| is_goal(l)).collect();
				let at_hub = !goals.is_empty() && goals.iter().all(|l| line_only(l).is_none() && npc_of(l).is_some_and(|ns| ns.iter().any(|x| hub.contains(x))));
				if !gap_blank || own || !at_hub {
					break;
				}
				tl += 1;
			}
			// (The step after them reads where the hand-in's step did.)
			let (_, te, tz) = steps[tl].clone();
			let next_named = steps.get(tl + 1).is_some_and(|n| lines[n.0 + 1..n.1].iter().any(|l| head_ws(l) == Some("zone")));
			let restate = steps.get(tl + 1).filter(|_| !next_named).map(|n| n.0);
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
			let Some((gj, p)) =
				missing.iter().chain(any.iter().filter(|_| any_missing)).find_map(|&p| (fi + 1..files.len()).find(|&g| later_turnins[g].contains(&p)).filter(|&g| may(g, fi)).map(|g| (g, p)))
			else {
				continue;
			};
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

/// A way step into a zone (`goto x,y "Ashenvale"`, everyone's) right before a step only those who
/// hold a quest play (`when onquest`) in that zone is that step's way in: it goes into the step, so
/// the others do not walk out there and back (the route's walk from Talrendis Point to Forest Song
/// for a carried hand-in, c14 Silithus bounce).
pub fn onquest_way_in(out: Vec<String>) -> Vec<String> {
	let zone_of = |lines: &[String]| lines.iter().find_map(|l| crate::re!(r"^\s+zone\s+(.+?)\s*$").captures(split_comment(l).0).map(|m| m[1].to_string()));
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
	let mut moves: Vec<(usize, usize, usize)> = Vec::new();
	// (A lone way step for everyone: one goal, a goto, no audience.)
	let way = |s: (usize, usize)| {
		let goals: Vec<usize> = (s.0 + 1..s.1).filter(|&k| is_goal(&out[k])).collect();
		let body = &out[s.0 + 1..s.1];
		matches!(goals.as_slice(), [g] if head_ws(&out[*g]) == Some("goto") && line_only(&out[*g]).is_none())
			&& !body.iter().any(|l| matches!(head_ws(l), Some("only" | "when" | "label" | "loop")) || split_comment(l).0.trim_start().starts_with('#'))
	};
	for w in 0..steps.len() {
		let (a0, a1) = steps[w];
		if !way(steps[w]) {
			continue;
		}
		// (Past other ways between, the repair's walk back to Talrendis Point after it.)
		let mut n = w + 1;
		while n < steps.len() && way(steps[n]) && zone_of(&out[steps[n].0 + 1..steps[n].1]) != zone_of(&out[a0 + 1..a1]) {
			n += 1;
		}
		let Some(&(b0, b1)) = steps.get(n) else { continue };
		if (a1..b0).any(|k| !out[k].trim().is_empty() && !steps[w + 1..n].iter().any(|s| (s.0..s.1).contains(&k))) {
			continue;
		}
		let next = &out[b0 + 1..b1];
		if !next.iter().any(|l| crate::re!(r"^\s+when\s+onquest\b").is_match(l)) || zone_of(&out[a0 + 1..a1]).is_none() || zone_of(&out[a0 + 1..a1]) != zone_of(next) {
			continue;
		}
		// (Into the step after its condition, zone and tips: its first goal.)
		let at = (b0 + 1..b1).find(|&k| is_goal(&out[k])).unwrap_or(b1);
		moves.push((a0, a1, at));
	}
	if moves.is_empty() {
		return out;
	}
	let mut ins: FxHashMap<usize, String> = FxHashMap::default();
	let mut gone: FxHashSet<usize> = FxHashSet::default();
	for (a0, a1, at) in moves {
		let g = (a0 + 1..a1).find(|&k| is_goal(&out[k])).unwrap();
		ins.insert(at, out[g].clone());
		gone.extend(a0..a1);
	}
	let mut res = Vec::with_capacity(out.len());
	for (k, l) in out.into_iter().enumerate() {
		if let Some(x) = ins.remove(&k) {
			res.push(x);
		}
		if !gone.contains(&k) {
			res.push(l);
		}
	}
	res
}

/// A class's detour that walks past the NPC of a quest ready to hand in hands it in there, for that
/// class: the route's own hand-in later is the others' (`only Orc,Troll,!Warlock`). The Orc Warlocks'
/// trip to Gan'rul in the Cleft of Shadow stood beside Neeru Fireblade with 832 in their bags. Beside:
/// within a hub's reach of one of the step's own quest NPCs. `files`: the chain, in order.
pub fn detour_hand_ins(files: &mut [(String, Vec<String>)], world: &World) -> usize {
	use forge_guide::conditions::Audience;
	let quest = |l: &str, verb: &str| -> Option<u32> { crate::jsre::compile(&format!(r"^\s+{verb}\s+(\d+)\b")).captures(split_comment(l).0).and_then(|m| m[1].parse().ok()) };
	let wq: FxHashMap<u32, &crate::input::WQuest> = world.quests.iter().map(|q| (q.id, q)).collect();
	let pt = |p: Option<u32>| p.and_then(|i| world.points.get(i as usize)).filter(|p| p.wx.is_finite());
	// A line's point: an accept's giver, a turn-in's ender.
	let line_pt = |l: &str| quest(l, "accept").and_then(|q| pt(wq.get(&q)?.giver)).or_else(|| quest(l, "turnin").and_then(|q| pt(wq.get(&q)?.ender)));
	// The chain's lines, flat: (file, line).
	let at: Vec<(usize, usize)> = files.iter().enumerate().flat_map(|(f, (_, ls))| (0..ls.len()).map(move |i| (f, i))).collect();
	let text = |files: &[(String, Vec<String>)], k: usize| files[at[k].0].1[at[k].1].clone();
	// Steps: (first line, end) in flat indices, and their `only`.
	let mut steps: Vec<(usize, usize, Audience)> = Vec::new();
	{
		let mut k = 0;
		while k < at.len() {
			if !is_step(&text(files, k)) {
				k += 1;
				continue;
			}
			let mut e = k + 1;
			while e < at.len() && at[e].0 == at[k].0 && !is_step(&text(files, e)) && !starts_nonspace(&text(files, e)) {
				e += 1;
			}
			let only = (k + 1..e).map(|j| text(files, j)).find_map(|l| re!(r"^\s+only\s+([!A-Za-z,]+)\s*$").captures(&l).map(|m| Audience::parse(&m[1]))).unwrap_or_default();
			steps.push((k, e, only));
			k = e;
		}
	}
	// Per quest: its first accept, its hand-ins, its last tagged work line (`quest Q`, `complete Q`).
	let mut first_accept: FxHashMap<u32, usize> = FxHashMap::default();
	let mut hand_ins: FxHashMap<u32, Vec<usize>> = FxHashMap::default();
	let mut last_work: FxHashMap<u32, usize> = FxHashMap::default();
	for k in 0..at.len() {
		let l = text(files, k);
		if let Some(q) = quest(&l, "accept") {
			first_accept.entry(q).or_insert(k);
		}
		if let Some(q) = quest(&l, "turnin") {
			hand_ins.entry(q).or_default().push(k);
			continue;
		}
		for m in re!(r"\b(?:quest|complete)\s+(\d+)").captures_iter(split_comment(&l).0) {
			if let Ok(q) = m[1].parse::<u32>() {
				last_work.insert(q, k);
			}
		}
	}
	let step_of = |k: usize| steps.partition_point(|s| s.0 <= k).checked_sub(1).filter(|&i| k < steps[i].1);
	let mut adds: Vec<(usize, String)> = Vec::new();
	let mut sets: FxHashMap<usize, String> = FxHashMap::default();
	// (The quests a class's detour already hands in: not again at its next step beside the same NPC,
	// the Warlocks' 876 at Gazrog's two Crossroads steps, c14 Rev14H1 A2.)
	let mut added: FxHashSet<(u32, String)> = FxHashSet::default();
	for (s0, s1, sa) in &steps {
		// (A class's own step: classes, no races.)
		let Some(cls) = sa.classes.as_ref().filter(|_| sa.races.is_none() && !sa.every_class()) else { continue };
		let sees = |a: &Audience| cls.iter().any(|c| a.class_in(c));
		let pts: Vec<&crate::input::Pt> = (s0 + 1..*s1).filter_map(|j| line_pt(&text(files, j))).collect();
		if pts.is_empty() {
			continue;
		}
		// (Beside one of the step's own NPCs: its walk there passes it. Not by the straight line from the
		// step before, which a flight or a boat may make.)
		let passes = |e: &crate::input::Pt| pts.iter().any(|p| p.c == e.c && js_hypot(p.wx - e.wx, p.wy - e.wy) <= crate::hub::HUB_YD);
		let mut done_here: FxHashSet<u32> = (s0 + 1..*s1).filter_map(|j| quest(&text(files, j), "turnin")).collect();
		// Each later hand-in (the first of its quest) for the class too, ready here.
		for t in *s1..at.len() {
			let l = text(files, t);
			let Some(q) = quest(&l, "turnin") else { continue };
			if done_here.contains(&q) || l.contains(" item ") || l.contains(" object ") || re!(r"\boptional\b").is_match(&l) {
				continue;
			}
			done_here.insert(q);
			let Some(e) = wq.get(&q).and_then(|w| pt(w.ender)) else { continue };
			if !passes(e) {
				continue;
			}
			// (Its step for everyone or some races; the line's own list races at most.)
			let Some(ti) = step_of(t) else { continue };
			if steps[ti].2.classes.is_some() {
				continue;
			}
			let own = line_only(&l).map(Audience::parse).unwrap_or_default();
			if own.classes.is_some() || !sees(&own) {
				continue;
			}
			// Ready: taken before, not handed in yet, its work (or, with none written, its quest's) done.
			let accepted = first_accept.get(&q).is_some_and(|&k| k < *s0);
			let handed = hand_ins.get(&q).is_some_and(|v| v.iter().any(|&k| k < *s0));
			let ready = match last_work.get(&q) {
				Some(&k) => k < *s0,
				None => wq.get(&q).is_some_and(|w| w.objs.is_empty()),
			};
			if !accepted || handed || !ready || !added.insert((q, cls.join(","))) {
				continue;
			}
			// The class's hand-in, after its step's last quest line; the route's for the others.
			let (code, rest) = split_comment(&l);
			let base = re!(r"\s+only\s+\S+\s*$").replace(code, "").to_string();
			let races = own.races.as_ref().map(|r| format!(" only {}", r.join(","))).unwrap_or_default();
			let last = (s0 + 1..*s1).rfind(|&j| line_pt(&text(files, j)).is_some()).unwrap();
			adds.push((last, format!("{}{races}{rest}", trim_end(&base))));
			let mut others = own.clone();
			others.classes = Some(forge_guide::races::CLASS_FILES.iter().copied().filter(|c| !cls.contains(c)).collect());
			let onquest = crate::jsre::compile(&format!(r"^\s+when\s+onquest\s+{q}\b"));
			let step_when = (steps[ti].0 + 1..steps[ti].1).any(|j| onquest.is_match(&text(files, j)));
			if !step_when {
				sets.insert(t, format!("{} only {}{rest}", trim_end(&base), others.render().unwrap_or_default()));
			}
		}
	}
	// A class's own hand-in written at a later visit, though its ender stands beside the step where the
	// class took it and nothing is left to do: handed in there (the Skyborne Rogues' Simple Note for Akeri
	// Duskblade, in the watchtower beside Rorian, not after the standing stones).
	let mut gone: FxHashSet<usize> = FxHashSet::default();
	for t in 0..at.len() {
		let l = text(files, t);
		let Some(q) = quest(&l, "turnin") else { continue };
		let own = line_only(&l).map(Audience::parse).unwrap_or_default();
		if own.classes.is_none() || own.every_class() || l.contains(" item ") || l.contains(" object ") {
			continue;
		}
		let Some(&acc) = first_accept.get(&q) else { continue };
		let (Some(ai), Some(ti)) = (step_of(acc), step_of(t)) else { continue };
		if ai >= ti || at[acc].0 != at[t].0 || last_work.contains_key(&q) || !wq.get(&q).is_some_and(|w| w.objs.is_empty()) {
			continue;
		}
		let Some(e) = wq.get(&q).and_then(|w| pt(w.ender)) else { continue };
		let (a0, a1, _) = &steps[ai];
		let beside = (a0 + 1..*a1).filter_map(|j| line_pt(&text(files, j))).any(|p| p.c == e.c && js_hypot(p.wx - e.wx, p.wy - e.wy) <= crate::hub::HUB_YD);
		if !beside || (steps[ti].0 + 1..steps[ti].1).any(|j| re!(r"^\s+when\b").is_match(&text(files, j))) {
			continue;
		}
		// (Only when the route leaves between, a later visit: the Valley of Trials' trainers' hand-ins in
		// the same stay keep their sweep.)
		let left = (steps[ai].1..steps[ti].0).filter_map(|j| line_pt(&text(files, j))).any(|p| p.c != e.c || js_hypot(p.wx - e.wx, p.wy - e.wy) > crate::hub::LEAVE_YD);
		if !left {
			continue;
		}
		// (Right after the step's last line of that class, else its accept.)
		let last = (acc..*a1).rfind(|&j| line_only(&text(files, j)).is_some_and(|o| o == own.render().unwrap_or_default().as_str())).unwrap_or(acc);
		adds.push((last, l.clone()));
		gone.insert(t);
	}
	let n = adds.len();
	for (k, l) in sets {
		let (f, i) = at[k];
		files[f].1[i] = l;
	}
	// (Deletions and insertions back to front, by flat index; an insertion after a line before a deletion.)
	let mut edits: Vec<(usize, Option<String>)> = adds.into_iter().map(|(k, l)| (k, Some(l))).collect();
	edits.extend(gone.into_iter().map(|k| (k, None)));
	edits.sort_by(|a, b| b.0.cmp(&a.0).then(b.1.is_some().cmp(&a.1.is_some())));
	for (k, l) in edits {
		let (f, i) = at[k];
		match l {
			Some(l) => files[f].1.insert(i + 1, l),
			None => {
				files[f].1.remove(i);
			}
		}
	}
	n
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn work_of_a_quest_handed_in_already_goes() {
		// Rev15 R3: Westfall's Moonbrook step still collected Red Leather Bandanas after Sentinel Hill's
		// hand-in of 153.
		let mut f =
			vec!["guide g\n\nstep Defias\n  collect 829 quest 153\n\nstep Hill\n  turnin 153\n\nstep Moonbrook\n  collect 829 quest 153\n  kill 590 quest 13\n\nstep Farm\n  collect 829 quest 153\n"
				.to_string()];
		work_after_turnin(&mut f);
		assert_eq!(f[0].matches("collect 829").count(), 1, "{}", f[0]);
		assert!(f[0].contains("kill 590 quest 13") && !f[0].contains("step Farm"), "{}", f[0]);
	}

	fn lines(s: &[&str]) -> Vec<String> {
		s.iter().map(|x| x.to_string()).collect()
	}

	#[test]
	fn a_class_trained_once_in_a_town_visit_is_not_trained_again_there() {
		// c17 Tauren, Thunder Bluff at 12: the route's stop trained the Shamans, then v1's Spirit Rise
		// step trained them again later in the same visit; Turak's step did the same for the Druids.
		let mut f = vec![[
			"step Class trainer\n  only Shaman\n  zone Thunder Bluff\n  train class only Shaman",
			"step Eyahn\n  zone Thunder Bluff\n  turnin 744",
			"step Class trainer\n  only Druid\n  train class only Druid",
			"step Spirit Rise\n  only Shaman\n  zone Thunder Bluff\n  train class only Shaman",
			"step Turak\n  only Druid\n  zone Thunder Bluff\n  turnin 5926\n  train class only Druid",
			"step Fly\n  zone Thunder Bluff\n  fly \"Crossroads\"\n  zone The Barrens",
			"step Crossroads trainer\n  only Shaman\n  train class only Shaman",
		]
		.join("\n\n")];
		repeat_training(&mut f);
		assert_eq!(f[0].matches("train class only Shaman").count(), 2, "{}", f[0]);
		assert!(!f[0].contains("step Spirit Rise") && f[0].contains("step Turak\n  only Druid\n  zone Thunder Bluff\n  turnin 5926\n"), "{}", f[0]);
		assert_eq!(f[0].matches("train class only Druid").count(), 1, "{}", f[0]);
	}

	#[test]
	fn the_step_after_a_class_step_reads_where_the_flight_before_landed() {
		// c15 (28): after the route's flight from Orgrimmar to Thunder Bluff and the Druids' and Paladins'
		// training, Rumstag's step named Orgrimmar, the flight step's first zone.
		let mut f = vec!["guide g\nzone Eastern Plaguelands\n\nstep Fly to Thunder Bluff\n  zone Orgrimmar\n  goto 45.3,63.7 \"Orgrimmar flight master\"\n  fly \"Thunder Bluff\"\n  zone Thunder Bluff\n\nstep Train\n  zone Thunder Bluff\n  train class only Druid,Paladin\n\nstep Rumstag\n  turnin 7820\n".to_string()];
		class_only_steps(&mut f);
		assert!(f[0].contains("step Rumstag\n  turnin 7820") && !f[0].contains("zone Orgrimmar\n  turnin"), "{}", f[0]);
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
	fn an_item_hand_in_moved_after_its_item_takes_its_follow_up_along() {
		// c16 Horde Hinterlands: Another Message to the Wildhammer (7842) handed in after its feathers
		// left The Final Message (7843, pre 7842) accepted before it (not-ready on every start).
		let mut data = Data::default();
		data.quests.insert(7842, serde_json::from_value(serde_json::json!({ "objectives": [{ "type": "item", "id": 4589 }] })).unwrap());
		data.quests.insert(7843, serde_json::from_value(serde_json::json!({ "pre": [7842] })).unwrap());
		let world: World = serde_json::from_value(serde_json::json!({ "points": [], "quests": [] })).unwrap();
		let mut files =
			vec!["guide a\n\nstep Revantusk Village\n  accept 7842\n  turnin 7842\n  turnin 7844\n  accept 7843\n\nstep Feathers\n  collect 4589 x10 quest 7842\n\nstep Aerie Peak\n  complete 7843\n"
				.to_string()];
		fix_item_turnins(&mut files, &data, &world, &|_, _| true, &FxHashSet::default(), &[7843].into_iter().collect());
		let f = &files[0];
		let at = |s: &str| f.find(s).unwrap();
		assert!(at("collect 4589") < at("turnin 7842") && at("turnin 7842") < at("accept 7843") && at("turnin 7844") < at("collect 4589"), "{f}");
		// (A follow-up whose own hand-in is written before where the hand-in goes stays: Test of
		// Strength's, c16 Ashenvale.)
		data.quests.insert(1150, serde_json::from_value(serde_json::json!({ "objectives": [{ "type": "item", "id": 5843 }] })).unwrap());
		data.quests.insert(1151, serde_json::from_value(serde_json::json!({ "pre": [1150] })).unwrap());
		let mut files = vec!["guide a\n\nstep Dorn\n  turnin 1150\n  accept 1151\n\nstep Rok'Alim\n  turnin 1151\n\nstep Den\n  collect 5843 quest 1150\n".to_string()];
		fix_item_turnins(&mut files, &data, &world, &|_, _| true, &FxHashSet::default(), &[1151].into_iter().collect());
		let f = &files[0];
		let at = |s: &str| f.find(s).unwrap();
		assert!(at("accept 1151") < at("turnin 1151") && at("collect 5843") < at("turnin 1150"), "{f}");
	}

	#[test]
	fn a_quest_taken_inside_its_parent_stays_before_the_parents_hand_in() {
		// c16 Stranglethorn: Chapter I-IV (339-342) are offered while The Green Hills of Stranglethorn
		// (338) is in the log, their books its objectives; the data lists 338 in their `pre` and as
		// their `parent`. They went after 338's hand-in (not-ready on every Alliance start).
		let mut data = Data::default();
		data.quests.insert(339, serde_json::from_value(serde_json::json!({ "pre": [338], "parent": 338 })).unwrap());
		let mut files = vec!["step Barnil\n  accept 338\n  accept 339\n\nstep Pages\n  complete 339\n\nstep Barnil\n  turnin 339\n  turnin 338".to_string()];
		let before = files[0].clone();
		let moved = prereq_order(&mut files, &data, &FxHashSet::default(), &|_, _| true);
		assert!(moved.is_empty() && files[0] == before, "{files:#?}");
	}

	#[test]
	fn a_class_quest_waiting_for_its_prerequisite_goes_after_everyones_lines_at_that_npc() {
		// c17 Barrens: the Warlocks' Ken'zigla trip (1510, pre 1509) went between Darsok's hand-in of
		// 876 at the Crossroads and his accept of 1060, which then read on Orgrimmar's map (the flight
		// step's first zone): back to Darsok after the trip (dup-trip), 4921's spot 4850 yd off.
		let mut data = Data::default();
		data.quests.insert(1510, serde_json::from_value(serde_json::json!({ "pre": [1509], "start": { "npc": [3337] } })).unwrap());
		data.quests.insert(876, serde_json::from_value(serde_json::json!({ "end": { "npc": [3449] } })).unwrap());
		data.quests.insert(1060, serde_json::from_value(serde_json::json!({ "start": { "npc": [3449] } })).unwrap());
		let mut files = vec![[
			"step Gazrog\n  only Warlock\n  zone The Barrens\n  level 20 only Warlock\n  accept 1510",
			"step Fly to Crossroads\n  zone Orgrimmar\n  fly \"Crossroads\"\n  zone The Barrens",
			"step the Crossroads\n  turnin 876\n  turnin 1509 only Warlock",
			"step Darsok Swiftdagger\n  accept 1060",
			"step Southern Barrens\n  goto 49.3,50.3",
		]
		.join("\n\n")];
		prereq_order(&mut files, &data, &FxHashSet::default(), &|_, _| true);
		let f = &files[0];
		let at = |s: &str| f.find(s).unwrap();
		assert!(at("accept 1060") < at("accept 1510") && at("turnin 1509") < at("accept 1510"), "{f}");
		assert!(!f.contains("zone Orgrimmar\n  accept") && !f.contains("zone Orgrimmar\n  goto 49.3"), "{f}");
		// (Its level gate goes with it: no empty Warlock step left behind.)
		assert!(at("level 20") > at("turnin 1509") && f.matches("step Gazrog").count() == 1, "{f}");
	}

	#[test]
	fn a_class_hearths_back_to_the_inn_only_that_class_binds_at() {
		// c14 Tauren: the Druids bind at Thunder Bluff before Teleport: Moonglade; their hearth back
		// was dropped as one the route is not bound for (R1: Moonglade to Thunder Bluff, no travel line).
		let mut files = vec![[
			"step Bloodhoof\n  sethome \"Bloodhoof Village\"\n  accept 1",
			"step Turak\n  only Druid\n  sethome \"Thunder Bluff\" npc 6746 only Druid\n  accept 5926",
			"step Back\n  only Druid\n  hearth \"Thunder Bluff\" only Druid\n  turnin 5932",
			"step Warrior\n  only Warrior\n  hearth \"Thunder Bluff\"\n  accept 2",
		]
		.join("\n\n")];
		fix_hearths(&mut files, &["Tauren".to_string()], &[], &[false]);
		assert!(files[0].contains("step Back\n  only Druid\n  hearth \"Thunder Bluff\" only Druid\n"), "{}", files[0]);
		// (A class not bound there still loses it.)
		assert!(files[0].contains("step Warrior\n  only Warrior\n  accept 2"), "{}", files[0]);
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
			"step Sepulcher",
			"  accept 1",
			"",
			"step Tirisfal Glades",
			"  only Priest",
			"  goto 60.7,58.9 \"Tirisfal Glades\"",
			"",
			"step Zeppelin to Orgrimmar",
			"  only Priest",
			"  goto 60.7,58.9 \"Zeppelin to Orgrimmar\"",
			"",
			"step Orgrimmar class quests",
			"  only Priest",
			"  zone Orgrimmar",
			"  turnin 5654 only Troll,Priest",
			"",
			"step Sepulcher",
			"  accept 2",
		]);
		let out = class_trip_audience(g);
		assert_eq!(out.iter().filter(|l| *l == "  only Troll,Priest").count(), 3, "{out:#?}");
		assert!(!out.iter().any(|l| l == "  only Priest"), "{out:#?}");
	}

	#[test]
	fn the_way_into_a_hand_in_for_quest_holders_goes_into_its_step() {
		// c14 Silithus: the route's walk from Talrendis Point into Ashenvale, then Forest Song for those
		// who hold 4261: everyone else walked out and back.
		let g = lines(&[
			"step Fly to Talrendis Point",
			"  fly \"Talrendis Point\"",
			"",
			"step Ashenvale",
			"  zone Ashenvale",
			"  goto 85.2,44.7 \"Ashenvale\"",
			"",
			"step Talrendis Point",
			"  zone Azshara",
			"  goto 11.9,77.5 \"Talrendis Point\"",
			"",
			"step Forest Song",
			"  when onquest 4261",
			"  zone Ashenvale",
			"  turnin 4261",
			"",
			"step Everlook",
			"  fly \"Everlook\"",
		]);
		let out = onquest_way_in(g);
		assert!(!out.iter().any(|l| l == "step Ashenvale"), "{out:#?}");
		let s = out.iter().position(|l| l == "step Forest Song").unwrap();
		assert_eq!(out[s + 3], "  goto 85.2,44.7 \"Ashenvale\"", "{out:#?}");
	}

	#[test]
	fn a_class_detour_hands_in_what_it_stands_beside() {
		// c14 Durotar: the Orc Warlocks' trip to Gan'rul in the Cleft of Shadow stood beside Neeru
		// Fireblade with 832 in their bags; the guide handed it in on a later visit.
		let world: World = serde_json::from_value(serde_json::json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 5000, 0, 1454], [1, 1, 5040, 0, 1454]],
			"quests": [{ "id": 832, "giver": 0, "ender": 2 }, { "id": 1501, "giver": 1, "ender": 1 }]
		}))
		.unwrap();
		let a = lines(&["guide a", "", "step Skull Rock", "  accept 832", "", "step The Binding", "  only Warlock", "  turnin 1501", "", "step Margoz", "  accept 9"]);
		let b = lines(&["guide b", "", "step Valley of Strength", "  zone Orgrimmar", "  turnin 832 only Orc,Troll -- Neeru", ""]);
		let mut files = vec![("a".to_string(), a), ("b".to_string(), b)];
		assert_eq!(detour_hand_ins(&mut files, &world), 1);
		let w = files[0].1.iter().position(|l| l == "  turnin 1501").unwrap();
		assert_eq!(files[0].1[w + 1], "  turnin 832 only Orc,Troll -- Neeru");
		assert_eq!(files[1].1[4], "  turnin 832 only Orc,Troll,!Warlock -- Neeru");
	}

	#[test]
	fn a_class_hand_in_beside_where_the_class_took_it_is_handed_in_there() {
		// c14 Zephras Isle (Horde): the Rogues' Simple Note from Rorian, for Akeri in the watchtower beside
		// him, was handed in at the next Thendal visit, after the standing stones.
		let world: World = serde_json::from_value(serde_json::json!({
			"points": [[1, 1, 0, 0, 1411], [1, 1, 90, 0, 1411], [1, 1, 3000, 0, 1411]],
			"quests": [{ "id": 1, "giver": 0, "ender": 0 }, { "id": 7, "giver": 0, "ender": 1 }, { "id": 2, "giver": 2, "ender": 2 }]
		}))
		.unwrap();
		let a = lines(&["guide a", "", "step Rorian", "  accept 1", "  accept 7 only Rogue", "", "step Stones", "  accept 2", "", "step Thendal", "  turnin 1", "  turnin 7 only Rogue -- Akeri", ""]);
		let mut files = vec![("a".to_string(), a)];
		assert_eq!(detour_hand_ins(&mut files, &world), 1);
		let g = &files[0].1;
		let acc = g.iter().position(|l| l == "  accept 7 only Rogue").unwrap();
		assert_eq!(g[acc + 1], "  turnin 7 only Rogue -- Akeri", "{g:#?}");
		assert_eq!(g.iter().filter(|l| l.starts_with("  turnin 7")).count(), 1, "{g:#?}");
	}

	#[test]
	fn a_ride_for_everyone_goes_after_the_towns_last_step() {
		// c14 Gnome: Gryth Thurden's flight path written after the Deeprun Tram goto: the tram line was
		// behind everyone, who were back in Ironforge.
		let g = lines(&[
			"step The Deeprun Tram",
			"  zone Ironforge",
			"  turnin 97263 optional",
			"  goto 78.0,51.4 \"Deeprun Tram\"",
			"",
			"step Gryth Thurden",
			"  turnin 6388",
			"  getfp \"Ironforge\"",
			"",
			"step Westfall",
			"  zone Westfall",
			"  goto 59.9,19.4 \"Westfall\"",
		]);
		let out = ride_last_in_town(g);
		let tram = out.iter().position(|l| l.contains("Deeprun Tram\"")).unwrap();
		assert!(tram > out.iter().position(|l| l.starts_with("  getfp")).unwrap() && tram < out.iter().position(|l| l == "step Westfall").unwrap(), "{out:#?}");
	}

	#[test]
	fn a_class_trip_with_nothing_to_do_goes() {
		// FlowDiag 1: the Warlocks fly Ratchet -> Orgrimmar -> Ratchet with their class step held for
		// later; the Priests' trip has Ur'kyo between and stays.
		let g = lines(&[
			"step Ratchet",
			"  turnin 1",
			"",
			"step Fly to Orgrimmar",
			"  only Warlock",
			"  goto 63.1,37.1 \"Ratchet flight master\"",
			"  fly \"Orgrimmar\"",
			"",
			"step Fly to Orgrimmar",
			"  only Priest",
			"  goto 63.1,37.1 \"Ratchet flight master\"",
			"  fly \"Orgrimmar\"",
			"",
			"step Ur'kyo",
			"  only Priest",
			"  accept 5680",
			"",
			"step Back to Ratchet",
			"  only Warlock",
			"  goto 45.3,63.7 \"Orgrimmar flight master\"",
			"  fly \"Ratchet\"",
			"",
			"step Back to Ratchet",
			"  only Priest",
			"  goto 45.3,63.7 \"Orgrimmar flight master\"",
			"  fly \"Ratchet\"",
			"",
			"step Ratchet",
			"  accept 2",
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

	#[test]
	fn hand_ins_go_before_a_level_gate_for_class_accepts() {
		// c14 Razor Hill (Rev14OrcTroll A1): `level 10 only Warrior`, the class accepts, then Gar'Thok's and
		// Cook Torka's hand-ins, whose experience is what reaches 10. The hand-ins first.
		let mut f = vec!["guide t/a\n\nstep Razor Hill\n  accept 837\n  level 10 only Warrior\n  accept 1505 only Warrior\n  level 10 only Shaman\n  accept 2983 only Shaman\n  turnin 825\n  accept 9\n  turnin 9\n  turnin 815\n\nstep Next\n  level 12\n  turnin 7\n".to_string()];
		hand_ins_before_level_gate(&mut f);
		assert_eq!(
			f[0],
			"guide t/a\n\nstep Razor Hill\n  accept 837\n  turnin 825\n  turnin 815\n  level 10 only Warrior\n  accept 1505 only Warrior\n  level 10 only Shaman\n  accept 2983 only Shaman\n  accept 9\n  turnin 9\n\nstep Next\n  level 12\n  turnin 7\n"
		);
	}

	#[test]
	fn a_class_detour_hands_in_a_quest_once() {
		// c14 Orc 04-the-barrens (Rev14H1 A2): the Warlocks' two steps at Gazrog, beside Darsok, each
		// handed in 876.
		let world: World = serde_json::from_value(serde_json::json!({
			"points": [[1, 1, 0, 0, 1413], [1, 1, 5000, 0, 1413], [1, 1, 5040, 0, 1413]],
			"quests": [{ "id": 876, "giver": 0, "ender": 2 }, { "id": 1509, "giver": 1, "ender": 1 }, { "id": 1510, "giver": 1, "ender": 1 }]
		}))
		.unwrap();
		let a = lines(&[
			"guide a",
			"",
			"step Crossroads",
			"  accept 876",
			"",
			"step Gazrog",
			"  only Warlock",
			"  turnin 1509",
			"",
			"step Gazrog again",
			"  only Warlock",
			"  accept 1510",
			"",
			"step Later",
			"  turnin 876 -- Darsok",
			"",
		]);
		let mut files = vec![("a".to_string(), a)];
		detour_hand_ins(&mut files, &world);
		assert_eq!(files[0].1.iter().filter(|l| l.starts_with("  turnin 876")).count(), 2, "{:#?}", files[0].1);
	}

	#[test]
	fn an_item_hand_in_in_another_zone_waits_for_the_next_pass_there() {
		// c14 Horde 07-ashenvale ((12a)): the Shamans' Call of Water to Brine, south of Camp Taurajo, moved
		// to right after the Ashenvale fountain that fills the waterskin, a trip to the Barrens; the chain
		// passes the Barrens a little later anyway.
		let q: crate::input::Quest = serde_json::from_value(serde_json::json!({ "objectives": [{ "type": "item", "id": 7770 }] })).unwrap();
		let mut data = Data::default();
		data.quests.insert(1534, q);
		let world: World = serde_json::from_value(serde_json::json!({ "points": [], "quests": [] })).unwrap();
		let mut files = vec![
			"guide a\n\nstep Brine\n  only Shaman\n  zone The Barrens\n  turnin 1534\n\nstep Fountain\n  only Shaman\n  zone Ashenvale\n  collect 7770 quest 1534.1\n\nstep Camp\n  accept 5\n\nstep Taurajo\n  zone The Barrens\n  turnin 6\n".to_string(),
		];
		fix_item_turnins(&mut files, &data, &world, &|_, _| true, &FxHashSet::default(), &FxHashSet::default());
		let f = &files[0];
		assert!(f.find("turnin 1534").unwrap() > f.find("turnin 6").unwrap(), "{f}");
	}

	#[test]
	fn a_use_of_the_item_a_quest_gives_goes_after_its_accept() {
		// c15 Orc: The Binding's lines moved after the Ken'zigla chain into the Stonetalon guide; `use 6626`
		// (Dogran's Pendant, given by 1513) stayed in the Barrens guide, before the pendant is in the bags.
		let r: crate::input::Quest = serde_json::from_value(serde_json::json!({ "sourceItem": 6626 })).unwrap();
		let mut data = Data::default();
		data.quests.insert(1513, r);
		let mut files = vec![
			"guide a\n\nstep The Binding\n  only Warlock\n  use 6626 @49.4,50.0 -- Dogran's Pendant\n\nstep Camp\n  accept 5\n".to_string(),
			"guide b\n\nstep The Binding\n  only Warlock\n  accept 1513\n  kill 5677 quest 1513.1\n  turnin 1513\n".to_string(),
		];
		source_item_uses(&mut files, &data, &|_, _| true);
		assert_eq!(files[0], "guide a\n\nstep Camp\n  accept 5\n");
		assert_eq!(files[1], "guide b\n\nstep The Binding\n  only Warlock\n  accept 1513\n  use 6626 @49.4,50.0 -- Dogran's Pendant\n  kill 5677 quest 1513.1\n  turnin 1513\n");
	}

	#[test]
	fn a_hand_in_before_its_accept_goes_to_the_next_step_by_its_ender() {
		// c15 Horde 04-the-barrens (Rev15H1): Sorek's 1823 taken at the Orgrimmar training, Ruga's
		// hand-in (Camp Taurajo) written right after it, a flight there and back; and Islen's 1528 for
		// the Shamans. They go to the route's next step by their ender, with their step's `only`.
		let pt = |x: f64| crate::input::Pt { c: 1, wx: x, wy: 0.0, map: 1413 };
		let place = |l: &str| -> Vec<crate::input::Pt> {
			if head_ws(l) == Some("accept") {
				return vec![pt(-8000.0)];
			}
			match quest_of(l) {
				Some(1823 | 882) => vec![pt(0.0)],
				Some(1528) => vec![pt(5000.0)],
				Some(5) => vec![pt(9000.0)],
				_ => Vec::new(),
			}
		};
		let mut files = vec![
			"guide a\n\nstep Camp Taurajo\n  turnin 1823 only Warrior\n\nstep Islen\n  only Shaman\n  turnin 1528\n\nstep Orgrimmar\n  accept 5\n  accept 1823 only Warrior\n  accept 1528 only Shaman\n\nstep Camp Taurajo\n  turnin 882\n".to_string(),
		];
		fix_order(&mut files, &[5, 882].into_iter().collect(), &|_, _| true, &place);
		let first = files[0].clone();
		// The Tauren Shamans' Telf 1525 (Rev15SkyH): an Orc guide's hand-in `only Shaman` moved after the
		// shared accept for Tauren Shamans takes that audience, and none is added where one follows.
		let mut tel =
			vec!["guide o\n\nstep Telf\n  only Shaman\n  turnin 1525\n".to_string(), "guide s\n\nstep Telf\n  only Tauren,Shaman\n  accept 1525 only Tauren\n\nstep Away\n  accept 5\n".to_string()];
		fix_order(&mut tel, &[5].into_iter().collect(), &|_, _| true, &|_: &str| Vec::new());
		assert_eq!(tel[1], "guide s\n\nstep Telf\n  only Tauren,Shaman\n  accept 1525 only Tauren\n  turnin 1525 only Tauren,Shaman\n\nstep Away\n  accept 5\n");
		let mut tel2 = vec!["guide o\n\nstep Telf\n  only Shaman\n  turnin 1525\n".to_string(), "guide s\n\nstep Telf\n  only Tauren,Shaman\n  accept 1525\n  turnin 1525\n".to_string()];
		fix_order(&mut tel2, &[].into_iter().collect(), &|_, _| true, &|_: &str| Vec::new());
		assert_eq!(tel2[1], "guide s\n\nstep Telf\n  only Tauren,Shaman\n  accept 1525\n  turnin 1525\n");
		assert!(!tel2[0].contains("1525"), "{}", tel2[0]);
		assert_eq!(
			first,
			"guide a\n\nstep Orgrimmar\n  accept 5\n  accept 1823 only Warrior\n  accept 1528 only Shaman\n  turnin 1528 only Shaman\n\nstep Camp Taurajo\n  turnin 882\n  turnin 1823 only Warrior\n"
		);
	}

	#[test]
	fn an_optional_hand_in_with_no_later_stop_by_its_ender_is_not_written() {
		// c17 Horde 04-tanaris: Rescue OOX-17/TN!'s optional hand-in (Oglethorpe, Booty Bay) landed
		// before its accept and went right after it: a flight to Booty Bay and back from Tanaris for a
		// rare beacon's escort, the escort's `complete` after the hand-in (R5). With no later stop by
		// the ender it goes; with one, it goes there (OOX-22/FE in c17's Feralas Booty Bay stop).
		let pt = |x: f64| crate::input::Pt { c: 1, wx: x, wy: 0.0, map: 1446 };
		let place = |l: &str| -> Vec<crate::input::Pt> {
			match (head_ws(l), quest_of(l)) {
				(Some("turnin"), Some(648 | 2767)) => vec![pt(9000.0)],
				(Some("turnin"), Some(5)) => vec![pt(9000.0)],
				_ => vec![pt(0.0)],
			}
		};
		let mut files = vec![
			"guide bb\n\nstep Booty Bay\n  turnin 648 optional\n  turnin 2767 optional\n".to_string(),
			"guide t\n\nstep OOX\n  accept 648 optional\n  complete 648 optional\n  accept 2767 optional\n\nstep Gadgetzan\n  accept 7\n".to_string(),
		];
		let mut later = files.clone();
		fix_order(&mut files, &[7].into_iter().collect(), &|_, _| true, &place);
		// (The quest's other lines go too: no accept left open, no escort for a reward never collected.)
		assert!(!files.concat().contains(" 648") && !files.concat().contains(" 2767"), "{files:?}");
		assert!(files[1].ends_with("step Gadgetzan\n  accept 7\n"), "{files:?}");
		later.push("guide f\n\nstep Booty Bay\n  turnin 5\n".to_string());
		fix_order(&mut later, &[7, 5].into_iter().collect(), &|_, _| true, &place);
		assert_eq!(later[2], "guide f\n\nstep Booty Bay\n  turnin 5\n  turnin 648 optional\n  turnin 2767 optional\n");
	}

	#[test]
	fn a_step_for_a_quest_not_yet_taken_goes_after_its_accept_near_its_place() {
		// c15 Horde (Rev15H1): the Druids' Strange Lockbox (`collect 15883`, the Half Pendant, a quest
		// item of Trial of the Sea Lion, 30) at 15.5, before the Moonglade accept; and a seed step `when
		// onquest 30` placed there too. Both go after the accept, to the Sludge Fen pass.
		let pt = |x: f64| crate::input::Pt { c: 1, wx: x, wy: 0.0, map: 1413 };
		let place = |l: &str| -> Vec<crate::input::Pt> {
			if l.contains("collect 15883") || l.contains("accept 858") {
				vec![pt(0.0)]
			} else if l.contains("accept 30") {
				vec![pt(9000.0)]
			} else {
				Vec::new()
			}
		};
		let item_quest: FxHashMap<u32, u32> = [(15883, 30)].into_iter().collect();
		let mut files = vec![
			"guide a\n\nstep Strange Lockbox\n  only Tauren,Druid\n  collect 15883\n\nstep Camp\n  accept 5\n".to_string(),
			"guide b\n\nstep Gated\n  when onquest 30\n  goto 1,1\n\nstep Moonglade\n  only Druid\n  accept 30\n\nstep Ignition\n  accept 858\n".to_string(),
		];
		steps_after_their_quest(&mut files, &[5, 858].into_iter().collect(), &item_quest, &|_, _| true, &place, 600.0);
		assert_eq!(files[0], "guide a\n\nstep Camp\n  accept 5\n");
		assert_eq!(files[1], "guide b\n\nstep Moonglade\n  only Druid\n  accept 30\n\nstep Gated\n  when onquest 30\n  goto 1,1\n\nstep Ignition\n  accept 858\n\nstep Strange Lockbox\n  only Tauren,Druid\n  collect 15883\n");
	}

	#[test]
	fn a_riding_lesson_holds_from_level_40() {
		// c19 Orc 40-50/02-feralas:99: the Orgrimmar riding step at about 38 told the player to learn
		// riding from Kildar, who cannot teach them yet (Rev19-H A1).
		let mut data = Data::default();
		data.npcs.insert(4752, serde_json::from_value(serde_json::json!({ "name": "Kildar", "subName": "Wolf Riding Instructor" })).unwrap());
		data.npcs.insert(3353, serde_json::from_value(serde_json::json!({ "name": "Grezz Ragefist", "subName": "Warrior Trainer" })).unwrap());
		let mut files = vec![
			"guide a\n\nstep Riding at 40\n  only Orc\n  zone Orgrimmar\n  tip Riding needs level 40.\n  train 4752 optional -- Kildar\n  note \"Wolves\"\n\nstep Grezz\n  zone Orgrimmar\n  train 3353\n  accept 1718\n  train 4752 optional only Orc -- Kildar\n\nstep Fly\n  fly \"Crossroads\"".to_string(),
		];
		riding_at_level(&mut files, &data);
		assert_eq!(
			files[0],
			"guide a\n\nstep Riding at 40\n  only Orc\n  zone Orgrimmar\n  when level>=40\n  tip Riding needs level 40.\n  train 4752 optional -- Kildar\n  note \"Wolves\"\n\nstep Grezz\n  zone Orgrimmar\n  train 3353\n  accept 1718\n\nstep Riding at 40\n  zone Orgrimmar\n  when level>=40\n  train 4752 optional only Orc -- Kildar\n\nstep Fly\n  fly \"Crossroads\""
		);
		// (Already gated: as it is.)
		let again = files.clone();
		riding_at_level(&mut files, &data);
		assert_eq!(files, again);
	}

	#[test]
	fn a_riding_step_with_notes_alone_holds_from_level_40() {
		// c19 Skyborne (Alliance 40-50/01-stranglethorn-vale): their riding trainer is on Zephras Isle, so
		// their riding step is only its tip and notes; it too came at the route's riding stop.
		let mut files = vec!["guide a\n\nstep Riding at 40\n  only Skyborne\n  zone Elwynn Forest\n  tip Genn.\n  note \"Genn\"\n\nstep Other\n  note \"x\"".to_string()];
		riding_at_level(&mut files, &Data::default());
		assert_eq!(files[0], "guide a\n\nstep Riding at 40\n  only Skyborne\n  zone Elwynn Forest\n  when level>=40\n  tip Genn.\n  note \"Genn\"\n\nstep Other\n  note \"x\"");
	}

	#[test]
	fn the_trip_to_a_riding_step_holds_from_level_40_too() {
		// c19 Troll 40-50/01-stranglethorn-vale: the Trolls' flight to Booty Bay and boat to Ratchet for
		// Xar'Ti in Sen'jin Village, and back, around their riding step; with the step gated alone, a
		// Troll under 40 made the trip for nothing (and one at 40 had no way there if the repair, which
		// skips a step that does not apply, wrote none).
		let mut data = Data::default();
		data.npcs.insert(7953, serde_json::from_value(serde_json::json!({ "name": "Xar'Ti", "subName": "Raptor Riding Trainer" })).unwrap());
		let trip = |only: &str| {
			format!("guide a\n\nstep Crocs\n  collect 6169 quest 698.1\n\nstep Fly to Booty Bay\n  only Troll\n  zone Swamp of Sorrows\n  goto 46.0,54.7 \"Stonard flight master\"\n  fly \"Booty Bay\"\n\nstep Riding at 40\n  only Troll\n  zone Durotar\n  train 7953 optional\n\nstep Fly to Stonard\n  only Troll\n  zone Stranglethorn Vale\n  fly \"Stonard\"\n\nstep Next\n{only}  kill 5477")
		};
		let mut files = vec![trip("")];
		riding_at_level(&mut files, &data);
		assert_eq!(files[0], "guide a\n\nstep Crocs\n  collect 6169 quest 698.1\n\nstep Fly to Booty Bay\n  only Troll\n  zone Swamp of Sorrows\n  when level>=40\n  goto 46.0,54.7 \"Stonard flight master\"\n  fly \"Booty Bay\"\n\nstep Riding at 40\n  only Troll\n  zone Durotar\n  when level>=40\n  train 7953 optional\n\nstep Fly to Stonard\n  only Troll\n  zone Stranglethorn Vale\n  when level>=40\n  fly \"Stonard\"\n\nstep Next\n  kill 5477");
		// (A trip that goes on to more of theirs: only the riding step.)
		let mut files = vec![trip("  only Troll\n")];
		riding_at_level(&mut files, &data);
		assert_eq!(files[0].matches("when level>=40").count(), 1, "{}", files[0]);
		// (A way back for some of their classes, the Troll Druids' (`only Troll,Druid`, the Undead
		// Paladins' from Brill): theirs too, gated.)
		let mut files = vec![trip("").replace("step Fly to Stonard\n  only Troll", "step Fly to Stonard\n  only Troll,Druid")];
		riding_at_level(&mut files, &data);
		assert_eq!(files[0].matches("when level>=40").count(), 3, "{}", files[0]);
		// (A way back shared with another race: the trip is not theirs alone, and the riding step gated
		// alone left them where the way there ends for the next way, made for the trainer's spot. Left
		// as it was.)
		let mut files = vec![trip("").replace("step Fly to Stonard\n  only Troll", "step Fly to Stonard\n  only Troll,Orc")];
		let was = files[0].clone();
		riding_at_level(&mut files, &data);
		assert_eq!(files[0], was);
	}

	#[test]
	fn a_riding_trips_way_back_past_others_steps_or_none_is_gated_with_it() {
		// c19p Horde 40-50/02-feralas: the Taurens' flight to Thunder Bluff and walk to Bloodhoof Village,
		// their riding step, the Undead's and the Druids' trips, then the Taurens' flight back to
		// Gadgetzan: the riding step was left ungated with a way back further on.
		let mut data = Data::default();
		data.npcs.insert(3690, serde_json::from_value(serde_json::json!({ "name": "Kar Stormsinger", "subName": "Kodo Riding Instructor" })).unwrap());
		data.npcs.insert(4732, serde_json::from_value(serde_json::json!({ "name": "Randal Hunter", "subName": "Horse Riding Instructor" })).unwrap());
		data.npcs.insert(7954, serde_json::from_value(serde_json::json!({ "name": "Binjy Featherwhistle", "subName": "Mechanostrider Pilot" })).unwrap());
		let tauren = "guide a\n\nstep Fly to Thunder Bluff\n  only Tauren\n  zone Tanaris\n  fly \"Thunder Bluff\"\n\nstep Mulgore\n  only Tauren\n  zone Mulgore\n  goto 46.8,62.0 \"Mulgore\"\n\nstep Riding at 40\n  only Tauren\n  zone Mulgore\n  train 3690 optional\n\nstep Thunder Bluff\n  only Druid,Paladin\n  zone Thunder Bluff\n  fly \"Thunder Bluff\"\n  train class\n\nstep Fly to Gadgetzan\n  only Tauren\n  zone Thunder Bluff\n  fly \"Gadgetzan\"\n\nstep Next\n  kill 5477";
		let mut files = vec![tauren.to_string()];
		riding_at_level(&mut files, &data);
		assert_eq!(files[0].matches("when level>=40").count(), 4, "{}", files[0]);
		assert!(files[0].contains("step Thunder Bluff\n  only Druid,Paladin\n  zone Thunder Bluff\n  fly"), "{}", files[0]);
		// (No way back: the next step is everyone's, the Humans' walk to Eastvale before everyone's way
		// into Deadwind Pass; the Gnomes' Binjy too.)
		for (npc, race) in [(4732, "Human"), (7954, "Gnome")] {
			let mut files = vec![format!("guide a\n\nstep Elwynn Forest\n  only {race}\n  zone Elwynn Forest\n  goto 84.6,64.5 \"Elwynn Forest\"\n\nstep Riding at 40\n  only {race}\n  zone Elwynn Forest\n  train {npc} optional\n\nstep Into Deadwind Pass\n  zone Deadwind Pass\n  goto 33.1,36.0 \"Into Deadwind Pass\"")];
			riding_at_level(&mut files, &data);
			assert_eq!(files[0].matches("when level>=40").count(), 2, "{}", files[0]);
		}
	}

	#[test]
	fn the_route_fixes_optional_quests_are_written_optional() {
		// c19p: v1's `accept 338` (The Green Hills of Stranglethorn) and `accept 712` (Study of the
		// Elements: Rock) required rare-drop chains the route fixes keep optional.
		let mut files = vec!["guide a\n\nstep Nesingwary\n  accept 185\n  accept 338                          -- Barnil Stonepot\n\nstep Pages\n  complete 339                        -- Chapter I\n  collect 4628 quest 712 optional\n  turnin 712 only Orc".to_string()];
		let optional: FxHashSet<u32> = [338, 339, 712].into_iter().collect();
		optional_by_fixes(&mut files, &optional);
		// (The hand-in as written: it applies only with the quest done.)
		assert_eq!(files[0], "guide a\n\nstep Nesingwary\n  accept 185\n  accept 338 optional                 -- Barnil Stonepot\n\nstep Pages\n  complete 339 optional               -- Chapter I\n  collect 4628 quest 712 optional\n  turnin 712 only Orc");
	}
}
