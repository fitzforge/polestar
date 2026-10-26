//! Acceptance cases (port of tools/lib/sim/cases.js): every reported route problem as a property of
//! a route's action list, with its reporter's credit (tests/fixtures/sim/cases/reported.json,
//! schema 1).
//!
//! An [`Action`] is `{ t, level, area, pt, act, quest?, objective?, camp?, npc?, item?, count?, via? }`
//! (`via`: `pass` for work on a walk leg, `sweep` for work in a chosen area). A [`Ref`] picks actions
//! by `quest, step, objective, item, npc, camp, area, act`, where `step` is an act or `objective`
//! (kill, loot or use). A [`Place`] is `{ map, x, y, yards, f? }` in map percent, Era frame unless
//! `f` is `l` (the other frame set when a map has only one).
//!
//! A visit is the maximal run of consecutive non-travel actions in one area; travel does not end a
//! visit that comes back to the same area.

use forge_core::frames::Rect;
use forge_core::jsnum::{js_hypot, js_round, js_to_string};
use forge_core::{MapId, Projector};
use serde::de::{Deserializer, MapAccess, Visitor};
use serde::Deserialize;
use serde_json::Value;
use std::cell::OnceCell;
use std::fmt;

/// Travel acts: they do not end a visit.
pub const TRAVEL: [&str; 6] = ["walk", "fly", "boat", "ride", "hearth", "deathskip"];
const WORK: [&str; 3] = ["kill", "loot", "use"];
const STEPS: [&str; 3] = ["accept", "turnin", "objective"];
/// The properties [`check_case`] knows (cases.js PROPS).
pub const PROPERTIES: [&str; 14] =
	["singleVisit", "before", "beforeOrSameVisit", "sameVisit", "notBefore", "never", "taken", "campOf", "notCampOf", "onLeg", "boundAt", "hearthSpacing", "notThrough", "mode"];
/// params.js PRIORS means the properties use.
pub const HEARTH_COOLDOWN: f64 = 3600.0;
pub const RUN_SPEED: f64 = 7.0;
pub const MOUNT_LEVEL: f64 = 40.0;
pub const MOUNT_MUL: f64 = 1.6;

fn is_travel(act: &str) -> bool {
	TRAVEL.contains(&act)
}
fn is_work(act: &str) -> bool {
	WORK.contains(&act)
}

/// One action of a route, as the cases see it.
#[derive(Clone, Debug, Default, Deserialize, PartialEq)]
pub struct Action {
	pub t: f64,
	pub level: f64,
	#[serde(default)]
	pub area: Option<i64>,
	#[serde(default)]
	pub pt: Option<i64>,
	pub act: String,
	#[serde(default)]
	pub quest: Option<i64>,
	#[serde(default)]
	pub objective: Option<i64>,
	#[serde(default)]
	pub camp: Option<i64>,
	#[serde(default)]
	pub npc: Option<i64>,
	#[serde(default)]
	pub item: Option<i64>,
	#[serde(default)]
	pub count: Option<f64>,
	#[serde(default)]
	pub via: Option<String>,
	/// Travel: `[zone, seconds, ...]` spent in enemy zones (v2/territory.js).
	#[serde(default)]
	pub enemy: Option<Vec<f64>>,
}

/// A v2 route's raw action (v2/sim.js runRoute): quest, objective and camp are run indices.
#[derive(Clone, Debug, Default, Deserialize)]
pub struct RouteAction {
	#[serde(flatten)]
	pub base: Action,
	/// Farm: the objectives (run indices) its kills credited.
	#[serde(default)]
	pub objs: Option<Vec<usize>>,
}

/// What [`case_actions`] needs of a compiled v2 run (run2): per run quest its id; per run objective
/// its quest, type (kill item object event talk), npc or item id, and raw objective index (`oi`,
/// -1 when none stands behind it); per run camp its world camp id.
#[derive(Clone, Debug, Default, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RunIndex {
	pub quest_ids: Vec<i64>,
	pub o_quest: Vec<usize>,
	pub o_type: Vec<u8>,
	pub o_id: Vec<i64>,
	pub o_oi: Vec<i64>,
	pub c_world: Vec<i64>,
}

const OBJ_ACT: [&str; 5] = ["kill", "loot", "use", "use", "use"];

