//! Polestar.Gear upgrade advice (addon/Polestar/Gear): the tooltip upgrade line's decisions (usable or not,
//! two-hand vs one-hand, rings and trinkets against the weaker one, unique items, empty slots), the reward pick
//! on quest choices and its tooltip line, racials, every spec's shipped weights, laziness (no ItemDB load at
//! login) and the cost of one tooltip show.

use forge_addontest::{emitted, fake_locale, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

// Items in the generated ItemDB format (forge-data gear/leveling.rs encode, `forge data itemdb`).
const ITEMS: &str = r#"{
	[9101] = "1 25 20 2 4 3 str10 sta6 armor180",
	[9102] = "1 25 20 2 4 1 int10 spi6 armor40",
	[9103] = "1 25 20 2 4 3 str10 sta6 armor180",
	[9105] = "5 26 20 2 4 4 str12 sta8 armor400",
	[9106] = "13 25 20 2 2 4 str5 dmin20 dmax30 speed2000",
	[9107] = "13 25 20 2 2 0 str5 dmin20 dmax30 speed2000",
	[9110] = "17 25 20 2 2 1 str12 dmin50 dmax70 speed3300",
	[9111] = "14 25 20 2 4 6 sta4 armor600",
	[9120] = "11 25 20 2 4 0 str4",
	[9121] = "11 25 20 2 4 0 str8",
	[9122] = "11 25 20 2 4 0 str2",
	[9123] = "11 25 20 3 4 0 str6 uniq1",
	[9130] = "12 25 20 2 4 0 ap20",
	[9131] = "12 25 20 2 4 0 ap40",
	[9140] = "13 25 20 2 2 15 agi3 dmin10 dmax18 speed1700",
	[9150] = "1 25 20 2 4 1 int10 spi6 armor40 cls128",
	[9160] = "15 25 20 2 2 2 agi3 dmin20 dmax30 speed2000",
	[9161] = "13 25 0 1 2 14 dmin1 dmax2 speed2000",
	[9162] = "21 25 20 2 2 15 agi3 dmin10 dmax18 speed1700",
	[9163] = "22 25 20 2 2 15 agi3 dmin10 dmax18 speed1700",
}"#;

const LEVELING: &str = r#"{
	names = { [9101] = "Militia Helm", [9102] = "Scholar Cap", [9103] = "Twin Helm", [9110] = "Hunter Axe", [9140] = "Hunter Dagger" },
	src = { [9101] = "q5001", [9102] = "q5001", [9103] = "q5001", [9110] = "q5002", [9140] = "q5002" },
	quests = { [5001] = "20 15 1 12 0 0 0|9101,9102,9103||Alliance Choice", [5002] = "20 15 2 12 0 0 0|9110,9140||Hunter Choice" },
	npcs = {}, zones = { [12] = "Elwynn Forest" },
}"#;

const LINE: &str = r#"local function line(link) for _, l in ipairs(g.showTooltip(GameTooltip, link)) do if l:find("^Polestar") then return l end end return false end"#;

struct Opts {
	cls: &'static str,
	class_name: &'static str,
	class_id: i32,
	level: i32,
	race: &'static str,
	race_id: i32,
	faction: &'static str,
	register: bool,
	locale: String,
}

impl Default for Opts {
	fn default() -> Self {
		Opts { cls: "WARRIOR", class_name: "Warrior", class_id: 1, level: 22, race: "Troll", race_id: 8, faction: "Horde", register: true, locale: String::new() }
	}
}

