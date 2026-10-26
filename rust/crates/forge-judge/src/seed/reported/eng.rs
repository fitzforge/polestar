//! The guides-reported tests that play a guide in the addon engine (forge-judge engine): the JS
//! helpers engineRun, questGoalStatus and stepView (a guide opened by `E.SetGuide` after a login with
//! no tab), playGuide (SIMULATE on the stub world, with the scripts' wraps of its helpers as
//! [`engine::Hooks`]), the "Skip grey quests" view fields, and the two tests on the shipped data
//! (the codex list cache, the walking maps' hubs).

use std::cell::RefCell;
use std::rc::Rc;

use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use rustc_hash::{FxHashMap, FxHashSet};

use crate::engine::{self, Character, Guide, Hooks, Sim, Status, StepView, WorldData};
#[allow(unused_imports)]
use crate::seed::{at, everyone, for_class, is, located, Check, Ctx, Row, SeedTest};

const DUROTAR: &str = "forever/horde/orc-troll/01-durotar.guide";
const DUN_MOROGH: &str = "forever/alliance/dwarf-gnome/01-dun-morogh.guide";
const TELDRASSIL: &str = "forever/alliance/nightelf/01-teldrassil.guide";
const ELWYNN: &str = "forever/alliance/human/01-elwynn-forest.guide";
const MULGORE: &str = "forever/horde/tauren/01-mulgore.guide";
const ASHENVALE: &str = "forever/alliance/06-ashenvale.guide";
const ASHENVALE_HORDE: &str = "forever/horde/07-ashenvale.guide";
const BARRENS: &str = "forever/horde/04-the-barrens.guide";
const WESTFALL: &str = "forever/alliance/02-westfall.guide";
const ZEPHRAS_HORDE: &str = "forever/horde/skyborne/01-zephras-isle.guide";
const ZEPHRAS_ALLIANCE: &str = "forever/alliance/skyborne/01-zephras-isle.guide";
const COZY: &str = "forever/miscellaneous/cozy-sleeping-bag.guide";

pub fn tests() -> Vec<SeedTest> {
	vec![
		(format!("{MULGORE}: Sharing the Land leads to each gnoll objective and resumes partial progress"), sharing_the_land),
		(
			"forever/alliance/03-darkshore.guide: Wogi's report: with Skip grey quests on, a Human at 20 leaves out the grey quests, keeps the Buzzbox chain, and one on the route's level keeps them all".into(),
			grey_skipped,
		),
		("forever/alliance/03-darkshore.guide: XooVe's report (#216): a grey quest Skip grey quests keeps says which quest it opens".into(), grey_kept),
		(format!("{DUROTAR}: AndarKerran's report: A Pain in the Neck is not offered to a Troll Warrior without Enchanting, and is to an enchanter"), pain_in_the_neck),
		(format!("{DUROTAR}: defect's report (#357): with The Admiral's Orders taken, Tiragarde Keep waits for neither Benedict's Key nor the Aged Envelope"), admirals_orders),
		(format!("{DUN_MOROGH}: thmastin's report: Beer Basted Boar Ribs is offered without Cooking, on arrival in Kharanos"), beer_basted),
		(format!("{BARRENS}: Fitz's report: Jorn Skyseer is passed by while The Angry Scytheclaws is missing, and open once it is done"), jorn_skyseer),
		("the leveling guides with profession quests play to the end for a character with the profession".into(), profession_quests),
		(format!("{TELDRASSIL}: Pynte's report: the Gnarlpine Totems are open together with the kills and the Fel Moss, at both totem objects"), gnarlpine_totems),
		("Sato's report: the Skysight and Read Ley Line objectives tell you to cast the racial, and tick from the quest log".into(), skysight),
		(format!("{ZEPHRAS_HORDE}: Sato's report: Welcome to Shen'dar Village follows its objectives, and is taken before Illaya's talk"), shendar),
		(format!("{ELWYNN}: Syfin's report (#221): Croaky's Head is an optional extra; Ridgepoint Tower holds and leads the arrow only with the head"), croaky),
		(format!("{ELWYNN}: zeike's report (#553): Forest's Edge does not wait for the rare Gruff Swiftbite; The Collector and Manhunt follow only the Schedule"), forests_edge),
		("#246: no NPC or object goal is on a neighbouring zone's map where the two maps overlap".into(), neighbour_map),
		("Zerkness's and Ioney's reports (#383, #396): every player is led to Alonso, and his quests hold only one who takes them, in both Ashenvale guides".into(), alonso),
		(format!("{WESTFALL}: Smuve's report (#298): the Molsen Farm step does not wait for the Precessive Autocognition Assembly; with one, it is handed in at Saldean's"), molsen_farm),
		(format!("{COZY}: dgc1980's report (#563): Alliance go round Honor's Stand on the way to Stonetalon, Horde go straight"), cozy_sleeping_bag),
	]
}

// ---------------------------------------------------------------------------------------- helpers

/// A character the engine plays (`who`: race file, faction, class file, level).
struct Who {
	race: &'static str,
	faction: &'static str,
	cls: &'static str,
	level: u32,
}

const TROLL_WARRIOR: Who = Who { race: "Troll", faction: "Horde", cls: "WARRIOR", level: 12 };
const SKYBORNE_HORDE: Who = Who { race: "Skyborne", faction: "Horde", cls: "ROGUE", level: 6 };
const SKYBORNE_ALLIANCE: Who = Who { race: "Skyborne", faction: "Alliance", cls: "ROGUE", level: 4 };

/// The guide played by the engine for `who` (engineRun): `before` sets the world before login, the
/// guide is opened (`E.SetGuide`), `after` runs, 0.5 s pass, then `script`. None (a failed check) when
/// the guide does not compile to one guide.
fn engine_run<R>(ctx: &Ctx, c: &mut Check, guide: &str, who: &Who, before: impl FnOnce(&mut Sim), after: impl FnOnce(&mut Sim), script: impl FnOnce(&mut Sim) -> R) -> Option<R> {
	let g = ctx.compiled(guide);
	if !c.ok(g.is_object(), &format!("{guide} compiles")) {
		return None;
	}
	let guides = vec![Guide::read(&g)];
	let wd = WorldData::from_data(&ctx.data);
	let mut sim = Sim::scripted(&guides, &wd, &Character::new(who.faction, who.race, who.cls, who.level));
	before(&mut sim);
	sim.login_and_open(0);
	after(&mut sim);
	sim.advance(0.5);
	Some(script(&mut sim))
}

/// Each goal of `quest` in the open guide as "t status" (questGoalStatus's script).
fn statuses_of(sim: &mut Sim, quest: u32) -> Vec<String> {
	let mut out = Vec::new();
	for i in 1..=sim.gd().steps.len() {
		for g in sim.step_view(i).goals {
			if g.quest == Some(quest) {
				out.push(format!("{} {}", g.t, g.status.as_str()));
			}
		}
	}
	out
}

/// questGoalStatus(guide, quest, who, { skills, after }).
fn quest_goal_status(ctx: &Ctx, c: &mut Check, guide: &str, quest: u32, who: &Who, before: impl FnOnce(&mut Sim), after: impl FnOnce(&mut Sim)) -> Option<Vec<String>> {
	engine_run(ctx, c, guide, who, before, after, |sim| statuses_of(sim, quest))
}

