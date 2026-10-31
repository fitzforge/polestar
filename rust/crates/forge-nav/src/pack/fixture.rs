//! Hand-made walking maps for the addon router's tests (forge-addontest): a map of cells written as
//! `forge nav pack` writes one (format 1: no floors, no graph), then given the format 2 parts a test
//! asks for (the class field, hand-made graph records, the hubs, the zone field) as the router reads
//! them. The JS tests built the same files with tools/lib/nav/pack.js (tests/nav-router.test.js mapFiles).

use super::cells::{CellGrid, Cluster};
use super::encode::{block, encode_maps, encode_zones, pack_files, run_length};
use super::hpa::Hpa;

/// One cell of a fixture map: value (1 ground, 2 water) and class byte.
#[derive(Clone, Copy, Debug)]
pub struct FixtureCell {
	pub val: u8,
	pub cls: u8,
}

/// A fixture map: `nx` tiles along x of `cells` x `cells` cells; a cell at global g = gx * cells + gy
/// (tile g / cells², local g % cells²).
pub struct FixtureMap<'a> {
	pub map: u32,
	pub cells: usize,
	pub nx: usize,
	pub set: &'a [(usize, FixtureCell)],
	/// With the format 2 class field (one byte per node).
	pub classes: bool,
	/// Hand-made graph strings by cluster index (Routing/PathGrid.lua adjacent's records).
	pub graph: Option<&'a [Option<String>]>,
	/// The metadata's `hubs` list, as Lua.
	pub hubs: Option<&'a str>,
	/// The uiMapID of cluster k's chunk q (the zone field; a cluster of all 0 gets none).
	pub zones: Option<&'a dyn Fn(usize, usize) -> u16>,
	/// The generated-file header line.
	pub gen: &'a str,
}

/// The map's Lua files, in load order: (file name, text).
pub fn map_files(f: &FixtureMap) -> Result<Vec<(String, String)>, String> {
	let c = f.cells;
	let mut cg = CellGrid::new(c, f.nx, 1, 0, 0);
	let mut clusters: Vec<Cluster> = (0..f.nx).map(|_| Cluster::new(c * c, false)).collect();
	let mut cls: Vec<Vec<u8>> = vec![vec![0; c * c]; f.nx];
	for &(g, cell) in f.set {
		let (t, l) = (g / (c * c), g % (c * c));
		clusters[t].val[l] = cell.val;
		cls[t][l] = cell.cls;
	}
	for (k, cl) in clusters.into_iter().enumerate() {
		cg.set_cluster(k as u32, cl);
	}
	let maps = encode_maps(&cg, &Hpa::default())?;
	let (mut files, _) = pack_files(f.map, &cg, &maps, "PolestarPathData", f.gen, &[], None, None)?;
	let meta = files[0].1.clone();
	let mut edited = meta.clone();
	let mut lines: Vec<String> = Vec::new();
	if f.classes {
		edited = edited.replacen("\tfloor = {},\n", "\tfloor = {},\n\tclass = {},\n", 1);
		let start = edited.find("\tcounts = { ").ok_or("fixture: no counts")?;
		let end = start + edited[start..].find(" },").ok_or("fixture: no counts end")?;
		edited.insert_str(end, &format!(", class = {}", f.nx));
		edited = edited.replacen("floor = {} },", "floor = {}, class = {} },", 1);
		for (k, t) in cls.iter().enumerate() {
			lines.push(format!("data.packed.class[{}] = {{\"{}\"}}", k + 1, block(run_length(t).as_bytes())));
		}
	}
	if let Some(graph) = f.graph {
		edited = edited.replacen("counts = { graph = 0,", &format!("counts = {{ graph = {},", graph.iter().filter(|g| g.is_some()).count()), 1);
		for (i, g) in graph.iter().enumerate() {
			if let Some(s) = g {
				lines.push(format!("data.packed.graph[{}] = {{\"{}\"}}", i + 1, block(s.as_bytes())));
			}
		}
	}
	if let Some(h) = f.hubs {
		edited = edited.replacen("\tcounts = {", &format!("\thubs = {h},\n\tcounts = {{"), 1);
	}
	if let Some(zones) = f.zones {
		let mut rows = Vec::new();
		for k in 0..f.nx {
			let z: Vec<u16> = (0..256).map(|q| zones(k, q)).collect();
			if z.iter().any(|&v| v != 0) {
				rows.push(format!("\t\t[{}] = \"{}\",", k + 1, encode_zones(&z)?));
			}
		}
		edited = edited.replacen("\tcounts = {", &format!("\tzone = {{\n{}\n\t}},\n\tcounts = {{", rows.join("\n")), 1);
	}
	files[0].1 = edited;
	let last = files.len() - 1;
	let tail: String = lines.iter().map(|l| format!("{l}\n")).collect();
	files[last].1 = files[last].1.replacen("-- stylua: ignore end\n", &format!("{tail}-- stylua: ignore end\n"), 1);
	Ok(files)
}
