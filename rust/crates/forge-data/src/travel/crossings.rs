//! Zone crossings (port of tools/lib/travel/crossings.js: validateCrossings, readCrossingsFile,
//! recordedCrossings, crossingsLua, emitTravelAddon, crossingCounts; see its header). Entries are
//! in map percent of the Era client maps; errors name the entry.

use std::path::Path;

use forge_core::jsnum::{js_hypot, js_round};
use forge_guide::js::{cmp_utf16, num_str, parse_json, stringify, V};
use indexmap::{IndexMap, IndexSet};

use super::geo::{round, Frame, Frames};
use super::paths::ZoneStep;
use super::{header, lua_str};

const RADIUS_MIN: f64 = 3.0;
const RADIUS_MAX: f64 = 100.0;
const PAIR_YARDS: f64 = 1000.0;
const HOP_YARDS: f64 = 600.0;
const CAPTION: usize = 160;
const OFF_MAP: [f64; 2] = [-50.0, 150.0];

const KEYS_TOP: &[&str] = &["schema", "frame", "source", "build", "crossings", "open", "chains"];
const KEYS_CROSSING: &[&str] = &["id", "a", "b", "ab", "ba", "oneWay"];
/// (`z`: the end's height, for ends on a ramp or a ledge: the crossings baked-legs measured.)
const KEYS_END: &[&str] = &["map", "x", "y", "z", "radius", "offMap"];
const KEYS_OPEN: &[&str] = &["a", "b", "oneWay"];
const KEYS_CHAIN: &[&str] = &["id", "name", "open", "note", "nodes"];
const KEYS_NODE: &[&str] = &["map", "x", "y", "z", "radius", "caption", "back", "offMap"];

/// A checked point: map percent, radius, world position (and a chain node's captions).
#[derive(Clone, Debug)]
pub struct XPt {
	pub map: f64,
	pub x: Option<f64>,
	pub y: Option<f64>,
	pub r: f64,
	/// The floor height a walk to the point ends on (a ramp, a ledge, the Undercity's entrance hall), when given.
	pub z: Option<f64>,
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
	pub caption: Option<String>,
	pub back: Option<String>,
}

#[derive(Clone, Debug)]
pub struct Crossing {
	pub id: String,
	pub a: XPt,
	pub b: XPt,
	pub ab: Option<String>,
	pub ba: Option<String>,
	pub one_way: bool,
	/// Recorded crossings: steps and sessions.
	pub recorded: Option<(f64, Vec<String>)>,
}

#[derive(Clone, Debug)]
pub struct Open {
	pub a: f64,
	pub b: f64,
	pub c: f64,
	pub one_way: bool,
}

#[derive(Clone, Debug)]
pub struct Chain {
	pub id: String,
	pub name: String,
	pub open: String,
	pub c: f64,
	pub nodes: Vec<XPt>,
}

#[derive(Clone, Debug, Default)]
pub struct Set {
	pub crossings: Vec<Crossing>,
	pub open: Vec<Open>,
	pub chains: Vec<Chain>,
}

fn is_obj(v: &V) -> bool {
	matches!(v, V::Obj(_))
}

fn json(v: &V) -> String {
	if v.is_undef() {
		"undefined".into()
	} else {
		stringify(v, None)
	}
}

fn is_integer(v: &V) -> Option<f64> {
	v.as_num().filter(|n| n.is_finite() && n.fract() == 0.0)
}

fn unknown_keys(o: &V, allowed: &[&str], at: &str, errors: &mut Vec<String>) {
	for k in o.keys() {
		if !allowed.contains(&&*k) {
			errors.push(format!("{at}: unknown key \"{k}\""));
		}
	}
}

