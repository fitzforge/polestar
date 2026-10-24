//! `forge nav prepare`: the road masks, walk graphs (one per faction) and zone mixes the walks stage
//! routes on, built where missing into <grid>/walk/ (forge-nav prepare).
use super::{usage, Fail};
use std::path::{Path, PathBuf};
use std::time::Instant;

pub const USAGE: &str = "usage: forge nav prepare [--dir <grid>] [--continents 0,1] [--threads N] [--root <dir>] [--layers <dir>]

Builds what is missing of each continent's road mask (roads-<c>-<tag>.bin, from the roads layer),
walk graphs (<c>-0-<sha>.f32 for no faction, Alliance and Horde) and zone mix (<c>-0-<sha>.mix)
into <grid>/walk/ (default: $POLESTAR_GRID, else <root>/data/local/nav4), on --threads threads
(default 6). --root: the Polestar checkout (default: the nearest folder above the working
directory with data/forever): its data/forever/zones.json and newest cached Forever AreaTable
(data/sources/wago) give the zones. --layers: the optional ground layers (roads/, hubs.json;
default <root>/data/local/nav-layers, made by `polestar nav layers`); without them walks have no
road preference and no hostile-town avoidance.";

/// `args`: the arguments after `prepare`.
pub fn main2(args: &[String]) -> Result<(), Fail> {
	let mut o: std::collections::HashMap<String, String> = Default::default();
	let mut it = args.iter();
	while let Some(a) = it.next() {
		match a.as_str() {
			"--dir" | "--continents" | "--threads" | "--root" | "--layers" => {
				let v = it.next().ok_or_else(|| usage(format!("{a} needs a value")))?;
				o.insert(a.clone(), v.clone());
			}
			_ => return Err(usage(format!("unknown argument {a}"))),
		}
	}
	let cwd = std::env::current_dir().map_err(|e| e.to_string())?;
	let root: PathBuf = match o.get("--root") {
		Some(r) => r.into(),
		None => cwd.ancestors().find(|d| d.join("data/forever").is_dir()).map(Path::to_path_buf).ok_or("no data/forever above the working directory (give --root)")?,
	};
	let grid: PathBuf = o.get("--dir").map(PathBuf::from).or_else(|| std::env::var_os("POLESTAR_GRID").map(PathBuf::from)).unwrap_or_else(|| root.join("data/local/nav4"));
	if !grid.join("index.json").is_file() {
		return Err(format!("no grid in {} (forge nav grid)", grid.display()).into());
	}
	let layers = o.get("--layers").map_or_else(|| root.join("data/local/nav-layers"), PathBuf::from);
	let continents = match o.get("--continents") {
		None => None,
		Some(v) => Some(v.split(',').map(|s| s.trim().parse::<u32>().map_err(|_| usage("--continents needs map ids, e.g. 0,1"))).collect::<Result<Vec<_>, _>>()?),
	};
	let threads = o.get("--threads").map_or(Ok(6), |j| j.parse::<usize>().map_err(|_| usage(format!("--threads {j}: a number"))))?;
	let build = forge_world::data::forever_build(&forge_world::data::DirSource::repo(&root)).ok_or("no cached Forever AreaTable in data/sources/wago")?;
	let area_table = root.join(format!("data/sources/wago/{build}/AreaTable.csv"));
	let t0 = Instant::now();
	let log = |m: &str| eprintln!("{m}");
	let out = forge_nav::prepare::prepare(&forge_nav::prepare::PrepareIn {
		grid: &grid,
		roads: &layers.join("roads"),
		hubs: &layers.join("hubs.json"),
		area_table: &area_table,
		zones: &root.join("data/forever/zones.json"),
		continents,
		threads,
		log: &log,
	})?;
	let built: Vec<_> = out.iter().filter(|b| b.built).collect();
	println!(
		"nav prepare: {} built ({:.0} s), {} kept, in {} ({:.1} s)",
		built.len(),
		built.iter().map(|b| b.seconds).sum::<f64>(),
		out.len() - built.len(),
		grid.display(),
		t0.elapsed().as_secs_f64()
	);
	Ok(())
}
