//! The recorder's explorer mode (addon/Polestar_Recorder/Explore.lua, docs/RECORDING.md "Explorer mode"):
//! off until `/psrec explore on` (or Polestar Client's explorer flag), denser `unit` and `pos` in Forever's new
//! zones and around its new dungeons' entrances, and the explorer kinds (`unitx`, `poi`, `imap`, `engage`,
//! `where`, `open`), against tests/lua/stub_recorder.lua.

use crate::recorder::{run, run_with, strings};
use serde_json::json;

/// Zephras Isle (2521, 1000 yd square: 1% = 10 yd), a cave inside it, and the walking helpers.
const WORLD: &str = r#"
local W = stub.world
W.maps[2521] = { name = "Zephras Isle", mapType = 3, parentMapID = 947, c = 1, top = 1000, left = 1000, bottom = 0, right = 0, w = 1000, h = 1000 }
W.maps[2700] = { name = "Tidecaller Grotto", mapType = 6, parentMapID = 2521, c = 1, top = 200, left = 200, bottom = 0, right = 0, w = 200, h = 200 }
W.maps[1420] = { name = "Tirisfal Glades", mapType = 3, parentMapID = 1415, c = 0, top = 3000, left = 3000, bottom = 0, right = 0, w = 1000, h = 1000 }
W.speed = 7
-- Walks along y (50 unless given) from x to x2 in steps of `step` percent a
-- second, a creature of npc 2000 (a new spawn each time) on a nameplate every
-- second.
local function walk(map, x, x2, step, y)
	W.moving = true
	while x <= x2 do
		stub.moveTo(x, y or 50, map)
		stub.setUnit("nameplate1", (stub.creature(2000, "Tidecaller")), "Tidecaller")
		W.units.nameplate1.lvl = 8
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.advance(1)
		x = x + step
	end
	W.moving = false
end
-- Records of `kind` on `map` with x (percent) from x1 to below x2, once the
-- chunks are stored (after logout()).
local MAP_FIELD = { pos = 3, unit = 7, unitx = 5 }
local function count(kind, map, x1, x2)
	local n = 0
	for _, r in ipairs(all()) do
		local f = MAP_FIELD[kind]
		if r[1] == kind and r[f] == tostring(map) then
			local x = tonumber(r[f + 1]) / 100
			if x >= (x1 or 0) and x < (x2 or 101) then n = n + 1 end
		end
	end
	return n
end
"#;

