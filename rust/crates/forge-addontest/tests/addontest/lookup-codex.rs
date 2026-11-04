//! The built Codex pack (addon/Polestar_Codex, local: `forge data codex`) end to end:
//! searching a mount's name finds it, it has ranked sources, the curated guide that collects it is the one
//! Lookup opens, and the guide Lookup builds from its best source plays to the end in the real engine
//! (tools/lib/playtest.js). Skips when the pack has not been built.

use forge_addontest::playtest::SIMULATE;
use forge_addontest::run::{addons_dir, join, root, toc_entries};
use forge_addontest::{emitted, is_match, lua_value, truthy, Addon, RunAddon};
use serde_json::{json, Value};
use std::path::PathBuf;

fn pack_dir() -> PathBuf {
	addons_dir().join("Polestar_Codex")
}

fn toc() -> PathBuf {
	pack_dir().join("Polestar_Codex.toc")
}

fn frames() -> PathBuf {
	root().join("data").join("forever").join("map-frames.json")
}

/// Whether the test skips (the pack or the map frames are missing), printing why.
fn skip() -> bool {
	let s = !toc().exists() || !frames().exists();
	if s {
		eprintln!("skipped: Codex pack not built (forge data codex)");
	}
	s
}

fn pack_lua() -> String {
	let pack = pack_dir();
	let text = std::fs::read_to_string(toc()).unwrap();
	let files: Vec<String> = text.lines().map(|l| l.trim()).filter(|l| !l.is_empty() && !l.starts_with('#')).map(|f| serde_json::to_string(&join(&pack, f).to_string_lossy()).unwrap()).collect();
	let list = format!("{{ {} }}", files.join(", "));
	format!(
		"do
  local __files, __load = {list}, C_AddOns.LoadAddOn
  function C_AddOns.LoadAddOn(name)
    if name ~= \"Polestar_Codex\" then return __load(name) end
    if not stub.addonsLoaded[name] then
      for _, f in ipairs(__files) do dofile(f) end
      stub.addonsLoaded[name] = true
    end
    return true, nil
  end
end"
	)
}

fn numeric_keys(v: &Value) -> Vec<String> {
	let mut keys: Vec<String> = v.as_object().map(|o| o.keys().cloned().collect()).unwrap_or_default();
	keys.sort_by(|a, b| match (a.parse::<f64>(), b.parse::<f64>()) {
		(Ok(x), Ok(y)) => x.partial_cmp(&y).unwrap_or(std::cmp::Ordering::Equal),
		_ => a.cmp(b),
	});
	keys
}

// Every map the client knows, in its live frame (Forever's own bounds where they differ from Era's);
// Era-frame coordinates convert through the frames the pack registers.
fn maps_lua() -> String {
	let all: Value = serde_json::from_str(&std::fs::read_to_string(frames()).unwrap()).unwrap();
	let era = &all["era"];
	let forever = if all["forever"].is_object() { all["forever"].clone() } else { json!({}) };
	let mut ids = numeric_keys(era);
	for k in numeric_keys(&forever) {
		if !ids.contains(&k) {
			ids.push(k);
		}
	}
	ids.iter()
		.map(|id| {
			let f = if truthy(&forever[id.as_str()]) { &forever[id.as_str()] } else { &era[id.as_str()] };
			format!("w.addMap({id}, {{ name = \"\", c = {}, left = {}, right = {}, top = {}, bottom = {} }})", f["c"], f["left"], f["right"], f["top"], f["bottom"])
		})
		.collect::<Vec<_>>()
		.join("\n")
}

fn lv(s: &str) -> String {
	lua_value(&json!(s))
}

fn at_lua(at: &[f64]) -> String {
	at.iter().map(|n| n.to_string()).collect::<Vec<_>>().join(", ")
}

/// The pack, the maps and the character (race, class, faction are Lua expressions).
fn before(race: &str, cls: &str, faction: &str, level: u32, at: &[f64]) -> String {
	format!(
		"{}\nlocal w = stub.world\n{}\nw.race, w.raceName, w.class, w.className, w.faction = {race}, {race}, {cls}, {cls}, {faction}\nw.level = {level}\nw.moveTo({})",
		pack_lua(),
		maps_lua(),
		at_lua(at)
	)
}

