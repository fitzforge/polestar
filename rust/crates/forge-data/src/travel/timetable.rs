//! Timetables for boats, zeppelins, the Deeprun Tram and lifts, the walk-in portals and the class
//! teleports (port of tools/lib/travel/timetable.js; see its header). Ported from Shortest Path
//! Forever (GPL-3.0-or-later, by Cillian Berragan, used with permission).
//! Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
//! Portions Copyright (C) the CMaNGOS project (see its AUTHORS file), GPL-2.0-or-later, used under GPL-3.0.

use forge_core::jsnum::{js_hypot, js_hypot_n, js_round};
use forge_guide::js::{cmp_utf16, num_str, parse_int, V};
use indexmap::IndexMap;
use rustc_hash::{FxHashMap, FxHashSet};

use super::geo::{round, Frames, W};
use super::taxi::LiveFrames;
use super::transports::{end_height, in_zone, number, End, Nav, Transport};
use crate::jsv::{to_int32, Row, Rows};

const SPEED: f64 = 30.0;
const ACCEL: f64 = 1.0;
const STOP: f64 = 2.0;
const TELEPORT: i32 = 1;
const REFERENCE_PERIODS: [(i64, f64); 8] = [(241, 350818.0), (285, 303463.0), (292, 329313.0), (293, 316251.0), (295, 295579.0), (301, 333044.0), (302, 356284.0), (303, 317038.0)];
const PERIOD_TOLERANCE: f64 = 0.005;
const SAME_DOCK: f64 = 30.0;
const DOCK_MATCH: f64 = 60.0;
const LOAD_SECONDS: f64 = 10.0;
const TRAM_WALK: f64 = 5.0;
const STEP: f64 = 0.05;

fn board_of(kind: &str) -> f64 {
	match kind {
		"boat" | "zeppelin" => 10.0,
		"tram" => 5.0,
		"lift" => 2.0,
		_ => f64::NAN,
	}
}

/// Observer fit thresholds: samples, span ms, min speed yd/s.
#[derive(Clone, Copy, Debug)]
pub struct Fit {
	pub samples: f64,
	pub span: f64,
	pub speed: f64,
}

fn fit(name: &str) -> Fit {
	match name {
		"lift" => Fit { samples: 5.0, span: 4000.0, speed: 8.0 },
		"liftSlow" => Fit { samples: 5.0, span: 4000.0, speed: 6.0 },
		"liftShort" => Fit { samples: 3.0, span: 2000.0, speed: 8.0 },
		_ => Fit { samples: 10.0, span: 30000.0, speed: 12.0 },
	}
}

const CATMULL_ROM: [[f64; 4]; 4] = [[-0.5, 1.5, -1.5, 0.5], [1.0, -2.5, 2.0, -0.5], [-0.5, 0.0, 0.5, 0.0], [0.0, 1.0, 0.0, 0.0]];

/// `Number.parseInt(v, 10) || 0`.
fn int(r: &Row, col: &str) -> f64 {
	let n = r.get(col).map(|s| parse_int(s)).unwrap_or(f64::NAN);
	if n.is_nan() {
		0.0
	} else {
		n
	}
}

fn dist3(a: &[f64; 3], b: &[f64; 3]) -> f64 {
	js_hypot_n(&[a[0] - b[0], a[1] - b[1], a[2] - b[2]])
}

fn modulo(a: f64, n: f64) -> f64 {
	((a % n) + n) % n
}

fn by_num(a: f64, b: f64) -> std::cmp::Ordering {
	(a - b).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
}

// --- the boat model (CMaNGOS TransportMgr::GenerateWaypoints) ---------------

fn evaluate(points: &[[f64; 3]], t: f64) -> [f64; 3] {
	let powers = [t * t * t, t * t, t, 1.0];
	let mut w = [0.0; 4];
	for (c, wc) in w.iter_mut().enumerate() {
		let mut s = 0.0;
		for (r, p) in powers.iter().enumerate() {
			s += p * CATMULL_ROM[r][c];
		}
		*wc = s;
	}
	let mut out = [0.0; 3];
	for (d, o) in out.iter_mut().enumerate() {
		let mut s = 0.0;
		for (k, wk) in w.iter().enumerate() {
			s += wk * points[k][d];
		}
		*o = s;
	}
	out
}

fn segment_lengths(controls: &[[f64; 3]]) -> Vec<f64> {
	if controls.len() < 2 {
		return Vec::new();
	}
	let first = [0, 1, 2].map(|d| 2.0 * controls[0][d] - controls[1][d]);
	let mut points = vec![first];
	points.extend_from_slice(controls);
	points.push(controls[controls.len() - 1]);
	let mut lengths = Vec::new();
	for i in 1..controls.len() {
		let window = &points[i - 1..i + 3];
		let mut previous = controls[i - 1];
		let mut length = 0.0;
		for step in [1.0, 2.0, 3.0] {
			let current = evaluate(window, step / 3.0);
			length += dist3(&current, &previous);
			previous = current;
		}
		lengths.push(length);
	}
	lengths
}

