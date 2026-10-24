//! Diffs bridge and ramp landings between two walking grids, row by row of a landing list
//! (data/local/research/BridgeSweep.tsv: map, wx, wy, z_top, z_landing, ...; each row a one-way
//! fall of the canonical grid over WMO faces the builder drops).
//!
//!   cargo run --release -p forge-devtools --bin landing_diff -- <list.tsv> <grid A> <grid B> [out.tsv]
//!
//! A row is *joined* in a grid when, walking only (links: no falls, no lifts, within 80 yd), the
//! top surface (the walkable entry of the row's column within 1.5 yd of z_top) reaches a landing
//! surface (a walkable entry within FALL_SLIDE columns and 1.5 yd of z_landing) and the nearest
//! such landing walks back to the top. Prints the counts (joined in A, in B, joined only in B,
//! only in A, top missing) and writes every row with its two states to out.tsv (default: stdout
//! gets only the summary).

use forge_navbuild::format::{cell_of, cls, decode_tile, flag, Tile, CELL, CODE_LIFT, FALL_SLIDE, TILE_CELLS};
use forge_navbuild::search::Space;
use rustc_hash::{FxHashMap, FxHashSet};
use std::io::Write;

const Z_TOL: f64 = 1.5;
const RADIUS: f64 = 80.0;

struct Grid {
	dir: String,
	tiles: FxHashMap<(u32, i32, i32), Option<Tile>>,
}

impl Grid {
	fn load(&mut self, c: u32, col: i32, row: i32) {
		if self.tiles.len() > 200 {
			self.tiles.clear();
		}
		let dir = &self.dir;
		self.tiles.entry((c, col, row)).or_insert_with(|| std::fs::read(format!("{dir}/tiles/{c}/{col}_{row}.nav.gz")).ok().and_then(|b| decode_tile(&b).ok()));
	}
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum State {
	Joined,
	OneWay,
	NoTop,
}

impl State {
	fn name(self) -> &'static str {
		match self {
			State::Joined => "joined",
			State::OneWay => "one-way",
			State::NoTop => "no-top",
		}
	}
}

/// Walking reach (links only, within RADIUS of the start) from `start` -> visited nodes.
fn reach(sp: &mut Space, start: i32, foot: &forge_navbuild::moves::Profile, stop: impl Fn(i32) -> bool) -> (FxHashSet<i32>, bool) {
	let s0 = sp.slot_of(start);
	let k0 = forge_navbuild::regions::column_of(&sp.tiles[s0].first, (start - sp.base[s0]) as u32);
	let (x0, y0) = (sp.wx(s0, k0), sp.wy(s0, k0));
	let mut seen = FxHashSet::default();
	seen.insert(start);
	let mut q = vec![start];
	while let Some(u) = q.pop() {
		if stop(u) {
			return (seen, true);
		}
		let sl = sp.slot_of(u);
		let e = (u - sp.base[sl]) as usize;
		let k = forge_navbuild::regions::column_of(&sp.tiles[sl].first, e as u32);
		sp.expand(sl, e, k, foot);
		for o in sp.out.clone() {
			if o.code == cls::FALL || o.code == CODE_LIFT {
				continue;
			}
			if (sp.wx(o.slot as usize, o.k as usize) - x0).hypot(sp.wy(o.slot as usize, o.k as usize) - y0) > RADIUS {
				continue;
			}
			if seen.insert(o.to) {
				q.push(o.to);
			}
		}
	}
	(seen, false)
}

