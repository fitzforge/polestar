//! Hearthstone destinations (port of tools/lib/travel/inns.js; see its header): curated bind
//! location names -> the innkeeper there (data/forever/npcs.json), each with its AreaTable area
//! (tools/lib/data/areas.js, through forge_guide::areas).

use forge_guide::areas::area_named;
use forge_guide::js::{cmp_utf16, V};

use super::geo::{round, Frames};
use super::taxi::{spawn_points, LiveFrames};

const INNS: [(&[&str], i64, i64); 50] = [
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
	// Zephras Isle (c13 review: the isle never bound or hearthed; binding
	// Shen'dar, then Valanaar, saves the walk back from both).
	(&["Shen'dar Village"], 2521, 254089),
	(&["Valanaar"], 2521, 255940),
	// The Riverglades (a map Forever added: the inns stand on its live frame). Players' recordings to
	// 2026-11-11: binds right after these innkeepers' windows, the Hearthstone landing there after, and
	// the client's subzone at each window (GetSubZoneText), an AreaTable area under the Riverglades.
	// Farholde Keep's inn reads "Elk's Horn Inn" indoors, a name no AreaTable area has, so its bind
	// location is taken to be the keep's (a bind there teaches the addon the pair either way).
	(&["Powderfuse Port"], 2548, 255894),
	(&["Rog'mar"], 2548, 256675),
	(&["Farholde Keep"], 2548, 257595),
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

#[cfg(test)]
mod tests {
	use super::*;
	use crate::travel::geo::Frame;
	use forge_guide::js::parse_json;

	// The Riverglades' inns: Innkeeper Zizplink at Powderfuse Port, Innkeeper Toka at Rog'mar and Barracks
	// Master Harlan at Farholde Keep (the recordings' binds), on the map's live frame (Forever added it: no
	// Era frame), each with the AreaTable area of its subzone under the Riverglades (16591).
	#[test]
	fn the_riverglades_inns_stand_on_the_live_frame_with_their_subzone_s_area() {
		let zones = parse_json(r#"{"2548":{"id":2548,"name":"Riverglades","areaId":16591,"type":3}}"#).unwrap();
		let frames = Frames::new(&V::obj(), &zones);
		let riverglades = parse_json(r#"{"c":0,"left":-1891.666,"right":-6741.666,"top":-6466.666,"bottom":-9700}"#).unwrap();
		let live: LiveFrames = [(2548, Frame::of(&riverglades))].into_iter().collect();
		let npcs = parse_json(
			r#"{
				"255894":{"id":255894,"name":"Innkeeper Zizplink","roles":["innkeeper","vendor"],"spawns":{"2548":{"f":"l","pts":[[78.75,54.03]]}}},
				"256675":{"id":256675,"name":"Innkeeper Toka","roles":["innkeeper","vendor"],"spawns":{"2548":{"f":"l","pts":[[58.01,45.12]]}}},
				"257595":{"id":257595,"name":"Barracks Master Harlan","roles":["innkeeper","vendor"],"spawns":{"2548":{"f":"l","pts":[[64.64,84.2]]}}}
			}"#,
		)
		.unwrap();
		let areas = parse_json(
			r#"{"build":"1.60.1.1",
				"byId":{
					"16591":{"id":16591,"name":"Riverglades","c":0,"parent":0},
					"16724":{"id":16724,"name":"Farholde Keep","c":0,"parent":16591},
					"16727":{"id":16727,"name":"Powderfuse Port","c":0,"parent":16591},
					"16743":{"id":16743,"name":"Rog'mar","c":0,"parent":16591}},
				"byName":{
					"riverglades":[{"id":16591,"name":"Riverglades","c":0,"parent":0}],
					"farholde keep":[{"id":16724,"name":"Farholde Keep","c":0,"parent":16591}],
					"powderfuse port":[{"id":16727,"name":"Powderfuse Port","c":0,"parent":16591}],
					"rog'mar":[{"id":16743,"name":"Rog'mar","c":0,"parent":16591}]}}"#,
		)
		.unwrap();
		let (inns, warnings) = build_inns(&frames, &npcs, &live, &areas, &zones);
		let got: Vec<_> = inns.iter().map(|i| (i.location.as_str(), i.names.clone(), i.area, i.npc, i.map, i.x, i.y, i.f, i.c)).collect();
		let names = |n: &str| vec![n.to_string()];
		assert_eq!(
			got,
			[
				("Farholde Keep", names("Farholde Keep"), Some(16724.0), 257595, 2548, 64.64, 84.2, "l", 0.0),
				("Powderfuse Port", names("Powderfuse Port"), Some(16727.0), 255894, 2548, 78.75, 54.03, "l", 0.0),
				("Rog'mar", names("Rog'mar"), Some(16743.0), 256675, 2548, 58.01, 45.12, "l", 0.0),
			]
		);
		// Toka's world point: the live frame's, rounded to a tenth.
		let toka = &inns[2];
		assert_eq!((toka.wx, toka.wy), (round(-6466.666 - 3233.334 * 0.4512, 1), round(-1891.666 - 4850.0 * 0.5801, 1)));
		let theirs: Vec<&String> = warnings.iter().filter(|w| ["Powderfuse Port", "Rog'mar", "Farholde Keep"].iter().any(|n| w.starts_with(&format!("inn {n}:")))).collect();
		assert!(theirs.is_empty(), "{theirs:?}");
	}
}
