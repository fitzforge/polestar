//! The compiled guide as the addon holds it: the fields of a compiled guide (forge-guide's `V`, what
//! emit.js writes to Guides.lua under GOAL_KEYS/STEP_KEYS/WHEN_KEYS) the engine reads, with Lua's
//! truthiness (`nil`/`false` absent, `0` and `""` present).

use forge_guide::js::V;
use rustc_hash::FxHashMap;

/// Lua truthiness of a field: anything but nil and false.
pub(crate) fn lua_true(v: &V) -> bool {
	!matches!(v, V::Undef | V::Null | V::Bool(false))
}

/// `tonumber(x)` for a number or a numeric string.
fn tonumber(v: &V) -> Option<f64> {
	match v {
		V::Num(n) => Some(*n),
		V::Str(s) => s.trim().parse::<f64>().ok(),
		_ => None,
	}
}

fn num(v: &V, k: &str) -> Option<f64> {
	v.get(k).as_num()
}

fn id(v: &V, k: &str) -> Option<u32> {
	num(v, k).map(|n| n as u32)
}

fn text(v: &V, k: &str) -> Option<String> {
	v.get(k).as_str().map(str::to_string)
}

fn strs(v: &V) -> Vec<String> {
	v.as_arr().map(|a| a.to_vec().iter().filter_map(|x| x.as_str().map(str::to_string)).collect()).unwrap_or_default()
}

/// A quest list field (`pre`, `preAll`, `closedBy`); None when absent (Lua `type(x) == "table"` fails).
fn ids(v: &V, k: &str) -> Option<Vec<u32>> {
	v.get(k).as_arr().map(|a| a.to_vec().iter().filter_map(|x| x.as_num()).map(|n| n as u32).collect())
}

/// `only = { classes, races, factions }`: AND across keys, OR within, `!x` excludes.
#[derive(Clone, Debug, Default)]
pub struct Only {
	pub classes: Vec<String>,
	pub races: Vec<String>,
	pub factions: Vec<String>,
}

impl Only {
	fn read(v: &V) -> Option<Only> {
		if !v.is_obj() {
			return None;
		}
		Some(Only { classes: strs(&v.get("classes")), races: strs(&v.get("races")), factions: strs(&v.get("factions")) })
	}
}

/// One `when` predicate (WHEN_KEYS); `q` holds one quest, or the list of an `onquest`.
#[derive(Clone, Debug, Default)]
pub struct Pred {
	pub k: String,
	pub neg: bool,
	pub op: Option<String>,
	pub n: Option<f64>,
	pub frac: Option<f64>,
	pub q: Vec<u32>,
	pub item: Option<u32>,
	pub spell: Option<u32>,
	pub name: Option<String>,
	pub label: Option<String>,
	pub area: Option<u32>,
	pub map: Option<u32>,
	pub skill_line: Option<u32>,
	pub min_level: Option<f64>,
	pub pre: Option<Vec<u32>>,
	pub pre_all: Option<Vec<u32>>,
	pub closed_by: Option<Vec<u32>>,
}

impl Pred {
	pub fn read(v: &V) -> Pred {
		let q = match v.get("q") {
			V::Num(n) => vec![n as u32],
			V::Arr(a) => a.to_vec().iter().filter_map(|x| x.as_num()).map(|n| n as u32).collect(),
			_ => Vec::new(),
		};
		Pred {
			k: text(v, "k").unwrap_or_default(),
			neg: lua_true(&v.get("neg")),
			op: text(v, "op"),
			n: num(v, "n"),
			frac: num(v, "frac"),
			q,
			item: id(v, "item"),
			spell: id(v, "spell"),
			name: text(v, "name"),
			label: text(v, "label"),
			area: id(v, "area"),
			map: id(v, "map"),
			skill_line: id(v, "skillLine"),
			min_level: num(v, "minLevel"),
			pre: ids(v, "pre"),
			pre_all: ids(v, "preAll"),
			closed_by: ids(v, "closedBy"),
		}
	}
	fn list(v: &V) -> Option<Vec<Pred>> {
		v.as_arr().map(|a| a.to_vec().iter().map(Pred::read).collect())
	}
}

