//! The quest atlas (port of tools/lib/judge/atlas.js, extended): per zone map, the places quests
//! are worked (camps of quest NPCs and objects, grouped into areas named by the client's
//! subzones), the hubs (quest givers clustered), each quest's roles (the areas of its givers,
//! enders and objectives), and, beyond the JS: the camps several quests share and the zone's
//! chain links (prerequisite arrows and breadcrumbs), as data rather than markdown only.
//!
//! Ground truth for subzones: a `SubzoneOf` (the walking grid's tile heads carry the AreaTable
//! id of each 16x16 chunk; `GridSubzones` reads them, native only).

use crate::data::{GameData, Quest};
use crate::prereqs::blocking_prereqs;
use crate::world::World;
use forge_core::{js_hypot, Faction, Frame, Projector};
use rustc_hash::FxHashMap;
use std::collections::BTreeMap;

pub const CAMP_LINK: f64 = 80.0;
pub const CAMP_SPAN: f64 = 300.0;
pub const AREA_LINK: f64 = 200.0;
pub const AREA_SPAN: f64 = 600.0;
pub const HUB_LINK: f64 = 120.0;
pub const HUB_SPAN: f64 = 400.0;
pub const HUB_GIVERS: usize = 3;
const SPAWN_CAP: usize = 400;
const NODE_PTS: usize = 40;
/// Percent: rarer drops are not a quest's camp.
const DROP_MIN: f64 = 5.0;
const LOCATE_ROLE: f64 = 300.0;
const LOCATE_ANY: f64 = 200.0;
const GRID_CELL: f64 = 250.0;

/// A client area (subzone) and the zone it lies in.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Subzone {
	pub id: u32,
	pub name: String,
	pub zone_id: u32,
	pub zone: String,
}

/// Which client area a world point lies in.
pub trait SubzoneOf {
	fn at(&self, c: i64, wx: f64, wy: f64) -> Option<Subzone>;
}

/// Single linkage within `link` yards, merging only while the cluster's box stays at most
/// `span` across (atlas.js capLink). -> groups of indices, in order of their first member.
pub fn cap_link(items: &[(f64, f64)], link: f64, span: f64) -> Vec<Vec<usize>> {
	let n = items.len();
	let mut parent: Vec<usize> = (0..n).collect();
	let mut bx: Vec<[f64; 4]> = items.iter().map(|p| [p.0, p.0, p.1, p.1]).collect();
	fn find(parent: &mut [usize], mut i: usize) -> usize {
		while parent[i] != i {
			parent[i] = parent[parent[i]];
			i = parent[i];
		}
		i
	}
	let mut grid: FxHashMap<(i64, i64), Vec<usize>> = FxHashMap::default();
	for (i, p) in items.iter().enumerate() {
		grid.entry(((p.0 / link).floor() as i64, (p.1 / link).floor() as i64)).or_default().push(i);
	}
	let mut edges: Vec<(f64, usize, usize)> = Vec::new();
	for (i, p) in items.iter().enumerate() {
		let gx = (p.0 / link).floor() as i64;
		let gy = (p.1 / link).floor() as i64;
		for x in gx - 1..=gx + 1 {
			for y in gy - 1..=gy + 1 {
				for &j in grid.get(&(x, y)).into_iter().flatten() {
					if j <= i {
						continue;
					}
					let d = js_hypot(items[j].0 - p.0, items[j].1 - p.1);
					if d <= link {
						edges.push((d, i, j));
					}
				}
			}
		}
	}
	edges.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap().then(a.1.cmp(&b.1)).then(a.2.cmp(&b.2)));
	for (_, i, j) in edges {
		let a = find(&mut parent, i);
		let b = find(&mut parent, j);
		if a == b {
			continue;
		}
		let (aa, bb) = (bx[a], bx[b]);
		let m = [aa[0].min(bb[0]), aa[1].max(bb[1]), aa[2].min(bb[2]), aa[3].max(bb[3])];
		if js_hypot(m[1] - m[0], m[3] - m[2]) > span {
			continue;
		}
		let (r, s) = if a < b { (a, b) } else { (b, a) };
		parent[s] = r;
		bx[r] = m;
	}
	let mut groups: Vec<(usize, Vec<usize>)> = Vec::new();
	let mut at: FxHashMap<usize, usize> = FxHashMap::default();
	for i in 0..n {
		let r = find(&mut parent, i);
		let g = *at.entry(r).or_insert_with(|| {
			groups.push((r, Vec::new()));
			groups.len() - 1
		});
		groups[g].1.push(i);
	}
	groups.into_iter().map(|g| g.1).collect()
}

