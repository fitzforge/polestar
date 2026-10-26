//! `forge nav grid`: the navigation grid (data/local/nav4) from the installed client (forge-navbuild);
//! `forge nav pack` and `forge nav check`: Polestar's walking maps in addon/Polestar_Nav (forge-nav pack).
use super::{usage, Fail};
use forge_navbuild::build::{run, Client, Opts};
use std::path::{Path, PathBuf};
use std::time::Instant;

pub(super) const USAGE: &str = "usage: forge nav grid --out <dir> [--wow <dir>] [--continents 0,1] [--force] [--threads N] [--allow-incomplete]
                     [--product <name>] [--root <dir>] [--data <dir>] [--defs <dir>]

Builds the navigation grid of every continent map-frames.json names (or --continents) from the
client's geometry: walkable surfaces, links, regions and the abstract graph per ADT tile, on
--threads threads (default 6), into --out (tiles/<c>/, graph/<c>.bin.gz, index.json, lifts.json).
A tile already built is kept unless --force. --wow: the World of Warcraft folder (default
$POLESTAR_WOW_DIR or the detected install); --product (default wow_classic_beta). --root: the
Polestar checkout (default: the nearest folder above the working directory with data/forever);
--data its game data (default <root>/data/forever), --defs the WoWDBDefs checkout (default
<root>/data/sources/wowdbdefs). An install that lacks files the continents use (stale archive
slots, files not downloaded: forge gamedata check) is refused, since the grid would be wrong
there: run Scan and Repair in the launcher, or pass --allow-incomplete.

usage: forge nav pack [--dir <grid>] [--layers <dir>] [--out <addon dir>] [--cells N] [--date YYYY-MM-DD] [--root <dir>] [--leffe <dir> [--leffe-maps 0,1,2991] [--literals zlib|base64]]

Writes Polestar's walking maps of maps 0, 1 and 2991 from the grid (--dir, default $POLESTAR_GRID,
else <root>/data/local/nav4; grid format 4) and the ground layers (--layers, default
<root>/data/local/nav-layers: roads/ and hubs.json, from forge nav layers) into the addon folder
(--out, default <root>/addon/Polestar_Nav): Nav/Nav<map>*.lua (maps format 2: a ground class per
surface, every graph edge priced per faction; format 3 with each surface's WMO group area when the
grid has its area sidecars, tiles/<c>/<tile>.area.gz and areas.json), Nav/Chokepoints.lua (lifts,
bridges, gates, tunnels, cave and building mouths, passes; from the grid, its lifts.json and
aids.json), PACK.json (grid, cells, date, sizes, sha256 of every file) and Nav/Nav.xml. --cells cuts
each ADT tile into N x N cells (8-256, default 128); --date dates the generated headers (default
today, UTC): the same grid, layers, cells and date give the same bytes. The capitals, zones and
place names come from <root>/data/forever (zones.json, map-frames.json) and the newest cached
AreaTable.csv under <root>/data/sources/wago. --leffe takes the maps from Leffe's navigation maps
instead (his format-4 Nav folder, or the folder holding it; same client build and cells): his
surfaces, floors, classes, zones and entrance graph, his jumps and drops as one-way arcs, and each
surface's area from the grid's surface nearest it (maps format 5); the chokepoints stay the grid's.
--leffe-maps names the maps taken from his (default all three); the rest stay the grid's. His
continents' map parts ship in their own load-on-demand addons beside the folder (Polestar_Nav_EK,
Polestar_Nav_Kalimdor; their metadata stays in Polestar_Nav), and their blocks as zlib bytes in the
string literals (--literals base64 keeps base64).

usage: forge nav check [--out <addon dir>] [--root <dir>]

Checks the walking maps in the addon folder (default <root>/addon/Polestar_Nav) against its
PACK.json: every listed file present and unchanged, none unlisted, Nav/Nav.xml listing them.
Exit 1 when one differs.

usage: forge nav layers roads [--c 0|1] [--allowlist] [--offline] [--wow <dir>] [--product <name>] [--root <dir>] [--defs <dir>] [--layers <dir>]

