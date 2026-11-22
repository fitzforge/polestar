//! Every automation setting off: the character of the full-log scene (Goldshire, partway through the Elwynn
//! Forest guide) talks to quest givers (gossip with quests to take and to hand in, a greeting window, a quest's
//! detail, progress and reward windows), a merchant who repairs (grey items in the bags, worn gear), a trainer,
//! a flight master, and gets a party invitation from a friend and from a stranger, a summon, a resurrection, a
//! duel and a guild invitation: nothing is done for the player and nothing goes to chat. The same tour with the
//! default settings shows the counters are live: the guide's quests are taken and handed in, the grey items sold
//! and the gear repaired.

use crate::common::{play, release_or_skip};
use crate::questlog::goldshire;
use serde_json::{json, Value};

/// Every setting that makes Polestar act for the player (accept, hand in, pick a gossip line or a reward, sell,
/// repair, buy, fly, bind, loot, release, answer invitations, summons, resurrections and duels, share quests,
/// speak in party chat). Each one this release has is turned off.
const AUTOMATION: &[&str] = &[
	"behavior.autoAccept",
	"behavior.autoTurnin",
	"qol.stepGossip",
	"qol.skipGossip",
	"qol.sellJunk",
	"qol.autoRepair",
	"qol.buyGoals",
	"qol.rewardAutoPick",
	"qol.rewardEquip",
	"qol.flightAutoTake",
	"qol.autoBind",
	"qol.fastLoot",
	"qol.autoReleasePvP",
	"qol.declineDuels",
	"qol.declineGuildInvites",
	"qol.declinePartyStrangers",
	"qol.acceptPartyFriends",
	"qol.acceptSummon",
	"qol.acceptResurrect",
	"qol.stepInteract",
	"party.share",
	"party.chat",
	"party.chatLoot",
];

