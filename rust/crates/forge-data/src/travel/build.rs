//! The build itself (tools/lib/travel/build.js buildTravel, emitLua, emitFlightLua, writeTravel).

use std::path::{Path, PathBuf};

use forge_guide::js::{cmp_utf16, num_str, parse_json, stringify, Obj, V};

use super::classicdb::load_classic_db;
use super::crossings::{crossing_counts, crossings_lua, emit_travel_addon, read_crossings_file, recorded_crossings, Crossing, Live, Set, XPt, TRAVEL_ADDON};
use super::geo::{Frame, Frames};
use super::inns::{build_inns, Inn};
use super::paths::{build_paths, live_frames_of};
use super::sources::{load_travel_tables, Loaded, Product};
use super::taxi::{build_taxi, Leg, Node, TRACK_TOLERANCE};
use super::timetable::{build_timetables, Portal, Route, Service, Teleport, Timetables};
use super::transports::{build_transports, End, Nav, Transport};
use super::{header, lua_str};

const PATH_CHUNK: usize = 1000;

pub struct Options {
	/// The checkout: package.json (the local addon's version).
	pub root: PathBuf,
	/// data/forever (map-frames, zones, npcs, objects, spawnz).
	pub data_dir: PathBuf,
	pub recordings_dir: PathBuf,
	pub sources_dir: PathBuf,
	/// The shipped crossings file (data/crossings.json); None: no shipped crossings.
	pub shipped_file: Option<PathBuf>,
	/// The optional local crossings file (default <data>/../local/crossings.json).
	pub crossings_file: PathBuf,
	/// The navigation grid (default data/local/nav4); None: no board points or heights.
	pub grid_dir: Option<PathBuf>,
	/// wago.tools Classic Era build (default: the newest cached).
	pub build: Option<String>,
	/// WoW Forever build (default: the newest cached).
	pub forever_build: Option<String>,
}

impl Options {
	/// `travel build`'s defaults for a checkout.
	pub fn new(root: &Path) -> Options {
		let data_dir = root.join("data").join("forever");
		Options {
			root: root.to_path_buf(),
			crossings_file: root.join("data").join("local").join("crossings.json"),
			data_dir,
			recordings_dir: root.join("data").join("recordings"),
			sources_dir: root.join("data").join("sources"),
			shipped_file: Some(root.join("data").join("crossings.json")),
			grid_dir: Some(root.join("data").join("local").join("nav4")),
			build: None,
			forever_build: None,
		}
	}
}

/// The texts `travel build` writes.
pub struct Output {
	/// data/forever/travel.json.
	pub travel_json: String,
	/// addon/Polestar/Nav/TravelData.lua.
	pub travel_lua: String,
	/// addon/Polestar/Maps/FlightPaths.lua.
	pub flight_lua: String,
	/// Polestar_Travel's files (name, text), only with a local crossings file.
	pub travel_addon: Option<Vec<(String, String)>>,
	pub warnings: Vec<String>,
	/// The command's report lines ("travel: build ...", local crossings counts).
	pub summary: String,
	pub local_counts: Vec<String>,
}

impl Output {
	/// Every file: name -> text (the local addon's under "Polestar_Travel/").
	pub fn files(&self) -> Vec<(String, &str)> {
		let mut out = vec![("travel.json".to_string(), self.travel_json.as_str()), ("TravelData.lua".to_string(), self.travel_lua.as_str()), ("FlightPaths.lua".to_string(), self.flight_lua.as_str())];
		for (name, text) in self.travel_addon.iter().flatten() {
			out.push((format!("{TRAVEL_ADDON}/{name}"), text.as_str()));
		}
		out
	}
}

/// Where the files go.
pub struct Targets {
	pub json: PathBuf,
	pub lua: PathBuf,
	pub flight_lua: PathBuf,
	pub travel_addon_dir: PathBuf,
}

impl Targets {
	/// The command's defaults: travel.json in the data folder, the Lua files in the addon.
	pub fn new(root: &Path, data_dir: &Path) -> Targets {
		let addon = root.join("addon");
		Targets {
			json: data_dir.join("travel.json"),
			lua: addon.join("Polestar").join("Nav").join("TravelData.lua"),
			flight_lua: addon.join("Polestar").join("Maps").join("FlightPaths.lua"),
			travel_addon_dir: addon.join(TRAVEL_ADDON),
		}
	}
}

fn write_file(file: &Path, text: &str) -> Result<(), String> {
	if let Some(dir) = file.parent() {
		std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	}
	std::fs::write(file, text).map_err(|e| format!("{}: {e}", file.display()))
}

/// writeTravel: Polestar_Travel only when the build read a local crossings file.
pub fn write(out: &Output, to: &Targets) -> Result<(), String> {
	write_file(&to.json, &out.travel_json)?;
	write_file(&to.lua, &out.travel_lua)?;
	write_file(&to.flight_lua, &out.flight_lua)?;
	for (name, text) in out.travel_addon.iter().flatten() {
		write_file(&to.travel_addon_dir.join(name), text)?;
	}
	Ok(())
}