The roads layer: per grid column, the share of the ground the client paints with a road texture,
from each tile's tex0 ADT (its texture layers and alpha maps) in the installed client (--wow,
--product, --defs as for forge nav grid) and the reviewed allowlist <root>/data/road-textures.json,
the texture names from the wowdev community listfile (downloaded once to
<root>/data/sources/listfile; --offline never downloads), for maps 0 and 1 (--c: one of them), into
<layers>/roads/<c>/<col>_<row>.bin (default --layers <root>/data/local/nav-layers) and its
index.json. --allowlist instead rewrites the allowlist from every texture both maps' tiles use
(never with --c): one whose tileset path names a road, path, cobble, street or trail; one naming
dirt, footprint, brick or gravel, or listed under reviewed, when its shape is a road's (most of its
weight in long, narrow, elongated strips); with every measure (review it).

usage: forge nav layers hubs [--dir <grid>] [--root <dir>] [--layers <dir>]

The hubs layer: each faction's towns and outposts from its guards and service NPCs (quest givers,
vendors, trainers, flight masters, innkeepers, bankers, repairers) in the CMaNGOS classic-db spawns
and creature templates (the cached dump under <root>/data/sources/cmangos), judged by the client's
FactionTemplate table, clustered, named by the AreaTable area under them (the grid's area ids:
--dir, default $POLESTAR_GRID, else <root>/data/local/nav4; the tables cached for the grid's build
under <root>/data/sources/wago), into <layers>/hubs.json.";

pub fn main() {
	super::exit("nav", main2());
}

fn main2() -> Result<(), Fail> {
	let args: Vec<String> = super::args().skip(1).collect();
	match args.first().map(String::as_str) {
		Some("prepare") => return super::navprep::main2(&args[1..]),
		Some("pack") => return pack(&args[1..]),
		Some("check") => return check(&args[1..]),
		Some("layers") => return layers(&args[1..]),
		Some("grid") => {}
		Some(x) => return Err(usage(format!("unknown command {x}: grid, prepare, pack, check or layers"))),
		None => return Err(usage("a command is needed: grid, prepare, pack, check or layers")),
	}
	let mut o: std::collections::HashMap<String, String> = Default::default();
	let mut force = false;
	let mut allow_incomplete = false;
	let mut it = args[1..].iter();
	while let Some(a) = it.next() {
		match a.as_str() {
			"--force" => force = true,
			"--allow-incomplete" => allow_incomplete = true,
			// --cache/--tables/--build: a CASC cache folder (<fdid>.blp) and table CSVs instead of
			// the client (developer checks, not in the help).
			"--wow" | "--out" | "--continents" | "--threads" | "--product" | "--root" | "--data" | "--defs" | "--cache" | "--tables" | "--build" => {
				let v = it.next().ok_or_else(|| usage(format!("{a} needs a value")))?;
				o.insert(a.clone(), v.clone());
			}
			_ => return Err(usage(format!("unknown argument {a}"))),
		}
	}
	let out = PathBuf::from(o.get("--out").ok_or_else(|| usage("--out <dir> is required"))?);
	let cwd = std::env::current_dir().map_err(|e| e.to_string())?;
	let root: PathBuf = match o.get("--root") {
		Some(r) => r.into(),
		None => cwd.ancestors().find(|d| d.join("data/forever").is_dir()).map(Path::to_path_buf).ok_or("no data/forever above the working directory (give --root)")?,
	};
	let continents = match o.get("--continents") {
		None => None,
		Some(v) => Some(v.split(',').map(|s| s.trim().parse::<u32>().map_err(|_| usage("--continents needs map ids, e.g. 0,1"))).collect::<Result<Vec<_>, _>>()?),
	};
	let client = match o.get("--cache") {
		Some(c) => Client::Cache {
			dir: c.into(),
			tables: o.get("--tables").ok_or_else(|| usage("--cache needs --tables"))?.into(),
			build: o.get("--build").ok_or_else(|| usage("--cache needs --build"))?.clone(),
		},
		None => Client::Install {
			wow: o.get("--wow").map(PathBuf::from).or_else(forge_gamedata::find_install).ok_or("no World of Warcraft install found (give --wow)")?,
			defs: o.get("--defs").map_or_else(|| root.join("data/sources/wowdbdefs"), PathBuf::from),
		},
	};
	let opts = Opts {
		out,
		client,
		product: o.get("--product").cloned().unwrap_or_else(|| "wow_classic_beta".into()),
		data: o.get("--data").map_or_else(|| root.join("data/forever"), PathBuf::from),
		continents,
		force,
		jobs: o.get("--threads").map_or(Ok(6), |j| j.parse::<usize>().map_err(|_| usage(format!("--threads {j}: a number"))))?,
	};
	if let Client::Install { wow, defs } = &opts.client {
		let continents = forge::grid_continents(&opts.data, opts.continents.as_deref());
		if let Some(w) = forge::game_running_warning() {
			println!("warning: {w}");
		}
		forge::check_install_for_grid(wow, &opts.product, defs, &continents, allow_incomplete, &mut |m| println!("{m}"))?;
	}
	let t0 = Instant::now();
	let r = run(&opts, &|m: &str| println!("{m}"))?;
	for w in &r.warnings {
		println!("warning: {w}");
	}
	println!("nav: build {} in {:.1} s, {} warning(s)", r.build, t0.elapsed().as_secs_f64(), r.warnings.len());
	Ok(())
}

