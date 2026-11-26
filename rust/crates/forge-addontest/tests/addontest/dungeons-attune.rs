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
use forge_addontest::playtest::SIMULATE;
use forge_addontest::run::{addons_dir, join, root};
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
			finder: m["finder"].as_object().map(|f| forge_data::codex::client::Finder {
				min: f["min"].as_f64().unwrap_or(0.0),
				max: f["max"].as_f64().unwrap_or(0.0),
				players: f["players"].as_f64().unwrap_or(5.0),
				players_max: f.get("playersMax").and_then(Value::as_f64).or(f["players"].as_f64()).unwrap_or(5.0),
			}),
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
			store_xp: &Default::default(),
			recorded_dungeons: &forge_guide::js::V::obj(),
			levels_table: &forge_guide::js::V::obj(),
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
	let mut closed: Vec<String> = Vec::new();
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
		// `open: false` (#3695): a raid Forever has not opened yet, saying how that is known.
		if !a["open"].is_null() {
			assert!(a["open"] == false && truthy(&a["openSource"]), "{id}: open is false or absent, with its openSource");
			closed.push(format!("{}:{id}", text(&a["key"])));
		}
	}
	closed.sort();
	assert_eq!(
		closed,
		["blackwing-lair:blackhand", "molten-core:aqual", "molten-core:core", "naxxramas:dread-citadel"],
		"Molten Core, Blackwing Lair and Naxxramas are not open on Forever yet; Onyxia's Lair is"
	);
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

/// One step as a line of the golden list: what it is, its ids, its order (`after`, `afterAny`), where it starts
/// and ends, and the gates (level, standing) it carries.
fn golden_line(s: &Value) -> String {
	let ids = |v: &Value| list(v).iter().map(|x| x.to_string()).collect::<Vec<_>>().join(",");
	let place = |p: &Value| if p.is_null() { "-".to_string() } else { format!("{}:{}", text(&p["kind"]), p["id"]) };
	let inside = |s: &Value| if s["instance"].is_string() { format!(" inside={}", text(&s["instance"])) } else { String::new() };
	match text(&s["kind"]) {
		"quest" => {
			let mut l = format!("quest {} {}", s["id"], text(&s["title"]));
			if truthy(&s["goal"]) {
				l.push_str(" *goal");
			}
			if truthy(&s["accept"]) {
				l.push_str(" (at its accept)");
			}
			l.push_str(&format!(" after=[{}] any=[{}] start={} finish={} minLevel={}", ids(&s["after"]), ids(&s["afterAny"]), place(&s["start"]), place(&s["finish"]), s["minLevel"]));
			if !s["startItem"].is_null() {
				l.push_str(&format!(" startItem={}", s["startItem"]["id"]));
			}
			if !s["rep"].is_null() {
				l.push_str(&format!(" rep={}:{}", s["rep"]["faction"], s["rep"]["standing"]));
			}
			l
		}
		"drop" => format!("drop {} {} npc:{}{}", s["item"]["id"], text(&s["item"]["name"]), s["npc"]["id"], inside(s)),
		"object" => format!("object {} {} object:{}{}", s["item"]["id"], text(&s["item"]["name"]), s["object"]["id"], inside(s)),
		"rep" => format!("rep {}:{}", s["faction"], s["standing"]),
		"gift" => format!("gift {} {} npc:{}", s["item"]["id"], text(&s["item"]["name"]), s["npc"]["id"]),
		"use" => format!("use {} {} > {} {} at {}", s["from"]["id"], text(&s["from"]["name"]), s["item"]["id"], text(&s["item"]["name"]), place(&s["at"])),
		k => format!("{k}?"),
	}
}

/// tests/fixtures/codex/attunements-golden.json: our pipeline's steps per attunement, pinned after review.
fn golden_path() -> std::path::PathBuf {
	root().join("tests/fixtures/codex/attunements-golden.json")
}