/// cases.js caseActions: a v2 route's actions as the actions the cases check.
pub fn case_actions(run: &RunIndex, actions: &[RouteAction]) -> Vec<Action> {
	let obj_act = |a: &Action, o: usize, camp: Option<i64>| -> Action {
		let ty = run.o_type[o] as usize;
		let oi = run.o_oi[o];
		Action {
			t: a.t,
			level: a.level,
			area: a.area,
			pt: a.pt,
			act: OBJ_ACT[ty].to_string(),
			quest: Some(run.quest_ids[run.o_quest[o]]),
			objective: (oi >= 0).then_some(oi),
			camp,
			npc: (ty == 0).then(|| run.o_id[o]),
			item: (ty == 1).then(|| run.o_id[o]),
			via: a.via.clone(),
			..Action::default()
		}
	};
	let mut out = Vec::with_capacity(actions.len());
	for ra in actions {
		let a = &ra.base;
		if a.act == "farm" {
			if let Some(objs) = ra.objs.as_ref().filter(|o| !o.is_empty()) {
				let camp = a.camp.map(|c| run.c_world[c as usize]);
				out.extend(objs.iter().map(|&o| obj_act(a, o, camp)));
				continue;
			}
		}
		if let Some(o) = a.objective.filter(|_| a.act == "use" || a.act == "event") {
			out.push(obj_act(a, o as usize, None));
			continue;
		}
		let mut x = a.clone();
		x.quest = a.quest.filter(|&q| q >= 0).map(|q| run.quest_ids[q as usize]);
		x.objective = a.objective.map(|o| run.o_oi[o as usize]).filter(|&oi| oi >= 0);
		x.camp = a.camp.map(|c| run.c_world[c as usize]);
		out.push(x);
	}
	out
}

/// A Ref: its fields in the case's key order (for the messages).
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Ref(pub Vec<(String, Value)>);

impl<'de> Deserialize<'de> for Ref {
	fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
		struct V;
		impl<'de> Visitor<'de> for V {
			type Value = Ref;
			fn expecting(&self, f: &mut fmt::Formatter) -> fmt::Result {
				f.write_str("an object")
			}
			fn visit_map<M: MapAccess<'de>>(self, mut m: M) -> Result<Ref, M::Error> {
				let mut v = Vec::new();
				while let Some((k, x)) = m.next_entry::<String, Value>()? {
					v.push((k, x));
				}
				Ok(Ref(v))
			}
		}
		d.deserialize_map(V)
	}
}

impl Ref {
	fn get(&self, k: &str) -> Option<&Value> {
		self.0.iter().find(|(kk, _)| kk == k).map(|(_, v)| v).filter(|v| !v.is_null())
	}
	fn num(&self, k: &str) -> Option<f64> {
		self.get(k).and_then(Value::as_f64)
	}
	/// A place: a ref with a map.
	pub fn is_place(&self) -> bool {
		self.get("map").is_some()
	}
	fn place(&self) -> Place {
		Place {
			map: self.num("map").unwrap_or(f64::NAN),
			x: self.num("x").unwrap_or(f64::NAN),
			y: self.num("y").unwrap_or(f64::NAN),
			yards: self.num("yards").unwrap_or(f64::NAN),
			f: self.get("f").and_then(Value::as_str).map(str::to_string),
		}
	}
	fn text(&self) -> String {
		if self.is_place() {
			return format!("{} {},{}", vtext(self.get("map")), vtext(self.get("x")), vtext(self.get("y")));
		}
		self.0.iter().map(|(k, v)| format!("{k} {}", vtext(Some(v)))).collect::<Vec<_>>().join(" ")
	}
}

/// JS template-literal text of a JSON value.
fn vtext(v: Option<&Value>) -> String {
	match v {
		None => "undefined".into(),
		Some(Value::Null) => "null".into(),
		Some(Value::String(s)) => s.clone(),
		Some(Value::Number(n)) => js_to_string(n.as_f64().unwrap_or(f64::NAN)),
		Some(Value::Bool(b)) => b.to_string(),
		Some(Value::Array(a)) => a.iter().map(|x| if x.is_null() { String::new() } else { vtext(Some(x)) }).collect::<Vec<_>>().join(","),
		Some(Value::Object(_)) => "[object Object]".into(),
	}
}

fn eq_num(a: Option<i64>, v: &Value) -> bool {
	match (a, v.as_f64()) {
		(Some(x), Some(y)) => x as f64 == y,
		_ => false,
	}
}

