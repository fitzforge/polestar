//! tile_geometry (the client's ADT/WMO/M2 files) equals the JS tileGeometry dumps on every Zephras tile.
//! Not CI-provable: client geometry is not shareable, so no golden holds it. Opt-in with
//! POLESTAR_NAV_SCRATCH=<dir> (<dir>/sources/{casc,wago}, <dir>/NavSurfaces/out/2991) and --ignored. The stages after it (rasterise, surfaces, links, graph) are
//! proven on the committed synthetic grid (surfaces.rs, links.rs, graph.rs).
mod common;
use forge_navbuild::geom::*;
use std::path::PathBuf;

#[test]
#[ignore = "needs POLESTAR_NAV_SCRATCH (client geometry, not in the repo)"]
fn zephras_geometry_equals_the_js() {
	let scratch = std::env::var("POLESTAR_NAV_SCRATCH").expect("needs POLESTAR_NAV_SCRATCH (client geometry, not in the repo)");
	let s = PathBuf::from(scratch).join("sources");
	let dir = s.join("casc/wow_classic_beta/1.60.1.70450");
	let wago = s.join("wago/1.60.1.70450");
	let t = Tables::from_csv(|n| std::fs::read_to_string(wago.join(format!("{n}.csv"))).map_err(|e| e.to_string())).unwrap();
	let src = CacheDir(dir);
	let dumps = common::src();
	let tiles = continent_tiles(&src, &t, 2991).unwrap();
	let dumped = dumps.tiles_listed();
	assert_eq!(tiles.len(), dumped.len());
	let cache = ModelCache::default();
	let mut bad = Vec::new();
	for tr in &tiles {
		let g = tile_geometry(&src, &t, 2991, tr, &cache).unwrap();
		let w = dumps.read_geom(tr.col, tr.row);
		let bits = |v: &[f32]| v.iter().map(|x| x.to_bits()).collect::<Vec<_>>();
		let mut why = Vec::new();
		if g.kind != w.kind {
			why.push(format!("kind {} vs {}", g.kind.len(), w.kind.len()));
		}
		if bits(&g.tris) != bits(&w.tris) {
			let at = g.tris.iter().zip(&w.tris).position(|(a, b)| a.to_bits() != b.to_bits());
			why.push(format!("tris @{at:?}"));
		}
		if g.areas != w.areas {
			why.push("areas".into());
		}
		if g.liquid.ty != w.liquid.ty || bits(&g.liquid.z) != bits(&w.liquid.z) || g.liquid.deep != w.liquid.deep {
			why.push("liquid".into());
		}
		if g.wmo_liquid.len() != w.wmo_liquid.len() || g.wmo_liquid.iter().zip(&w.wmo_liquid).any(|(a, b)| a.ty != b.ty || bits(&a.tris) != bits(&b.tris)) {
			why.push("wmoLiquid".into());
		}
		if g.openings.len() != w.openings.len() {
			why.push("openings".into());
		}
		if !why.is_empty() {
			bad.push(format!("{}_{}: {why:?}", tr.col, tr.row));
		}
	}
	assert!(bad.is_empty(), "{} tiles; differ: {bad:?}", tiles.len());
}
