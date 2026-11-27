//! The fresh-start note's link (#4110; addon/Polestar/Core/Engine.lua, Engine.OpenFreshSource and Own.chainStart;
//! `/polestar prereq`). A guide that follows on from an earlier guide offers to open it; the earlier guide opens
//! at the first step where the character can start on the quests they lack of it, down their prerequisites, not
//! at its first step. A hand-in counts only for a quest in the log. The steps before are skipped as a `skipto`
//! jump skips them ("jump"), and Unskip brings one back. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Human", "Human", "MAGE", "Mage", "Alliance", 6
w.titles[844] = "Unrelated Errand"; w.titles[5000] = "First Link"; w.titles[5001] = "Second Link"
w.titles[5002] = "Third Link"; w.titles[5003] = "Stale Shards"
"#;

// The earlier guide: 1 an errand the character does not need · 2 the hand-in of Stale Shards (5003), a quest
// whose accept an even earlier guide has · 3-6 a chain: First Link (5000), Second Link (5001, needs 5000) and its
// hand-in, Third Link (5002, needs 5001) · 7 a stop. The later guide's header names 5002 and 5003. The
// character's own tab at login is Silverpine, a guide that follows on from nothing.
const GUIDES: &str = r#"
local function acc(q, pre) return { t = "accept", quest = q, title = stub.world.titles[q], pre = pre, map = 1429, x = 30, y = 50 } end
local function steps(n)
	local out = {}
	for i = 1, n do out[i] = { title = "Stop " .. i, goals = { { t = "goto", map = 1429, x = 30 + i, y = 50 } } } end
	return out
end
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", faction = "Alliance", minLevel = 1, maxLevel = 10, steps = {
	{ title = "Unrelated", goals = { acc(844) } },
	{ title = "Hand in the shards", goals = { { t = "turnin", quest = 5003, title = "Stale Shards", map = 1429, x = 30, y = 50 } } },
	{ title = "First link", goals = { acc(5000) } },
	{ title = "Second link", goals = { acc(5001, { 5000 }) } },
	{ title = "Hand in the second link", goals = { { t = "turnin", quest = 5001, title = "Second Link", map = 1429, x = 30, y = 50 } } },
	{ title = "Third link", goals = { acc(5002, { 5001 }) } },
	{ title = "Stop", goals = { { t = "goto", map = 1429, x = 36, y = 50 } } },
} })
Polestar.RegisterGuide({ id = "test/ashenvale", pack = "test", title = "Ashenvale", faction = "Alliance", minLevel = 5, maxLevel = 12,
	steps = steps(6), fresh = { from = "test/barrens", share = 60, xp = 10000, needs = { 5002, 5003 } } })
Polestar.RegisterGuide({ id = "test/silverpine", pack = "test", title = "Silverpine", faction = "Alliance", minLevel = 5, maxLevel = 12,
	steps = steps(3) })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- The saved skips of the earlier guide's steps 1-7, "nil" where none.
function jumps()
	local sk = Polestar.CharState().skipped["test/barrens"] or {}
	local out = {}
	for s = 1, 7 do out[#out + 1] = tostring(sk[s]) end
	return table.concat(out, " ")
end
function tabs()
	local list, active = E.GetTabs()
	local out = {}
	for i, t in ipairs(list) do out[i] = t.guideId end
	return { tabs = out, active = active }
end
stub.login()
stub.fire("QUEST_LOG_UPDATE"); flush()
"#;

fn run(script: &str) -> Value {
	run_with(vec![Addon::files("Polestar", &["Core/Core.xml"])], script)
}

fn run_with(addons: Vec<Addon>, script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: WORLD.to_string(), addons, script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, script].join("\n"), ..Default::default() }).remove(0)
}