const COMPASS: [&str; 8] = ["E", "NE", "N", "NW", "W", "SW", "S", "SE"];

/// The bearing from a to b as a compass point (world x north, y west).
pub fn compass(a: (f64, f64), b: (f64, f64)) -> &'static str {
	let ang = (b.0 - a.0).atan2(-(b.1 - a.1));
	let k = (forge_core::js_round(ang / (std::f64::consts::PI / 4.0)) + 8.0) as i64 % 8;
	COMPASS[k as usize]
}

#[derive(Clone, Debug)]
pub struct AtlasNode {
	/// `${kind}:${id}@${map}#${k}` (kind 'npc' | 'obj').
	pub key: String,
	pub kind: &'static str,
	pub id: u32,
	pub name: String,
	pub map: u32,
	pub c: i64,
	pub wx: f64,
	pub wy: f64,
	pub n: u32,
	pub pts: Vec<(f64, f64)>,
	pub area: Option<usize>,
	pub subzone: Option<Subzone>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct ObjAt {
	/// 1-based objective index.
	pub oi: usize,
	pub node: usize,
	pub n: u32,
}

#[derive(Clone, Debug)]
pub struct AtlasArea {
	/// `${map}/${index}`.
	pub id: String,
	pub map: u32,
	pub c: i64,
	pub subzone: Option<Subzone>,
	pub wx: f64,
	pub wy: f64,
	pub n: u32,
	pub nodes: Vec<usize>,
	pub hub: Option<String>,
	pub name: String,
	base: String,
	/// Quests given, turned in, worked here (insertion-ordered sets).
	pub give: Vec<u32>,
	pub end: Vec<u32>,
	pub obj: Vec<(u32, Vec<ObjAt>)>,
}

#[derive(Clone, Debug)]
pub struct AtlasHub {
	pub name: String,
	pub areas: Vec<String>,
	pub givers: Vec<String>,
	pub quests: Vec<u32>,
}

/// A camp two or more quests work (extension): the target and the quests.
#[derive(Clone, Debug, PartialEq)]
pub struct SharedCamp {
	pub area: usize,
	pub kind: &'static str,
	pub id: u32,
	pub name: String,
	pub quests: Vec<u32>,
}

#[derive(Clone, Debug, Default)]
pub struct AtlasZone {
	pub map: u32,
	pub areas: Vec<usize>,
	pub hubs: Vec<AtlasHub>,
	/// Prerequisite arrows among the zone's quests (given here): (from, to).
	pub chains: Vec<(u32, u32)>,
	/// Breadcrumbs among them: (breadcrumb, target).
	pub breadcrumbs: Vec<(u32, u32)>,
	pub shared: Vec<SharedCamp>,
}

#[derive(Clone, Debug, Default)]
pub struct Role {
	pub give: Vec<usize>,
	pub end: Vec<usize>,
	pub obj: Vec<Vec<usize>>,
}

/// A walk goal for `locate`: quest, type, objective (1-based) and its world point.
pub struct GoalAt {
	pub q: Option<u32>,
	pub t: String,
	pub oi: Option<usize>,
	pub c: i64,
	pub wx: f64,
	pub wy: f64,
}

pub struct Atlas {
	pub nodes: Vec<AtlasNode>,
	pub areas: Vec<AtlasArea>,
	pub zones: BTreeMap<u32, AtlasZone>,
	pub roles: BTreeMap<u32, Role>,
	by_key: FxHashMap<String, usize>,
	grid: FxHashMap<(i64, i64, i64), Vec<(usize, f64, f64)>>,
}

/// atlas.js questOkFor(faction, npcs): not repeatable, open to the side (Era bits; a mask past
/// 32 bits counts as open), a giver or starting item, not only enemy givers.
pub fn quest_ok_for(faction: Faction, d: &GameData, rec: &Quest) -> bool {
	if rec.repeatable == Some(true) {
		return false;
	}
	let enemy = faction.other().letter();
	if let Some(r) = rec.races.filter(|r| *r != 0.0) {
		// JS: (races & sideBits) === 0 && races < 2^32 (ToInt32 of the mask).
		if r < 4294967296.0 && ((r as i64 as i32) as i64 & faction.era_races() as i64) == 0 {
			return false;
		}
	}
	let st = &rec.start;
	if st.npc.is_empty() && st.object.is_empty() && st.item.is_empty() {
		return false;
	}
	let npc_givers: Vec<_> = st.npc.iter().filter_map(|&n| u32::try_from(n).ok().and_then(|n| d.npcs.get(&n))).collect();
	if !npc_givers.is_empty() && npc_givers.iter().all(|n| n.faction.as_deref().unwrap_or("").to_uppercase() == enemy) {
		return false;
	}
	true
}

impl Atlas {
	/// The atlas of a world's faction over the data it was built from; `subzone` names the
	/// areas (None: every area is its zone's open land). `maps`: only these zone maps.
	pub fn build(world: &World, d: &GameData, subzone: Option<&dyn SubzoneOf>) -> Atlas {
		Atlas::build_for(world.faction, d, subzone, None)
	}

