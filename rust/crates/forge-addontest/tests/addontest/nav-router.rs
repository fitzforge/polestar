//! Polestar's walking router (addon/Polestar_Nav/Routing) prices a step by the ground class of the node it
//! enters and the player's faction (Routing/Costs.lua): on synthetic one-tile maps written by forge-nav's
//! fixture writer (forge_addontest::navmap) with a hand-made `class` field (maps format 2), a road is taken
//! while it is at most 1/0.8 = 1.25 times the straight way, a hostile hub is gone round and one's own crossed,
//! and a map without the field (format 1, 0.2.4's) routes exactly as the router did before it priced classes
//! (the base commit's Routing files, from git). The fifth argument of Find, FindCost and FindMany is today's
//! waterWalking flag or an opts table { waterWalking, profile }. Every result carries yards beside its cost,
//! a format 2 graph edge is priced per profile (hand-made edge records), Find reports the hostile hubs of the
//! map's `hubs` metadata its drawn line enters, the drawn line straightens only over ground no costlier than
//! the path it replaces, and ReuseMany keeps a batch to the profile it was priced for. With the maps' `zone`
//! field, opts.danger multiplies a step into a dangerous zone; without it every result is today's;
//! Path.ZoneAt reads a point's zone. (Ported from tests/nav-router.test.js.)

use std::collections::{BTreeMap, BTreeSet};
use std::f64::consts::SQRT_2;

use forge_addontest::navmap::{enc, encode_areas, write_map, FixtureCell, FixtureMap, MapDir};
use forge_addontest::run::{addons_dir, root, toc_entries};
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const C: usize = 128;
const CS: f64 = 1600.0 / 3.0 / C as f64;
const MAP: u32 = 7;
const X0: usize = 20;
const S: usize = 24;
const X1: usize = X0 + S;
const Y0: usize = 64;

#[derive(Clone, Copy, Debug)]
struct P {
	x: f64,
	y: f64,
}

fn at(x: f64, y: f64) -> P {
	P { x: (x + 0.5) * CS, y: (y + 0.5) * CS }
}
fn from() -> P {
	at(X0 as f64, Y0 as f64)
}
fn to() -> P {
	at(X1 as f64, Y0 as f64)
}
fn lua(p: P) -> String {
	format!("{{ x = {}, y = {}, z = 0 }}", js(p.x), js(p.y))
}
fn js(v: f64) -> String {
	// Lua reads the shortest round-trip digits as the same double.
	let s = format!("{v:?}");
	s.strip_suffix(".0").map(str::to_string).unwrap_or(s)
}

const STRAIGHT: f64 = S as f64 * CS;
fn round_len(d: usize) -> f64 {
	(S as f64 + 2.0 * d as f64 - 4.0 + 2.0 * SQRT_2) * CS
}
fn round_at(d: usize, mult: f64) -> f64 {
	(mult * (S as f64 + 2.0 * d as f64 - 5.0 + 2.0 * SQRT_2) + 1.0) * CS
}

type Cells = BTreeMap<usize, FixtureCell>;

#[derive(Clone, Copy, Default)]
struct Cls {
	val: Option<u8>,
	cls: Option<u8>,
}
fn cls(c: u8) -> Cls {
	Cls { val: None, cls: Some(c) }
}
fn val(v: u8) -> Cls {
	Cls { val: Some(v), cls: None }
}

/// The straight strip (row Y0, X0..X1) and a U of depth d above it, sharing its end cells.
fn layout(d: usize, strip: Cls, round: Cls) -> Cells {
	let mut cells = Cells::new();
	let mut set = |x: usize, y: usize, c: Cls| {
		cells.insert(x * C + y, FixtureCell { val: c.val.unwrap_or(1), cls: c.cls.unwrap_or(0) });
	};
	for x in X0..=X1 {
		set(x, Y0, if x == X0 || x == X1 { Cls::default() } else { strip });
	}
	for y in Y0 - d..Y0 {
		set(X0, y, round);
		set(X1, y, round);
	}
	for x in X0 + 1..X1 {
		set(x, Y0 - d, round);
	}
	cells
}

#[derive(Default)]
struct Opts<'a> {
	nx: usize,
	graph: Option<Vec<Option<String>>>,
	hubs: Option<String>,
	zones: Option<&'a dyn Fn(usize, usize) -> u16>,
}

fn map_files(cells: &Cells, classes: bool, o: Opts) -> MapDir {
	let set: Vec<(usize, FixtureCell)> = cells.iter().map(|(&g, &c)| (g, c)).collect();
	write_map(&FixtureMap { map: MAP, cells: C, nx: o.nx.max(1), set: &set, classes, graph: o.graph.as_deref(), hubs: o.hubs.as_deref(), zones: o.zones, gen: "-- tests/addontest/nav-router.rs" })
}

struct Q {
	id: String,
	kind: &'static str,
	opts: String,
}
fn q(id: &str, kind: &'static str, opts: &str) -> Q {
	Q { id: id.into(), kind, opts: opts.into() }
}

fn call(x: &Q) -> String {
	let id = serde_json::to_string(&x.id).unwrap();
	let o = &x.opts;
	match x.kind {
		"find" => {
			format!("Path.Find({MAP}, A, B, function(points, cost, job) out[{id}] = {{ cost = str(cost), points = flat(points), yards = job and str(job.yards), hubs = job and job.hubs }} end, {o})")
		}
		"cost" => format!("Path.FindCost({MAP}, A, B, function(cost, reason, job) out[{id}] = {{ cost = str(cost or reason), yards = job and str(job.yards) }} end, {o})"),
		"many" => format!("Path.FindMany({MAP}, A, {{ B }}, function(costs, reason, job) out[{id}] = {{ cost = str(costs[1] or reason), yards = job and job.yards and str(job.yards[1]) }} end, {o})"),
		k => panic!("{k}"),
	}
}

/// Polestar_Nav without its maps: the TOC's Routing files and API.lua.
fn ours() -> Addon {
	let files: Vec<String> = toc_entries(&addons_dir().join("Polestar_Nav")).unwrap().into_iter().filter(|f| !f.ends_with(".xml")).collect();
	Addon::Files("Polestar_Nav".into(), files)
}

/// Runs the queries on the map with the router `addon` -> { id: { cost, points?, yards?, hubs? } }.
fn route_with(addon: Addon, map: &MapDir, queries: &[Q], from: P, to: P, tail: &str) -> Value {
	let script = format!(
		r#"
local Path = Polestar_NavEngine
local frames = {{}}
Path.after = function(fn) frames[#frames + 1] = fn end
local function str(v) return type(v) == "number" and string.format("%.17g", v) or (v ~= nil and tostring(v) or nil) end
local function flat(points)
	if not points then return nil end
	local out = {{}}
	for i, p in ipairs(points) do out[i] = {{ str(p.x), str(p.y) }} end
	return out
end
local A, B = {}, {}
local out = {{}}
{}
while #frames > 0 do table.remove(frames, 1)() end
{tail}
emit(out)"#,
		lua(from),
		lua(to),
		queries.iter().map(call).collect::<Vec<_>>().join("\n")
	);
	emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], before: map.dofiles(), addons: vec![addon], script, ..Default::default() }).remove(0)
}

fn route(map: &MapDir, queries: &[Q]) -> Value {
	route_with(ours(), map, queries, from(), to(), "")
}

fn num(r: &Value) -> f64 {
	r["cost"].as_str().unwrap_or_else(|| panic!("no cost: {r}")).parse().unwrap()
}
fn close(r: &Value, want: f64, what: &str) {
	assert!((num(r) - want).abs() < 1e-9, "{what}: cost {}, want {want}", r["cost"]);
}
fn points(r: &Value) -> Vec<(f64, f64)> {
	r["points"].as_array().unwrap().iter().map(|p| (p[0].as_str().unwrap().parse().unwrap(), p[1].as_str().unwrap().parse().unwrap())).collect()
}
fn straight(r: &Value) -> bool {
	points(r).iter().all(|p| (p.1 - from().y).abs() < 1e-9)
}
fn round(r: &Value) -> bool {
	points(r).iter().any(|p| p.1 < from().y - 2.0 * CS)
}
fn drawn(r: &Value) -> f64 {
	points(r).windows(2).map(|w| (w[1].0 - w[0].0).hypot(w[1].1 - w[0].1)).sum()
}
fn yards(r: &Value) -> f64 {
	r["yards"].as_str().unwrap_or_else(|| panic!("no yards: {r}")).parse().unwrap()
}
fn yards_near(got: f64, want: f64, what: &str, tol: f64) {
	assert!((got - want).abs() <= tol, "{what}: yards {got}, want {want} (within {tol})");
}
fn empty(v: &Value) -> bool {
	v.as_object().is_some_and(|o| o.is_empty()) || v.as_array().is_some_and(|a| a.is_empty())
}

