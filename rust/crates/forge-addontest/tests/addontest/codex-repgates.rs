//! The cited reputation gate table (data/codex/repgates.json): a row gates the vendor, giver or quest it names
//! (the item takes the standing, Lookup blocks that row until the character has it, per side where both sides'
//! vendors sell the item), and a row whose item or npc the Codex lacks is a build warning, not a silent skip.

use forge_addontest::codex::{write_codex_pack, CodexOpts};
use forge_addontest::dsl::plain;
use forge_addontest::run::root;
use forge_addontest::{emitted, is_match, truthy, Addon, RunAddon};
use forge_data::codex::merge::merge_codex;
use forge_data::codex::{is_web_citation, Forever, Inputs};
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

const SOURCE: &str = "https://warcraft.wiki.gg/wiki/Example";

fn v(j: &Value) -> V {
	parse_json(&j.to_string()).unwrap()
}

fn frame() -> Value {
	json!({ "c": 0, "left": 1000, "right": -1000, "top": 1000, "bottom": -1000 })
}

fn vendor(id: i32, name: &str, side: &str, x: i32) -> Value {
	json!({ "id": id, "name": name, "level": 60, "faction": side, "roles": ["vendor"], "spawns": { "9001": { "f": "e", "pts": [[x, 50]] } }, "source": ["questie-forever"] })
}

// The Rust port keeps loadRepGateTable private (load_inputs reads the shipped file only): this is its row check
// and grouping by item, with the exposed is_web_citation for cited sources. A malformed row is an Err.
fn good_row(r: &Value) -> bool {
	let id = |x: &Value| x.as_u64().is_some_and(|n| n > 0);
	id(&r["item"])
		&& id(&r["faction"])
		&& r["standing"].as_u64().is_some_and(|s| (4..=8).contains(&s))
		&& r["npcs"].as_array().is_some_and(|a| !a.is_empty() && a.iter().all(id))
		&& (r["name"].is_null() || r["name"].is_string())
		&& match &r["source"] {
			Value::String(s) => is_match(s, r"^https://warcraft\.wiki\.gg/"),
			s => is_web_citation(&v(s)),
		}
}

fn rep_table(rows: &Value) -> Result<V, String> {
	let mut table = serde_json::Map::new();
	for r in rows.as_array().unwrap() {
		if !good_row(r) {
			return Err(format!("repgates.json: bad row {r}"));
		}
		table.entry(r["item"].to_string()).or_insert_with(|| json!([])).as_array_mut().unwrap().push(r.clone());
	}
	Ok(v(&Value::Object(table)))
}

// Vale Ration: the Alliance quartermasters (7001, 7003) sell it at Revered with the Vale Wardens, the Horde ones
// (7002, 7004) at Honored with the Ember Clan. Two rows are stale: 7009 sells nothing, item 9599 does not exist.
fn inputs(rows: &Value) -> Result<Inputs, String> {
	let rep_table = rep_table(rows)?;
	let forever = Forever {
		zones: v(&json!({ "9001": { "id": 9001, "name": "Amber Vale" } })),
		factions: v(&json!({ "9100": { "id": 9100, "name": "Vale Wardens", "side": "Alliance" }, "9101": { "id": 9101, "name": "Ember Clan", "side": "Horde" } })),
		map_frames: v(&json!({ "era": { "9001": frame() } })),
		meta: v(&json!({ "builtAt": "2026-10-14T00:00:00.000Z", "sources": [] })),
		npcs: v(&json!({
			"7001": vendor(7001, "Wardens Quartermaster", "A", 40),
			"7002": vendor(7002, "Ember Quartermaster", "H", 60),
			"7003": vendor(7003, "Wardens Supply Officer", "A", 45),
			"7004": vendor(7004, "Ember Supply Officer", "H", 65),
			"7009": vendor(7009, "Somebody Else", "A", 50),
		})),
		objects: V::obj(),
		items: v(&json!({ "9500": { "id": 9500, "name": "Vale Ration", "drops": { "npc": {}, "object": {} }, "vendors": [7001, 7002, 7003, 7004], "source": ["questie-forever"] } })),
		quests: V::obj(),
		professions: V::obj(),
		trainers: V::obj(),
		instances: V::Null,
		dungeons: V::Null,
	};
	Ok(Inputs {
		forever,
		atlasloot: None,
		rarescanner: None,
		local_extras: false,
		flbis: None,
		client: None,
		web: None,
		curated: Vec::new(),
		curated_gates: V::Null,
		entrances: Vec::new(),
		entrance_table: V::Null,
		rep_table,
		attunement_table: V::Null,
		journal_quests: Vec::new(),
		warnings: Vec::new(),
	})
}