/// `String(v)` / `${v}` of an emitted value.
fn js_string(v: &Value) -> String {
	match v {
		Value::String(s) => s.clone(),
		Value::Array(a) => a.iter().map(js_string).collect::<Vec<_>>().join(","),
		Value::Null => String::new(),
		_ => v.to_string(),
	}
}

fn strs(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(js_string).collect()).unwrap_or_default()
}

fn nums(v: &Value) -> Vec<i64> {
	v.as_array().map(|a| a.iter().filter_map(|x| x.as_i64()).collect()).unwrap_or_default()
}

const LOOKUP: &str = r#"
stub.login()
Polestar.Set("behavior.autoNextGuide", false)
local results = Polestar.Search.Query(@QUERY@)
local hit
for _, r in ipairs(results) do
	if r.kind == @KIND@ then hit = r; break end
end
local rows = hit and Polestar.Lookup.Sources(hit.kind, hit.id) or {}
local types = {}
for i, r in ipairs(rows) do types[i] = r.type .. (r.available and "" or ("!" .. tostring(r.why))) end
local mounts = {}
for _, r in ipairs(results) do
	if r.kind == "mount" then mounts[#mounts + 1] = { id = r.id, status = r.status or false, curated = r.curated or false } end
end
emit({ id = hit and hit.id or false, title = hit and hit.title or false, kinds = #results, types = types, mounts = mounts,
	curated = hit and Polestar.Lookup.CuratedGuide(hit.kind, hit.id) or false })
local best
for i, r in ipairs(rows) do if r.available and r.guideable then best = i; break end end
local gid, why = Polestar.Lookup.Guide(hit.kind, hit.id, best or 1)
local g = gid and Polestar.Guides.Get(gid)
emit({ id = gid or false, why = why or false, steps = g and #g.steps or 0 })
stub.advance(0.6)
@SIMULATE@"#;

// query: the search text; kind_of: the result kind to pick; the rest: the character.
fn look_up(query: &str, kind_of: &str, race: &str, faction: &str, cls: &str, level: u32, at: &[f64]) -> (Value, Value, Value) {
	let mut out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: before(&lv(race), &lv(cls), &lv(faction), level, at),
		// The pack and the player's faction's part (Polestar loads it on demand in game).
		addons: vec!["Polestar".into(), "Polestar_Guides".into(), Addon::name(&format!("Polestar_Guides_{faction}"))],
		script: LOOKUP.replace("@QUERY@", &lv(query)).replace("@KIND@", &lv(kind_of)).replace("@SIMULATE@", SIMULATE),
		..Default::default()
	});
	let out3 = out.remove(2);
	let built = out.remove(1);
	let found = out.remove(0);
	(found, built, out3)
}

fn assert_plays((found, built, out): (Value, Value, Value)) -> Value {
	assert!(truthy(&built["id"]), "a guide was built ({})", js_string(&built["why"]));
	assert!(built["steps"].as_f64().unwrap() > 0.0);
	assert!(!truthy(&out["stuck"]), "stuck: {}", out["stuck"]);
	assert_eq!(out["done"], true);
	assert_eq!(out["missing"], json!({}), "every accept and turn-in has a location");
	found
}

#[test]
fn striped_frostsaber_finds_the_night_elf_saber_sold_in_darnassus_its_curated_guide_and_the_built_guide_plays() {
	if skip() {
		return;
	}
	let found = assert_plays(look_up("Striped Frostsaber", "mount", "NightElf", "Alliance", "HUNTER", 40, &[1438.0, 55.5, 50.1]));
	assert_eq!(found["id"], 8631);
	assert!(strs(&found["types"]).iter().any(|t| t == "vendor"), "an available vendor source: {}", js_string(&found["types"]));
	assert!(is_match(&js_string(&found["curated"]), r"^forever/collectibles/mounts/"));
}

#[test]
fn deathcharger_finds_the_deathcharger_s_reins_with_its_stratholme_drop_and_the_built_guide_plays() {
	if skip() {
		return;
	}
	let found = assert_plays(look_up("Deathcharger", "mount", "Scourge", "Horde", "WARRIOR", 60, &[1423.0, 50.0, 50.0]));
	assert_eq!(found["id"], 13335);
	assert!(strs(&found["types"]).iter().any(|t| t == "drop"), "an available drop source: {}", js_string(&found["types"]));
	assert!(is_match(&js_string(&found["curated"]), r"^forever/collectibles/mounts/neutral/deathcharger"));
}

#[test]
fn frostsaber_the_sabers_on_sale_and_covered_by_a_guide_come_first_the_retired_reins_of_the_frostsaber_last() {
	if skip() {
		return;
	}
	let found = assert_plays(look_up("Frostsaber", "mount", "NightElf", "Alliance", "HUNTER", 60, &[1438.0, 55.5, 50.1]));
	assert_ne!(found["id"], 12302);
	assert_eq!(found["mounts"][0]["curated"], true, "first mount is guide-backed: {}", serde_json::to_string(&found["mounts"]).unwrap());
	let mounts = found["mounts"].as_array().unwrap();
	let retired = mounts.iter().position(|m| m["id"] == 12302);
	assert!(retired.is_some(), "still listed, for reference");
	let retired = retired.unwrap_or_default();
	assert_eq!(mounts[retired]["status"], "retired");
	assert!(mounts[retired..].iter().all(|m| truthy(&m["status"])), "nothing obtainable ranks below it");
}

// tools/lib/codex/pack's releaseRefusal has no Rust port in forge_data::codex::pack; its check that the pack
// would ship is approximated by what a shipped pack holds: every file its TOC lists, and LICENSE-DATA.txt.
fn release_refusal(dir: &std::path::Path) -> Option<String> {
	if !dir.join("LICENSE-DATA.txt").exists() {
		return Some("no LICENSE-DATA.txt".into());
	}
	match toc_entries(dir) {
		Err(e) => Some(e),
		Ok(entries) => entries.iter().find(|f| !join(dir, f).exists()).map(|f| format!("{f} is missing")),
	}
}

const CODEX_SCRIPT: &str = r#"
stub.login()
local C = Polestar.Codex
local loaded = C.Load()
local function first(q, kind)
	for _, r in ipairs(Polestar.Search.Query(q)) do if r.kind == kind then return r.id end end
	return false
end
local D = Polestar.Dungeons
D.Load()
local list, bossed, quested = 0, 0, 0
for _, d in ipairs(D.List()) do
	list = list + 1
	if d.bosses > 0 then bossed = bossed + 1 end
	if d.quests.A + d.quests.H > 0 then quested = quested + 1 end
end
local wc = {}
for _, b in ipairs(D.Bosses("wailing-caverns")) do wc[#wc + 1] = b.name end
local rares = 0
C.Each("rare", function() rares = rares + 1 end)
local thuros = C.Npc(61)
local dm = C.Instance("deadmines")
emit({ loaded = loaded, item = first("Linen Cloth", "item"), mount = first("Deathcharger", "mount"), npc = first("Lelanai", "npc"),
	list = list, bossed = bossed, quested = quested, wc = wc, wcQuests = #D.Quests("wailing-caverns"),
	rares = rares, thuros = { thuros.rare and true or false, #thuros.spawns > 0 },
	dm = { #dm.bosses, dm.entrance and dm.entrance.map or false, #dm.bosses[#dm.bosses].items } })"#;

#[test]
fn the_built_codex_is_release_safe_and_in_game_lookup_finds_items_mounts_and_npcs_dungeons_lists_dungeons_with_bosses_and_quests_rares_lists_rares() {
	if skip() {
		return;
	}
	assert_eq!(release_refusal(&pack_dir()), None, "pack would ship it");
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: pack_lua(), addons: vec!["Polestar".into()], script: CODEX_SCRIPT.into(), ..Default::default() }).remove(0);
	assert_eq!(out["loaded"], true);
	assert_eq!(out["item"], 2589);
	assert_eq!(out["mount"], 13335);
	assert_eq!(out["npc"], 4730);
	assert!(out["list"].as_f64().unwrap() >= 25.0, "dungeons listed: {}", out["list"]);
	assert!(out["bossed"].as_f64().unwrap() >= 25.0 && out["quested"].as_f64().unwrap() >= 25.0, "with bosses {}, with quests {}", out["bossed"], out["quested"]);
	assert!(out["wc"].as_array().unwrap().iter().any(|n| n == "Mutanus the Devourer"), "{}", strs(&out["wc"]).join(", "));
	assert!(out["wcQuests"].as_f64().unwrap() > 0.0);
	assert!(out["rares"].as_f64().unwrap() >= 300.0, "rares: {}", out["rares"]);
	assert_eq!(out["thuros"], json!([true, true]));
	assert!(out["dm"][0].as_f64().unwrap() >= 8.0, "Deadmines bosses: {}", out["dm"][0]);
	assert_eq!(out["dm"][1], 1436, "the Deadmines entrance is in Westfall");
	assert!(out["dm"][2].as_f64().unwrap() > 0.0, "VanCleef's loot");
}

const KP_SCRIPT: &str = r#"
stub.login()
local D = Polestar.Dungeons
D.Load()
local plan = D.PickupPlan("deadmines")
local take = {}
for i, t in ipairs(plan and plan.take or {}) do take[i] = t.quest.id end
local pages = {}
for _, d in ipairs(D.List()) do
	for _, q in ipairs(D.Quests(d.key)) do pages[#pages + 1] = d.key .. ":" .. q.id end
end
emit({ take = take, pages = pages })"#;

#[test]
fn kp_s_report_the_deadmines_pick_up_guide_of_a_level_21_gnome_rogue_in_lakeshire_has_no_darkmoon_faire_quest_and_no_dungeon_page_carries_one_or_a_quest_tied_by_a_stray_drop() {
	if skip() {
		return;
	}
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: before("\"Gnome\"", "\"ROGUE\"", "\"Alliance\"", 21, &[1433.0, 26.5, 45.0]),
		addons: vec!["Polestar".into()],
		script: KP_SCRIPT.into(),
		..Default::default()
	})
	.remove(0);
	let take = nums(&out["take"]);
	assert!(!take.is_empty(), "the Deadmines quests are offered");
	assert!(!take.contains(&7894), "no Copper Modulator (Rinling, the Faire): {}", js_string(&out["take"]));
	// The Faire's quests: pfQuest's game events 4 and 5 (Chronos, Rinling, Yebb Neblegear, Kerri Hicks, Morja, Gelvas Grimegate).
	let quests: Value = serde_json::from_str(&std::fs::read_to_string(root().join("data").join("forever").join("quests.json")).unwrap()).unwrap();
	let pages = strs(&out["pages"]);
	let faire: Vec<&String> = pages
		.iter()
		.filter(|p| {
			let id = p.split(':').nth(1).unwrap_or("");
			let event = &quests[id]["event"];
			*event == 4 || *event == 5
		})
		.collect();
	assert_eq!(faire, Vec::<&String>::new(), "no Darkmoon Faire quest on a dungeon page");
	let stray = ["naxxramas:8921", "zulgurub:8921", "blackwing-lair:9121", "blackwing-lair:9122"];
	let found: Vec<&String> = pages.iter().filter(|p| stray.contains(&p.as_str())).collect();
	assert_eq!(found, Vec::<&String>::new(), "The Ectoplasmic Distiller (Mux, Tanaris) and The Dread Citadel (Dosantos, Light's Hope) are on no raid page through a boss's stray essence or crystal");
}

const TABETHA: &str = r#"
stub.login()
local D = Polestar.Dungeons
D.Load()
local giver
for _, t in ipairs(D.PickupPlan("zulfarrak").take) do
	if t.quest.id == 2861 then giver = t.giver end
end
local target = D.GiverTarget("zulfarrak", 2861)
local npc = giver and Polestar.Codex.Npc(giver.id)
emit({ giver = giver and giver.name or false, map = giver and giver.map or false, side = npc and npc.faction or false, target = target and target.name or false })"#;

// Tabetha's Task (2861) for Zul'Farrak: the mage trainers of both sides give it; the page names the first,
// Anastasia Hartwell in the Undercity.
fn tabetha(race: &str, faction: &str, at: &[f64]) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: before(&lv(race), "\"MAGE\"", &lv(faction), 44, at), addons: vec!["Polestar".into()], script: TABETHA.into(), ..Default::default() })
		.remove(0)
}