/// stepView(guide, who, s, before).
fn step_view(ctx: &Ctx, c: &mut Check, guide: &str, who: &Who, s: usize, before: impl FnOnce(&mut Sim)) -> Option<StepView> {
	engine_run(ctx, c, guide, who, before, |_| {}, |sim| sim.step_view(s))
}

/// Guide files compiled together with the reference data (buildSimPack's compileSources) -> the
/// guides and the number of errors.
fn compile_set(ctx: &Ctx, files: &[String]) -> (Vec<V>, usize) {
	let sources: Vec<Source> =
		files.iter().map(|f| Source { file: ctx.guides.join(f).to_string_lossy().into_owned(), source: f.clone(), text: std::fs::read_to_string(ctx.guides.join(f)).unwrap_or_default() }).collect();
	let mut diag = Diagnostics::new();
	let out = compile_sources(&sources, &ctx.data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None });
	(out.guides, diag.errors().len())
}

/// A pack of compiled guides read by the engine, and the index of guide file `file` in it.
fn pack_index(guides: &[Guide], file: &str) -> Option<usize> {
	guides.iter().position(|g| format!("{}.guide", g.id) == file)
}

/// playGuide(pack, g, { race, faction, cls, before, script }): `before` sets the world up, the login
/// opens the guide, 0.6 s pass, then `script`.
fn play_guide<R>(guides: &[Guide], wd: &WorldData, gi: usize, (race, faction, cls): (&str, &str, &str), before: impl FnOnce(&mut Sim), script: impl FnOnce(&mut Sim) -> R) -> R {
	let mut sim = Sim::for_play(guides, wd, gi, race, faction, cls);
	before(&mut sim);
	sim.login(gi);
	sim.advance(0.6);
	script(&mut sim)
}

/// SIMULATE's `out.stuck === undefined` and `out.done`.
fn played(c: &mut Check, who: &str, (done, stuck): (bool, Option<engine::Event>)) {
	c.ok(stuck.is_none(), &format!("{who}: not stuck: {stuck:?}"));
	c.ok(done, &format!("{who}: plays to the end"));
}

/// yards(a, b): yards between two points on one map (Era frame); None (a failed check) when not on
/// one map with an Era frame.
fn yards(ctx: &Ctx, c: &mut Check, a: (f64, f64, f64), b: (f64, f64, f64)) -> Option<f64> {
	let f = ctx.data.era_frame(&V::Num(a.0));
	if !c.ok(f.truthy() && a.0 == b.0, &format!("points on one map with an Era frame ({}, {})", a.0, b.0)) {
		return None;
	}
	let n = |k: &str| f.get(k).as_num().unwrap_or(f64::NAN);
	Some(((n("right") - n("left")) * (a.1 - b.1) / 100.0).hypot((n("bottom") - n("top")) * (a.2 - b.2) / 100.0))
}

fn num(v: &V, k: &str) -> Option<f64> {
	v.get(k).as_num()
}

/// `tonumber(x)`: a number, or a numeric string.
fn tonumber(v: &V) -> Option<f64> {
	match v {
		V::Num(n) => Some(*n),
		V::Str(s) => s.trim().parse().ok(),
		_ => None,
	}
}

// ---------------------------------------------------------------------------------------- Mulgore

fn sharing_the_land(ctx: &Ctx, c: &mut Check) {
	let files: Vec<String> = ctx.all_guides().into_iter().filter(|f| f.starts_with("forever/horde/")).collect();
	let (compiled, errors) = compile_set(ctx, &files);
	c.eq(errors, 0, "pack.diag.errors");
	let guides: Vec<Guide> = compiled.iter().map(Guide::read).collect();
	let wd = WorldData::from_data(&ctx.data);
	let Some(gi) = pack_index(&guides, MULGORE) else {
		c.ok(false, "the Mulgore guide is in the pack");
		return;
	};
	let si = guides[gi].steps.iter().position(|s| s.goals.iter().any(|v| v.quest == Some(745) && matches!(v.t, engine::T::Kill | engine::T::Complete))).map_or(0, |i| i + 1);
	if !c.ok(si > 0, "a step works on 745") {
		return;
	}
	for cls in ["SHAMAN", "WARRIOR", "DRUID"] {
		let (points, done) = play_guide(
			&guides,
			&wd,
			gi,
			("Tauren", "Horde", cls),
			|sim| {
				sim.w.level = 12.0;
				sim.set_on_quest(745, &[(10.0, 0.0), (8.0, 0.0), (5.0, 0.0)]);
			},
			|sim| {
				sim.goto(si);
				// snap(): the arrow's place and its goal's quest, NPC and objective.
				let snap = |sim: &mut Sim| {
					let wp = sim.get_waypoint()?;
					let v = sim.gd().goal(wp.step, wp.goal);
					Some((wp.map, wp.x, wp.y, v.quest, v.npc, v.oi))
				};
				let mut out = vec![snap(sim)];
				for (oi, n) in [(1usize, 9.0), (1, 10.0), (2, 7.0), (2, 8.0), (3, 4.0)] {
					sim.w_progress(745, oi - 1, n);
					sim.advance(0.6);
					out.push(snap(sim));
				}
				sim.w_progress(745, 2, 5.0);
				sim.advance(0.6);
				let done = sim.step_view(si).goals.iter().all(|v| v.quest != Some(745) || v.status == Status::Done);
				(out, done)
			},
		);
		c.eq(points.len(), 6, "out.points.length");
		for (i, p) in points.iter().enumerate() {
			let Some((map, x, y, quest, npc, oi)) = p else {
				c.ok(false, &format!("{cls}: the active gnoll objective has an arrow"));
				break;
			};
			c.eq(*map, Some(1412), "p.map");
			c.eq(*quest, Some(745), "p.quest");
			c.eq(*npc, Some([2949, 2949, 2950, 2950, 2951, 2951][i]), "p.npc");
			c.eq(*oi, Some([1, 1, 2, 2, 3, 3][i]), "p.oi");
			c.ok(x.is_some(), "typeof p.x is number");
			c.ok(y.is_some(), "typeof p.y is number");
		}
		c.ok(done, &format!("{cls}: all three counts finish the work"));
	}
}

// ---------------------------------------------------------------------------------------- Skip grey quests

/// What the Engine shows of Darkshore (and the guides after it) for a level-`level` Human with "Skip
/// grey quests" on: the accepts it leaves out as grey (`skipped`, in step order), and each grey accept
/// it keeps with the quest it says it opens and that line (`kept`, by quest).
struct Grey {
	skipped: Vec<u32>,
	kept: FxHashMap<u32, (u32, String)>,
}

/// Own.optionClosed: a `next` option whose `when` can no longer hold (a level the player is past; a
/// `!turnedin` of a quest handed in: none in a fresh session).
fn option_closed(from: &V, id: &str, level: f64) -> bool {
	from.get("nextWhen").get(id).items().iter().any(|p| {
		let n = num(p, "n").unwrap_or(f64::NAN);
		p.get("k").as_str() == Some("level") && ((p.get("op").as_str() == Some("<") && level >= n) || (p.get("op").as_str() == Some("<=") && level > n))
	})
}