fn state(g: &mut Grid, c: u32, wx: f64, wy: f64, z_top: f64, z_land: f64, foot: &forge_navbuild::moves::Profile) -> State {
	let (col, row, i, j) = cell_of(wx, wy);
	for dr in -1..=1 {
		for dc in -1..=1 {
			g.load(c, col + dc, row + dr);
		}
	}
	let keys: Vec<(i32, i32)> = (-1..=1).flat_map(|dr| (-1..=1).map(move |dc| (col + dc, row + dr))).filter(|k| matches!(g.tiles.get(&(c, k.0, k.1)), Some(Some(_)))).collect();
	let Some(ts) = keys.iter().position(|k| *k == (col, row)) else { return State::NoTop };
	let refs: Vec<&Tile> = keys.iter().map(|k| g.tiles[&(c, k.0, k.1)].as_ref().unwrap()).collect();
	let mut sp = Space::new(&refs);
	// The top surface.
	let t = refs[ts];
	let k = (j * TILE_CELLS as i32 + i) as usize;
	let top = (t.first[k] as usize..t.first[k + 1] as usize)
		.filter(|&e| t.flags[e] & flag::BLOCKED == 0 && (f64::from(t.z[e]) - z_top).abs() <= Z_TOL)
		.min_by(|&a, &b| (f64::from(t.z[a]) - z_top).abs().total_cmp(&(f64::from(t.z[b]) - z_top).abs()));
	let Some(top) = top else { return State::NoTop };
	let top_node = sp.base[ts] + top as i32;
	// Landing surfaces: walkable entries within FALL_SLIDE columns and Z_TOL of z_land.
	let mut landings: Vec<(f64, i32)> = Vec::new();
	let r = FALL_SLIDE as i32;
	let tc = TILE_CELLS as i32;
	let (gi, gj) = (col * tc + i, row * tc + j);
	for dj in -r..=r {
		for di in -r..=r {
			let (li, lj) = (gi + di, gj + dj);
			let (lc, lr) = (li.div_euclid(tc), lj.div_euclid(tc));
			let Some(s) = keys.iter().position(|kk| *kk == (lc, lr)) else { continue };
			let lt = refs[s];
			let lk = (lj.rem_euclid(tc) * tc + li.rem_euclid(tc)) as usize;
			for e in lt.first[lk] as usize..lt.first[lk + 1] as usize {
				if lt.flags[e] & flag::BLOCKED == 0 && (f64::from(lt.z[e]) - z_land).abs() <= Z_TOL {
					landings.push((f64::from(di * di + dj * dj).sqrt() * CELL, sp.base[s] + e as i32));
				}
			}
		}
	}
	if landings.is_empty() {
		return State::OneWay;
	}
	landings.sort_by(|a, b| a.0.total_cmp(&b.0));
	let (down, _) = reach(&mut sp, top_node, foot, |_| false);
	let Some(&(_, land)) = landings.iter().find(|l| down.contains(&l.1)) else { return State::OneWay };
	let (_, up) = reach(&mut sp, land, foot, |u| u == top_node);
	if up {
		State::Joined
	} else {
		State::OneWay
	}
}

fn main() {
	let a: Vec<String> = std::env::args().collect();
	if a.len() < 4 {
		eprintln!("usage: landing_diff <list.tsv> <grid A> <grid B> [out.tsv]");
		std::process::exit(2);
	}
	let text = std::fs::read_to_string(&a[1]).unwrap_or_else(|e| panic!("{}: {e}", a[1]));
	let mut lines = text.lines();
	let header: Vec<&str> = lines.next().unwrap_or("").split('\t').collect();
	let col = |n: &str| header.iter().position(|h| *h == n).unwrap_or_else(|| panic!("{}: no column {n}", a[1]));
	let (cm, cx, cy, ct, cl) = (col("map"), col("wx"), col("wy"), col("z_top"), col("z_landing"));
	let mut ga = Grid { dir: a[2].clone(), tiles: FxHashMap::default() };
	let mut gb = Grid { dir: a[3].clone(), tiles: FxHashMap::default() };
	let foot = forge_navbuild::moves::refs()[0].clone();
	let mut out: Box<dyn Write> = match a.get(4) {
		Some(p) => Box::new(std::io::BufWriter::new(std::fs::File::create(p).unwrap_or_else(|e| panic!("{p}: {e}")))),
		None => Box::new(std::io::sink()),
	};
	writeln!(out, "{}\tstate_a\tstate_b", header.join("\t")).unwrap();
	let (mut ja, mut jb, mut only_b, mut only_a, mut no_top, mut n) = (0, 0, 0, 0, 0, 0);
	for line in lines {
		let f: Vec<&str> = line.split('\t').collect();
		if f.len() < header.len() {
			continue;
		}
		let num = |i: usize| f[i].parse::<f64>().unwrap_or(f64::NAN);
		let c: u32 = f[cm].parse().unwrap_or(0);
		let sa = state(&mut ga, c, num(cx), num(cy), num(ct), num(cl), &foot);
		let sb = state(&mut gb, c, num(cx), num(cy), num(ct), num(cl), &foot);
		n += 1;
		ja += usize::from(sa == State::Joined);
		jb += usize::from(sb == State::Joined);
		only_b += usize::from(sb == State::Joined && sa != State::Joined);
		only_a += usize::from(sa == State::Joined && sb != State::Joined);
		no_top += usize::from(sa == State::NoTop || sb == State::NoTop);
		writeln!(out, "{line}\t{}\t{}", sa.name(), sb.name()).unwrap();
	}
	println!("{n} rows: joined in A {ja}, in B {jb}; joined only in B {only_b}, only in A {only_a}; top surface missing in A or B {no_top}");
}
