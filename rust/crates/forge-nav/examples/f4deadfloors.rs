//! How many of Leffe's floors no walk can use (an estimate for condensing the in-game maps): a floor with no step or
//! link out of it that no surface of its cluster links into and no jump, drop or entrance names. Credit: Leffe's
//! navigation maps.
//!
//!   cargo run --profile quick -p forge-nav --example f4deadfloors -- <Leffe's Nav folder> [map...]

use forge_nav::f4::pack::{self, Assembly, Meta, Span, DX, DY};
use forge_nav::f4::{NavDir, PackSource};
use rayon::prelude::*;

fn read_field(src: &NavDir, meta: &Meta, field: &str, k: u32) -> Result<Option<Vec<u8>>, String> {
	let Some(spans) = meta.spans(field, k) else { return Ok(None) };
	let mut parts = Vec::new();
	for &Span { part, start, end } in spans {
		let buf = src.read(meta.map, part as usize, start, end)?;
		pack::inflate_blocks(&buf, &mut parts)?;
	}
	Ok(Some(parts.concat()))
}

fn main() -> Result<(), String> {
	let mut args = std::env::args().skip(1);
	let dir = args.next().ok_or("usage: f4deadfloors <Nav folder> [map...]")?;
	let want: Vec<u32> = args.filter_map(|a| a.parse().ok()).collect();
	let src = NavDir::open(std::path::Path::new(&dir))?;
	for map in src.maps() {
		if !want.is_empty() && !want.contains(&map) {
			continue;
		}
		let mut meta = pack::parse_meta(&src.meta(map)?.ok_or("meta")?, map)?;
		let mut asm = Assembly::default();
		for part in 0..src.parts(map) {
			let mut res = Ok(());
			src.with_part(map, part, &mut |b| res = pack::scan_part(b, part as u32, &mut meta.index, &mut asm, "part"))?;
			res?;
		}
		let mut keys: Vec<u32> = meta.index.get("grid").map(|m| m.keys().copied().collect()).unwrap_or_default();
		keys.sort_unstable();
		let (meta, src) = (&meta, &src);
		let c2 = (meta.c * meta.c) as usize;
		let cc = meta.c;
		let counts: Vec<[usize; 4]> = keys
			.par_iter()
			.map(|&k| -> Result<[usize; 4], String> {
				let mut read = |f: &str, k: u32| read_field(src, meta, f, k);
				let Some(c) = pack::decode_cluster(meta, k, &mut read)? else { return Ok([0; 4]) };
				let g = pack::decode_graph(k, &mut read, Some(&c))?;
				let mut used = vec![false; c.n0];
				let owner = |n: usize| if c.owner[n] >= 0 { c.owner[n] as usize } else { n };
				for r in 0..g.rows {
					used[owner(g.row_node[r] as usize)] = true;
				}
				for a in 0..c.a_from.len() {
					let o = owner(c.a_from[a] as usize);
					if o < c.n0 {
						used[o] = true;
					}
					if c.a_dx[a] == 0 && c.a_dy[a] == 0 {
						let o = owner(c.a_to[a] as usize);
						if o < c.n0 {
							used[o] = true;
						}
					}
				}
				// Links into a floor of this cluster (the router's surface(): layer 0 base, i the ith floor, -1 nearest).
				for u in 0..c.n0 {
					let lc = if u < c2 { u as i64 } else { c.at_cell[u] as i64 };
					for e in c.link_off[u] as usize..c.link_off[u + 1] as usize {
						let l = c.link_val[e] as usize;
						let (tx, ty) = (lc / cc + DX[l % 8], lc % cc + DY[l % 8]);
						if tx < 0 || ty < 0 || tx >= cc || ty >= cc {
							continue;
						}
						let t = (tx * cc + ty) as usize;
						let layer = (l / 8) as i64 - 1;
						let first = c.first_floor[t] as i64;
						let target = if layer == 0 {
							None
						} else if layer > 0 {
							(first >= 0).then(|| (first + layer - 1) as usize)
						} else {
							let h = c.z[u];
							let mut best = (if c.val[t] != 0 { Some(t) } else { None }, if c.val[t] != 0 { (c.z[t] - h).abs() } else { f32::INFINITY });
							let mut f = first;
							while f >= 0 && (f as usize) < c.n0 && c.at_cell[f as usize] as usize == t {
								let d = (c.z[f as usize] - h).abs();
								if d < best.1 {
									best = (Some(f as usize), d);
								}
								f += 1;
							}
							best.0
						};
						if let Some(t) = target.filter(|&t| t >= c2 && t < c.n0) {
							used[t] = true;
						}
					}
				}
				let mut n = [c.n0 - c2, 0, 0, 0];
				for f in c2..c.n0 {
					let out = c.link_off[f + 1] > c.link_off[f];
					if !out {
						n[1] += 1;
					}
					if !out && !used[f] {
						n[2] += 1;
					}
					if !used[f] {
						n[3] += 1;
					}
				}
				Ok(n)
			})
			.collect::<Result<_, String>>()?;
		let s = counts.iter().fold([0usize; 4], |a, b| [a[0] + b[0], a[1] + b[1], a[2] + b[2], a[3] + b[3]]);
		println!("map {map}: floors {}, no link out {}, no link out and none in (cluster) nor jump/entrance {} ({:.1} %), none in {}", s[0], s[1], s[2], 100.0 * s[2] as f64 / s[0] as f64, s[3]);
	}
	Ok(())
}
