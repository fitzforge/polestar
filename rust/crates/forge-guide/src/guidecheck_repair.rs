//! guidecheck repair: applies [`crate::guidecheck`]'s repairs to one chain's guides, then puts every line
//! after what it needs with a stable topological sort, so the route's order is kept wherever it is already
//! right (docs/ARCHITECTURE.md, `forge guide check`).
//!
//! Repairs (one per failure, the cheapest):
//!   npc / object   name the giver or ender on the line (R4)
//!   source         a step that gets the item before the line: the best dropper's or object's spawn nearest
//!                  the route's point, else a vendor (R2, R3)
//!   whenhas        the accept in its own step after, gated on `when has <item>` (R2)
//!   drop           a quest-only drop's bag count before the quest is held goes (R3)
//!   addgoal        the quest part's goal in a step before the turn-in (R5)
//!   addaccept      the accept in a step before the turn-in
//!   addkb          the knowledge base's step before the turn-in
//!   copy           the later collect copied before the use
//!   move           nothing to write: the order pass moves the line after its producer
//! travel / ride / leaveout are reported, not applied (the writer's travel pass, the route).
//!
//! Order pass: each line that needs something gets an edge from the line that gives it: the nearest
//! earlier one, else the first later one. A step waits for its producers (Kahn's algorithm, by original
//! position); a step caught in a cycle is split into one step per goal, its `when`/`only`/`along` lines copied.

use crate::data::Data;
use crate::guidecheck::{check_files, held_only_item, keys, load_chain, Chain, Fix, Kb, Reported, MAX_MOVE};
use forge_core::jsnum::{js_hypot, js_round, js_to_string};
use rustc_hash::{FxHashMap, FxHashSet};
use std::cmp::Reverse;
use std::collections::BinaryHeap;

const FIXABLE: [&str; 8] = ["itemStart", "useBefore", "bagBefore", "giver", "ender", "objective", "kbStep", "noAccept"];

// ---- the text model -------------------------------------------------------------

#[derive(Clone, Debug)]
struct Chunk {
	li: Option<usize>,
	lines: Vec<String>,
}

#[derive(Clone, Debug)]
struct Unit {
	fi: usize,
	title: String,
	head: Vec<String>,
	chunks: Vec<Chunk>,
	tail: Vec<String>,
	zone_in: Option<String>,
	zone_out: Option<String>,
	/// The step a part of a split step came from (its index in play order).
	from: Option<usize>,
}

#[derive(Clone, Debug)]
struct FileModel {
	file: String,
	header: Vec<String>,
	units: Vec<Unit>,
	zone: Option<String>,
}

fn blank(s: &str) -> bool {
	s.trim().is_empty()
}

fn model_of(chain: &Chain) -> Vec<FileModel> {
	let mut files: Vec<FileModel> = chain
		.files
		.iter()
		.map(|f| {
			let mut header = f.header.clone();
			while header.last().is_some_and(|h| blank(h)) {
				header.pop();
			}
			FileModel { file: f.file.clone(), header, units: Vec::new(), zone: f.zone.clone() }
		})
		.collect();
	for step in &chain.steps {
		let src = &chain.files[step.fi].src;
		let by_line: FxHashMap<usize, usize> = step.goals.iter().map(|&li| (chain.lines[li].line, li)).collect();
		let mut unit =
			Unit { fi: step.fi, title: step.title.clone(), head: Vec::new(), chunks: Vec::new(), tail: Vec::new(), zone_in: step.zone_in.clone(), zone_out: step.zone_out.clone(), from: None };
		let mut pending: Vec<String> = Vec::new();
		let mut seen_goal = false;
		for n in step.src..=step.end {
			let Some(text) = n.checked_sub(1).and_then(|i| src.get(i)) else { continue };
			if let Some(&li) = by_line.get(&n) {
				let mut lines = std::mem::take(&mut pending);
				lines.push(text.clone());
				unit.chunks.push(Chunk { li: Some(li), lines });
				seen_goal = true;
			} else if !seen_goal {
				unit.head.push(text.clone());
			} else {
				pending.push(text.clone());
			}
		}
		while pending.last().is_some_and(|h| blank(h)) {
			pending.pop();
		}
		unit.tail = pending;
		while unit.chunks.is_empty() && unit.head.len() > 1 && unit.head.last().is_some_and(|h| blank(h)) {
			unit.head.pop();
		}
		files[step.fi].units.push(unit);
	}
	files
}

