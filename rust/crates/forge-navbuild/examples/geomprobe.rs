//! Which WMO groups' faces lie under a world point: for each WMO placed on the point's ADT tile
//! whose box holds it, each group's triangles within `radius` yd (xy) of the point, with their
//! MOPY flags (collision 0x08, render 0x20, detail 0x04), whether the builder keeps them
//! (collision, or render without detail), their height at the point and slope. For choosing
//! walkways.json entries (`groups`, `landings`).
//!
//!   cargo run --release -p forge-navbuild --example geomprobe -- <wow dir> <defs dir> <c> <wx> <wy> [radius] [zlo] [zhi]

use forge_navbuild::geom::{self, parse, Source};

fn u16le(b: &[u8], o: usize) -> u16 {
	u16::from_le_bytes([b[o], b[o + 1]])
}
fn u32le(b: &[u8], o: usize) -> u32 {
	u32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}
fn f32le(b: &[u8], o: usize) -> f32 {
	f32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}

fn main() -> Result<(), String> {
	let a: Vec<String> = std::env::args().collect();
	if a.len() < 6 {
		return Err("usage: geomprobe <wow dir> <defs dir> <c> <wx> <wy> [radius] [zlo] [zhi]".into());
	}
	let wow = std::path::PathBuf::from(&a[1]);
	let defs = std::path::PathBuf::from(&a[2]);
	let c: u32 = a[3].parse().map_err(|e| format!("c: {e}"))?;
	let (wx, wy): (f64, f64) = (a[4].parse().map_err(|e| format!("wx: {e}"))?, a[5].parse().map_err(|e| format!("wy: {e}"))?);
	let radius: f64 = a.get(6).map_or(Ok(1.5), |v| v.parse()).map_err(|e| format!("radius: {e}"))?;
	let zlo: f64 = a.get(7).map_or(Ok(f64::NEG_INFINITY), |v| v.parse()).map_err(|e| format!("zlo: {e}"))?;
	let zhi: f64 = a.get(8).map_or(Ok(f64::INFINITY), |v| v.parse()).map_err(|e| format!("zhi: {e}"))?;
	let product = "wow_classic_beta";
	let client = forge_gamedata::Client::open(&wow, product, &defs)?;
	let tables = geom::Tables::from_csv(|name| {
		let t = client.table(name, "enUS")?;
		String::from_utf8(forge_gamedata::csv::write_table(&t)).map_err(|e| format!("{name}: {e}"))
	})?;
	let src = geom::ClientSource::open(&wow, product)?;
	let (col, row, _, _) = forge_navbuild::format::cell_of(wx, wy);
	let tiles = geom::continent_tiles(&src, &tables, c)?;
	let tile = tiles.iter().find(|t| t.col == col && t.row == row).ok_or_else(|| format!("no tile {col}_{row}"))?;
	let obj = src.get(tile.obj0)?.ok_or("no obj0")?;
	let (_, wmos) = parse::parse_placements(&parse::chunks(&obj, 0)?)?;
	for p in &wmos {
		let e = p.extents;
		if wx < e[0] - radius || wx > e[3] + radius || wy < e[1] - radius || wy > e[4] + radius {
			continue;
		}
		let Some(root) = src.get(p.fdid)? else { continue };
		let list = parse::chunks(&root, 0)?;
		let mohd = parse::chunk(&list, b"MOHD").ok_or("no MOHD")?;
		let n = u32le(mohd, 4) as usize;
		let gfid = parse::chunk(&list, b"GFID").ok_or("no GFID")?;
		let names = parse::chunk(&list, b"MOGN");
		let m = parse::placement_matrix(p);
		println!("WMO {} uid {} at {:.1},{:.1},{:.1} scale {}", p.fdid, p.unique_id, p.pos[0], p.pos[1], p.pos[2], p.scale);
		for g in 0..n {
			let gf = u32le(gfid, g * 4);
			let Some(gb) = src.get(gf)? else { continue };
			let top = parse::chunks(&gb, 0)?;
			let Some(mogp) = parse::chunk(&top, b"MOGP") else { continue };
			let name_ofs = u32le(mogp, 0) as usize;
			let gflags = u32le(mogp, 8);
			let name = names
				.filter(|nm| name_ofs < nm.len())
				.map(|nm| {
					let end = nm[name_ofs..].iter().position(|&b| b == 0).map_or(nm.len(), |q| name_ofs + q);
					String::from_utf8_lossy(&nm[name_ofs..end]).into_owned()
				})
				.unwrap_or_default();
			let sub = parse::chunks(mogp, 0x44)?;
			let poly: Vec<u32> = if let Some(m) = parse::chunk(&sub, b"MPY2") {
				(0..m.len() / 4).map(|i| u32::from(u16le(m, i * 4))).collect()
			} else if let Some(m) = parse::chunk(&sub, b"MOPY") {
				(0..m.len() / 2).map(|i| u32::from(m[i * 2])).collect()
			} else {
				continue;
			};
			let Some(movt) = parse::chunk(&sub, b"MOVT") else { continue };
			let idx: Vec<u32> = if let Some(movx) = parse::chunk(&sub, b"MOVX") {
				(0..movx.len() / 4).map(|i| u32le(movx, i * 4)).collect()
			} else if let Some(movi) = parse::chunk(&sub, b"MOVI") {
				(0..movi.len() / 2).map(|i| u32::from(u16le(movi, i * 2))).collect()
			} else {
				continue;
			};
			let verts: Vec<f32> = (0..movt.len() / 4).map(|i| f32le(movt, i * 4)).collect();
			let w = parse::transform_points(&m, &verts);
			let mut hits = Vec::new();
			for t in 0..idx.len() / 3 {
				let f = poly[t];
				let v = |k: usize| {
					let i = idx[t * 3 + k] as usize * 3;
					[f64::from(w[i]), f64::from(w[i + 1]), f64::from(w[i + 2])]
				};
				let (p0, p1, p2) = (v(0), v(1), v(2));
				// Height at (wx, wy) on the triangle's plane, when the point is within radius of it.
				let minx = p0[0].min(p1[0]).min(p2[0]);
				let maxx = p0[0].max(p1[0]).max(p2[0]);
				let miny = p0[1].min(p1[1]).min(p2[1]);
				let maxy = p0[1].max(p1[1]).max(p2[1]);
				if wx < minx - radius || wx > maxx + radius || wy < miny - radius || wy > maxy + radius {
					continue;
				}
				let u = [p1[0] - p0[0], p1[1] - p0[1], p1[2] - p0[2]];
				let q = [p2[0] - p0[0], p2[1] - p0[1], p2[2] - p0[2]];
				let nrm = [u[1] * q[2] - u[2] * q[1], u[2] * q[0] - u[0] * q[2], u[0] * q[1] - u[1] * q[0]];
				let len = (nrm[0] * nrm[0] + nrm[1] * nrm[1] + nrm[2] * nrm[2]).sqrt();
				if len == 0.0 {
					continue;
				}
				let slope = (nrm[2].abs() / len).acos().to_degrees();
				let z = if nrm[2].abs() > 1e-6 { p0[2] - (nrm[0] * (wx - p0[0]) + nrm[1] * (wy - p0[1])) / nrm[2] } else { (p0[2] + p1[2] + p2[2]) / 3.0 };
				let zr = [p0[2].min(p1[2]).min(p2[2]), p0[2].max(p1[2]).max(p2[2])];
				if zr[1] < zlo || zr[0] > zhi {
					continue;
				}
				let kept = f & 0x08 != 0 || (f & 0x20 != 0 && f & 0x04 == 0);
				hits.push(format!("    tri {t}: flags {f:#04x} {} z@pt {z:.1} (z {:.1}..{:.1}) slope {slope:.0}", if kept { "kept" } else { "DROPPED" }, zr[0], zr[1]));
			}
			if !hits.is_empty() {
				println!("  group {g} '{name}' fdid {gf} flags {gflags:#x}: {} faces", hits.len());
				for h in hits {
					println!("{h}");
				}
			}
		}
	}
	Ok(())
}