fn read_json(file: &Path) -> Result<V, String> {
	if !file.exists() {
		return Err(format!("missing {} (run: forge data build)", file.display()));
	}
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))
}

fn package_version(root: &Path) -> Result<String, String> {
	Ok(read_json(&root.join("package.json"))?.get("version").to_js_string())
}

// --- JSON values ---------------------------------------------------------------

fn obj(pairs: Vec<(&str, V)>) -> V {
	let o = Obj::new();
	for (k, v) in pairs {
		if !v.is_undef() {
			o.set(k, v);
		}
	}
	V::Obj(o)
}

fn nums(v: &[f64]) -> V {
	V::from(v.iter().map(|&n| V::Num(n)).collect::<Vec<V>>())
}

fn strs(v: &[String]) -> V {
	V::from(v.iter().map(|s| V::from(s.as_str())).collect::<Vec<V>>())
}

fn opt<T: Into<V>>(v: Option<T>) -> V {
	v.map(Into::into).unwrap_or(V::Undef)
}

fn node_v(n: &Node) -> V {
	obj(vec![
		("id", n.id.into()),
		("name", n.name.as_str().into()),
		("short", n.short.as_str().into()),
		("c", n.c.into()),
		("wx", n.wx.into()),
		("wy", n.wy.into()),
		("map", n.map.into()),
		("x", n.x.into()),
		("y", n.y.into()),
		("faction", n.faction.into()),
		("npc", n.npc.as_ref().map(|m| V::Num(m.0)).unwrap_or(V::Null)),
		("npcName", n.npc.as_ref().map(|m| V::from(m.1.as_str())).unwrap_or(V::Null)),
	])
}

fn leg_v(l: &Leg) -> V {
	obj(vec![("path", l.path.into()), ("from", l.from.into()), ("to", l.to.into()), ("yards", l.yards.into()), ("cost", l.cost.into())])
}

fn board_v(b: (f64, f64, f64)) -> V {
	obj(vec![("wx", b.0.into()), ("wy", b.1.into()), ("z", b.2.into())])
}

fn end_v(e: &End) -> V {
	obj(vec![
		("name", e.name.as_str().into()),
		("area", opt(e.area)),
		("c", e.c.into()),
		("wx", e.wx.into()),
		("wy", e.wy.into()),
		("map", e.map.into()),
		("x", e.x.into()),
		("y", e.y.into()),
		("f", e.f.into()),
		("source", opt(e.source.as_deref())),
		("board", e.board.map(board_v).unwrap_or(V::Undef)),
		("z", opt(e.z)),
	])
}

fn transport_v(t: &Transport) -> V {
	let mut pairs = vec![
		("id", t.id.as_str().into()),
		("kind", t.kind.as_str().into()),
		("faction", t.faction.into()),
		("a", end_v(&t.a)),
		("b", end_v(&t.b)),
		("ab", t.ab.into()),
		("ba", t.ba.into()),
		("waitA", t.wait_a.into()),
		("waitB", t.wait_b.into()),
		("source", t.source.as_str().into()),
	];
	if let Some((path, client, a, b)) = &t.path {
		let w = |p: &super::geo::W| obj(vec![("c", p.c.into()), ("wx", p.wx.into()), ("wy", p.wy.into())]);
		pairs.push(("path", (*path).into()));
		pairs.push(("client", (*client).into()));
		pairs.push(("stops", obj(vec![("a", w(a)), ("b", w(b))])));
	}
	obj(pairs)
}

fn inn_v(i: &Inn) -> V {
	obj(vec![
		("location", i.location.as_str().into()),
		("names", strs(&i.names)),
		("area", opt(i.area)),
		("npc", i.npc.into()),
		("npcName", i.npc_name.as_str().into()),
		("c", i.c.into()),
		("wx", i.wx.into()),
		("wy", i.wy.into()),
		("map", i.map.into()),
		("x", i.x.into()),
		("y", i.y.into()),
		("f", i.f.into()),
	])
}

fn xpt_v(p: &XPt) -> V {
	obj(vec![
		("map", p.map.into()),
		("x", p.x.map(V::Num).unwrap_or(V::Null)),
		("y", p.y.map(V::Num).unwrap_or(V::Null)),
		("r", p.r.into()),
		("c", p.c.into()),
		("wx", p.wx.into()),
		("wy", p.wy.into()),
		("caption", opt(p.caption.as_deref())),
		("back", opt(p.back.as_deref())),
	])
}

fn crossing_v(e: &Crossing) -> V {
	let mut pairs = vec![("id", e.id.as_str().into()), ("a", xpt_v(&e.a)), ("b", xpt_v(&e.b)), ("ab", opt(e.ab.as_deref())), ("ba", opt(e.ba.as_deref())), ("oneWay", e.one_way.into())];
	if let Some((steps, sessions)) = &e.recorded {
		pairs.push(("steps", (*steps).into()));
		pairs.push(("sessions", strs(sessions)));
	}
	obj(pairs)
}

