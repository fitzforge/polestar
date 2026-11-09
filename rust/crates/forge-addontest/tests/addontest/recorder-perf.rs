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
//! The same budgets hold in one of Forever's new zones, where explorer mode works by itself and the Recorder
//! records the most (addon/Polestar_Recorder/Explore.lua).
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

-- Records of a kind in every stored chunk; the open chunk is closed first
-- (a logout), so this is for the end of a run.
local function count(kind)
	stub.fire("PLAYER_LOGOUT")
	local n = 0
	for _, text in pairs(PolestarRecorderDB.chunks) do
		for _, r in ipairs(stub.records(text)) do if r[1] == kind then n = n + 1 end end
	end
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

/// Recording on and the player in Zephras Isle (2521, its real size), where explorer mode works by itself:
/// the explorer variants run the same scripts there.
const EXPLORE: &str = r#"
stub.world.maps[2521] = { name = "Zephras Isle", mapType = 3, parentMapID = 947, c = 2991, top = 4956.25, left = 4231.25, bottom = 1247.917, right = -1331.25, w = 5562.5, h = 3708.33 }
stub.moveTo(50, 50, 2521)
"#;

const WALK_AND_QUESTS: &str = r#"
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

-- Walking: one frame at a time for 10 s, far enough that breadcrumbs are
-- written (the work being measured). Each round's slowest frame; the median
-- of those is held to the budget.
local slowest, refs = {}, {}
stub.world.moving = true
for r = 1, ROUNDS do
	refs[r] = reference()
	collectgarbage("collect")
	slowest[r] = 0
	for i = 1, 200 do
		stub.moveTo(20 + i * 0.2, 30 + i * 0.1)
		local t = P.total()
		stub.advance(0.05)
		slowest[r] = math.max(slowest[r], P.total() - t)
	end
end
stub.world.moving = false
hold("tick", slowest, refs)
out.progress = count("progress")
out.crumbs = count("pos")
out.unitx = count("unitx")"#;

fn walk_and_quests(r: &Value) {
	assert_eq!(r["progress"], ROUNDS * 20, "every round recorded progress on each of the 20 quests, so the quest scans were measured");
	assert!(num(&r["crumbs"]) >= f64::from(ROUNDS), "the walking wrote too few breadcrumbs for every round to have measured one: {}", r["crumbs"]);
	within(r, &["quests", "tick"]);
}

#[test]
fn recording_stays_within_the_walking_frame_and_event_burst_budgets() {
	walk_and_quests(&measure(WALK_AND_QUESTS));
}

const FINDS: &str = r#"
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
stub.advance(4) -- the last kills wait for their XP line and objective
out.rares = count("rare")
out.kills = count("kill")
out.drops = count("loot")
out.unitx = count("unitx")"#;

fn finds(r: &Value) {
	assert_eq!(
		json!({ "rares": r["rares"], "kills": r["kills"], "drops": r["drops"] }),
		json!({ "rares": ROUNDS * 20 + 1, "kills": ROUNDS * 20, "drops": ROUNDS * 20 }),
		"every rare (and the vignette one), kill and loot window was recorded, so the recording is what was measured"
	);
	within(r, &["finds"]);
}

#[test]
fn recording_rares_kills_and_loot_windows_stays_within_the_event_burst_budget() {
	finds(&measure(FINDS));
}

#[test]
fn explorer_mode_in_a_new_zone_stays_within_the_same_budgets() {
	let r = measure(&format!("{EXPLORE}{WALK_AND_QUESTS}"));
	assert!(num(&r["unitx"]) >= 1.0, "explorer mode recorded the spawns seen: {r}");
	walk_and_quests(&r);
	let r = measure(&format!("{EXPLORE}{FINDS}"));
	assert!(num(&r["unitx"]) >= f64::from(ROUNDS * 40), "each rare and wolf seen is a spawn record: {r}");
	finds(&r);
}