/// chainNeeds(g, level): the quests a guide or any guide after it still needs at a level, each mapped
/// to the accept that is not grey it leads to (Own.chainOf, Own.needsFrom).
fn chain_needs(guides: &[V], start: usize, level: f64) -> FxHashMap<u32, V> {
	let mut pres: FxHashMap<u32, Vec<Vec<u32>>> = FxHashMap::default();
	let mut accepts: Vec<V> = Vec::new();
	let mut seen: FxHashSet<String> = FxHashSet::default();
	let mut queue = vec![start];
	let mut head = 0;
	while head < queue.len() && head < 200 {
		let cur = &guides[queue[head]];
		head += 1;
		let id = cur.get("id").as_str().unwrap_or_default().to_string();
		if !seen.insert(id) {
			continue;
		}
		for step in cur.get("steps").items() {
			for goal in step.get("goals").items() {
				let Some(q) = num(&goal, "quest") else { continue };
				if goal.get("t").as_str() != Some("accept") {
					continue;
				}
				let list = pres.entry(q as u32).or_default();
				for k in ["pre", "preAll"] {
					if let Some(a) = goal.get(k).as_arr() {
						list.push(a.to_vec().iter().filter_map(|x| x.as_num()).map(|n| n as u32).collect());
					}
				}
				accepts.push(goal);
			}
		}
		let next: Vec<String> = match cur.get("nextChoices").as_arr() {
			Some(a) => a.to_vec().iter().filter_map(|x| x.as_str().map(str::to_string)).collect(),
			None => cur.get("next").as_str().map(|s| vec![s.to_string()]).unwrap_or_default(),
		};
		for id in next {
			if !option_closed(cur, &id, level) {
				if let Some(k) = guides.iter().position(|g| g.get("id").as_str() == Some(id.as_str())) {
					queue.push(k);
				}
			}
		}
	}
	// needsFrom: breadth first from every accept that is not grey at once.
	let mut set: FxHashMap<u32, V> = FxHashMap::default();
	let mut by: FxHashMap<u32, V> = FxHashMap::default();
	let mut queue: Vec<u32> = Vec::new();
	for goal in &accepts {
		let grey = tonumber(&goal.get("qlvl")).is_some_and(|l| engine::trivial(l, level));
		let q = num(goal, "quest").unwrap() as u32;
		if !grey && !by.contains_key(&q) {
			by.insert(q, goal.clone());
			queue.push(q);
		}
	}
	let mut head = 0;
	while head < queue.len() {
		let q = queue[head];
		head += 1;
		for list in pres.get(&q).cloned().unwrap_or_default() {
			for p in list {
				let opens = by[&q].clone();
				set.entry(p).or_insert_with(|| opens.clone());
				if let std::collections::hash_map::Entry::Vacant(e) = by.entry(p) {
					e.insert(opens);
					queue.push(p);
				}
			}
		}
	}
	set
}

/// greyInDarkshore(level): GetStepView's `skippedGrey` and `keptGrey`/`keptGreyText` (greyNeed) on
/// each goal of Darkshore, opened in a fresh session (nothing in the log or done).
fn grey_in_darkshore(ctx: &Ctx, c: &mut Check, level: f64) -> Option<Grey> {
	let files: Vec<String> = ["03-darkshore", "04-redridge-mountains", "05-duskwood", "06-ashenvale", "07-thousand-needles"].iter().map(|n| format!("forever/alliance/{n}.guide")).collect();
	let (guides, _) = compile_set(ctx, &files);
	let Some(d) = guides.iter().position(|g| g.get("id").as_str() == Some("forever/alliance/03-darkshore")) else {
		c.ok(false, "forever/alliance/03-darkshore compiles");
		return None;
	};
	let dark = &guides[d];
	let category = dark.get("category");
	let every_step = category.as_str().is_some_and(|c| c != "Leveling");
	let needs = chain_needs(&guides, d, level);
	let mut out = Grey { skipped: Vec::new(), kept: FxHashMap::default() };
	for step in dark.get("steps").items() {
		for goal in step.get("goals").items() {
			let takes = goal.get("t").as_str() == Some("accept") || goal.get("direct").truthy();
			let Some(qlvl) = tonumber(&goal.get("qlvl")) else { continue };
			if !takes || every_step || !engine::trivial(qlvl, level) {
				continue;
			}
			let Some(q) = num(&goal, "quest").map(|q| q as u32) else { continue };
			match needs.get(&q) {
				None => out.skipped.push(q),
				Some(opens) => {
					let oq = num(opens, "quest").unwrap() as u32;
					let title = opens.get("title").as_str().map(str::to_string).unwrap_or_else(|| format!("Quest {oq}"));
					out.kept.insert(q, (oq, format!("Grey, kept: opens {title}")));
				}
			}
		}
	}
	Some(out)
}

fn grey_skipped(ctx: &Ctx, c: &mut Check) {
	let Some(at20) = grey_in_darkshore(ctx, c, 20.0) else { return };
	let mut s = at20.skipped.clone();
	s.sort();
	c.eq(s, vec![953, 954, 955, 956, 957, 958, 98025], "greyInDarkshore(20).skipped");
	let Some(at17) = grey_in_darkshore(ctx, c, 17.0) else { return };
	c.eq(at17.skipped, vec![], "greyInDarkshore(17).skipped");
}

fn grey_kept(ctx: &Ctx, c: &mut Check) {
	let Some(at20) = grey_in_darkshore(ctx, c, 20.0) else { return };
	let want = Some((1002, "Grey, kept: opens Buzzbox 323".to_string()));
	c.eq(at20.kept.get(&983).cloned(), want.clone(), "at20['983']");
	c.eq(at20.kept.get(&1001).cloned(), want, "at20['1001']");
	let Some(at22) = grey_in_darkshore(ctx, c, 22.0) else { return };
	c.eq(at22.kept.get(&983).cloned(), Some((1003, "Grey, kept: opens Buzzbox 525".to_string())), "at22['983']");
	let Some(at23) = grey_in_darkshore(ctx, c, 23.0) else { return };
	c.eq(at23.kept.get(&983).cloned(), None, "at23.kept['983']");
	c.ok(at23.skipped.contains(&983), "at23.skipped includes 983");
}

// ---------------------------------------------------------------------------------------- statuses

fn pain_in_the_neck(ctx: &Ctx, c: &mut Check) {
	// Pa'zula offers it to enchanters only: every goal carries the profession.
	let pain: Vec<_> = ctx.goals(DUROTAR).into_iter().filter(|r| num(&r.goal, "quest") == Some(96873.0)).collect();
	let got: Vec<(String, Option<f64>, Option<String>, Option<f64>)> = pain
		.iter()
		.map(|r| (r.goal.get("t").as_str().unwrap_or_default().to_string(), num(&r.goal, "profLine"), r.goal.get("profName").as_str().map(str::to_string), num(&r.goal, "profRank")))
		.collect();
	let e = |t: &str| (t.to_string(), Some(333.0), Some("Enchanting".to_string()), Some(1.0));
	c.eq(got, vec![e("accept"), e("complete"), e("turnin")], "the goals of 96873 carry Enchanting 1");
	// Hidden ("na", like another class's goals), not offered and then skipped.
	let pain_in_the_neck = |c: &mut Check, before: &dyn Fn(&mut Sim), after: &dyn Fn(&mut Sim)| quest_goal_status(ctx, c, DUROTAR, 96873, &TROLL_WARRIOR, before, after);
	let s = |v: &[&str]| Some(v.iter().map(|x| x.to_string()).collect::<Vec<_>>());
	let r = pain_in_the_neck(c, &|_| {}, &|_| {});
	c.eq(r, s(&["accept na", "complete na", "turnin na"]), "painInTheNeck()");
	// An enchanter is offered it. Its accept is optional, so the complete and the turn-in are theirs
	// only once they take it (#221).
	let offered = s(&["accept pending", "complete na", "turnin na"]);
	let r = pain_in_the_neck(c, &|sim| sim.set_skill(333, 1.0, 75.0), &|_| {});
	c.eq(r, offered.clone(), "painInTheNeck with Enchanting");
	// Learning Enchanting during the session brings the accept back.
	let r = pain_in_the_neck(c, &|_| {}, &|sim| sim.w_skill("333", 1.0, Some(75.0)));
	c.eq(r, offered, "painInTheNeck learning Enchanting");
}