fn set_v(s: &Set) -> V {
	obj(vec![
		("crossings", s.crossings.iter().map(crossing_v).collect::<Vec<V>>().into()),
		("open", s.open.iter().map(|o| obj(vec![("a", o.a.into()), ("b", o.b.into()), ("c", o.c.into()), ("oneWay", o.one_way.into())])).collect::<Vec<V>>().into()),
		(
			"chains",
			s.chains
				.iter()
				.map(|c| {
					obj(vec![
						("id", c.id.as_str().into()),
						("name", c.name.as_str().into()),
						("open", c.open.as_str().into()),
						("c", c.c.into()),
						("nodes", c.nodes.iter().map(xpt_v).collect::<Vec<V>>().into()),
					])
				})
				.collect::<Vec<V>>()
				.into(),
		),
	])
}

fn fit_v(r: &Route) -> V {
	obj(vec![("samples", r.fit.samples.into()), ("span", r.fit.span.into()), ("speed", r.fit.speed.into())])
}

fn route_v(r: &Route) -> V {
	obj(vec![
		("kind", r.kind.as_str().into()),
		("period", r.period.into()),
		("fit", fit_v(r)),
		("stops", r.stops.iter().map(|s| nums(s)).collect::<Vec<V>>().into()),
		("frames", r.frames.iter().map(|s| nums(s)).collect::<Vec<V>>().into()),
	])
}

/// A service; `one` adds 1 to the stop indices (Lua's).
fn service_v(s: &Service, one: usize) -> V {
	let mut pairs: Vec<(&str, V)> = s.head.iter().map(|(k, v)| (*k, v.clone())).collect();
	let idx = |v: &[usize]| V::from(v.iter().map(|&i| V::Num((i + one) as f64)).collect::<Vec<V>>());
	pairs.extend([
		("board", s.board.into()),
		("pre", s.pre.into()),
		("post", s.post.into()),
		("routes", s.routes.iter().map(|p| obj(vec![("route", p.route.as_str().into()), ("a", idx(&p.a)), ("b", idx(&p.b))])).collect::<Vec<V>>().into()),
		("wait", obj(vec![("a", s.wait.0.into()), ("b", s.wait.1.into())])),
		("ride", obj(vec![("a", s.ride.0.into()), ("b", s.ride.1.into())])),
	]);
	obj(pairs)
}

fn portal_v(p: &Portal) -> V {
	obj(vec![
		("id", p.id.as_str().into()),
		("name", p.name.as_str().into()),
		("area", p.area.into()),
		("a", end_v(&p.a)),
		("b", end_v(&p.b)),
		("seconds", p.seconds.into()),
		("source", p.source.as_str().into()),
	])
}

/// A teleport; `to` given as the Lua array when `lua_to`.
fn teleport_v(t: &Teleport, lua_to: bool) -> V {
	let mut pairs = vec![("spell", t.spell.into()), ("name", t.name.as_str().into()), ("cast", t.cast.into()), ("reagents", t.reagents.as_deref().map(nums).unwrap_or(V::Undef))];
	if t.bind {
		pairs.push(("bind", true.into()));
	}
	if let Some(to) = &t.to {
		pairs.push(("to", if lua_to { to_lua_end(to, false) } else { end_v(to) }));
	}
	obj(pairs)
}

// --- Lua ---------------------------------------------------------------------

fn lua_num(n: f64) -> Result<String, String> {
	if !n.is_finite() {
		return Err(format!("non-finite number in travel data: {}", num_str(n)));
	}
	Ok(num_str(n))
}

fn is_ident(k: &str) -> bool {
	let b = k.as_bytes();
	!b.is_empty() && (b[0].is_ascii_alphabetic() || b[0] == b'_') && b.iter().all(|c| c.is_ascii_alphanumeric() || *c == b'_')
}

/// luaVal.
fn lua_val(v: &V) -> Result<String, String> {
	Ok(match v {
		V::Num(n) => lua_num(*n)?,
		V::Str(s) => lua_str(s),
		V::Bool(b) => if *b { "true" } else { "false" }.to_string(),
		V::Null | V::Undef => "nil".to_string(),
		V::Arr(a) => format!("{{{}}}", a.to_vec().iter().map(lua_val).collect::<Result<Vec<_>, _>>()?.join(",")),
		V::Obj(o) => {
			let mut keys = o.keys();
			keys.sort_by(|a, b| cmp_utf16(a, b));
			let mut parts = Vec::with_capacity(keys.len());
			for k in keys {
				let key = if is_ident(&k) { k.to_string() } else { format!("[{}]", lua_str(&k)) };
				parts.push(format!("{key}={}", lua_val(&o.get(&k))?));
			}
			format!("{{{}}}", parts.join(","))
		}
	})
}

/// emitLua's end(e): [name, c, wx, wy, map, x, y, f, area(, board | z)]; `extra` adds the board or z.
fn to_lua_end(e: &End, extra: bool) -> V {
	let mut v = vec![e.name.as_str().into(), e.c.into(), e.wx.into(), e.wy.into(), e.map.into(), e.x.into(), e.y.into(), e.f.into(), opt(e.area)];
	if extra {
		if let Some(b) = e.board {
			v.push(board_v(b));
		} else if let Some(z) = e.z {
			v.push(z.into());
		}
	}
	V::from(v)
}

