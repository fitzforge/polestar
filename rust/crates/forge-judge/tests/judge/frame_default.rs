//! A goal or spawn with no frame `f` is on the live map, not Era (02-westfall.guide:296, Catherine
//! Leland, npc 5494 at 55.09,69.76 on Stormwind, a live spawn).
use forge_core::{MapFrames, Projector};
use forge_guide::js::V;

#[test]
#[ignore = "needs POLESTAR_V1 (a guides checkout with built data/forever)"]
fn goal_without_frame_is_live() {
	let v1 = std::env::var_os("POLESTAR_V1").expect("needs POLESTAR_V1, a guides checkout with built data/forever");
	let bytes = std::fs::read(std::path::Path::new(&v1).join("data/forever/map-frames.json")).expect("needs POLESTAR_V1/data/forever/map-frames.json");
	let proj = Projector::new(&MapFrames::from_json(&bytes).unwrap());
	let w = forge_judge::walk::wpt(&proj, &V::from(1453u32), &V::from(55.09), &V::from(69.76), &V::Null).unwrap();
	let live = forge_judge::walk::wpt(&proj, &V::from(1453u32), &V::from(55.09), &V::from(69.76), &V::from("l")).unwrap();
	assert_eq!((w.wx, w.wy), (live.wx, live.wy));
	assert!((w.wy - 765.7).abs() < 1.0 && (w.wx + 8803.9).abs() < 1.0, "{} {}", w.wx, w.wy);
}
