//! Polestar Studio (addon/Polestar_Studio) on the stub world, beside the whole of Polestar: a draft built
//! through Studio's model plays in Polestar as it is built, a goal of the draft is evaluated by the engine
//! (a boss's death), and the guide goes export -> decode -> save -> open -> fork. The Studio window opens on
//! New / Open on the first run (until the author picks a handle), and every tab of its dock builds.

use forge_addontest::{emitted, Addon, RunAddon};
use forge_guide::importstring::decode_import;
use forge_addontest::dsl::plain;
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
-- No target and no mouseover: the Targets tab shows its empty card.
function UnitExists(unit) return unit == "player" end
"#;

// A draft of two steps: VanCleef's death, then a walk; Studio's model only (S.Model), as its tools add goals.
const BUILD: &str = r#"
S = PolestarStudio
P = Polestar
E = P.Engine
function flush() stub.advance(0.6) end
S.SetHandle("yendi")
local doc = S.Model.New({ title = "Cozy Bag", faction = "Alliance", minLevel = 1, maxLevel = 10, zone = 1429 })
S.Model.SetStep(1, "title", "Kill him")
S.Model.AddGoal(1, { verb = "boss", args = { "639" }, mods = {} }, { t = "boss", npc = 639, npcName = "Edwin VanCleef" })
local i = S.Model.AddStep("After")
S.Model.AddGoal(i, { verb = "goto", args = { "30,30" }, mods = { { "frame", "live" } } }, { t = "goto", map = 1429, x = 30, y = 30 })
S.Sync.Now(); flush()
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Studio")],
		login: true,
		script: format!("stub.fire(\"QUEST_LOG_UPDATE\")\n{script}"),
		..Default::default()
	})
}

#[test]
fn a_draft_plays_in_polestar_as_it_is_built_and_its_boss_goal_is_evaluated() {
	let out = run(&format!(
		r#"{BUILD}
		local d = S.Model.Current()
		emit({{ id = d.header.id, guide = E.GetGuide() and E.GetGuide().id, live = E.GetLiveStep(), synced = S.Sync.State().ok }})
		stub.world.combatLog("UNIT_DIED", "Creature-0-1-2-3-639-0000ABCD"); flush()
		emit({{ live = E.GetLiveStep() }})
		"#
	));
	assert_eq!(out[0], json!({ "id": "yendi/cozy-bag", "guide": "studio/cozy-bag", "live": 1, "synced": true }));
	assert_eq!(out[1], json!({ "live": 2 }));
}

#[test]
fn export_decode_save_open_fork() {
	let out = run(&format!(
		r#"{BUILD}
		local text, why = S.Export()
		assert(text, why)
		emit({{ text = text }})
		-- A player pastes it on Polestar's Import page.
		local info, why2 = P.Import.Preview(text)
		assert(info, why2)
		assert(P.Import.Save(info.entry))
		local entry = P.Import.Entry("yendi/cozy-bag")
		-- Another author opens it in Studio, then forks it.
		S.Model.Delete("yendi/cozy-bag")
		local opened = assert(S.Model.Open(entry))
		emit({{ opened = opened.header.id, steps = #opened.steps, verb = opened.steps[1].goals[1].src.verb, stepId = opened.steps[1].id == entry.guide.steps[1].id }})
		S.SetHandle("joe")
		local fork = assert(S.Model.Fork(entry, "joe"))
		emit({{ id = fork.header.id, author = fork.header.author, forkedFrom = fork.header.forkedFrom, credits = fork.header.credits, version = fork.header.version }})
		local forkText = assert(S.Export(fork))
		local back = assert(P.Import.Decode(forkText))
		emit({{ forkedFrom = back.guide.forkedFrom, credits = back.guide.credits }})
		"#
	));
	let text = out[0]["text"].as_str().unwrap();
	assert!(text.starts_with("!PS2!"), "{text}");
	// The tools read Studio's string: its source tree writes the guide back (node tools/polestar.js decode).
	let payload = plain(&decode_import(text).unwrap_or_else(|e| panic!("{e}")));
	assert_eq!(payload["format"], 10);
	assert_eq!(payload["source"]["header"]["guide"], "yendi/cozy-bag");
	assert_eq!(payload["source"]["steps"][0]["goals"][0], json!({ "verb": "boss", "args": ["639"], "mods": [] }));
	assert_eq!(payload["guide"]["steps"][1]["goals"][0]["t"], "goto");
	assert_eq!(out[1], json!({ "opened": "yendi/cozy-bag", "steps": 2, "verb": "boss", "stepId": true }));
	assert_eq!(out[2], json!({ "id": "joe/cozy-bag", "author": "joe", "forkedFrom": { "id": "yendi/cozy-bag", "version": 1 }, "credits": ["yendi"], "version": 1 }));
	assert_eq!(out[3], json!({ "forkedFrom": { "id": "yendi/cozy-bag", "version": 1 }, "credits": ["yendi"] }));
}

#[test]
fn the_window_opens_on_the_handle_first_then_new_and_open_and_every_tab_builds() {
	let out = run(
		r#"
		S = PolestarStudio
		local UI = S.UI
		UI.Toggle()
		local p = UI.Panel()
		emit({ shown = p:IsShown(), home = p.HomeView:IsShown(), left = p.HomeView and UI.Home ~= nil })
		S.SetHandle("yendi")
		UI.Home.Refresh()
		local doc = S.Model.New({ title = "Tabs", minLevel = 1, maxLevel = 5, zone = 1429 })
		UI.ShowHome(false)
		local built = {}
		for _, def in ipairs(UI.WidgetList()) do
			UI.SelectTab(def.name)
			built[#built + 1] = def.name .. ":" .. tostring(UI.WidgetShown(def.name))
		end
		UI.SelectTab("Export")
		emit({ home = p.HomeView:IsShown(), tabs = built, active = UI.ActiveTab(), toolbar = p.Strip:IsShown() })
		"#,
	);
	assert_eq!(out[0], json!({ "shown": true, "home": true, "left": true }));
	assert_eq!(out[1]["home"], false);
	assert_eq!(out[1]["active"], "Export");
	assert_eq!(out[1]["toolbar"], true);
	let tabs: Vec<&str> = out[1]["tabs"].as_array().unwrap().iter().map(|t| t.as_str().unwrap()).collect();
	assert_eq!(tabs, ["TargetCard:true", "QuestPanel:true", "PositionHUD:true", "Nearby:true", "Checks:true", "Session:true"]);
}
