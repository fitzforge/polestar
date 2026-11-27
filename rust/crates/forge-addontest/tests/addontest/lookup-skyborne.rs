//! Lookup's quest block for Skyborne (Lookup.QuestBlock, from the Codex's whole race mask, which carries
//! Forever's Skyborne bits: 2^32 the Alliance's High Order, 2^33 the Horde's Windshapers). A Skyborne druid is
//! shown the Night Elf druids' Body and Heart (6001) and the Tauren's (6002) as not for their race, and keeps
//! their own Moonglade quests (94914 / 94913) and the quests of a mask that names their bit.

use forge_addontest::{emitted, RunAddon};
use serde_json::{json, Value};

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec!["Polestar".into()], script: script.to_string(), ..Default::default() }).remove(0)
}

const BLOCKS: &str = r#"
local Lk = Polestar.Lookup
local function p(race, faction) return { race = race, faction = faction, code = faction == "Alliance" and "A" or "H", level = 12, class = "DRUID" } end
local who = { skyA = p("Skyborne", "Alliance"), skyH = p("Skyborne", "Horde"), nightElf = p("NightElf", "Alliance"), human = p("Human", "Alliance"), tauren = p("Tauren", "Horde") }
local quests = {
	bodyAndHeartA = { id = 6001, races = 8, faction = "A" },
	bodyAndHeartH = { id = 6002, races = 32, faction = "H" },
	nightElfAndSkyborne = { id = 98393, races = 4294967304, faction = "A" },
	highOrderOnly = { id = 94914, races = 4294967296, faction = "A" },
	windshaperOnly = { id = 94913, races = 8589934592, faction = "H" },
	wholeAlliance = { id = 5, races = 77, faction = "A" },
	wholeAllianceAndSkyborne = { id = 6, races = 4294967373, faction = "A" },
	noMask = { id = 7 },
}
local out = {}
for qname, q in pairs(quests) do
	local row = {}
	for name, who in pairs(who) do row[name] = Lk.QuestBlock(q, who) or false end
	out[qname] = row
end
emit(out)
"#;

#[test]
fn lookup_blocks_a_skyborne_druid_from_the_quests_of_races_not_theirs_and_keeps_their_own() {
	let out = run(BLOCKS);
	let blocked = |sky_a: Value, sky_h: Value, night_elf: Value, human: Value, tauren: Value| json!({ "skyA": sky_a, "skyH": sky_h, "nightElf": night_elf, "human": human, "tauren": tauren });
	let (race, side, free) = (json!("race"), json!("faction"), json!(false));
	// Body and Heart by race: Night Elf's is for Night Elves, Tauren's for Tauren; no Skyborne takes either.
	assert_eq!(out["bodyAndHeartA"], blocked(race.clone(), side.clone(), free.clone(), race.clone(), side.clone()));
	assert_eq!(out["bodyAndHeartH"], blocked(side.clone(), race.clone(), side.clone(), side.clone(), free.clone()));
	// A mask with Night Elf and the High Order bit: Night Elves and High Order Skyborne.
	assert_eq!(out["nightElfAndSkyborne"], blocked(free.clone(), side.clone(), free.clone(), race.clone(), side.clone()));
	// Moonglade (the high bit alone): its own side's Skyborne only.
	assert_eq!(out["highOrderOnly"], blocked(free.clone(), side.clone(), race.clone(), race.clone(), side.clone()));
	assert_eq!(out["windshaperOnly"], blocked(side.clone(), free.clone(), side.clone(), side.clone(), race.clone()));
	// A whole side's mask is the faction's say, with or without the Skyborne bit.
	assert_eq!(out["wholeAlliance"], blocked(free.clone(), side.clone(), free.clone(), free.clone(), side.clone()));
	assert_eq!(out["wholeAllianceAndSkyborne"], blocked(free.clone(), side.clone(), free.clone(), free.clone(), side.clone()));
	assert_eq!(out["noMask"], blocked(free.clone(), free.clone(), free.clone(), free.clone(), free.clone()));
}
