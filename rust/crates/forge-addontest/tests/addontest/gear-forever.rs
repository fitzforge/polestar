//! Forever's ratings and Polestar's own weights (addon/Polestar/Gear/Gear.lua, Weights.lua, PawnStats.lua, #1529): an
//! item's ratings read at the client's points per 1%, haste, expertise and armor penetration weighed, and the same
//! weights at every level, with no simulation's bands.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: r#"w = stub.world; g = stub.gear
w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30
w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde""#
			.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Gear.xml"])],
		login: true,
		script: ["G = Polestar.Gear\n", script].concat(),
		..Default::default()
	})
}

#[test]
fn an_item_s_ratings_count_at_the_client_s_points_per_1_percent_and_plain_hit_and_crit_count_for_spells_too() {
	let out = run(r#"
		g.defineItem("item:9101", { equipLoc = "INVTYPE_CHEST", classID = 4, subclassID = 4, minLevel = 20, stats = {
			ITEM_MOD_STRENGTH_SHORT = 10, ITEM_MOD_CRIT_RATING_SHORT = 14, ITEM_MOD_HIT_RATING_SHORT = 10, ITEM_MOD_CRIT_SPELL_RATING_SHORT = 7,
			ITEM_MOD_HASTE_RATING_SHORT = 20, ITEM_MOD_EXPERTISE_RATING_SHORT = 5, ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT = 10,
			ITEM_MOD_DODGE_RATING_SHORT = 12, ITEM_MOD_PARRY_RATING_SHORT = 15, ITEM_MOD_BLOCK_RATING_SHORT = 5,
			ITEM_MOD_DEFENSE_SKILL_RATING_SHORT = 3, ITEM_MOD_HIT_MELEE_RATING_SHORT = 20 } })
		emit(G.GetItemInfo("item:9101").stats)
	"#);
	assert_eq!(
		out[0],
		json!({ "str": 10, "crit": 1, "spellCrit": 1.5, "hit": 3, "spellHit": 1, "haste": 2, "expertise": 0.5, "armorPen": 1,
			"dodge": 1, "parry": 1, "block": 1, "defense": 3 }),
		"14 crit rating is 1% (melee and spell), 10 hit 1%, 20 haste 2%; defense rating is defense skill"
	);
}

#[test]
fn every_spec_weighs_haste_melee_specs_expertise_and_armor_penetration_casters_neither() {
	let out = run(r#"
		local out = {}
		for class, specs in pairs(G.WEIGHTS) do
			for key, w in pairs(specs) do
				out[class .. "." .. key] = { haste = w.haste or 0, expertise = w.expertise or 0, armorPen = w.armorPen or 0, crit = w.crit or 0 }
			end
		end
		local stat = {}
		for _, k in ipairs(G.STAT_KEYS) do stat[k] = true end
		emit({ specs = out, keys = { stat.haste or false, stat.expertise or false, stat.armorPen or false } })
	"#);
	let specs = out[0]["specs"].as_object().unwrap();
	assert_eq!(specs.len(), 27);
	assert_eq!(out[0]["keys"], json!([true, true, true]));
	let melee = [
		"WARRIOR.arms",
		"WARRIOR.fury",
		"WARRIOR.protection",
		"PALADIN.protection",
		"PALADIN.retribution",
		"ROGUE.assassination",
		"ROGUE.combat",
		"ROGUE.subtlety",
		"SHAMAN.enhancement",
		"DRUID.feral",
	];
	for (name, w) in specs {
		assert!(w["haste"].as_f64().unwrap() > 0.0, "{name} weighs haste");
		let is_melee = melee.contains(&name.as_str());
		let hunter = name.starts_with("HUNTER.");
		assert_eq!(w["expertise"].as_f64().unwrap() > 0.0, is_melee || hunter, "{name}: expertise");
		assert_eq!(w["armorPen"].as_f64().unwrap() > 0.0, is_melee || hunter, "{name}: armor penetration");
		if is_melee && name != "WARRIOR.protection" && name != "PALADIN.protection" {
			assert!(w["haste"].as_f64().unwrap() < w["crit"].as_f64().unwrap(), "{name}: specials are not hasted, so haste is worth less than crit");
		}
	}
}

#[test]
fn the_weights_are_polestar_s_own_at_every_level_no_simulation_band_replaces_them() {
	let out = run(r#"
		local diff = {}
		for class, specs in pairs(G.WEIGHTS) do
			for key, w in pairs(specs) do
				for _, level in ipairs({ 1, 24, 25, 40, 59, 60 }) do
					local got, info = G.WeightsFor(class, key, level)
					for k, v in pairs(w) do
						if got[k] ~= v then diff[#diff + 1] = class .. "." .. key .. "@" .. level .. ":" .. k end
					end
					if info.source ~= "polestar" then diff[#diff + 1] = class .. "." .. key .. "@" .. level .. ":source=" .. tostring(info.source) end
				end
			end
		end
		emit({ n = #diff, first = diff[1] or false })
	"#);
	assert_eq!(out[0], json!({ "n": 0, "first": false }), "Weights.lua's numbers at every level");
}

#[test]
fn pawn_s_haste_expertise_and_armor_penetration_map_to_the_new_keys() {
	let out = run(r#"
		local p = assert(G.Pawn.Parse('( Pawn: v1: "R": HasteRating=3, ExpertiseRating=2, ArmorPenetration=1, CritRating=4 )'))
		local w, mapped, ignored = G.Pawn.Weights(p)
		emit({ w = w, mapped = mapped, ignored = ignored })
	"#);
	assert_eq!(out[0], json!({ "w": { "haste": 3, "expertise": 2, "armorPen": 1, "crit": 4 }, "mapped": 4, "ignored": {} }));
}
