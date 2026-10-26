//! Attunements and keys: the builder (tools/lib/codex/attunements.js through the journal), the cited goal table
//! (data/codex/attunements.json), the runtime's states and guide (addon/Polestar/Dungeons/Attune.lua) in the real
//! engine over the stub world, and the Attunement tab (UI/Dungeons.lua) over the fake engine of
//! tests/lua/stub_ui.lua.
//!
//! The synthetic fixture tests/fixtures/codex/dungeons.json (inputs.attunementTable):
//!   Wailing Caverns  fang          an attunement, one of two goals: Horde
//!                                  90001 Rite of the Serpent (Nara Wildmane, Thunder Bluff,
//!                                  to Tonga Runetotem) > 90002 The Serpent's Trial >
//!                                  90003 Fang of the Serpent (Friendly with Thunder Bluff);
//!                                  Alliance 90004 Fang of the Serpent (Gryan Stoutmantle)
//!   The Deadmines    ironclad-a    an Alliance key: 90006 > 90005, which rewards the Ironclad Key
//!                    smelting-key  a key Edwin VanCleef drops inside
//!   (and `missing`, whose goal no Codex quest has: dropped with a warning)

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::dsl::plain;
use forge_addontest::run::root;
use forge_addontest::{emitted, fake_locale, is_match, lua_value, text, truthy, Addon, RunAddon};
use forge_data::codex::attune::attunements_of;
use forge_data::codex::client::{Corpse, InstanceMap};
use forge_data::codex::is_web_citation;
use forge_data::codex::journal::{build_journal, emit_journal, Codex, JournalInputs};
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};
use std::collections::HashSet;

static NULL: Value = Value::Null;

/// The fixture's codex and inputs.
fn parts() -> (Value, Value) {
	let f = fixture("dungeons.json");
	(f["codex"].clone(), f["inputs"].clone())
}

fn to_v(v: &Value) -> V {
	parse_json(&v.to_string()).unwrap()
}

/// A JSON object as V, an empty object when absent.
fn part(v: &Value) -> V {
	if v.is_null() {
		to_v(&json!({}))
	} else {
		to_v(v)
	}
}

/// `(v || [])` items.
fn list(v: &Value) -> Vec<Value> {
	v.as_array().cloned().unwrap_or_default()
}

fn nums(v: &Value) -> Vec<f64> {
	list(v).iter().filter_map(Value::as_f64).collect()
}

/// The first of `paths` (key paths into `v`) that holds a value.
fn pick<'a>(v: &'a Value, paths: &[&[&str]]) -> &'a Value {
	for p in paths {
		let mut x = v;
		for k in *p {
			x = &x[*k];
		}
		if !x.is_null() {
			return x;
		}
	}
	&NULL
}

fn maps_of(v: &Value) -> Vec<InstanceMap> {
	list(v)
		.iter()
		.map(|m| InstanceMap {
			id: m["id"].as_f64().unwrap_or(0.0),
			name: text(&m["name"]).to_string(),
			raid: m["raid"].as_bool().unwrap_or(false),
			players: m["players"].as_f64(),
			area: m["area"].as_f64(),
			areas: nums(&m["areas"]),
			inner: nums(&m["inner"]),
			zones: nums(&m["zones"]),
			corpse: m["corpse"].as_object().map(|_| Corpse { c: m["corpse"]["c"].as_f64().unwrap_or(0.0), x: m["corpse"]["x"].as_f64().unwrap_or(0.0), y: m["corpse"]["y"].as_f64().unwrap_or(0.0) }),
		})
		.collect()
}

/// buildJournal(inputs, codex) -> (journal, warnings).
fn journal(codex: &Value, inputs: &Value) -> (V, Vec<String>) {
	let maps = maps_of(pick(inputs, &[&["client", "instanceMaps"], &["maps"], &["instanceMaps"]]));
	let frames = part(pick(inputs, &[&["forever", "mapFrames", "forever"], &["mapFrames", "forever"], &["forever", "mapFrames"], &["frames"]]));
	let fv_quests = part(pick(inputs, &[&["forever", "quests"], &["fvQuests"]]));
	let fv_objects = part(pick(inputs, &[&["forever", "objects"], &["fvObjects"]]));
	let fv_zones = part(pick(inputs, &[&["forever", "zones"], &["fvZones"]]));
	let fv_dungeons = part(pick(inputs, &[&["forever", "dungeons"]]));
	let journal_quests: Vec<V> = list(&inputs["journalQuests"]).iter().map(to_v).collect();
	let table = part(&inputs["attunementTable"]);
	let c = Codex {
		instances: part(&codex["instances"]),
		quests: part(&codex["quests"]),
		npcs: part(&codex["npcs"]),
		items: part(&codex["items"]),
		objects: part(&codex["objects"]),
		factions: part(&codex["factions"]),
		zones: part(&codex["zones"]),
	};
	build_journal(
		&JournalInputs {
			maps: &maps,
			frames: &frames,
			fv_quests: &fv_quests,
			fv_objects: &fv_objects,
			fv_zones: &fv_zones,
			fv_dungeons: &fv_dungeons,
			journal_quests: &journal_quests,
			attunement_table: &table,
		},
		&c,
	)
}