	/// buildAtlas({ quests, npcs, objects, items, proj, subzone, faction, maps }).
	pub fn build_for(faction: Faction, d: &GameData, subzone: Option<&dyn SubzoneOf>, maps: Option<&[u32]>) -> Atlas {
		let proj = Projector::new(&d.frames);
		let enemy = faction.other().letter();
		let mut nodes: Vec<AtlasNode> = Vec::new();
		let mut by_key: FxHashMap<String, usize> = FxHashMap::default();
		let mut target_nodes: FxHashMap<String, Vec<usize>> = FxHashMap::default();
		let mut nodes_of = |kind: &'static str, id: i64, nodes: &mut Vec<AtlasNode>, by_key: &mut FxHashMap<String, usize>| -> Vec<usize> {
			let tk = format!("{kind}:{id}");
			if let Some(v) = target_nodes.get(&tk) {
				return v.clone();
			}
			let rec = u32::try_from(id).ok().and_then(|i| if kind == "npc" { d.npcs.get(&i) } else { d.objects.get(&i) });
			let mut out = Vec::new();
			if let Some(rec) = rec {
				for (&map, sp) in &rec.spawns {
					if maps.is_some_and(|m| !m.contains(&map)) {
						continue;
					}
					let f = Frame::parse(sp.f.as_deref().filter(|f| !f.is_empty()).unwrap_or("e"));
					let mut pts: Vec<(i64, f64, f64)> = Vec::new();
					for p in sp.pts.iter().chain(sp.more.iter().flatten()).take(SPAWN_CAP) {
						let w = proj.point(map, p.first().copied().unwrap_or(f64::NAN), p.get(1).copied().unwrap_or(f64::NAN), f);
						if w.wx.is_finite() {
							pts.push((w.c, w.wx, w.wy));
						}
					}
					if pts.is_empty() {
						continue;
					}
					let xy: Vec<(f64, f64)> = pts.iter().map(|p| (p.1, p.2)).collect();
					for (k, ix) in cap_link(&xy, CAMP_LINK, CAMP_SPAN).into_iter().enumerate() {
						let ps: Vec<(i64, f64, f64)> = ix.iter().map(|&i| pts[i]).collect();
						let len = ps.len() as f64;
						let wx = ps.iter().fold(0.0, |s, p| s + p.1) / len;
						let wy = ps.iter().fold(0.0, |s, p| s + p.2) / len;
						let stride = ps.len().div_ceil(NODE_PTS).max(1);
						let key = format!("{tk}@{map}#{k}");
						let node = AtlasNode {
							key: key.clone(),
							kind,
							id: id as u32,
							name: rec.name.clone().filter(|n| !n.is_empty()).unwrap_or_else(|| tk.clone()),
							map,
							c: ps[0].0,
							wx,
							wy,
							n: ps.len() as u32,
							pts: ps.iter().enumerate().filter(|(i, _)| i % stride == 0).map(|(_, p)| (p.1, p.2)).collect(),
							area: None,
							subzone: None,
						};
						// nodes.set(key): a repeated key replaces the node in place.
						let idx = match by_key.get(&key) {
							Some(&i) => {
								nodes[i] = node;
								i
							}
							None => {
								nodes.push(node);
								by_key.insert(key, nodes.len() - 1);
								nodes.len() - 1
							}
						};
						out.push(idx);
					}
				}
			}
			target_nodes.insert(tk, out.clone());
			out
		};
		let mut roles: BTreeMap<u32, Role> = BTreeMap::new();
		for (&qid, rec) in &d.quests {
			if !quest_ok_for(faction, d, rec) {
				continue;
			}
			let friendly = |n: i64| u32::try_from(n).ok().and_then(|n| d.npcs.get(&n)).and_then(|r| r.faction.clone()).unwrap_or_default().to_uppercase() != enemy;
			let mut role = Role::default();
			for &n in rec.start.npc.iter().filter(|&&n| friendly(n)) {
				role.give.extend(nodes_of("npc", n, &mut nodes, &mut by_key));
			}
			for &o in &rec.start.object {
				role.give.extend(nodes_of("obj", o, &mut nodes, &mut by_key));
			}
			for &n in rec.end.npc.iter().filter(|&&n| friendly(n)) {
				role.end.extend(nodes_of("npc", n, &mut nodes, &mut by_key));
			}
			for &o in &rec.end.object {
				role.end.extend(nodes_of("obj", o, &mut nodes, &mut by_key));
			}
			for o in &rec.objectives {
				let mut list = Vec::new();
				for (kind, id) in objective_targets(d, o.as_ref()) {
					list.extend(nodes_of(kind, id, &mut nodes, &mut by_key));
				}
				role.obj.push(list);
			}
			if role.give.is_empty() && role.end.is_empty() && !role.obj.iter().any(|x| !x.is_empty()) {
				continue;
			}
			roles.insert(qid, role);
		}
		// Areas: the used nodes of each map, by subzone, then capped single linkage.
		let mut used: Vec<usize> = Vec::new();
		let mut seen = vec![false; nodes.len()];
		for r in roles.values() {
			for &n in r.give.iter().chain(&r.end).chain(r.obj.iter().flatten()) {
				if !seen[n] {
					seen[n] = true;
					used.push(n);
				}
			}
		}
		let mut by_map_sub: Vec<(String, Vec<usize>)> = Vec::new();
		let mut bms: FxHashMap<String, usize> = FxHashMap::default();
		for &k in &used {
			let sz = subzone.and_then(|s| s.at(nodes[k].c, nodes[k].wx, nodes[k].wy));
			let key = format!("{}|{}", nodes[k].map, sz.as_ref().map_or(0, |s| s.id));
			nodes[k].subzone = sz;
			let g = *bms.entry(key.clone()).or_insert_with(|| {
				by_map_sub.push((key, Vec::new()));
				by_map_sub.len() - 1
			});
			by_map_sub[g].1.push(k);
		}
		// [...entries].sort(): by the entry's string, "<key>,[object Object]...".
		by_map_sub.sort_by(|a, b| format!("{},", a.0).encode_utf16().cmp(format!("{},", b.0).encode_utf16()));
		let mut areas: Vec<AtlasArea> = Vec::new();
		for (k, mut list) in by_map_sub {
			list.sort_by(|&a, &b| nodes[a].key.encode_utf16().cmp(nodes[b].key.encode_utf16()));
			let xy: Vec<(f64, f64)> = list.iter().map(|&n| (nodes[n].wx, nodes[n].wy)).collect();
			for ix in cap_link(&xy, AREA_LINK, AREA_SPAN) {
				let ns: Vec<usize> = ix.iter().map(|&i| list[i]).collect();
				let w = ns.iter().fold(0u32, |s, &n| s + nodes[n].n);
				let wf = w as f64;
				let ai = areas.len();
				let a = AtlasArea {
					id: format!("{}/{}", k.split('|').next().unwrap_or(""), ai),
					map: nodes[ns[0]].map,
					c: nodes[ns[0]].c,
					subzone: nodes[ns[0]].subzone.clone(),
					wx: ns.iter().fold(0.0, |s, &n| s + nodes[n].wx * nodes[n].n as f64) / wf,
					wy: ns.iter().fold(0.0, |s, &n| s + nodes[n].wy * nodes[n].n as f64) / wf,
					n: w,
					nodes: ns.clone(),
					hub: None,
					name: String::new(),
					base: String::new(),
					give: Vec::new(),
					end: Vec::new(),
					obj: Vec::new(),
				};
				for &n in &ns {
					nodes[n].area = Some(ai);
				}
				areas.push(a);
			}
		}
		let mut gives_at: FxHashMap<usize, Vec<u32>> = FxHashMap::default();
		let add = |v: &mut Vec<u32>, q: u32| {
			if !v.contains(&q) {
				v.push(q);
			}
		};
		for (&q, r) in &roles {
			for &n in &r.give {
				let a = nodes[n].area.expect("used node has an area");
				add(&mut areas[a].give, q);
				gives_at.entry(n).or_default().push(q);
			}
			for &n in &r.end {
				let a = nodes[n].area.expect("used node has an area");
				add(&mut areas[a].end, q);
			}
			for (k, list) in r.obj.iter().enumerate() {
				for &n in list {
					let a = nodes[n].area.expect("used node has an area");
					let ob = &mut areas[a].obj;
					let e = match ob.iter().position(|e| e.0 == q) {
						Some(i) => i,
						None => {
							ob.push((q, Vec::new()));
							ob.len() - 1
						}
					};
					ob[e].1.push(ObjAt { oi: k + 1, node: n, n: nodes[n].n });
				}
			}
		}
		// Names and hubs per zone.
		let mut zones: BTreeMap<u32, AtlasZone> = BTreeMap::new();
		let mut zone_order: Vec<u32> = Vec::new();
		for (i, a) in areas.iter().enumerate() {
			let z = zones.entry(a.map).or_insert_with(|| {
				zone_order.push(a.map);
				AtlasZone { map: a.map, ..AtlasZone::default() }
			});
			z.areas.push(i);
		}
		for map in zone_order {
			let z = zones.get_mut(&map).expect("zone");
			let named: Vec<usize> = z.areas.iter().copied().filter(|&a| areas[a].subzone.as_ref().is_some_and(|s| s.id != s.zone_id)).collect();
			for &a in &z.areas {
				if named.contains(&a) {
					continue;
				}
				let mut best: Option<usize> = None;
				let mut bd = f64::INFINITY;
				for &b in &named {
					let dd = js_hypot(areas[b].wx - areas[a].wx, areas[b].wy - areas[a].wy);
					if dd < bd {
						best = Some(b);
						bd = dd;
					}
				}
				let zone = areas[a].subzone.as_ref().map_or_else(|| format!("map {}", areas[a].map), |s| s.zone.clone());
				areas[a].base = match best {
					Some(b) => format!("{zone}, near {}", areas[b].subzone.as_ref().expect("named").name),
					None => zone,
				};
			}
			for &a in &named {
				areas[a].base = areas[a].subzone.as_ref().expect("named").name.clone();
			}
			let mut by_base: Vec<(String, Vec<usize>)> = Vec::new();
			for &a in &z.areas {
				match by_base.iter_mut().find(|e| e.0 == areas[a].base) {
					Some(e) => e.1.push(a),
					None => by_base.push((areas[a].base.clone(), vec![a])),
				}
			}
			for (_, mut list) in by_base {
				list.sort_by(|&x, &y| areas[y].n.cmp(&areas[x].n));
				let mut seen: Vec<(String, u32)> = Vec::new();
				let first = (areas[list[0]].wx, areas[list[0]].wy);
				for (i, &a) in list.iter().enumerate() {
					let mut name = if i == 0 { areas[a].base.clone() } else { format!("{} ({})", areas[a].base, compass(first, (areas[a].wx, areas[a].wy))) };
					let cnt = match seen.iter_mut().find(|e| e.0 == name) {
						Some(e) => {
							e.1 += 1;
							e.1
						}
						None => {
							seen.push((name.clone(), 1));
							1
						}
					};
					if cnt > 1 {
						name = format!("{name} {cnt}");
					}
					areas[a].name = name;
				}
			}
			// Hubs.
			let mut givers: Vec<(usize, Vec<u32>)> = Vec::new();
			let mut seen_g: Vec<usize> = Vec::new();
			for &a in &z.areas {
				for &n in &areas[a].nodes {
					if seen_g.contains(&n) {
						continue;
					}
					let qs = gives_at.get(&n).cloned().unwrap_or_default();
					if qs.is_empty() {
						continue;
					}
					seen_g.push(n);
					givers.push((n, qs));
				}
			}
			let xy: Vec<(f64, f64)> = givers.iter().map(|g| (nodes[g.0].wx, nodes[g.0].wy)).collect();
			for ix in cap_link(&xy, HUB_LINK, HUB_SPAN) {
				let gs: Vec<&(usize, Vec<u32>)> = ix.iter().map(|&i| &givers[i]).collect();
				let mut distinct: Vec<(&str, u32)> = Vec::new();
				for g in &gs {
					let k = (nodes[g.0].kind, nodes[g.0].id);
					if !distinct.contains(&k) {
						distinct.push(k);
					}
				}
				if distinct.len() < HUB_GIVERS {
					continue;
				}
				let mut hub_areas: Vec<usize> = Vec::new();
				for g in &gs {
					let a = nodes[g.0].area.expect("area");
					if !hub_areas.contains(&a) {
						hub_areas.push(a);
					}
				}
				hub_areas.sort_by(|&x, &y| areas[y].n.cmp(&areas[x].n));
				let mut quests: Vec<u32> = Vec::new();
				for g in &gs {
					for &q in &g.1 {
						if !quests.contains(&q) {
							quests.push(q);
						}
					}
				}
				let hub = AtlasHub {
					name: areas[hub_areas[0]].name.clone(),
					areas: hub_areas.iter().map(|&a| areas[a].id.clone()).collect(),
					givers: gs.iter().map(|g| nodes[g.0].name.clone()).collect(),
					quests,
				};
				for &a in &hub_areas {
					if areas[a].hub.is_none() {
						areas[a].hub = Some(hub.name.clone());
					}
				}
				z.hubs.push(hub);
			}
			// Extension: shared camps and chain links.
			for &a in &z.areas {
				let mut shared: Vec<(&'static str, u32, String, Vec<u32>)> = Vec::new();
				for (q, list) in &areas[a].obj {
					for o in list {
						let n = &nodes[o.node];
						let e = match shared.iter().position(|s| s.0 == n.kind && s.1 == n.id) {
							Some(i) => i,
							None => {
								shared.push((n.kind, n.id, n.name.clone(), Vec::new()));
								shared.len() - 1
							}
						};
						if !shared[e].3.contains(q) {
							shared[e].3.push(*q);
						}
					}
				}
				for s in shared.into_iter().filter(|s| s.3.len() > 1) {
					z.shared.push(SharedCamp { area: a, kind: s.0, id: s.1, name: s.2, quests: s.3 });
				}
			}
			let mut zone_quests: Vec<u32> = Vec::new();
			for &a in &z.areas {
				for &q in &areas[a].give {
					if !zone_quests.contains(&q) {
						zone_quests.push(q);
					}
				}
			}
			let qo = |id: i64| u32::try_from(id).ok().and_then(|i| d.quests.get(&i));
			for &q in &zone_quests {
				let Some(rec) = d.quests.get(&q) else { continue };
				let b = blocking_prereqs(rec, &qo);
				for p in b.all.iter().chain(&b.any) {
					if let Ok(p) = u32::try_from(*p) {
						if zone_quests.contains(&p) && !z.chains.contains(&(p, q)) {
							z.chains.push((p, q));
						}
					}
				}
				if let Some(t) = rec.breadcrumb_for.filter(|t| *t > 0.0) {
					z.breadcrumbs.push((q, t as u32));
				}
				for &c in &rec.breadcrumbs {
					if c > 0 {
						z.breadcrumbs.push((c as u32, q));
					}
				}
			}
		}
		// Grid of node points for near/locate.
		let mut grid: FxHashMap<(i64, i64, i64), Vec<(usize, f64, f64)>> = FxHashMap::default();
		for &k in &used {
			let n = &nodes[k];
			for p in std::iter::once((n.wx, n.wy)).chain(n.pts.iter().copied()) {
				grid.entry((n.c, (p.0 / GRID_CELL).floor() as i64, (p.1 / GRID_CELL).floor() as i64)).or_default().push((k, p.0, p.1));
			}
		}
		Atlas { nodes, areas, zones, roles, by_key, grid }
	}