#[test]
fn explorer_mode_is_off_by_default_and_makes_units_and_positions_denser_only_in_new_zones() {
	let out = run(&format!(
		"{WORLD}{}",
		r#"
		-- Off: Zephras Isle at the normal density, 200 yd at 7 yd a second.
		walk(2521, 10, 30, 0.7)
		-- On: the same walk further along, in the zone and in a cave inside it.
		cmd("explore on")
		walk(2521, 40, 60, 0.7)
		walk(2700, 10, 100, 3.5) -- 180 yd on a 200 yd map
		-- On, but outside the new zones: Elwynn's density stays as it was.
		walk(1429, 10, 13.8, 0.135) -- 200 yd on Elwynn (5200 yd wide)
		-- A new dungeon's entrance (Ruins of Lordaeron, 63.4 67.4 on Tirisfal): 400 yd towards it, the
		-- second half within 200 yd.
		walk(1420, 23.4, 63.4, 0.7, 67.4)
		logout()
		local function counts(map, x1, x2) return { pos = count("pos", map, x1, x2), unit = count("unit", map, x1, x2), unitx = count("unitx", map, x1, x2) } end
		emit({
			off = counts(2521, 0, 35), on = counts(2521, 35), cave = counts(2700), elwynn = counts(1429),
			far = counts(1420, 0, 43.4), near = counts(1420, 43.4), bad = malformed(),
		})"#
	));
	println!("{out}");
	let n = |v: &serde_json::Value| v.as_u64().unwrap();
	// Off: one breadcrumb per 25 yd and 2 s (every 4 s at 7 yd/s), one `unit` per 100 yd, no spawn records.
	let normal = |c: &serde_json::Value| {
		assert!((7..=9).contains(&n(&c["pos"])), "{c}");
		assert!((2..=3).contains(&n(&c["unit"])), "{c}");
		assert_eq!(c["unitx"], 0, "no `unitx` at the normal density: {c}");
	};
	normal(&out["off"]);
	// On: a breadcrumb per 10 yd (every 2 s at 7 yd/s), a `unit` per 30 yd, a `unitx` per spawn seen.
	let dense = |c: &serde_json::Value, spawns: u64| {
		assert!((13..=16).contains(&n(&c["pos"])), "{c}");
		assert_eq!(c["unitx"], spawns, "one per spawn seen: {c}");
	};
	dense(&out["on"], 29);
	assert!((6..=8).contains(&n(&out["on"]["unit"])), "{}", out["on"]);
	// A map inside a new zone is dense too.
	dense(&out["cave"], 26);
	// Elsewhere the normal density.
	normal(&out["elwynn"]);
	// Towards the entrance: normal until 200 yd from it, dense within.
	normal(&out["far"]);
	dense(&out["near"], 29);
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn explorer_kinds_are_written_only_in_explorer_mode() {
	let out = run(&format!(
		"{WORLD}{}",
		r#"
		local function play()
			-- A quest giver in a building, offered, accepted, handed in.
			stub.moveTo(45.12, 66.33, 2521)
			W.subzone, W.indoors = "The Drowned Chapel", true
			local giver = stub.creature(261306, "Mother Ysolde")
			stub.setUnit("npc", giver, "Mother Ysolde")
			W.gossip = { available = { 90012 }, active = {}, options = {} }
			stub.fire("GOSSIP_SHOW")
			stub.offerQuest(90012, giver, "Mother Ysolde", "Drowned Prayers")
			stub.acceptQuest(90012, { title = "Drowned Prayers", objectives = { { text = "Prayer Beads: %d/%d", type = "item", numRequired = 3 } } })
			W.indoors = false
			-- The quest log's map points.
			C_QuestLog.GetQuestsOnMap = function(map)
				if map ~= 2521 then return {} end
				return { { questID = 90012, mapID = 2521, x = 0.44, y = 0.61, numObjectives = 1, isQuestStart = false, inProgress = true } }
			end
			stub.advance(3)
			-- A chest opened with Opening (the client names the object), a player soft-targeted: no target.
			W.spells[3365] = "Opening"
			W.spells[1290001] = "Opening"
			stub.setUnit("softinteract", (stub.gameObject(500123, "Barnacled Chest")), "Barnacled Chest")
			stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", 3365)
			stub.setUnit("softinteract", "Player-1-00000002", "Somebody")
			stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-2", 1290001) -- a Forever "Opening" by its name
			stub.setUnit("softinteract", nil)
			stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-3", 133) -- not an opening
			-- The objectives done: the point moves to the hand-in.
			C_QuestLog.GetQuestsOnMap = function() return { { questID = 90012, mapID = 2521, x = 0.451, y = 0.663, numObjectives = 1 } } end
			stub.setProgress(90012, 1, 3)
			stub.advance(3)
			stub.turnIn(90012, giver, "Mother Ysolde", 450, 120)
			stub.world.completed[90012] = nil
			-- A new dungeon: two floors, a pull, a spawn seen inside.
			stub.fire("PLAYER_LEAVING_WORLD")
			W.instance = { id = 2943, name = "Hall of Thanes", kind = "party", diff = 1 }
			W.x, W.map = nil, 2681
			C_Map.GetMapGroupID = function(map) return (map == 2681 or map == 2682) and 512 or nil end
			C_Map.GetMapGroupMembersInfo = function(g) return g == 512 and { { mapID = 2681, relativeHeightIndex = 1, name = "Hall" }, { mapID = 2682, relativeHeightIndex = 2, name = "Forge" } } or nil end
			stub.fire("PLAYER_ENTERING_WORLD", false, false)
			stub.advance(2)
			local boss = stub.creature(261400, "Faldrim Anvilmar")
			stub.setUnit("target", boss, "Faldrim Anvilmar")
			stub.fire("PLAYER_TARGET_CHANGED")
			stub.fire("PLAYER_TARGET_CHANGED") -- the same spawn again: one record
			W.map = 2682
			stub.advance(2)
			stub.fire("ENCOUNTER_START", 3301, "Faldrim Anvilmar", 1, 5)
			stub.advance(30)
			stub.fire("ENCOUNTER_END", 3301, "Faldrim Anvilmar", 1, 5, 1)
			W.instance, W.map, W.x, W.y = nil, 2521, 0.5, 0.5
			stub.fire("PLAYER_ENTERING_WORLD", false, false)
			stub.advance(2)
		end
		local KINDS = "unitx poi imap engage where open encounter"
		play()
		cmd("mark explorer on")
		cmd("explore on")
		W.instance, W.map, W.x, W.y = nil, 2521, 0.5, 0.5
		play()
		logout()
		local off, on, list = {}, {}, nil
		list = off
		for _, r in ipairs(recs("mark " .. KINDS)) do
			if r:find("^mark|") then list = on else list[#list + 1] = r end
		end
		emit({ off = off, on = on, bad = malformed() })"#
	));
	// Off: only the encounter end it always had.
	assert_eq!(out["off"], json!(["encounter|3301|1|1|5"]));
	let on = strings(&out["on"]);
	let want = [
		"where|c|261306|The Drowned Chapel|1",
		"poi|90012|0|2521|4400|6100",
		"open|3365|2521|4512|6633|o|500123",
		"open|1290001|2521|4512|6633||",
		"poi|90012|1|2521|4510|6630",
		"imap|2943|2681|512|1",
		"unitx|261400|0000000000|||",
		"imap|2943|2682|512|2",
		"engage|3301|1|5",
		"encounter|3301|1|1|5",
	];
	assert_eq!(on.len(), want.len(), "{on:?}");
	for (got, want) in on.iter().zip(want) {
		if want.starts_with("unitx|") {
			// The GUID's spawn part (the stub's serial): its last part only.
			assert!(got.starts_with("unitx|261400|") && got.ends_with("|||"), "{got}");
			let uid = got.split('|').nth(2).unwrap();
			assert!(uid.len() == 10 && uid.chars().all(|c| c.is_ascii_hexdigit() && !c.is_ascii_lowercase()), "{got}");
		} else {
			assert_eq!(got, want);
		}
	}
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn psrec_explore_turns_it_on_and_off_and_the_client_flag_works_like_the_share_flag() {
	let status = |before: &str, saved: &str, script: &str| {
		run_with(
			&format!("{script}\nemit({{ on = PolestarRecorderDB.explore == true, off = PolestarRecorderDB.exploreOff == true, said = table.concat(stub.messages, \"\\n\") }})"),
			before,
			true,
			Some(saved),
		)
	};
	let on = status("", "PolestarRecorderDB = { schema = 2, enabled = true }", "cmd(\"explore on\") cmd(\"status\")");
	assert_eq!((on["on"].as_bool(), on["off"].as_bool()), (Some(true), Some(false)));
	let said = on["said"].as_str().unwrap();
	assert!(said.contains("explorer mode") && said.contains("Nothing new about you."), "{said}");
	assert!(said.contains("explorer mode: |cff4fd18fon|r (/psrec explore on | off)"), "{said}");
	// Recording off: it says so.
	let rec_off = status("", "PolestarRecorderDB = { schema = 2, enabled = false }", "cmd(\"explore\")");
	assert_eq!(rec_off["on"], true);
	assert!(rec_off["said"].as_str().unwrap().contains("recording is off; /psrec on first"), "{}", rec_off["said"]);
	// The client's flag turns it on, and off, unless the player typed /psrec explore off.
	assert_eq!(status("PolestarRecorderExplore = true", "PolestarRecorderDB = { schema = 2, enabled = true }", "")["on"], true);
	assert_eq!(status("PolestarRecorderExplore = false", "PolestarRecorderDB = { schema = 2, enabled = true, explore = true }", "")["on"], false);
	assert_eq!(status("PolestarRecorderExplore = true", "PolestarRecorderDB = { schema = 2, enabled = true, exploreOff = true }", "")["on"], false);
	// No flag: the player's own choice stays.
	assert_eq!(status("", "PolestarRecorderDB = { schema = 2, enabled = true, explore = true }", "")["on"], true);
	assert_eq!(status("", "PolestarRecorderDB = { schema = 2, enabled = true }", "")["on"], false);
	let toggled = status("", "PolestarRecorderDB = { schema = 2, enabled = true, explore = true }", "cmd(\"explore off\")");
	assert_eq!((toggled["on"].as_bool(), toggled["off"].as_bool()), (Some(false), Some(true)));
	assert!(status("", "PolestarRecorderDB = { schema = 2, enabled = true }", "cmd(\"explore maybe\")")["said"].as_str().unwrap().contains("usage: /psrec explore on | off"));
}