fn unit_text(u: &Unit) -> String {
	let mut lines = u.head.clone();
	while lines.len() > 1 && lines.last().is_some_and(|h| blank(h)) {
		lines.pop();
	}
	for c in &u.chunks {
		lines.extend(c.lines.iter().cloned());
	}
	lines.extend(u.tail.iter().cloned());
	while lines.last().is_some_and(|h| blank(h)) {
		lines.pop();
	}
	lines.join("\n")
}

/// A unit whose zone in differs from the one in effect where it now stands says its zone again.
fn serialize(files: &[FileModel]) -> Vec<(String, String)> {
	files
		.iter()
		.map(|f| {
			let mut cur = f.zone.clone();
			let mut parts = vec![f.header.join("\n")];
			for u in &f.units {
				let mut text = unit_text(u);
				if let Some(z) = u.zone_in.as_ref().filter(|z| Some(*z) != cur.as_ref()) {
					let mut ls: Vec<&str> = text.split('\n').collect();
					let line = format!("  zone {z}");
					ls.insert(1.min(ls.len()), &line);
					text = ls.join("\n");
				}
				cur = u.zone_out.clone().or_else(|| u.zone_in.clone()).or(cur);
				parts.push(text);
			}
			(f.file.clone(), format!("{}\n", parts.join("\n\n")))
		})
		.collect()
}

/// A new step, in the sticky zone of the step it is placed against; a `zone` line of its own changes it.
fn new_unit(fi: usize, title: &str, lines: Vec<String>, zone: Option<String>) -> Unit {
	let own = lines.first().and_then(|l| crate::re!(r"^\s*zone\s+(.+?)\s*$").captures(l).map(|m| m[1].to_string()));
	Unit { fi, title: title.into(), head: vec![format!("step {title}")], chunks: vec![Chunk { li: None, lines }], tail: Vec::new(), zone_out: own.or_else(|| zone.clone()), zone_in: zone, from: None }
}

// ---- repairs on the model ---------------------------------------------------------

fn locate(files: &[FileModel], li: usize) -> Option<(usize, usize, usize)> {
	for (f, fm) in files.iter().enumerate() {
		for (u, unit) in fm.units.iter().enumerate() {
			if let Some(c) = unit.chunks.iter().position(|x| x.li == Some(li)) {
				return Some((f, u, c));
			}
		}
	}
	None
}

fn with_modifier(text: &str, word: &str, id: i64) -> String {
	let (body, note) = match text.find(" -- ") {
		Some(at) => (&text[..at], &text[at..]),
		None => (text, ""),
	};
	let body = crate::re!(r"\s+(npc|object)\s+\d+").replace_all(body, "");
	format!("{} {word} {id}{note}", body.trim_end())
}

fn table<'a>(data: &'a Data, kind: &str) -> &'a crate::js::V {
	match kind {
		"npcs" => &data.npcs,
		"objects" => &data.objects,
		"items" => &data.items,
		_ => &data.quests,
	}
}

fn name_of(data: &Data, kind: &str, id: i64) -> String {
	let e = table(data, kind).get(&id.to_string());
	for k in ["name", "title"] {
		if e.get(k).truthy() {
			return e.get(k).to_js_string();
		}
	}
	id.to_string()
}

struct Spawn {
	id: i64,
	map: i64,
	x: f64,
	y: f64,
}

/// The spawn of `ids` (npcs or objects) nearest the point p.
fn nearest_spawn(data: &Data, kind: &str, ids: &[i64], p: Option<&crate::guidecheck::Line>) -> Option<Spawn> {
	let mut best: Option<(Spawn, f64)> = None;
	for &id in ids {
		let spawns = table(data, kind).get(&id.to_string()).get("spawns");
		for (map, s) in spawns.entries() {
			for pt in s.get("pts").items() {
				let (x, y) = (pt.at(0).num(), pt.at(1).num());
				let d = match p {
					Some(p) if p.map.is_some_and(|m| m.to_string() == *map) && p.x.is_some() => js_hypot(x - p.x.unwrap(), y - p.y.unwrap_or(f64::NAN)),
					_ => 1e6,
				};
				if best.as_ref().is_none_or(|b| d < b.1) {
					best = Some((Spawn { id, map: map.parse().unwrap_or(0), x, y }, d));
				}
			}
		}
	}
	best.map(|b| b.0)
}