#[test]
fn tabetha_s_task_a_level_44_alliance_mage_in_stormwind_is_sent_to_an_alliance_mage_trainer_in_stormwind_a_horde_one_in_the_undercity_to_anastasia_hartwell() {
	if skip() {
		return;
	}
	let human = tabetha("Human", "Alliance", &[1453.0, 50.0, 60.0]);
	assert_eq!(human["side"], "A", "an Alliance giver: {}", serde_json::to_string(&human).unwrap());
	assert_eq!(human["map"], 1453, "in Stormwind");
	assert_eq!(human["target"], human["giver"], "the quest card's link goes there too");
	let undead = tabetha("Scourge", "Horde", &[1458.0, 66.0, 44.0]);
	let mut u = undead.clone();
	u["map"] = json!(undead["map"] == 1420 || undead["map"] == 1458);
	assert_eq!(u, json!({ "giver": "Anastasia Hartwell", "map": true, "side": "H", "target": "Anastasia Hartwell" }), "in the Undercity (the Codex also places her on its Tirisfal Glades map)");
}

const ATTUNE: &str = r#"
stub.login()
Polestar.Set("behavior.autoNextGuide", false)
local D = Polestar.Dungeons
D.Load()
local a
for _, x in ipairs(D.Attunements(@KEY@)) do if x.id == @ID@ then a = x end end
local st = D.AttunementState(a)
local quests = 0
for _, e in ipairs(st.steps) do
	if e.step.kind == "quest" and e.state ~= "na" and e.state ~= "skip" and e.state ~= "done" then quests = quests + 1 end