/// `--opt value` pairs of `allowed` (every other argument is a usage error).
fn options(args: &[String], allowed: &[&str]) -> Result<std::collections::HashMap<String, String>, Fail> {
	let mut o = std::collections::HashMap::new();
	let mut it = args.iter();
	while let Some(a) = it.next() {
		if !allowed.contains(&a.as_str()) {
			return Err(usage(format!("unknown argument {a}")));
		}
		let v = it.next().ok_or_else(|| usage(format!("{a} needs a value")))?;
		o.insert(a.clone(), v.clone());
	}
	Ok(o)
}

/// --root, else the nearest folder above the working directory with data/forever.
fn root_of(o: &std::collections::HashMap<String, String>) -> Result<PathBuf, Fail> {
	match o.get("--root") {
		Some(r) => Ok(r.into()),
		None => {
			let cwd = std::env::current_dir().map_err(|e| e.to_string())?;
			Ok(cwd.ancestors().find(|d| d.join("data/forever").is_dir()).map(Path::to_path_buf).ok_or("no data/forever above the working directory (give --root)")?)
		}
	}
}

/// The newest cached AreaTable.csv under <root>/data/sources/wago (the builds compared by their
/// numbers).
fn newest_area_table(root: &Path) -> Result<PathBuf, Fail> {
	let wago = root.join("data/sources/wago");
	let mut builds: Vec<String> =
		std::fs::read_dir(&wago).into_iter().flatten().filter_map(|e| e.ok()?.file_name().into_string().ok()).filter(|b| wago.join(b).join("AreaTable.csv").is_file()).collect();
	let key = |b: &str| -> Vec<u64> { b.split('.').map(|p| p.parse().unwrap_or(0)).collect() };
	builds.sort_by_key(|a| key(a));
	let b = builds.pop().ok_or_else(|| format!("no AreaTable.csv under {} (forge data build)", wago.display()))?;
	Ok(wago.join(b).join("AreaTable.csv"))
}

/// Today's date (UTC), YYYY-MM-DD.
fn today() -> String {
	let days = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map_or(0, |d| d.as_secs() / 86_400) as i64;
	let z = days + 719_468;
	let era = z.div_euclid(146_097);
	let doe = z - era * 146_097;
	let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let d = doy - (153 * mp + 2) / 5 + 1;
	let m = if mp < 10 { mp + 3 } else { mp - 9 };
	let y = yoe + era * 400 + i64::from(m <= 2);
	format!("{y:04}-{m:02}-{d:02}")
}