	pub fn node(&self, key: &str) -> Option<&AtlasNode> {
		self.by_key.get(key).map(|&i| &self.nodes[i])
	}

	pub fn area(&self, id: &str) -> Option<&AtlasArea> {
		self.areas.iter().find(|a| a.id == id)
	}

	/// Nodes within r yards of a point -> (node, nearest distance), first-seen order.
	pub fn near_nodes(&self, c: i64, wx: f64, wy: f64, r: f64) -> Vec<(usize, f64)> {
		let mut out: Vec<(usize, f64)> = Vec::new();
		let x0 = ((wx - r) / GRID_CELL).floor() as i64;
		let x1 = ((wx + r) / GRID_CELL).floor() as i64;
		let y0 = ((wy - r) / GRID_CELL).floor() as i64;
		let y1 = ((wy + r) / GRID_CELL).floor() as i64;
		for x in x0..=x1 {
			for y in y0..=y1 {
				for &(n, ex, ey) in self.grid.get(&(c, x, y)).into_iter().flatten() {
					let dd = js_hypot(ex - wx, ey - wy);
					if dd > r {
						continue;
					}
					match out.iter_mut().find(|e| e.0 == n) {
						Some(e) => {
							if dd < e.1 {
								e.1 = dd;
							}
						}
						None => out.push((n, dd)),
					}
				}
			}
		}
		out
	}

