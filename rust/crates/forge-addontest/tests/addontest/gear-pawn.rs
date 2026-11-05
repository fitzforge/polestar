//! Pawn scale import (addon/Polestar/Gear/Pawn.lua, PawnStats.lua): the string parser, the stat mapping, the
//! saved scales and how a chosen scale scores.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FIXTURE: &str = r#"{
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
}"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: r#"w = stub.world; g = stub.gear
w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30
w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde""#
			.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Gear.xml"])],
		login: true,
		script: ["G = Polestar.Gear\nPolestar.ItemDB.Register({ schema = 1, build = \"test\" }, ", FIXTURE, ")\n", script].concat(),
		..Default::default()
	})
}

// The parser's result for one string: { name, stats, order, meta, skipped } or { err }.
fn parse(s: &str) -> Value {
	let script = [
		"\n\t\tlocal p, err = G.Pawn.Parse(",
		&serde_json::to_string(s).unwrap(),
		r#")
		if not p then emit({ err = err }) else emit({ name = p.name or false, stats = p.stats, order = p.order, meta = p.meta, skipped = p.skipped }) end
	"#,
	]
	.concat();
	run(&script).remove(0)
}

#[test]
fn parses_a_standard_string_name_metadata_apart_from_stats() {
	let r = parse(r#"( Pawn: v1: "Warrior: Arms": Class=Warrior, Spec=1, Strength=2.0, Agility=1.1, Stamina=0.5 )"#);
	assert_eq!(r["name"], "Warrior: Arms");
	assert_eq!(r["stats"], json!({ "Strength": 2, "Agility": 1.1, "Stamina": 0.5 }));
	assert_eq!(r["order"], json!(["Strength", "Agility", "Stamina"]));
	assert_eq!(r["meta"], json!({ "Class": "Warrior", "Spec": 1 }));
}

#[test]
fn tolerates_spaces_no_parentheses_no_version_single_quotes_case() {
	for s in [
		r#"(Pawn:v1:"X":Strength=1,Agility=2)"#,
		r#"  (  pawn :  V1 :  "X"  :  Strength = 1 ,  Agility =  2  )  "#,
		r#"Pawn: v1: "X": Strength=1, Agility=2"#,
		r#"( Pawn: "X": Strength=1, Agility=2 )"#,
		"( Pawn: v1: 'X': Strength=1, Agility=2 )",
	] {
		let r = parse(s);
		assert_eq!(r["name"], "X", "{s}");
		assert_eq!(r["stats"], json!({ "Strength": 1, "Agility": 2 }), "{s}");
	}
}

#[test]
fn numbers_1_1_5_5_1_negatives_and_a_plus_sign() {
	let r = parse(r#"( Pawn: v1: "N": A=1, B=1.5, C=.5, D=-2, E=-.25, F=+3, G=1. , H=0 )"#);
	assert_eq!(r["stats"], json!({ "A": 1, "B": 1.5, "C": 0.5, "D": -2, "E": -0.25, "F": 3, "G": 1, "H": 0 }));
}

#[test]
fn a_missing_name_parses_with_none_hex_and_words_are_not_numbers() {
	let r = parse("( Pawn: v1: Strength=1 )");
	assert_eq!(r["name"], false);
	assert_eq!(r["stats"], json!({ "Strength": 1 }));
	let r = parse(r#"( Pawn: v1: "N": Strength=0x10, Agility=two, Stamina=1 )"#);
	assert_eq!(r["stats"], json!({ "Stamina": 1 }));
	assert_eq!(r["meta"]["Strength"], "0x10");
}

#[test]
fn a_number_so_long_it_reads_as_infinity_is_no_weight_in_a_string_or_typed_in_the_details() {
	let big = "9".repeat(400);
	let r = parse(&format!(r#"( Pawn: v1: "N": Strength={big}, Agility=-{big}, Stamina=1 )"#));
	assert_eq!(r["stats"], json!({ "Stamina": 1 }));
	let out = run(&r#"
		local _, res = G.Scales.Import('( Pawn: v1: "T": Class=Warrior, Strength=2 )')
		local ok, err = G.Scales.SetWeight("WARRIOR", res.scale.id, "str", "BIG")
		local okInf, errInf = G.Scales.SetWeight("WARRIOR", res.scale.id, "str", math.huge)
		local okNan = G.Scales.SetWeight("WARRIOR", res.scale.id, "str", 0 / 0)
		emit({ ok = ok, err = err, okInf = okInf, errInf = errInf, okNan = okNan, str = res.scale.weights.str, number = G.Pawn.Number("BIG") or false })
	"#
	.replace("BIG", &big));
	assert_eq!(out[0], json!({ "ok": false, "err": "number", "okInf": false, "errInf": "number", "okNan": false, "str": 2, "number": false }));
}

#[test]
fn pawn_s_x_marker_skips_a_stat_a_repeated_key_keeps_its_last_value() {
	let r = parse(r#"( Pawn: v1: "N": Strength=1, Agility=X, Strength=3 )"#);
	assert_eq!(r["stats"], json!({ "Strength": 3 }));
	assert_eq!(r["skipped"], json!(["Agility"]));
	assert_eq!(r["order"], json!(["Strength"]));
}

#[test]
fn refuses_garbage_empty_text_a_newer_version_a_string_with_no_stats() {
	assert_eq!(parse("")["err"], "empty");
	assert_eq!(parse("   ")["err"], "empty");
	assert_eq!(parse("Strength=1, Agility=2")["err"], "notpawn");
	assert_eq!(parse("hello world")["err"], "notpawn");
	assert_eq!(parse(r#"( Pawn: v2: "N": Strength=1 )"#)["err"], "version");
	assert_eq!(parse(r#"( Pawn: v1: "N": Class=Warrior )"#)["err"], "nostats");
	assert_eq!(parse(r#"( Pawn: v1: "N": )"#)["err"], "nostats");
	assert_eq!(parse(&format!(r#"( Pawn: v1: "N": {} )"#, "Strength=1,".repeat(1000)))["err"], "toolong");
}

#[test]
fn a_long_paste_of_mostly_spaces_is_refused_at_once_not_after_seconds_of_trimming() {
	let out = run(r#"
		local t0 = os.clock()
		local _, long = G.Pawn.Parse("x" .. string.rep(" ", 100000) .. "x")
		local _, gap = G.Pawn.Parse("( Pawn: v1: Strength=1" .. string.rep(" ", 5900) .. ", Agility=2 )")
		emit({ long = long, gap = gap or false, secs = os.clock() - t0 })
	"#);
	let r = &out[0];
	assert_eq!(r["long"], "toolong");
	assert_eq!(r["gap"], false);
	assert!(r["secs"].as_f64().unwrap() < 0.2, "took {}s", r["secs"]);
}

fn weights(s: &str) -> Value {
	let script = [
		"\n\t\tlocal p = G.Pawn.Parse(",
		&serde_json::to_string(s).unwrap(),
		r#")
		local w, mapped, ignored = G.Pawn.Weights(p)
		emit({ w = w, mapped = mapped, ignored = ignored })
	"#,
	]
	.concat();
	run(&script).remove(0)
}

#[test]
fn stat_mapping_names_to_polestar_keys_case_insensitive() {
	let r = weights(concat!(
		r#"( Pawn: v1: "N": strength=1, AGILITY=2, Stamina=3, Intellect=4, Spirit=5, Armor=6, Health=7, Mana=8, Hp5=9, Mp5=10, Ap=11, Rap=12, "#,
		"SpellDamage=13, ArcaneSpellDamage=14, FireSpellDamage=15, FrostSpellDamage=16, HolySpellDamage=17, NatureSpellDamage=18, ShadowSpellDamage=19, Healing=20, ",
		"CritRating=21, HitRating=22, SpellCritRating=23, SpellHitRating=24, DefenseRating=25, DodgeRating=26, ParryRating=27, BlockRating=28, BlockValue=29 )"
	));
	assert_eq!(
		r["w"],
		json!({
			"str": 1, "agi": 2, "sta": 3, "int": 4, "spi": 5, "armor": 6, "health": 7, "mana": 8, "hp5": 9, "mp5": 10, "ap": 11, "rap": 12,
			"sp": 13, "spArcane": 14, "spFire": 15, "spFrost": 16, "spHoly": 17, "spNature": 18, "spShadow": 19, "heal": 20,
			"crit": 21, "hit": 22, "spellCrit": 23, "spellHit": 24, "defense": 25, "dodge": 26, "parry": 27, "block": 28, "blockValue": 29,
		})
	);
	assert_eq!(r["mapped"], 29);
	let n = match &r["ignored"] {
		Value::Array(a) => a.len(),
		Value::Object(o) => o.len(),
		other => panic!("ignored is {other}"),
	};
	assert_eq!(n, 0);
}

#[test]
fn dps_covers_both_weapon_slots_until_meleedps_or_rangeddps_say_otherwise() {
	assert_eq!(weights(r#"( Pawn: v1: "N": Dps=5 )"#)["w"], json!({ "dps": 5, "rdps": 5 }));
	assert_eq!(weights(r#"( Pawn: v1: "N": Dps=5, RangedDps=1 )"#)["w"], json!({ "dps": 5, "rdps": 1 }));
	assert_eq!(weights(r#"( Pawn: v1: "N": RangedDps=1, MeleeDps=7, Dps=5 )"#)["w"], json!({ "dps": 7, "rdps": 1 }));
}

#[test]
fn unmapped_pawn_stats_are_ignored_and_named_in_order() {
	let r = weights(r#"( Pawn: v1: "N": Strength=1, FireResist=2, Speed=3, IsMace=1, HasteRating=4, Agility=X, FeralAp=1 )"#);
	assert_eq!(r["w"], json!({ "str": 1 }));
	assert_eq!(r["mapped"], 1);
	assert_eq!(r["ignored"], json!(["FireResist", "Speed", "IsMace", "HasteRating", "FeralAp", "Agility"]));
}

#[test]
fn import_stores_a_scale_per_class_the_same_name_updates_it() {
	let out = run(r#"
		local ok, res = G.Scales.Import('( Pawn: v1: "Tank": Class=Warrior, Strength=2, Resist=1 )')
		emit({ ok = ok, name = res.scale.name, class = res.class, mapped = res.mapped, ignored = res.ignored, updated = res.updated, summary = G.Scales.Summary(res), id = res.scale.id })
		local ok2, res2 = G.Scales.Import('( Pawn: v1: "tank": Strength=3 )', "WARRIOR")
		emit({ ok = ok2, updated = res2.updated, id = res2.scale.id, str = res2.scale.weights.str })
		emit(#G.Scales.List("WARRIOR"))
		emit(#G.Scales.List("MAGE"))
	"#);
	let (first, second, list, other) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(first["ok"], true);
	assert_eq!(first["name"], "Tank");
	assert_eq!(first["class"], "WARRIOR");
	assert_eq!(first["mapped"], 1);
	assert_eq!(first["ignored"], json!(["Resist"]));
	assert_eq!(first["updated"], false);
	assert_eq!(first["summary"], "Imported 'Tank': 1 stats, 1 ignored: Resist");
	assert_eq!(*second, json!({ "ok": true, "updated": true, "id": first["id"].clone(), "str": 3 }));
	assert_eq!(*list, 1);
	assert_eq!(*other, 0);
}

#[test]
fn a_string_naming_another_class_is_kept_for_that_class_unknown_classes_and_numeric_ids() {
	let out = run(r#"
		local _, a = G.Scales.Import('( Pawn: v1: "Frost": Class=Mage, SpellDamage=1 )')
		emit(a.class)
		emit({ G.Scales.Import('( Pawn: v1: "K": Class=DeathKnight, Strength=1 )') })
		local _, c = G.Scales.Import('( Pawn: v1: "P": Class=2, Strength=1 )')
		emit(c.class)
	"#);
	assert_eq!(out[0], "MAGE");
	assert_eq!(out[1], json!([false, "class"]));
	assert_eq!(out[2], "PALADIN");
}

#[test]
fn a_string_with_no_name_gets_a_numbered_default_errors_come_back_as_text() {
	let out = run(r#"
		local _, x = G.Scales.Import('( Pawn: v1: Strength=1 )', "WARRIOR")
		local _, y = G.Scales.Import('( Pawn: v1: Strength=2 )', "WARRIOR")
		emit(x.scale.name); emit(y.scale.name)
		emit(G.Scales.ErrorText("notpawn"))
	"#);
	assert_eq!(out[0], "Pawn scale");
	assert_eq!(out[1], "Pawn scale 2");
	assert!(is_match(text(&out[2]), r"not a Pawn string"));
}

#[test]
fn names_lose_chat_escapes_and_are_cut_rename_refuses_empty_and_taken_names() {
	let out = run(&r#"
		local _, x = G.Scales.Import('( Pawn: v1: "|cffff0000Red|r XS60": Strength=1 )', "WARRIOR")
		local _, y = G.Scales.Import('( Pawn: v1: "Other": Strength=1 )', "WARRIOR")
		emit(x.scale.name)
		emit({ G.Scales.Rename("WARRIOR", x.scale.id, "  ") })
		emit({ G.Scales.Rename("WARRIOR", x.scale.id, "other") })
		emit({ G.Scales.Rename("WARRIOR", x.scale.id, "Fresh") })
		emit(G.Scales.Get("WARRIOR", x.scale.id).name)
		emit({ G.Scales.Rename("WARRIOR", "nope", "Z") })
	"#
	.replace("XS60", &"x".repeat(60)));
	let name = text(&out[0]);
	assert!(name.chars().count() <= 40);
	assert!(!name.contains('|'));
	assert_eq!(out[1], json!([false, "name"]));
	assert_eq!(out[2], json!([false, "taken"]));
	assert_eq!(out[3], json!([true]));
	assert_eq!(out[4], "Fresh");
	assert_eq!(out[5], json!([false, "gone"]));
}

#[test]
fn export_returns_the_string_as_imported_a_class_holds_at_most_20_scales() {
	let out = run(r#"
		local s = '( Pawn: v1: "E": Strength=1 )'
		local _, r = G.Scales.Import(s, "WARRIOR")
		emit(G.Scales.Export("WARRIOR", r.scale.id) == s)
		local last
		for i = 1, 25 do last = { G.Scales.Import('( Pawn: v1: "S' .. i .. '": Strength=1 )', "WARRIOR") } end
		emit({ last[1], last[2], #G.Scales.List("WARRIOR") })
	"#);
	assert_eq!(out[0], true);
	assert_eq!(out[1], json!([false, "full", 20]));
}

const HEAD: &str = r#"g.defineItem("item:9001", { equipLoc = "INVTYPE_HEAD", classID = 4, subclassID = 3, minLevel = 15, stats = { ITEM_MOD_STRENGTH_SHORT = 5, ITEM_MOD_STAMINA_SHORT = 3 } })"#;

#[test]
fn a_chosen_custom_scale_replaces_the_built_in_weights_and_reports_source_custom() {
	let out = run(&[
		"\n\t\t",
		HEAD,
		r#"
		emit({ G.GetSpec() })
		local _, r = G.Scales.Import('( Pawn: v1: "Mine": Strength=10, Stamina=1 )', "WARRIOR")
		Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
		emit({ G.GetSpec() })
		emit({ G.ScoreItem("item:9001"), G.GetWeightsInfo().source, G.GetWeights().str })
		Polestar.Set("gear.spec.WARRIOR", "arms")
		emit(G.ScoreItem("item:9001") ~= 53)
		Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
		G.Scales.Delete("WARRIOR", r.scale.id)
		emit({ G.GetSpec() })
	"#,
	]
	.concat());
	let (before, after, score, builtin, deleted) = (&out[0], &out[1], &out[2], &out[3], &out[4]);
	assert_ne!(before[2], "custom");
	assert!(text(&after[0]).starts_with("custom:"));
	assert_eq!(after[1], "Custom: Mine");
	assert_eq!(after[2], "custom");
	assert_eq!(*score, json!([53, "custom", 10]));
	assert_eq!(*builtin, true);
	assert_ne!(deleted[2], "custom", "deleting the chosen scale goes back to Automatic");
}

#[test]
fn a_scale_in_another_size_scores_in_proportion_so_upgrade_percents_match() {
	let out = run(&[
		"\n\t\t",
		HEAD,
		r#"
		local function score(str)
			local _, r = G.Scales.Import(str, "WARRIOR")
			Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
			return G.CompareToEquipped("item:9001").score
		end
		emit(score('( Pawn: v1: "A": Strength=1, Stamina=0.5 )') * 10)
		emit(score('( Pawn: v1: "B": Strength=10, Stamina=5 )'))
	"#,
	]
	.concat());
	assert_eq!(out[0].as_f64(), out[1].as_f64());
}

#[test]
fn polestar_gear_import_string_imports_for_your_class() {
	let out = run(r#"
		SlashCmdList.POLESTAR('gear import ( Pawn: v1: "Cmd": Strength=1 )')
		emit(#G.Scales.List("WARRIOR"))
	"#);
	assert_eq!(out[0], 1);
}

// The windows (UI/GearScales.lua), over the UI stub with the Gear module.
fn run_ui(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_world.lua", "stub_gear.lua"],
		before: r#"w = stub.world; w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30"#.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "UI/UI.xml"])],
		login: true,
		script: script.into(),
		..Default::default()
	})
}

#[test]
fn rename_import_and_delete_refresh_the_options_rows_so_the_dropdown_shows_the_new_name_at_once() {
	let out = run_ui(
		r#"
		local G = Polestar.Gear
		local n = 0
		local real = Polestar.Widgets.RefreshAll
		Polestar.Widgets.RefreshAll = function() n = n + 1; return real() end
		local _, r = G.Scales.Import('( Pawn: v1: "A": Strength=1 )', "WARRIOR")
		local afterImport = n
		G.Scales.Rename("WARRIOR", r.scale.id, "B")
		local afterRename = n
		G.Scales.Delete("WARRIOR", r.scale.id)
		emit({ afterImport, afterRename, n })
	"#,
	);
	assert_eq!(out[0], json!([1, 2, 3]));
}

// What the manager window's rows say, as plain data.
const ROWS: &str = r#"
local function shown()
	local out = {}
	for _, row in ipairs(Polestar.UI.ScalesView.rows) do
		if row:IsShown() then
			out[#out + 1] = { title = row.Title:GetText(), meta = row.Meta:GetText(), tag = row.Tag:GetText(),
				use = row.Use:IsShown() and row.Use.Label:GetText() or false, body = row.Body:IsShown() and row.Body:GetText() or false,
				reset = row.Reset:IsShown(), lines = {} }
			for _, line in ipairs(row.Lines) do
				if line:IsShown() then out[#out].lines[#out[#out].lines + 1] = line.Label:GetText() .. "=" .. line.Box:GetText() end
			end
		end
	end
	return out
end"#;

#[test]
fn scales_keep_the_pawn_stats_they_left_out_and_all_lists_every_class_the_player_s_first() {
	let out = run_ui(
		r#"
		local G = Polestar.Gear
		G.Scales.Import('( Pawn: v1: "M": Class=Mage, SpellDamage=1, FireResist=1 )')
		G.Scales.Import('( Pawn: v1: "Z": Class=Warrior, Strength=1 )')
		G.Scales.Import('( Pawn: v1: "A": Class=Warrior, Strength=1, Speed=2 )')
		local names = {}
		for _, e in ipairs(G.Scales.All("WARRIOR")) do names[#names + 1] = e.class .. ":" .. e.scale.name end
		emit(names)
		emit(G.Scales.All("WARRIOR")[2].scale.ignored)
	"#,
	);
	assert_eq!(out[0], json!(["WARRIOR:Z", "WARRIOR:A", "MAGE:M"]));
	assert_eq!(out[1], json!(["Speed"]), "A left Speed out");
}

#[test]
fn the_manager_window_import_chooses_the_scale_and_lists_it_a_bad_string_says_why_and_adds_nothing() {
	let out = run_ui(
		&[
			ROWS,
			r#"
		local UI, G = Polestar.UI, Polestar.Gear
		UI.ShowScales()
		local V = UI.ScalesView.frame
		V.Paste:SetText("not a pawn string")
		V.Ok:Click()
		local bad = { V.Status:GetText(), #shown() }
		V.Paste:SetText('( Pawn: v1: "Tank": Class=Warrior, Strength=2, FireResist=1 )')
		V.Ok:Click()
		emit({ bad = bad, good = V.Status:GetText(), spec = { G.GetSpec() }, box = V.Paste:GetText(), rows = shown() })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert!(is_match(text(&out["bad"][0]), r"not a Pawn string"));
	assert_eq!(out["bad"][1], 0);
	assert_eq!(out["good"], "Imported 'Tank': 1 stats, 1 ignored: FireResist");
	assert_eq!(out["spec"][2], "custom");
	assert_eq!(out["box"], "");
	assert_eq!(out["rows"].as_array().unwrap().len(), 1);
	assert_eq!(out["rows"][0]["title"], "Tank");
	assert_eq!(out["rows"][0]["tag"], "In use");
	assert_eq!(out["rows"][0]["use"], "Stop using");
}

#[test]
fn the_manager_window_lists_every_class_use_is_only_for_your_class_and_a_scale_for_another_class_can_be_deleted_from_here() {
	let out = run_ui(
		&[
			ROWS,
			r#"
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Mine": Class=Warrior, Strength=1 )')
		G.Scales.Import('( Pawn: v1: "Theirs": Class=Druid, Agility=1 )')
		UI.ShowScales()
		local before = shown()
		local rows = UI.ScalesView.rows
		-- the Druid row's Use is hidden; delete it (two clicks: the confirm)
		rows[2].Delete:Click(); rows[2].Delete:Click()
		emit({ before = before, after = shown(), druids = #G.Scales.List("DRUID") })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_eq!(out["before"].as_array().unwrap().len(), 2);
	assert_eq!(out["before"][0]["title"], "Mine");
	assert_eq!(out["before"][0]["use"], "Use");
	assert_eq!(out["before"][1]["title"], "Theirs");
	assert_eq!(out["before"][1]["use"], false);
	assert_eq!(out["druids"], 0);
	assert_eq!(out["after"].as_array().unwrap().len(), 1);
}

#[test]
fn the_manager_window_use_and_stop_using_switch_the_weights_details_shows_what_the_scale_kept_and_left_out() {
	let out = run_ui(
		&[
			ROWS,
			r#"
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Tank": Class=Warrior, Strength=2, Stamina=0.5, FireResist=1, Dps=3 )')
		UI.ShowScales()
		local row = UI.ScalesView.rows[1]
		local off = { G.GetSpec() }
		row.Use:Click()
		local on = { G.GetSpec() }
		row.Use:Click()
		local back = { G.GetSpec() }
		row.Details:Click()
		emit({ off = off[3], on = on[3], back = back[3], row = shown()[1] })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_ne!(out["off"], "custom");
	assert_eq!(out["on"], "custom");
	assert_eq!(out["back"], out["off"]);
	assert_eq!(out["row"]["lines"], json!(["Strength=2", "Stamina=0.5", "Weapon DPS (melee)=3", "Weapon DPS (ranged)=3"]));
	assert_eq!(out["row"]["body"], "Ignored: FireResist");
	assert_eq!(out["row"]["reset"], false);
}

#[test]
fn the_manager_window_rename_takes_the_name_through_the_box_refuses_an_empty_one_and_the_list_shows_it() {
	let out = run_ui(
		&[
			ROWS,
			r#"
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Old": Class=Warrior, Strength=1 )')
		UI.ShowScales()
		local V = UI.ScalesView.frame
		UI.ScalesView.rows[1].Rename:Click()
		local prefilled = V.Name:GetText()
		V.Name:SetText("")
		V.Ok:Click()
		local refused = V.Status:GetText()
		V.Name:SetText("New")
		V.Ok:Click()
		emit({ prefilled = prefilled, refused = refused, title = shown()[1].title, backToImport = V.Paste:IsShown() })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_eq!(out["prefilled"], "Old");
	assert_eq!(out["refused"], "Give the scale a name.");
	assert_eq!(out["title"], "New");
	assert_eq!(out["backToImport"], true);
}

#[test]
fn polestar_gear_import_and_gear_scales_open_the_manager() {
	let out = run_ui(
		r#"
		SlashCmdList.POLESTAR("gear scales")
		local first = PolestarScales:IsShown()
		PolestarScales:Hide()
		SlashCmdList.POLESTAR("gear import")
		emit({ first, PolestarScales:IsShown() })
	"#,
	);
	assert_eq!(out[0], json!([true, true]));
}

const OPEN: &str = r#"
local UI, G = Polestar.UI, Polestar.Gear
local _, r = G.Scales.Import('( Pawn: v1: "Tank": Class=Warrior, Strength=2, Stamina=0.5, FireResist=1 )')
Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
UI.ShowScales()
local row = UI.ScalesView.rows[1]
row.Details:Click()
local function line(name)
	for _, l in ipairs(row.Lines) do if l:IsShown() and l.Label:GetText() == name then return l end end
end
local function type_(l, text) l.Box:SetFocus(); l.Box:SetText(text); l.Box:GetScript("OnEnterPressed")(l.Box); l.Box:GetScript("OnEditFocusLost")(l.Box) end"#;

#[test]
fn editing_a_weight_in_the_details_it_applies_at_once_marks_the_scale_edited_rebuilds_the_export_string_and_offers_a_reset() {
	let out = run_ui(
		&[
			ROWS,
			OPEN,
			r#"
		type_(line("Strength"), "5")
		local w = G.GetWeights()
		emit({ str = w.str, edited = r.scale.edited, source = G.Scales.Export("WARRIOR", r.scale.id), original = r.scale.original,
			row = shown()[1] })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_eq!(out["str"], 5);
	assert_eq!(out["edited"], true);
	assert_eq!(out["source"], r#"( Pawn: v1: "Tank": Class=Warrior, Stamina=0.5, Strength=5 )"#);
	assert_eq!(out["original"], r#"( Pawn: v1: "Tank": Class=Warrior, Strength=2, Stamina=0.5, FireResist=1 )"#);
	assert_eq!(out["row"]["reset"], true);
	assert!(is_match(text(&out["row"]["body"]), r"Edited"));
	assert!(out["row"]["lines"].as_array().unwrap().contains(&json!("Strength=5")));
}

#[test]
fn editing_text_that_is_not_a_number_puts_the_old_value_back_removing_a_weight_drops_its_line_reset_returns_to_the_string_as_imported() {
	let out = run_ui(
		&[
			ROWS,
			OPEN,
			r#"
		type_(line("Strength"), "lots")
		local keptWeight, keptBox = G.GetWeights().str, line("Strength").Box:GetText()
		line("Stamina").Remove:Click()
		local staAfter, staLine = G.GetWeights().sta, line("Stamina")
		type_(line("Strength"), "9")
		local nine = G.GetWeights().str
		row.Reset:Click()
		emit({ keptWeight = keptWeight, keptBox = keptBox, staGone = staAfter == nil, lineGone = staLine == nil, nine = nine,
			str = G.GetWeights().str, sta = G.GetWeights().sta, edited = r.scale.edited or false, ignored = shown()[1].body })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_eq!(out["keptWeight"], 2);
	assert_eq!(out["keptBox"], "2");
	assert_eq!(out["staGone"], true);
	assert_eq!(out["lineGone"], true);
	assert_eq!(out["nine"], 9);
	assert_eq!(out["str"], 2, "Reset: the imported Strength");
	assert_eq!(out["sta"], 0.5, "Reset: the removed Stamina is back");
	assert_eq!(out["edited"], false);
	assert_eq!(out["ignored"], "Ignored: FireResist");
}

#[test]
fn setweight_refuses_a_stat_polestar_does_not_score_and_a_value_that_is_not_a_number_a_string_number_is_read_as_one() {
	let out = run_ui(
		r#"
		local G = Polestar.Gear
		local _, r = G.Scales.Import('( Pawn: v1: "T": Class=Warrior, Strength=2 )')
		local id = r.scale.id
		emit({ G.Scales.SetWeight("WARRIOR", id, "nonsense", 1) })
		emit({ G.Scales.SetWeight("WARRIOR", id, "str", "x") })
		emit({ G.Scales.SetWeight("WARRIOR", id, "str", " -1.5 ") })
		emit({ G.Scales.SetWeight("WARRIOR", "nope", "str", 1) })
		emit(G.Scales.Get("WARRIOR", id).weights.str)
	"#,
	);
	assert_eq!(out[0], json!([false, "stat"]));
	assert_eq!(out[1], json!([false, "number"]));
	assert_eq!(out[2], json!([true]));
	assert_eq!(out[3], json!([false, "gone"]));
	assert_eq!(out[4], -1.5);
}

#[test]
fn pawn_build_writes_a_string_parse_and_weights_read_back_to_the_same_weights() {
	let out = run(r#"
		local w = { str = 1, agi = 0.65, sta = 0.5, dps = 6.5, rdps = 0.5, crit = 11, spFire = 0.25, blockValue = 0.05 }
		local s = G.Pawn.Build('A "quoted" name', "WARRIOR", w)
		local p = G.Pawn.Parse(s)
		local back = G.Pawn.Weights(p)
		local same = true
		for k, v in pairs(w) do if back[k] ~= v then same = false end end
		emit({ s = s, same = same, name = p.name })
	"#);
	let out = &out[0];
	assert_eq!(out["same"], true);
	assert_eq!(out["name"], "A 'quoted' name");
	assert!(is_match(text(&out["s"]), r#"^\( Pawn: v1: "A 'quoted' name": Class=Warrior, "#));
}

#[test]
fn pawn_build_rounds_positive_and_negative_weights_to_the_nearest_thousandth_with_ties_away_from_zero() {
	let cases: [(f64, f64); 19] = [
		(0.0, 0.0),
		(1.0, 1.0),
		(-1.0, -1.0),
		(0.1, 0.1),
		(-0.1, -0.1),
		(1.234, 1.234),
		(-1.234, -1.234),
		(1.2344, 1.234),
		(-1.2344, -1.234),
		(1.2345, 1.235),
		(-1.2345, -1.235),
		(1.2346, 1.235),
		(-1.2346, -1.235),
		(0.0004, 0.0),
		(-0.0004, 0.0),
		(0.0005, 0.001),
		(-0.0005, -0.001),
		(0.0006, 0.001),
		(-0.0006, -0.001),
	];
	let values = cases.iter().map(|(v, _)| v.to_string()).collect::<Vec<_>>().join(", ");
	let out = run(&format!(
		r#"
		local out = {{}}
		for _, value in ipairs({{ {values} }}) do
			local source = G.Pawn.Build("Rounded", "WARRIOR", {{ str = value }})
			local parsed = assert(G.Pawn.Parse(source))
			out[#out + 1] = G.Pawn.Weights(parsed).str
		end
		emit(out)
	"#
	));
	let weights = out[0].as_array().unwrap();
	assert_eq!(weights.len(), cases.len());
	for ((value, want), got) in cases.iter().zip(weights) {
		assert_eq!(got.as_f64(), Some(*want), "weight {value}");
	}
}

#[test]
fn editing_a_scale_preserves_negative_weights_through_repeated_export_and_import() {
	let rounds = run(r#"
		local _, r = G.Scales.Import('( Pawn: v1: "Penalties": Class=Warrior, Strength=-1, Agility=-0.1, Stamina=-1.234, CritRating=0 )')
		for i = 1, 3 do
			-- Changing another stat rebuilds the whole export string.
			assert(G.Scales.SetWeight("WARRIOR", r.scale.id, "dps", i))
			local source = G.Scales.Export("WARRIOR", r.scale.id)
			local ok, imported = G.Scales.Import(source)
			assert(ok)
			r = imported
			emit(r.scale.weights)
		end
	"#);
	let want: Vec<Value> = (1..=3).map(|dps| json!({ "str": -1, "agi": -0.1, "sta": -1.234, "crit": 0, "dps": dps })).collect();
	assert_eq!(rounds, want);
}

#[test]
fn removing_a_stat_keeps_the_other_negative_weights_in_the_exported_scale() {
	let out = run(r#"
		local _, r = G.Scales.Import('( Pawn: v1: "Penalties": Class=Warrior, Strength=-1, Agility=-0.1, Stamina=2 )')
		assert(G.Scales.RemoveWeight("WARRIOR", r.scale.id, "sta"))
		local ok, imported = G.Scales.Import(G.Scales.Export("WARRIOR", r.scale.id))
		assert(ok)
		emit(imported.scale.weights)
	"#);
	assert_eq!(out[0], json!({ "str": -1, "agi": -0.1 }));
}

#[test]
fn copy_a_built_in_spec_a_new_scale_holds_that_spec_s_weights_at_your_level_named_as_a_copy_ready_to_edit() {
	let out = run_ui(
		&[
			ROWS,
			r#"
		local UI, G = Polestar.UI, Polestar.Gear
		UI.ShowScales()
		local ok, res = G.Scales.CopyBuiltin("WARRIOR", "arms")
		local builtin = G.WeightsFor("WARRIOR", "arms", G.GetPlayer().level)
		local same = true
		for k, v in pairs(builtin) do if res.scale.weights[k] ~= v then same = false end end
		local ok2, res2 = G.Scales.CopyBuiltin("WARRIOR", "arms")
		emit({ ok = ok, name = res.scale.name, same = same, edited = res.scale.edited or false, second = res2.scale.name })
		G.Scales.SetWeight("WARRIOR", res.scale.id, "dps", 9)
		emit({ builtinDps = G.WeightsFor("WARRIOR", "arms", G.GetPlayer().level).dps, copyDps = res.scale.weights.dps })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_eq!(out["ok"], true);
	assert_eq!(out["name"], "Arms (copy)");
	assert_eq!(out["same"], true);
	assert_eq!(out["edited"], false);
	assert_eq!(out["second"], "Arms (copy) 2");
}

#[test]
fn the_copy_a_built_in_spec_button_lists_your_class_s_specs_and_opens_the_new_scale_s_details() {
	let out = run_ui(
		&[
			ROWS,
			r#"
		local UI, G = Polestar.UI, Polestar.Gear
		UI.ShowScales()
		local items
		Polestar.Widgets.ShowMenu = function(anchor, list) items = list end
		UI.ScalesView.frame.Copy:Click()
		local names = {}
		for _, it in ipairs(items) do names[#names + 1] = it.text end
		items[3].onClick()
		emit({ names = names, rows = #shown(), lines = #shown()[1].lines > 0, status = UI.ScalesView.frame.Status:GetText() })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_eq!(out["names"], json!(["Arms", "Fury", "Protection (tank)"]));
	assert_eq!(out["rows"], 1);
	assert_eq!(out["lines"], true);
	assert!(is_match(text(&out["status"]), r"Copied Protection \(tank\) \(copy\)"));
}

#[test]
fn the_window_can_be_resized_by_its_grip_bounds_the_corner_anchor_kept_the_list_following_the_width_the_size_remembered() {
	let out = run_ui(
		&[
			ROWS,
			r#"
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Tank": Class=Warrior, Strength=2 )')
		UI.ShowScales()
		local V = UI.ScalesView.frame
		local before = { V:GetWidth(), V:GetHeight(), UI.ScalesView.rows[1]:GetWidth() }
		V.Grip:GetScript("OnMouseDown")(V.Grip)
		local sizing = V.sizing
		V:SetSize(800, 720)
		V:GetScript("OnSizeChanged")(V, 800, 720)
		V.Grip:GetScript("OnMouseUp")(V.Grip)
		local row = UI.ScalesView.rows[1]
		emit({ resizable = V:IsResizable(), bounds = V.resizeBounds, sizing = sizing, stopped = V.sizing == false, before = before,
			after = { V:GetWidth(), V:GetHeight(), row:GetWidth() }, saved = Polestar.DB().gearScalesWindow })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_eq!(out["resizable"], true);
	assert_eq!(out["bounds"], json!([480, 460, 1100, 1400]));
	assert_eq!(out["sizing"], true, "the grip starts sizing");
	assert_eq!(out["stopped"], true, "letting go stops it");
	assert_eq!(out["before"], json!([560, 640, 560 - 48 - 12]));
	assert_eq!(out["after"], json!([800, 720, 800 - 48 - 12]), "the rows are as wide as the list now");
	assert_eq!(out["saved"], json!({ "w": 800, "h": 720 }));
}

#[test]
fn the_window_opens_at_the_size_it_was_left_at_inside_the_limits() {
	let sizes = |saved: &str| {
		run_ui(&["\n\t\tlocal UI = Polestar.UI\n\t\tPolestar.DB().gearScalesWindow = ", saved, "\n\t\tUI.ShowScales()\n\t\temit({ UI.ScalesView.frame:GetSize() })\n\t"].concat()).remove(0)
	};
	assert_eq!(sizes("{ w = 700, h = 600 }"), json!([700, 600]));
	assert_eq!(sizes("{ w = 100, h = 100 }"), json!([480, 460]), "never smaller than the least");
	assert_eq!(sizes("{ w = 5000, h = 5000 }"), json!([1100, 1060]), "nor bigger than the limit or the screen");
	assert_eq!(sizes(r#""junk""#), json!([560, 640]), "a bad value is the default");
}

#[test]
fn the_input_area_keeps_its_height_while_a_scale_is_renamed_so_the_list_stays_where_it_is() {
	let out = run_ui(
		&[
			ROWS,
			r#"
		local UI, G = Polestar.UI, Polestar.Gear
		G.Scales.Import('( Pawn: v1: "Old": Class=Warrior, Strength=1 )')
		UI.ShowScales()
		local V = UI.ScalesView.frame
		local importing = { V.Input:GetHeight(), V.Paste:IsShown(), V.Name:IsShown() }
		UI.ScalesView.rows[1].Rename:Click()
		emit({ importing = importing, renaming = { V.Input:GetHeight(), V.Paste:IsShown(), V.Name:IsShown() } })
	"#,
		]
		.concat(),
	);
	let out = &out[0];
	assert_eq!(out["importing"], json!([80, true, false]));
	assert_eq!(out["renaming"], json!([80, false, true]));
}
