//! #2614: the game's internal placeholder names never reach the player. Forever's quest data names some objectives
//! by the invisible creature the server credits ("[DNT] Kill Credit", Alterac Valley's "PvP Graveyard Credit Marker"
//! and "Trigger Ichman"); No Soldier Left Behind read "Kill [DNT] Kill Credit 1/5". A guide goal the compiler found
//! on such a target (`logLine`) reads as its quest-log line in the game's words, else the compiler's name for it,
//! never "Kill <placeholder>"; a quest-log line the game itself words with a placeholder reads as a line with no name
//! yet; and Lookup's quest step never names one.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[7081] = "Alterac Valley Graveyards"
"#;

// Alterac Valley's `kill 13756 quest 7081.1 -- assault a graveyard` as 0.4.1's compiler writes it.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/av", pack = "test", title = "Alterac Valley", faction = "Alliance", minLevel = 51, maxLevel = 60, zone = 1429,
	steps = {
		{ title = "The battle", goals = {
			{ t = "kill", quest = 7081, title = "Alterac Valley Graveyards", target = "Graveyard Assaulted", logLine = true, count = 1, oi = 1,
				map = 1429, x = 51.8, y = 36, note = "assault a graveyard" },
		} },
	},
})
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		login: false,
		script: [TEST_PACK, TEST_SOURCE, GUIDE, "stub.login()", "E = Polestar.Engine", "E.SetGuide(\"test/av\"); stub.advance(0.25)", script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

fn line(v: &Value) -> Value {
	let g = &v["goals"][0];
	json!([g["text"], g["verb"], g["subject"], g["subjectKind"]])
}

#[test]
fn a_goal_on_a_credit_target_reads_as_its_quest_log_line_never_kill_the_placeholder() {
	let out = run(r#"
		local w = stub.world
		local out = { ahead = E.GetStepView(1) }
		w.accept(7081, { { text = "Friedhof angegriffen: 0/1", required = 1 } }); stub.advance(0.25)
		out.log = E.GetStepView(1)
		w.abandon(7081); stub.advance(0.25)
		w.accept(7081, { { text = "PvP Graveyard Credit Marker: 0/1", required = 1 } }); stub.advance(0.25)
		out.marker = E.GetStepView(1)
		emit(out)
	"#);
	assert_eq!(line(&out["ahead"]), json!(["Graveyard Assaulted", "", "Graveyard Assaulted", "text"]), "before the quest is in the log: {out}");
	assert_eq!(line(&out["log"]), json!(["Friedhof angegriffen", "", "Friedhof angegriffen", "text"]), "the log's line in the client's language");
	assert_eq!(line(&out["marker"]), json!(["Graveyard Assaulted", "", "Graveyard Assaulted", "text"]), "a log line the game words with a placeholder");
}

#[test]
fn a_quest_log_line_worded_with_a_placeholder_has_no_name_its_counts_stay() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"
			local C = Polestar.Compat
			C_QuestLog.GetQuestObjectives = function()
				return {
					{ text = "[DNT] Kill Credit: 2/5", type = "monster", finished = false, numFulfilled = 2, numRequired = 5 },
					{ text = "Credit: 0/1", type = "monster", finished = false, numFulfilled = 0, numRequired = 1 },
					{ text = "Farholde Scouts rescued: 1/5", type = "monster", finished = false, numFulfilled = 1, numRequired = 5 },
					{ text = "Trigger Ichman: 1/1", type = "monster", finished = true, numFulfilled = 1, numRequired = 1 },
				}
			end
			local out = {}
			for i, o in ipairs(C.GetQuestObjectives(94888)) do out[i] = { o.text, o.numFulfilled, o.numRequired } end
			emit({ lines = out, names = { C.Placeholder("PvP Tower Credit Marker"), C.Placeholder("Corrupted Moonwell Spell Focus (DND)"),
				C.Placeholder("<UNUSED>"), C.Placeholder("Credit Union"), C.Placeholder("Mulgore Trigger"), C.Placeholder("Graveyard Assaulted") } })
		"#
		.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["lines"], json!([["", 2, 5], ["", 0, 1], ["Farholde Scouts rescued: 1/5", 1, 5], ["", 1, 1]]));
	assert_eq!(out["names"], json!([true, true, true, false, false, false]));
}

// Lookup's quest step from the Codex: the credit marker's objective is read by its log line and named by its own
// words, with no NPC to target; a real kill is untouched. (The data build makes such objectives events; this is
// a Codex from before it.)
#[test]
fn lookups_quest_step_never_names_a_credit_target() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_lookup_runtime.lua"],
		before: "local w = stub.world\nw.addMap(9001, { name = \"Amber Vale\", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })\nw.moveTo(9001, 50, 50)\nw.level, w.race, w.raceName, w.faction = 55, \"Human\", \"Human\", \"Alliance\"".into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml"])],
		login: true,
		script: r#"
Polestar.RegisterMapFrames({ era = { [9001] = { c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 } } })
local C = Polestar.Codex
C.Register("meta", { version = 1 })
C.Register("npc", "\n8003\t\tWarden Ilsa\n8010\t\tPvP Tower Credit Marker\n8011\t\tKobold Sapper",
	"\n8003\t19;;;;;;;9001,e,500,500\n8010\t1;;;;;;;9001,e,600,600\n8011\t20;;;;;;;9001,e,400,400")
C.Register("quest", "\n7201\t\tTowers and Bunkers\n7202\t\tSappers",
	"\n7201\t55;51;;;;9001;8003;;;8003;;;;;;k8010,1,Tower Captured" ..
	"\n7202\t20;15;;;;9001;8003;;;8003;;;;;;k8011,5,Kobold Sapper slain")
local function work(id)
	local out = {}
	for _, g in ipairs(Polestar.Lookup.QuestStep(C.Quest(id), nil).goals) do
		if g.t ~= "accept" and g.t ~= "turnin" then out[#out + 1] = { t = g.t, target = g.target, npc = g.npc or false, logLine = g.logLine or false } end
	end
	return out
end
emit({ tower = work(7201), sappers = work(7202) })
"#
		.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["tower"], json!([{ "t": "kill", "target": "Tower Captured", "npc": false, "logLine": true }]), "{out}");
	assert_eq!(out["sappers"], json!([{ "t": "kill", "target": "Kobold Sapper", "npc": 8011, "logLine": false }]), "{out}");
}
