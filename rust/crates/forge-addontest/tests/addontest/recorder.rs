//! The in-game recorder (addon/Polestar_Recorder) against the quest/map/unit world of
//! tests/lua/stub_recorder.lua: schema 2 of docs/RECORDING.md, its chunks, the ack file, the caps, the
//! commands, and the quest records.

use forge_addontest::{emitted, text, truthy, RunAddon};
use serde_json::{json, Value};

const REC: &str = "Polestar_Recorder";

/// Lua helpers every Recorder test script starts with (also used by the other recorder*.rs files).
pub const PRELUDE: &str = r#"
-- Every record of every stored chunk, in seq order: { kind, dt, fields... }.
local function all()
	local seqs = {}
	for seq in pairs(PolestarRecorderDB.chunks) do seqs[#seqs + 1] = seq end
	table.sort(seqs)
	local out = {}
	for _, s in ipairs(seqs) do
		for _, r in ipairs(stub.records(PolestarRecorderDB.chunks[s])) do out[#out + 1] = r end
	end
	return out
end
-- The records of the given kinds ("kill loot", nil: all) as "kind|field|...", without dt.
local function recs(kinds)
	local want
	if kinds then
		want = {}
		for k in kinds:gmatch("%S+") do want[k] = true end
	end
	local out = {}
	for _, r in ipairs(all()) do
		if not want or want[r[1]] then
			local f = { r[1] }
			for i = 3, #r do f[#f + 1] = r[i] end
			out[#out + 1] = table.concat(f, "|")
		end
	end
	return out
end
-- Ends the session: the open chunk is written into chunks[seq].
local function logout() stub.fire("PLAYER_LOGOUT") end
local cmd = SlashCmdList.POLESTARREC
-- docs/RECORDING.md: fields after dt per kind (a position is three).
local WIDTH = {
	chunk = 3, session = 14, map = 8, level = 5, xp = 3, dropped = 1, mark = 4, pos = 5, zone = 5, ride = 4, taxi = 2,
	land = 5, death = 5, revive = 4, combat = 4, afk = 1, rest = 2, offer = 10, detail = 7, text = 4, accept = 11,
	objectives = 2, progress = 7, complete = 1, turnin = 10, abandon = 1, gossip = 7, cast = 7, escort = 5, kill = 10,
	loot = 8, unit = 8, rare = 7, treasure = 4, enter = 6, encounter = 4, trainer = 5, vendor = 5, flightmaster = 6,
	bind = 4, rep = 4, skill = 3, explore = 5, learn = 1, craft = 3, achieve = 1, step = 6,
}
-- Records whose kind is unknown or whose field count is wrong, as "kind:count".
local function malformed()
	local bad = {}
	for _, r in ipairs(all()) do
		if WIDTH[r[1]] ~= #r - 2 then bad[#bad + 1] = r[1] .. ":" .. (#r - 2) end
	end
	return bad
end
"#;

/// The Recorder's run: `before` ahead of the addon, `saved` as its SavedVariables (and Ack.lua's
/// global), then login when asked, then the script after PRELUDE.
pub fn run_with(script: &str, before: &str, login: bool, saved: Option<&str>) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_recorder.lua"],
		addons: vec![REC.into()],
		login,
		saved: saved.map(|s| (REC.to_string(), s.to_string())).into_iter().collect(),
		before: before.to_string(),
		script: format!("{PRELUDE}{script}"),
	})
	.remove(0)
}

pub fn run(script: &str) -> Value {
	run_with(script, "", true, None)
}

/// Strings of a JSON array.
pub fn strings(v: &Value) -> Vec<String> {
	v.as_array().unwrap_or_else(|| panic!("not an array: {v}")).iter().map(|s| s.as_str().unwrap().to_string()).collect()
}

const FIXED_IDS: &str = r#"
PolestarRecorderDB = { schema = 2, enabled = true, install = "k3j9x0q2m7ab", seq = 4, acked = 4, chunks = {}, maps = {} }
PolestarRecorderCharDB = { id = "k3j9x0q2m7" }"#;

