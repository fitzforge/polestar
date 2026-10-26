//! The typed guide model: what the writer produces and the judge consumes.
//!
//! - The writer builds a [`Guide`] (header, [`Step`]s, [`Goal`]s with their source fields) and renders it with
//!   [`Guide::to_source`] into `.guide` text (docs/GUIDE_FORMAT.md). That text goes through the compiler
//!   (parse, resolve, validate, tokens, emit) like any hand-written guide, so lint checks everything the writer
//!   emits and the pack bytes are the compiler's.
//! - The judge reads compiled guides with [`Guide::from_compiled`]: the same types, with the compiler's fill-ins
//!   ([`Filled`]: titles, givers, coordinates, prerequisites, spawn spots, smart-target candidates) set.
//!
//! Source fields per verb (what [`Goal::to_line`] writes):
//!
//! | verb | `id` | other |
//! |---|---|---|
//! | accept, turnin, complete, abandon | quest | `name` = title; `npc`/`object`/`item` givers; turnin `direct`, `xp`, `money`, `rewards`/`choose` |
//! | kill, talk, sethome?, getfp?, train, vendor | npc | `name` = NPC name; `nearest` (vendor/sethome); `class_trainer` (`train class`) |
//! | collect, use, buy, destroy | item | `count`, `quest_obj`, `nearest` (collect/buy) |
//! | interact | object | `quest_obj` |
//! | goto, explore | — | `at` (positional), `name` = label |
//! | sethome, hearth, fly, getfp, enter, die | — | `place` (quoted), or `nearest` (sethome) |
//! | level | — | `level`, `frac` |
//! | money | — | `money` (copper) |
//! | task, note | — | `text` (task: the quoted text; note: the words) |
//! | skill, train (profession) | — | `profession`, `rank`/`level` |
//! | learn, cast, craft | spell | `name`; craft `count`/`until` |
//! | rep | — | `faction_name`, `standing` |
//! | achieve | achievement | `name`, `criteria` |
//!
//! Common modifiers: `at` (`@x,y`, except goto/explore where it is positional), `map`, `r`, `live`,
//! `optional`, `only`, `group`, `text` (quoted text players see), `note` (` -- note`).

use crate::js::{to_fixed, V};

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum Verb {
	Accept,
	Turnin,
	Complete,
	Abandon,
	Destroy,
	Kill,
	Collect,
	Goto,
	Talk,
	Interact,
	Use,
	Sethome,
	Hearth,
	Die,
	Getfp,
	Fly,
	Enter,
	Train,
	Buy,
	Vendor,
	Level,
	Money,
	Task,
	Note,
	Skill,
	Learn,
	Cast,
	Craft,
	Rep,
	Explore,
	Achieve,
}

pub const VERBS: [(Verb, &str); 31] = [
	(Verb::Accept, "accept"),
	(Verb::Turnin, "turnin"),
	(Verb::Complete, "complete"),
	(Verb::Abandon, "abandon"),
	(Verb::Destroy, "destroy"),
	(Verb::Kill, "kill"),
	(Verb::Collect, "collect"),
	(Verb::Goto, "goto"),
	(Verb::Talk, "talk"),
	(Verb::Interact, "interact"),
	(Verb::Use, "use"),
	(Verb::Sethome, "sethome"),
	(Verb::Hearth, "hearth"),
	(Verb::Die, "die"),
	(Verb::Getfp, "getfp"),
	(Verb::Fly, "fly"),
	(Verb::Enter, "enter"),
	(Verb::Train, "train"),
	(Verb::Buy, "buy"),
	(Verb::Vendor, "vendor"),
	(Verb::Level, "level"),
	(Verb::Money, "money"),
	(Verb::Task, "task"),
	(Verb::Note, "note"),
	(Verb::Skill, "skill"),
	(Verb::Learn, "learn"),
	(Verb::Cast, "cast"),
	(Verb::Craft, "craft"),
	(Verb::Rep, "rep"),
	(Verb::Explore, "explore"),
	(Verb::Achieve, "achieve"),
];

