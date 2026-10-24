//! gen_nav.py encode_map + encode_floors and pack_nav.py write_bundle (pack.js encodeMaps,
//! runLength, encodeZones, encodeHeights, packFiles): the per-cluster strings and the Lua files.

use super::cells::{dir_of, CellGrid, SDX, SDY, ZQ};
use super::hpa::Hpa;
use super::{enc, js_round, js_str, Hub, B64, NONE, SWIM};
use rustc_hash::FxHashMap;
use std::collections::BTreeMap;
use std::io::Write;

/// A graph edge's cost per profile: 3 symbols.
pub const COST_MAX: f64 = (64 * 64 * 64 - 1) as f64;
/// Its yards: 2 symbols.
pub const YARDS_MAX: f64 = (64 * 64 - 1) as f64;
/// pack_nav.py: the client decompresses blocks into a 16 KB buffer.
pub const BLOCK_BYTES: usize = 16 * 1024;
/// pack_nav.py: bytes per Lua part file.
pub const PART_BYTES: usize = 512 * 1024;

/// One map's encoded fields per cluster k (0-based).
#[derive(Default, Debug)]
pub struct Maps {
	pub graph: BTreeMap<u32, String>,
	pub grid: BTreeMap<u32, String>,
	pub height: BTreeMap<u32, String>,
	pub floor: BTreeMap<u32, String>,
	/// Format 2 only.
	pub class: Option<BTreeMap<u32, String>>,
	pub zone: Option<BTreeMap<u32, String>>,
	/// Format 3: the area field, when any node of the map has a WMOAreaTable row.
	pub area: Option<BTreeMap<u32, String>>,
	pub components: usize,
	pub clamped: usize,
	pub max_degree: usize,
}

impl Maps {
	pub fn field(&self, f: &str) -> &BTreeMap<u32, String> {
		match f {
			"graph" => &self.graph,
			"grid" => &self.grid,
			"height" => &self.height,
			"floor" => &self.floor,
			"class" => self.class.as_ref().expect("class field"),
			"area" => self.area.as_ref().expect("area field"),
			_ => panic!("field {f}"),
		}
	}

	/// The packed fields, in pack order: format 1's, format 2's class, format 3's area.
	pub fn fields(&self) -> &'static [&'static str] {
		match (self.class.is_some(), self.area.is_some()) {
			(false, _) => &FIELDS,
			(true, false) => &CLASS_FIELDS,
			(true, true) => &AREA_FIELDS,
		}
	}
}

/// Run-length symbols of a cell list (gen_nav.py encode_map's grid part).
pub fn run_length(vals: &[u8]) -> String {
	let mut out = String::new();
	let mut i = 0;
	while i < vals.len() {
		let mut j = i + 1;
		while j < vals.len() && vals[j] == vals[i] {
			j += 1;
		}
		out.push(B64[vals[i] as usize] as char);
		let mut r = (j - i - 1) as i64;
		while r > 0 {
			out.push(B64[48 + r.min(16) as usize - 1] as char);
			r -= 16;
		}
		i = j;
	}
	out
}

/// The zone field of a cluster: its 256 chunk uiMapIDs, each 2 symbols, a symbol >= 48 repeating
/// the previous one (symbol - 47) more times.
pub fn encode_zones(vals: &[u16]) -> Result<String, String> {
	let mut out = String::new();
	let mut i = 0;
	while i < vals.len() {
		let mut j = i + 1;
		while j < vals.len() && vals[j] == vals[i] {
			j += 1;
		}
		if vals[i] as u32 >= 48 * 64 {
			return Err(format!("pack: zone {} does not fit the zone field", vals[i]));
		}
		out.push_str(&enc(vals[i] as f64, 2)?);
		let mut r = (j - i - 1) as i64;
		while r > 0 {
			out.push(B64[48 + r.min(16) as usize - 1] as char);
			r -= 16;
		}
		i = j;
	}
	Ok(out)
}