/// cases.js matches.
pub fn matches(a: &Action, r: &Ref) -> bool {
	for (k, v) in &r.0 {
		if v.is_null() {
			continue;
		}
		let hit = match k.as_str() {
			"quest" => eq_num(a.quest, v),
			"step" => match v.as_str() {
				Some("objective") => is_work(&a.act),
				Some(s) => a.act == s,
				None => false,
			},
			"objective" => eq_num(a.objective, v),
			"item" => eq_num(a.item, v),
			"npc" => eq_num(a.npc, v),
			"camp" => eq_num(a.camp, v),
			"area" => eq_num(a.area, v),
			"act" => v.as_str() == Some(a.act.as_str()),
			_ => true,
		};
		if !hit {
			return false;
		}
	}
	true
}

/// A place `{ map, x, y, yards, f? }`.
#[derive(Clone, Debug, PartialEq)]
pub struct Place {
	pub map: f64,
	pub x: f64,
	pub y: f64,
	pub yards: f64,
	pub f: Option<String>,
}

/// planner/geo.js Geo.toWorld over the core projector's frames: the frame set f's first (`e` the
/// Era set, anything else the live one), the other when the map has none.
pub fn to_world(proj: &Projector, map: MapId, x: f64, y: f64, f: &str) -> Option<(i64, f64, f64)> {
	let b: Rect = if f == "e" { proj.era_bounds(map).or_else(|| proj.live_bounds(map)) } else { proj.live_bounds(map).or_else(|| proj.era_bounds(map)) }?;
	Some((b.c, b.top + (b.bottom - b.top) * (y / 100.0), b.left + (b.right - b.left) * (x / 100.0)))
}

/// The sim world's parts the cases read (world-<faction>.json): points `[c, _, wx, wy, map, ...]`,
/// camps' points, inns, and the danger grid's cell size.
#[derive(Clone, Debug, Default)]
pub struct CaseWorld {
	pub points: Vec<WorldPoint>,
	pub camp_pts: Vec<Option<i64>>,
	pub inns: Vec<(String, i64)>,
	/// world.danger[0].cell (yards); None when the world has no danger grid.
	pub danger_cell: Option<f64>,
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub struct WorldPoint {
	pub c: i64,
	pub wx: f64,
	pub wy: f64,
	pub map: i64,
}

#[derive(Deserialize)]
struct WorldRaw {
	#[serde(default)]
	points: Vec<Vec<Value>>,
	#[serde(default)]
	camps: Vec<CampRaw>,
	#[serde(default)]
	inns: Vec<InnRaw>,
	#[serde(default)]
	danger: Vec<DangerRaw>,
}
#[derive(Deserialize)]
struct CampRaw {
	pt: Option<i64>,
}
#[derive(Deserialize)]
struct InnRaw {
	name: String,
	pt: i64,
}
#[derive(Deserialize)]
struct DangerRaw {
	cell: f64,
}

impl CaseWorld {
	/// From a sim world's JSON (world-<faction>.json; other keys ignored).
	pub fn from_json(bytes: &[u8]) -> Result<Self, serde_json::Error> {
		let raw: WorldRaw = serde_json::from_slice(bytes)?;
		let n = |p: &[Value], i: usize| p.get(i).and_then(Value::as_f64).unwrap_or(f64::NAN);
		Ok(CaseWorld {
			points: raw.points.iter().map(|p| WorldPoint { c: n(p, 0) as i64, wx: n(p, 2), wy: n(p, 3), map: n(p, 4) as i64 }).collect(),
			camp_pts: raw.camps.into_iter().map(|c| c.pt).collect(),
			inns: raw.inns.into_iter().map(|i| (i.name, i.pt)).collect(),
			danger_cell: raw.danger.first().map(|d| d.cell),
		})
	}

	#[cfg(feature = "native")]
	pub fn load(path: &std::path::Path) -> Result<Self, String> {
		let b = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
		Self::from_json(&b).map_err(|e| format!("{}: {e}", path.display()))
	}

