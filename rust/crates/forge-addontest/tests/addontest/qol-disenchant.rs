//! An uncommon or rare weapon or armour's tooltip says what disenchanting it gives, for a character with
//! Enchanting (QoL/Disenchant.lua, docs/ARCHITECTURE.md "Disenchanting result on the tooltip"): the likeliest
//! result with its count range and the next one when it comes up often. No line without Enchanting, for a grey,
//! white or epic item, for a trade good, or for an item level the table has no band for. The Lua table is the
//! same as data/disenchant.json.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// The items: id -> class, quality, item level. The dusts and essences the lines name carry the client's own
// names (a German one for Strange Dust); the others are not cached, so the English fallback shows.
const ITEMS: &str = r#"
local w = stub.world
local function item(id, name, class, quality, ilvl) w.itemInfo[id] = { name = name, classID = class, quality = quality, ilvl = ilvl, subclassID = 0 } end
item(9001, "Test Green Vest", 4, 2, 12)
item(9002, "Test Green Sword", 2, 2, 12)
item(9003, "Test Blue Helm", 4, 3, 27)
item(9004, "Test Grey Cap", 4, 0, 12)
item(9005, "Test White Shirt", 4, 1, 12)
item(9006, "Test Epic Blade", 2, 4, 45)
item(9007, "Test Green Gem", 3, 2, 12)
item(9008, "Test Green Cloak", 4, 2, 90)
item(9009, "Test Green Wand", 2, 2, 3)
item(9010, "Test Green Greaves", 4, 2, 23)
item(9011, "Test Green Hammer", 2, 2, 53)
item(9012, "Test Blue Dagger", 2, 3, 14)
item(10940, "Seltsamer Staub", 7, 1, 1)
"#;

const SCRIPT: &str = r#"
local P, QoL = Polestar, Polestar.QoL
local function lines(id)
	GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	GameTooltip:ClearLines()
	P.Hooks.OnItemTooltip(GameTooltip, { id = id })
	local out = {}
	for _, l in ipairs(GameTooltip.lines) do
		if l:find("Disenchants into", 1, true) or l:find("Zerlegt", 1, true) then out[#out + 1] = l end
	end
	return table.concat(out, "\n")
end
local ids = { 9001, 9002, 9003, 9004, 9005, 9006, 9007, 9008, 9009, 9010, 9011, 9012 }
local function all()
	local out = {}
	for _, id in ipairs(ids) do out[tostring(id)] = lines(id) end
	return out
end
local seen = { without = all() }
stub.world.learnSkill(333, "Enchanting", 1, 75)
seen.with = all()
-- The Lua copy of the table, for the file's check.
seen.bands, seen.names = QoL.DISENCHANT_BANDS, QoL.DISENCHANT_NAMES
emit(seen)
"#;

// A whole chance reads as an integer, as Lua emits it.
fn num(f: f64) -> Value {
	if f.fract() == 0.0 {
		json!(f as i64)
	} else {
		json!(f)
	}
}

fn run() -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: ITEMS.into(),
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: SCRIPT.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn an_enchanter_sees_what_a_green_or_blue_weapon_or_armour_disenchants_into_and_nobody_else_does() {
	let out = run();
	// Without Enchanting: nothing, whatever the item.
	for (id, l) in out["without"].as_object().unwrap() {
		assert_eq!(l, "", "item {id}: no line without Enchanting");
	}
	let with = &out["with"];
	// Green armour: mostly dust (Strange Dust under the client's own name), the essence as the other result.
	assert_eq!(with["9001"], "Disenchants into: 1\u{2013}2 Seltsamer Staub (or 1\u{2013}2 Lesser Magic Essence)");
	// A green weapon: mostly essence.
	assert_eq!(with["9002"], "Disenchants into: 1\u{2013}2 Lesser Magic Essence (or 1\u{2013}2 Seltsamer Staub)");
	// A blue: a shard, nothing else worth naming.
	assert_eq!(with["9003"], "Disenchants into: 1 Large Glimmering Shard");
	// A blue below the rare bands the server has: the inferred shard.
	assert_eq!(with["9012"], "Disenchants into: 1 Small Glimmering Shard");
	// A band whose second result is the 15% one, and a weapon band whose other result is dust.
	assert_eq!(with["9010"], "Disenchants into: 4\u{2013}6 Seltsamer Staub (or 1\u{2013}2 Lesser Astral Essence)");
	assert_eq!(with["9011"], "Disenchants into: 1\u{2013}2 Lesser Eternal Essence (or 2\u{2013}5 Dream Dust)");
	// No line: grey, white and epic items, a gem, an item level past the bands (3 is below the first band).
	for id in ["9004", "9005", "9006", "9007", "9009"] {
		assert_eq!(with[id], "", "item {id}: nothing to say");
	}
	assert_eq!(with["9008"], "Disenchants into: 2\u{2013}5 Illusion Dust (or 2\u{2013}3 Greater Eternal Essence)", "the top band");
}

// The Lua table in QoL/Disenchant.lua is the table in data/disenchant.json, band for band.
#[test]
fn the_addon_s_disenchant_table_is_the_json_file_s() {
	let out = run();
	let file: Value = serde_json::from_slice(&std::fs::read(addons_dir().parent().unwrap().join("data/disenchant.json")).unwrap()).unwrap();
	let rows: Vec<Value> = file["bands"]
		.as_array()
		.unwrap()
		.iter()
		.map(|b| {
			let loot: Vec<Value> = b["loot"].as_array().unwrap().iter().map(|l| json!([l["item"], num(l["chance"].as_f64().unwrap()), l["min"], l["max"]])).collect();
			json!([b["class"], b["quality"], b["ilvl"][0], b["ilvl"][1], loot])
		})
		.collect();
	assert_eq!(out["bands"], json!(rows), "the bands");
	assert_eq!(out["names"], file["names"], "the English names");
	// Every band's loot is best first, and every item in it has a name.
	for b in file["bands"].as_array().unwrap() {
		let chances: Vec<f64> = b["loot"].as_array().unwrap().iter().map(|l| l["chance"].as_f64().unwrap()).collect();
		assert!(chances.windows(2).all(|w| w[0] >= w[1]), "best first: {b}");
		for l in b["loot"].as_array().unwrap() {
			assert!(file["names"].get(l["item"].to_string()).is_some(), "a name for item {}", l["item"]);
		}
	}
}