/// The area field of a cluster (HEADER, maps format 3): per node its WMOAreaTable row id, each a
/// 3-symbol number (its first symbol under 48: under 48 * 64 * 64), a symbol >= 48 repeating the
/// previous one (symbol - 47) more times.
pub fn encode_areas(vals: &[u32]) -> Result<String, String> {
	let mut out = String::new();
	let mut i = 0;
	while i < vals.len() {
		let mut j = i + 1;
		while j < vals.len() && vals[j] == vals[i] {
			j += 1;
		}
		if vals[i] >= 48 * 64 * 64 {
			return Err(format!("pack: area {} does not fit the area field", vals[i]));
		}
		out.push_str(&enc(vals[i] as f64, 3)?);
		let mut r = (j - i - 1) as i64;
		while r > 0 {
			out.push(B64[48 + r.min(16) as usize - 1] as char);
			r -= 16;
		}
		i = j;
	}
	Ok(out)
}

/// gen_nav.py encode_heights.
fn encode_heights(val: &[u8], zq: &[i32], c: usize) -> Result<String, String> {
	let mut q = vec![0i32; c * c];
	let mut has = vec![false; c * c];
	let mut items: Vec<(bool, i32)> = Vec::new(); // (absolute, value)
	let mut last = 0;
	for i in 0..c {
		for j in 0..c {
			let l = i * c + j;
			if val[l] == 0 {
				continue;
			}
			let v = zq[l];
			let pred = if j > 0 && has[l - 1] {
				q[l - 1]
			} else if i > 0 && has[l - c] {
				q[l - c]
			} else {
				last
			};
			items.push(if (v - pred).abs() <= 23 { (false, v - pred) } else { (true, v) });
			q[l] = v;
			last = v;
			has[l] = true;
		}
	}
	let mut out = String::new();
	let mut i = 0;
	while i < items.len() {
		let (abs, v) = items[i];
		if abs {
			out.push(B64[47] as char);
			out.push_str(&enc((v + 2048) as f64, 2)?);
			i += 1;
			continue;
		}
		out.push(B64[(v + 23) as usize] as char);
		let mut j = i + 1;
		while j < items.len() && !items[j].0 && items[j].1 == v {
			j += 1;
		}
		let mut r = (j - i - 1) as i64;
		while r > 0 {
			out.push(B64[48 + r.min(16) as usize - 1] as char);
			r -= 16;
		}
		i = j;
	}
	Ok(out)
}

