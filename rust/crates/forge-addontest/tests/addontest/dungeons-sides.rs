//! Every dungeon's and raid's "Pick up the quests" and "Hand in the quests" guides (addon/Polestar/Dungeons/
//! Pickup.lua, Handin.lua) built on a real Codex for characters of both factions: no step may send a character
//! to a quest or an NPC of the other faction (#1026: Blackfathom Deeps sent Horde characters to Darnassus for
//! the Alliance's In Search of Thaelrid). The page's Horde / Alliance / All switch only changes the view; the
//! character's own faction decides.
//!
//! The Codex: $POLESTAR_CODEX_DIR (a Polestar_Codex folder), else addon/Polestar_Codex (local: `forge data
//! codex`); the quest database: $POLESTAR_QUESTDB_DIR, else addon/Polestar_QuestDB when built. The release
//! case is the Codex and quest database it ships (0.3.4: the 0.3.2 Codex and a quest database built from
//! data/forever with forever-db's corrections). A quest's side is the corrections' race mask (the facts we
//! settled), else the Codex's, else the quest database's; an NPC's is the Codex's. Skips when the Codex or
//! data/forever/map-frames.json is missing.

use forge_addontest::run::{addons_dir, join, root};
use forge_addontest::{emitted, lua_value, truthy, Addon, RunAddon};
use serde_json::{json, Value};
use std::path::PathBuf;

fn codex_dir() -> PathBuf {
	std::env::var_os("POLESTAR_CODEX_DIR").map_or_else(|| addons_dir().join("Polestar_Codex"), PathBuf::from)
}

fn questdb_dir() -> PathBuf {
	std::env::var_os("POLESTAR_QUESTDB_DIR").map_or_else(|| addons_dir().join("Polestar_QuestDB"), PathBuf::from)
}

fn frames() -> PathBuf {
	root().join("data").join("forever").join("map-frames.json")
}

/// A pack folder's TOC files as a Lua list of absolute paths, empty when it has no TOC.
fn toc_list(dir: &PathBuf, toc: &str) -> String {
	let Ok(text) = std::fs::read_to_string(dir.join(toc)) else { return "{}".into() };
	let files: Vec<String> = text.lines().map(str::trim).filter(|l| !l.is_empty() && !l.starts_with('#')).map(|f| serde_json::to_string(&join(dir, f).to_string_lossy()).unwrap()).collect();
	format!("{{ {} }}", files.join(", "))
}

/// The Codex loads when asked (C_AddOns.LoadAddOn), as in game; the quest database through stub_quests.
fn packs_lua() -> String {
	format!(
		"do
  local __files, __load = {}, C_AddOns.LoadAddOn
  function C_AddOns.LoadAddOn(name)
    if name ~= \"Polestar_Codex\" then return __load(name) end
    if not stub.addonsLoaded[name] then
      for _, f in ipairs(__files) do dofile(f) end
      stub.addonsLoaded[name] = true
    end
    return true, nil
  end
end
stub.quests.dbFiles = {}",
		toc_list(&codex_dir(), "Polestar_Codex.toc"),
		toc_list(&questdb_dir(), "Polestar_QuestDB.toc"),
	)
}

fn maps_lua() -> String {
	let all: Value = serde_json::from_str(&std::fs::read_to_string(frames()).unwrap()).unwrap();
	let mut out = Vec::new();
	for part in ["era", "forever"] {
		for (id, f) in all[part].as_object().into_iter().flatten() {
			out.push(format!("w.addMap({id}, {{ name = \"\", c = {}, left = {}, right = {}, top = {}, bottom = {} }})", f["c"], f["left"], f["right"], f["top"], f["bottom"]));
		}
	}
	out.join("\n")
}

/// A race mask's side: "A" or "H" when it names only that faction's races (Skyborne: 2^32 Alliance, 2^33
/// Horde), else none.
fn mask_side(mask: u64) -> Option<&'static str> {
	let (low, high) = (mask & 0xffff_ffff, mask >> 32);
	let (a, h) = (low & 77 != 0 || high & 1 != 0, low & 178 != 0 || high & 2 != 0);
	match (a, h) {
		(true, false) => Some("A"),
		(false, true) => Some("H"),
		_ => None,
	}
}

/// { [quest] = "A" | "H" } from forever-db/corrections/quests.json's race masks.
fn corrected_sides() -> Value {
	let c: Value = serde_json::from_str(&std::fs::read_to_string(root().join("forever-db/corrections/quests.json")).unwrap()).unwrap();
	let mut out = serde_json::Map::new();
	for (id, rec) in c.as_object().unwrap() {
		if let Some(side) = rec["set"]["races"].as_u64().and_then(mask_side) {
			out.insert(id.clone(), json!(side));
		}
	}
	Value::Object(out)
}

const SWEEP: &str = r#"
stub.login()
local D, C, Q = Polestar.Dungeons, Polestar.Codex, Polestar.QuestDB
if Q and Q.Load then Q.Load() end
local mine = @MINE@
local corrected = {}
for id, s in pairs(@CORRECTED@) do corrected[tonumber(id)] = s end
local function qside(id)
	if corrected[id] then return corrected[id] end
	local q = C.Quest(id)
	if q and q.faction then return q.faction end
	if q and type(q.races) == "number" and q.races > 0 then return "AH" end
	local r = Q and Q.IsLoaded() and Q.QuestRecord(id)
	local f = r and r[Q.F.FACTION]
	return f == 1 and "A" or f == 2 and "H" or nil
