//! Performance budgets for the Recorder (addon/Polestar_Recorder) while it records, against the world of
//! tests/lua/stub_recorder.lua: the budgets perf.rs holds Polestar to, so the Recorder can stay on while a
//! player plays. Addon time is CPU time inside its event handlers, OnUpdate scripts and C_Timer callbacks
//! (tests/lua/profile.lua).
//!
//!   - a frame while the player walks (the breadcrumb ticker included): under 1 ms;
//!   - a burst of the events questing sends most, 50 of each in one frame with a full quest log, plus the
//!     scans it schedules: under 4 ms;
//!   - a burst of finds in one frame (20 rares seen, 20 kills and their loot windows, a big pull), plus the
//!     loot checks they schedule: under 4 ms.
//!
//! Each measurement is taken over 5 rounds (ROUNDS) and the median is held to the budget; a regression shows
//! in every round, a hiccup in one.
//!
//! Every round also times a reference (reference() below): 400 events through the same event path to a plain
//! handler doing what a Recorder handler does, about 1.7 ms here (Linux, lua5.1). Each figure is also held in
//! reference units, divided by its round's reference: the Recorder's work in units of plain recording work,
//! which holds across machines and across lua5.1 and LuaJIT. On Windows os.clock() counts wall time, so a busy
//! or slow machine stretches the milliseconds; it stretches the reference in the same round alike, so there
//! only the units are held. Where os.clock() is CPU time the milliseconds are held as well.
//!
//! Unlike perf.rs it needs no reference data, so it runs everywhere.

use forge_addontest::{emitted, RunAddon};
use serde_json::{json, Value};

/// The budgets in ms and in reference units, by key. Here the questing burst is ~0.7 units on lua5.1 and
/// LuaJIT, the finds burst ~1.2 on lua5.1 and ~1.9 on LuaJIT, a walking frame under 0.05: each budget leaves
/// LuaJIT headroom and fails a Recorder about 3 times slower on lua5.1.
fn budget(key: &str) -> (f64, f64) {
	match key {
		"quests" => (4.0, 2.0),
		"finds" => (4.0, 3.0),
		"tick" => (1.0, 0.6),
		_ => panic!("no budget {key}"),
	}
}

const ROUNDS: i32 = 5;
// os.clock() is wall time with the Microsoft C runtime.
const CPU_CLOCK: bool = !cfg!(windows);

// Recording on, the delayed work after login done, and the measuring helpers.
const PRELUDE: &str = r#"
local P = stub.profile
SlashCmdList.POLESTARREC("on")
stub.advance(3) -- the delayed work after login
local out = {}
local ROUNDS = ${ROUNDS}

-- One step of os.clock: whole milliseconds on some systems (Windows), so a
-- reading can be one step high. Never more than 1 ms of slack.
local c0 = os.clock()
local c1 = os.clock()
while c1 == c0 do c1 = os.clock() end
out.resolution = math.min((c1 - c0) * 1000, 1)