fn check_caption(v: &V, at: &str, errors: &mut Vec<String>) -> Option<String> {
	if v.is_undef() {
		return None;
	}
	let Some(s) = v.as_str().filter(|s| !s.trim().is_empty()) else {
		errors.push(format!("{at}: caption must be a non-empty string"));
		return None;
	};
	if s.encode_utf16().count() > CAPTION {
		errors.push(format!("{at}: caption longer than {CAPTION} characters"));
	}
	let ctl = s.chars().any(|c| (c as u32) < 0x20);
	let esc = s.as_bytes().windows(2).any(|w| w[0] == b'|' && b"cCrRTtnH".contains(&w[1]));
	if ctl || esc {
		errors.push(format!("{at}: caption has control characters or | escape codes"));
	}
	Some(s.to_string())
}

fn check_point(p: &V, at: &str, keys: &[&str], frames: &Frames, errors: &mut Vec<String>) -> Option<XPt> {
	if !is_obj(p) {
		errors.push(format!("{at}: expected an object"));
		return None;
	}
	unknown_keys(p, keys, at, errors);
	let mut ok = true;
	let map = is_integer(&p.get("map"));
	if map.is_none_or(|m| frames.frame(m as i64).is_none()) {
		errors.push(format!("{at}: map {} is not a known uiMap id with a map frame", json(&p.get("map"))));
		ok = false;
	}
	let off = matches!(p.get("offMap"), V::Bool(true));
	for k in ["x", "y"] {
		let Some(v) = p.get(k).as_num().filter(|v| v.is_finite()) else {
			errors.push(format!("{at}: {k} must be a number"));
			ok = false;
			continue;
		};
		let [lo, hi] = if off { OFF_MAP } else { [0.0, 100.0] };
		if v < lo || v > hi {
			errors.push(format!("{at}: {k} {} outside {}-{}{}", num_str(v), num_str(lo), num_str(hi), if off { "" } else { " (set \"offMap\": true for a point past the map edge)" }));
			ok = false;
		}
	}
	let om = p.get("offMap");
	if !om.is_undef() && !matches!(om, V::Bool(_)) {
		errors.push(format!("{at}: offMap must be true or false"));
	}
	match p.get("radius").as_num().filter(|r| r.is_finite()) {
		None => {
			errors.push(format!("{at}: radius (yards) is required"));
			ok = false;
		}
		Some(r) if !(RADIUS_MIN..=RADIUS_MAX).contains(&r) => {
			errors.push(format!("{at}: radius {} outside {}-{} yd", num_str(r), num_str(RADIUS_MIN), num_str(RADIUS_MAX)));
			ok = false;
		}
		_ => {}
	}
	let zv = p.get("z");
	if !zv.is_undef() && zv.as_num().is_none_or(|z| !z.is_finite()) {
		errors.push(format!("{at}: z must be a number (yards)"));
		ok = false;
	}
	if !ok {
		return None;
	}
	let (map, x, y) = (map.unwrap(), p.get("x").num(), p.get("y").num());
	let w = frames.to_world(map as i64, x, y).unwrap();
	Some(XPt { map, x: Some(x), y: Some(y), r: p.get("radius").num(), z: zv.as_num(), c: w.c, wx: round(w.wx, 1), wy: round(w.wy, 1), caption: None, back: None })
}

fn yards(a: &XPt, b: &XPt) -> f64 {
	if a.c == b.c {
		js_hypot(a.wx - b.wx, a.wy - b.wy)
	} else {
		f64::INFINITY
	}
}

fn id_ok(id: &str) -> bool {
	let b = id.as_bytes();
	!b.is_empty() && (b[0].is_ascii_lowercase() || b[0].is_ascii_digit()) && b.iter().all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || *c == b'-')
}