/// The last placed line at or before li: the route's point there.
fn point_at(chain: &Chain, li: usize) -> Option<&crate::guidecheck::Line> {
	(1..=li).rev().map(|i| &chain.lines[i]).find(|l| l.map.is_some() && l.x.is_some())
}

fn round1(v: f64) -> String {
	js_to_string(js_round(v * 10.0) / 10.0)
}

fn placed(data: &Data, sp: &Spawn) -> Option<(String, String)> {
	let zone = data.zones.get(&sp.map.to_string());
	let name = zone.get("name");
	if !zone.truthy() || !name.truthy() || !data.zone_by_name.contains_key(&name.to_js_string().to_lowercase()) {
		return None;
	}
	Some((name.to_js_string(), format!("@{},{}", round1(sp.x), round1(sp.y))))
}

/// A step that gets item `it` near the route's point at line li.
fn source_unit(chain: &Chain, data: &Data, fi: usize, li: usize, it: i64, zone: &Option<String>) -> Unit {
	let d = data.items.get(&it.to_string());
	let p = point_at(chain, li);
	let drops = |kind: &str| -> Vec<(i64, f64)> {
		d.get("drops")
			.get(kind)
			.entries()
			.iter()
			.map(|(e, c)| {
				let c = c.num();
				(e.parse().unwrap_or(0), if c.is_nan() { 0.0 } else { c })
			})
			.collect()
	};
	let pick = |list: Vec<(i64, f64)>| -> Vec<i64> {
		if list.is_empty() {
			return Vec::new();
		}
		let top = list.iter().map(|x| x.1).fold(f64::NEG_INFINITY, f64::max);
		list.into_iter().filter(|x| x.1 >= top / 2.0).map(|x| x.0).collect()
	};
	let npcs = pick(drops("npc"));
	let objs = pick(drops("object"));
	let vendors: Vec<i64> = keys(&d.get("vendors")).iter().map(|v| v.parse().unwrap_or(0)).collect();
	let name = if d.get("name").truthy() { d.get("name").to_js_string() } else { format!("item {it}") };
	let best = drops("npc").iter().chain(drops("object").iter()).map(|x| x.1).fold(0.0, f64::max);
	if !vendors.is_empty() && best < 25.0 {
		let vid = nearest_spawn(data, "npcs", &vendors, p).map_or(vendors[0], |v| v.id);
		return new_unit(fi, &name_of(data, "npcs", vid), vec![format!("  buy {it} npc {vid}")], zone.clone());
	}
	let obj_sp = nearest_spawn(data, "objects", &objs, p);
	let from_obj = obj_sp.is_some();
	let sp = obj_sp.or_else(|| nearest_spawn(data, "npcs", &npcs, p));
	let from = sp.as_ref().map(|s| name_of(data, if from_obj { "objects" } else { "npcs" }, s.id));
	let pl = sp.as_ref().and_then(|s| placed(data, s));
	let mut lines = Vec::new();
	if let Some((z, _)) = &pl {
		if Some(z) != zone.as_ref() {
			lines.push(format!("  zone {z}"));
		}
	}
	lines.push(format!("  collect {it}{}{}", pl.as_ref().map(|p| format!(" {}", p.1)).unwrap_or_default(), from.as_ref().map(|f| format!(" -- From {f}")).unwrap_or_default()));
	let title = match &from {
		Some(f) => format!("{name} (from {f})"),
		None => name,
	};
	new_unit(fi, &title, lines, zone.clone())
}

fn quest_title(data: &Data, q: i64) -> String {
	let t = data.quests.get(&q.to_string()).get("title");
	if t.truthy() {
		t.to_js_string()
	} else {
		format!("Quest {q}")
	}
}

