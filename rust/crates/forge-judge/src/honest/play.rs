//! Playing a guide's lines (honest:249-684): step gates, R1 moves, and each verb's rule.

use super::rules::{self, At};
use super::world::{dist, has, id_of, Id, NodeKey, Pos, Worked, World};
use super::{Finding, Groups, Move, Persona, Place, Severity, AT_FLIGHT_YD, AT_NPC_YD, DOCK_YD, GIVER_NEARER_YD, RIDE_WALK_YD, SOURCE_YD, WALK_FAR_YD, ZONE_STEP_YD};
use forge_core::{js_round, js_to_string};
use forge_guide::js::V;
use Severity::{Fail, Info, Warn};

/// Whether an `only` ({ classes, races, factions }, "!x" excludes) lets the persona in.
pub fn fits(only: &V, p: &Persona) -> bool {
	if !only.truthy() {
		return true;
	}
	let group = |list: V, v: &str| -> bool {
		let items = list.items();
		if items.is_empty() {
			return true;
		}
		let up = v.to_uppercase();
		let strs: Vec<String> = items.iter().map(V::to_js_string).collect();
		let neg: Vec<String> = strs.iter().filter(|x| x.starts_with('!')).map(|x| x[1..].to_uppercase()).collect();
		let pos: Vec<&String> = strs.iter().filter(|x| !x.starts_with('!')).collect();
		if neg.contains(&up) {
			return false;
		}
		pos.is_empty() || pos.iter().any(|x| x.to_uppercase() == up || (up == "SCOURGE" && x.to_uppercase() == "UNDEAD"))
	};
	group(only.get("classes"), &p.cls) && group(only.get("races"), &p.race) && group(only.get("factions"), &p.faction)
}

fn nn(a: V, b: impl FnOnce() -> V) -> V {
	if a.is_nullish() {
		b()
	} else {
		a
	}
}

/// `g.quest ?? g.item ?? g.npc ?? g.object ?? g.level ?? g.location ?? null`.
/// Each compiled goal matched to its source line (the step's goals in the source, in order): the first unused
/// one of its verb whose own ids (quest, item, npc, object, level, location) the goal has (the compiler adds
/// some: a `sethome` gets its innkeeper's npc), else the step's.
pub fn goal_lines(ast_step: &V, goals: &[V]) -> Vec<f64> {
	const KEYS: [&str; 6] = ["quest", "item", "npc", "object", "level", "location"];
	let ast = ast_step.get("goals").items();
	let mut used = vec![false; ast.len()];
	goals
		.iter()
		.map(|g| {
			let t = g.get("t");
			for (i, a) in ast.iter().enumerate() {
				if used[i] {
					continue;
				}
				if a.get("verb").strict_eq(&t) && KEYS.iter().all(|k| a.get(k).is_nullish() || g.get(k).is_nullish() || a.get(k).strict_eq(&g.get(k))) {
					used[i] = true;
					return a.get("line").num();
				}
			}
			if ast_step.truthy() {
				ast_step.get("line").num()
			} else {
				0.0
			}
		})
		.collect()
}

pub fn when_holds(w: &World, when: &V) -> bool {
	for p in when.items() {
		// A condition naming one quest (not a list) holds as one of one.
		let q = p.get("q");
		let qs: Vec<Id> = if q.is_arr() {
			q.items().iter().map(id_of).collect()
		} else if q.is_nullish() {
			Vec::new()
		} else {
			vec![id_of(&q)]
		};
		let k = p.get("k").to_js_string();
		let mut ok = match k.as_str() {
			"onquest" | "complete" => qs.iter().any(|q| w.held(*q)),
			"turnedin" => qs.iter().all(|q| w.done.contains(q)),
			"available" => qs.iter().any(|q| !w.held(*q) && !w.done.contains(q)),
			"has" => {
				let n = p.get("n");
				w.has(id_of(&p.get("item")), if n.truthy() { n.num() } else { 1.0 })
			}
			"level" => {
				let v = nn(p.get("level"), || nn(p.get("v"), || p.get("n")));
				let op = p.get("op");
				if v.is_nullish() || !op.truthy() {
					true
				} else {
					let v = v.num();
					match op.to_js_string().as_str() {
						"<" => w.level < v,
						"<=" => w.level <= v,
						">" => w.level > v,
						">=" => w.level >= v,
						_ => true,
					}
				}
			}
			"group" => w.opts.groups == Groups::Do,
			"bound" => {
				let loc = p.get("location");
				!loc.truthy() || w.bound.is_nullish() || w.bound.to_js_string().to_lowercase() == loc.to_js_string().to_lowercase()
			}
			_ => true,
		};
		if p.get("neg").truthy() && k != "level" {
			ok = !ok;
		}
		if !ok {
			return false;
		}
	}
	true
}

/// The finding's place in the guide.
#[derive(Clone)]
pub struct Here {
	pub guide: String,
	pub file: String,
	pub lines: Vec<f64>,
	pub step_line: f64,
	pub step: usize,
	pub title: String,
	pub reporting: bool,
}

impl Here {
	pub fn at(&self, gi: usize) -> At {
		let l = self.lines.get(gi).copied().unwrap_or(0.0);
		let line = if l != 0.0 && !l.is_nan() { l } else { self.step_line };
		At { guide: self.guide.clone(), file: self.file.clone(), line: if line.is_nan() { 0 } else { line as u32 }, step: self.step, title: self.title.clone(), reporting: self.reporting }
	}
}

