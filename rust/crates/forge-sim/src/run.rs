//! A world compiled for one character (port of tools/lib/sim/run.js `compileRun` without
//! packages, and `makeTables`): flat arrays the evaluator walks without allocating.
//!
//! Quests are the character's open set from `forge_world::Rules` (the one availability rule),
//! sorted by id; prerequisites are the rule's reduced ones. Points are the world points the run
//! uses (givers, enders, task sites, inns, the start), indexed densely.

use crate::params::Params;
use crate::walks::Walks;
use crate::xp::mob_xp;
use forge_core::js_hypot;
use forge_world::world::{Work, World};
use forge_world::Rules;
use rustc_hash::FxHashMap;

pub const K_ACCEPT: u8 = 0;
pub const K_TASK: u8 = 1;
pub const K_TURNIN: u8 = 2;
/// Sequences only: grind to a level checkpoint (q = level, task = xp into it).
pub const K_GRIND: u8 = 3;
/// A class training stop (`train class`): travel to `pt` (a town's trainers) and train.
pub const K_TRAIN: u8 = 4;

pub const W_KILL: u8 = 0;
pub const W_USE: u8 = 1;
pub const W_ESCORT: u8 = 2;
pub const W_BUY: u8 = 3;
pub const W_VISIT: u8 = 4;
pub const W_DUNGEON: u8 = 5;

/// Transport nodes considered at each end of a leg.
pub const NEAR_K: usize = 3;
/// Straight-line nearest nodes kept per point for Travel to pick NEAR_K of by walk.
pub const NEAR_CAND: usize = 8;
/// A flight master / inn this close is learned / bound.
pub const NEAR_HUB: f64 = 200.0;
/// Kills of one mob credit another quest's work on it this close (yards).
pub const SHARE_R: f64 = 100.0;
/// Side of a spot cell (spot returns), yards.
pub const SPOT_CELL: f64 = 250.0;
/// Mob level stride in the kill tables.
pub const MOBL: usize = 64;
/// Quest log size when the world names none (world.js MAX_OPEN).
pub const MAX_OPEN: u32 = 40;

/// Seconds a camp's mob takes to come back when the data has none (compile.js DEFAULT_RESPAWN).
pub const DEFAULT_RESPAWN: f64 = 300.0;
/// Yards between kills at a camp of one spawn point (camp.js SINGLE_SPACING).
pub const SINGLE_SPACING: f64 = 40.0;
/// Yards: camps this close are one hunting ground (compile.js HUNT_R).
pub const HUNT_R: f64 = 250.0;
/// A ground of fewer mobs is not farmed while another exists (camp.js MIN_SPAWNS).
pub const MIN_SPAWNS: f64 = 3.0;
/// Seconds: a camp respawning slower than this is a rare's (left out while another exists).
pub const RARE_RESPAWN: f64 = 3600.0;

/// A camp a kill work item can be done at (world camp × the mob it is killed for): where, how
/// many of the mobs live there, their respawn, the yards between them and their level.
#[derive(Clone, Debug)]
pub struct RunCamp {
	pub pt: u32,
	pub spawns: f64,
	pub respawn: f64,
	pub spacing: f64,
	pub mob: i32,
}

/// A transport ride (boat, zeppelin, tram, lift, portal): node a -> node b.
#[derive(Clone, Debug)]
pub struct RideEdge {
	pub a: usize,
	pub b: usize,
	pub ride: f64,
	pub wait: f64,
}

/// Danger grid of one region (world.danger).
#[derive(Clone, Debug)]
pub struct DangerGrid {
	pub gx0: i64,
	pub gy0: i64,
	pub nx: i64,
	pub ny: i64,
	pub cell: f64,
	pub z: Vec<u32>,
}

