//! `travel build` (travel.json, TravelData.lua, FlightPaths.lua, Polestar_Travel/*) against the
//! JavaScript's output on the data golden, client table slices, the shipped and a synthetic local
//! crossings file and synthetic walks, without a navigation grid: rust/tests/golden/travel (README).

use crate::common;

use forge_data::travel::{build, Options};

#[test]
fn travel_matches_golden() {
	let g = common::golden("travel");
	let input = g.join("input");
	let mut o = Options::new(&input);
	o.data_dir = common::golden("data").join("expected");
	o.recordings_dir = input.join("recordings");
	o.sources_dir = input.join("sources");
	o.shipped_file = Some(input.join("crossings.json"));
	o.crossings_file = input.join("local").join("crossings.json");
	o.grid_dir = None;
	let out = build(&o).unwrap();
	let want = g.join("expected");
	let mut check = common::Check::new();
	let mut names = Vec::new();
	for (name, text) in out.files() {
		check.file(&name, text, &want.join(&name));
		names.push(name);
	}
	assert!(out.travel_addon.is_some(), "the local crossings file builds Polestar_Travel");
	check.all_of(&want.join("Polestar_Travel"), &names.iter().filter_map(|n| n.strip_prefix("Polestar_Travel/").map(String::from)).collect::<Vec<_>>());
	names.push("Polestar_Travel".into());
	check.all_of(&want, &names);
	check.finish("travel build");
}