pub fn push(w: &mut World, at: &At, rule: &'static str, severity: Severity, reason: String, repair: String, moved: Option<Move>) {
	if !at.reporting {
		return;
	}
	w.findings.push(Finding {
		rule,
		severity,
		guide: at.guide.clone(),
		file: at.file.clone(),
		line: at.line,
		step: at.step,
		title: at.title.clone(),
		reason,
		repair,
		race: String::new(),
		cls: String::new(),
		personas: Vec::new(),
		moved,
		state: (rule == "R1").then(|| super::R1State { at: w.pos.as_ref().map(place_of), known: w.known.iter().cloned().collect(), bound: w.bound.clone() }),
	});
}

fn find(w: &mut World, h: &Here, gi: usize, rule: &'static str, severity: Severity, reason: String, repair: String) {
	push(w, &h.at(gi), rule, severity, reason, repair, None);
}

pub fn play_guide(w: &mut World, g: &V, reporting: bool) {
	let ast = g.hidden("_ast");
	let file = if ast.truthy() && ast.get("file").truthy() { ast.get("file").to_js_string() } else { g.get("id").to_js_string() };
	let ast_steps = ast.get("steps").items();
	let gid = g.get("id").to_js_string();
	for (si, s) in g.get("steps").items().iter().enumerate() {
		if !fits(&s.get("only"), &w.persona) || !when_holds(w, &s.get("when")) {
			continue;
		}
		let ast_step = ast_steps.get(si).cloned().unwrap_or(V::Undef);
		let goals = s.get("goals").items();
		let title = s.get("title");
		let h = Here {
			guide: gid.clone(),
			file: file.clone(),
			lines: goal_lines(&ast_step, &goals),
			step_line: if ast_step.truthy() { ast_step.get("line").num() } else { 0.0 },
			step: si + 1,
			title: if title.truthy() { title.to_js_string() } else { String::new() },
			reporting,
		};
		let ast_goals = ast_step.get("goals").items();
		w.step = format!("{gid}#{si}");
		let mut step_npcs: Vec<Id> = Vec::new();
		let along = s.get("along").truthy();
		for (gi, x) in goals.iter().enumerate() {
			if !fits(&x.get("only"), &w.persona) {
				continue;
			}
			let t = x.get("t").to_js_string();
			if has(&x.get("npc")) && matches!(t.as_str(), "accept" | "turnin" | "talk") {
				let n = id_of(&x.get("npc"));
				if !step_npcs.contains(&n) {
					step_npcs.push(n);
				}
			}
			let explicit_npc = ast_goals.iter().any(|a| a.get("verb").to_js_string() == t && a.get("quest").strict_eq(&x.get("quest")) && has(&a.get("npc")));
			if !w.opts.legacy {
				rules::before_goal(w, s, x, &h, gi);
			}
			let before = w.trace.is_some().then(|| (w.pos.as_ref().and_then(|p| p.w), w.pos_gen));
			play_goal(w, x, &t, gi, &h, explicit_npc, along);
			if let Some((bw, bg)) = before {
				let line = h.lines.get(gi).copied().filter(|l| *l != 0.0 && !l.is_nan()).unwrap_or(0.0) as u32;
				let row = super::TraceRow {
					file: file.clone(),
					line,
					verb: t.clone(),
					before: bw,
					after: w.pos.as_ref().and_then(|p| p.w),
					moved: w.pos_gen != bg,
					had_before: bg != 0,
					has_after: w.pos.is_some(),
				};
				w.trace.as_mut().unwrap().push(row);
			}
		}
		title_check(w, s, &goals, &step_npcs, &h);
		if !w.opts.legacy {
			rules::after_step(w, s, &goals, &h);
		}
	}
}