fn admirals_orders(ctx: &Ctx, c: &mut Check) {
	let s = ctx
		.compiled(DUROTAR)
		.get("steps")
		.items()
		.iter()
		.position(|step| step.get("goals").items().iter().any(|g| g.get("t").as_str() == Some("accept") && num(g, "quest") == Some(830.0)))
		.map_or(0, |i| i + 1);
	if !c.ok(s > 0, "a step takes 830") {
		return;
	}
	let Some(view) = step_view(ctx, c, DUROTAR, &TROLL_WARRIOR, s, |sim| sim.set_on_quest(830, &[])) else { return };
	let open: Vec<_> = view.goals.iter().filter(|g| g.t == "collect" && g.quest.is_none() && g.status != Status::Done).map(|g| (g.t.clone(), g.status)).collect();
	c.eq(open, vec![], "no bag collect left open once 830 is in the log");
	c.ok(ctx.goals(DUROTAR).iter().any(|r| r.s == s && r.goal.get("t").as_str() == Some("kill") && num(&r.goal, "npc") == Some(3192.0)), "Benedict is still a kill of the step");
}

fn beer_basted(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(DUN_MOROGH);
	let ribs: Vec<(String, Option<f64>)> =
		list.iter().filter(|r| num(&r.goal, "quest") == Some(384.0)).map(|r| (r.goal.get("t").as_str().unwrap_or_default().to_string(), num(&r.goal, "profLine"))).collect();
	c.eq(ribs, vec![("accept".into(), None), ("collect".into(), None), ("turnin".into(), None)], "the goals of 384 need no profession");
	let take = at(c, &list, "accept 384", is("accept", 384));
	let camping = at(c, &list, "turnin 96629 (Camping 101: Cooking)", is("turnin", 96629));
	let (Some(take), Some(camping)) = (take, camping) else { return };
	c.ok(take < camping, "384 is taken before the cooking lesson");
	let dwarf = Who { race: "Dwarf", faction: "Alliance", cls: "PALADIN", level: 6 };
	let Some(status) = quest_goal_status(ctx, c, DUN_MOROGH, 384, &dwarf, |_| {}, |_| {}) else { return };
	c.eq(status.len(), 3, "status.length");
	c.ok(status.iter().all(|s| !s.ends_with(" na")), &format!("a Dwarf without Cooking sees 384: {}", status.join(", ")));
}

fn jorn_skyseer(ctx: &Ctx, c: &mut Check) {
	let warlock = Who { race: "Scourge", faction: "Horde", cls: "WARLOCK", level: 21 };
	let list = ctx.goals(BARRENS);
	let Some(accept) = at(c, &list, "accept 3261 (Jorn Skyseer)", is("accept", 3261)) else { return };
	let pre: Vec<Option<f64>> = list[accept].goal.get("pre").items().iter().map(|x| x.as_num()).collect();
	c.ok(list[accept].goal.get("pre").is_arr() && pre == vec![Some(905.0)], "Jorn Skyseer needs The Angry Scytheclaws");
	let Some(missing) = quest_goal_status(ctx, c, BARRENS, 3261, &warlock, |_| {}, |_| {}) else { return };
	c.eq(missing, vec!["accept skipped".to_string(), "turnin skipped".to_string()], "without 905");
	let Some(done) = quest_goal_status(
		ctx,
		c,
		BARRENS,
		3261,
		&warlock,
		|sim| {
			sim.w.completed.insert(905);
		},
		|_| {},
	) else {
		return;
	};
	c.eq(done.len(), 2, "done.length");
	c.ok(done.iter().all(|s| !s.ends_with(" skipped") && !s.ends_with(" na")), &format!("with 905 done Jorn Skyseer is open: {}", done.join(", ")));
}

fn forests_edge(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(ELWYNN);
	let edge: Vec<&Row> = list.iter().filter(|r| num(&r.goal, "item") == Some(1307.0) || is("accept", 123)(&r.goal)).collect();
	let got: Vec<(String, bool)> = edge.iter().map(|r| (r.goal.get("t").as_str().unwrap_or_default().to_string(), r.goal.get("optional").strict_eq(&V::Bool(true)))).collect();
	c.eq(got, vec![("collect".into(), true), ("accept".into(), true)], "the Schedule and The Collector's accept are optional");
	let Some(first) = edge.first() else { return };
	let s = first.s;
	c.ok(list.iter().any(|r| r.s == s && r.goal.get("t").as_str() == Some("collect") && num(&r.goal, "quest") == Some(11.0) && !r.goal.get("optional").truthy()), "the armbands hold the step");
	let human = Who { race: "Human", faction: "Alliance", cls: "MAGE", level: 11 };
	let v = |x: &[&str]| Some(x.iter().map(|s| s.to_string()).collect::<Vec<_>>());
	let took = |sim: &mut Sim| sim.w_accept(123, vec![]);
	let handed = |sim: &mut Sim| {
		sim.w_accept(123, vec![]);
		sim.w_turn_in(123);
	};
	let manhunt = |sim: &mut Sim| {
		sim.w_accept(123, vec![]);
		sim.w_turn_in(123);
		sim.w_accept(147, vec![]);
	};
	let r = quest_goal_status(ctx, c, ELWYNN, 123, &human, |_| {}, |_| {});
	c.eq(r, v(&["accept pending", "turnin na"]), "123");
	let r = quest_goal_status(ctx, c, ELWYNN, 147, &human, |_| {}, |_| {});
	c.eq(r, v(&["accept na", "collect na", "turnin na"]), "147");
	let r = quest_goal_status(ctx, c, ELWYNN, 123, &human, |_| {}, took);
	c.eq(r, v(&["accept done", "turnin pending"]), "123 taken");
	let r = quest_goal_status(ctx, c, ELWYNN, 147, &human, |_| {}, took);
	c.eq(r, v(&["accept na", "collect na", "turnin na"]), "147 with 123 taken");
	let r = quest_goal_status(ctx, c, ELWYNN, 147, &human, |_| {}, handed);
	c.eq(r, v(&["accept pending", "collect pending", "turnin na"]), "147 with 123 handed in");
	let r = quest_goal_status(ctx, c, ELWYNN, 147, &human, |_| {}, manhunt);
	c.eq(r, v(&["accept done", "collect pending", "turnin pending"]), "147 taken");
}

// ---------------------------------------------------------------------------------------- step views

