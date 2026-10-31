//! Follows a recorded walk through the grid's links: where a player walked and the grid has no
//! way from one column to the next, that is a grid gap (a doorway closed, a stair or ramp not
//! joined, a floor dropped). Input: one walk per line, {"id","map","pts":[[wx,wy],...]} (the
//! recording's positions, no heights); output: one line per walk, {"id","cells","breaks":[..],
//! "drops":[..],"pz":[z|null per position]}.
//!
//! The recording is drawn as a line of columns (every yard). The follower keeps every surface the
//! walk may be on (all floors of the first column at the start) and moves them on through the
//! grid's links, falls and lift rides, within WIDTH columns of the line (a player cuts a corner
//! the samples do not show) and up to AHEAD columns along it. When no surface gets further along
//! the line, that is a break: it is reported with the surfaces either side, and the follower
//! starts again past it on the floors of the next column within RESEED yd of the heights it had.
//! A fall of more than DROP yd on the way is reported as a drop (a bridge or floor the player
//! crossed that the grid lacks shows as one).
//!
//!   cargo run --profile quick -p forge-nav --example trailfollow -- <grid> < walks.jsonl > follow.jsonl

use forge_nav::grid::{cell_of, flag, Grid, DIRS, FALL_SLIDE, FALL_SPAN, NO_LINK, TILE_CELLS};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::{json, Value};
use std::io::{BufRead, Write};
use std::path::Path;

const WIDTH: i64 = 1;
const AHEAD: usize = 6;
const DEPTH: usize = 40;
const RESEED: f64 = 10.0;
const DROP: f64 = 3.0;

type Node = (i64, i64, u32);

struct G<'a> {
	grid: &'a Grid,
	c: u32,
}

impl G<'_> {
	/// (z, ceil, flags, slope) of each surface of global column (gi, gj).
	fn column(&self, gi: i64, gj: i64) -> Vec<(f32, f32, u8, u8)> {
		let ts = TILE_CELLS as i64;
		let Some(t) = self.grid.tile(self.c, gi.div_euclid(ts), gj.div_euclid(ts)) else { return Vec::new() };
		let k = (gj.rem_euclid(ts) * ts + gi.rem_euclid(ts)) as usize;
		(t.first[k] as usize..t.first[k + 1] as usize).map(|e| (t.z[e], t.ceil[e], t.flags[e], t.slope[e])).collect()
	}

	/// The surfaces node n links, falls or rides to: (node, height of the fall when it is one).
	fn out(&self, n: Node) -> Vec<(Node, f64)> {
		let ts = TILE_CELLS as i64;
		let (gi, gj, l) = n;
		let Some(t) = self.grid.tile(self.c, gi.div_euclid(ts), gj.div_euclid(ts)) else { return Vec::new() };
		let k = (gj.rem_euclid(ts) * ts + gi.rem_euclid(ts)) as usize;
		let e = t.first[k] as usize + l as usize;
		if e >= t.first[k + 1] as usize || t.links.is_empty() {
			return Vec::new();
		}
		let mut v = Vec::new();
		for (d, dir) in DIRS.iter().enumerate() {
			let b = t.links[e * 8 + d];
			if b != NO_LINK {
				v.push(((gi + dir.0 as i64, gj + dir.1 as i64, u32::from(b & 31)), 0.0));
			}
		}
		if !t.fall_from.is_empty() {
			let at = t.fall_at();
			for f in at[e] as usize..at[e + 1] as usize {
				let code = t.fall_to[f];
				let off = (code >> 5) as i32;
				let di = off.div_euclid(FALL_SPAN) - FALL_SLIDE;
				let dj = off.rem_euclid(FALL_SPAN) - FALL_SLIDE;
				let to = (gi + di as i64, gj + dj as i64, u32::from(code & 31));
				let h = self.column(to.0, to.1).get(to.2 as usize).map_or(0.0, |s| f64::from(t.z[e]) - f64::from(s.0));
				v.push((to, h));
			}
		}
		if let Some(rides) = t.lifts.as_ref().and_then(|m| m.get(&(e as u32))) {
			for r in rides {
				let Some(t2) = self.grid.tile(self.c, r.col as i64, r.row as i64) else { continue };
				let (i2, j2) = ((r.k as usize & 255) as i64, (r.k as usize >> 8) as i64);
				v.push(((r.col as i64 * ts + i2, r.row as i64 * ts + j2, r.entry - t2.first[r.k as usize]), 0.0));
			}
		}
		v
	}
}

