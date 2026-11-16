//! The play checks (docs/GUIDE_FORMAT.md, "Validation", "Play checks"): patterns players reported more than
//! once, each a check over every guide instead of a fix per report. Errors in our pack (`guides`), warnings in
//! every other, like the house rules. A step a check flags that is right as written is listed in
//! `data/lint-allow.json` with its reason ([`Allow`]); an entry no step needs any more is a warning.
//!
//! - `direct-gate`: a required `turnin <q> direct` whose quest takes items, in a step with no `when has <item>`
//!   for each and no goal before it in the step that gets the item. The quest never enters the log, so nothing
//!   tells the route whether the player still carries the item: without it the giver offers nothing and the
//!   step holds (An Apple Treat, reported six times).
//! - `talk-kill`: a `kill` goal on a quest-log line the data types as a talk objective (`talk`): the player is
//!   told to kill an NPC they are meant to speak to.
//! - `item-skippable`: a required `use <item>`, or an `accept` of a quest an item starts, whose item every
//!   earlier goal that gets it (a `collect`, `buy` or `craft` of it, an accept that hands it over, a turn-in
//!   that rewards it) is `optional` or in a step with a `when` the goal's step does not share: a player who
//!   passed those goes on without it, and the goal holds.
//! - `handin-unworked`: a required, plain `turnin Q` (not in a step with `when complete Q` or `when has` an item
//!   of Q's) while one of Q's kill, talk, object or event objectives has no goal working it since Q's accept (or,
//!   for a quest this guide never accepts, anywhere before it in the guide or a guide chaining in): no `complete
//!   Q`, no goal bound to Q (`quest Q` or `quest Q.O`), no unbound goal at the objective's npc or object. The
//!   guide window goes from the accept straight to the hand-in (Kerlonian's escort, The Sleeper Has Awakened).
//!   An objective that is the ender itself (talk to, or click, whoever takes the quest in) needs no goal.
//! - `offer` and `offer-level` (validate.rs): an `accept` (or direct turn-in) the giver cannot offer there: a
//!   prerequisite, parent or breadcrumb the chain leaves open; or a level well below the quest's minimum at the
//!   level the route plausibly reaches.

use std::cell::RefCell;

use rustc_hash::{FxHashMap, FxHashSet};

use crate::data::Data;
use crate::diag::Diagnostics;
use crate::js::V;
use crate::validate::{key, Key};

fn ts(v: &V) -> String {
	v.to_js_string()
}

fn t_of(goal: &V) -> String {
	goal.get("t").to_js_string()
}

fn ast_file(g: &V) -> String {
	ts(&g.hidden("_ast").get("file"))
}

/// The allow-list (data/lint-allow.json `allow`): `{ rule, guide, quest | item, reason }` entries. A check
/// asks [`Allow::covers`] before it reports; [`Allow::finish`] warns about entries of the compiled guides
/// that covered nothing.
pub struct Allow {
	list: Vec<V>,
	used: RefCell<FxHashSet<usize>>,
}

impl Allow {
	pub fn new(data: &Data) -> Allow {
		Allow { list: data.lint_allow.items(), used: RefCell::new(FxHashSet::default()) }
	}

	/// Whether an entry lists `rule` on `guide` for `subject` (`quest` or `item`, by id); marks it used.
	pub fn covers(&self, rule: &str, guide: &V, subject: (&str, &V)) -> bool {
		let (kind, id) = subject;
		for (i, e) in self.list.iter().enumerate() {
			if e.get("rule").as_str() == Some(rule) && e.get("guide").as_str() == guide.as_str() && !e.get(kind).is_nullish() && key(&e.get(kind)) == key(id) {
				self.used.borrow_mut().insert(i);
				return true;
			}
		}
		false
	}