fn transit_lua(t: &Timetables) -> Result<Vec<String>, String> {
	if t.routes.is_empty() && t.teleports.is_empty() {
		return Ok(Vec::new());
	}
	let mut lines: Vec<String> = [
		"",
		"-- Timetables (Nav/Transit.lua). routes[id] = { kind, period (ms), fit = observer thresholds,",
		"--   stops = { { arrive, depart (ms into the loop; depart < arrive spans its start), continent, wx, wy[, z, car] } },",
		"--   frames = { { arrive, depart, continent, wx, wy, jump (1: the next frame is reached by teleport)[, z] } } }",
		"-- services[transport or lift id] = { kind, name, board (s at the dock before it leaves), pre/post (s outside",
		"--   the ride), wait/ride = { a, b } expected s while untimed, routes = { { route, a = stops, b = stops } } }",
		"--   (a, b: indices into the route's stops, from 1)",
		"--   (ends = the a and b names, areas = their AreaTable areas; area: the tram's or the lift's, dir: which of",
		"--   that place's lifts; lifts: a = top, b = bottom, with c, wx, wy and the top and bottom z)",
		"-- teleports: class teleports { spell, name, cast (s), reagents = { item, count, ... }, to = end | bind = true }",
		"if ns.Transit and ns.Transit.Register then",
		"\tns.Transit.Register({",
		"\t\troutes = {",
	]
	.iter()
	.map(|s| s.to_string())
	.collect();
	for (id, r) in &t.routes {
		lines.push(format!("\t\t\t[{}] = {{ kind = {}, period = {}, fit = {},", lua_str(id), lua_str(&r.kind), lua_num(r.period)?, lua_val(&fit_v(r))?));
		lines.push(format!("\t\t\t\tstops = {},", lua_val(&V::from(r.stops.iter().map(|s| nums(s)).collect::<Vec<V>>()))?));
		lines.push("\t\t\t\tframes = {".into());
		for f in &r.frames {
			lines.push(format!("\t\t\t\t\t{},", lua_val(&nums(f))?));
		}
		lines.push("\t\t\t\t},".into());
		lines.push("\t\t\t},".into());
	}
	lines.push("\t\t},".into());
	lines.push("\t\tservices = {".into());
	for (id, s) in &t.services {
		lines.push(format!("\t\t\t[{}] = {},", lua_str(id), lua_val(&service_v(s, 1))?));
	}
	lines.push("\t\t},".into());
	lines.push("\t\tteleports = {".into());
	for tp in &t.teleports {
		lines.push(format!("\t\t\t{},", lua_val(&teleport_v(tp, true))?));
	}
	lines.push("\t\t},".into());
	lines.push("\t})".into());
	lines.push("end".into());
	Ok(lines)
}

struct Emit<'a> {
	build: &'a str,
	forever_build: Option<&'a str>,
	transit_build: Option<&'a str>,
	cmangos_rev: Option<&'a str>,
	area_build: Option<String>,
	sessions: usize,
	nodes: &'a [Node],
	legs: &'a [Leg],
	transports: &'a [Transport],
	transit: &'a Timetables,
	inns: &'a [Inn],
	shipped: Option<(&'a Set, &'a str)>,
	recorded: &'a [Crossing],
	paths: &'a super::paths::Paths,
	frames: &'a Frames,
	live: &'a Live,
}