/// R4: a step with an accept, turn-in or talk whose title names an NPC that none of its goals is at, kills,
/// loots from, gives or takes its quests. A title that is one of its quests' titles is no NPC's.
fn title_check(w: &mut World, s: &V, goals: &[V], step_npcs: &[Id], h: &Here) {
	let title = s.get("title");
	if !title.truthy() || step_npcs.is_empty() {
		return;
	}
	let tl = title.to_js_string().trim().to_lowercase();
	let names = w.ctx.names();
	let Some(ids) = names.get(&tl) else { return };
	let mut allowed: Vec<Id> = Vec::new();
	let mut quests: Vec<(Id, Vec<&'static str>, V)> = Vec::new();
	for x in goals {
		if !fits(&x.get("only"), &w.persona) {
			continue;
		}
		if has(&x.get("npc")) {
			allowed.push(id_of(&x.get("npc")));
		}
		if x.get("fromKind").as_str() == Some("npc") && has(&x.get("fromId")) {
			allowed.push(id_of(&x.get("fromId")));
		}
		if has(&x.get("fromAlsoId")) {
			allowed.push(id_of(&x.get("fromAlsoId")));
		}
		for n in x.get("fromNpcs").items() {
			allowed.push(if n.is_object() { id_of(&nn(n.get("npc"), || n.get("id"))) } else { id_of(&n) });
		}
		let qv = x.get("quest");
		if qv.is_nullish() {
			continue;
		}
		let q = w.ctx.quest(id_of(&qv));
		if q.truthy() && q.get("title").to_js_string().to_lowercase() == tl {
			return;
		}
		let qid = id_of(&qv);
		let ix = match quests.iter().position(|(k, _, _)| *k == qid) {
			Some(i) => i,
			None => {
				quests.push((qid, Vec::new(), q));
				quests.len() - 1
			}
		};
		let t = x.get("t").to_js_string();
		if (t == "accept" || t == "turnin") && has(&x.get("npc")) {
			quests[ix].1.push(if t == "accept" { "accept" } else { "turnin" });
		}
	}
	for (_, named, q) in &quests {
		if !q.truthy() {
			continue;
		}
		if !named.contains(&"accept") {
			allowed.extend(q.get("start").get("npc").items().iter().map(id_of));
		}
		if !named.contains(&"turnin") {
			allowed.extend(q.get("end").get("npc").items().iter().map(id_of));
		}
	}
	if ids.iter().any(|id| allowed.contains(id)) {
		return;
	}
	let at = step_npcs.iter().map(|n| w.ctx.npc_name(&V::Num(*n as f64))).collect::<Vec<_>>().join(", ");
	find(w, h, 0, "R4", Fail, format!("step titled \"{}\" but its quest goals are at {at}", title.to_js_string()), format!("title the step {at}, or give the goal `npc {}`", ids[0]));
}

fn place_of(p: &Pos) -> Place {
	Place { map: p.map.to_js_string(), x: p.x.to_js_string(), y: p.y.to_js_string(), f: p.f.to_js_string() }
}

fn round(d: f64) -> String {
	js_to_string(js_round(d))
}

/// R1 before a goal moves the character to `to`.
fn arrive(w: &mut World, x: &V, t: &str, gi: usize, h: &Here, to: Pos) {
	let is_travel = matches!(t, "goto" | "enter" | "explore" | "fly" | "hearth" | "die");
	if let (Some(from), Some(tw)) = (w.pos.clone(), to.w) {
		if let Some(fw) = from.w {
			let label = format!("{} to {}", w.ctx.zone_name(&from.map), w.ctx.zone_name(&to.map));
			let moved = Move { from: place_of(&from), to: place_of(&to), in_step: w.pos_step == w.step };
			let ride = t == "goto" && ride_re(&if x.get("text").truthy() { x.get("text").to_js_string() } else { String::new() });
			if fw.c != tw.c {
				// A dock is walked to: the crossing is the ride after it, so a dock on another continent needs
				// travel before it too (v1's Ratchet pier for an Orc in Booty Bay).
				let crossed = w.travelled == Some("world") || t == "hearth" || t == "die";
				if !crossed {
					let reason = if ride { format!("dock on another continent with no travel line: {label}") } else { format!("continent change with no travel line: {label}") };
					push(
						w,
						&h.at(gi),
						"R1",
						Fail,
						reason,
						"add a travel step before it: `goto` the dock \"Boat to …\" / \"Zeppelin to …\", or `hearth`, then `fly` from a known flight path".into(),
						Some(moved),
					);
				}
			} else if ride && w.travelled.is_none() && !from.map.strict_eq(&to.map) && dist(Some(fw), Some(tw)) > RIDE_WALK_YD {
				let d = dist(Some(fw), Some(tw));
				push(
					w,
					&h.at(gi),
					"R1",
					Fail,
					format!("dock far from where the guide leaves the player: {label} ({} yd)", round(d)),
					"fly or hearth near the dock first, or leave the ride to the races it starts near".into(),
					Some(moved),
				);
			} else if t == "goto"
				&& flight_master_re(&if x.get("text").truthy() { x.get("text").to_js_string() } else { String::new() })
				&& w.travelled.is_none()
				&& !from.map.strict_eq(&to.map)
				&& dist(Some(fw), Some(tw)) > RIDE_WALK_YD
			{
				// The same for a flight master's goto (a flight from Orgrimmar written after the flight that left it).
				let d = dist(Some(fw), Some(tw));
				push(
					w,
					&h.at(gi),
					"R1",
					Fail,
					format!("flight master far from where the guide leaves the player: {label} ({} yd)", round(d)),
					"fly from the flight master the player is at, or leave the flight to the races it starts near".into(),
					Some(moved),
				);
			} else if w.opts.walk_far && t == "goto" && !ride && w.travelled.is_none() && !from.map.strict_eq(&to.map) && dist(Some(fw), Some(tw)) > WALK_FAR_YD {
				// A goto is a way into the next zone, not across several (an arrow from Stranglethorn
				// to Arathi with the flights between hidden).
				let d = dist(Some(fw), Some(tw));
				push(w, &h.at(gi), "R1", Fail, format!("walk far into another zone: {label} ({} yd)", round(d)), "fly, ride or hearth nearer first".into(), Some(moved));
			} else if !from.map.strict_eq(&to.map) && !is_travel && w.travelled.is_none() && dist(Some(fw), Some(tw)) > ZONE_STEP_YD {
				let d = dist(Some(fw), Some(tw));
				push(
					w,
					&h.at(gi),
					"R1",
					Fail,
					format!("zone change with no travel line: {label} ({} yd)", round(d)),
					format!("add `goto` (or `fly`) into {} with a label saying the way", w.ctx.zone_name(&to.map)),
					Some(moved),
				);
			}
		}
	}
	w.pos = Some(to);
	w.pos_gen += 1;
	w.pos_step = w.step.clone();
	w.travelled = None;
}

fn transport_re(text: &str) -> bool {
	words_re(text, &["boat", "ship", "zeppelin", "portal", "tram", "ferry", "dock", "harbor", "harbour", "teleport", "lift", "elevator", "ride", "flight", "gryphon", "wyvern", "bat", "hippogryph"])
}

/// /\b(word)s?\b/i: one of the words (optionally plural) between word boundaries (\w = [A-Za-z0-9_]).
fn words_re(text: &str, words: &[&str]) -> bool {
	let lower = text.to_ascii_lowercase();
	let b = lower.as_bytes();
	let is_w = |c: u8| c.is_ascii_alphanumeric() || c == b'_';
	for word in words {
		let mut from = 0;
		while let Some(i) = lower[from..].find(word) {
			let s = from + i;
			let mut e = s + word.len();
			let before_ok = s == 0 || !is_w(b[s - 1]);
			if before_ok {
				if e == b.len() || !is_w(b[e]) {
					return true;
				}
				if b[e] == b's' {
					e += 1;
					if e == b.len() || !is_w(b[e]) {
						return true;
					}
				}
			}
			from = s + 1;
		}
	}
	false
}

/// `/\bflight master\b/i`.
fn flight_master_re(text: &str) -> bool {
	let lower = text.to_ascii_lowercase();
	let b = lower.as_bytes();
	let is_w = |c: u8| c.is_ascii_alphanumeric() || c == b'_';
	lower.match_indices("flight master").any(|(i, m)| (i == 0 || !is_w(b[i - 1])) && (i + m.len() == b.len() || !is_w(b[i + m.len()])))
}

/// `/\b(boat|ship|zeppelin|ferry|pier|dock|wharf|harbou?r)s?\b/i`.
fn ride_re(text: &str) -> bool {
	words_re(text, &["boat", "ship", "zeppelin", "ferry", "pier", "dock", "wharf", "harbor", "harbour"])
}

/// A goto whose label names a boat, zeppelin or portal, or that stands at a dock.
fn transport_goto(w: &World, x: &V, at: Option<super::world::Wpt>) -> bool {
	let text = x.get("text");
	if transport_re(&if text.truthy() { text.to_js_string() } else { String::new() }) {
		return true;
	}
	w.ctx.docks.iter().any(|d| dist(*d, at) < DOCK_YD)
}

fn place(w: &World, x: &V) -> Option<Pos> {
	let (map, xx) = (x.get("map"), x.get("x"));
	if map.is_nullish() || xx.is_nullish() {
		return None;
	}
	let (y, f) = (x.get("y"), x.get("f"));
	let wp = w.ctx.world(&map, &xx, &y, &f);
	Some(Pos { map, x: xx, y, f, w: wp })
}

fn arrive_at(w: &mut World, x: &V, t: &str, gi: usize, h: &Here, map: V, xx: V, y: V, f: V) {
	let wp = w.ctx.world(&map, &xx, &y, &f);
	arrive(w, x, t, gi, h, Pos { map, x: xx, y, f, w: wp });
}

fn count_or_1(x: &V) -> f64 {
	let c = x.get("count");
	if c.truthy() {
		c.num()
	} else {
		1.0
	}
}

pub fn play_goal(w: &mut World, x: &V, t: &str, gi: usize, h: &Here, explicit_npc: bool, along: bool) {
	let prior = w.pos.clone();
	let p = place(w, x);
	if t == "fly" {
		let node = w.node(x);
		let id = match &node {
			Some(n) => n.get("id"),
			None => x.get("location"),
		};
		let idk = NodeKey::of(&id);
		let here = prior.as_ref().and_then(|p| p.w);
		let nearest = |w: &World, known: bool| -> Option<(V, f64)> {
			let mut best: Option<(V, f64)> = None;
			for n in &w.ctx.nodes {
				let nid = NodeKey::of(&n.get("id"));
				if !w.usable(n) || (known && (!w.known.contains(&nid) || nid == idk)) {
					continue;
				}
				let d = dist(w.ctx.world(&n.get("map"), &n.get("x"), &n.get("y"), &V::str("e")), here);
				if best.as_ref().is_none_or(|b| d < b.1) {
					best = Some((n.clone(), d));
				}
			}
			best
		};
		let loc = x.get("location").to_js_string();
		if !w.known.contains(&idk) {
			let short = node.as_ref().map(|n| n.get("short")).filter(|s| s.truthy()).map(|s| s.to_js_string()).unwrap_or_else(|| loc.clone());
			find(w, h, gi, "R1", Fail, format!("fly to {loc}: its flight path was never learnt"), format!("add `getfp \"{short}\"` on an earlier visit, or walk"));
		}
		if here.is_some() {
			let prior = prior.as_ref().unwrap();
			match nearest(w, false).filter(|(_, d)| *d <= AT_FLIGHT_YD) {
				Some((n, _)) => {
					let nk = NodeKey::of(&n.get("id"));
					if nk != idk && !w.known.contains(&nk) {
						let s = n.get("short").to_js_string();
						find(w, h, gi, "R1", Fail, format!("fly from {s}: its flight path was never learnt"), format!("add `getfp \"{s}\"` before the flight"));
					}
					w.known.insert(nk);
				}
				None => match nearest(w, true) {
					Some((k, d)) => {
						let s = k.get("short").to_js_string();
						find(
							w,
							h,
							gi,
							"R1",
							Fail,
							format!(
								"fly to {loc} with no flight master where the guide leaves the player ({} {},{}): the nearest learnt one is {s}, {} yd away",
								w.ctx.zone_name(&prior.map),
								prior.x.to_js_string(),
								prior.y.to_js_string(),
								round(d)
							),
							format!("add a step to the {s} flight master (`goto` it) before the flight"),
						);
					}
					None => find(w, h, gi, "R1", Fail, format!("fly to {loc}: no flight path learnt to fly from"), "add `getfp` at the flight master the player stands at".into()),
				},
			}
		}
		w.known.insert(idk);
		if let Some(n) = node {
			arrive_at(w, x, t, gi, h, n.get("map"), n.get("x"), n.get("y"), V::str("e"));
		}
		w.travelled = None;
		return;
	}
	if t == "hearth" {
		let loc = x.get("location").to_js_string();
		if w.bound.truthy() && w.bound.to_js_string().to_lowercase() != loc.to_lowercase() {
			let b = w.bound.to_js_string();
			find(w, h, gi, "R1", Fail, format!("hearth to {loc}, but the hearthstone is bound to {b}"), format!("add `sethome \"{loc}\"` before, or hearth to {b}"));
		}
		let inn = w.ctx.data.travel.get("inns").items().into_iter().find(|i| {
			let names = i.get("names");
			let list = if names.truthy() { names.items() } else { vec![i.get("location")] };
			list.iter().any(|n| n.to_js_string().to_lowercase() == loc.to_lowercase())
		});
		if let Some(inn) = inn {
			arrive_at(w, x, t, gi, h, inn.get("map"), inn.get("x"), inn.get("y"), inn.get("f"));
		}
		w.travelled = None;
		return;
	}
	if let Some(p) = &p {
		if !along {
			arrive(w, x, t, gi, h, p.clone());
		}
	}
	match t {
		"goto" | "enter" | "explore" => {
			let pw = p.as_ref().and_then(|p| p.w);
			w.travelled = if t == "goto" && pw.is_some() && transport_goto(w, x, pw) { Some("world") } else { Some("zone") };
		}
		"die" => w.travelled = Some("zone"),
		"getfp" => {
			let k = match w.node(x) {
				Some(n) => NodeKey::of(&n.get("id")),
				None => NodeKey::of(&x.get("location")),
			};
			w.known.insert(k);
		}
		"sethome" => w.bound = x.get("location"),
		"level" => {
			let l = x.get("level");
			let l = if l.truthy() { l.num() } else { 0.0 };
			w.level = w.level.max(l.floor());
		}
		"buy" => {
			w.give(&x.get("item"), count_or_1(x));
			if !w.opts.legacy {
				// The knowledge base's buy steps read the buy lines (legacy honest never recorded them).
				w.worked.push(Worked::of(x));
			}
		}
		"accept" => accept(w, x, gi, h, explicit_npc, prior.as_ref()),
		"turnin" => turnin(w, x, gi, h),
		"kill" => kill(w, x),
		"collect" => collect(w, x, gi, h, p.as_ref()),
		"use" => {
			let item = x.get("item");
			if has(&item) && !w.has(id_of(&item), 1.0) {
				let q = w.ctx.quest(id_of(&x.get("quest")));
				let given = q.truthy() && q.get("sourceItem").strict_eq(&item);
				if !given {
					let name = w.ctx.item_name(&item);
					let i = item.to_js_string();
					find(w, h, gi, "R3", Fail, format!("use {name}: it is not in the bags"), format!("add the line that gets it (`collect {i}`, `buy {i}`, or the accept that gives it) before"));
				}
				w.give(&item, 1.0);
			}
			credit_goal(w, x);
			w.worked.push(Worked::of(x));
		}
		"interact" => {
			credit_goal(w, x);
			let o = x.get("object");
			if has(&o) {
				if let Some(items) = w.ctx.object_items.get(&id_of(&o)) {
					for i in items.clone() {
						w.give_id(i, 1.0);
					}
				}
			}
			w.worked.push(Worked::of(x));
		}
		"complete" => {
			let qv = x.get("quest");
			let q = w.ctx.quest(id_of(&qv));
			if q.truthy() && w.held(id_of(&qv)) {
				complete_all(w, id_of(&qv), &q);
			}
			w.worked.push(Worked::of(x));
		}
		"abandon" if !w.opts.legacy => {
			let q = id_of(&x.get("quest"));
			w.log_delete(q);
			w.worked.push(Worked::of(x));
		}
		_ => w.worked.push(Worked::of(x)),
	}
}

/// `if (x.quest && x.oi) w.credit(x.quest, x.oi, x.count || 1)`.
fn credit_goal(w: &mut World, x: &V) {
	let (q, oi) = (x.get("quest"), x.get("oi"));
	if q.truthy() && oi.truthy() {
		w.credit(id_of(&q), oi.num(), count_or_1(x));
	}
}

/// Every objective credited and its items given.
fn complete_all(w: &mut World, q: Id, quest: &V) {
	for (i, o) in quest.get("objectives").items().iter().enumerate() {
		let need = count_or_1(o);
		w.credit(q, (i + 1) as f64, need);
		if o.get("type").as_str() == Some("item") {
			w.give(&o.get("id"), need);
		}
	}
}

fn accept(w: &mut World, x: &V, gi: usize, h: &Here, explicit_npc: bool, prior: Option<&Pos>) {
	let qv = x.get("quest");
	let qid = id_of(&qv);
	let q = w.ctx.quest(qid);
	let at = h.at(gi);
	if !q.truthy() {
		return w.accepted(qid, Some(at));
	}
	let start = q.get("start");
	let (s_npc, s_obj, s_item) = (start.get("npc").items(), start.get("object").items(), start.get("item").items());
	let name = w.ctx.title_of(&qv);
	let item = x.get("item");
	let by_item = !s_item.is_empty() && (has(&item) || (s_npc.is_empty() && s_obj.is_empty()));
	if by_item {
		let items: Vec<V> = if has(&item) { vec![item.clone()] } else { s_item.clone() };
		if !items.iter().any(|i| w.has(id_of(i), 1.0)) {
			let it = w.ctx.data.items.get(&items[0].to_js_string());
			let drops = it.get("drops");
			let mut srcs: Vec<String> = drops.get("npc").keys().iter().take(3).map(|n| format!("kill {}", w.ctx.npc_name(&V::Num(forge_guide::js::str_to_num(n))))).collect();
			srcs.extend(drops.get("object").keys().iter().take(3).map(|o| {
				let ob = w.ctx.data.objects.get(o);
				let nm = ob.get("name");
				format!("loot {}", if ob.truthy() && nm.truthy() { nm.to_js_string() } else { format!("object {o}") })
			}));
			let i0 = items[0].to_js_string();
			let first = if srcs.is_empty() { format!("first `collect {i0}`") } else { format!("first {} (`collect {i0}`)", srcs.join(" / ")) };
			let iname = w.ctx.item_name(&items[0]);
			find(
				w,
				h,
				gi,
				"R2",
				Fail,
				format!("accept {name}: it starts from {iname}, which no earlier line puts in the bags"),
				format!("{first}, then accept; or move the accept to the step that loots it"),
			);
			w.give(&items[0], 1.0);
		}
	} else if has(&x.get("npc")) {
		let npc = x.get("npc");
		let nid = id_of(&npc);
		if !s_npc.is_empty() && !s_npc.iter().any(|n| id_of(n) == nid) {
			let givers = s_npc.iter().map(|n| w.ctx.npc_name(n)).collect::<Vec<_>>().join(", ");
			find(w, h, gi, "R4", Fail, format!("accept {name} at {}, who does not give it (givers: {givers})", w.ctx.npc_name(&npc)), format!("write `npc {}` and its place", s_npc[0].to_js_string()));
		}
		let here = w.ctx.world(&x.get("map"), &x.get("x"), &x.get("y"), &x.get("f"));
		if here.is_some() && w.ctx.npc_dist(nid, here) > AT_NPC_YD {
			let n = w.ctx.npc_name(&npc);
			find(
				w,
				h,
				gi,
				"R2",
				Fail,
				format!("accept {name}: {n} does not stand at the step's place ({} {},{})", w.ctx.zone_name(&x.get("map")), x.get("x").to_js_string(), x.get("y").to_js_string()),
				format!("drop the `@` or move it to {n}"),
			);
		}
		if let Some(pw) = prior.and_then(|p| p.w).filter(|_| !explicit_npc && s_npc.len() > 1) {
			let mine = w.ctx.npc_dist(nid, Some(pw));
			let mut best: Option<(V, f64)> = None;
			for n in &s_npc {
				let d = w.ctx.npc_dist(id_of(n), Some(pw));
				if id_of(n) != nid && d + GIVER_NEARER_YD < mine && best.as_ref().is_none_or(|b| d < b.1) {
					best = Some((n.clone(), d));
				}
			}
			if let Some((bn, bd)) = best {
				find(
					w,
					h,
					gi,
					"R4",
					Fail,
					format!(
						"accept {name}: several NPCs give it and the line names none, so it resolves to {} ({}, {} yd away); {} is {} yd away",
						w.ctx.npc_name(&npc),
						w.ctx.zone_name(&x.get("map")),
						round(mine),
						w.ctx.npc_name(&bn),
						round(bd)
					),
					format!("write `accept {} npc {}` if the route takes it there", qv.to_js_string(), bn.to_js_string()),
				);
			}
		}
	}
	w.accepted(qid, Some(at));
	w.worked.push(Worked::of(x));
}

fn turnin(w: &mut World, x: &V, gi: usize, h: &Here) {
	let qv = x.get("quest");
	let qid = id_of(&qv);
	let q = w.ctx.quest(qid);
	let name = w.ctx.title_of(&qv);
	let npc = x.get("npc");
	if q.truthy() && has(&npc) {
		let end = q.get("end").get("npc").items();
		if !end.is_empty() && !end.iter().any(|n| id_of(n) == id_of(&npc)) {
			let enders = end.iter().map(|n| w.ctx.npc_name(n)).collect::<Vec<_>>().join(", ");
			find(w, h, gi, "R4", Fail, format!("turn in {name} at {}, who does not take it (enders: {enders})", w.ctx.npc_name(&npc)), format!("write `npc {}`", end[0].to_js_string()));
		}
	}
	if x.get("direct").truthy() {
		w.done.insert(qid);
		return;
	}
	if !w.held(qid) {
		let sev = if !w.done.is_empty() || !w.log.is_empty() { Fail } else { Warn };
		let qs = qv.to_js_string();
		find(w, h, gi, "R5", sev, format!("turn in {name}: never accepted on the way here"), format!("add `accept {qs}` before, or mark the turn-in `direct`"));
		w.accepted(qid, None);
		if q.truthy() {
			complete_all(w, qid, &q);
		}
	}
	if q.truthy() {
		let objectives = q.get("objectives").items();
		for (i, o) in objectives.iter().enumerate() {
			let need = count_or_1(o);
			let ty = o.get("type").to_js_string();
			let oid = o.get("id");
			let credit = w.log.iter().find(|(k, _)| *k == qid).map(|(_, e)| e.get(i)).unwrap_or(0.0);
			let got = if ty == "item" { w.bag(id_of(&oid)).max(credit) } else { credit };
			if got < need {
				let text = o.get("text");
				let what = if ty == "item" {
					format!("{} {}", js_to_string(need), if text.truthy() { text.to_js_string() } else { w.ctx.item_name(&oid) })
				} else {
					format!("{ty} {} x{}", if text.truthy() { text.to_js_string() } else { oid.to_js_string() }, js_to_string(need))
				};
				let verb = match ty.as_str() {
					"kill" => "kill",
					"item" => "collect",
					_ => "complete",
				};
				let target = if ty == "kill" || ty == "item" { oid.to_js_string() } else { qv.to_js_string() };
				find(
					w,
					h,
					gi,
					"R5",
					Fail,
					format!("turn in {name}: objective {} ({what}) has {}/{} from earlier lines", i + 1, js_to_string(got), js_to_string(need)),
					format!("add `{verb} {target} x{} quest {}.{}` with its place before the turn-in", js_to_string(need), qv.to_js_string(), i + 1),
				);
			}
			if ty == "item" {
				w.take(id_of(&oid), need);
			}
		}
		kb_check(w, &qv, &name, gi, h);
	}
	w.log_delete(qid);
	w.done.insert(qid);
	let rewards = q.get(concat!("wow", "head")).get("items");
	for it in rewards.items() {
		if it.is_arr() {
			let n = it.at(1);
			w.give(&it.at(0), if n.truthy() { n.num() } else { 1.0 });
		} else {
			w.give(&it, 1.0);
		}
	}
	w.worked.push(Worked::of(x));
}

/// The knowledge base's required steps since the accept: an item step (use, combine, buy) needs a line
/// naming the item; a summon or escort one the NPC (or the summoning item); an object's loot the item or
/// the object.
fn kb_check(w: &mut World, qv: &V, name: &str, gi: usize, h: &Here) {
	let Some(kb) = w.kb else { return };
	let qid = id_of(qv);
	let Some(steps) = kb.get(&qid) else { return };
	let since = w.log.iter().find(|(k, _)| *k == qid).map(|(_, e)| e.since).unwrap_or(w.worked.len());
	let mut missing: Vec<(String, String)> = Vec::new();
	for st in steps {
		let by_item = matches!(st.action.as_str(), "use-item" | "combine" | "buy");
		let ids: Vec<i64> = if let (true, Some(i)) = (by_item, st.item) { vec![i] } else { [st.item, st.target].into_iter().flatten().collect() };
		let covered = w.worked[since.min(w.worked.len())..].iter().any(|y| {
			if y.t == "complete" && y.quest.strict_eq(qv) {
				return st.action == "collect-object" || st.action == "buy";
			}
			let vals: Vec<&V> = if by_item { vec![&y.item] } else { vec![&y.item, &y.npc, &y.object, &y.from_id] };
			vals.iter().any(|v| v.is_num() && ids.contains(&id_of(v)) && v.num().fract() == 0.0)
		}) || (!w.opts.legacy && st.action == "buy" && st.item.is_some_and(|i| w.has(i, 1.0)));
		if !covered {
			let target = match (st.item, st.kind.as_deref()) {
				(Some(i), _) => w.ctx.item_name(&V::Num(i as f64)),
				(None, Some("npc")) => w.ctx.npc_name(&st.target.map_or(V::Null, |t| V::Num(t as f64))),
				(None, k) => format!("{} {}", k.unwrap_or("null"), st.target.map_or("null".into(), |t| t.to_string())),
			};
			let fact = st.fact.as_deref().filter(|f| !f.is_empty()).map(|f| format!(": {f}")).unwrap_or_default();
			let reason = if w.opts.legacy || st.action != "buy" {
				format!("turn in {name}: required step {} ({} {target}) has no line", st.n, st.action)
			} else {
				format!("turn in {name}: required step {} (buy {target}) has no buy line since the accept", st.n)
			};
			missing.push((reason, format!("add a goal for it before the turn-in{fact}")));
		}
	}
	for (reason, repair) in missing {
		find(w, h, gi, "R5", Fail, reason, repair);
	}
}

fn kill(w: &mut World, x: &V) {
	let n = count_or_1(x);
	credit_goal(w, x);
	let qid = id_of(&x.get("quest"));
	let npc = x.get("npc");
	let nid = id_of(&npc);
	let nkey = npc.to_js_string();
	let ctx = w.ctx;
	for (q, e) in w.log.iter_mut() {
		if *q == qid {
			continue;
		}
		for (i, o) in ctx.quest(*q).get("objectives").items().iter().enumerate() {
			if o.get("type").as_str() == Some("kill") && o.get("id").strict_eq(&npc) {
				let v = e.get(i) + n;
				e.set(i, v);
			}
		}
	}
	let held: Vec<Id> = w.log.iter().map(|(q, _)| *q).collect();
	for q in held {
		for o in ctx.quest(q).get("objectives").items() {
			if o.get("type").as_str() != Some("item") {
				continue;
			}
			let oid = id_of(&o.get("id"));
			let it = ctx.item(oid);
			let drops = it.get("drops").get("npc");
			let need = count_or_1(&o);
			if it.truthy() && drops.truthy() && has(&npc) && drops.has(&nkey) && !w.has(oid, need) {
				let give = need - w.bag(oid);
				w.give_id(oid, give);
			}
		}
	}
	if has(&npc) {
		if let Some(list) = ctx.starters.get(&nid) {
			for &(q, i) in list {
				if !w.has(i, 1.0) && !w.done.contains(&q) {
					w.give_id(i, 1.0);
				}
			}
		}
	}
	w.worked.push(Worked::of(x));
}

fn collect(w: &mut World, x: &V, gi: usize, h: &Here, p: Option<&Pos>) {
	let item = x.get("item");
	let iid = id_of(&item);
	let n = count_or_1(x);
	let it = w.ctx.item(iid);
	let name = w.ctx.item_name(&item);
	let optional = x.get("optional").truthy();
	let sev = if optional { Warn } else { Fail };
	if !w.has(iid, n) {
		let at = match p {
			Some(p) if p.w.is_some() => Some(p.clone()),
			_ => w.pos.clone().filter(|q| q.w.is_some()),
		};
		let mut sourced = true;
		let drops = it.get("drops");
		let npcs: Vec<Id> = drops.get("npc").keys().iter().map(|k| forge_guide::js::str_to_num(k) as Id).collect();
		let objs: Vec<Id> = drops.get("object").keys().iter().map(|k| forge_guide::js::str_to_num(k) as Id).collect();
		let vendors = it.get("vendors");
		let has_vendors = vendors.truthy() && !vendors.is_empty();
		if npcs.is_empty() && objs.is_empty() && !has_vendors {
			sourced = false;
			find(
				w,
				h,
				gi,
				"R3",
				sev,
				format!("collect {name}: the data has no mob, object or vendor for it and no earlier line gives it"),
				"write the line that makes it (`buy` what it takes, the object to use, the quest that rewards it) before, or drop the goal".into(),
			);
		} else if let (Some(at), false) = (&at, has_vendors) {
			let near = npcs.iter().any(|m| w.ctx.npc_dist(*m, at.w) <= SOURCE_YD) || objs.iter().any(|o| w.ctx.obj_dist(*o, at.w) <= SOURCE_YD);
			if !near {
				sourced = false;
				let mut cands: Vec<(f64, String)> = npcs.iter().map(|m| (w.ctx.npc_dist(*m, at.w), w.ctx.npc_name(&V::Num(*m as f64)))).collect();
				cands.extend(objs.iter().map(|o| (w.ctx.obj_dist(*o, at.w), w.ctx.object_name(&V::Num(*o as f64)))));
				// Array.prototype.sort with (a, b) => a.d - b.d: stable; NaN compares as equal.
				cands.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(std::cmp::Ordering::Equal));
				let nearest = match cands.first() {
					Some((d, nm)) if d.is_finite() => format!(" (nearest: {nm}, {} yd)", round(*d)),
					_ => " on this continent".into(),
				};
				let noplace = if p.is_some() { "" } else { " (no place: where the guide left the player)" };
				find(
					w,
					h,
					gi,
					"R3",
					sev,
					format!("collect {name} at {} {},{}{noplace}: nothing there drops it{nearest}", w.ctx.zone_name(&at.map), at.x.to_js_string(), at.y.to_js_string()),
					format!("place the goal at a camp that drops it (`collect {} nearest`)", item.to_js_string()),
				);
			}
		}
		let needers = w.ctx.needing.get(&iid).cloned().unwrap_or_default();
		if !needers.is_empty() && !has_vendors && !w.held_needing(iid) {
			let qs = needers.iter().take(2).map(|q| w.ctx.title_of(&V::Num(*q as f64))).collect::<Vec<_>>().join(" / ");
			let repair = format!("move the collect after `accept {}`", needers[0]);
			if it.truthy() && it.get("questItem").truthy() {
				sourced = false;
				find(w, h, gi, "R3", sev, format!("collect {name}: it drops only while {qs} is held, and it is not"), repair);
			} else {
				find(
					w,
					h,
					gi,
					"R3",
					if w.opts.legacy { Warn } else { Info },
					format!("collect {name}: {qs} asks for it and none is held; it may drop only for the quest (the data does not say)"),
					repair,
				);
			}
		}
		if sourced || !optional {
			let give = n - w.bag(iid);
			w.give(&item, give);
		}
	}
	let (q, oi) = (x.get("quest"), x.get("oi"));
	if q.truthy() && oi.truthy() && w.has(iid, n) {
		w.credit(id_of(&q), oi.num(), n);
	}
	w.worked.push(Worked::of(x));
}
