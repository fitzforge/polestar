//! A census of Leffe's navigation maps (format 4) for the in-game pack: per map, the floors, the motion arcs by what
//! the in-game engine could already express (a cell step or floor link it decodes from the grid), and the entrance
//! graph. Credit: Leffe's navigation maps and reader.
//!
//!   cargo run --profile quick -p forge-nav --example f4census -- <Leffe's Nav folder> [map...]

use forge_nav::f4::pack::{self, Assembly, Cluster, Meta, Span, WALK_TAN};
use forge_nav::f4::{NavDir, PackSource};
use rayon::prelude::*;
use rustc_hash::FxHashMap;
use std::io::Write;

const DX: [i64; 8] = [1, -1, 0, 0, 1, 1, -1, -1];
const DY: [i64; 8] = [0, 0, 1, -1, 1, -1, 1, -1];

/// What another cluster's arcs need of this one.
struct Slim {
	n: usize,
	owner: Vec<i32>,
	at_cell: Vec<i32>,
	first_floor: Vec<i32>,
	val: Vec<u8>,
	flags: Vec<u8>,
	z: Vec<f32>,
	geo: Vec<[f32; 3]>,
	link_off: Vec<u32>,
	link_val: Vec<u8>,
}

struct Arc {
	from: u32,
	dx: i8,
	dy: i8,
	to: u32,
	kind: u8,
	yards: f32,
	cost: [f32; 3],
}

#[derive(Default, Clone)]
struct GraphStats {
	rows: usize,
	port_rows: usize,
	edges: usize,
	inter: usize,
	jump_edges: usize,
	over63: usize,
	max_degree: usize,
	costs_equal: usize,
	oneway: usize,
}

fn read_field(src: &NavDir, meta: &Meta, field: &str, k: u32) -> Result<Option<Vec<u8>>, String> {
	let Some(spans) = meta.spans(field, k) else { return Ok(None) };
	let mut parts = Vec::new();
	for &Span { part, start, end } in spans {
		let buf = src.read(meta.map, part as usize, start, end)?;
		pack::inflate_blocks(&buf, &mut parts)?;
	}
	Ok(Some(parts.concat()))
}

fn slim(meta: &Meta, k: u32, c: &Cluster) -> Slim {
	let cc = meta.c;
	let ny = meta.ny;
	let geo = (0..c.n)
		.map(|node| {
			let s = c.spec_idx[node];
			if s >= 0 {
				let s = s as usize;
				return [c.spec_x[s] as f32, c.spec_y[s] as f32, c.spec_z[s]];
			}
			let o = if c.owner[node] >= 0 { c.owner[node] as usize } else { node };
			let lc = if o < (cc * cc) as usize { o as i64 } else { c.at_cell[o] as i64 };
			[(meta.x0 + ((k as i64 / ny * cc + lc / cc) as f64 + 0.5) * meta.cs) as f32, (meta.y0 + ((k as i64 % ny * cc + lc % cc) as f64 + 0.5) * meta.cs) as f32, c.z[o]]
		})
		.collect();
	Slim {
		n: c.n,
		owner: c.owner.clone(),
		at_cell: c.at_cell.clone(),
		first_floor: c.first_floor.clone(),
		val: c.val.clone(),
		flags: c.moves.iter().map(|m| m >> 4).collect(),
		z: c.z.clone(),
		geo,
		link_off: c.link_off.clone(),
		link_val: c.link_val.clone(),
	}
}