/// One simulated hour of questing (walking, mobs on plates, kills with XP lines, loot, quests every 10
/// minutes, a vendor and a trainer twice, one flight), on the player's map: what it stores, so the 4 MiB cap
/// holds days of play, and the Lua memory the addon then holds (KiB, after a full collection).
const HOUR: &str = r#"
		local W = stub.world
		local YD = 100 / C_Map.GetMapWorldSize(W.map)
		local x, y = 30, 50
		W.speed = 7
		local q = 100
		local function walk(seconds)
			W.moving = true
			for _ = 1, seconds do
				x = x + 7 * YD
				if x > 80 then x = 20; y = y + 2 end
				stub.moveTo(x, y)
				stub.advance(1)
			end
			W.moving = false
			stub.fire("PLAYER_STOPPED_MOVING")
		end
		local mobs = { { 6, "Kobold Vermin" }, { 299, "Young Wolf" }, { 40, "Kobold Miner" }, { 113, "Stonetusk Boar" }, { 257, "Kobold Worker" } }
		stub.acceptQuest(q, { title = "Quest " .. q, objectives = { { text = "Kobold Vermin slain: %d/%d", type = "monster", numRequired = 100 }, { text = "Gold Dust: %d/%d", type = "item", numRequired = 100 } } })
		local kills, dust = 0, 0
		for minute = 1, 60 do
			walk(30)
			for i = 1, PLATES or 5 do -- creatures seen on nameplates this minute (PLATES: a busier zone)
				local m = mobs[(minute + i) % #mobs + 1]
				local g = stub.creature(m[1], m[2])
				stub.setUnit("nameplate" .. i, g, m[2])
				W.units["nameplate" .. i].lvl = 3 + (i % 3)
				stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate" .. i)
			end
			for k = 1, 2 do
				local g = stub.creature(6, "Kobold Vermin")
				stub.setUnit("target", g, "Kobold Vermin")
				W.units.target.lvl = 4
				stub.fire("PLAYER_TARGET_CHANGED")
				W.combat = true
				stub.fire("PLAYER_REGEN_DISABLED")
				stub.advance(8)
				stub.partyKill(g)
				stub.xpLine("Kobold Vermin", 45, k == 1 and 22 or nil)
				W.xp = W.xp + 45
				kills = kills + 1
				stub.setProgress(q, 1, kills)
				W.combat = false
				stub.fire("PLAYER_REGEN_ENABLED")
				W.loot = { { name = "Gold Dust", item = 773, count = 1, src = { g, 1 } }, { name = "Linen Cloth", item = 2589, count = 1, src = { g, 1 } } }
				stub.fire("LOOT_OPENED", false, false)
				stub.fire("LOOT_CLOSED")
				dust = dust + 1
				stub.setProgress(q, 2, dust)
				stub.advance(4)
			end
			if minute % 10 == 0 then
				local giver = stub.creature(800 + minute, "Giver")
				q = q + 1
				W.gossip = { available = { q }, active = { q - 1 }, options = {} }
				stub.setUnit("npc", giver, "Giver")
				stub.fire("GOSSIP_SHOW")
				W.questText = "Bring me what I need, $N."
				W.questDetail = ("Long quest text %d. "):rep(20):format(minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute, minute)
				stub.offerQuest(q, giver, "Giver", "Quest " .. q)
				stub.acceptQuest(q, { title = "Quest " .. q, objectives = { { text = "Kobold Vermin slain: %d/%d", type = "monster", numRequired = 100 }, { text = "Gold Dust: %d/%d", type = "item", numRequired = 100 } } })
				stub.turnIn(q - 1, giver, "Giver", 450, 120)
				kills, dust = 0, 0
			end
			if minute == 15 or minute == 45 then
				function GetMerchantNumItems() return 20 end
				function GetMerchantItemID(i) return 2500 + i end
				function GetMerchantItemInfo(i) return "Item", 1, 25 * i, 1, -1 end
				stub.setUnit("npc", (stub.creature(1200 + minute, "Vendor")), "Vendor")
				stub.fire("MERCHANT_SHOW")
				function GetNumTrainerServices() return 12 end
				function GetTrainerServiceInfo(i) return "Spell " .. i, i % 3 == 0 and "used" or "available", 1, 2 * i end
				function GetTrainerServiceCost(i) return 100 * i end
				C_TooltipInfo = { GetTrainerService = function(i) return { id = 6000 + i } end }
				stub.setUnit("npc", (stub.creature(1300 + minute, "Trainer")), "Trainer")
				stub.fire("TRAINER_SHOW")
			end
			if minute == 30 then
				W.taxi = { { nodeID = 2, name = "Stormwind", state = 0, slotIndex = 1 }, { nodeID = 4, name = "Sentinel Hill", state = 1, slotIndex = 2 } }
				stub.setUnit("npc", (stub.creature(352, "Flight Master")), "Flight Master")
				stub.fire("TAXIMAP_OPENED", 0)
				TakeTaxiNode(2)
				W.onTaxi = true
				stub.fire("PLAYER_CONTROL_LOST")
				stub.advance(90)
				W.onTaxi = false
				stub.fire("PLAYER_CONTROL_GAINED")
			end
			stub.advance(6)
		end
		logout()
		local bytes, kinds, maxBytes, maxRecords = 0, {}, 0, 0
		for _, text in pairs(PolestarRecorderDB.chunks) do
			bytes = bytes + #text
			local recs = stub.records(text)
			for _, r in ipairs(recs) do kinds[r[1]] = (kinds[r[1]] or 0) + 1 end
			maxBytes, maxRecords = math.max(maxBytes, #text), math.max(maxRecords, #recs)
		end
		collectgarbage("collect")
		emit({ bytes = bytes, seconds = stub.now, kinds = kinds, maxBytes = maxBytes, maxRecords = maxRecords, mem = collectgarbage("count"), bad = malformed() })"#;

/// The hour after `setup`: its records, checked well formed and holding every kind questing writes.
fn hour(setup: &str) -> Value {
	let out = crate::recorder::run(&format!("{setup}{HOUR}"));
	println!(
		"recorded {} bytes in {} simulated seconds: {:.0} bytes per hour; largest chunk {} bytes, {} records; Lua memory {:.0} KiB; records {}",
		out["bytes"],
		out["seconds"],
		per_hour(&out),
		out["maxBytes"],
		out["maxRecords"],
		num(&out["mem"]),
		out["kinds"]
	);
	assert_eq!(out["bad"], json!({}));
	for kind in ["pos", "unit", "kill", "loot", "progress", "accept", "turnin", "offer", "text", "vendor", "trainer", "taxi", "land", "combat", "xp"] {
		assert!(out["kinds"][kind].as_u64().unwrap_or(0) > 0, "no {kind} record in the hour: {}", out["kinds"]);
	}
	out
}

fn per_hour(out: &Value) -> f64 {
	num(&out["bytes"]) * 3600.0 / num(&out["seconds"])
}

#[test]
fn an_hour_of_questing_stores_under_80_kib_in_well_formed_records() {
	let out = hour("");
	assert!(per_hour(&out) < 80.0 * 1024.0, "{:.0} bytes per hour", per_hour(&out));
	for kind in ["unitx", "poi", "imap", "engage", "where", "open"] {
		assert!(out["kinds"].get(kind).is_none(), "{kind} without explorer mode: {}", out["kinds"]);
	}
}

/// A busy hour in Zephras Isle, where explorer mode works by itself (25 creatures on nameplates a minute
/// instead of 5, the quest log's map points readable): at most 160 KiB an hour, so the 4 MiB store holds over
/// 25 hours of it and a day of it stays far under the server's 20 MiB per contributor; every chunk within
/// the Recorder's 16 KiB (plus one record) and the server's 64 KiB and 4,096 records; and what explorer mode
/// remembers for a session (sightings, spawns, map points, NPCs) under 256 KiB of Lua memory beyond the
/// bigger chunks it stores.
#[test]
fn a_busy_hour_in_a_new_zone_stores_under_160_kib_in_chunks_the_server_takes_and_its_memory_stays_small() {
	let normal = hour("");
	let setup = format!(
		"{EXPLORE}{}",
		r#"
		PLATES = 25
		C_QuestLog.GetQuestsOnMap = function(map)
			local out = {}
			for _, q in ipairs(stub.world.log) do out[#out + 1] = { questID = q, mapID = map, x = 0.4, y = 0.6 } end
			return out
		end
		"#
	);
	let out = hour(&setup);
	for kind in ["unitx", "poi", "where"] {
		assert!(out["kinds"][kind].as_u64().unwrap_or(0) > 0, "no {kind} record in the explorer hour: {}", out["kinds"]);
	}
	assert!(per_hour(&out) < 160.0 * 1024.0, "{:.0} bytes per hour", per_hour(&out));
	assert!(per_hour(&out) * 24.0 < 20.0 * 1024.0 * 1024.0);
	assert!(num(&out["maxBytes"]) < 16.0 * 1024.0 + 256.0, "largest chunk {}", out["maxBytes"]);
	assert!(num(&out["maxRecords"]) < 4096.0, "most records in a chunk {}", out["maxRecords"]);
	let held = num(&out["mem"]) - num(&normal["mem"]) - (num(&out["bytes"]) - num(&normal["bytes"])) / 1024.0;
	assert!(held < 256.0, "explorer mode holds {held:.0} KiB more than the hour without it, beyond its chunks");
}
