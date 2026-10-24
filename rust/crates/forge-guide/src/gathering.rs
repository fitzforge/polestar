//! Port of tools/lib/professions/gathering/tables.js.
//! Curated game-mechanics tables for the gathering profession guides (classic rules): node colors, node
//! skill requirements, skinning requirements, ranks, and the open-world zones a gathering route may use.

/// Relative skill-up value by color.
pub fn color_weight(color: &str) -> f64 {
	match color {
		"orange" => 1.0,
		"yellow" => 0.6,
		"green" => 0.15,
		_ => 0.0,
	}
}

/// The node's color at `skill`, or None when it cannot be gathered.
pub fn color(skill: f64, req: f64) -> Option<&'static str> {
	if skill < req {
		return None;
	}
	if skill < req + 25.0 {
		return Some("orange");
	}
	if skill < req + 50.0 {
		return Some("yellow");
	}
	if skill < req + 100.0 {
		return Some("green");
	}
	Some("grey")
}

/// Mean skill-up weight of a node across a skill band [from, to).
pub fn band_weight(req: f64, from: f64, to: f64) -> f64 {
	let mut sum = 0.0;
	let mut s = from;
	while s < to {
		sum += color(s, req).map_or(0.0, color_weight);
		s += 1.0;
	}
	if to > from {
		sum / (to - from)
	} else {
		0.0
	}
}

/// Ore nodes by objects.json name -> req.
pub const MINING_NODES: &[(&str, u32)] = &[
	("Copper Vein", 1),
	("Tin Vein", 65),
	("Incendicite Mineral Vein", 65),
	("Silver Vein", 75),
	("Lesser Bloodstone Deposit", 75),
	("Iron Deposit", 125),
	("Gold Vein", 155),
	("Mithril Deposit", 175),
	("Truesilver Deposit", 230),
	("Dark Iron Deposit", 230),
	("Small Thorium Vein", 245),
	("Rich Thorium Vein", 275),
];

/// Herb nodes by objects.json name -> req.
pub const HERB_NODES: &[(&str, u32)] = &[
	("Peacebloom", 1),
	("Silverleaf", 1),
	("Earthroot", 15),
	("Mageroyal", 50),
	("Briarthorn", 70),
	("Stranglekelp", 85),
	("Bruiseweed", 100),
	("Wild Steelbloom", 115),
	("Grave Moss", 120),
	("Kingsblood", 125),
	("Liferoot", 150),
	("Fadeleaf", 160),
	("Goldthorn", 170),
	("Khadgar's Whisker", 185),
	("Wintersbite", 195),
	("Firebloom", 205),
	("Purple Lotus", 210),
	("Arthas' Tears", 220),
	("Sungrass", 230),
	("Blindweed", 235),
	("Ghost Mushroom", 245),
	("Gromsblood", 250),
	("Golden Sansam", 260),
	("Dreamfoil", 270),
	("Mountain Silversage", 280),
	("Plaguebloom", 285),
	("Icecap", 290),
	("Black Lotus", 300),
];

pub fn skinning_req(level: f64) -> f64 {
	if level <= 10.0 {
		return 1.0;
	}
	if level <= 20.0 {
		return (level - 10.0) * 10.0;
	}
	level * 5.0
}

pub struct Rank {
	pub name: &'static str,
	pub learn_at: u32,
	pub level: u32,
	pub max: u32,
}

pub const RANKS: [Rank; 4] = [
	Rank { name: "Apprentice", learn_at: 0, level: 5, max: 75 },
	Rank { name: "Journeyman", learn_at: 50, level: 10, max: 150 },
	Rank { name: "Expert", learn_at: 125, level: 20, max: 225 },
	Rank { name: "Artisan", learn_at: 200, level: 35, max: 300 },
];

pub struct Zone {
	pub id: u32,
	pub name: &'static str,
	pub min: u32,
	pub max: u32,
	/// 'A' | 'H' | 'AH'
	pub side: &'static str,
}

/// Open-world zones a gathering route may use: (uiMapID, name, min, max, side), in source order.
const ZONE_ROWS: &[(u32, &str, u32, u32, &str)] = &[
	(1429, "Elwynn Forest", 1, 10, "A"),
	(1426, "Dun Morogh", 1, 10, "A"),
	(1438, "Teldrassil", 1, 10, "A"),
	(1411, "Durotar", 1, 10, "H"),
	(1412, "Mulgore", 1, 10, "H"),
	(1420, "Tirisfal Glades", 1, 10, "H"),
	(1436, "Westfall", 10, 20, "A"),
	(1432, "Loch Modan", 10, 20, "A"),
	(1439, "Darkshore", 10, 20, "A"),
	(1413, "The Barrens", 10, 25, "H"),
	(1421, "Silverpine Forest", 10, 20, "H"),
	(1442, "Stonetalon Mountains", 15, 27, "AH"),
	(1431, "Duskwood", 18, 30, "A"),
	(1440, "Ashenvale", 18, 30, "AH"),
	(1433, "Redridge Mountains", 15, 25, "A"),
	(1437, "Wetlands", 20, 30, "A"),
	(1424, "Hillsbrad Foothills", 20, 30, "AH"),
	(1441, "Thousand Needles", 25, 35, "AH"),
	(1416, "Alterac Mountains", 30, 40, "AH"),
	(1417, "Arathi Highlands", 30, 40, "AH"),
	(1443, "Desolace", 30, 40, "AH"),
	(1434, "Stranglethorn Vale", 30, 45, "AH"),
	(1418, "Badlands", 35, 45, "AH"),
	(1435, "Swamp of Sorrows", 35, 45, "AH"),
	(1445, "Dustwallow Marsh", 35, 45, "AH"),
	(1444, "Feralas", 40, 50, "AH"),
	(1446, "Tanaris", 40, 50, "AH"),
	(1425, "The Hinterlands", 40, 50, "AH"),
	(1427, "Searing Gorge", 43, 50, "AH"),
	(1419, "Blasted Lands", 45, 55, "AH"),
	(1447, "Azshara", 45, 55, "AH"),
	(1448, "Felwood", 48, 55, "AH"),
	(1449, "Un'Goro Crater", 48, 55, "AH"),
	(1428, "Burning Steppes", 50, 58, "AH"),
	(1422, "Western Plaguelands", 51, 58, "AH"),
	(1423, "Eastern Plaguelands", 53, 60, "AH"),
	(1452, "Winterspring", 55, 60, "AH"),
	(1451, "Silithus", 55, 60, "AH"),
];

/// `ZONES[map]` (map as the JS property key String(map)).
pub fn zone(map: &crate::js::V) -> Option<Zone> {
	let key = map.to_js_string();
	ZONE_ROWS.iter().find(|z| z.0.to_string() == key).map(|&(id, name, min, max, side)| Zone { id, name, min, max, side })
}

/// Every zone of ZONES in JS key order (ascending id).
pub fn zones() -> Vec<Zone> {
	let mut v: Vec<Zone> = ZONE_ROWS.iter().map(|&(id, name, min, max, side)| Zone { id, name, min, max, side }).collect();
	v.sort_by_key(|z| z.id);
	v
}