pub struct Run {
	pub faction: forge_core::Faction,
	pub race: String,
	pub cls: Option<String>,
	/// World point count (walk keys are world point ids).
	pub nw: usize,
	pub start_pt: u32,
	// ---- quests (sorted by id) ----
	pub q_id: Vec<u32>,
	pub q_index: FxHashMap<u32, u32>,
	pub q_level: Vec<i32>,
	pub q_min_level: Vec<i32>,
	pub q_tier: Vec<u32>,
	/// Recorded full reward, 0 = estimate, -1 = none (repeatable).
	pub q_xp: Vec<f64>,
	pub q_giver: Vec<u32>,
	pub q_ender: Vec<u32>,
	pub q_accept: Vec<i32>,
	pub q_task0: Vec<u32>,
	pub q_task1: Vec<u32>,
	pub q_pre: Vec<Vec<u32>>,
	pub q_all: Vec<Vec<u32>>,
	pub q_excl: Vec<Vec<u32>>,
	pub q_after: Vec<Vec<u32>>,
	pub q_parent: Vec<i32>,
	/// Clamped levels 0..63 and quests by level, then index (abandonable).
	pub q_lv: Vec<usize>,
	pub q_by_level: Vec<u32>,
	pub q_lv_start: Vec<usize>,
	// ---- tasks and work ----
	pub task_pt: Vec<u32>,
	/// Per task: the quest objectives (0-based oi, as bits) worked there (the seed places a
	/// guide goal naming one objective at that objective's task).
	pub task_objs: Vec<u64>,
	/// Per task: its items drop from so many kinds of mob (> BAG_SOURCES) that the player has
	/// them from the bags (cloth for the donations): no trip, no work (route profiles set it).
	pub task_bag: Vec<bool>,
	/// v1's travel plan (route profiles): hearths, binds and flight paths where v1's guide has
	/// them, keyed by the quest step after the guide's line. None: the model's own rules.
	pub plan: Option<std::sync::Arc<TravelPlan>>,
	pub task_w0: Vec<u32>,
	pub task_w1: Vec<u32>,
	/// Objective tasks' quest (accept item tasks: -1).
	pub t_quest: Vec<i32>,
	pub w_kind: Vec<u8>,
	pub w_level: Vec<i32>,
	pub w_count: Vec<f64>,
	pub w_elite: Vec<bool>,
	pub w_spacing: Vec<f64>,
	pub w_drop: Vec<bool>,
	pub w_mob: Vec<u32>,
	pub w_task: Vec<u32>,
	pub w_share: Vec<Vec<u32>>,
	// ---- points (run indices) ----
	pub pt_list: Vec<u32>,
	/// World point -> run point (-1: not in the run).
	pub pt_index: Vec<i32>,
	pub p_c: Vec<i64>,
	pub p_r: Vec<i64>,
	pub p_x: Vec<f64>,
	pub p_y: Vec<f64>,
	pub p_map: Vec<u32>,
	pub p_fp: Vec<i32>,
	pub p_inn: Vec<i32>,
	pub p_near: Vec<i32>,
	pub p_near_d: Vec<f64>,
	pub p_zone: Vec<u32>,
	pub p_cell: Vec<u32>,
	pub zone_count: usize,
	pub cell_count: usize,
	pub log_cap: u32,
	pub inn_pt: Vec<u32>,
	// ---- transport nodes ----
	pub n_nodes: usize,
	pub node_w: Vec<u32>,
	pub node_r: Vec<i64>,
	pub node_c: Vec<i64>,
	pub node_x: Vec<f64>,
	pub node_y: Vec<f64>,
	pub fp_bit: Vec<i32>,
	pub fp_count: usize,
	pub taxi: Vec<(usize, usize, f64)>,
	pub rides: Vec<RideEdge>,
	pub danger: FxHashMap<i64, DangerGrid>,
	pub zone_min: FxHashMap<u32, f64>,
	pub grind_spacing: Vec<f64>,
	/// QuestXP rows (by level: per tier), from the world.
	pub quest_xp_rows: Vec<Vec<f64>>,
	/// Run points of towns with the class trainers (`train class` stops); set by the profile.
	pub towns: Vec<u32>,
	/// Of those, the character's own starting valley: trained at only before leaving it.
	pub valley_towns: Vec<u32>,
	/// Per quest: its time limit in seconds (0: none).
	pub q_limit: Vec<f64>,
	/// Per quest: the task that holds its escort (-1: none).
	pub q_escort_task: Vec<i32>,
	/// Camps of kill work (see RunCamp).
	pub camps: Vec<RunCamp>,
	/// Per kill work item: its camps (index, kills needed there: the objective's count, or its
	/// items over the camp's drop chance per kill).
	pub w_alts: Vec<Vec<(u32, f64)>>,
	/// Per kill work item: the alternative nearest its task's site (-1: none).
	pub w_default: Vec<i32>,
}

impl Run {
	pub fn q(&self, id: u32) -> Option<u32> {
		self.q_index.get(&id).copied()
	}
	pub fn n_quests(&self) -> usize {
		self.q_id.len()
	}
	/// Run point of world point `p`, if the run indexes it.
	pub fn run_pt(&self, p: u32) -> Option<u32> {
		let i = *self.pt_index.get(p as usize)?;
		(i >= 0).then_some(i as u32)
	}
	/// Straight-line yards between two run points (Infinity across regions).
	pub fn straight(&self, a: u32, b: u32) -> f64 {
		let (a, b) = (a as usize, b as usize);
		if self.p_r[a] != self.p_r[b] {
			return f64::INFINITY;
		}
		js_hypot(self.p_x[a] - self.p_x[b], self.p_y[a] - self.p_y[b])
	}
}

