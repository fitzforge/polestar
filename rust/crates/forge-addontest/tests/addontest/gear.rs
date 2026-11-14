//! Polestar.Gear (addon/Polestar/Gear): item stats from ItemDB and the client, leveling weights, scoring and
//! comparison across slot types, spec detection, the tooltip line (also on quest reward choices) and the
//! options page.

use std::collections::HashSet;

use forge_addontest::{emitted, fake_locale, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

// Fixture item entries in the generated format (see forge-data gear/leveling.rs encode, `forge data itemdb`).
const FIXTURE: &str = r#"{
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
	[9002] = "1 25 20 2 4 3 str10 sta4 armor170",
	[9003] = "1 45 40 3 4 4 str15 sta10 armor400",
	[9004] = "1 20 15 2 4 1 int10 spi5 armor30",
	[9005] = "1 35 30 2 4 4 str8 sta8 armor300",
	[9006] = "1 25 20 2 4 3 str10 sta4 armor170 crit1",
	[9010] = "11 20 15 2 4 0 sta5",
	[9011] = "11 20 15 2 4 0 sta2",
	[9012] = "11 20 15 2 4 0 sta4",
	[9013] = "11 25 20 3 4 0 sta6 uniq1",
	[9020] = "12 30 25 3 4 0 ap20",
	[9030] = "13 20 15 2 2 7 str2 dmin10 dmax20 speed2000",
	[9031] = "14 20 15 2 4 6 sta3 armor500",
	[9032] = "17 22 17 2 2 8 str10 dmin40 dmax60 speed3000",
	[9033] = "13 22 17 2 2 7 agi3 dmin12 dmax22 speed1800",
	[9040] = "16 20 15 2 4 1 sta3",
	[9050] = "7 76 60 4 4 1 sta16 int21 spi21 armor101 heal46 mpr7 cls16",
	[9060] = "17 25 0 3 2 10 sta14 spFire34 spShadow34 dmin36 dmax55 speed2900 cls256",
	[9061] = "17 33 28 3 2 10 sta14 sp36 heal36 dmin59 dmax90 speed3600",
	[9062] = "16 30 25 2 4 1 spFire10 spFrost10",
	[9063] = "16 30 25 2 4 1 sp10",
	[9064] = "16 30 25 2 4 1 spShadow20",
	[9070] = "13 22 17 2 2 0 agi3 dmin12 dmax22 speed1800",
	[9071] = "17 22 17 2 2 1 str10 dmin40 dmax60 speed3000",
}"#;

// Troll by default: a race with no gear trait (racials have their own tests).
struct Opts {
	cls: &'static str,
	class_name: &'static str,
	class_id: i32,
	level: i32,
	race: &'static str,
	race_id: i32,
	faction: &'static str,
	before: String,
	login: bool,
}

impl Default for Opts {
	fn default() -> Opts {
		Opts { cls: "WARRIOR", class_name: "Warrior", class_id: 1, level: 30, race: "Troll", race_id: 8, faction: "Horde", before: String::new(), login: true }
	}
}

fn run(script: &str, o: Opts) -> Vec<Value> {
	let Opts { cls, class_name, class_id, level, race, race_id, faction, before, login } = o;
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: format!(
			"w = stub.world; g = stub.gear\nw.class, w.className, w.classID, w.level = \"{cls}\", \"{class_name}\", {class_id}, {level}\nw.race, w.raceName, w.raceID, w.faction = \"{race}\", \"{race}\", {race_id}, \"{faction}\"\n{before}"
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Gear.xml"])],
		login,
		script: ["G = Polestar.Gear\nPolestar.ItemDB.Register({ schema = 1, build = \"test\" }, ", FIXTURE, ")\n", script].concat(),
		..Default::default()
	})
}

fn r1(v: &Value) -> f64 {
	(v.as_f64().unwrap() * 10.0).round() / 10.0
}

#[test]
fn itemdb_parses_entries_header_fields_stat_tokens_weapon_dps_class_mask_unique_mp5_alias() {
	let out = run(
		r#"
		emit(Polestar.ItemDB.Get(9032)); emit(Polestar.ItemDB.Get(9050)); emit(Polestar.ItemDB.Get(9013)); emit(Polestar.ItemDB.Get(1) == nil)
	"#,
		Opts::default(),
	);
	let (sword, legs, ring, missing) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(
		json!({ "inv": sword["inv"], "ilvl": sword["ilvl"], "req": sword["req"], "quality": sword["quality"], "class": sword["class"], "subclass": sword["subclass"], "speed": sword["speed"] }),
		json!({ "inv": 17, "ilvl": 22, "req": 17, "quality": 2, "class": 2, "subclass": 8, "speed": 3000 })
	);
	assert_eq!(sword["stats"], json!({ "str": 10, "dps": 16.7 }));
	assert_eq!(legs["stats"], json!({ "sta": 16, "int": 21, "spi": 21, "armor": 101, "heal": 46, "mp5": 7 }));
	assert_eq!(legs["allow"], 16);
	assert_eq!(ring["unique"], true);
	assert_eq!(*missing, true);
}

#[test]
fn client_stats_win_over_itemdb_for_base_stats_itemdb_fills_equip_bonuses_the_client_left_out() {
	let out = run(
		r#"
		g.defineItem("item:9006", { equipLoc = "INVTYPE_HEAD", classID = 4, subclassID = 3, minLevel = 20,
			stats = { ITEM_MOD_STRENGTH_SHORT = 12, ITEM_MOD_STAMINA_SHORT = 4, RESISTANCE0_NAME = 170 } })
		g.defineItem("item:7777", { equipLoc = "INVTYPE_HEAD", classID = 4, subclassID = 2, minLevel = 10,
			stats = { ITEM_MOD_STRENGTH_SHORT = 3 } })
		emit(G.GetItemInfo("item:9006").stats)
		emit({ G.GetItemInfo("item:7777").stats, G.GetItemInfo("item:7777").inv, G.ScoreItem("item:7777") })
		emit(G.ScoreItem("item:5555") == nil)
	"#,
		Opts::default(),
	);
	assert_eq!(out[0], json!({ "str": 12, "sta": 4, "armor": 170, "crit": 1 }));
	assert_eq!(out[1], json!([{ "str": 3 }, 1, 3]));
	assert_eq!(out[2], true);
}