fn goal_unit(data: &Data, fi: usize, q: i64, k: i64, zone: &Option<String>) -> Option<Unit> {
	let o = data.quests.get(&q.to_string()).get("objectives").at((k - 1).max(0) as usize);
	if k < 1 || !o.truthy() {
		return None;
	}
	let x = if o.get("count").num() > 1.0 { format!(" x{}", o.get("count").to_js_string()) } else { String::new() };
	let id = o.get("id").to_js_string();
	let line = match o.get("type").as_str() {
		Some("kill") => format!("  kill {id}{x} quest {q}.{k}"),
		Some("item") => format!("  collect {id}{x} quest {q}.{k}"),
		Some("object") => format!("  interact {id} quest {q}.{k}"),
		_ => format!("  complete {q}"),
	};
	let mut u = new_unit(fi, &quest_title(data, q), vec![line], zone.clone());
	u.head.push(format!("  when onquest {q}"));
	Some(u)
}

/// The goal line for a knowledge-base step.
fn kb_line(data: &Data, st: &crate::guidecheck::KbStep) -> Option<String> {
	let vendors = st.item.is_some_and(|it| !keys(&data.items.get(&it.to_string()).get("vendors")).is_empty());
	let kind = st.kind.as_deref();
	match st.action.as_str() {
		"buy" => st.item.map(|it| if vendors { format!("  buy {it} nearest") } else { format!("  collect {it}") }),
		"use-item" | "combine" => st.item.map(|it| format!("  use {it}")),
		"collect-object" => match (st.item, kind, st.target) {
			(Some(it), _, _) => Some(format!("  collect {it}")),
			(None, Some("object"), Some(t)) => Some(format!("  interact {t}")),
			_ => None,
		},
		_ => match (kind, st.target) {
			(Some("npc"), Some(t)) => Some(format!("  talk {t}")),
			(Some("object"), Some(t)) => Some(format!("  interact {t}")),
			_ => st.item.map(|it| format!("  use {it}")),
		},
	}
}