/// writeCodexPack(codex, { extraFiles: emitJournal(buildJournal(inputs, codex)) }).
fn pack_of(codex: &Value, inputs: &Value) -> CodexPack {
	let (j, _) = journal(codex, inputs);
	write_codex_pack(codex, &CodexOpts { extra_files: vec![("Dungeons1.lua".into(), emit_journal(&j))], ..Default::default() })
}

/// attunementsOf(codex, { table }) -> (byKey as a JSON object, warnings).
fn attunes(codex: &Value, table: &Value) -> (Value, Vec<String>) {
	let (by, warnings) = attunements_of(&to_v(codex), &to_v(table));
	let mut m = serde_json::Map::new();
	for (k, l) in by {
		m.insert(k, Value::Array(l.iter().map(plain).collect()));
	}
	(Value::Object(m), warnings)
}

/// data/codex/attunements.json (loadAttunementTable).
fn attunement_table() -> Value {
	serde_json::from_str(&std::fs::read_to_string(root().join("data/codex/attunements.json")).unwrap()).unwrap()
}

fn shape(a: &Value) -> String {
	list(&a["steps"])
		.iter()
		.map(|s| if s["kind"] == "quest" { format!("{}{}", s["id"], if truthy(&s["goal"]) { "*" } else { "" }) } else { format!("{}:{}", text(&s["kind"]), s["item"]["id"]) })
		.collect::<Vec<_>>()
		.join(" > ")
}

fn is_int(v: &Value) -> bool {
	v.as_f64().is_some_and(|f| f.is_finite() && f.fract() == 0.0)
}

fn cited(s: &Value) -> bool {
	match s.as_str() {
		Some(s) => is_match(s, r"^https://"),
		None => is_web_citation(&to_v(s)),
	}
}

/// /Attune(?!ment)/i.test(s)
fn names_attune(s: &str) -> bool {
	let l = s.to_ascii_lowercase();
	l.match_indices("attune").any(|(i, _)| !l[i + 6..].starts_with("ment"))
}

// ---------------------------------------------------------------------------
// Builder and table
// ---------------------------------------------------------------------------

#[test]
fn the_builder_walks_each_goal_back_through_pre_and_preany_adds_an_item_goal_s_sources_and_warns_of_goals_the_codex_lacks() {
	let (codex, inputs) = parts();
	let (by, warnings) = attunes(&codex, &inputs["attunementTable"]);
	assert_eq!(warnings, vec!["missing: goal quest 99999 is not in the Codex".to_string()]);
	let mut keys: Vec<&String> = by.as_object().unwrap().keys().collect();
	keys.sort();
	assert_eq!(keys, vec!["deadmines", "wailing-caverns"]);
	let fang = &by["wailing-caverns"][0];
	assert_eq!(shape(fang), "90001 > 90002 > 90003* > 90004*");
	assert_eq!(json!([fang["kind"], fang["need"], fang["faction"], fang["any"], fang["level"], fang["item"]]), json!(["attunement", "each", null, true, 17, null]));
	let trial = &fang["steps"][1];
	assert_eq!(json!([trial["after"], trial["afterAny"], trial["start"]["name"], trial["finish"]["name"]]), json!([[], [90001], "Tonga Runetotem", "Tonga Runetotem"]));
	assert_eq!(fang["steps"][2]["rep"], json!({ "faction": 81, "name": "Thunder Bluff", "standing": 5 }));
	let (ironclad, smelting) = (&by["deadmines"][0], &by["deadmines"][1]);
	assert_eq!(shape(ironclad), "90006 > 90005*");
	assert_eq!(json!([ironclad["faction"], ironclad["item"], ironclad["steps"][1]["after"]]), json!(["A", { "id": 90010, "name": "Ironclad Key", "quality": 1 }, [90006]]));
	assert_eq!(shape(smelting), "drop:90011");
	assert_eq!(json!([smelting["steps"][0]["npc"]["name"], smelting["steps"][0]["chance"], smelting["steps"][0]["instance"], smelting["level"]]), json!(["Edwin VanCleef", 100, "deadmines", null]));
}