fn emit_lua(t: &Emit) -> Result<String, String> {
	let mut lines: Vec<String> = Vec::new();
	lines.push(header("travel build", "the client tables, CMaNGOS classic-db, data/forever and data/recordings"));
	lines.push(format!("-- Blizzard Classic Era client tables (wago.tools build {}): TaxiNodes, TaxiPath,", t.build));
	lines.push("-- TaxiPathNode, AreaTrigger; WoW Forever client TaxiPathNode (wago.tools build".into());
	lines.push(format!("-- {}) for the ships Forever added; docks and inns placed from data/forever (pfQuest, MIT);", t.forever_build.unwrap_or("none")));
	lines.push(format!("-- learned walking paths from {} recorded session(s).", t.sessions));
	lines.push("-- Timetables, portals and teleports: WoW Forever TransportAnimation and spell tables (wago.tools build".into());
	lines.push(format!("-- {}), CMaNGOS classic-db {} (spawns, areatrigger_teleport,", t.transit_build.unwrap_or("none"), t.cmangos_rev.map(|r| &r[..7]).unwrap_or("none")));
	lines.push("-- spell_target_position, sniffed transport periods) and the CMaNGOS transport model, after".into());
	lines.push("-- Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later, used with permission).".into());
	lines.push("-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.".into());
	lines.push(String::new());
	lines.push("local ADDON, ns = ...".into());
	lines.push("local N = ns.Nav".into());
	lines.push("if not (N and N.RegisterTravelData) then return end".into());
	lines.push(String::new());
	lines.push("N.RegisterTravelData({".into());
	lines.push(format!("\tbuild = {},", lua_str(t.build)));
	lines.push("\t-- id, continent, wx, wy, uiMapID, x, y (Era frame), faction mask (1 Alliance, 2 Horde), name".into());
	lines.push("\ttaxi = {".into());
	for n in t.nodes {
		let v = V::from(vec![n.id.into(), n.c.into(), n.wx.into(), n.wy.into(), n.map.into(), n.x.into(), n.y.into(), n.faction.into(), n.name.as_str().into()]);
		lines.push(format!("\t\t{},", lua_val(&v)?));
	}
	lines.push("\t},".into());
	lines.push("\t-- one-way flights: from, to, yards flown".into());
	lines.push("\tflights = {".into());
	for l in t.legs {
		lines.push(format!("\t\t{},{},{},", num_str(l.from), num_str(l.to), num_str(l.yards)));
	}
	lines.push("\t},".into());
	lines.push("\t-- ends: name, continent, wx, wy, uiMapID, x, y, frame (\"e\" Era, \"l\" live), AreaTable area (its name in the client's language)".into());
	lines.push("\t-- [, board = { wx, wy, z }: where a ship lying off its pier is boarded, on the deck; or z: the height of the floor the walk to the end ends on]; seconds riding a->b, b->a and waiting at a, b".into());
	lines.push("\ttransports = {".into());
	for tr in t.transports {
		let v = obj(vec![
			("id", tr.id.as_str().into()),
			("kind", tr.kind.as_str().into()),
			("faction", tr.faction.into()),
			("a", to_lua_end(&tr.a, true)),
			("b", to_lua_end(&tr.b, true)),
			("ab", tr.ab.into()),
			("ba", tr.ba.into()),
			("waitA", tr.wait_a.into()),
			("waitB", tr.wait_b.into()),
		]);
		lines.push(format!("\t\t{},", lua_val(&v)?));
	}
	lines.push("\t},".into());
	lines.push("\t-- walk-in portals, one way a -> b: id, destination name and area, ends as transports (with z), seconds (the loading screen)".into());
	lines.push("\tportals = {".into());
	for p in &t.transit.portals {
		let v = obj(vec![
			("id", p.id.as_str().into()),
			("name", p.name.as_str().into()),
			("area", p.area.into()),
			("a", to_lua_end(&p.a, true)),
			("b", to_lua_end(&p.b, true)),
			("seconds", p.seconds.into()),
		]);
		lines.push(format!("\t\t{},", lua_val(&v)?));
	}
	lines.push("\t},".into());
	lines.push(format!("\t-- bind location names (as GetBindLocation reports them), AreaTable area (WoW Forever client build {}), innkeeper NPC, position", t.area_build.as_deref().unwrap_or("none")));
	lines.push("\tinns = {".into());
	for i in t.inns {
		let v = obj(vec![
			("names", strs(&i.names)),
			("area", opt(i.area)),
			("npc", i.npc.into()),
			("c", i.c.into()),
			("wx", i.wx.into()),
			("wy", i.wy.into()),
			("map", i.map.into()),
			("x", i.x.into()),
			("y", i.y.into()),
			("f", i.f.into()),
		]);
		lines.push(format!("\t\t{},", lua_val(&v)?));
	}
	lines.push("\t},".into());
	lines.push("})".into());
	lines.extend(transit_lua(t.transit)?);
	if let Some((shipped, source)) = t.shipped {
		lines.push(format!("-- zone crossings: {source}"));
		lines.extend(crossings_lua(shipped, t.frames, true, t.live));
	}
	if !t.recorded.is_empty() {
		lines.push("-- zone crossings learned from recorded play (used where a continent has full crossing data)".into());
		let set = Set { crossings: t.recorded.to_vec(), open: Vec::new(), chains: Vec::new() };
		lines.extend(crossings_lua(&set, t.frames, false, t.live));
	}
	for part in t.paths.nodes.chunks(PATH_CHUNK) {
		lines.push("-- learned path nodes: continent, wx, wy, gateway (1 = zone-border crossing), uiMap".into());
		lines.push("N.AddTravelPaths((function() return { nodes = {".into());
		for n in part {
			lines.push(format!("\t{},{},{},{},{},", num_str(n.c), num_str(n.wx), num_str(n.wy), if n.gateway.is_some() { 1 } else { 0 }, n.map));
		}
		lines.push("} } end)())".into());
	}
	for part in t.paths.edges.chunks(PATH_CHUNK) {
		lines.push("-- learned path edges: node, node, yards".into());
		lines.push("N.AddTravelPaths((function() return { edges = {".into());
		for e in part {
			lines.push(format!("\t{},{},{},", e.a, e.b, num_str(e.yards)));
		}
		lines.push("} } end)())".into());
	}
	Ok(format!("{}\n", lines.join("\n")))
}