	fn node_dist(&self, n: usize, c: i64, wx: f64, wy: f64) -> f64 {
		let n = &self.nodes[n];
		if n.c != c {
			return f64::INFINITY;
		}
		n.pts.iter().fold(js_hypot(n.wx - wx, n.wy - wy), |m, s| m.min(js_hypot(s.0 - wx, s.1 - wy)))
	}

	/// The area of a walk goal: the nearest node of its own role within 300 yd, else the
	/// nearest node of any quest within 200 yd, else none.
	pub fn locate(&self, g: &GoalAt) -> Option<usize> {
		let r = g.q.and_then(|q| self.roles.get(&q));
		let cand: Vec<usize> = match r {
			None => Vec::new(),
			Some(r) => match g.t.as_str() {
				"accept" => r.give.clone(),
				"turnin" => r.end.clone(),
				_ => match g.oi.and_then(|oi| oi.checked_sub(1)).and_then(|i| r.obj.get(i)) {
					Some(l) => l.clone(),
					None => r.obj.iter().flatten().copied().collect(),
				},
			},
		};
		let mut best = None;
		let mut bd = LOCATE_ROLE;
		for n in cand {
			let dd = self.node_dist(n, g.c, g.wx, g.wy);
			if dd <= bd && self.nodes[n].area.is_some() {
				best = Some(n);
				bd = dd;
			}
		}
		if let Some(b) = best {
			return self.nodes[b].area;
		}
		bd = LOCATE_ANY;
		for (n, dd) in self.near_nodes(g.c, g.wx, g.wy, LOCATE_ANY) {
			if dd <= bd && self.nodes[n].area.is_some() {
				best = Some(n);
				bd = dd;
			}
		}
		best.and_then(|b| self.nodes[b].area)
	}