fn pack(args: &[String]) -> Result<(), Fail> {
	let o = options(args, &["--dir", "--layers", "--out", "--cells", "--date", "--root", "--leffe", "--leffe-maps", "--literals"])?;
	let cells: usize = match o.get("--cells") {
		None => 128,
		Some(v) => v.parse().ok().filter(|n| (8..=256).contains(n)).ok_or_else(|| usage("--cells needs a whole number from 8 to 256"))?,
	};
	let leffe: Option<(PathBuf, Vec<u32>)> = match o.get("--leffe") {
		None if o.contains_key("--leffe-maps") => return Err(usage("--leffe-maps needs --leffe")),
		None => None,
		Some(d) => {
			let maps: Vec<u32> = match o.get("--leffe-maps") {
				None => forge_nav::pack::MAPS.to_vec(),
				Some(v) => {
					v.split(',').map(|m| m.trim().parse().ok().filter(|m| forge_nav::pack::MAPS.contains(m))).collect::<Option<_>>().ok_or_else(|| usage("--leffe-maps needs maps among 0,1,2991"))?
				}
			};
			Some((PathBuf::from(d), maps))
		}
	};
	let zlib_literals = match o.get("--literals").map(String::as_str) {
		None | Some("zlib") => leffe.is_some(),
		Some("base64") => false,
		Some(_) => return Err(usage("--literals needs zlib or base64")),
	};
	let date = o.get("--date").cloned().unwrap_or_else(today);
	let ok_date = date.len() == 10 && date.bytes().enumerate().all(|(n, b)| if n == 4 || n == 7 { b == b'-' } else { b.is_ascii_digit() });
	if !ok_date {
		return Err(usage("--date needs YYYY-MM-DD"));
	}
	let root = root_of(&o)?;
	let grid: PathBuf = o.get("--dir").map(PathBuf::from).or_else(|| std::env::var_os("POLESTAR_GRID").map(PathBuf::from)).unwrap_or_else(|| root.join("data/local/nav4"));
	let index = grid.join("index.json");
	if !index.is_file() {
		return Err(format!("no navigation grid in {} (forge nav grid)", grid.display()).into());
	}
	let idx: serde_json::Value = serde_json::from_slice(&std::fs::read(&index).map_err(|e| e.to_string())?).map_err(|e| format!("{}: {e}", index.display()))?;
	let version = idx["version"].as_u64().unwrap_or(0);
	if version != 4 {
		return Err(format!("{} is grid format {version}: the walking maps' classes need format 4's slope per surface; rebuild it with `forge nav grid`", grid.display()).into());
	}
	let layers = o.get("--layers").map_or_else(|| root.join("data/local/nav-layers"), PathBuf::from);
	let out = o.get("--out").map_or_else(|| root.join("addon/Polestar_Nav"), PathBuf::from);
	let area_table = newest_area_table(&root)?;
	let data = root.join("data/forever");
	let log = |m: &str| eprintln!("{m}");
	let aids = grid.join("aids.json");
	let t0 = Instant::now();
	let p = forge_nav::pack::pack_nav(&forge_nav::pack::PackIn {
		grid: &grid,
		layers: &layers,
		area_table: &area_table,
		zones: &data.join("zones.json"),
		map_frames: &data.join("map-frames.json"),
		aids: aids.is_file().then_some(aids.as_path()),
		cells,
		date: &date,
		continents: &forge_nav::pack::MAPS,
		generator: "forge nav pack",
		leffe: leffe.as_ref().map(|(d, m)| (d.as_path(), m.as_slice())),
		zlib_literals,
		log: &log,
	})?;
	let (written, removed) = forge_nav::pack::ship_pack(&p, &out)?;
	let bytes: u64 = written.iter().filter_map(|k| std::fs::metadata(if k.starts_with("Nav/") { out.join(k) } else { out.parent().unwrap_or(&out).join(k) }).ok()).map(|m| m.len()).sum();
	println!("nav pack: {} files, {:.1} MB at {cells} cells per tile in {} ({:.0} s)", written.len(), bytes as f64 / 1e6, out.display(), t0.elapsed().as_secs_f64());
	for r in removed {
		println!("removed {r}");
	}
	Ok(())
}

fn check(args: &[String]) -> Result<(), Fail> {
	let o = options(args, &["--out", "--root"])?;
	let out = match o.get("--out") {
		Some(d) => PathBuf::from(d),
		None => root_of(&o)?.join("addon/Polestar_Nav"),
	};
	let problems = forge_nav::pack::check_pack(&out);
	for p in &problems {
		eprintln!("forge nav check: {p}");
	}
	if !problems.is_empty() {
		return Err(format!("{} problem(s) in {}", problems.len(), out.display()).into());
	}
	println!("nav check: the walking maps match PACK.json");
	Ok(())
}