/// Compile `world` for one character: race a `starts` label ("Orc", "Human", "Undead"),
/// cls None for any class (class quests out). `extra_pts`: more world points to index.
pub fn compile_run(world: &World, rules: &Rules, race: &str, cls: Option<&str>, extra_pts: &[u32]) -> Result<Run, String> {
	let start = world.starts.iter().find(|(r, _)| r == race).map(|(_, s)| s.clone()).ok_or_else(|| format!("no {} start for race {race}", world.faction.name()))?;
	let nw = world.points.len();
	let mut ids: Vec<u32> = rules.open.keys().copied().collect();
	ids.sort_unstable();
	let q_index: FxHashMap<u32, u32> = ids.iter().enumerate().map(|(i, &id)| (id, i as u32)).collect();
	let nq = ids.len();
	let mut pt_list: Vec<u32> = Vec::new();
	let mut pt_index: Vec<i32> = vec![-1; nw];
	fn use_pt(p: u32, pt_list: &mut Vec<u32>, pt_index: &mut [i32]) -> u32 {
		if pt_index[p as usize] < 0 {
			pt_index[p as usize] = pt_list.len() as i32;
			pt_list.push(p);
		}
		pt_index[p as usize] as u32
	}
	let mut r = Run {
		faction: world.faction,
		race: race.to_string(),
		cls: cls.map(str::to_string),
		nw,
		start_pt: 0,
		q_id: ids.clone(),
		q_index: q_index.clone(),
		q_level: vec![0; nq],
		q_min_level: vec![0; nq],
		q_tier: vec![0; nq],
		q_xp: vec![0.0; nq],
		q_giver: vec![0; nq],
		q_ender: vec![0; nq],
		q_accept: vec![-1; nq],
		q_task0: vec![0; nq],
		q_task1: vec![0; nq],
		q_pre: vec![Vec::new(); nq],
		q_all: vec![Vec::new(); nq],
		q_excl: vec![Vec::new(); nq],
		q_after: vec![Vec::new(); nq],
		q_parent: vec![-1; nq],
		q_lv: Vec::new(),
		q_by_level: Vec::new(),
		q_lv_start: Vec::new(),
		task_pt: Vec::new(),
		task_objs: Vec::new(),
		task_bag: Vec::new(),
		plan: None,
		task_w0: Vec::new(),
		task_w1: Vec::new(),
		t_quest: Vec::new(),
		w_kind: Vec::new(),
		w_level: Vec::new(),
		w_count: Vec::new(),
		w_elite: Vec::new(),
		w_spacing: Vec::new(),
		w_drop: Vec::new(),
		w_mob: Vec::new(),
		w_task: Vec::new(),
		w_share: Vec::new(),
		pt_list: Vec::new(),
		pt_index: Vec::new(),
		p_c: Vec::new(),
		p_r: Vec::new(),
		p_x: Vec::new(),
		p_y: Vec::new(),
		p_map: Vec::new(),
		p_fp: Vec::new(),
		p_inn: Vec::new(),
		p_near: Vec::new(),
		p_near_d: Vec::new(),
		p_zone: Vec::new(),
		p_cell: Vec::new(),
		zone_count: 0,
		cell_count: 0,
		log_cap: if world.max_open > 0 { world.max_open } else { MAX_OPEN },
		inn_pt: Vec::new(),
		n_nodes: world.nodes.len(),
		node_w: Vec::new(),
		node_r: Vec::new(),
		node_c: Vec::new(),
		node_x: Vec::new(),
		node_y: Vec::new(),
		fp_bit: Vec::new(),
		fp_count: 0,
		taxi: Vec::new(),
		rides: Vec::new(),
		danger: FxHashMap::default(),
		zone_min: FxHashMap::default(),
		grind_spacing: world.grind_spacing.clone(),
		towns: Vec::new(),
		valley_towns: Vec::new(),
		q_limit: Vec::new(),
		q_escort_task: Vec::new(),
		camps: Vec::new(),
		w_alts: Vec::new(),
		w_default: Vec::new(),
		quest_xp_rows: Vec::new(),
	};
	let is_int = |v: f64| v.fract() == 0.0 && v.is_finite();
	let add_task = |r: &mut Run, pt_list: &mut Vec<u32>, pt_index: &mut [i32], t: &forge_world::world::Task| -> u32 {
		let ti = r.task_pt.len() as u32;
		let p = use_pt(t.pt, pt_list, pt_index);
		r.task_pt.push(p);
		r.task_w0.push(r.w_kind.len() as u32);
		for w in &t.work {
			let (kind, level, count, elite, spacing, drop, mob) = match *w {
				Work::Kill { level, count, elite, spacing, npc } => (W_KILL, (level.min((MOBL - 1) as f64)).max(1.0) as i32, count, elite, spacing, !is_int(count), npc),
				Work::Use(n) => (W_USE, 0, n, false, 0.0, !is_int(n), 0),
				Work::Escort => (W_ESCORT, 0, 1.0, false, 0.0, false, 0),
				Work::Buy => (W_BUY, 0, 1.0, false, 0.0, false, 0),
				Work::Visit => (W_VISIT, 0, 1.0, false, 0.0, false, 0),
				Work::Dungeon(_) => (W_DUNGEON, 0, 1.0, false, 0.0, false, 0),
			};
			r.w_kind.push(kind);
			r.w_level.push(level);
			r.w_count.push(count);
			r.w_elite.push(elite);
			r.w_spacing.push(spacing);
			r.w_drop.push(drop);
			r.w_mob.push(mob);
			r.w_task.push(ti);
		}
		r.task_w1.push(r.w_kind.len() as u32);
		ti
	};
	for (i, &id) in ids.iter().enumerate() {
		let q = &world.quests[rules.open[&id]];
		r.q_level[i] = q.level as i32;
		r.q_min_level[i] = q.min_level as i32;
		r.q_excl[i] = q.excl.iter().filter_map(|&e| u32::try_from(e).ok().and_then(|e| q_index.get(&e).copied())).collect();
		r.q_tier[i] = q.tier;
		r.q_xp[i] = if q.no_xp == Some(true) { -1.0 } else { q.xp.filter(|x| *x != 0.0 && !x.is_nan()).unwrap_or(0.0) };
		r.q_giver[i] = use_pt(q.giver, &mut pt_list, &mut pt_index);
		r.q_ender[i] = use_pt(q.ender, &mut pt_list, &mut pt_index);
		if let Some(a) = &q.accept {
			r.q_accept[i] = add_task(&mut r, &mut pt_list, &mut pt_index, a) as i32;
		}
		r.q_task0[i] = r.task_pt.len() as u32;
		for t in &q.tasks {
			add_task(&mut r, &mut pt_list, &mut pt_index, t);
		}
		r.q_task1[i] = r.task_pt.len() as u32;
		r.task_objs.resize(r.task_pt.len(), 0);
		for o in &q.objs {
			if let Some(t) = o.task.filter(|&t| (0..63).contains(&o.oi) && r.q_task0[i] + t < r.q_task1[i]) {
				r.task_objs[(r.q_task0[i] + t) as usize] |= 1u64 << o.oi;
			}
		}
		let rec = forge_world::data::Quest { id, ..Default::default() };
		let pr = rules.prereqs_of(&rec);
		let idx = |v: &[i64]| v.iter().filter_map(|&p| u32::try_from(p).ok().and_then(|p| q_index.get(&p).copied())).collect::<Vec<u32>>();
		r.q_pre[i] = idx(&pr.any);
		r.q_all[i] = idx(&pr.all);
		if let Some(l) = q.in_log.and_then(|l| u32::try_from(l).ok()).and_then(|l| q_index.get(&l).copied()) {
			r.q_parent[i] = l as i32;
		}
		r.q_after[i] = q.after.iter().flatten().filter_map(|c| q_index.get(c).copied()).collect();
		r.q_limit.push(q.limit.filter(|l| *l > 0.0).unwrap_or(0.0));
		r.q_escort_task.push((r.q_task0[i]..r.q_task1[i]).find(|&t| (r.task_w0[t as usize]..r.task_w1[t as usize]).any(|w| r.w_kind[w as usize] == W_ESCORT)).map_or(-1, |t| t as i32));
	}
	let ntask = r.task_pt.len();
	r.t_quest = vec![-1; ntask];
	for i in 0..nq {
		for t in r.q_task0[i]..r.q_task1[i] {
			r.t_quest[t as usize] = i as i32;
		}
	}
	// Shared kill credit: other objective kill items on the same mob within SHARE_R.
	let nw_items = r.w_kind.len();
	let mut by_mob: Vec<(u32, Vec<u32>)> = Vec::new();
	let mut mob_ix: FxHashMap<u32, usize> = FxHashMap::default();
	for w in 0..nw_items {
		if r.w_kind[w] != W_KILL || r.w_mob[w] == 0 {
			continue;
		}
		let k = *mob_ix.entry(r.w_mob[w]).or_insert_with(|| {
			by_mob.push((r.w_mob[w], Vec::new()));
			by_mob.len() - 1
		});
		by_mob[k].1.push(w as u32);
	}
	r.w_share = vec![Vec::new(); nw_items];
	for (_, list) in &by_mob {
		for &a in list {
			let pa = &world.points[pt_list[r.task_pt[r.w_task[a as usize] as usize] as usize] as usize];
			for &b in list {
				if a == b || r.t_quest[r.w_task[b as usize] as usize] < 0 {
					continue;
				}
				let pb = &world.points[pt_list[r.task_pt[r.w_task[b as usize] as usize] as usize] as usize];
				if pa.region == pb.region && js_hypot(pa.wx - pb.wx, pa.wy - pb.wy) <= SHARE_R {
					r.w_share[a as usize].push(b);
				}
			}
		}
	}
	r.start_pt = use_pt(start.pt, &mut pt_list, &mut pt_index);
	r.inn_pt = world.inns.iter().map(|n| use_pt(n.pt, &mut pt_list, &mut pt_index)).collect();
	for &p in extra_pts {
		use_pt(p, &mut pt_list, &mut pt_index);
	}
	// ---- grounds: where a kill work item's mobs live (the camp and spot fidelity terms) ----
	// The objective's camps (mobs of its NPC, or the droppers of its item) are pooled into
	// hunting grounds: camps within HUNT_R of each other (single linkage, as compile.js HUNT_R)
	// are farmed as one. A ground of fewer than MIN_SPAWNS mobs is left out while another
	// exists (camp.js allowFor).
	r.w_alts = vec![Vec::new(); r.w_kind.len()];
	r.w_default = vec![-1; r.w_kind.len()];
	let mut ground_ix: FxHashMap<Vec<u32>, u32> = FxHashMap::default();
	struct Member {
		cw: u32,
		spawns: f64,
		items: f64,
	}
	for (i, &id) in ids.iter().enumerate() {
		let q = &world.quests[rules.open[&id]];
		for t in r.q_task0[i]..r.q_task1[i] {
			let ti = t - r.q_task0[i];
			let tpt = &world.points[pt_list[r.task_pt[t as usize] as usize] as usize];
			for w in r.task_w0[t as usize]..r.task_w1[t as usize] {
				let w = w as usize;
				if r.w_kind[w] != W_KILL || r.w_mob[w] == 0 {
					continue;
				}
				let mob = r.w_mob[w];
				let key = format!("npc:{mob}");
				let Some(o) = q.objs.iter().find(|o| o.task == Some(ti) && ((o.kind == "kill" && o.id == Some(mob as f64)) || (o.kind == "item" && o.chances.iter().any(|(c, _)| *c == key)))) else {
					continue;
				};
				let chance = |npc: u32| -> f64 {
					if o.kind == "kill" {
						return if npc == mob { 100.0 } else { 0.0 };
					}
					let k = format!("npc:{npc}");
					o.chances.iter().find(|(c, _)| *c == k).and_then(|(_, v)| *v).unwrap_or(0.0)
				};
				// The objective's kill work items in this task (v1 splits an item's kills over
				// its droppers): this item's share of them.
				let total: f64 = (r.task_w0[t as usize]..r.task_w1[t as usize]).map(|x| x as usize).filter(|&x| r.w_kind[x] == W_KILL && chance(r.w_mob[x]) > 0.0).map(|x| r.w_count[x]).sum();
				let share = if total > 0.0 { r.w_count[w] / total } else { 1.0 };
				// The objective's mobs per camp: its NPC, or every dropper of its item (kills
				// needed there: the item count over the ground's drops per kill).
				let mut mem: Vec<Member> = Vec::new();
				for &cw in &o.camps {
					let camp = &world.camps[cw as usize];
					let (mut spawns, mut items) = (0.0f64, 0.0f64);
					for s in camp.sources.iter().filter(|s| s.kind == forge_world::data::Kind::Npc) {
						let ch = chance(s.id);
						if ch > 0.0 {
							spawns += s.spawns as f64;
							items += s.spawns as f64 * ch / 100.0;
						}
					}
					if spawns > 0.0 {
						mem.push(Member { cw, spawns, items });
					}
				}
				// A rare's camp (respawn over RARE_RESPAWN) is left out while another exists.
				let rare = |m: &Member| world.camps[m.cw as usize].respawn.unwrap_or(DEFAULT_RESPAWN) > RARE_RESPAWN;
				if mem.iter().any(|m| !rare(m)) {
					mem.retain(|m| !rare(m));
				}
				// Single linkage within HUNT_R.
				let pt_of = |cw: u32| &world.points[world.camps[cw as usize].pt as usize];
				let near = |a: u32, b: u32| {
					let (pa, pb) = (pt_of(a), pt_of(b));
					pa.region == pb.region && js_hypot(pa.wx - pb.wx, pa.wy - pb.wy) <= HUNT_R
				};
				let mut group: Vec<usize> = (0..mem.len()).collect();
				let find = |g: &mut Vec<usize>, mut x: usize| {
					while g[x] != x {
						g[x] = g[g[x]];
						x = g[x];
					}
					x
				};
				for a in 0..mem.len() {
					for b in a + 1..mem.len() {
						if near(mem[a].cw, mem[b].cw) {
							let (ra, rb) = (find(&mut group, a), find(&mut group, b));
							if ra != rb {
								group[ra.max(rb)] = ra.min(rb);
							}
						}
					}
				}
				let mut grounds: Vec<Vec<usize>> = Vec::new();
				let mut root_of: FxHashMap<usize, usize> = FxHashMap::default();
				for a in 0..mem.len() {
					let ra = find(&mut group, a);
					let k = *root_of.entry(ra).or_insert_with(|| {
						grounds.push(Vec::new());
						grounds.len() - 1
					});
					grounds[k].push(a);
				}
				// No ground of MIN_SPAWNS mobs: the data lacks the mob's spawns; v1's site stays.
				if !grounds.iter().any(|g| g.iter().map(|&a| mem[a].spawns).sum::<f64>() >= MIN_SPAWNS) {
					continue;
				}
				let mut best = (f64::INFINITY, -1i32);
				for g in &grounds {
					let spawns: f64 = g.iter().map(|&a| mem[a].spawns).sum();
					if spawns < MIN_SPAWNS {
						continue;
					}
					let items: f64 = g.iter().map(|&a| mem[a].items).sum();
					let kills = o.count / (items / spawns) * share;
					let mut cws: Vec<u32> = g.iter().map(|&a| mem[a].cw).collect();
					cws.sort_unstable();
					let lead = *g.iter().max_by(|&&a, &&b| mem[a].spawns.total_cmp(&mem[b].spawns).then(mem[b].cw.cmp(&mem[a].cw))).unwrap();
					let lead_cw = mem[lead].cw;
					let cp = use_pt(world.camps[lead_cw as usize].pt, &mut pt_list, &mut pt_index);
					let nc = r.camps.len() as u32;
					let ix = *ground_ix.entry(cws.iter().copied().chain([u32::MAX, mob]).collect()).or_insert_with(|| {
						// Spawn-weighted centre, the ground's reach from it, its levels and respawn.
						let (mut cx, mut cy, mut lv, mut lvw, mut resp) = (0.0, 0.0, 0.0, 0.0, 0.0);
						for &a in g {
							let c = &world.camps[mem[a].cw as usize];
							let p = pt_of(mem[a].cw);
							cx += p.wx * mem[a].spawns;
							cy += p.wy * mem[a].spawns;
							resp += c.respawn.unwrap_or(DEFAULT_RESPAWN) * mem[a].spawns;
							if let (Some(x), Some(y)) = (c.level_min, c.level_max) {
								lv += (x + y) / 2.0 * mem[a].spawns;
								lvw += mem[a].spawns;
							}
						}
						let (cx, cy) = (cx / spawns, cy / spawns);
						let reach = g.iter().map(|&a| {
							let p = pt_of(mem[a].cw);
							js_hypot(p.wx - cx, p.wy - cy) + world.camps[mem[a].cw as usize].radius
						});
						let reach = reach.fold(0.0f64, f64::max);
						let spacing = if reach > 0.0 { (std::f64::consts::PI * reach * reach / spawns).sqrt() } else { SINGLE_SPACING };
						let mid = if lvw > 0.0 { forge_core::js_round(lv / lvw) as i32 } else { r.w_level[w] };
						r.camps.push(RunCamp { pt: cp, spawns, respawn: resp / spawns, spacing, mob: mid.clamp(1, (MOBL - 1) as i32) });
						nc
					});
					let cpt = &world.points[world.camps[lead_cw as usize].pt as usize];
					let dd = if cpt.region == tpt.region { js_hypot(cpt.wx - tpt.wx, cpt.wy - tpt.wy) } else { f64::INFINITY };
					if dd < best.0 {
						best = (dd, r.w_alts[w].len() as i32);
					}
					r.w_alts[w].push((ix, kills));
				}
				r.w_default[w] = best.1;
			}
		}
	}
	// ---- point geometry, flight masters and inns at points ----
	let n = world.nodes.len();
	let node_pt: Vec<&forge_world::world::Point> = world.nodes.iter().map(|nd| &world.points[nd.pt as usize]).collect();
	let inn_w: Vec<&forge_world::world::Point> = world.inns.iter().map(|nd| &world.points[nd.pt as usize]).collect();
	r.fp_bit = vec![-1; n];
	for (i, nd) in world.nodes.iter().enumerate() {
		if nd.kind == "fp" {
			r.fp_bit[i] = r.fp_count as i32;
			r.fp_count += 1;
		}
	}
	if r.fp_count > 50 {
		return Err(format!("too many flight paths for the known-set key ({})", r.fp_count));
	}
	let np = pt_list.len();
	r.p_fp = vec![-1; np];
	r.p_inn = vec![-1; np];
	r.p_near = vec![-1; np * NEAR_CAND];
	r.p_near_d = vec![0.0; np * NEAR_CAND];
	let mut zone_idx: FxHashMap<u32, u32> = FxHashMap::default();
	let mut cell_idx: FxHashMap<(i64, i64, i64), u32> = FxHashMap::default();
	let mut near: Vec<(f64, usize)> = Vec::with_capacity(n);
	for (i, &wp) in pt_list.iter().enumerate() {
		let p = &world.points[wp as usize];
		r.p_c.push(p.c);
		r.p_r.push(p.region);
		r.p_x.push(p.wx);
		r.p_y.push(p.wy);
		r.p_map.push(p.map);
		near.clear();
		for (k, q) in node_pt.iter().enumerate() {
			if q.region != p.region {
				continue;
			}
			let d = js_hypot(q.wx - p.wx, q.wy - p.wy);
			near.push((d, k));
			if world.nodes[k].kind == "fp" && d <= NEAR_HUB {
				let cur = r.p_fp[i];
				if cur < 0 || d < near.iter().find(|x| x.1 == cur as usize).map_or(f64::INFINITY, |x| x.0) {
					r.p_fp[i] = k as i32;
				}
			}
		}
		near.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(std::cmp::Ordering::Equal).then(a.1.cmp(&b.1)));
		for (k, x) in near.iter().take(NEAR_CAND).enumerate() {
			r.p_near[i * NEAR_CAND + k] = x.1 as i32;
			r.p_near_d[i * NEAR_CAND + k] = x.0;
		}
		let mut bd = NEAR_HUB;
		for (k, q) in inn_w.iter().enumerate() {
			if q.region != p.region {
				continue;
			}
			let d = js_hypot(q.wx - p.wx, q.wy - p.wy);
			if d <= bd {
				bd = d;
				r.p_inn[i] = k as i32;
			}
		}
		let zl = zone_idx.len() as u32;
		r.p_zone.push(*zone_idx.entry(p.map).or_insert(zl));
		let key = (p.region, (p.wx / SPOT_CELL).floor() as i64, (p.wy / SPOT_CELL).floor() as i64);
		let cl = cell_idx.len() as u32;
		r.p_cell.push(*cell_idx.entry(key).or_insert(cl));
	}
	r.zone_count = zone_idx.len();
	r.cell_count = cell_idx.len();
	r.zone_min = world.zone_min.iter().map(|(&m, &l)| (m, l)).collect();
	for g in &world.danger {
		r.danger.insert(g.region, DangerGrid { gx0: g.gx0, gy0: g.gy0, nx: g.nx, ny: g.ny, cell: g.cell, z: g.z.clone() });
	}
	r.node_w = world.nodes.iter().map(|nd| nd.pt).collect();
	r.node_r = node_pt.iter().map(|p| p.region).collect();
	r.node_c = node_pt.iter().map(|p| p.c).collect();
	r.node_x = node_pt.iter().map(|p| p.wx).collect();
	r.node_y = node_pt.iter().map(|p| p.wy).collect();
	r.taxi = world.taxi.iter().map(|(a, b, s)| (*a as usize, *b as usize, s.as_f64().unwrap_or(f64::NAN))).collect();
	r.rides = world.rides.iter().map(|x| RideEdge { a: x.a as usize, b: x.b as usize, ride: x.seconds, wait: x.wait }).collect();
	r.quest_xp_rows = match &world.quest_xp {
		serde_json::Value::Array(rows) => rows.iter().map(|row| row.as_array().map(|a| a.iter().map(|v| v.as_f64().unwrap_or(0.0)).collect()).unwrap_or_default()).collect(),
		_ => Vec::new(),
	};
	// Quests by level (abandonable).
	r.q_lv = r.q_level.iter().map(|&l| l.clamp(0, 63) as usize).collect();
	let mut by: Vec<u32> = (0..nq as u32).collect();
	by.sort_by_key(|&i| (r.q_lv[i as usize], i));
	let mut start_at = vec![0usize; 65];
	for &q in &by {
		start_at[r.q_lv[q as usize] + 1] += 1;
	}
	for l in 0..64 {
		start_at[l + 1] += start_at[l];
	}
	r.q_by_level = by;
	r.q_lv_start = start_at;
	r.pt_index = pt_index;
	r.pt_list = pt_list;
	Ok(r)
}