#[test]
fn combined_client_spell_power_scores_damage_and_healing_but_damage_only_does_not() {
	let out = run(
		r#"
		local _, imported = G.Scales.Import('( Pawn: v1: "Spellcaster": SpellDamage=0.9, Healing=0.5, Armor=0.005 )', "WARRIOR")
		Polestar.Set("gear.spec.WARRIOR", "custom:" .. imported.scale.id)
		local cases = {
			{ ITEM_MOD_SPELL_POWER_SHORT = 13, RESISTANCE0_NAME = 104 },
			{ ITEM_MOD_SPELL_DAMAGE_DONE_SHORT = 13, RESISTANCE0_NAME = 104 },
			{ ITEM_MOD_SPELL_DAMAGE_DONE_SHORT = 13, ITEM_MOD_SPELL_HEALING_DONE_SHORT = 21, RESISTANCE0_NAME = 104 },
		}
		for i, stats in ipairs(cases) do
			local link = "item:" .. (7800 + i)
			g.defineItem(link, { equipLoc = "INVTYPE_CLOAK", classID = 4, subclassID = 1, stats = stats })
			emit({ stats = G.GetItemInfo(link).stats, score = G.ScoreItem(link) })
		end
	"#,
		Opts::default(),
	);
	assert_eq!(out[0]["stats"], json!({ "sp": 13, "heal": 13, "armor": 104 }));
	assert_eq!(out[1]["stats"], json!({ "sp": 13, "armor": 104 }));
	assert_eq!(out[2]["stats"], json!({ "sp": 13, "heal": 21, "armor": 104 }));
	for (item, expected) in out.iter().zip([18.72, 12.22, 22.72]) {
		let score = item["score"].as_f64().unwrap();
		assert!((score - expected).abs() < 1e-9, "expected {expected}, got {score}");
	}
}

#[test]
fn combined_client_spell_power_supplies_healing_before_itemdb_fills_missing_equip_bonuses() {
	let out = run(
		r#"
		-- The ItemDB fixture has sp36 heal36. Live combined power supplies both
		-- channels, while damage-only still lets ItemDB fill omitted healing.
		g.defineItem("item:9061:1", { stats = { ITEM_MOD_SPELL_POWER_SHORT = 13 } })
		g.defineItem("item:9061:2", { stats = { ITEM_MOD_SPELL_DAMAGE_DONE_SHORT = 13 } })
		g.defineItem("item:9061:3", { stats = { ITEM_MOD_SPELL_DAMAGE_DONE_SHORT = 13, ITEM_MOD_SPELL_HEALING_DONE_SHORT = 21 } })
		for _, link in ipairs({ "item:9061:1", "item:9061:2", "item:9061:3", "item:9061" }) do
			local stats = G.GetItemInfo(link).stats
			emit({ sp = stats.sp, heal = stats.heal })
		end
	"#,
		Opts::default(),
	);
	assert_eq!(out, vec![json!({ "sp": 13, "heal": 13 }), json!({ "sp": 13, "heal": 36 }), json!({ "sp": 13, "heal": 21 }), json!({ "sp": 36, "heal": 36 })]);
}

// A damage-only or healing-only bonus is a stat of its own next to combined spell power, so the two add up. The
// client's item table gives Earthen Silk Slippers (254013) 18 combined and 6 damage, and Atiesh (22631) 120
// combined and 180 healing: 24 damage and 18 healing, and 120 damage and 300 healing, as their item data says.
#[test]
fn combined_spell_power_adds_to_a_damage_only_or_healing_only_bonus() {
	let out = run(
		r#"
		local cases = {
			{ ITEM_MOD_SPELL_POWER_SHORT = 18, ITEM_MOD_SPELL_DAMAGE_DONE_SHORT = 6 },
			{ ITEM_MOD_SPELL_POWER_SHORT = 120, ITEM_MOD_SPELL_HEALING_DONE_SHORT = 180 },
			{ ITEM_MOD_SPELL_DAMAGE_DONE_SHORT = 16, ITEM_MOD_SPELL_HEALING_DONE_SHORT = 48 },
			{ ITEM_MOD_SPELL_POWER_SHORT = 13 },
		}
		for i, stats in ipairs(cases) do
			local link = "item:" .. (7800 + i)
			g.defineItem(link, { equipLoc = "INVTYPE_CLOAK", classID = 4, subclassID = 1, stats = stats })
			emit(G.GetItemInfo(link).stats)
		end
	"#,
		Opts::default(),
	);
	assert_eq!(out, vec![json!({ "sp": 24, "heal": 18 }), json!({ "sp": 120, "heal": 300 }), json!({ "sp": 16, "heal": 48 }), json!({ "sp": 13, "heal": 13 })]);
}

