//! Dungeons/QuestKeys.lua (`forge data dungeonquests`), read by Dungeons.QuestDungeon: every page quest answers
//! its dungeon, the file stays one string at login (no table, the Codex not loaded), and lookups leave nothing
//! behind. Each figure fails the test when it grows past its budget: lower a budget when a change lowers the
//! figure, never raise one to make a change pass.

use forge_addontest::run::{lua_string, root};
use forge_addontest::{emitted, Addon, RunAddon};

/// KiB (Lua 5.1, 64-bit): the file resident once loaded (its one string, ~5.6 KiB for 30 dungeons and 771 ids),
/// and what looking every id up leaves after a full collect.
const RESIDENT_KIB: f64 = 8.0;
const LOOKUPS_KIB: f64 = 0.5;

#[test]
fn every_page_quest_answers_its_dungeon_from_one_string_within_budget() {
	let file = root().join("addon/Polestar/Dungeons/QuestKeys.lua");
	let text = std::fs::read_to_string(&file).unwrap();
	// The file's own lines: key|map|name|ids. The first key in file order wins for a quest on several pages.
	let body = text.split("[[\n").nth(1).unwrap().split("]]").next().unwrap();
	let mut want: Vec<(i64, String)> = vec![];
	for line in body.lines() {
		let f: Vec<&str> = line.splitn(4, '|').collect();
		for chunk in f[3].as_bytes().chunks(6) {
			let id: i64 = std::str::from_utf8(chunk).unwrap().parse().unwrap();
			if !want.iter().any(|(q, _)| *q == id) {
				want.push((id, f[0].to_string()));
			}
		}
	}
	assert!(want.len() > 500, "{} page quests", want.len());
	let pairs: String = want.iter().map(|(q, k)| format!("{{{q},{}}},", lua_string(k))).collect();
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Dungeons/Dungeons.lua"])],
		script: format!(
			r#"
local D = Polestar.Dungeons
local want = {{ {pairs} }}
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
local before = full()
assert(loadfile({file}))("Polestar", Polestar)
local loaded = full()
local wrong = {{}}
collectgarbage("stop")
local base = collectgarbage("count")
for _, p in ipairs(want) do
	if D.QuestDungeon(p[1]) ~= p[2] then wrong[#wrong + 1] = p[1] end
end
collectgarbage("restart")
local after = full()
emit({{ resident = loaded - before, lookups = after - loaded, wrong = wrong, absent = D.QuestDungeon(77) == nil,
	kind = type(D.questKeys), codex = D.Meta() ~= nil }})"#,
			file = lua_string(&file.to_string_lossy())
		),
		..Default::default()
	});
	let v = &out[0];
	assert_eq!(v["wrong"], serde_json::json!([]), "{v}");
	assert_eq!(v["absent"], true, "{v}");
	assert_eq!(v["kind"], "string", "kept as one string: {v}");
	assert_eq!(v["codex"], false, "the Codex stays unloaded: {v}");
	let (resident, lookups) = (v["resident"].as_f64().unwrap(), v["lookups"].as_f64().unwrap());
	eprintln!("QuestKeys.lua: {} quests, {resident:.2} KiB resident (budget {RESIDENT_KIB}), lookups leave {lookups:.2} KiB (budget {LOOKUPS_KIB})", want.len());
	assert!(resident <= RESIDENT_KIB, "{resident:.2} KiB resident over the {RESIDENT_KIB} KiB budget");
	assert!(lookups <= LOOKUPS_KIB, "lookups leave {lookups:.2} KiB, over {LOOKUPS_KIB}");
}