// A character with none of the quests: the earlier guide opens at First Link, the first step they can start the
// chain on. The errand before it and the hand-in of Stale Shards (a quest they do not hold) are skipped, not
// where the guide starts; Unskip brings the errand back.
#[test]
fn the_earlier_guide_opens_at_the_first_step_that_starts_the_chain() {
	let out = run(r#"
		local r = { opened = E.OpenFreshSource("test/ashenvale") }
		flush()
		r.at = { E.GetLiveStep(), E.GetGuide().id, jumps(), tabs() }
		r.unskipped = E.Unskip(1); flush()
		r.after = { E.GetLiveStep(), jumps() }
		emit(r)
	"#);
	assert_eq!(out["opened"], json!(2), "{out}");
	assert_eq!(out["at"], json!([3, "test/barrens", "jump jump nil nil nil nil nil", { "tabs": ["test/silverpine", "test/barrens"], "active": 2 }]), "{out}");
	assert_eq!(out["unskipped"], json!(true), "{out}");
	assert_eq!(out["after"], json!([1, "nil jump nil nil nil nil nil"]), "{out}");
}

// A prerequisite done moves the start on to the quest it opens. A quest in the log is no start for its accept,
// but its hand-in, when the next quest of the chain waits on it, is.
#[test]
fn a_prerequisite_done_moves_the_start_on_and_a_hand_in_counts_for_a_quest_in_the_log() {
	let done = run(r#"
		stub.world.complete({ 5000 }); flush()
		E.OpenFreshSource("test/ashenvale"); flush()
		emit({ E.GetLiveStep(), jumps() })
	"#);
	assert_eq!(done, json!([4, "jump jump jump nil nil nil nil"]), "{done}");
	let held = run(r#"
		stub.world.complete({ 5000 }); stub.world.onQuest(5001, {}); flush()
		E.OpenFreshSource("test/ashenvale"); flush()
		emit({ E.GetLiveStep(), jumps() })
	"#);
	assert_eq!(held, json!([5, "jump jump jump jump nil nil nil"]), "{held}");
}

// Nothing to open: every quest the header names is done, or the guide follows on from nothing. A guide already
// in a tab is shown as it is, with no step skipped.
#[test]
fn nothing_is_opened_for_a_character_who_lacks_nothing_and_an_open_tab_is_left_as_it_is() {
	let out = run(r#"
		local r = {}
		r.silverpine = E.OpenFreshSource("test/silverpine") or false
		r.unknown = E.OpenFreshSource("test/nowhere") or false
		stub.world.complete({ 5002, 5003 }); flush()
		r.done = E.OpenFreshSource("test/ashenvale") or false
		r.tabs = tabs()
		emit(r)
	"#);
	assert_eq!(out["silverpine"], json!(false), "{out}");
	assert_eq!(out["unknown"], json!(false), "{out}");
	assert_eq!(out["done"], json!(false), "{out}");
	assert_eq!(out["tabs"]["tabs"], json!(["test/silverpine"]), "{out}");
	let open = run(r#"
		E.OpenTab("test/barrens"); flush()
		local r = { E.OpenFreshSource("test/ashenvale") }
		flush()
		emit({ r[1], E.GetGuide().id, E.GetLiveStep(), jumps() })
	"#);
	assert_eq!(open, json!([2, "test/barrens", 1, "nil nil nil nil nil nil nil"]), "{open}");
}

// `/polestar prereq`: the active guide's, or the one named.
#[test]
fn the_prereq_command_opens_the_earlier_guide_for_the_active_guide_or_the_one_named() {
	let out = run(r#"
		E.OpenTab("test/ashenvale"); flush()
		Polestar.RunCommand("prereq"); flush()
		local r = { E.GetGuide().id, E.GetLiveStep() }
		E.CloseTab(3); flush()
		E.SelectTab(2); flush()
		Polestar.RunCommand("prereq test/ashenvale"); flush()
		emit({ r, { E.GetGuide().id, E.GetLiveStep() } })
	"#);
	assert_eq!(out, json!([["test/barrens", 3], ["test/barrens", 3]]), "{out}");
}

// The full addon: the banner's "Open The Barrens" opens the earlier guide at First Link, not at its first step.
#[test]
fn the_banners_link_opens_the_earlier_guide_at_the_chain() {
	let out = run_with(
		vec![Addon::name("Polestar")],
		r#"
		local GF = Polestar.UI.GuideFrame
		local B = GF.parts.banner
		Polestar.Set("ui.shown", true)
		E.OpenTab("test/ashenvale"); flush()
		local r = { banner = B:IsShown() and B.psKind == "fresh" and B.Jump.Label:GetText() or false }
		B.Jump:Click(); flush()
		r.opened = { E.GetGuide().id, E.GetLiveStep(), jumps() }
		emit(r)
	"#,
	);
	assert_eq!(out["banner"], json!("Open The Barrens"), "{out}");
	assert_eq!(out["opened"], json!(["test/barrens", 3, "jump jump nil nil nil nil nil"]), "{out}");
}
