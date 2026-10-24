//! The route order's fixes before writing (timed items, item-started accepts) and the passes
//! over the written guides (accepts before their work, item turn-ins after their items,
//! hearths the route is not bound for, travel lines per audience, riding words).

use crate::apply::{line_only, qkey, quest_of, ALL_RACES};
use crate::guide::{is_goal, Key, Step};
use crate::input::{Data, Order, OrderT, World};
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
		}
		res.push(out[i].clone());
		i += 1;
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
/// and the turn-in of a quest that spends it move to after that turn-in.
pub fn timed_order(order: Vec<Order>, steps: &[Step], named: &FxHashSet<Key>, anchor_of: &FxHashMap<Key, Key>, data: &Data) -> Vec<Order> {
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