	/// Yards from a point to an area (its nearest node point).
	pub fn area_dist(&self, a: usize, c: i64, wx: f64, wy: f64) -> f64 {
		let a = &self.areas[a];
		if a.c != c {
			return f64::INFINITY;
		}
		a.nodes.iter().fold(f64::INFINITY, |m, &n| m.min(self.node_dist(n, c, wx, wy)))
	}
}

/// atlas.js objectiveTargets: kill -> the npc, object -> the object, item -> its droppers at
/// >= 5% or without a rate (npcs then objects), else its vendors.
fn objective_targets(d: &GameData, o: Option<&crate::data::Objective>) -> Vec<(&'static str, i64)> {
	let Some(o) = o else { return Vec::new() };
	let id = o.id.map_or(-1, |x| x as i64);
	match o.kind.as_str() {
		"kill" => vec![("npc", id)],
		"object" => vec![("obj", id)],
		"item" => {
			let Some(it) = u32::try_from(id).ok().and_then(|i| d.items.get(&i)) else { return Vec::new() };
			let mut out = Vec::new();
			if let Some(dr) = &it.drops {
				for (&n, ch) in &dr.npc {
					if ch.is_none_or(|c| c >= DROP_MIN) {
						out.push(("npc", n as i64));
					}
				}
				for (&n, ch) in &dr.object {
					if ch.is_none_or(|c| c >= DROP_MIN) {
						out.push(("obj", n as i64));
					}
				}
			}
			if out.is_empty() {
				for &v in it.vendors.as_deref().unwrap_or(&[]) {
					out.push(("npc", v));
				}
			}
			out
		}
		_ => Vec::new(),
	}
}

#[cfg(feature = "native")]
pub use grid::GridSubzones;

#[cfg(feature = "native")]
mod grid {
	use super::{Subzone, SubzoneOf};
	use crate::csv::parse_csv;
	use rustc_hash::FxHashMap;
	use std::io::Read;
	use std::path::{Path, PathBuf};
	use std::sync::Mutex;