fn run_with(script: &str, o: Opts) -> Vec<Value> {
	let before = format!(
		"w = stub.world; g = stub.gear\nw.class, w.className, w.classID, w.level = \"{}\", \"{}\", {}, {}\nw.race, w.raceName, w.raceID, w.faction = \"{}\", \"{}\", {}, \"{}\"\n{}",
		o.cls, o.class_name, o.class_id, o.level, o.race, o.race, o.race_id, o.faction, o.locale
	);
	let register = if o.register {
		[r#"Polestar.ItemDB.Register({ schema = 1, build = "test" }, "#, ITEMS, ")\n", r#"Polestar.ItemDB.RegisterLeveling({ source = "test" }, "#, LEVELING, ")"].concat()
	} else {
		String::new()
	};
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before,
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Gear.xml"])],
		login: true,
		script: format!("G = Polestar.Gear\n{register}\nG.RefreshPlayer()\n{LINE}\n{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, Opts::default())
}

fn mage() -> Opts {
	Opts { cls: "MAGE", class_name: "Mage", class_id: 8, ..Default::default() }
}

#[test]
fn every_spec_an_item_of_its_best_stats_outscores_one_of_its_worst_at_10_30_and_60_with_the_shipped_weights() {
	let out = run(r#"
		local res = {}
		local P = { "str", "agi", "int", "spi" }
		for class, meta in pairs(G.CLASSES) do
			for _, spec in ipairs(meta.specs) do
				for _, level in ipairs({ 10, 30, 60 }) do
					local w = G.WeightsFor(class, spec.key, level)
					local s = { unpack(P) }
					table.sort(s, function(a, b) return (w[a] or 0) > (w[b] or 0) end)
					local up = { inv = 16, class = 4, subclass = 1, stats = { [s[1]] = 10, [s[2]] = 6 } }
					local down = { inv = 16, class = 4, subclass = 1, stats = { [s[4]] = 10, [s[3]] = 6 } }
					res[#res + 1] = { class .. "." .. spec.key .. "@" .. level, G.ScoreWith(up, w, false) > G.ScoreWith(down, w, false) }
				end
			end
		end
		emit(res)
	"#);
	let out = out[0].as_array().unwrap();
	assert_eq!(out.len(), 27 * 3);
	for e in out {
		assert!(truthy(&e[1]), "{}", text(&e[0]));
	}
}

#[test]
fn upgrade_line_unusable_items_say_why_class_restricted_the_downgrade_in_red_equipped_items_get_no_line() {
	let mail = run(r#"
		g.equip(1, "item:9101")
		emit(line("item:9101"))
	"#)
	.remove(0);
	let mage_line = run_with(r#"emit(line("item:9101"))"#, mage()).remove(0);
	let cls_only = run(r#"emit(line("item:9150"))"#).remove(0);
	let worn = run(r#"g.equip(1, "item:9101"); emit(line("item:9101"))"#).remove(0);
	assert_eq!(mail, false, "the worn helm itself");
	assert_eq!(mage_line, "Polestar | armor you cannot wear");
	assert_eq!(cls_only, "Polestar | not for your class");
	assert_eq!(worn, false);
}

#[test]
fn upgrade_line_why_an_item_is_unusable_is_in_the_client_language() {
	let es = fake_locale("itIT", &[("armor you cannot wear", "armadura que no puedes llevar"), ("not for your class", "no es para tu clase")]);
	let mage_line = run_with(r#"emit(line("item:9101"))"#, Opts { locale: es.clone(), ..mage() }).remove(0);
	let cls = run_with(r#"emit(line("item:9150"))"#, Opts { locale: es, ..Default::default() }).remove(0);
	assert_eq!(mage_line, "Polestar | armadura que no puedes llevar");
	assert_eq!(cls, "Polestar | no es para tu clase");
}

#[test]
fn two_hand_vs_one_hand_a_two_hander_against_main_off_hand_a_one_hander_against_a_worn_two_hander_pairs_with_the_best_bag_off_hand() {
	let out = run(r#"
		g.equip(16, "item:9106"); g.equip(17, "item:9111")
		emit(line("item:9110"))
		g.equip(17, nil); g.equip(16, "item:9110"); g.bag(0, 1, "item:9111")
		emit(line("item:9107"))
		emit(MAINHANDSLOT)
	"#);
	let (two_hand, one_hand, main_hand) = (text(&out[0]), text(&out[1]), text(&out[2]));
	// The slot is the client's word for it (MAINHANDSLOT).
	assert!(is_match(two_hand, r"^Polestar \| \+[\d.]+% upgrade · "));
	assert!(two_hand.ends_with(&format!(" · {main_hand}")), "{two_hand}");
	assert!(is_match(one_hand, r"^Polestar \| -[\d.]+% downgrade · "));
	assert!(one_hand.ends_with(&format!(" · {main_hand}")), "{one_hand}");
}

#[test]
fn rings_and_trinkets_against_the_weaker_equipped_one_a_unique_ring_only_against_its_own_copy_an_empty_slot_first() {
	let out = run(r#"
		g.equip(11, "item:9120"); g.equip(12, "item:9121")
		emit(line("item:9122"))
		emit(line("item:9123"))
		g.equip(13, "item:9130"); g.equip(14, "item:9130")
		emit(line("item:9131"))
		g.equip(14, nil)
		emit(line("item:9131"))
	"#);
	// 9122 (str 2) against the weaker ring 9120 (str 4): -50%
	assert_eq!(out[0], "Polestar | -50% downgrade · Finger");
	assert_eq!(out[1], "Polestar | +50% upgrade · Finger");
	assert_eq!(out[2], "Polestar | big upgrade · Trinket");
	assert_eq!(out[3], "Polestar | upgrade (empty slot)");
}

#[test]
fn reward_picks_a_known_upgrade_above_a_known_downgrade_the_same_in_any_order_ties_to_the_lower_item_id_nothing_better_still_names_the_best() {
	let out = run(r#"
		g.equip(1, "item:9102")
		local function pick(links) local list, p, best = G.RankChoices(links); return { list[p].id, best and list[best].id or false } end
		emit(pick({ "item:9102", "item:9103", "item:9101" }))
		emit(pick({ "item:9101", "item:9102", "item:9103" }))
		emit(pick({ "item:9103", "item:9101", "item:9102" }))
		g.equip(1, "item:9105")
		G.Invalidate("equipment")
		local p = G.QuestPick(5001)
		emit({ p.entry.id, p.upgrade })
	"#);
	assert_eq!(out[0], json!([9101, 9101]));
	assert_eq!(out[1], out[0]);
	assert_eq!(out[2], out[0]);
	assert_eq!(out[3], json!([9101, false]));
}

#[test]
fn reward_item_tooltips_best_pick_on_an_upgrade_pick_reward_pick_naming_it_on_the_others_nothing_when_no_choice_is_an_upgrade_off_with_gear_picktooltip() {
	let out = run(r#"
		g.equip(1, "item:9102")
		emit(g.showTooltip(GameTooltip, "item:9101"))
		emit(g.showTooltip(GameTooltip, "item:9103"))
		g.equip(1, "item:9105")
		G.Invalidate("equipment")
		emit(g.showTooltip(GameTooltip, "item:9101"))
		g.equip(1, "item:9102")
		G.Invalidate("equipment")
		Polestar.Set("gear.pickTooltip", false)
		emit(g.showTooltip(GameTooltip, "item:9101"))
	"#);
	let (best, other, none, off) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(best[1], "Best pick | Alliance Choice");
	assert_eq!(other[1], "Reward pick | Militia Helm");
	// No upgrade: the reward panel's coin (the most valuable) decides, not Gear.
	assert!(!none.as_array().unwrap().iter().any(|l| is_match(text(l), r"^(Best|Reward) pick")), "{}", none);
	// The upgrade line, then the weights it was scored with: no pick line.
	assert_eq!(off.as_array().unwrap().len(), 2, "{}", off);
	// The weights' line closes every tooltip with an upgrade line or a pick.
	for lines in [best, other, none, off] {
		assert_eq!(lines.as_array().unwrap().last().map(text), Some("Scored for Arms until you spend talent points"), "{}", lines);
	}
}

fn hunter() -> Opts {
	Opts { cls: "HUNTER", class_name: "Hunter", class_id: 3, ..Default::default() }
}

const STATS: &str = "Your ranged damage uses this weapon's stats, not its damage";

fn stats_lines(lines: &Value) -> usize {
	lines.as_array().map_or(0, |l| l.iter().filter(|l| text(l) == STATS).count())
}

// #2229: a Hunter's melee weapon counts for its stats, said once, right under Polestar's score line, on a quest
// reward choice (Hidden Enemies' staff).
#[test]
fn a_hunters_melee_reward_choice_says_once_under_the_score_line_that_its_stats_count_not_its_damage() {
	let out = run_with(
		r#"
		emit(g.showTooltip(GameTooltip, "item:9140"))
		emit(g.showTooltip(GameTooltip, "item:9110"))
		Polestar.Set("gear.pickTooltip", false)
		emit(g.showTooltip(GameTooltip, "item:9140")) -- no pick line, skill unknown: nothing to explain
		Polestar.Set("gear.pickTooltip", true); Polestar.Set("gear.tooltip", false)
		emit(g.showTooltip(GameTooltip, "item:9140")) -- no score line to sit under
	"#,
		hunter(),
	);
	for lines in &out[..2] {
		let l = lines.as_array().unwrap();
		assert!(text(&l[0]).starts_with("Polestar | "), "{lines}");
		assert_eq!(text(&l[1]), STATS, "{lines}");
		assert_eq!(stats_lines(lines), 1, "{lines}");
		assert!(l.iter().any(|l| is_match(text(l), r"^(Best|Reward) pick \| ")), "{lines}");
	}
	assert_eq!(stats_lines(&out[2]), 0, "{}", out[2]);
	assert_eq!(stats_lines(&out[3]), 0, "{}", out[3]);
}

// Off the reward window: only a weapon whose skill is under half its cap, the case the report met (a staff at
// skill 1), in every melee slot; the scores and the reward pick do not change with the rank.
#[test]
fn a_hunters_melee_weapon_says_it_while_its_skill_is_under_half_its_cap_whatever_the_rank_the_score_stays() {
	let out = run_with(
		r#"
		Polestar.Set("gear.pickTooltip", false)
		for _, rank in ipairs({ 1, 54, 55, 110 }) do
			w.learnSkill(173, "Daggers", rank, 110); w.learnSkill(172, "Two-Handed Axes", rank, 110)
			local lines = {}
			for _, id in ipairs({ 9140, 9110, 9162, 9163 }) do lines[#lines + 1] = g.showTooltip(GameTooltip, "item:" .. id) end
			emit({ lines = lines, score = G.ScoreItem("item:9140"), pick = G.QuestPick(5002).entry.id })
		end
	"#,
		hunter(),
	);
	for (i, shown) in [(0, true), (1, true), (2, false), (3, false)] {
		for lines in out[i]["lines"].as_array().unwrap() {
			assert_eq!(stats_lines(lines), usize::from(shown), "rank case {i}: {lines}");
			if shown {
				assert_eq!(text(&lines[1]), STATS, "{lines}");
			}
		}
		assert_eq!(out[i]["score"], out[0]["score"]);
		assert_eq!(out[i]["pick"], 9110);
	}
}

#[test]
fn the_hunter_stats_line_is_not_for_other_classes_ranged_or_untrained_weapons_tools_or_forever_leveling_bis_scores() {
	let out = run_with(
		r#"
		for _, id in ipairs({ 9160, 9161 }) do emit(g.showTooltip(GameTooltip, "item:" .. id)) end
		G.UsesFLB = function(min) return min == 2 end
		emit(g.showTooltip(GameTooltip, "item:9140"))
		G.UsesFLB = function() return false end
		w.learnSkill(45, "Bows", 1, 110) -- skills readable, Daggers not trained
		emit(g.showTooltip(GameTooltip, "item:9140"))
	"#,
		hunter(),
	);
	for lines in &out {
		assert_eq!(stats_lines(lines), 0, "{lines}");
	}
	assert!(text(&out[3][0]).ends_with("| weapon skill not trained"), "{}", out[3]);
	let warrior = run(r#"w.learnSkill(173, "Daggers", 1, 110); emit(g.showTooltip(GameTooltip, "item:9162"))"#);
	assert_eq!(stats_lines(&warrior[0]), 0, "{}", warrior[0]);
}

#[test]
fn the_hunter_stats_line_is_in_the_clients_language() {
	let locale = fake_locale("itIT", &[(STATS, "il danno a distanza usa le statistiche dell'arma, non il suo danno")]);
	let out = run_with(r#"emit(g.showTooltip(GameTooltip, "item:9140"))"#, Opts { locale, ..hunter() });
	assert_eq!(text(&out[0][1]), "il danno a distanza usa le statistiche dell'arma, non il suo danno", "{}", out[0]);
}

#[test]
fn racials_mace_specialization_makes_a_dwarf_shaman_a_forever_pair_prefer_the_mace_an_orc_the_axe() {
	const R: &str = r#"G.RACIALS[3] = { weaponCrit = { pct = 1, subclasses = { [4] = true, [5] = true } } }
		G.RACIALS[2] = { weaponCrit = { pct = 1, subclasses = { [0] = true, [1] = true } } }
		G.RefreshPlayer()"#;
	let dwarf = run_with(
		&format!(r#"{R}; emit(G.ScoreItem("item:9106") > G.ScoreItem("item:9107"))"#),
		Opts { cls: "SHAMAN", class_name: "Shaman", class_id: 7, race: "Dwarf", race_id: 3, faction: "Alliance", ..Default::default() },
	)
	.remove(0);
	let orc = run_with(
		&format!(r#"{R}; emit(G.ScoreItem("item:9107") > G.ScoreItem("item:9106"))"#),
		Opts { cls: "SHAMAN", class_name: "Shaman", class_id: 7, race: "Orc", race_id: 2, ..Default::default() },
	)
	.remove(0);
	assert_eq!(dwarf, true);
	assert_eq!(orc, true);
}

#[test]
fn lazy_login_loads_no_item_data_and_reads_no_bags_the_first_tooltip_loads_polestar_itemdb_once() {
	let out = run_with(
		r#"
		local calls, bagReads = 0, 0
		C_AddOns.LoadAddOn = function(name) calls = calls + 1; return true end
		local slots = C_Container.GetContainerItemLink
		C_Container.GetContainerItemLink = function(...) bagReads = bagReads + 1; return slots(...) end
		stub.login()
		local atLogin = { calls, bagReads, Polestar.ItemDB.IsLoaded() }
		g.showTooltip(GameTooltip, "item:9101")
		emit({ atLogin = atLogin, after = calls })
	"#,
		Opts { register: false, ..Default::default() },
	)
	.remove(0);
	assert_eq!(out["atLogin"], json!([0, 0, false]));
	assert_eq!(out["after"], 1);
}

#[test]
fn cost_a_tooltip_show_stays_under_1_ms_cold_and_cached_per_item_spec_and_level() {
	let t = run(r#"
		g.equip(1, "item:9102"); g.equip(11, "item:9120"); g.equip(12, "item:9121"); g.equip(16, "item:9106"); g.equip(17, "item:9111")
		local items = { "item:9101", "item:9103", "item:9105", "item:9110", "item:9122", "item:9123", "item:9131", "item:9140" }
		local clock = os.clock
		local n, t0 = 0, clock()
		for round = 1, 50 do
			G.Invalidate("equipment") -- every show cold: no cached answer
			for _, link in ipairs(items) do g.showTooltip(GameTooltip, link); n = n + 1 end
		end
		local cold = (clock() - t0) / n * 1000
		n, t0 = 0, clock()
		for round = 1, 200 do
			for _, link in ipairs(items) do g.showTooltip(GameTooltip, link); n = n + 1 end
		end
		local warm = (clock() - t0) / n * 1000
		emit({ cold = cold, warm = warm })
	"#)
	.remove(0);
	let cold = t["cold"].as_f64().unwrap();
	let warm = t["warm"].as_f64().unwrap();
	println!("tooltip show: {cold:.4} ms cold, {warm:.4} ms cached");
	assert!(cold < 1.0, "cold {cold} ms");
	assert!(warm < 1.0, "cached {warm} ms");
}