end
local def, why = D.AttuneGuide(@KEY@, @ID@)
local accepts, bare = 0, {}
for _, s in ipairs(def and def.steps or {}) do
	local quest = false
	for _, g in ipairs(s.goals) do if g.t == "accept" then accepts = accepts + 1; quest = true end end
	if not quest and #s.goals == 1 and s.goals[1].t == "note" then bare[#bare + 1] = s.title end
end
emit({ quests = quests, accepts = accepts, bare = table.concat(bare, ", "), why = why or false })
if def then
	D.Attune(@KEY@, @ID@)
	stub.advance(0.6)
	SIM_GUIDE = Polestar.Engine.GetGuide()
	@SCRIPT@
end"#;

struct Who {
	race: &'static str,
	faction: &'static str,
	at: [f64; 3],
}

// "Guide me through it" for an attunement or key: the guide (Dungeons.AttuneGuide) as a character of
// `faction` at `level` in their capital, and `script` (SIMULATE) playing it.
fn attune_guide(r: &str, who: &Who, level: u32, script: &str) -> Vec<Value> {
	let (key, id) = r.split_once(':').unwrap();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: before(&lv(who.race), "\"WARRIOR\"", &lv(who.faction), level, &who.at),
		addons: vec!["Polestar".into()],
		script: ATTUNE.replace("@KEY@", &lv(key)).replace("@ID@", &lv(id)).replace("@SCRIPT@", script),
		..Default::default()
	})
}

