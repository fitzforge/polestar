//! Class quests (addon/Polestar/QoL/ClassQuests.lua + the UI/GuideFrame.lua banner): when one of the character's
//! Class guides opens, the guide window offers it in a tab, once per guide; "Later" asks again at a higher level.
//!
//! Section 1: the banner (stub_ui, like tests/riding.rs).
//! Section 2: ClassQuests.lua (stub_qol), with the guides and the engine stubbed.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const UI_PRE: &str = r#"uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local B = GF.parts.banner
uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
local opened, resolved = {}, {}
Polestar.Engine.OpenTab = function(id) opened[#opened + 1] = id; return 2 end
Polestar.QoL = { ClassQuests = { Resolve = function(id, later) resolved[#resolved + 1] = { id = id, later = later or false } end } }
"#;

fn run_ui(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &UI_FILES)], script: format!("{UI_PRE}{script}"), ..Default::default() })
}

#[test]
fn class_quest_ready_shows_the_offer_the_guide_why_open_in_a_tab_and_later() {
	let out = run_ui(
		r#"
		Polestar.Fire("CLASS_QUEST_READY", { guideId = "forever/class/shaman/call-of-air-horde", title = "Call of Air", why = "The Air Totem." })
		emit({ shown = B:IsShown(), text = B.Text:GetText(), jump = B.Jump.Label:GetText(), later = B.Later:IsShown() and B.Later.Label:GetText(), close = B.Close:IsShown() })"#,
	);
	let out = &out[0];
	assert_eq!(out["shown"], true);
	assert_eq!(out["text"], "Class quest ready: Call of Air\nThe Air Totem.");
	assert_eq!(out["jump"], "Open in a tab");
	assert_eq!(out["later"], "Later");
	assert_eq!(out["close"], true);
}

#[test]
fn the_banner_opens_the_guide_in_a_tab_or_asks_again_later_or_is_dismissed_for_good() {
	let out = run_ui(
		r#"
		local n = { guideId = "g/one", title = "One" }
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Jump:Click()
		emit({ opened = opened, resolved = resolved[1], shown = B:IsShown() })
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Later:Click()
		emit(resolved[2])
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Close:Click()
		emit(resolved[3])"#,
	);
	assert_eq!(out[0], json!({ "opened": ["g/one"], "resolved": { "id": "g/one", "later": false }, "shown": false }));
	assert_eq!(out[1], json!({ "id": "g/one", "later": true }));
	assert_eq!(out[2], json!({ "id": "g/one", "later": false }));
}

// ---------------------------------------------------------------------------
// Section 2: ClassQuests.lua
// ---------------------------------------------------------------------------

fn qol_files() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"])
}

// Three Class guides: a Shaman one that is open (no gate), a Shaman one that waits on level 30, and a Rogue one.
const PRELUDE: &str = r#"
local q = stub.qol
local C = Polestar.Compat
local CQ = Polestar.QoL.ClassQuests
Polestar.RegisterDefaults("behavior", { offerClassQuests = true })
local inLog, done = {}, {}
C.IsOnQuest = function(id) return inLog[id] == true end
C.IsQuestCompleted = function(id) return done[id] == true end
C.GetPlayerInfo = function() return { name = "T", level = q.level, race = "Orc", class = "SHAMAN", faction = "Horde" } end
local guides = {
	{ id = "c/fire", title = "Call of Fire", category = "Class", classes = { "SHAMAN" }, why = "The Fire Totem.", steps = { { goals = { { t = "accept", quest = 1 } } } } },
	{ id = "c/air", title = "Call of Air", category = "Class", classes = { "SHAMAN" }, steps = { { goals = { { t = "accept", quest = 2 } } } } },
	{ id = "c/poisons", title = "Poisons", category = "Class", classes = { "ROGUE" }, steps = { { goals = { { t = "accept", quest = 3 } } } } },
	{ id = "l/durotar", title = "Durotar", category = "Leveling", steps = { { goals = { { t = "accept", quest = 4 } } } } },
}
local byId = {}
for _, g in ipairs(guides) do byId[g.id] = g end
Polestar.Guides = {
	List = function() return guides end,
	Get = function(id) return byId[id] end,
	GuideMatches = function(g, p) return not g.classes or g.classes[1] == p.class end,
}
local gates = { ["c/air"] = { level = 30 } }
Polestar.Engine = {
	StartGate = function(id) return gates[id] end,
	GetGuideState = function() return "new" end,
}
local offers = {}
Polestar.On("CLASS_QUEST_READY", function(n) offers[#offers + 1] = n end)
local function levelUp(n)
	q.level = n
	stub.fire("PLAYER_LEVEL_UP", n, 0, 0, 0, 0, 0, 0, 0, 0)
	stub.advance(3)
end
"#;

fn run_qol(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_qol.lua"], addons: vec![qol_files()], login: true, script: format!("{PRELUDE}{script}"), ..Default::default() })
}

#[test]
fn only_the_class_guides_this_character_can_start_now_and_has_not_started_are_ready() {
	let out = run_qol(
		r#"
		q.level = 20
		local ids = {}
		for _, g in ipairs(CQ.Ready()) do ids[#ids + 1] = g.id end
		emit(ids)
		inLog[1] = true
		emit(#CQ.Ready())"#,
	);
	assert_eq!(out[0], json!(["c/fire"]), "not the gated one, not another class, not a leveling guide");
	assert_eq!(out[1], 0, "a quest of it in the log: under way");
}

#[test]
fn a_level_up_offers_one_guide_at_a_time_later_asks_again_at_a_higher_level_a_dismiss_never() {
	let out = run_qol(
		r#"
		levelUp(20)
		emit({ n = #offers, id = offers[1] and offers[1].guideId, why = offers[1] and offers[1].why })
		levelUp(21)
		emit(#offers)
		CQ.Resolve("c/fire", true)
		emit(#offers)
		levelUp(22)
		emit(#offers)
		CQ.Resolve("c/fire")
		levelUp(23)
		emit(#offers)"#,
	);
	assert_eq!(out[0], json!({ "n": 1, "id": "c/fire", "why": "The Fire Totem." }));
	assert_eq!(out[1], 1, "not again while the offer is up");
	assert_eq!(out[2], 1, "Later: not at this level");
	assert_eq!(out[3], 2, "again at a higher level");
	assert_eq!(out[4], 2, "dismissed for good");
}

#[test]
fn the_gated_guide_is_offered_once_its_gate_opens_nothing_with_the_setting_off() {
	let out = run_qol(
		r#"
		levelUp(20)
		CQ.Resolve("c/fire")
		gates["c/air"] = nil
		levelUp(30)
		emit(offers[#offers].guideId)
		Polestar.Set("behavior.offerClassQuests", false)
		CQ.Resolve("c/air", true)
		levelUp(31)
		emit(#offers)"#,
	);
	assert_eq!(out[0], "c/air");
	assert_eq!(out[1], 2);
}