// Every attunement and key as our pipeline builds it from the local Codex (data/forever/codex) and the cited
// table, step by step, against the reviewed list in tests/fixtures/codex/attunements-golden.json (the 0.4.3 audit:
// each chain checked against Forever's quest data and the game's quest text): a Codex change that alters an
// attunement fails here until its new steps are reviewed. POLESTAR_WRITE_GOLDEN=1 writes the list anew.
#[test]
fn with_the_local_codex_every_attunement_builds_the_reviewed_steps_and_each_cited_inside_place_is_one_the_codex_lacks() {
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
	let mut built = serde_json::Map::new();
	for (key, l) in by.as_object().unwrap() {
		for a in list(l) {
			let head = format!("{} {} faction={} level={} item={}", text(&a["kind"]), text(&a["need"]), a["faction"], a["level"], a["item"]["id"]);
			let steps: Vec<Value> = list(&a["steps"]).iter().map(|s| Value::String(golden_line(s))).collect();
			built.insert(format!("{key}:{}", text(&a["id"])), json!({ "head": head, "steps": steps }));
		}
	}
	let built = Value::Object(built);
	if std::env::var_os("POLESTAR_WRITE_GOLDEN").is_some() {
		let file = json!({ "_about": "Every attunement and key our pipeline builds from the Codex (tools/lib/codex/attunements.js, forge_data::codex::attune), one line per step, reviewed in the 0.4.3 audit. The dungeons-attune addontest compares the build with it; POLESTAR_WRITE_GOLDEN=1 rewrites it after a reviewed change.", "attunements": built });
		std::fs::write(golden_path(), format!("{}\n", serde_json::to_string_pretty(&file).unwrap())).unwrap();
	}
	let golden: Value = serde_json::from_str(&std::fs::read_to_string(golden_path()).unwrap()).unwrap();
	let want = &golden["attunements"];
	let mut diff: Vec<String> = Vec::new();
	let keys: HashSet<&String> = want.as_object().unwrap().keys().chain(built.as_object().unwrap().keys()).collect();
	let mut keys: Vec<&String> = keys.into_iter().collect();
	keys.sort();
	for k in keys {
		if want[k] != built[k] {
			diff.push(format!("{k}:\n  reviewed {}\n  built    {}", want[k], built[k]));
		}
	}
	assert!(diff.is_empty(), "attunements differ from the reviewed list (review, then POLESTAR_WRITE_GOLDEN=1):\n{}", diff.join("\n"));
	// Every cited `inside` place is one a chain meets, of an NPC or object that has no spawn and that the Codex
	// places in no instance (the guide reads the Codex's instance itself; Drakkisath's Brand, Franclorn's monument,
	// Doan's Strongbox and the Inconspicuous Documents are the Codex's). A place cited for a quest of a raid Forever
	// has not opened, whose quests are out of the data (the Core Fragment for Attunement to the Core, #3392), is in
	// no chain until the raid opens.
	let closed_out: HashSet<String> =
		list(&table["attunements"]).iter().filter(|a| a["open"] == false).flat_map(|a| list(&a["goal"])).map(|q| q.to_string()).filter(|q| !truthy(&real["quests"][q.as_str()])).collect();
	let mut used: HashSet<String> = HashSet::new();
	for l in by.as_object().unwrap().values() {
		for a in list(l) {
			for e in list(&a["inside"]) {
				used.insert(format!("{}:{}:{}", text(&e["kind"]), e["id"], text(&e["instance"])));
			}
		}
	}
	for e in list(&table["inside"]) {
		let for_closed = list(&e["sources"]).iter().any(|s| s["kind"] == "quest" && closed_out.contains(&s["id"].to_string()));
		if for_closed {
			continue;
		}
		assert!(used.contains(&format!("{}:{}:{}", text(&e["kind"]), e["id"], text(&e["instance"]))), "{} is in no chain", text(&e["name"]));
		let records = if e["kind"] == "npc" { &real["npcs"] } else { &real["objects"] };
		let rec = &records[e["id"].to_string()];
		assert!(truthy(rec) && list(&rec["spawns"]).is_empty(), "{}: the Codex has it, with no spawn", text(&e["name"]));
		assert!(!truthy(&rec["instance"]), "{}: the Codex places it in {}, so the table need not", text(&e["name"]), rec["instance"]);
	}
	assert!(by["blackrock-spire"].is_null(), "Forever removed the Seal of Ascension");
}

/// The Codex pack a real guide reads: $POLESTAR_CODEX_DIR (a Polestar_Codex folder), else addon/Polestar_Codex
/// (`forge data codex`), loaded when asked as in game.
fn real_pack_lua() -> Option<String> {
	let dir = std::env::var_os("POLESTAR_CODEX_DIR").map_or_else(|| addons_dir().join("Polestar_Codex"), std::path::PathBuf::from);
	let toc = std::fs::read_to_string(dir.join("Polestar_Codex.toc")).ok()?;
	let frames: Value = serde_json::from_str(&std::fs::read_to_string(root().join("data/forever/map-frames.json")).ok()?).ok()?;
	let files: Vec<String> = toc.lines().map(str::trim).filter(|l| !l.is_empty() && !l.starts_with('#')).map(|f| serde_json::to_string(&join(&dir, f).to_string_lossy()).unwrap()).collect();
	let mut maps = Vec::new();
	for part in ["era", "forever"] {
		for (id, f) in frames[part].as_object().into_iter().flatten() {
			maps.push(format!("w.addMap({id}, {{ name = \"\", c = {}, left = {}, right = {}, top = {}, bottom = {} }})", f["c"], f["left"], f["right"], f["top"], f["bottom"]));
		}
	}
	Some(format!(
		"do
  local __files, __load = {{ {} }}, C_AddOns.LoadAddOn
  function C_AddOns.LoadAddOn(name)
    if name ~= \"Polestar_Codex\" then return __load(name) end
    if not stub.addonsLoaded[name] then
      for _, f in ipairs(__files) do dofile(f) end
      stub.addonsLoaded[name] = true
    end
    return true, nil
  end
end
local w = stub.world
{}",
		files.join(", "),
		maps.join("\n")
	))
}