	/// After every check: an entry without a reason is an error; an entry of a compiled guide that covered
	/// nothing is a warning (the step was fixed or moved: drop the entry).
	pub fn finish(&self, guides: &[V], diag: &mut Diagnostics) {
		let ids: FxHashSet<String> = guides.iter().map(|g| ts(&g.get("id"))).collect();
		for (i, e) in self.list.iter().enumerate() {
			let guide = ts(&e.get("guide"));
			if !ids.contains(&guide) {
				continue;
			}
			let what = format!("{} on {guide} ({})", ts(&e.get("rule")), if !e.get("quest").is_nullish() { format!("quest {}", ts(&e.get("quest"))) } else { format!("item {}", ts(&e.get("item"))) });
			if !e.get("reason").as_str().is_some_and(|r| !r.trim().is_empty()) {
				diag.error("data/lint-allow.json", 0.0, format!("allow entry {what} has no reason"), Some("say why the step is right as written".into()));
			}
			if !self.used.borrow().contains(&i) {
				diag.warn("data/lint-allow.json", 0.0, format!("allow entry {what} matches no step: drop it"), None);
			}
		}
	}
}

/// Report a play check's finding: an error in our pack, a warning in any other, unless the allow-list covers it.
#[allow(clippy::too_many_arguments)]
pub fn report(diag: &mut Diagnostics, allow: &Allow, g: &V, ln: f64, rule: &str, subject: (&str, &V), msg: String, hint: &str) {
	if allow.covers(rule, &g.get("id"), subject) {
		return;
	}
	let hint = format!("{hint}; a step that is right as written goes in data/lint-allow.json (rule `{rule}`, the {} and the reason)", subject.0);
	if g.get("pack").as_str() == Some("guides") {
		diag.error(&ast_file(g), ln, msg, Some(hint));
	} else {
		diag.warn(&ast_file(g), ln, msg, Some(hint));
	}
}

fn item_name(data: &Data, id: &V) -> String {
	let it = data.item(id);
	if it.truthy() && it.get("name").truthy() {
		format!("{} ({})", ts(&it.get("name")), ts(id))
	} else {
		format!("item {}", ts(id))
	}
}

fn quest_name(data: &Data, id: &V) -> String {
	let q = data.quest(id);
	if q.truthy() && q.get("title").truthy() {
		format!("{} ({})", ts(id), ts(&q.get("title")))
	} else {
		ts(id)
	}
}

/// The items the giver of a direct hand-in takes from the bags: every item line of the quest's objectives.
fn hand_over_items(data: &Data, q: &V) -> Vec<V> {
	let mut out: Vec<V> = Vec::new();
	for o in data.quest_objectives(q) {
		let id = o.get("id");
		if o.get("kind").as_str() == Some("item") && !id.is_nullish() && !out.iter().any(|x| key(x) == key(&id)) {
			out.push(id);
		}
	}
	out
}

/// The `when has <item>` items of a step (positive predicates only).
fn has_gates(step: &V) -> FxHashSet<Key> {
	step.get("when").items().iter().filter(|p| p.get("k").as_str() == Some("has") && !p.get("neg").truthy()).map(|p| key(&p.get("item"))).collect()
}

/// The item a goal puts in the bags, if any: a `collect`, `buy` or `craft` of it.
fn got_item(goal: &V) -> Option<V> {
	matches!(t_of(goal).as_str(), "collect" | "buy" | "craft" | "auction").then(|| goal.get("item")).filter(|i| !i.is_nullish())
}

/// direct-gate (module docs).
pub fn check_direct_gates(g: &V, data: &Data, allow: &Allow, diag: &mut Diagnostics) {
	for step in g.get("steps").items() {
		let gated = has_gates(&step);
		let mut got: FxHashSet<Key> = FxHashSet::default();
		for goal in step.get("goals").items() {
			if t_of(&goal) == "turnin" && goal.get("direct").strict_eq(&V::Bool(true)) && !goal.get("optional").truthy() {
				let q = goal.get("quest");
				let open: Vec<V> = hand_over_items(data, &q).into_iter().filter(|i| !gated.contains(&key(i)) && !got.contains(&key(i))).collect();
				if !open.is_empty() {
					let list = open.iter().map(|i| item_name(data, i)).collect::<Vec<_>>().join(", ");
					let gates = open.iter().map(|i| format!("`when has {}`", ts(i))).collect::<Vec<_>>().join(" and ");
					report(
						diag,
						allow,
						g,
						goal.hidden("_line").num(),
						"direct-gate",
						("quest", &q),
						format!(
							"`turnin {} direct` takes {list} from the bags, but the step has no `when has` for it: a player without it is held at a hand-in the giver never offers",
							quest_name(data, &q)
						),
						&format!("give the step {gates} (the hand-in then waits for the item), or get the item earlier in the same step"),
					);
				}
			}
			if let Some(i) = got_item(&goal) {
				got.insert(key(&i));
			}
		}
	}
}