	fn point(&self, pt: i64) -> Option<&WorldPoint> {
		usize::try_from(pt).ok().and_then(|i| self.points.get(i))
	}
}

/// One acceptance case (reported.json). `raw` keeps the whole entry.
#[derive(Clone, Debug, Deserialize)]
pub struct Case {
	pub id: String,
	#[serde(default)]
	pub title: Option<String>,
	#[serde(default)]
	pub faction: String,
	#[serde(default)]
	pub race: Option<String>,
	#[serde(default)]
	pub cls: Option<String>,
	#[serde(default)]
	pub class: Option<String>,
	#[serde(default)]
	pub property: Option<String>,
	#[serde(default)]
	pub todo: Option<String>,
	#[serde(default)]
	pub a: Option<Ref>,
	#[serde(default)]
	pub b: Option<Ref>,
	#[serde(default)]
	pub from: Option<Ref>,
	#[serde(default)]
	pub to: Option<Ref>,
	#[serde(default)]
	pub near: Option<Ref>,
	#[serde(default)]
	pub quests: Vec<i64>,
	#[serde(default)]
	pub quest: Option<i64>,
	#[serde(default)]
	pub objective: Option<i64>,
	#[serde(default)]
	pub item: Option<i64>,
	#[serde(default)]
	pub npc: Option<i64>,
	#[serde(default)]
	pub act: Option<String>,
	#[serde(default)]
	pub step: Option<String>,
	#[serde(default)]
	pub steps: Option<Value>,
	#[serde(default, rename = "match")]
	pub match_: Option<Value>,
	#[serde(default)]
	pub level: Option<f64>,
	#[serde(default)]
	pub levels: Option<(f64, f64)>,
	#[serde(default)]
	pub map: Option<i64>,
	#[serde(default)]
	pub inns: Vec<String>,
	#[serde(default, rename = "minSec")]
	pub min_sec: Option<f64>,
	#[serde(default)]
	pub without: Vec<String>,
	#[serde(default)]
	pub source: Option<Value>,
}

impl Case {
	fn steps(&self) -> Vec<String> {
		self.steps.as_ref().and_then(Value::as_array).map(|a| a.iter().filter_map(|s| s.as_str().map(str::to_string)).collect()).unwrap_or_default()
	}
	fn match_refs(&self) -> Option<Vec<Ref>> {
		self.match_.as_ref().map(|m| serde_json::from_value(m.clone()).unwrap_or_default())
	}
}

/// A case's outcome: `ok` None for a todo case (not checkable yet).
#[derive(Clone, Debug, PartialEq)]
pub struct Outcome {
	pub ok: Option<bool>,
	pub why: String,
}

fn ok(why: &str) -> Result<Outcome, String> {
	Ok(Outcome { ok: Some(true), why: why.to_string() })
}
fn fail(why: String) -> Result<Outcome, String> {
	Ok(Outcome { ok: Some(false), why })
}

fn fmt_action(a: &Action) -> String {
	let mut what = vec![a.act.clone()].into_iter().filter(|s| !s.is_empty()).collect::<Vec<_>>();
	if let Some(q) = a.quest {
		what.push(format!("quest {q}"));
	}
	if let Some(o) = a.objective {
		what.push(format!("objective {o}"));
	}
	if let Some(i) = a.item {
		what.push(format!("item {i}"));
	}
	if let Some(n) = a.npc {
		what.push(format!("npc {n}"));
	}
	let level = if a.level.is_finite() { js_round(a.level * 10.0) / 10.0 } else { a.level };
	let area = a.area.map_or("undefined".to_string(), |x| x.to_string());
	format!("{} at t={}s, level {}, area {}", what.join(" "), js_to_string(a.t), js_to_string(level), area)
}

/// cases.js visits: visit id per action (None for travel).
pub fn visits(actions: &[Action]) -> Vec<Option<usize>> {
	let mut out = Vec::with_capacity(actions.len());
	let mut id: Option<usize> = None;
	let mut area: Option<Option<i64>> = None;
	for a in actions {
		if is_travel(&a.act) {
			out.push(None);
			continue;
		}
		if area != Some(a.area) {
			id = Some(id.map_or(0, |i| i + 1));
			area = Some(a.area);
		}
		out.push(id);
	}
	out
}

fn first_idx(actions: &[Action], r: &Ref) -> Option<usize> {
	actions.iter().position(|a| matches(a, r))
}

/// The geometry a place needs: the core projector over map-frames.json.
pub struct Geo<'a> {
	pub proj: &'a Projector,
}

/// cases.js placeTest: resolves the place on the first call.
struct PlaceTest<'a> {
	near: Place,
	world: &'a CaseWorld,
	geo: Option<&'a Geo<'a>>,
	at: OnceCell<(i64, f64, f64)>,
}

