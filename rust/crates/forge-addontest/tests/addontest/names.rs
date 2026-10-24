//! Game names in the client's language (addon/Polestar/Core/Names.lua and its
//! consumers) on a fake French client with a small Polestar_frFR
//! (forge_addontest::names): the client's own quest and item names first,
//! then the pack's, else English; one server request per name, one redraw
//! when they arrive; an English client loads nothing and reads the guides'
//! English as before.

use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts};
use forge_addontest::names::{names_pack, NamesPack};
use forge_addontest::questdb::{build_db, data_with, QuestDb};
use forge_addontest::{emitted, lua_string, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

fn fr_pack() -> NamesPack {
	names_pack(
		"frFR",
		&[
			("quest", &[(7, "Nettoyer le camp des kobolds"), (33, "Les loups à la frontière"), (176, "Avis de recherche : Lardeur")]),
			("npc", &[(6, "Vermine kobold"), (197, "Maréchal McBride"), (240, "Maréchal Dughan"), (448, "Lardeur")]),
			("object", &[(68, "Avis de recherche")]),
			("item", &[(750, "Viande de loup coriace"), (1528, "Poignée d'avoine")]),
		],
	)
}

// The client's quest and item APIs as the names need them; requests recorded.
const CLIENT: &str = r#"
__asked = { quest = {}, item = {} }
__itemNames = {}
function C_QuestLog.RequestLoadQuestByID(id) table.insert(__asked.quest, id) end
function C_Item.GetItemNameByID(id) return __itemNames[id] end
function C_Item.IsItemDataCachedByID(id) return __itemNames[id] ~= nil end
function C_Item.RequestLoadItemDataByID(id) table.insert(__asked.item, id) end
local w = stub.world
w.addMap(1429, { name = "Forêt d'Elwynn", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
"#;

// Every name kind on one step; NPC 999 and item 9999 have no French name.
const GUIDE_LUA: &str = r#"
Polestar.RegisterGuide({
	id = "test/names", pack = "test", title = "Names", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Goldshire", goals = {
			{ t = "accept", quest = 176, title = "Wanted: Hogger", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48, y = 42 },
			{ t = "kill", quest = 7, title = "Kobold Camp Cleanup", target = "Kobold Vermin", npc = 6, count = 10, oi = 1, map = 1429, x = 47, y = 35 },
			{ t = "collect", quest = 7, title = "Kobold Camp Cleanup", item = 1528, itemName = "Handful of Oats", count = 8, oi = 2, map = 1429, x = 47, y = 35 },
			{ t = "interact", object = 68, objName = "Wanted Poster", map = 1429, x = 48, y = 42 },
			{ t = "talk", npc = 999, npcName = "Nobody Translated", map = 1429, x = 48, y = 42 },
			{ t = "use", item = 9999, itemName = "Untranslated Thing" },
			{ t = "turnin", quest = 33, title = "Wolves Across the Border", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48, y = 42 },
		} },
	},
})
"#;

fn guide() -> String {
	format!("\n{TEST_PACK}\n{TEST_SOURCE}{GUIDE_LUA}")
}

// The French interface file stays out (its "%1$s" formats need the client's
// string.format, which Lua 5.1's lacks): these tests are about the names.
const NO_INTERFACE_FILE: &str = r#"
do
	local load = loadfile
	function loadfile(file)
		if file:match("[/\\]Locales[/\\]%a%a%u%u%.lua$") then return function() end end
		return load(file)
	end
end"#;

struct Opts<'a> {
	locale: Option<&'a str>,
	pack: Option<&'a NamesPack>,
	before: String,
	guide: String,
	stubs: Vec<&'static str>,
	saved: Option<&'a str>,
	script: String,
}

impl Default for Opts<'_> {
	fn default() -> Self {
		Opts { locale: Some("frFR"), pack: None, before: String::new(), guide: String::new(), stubs: vec!["stub_world.lua"], saved: None, script: String::new() }
	}
}

fn locale_lua(locale: Option<&str>) -> String {
	locale.map(|l| format!("function GetLocale() return {} end", lua_string(l))).unwrap_or_default()
}

