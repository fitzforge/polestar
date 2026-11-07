//! Polestar: Mob Markers (addon/Polestar_Mob_Markers): which quests' mobs it marks (the log's open quests,
//! only the current guide step's with "Only the current step's mobs" on, the whole log with no guide), that a
//! finished objective's mobs drop off, that hiding the guide hides the markers and legend, and that the
//! addon's old settings move into Polestar's once. Runs the real Core/Init.lua, Core/Compat.lua and the
//! addon by its TOC over a fake LibForeverData and quest log; what it marks is read from `/pmm`'s status line.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// Quest 100 needs Wolves (2 spawns) and Bear Pelts (Bears, 3 spawns) on map 1429; 200 a Spider (1 spawn) on
// 1430; 300 is complete, 400 has no mobs. No world bounds, so the zone's own spawns are drawn.
const FAKES: &str = r#"
LibForeverData = {
	quests = {
		[100] = { name = "Wolves and Bears", objectives = { { kind = "kill", target = 1 }, { kind = "item", target = 50 } } },
		[200] = { name = "Spiders", objectives = { { kind = "kill", target = 3 } } },
		[300] = { name = "Done already", objectives = { { kind = "kill", target = 3 } } },
		[400] = { name = "A letter", objectives = {} },
	},
	npcs = {
		[1] = { name = "Wolf", spawns = { [1429] = { 10, 10, 20, 20 } } },
		[2] = { name = "Bear", spawns = { [1429] = { 30, 30, 40, 40, 50, 50 } } },
		[3] = { name = "Spider", spawns = { [1430] = { 60, 60 } } },
	},
	items = { [50] = { name = "Bear Pelt", npcDrops = { 2 } } },
}
local DB = LibForeverData
function DB.Quest(id) return DB.quests[id] end
function DB.Name(_, id) local n = DB.npcs[id]; return n and n.name end
function DB.Get(kind, id) return (kind == "npc" and DB.npcs or DB.items)[id] end
function DB.Spawns() return {} end
function DB.Ids() return {} end

stub.mm = { log = { 100, 200, 300, 400 }, complete = { [300] = true }, objectives = {}, turnedIn = {} }
C_QuestLog = {
	GetNumQuestLogEntries = function() return #stub.mm.log end,
	GetInfo = function(i) local id = stub.mm.log[i]; return id and { questID = id, title = DB.quests[id].name } end,
	IsComplete = function(id) return stub.mm.complete[id] or false end,
	IsQuestFlaggedCompleted = function(id) return stub.mm.turnedIn[id] or false end,
	GetQuestObjectives = function(id) return stub.mm.objectives[id] end,
}
C_Map = C_Map or {}
C_Map.GetWorldPosFromMapPos = function() return nil end

-- /pmm's status line as { spawn marks, maps with marks, marks on the shown map, markers drawn }.
function stub.mm.status()
	local line
	local p = print
	print = function(s) line = s end
	SlashCmdList.POLESTARMOBMARKERS("")
	print = p
	local a, b, c, d = line:match("(%d+) spawn marks on (%d+) maps, (%d+) on this map, (%d+) markers drawn")
	return { tonumber(a), tonumber(b), tonumber(c), tonumber(d) }
end
"#;

// The world map open on 1429, its canvas big enough that no two spawns share a marker.
const OPEN_MAP: &str = r#"
stub.worldMapID = 1429
WorldMapFrame:GetCanvas():SetSize(1000, 700)
WorldMapFrame:Show()
stub.advance(0.3)
"#;

fn run(saved: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		before: FAKES.into(),
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua"]), Addon::name("Polestar_Mob_Markers")],
		saved: if saved.is_empty() { vec![] } else { vec![("Polestar_Mob_Markers".into(), saved.into())] },
		login: true,
		script: format!("{OPEN_MAP}\n{script}"),
		..Default::default()
	})
}

#[test]
fn with_no_guide_running_every_open_quest_in_the_log_with_mobs_is_marked() {
	let out = run("", "emit(stub.mm.status())");
	assert_eq!(out, vec![json!([6, 2, 5, 5])], "quests 100 and 200; not the complete 300 nor the mobless 400");
}

#[test]
fn only_the_current_steps_quests_are_marked_until_the_option_is_turned_off() {
	let out = run(
		"",
		r#"
		Polestar.Engine = { GetStepIndex = function() return 1 end, GetStepView = function() return { goals = {
			{ quest = 200, t = "kill" },
			{ quest = 100, t = "turnin" },
			{ quest = 100, t = "kill", status = "done" },
		} } end }
		emit(stub.mm.status())
		Polestar.Set("mobMarkers.stepOnly", false)
		emit(stub.mm.status())"#,
	);
	assert_eq!(out, vec![json!([1, 1, 0, 0]), json!([6, 2, 5, 5])], "the step works on 200 only; a hand-in or a done goal does not count");
}

#[test]
fn a_finished_objectives_mobs_drop_off_matched_by_name_not_by_the_logs_order() {
	let out = run(
		"",
		r#"
		local o = stub.mm.objectives
		-- The log lists the pelts first, the database the wolves: the wolves are the finished ones.
		o[100] = { { text = "Bear Pelt: 2/5", finished = false, numRequired = 5, numFulfilled = 2 },
			{ text = "Wolf slain: 8/8", finished = true, numRequired = 8, numFulfilled = 8 } }
		emit(stub.mm.status())
		o[100][1] = { text = "Bear Pelt: 5/5", finished = true, numRequired = 5, numFulfilled = 5 }
		emit(stub.mm.status())"#,
	);
	assert_eq!(out, vec![json!([4, 2, 3, 3]), json!([1, 1, 0, 0])], "the wolves go first, then the bears");
}

#[test]
fn hiding_the_guide_hides_the_markers_and_legend_and_showing_it_brings_them_back() {
	let out = run(
		"",
		r#"
		local function shown()
			local s = stub.mm.status()
			emit({ s[4], PolestarMobMarkersLegend:IsShown() })
		end
		shown()
		Polestar.Set("ui.shown", false)
		shown()
		Polestar.Set("ui.shown", true)
		shown()
		emit(#stub.underGameFrames)"#,
	);
	assert_eq!(out, vec![json!([5, true]), json!([0, false]), json!([5, true]), json!(0)], "and no frame is made under the game's own");
}

#[test]
fn the_old_settings_move_into_polestars_once_and_turned_in_quests_leave_the_hidden_list() {
	let out = run(
		"stub.mm.turnedIn[999] = true\nPolestarMobMarkersDB = { worldSize = 14, minimapButton = true, hidden = { [100] = true, [999] = true } }",
		r#"
		emit({ Polestar.Get("mobMarkers.worldSize"), PolestarMobMarkersDB.worldSize == nil, PolestarMobMarkersDB.minimapButton == nil })
		local h = PolestarMobMarkersCharDB.hidden
		emit({ h[100] == true, h[999] == nil })
		emit(stub.mm.status())"#,
	);
	assert_eq!(out[0], json!([14, true, true]));
	assert_eq!(out[1], json!([true, true]), "100 stays hidden; 999, turned in, is pruned");
	assert_eq!(out[2], json!([6, 2, 5, 0]), "quest 100 is hidden: its spawns count, none is drawn");
}
