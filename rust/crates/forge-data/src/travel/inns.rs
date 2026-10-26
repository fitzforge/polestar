//! Hearthstone destinations (port of tools/lib/travel/inns.js; see its header): curated bind
//! location names -> the innkeeper there (data/forever/npcs.json), each with its AreaTable area
//! (tools/lib/data/areas.js, through forge_guide::areas).

use forge_guide::areas::area_named;
use forge_guide::js::{cmp_utf16, V};

use super::geo::{round, Frames};
use super::taxi::{spawn_points, LiveFrames};

const INNS: [(&[&str], i64, i64); 45] = [
	(&["Goldshire"], 1429, 295),
	(&["Thunderbrew Distillery", "Kharanos"], 1426, 1247),
	(&["Deepwater Tavern", "Menethil Harbor"], 1437, 1464),
	(&["Southshore"], 1424, 2352),
	(&["Tarren Mill"], 1424, 2388),
	(&["The Crossroads", "Crossroads"], 1413, 3934),
	(&["Ironforge"], 1455, 5111),
	(&["Gallows' End Tavern", "Brill"], 1420, 5688),
	(&["Grom'gol Base Camp"], 1434, 5814),
	(&["Theramore Isle"], 1445, 6272),
	(&["Lakeshire"], 1433, 6727),
	(&["Stoutlager Inn", "Thelsamar"], 1432, 6734),
	(&["Craftsmen's Terrace", "Darnassus"], 1457, 6735),
	(&["Dolanaar"], 1438, 6736),
	(&["Auberdine"], 1439, 6737),
	(&["Astranaar"], 1440, 6738),
	(&["The Sepulcher"], 1421, 6739),
	(&["Stormwind City"], 1453, 6740),
	(&["Undercity"], 1458, 6741),
	(&["Thunder Bluff"], 1456, 6746),
	(&["Bloodhoof Village"], 1412, 6747),
	(&["Darkshire"], 1431, 6790),
	(&["Ratchet"], 1413, 6791),
	(&["Booty Bay"], 1434, 6807),
	(&["Razor Hill"], 1411, 6928),
	(&["Orgrimmar"], 1454, 6929),
	(&["Stonard"], 1435, 6930),
	(&["Camp Taurajo"], 1413, 7714),
	(&["Sun Rock Retreat"], 1442, 7731),
	(&["Gadgetzan"], 1446, 7733),
	(&["Feathermoon Stronghold"], 1444, 7736),
	(&["Camp Mojache"], 1444, 7737),
	(&["Aerie Peak", "Wildhammer Keep"], 1425, 7744),
	(&["Sentinel Hill"], 1436, 8931),
	(&["Kargath"], 1418, 9356),
	(&["Hammerfall"], 1417, 9501),
	(&["Nijel's Point"], 1443, 11103),
	(&["Shadowprey Village"], 1443, 11106),
	(&["Freewind Post"], 1441, 11116),
	(&["Everlook"], 1452, 11118),
	(&["Splintertree Post"], 1440, 12196),
	(&["Revantusk Village"], 1425, 14731),
	(&["Cenarion Hold"], 1451, 15174),
	(&["Light's Hope Chapel"], 1423, 16256),
	(&["Stonetalon Peak"], 1442, 16458),
];

pub struct Inn {
	pub location: String,
	pub names: Vec<String>,
	pub area: Option<f64>,
	pub npc: i64,
	pub npc_name: String,
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
	pub map: i64,
	pub x: f64,
	pub y: f64,
	pub f: &'static str,
}

/// areas: forge_guide::areas::load_areas (Null without a cached AreaTable).
pub fn build_inns(frames: &Frames, npcs: &V, live: &LiveFrames, areas: &V, zones: &V) -> (Vec<Inn>, Vec<String>) {
	let mut warnings = Vec::new();
	let mut inns: Vec<Inn> = Vec::new();
	for (names, map, npc_id) in INNS {
		let location = names[0];
		let npc = npcs.get(&npc_id.to_string());
		if !npc.truthy() {
			warnings.push(format!("inn {location}: innkeeper {npc_id} not in npcs.json"));
			continue;
		}
		let npc_name = npc.get("name").to_js_string();
		if !npc.get("roles").items().iter().any(|r| r.as_str() == Some("innkeeper")) {
			warnings.push(format!("inn {location}: npc {npc_id} \"{npc_name}\" lacks the innkeeper role"));
		}
		let pts: Vec<_> = spawn_points(&npc, frames, live).into_iter().filter(|p| p.map == map).collect();
		let Some(p) = pts.into_iter().next() else {
			warnings.push(format!("inn {location}: {npc_name} ({npc_id}) does not spawn on map {map} ({})", frames.name(map).unwrap_or_else(|| "null".into())));
			continue;
		};
		let zone = zones.get(&map.to_string());
		let zone_area = if zone.truthy() { zone.get("areaId") } else { zone };
		let area = if areas.truthy() { names.iter().map(|n| area_named(areas, &V::from(*n), &zone_area)).find(V::truthy) } else { None };
		if areas.truthy() && area.is_none() {
			let list: Vec<String> = names.iter().map(|n| format!("\"{n}\"")).collect();
			warnings.push(format!("inn {location}: no AreaTable area named {} in {}; the addon matches it by name only", list.join(" or "), frames.name(map).unwrap_or_else(|| "null".into())));
		}
		inns.push(Inn {
			location: location.to_string(),
			names: names.iter().map(|s| s.to_string()).collect(),
			area: area.map(|a| a.get("id").num()),
			npc: npc_id,
			npc_name,
			c: p.c,
			wx: round(p.wx, 1),
			wy: round(p.wy, 1),
			map: p.map,
			x: p.x,
			y: p.y,
			f: p.f,
		});
	}
	inns.sort_by(|a, b| cmp_utf16(&a.location, &b.location));
	(inns, warnings)
}