#[test]
fn costs_lua_the_ground_classes_the_multipliers_and_the_faction_profiles() {
	let got = emitted(&RunAddon {
		addons: vec![ours()],
		script: r#"
local K = Polestar_NavCosts
local function m(c, p) return K.Mult(c, p) end
local function six(t) return { t[0], t[1], t[2], t[3], t[4], t[5] } end
emit({
	class = K.CLASS, hubs = { K.HUB_ALLIANCE, K.HUB_HORDE }, hub = K.HUB, min = K.MIN, mult = six(K.MULT),
	profiles = { K.Profile("Alliance"), K.Profile("Horde"), K.Profile("Neutral") or "nil", K.Profile(nil) or "nil" },
	m = { m(0), m(1, "Horde"), m(3, "Alliance"), m(4), m(5, "Horde"), m(8 + 1, "Horde"), m(8 + 1, "Alliance"), m(8 + 1), m(16 + 3, "Alliance"), m(16 + 3, "Horde"), m(16 + 3), m(8 + 16, "Horde"), m(8 + 16, "Alliance") },
	style = { K.Style(nil), K.Style("fastest"), K.Style("roads"), K.Style("Sideways"), K.Style("balanced") },
	styles = {
		fastest = { mult = six(K.STYLES.fastest.MULT), min = K.STYLES.fastest.MIN, min2 = K.Min("fastest") },
		balanced = { mult = six(K.STYLES.balanced.MULT), min = K.STYLES.balanced.MIN, min2 = K.Min(nil) },
		roads = { mult = six(K.STYLES.roads.MULT), min = K.STYLES.roads.MIN, min2 = K.Min("roads") },
	},
	ms = { K.Mult(3, nil, "fastest"), K.Mult(1, nil, "roads"), K.Mult(8, "Horde", "roads"), K.Mult(1, "Horde", "Sideways") },
})"#
		.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(got["class"], json!({ "NORMAL": 0, "ROAD": 1, "GENTLE": 2, "STEEP": 3, "INDOOR": 4, "CITY": 5 }));
	assert_eq!(got["hubs"], json!([8, 16]));
	assert_eq!(got["hub"], 20);
	assert_eq!(got["mult"], json!([1, 0.8, 1.3, 2.5, 2, 1]));
	assert_eq!(got["min"], 0.8, "MIN is the smallest multiplier: the heuristic stays admissible");
	assert_eq!(got["profiles"], json!(["Alliance", "Horde", "nil", "nil"]));
	assert_eq!(got["m"], json!([1, 0.8, 2.5, 2, 1, 16, 0.8, 0.8, 50, 2.5, 2.5, 20, 20]));
	assert_eq!(got["style"], json!(["balanced", "fastest", "roads", "balanced", "balanced"]), "Costs.Style: anything not a style is balanced");
	assert_eq!(got["styles"]["fastest"], json!({ "mult": [1, 1, 1, 1.2, 2, 1], "min": 1, "min2": 1 }));
	assert_eq!(got["styles"]["balanced"], json!({ "mult": [1, 0.8, 1.3, 2.5, 2, 1], "min": 0.8, "min2": 0.8 }));
	assert_eq!(got["styles"]["roads"], json!({ "mult": [1, 0.5, 1.6, 4, 2, 1], "min": 0.5, "min2": 0.5 }));
	assert_eq!(got["ms"], json!([1.2, 0.5, 20, 0.8]));
	// The packer prices the graph as the router prices a step: forge-nav's table is Costs.lua's.
	for c in 0..32u8 {
		for (i, p) in forge_nav::pack::PROFILES.iter().enumerate() {
			let want = forge_nav::pack::mult(c, *p);
			let m = if c & 7 > 5 { 1.0 } else { got["mult"][(c & 7) as usize].as_f64().unwrap() };
			let hostile = (*p == Some("Horde") && c & 8 != 0) || (*p == Some("Alliance") && c & 16 != 0);
			assert_eq!(want, if hostile { m * 20.0 } else { m }, "class byte {c}, profile {i}");
		}
	}
	let toc: Vec<String> = toc_entries(&addons_dir().join("Polestar_Nav")).unwrap().iter().map(|f| f.replace('\\', "/")).collect();
	let (c, g) = (toc.iter().position(|f| f == "Routing/Costs.lua"), toc.iter().position(|f| f == "Routing/PathGrid.lua"));
	assert!(c.is_some() && c < g, "Costs.lua loads before the other Routing files");
}

#[test]
fn format_2_a_road_is_taken_while_it_is_at_most_1_25_times_the_straight_way_not_at_128_yd() {
	let road = cls(1);
	let r120 = route(
		&map_files(&layout(3, Cls::default(), road), true, Opts::default()),
		&[q("none", "find", "nil"), q("horde", "find", r#"{ profile = "Horde" }"#), q("cost", "cost", "nil"), q("many", "many", r#"{ profile = "Alliance" }"#)],
	);
	assert!(round_len(3) > 1.19 * STRAIGHT && round_len(3) < 1.21 * STRAIGHT, "the road is 120 yd");
	for id in ["none", "horde"] {
		assert!(round(&r120[id]), "{id}: by the road");
		close(&r120[id], round_at(3, 0.8), id);
	}
	close(&r120["cost"], round_at(3, 0.8), "FindCost");
	close(&r120["many"], round_at(3, 0.8), "FindMany");
	let r130 = route(&map_files(&layout(4, Cls::default(), road), true, Opts::default()), &[q("none", "find", "nil"), q("alliance", "find", r#"{ profile = "Alliance" }"#)]);
	assert!(round_len(4) > 1.28 * STRAIGHT && round_at(4, 0.8) > STRAIGHT);
	for id in ["none", "alliance"] {
		assert!(straight(&r130[id]), "{id}: the straight strip");
		close(&r130[id], STRAIGHT, id);
	}
}

fn strip_only(cells: Cells) -> Cells {
	cells.into_iter().filter(|(l, _)| l % C == Y0).collect()
}

#[test]
fn format_2_a_horde_player_goes_round_an_alliance_hub_the_alliance_player_and_no_profile_cross() {
	let queries =
		|| [q("none", "find", "nil"), q("alliance", "find", r#"{ profile = "Alliance" }"#), q("horde", "find", r#"{ profile = "Horde" }"#), q("hordeMany", "many", r#"{ profile = "Horde" }"#)];
	let alliance = route(&map_files(&layout(4, cls(8), Cls::default()), true, Opts::default()), &queries());
	assert!(round(&alliance["horde"]), "Horde: round the Alliance hub");
	close(&alliance["horde"], round_len(4), "Horde");
	close(&alliance["hordeMany"], round_len(4), "Horde, FindMany");
	for id in ["alliance", "none"] {
		assert!(straight(&alliance[id]), "{id}: through it");
		close(&alliance[id], STRAIGHT, id);
	}
	let horde = route(&map_files(&layout(4, cls(16), Cls::default()), true, Opts::default()), &queries());
	assert!(round(&horde["alliance"]));
	close(&horde["alliance"], round_len(4), "Alliance");
	for id in ["horde", "none"] {
		assert!(straight(&horde[id]));
		close(&horde[id], STRAIGHT, id);
	}
	// Crossing a hostile hub is still a route when it is the only way: x 20, never closed.
	let only = route(&map_files(&strip_only(layout(4, cls(8), Cls::default())), true, Opts::default()), &[q("horde", "find", r#"{ profile = "Horde" }"#)]);
	close(&only["horde"], (20.0 * (S as f64 - 1.0) + 1.0) * CS, "Horde through the only way");
}

#[test]
fn the_fifth_argument_a_boolean_is_waterwalking_a_table_is_opts() {
	let map = map_files(&layout(4, val(2), Cls::default()), true, Opts::default());
	let got = route(
		&map,
		&[
			q("swim", "find", "nil"),
			q("swimHorde", "find", r#"{ profile = "Horde" }"#),
			q("walk", "find", "true"),
			q("walkOpts", "find", r#"{ waterWalking = true, profile = "Horde" }"#),
			q("walkCost", "cost", "true"),
			q("walkCostOpts", "cost", "{ waterWalking = true }"),
			q("walkMany", "many", "true"),
			q("walkManyOpts", "many", r#"{ waterWalking = true, profile = "Alliance" }"#),
		],
	);
	for id in ["swim", "swimHorde"] {
		assert!(round(&got[id]), "{id}: round the water");
		close(&got[id], round_len(4), id);
	}
	for id in ["walk", "walkOpts", "walkCost", "walkCostOpts", "walkMany", "walkManyOpts"] {
		close(&got[id], STRAIGHT, id);
	}
}

/// A router of an older commit (its Routing files and API.lua from git), or None outside a checkout.
fn router_at(rev: &str, rels: &[&str]) -> Option<(TempDir, Addon)> {
	let show =
		|rel: &str| std::process::Command::new("git").arg("-C").arg(root()).arg("show").arg(format!("{rev}:addon/Polestar_Nav/{rel}")).output().ok().filter(|o| o.status.success()).map(|o| o.stdout);
	show("API.lua")?;
	let tmp = TempDir::new("polestar-router-base-");
	let dir = tmp.path().join("Polestar_Nav");
	std::fs::create_dir_all(dir.join("Routing")).unwrap();
	for rel in rels {
		std::fs::write(dir.join(rel), show(rel).unwrap_or_else(|| panic!("git show {rev}:{rel}"))).unwrap();
	}
	std::fs::write(dir.join("Polestar_Nav.toc"), format!("{}\n", rels.join("\n"))).unwrap();
	Some((tmp, Addon::dir("Polestar_Nav", dir)))
}

fn strip_new(v: &mut Value) {
	for r in v.as_object_mut().unwrap().values_mut() {
		assert!(r.get("yards").is_some(), "yards present");
		r.as_object_mut().unwrap().remove("yards");
		r.as_object_mut().unwrap().remove("hubs");
	}
}

#[test]
fn format_1_no_class_field_the_same_points_and_costs_as_the_router_before_classes_for_any_profile() {
	let Some((_tmp, before)) = router_at("f537d1d", &["Routing/PathGrid.lua", "Routing/Path.lua", "Routing/PathJobs.lua", "API.lua"]) else {
		eprintln!("skipped: no git history with f537d1d");
		return;
	};
	let ours_q = || {
		[
			q("none", "find", "nil"),
			q("horde", "find", r#"{ profile = "Horde" }"#),
			q("alliance", "find", r#"{ profile = "Alliance" }"#),
			q("walk", "find", "true"),
			q("walkOpts", "find", r#"{ waterWalking = true, profile = "Horde" }"#),
			q("cost", "cost", r#"{ profile = "Alliance" }"#),
			q("many", "many", r#"{ profile = "Horde" }"#),
			q("manyWalk", "many", "true"),
		]
	};
	let theirs = || {
		[
			q("none", "find", "nil"),
			q("horde", "find", "nil"),
			q("alliance", "find", "nil"),
			q("walk", "find", "true"),
			q("walkOpts", "find", "true"),
			q("cost", "cost", "nil"),
			q("many", "many", "nil"),
			q("manyWalk", "many", "true"),
		]
	};
	for (what, cells) in [("road", layout(3, Cls::default(), cls(1))), ("hub", layout(4, cls(8), Cls::default())), ("water", layout(4, val(2), Cls::default()))] {
		let map = map_files(&cells, false, Opts::default());
		let mut got = route(&map, &ours_q());
		let want = route_with(before.clone(), &map, &theirs(), from(), to(), "");
		strip_new(&mut got);
		assert_eq!(got, want, "{what}: identical to the router before classes");
		close(&got["none"], if what == "water" { round_len(4) } else { STRAIGHT }, what);
	}
	let bends = [bend(12, 12, 0, 2), bend(10, 10, 1, 0)];
	let r = rim();
	for (what, cells, goal) in [("90 degree bend", &bends[0].0, bends[0].1), ("45 degree bend", &bends[1].0, bends[1].1), ("rim", &r.cells, hub_to())] {
		let map = map_files(cells, false, Opts::default());
		let mut got = route_with(ours(), &map, &ours_q(), from(), goal, "");
		let want = route_with(before.clone(), &map, &theirs(), from(), goal, "");
		strip_new(&mut got);
		assert_eq!(got, want, "{what}: identical to the router before classes");
		assert_eq!(got["none"]["points"].as_array().unwrap().len(), 2, "{what}: one straight segment");
	}
}

#[test]
fn format_1_finds_yards_are_the_drawn_lines_length_findcosts_and_findmanys_the_cost_and_no_hubs() {
	for (what, cells) in [("road", layout(3, Cls::default(), cls(1))), ("water", layout(4, val(2), Cls::default()))] {
		let got = route(
			&map_files(&cells, false, Opts::default()),
			&[
				q("none", "find", "nil"),
				q("horde", "find", r#"{ profile = "Horde" }"#),
				q("walk", "find", "true"),
				q("cost", "cost", r#"{ profile = "Alliance" }"#),
				q("many", "many", r#"{ profile = "Horde" }"#),
				q("manyWalk", "many", "true"),
			],
		);
		for id in ["none", "horde", "walk"] {
			yards_near(yards(&got[id]), drawn(&got[id]), &format!("{what} {id}"), 1e-9);
			assert!(empty(&got[id]["hubs"]), "{what} {id}: no hubs");
		}
		for id in ["cost", "many", "manyWalk"] {
			assert_eq!(got[id]["yards"], got[id]["cost"], "{what} {id}: yards = cost");
		}
	}
}

#[test]
fn format_2_yards_are_the_drawn_lines_length_under_every_profile_and_findmanys_match_finds() {
	let profiles = [("none", "nil"), ("alliance", r#"{ profile = "Alliance" }"#), ("horde", r#"{ profile = "Horde" }"#)];
	for (what, cells, want) in [("road", layout(3, Cls::default(), cls(1)), [round_len(3); 3]), ("hub", layout(4, cls(8), Cls::default()), [STRAIGHT, STRAIGHT, round_len(4)])] {
		let qs: Vec<Q> = profiles.iter().flat_map(|(id, o)| [q(id, "find", o), q(&format!("{id}Many"), "many", o), q(&format!("{id}Cost"), "cost", o)]).collect();
		let got = route(&map_files(&cells, true, Opts::default()), &qs);
		for (i, (id, _)) in profiles.iter().enumerate() {
			let y = yards(&got[*id]);
			yards_near(y, drawn(&got[*id]), &format!("{what} {id}: the drawn length"), 0.5);
			yards_near(y, want[i], &format!("{what} {id}: the way walked"), 0.5);
			yards_near(yards(&got[format!("{id}Many")]), y, &format!("{what} {id}: FindMany's yards"), 0.5);
			yards_near(yards(&got[format!("{id}Cost")]), y, &format!("{what} {id}: FindCost's yards"), 0.5);
		}
		if what == "road" {
			assert!((num(&got["none"]) - yards(&got["none"])).abs() > 10.0, "road: the cost is not the yards");
		}
	}
}

fn border() -> (P, P) {
	(at(C as f64 - 12.0, Y0 as f64), at(C as f64 + 12.0, Y0 as f64))
}

/// Two tiles along x, one strip across their border; one hand-made format 2 edge each way.
fn border_files(costs: [u32; 3], yards: u32, zone: Option<&dyn Fn(usize) -> u16>) -> MapDir {
	let mut cells = Cells::new();
	for x in C - 12..=C + 12 {
		cells.insert(x * C + Y0, FixtureCell { val: 1, cls: 0 });
	}
	let e = |v: usize, w: u32| enc(v as f64, w).unwrap();
	let cluster = |lx: usize, offset: usize| -> String {
		format!("{}{}{}{}{}{}{}{}{}", e(1, 2), e(lx * C + Y0, 3), e(0, 1), e(0, 2), e(1, 1), e(offset, 1), e(0, 2), costs.iter().map(|&c| e(c as usize, 3)).collect::<String>(), e(yards as usize, 2))
	};
	let zones = zone.map(|z| move |k: usize, _q: usize| z(k));
	map_files(&cells, true, Opts { nx: 2, graph: Some(vec![Some(cluster(C - 1, 7)), Some(cluster(0, 1))]), hubs: None, zones: zones.as_ref().map(|f| f as &dyn Fn(usize, usize) -> u16) })
}

#[test]
fn format_2_the_graph_prices_an_edge_per_profile_and_adds_its_yards() {
	let (a, h, n, y) = (4u32, 84u32, 5u32, 4u32);
	let local = 23.0 * CS;
	let profiles = [("none", "nil", n), ("alliance", r#"{ profile = "Alliance" }"#, a), ("horde", r#"{ profile = "Horde" }"#, h), ("walk", "true", n)];
	let qs: Vec<Q> = profiles.iter().flat_map(|(id, o, _)| [q(id, "find", o), q(&format!("{id}Many"), "many", o), q(&format!("{id}Cost"), "cost", o)]).collect();
	let (f, t) = border();
	let got = route_with(ours(), &border_files([a, h, n], y, None), &qs, f, t, "");
	for (id, _, edge) in profiles {
		for kind in ["", "Many", "Cost"] {
			close(&got[format!("{id}{kind}")], local + edge as f64, &format!("{id}{kind}"));
		}
		yards_near(yards(&got[format!("{id}Many")]), local + y as f64, id, 1e-9);
		yards_near(yards(&got[format!("{id}Cost")]), local + y as f64, id, 1e-9);
		yards_near(yards(&got[id]), 24.0 * CS, id, 1e-6);
	}
}

#[test]
fn hubs_a_horde_route_into_an_alliance_hub_reports_it_each_once_in_path_order() {
	let strip = strip_only(layout(4, cls(8), Cls::default()));
	let mid = at(X0 as f64 + S as f64 / 2.0, Y0 as f64);
	let (fr, t) = (from(), to());
	let hubs = format!(
		"{{\n\t\t{{ id = 11, side = \"Alliance\", name = \"Astranaar\", disks = {{ {{ {}, {}, 12 }}, {{ {}, {}, 12 }} }} }},\n\t\t{{ id = 12, side = \"Alliance\", name = \"Maestra's Post\", disks = {{ {{ {}, {}, 8 }} }} }},\n\t\t{{ id = 13, side = \"Horde\", name = \"Splintertree Post\", disks = {{ {{ {}, {}, 6 }} }} }},\n\t\t{{ id = 14, side = \"Alliance\", name = \"Far away\", disks = {{ {{ {}, {}, 10 }} }} }},\n\t}}",
		js(t.x),
		js(t.y),
		js(t.x - 3.0),
		js(t.y),
		js(mid.x),
		js(mid.y + 6.0),
		js(fr.x),
		js(fr.y),
		js(fr.x),
		js(fr.y + 60.0)
	);
	let got = route(
		&map_files(&strip, true, Opts { hubs: Some(hubs.clone()), ..Default::default() }),
		&[q("horde", "find", r#"{ profile = "Horde" }"#), q("alliance", "find", r#"{ profile = "Alliance" }"#), q("none", "find", "nil")],
	);
	assert_eq!(got["horde"]["hubs"], json!([{ "id": 12, "name": "Maestra's Post" }, { "id": 11, "name": "Astranaar" }]), "Horde: the Alliance hubs entered, in path order, once each");
	assert_eq!(got["alliance"]["hubs"], json!([{ "id": 13, "name": "Splintertree Post" }]), "Alliance: only the Horde hub at the start");
	assert!(empty(&got["none"]["hubs"]), "no profile: no hub is hostile");
	let without: String = hubs.lines().filter(|l| !l.contains("id = 13")).collect::<Vec<_>>().join("\n");
	let own =
		route(&map_files(&strip, true, Opts { hubs: Some(without), ..Default::default() }), &[q("alliance", "find", r#"{ profile = "Alliance" }"#), q("horde", "find", r#"{ profile = "Horde" }"#)]);
	assert!(empty(&own["alliance"]["hubs"]), "Alliance: no hub on the same route");
	assert_eq!(own["horde"]["hubs"].as_array().unwrap().len(), 2);
}

/// The cells (gx * C + gy) a drawn line passes, sampled at 997 steps a segment.
fn crossed(r: &Value) -> BTreeSet<usize> {
	let pts: Vec<(f64, f64)> = points(r).iter().map(|p| (p.0 / CS, p.1 / CS)).collect();
	let mut out = BTreeSet::new();
	for w in pts.windows(2) {
		let ((ax, ay), (bx, by)) = (w[0], w[1]);
		for s in 0..=997 {
			let s = s as f64;
			out.insert((ax + ((bx - ax) * s) / 997.0).floor() as usize * C + (ay + ((by - ay) * s) / 997.0).floor() as usize);
		}
	}
	out
}

fn fill(cells: &mut Cells, x0: usize, x1: usize, y0: usize, y1: usize, c: u8) {
	for x in x0..=x1 {
		for y in y0..=y1 {
			cells.entry(x * C + y).or_insert(FixtureCell { val: 1, cls: c });
		}
	}
}

/// A road east along row Y0 for `east` cells, then `rise` cells on by (1, dy); `inside` the bend's ground.
fn bend(east: usize, rise: usize, dy: usize, inside: u8) -> (Cells, P) {
	let mut cells = Cells::new();
	for x in X0..=X0 + east {
		cells.insert(x * C + Y0, FixtureCell { val: 1, cls: 1 });
	}
	for i in 1..=rise {
		cells.insert((X0 + east + if dy > 0 { i } else { 0 }) * C + Y0 + i, FixtureCell { val: 1, cls: 1 });
	}
	let (ex, ey) = (X0 + east + if dy > 0 { rise } else { 0 }, Y0 + rise);
	for y in Y0 + 1..=ey {
		let x1 = if dy > 0 { X0 + east + (y - Y0 - 1) } else { X0 + east - 1 };
		fill(&mut cells, X0, x1, y, y, inside);
	}
	fill(&mut cells, X0 - 3, ex + 3, Y0 - 3, ey + 3, 0);
	(cells, at(ex as f64, ey as f64))
}

fn hub_to() -> P {
	at(X0 as f64 + 20.0, Y0 as f64 + 8.0)
}

struct Rim {
	cells: Cells,
	hubs: String,
	hub: BTreeSet<usize>,
}

fn rim() -> Rim {
	let (cx, cy, r) = (X0 as f64 + 13.0, Y0 as f64 + 3.5, 2.5);
	let mut cells = Cells::new();
	let mut hub = BTreeSet::new();
	for x in X0 - 3..=X0 + 23 {
		for y in Y0 - 3..=Y0 + 11 {
			let (nx, ny) = (cx.max(x as f64).min(x as f64 + 1.0), cy.max(y as f64).min(y as f64 + 1.0));
			let inside = (nx - cx).hypot(ny - cy) < r;
			if inside {
				hub.insert(x * C + y);
			}
			cells.insert(x * C + y, FixtureCell { val: 1, cls: if inside { 8 } else { 0 } });
		}
	}
	let hubs = format!("{{ {{ id = 21, side = \"Alliance\", name = \"Rim\", disks = {{ {{ {}, {}, {} }} }} }} }}", js(cx * CS), js(cy * CS), js(r * CS));
	Rim { cells, hubs, hub }
}

#[test]
fn straightening_keeps_a_drawn_line_on_the_road_round_a_bend() {
	for (what, east, rise, dy, inside, want) in
		[("90 degree bend, gentle inside", 12, 12, 0, 2, 0.8 * (22.0 + SQRT_2) * CS), ("45 degree bend, normal inside", 10, 10, 1, 0, 0.8 * (10.0 + 10.0 * SQRT_2) * CS)]
	{
		let (cells, goal) = bend(east, rise, dy, inside);
		let got = route_with(ours(), &map_files(&cells, true, Opts::default()), &[q("none", "find", "nil"), q("horde", "find", r#"{ profile = "Horde" }"#)], from(), goal, "");
		for id in ["none", "horde"] {
			close(&got[id], want, &format!("{what} {id}: the cost-best path is the road"));
			let off: Vec<usize> = crossed(&got[id]).into_iter().filter(|g| cells[g].cls != 1).collect();
			assert!(off.is_empty(), "{what} {id}: every cell the drawn line passes is road ({off:?})");
			assert!(points(&got[id]).len() >= 3, "{what} {id}: the bend is drawn");
		}
	}
}

#[test]
fn straightening_prices_a_segment_by_the_path_after_its_anchor() {
	let (mut cells, goal) = bend(12, 12, 0, 3);
	cells.insert(X0 * C + Y0, FixtureCell { val: 1, cls: 3 });
	let got = route_with(ours(), &map_files(&cells, true, Opts::default()), &[q("none", "find", "nil"), q("horde", "find", r#"{ profile = "Horde" }"#)], from(), goal, "");
	for id in ["none", "horde"] {
		let off: Vec<usize> = crossed(&got[id]).into_iter().filter(|g| *g != X0 * C + Y0 && cells[g].cls != 1).collect();
		assert!(off.is_empty(), "{id}: past the start, every cell the drawn line passes is road");
		assert!(points(&got[id]).len() >= 3);
	}
}

#[test]
fn straightening_never_cuts_into_a_hostile_hub_the_path_went_round() {
	let r = rim();
	let got = route_with(
		ours(),
		&map_files(&r.cells, true, Opts { hubs: Some(r.hubs.clone()), ..Default::default() }),
		&[q("horde", "find", r#"{ profile = "Horde" }"#), q("alliance", "find", r#"{ profile = "Alliance" }"#), q("none", "find", "nil")],
		from(),
		hub_to(),
		"",
	);
	let octile = (12.0 + 8.0 * SQRT_2) * CS;
	close(&got["horde"], octile, "Horde: round the rim at no extra length");
	assert!(crossed(&got["horde"]).iter().all(|g| !r.hub.contains(g)), "Horde: no drawn segment crosses a hub cell");
	assert!(empty(&got["horde"]["hubs"]));
	for id in ["alliance", "none"] {
		close(&got[id], octile, id);
		assert_eq!(points(&got[id]).len(), 2, "{id}: the corner is straightened");
		assert!(crossed(&got[id]).iter().any(|g| r.hub.contains(g)));
		assert!(empty(&got[id]["hubs"]));
	}
}

fn tail_route(cells: &Cells, zones: Option<&dyn Fn(usize, usize) -> u16>, tail: &str) -> Value {
	route_with(ours(), &map_files(cells, true, Opts { zones, ..Default::default() }), &[], from(), to(), tail)
}

#[test]
fn reusemany_reuses_a_batch_only_for_the_profile_it_was_priced_for() {
	let tail = format!(
		r#"
local job = Path.FindMany({MAP}, {{ map = {MAP}, x = A.x, y = A.y, z = A.z }}, {{ B }}, function() end, {{ profile = "Horde" }})
while #frames > 0 do table.remove(frames, 1)() end
local here = {{ map = {MAP}, x = A.x + 1, y = A.y, z = A.z }}
out.reuse = {{ horde = Path.ReuseMany(job, here, "Horde"), alliance = Path.ReuseMany(job, here, "Alliance"), none = Path.ReuseMany(job, here), neutral = Path.ReuseMany(job, here, "Neutral") }}
local nojob = Path.FindMany({MAP}, {{ map = {MAP}, x = A.x, y = A.y, z = A.z }}, {{ B }}, function() end)
while #frames > 0 do table.remove(frames, 1)() end
out.reuseNone = {{ none = Path.ReuseMany(nojob, here), neutral = Path.ReuseMany(nojob, here, "Neutral"), horde = Path.ReuseMany(nojob, here, "Horde") }}"#
	);
	let got = tail_route(&layout(4, Cls::default(), Cls::default()), None, &tail);
	assert_eq!(got["reuse"], json!({ "horde": true, "alliance": false, "none": false, "neutral": false }));
	assert_eq!(got["reuseNone"], json!({ "none": true, "neutral": true, "horde": false }));
}

#[test]
fn styles_roads_takes_a_road_1_45_times_the_straight_way_not_2_12_unknown_is_balanced() {
	let styles = [("fastest", r#""fastest""#), ("balanced", r#""balanced""#), ("roads", r#""roads""#), ("none", "nil"), ("odd", r#""Sideways""#)];
	let qs = || {
		let mut v: Vec<Q> = styles.iter().map(|(id, s)| q(id, "find", &format!(r#"{{ profile = "Horde", style = {s} }}"#))).collect();
		v.push(q("roadsMany", "many", r#"{ style = "roads" }"#));
		v
	};
	assert!(round_len(6) > 1.44 * STRAIGHT && round_len(6) < 1.46 * STRAIGHT);
	let near = route(&map_files(&layout(6, Cls::default(), cls(1)), true, Opts::default()), &qs());
	assert!(round(&near["roads"]), "Roads: the road");
	close(&near["roads"], round_at(6, 0.5), "Roads prices the road at 0.5");
	close(&near["roadsMany"], round_at(6, 0.5), "FindMany prices it the same");
	for id in ["fastest", "balanced", "none", "odd"] {
		assert!(straight(&near[id]), "{id}: straight across");
	}
	assert_eq!(near["none"], near["balanced"]);
	assert_eq!(near["odd"], near["balanced"]);
	let far = route(&map_files(&layout(14, Cls::default(), cls(1)), true, Opts::default()), &qs());
	assert!(straight(&far["roads"]), "Roads: not a road 2.12 times as long");
}

#[test]
fn styles_fastest_crosses_a_steep_strip_that_balanced_and_roads_go_round() {
	let got = route(&map_files(&layout(4, cls(3), Cls::default()), true, Opts::default()), &["fastest", "balanced", "roads"].map(|s| q(s, "find", &format!(r#"{{ style = "{s}" }}"#))));
	assert!(straight(&got["fastest"]));
	close(&got["fastest"], (23.0 * 1.2 + 1.0) * CS, "Fastest prices steep ground at 1.2");
	assert!(round(&got["balanced"]));
	close(&got["balanced"], round_len(4), "round the plain U");
	assert!(round(&got["roads"]));
}

#[test]
fn styles_a_horde_player_goes_round_an_alliance_hub_in_every_style() {
	let got =
		route(&map_files(&layout(4, cls(8), Cls::default()), true, Opts::default()), &["fastest", "balanced", "roads"].map(|s| q(s, "find", &format!(r#"{{ profile = "Horde", style = "{s}" }}"#))));
	for s in ["fastest", "balanced", "roads"] {
		assert!(round(&got[s]), "{s}: round the hostile hub");
	}
}

#[test]
fn styles_a_map_without_classes_routes_the_same_in_every_style() {
	let got = route(&map_files(&layout(3, Cls::default(), cls(1)), false, Opts::default()), &["fastest", "balanced", "roads"].map(|s| q(s, "find", &format!(r#"{{ style = "{s}" }}"#))));
	assert_eq!(got["fastest"], got["balanced"]);
	assert_eq!(got["roads"], got["balanced"]);
}

#[test]
fn reusemany_reuses_a_batch_only_for_the_style_it_was_priced_for() {
	let tail = format!(
		r#"
local job = Path.FindMany({MAP}, {{ map = {MAP}, x = A.x, y = A.y, z = A.z }}, {{ B }}, function() end, {{ profile = "Horde", style = "roads" }})
while #frames > 0 do table.remove(frames, 1)() end
local here = {{ map = {MAP}, x = A.x + 1, y = A.y, z = A.z }}
out.reuse = {{ roads = Path.ReuseMany(job, here, "Horde", "roads"), balanced = Path.ReuseMany(job, here, "Horde", "balanced"), none = Path.ReuseMany(job, here, "Horde") }}
local plain = Path.FindMany({MAP}, {{ map = {MAP}, x = A.x, y = A.y, z = A.z }}, {{ B }}, function() end, {{ profile = "Horde" }})
while #frames > 0 do table.remove(frames, 1)() end
out.reusePlain = {{ none = Path.ReuseMany(plain, here, "Horde"), balanced = Path.ReuseMany(plain, here, "Horde", "balanced"), fastest = Path.ReuseMany(plain, here, "Horde", "fastest") }}"#
	);
	let got = tail_route(&layout(4, Cls::default(), Cls::default()), None, &tail);
	assert_eq!(got["reuse"], json!({ "roads": true, "balanced": false, "none": false }));
	assert_eq!(got["reusePlain"], json!({ "none": true, "balanced": true, "fastest": false }));
}

const WPL: u16 = 1422;
const SILVERPINE: u16 = 1421;
fn zones_by_row(_k: usize, q: usize) -> u16 {
	if q % 16 >= 8 {
		WPL
	} else {
		SILVERPINE
	}
}
fn danger(t: &str) -> String {
	format!("{{ danger = {t} }}")
}

#[test]
fn danger_a_step_into_a_dangerous_zone_costs_its_multiplier() {
	assert!(round_len(4) < 3.0 * STRAIGHT);
	let map = map_files(&layout(4, Cls::default(), Cls::default()), true, Opts { zones: Some(&zones_by_row), ..Default::default() });
	let w3 = format!("{{ [{WPL}] = 3 }}");
	let s3 = format!("{{ [{SILVERPINE}] = 3 }}");
	let got = route(
		&map,
		&[
			q("none", "find", "nil"),
			q("wpl", "find", &danger(&w3)),
			q("silver", "find", &danger(&s3)),
			q("wplCost", "cost", &danger(&w3)),
			q("wplMany", "many", &danger(&w3)),
			q("silverCost", "cost", &danger(&s3)),
			q("wplHorde", "find", &format!(r#"{{ profile = "Horde", style = "roads", danger = {w3} }}"#)),
			q("noneAgain", "find", "nil"),
		],
	);
	assert!(straight(&got["none"]));
	close(&got["none"], STRAIGHT, "no danger");
	let round_wpl = (S as f64 + 2.0 * 4.0 - 5.0 + 2.0 * SQRT_2 + 3.0) * CS;
	for id in ["wpl", "wplHorde"] {
		assert!(round(&got[id]), "{id}: round the dangerous strip");
		close(&got[id], round_wpl, id);
	}
	close(&got["wplCost"], round_wpl, "FindCost");
	close(&got["wplMany"], round_wpl, "FindMany");
	assert!(straight(&got["silver"]));
	close(&got["silver"], STRAIGHT, "the strip is not dangerous");
	close(&got["silverCost"], STRAIGHT, "FindCost: the strip");
	assert_eq!(got["noneAgain"], got["none"], "no danger after danger: today's route again");
}

#[test]
fn danger_no_zone_is_closed_the_only_way_through_still_routes_at_ten_times_the_cost() {
	let w10 = danger(&format!("{{ [{WPL}] = 10 }}"));
	let got = route(
		&map_files(&strip_only(layout(4, Cls::default(), Cls::default())), true, Opts { zones: Some(&zones_by_row), ..Default::default() }),
		&[q("far", "find", &w10), q("farMany", "many", &w10), q("farCost", "cost", &w10)],
	);
	for id in ["far", "farMany", "farCost"] {
		close(&got[id], 10.0 * STRAIGHT, id);
	}
	assert!(straight(&got["far"]));
}

#[test]
fn danger_a_graph_edge_costs_its_baked_cost_times_the_larger_of_its_ends_multipliers() {
	let (a, h, n, y) = (4, 84, 5, 4);
	let zone = |k: usize| if k == 0 { SILVERPINE } else { WPL };
	let map = border_files([a, h, n], y, Some(&zone));
	let tables = [
		("wpl3", format!("{{ [{WPL}] = 3 }}"), 11 + 3 * 12, 3),
		("silver2", format!("{{ [{SILVERPINE}] = 2 }}"), 2 * 11 + 12, 2),
		("both", format!("{{ [{SILVERPINE}] = 2, [{WPL}] = 3 }}"), 2 * 11 + 3 * 12, 3),
	];
	let qs: Vec<Q> = tables.iter().flat_map(|(id, t, _, _)| [q(id, "find", &danger(t)), q(&format!("{id}Many"), "many", &danger(t)), q(&format!("{id}Cost"), "cost", &danger(t))]).collect();
	let (f, t) = border();
	let got = route_with(ours(), &map, &qs, f, t, "");
	for (id, _, cells, edge) in &tables {
		for kind in ["", "Many", "Cost"] {
			close(&got[format!("{id}{kind}")], *cells as f64 * CS + (*edge * n) as f64, &format!("{id}{kind}"));
		}
	}
}

#[test]
fn danger_straightening_never_cuts_into_a_dangerous_zone_the_path_went_round() {
	let mut cells = Cells::new();
	fill(&mut cells, X0 - 3, X0 + 23, Y0 - 3, Y0 + 11, 0);
	let zones = |_k: usize, q: usize| if q == 4 * 16 + 8 { WPL } else { SILVERPINE };
	let goal = at(X0 as f64 + 20.0, Y0 as f64 + 8.0);
	let got = route_with(
		ours(),
		&map_files(&cells, true, Opts { zones: Some(&zones), ..Default::default() }),
		&[q("none", "find", "nil"), q("wpl", "find", &danger(&format!("{{ [{WPL}] = 3 }}")))],
		from(),
		goal,
		"",
	);
	let octile = (12.0 + 8.0 * SQRT_2) * CS;
	let in_chunk = |g: &usize| (32..=39).contains(&(g / C)) && (64..=71).contains(&(g % C));
	close(&got["none"], octile, "no danger");
	assert_eq!(points(&got["none"]).len(), 2);
	assert!(crossed(&got["none"]).iter().any(in_chunk), "the straight line crosses the chunk");
	close(&got["wpl"], octile, "danger: round the chunk at no extra length");
	assert!(!crossed(&got["wpl"]).iter().any(in_chunk), "danger: no drawn segment crosses the dangerous chunk");
}

#[test]
fn danger_without_it_and_on_a_map_without_the_zone_field_results_are_todays_routers() {
	let Some((_tmp, today)) = router_at("c84f3b89", &["Routing/Costs.lua", "Routing/PathGrid.lua", "Routing/Path.lua", "Routing/PathJobs.lua", "API.lua"]) else {
		eprintln!("skipped: no git history with c84f3b89");
		return;
	};
	let base = [("none", "nil"), ("horde", r#"{ profile = "Horde" }"#), ("roads", r#"{ profile = "Alliance", style = "roads" }"#), ("walk", "true")];
	let kinds = ["find", "cost", "many"];
	let theirs: Vec<Q> = base.iter().flat_map(|(id, o)| kinds.iter().map(move |k| q(&format!("{id}-{k}"), k, o))).collect();
	let with_danger = |o: &str, d: &str| -> String {
		match o {
			"nil" => format!("{{ danger = {d} }}"),
			"true" => format!("{{ waterWalking = true, danger = {d} }}"),
			o => format!("{}, danger = {d} }}", o.strip_suffix(" }").unwrap()),
		}
	};
	let zone = |k: usize| if k == 0 { SILVERPINE } else { WPL };
	let wpl10 = format!("{{ [{WPL}] = 10 }}");
	let cases = [
		("zoned strip and U", map_files(&layout(4, Cls::default(), cls(1)), true, Opts { zones: Some(&zones_by_row), ..Default::default() }), (from(), to())),
		("zoned border graph", border_files([4, 84, 5], 4, Some(&zone)), border()),
		("no zone field", map_files(&layout(4, cls(8), Cls::default()), true, Opts::default()), (from(), to())),
	];
	for (what, map, (f, t)) in &cases {
		let want = route_with(today.clone(), map, &theirs, *f, *t, "");
		let mut tables: Vec<Option<&str>> = vec![None, Some("{}"), Some("{ [9999] = 3 }")];
		if *what == "no zone field" {
			tables.push(Some(&wpl10));
		}
		for d in tables {
			let ours_q: Vec<Q> = base.iter().flat_map(|(id, o)| kinds.iter().map(move |k| q(&format!("{id}-{k}"), k, &d.map_or(o.to_string(), |d| with_danger(o, d))))).collect();
			assert_eq!(route_with(ours(), map, &ours_q, *f, *t, ""), want, "{what}, danger {d:?}: today's results");
		}
	}
}

#[test]
fn reusemany_reuses_a_batch_only_for_the_danger_table_it_was_priced_for() {
	let tail = format!(
		r#"
local job = Path.FindMany({MAP}, {{ map = {MAP}, x = A.x, y = A.y, z = A.z }}, {{ B }}, function() end, {{ profile = "Horde", danger = {{ [{WPL}] = 3 }} }})
while #frames > 0 do table.remove(frames, 1)() end
local here = {{ map = {MAP}, x = A.x + 1, y = A.y, z = A.z }}
out.reuse = {{ same = Path.ReuseMany(job, here, "Horde", nil, {{ [{WPL}] = 3 }}), other = Path.ReuseMany(job, here, "Horde", nil, {{ [{WPL}] = 10 }}),
	more = Path.ReuseMany(job, here, "Horde", nil, {{ [{WPL}] = 3, [{SILVERPINE}] = 3 }}), none = Path.ReuseMany(job, here, "Horde") }}
local plain = Path.FindMany({MAP}, {{ map = {MAP}, x = A.x, y = A.y, z = A.z }}, {{ B }}, function() end, {{ profile = "Horde" }})
while #frames > 0 do table.remove(frames, 1)() end
out.reusePlain = {{ none = Path.ReuseMany(plain, here, "Horde"), empty = Path.ReuseMany(plain, here, "Horde", nil, {{}}), wpl = Path.ReuseMany(plain, here, "Horde", nil, {{ [{WPL}] = 3 }}) }}"#
	);
	let got = tail_route(&layout(4, Cls::default(), Cls::default()), Some(&zones_by_row), &tail);
	assert_eq!(got["reuse"], json!({ "same": true, "other": false, "more": false, "none": false }));
	assert_eq!(got["reusePlain"], json!({ "none": true, "empty": true, "wpl": false }));
}

#[test]
fn reusemany_on_a_map_without_the_zone_field_reuses_a_batch_across_danger_tables() {
	let tail = format!(
		r#"
local job = Path.FindMany({MAP}, {{ map = {MAP}, x = A.x, y = A.y, z = A.z }}, {{ B }}, function() end, {{ profile = "Horde", danger = {{ [{WPL}] = 3 }} }})
while #frames > 0 do table.remove(frames, 1)() end
local here = {{ map = {MAP}, x = A.x + 1, y = A.y, z = A.z }}
out.reuse = {{ other = Path.ReuseMany(job, here, "Horde", nil, {{ [{WPL}] = 10 }}), none = Path.ReuseMany(job, here, "Horde"), alliance = Path.ReuseMany(job, here, "Alliance", nil, {{ [{WPL}] = 3 }}) }}"#
	);
	let got = tail_route(&layout(4, Cls::default(), Cls::default()), None, &tail);
	assert_eq!(got["reuse"], json!({ "other": true, "none": true, "alliance": false }));
}

#[test]
fn path_zoneat_reads_the_uimapid_of_a_points_chunk() {
	let l = |x: f64, y: f64| lua(at(x, y));
	let tail = format!(
		r#"
local function z(m, p) return Path.ZoneAt(m, p.x, p.y) or "nil" end
out.zones = {{ strip = z({MAP}, {}), u = z({MAP}, {}), corner = z({MAP}, {}), last = z({MAP}, {}), outside = z({MAP}, {{ x = -10, y = 5 }}), nomap = z(99, {}) }}"#,
		l(X0 as f64, Y0 as f64),
		l(X0 as f64, Y0 as f64 - 4.0),
		l(127.0, 0.0),
		l(127.0, 127.0),
		l(X0 as f64, Y0 as f64)
	);
	let zones = |k: usize, q: usize| if q == 0 { 0 } else { zones_by_row(k, q) };
	let cells = layout(4, Cls::default(), Cls::default());
	let got = tail_route(&cells, Some(&zones), &tail);
	assert_eq!(got["zones"], json!({ "strip": WPL, "u": SILVERPINE, "corner": SILVERPINE, "last": WPL, "outside": "nil", "nomap": "nil" }));
	assert_eq!(tail_route(&cells, None, &tail)["zones"]["strip"], "nil", "a map without the zone field");
	let p = at(3.0, 3.0);
	let zero = tail_route(&cells, Some(&zones), &format!("out.zero = Path.ZoneAt({MAP}, {}, {}) or \"nil\"", js(p.x), js(p.y)));
	assert_eq!(zero["zero"], "nil");
}

#[test]
fn path_surfacesat_reads_a_cells_surfaces_never_decodes_one_prefetch_job_one_cluster_kept_until_releasesurfaces() {
	let mut cells = Cells::new();
	for k in 0..2 {
		cells.insert(k * C * C + 10 * C + 10, FixtureCell { val: 1, cls: 0 });
		cells.insert(k * C * C + 10 * C + 11, FixtureCell { val: 2, cls: 0 });
		cells.insert(k * C * C + 10 * C + 12, FixtureCell { val: 1, cls: 4 });
		cells.insert(k * C * C + 10 * C + 13, FixtureCell { val: 1, cls: 5 + 8 });
	}
	let map = map_files(&cells, true, Opts { nx: 2, ..Default::default() });
	let cs = js(CS);
	let tail = format!(
		r#"
local t = {{ 99, 99, [-1] = 99 }}
local function read(gx, gy)
	local n = Path.SurfacesAt({MAP}, (gx + 0.5) * {cs}, (gy + 0.5) * {cs}, t)
	return {{ n = n or "nil", z = n and n > 0 and t[1] or "-", marks = n and n > 0 and t[-1] or "-" }}
end
local function pump(budget)
	local was, clock, now, n = Path.budget, Path.clock, 0, 0
	Path.budget = budget or was
	Path.clock = function() now = now + 0.01 return now end
	while #frames > 0 do n = n + 1 table.remove(frames, 1)() end
	Path.budget, Path.clock = was, clock
	return n
end
local d0 = Path.decodes or 0
out.cold = read(10, 10)
out.sync = (Path.decodes or 0) - d0
local x, y = 10.5 * {cs}, 10.5 * {cs}
local job = Path.Prefetch({MAP}, x, y)
out.oneJob = job ~= nil and job.prefetch == true and Path.Prefetch({MAP}, x, y) == job and read(10, 10).n == "nil"
out.frames = pump(0)
out.decoded = Path.decodes - d0
out.ground = read(10, 10)
out.water = read(10, 11)
out.indoor = read(10, 12)
out.city = read(10, 13)
out.none = read(10, 20)
out.kept = t[2]
out.done = Path.Prefetch({MAP}, x, y) == nil
out.outside = {{ n = Path.SurfacesAt({MAP}, -50, 5, t), nomap = Path.SurfacesAt(99, 5, 5, t) }}
read({C} + 10, 10)
pump()
out.next = read({C} + 10, 10).n
out.left = read(10, 10).n
pump()
Path.Find({MAP}, A, B, function() end)
pump()
out.idle = {{ read(10, 10).n, read({C} + 10, 10).n }}
pump()
out.decodes = Path.decodes - d0
read(10, 10)
Path.ReleaseSurfaces()
out.released = read(10, 10).n"#
	);
	let got = route_with(ours(), &map, &[], from(), to(), &tail);
	assert_eq!(got["cold"], json!({ "n": "nil", "z": "-", "marks": "-" }), "not decoded: nil");
	assert_eq!(got["sync"], 0, "the read itself decodes nothing");
	assert_eq!(got["oneJob"], true);
	assert!(got["frames"].as_i64().unwrap() > 1, "the job decodes in slices under the frame budget");
	assert_eq!(got["decoded"], 1);
	assert_eq!(got["ground"]["n"], 1);
	assert_eq!(got["ground"]["marks"], 0);
	assert!(got["ground"]["z"].is_number());
	assert_eq!(got["water"]["marks"], 1);
	assert_eq!(got["indoor"]["marks"], 2);
	assert_eq!(got["city"]["marks"], 2, "an indoor city (class 5, here inside a hub) is indoor");
	assert_eq!(got["none"]["n"], 0);
	assert_eq!(got["outside"], json!({ "n": 0, "nomap": 0 }));
	assert_eq!(got["kept"], 99, "entries past n are left as they were");
	assert_eq!(got["done"], true);
	assert_eq!(got["next"], 1);
	assert_eq!(got["left"], "nil", "reading the next cluster dropped the one before");
	assert_eq!(got["idle"], json!([1, "nil"]), "Idle keeps the reader's cluster and drops the rest");
	assert_eq!(got["decodes"], 4, "cluster 0, 1, 0 again, 1 again");
	assert_eq!(got["released"], "nil");
}

/// Two clusters, cell (10, 10) walkable in each, for the reader's slot.
fn reader_route(tail: &str) -> Value {
	let cells: Cells = [(10 * C + 10, FixtureCell { val: 1, cls: 0 }), (C * C + 10 * C + 10, FixtureCell { val: 1, cls: 0 })].into_iter().collect();
	let cs = js(CS);
	let full = format!(
		r#"
local t = {{}}
local function read(gx) return Path.SurfacesAt({MAP}, (gx + 0.5) * {cs}, 10.5 * {cs}, t) or "nil" end
local function pump(budget, once)
	local was, clock, now = Path.budget, Path.clock, 0
	Path.budget = budget or was
	Path.clock = function() now = now + 0.01 return now end
	while #frames > 0 do
		table.remove(frames, 1)()
		if once then break end
	end
	Path.budget, Path.clock = was, clock
end
{tail}"#
	);
	route_with(ours(), &map_files(&cells, true, Opts { nx: 2, ..Default::default() }), &[], from(), to(), &full)
}

#[test]
fn path_releasesurfaces_cancels_a_prefetch_queued_or_mid_decode() {
	let got = reader_route(&format!(
		r#"
local d0 = Path.decodes or 0
read(10)
Path.ReleaseSurfaces()
pump()
out.queued = {{ decodes = (Path.decodes or 0) - d0, loaded = Path.IsLoaded({MAP}) }}
read(10)
pump(0, true)
out.started = (Path.decodes or 0) - d0
Path.ReleaseSurfaces()
pump()
out.running = Path.IsLoaded({MAP})"#
	));
	assert_eq!(got["queued"], json!({ "decodes": 0, "loaded": false }), "a queued Prefetch never runs");
	assert_eq!(got["started"], 1, "the second one had begun decoding");
	assert_eq!(got["running"], false, "and its decode never lands");
}

/// Adds maps format 3's area field to a written map's metadata: per cluster k the node row ids `nodes(k)`
/// (C * C), and the names by id.
fn with_areas(map: &MapDir, nx: usize, nodes: &dyn Fn(usize) -> Vec<u32>, names: &[(u32, &str)]) {
	let meta = &map.files[0];
	let text = std::fs::read_to_string(meta).unwrap();
	let rows: Vec<String> = (0..nx)
		.filter_map(|k| {
			let v = nodes(k);
			v.iter().any(|&a| a != 0).then(|| format!("\t\t[{}] = \"{}\",", k + 1, encode_areas(&v).unwrap()))
		})
		.collect();
	let names: Vec<String> = names.iter().map(|(id, n)| format!("\t\t[{id}] = \"{n}\",")).collect();
	let edited = text.replacen("\tcounts = {", &format!("\tarea = {{\n{}\n\t}},\n\tareaNames = {{\n{}\n\t}},\n\tcounts = {{", rows.join("\n"), names.join("\n")), 1);
	assert_ne!(edited, text, "the metadata has a counts table");
	std::fs::write(meta, edited).unwrap();
}

#[test]
fn path_surfacesat_s_areas_maps_format_3_each_surface_s_wmoareatable_row_path_areaname_its_subzone_a_map_without_the_field_gives_0() {
	let cells: Cells = [10 * C + 10, 10 * C + 11, 10 * C + 12].into_iter().map(|g| (g, FixtureCell { val: 1, cls: 0 })).collect();
	let nodes = |_k: usize| {
		let mut v = vec![0u32; C * C];
		v[10 * C + 10] = 141153; // Canals
		v[10 * C + 11] = 141120; // Trade Quarter
		v
	};
	let cs = js(CS);
	let tail = format!(
		r#"
local t, a = {{}}, {{ 7, 7, 7 }}
local function read(gx, gy)
	Path.SurfacesAt({MAP}, (gx + 0.5) * {cs}, (gy + 0.5) * {cs}, t, a)
	while #frames > 0 do table.remove(frames, 1)() end
	local n = Path.SurfacesAt({MAP}, (gx + 0.5) * {cs}, (gy + 0.5) * {cs}, t, a)
	return {{ n = n, area = a[1], name = Path.AreaName({MAP}, a[1]) or "nil" }}
end
out.format = Path.AreaFormat({MAP}) or "nil"
out.canals, out.trade, out.none = read(10, 10), read(10, 11), read(10, 12)
out.noname = Path.AreaName({MAP}, 0) or "nil""#
	);
	let map = map_files(&cells, true, Opts::default());
	with_areas(&map, 1, &nodes, &[(141153, "Canals"), (141120, "Trade Quarter")]);
	let got = route_with(ours(), &map, &[], from(), to(), &tail);
	assert_eq!(got["format"], 3);
	assert_eq!(got["canals"], json!({ "n": 1, "area": 141153, "name": "Canals" }));
	assert_eq!(got["trade"], json!({ "n": 1, "area": 141120, "name": "Trade Quarter" }));
	assert_eq!(got["none"], json!({ "n": 1, "area": 0, "name": "nil" }));
	assert_eq!(got["noname"], "nil");
	let old = route_with(ours(), &map_files(&cells, true, Opts::default()), &[], from(), to(), &tail);
	assert_eq!(old["format"], "nil", "format 2: no areas");
	assert_eq!(old["canals"], json!({ "n": 1, "area": 0, "name": "nil" }));
}

#[test]
fn path_surfacesat_at_a_cluster_edge_keeps_a_and_b_goes_at_idle() {
	let got = reader_route(&format!("\nread(10)\npump()\nout.a = read(10)\nout.b = read({C} + 10)\nout.back = read(10)\npump()\nout.kept = read(10)\nout.bAfter = read({C} + 10)"));
	assert_eq!(got, json!({ "a": 1, "b": "nil", "back": 1, "kept": 1, "bAfter": "nil" }));
}

#[test]
fn path_surfacesat_off_the_data_drops_the_cluster_read_before() {
	let got = reader_route(&format!(
		r#"
local function held(f)
	read(10)
	pump()
	local was = read(10)
	local n = f()
	return {{ was, n, Path.IsLoaded({MAP}) }}
end
out.nomap = held(function() return Path.SurfacesAt(99, 5, 5, t) end)
out.outside = held(function() return Path.SurfacesAt({MAP}, -50, 5, t) end)"#
	));
	assert_eq!(got["nomap"], json!([1, 0, false]), "a map without data");
	assert_eq!(got["outside"], json!([1, 0, false]), "a point outside the map's data");
}

// Lifts: two strips of ground with no walkable cell between them (a mesa top and the plain below, as the grid has
// them: nothing joins them), and the pack's lift chokepoints (PolestarNavChokepoints[map]) naming a bottom landing
// at the near strip's end and its top at the far strip's start.
const LIFT_GAP: usize = 8;
fn lift_files(with_lift: bool) -> MapDir {
	let cells: Cells = (X0..=X1).filter(|&x| x <= X0 + LIFT_GAP || x >= X1 - LIFT_GAP).map(|x| (x * C + Y0, FixtureCell { val: 1, cls: 0 })).collect();
	let mut map = map_files(&cells, true, Opts::default());
	if with_lift {
		let bottom = at((X0 + LIFT_GAP) as f64, Y0 as f64);
		let top = at((X1 - LIFT_GAP) as f64, Y0 as f64);
		let choke = map.dir.path().join("Chokepoints.lua");
		std::fs::write(
			&choke,
			format!(
				"PolestarNavChokepoints = {{ [{MAP}] = {{\n\t{{ wx = {}, wy = {}, z = 0, r = 6, kind = \"lift\", liftEnd = \"bottom\", pair = 2 }},\n\t{{ wx = {}, wy = {}, z = 0, r = 6, kind = \"lift\", liftEnd = \"top\", pair = 1 }},\n\t{{ wx = {}, wy = {}, z = 0, r = 10, kind = \"gate\" }},\n}} }}\n",
				js(bottom.x),
				js(bottom.y),
				js(top.x),
				js(top.y),
				js(top.x),
				js(top.y + 3.0 * CS)
			),
		)
		.unwrap();
		map.files.push(choke);
	}
	map
}

#[test]
fn lifts_a_lift_chokepoint_joins_ground_the_grid_leaves_apart_find_rides_it_findcost_and_findmany_price_the_ride_without_it_no_way() {
	let queries = || [q("find", "find", "nil"), q("cost", "cost", "nil"), q("many", "many", "nil"), q("back", "many", "nil")];
	let none = route(&lift_files(false), &queries()[..3]);
	for id in ["find", "cost"] {
		assert_eq!(none[id]["cost"], "unreachable", "{id}: no lift, no way");
	}
	assert!(none["many"].get("cost").is_none_or(Value::is_null), "FindMany: no cost");
	let r = route_with(
		ours(),
		&lift_files(true),
		&queries(),
		from(),
		to(),
		&format!("Path.FindMany({MAP}, B, {{ A }}, function(costs, reason, job) out.back = {{ cost = str(costs[1] or reason) }} end)\nwhile #frames > 0 do table.remove(frames, 1)() end"),
	);
	let want = 2.0 * LIFT_GAP as f64 * CS + 175.0; // the two walks at run speed, and the ride (25 s at 7 yd/s)
	for id in ["find", "cost", "many", "back"] {
		close(&r[id], want, id);
	}
	let xs: Vec<f64> = points(&r["find"]).iter().map(|p| p.0).collect();
	let landing = |x: usize| xs.iter().any(|v| (v - (x as f64 + 0.5) * CS).abs() < 1e-6);
	assert!(landing(X0 + LIFT_GAP) && landing(X1 - LIFT_GAP), "both landings on the drawn line: {:?}", xs.iter().map(|v| v / CS - 0.5).collect::<Vec<_>>());
	yards_near(yards(&r["find"]), S as f64 * CS, "the drawn line, the shaft included", 0.5);
	yards_near(yards(&r["many"]), S as f64 * CS, "FindMany's yards: the walks and the yards between the landings", 0.5);
}