/// applyFixes: the fixable failures' repairs on the chain's text -> (texts, applied counts).
fn apply_fixes(chain: &Chain, data: &Data, failures: &[&Reported], kb: Option<&Kb>, applied: &mut Vec<(String, usize)>) -> Vec<(String, String)> {
	let mut files = model_of(chain);
	let mut count = |n: &str| match applied.iter_mut().find(|(k, _)| k == n) {
		Some(e) => e.1 += 1,
		None => applied.push((n.into(), 1)),
	};
	let mut before: FxHashMap<(usize, usize), Vec<Unit>> = FxHashMap::default();
	let mut after: FxHashMap<(usize, usize), Vec<Unit>> = FxHashMap::default();
	let mut done_obj: FxHashSet<String> = FxHashSet::default();
	for f in failures {
		let Some(fix) = f.fix.as_ref() else { continue };
		if !FIXABLE.contains(&f.rule) {
			continue;
		}
		let Some((fm, u, c)) = locate(&files, f.i) else { continue };
		let unit = &files[fm].units[u];
		let fi = unit.fi;
		let zone = unit.zone_in.clone();
		let a = fix.args.first().copied().unwrap_or(0);
		let b = fix.args.get(1).copied().unwrap_or(0);
		match fix.name.as_str() {
			"npc" | "object" => {
				let ch = &mut files[fm].units[u].chunks[c];
				let last = ch.lines.len() - 1;
				ch.lines[last] = with_modifier(&ch.lines[last], &fix.name, a);
				count(&fix.name);
			}
			"drop" => {
				let ch = &mut files[fm].units[u].chunks[c];
				ch.lines.pop();
				ch.li = None;
				count("drop");
			}
			"source" => {
				before.entry((fm, u)).or_default().push(source_unit(chain, data, fi, f.i, a, &zone));
				count("source");
			}
			"whenhas" => {
				let ch = files[fm].units[u].chunks.remove(c);
				let unit = &files[fm].units[u];
				let qt = data.quests.get(&chain.lines[f.i].quest.map(|q| q.to_string()).unwrap_or_default()).get("title");
				let title = if qt.truthy() { qt.to_js_string() } else { unit.title.clone() };
				let nu = Unit {
					fi,
					title: title.clone(),
					head: vec![format!("step {title}"), format!("  when has {a}")],
					chunks: vec![ch],
					tail: Vec::new(),
					zone_in: unit.zone_out.clone(),
					zone_out: unit.zone_out.clone(),
					from: None,
				};
				after.entry((fm, u)).or_default().push(nu);
				count("whenhas");
			}
			"addgoal" => {
				if !done_obj.insert(format!("{a}.{b}@{}", f.i)) {
					continue;
				}
				if let Some(nu) = goal_unit(data, fi, a, b, &zone) {
					before.entry((fm, u)).or_default().push(nu);
					count("addgoal");
				}
			}
			"addaccept" => {
				let givers: Vec<i64> = keys(&data.quests.get(&a.to_string()).get("start").get("npc")).iter().map(|v| v.parse().unwrap_or(0)).collect();
				let g = nearest_spawn(data, "npcs", &givers, point_at(chain, f.i));
				let title = match &g {
					Some(g) => name_of(data, "npcs", g.id),
					None => quest_title(data, a),
				};
				let npc = g.as_ref().filter(|_| givers.len() > 1).map(|g| format!(" npc {}", g.id)).unwrap_or_default();
				before.entry((fm, u)).or_default().push(new_unit(fi, &title, vec![format!("  accept {a}{npc}")], zone));
				count("addaccept");
			}
			"addkb" => {
				let st = kb.and_then(|kb| kb.get(&a)).and_then(|l| l.iter().find(|s| s.n == b));
				if let Some(line) = st.and_then(|st| kb_line(data, st)) {
					let mut nu = new_unit(fi, &quest_title(data, a), vec![line], zone);
					nu.head.push(format!("  when onquest {a}"));
					before.entry((fm, u)).or_default().push(nu);
					count("addkb");
				}
			}
			"copy" => {
				let src = &chain.lines[a as usize];
				let lines = match &src.zone_spec {
					Some(z) if Some(z) != zone.as_ref() => vec![format!("  zone {z}"), src.text.clone()],
					_ => vec![src.text.clone()],
				};
				before.entry((fm, u)).or_default().push(new_unit(fi, &name_of(data, "items", src.item.unwrap_or(0)), lines, zone));
				count("copy");
			}
			"move" => count("move"),
			_ => {}
		}
	}
	for (fm, f) in files.iter_mut().enumerate() {
		let mut out = Vec::new();
		for (u, unit) in std::mem::take(&mut f.units).into_iter().enumerate() {
			out.extend(before.remove(&(fm, u)).unwrap_or_default());
			out.push(unit);
			out.extend(after.remove(&(fm, u)).unwrap_or_default());
		}
		f.units = out.into_iter().filter(|u| !u.chunks.is_empty() || !u.tail.is_empty() || u.head.iter().skip(1).any(|h| !blank(h))).collect();
	}
	serialize(&files)
}

// ---- the order pass -----------------------------------------------------------------

fn pick_from(list: &[usize], c: usize) -> usize {
	let mut best = 0;
	for &p in list {
		if p < c {
			best = p;
		}
	}
	if best != 0 {
		return best;
	}
	list.iter().copied().find(|&p| p > c).unwrap_or(0)
}

