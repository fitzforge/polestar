//! Zone detours (#1249, "do this zone, then come back"; addon/Polestar/Core/Engine.lua, "Zone detours"): a player
//! standing in a zone the guide comes to later is offered it after Own.DETOUR_DWELL seconds there; the detour runs
//! the block's steps first, passes over a step that waits for a quest of the steps before it, and comes back to
//! those steps when the block has nothing open left (or on Back now), without skipping anything. Real Core
//! manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1440, { name = "Ashenvale", c = 1, left = 0, right = -2000, top = 2000, bottom = 0 })
w.addMap(1439, { name = "Darkshore", c = 1, left = 0, right = -2000, top = 5000, bottom = 3000 })
w.addMap(1437, { name = "Wetlands", c = 0, left = 0, right = -2000, top = 2000, bottom = 0 })
w.moveTo(1440, 50, 50)
w.setZone("Ashenvale")
w.level = 25
"#;

// Ashenvale 1-3 (accepts 101 and 103), Darkshore 4-6, Wetlands 7-10: step 9 hands in 103, taken at step 1.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/detour", pack = "test", title = "Detour", minLevel = 20, maxLevel = 30,
	zones = {
		{ start = 1, stop = 3, map = 1440, steps = 3 },
		{ start = 4, stop = 6, map = 1439, steps = 3 },
		{ start = 7, stop = 10, map = 1437, steps = 4, waits = { { s = 9, q = 103, at = 1 } } },
	},
	steps = {
		{ title = "Astranaar", goals = { { t = "accept", quest = 101, title = "Ash One", npc = 1, map = 1440, x = 50, y = 50 },
			{ t = "accept", quest = 103, title = "Letter for Menethil", npc = 1, map = 1440, x = 50, y = 50 } } },
		{ title = "Ash kills", goals = { { t = "kill", quest = 101, oi = 1, count = 1, target = "Wolf", npc = 11, map = 1440, x = 40, y = 40 } } },
		{ title = "Ash hand-in", goals = { { t = "turnin", quest = 101, title = "Ash One", npc = 1, map = 1440, x = 50, y = 50 } } },
		{ title = "Auberdine", goals = { { t = "accept", quest = 201, title = "Shore One", npc = 2, map = 1439, x = 50, y = 50 } } },
		{ title = "Shore kills", goals = { { t = "kill", quest = 201, oi = 1, count = 1, target = "Crab", npc = 12, map = 1439, x = 40, y = 40 } } },
		{ title = "Shore hand-in", goals = { { t = "turnin", quest = 201, title = "Shore One", npc = 2, map = 1439, x = 50, y = 50 } } },
		{ title = "Menethil", goals = { { t = "accept", quest = 301, title = "Wet One", npc = 3, map = 1437, x = 50, y = 50 } } },
		{ title = "Wet kills", goals = { { t = "kill", quest = 301, oi = 1, count = 1, target = "Raptor", npc = 13, map = 1437, x = 40, y = 40 } } },
		{ title = "Letter", goals = { { t = "turnin", quest = 103, title = "Letter for Menethil", npc = 4, map = 1437, x = 52, y = 52 } } },
		{ title = "Wet hand-in", goals = { { t = "turnin", quest = 301, title = "Wet One", npc = 3, map = 1437, x = 50, y = 50 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
function wetlands() w.moveTo(1437, 50, 50); w.setZone("Wetlands"); flush() end
function detour()
	local d = E.GetDetour()
	local rec = (Polestar.CharState().detours or {})["test/detour"]
	return { live = E.GetLiveStep(), running = d and d.start or false, back = d and d.back or false, saved = rec and (rec.back and "back" or "running") or false }
end
"#;

fn run(script: &str) -> Value {
	json!(emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/detour" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	}))
}

#[test]
fn a_zone_ahead_is_offered_after_half_a_minute_there_and_its_detour_comes_back_to_the_steps_passed_over() {
	let out = run(r#"
		wetlands()
		emit({ live = E.GetLiveStep(), offer = E.DetourOffer() and true or false })   -- just arrived: no offer yet
		stub.advance(31); flush()
		local b = E.DetourOffer()
		emit({ start = b and b.start or false })
		local p = E.DetourPreview(b)
		emit({ waits = p.waits[1] and p.waits[1].quest or false, back = p.back })
		emit(E.DetourStart(b))
		emit(detour())                                              -- live 7, the block's first step
		w.accept(301, { 1 }); flush()
		w.finish(301); flush()
		emit(detour())                                              -- 9 waits for 103 (step 1 still open): 10 is live
		w.turnIn(301); flush()
		emit(detour())                                              -- nothing open left: back to step 1, not skipped
		emit({ skipped = Polestar.CharState().skipped["test/detour"] == nil, offer = E.DetourOffer() and true or false })
		w.accept(101, { 1 }); w.accept(103); flush()
		emit(E.GetLiveStep())                                       -- the route goes on in order from step 1"#);
	assert_eq!(out[0], json!({ "live": 1, "offer": false }), "no offer before Own.DETOUR_DWELL seconds in the zone");
	assert_eq!(out[1], json!({ "start": 7 }), "the Wetlands block is offered");
	assert_eq!(out[2], json!({ "waits": 103, "back": 1 }), "the preview names the hand-in that waits for Ashenvale and where it comes back");
	assert_eq!(out[3], true);
	assert_eq!(out[4], json!({ "live": 7, "running": 7, "back": 1, "saved": "running" }));
	assert_eq!(out[5], json!({ "live": 10, "running": 7, "back": 1, "saved": "running" }), "the waiting step is passed over, not skipped");
	assert_eq!(out[6], json!({ "live": 1, "running": false, "back": false, "saved": "back" }), "the detour ends by itself; the guide's end waits for the steps it passed over");
	assert_eq!(out[7], json!({ "skipped": true, "offer": false }), "nothing skipped; the done block is not offered again");
	assert_eq!(out[8], 2);
}

#[test]
fn back_now_ends_the_detour_and_a_sync_drops_it() {
	let out = run(r#"
		wetlands(); stub.advance(31); flush()
		E.DetourStart(E.DetourOffer())
		emit(detour())
		emit(E.DetourBack())
		emit(detour())                                              -- back on step 1; the Wetlands steps come again in order
		E.DetourStart(E.DetourBlockAt(8))
		emit(detour())
		E.SkipUpTo(4)                                               -- a party sync to step 4
		emit(detour())"#);
	assert_eq!(out[0]["live"], 7);
	assert_eq!(out[1], true);
	assert_eq!(out[2], json!({ "live": 1, "running": false, "back": false, "saved": "back" }));
	assert_eq!(out[3]["live"], 7, "the Up next menu's block starts the same detour");
	assert_eq!(out[4], json!({ "live": 4, "running": false, "back": false, "saved": false }), "a sync drops the detour and moves the live step");
}

#[test]
fn the_settings_choose_the_offers() {
	let out = run(r#"
		wetlands(); stub.advance(31); flush()
		Polestar.Set("behavior.zoneDetourPartial", false)
		emit(E.DetourOffer() and true or false)                     -- step 9 waits: not offered without partial blocks
		Polestar.Set("behavior.zoneDetourPartial", true)
		Polestar.Set("behavior.zoneDetour", "menu")
		emit({ offer = E.DetourOffer() and true or false, menu = E.DetourBlockAt(8) and E.DetourBlockAt(8).start or false })
		Polestar.Set("behavior.zoneDetour", "both")
		E.DetourDismiss(E.DetourOffer())
		emit({ offer = E.DetourOffer() and true or false, menu = E.DetourBlockAt(3) and true or false })"#);
	assert_eq!(out[0], false);
	assert_eq!(out[1], json!({ "offer": false, "menu": 7 }), "\"menu\": no line, the Up next menu still offers it");
	assert_eq!(out[2], json!({ "offer": false, "menu": false }), "dismissed for the session; the live step's own block is never offered");
}