/// pack.js encodeMaps: CellGrid + HPA -> strings per cluster. A grid with ground classes gives maps
/// format 2; one without (a hand-made map) format 1 with no graph.
pub fn encode_maps(cg: &CellGrid, hpa: &Hpa) -> Result<Maps, String> {
	let c = cg.c;
	let (ny, gh) = (cg.ny, cg.gh);
	let nb = cg.nb();
	let classed = cg.clusters().all(|cl| cl.cls.is_some());
	if !classed && !hpa.edges.is_empty() {
		return Err("pack: a graph needs ground classes (maps format 2)".into());
	}
	let mut all: Vec<u32> = hpa.nodes.values().flat_map(|s| s.iter().copied()).collect();
	all.sort_unstable();
	let idx = |n: u32| all.binary_search(&n).unwrap();
	let mut parent: Vec<usize> = (0..all.len()).collect();
	fn find(parent: &mut [usize], mut x: usize) -> usize {
		while parent[x] != x {
			parent[x] = parent[parent[x]];
			x = parent[x];
		}
		x
	}
	let mut sorted: Vec<(u32, u32)> = hpa.edges.iter().map(|e| (e.a, e.b)).collect();
	sorted.sort();
	for (a, b) in sorted {
		let ra = find(&mut parent, idx(a));
		let rb = find(&mut parent, idx(b));
		parent[ra] = rb;
	}
	let mut size: FxHashMap<usize, usize> = FxHashMap::default();
	for i in 0..all.len() {
		let r = find(&mut parent, i);
		*size.entry(r).or_default() += 1;
	}
	let mut ranked: Vec<(usize, usize)> = size.into_iter().collect();
	ranked.sort_by(|p, q| q.1.cmp(&p.1).then(p.0.cmp(&q.0)));
	let roots: FxHashMap<usize, usize> = ranked.iter().enumerate().map(|(i, &(r, _))| (r, i.min(4095))).collect();
	let comp: Vec<usize> = (0..all.len()).map(|i| roots[&find(&mut parent, i)]).collect();
	let mut order: FxHashMap<u32, Vec<u32>> = FxHashMap::default();
	let mut local: FxHashMap<u32, usize> = FxHashMap::default();
	for (&k, set) in &hpa.nodes {
		let mut cs: Vec<u32> = set.iter().copied().collect();
		cs.sort_unstable();
		for (i, &n) in cs.iter().enumerate() {
			local.insert(n, i);
		}
		order.insert(k, cs);
	}
	let mut nbrs: FxHashMap<u32, Vec<(u32, [f64; 3], f64)>> = FxHashMap::default();
	for e in &hpa.edges {
		nbrs.entry(e.a).or_default().push((e.b, e.ab, e.yab));
		nbrs.entry(e.b).or_default().push((e.a, e.ba, e.yba));
	}
	let lcell = |cell: u32| -> usize {
		if cell >= nb {
			let f = (cell - nb) as usize;
			let cl = cg.cluster(cg.cluster_of_cell(cg.floor_cell[f])).unwrap();
			return c * c + f - cl.floor_start;
		}
		let gx = cell as usize / gh;
		let gy = cell as usize % gh;
		(gx % c) * c + gy % c
	};
	let layer_of = |n: u32| -> u32 {
		if n >= nb {
			cg.floor_layer[(n - nb) as usize]
		} else {
			0
		}
	};
	let stored_z = |n: u32| -> i64 {
		if n >= nb {
			return js_round(cg.floor_z[(n - nb) as usize]) as i64;
		}
		let (s, l) = cg.at((n as usize / gh) as i64, (n as usize % gh) as i64).unwrap();
		let _ = s;
		cg.cluster(cg.cluster_of_cell(n)).unwrap().zq[l] as i64 * ZQ as i64
	};
	let direction = |u: u32, v: u32| -> i32 {
		let (cu, cv) = (cg.cell_of(u) as i64, cg.cell_of(v) as i64);
		let gh = gh as i64;
		dir_of(cv / gh - cu / gh, cv % gh - cu % gh)
	};
	let matched = |u: u32, d: usize| -> Option<u32> {
		let cu = cg.cell_of(u) as i64;
		let tx = cu / gh as i64 + SDX[d] as i64;
		let ty = cu % gh as i64 + SDY[d] as i64;
		if tx < 0 || ty < 0 || tx >= cg.gw as i64 || ty >= gh as i64 {
			return None;
		}
		let cell = (tx * gh as i64 + ty) as u32;
		let mut cands = Vec::new();
		if cg.value(tx, ty) != 0 {
			cands.push(cell);
		}
		if let Some(&f0) = cg.floor_at.get(&cell) {
			let mut f = f0 as usize;
			while f < cg.floor_cell.len() && cg.floor_cell[f] == cell {
				cands.push(nb + f as u32);
				f += 1;
			}
		}
		let zu = stored_z(u);
		let mut best = None;
		let mut gap = i64::MAX;
		for v in cands {
			let g = (stored_z(v) - zu).abs();
			if g < gap {
				best = Some(v);
				gap = g;
			}
		}
		best
	};
	let mut maps = Maps { class: classed.then(BTreeMap::new), zone: classed.then(BTreeMap::new), ..Default::default() };
	let mut areas: BTreeMap<u32, String> = BTreeMap::new();
	let empty: Vec<u32> = Vec::new();
	for k in cg.keys_sorted() {
		let kx = k as i64 / ny as i64;
		let ky = k as i64 % ny as i64;
		let cl = cg.cluster(k).unwrap();
		let cs = order.get(&k).unwrap_or(&empty);
		if !cs.is_empty() {
			if cs.len() >= 4096 {
				return Err(format!("pack: cluster {k} has {} entrances (at most 4095)", cs.len()));
			}
			let mut rec = enc(cs.len() as f64, 2)?;
			let mut erec = String::new();
			for &n in cs {
				let mut list = nbrs.get(&n).cloned().unwrap_or_default();
				list.sort_by(|p, q| p.0.cmp(&q.0).then(p.1[NONE].partial_cmp(&q.1[NONE]).unwrap()).then(p.2.partial_cmp(&q.2).unwrap()));
				maps.max_degree = maps.max_degree.max(list.len());
				if list.len() >= 64 {
					return Err(format!("pack: entrance {n} has {} edges (at most 63)", list.len()));
				}
				rec.push_str(&enc(lcell(cg.cell_of(n)) as f64, 3)?);
				rec.push_str(&enc(layer_of(n) as f64, 1)?);
				rec.push_str(&enc(comp[idx(n)] as f64, 2)?);
				rec.push_str(&enc(list.len() as f64, 1)?);
				for (m, costs, yd) in list {
					let km = cg.cluster_of_cell(cg.cell_of(m)) as i64;
					let dx = km / ny as i64 - kx;
					let dy = km % ny as i64 - ky;
					erec.push_str(&enc(((dx + 1) * 3 + dy + 1) as f64, 1)?);
					erec.push_str(&enc(local[&m] as f64, 2)?);
					for w in costs {
						let r = js_round(w);
						if r > COST_MAX {
							maps.clamped += 1;
						}
						erec.push_str(&enc(r.min(COST_MAX), 3)?);
					}
					let y = js_round(yd);
					if y > YARDS_MAX {
						maps.clamped += 1;
					}
					erec.push_str(&enc(y.min(YARDS_MAX), 2)?);
				}
			}
			rec.push_str(&erec);
			maps.graph.insert(k, rec);
		}
		let vals: Vec<u8> = (0..c * c).map(|l| cl.val[l] * 16 + cl.flags[l]).collect();
		if vals.iter().any(|&v| v != 0) {
			maps.grid.insert(k, run_length(&vals));
			maps.height.insert(k, encode_heights(&cl.val, &cl.zq, c)?);
		}
		if let (Some(classes), Some(ccls)) = (maps.class.as_mut(), cl.cls.as_ref()) {
			let nf = cl.floor_end - cl.floor_start;
			let mut cv: Vec<u8> = ccls.clone();
			cv.extend((0..nf).map(|f| cg.floor_class[cl.floor_start + f]));
			if cv.iter().any(|&v| v != 0) {
				classes.insert(k, run_length(&cv));
			}
		}
		// The area field (maps format 3): per node its WMOAreaTable row, when any node of the cluster has one.
		let floor_area = &cg.floor_area[cl.floor_start..cl.floor_end];
		if cl.area.is_some() || floor_area.iter().any(|&a| a != 0) {
			let mut av: Vec<u32> = cl.area.clone().unwrap_or_else(|| vec![0; c * c]);
			av.extend_from_slice(floor_area);
			areas.insert(k, encode_areas(&av)?);
		}
		let linked = cg.linked_of.get(&k).unwrap_or(&empty);
		if cl.floor_end > cl.floor_start || !linked.is_empty() {
			let mut cells: Vec<(u32, Vec<u32>)> = Vec::new();
			for f in cl.floor_start..cl.floor_end {
				let cell = cg.floor_cell[f];
				if cells.last().is_none_or(|x| x.0 != cell) {
					cells.push((cell, Vec::new()));
				}
				cells.last_mut().unwrap().1.push(nb + f as u32);
			}
			let mut out = enc(cells.len() as f64, 3)?;
			let mut extra: Vec<(usize, i32, u32)> = Vec::new();
			for (cell, ns) in &cells {
				out.push_str(&enc(lcell(*cell) as f64, 3)?);
				out.push_str(&enc(ns.len() as f64, 1)?);
				for &n in ns {
					let mut steps = 0u32;
					for &v in cg.links.get(&n).unwrap_or(&empty) {
						let d = direction(n, v);
						if matched(n, d as usize) == Some(v) {
							steps |= 1 << d;
						} else {
							extra.push((lcell(n), d, layer_of(v)));
						}
					}
					out.push_str(&enc(cg.floor_val[(n - nb) as usize] as f64, 1)?);
					out.push_str(&enc((stored_z(n) + 2048) as f64, 2)?);
					out.push_str(&enc(steps as f64, 2)?);
				}
			}
			for &u in linked {
				if u >= nb {
					continue;
				}
				for &v in &cg.links[&u] {
					if cg.cluster_of_cell(cg.cell_of(v)) != k {
						extra.push((lcell(u), direction(u, v), layer_of(v)));
					}
				}
			}
			extra.sort();
			out.push_str(&enc(extra.len() as f64, 3)?);
			for (n, d, la) in extra {
				out.push_str(&enc(n as f64, 3)?);
				out.push_str(&enc(d as f64, 1)?);
				out.push_str(&enc(la as f64, 1)?);
			}
			maps.floor.insert(k, out);
		}
	}
	if let Some(zones) = maps.zone.as_mut() {
		for k in cg.keys_sorted() {
			if let Some(z) = &cg.cluster(k).unwrap().zone {
				zones.insert(k, encode_zones(z)?);
			}
		}
	}
	maps.components = roots.len();
	if classed && !areas.is_empty() {
		maps.area = Some(areas);
	}
	Ok(maps)
}

