//! Who may take a quest by race, with Forever's Skyborne bits (2^32 the Alliance's High Order, 2^33 the Horde's
//! Windshapers: beyond the 32 bits Lua 5.1's bit library reads): the quest database's eligibility
//! (QuestDB.IsEligible, from the low race mask and `raceHigh`), and the shipped start guides' Body and Heart
//! steps. A Skyborne druid is never offered the Night Elf druids' Body and Heart (6001) nor the Tauren's (6002),
//! and keeps their own Moonglade quests (94914 / 94913) (Lookup's block: lookup-skyborne.rs).

use forge_addontest::questdb::ADD_RECORDS_LUA;
use forge_addontest::run::{addons_dir, dir_files, lua_string};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec!["Polestar".into()], script: [ADD_RECORDS_LUA, script].join("\n"), ..Default::default() }).remove(0)
}

// A record's fields, as the quest database lays them out: title, level, minLevel, races (the mask's low 32 bits),
// classes, faction (1 Alliance, 2 Horde), start .. preAll (unused), raceHigh (field 18: +1 High Order, +2
// Windshaper; 3 for a mask from the Era data alone, which never excludes Skyborne).
const ELIGIBLE: &str = r#"
local function rec(title, races, faction, high) return { title, 10, 1, races, 1024, faction, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, high } end
AddRecords("quests", {
	[8001] = rec("Night Elf druids only", 8, 1, 0),
	[8002] = rec("Tauren druids only", 32, 2, 0),
	[8003] = rec("High Order only", 0, 1, 1),
	[8004] = rec("Windshaper only", 0, 2, 2),
	[8005] = rec("Night Elf and High Order", 8, 1, 1),
	[8006] = rec("Whole Alliance with Skyborne", 77, 1, 1),
	[8007] = rec("Era mask, Night Elf only", 8, 1, 3),
	[8008] = rec("Whole Alliance without Skyborne", 77, 1, 0),
	[8009] = { "Anyone", 10, 1, nil, 1024 },
})
Polestar.QuestDB.SetMeta({})
local Q = Polestar.QuestDB
local who = {
	skyA = { race = "Skyborne", faction = "Alliance" }, skyH = { race = "Skyborne", faction = "Horde" },
	nightElf = { race = "NightElf", faction = "Alliance" }, tauren = { race = "Tauren", faction = "Horde" },
	human = { race = "Human", faction = "Alliance" },
}
local out = {}
for _, id in ipairs({ 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009 }) do
	local row = {}
	for name, p in pairs(who) do
		local ctx = Q.PlayerContext({ level = 12, race = p.race, faction = p.faction, class = "DRUID" })
		row[name] = Q.IsEligible(Q.QuestRecord(id), ctx)
	end
	out[tostring(id)] = row
end
emit(out)
"#;

#[test]
fn the_quest_database_reads_skyborne_by_the_high_bits_of_the_race_mask() {
	let out = run(ELIGIBLE);
	let row = |sky_a: bool, sky_h: bool, night_elf: bool, tauren: bool, human: bool| json!({ "skyA": sky_a, "skyH": sky_h, "nightElf": night_elf, "tauren": tauren, "human": human });
	// Body and Heart: only the race named takes it, Skyborne of either side never.
	assert_eq!(out["8001"], row(false, false, true, false, false));
	assert_eq!(out["8002"], row(false, false, false, true, false));
	// Skyborne's own quests (a mask of the high bit alone) are for their side only.
	assert_eq!(out["8003"], row(true, false, false, false, false));
	assert_eq!(out["8004"], row(false, true, false, false, false));
	assert_eq!(out["8005"], row(true, false, true, false, false));
	// A whole side's mask takes Skyborne in when Forever's data carries their bit, and leaves them out when it does not.
	assert_eq!(out["8006"], row(true, false, true, false, true));
	assert_eq!(out["8008"], row(false, false, true, false, true));
	// A mask from the Era data alone (no Skyborne bit to read) never excludes them by race (the faction still does).
	assert_eq!(out["8007"], row(true, false, true, false, false));
	// No mask: anyone, whichever race.
	assert_eq!(out["8009"], row(true, true, true, true, true));
}

