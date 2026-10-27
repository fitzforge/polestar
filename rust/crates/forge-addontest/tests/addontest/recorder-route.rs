//! Route telemetry and movement in the recorder (addon/Polestar_Recorder/Route.lua, World.lua, Trail.lua):
//! `step` records with the reason the step changed, the session's packs, combat, AFK, deaths with their killer
//! and revives, breadcrumbs, rides, flights, services, casts, eating, zones and levels, and running with
//! Polestar absent or late.

use crate::recorder::{run, run_with};
use serde_json::json;

// A stand-in for Polestar's bus, Engine and guide registry (docs/ARCHITECTURE.md "Message bus", "Tabs"):
// __fire(msg, ...) delivers a message; __polestar.guide/step is the active tab; the Engine's actions move
// the step and fire STEP_CHANGED inside, as the real one does.
const FAKE_POLESTAR: &str = r#"
__polestar = {
	handlers = {},
	guides = {
		g1 = { id = "forever/alliance/human/01-elwynn", title = "Elwynn Forest", steps = { {}, {}, {}, {} } },
		g2 = { id = "professions/mining", title = "Mining 1-75", steps = { {} } },
	},
}
__polestar.guide, __polestar.step = __polestar.guides.g1, 2
local function fire(msg, ...) for _, fn in ipairs(__polestar.handlers[msg] or {}) do fn(...) end end
__fire = fire
function __installPolestar()
	Polestar = {
		On = function(msg, fn)
			__polestar.handlers[msg] = __polestar.handlers[msg] or {}
			table.insert(__polestar.handlers[msg], fn)
			return {}
		end,
		Engine = {
			GetGuide = function() return __polestar.guide end,
			GetStepIndex = function() return __polestar.step end,
			Next = function() __polestar.step = __polestar.step + 1; fire("STEP_CHANGED", __polestar.step) end,
			Prev = function() __polestar.step = __polestar.step - 1; fire("STEP_CHANGED", __polestar.step) end,
			Skip = function() __polestar.step = __polestar.step + 1; fire("STEP_CHANGED", __polestar.step) end,
			Goto = function(i) __polestar.step = i; fire("STEP_CHANGED", i) end,
		},
		Guides = { Packs = function() return { { id = "guides", version = "0.4.2", status = "on" }, { id = "leffe", version = "1.2", status = "off" } } end },
	}
end
"#;

#[test]
fn step_records_say_why_the_step_changed_the_session_names_the_packs_and_the_active_guide() {
	let out = run_with(
		r#"
		local E = Polestar.Engine
		stub.moveTo(48.2, 41.9)
		stub.advance(1)
		E.Next(); stub.advance(1)                      -- next
		__polestar.step = 4; __fire("STEP_CHANGED", 4) -- the engine moving on: auto
		stub.advance(1)
		E.Prev(); stub.advance(1)                      -- back
		E.Skip(); stub.advance(1)                      -- skip
		E.Goto(1); stub.advance(1)                     -- pick
		-- the engine steps past an unavailable quest: STEP_SKIPPED then STEP_CHANGED
		__fire("STEP_SKIPPED", 1, 2, {}); __polestar.step = 2; __fire("STEP_CHANGED", 2)
		stub.advance(1)
		-- a tab switch: GUIDE_CHANGED then STEP_CHANGED for the same state, one record
		__polestar.guide, __polestar.step = __polestar.guides.g2, 1
		__fire("GUIDE_CHANGED", "professions/mining")
		__fire("STEP_CHANGED", 1)
		stub.advance(1)
		__fire("GUIDE_COMPLETED", "professions/mining")
		logout()
		emit({ steps = recs("step"), session = recs("session")[1] })"#,
		&format!("{FAKE_POLESTAR}__installPolestar()"),
		true,
		None,
	);
	let guide = |step: &str, reason: &str, p: &str| format!("step|forever/alliance/human/01-elwynn|{step}|{reason}|1429|{p}");
	assert_eq!(
		out["steps"],
		json!([
			guide("2", "auto", "5000|5000"),
			guide("3", "next", "4820|4190"),
			guide("4", "auto", "4820|4190"),
			guide("3", "back", "4820|4190"),
			guide("4", "skip", "4820|4190"),
			guide("1", "pick", "4820|4190"),
			guide("2", "skip", "4820|4190"),
			"step|professions/mining|1|pick|1429|4820|4190",
			"step|professions/mining||done|1429|4820|4190",
		])
	);
	assert_eq!(out["session"], "session|char000001|Human|WARRIOR|Alliance|2|1|enUS|70338|16001|3||0.1.0-test||guides:0.4.2;guide:forever/alliance/human/01-elwynn");
}