const HEADER: &[&str] = &[
	"-- UnitPosition's frame (x north, y west). Cluster k (0-based) is the ADT tile x in [(cx0 + k // ny) T, +T),",
	"-- y in [(cy0 + k % ny) T, +T), T = 1600 / 3, cut into cells x cells cells, x-major. Base64 (A-Za-z0-9+/).",
	"-- graph[k + 1]: n(2) | n x [cell(3) layer(1) component(2) degree(1)] | edges in node order [cluster offset(1):",
	"--   (dx + 1) * 3 + dy + 1, node(2), costAlliance(3), costHorde(3), costNone(3), yards(2)]: an edge's cost under",
	"--   each profile (Routing/Costs.lua; water at swim) in running yards, and the yards walked along the cost-best way",
	"--   with no profile (one value for every profile: a walk round a hostile hub inside a cluster is longer than its",
	"--   yards say; Routing/PathGrid.lua adjacent). grid[k + 1]: per cell value * 16 + flags, where value 0 blocked,",
	"--   1 ground, 2 water;",
	"--   flags 1/2 close the step to the +x/+y neighbour, 4/8 open the +x+y/+x-y",
	"--   diagonal (otherwise a diagonal is open when either L-shaped detour is). A symbol >= 48 repeats the",
	"--   previous cell (symbol - 47) more times. Nodes are local cells, then floors from cells * cells on.",
	"-- height[k + 1]: base heights of the walkable cells in cell order, in zstep yards, each against its -y",
	"--   neighbour (else its -x neighbour, else the previous cell): symbols 0-46 add -23..23, 47 is followed by",
	"--   an absolute value + 2048 (2), a symbol >= 48 repeats the previous difference (symbol - 47) more times.",
	"-- floor[k + 1]: surfaces above or below the base one, numbered from cells * cells in order.",
	"--   n(3) | n x [cell(3) count(1) count x [value(1) height + 2048(2) steps(2)]] | m(3) | m x [node(3) direction(1)",
	"--   layer(1)]. A floor's steps bit d links it to the surface in direction d nearest its height; the m links are",
	"--   the rest: a floor's links to another surface, and a base cell's links to floors across the cluster border",
	"--   (inside the cluster they are the reverse of the floors' own). Layer 0 is the base surface, i the cell's ith",
	"--   floor from the bottom; directions 0-7 are +x, -x, +y, -y, +x+y, +x-y, -x+y, -x-y.",
	"-- class[k + 1]: per node in node order its ground class byte (Routing/Costs.lua: bits 0-2 the base class,",
	"--   bit 3 inside an Alliance hub, bit 4 inside a Horde hub), run-length as the grid field; nodes past the end",
	"--   are class 0, and so is every node of a cluster without one. hubs: the hostile hubs, for the router's report:",
	"--   { id, side, name (English), areaId (AreaTable: the town in the client's language), disks = { { x, y, r } } }.",
	"-- zone[k + 1] (format 2, optional, not packed): the zone of each of the cluster's 16 x 16 chunks (cells / 16 cells",
	"--   square; chunk (x // (cells / 16)) * 16 + y // (cells / 16) of its local cell x, y) as its uiMapID, 0 for none:",
	"--   a 2-symbol number, a symbol >= 48 repeating the previous one (symbol - 47) more times. A cluster without one",
	"--   lies in no zone; the router prices a step into a zone by its caller's danger table (Routing/Path.lua).",
	"-- area[k + 1] (format 3, optional, packed as class is): per node in node order its WMO group's WMOAreaTable row id (the",
	"--   client's subzone on that floor: the Undercity's Canals, Trade Quarter, the Ruins above), 0 for none: a 3-symbol",
	"--   number, a symbol >= 48 repeating the previous one (symbol - 47) more times; nodes past the end are 0, and so is",
	"--   every node of a cluster without one. areaNames[id]: each row id's subzone name (English, as GetSubZoneText).",
	"-- Packed (pack_nav.py's layout): data.packed.<field>[k + 1] = { base64(zlib(16 KB block)), ... } in the parts.",
];