const ORGRIMMAR: Who = Who { race: "Orc", faction: "Horde", at: [1454.0, 50.0, 50.0] };
const STORMWIND: Who = Who { race: "Human", faction: "Alliance", at: [1453.0, 50.0, 60.0] };

#[test]
fn every_attunement_and_key_the_guide_has_a_step_per_quest_still_to_do_none_a_bare_note_and_plays_to_the_end_for_both_sides() {
	if skip() {
		return;
	}
	let refs: [(&str, &[&Who]); 11] = [
		("molten-core:core", &[&ORGRIMMAR, &STORMWIND]),
		("molten-core:aqual", &[&ORGRIMMAR, &STORMWIND]),
		("onyxias-lair:drakefire-h", &[&ORGRIMMAR]),
		("onyxias-lair:drakefire-a", &[&STORMWIND]),
		("blackwing-lair:blackhand", &[&ORGRIMMAR, &STORMWIND]),
		("naxxramas:dread-citadel", &[&ORGRIMMAR, &STORMWIND]),
		("scholomance:skeleton-key-h", &[&ORGRIMMAR]),
		("scholomance:skeleton-key-a", &[&STORMWIND]),
		("blackrock-depths:shadowforge-key", &[&ORGRIMMAR, &STORMWIND]),
		("city-of-dalaran:sewer-key", &[&ORGRIMMAR]),
		("scarlet-monastery:scarlet-key", &[&ORGRIMMAR, &STORMWIND]),
	];
	for (r, who) in refs {
		for p in who {
			let out = attune_guide(r, p, 60, SIMULATE);
			let (count, out) = (&out[0], &out[1]);
			let as_ = format!("{r} ({})", p.faction);
			assert_eq!(count["why"], false, "{as_}: a guide");
			assert_eq!(count["accepts"], count["quests"], "{as_}: one accept per quest left");
			assert_eq!(count["bare"], "", "{as_}: no quest is a bare \"First do the quest\" note");
			assert!(!truthy(&out["stuck"]), "{as_} stuck: {}", out["stuck"]);
			assert_eq!(out["done"], true, "{as_}");
			assert_eq!(out["visited"], out["steps"], "{as_}: the engine stops at every step, none passed as done");
		}
	}
	let other = attune_guide("onyxias-lair:drakefire-a", &ORGRIMMAR, 60, SIMULATE);
	assert_eq!(other[0], json!({ "quests": 0, "accepts": 0, "bare": "", "why": "nothing" }), "the Alliance amulet's guide is not a Horde character's");
}