#[test]
fn without_polestar_nothing_is_stepped_and_nothing_errors_a_late_or_broken_polestar_is_handled() {
	let absent = run(r#"
		stub.fire("PLAYER_REGEN_DISABLED")
		logout()
		emit({ steps = #recs("step"), combat = #recs("combat") })"#);
	assert_eq!(absent, json!({ "steps": 0, "combat": 1 }));

	// Polestar loads after the recorder: attached on its ADDON_LOADED.
	let late = run_with(
		r#"
		__installPolestar()
		stub.addonLoaded("Polestar")
		__polestar.step = 3
		__fire("STEP_CHANGED", 3)
		stub.advance(1)
		logout()
		emit(recs("step"))"#,
		FAKE_POLESTAR,
		true,
		None,
	);
	assert_eq!(late, json!(["step|forever/alliance/human/01-elwynn|3|auto|1429|5000|5000"]));

	// An Engine that errors or returns junk: records carry what is known.
	let broken = run_with(
		r#"
		Polestar.Engine.GetGuide = function() error("boom") end
		__fire("STEP_CHANGED", 2)
		stub.advance(1)
		__fire("GUIDE_CHANGED", { id = "x/y" })
		__fire("GUIDE_COMPLETED", nil)
		logout()
		emit({ steps = recs("step"), bad = malformed() })"#,
		&format!("{FAKE_POLESTAR}__installPolestar()"),
		true,
		None,
	);
	assert_eq!(broken["steps"], json!(["step|forever/alliance/human/01-elwynn|2|auto|1429|5000|5000", "step||2|auto|1429|5000|5000", "step|x/y||pick|1429|5000|5000"]));
}

#[test]
fn combat_afk_deaths_with_their_killer_and_how_the_player_came_back() {
	let out = run(r#"
		local W = stub.world
		local YD = 100 / 5200
		stub.moveTo(40, 40)
		-- combat, afk
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(10)
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.fire("PLAYER_REGEN_ENABLED") -- no second off
		W.afk = true
		stub.fire("PLAYER_FLAGS_CHANGED", "player")
		stub.fire("PLAYER_FLAGS_CHANGED", "player")
		W.afk = false
		stub.fire("PLAYER_FLAGS_CHANGED", "player")
		-- death: the wolf that targeted the player 3 s before is the killer
		local wolf = stub.creature(299, "Young Wolf")
		stub.setUnit("nameplate1", wolf, "Young Wolf")
		W.units.nameplate1.lvl, W.units.nameplate1.targetsPlayer = 4, true
		stub.fire("UNIT_TARGET", "nameplate1")
		stub.advance(3)
		W.dead = true
		stub.fire("PLAYER_DEAD")
		-- released (a ghost), run back, alive at the corpse
		W.ghost = true
		stub.fire("PLAYER_ALIVE")
		stub.moveTo(41, 41)
		W.dead, W.ghost = false, false
		stub.fire("PLAYER_UNGHOST")
		stub.fire("PLAYER_ALIVE")
		-- died again, the spirit healer this time
		W.dead = true
		stub.fire("PLAYER_DEAD") -- no killer within 10 s now? (the wolf targeted 3 s + ... ago)
		W.ghost = true
		stub.fire("PLAYER_ALIVE")
		stub.fire("CONFIRM_XP_LOSS")
		W.dead, W.ghost = false, false
		stub.fire("PLAYER_UNGHOST")
		-- and resurrected where it fell
		stub.advance(40)
		W.dead = true
		stub.fire("PLAYER_DEAD")
		stub.fire("RESURRECT_REQUEST", "Healer")
		W.dead = false
		stub.fire("PLAYER_ALIVE")
		logout()
		emit(recs("combat afk death revive"))"#);
	assert_eq!(
		out,
		json!([
			"combat|1|1429|4000|4000",
			"combat|0|1429|4000|4000",
			"afk|1",
			"afk|0",
			"death|1429|4000|4000|299|4",
			"revive|1429|4100|4100|c",
			"death|1429|4100|4100|299|4",
			"revive|1429|4100|4100|s",
			"death|1429|4100|4100||",
			"revive|1429|4100|4100|r",
		])
	);
}

#[test]
fn breadcrumbs_rides_flights_services_casts_eating_zones_and_levels() {
	let out = run(r#"
		local W = stub.world
		local YD = 100 / 5200
		local x = 30
		local function walk(seconds, ydps)
			for _ = 1, seconds do
				x = x + ydps * YD
				stub.moveTo(x, 50)
				stub.advance(1)
			end
		end
		W.moving, W.speed = true, 7
		walk(1, 7)                  -- first point once moving
		walk(15, 1)                 -- 15 yd in 15 s: under both thresholds
		walk(6, 1)                  -- 20 s since the last point and over 4 yd: one point
		W.mounted = true
		walk(9, 10)                 -- 90 yd mounted: a point every 25+ yd
		W.mounted, W.moving, W.speed = false, false, 0
		-- a boat: the position moves, the player's own speed is 0
		walk(12, 8)
		walk(6, 0)                  -- docked: still for 5 ticks ends the ride
		local function n(kind) return #recs(kind) end
		-- a flight: taken, on the taxi (not breadcrumbed), landed
		W.taxi = { { nodeID = 2, name = "Stormwind", state = 0, slotIndex = 1 }, { nodeID = 4, name = "Sentinel Hill", state = 1, slotIndex = 2 }, { nodeID = 9, name = "Far", state = 2, slotIndex = 3 } }
		stub.setUnit("npc", (stub.creature(352, "Dungar Longdrink")), "Dungar Longdrink")
		stub.fire("TAXIMAP_OPENED", 0)
		stub.fire("TAXIMAP_OPENED", 0)  -- the same node again this session: once
		TakeTaxiNode(2)
		stub.advance(7)                 -- refused (never on the taxi): nothing
		TakeTaxiNode(2)
		W.onTaxi = true
		stub.fire("PLAYER_CONTROL_LOST")
		W.moving = true
		walk(40, 30)
		W.onTaxi, W.moving = false, false
		stub.fire("PLAYER_CONTROL_GAINED")
		stub.advance(1)
		-- hearth, trainer, vendor
		stub.moveTo(30, 30)
		stub.setUnit("npc", (stub.creature(6774, "Innkeeper Farley")), "Innkeeper Farley")
		stub.fire("HEARTHSTONE_BOUND")
		function GetNumTrainerServices() return 3 end
		local services = { { "Battle Shout", "used", 1 }, { "Rend", "available", 4 }, { "Thunder Clap", "unavailable", 6 } }
		function GetTrainerServiceInfo(i) local s = services[i]; return s[1], s[2], 1, s[3] end
		function GetTrainerServiceCost(i) return ({ 0, 100, 400 })[i] end
		C_TooltipInfo = { GetTrainerService = function(i) if i < 3 then return { id = ({ 6673, 772 })[i] } end end }
		local filters = { available = true, unavailable = false, used = false }
		function GetTrainerServiceTypeFilter(f) return filters[f] end
		function SetTrainerServiceTypeFilter(f, on) filters[f] = on end
		stub.setUnit("npc", (stub.creature(911, "Llane Beshere")), "Llane Beshere")
		stub.fire("TRAINER_SHOW")
		stub.fire("TRAINER_SHOW")
		function GetMerchantNumItems() return 2 end
		function GetMerchantItemID(i) return ({ 159, 4540 })[i] end
		C_MerchantFrame = { GetItemInfo = function(i) return ({ { price = 5, stackCount = 5, numAvailable = -1 }, { price = 25, stackCount = 1, numAvailable = 3 } })[i] end }
		stub.setUnit("npc", (stub.creature(78, "Janos Hammerknuckle")), "Janos Hammerknuckle")
		stub.fire("MERCHANT_SHOW")
		-- casts: an item used, a quest spell out of combat, not a spellbook spell, not in combat
		stub.setUnit("target", (stub.creature(1501, "Mindless Zombie")), "Mindless Zombie")
		W.bags = { [0] = { [3] = 6948 } }
		C_Container.UseContainerItem(0, 3)                               -- the Hearthstone from the bags
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-0", 8690)
		W.actions = { [12] = { "item", 15788 } }
		W.combat = true
		UseAction(12)                                                    -- a quest item on the bars, in combat
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-4", 18986)
		W.combat = false
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", 6603)  -- Auto Attack: in the spellbook
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-2", 7091)  -- a quest spell out of combat, not in the spellbook
		W.combat = true
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-3", 12345) -- in combat, no item: never
		W.combat = false
		-- eating
		stub.world.spells[433], stub.world.spells[430] = "Food", "Drink"
		stub.fire("UNIT_AURA", "player", { addedAuras = { { auraInstanceID = 77, name = "Food", spellId = 1131 } } })
		stub.advance(18)
		stub.fire("UNIT_AURA", "player", { removedAuraInstanceIDs = { 77 } })
		-- zone, level
		W.zone, W.subzone = "Stormwind City", "Trade District"
		stub.moveTo(60, 70, 1453)
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.fire("ZONE_CHANGED") -- same map and zone: no duplicate
		W.level, W.xp = 2, 15
		stub.fire("PLAYER_LEVEL_UP", 2)
		stub.advance(2)
		logout()
		emit({ filters = { GetTrainerServiceTypeFilter("available"), GetTrainerServiceTypeFilter("unavailable"), GetTrainerServiceTypeFilter("used") }, recs = recs("pos ride taxi land flightmaster bind trainer vendor cast rest zone level xp map"), bad = malformed() })"#);
	assert_eq!(out["bad"], json!({}));
	assert_eq!(out["filters"], json!([true, false, false]), "the trainer's filters are put back");
	assert_eq!(
		out["recs"],
		json!([
			"map|1429|3|1415|0|1800|1100|-1666.7|-4100",
			"zone|1429|5000|5000|Elwynn Forest|Northshire Valley",
			"xp|0|400|",
			// walking: the first point, one after 20 s and 4 yd, then every 25+ yd (mounted: flag 1)
			"pos|1429|3013|5000|0|70",
			"pos|1429|3052|5000|0|70",
			"pos|1429|3112|5000|1|70",
			"pos|1429|3169|5000|1|70",
			"pos|1429|3227|5000|1|70",
			// a boat: moving with no speed of one's own, two ticks running; still for 5 s ends it
			"ride|1|1429|3227|5000",
			"pos|1429|3288|5000|0|0",
			"pos|1429|3350|5000|0|0",
			"pos|1429|3412|5000|0|0",
			"ride|0|1429|3412|5000",
			// the flight master (once per node per session), a refused flight (nothing), the flight
			"flightmaster|352|1429|3412|5000|2|2;4",
			"taxi|2|4",
			"land|4|40|1429|5719|5000",
			"bind|6774|1429|3000|3000",
			"trainer|911|1429|3000|3000|6673:0:1:k;772:100:4:a;0:400:6:u:Thunder Clap",
			"vendor|78|1429|3000|3000|159:5:5:-1;4540:25:1:3",
			"cast|8690|6948|1429|3000|3000|c|1501",
			"cast|18986|15788|1429|3000|3000|c|1501",
			"cast|7091||1429|3000|3000|c|1501",
			"rest|f|18",
			"map|1453|3|1429|0|1722.2|-7997.7|564.1|-9733.2",
			"zone|1453|6000|7000|Stormwind City|Trade District",
			"level|2|1453|6000|7000|",
			"xp|15|400|",
		])
	);
}