#[test]
fn the_journal_carries_the_attunements_on_their_pages_counts_them_and_the_pack_file_writes_them_with_a_per_side_summary() {
	let (codex, inputs) = parts();
	let (j, warnings) = journal(&codex, &inputs);
	let jp = plain(&j);
	assert_eq!(jp["meta"]["counts"]["attunements"], 3);
	assert_eq!(warnings, vec!["missing: goal quest 99999 is not in the Codex".to_string()]);
	assert!(jp["dungeons"]["blackmaw-hold"]["attunement"].is_null());
	let file = emit_journal(&j);
	assert!(is_match(&file, r"deadmines=\{[^\n]*attune=\{A=2,H=1\}"));
	assert!(is_match(&file, r#"\["wailing-caverns"\]=\{[^\n]*attune=\{A=1,H=1\}"#));
	assert!(is_match(&file, r"attunement=\{\{"));
	assert_eq!(attunes(&json!({}), &inputs["attunementTable"]).1.len(), 0, "no instance, no page, no warning");
}

#[test]
fn the_goal_table_every_entry_cites_public_sources_names_a_goal_or_an_item_and_nothing_comes_from_attune() {
	let t = attunement_table();
	let mut ids: HashSet<String> = HashSet::new();
	for a in list(&t["attunements"]) {
		let js = a.to_string();
		assert!(truthy(&a["key"]) && truthy(&a["id"]) && truthy(&a["name"]), "{js}");
		let id = text(&a["id"]);
		assert!(!ids.contains(id), "duplicate {id}");
		ids.insert(id.to_string());
		assert!(["attunement", "key", "item"].contains(&text(&a["kind"])), "{id}");
		assert!(["each", "one"].contains(&text(&a["need"])), "{id}");
		let goal = list(&a["goal"]);
		assert!(goal.iter().all(is_int) && (!goal.is_empty() || is_int(&a["item"])), "{id}");
		let sources = list(&a["sources"]);
		assert!(!sources.is_empty() && sources.iter().all(cited), "{id}");
		if let Some(links) = a["links"].as_object() {
			for (q, l) in links {
				assert!(is_match(q, r"^\d+$") && list(&l["pre"]).iter().all(is_int) && cited(&l["source"]), "{id} link {q}");
			}
		}
		assert!(!names_attune(&js), "{id} names Attune");
	}
	for r in list(&t["removed"]) {
		assert!(truthy(&r["why"]) && !list(&r["sources"]).is_empty(), "{}", r["id"]);
	}
	for e in list(&t["inside"]) {
		let js = e.to_string();
		assert!(["npc", "object"].contains(&text(&e["kind"])) && is_int(&e["id"]) && truthy(&e["name"]) && truthy(&e["instance"]), "{js}");
		let sources = list(&e["sources"]);
		assert!(!sources.is_empty() && sources.iter().all(|s| is_web_citation(&to_v(s)) && s["edition"] == "forever"), "{} {}", text(&e["kind"]), e["id"]);
		assert!(!names_attune(&js), "{} {} names Attune", text(&e["kind"]), e["id"]);
	}
}

#[test]
fn with_the_local_codex_the_onyxia_blackwing_lair_naxxramas_and_dalaran_chains_from_our_quest_data_and_the_cited_links() {
	forge_addontest::needs!("codex/quests.json", "codex/items.json", "codex/npcs.json", "codex/objects.json", "codex/factions.json", "codex/instances.json");
	let dir = root().join("data/forever/codex");
	let read = |n: &str| -> Value { serde_json::from_str(&std::fs::read_to_string(dir.join(format!("{n}.json"))).unwrap()).unwrap() };
	let real = json!({
		"quests": read("quests"),
		"items": read("items"),
		"npcs": read("npcs"),
		"objects": read("objects"),
		"factions": read("factions"),
		"instances": read("instances"),
	});
	let table = attunement_table();
	let (by, warnings) = attunes(&real, &table);
	assert_eq!(warnings, Vec::<String>::new());
	let get = |key: &str, id: &str| -> Value { by[key].as_array().unwrap().iter().find(|a| a["id"] == id).unwrap().clone() };
	assert_eq!(shape(&get("onyxias-lair", "drakefire-h")), "4903 > 4941 > 4974 > 6566 > 6567 > 6568 > 6569 > 6570 > 6582 > 6583 > 6584 > 6585 > 6601 > 6602*");
	assert_eq!(get("onyxias-lair", "drakefire-h")["steps"][11]["after"], json!([6582, 6583, 6584]), "the three Tests of Skulls before Axtroz");
	assert_eq!(shape(&get("city-of-dalaran", "sewer-key")), "544 > 545 > 93680 > 92434 > 96984*");
	assert_eq!(shape(&get("blackwing-lair", "blackhand")), "drop:18987 > 7761*", "the Quartermaster drops the letter that starts it");
	assert_eq!(shape(&get("naxxramas", "dread-citadel")), "9121* > 9122* > 9123*");
	assert!(by["blackrock-spire"].is_null(), "Forever removed the Seal of Ascension");
	// Every cited `inside` place is one a chain meets, of an NPC or object that still has no spawn and no Codex
	// instance.
	let mut used: HashSet<String> = HashSet::new();
	for l in by.as_object().unwrap().values() {
		for a in list(l) {
			for e in list(&a["inside"]) {
				used.insert(format!("{}:{}:{}", text(&e["kind"]), e["id"], text(&e["instance"])));
			}
		}
	}
	for e in list(&table["inside"]) {
		assert!(used.contains(&format!("{}:{}:{}", text(&e["kind"]), e["id"], text(&e["instance"]))), "{} is in no chain", text(&e["name"]));
		let records = if e["kind"] == "npc" { &real["npcs"] } else { &real["objects"] };
		let rec = &records[e["id"].to_string()];
		assert!(truthy(rec) && list(&rec["spawns"]).is_empty() && !truthy(&rec["instance"]), "{}: the Codex places it now", text(&e["name"]));
	}
	assert_eq!(get("molten-core", "core")["inside"], json!([{ "kind": "object", "id": 179553, "instance": "blackrock-depths" }]), "the Core Fragment, by the Molten Core portal in Blackrock Depths");
}

fn quests_of(a: &Value) -> Vec<i64> {
	list(&a["steps"]).iter().filter(|s| s["kind"] == "quest").filter_map(|s| s["id"].as_i64()).collect()
}

#[test]
fn auditreport_compares_our_chains_with_attune_s_by_their_quests() {
	// forge_data has no port of auditReport (tools/lib/codex/attunements.js): this checks what the report compares
	// with the closest exposed function, our chains (attunements_of) against the same fake Attune's steps by
	// their quests, each assertion standing for a line of the report.
	let (codex, inputs) = parts();
	let attune = json!({
		"meta": { "version": "test" },
		"attunes": [
			{ "id": "1", "name": "Wailing Caverns", "group": "RAIDS", "faction": "Horde", "steps": [{ "id": 1, "type": "Quest", "ref": 90001 }, { "id": 2, "type": "Quest", "ref": 90003 }, { "id": 3, "type": "Quest", "ref": 77777 }] },
			{ "id": "2", "name": "Something else", "group": "MISC", "faction": "Both", "steps": [{ "id": 1, "type": "Quest", "ref": 88888 }] },
			{ "id": "3", "name": "Dungeon quests", "group": "DUNGEONS", "faction": "Both", "steps": [] },
		],
	});
	let (by, _) = attunes(&codex, &inputs["attunementTable"]);
	let ours: Vec<Value> = by.as_object().unwrap().values().flat_map(list).collect();
	let fang = by["wailing-caverns"].as_array().unwrap().iter().find(|a| a["id"] == "fang").unwrap();
	let fang_q = quests_of(fang);
	let wc: Vec<i64> = list(&attune["attunes"][0]["steps"]).iter().filter_map(|s| s["ref"].as_i64()).collect();
	let shared: Vec<i64> = wc.iter().copied().filter(|q| fang_q.contains(q)).collect();
	assert_eq!(shared, vec![90001, 90003], "| Wailing Caverns (RAIDS) | Horde | Wailing Caverns: Fang of the Serpent | 2 |");
	let only_attune: Vec<i64> = wc.iter().copied().filter(|q| !fang_q.contains(q)).collect();
	assert_eq!(only_attune, vec![77777]);
	assert!(codex["quests"]["77777"].is_null(), "- Only Attune: 77777: not in our Codex");
	assert!(fang_q.contains(&90002) && !wc.contains(&90002), "- Only ours: The Serpent's Trial (90002)");
	assert_eq!(codex["quests"]["90002"]["title"], "The Serpent's Trial");
	let goal = &fang["steps"][2];
	let before: Vec<i64> = [list(&goal["after"]), list(&goal["afterAny"])].concat().iter().filter_map(Value::as_i64).collect();
	assert!(before.contains(&90002), "a prerequisite of Fang of the Serpent (90003).");
	assert!(!ours.iter().any(|a| quests_of(a).contains(&88888)), "No attunement of ours matches");
	assert!(list(&attune["attunes"]).iter().any(|a| a["group"] == "DUNGEONS"), "dungeon quest groups are the dungeon audit's");
	assert!(list(&by["deadmines"]).iter().any(|a| a["item"]["name"] == "Ironclad Key"), "## Ours only: The Deadmines: Ironclad Key");
	assert!(list(&attunement_table()["removed"]).iter().any(|r| r.to_string().contains("Seal of Ascension")), "## Removed in Forever\n\n- Seal of Ascension");
}

// ---------------------------------------------------------------------------
// Runtime: states and the guide, in the real engine
// ---------------------------------------------------------------------------

fn maps_lua(codex: &Value) -> String {
	let frames = codex["frames"].as_object().unwrap();
	let mut ids: Vec<&String> = frames.keys().collect();
	ids.sort_by(|a, b| a.parse::<f64>().unwrap_or(0.0).total_cmp(&b.parse::<f64>().unwrap_or(0.0)));
	ids.iter()
		.map(|id| {
			let f = &frames[*id];
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

const LUA: &str = r#"
local D = Polestar.Dungeons
local function att(key, id) for _, a in ipairs(D.Attunements(key)) do if a.id == id then return a end end end
local function states(key, id)
	local st = D.AttunementState(att(key, id))
	local out = {}
	for i, e in ipairs(st.steps) do out[i] = e.state end
	return { states = out, done = st.done, owned = st.owned or false, goalDone = st.goalDone, next = st.next or false, left = st.left }
end
local function describe(g)
	local out = {}
	for i, s in ipairs(g and g.steps or {}) do
		local verbs = {}
		for j, goal in ipairs(s.goals) do verbs[j] = goal.t .. (goal.quest and (":" .. goal.quest) or goal.item and (":" .. goal.item) or "") end
		out[i] = { title = s.title, goals = table.concat(verbs, " ") }
	end
	return out
end
"#;

const UI_FILES: [&str; 6] = ["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml", "UI/UI.xml"];

const UI_PRELUDE: &str = r#"uistub.install()
stub.login()
uistub.player.level, uistub.player.race, uistub.player.class, uistub.player.faction = 18, "Tauren", "WARRIOR", "Horde"
local done, log = {}, {}
Polestar.Compat.IsQuestCompleted = function(id) return done[id] or false end
Polestar.Compat.IsOnQuest = function(id) return log[id] or false end
Polestar.Compat.IsQuestReadyForTurnIn = function() return false end
local DS = Polestar.UI.DungeonsSection
local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
local function rows()
	local out = {}
	for _, r in ipairs(DS.attSteps) do if r:IsShown() then out[#out + 1] = { plain(r.Text:GetText()), plain(r.Sub:GetText()), r.psPoint and true or false } end end
	return out
end
local function tabs()
	local out = {}
	for _, t in ipairs(PolestarPicker.tabButtons) do if t:IsShown() then out[#out + 1] = t.Label:GetText() end end
	return out
end
"#;

/// The fixture and its pack (the JS file's `before`).
struct Fx {
	codex: Value,
	inputs: Value,
	pack: CodexPack,
}

impl Fx {
	fn new() -> Fx {
		let (codex, inputs) = parts();
		let pack = pack_of(&codex, &inputs);
		Fx { codex, inputs, pack }
	}

	fn run(&self, pk: &CodexPack, script: &str, faction: &str, race: &str) -> Vec<Value> {
		let (level, at) = (18, [1413, 50, 40]);
		let q = |s: &str| serde_json::to_string(s).unwrap();
		let before = format!(
			"{}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = {level}, {}, {}, {}\nw.class, w.className = \"WARRIOR\", \"WARRIOR\"\nw.moveTo({})\nw.complete({})",
			pk.stub_lua,
			maps_lua(&self.codex),
			q(race),
			q(race),
			q(faction),
			at.map(|n| n.to_string()).join(", "),
			lua_value(&json!([]))
		);
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua"],
			before,
			addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml"])],
			login: true,
			script: format!("{LUA}\n{script}"),
			..Default::default()
		})
	}

	fn horde(&self, script: &str) -> Vec<Value> {
		self.run(&self.pack, script, "Horde", "Tauren")
	}

	fn run_ui(&self, script: &str, locale: &str) -> Vec<Value> {
		emitted(&RunAddon {
			stubs: vec!["stub_ui.lua"],
			before: format!("{}\n{locale}", self.pack.stub_lua),
			addons: vec![Addon::files("Polestar", &UI_FILES)],
			script: UI_PRELUDE.to_string() + script,
			..Default::default()
		})
	}
}

#[test]
fn states_a_horde_character_walks_the_serpent_chain_the_standing_gates_the_last_quest_the_alliance_goal_is_not_theirs_and_done_settles_it() {
	let f = Fx::new();
	let out = f.horde(
		r#"
emit(states("wailing-caverns", "fang"))
stub.world.complete({ 90001, 90002 })
emit(states("wailing-caverns", "fang"))
stub.world.setRep(81, "Thunder Bluff", 5)
emit(states("wailing-caverns", "fang"))
stub.world.complete({ 90003 })
emit(states("wailing-caverns", "fang"))"#,
	);
	let (fresh, gated, friendly, finished) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(*fresh, json!({ "states": ["open", "locked", "locked", "na"], "done": false, "owned": false, "goalDone": false, "next": 1, "left": 3 }));
	assert_eq!(gated["states"], json!(["done", "done", "rep", "na"]), "Friendly with Thunder Bluff first");
	assert_eq!(json!([friendly["states"], friendly["next"]]), json!([["done", "done", "open", "na"], 3]));
	assert_eq!(json!([finished["states"], finished["done"], finished["goalDone"], finished["left"]]), json!([["done", "done", "done", "na"], true, true, 0]));
}

#[test]
fn states_an_alliance_character_takes_the_other_goal_a_key_is_done_once_owned_its_chain_done_without_it_says_so_a_dropped_key_wants_its_drop() {
	let f = Fx::new();
	let out = f.run(
		&f.pack,
		r#"
emit(states("wailing-caverns", "fang"))
emit(states("deadmines", "ironclad-a"))
stub.world.complete({ 90006, 90005 })
emit(states("deadmines", "ironclad-a"))
stub.world.addItem(90010)
emit(states("deadmines", "ironclad-a"))
emit(states("deadmines", "smelting-key"))
stub.world.addItem(90011)
emit(states("deadmines", "smelting-key"))"#,
		"Alliance",
		"Human",
	);
	let (fang, before, lost, owned, smelting, dropped) = (&out[0], &out[1], &out[2], &out[3], &out[4], &out[5]);
	assert_eq!(fang["states"], json!(["na", "na", "na", "open"]));
	assert_eq!(before["states"], json!(["open", "locked"]));
	assert_eq!(json!([lost["done"], lost["goalDone"], lost["owned"]]), json!([false, true, false]), "the chain is behind, the key is not in the bags");
	assert_eq!(json!([owned["done"], owned["owned"]]), json!([true, true]));
	assert_eq!(json!([smelting["states"], smelting["done"]]), json!([["open"], false]));
	assert_eq!(json!([dropped["states"], dropped["done"]]), json!([["done"], true]));
}

#[test]
fn the_guide_walks_what_is_left_in_order_and_ends_at_the_entrance_it_opens_in_a_tab_as_lookup_attune_key_id_nothing_left_builds_none() {
	let f = Fx::new();
	let out = f.horde(
		r#"
emit(describe(D.AttuneGuide("wailing-caverns", "fang")))
stub.world.complete({ 90001 })
local def = D.AttuneGuide("wailing-caverns", "fang")
local last = def.steps[#def.steps]
emit({ title = def.title, steps = describe(def), goto = { last.goals[2].map, last.goals[2].x, last.goals[2].y, last.goals[2].text }, note = last.goals[1].text })
local gid = D.Attune("wailing-caverns", "fang")
local tabs = {}
for i, t in ipairs(Polestar.Engine.GetTabs()) do tabs[i] = t.guideId end
emit({ gid = gid, tabs = tabs })
stub.world.complete({ 90002, 90003 })
local none, why = D.AttuneGuide("wailing-caverns", "fang")
emit({ none = none == nil, why = why })"#,
	);
	let (fresh, later, opened, finished) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(
		*fresh,
		json!([
			{ "title": "Rite of the Serpent", "goals": "accept:90001 turnin:90001" },
			{ "title": "The Serpent's Trial", "goals": "accept:90002 collect:90002 turnin:90002" },
			{ "title": "Fang of the Serpent", "goals": "accept:90003 turnin:90003" },
			{ "title": "Wailing Caverns", "goals": "note goto" },
		]),
		"the Alliance goal is not in a Horde guide"
	);
	assert_eq!(later["title"], "Wailing Caverns: Fang of the Serpent");
	let titles: Vec<Value> = list(&later["steps"]).iter().map(|s| s["title"].clone()).collect();
	assert_eq!(json!(titles), json!(["The Serpent's Trial", "Fang of the Serpent", "Wailing Caverns"]));
	assert_eq!(later["goto"], json!([1413, 46, 36.4, "Enter Wailing Caverns"]));
	assert_eq!(later["note"], "Lets you take the serpent's path.");
	assert_eq!(*opened, json!({ "gid": "lookup/attune/wailing-caverns:fang", "tabs": ["lookup/attune/wailing-caverns:fang"] }));
	assert_eq!(*finished, json!({ "none": true, "why": "done" }));
}

#[test]
fn a_dropped_key_s_guide_collects_it_from_its_npc_at_the_instance_s_entrance_owned_there_is_nothing_to_do() {
	let f = Fx::new();
	let out = f.run(
		&f.pack,
		r#"
local def = D.AttuneGuide("deadmines", "smelting-key")
local g = def.steps[1].goals[1]
emit({ steps = describe(def), at = { g.map, g.x, g.y, g.npcName }, note = def.steps[1].goals[2].text })
stub.world.addItem(90011)
local none, why = D.AttuneGuide("deadmines", "smelting-key")
emit({ none = none == nil, why = why })"#,
		"Alliance",
		"Human",
	);
	let (guide, owned) = (&out[0], &out[1]);
	assert_eq!(
		guide["steps"],
		json!([
			{ "title": "Smelting Key", "goals": "collect:90011 note" },
			{ "title": "The Deadmines", "goals": "note goto" },
		])
	);
	assert_eq!(guide["at"], json!([1436, 42.5, 71.7, "Edwin VanCleef"]));
	assert_eq!(guide["note"], "Edwin VanCleef drops it inside The Deadmines.");
	assert_eq!(*owned, json!({ "none": true, "why": "done" }));
}

// The serpent's heart: Tonga sends you into the caverns to the Deviate Keeper, who has no spawn; the table's
// cited `inside` places him and the scale pile there, the Codex places Kresh. Above the level 18 character's
// level.
fn heart_fixture(codex: &Value, inputs: &Value) -> (Value, Value) {
	let mut c = codex.clone();
	let quest = |id: i64, title: &str, start: i64, end: i64, objectives: Value, pre: Value| {
		json!({ "id": id, "title": title, "level": 26, "minLevel": 25, "faction": null, "races": null, "classes": null,
			"start": { "npc": [start], "object": [], "item": [] }, "end": { "npc": [end], "object": [] }, "objectives": objectives, "pre": pre, "preAny": [], "rewards": [], "choices": [] })
	};
	c["npcs"]["90040"] =
		json!({ "id": 90040, "name": "Deviate Keeper", "level": 22, "levelMax": null, "faction": null, "rare": false, "elite": false, "boss": false, "instance": null, "roles": [], "spawns": [] });
	c["objects"]["90050"] = json!({ "id": 90050, "name": "Glowing Scale Pile", "treasure": false, "spawns": [] });
	c["items"]["90031"] =
		json!({ "id": 90031, "name": "Shimmering Scale", "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": [{ "type": "object", "object": 90050, "chance": 100 }] });
	c["quests"]["90030"] = quest(
		90030,
		"Into the Caverns",
		3448,
		90040,
		json!([{ "type": "kill", "id": 3653, "count": 1, "text": "Kresh" }, { "type": "item", "id": 90031, "count": 1, "text": "Shimmering Scale" }]),
		json!([]),
	);
	c["quests"]["90032"] = quest(90032, "Heart of the Serpent", 90040, 3448, json!([]), json!([90030]));
	let mut table = inputs["attunementTable"].clone();
	table["attunements"]
		.as_array_mut()
		.unwrap()
		.push(json!({ "key": "wailing-caverns", "id": "heart", "name": "Heart of the Serpent", "kind": "attunement", "need": "each", "goal": [90032], "note": "Opens the heart." }));
	table["inside"] = json!([
		{ "kind": "npc", "id": 90040, "name": "Deviate Keeper", "instance": "wailing-caverns", "sources": ["synthetic"] },
		{ "kind": "object", "id": 90050, "name": "Glowing Scale Pile", "instance": "wailing-caverns", "sources": ["synthetic"] },
		{ "kind": "npc", "id": 90041, "name": "Not in the chain", "instance": "wailing-caverns", "sources": ["synthetic"] },
	]);
	let mut inp = inputs.clone();
	inp["attunementTable"] = table;
	(c, inp)
}

#[test]
fn a_quest_whose_turn_in_targets_or_chest_are_inside_an_instance_stays_whole_in_the_guide_at_the_entrance_and_the_engine_walks_every_quest_an_accept_above_the_level_says_from_which() {
	let f = Fx::new();
	let (hc, hi) = heart_fixture(&f.codex, &f.inputs);
	let (by, _) = attunes(&hc, &hi["attunementTable"]);
	let find = |id: &str| by["wailing-caverns"].as_array().unwrap().iter().find(|a| a["id"] == id).unwrap().clone();
	assert_eq!(
		find("heart")["inside"],
		json!([
			{ "kind": "npc", "id": 90040, "instance": "wailing-caverns" },
			{ "kind": "object", "id": 90050, "instance": "wailing-caverns" },
		]),
		"only the table's entries the chain meets"
	);
	assert_eq!(find("fang")["inside"], Value::Null);
	let pk = pack_of(&hc, &hi);
	let out = f.run(
		&pk,
		r#"
local def = D.AttuneGuide("wailing-caverns", "heart")
local at = {}
for i, s in ipairs(def.steps) do
	local g = {}
	for j, goal in ipairs(s.goals) do g[j] = goal.map and table.concat({ goal.map, goal.x, goal.y }, " ") or false end
	at[i] = g
end
local notes = {}
for i, s in ipairs(def.steps) do notes[i] = s.note or false end
emit({ steps = describe(def), at = at, notes = notes })
local E = Polestar.Engine
D.Attune("wailing-caverns", "heart")
stub.advance(0.6)
local walk = {}
local function look()
	local v = E.GetStepView(1)
	walk[#walk + 1] = { step = E.GetStepIndex() or false, accept = v.goals[1].detail }
end
look()
stub.world.setLevel(25)
stub.advance(0.6)
look()
stub.world.accept(90030, { { required = 1 }, { required = 1 } })
stub.world.finish(90030)
stub.world.turnIn(90030)
stub.advance(0.6)
look()
stub.world.accept(90032, {})
stub.world.finish(90032)
stub.world.turnIn(90032)
stub.advance(0.6)
look()
emit(walk)"#,
		"Horde",
		"Tauren",
	);
	let (built, walk) = (&out[0], &out[1]);
	assert_eq!(
		built["steps"],
		json!([
			{ "title": "Into the Caverns", "goals": "accept:90030 kill:90030 collect:90030 turnin:90030" },
			{ "title": "Heart of the Serpent", "goals": "accept:90032 turnin:90032" },
			{ "title": "Wailing Caverns", "goals": "note goto" },
		]),
		"both quests whole, not \"First do the quest\" notes the engine passes as done"
	);
	let entrance = "1413 46 36.4";
	assert_eq!(built["at"][0], json!(["1413 52.2 31.9", entrance, entrance, entrance]), "Tonga in the Barrens; Kresh, the scale pile and the Keeper at the entrance");
	assert_eq!(built["at"][1], json!([entrance, "1413 52.2 31.9"]));
	assert_eq!(built["notes"], json!(["Deviate Keeper, Kresh, Shimmering Scale: inside Wailing Caverns.", "Deviate Keeper: inside Wailing Caverns.", false]));
	assert_eq!(
		*walk,
		json!([
			{ "step": 1, "accept": "from Tonga Runetotem, from level 25" },
			{ "step": 1, "accept": "from Tonga Runetotem" },
			{ "step": 2, "accept": "from Tonga Runetotem" },
			{ "step": 3, "accept": "from Tonga Runetotem" },
		]),
		"the guide stays on the gated quest, then walks each quest in turn to the entrance"
	);
}

#[test]
fn the_other_side_s_attunement_builds_no_guide() {
	let f = Fx::new();
	let (hc, mut hi) = heart_fixture(&f.codex, &f.inputs);
	hi["attunementTable"]["attunements"]
		.as_array_mut()
		.unwrap()
		.push(json!({ "key": "wailing-caverns", "id": "heart-a", "name": "Heart of the Serpent", "kind": "attunement", "need": "each", "faction": "A", "goal": [90032] }));
	let pk = pack_of(&hc, &hi);
	let out = f.run(
		&pk,
		r#"
local none, why = D.AttuneGuide("wailing-caverns", "heart-a")
emit({ none = none == nil, why = why })
emit({ some = D.AttuneGuide("wailing-caverns", "heart") ~= nil })"#,
		"Horde",
		"Tauren",
	);
	assert_eq!(out[0], json!({ "none": true, "why": "nothing" }));
	assert_eq!(out[1], json!({ "some": true }));
}

// ---------------------------------------------------------------------------
// The Attunement tab
// ---------------------------------------------------------------------------

#[test]
fn the_attunement_tab_the_head_with_its_facts_and_note_a_row_per_step_of_this_side_with_its_state_and_guide_me_through_it_opening_the_guide() {
	let f = Fx::new();
	let out = f.run_ui(
		r#"
Polestar.Dungeons.Open("wailing-caverns")
DS.SetTab("attune")
local h = DS.atts[1]
emit({ tab = DS.Tab(), tabs = tabs(), title = h.Title:GetText(), meta = h.Meta:GetText(), note = h.Note:GetText(), chip = h.State:IsShown(),
	guide = h.Guide:IsShown(), tip = h.Guide.psTipLines, rows = rows(), shown = DS.Shown().attune })
done[90001] = true
log[90002] = true
DS.Render()
local asked = {}
Polestar.Dungeons.Attune = function(key, id) asked[#asked + 1] = key .. ":" .. id return "lookup/attune/" .. key .. ":" .. id end
h.Guide:Click()
emit({ chip = h.State.Text:GetText(), rows = rows(), asked = asked, hub = PolestarPicker:IsShown() })
Polestar.Dungeons.Open("deadmines")
local tabsDm = tabs()
DS.SetTab("attune")
emit({ tabs = tabsDm, heads = { DS.atts[1].Title:GetText(), DS.atts[2] and DS.atts[2]:IsShown() or false }, rows = rows(), owned = DS.atts[1].Owned:GetText() })"#,
		"",
	);
	let (first, progress, deadmines) = (&out[0], &out[1], &out[2]);
	assert_eq!(first["tab"], "attune");
	assert_eq!(first["tabs"], json!(["Quests  4", "Attunement", "Bosses  4", "Map"]));
	assert_eq!(first["title"], "Fang of the Serpent");
	assert_eq!(first["meta"], "Attunement  \u{b7}  Everyone entering needs it  \u{b7}  From level 17");
	assert_eq!(first["note"], "Lets you take the serpent's path.");
	assert_eq!(json!([first["chip"], first["guide"]]), json!([false, true]));
	assert_eq!(first["tip"], json!(["A guide through the 3 steps left, from where you stand.", "It opens in a new tab."]));
	assert_eq!(
		first["rows"],
		json!([
			["Rite of the Serpent", "Nara Wildmane  \u{b7}  Thunder Bluff", true],
			["The Serpent's Trial", "After the steps before it  \u{b7}  Tonga Runetotem  \u{b7}  The Barrens", true],
			["Fang of the Serpent", "After the steps before it  \u{b7}  Tonga Runetotem  \u{b7}  The Barrens", true],
		]),
		"the Horde filter hides the Alliance goal"
	);
	assert_eq!(first["shown"], json!([{ "id": "fang", "done": false, "guide": true, "states": ["open", "locked", "locked"] }]));
	assert_eq!(progress["chip"], "1 of 3 done");
	let heads: Vec<String> = list(&progress["rows"]).iter().map(|r| text(&r[1]).split("  \u{b7}  ").next().unwrap().to_string()).collect();
	assert_eq!(heads, vec!["Done", "In your log", "After the steps before it"]);
	assert_eq!(json!([progress["asked"], progress["hub"]]), json!([["wailing-caverns:fang"], false]), "the guide opens and the hub steps aside");
	assert_eq!(deadmines["tabs"], json!(["Quests", "Keys", "Bosses  1", "Map"]), "the Horde sees the side-free key only: \"Keys\"");
	assert_eq!(deadmines["heads"], json!(["Smelting Key", false]));
	assert_eq!(deadmines["rows"], json!([["Smelting Key from Edwin VanCleef", "100% chance  \u{b7}  inside The Deadmines", false]]));
	assert_eq!(deadmines["owned"], "Not in your bags or bank");
}

#[test]
fn the_attunement_tab_the_kind_beside_the_title_is_in_the_client_language() {
	let f = Fx::new();
	let out = f.run_ui(
		r#"
Polestar.Dungeons.Open("wailing-caverns")
DS.SetTab("attune")
emit(DS.atts[1].Meta:GetText())"#,
		&fake_locale("itIT", &[("Attunement", "Zugangsquest"), ("Everyone entering needs it", "Jeder braucht sie"), ("From level %d", "Ab Stufe %d")]),
	);
	assert_eq!(out[0], "Zugangsquest  \u{b7}  Jeder braucht sie  \u{b7}  Ab Stufe 17");
}
