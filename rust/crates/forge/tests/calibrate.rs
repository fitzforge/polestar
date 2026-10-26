//! `forge sim calibrate` equals the JavaScript calibrate on a committed fixture
//! (rust/tests/golden/calibrate: synthetic worlds, journal rewards and recordings).

use std::path::Path;

#[test]
fn calibrate_equals_the_js() {
	let g = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden/calibrate");
	let c = forge::calibrate::calibrate(&g.join("sim"), Some(&g.join("journal")), &g.join("recordings"), "2026-10-22T00:00:00.000Z").unwrap();
	let want = std::fs::read_to_string(g.join("params.expected.json")).unwrap();
	let got = c.text.clone();
	assert_eq!(got, want);
	assert!(c.sessions == 2 && c.est.is_some() && c.forever.is_some());
}
