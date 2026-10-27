//! Forever's quest data (QuestieDB's baked Forever store) on a synthetic install written here: the
//! decoder (CBOR, chunked values, presence masks, constants, support data, the flavour check), the
//! merge over pfQuest (precedence, roles, services, Forever-only records, objective order, triggers,
//! hints, drop-rate tables and their scale, corrections, recordings), the CMaNGOS objective counts
//! and spawn heights from a cached dump, and the frames, instances and item durations the Forever
//! client tables give.

use std::io::Write;
use std::path::{Path, PathBuf};

use forge_data::run;
use serde_json::{json, Map, Value};

use super::fixture_build::{fixture, options, Built};

// ---------------------------------------------------------------- a minimal CBOR encoder

fn head(major: u8, n: u64) -> Vec<u8> {
	let m = major << 5;
	match n {
		0..=23 => vec![m | n as u8],
		24..=255 => vec![m | 24, n as u8],
		256..=65535 => [vec![m | 25], (n as u16).to_be_bytes().to_vec()].concat(),
		65536..=0xffff_ffff => [vec![m | 26], (n as u32).to_be_bytes().to_vec()].concat(),
		_ => [vec![m | 27], n.to_be_bytes().to_vec()].concat(),
	}
}

fn int_key(k: &str) -> Option<i64> {
	let d = k.strip_prefix('-').unwrap_or(k);
	(!d.is_empty() && d.bytes().all(|b| b.is_ascii_digit())).then(|| k.parse().unwrap())
}

fn int(n: i64) -> Vec<u8> {
	if n >= 0 {
		head(0, n as u64)
	} else {
		head(1, (-1 - n) as u64)
	}
}

/// C_EncodingUtil.SerializeCBOR's shapes; an object's integer-looking keys are integer keys (as in
/// Lua), first in ascending order, then the others as written (a JS object's key order).
fn cbor(v: &Value) -> Vec<u8> {
	match v {
		Value::Null => vec![0xf6],
		Value::Bool(true) => vec![0xf5],
		Value::Bool(false) => vec![0xf4],
		Value::Number(n) => {
			let x = n.as_f64().unwrap();
			if x.fract() == 0.0 && x.abs() < 1.8e19 {
				int(x as i64)
			} else {
				[vec![0xfb], x.to_be_bytes().to_vec()].concat()
			}
		}
		Value::String(s) => [head(3, s.len() as u64), s.as_bytes().to_vec()].concat(),
		Value::Array(a) => {
			let mut out = head(4, a.len() as u64);
			for x in a {
				out.extend(cbor(x));
			}
			out
		}
		Value::Object(o) => {
			let mut ints: Vec<(i64, &Value)> = o.iter().filter_map(|(k, x)| int_key(k).map(|i| (i, x))).collect();
			ints.sort_by_key(|e| e.0);
			let mut out = head(5, o.len() as u64);
			for (k, x) in ints {
				out.extend(int(k));
				out.extend(cbor(x));
			}
			for (k, x) in o.iter().filter(|(k, _)| int_key(k).is_none()) {
				out.extend(cbor(&Value::String(k.clone())));
				out.extend(cbor(x));
			}
			out
		}
	}
}

fn b64(b: &[u8]) -> String {
	const A: &[u8] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	let mut s = String::new();
	for c in b.chunks(3) {
		let n = (c[0] as u32) << 16 | (*c.get(1).unwrap_or(&0) as u32) << 8 | *c.get(2).unwrap_or(&0) as u32;
		for i in 0..4 {
			s.push(if i <= c.len() { A[(n >> (18 - 6 * i)) as usize & 63] as char } else { '=' });
		}
	}
	s
}

// ---------------------------------------------------------------- a synthetic QuestieDB install

