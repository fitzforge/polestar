//! The world and its walks, built in Rust (forge-world + forge-nav's walk store):
//!   forge walks world <root> <grid> <simDir> <faction>  world-<faction>.json from root's data
//!   forge walks hybrid <grid walks.bin> <Leffe walks.bin> <out.bin> [slack]
//!   forge walks walks <root> <grid> <simDir> <faction> <store> <navFp> [bands]   (default: the hybrid when POLESTAR_LEFFE_NAV=<Leffe's Nav folder>, else our grid; POLESTAR_NAV=grid|leffe|hybrid)
//! Developer checks (not in the help): floors-parity <grid> <floors.json>, import-tables.
use forge_nav::floors::GridFloors;
use forge_nav::grid::Grid;
use std::path::PathBuf;
use std::sync::Arc;
use std::time::Instant;

/// A failure: exit 1.
fn die(m: &str) -> ! {
	eprintln!("forge walks: {m}");
	std::process::exit(1)
}

/// A usage error: exit 2.
fn usage(m: &str) -> ! {
	eprintln!("forge walks: {m}\n{}", super::WALKS_HELP.trim_end());
	std::process::exit(2)
}

/// `a` has at least `n` arguments, else the usage of `what`.
fn need(a: &[String], n: usize, what: &str) {
	if a.len() < n {
		usage(&format!("{what} takes {n} arguments, got {}", a.len()));
	}
}

fn read(f: &std::path::Path) -> Vec<u8> {
	std::fs::read(f).unwrap_or_else(|e| die(&format!("{}: {e}", f.display())))
}

fn floors_parity(a: &[String]) {
	need(a, 2, "floors-parity <grid> <floors.json>");
	let grid = Arc::new(Grid::open(&PathBuf::from(&a[0]), 2048).unwrap_or_else(|e| die(&e)));
	let doc: serde_json::Value = serde_json::from_slice(&read(a[1].as_ref())).unwrap_or_else(|e| die(&format!("{}: {e}", a[1])));
	let fl = GridFloors::new(grid);
	let t0 = Instant::now();
	let (mut same, mut differ) = (0, 0);
	for (k, v) in doc["floors"].as_object().unwrap_or_else(|| die(&format!("{}: no floors object", a[1]))) {
		let mut it = k.split(':').map(str::parse::<f64>);
		let (Some(Ok(c)), Some(Ok(wx)), Some(Ok(wy))) = (it.next(), it.next(), it.next()) else { die(&format!("{}: bad floor key {k}", a[1])) };
		let want: Vec<f64> = v.as_array().map(|a| a.iter().filter_map(|x| x.as_f64()).collect()).unwrap_or_default();
		let got = fl.surfaces_at(c as i64, wx, wy);
		if got == want {
			same += 1;
		} else {
			differ += 1;
			if differ <= 5 {
				eprintln!("  {k}: expected {want:?}, got {got:?}");
			}
		}
	}
	println!("floors: {same} equal, {differ} differ, {:.1} s", t0.elapsed().as_secs_f64());
	if differ > 0 {
		std::process::exit(1);
	}
}

fn world(a: &[String]) {
	need(a, 4, "world <root> <grid> <simDir> <faction>");
	let (root, grid_dir, sim) = (PathBuf::from(&a[0]), PathBuf::from(&a[1]), PathBuf::from(&a[2]));
	let faction = forge_core::Faction::parse(&a[3]).unwrap_or_else(|| usage(&format!("faction {}: horde or alliance", a[3])));
	let t0 = Instant::now();
	let (w, text) = forge_nav::stage::world(&root, &grid_dir, faction).unwrap_or_else(|e| die(&e));
	std::fs::create_dir_all(&sim).unwrap_or_else(|e| die(&format!("{}: {e}", sim.display())));
	let f = sim.join(format!("world-{}.json", faction.lower()));
	std::fs::write(&f, &text).unwrap_or_else(|e| die(&format!("{}: {e}", f.display())));
	println!("{}: {} points, {} quests, dataHash {}, {:.1} s -> {}", faction.name(), w.points.len(), w.quests.len(), w.data_hash.as_deref().unwrap_or("-"), t0.elapsed().as_secs_f64(), f.display());
}