/// talk-kill (module docs): a compiled `kill` goal on quest-log line Q.O (resolve fills `oi`) that the data
/// types `talk`.
pub fn check_talk_kills(g: &V, data: &Data, allow: &Allow, diag: &mut Diagnostics) {
	for step in g.get("steps").items() {
		for goal in step.get("goals").items() {
			if t_of(&goal) != "kill" || goal.get("quest").is_undef() || goal.get("oi").is_undef() {
				continue;
			}
			let q = goal.get("quest");
			let oi = goal.get("oi").num();
			let objectives = data.quest_objectives(&q);
			let Some(o) = (oi >= 1.0).then(|| objectives.get(oi as usize - 1)).flatten() else { continue };
			if o.get("kind").as_str() != Some("talk") {
				continue;
			}
			let who = if o.get("name").truthy() { ts(&o.get("name")) } else { format!("npc {}", ts(&o.get("id"))) };
			report(
				diag,
				allow,
				g,
				goal.hidden("_line").num(),
				"talk-kill",
				("quest", &q),
				format!(
					"`kill` on quest {}'s line {}, which the game counts by talking to {who}: the step tells the player to kill an NPC they are meant to speak to",
					quest_name(data, &q),
					ts(&goal.get("oi"))
				),
				&format!("write `talk {} quest {}.{}`", ts(&o.get("id")), ts(&q), ts(&goal.get("oi"))),
			);
		}
	}
}

/// Where an item comes from in the route: whether some goal that gets it always runs (`sure`), the `when`
/// sets of the skippable ones, and the quests whose accept hands it over (a `use … quest Q` of Q's own item
/// waits on Q's accept: without it the goal is out with its quest).
#[derive(Default)]
struct Sources {
	sure: bool,
	whens: Vec<FxHashSet<String>>,
	accepts: FxHashSet<Key>,
}

/// The `when` predicates of a step, each as its JSON text, without a `!has <item>` on `item` (a step that gets
/// the item only when the bags lack it leaves no one without it).
fn when_set(step: &V, item: Option<&V>) -> FxHashSet<String> {
	step.get("when")
		.items()
		.iter()
		.filter(|p| !(p.get("k").as_str() == Some("has") && p.get("neg").truthy() && item.is_some_and(|i| key(&p.get("item")) == key(i))))
		.map(|p| {
			let o = V::obj();
			for (k, x) in p.entries() {
				if &*k != "line" {
					o.set(&k, x);
				}
			}
			crate::js::stringify(&o, None)
		})
		.collect()
}

/// The items goal `goal` puts in the bags (got_item, an accept's handed-over item, a turn-in's fixed rewards).
fn gives(goal: &V, data: &Data) -> Vec<V> {
	let mut out: Vec<V> = got_item(goal).into_iter().collect();
	let q = goal.get("quest");
	if q.is_undef() {
		return out;
	}
	let qd = data.quest(&q);
	if !qd.truthy() {
		return out;
	}
	match t_of(goal).as_str() {
		"accept" => {
			if !qd.get("sourceItem").is_nullish() {
				out.push(qd.get("sourceItem"));
			}
		}
		"turnin" => {
			for r in qd.get("web").get("items").items() {
				let id = if r.is_arr() { r.at(0) } else { r };
				if !id.is_nullish() {
					out.push(id);
				}
			}
		}
		_ => {}
	}
	out
}

/// The item a goal needs in the bags to be done: a `use` of it, or an `accept` of a quest only an item starts.
fn needs(goal: &V, data: &Data) -> Option<V> {
	match t_of(goal).as_str() {
		"use" => Some(goal.get("item")).filter(|i| !i.is_nullish()),
		"accept" => {
			let q = data.quest(&goal.get("quest"));
			let start = q.get("start");
			if !start.truthy() || !start.get("npc").items().is_empty() || !start.get("object").items().is_empty() {
				return None;
			}
			start.get("item").items().into_iter().next().filter(|i| !i.is_nullish())
		}
		_ => None,
	}
}