/// Parameter-dependent tables (run.js makeTables).
pub struct Tables {
	pub p: Params,
	pub kill_t: Vec<f64>,
	pub kill_x: Vec<f64>,
	pub q_full: Vec<f64>,
	pub grind_rate: Vec<f64>,
}

pub fn make_tables(run: &Run, p: &Params) -> Tables {
	let mut t = Tables { p: p.clone(), kill_t: vec![0.0; 61 * MOBL], kill_x: vec![0.0; 61 * MOBL], q_full: vec![0.0; run.n_quests()], grind_rate: vec![0.0; 62] };
	for l in 1..=60usize {
		let base = p.kill_sec1 + ((p.kill_sec60 - p.kill_sec1) * (l as f64 - 1.0)) / 59.0;
		for m in 0..MOBL {
			let d = m as f64 - l as f64;
			let f = if d >= 0.0 { 1.0 + p.kill_up * d } else { (1.0 + p.kill_down * d).max(0.5) };
			t.kill_t[l * MOBL + m] = base * f * p.class_factor;
			t.kill_x[l * MOBL + m] = mob_xp(l as i64, m as i64, false, false) * (1.0 + p.rested_share);
		}
	}
	t.grind_rate = grind_rates(run, p);
	let rows = &run.quest_xp_rows;
	for i in 0..run.n_quests() {
		t.q_full[i] = if run.q_xp[i] < 0.0 {
			0.0
		} else if run.q_xp[i] > 0.0 {
			run.q_xp[i] * p.quest_xp_scale
		} else if rows.len() > 1 {
			let li = (run.q_level[i].max(1) as usize).min(rows.len() - 1);
			let row = if rows[li].is_empty() { rows.get(60) } else { Some(&rows[li]) };
			row.and_then(|row| row.get(run.q_tier[i] as usize)).copied().unwrap_or(0.0) * p.quest_est_scale * p.quest_xp_scale
		} else {
			0.0
		};
	}
	t
}

