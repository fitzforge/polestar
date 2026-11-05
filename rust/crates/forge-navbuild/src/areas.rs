//! The area of each walkable surface (Rust only): the WMOAreaTable row ID of the WMO group whose
//! floor it is (geom::Tables::wmo_area, Geometry::tri_area; the client's subzone there is that row's
//! AreaName, else its AreaTableID's name), 0 for terrain, M2s and groups without one. Written beside the tile as `<col>_<row>.area.gz`, a u32 (little endian) per
//! tile entry in entry order; the walking maps carry it per floor (tools/lib/nav/pack.js `area`), so
//! the addon can tell a city's levels apart by the client's subzone (the Undercity's Canals, Trade
//! Quarter and the Ruins' hall above them).
//!
//! An entry takes the group of the WMO triangle under its column's centre whose height there is
//! nearest the entry's (within AREA_DZ); a triangle's plane is evaluated at the centre when the
//! centre lies within half a column of it (a floor's edge column).

use crate::format::{cell_centre, cell_of, Tile, CELL, TILE_CELLS};
use crate::geom::Geometry;

/// yd between a surface's height and the triangle that gives it its area.
pub const AREA_DZ: f64 = 0.6;

/// Per entry of `tile` (built from `geom`) its area; all 0 when the geometry has none.
pub fn surface_areas(geom: &Geometry, tile: &Tile) -> Vec<u32> {
	let mut out = vec![0u32; tile.n];
	if geom.tri_area.iter().all(|&a| a == 0) {
		return out;
	}
	let tc = TILE_CELLS as i32;
	// Best (|dz|) so far per entry.
	let mut best = vec![f64::INFINITY; tile.n];
	let half = CELL / 2.0;
	for (t, &area) in geom.tri_area.iter().enumerate() {
		if area == 0 {
			continue;
		}
		let v = &geom.tris[t * 9..t * 9 + 9];
		let p = |k: usize| [f64::from(v[k * 3]), f64::from(v[k * 3 + 1]), f64::from(v[k * 3 + 2])];
		let (a, b, c) = (p(0), p(1), p(2));
		let u = [b[0] - a[0], b[1] - a[1], b[2] - a[2]];
		let w = [c[0] - a[0], c[1] - a[1], c[2] - a[2]];
		let nz = u[0] * w[1] - u[1] * w[0];
		if nz.abs() < 1e-9 {
			continue; // upright: no floor
		}
		let nx = u[1] * w[2] - u[2] * w[1];
		let ny = u[2] * w[0] - u[0] * w[2];
		let (minx, maxx) = (a[0].min(b[0]).min(c[0]) - half, a[0].max(b[0]).max(c[0]) + half);
		let (miny, maxy) = (a[1].min(b[1]).min(c[1]) - half, a[1].max(b[1]).max(c[1]) + half);
		// Columns of this tile whose centre lies in the box: i east (wy decreasing), j south (wx decreasing).
		let (c0, r0, i_hi, j_hi) = cell_of(minx, miny);
		let (c1, r1, i_lo, j_lo) = cell_of(maxx, maxy);
		let gi = |col: i32, i: i32| col * tc + i;
		let (gi_lo, gi_hi) = (gi(c1, i_lo), gi(c0, i_hi));
		let (gj_lo, gj_hi) = (gi(r1, j_lo), gi(r0, j_hi));
		let (ti0, tj0) = (tile.col * tc, tile.row * tc);
		for gj in gj_lo.max(tj0)..=gj_hi.min(tj0 + tc - 1) {
			for gix in gi_lo.max(ti0)..=gi_hi.min(ti0 + tc - 1) {
				let (i, j) = (gix - ti0, gj - tj0);
				let (cx, cy) = cell_centre(tile.col, tile.row, i, j);
				if cx < minx || cx > maxx || cy < miny || cy > maxy || !near_triangle(a, b, c, cx, cy, half) {
					continue;
				}
				let z = a[2] - (nx * (cx - a[0]) + ny * (cy - a[1])) / nz;
				let k = (j * tc + i) as usize;
				for e in tile.first[k] as usize..tile.first[k + 1] as usize {
					let dz = (f64::from(tile.z[e]) - z).abs();
					if dz <= AREA_DZ && dz < best[e] {
						best[e] = dz;
						out[e] = area;
					}
				}
			}
		}
	}
	out
}

/// Is (x, y) inside triangle abc (xy), or within `pad` of it?
fn near_triangle(a: [f64; 3], b: [f64; 3], c: [f64; 3], x: f64, y: f64, pad: f64) -> bool {
	let edge = |p: [f64; 3], q: [f64; 3]| {
		let (ex, ey) = (q[0] - p[0], q[1] - p[1]);
		let len = (ex * ex + ey * ey).sqrt().max(1e-9);
		((x - p[0]) * ey - (y - p[1]) * ex) / len
	};
	let (d0, d1, d2) = (edge(a, b), edge(b, c), edge(c, a));
	// Inside (or within pad) whatever the winding: every signed distance on one side, up to pad.
	(d0 <= pad && d1 <= pad && d2 <= pad) || (d0 >= -pad && d1 >= -pad && d2 >= -pad)
}

/// The grid's `areas.json`: { "<row id>": [name, AreaTableID], ... } of every WMOAreaTable row (the
/// names the sidecars' ids stand for), or None when the client gave no WMOAreaTable.
pub fn areas_json(tables: &crate::geom::Tables) -> Option<String> {
	let rows = tables.wmo_area_names();
	if rows.is_empty() {
		return None;
	}
	let mut m = serde_json::Map::new();
	for (id, name, parent) in rows {
		m.insert(id.to_string(), serde_json::json!([name, parent]));
	}
	Some(format!("{}\n", serde_json::Value::Object(m)))
}

/// A tile's areas as the `.area.gz` sidecar's bytes.
pub fn encode_areas(areas: &[u32]) -> Vec<u8> {
	let mut raw = Vec::with_capacity(areas.len() * 4);
	for a in areas {
		raw.extend_from_slice(&a.to_le_bytes());
	}
	crate::format::gzip(&raw)
}

/// The `.area.gz` sidecar's areas.
pub fn decode_areas(gz: &[u8]) -> Result<Vec<u32>, String> {
	let raw = crate::format::gunzip(gz)?;
	if raw.len() % 4 != 0 {
		return Err(format!("area sidecar: {} bytes, not whole u32s", raw.len()));
	}
	Ok(raw.chunks_exact(4).map(|b| u32::from_le_bytes([b[0], b[1], b[2], b[3]])).collect())
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn near_triangle_inside_outside_padded() {
		let (a, b, c) = ([0.0, 0.0, 0.0], [10.0, 0.0, 0.0], [0.0, 10.0, 0.0]);
		assert!(near_triangle(a, b, c, 2.0, 2.0, 0.0));
		assert!(near_triangle(c, b, a, 2.0, 2.0, 0.0), "either winding");
		assert!(!near_triangle(a, b, c, 8.0, 8.0, 0.0));
		assert!(near_triangle(a, b, c, -0.5, 2.0, 1.0), "within pad of an edge");
	}

	#[test]
	fn areas_round_trip() {
		let v = vec![0, 14371, 0, 15011, 70000];
		assert_eq!(decode_areas(&encode_areas(&v)).unwrap(), v);
	}
}
