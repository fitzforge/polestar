//! The Lookup runtime: Lookup.Sources ranking for the character (faction, race, class, level, professions,
//! reputation, distance, drop chance), curated and generated guides, Search over guides and Codex entities,
//! Polestar.Hooks (tooltip lines, item clicks), the mount spotter, tooltip source lines, Alt-click and the
//! options page. The Codex is a synthetic pack (tests/fixtures/codex/lookup.json) loaded the way the client
//! loads it.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

fn codex() -> Value {
	fixture("lookup.json")
}

const ADDON_FILES: &[&str] = &["Core/Core.xml", "Lookup/Lookup.xml"];

// The stub world draws the fixture's maps with the same bounds as their Era frames, so live and Era
// coordinates agree.
fn maps(codex: &Value) -> String {
	let mut frames: Vec<(&String, &Value)> = codex["frames"].as_object().unwrap().iter().collect();
	frames.sort_by_key(|(id, _)| id.parse::<u64>().unwrap_or(u64::MAX));
	frames
		.into_iter()
		.map(|(id, f)| {
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&codex["zones"][id.as_str()]["name"]).unwrap(),
				f["c"],
				f["left"],
				f["right"],
				f["top"],
				f["bottom"]
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

thread_local! {
	static PACK: CodexPack = write_codex_pack(&codex(), &CodexOpts::default());
}

struct Opts {
	level: i32,
	race: &'static str,
	faction: &'static str,
	cls: &'static str,
	with_pack: bool,
	files: &'static [&'static str],
	saved: Option<&'static str>,
	setup: String,
}

impl Default for Opts {
	fn default() -> Opts {
		Opts { level: 20, race: "Human", faction: "Alliance", cls: "WARRIOR", with_pack: true, files: ADDON_FILES, saved: None, setup: String::new() }
	}
}

const ROWS: &str = r#"
local function rows(kind, id)
	local list, entity = Polestar.Lookup.Sources(kind, id)
	local out = {}
	for i, r in ipairs(list) do
		out[i] = { type = r.type, label = r.label, detail = r.detail, available = r.available, why = r.why, whyText = r.whyText,
			travel = r.travel and math.floor(r.travel + 0.5), effort = r.effort and math.floor(r.effort + 0.5), chance = r.chance,
			map = r.map, x = r.x, y = r.y, guideable = r.guideable, trainer = r.trainer, price = r.price }
	end
	return out, entity
end
"#;

fn run_with(script: &str, o: &Opts) -> Vec<Value> {
	let js = |s: &str| serde_json::to_string(s).unwrap();
	let pack = if o.with_pack { PACK.with(|p| p.stub_lua.clone()) } else { String::new() };
	let before = format!(
		"{pack}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = {}, {}, {}, {}\nw.class, w.className = {}, {}\nw.moveTo(9001, 50, 50)\n{}",
		maps(&codex()),
		o.level,
		js(o.race),
		js(o.race),
		js(o.faction),
		js(o.cls),
		js(o.cls),
		o.setup
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_lookup_runtime.lua"],
		before,
		addons: vec![Addon::files("Polestar", o.files)],
		saved: o.saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login: true,
		script: format!("{ROWS}{script}"),
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, &Opts::default())
}

fn first<const N: usize>(v: Vec<Value>) -> [Value; N] {
	let mut it = v.into_iter();
	std::array::from_fn(|_| it.next().unwrap_or(Value::Null))
}

fn arr(v: &Value) -> &Vec<Value> {
	v.as_array().unwrap()
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

fn pick(list: &Value, keys: &[&str]) -> Value {
	Value::Array(
		arr(list)
			.iter()
			.map(|r| {
				let mut o = serde_json::Map::new();
				for k in keys {
					o.insert((*k).to_string(), r[*k].clone());
				}
				Value::Object(o)
			})
			.collect(),
	)
}

// ---------------------------------------------------------------------------
// Sources
// ---------------------------------------------------------------------------

#[test]
fn sources_the_other_faction_is_unavailable_the_nearer_vendor_ranks_first() {
	let list = run(r#"emit((rows("mount", 8000)))"#).remove(0);
	let horde = run_with(r#"emit((rows("mount", 8000)))"#, &Opts { race: "Orc", faction: "Horde", ..Default::default() }).remove(0);
	assert_eq!(
		pick(&list, &["label", "available", "why", "detail"]),
		json!([
			{ "label": "Mira Saddler", "available": true, "why": null, "detail": "Vendor \u{b7} Amber Vale" },
			{ "label": "Tobin Far", "available": true, "why": null, "detail": "Vendor \u{b7} Ember Hollow" },
			{ "label": "Grosh Saddler", "available": false, "why": "faction", "detail": "Vendor \u{b7} Amber Vale" },
		])
	);
	assert!(num(&list[0]["travel"]) < num(&list[1]["travel"]), "Mira is nearer than Tobin");
	assert_eq!(list[0]["price"], 100000);
	assert_eq!(list[2]["whyText"], "Horde only");
	assert_eq!(
		pick(&horde, &["label", "available"]),
		json!([
			{ "label": "Grosh Saddler", "available": true },
			{ "label": "Mira Saddler", "available": false },
			{ "label": "Tobin Far", "available": false },
		])
	);
}

#[test]
fn sources_required_item_level_quest_minlevel_and_mob_level_gate_a_source() {
	let [low, peril, grumble] = first::<3>(run_with(
		r#"
		emit((rows("mount", 8000)))
		emit((rows("item", 8002)))
		emit((rows("item", 8007)))
	"#,
		&Opts { level: 15, ..Default::default() },
	));
	assert!(arr(&low).iter().all(|r| !truthy(&r["available"])));
	assert!(arr(&low).iter().filter(|r| r["label"] != "Grosh Saddler").all(|r| r["why"] == "level" && r["whyText"] == "Requires level 20"));
	assert_eq!(
		pick(&peril, &["type", "available", "why", "whyText"]),
		json!([
			{ "type": "drop", "available": true, "why": null, "whyText": null },
			{ "type": "quest", "available": false, "why": "level", "whyText": "Requires level 30" },
		])
	);
	assert_eq!(pick(&grumble, &["available", "why"]), json!([{ "available": false, "why": "level" }]));
	let ok = run_with(r#"emit((rows("mount", 8000)))"#, &Opts { level: 20, ..Default::default() }).remove(0);
	assert!(truthy(&ok[0]["available"]));
}

#[test]
fn sources_professions_gate_crafts_unless_the_character_can_still_learn_them() {
	let script = r#"emit((rows("item", 8005)))"#;
	let none = run(script).remove(0);
	let full = run_with(script, &Opts { setup: r#"w.learnSkill(164, "Blacksmithing", 50, 75); w.learnSkill(186, "Mining", 60, 75)"#.into(), ..Default::default() }).remove(0);
	let low = run_with(script, &Opts { setup: r#"w.learnSkill(197, "Tailoring", 80, 150)"#.into(), ..Default::default() }).remove(0);
	let high = run_with(script, &Opts { setup: r#"w.learnSkill(197, "Tailoring", 120, 150)"#.into(), ..Default::default() }).remove(0);
	let stubbed = run(r#"
		Polestar.Compat.GetSkillRank = function(line) if line == 197 then return 150, 225 end end
		emit((rows("item", 8005)))
	"#)
	.remove(0);
	assert_eq!(pick(&none, &["available", "label", "trainer", "map"]), json!([{ "available": true, "label": "Tailoring 100", "trainer": 5010, "map": 9001 }]));
	assert_eq!(pick(&full, &["available", "why", "whyText"]), json!([{ "available": false, "why": "profession", "whyText": "Requires Tailoring" }]));
	assert!(truthy(&low[0]["available"]) && truthy(&high[0]["available"]) && truthy(&stubbed[0]["available"]));
	assert!(num(&none[0]["effort"]) > num(&low[0]["effort"]), "learning the profession costs more than skilling up");
	assert!(num(&low[0]["effort"]) > num(&high[0]["effort"]), "missing skill points cost effort");
	assert_eq!(high[0]["effort"], stubbed[0]["effort"]);
}

#[test]
fn sources_reputation_and_the_faction_of_a_reputation_gate_a_source() {
	let [before, wolf] = first::<2>(run(r#"emit((rows("tabard", 8006))); emit((rows("mount", 8012)))"#));
	let after = run_with(r#"emit((rows("tabard", 8006)))"#, &Opts { setup: r#"w.setRep(9100, "Vale Wardens", 7, 0, 0, 21000)"#.into(), ..Default::default() }).remove(0);
	assert_eq!(pick(&before, &["available", "why", "label", "detail"]), json!([{ "available": false, "why": "reputation", "label": "Vale Wardens", "detail": "Reputation \u{b7} Revered" }]));
	assert_eq!(before[0]["whyText"], "Requires Revered (Neutral)");
	assert_eq!(before[0]["effort"], 3 * 14400);
	assert_eq!(pick(&after, &["available", "effort"]), json!([{ "available": true, "effort": 0 }]));
	assert_eq!(pick(&wolf, &["available", "why"]), json!([{ "available": false, "why": "faction" }]));
}

#[test]
fn sources_a_vendor_that_sells_only_at_a_standing_or_a_skill_rank() {
	let script = r#"emit((rows("mount", 8016))); emit((rows("recipe", 8017)))"#;
	let [reins, pattern] = first::<2>(run(script));
	let [reins_ok, pattern_ok] =
		first::<2>(run_with(script, &Opts { setup: r#"w.setRep(9100, "Vale Wardens", 8, 0, 0, 1000); w.learnSkill(197, "Tailoring", 130, 150)"#.into(), ..Default::default() }));
	let [_, pattern_low] = first::<2>(run_with(script, &Opts { setup: r#"w.learnSkill(197, "Tailoring", 100, 150)"#.into(), ..Default::default() }));
	assert_eq!(
		pick(&reins, &["type", "label", "available", "why", "whyText", "effort"]),
		json!([{ "type": "vendor", "label": "Quartermaster Ilsa", "available": false, "why": "reputation", "whyText": "Requires Exalted (Vale Wardens)", "effort": 4 * 14400 }])
	);
	assert_eq!(pick(&pattern, &["type", "available", "why", "whyText"]), json!([{ "type": "vendor", "available": false, "why": "profession", "whyText": "Requires Tailoring 125" }]));
	assert!(num(&pattern[0]["effort"]) > num(&pattern_low[0]["effort"]), "fewer missing skill points cost less");
	assert_eq!(pattern_low[0]["why"], "profession");
	assert_eq!(pick(&reins_ok, &["available", "effort"]), json!([{ "available": true, "effort": 0 }]));
	assert_eq!(pick(&pattern_ok, &["available", "effort"]), json!([{ "available": true, "effort": 0 }]));
}

#[test]
fn sources_a_quest_whose_rewards_need_a_standing_questiedb_requiredminrep_gates_its_reward_row() {
	let script = r#"emit((rows("item", 8018)))"#;
	let band = run(script).remove(0);
	let band_ok = run_with(script, &Opts { setup: r#"w.setRep(9100, "Vale Wardens", 6, 0, 0, 12000)"#.into(), ..Default::default() }).remove(0);
	assert_eq!(
		pick(&band, &["type", "label", "available", "why", "whyText"]),
		json!([{ "type": "quest", "label": "The Wardens' Commission", "available": false, "why": "reputation", "whyText": "Requires Honored (Vale Wardens)" }])
	);
	assert!(num(&band[0]["effort"]) >= (2 * 14400) as f64, "the missing standings cost the grind");
	assert_eq!(pick(&band_ok, &["available", "why"]), json!([{ "available": true, "why": null }]));
}

#[test]
fn sources_a_better_drop_chance_ranks_first_race_class_and_unknown_races() {
	let [tusk, totem, charger] = first::<3>(run(r#"emit((rows("item", 8004))); emit((rows("item", 8003))); emit((rows("mount", 8011)))"#));
	assert_eq!(pick(&tusk, &["label", "chance"]), json!([{ "label": "Bristle Boar", "chance": 50 }, { "label": "Thornback Boar", "chance": 5 }]));
	assert!((num(&tusk[1]["effort"]) / num(&tusk[0]["effort"]) - 10.0).abs() < 0.01, "expected kills scale with 100 / chance");
	assert_eq!(pick(&totem, &["available", "why"]), json!([{ "available": false, "why": "race" }, { "available": false, "why": "race" }]));
	assert_eq!(pick(&charger, &["available", "why", "whyText"]), json!([{ "available": false, "why": "class", "whyText": "Class mount" }]));
	// A race the Era masks do not know (a Forever race) is never excluded by them.
	let new_race = run_with(r#"emit((rows("item", 8003)))"#, &Opts { race: "Dracthyr", ..Default::default() }).remove(0);
	assert!(arr(&new_race).iter().all(|r| truthy(&r["available"])));
	let paladin = run_with(r#"emit((rows("mount", 8011)))"#, &Opts { cls: "PALADIN", ..Default::default() }).remove(0);
	assert!(truthy(&paladin[0]["available"]));
}

#[test]
fn sources_rare_instance_object_world_drop_and_container_rows() {
	let [rare, crypt, chest, world] = first::<4>(run(r#"
		emit((rows("item", 8014))); emit((rows("item", 8008))); emit((rows("item", 8009))); emit((rows("item", 8015)))
	"#));
	assert_eq!(rare[0]["label"], "Gnash the Unseen");
	assert!(num(&rare[0]["effort"]) > (4 * 1800) as f64, "a rare waits for its respawn");
	assert_eq!(
		pick(&crypt, &["label", "detail", "map", "x", "y", "guideable", "available"]),
		json!([{ "label": "Lord Ashcroft", "detail": "Drop \u{b7} Ashen Crypt", "map": 9001, "x": 30, "y": 70, "guideable": true, "available": true }])
	);
	assert_eq!(crypt[0]["effort"], 5 * 2400);
	assert_eq!(pick(&chest, &["label", "detail", "chance", "guideable"]), json!([{ "label": "Weathered Chest", "detail": "Treasure \u{b7} Amber Vale", "chance": 40, "guideable": true }]));
	assert_eq!(pick(&world, &["label", "detail", "guideable"]), json!([{ "label": "World drop", "detail": "World drop \u{b7} Level 10-30", "guideable": false }]));
}

#[test]
fn sources_npcs_quests_dungeons_and_zones_give_location_rows() {
	let [npc, quest, inst, zone] = first::<4>(run(r#"
		emit((rows("rare", 5011)))
		emit((rows("quest", 7001)))
		emit((rows("instance", "ashen_crypt")))
		local list, z = rows("zone", 9001); emit({ n = #list, name = z.name })
	"#));
	assert_eq!(
		pick(&npc, &["type", "label", "detail", "map", "x", "y"]),
		json!([{ "type": "spawn", "label": "Gnash the Unseen", "detail": "Amber Vale \u{b7} Level 21", "map": 9001, "x": 70, "y": 30 }])
	);
	assert_eq!(
		pick(&quest, &["type", "label", "detail", "available", "guideable"]),
		json!([
			{ "type": "start", "label": "Elder Rowan", "detail": "Starts the quest \u{b7} Amber Vale", "available": true, "guideable": true },
			{ "type": "end", "label": "Captain Hale", "detail": "Ends the quest \u{b7} Amber Vale", "available": true, "guideable": true },
		])
	);
	assert_eq!(pick(&inst, &["type", "label", "detail", "map"]), json!([{ "type": "entrance", "label": "Ashen Crypt", "detail": "Entrance \u{b7} Amber Vale", "map": 9001 }]));
	assert_eq!(zone, json!({ "n": 0, "name": "Amber Vale" }));
}

// A French client whose names pack lands after the first look: the Codex names Elder Rowan in French from then
// on, and so must the cached rows.
#[test]
fn sources_a_names_pack_landing_late_renames_the_cached_rows() {
	let [before, after] = first::<2>(run(r#"
		local label = function() return rows("quest", 7001)[1].label end
		emit(label())
		local N = Polestar.Names
		N.Localised = function() return true end
		local cached = N.Cached
		N.Cached = function(kind, id) if kind == "npc" and id == 5008 then return "Ancien Rowan" end return cached(kind, id) end
		Polestar.Fire("NAMES_LOADED")
		emit(label())
	"#));
	assert_eq!(before, "Elder Rowan");
	assert_eq!(after, "Ancien Rowan");
}

#[test]
fn sources_an_already_finished_quest_is_not_offered_as_available() {
	let list = run_with(r#"emit((rows("item", 8001)))"#, &Opts { level: 20, setup: "w.complete({ 7002 })".into(), ..Default::default() }).remove(0);
	assert_eq!(pick(&list, &["available", "why", "whyText"]), json!([{ "available": false, "why": "done", "whyText": "Already done" }]));
}

// ---------------------------------------------------------------------------
// Guides: curated and generated
// ---------------------------------------------------------------------------

const GUIDES_LUA: &str = r#"
local function g(id, extra)
	local def = { id = id, pack = "test", title = id, category = "Collectibles", steps = { { goals = { { t = "note", text = "x" } } } } }
	for k, v in pairs(extra) do def[k] = v end
	assert(Polestar.RegisterGuide(def))
end
g("test/horde-strider", { faction = "Horde", collects = { 8000 } })
g("test/alliance-strider", { faction = "Alliance", collects = { 8000, 8013 } })
g("test/shadowsteed", { keywords = { "Warlock", "Summon Shadowsteed" } })
-- A leveling guide makes the test pack a suggestion source (TEST_SOURCE).
g("test/route", { category = "Leveling", minLevel = 1, maxLevel = 60 })
"#;

fn guides() -> String {
	["\n", TEST_PACK, "\n", TEST_SOURCE, GUIDES_LUA].concat()
}

#[test]
fn curated_guides_the_one_for_this_character_and_class_mounts_by_keyword() {
	let [alliance, spell, none, opened, tabs] = first::<5>(run(&(guides()
		+ r#"
		local L = Polestar.Lookup
		emit(L.CuratedGuide("mount", 8000)); emit(L.CuratedGuide("spell", 9503)); emit(L.CuratedGuide("item", 8004) or false)
		emit(L.Guide("pet", 8013))
		local t = Polestar.Engine.GetTabs(); emit({ t[#t].guideId, Polestar.Engine.GetGuide().id })
	"#)));
	assert_eq!(alliance, "test/alliance-strider");
	assert_eq!(spell, "test/shadowsteed");
	assert_eq!(none, false);
	assert_eq!(opened, "test/alliance-strider");
	assert_eq!(tabs, json!(["test/alliance-strider", "test/alliance-strider"]));
	let horde = run_with(&(guides() + r#" emit(Polestar.Lookup.CuratedGuide("mount", 8000))"#), &Opts { race: "Orc", faction: "Horde", ..Default::default() }).remove(0);
	assert_eq!(horde, "test/horde-strider");
}

#[test]
fn generated_guides_registered_unsaved_in_pack_lookup_opened_in_a_tab_rebuilt_for_another_source() {
	let [first_id, def, second, tabs, step] = first::<5>(run(r#"
		local L = Polestar.Lookup
		emit({ L.Guide("item", 8004) })
		local g = Polestar.Guides.Get("lookup/item/8004")
		emit({ pack = g.pack, category = g.category, title = g.title, steps = #g.steps, step1 = g.steps[1].title,
			goals = { g.steps[1].goals[1].t, g.steps[1].goals[2].t, g.steps[1].goals[3].t }, pack2 = Polestar.Guides.Pack("lookup").id })
		emit({ L.Guide("item", 8004, 2) })
		local t = Polestar.Engine.GetTabs(); local ids = {}
		for i, x in ipairs(t) do ids[i] = x.guideId end
		emit(ids)
		emit(Polestar.Engine.GetGuide().steps[1].title)
	"#));
	assert_eq!(first_id, json!(["lookup/item/8004"]));
	assert_eq!(def, json!({ "pack": "lookup", "category": "Lookup", "title": "Boar Tusk", "steps": 1, "step1": "Bristle Boar", "goals": ["goto", "kill", "collect"], "pack2": "lookup" }));
	assert_eq!(second, json!(["lookup/item/8004"]));
	assert_eq!(tabs, json!(["lookup/item/8004"]));
	assert_eq!(step, "Thornback Boar");
}

#[test]
fn polestar_holds_the_internal_lookup_pack_from_load_a_pack_claiming_it_later_is_refused_listed_and_lookup_still_works() {
	let [claim, rows, held, opened] = first::<4>(run(r#"
		emit({ Polestar.RegisterPack({ addon = "SneakyLookup", id = "lookup", format = 1, title = "Mine", author = "X", version = "1", license = "MIT", internal = true }) })
		stub.addonLoaded("SneakyLookup")
		local rows = {}
		for _, r in ipairs(Polestar.Guides.Packs()) do rows[#rows + 1] = { id = r.id, addon = r.addon or false, status = r.status, reason = r.reason or false } end
		emit(rows)
		local p = Polestar.Guides.Pack("lookup")
		emit({ internal = p.internal or false, status = p.status, addon = p.addon or false })
		emit({ Polestar.Lookup.Guide("item", 8004) })
	"#));
	assert_eq!(claim[0], false);
	let sneaky: Vec<&Value> = arr(&rows).iter().filter(|r| r["addon"] == "SneakyLookup").collect();
	assert_eq!(sneaky.len(), 1, "{}", rows);
	assert_eq!(sneaky[0]["status"], "refused");
	assert!(is_match(text(&sneaky[0]["reason"]), r"internal"));
	assert_eq!(held, json!({ "internal": true, "status": "on", "addon": false }));
	assert_eq!(opened, json!(["lookup/item/8004"]));
}

#[test]
fn generated_guides_no_guide_for_sources_without_a_place_disabled_module() {
	let [world, disabled] = first::<2>(run(r#"
		local function try(...) local id, why = Polestar.Lookup.Guide(...); return { id = id or false, why = why or false } end
		emit(try("item", 8015))
		Polestar.Set("lookup.enabled", false)
		emit(try("item", 8004))
	"#));
	assert_eq!(world, json!({ "id": false, "why": "noguide" }));
	assert_eq!(disabled, json!({ "id": false, "why": "disabled" }));
}

#[test]
fn generated_guides_a_saved_lookup_tab_is_rebuilt_before_the_engine_reopens_tabs() {
	let [tabs, active] = first::<2>(run_with(
		r#"
		local t = Polestar.Engine.GetTabs(); local ids = {}
		for i, x in ipairs(t) do ids[i] = x.guideId end
		emit(ids); emit(Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id)
	"#,
		&Opts { saved: Some(r#"PolestarCharDB = { schema = 1, tabs = { "lookup/item/8004", "lookup/mount/8000" }, activeTab = 2 }"#), ..Default::default() },
	));
	assert_eq!(tabs, json!(["lookup/item/8004", "lookup/mount/8000"]));
	assert_eq!(active, "lookup/mount/8000");
}

// ---------------------------------------------------------------------------
// Search
// ---------------------------------------------------------------------------

const SEARCH_LUA: &str = r#"
assert(Polestar.RegisterGuide({ id = "test/pathfinder", pack = "test", title = "Amber Vale Pathfinder", zoneName = "Amber Vale", minLevel = 15, maxLevel = 20,
	keywords = { "strider" }, steps = { { goals = { { t = "note", text = "x" } } } } }))
assert(Polestar.RegisterGuide({ id = "lookup/item/1", pack = "lookup", title = "Amber Generated", steps = { { goals = { { t = "note", text = "x" } } } } }))
local function q(text, opts)
	local res, counts = Polestar.Search.Query(text, opts)
	local out = {}
	for i, r in ipairs(res) do out[i] = { kind = r.kind, id = r.id, title = r.title, subtitle = r.subtitle, quality = r.quality } end
	return { res = out, counts = counts }
end
"#;

fn search_guides() -> String {
	["\n", TEST_PACK, "\n", TEST_SOURCE, SEARCH_LUA].concat()
}

fn titles(r: &Value) -> Vec<String> {
	arr(&r["res"]).iter().map(|x| format!("{}:{}", text(&x["kind"]), text(&x["title"]))).collect()
}

fn kinds(r: &Value) -> Vec<Value> {
	arr(&r["res"]).iter().map(|x| x["kind"].clone()).collect()
}

#[test]
fn search_tiers_kind_order_guides_with_keywords_filters_and_counts() {
	let [amber, exact, boar, npc_only, strider, rider, words, accent, status] = first::<9>(run(&(search_guides()
		+ r#"
		emit(q("amber")); emit(q("Amber Vale")); emit(q("boar")); emit(q("boar", { kinds = { npc = true } }))
		emit(q("strider")); emit(q("rider")); emit(q("reins strider")); emit(q("M\195\174RA"))
		emit({ Polestar.Search.Status() })
	"#)));
	assert_eq!(titles(&amber), ["guide:Amber Vale Pathfinder", "mount:Amber Strider Reins", "zone:Amber Vale"]);
	assert_eq!(amber["res"][0], json!({ "kind": "guide", "id": "test/pathfinder", "title": "Amber Vale Pathfinder", "subtitle": "Amber Vale \u{b7} 15-20" }));
	assert_eq!(amber["res"][1], json!({ "kind": "mount", "id": 8000, "title": "Amber Strider Reins", "subtitle": "Vendor \u{b7} Amber Vale", "quality": 3 }));
	assert_eq!(titles(&exact)[..2].to_vec(), ["zone:Amber Vale", "guide:Amber Vale Pathfinder"]);
	assert_eq!(titles(&boar), ["item:Boar Tusk", "npc:Bristle Boar", "npc:Thornback Boar"]);
	assert_eq!(boar["counts"], json!({ "item": 1, "npc": 2 }));
	assert_eq!(boar["res"][1]["subtitle"], "Amber Vale \u{b7} Level 18");
	assert_eq!(titles(&npc_only), ["npc:Bristle Boar", "npc:Thornback Boar"]);
	assert_eq!(titles(&strider), ["guide:Amber Vale Pathfinder", "mount:Amber Strider Reins"]);
	assert_eq!(titles(&rider), ["mount:Amber Strider Reins", "guide:Amber Vale Pathfinder"]);
	assert_eq!(titles(&words), ["mount:Amber Strider Reins"]);
	assert_eq!(titles(&accent), ["npc:Mira Saddler"]);
	assert_eq!(status, json!([true]));
}

#[test]
fn search_folding_quests_and_dungeons_limits_a_missing_codex_pack_lookup_switched_off() {
	let [fold, quest, crypt, limited, status] = first::<5>(run(&(search_guides()
		+ r#"
		emit(Polestar.Search.Fold("\195\129mber V\195\161le's  Path-finder"))
		emit(q("trouble")); emit(q("crypt")); emit(q("a", { limit = 2 }))
		emit({ Polestar.Search.Status() })
	"#)));
	assert_eq!(fold, " amber vales path finder");
	assert_eq!(quest["res"], json!([{ "kind": "quest", "id": 7001, "title": "Trouble in the Vale", "subtitle": "Level 18 \u{b7} Amber Vale" }]));
	let crypt_rows: Vec<Value> = arr(&crypt["res"]).iter().map(|r| Value::Array(vec![r["kind"].clone(), r["title"].clone(), r["subtitle"].clone()])).collect();
	assert_eq!(crypt_rows, vec![json!(["item", "Crypt Blade", "Drop \u{b7} Ashen Crypt"]), json!(["instance", "Ashen Crypt", "Dungeon \u{b7} 18-26"])]);
	assert_eq!(arr(&limited["res"]).len(), 2);
	assert_eq!(status, json!([true]));
	let [st0, res, st1] = first::<3>(run_with(
		&(search_guides()
			+ r#"
		emit({ Polestar.Search.Status() }); emit(q("amber")); emit({ Polestar.Search.Status() })
	"#),
		&Opts { with_pack: false, ..Default::default() },
	));
	assert_eq!(st0, json!([false, "notloaded"]));
	assert_eq!(kinds(&res), ["guide"], "without the pack only guides are found");
	assert_eq!(st1, json!([false, "missing"]));
	let [off_status, off_res, loaded] = first::<3>(run(&(search_guides()
		+ r#"
		Polestar.Set("lookup.enabled", false)
		emit({ Polestar.Search.Status() }); emit(q("amber")); emit(Polestar.Codex.IsLoaded())
	"#)));
	assert_eq!(off_status, json!([false, "off"]));
	assert_eq!(kinds(&off_res), ["guide"]);
	assert_eq!(loaded, false, "a switched-off Lookup never loads the Codex");
}

#[test]
fn search_and_sources_obtainable_before_retired_curated_guide_backed_before_name_match() {
	// Three sabers: a short name no longer sold (retired), a plain one, and one a curated guide collects; plus
	// a pet with no known source.
	let mut extra = codex();
	let vendor = extra["items"]["8000"]["sources"][0].clone();
	extra["items"]["8100"] = json!({ "id": 8100, "name": "Saber Reins", "quality": 4, "kind": "mount", "spell": null, "reqLevel": null, "status": "retired", "sources": [vendor.clone()] });
	extra["items"]["8101"] = json!({ "id": 8101, "name": "Reins of the Plain Saber", "quality": 3, "kind": "mount", "spell": null, "reqLevel": null, "sources": [vendor.clone()] });
	extra["items"]["8102"] = json!({ "id": 8102, "name": "Reins of the Striped Saber", "quality": 3, "kind": "mount", "spell": null, "reqLevel": null, "sources": [vendor] });
	extra["items"]["8103"] = json!({ "id": 8103, "name": "Saber Kitten", "quality": 1, "kind": "pet", "spell": null, "reqLevel": null, "status": "nosource", "sources": [] });
	let own = write_codex_pack(&extra, &CodexOpts::default());
	let script = [
		"\n\t\t\t",
		TEST_PACK,
		"\n",
		TEST_SOURCE,
		r#"
			assert(Polestar.RegisterGuide({ id = "test/sabers", pack = "test", title = "Striped Sabers", collects = { 8102 },
				steps = { { goals = { { t = "note", text = "x" } } } } }))
			local res = Polestar.Search.Query("saber")
			local out = {}
			for i, r in ipairs(res) do out[i] = { kind = r.kind, id = r.id, status = r.status or false, curated = r.curated or false } end
			emit(out)
			local list = Polestar.Lookup.Sources("mount", 8100)
			emit({ available = list[1].available, why = list[1].why, whyText = list[1].whyText, guideable = list[1].guideable })
			local id, why = Polestar.Lookup.Guide("mount", 8100)
			emit({ id = id or false, why = why or false })
		"#,
	]
	.concat();
	let [res, rows, guide] = first::<3>(run_with(&script, &Opts { with_pack: false, setup: own.stub_lua.clone(), ..Default::default() }));
	let found: Vec<Value> = arr(&res).iter().filter(|r| r["kind"] != "guide").cloned().collect();
	assert_eq!(
		Value::Array(found),
		json!([
			{ "kind": "mount", "id": 8102, "status": false, "curated": true },
			{ "kind": "mount", "id": 8101, "status": false, "curated": false },
			{ "kind": "mount", "id": 8100, "status": "retired", "curated": false },
			{ "kind": "pet", "id": 8103, "status": "nosource", "curated": false },
		])
	);
	assert_eq!(rows, json!({ "available": false, "why": "retired", "whyText": "No longer obtainable", "guideable": false }));
	assert_eq!(guide, json!({ "id": false, "why": "noguide" }));
	drop(own);
}

#[test]
fn search_an_item_only_a_third_pack_collects_ranks_as_curated_only_while_that_pack_is_the_suggestion_source() {
	let mut extra = codex();
	let vendor = extra["items"]["8000"]["sources"][0].clone();
	extra["items"]["8102"] = json!({ "id": 8102, "name": "Reins of the Striped Saber", "quality": 3, "kind": "mount", "spell": null, "reqLevel": null, "sources": [vendor] });
	let own = write_codex_pack(&extra, &CodexOpts::default());
	let script = [
		"\n\t\t\t",
		TEST_PACK,
		"\n",
		TEST_SOURCE,
		r#"
			Polestar.RegisterPack({ addon = "Polestar_Other", id = "other", format = 1, title = "Other", author = "O", version = "1", license = "MIT" })
			local function g(id, extra)
				local def = { id = id, pack = "other", title = id, steps = { { goals = { { t = "note", text = "x" } } } } }
				for k, v in pairs(extra) do def[k] = v end
				assert(Polestar.RegisterGuide(def))
			end
			g("other/sabers", { category = "Collectibles", collects = { 8102 } })
			g("other/route", { category = "Leveling", minLevel = 1, maxLevel = 60 })
			local function flag()
				for _, r in ipairs(Polestar.Search.Query("striped saber")) do
					if r.kind == "mount" and r.id == 8102 then return r.curated or false end
				end
				return "missing"
			end
			emit(flag())
			Polestar.Set("behavior.suggestFrom", "other")
			emit(flag())
		"#,
	]
	.concat();
	let [before, after] = first::<2>(run_with(&script, &Opts { with_pack: false, setup: own.stub_lua.clone(), ..Default::default() }));
	assert_eq!(before, false, "no curated guide opens for it from another pack");
	assert_eq!(after, true);
	drop(own);
}

#[test]
fn search_one_letter_queries_read_name_prefixes_only_capped_paging_with_offset_lazy_subtitles() {
	let [one, page1, page2, lazy] = first::<4>(run_with(
		r#"
		local names = {}
		for i = 1, 400 do names[i] = { 100000 + i, (i % 2 == 0 and "Kestrel " or "Old Kestrel ") .. i } end
		local lines = {}
		for i, e in ipairs(names) do lines[i] = "\2" .. Polestar.Search.Fold(e[2]):sub(2) .. "\1" .. e[1] .. ",2,," .. #e[2] .. "\n" end
		local blob = table.concat(lines)
		local byId = {}
		for _, e in ipairs(names) do byId[e[1]] = e[2] end
		local none = function() return nil end
		Polestar.Codex = { IsLoaded = function() return true end, Load = function() return true end,
			Index = function(kind) if kind == "item" then return blob end end,
			Name = function(kind, id) return byId[id] end,
			Item = none, Npc = none, Quest = none, Object = none, Instance = none, Zone = none, Faction = none, Spell = none }
		local res, counts, more = Polestar.Search.Query("k", { kinds = { item = true } })
		emit({ n = #res, count = counts.item, more = more.item or false, first = res[1] and res[1].title })
		local a = Polestar.Search.Query("kestrel", { kinds = { item = true }, perKind = 50, subtitles = false })
		local b = Polestar.Search.Query("kestrel", { kinds = { item = true }, perKind = 50, offset = 50, subtitles = false })
		emit({ n = #a, first = a[1].title, last = a[#a].title }); emit({ n = #b, first = b[1].title })
		local calls = 0
		Polestar.Lookup = { Subtitle = function(kind, id) calls = calls + 1; return "Sub " .. id end }
		local c = Polestar.Search.Query("kestrel 3", { kinds = { item = true }, subtitles = false })
		local before = calls
		local s1 = Polestar.Search.Subtitle(c[1]); Polestar.Search.Subtitle(c[1])
		emit({ before = before, after = calls, s1 = s1 })
	"#,
		&Opts { with_pack: false, ..Default::default() },
	));
	assert_eq!(one, json!({ "n": 60, "count": 200, "more": false, "first": "Kestrel 2" }), "one letter: names starting with k only, not the word \"Kestrel\" in \"Old Kestrel\"");
	assert_eq!(page1, json!({ "n": 50, "first": "Kestrel 2", "last": "Kestrel 100" }));
	assert_eq!(page2["n"], 50);
	assert_ne!(page2["first"], page1["first"]);
	assert_eq!(lazy, json!({ "before": 0, "after": 1, "s1": "Sub 100030" }));
}

// Search speed without pinning one machine's: a keystroke is timed against the same run's cost of scanning every
// name once (one plain find over each index, what any search must do), and 25,000 names against 2,500. A search
// rebuilding its index per keystroke (a Lua pass over every line) costs far more than a few C scans; a quadratic
// one grows ~100x over 10x the names. Each figure is the median of several batches, each batch long enough for a
// coarse os.clock (Windows: 1 ms).
#[test]
fn search_a_keystroke_costs_a_few_scans_of_the_names_and_grows_linearly_from_2_500_to_25_000() {
	let [small, large] = first::<2>(run_with(
		r#"
		local syll = { "ka", "lo", "mi", "ra", "tor", "vel", "shi", "dun", "gar", "eth", "ul", "bri", "sta", "zor", "nim", "pe" }
		local queries = { "k", "ka", "tor", "torvel", "mi ra", "shidun", "zz", "gar eth", "Velka", "a", "nimpe sta", "ulbri" }
		local function median(fn, batches)
			local t = {}
			for b = 1, batches do
				local c = os.clock()
				fn()
				t[b] = os.clock() - c
			end
			table.sort(t)
			return t[math.ceil(batches / 2)]
		end
		local function measure(scale)
			local seed = 7
			local function rnd(n) seed = (seed * 1103515245 + 12345) % 2147483648; return seed % n + 1 end
			local function word() local s = ""; for _ = 1, rnd(3) + 1 do s = s .. syll[rnd(#syll)] end return s:sub(1, 1):upper() .. s:sub(2) end
			local plan = { item = 15000 * scale, npc = 6000 * scale, quest = 3800 * scale, mount = 200 * scale }
			local blobs, names = {}, {}
			for kind, n in pairs(plan) do
				local lines = {}
				names[kind] = {}
				for i = 1, n do
					local name = word() .. " " .. word() .. (rnd(3) == 1 and (" " .. word()) or "")
					names[kind][i] = name
					lines[i] = "\2" .. Polestar.Search.Fold(name):sub(2) .. "\1" .. i .. ",2,," .. #name .. "\n"
				end
				blobs[kind] = table.concat(lines)
			end
			local none = function() return nil end
			Polestar.Codex = { IsLoaded = function() return true end, Load = function() return true end,
				Index = function(kind) return blobs[kind] end,
				Name = function(kind, id) return names[kind] and names[kind][id] end,
				Item = none, Npc = none, Quest = none, Object = none, Instance = none, Zone = none, Faction = none, Spell = none }
			Polestar.Search.Query("warmup", { subtitles = false })
			-- The batches: every query 4 times; 40 scans of every index.
			local keys = median(function()
				for _ = 1, 4 do for _, text in ipairs(queries) do Polestar.Search.Query(text, { subtitles = false }) end end
			end, 7) / (4 * #queries)
			local scan = median(function()
				for _ = 1, 40 do for _, blob in pairs(blobs) do string.find(blob, "\2qqqq", 1, true) end end
			end, 7) / 40
			return { key = keys * 1000, scan = scan * 1000 }
		end
		emit(measure(0.1))
		emit(measure(1))
	"#,
		&Opts { with_pack: false, ..Default::default() },
	));
	let ms = |t: &Value| format!("keystroke {:.3} ms, one scan {:.3} ms", num(&t["key"]), num(&t["scan"]));
	// Here (Linux, lua5.1): a keystroke ~3 scans, 25,000 names ~2.5x 2,500; a Lua pass over every line alone
	// costs ~35 scans.
	assert!(num(&large["key"]) < 12.0 * num(&large["scan"]).max(0.01), "25,000 names: {}: more than 12 scans a keystroke", ms(&large));
	assert!(num(&large["key"]) < 15.0 * num(&small["key"]).max(0.01), "25,000 names {} vs 2,500 {}: grows faster than the names", ms(&large), ms(&small));
}

// ---------------------------------------------------------------------------
// Hooks
// ---------------------------------------------------------------------------

fn run_bare(script: &str) -> Vec<Value> {
	run_with(script, &Opts { with_pack: false, ..Default::default() })
}

#[test]
fn hooks_simulated_clears_dispatch_existing_scripts_and_hooks_on_both_item_frames() {
	let out = run_bare(
		r#"
		for _, tt in ipairs({ GameTooltip, ItemRefTooltip }) do
			local events = {}
			tt:SetScript("OnTooltipCleared", function(self) events[#events + 1] = "script:" .. #self.lines end)
			tt:HookScript("OnTooltipCleared", function(self) events[#events + 1] = "hook:" .. #self.lines end)
			tt:AddLine("Old client line")
			tt:ClearLines()
			tt:AddLine("Another client line")
			tt:SetOwner(UIParent)
			emit(events)
		end
	"#,
	);
	let events = json!(["script:0", "hook:0", "script:0", "hook:0"]);
	assert_eq!(out, vec![events.clone(), events]);
}

// One annotated subject on a tooltip: the frame, the Hooks registration and the post-call that shows it.
struct Rebuild {
	name: &'static str,
	frame: &'static str,
	register: &'static str,
	show: &'static str,
	setup: &'static str,
}

const TOOLTIP_REBUILD_CASES: [Rebuild; 4] = [
	Rebuild { name: "item on GameTooltip", frame: "GameTooltip", register: "ItemLines", show: r#"lookuprt.showItem(tt, 1234, "item:1234")"#, setup: "" },
	Rebuild { name: "item on ItemRefTooltip", frame: "ItemRefTooltip", register: "ItemLines", show: r#"lookuprt.showItem(tt, 1234, "item:1234")"#, setup: "" },
	Rebuild {
		name: "unit",
		frame: "GameTooltip",
		register: "UnitLines",
		show: r#"lookuprt.showUnit(tt, "mouseover")"#,
		setup: r#"lookuprt.units.mouseover = { guid = "Creature-0-1-0-1-1234-00000001" }"#,
	},
	Rebuild { name: "object", frame: "GameTooltip", register: "ObjectLines", show: r#"lookuprt.showObject(tt, { id = 1234, lines = { { leftText = "Synthetic object" } } })"#, setup: "" },
];

fn rebuild_script(c: &Rebuild, body: &str) -> String {
	body.replace("{SETUP}", c.setup).replace("{FRAME}", c.frame).replace("{REGISTER}", c.register).replace("{SHOW}", c.show)
}

#[test]
fn hooks_clear_hooks_install_once_per_frame_preserve_handlers_and_survive_registration_changes() {
	let [items, object] = first::<2>(run_bare(
		r#"
		local H, installs, clears = Polestar.Hooks, {}, {}
		local function annotation(tt) H.AddLine(tt, "Annotation") end
		H.ItemLines("installation-test", annotation)
		for _, tt in ipairs({ GameTooltip, ItemRefTooltip }) do
			local name, hook = tt:GetName(), tt.HookScript
			installs[name], clears[name] = 0, 0
			tt:SetScript("OnTooltipCleared", function() clears[name] = clears[name] + 1 end)
			tt.HookScript = function(self, event, fn)
				if event == "OnTooltipCleared" then installs[name] = installs[name] + 1 end
				return hook(self, event, fn)
			end
			-- HookScript can still work when support introspection is absent.
			if tt == ItemRefTooltip then tt.HasScript = false end
			for i = 1, 3 do
				tt:ClearLines(); tt:AddLine("Client")
				lookuprt.showItem(tt, 1234, "item:1234")
				lookuprt.showItem(tt, 1234, "item:1234")
				H.ItemLines("installation-test", nil)
				H.ItemLines("installation-test", annotation)
			end
		end
		emit({ installs = installs, clears = clears, game = GameTooltip.lines, ref = ItemRefTooltip.lines })
		H.ObjectLines("installation-test", annotation)
		GameTooltip:ClearLines(); GameTooltip:AddLine("Client")
		lookuprt.showObject(GameTooltip, { id = 1234 })
		lookuprt.showObject(GameTooltip, { id = 1234 })
		emit({ installs = installs, clears = clears, game = GameTooltip.lines, ref = ItemRefTooltip.lines })
	"#,
	));
	let installs = json!({ "GameTooltip": 1, "ItemRefTooltip": 1 });
	let lines = json!(["Client", "Annotation"]);
	assert_eq!(items, json!({ "installs": installs, "clears": { "GameTooltip": 3, "ItemRefTooltip": 3 }, "game": lines, "ref": lines }));
	assert_eq!(object, json!({ "installs": installs, "clears": { "GameTooltip": 4, "ItemRefTooltip": 3 }, "game": lines, "ref": lines }));
}

// A clear-hook API that is missing, says it is unsupported, or throws: annotations still show once per clear,
// the API is tried once, and a thrown error is kept once in the session report without reaching the handler.
fn clear_hook_api_failure(failure: &str) {
	let [out] = first::<1>(run_bare(
		&r#"
			local H, tt, checks, attempts, calls, handlerCalls = Polestar.Hooks, GameTooltip, 0, 0, 0, 0
			local messages = #stub.messages
			geterrorhandler = function() return function() handlerCalls = handlerCalls + 1 end end
			tt.HasScript = function()
				checks = checks + 1
				if "{FAILURE}" == "HasScript" then error("synthetic HasScript failure", 0) end
				return "{FAILURE}" ~= "unsupported"
			end
			tt.HookScript = function()
				attempts = attempts + 1
				error("synthetic HookScript failure", 0)
			end
			if "{FAILURE}" == "missing" then tt.HookScript = false end
			H.ItemLines("failure-test", function(tip) calls = calls + 1; H.AddLine(tip, "Annotation") end)
			for i = 1, 2 do
				tt:ClearLines(); tt:AddLine("Client")
				for j = 1, 3 do lookuprt.showItem(tt, 1234, "item:1234") end
			end
			local errors = Polestar.Errors()
			emit({ checks = checks, attempts = attempts, calls = calls, lines = tt.lines,
				errors = #errors, error = errors[1] and { msg = errors[1].msg, count = errors[1].count } or false,
				handlerCalls = handlerCalls, messages = #stub.messages - messages })
		"#
		.replace("{FAILURE}", failure),
	));
	let throws = failure == "HasScript" || failure == "HookScript";
	let error = if throws { json!({ "msg": format!("synthetic {failure} failure"), "count": 1 }) } else { json!(false) };
	assert_eq!(
		out,
		json!({
			"checks": if failure == "missing" { 0 } else { 1 },
			"attempts": if failure == "HookScript" { 1 } else { 0 },
			"calls": 2, "lines": ["Client", "Annotation"], "errors": if throws { 1 } else { 0 },
			"error": error, "handlerCalls": 0, "messages": 0,
		}),
		"{failure}"
	);
}

#[test]
fn hooks_missing_clear_hook_api_preserves_annotations_without_retrying_or_noisy_diagnostics() {
	clear_hook_api_failure("missing");
}

#[test]
fn hooks_unsupported_clear_hook_api_preserves_annotations_without_retrying_or_noisy_diagnostics() {
	clear_hook_api_failure("unsupported");
}

#[test]
fn hooks_hasscript_clear_hook_api_failure_preserves_annotations_without_retrying_or_noisy_diagnostics() {
	clear_hook_api_failure("HasScript");
}

#[test]
fn hooks_hookscript_clear_hook_api_failure_preserves_annotations_without_retrying_or_noisy_diagnostics() {
	clear_hook_api_failure("HookScript");
}

// Without TooltipDataProcessor the OnTooltipSet* scripts deliver the post-calls.
fn processor_unavailable_fallback(frame: &str, kind: &str) {
	let [initial, rebuilt] = first::<2>(run_with(
		&r#"
			local H, tt, calls = Polestar.Hooks, {FRAME}, 0
			lookuprt.units.mouseover = { guid = "Creature-0-1-0-1-1234-00000001" }
			GameTooltip.GetUnit = function() return "Synthetic unit", "mouseover" end
			tt.link = "item:1234"
			H.{KIND}Lines("fallback-test", function(tip) calls = calls + 1; H.AddLine(tip, "Annotation") end)
			for n = 1, 2 do
				tt:ClearLines()
				for i = 1, n do tt:AddLine("Client " .. i) end
				stub.RunScript(tt, "OnTooltipSet{KIND}")
				stub.RunScript(tt, "OnTooltipSet{KIND}")
				emit({ lines = tt.lines, calls = calls, hooks = #tt.hooks.OnTooltipCleared })
			end
		"#
		.replace("{FRAME}", frame)
		.replace("{KIND}", kind),
		&Opts { with_pack: false, setup: "TooltipDataProcessor = nil".into(), ..Default::default() },
	));
	assert_eq!(initial, json!({ "lines": ["Client 1", "Annotation"], "calls": 1, "hooks": 1 }), "{kind} on {frame}");
	assert_eq!(rebuilt, json!({ "lines": ["Client 1", "Client 2", "Annotation"], "calls": 2, "hooks": 1 }), "{kind} on {frame}");
}

#[test]
fn hooks_processor_unavailable_item_fallback_on_gametooltip_restores_annotations_once_per_clear() {
	processor_unavailable_fallback("GameTooltip", "Item");
}

#[test]
fn hooks_processor_unavailable_item_fallback_on_itemreftooltip_restores_annotations_once_per_clear() {
	processor_unavailable_fallback("ItemRefTooltip", "Item");
}

#[test]
fn hooks_processor_unavailable_unit_fallback_on_gametooltip_restores_annotations_once_per_clear() {
	processor_unavailable_fallback("GameTooltip", "Unit");
}

#[test]
fn hooks_repeated_and_appended_callbacks_keep_annotations_once_without_clearing() {
	for c in &TOOLTIP_REBUILD_CASES {
		let [repeated, appended] = first::<2>(run_bare(&rebuild_script(
			c,
			r#"
			{SETUP}
			local tt, H, calls, clears = {FRAME}, Polestar.Hooks, 0, 0
			tt:HookScript("OnTooltipCleared", function() clears = clears + 1 end)
			H.{REGISTER}("rebuild-test", function(tip) calls = calls + 1; H.AddLine(tip, "Annotation") end)
			tt:ClearLines()
			tt:AddLine("Client 1")
			{SHOW}
			{SHOW}
			emit({ lines = tt.lines, calls = calls, clears = clears })
			tt:AddLine("Appended client line")
			{SHOW}
			{SHOW}
			emit({ lines = tt.lines, calls = calls, clears = clears })
		"#,
		)));
		assert_eq!(repeated, json!({ "lines": ["Client 1", "Annotation"], "calls": 1, "clears": 1 }), "{}", c.name);
		assert_eq!(appended, json!({ "lines": ["Client 1", "Annotation", "Appended client line"], "calls": 1, "clears": 1 }), "{}", c.name);
	}
}

// #673: a tooltip cleared and rebuilt for the same subject with as many or more client lines than before.
#[test]
fn hooks_restore_annotations_after_a_same_subject_clear_and_rebuild_with_an_equal_or_greater_line_count() {
	for c in &TOOLTIP_REBUILD_CASES {
		for client_lines in [2, 3] {
			let [initial, rebuilt, repeated] = first::<3>(run_bare(
				&rebuild_script(
					c,
					r#"
				{SETUP}
				local tt, H, calls, clears = {FRAME}, Polestar.Hooks, 0, 0
				tt:HookScript("OnTooltipCleared", function() clears = clears + 1 end)
				H.{REGISTER}("rebuild-test", function(tip) calls = calls + 1; H.AddLine(tip, "Annotation") end)
				tt:ClearLines()
				tt:AddLine("Client 1")
				{SHOW}
				emit({ lines = tt.lines, calls = calls, clears = clears })
				tt:ClearLines()
				for i = 1, {LINES} do tt:AddLine("Client " .. i) end
				{SHOW}
				emit({ lines = tt.lines, calls = calls, clears = clears })
				{SHOW}
				emit({ lines = tt.lines, calls = calls, clears = clears })
			"#,
				)
				.replace("{LINES}", &client_lines.to_string()),
			));
			let case = format!("{} with {client_lines} client lines", c.name);
			assert_eq!(initial, json!({ "lines": ["Client 1", "Annotation"], "calls": 1, "clears": 1 }), "{case}");
			let mut lines: Vec<Value> = (1..=client_lines).map(|i| json!(format!("Client {i}"))).collect();
			lines.push(json!("Annotation"));
			let expected = json!({ "lines": lines, "calls": 2, "clears": 2 });
			assert_eq!(rebuilt, expected, "{case}: a clear removed annotations even though the rebuilt line count is not smaller");
			assert_eq!(repeated, expected, "{case}: a repeated callback on the rebuilt tooltip must not add another annotation");
		}
	}
}

#[test]
fn hooks_item_frames_keep_independent_annotation_state_when_one_is_cleared() {
	let [initial, refreshed] = first::<2>(run_bare(
		r#"
		local H, calls = Polestar.Hooks, { game = 0, ref = 0 }
		H.ItemLines("independent-test", function(tt)
			local key = tt == GameTooltip and "game" or "ref"
			calls[key] = calls[key] + 1
			H.AddLine(tt, "Annotation")
		end)
		for _, tt in ipairs({ GameTooltip, ItemRefTooltip }) do
			tt:ClearLines(); tt:AddLine("Client 1")
			lookuprt.showItem(tt, 1234, "item:1234")
			lookuprt.showItem(tt, 1234, "item:1234")
		end
		emit({ game = GameTooltip.lines, ref = ItemRefTooltip.lines, calls = calls })
		GameTooltip:ClearLines(); GameTooltip:AddLine("Replacement client line")
		lookuprt.showItem(GameTooltip, 1234, "item:1234")
		lookuprt.showItem(ItemRefTooltip, 1234, "item:1234")
		emit({ game = GameTooltip.lines, ref = ItemRefTooltip.lines, calls = calls })
	"#,
	));
	assert_eq!(initial, json!({ "game": ["Client 1", "Annotation"], "ref": ["Client 1", "Annotation"], "calls": { "game": 1, "ref": 1 } }));
	assert_eq!(refreshed, json!({ "game": ["Replacement client line", "Annotation"], "ref": ["Client 1", "Annotation"], "calls": { "game": 2, "ref": 1 } }));
}

#[test]
fn hooks_a_reused_tooltip_dispatches_annotations_for_changed_subjects_and_kinds() {
	let out = run_bare(
		r#"
		local H, tt = Polestar.Hooks, GameTooltip
		H.ItemLines("transition-test", function(tip, _, id) H.AddLine(tip, "Item " .. id) end)
		H.ObjectLines("transition-test", function(tip, id) H.AddLine(tip, "Object " .. id) end)
		local function clientLines(n)
			tt:ClearLines()
			for i = 1, n do tt:AddLine("Client " .. i) end
		end
		clientLines(1)
		lookuprt.showItem(tt, 1234, nil); lookuprt.showItem(tt, 1234, nil); emit(tt.lines)
		clientLines(2)
		lookuprt.showItem(tt, 1235, nil); lookuprt.showItem(tt, 1235, nil); emit(tt.lines)
		-- Same numeric key, different annotation kind, on the same frame.
		clientLines(3)
		lookuprt.showObject(tt, { id = 1235 }); lookuprt.showObject(tt, { id = 1235 }); emit(tt.lines)
		clientLines(4)
		lookuprt.showItem(tt, 1235, nil); lookuprt.showItem(tt, 1235, nil); emit(tt.lines)
	"#,
	);
	assert_eq!(
		out,
		vec![
			json!(["Client 1", "Item 1234"]),
			json!(["Client 1", "Client 2", "Item 1235"]),
			json!(["Client 1", "Client 2", "Client 3", "Object 1235"]),
			json!(["Client 1", "Client 2", "Client 3", "Client 4", "Item 1235"]),
		]
	);
}

#[test]
fn hooks_item_lines_once_per_tooltip_show_in_order_errors_isolated_forbidden_and_secret_skipped() {
	let [once, cleared, forbidden, secret, other, item_ref, replaced] = first::<7>(run_with(
		r#"
		local H = Polestar.Hooks
		H.ItemLines("a", function(tt, link, id) H.AddLine(tt, "A " .. id, link and "link" or nil) end)
		H.ItemLines("b", function() error("boom") end)
		H.ItemLines("c", function(tt, link, id) H.AddLine(tt, "C " .. id) end)
		local tt = GameTooltip
		tt:SetOwner(UIParent)
		lookuprt.showItem(tt, 1234, "|cffffffff|Hitem:1234::::::::20:::::|h[Thing]|h|r")
		lookuprt.showItem(tt, 1234, "|cffffffff|Hitem:1234::::::::20:::::|h[Thing]|h|r")
		emit(tt.lines)
		tt:SetOwner(UIParent)
		lookuprt.showItem(tt, 1234, nil)
		emit(tt.lines)
		tt:SetOwner(UIParent); tt.forbidden = true
		lookuprt.showItem(tt, 1234, nil); emit(#tt.lines); tt.forbidden = nil
		tt:SetOwner(UIParent)
		lookuprt.showItem(tt, lookuprt.SECRET, lookuprt.SECRET); emit(#tt.lines)
		local shop = CreateFrame("GameTooltip", "ShoppingTooltip1", UIParent)
		shop.lines = {}; shop.AddLine = GameTooltip.AddLine; shop.NumLines = GameTooltip.NumLines
		lookuprt.showItem(shop, 1234, nil); emit(#shop.lines)
		ItemRefTooltip:SetOwner(UIParent)
		lookuprt.showItem(ItemRefTooltip, 99, nil); emit(ItemRefTooltip.lines)
		H.ItemLines("a", function(tt, link, id) H.AddLine(tt, "A2 " .. id) end)
		H.ItemLines("c", nil)
		tt:SetOwner(UIParent)
		lookuprt.showItem(tt, 5, nil); emit(tt.lines)
	"#,
		&Opts { with_pack: false, ..Default::default() },
	));
	assert_eq!(once, json!(["A 1234 | link", "C 1234"]));
	assert_eq!(cleared, json!(["A 1234", "C 1234"]));
	assert_eq!(forbidden, 0);
	assert_eq!(secret, 0);
	assert_eq!(other, 0);
	assert_eq!(item_ref, json!(["A 99", "C 99"]));
	assert_eq!(replaced, json!(["A2 5"]));
}

#[test]
fn hooks_unit_lines_get_the_unit_token_item_clicks_get_the_item_id() {
	let [unit, clicks] = first::<2>(run_with(
		r#"
		local H = Polestar.Hooks
		local seen = {}
		H.UnitLines("t", function(tt, unit) seen[#seen + 1] = unit; H.AddLine(tt, "U " .. unit) end)
		lookuprt.units.mouseover = { guid = "Player-1-00000042", player = true }
		GameTooltip:SetOwner(UIParent)
		lookuprt.showUnit(GameTooltip, "mouseover")
		lookuprt.showUnit(GameTooltip, "mouseover")
		emit({ seen = seen, lines = GameTooltip.lines })
		local got = {}
		H.ItemClick("t", function(link, id) got[#got + 1] = id end)
		lookuprt.clickItem("|cff1eff00|Hitem:8004::::::::20:::::|h[Boar Tusk]|h|r")
		lookuprt.clickItem("|cffffd000|Henchant:1234|h[Enchant]|h|r")
		lookuprt.clickItem(lookuprt.SECRET)
		emit(got)
	"#,
		&Opts { with_pack: false, ..Default::default() },
	));
	assert_eq!(unit, json!({ "seen": ["mouseover"], "lines": ["U mouseover"] }));
	assert_eq!(clicks, json!([8004]));
}

#[test]
fn hooks_object_lines_get_the_object_id_data_or_guid_and_name_secret_safe() {
	let out = run_with(
		r#"
		local H = Polestar.Hooks
		local seen = {}
		H.ObjectLines("q", function(tt, id, name) seen[#seen + 1] = { id or false, name or false }; H.AddLine(tt, "O " .. tostring(id)) end)
		local function show(data) GameTooltip:SetOwner(UIParent); lookuprt.showObject(GameTooltip, data); return #GameTooltip.lines end
		emit(show({ id = 2843, lines = { { leftText = "Battered Chest" } } }))
		emit(show({ guid = "GameObject-0-4372-0-17-6002-0000123456", lines = { { leftText = "Supply Crate" } } }))
		emit(show({ guid = "Creature-0-4372-0-17-6002-0000123456", lines = { { leftText = "Mailbox" } } }))
		emit(show({ id = lookuprt.SECRET, guid = lookuprt.SECRET, lines = lookuprt.SECRET }))
		GameTooltip.forbidden = true; emit(show({ id = 1 })); GameTooltip.forbidden = nil
		lookuprt.showObject(ItemRefTooltip, { id = 5 })
		emit(seen)
	"#,
		&Opts { with_pack: false, ..Default::default() },
	);
	assert_eq!(Value::Array(out), json!([1, 1, 1, 0, 0, [[2843, "Battered Chest"], [6002, "Supply Crate"], [false, "Mailbox"]]]));
}

// ---------------------------------------------------------------------------
// Spotter, tooltip lines, Alt-click, commands
// ---------------------------------------------------------------------------

const MOUNTED: &str = r#"
lookuprt.units.target = { guid = "Player-1-0000BEEF", player = true }
lookuprt.auras.target = { { spellId = 1243, name = "Fortitude" }, { spellId = 9500, name = "Amber Strider", icon = 132226 } }
"#;

#[test]
fn spotter_a_player_s_mount_from_their_auras_secret_safe() {
	let out = run(&[
		MOUNTED,
		r#"
		local L = Polestar.Lookup
		emit(L.UnitMount("target"))
		lookuprt.auras.target = { { spellId = 9503, name = "Summon Shadowsteed" } }; emit(L.UnitMount("target"))
		lookuprt.auras.target = { { spellId = 7777, name = "Gale" } }; lookuprt.journal[7777] = { id = 55, name = "Swift Gale", icon = 7 }
		emit(L.UnitMount("target"))
		lookuprt.auras.target = { { spellId = lookuprt.SECRET, name = "?" }, { spellId = 9500, name = "Amber Strider" } }; emit(L.UnitMount("target") or false)
		lookuprt.auras.target = { { spellId = 9500, name = "Amber Strider" } }
		lookuprt.auraError = true; emit(L.UnitMount("target") or false); lookuprt.auraError = nil
		lookuprt.units.target.player = false; emit(L.UnitMount("target") or false)
		lookuprt.units.target.player = true; lookuprt.units.target.secretPlayer = true; emit(L.UnitMount("target") or false)
	"#,
	]
	.concat());
	assert_eq!(
		Value::Array(out),
		json!([
			{ "spell": 9500, "item": 8000, "name": "Amber Strider", "icon": 132226 },
			{ "spell": 9503, "name": "Summon Shadowsteed", "class": "WARLOCK" },
			{ "spell": 7777, "name": "Swift Gale", "icon": 7 },
			false, false, false, false,
		])
	);
}

#[test]
fn spotter_mount_spotted_the_unit_tooltip_line_and_polestar_mount() {
	let [spotted, lines, shown, class_mount, nothing, lookup_cmd, off] = first::<7>(run(&[
		MOUNTED,
		r#"
		local got = {}
		Polestar.On("MOUNT_SPOTTED", function(unit, info) got[#got + 1] = { unit, info.item } end)
		local shows = {}
		Polestar.On("SHOW_LOOKUP", function(q, kind, id) shows[#shows + 1] = { q or false, kind or false, id or false } end)
		stub.fire("PLAYER_TARGET_CHANGED")
		emit(got)
		GameTooltip:SetOwner(UIParent); lookuprt.showUnit(GameTooltip, "target"); emit(GameTooltip.lines)
		SlashCmdList.POLESTAR("mount"); emit(shows[#shows])
		lookuprt.auras.target = { { spellId = 9503, name = "Summon Shadowsteed" } }
		SlashCmdList.POLESTAR("mount"); emit(shows[#shows])
		lookuprt.auras.target = {}
		local before = #stub.messages; SlashCmdList.POLESTAR("mount"); emit(stub.messages[#stub.messages])
		SlashCmdList.POLESTAR("lookup boar tusk"); emit(shows[#shows])
		Polestar.Set("lookup.mounts", false)
		lookuprt.auras.target = { { spellId = 9500, name = "Amber Strider" } }
		got = {}; stub.fire("PLAYER_TARGET_CHANGED")
		GameTooltip:SetOwner(UIParent); lookuprt.showUnit(GameTooltip, "target")
		emit({ #got, #GameTooltip.lines })
	"#,
	]
	.concat()));
	assert_eq!(spotted, json!([["target", 8000]]));
	assert_eq!(lines, json!(["Mount: Amber Strider | Vendor \u{b7} Amber Vale", "/pole mount: how to get it"]));
	assert_eq!(shown, json!([false, "mount", 8000]));
	assert_eq!(class_mount, json!(["Summon Shadowsteed", false, false]));
	assert!(is_match(text(&nothing), r"No mount found"));
	assert_eq!(lookup_cmd, json!(["boar tusk", false, false]));
	assert_eq!(off, json!([0, 0]));
}

#[test]
fn item_tooltips_the_best_sources_the_alt_click_hint_and_the_settings() {
	let [strider, peril, world, no_tip, disabled] = first::<5>(run(r#"
		local function show(id)
			GameTooltip:SetOwner(UIParent)
			lookuprt.showItem(GameTooltip, id, "|cffffffff|Hitem:" .. id .. "::::::::20:::::|h[x]|h|r")
			return GameTooltip.lines
		end
		emit(show(8000)); emit(show(8002)); emit(show(8015))
		Polestar.Set("lookup.tooltip", false); emit(#show(8000)); Polestar.Set("lookup.tooltip", true)
		Polestar.Set("lookup.enabled", false); emit(#show(8000))
	"#));
	assert_eq!(strider, json!(["From Mira Saddler | Vendor \u{b7} Amber Vale", "Alt-click: guide me"]));
	assert_eq!(peril, json!(["From Bristle Boar | Drop \u{b7} Amber Vale", "From High Peril | Requires level 30", "Alt-click: guide me"]));
	assert_eq!(world, json!(["From World drop | World drop \u{b7} Level 10-30"]));
	assert_eq!(no_tip, 0);
	assert_eq!(disabled, 0);
}

#[test]
fn alt_click_opens_a_guide_for_the_item_else_the_lookup_window_only_a_plain_alt_left_click() {
	let [opened, shown, shift, right, off] = first::<5>(run(r#"
		local shows = {}
		Polestar.On("SHOW_LOOKUP", function(q, kind, id) shows[#shows + 1] = { q or false, kind or false, id or false } end)
		local function link(id) return "|cffffffff|Hitem:" .. id .. "::::::::20:::::|h[x]|h|r" end
		local function tabs() local t, ids = Polestar.Engine.GetTabs(), {}; for i, x in ipairs(t) do ids[i] = x.guideId end; return ids end
		stub.keys.alt = true
		lookuprt.clickItem(link(8004)); emit(tabs())
		lookuprt.clickItem(link(8015)); emit(shows)
		stub.keys.shift = true; lookuprt.clickItem(link(8009)); stub.keys.shift = false; emit(tabs())
		lookuprt.button = "RightButton"; lookuprt.clickItem(link(8009)); lookuprt.button = "LeftButton"; emit(tabs())
		Polestar.Set("lookup.altClick", false); lookuprt.clickItem(link(8009)); emit(tabs())
	"#));
	assert_eq!(opened, json!(["lookup/item/8004"]));
	assert_eq!(shown, json!([[false, "item", 8015]]));
	assert_eq!(shift, json!(["lookup/item/8004"]));
	assert_eq!(right, json!(["lookup/item/8004"]));
	assert_eq!(off, json!(["lookup/item/8004"]));
}

#[test]
fn options_the_lookup_tab_of_discovery_and_its_defaults() {
	let [controls, defaults] = first::<2>(run_with(
		r#"
		local out = {}
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.page == "Discovery" and spec.tab == "Lookup" then
				for _, c in ipairs(spec.controls) do out[#out + 1] = { key = c.key, kind = c.kind, label = c.label, help = c.help ~= nil } end
			end
		end
		emit(out)
		emit({ Polestar.Get("lookup.enabled"), Polestar.Get("lookup.tooltip"), Polestar.Get("lookup.altClick"), Polestar.Get("lookup.mounts") })
	"#,
		&Opts { files: &["Core/Core.xml", "Theme/Theme.xml", "Lookup/Lookup.xml"], ..Default::default() },
	));
	let keys: Vec<Value> = arr(&controls).iter().map(|c| c["key"].clone()).collect();
	assert_eq!(keys, ["lookup.enabled", "lookup.tooltip", "lookup.altClick", "lookup.mounts"]);
	assert!(arr(&controls).iter().all(|c| c["kind"] == "toggle" && truthy(&c["label"]) && truthy(&c["help"])));
	assert_eq!(defaults, json!([true, true, true, true]));
}