// The start guides as shipped (addon/Polestar_Guides*, no reference data needed), with the quest database's
// records of their druid chains as the data builds them (quests.json's masks; every one has Forever's own store,
// so `raceHigh` is the mask's high bits, none here): a druid of the guide's own race keeps Body and Heart and its
// Moonkin Stone, a Skyborne druid of the same side, who may follow the start from the guide menu, is shown none
// of it: not the quest, nor the flight, the Moondust or the walk that only go with it.
const CHAINS: &str = r#"
local function rec(title, races, classes) return { title, 10, 10, races, classes, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0 } end
AddRecords("quests", {
	[5921] = rec("Moonglade", 8, 1024), [5929] = rec("Great Bear Spirit", 8, 1024), [5931] = rec("Back to Darnassus", 8, 1024),
	[5922] = rec("Moonglade", 32, 1024), [5926] = rec("Heeding the Call", 32, 1024), [5930] = rec("Great Bear Spirit", 32, 1024),
	[5932] = rec("Back to Thunder Bluff", 32, 1024), [6001] = rec("Body and Heart", 8, 1024), [6002] = rec("Body and Heart", 32, 1024),
	[6343] = rec("Return to Nessa", 8), [6361] = rec("A Bundle of Hides", 32), [6362] = rec("Ride to Thunder Bluff", 32),
	[6363] = rec("Tal the Wind Rider Master", 32), [6364] = rec("Return to Jahan", 32),
})
Polestar.QuestDB.SetMeta({})
"#;

fn part_files(name: &str) -> String {
	let dir = addons_dir().join(name);
	let files = dir_files(&dir).unwrap_or_else(|e| panic!("{e}"));
	let list: Vec<String> = files.iter().map(|f| lua_string(&f.to_string_lossy())).collect();
	format!("stub.packs[{}] = {{ {} }}", lua_string(name), list.join(", "))
}

/// The live goals (not "na", not skipped) of the open start guide, as { quest, item, t } rows by step title.
fn live_goals(race: &str, faction: &str, guide: &str) -> Value {
	let main = dir_files(&addons_dir().join("Polestar_Guides")).unwrap_or_else(|e| panic!("{e}"));
	let files: Vec<String> = main.iter().map(|f| lua_string(&f.to_string_lossy())).collect();
	let script = format!(
		r#"
local ns = {{}}
for _, f in ipairs({{ {files} }}) do assert(loadfile(f))("Polestar_Guides", ns) end
stub.addonLoaded("Polestar_Guides")
stub.login()
{ADD_RECORDS_LUA}
{CHAINS}
local E = Polestar.Engine
E.SetGuide({guide}); stub.advance(0.6)
local G = E.GetGuide()
local live = {{}}
for i = 1, #G.steps do
	for _, g in ipairs(E.GetStepView(i).goals) do
		if g.status ~= "na" and g.status ~= "skipped" then live[#live + 1] = {{ step = i, t = g.t, quest = g.quest or false, item = g.item or false, title = G.steps[i].title }} end
	end
end
emit({{ guide = G.id, steps = #G.steps, live = live }})"#,
		files = files.join(", "),
		guide = lua_string(guide),
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_packs.lua"],
		before: format!(
			"{}\n{}\nlocal w = stub.world\nw.faction, w.race, w.raceName, w.class, w.className, w.level = {}, {}, {}, \"DRUID\", \"Druid\", 10",
			part_files("Polestar_Guides_Alliance"),
			part_files("Polestar_Guides_Horde"),
			lua_string(faction),
			lua_string(race),
			lua_string(race)
		),
		addons: vec![Addon::name("Polestar")],
		script,
		..Default::default()
	})
	.remove(0)
}

/// Whether any live goal of `out` is for `quest` or uses `item`.
fn mentions(out: &Value, quest: i64, item: i64) -> bool {
	out["live"].as_array().unwrap().iter().any(|g| g["quest"] == quest || g["item"] == item)
}

#[test]
fn a_skyborne_druid_following_the_night_elf_or_tauren_start_is_shown_no_body_and_heart() {
	for (race, faction, guide, quest, item, own) in
		[("Skyborne", "Alliance", "forever/alliance/nightelf/01-teldrassil", 6001, 15208, "NightElf"), ("Skyborne", "Horde", "forever/horde/tauren/01-mulgore", 6002, 15710, "Tauren")]
	{
		let skyborne = live_goals(race, faction, guide);
		assert!(skyborne["steps"].as_i64().unwrap() > 50, "{guide} loaded: {}", skyborne["steps"]);
		assert!(!mentions(&skyborne, quest, item), "{race} {faction} druid in {guide}: a live goal for Body and Heart ({quest}) or its Moondust ({item}): {skyborne}");
		// The same guide for a druid of its own race still has the whole chain.
		let owner = live_goals(own, faction, guide);
		assert!(mentions(&owner, quest, item), "{own} druid in {guide}: Body and Heart must stay");
	}
}