/// The flights' tracks: ns.FlightTracks[from][to] = { wx, wy, ... }.
fn emit_flight_lua(build: &str, legs: &[Leg]) -> Result<String, String> {
	let mut lines: Vec<String> = Vec::new();
	lines.push(header("travel build", "the client tables"));
	lines.push("-- What each flight in TravelData.lua flies: Blizzard Classic Era TaxiPathNode (wago.tools build".into());
	lines.push(format!("-- {build}), on the ground plane, simplified to {} yards and rounded to the yard.", num_str(TRACK_TOLERANCE)));
	lines.push("-- ns.FlightTracks[from][to] = { wx, wy, wx, wy, ... } (taxi node ids, world yards: wx north, wy west).".into());
	lines.push("-- Drawn by Maps/RouteLines.lua.".into());
	lines.push(String::new());
	lines.push("local ADDON, ns = ...".into());
	lines.push(String::new());
	lines.push("ns.FlightTracks = {".into());
	let mut from: Option<f64> = None;
	for l in legs {
		let Some(track) = &l.track else { continue };
		if from != Some(l.from) {
			if from.is_some() {
				lines.push("\t},".into());
			}
			from = Some(l.from);
			lines.push(format!("\t[{}] = {{", num_str(l.from)));
		}
		let t: Vec<String> = track.iter().map(|&n| lua_num(n)).collect::<Result<_, _>>()?;
		lines.push(format!("\t\t[{}] = {{{}}},", num_str(l.to), t.join(",")));
	}
	if from.is_some() {
		lines.push("\t},".into());
	}
	lines.push("}".into());
	Ok(format!("{}\n", lines.join("\n")))
}

// --- build ---------------------------------------------------------------------

fn tables_source(name: &str, t: &Loaded, use_: Option<&str>) -> V {
	let urls = Obj::new();
	for (k, u) in &t.urls {
		urls.set(k, u.as_str());
	}
	let tables: Vec<V> = t.urls.keys().map(|k| V::from(*k)).collect();
	obj(vec![("name", name.into()), ("build", t.build.as_str().into()), ("tables", tables.into()), ("urls", urls.into()), ("use", opt(use_))])
}