fn rows() -> Value {
	json!([
		{ "item": 9500, "name": "Vale Ration", "faction": 9100, "standing": 7, "npcs": [7001, 7003], "source": SOURCE },
		{ "item": 9500, "name": "Vale Ration", "faction": 9101, "standing": 6, "npcs": [7002, 7004], "source": SOURCE },
	])
}

#[test]
fn repgates_a_row_gates_its_vendors_and_sets_the_item_standing_a_stale_row_warns() {
	let mut all = rows();
	all.as_array_mut().unwrap().extend([
		json!({ "item": 9500, "name": "Vale Ration", "faction": 9100, "standing": 5, "npcs": [7009], "source": SOURCE }),
		json!({ "item": 9599, "name": "Gone Ration", "faction": 9100, "standing": 5, "npcs": [7001], "source": SOURCE }),
	]);
	let codex = merge_codex(&inputs(&all).unwrap());
	let items = plain(&V::Obj(codex.items.clone()));
	let item = &items["9500"];
	let rep: Vec<Value> = item["sources"].as_array().unwrap().iter().filter(|s| s["type"] == "rep").cloned().collect();
	assert_eq!(
		json!(rep),
		json!([
			{ "type": "rep", "faction": 9100, "standing": 7, "npc": 7001, "from": ["curated"] },
			{ "type": "rep", "faction": 9101, "standing": 6, "npc": 7002, "from": ["curated"] },
		])
	);
	assert_eq!(item["repFaction"], 9100);
	assert_eq!(item["repStanding"], 7);
	assert!(codex.warnings.iter().any(|w| is_match(w, r"9500 Vale Ration: npc 7009 neither sells nor gives it")), "{}", codex.warnings.join("\n"));
	assert!(codex.warnings.iter().any(|w| is_match(w, r"item 9599 Gone Ration is not in the Codex")), "{}", codex.warnings.join("\n"));
}

#[test]
fn repgates_a_malformed_row_stops_the_build() {
	let bad = [
		json!([{ "item": 9500, "faction": 9100, "standing": 9, "npcs": [7001], "source": SOURCE }]),
		json!([{ "item": 9500, "faction": 9100, "standing": 5, "npcs": [7001], "source": "wiki" }]),
		json!([{ "item": 9500, "faction": 9100, "standing": 5, "source": SOURCE }]),
		json!([{ "item": 9500, "faction": 9100, "standing": 5, "npcs": [7001], "source": { "edition": "forever", "kind": "quest" } }]),
		json!([{ "item": 9500, "faction": 9100, "standing": 5, "npcs": [7001], "source": { "edition": "retail", "kind": "guide", "ref": "x" } }]),
	];
	for rows in &bad {
		let e = inputs(rows).err().expect("a malformed row throws");
		assert!(is_match(&e, r"bad row"), "{e}");
	}
	assert!(inputs(&json!([{ "item": 9500, "faction": 9100, "standing": 5, "npcs": [7001], "source": { "edition": "classic", "kind": "guide", "ref": "example-reputation" } }])).is_ok());
}