impl PlaceTest<'_> {
	fn test(&self, pt: i64) -> Result<bool, String> {
		let at = match self.at.get() {
			Some(a) => *a,
			None => {
				let geo = self.geo.ok_or("a place needs map frames: pass { geo } (cases.loadGeo(dataDir))")?;
				let w = if self.near.map.fract() == 0.0 && self.near.map >= 0.0 {
					to_world(geo.proj, self.near.map as MapId, self.near.x, self.near.y, self.near.f.as_deref().unwrap_or("e"))
				} else {
					None
				};
				let w = w.ok_or_else(|| format!("map {} has no frame", js_to_string(self.near.map)))?;
				let _ = self.at.set(w);
				w
			}
		};
		Ok(self.world.point(pt).is_some_and(|p| p.c == at.0 && js_hypot(p.wx - at.1, p.wy - at.2) <= self.near.yards))
	}
}

fn need<'c, T>(v: &'c Option<T>, id: &str, k: &str) -> Result<&'c T, String> {
	v.as_ref().ok_or_else(|| format!("case {id}: no {k}"))
}

fn single_visit(c: &Case, actions: &[Action]) -> Result<Outcome, String> {
	let steps = c.steps();
	let picks = c.match_refs();
	let mine = |a: &Action| {
		a.quest.is_some_and(|q| c.quests.contains(&q))
			&& !is_travel(&a.act)
			&& (steps.is_empty() || steps.iter().any(|s| if s == "objective" { is_work(&a.act) } else { a.act == *s }))
			&& picks.as_ref().is_none_or(|m| m.iter().any(|r| matches(a, r)))
	};
	let Some(first) = actions.iter().position(mine) else { return ok("none of the quests is in the route") };
	let last = actions.iter().rposition(mine).unwrap_or(first);
	let used: Vec<Option<i64>> = actions.iter().filter(|a| mine(a)).map(|a| a.area).collect();
	for i in first + 1..last {
		let a = &actions[i];
		if is_travel(&a.act) || used.contains(&a.area) {
			continue;
		}
		let next = actions[i + 1..=last].iter().find(|x| mine(x)).expect("last is mine");
		return fail(format!("{} comes after {}, outside the quests' areas", fmt_action(next), fmt_action(a)));
	}
	ok("")
}

fn before(c: &Case, actions: &[Action], same_visit: bool) -> Result<Outcome, String> {
	let (ra, rb) = (need(&c.a, &c.id, "a")?, need(&c.b, &c.id, "b")?);
	let i = first_idx(actions, ra);
	let Some(j) = first_idx(actions, rb) else { return ok(if i.is_none() { "neither happens" } else { "b never happens" }) };
	let Some(i) = i else { return fail(format!("{} happens and {} never does", fmt_action(&actions[j]), ra.text())) };
	if i < j {
		return ok("");
	}
	if !same_visit {
		return fail(format!("{} comes before {}", fmt_action(&actions[j]), fmt_action(&actions[i])));
	}
	let v = visits(actions);
	if v[i].is_some() && v[i] == v[j] {
		ok("")
	} else {
		fail(format!("{} comes a visit before {}", fmt_action(&actions[j]), fmt_action(&actions[i])))
	}
}

fn same_visit(c: &Case, actions: &[Action]) -> Result<Outcome, String> {
	let (ra, rb) = (need(&c.a, &c.id, "a")?, need(&c.b, &c.id, "b")?);
	let v = visits(actions);
	let (mut va, mut vb) = (Vec::new(), Vec::new());
	for (i, a) in actions.iter().enumerate() {
		let Some(x) = v[i] else { continue };
		if matches(a, ra) && !va.contains(&x) {
			va.push(x);
		}
		if matches(a, rb) && !vb.contains(&x) {
			vb.push(x);
		}
	}
	if va.is_empty() || vb.is_empty() {
		return fail(format!("{} never happens", if va.is_empty() { ra } else { rb }.text()));
	}
	if va.iter().any(|x| vb.contains(x)) {
		return ok("");
	}
	let j = first_idx(actions, rb).expect("b happens");
	let i = first_idx(actions, ra).expect("a happens");
	fail(format!("{} is on another visit than {}", fmt_action(&actions[j]), fmt_action(&actions[i])))
}