	const ADT: f64 = 1600.0 / 3.0;
	const TILE_CELLS: f64 = 256.0;
	const HEAD_BYTES: usize = 8192;
	const AREAS_AT: usize = 32;

	struct AreaRow {
		name: String,
		parent: u32,
	}

	/// Subzones from the walking grid's tile heads (atlas.js subzoneLookup) and AreaTable.
	pub struct GridSubzones {
		dir: PathBuf,
		table: FxHashMap<u32, AreaRow>,
		tiles: Mutex<FxHashMap<(i64, i64, i64), Option<Vec<u16>>>>,
	}

	impl GridSubzones {
		/// gridDir: data/local/nav4 (or $POLESTAR_GRID); sources: data/sources (newest Forever
		/// AreaTable.csv).
		pub fn open(grid_dir: &Path, sources: &Path) -> GridSubzones {
			let mut table = FxHashMap::default();
			let mut builds: Vec<String> = std::fs::read_dir(sources.join("wago")).map(|it| it.filter_map(|e| e.ok()?.file_name().into_string().ok()).collect()).unwrap_or_default();
			builds.retain(|b| {
				b.split('.').all(|p| !p.is_empty() && p.bytes().all(|c| c.is_ascii_digit()))
					&& b.contains('.')
					&& b.starts_with("1.6")
					&& b.as_bytes().get(3).is_some_and(u8::is_ascii_digit)
					&& b.as_bytes().get(4) == Some(&b'.')
					&& sources.join("wago").join(b).join("AreaTable.csv").exists()
			});
			builds.sort_by_key(|b| b.split('.').map(|p| p.parse::<u64>().unwrap_or(0)).collect::<Vec<_>>());
			if let Some(b) = builds.last() {
				if let Ok(text) = std::fs::read_to_string(sources.join("wago").join(b).join("AreaTable.csv")) {
					for r in parse_csv(&text).unwrap_or_default() {
						let Some(id) = r.get("ID").and_then(|s| s.parse::<u32>().ok()) else { continue };
						let name = r.get("AreaName_lang").cloned().unwrap_or_default();
						if name.is_empty() {
							continue;
						}
						let parent = r.get("ParentAreaID").and_then(|s| s.parse::<u32>().ok()).unwrap_or(0);
						table.insert(id, AreaRow { name, parent });
					}
				}
			}
			GridSubzones { dir: grid_dir.to_path_buf(), table, tiles: Mutex::new(FxHashMap::default()) }
		}