fn gnarlpine_totems(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(TELDRASSIL);
	let Some(i) = at(c, &list, "the Gnarlpine Totems (97977)", |g| num(g, "quest") == Some(97977.0) && !matches!(g.get("t").as_str(), Some("accept" | "turnin"))) else { return };
	let totems = &list[i];
	let spots = totems.goal.get("spots").items();
	for object in [668482.0, 668493.0] {
		for sp in ctx.data.spawns("object", &V::Num(object)).iter().filter(|x| num(x, "map") == Some(1438.0)) {
			for p in sp.get("pts").items().into_iter().chain(sp.get("more").items()) {
				let (x, y) = (p.num_at(0), p.num_at(1));
				let mut inside = false;
				for o in &spots {
					let Some(d) = yards(ctx, c, (1438.0, num(o, "x").unwrap_or(f64::NAN), num(o, "y").unwrap_or(f64::NAN)), (1438.0, x, y)) else { return };
					if d <= num(o, "r").unwrap_or(f64::NAN) + 1.0 {
						inside = true;
						break;
					}
				}
				c.ok(inside, &format!("the totem {object} at {x},{y} lies in one of the goal's spots"));
			}
		}
	}
	// The report's state: one boar kill left to do, the boars and the moss done, one totem of four.
	let night_elf = Who { race: "NightElf", faction: "Alliance", cls: "ROGUE", level: 2 };
	let Some(view) = step_view(ctx, c, TELDRASSIL, &night_elf, totems.s, |sim| {
		sim.w.completed.insert(458);
		sim.set_on_quest(456, &[(7.0, 3.0), (4.0, 4.0)]);
		sim.set_on_quest(459, &[(8.0, 8.0)]);
		sim.set_on_quest(97977, &[(4.0, 1.0)]);
	}) else {
		return;
	};
	c.eq(view.groups.len(), 1, &format!("the step is one group: {:?}", view.groups));
	let open: Vec<u32> = view.goals.iter().filter(|g| g.status == Status::Active).map(|g| g.quest.unwrap_or(0)).collect();
	c.eq(open, vec![456, 97977], "the Nightsabers and the totems are open at the same time");
}

fn skysight(ctx: &Ctx, c: &mut Check) {
	let click = regex::Regex::new(r"^Click\b").unwrap();
	for (guide, who, quest, spell) in [(ZEPHRAS_HORDE, &SKYBORNE_HORDE, 92598, "Skysight"), (ZEPHRAS_ALLIANCE, &SKYBORNE_ALLIANCE, 92597, "Read Leyline")] {
		let list = ctx.goals(guide);
		let Some(i) = at(c, &list, &format!("{guide}: the objective of {quest}"), |g| num(g, "quest") == Some(quest as f64) && num(g, "oi") == Some(1.0)) else { return };
		let Some(view) = step_view(ctx, c, guide, who, list[i].s, |sim| sim.set_on_quest(quest, &[(1.0, 1.0)])) else { return };
		let Some(line) = view.goals.iter().find(|g| g.quest == Some(quest) && g.t != "accept" && g.t != "turnin") else {
			c.ok(false, &format!("{guide}: the step has a line for {quest}'s objective"));
			return;
		};
		c.ok(!click.is_match(&line.text) && line.text.contains(spell), &format!("{guide}: \"{}\" names {spell}, not a click", line.text));
		c.eq(line.status, Status::Done, &format!("{guide}: ticked once the quest log counts it"));
	}
}

fn shendar(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(ZEPHRAS_HORDE);
	let (Some(a), Some(b)) = (at(c, &list, "accept 92514", is("accept", 92514)), at(c, &list, "complete 92595 (talk to Illaya)", is("complete", 92595))) else { return };
	c.ok(a < b, "taken before the talk to Illaya for The Windshapers, which counts for it too");
	let Some(t) = at(c, &list, "turnin 92514", is("turnin", 92514)) else { return };
	let step = list[t].s;
	let talks: Vec<Option<f64>> = list.iter().filter(|r| r.s == step && r.goal.get("t").as_str() == Some("talk")).map(|r| num(&r.goal, "npc")).collect();
	c.eq(talks, vec![], "no bare talk goal that only counts during the step");
	let objectives = |c: &mut Check, illaya: f64, coriella: f64| {
		step_view(ctx, c, ZEPHRAS_HORDE, &SKYBORNE_HORDE, step, |sim| {
			sim.w.completed.insert(92595);
			sim.set_on_quest(92514, &[(1.0, illaya), (1.0, coriella)]);
		})
		.map(|v| v.goals.iter().filter(|g| g.quest == Some(92514) && g.t != "turnin").map(|g| g.status).collect::<Vec<_>>())
	};
	let Some(one) = objectives(c, 1.0, 0.0) else { return };
	c.eq(one.iter().map(|s| *s == Status::Done).collect::<Vec<_>>(), vec![true, false], "Illaya done earlier, Coriella still to do");
	let Some(both) = objectives(c, 1.0, 1.0) else { return };
	c.ok(both.iter().all(|s| *s == Status::Done), "both done: only the turn-in is left");
}

// ---------------------------------------------------------------------------------------- plays

fn profession_quests(ctx: &Ctx, c: &mut Check) {
	let files: Vec<String> = [DUROTAR, DUN_MOROGH, TELDRASSIL, ELWYNN].iter().map(|s| s.to_string()).collect();
	let (compiled, _) = compile_set(ctx, &files);
	let guides: Vec<Guide> = compiled.iter().map(Guide::read).collect();
	let wd = WorldData::from_data(&ctx.data);
	let cases: [(&str, &str, &str, &[(u32, &str)], Option<u32>); 4] = [
		(DUROTAR, "Troll", "Horde", &[(333, "Enchanting")], None),
		(DUN_MOROGH, "Dwarf", "Alliance", &[(185, "Cooking"), (164, "Blacksmithing")], Some(384)),
		(TELDRASSIL, "NightElf", "Alliance", &[(185, "Cooking")], Some(4161)),
		(ELWYNN, "Human", "Alliance", &[(393, "Skinning")], None),
	];
	for (guide, race, faction, skills, quest) in cases {
		let Some(gi) = pack_index(&guides, guide) else {
			c.ok(false, &format!("{guide} compiles"));
			return;
		};
		let (out, done) = play_guide(
			&guides,
			&wd,
			gi,
			(race, faction, "WARRIOR"),
			|sim| {
				for &(line, _) in skills {
					sim.set_skill(line, 1.0, 75.0);
				}
			},
			|sim| {
				let out = sim.simulate();
				(out, quest.is_some_and(|q| sim.w.completed.contains(&q)))
			},
		);
		played(c, &format!("{guide} ({race})"), out);
		if let Some(q) = quest {
			c.ok(done, &format!("{guide}: a cook does {q}"));
		}
	}
}

/// What the Croaky's Head play records (`murlocs`, `ridge`).
#[derive(Default)]
struct CroakyLog {
	murlocs: Option<Vec<String>>,
	ridge: Option<(Option<String>, Option<Status>, Option<(Option<u32>, Option<f64>, Option<f64>)>)>,
}

/// The first Torn Murloc Fin (the murloc step is live; with the head, it is looted and right-clicked
/// there), and any hand-in of Croaky's Head (the step it is handed in from, and where the arrow leads).
/// The game takes no turn-in for a quest the player does not hold.
struct Croaky {
	head: bool,
	log: Rc<RefCell<CroakyLog>>,
}

/// The goals of the live step for quest `q` or item `item`, as "t optional".
fn goals_for(sim: &mut Sim, q: u32, item: u32) -> Vec<String> {
	let Some(i) = sim.current else { return Vec::new() };
	sim.step_view(i).goals.iter().filter(|v| v.quest == Some(q) || v.item == Some(item)).map(|v| format!("{} {}", v.t, v.optional)).collect()
}

