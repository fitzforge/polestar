//! The walking-map writer's maps on Polestar's router (ported from the router-side cases of
//! tests/navmesh-pack.test.js): the nav-pack golden (forge nav pack's output on the nav-grid golden's synthetic
//! scenes, rust/tests/golden/nav-pack) loaded with Polestar_Nav's Routing. A house's walls close the steps
//! through them and its door opens them, a ramp leads onto an upper floor and onto a sheer plateau, an
//! enclosure no wall opens is unreachable, a Horde walk into an Alliance hub reports it, and the graph's
//! per-profile costs agree across the APIs. The writer's own rules are forge-nav's tests (tests/pack).

use forge_addontest::run::{addons_dir, root, toc_entries};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

/// Polestar_Nav's Routing and API.lua with the golden's map files (map 0, PolestarPathData).
fn golden_nav() -> Addon {
	let mut files: Vec<String> = toc_entries(&addons_dir().join("Polestar_Nav")).unwrap().into_iter().filter(|f| !f.ends_with(".xml")).collect();
	let dir = root().join("rust/tests/golden/nav-pack/Polestar_Nav/Nav");
	for f in ["Nav0.lua", "Nav0_1.lua"] {
		files.push(dir.join(f).to_string_lossy().into_owned());
	}
	Addon::Files("Polestar_Nav".into(), files)
}

/// The scenes' coordinates: E east and S south from tile (32, 32)'s north-west corner (x = -S, y = -E).
fn p(e: f64, s: f64, z: Option<f64>) -> String {
	match z {
		Some(z) => format!("{{ x = {}, y = {}, z = {z} }}", -s, -e),
		None => format!("{{ x = {}, y = {} }}", -s, -e),
	}
}

fn run(script: &str) -> Value {
	let full = format!(
		r#"
local Path = Polestar_NavEngine
local frames = {{}}
Path.after = function(fn) frames[#frames + 1] = fn end
local function pts(list) if not list then return nil end local out = {{}} for i, q in ipairs(list) do out[i] = {{ -q.y, -q.x }} end return out end
local out = {{}}
{script}
emit(out)"#
	);
	emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], addons: vec![golden_nav()], script: full, ..Default::default() }).remove(0)
}

fn points(v: &Value) -> Vec<(f64, f64)> {
	v.as_array().unwrap_or_else(|| panic!("no path: {v}")).iter().map(|q| (q[0].as_f64().unwrap(), q[1].as_f64().unwrap())).collect()
}

#[test]
fn the_golden_maps_load_and_a_walk_across_the_tiles_routes() {
	let got = run(&format!("out.available = Path.Available(0)\nlocal list, cost = Path.FindSync(0, {}, {})\nout.n, out.cost = list and #list, cost", p(60.0, 100.0, None), p(1000.0, 100.0, None)));
	assert_eq!(got["available"], true);
	assert!(got["n"].as_i64().unwrap() >= 2);
	assert!(got["cost"].as_f64().unwrap() > 0.0);
}

#[test]
fn a_wall_closes_the_steps_through_it_and_the_house_door_opens_them() {
	// The house (E 300-460, S 60-200) has a door in its west wall (E 300-303) at S 120-140.
	let got = run(&format!("local list = Path.FindSync(0, {}, {})\nout.path = pts(list)", p(250.0, 80.0, Some(0.0)), p(380.0, 130.0, Some(0.2))));
	let path = points(&got["path"]);
	let mut crossings = Vec::new();
	for w in path.windows(2) {
		let ((e0, s0), (e1, s1)) = (w[0], w[1]);
		if (e0 - 301.5) * (e1 - 301.5) < 0.0 {
			crossings.push(s0 + (s1 - s0) * (301.5 - e0) / (e1 - e0));
		}
	}
	assert!(!crossings.is_empty(), "the walk enters the house: {path:?}");
	for s in crossings {
		assert!((117.0..=143.0).contains(&s), "the walk crosses the west wall at S {s:.1}, not through the door (S 120-140)");
	}
}

#[test]
fn a_ramp_leads_onto_the_upper_floor_and_onto_the_sheer_plateau() {
	let got = run(&format!(
		"out.upper = Path.FindSync(0, {}, {}) ~= nil\nlocal list = Path.FindSync(0, {}, {})\nout.plateau = pts(list)",
		p(250.0, 80.0, Some(0.0)),
		p(420.0, 150.0, Some(6.0)),
		p(700.0, 700.0, None),
		p(980.0, 980.0, Some(30.0))
	));
	assert_eq!(got["upper"], true, "the upper floor is reached by its ramp");
	let path = points(&got["plateau"]);
	assert!(path.iter().any(|&(e, s)| (750.0..=870.0).contains(&e) && (875.0..=945.0).contains(&s)), "the walk onto the plateau climbs its ramp (E 760-860, S 880-940): {path:?}");
}

#[test]
fn an_enclosure_no_wall_opens_is_unreachable() {
	// The pen of tile (32, 33): walls 40 yd high round E 60-160, S 933-1033.
	let got = run(&format!("local list, why = Path.FindSync(0, {}, {})\nout.found, out.why = list ~= nil, why", p(250.0, 983.0, None), p(110.0, 983.0, None)));
	assert_eq!(got["found"], false, "{got}");
}

#[test]
fn a_horde_walk_into_the_alliance_keep_reports_it_and_find_findmany_and_findcost_agree() {
	let got = run(&format!(
		r#"
Path.Find(0, {a}, {b}, function(points, cost, job) out.hubs, out.cost = job and job.hubs, cost end, {{ profile = "Horde" }})
Path.FindMany(0, {a}, {{ {b} }}, function(costs) out.many = costs[1] end, {{ profile = "Horde" }})
Path.FindCost(0, {a}, {b}, function(cost) out.only = cost end, {{ profile = "Horde" }})
Path.Find(0, {a}, {b}, function(points, cost, job) out.allianceHubs = job and job.hubs end, {{ profile = "Alliance" }})
while #frames > 0 do table.remove(frames, 1)() end"#,
		a = p(300.0, 300.0, None),
		b = p(95.0, 135.0, None)
	));
	assert_eq!(got["hubs"], json!([{ "id": "1", "name": "Westvale Keep", "areaId": 9011 }]), "Horde: the Alliance keep");
	assert!(got["allianceHubs"].as_array().is_none_or(Vec::is_empty) && got["allianceHubs"].as_object().is_none_or(|o| o.is_empty()), "Alliance: its own keep is no hostile hub");
	let cost = got["cost"].as_f64().unwrap();
	assert!((got["many"].as_f64().unwrap() - cost).abs() < 1e-6, "FindMany's cost is Find's");
	assert!((got["only"].as_f64().unwrap() - cost).abs() < 1e-6, "FindCost's cost is Find's");
}