/// Run-point walks for a run (v1 `walkRun`, f32 like its Float32Array) from a walk store.
pub fn walk_yards_f32(walks: &dyn Walks, a_world: u32, b_world: u32) -> Option<f64> {
	walks.yards(a_world, b_world).map(|y| y as f32 as f64)
}

/// Grinding XP/s by level (makeTables grindRate): the best of mobs at +0..+2 levels with the
/// grind camp spacing of that level, × grindEff.
pub fn grind_rates(run: &Run, p: &Params) -> Vec<f64> {
	let mut g = vec![0.0; 62];
	for l in 1..=60usize {
		let base = p.kill_sec1 + ((p.kill_sec60 - p.kill_sec1) * (l as f64 - 1.0)) / 59.0;
		let mut best = 0.0f64;
		for d in 0..=2usize {
			let m = (MOBL - 1).min(l + d);
			let dd = m as f64 - l as f64;
			let f = if dd >= 0.0 { 1.0 + p.kill_up * dd } else { (1.0 + p.kill_down * dd).max(0.5) };
			let gs = &run.grind_spacing;
			let sp = if gs.is_empty() { 0.0 } else { gs[(gs.len() - 1).min(m)] };
			let sec = base * f * p.class_factor + (sp * p.spacing) / p.run_speed;
			let rate = mob_xp(l as i64, m as i64, false, false) * (1.0 + p.rested_share) / sec;
			if rate > best {
				best = rate;
			}
		}
		g[l] = best * p.grind_eff;
	}
	g
}

/// A quest step's key across runs of one world and race: kind, quest id, task within the quest
/// (-1: none).
pub type StepKey = (u8, u32, i32);

impl Run {
	/// The key of a quest step (None for grinds and trainings).
	pub fn step_key(&self, kind: u8, q: u32, task: i32) -> Option<StepKey> {
		match kind {
			K_ACCEPT | K_TURNIN => Some((kind, self.q_id[q as usize], -1)),
			K_TASK => Some((kind, self.q_id[q as usize], task - self.q_task0[q as usize] as i32)),
			_ => None,
		}
	}
}

/// v1's travel plan (Run::plan): the hearth before a step, the inn bound at a step, the flight
/// paths learned at a step.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct TravelPlan {
	pub hearth: rustc_hash::FxHashSet<StepKey>,
	pub bind: rustc_hash::FxHashMap<StepKey, u32>,
	pub fp: rustc_hash::FxHashMap<StepKey, Vec<u32>>,
}