/// needEdges: (producer line, line that needs it).
fn need_edges(chain: &Chain, data: &Data) -> Vec<(usize, usize)> {
	let lines = &chain.lines[1..];
	let mut edges = Vec::new();
	let mut accepts: Vec<(i64, Vec<usize>)> = Vec::new();
	let mut turnins: FxHashMap<i64, Vec<usize>> = FxHashMap::default();
	for l in lines {
		let Some(q) = l.quest else { continue };
		if l.verb == "accept" {
			match accepts.iter_mut().find(|e| e.0 == q) {
				Some(e) => e.1.push(l.i),
				None => accepts.push((q, vec![l.i])),
			}
		}
		if l.verb == "turnin" {
			turnins.entry(q).or_default().push(l.i);
		}
	}
	let accepts_of = |q: i64| accepts.iter().find(|e| e.0 == q).map(|e| e.1.as_slice()).unwrap_or(&[]);
	// Items the lines need, then who gives them.
	let mut needs: Vec<(usize, Vec<i64>)> = Vec::new();
	for l in lines {
		let has = crate::guidecheck::when_has(&chain.steps[l.k].when);
		let mut items: Vec<i64> = Vec::new();
		if l.verb == "use" {
			if let Some(it) = l.item {
				items = vec![it];
			}
		}
		if l.verb == "accept" {
			let st = data.quests.get(&l.quest.map(|q| q.to_string()).unwrap_or_default()).get("start");
			if let Some(it) = l.item {
				items = vec![it];
			} else if keys(&st.get("npc")).is_empty() && keys(&st.get("object")).is_empty() {
				items = keys(&st.get("item")).iter().map(|v| v.parse().unwrap_or(0)).collect();
			}
		}
		items.retain(|it| !has.contains(it));
		if !items.is_empty() {
			needs.push((l.i, items));
		}
	}
	let mut wanted: Vec<i64> = Vec::new();
	for (_, its) in &needs {
		for &it in its {
			if !wanted.contains(&it) {
				wanted.push(it);
			}
		}
	}
	let mut producers: FxHashMap<i64, Vec<usize>> = wanted.iter().map(|&it| (it, Vec::new())).collect();
	let drops_by = |kind: &str| {
		let mut m: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
		for &it in &wanted {
			for e in keys(&data.items.get(&it.to_string()).get("drops").get(kind)) {
				m.entry(e.parse().unwrap_or(0)).or_default().push(it);
			}
		}
		m
	};
	let by_npc = drops_by("npc");
	let by_obj = drops_by("object");
	for l in lines {
		let mut give = |it: i64| {
			if let Some(v) = producers.get_mut(&it) {
				v.push(l.i)
			}
		};
		if let Some(it) = l.item.filter(|_| l.verb == "collect" || l.verb == "buy") {
			give(it);
		}
		if l.verb == "kill" {
			for &it in l.npc.and_then(|n| by_npc.get(&n)).map(Vec::as_slice).unwrap_or(&[]) {
				give(it);
			}
		}
		if l.verb == "interact" {
			for &it in l.object.and_then(|o| by_obj.get(&o)).map(Vec::as_slice).unwrap_or(&[]) {
				give(it);
			}
		}
		let q = l.quest.map(|q| data.quests.get(&q.to_string())).filter(|q| q.truthy());
		if let Some(q) = q {
			if l.verb == "accept" && q.get("sourceItem").truthy() {
				give(q.get("sourceItem").num() as i64);
			}
			if l.verb == "turnin" {
				for r in q.get("web").get("items").items() {
					give(if r.is_arr() { r.at(0).num() as i64 } else { r.num() as i64 });
				}
			}
		}
	}
	for (c, items) in &needs {
		let mut all: Vec<usize> = items.iter().flat_map(|it| producers.get(it).cloned().unwrap_or_default()).filter(|p| p != c).collect();
		all.sort_unstable();
		let p = pick_from(&all, *c);
		// A producer further on is another part of the route.
		if p as i64 > *c as i64 + MAX_MOVE {
			continue;
		}
		if p != 0 {
			edges.push((p, *c));
		}
	}
	// A quest's work after its accept, and before the turn-in that closes it.
	for l in lines {
		let Some(q) = l.quest else { continue };
		if l.verb == "accept" {
			continue;
		}
		let is_goal = l.verb == "turnin" || l.verb == "complete" || (l.oi.is_some() && ["kill", "collect", "interact", "use", "talk"].contains(&l.verb.as_str()));
		let bag = l.verb == "collect" && l.oi.is_none();
		if !is_goal && !bag {
			continue;
		}
		let a = pick_from(accepts_of(q), l.i);
		if a != 0 {
			edges.push((a, l.i));
			if l.verb != "turnin" {
				if let Some(&t) = turnins.get(&q).and_then(|v| v.iter().find(|&&x| x > a)) {
					edges.push((l.i, t));
				}
			}
		}
	}
	// A quest-only drop bagged with no quest: after the accept of the quest that needs it.
	for l in lines {
		let Some(it) = l.item else { continue };
		if l.verb != "collect" || l.quest.is_some() || !held_only_item(&data.items.get(&it.to_string())) {
			continue;
		}
		for (qid, acc) in &accepts {
			let objs = data.quests.get(&qid.to_string()).get("objectives").items();
			if !objs.iter().any(|o| o.get("type").as_str() == Some("item") && o.get("id").num() as i64 == it) {
				continue;
			}
			let a = pick_from(acc, l.i);
			if a != 0 {
				edges.push((a, l.i));
			}
		}
	}
	edges
}