/// A candidate NPC or farm spot of a `nearest` goal (CANDIDATE_KEYS).
#[derive(Clone, Debug)]
pub struct Cand {
	pub npc: Option<u32>,
	pub npc_name: Option<String>,
	pub map: Option<u32>,
	pub x: Option<f64>,
	pub y: Option<f64>,
	pub era: bool,
	pub faction: Option<String>,
	pub races: Vec<String>,
	pub classes: Vec<String>,
	pub lvl: Option<(Option<f64>, Option<f64>)>,
	pub rate: Option<f64>,
	pub spawns: Option<f64>,
}

/// A spawn area (SPOT_KEYS).
#[derive(Clone, Debug)]
pub struct Spot {
	pub x: f64,
	pub y: f64,
	pub r: Option<f64>,
	pub alt: bool,
}

/// The goal verbs the engine tells apart (`t`); `Other` for any it has no rule for (done never).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum T {
	Accept,
	Turnin,
	Complete,
	Kill,
	Interact,
	Use,
	Collect,
	Buy,
	Goto,
	Train,
	Talk,
	Vendor,
	Task,
	Abandon,
	Destroy,
	Money,
	Sethome,
	Enter,
	Hearth,
	Fly,
	Getfp,
	Level,
	Skill,
	Cast,
	Learn,
	Craft,
	Rep,
	Explore,
	Die,
	Achieve,
	Note,
	Other,
}

impl T {
	fn parse(s: &str) -> T {
		match s {
			"accept" => T::Accept,
			"turnin" => T::Turnin,
			"complete" => T::Complete,
			"kill" => T::Kill,
			"interact" => T::Interact,
			"use" => T::Use,
			"collect" => T::Collect,
			"buy" => T::Buy,
			"goto" => T::Goto,
			"train" => T::Train,
			"talk" => T::Talk,
			"vendor" => T::Vendor,
			"task" => T::Task,
			"abandon" => T::Abandon,
			"destroy" => T::Destroy,
			"money" => T::Money,
			"sethome" => T::Sethome,
			"enter" => T::Enter,
			"hearth" => T::Hearth,
			"fly" => T::Fly,
			"getfp" => T::Getfp,
			"level" => T::Level,
			"skill" => T::Skill,
			"cast" => T::Cast,
			"learn" => T::Learn,
			"craft" => T::Craft,
			"rep" => T::Rep,
			"explore" => T::Explore,
			"die" => T::Die,
			"achieve" => T::Achieve,
			"note" => T::Note,
			_ => T::Other,
		}
	}
}

/// A profession rank: a number, or a rank name ("Journeyman").
#[derive(Clone, Debug)]
pub enum Rank {
	Num(f64),
	Name(String),
}

/// One goal (GOAL_KEYS the engine reads).
#[derive(Clone, Debug)]
pub struct Goal {
	/// The compiled verb, as written (`t`).
	pub verb: String,
	pub t: T,
	pub class: bool,
	pub spell: Option<u32>,
	pub faction: Option<u32>,
	pub standing: Option<f64>,
	pub achievement: Option<u32>,
	pub criteria: Option<u32>,
	pub quest: Option<u32>,
	pub npc: Option<u32>,
	pub npc_name: Option<String>,
	pub object: Option<u32>,
	pub item: Option<u32>,
	pub count: Option<f64>,
	pub oi: Option<u32>,
	pub skill: Option<String>,
	pub skill_line: Option<u32>,
	pub rank: Option<Rank>,
	pub rank_max: Option<f64>,
	pub level: Option<f64>,
	pub frac: Option<f64>,
	pub money: Option<f64>,
	pub until_skill: Option<f64>,
	pub location: Option<String>,
	pub min_level: Option<f64>,
	pub qlvl: Option<f64>,
	pub pre: Option<Vec<u32>>,
	pub pre_all: Option<Vec<u32>>,
	pub closed_by: Option<Vec<u32>>,
	pub text: Option<String>,
	pub node: Option<u32>,
	pub area: Option<u32>,
	pub map: Option<u32>,
	pub x: Option<f64>,
	pub y: Option<f64>,
	pub era: bool,
	pub r: Option<f64>,
	pub spots: Option<Vec<Spot>>,
	pub spread: bool,
	pub optional: bool,
	pub only: Option<Only>,
	pub prof_line: Option<u32>,
	pub prof_name: Option<String>,
	pub prof_rank: Option<f64>,
	pub candidates: Option<Vec<Cand>>,
	pub direct: bool,
}

