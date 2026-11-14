//! Gathering spots in While you're here (addon/Polestar/Core/Gather.lua; Core/Engine.lua, Own.hereGather*; option
//! behavior.whileHereGather, off by default): within the radius, a spot where a herb, ore vein or fishing pool the
//! character gathers can spawn is a line after the quest lines, one at a time. Its kind must be one the character
//! gathers at its skill; it says the node can grow or spawn there, "is up here" only while the Interact Key picks one
//! of its kind, and carries `tracking` while the minimap tracks that profession's nodes. A dismiss mutes the kind
//! around here. The poll allocates nothing. Real Core manifest, stub world.
//!
//! Elwynn here is 3000 yd across (30 yd per map percent on x) and 2000 yd high (20 yd per percent on y).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.level = 5
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 70, 80)
"#;

// One step far away (the guide's live step: no quest line comes near the spots).
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/gather", pack = "test", title = "Gather", minLevel = 1, maxLevel = 10,
	steps = { { title = "Far away", goals = { { t = "goto", map = 1429, x = 90, y = 90 } } } },
})
"#;

// Peacebloom (Herbalism 1) at 40,50; a Copper Vein (Mining 1) at 40,50.5; Mageroyal (Herbalism 50) at 39.9,50.
const HELPERS: &str = r#"
E, w = Polestar.Engine, stub.world
function flush() stub.advance(0.25) end
function at(x, y) w.moveTo(1429, x, y); stub.advance(0.6) end
local B = "0123456789ABCDEFGHIJKLMNOPQRSTUVWYabcdefghijklmnopqrstuvwy+/"
local function enc(v)
	local n = math.floor(v / 100 * 3599 + 0.5)
	local a, b = math.floor(n / 60), n % 60
	return B:sub(a + 1, a + 1) .. B:sub(b + 1, b + 1)
end
local function spot(x, y) return enc(x) .. enc(y) end
Polestar.MapFrames.era[1429] = { c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }
Polestar.Gather.Register({
	kinds = { { "Peacebloom", 182, 1, 1618, 3724 }, { "Copper Vein", 186, 1, 1731 }, { "Mageroyal", 182, 50, 1620 } },
	maps = { [1429] = "e;1:" .. spot(40, 50) .. ";2:" .. spot(40, 50.5) .. ";3:" .. spot(39.9, 50) },
})
-- The gathering spot lines shown: { step, kind, verb, text, under it, yards, tracking }.
function gathers()
	local out = {}
	for _, v in ipairs(E.GetWhileHereList()) do
		if v.here == "gather" then out[#out + 1] = { v.step, v.index, v.t, v.hereText, v.hereSub or false, v.yards or false, v.tracking or false } end
	end
	return out
end
r = {}
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/gather" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, HELPERS, script, "emit(r)"].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_spot_of_a_kind_the_character_gathers_is_a_line_once_the_option_is_on_and_a_dismiss_mutes_its_kind_around_here() {
	let out = run(r#"
		w.learnSkill(182, "Herbalism", 1, 75); flush()
		at(40.2, 50)
		r.off = gathers()
		Polestar.Set("behavior.whileHereGather", true); flush(); at(40.2, 50)
		r.on = gathers()
		r.aim = E.AimWhileHere(1)
		local wp = E.GetWaypoint()
		r.wp = wp and { wp.map, wp.x, wp.y } or false
		-- Herbalism 50 opens Mageroyal: the Peacebloom line dismissed, the Mageroyal spot 9 yd off shows.
		w.skillUp(182, 50); flush()
		E.DismissWhileHere(1); flush(); at(40.2, 50)
		r.next = gathers()
		-- Out of reach: the line goes.
		at(70, 80)
		r.gone = gathers()
		Polestar.Set("behavior.whileHereGather", false); flush(); at(40.3, 50)
		r.offAgain = gathers()
		"#);
	assert_eq!(out["off"], json!({}), "off by default");
	assert_eq!(out["on"], json!([[-3, 1, "gather", "Peacebloom can grow here", "Herbalism 1", 5, false]]), "no Copper Vein without Mining, no Mageroyal at Herbalism 1");
	assert_eq!(out["aim"], json!(true));
	let wp = out["wp"].as_array().unwrap();
	assert_eq!(wp[0], json!(1429));
	assert!((wp[1].as_f64().unwrap() - 40.0).abs() < 0.05 && (wp[2].as_f64().unwrap() - 50.0).abs() < 0.05, "the arrow at the spot: {wp:?}");
	assert_eq!(out["next"], json!([[-3, 3, "gather", "Mageroyal can grow here", "Herbalism 50", 10, false]]));
	assert_eq!(out["gone"], json!({}));
	assert_eq!(out["offAgain"], json!({}));
}

#[test]
fn up_here_while_the_interact_key_picks_one_and_tracking_while_the_minimap_tracks_herbs() {
	let out = run(r#"
		local tracking = false
		C_Minimap = C_Minimap or {}
		C_Minimap.GetNumTrackingTypes = function() return 2 end
		C_Minimap.GetTrackingInfo = function(i)
			if i == 1 then return { name = "Find Herbs", active = tracking, spellID = 2383 } end
			return { name = "Track Humanoids", active = true, spellID = 5225 }
		end
		w.learnSkill(182, "Herbalism", 1, 75); flush()
		Polestar.Set("behavior.whileHereGather", true); flush(); at(40.2, 50)
		r.plain = gathers()
		tracking = true
		stub.fire("MINIMAP_UPDATE_TRACKING"); flush()
		r.tracking = gathers()
		stub.fire("PLAYER_SOFT_INTERACT_CHANGED", nil, "GameObject-0-1-0-12-3724-0000ABCDEF"); flush()
		r.up = gathers()
		stub.fire("PLAYER_SOFT_INTERACT_CHANGED", "GameObject-0-1-0-12-3724-0000ABCDEF", "Creature-0-1-0-12-299-0000ABCDEF"); flush()
		r.gone = gathers()
		"#);
	assert_eq!(out["plain"], json!([[-3, 1, "gather", "Peacebloom can grow here", "Herbalism 1", 5, false]]));
	assert_eq!(out["tracking"], json!([[-3, 1, "gather", "Peacebloom can grow here", "Herbalism 1", 5, true]]));
	assert_eq!(out["up"], json!([[-3, 1, "gather", "Peacebloom is up here", "Herbalism 1", 5, true]]), "a second Peacebloom object id counts too");
	assert_eq!(out["gone"], json!([[-3, 1, "gather", "Peacebloom can grow here", "Herbalism 1", 5, true]]));
}

#[test]
fn the_gathering_spot_poll_allocates_nothing_per_tick() {
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
		w.learnSkill(182, "Herbalism", 1, 75); flush()
		Polestar.Set("behavior.whileHereGather", true); flush()
		at(40.2, 50)
		r.line = gathers()
		r.shown = ticks(2000)
		-- Dismissed (muted while the player stays): measuring the spots with nothing to show.
		E.DismissWhileHere(1); flush()
		at(40.25, 50)
		r.idle = ticks(2000)
		r.after = gathers()
		"#);
	assert_eq!(out["line"], json!([[-3, 1, "gather", "Peacebloom can grow here", "Herbalism 1", 5, false]]));
	assert_eq!(out["after"], json!({}));
	let (shown, idle) = (out["shown"].as_f64().unwrap(), out["idle"].as_f64().unwrap());
	assert!(shown < 0.5, "2000 polls with the line shown allocated {shown:.2} KiB");
	assert!(idle < 0.5, "2000 polls measuring the spots allocated {idle:.2} KiB");
}