/// validateCrossings: the parsed crossings file -> (errors, set).
pub fn validate_crossings(doc: &V, frames: &Frames) -> (Vec<String>, Set) {
	let mut errors = Vec::new();
	let mut out = Set::default();
	if !is_obj(doc) {
		errors.push("crossings file: expected a JSON object".into());
		return (errors, out);
	}
	unknown_keys(doc, KEYS_TOP, "crossings file", &mut errors);
	if doc.get("schema").as_num() != Some(1.0) {
		errors.push(format!("crossings file: schema {} (expected 1)", json(&doc.get("schema"))));
	}
	let frame = doc.get("frame");
	if !frame.is_undef() && frame.as_str() != Some("e") {
		errors.push(format!("crossings file: frame {} (only \"e\", the Era client maps)", json(&frame)));
	}
	let mut ids: IndexMap<String, String> = IndexMap::new();
	let mut claim = |id: &V, at: &str, errors: &mut Vec<String>| {
		let Some(s) = id.as_str().filter(|s| id_ok(s)) else {
			errors.push(format!("{at}: id {} must be lower-case letters, digits and dashes", json(id)));
			return;
		};
		if let Some(prev) = ids.get(s) {
			errors.push(format!("{at}: duplicate id \"{s}\" (also {prev})"));
		} else {
			ids.insert(s.to_string(), at.to_string());
		}
	};
	let list = |k: &str, errors: &mut Vec<String>| -> Vec<V> {
		let v = doc.get(k);
		if v.is_undef() {
			return Vec::new();
		}
		if !v.is_arr() {
			errors.push(format!("crossings file: {k} must be an array"));
			return Vec::new();
		}
		v.items()
	};
	let named = |kind: &str, i: usize, e: &V| match e.get("id").as_str() {
		Some(id) if is_obj(e) => format!("{kind}[{i}] ({id})"),
		_ => format!("{kind}[{i}]"),
	};

	for (i, e) in list("crossings", &mut errors).iter().enumerate() {
		let at = named("crossings", i, e);
		if !is_obj(e) {
			errors.push(format!("{at}: expected an object"));
			continue;
		}
		unknown_keys(e, KEYS_CROSSING, &at, &mut errors);
		claim(&e.get("id"), &at, &mut errors);
		let a = check_point(&e.get("a"), &format!("{at}.a"), KEYS_END, frames, &mut errors);
		let b = check_point(&e.get("b"), &format!("{at}.b"), KEYS_END, frames, &mut errors);
		let ab = check_caption(&e.get("ab"), &format!("{at}.ab"), &mut errors);
		let ba = check_caption(&e.get("ba"), &format!("{at}.ba"), &mut errors);
		let ow = e.get("oneWay");
		if !ow.is_undef() && !matches!(ow, V::Bool(_)) {
			errors.push(format!("{at}: oneWay must be true or false"));
		}
		let (Some(a), Some(b)) = (a, b) else { continue };
		if a.c != b.c {
			errors.push(format!("{at}: the ends are on different continents ({}, {})", num_str(a.c), num_str(b.c)));
			continue;
		}
		if a.map == b.map {
			errors.push(format!("{at}: both ends are in zone {}; a crossing joins two zones", num_str(a.map)));
			continue;
		}
		let d = yards(&a, &b);
		if d > PAIR_YARDS {
			errors.push(format!("{at}: the ends are {} yd apart (more than {})", num_str(js_round(d)), num_str(PAIR_YARDS)));
			continue;
		}
		out.crossings.push(Crossing { id: e.get("id").to_js_string(), a, b, ab, ba, one_way: matches!(ow, V::Bool(true)), recorded: None });
	}

	let mut pairs: IndexSet<String> = IndexSet::new();
	for (i, e) in list("open", &mut errors).iter().enumerate() {
		let at = format!("open[{i}]");
		if !is_obj(e) {
			errors.push(format!("{at}: expected an object"));
			continue;
		}
		unknown_keys(e, KEYS_OPEN, &at, &mut errors);
		let fa: Option<Frame> = is_integer(&e.get("a")).and_then(|m| frames.frame(m as i64));
		let fb: Option<Frame> = is_integer(&e.get("b")).and_then(|m| frames.frame(m as i64));
		if fa.is_none() {
			errors.push(format!("{at}: a {} is not a known uiMap id with a map frame", json(&e.get("a"))));
		}
		if fb.is_none() {
			errors.push(format!("{at}: b {} is not a known uiMap id with a map frame", json(&e.get("b"))));
		}
		let ow = e.get("oneWay");
		if !ow.is_undef() && !matches!(ow, V::Bool(_)) {
			errors.push(format!("{at}: oneWay must be true or false"));
		}
		let (Some(fa), Some(fb)) = (fa, fb) else { continue };
		let (a, b) = (e.get("a").num(), e.get("b").num());
		if a == b {
			errors.push(format!("{at}: a zone is not a pair with itself"));
			continue;
		}
		if fa.c != fb.c {
			errors.push(format!("{at}: {} and {} are on different continents", num_str(a), num_str(b)));
			continue;
		}
		let key = format!("{}-{}", num_str(a.min(b)), num_str(a.max(b)));
		if pairs.contains(&key) {
			errors.push(format!("{at}: duplicate open pair {} / {}", num_str(a), num_str(b)));
			continue;
		}
		pairs.insert(key);
		out.open.push(Open { a, b, c: fa.c, one_way: matches!(ow, V::Bool(true)) });
	}

	'chains: for (i, e) in list("chains", &mut errors).iter().enumerate() {
		let at = named("chains", i, e);
		if !is_obj(e) {
			errors.push(format!("{at}: expected an object"));
			continue;
		}
		unknown_keys(e, KEYS_CHAIN, &at, &mut errors);
		claim(&e.get("id"), &at, &mut errors);
		let name = e.get("name");
		if !name.is_undef() && name.as_str().is_none_or(|s| s.trim().is_empty()) {
			errors.push(format!("{at}: name must be a non-empty string"));
		}
		let ov = e.get("open");
		let open = if ov.is_undef() { "mouth".to_string() } else { ov.to_js_string() };
		if !(ov.is_undef() || ov.as_str() == Some("mouth") || ov.as_str() == Some("both")) {
			errors.push(format!("{at}: open must be \"mouth\" or \"both\""));
		}
		let nv = e.get("nodes");
		if !nv.is_arr() || nv.len() < 2 {
			errors.push(format!("{at}: a chain needs at least 2 nodes"));
			continue;
		}
		let nodes: Vec<Option<XPt>> = nv
			.items()
			.iter()
			.enumerate()
			.map(|(k, n)| {
				let p = check_point(n, &format!("{at}.nodes[{k}]"), KEYS_NODE, frames, &mut errors);
				let get = |f: &str| if n.is_object() { n.get(f) } else { V::Undef };
				let caption = check_caption(&get("caption"), &format!("{at}.nodes[{k}].caption"), &mut errors);
				let back = check_caption(&get("back"), &format!("{at}.nodes[{k}].back"), &mut errors);
				p.map(|p| XPt { caption, back, ..p })
			})
			.collect();
		if nodes.iter().any(Option::is_none) {
			continue;
		}
		let nodes: Vec<XPt> = nodes.into_iter().map(Option::unwrap).collect();
		for k in 1..nodes.len() {
			let d = yards(&nodes[k - 1], &nodes[k]);
			if !d.is_finite() {
				errors.push(format!("{at}: nodes {} and {k} are on different continents", k - 1));
				continue 'chains;
			}
			if d > HOP_YARDS {
				errors.push(format!("{at}: nodes {} -> {k} are {} yd apart (more than {})", k - 1, num_str(js_round(d)), num_str(HOP_YARDS)));
				continue 'chains;
			}
		}
		let id = e.get("id").to_js_string();
		let name = if name.truthy() { name.to_js_string() } else { id.clone() };
		out.chains.push(Chain { id, name, open, c: nodes[0].c, nodes });
	}
	(errors, out)
}