fn layers(args: &[String]) -> Result<(), Fail> {
	match args.first().map(String::as_str) {
		Some("roads") => roads_layer(&args[1..]),
		Some("hubs") => hubs_layer(&args[1..]),
		Some(x) => Err(usage(format!("unknown nav layer {x} (roads, hubs)"))),
		None => Err(usage("nav layers needs a layer: roads or hubs")),
	}
}

/// The wowdev community listfile (FileDataID -> client path; build time only, never shipped).
const LISTFILE_URL: &str = "https://github.com/wowdev/wow-listfile/releases/latest/download/community-listfile.csv";

/// The cached listfile, downloaded first when missing (never with --offline).
fn ensure_listfile(root: &Path, offline: bool) -> Result<PathBuf, Fail> {
	let file = root.join("data/sources/listfile/community-listfile.csv");
	if file.is_file() {
		return Ok(file);
	}
	if offline {
		return Err(format!("--offline: missing cached {}", file.display()).into());
	}
	println!("fetching {LISTFILE_URL}");
	let resp = ureq::get(LISTFILE_URL).call().map_err(|e| format!("{LISTFILE_URL}: {e}"))?;
	let dir = file.parent().unwrap();
	std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	let tmp = dir.join(format!("community-listfile.csv.{}.tmp", std::process::id()));
	let mut out = std::fs::File::create(&tmp).map_err(|e| format!("{}: {e}", tmp.display()))?;
	let copied = std::io::copy(&mut resp.into_body().into_reader(), &mut out);
	if let Err(e) = copied {
		let _ = std::fs::remove_file(&tmp);
		return Err(format!("{LISTFILE_URL}: {e}").into());
	}
	std::fs::rename(&tmp, &file).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok(file)
}

