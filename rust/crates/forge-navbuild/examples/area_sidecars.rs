//! Writes the per-surface area sidecar (`<col>_<row>.area.gz`, areas.rs) beside every built tile of
//! a grid that lacks one, and the grid's areas.json (the WMOAreaTable names), without touching its
//! tiles, graph or index (so its prepared walk graphs stay valid): the tile's geometry, rasterised and its surfaces rebuilt as `forge nav grid` does,
//! must give the tile's own entry count, else the tile is reported and skipped.
//!
//!   cargo run --release -p forge-navbuild --example area_sidecars -- <wow dir> <defs dir> <grid dir> <c,c,...> [threads] [--force]

use forge_navbuild::{areas, format, geom};
use std::path::PathBuf;
use std::sync::atomic::{AtomicUsize, Ordering};

fn main() -> Result<(), String> {
	let a: Vec<String> = std::env::args().collect();
	if a.len() < 5 {
		return Err("usage: area_sidecars <wow dir> <defs dir> <grid dir> <c,c,...> [threads] [--force]".into());
	}
	let (wow, defs, grid) = (PathBuf::from(&a[1]), PathBuf::from(&a[2]), PathBuf::from(&a[3]));
	let cs: Vec<u32> = a[4].split(',').map(|v| v.parse().map_err(|e| format!("continent {v}: {e}"))).collect::<Result<_, _>>()?;
	let threads: usize = a.get(5).and_then(|v| v.parse().ok()).unwrap_or(6);
	let force = a.iter().any(|v| v == "--force");
	let product = "wow_classic_beta";
	let client = forge_gamedata::Client::open(&wow, product, &defs)?;
	let tables = geom::Tables::from_csv(|name| {
		let t = client.table(name, "enUS")?;
		String::from_utf8(forge_gamedata::csv::write_table(&t)).map_err(|e| format!("{name}: {e}"))
	})?;
	let src = geom::ClientSource::open(&wow, product)?;
	let cache = geom::ModelCache::default();
	if let Some(text) = areas::areas_json(&tables) {
		std::fs::write(grid.join("areas.json"), text).map_err(|e| e.to_string())?;
	}
	for c in cs {
		let dir = grid.join("tiles").join(c.to_string());
		let tiles: Vec<geom::TileRef> = geom::continent_tiles(&src, &tables, c)?
			.into_iter()
			.filter(|t| dir.join(format!("{}_{}.nav.gz", t.col, t.row)).exists() && (force || !dir.join(format!("{}_{}.area.gz", t.col, t.row)).exists()))
			.collect();
		let next = AtomicUsize::new(0);
		let (done, skipped, any) = (AtomicUsize::new(0), AtomicUsize::new(0), AtomicUsize::new(0));
		std::thread::scope(|s| {
			for _ in 0..threads {
				s.spawn(|| loop {
					let i = next.fetch_add(1, Ordering::Relaxed);
					let Some(t) = tiles.get(i) else { break };
					let run = || -> Result<bool, String> {
						let nav = format::decode_tile(&std::fs::read(dir.join(format!("{}_{}.nav.gz", t.col, t.row))).map_err(|e| e.to_string())?)?;
						let g = geom::tile_geometry(&src, &tables, c, t, &cache)?;
						let (tile, _) = forge_navbuild::surfaces::build_surfaces(forge_navbuild::rasterise::rasterise(&g), &g);
						if tile.n != nav.n || tile.z != nav.z {
							return Err(format!("rebuilt surfaces differ from the tile's ({} vs {} entries)", tile.n, nav.n));
						}
						let ar = areas::surface_areas(&g, &tile);
						let has = ar.iter().any(|&v| v != 0);
						let f = dir.join(format!("{}_{}.area.gz", t.col, t.row));
						let tmp = f.with_extension("gz.tmp");
						std::fs::write(&tmp, areas::encode_areas(&ar)).map_err(|e| e.to_string())?;
						std::fs::rename(&tmp, &f).map_err(|e| e.to_string())?;
						Ok(has)
					};
					match run() {
						Ok(has) => {
							done.fetch_add(1, Ordering::Relaxed);
							if has {
								any.fetch_add(1, Ordering::Relaxed);
							}
						}
						Err(e) => {
							skipped.fetch_add(1, Ordering::Relaxed);
							eprintln!("continent {c} tile {}_{}: {e}", t.col, t.row);
						}
					}
				});
			}
		});
		eprintln!("continent {c}: {} sidecars written ({} with areas), {} skipped", done.into_inner(), any.into_inner(), skipped.into_inner());
	}
	Ok(())
}
