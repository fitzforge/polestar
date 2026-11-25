//! Incremental rebuild of two Ironforge clusters in the reviewed `forge nav pack` output, before regional partitioning.
//! Run with `<derived AddOns> <new directory>`; fill the remaining files with `cp -an <derived AddOns>/. <new directory>/`
//! and pass that directory to tools/lib/nav/import-regions.js. Neither the source nor the installed addon is edited.
//! At the grounded center the body intersects the fixed gryphon roost in both base builds (70532 and 70959).
//! Off-center stances in the same cell are clear. This is not a cell mask or a ban on standing near the roost.
//! On the street the sign blocks six pairs of ground-layer steps. Three separate points on its faces
//! also bound shortcuts; they do not mark a whole cell, model volume or standing position as occupied.
use flate2::read::ZlibDecoder;
use forge_nav::pack::cuts::reprice;
use forge_nav::pack::encode::{block, BLOCK_BYTES};
use forge_nav::pack::ingame::{decode_graph, encode_graph, Cluster, Row, DX, DY};
use forge_nav::pack::zlib_literals;
use serde_json::{json, Value};
use sha2::{Digest, Sha256};
use std::{collections::BTreeMap, fs, io::Read, path::Path};

const MANIFEST: &str = "Polestar_Nav/PACK.json";
// The reviewed pack: forge nav pack with joins.json's four joins of #3098, #3618, #3495 and #3581 (Nav0_20 and
// Nav0_21 unchanged from the 0.4.2 pack bcbe88bb), the 0.4.2 pack's appended layers kept.
const SOURCE: &str = "baebcb9390ef28030af0201d79ba68faca9fcb5973656cf920015ca650bff2d1";
const PARTS: [&str; 2] = ["Polestar_Nav_EK/Nav0_20.lua", "Polestar_Nav_EK/Nav0_21.lua"];
const CLUSTER: usize = 471;
const CELL: usize = 15594;
// Map 0, cluster 471: both ends are layer 1 at packed height 502. These are cell IDs, not node IDs.
const SIGN_PAIRS: [(usize, usize); 6] = [(14325, 14454), (14326, 14453), (14326, 14454), (14327, 14454), (14453, 14454), (14454, 14455)];
// Map 0, cluster 472: each street step incident on this layer crosses a fixed ForgeRoom wall at torso height.
// The parallel pavement and other storeys are not part of this cut.
const STREET: usize = 472;
const STREET_PAIRS: [(usize, usize); 5] = [(27823, 27828), (27828, 27831), (27828, 28005), (27828, 28006), (27828, 28008)];
// Node IDs in this exact pinned source, before renumbering. Two ramp-floor centers
// put the player's torso inside masonry; two approaches cut a wall before their end.
// Equal-height floors can share a cell: do not subtract by XY or height alone.
const RAMP_PAIRS: [(usize, usize); 14] = [
	(27359, 27495),
	(27359, 27498),
	(27360, 27495),
	(27363, 27495),
	(27363, 27498),
	(27371, 27498),
	(27493, 27495),
	(27495, 27498),
	(27495, 27608),
	(27498, 27500),
	(27498, 27610),
	(27498, 27611),
	(27611, 27728),
	(27613, 27728),
];
const SOLID_SAMPLES: &str = concat!(
	"PolestarPathData[0].solidSamples = { [471] = {-4866.847,-1107.031,502.515,-4864.583,-1106.652,502.515,-4866.632,-1108.366,502.515,",
	"-4861.745934,-1139.989935,502.750054,-4868.890104,-1143.820089,506.549525,-4863.879720,-1135.746168,503.250200,",
	"-4861.273418,-1141.422549,503.223817,-4868.359568,-1147.723829,506.619640},",
	" [472] = {-4825.530720,-1013.096860,503.236699,-4843.076958,-871.850614,502.55} }\n",
);

fn hash(bytes: &[u8]) -> String {
	format!("{:x}", Sha256::digest(bytes))
}