/// item-skippable (module docs). `before`: the guides chaining into g (their goals count as earlier).
pub fn check_skippable_items(g: &V, before: &[V], data: &Data, allow: &Allow, diag: &mut Diagnostics) {
	let mut sources: FxHashMap<Key, Sources> = FxHashMap::default();
	let note = |sources: &mut FxHashMap<Key, Sources>, step: &V, goal: &V| {
		for i in gives(goal, data) {
			let s = sources.entry(key(&i)).or_default();
			if t_of(goal) == "accept" {
				s.accepts.insert(key(&goal.get("quest")));
			}
			let whens = when_set(step, Some(&i));
			if !goal.get("optional").truthy() && whens.is_empty() {
				s.sure = true;
			} else {
				s.whens.push(if goal.get("optional").truthy() { FxHashSet::from_iter([String::from("optional")]) } else { whens });
			}
		}
	};
	for a in before {
		for step in a.get("steps").items() {
			for goal in step.get("goals").items() {
				note(&mut sources, &step, &goal);
			}
		}
	}
	for step in g.get("steps").items() {
		let gated = has_gates(&step);
		for goal in step.get("goals").items() {
			if !goal.get("optional").truthy() {
				if let Some(item) = needs(&goal, data) {
					let mine = when_set(&step, None);
					let own = goal.get("quest");
					// The quests the step holds in the log or done (`when onquest`, `complete`, `turnedin`): their
					// accepts ran for whoever sees the step.
					let held: FxHashSet<Key> = step
						.get("when")
						.items()
						.iter()
						.filter(|p| !p.get("neg").truthy() && matches!(p.get("k").as_str(), Some("onquest" | "complete" | "turnedin")))
						.flat_map(|p| if p.get("q").is_arr() { p.get("q").items() } else { vec![p.get("q")] })
						.map(|q| key(&q))
						.collect();
					// Skippable only when no source always runs, none has a `when` this step shares (an optional
					// source never does), and none is the accept of the goal's own quest or of a quest the step holds.
					let open = sources
						.get(&key(&item))
						.is_some_and(|s| !s.sure && !s.whens.iter().any(|w| w.is_subset(&mine)) && (own.is_undef() || !s.accepts.contains(&key(&own))) && !s.accepts.iter().any(|a| held.contains(a)));
					if open && !gated.contains(&key(&item)) {
						let what = if t_of(&goal) == "use" { "`use`".to_string() } else { format!("`accept {}`, a quest the item starts,", quest_name(data, &goal.get("quest"))) };
						report(
							diag,
							allow,
							g,
							goal.hidden("_line").num(),
							"item-skippable",
							("item", &item),
							format!("{what} needs {} in the bags, but every earlier goal that gets it is `optional` or in a step with a `when` this step does not share: a player who passed them is held here", item_name(data, &item)),
							&format!("give the step `when has {}`, or make a goal that gets the item required", ts(&item)),
						);
					}
				}
			}
			note(&mut sources, &step, &goal);
		}
	}
}

/// Goal kinds that work a quest's objectives.
const WORK: &[&str] = &["complete", "kill", "collect", "use", "interact", "talk", "explore", "cast"];

/// An event objective this close to the hand-in (yards) happens there: the find is at the ender.
const EVENT_AT_ENDER_YARDS: f64 = 30.0;

/// Whether `goal` works objective `o` (quest_objectives' entry) of quest `q`: `complete Q`, a goal bound to Q (no
/// line, or this line), or an unbound goal at the objective's npc or object.
fn works(goal: &V, q: &V, o: &V) -> bool {
	let t = t_of(goal);
	if !WORK.contains(&t.as_str()) {
		return false;
	}
	let gq = goal.get("quest");
	if !gq.is_undef() {
		return key(&gq) == key(q) && (t == "complete" || goal.get("oi").is_undef() || goal.get("oi").num() == o.get("index").num());
	}
	let id = o.get("id");
	match o.get("kind").as_str() {
		Some("kill" | "talk") => matches!(t.as_str(), "kill" | "talk") && !goal.get("npc").is_undef() && key(&goal.get("npc")) == key(&id),
		Some("object") => t == "interact" && !goal.get("object").is_undef() && key(&goal.get("object")) == key(&id),
		_ => false,
	}
}