#[derive(Clone, Debug, Default)]
struct KF {
	c: f64,
	pos: [f64; 3],
	stop: bool,
	delay: f64,
	teleport: bool,
	dist: f64,
	since: f64,
	until: f64,
	to: f64,
	arrive: f64,
	depart: f64,
}

fn keyframes(nodes: &[&Row]) -> Vec<KF> {
	let mut frames: Vec<KF> = Vec::new();
	let mut skip = false;
	for i in 1..nodes.len().saturating_sub(1) {
		if skip {
			skip = false;
			continue;
		}
		let n = nodes[i];
		if to_int32(int(n, "Flags")) & TELEPORT != 0 || int(n, "ContinentID") != int(nodes[i + 1], "ContinentID") {
			if let Some(l) = frames.last_mut() {
				l.teleport = true;
			}
			skip = true;
			continue;
		}
		let delay = number(n.get("Delay"));
		frames.push(KF {
			c: int(n, "ContinentID"),
			pos: [number(n.get("Loc_0")), number(n.get("Loc_1")), number(n.get("Loc_2"))],
			stop: int(n, "Flags") == STOP,
			delay: if delay.is_nan() { 0.0 } else { delay },
			..KF::default()
		});
	}
	if let Some(l) = frames.last_mut() {
		l.teleport = true;
	}
	let mut start = 0;
	for i in 1..frames.len() {
		if frames[i - 1].teleport || i + 1 == frames.len() {
			let end = i + if frames[i - 1].teleport { 0 } else { 1 };
			let ctl: Vec<[f64; 3]> = frames[start..end].iter().map(|f| f.pos).collect();
			for (k, length) in segment_lengths(&ctl).into_iter().enumerate() {
				frames[start + 1 + k].dist = length;
			}
			start = i;
		}
	}
	frames
}

fn move_time(since: f64, until: f64) -> f64 {
	let accel_dist = (0.5 * SPEED * SPEED) / ACCEL;
	if since + until < 2.0 * accel_dist {
		if since < until {
			return 2.0 * ((since + until) / ACCEL).sqrt() - ((2.0 * since) / ACCEL).sqrt();
		}
		return ((2.0 * until) / ACCEL).sqrt();
	}
	if since < accel_dist {
		return (since + until) / SPEED + SPEED / ACCEL - ((2.0 * since) / ACCEL).sqrt();
	}
	if until < accel_dist {
		return ((2.0 * until) / ACCEL).sqrt();
	}
	until / SPEED + (0.5 * SPEED) / ACCEL
}

/// (frames with arrive/depart seconds, period seconds); None: too short.
fn boat_timetable(nodes: &[&Row]) -> Option<(Vec<KF>, f64)> {
	let mut frames = keyframes(nodes);
	let count = frames.len();
	if count < 2 {
		return None;
	}
	let stops: Vec<usize> = (0..count).filter(|&i| frames[i].stop).collect();
	let first = stops.first().copied().unwrap_or(0);
	let last = stops.last().copied().unwrap_or(0);
	let mut distance = 0.0;
	for k in 0..count {
		let j = (k + last) % count;
		distance = if frames[j].stop || j == last { 0.0 } else { distance + frames[j].dist };
		frames[j].since = distance;
	}
	distance = 0.0;
	for k in (0..count).rev() {
		let j = (k + first) % count;
		distance += frames[(j + 1) % count].dist;
		frames[j].until = distance;
		if frames[j].stop || j == first {
			distance = 0.0;
		}
	}
	for f in frames.iter_mut() {
		f.to = move_time(f.since, f.until);
	}
	let mut clock = if frames[0].stop { frames[0].delay } else { 0.0 };
	frames[0].arrive = 0.0;
	frames[0].depart = clock;
	for i in 1..count {
		clock += frames[i - 1].to;
		if frames[i].stop {
			frames[i].arrive = clock;
			clock += frames[i].delay;
			frames[i].depart = clock;
		} else {
			clock -= frames[i].to;
			frames[i].arrive = clock;
			frames[i].depart = clock;
		}
	}
	Some((frames, clock))
}

// --- routes and services -----------------------------------------------------

#[derive(Clone, Debug)]
pub struct Route {
	pub kind: String,
	pub period: f64,
	pub fit: Fit,
	pub stops: Vec<Vec<f64>>,
	pub frames: Vec<Vec<f64>>,
}

#[derive(Clone, Debug)]
pub struct Part {
	pub route: String,
	pub a: Vec<usize>,
	pub b: Vec<usize>,
}

