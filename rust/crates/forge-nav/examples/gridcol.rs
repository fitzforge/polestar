//! The grid's surfaces in the columns around a point, with their links: what a walk can stand on
//! there and where it can step.
//!
//!   cargo run --profile quick -p forge-nav --example gridcol -- <grid> <map> <wx> <wy> [radius columns, default 1] [zlo zhi]
//!
//! One line per surface: column (gi, gj: the global column), layer, z, gap above it, flags (T
//! terrain, W WMO, M M2, I indoor, S swim, O ocean, ^ steep, X blocked), slope in degrees, its region
//! and the region's size (surfaces),
//! and each direction's link (E, SE, S, SW, W, NW, N, NE in grid order: the class
//! letter w walk, s steep, ~ swim, j jump, i indoor, c climb, / slope, and the layer it reaches).

use forge_nav::grid::{cell_of, flag, Grid, NO_LINK, TILE_CELLS};
use std::path::Path;

fn main() -> Result<(), String> {
	let a: Vec<String> = std::env::args().skip(1).collect();
	if a.len() < 4 {
		return Err("usage: gridcol <grid> <map> <wx> <wy> [radius] [zlo zhi]".into());
	}
	let grid = Grid::open(Path::new(&a[0]), 64)?;
	let c: u32 = a[1].parse().map_err(|_| "map")?;
	let (wx, wy): (f64, f64) = (a[2].parse().map_err(|_| "wx")?, a[3].parse().map_err(|_| "wy")?);
	let r: i64 = a.get(4).and_then(|v| v.parse().ok()).unwrap_or(1);
	let zlo: f32 = a.get(5).and_then(|v| v.parse().ok()).unwrap_or(f32::NEG_INFINITY);
	let zhi: f32 = a.get(6).and_then(|v| v.parse().ok()).unwrap_or(f32::INFINITY);
	let ts = TILE_CELLS as i64;
	let (col, row, i, j) = cell_of(wx, wy);
	let (gi0, gj0) = (col * ts + i, row * ts + j);
	let names = ["E", "SE", "S", "SW", "W", "NW", "N", "NE"];
	let cls = ['w', 's', '~', 'j', 'f', 'i', 'c', '/'];
	for gj in gj0 - r..=gj0 + r {
		for gi in gi0 - r..=gi0 + r {
			let Some(t) = grid.tile(c, gi.div_euclid(ts), gj.div_euclid(ts)) else { continue };
			let k = (gj.rem_euclid(ts) * ts + gi.rem_euclid(ts)) as usize;
			let (cx, cy) = (t.wx(k), t.wy(k));
			for e in t.first[k] as usize..t.first[k + 1] as usize {
				if t.z[e] < zlo || t.z[e] > zhi {
					continue;
				}
				let f = t.flags[e];
				let fl: String = [(flag::TERRAIN, 'T'), (flag::WMO, 'W'), (flag::M2, 'M'), (flag::INDOOR, 'I'), (flag::SWIM, 'S'), (flag::OCEAN, 'O'), (flag::STEEP, '^'), (flag::BLOCKED, 'X')]
					.iter()
					.filter(|x| f & x.0 != 0)
					.map(|x| x.1)
					.collect();
				let links: Vec<String> = (0..8)
					.map(|d| {
						let b = if t.links.is_empty() { NO_LINK } else { t.links[e * 8 + d] };
						if b == NO_LINK {
							format!("{}:-", names[d])
						} else {
							format!("{}:{}{}", names[d], cls[(b >> 5) as usize], b & 31)
						}
					})
					.collect();
				println!(
					"({gi},{gj}) [{:.1},{:.1}] L{} z {:.2} gap {:.2} {fl} slope {} region {:?} ({:?}) | {}",
					cx,
					cy,
					e - t.first[k] as usize,
					t.z[e],
					t.ceil[e] - t.z[e],
					t.slope[e],
					grid.region(c, t.col, t.row, e as u32),
					grid.region_size(c, t.col, t.row, e as u32),
					links.join(" ")
				);
			}
		}
	}
	Ok(())
}