/// Kahn's algorithm by original position over nodes 0..n -> (order, stuck nodes).
pub fn stable_sort(n: usize, edges: &[(usize, usize)]) -> (Vec<usize>, Vec<usize>) {
	let mut out: Vec<Vec<usize>> = vec![Vec::new(); n];
	let mut indeg = vec![0usize; n];
	let mut seen: FxHashSet<(usize, usize)> = FxHashSet::default();
	for &(a, b) in edges {
		if a == b || !seen.insert((a, b)) {
			continue;
		}
		out[a].push(b);
		indeg[b] += 1;
	}
	let mut heap: BinaryHeap<Reverse<usize>> = (0..n).filter(|&i| indeg[i] == 0).map(Reverse).collect();
	let mut order = Vec::new();
	while let Some(Reverse(x)) = heap.pop() {
		order.push(x);
		for &y in &out[x] {
			indeg[y] -= 1;
			if indeg[y] == 0 {
				heap.push(Reverse(y));
			}
		}
	}
	let stuck = (0..n).filter(|&i| indeg[i] > 0).collect();
	(order, stuck)
}

fn order_chain(chain: &Chain, data: &Data) -> Vec<(String, String)> {
	let mut files = model_of(chain);
	let edges = need_edges(chain, data);
	let mut units: Vec<Unit> = files.iter_mut().flat_map(|f| std::mem::take(&mut f.units)).collect();
	// The original step index of each unit (a split part keeps its step's in `from`).
	let mut split: FxHashSet<usize> = FxHashSet::default();
	let mut ids: Vec<usize> = (0..units.len()).collect();
	let mut next_id = units.len();
	let copy_head = crate::re!(r"^\s*(when|only|along)\b");
	for pass in 0..3 {
		let mut unit_of: FxHashMap<usize, usize> = FxHashMap::default();
		for (n, u) in units.iter().enumerate() {
			for c in &u.chunks {
				if let Some(li) = c.li {
					unit_of.insert(li, n);
				}
			}
		}
		let u_edges: Vec<(usize, usize)> = edges
			.iter()
			.filter_map(|(a, b)| match (unit_of.get(a), unit_of.get(b)) {
				(Some(&ua), Some(&ub)) if ua != ub => Some((ua, ub)),
				_ => None,
			})
			.collect();
		let (order, stuck) = stable_sort(units.len(), &u_edges);
		if stuck.is_empty() || pass == 2 {
			let placed: FxHashSet<usize> = order.iter().copied().collect();
			let mut new_units: Vec<Unit> = order.iter().map(|&n| units[n].clone()).collect();
			new_units.extend(units.iter().enumerate().filter(|(n, _)| !placed.contains(n)).map(|(_, u)| u.clone()));
			units = new_units;
			break;
		}
		// Split every stuck unit into one unit per goal.
		let mut next: Vec<Unit> = Vec::new();
		let mut next_ids: Vec<usize> = Vec::new();
		for (n, u) in units.iter().enumerate() {
			if !stuck.contains(&n) || u.chunks.len() < 2 || split.contains(&ids[n]) {
				next.push(u.clone());
				next_ids.push(ids[n]);
				continue;
			}
			let mut copy = vec![format!("step {}", u.title)];
			copy.extend(u.head.iter().skip(1).filter(|h| copy_head.is_match(h)).cloned());
			let last = u.chunks.len() - 1;
			for (j, c) in u.chunks.iter().enumerate() {
				let part = Unit {
					fi: u.fi,
					title: u.title.clone(),
					head: if j == 0 { u.head.clone() } else { copy.clone() },
					chunks: vec![c.clone()],
					tail: if j == last { u.tail.clone() } else { Vec::new() },
					zone_in: if j == 0 { u.zone_in.clone() } else { u.zone_out.clone() },
					zone_out: u.zone_out.clone(),
					from: Some(ids[n]),
				};
				split.insert(next_id);
				next.push(part);
				next_ids.push(next_id);
				next_id += 1;
			}
		}
		if next.len() == units.len() {
			break;
		}
		units = next;
		ids = next_ids;
	}
	// Parts of one split step that ended up side by side are one step again.
	let mut merged: Vec<Unit> = Vec::new();
	for u in units {
		if let Some(last) = merged.last_mut() {
			if u.from.is_some() && last.from == u.from {
				last.chunks.extend(u.chunks);
				last.tail = u.tail;
				continue;
			}
		}
		merged.push(u);
	}
	// Inside a unit: goals after what they need there.
	for u in &mut merged {
		if u.chunks.len() < 2 {
			continue;
		}
		let pos: FxHashMap<usize, usize> = u.chunks.iter().enumerate().filter_map(|(j, c)| c.li.map(|li| (li, j))).collect();
		let inner: Vec<(usize, usize)> = edges.iter().filter_map(|(a, b)| Some((*pos.get(a)?, *pos.get(b)?))).collect();
		if !inner.iter().any(|(a, b)| a > b) {
			continue;
		}
		let (order, stuck) = stable_sort(u.chunks.len(), &inner);
		if stuck.is_empty() {
			u.chunks = order.iter().map(|&j| u.chunks[j].clone()).collect();
		}
	}
	// Back into files, in play order: a unit delayed past the next guide's first step joins that guide.
	let mut fi = 0;
	for mut u in merged {
		fi = fi.max(u.fi);
		u.fi = fi;
		files[fi].units.push(u);
	}
	serialize(&files)
}