impl Goal {
	pub fn read(v: &V) -> Goal {
		let verb = text(v, "t").unwrap_or_default();
		let rank = match v.get("rank") {
			V::Num(n) => Some(Rank::Num(n)),
			V::Str(s) => Some(Rank::Name(s.to_string())),
			_ => None,
		};
		let candidates = v.get("candidates").as_arr().map(|a| {
			a.to_vec()
				.iter()
				.map(|c| {
					let lvl = match c.get("lvl") {
						V::Arr(_) => Some((c.get("lvl").at(0).as_num(), c.get("lvl").at(1).as_num())),
						V::Obj(_) => Some((num(&c.get("lvl"), "min"), num(&c.get("lvl"), "max"))),
						_ => None,
					};
					Cand {
						npc: id(c, "npc"),
						npc_name: text(c, "npcName"),
						map: id(c, "map"),
						x: num(c, "x"),
						y: num(c, "y"),
						era: c.get("f").as_str() == Some("e"),
						faction: text(c, "faction"),
						races: strs(&c.get("races")),
						classes: strs(&c.get("classes")),
						lvl,
						rate: tonumber(&c.get("rate")),
						spawns: tonumber(&c.get("spawns")),
					}
				})
				.collect()
		});
		let spots = v.get("spots").as_arr().map(|a| a.to_vec().iter().map(|s| Spot { x: s.get("x").num(), y: s.get("y").num(), r: num(s, "r"), alt: lua_true(&s.get("alt")) }).collect());
		Goal {
			t: T::parse(&verb),
			verb,
			class: lua_true(&v.get("class")),
			spell: id(v, "spell"),
			faction: id(v, "faction"),
			standing: num(v, "standing"),
			achievement: id(v, "achievement"),
			criteria: id(v, "criteria"),
			quest: id(v, "quest"),
			npc: id(v, "npc"),
			npc_name: text(v, "npcName"),
			object: id(v, "object"),
			item: id(v, "item"),
			count: num(v, "count"),
			oi: id(v, "oi"),
			skill: text(v, "skill"),
			skill_line: id(v, "skillLine"),
			rank,
			rank_max: num(v, "rankMax"),
			level: num(v, "level"),
			frac: num(v, "frac"),
			money: num(v, "money"),
			until_skill: num(v, "untilSkill"),
			location: text(v, "location"),
			min_level: tonumber(&v.get("minLevel")),
			qlvl: tonumber(&v.get("qlvl")),
			pre: ids(v, "pre"),
			pre_all: ids(v, "preAll"),
			closed_by: ids(v, "closedBy"),
			text: text(v, "text"),
			node: id(v, "node"),
			area: id(v, "area"),
			map: id(v, "map"),
			x: num(v, "x"),
			y: num(v, "y"),
			era: v.get("f").as_str() == Some("e"),
			r: num(v, "r"),
			spots,
			spread: lua_true(&v.get("spread")),
			optional: lua_true(&v.get("optional")),
			only: Only::read(&v.get("only")),
			prof_line: id(v, "profLine"),
			prof_name: text(v, "profName"),
			prof_rank: num(v, "profRank"),
			candidates,
			direct: lua_true(&v.get("direct")),
		}
	}

	/// The id a replay reports for the goal: its quest, else item, npc or spell (as the JS recorder).
	pub fn report_id(&self) -> Option<u32> {
		self.quest.or(self.item).or(self.npc).or(self.spell)
	}
}

/// `along`: not an along step, along until the guide's end, or until the step so labelled.
#[derive(Clone, Debug, PartialEq)]
pub enum Along {
	No,
	Yes,
	Until(String),
}

