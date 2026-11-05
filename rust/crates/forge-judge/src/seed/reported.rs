//! tests/guides-reported.test.js, in four parts (by the JS file's lines: 1-558, 559-1146, 1147-1910, 1911-end),
//! and `eng`: the tests that play the guide in the addon's engine (questGoalStatus, stepView, playGuide, ...).

use super::SeedTest;

mod eng;
mod p1;
mod p2;
mod p3;
mod p4;

pub fn tests() -> Vec<SeedTest> {
	let mut v = p1::tests();
	v.extend(p2::tests());
	v.extend(p3::tests());
	v.extend(p4::tests());
	v.extend(eng::tests());
	v
}