impl Verb {
	pub fn as_str(self) -> &'static str {
		VERBS.iter().find(|(v, _)| *v == self).unwrap().1
	}
	pub fn parse(s: &str) -> Option<Verb> {
		VERBS.iter().find(|(_, n)| *n == s).map(|(v, _)| *v)
	}
}

/// `only` lists: AND across kinds, OR within one; compiled guides hold positive lists only.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Only {
	pub classes: Vec<String>,
	pub races: Vec<String>,
	pub factions: Vec<String>,
}

impl Only {
	pub fn is_empty(&self) -> bool {
		self.classes.is_empty() && self.races.is_empty() && self.factions.is_empty()
	}
	fn source(&self) -> String {
		self.factions.iter().chain(self.races.iter()).chain(self.classes.iter()).cloned().collect::<Vec<_>>().join(",")
	}
	fn from_v(v: &V) -> Option<Only> {
		if !v.is_obj() {
			return None;
		}
		let list = |k: &str| v.get(k).items().iter().map(|x| x.to_js_string()).collect();
		Some(Only { classes: list("classes"), races: list("races"), factions: list("factions") })
	}
}

/// A `when` predicate: `source` is its text as written after `when` (`level>=10`, `!turnedin 783`); `k` the kind.
#[derive(Clone, Debug, PartialEq)]
pub struct When {
	pub source: String,
	pub k: String,
	pub neg: bool,
	/// The compiled predicate (WHEN_KEYS), when read from a compiled guide.
	pub compiled: Option<V>,
}

impl When {
	pub fn new(source: impl Into<String>) -> When {
		let source = source.into();
		let t = source.trim_start_matches('!');
		let k = t.split([' ', '<', '>', '=']).next().unwrap_or("").to_string();
		When { neg: source.starts_with('!'), k, source, compiled: None }
	}
}

/// `skipto <label> when <predicate>`.
#[derive(Clone, Debug, PartialEq)]
pub struct Skipto {
	pub to: String,
	pub when: When,
}

/// Map-percent coordinates; `map` the uiMapID when not the zone in effect.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct At {
	pub x: f64,
	pub y: f64,
}

/// A spawn spot (compiled `spots`).
#[derive(Clone, Debug, PartialEq)]
pub struct Spot {
	pub x: f64,
	pub y: f64,
	pub z: Option<f64>,
	pub r: Option<f64>,
	pub n: Option<f64>,
	pub alt: bool,
}

/// A smart-target candidate (compiled `candidates`).
#[derive(Clone, Debug, PartialEq)]
pub struct Candidate {
	pub npc: Option<u32>,
	pub npc_name: Option<String>,
	pub map: u32,
	pub x: f64,
	pub y: f64,
	pub z: Option<f64>,
	pub faction: Option<String>,
	pub classes: Vec<String>,
	pub races: Vec<String>,
	/// Farm spots: mob levels { min, max }, items per kill, spawn count.
	pub lvl: Option<(f64, f64)>,
	pub rate: Option<f64>,
	pub spawns: Option<f64>,
}