#[test]
fn the_class_weight_table_nine_classes_three_specs_each_known_stat_keys_sane_priorities() {
	let out = run(r#"emit({ classes = G.CLASSES, weights = G.WEIGHTS, keys = G.STAT_KEYS, prof = G.PROFICIENCY })"#, Opts::default());
	let t = &out[0];
	let keys: HashSet<&str> = t["keys"].as_array().unwrap().iter().map(|k| k.as_str().unwrap()).collect();
	let mut classes: Vec<&str> = t["classes"].as_object().unwrap().keys().map(String::as_str).collect();
	classes.sort();
	assert_eq!(classes, vec!["DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR"]);
	for c in &classes {
		let meta = &t["classes"][*c];
		let specs = meta["specs"].as_array().unwrap();
		assert_eq!(specs.len(), 3, "{c}");
		assert!(specs.iter().any(|s| s["key"] == meta["default"]), "{c} default spec");
		assert!(truthy(&t["prof"][*c]), "{c} proficiencies");
		for s in specs {
			let key = text(&s["key"]);
			let w = &t["weights"][*c][key];
			assert!(truthy(w), "{c}.{key} has weights");
			for (k, v) in w.as_object().unwrap() {
				assert!(keys.contains(k.as_str()), "{c}.{key}: unknown stat {k}");
				assert!(v.as_f64().is_some_and(|f| f >= 0.0), "{c}.{key}.{k} = {v}");
			}
		}
	}
	let n = |v: &Value| v.as_f64().unwrap_or(f64::NAN);
	let w = &t["weights"];
	assert!(n(&w["WARRIOR"]["arms"]["str"]) > n(&w["WARRIOR"]["arms"]["int"]) || !truthy(&w["WARRIOR"]["arms"]["int"]));
	assert!(n(&w["WARRIOR"]["protection"]["sta"]) >= n(&w["WARRIOR"]["protection"]["str"]) && n(&w["WARRIOR"]["protection"]["defense"]) > 0.0);
	assert!(n(&w["MAGE"]["frost"]["int"]) > w["MAGE"]["frost"]["str"].as_f64().unwrap_or(0.0) && n(&w["MAGE"]["frost"]["spFrost"]) > 0.0);
	assert!(n(&w["HUNTER"]["marksmanship"]["rdps"]) > n(&w["HUNTER"]["marksmanship"]["dps"]));
	assert!(n(&w["PRIEST"]["holy"]["heal"]) > n(&w["PRIEST"]["holy"]["sp"]) && n(&w["PRIEST"]["shadow"]["sp"]) > n(&w["PRIEST"]["shadow"]["heal"]));
	assert!(!truthy(&w["DRUID"]["feral"]["dps"]), "feral's weapon DPS weight comes from its attack power, in Gear.WeightsFor");
	assert!(n(&w["ROGUE"]["combat"]["agi"]) >= n(&w["ROGUE"]["combat"]["str"]));
}

#[test]
fn single_slots_upgrade_downgrade_empty_slot_equipped_item() {
	let out = run(
		r#"
		g.equip(1, "item:9001")
		emit(G.CompareToEquipped("item:9002"))
		emit(G.CompareToEquipped("item:9004"))
		emit({ G.IsUpgrade("item:9040") })
		emit(G.CompareToEquipped("item:9001"))
	"#,
		Opts::default(),
	);
	let (up, down, empty, worn) = (&out[0], &out[1], &out[2], &out[3]);
	// Arms: str 1, sta 0.5, armor 0.02, spi 0.1
	assert_eq!(r1(&up["old"]), 9.5);
	assert_eq!(r1(&up["new"]), 15.4);
	assert_eq!(up["slot"], 1);
	assert_eq!(r1(&up["pct"]), 62.1);
	assert_eq!(r1(&down["new"]), 1.1);
	assert!(down["pct"].as_f64().unwrap() < 0.0);
	assert_eq!(json!([empty[0], r1(&empty[1])]), json!([true, 1.5])); // cloak into an empty back slot: no percentage
	assert!(empty[2].is_null());
	assert_eq!(worn["equipped"], true);
}

#[test]
fn rings_replace_the_weaker_ring_a_unique_ring_only_its_own_copy_trinkets_fill_an_empty_slot() {
	let out = run(
		r#"
		g.equip(11, "item:9010"); g.equip(12, "item:9011")
		emit(G.CompareToEquipped("item:9012"))
		g.equip(11, "item:9013:0"); g.equip(12, "item:9010")
		emit(G.CompareToEquipped("item:9013"))
		emit(G.CompareToEquipped("item:9020"))
	"#,
		Opts::default(),
	);
	let (ring, unique, trinket) = (&out[0], &out[1], &out[2]);
	assert_eq!(ring["slot"], 12);
	assert_eq!(json!([ring["old"], ring["new"], r1(&ring["pct"])]), json!([1, 2, 100.0]));
	assert_eq!(unique["slot"], 11);
	assert_eq!(unique["delta"], 0);
	assert_eq!(trinket["empty"], true);
	assert_eq!(trinket["delta"], 10); // 20 attack power x 0.5
	assert!(trinket["pct"].is_null());
}

#[test]
fn a_two_hander_is_weighed_against_main_hand_off_hand_and_a_one_hander_against_a_two_hander_with_the_best_bag_off_hand() {
	let out = run(
		r#"
		g.equip(16, "item:9030"); g.equip(17, "item:9031")
		emit(G.CompareToEquipped("item:9032"))
		emit({ G.IsUpgrade("item:9032") })
		g.equip(17, nil); g.equip(16, "item:9032"); g.bag(0, 3, "item:9031")
		emit(G.CompareToEquipped("item:9033"))
		g.bag(0, 3, nil)
		emit(G.CompareToEquipped("item:9033"))
	"#,
		Opts::default(),
	);
	let (two_hand, upgrade, one_hand, one_hand_no_bag) = (&out[0], &out[1], &out[2], &out[3]);
	// MH 9030: 2 str + 7.5 dps x 7 = 54.5; shield 9031: 3 sta x 0.5 + 500 armor x 0.02 = 11.5
	assert_eq!(r1(&two_hand["old"]), 66.0);
	// 2H 9032: 10 str + 16.7 dps x 7 = 126.9
	assert_eq!(r1(&two_hand["new"]), 126.9);
	assert_eq!(two_hand["slot"], 16);
	assert_eq!(upgrade[0], true);
	assert_eq!(r1(&upgrade[2]), 92.3);
	// 1H 9033: 3 agi x 0.6 + 9.4 dps x 7 = 67.6, plus the shield from the bags
	assert_eq!(r1(&one_hand["old"]), 126.9);
	assert_eq!(r1(&one_hand["new"]), 79.1);
	assert_eq!(r1(&one_hand_no_bag["new"]), 67.6);
}

#[test]
fn dual_wielders_try_a_one_hander_in_the_off_hand_at_half_weapon_dps() {
	let out = run(
		r#"
		Polestar.Set("gear.spec.WARRIOR", "fury")
		g.equip(16, "item:9030")
		emit(G.CompareToEquipped("item:9033"))
		w.level = 12; w.setLevel(12)
		emit(G.CompareToEquipped("item:9033"))
	"#,
		Opts::default(),
	);
	let (dw, no_dw) = (&out[0], &out[1]);
	// Fury: off hand empty -> 3 agi x 0.65 + 9.4 x 6.5 x 0.5 = 32.5 beats the main-hand gain (63.05 - 50.75)
	assert_eq!(dw["slot"], 17);
	assert_eq!(dw["empty"], true);
	assert_eq!(r1(&dw["new"]), 32.5);
	assert_eq!(no_dw["slot"], 16); // no Dual Wield before level 20
	assert_eq!(r1(&no_dw["delta"]), 12.3);
}

#[test]
fn proficiency_and_level_plate_waits_for_40_cloth_only_classes_cannot_wear_it_class_restricted_items() {
	let plate = run(
		r#"g.equip(1, "item:9001"); local up = G.IsUpgrade("item:9005"); local r = G.CompareToEquipped("item:9005")
			emit({ up = up, minLevel = r.minLevel, usable = r.usable, delta = r.delta })"#,
		Opts::default(),
	)
	.remove(0);
	let mage = run(
		r#"emit({ G.ScoreItem("item:9003") == nil, G.CompareToEquipped("item:9003").reason, G.IsUpgrade("item:9003") })"#,
		Opts { cls: "MAGE", class_name: "Mage", class_id: 8, ..Default::default() },
	)
	.remove(0);
	let priest_only = run(r#"emit({ G.ScoreItem("item:9050") == nil, G.CompareToEquipped("item:9050").reason })"#, Opts::default()).remove(0);
	assert_eq!(plate["usable"], true);
	assert_eq!(plate["minLevel"], 40);
	assert!(plate["delta"].as_f64().unwrap() > 0.0);
	assert_eq!(plate["up"], false);
	assert_eq!(mage, json!([true, "armor", false]));
	assert_eq!(priest_only, json!([true, "class"]));
	let priest = run(r#"emit(G.ScoreItem("item:9050") ~= nil)"#, Opts { cls: "PRIEST", class_name: "Priest", class_id: 5, level: 60, ..Default::default() });
	assert_eq!(priest[0], true);
}

// #107: rogues can train swords, but only from a weapon master.
#[test]
fn a_weapon_the_class_can_train_but_the_character_has_not_learned_is_no_upgrade_until_the_skill_is_learned() {
	let out = run(
		r#"
		w.learnSkill(173, "Daggers", 1, 150)
		local before = G.CompareToEquipped("item:9030")
		local b = { up = G.IsUpgrade("item:9030"), usable = before.usable, reason = before.reason }
		w.learnSkill(43, "Swords", 1, 150)
		local after = G.CompareToEquipped("item:9030")
		emit({ before = b, after = { up = G.IsUpgrade("item:9030"), usable = after.usable, reason = after.reason } })
	"#,
		Opts { cls: "ROGUE", class_name: "Rogue", class_id: 4, ..Default::default() },
	);
	let r = &out[0];
	assert_eq!(r["before"], json!({ "up": false, "usable": false, "reason": "skill" }));
	assert_eq!(r["after"]["usable"], true);
	assert_eq!(r["after"]["up"], true);
	assert!(r["after"]["reason"].is_null());
}

#[test]
fn a_rogue_can_upgrade_to_a_one_handed_axe_after_learning_the_skill() {
	let out = run(
		r#"
		w.learnSkill(173, "Daggers", 1, 150)
		emit(G.IsUpgrade("item:9070"))
		w.learnSkill(44, "One-Handed Axes", 1, 150)
		emit(G.IsUpgrade("item:9070"))
		w.learnSkill(172, "Two-Handed Axes", 1, 150)
		emit(G.CompareToEquipped("item:9071").reason)
	"#,
		Opts { cls: "ROGUE", class_name: "Rogue", class_id: 4, ..Default::default() },
	);
	assert_eq!(out, vec![json!(false), json!(true), json!("weapon")]);
}

#[test]
fn without_weapon_skill_data_the_class_weapon_list_decides_as_before() {
	let out = run(r#"local c = G.CompareToEquipped("item:9030"); emit({ G.IsUpgrade("item:9030"), c.usable })"#, Opts { cls: "ROGUE", class_name: "Rogue", class_id: 4, ..Default::default() });
	assert_eq!(out[0], json!([true, true]));
}

#[test]
fn spec_automatic_from_the_talent_spread_the_chosen_primary_tree_the_class_default_before_any_point_a_chosen_spec_wins() {
	let out = run(
		r#"
		emit({ G.GetSpec() })
		g.specSelection, g.primary = true, 2
		g.setSpecs({ { "Arms", 0 }, { "Fury", 0 }, { "Protection", 0 } })
		emit({ G.GetSpec() })
		g.setSpecs({ { "Arms", 5 }, { "Fury", 21 }, { "Protection", 0 } })
		g.primary = 1
		emit({ G.GetSpec() })
		Polestar.Set("gear.spec.WARRIOR", "protection")
		emit({ G.GetSpec() })
		Polestar.Set("gear.spec.WARRIOR", "auto")
		emit({ G.GetSpec() })
	"#,
		Opts::default(),
	);
	assert_eq!(out[0], json!(["arms", "Arms", "default"]));
	assert_eq!(out[1], json!(["fury", "Fury", "talents"]));
	assert_eq!(out[2], json!(["fury", "Fury", "talents"]));
	assert_eq!(out[3], json!(["protection", "Protection (tank)", "setting"]));
	assert_eq!(out[4], json!(["fury", "Fury", "talents"]));
}

fn druid(level: i32) -> Opts {
	Opts { cls: "DRUID", class_name: "Druid", class_id: 11, level, ..Default::default() }
}

// Forever keeps talents in a C_Traits tree; its talent-tab API (GetSpecializationInfo) gives no points, so a
// Restoration Druid fell to the class default, Feral. The columns' points come from the tree's groups, the way
// Forever's talent frame heads them.
#[test]
fn spec_automatic_on_forever_reads_the_talent_columns_points_a_restoration_druid_is_restoration_in_any_language() {
	let out = run(
		r#"
		g.setSpecs({ { "Balance", 0 }, { "Feral Combat", 0 }, { "Restoration", 0 } })
		g.setColumns({ { "Balance", 0 }, { "Feral Combat", 0 }, { "Restoration", 0 } })
		emit({ G.GetSpec() })
		g.setColumns({ { "Balance", 0 }, { "Feral Combat", 0 }, { "Restoration", 11 } })
		emit({ G.GetSpec() })
		g.setColumns({ { "Gleichgewicht", 2 }, { "Wilder Kampf", 0 }, { "Wiederherstellung", 9 } })
		emit({ G.GetSpec() })
		g.setColumns({ { "Balance", 0 }, { "Feral Combat", 8 }, { "Restoration", 5 } })
		emit({ G.GetSpec() })
		g.setColumns(nil)
		g.setSpecs({ { "Balance", 0 }, { "Feral Combat", 0 }, { "Restoration", 12 } })
		emit({ G.GetSpec() })
	"#,
		druid(20),
	);
	assert_eq!(out[0], json!(["feral", "Feral", "default"]), "no points yet: the levelling default");
	assert_eq!(out[1], json!(["restoration", "Restoration (healer)", "talents"]), "most points in Restoration");
	assert_eq!(out[2], json!(["restoration", "Restoration (healer)", "talents"]), "a German client: by column");
	assert_eq!(out[3], json!(["feral", "Feral", "talents"]), "a hybrid with more Feral points");
	assert_eq!(out[4], json!(["restoration", "Restoration (healer)", "talents"]), "no trait tree: the talent tabs");
}

// A group row the client gives without its traitNodeGroupID (a tree it shapes otherwise) is no Lua error: its
// points are unknown, and the talent tabs answer.
#[test]
fn spec_automatic_a_talent_group_row_without_its_id_is_no_lua_error_the_talent_tabs_answer() {
	let out = run(
		r#"
		g.setSpecs({ { "Balance", 0 }, { "Feral Combat", 0 }, { "Restoration", 12 } })
		g.setColumns({ { "Balance", 0 }, { "Feral Combat", 0 }, { "Restoration", 11 } })
		C_Traits.GetGroupCurrencyInfo = function() return { { currencyInfos = { { traitCurrencyID = 1, quantity = 0, spent = 11 } } } } end
		emit({ G.GetSpec() })
	"#,
		druid(20),
	);
	assert_eq!(out[0], json!(["restoration", "Restoration (healer)", "talents"]));
}

// A player set Stat weights to Restoration and saw Feral come back. The chosen spec holds over a reload, a level,
// talent points in Feral and Cat Form, on every surface: the spec, the weights, the tooltip line and reward picks.
#[test]
fn a_chosen_spec_holds_over_reload_level_up_talent_points_and_cat_form_on_every_gear_surface() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: [
			"w = stub.world; g = stub.gear\n",
			"w.class, w.className, w.classID, w.level = \"DRUID\", \"Druid\", 11, 20\n",
			"w.race, w.raceName, w.raceID, w.faction = \"Troll\", \"Troll\", 8, \"Horde\"\n",
			"g.columns = { { \"Balance\", 0 }, { \"Feral Combat\", 11 }, { \"Restoration\", 0 } }\n",
		]
		.concat(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Gear.xml"])],
		saved: vec![("Polestar".into(), "PolestarDB = { schema = 1, settings = { gear = { spec = { DRUID = \"restoration\" } } } }".into())],
		login: true,
		script: [
			"G = Polestar.Gear\nPolestar.ItemDB.Register({ schema = 1, build = \"test\" }, ",
			FIXTURE,
			r#")
		g.defineItem("item:8001", { equipLoc = "INVTYPE_CHEST", classID = 4, subclassID = 2, minLevel = 15,
			stats = { ITEM_MOD_AGILITY_SHORT = 8, ITEM_MOD_STRENGTH_SHORT = 6, ITEM_MOD_STAMINA_SHORT = 4, RESISTANCE0_NAME = 80 } })
		g.defineItem("item:8002", { equipLoc = "INVTYPE_CHEST", classID = 4, subclassID = 2, minLevel = 15,
			stats = { ITEM_MOD_INTELLECT_SHORT = 8, ITEM_MOD_SPIRIT_SHORT = 6, ITEM_MOD_STAMINA_SHORT = 4, RESISTANCE0_NAME = 80 } })
		g.defineItem("item:8003", { equipLoc = "INVTYPE_CHEST", classID = 4, subclassID = 2, minLevel = 1,
			stats = { ITEM_MOD_STAMINA_SHORT = 1, RESISTANCE0_NAME = 40 } })
		g.equip(5, "item:8003")
		local function surfaces(when)
			local key, label, source = G.GetSpec()
			local _, pick = G.RankChoices({ "item:8001", "item:8002" })
			local line = g.showTooltip(GameTooltip, "item:8002")[1]
			emit({ when = when, key = key, label = label, source = source, heal = G.GetWeights().heal or false,
				pick = pick, line = line, saved = PolestarDB.settings.gear.spec.DRUID })
		end
		surfaces("login")
		w.setLevel(21)
		surfaces("level")
		g.setColumns({ { "Balance", 0 }, { "Feral Combat", 12 }, { "Restoration", 0 } })
		g.setSpecs({ { "Balance", 0 }, { "Feral Combat", 12 }, { "Restoration", 0 } })
		surfaces("talent")
		stub.fire("UPDATE_SHAPESHIFT_FORM")
		stub.fire("ACTIVE_TALENT_GROUP_CHANGED")
		surfaces("cat form")
		Polestar.Set("gear.spec.DRUID", "auto")
		surfaces("automatic")
	"#,
		]
		.concat(),
	});
	for o in &out[..4] {
		let when = text(&o["when"]);
		assert_eq!(o["key"], "restoration", "{when}: {o}");
		assert_eq!(o["source"], "setting", "{when}: {o}");
		assert_eq!(o["saved"], "restoration", "{when}: the setting is still saved");
		assert!(o["heal"].as_f64().unwrap() > 0.0, "{when}: Restoration weights");
		assert_eq!(o["pick"], 2, "{when}: the Intellect/Spirit chest over the Agility one");
		assert!(is_match(text(&o["line"]), r"^Polestar · Restoration \(healer\) \| "), "{when}: {}", o["line"]);
	}
	assert_eq!(out[4]["key"], "feral", "Automatic follows the Feral points again");
	assert_eq!(out[4]["pick"], 1);
}

#[test]
fn tooltip_line_upgrade_and_downgrade_percentages_empty_slot_later_level_skipped_for_secret_links_and_other_tooltips() {
	let out = run(
		r#"
		g.equip(1, "item:9001")
		emit(g.showTooltip(GameTooltip, "item:9002"))
		emit(g.showTooltip(GameTooltip, "item:9004"))
		emit(g.showTooltip(ItemRefTooltip, "item:9040"))
		emit(g.showTooltip(GameTooltip, "item:9005"))
		g.secret["item:9002"] = true
		emit(g.showTooltip(GameTooltip, "item:9002"))
		g.secret["item:9002"] = nil
		emit(g.showTooltip(ShoppingTooltip1, "item:9002"))
		Polestar.Set("gear.tooltip", false)
		emit(g.showTooltip(GameTooltip, "item:9002"))
		Polestar.Set("gear.tooltip", true)
		g.showTooltip(GameTooltip, "item:9002")
		local up = GameTooltip.colors[1]
		g.showTooltip(GameTooltip, "item:9004")
		emit({ up, GameTooltip.colors[1] })
	"#,
		Opts::default(),
	);
	// The slot it replaces follows the gain; an empty slot needs no name.
	assert_eq!(out[0], json!(["Polestar · Arms | +62% upgrade · Head"]));
	assert_eq!(out[1], json!(["Polestar · Arms | -88% downgrade · Head"]));
	assert_eq!(out[2], json!(["Polestar · Arms | upgrade (empty slot)"]));
	assert_eq!(out[3], json!(["Polestar · Arms | +89% upgrade at level 40 · Head"]));
	assert_eq!(out[4], json!({}));
	assert_eq!(out[5], json!({}));
	assert_eq!(out[6], json!({}));
	let colors = &out[7];
	let c = |i: usize, j: usize| colors[i][j].as_f64().unwrap();
	assert!(c(0, 1) > c(0, 0), "upgrade is green");
	assert!(c(1, 0) > c(1, 1), "downgrade is red");
}

#[test]
fn tooltip_line_the_slot_is_the_client_s_own_word_backslot_chestslot_apart_from_the_back_button_and_the_boss_chest() {
	let out = run(
		r#"
		Polestar.ItemDB.Register(nil, { [9041] = "16 25 20 2 4 1 sta8", [9060] = "5 20 15 2 4 3 str5 sta3 armor200", [9061] = "5 25 20 2 4 3 str10 sta4 armor260" })
		g.equip(15, "item:9040")
		g.equip(5, "item:9060")
		emit(g.showTooltip(GameTooltip, "item:9041"))
		emit(g.showTooltip(GameTooltip, "item:9061"))
	"#,
		Opts { before: format!("{}\nBACKSLOT, CHESTSLOT = \"Espalda\", \"Pecho\"", fake_locale("itIT", &[("Back", "Atrás"), ("Chest", "Cofre"), ("boss: Chest", "Arca")])), ..Default::default() },
	);
	assert!(is_match(text(&out[0][0]), r"^Polestar · Arms \| .*upgrade · Espalda$"));
	assert!(is_match(text(&out[1][0]), r"^Polestar · Arms \| .*upgrade · Pecho$"));
}

#[test]
fn quest_reward_tooltips_hovering_a_choice_setquestitem_setquestlogitem_shows_the_upgrade_line_also_before_its_link_is_cached() {
	let out = run(
		r#"
		g.equip(1, "item:9001")
		g.rewards({ "item:9004", "item:9002" })
		emit({ GameTooltip:SetQuestItem("choice", 1), GameTooltip:SetQuestItem("choice", 2) })
		emit(GameTooltip:SetQuestLogItem("choice", 2))
		g.rewards({ "item:9004", "item:9002" }, { uncached = true })
		emit(GameTooltip:SetQuestItem("choice", 2))
		Polestar.Set("gear.tooltip", false)
		emit(GameTooltip:SetQuestItem("choice", 2))
	"#,
		Opts::default(),
	);
	assert_eq!(out[0], json!([["Polestar · Arms | -88% downgrade · Head"], ["Polestar · Arms | +62% upgrade · Head"]]));
	assert_eq!(out[1], json!(["Polestar · Arms | +62% upgrade · Head"]));
	assert_eq!(out[2], json!(["Polestar · Arms | +62% upgrade · Head"]));
	assert_eq!(out[3], json!({}));
}

#[test]
fn options_the_gear_advice_on_questing_with_the_class_spec_dropdown_registered_once() {
	// The rows are the settings' addon's (Polestar_Options/Gear/Options.lua), run here as it loads: one section, the
	// feature's switch in its header, the comparison's threshold and pairing beside the rest.
	let file = forge_addontest::run::addons_dir().join("Polestar_Options/Gear/Options.lua").to_string_lossy().into_owned();
	let out = run(
		&[
			r#"
		local seen = {}
		Polestar.RegisterOptions = function(def) seen[#seen + 1] = def; return true end
		dofile([["#,
			&file,
			r#"]])
		stub.login()"#,
			r#"
		local out = {}
		for _, def in ipairs(seen) do
			local keys = {}
			if def.toggle then keys[1] = def.toggle.key .. "=header:" .. (def.toggle.help and "help" or "nohelp") end
			for _, c in ipairs(def.controls) do keys[#keys + 1] = (c.key or c.label) .. "=" .. c.kind .. ":" .. (c.help and "help" or "nohelp") end
			out[#out + 1] = { page = def.page, section = def.section, keys = keys,
				choices = def.controls[1].choices and #def.controls[1].choices() or 0 }
		end
		emit(out)
	"#,
		]
		.concat(),
		Opts { login: false, ..Default::default() },
	);
	let defs = out[0].as_array().unwrap();
	assert_eq!(defs.len(), 1);
	assert!(defs.iter().all(|d| d["page"] == "Questing"));
	assert_eq!(
		defs[0]["keys"],
		json!([
			"gear.enabled=header:help",
			"gear.spec.WARRIOR=dropdown:help",
			"Adjust weights=button:help",
			"Manage custom weights=button:help",
			"gear.tooltip=toggle:help",
			"gear.minUpgrade=slider:help",
			"gear.bagArrows=toggle:help",
			"gear.hideForPawn=toggle:help",
			"gear.useBags=toggle:help",
			"gear.rewards=toggle:help",
			"gear.pickTooltip=toggle:help"
		])
	);
	assert_eq!(defs[0]["choices"], 4); // Automatic + three warrior specs
}

#[test]
fn gains_read_in_whole_percents_and_in_words_past_doubling() {
	let out = run(
		r#"
		local G = Polestar.Gear
		local function t(p) local s, big = G.GainText(p); return { s, big } end
		emit({ t(62.14), t(-88.4), t(0.2), t(-0.3), t(99.4), t(100), t(625) })"#,
		Opts::default(),
	);
	assert_eq!(out[0], json!([["+62%", false], ["-88%", false], ["+<1%", false], ["-<1%", false], ["+99%", false], ["big upgrade", true], ["big upgrade", true]]));
}

fn staff(id: i32, dps: f64) -> String {
	format!("g.defineItem(\"item:{id}\", {{ equipLoc = \"INVTYPE_2HWEAPON\", classID = 2, subclassID = 10, minLevel = 1, stats = {{ ITEM_MOD_DAMAGE_PER_SECOND_SHORT = {dps} }} }})")
}

#[test]
fn specs_with_no_melee_weapon_dps_weight_get_a_small_one_a_harder_hitting_staff_counts_for_a_druid_and_a_priest_a_warrior_keeps_its_own() {
	let probe = |cls: &'static str, class_name: &'static str, class_id: i32, spec: &str| {
		let script = format!(
			"\n\t\t{}\n\t\t{}\n\t\tg.equip(16, \"item:7001\")\n\t\tPolestar.Set(\"gear.spec.{cls}\", \"{spec}\")\n\t\tlocal up, delta, pct = G.IsUpgrade(\"item:7002\")\n\t\temit({{ up = up, delta = delta, w = G.GetWeights().dps }})\n\t",
			staff(7001, 1.2),
			staff(7002, 2.6)
		);
		run(&script, Opts { cls, class_name, class_id, level: 8, ..Default::default() }).remove(0)
	};
	let druid = probe("DRUID", "Druid", 11, "balance");
	assert_eq!(druid["up"], true, "the cane beats the knife on weapon DPS alone");
	assert_eq!(druid["w"], 0.01);
	assert_eq!(probe("PRIEST", "Priest", 5, "shadow")["up"], true);
	assert_eq!(probe("WARRIOR", "Warrior", 1, "arms")["w"], 7, "a weight the spec has is never changed");
}

const WAND: &str = r#"g.defineItem("item:7101", { equipLoc = "INVTYPE_RANGEDRIGHT", classID = 2, subclassID = 19, minLevel = 5, stats = { ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 3.1 } })"#;

#[test]
fn a_wand_fills_an_empty_ranged_slot_for_a_caster_the_ranged_dps_weight_already_counts_it_a_druid_has_no_wand_to_wear() {
	let mage = run(
		&[
			WAND,
			r#"
		local c = G.CompareToEquipped("item:7101")
		emit({ G.IsUpgrade("item:7101"), c.empty, c.slot })"#,
		]
		.concat(),
		Opts { cls: "MAGE", class_name: "Mage", class_id: 8, level: 8, ..Default::default() },
	)
	.remove(0);
	assert_eq!(mage, json!([true, true, 18]));
	let druid = run(
		&[
			WAND,
			r#"
		local c = G.CompareToEquipped("item:7101")
		emit({ G.IsUpgrade("item:7101"), c.usable, c.reason })"#,
		]
		.concat(),
		Opts { cls: "DRUID", class_name: "Druid", class_id: 11, level: 8, ..Default::default() },
	)
	.remove(0);
	assert_eq!(druid, json!([false, false, "weapon"]));
}

#[test]
fn the_melee_dps_weight_is_only_a_tiebreaker_a_stat_on_the_item_outweighs_any_weapon_dps_gap_and_a_dps_only_gain_keeps_its_percent() {
	let out = run(
		r#"
		g.defineItem("item:7201", { equipLoc = "INVTYPE_2HWEAPON", classID = 2, subclassID = 10, minLevel = 1, stats = { ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 12 } })
		g.defineItem("item:7202", { equipLoc = "INVTYPE_2HWEAPON", classID = 2, subclassID = 10, minLevel = 1, stats = { ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 2, ITEM_MOD_INTELLECT_SHORT = 1 } })
		g.defineItem("item:7203", { equipLoc = "INVTYPE_2HWEAPON", classID = 2, subclassID = 10, minLevel = 1, stats = { ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 2.6 } })
		g.defineItem("item:7204", { equipLoc = "INVTYPE_2HWEAPON", classID = 2, subclassID = 10, minLevel = 1, stats = { ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 1.3 } })
		Polestar.Set("gear.spec.PRIEST", "shadow")
		g.equip(16, "item:7201")
		local intWins = { G.IsUpgrade("item:7202") }
		g.equip(16, "item:7204")
		local dpsOnly = { G.IsUpgrade("item:7203") }
		emit({ intWins = intWins[1], dpsPct = dpsOnly[3] })
	"#,
		Opts { cls: "PRIEST", class_name: "Priest", class_id: 5, level: 8, ..Default::default() },
	);
	let out = &out[0];
	assert_eq!(out["intWins"], true, "+1 Intellect beats 10 DPS less");
	assert!((out["dpsPct"].as_f64().unwrap() - 100.0).abs() < 0.5, "doubling the DPS of a bare weapon is +100%, at any weight");
}

#[test]
fn feral_weighs_weapon_dps_at_14_attack_power_before_and_after_bear_form_balance_keeps_the_tiebreaker() {
	// In Forever, Cat, Bear and Dire Bear Form hit with the equipped weapon's DPS (#731).
	let w = |spec: &str, level: i32| {
		let script = format!("\n\t\tPolestar.Set(\"gear.spec.DRUID\", \"{spec}\")\n\t\tlocal w = G.GetWeights()\n\t\temit({{ dps = w.dps or false, ap = w.ap or false }})\n\t");
		run(&script, Opts { cls: "DRUID", class_name: "Druid", class_id: 11, level, ..Default::default() }).remove(0)
	};
	assert_eq!(w("feral", 9)["dps"], 7, "before any form the Druid fights with the weapon");
	assert_eq!(w("feral", 10)["dps"], 7, "cat and bear damage follows the weapon's DPS");
	assert_eq!(w("feral", 24)["dps"], 7, "the same as Arms");
	for level in [30, 45, 55, 60] {
		let f = w("feral", level);
		let (dps, ap) = (f["dps"].as_f64().unwrap(), f["ap"].as_f64().unwrap());
		assert!((dps - 14.0 * ap).abs() < 1e-9, "level {level}: 14 attack power per weapon DPS ({dps} vs ap {ap})");
	}
	assert_eq!(w("balance", 20)["dps"], 0.01);
}

#[test]
fn a_feral_druid_takes_the_harder_hitting_mace_over_a_caster_staff_with_more_stats() {
	// #731: at Leaders of the Fang the turn-in pick offered Crescent Staff over Hammerbone.
	let script = r#"
		g.defineItem("item:7201", { equipLoc = "INVTYPE_2HWEAPON", classID = 2, subclassID = 10, minLevel = 1,
			stats = { ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 15.2, ITEM_MOD_STAMINA_SHORT = 7, ITEM_MOD_INTELLECT_SHORT = 7 } })
		g.defineItem("item:7202", { equipLoc = "INVTYPE_2HWEAPON", classID = 2, subclassID = 5, minLevel = 1,
			stats = { ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 20.4 } })
		g.equip(16, "item:7201")
		Polestar.Set("gear.spec.DRUID", "feral")
		emit({ up = G.IsUpgrade("item:7202") })
	"#;
	let out = run(script, Opts { cls: "DRUID", class_name: "Druid", class_id: 11, level: 20, ..Default::default() }).remove(0);
	assert_eq!(out["up"], true, "5.2 more weapon DPS outweighs 7 Stamina and 7 Intellect");
}

// #833: an Orc Hunter at 13 with Rusty Hatchet (2.9 DPS, no stats) was told Jagged Dagger (6.0 DPS, +1 Strength)
// is a big downgrade. Axe Specialization's 1% crit was worth the Hunter's whole crit weight (10, the bow's) on the
// axe, against 0.5 per melee DPS: the axe scored 11.45, the dagger 3.1. A melee weapon's racial crit now counts
// by the spec's melee share (0.5 of 6.5); an Orc Warrior's axe keeps it whole. The items are Polestar_ItemDB's.
const AXE_AND_DAGGER: &str = r#"
		Polestar.ItemDB.Register(nil, {
			[1416] = "21 9 4 0 2 0 dmin4 dmax8 speed2100",
			[4947] = "13 11 0 2 2 15 str1 dmin6 dmax12 speed1500",
		})
		g.defineItem("item:1416", { equipLoc = "INVTYPE_WEAPONMAINHAND", classID = 2, subclassID = 0, minLevel = 4 })
		g.defineItem("item:4947", { equipLoc = "INVTYPE_WEAPON", classID = 2, subclassID = 15, minLevel = 0,
			stats = { ITEM_MOD_STRENGTH_SHORT = 1, ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 6 } })
		g.equip(16, "item:1416")
		local function round(x) return math.floor(x * 100 + 0.5) / 100 end
		local axe = G.GetItemInfo("item:1416")
		local w = G.GetWeights()
		emit({ axe = round(G.ScoreWith(axe, w)), dagger = round(G.ScoreItem("item:4947")) })
		emit(g.showTooltip(GameTooltip, "item:4947"))
"#;

#[test]
fn an_orc_hunters_axe_specialization_counts_by_how_much_a_hunter_fights_in_melee() {
	let orc = |cls: &'static str, class_name: &'static str, class_id: i32| Opts { cls, class_name, class_id, level: 13, race: "Orc", race_id: 2, ..Opts::default() };
	let hunter = run(AXE_AND_DAGGER, orc("HUNTER", "Hunter", 3));
	// 2.9 x 0.5 + 10 x 1% x (0.5 / 6.5); 6.0 x 0.5 + 0.1.
	assert_eq!(hunter[0], json!({ "axe": 2.22, "dagger": 3.1 }));
	assert_eq!(hunter[1], json!(["Polestar · Beast Mastery | +40% upgrade · Main Hand"]));
	// A Warrior fights with the axe: Axe Specialization counts whole (the dagger's double DPS still wins).
	let warrior = run(AXE_AND_DAGGER, orc("WARRIOR", "Warrior", 1));
	let (axe, dagger) = (warrior[0]["axe"].as_f64().unwrap(), warrior[0]["dagger"].as_f64().unwrap());
	let w = run("local w = G.GetWeights() emit({ dps = w.dps, crit = w.crit })", orc("WARRIOR", "Warrior", 1));
	let (dps_w, crit_w) = (w[0]["dps"].as_f64().unwrap(), w[0]["crit"].as_f64().unwrap());
	assert!((axe - (2.9 * dps_w + crit_w)).abs() < 0.01, "the Warrior's axe keeps the whole crit: {axe} vs {dps_w} {crit_w}");
	assert!(dagger > axe, "{dagger} > {axe}");
}

// #1304: an Orc Rogue at 2 with the Worn Dagger was told to equip a Skinning Knife (0.3 DPS more). The client lists
// it as a Miscellaneous weapon (subclass 14), like the Mining Pick, Blacksmith Hammer, Arclight Spanner and Frying
// Pan: profession tools and novelties, never a weapon pick. No upgrade, no score, no gear line on its tooltip.
#[test]
fn a_miscellaneous_weapon_is_a_profession_tool_never_an_upgrade_even_with_more_dps() {
	let out = run(
		r#"
		Polestar.ItemDB.Register(nil, {
			[2092] = "13 2 1 1 2 15 dmin1 dmax3 speed1600",
			[7005] = "13 4 1 1 2 14 dmin2 dmax4 speed1600",
		})
		g.defineItem("item:2092", { equipLoc = "INVTYPE_WEAPON", classID = 2, subclassID = 15, minLevel = 1 })
		g.defineItem("item:7005", { equipLoc = "INVTYPE_WEAPON", classID = 2, subclassID = 14, minLevel = 1 })
		g.equip(16, "item:2092")
		local r = G.CompareToEquipped("item:7005")
		emit({ up = G.IsUpgrade("item:7005"), usable = r.usable, reason = r.reason, scored = G.ScoreItem("item:7005") ~= nil })
		emit(g.showTooltip(GameTooltip, "item:7005"))
	"#,
		Opts { cls: "ROGUE", class_name: "Rogue", class_id: 4, level: 2, race: "Orc", race_id: 2, ..Default::default() },
	);
	assert_eq!(out[0], json!({ "up": false, "usable": false, "scored": false }));
	assert!(!out[1].to_string().contains("Polestar"), "no gear line on a tool's tooltip: {}", out[1]);
}

// #1324: Staff of Soran'ruk (+34 Fire, +34 Shadow) against Spine of the Devourer (+36 Spell Power).
#[test]
fn bonus_damage_to_several_schools_is_worth_no_more_than_its_largest_bonus_as_spell_power_soranruk_is_no_upgrade_over_spine_of_the_devourer() {
	let out = run(
		r#"
		g.equip(16, "item:9061")
		local res = {}
		for _, spec in ipairs({ "affliction", "demonology", "destruction" }) do
			Polestar.Set("gear.spec.WARLOCK", spec)
			local up, _, pct = G.IsUpgrade("item:9060")
			res[spec] = { up = up, pct = pct }
		end
		emit(res)
	"#,
		Opts { cls: "WARLOCK", class_name: "Warlock", class_id: 9, level: 30, ..Default::default() },
	);
	for spec in ["affliction", "demonology", "destruction"] {
		let r = &out[0][spec];
		assert_eq!(r["up"], false, "{spec}: {r}");
		assert!(r["pct"].as_f64().unwrap() < 0.0, "{spec}: {r}");
	}
}

#[test]
fn a_fire_mage_values_fire_and_frost_damage_together_no_higher_than_the_same_spell_power() {
	let out = run(
		r#"
		Polestar.Set("gear.spec.MAGE", "fire")
		emit({ G.ScoreItem("item:9062"), G.ScoreItem("item:9063") })
	"#,
		Opts { cls: "MAGE", class_name: "Mage", class_id: 8, level: 30, ..Default::default() },
	);
	let (schools, sp) = (out[0][0].as_f64().unwrap(), out[0][1].as_f64().unwrap());
	assert!(schools <= sp + 1e-9, "Fire 10 + Frost 10 scores {schools}, Spell Power 10 {sp}");
}

#[test]
fn a_custom_scale_with_school_weights_only_keeps_their_value_and_two_schools_count_as_the_larger_bonus() {
	let out = run(
		r#"
		local _, one = G.Scales.Import('( Pawn: v1: "Shadow": ShadowSpellDamage=1 )', "WARLOCK")
		local _, two = G.Scales.Import('( Pawn: v1: "Both": ShadowSpellDamage=1, FireSpellDamage=1 )', "WARLOCK")
		Polestar.Set("gear.spec.WARLOCK", "custom:" .. one.scale.id)
		emit({ G.ScoreItem("item:9064"), G.ScoreItem("item:9060") })
		Polestar.Set("gear.spec.WARLOCK", "custom:" .. two.scale.id)
		emit({ G.ScoreItem("item:9064"), G.ScoreItem("item:9060") })
	"#,
		Opts { cls: "WARLOCK", class_name: "Warlock", class_id: 9, level: 30, ..Default::default() },
	);
	assert_eq!(out[0], json!([20, 34]), "Shadow only: +20 Shadow is 20, +34 Fire +34 Shadow is 34");
	assert_eq!(out[1], json!([20, 34]), "Shadow and Fire: the two bonuses count as the larger one");
}

#[test]
fn item_data_arriving_redoes_the_answers_built_from_that_item_and_no_others() {
	let out = run(
		r#"
		g.equip(1, "item:9001")
		-- Not in the ItemDB: the client's stats only, not loaded yet.
		g.defineItem("item:8001", { equipLoc = "INVTYPE_HEAD", classID = 4, subclassID = 3, minLevel = 20, cached = false })
		local fires = {}
		Polestar.On("GEAR_UPDATED", function(what) fires[#fires + 1] = what end)
		emit(G.CompareToEquipped("item:8001") == nil)
		-- Another item's data (a chat link, a vendor page): no answer used it.
		stub.fire("GET_ITEM_INFO_RECEIVED", 7777, true)
		emit(#fires)
		-- Its own data arrives: the answer is built again from it.
		g.defineItem("item:8001", { equipLoc = "INVTYPE_HEAD", classID = 4, subclassID = 3, minLevel = 20,
			stats = { ITEM_MOD_STRENGTH_SHORT = 20, ITEM_MOD_STAMINA_SHORT = 10, RESISTANCE0_NAME = 200 } })
		stub.fire("GET_ITEM_INFO_RECEIVED", 8001, true)
		emit(fires)
		local r = G.CompareToEquipped("item:8001")
		emit(r ~= nil and r.delta ~= nil and r.delta > 0)
		-- After that wipe, an unrelated arrival is still nothing.
		stub.fire("GET_ITEM_INFO_RECEIVED", 7778, true)
		emit(#fires)
	"#,
		Opts::default(),
	);
	assert_eq!(out[0], true, "no stats yet: no answer");
	assert_eq!(out[1], 0, "another item's data changes no answer, so nothing is redone");
	assert_eq!(out[2], json!(["items"]), "the item's own data wipes the answers built from it");
	assert_eq!(out[3], true, "and the answer reads the new stats");
	assert_eq!(out[4], 1);
}