// ---- the loop --------------------------------------------------------------------------

/// What [`repair_chain`] did: the texts, the failures before and after, the repairs written by name.
pub struct Repaired {
	pub texts: Vec<(String, String)>,
	pub before: Vec<Reported>,
	pub after: Vec<Reported>,
	pub applied: Vec<(String, usize)>,
}

/// repairChain: rounds of repairs (a repair can bring the next failure to light). A failure whose repair was
/// already written once is not repaired again; the loop stops when a round writes nothing new.
pub fn repair_chain(files: &[(String, String)], data: &Data, kb: Option<&Kb>, rounds: usize) -> Repaired {
	let mut texts = files.to_vec();
	let (chain0, first) = check_files(&texts, data, kb);
	let (mut chain, mut current) = (chain0, first.clone());
	let mut applied = Vec::new();
	let mut tried: FxHashSet<String> = FxHashSet::default();
	for _ in 0..rounds {
		let key = |f: &Reported| format!("{}:{},{}:{}", f.rule, f.args[0], f.args[1], chain.lines.get(f.i).filter(|_| f.i > 0).map(|l| l.text.trim().to_string()).unwrap_or_default());
		let fixable: Vec<&Reported> = current.iter().filter(|f| FIXABLE.contains(&f.rule) && f.fix.is_some() && !tried.contains(&key(f))).collect();
		if fixable.is_empty() {
			break;
		}
		for f in &fixable {
			tried.insert(key(f));
		}
		let step1 = apply_fixes(&chain, data, &fixable, kb, &mut applied);
		let chain2 = load_chain(&step1, data);
		let step2 = order_chain(&chain2, data);
		let same = step2.iter().zip(&texts).all(|(a, b)| a.1 == b.1);
		texts = step2;
		if same {
			break;
		}
		let (c, r) = check_files(&texts, data, kb);
		chain = c;
		current = r;
	}
	Repaired { texts, before: first, after: current, applied }
}

/// The fix of a failure as clingo printed it (`move(3)`, `drop`), for tests and reports.
pub fn fix_term(f: &Fix) -> String {
	if f.args.is_empty() {
		f.name.clone()
	} else {
		format!("{}({})", f.name, f.args.iter().map(|a| a.to_string()).collect::<Vec<_>>().join(","))
	}
}