/// readCrossingsFile: None when absent; an error listing every problem.
pub fn read_crossings_file(file: &Path, frames: &Frames) -> Result<Option<(Set, V)>, String> {
	if !file.exists() {
		return Ok(None);
	}
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	let doc = parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	let (errors, set) = validate_crossings(&doc, frames);
	if !errors.is_empty() {
		return Err(format!("{}: {} error(s)\n  {}", file.display(), errors.len(), errors.join("\n  ")));
	}
	Ok(Some((set, doc)))
}

const RECORDED_GRID: f64 = 100.0;
const RECORDED_RADIUS: f64 = 20.0;

/// recordedCrossings: zone changes in recorded play -> crossings.
pub fn recorded_crossings(steps: &[ZoneStep], frames: &Frames) -> Vec<Crossing> {
	struct G {
		c: f64,
		lo: i64,
		hi: i64,
		a: (f64, f64),
		b: (f64, f64),
		n: f64,
		sessions: IndexSet<String>,
	}
	let mut groups: IndexMap<String, G> = IndexMap::new();
	for s in steps {
		let (lo, hi) = if s.from.0 < s.to.0 { (&s.from, &s.to) } else { (&s.to, &s.from) };
		let mx = (lo.1 + hi.1) / 2.0;
		let my = (lo.2 + hi.2) / 2.0;
		let key = format!("{}:{}:{}:{}:{}", num_str(s.c), lo.0, hi.0, num_str((mx / RECORDED_GRID).floor()), num_str((my / RECORDED_GRID).floor()));
		let g = groups.entry(key).or_insert_with(|| G { c: s.c, lo: lo.0, hi: hi.0, a: (0.0, 0.0), b: (0.0, 0.0), n: 0.0, sessions: IndexSet::new() });
		g.a.0 += lo.1;
		g.a.1 += lo.2;
		g.b.0 += hi.1;
		g.b.1 += hi.2;
		g.n += 1.0;
		g.sessions.insert(s.session.clone());
	}
	let mut keys: Vec<&String> = groups.keys().collect();
	keys.sort_by(|a, b| cmp_utf16(a, b));
	let mut seen: IndexMap<String, usize> = IndexMap::new();
	keys.into_iter()
		.map(|key| {
			let g = &groups[key];
			let base = format!("recorded-{}-{}", g.lo, g.hi);
			let k = seen.get(&base).copied().unwrap_or(0) + 1;
			seen.insert(base.clone(), k);
			let end = |map: i64, sx: f64, sy: f64| {
				let wx = round(sx / g.n, 1);
				let wy = round(sy / g.n, 1);
				let p = frames.to_map(map, g.c, wx, wy);
				XPt { map: map as f64, x: p.map(|p| round(p.0, 2)), y: p.map(|p| round(p.1, 2)), r: RECORDED_RADIUS, z: None, c: g.c, wx, wy, caption: None, back: None }
			};
			let mut sessions: Vec<String> = g.sessions.iter().cloned().collect();
			sessions.sort_by(|a, b| cmp_utf16(a, b));
			Crossing { id: format!("{base}-{k}"), a: end(g.lo, g.a.0, g.a.1), b: end(g.hi, g.b.0, g.b.1), ab: None, ba: None, one_way: false, recorded: Some((g.n, sessions)) }
		})
		.collect()
}