/// The tour (after `turn_off`): each visit's automatic actions, chat lines and CPU ms.
fn tour(turn_off: bool) -> Value {
	let list = AUTOMATION.iter().map(|p| forge_addontest::lua_string(p)).collect::<Vec<_>>().join(", ");
	let script = format!(
		r#"
local w = stub.world
local at = ScenesQ.place(240)
if not at then error("no guide loaded, or none that hands in a quest to Marshal Dughan (240)", 0) end
local applied = {{}}
if {turn_off} then
	for _, p in ipairs({{ {list} }}) do
		if Polestar.GetDefault(p) ~= nil then Polestar.Set(p, false); applied[#applied + 1] = p end
	end
end
w.money = 500000
w.itemInfo[4865] = {{ name = "Ruined Pelt", quality = 0, price = 5 }}
w.itemInfo[3300] = {{ name = "Rabbit's Foot", quality = 0, price = 4 }}
ScenesQ.bag[1] = {{ id = 4865, count = 3 }}; w.items[4865] = 3
ScenesQ.bag[2] = {{ id = 3300, count = 2 }}; w.items[3300] = 2
ScenesQ.repairCost = 1234
stub.advance(2)
-- The live step's quests: those it takes (not in the log yet) and those it hands in (in the log, finished).
local g = Polestar.Engine.GetGuide()
local takes, hands = {{}}, {{}}
for _, goal in ipairs(g.steps[at.step].goals) do
	local q = goal.quest
	if q and goal.npc and goal.t == "accept" and not w.log[q] then takes[#takes + 1] = {{ q = q, npc = goal.npc }} end
	if q and goal.npc and goal.t == "turnin" and w.log[q] and C_QuestLog.ReadyForTurnIn(q) then hands[#hands + 1] = {{ q = q, npc = goal.npc }} end
end
if #takes < 3 or #hands < 4 then error(("the live step %d takes %d quests and hands in %d: the tour needs 3 and 4"):format(at.step, #takes, #hands), 0) end
local visits = {{}}
local function visit(name, open)
	local s = Scene.snap()
	local cost = Scene.work(function() open(); stub.advance(0.5) end)
	for _ = 1, 8 do stub.advance(0.5) end
	if w.frame then w.close() end
	stub.advance(1)
	local d = Scene.since(s)
	visits[#visits + 1] = {{ name = name, actions = d.actions, n = d.autoTotal, lines = d.lines, sounds = d.sounds, alerts = d.alertTotal, ms = cost.ms }}
end
local t, h = takes, hands
visit("gossip", function() w.gossip(h[1].npc, {{ available = {{ {{ questID = t[1].q }} }}, active = {{ {{ questID = h[1].q, isComplete = true }} }},
	options = {{ {{ name = "Let me browse your goods." }}, {{ name = "I want to fly." }} }} }}) end)
visit("greeting", function() w.greeting(h[2].npc, {{ available = {{ {{ questID = t[2].q }} }}, active = {{ {{ questID = h[2].q, isComplete = true }} }} }}) end)
visit("detail", function() w.questDetail(t[3].npc, t[3].q) end)
visit("progress", function() w.questProgress(h[3].npc, h[3].q) end)
visit("complete", function() w.questComplete(h[4].npc, h[4].q, {{ choices = 2 }}) end)
visit("merchant", function() w.merchant(1250, {{ repair = true }}) end)
visit("trainer", function() w.trainer(913) end)
visit("flight master", function() w.taxi(352, "Stormwind, Elwynn", {{ "Sentinel Hill, Westfall", "Lakeshire, Redridge" }}) end)
visit("party invite from a friend", function() ScenesQ.invite("Ana", true) end)
visit("party invite from a stranger", function() ScenesQ.invite("Stranger", false) end)
visit("summon", function() stub.fire("CONFIRM_SUMMON") end)
visit("resurrection", function() stub.fire("RESURRECT_REQUEST", "Ana") end)
visit("duel", function() stub.fire("DUEL_REQUESTED", "Bob") end)
visit("guild invite", function() stub.fire("GUILD_INVITE_REQUEST", "Bob", "Some Guild") end)
emit({{ applied = applied, visits = visits }})
"#
	);
	play(&goldshire(&script)).into_iter().next().expect("the scene emitted nothing")
}

fn visits(out: &Value) -> Vec<Value> {
	out["visits"].as_array().cloned().unwrap_or_default()
}

/// Each visit's name with what happened, for a failure message.
fn told(v: &[Value], key: &str) -> String {
	v.iter().filter(|x| x[key].as_array().is_some_and(|a| !a.is_empty())).map(|x| format!("{}: {}", x["name"].as_str().unwrap_or("?"), x[key])).collect::<Vec<_>>().join("; ")
}

fn worst_ms(v: &[Value]) -> (f64, String) {
	v.iter().map(|x| (x["ms"].as_f64().unwrap_or(f64::NAN), x["name"].as_str().unwrap_or("?").to_string())).fold((0.0, String::new()), |a, b| if b.0 > a.0 { b } else { a })
}

#[test]
fn with_every_automation_setting_off_nothing_is_done_for_the_player() {
	let Some(_) = release_or_skip() else { return };
	let out = tour(true);
	println!("{}", serde_json::to_string_pretty(&out).unwrap());
	let v = visits(&out);
	assert_eq!(v.len(), 14, "every visit ran: {out}");
	let n: u64 = v.iter().map(|x| x["n"].as_u64().unwrap_or(0)).sum();
	assert_eq!(n, 0, "{n} automatic actions with every automation setting off ({}): {}", out["applied"], told(&v, "actions"));
	assert_eq!(told(&v, "lines"), "", "chat lines with every automation setting off");
	let alerts: u64 = v.iter().map(|x| x["alerts"].as_u64().unwrap_or(0)).sum();
	assert_eq!(alerts, 0, "alerts while talking to NPCs: {out}");
	let (ms, at) = worst_ms(&v);
	// Opening an NPC's window: the gossip and quest windows read the guide's live step and the log.
	forge_addontest::assert_timing!(ms < VISIT_MS, "opening a window took {ms:.1} ms at the {at} (budget {VISIT_MS} ms): {out}");
}

#[test]
fn with_the_default_settings_the_guides_quests_are_taken_and_handed_in_and_greys_sold() {
	let Some(_) = release_or_skip() else { return };
	let out = tour(false);
	println!("{}", serde_json::to_string_pretty(&out).unwrap());
	let v = visits(&out);
	let by = |name: &str| v.iter().find(|x| x["name"] == name).cloned().unwrap_or(Value::Null);
	let acts = |name: &str| by(name)["actions"].as_array().map(|a| a.iter().filter_map(|s| s.as_str().map(|s| s.split('(').next().unwrap_or("").to_string())).collect::<Vec<_>>()).unwrap_or_default();
	let quests: Vec<String> = ["gossip", "greeting", "detail", "progress", "complete"].iter().flat_map(|n| acts(n)).collect();
	assert!(quests.iter().any(|a| a == "AcceptQuest"), "auto-accept took none of the live step's quests: {}", told(&v, "actions"));
	assert!(quests.iter().any(|a| a == "GetQuestReward"), "auto turn-in handed in none of the live step's quests: {}", told(&v, "actions"));
	let merchant = acts("merchant");
	assert!(merchant.iter().any(|a| a.contains("UseContainerItem")), "the merchant was sold none of the grey items: {:?}", merchant);
	assert!(merchant.iter().any(|a| a == "RepairAllItems"), "the merchant did not repair: {:?}", merchant);
	// What the defaults do not automate: trainers, flights, invitations, summons, resurrections, duels.
	for name in ["trainer", "flight master", "party invite from a friend", "party invite from a stranger", "summon", "resurrection", "duel", "guild invite"] {
		assert_eq!(by(name)["n"], 0, "{name}: acted with default settings: {}", by(name)["actions"]);
	}
	// The design's lines: the merchant says what it sold and what the repair cost; auto turn-in at a reward window
	// with a choice says the player picks. One each per visit; nothing else.
	const DESIGN: &[(&str, &str)] = &[("merchant", "Sold "), ("merchant", "Repaired for "), ("complete", "Choose a reward to finish the turn-in.")];
	let mut other = Vec::new();
	for x in &v {
		let name = x["name"].as_str().unwrap_or("?");
		let lines: Vec<&str> = x["lines"].as_array().map(|a| a.iter().filter_map(Value::as_str).collect()).unwrap_or_default();
		for line in &lines {
			let text = line.split_once("|r: ").map_or(*line, |(_, t)| t);
			if !DESIGN.iter().any(|(at, start)| *at == name && text.starts_with(start)) {
				other.push(format!("{name}: {line}"));
			}
		}
		assert!(lines.len() <= 2, "{name}: {} chat lines: {lines:?}", lines.len());
	}
	assert!(other.is_empty(), "chat lines the design does not print: {other:?}");
	let (ms, at) = worst_ms(&v);
	forge_addontest::assert_timing!(ms < VISIT_MS, "a window and what it did for the player took {ms:.1} ms at the {at} (budget {VISIT_MS} ms): {out}");
	assert_eq!(json!(v.len()), json!(14), "every visit ran");
}

/// Budget (CPU ms, quiet machine) for opening one NPC window and the automation it runs: 0.4.1.1's worst is the
/// gossip window that hands a quest in, 30 ms (6 ms with everything off); about 4x.
const VISIT_MS: f64 = 120.0;