// Remove only the named floor-to-floor moves, however they were encoded. A paid
// arc can duplicate a nearest-height step. The reverse search uses both records.
fn cut_floor_pairs(before: &Cluster, after: &mut Cluster, pairs: &[(usize, usize)]) -> Result<(), String> {
	let mut moves = Vec::new();
	for &(a, b) in pairs {
		for (s, t) in [(a, b), (b, a)] {
			if s < before.n() || t >= before.t() || s >= before.t() || t < before.n() {
				return Err("expected two reviewed floor nodes".into());
			}
			before.moves(s, false, &mut moves);
			if !moves.iter().any(|m| m.0 == t) {
				return Err(format!("missing reviewed move {s} -> {t}"));
			}
			let (u, v, c) = (before.cell(s), before.cell(t), before.c);
			let delta = ((v / c) as i64 - (u / c) as i64, (v % c) as i64 - (u % c) as i64);
			let d = (0..8).find(|&d| (DX[d], DY[d]) == delta).ok_or("expected adjacent floors")?;
			if before.surface(v, -1, before.z[s]) == Some(t) {
				after.steps[s - before.n()] &= !(1 << d);
			}
			after.arcs.remove(&(s as u32, t as u32));
		}
	}
	after.links.retain(|&(s, d, layer)| {
		let s = s as usize;
		if !pairs.iter().any(|&(a, b)| a == s || b == s) {
			return true;
		}
		let (u, c) = (before.cell(s), before.c as i64);
		let v = (u as i64 / c + DX[d as usize]) * c + u as i64 % c + DY[d as usize];
		!before.surface(v as usize, layer as i32, before.z[s]).is_some_and(|t| pairs.binary_search(&(s.min(t), s.max(t))).is_ok())
	});
	Ok(())
}

// A reviewed cluster's interior cell has exactly one extra floor. No border, entrance, arc or explicit link
// is incident on it. In particular removing a step's target alone would redirect that step to the base floor.
fn remove<const P: usize>(before: &Cluster, rows: &[Row], cell: usize, z: f64, sign_pairs: &[(usize, usize); P], ramp_pairs: &[(usize, usize)]) -> Result<Cluster, String> {
	let (c, n) = (before.c, before.n());
	let (x, y) = (cell / c, cell % c);
	let (u, count) = before.floors_of(cell);
	if x == 0 || x + 1 >= c || y == 0 || y + 1 >= c || count != 1 || before.z[u] != z || before.val[u] != 1 || before.surface(cell, 0, 0.0) != Some(cell) {
		return Err("occupied floor: not the reviewed interior ground layer".into());
	}
	let neighbor = |from: usize, d: usize| {
		let lc = before.cell(from);
		(lc / c) as i64 + DX[d] == x as i64 && (lc % c) as i64 + DY[d] == y as i64
	};
	if rows.iter().any(|r| r.cell as usize == cell && r.layer != 0)
		|| before.arcs.keys().any(|&(a, b)| a as usize == u || b as usize == u)
		|| before.links.iter().any(|&(v, d, l)| v as usize == u || (l != 0 && neighbor(v as usize, d as usize)))
	{
		return Err("occupied floor: incident entrance, arc or explicit link needs review".into());
	}
	let mut after = before.clone();
	for d in 0..8 {
		let adjacent = (x as i64 - DX[d]) as usize * c + (y as i64 - DY[d]) as usize;
		let (first, count) = before.floors_of(adjacent);
		for i in 0..count {
			let v = first + i;
			if before.surface(cell, -1, before.z[v]) == Some(u) {
				after.steps[v - n] &= !(1 << d);
			}
		}
	}
	// Resolve stable cell/layer addresses before the roost removal renumbers the floor nodes.
	let street = |lc| before.surface(lc, 1, 502.0).filter(|&v| before.val[v] == 1 && before.z[v] == 502.0).ok_or("sign: expected street floor");
	let mut excluded = [(0, 0); P];
	for (pair, &(a, b)) in excluded.iter_mut().zip(sign_pairs) {
		let (s, t) = (street(a)?, street(b)?);
		*pair = (s, t);
		for (from, to, source, target) in [(a, b, s, t), (b, a, t, s)] {
			let dx = (to / c) as i64 - (from / c) as i64;
			let dy = (to % c) as i64 - (from % c) as i64;
			let d = (0..8).find(|&d| (DX[d], DY[d]) == (dx, dy)).ok_or("sign: not neighboring cells")?;
			let steps = &mut after.steps[source - n];
			if *steps & (1 << d) == 0 || before.surface(to, -1, before.z[source]) != Some(target) {
				return Err(format!("sign: missing street step {from} -> {to}"));
			}
			*steps &= !(1 << d);
		}
	}
	cut_floor_pairs(before, &mut after, ramp_pairs)?;
	let shift = |v: u32| v - u32::from(v as usize > u);
	for (v, _, _) in &mut after.links {
		*v = shift(*v);
	}
	after.arcs = std::mem::take(&mut after.arcs).into_iter().map(|((a, b), len)| ((shift(a), shift(b)), len)).collect();
	after.at.remove(u - n);
	after.steps.remove(u - n);
	after.val.remove(u);
	after.z.remove(u);
	after.cls.remove(u);
	after.area.remove(u);
	after.index();
	let (mut old, mut new) = (Vec::new(), Vec::new());
	for v in (0..before.t()).filter(|&v| v != u) {
		let at_sign = excluded.iter().any(|&(a, b)| a == v || b == v);
		let at_ramp = ramp_pairs.iter().any(|&(a, b)| a == v || b == v);
		for reverse in [false, true] {
			before.moves(v, reverse, &mut old);
			old.retain(|&(w, _)| {
				let sign = at_sign && (excluded.contains(&(v, w)) || excluded.contains(&(w, v)));
				let ramp = at_ramp && ramp_pairs.binary_search(&(v.min(w), v.max(w))).is_ok();
				w != u && !sign && !ramp
			});
			for m in &mut old {
				m.0 = shift(m.0 as u32) as usize;
			}
			after.moves(shift(v as u32) as usize, reverse, &mut new);
			if old != new {
				return Err(format!("occupied floor: changed a surviving move at node {v}"));
			}
		}
	}
	Ok(after)
}