#[derive(Clone, Debug)]
pub struct Service {
	/// The fields before `board` (kind, name, ...), in the JS object's order.
	pub head: Vec<(&'static str, V)>,
	pub board: f64,
	pub pre: f64,
	pub post: f64,
	pub routes: Vec<Part>,
	pub wait: (f64, f64),
	pub ride: (f64, f64),
}

fn gaps_of(route: &Route, idx: &[usize]) -> Vec<f64> {
	let period = route.period / 1000.0;
	let mut departs: Vec<f64> = Vec::new();
	for &i in idx {
		let d = modulo(route.stops[i][1] / 1000.0, period);
		if !departs.iter().any(|&x| x == d || (x.is_nan() && d.is_nan())) {
			departs.push(d);
		}
	}
	departs.sort_by(|a, b| by_num(*a, *b));
	let n = departs.len();
	(0..n).map(|k| if k + 1 < n { departs[k + 1] - departs[k] } else { departs[0] + period - departs[k] }).collect()
}

fn js_max(v: &[f64]) -> f64 {
	v.iter().fold(f64::NEG_INFINITY, |m, &x| if x.is_nan() || m.is_nan() { f64::NAN } else { m.max(x) })
}

fn expected_wait(parts: &[(&Route, &[usize])], board: f64) -> f64 {
	let gaps: Vec<(Vec<f64>, f64)> = parts.iter().map(|(r, idx)| (gaps_of(r, idx), r.period / 1000.0)).collect();
	let longest = gaps.iter().map(|g| js_max(&g.0)).fold(f64::INFINITY, |m, x| if x.is_nan() || m.is_nan() { f64::NAN } else { m.min(x) });
	let mut total = 0.0;
	let mut t = STEP / 2.0;
	while t < longest {
		let mut survive = 1.0;
		for (g, period) in &gaps {
			let mut s = 0.0;
			for &gap in g {
				s += js_max(&[0.0, gap - t]);
			}
			survive *= s / period;
		}
		total += survive * STEP;
		t += STEP;
	}
	board + total
}

fn ride_from(route: &Route, i: usize, to: &[usize]) -> f64 {
	let mut best = f64::INFINITY;
	for &j in to {
		let ride = modulo(route.stops[j][0] - route.stops[i][1], route.period);
		if ride < best {
			best = ride;
		}
	}
	best / 1000.0
}

fn expected_ride(parts: &[(&Route, &Part)], from_a: bool) -> f64 {
	let mut sum = 0.0;
	let mut weight = 0.0;
	for (route, part) in parts {
		let period = route.period;
		let (from, to) = if from_a { (&part.a, &part.b) } else { (&part.b, &part.a) };
		let mut departs: Vec<(usize, f64)> = from.iter().map(|&i| (i, modulo(route.stops[i][1], period))).collect();
		departs.sort_by(|a, b| by_num(a.1, b.1));
		for k in 0..departs.len() {
			let (i, d) = departs[k];
			let prev = if k > 0 { departs[k - 1].1 } else { departs[departs.len() - 1].1 - period };
			let diff = d - prev;
			let gap = (if diff == 0.0 || diff.is_nan() { period } else { diff }) / period;
			sum += gap * ride_from(route, i, to);
			weight += gap;
		}
	}
	sum / weight
}

fn service_times(service: &mut Service, routes: &IndexMap<String, Route>) {
	let parts: Vec<(&Route, &Part)> = service.routes.iter().map(|p| (&routes[&p.route], p)).collect();
	let side = |from_a: bool| {
		let idx: Vec<(&Route, &[usize])> = parts.iter().map(|(r, p)| (*r, if from_a { p.a.as_slice() } else { p.b.as_slice() })).collect();
		(round(service.pre + expected_wait(&idx, service.board), 1), round(expected_ride(&parts, from_a) + service.post, 1))
	};
	let a = side(true);
	let b = side(false);
	service.wait = (a.0, b.0);
	service.ride = (a.1, b.1);
}

// --- boats and zeppelins -----------------------------------------------------

fn path_nodes(rows: &Rows) -> FxHashMap<i64, Vec<&Row>> {
	let mut by_path: FxHashMap<i64, Vec<&Row>> = FxHashMap::default();
	for r in rows {
		by_path.entry(int(r, "PathID") as i64).or_default().push(r);
	}
	for list in by_path.values_mut() {
		list.sort_by(|a, b| by_num(int(a, "NodeIndex"), int(b, "NodeIndex")));
	}
	by_path
}

fn reference_period(path: i64) -> Option<f64> {
	REFERENCE_PERIODS.iter().find(|r| r.0 == path).map(|r| r.1)
}

fn boat_route(nodes: &[&Row], path: i64, kind: &str, mean_ratio: f64) -> Result<Route, String> {
	let Some((frames, period)) = boat_timetable(nodes) else { return Err("too short to time".into()) };
	let reference = reference_period(path);
	if let Some(r) = reference {
		if (period * 1000.0 - r).abs() / r > PERIOD_TOLERANCE {
			return Err(format!("modelled period {} ms is not the sniffed {} ms", num_str(js_round(period * 1000.0)), num_str(r)));
		}
	}
	let scale = reference.map(|r| r / (period * 1000.0)).unwrap_or(mean_ratio);
	let ms = |s: f64| js_round(s * 1000.0 * scale);
	let mut stops: Vec<Vec<f64>> = Vec::new();
	for f in &frames {
		if f.stop {
			stops.push(vec![ms(f.arrive), ms(f.depart), f.c, round(f.pos[0], 1), round(f.pos[1], 1)]);
		}
	}
	if stops.len() > 1 {
		let (head, tail) = (&stops[0], &stops[stops.len() - 1]);
		if head[0] == 0.0 && head[2] == tail[2] && js_hypot(head[3] - tail[3], head[4] - tail[4]) <= SAME_DOCK {
			let t = stops.pop().unwrap();
			stops[0][0] = t[0];
		}
	}
	Ok(Route {
		kind: kind.to_string(),
		period: ms(period),
		fit: fit("boat"),
		stops,
		frames: frames.iter().map(|f| vec![ms(f.arrive), ms(f.depart), f.c, round(f.pos[0], 1), round(f.pos[1], 1), if f.teleport { 1.0 } else { 0.0 }]).collect(),
	})
}

fn stops_at(route: &Route, at: &W) -> Vec<usize> {
	(0..route.stops.len()).filter(|&i| route.stops[i][2] == at.c && js_hypot(route.stops[i][3] - at.wx, route.stops[i][4] - at.wy) <= DOCK_MATCH).collect()
}

// --- lifts and the tram (TransportAnimation) ---------------------------------

struct Lift {
	id: &'static str,
	name: &'static str,
	area: f64,
	dir: Option<&'static str>,
	cars: &'static [(f64, f64)],
	fit: &'static str,
}

const LIFTS: [Lift; 7] = [
	Lift { id: "lift-great-lift", name: "The Great Lift", area: 485.0, dir: None, cars: &[(11898.0, 16874.0), (11899.0, 16876.0)], fit: "lift" },
	Lift { id: "lift-freewind-post", name: "Freewind Post", area: 484.0, dir: None, cars: &[(11898.0, 16875.0), (11899.0, 16877.0)], fit: "lift" },
	Lift { id: "lift-thunder-bluff-west", name: "Thunder Bluff, west lift", area: 1638.0, dir: Some("west"), cars: &[(4170.0, 18298.0), (4171.0, 18435.0)], fit: "liftSlow" },
	Lift { id: "lift-thunder-bluff-north", name: "Thunder Bluff, north lift", area: 1638.0, dir: Some("north"), cars: &[(47296.0, 20639.0), (47297.0, 20640.0)], fit: "liftSlow" },
	Lift { id: "lift-undercity-west", name: "Undercity, west lift", area: 1497.0, dir: Some("west"), cars: &[(20649.0, 44892.0)], fit: "liftShort" },
	Lift { id: "lift-undercity-east", name: "Undercity, east lift", area: 1497.0, dir: Some("east"), cars: &[(20652.0, 44962.0)], fit: "liftShort" },
	Lift { id: "lift-undercity-south", name: "Undercity, south lift", area: 1497.0, dir: Some("south"), cars: &[(20655.0, 44901.0)], fit: "liftShort" },
];
const TRAINS: [f64; 2] = [176080.0, 176082.0];
const DEEPRUN_TRAM_AREA: f64 = 2257.0;
const TRAM_SPLIT_Y: f64 = 1200.0;

type Track = Vec<(f64, [f64; 3])>;

fn animation_tracks(rows: &Rows) -> FxHashMap<i64, Track> {
	let mut tracks: FxHashMap<i64, Track> = FxHashMap::default();
	for r in rows {
		tracks.entry(int(r, "TransportID") as i64).or_default().push((int(r, "TimeIndex"), [number(r.get("Pos_0")), number(r.get("Pos_1")), number(r.get("Pos_2"))]));
	}
	for t in tracks.values_mut() {
		t.sort_by(|a, b| by_num(a.0, b.0));
	}
	tracks
}

#[derive(Clone, Debug)]
struct TF {
	arrive: f64,
	depart: f64,
	c: f64,
	pos: [f64; 3],
	car: usize,
	jump: bool,
}

struct Spawn {
	map: f64,
	x: f64,
	y: f64,
	z: f64,
}

fn world_track(track: &Track, spawn: &Spawn) -> Vec<TF> {
	let mut frames: Vec<TF> = Vec::new();
	for &(time, [x, y, z]) in track {
		let pos = [spawn.x + x, spawn.y - y, spawn.z + z];
		match frames.last_mut() {
			Some(prev) if dist3(&prev.pos, &pos) < 0.001 => prev.depart = time,
			_ => frames.push(TF { arrive: time, depart: time, c: spawn.map, pos, car: 0, jump: false }),
		}
	}
	frames
}

struct TStop {
	v: [f64; 6],
	side: &'static str,
	car: usize,
}

fn track_stops(frames: &[TF], period: f64, side_of: &dyn Fn(&TF) -> &'static str) -> Vec<TStop> {
	let mut stops: Vec<TStop> = Vec::new();
	for f in frames {
		if f.depart <= f.arrive {
			continue;
		}
		let side = side_of(f);
		let head = stops.iter().position(|s| s.side == side && s.v[0] == 0.0 && s.car == f.car);
		match head {
			Some(h) if f.depart == period => stops[h].v[0] = f.arrive,
			_ => stops.push(TStop { v: [f.arrive, f.depart, f.c, round(f.pos[0], 1), round(f.pos[1], 1), round(f.pos[2], 1)], side, car: f.car }),
		}
	}
	stops.sort_by(|a, b| by_num(a.v[0], b.v[0]).then(a.side.cmp(b.side)).then(a.car.cmp(&b.car)));
	stops
}

fn track_route(kind: &str, fit_name: &str, cars: &[Vec<TF>], period: f64, side_of: &dyn Fn(&TF) -> &'static str) -> (Route, Vec<usize>, Vec<usize>) {
	let mut frames: Vec<TF> = Vec::new();
	for (k, car) in cars.iter().enumerate() {
		for f in car {
			frames.push(TF { car: k, ..f.clone() });
		}
		frames.last_mut().unwrap().jump = true;
	}
	let stops = track_stops(&frames, period, side_of);
	let route = Route {
		kind: kind.to_string(),
		period,
		fit: fit(fit_name),
		stops: stops
			.iter()
			.map(|s| {
				let mut v = s.v.to_vec();
				v.push((s.car + 1) as f64);
				v
			})
			.collect(),
		frames: frames.iter().map(|f| vec![f.arrive, f.depart, f.c, round(f.pos[0], 1), round(f.pos[1], 1), if f.jump { 1.0 } else { 0.0 }, round(f.pos[2], 1)]).collect(),
	};
	let a = (0..stops.len()).filter(|&i| stops[i].side == "a").collect();
	let b = (0..stops.len()).filter(|&i| stops[i].side == "b").collect();
	(route, a, b)
}

fn spawn_of(db: &V, entry: f64, guid: Option<f64>) -> Option<Spawn> {
	let list = db.get("spawns").get(&num_str(entry)).items();
	let s = match guid {
		Some(g) => list.into_iter().find(|s| s.get("guid").as_num() == Some(g)),
		None => list.into_iter().next(),
	}?;
	Some(Spawn { map: s.get("map").num(), x: s.get("x").num(), y: s.get("y").num(), z: s.get("z").num() })
}

fn mean(list: &[&TF], axis: usize) -> f64 {
	list.iter().fold(0.0, |s, f| s + f.pos[axis]) / list.len() as f64
}

fn build_lifts(tracks: &FxHashMap<i64, Track>, db: &V, routes: &mut IndexMap<String, Route>, services: &mut IndexMap<String, Service>, warnings: &mut Vec<String>) {
	for site in &LIFTS {
		// (period, frames)
		let mut cars: Vec<(f64, Vec<TF>)> = Vec::new();
		for &(entry, guid) in site.cars {
			let spawn = spawn_of(db, entry, Some(guid));
			let track = tracks.get(&(entry as i64));
			let (Some(spawn), Some(track)) = (spawn.as_ref(), track) else {
				warnings.push(format!("{}: {} of {} ({}) missing, skipped", site.id, if spawn.is_some() { "TransportAnimation" } else { "classic-db spawn" }, num_str(entry), num_str(guid)));
				break;
			};
			cars.push((track[track.len() - 1].0, world_track(track, spawn)));
		}
		if cars.len() != site.cars.len() {
			continue;
		}
		let landings: Vec<&TF> = cars.iter().flat_map(|c| c.1.iter().filter(|f| f.depart > f.arrive)).collect();
		let zs: Vec<f64> = landings.iter().map(|f| f.pos[2]).collect();
		let lo = zs.iter().fold(f64::INFINITY, |m, &x| if x.is_nan() || m.is_nan() { f64::NAN } else { m.min(x) });
		let middle = (lo + js_max(&zs)) / 2.0;
		let side_of = move |f: &TF| if f.pos[2] > middle { "a" } else { "b" };
		let top: Vec<&TF> = landings.iter().copied().filter(|f| side_of(f) == "a").collect();
		let bottom: Vec<&TF> = landings.iter().copied().filter(|f| side_of(f) == "b").collect();
		let mut periods: Vec<f64> = Vec::new();
		for c in &cars {
			if !periods.contains(&c.0) {
				periods.push(c.0);
			}
		}
		let groups: Vec<Vec<&(f64, Vec<TF>)>> = if periods.len() > 1 { cars.iter().map(|c| vec![c]).collect() } else { vec![cars.iter().collect()] };
		let mut parts = Vec::new();
		for (k, group) in groups.iter().enumerate() {
			let id = if groups.len() > 1 { format!("{}-{}", site.id, k + 1) } else { site.id.to_string() };
			let frames: Vec<Vec<TF>> = group.iter().map(|c| c.1.clone()).collect();
			let (route, a, b) = track_route("lift", site.fit, &frames, group[0].0, &side_of);
			routes.insert(id.clone(), route);
			parts.push(Part { route: id, a, b });
		}
		let mut head: Vec<(&'static str, V)> = vec![("kind", "lift".into()), ("name", site.name.into()), ("area", site.area.into())];
		if let Some(d) = site.dir {
			head.push(("dir", d.into()));
		}
		head.extend([
			("c", landings[0].c.into()),
			("wx", round(mean(&landings, 0), 1).into()),
			("wy", round(mean(&landings, 1), 1).into()),
			("top", round(mean(&top, 2), 1).into()),
			("bottom", round(mean(&bottom, 2), 1).into()),
		]);
		services.insert(site.id.to_string(), Service { head, board: board_of("lift"), pre: 0.0, post: 0.0, routes: parts, wait: (0.0, 0.0), ride: (0.0, 0.0) });
	}
}

fn build_tram(tram: &Transport, tracks: &FxHashMap<i64, Track>, db: &V, routes: &mut IndexMap<String, Route>, services: &mut IndexMap<String, Service>, warnings: &mut Vec<String>) {
	let mut parts = Vec::new();
	for entry in TRAINS {
		let spawn = spawn_of(db, entry, None);
		let track = tracks.get(&(entry as i64));
		let (Some(spawn), Some(track)) = (spawn.as_ref(), track) else {
			warnings.push(format!("{}: {} of train {} missing, skipped", tram.id, if spawn.is_some() { "TransportAnimation" } else { "classic-db spawn" }, num_str(entry)));
			return;
		};
		let id = format!("tram-{}", num_str(entry));
		let side = |f: &TF| if f.pos[1] < TRAM_SPLIT_Y { "b" } else { "a" };
		let (route, a, b) = track_route("tram", "tram", &[world_track(track, spawn)], track[track.len() - 1].0, &side);
		routes.insert(id.clone(), route);
		parts.push(Part { route: id, a, b });
	}
	let head: Vec<(&'static str, V)> = vec![
		("kind", "tram".into()),
		("name", "Deeprun Tram".into()),
		("area", DEEPRUN_TRAM_AREA.into()),
		("ends", vec![V::from(tram.a.name.as_str()), V::from(tram.b.name.as_str())].into()),
		("areas", vec![V::from(tram.a.area), V::from(tram.b.area)].into()),
	];
	services.insert(tram.id.clone(), Service { head, board: board_of("tram"), pre: LOAD_SECONDS + TRAM_WALK, post: LOAD_SECONDS + TRAM_WALK, routes: parts, wait: (0.0, 0.0), ride: (0.0, 0.0) });
}

// --- portals and teleports ---------------------------------------------------

struct PortalDef {
	trigger: i64,
	id: &'static str,
	from: &'static str,
	from_area: f64,
	to: &'static str,
	to_area: f64,
}

const PORTALS: [PortalDef; 2] = [
	PortalDef { trigger: 527, id: "portal-ruttheran", from: "Darnassus", from_area: 1657.0, to: "Rut'theran Village", to_area: 702.0 },
	PortalDef { trigger: 542, id: "portal-darnassus", from: "Rut'theran Village", from_area: 702.0, to: "Darnassus", to_area: 1657.0 },
];
const PORTAL_SECONDS: f64 = 5.0;
const DEST_HOME: f64 = 9.0;
const DEST_DB: f64 = 17.0;
const HEARTHSTONE_SPELL: f64 = 8690.0;

fn teleport_area(spell: f64) -> Option<f64> {
	[(3561.0, 1519.0), (3562.0, 1537.0), (3563.0, 1497.0), (3565.0, 1657.0), (3566.0, 1638.0), (3567.0, 1637.0), (18960.0, 493.0)].iter().find(|x| x.0 == spell).map(|x| x.1)
}

/// A world point -> an end on the smallest zone or city map holding it.
pub fn place(name: &str, c: f64, wx: f64, wy: f64, frames: &Frames, live: &LiveFrames, area: Option<f64>) -> Option<End> {
	for cand in frames.containing(c, wx, wy) {
		if let Some((x, y, f)) = in_zone(frames, live, cand.map, c, wx, wy) {
			return Some(End {
				name: name.to_string(),
				area: area.filter(|&a| a != 0.0),
				c,
				wx: round(wx, 1),
				wy: round(wy, 1),
				map: cand.map,
				x: round(x, 2),
				y: round(y, 2),
				f,
				source: None,
				board: None,
				z: None,
			});
		}
	}
	None
}

#[derive(Clone, Debug)]
pub struct Portal {
	pub id: String,
	pub name: String,
	pub area: f64,
	pub a: End,
	pub b: End,
	pub seconds: f64,
	pub source: String,
}

fn build_portals(area_triggers: &Rows, db: &V, frames: &Frames, live: &LiveFrames, warnings: &mut Vec<String>, nav: Option<&Nav>) -> Vec<Portal> {
	let mut triggers: FxHashMap<i64, &Row> = FxHashMap::default();
	for r in area_triggers {
		triggers.insert(int(r, "ID") as i64, r);
	}
	let mut out = Vec::new();
	for p in &PORTALS {
		let t = triggers.get(&p.trigger);
		let dest = db.get("portals").get(&p.trigger.to_string());
		let (Some(t), true) = (t, dest.truthy()) else {
			warnings.push(format!("{}: {} {} missing, skipped", p.id, if t.is_some() { "classic-db areatrigger_teleport" } else { "AreaTrigger" }, p.trigger));
			continue;
		};
		let mut a = place(p.from, int(t, "ContinentID"), number(t.get("Pos_0")), number(t.get("Pos_1")), frames, live, Some(p.from_area));
		let mut b = place(p.to, dest.get("map").num(), dest.get("x").num(), dest.get("y").num(), frames, live, Some(p.to_area));
		if let (Some(a), Some(b), Some(nav)) = (a.as_mut(), b.as_mut(), nav) {
			for (e, z) in [(a, number(t.get("Pos_2"))), (b, dest.get("z").as_num().unwrap_or(f64::NAN))] {
				match end_height(nav, e.c, e.wx, e.wy, Some(z)) {
					Some(h) => e.z = Some(h),
					None => warnings.push(format!("{}: the {} end has no walkable surface near its height {}", p.id, e.name, num_str(round(z, 1)))),
				}
			}
		}
		let (Some(a), Some(b)) = (a, b) else {
			warnings.push(format!("{}: an end is on no map, skipped", p.id));
			continue;
		};
		out.push(Portal {
			id: p.id.to_string(),
			name: p.to.to_string(),
			area: p.to_area,
			a,
			b,
			seconds: PORTAL_SECONDS,
			source: format!("AreaTrigger {} -> classic-db areatrigger_teleport {}", p.trigger, p.trigger),
		});
	}
	out
}

#[derive(Clone, Debug)]
pub struct Teleport {
	pub spell: f64,
	pub name: String,
	pub cast: f64,
	pub reagents: Option<Vec<f64>>,
	pub bind: bool,
	pub to: Option<End>,
}

/// `name.replace(/^[^:]*:\s*/, '')`.
fn after_colon(name: &str) -> &str {
	match name.find(':') {
		Some(i) => name[i + 1..].trim_start(),
		None => name,
	}
}

fn build_teleports(transit: &super::sources::Loaded, db: &V, frames: &Frames, live: &LiveFrames, warnings: &mut Vec<String>) -> Vec<Teleport> {
	let mut names: FxHashMap<i64, String> = FxHashMap::default();
	for r in transit.rows("SpellName") {
		names.insert(int(r, "ID") as i64, r.get("Name_lang").cloned().unwrap_or_default());
	}
	let mut targets: FxHashMap<i64, f64> = FxHashMap::default();
	for r in transit.rows("SpellEffect") {
		let target = int(r, "ImplicitTarget_1");
		let effect = int(r, "Effect");
		if int(r, "DifficultyID") == 0.0 && (effect == 5.0 || effect == 252.0) && (target == DEST_HOME || target == DEST_DB) {
			targets.insert(int(r, "SpellID") as i64, target);
		}
	}
	let class_spells: FxHashSet<i64> = transit.rows("SkillLineAbility").iter().filter(|r| int(r, "ClassMask") != 0.0).map(|r| int(r, "Spell") as i64).collect();
	let mut cast_times: FxHashMap<i64, f64> = FxHashMap::default();
	for r in transit.rows("SpellCastTimes") {
		cast_times.insert(int(r, "ID") as i64, int(r, "Base"));
	}
	let mut cast_index: FxHashMap<i64, f64> = FxHashMap::default();
	for r in transit.rows("SpellMisc").iter().filter(|r| int(r, "DifficultyID") == 0.0) {
		cast_index.insert(int(r, "SpellID") as i64, int(r, "CastingTimeIndex"));
	}
	let mut reagents: FxHashMap<i64, Vec<f64>> = FxHashMap::default();
	for r in transit.rows("SpellReagents") {
		let mut need = Vec::new();
		for i in 0..8 {
			let item = int(r, &format!("Reagent_{i}"));
			let count = int(r, &format!("ReagentCount_{i}"));
			if item != 0.0 && count > 0.0 {
				need.push(item);
				need.push(count);
			}
		}
		if !need.is_empty() {
			reagents.insert(int(r, "SpellID") as i64, need);
		}
	}
	let mut spells: Vec<i64> = targets.keys().copied().collect();
	spells.sort();
	let mut out = Vec::new();
	for spell in spells {
		let sp = spell as f64;
		if !class_spells.contains(&spell) || sp == HEARTHSTONE_SPELL {
			continue;
		}
		let name = names.get(&spell).filter(|n| !n.is_empty()).cloned().unwrap_or_else(|| format!("spell {spell}"));
		let cast_ms = cast_index.get(&spell).and_then(|ix| cast_times.get(&(*ix as i64))).copied().filter(|&n| n != 0.0).unwrap_or(0.0);
		let mut entry = Teleport { spell: sp, name: name.clone(), cast: round(cast_ms / 1000.0, 1), reagents: reagents.get(&spell).cloned(), bind: false, to: None };
		if targets[&spell] == DEST_HOME {
			entry.bind = true;
		} else {
			let pos = db.get("positions").get(&spell.to_string());
			let to = if pos.truthy() { place(after_colon(&name), pos.get("map").num(), pos.get("x").num(), pos.get("y").num(), frames, live, teleport_area(sp)) } else { None };
			let Some(to) = to else {
				warnings.push(format!("teleport {name} ({spell}): no destination on a mapped continent, skipped"));
				continue;
			};
			entry.to = Some(to);
		}
		out.push(entry);
	}
	out
}

// --- build -------------------------------------------------------------------

pub struct Timetables {
	pub routes: IndexMap<String, Route>,
	pub services: IndexMap<String, Service>,
	pub portals: Vec<Portal>,
	pub teleports: Vec<Teleport>,
	pub warnings: Vec<String>,
}
pub fn build_timetables(
	taxi_path_nodes: &Rows,
	area_triggers: &Rows,
	forever_nodes: Option<&Rows>,
	transit: Option<&super::sources::Loaded>,
	db: Option<&V>,
	transports: &mut [Transport],
	frames: &Frames,
	live: &LiveFrames,
	nav: Option<&Nav>,
) -> Timetables {
	let mut warnings = Vec::new();
	let mut routes: IndexMap<String, Route> = IndexMap::new();
	let mut services: IndexMap<String, Service> = IndexMap::new();
	let era = path_nodes(taxi_path_nodes);
	let forever = forever_nodes.map(path_nodes);
	let mut ratios = Vec::new();
	for &(path, reference) in &REFERENCE_PERIODS {
		let Some(n) = era.get(&path).filter(|n| n.len() > 2) else { continue };
		let Some((_, period)) = boat_timetable(n) else { continue };
		let ratio = reference / (period * 1000.0);
		if ratio != 0.0 && !ratio.is_nan() && (ratio - 1.0).abs() <= PERIOD_TOLERANCE {
			ratios.push(ratio);
		}
	}
	let mean_ratio = if ratios.is_empty() { 1.0 } else { ratios.iter().fold(0.0, |s, r| s + r) / ratios.len() as f64 };
	let mut modelled: FxHashMap<String, Result<Route, String>> = FxHashMap::default();
	for t in transports.iter() {
		let Some((path, client, sa, sb)) = &t.path else { continue };
		if t.kind == "tram" || *path == 0 {
			continue;
		}
		let nodes = if *client == "forever" { forever.as_ref() } else { Some(&era) };
		let Some(n) = nodes.and_then(|m| m.get(path)).filter(|n| n.len() >= 3) else { continue };
		let id = format!("path-{path}");
		let built = modelled.entry(id.clone()).or_insert_with(|| boat_route(n, *path, &t.kind, mean_ratio));
		let route = match built {
			Ok(r) => r.clone(),
			Err(e) => {
				warnings.push(format!("{}: TaxiPath {path} {e}; estimate kept", t.id));
				continue;
			}
		};
		let a = stops_at(&route, sa);
		let b = stops_at(&route, sb);
		routes.insert(id.clone(), route);
		if a.is_empty() || b.is_empty() {
			warnings.push(format!("{}: no {} stop on the TaxiPath {path} timetable; estimate kept", t.id, if a.is_empty() { &t.a.name } else { &t.b.name }));
			continue;
		}
		let head: Vec<(&'static str, V)> = vec![
			("kind", t.kind.as_str().into()),
			("name", format!("{} - {}", t.a.name, t.b.name).into()),
			("ends", vec![V::from(t.a.name.as_str()), V::from(t.b.name.as_str())].into()),
			("areas", vec![V::from(t.a.area), V::from(t.b.area)].into()),
		];
		services.insert(t.id.clone(), Service { head, board: board_of(&t.kind), pre: 0.0, post: 0.0, routes: vec![Part { route: id, a, b }], wait: (0.0, 0.0), ride: (0.0, 0.0) });
	}
	let mut portals = Vec::new();
	let mut teleports = Vec::new();
	match (transit, db) {
		(Some(transit), Some(db)) => {
			let tracks = animation_tracks(transit.rows("TransportAnimation"));
			build_lifts(&tracks, db, &mut routes, &mut services, &mut warnings);
			if let Some(tram) = transports.iter().find(|t| t.kind == "tram") {
				build_tram(tram, &tracks, db, &mut routes, &mut services, &mut warnings);
			}
			portals = build_portals(area_triggers, db, frames, live, &mut warnings, nav);
			teleports = build_teleports(transit, db, frames, live, &mut warnings);
		}
		_ => warnings.push(format!("lifts, tram timetable, portals and teleports skipped: {}", if db.is_none() { "no CMaNGOS classic-db" } else { "no client TransportAnimation/spell tables" })),
	}
	for s in services.values_mut() {
		service_times(s, &routes);
	}
	for t in transports.iter_mut() {
		let Some(s) = services.get(&t.id) else { continue };
		t.wait_a = js_round(s.wait.0);
		t.wait_b = js_round(s.wait.1);
		t.ab = js_round(s.ride.0);
		t.ba = js_round(s.ride.1);
		let ids: Vec<&str> = s.routes.iter().map(|p| p.route.as_str()).collect();
		t.source = format!("{}; timetable: {} (CMaNGOS transport model, sniffed periods)", t.source, ids.join(", "));
	}
	routes.sort_by(|a, _, b, _| cmp_utf16(a, b));
	services.sort_by(|a, _, b, _| cmp_utf16(a, b));
	Timetables { routes, services, portals, teleports, warnings }
}