fn run(o: Opts) -> Vec<Value> {
	let own;
	let pack = match o.pack {
		Some(p) => p,
		None => {
			own = fr_pack();
			&own
		}
	};
	emitted(&RunAddon {
		stubs: o.stubs,
		saved: o.saved.map(|s| vec![("Polestar".into(), s.into())]).unwrap_or_default(),
		before: format!("{}\n{NO_INTERFACE_FILE}\n{}\n{CLIENT}\n{}", locale_lua(o.locale), pack.stub_lua, o.before),
		addons: vec![Addon::name("Polestar")],
		script: format!("{}\nstub.login()\nstub.fire(\"QUEST_LOG_UPDATE\"); stub.advance(0.6)\nN = Polestar.Names\n{}", o.guide, o.script),
		..Default::default()
	})
}

fn s(v: &Value) -> &str {
	text(v)
}

// ---------------------------------------------------------------------------
// Polestar.Names
// ---------------------------------------------------------------------------

#[test]
fn a_french_client_npcs_and_objects_from_the_pack_quests_and_items_from_the_client_first_asked_for_once_when_it_has_none() {
	let out = run(Opts {
		script: r#"
emit({ N.Localised(), N.Npc(448), N.Npc(1) or false, N.Object(68), N.Npc("448") or false, __namesLoads })
stub.world.titles[33] = "Les loups à la frontière (client)"
emit({ N.Quest(33), N.Quest(176), N.Quest(176), N.Quest(5) or false, __asked.quest })
__itemNames[750] = "Viande de loup coriace (client)"
emit({ N.Item(750), N.Item(1528), N.Item(1528), __asked.item, __namesLoads })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!([true, "Lardeur", false, "Avis de recherche", false, 1]));
	assert_eq!(
		out[1],
		json!(["Les loups à la frontière (client)", "Avis de recherche : Lardeur", "Avis de recherche : Lardeur", false, [176, 5]]),
		"the client's title wins; 176 and 5 are asked for once each"
	);
	assert_eq!(out[2], json!(["Viande de loup coriace (client)", "Poignée d'avoine", "Poignée d'avoine", [1528], 1]), "the pack loaded once");
}

#[test]
fn the_asked_names_arriving_redraw_the_guide_window_once_step_updated_a_name_never_asked_for_does_not() {
	let out = run(Opts {
		guide: guide(),
		script: r#"
local fired = 0
Polestar.On("STEP_UPDATED", function() fired = fired + 1 end)
N.Quest(176); N.Item(1528)
stub.fire("QUEST_DATA_LOAD_RESULT", 4242, true)
stub.advance(1)
local unasked = fired
stub.fire("QUEST_DATA_LOAD_RESULT", 176, true)
stub.fire("ITEM_DATA_LOAD_RESULT", 1528, true)
stub.advance(1)
local burst = fired
stub.fire("QUEST_DATA_LOAD_RESULT", 176, true)
stub.advance(1)
emit({ unasked, burst, fired })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!([0, 1, 1]));
}

#[test]
fn in_combat_the_pack_waits_english_meanwhile_and_loads_once_out_of_it_a_pack_for_another_language_changes_nothing() {
	let out = run(Opts {
		script: r#"
stub.inCombat = true
emit({ N.Npc(448) or false, __namesLoads })
stub.inCombat = false
N.AddChunk("deDE", "npc", 448, 448, "\n\n448\tHogger (deDE)\n")
emit({ N.Npc(448), __namesLoads, N.Ready() })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!([false, 0]));
	assert_eq!(out[1], json!(["Lardeur", 1, true]));
}

#[test]
fn an_english_client_loads_no_names_pack_and_asks_the_server_for_nothing() {
	for locale in [None, Some("enGB")] {
		let out = run(Opts {
			locale,
			guide: guide(),
			script: r#"
stub.world.titles[176] = "Wanted: Hogger"
emit({ N.Localised(), N.Quest(176) or false, N.Npc(448) or false, N.Object(68) or false, N.Item(1528) or false, N.Ready(), __namesLoads, #__asked.quest, #__asked.item })"#
				.into(),
			..Default::default()
		});
		assert_eq!(out[0], json!([false, false, false, false, false, true, 0, 0, 0]), "{}", locale.unwrap_or("null"));
	}
}

#[test]
fn a_name_the_client_shows_in_play_target_mouseover_an_npc_or_object_window_is_kept_per_language_and_wins_over_the_pack_s_next_session_too() {
	let stubs = vec!["stub_world.lua", "stub_rares.lua"];
	let out = run(Opts {
		stubs: stubs.clone(),
		script: r#"
local R = stub.rares
R.unit("target", { npc = 448, name = "Lardeur (client)" }); stub.fire("PLAYER_TARGET_CHANGED")
R.unit("mouseover", { npc = 1, name = "Pas dans le pack" }); stub.fire("UPDATE_MOUSEOVER_UNIT")
R.unit("mouseover", { npc = 2, name = "Mon familier", controlled = true }); stub.fire("UPDATE_MOUSEOVER_UNIT")
R.unit("npc", { object = 68, name = "Avis (client)" }); stub.fire("QUEST_DETAIL")
R.unit("target", { npc = 6, name = "Vermine kobold" }); stub.fire("PLAYER_TARGET_CHANGED")
emit({ N.Npc(448), N.Npc(1), N.Npc(2) or false, N.Object(68), N.Cached("npc", 448), N.Get("npc", 1) })
local db = PolestarDB.names.frFR
emit({ npc = db.npc, object = db.object })
for i = 1, 2001 do R.unit("target", { npc = 10000 + i, name = "N" .. i }); N.Learn("target") end
local n = 0
for _ in pairs(db.npc) do n = n + 1 end
emit({ n, N.Npc(10001) or false, N.Npc(12001) })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!(["Lardeur (client)", "Pas dans le pack", false, "Avis (client)", "Lardeur (client)", "Pas dans le pack"]));
	assert_eq!(out[1], json!({ "npc": { "448": "Lardeur (client)", "1": "Pas dans le pack" }, "object": { "68": "Avis (client)" } }), "the pack's own name is not kept");
	let capped = &out[2];
	let kept = capped[0].as_i64().unwrap();
	assert!(kept <= 2000 && kept > 1500, "kept {kept}");
	assert_eq!(json!([capped[1], capped[2]]), json!([false, "N2001"]), "the oldest dropped first");
	let next = run(Opts {
		stubs: stubs.clone(),
		saved: Some(r#"PolestarDB = { schema = 1, settings = {}, names = { frFR = { npc = { [448] = "Lardeur (client)" } }, deDE = { npc = { [6] = "Kobold (deDE)" } } } }"#),
		script: "emit({ N.Npc(448), N.Npc(6) })".into(),
		..Default::default()
	});
	assert_eq!(next[0], json!(["Lardeur (client)", "Vermine kobold"]), "the French name learned last session; another language's ignored");
	let english = run(Opts {
		locale: None,
		stubs,
		script: r#"stub.rares.unit("target", { npc = 448, name = "Hogger" }); stub.fire("PLAYER_TARGET_CHANGED"); emit({ N.Npc(448) or false, PolestarDB.names == nil })"#.into(),
		..Default::default()
	});
	assert_eq!(english[0], json!([false, true]), "an English client keeps nothing");
}

#[test]
fn a_pack_may_add_other_kinds_of_names_read_by_names_get() {
	let out = run(Opts {
		script: r#"N.AddChunk("frFR", "map", 36, 36, "\n\n36\tLes Mortemines\n"); N.AddChunk("deDE", "map", 43, 43, "\n\n43\tx\n"); emit({ N.Get("map", 36), N.Get("map", 43) or false, N.Get("npc", 448), N.Get("nope", 1) or false })"#.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!(["Les Mortemines", false, "Lardeur", false]));
}

#[test]
fn spells_factions_areas_from_the_client_instances_flight_points_and_encounters_from_the_pack_an_instance_s_client_name_only_when_it_is_not_just_the_current_zone() {
	let out = run(Opts {
		before: r#"
C_Spell = { GetSpellName = function(id) return id == 458 and "Cheval bai" or nil end }
function GetFactionInfoByID(id) if id == 72 then return "Hurlevent" end end
C_Map.GetAreaInfo = function(id) return id == 12 and "Forêt d'Elwynn" or nil end
function GetRealZoneText(id) if id == 33 then return "Donjon d'Ombrecroc" end return "Forêt d'Elwynn" end"#
			.into(),
		script: r#"
N.AddChunk("frFR", "faction", 529, 529, "\n\n529\tAube d'argent\n")
N.AddChunk("frFR", "map", 36, 36, "\n\n36\tLes Mortemines\n")
N.AddChunk("frFR", "taxi", 2, 2, "\n\n2\tHurlevent%2C Elwynn\n")
N.AddChunk("frFR", "encounter", 1144, 1144, "\n\n1144\tCercle de la loi\n")
emit({ N.Spell(458), N.Faction(72), N.Faction(529), N.Area(12), N.Instance(36), N.Instance(33), N.Instance(48) or false,
  N.Get("taxi", 2), N.Get("encounter", 1144), N.Get("map", 36), N.Spell(1) or false })"#
			.into(),
		..Default::default()
	});
	assert_eq!(
		out[0],
		json!(["Cheval bai", "Hurlevent", "Aube d'argent", "Forêt d'Elwynn", "Les Mortemines", "Donjon d'Ombrecroc", false, "Hurlevent, Elwynn", "Cercle de la loi", "Les Mortemines", false])
	);
	let english = run(Opts {
		locale: None,
		before: r#"C_Spell = { GetSpellName = function() return "Brown Horse" end }"#.into(),
		script: "emit({ N.Spell(458) or false, N.Area(12) or false })".into(),
		..Default::default()
	});
	assert_eq!(english[0], json!([false, false]));
}

#[test]
fn the_language_folder_is_optional_never_reported_missing_named_when_it_is_from_another_version() {
	let script = "local missing, stale = Polestar.Data.CheckInstall(); emit({ table.concat(missing, \",\"), table.concat(stale, \",\") })";
	// A complete install for the stub's Alliance character: our guides' Alliance part too (format 8).
	let check = |addons: &str| {
		run(Opts {
			before: format!(r#"stub.addons = {{ {{ name = "Polestar" }}, {{ name = "Polestar_Guides" }}, {{ name = "Polestar_Guides_Alliance" }}, {{ name = "Polestar_Codex" }}{addons} }}"#),
			script: script.into(),
			..Default::default()
		})
		.remove(0)
	};
	assert_eq!(check(""), json!(["", ""]));
	assert_eq!(check(r#", { name = "Polestar_frFR" }"#), json!(["", ""]));
	let stale = run(Opts {
		before: "stub.addons = { { name = \"Polestar\" }, { name = \"Polestar_Guides\" }, { name = \"Polestar_Guides_Alliance\" }, { name = \"Polestar_Codex\" }, { name = \"Polestar_frFR\" } }\nstub.addonMeta[\"Polestar_frFR\"] = { Version = \"0.0.1\" }".into(),
		script: script.into(),
		..Default::default()
	});
	assert_eq!(stale[0], json!(["", "Polestar_frFR (0.0.1)"]), "named once: the guide texts share the folder");
}

#[test]
fn the_old_language_folders_left_from_an_older_zip_are_named_by_language_and_never_loaded() {
	let out = run(Opts {
		before: "stub.addons = { { name = \"Polestar\" }, { name = \"Polestar_Guides\" }, { name = \"Polestar_Guides_Alliance\" }, { name = \"Polestar_Guides_Horde\" }, { name = \"Polestar_Codex\" }, { name = \"Polestar_frFR\" }, { name = \"Polestar_Names_frFR\" }, { name = \"Polestar_Guides_deDE\" }, { name = \"Polestar_Names_deDE\" } }".into(),
		script: r#"
local _, _, retired = Polestar.Data.CheckInstall()
local said, asked = {}, {}
for _, m in ipairs(stub.messages) do if m:find("no longer uses", 1, true) then said[#said + 1] = m end end
N.Npc(448)
for name in pairs(stub.addonsLoaded) do if name:find("^Polestar_Names_") or name:find("^Polestar_Guides_%l%l%u%u$") then asked[#asked + 1] = name end end
emit({ retired = table.concat(retired, ","), said = said, loaded = table.concat(asked, ",") })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["retired"], "deDE,frFR");
	assert_eq!(out["said"].as_array().unwrap().len(), 1, "one line at login");
	let said = out["said"][0].as_str().unwrap();
	assert!(said.contains("Polestar_Guides_<language> and Polestar_Names_<language> (deDE, frFR)") && said.contains("delete them"), "{said}");
	assert_eq!(out["loaded"], "", "the old folders are never loaded");
}

// ---------------------------------------------------------------------------
// The guide window (Engine.GetStepView)
// ---------------------------------------------------------------------------

const VIEW: &str = r#"
local v = Polestar.Engine.GetStepView(1)
local out = {}
for i, g in ipairs(v.goals) do out[i] = { g.subject, g.detail or false, g.npcName or false } end
emit(out)"#;

fn col(view: &Value, i: usize) -> Value {
	Value::Array(view.as_array().unwrap().iter().map(|g| g[i].clone()).collect())
}

#[test]
fn a_french_client_the_guide_window_names_quests_npcs_objects_and_items_in_french_the_client_s_quest_title_first_english_where_no_french_name_exists() {
	let view = run(Opts { guide: guide(), before: r#"stub.world.titles[33] = "Les loups à la frontière (client)""#.into(), script: VIEW.into(), ..Default::default() }).remove(0);
	assert_eq!(
		col(&view, 0),
		json!(["Avis de recherche : Lardeur", "Vermine kobold", "Poignée d'avoine", "Avis de recherche", "Nobody Translated", "Untranslated Thing", "Les loups à la frontière (client)"]),
		"French names, the client's quest title first; English where no French name exists"
	);
	let has = |i: usize, name: &str| assert!(s(&view[i][1]).contains(name), "{} names {name}", view[i][1]);
	has(0, "Maréchal Dughan");
	has(1, "Nettoyer le camp des kobolds");
	has(2, "Nettoyer le camp des kobolds");
	has(6, "Maréchal McBride");
	assert_eq!(col(&view, 2), json!(["Maréchal Dughan", false, false, false, "Nobody Translated", false, "Maréchal McBride"]));
}

#[test]
fn an_english_client_keeps_the_guide_s_english_its_quest_title_before_the_client_s() {
	let view = run(Opts { locale: None, guide: guide(), before: r#"stub.world.titles[176] = "Wanted: Hogger (client)""#.into(), script: VIEW.into(), ..Default::default() }).remove(0);
	assert_eq!(col(&view, 0), json!(["Wanted: Hogger", "Kobold Vermin", "Handful of Oats", "Wanted Poster", "Nobody Translated", "Untranslated Thing", "Wolves Across the Border"]));
	assert!(s(&view[0][1]).contains("Marshal Dughan"));
	assert_eq!(view[0][2], "Marshal Dughan");
}

#[test]
fn a_collect_s_compiled_sources_are_named_in_the_client_s_language_by_their_ids_english_where_the_pack_has_no_name_or_the_goal_no_id() {
	let guide = format!(
		"\n{TEST_PACK}\n{TEST_SOURCE}\n{}",
		r#"Polestar.RegisterGuide({
	id = "test/sources", pack = "test", title = "Sources", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Goldshire", goals = {
			{ t = "collect", item = 750, itemName = "Tough Wolf Meat", count = 4, map = 1429, x = 48, y = 42, from = "Kobold Vermin", fromId = 6, fromAlso = "Hogger", fromAlsoId = 448, fromKind = "npc" },
			{ t = "collect", item = 1528, itemName = "Handful of Oats", count = 2, map = 1429, x = 48, y = 42, from = "Wanted Poster", fromId = 68, fromKind = "object" },
			{ t = "collect", item = 750, itemName = "Tough Wolf Meat", count = 2, map = 1429, x = 48, y = 42, from = "Nobody Translated", fromId = 999, fromKind = "npc", fromFaction = "AH" },
			{ t = "collect", item = 750, itemName = "Tough Wolf Meat", count = 2, map = 1429, x = 48, y = 42, from = "Kobold Vermin", fromKind = "npc" },
		} },
	},
})"#
	);
	let script = r#"
local v = Polestar.Engine.GetStepView(1)
local out = {}
for i, g in ipairs(v.goals) do out[i] = g.text end
emit(out)"#;
	let fr = run(Opts { guide: guide.clone(), script: script.into(), ..Default::default() }).remove(0);
	assert!(s(&fr[0]).contains("Vermine kobold") && s(&fr[0]).contains("Lardeur"), "{}", fr[0]);
	assert!(s(&fr[1]).contains("Avis de recherche"), "{}", fr[1]);
	assert!(s(&fr[2]).contains("Nobody Translated"), "{}", fr[2]);
	assert!(s(&fr[3]).contains("Kobold Vermin"), "{}", fr[3]);
	let en = run(Opts { locale: None, guide, script: script.into(), ..Default::default() }).remove(0);
	assert!(s(&en[0]).contains("Kobold Vermin") && s(&en[0]).contains("Hogger"), "{}", en[0]);
	assert!(s(&en[1]).contains("Wanted Poster"), "{}", en[1]);
}

// ---------------------------------------------------------------------------
// The target button, the quest database's names, objective matching
// ---------------------------------------------------------------------------

#[test]
fn the_target_button_s_macro_targets_the_french_name_an_english_client_s_the_english_one() {
	let script = "local B = Polestar.QoL.Buttons; emit(B.TargetMacro(B.TargetNames(), 1))";
	let before = r#"stub.world.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 }, { text = "Handful of Oats: 0/8", required = 8 } })"#;
	assert_eq!(run(Opts { guide: guide(), before: before.into(), script: script.into(), ..Default::default() }), [json!("/cleartarget [nocombat]\n/targetexact Vermine kobold\n/cleartarget [dead]")]);
	assert_eq!(
		run(Opts { locale: None, guide: guide(), before: before.into(), script: script.into(), ..Default::default() }),
		[json!("/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]")]
	);
}

// tests/fixtures/questdb plus quest 9500: 8 Kobold Vermin (6) and 5 Kobold
// Vermin Runts (9500), a name holding the other.
fn quest_db() -> QuestDb {
	let data = data_with(|raw| {
		let npcs = raw.get_mut("npcs.json").unwrap();
		let mut runt = npcs["6"].clone();
		runt["id"] = json!(9500);
		runt["name"] = json!("Kobold Vermin Runt");
		runt["spawns"] = json!({ "1429": { "f": "e", "pts": [[20, 20], [20.4, 20.3]] } });
		npcs["9500"] = runt;
		let quests = raw.get_mut("quests.json").unwrap();
		let mut q = quests["7"].clone();
		q["id"] = json!(9500);
		q["title"] = json!("Quest 9500");
		q["pre"] = json!([]);
		q["objectives"] = json!([{ "type": "kill", "id": 6, "count": 8, "text": "Kobold Vermin" }, { "type": "kill", "id": 9500, "count": 5, "text": "Kobold Vermin Runt" }]);
		quests["9500"] = q;
	});
	build_db(data.path())
}

fn quest_pack() -> NamesPack {
	names_pack(
		"frFR",
		&[
			("quest", &[(60, "Les chandelles kobolds")]),
			("npc", &[(6, "Vermine kobold"), (40, "Mineur kobold"), (9500, "Vermine kobold avorton")]),
			("object", &[(77, "Caisse de chandelles")]),
			("item", &[(772, "Grande chandelle")]),
		],
	)
}

fn quest_run_in(script: &str, locale: Option<&str>) -> Vec<Value> {
	let db = quest_db();
	let pack = quest_pack();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua"],
		before: format!(
			r#"{}
{NO_INTERFACE_FILE}
{}
function C_QuestLog.RequestLoadQuestByID() end
stub.quests.dbFiles = {}
local w = stub.world
w.addMap(1429, {{ name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }})
w.moveTo(1429, 48, 40)
"#,
			locale_lua(locale),
			pack.stub_lua,
			db.lua_files()
		),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), "PolestarDB = { schema = 1, settings = { qol = { mapObjectives = true } } }".into())],
		script: format!(
			"{}{script}",
			r#"
local w, sq, Q = stub.world, stub.quests, Polestar.QuestDB
sq.installPins()
stub.login()
stub.advance(0.3)
local function prog(q, npc)
	for _, o in ipairs(Q._index.npc[npc] or {}) do
		if o.q == q then return o.cur .. "/" .. o.max .. (o.done and " done" or "") end
	end
	return "none"
end
"#
		),
		..Default::default()
	})
}

fn quest_run(script: &str) -> Vec<Value> {
	quest_run_in(script, Some("frFR"))
}

#[test]
fn the_quest_database_names_quests_npcs_and_items_in_french_tooltips_the_target_button_s_droppers() {
	let names = quest_run(
		r#"
emit({ Q.GetQuestTitle(60), Q.EntityName(6), Q.GetObjectiveMobs(60, 1), Q.GetItemDroppers(772)[1].name, Q.GetItem(772).name, Q.GetNpc(6).name, Q.GetQuest(60).title, Q.EntityName(253) })"#,
	)
	.remove(0);
	assert_eq!(
		names,
		json!(["Les chandelles kobolds", "Vermine kobold", ["Vermine kobold", "Mineur kobold"], "Vermine kobold", "Grande chandelle", "Vermine kobold", "Les chandelles kobolds", "William Pestle"])
	);
}

#[test]
fn an_object_s_tooltip_which_names_it_in_french_finds_the_objectives_it_serves() {
	let found = quest_run(
		r#"
w.accept(60, { { text = "Grande chandelle : 0/8", required = 8 } })
stub.advance(0.3)
local fr, en = Q.ObjectivesForObjectName("Caisse de chandelles"), Q.ObjectivesForObjectName("Candle Crate")
emit({ fr and #fr or 0, en and #en or 0 })"#,
	)
	.remove(0);
	assert_eq!(found, json!([1, 0]));
}

#[test]
fn objective_lines_match_their_objectives_by_the_french_names_before_their_order() {
	let lines = "w.accept(9500, { { text = \"Vermine kobold avorton tuée : 1/5\", required = 5, fulfilled = 1 }, { text = \"Vermine kobold tuée : 2/8\", required = 8, fulfilled = 2 } })\nstub.advance(0.3)\nemit({ prog(9500, 6), prog(9500, 9500) })";
	assert_eq!(quest_run(lines)[0], json!(["2/8", "1/5"]), "each line read for its own objective");
	assert_eq!(quest_run_in(lines, None)[0], json!(["1/5", "2/8"]), "English names find nothing in French lines: by order");
}

// ---------------------------------------------------------------------------
// Lookup (Core/Search.lua) on the sample Codex
// ---------------------------------------------------------------------------

const SEARCH: &str = r#"
local function q(text)
	local out = {}
	for _, r in ipairs(Polestar.Search.Query(text)) do out[#out + 1] = r.kind .. ":" .. tostring(r.id) .. ":" .. r.title end
	return table.concat(out, "|")
end
emit(q("lardeur")); emit(q("hogger")); emit(q("foret d'elwynn")); emit(q("elwynn")); emit(q("viande de loup"))
local _, counts = Polestar.Search.Query("hogger")
emit(counts)
emit(__namesLoads)"#;

// A "|"-joined result string as a list; other values as they are.
fn list(v: &Value) -> Value {
	match v {
		Value::String(s) if s.is_empty() => json!([]),
		Value::String(s) => json!(s.split('|').collect::<Vec<_>>()),
		v => v.clone(),
	}
}

#[test]
fn lookup_finds_a_quest_npc_item_or_zone_by_its_french_name_and_by_its_english_one_listed_once_under_its_french_name() {
	let codex = write_codex_pack(&sample_codex(), &CodexOpts::default());
	let out: Vec<Value> = run(Opts { before: codex.stub_lua.clone(), script: SEARCH.into(), ..Default::default() }).iter().map(list).collect();
	assert_eq!(out[0], json!(["npc:448:Lardeur", "quest:176:Avis de recherche : Lardeur"]));
	assert_eq!(out[1], json!(["npc:448:Lardeur", "quest:176:Avis de recherche : Lardeur"]), "the English names still find them");
	assert_eq!(out[2], json!(["zone:1429:Forêt d'Elwynn"]), "accents and apostrophes fold away");
	assert_eq!(out[3], json!(["zone:1429:Forêt d'Elwynn"]), "once, though both names match");
	assert_eq!(out[4], json!(["item:750:Viande de loup coriace"]));
	assert_eq!(out[5], json!({ "npc": 1, "quest": 1 }));
	assert_eq!(out[6], 1);
}

#[test]
fn lookup_s_search_asks_the_server_for_no_quest_or_item_name() {
	let codex = write_codex_pack(&sample_codex(), &CodexOpts::default());
	let out = run(Opts { before: codex.stub_lua.clone(), script: format!("{SEARCH}\nemit({{ #__asked.quest, #__asked.item }})"), ..Default::default() });
	assert_eq!(*out.last().unwrap(), json!([0, 0]));
}

#[test]
fn an_english_client_s_lookup_is_unchanged_and_loads_no_names_pack() {
	let codex = write_codex_pack(&sample_codex(), &CodexOpts::default());
	let out: Vec<Value> = run(Opts { locale: None, before: codex.stub_lua.clone(), script: SEARCH.into(), ..Default::default() }).iter().map(list).collect();
	assert_eq!(out[0], json!([]));
	assert_eq!(out[1], json!(["npc:448:Hogger", "quest:176:Wanted: \"Hogger\""]));
	assert_eq!(out[3], json!(["zone:1429:Elwynn Forest"]));
	assert_eq!(out[5], json!({ "npc": 1, "quest": 1 }));
	assert_eq!(out[6], 0);
}

#[test]
fn a_russian_client_s_lookup_finds_a_capitalised_name_from_a_lower_case_query_ё_as_е_a_chinese_name_matches_as_typed_œ_folds_to_oe() {
	let codex = write_codex_pack(&sample_codex(), &CodexOpts::default());
	let ru = names_pack("ruRU", &[("npc", &[(448, "Хоггер")]), ("item", &[(750, "Жёсткое волчье мясо")])]);
	let out = run(Opts {
		locale: Some("ruRU"),
		pack: Some(&ru),
		before: codex.stub_lua.clone(),
		script: r#"
local function q(text)
	local out = {}
	for _, r in ipairs(Polestar.Search.Query(text, { kinds = { npc = true, item = true } })) do out[#out + 1] = r.kind .. ":" .. tostring(r.id) .. ":" .. r.title end
	return table.concat(out, "|")
end
emit(q("хоггер")); emit(q("жесткое")); emit(Polestar.Search.Fold("Œuvre cœur"))"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], "npc:448:Хоггер");
	assert_eq!(out[1], "item:750:Жёсткое волчье мясо");
	assert_eq!(out[2], " oeuvre coeur");
	let zh = names_pack("zhCN", &[("npc", &[(448, "霍格")])]);
	let cjk = run(Opts {
		locale: Some("zhCN"),
		pack: Some(&zh),
		before: codex.stub_lua.clone(),
		script: r#"
local out = {}
for _, r in ipairs(Polestar.Search.Query("霍格", { kinds = { npc = true } })) do out[#out + 1] = r.kind .. ":" .. tostring(r.id) end
emit(table.concat(out, "|"))"#
			.into(),
		..Default::default()
	});
	assert_eq!(cjk[0], "npc:448");
}

#[test]
fn a_names_pack_refused_in_combat_loads_when_combat_ends_without_another_ask_and_redraws_the_guide_window_once() {
	let out = run(Opts {
		guide: guide(),
		before: "stub.inCombat = true".into(),
		script: r#"
local fired, names = 0, 0
Polestar.On("STEP_UPDATED", function() fired = fired + 1 end)
Polestar.On("NAMES_LOADED", function() names = names + 1 end)
local during = N.Npc(448) or false
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(1)
local loads = __namesLoads
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(1)
emit({ during, loads, N.Ready(), fired, names, __namesLoads })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!([false, 1, true, 1, 1, 1]));
}

#[test]
fn the_quest_tracker_reads_the_objective_lines_by_the_french_names_once_a_pack_refused_in_combat_arrives() {
	let out = quest_run(
		r#"
local before = __namesLoads
stub.inCombat = true
w.accept(9500, { { text = "Vermine kobold avorton tuée : 1/5", required = 5, fulfilled = 1 }, { text = "Vermine kobold tuée : 2/8", required = 8, fulfilled = 2 } })
stub.advance(0.3)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(0.6)
w.progress(9500, 2, 3)
stub.advance(0.3)
emit({ before, prog(9500, 6), prog(9500, 9500) })"#,
	);
	assert_eq!(out[0], json!([0, "3/8", "1/5"]));
}