/// `, z = <height>` when the point has one (after wy, as the planner reads it).
fn z_lua(p: &XPt) -> String {
	p.z.map_or(String::new(), |z| format!(", z = {}", num_str(z)))
}

fn end_lua(p: &XPt) -> String {
	format!("{{ map = {}, c = {}, wx = {}, wy = {}{}, r = {} }}", num_str(p.map), num_str(p.c), num_str(p.wx), num_str(p.wy), z_lua(p), num_str(p.r))
}

/// The live frames (map-frames.json `forever`), ids as the object keys.
pub type Live = IndexMap<String, Frame>;

struct ZoneRow {
	map: i64,
	name: String,
	f: Frame,
}

fn zone_table(set: &Set, frames: &Frames, complete: bool, live: &Live) -> (Vec<ZoneRow>, Vec<i64>) {
	let mut maps: IndexSet<i64> = IndexSet::new();
	for e in &set.crossings {
		maps.insert(e.a.map as i64);
		maps.insert(e.b.map as i64);
	}
	for e in &set.open {
		maps.insert(e.a as i64);
		maps.insert(e.b as i64);
	}
	for ch in &set.chains {
		for n in &ch.nodes {
			maps.insert(n.map as i64);
		}
	}
	let frame_of = |map: i64| live.get(&map.to_string()).copied().or_else(|| frames.frame(map));
	let mut sorted: Vec<i64> = maps.iter().copied().collect();
	sorted.sort();
	let zones: Vec<ZoneRow> = sorted.iter().map(|&map| ZoneRow { map, name: frames.name(map).unwrap_or_else(|| map.to_string()), f: frame_of(map).unwrap() }).collect();
	let mut wild = Vec::new();
	if complete {
		let covered: Vec<f64> = zones.iter().map(|z| z.f.c).collect();
		let mut ids: IndexSet<i64> = frames.list.iter().map(|f| f.0).collect();
		for k in live.keys() {
			ids.insert(forge_guide::js::str_to_num(k) as i64);
		}
		for id in ids {
			let z = frames.zone(id);
			if z.truthy() && z.get("type").as_num() == Some(3.0) && frame_of(id).is_some_and(|f| covered.contains(&f.c)) && !maps.contains(&id) {
				wild.push(id);
			}
		}
		wild.sort();
	}
	(zones, wild)
}