fn step_ref(quest: Option<i64>, step: Option<&str>) -> Ref {
	let mut v = Vec::new();
	if let Some(q) = quest {
		v.push(("quest".to_string(), Value::from(q)));
	}
	if let Some(s) = step {
		v.push(("step".to_string(), Value::from(s)));
	}
	Ref(v)
}

fn camp_check(c: &Case, actions: &[Action], world: &CaseWorld, geo: Option<&Geo>, inside: bool) -> Result<Outcome, String> {
	let near_ref = need(&c.near, &c.id, "near")?;
	let test = PlaceTest { near: near_ref.place(), world, geo, at: OnceCell::new() };
	let work: Vec<&Action> = actions
		.iter()
		.filter(|a| (a.act == "kill" || a.act == "loot") && a.quest.is_some() && a.quest == c.quest && (c.objective.is_none() || a.objective == c.objective) && a.camp.is_some())
		.collect();
	if work.is_empty() {
		return ok("no camp work for the objective");
	}
	for a in work {
		let camp = a.camp.and_then(|k| usize::try_from(k).ok()).and_then(|k| world.camp_pts.get(k));
		let hit = match camp {
			Some(Some(pt)) => test.test(*pt)?,
			_ => false,
		};
		if hit != inside {
			let n = &test.near;
			return fail(format!(
				"{} uses camp {}, {} {} yd of {} {},{}",
				fmt_action(a),
				a.camp.unwrap(),
				if inside { "not within" } else { "within" },
				js_to_string(n.yards),
				vtext(near_ref.get("map")),
				vtext(near_ref.get("x")),
				vtext(near_ref.get("y"))
			));
		}
	}
	ok("")
}

fn on_leg(c: &Case, actions: &[Action]) -> Result<Outcome, String> {
	let mut v: Vec<(String, Value)> = Vec::new();
	let mut put = |k: &str, x: Option<Value>| {
		if let Some(x) = x {
			v.push((k.to_string(), x));
		}
	};
	put("quest", c.quest.map(Value::from));
	put("step", c.step.clone().map(Value::from));
	put("objective", c.objective.map(Value::from));
	put("item", c.item.map(Value::from));
	put("npc", c.npc.map(Value::from));
	put("act", c.act.clone().map(Value::from));
	let r = Ref(v);
	let Some(i) = first_idx(actions, &r) else { return fail(format!("{} never happens", r.text())) };
	let a = &actions[i];
	if a.via.as_deref() == Some("pass") {
		ok("")
	} else {
		fail(format!("{} is not done on a walk leg (via {})", fmt_action(a), a.via.as_deref().filter(|s| !s.is_empty()).unwrap_or("none")))
	}
}

fn bound_at(c: &Case, actions: &[Action], world: &CaseWorld) -> Result<Outcome, String> {
	let allowed: Option<Vec<i64>> = (!c.inns.is_empty()).then(|| world.inns.iter().filter(|(n, _)| c.inns.contains(n)).map(|(_, p)| *p).collect());
	let mut bound: Option<Option<i64>> = None;
	for a in actions {
		if a.act == "bind" {
			bound = Some(a.pt);
		}
		if a.act != "hearth" {
			continue;
		}
		// JS `bound == null`: never bound, or bound to an action without a point.
		let b = bound.flatten();
		if b.is_none() || a.pt != b {
			let pt = a.pt.map_or("undefined".to_string(), |p| p.to_string());
			let at = b.map_or("nothing".to_string(), |p| format!("point {p}"));
			return fail(format!("{} goes to point {pt}, bound at {at}", fmt_action(a)));
		}
		if let Some(al) = &allowed {
			if !a.pt.is_some_and(|p| al.contains(&p)) {
				return fail(format!("{} goes to an inn outside {}", fmt_action(a), c.inns.join(", ")));
			}
		}
	}
	ok("")
}

fn hearth_spacing(c: &Case, actions: &[Action]) -> Result<Outcome, String> {
	let min = c.min_sec.unwrap_or(HEARTH_COOLDOWN);
	let mut last: Option<&Action> = None;
	for a in actions.iter().filter(|a| a.act == "hearth") {
		if let Some(l) = last {
			if a.t - l.t < min {
				return fail(format!("{} comes {} s after the last hearth (t={}s; at least {} s)", fmt_action(a), js_to_string(js_round(a.t - l.t)), js_to_string(l.t), js_to_string(min)));
			}
		}
		last = Some(a);
	}
	ok("")
}