local function median(list)
	table.sort(list)
	return list[math.ceil(#list / 2)]
end

-- The reference: 400 events through the same event path to a plain handler
-- that does what a Recorder handler does (asks the game for a unit and the
-- player's position, parses the GUID, writes an event table), in addon ms as
-- P.total counts them. Recorder work, not a plain Lua loop, so it speeds up
-- or slows down with the interpreter (lua5.1, LuaJIT) as the Recorder does.
-- Timed over 4,000 events, so a millisecond os.clock reads it to a few
-- percent.
local refEvents
local refFrame = CreateFrame("Frame")
refFrame:RegisterEvent("POLESTAR_TEST_REFERENCE")
refFrame:SetScript("OnEvent", function(_, _, i)
	local kind, id = UnitGUID("player"):match("^(%a+)%-[^-]*%-(%x+)")
	local map = C_Map.GetBestMapForUnit("player")
	local pos = map and C_Map.GetPlayerMapPosition(map, "player")
	local x, y = 0, 0
	if pos then x, y = pos:GetXY() end
	x, y = math.floor(x * 10000 + 0.5) / 100, math.floor(y * 10000 + 0.5) / 100
	refEvents[#refEvents + 1] = { e = kind, id = id, i = i, name = UnitName("player"), map = map, x = x, y = y,
		at = string.format("%d:%.2f,%.2f", map or 0, x, y) }
end)
local function reference()
	refEvents = {}
	collectgarbage("collect")
	local t = P.total()
	for i = 1, 4000 do stub.fire("POLESTAR_TEST_REFERENCE", i) end
	return (P.total() - t) / 10
end

-- Holds a figure in ms (out[key]) and in reference units (out[key .. "Ref"]):
-- the medians over the rounds of ms[r] and ms[r] / refs[r].
local function hold(key, ms, refs)
	local units = {}
	for r = 1, #ms do units[r] = ms[r] / refs[r] end
	out[key], out[key .. "Ref"] = median(ms), median(units)
	out.reference = math.min(out.reference or math.huge, median(refs))
end

-- Addon time of a second of frames when nothing happens (one ticker run).
local function idleFrames()
	local t = P.total()
	stub.advance(1)
	return P.total() - t
end
local idle = math.huge
for _ = 1, 5 do idle = math.min(idle, idleFrames()) end
out.idle = idle

-- Holds as out[key] what fire(round) and the second of frames after it
-- cost, less an idle second, over ROUNDS. The events are fired from the top
-- level, so P.total counts the Recorder's handlers and not the loop that
-- fires them.
local function burst(key, fire)
	local rounds, refs = {}, {}
	for r = 1, ROUNDS do
		refs[r] = reference()
		collectgarbage("collect")
		local t = P.total()
		fire(r)
		stub.advance(1)
		rounds[r] = P.total() - t - idle
	end
	hold(key, rounds, refs)
end

local S = PolestarRecorderDB.sessions[PolestarRecorderDB.current]
local function count(kind)
	local n = 0
	for _, e in ipairs(S.events) do if e.e == kind then n = n + 1 end end
	return n
end
"#;

fn measure(script: &str) -> Value {
	let prelude = PRELUDE.replace("${ROUNDS}", &ROUNDS.to_string());
	emitted(&RunAddon {
		stubs: vec!["stub_recorder.lua", "profile.lua"],
		addons: vec!["Polestar_Recorder".into()],
		login: true,
		before: "stub.profile.start()".into(),
		script: [prelude.as_str(), script, "emit(out)"].join("\n"),
		..Default::default()
	})
	.remove(0)
}

/// A number's value, NaN when it is missing (a comparison with it fails, as with undefined in JS).
fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or(f64::NAN)
}

// Each key under its budget in reference units and, where os.clock() is CPU time, in ms; a reading may be
// one os.clock step high.
fn within(r: &Value, keys: &[&str]) {
	let measured: serde_json::Map<String, Value> = r
		.as_object()
		.unwrap()
		.iter()
		.map(|(k, v)| {
			let v = match v.as_f64() {
				Some(f) if v.is_f64() => json!((f * 1000.0).round() / 1000.0),
				_ => v.clone(),
			};
			(k.clone(), v)
		})
		.collect();
	let budgets = json!({
		"ms": { "quests": 4, "finds": 4, "tick": 1 },
		"units": { "quests": 2, "finds": 3, "tick": 0.6 },
	});
	let report = format!("budgets {budgets}; measured (ms, <key>Ref in units) {}", Value::Object(measured));
	let resolution = num(&r["resolution"]);
	for k in keys {
		let (ms, units) = budget(k);
		assert!(num(&r[format!("{k}Ref")]) < units + resolution / num(&r["reference"]), "{k} over budget in reference units: {report}");
		if CPU_CLOCK {
			assert!(num(&r[*k]) < ms + resolution, "{k} over budget in ms: {report}");
		}
	}
	println!("{report}");
}

#[test]
fn recording_stays_within_the_walking_frame_and_event_burst_budgets() {
	let r = measure(
		r#"
local mob = stub.creature(6, "Kobold Vermin")
stub.setUnit("mouseover", mob, "Kobold Vermin")
stub.setUnit("target", mob, "Kobold Vermin")
-- A full quest log, every quest a kill further along each round, so the
-- scans the burst schedules have progress to record.
for q = 1, 20 do
	stub.acceptQuest(q, { title = "Quest " .. q, level = 5, objectives = {
		{ text = "Kobold Vermin slain: %d/%d", numRequired = 100 },
		{ text = "Gold Dust: %d/%d", type = "item", numRequired = 100 },
	} })
end
stub.advance(1)
local progress = count("progress")
burst("quests", function(round)
	for q = 1, 20 do stub.world.quests[q].objectives[1].numFulfilled = round end
	for _ = 1, 50 do
		stub.fire("QUEST_LOG_UPDATE")
		stub.fire("UNIT_QUEST_LOG_CHANGED", "player")
		stub.fire("UPDATE_MOUSEOVER_UNIT")
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-3-0-0-0-6603-0", 6603)
	end
end)
out.progress = count("progress") - progress

-- Walking: one frame at a time for 10 s, far enough that breadcrumbs are
-- written (the work being measured). Each round's slowest frame; the median
-- of those is held to the budget.
local slowest, refs = {}, {}
out.crumbs = math.huge
stub.world.moving = true
for r = 1, ROUNDS do
	refs[r] = reference()
	local before = count("pos")
	collectgarbage("collect")
	slowest[r] = 0
	for i = 1, 200 do
		stub.moveTo(20 + i * 0.2, 30 + i * 0.1)
		local t = P.total()
		stub.advance(0.05)
		slowest[r] = math.max(slowest[r], P.total() - t)
	end
	out.crumbs = math.min(out.crumbs, count("pos") - before)
end
stub.world.moving = false
hold("tick", slowest, refs)"#,
	);
	assert_eq!(r["progress"], ROUNDS * 20, "every round recorded progress on each of the 20 quests, so the quest scans were measured");
	assert!(num(&r["crumbs"]) > 0.0, "a round of walking wrote no breadcrumbs, so nothing was measured");
	within(&r, &["quests", "tick"]);
}

#[test]
fn recording_rares_kills_and_loot_windows_stays_within_the_event_burst_budget() {
	let r = measure(
		r#"
local W = stub.world
local function unit(token, guid, name, cls, lvl)
	stub.setUnit(token, guid, name)
	W.units[token].cls, W.units[token].lvl = cls, lvl
end
-- A rare and a treasure behind vignettes, as the minimap lists them.
local V = {
	["Vignette-1"] = { objectGUID = (stub.creature(62, "Gruff Swiftbite")), name = "Gruff Swiftbite", x = 60, y = 70 },
	["Vignette-2"] = { objectGUID = (stub.gameObject(2843, "Battered Chest")), name = "Battered Chest", x = 25, y = 30 },
}
C_VignetteInfo = {
	GetVignetteInfo = function(g) return V[g] end,
	GetVignettePosition = function(g) local v = V[g]; return v and CreateVector2D(v.x / 100, v.y / 100) or nil end,
	GetVignettes = function() return { "Vignette-1", "Vignette-2" } end,
}
stub.moveTo(50, 50)
local before = { rare = count("rare"), slain = count("slain"), drop = count("drop") }
-- Each round: 20 new rares on nameplates, 20 kills, each corpse looted, and
-- the vignette list updating with every one. Every rare, kill and corpse is
-- new, so each is recorded rather than skipped as already seen.
burst("finds", function(round)
	for i = 1, 20 do
		local id = 1000 + round * 100 + i
		local rare = stub.creature(id, "Rare " .. id)
		unit("nameplate1", rare, "Rare " .. id, "rare", 12)
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.fire("VIGNETTES_UPDATED")
		local wolf = stub.creature(299, "Young Wolf")
		unit("target", wolf, "Young Wolf", "normal", 3)
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.partyKill(wolf)
		stub.unitDied(wolf)
		W.loot = { { name = "Tough Wolf Meat", item = 750, count = 2, src = { wolf, 2 } }, { name = "Ruined Pelt", item = 4865, src = { wolf, 1 } } }
		stub.fire("LOOT_OPENED", false, false)
		stub.fire("LOOT_CLOSED")
	end
end)
out.rares = count("rare") - before.rare
out.kills = count("slain") - before.slain
out.drops = count("drop") - before.drop"#,
	);
	assert_eq!(
		json!({ "rares": r["rares"], "kills": r["kills"], "drops": r["drops"] }),
		json!({ "rares": ROUNDS * 20 + 1, "kills": ROUNDS * 20, "drops": ROUNDS * 20 }),
		"every rare (and the vignette one), kill and loot window was recorded, so the recording is what was measured"
	);
	within(&r, &["finds"]);
}