// Two attunements as a level 60 Horde character in Orgrimmar gets them from the shipped Codex: none for the Molten
// Core while Forever has it closed (Attunement to the Core and Duke Hydraxis's chain are out of the data, #3392), and
// the Horde's Dalaran Sewer Key (the Tarren Mill chain, then Heart of Disruption's accept alone with the keep-it note).
// Skips without a built pack.
#[test]
fn with_the_built_codex_the_sewer_key_guide_reads_like_a_route_and_the_closed_molten_core_has_none() {
	let Some(packs) = real_pack_lua() else {
		eprintln!("skipped: no Codex pack (forge data codex, or POLESTAR_CODEX_DIR) or no data/forever/map-frames.json");
		return;
	};
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{packs}\nw.level, w.race, w.raceName, w.faction = 60, \"Orc\", \"Orc\", \"Horde\"\nw.class, w.className = \"WARRIOR\", \"WARRIOR\"\nw.moveTo(1454, 50, 70)"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml"])],
		login: true,
		script: format!(
			"{LUA}\n{}",
			r#"
local D = Polestar.Dungeons
D.Load()
local function full(def)
	local out = {}
	for i, s in ipairs(def and def.steps or {}) do
		local goals = {}
		for j, g in ipairs(s.goals) do
			goals[j] = g.t .. (g.quest and (":" .. g.quest) or g.item and (":" .. g.item) or "") .. (g.map and (" @" .. g.map .. " " .. g.x .. "," .. g.y) or "")
		end
		local notes = {}
		for _, g in ipairs(s.goals) do if g.t == "note" then notes[#notes + 1] = g.text end end
		out[i] = { title = s.title, goals = goals, note = s.note or table.concat(notes, " ") }
	end
	return out
end
emit(full(D.AttuneGuide("molten-core", "core")))
emit(full(D.AttuneGuide("city-of-dalaran", "sewer-key")))"#
		),
		..Default::default()
	});
	let (mc, sewer) = (&out[0], &out[1]);
	eprintln!("{}\n{}", serde_json::to_string_pretty(mc).unwrap(), serde_json::to_string_pretty(sewer).unwrap());
	assert!(list(mc).is_empty(), "no Molten Core attunement while the raid is closed: {mc:?}");
	let titles: Vec<String> = list(sewer).iter().map(|s| text(&s["title"]).to_string()).collect();
	let mut chain = titles[..4].to_vec();
	chain.sort();
	assert_eq!(chain, vec!["Blood in the Streets", "Dalaran Patrols", "Key to the City", "Prison Break In"], "{titles:?}");
	assert_eq!(titles[3], "Blood in the Streets", "after the three Tarren Mill quests: {titles:?}");
	assert_eq!(titles[4], "Heart of Disruption");
	let heart: Vec<String> = list(&sewer[4]["goals"]).iter().map(|g| text(g).to_string()).collect();
	assert_eq!(heart.len(), 1, "its accept alone: {heart:?}");
	assert!(heart[0].starts_with("accept:96984 @1421 "), "at the Image of Archmage Modera: {heart:?}");
	assert!(text(&sewer[4]["note"]).starts_with("Keep "), "{}", sewer[4]["note"]);
	assert_eq!(text(&sewer[5]["title"]), "City of Dalaran");
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
local E = Polestar.Engine
local enter = E.GetStepView(E.GetStepCount()).goals[2]
emit({ gid = gid, tabs = tabs, enter = enter.text, header = enter.header or false })
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
			{ "title": "Fang of the Serpent", "goals": "rep accept:90003 turnin:90003" },
			{ "title": "Wailing Caverns", "goals": "note goto" },
		]),
		"the Alliance goal is not in a Horde guide; the standing the last quest needs comes first, in words"
	);
	assert_eq!(later["title"], "Wailing Caverns: Fang of the Serpent");
	let titles: Vec<Value> = list(&later["steps"]).iter().map(|s| s["title"].clone()).collect();
	assert_eq!(json!(titles), json!(["The Serpent's Trial", "Fang of the Serpent", "Wailing Caverns"]));
	assert_eq!(later["goto"], json!([1413, 46, 36.4, "Wailing Caverns"]));
	assert_eq!(later["note"], "Lets you take the serpent's path.");
	assert_eq!(
		*opened,
		json!({ "gid": "lookup/attune/wailing-caverns:fang", "tabs": ["lookup/attune/wailing-caverns:fang"], "enter": "Enter Wailing Caverns", "header": false }),
		"the entrance reads Enter, not Go to Enter, as its own row"
	);
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
	local wp = E.GetWaypoint()
	walk[#walk + 1] = { step = E.GetStepIndex() or false, accept = v.goals[1].detail, entrance = wp ~= nil and wp.map == 1413 and wp.x == 46 and wp.y == 36.4 }
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
	let steps: Vec<Value> = walk.as_array().unwrap().iter().map(|w| json!({ "step": w["step"], "accept": w["accept"] })).collect();
	assert_eq!(
		json!(steps),
		json!([
			{ "step": 1, "accept": "from Tonga Runetotem, from level 25" },
			{ "step": 1, "accept": "from Tonga Runetotem" },
			{ "step": 2, "accept": "from Tonga Runetotem" },
			{ "step": 3, "accept": "from Tonga Runetotem" },
		]),
		"the guide stays on the gated quest, then walks each quest in turn to the entrance"
	);
	// #1320's generic pass of an accept above the level never sends a character too low for the attunement into
	// the dungeon's entrance: the guide holds at Tonga's accept.
	assert_eq!(walk[0]["entrance"], json!(false), "level 18: the arrow is not on the entrance");
}