/// (name, type, structure, constant) per field; synthetic indices, the decoder reads them from the
/// meta files.
type F = (&'static str, &'static str, Option<&'static str>, Option<i64>);
fn metas(entity: &str) -> Vec<F> {
	match entity {
		"Quest" => vec![
			("name", "string", None, None),
			("startedBy", "table", Some("questgivers"), None),
			("finishedBy", "table", Some("questgivers"), None),
			("requiredLevel", "number", None, None),
			("questLevel", "number", None, None),
			("requiredRaces", "number", None, None),
			("objectivesText", "table", Some("stringarray"), None),
			("objectives", "table", Some("objectives"), None),
			("preQuestSingle", "table", Some("idarray"), None),
			("preQuestGroup", "table", Some("idarray"), None),
			("exclusiveTo", "table", Some("idarray"), None),
			("nextQuestInChain", "number", None, None),
			("breadcrumbs", "table", Some("idarray"), None),
			("triggerEnd", "table", Some("trigger"), None),
			("zoneOrSort", "number", None, None),
			("requiredClasses", "number", None, None),
			("retired", "number", None, Some(7)),
			("breadcrumbForQuestId", "number", None, None),
			("parentQuest", "number", None, None),
			("childQuests", "table", Some("idarray"), None),
			("requiredSkill", "table", Some("pair"), None),
		],
		"Npc" => vec![
			("name", "string", None, None),
			("minLevel", "number", None, None),
			("maxLevel", "number", None, None),
			("spawns", "table", Some("spawnlist"), None),
			("friendlyToFaction", "string", None, None),
			("npcFlags", "number", None, None),
			("questStarts", "table", Some("idarray"), None),
			("rank", "number", None, None),
			("minLevelHealth", "number", None, Some(0)),
		],
		"Object" => vec![
			("name", "string", None, None),
			("spawns", "table", Some("spawnlist"), None),
			("questStarts", "table", Some("idarray"), None),
			("questEnds", "table", Some("idarray"), None),
			("factionID", "number", None, None),
		],
		_ => vec![("name", "string", None, None), ("npcDrops", "table", Some("idarray"), None), ("objectDrops", "table", Some("idarray"), None), ("vendors", "table", Some("idarray"), None)],
	}
}

fn meta_lua(entity: &str) -> String {
	let f = metas(entity);
	let list = |pick: &dyn Fn(&F) -> Option<String>| f.iter().enumerate().filter_map(|(i, x)| pick(x).map(|v| format!("[{}]={v}", i + 1))).collect::<Vec<_>>().join(", ");
	format!(
		"local _, LibQuestieDB = ...\nlocal meta = {{\n  entity = '{entity}', metaPrefix = '{entity}-', fieldCount = {},\n  names = {{ {} }},\n  types = {{ {} }},\n  structures = {{ {} }},\n  constantValues = {{ {} }},\n}}\nreturn meta\n",
		f.len(),
		list(&|x| Some(format!("'{}'", x.0))),
		list(&|x| Some(format!("'{}'", x.1))),
		list(&|x| x.2.map(|s| format!("'{s}'"))),
		list(&|x| x.3.map(|n| n.to_string())),
	)
}

/// records: id -> { field: value } -> TOC lines. `chunk`: ids whose scalar row is a two-part chunked
/// value; `hidden`: (id, field, value) tables stored without their presence bit.
fn store_lines(entity: &str, records: &Map<String, Value>, chunk: &[i64], hidden: &[(i64, &str, Value)]) -> Vec<String> {
	let fields = metas(entity);
	let mut ids: Vec<i64> = records.keys().map(|k| k.parse().unwrap()).collect();
	ids.sort();
	let mut z = flate2::write::ZlibEncoder::new(Vec::new(), flate2::Compression::default());
	z.write_all(&cbor(&json!(ids))).unwrap();
	let enc = b64(&z.finish().unwrap());
	let mut lines = vec![format!("## X-{entity}-IDS: ~2~"), format!("## X-{entity}-IDS-1: {}", &enc[..10]), format!("## X-{entity}-IDS-2: {}", &enc[10..])];
	for id in &ids {
		let rec = &records[&id.to_string()];
		let mut row = Map::new();
		let mut p = 0u64;
		for (i, (name, ty, _, constant)) in fields.iter().enumerate() {
			let Some(v) = rec.get(*name) else { continue };
			if constant.is_some() {
				continue;
			}
			if *ty == "table" {
				p += 1 << i;
				lines.push(format!("## X-{entity}-{id}-{}: {}", i + 1, b64(&cbor(v))));
			} else {
				row.insert((i + 1).to_string(), v.clone());
			}
		}
		row.insert("p".into(), json!(p));
		let s = b64(&cbor(&Value::Object(row)));
		if chunk.contains(id) {
			lines.extend([format!("## X-{entity}-{id}-S: ~2~"), format!("## X-{entity}-{id}-S-1: {}", &s[..7]), format!("## X-{entity}-{id}-S-2: {}", &s[7..])]);
		} else {
			lines.push(format!("## X-{entity}-{id}-S: {s}"));
		}
	}
	for (id, name, v) in hidden {
		let i = fields.iter().position(|f| f.0 == *name).unwrap();
		lines.push(format!("## X-{entity}-{id}-{}: {}", i + 1, b64(&cbor(v))));
	}
	lines
}

fn quests() -> Value {
	json!({
		"100": { "name": "Fixture Calling (Questie)", "questLevel": 3, "requiredLevel": 1, "startedBy": [[1]], "finishedBy": [[2]], "objectivesText": ["Speak with Alice."] },
		"101": {
			"name": "Wolf Trouble", "questLevel": 3, "requiredLevel": 2, "requiredRaces": 77, "requiredClasses": 1,
			"startedBy": [[2]], "finishedBy": [[2]],
			"objectivesText": ["Bring 3 pieces of Wolf Pelt, and kill 10 Fixture Wolves and 4 Fixture Wolf Alphas for Alice."],
			"objectives": [[{ "1": 3, "3": 0 }, { "1": 4, "3": 0 }], [], [{ "1": 50, "3": 0 }]],
			"preQuestSingle": [100], "exclusiveTo": [102, 105], "breadcrumbs": [103], "childQuests": [104], "requiredSkill": [393, 1]
		},
		"102": { "name": "Fixture Altar", "questLevel": 4, "requiredLevel": 2, "startedBy": [[], [500]], "finishedBy": [[], [500]], "preQuestSingle": [101, 102, 100] },
		"92461": { "name": "The Missing Scholar", "questLevel": 5, "requiredLevel": 2, "startedBy": { "2": [700] } },
		"92460": {
			"name": "Coming of Age", "questLevel": 1, "requiredLevel": 1, "requiredRaces": 12884901888u64,
			"startedBy": [[251362]], "finishedBy": [[251361]], "objectivesText": ["Find the shrine.", "", "Return to Rorian."],
			"preQuestGroup": [100], "zoneOrSort": 16593, "triggerEnd": ["Find the shrine", { "16593": [[40.5, 60.25]] }],
			"breadcrumbForQuestId": 92461, "parentQuest": 100, "retired": 99
		}
	})
}

fn npcs() -> Value {
	json!({
		"1": { "name": "Bob", "minLevel": 20, "maxLevel": 20, "spawns": { "12": [[48.9, 41.6]] }, "friendlyToFaction": "A", "npcFlags": 10 },
		"2": { "name": "Alice", "minLevel": 5, "maxLevel": 6, "rank": 1, "spawns": { "12": [[42.1, 65.9]], "1519": [[60, 60]] }, "friendlyToFaction": "AH", "npcFlags": 6, "questStarts": [101] },
		"3": { "name": "Fixture Wolf", "minLevel": 2, "maxLevel": 3, "spawns": { "12": [[21, 31]] }, "friendlyToFaction": "AH", "npcFlags": 0 },
		"251361": { "name": "Rorian the Dayseeker", "minLevel": 1, "maxLevel": 1, "spawns": { "16593": [[44, 25]] }, "friendlyToFaction": "AH", "npcFlags": 2 },
		"251362": { "name": "Ailee Farheart", "minLevel": 1, "maxLevel": 1, "spawns": { "16593": [[42.82, 23.37], [-1, -1]] }, "friendlyToFaction": "AH", "npcFlags": 2, "questStarts": [92460] }
	})
}

fn objects() -> Value {
	json!({
		"500": { "name": "Fixture Altar", "spawns": { "12": [[30.12, 40.99]] } },
		"700": { "name": "Bloodstained Satchel", "spawns": { "16593": [[53.25, 72.17]] }, "questStarts": [92461], "questEnds": [92461] },
		"600": { "name": "Peacebloom", "spawns": { "1519": [[10, 10]] } }
	})
}

fn items() -> Value {
	json!({
		"50": { "name": "Wolf Pelt", "npcDrops": [3, 4] },
		"52": { "name": "Fixture Schematic", "vendors": [2] },
		"252665": { "name": "Head of Urs'anah", "npcDrops": [251361] }
	})
}

/// The store's drop tables: the observed one (its variable named for the web source it came from,
/// spelled in parts as the reader does) and the server one.
fn drops_lua(web: &str, server: &str) -> String {
	format!("local D = QuestieLoader:CreateModule(\"QuestieClassicItemDrops\")\nD.{}Data = [[return {{\n{web}}}]]\nD.cmangosData = [[return {{\n{server}}}]]\n", ["wow", "head"].concat())
}
const DROP_FIXES: &str = "local DropDB = QuestieLoader:ImportModule(\"DropDB\")\nlocal K = DropDB.correctionKeys\nlocal C = QuestieLoader:CreateModule(\"QuestieItemDropCorrections\")\nC.Era = {\n  [50] = { [3] = K.PSERVER },\n  [252665] = { [251361] = 100 },\n}\n";

#[derive(Default)]
struct Store {
	quests: Value,
	npcs: Value,
	objects: Value,
	items: Value,
	files: Vec<(&'static str, String)>,
}

fn merged(base: Value, extra: &Value) -> Map<String, Value> {
	let mut m = base.as_object().unwrap().clone();
	if let Some(e) = extra.as_object() {
		for (k, v) in e {
			m.insert(k.clone(), v.clone());
		}
	}
	m
}

fn write_questie(dir: &Path, store: &Store) -> PathBuf {
	let q = dir.join("QuestieDB");
	let w = |rel: &str, text: &str| {
		let f = q.join(rel);
		std::fs::create_dir_all(f.parent().unwrap()).unwrap();
		std::fs::write(f, text).unwrap();
	};
	let mut toc: Vec<String> = [
		"## Interface: 16001",
		"## Title: QuestieDB",
		"## Author: Fixture Authors",
		"## Version: 9.9.9",
		"## X-Contract-Version: 3",
		"## X-Flavor: Forever",
		"## X-Mode: baked",
		"## X-BUILD-COMMIT: abc123",
		"## X-BUILD-TIME: 2026-01-01T00:00:00Z",
		"",
	]
	.map(String::from)
	.to_vec();
	toc.extend(store_lines("Quest", &merged(quests(), &store.quests), &[92460], &[(92460, "breadcrumbs", json!([7]))]));
	toc.extend(store_lines("Npc", &merged(npcs(), &store.npcs), &[], &[]));
	toc.extend(store_lines("Object", &merged(objects(), &store.objects), &[], &[]));
	toc.extend(store_lines("Item", &merged(items(), &store.items), &[], &[]));
	toc.extend(["".into(), "src\\config.lua".into(), "".into()]);
	w("QuestieDB_Forever.toc", &toc.join("\r\n"));
	for (e, f) in [("Quest", "questMeta.lua"), ("Npc", "npcMeta.lua"), ("Object", "objectMeta.lua"), ("Item", "itemMeta.lua")] {
		w(&format!("src/meta/{f}"), &meta_lua(e));
	}
	w("support/Forever/QuestXP/xpDB-classic.lua", "local QuestXP = QuestieLoader:ImportModule(\"QuestXP\");\nQuestXP.db = {\n  [100] = {1, 85},\n  [101] = {3, 170},\n  [92460] = {1, 40},\n}\n");
	w("support/Forever/DropTables/classicItemDrops.lua", &drops_lua("  [50] = { [3] = 12.5, [4] = 20 },\n", "  [50] = { [4] = 70.0 },\n"));
	w("support/Forever/DropTables/itemDropCorrections.lua", DROP_FIXES);
	w(
		"support/Forever/Zones/areaIdToUiMapId.lua",
		"local ZoneDB = QuestieLoader:ImportModule(\"ZoneDB\")\nZoneDB.private.areaIdToUiMapIdOverride = [[return { [0] = 0 }]]\nZoneDB.private.areaIdToUiMapId = [[return {\n  [12] = 1429, [87] = 1429, [1519] = 1453, [16593] = 2521,\n}]]\n",
	);
	w(
		"support/Forever/Zones/uiMapIdToAreaId.lua",
		"local ZoneDB = QuestieLoader:ImportModule(\"ZoneDB\")\nZoneDB.private.uiMapIdToAreaId = [[return {\n  [1429] = 12, [1453] = 1519, [2521] = 16593,\n}]]\n",
	);
	w("support/Forever/FactionTemplates/factionTemplateClassic.lua", "local Q = QuestieLoader:ImportModule(\"QuestieDB\")\nQ.factionTemplate = { [12] = 4, [29] = 2, [35] = 0, [99] = 6 }\n");
	w(
		"src/support/eraToForever.lua",
		"-- DBC bounds: 1.15.9.1 -> 1.60.1.2. Assumes unchanged world positions.\nlocal transforms = {\n  [1519] = { 0.77, 19.68, 0.77, 24.43 }, -- Stormwind City\n}\nlocal uiMapToArea = {\n  [1453] = 1519, -- Stormwind City\n}\n",
	);
	w("../Questie/Questie_Camelot.toc", "## Title: Questie\n## Version: 8.8.8\n## Author: Fixture Questie Authors\n## X-BUILD-COMMIT: def456\n");
	for (rel, text) in &store.files {
		w(rel, text);
	}
	q
}

/// A fresh folder for one build.
fn scratch(name: &str) -> PathBuf {
	crate::common::scratch(&format!("questie-{name}"))
}

/// The JS build's options over the store (no recordings unless `recordings`), and its output.
fn build_with(name: &str, store: &Store, tweak: &dyn Fn(&mut forge_data::Options)) -> Built {
	let root = scratch(name);
	let mut o = options(Some(&root.join("no-recordings")));
	o.questie = Some(write_questie(&root, store));
	tweak(&mut o);
	Built { out: run(&o, &|_| {}).unwrap() }
}

fn build(name: &str, store: &Store) -> Built {
	build_with(name, store, &|_| {})
}

fn s(v: &forge_guide::js::V) -> Value {
	serde_json::from_str(&forge_guide::js::stringify(v, None)).unwrap()
}

// ---------------------------------------------------------------- the decoder

#[test]
fn cbor_round_trips_and_the_odd_shapes() {
	use forge_data::questie::decode_cbor;
	for v in [
		json!(0),
		json!(23),
		json!(24),
		json!(255),
		json!(65535),
		json!(65536),
		json!(4294967295u64),
		json!(12884901888u64),
		json!(-1),
		json!(-500),
		json!(1.5),
		json!(-48.92),
		json!("Urs'anah ü"),
		json!(""),
		json!([1, [2, [3]], "x"]),
		json!(true),
		json!(false),
	] {
		assert_eq!(s(&decode_cbor(&cbor(&v)).unwrap()), v, "{v}");
	}
	assert_eq!(s(&decode_cbor(&cbor(&json!({ "1": "a", "2": "b" }))).unwrap()), json!(["a", "b"]), "keys 1..n read back as a list");
	assert_eq!(s(&decode_cbor(&cbor(&json!({ "1": 182, "3": 0 }))).unwrap()), json!({ "1": 182, "3": 0 }));
	assert_eq!(s(&decode_cbor(&cbor(&json!({ "16593": [[40.5, 60.25]], "p": 6 }))).unwrap()), json!({ "16593": [[40.5, 60.25]], "p": 6 }));
	assert_eq!(s(&decode_cbor(&[0xf9, 0x3e, 0x00]).unwrap()), json!(1.5), "half float");
	assert_eq!(s(&decode_cbor(&[0xfa, 0x3f, 0xc0, 0x00, 0x00]).unwrap()), json!(1.5), "single float");
	assert_eq!(s(&decode_cbor(&[0x43, 0x41, 0x42, 0x43]).unwrap()), json!("ABC"), "byte string");
	assert_eq!(s(&decode_cbor(&[0xc1, 0x05]).unwrap()), json!(5), "tag");
	assert_eq!(s(&decode_cbor(&[0x9f, 0x01, 0x02, 0xff]).unwrap()), json!([1, 2]), "indefinite array");
	assert_eq!(s(&decode_cbor(&[0x83, 0x01, 0xf6, 0x03]).unwrap()), json!({ "1": 1, "3": 3 }), "a nil hole breaks the list, as in Lua");
	assert!(decode_cbor(&[0x01, 0x02]).unwrap_err().contains("trailing"));
	assert!(decode_cbor(&[0x82, 0x01]).unwrap_err().contains("truncated"));
}

#[test]
fn reads_every_entity_with_defaults_presence_masks_constants_and_support_data() {
	let root = scratch("read");
	let dir = write_questie(&root, &Store::default());
	assert_eq!(forge_data::questie::questie_db_dir(&root), Some(dir.clone()), "an AddOns folder resolves to its QuestieDB");
	let qz = forge_data::questie::read_questie(&dir, &|_| {}).unwrap();
	assert_eq!(qz.quests.keys().copied().collect::<Vec<_>>(), [100, 101, 102, 92460, 92461]);
	let q = |id: i64, k: &str| s(&qz.quests[&id].get(k));
	assert_eq!(q(92461, "startedBy"), json!({ "2": [700] }), "sparse questgivers: a Lua table with a hole");
	assert_eq!(q(92460, "name"), json!("Coming of Age"), "chunked scalar row");
	assert_eq!(q(92460, "requiredRaces"), json!(12884901888u64));
	assert_eq!(q(92460, "startedBy"), json!([[251362]]));
	assert_eq!(q(92460, "triggerEnd"), json!(["Find the shrine", { "16593": [[40.5, 60.25]] }]));
	assert!(qz.quests[&92460].get("breadcrumbs").is_undef(), "a table without its presence bit is not read");
	assert_eq!(q(92460, "retired"), json!(7), "constant fields read back as the schema constant");
	assert_eq!(q(92460, "nextQuestInChain"), json!(0), "absent numbers read back as 0");
	assert_eq!(q(100, "objectives"), json!([]), "objectives default to an empty table");
	assert_eq!(q(102, "startedBy"), json!([[], [500]]));
	assert!(qz.quests[&100].get("preQuestSingle").is_undef());
	assert_eq!(s(&qz.npcs[&251362].get("minLevelHealth")), json!(0));
	assert_eq!(s(&qz.npcs[&2].get("spawns")), json!({ "12": [[42.1, 65.9]], "1519": [[60, 60]] }));
	assert_eq!(s(&qz.objects[&500].get("factionID")), json!(0), "absent object faction templates keep the numeric default");
	assert_eq!(s(&qz.items[&50].get("npcDrops")), json!([3, 4]));
	assert_eq!(qz.xp[&92460], (Some(1.0), Some(40.0)));
	assert_eq!(qz.faction_templates.iter().map(|(k, v)| (*k, *v)).collect::<Vec<_>>(), [(12, 4.0), (29, 2.0), (35, 0.0), (99, 6.0)]);
	assert_eq!((qz.area_to_ui_map[&16593], qz.ui_map_to_area[&2521]), (2521.0, 16593.0));
	assert_eq!(qz.era_to_forever.ui_map_to_area.iter().map(|(k, v)| (*k, *v)).collect::<Vec<_>>(), [(1453, 1519)]);
	let qi = qz.questie.as_ref().unwrap();
	assert_eq!(
		(qi.title.as_deref(), qi.version.as_deref(), qi.author.as_deref(), qi.build_commit.as_deref(), qi.build_time.as_deref()),
		(Some("Questie"), Some("8.8.8"), Some("Fixture Questie Authors"), Some("def456"), None)
	);
	// DropDB.GetItemDroprate order: the correction (a reference falls through), the server table, the web one.
	let rate = |i, n| forge_data::questie::drop_rate(&qz.drops, i, n).map(|r| (r.chance, r.source));
	assert_eq!(rate(50, 3), Some((12.5, "web")));
	assert_eq!(rate(50, 4), Some((70.0, "cmangos")));
	assert_eq!(rate(252665, 251361), Some((100.0, "questie")));
	assert_eq!(rate(50, 99), None);
}

#[test]
fn race_masks_keep_the_skyborne_bits_and_all_races_is_unrestricted() {
	use forge_data::merge::race_mask;
	use forge_guide::js::V;
	assert_eq!(race_mask(&V::Num(77.0)), Some(77.0));
	assert_eq!(race_mask(&V::Num(4294967296.0)), Some(4294967296.0));
	assert_eq!(race_mask(&V::Num(255.0 + 4294967296.0 + 8589934592.0)), None);
	assert_eq!(race_mask(&V::Num(255.0)), Some(255.0), "every Era race but no Skyborne is a restriction");
	assert_eq!(race_mask(&V::Num(0.0)), None);
}

#[test]
fn refuses_a_store_that_is_not_baked_forever_and_a_chunk_missing_a_part() {
	let root = scratch("flavour");
	let dir = write_questie(&root, &Store::default());
	let toc = dir.join("QuestieDB_Forever.toc");
	let text = std::fs::read_to_string(&toc).unwrap();
	std::fs::write(&toc, text.replace("## X-Flavor: Forever", "## X-Flavor: Era")).unwrap();
	assert!(forge_data::questie::read_questie(&dir, &|_| {}).err().unwrap().contains("flavor Era, not Forever"));
	let cut: Vec<&str> = text.split("\r\n").filter(|l| !l.starts_with("## X-Quest-92460-S-2:")).collect();
	std::fs::write(&toc, cut.join("\r\n")).unwrap();
	assert!(forge_data::questie::read_questie(&dir, &|_| {}).err().unwrap().contains("declares 2 parts but part 2 is missing"));
}

// ---------------------------------------------------------------- the merge

fn mailbox(faction: Option<i64>, at: [f64; 2]) -> Value {
	let mut m = json!({ "name": "Mailbox", "spawns": { "12": [at] } });
	if let Some(f) = faction {
		m["factionID"] = json!(f);
	}
	m
}

#[test]
fn mailboxes_keep_their_role_and_side_through_pfquest_and_recordings() {
	let store = Store {
		objects: json!({
			"500": mailbox(Some(29), [30.0, 40.0]), "600": mailbox(Some(12), [30.0, 40.0]), "801": mailbox(Some(35), [30.0, 40.0]), "802": mailbox(Some(99), [30.0, 40.0]),
			"803": mailbox(Some(999), [30.0, 40.0]), "804": mailbox(None, [31.0, 41.0]), "805": { "name": "mailbox", "factionID": 35, "spawns": { "12": [[32, 42]] } }
		}),
		..Default::default()
	};
	let b = build_with("mailboxes", &store, &|o| o.recordings = fixture().join("recordings"));
	let o = b.read("objects");
	assert_eq!((&o["500"]["roles"], &o["500"]["faction"], &o["500"]["name"]), (&json!(["mailbox"]), &json!("H"), &json!("Fixture Altar")));
	assert_eq!(o["500"]["spawns"], json!({ "1429": { "f": "l", "pts": [[31.5, 41.25]] } }));
	let keys: Vec<&String> = o["500"].as_object().unwrap().keys().take(5).collect();
	assert_eq!(keys, ["id", "name", "roles", "faction", "spawns"]);
	assert_eq!((&o["600"]["roles"], &o["600"]["faction"]), (&json!(["herb", "mailbox"]), &json!("A")), "pfQuest gathering roles survive");
	assert_eq!((&o["801"]["faction"], &o["804"]["faction"]), (&json!("AH"), &json!("AH")));
	for id in ["802", "803"] {
		assert_eq!((&o[id]["roles"], &o[id]["faction"]), (&json!(["mailbox"]), &Value::Null), "{id}: hostile-both or unknown template stays unknown");
	}
	assert!(o["805"].get("roles").is_none() && o["805"].get("faction").is_none(), "the exact English name classifies");
}

#[test]
fn services_keep_close_spawns_spirit_guides_and_fill_only_missing_service_sides() {
	let pts = json!([[30, 40], [30.1, 40.1]]);
	let npc = |flags: i64, side: &str| json!({ "name": "Fixture Service", "minLevel": 10, "spawns": { "12": pts }, "npcFlags": flags, "friendlyToFaction": side });
	let store = Store {
		npcs: json!({ "2": npc(4, "H"), "3": npc(4, "H"), "4": npc(0, "A"), "812": npc(96, "AH") }),
		objects: json!({ "813": { "name": "Mailbox", "factionID": 35, "spawns": { "12": pts } }, "814": { "name": "Fixture Stone", "spawns": { "12": pts } } }),
		..Default::default()
	};
	let b = build_with("services", &store, &|o| o.cap = 1);
	let (n, o) = (b.read("npcs"), b.read("objects"));
	assert_eq!((&n["2"]["faction"], &n["3"]["faction"], &n["4"]["faction"]), (&json!("AH"), &json!("H"), &Value::Null));
	assert_eq!(n["812"]["roles"], json!(["spirithealer"]));
	for e in [&n["3"], &n["812"], &o["813"]] {
		let sp = &e["spawns"]["1429"];
		assert_eq!(sp["pts"].as_array().unwrap().len(), 1);
		let mut all: Vec<Value> = sp["pts"].as_array().unwrap().iter().chain(sp["more"].as_array().into_iter().flatten()).cloned().collect();
		all.sort_by(|a, b| a[0].as_f64().partial_cmp(&b[0].as_f64()).unwrap());
		assert_eq!(Value::Array(all), pts, "the cap keeps the other close service point in more");
	}
	assert!(o["814"]["spawns"]["1429"].get("more").is_none(), "ordinary objects keep the spatial reduction");
}

#[test]
fn forever_only_records_shared_records_and_the_store_meta() {
	let b = build("shared", &Store::default());
	let q = b.read("quests");
	assert_eq!(
		q["92460"],
		json!({
			"id": 92460, "title": "Coming of Age", "level": 1, "minLevel": 1, "races": 12884901888u64, "classes": null,
			"start": { "npc": [251362], "object": [], "item": [] }, "end": { "npc": [251361], "object": [] },
			"pre": [100], "excl": [], "next": null,
			"objectives": [{ "type": "event", "id": null, "count": null, "text": "Find the shrine", "map": 2521, "f": "l", "x": 40.5, "y": 60.25 }],
			"objectiveText": "Find the shrine.$B$BReturn to Rorian.", "zone": 2521, "xp": 40, "skill": null, "event": null,
			"source": ["questie-forever"], "preAll": [100], "breadcrumbFor": 92461, "parent": 100, "area": 16593
		})
	);
	let n = b.read("npcs");
	assert_eq!(n["251362"], json!({ "id": 251362, "name": "Ailee Farheart", "level": 1, "faction": "AH", "spawns": { "2521": { "f": "l", "pts": [[42.82, 23.37]] } }, "source": ["questie-forever"] }));
	let items = b.read("items");
	assert_eq!(
		items["252665"],
		json!({ "id": 252665, "name": "Head of Urs'anah", "drops": { "npc": { "251361": 100 }, "object": {} }, "vendors": [], "dropScale": "corrected", "source": ["questie-forever"] })
	);
	assert_eq!(b.read("zones")["2521"], json!({ "id": 2521, "name": null, "areaId": 16593, "parent": null, "type": 3 }));

	assert_eq!((&q["100"]["title"], &q["100"]["level"], &q["100"]["xp"]), (&json!("Fixture Calling (Questie)"), &json!(3), &json!(85)));
	assert_eq!(q["100"]["source"], json!(["pfquest", "questie-forever"]));
	assert_eq!(
		q["101"]["objectives"],
		json!([{ "type": "kill", "id": 3, "count": 10, "text": "Fixture Wolf" }, { "type": "kill", "id": 4, "count": 4, "text": "Fixture Wolf Alpha" }, { "type": "item", "id": 50, "count": 3, "text": "Wolf Pelt" }]),
		"the game's order, creatures before items; counts from the text"
	);
	let q101 = &q["101"];
	assert_eq!([&q101["pre"], &q101["preAny"], &q101["excl"], &q101["breadcrumbs"], &q101["children"]], [&json!([100]), &json!([100]), &json!([102, 105]), &json!([103]), &json!([104])]);
	assert_eq!([&q101["races"], &q101["skill"], &q101["skillLevel"]], [&json!(77), &json!(393), &json!(1)]);
	assert_eq!((&q["102"]["event"], &q["102"]["skill"]), (&json!(12), &Value::Null), "Forever asks no skill: pfQuest's is dropped");
	assert!(q["102"].get("skillLevel").is_none() && q["102"].get("preAll").is_none());
	assert_eq!(q["102"]["objectives"].as_array().unwrap().len(), 2);
	assert_eq!(q["102"]["preAny"], json!([100]), "never itself or a quest exclusive with it");
	assert_eq!(q["104"]["source"], json!(["pfquest"]));
	let m = b.meta();
	assert_eq!(m["questie"]["notInStore"], json!([104]));
	assert_eq!(m["counts"]["prereqsCleaned"], 1);
	assert_eq!((&n["2"]["roles"], &n["2"]["faction"], &n["3"]["faction"]), (&json!(["vendor"]), &json!("AH"), &Value::Null));
	assert_eq!((&n["1"]["roles"], &n["1"]["source"]), (&json!(["flightmaster"]), &json!(["pfquest", "questie-forever"])));
	assert_eq!(b.read("objects")["600"]["spawns"], json!({ "1429": { "f": "e", "pts": [[33.3, 44.4]] }, "1453": { "f": "l", "pts": [[10, 10]] } }), "gathering nodes keep pfQuest's other maps");
	// One table per item: the server table rates dropper 4, so 3 (observed only) and 5 (pfQuest only) get no number.
	assert_eq!(items["50"]["drops"], json!({ "npc": { "3": null, "4": 70, "5": null }, "object": { "600": 2.5 } }));
	assert_eq!(items["50"]["dropScale"], "server");
	assert_eq!(m["counts"]["dropRatesMixedAvoided"], 2);
	assert_eq!(items["53"]["dropScale"], Value::Null, "an item QuestieDB does not hold, with no rated npc dropper");
	assert_eq!((&items["52"]["vendors"], &items["52"]["source"]), (&json!([1, 2]), &json!(["pfquest", "questie-forever"])), "a shorter vendor list never drops pfQuest's");
	assert_eq!(m["counts"]["itemsRegainedEntries"], 2);
	let src = m["sources"].as_array().unwrap().iter().find(|s| s["name"].as_str().unwrap().contains("QuestieDB")).unwrap();
	assert_eq!((&src["revision"], &src["questie"]["version"]), (&json!("9.9.9 abc123"), &json!("8.8.8")));
	assert!(src["license"].as_str().unwrap().contains("all rights reserved"));
	assert_eq!(m["counts"]["questieOnlyQuests"], 2);
	assert_eq!(q["92461"]["start"], json!({ "npc": [], "object": [700], "item": [] }), "sparse questgivers keep the object slot");
	assert_eq!(q["92461"]["end"], json!({ "npc": [], "object": [700] }), "the ender from the object's questEnds");
	assert_eq!((&m["counts"]["reverseLinks"], &m["counts"]["questsWithXp"]), (&json!(1), &json!(3)));
	// Frames: Era points on unchanged maps, live on changed and Forever-only ones.
	assert_eq!(n["2"]["spawns"], json!({ "1429": { "f": "e", "pts": [[42.1, 65.9]] }, "1453": { "f": "l", "pts": [[60, 60]] } }));
	assert_eq!(n["251361"]["spawns"]["2521"]["f"], "l");
	assert_eq!(m["liveFrameMaps"], json!([1453]), "without Forever tables, the store's eraToForever names the changed maps");
}

#[test]
fn drop_rate_tables_one_per_item_and_the_scale_they_give() {
	let tables = drops_lua("  [9001] = { [1] = 0.4, [2] = 12 },\n  [9002] = { [3] = 5 },\n  [9003] = { [3] = 5 },\n", "  [9002] = { [1] = 30 },\n  [9003] = { [1] = 30 },\n");
	let fixes = "local DropDB = QuestieLoader:ImportModule(\"DropDB\")\nlocal K = DropDB.correctionKeys\nlocal C = QuestieLoader:CreateModule(\"QuestieItemDropCorrections\")\nC.Era = {\n  [9002] = { [2] = 80 },\n  [9003] = { [2] = 80 },\n}\n";
	let store = Store {
		items: json!({ "9001": { "name": "Observed", "npcDrops": [1, 2] }, "9002": { "name": "Server", "npcDrops": [1, 2, 3] }, "9003": { "name": "Corrected", "npcDrops": [2] } }),
		files: vec![("support/Forever/DropTables/classicItemDrops.lua", tables), ("support/Forever/DropTables/itemDropCorrections.lua", fixes.into())],
		..Default::default()
	};
	let items = build("drops", &store).read("items");
	assert_eq!((&items["9001"]["drops"]["npc"], &items["9001"]["dropScale"]), (&json!({ "1": 0.4, "2": 12 }), &json!("observed")), "only the observed table rates it");
	assert_eq!(
		(&items["9002"]["drops"]["npc"], &items["9002"]["dropScale"]),
		(&json!({ "1": 30, "2": 80, "3": null }), &json!("server")),
		"a corrected dropper keeps its correction beside the server table"
	);
	assert_eq!((&items["9003"]["drops"]["npc"], &items["9003"]["dropScale"]), (&json!({ "2": 80 }), &json!("corrected")), "every rate from corrections");
	// Item 50 with no QuestieDB rate at all: pfQuest's rates stay, on pfQuest's scale.
	assert_eq!((&items["50"]["drops"]["npc"], &items["50"]["dropScale"]), (&json!({ "3": 45.5, "4": 80, "5": 2.5 }), &json!("pfquest")));
}

#[test]
fn recordings_win_over_the_store() {
	let b = build_with("recordings", &Store::default(), &|o| o.recordings = fixture().join("recordings"));
	let q = b.read("quests");
	assert_eq!((&q["100"]["title"], &q["100"]["level"], &q["100"]["xp"]), (&json!("Fixture Calling (Forever)"), &json!(2), &json!(40)));
	assert_eq!(q["100"]["source"], json!(["pfquest", "questie-forever", "recorder:title", "recorder:level", "recorder:start", "recorder:end", "recorder:xp-turnin"]));
	assert_eq!(b.read("npcs")["1"]["spawns"], json!({ "1429": { "f": "l", "pts": [[47.5, 40.25]] } }));
}

#[test]
fn our_corrections_apply_over_the_store() {
	let quest = |name: &str, lvl: i64, giver: i64| json!({ "name": name, "questLevel": lvl, "requiredLevel": 1, "startedBy": [[giver]], "finishedBy": [[giver]] });
	let store = Store {
		quests: json!({
			"377": quest("Crime and Punishment", 26, 2),
			"1486": { "name": "Deviate Hides", "questLevel": 17, "requiredLevel": 13, "startedBy": [[5767], [659159]], "finishedBy": [[5767]] },
			"151": { "name": "Poor Old Blanchy", "questLevel": 10, "requiredLevel": 7, "startedBy": [[238], [696264]], "finishedBy": [[238]] },
			"8227": { "name": "Nat's Measuring Tape", "questLevel": 60, "requiredLevel": 58, "startedBy": [[], [180366], [19973]], "finishedBy": [[12919]] },
			"91901": quest("A Sealed Crate", 60, 256386),
			"79358": { "name": "Storm, Earth, and Fire", "questLevel": 40, "requiredLevel": 30, "startedBy": [[259023]], "finishedBy": [[4722, 259023]] }
		}),
		npcs: json!({
			"5767": { "name": "Nalpak", "minLevel": 22, "maxLevel": 22, "spawns": { "17": [[46, 35.7]] }, "friendlyToFaction": "AH", "npcFlags": 2, "questStarts": [1486] },
			"238": { "name": "Verna Furlbrow", "minLevel": 14, "maxLevel": 14, "spawns": { "40": [[59.9, 19.4]] }, "friendlyToFaction": "A", "npcFlags": 2, "questStarts": [151] },
			"12919": { "name": "Nat Pagle", "minLevel": 45, "maxLevel": 45, "spawns": { "15": [[58.6, 60.1]] }, "friendlyToFaction": "AH", "npcFlags": 2 },
			"256386": { "name": "Dokimi", "minLevel": 30, "maxLevel": 30, "spawns": { "17": [[50.15, 29.35]] }, "friendlyToFaction": "H", "npcFlags": 2, "questStarts": [91901] },
			"4722": { "name": "Rau Cliffrunner", "minLevel": 30, "maxLevel": 30, "spawns": { "400": [[46.1, 51.7]] }, "friendlyToFaction": "H", "npcFlags": 2 },
			"259023": { "name": "Veyric Thunderhame", "minLevel": 40, "maxLevel": 40, "spawns": { "45": [[59.8, 27.6]] }, "friendlyToFaction": "A", "npcFlags": 2, "questStarts": [79358] }
		}),
		objects: json!({
			"659159": { "name": "Mailbox", "spawns": { "1637": [[50.9, 70.4]] }, "questStarts": [1486] },
			"696264": { "name": "Mailbox", "spawns": { "1519": [[61.7, 70.7]] }, "questStarts": [151] },
			"180366": { "name": "Battered Tackle Box", "spawns": {}, "questStarts": [8227] }
		}),
		files: vec![(
			"support/Forever/QuestXP/xpDB-classic.lua",
			"local QuestXP = QuestieLoader:ImportModule(\"QuestXP\");\nQuestXP.db = {\n  [377] = {26, 2100},\n  [1486] = {17, 1600},\n}\n".into(),
		)],
		..Default::default()
	};
	let q = build("corrections", &store).read("quests");
	assert_eq!((&q["377"]["xp"], &q["1486"]["xp"]), (&json!(4400), &json!(3100)), "dungeon quests' Forever XP over the store's QuestXP");
	for id in ["377", "1486"] {
		assert!(q[id]["source"].as_array().unwrap().contains(&json!("polestar-correction")), "{id} is tagged");
	}
	assert_eq!(q["1486"]["start"], json!({ "npc": [5767], "object": [], "item": [] }), "not the mailbox");
	assert_eq!(q["151"]["start"], json!({ "npc": [238], "object": [], "item": [] }));
	assert_eq!(q["8227"]["start"], json!({ "npc": [], "object": [180366], "item": [] }), "only the tackle box");
	assert_eq!(q["91901"]["start"], json!({ "npc": [256386, 256390], "object": [], "item": [] }), "both factions' representatives");
	assert_eq!(q["79358"]["end"], json!({ "npc": [4722, 259023], "object": [] }));
}

#[test]
fn objectives_in_the_games_order_triggers_nearest_the_giver_and_the_stores_hints() {
	let quest = |name: &str| json!({ "name": name, "questLevel": 3, "requiredLevel": 1, "startedBy": [[2]], "finishedBy": [[2]], "objectives": [[{ "1": 3 }], [], [{ "1": 50 }]] });
	let camps = |name: &str, giver: i64| json!({ "name": name, "questLevel": 3, "requiredLevel": 1, "startedBy": [[giver]], "finishedBy": [[giver]], "triggerEnd": ["Find a camp", { "12": [[80, 20], [44, 62], [10, 90]] }] });
	let store = Store {
		quests: json!({
			"891": {
				"name": "The Guns of Northwatch", "questLevel": 20, "requiredLevel": 13, "startedBy": [[2]], "finishedBy": [[2]],
				"objectivesText": ["Captain Thalo'thas Brightsun of Ratchet wants you to collect 10 Theramore Medals and slay Captain Fairmount, Cannoneer Whessan and Cannoneer Smythe."],
				"objectives": [[{ "1": 3393, "2": "Captain Fairmount" }, { "1": 3455, "2": "Cannoneer Whessan" }, { "1": 3454, "2": "Cannoneer Smythe" }], [], [{ "1": 5078, "2": "Theramore Medal" }]]
			},
			"110": {
				"name": "Fixture Order", "questLevel": 3, "requiredLevel": 1, "startedBy": [[2]], "finishedBy": [[2]],
				"objectivesText": ["Scout the ridge, question Bob, bring 3 Wolf Pelts, light the Fixture Altar and kill 5 Fixture Wolves."],
				"objectives": { "1": [{ "1": 3 }], "2": [{ "1": 500 }], "3": [{ "1": 50 }], "5": [{ "1": [1, 2], "2": 1, "3": "Bob questioned" }] },
				"triggerEnd": ["Scout the ridge", { "12": [[50, 50]] }]
			},
			"111": quest("Fixture Item First"), "112": quest("Fixture Commented"), "113": quest("Fixture Era"), "114": quest("Fixture Season"),
			"130": camps("Fixture Camps", 2), "131": camps("Fixture Camps Elsewhere", 251361)
		}),
		files: vec![
			("src/corrections/Forever/legacy/classicQuestFixes.lua", "QuestieCorrections.itemObjectiveFirst[111] = true\n-- QuestieCorrections.itemObjectiveFirst[112] = true\n".into()),
			("src/corrections/Era/classicQuestFixes.lua", "QuestieCorrections.itemObjectiveFirst[113] = true\n".into()),
			("src/corrections/Sod/sodQuestFixes.lua", "QuestieCorrections.itemObjectiveFirst[114] = true\n".into()),
		],
		..Default::default()
	};
	let q = build("order", &store).read("quests");
	let order = |id: &str| {
		q[id]["objectives"]
			.as_array()
			.unwrap()
			.iter()
			.map(|o| format!("{} {}", o["type"].as_str().unwrap(), if o["id"].is_null() { o["text"].as_str().unwrap().to_string() } else { o["id"].to_string() }))
			.collect::<Vec<_>>()
	};
	assert_eq!(order("891"), ["kill 3393", "kill 3455", "kill 3454", "item 5078"]);
	assert_eq!(q["891"]["objectives"][3]["count"], 10);
	assert_eq!(order("110"), ["kill 3", "object 500", "item 50", "kill 1", "event Scout the ridge"]);
	assert_eq!(order("111"), ["item 50", "kill 3"], "the store's hint moves the item first");
	for id in ["112", "113", "114"] {
		assert_eq!(order(id), ["kill 3", "item 50"], "{id}: commented hints and other scopes' do not count");
	}
	let at = |id: &str| {
		let o = &q[id]["objectives"][0];
		(o["map"].clone(), o["x"].clone(), o["y"].clone())
	};
	assert_eq!(at("130"), (json!(1429), json!(44), json!(62)), "the place nearest the giver on that map");
	assert_eq!(at("131"), (json!(1429), json!(80), json!(20)), "the giver on another map: the first place");
}

/// A gzipped SQL dump at the source cache's pinned path (the build reads any dump that is there).
fn put_dump(sources: &Path, lines: &[String]) -> PathBuf {
	let dir = sources.join("cmangos").join(&forge_data::cmangos::DB_REV[..12]);
	std::fs::create_dir_all(&dir).unwrap();
	let mut z = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
	z.write_all(lines.join("\n").as_bytes()).unwrap();
	std::fs::write(dir.join("classicdb.sql.gz"), z.finish().unwrap()).unwrap();
	dir
}

#[test]
fn objective_counts_the_store_lacks_come_from_the_classic_db_dump() {
	let cols: Vec<String> = ["entry".to_string(), "Title".into()]
		.into_iter()
		.chain((1..=4).map(|i| format!("ReqItemId{i}")))
		.chain((1..=4).map(|i| format!("ReqItemCount{i}")))
		.chain((1..=4).map(|i| format!("ReqCreatureOrGOId{i}")))
		.chain((1..=4).map(|i| format!("ReqCreatureOrGOCount{i}")))
		.collect();
	let row = |entry: i64, items: &[(i64, i64)], kills: &[(i64, i64)]| {
		let pad = |l: &[(i64, i64)]| (0..4).map(|i| l.get(i).copied().unwrap_or((0, 0))).collect::<Vec<_>>();
		let (it, kl) = (pad(items), pad(kills));
		let mut v = vec![entry.to_string(), "'Fixture\\'s quest'".into()];
		v.extend(it.iter().map(|e| e.0.to_string()));
		v.extend(it.iter().map(|e| e.1.to_string()));
		v.extend(kl.iter().map(|e| e.0.to_string()));
		v.extend(kl.iter().map(|e| e.1.to_string()));
		format!("({})", v.join(","))
	};
	let mut dump = vec!["CREATE TABLE `quest_template` (".to_string()];
	dump.extend(cols.iter().map(|c| format!("  `{c}` mediumint NOT NULL DEFAULT '0',")));
	dump.extend(["  PRIMARY KEY (`entry`)".into(), ") ENGINE=MyISAM;".into()]);
	let rows = [
		row(120, &[(50, 6)], &[(3, 8)]),
		row(121, &[], &[(999, 7)]),
		row(122, &[], &[(3, 5), (3, 9)]),
		row(123, &[(50, 2)], &[(4, 10)]),
		row(124, &[], &[(-500, 2), (3, 1)]),
		row(125, &[], &[(999, 1)]),
		row(126, &[(0, 0)], &[]),
	];
	dump.push(format!("INSERT INTO `quest_template` VALUES {};", rows.join(",")));
	let quest = |name: &str, objectives: Value| json!({ "name": name, "questLevel": 3, "requiredLevel": 1, "startedBy": [[2]], "finishedBy": [[2]], "objectivesText": ["Help the camp."], "objectives": objectives });
	let mut q123 = quest("Fixture Text Count", json!([[{ "1": 4 }], [], [{ "1": 50 }]]));
	q123["objectivesText"] = json!(["Kill 4 Fixture Wolf Alphas."]);
	let mut q125 = quest("Fixture Trigger", json!([]));
	q125["triggerEnd"] = json!(["Scout the ridge", { "12": [[50, 50]] }]);
	let store = Store {
		quests: json!({
			"120": quest("Fixture Same Ids", json!([[{ "1": 3 }], [], [{ "1": 50 }]])), "121": quest("Fixture Changed Id", json!([[{ "1": 4 }]])),
			"122": quest("Fixture Conflict", json!([[{ "1": 3 }]])), "123": q123, "124": quest("Fixture Altar", json!([[{ "1": 3 }], [{ "1": 500 }]])),
			"125": q125, "127": quest("Fixture Not In Classic", json!([[{ "1": 3 }]]))
		}),
		..Default::default()
	};
	let sources = scratch("counts-sources");
	crate::common::copy_tree(&fixture().join("sources"), &sources);
	let cache = put_dump(&sources, &dump);
	let b = build_with("counts", &store, &|o| o.sources = sources.clone());
	let q = b.read("quests");
	let counts = |id: &str| q[id]["objectives"].as_array().unwrap().iter().map(|o| format!("{} {} {}", o["type"].as_str().unwrap(), o["id"], o["count"])).collect::<Vec<_>>();
	assert_eq!(counts("120"), ["kill 3 8", "item 50 6"], "the same ids");
	assert_eq!(counts("121"), ["kill 4 7"], "one of its kind on each side");
	assert_eq!(counts("122"), ["kill 3 null"], "two different counts leave null");
	assert_eq!(counts("123"), ["kill 4 4", "item 50 2"], "the text's count is never overwritten");
	assert_eq!(counts("124"), ["kill 3 1", "object 500 2"], "a negative id is an object");
	assert_eq!(counts("125"), ["event null 1"]);
	assert_eq!(counts("127"), ["kill 3 null"]);
	assert!(cache.join("quest_counts.json").exists(), "the extract is cached beside the dump");
	let m = b.meta();
	assert_eq!(m["counts"]["objectiveCountsFromClassicDb"], 7);
	let credit = m["sources"].as_array().unwrap().iter().find(|s| s["name"].as_str().unwrap().contains("quest objective counts")).unwrap();
	assert_eq!(credit["revision"], forge_data::cmangos::DB_REV);
	assert!(credit["license"].as_str().unwrap().starts_with("GPL-3.0"));

	// Without the dump: the counts stay null, one warning, no credit.
	let store = Store { quests: json!({ "121": quest("Fixture Changed Id", json!([[{ "1": 4 }]])) }), ..Default::default() };
	let b = build("no-dump", &store);
	assert_eq!(b.read("quests")["121"]["objectives"][0]["count"], Value::Null);
	let m = b.meta();
	assert_eq!(m["warnings"].as_array().unwrap().iter().filter(|w| w.as_str().unwrap().contains("objective counts unavailable")).count(), 1);
	assert!(!m["sources"].as_array().unwrap().iter().any(|s| s["name"].as_str().unwrap().contains("quest objective counts")));
}

#[test]
fn spawn_heights_from_the_cached_dump_or_one_warning_without_it() {
	let sources = scratch("spawnz-sources");
	crate::common::copy_tree(&fixture().join("sources"), &sources);
	put_dump(
		&sources,
		&[
			"INSERT INTO `creature` VALUES (1,6522,0,1,1389.34,347.315,-65.9567,0,300,300,0,0),(2,3,1,1,-10.04,20.06,30.04,0,300,300,0,0),(3,3,0,1,5,6,7.26,0,300,300,0,0),(4,3,530,1,5,6,7,0,300,300,0,0),(5,0,1,1,100,200,-0.04,0,300,300,0,0),(6,3,1,1,-10.04,20.06,30.04,0,300,300,0,0);".into(),
			"INSERT INTO `creature_spawn_entry` VALUES (5,7),(5,8),(99,9);".into(),
			"INSERT INTO `gameobject` VALUES (10,176080,0,1,1.25,2.25,3.25,0,0,0,0,0,0,0),(11,1617,369,1,1,1,1,0,0,0,0,0,0,0);".into(),
			"INSERT INTO `quest_template` VALUES (1,'(not a spawn)');".into(),
		],
	);
	let mut o = options(None);
	o.sources = sources.clone();
	let a = run(&o, &|_| {}).unwrap();
	let b = run(&o, &|_| {}).unwrap();
	let spawnz = &a.files.iter().find(|(n, _)| n == "spawnz").expect("spawnz.json is written").1;
	assert_eq!(spawnz, &b.files.iter().find(|(n, _)| n == "spawnz").unwrap().1, "deterministic");
	let v: Value = serde_json::from_str(spawnz).unwrap();
	assert_eq!(v["npc"]["3"], json!([[0, 5, 6, 7.3], [1, -10, 20.1, 30]]), "maps 0 and 1 only, a tenth of a yard, one entry per place");
	assert_eq!(v["npc"]["7"], json!([[1, 100, 200, 0]]), "pooled entries");
	assert_eq!(v["object"]["176080"], json!([[0, 1.3, 2.3, 3.3]]));
	let meta: Value = serde_json::from_str(&a.files.iter().find(|(n, _)| n == "meta").unwrap().1).unwrap();
	assert!(meta["sources"].as_array().unwrap().iter().any(|s| s["name"].as_str().unwrap().contains("spawn heights")));

	let c = run(&options(None), &|_| {}).unwrap();
	assert!(!c.files.iter().any(|(n, _)| n == "spawnz"), "no dump: no spawnz.json");
	assert_eq!(c.warnings.iter().filter(|w| w.contains("spawn heights unavailable")).count(), 1);
}

// ---------------------------------------------------------------- with the Forever client tables

fn forever_sources(name: &str) -> (PathBuf, PathBuf, PathBuf) {
	let sources = scratch(&format!("{name}-sources"));
	crate::common::copy_tree(&fixture().join("sources/wago"), &sources.join("wago"));
	let era = sources.join("wago/1.15.9.11111");
	let fv = sources.join("wago/1.60.1.1");
	std::fs::create_dir_all(&fv).unwrap();
	(sources, era, fv)
}

fn read(p: &Path) -> String {
	std::fs::read_to_string(p).unwrap()
}

#[test]
fn forever_tables_decide_changed_frames_and_name_forever_maps() {
	let (sources, era, fv) = forever_sources("frames");
	std::fs::write(fv.join("UiMap.csv"), format!("{}\n\"Zephras Isle\",2521,947,4,0,3\n", read(&era.join("UiMap.csv")).trim_end())).unwrap();
	let asg = read(&era.join("UiMapAssignment.csv")).replace("-10254.166015625,-1935.4166259766", "-10264.166015625,-1935.4166259766");
	std::fs::write(fv.join("UiMapAssignment.csv"), format!("{}\n0,0,1,1,1247.917,-1331.25,-1000000,4956.25,4231.25,1000000,50000,2521,0,2991,16593,0,0\n", asg.trim_end())).unwrap();
	std::fs::write(fv.join("AreaTable.csv"), format!("{}\n16593,ZephrasIsle,\"Zephras Isle\",2991,0\n", read(&era.join("AreaTable.csv")).trim_end())).unwrap();
	let b = build_with("frames", &Store::default(), &|o| {
		o.sources = sources.clone();
		o.forever = true;
	});
	let m = b.meta();
	assert_eq!(m["liveFrameMaps"], json!([1429]), "Stormwind keeps its frame, Elwynn moved 10 yards");
	assert_eq!(b.read("zones")["2521"], json!({ "id": 2521, "name": "Zephras Isle", "areaId": 16593, "parent": 947, "type": 3 }));
	let frames = b.read("map-frames");
	assert_eq!(frames["forever"]["2521"], json!({ "c": 2991, "left": 4231.25, "right": -1331.25, "top": 4956.25, "bottom": 1247.917 }));
	assert!(frames["era"].get("2521").is_none());
	let n = b.read("npcs");
	assert_eq!((&n["2"]["spawns"]["1429"]["f"], &n["2"]["spawns"]["1453"]["f"]), (&json!("l"), &json!("e")));
	let fsrc = m["sources"].as_array().unwrap().iter().find(|s| s["name"].as_str().unwrap().contains("Forever client tables")).unwrap();
	assert!(fsrc["revision"].as_str().unwrap().contains("wow_classic_beta 1.60.1.1"));
}

#[test]
fn instance_spawns_get_the_instance_maps_of_their_areas() {
	let (sources, era, fv) = forever_sources("instances");
	let areas = format!(
		"{}\n1581,TheDeadmines,\"The Deadmines\",36,0\n719,BlackfathomDeeps,\"Blackfathom Deeps\",48,0\n16593,ZephrasIsle,\"Zephras Isle\",2991,0\n",
		read(&era.join("AreaTable.csv")).trim_end()
	);
	std::fs::write(era.join("AreaTable.csv"), &areas).unwrap();
	std::fs::remove_dir_all(&fv).unwrap();
	let store = Store {
		npcs: json!({ "639": { "name": "Edwin VanCleef", "minLevel": 21, "maxLevel": 21, "spawns": { "1581": [[-1, -1]] }, "friendlyToFaction": "", "npcFlags": 0 } }),
		objects: json!({ "1700": { "name": "Fathom Stone", "spawns": { "719": [[-1, -1]] } } }),
		..Default::default()
	};
	let plain = build_with("instances-plain", &store, &|o| o.sources = sources.clone());
	assert_eq!(plain.read("npcs")["639"]["instances"], json!([36]), "without the Map table: unmapped areas off the old continents");
	assert_eq!(plain.read("objects")["1700"]["instances"], json!([48]));
	assert!(plain.read("npcs")["251362"].get("instances").is_none(), "Zephras Isle is open world");
	std::fs::create_dir_all(&fv).unwrap();
	for t in ["UiMap", "UiMapAssignment"] {
		std::fs::copy(era.join(format!("{t}.csv")), fv.join(format!("{t}.csv"))).unwrap();
	}
	std::fs::write(fv.join("AreaTable.csv"), &areas).unwrap();
	std::fs::write(fv.join("Map.csv"), "ID,Directory,MapName_lang,InstanceType\n0,Azeroth,\"Eastern Kingdoms\",0\n36,DeadminesInstance,\"Deadmines\",1\n48,Blackfathom,\"Blackfathom Deeps\",3\n")
		.unwrap();
	let fb = build_with("instances-forever", &store, &|o| {
		o.sources = sources.clone();
		o.forever = true;
	});
	assert_eq!(fb.read("npcs")["639"]["instances"], json!([36]));
	assert!(fb.read("objects")["1700"].get("instances").is_none(), "Map InstanceType decides: 48 is a battleground here");
	let m = fb.meta();
	assert!(m["sources"].as_array().unwrap().iter().any(|s| s["name"].as_str().unwrap().contains(", Map)")));
}

#[test]
fn the_forever_item_sparse_gives_timed_items_their_duration() {
	let (sources, era, fv) = forever_sources("durations");
	for t in ["UiMap", "UiMapAssignment", "AreaTable"] {
		std::fs::copy(era.join(format!("{t}.csv")), fv.join(format!("{t}.csv"))).unwrap();
	}
	std::fs::write(fv.join("ItemSparse.csv"), "ID,Display_lang,DurationInInventory\n50,\"Timed Thing\",900\n252665,\"Lasting Thing\",0\n999999,\"Elsewhere\",300\n").unwrap();
	let b = build_with("durations", &Store::default(), &|o| {
		o.sources = sources.clone();
		o.forever = true;
	});
	let items = b.read("items");
	assert_eq!(items["50"]["duration"], 900);
	assert!(items["252665"].get("duration").is_none() && items.get("999999").is_none());
	let m = b.meta();
	assert_eq!(m["counts"]["timedItems"], 1);
	assert!(m["sources"].as_array().unwrap().iter().any(|s| s["name"].as_str().unwrap().contains(", ItemSparse)")));
}