pub const FIELDS: [&str; 4] = ["graph", "grid", "height", "floor"];
pub const CLASS_FIELDS: [&str; 5] = ["graph", "grid", "height", "floor", "class"];
pub const AREA_FIELDS: [&str; 6] = ["graph", "grid", "height", "floor", "class", "area"];
const PART_NOTE: &str = "-- Compressed terrain for on-demand decoding (Shortest Path Forever's pack_nav.py layout).";
const CREDIT: &[&str] = &[
	"-- Polestar's walking maps (format 2: ground classes and per-faction costs) of the navigation grid, written by",
	"-- tools/lib/nav/pack.js, started from Shortest Path Forever's walking-map format (github.com/cjber/shortest-path-forever):",
	"-- a port of his tools/baker/gen_nav.py and tools/pack_nav.py, used with his permission.",
	"-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.",
];

/// The name of a map (pack.js NAMES).
fn map_name(map: u32) -> String {
	match map {
		0 => "Eastern Kingdoms".into(),
		1 => "Kalimdor".into(),
		2991 => "Zephras Isle".into(),
		m => format!("map {m}"),
	}
}

/// A Lua string literal (pack.js luaStr).
pub fn lua_str(s: &str) -> String {
	let mut out = String::with_capacity(s.len() + 2);
	out.push('"');
	for ch in s.chars() {
		match ch {
			'\\' | '"' => {
				out.push('\\');
				out.push(ch);
			}
			'\n' => out.push_str("\\n"),
			_ => out.push(ch),
		}
	}
	out.push('"');
	out
}