fn not_through(c: &Case, actions: &[Action], world: &CaseWorld) -> Result<Outcome, String> {
	let (lo, hi) = c.levels.unwrap_or((0.0, f64::INFINITY));
	let cell = world.danger_cell.unwrap_or(200.0);
	let allow = |lv: f64| cell / (RUN_SPEED * if lv >= MOUNT_LEVEL { MOUNT_MUL } else { 1.0 });
	let in_map = |pt: Option<i64>| pt.and_then(|p| world.point(p)).is_some_and(|p| Some(p.map) == c.map);
	let sec_in = |a: &Action| -> f64 {
		let mut s = 0.0;
		if let Some(e) = &a.enemy {
			let mut k = 0;
			while k < e.len() {
				if Some(e[k]) == c.map.map(|m| m as f64) {
					s += e.get(k + 1).copied().unwrap_or(f64::NAN);
				}
				k += 2;
			}
		}
		s
	};
	let mine = |a: &Action| a.quest.is_some_and(|q| c.quests.contains(&q)) && !is_travel(&a.act);
	for (i, a) in actions.iter().enumerate() {
		if !mine(a) || a.level < lo || a.level > hi {
			continue;
		}
		for b in actions[..i].iter().rev() {
			if !is_travel(&b.act) {
				if mine(b) || in_map(b.pt) {
					continue;
				}
				break;
			}
			let s = sec_in(b);
			if s > allow(b.level) {
				let map = c.map.map_or("undefined".to_string(), |m| m.to_string());
				return fail(format!(
					"{} spends {} s in map {map} (over one {} yd cell, {} s) on the way to {}",
					fmt_action(b),
					js_to_string(js_round(s)),
					js_to_string(cell),
					js_to_string(js_round(allow(b.level))),
					fmt_action(a)
				));
			}
		}
	}
	ok("")
}

fn mode(c: &Case, actions: &[Action], world: &CaseWorld, geo: Option<&Geo>) -> Result<Outcome, String> {
	let (rf, rt) = (need(&c.from, &c.id, "from")?, need(&c.to, &c.id, "to")?);
	let mk = |r: &Ref| r.is_place().then(|| PlaceTest { near: r.place(), world, geo, at: OnceCell::new() });
	let (pf, pto) = (mk(rf), mk(rt));
	let at = |r: &Ref, p: &Option<PlaceTest>, a: &Action| -> Result<bool, String> {
		match p {
			Some(t) => match a.pt {
				Some(pt) => t.test(pt),
				None => Ok(false),
			},
			None => Ok(matches(a, r)),
		}
	};
	let mut from: Option<usize> = None;
	for (i, a) in actions.iter().enumerate() {
		if let Some(f) = from {
			if at(rt, &pto, a)? {
				let legs: Vec<&Action> = actions[f + 1..=i].iter().filter(|x| is_travel(&x.act)).collect();
				if let Some(bad) = legs.iter().find(|x| c.without.contains(&x.act)) {
					return fail(format!("{} on the way from {} to {}", fmt_action(bad), rf.text(), rt.text()));
				}
				if !legs.iter().any(|x| Some(&x.act) == c.act.as_ref()) {
					let act = c.act.as_deref().unwrap_or("undefined");
					return fail(format!("{} is reached from {} without a {act}", fmt_action(a), rf.text()));
				}
				from = None;
			}
		}
		// A walk arriving at the place counts: the trip leaves from there.
		if at(rf, &pf, a)? {
			from = Some(i);
		}
	}
	ok("")
}