/// The AreaTable.csv of the newest cached Forever build under root's data/sources.
fn area_table(root: &std::path::Path) -> PathBuf {
	let src = forge_world::data::DirSource::repo(root);
	let build = forge_world::data::forever_build(&src).unwrap_or_else(|| die("no cached Forever AreaTable"));
	root.join(format!("data/sources/wago/{build}/AreaTable.csv"))
}

fn pricing(root: &std::path::Path, grid: &Grid, faction: &str, grids: Vec<forge_nav::cost::ZoneGrid>) -> forge_nav::walkdoc::Pricing {
	forge_nav::stage::pricing(grid, faction, &area_table(root), &root.join("data/forever/zones.json"), grids).unwrap_or_else(|e| die(&e))
}

fn open_store(file: &std::path::Path) -> forge_nav::store::WalkStore {
	forge_nav::stage::open_store(file).unwrap_or_else(|e| die(&e))
}

fn save_store(store: &forge_nav::store::WalkStore, file: &std::path::Path) {
	let t = Instant::now();
	let n = forge_nav::stage::save_store(store, file).unwrap_or_else(|e| die(&e));
	eprintln!("store: {} answers, {:.0} MB, saved in {:.1} s", store.len(), n as f64 / 1e6, t.elapsed().as_secs_f64());
}

/// import-tables <store> <root> <grid> <world.json> <asksDir> <tablesDir>: saved router tables
/// (walktables.js, asks.js's pair order and ends) into the store under their models.
fn import_tables(a: &[String]) {
	need(a, 6, "import-tables <store> <root> <grid> <world.json> <asksDir> <tablesDir>");
	let (file, root, grid_dir, world_file, asks, tables) = (PathBuf::from(&a[0]), PathBuf::from(&a[1]), PathBuf::from(&a[2]), PathBuf::from(&a[3]), PathBuf::from(&a[4]), PathBuf::from(&a[5]));
	let grid = Grid::open(&grid_dir, 64).unwrap_or_else(|e| die(&e));
	let world = forge_nav::walkdoc::WalkWorld::from_json(&std::fs::read(&world_file).unwrap(), &[0, 1, 2991]).unwrap_or_else(|e| die(&e));
	let pr = pricing(&root, &grid, &world.faction, world.danger.clone());
	let ends_doc: serde_json::Value = serde_json::from_slice(&std::fs::read(asks.join("ends.json")).unwrap()).unwrap();
	let ends: Vec<forge_nav::store::End> = ends_doc["ends"]
		.as_array()
		.unwrap()
		.iter()
		.map(|e| forge_nav::store::End::new(e[0].as_i64().unwrap() as i32, e[1].as_f64().unwrap(), e[2].as_f64().unwrap(), e[3].as_f64(), e[4].as_f64()))
		.collect();
	let mut store = open_store(&file);
	let n0 = store.len();
	for band in [0, 10] {
		let meta: serde_json::Value = serde_json::from_slice(&std::fs::read(asks.join(format!("asks-{band}.json"))).unwrap()).unwrap();
		let n = meta["n"].as_u64().unwrap() as usize;
		let raw = std::fs::read(asks.join(format!("asks-{band}.bin"))).unwrap();
		let col = |k: usize| (0..n).map(|i| i32::from_le_bytes(raw[4 * (k * n + i)..4 * (k * n + i) + 4].try_into().unwrap())).collect::<Vec<i32>>();
		let (src, dst, dk) = (col(0), col(1), col(2));
		let bytes = std::fs::read(tables.join(format!("{}.bin", meta["key"].as_str().unwrap()))).unwrap_or_else(|_| die(&format!("band {band}: no saved table {}", meta["key"])));
		let t = forge_nav::psbn::Bin::parse(&bytes[..]).unwrap();
		let (y, c, xoff, x) = (t.f64s("y").unwrap(), t.f64s("c").unwrap(), t.u32s("xoff").unwrap(), t.f32s("x").unwrap());
		// Pairs by danger table, each under its model.
		let mut by: std::collections::BTreeMap<i32, Vec<usize>> = Default::default();
		for i in 0..n {
			by.entry(dk[i]).or_default().push(i);
		}
		for (d, idx) in by {
			let danger: Vec<(u16, f64)> = meta["dangers"][d as usize].as_object().map(|o| o.iter().map(|(k, v)| (k.parse().unwrap(), v.as_f64().unwrap())).collect()).unwrap_or_default();
			let m = store.model(&forge_nav::walker::walk_model(&pr.grid_id, &pr.profile(&danger), forge_nav::walkdoc::STYLE, pr.smooth, &pr.zones.tag));
			let pick_f = |v: &[f64]| idx.iter().map(|&i| v[i]).collect::<Vec<f64>>();
			let pick_i = |v: &[i32]| idx.iter().map(|&i| v[i]).collect::<Vec<i32>>();
			let (mut off, mut xs) = (vec![0u32], Vec::new());
			for &i in &idx {
				xs.extend_from_slice(&x[xoff[i] as usize..xoff[i + 1] as usize]);
				off.push(xs.len() as u32);
			}
			store.import_table(&pick_f(&y), &pick_f(&c), &pick_i(&src), &pick_i(&dst), &ends, m, pr.smooth, if band == 0 { Some((&off, &xs)) } else { None });
		}
		// Every pair answers from the store (a later pair with the same ends wins).
		let mut last: std::collections::HashMap<(u64, u64, i32), usize> = Default::default();
		let key = |e: &forge_nav::store::End| e.x.to_bits() ^ e.y.to_bits().rotate_left(17) ^ e.z.to_bits().rotate_left(31) ^ e.zf.to_bits().rotate_left(47);
		for i in 0..n {
			last.insert((key(&ends[src[i] as usize]), key(&ends[dst[i] as usize]), dk[i]), i);
		}
		let mut bad = 0;
		for i in 0..n {
			if last[&(key(&ends[src[i] as usize]), key(&ends[dst[i] as usize]), dk[i])] != i {
				continue;
			}
			let danger: Vec<(u16, f64)> = meta["dangers"][dk[i] as usize].as_object().map(|o| o.iter().map(|(k, v)| (k.parse().unwrap(), v.as_f64().unwrap())).collect()).unwrap_or_default();
			let m = store.model(&forge_nav::walker::walk_model(&pr.grid_id, &pr.profile(&danger), forge_nav::walkdoc::STYLE, pr.smooth, &pr.zones.tag));
			let got = store.get(&ends[src[i] as usize], &ends[dst[i] as usize], forge_nav::store::Profile { model: m, base: None });
			let want_ok = y[i] >= 0.0;
			if got.is_none_or(|g| (g.yd >= 0.0) != want_ok) {
				bad += 1;
				if bad <= 3 {
					eprintln!("  pair {i} ({} -> {}): table {} / {}, store {got:?}", src[i], dst[i], y[i], c[i]);
				}
			}
		}
		eprintln!("band {band}: {n} table pairs imported, {bad} not answered as the table holds them");
	}
	println!("imported: store {n0} -> {} answers ({} with cells)", store.len(), store.cells_kept());
	save_store(&store, &file);
}