		fn tile(&self, c: i64, col: i64, row: i64) -> Option<Vec<u16>> {
			let mut file = std::fs::File::open(self.dir.join("tiles").join(c.to_string()).join(format!("{col}_{row}.nav.gz"))).ok()?;
			let mut head = vec![0u8; HEAD_BYTES];
			let mut n = 0;
			while n < HEAD_BYTES {
				match file.read(&mut head[n..]) {
					Ok(0) | Err(_) => break,
					Ok(k) => n += k,
				}
			}
			let mut raw = vec![0u8; AREAS_AT + 512];
			flate2::read::GzDecoder::new(&head[..n]).read_exact(&mut raw).ok()?;
			Some((0..256).map(|k| u16::from_le_bytes([raw[AREAS_AT + 2 * k], raw[AREAS_AT + 2 * k + 1]])).collect())
		}
	}

	impl SubzoneOf for GridSubzones {
		fn at(&self, c: i64, wx: f64, wy: f64) -> Option<Subzone> {
			let cell = ADT / TILE_CELLS;
			let gi = ((32.0 * ADT - wy) / cell).floor() as i64;
			let gj = ((32.0 * ADT - wx) / cell).floor() as i64;
			let col = gi.div_euclid(256);
			let row = gj.div_euclid(256);
			let t = {
				let mut tiles = self.tiles.lock().expect("tiles");
				tiles.entry((c, col, row)).or_insert_with(|| self.tile(c, col, row)).clone()
			}?;
			let i = gi - col * 256;
			let j = gj - row * 256;
			let id = u32::from(t[((j >> 4) * 16 + (i >> 4)) as usize]);
			if id == 0 {
				return None;
			}
			let a = self.table.get(&id);
			let mut z = a.map(|a| (id, a));
			let mut hops = 0;
			while let Some((_, za)) = z {
				if za.parent == 0 || hops >= 8 {
					break;
				}
				z = self.table.get(&za.parent).map(|p| (za.parent, p));
				hops += 1;
			}
			let fallback = format!("area {id}");
			Some(Subzone {
				id,
				name: a.map_or(fallback.clone(), |a| a.name.clone()),
				zone_id: z.map_or(id, |z| z.0),
				zone: z.map(|z| z.1.name.clone()).or_else(|| a.map(|a| a.name.clone())).unwrap_or(fallback),
			})
		}
	}
}