fn roads_layer(args: &[String]) -> Result<(), Fail> {
	let (mut allowlist, mut offline) = (false, false);
	let mut rest = Vec::new();
	for a in args {
		match a.as_str() {
			"--allowlist" => allowlist = true,
			"--offline" => offline = true,
			_ => rest.push(a.clone()),
		}
	}
	// --cache/--tables/--build: a CASC cache folder (<fdid>.blp) and table CSVs instead of the client
	// (developer checks, not in the help).
	let o = options(&rest, &["--c", "--wow", "--product", "--root", "--defs", "--layers", "--cache", "--tables", "--build"])?;
	if let Some(c) = o.get("--c") {
		if c != "0" && c != "1" {
			return Err(usage("--c needs 0 or 1"));
		}
	}
	// The allowlist is one file for both maps: rewritten from one map's textures it would drop the other's.
	if allowlist && o.contains_key("--c") {
		return Err(usage("--allowlist reads both maps' textures: leave out --c"));
	}
	let continents: Vec<u32> = match o.get("--c") {
		Some(c) => vec![c.parse().unwrap()],
		None => vec![0, 1],
	};
	let root = root_of(&o)?;
	let (src, tables, build): (Box<dyn forge_navbuild::geom::Source>, forge_navbuild::geom::Tables, String) = match o.get("--cache") {
		Some(dir) => {
			let tdir = PathBuf::from(o.get("--tables").ok_or_else(|| usage("--cache needs --tables"))?);
			let t = forge_navbuild::geom::Tables::from_csv(|name| {
				std::fs::read_to_string(tdir.join(format!("{name}.csv")))
					.or_else(|_| if name == "Map" { Err(format!("{name}.csv: missing")) } else { Ok("ID\n".into()) })
					.map_err(|e| format!("{name}.csv: {e}"))
			})?;
			(Box::new(forge_navbuild::geom::CacheDir(dir.into())), t, o.get("--build").ok_or_else(|| usage("--cache needs --build"))?.clone())
		}
		None => {
			let wow = o.get("--wow").map(PathBuf::from).or_else(forge_gamedata::find_install).ok_or("no World of Warcraft install found (give --wow)")?;
			let product = o.get("--product").cloned().unwrap_or_else(|| "wow_classic_beta".into());
			let defs = o.get("--defs").map_or_else(|| root.join("data/sources/wowdbdefs"), PathBuf::from);
			let client = forge_gamedata::Client::open(&wow, &product, &defs)?;
			let t = forge_navbuild::geom::Tables::from_csv(|name| {
				let t = client.table(name, "enUS")?;
				String::from_utf8(forge_gamedata::csv::write_table(&t)).map_err(|e| format!("{name}: {e}"))
			})?;
			let build = client.storage.version.clone();
			(Box::new(forge_navbuild::geom::ClientSource::open(&wow, &product)?), t, build)
		}
	};
	let listfile = ensure_listfile(&root, offline)?;
	let allow_file = root.join("data/road-textures.json");
	let log = |m: &str| eprintln!("{m}");
	let t0 = Instant::now();
	let doc: serde_json::Value = match std::fs::read(&allow_file) {
		Ok(b) => serde_json::from_slice(&b).map_err(|e| format!("{}: {e}", allow_file.display()))?,
		Err(_) if allowlist => serde_json::json!({}),
		Err(e) => return Err(format!("{}: {e}", allow_file.display()).into()),
	};
	if allowlist {
		let reviewed = doc.get("reviewed").cloned().unwrap_or_else(|| serde_json::json!([]));
		let names: Vec<String> = reviewed.as_array().into_iter().flatten().filter_map(|r| r["texture"].as_str().map(str::to_string)).collect();
		let a = forge_navbuild::roads::road_allowlist(src.as_ref(), &tables, &continents, &listfile, &names, &log)?;
		let out = forge_navbuild::roads::allowlist_doc(&a, &build, &continents, &reviewed, "forge nav layers roads --allowlist");
		std::fs::write(&allow_file, format!("{}\n", forge_navbuild::build::js_json(&out, Some("\t")))).map_err(|e| format!("{}: {e}", allow_file.display()))?;
		let mut kept: Vec<&forge_navbuild::roads::ShapeRow> = a.shapes.iter().filter(|s| s.kind != "other" || s.verdict.road).collect();
		kept.sort_by(|x, y| y.verdict.share.partial_cmp(&x.verdict.share).unwrap());
		for s in kept {
			let w = s.verdict.median_width.map_or("   -".to_string(), |w| format!("{w:5.2}"));
			println!("{} {:<6} {:>9} col {:>6} comp  width {w}  share {:.3}  {}", if s.road { "road" } else { "    " }, s.kind, s.verdict.columns, s.verdict.components, s.verdict.share, s.texture);
		}
		println!(
			"nav layers roads: {} road textures of {} used in {}{} ({:.0} s)",
			a.textures.len(),
			a.used,
			allow_file.display(),
			if a.unnamed > 0 { format!("; {} used fdids the listfile does not name", a.unnamed) } else { String::new() },
			t0.elapsed().as_secs_f64()
		);
		return Ok(());
	}
	let allow: rustc_hash::FxHashSet<String> = doc["textures"].as_array().into_iter().flatten().filter_map(|t| t.as_str()).map(forge_navbuild::roads::texture_key).collect();
	let dir = o.get("--layers").map_or_else(|| root.join("data/local/nav-layers"), PathBuf::from).join("roads");
	let stats = forge_navbuild::roads::build_roads(src.as_ref(), &tables, &build, &continents, &dir, &listfile, &allow, &log)?;
	for s in &stats {
		println!("roads {}: {} tiles, {} with road, {} road columns, {} alpha, {:.1} s", s.c, s.tiles, s.road_tiles, s.road_columns, if s.big_alpha { "8-bit" } else { "4-bit" }, s.seconds);
		for (fdid, path, n) in &s.textures {
			println!("  {n:>5} tiles  {path} ({fdid})");
		}
	}
	println!("nav layers roads {build}: in {} ({:.0} s)", dir.display(), t0.elapsed().as_secs_f64());
	Ok(())
}

