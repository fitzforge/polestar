//! Sell and repair before heading out in While you're here (#2344; addon/Polestar/Core/Engine.lua, Own.hereVendor*;
//! Nav/Nearby.lua's Nearby.PlacesOn; option behavior.whileHereVendors, on by default): when the route heads out of
//! town with the bags nearly full (fewer free slots than behavior.whileHereSellSlots or than the next steps' loot)
//! or the gear worn (under behavior.whileHereRepairPercent), the nearest friendly merchant or repairer on the way is
//! a line of its own, once per visit and kind; never in combat or an instance, never with the option off. A click
//! points the arrow at the NPC. The whole addon (QoL counts the bags, Nav finds the NPCs), stub world.
//!
//! Elwynn here is 3000 yd across (30 yd per map percent on x) and 2000 yd high (20 yd per percent on y). The player
//! stands in Goldshire at 42,65 (resting: the inn's town). Corina Steele repairs 15 yd west, Brog Hamfist sells 30 yd
//! east, a Horde merchant who repairs stands 6 yd south (never offered to this Alliance character); the route's
//! step 1 is in town (42.6,65), step 2 sends the player 690 yd out to the farm.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.level = 10
w.zone, w.subzone = "Elwynn Forest", "Goldshire"
w.resting = true
w.moveTo(1429, 42, 65)
w.onQuest(33, { 8 }, "Wolves Across the Border")
-- The bags: a 16-slot backpack, `bagFree` of it free. The gear: slot -> { durability, max }.
bagFree, gear = 2, { [5] = { 80, 100 }, [16] = { 70, 80 } }
C_Container = C_Container or {}
C_Container.GetContainerNumSlots = function(bag) return bag == 0 and 16 or 0 end
C_Container.GetContainerNumFreeSlots = function(bag) return bag == 0 and bagFree or 0, 0 end
function GetInventoryItemDurability(slot)
	local d = gear[slot]
	if d then return d[1], d[2] end
end
"#;

// 1 (live) a goto in town · 2 the wolves at the farm, 690 yd out · 3 and 4 collect an item each for 33, at the farm.
// SELLS: a step after the farm's that sells (a `vendor` goal): the route sells itself.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/sell", pack = "test", title = "Sell", minLevel = 1, maxLevel = 20,
	steps = {
		{ title = "In town", goals = { { t = "goto", map = 1429, x = 42.6, y = 65 } } },
		{ title = "The farm", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 40 } } },
		SELLS
		{ title = "Fangs", goals = { { t = "collect", item = 901, itemName = "Wolf Fang", count = 3, quest = 33, map = 1429, x = 60, y = 40 } } },
		{ title = "Pelts", goals = { { t = "collect", item = 902, itemName = "Wolf Pelt", count = 3, quest = 33, map = 1429, x = 60, y = 40 } } },
	},
})
"#;

