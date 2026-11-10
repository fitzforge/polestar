//! The recorder's explorer mode (addon/Polestar_Recorder/Explore.lua, docs/RECORDING.md "Explorer mode"): it
//! works by itself while recording in Forever's new places (its new zones, new dungeons and around their
//! entrances) and nowhere else, unless `/psrec explore off` (or Polestar Client's explorer flag false) turns it
//! off; there it makes `unit` and `pos` denser and writes the explorer kinds (`unitx`, `poi`, `imap`,
//! `engage`, `where`, `open`), and says so once in chat. Against tests/lua/stub_recorder.lua.

use crate::recorder::{run, run_with, strings};
use serde_json::{json, Value};

/// Zephras Isle (2521, 1000 yd square: 1% = 10 yd), a cave inside it, Tirisfal, and the walking helpers.
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

const NOTE: &str = "recording more detail here to map this new zone (/psrec explore off to stop)";

#[test]
fn explorer_mode_makes_units_and_positions_denser_by_itself_in_new_zones_only_and_explore_off_stops_it() {
	let out = run(&format!(
		"{WORLD}{}",
		r#"
		-- Nothing typed: Zephras Isle at explorer density, 200 yd at 7 yd a second, and a cave inside it.
		walk(2521, 40, 60, 0.7)
		walk(2700, 10, 100, 3.5) -- 180 yd on a 200 yd map
		-- Outside the new zones: Elwynn's density stays as it was.
		walk(1429, 10, 13.8, 0.135) -- 200 yd on Elwynn (5200 yd wide)
		-- A new dungeon's entrance (Ruins of Lordaeron, 63.4 67.4 on Tirisfal): 400 yd towards it, the
		-- second half within 200 yd.
		walk(1420, 23.4, 63.4, 0.7, 67.4)
		-- /psrec explore off: Zephras Isle at the normal density again.
		cmd("explore off")
		walk(2521, 10, 30, 0.7)
		logout()
		local function counts(map, x1, x2) return { pos = count("pos", map, x1, x2), unit = count("unit", map, x1, x2), unitx = count("unitx", map, x1, x2) } end
		emit({
			on = counts(2521, 35), cave = counts(2700), elwynn = counts(1429),
			far = counts(1420, 0, 43.4), near = counts(1420, 43.4), off = counts(2521, 0, 35), bad = malformed(),
		})"#
	));
	println!("{out}");
	let n = |v: &Value| v.as_u64().unwrap();
	// The normal density: one breadcrumb per 25 yd and 2 s (every 4 s at 7 yd/s), one `unit` per 100 yd, no spawns.
	let normal = |c: &Value| {
		assert!((7..=9).contains(&n(&c["pos"])), "{c}");
		assert!((2..=3).contains(&n(&c["unit"])), "{c}");
		assert_eq!(c["unitx"], 0, "no `unitx` at the normal density: {c}");
	};
	// Explorer density: a breadcrumb per 10 yd (every 2 s at 7 yd/s), a `unit` per 30 yd, a `unitx` per spawn seen.
	let dense = |c: &Value, spawns: u64| {
		assert!((13..=16).contains(&n(&c["pos"])), "{c}");
		assert_eq!(c["unitx"], spawns, "one per spawn seen: {c}");
	};
	dense(&out["on"], 29);
	assert!((6..=8).contains(&n(&out["on"]["unit"])), "{}", out["on"]);
	dense(&out["cave"], 26);
	normal(&out["elwynn"]);
	normal(&out["far"]);
	dense(&out["near"], 29);
	normal(&out["off"]);
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn explorer_kinds_are_written_only_in_new_places_and_not_after_explore_off() {
	let out = run(&format!(
		"{WORLD}{}",
		r#"
		-- A quest from a giver in a building, an object opened, the quest's map points, then a dungeon
		-- (`inst`: its map id) with two floors, a spawn seen and a boss pulled.
		local function play(map, inst)
			W.instance, W.map, W.x, W.y = nil, map, 0.5, 0.5
			stub.fire("PLAYER_ENTERING_WORLD", false, false)
			stub.moveTo(45.12, 66.33, map)
			W.subzone, W.indoors = "The Drowned Chapel", true
			local giver = stub.creature(261306, "Mother Ysolde")
			stub.setUnit("npc", giver, "Mother Ysolde")
			W.gossip = { available = { 90012 }, active = {}, options = {} }
			stub.fire("GOSSIP_SHOW")
			stub.offerQuest(90012, giver, "Mother Ysolde", "Drowned Prayers")
			stub.acceptQuest(90012, { title = "Drowned Prayers", objectives = { { text = "Prayer Beads: %d/%d", type = "item", numRequired = 3 } } })
			W.indoors = false
			C_QuestLog.GetQuestsOnMap = function(m)
				if m ~= map then return {} end
				return { { questID = 90012, mapID = map, x = 0.44, y = 0.61, numObjectives = 1, isQuestStart = false, inProgress = true } }
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
			C_QuestLog.GetQuestsOnMap = function() return { { questID = 90012, mapID = map, x = 0.451, y = 0.663, numObjectives = 1 } } end
			stub.setProgress(90012, 1, 3)
			stub.advance(3)
			stub.turnIn(90012, giver, "Mother Ysolde", 450, 120)
			stub.world.completed[90012] = nil
			stub.fire("PLAYER_LEAVING_WORLD")
			W.instance = { id = inst, name = "A dungeon", kind = "party", diff = 1 }
			W.x, W.map = nil, 2681
			C_Map.GetMapGroupID = function(m) return (m == 2681 or m == 2682) and 512 or nil end
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
		end
		local KINDS = "unitx poi imap engage where open encounter"
		play(1429, 36) -- Elwynn and the Deadmines: not new
		cmd("mark new")
		play(2521, 3065) -- Zephras Isle and the Hall of Thanes
		cmd("mark off")
		cmd("explore off")
		play(2521, 3065)
		logout()
		local phases, list = {}, {}
		phases[1] = list
		for _, r in ipairs(recs("mark " .. KINDS)) do
			if r:find("^mark|") then
				list = {}
				phases[#phases + 1] = list
			else
				list[#list + 1] = r
			end
		end
		emit({ old = phases[1], new = phases[2], off = phases[3], bad = malformed() })"#
	));
	// Not new, or turned off: only the encounter end the Recorder always writes.
	assert_eq!(out["old"], json!(["encounter|3301|1|1|5"]));
	assert_eq!(out["off"], json!(["encounter|3301|1|1|5"]));
	let new = strings(&out["new"]);
	let want = [
		"where|c|261306|The Drowned Chapel|1",
		"poi|90012|0|2521|4400|6100",
		"open|3365|2521|4512|6633|o|500123",
		"open|1290001|2521|4512|6633||",
		"poi|90012|1|2521|4510|6630",
		"imap|3065|2681|512|1",
		"unitx|261400|0000000000|||",
		"imap|3065|2682|512|2",
		"engage|3301|1|5",
		"encounter|3301|1|1|5",
	];
	assert_eq!(new.len(), want.len(), "{new:?}");
	for (got, want) in new.iter().zip(want) {
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
fn it_says_so_once_the_first_time_and_explore_off_or_the_client_flag_keep_it_off() {
	// `script` after WORLD; then: whether the note was shown and how often, the opt-out, and the spawns seen.
	let run_case = |before: &str, saved: &str, script: &str| {
		run_with(
			&format!(
				"{WORLD}{script}\nlocal said, notes = table.concat(stub.messages, \"\\n\"), 0\nfor _, m in ipairs(stub.messages) do if m:find(\"recording more detail here\", 1, true) then notes = notes + 1 end end\nlogout()\nemit({{ notes = notes, said = said, saidFlag = PolestarRecorderDB.exploreSaid == true, off = PolestarRecorderDB.exploreOff == true, unitx = count(\"unitx\", 2521) }})"
			),
			before,
			true,
			Some(saved),
		)
	};
	let enter = "walk(2521, 40, 42, 0.7); walk(1429, 10, 10.5, 0.135); walk(2521, 40, 42, 0.7)";
	// Recording, nothing typed: the note once, the first time, in the Recorder's words; spawns recorded.
	let first = run_case("", "PolestarRecorderDB = { schema = 2, enabled = true }", enter);
	assert_eq!((first["notes"].as_u64(), first["saidFlag"].as_bool()), (Some(1), Some(true)), "{first}");
	assert!(first["said"].as_str().unwrap().contains(&format!("Polestar Recorder|r: {NOTE}")), "{}", first["said"]);
	assert!(first["unitx"].as_u64().unwrap() > 0);
	// Shown once per account: not again at a later login.
	let later = run_case("", "PolestarRecorderDB = { schema = 2, enabled = true, exploreSaid = true }", enter);
	assert_eq!(later["notes"], 0);
	assert!(later["unitx"].as_u64().unwrap() > 0);
	// Outside the new zones: no note.
	assert_eq!(run_case("", "PolestarRecorderDB = { schema = 2, enabled = true }", "walk(1429, 10, 11, 0.135)")["notes"], 0);
	// Recording off: nothing at all.
	let rec_off = run_case("", "PolestarRecorderDB = { schema = 2, enabled = false }", enter);
	assert_eq!((rec_off["notes"].as_u64(), rec_off["unitx"].as_u64()), (Some(0), Some(0)));
	// /psrec explore off (kept): no note, no explorer records, and the status says off.
	let opted = run_case("", "PolestarRecorderDB = { schema = 2, enabled = true, exploreOff = true }", &format!("{enter}; cmd(\"status\")"));
	assert_eq!((opted["notes"].as_u64(), opted["unitx"].as_u64(), opted["off"].as_bool()), (Some(0), Some(0), Some(true)), "{opted}");
	assert!(opted["said"].as_str().unwrap().contains("explorer mode: |cffd14f4foff|r (/psrec explore on | off)"), "{}", opted["said"]);
	// Polestar Client's explorer flag false keeps it off too (without the player's opt-out); true does not
	// undo /psrec explore off; /psrec explore on overrides the flag.
	let client_off = run_case("PolestarRecorderExplore = false", "PolestarRecorderDB = { schema = 2, enabled = true }", enter);
	assert_eq!((client_off["notes"].as_u64(), client_off["unitx"].as_u64(), client_off["off"].as_bool()), (Some(0), Some(0), Some(false)));
	let flag_on = run_case("PolestarRecorderExplore = true", "PolestarRecorderDB = { schema = 2, enabled = true, exploreOff = true }", enter);
	assert_eq!(flag_on["unitx"], 0);
	let back_on = run_case("PolestarRecorderExplore = false", "PolestarRecorderDB = { schema = 2, enabled = true, exploreOff = true }", &format!("cmd(\"explore on\"); {enter}"));
	assert_eq!((back_on["notes"].as_u64(), back_on["off"].as_bool()), (Some(1), Some(false)), "{back_on}");
	assert!(back_on["unitx"].as_u64().unwrap() > 0);
	assert!(back_on["said"].as_str().unwrap().contains("Nothing new about you."));
	// Typed off in play: off from then on, and kept.
	let typed = run_case("", "PolestarRecorderDB = { schema = 2, enabled = true, exploreSaid = true }", &format!("cmd(\"explore off\"); {enter}"));
	assert_eq!((typed["unitx"].as_u64(), typed["off"].as_bool()), (Some(0), Some(true)));
	assert!(run_case("", "PolestarRecorderDB = { schema = 2, enabled = true }", "cmd(\"explore maybe\")")["said"].as_str().unwrap().contains("usage: /psrec explore on | off"));
}