fn main() -> Result<(), String> {
	let dir = std::env::args().nth(1).ok_or("usage: trailfollow <grid> < walks.jsonl")?;
	let grid = Grid::open(Path::new(&dir), 640)?;
	let ts = TILE_CELLS as i64;
	let stdout = std::io::stdout();
	let mut out = stdout.lock();
	for line in std::io::stdin().lock().lines() {
		let line = line.map_err(|e| e.to_string())?;
		if line.trim().is_empty() {
			continue;
		}
		let q: Value = serde_json::from_str(&line).map_err(|e| e.to_string())?;
		let g = G { grid: &grid, c: q["map"].as_u64().unwrap_or(0) as u32 };
		let pts: Vec<(f64, f64)> = q["pts"].as_array().into_iter().flatten().map(|p| (p[0].as_f64().unwrap_or(0.0), p[1].as_f64().unwrap_or(0.0))).collect();
		// The line of columns, every yard.
		let mut cells: Vec<(i64, i64)> = Vec::new();
		let mut at: Vec<(f64, f64)> = Vec::new();
		let mut of_pt: Vec<usize> = vec![0; pts.len()];
		for (pi, w) in pts.windows(2).enumerate() {
			of_pt[pi] = cells.len().saturating_sub(1);
			let (a, b) = (w[0], w[1]);
			let n = ((b.0 - a.0).hypot(b.1 - a.1)).ceil().max(1.0) as usize;
			for s in 0..=n {
				let (x, y) = (a.0 + (b.0 - a.0) * s as f64 / n as f64, a.1 + (b.1 - a.1) * s as f64 / n as f64);
				let (col, row, i, j) = cell_of(x, y);
				let cell = (col * ts + i, row * ts + j);
				if cells.last() != Some(&cell) {
					cells.push(cell);
					at.push((x, y));
				}
			}
		}
		let near = |a: (i64, i64), b: (i64, i64), r: i64| (a.0 - b.0).abs() <= r && (a.1 - b.1).abs() <= r;
		let usable = |s: &(f32, f32, u8, u8)| s.2 & flag::BLOCKED == 0;
		let mut breaks = Vec::new();
		let mut drops = Vec::new();
		let mut zs: Vec<Option<f32>> = vec![None; cells.len()];
		let seed = |m: usize, zref: Option<&[f32]>| -> Vec<Node> {
			let col = g.column(cells[m].0, cells[m].1);
			(0..col.len() as u32)
				.filter(|&l| usable(&col[l as usize]) && zref.is_none_or(|zr| zr.iter().any(|z| (col[l as usize].0 - z).abs() as f64 <= RESEED)))
				.map(|l| (cells[m].0, cells[m].1, l))
				.collect()
		};
		let mut n = 0;
		let mut s: Vec<Node> = seed(0, None);
		while s.is_empty() && n + 1 < cells.len() {
			n += 1;
			s = seed(n, None);
		}
		while n + 1 < cells.len() {
			let hi = (n + AHEAD).min(cells.len() - 1);
			// Breadth-first through the links, inside the window along the line.
			let inside = |c: (i64, i64)| (n..=hi).any(|m| near(c, cells[m], WIDTH));
			let mut seen: FxHashMap<Node, (usize, f64)> = FxHashMap::default();
			let mut front: Vec<Node> = s.clone();
			for &x in &s {
				seen.insert(x, (0, 0.0));
			}
			for depth in 1..=DEPTH {
				let mut next = Vec::new();
				for &x in &front {
					let fall0 = seen[&x].1;
					for (y, h) in g.out(x) {
						if seen.contains_key(&y) || !inside((y.0, y.1)) {
							continue;
						}
						seen.insert(y, (depth, fall0.max(h)));
						next.push(y);
					}
				}
				if next.is_empty() {
					break;
				}
				front = next;
			}
			// The farthest column of the line reached.
			let mut best: Option<usize> = None;
			for m in (n + 1..=hi).rev() {
				if seen.keys().any(|y| (y.0, y.1) == cells[m]) {
					best = Some(m);
					break;
				}
			}
			let zof = |v: &[Node]| -> Vec<f32> { v.iter().filter_map(|x| g.column(x.0, x.1).get(x.2 as usize).map(|c| c.0)).collect() };
			match best {
				Some(m) => {
					let ns: Vec<Node> = seen.keys().filter(|y| (y.0, y.1) == cells[m]).copied().collect();
					let fall = ns.iter().map(|y| seen[y].1).fold(f64::INFINITY, f64::min);
					if fall > DROP {
						drops.push(json!({ "at": m, "wx": at[m].0, "wy": at[m].1, "h": (fall * 10.0).round() / 10.0 }));
					}
					let z = zof(&ns);
					zs[m] = z.iter().copied().fold(None, |a: Option<f32>, b| Some(a.map_or(b, |a| a.max(b))));
					s = ns;
					n = m;
				}
				None => {
					let zf = zof(&s);
					let nx = cells[n + 1];
					let desc = |c: &[(f32, f32, u8, u8)]| -> Value {
						c.iter().map(|x| json!([(x.0 * 10.0).round() / 10.0, if x.1.is_finite() { json!((x.1 * 10.0).round() / 10.0) } else { Value::Null }, x.2, x.3])).collect()
					};
					let here: FxHashSet<u32> = s.iter().filter(|x| (x.0, x.1) == cells[n]).map(|x| x.2).collect();
					breaks.push(json!({
						"at": n, "wx": (at[n].0 * 10.0).round() / 10.0, "wy": (at[n].1 * 10.0).round() / 10.0,
						"cell": [cells[n].0, cells[n].1], "next": [nx.0, nx.1],
						"z": zf, "layers": here.into_iter().collect::<Vec<_>>(),
						"here": desc(&g.column(cells[n].0, cells[n].1)), "there": desc(&g.column(nx.0, nx.1)),
					}));
					let mut m = n + 1;
					let mut ns = seed(m, Some(&zf));
					while ns.is_empty() && m + 1 < cells.len() {
						m += 1;
						ns = seed(m, Some(&zf));
					}
					if ns.is_empty() {
						break;
					}
					s = ns;
					n = m;
				}
			}
		}
		if let Some(l) = of_pt.last_mut() {
			*l = cells.len().saturating_sub(1);
		}
		// Each recorded position's height: the followed surface's at the nearest column reached (the
		// highest when several floors were still possible there).
		let known: Vec<usize> = (0..cells.len()).filter(|&m| zs[m].is_some()).collect();
		let pz: Vec<Value> = of_pt
			.iter()
			.map(|&m| {
				let i = known.partition_point(|&x| x < m);
				let best = [i.checked_sub(1), Some(i)].into_iter().flatten().filter_map(|i| known.get(i)).min_by_key(|&&x| x.abs_diff(m));
				best.and_then(|&x| zs[x]).map_or(Value::Null, |z| json!((z * 10.0).round() / 10.0))
			})
			.collect();
		writeln!(out, "{}", json!({ "id": q["id"], "cells": cells.len(), "breaks": breaks, "drops": drops, "pz": pz })).map_err(|e| e.to_string())?;
	}
	Ok(())
}