fn main() -> Result<(), String> {
	let mut args = std::env::args().skip(1);
	let dir = args.next().ok_or("usage: f4census <Leffe's Nav folder> [map...]")?;
	let want: Vec<u32> = args.filter_map(|a| a.parse().ok()).collect();
	let src = NavDir::open(std::path::Path::new(&dir))?;
	let stdout = std::io::stdout();
	let mut out = stdout.lock();
	for map in src.maps() {
		if !want.is_empty() && !want.contains(&map) {
			continue;
		}
		let t0 = std::time::Instant::now();
		let text = src.meta(map)?.ok_or("no meta")?;
		let mut meta = pack::parse_meta(&text, map)?;
		let mut asm = Assembly::default();
		for part in 0..src.parts(map) {
			let name = format!("Nav{map}_{}.lua", part + 1);
			let mut res = Ok(());
			src.with_part(map, part, &mut |bytes| res = pack::scan_part(bytes, part as u32, &mut meta.index, &mut asm, &name))?;
			res?;
		}
		let cc = meta.c as usize;
		let ncell = cc * cc;
		let mut keys: Vec<u32> = meta.index.get("graph").map(|m| m.keys().copied().collect()).unwrap_or_default();
		keys.sort_unstable();
		writeln!(out, "map {map}: {} clusters, index in {:.1}s", keys.len(), t0.elapsed().as_secs_f64()).ok();
		let meta = &meta;
		let src = &src;
		let decoded: Vec<(u32, Option<Slim>, Vec<Arc>, GraphStats, [usize; 4])> = keys
			.par_iter()
			.map(|&k| -> Result<_, String> {
				let mut read = |f: &str, k: u32| read_field(src, meta, f, k);
				let c = pack::decode_cluster(meta, k, &mut read)?;
				let g = if c.is_some() { pack::decode_graph(k, &mut read, c.as_ref())? } else { pack::Graph::default() };
				let mut gs = GraphStats { rows: g.rows, ..Default::default() };
				for r in 0..g.rows {
					if let Some(c) = &c {
						if g.row_node[r] as usize >= c.n0 {
							gs.port_rows += 1;
						}
					}
					let (lo, hi) = (g.row_out[r] as usize, g.row_out[r + 1] as usize);
					gs.max_degree = gs.max_degree.max(hi - lo);
					if hi - lo > 63 {
						gs.over63 += 1;
					}
					for e in lo..hi {
						gs.edges += 1;
						if g.e_dx[e] != 0 || g.e_dy[e] != 0 {
							gs.inter += 1;
						}
						if g.e_jumps[e] > 0 {
							gs.jump_edges += 1;
						}
						if g.e_cost[3 * e] == g.e_cost[3 * e + 1] && g.e_cost[3 * e + 1] == g.e_cost[3 * e + 2] {
							gs.costs_equal += 1;
						}
					}
				}
				let Some(c) = c else { return Ok((k, None, Vec::new(), gs, [0; 4])) };
				// [floors, ports, over-open orthogonal steps (open by flags, past the walk slope), refined nodes]
				let mut extra = [c.n0 - ncell, c.n - c.n0, 0, c.over_kind.iter().filter(|&&o| o >= 0).count()];
				let straight = (meta.cs * WALK_TAN) as f32;
				for a in 0..ncell {
					if c.val[a] == 0 {
						continue;
					}
					let f = c.moves[a] >> 4;
					if a + cc < ncell && c.val[a + cc] != 0 && f % 2 == 0 && (c.z[a + cc] - c.z[a]).abs() > straight {
						extra[2] += 1;
					}
					if a % cc < cc - 1 && c.val[a + 1] != 0 && f % 4 < 2 && (c.z[a + 1] - c.z[a]).abs() > straight {
						extra[2] += 1;
					}
				}
				let arcs = (0..c.a_from.len())
					.map(|a| Arc {
						from: c.a_from[a],
						dx: c.a_dx[a],
						dy: c.a_dy[a],
						to: c.a_to[a],
						kind: c.a_kind[a],
						yards: c.a_yards[a],
						cost: [c.a_cost[3 * a], c.a_cost[3 * a + 1], c.a_cost[3 * a + 2]],
					})
					.collect();
				Ok((k, Some(slim(meta, k, &c)), arcs, gs, extra))
			})
			.collect::<Result<_, String>>()?;
		let mut slims: FxHashMap<u32, Slim> = FxHashMap::default();
		let mut all_arcs: Vec<(u32, Vec<Arc>)> = Vec::new();
		let mut gs = GraphStats::default();
		let mut ex = [0usize; 4];
		for (k, s, arcs, g, e) in decoded {
			gs.rows += g.rows;
			gs.port_rows += g.port_rows;
			gs.edges += g.edges;
			gs.inter += g.inter;
			gs.jump_edges += g.jump_edges;
			gs.over63 += g.over63;
			gs.max_degree = gs.max_degree.max(g.max_degree);
			gs.costs_equal += g.costs_equal;
			gs.oneway += g.oneway;
			for i in 0..4 {
				ex[i] += e[i];
			}
			if let Some(s) = s {
				slims.insert(k, s);
			}
			all_arcs.push((k, arcs));
		}
		writeln!(out, "  decoded in {:.1}s; floors {} ports {} over-open steps {} refined nodes {}", t0.elapsed().as_secs_f64(), ex[0], ex[1], ex[2], ex[3]).ok();
		writeln!(
			out,
			"  graph: rows {} (on ports {}), edges {} (inter {}), with jumps {}, rows over 63 edges {}, max degree {}, costs equal in all slots {}",
			gs.rows, gs.port_rows, gs.edges, gs.inter, gs.jump_edges, gs.over63, gs.max_degree, gs.costs_equal
		)
		.ok();
		let ny = meta.ny;
		let owner_of = |s: &Slim, node: u32| -> u32 {
			if s.owner[node as usize] >= 0 {
				s.owner[node as usize] as u32
			} else {
				node
			}
		};
		let cell_of = |s: &Slim, o: u32| -> i64 {
			if (o as usize) < ncell {
				o as i64
			} else {
				s.at_cell[o as usize] as i64
			}
		};
		let gcell = |k: u32, lc: i64| -> (i64, i64) { (k as i64 / ny * cc as i64 + lc / cc as i64, k as i64 % ny * cc as i64 + lc % cc as i64) };
		// The in-game engine's surface for a link layer (0 base, i the ith floor, -1 nearest h).
		let surface = |s: &Slim, lc: i64, layer: i64, h: f32| -> i64 {
			let first = s.first_floor[lc as usize] as i64;
			if layer == 0 {
				return if s.val[lc as usize] != 0 { lc } else { -1 };
			}
			if layer > 0 {
				let node = first + layer - 1;
				return if first >= 0 && (node as usize) < s.n && s.at_cell[node as usize] as i64 == lc { node } else { -1 };
			}
			let (mut best, mut gap) = (-1i64, f32::INFINITY);
			if s.val[lc as usize] != 0 {
				best = lc;
				gap = (s.z[lc as usize] - h).abs();
			}
			let mut node = first;
			while node >= 0 && (node as usize) < s.n && s.at_cell[node as usize] as i64 == lc {
				let d = (s.z[node as usize] - h).abs();
				if d < gap {
					best = node;
					gap = d;
				}
				node += 1;
			}
			best
		};
		let at_global = |gx: i64, gy: i64| -> Option<(u32, i64)> {
			if gx < 0 || gy < 0 || gx >= meta.gx || gy >= meta.gy {
				return None;
			}
			let k = (gx / cc as i64 * ny + gy / cc as i64) as u32;
			Some((k, (gx % cc as i64) * cc as i64 + gy % cc as i64))
		};
		// Can the in-game engine step from (ka, a) to (kb, b), adjacent cells, from the grid and floor links alone?
		let step = |ka: u32, a: u32, kb: u32, b: u32| -> bool {
			let (sa, sb) = (&slims[&ka], &slims[&kb]);
			let (ax, ay) = gcell(ka, cell_of(sa, a));
			let (bx, by) = gcell(kb, cell_of(sb, b));
			let (dx, dy) = (bx - ax, by - ay);
			let Some(d) = (0..8).find(|&d| DX[d] == dx && DY[d] == dy) else { return false };
			if (a as usize) < ncell && (b as usize) < ncell {
				let open = |x: i64, y: i64, ox: i64, oy: i64| -> bool {
					// the orthogonal step from (x, y) by (ox, oy): the lower cell's flags close it
					let (lx, ly) = if ox < 0 || oy < 0 { (x + ox, y + oy) } else { (x, y) };
					let (Some((k1, l1)), Some((k2, l2))) = (at_global(lx, ly), at_global(lx + (ox != 0) as i64, ly + (oy != 0) as i64)) else { return false };
					let (Some(s1), Some(s2)) = (slims.get(&k1), slims.get(&k2)) else { return false };
					if s1.val[l1 as usize] == 0 || s2.val[l2 as usize] == 0 {
						return false;
					}
					let f = s1.flags[l1 as usize];
					if ox != 0 {
						f % 2 == 0
					} else {
						f % 4 < 2
					}
				};
				if dx == 0 || dy == 0 {
					return open(ax, ay, dx, dy);
				}
				if (open(ax, ay, dx, 0) && open(ax + dx, ay, 0, dy)) || (open(ax, ay, 0, dy) && open(ax, ay + dy, dx, 0)) {
					return true;
				}
				let (lx, ly, up) = if dx < 0 { (ax + dx, ay + dy, dy < 0) } else { (ax, ay, dy > 0) };
				let Some((k1, l1)) = at_global(lx, ly) else { return false };
				let f = slims.get(&k1).map_or(0, |s| s.flags[l1 as usize]);
				return if up { f % 8 >= 4 } else { f >= 8 };
			}
			// a floor link from a, or (the decoder's reverse) from b back to a
			let linked = |s: &Slim, ks: u32, from: u32, d: usize, kt: u32, to: u32| -> bool {
				let st = &slims[&kt];
				let (lo, hi) = (s.link_off[from as usize] as usize, s.link_off[from as usize + 1] as usize);
				let (fx, fy) = gcell(ks, cell_of(s, from));
				let Some((_, tlc)) = at_global(fx + DX[d], fy + DY[d]) else { return false };
				(lo..hi).any(|e| {
					let l = s.link_val[e];
					l as usize % 8 == d && surface(st, tlc, (l / 8) as i64 - 1, s.z[from as usize]) == to as i64
				})
			};
			let back = [1, 0, 3, 2, 7, 6, 5, 4][d];
			linked(sa, ka, a, d, kb, b) || linked(sb, kb, b, back, ka, a)
		};
		// kinds: jump, drop, climb, self, derivable, same cell other surface, adjacent not derivable, farther
		let mut counts = [0usize; 8];
		let mut span = [0usize; 6];
		let mut kept_bytes = 0usize;
		let mut kept_n = 0usize;
		let mut cost_ratio = Vec::new();
		for (k, arcs) in &all_arcs {
			let Some(s) = slims.get(k) else { continue };
			let mut buf: Vec<u8> = Vec::new();
			let mut prev = 0u32;
			for a in arcs {
				let q = (((*k as i64 / ny) + a.dx as i64) * ny + (*k as i64 % ny) + a.dy as i64) as u32;
				let Some(t) = slims.get(&q) else { continue };
				let fo = owner_of(s, a.from);
				let to = owner_of(t, a.to);
				let ga = s.geo[a.from as usize];
				let gb = t.geo[a.to as usize];
				let h = ((gb[0] - ga[0]).powi(2) + (gb[1] - ga[1]).powi(2)).sqrt() as f64;
				let dz = (gb[2] - ga[2]) as f64;
				let slope = h * WALK_TAN + 1e-12;
				let (ax, ay) = gcell(*k, cell_of(s, fo));
				let (bx, by) = gcell(q, cell_of(t, to));
				let sp = (bx - ax).abs().max((by - ay).abs()) as usize;
				let class = if a.kind == 1 {
					0
				} else if dz < -slope {
					1
				} else if dz > slope {
					2
				} else if *k == q && fo == to {
					3
				} else if sp == 1 && step(*k, fo, q, to) {
					4
				} else if sp == 0 {
					5
				} else if sp == 1 {
					6
				} else {
					7
				};
				counts[class] += 1;
				if class != 3 && class != 4 {
					span[sp.min(5)] += 1;
					kept_n += 1;
					let fo_d = fo.wrapping_sub(prev);
					prev = fo;
					for v in [fo_d, ((a.dx + 1) * 3 + a.dy + 1) as u32 * 2 + a.kind as u32, to, (a.yards * 4.0).round() as u32, (a.cost[2] * 4.0).round() as u32] {
						let mut v = v;
						loop {
							let b = (v & 127) as u8;
							v >>= 7;
							if v == 0 {
								buf.push(b);
								break;
							}
							buf.push(b | 128);
						}
					}
					if a.yards > 0.0 {
						cost_ratio.push(a.cost[2] / a.yards);
					}
				}
			}
			if !buf.is_empty() {
				let mut z = flate2::write::ZlibEncoder::new(Vec::new(), flate2::Compression::best());
				z.write_all(&buf).unwrap();
				kept_bytes += z.finish().unwrap().len();
			}
		}
		writeln!(
			out,
			"  arcs: jump {} drop {} climb {} self {} derivable {} same-cell {} adjacent-not-derivable {} farther {}",
			counts[0], counts[1], counts[2], counts[3], counts[4], counts[5], counts[6], counts[7]
		)
		.ok();
		writeln!(out, "  kept arcs {kept_n}: span in cells 0..5+ {:?}; zlib {:.2} MB", span, kept_bytes as f64 / 1e6).ok();
		cost_ratio.sort_by(|a, b| a.partial_cmp(b).unwrap());
		if !cost_ratio.is_empty() {
			let q = |p: f64| cost_ratio[((cost_ratio.len() - 1) as f64 * p) as usize];
			writeln!(out, "  kept cost/yard p10 {:.2} p50 {:.2} p90 {:.2}", q(0.1), q(0.5), q(0.9)).ok();
		}
		writeln!(out, "  done in {:.1}s", t0.elapsed().as_secs_f64()).ok();
		out.flush().ok();
	}
	Ok(())
}