impl Hooks for Croaky {
	fn progress(&mut self, sim: &mut Sim<'_>, q: u32, i: usize, n: f64) {
		if q == 46 && self.log.borrow().murlocs.is_none() {
			self.log.borrow_mut().murlocs = Some(Vec::new());
			if self.head {
				sim.raw_add_item(247826, 1.0);
				sim.raw_accept(91740, vec![]);
				sim.advance(0.6);
			}
			let m = goals_for(sim, 91740, 247826);
			self.log.borrow_mut().murlocs = Some(m);
		}
		sim.raw_progress(q, i, n);
	}
	fn turn_in(&mut self, sim: &mut Sim<'_>, q: u32) {
		if q == 91740 {
			let wp = sim.get_waypoint().map(|w| (w.map, w.x, w.y));
			let (title, status) = match sim.current {
				Some(i) => {
					let v = sim.step_view(i);
					(v.title, v.goals.first().map(|g| g.status))
				}
				None => (None, None),
			};
			self.log.borrow_mut().ridge = Some((title, status, wp));
			if !sim.w.log.contains_key(&q) {
				return;
			}
		}
		sim.raw_turn_in(q);
	}
}

fn croaky(ctx: &Ctx, c: &mut Check) {
	let (compiled, _) = compile_set(ctx, &[ELWYNN.to_string()]);
	let guides: Vec<Guide> = compiled.iter().map(Guide::read).collect();
	if !c.ok(!guides.is_empty(), "the Elwynn guide compiles") {
		return;
	}
	let wd = WorldData::from_data(&ctx.data);
	let merell = ctx.data.npcs.get("248277").get("spawns").get("1429").get("pts").at(0);
	let (x, y) = (merell.num_at(0), merell.num_at(1));
	for head in [false, true] {
		let log = Rc::new(RefCell::new(CroakyLog::default()));
		let (out, later, done) = play_guide(
			&guides,
			&wd,
			0,
			("Human", "Alliance", "WARRIOR"),
			|_| {},
			|sim| {
				sim.hooks = Some(Box::new(Croaky { head, log: log.clone() }));
				let out = sim.simulate();
				sim.hooks = None;
				let mut later = None;
				let n = sim.gs[0].steps.len();
				for i in 1..=n {
					if sim.gs[0].step(i).title.as_deref() == Some("Ridgepoint Tower") && sim.guide.is_some() {
						later = sim.step_view(i).goals.first().map(|g| g.status);
					}
				}
				(out, later, sim.w.completed.contains(&91740))
			},
		);
		let who = if head { "with the head" } else { "without the head" };
		played(c, who, out);
		let log = log.borrow();
		c.eq(log.murlocs.clone(), Some(vec!["collect true".to_string(), "accept true".to_string()]), &format!("{who}: the head and its accept are optional goals of the murloc step"));
		c.eq(done, head, &format!("{who}: Croaky's Head {} handed in", if head { "is" } else { "is not" }));
		if head {
			let Some((title, status, wp)) = &log.ridge else {
				c.ok(false, "with the head: handed in at the Ridgepoint Tower step");
				continue;
			};
			c.eq(title.as_deref(), Some("Ridgepoint Tower"), "with the head: handed in at the Ridgepoint Tower step");
			c.eq(*status, Some(Status::Active), "the turn-in holds the step");
			let near = match wp {
				Some((Some(map), Some(wx), Some(wy))) => yards(ctx, c, (*map as f64, *wx, *wy), (1429.0, x, y)).is_some_and(|d| d <= 5.0),
				_ => false,
			};
			c.ok(near, &format!("the arrow leads to Merell Ross at Ridgepoint Tower: {wp:?}"));
			c.eq(later, Some(Status::Done), "later");
		} else {
			c.ok(log.ridge.is_none(), "without the head: Ridgepoint Tower is passed, nothing is handed in there");
			c.eq(later, Some(Status::Na), "without the head: the turn-in is not this player's");
		}
	}
}

/// The Molsen Farm play: without the Assembly it never drops; with it, it is looted and right-clicked
/// there. Recorded: the farm step's goals for the Assembly and its quest, and where Harvesting the
/// Harvesters is handed in.
struct Molsen {
	assembly: bool,
	farm: Rc<RefCell<Option<Vec<String>>>>,
	turned_in: Rc<RefCell<Option<Option<String>>>>,
}

impl Hooks for Molsen {
	fn add_item(&mut self, sim: &mut Sim<'_>, id: u32, n: f64) {
		if id == 255155 && !self.assembly {
			return;
		}
		sim.raw_add_item(id, n);
	}
	fn progress(&mut self, sim: &mut Sim<'_>, q: u32, i: usize, n: f64) {
		if q == 92909 && self.farm.borrow().is_none() {
			*self.farm.borrow_mut() = Some(Vec::new());
			if self.assembly {
				sim.raw_add_item(255155, 1.0);
				sim.raw_accept(92910, vec![]);
				sim.advance(0.6);
			}
			let f = goals_for(sim, 92910, 255155);
			*self.farm.borrow_mut() = Some(f);
		}
		sim.raw_progress(q, i, n);
	}
	fn turn_in(&mut self, sim: &mut Sim<'_>, q: u32) {
		if q == 92910 {
			let title = sim.current.and_then(|i| sim.step_view(i).title);
			*self.turned_in.borrow_mut() = Some(title);
			if !sim.w.log.contains_key(&q) {
				return;
			}
		}
		sim.raw_turn_in(q);
	}
}

fn molsen_farm(ctx: &Ctx, c: &mut Check) {
	let (compiled, _) = compile_set(ctx, &[WESTFALL.to_string()]);
	let guides: Vec<Guide> = compiled.iter().map(Guide::read).collect();
	if !c.ok(!guides.is_empty(), "the Westfall guide compiles") {
		return;
	}
	let wd = WorldData::from_data(&ctx.data);
	for assembly in [false, true] {
		let farm = Rc::new(RefCell::new(None));
		let turned_in = Rc::new(RefCell::new(None));
		let (out, done) = play_guide(
			&guides,
			&wd,
			0,
			("Human", "Alliance", "WARRIOR"),
			|_| {},
			|sim| {
				sim.hooks = Some(Box::new(Molsen { assembly, farm: farm.clone(), turned_in: turned_in.clone() }));
				let out = sim.simulate();
				sim.hooks = None;
				(out, sim.w.completed.contains(&92910))
			},
		);
		let who = if assembly { "with the Assembly" } else { "without the Assembly" };
		played(c, who, out);
		c.eq(farm.borrow().clone(), Some(vec!["collect true".to_string(), "accept true".to_string()]), &format!("{who}: the Assembly and its accept are optional goals of the farm step"));
		c.eq(done, assembly, &format!("{who}: Harvesting the Harvesters {} handed in", if assembly { "is" } else { "is not" }));
		let want = if assembly { Some(Some("Saldean's Farm".to_string())) } else { None };
		c.eq(turned_in.borrow().clone(), want, &format!("{who}: where it is handed in"));
	}
}

const ALONSO_CHAIN: [u32; 3] = [78132, 78133, 78134];

/// The Alonso play: `offered`, whether Alonso offers the chain. The game takes no accept he does not
/// offer; a player he offers them to takes each one the guide shows (the simulated player leaves
/// optional goals alone). Recorded: whether the Alonso step's first goal was seen done (`reached`),
/// and the step 78132 is handed in from (`held`).
#[derive(Default)]
struct AlonsoLog {
	held: Option<Option<String>>,
	reached: bool,
}