const MC_VIEW: &str = r#"
local E = Polestar.Engine
local v = E.GetStepView(1)
local goals = {}
for i, g in ipairs(v.goals) do goals[i] = { t = g.t, text = g.text, detail = g.detail or false, at = g.map and { g.map, g.x, g.y } or false } end
local brd = D.Get("blackrock-depths").entrance
emit({ step = E.GetStepIndex(), count = E.GetStepCount(), title = v.title, note = v.note or false, goals = goals, brd = { brd.map, brd.x, brd.y } })"#;

#[test]
fn the_maintainer_s_level_20_undead_in_the_undercity_molten_core_s_guide_sends_him_to_the_core_fragment_inside_blackrock_depths_and_its_accept_says_from_level_55() {
	if skip() {
		return;
	}
	let out = attune_guide("molten-core:core", &Who { race: "Scourge", faction: "Horde", at: [1458.0, 66.0, 44.0] }, 20, MC_VIEW);
	let (count, view) = (&out[0], &out[1]);
	assert_eq!(json!([count["quests"], count["accepts"]]), json!([1, 1]), "one quest: Attunement to the Core (7848, the Forever id)");
	assert_eq!(view["step"], 1);
	assert_eq!(view["count"], 2, "the quest, then the way in");
	let ts: Vec<Value> = view["goals"].as_array().unwrap().iter().map(|g| g["t"].clone()).collect();
	assert_eq!(json!(ts), json!(["accept", "collect", "turnin"]));
	assert_eq!(view["goals"][0]["detail"], "from Lothos Riftwaker, from level 55");
	assert_eq!(view["goals"][1]["text"], "Collect Core Fragment");
	assert_eq!(view["goals"][1]["at"], view["brd"], "at the Blackrock Depths entrance");
	assert_eq!(view["note"], "Core Fragment: inside Blackrock Depths.");
}

const DUNGEON_QUESTS: &str = r#"
stub.login()
local D = Polestar.Dungeons
D.Load()
local ids = function(list, f) local o = {} for i, x in ipairs(list or {}) do o[i] = f(x) end return o end
local plan = D.PickupPlan(@KEY@)
local def = D.PickupGuide(@KEY@)
local accepts = {}
for _, s in ipairs(def and def.steps or {}) do
	for _, g in ipairs(s.goals) do if g.t == "accept" then accepts[#accepts + 1] = g.quest end end
end
local hand = D.HandinPlan(@KEY@)
emit({ take = ids(plan and plan.take, function(t) return t.quest.id end), accepts = accepts,
	hand = ids(hand and hand.hand, function(h) return h.quest.id end),
	follow = hand and ids(D.HandinFollowUps(hand), function(f) return f.rec.id end) or {} })"#;

#[derive(Clone)]
struct Dq {
	race: &'static str,
	faction: &'static str,
	cls: &'static str,
	level: u32,
	at: [f64; 3],
	ready: Vec<i64>,
}

// A dungeon's pick-up plan and guide (the quests taken, the accepts) and its hand-in plan with the follow-ups
// those turn-ins open, for a character of race/faction/cls at level, standing at, carrying ready (done, in
// the log).
fn dungeon_quests(key: &str, who: &Dq) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: before(&lv(who.race), &lv(who.cls), &lv(who.faction), who.level, &who.at) + "\nfor _, q in ipairs(" + &lua_value(&json!(who.ready)) + ") do w.onQuest(q, {}) end",
		addons: vec!["Polestar".into()],
		script: DUNGEON_QUESTS.replace("@KEY@", &lv(key)),
		..Default::default()
	})
	.remove(0)
}