/// buildTravel: every output's text.
pub fn build(o: &Options) -> Result<Output, String> {
	let map_frames = read_json(&o.data_dir.join("map-frames.json"))?;
	let zones = read_json(&o.data_dir.join("zones.json"))?;
	let frames = Frames::new(&map_frames.get("era"), &zones);
	let npcs = read_json(&o.data_dir.join("npcs.json"))?;
	let objects = read_json(&o.data_dir.join("objects.json"))?;
	let spawnz_file = o.data_dir.join("spawnz.json");
	let spawnz = if spawnz_file.exists() { read_json(&spawnz_file)? } else { V::Null };
	let recordings = crate::recordings::read_recordings(&o.recordings_dir)?;
	let mut live = live_frames_of(&recordings);
	let forever_frames = map_frames.get("forever");
	let mut live_obj: Live = Live::new();
	if let Some(f) = forever_frames.as_obj() {
		for (id, b) in f.entries() {
			let fr = Frame::of(&b);
			live.entry(forge_guide::js::str_to_num(&id) as i64).or_insert(fr);
			live_obj.insert(id.to_string(), fr);
		}
	}
	let src = load_travel_tables(&o.sources_dir, o.build.as_deref(), Product::Era)?;
	let (forever, forever_error) = match load_travel_tables(&o.sources_dir, o.forever_build.as_deref(), Product::Forever) {
		Ok(f) => (Some(f), String::new()),
		Err(e) => (None, e),
	};
	let mut transit_warnings = Vec::new();
	let transit_build = forever.as_ref().map(|f| f.build.clone()).or_else(|| o.forever_build.clone());
	let transit_tables = match load_travel_tables(&o.sources_dir, transit_build.as_deref(), Product::Transit) {
		Ok(t) => Some(t),
		Err(e) => {
			transit_warnings.push(format!("timetable client tables: {e}"));
			None
		}
	};
	let db = match load_classic_db(&o.sources_dir) {
		Ok(d) => Some(d),
		Err(e) => {
			transit_warnings.push(format!("CMaNGOS classic-db: {e}"));
			None
		}
	};

	let taxi = build_taxi(src.rows("TaxiNodes"), src.rows("TaxiPath"), src.rows("TaxiPathNode"), &frames, &npcs, &live);
	let nav = o.grid_dir.as_deref().and_then(Nav::open);
	let grid_warnings: Vec<String> = if nav.is_some() {
		Vec::new()
	} else {
		let at = o.grid_dir.as_ref().map(|d| format!(" at {}", d.display())).unwrap_or_default();
		vec![format!("no navigation grid{at}: the transports and portals get no board points or heights (`nav build`, or --grid)")]
	};
	let mut tr = build_transports(
		src.rows("TaxiPathNode"),
		src.rows("AreaTrigger"),
		forever.as_ref().map(|f| (f.rows("TaxiPathNode"), f.build.as_str())),
		&forever_error,
		&frames,
		&npcs,
		&objects,
		&live,
		nav.as_ref(),
		&spawnz,
	);
	let transit = build_timetables(
		src.rows("TaxiPathNode"),
		src.rows("AreaTrigger"),
		forever.as_ref().map(|f| f.rows("TaxiPathNode")),
		transit_tables.as_ref(),
		db.as_ref().map(|d| &d.data),
		&mut tr.transports,
		&frames,
		&live,
		nav.as_ref(),
	);
	let areas = forge_guide::areas::load_areas(&o.sources_dir);
	let (inns, inn_warnings) = build_inns(&frames, &npcs, &live, &areas, &zones);
	let area_warnings: Vec<String> =
		if areas.truthy() { Vec::new() } else { vec![format!("no cached WoW Forever AreaTable under {}: the inns get no area (`data build` downloads it)", o.sources_dir.join("wago").display())] };
	let paths = build_paths(&recordings, &frames);
	let recorded = recorded_crossings(&paths.zone_steps, &frames);
	let local = read_crossings_file(&o.crossings_file, &frames)?;
	let shipped = match &o.shipped_file {
		Some(f) => read_crossings_file(f, &frames)?.map(|(set, doc)| {
			let s = doc.get("source");
			let source = if s.truthy() { s.to_js_string() } else { f.file_name().map(|n| n.to_string_lossy().to_string()).unwrap_or_default() };
			(set, source)
		}),
		None => None,
	};
	let mut warnings: Vec<String> = Vec::new();
	warnings.extend(src.warnings.iter().cloned());
	if let Some(f) = &forever {
		warnings.extend(f.warnings.iter().cloned());
	}
	if let Some(t) = &transit_tables {
		warnings.extend(t.warnings.iter().cloned());
	}
	warnings.extend(transit_warnings);
	warnings.extend(taxi.warnings.iter().cloned());
	warnings.extend(grid_warnings);
	warnings.extend(tr.warnings.iter().cloned());
	warnings.extend(transit.warnings.iter().cloned());
	warnings.extend(area_warnings);
	warnings.extend(inn_warnings);
	warnings.extend(paths.warnings.iter().cloned());

	let mut sources: Vec<V> = vec![tables_source("Blizzard Classic Era client tables (wago.tools)", &src, None)];
	if let Some(f) = &forever {
		sources.push(tables_source("WoW Forever client tables (wago.tools)", f, Some("ship loops Forever added")));
	}
	if let Some(t) = &transit_tables {
		sources.push(tables_source("WoW Forever client tables (wago.tools)", t, Some("lift and tram tracks, class teleports")));
	}
	if let Some(d) = &db {
		sources.push(obj(vec![
			("name", "CMaNGOS classic-db (GPL-3.0)".into()),
			("rev", d.rev.into()),
			("url", d.url.as_str().into()),
			("use", "lift and tram spawns, portal and teleport destinations; sniffed transport periods".into()),
		]));
	}
	let area_build = if areas.truthy() { Some(areas.get("build").to_js_string()) } else { None };
	if let Some(b) = &area_build {
		sources.push(obj(vec![
			("name", "WoW Forever client tables (wago.tools)".into()),
			("build", b.as_str().into()),
			("tables", vec![V::from("AreaTable")].into()),
			("use", "the area of each inn".into()),
		]));
	}
	sources.push(obj(vec![
		("name", "Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later, used with permission)".into()),
		("use", "the timetable model, observer and data choices, ported".into()),
	]));
	sources.push(obj(vec![("name", "data/forever npcs.json / objects.json (pfQuest, MIT)".into()), ("use", "flight masters, dock NPCs/objects, innkeepers".into())]));
	sources.push(obj(vec![("name", "data/forever map-frames.json".into()), ("use", "Era map frames; Forever (live) frames for maps Forever added or redrew".into())]));
	sources.push(obj(vec![("name", "data/recordings".into()), ("use", "learned walking paths and recorded zone crossings".into()), ("sessions", strs(&paths.sessions))]));
	if spawnz.truthy() {
		sources.push(obj(vec![("name", "data/forever spawnz.json (CMaNGOS classic-db, GPL-3.0)".into()), ("use", "the heights of the dock NPCs the zeppelin and wharf ends stand at".into())]));
	}
	if let Some((_, source)) = &shipped {
		sources.push(obj(vec![
			("name", "Carbonite (github.com/IrcDirk/Carbonite-Classic, GPL-3.0)".into()),
			("source", source.as_str().into()),
			("use", "zone crossings (data/crossings.json)".into()),
		]));
	}
	let routes = Obj::new();
	for (id, r) in &transit.routes {
		routes.set(id, route_v(r));
	}
	let services = Obj::new();
	for (id, s) in &transit.services {
		services.set(id, service_v(s, 0));
	}
	let null_or = |s: Option<&str>| s.map(V::from).unwrap_or(V::Null);
	let counts = obj(vec![
		("taxiNodes", taxi.nodes.len().into()),
		("flights", taxi.legs.len().into()),
		("transports", tr.transports.len().into()),
		("inns", inns.len().into()),
		("pathNodes", paths.nodes.len().into()),
		("pathEdges", paths.edges.len().into()),
		("recordedCrossings", recorded.len().into()),
		("shippedCrossings", shipped.as_ref().map(|s| s.0.crossings.len()).unwrap_or(0).into()),
		("timetables", transit.services.len().into()),
		("portals", transit.portals.len().into()),
		("teleports", transit.teleports.len().into()),
	]);
	let travel = obj(vec![
		("schema", 1.0.into()),
		("build", src.build.as_str().into()),
		("foreverBuild", null_or(forever.as_ref().map(|f| f.build.as_str()))),
		("transitBuild", null_or(transit_tables.as_ref().map(|t| t.build.as_str()))),
		("cmangosRev", null_or(db.as_ref().map(|d| d.rev))),
		("areaBuild", null_or(area_build.as_deref())),
		("sources", sources.into()),
		("counts", counts),
		("taxi", obj(vec![("nodes", taxi.nodes.iter().map(node_v).collect::<Vec<V>>().into()), ("legs", taxi.legs.iter().map(leg_v).collect::<Vec<V>>().into())])),
		("transports", tr.transports.iter().map(transport_v).collect::<Vec<V>>().into()),
		("inns", inns.iter().map(inn_v).collect::<Vec<V>>().into()),
		(
			"paths",
			obj(vec![
				(
					"nodes",
					paths
						.nodes
						.iter()
						.map(|n| {
							obj(vec![
								("id", n.id.into()),
								("c", n.c.into()),
								("wx", n.wx.into()),
								("wy", n.wy.into()),
								("map", n.map.into()),
								("gateway", n.gateway.as_ref().map(|g| V::from(g.iter().map(|&m| V::from(m)).collect::<Vec<V>>())).unwrap_or(V::Undef)),
							])
						})
						.collect::<Vec<V>>()
						.into(),
				),
				(
					"edges",
					paths
						.edges
						.iter()
						.map(|e| obj(vec![("a", e.a.into()), ("b", e.b.into()), ("yards", e.yards.into()), ("n", e.n.into()), ("sessions", strs(&e.sessions))]))
						.collect::<Vec<V>>()
						.into(),
				),
				("sessions", strs(&paths.sessions)),
			]),
		),
		(
			"crossings",
			obj(vec![
				("recorded", recorded.iter().map(crossing_v).collect::<Vec<V>>().into()),
				("shipped", shipped.as_ref().map(|s| set_v(&s.0)).unwrap_or(V::Null)),
				("shippedSource", null_or(shipped.as_ref().map(|s| s.1.as_str()))),
			]),
		),
		(
			"transit",
			obj(vec![
				("routes", routes.into()),
				("services", services.into()),
				("portals", transit.portals.iter().map(portal_v).collect::<Vec<V>>().into()),
				("teleports", transit.teleports.iter().map(|t| teleport_v(t, false)).collect::<Vec<V>>().into()),
			]),
		),
		("warnings", strs(&warnings)),
	]);
	let emit = Emit {
		build: &src.build,
		forever_build: forever.as_ref().map(|f| f.build.as_str()),
		transit_build: transit_tables.as_ref().map(|t| t.build.as_str()),
		cmangos_rev: db.as_ref().map(|d| d.rev),
		area_build: area_build.clone(),
		sessions: paths.sessions.len(),
		nodes: &taxi.nodes,
		legs: &taxi.legs,
		transports: &tr.transports,
		transit: &transit,
		inns: &inns,
		shipped: shipped.as_ref().map(|s| (&s.0, s.1.as_str())),
		recorded: &recorded,
		paths: &paths,
		frames: &frames,
		live: &live_obj,
	};
	let travel_lua = emit_lua(&emit)?;
	let flight_lua = emit_flight_lua(&src.build, &taxi.legs)?;
	let travel_addon = match &local {
		Some((set, _)) => Some(emit_travel_addon(set, &frames, &live_obj, &package_version(&o.root)?)),
		None => None,
	};
	let summary = format!(
		"travel: build {}: {} flight masters, {} flights, {} transports, {} inns, {} learned path nodes / {} edges, {} recorded crossings, {} shipped crossings",
		src.build,
		taxi.nodes.len(),
		taxi.legs.len(),
		tr.transports.len(),
		inns.len(),
		paths.nodes.len(),
		paths.edges.len(),
		recorded.len(),
		shipped.as_ref().map(|s| s.0.crossings.len()).unwrap_or(0)
	);
	let local_counts = match &local {
		Some((set, _)) => crossing_counts(set)
			.into_iter()
			.map(|(c, n)| {
				let name = if c == 0.0 {
					"Eastern Kingdoms".to_string()
				} else if c == 1.0 {
					"Kalimdor".to_string()
				} else {
					format!("continent {}", num_str(c))
				};
				format!("local crossings, {name}: {} crossings, {} open-ground pairs, {} approach chains ({} nodes)", n[0], n[1], n[2], n[3])
			})
			.collect(),
		None => Vec::new(),
	};
	Ok(Output { travel_json: format!("{}\n", stringify(&travel, Some("\t"))), travel_lua, flight_lua, travel_addon, warnings, summary, local_counts })
}