struct Alonso {
	offered: bool,
	taking: bool,
	log: Rc<RefCell<AlonsoLog>>,
}

impl Alonso {
	/// The wrap of E.GetStepView: after the view of step s is read (its statuses).
	fn seen(&mut self, sim: &mut Sim<'_>, s: usize, statuses: &[Status]) {
		let gd = sim.gd();
		let step = gd.step(s);
		if step.title.as_deref() == Some("Alonso") && statuses.first() == Some(&Status::Done) {
			self.log.borrow_mut().reached = true;
		}
		if self.offered && !self.taking {
			self.taking = true;
			for (g, goal) in step.goals.iter().enumerate() {
				let Some(q) = goal.quest else { continue };
				if goal.t == engine::T::Accept && ALONSO_CHAIN.contains(&q) && matches!(statuses[g], Status::Pending | Status::Active) && !sim.w.log.contains_key(&q) && !sim.w.completed.contains(&q) {
					self.accept(sim, q, vec![]);
					sim.advance(0.6);
				}
			}
			self.taking = false;
		}
	}
}

impl Hooks for Alonso {
	fn accept(&mut self, sim: &mut Sim<'_>, q: u32, objectives: Vec<f64>) {
		if !self.offered && ALONSO_CHAIN.contains(&q) {
			return;
		}
		sim.raw_accept(q, objectives);
	}
	// Held: with 78132 taken, the step is still Alonso's when it is handed in.
	fn turn_in(&mut self, sim: &mut Sim<'_>, q: u32) {
		if q == 78132 {
			let title = sim.current.map(|i| {
				let v = sim.step_view(i);
				let statuses: Vec<Status> = v.goals.iter().map(|g| g.status).collect();
				self.seen(sim, i, &statuses);
				v.title
			});
			self.log.borrow_mut().held = Some(title.flatten());
		}
		sim.raw_turn_in(q);
	}
	fn view(&mut self, sim: &mut Sim<'_>, s: usize, statuses: &[Status]) {
		self.seen(sim, s, statuses);
	}
}

fn alonso(ctx: &Ctx, c: &mut Check) {
	for (guide, faction, paladin_race, warrior_race) in [(ASHENVALE, "Alliance", "Dwarf", "Human"), (ASHENVALE_HORDE, "Horde", "Scourge", "Orc")] {
		let list = ctx.goals(guide);
		let Some(first) = at(c, &list, &format!("{guide}: accept 78132"), is("accept", 78132)) else { return };
		let step = &list[first].step;
		c.eq(step.get("title").as_str(), Some("Alonso"), &format!("{guide}: Alonso has his own step"));
		c.ok(!step.get("only").truthy(), &format!("{guide}: the Alonso step is for every class"));
		let g0 = step.get("goals").at(0);
		c.eq((g0.get("t").as_str(), g0.get("optional").truthy()), (Some("goto"), false), &format!("{guide}: a plain goto leads everyone to Alonso"));
		for q in ALONSO_CHAIN {
			let Some(a) = at(c, &list, &format!("{guide}: accept {q}"), is("accept", q as i64)) else { return };
			c.ok(list[a].goal.get("optional").strict_eq(&V::Bool(true)), &format!("{guide}: accept {q} is optional"));
			let Some(t) = at(c, &list, &format!("{guide}: turnin {q}"), is("turnin", q as i64)) else { return };
			c.ok(!list[t].goal.get("optional").truthy(), &format!("{guide}: turnin {q} is plain"));
		}
		let (compiled, _) = compile_set(ctx, &[guide.to_string()]);
		let guides: Vec<Guide> = compiled.iter().map(Guide::read).collect();
		if !c.ok(!guides.is_empty(), &format!("{guide} compiles")) {
			return;
		}
		let wd = WorldData::from_data(&ctx.data);
		for (cls, race, offered) in [("PALADIN", paladin_race, false), ("WARRIOR", warrior_race, true)] {
			let who = format!("{guide}: a {race} {cls}{}", if offered { "" } else { " Alonso offers nothing" });
			let log = Rc::new(RefCell::new(AlonsoLog::default()));
			let (out, done) = play_guide(
				&guides,
				&wd,
				0,
				(race, faction, cls),
				|_| {},
				|sim| {
					sim.hooks = Some(Box::new(Alonso { offered, taking: false, log: log.clone() }));
					let out = sim.simulate();
					sim.hooks = None;
					(out, ALONSO_CHAIN.map(|q| sim.w.completed.contains(&q)))
				},
			);
			played(c, &who, out);
			let log = log.borrow();
			c.ok(log.reached, &format!("{who}: is led to Alonso"));
			c.eq(done, [offered; 3], &format!("{who}: the chain is {}handed in", if offered { "" } else { "not " }));
			let want = if offered { Some(Some("Alonso".to_string())) } else { None };
			c.eq(log.held.clone(), want, &format!("{who}: {}", if offered { "held at Alonso until 78132 is handed in" } else { "hands nothing in" }));
		}
	}
}

// ---------------------------------------------------------------------------------------- shipped data

/// Exceptions: the optional hand-in at Garush shares a step with the Alliance's at Pureheart in
/// Western Plaguelands.
const NEIGHBOUR_MAP: [&str; 1] = ["forever/reputation/argent-dawn.guide talk npc 10839"];

/// The codex list cache's rows by type and id: the zones (area ids) each is listed in.
fn listed_locations(root: &std::path::Path) -> Option<FxHashMap<&'static str, FxHashMap<u64, Vec<f64>>>> {
	let mut out = FxHashMap::default();
	for kind in ["npc", "object", "item"] {
		let file = root.join("data/sources/web/codex/lists").join(format!("{kind}.json"));
		let Ok(text) = std::fs::read_to_string(&file) else { continue };
		let json: serde_json::Value = serde_json::from_str(&text).ok()?;
		let rows = out.entry(kind).or_insert_with(FxHashMap::default);
		for chunk in json["chunks"].as_array().into_iter().flatten() {
			for r in chunk["rows"].as_array().into_iter().flatten() {
				let Some(id) = r["id"].as_u64() else { continue };
				let loc = r["location"].as_array().map(|a| a.iter().filter_map(|x| x.as_f64()).collect()).unwrap_or_default();
				rows.insert(id, loc);
			}
		}
	}
	Some(out)
}