// Issue #50 (Arachnit): Unending Torment (97288-97292, Horde) starts from the Abominable Head The Baron drops in
// the Ruins of Lordaeron; Master Apothecary Faranell gives the rest of it in the Undercity once the head is hers
// (Forever's Series box and quest texts; forever-db/corrections).
#[test]
fn arachnit_s_report_the_ruins_of_lordaeron_pick_up_guide_of_a_level_23_orc_warrior_takes_no_unending_torment_before_the_run_after_it_the_abominable_head_goes_to_faranell_who_gives_the_next_one() {
	if skip() {
		return;
	}
	const TORMENT: [i64; 5] = [97288, 97289, 97290, 97291, 97292];
	let orc = Dq { race: "Orc", faction: "Horde", cls: "WARRIOR", level: 23, at: [1458.0, 66.0, 44.0], ready: vec![] };
	let before = dungeon_quests("ruins-of-lordaeron", &orc);
	let take = nums(&before["take"]);
	let accepts = nums(&before["accepts"]);
	assert!(!take.is_empty(), "the Horde quests of the Ruins of Lordaeron are offered");
	assert_eq!(take.iter().filter(|id| TORMENT.contains(id)).collect::<Vec<_>>(), Vec::<&i64>::new(), "no Unending Torment to pick up: {}", js_string(&before["take"]));
	assert_eq!(accepts.iter().filter(|id| TORMENT.contains(id)).collect::<Vec<_>>(), Vec::<&i64>::new(), "no Unending Torment accept in the guide: {}", js_string(&before["accepts"]));
	let after = dungeon_quests("ruins-of-lordaeron", &Dq { ready: vec![97288], ..orc.clone() });
	assert_eq!(after["hand"], json!([97288]), "the Abominable Head is handed in after the run");
	assert_eq!(after["follow"], json!([97289]), "Faranell then gives the next Unending Torment");
}

// The same shape in the Excavation Site (Wetlands): each side's Titan Relic drops inside and its quest's ender
// gives the next one (Earthen Echo 98823 after Elder Knowledge 95664, Prehistoric Prism 98824 after Lost Relic
// Carry 95810).
#[test]
fn the_excavation_site_pick_up_guide_takes_neither_titan_relic_follow_up_before_the_run_after_it_each_relic_s_ender_gives_it() {
	if skip() {
		return;
	}
	let tauren = Dq { race: "Tauren", faction: "Horde", cls: "WARRIOR", level: 26, at: [1456.0, 50.0, 50.0], ready: vec![] };
	let dwarf = Dq { race: "Dwarf", faction: "Alliance", cls: "WARRIOR", level: 26, at: [1455.0, 50.0, 50.0], ready: vec![] };
	for (who, item, next) in [(tauren, 95664, 98823), (dwarf, 95810, 98824)] {
		let before = dungeon_quests("excavation-site-wetlands", &who);
		let take = nums(&before["take"]);
		let accepts = nums(&before["accepts"]);
		assert!(!take.is_empty(), "the {} quests of the Excavation Site are offered", who.faction);
		assert!(!take.contains(&next) && !accepts.contains(&next), "{next} is not picked up before the run: {}", js_string(&before["take"]));
		let after = dungeon_quests("excavation-site-wetlands", &Dq { ready: vec![item], ..who.clone() });
		assert_eq!(after["hand"], json!([item]));
		assert_eq!(after["follow"], json!([next]));
	}
}
