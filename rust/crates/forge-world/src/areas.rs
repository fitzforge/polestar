//! Areas: the places a route chooses between (port of tools/lib/sim/areas.js). Hub seeds
//! (>= 3 givers, or owning a flight master or inn), towns first within hubSpan/2, the rest by
//! complete linkage within `span`, straight-line world yards.

use crate::world::{Point, World};
use forge_core::js_hypot;
use rustc_hash::FxHashMap;

const CELL: f64 = 50.0;
pub const GIVER: u8 = 1;
pub const ENDER: u8 = 2;
pub const CAMP: u8 = 4;
pub const SERVICE: u8 = 8;
pub const NODE: u8 = 16;
pub const TASK: u8 = 32;
const HUB_GIVERS: usize = 3;

#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct AreaKinds {
	pub giver: u32,
	pub ender: u32,
	pub camp: u32,
	pub service: u32,
	pub node: u32,
	pub task: u32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Area {
	pub id: u32,
	pub pt: u32,
	pub c: i64,
	pub region: i64,
	pub members: Vec<u32>,
	pub hub: bool,
	pub kinds: AreaKinds,
}

/// areas.js buildAreas(world, { span: 250, hubSpan: 400 }) -> (areas, pointArea).
pub fn build_areas(world: &World, span: f64, hub_span: f64) -> (Vec<Area>, Vec<i32>) {
	let p: &[Point] = &world.points;
	let hubs = &world.hubs;
	let mut kind_of = vec![0u8; p.len()];
	let mut mark = |pt: i64, k: u8| {
		if pt >= 0 {
			kind_of[pt as usize] |= k;
		}
	};
	for q in &world.quests {
		mark(q.giver as i64, GIVER);
		mark(q.ender as i64, ENDER);
		for (_, pt) in q.g_alt.iter().flatten() {
			mark(*pt as i64, GIVER);
		}
		for (_, pt) in q.e_alt.iter().flatten() {
			mark(*pt as i64, ENDER);
		}
		for t in &q.tasks {
			mark(t.pt as i64, TASK);
		}
		if let Some(a) = &q.accept {
			mark(a.pt as i64, TASK);
		}
		for o in &q.objs {
			for &c in &o.camps {
				mark(world.camps[c as usize].pt as i64, CAMP);
			}
		}
	}
	for pt in world.service_set.keys() {
		mark(*pt as i64, SERVICE);
	}
	for inn in &world.inns {
		mark(inn.pt as i64, SERVICE);
	}
	for n in &world.nodes {
		mark(n.pt as i64, NODE);
	}
	let dist = |a: u32, b: u32| js_hypot(p[a as usize].wx - p[b as usize].wx, p[a as usize].wy - p[b as usize].wy);
	let reg = |a: u32| p[a as usize].region;

	// 1. Hub seeds.
	let mut givers: Vec<Vec<u32>> = vec![Vec::new(); hubs.len()];
	for q in &world.quests {
		if q.hub_giver >= 0 && (q.hub_giver as usize) < hubs.len() {
			let set = &mut givers[q.hub_giver as usize];
			if !set.contains(&q.giver) {
				set.push(q.giver);
			}
		}
	}
	let mut owns = vec![false; hubs.len()];
	let mut own = |fp: bool, idx: i64, pt: u32| {
		let mut best = -1i64;
		let mut best_d = f64::INFINITY;
		for (i, h) in hubs.iter().enumerate() {
			let field = if fp { h.fp } else { h.inn };
			if field != idx || reg(h.pt) != reg(pt) {
				continue;
			}
			let d = dist(h.pt, pt);
			if d < best_d {
				best = i as i64;
				best_d = d;
			}
		}
		if best >= 0 {
			owns[best as usize] = true;
		}
	};
	for (i, n) in world.nodes.iter().enumerate() {
		if n.kind == "fp" {
			own(true, i as i64, n.pt);
		}
	}
	for (i, n) in world.inns.iter().enumerate() {
		own(false, i as i64, n.pt);
	}
	let qualifying: Vec<usize> = (0..hubs.len()).filter(|&i| givers[i].len() >= HUB_GIVERS || owns[i]).collect();
	let mut order = qualifying.clone();
	order.sort_by(|&a, &b| givers[b].len().cmp(&givers[a].len()).then(a.cmp(&b)));
	let mut kept: Vec<usize> = Vec::new();
	for i in order {
		let pt = hubs[i].pt;
		if !kept.iter().any(|&k| reg(hubs[k].pt) == reg(pt) && dist(hubs[k].pt, pt) < hub_span / 2.0) {
			kept.push(i);
		}
	}
	kept.sort_unstable();

	// 2. Towns first.
	struct Group {
		region: i64,
		hub: bool,
		members: Vec<u32>,
	}
	let mut groups: Vec<Group> = kept.iter().map(|&i| Group { region: reg(hubs[i].pt), hub: true, members: Vec::new() }).collect();
	let mut owner = vec![-1i64; p.len()];
	for pt in 0..p.len() as u32 {
		if kind_of[pt as usize] == 0 {
			continue;
		}
		let mut best = -1i64;
		let mut best_d = f64::INFINITY;
		for (g, &h) in kept.iter().enumerate() {
			let s = hubs[h].pt;
			if reg(s) != reg(pt) {
				continue;
			}
			let d = dist(s, pt);
			if d <= hub_span / 2.0 && d < best_d {
				best = g as i64;
				best_d = d;
			}
		}
		if best < 0 {
			continue;
		}
		groups[best as usize].members.push(pt);
		owner[pt as usize] = best;
	}

	// 3. The rest: complete linkage within span.
	let mut grid: FxHashMap<(i64, i64, i64), Vec<u32>> = FxHashMap::default();
	let reach = (span / CELL).ceil() as i64;
	for pt in 0..p.len() as u32 {
		if kind_of[pt as usize] == 0 || owner[pt as usize] >= 0 {
			continue;
		}
		let pp = &p[pt as usize];
		let region = pp.region;
		let gx = (pp.wx / CELL).floor() as i64;
		let gy = (pp.wy / CELL).floor() as i64;
		// group -> nearest member distance, in first-seen order (a JS Map).
		let mut nearest: Vec<(i64, f64)> = Vec::new();
		for dx in -reach..=reach {
			for dy in -reach..=reach {
				let Some(list) = grid.get(&(region, gx + dx, gy + dy)) else { continue };
				for &m in list {
					let d = dist(m, pt);
					if d > span {
						continue;
					}
					let g = owner[m as usize];
					match nearest.iter_mut().find(|e| e.0 == g) {
						Some(e) => {
							if d < e.1 {
								e.1 = d;
							}
						}
						None => nearest.push((g, d)),
					}
				}
			}
		}
		let mut best = -1i64;
		let mut best_d = f64::INFINITY;
		for &(g, d) in &nearest {
			if d > best_d || (d == best_d && g > best) {
				continue;
			}
			if groups[g as usize].members.iter().all(|&m| dist(m, pt) <= span) {
				best = g;
				best_d = d;
			}
		}
		if best < 0 {
			best = groups.len() as i64;
			groups.push(Group { region, hub: false, members: Vec::new() });
		}
		groups[best as usize].members.push(pt);
		owner[pt as usize] = best;
		grid.entry((region, gx, gy)).or_default().push(pt);
	}

	let mut areas = Vec::new();
	let mut id_of = vec![-1i32; groups.len()];
	for (g, gr) in groups.into_iter().enumerate() {
		let ms = gr.members;
		if ms.is_empty() {
			continue;
		}
		let mut cx = 0.0;
		let mut cy = 0.0;
		for &m in &ms {
			cx += p[m as usize].wx;
			cy += p[m as usize].wy;
		}
		cx /= ms.len() as f64;
		cy /= ms.len() as f64;
		let mut pt = ms[0];
		let mut pd = f64::INFINITY;
		let mut kinds = AreaKinds::default();
		for &m in &ms {
			let d = js_hypot(p[m as usize].wx - cx, p[m as usize].wy - cy);
			if d < pd {
				pt = m;
				pd = d;
			}
			let k = kind_of[m as usize];
			kinds.giver += u32::from(k & GIVER != 0);
			kinds.ender += u32::from(k & ENDER != 0);
			kinds.camp += u32::from(k & CAMP != 0);
			kinds.service += u32::from(k & SERVICE != 0);
			kinds.node += u32::from(k & NODE != 0);
			kinds.task += u32::from(k & TASK != 0);
		}
		id_of[g] = areas.len() as i32;
		areas.push(Area { id: areas.len() as u32, pt, c: p[pt as usize].c, region: gr.region, members: ms, hub: gr.hub, kinds });
	}
	let point_area = (0..p.len()).map(|pt| if owner[pt] >= 0 { id_of[owner[pt] as usize] } else { -1 }).collect();
	(areas, point_area)
}