fn neighbour_map(ctx: &Ctx, c: &mut Check) {
	if !ctx.root.join("data/sources/web/codex/lists/npc.json").exists() {
		c.skip("no cached web NPC lists (the web cache under data/sources)");
		return;
	}
	let Some(wh) = listed_locations(&ctx.root) else {
		c.ok(false, "the list cache reads");
		return;
	};
	let data = &ctx.data;
	let area = |map: f64| {
		let z = data.zone(&V::Num(map));
		if z.truthy() {
			num(&z, "areaId")
		} else {
			None
		}
	};
	let world = |map: f64, x: f64, y: f64, f: Option<&str>| {
		let key = format!("{}", map as i64);
		let mut fr = data.map_frames.get(if f == Some("e") { "era" } else { "forever" }).get(&key);
		if !fr.truthy() {
			fr = data.era_frame(&V::Num(map));
		}
		if !fr.truthy() {
			return None;
		}
		let n = |k: &str| num(&fr, k).unwrap_or(f64::NAN);
		Some((num(&fr, "c"), n("top") + (n("bottom") - n("top")) * y / 100.0, n("left") + (n("right") - n("left")) * x / 100.0))
	};
	let empty = Vec::new();
	let listed_in = |kind: &str, id: f64| wh.get(kind).and_then(|m| m.get(&(id as u64))).unwrap_or(&empty);
	let mut offenders: Vec<String> = Vec::new();
	for guide in ctx.all_guides() {
		for Row { step, goal, .. } in ctx.goals(&guide) {
			let (Some(map), true) = (num(&goal, "map"), !goal.get("x").is_nullish()) else { continue };
			if goal.get("map").is_nullish() {
				continue;
			}
			let mut sources: Vec<(&str, f64)> = ["npc", "object"].iter().filter_map(|k| num(&goal, k).map(|id| (*k, id))).collect();
			let item = goal.get("item");
			if sources.is_empty() && goal.get("t").as_str() == Some("collect") && item.truthy() {
				let drops = data.item(&item).get("drops");
				for k in ["npc", "object"] {
					for id in drops.get(k).keys() {
						sources.push((k, id.parse::<f64>().unwrap_or(f64::NAN)));
					}
				}
			}
			let zone = area(map);
			if sources.is_empty() || sources.iter().any(|&(k, id)| listed_in(k, id).is_empty() || zone.is_some_and(|z| listed_in(k, id).contains(&z))) {
				continue;
			}
			let gf = goal.get("f");
			let mut pts = vec![goal.clone()];
			pts.extend(goal.get("spots").items());
			let points: Vec<_> = pts.iter().filter_map(|p| world(map, num(p, "x").unwrap_or(f64::NAN), num(p, "y").unwrap_or(f64::NAN), gf.as_str())).collect();
			let elsewhere = sources.iter().any(|&(k, id)| {
				data.spawns(k, &V::Num(id)).iter().any(|s| {
					let smap = num(s, "map").unwrap_or(f64::NAN);
					smap != map
						&& area(smap).is_some_and(|a| listed_in(k, id).contains(&a))
						&& s.get("pts").items().iter().any(|p| {
							let Some((wc, wx, wy)) = world(smap, p.num_at(0), p.num_at(1), s.get("f").as_str()) else { return false };
							points.iter().any(|&(gc, gx, gy)| gc.is_some() && gc == wc && (gx - wx).hypot(gy - wy) <= 60.0)
						})
				})
			});
			let t = goal.get("t").as_str().unwrap_or_default().to_string();
			let key = if sources.len() == 1 { format!("{guide} {t} {} {}", sources[0].0, sources[0].1) } else { format!("{guide} {t} item {}", item.to_js_string()) };
			if elsewhere && !NEIGHBOUR_MAP.contains(&key.as_str()) {
				let o = format!("{key} (step {}, map {})", step.get("title").to_js_string(), map);
				if !offenders.contains(&o) {
					offenders.push(o);
				}
			}
		}
	}
	c.eq(offenders, vec![], "goals on the map of a zone the web facts do not place them in");
}

/// The walking maps' hostile hub `id` on continent 1 (PolestarPathData[1].hubs, Nav/Nav1.lua): its
/// disks as [x, y, r] (world frame: x north, y west).
fn hub_disks(root: &std::path::Path, id: &str) -> Vec<[f64; 3]> {
	let Ok(text) = std::fs::read_to_string(root.join("addon/Polestar_Nav/Nav/Nav1.lua")) else { return Vec::new() };
	let disk = regex::Regex::new(r"\{\s*(-?[0-9.]+)\s*,\s*(-?[0-9.]+)\s*,\s*(-?[0-9.]+)\s*\}").unwrap();
	let mut out = Vec::new();
	let tag = format!("id = \"{id}\"");
	for line in text.lines().filter(|l| l.contains(&tag)) {
		let Some(at) = line.find("disks = {") else { continue };
		out = disk.captures_iter(&line[at..]).map(|m| [m[1].parse().unwrap_or(f64::NAN), m[2].parse().unwrap_or(f64::NAN), m[3].parse().unwrap_or(f64::NAN)]).collect();
	}
	out
}

fn cozy_sleeping_bag(ctx: &Ctx, c: &mut Check) {
	let list = ctx.goals(COZY);
	let Some(hills) = at(c, &list, "the path into the hills", |g| g.get("t").as_str() == Some("goto") && num(g, "map") == Some(1442.0)) else { return };
	let step = list[hills].s;
	let before: Vec<&Row> = list.iter().enumerate().filter(|(i, r)| r.s == step && *i < hills && r.goal.get("t").as_str() == Some("goto")).map(|(_, r)| r).collect();
	let sided = |side: &str| -> Vec<&Row> {
		before
			.iter()
			.copied()
			.filter(|r| {
				let only = r.goal.get("only");
				!only.truthy() || only.get("factions").items().iter().any(|f| f.as_str() == Some(side))
			})
			.collect()
	};
	let (alliance, horde) = (sided("Alliance"), sided("Horde"));
	let hubs = hub_disks(&ctx.root, "horde-honors-stand");
	if !c.ok(!hubs.is_empty(), "the walking maps know Honor's Stand") {
		return;
	}
	// A map point in the world frame the maps use: x north, y west.
	let world = |p: (f64, f64, f64)| {
		let f = ctx.data.era_frame(&V::Num(p.0));
		if !f.truthy() {
			return None;
		}
		let n = |k: &str| num(&f, k).unwrap_or(f64::NAN);
		Some((n("top") + (n("bottom") - n("top")) * p.2 / 100.0, n("left") + (n("right") - n("left")) * p.1 / 100.0))
	};
	// How far (yd) the line from a to b stays outside the hub's disks.
	let clear = |a: (f64, f64, f64), b: (f64, f64, f64)| -> Option<f64> {
		let (p, q) = (world(a)?, world(b)?);
		let (dx, dy) = (q.0 - p.0, q.1 - p.1);
		let l2 = dx * dx + dy * dy;
		Some(
			hubs.iter()
				.map(|&[x, y, r]| {
					let t = (((x - p.0) * dx + (y - p.1) * dy) / l2).clamp(0.0, 1.0);
					(p.0 + dx * t - x).hypot(p.1 + dy * t - y) - r
				})
				.fold(f64::INFINITY, f64::min),
		)
	};
	let point = |g: &V| (num(g, "map").unwrap_or(f64::NAN), num(g, "x").unwrap_or(f64::NAN), num(g, "y").unwrap_or(f64::NAN));
	let mut stops = vec![(1413.0, 42.08, 32.49)];
	stops.extend(alliance.iter().map(|r| point(&r.goal)));
	stops.push(point(&list[hills].goal));
	for w in stops.windows(2) {
		let (a, b) = (w[0], w[1]);
		let Some(off) = clear(a, b) else {
			c.ok(false, &format!("the points {a:?} and {b:?} have an Era frame"));
			return;
		};
		c.ok(off > 50.0, &format!("the arrow from {},{} to {},{} (map {}) passes {} yd outside Honor's Stand", a.1, a.2, b.1, b.2, b.0, off.round()));
	}
	c.eq(alliance.len(), 1, "Alliance get one waypoint before the path");
	if let Some(a) = alliance.first() {
		let near = yards(ctx, c, point(&a.goal), (1413.0, 40.2, 24.88)).is_some_and(|d| d <= 30.0);
		c.ok(near, "it is the reporter's safe spot");
	}
	c.eq(horde.len(), 0, "Horde get none");
}