/// handin-unworked (module docs). `before`: the guides chaining into g.
pub fn check_unworked_turnins(g: &V, before: &[V], data: &Data, allow: &Allow, diag: &mut Diagnostics) {
	let earlier: Vec<(V, V)> = before.iter().flat_map(|a| a.get("steps").items().into_iter().flat_map(|s| s.get("goals").items().into_iter().map(move |x| (s.clone(), x)))).collect();
	let list: Vec<(V, V)> = g.get("steps").items().into_iter().flat_map(|s| s.get("goals").items().into_iter().map(move |x| (s.clone(), x))).collect();
	for (t, (step, goal)) in list.iter().enumerate() {
		if t_of(goal) != "turnin" || goal.get("direct").truthy() || goal.get("optional").truthy() {
			continue;
		}
		let q = goal.get("quest");
		let qd = data.quest(&q);
		if !qd.truthy() {
			continue;
		}
		let ender = qd.get("end");
		let (end_npc, end_obj) = (ender.get("npc").items(), ender.get("object").items());
		let objectives = data.quest_objectives(&q);
		let raw = qd.get("objectives").items();
		let items: FxHashSet<Key> = objectives.iter().filter(|o| o.get("kind").as_str() == Some("item") && !o.get("id").is_nullish()).map(|o| key(&o.get("id"))).collect();
		// The step waits for the work: `when complete Q`, or `when has` one of Q's items.
		let guarded = step.get("when").items().iter().any(|p| {
			!p.get("neg").truthy()
				&& match p.get("k").as_str() {
					Some("complete") => {
						let pq = p.get("q");
						if pq.is_arr() {
							pq.items().iter().any(|x| key(x) == key(&q))
						} else {
							key(&pq) == key(&q)
						}
					}
					Some("has") => items.contains(&key(&p.get("item"))),
					_ => false,
				}
		});
		if guarded {
			continue;
		}
		let here = crate::validate::world_point(data, &goal.get("map"), &goal.get("x"), &goal.get("y"), &goal.get("f"));
		// The goals that count: since Q's last accept in this guide (with along steps before it), else everything
		// before the turn-in here and in the guides chaining in.
		let accept = list[..t].iter().rposition(|(_, x)| t_of(x) == "accept" && key(&x.get("quest")) == key(&q));
		let span: Vec<&(V, V)> = match accept {
			Some(a) => list[a + 1..t].iter().chain(list[..a].iter().filter(|(s, _)| s.get("along").truthy())).collect(),
			None => list[..t].iter().chain(earlier.iter()).collect(),
		};
		let open: Vec<String> = objectives
			.iter()
			.filter(|o| matches!(o.get("kind").as_str(), Some("kill" | "talk" | "object" | "event")))
			.filter(|o| {
				let id = o.get("id");
				let at_ender = match o.get("kind").as_str() {
					Some("kill" | "talk") => !id.is_nullish() && end_npc.iter().any(|n| key(n) == key(&id)),
					Some("object") => !id.is_nullish() && end_obj.iter().any(|n| key(n) == key(&id)),
					// An event whose spot (the objective's map/x/y in the data) is at the hand-in.
					_ => {
						let r = raw.get(o.get("index").num() as usize - 1).cloned().unwrap_or_default();
						let spot = if r.get("map").is_undef() { None } else { crate::validate::world_point(data, &r.get("map"), &r.get("x"), &r.get("y"), &r.get("f")) };
						matches!((spot, here), (Some(a), Some(b)) if ((a.0 - b.0).powi(2) + (a.1 - b.1).powi(2)).sqrt() <= EVENT_AT_ENDER_YARDS)
					}
				};
				!at_ender && !span.iter().any(|(_, x)| works(x, &q, o))
			})
			.map(|o| crate::data::objective_label(&q, o))
			.collect();
		if !open.is_empty() {
			report(
				diag,
				allow,
				g,
				goal.hidden("_line").num(),
				"handin-unworked",
				("quest", &q),
				format!("quest {} is turned in, but no earlier goal works its objective {}: the guide window goes from the accept straight to the hand-in", quest_name(data, &q), open.join(", ")),
				&format!(
					"add `complete {}` after the accept (it lists the objective and leads to its place), or the objective's own goal (`kill <npc> quest {}.<n>`, `interact <object> quest {}.<n>`)",
					ts(&q),
					ts(&q),
					ts(&q)
				),
			);
		}
	}
}