/// cases.js checkCase. Err: what JS throws (an unknown property, a place without frames).
pub fn check_case(c: &Case, actions: &[Action], world: &CaseWorld, geo: Option<&Geo>) -> Result<Outcome, String> {
	if let Some(t) = &c.todo {
		return Ok(Outcome { ok: None, why: format!("todo: {t}") });
	}
	let prop = c.property.as_deref().unwrap_or("undefined");
	match prop {
		"singleVisit" => single_visit(c, actions),
		"before" => before(c, actions, false),
		"beforeOrSameVisit" => before(c, actions, true),
		"sameVisit" => same_visit(c, actions),
		"notBefore" => {
			let step = c.step.as_deref().unwrap_or("accept");
			let r = step_ref(c.quest, Some(step));
			let lv = c.level.unwrap_or(f64::NAN);
			match actions.iter().find(|x| matches(x, &r) && x.level < lv) {
				Some(a) => fail(format!("{}: below level {}", fmt_action(a), js_to_string(lv))),
				None => ok(""),
			}
		}
		"never" => match actions.iter().find(|x| x.act == "accept" && x.quest.is_some() && x.quest == c.quest) {
			Some(a) => fail(format!("{}: never expected", fmt_action(a))),
			None => ok(""),
		},
		"taken" => {
			if actions.iter().any(|x| x.act == "accept" && x.quest.is_some() && x.quest == c.quest) {
				ok("")
			} else {
				fail(format!("quest {} is never accepted", c.quest.map_or("undefined".to_string(), |q| q.to_string())))
			}
		}
		"campOf" => camp_check(c, actions, world, geo, true),
		"notCampOf" => camp_check(c, actions, world, geo, false),
		"onLeg" => on_leg(c, actions),
		"boundAt" => bound_at(c, actions, world),
		"hearthSpacing" => hearth_spacing(c, actions),
		"notThrough" => not_through(c, actions, world),
		"mode" => mode(c, actions, world, geo),
		p => Err(format!("case {}: unknown property {p}", c.id)),
	}
}

/// sim cases' per-case form: an error fails its case (`error: ...`).
pub fn check_case_or_fail(c: &Case, actions: &[Action], world: &CaseWorld, geo: Option<&Geo>) -> Outcome {
	check_case(c, actions, world, geo).unwrap_or_else(|e| Outcome { ok: Some(false), why: format!("error: {e}") })
}

/// cases.js loadCases: reported.json (`{ schema: 1, cases: [] }`), validated.
pub fn parse_cases(bytes: &[u8], file: &str) -> Result<Vec<Case>, String> {
	let doc: Value = serde_json::from_slice(bytes).map_err(|e| format!("{file}: {e}"))?;
	let list = match (doc.get("schema").and_then(Value::as_f64), doc.get("cases").and_then(Value::as_array)) {
		(Some(1.0), Some(l)) => l,
		_ => return Err(format!("{file}: expected {{ schema: 1, cases: [] }}")),
	};
	// Typed from the bytes, not the Value: refs keep their key order (the messages show it).
	#[derive(Deserialize)]
	struct Doc {
		cases: Vec<Case>,
	}
	let typed = serde_json::from_slice::<Doc>(bytes).map_err(|e| format!("{file}: {e}"))?.cases;
	let mut seen: Vec<&str> = Vec::new();
	for raw in list {
		let id = raw.get("id").and_then(Value::as_str).filter(|s| !s.is_empty());
		let Some(id) = id.filter(|i| !seen.contains(i)) else {
			return Err(format!("{file}: missing or duplicate id {}", vtext(raw.get("id"))));
		};
		seen.push(id);
		let fac = raw.get("faction");
		if !matches!(fac.and_then(Value::as_str), Some("Alliance" | "Horde")) {
			return Err(format!("{file}: {id}: faction {}", vtext(fac)));
		}
		let todo = raw.get("todo").is_some_and(|t| !matches!(t, Value::Null | Value::Bool(false)) && t != "" && t.as_f64() != Some(0.0));
		let prop = raw.get("property");
		if !todo && !prop.and_then(Value::as_str).is_some_and(|p| PROPERTIES.contains(&p)) {
			return Err(format!("{file}: {id}: unknown property {}", vtext(prop)));
		}
		let refs = raw.get("source").and_then(|s| s.get("refs")).and_then(Value::as_array);
		if refs.is_none_or(|r| r.is_empty()) {
			return Err(format!("{file}: {id}: no source refs"));
		}
		if let Some(s) = raw.get("steps").filter(|v| !v.is_null()) {
			let good = s.as_array().is_some_and(|a| a.iter().all(|x| x.as_str().is_some_and(|x| STEPS.contains(&x))));
			if !good {
				return Err(format!("{file}: {id}: steps must be a list of {} (got {s})", STEPS.join(", ")));
			}
		}
		if let Some(m) = raw.get("match").filter(|v| !v.is_null()) {
			let good = m.as_array().is_some_and(|a| !a.is_empty() && a.iter().all(|r| r.as_object().is_some_and(|o| !o.is_empty())));
			if !good {
				return Err(format!("{file}: {id}: match must be a non-empty list of refs (got {m})"));
			}
		}
	}
	Ok(typed)
}