/// The N.RegisterCrossings({...}) call for a set (lines).
pub fn crossings_lua(set: &Set, frames: &Frames, complete: bool, live: &Live) -> Vec<String> {
	let (zones, wild) = zone_table(set, frames, complete, live);
	let mut l = Vec::new();
	l.push("N.RegisterCrossings({".to_string());
	if complete {
		l.push("\t-- the continents this set covers walk between zones only through it".into());
	}
	l.push(format!("\tcomplete = {},", if complete { "true" } else { "false" }));
	l.push("\t-- uiMap = { name, continent, frame (Forever's where it redrew the map, else Era's) }".into());
	l.push("\tzones = {".into());
	for z in &zones {
		l.push(format!(
			"\t\t[{}] = {{ name = {}, c = {}, top = {}, bottom = {}, left = {}, right = {} }},",
			z.map,
			lua_str(&z.name),
			num_str(z.f.c),
			num_str(z.f.top),
			num_str(z.f.bottom),
			num_str(z.f.left),
			num_str(z.f.right)
		));
	}
	l.push("\t},".into());
	if !wild.is_empty() {
		l.push("\t-- other zones on these continents (no crossing data: walked as before)".into());
		l.push(format!("\twild = {{ {} }},", wild.iter().map(|w| w.to_string()).collect::<Vec<_>>().join(", ")));
	}
	l.push("\t-- id, ends a and b (uiMap, continent, world yards, z: the floor height when given, arrival radius), captions a->b and b->a, oneWay".into());
	l.push("\tcrossings = {".into());
	for e in &set.crossings {
		let mut parts = vec![format!("id = {}", lua_str(&e.id)), format!("a = {}", end_lua(&e.a)), format!("b = {}", end_lua(&e.b))];
		if let Some(ab) = e.ab.as_ref().filter(|s| !s.is_empty()) {
			parts.push(format!("ab = {}", lua_str(ab)));
		}
		if let Some(ba) = e.ba.as_ref().filter(|s| !s.is_empty()) {
			parts.push(format!("ba = {}", lua_str(ba)));
		}
		if e.one_way {
			parts.push("oneWay = true".into());
		}
		l.push(format!("\t\t{{ {} }},", parts.join(", ")));
	}
	l.push("\t},".into());
	if !set.open.is_empty() {
		l.push("\t-- zone a, zone b, one way (1: a -> b only)".into());
		l.push("\topen = {".into());
		for e in &set.open {
			l.push(format!("\t\t{}, {}, {},", num_str(e.a), num_str(e.b), if e.one_way { 1 } else { 0 }));
		}
		l.push("\t},".into());
	}
	if !set.chains.is_empty() {
		l.push("\t-- nodes: uiMap, continent, world yards, z (the floor height when given), radius, caption walking in, caption walking out".into());
		l.push("\tchains = {".into());
		for ch in &set.chains {
			l.push(format!("\t\t{{ id = {}, name = {}, open = {}, nodes = {{", lua_str(&ch.id), lua_str(&ch.name), lua_str(&ch.open)));
			for n in &ch.nodes {
				let mut parts = vec![format!("map = {}", num_str(n.map)), format!("c = {}", num_str(n.c)), format!("wx = {}", num_str(n.wx)), format!("wy = {}", num_str(n.wy))];
				if let Some(z) = n.z {
					parts.push(format!("z = {}", num_str(z)));
				}
				parts.push(format!("r = {}", num_str(n.r)));
				if let Some(c) = n.caption.as_ref().filter(|s| !s.is_empty()) {
					parts.push(format!("caption = {}", lua_str(c)));
				}
				if let Some(b) = n.back.as_ref().filter(|s| !s.is_empty()) {
					parts.push(format!("back = {}", lua_str(b)));
				}
				l.push(format!("\t\t\t{{ {} }},", parts.join(", ")));
			}
			l.push("\t\t} },".into());
		}
		l.push("\t},".into());
	}
	l.push("})".into());
	l
}