#[derive(Clone, Debug)]
pub struct Step {
	pub title: Option<String>,
	pub only: Option<Only>,
	pub when: Option<Vec<Pred>>,
	pub skipto: Option<Vec<(String, Pred)>>,
	pub label: Option<String>,
	pub along: Along,
	pub goals: Vec<Goal>,
}

/// A quest's accept, turn-in or abandon goal in a guide (layoutOf: `{ s, key, step, goal }`).
#[derive(Clone, Copy, Debug)]
pub struct At {
	pub s: usize,
	pub g: usize,
}

/// One compiled guide with its layout (Engine.lua layoutOf, Own.marksOf), steps and goals 1-based.
#[derive(Clone, Debug)]
pub struct Guide {
	pub id: String,
	pub steps: Vec<Step>,
	pub next: Option<String>,
	pub next_choices: Option<Vec<String>>,
	pub next_when: FxHashMap<String, Vec<Pred>>,
	pub category: Option<String>,
	pub min_level: Option<f64>,
	pub max_level: Option<f64>,
	pub races: Vec<String>,
	pub classes: Vec<String>,
	pub faction: Option<String>,
	pub accepts: FxHashMap<u32, Vec<At>>,
	pub turnins: FxHashMap<u32, Vec<At>>,
	pub abandons: FxHashMap<u32, Vec<At>>,
	pub labels: FxHashMap<String, usize>,
	pub along: Vec<usize>,
}

impl Guide {
	/// A compiled guide (`compileSources(...).guides[i]`).
	pub fn read(v: &V) -> Guide {
		let steps: Vec<Step> = v
			.get("steps")
			.as_arr()
			.map(|a| {
				a.to_vec()
					.iter()
					.map(|s| {
						let along = match s.get("along") {
							V::Str(l) => Along::Until(l.to_string()),
							x if lua_true(&x) => Along::Yes,
							_ => Along::No,
						};
						let skipto = s.get("skipto").as_arr().map(|a| a.to_vec().iter().map(|k| (text(k, "to").unwrap_or_default(), Pred::read(&k.get("when")))).collect());
						Step {
							title: text(s, "title"),
							only: Only::read(&s.get("only")),
							when: Pred::list(&s.get("when")),
							skipto,
							label: text(s, "label"),
							along,
							goals: s.get("goals").as_arr().map(|g| g.to_vec().iter().map(Goal::read).collect()).unwrap_or_default(),
						}
					})
					.collect()
			})
			.unwrap_or_default();
		let mut next_when = FxHashMap::default();
		if let Some(o) = v.get("nextWhen").as_obj() {
			for (k, p) in o.entries() {
				if let Some(list) = Pred::list(&p) {
					next_when.insert(k.to_string(), list);
				}
			}
		}
		let next_choices = v.get("nextChoices").as_arr().map(|_| strs(&v.get("nextChoices")));
		let mut g = Guide {
			id: text(v, "id").unwrap_or_default(),
			steps,
			next: text(v, "next"),
			next_choices,
			next_when,
			category: text(v, "category"),
			min_level: num(v, "minLevel"),
			max_level: num(v, "maxLevel"),
			races: strs(&v.get("races")),
			classes: strs(&v.get("classes")),
			faction: text(v, "faction"),
			accepts: FxHashMap::default(),
			turnins: FxHashMap::default(),
			abandons: FxHashMap::default(),
			labels: FxHashMap::default(),
			along: Vec::new(),
		};
		for (si, st) in g.steps.iter().enumerate() {
			let s = si + 1;
			if let Some(l) = &st.label {
				g.labels.insert(l.clone(), s);
			}
			if st.along != Along::No {
				g.along.push(s);
			}
			for (gi, goal) in st.goals.iter().enumerate() {
				let Some(q) = goal.quest else { continue };
				let by = match goal.t {
					T::Accept => &mut g.accepts,
					T::Turnin => &mut g.turnins,
					T::Abandon => &mut g.abandons,
					_ => continue,
				};
				by.entry(q).or_default().push(At { s, g: gi + 1 });
			}
		}
		g
	}

	pub fn step(&self, s: usize) -> &Step {
		&self.steps[s - 1]
	}

	pub fn goal(&self, s: usize, g: usize) -> &Goal {
		&self.steps[s - 1].goals[g - 1]
	}
}
