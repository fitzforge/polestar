//! Talent plans (addon/Polestar/Talents): the plans in Builds.lua replayed under the snapshot's rules, plan
//! progress (T.State: points from the tree's currency, the level only as a fallback), the snapshot checked
//! against the live tree (moved IDs found by name, a missing talent makes the plan out of date), the marks on
//! the talent frame (next ring while a point waits, pick numbers, off-plan flags, the tooltip line; no levels;
//! nothing while inspecting, for another loadout or in combat until it ends), the reminder and the hub section
//! (client names on every tab). The client is tests/lua/stub_talents.lua.

use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const CORE: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Talents/Talents.xml"];
const WITH_UI: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml", "Talents/Talents.xml"];

const PRELUDE: &str = r#"
local T, TS = Polestar.Talents, stub.talents
local data = T.Data("PALADIN")
TS.useSnapshot(data)
local function plan(key) return T.BuildByKey(data, key) end
"#;

fn run_in(script: &str, files: &[&str], stubs: &[&'static str]) -> Vec<Value> {
	let mut all = vec!["stub_world.lua", "stub_talents.lua"];
	all.extend_from_slice(stubs);
	emitted(&RunAddon { stubs: all, addons: vec![Addon::files("Polestar", files)], script: [PRELUDE, script].join("\n"), ..Default::default() })
}

fn run(script: &str) -> Vec<Value> {
	run_in(script, CORE, &[])
}

/// Object.keys(v).length of an emitted table.
fn count(v: &Value) -> usize {
	match v {
		Value::Array(a) => a.len(),
		Value::Object(o) => o.len(),
		_ => 0,
	}
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

// ------------------------------------------------------------ the plans

#[test]
fn talent_labels_use_the_client_spell_name_before_the_english_snapshot_when_the_live_tree_is_unavailable() {
	let out = run(r#"
local id = next(data.nodes)
local n = data.nodes[id]
C_Spell = C_Spell or {}
C_Spell.GetSpellName = function(spell) if spell == n.spell then return "客户端天赋" end end
local first = T.NodeName(data, id)
local pick = T.PickText(data, { node = id, rank = 1 })
local live = T.NodeName(data, id, { names = { [id] = "实时天赋" } })
C_Spell.GetSpellName = function() return nil end
GetSpellInfo = function(spell) if spell == n.spell then return "旧版接口天赋" end end
local legacy = T.NodeName(data, id)
GetSpellInfo = function() return nil end
local missing = T.NodeName(data, id)
C_Spell.GetSpellName = function() error("spell cache not ready") end
GetSpellInfo = function() error("spell cache not ready") end
emit({ first, pick, live, legacy, missing, T.NodeName(data, id), n.name, n.max })"#)
	.remove(0);
	assert_eq!(out[0], "客户端天赋");
	assert_eq!(out[1], format!("客户端天赋 1/{}", out[7]).as_str());
	assert_eq!(json!([out[2], out[3]]), json!(["实时天赋", "旧版接口天赋"]));
	assert_eq!(out[4], out[6], "unknown spell names retain the snapshot");
	assert_eq!(out[5], out[6], "unavailable client APIs retain the snapshot");
}

#[test]
fn builds_lua_three_paladin_plans_51_picks_each_every_one_legal_under_the_snapshot() {
	let out = run(r#"
local o = { prereq = data.prereq, tree = data.tree, specs = data.specs, plans = {} }
for _, b in ipairs(data.builds) do
	o.plans[#o.plans + 1] = { key = b.key, spec = b.specName, picks = #b.picks, first = b.picks[1].order, last = b.picks[#b.picks].order, level = b.picks[1].level, errors = T.Replay(data, b) }
end
emit(o)"#)
	.remove(0);
	assert_eq!(out["tree"], 1100);
	assert_eq!(out["prereq"], "full", "arrows need full rank until checked in game");
	assert_eq!(out["specs"], json!(["Holy", "Protection", "Retribution"]));
	for p in out["plans"].as_array().unwrap() {
		assert_eq!(p["picks"], 51, "{}", text(&p["key"]));
		assert_eq!(p["first"], 1);
		assert_eq!(p["last"], 51);
		assert!(p["level"].is_null(), "picks carry an order, not a level");
		assert_eq!(count(&p["errors"]), 0, "{}: {}", text(&p["key"]), p["errors"]);
	}
}

#[test]
fn replay_of_several_arrows_into_one_talent_any_one_opens_it() {
	let outs = run(r#"
local d = { prereq = "full", groups = {}, gates = {}, edges = { { 1, 3 }, { 2, 3 } }, nodes = {
	[1] = { name = "Bestial Swiftness", max = 1 }, [2] = { name = "Bestial Wrath", max = 1 }, [3] = { name = "Intimidation", max = 1 } } }
emit(#T.Replay(d, { key = "k", picks = { { order = 1, node = 1, rank = 1 }, { order = 2, node = 3, rank = 1 } } }))
emit(T.Replay(d, { key = "k", picks = { { order = 1, node = 3, rank = 1 } } })[1])"#);
	assert_eq!(outs[0], 0);
	assert!(is_match(outs[1].as_str().unwrap(), r"needs Bestial Swiftness or Bestial Wrath"));
}

// Every class's plans in Builds.lua: three specs, 51 picks each, legal under the snapshot.
const CLASS_SPECS: &[(&str, &[&str])] = &[
	("DRUID", &["Balance", "Feral Combat", "Restoration"]),
	("HUNTER", &["Beast Mastery", "Marksmanship", "Survival"]),
	("MAGE", &["Arcane", "Fire", "Frost"]),
	("PALADIN", &["Holy", "Protection", "Retribution"]),
	("PRIEST", &["Discipline", "Holy", "Shadow"]),
	("ROGUE", &["Assassination", "Combat", "Subtlety"]),
	("SHAMAN", &["Elemental", "Enhancement", "Restoration"]),
	("WARLOCK", &["Affliction", "Demonology", "Destruction"]),
	("WARRIOR", &["Arms", "Fury", "Protection"]),
];

// Each class in turn, as the player's class: T.Register keeps only that one.
fn run_as(cls: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_talents.lua"],
		before: format!("stub.talents.class = \"{cls}\""),
		addons: vec![Addon::files("Polestar", CORE)],
		script: script.into(),
		..Default::default()
	})
}

#[test]
fn builds_lua_every_class_has_a_plan_per_spec_51_picks_each_every_one_legal_under_the_snapshot() {
	for (cls, specs) in CLASS_SPECS {
		let out = run_as(
			cls,
			r#"
local d = Polestar.Talents.Data()
local c = { class = d and d.class, specs = d and d.specs, plans = {} }
for _, b in ipairs(d and d.builds or {}) do
	c.plans[#c.plans + 1] = { key = b.key, spec = b.specName, picks = #b.picks, errors = Polestar.Talents.Replay(d, b) }
end
emit(c)"#,
		)
		.remove(0);
		assert_eq!(out["class"], *cls);
		assert_eq!(out["specs"], json!(specs), "{cls}");
		let plans = out["plans"].as_array().unwrap();
		let got: Vec<Value> = plans.iter().map(|p| p["spec"].clone()).collect();
		assert_eq!(json!(got), json!(specs), "{cls}: one plan per spec, in order");
		for p in plans {
			assert_eq!(p["picks"], 51, "{cls} {}", text(&p["key"]));
			assert_eq!(count(&p["errors"]), 0, "{cls} {}: {}", text(&p["key"]), p["errors"]);
		}
	}
}

#[test]
fn register_only_the_player_s_class_is_kept_so_a_character_does_not_hold_every_class_s_plans() {
	let classes = CLASS_SPECS.iter().map(|(c, _)| format!("\"{c}\"")).collect::<Vec<_>>().join(", ");
	let kept = r#"
local o = {}
for _, cls in ipairs({ ${classes} }) do
	if Polestar.Talents.Data(cls) then o[#o + 1] = cls end
end
emit(o)"#
		.replace("${classes}", &classes);
	assert_eq!(run_as("WARRIOR", &kept)[0], json!(["WARRIOR"]));
	assert_eq!(run_as("PALADIN", &kept)[0], json!(["PALADIN"]));
	assert_eq!(run_as("DEATHKNIGHT", &kept)[0], json!({}), "a class with no plans keeps none (an empty Lua table)");
	// A client that cannot name the class yet keeps every class, as before.
	let all = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_talents.lua"],
		before: "stub.talents.class = nil".into(),
		addons: vec![Addon::files("Polestar", CORE)],
		script: kept.clone(),
		..Default::default()
	});
	let names: Vec<&str> = CLASS_SPECS.iter().map(|(c, _)| *c).collect();
	assert_eq!(all[0], json!(names));
}

#[test]
fn replay_a_skipped_arrow_an_early_tier_and_a_skipped_rank_are_caught_started_relaxes_arrows() {
	let outs = run(r#"
local ret = plan("retribution")
local function copy(b, edit)
	local c = { key = b.key, picks = {} }
	for i, p in ipairs(b.picks) do c.picks[i] = { order = p.order, node = p.node, rank = p.rank } end
	edit(c.picks)
	return c
end
-- Vengeance needs Sanctified Judgement (an arrow): drop that pick's ranks.
local arrow
for _, e in ipairs(data.edges) do if data.nodes[e[2]].name == "Vengeance" then arrow = e end end
local fromNode = arrow[1]
local broken = copy(ret, function(p)
	local first
	for i, x in ipairs(p) do if x.node == fromNode and x.rank == data.nodes[fromNode].max then first = i end end
	p[first] = { order = p[first].order, node = p[1].node, rank = 99 }
end)
local early = copy(ret, function(p) p[1], p[25] = p[25], p[1]; p[1].order, p[25].order = 1, 25 end)
local errs = T.Replay(data, broken)
local arrowErr = false
for _, e in ipairs(errs) do if e:find("needs " .. data.nodes[fromNode].name, 1, true) then arrowErr = true end end
emit({ arrowErr = arrowErr, rankErr = errs[1] ~= nil, early = #T.Replay(data, early) > 0 })
data.prereq = "started"
emit(#T.Replay(data, ret))"#);
	let (out, started) = (&outs[0], &outs[1]);
	assert!(truthy(&out["rankErr"]));
	assert!(truthy(&out["arrowErr"]), "the arrow into Vengeance");
	assert!(truthy(&out["early"]), "a deep talent first");
	assert_eq!(*started, 0, "the plans also hold if one rank opens an arrow");
}

// ------------------------------------------------------------ progress

#[test]
fn state_next_pick_unspent_points_off_plan_ranks_complete_the_level_is_only_a_fallback() {
	let outs = run(r#"
local b = plan("retribution")
local function at(n, level, granted, extra)
	local ranks = {}
	for i = 1, n do ranks[b.picks[i].node] = b.picks[i].rank end
	for id, r in pairs(extra or {}) do ranks[id] = r end
	local s = T.State(b, ranks, level, granted)
	return { status = s.status, done = s.done, unspent = s.unspent, nextOrder = s.next and s.next.order, source = s.source, off = next(s.offPlan) ~= nil }
end
emit(at(0, 5))
emit(at(10, 20))
emit(at(11, 20))
emit(at(21, 31))
local holy = plan("holy").picks[1].node
emit(at(11, 20, nil, { [holy] = 5 }))
emit(at(51, 60))
emit(at(0, 5, 1))
emit(at(10, 15, 20))
emit(at(21, 30, 22))
emit(at(21, 30, 21))"#);
	assert_eq!(outs[0]["status"], "early");
	assert_eq!(json!([outs[1]["status"], outs[1]["unspent"], outs[1]["nextOrder"], outs[1]["source"]]), json!(["behind", 1, 11, "level"]));
	assert_eq!(json!([outs[2]["status"], outs[2]["unspent"], outs[2]["nextOrder"]]), json!(["onplan", 0, 12]));
	assert_eq!(json!([outs[3]["status"], outs[3]["unspent"]]), json!(["behind", 1]));
	assert_eq!(outs[4]["status"], "offplan");
	assert_eq!(outs[5]["status"], "complete");
	assert_eq!(json!([outs[6]["status"], outs[6]["unspent"], outs[6]["source"]]), json!(["behind", 1, "currency"]), "a point at level 5 (Talented): no longer \"early\"");
	assert_eq!(json!([outs[7]["status"], outs[7]["unspent"], outs[7]["nextOrder"]]), json!(["behind", 10, 11]), "granted points, not the level, give the unspent count");
	assert_eq!(json!([outs[8]["status"], outs[8]["unspent"], outs[8]["nextOrder"]]), json!(["behind", 1, 22]), "at the level cap a granted point is still a point");
	assert_eq!(json!([outs[9]["status"], outs[9]["unspent"]]), json!(["onplan", 0]));
}

#[test]
fn current_unspent_points_come_from_the_tree_currency_early_points_else_from_the_level() {
	let outs = run(r#"
local b = plan("retribution")
local function state()
	local c = T.Refresh()
	local s = c.state
	return { status = s.status, unspent = s.unspent, points = s.points, source = s.source, staged = c.staged.unspent }
end
-- Talented (Adventure): level 14 with 11 points granted, 10 spent.
TS.level = 14
TS.learn(b, 10)
TS.currency = { quantity = 1, spent = 10 }
stub.login()
emit(state())
-- A point staged in the frame uses it up.
TS.staged[b.picks[11].node] = b.picks[11].rank
emit(state())
TS.staged = {}
-- No currency from the client: one point a level from 10.
TS.currency = nil
emit(state())
TS.level = 20
emit(state())
-- No API at all.
local api = C_Traits.GetTreeCurrencyInfo
C_Traits.GetTreeCurrencyInfo = nil
emit(state())
C_Traits.GetTreeCurrencyInfo = api"#);
	assert_eq!(outs[0], json!({ "status": "behind", "unspent": 1, "points": 11, "source": "currency", "staged": 1 }));
	assert_eq!(json!([outs[1]["unspent"], outs[1]["staged"]]), json!([1, 0]));
	assert_eq!(outs[2], json!({ "status": "onplan", "unspent": 0, "points": 10, "source": "level", "staged": 0 }), "fallback: level 14 is 5 points, all spent");
	assert_eq!(outs[3], json!({ "status": "behind", "unspent": 1, "points": 11, "source": "level", "staged": 1 }));
	assert_eq!(outs[4], outs[3], "missing API falls back the same way");
}

// ------------------------------------------------------------ the live tree

#[test]
fn validate_a_moved_node_is_found_by_spell_and_rank_count_a_missing_one_makes_the_plan_out_of_date() {
	let outs = run(r#"
local soc
for id, n in pairs(data.nodes) do if n.name == "Seal of Command" then soc = id end end
TS.nodes[soc + 90000], TS.nodes[soc] = TS.nodes[soc], nil
local v = T.Validate(data, T.Read(data))
emit({ ok = v.ok, moved = v.moved, to = v.map[soc] == soc + 90000 })
TS.nodes[soc + 90000] = nil
v = T.Validate(data, T.Read(data))
emit({ ok = v.ok, missing = v.missing })
stub.login()
local c, why = T.Current()
emit({ why = why, state = c.state ~= nil })"#);
	assert_eq!(outs[0], json!({ "ok": true, "moved": 1, "to": true }));
	assert_eq!(outs[1], json!({ "ok": false, "missing": ["Seal of Command"] }));
	assert_eq!(outs[2], json!({ "why": "stale", "state": false }), "no guessing: no state, no marks");
}

#[test]
fn validate_a_non_english_client_matches_by_spell_id_and_shows_its_own_names() {
	let outs = run(r#"
for id, n in pairs(TS.nodes) do n.name = "es:" .. n.name end
local soc
for id, n in pairs(data.nodes) do if n.name == "Seal of Command" then soc = id end end
TS.nodes[soc + 90000], TS.nodes[soc] = TS.nodes[soc], nil
local b = plan("retribution")
TS.learn(b, 20)
stub.login()
local c, why = T.Current()
emit({ why = why, ok = c.valid.ok, moved = c.valid.moved, missing = #c.valid.missing, next = T.PickText(c.data, c.state.next, c.valid), soc = T.NodeName(c.data, soc, c.valid) })"#);
	assert_eq!(outs[0], json!({ "ok": true, "moved": 1, "missing": 0, "next": "es:Seal of Command 1/1", "soc": "es:Seal of Command" }));
}

#[test]
fn activebuild_the_chosen_plan_else_the_spec_with_the_most_points_choose_auto_follows_again() {
	let outs = run(r#"
TS.learn(plan("protection"), 12)
stub.login()
emit(T.Current().build.key)
T.Choose("holy")
emit({ key = T.Current().build.key, choice = T.Choice() })
T.Choose("auto")
emit(T.Current().build.key)"#);
	assert_eq!(outs[0], "protection");
	assert_eq!(outs[1], json!({ "key": "holy", "choice": "holy" }));
	assert_eq!(outs[2], "protection");
}

// ------------------------------------------------------------ the talent frame

const FRAME: &str = r#"
local b = plan("retribution")
TS.learn(b, 20) -- level 30 with one point unspent: next is pick 21 (level 30)
stub.login()
local f = TS.openFrame()
stub.addonLoaded("Blizzard_PlayerSpells")
stub.runTimers()
local O = T.Overlay
local function markOf(id) return O.marks[TS.button(id)] end
local function view()
	local s = T.Current().staged
	local nxt = s.next.node
	local m = markOf(nxt)
	local shownMarks = 0
	for _, x in pairs(O.marks) do if x:IsShown() then shownMarks = shownMarks + 1 end end
	return { ring = m and m:IsShown() and m.Ring:IsShown() or false, badge = m and m.Badge.Text:GetText(), marks = shownMarks }
end
"#;

fn run_frame(script: &str) -> Vec<Value> {
	run(&[FRAME, script].join("\n"))
}

#[test]
fn overlay_a_ring_on_the_next_pick_while_a_point_waits_its_pick_number_as_a_badge_a_flag_off_the_plan_staged_ranks_move_the_ring() {
	let outs = run_frame(
		r#"emit(view())
TS.currency = { quantity = 2, spent = 20 }
T.Refresh()
stub.runTimers()
local nxt = T.Current().staged.next
-- Stage the next pick in the frame (not applied yet).
TS.staged[nxt.node] = nxt.rank
EventRegistry:TriggerEvent("TalentFrameBase.ButtonsUpdated")
stub.fire("TRAIT_NODE_CHANGED", nxt.node)
stub.runTimers()
stub.runTimers()
local after = view()
after.moved = T.Current().staged.next ~= nxt
emit(after)
-- Both points staged: nothing left to spend, no ring.
local second = T.Current().staged.next
TS.staged[second.node] = second.rank
T.Refresh()
stub.runTimers()
emit(view())
-- A point outside the plan.
local holy = plan("holy").picks[1].node
TS.ranks[holy] = 1
stub.fire("TRAIT_CONFIG_UPDATED", 7)
stub.runTimers()
stub.runTimers()
local m = markOf(holy)
emit({ flag = m and m:IsShown() and m.Flag:IsShown() or false })"#,
	);
	assert_eq!(outs[0]["ring"], true);
	assert_eq!(outs[0]["badge"], "21", "pick #21, not level 30");
	assert!(num(&outs[0]["marks"]) > 1.0, "every planned talent with a rank to come has a badge");
	assert_eq!(outs[1]["moved"], true);
	assert_eq!(outs[1]["ring"], true, "the ring is on the new next pick");
	assert_eq!(outs[2]["ring"], false, "no point left: no ring");
	assert_eq!(outs[3]["flag"], true);
}

// The gamepad interface hooks CreateFrame and, for a parent inside the open talent frame, rebuilds its buttons
// in the caller's code: from Polestar's, the talent frame's next gamepad action is blocked. wow_stub.lua's
// CreateFrame lists those calls in stub.underGameFrames.
#[test]
fn overlay_a_mark_and_its_ring_and_badge_are_made_with_no_parent_then_set_under_the_talent_button_so_the_gamepad_interface_never_rebuilds_the_talent_frame_s_buttons_in_polestar_s_code() {
	let out = run_frame(
		r#"local on = 0
for button, m in pairs(O.marks) do
	if m:GetParent() == button and m.Ring:GetParent() == m and m.Badge:GetParent() == m then on = on + 1 end
end
emit({ marks = view().marks, on = on, under = table.concat(stub.underGameFrames, "; ") })"#,
	)
	.remove(0);
	assert!(num(&out["marks"]) > 1.0, "the planned talents are marked");
	assert!(num(&out["on"]) >= num(&out["marks"]), "every mark hangs off its button, its ring and badge off the mark");
	assert_eq!(out["under"], "", "no CreateFrame names a game frame as parent");
}

#[test]
fn overlay_no_level_labels_and_nothing_muted_at_the_level_cap_badges_and_tooltips_give_pick_numbers() {
	let outs = run_frame(
		r#"-- Early points: level 30 is the cap, yet the game has given a 22nd point.
TS.learn(b, 21)
TS.currency = { quantity = 1, spent = 21 }
T.Refresh()
stub.runTimers()
local s = T.Current().staged
local nxt = markOf(s.next.node)
local later
for _, p in ipairs(b.picks) do if p.order > s.next.order and s.nodeNext[p.node] == p then later = p break end end
local badges, muted = {}, 0
local mr, mg, mb = Polestar.Theme.Color("textMuted")
for id, m in pairs(O.marks) do
	if m:IsShown() and m.Badge:IsShown() then
		badges[#badges + 1] = m.Badge.Text:GetText()
		local r, g, bl = m.Badge.Text:GetTextColor()
		if r == mr and g == mg and bl == mb then muted = muted + 1 end
	end
end
emit({ ring = nxt:IsShown() and nxt.Ring:IsShown(), badge = nxt.Badge.Text:GetText(), badges = badges, muted = muted, projected = T.Projected ~= nil, status = s.status })
local btn = TS.button(s.next.node)
GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
stub.RunScript(btn, "OnEnter")
emit(GameTooltip.lines)
local other = TS.button(later.node)
GameTooltip:SetOwner(other, "ANCHOR_RIGHT")
stub.RunScript(other, "OnEnter")
emit({ lines = GameTooltip.lines, order = later.order })
Polestar.Set("talents.tooltip", false)
GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
stub.RunScript(btn, "OnEnter")
emit(#GameTooltip.lines)"#,
	);
	assert_eq!(json!([outs[0]["ring"], outs[0]["badge"], outs[0]["status"], outs[0]["projected"]]), json!([true, "22", "behind", false]), "the point at the cap is highlighted");
	for t in outs[0]["badges"].as_array().unwrap() {
		assert!(is_match(t.as_str().unwrap(), r"^\d+$"));
	}
	assert_eq!(outs[0]["muted"], 0, "no badge muted as \"past the cap\"");
	assert_eq!(outs[1].as_array().unwrap().len(), 1);
	assert!(is_match(outs[1][0].as_str().unwrap(), r"^Polestar: pick #22, rank \d/\d \(Retribution plan\)  next$"));
	let line = outs[2]["lines"][0].as_str().unwrap();
	assert!(!is_match(line, r"(?i)level|cap"), "no level or cap wording");
	assert!(is_match(line, &format!(r"^Polestar: pick #{}, rank \d/\d \(Retribution plan\)$", outs[2]["order"])));
	assert_eq!(outs[3], 0);
}

#[test]
fn overlay_nothing_while_inspecting_or_for_another_loadout_combat_defers_the_redraw() {
	let outs = run_frame(
		r#"TS.inspecting = true
EventRegistry:TriggerEvent("TalentFrameBase.ConfigUpdated")
stub.runTimers()
emit(view().marks)
TS.inspecting = nil
TS.frameConfig = 99
EventRegistry:TriggerEvent("TalentFrameBase.ConfigUpdated")
stub.runTimers()
emit(view().marks)
TS.frameConfig = nil
stub.inCombat = true
EventRegistry:TriggerEvent("TalentFrameBase.ConfigUpdated")
stub.runTimers()
emit(view().marks)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.runTimers()
emit(view().marks)
-- Marks up, then inspecting someone mid-fight.
stub.inCombat = true
TS.inspecting = true
EventRegistry:TriggerEvent("TalentFrameBase.ConfigUpdated")
stub.runTimers()
emit(view().marks)
TS.inspecting = nil
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.runTimers()
emit(view().marks)"#,
	);
	assert_eq!(outs[0], 0, "inspecting");
	assert_eq!(outs[1], 0, "another loadout");
	assert_eq!(outs[2], 0, "still hidden: the redraw waits for combat to end");
	assert!(num(&outs[3]) > 0.0, "drawn after combat");
	assert_eq!(outs[4], 0, "marks come down when the frame changes in combat");
	assert!(num(&outs[5]) > 0.0, "and come back after combat");
}

// ------------------------------------------------------------ reminder

#[test]
fn reminder_a_chat_line_when_a_point_waits_from_the_currency_even_below_the_old_schedule_none_when_switched_off() {
	let outs = run(r#"
local b = plan("retribution")
TS.learn(b, 10)
TS.level = 20
stub.login()
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 20)
stub.advance(2)
emit(stub.messages)
-- Talented: level 14, 11 points granted, 10 spent.
TS.level = 14
TS.currency = { quantity = 1, spent = 10 }
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 14)
stub.advance(2)
emit(stub.messages)
-- At the level cap with a point granted.
TS.learn(b, 21)
TS.level, TS.cap = 30, 30
TS.currency = { quantity = 1, spent = 21 }
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 30)
stub.advance(2)
emit(#stub.messages)
-- Nothing granted: nothing to say.
TS.currency = { quantity = 0, spent = 21 }
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 30)
stub.advance(2)
emit(#stub.messages)
TS.currency = { quantity = 1, spent = 21 }
Polestar.Set("talents.reminder", false)
stub.messages = {}
stub.fire("PLAYER_LEVEL_UP", 30)
stub.advance(2)
emit(#stub.messages)"#);
	assert_eq!(outs[0].as_array().unwrap().len(), 1);
	assert!(is_match(outs[0][0].as_str().unwrap(), r"Talent point: Seal of Command 1/1 \(Retribution plan\)\."));
	assert_eq!(outs[1].as_array().unwrap().len(), 1, "an early point is reminded");
	assert!(is_match(outs[1][0].as_str().unwrap(), r"Talent point: Seal of Command 1/1"));
	assert_eq!(outs[2], 1, "not muted at the level cap");
	assert_eq!(outs[3], 0);
	assert_eq!(outs[4], 0);
}

// ------------------------------------------------------------ the hub section

#[test]
fn view_the_talents_section_lists_the_followed_plan_with_its_status_tabs_per_spec_follow_buttons() {
	let outs = run_in(
		r#"
local b = plan("retribution")
TS.learn(b, 20)
uistub = uistub
stub.login()
local TV = Polestar.UI.TalentsSection
TV.Show()
local s = TV.Shown()
local approx, exact = 0, 0
for _, n in ipairs(s.notes) do
	if n:find("^Around level %d+: ") then approx = approx + 1 end
	if n:find("^Level %d+") or n:find("[Bb]y %d%d ") or n:find(" at %d%d ") then exact = exact + 1 end
end
emit({ rows = s.rows, spec = s.spec, mine = s.mine, status = s.status, follow = s.follow, auto = s.auto, notes = #s.notes, first = s.notes[1], noteLevels = approx, exactLevels = exact })
local nav, active = TV.Nav()
local labels = {}
for _, n in ipairs(nav) do labels[#labels + 1] = n.label end
emit({ labels = labels, active = active })
TV.SetTab("1")
s = TV.Shown()
emit({ spec = s.spec, mine = s.mine, status = s.status, follow = s.follow })
TV.Follow()
emit({ choice = T.Choice(), followed = TV.Shown().followed })
TV.FollowSpec()
emit(T.Choice())"#,
		WITH_UI,
		&["stub_ui.lua"],
	);
	let o = &outs[0];
	assert_eq!(
		*o,
		json!({ "rows": 51, "spec": "Retribution", "mine": true, "status": "behind", "follow": true, "auto": false, "notes": o["notes"], "first": o["first"], "noteLevels": o["noteLevels"], "exactLevels": o["exactLevels"] })
	);
	assert!(is_match(o["first"].as_str().unwrap(), r"^1 point to spend\. Next: Vengeance 1/3\.$"), "one point: the talent, not the count");
	assert!(num(&o["notes"]) >= 10.0, "status, summary, the plan notes and the source");
	assert!(num(&o["noteLevels"]) > 0.0, "plan notes give approximate levels");
	assert_eq!(o["exactLevels"], 0, "no exact \"Level N:\" labels");
	assert_eq!(outs[1], json!({ "labels": ["Holy", "Protection", "Retribution"], "active": "3" }));
	assert_eq!(outs[2], json!({ "spec": "Holy", "mine": false, "status": "other", "follow": true }));
	assert_eq!(outs[3], json!({ "choice": "holy", "followed": "Holy" }));
	assert_eq!(outs[4], "auto");
}

#[test]
fn view_every_spec_tab_shows_the_client_s_talent_names_not_only_the_followed_plan() {
	let outs = run_in(
		r#"
for id, n in pairs(TS.nodes) do n.name = "es:" .. n.name end
TS.learn(plan("retribution"), 20)
stub.login()
local TV = Polestar.UI.TalentsSection
TV.Show()
local function english()
	local n = 0
	for _, t in ipairs(TV.Shown().titles) do if not t:find("^es:") then n = n + 1 end end
	return { rows = TV.Shown().rows, mine = TV.Shown().mine, english = n }
end
emit(english())
TV.SetTab("1")
emit(english())
TV.SetTab("2")
emit(english())"#,
		WITH_UI,
		&["stub_ui.lua"],
	);
	assert_eq!(outs[0], json!({ "rows": 51, "mine": true, "english": 0 }));
	assert_eq!(outs[1], json!({ "rows": 51, "mine": false, "english": 0 }), "Holy tab");
	assert_eq!(outs[2], json!({ "rows": 51, "mine": false, "english": 0 }), "Protection tab");
}

#[test]
fn tree_the_mini_tree_opens_on_the_next_pick_steps_one_pick_at_a_time_and_a_list_row_steps_to_it() {
	let outs = run_in(
		r#"
TS.learn(plan("retribution"), 20)
TS.currency = { quantity = 1, spent = 20 }
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local function snap() local s = TV.Shown(); return { cursor = s.tree.cursor, picked = s.tree.picked, row = s.cursorRow, ret = s.tree.points[3] or 0 } end
emit(snap())
TV.StepTo(12)
emit(snap())
TV.StepTo(0)
emit(snap())
TV.StepTo(99)
emit(snap())
TV.SetTab("1")
local s = TV.Shown()
emit({ cursor = s.tree.cursor, holy = s.tree.points[1] or 0, prot = s.tree.points[2] or 0, ret = s.tree.points[3] or 0 })"#,
		WITH_UI,
		&["stub_ui.lua"],
	);
	assert_eq!(outs[0], json!({ "cursor": 21, "picked": 21, "row": 21, "ret": 21 }), "a point waits: the next pick");
	assert_eq!(outs[1], json!({ "cursor": 12, "picked": 12, "row": 12, "ret": 12 }));
	assert_eq!(outs[2], json!({ "cursor": 0, "picked": 0, "row": 0, "ret": 0 }), "clamped at the start");
	assert_eq!(outs[3], json!({ "cursor": 51, "picked": 51, "row": 51, "ret": 41 }), "clamped at the end");
	assert_eq!(outs[4], json!({ "cursor": 51, "holy": 31, "prot": 0, "ret": 20 }), "another plan opens whole, its split per column");
}

#[test]
fn tree_ranks_after_n_picks_and_the_flag_on_ranks_spent_outside_the_plan() {
	let outs = run_in(
		r#"
local b = plan("retribution")
local r = T.Tree.RanksAt(b, 5)
local n = 0
for _ in pairs(r) do n = n + 1 end
emit({ talents = n, count = T.Tree.Count(r), first = r[b.picks[1].node] })
TS.learn(b, 20)
local stray
for id, node in pairs(data.nodes) do if node.spec == 1 and node.row == 1 then stray = id break end end
TS.ranks[stray] = 1
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local t = T.Tree
local flagged = 0
for _, c in ipairs(Polestar.UI.TalentsSection.TreeFrame().cells) do if c:IsShown() and c.Flag:IsShown() then flagged = flagged + 1 end end
emit(flagged)"#,
		WITH_UI,
		&["stub_ui.lua"],
	);
	assert_eq!(outs[0]["count"], 5);
	assert!(num(&outs[0]["talents"]) >= 1.0);
	assert!(num(&outs[0]["first"]) >= 1.0);
	assert_eq!(outs[1], 1, "one talent flagged off-plan");
}

#[test]
fn view_another_class_sees_why_there_is_no_plan() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_talents.lua", "stub_ui.lua"],
		before: r#"stub.talents.class, stub.talents.className = "DEATHKNIGHT", "Death Knight""#.into(),
		addons: vec![Addon::files("Polestar", WITH_UI)],
		login: true,
		script: "Polestar.UI.TalentsSection.Show(); emit(Polestar.UI.TalentsSection.Shown().empty)".into(),
		..Default::default()
	});
	assert_eq!(out[0], "class");
}