pub const TRAVEL_ADDON: &str = "Polestar_Travel";

/// The local data addon: (file name, text), the TOC first.
pub fn emit_travel_addon(set: &Set, frames: &Frames, live: &Live, version: &str) -> Vec<(String, String)> {
	let toc = [
		"## Interface: 16001",
		"## Title: Polestar Travel (local)",
		"## Notes: Zone crossings for Polestar's travel planner, built from an optional local crossings file. Local use only.",
		"## Author: Polestar",
		&format!("## Version: {version}"),
		"## Category: Polestar",
		"## Group: Polestar",
		"## Dependencies: Polestar",
		"",
		"Crossings.lua",
		"",
	]
	.join("\n");
	let counts = format!("{} crossing(s), {} open-ground pair(s), {} approach chain(s)", set.crossings.len(), set.open.len(), set.chains.len());
	let mut lua = vec![
		header("travel build", "the optional local crossings file (data/local/crossings.json)"),
		format!("-- {counts}. Local use only: never committed or packaged."),
		String::new(),
		"local N = Polestar and Polestar.Nav".into(),
		"if not (N and N.RegisterCrossings) then return end".into(),
		String::new(),
	];
	lua.extend(crossings_lua(set, frames, true, live));
	lua.push(String::new());
	vec![(format!("{TRAVEL_ADDON}.toc"), toc), ("Crossings.lua".into(), lua.join("\n"))]
}

/// Per continent counts: continent -> (crossings, open, chains, chain nodes), continents ascending.
pub fn crossing_counts(set: &Set) -> Vec<(f64, [usize; 4])> {
	let mut out: IndexMap<String, (f64, [usize; 4])> = IndexMap::new();
	let mut bump = |c: f64, k: usize, n: usize| {
		out.entry(num_str(c)).or_insert((c, [0; 4])).1[k] += n;
	};
	for e in &set.crossings {
		bump(e.a.c, 0, 1);
	}
	for e in &set.open {
		bump(e.c, 1, 1);
	}
	for ch in &set.chains {
		bump(ch.c, 2, 1);
		bump(ch.c, 3, ch.nodes.len());
	}
	let mut v: Vec<(f64, [usize; 4])> = out.into_values().collect();
	v.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(std::cmp::Ordering::Equal));
	v
}