// Only called on the two parts authenticated by PACK.json. Literals in these fields are forge-nav's
// zlib_literals: raw bytes apart from three-digit decimal escapes. Keep every other line byte-for-byte.
fn field(line: &[u8]) -> Option<((usize, &str), &[u8])> {
	let line = line.strip_prefix(b"data.packed.")?;
	let at = line.iter().position(|&b| b == b'[')?;
	let name = std::str::from_utf8(&line[..at]).ok()?;
	let rhs = line[at..].strip_suffix(b"}\n")?;
	let (k, blocks) = if let Some(b) = rhs.strip_prefix(b"[472] = {") { (CLUSTER, b) } else { (STREET, rhs.strip_prefix(b"[473] = {")?) };
	matches!(name, "graph" | "grid" | "height" | "floor" | "class" | "area" | "arc").then_some(((k, name), blocks))
}

fn unpack(blocks: &[u8]) -> (String, usize) {
	let mut raw = String::new();
	let mut encoded = 0;
	for body in blocks.split(|&b| b == b'"').skip(1).step_by(2) {
		let mut bytes = Vec::with_capacity(body.len());
		let mut p = 0;
		while p < body.len() {
			if body[p] == b'\\' {
				bytes.push(std::str::from_utf8(&body[p + 1..p + 4]).unwrap().parse().unwrap());
				p += 4;
			} else {
				bytes.push(body[p]);
				p += 1;
			}
		}
		ZlibDecoder::new(bytes.as_slice()).read_to_string(&mut raw).unwrap();
		encoded += 4 * bytes.len().div_ceil(3) + 4; // base64 and quotes + separator, less final separator
	}
	(raw, encoded - 2)
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
	let args: Vec<_> = std::env::args_os().skip(1).collect();
	if args.len() != 2 {
		return Err("usage: occupied_floor <derived AddOns> <new output directory>".into());
	}
	let (source, dest) = (Path::new(&args[0]), Path::new(&args[1]));
	let bytes = fs::read(source.join(MANIFEST))?;
	assert_eq!(hash(&bytes), SOURCE, "unreviewed forge nav pack manifest");
	let mut manifest: Value = serde_json::from_slice(&bytes)?;
	let read = |name: &str, key: &str| -> std::io::Result<Vec<u8>> {
		let b = fs::read(source.join(name))?;
		assert_eq!(manifest["files"][key], hash(&b), "unrecognized {key}");
		Ok(b)
	};
	let mut meta = String::from_utf8(read("Polestar_Nav/Nav/Nav0.lua", "Nav/Nav0.lua")?)?;
	let number = |key: &str| -> f64 { meta.split_once(&format!("\n\t{key} = ")).unwrap().1.split(',').next().unwrap().parse().unwrap() };
	let c = number("cells") as usize;
	let ny = number("ny") as usize;
	let tile = 1600.0 / 3.0;
	let cs = tile / c as f64;
	let center = |origin, cluster: usize, local: usize| (origin + cluster as f64) * tile + (local as f64 + 0.5) * cs;
	let x: f64 = center(number("cx0"), CLUSTER / ny, CELL / c);
	let y: f64 = center(number("cy0"), CLUSTER % ny, CELL % c);
	assert!((x + 4827.0833333333).abs() < 1e-8 && (y + 1156.25).abs() < 1e-8);
	let parts = PARTS.iter().map(|p| read(p, p)).collect::<Result<Vec<_>, _>>()?;
	let mut fields = BTreeMap::new();
	for line in parts.iter().flat_map(|p| p.split_inclusive(|&b| b == b'\n')) {
		if let Some((name, blocks)) = field(line) {
			assert!(fields.insert(name, unpack(blocks)).is_none());
		}
	}
	let mut changed = BTreeMap::new();
	let mut area_removed = 0;
	let mut dearer = [0; 2];
	for (i, k) in [CLUSTER, STREET].into_iter().enumerate() {
		let get = |f: &'static str| fields[&(k, f)].0.as_str();
		let before = Cluster::decode(c, cs, number("zstep"), get("grid"), get("height"), Some(get("floor")), Some(get("class")), Some(get("area")), Some(get("arc")))?;
		let mut rows = decode_graph(get("graph"))?;
		let after = if k == CLUSTER {
			assert_eq!((before.z[CELL], rows.len()), (768.0, 306));
			area_removed = i64::from(before.area[before.floors_of(CELL).0] != 0);
			let after = remove(&before, &rows, CELL, 502.0, &SIGN_PAIRS, &RAMP_PAIRS)?;
			changed.insert((k, "class"), after.class_field());
			changed.insert((k, "area"), after.area_field()?.unwrap());
			after
		} else {
			let mut after = before.clone();
			assert_eq!(before.surface(15875, 5, 502.0), Some(27828));
			cut_floor_pairs(&before, &mut after, &STREET_PAIRS)?;
			after.index();
			let (mut old, mut new) = (Vec::new(), Vec::new());
			for u in 0..before.t() {
				for reverse in [false, true] {
					before.moves(u, reverse, &mut old);
					old.retain(|&(v, _)| STREET_PAIRS.binary_search(&(u.min(v), u.max(v))).is_err());
					after.moves(u, reverse, &mut new);
					assert_eq!(old, new, "unexpected street move at {u}, reverse={reverse}");
				}
			}
			after
		};
		let (costlier, gone) = reprice(&before, &after, &mut rows, number("swim"));
		assert_eq!(gone, 0, "disconnected entrance edge in cluster {k} needs review");
		dearer[i] = costlier;
		changed.insert((k, "floor"), after.floor_field()?.unwrap());
		changed.insert((k, "arc"), after.arc_field().unwrap());
		if costlier != 0 {
			changed.insert((k, "graph"), encode_graph(&rows)?);
		}
	}
	let (mut raw_delta, mut packed_delta) = (0i64, 0i64);
	fs::create_dir(dest)?; // Never overwrite or follow links into the input (or into an installed addon).
	fs::create_dir(dest.join("Polestar_Nav_EK"))?;
	fs::create_dir(dest.join("Polestar_Nav"))?;
	meta.push_str(SOLID_SAMPLES);
	fs::create_dir(dest.join("Polestar_Nav/Nav"))?;
	manifest["files"]["Nav/Nav0.lua"] = json!(hash(meta.as_bytes()));
	fs::write(dest.join("Polestar_Nav/Nav/Nav0.lua"), meta)?;
	for (key, part) in PARTS.iter().zip(&parts) {
		let mut out = Vec::with_capacity(part.len());
		for line in part.split_inclusive(|&b| b == b'\n') {
			if let Some((id @ (k, name), _)) = field(line) {
				if let Some(value) = changed.get(&id).filter(|v| **v != fields[&id].0) {
					let rhs = value.as_bytes().chunks(BLOCK_BYTES).map(|chunk| format!("\"{}\"", block(chunk))).collect::<Vec<_>>().join(", ");
					raw_delta += value.len() as i64 - fields[&id].0.len() as i64;
					packed_delta += rhs.len() as i64 - fields[&id].1 as i64;
					out.extend(zlib_literals(&format!("data.packed.{name}[{}] = {{{rhs}}}\n", k + 1))?);
					continue;
				}
			}
			out.extend_from_slice(line);
		}
		manifest["files"][key] = json!(hash(&out));
		fs::write(dest.join(key), out)?;
	}
	let map = &mut manifest["maps"]["0"];
	for (v, delta) in [("rawBytes", raw_delta), ("packedBytes", packed_delta)] {
		map[v] = json!(map[v].as_i64().unwrap() + delta);
	}
	let stats = &mut map["leffe"];
	stats["floors"] = json!(stats["floors"].as_i64().unwrap() - 1);
	stats["areaSurfaces"] = json!(stats["areaSurfaces"].as_i64().unwrap() - area_removed);
	map["occupiedFloor"] = json!({
		"sourceManifestSha256": SOURCE, "cluster": CLUSTER, "cell": CELL, "layer": 1, "z": 502,
		"sign": {"cellPairs": SIGN_PAIRS, "layer": 1, "z": 502, "solidSamples": 3},
		"trainerRamp": {"sourceNodePairs": RAMP_PAIRS, "solidSamples": 5}, "dearerEdges": dearer[0],
		"forgeRoom": {"cluster": STREET, "sourceNodePairs": STREET_PAIRS, "solidSamples": 1, "dearerEdges": dearer[1]},
		"stonefireWall": {"cluster": STREET, "solidSamples": 1}
	});
	fs::write(dest.join(MANIFEST), serde_json::to_string_pretty(&manifest)? + "\n")?;
	println!("Removed the occupied Ironforge center and obstructed signpost, ramp and street steps; dearer entrance edges: {dearer:?}, none lost");
	Ok(())
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_nav::pack::encode::{encode_heights, run_length};

	fn floors() -> Cluster {
		let height = encode_heights(&[1; 16], &[384; 16], 4).unwrap();
		let mut c = Cluster::decode(4, 4.0, 2.0, &run_length(&[16; 16]), &height, None, None, None, None).unwrap();
		let a = c.add_floor(5, 1, 502.0, 0, 0);
		let b = c.add_floor(6, 1, 502.0, 0, 0);
		c.steps[a - 16] = 4; // +y
		c.steps[b - 16] = 8; // -y
		c.index();
		c
	}

	#[test]
	fn removing_ground_does_not_redirect_its_neighbor_onto_the_roof() {
		let c = floors();
		assert!(remove(&c, &[], 5, 768.0, &[], &[]).is_err());
		let after = remove(&c, &[], 5, 502.0, &[], &[]).unwrap();
		assert_eq!(after.z[5], 768.0);
		let neighbor = after.surface(6, 1, 502.0).unwrap();
		let mut moves = Vec::new();
		after.moves(neighbor, false, &mut moves);
		assert!(moves.is_empty());
	}

	#[test]
	fn sign_cut_keeps_the_neighbor_upper_walk_and_one_way_arc() {
		let mut c = floors();
		let lo = c.surface(6, 1, 0.0).unwrap();
		let hi = c.add_floor(6, 1, 520.0, 0, 0);
		let other_lo = c.add_floor(7, 1, 502.0, 0, 0);
		let other_hi = c.add_floor(7, 1, 520.0, 0, 0);
		let neighbor = c.add_floor(10, 1, 502.0, 0, 0);
		c.steps[lo - 16] |= 1 | 4; // +x to the neighbor, +y through the sign
		c.steps[other_lo - 16] = 8;
		c.steps[neighbor - 16] = 2;
		c.steps[hi - 16] = 4;
		c.steps[other_hi - 16] = 8;
		c.add_arc(other_hi, lo, 12.0);

		let after = remove(&c, &[], 5, 502.0, &[(6, 7)], &[]).unwrap();
		let node = |lc, layer| after.surface(lc, layer, 0.0).unwrap();
		let mut moves = Vec::new();
		for back in [false, true] {
			after.moves(node(6, 1), back, &mut moves);
			assert!(!moves.iter().any(|m| m.0 == node(7, 1)));
			assert!(moves.contains(&(node(10, 1), 1.0)));
			assert_eq!(moves.contains(&(node(7, 2), 3.0)), back);
			after.moves(node(7, 1), back, &mut moves);
			assert!(moves.is_empty());
			after.moves(node(6, 2), back, &mut moves);
			assert_eq!(moves, [(node(7, 2), 1.0)]);
			after.moves(node(7, 2), back, &mut moves);
			assert!(moves.contains(&(node(6, 2), 1.0)));
			assert_eq!(moves.contains(&(node(6, 1), 3.0)), !back);
		}
	}

	#[test]
	fn another_layer_or_incident_entrance_link_or_arc_needs_a_new_review() {
		let mut c = floors();
		let u = c.surface(5, 1, 502.0).unwrap();
		let v = c.surface(6, 1, 502.0).unwrap();
		let row = Row { cell: 5, layer: 1, comp: 0, edges: vec![] };
		assert!(remove(&c, &[row], 5, 502.0, &[], &[]).is_err());
		c.links.push((v as u32, 3, 1));
		assert!(remove(&c, &[], 5, 502.0, &[], &[]).is_err());
		c.links.clear();
		c.add_arc(v, u, 4.0);
		assert!(remove(&c, &[], 5, 502.0, &[], &[]).is_err());
		c.arcs.clear();
		c.add_floor(5, 1, 510.0, 0, 0);
		assert!(remove(&c, &[], 5, 502.0, &[], &[]).is_err());
	}
}