end
local function nside(id)
	local n = C.Npc(id)
	return n and n.faction or nil
end
local function other(s) return s ~= nil and s ~= "AH" and not s:find(mine, 1, true) end
local bad, sideless, n = {}, {}, { pickups = 0, handins = 0 }
local function check(key, kind, def)
	for i, s in ipairs(def and def.steps or {}) do
		for _, g in ipairs(s.goals) do
			if g.quest and other(qside(g.quest)) then
				bad[#bad + 1] = string.format("%s %s step %d: %s %d %s is %s's", key, kind, i, g.t, g.quest, tostring(g.title), qside(g.quest))
			end
			-- An NPC to talk to (accept, turn in, talk); a kill of the other side's NPC is no fault.
			if g.npc and g.t ~= "kill" and other(nside(g.npc)) then
				bad[#bad + 1] = string.format("%s %s step %d: %s %d at %s (npc %d) is %s's", key, kind, i, g.t, g.quest or 0, tostring(g.npcName), g.npc, nside(g.npc))
			end
			if g.t == "accept" and g.quest and not qside(g.quest) then
				sideless[#sideless + 1] = string.format("%s %d %s", key, g.quest, tostring(g.title))
			end
		end
	end
end
for _, d in ipairs(D.List()) do
	local def = D.PickupGuide(d.key)
	if def then n.pickups = n.pickups + 1 end
	check(d.key, "pick-up", def)
	-- After the run: every page quest that is not the other faction's in the log, finished.
	local put = {}
	for _, q in ipairs(D.Quests(d.key)) do
		if not other(qside(q.id)) and not stub.world.log[q.id] then
			stub.world.onQuest(q.id, {})
			put[#put + 1] = q.id
		end
	end
	local h = D.HandinGuide(d.key)
	if h then n.handins = n.handins + 1 end
	check(d.key, "hand-in", h)
	for _, id in ipairs(put) do stub.world.log[id] = nil end
end
table.sort(sideless)
emit({ bad = bad, sideless = sideless, pickups = n.pickups, handins = n.handins, questDB = Q ~= nil and Q.IsLoaded() })
"#;

/// (race, class, faction, map, x, y)
type Character = (&'static str, &'static str, &'static str, i32, i32, i32);

const HORDE: [Character; 4] = [("Orc", "WARRIOR", "Horde", 1454, 50, 70), ("Scourge", "WARLOCK", "Horde", 1458, 66, 44), ("Tauren", "DRUID", "Horde", 1456, 45, 55), ("Troll", "SHAMAN", "Horde", 1454, 50, 70)];
const ALLIANCE: [Character; 4] = [("Human", "PALADIN", "Alliance", 1453, 60, 70), ("Dwarf", "HUNTER", "Alliance", 1455, 30, 60), ("NightElf", "DRUID", "Alliance", 1457, 40, 50), ("Gnome", "MAGE", "Alliance", 1453, 60, 70)];

fn skip() -> bool {
	let s = !codex_dir().join("Polestar_Codex.toc").exists() || !frames().exists();
	if s {
		eprintln!("skipped: no Codex pack at {} (forge data codex, or POLESTAR_CODEX_DIR) or no data/forever/map-frames.json", codex_dir().display());
	}
	s
}

fn sweep(chars: &[Character]) {
	if skip() {
		return;
	}
	let corrected = corrected_sides();
	let mut bad: Vec<String> = Vec::new();
	for (race, cls, faction, map, x, y) in chars {
		let before = format!(
			"{}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = 60, {race:?}, {race:?}, {faction:?}\nw.class, w.className = {cls:?}, {cls:?}\nw.moveTo({map}, {x}, {y})",
			packs_lua(),
			maps_lua()
		);
		let out = emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_quests.lua"],
			before,
			addons: vec![Addon::name("Polestar")],
			login: false,
			script: SWEEP.replace("@MINE@", &lua_value(&json!(if *faction == "Alliance" { "A" } else { "H" }))).replace("@CORRECTED@", &lua_value(&corrected)),
			..Default::default()
		})
		.remove(0);
		eprintln!(
			"{race} {cls}: {} pick-up and {} hand-in guides, quest database {}; accepts with no side known: {}",
			out["pickups"],
			out["handins"],
			if truthy(&out["questDB"]) { "loaded" } else { "absent" },
			out["sideless"].as_array().map(|a| a.iter().map(|s| s.as_str().unwrap_or("").to_string()).collect::<Vec<_>>().join("; ")).unwrap_or_default()
		);
		assert!(out["pickups"].as_i64().unwrap_or(0) > 0, "{race} {cls}: no pick-up guide built at all");
		for b in out["bad"].as_array().into_iter().flatten() {
			bad.push(format!("{race} {cls}: {}", b.as_str().unwrap_or("")));
		}
	}
	assert!(bad.is_empty(), "steps of the other faction:\n{}", bad.join("\n"));
}

#[test]
fn horde_characters_dungeon_pick_up_and_hand_in_guides_hold_no_alliance_quest_or_npc() {
	sweep(&HORDE);
}

#[test]
fn alliance_characters_dungeon_pick_up_and_hand_in_guides_hold_no_horde_quest_or_npc() {
	sweep(&ALLIANCE);
}