/// walks <root> <grid> <simDir> <faction> <store> <navFingerprint> [bands]: simDir's world's walks
/// from the store (the rest routed), written as simDir/walks-<faction>.bin (stage::walks).
fn walks(a: &[String]) {
	need(a, 6, "walks <root> <grid> <simDir> <faction> <store> <navFp> [bands]");
	let (root, grid_dir, sim, faction, file, nav_fp) = (PathBuf::from(&a[0]), PathBuf::from(&a[1]), PathBuf::from(&a[2]), a[3].to_lowercase(), PathBuf::from(&a[4]), a[5].clone());
	let bands: Vec<i64> = match a.get(6) {
		Some(b) => b.split(',').map(|x| x.trim().parse().unwrap_or_else(|_| usage(&format!("bands {b}: comma-separated levels, e.g. 0,10")))).collect(),
		None => forge_nav::walkdoc::BANDS.to_vec(),
	};
	let pack_json = root.join("addon/Polestar_Nav/PACK.json");
	let pack: serde_json::Value = serde_json::from_slice(&read(&pack_json)).unwrap_or_else(|e| die(&format!("{}: {e}", pack_json.display())));
	let maps: Vec<i64> = pack["maps"].as_object().map(|m| m.keys().filter_map(|k| k.parse().ok()).collect()).unwrap_or_else(|| die(&format!("{}: no maps", pack_json.display())));
	let world_json = read(&sim.join(format!("world-{faction}.json")));
	let (at, zones) = (area_table(&root), root.join("data/forever/zones.json"));
	let log = |m: &str| eprintln!("  {m}");
	let out = forge_nav::stage::walks(&forge_nav::stage::WalksIn {
		world_json: &world_json,
		grid: &grid_dir,
		maps: &maps,
		area_table: &at,
		zones: &zones,
		store: &file,
		nav_fp: &nav_fp,
		bands: &bands,
		threads: 8,
		// Default: the hybrid when Leffe's navigation maps are given (POLESTAR_LEFFE_NAV), else the hybrid on his
		// saved walks (<store>-leffe.<ext>) when present, else our grid (stage::Nav::auto); POLESTAR_NAV forces one.
		nav: match std::env::var("POLESTAR_NAV").as_deref() {
			Ok("grid") => forge_nav::stage::Nav::Grid,
			Ok("hybrid") => match forge_nav::stage::Nav::auto(std::env::var("POLESTAR_LEFFE_NAV").ok().as_deref().map(std::path::Path::new), &file) {
				forge_nav::stage::Nav::Grid => usage("POLESTAR_NAV=hybrid needs POLESTAR_LEFFE_NAV=<Leffe's Nav folder> or his saved walks beside the store (<store>-leffe.<ext>)"),
				n => n,
			},
			Ok("leffe") => forge_nav::stage::Nav::Leffe {
				pack: std::env::var("POLESTAR_LEFFE_NAV").map(PathBuf::from).unwrap_or_else(|_| usage("POLESTAR_NAV=leffe needs POLESTAR_LEFFE_NAV=<Leffe's Nav folder>")),
				cache_mb: match std::env::var("POLESTAR_LEFFE_NAV_CACHE_MB") {
					Ok(v) => v.parse().unwrap_or_else(|_| usage(&format!("POLESTAR_LEFFE_NAV_CACHE_MB={v}: a number of megabytes"))),
					Err(_) => 1024,
				},
			},
			Ok(x) if !x.is_empty() => usage(&format!("POLESTAR_NAV={x}: grid, leffe or hybrid")),
			_ => forge_nav::stage::Nav::auto(std::env::var("POLESTAR_LEFFE_NAV").ok().as_deref().map(std::path::Path::new), &file),
		},
		log: &log,
	})
	.unwrap_or_else(|e| die(&e));
	let f = sim.join(format!("walks-{faction}.bin"));
	let tmp = f.with_extension("tmp");
	std::fs::write(&tmp, &out.bin).and_then(|()| std::fs::rename(&tmp, &f)).unwrap_or_else(|e| die(&format!("{}: {e}", f.display())));
	let mut stats = out.stats;
	stats["file"] = serde_json::json!(f);
	stats["peak"] = serde_json::json!(std::fs::read_to_string("/proc/self/status").ok().and_then(|t| t.lines().find(|l| l.starts_with("VmHWM")).map(|l| l.to_string())));
	println!("{stats}");
}

pub fn main() {
	let args: Vec<String> = super::args().collect();
	match args.get(1).map(|s| s.as_str()) {
		Some("floors-parity") => floors_parity(&args[2..]),
		Some("world") => world(&args[2..]),
		Some("import-tables") => import_tables(&args[2..]),
		Some("walks") => walks(&args[2..]),
		Some("hybrid") => {
			let a = &args[2..];
			need(a, 3, "hybrid <grid walks.bin> <Leffe walks.bin> <out.bin> [slack]");
			let slack = match a.get(3) {
				Some(v) => v.parse().unwrap_or_else(|_| usage(&format!("slack {v}: a number"))),
				None => forge_nav::hybrid::SLACK,
			};
			let (bin, stats) = forge_nav::stage::hybrid_bin(&read(a[0].as_ref()), &read(a[1].as_ref()), slack).unwrap_or_else(|e| die(&e));
			std::fs::write(&a[2], &bin).unwrap_or_else(|e| die(&format!("{}: {e}", a[2])));
			println!("{stats}");
		}
		Some(x) => usage(&format!("unknown command {x}")),
		None => usage("a command is needed"),
	}
}