/// What the compiler fills in from the data (GUIDE_FORMAT.md "Compiler fill-ins").
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Filled {
	pub title: Option<String>,
	pub target: Option<String>,
	pub npc_name: Option<String>,
	pub obj_name: Option<String>,
	pub item_name: Option<String>,
	pub spell_name: Option<String>,
	/// The objective index (`oi`) a kill/collect/interact counts by.
	pub oi: Option<u32>,
	pub min_level: Option<f64>,
	pub qlvl: Option<f64>,
	pub pre: Vec<u32>,
	pub pre_all: Vec<u32>,
	pub closed_by: Vec<u32>,
	pub location: Option<String>,
	pub map: Option<u32>,
	pub x: Option<f64>,
	pub y: Option<f64>,
	pub z: Option<f64>,
	pub area: Option<u32>,
	pub node: Option<u32>,
	pub spots: Vec<Spot>,
	pub spread: bool,
	pub candidates: Vec<Candidate>,
	pub from_npcs: Vec<(u32, String)>,
	pub escort: bool,
	pub skill_line: Option<u32>,
	pub prof_line: Option<u32>,
	pub prof_rank: Option<f64>,
	/// The compiled goal as the compiler made it, for anything not typed here.
	pub raw: Option<V>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Goal {
	pub verb: Verb,
	/// The verb's id: quest, npc, object, item, spell or achievement (see the module table).
	pub id: Option<u32>,
	/// The quoted name/title/label right after the id or verb.
	pub name: Option<String>,
	/// sethome/hearth/fly/getfp/enter/die: the place as the game names it.
	pub place: Option<String>,
	/// `nearest` (collect, buy, vendor, sethome, learn).
	pub nearest: bool,
	/// `train class`.
	pub class_trainer: bool,
	/// train/skill: profession name; train rank word; skill/level target.
	pub profession: Option<String>,
	pub rank: Option<String>,
	pub level: Option<f64>,
	/// `level N.frac` (0..1) for level goals.
	pub frac: Option<f64>,
	pub count: Option<u32>,
	/// `quest Q[.O]`.
	pub quest_obj: Option<(u32, Option<u32>)>,
	pub at: Option<At>,
	pub map: Option<u32>,
	pub r: Option<f64>,
	pub live: bool,
	pub npc: Option<u32>,
	pub object: Option<u32>,
	pub item: Option<u32>,
	pub lvl: Option<u32>,
	pub optional: bool,
	pub only: Option<Only>,
	pub group: Option<u32>,
	pub direct: bool,
	pub xp: Option<u32>,
	/// money goals and turnin `money`: copper.
	pub money: Option<u64>,
	pub rewards: Vec<u32>,
	pub choose: Vec<u32>,
	pub until: Option<u32>,
	pub criteria: Option<u32>,
	pub faction_name: Option<String>,
	pub standing: Option<String>,
	/// Quoted text players see instead of the generated one (`task`'s text, `note`'s words).
	pub text: Option<String>,
	/// ` -- note`.
	pub note: Option<String>,
	pub filled: Filled,
}

impl Goal {
	pub fn new(verb: Verb) -> Goal {
		Goal {
			verb,
			id: None,
			name: None,
			place: None,
			nearest: false,
			class_trainer: false,
			profession: None,
			rank: None,
			level: None,
			frac: None,
			count: None,
			quest_obj: None,
			at: None,
			map: None,
			r: None,
			live: false,
			npc: None,
			object: None,
			item: None,
			lvl: None,
			optional: false,
			only: None,
			group: None,
			direct: false,
			xp: None,
			money: None,
			rewards: Vec::new(),
			choose: Vec::new(),
			until: None,
			criteria: None,
			faction_name: None,
			standing: None,
			text: None,
			note: None,
			filled: Filled::default(),
		}
	}
	pub fn with_id(verb: Verb, id: u32) -> Goal {
		let mut g = Goal::new(verb);
		g.id = Some(id);
		g
	}

	/// The goal as one `.guide` line (without indentation).
	pub fn to_line(&self) -> String {
		let mut w: Vec<String> = vec![self.verb.as_str().to_string()];
		let q = |s: &str| quote(s);
		match self.verb {
			Verb::Goto | Verb::Explore => {
				if let Some(a) = self.at {
					w.push(format!("{},{}", coord(a.x), coord(a.y)));
				}
				if let Some(n) = &self.name {
					w.push(q(n));
				}
			}
			Verb::Sethome | Verb::Hearth | Verb::Fly | Verb::Getfp | Verb::Enter | Verb::Die => {
				if self.nearest {
					w.push("nearest".into());
				} else if let Some(p) = &self.place {
					w.push(q(p));
				}
			}
			Verb::Level => {
				let l = self.level.unwrap_or(1.0);
				w.push(match self.frac {
					Some(f) if f > 0.0 => {
						let s = to_fixed(l + f, 2);
						s.trim_end_matches('0').trim_end_matches('.').to_string()
					}
					_ => crate::js::num_str(l),
				});
			}
			Verb::Money => w.push(self.money.unwrap_or(0).to_string()),
			Verb::Task => w.push(q(self.text.as_deref().unwrap_or(""))),
			Verb::Note => w.push(self.text.clone().unwrap_or_default()),
			Verb::Skill => {
				w.push(q(self.profession.as_deref().unwrap_or("")));
				w.push(crate::js::num_str(self.level.unwrap_or(1.0)));
			}
			Verb::Rep => {
				w.push(q(self.faction_name.as_deref().unwrap_or("")));
				w.push(self.standing.clone().unwrap_or_default());
			}
			Verb::Train if self.class_trainer => w.push("class".into()),
			Verb::Train if self.profession.is_some() => {
				w.push(q(self.profession.as_deref().unwrap()));
				if let Some(r) = &self.rank {
					w.push(r.clone());
				}
			}
			Verb::Vendor if self.nearest => w.push("nearest".into()),
			_ => {
				if let Some(id) = self.id {
					w.push(id.to_string());
				}
				if let Some(n) = &self.name {
					w.push(q(n));
				}
			}
		}
		if self.nearest && matches!(self.verb, Verb::Collect | Verb::Buy | Verb::Learn) {
			w.push("nearest".into());
		}
		if let Some(c) = self.count {
			w.push(format!("x{c}"));
		}
		if let Some((qid, o)) = self.quest_obj {
			w.push("quest".into());
			w.push(match o {
				Some(o) => format!("{qid}.{o}"),
				None => qid.to_string(),
			});
		}
		for (k, v) in [("npc", self.npc), ("object", self.object), ("item", self.item), ("lvl", self.lvl)] {
			if let Some(v) = v {
				w.push(format!("{k} {v}"));
			}
		}
		if let Some(m) = self.map {
			w.push(format!("map {m}"));
		}
		if let Some(a) = self.at.filter(|_| !matches!(self.verb, Verb::Goto | Verb::Explore)) {
			w.push(format!("@{},{}", coord(a.x), coord(a.y)));
		}
		if let Some(r) = self.r {
			w.push(format!("r {}", crate::js::num_str(r)));
		}
		if self.live {
			w.push("live".into());
		}
		if let Some(x) = self.xp {
			w.push(format!("xp {x}"));
		}
		if let (Verb::Turnin, Some(m)) = (self.verb, self.money) {
			w.push(format!("money {m}"));
		}
		if !self.choose.is_empty() {
			w.push(format!("choose {}", self.choose.iter().map(u32::to_string).collect::<Vec<_>>().join(" ")));
		}
		if !self.rewards.is_empty() {
			w.push(format!("reward {}", self.rewards.iter().map(u32::to_string).collect::<Vec<_>>().join(" ")));
		}
		if let Some(u) = self.until {
			w.push(format!("until {u}"));
		}
		if let Some(c) = self.criteria {
			w.push(format!("criteria {c}"));
		}
		if self.direct {
			w.push("direct".into());
		}
		if self.optional {
			w.push("optional".into());
		}
		if let Some(o) = self.only.as_ref().filter(|o| !o.is_empty()) {
			w.push(format!("only {}", o.source()));
		}
		if let Some(gr) = self.group {
			w.push(format!("group {gr}"));
		}
		if let Some(t) = self.text.as_ref().filter(|_| !matches!(self.verb, Verb::Task | Verb::Note)) {
			w.push(q(t));
		}
		let mut line = w.join(" ");
		if let Some(n) = &self.note {
			line.push_str(" -- ");
			line.push_str(n);
		}
		line
	}
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct Step {
	pub title: Option<String>,
	/// Tips, one per `tip` line (the compiled step note joins them with "\n").
	pub tips: Vec<String>,
	/// `zone <Name>` / `zone map <id>` set on this step (source only).
	pub zone: Option<String>,
	pub only: Option<Only>,
	pub when: Vec<When>,
	pub label: Option<String>,
	/// `along`, with the label `along until` names when Some(Some).
	pub along: Option<Option<String>>,
	pub skipto: Vec<Skipto>,
	pub loop_: bool,
	pub goals: Vec<Goal>,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct Guide {
	pub id: String,
	pub title: String,
	pub min_level: u32,
	pub max_level: u32,
	pub zone: String,
	pub faction: Option<String>,
	pub races: Vec<String>,
	pub classes: Vec<String>,
	pub category: Option<String>,
	pub folder: Option<String>,
	/// `next` options in order, each with its `when` predicate.
	pub next: Vec<(String, Option<When>)>,
	pub pitch: Option<String>,
	pub pros: Vec<String>,
	pub cons: Vec<String>,
	pub author: Option<String>,
	pub version: Option<u32>,
	pub live_coords: bool,
	/// Comment lines written right after the `guide` line (`# ...`).
	pub comments: Vec<String>,
	pub steps: Vec<Step>,
}

/// A quoted token: the lexer escapes only `\"` and `\\`.
pub fn quote(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\""))
}

fn coord(v: f64) -> String {
	let s = to_fixed(v, 2);
	let s = s.trim_end_matches('0').trim_end_matches('.');
	if s.is_empty() || s == "-" {
		"0".into()
	} else {
		s.to_string()
	}
}

impl Guide {
	/// The guide as `.guide` source text (docs/GUIDE_FORMAT.md).
	pub fn to_source(&self) -> String {
		let mut o = String::new();
		let mut line = |s: String| {
			o.push_str(&s);
			o.push('\n');
		};
		line(format!("guide {}", self.id));
		for c in &self.comments {
			line(format!("# {c}"));
		}
		line(format!("title {}", self.title));
		line(format!("levels {}-{}", self.min_level, self.max_level));
		line(format!("zone {}", self.zone));
		if let Some(f) = &self.faction {
			line(format!("faction {f}"));
		}
		if !self.races.is_empty() {
			line(format!("race {}", self.races.join(", ")));
		}
		if !self.classes.is_empty() {
			line(format!("class {}", self.classes.join(", ")));
		}
		if let Some(c) = &self.category {
			line(format!("category {c}"));
		}
		if let Some(f) = &self.folder {
			line(format!("folder {f}"));
		}
		if let Some(a) = &self.author {
			line(format!("author {a}"));
		}
		if let Some(v) = self.version {
			line(format!("version {v}"));
		}
		if self.live_coords {
			line("coords live".into());
		}
		for (id, when) in &self.next {
			match when {
				Some(w) => line(format!("next {id} when {}", w.source)),
				None => line(format!("next {id}")),
			}
		}
		if let Some(p) = &self.pitch {
			line(format!("pitch {p}"));
		}
		for p in &self.pros {
			line(format!("pro {p}"));
		}
		for c in &self.cons {
			line(format!("con {c}"));
		}
		for s in &self.steps {
			line(String::new());
			line(match &s.title {
				Some(t) if !t.is_empty() => format!("step {t}"),
				_ => "step".into(),
			});
			if let Some(z) = &s.zone {
				line(format!("  zone {z}"));
			}
			if let Some(l) = &s.label {
				line(format!("  label {l}"));
			}
			if let Some(o) = s.only.as_ref().filter(|o| !o.is_empty()) {
				line(format!("  only {}", o.source()));
			}
			for w in &s.when {
				line(format!("  when {}", w.source));
			}
			match &s.along {
				Some(Some(l)) => line(format!("  along until {l}")),
				Some(None) => line("  along".into()),
				None => {}
			}
			for k in &s.skipto {
				line(format!("  skipto {} when {}", k.to, k.when.source));
			}
			if s.loop_ {
				line("  loop".into());
			}
			for t in &s.tips {
				line(format!("  tip {t}"));
			}
			for g in &s.goals {
				line(format!("  {}", g.to_line()));
			}
		}
		o
	}

	/// The typed view of a compiled guide (resolve_guide's result, or its `_localised` copy).
	pub fn from_compiled(g: &V) -> Guide {
		let s = |v: V| v.as_str().map(str::to_string);
		let list = |v: V| v.items().iter().map(|x| x.to_js_string()).collect::<Vec<_>>();
		let mut next: Vec<(String, Option<When>)> = list(g.get("next")).into_iter().map(|id| (id, None)).collect();
		let nw = g.get("nextWhen");
		for (id, w) in next.iter_mut() {
			let p = nw.get(id);
			if p.truthy() {
				*w = Some(When { source: String::new(), k: p.get("k").to_js_string(), neg: p.get("neg").truthy(), compiled: Some(p) });
			}
		}
		Guide {
			id: g.get("id").to_js_string(),
			title: g.get("title").to_js_string(),
			min_level: g.get("minLevel").num() as u32,
			max_level: g.get("maxLevel").num() as u32,
			zone: s(g.get("zoneName")).unwrap_or_default(),
			faction: s(g.get("faction")),
			races: list(g.get("races")),
			classes: list(g.get("classes")),
			category: s(g.get("category")),
			folder: s(g.get("folder")),
			next,
			pitch: s(g.get("pitch")),
			pros: list(g.get("pros")),
			cons: list(g.get("cons")),
			author: s(g.get("author")),
			version: g.get("version").as_num().map(|v| v as u32),
			live_coords: false,
			comments: Vec::new(),
			steps: g.get("steps").items().iter().map(step_from_compiled).collect(),
		}
	}
}

fn num_u32(v: V) -> Option<u32> {
	v.as_num().filter(|n| *n >= 0.0).map(|n| n as u32)
}

fn ids(v: V) -> Vec<u32> {
	match v {
		V::Num(n) => vec![n as u32],
		v => v.items().iter().filter_map(|x| num_u32(x.clone())).collect(),
	}
}

fn step_from_compiled(st: &V) -> Step {
	let note = st.get("note").as_str().map(str::to_string);
	let along = match st.get("along") {
		V::Bool(true) => Some(None),
		V::Str(l) => Some(Some(l.to_string())),
		_ => None,
	};
	Step {
		title: st.get("title").as_str().map(str::to_string),
		tips: note.map(|n| n.split('\n').map(str::to_string).collect()).unwrap_or_default(),
		zone: None,
		only: Only::from_v(&st.get("only")),
		when: st.get("when").items().iter().map(|p| When { source: String::new(), k: p.get("k").to_js_string(), neg: p.get("neg").truthy(), compiled: Some(p.clone()) }).collect(),
		label: st.get("label").as_str().map(str::to_string),
		along,
		skipto: st
			.get("skipto")
			.items()
			.iter()
			.map(|k| {
				let p = k.get("when");
				Skipto { to: k.get("to").to_js_string(), when: When { source: String::new(), k: p.get("k").to_js_string(), neg: p.get("neg").truthy(), compiled: Some(p) } }
			})
			.collect(),
		loop_: false,
		goals: st.get("goals").items().iter().filter_map(goal_from_compiled).collect(),
	}
}

fn goal_from_compiled(c: &V) -> Option<Goal> {
	let verb = Verb::parse(c.get("t").as_str()?)?;
	let s = |k: &str| c.get(k).as_str().map(str::to_string);
	let n = |k: &str| c.get(k).as_num();
	let mut g = Goal::new(verb);
	g.id = match verb {
		Verb::Accept | Verb::Turnin | Verb::Complete | Verb::Abandon => num_u32(c.get("quest")),
		Verb::Kill | Verb::Talk | Verb::Train | Verb::Vendor | Verb::Sethome | Verb::Getfp => num_u32(c.get("npc")),
		Verb::Collect | Verb::Use | Verb::Buy | Verb::Destroy => num_u32(c.get("item")),
		Verb::Interact => num_u32(c.get("object")),
		Verb::Learn | Verb::Cast | Verb::Craft => num_u32(c.get("spell")),
		Verb::Achieve => num_u32(c.get("achievement")),
		_ => None,
	};
	g.class_trainer = verb == Verb::Train && c.get("class").truthy();
	g.place = s("location");
	g.level = n("level");
	g.frac = n("frac");
	g.count = num_u32(c.get("count"));
	if !matches!(verb, Verb::Accept | Verb::Turnin | Verb::Complete | Verb::Abandon) {
		if let Some(q) = num_u32(c.get("quest")) {
			g.quest_obj = Some((q, num_u32(c.get("oi"))));
		}
	}
	g.map = num_u32(c.get("map"));
	g.at = match (n("x"), n("y")) {
		(Some(x), Some(y)) => Some(At { x, y }),
		_ => None,
	};
	g.r = n("r");
	g.optional = c.get("optional").truthy();
	g.only = Only::from_v(&c.get("only"));
	g.group = num_u32(c.get("group"));
	g.direct = c.get("direct").truthy();
	g.money = n("money").map(|m| m as u64);
	g.until = num_u32(c.get("untilSkill"));
	g.criteria = num_u32(c.get("criteria"));
	g.faction_name = s("factionName");
	g.standing = c.get("standing").as_num().map(crate::js::num_str);
	g.text = s("text");
	g.note = s("note");
	g.profession = s("skill");
	g.npc = if g.id.is_some() && matches!(verb, Verb::Kill | Verb::Talk | Verb::Train | Verb::Vendor) { None } else { num_u32(c.get("npc")) };
	let spots = c.get("spots");
	g.filled = Filled {
		title: s("title"),
		target: s("target"),
		npc_name: s("npcName"),
		obj_name: s("objName"),
		item_name: s("itemName"),
		spell_name: s("spellName"),
		oi: num_u32(c.get("oi")),
		min_level: n("minLevel"),
		qlvl: n("qlvl"),
		pre: ids(c.get("pre")),
		pre_all: ids(c.get("preAll")),
		closed_by: ids(c.get("closedBy")),
		location: s("location"),
		map: num_u32(c.get("map")),
		x: n("x"),
		y: n("y"),
		z: n("z"),
		area: num_u32(c.get("area")),
		node: num_u32(c.get("node")),
		spots: spots
			.items()
			.iter()
			.map(|p| Spot { x: p.get("x").num(), y: p.get("y").num(), z: p.get("z").as_num(), r: p.get("r").as_num(), n: p.get("n").as_num(), alt: p.get("alt").truthy() })
			.collect(),
		spread: c.get("spread").truthy(),
		candidates: c
			.get("candidates")
			.items()
			.iter()
			.map(|k| Candidate {
				npc: num_u32(k.get("npc")),
				npc_name: k.get("npcName").as_str().map(str::to_string),
				map: k.get("map").num() as u32,
				x: k.get("x").num(),
				y: k.get("y").num(),
				z: k.get("z").as_num(),
				faction: k.get("faction").as_str().map(str::to_string),
				classes: k.get("classes").items().iter().map(|x| x.to_js_string()).collect(),
				races: k.get("races").items().iter().map(|x| x.to_js_string()).collect(),
				lvl: k.get("lvl").as_obj().map(|_| (k.get("lvl").get("min").num(), k.get("lvl").get("max").num())),
				rate: k.get("rate").as_num(),
				spawns: k.get("spawns").as_num(),
			})
			.collect(),
		from_npcs: c.get("fromNpcs").items().iter().map(|f| (f.get("npc").num() as u32, f.get("npcName").to_js_string())).collect(),
		escort: c.get("escort").truthy(),
		skill_line: num_u32(c.get("skillLine")),
		prof_line: num_u32(c.get("profLine")),
		prof_rank: n("profRank"),
		raw: Some(c.clone()),
	};
	Some(g)
}

/// A small guide built with the model, covering the verbs and step lines the writer uses. The committed
/// fixture tests/fixtures/mini/forever/test/01-valley.guide is its rendering; the parity test compiles it
/// with the JS and the Rust compiler.
pub fn fixture() -> Guide {
	let mut g = Guide {
		id: "forever/test/01-valley".into(),
		title: "Valley of Trials".into(),
		min_level: 1,
		max_level: 6,
		zone: "Durotar".into(),
		faction: Some("Horde".into()),
		races: vec!["Orc".into(), "Troll".into()],
		next: vec![("forever/horde/orc-troll/02-the-barrens".into(), Some(When::new("level>=5")))],
		comments: vec!["Written by the typed model (polestar-guide model::fixture).".into()],
		..Default::default()
	};
	let mut s1 = Step { title: Some("Kaltunk".into()), ..Default::default() };
	let mut a = Goal::with_id(Verb::Accept, 4641);
	a.note = Some("Kaltunk, where you start".into());
	s1.goals.push(a);
	g.steps.push(s1);
	let mut s2 = Step { title: Some("Gornek".into()), tips: vec!["Gornek waits inside the Den.".into()], label: Some("den".into()), ..Default::default() };
	s2.goals.push(Goal::with_id(Verb::Turnin, 4641));
	s2.goals.push(Goal::with_id(Verb::Accept, 788));
	s2.goals.push(Goal::with_id(Verb::Accept, 97279));
	g.steps.push(s2);
	let mut s3 = Step { title: Some("Training weapons and boars".into()), ..Default::default() };
	let mut c = Goal::with_id(Verb::Collect, 277653);
	c.quest_obj = Some((97279, Some(1)));
	s3.goals.push(c);
	let mut k = Goal::with_id(Verb::Kill, 3098);
	k.quest_obj = Some((788, Some(1)));
	k.count = Some(10);
	s3.goals.push(k);
	let mut go = Goal::new(Verb::Goto);
	go.at = Some(At { x: 42.4, y: 68.6 });
	go.name = Some("The Den".into());
	s3.goals.push(go);
	g.steps.push(s3);
	let mut s4 = Step { title: Some("The Den".into()), ..Default::default() };
	s4.when.push(When::new("level<6"));
	s4.goals.push(Goal::with_id(Verb::Turnin, 788));
	let mut t = Goal::new(Verb::Train);
	t.class_trainer = true;
	t.optional = true;
	s4.goals.push(t);
	let mut v = Goal::new(Verb::Vendor);
	v.nearest = true;
	v.only = Some(Only { classes: vec!["Warrior".into()], ..Default::default() });
	s4.goals.push(v);
	let mut l = Goal::new(Verb::Level);
	l.level = Some(5.0);
	l.frac = Some(0.5);
	s4.goals.push(l);
	g.steps.push(s4);
	g
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn fixture_is_the_model_rendering() {
		let path = concat!(env!("CARGO_MANIFEST_DIR"), "/tests/fixtures/mini/forever/test/01-valley.guide");
		let text = fixture().to_source();
		if std::env::var_os("WRITE_FIXTURE").is_some() {
			std::fs::create_dir_all(std::path::Path::new(path).parent().unwrap()).unwrap();
			std::fs::write(path, &text).unwrap();
		}
		assert_eq!(std::fs::read_to_string(path).unwrap(), text);
	}

	#[test]
	fn fixture_round_trips_through_the_parser() {
		let mut diag = crate::diag::Diagnostics::new();
		let ast = crate::parse::parse_guide(&fixture().to_source(), "01-valley.guide", &mut diag);
		assert!(diag.list.is_empty(), "{:?}", diag.list);
		assert_eq!(ast.get("steps").len(), 4);
		assert_eq!(ast.get("steps").at(3).get("goals").len(), 4);
	}

	#[test]
	fn renders_source() {
		let mut g = Guide { id: "forever/horde/test".into(), title: "Test".into(), min_level: 1, max_level: 6, zone: "Durotar".into(), faction: Some("Horde".into()), ..Default::default() };
		let mut st = Step { title: Some("Valley of Trials".into()), tips: vec!["Pull one at a time.".into()], ..Default::default() };
		st.goals.push(Goal::with_id(Verb::Accept, 4641));
		let mut k = Goal::with_id(Verb::Kill, 3098);
		k.count = Some(10);
		k.quest_obj = Some((788, Some(1)));
		k.at = Some(At { x: 44.125, y: 60.0 });
		st.goals.push(k);
		let mut go = Goal::new(Verb::Goto);
		go.at = Some(At { x: 42.5, y: 68.25 });
		go.name = Some("Den \"cave\"".into());
		st.goals.push(go);
		g.steps.push(st);
		assert_eq!(
			g.to_source(),
			"guide forever/horde/test\ntitle Test\nlevels 1-6\nzone Durotar\nfaction Horde\n\nstep Valley of Trials\n  tip Pull one at a time.\n  accept 4641\n  kill 3098 x10 quest 788.1 @44.13,60\n  goto 42.5,68.25 \"Den \\\"cave\\\"\"\n"
		);
	}
}