fn hubs_layer(args: &[String]) -> Result<(), Fail> {
	let o = options(args, &["--dir", "--root", "--layers"])?;
	let root = root_of(&o)?;
	let grid_dir: PathBuf = o.get("--dir").map(PathBuf::from).or_else(|| std::env::var_os("POLESTAR_GRID").map(PathBuf::from)).unwrap_or_else(|| root.join("data/local/nav4"));
	if !grid_dir.join("index.json").is_file() {
		return Err(format!("no navigation grid at {} (its area ids name the hubs): run forge nav grid", grid_dir.display()).into());
	}
	let grid = forge_nav::grid::Grid::open(&grid_dir, 64)?;
	let build = grid.index["build"].as_str().unwrap_or("").to_string();
	let t0 = Instant::now();
	let table = |name: &str| -> Result<Vec<rustc_hash::FxHashMap<String, String>>, Fail> {
		let f = root.join("data/sources/wago").join(&build).join(format!("{name}.csv"));
		let text = std::fs::read_to_string(&f).map_err(|e| format!("{}: {e} (the grid's build {build}: cache its tables with forge data build)", f.display()))?;
		Ok(forge_nav::hubs::csv_rows(&text))
	};
	let factions = table("FactionTemplate")?;
	let areas = table("AreaTable")?;
	let sources = root.join("data/sources");
	let to_json = |v: &forge_guide::js::V| -> Result<serde_json::Value, String> { serde_json::from_str(&forge_guide::js::stringify(v, None)).map_err(|e| e.to_string()) };
	let spawns = to_json(&forge_data::cmangos::load_spawn_heights(&sources, false)?.npc)?;
	let templates = to_json(&forge_data::cmangos::load_creature_templates(&sources)?)?;
	let data = root.join("data/forever");
	let read =
		|f: &str| -> Result<serde_json::Value, String> { serde_json::from_slice(&std::fs::read(data.join(f)).map_err(|e| format!("{}: {e}", data.join(f).display()))?).map_err(|e| e.to_string()) };
	let frames = forge_nav::pack::layers::Frames::new(&read("map-frames.json")?, read("zones.json")?);
	let area_at = |c: u32, x: f64, y: f64| -> u32 {
		let (col, row, i, j) = forge_nav::grid::cell_of(x, y);
		grid.tile(c, col, row).map_or(0, |t| t.areas[((j >> 4) * 16 + (i >> 4)) as usize] as u32)
	};
	let zone_at = |c: u32, x: f64, y: f64| frames.zone_area_at(c, x, y);
	let maps: Vec<u32> = forge_nav::hubs::HUB_MAPS.iter().copied().filter(|c| !grid.index["continents"][c.to_string()].is_null()).collect();
	let out = forge_nav::hubs::build_hubs(&forge_nav::hubs::HubsIn {
		spawns: &spawns,
		templates: &templates,
		faction_templates: &factions,
		area_table: &areas,
		area_at: &area_at,
		zone_at: Some(&zone_at),
		maps: &maps,
	})?;
	let file = o.get("--layers").map_or_else(|| root.join("data/local/nav-layers"), PathBuf::from).join("hubs.json");
	std::fs::create_dir_all(file.parent().unwrap()).map_err(|e| format!("{}: {e}", file.display()))?;
	let tmp = file.with_extension("json.tmp");
	std::fs::write(&tmp, forge_nav::hubs::hubs_doc(&out, &build, forge_data::cmangos::DB_REV, &maps)).map_err(|e| format!("{}: {e}", tmp.display()))?;
	std::fs::rename(&tmp, &file).map_err(|e| format!("{}: {e}", file.display()))?;
	for (c, list) in &out {
		let side = |s: &str| list.iter().filter(|h| h["side"] == s).count();
		println!("hubs {c}: {} ({} Alliance, {} Horde)", list.len(), side("Alliance"), side("Horde"));
		for h in list {
			println!(
				"  {:<8} {} ({} guards, {} services, {} disks)",
				h["side"].as_str().unwrap_or(""),
				h["name"].as_str().unwrap_or(""),
				h["guards"],
				h["services"],
				h["disks"].as_array().map_or(0, Vec::len)
			);
		}
	}
	println!("nav layers hubs {build}: {} ({:.0} s)", file.display(), t0.elapsed().as_secs_f64());
	Ok(())
}