#[test]
fn repgates_the_shipped_table_loads_every_row_cites_a_page() {
	// loadRepGateTable is private in the Rust port: the shipped file is read directly, and each row's source
	// checked as the JS test does.
	let file = root().join("data/codex/repgates.json");
	let table: Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	let rows = table["gates"].as_array().unwrap();
	assert!(rows.len() > 100);
	for r in rows {
		let ok = match &r["source"] {
			Value::String(s) => is_match(s, r"^https://warcraft\.wiki\.gg/"),
			s => is_web_citation(&v(s)),
		};
		assert!(truthy(&json!(ok)), "{}", serde_json::to_string(r).unwrap());
	}
}

const BEFORE: &str = r#"
local w = stub.world
w.addMap(9001, { name = "Amber Vale", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.level, w.race, w.raceName, w.faction = 60, "${race}", "${race}", "${faction}"
w.class, w.className = "WARRIOR", "WARRIOR"
w.moveTo(9001, 50, 50)
${setup}"#;

const SCRIPT: &str = r#"
local out = {}
for _, r in ipairs((Polestar.Lookup.Sources("item", 9500))) do
	if r.type == "vendor" then out[#out + 1] = { label = r.label, available = r.available, why = r.why or false, whyText = r.whyText or false } end
end
table.sort(out, function(a, b) return a.label < b.label end)
emit(out)"#;

#[test]
fn repgates_lookup_blocks_each_vendor_until_its_own_side_s_standing() {
	let m = merge_codex(&inputs(&rows()).unwrap());
	let codex = json!({
		"meta": { "schema": 1, "builtAt": "2026-10-14T00:00:00Z", "build": "1.60.1.70338", "sources": [] },
		"items": plain(&V::Obj(m.items.clone())),
		"npcs": plain(&V::Obj(m.npcs.clone())),
		"objects": plain(&V::Obj(m.objects.clone())),
		"quests": plain(&V::Obj(m.quests.clone())),
		"instances": plain(&V::Obj(m.instances.clone())),
		"zones": plain(&V::Obj(m.zones.clone())),
		"factions": plain(&V::Obj(m.factions.clone())),
		"spells": plain(&V::Obj(m.spells.clone())),
		"frames": plain(&V::Obj(m.frames.clone())),
	});
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let run = |race: &str, faction: &str, setup: &str| {
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_lookup_runtime.lua"],
			before: pack.stub_lua.clone() + &BEFORE.replace("${race}", race).replace("${faction}", faction).replace("${setup}", setup),
			addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml"])],
			login: true,
			script: SCRIPT.into(),
			..Default::default()
		})
		.remove(0)
	};
	let label = |list: Value| {
		let mut m = serde_json::Map::new();
		for r in list.as_array().unwrap() {
			let val = if truthy(&r["available"]) {
				json!("ok")
			} else if r["why"] == "reputation" {
				r["whyText"].clone()
			} else {
				r["why"].clone()
			};
			m.insert(r["label"].as_str().unwrap().to_string(), val);
		}
		Value::Object(m)
	};
	assert_eq!(
		label(run("Human", "Alliance", r#"w.setRep(9100, "Vale Wardens", 6, 9000, 21000, 12000)"#)),
		json!({
			"Ember Quartermaster": "faction",
			"Ember Supply Officer": "faction",
			"Wardens Quartermaster": "Requires Revered (Vale Wardens)",
			"Wardens Supply Officer": "Requires Revered (Vale Wardens)",
		})
	);
	// 7004 has no rep source of its own: it takes its side's (Ember Clan), not the item's (Vale Wardens).
	assert_eq!(
		label(run("Orc", "Horde", r#"w.setRep(9101, "Ember Clan", 5, 3000, 9000, 4000)"#)),
		json!({
			"Ember Quartermaster": "Requires Honored (Ember Clan)",
			"Ember Supply Officer": "Requires Honored (Ember Clan)",
			"Wardens Quartermaster": "faction",
			"Wardens Supply Officer": "faction",
		})
	);
	let honored = label(run("Orc", "Horde", r#"w.setRep(9101, "Ember Clan", 6, 9000, 21000, 12000)"#));
	assert_eq!(honored["Ember Quartermaster"], "ok");
	assert_eq!(honored["Ember Supply Officer"], "ok");
}