// The Shadowforge Key's guide (Dark Iron Legacy, 3801 > 3802) went straight to Blackrock Depths' entrance: Franclorn
// Forgewright gives and takes both quests and only a dead character sees him, and #558 made such an accept or
// turn-in optional, so the engine passed both quests by. An attunement's quests are what it needs: here a ghost-only
// NPC's goals stay to do, each saying how to reach him, and the guide plays every step to the entrance.
#[test]
fn a_ghost_only_npc_s_accepts_and_turn_ins_stay_to_do_in_an_attunement_guide_their_goal_saying_how_and_the_engine_walks_every_step() {
	let f = Fx::new();
	let mut c = f.codex.clone();
	c["npcs"]["3448"]["ghostOnly"] = json!(true);
	let pk = pack_of(&c, &f.inputs);
	let out = f.run(
		&pk,
		&format!(
			r#"
local def = D.AttuneGuide("wailing-caverns", "fang")
local ghost = {{}}
for _, s in ipairs(def.steps) do
	for _, g in ipairs(s.goals) do
		if g.npc == 3448 then ghost[#ghost + 1] = {{ goal = g.t .. ":" .. g.quest, optional = g.optional or false, note = g.note or false }} end
	end
end
emit({{ steps = describe(def), ghost = ghost }})
D.Attune("wailing-caverns", "fang")
stub.advance(0.6)
SIM_GUIDE = Polestar.Engine.GetGuide()
{SIMULATE}"#,
			SIMULATE = SIMULATE.as_str()
		),
		"Horde",
		"Tauren",
	);
	let (built, played) = (&out[0], &out[1]);
	assert_eq!(
		built["steps"],
		json!([
			{ "title": "Rite of the Serpent", "goals": "accept:90001 turnin:90001" },
			{ "title": "The Serpent's Trial", "goals": "accept:90002 collect:90002 turnin:90002" },
			{ "title": "Fang of the Serpent", "goals": "rep accept:90003 turnin:90003" },
			{ "title": "Wailing Caverns", "goals": "note goto" },
		])
	);
	let how = "Only visible while dead: die nearby and talk to them as a ghost.";
	assert_eq!(
		built["ghost"],
		json!([
			{ "goal": "turnin:90001", "optional": false, "note": how },
			{ "goal": "accept:90002", "optional": false, "note": how },
			{ "goal": "turnin:90002", "optional": false, "note": how },
			{ "goal": "accept:90003", "optional": false, "note": how },
		]),
		"Tonga's goals are the chain: to do, not skipped"
	);
	assert!(!truthy(&played["stuck"]), "stuck: {}", played["stuck"]);
	assert_eq!(played["done"], true);
	assert_eq!(played["visited"], played["steps"], "the engine stops at every step, none passed as done");
}

// What Comes Around...: Lookup's guide for the quest said "Collect Head of Targorr" with the arrow left beside
// Guard Berton, who takes it; Targorr is a boss inside the Stockade and the data has no place for him outside
// (#3613). A quest guide sends an inside source's item to its instance's entrance, as the attunement guides do,
// and says what is inside.
#[test]
fn issue_3613_a_lookup_quest_guide_sends_a_drop_from_inside_an_instance_to_its_entrance() {
	let f = Fx::new();
	let mut c = f.codex.clone();
	c["items"]["90061"] = json!({ "id": 90061, "name": "Head of Kresh", "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": [{ "type": "drop", "npc": 3653, "chance": 100 }] });
	c["quests"]["90062"] = json!({ "id": 90062, "title": "What Comes Around", "level": 18, "minLevel": 10, "faction": null, "races": null, "classes": null,
		"start": { "npc": [3448], "object": [], "item": [] }, "end": { "npc": [3448], "object": [] },
		"objectives": [{ "type": "item", "id": 90061, "count": 1, "text": "Head of Kresh" }], "pre": [], "preAny": [], "rewards": [], "choices": [] });
	let pk = pack_of(&c, &f.inputs);
	let out = f.run(
		&pk,
		r#"
Polestar.Set("lookup.enabled", true)
local def, why = Polestar.Lookup.BuildGuide("quest", 90062)
local goals = {}
for i, goal in ipairs(def and def.steps[1].goals or {}) do goals[i] = goal.t .. " " .. (goal.map and table.concat({ goal.map, goal.x, goal.y }, " ") or "nowhere") end
emit({ why = why or false, goals = goals, note = def and def.steps[1].note or false })"#,
		"Horde",
		"Tauren",
	);
	assert_eq!(out[0]["why"], json!(false));
	assert_eq!(out[0]["goals"], json!(["accept 1413 52.2 31.9", "collect 1413 46 36.4", "turnin 1413 52.2 31.9"]), "the head at the caverns' entrance");
	assert_eq!(out[0]["note"], json!("Head of Kresh: inside Wailing Caverns."), "the step says what is inside where");
}

// The God Hakkar: Lookup's guide for the quest left the arrow on Yeh'kinya for "Collect Filled Egg of Hakkar"; no
// source gives the egg, it is filled with the Essence of Hakkar, which drops inside the Sunken Temple (#4148). An
// item objective the Codex says is made from an item the quest needs (madeFrom) goes where that item comes from:
// the instance's entrance, the step saying what is inside.
#[test]
fn issue_4148_a_lookup_quest_guide_sends_an_item_made_from_a_drop_inside_an_instance_to_its_entrance() {
	let f = Fx::new();
	let mut c = f.codex.clone();
	c["items"]["90061"] =
		json!({ "id": 90061, "name": "Essence of Kresh", "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": [{ "type": "drop", "npc": 3653, "chance": 100 }] });
	c["items"]["90063"] = json!({ "id": 90063, "name": "Filled Egg", "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": [] });
	c["quests"]["90062"] = json!({ "id": 90062, "title": "The God Kresh", "level": 18, "minLevel": 10, "faction": null, "races": null, "classes": null,
		"start": { "npc": [3448], "object": [], "item": [] }, "end": { "npc": [3448], "object": [] },
		"objectives": [{ "type": "item", "id": 90063, "count": 1, "text": "Filled Egg", "madeFrom": [90061] }], "pre": [], "preAny": [], "rewards": [], "choices": [] });
	let pk = pack_of(&c, &f.inputs);
	let out = f.run(
		&pk,
		r#"
Polestar.Set("lookup.enabled", true)
local def, why = Polestar.Lookup.BuildGuide("quest", 90062)
local goals = {}
for i, goal in ipairs(def and def.steps[1].goals or {}) do goals[i] = goal.t .. " " .. (goal.map and table.concat({ goal.map, goal.x, goal.y }, " ") or "nowhere") end
emit({ why = why or false, goals = goals, note = def and def.steps[1].note or false })"#,
		"Horde",
		"Tauren",
	);
	assert_eq!(out[0]["why"], json!(false));
	assert_eq!(out[0]["goals"], json!(["accept 1413 52.2 31.9", "collect 1413 46 36.4", "turnin 1413 52.2 31.9"]), "the egg at the caverns' entrance, not the giver");
	assert_eq!(out[0]["note"], json!("Essence of Kresh: inside Wailing Caverns."), "the step says what is inside where");
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

// Keys and items the 0.4.3 audit added ways for: a key handed over with a quest's accept (Heart of Disruption's
// Dalaran Sewer Key), an item made by using another where an NPC stands (the Black Tome at the Ambermill Leyline
// Focus), and a turn-in at an object the Codex places inside an instance with no spawn (Drakkisath's Brand).
fn keys_fixture(codex: &Value, inputs: &Value) -> (Value, Value) {
	let mut c = codex.clone();
	let quest = |id: i64, title: &str, start: i64, end: Value, objectives: Value, pre_any: Value| {
		json!({ "id": id, "title": title, "level": 26, "minLevel": 15, "faction": null, "races": null, "classes": null,
			"start": { "npc": [start], "object": [], "item": [] }, "end": end, "objectives": objectives, "pre": [], "preAny": pre_any, "rewards": [], "choices": [] })
	};
	let item = |id: i64, name: &str, sources: Value| json!({ "id": id, "name": name, "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": sources });
	c["quests"]["90060"] = quest(90060, "Blood in the Streets", 3448, json!({ "npc": [3448], "object": [] }), json!([]), json!([]));
	c["quests"]["90061"] =
		quest(90061, "Heart of Disruption", 3448, json!({ "npc": [3448], "object": [] }), json!([{ "type": "item", "id": 90062, "count": 1, "text": "Arcane Mote" }]), json!([90060]));
	c["items"]["90062"] = item(90062, "Arcane Mote", json!([]));
	c["items"]["90063"] = item(90063, "Sewer Key", json!([]));
	c["items"]["90064"] = item(90064, "Black Tome", json!([{ "type": "object", "object": 90065, "chance": 100, "instance": "deadmines" }]));
	c["items"]["90066"] = item(90066, "Tome of Secrets", json!([]));
	c["objects"]["90070"] = json!({ "id": 90070, "name": "Serpent's Brand", "treasure": false, "instance": "wailing-caverns", "spawns": [] });
	c["quests"]["90069"] = quest(90069, "The Serpent's Brand", 3448, json!({ "npc": [], "object": [90070] }), json!([]), json!([]));
	let mut table = inputs["attunementTable"].clone();
	let list = table["attunements"].as_array_mut().unwrap();
	list.push(json!({ "key": "wailing-caverns", "id": "sewer", "name": "Sewer Key", "kind": "key", "need": "one", "item": 90063, "goal": [90061], "onAccept": true, "note": "Opens the sewer." }));
	list.push(json!({ "key": "wailing-caverns", "id": "tome", "name": "Tome of Secrets", "kind": "item", "need": "one", "item": 90066, "via": 90064, "useAt": { "kind": "npc", "id": 3448 }, "note": "Calls up a secret." }));
	list.push(json!({ "key": "wailing-caverns", "id": "brand", "name": "The Serpent's Brand", "kind": "attunement", "need": "each", "goal": [90069], "note": "Lets you in." }));
	let mut inp = inputs.clone();
	inp["attunementTable"] = table;
	(c, inp)
}

#[test]
fn a_key_given_at_an_accept_ends_the_guide_there_an_item_made_by_a_use_is_used_where_its_npc_stands_and_a_codex_placed_object_is_at_its_entrance() {
	let f = Fx::new();
	let (kc, ki) = keys_fixture(&f.codex, &f.inputs);
	let pk = pack_of(&kc, &ki);
	let out = f.run(
		&pk,
		r#"
local function at(g) return g.map and table.concat({ g.map, g.x, g.y }, " ") or false end
local sewer = D.AttuneGuide("wailing-caverns", "sewer")
emit({ steps = describe(sewer), note = sewer.steps[2].note })
emit(states("wailing-caverns", "sewer"))
stub.world.accept(90060, {})
stub.world.turnIn(90060)
stub.world.accept(90061, { { required = 1 } })
emit(states("wailing-caverns", "sewer"))
stub.world.addItem(90063)
emit(states("wailing-caverns", "sewer"))
local tome = D.AttuneGuide("wailing-caverns", "tome")
emit({ steps = describe(tome), chest = at(tome.steps[1].goals[1]), chestNote = tome.steps[1].goals[2].text,
	use = at(tome.steps[2].goals[1]), made = at(tome.steps[2].goals[2]), useNote = tome.steps[2].note })
stub.world.addItem(90066)
emit(states("wailing-caverns", "tome"))
local brand = D.AttuneGuide("wailing-caverns", "brand")
emit({ steps = describe(brand), turnin = at(brand.steps[1].goals[2]), note = brand.steps[1].note or false })"#,
		"Horde",
		"Tauren",
	);
	let (sewer, fresh, taken, owned, tome, made, brand) = (&out[0], &out[1], &out[2], &out[3], &out[4], &out[5], &out[6]);
	assert_eq!(
		sewer["steps"],
		json!([
			{ "title": "Blood in the Streets", "goals": "accept:90060 turnin:90060" },
			{ "title": "Heart of Disruption", "goals": "accept:90061" },
			{ "title": "Wailing Caverns", "goals": "note goto" },
		]),
		"the chain ends at the accept that hands over the key: no Arcane Mote, no turn-in that would take it back"
	);
	assert_eq!(sewer["note"], "Keep \u{201c}Heart of Disruption\u{201d} in your quest log until you are inside: taking it gives you Sewer Key, and dropping the quest takes it back.");
	assert_eq!(fresh["states"], json!(["open", "locked"]));
	assert_eq!(json!([taken["states"], taken["done"], taken["goalDone"]]), json!([["done", "done"], false, true]), "in the log: the step is done, the key not yet in the bags");
	assert_eq!(owned["done"], json!(true));
	assert_eq!(
		tome["steps"],
		json!([
			{ "title": "Black Tome", "goals": "collect:90064 note" },
			{ "title": "Black Tome", "goals": "use:90064 collect:90066" },
			{ "title": "Wailing Caverns", "goals": "note goto" },
		])
	);
	assert_eq!(json!([tome["chest"], tome["chestNote"]]), json!(["1436 42.5 71.7", "Black Tome: inside The Deadmines."]), "a chest with no object name, at its instance's entrance");
	assert_eq!(json!([tome["use"], tome["made"]]), json!(["1413 52.2 31.9", "1413 52.2 31.9"]), "used where Tonga stands");
	assert_eq!(tome["useNote"], "Use Black Tome beside Tonga Runetotem: it becomes Tome of Secrets.");
	assert_eq!(json!([made["done"], made["states"]]), json!([true, ["skip", "done"]]), "the made item owned: done");
	assert_eq!(brand["steps"], json!([{ "title": "The Serpent's Brand", "goals": "accept:90069 turnin:90069" }, { "title": "Wailing Caverns", "goals": "note goto" }]));
	assert_eq!(json!([brand["turnin"], brand["note"]]), json!(["1413 46 36.4", "Serpent's Brand: inside Wailing Caverns."]), "the Codex's object instance places the turn-in");
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

// The next step of a chest (the Tome of Dalaran's Black Tome) names its object in the client's language
// (Polestar.Names), and in English where the language has no name for it, as the drop and gift steps' NPCs do:
// a Russian client read "(источник: Black Tome)" before.
#[test]
fn the_next_step_names_its_object_in_the_client_language_and_in_english_where_it_has_none() {
	let f = Fx::new();
	let out = f.run_ui(
		r#"
local step = { kind = "object", item = { id = 276561, name = "Black Tome" }, object = { kind = "object", id = 659376, name = "Black Tome" } }
emit(Polestar.UI.Attunements.StepWords(step, "open"))
Polestar.Names.AddChunk("itIT", "object", 659376, 659376, "\n659376\tTomo nero\n")
emit(Polestar.UI.Attunements.StepWords(step, "open"))"#,
		&fake_locale("itIT", &[("%s from %s", "%s da %s")]),
	);
	assert_eq!(out, vec![json!("Black Tome da Black Tome"), json!("Black Tome da Tomo nero")]);
}

#[test]
fn the_next_step_uses_client_names_for_quest_givers_items_and_their_sources() {
	let f = Fx::new();
	let out = f.run_ui(
		r#"
local stepWords, names = Polestar.UI.Attunements.StepWords, Polestar.Names
local npc = { kind = "npc", id = 31, name = "Elizabeth" }
local item = { id = 42, name = "Key" }
local object = { kind = "object", id = 53, name = "Door" }
local quest = { kind = "quest", id = 64, title = "The quest", start = npc }
local function lines()
	return {
		stepWords(quest, "open"),
		stepWords({ kind = "drop", item = item, npc = npc }, "open"),
		stepWords({ kind = "gift", item = item, npc = npc }, "open"),
		stepWords({ kind = "use", from = item, at = object }, "open"),
	}
end
emit(lines())
names.AddChunk("itIT", "npc", 31, 31, "\n31\tElisabetta\n")
names.AddChunk("itIT", "item", 42, 42, "\n42\tChiave\n")
names.AddChunk("itIT", "object", 53, 53, "\n53\tPorta\n")
names.AddChunk("itIT", "quest", 64, 64, "\n64\tLa missione\n")
emit(lines())"#,
		&fake_locale("itIT", &[("Pick up %s from %s", "Accetta %s da %s"), ("%s from %s", "%s da %s"), ("%s gives you %s", "%s ti dà %s"), ("Use %s beside %s", "Usa %s accanto a %s")]),
	);
	assert_eq!(
		out,
		vec![
			json!(["Accetta The quest da Elizabeth", "Key da Elizabeth", "Elizabeth ti dà Key", "Usa Key accanto a Door"]),
			json!(["Accetta La missione da Elisabetta", "Chiave da Elisabetta", "Elisabetta ti dà Chiave", "Usa Chiave accanto a Porta"]),
		]
	);
}

// ---------------------------------------------------------------------------
// The Attunements section (UI/Attunements.lua, #3695)
// ---------------------------------------------------------------------------

// A rail entry of its own after Dungeons: every attunement and key of this character's faction (the Alliance's
// Ironclad Key left out for a Tauren), each with what it opens, a bar of the steps done as Dungeons.AttunementState
// counts them, the next step in words and Guide me, which opens the same guide as the dungeon page's button. A raid
// not open on Forever yet says so instead of its bar and comes after the open ones, its guide still built with that
// line at the end; a done one is ticked at the bottom. The dungeon page's Attunement tab links here.
#[test]
fn the_attunements_section_lists_this_side_s_attunements_with_their_progress_next_step_and_guide_not_open_ones_after_done_ones_last() {
	let f = Fx::new();
	let out = f.run_ui(
		r#"
local AT, P, D = Polestar.UI.Attunements, Polestar.UI.Picker, Polestar.Dungeons
local rail = {}
for _, it in ipairs(P.RailItems()) do rail[#rail + 1] = it.key end
AT.Show()
local function list()
	local out = {}
	for i, s in ipairs(AT.Shown()) do out[i] = { s.id, s.opens, s.progress, s.nextStep, s.closed, s.guide, s.chip } end
	return out
end
-- What AttunementState says, counted as the card counts it.
local function counted(key, id)
	for _, a in ipairs(D.Attunements(key, "H")) do
		if a.id == id then
			local st, did, total = D.AttunementState(a), 0, 0
			for _, e in ipairs(st.steps) do
				if e.state ~= "na" and e.state ~= "skip" then total = total + 1; if e.state == "done" then did = did + 1 end end
			end
			return { did, total }
		end
	end
end
emit({ rail = rail, section = P.Section(), fresh = list(), counted = counted("wailing-caverns", "fang") })
done[90001] = true
log[90002] = true
AT.Render()
local asked = {}
D.Attune = function(key, id) asked[#asked + 1] = key .. ":" .. id return "lookup/attune/" .. key .. ":" .. id end
for _, c in ipairs(AT.cards) do if c:IsShown() and c.psId == "fang" then c.Guide:Click() end end
Polestar.Dungeons.Open("wailing-caverns")
DS.SetTab("attune")
DS.atts[1].Guide:Click()
local _, _, pg = DS.Frames()
emit({ progress = list(), counted = counted("wailing-caverns", "fang"), asked = asked, link = pg.AttLink and pg.AttLink:IsShown() and pg.AttLink.Label:GetText() or false })
-- Fang's raid not open yet; the Smelting Key in the bags.
Polestar.Compat.GetItemCount = function(id) return id == 90011 and 1 or 0 end
local attunements = D.Attunements
D.Attunements = function(key, side)
	local l = attunements(key, side)
	for _, a in ipairs(l) do if a.id == "fang" then a.open = false end end
	return l
end
pg.AttLink:Click()
local guide = D.AttuneGuide("wailing-caverns", "fang")
local last = guide.steps[#guide.steps]
local notes = {}
for _, g in ipairs(last.goals) do if g.t == "note" then notes[#notes + 1] = g.text end end
emit({ section = P.Section(), later = list(), notes = notes })"#,
		"",
	);
	let (fresh, progress, later) = (&out[0], &out[1], &out[2]);
	let at = fresh["rail"].as_array().unwrap().iter().position(|k| k == "Attunements").expect("a rail entry");
	assert_eq!(fresh["rail"][at - 1], "Dungeons", "next to Dungeons: {}", fresh["rail"]);
	assert_eq!(fresh["section"], "Attunements");
	assert_eq!(
		fresh["fresh"],
		json!([
			["smelting-key", "The Deadmines", [0, 1], "Next: Smelting Key from Edwin VanCleef", false, true, false],
			["fang", "Wailing Caverns", [0, 3], "Next: Pick up Rite of the Serpent from Nara Wildmane", false, true, false],
		]),
		"the Horde's two, by level then the instance's name; the Alliance's Ironclad Key left out"
	);
	assert_eq!(fresh["fresh"][1][2], fresh["counted"], "the bar counts what AttunementState says");
	assert_eq!(progress["progress"][1][2], json!([1, 3]));
	assert_eq!(progress["progress"][1][2], progress["counted"]);
	assert_eq!(progress["progress"][1][3], "Next: Finish The Serpent's Trial", "the quest in the log is the next step");
	assert_eq!(progress["asked"], json!(["wailing-caverns:fang", "wailing-caverns:fang"]), "Guide me opens the dungeon page's guide");
	assert_eq!(progress["link"], "All attunements and keys", "the dungeon page links here");
	assert_eq!(later["section"], "Attunements", "the link opens the section");
	assert_eq!(
		later["later"],
		json!([["fang", "Wailing Caverns", false, "Next: Finish The Serpent's Trial", "Not open on Forever yet", true, false], ["smelting-key", "The Deadmines", true, false, false, false, "Done"]]),
		"not open: the line instead of the bar, Guide me still there; done: ticked, at the bottom"
	);
	assert_eq!(later["notes"].as_array().unwrap().last().unwrap(), "Not open on Forever yet: the attunement is ready for when it opens.");
}

// #3877: the section laid out like the Dungeons page: a key in the rail, cards two to a row each with the
// instance's picture band, the key glyph before the name (a check once done) and Guide me unchanged; a raid's
// attunement before the dungeons' keys; a done one dimmed at the end.
#[test]
fn the_attunements_section_is_cards_two_to_a_row_with_a_key_raids_first_done_ones_dimmed_3877() {
	let f = Fx::new();
	let out = f.run_ui(
		r#"
local AT, P, D = Polestar.UI.Attunements, Polestar.UI.Picker, Polestar.Dungeons
local icon
for _, it in ipairs(P.RailItems()) do if it.key == "Attunements" then icon = it.icon end end
-- The Deadmines a raid, for the order.
local list = D.List
D.List = function()
	local l = list()
	for _, d in ipairs(l) do if d.key == "deadmines" then d.kind = "raid" end end
	return l
end
AT.Show()
local c1, c2 = AT.cards[1], AT.cards[2]
local _, _, _, x1, y1 = c1:GetPoint(1)
local _, _, _, x2, y2 = c2:GetPoint(1)
local first = { AT.Shown()[1].id, AT.Shown()[1].raid, AT.Shown()[1].glyph }
local art = c1.Art:IsShown() and c1.Art:GetHeight() > 0
-- The Smelting Key in the bags: done, at the end, dimmed.
Polestar.Compat.GetItemCount = function(id) return id == 90011 and 1 or 0 end
AT.Render()
local last = AT.Shown()[#AT.Shown()]
local lastCard
for _, c in ipairs(AT.cards) do if c:IsShown() and c.psId == last.id then lastCard = c end end
emit({ icon = icon, first = first, sideBySide = y1 == y2 and x2 > x1, sameHeight = c1:GetHeight() == c2:GetHeight(), art = art,
	guide = c1.Guide.Label:GetText(), titles = { c1.Title:GetText(), c2.Title:GetText() }, metas = { c1.Meta:GetText(), c2.Meta:GetText() }, last = { last.id, last.glyph, lastCard:GetAlpha() } })"#,
		"",
	);
	let out = &out[0];
	assert_eq!(out["icon"], "key", "a key in the rail: {out}");
	assert_eq!(out["first"], json!(["smelting-key", true, "key"]), "the raid's first, a key before its name: {out}");
	assert_eq!(out["sideBySide"], true, "two to a row: {out}");
	assert_eq!(out["sameHeight"], true, "a row's cards as tall as each other: {out}");
	assert_eq!(out["art"], true, "the picture band: {out}");
	assert_eq!(out["guide"], "Guide me");
	assert_eq!(out["titles"], json!(["Wailing Caverns", "The Deadmines"]), "the title is the instance the card opens: {out}");
	assert_eq!(
		out["metas"],
		json!(["Fang of the Serpent  ·  Attunement  ·  Everyone entering needs it  ·  From level 17", "Smelting Key  ·  Key  ·  One in the group is enough"]),
		"the key's own name leads the facts: {out}"
	);
	assert_eq!(out["last"], json!(["smelting-key", "check", 0.6]), "done: ticked, at the end, dimmed: {out}");
}
