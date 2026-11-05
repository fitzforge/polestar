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
	let out = run(
		r#"
		local seen = {}
		Polestar.RegisterOptions = function(def) seen[#seen + 1] = def end
		stub.login()
		local out = {}
		for _, def in ipairs(seen) do
			local keys = {}
			for _, c in ipairs(def.controls) do keys[#keys + 1] = (c.key or c.label) .. "=" .. c.kind .. ":" .. (c.help and "help" or "nohelp") end
			out[#out + 1] = { page = def.page, section = def.section, keys = keys,
				choices = def.controls[2].choices and #def.controls[2].choices() or 0 }
		end
		emit(out)
	"#,
		Opts { login: false, ..Default::default() },
	);
	let defs = out[0].as_array().unwrap();
	assert_eq!(defs.len(), 2);
	assert!(defs.iter().all(|d| d["page"] == "Questing"));
	assert_eq!(
		defs[0]["keys"],
		json!([
			"gear.enabled=toggle:help",
			"gear.spec.WARRIOR=dropdown:help",
			"Manage custom weights=button:help",
			"gear.tooltip=toggle:help",
			"gear.bagArrows=toggle:help",
			"gear.hideForPawn=toggle:help",
			"gear.rewards=toggle:help",
			"gear.pickTooltip=toggle:help"
		])
	);
	assert_eq!(defs[0]["choices"], 4); // Automatic + three warrior specs
	assert_eq!(defs[1]["keys"], json!(["gear.minUpgrade=slider:help", "gear.useBags=toggle:help"]));
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