#[test]
fn a_quest_with_kills_xp_loot_and_a_turn_in_is_exactly_this_chunk_text() {
	let out = run_with(
		r#"
		local KOBOLDS = { title = "Kobold Camp Cleanup", level = 2, objectives = { { text = "Kobold Vermin slain: %d/%d", type = "monster", numRequired = 3 } } }
		stub.acceptQuest(33, { title = "Wolves Across the Border", objectives = { { text = "Tough Wolf Meat: %d/%d", type = "item", numRequired = 8 } } })
		stub.world.xp = 40
		stub.world.rewards[7] = { 170, 170 }
		stub.moveTo(48.2, 41.9)
		local willem = stub.creature(823, "Deputy Willem")
		stub.world.questText = "Kill 3 Kobold Vermin."
		stub.world.questDetail = "Testchar, the kobolds trouble every Human here."
		stub.world.frame = { reward = { { 2575, 1 } }, choice = { { 2577, 1 }, { 2578, 5 } }, money = 75 }
		stub.offerQuest(7, willem, "Deputy Willem", "Kobold Camp Cleanup")
		stub.advance(3)
		stub.moveTo(48.4, 42.3) -- the accept belongs where the quest giver stood
		stub.acceptQuest(7, KOBOLDS)
		stub.setUnit("npc", nil)
		local last
		for i = 1, 3 do
			stub.moveTo(46 + i, 35)
			local g = stub.creature(6, "Kobold Vermin")
			last = g
			stub.setUnit("target", g, "Kobold Vermin")
			stub.fire("PLAYER_TARGET_CHANGED")
			stub.partyKill(g)
			stub.unitDied(g)
			stub.xpLine("Kobold Vermin", i == 2 and 50 or 25, i == 2 and 25 or nil)
			stub.setProgress(7, 1, i)
			stub.advance(10)
		end
		stub.world.loot = { { name = "Tough Wolf Meat", item = 750, count = 1, src = { last, 1 } } }
		stub.fire("LOOT_OPENED", false, false)
		stub.fire("LOOT_CLOSED")
		stub.moveTo(48.2, 41.9)
		stub.turnIn(7, willem, "Deputy Willem", 170, 35, 2)
		logout()
		emit({ text = PolestarRecorderDB.chunks[5], seq = PolestarRecorderDB.seq, bad = malformed() })"#,
		"",
		true,
		Some(FIXED_IDS),
	);
	let want = [
		"chunk|0|5|1791000000|k3j9x0q2m7",
		"session|0|k3j9x0q2m7|Human|WARRIOR|Alliance|2|1|enUS|70338|16001|3||0.1.0-test||",
		"map|0|1429|3|1415|0|1800|1100|-1666.7|-4100",
		"zone|0|1429|5000|5000|Elwynn Forest|Northshire Valley",
		"xp|0|0|400|",
		"accept|0|33|||1429|5000|5000|1||||",
		"objectives|0|33|item:8:Tough Wolf Meat",
		"offer|0|c|823|1429|4820|4190|7||33||",
		"detail|0|7|c|823|1429|4820|4190|",
		"text|0|7|Kobold Camp Cleanup|Kill 3 Kobold Vermin.|$N, the kobolds trouble every $R here.",
		"accept|30|7|c|823|1429|4820|4190|1|170|75|2575:1|2577:1;2578:5",
		"objectives|30|7|monster:3:Kobold Vermin slain",
		"unit|30|6|1|n|h|1429|4700|3500|t",
		"progress|31|7|1|1|3|1429|4700|3500",
		"kill|30|6|1|n|1429|4700|3500|25||0|7:1",
		"progress|133|7|1|2|3|1429|4800|3500",
		"kill|132|6|1|n|1429|4800|3500|50|25|0|7:1",
		"unit|234|6|1|n|h|1429|4900|3500|t",
		"progress|235|7|1|3|3|1429|4900|3500",
		"complete|235|7",
		"kill|234|6|1|n|1429|4900|3500|25||0|7:1",
		"loot|336|c|6|1429|4900|3500||750:1|33:1",
		"turnin|336|7|c|823|1429|4820|4190|1|170|35|2578",
	]
	.join("\n")
	.replace('|', "\t");
	assert_eq!(out["text"], json!(want));
	assert_eq!(out["seq"], 5);
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn at_login_the_chunks_the_uploader_acknowledged_for_this_install_are_deleted() {
	const SAVED: &str = r#"
local function c(seq) return ("chunk\t0\t%d\t1790990000\tk3j9x0q2m7\nmark\t5\t\t\t\tchunk %d"):format(seq, seq) end
PolestarRecorderDB = { schema = 2, enabled = true, install = "k3j9x0q2m7ab", seq = 4, acked = 1, chunks = { [2] = c(2), [3] = c(3), [4] = c(4) }, maps = {} }
PolestarRecorderCharDB = { id = "k3j9x0q2m7" }
PolestarRecorderAck = "#;
	const SCRIPT: &str = r#"
		local keys = {}
		for seq in pairs(PolestarRecorderDB.chunks) do keys[#keys + 1] = seq end
		table.sort(keys)
		emit({ chunks = keys, acked = PolestarRecorderDB.acked, seq = PolestarRecorderDB.seq })"#;
	let with = |ack: &str| run_with(SCRIPT, "", true, Some(&format!("{SAVED}{ack}")));
	// The release's Ack.lua: nothing acknowledged. The new session is chunk 5.
	assert_eq!(with("nil"), json!({ "chunks": [2, 3, 4, 5], "acked": 1, "seq": 5 }));
	assert_eq!(with(r#"{ ["k3j9x0q2m7ab"] = 3 }"#), json!({ "chunks": [4, 5], "acked": 3, "seq": 5 }));
	// Only another WoW account's install: its ack is not for these chunks.
	assert_eq!(with(r#"{ ["zzzzzzzzzzzz"] = 4 }"#), json!({ "chunks": [2, 3, 4, 5], "acked": 1, "seq": 5 }));
	// One file for several accounts sharing the AddOns folder.
	assert_eq!(with(r#"{ ["k3j9x0q2m7ab"] = 2, ["zzzzzzzzzzzz"] = 9 }"#), json!({ "chunks": [3, 4, 5], "acked": 2, "seq": 5 }));
	// The old { install, upto } form is not read.
	assert_eq!(with(r#"{ install = "k3j9x0q2m7ab", upto = 3 }"#), json!({ "chunks": [2, 3, 4, 5], "acked": 1, "seq": 5 }));
}

#[test]
fn schema_1_recordings_are_removed_at_load_said_once_in_chat_the_opt_in_and_the_window_settings_stay() {
	let out = run_with(
		r#"
		local db = PolestarRecorderDB
		local keys = {}
		for k in pairs(db) do keys[#keys + 1] = k end
		table.sort(keys)
		stub.fire("PLAYER_LOGIN")
		local said = 0
		for _, m in ipairs(stub.messages) do if m:find("schema 1", 1, true) then said = said + 1 end end
		logout()
		emit({ keys = keys, schema = db.schema, enabled = db.enabled, panel = db.panel, spots = db.spots, said = said,
			old = table.concat(recs(), "\n"):find("Testchar", 1, true) ~= nil, chunks = #recs("chunk") })"#,
		"",
		true,
		Some(
			r#"PolestarRecorderDB = { schema = 1, enabled = true, current = "1790000000-Testchar",
			sessions = { ["1790000000-Testchar"] = { char = { name = "Testchar", realm = "Test Realm" }, events = { { e = "mark", text = "old" } } } },
			maps = { [1429] = { name = "Elwynn Forest" } }, fp = {}, panel = { "CENTER", "CENTER", 10, 20 }, spots = { [3] = 1790000000 } }"#,
		),
	);
	assert_eq!(out["keys"], json!(["acked", "chunks", "enabled", "install", "maps", "panel", "schema", "seq", "spots"]));
	assert_eq!(out["schema"], 2);
	assert_eq!(out["enabled"], true);
	assert_eq!(out["panel"], json!(["CENTER", "CENTER", 10, 20]));
	assert_eq!(out["said"], 1);
	assert_eq!(out["old"], false, "nothing of the old sessions (names) is left");
	assert_eq!(out["chunks"], 1);
}

#[test]
fn a_nil_polestarrecorderdb_cold_start_bug_neither_errors_nor_loses_the_open_chunk() {
	let out = run_with(
		r#"
		cmd("on") -- a lost table also lost the opt-in
		cmd("mark before")
		local install = PolestarRecorderDB.install
		PolestarRecorderDB = nil -- the table vanishes under the running session
		cmd("mark after")
		logout()
		emit({ type = type(PolestarRecorderDB), schema = PolestarRecorderDB.schema, marks = recs("mark"), seq = PolestarRecorderDB.seq,
			sameInstall = PolestarRecorderDB.install == install, installLength = #install, charId = #PolestarRecorderCharDB.id })"#,
		"",
		true,
		Some("PolestarRecorderDB = nil; PolestarRecorderCharDB = nil"),
	);
	assert_eq!(out, json!({ "type": "table", "schema": 2, "marks": ["mark|1429|5000|5000|before", "mark|1429|5000|5000|after"], "seq": 1, "sameInstall": true, "installLength": 12, "charId": 10 }));

	let garbage = run_with(r#"cmd("on"); cmd("mark x"); logout(); emit({ marks = recs("mark"), bad = malformed() })"#, "", true, Some(r#"PolestarRecorderDB = "corrupt"; PolestarRecorderCharDB = 5"#));
	assert_eq!(garbage, json!({ "marks": ["mark|1429|5000|5000|x"], "bad": {} }));
}

// Recording is opt-in: a fresh install writes nothing until the player turns it on; on opens a chunk at once
// in play, off closes it and nothing is written until it is on again (a new chunk).
#[test]
fn recording_is_off_until_the_player_turns_it_on_no_chunks_on_opens_one_off_closes_it() {
	let out = run_with(
		r#"
		local function n() local c = 0 for _ in pairs(PolestarRecorderDB.chunks) do c = c + 1 end return c end
		stub.fire("PLAYER_LEVEL_UP", 2)
		cmd("mark ignored")
		local off = { chunks = n(), enabled = PolestarRecorderDB.enabled, seq = PolestarRecorderDB.seq }
		cmd("on")
		cmd("mark kept")
		local on = { chunks = n(), seq = PolestarRecorderDB.seq }
		cmd("off")
		cmd("mark dropped")
		cmd("on")
		logout()
		emit({ off = off, on = on, marks = recs("mark"), enabled = PolestarRecorderDB.enabled, seqs = PolestarRecorderDB.seq })"#,
		"",
		true,
		Some("PolestarRecorderDB = nil"),
	);
	assert_eq!(out["off"], json!({ "chunks": 0, "enabled": false, "seq": 0 }));
	assert_eq!(out["on"], json!({ "chunks": 1, "seq": 1 }));
	assert_eq!(out["marks"], json!(["mark|1429|5000|5000|kept"]), "nothing is written while off");
	assert_eq!(out["enabled"], true);
	assert_eq!(out["seqs"], 2, "on again opens the next chunk");
}

#[test]
fn a_chunk_closes_after_5_minutes_or_16_kib_and_is_refreshed_every_60_s_out_of_combat() {
	let out = run(r#"
		local db = PolestarRecorderDB
		local function stored(seq) return db.chunks[seq] and #stub.records(db.chunks[seq]) or 0 end
		cmd("mark one")
		local first = db.seq
		local atOpen = stored(first) -- chunk and session, written as the chunk opens
		stub.advance(30)
		cmd("mark two")
		local before = stored(first)
		stub.advance(31)
		local refreshed = stored(first)
		stub.world.combat = true
		cmd("mark in combat")
		stub.advance(65)
		local inCombat = stored(first)
		stub.world.combat = false
		stub.advance(5)
		local after = stored(first)
		stub.advance(300 - stub.now + 1)
		local second = db.seq
		local head = stub.records(db.chunks[second])
		for i = 1, 300 do cmd("mark " .. ("x"):rep(60) .. i) end
		local third = db.seq
		local size = #db.chunks[second]
		logout()
		emit({ first = first, atOpen = atOpen, before = before, refreshed = refreshed, inCombat = inCombat, after = after,
			second = second, head = { head[1][1], head[1][2], head[1][3], head[2][1] }, third = third, size = size, bad = malformed() })"#);
	assert_eq!(out["atOpen"], 2);
	assert_eq!(out["before"], 2, "not written again before 60 s");
	assert_eq!(out["refreshed"], 7, "chunk, session, map, zone, xp and both marks");
	assert_eq!(out["inCombat"], 7, "no refresh in combat");
	assert_eq!(out["after"], 8);
	assert_eq!(out["second"], 2, "the 5-minute close opened chunk 2");
	assert_eq!(out["head"], json!(["chunk", "0", "2", "session"]), "every chunk starts with chunk then session");
	assert_eq!(out["third"], 3, "16 KiB closed chunk 2");
	let size = out["size"].as_u64().unwrap();
	assert!((16 * 1024..16 * 1024 + 200).contains(&size), "chunk 2 closed at the first record past 16 KiB: {size}");
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn past_4_mib_the_oldest_chunks_are_dropped_and_a_dropped_record_counts_them() {
	let out = run_with(
		r#"
		local keys = {}
		for seq in pairs(PolestarRecorderDB.chunks) do keys[#keys + 1] = seq end
		table.sort(keys)
		local dropped = {}
		for _, r in ipairs(stub.records(PolestarRecorderDB.chunks[6])) do if r[1] == "dropped" then dropped[#dropped + 1] = r[3] end end
		stub.messages = {}
		cmd("status")
		emit({ chunks = keys, dropped = dropped, status = stub.messages })"#,
		"",
		true,
		Some(
			r#"
local big = ("x"):rep(1024 * 1024 - 40)
local chunks = {}
for seq = 1, 5 do chunks[seq] = ("chunk\t0\t%d\t1790990000\tk3j9x0q2m7\nmark\t5\t\t\t\t"):format(seq) .. big end
PolestarRecorderDB = { schema = 2, enabled = true, install = "k3j9x0q2m7ab", seq = 5, acked = 0, chunks = chunks, maps = {} }
PolestarRecorderCharDB = { id = "k3j9x0q2m7" }"#,
		),
	);
	assert_eq!(out["chunks"], json!([3, 4, 5, 6]));
	assert_eq!(out["dropped"], json!(["2"]));
	let status: Vec<String> = strings(&out["status"]);
	assert!(status[1].ends_with("4 chunks waiting for the uploader (about 3072 KiB of 4096 KiB)"), "{status:?}");
	assert!(status[2].ends_with("the uploader has not confirmed a chunk yet (newest: 6)"), "{status:?}");
	assert!(status[3].ends_with("install id: k3j9x0q2m7ab"), "{status:?}");
}

#[test]
fn psrec_clear_needs_confirmation_deletes_every_chunk_and_map_and_the_seq_keeps_counting() {
	let out = run(r#"
		cmd("mark kept")
		local before = PolestarRecorderDB.seq
		cmd("clear")
		local armed = PolestarRecorderDB.chunks[before] ~= nil
		stub.advance(31)
		cmd("clear confirm") -- too late: re-arms instead
		local still = PolestarRecorderDB.chunks[before] ~= nil
		cmd("clear confirm")
		local n = 0
		for _ in pairs(PolestarRecorderDB.chunks) do n = n + 1 end
		cmd("mark after")
		logout()
		emit({ armed = armed, still = still, after = n, seq = PolestarRecorderDB.seq, marks = recs("mark"), maps = #recs("map") })"#);
	assert_eq!(out, json!({ "armed": true, "still": true, "after": 1, "seq": 2, "marks": ["mark|1429|5000|5000|after"], "maps": 1 }));
}

#[test]
fn psrec_speaks_the_client_s_language_through_the_recorder_s_own_locale_file_english_where_it_has_no_translation() {
	let before = r#"function GetLocale() return "ruRU" end
do
	local load = loadfile
	function loadfile(file)
		if file:match("Polestar_Recorder[/\\]Locales[/\\]ruRU%.lua$") then
			return function(_, ns) ns.L["recording %s"] = "запись: %s"; ns.L["on"] = "вкл" end
		end
		return load(file)
	end
end"#;
	let lines = run_with(
		r#"
stub.messages = {}
cmd("on")
cmd("mark")
emit(stub.messages)"#,
		before,
		true,
		None,
	);
	assert!(truthy(&lines[0]) && text(&lines[0]).contains("запись: |cff4fd18fвкл|r"), "{}", lines[0]);
	assert!(truthy(&lines[1]) && text(&lines[1]).contains("usage: /psrec mark <text>"), "{}", lines[1]);
}

// Polestar's quest database: NPC 197 starts 18, 33, 54, 60 and 70; object 1593 starts 61.
const POLESTAR_QUESTDB: &str = r#"
Polestar = { QuestDB = {
	IsLoaded = function() return true end,
	QuestIds = function() return { 18, 33, 54, 60, 61, 70 } end,
	QuestRecord = function(q) return ({ [18] = { [7] = 197 }, [33] = { [7] = { 197, 240 } }, [54] = { [7] = 197 }, [60] = { [7] = 197 }, [61] = { [7] = -1593 }, [70] = { [7] = 197 } })[q] end,
	Each = function(v)
		if type(v) == "table" then return ipairs(v) end
		local done = false
		return function() if done or v == nil then return nil end done = true return 1, v end
	end,
	F = { START = 7 },
} }"#;

#[test]
fn offers_list_what_is_shown_in_the_log_and_among_what_polestar_says_the_npc_starts_done_and_not_offered() {
	let out = run_with(
		r#"
		stub.world.completed[54] = true
		stub.acceptQuest(60, { title = "Kobold Candles", objectives = {} })
		stub.advance(1) -- the index builds a slice per step
		stub.moveTo(10, 10)
		stub.world.gossip = { available = { 33, 18 }, active = { 7 }, options = { { gossipOptionID = 4101, name = "Tell me about Testchar's task." }, { gossipOptionID = 4102, name = "Goodbye." } } }
		local mcbride = stub.creature(197, "Marshal McBride")
		stub.setUnit("npc", mcbride, "Marshal McBride")
		stub.fire("GOSSIP_SHOW")
		C_GossipInfo.SelectOption(4101)
		C_GossipInfo.SelectOptionByIndex(1)
		-- the quest detail right after the same NPC's gossip is no new offer
		stub.offerQuest(33, mcbride, "Marshal McBride", "Wolves Across the Border")
		-- an NPC who offers nothing still says what it would start
		stub.world.gossip = { available = {}, active = {}, options = {} }
		stub.fire("GOSSIP_SHOW")
		-- a timed quest: escort on while its timer runs, off once it is done
		stub.world.timers[90] = 600
		stub.acceptQuest(90, { title = "Escort", objectives = { { text = "Escort complete", type = "event", numRequired = 1 } } })
		stub.advance(1)
		stub.setProgress(90, 1, 1)
		stub.advance(1)
		stub.turnIn(90, mcbride, "Marshal McBride", 300, 0)
		stub.abandon(60)
		logout()
		emit({ recs = recs("offer gossip detail escort abandon"), bad = malformed(), option = stub.world.selectedOption })"#,
		POLESTAR_QUESTDB,
		true,
		None,
	);
	assert_eq!(
		out["recs"],
		json!([
			"offer|c|197|1429|1000|1000|33;18|7|60|54|70",
			"gossip|c|197|1429|1000|1000|4101|Tell me about $N's task.",
			"gossip|c|197|1429|1000|1000|4102|Goodbye.",
			"detail|33|c|197|1429|1000|1000|",
			"offer|c|197|1429|1000|1000|||60|54|18;33;70",
			"escort|90|1|1429|1000|1000",
			"escort|90|0|1429|1000|1000",
			"abandon|60",
		])
	);
	assert_eq!(out["option"], 4101, "the client's own SelectOption still ran (hooked, not replaced)");
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn a_quest_s_text_is_recorded_once_per_character_with_the_player_s_name_race_and_class_put_back_as_tokens() {
	let first = run(r#"
		stub.world.questText = "Slay the beasts, Testchar."
		stub.world.questDetail = "A Human warrior like you, Testchar, is what we need. Warriors are rare."
		stub.offerQuest(7, (stub.creature(823, "Deputy Willem")), "Deputy Willem", "Kobold Camp Cleanup")
		stub.fire("QUEST_CLOSED")
		stub.offerQuest(7, (stub.creature(823, "Deputy Willem")), "Deputy Willem", "Kobold Camp Cleanup")
		logout()
		emit({ text = recs("text"), seen = PolestarRecorderCharDB.textSeen[7], char = stub.serialize(PolestarRecorderCharDB) })"#);
	assert_eq!(first["text"], json!(["text|7|Kobold Camp Cleanup|Slay the beasts, $N.|A $R $c like you, $N, is what we need. $Cs are rare."]));
	assert_eq!(first["seen"], true);
	let again = run_with(
		r#"
		stub.offerQuest(7, (stub.creature(823, "Deputy Willem")), "Deputy Willem", "Kobold Camp Cleanup")
		logout()
		emit(#recs("text"))"#,
		"",
		true,
		Some(&format!("PolestarRecorderDB = {{ enabled = true, install = \"testinstall1\" }}; PolestarRecorderCharDB = {}", first["char"].as_str().unwrap())),
	);
	assert_eq!(again, 0, "textSeen is per character, across sessions");
}