/// zlib (level 9) of a block, base64.
pub fn block(raw: &[u8]) -> String {
	let mut z = flate2::write::ZlibEncoder::new(Vec::new(), flate2::Compression::new(9));
	z.write_all(raw).unwrap();
	super::base64(&z.finish().unwrap())
}

/// pack.js packFiles: one map's strings -> its metadata file and parts. `gen` is the
/// generated-file header line; `area_names` the grid's areas.json ({ id: [name, AreaTableID] }),
/// naming the rows of a format 3 map's area field. -> (files, packed bytes)
pub fn pack_files(map: u32, cg: &CellGrid, maps: &Maps, global: &str, gen: &str, hubs: &[Hub], area_names: Option<&serde_json::Value>) -> Result<(Vec<(String, String)>, usize), String> {
	let mut files = Vec::new();
	let classed = maps.class.is_some();
	let areaed = classed && maps.area.is_some();
	let fields = maps.fields();
	let num = js_str_num;
	let hub_lines: Vec<String> = hubs
		.iter()
		.filter(|h| h.side == "Alliance" || h.side == "Horde")
		.map(|h| {
			let disks: Vec<String> = h.disks.iter().map(|d| format!("{{ {}, {}, {} }}", num(d[0]), num(d[1]), num(d[2]))).collect();
			format!("\t\t{{ id = {}, side = {}, name = {}, areaId = {}, disks = {{ {} }} }},", lua_str(&js_str(&h.id)), lua_str(&h.side), lua_str(&js_str(&h.name)), num(h.area_id), disks.join(", "))
		})
		.collect();
	let mut meta: Vec<String> = vec![gen.to_string()];
	meta.extend(CREDIT.iter().map(|s| s.to_string()));
	meta.push(format!("-- Map {map} ({}), ADT rows {}-{} x cols {}-{}.", map_name(map), 31 - cg.cx0 - cg.nx as i32 + 1, 31 - cg.cx0, 31 - cg.cy0 - cg.ny as i32 + 1, 31 - cg.cy0));
	meta.extend(HEADER.iter().map(|s| s.to_string()));
	meta.push(format!("{global} = {global} or {{}}"));
	meta.push(String::new());
	meta.push("---@type SPFNavData".into());
	meta.push("-- stylua: ignore".into());
	meta.push(format!("{global}[{map}] = {{"));
	if classed {
		meta.push(format!("\tformat = {},", if areaed { 3 } else { 2 }));
		meta.push("\tprofiles = { \"Alliance\", \"Horde\" },".into());
	}
	meta.push(format!("\tcx0 = {},", cg.cx0));
	meta.push(format!("\tcy0 = {},", cg.cy0));
	meta.push(format!("\tnx = {},", cg.nx));
	meta.push(format!("\tny = {},", cg.ny));
	meta.push(format!("\tcells = {},", cg.c));
	meta.push(format!("\tswim = {:.6},", SWIM));
	meta.push(format!("\tzstep = {ZQ},"));
	if classed {
		if hub_lines.is_empty() {
			meta.push("\thubs = {},".into());
		} else {
			meta.push("\thubs = {".into());
			meta.extend(hub_lines);
			meta.push("\t},".into());
		}
	}
	for f in FIELDS {
		meta.push(format!("\t{f} = {{}},"));
	}
	if classed {
		meta.push("\tclass = {},".into());
	}
	if let Some(z) = maps.zone.as_ref().filter(|z| classed && !z.is_empty()) {
		meta.push("\tzone = {".into());
		for (k, s) in z {
			meta.push(format!("\t\t[{}] = \"{s}\",", k + 1));
		}
		meta.push("\t},".into());
	}
	if areaed {
		meta.push("\tarea = {},".into());
		meta.push("\tareaNames = {".into());
		for id in &cg.areas {
			let name = area_names.and_then(|n| n[id.to_string()][0].as_str()).unwrap_or("");
			meta.push(format!("\t\t[{id}] = {},", lua_str(name)));
		}
		meta.push("\t},".into());
	}
	meta.push(format!("\tcounts = {{ {} }},", fields.iter().map(|f| format!("{f} = {}", maps.field(f).len())).collect::<Vec<_>>().join(", ")));
	meta.push(format!("\tpacked = {{ {} }},", fields.iter().map(|f| format!("{f} = {{}}")).collect::<Vec<_>>().join(", ")));
	meta.push("}".into());
	meta.push(String::new());
	files.push((format!("Nav{map}.lua"), meta.join("\n")));
	let header = format!("{gen}\n{PART_NOTE}\n---@type SPFNavData\nlocal data = {global}[{map}]\n-- stylua: ignore start\n");
	let mut part = 1;
	let mut content = header.clone();
	let mut keys: Vec<u32> = fields.iter().flat_map(|f| maps.field(f).keys().copied()).collect();
	keys.sort_unstable();
	keys.dedup();
	let mut packed_bytes = 0;
	for k in keys {
		for field in fields {
			let Some(raw) = maps.field(field).get(&k) else { continue };
			let buf = raw.as_bytes();
			let mut blocks = Vec::new();
			if buf.is_empty() {
				blocks.push(block(buf));
			}
			for chunk in buf.chunks(BLOCK_BYTES) {
				blocks.push(block(chunk));
			}
			let line = format!("data.packed.{field}[{}] = {{{}}}\n", k + 1, blocks.iter().map(|b| format!("\"{b}\"")).collect::<Vec<_>>().join(", "));
			packed_bytes += line.len();
			if header.len() + line.len() + 32 > PART_BYTES {
				return Err(format!("pack: map {map} cluster {k} exceeds the part limit"));
			}
			if content.len() + line.len() + 32 > PART_BYTES {
				files.push((format!("Nav{map}_{part}.lua"), format!("{content}-- stylua: ignore end\n")));
				part += 1;
				content = header.clone();
			}
			content.push_str(&line);
		}
	}
	files.push((format!("Nav{map}_{part}.lua"), format!("{content}-- stylua: ignore end\n")));
	Ok((files, packed_bytes))
}

fn js_str_num(v: f64) -> String {
	forge_core::jsnum::js_to_string(v)
}