const HELPERS: &str = r#"
E, w = Polestar.Engine, stub.world
function flush() stub.advance(0.25) end
function at(x, y) w.moveTo(1429, x, y); stub.advance(0.6) end
Polestar.MapFrames.era[1429] = { c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }
local npcs = {
	[101] = { id = 101, name = "Corina Steele", subName = "Weaponsmith", faction = "A", spawns = { { map = 1429, x = 41.5, y = 65 } } },
	[102] = { id = 102, name = "Brog Hamfist", subName = "General Supplies", faction = "A", spawns = { { map = 1429, x = 43, y = 65 } } },
	[103] = { id = 103, name = "Grunt Trader", faction = "H", spawns = { { map = 1429, x = 42, y = 65.3 } } },
}
local roles = { repair = { 101, 103 }, vendor = { 102, 103 } }
Polestar.Codex = {
	IsLoaded = function() return true end,
	Load = function() return true end,
	WithRole = function(r) return roles[r] or {} end,
	Npc = function(id) return npcs[id] end,
}
-- The bags or the gear changed (the client's events).
function bags(n) bagFree = n; stub.fire("BAG_UPDATE_DELAYED"); flush() end
function wear(pct) gear[5] = { pct, 100 }; stub.fire("UPDATE_INVENTORY_DURABILITY"); flush() end
-- The sell and repair lines shown: { kind, text, under it, yards, icon }.
function vendors()
	local out = {}
	for _, v in ipairs(E.GetWhileHereList()) do
		if v.here == "sell" or v.here == "repair" then
			local icon = Polestar.Theme.VerbIcon(v.t):match("[^\\]+$")
			out[#out + 1] = { v.here, v.hereText, v.hereSub or false, v.yards or false, icon }
		end
	end
	return out
end
-- Step 1 done: the route heads out to the farm.
function headOut() at(42.6, 65); flush(); at(42, 65) end
r = {}
"#;

fn run_with(guide: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/sell" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, guide, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, HELPERS, script, "emit(r)"].join("\n"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(&GUIDE.replace("SELLS", ""), script)
}

#[test]
fn a_merchant_on_the_way_shows_before_the_route_heads_out_with_the_bags_nearly_full_and_a_click_points_the_arrow_there() {
	let out = run(r#"
		bags(2)
		r.inTown = vendors()
		headOut()
		r.live = E.GetLiveStep()
		r.out = vendors()
		r.aim = E.AimWhileHere(1)
		local wp = E.GetWaypoint()
		r.wp = wp and { wp.map, wp.x, wp.y, wp.label, wp.stepIndex, wp.goalIndex } or false
		-- Sold: the line goes, the arrow back to the guide.
		bags(9)
		r.sold = vendors()
		local back = E.GetWaypoint()
		r.back = back and back.stepIndex or false
		"#);
	assert_eq!(out["inTown"], json!({}), "the route's next goal is in town: not heading out yet");
	assert_eq!(out["live"], json!(2));
	assert_eq!(out["out"], json!([["sell", "Sell before heading out: 2 free slots", "Brog Hamfist (General Supplies)", 30, "icon-sell"]]), "the Horde merchant 6 yd off is never offered");
	assert_eq!(out["aim"], json!(true));
	assert_eq!(out["wp"], json!([1429, 43, 65, "Sell at Brog Hamfist", -4, 2]));
	assert_eq!(out["sold"], json!({}));
	assert_eq!(out["back"], json!(2), "the arrow back on the farm");
}

#[test]
fn worn_gear_shows_the_repairer_and_with_full_bags_too_one_line_says_both() {
	let out = run(r#"
		bags(8); wear(22)
		headOut()
		r.repair = vendors()
		E.DismissWhileHere(1); flush()
		-- The dismiss's own mute (2 minutes) over: still not this visit.
		stub.advance(130); at(42, 80); at(42, 65)
		r.dismissed = vendors()
		-- Far from town and back (a new visit): both needed now, the repairer's line says both, no sell line.
		at(42, 90); at(42, 65)
		bags(1); wear(18)
		at(42.05, 65)
		r.both = vendors()
		"#);
	assert_eq!(out["repair"], json!([["repair", "Repair before heading out: gear at 22%", "Corina Steele (Weaponsmith)", 15, "icon-repair"]]));
	assert_eq!(out["dismissed"], json!({}), "dismissed: not again this visit");
	assert_eq!(out["both"], json!([["repair", "Repair and sell before heading out: gear at 18%, 1 free slot", "Corina Steele (Weaponsmith)", 15, "icon-repair"]]));
}

#[test]
fn once_per_visit_a_merchant_s_window_spends_it_and_a_new_town_brings_it_back() {
	let out = run(r#"
		bags(2)
		headOut()
		r.first = #vendors()
		-- Dismissed, the dismiss's own mute (2 minutes) over, out of town 300 yd and back: not twice this visit.
		E.DismissWhileHere(1); flush()
		stub.advance(130); at(42, 80); at(42, 65)
		r.again = #vendors()
		-- 400 yd and more away, then back: a new visit.
		at(42, 90); at(42, 65)
		r.newVisit = #vendors()
		-- At a merchant: the line goes; closed again, not this visit.
		w.merchant(102); flush()
		r.atMerchant = #vendors()
		w.close(); flush(); at(42.05, 65)
		r.afterMerchant = #vendors()
		"#);
	assert_eq!(out["first"], json!(1));
	assert_eq!(out["again"], json!(0), "once per visit");
	assert_eq!(out["newVisit"], json!(1));
	assert_eq!(out["atMerchant"], json!(0));
	assert_eq!(out["afterMerchant"], json!(0));
}

#[test]
fn never_in_combat_an_instance_with_the_option_off_or_when_the_route_sells_itself() {
	let out = run(r#"
		bags(2)
		stub.inCombat = true
		E.Skip(); flush()
		at(42, 65)
		r.combatLive = E.GetLiveStep()
		r.combat = #vendors()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED"); at(42.05, 65)
		r.afterCombat = #vendors()
		at(42, 90); w.inInstance = true; at(42, 65)
		r.instance = #vendors()
		w.inInstance = false
		Polestar.Set("behavior.whileHereVendors", false); flush()
		at(42, 90); at(42, 65)
		r.off = #vendors()
		r.default = Polestar.GetDefault("behavior.whileHereVendors")
		"#);
	assert_eq!(out["combatLive"], json!(2));
	assert_eq!(out["combat"], json!(0));
	assert_eq!(out["afterCombat"], json!(1), "after the fight it comes");
	assert_eq!(out["instance"], json!(0));
	assert_eq!(out["off"], json!(0));
	assert_eq!(out["default"], json!(true));
	// The route's own step sells before heading out: no reminder.
	let sells = run_with(
		&GUIDE.replace("SELLS", r#"{ title = "Sell", goals = { { t = "vendor", npc = 102, npcName = "Brog Hamfist", map = 1429, x = 43, y = 65 } } },"#),
		r#"
		bags(2)
		headOut()
		r.live = E.GetLiveStep()
		r.lines = #vendors()
		"#,
	);
	assert_eq!(sells["lines"], json!(0), "live step {}", sells["live"]);
}

#[test]
fn the_next_steps_loot_raises_the_free_slots_wanted() {
	let out = run(r#"
		-- 4 free: the setting's 4 is met. The farm's fangs and pelts want 2 slots, and with 8 wanted 4 free is short.
		bags(4)
		headOut()
		r.four = #vendors()
		Polestar.Set("behavior.whileHereSellSlots", 0); flush()
		at(42, 90); at(42, 65)
		bags(1)
		at(42.05, 65)
		r.loot = vendors()
		Polestar.Set("behavior.whileHereSellSlots", 8); flush()
		at(42, 90); at(42, 65); bags(4); at(42.05, 65)
		r.eight = #vendors()
		"#);
	assert_eq!(out["four"], json!(0), "4 free slots, 4 wanted, 2 for the loot");
	assert_eq!(out["loot"], json!([["sell", "Sell before heading out: 1 free slot", "Brog Hamfist (General Supplies)", 30, "icon-sell"]]), "1 free, the loot wants 2");
	assert_eq!(out["eight"], json!(1));
}

// A flight out: the live step flies from the town's flight master, 20 yd off, whose point the arrow may lead to; the
// route heads out all the same.
#[test]
fn a_flight_out_of_town_heads_out_too() {
	let fly = GUIDE
		.replace(
			r#"{ title = "The farm", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 40 } } },"#,
			r#"{ title = "Fly out", goals = { { t = "fly", location = "Stormwind", map = 1429, x = 42.3, y = 64.5 } } },"#,
		)
		.replace("SELLS", "");
	assert!(fly.contains("Fly out"));
	let out = run_with(
		&fly,
		r#"
		bags(2)
		headOut()
		r.live = E.GetLiveStep()
		r.lines = vendors()
		"#,
	);
	assert_eq!(out["live"], json!(2));
	assert_eq!(out["lines"], json!([["sell", "Sell before heading out: 2 free slots", "Brog Hamfist (General Supplies)", 30, "icon-sell"]]));
}

#[test]
fn the_reminder_poll_allocates_nothing_per_tick() {
	let out = run(r#"
		local function ticks(n)
			local c, px, py = Polestar.Compat.GetPlayerWorldPosition()
			for _ = 1, 20 do E.WhileHereTick(c, px, py) end
			collectgarbage("collect"); collectgarbage("collect")
			collectgarbage("stop")
			local base = collectgarbage("count")
			for i = 1, n do E.WhileHereTick(c, px + (i % 2) * 0.4, py) end
			local kib = collectgarbage("count") - base
			collectgarbage("restart")
			return kib
		end
		bags(2)
		headOut()
		r.line = #vendors()
		r.shown = ticks(2000)
		E.DismissWhileHere(1); flush()
		r.idle = ticks(2000)
		"#);
	assert_eq!(out["line"], json!(1));
	let (shown, idle) = (out["shown"].as_f64().unwrap(), out["idle"].as_f64().unwrap());
	assert!(shown < 0.5, "2000 polls with the line shown allocated {shown:.2} KiB");
	assert!(idle < 0.5, "2000 polls with the kind spent allocated {idle:.2} KiB");
}

// #3547: Nav/RuneStop.lua's offer is a line of the same kind: the vendor, what it saves, a click points the arrow
// there, and the line goes when the offer does (a rune in the bags), the arrow back on the guide.
#[test]
fn a_rune_stop_is_a_while_you_re_here_line_a_click_leads_to_the_vendor_and_it_goes_with_the_offer() {
	let out = run(r#"
		bags(16)
		local c, wx, wy = Polestar.Compat.MapToWorld(1429, 43, 65)
		local place = { id = 102, name = "Brog Hamfist", sub = "General Supplies", map = 1429, x = 43, y = 65, c = c, wx = wx, wy = wy }
		local function offer(saves) return { seller = place, places = { place }, teleport = { spell = 3561, name = "Teleport: Stormwind" }, saves = saves } end
		local function line()
			for _, v in ipairs(E.GetWhileHereList()) do
				if v.here == "rune" then return { v.hereText, v.hereSub or false, v.yards or false, Polestar.Theme.VerbIcon(v.t):match("[^\\]+$") } end
			end
			return false
		end
		r.none = line()
		E.SetRuneStop(offer(185))
		flush()
		at(42, 65)
		r.shown = line()
		E.SetRuneStop(offer(250))
		flush()
		r.moved = line()
		r.aim = E.AimWhileHere(1)
		r.aimed = E.RuneStopAimed()
		local wp = E.GetWaypoint()
		r.wp = wp and { wp.map, wp.x, wp.y, wp.label, wp.stepIndex, wp.goalIndex } or false
		E.SetRuneStop(nil)
		flush()
		r.gone = line()
		local back = E.GetWaypoint()
		r.backOnGuide = back and back.stepIndex == E.GetLiveStep() or false
		-- Out of runes again, in the same town: a new trip's offer shows, not held back as once per visit.
		E.SetRuneStop(offer(185))
		flush()
		at(42, 65)
		r.again = line() ~= false
		-- Dismissed, it stays gone though the offer holds.
		E.DismissWhileHere(1)
		flush()
		E.SetRuneStop(offer(190))
		flush()
		at(42, 65)
		r.dismissed = line()
		"#);
	assert_eq!(out["none"], false);
	assert_eq!(out["shown"], json!(["Buy a rune and cast Teleport: Stormwind to save about 3m", "Brog Hamfist (General Supplies)", 30, "icon-sell"]));
	assert_eq!(out["moved"][0], "Buy a rune and cast Teleport: Stormwind to save about 4m", "the same stop takes the new saving");
	assert_eq!(out["aim"], true);
	assert_eq!(out["aimed"], true);
	assert_eq!(out["wp"], json!([1429, 43, 65, "Buy a rune at Brog Hamfist", -4, 3]));
	assert_eq!(out["gone"], false);
	assert_eq!(out["backOnGuide"], true);
	assert_eq!(out["again"], true, "a later trip in the same town gets the line again");
	assert_eq!(out["dismissed"], false, "a dismiss holds");
}

// #3432 (Stö): Mount Hyjal's "Sell before heading out" picked Pexmit ("Someone's Minion"), a rare merchant with 8
// spawns across the zone, often not there. A rare whose spawns lie more than 100 yd apart is no place to send the
// player (Nav/Nearby.lua); one that stays at one spot still is.
#[test]
fn a_rare_merchant_who_wanders_is_never_the_place_to_sell_one_who_stays_put_is_3432() {
	let line = |spawns: &str| {
		let out = run(&format!(
			r#"
		npcs[104] = {{ id = 104, name = "Pexmit", subName = "Someone's Minion", faction = "AH", rare = true, spawns = {spawns} }}
		roles.vendor = {{ 102, 103, 104 }}
		bags(2)
		headOut()
		r.out = vendors()
		"#
		));
		out["out"][0][2].clone()
	};
	assert_eq!(line("{ { map = 1429, x = 42.3, y = 65 }, { map = 1429, x = 80, y = 20 } }"), "Brog Hamfist (General Supplies)", "9 yd off, but it wanders");
	assert_eq!(line("{ { map = 1429, x = 42.3, y = 65 }, { map = 1429, x = 42.5, y = 65.2 } }"), "Pexmit (Someone's Minion)", "at one spot: the nearest");
}
