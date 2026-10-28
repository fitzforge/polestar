use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const SETUP: &str = r#"
local P = Polestar
local guideA = { id = "route/a", title = "Starter", next = "route/b", steps = {
 { goals = {{ t="turnin", quest=1 }} },
 { goals = {{ t="turnin", quest=2 }} },
 { goals = {{ t="turnin", quest=3 }} },
 { goals = {{ t="turnin", quest=4, only={ classes={"MAGE"} } }} },
} }
local guideB = { id="route/b", title="Westfall", steps={ { goals={{t="turnin",quest=5}} } } }
local guides = { [guideA.id]=guideA, [guideB.id]=guideB }
P.Guides.Get = function(id) return guides[id] end
P.Guides.List = function() return {guideA,guideB} end
P.Compat.GetPlayerInfo = function() return {cls="DRUID", class="DRUID", race="NightElf", faction="Alliance"} end
P.Engine.GetGuide = function() return guideA end
local live = 2
P.Engine.GetLiveStep = function() return live end
P.Engine.GetStepIndex = function() return 4 end
local R = P.RoutePlan
"#;

fn run(script: &str, ui: bool) -> Value {
	let files: &[&str] = if ui { &["Core/Core.xml", "UI/QuestieTurnIns.lua"] } else { &["Core/Core.xml"] };
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::files("Polestar", files)], login: true, script: format!("{SETUP}{script}"), ..Default::default() }).remove(0)
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

#[test]
fn turn_in_plans_use_live_progress_follow_next_and_exclude_other_classes() {
	let out = run("emit({past=R.GetTurnIn(1),now=R.GetTurnIn(2),future=R.GetTurnIn(3),other=R.GetTurnIn(4),later=R.GetTurnIn(5),absent=R.GetTurnIn(99)})", false);
	assert_eq!(out["past"]["status"], "missed");
	assert_eq!(out["now"]["status"], "now");
	assert_eq!(out["future"]["status"], "future");
	assert_eq!(out["other"]["status"], "unplanned");
	assert_eq!(out["later"]["status"], "later");
	assert_eq!(out["later"]["title"], "Westfall");
	assert_eq!(out["absent"]["status"], "unplanned");
}

#[test]
fn skipped_hand_ins_and_completed_chapters_are_not_promised_as_future_work() {
	let out = run("P.CharState().skipped={ [guideA.id]={ [3]=true } }; local skipped=R.GetTurnIn(3); live=nil; emit({skipped=skipped,done=R.GetTurnIn(2)})", false);
	assert_eq!(out["skipped"]["status"], "skipped");
	assert_eq!(out["done"]["status"], "missed");
}

#[test]
fn a_previous_chapter_hand_in_is_flagged_while_unrelated_tabs_are_excluded() {
	let out =
		run(r#"P.Engine.GetGuide=function() return guideB end; live=1; guides.extra={id="extra",steps={{goals={{t="turnin",quest=99}}}}}; emit({past=R.GetTurnIn(3),absent=R.GetTurnIn(99)})"#, false);
	assert_eq!(out["past"]["status"], "missed");
	assert_eq!(out["absent"]["status"], "unplanned");
}

#[test]
fn route_choices_require_selection_and_update_without_reloading() {
	let out = run(
		r#"
    guideA.nextChoices={guideB.id,"route/c"}; guides["route/c"]={id="route/c",title="Other",steps={}}
    local before=R.GetTurnIn(5)
    P.CharState().routes={[guideA.id]=guideB.id}; P.Fire("ROUTE_CHOSEN",guideA.id,guideB.id)
    emit({before=before,after=R.GetTurnIn(5)})
  "#,
		false,
	);
	assert_eq!(out["before"]["status"], "choice");
	assert_eq!(out["after"]["status"], "later");
}

#[test]
fn a_direct_next_link_to_another_class_does_not_promise_that_guide_s_hand_ins() {
	let out = run(r#"guideB.classes={"MAGE"}; emit(R.GetTurnIn(5))"#, false);
	assert_eq!(out["status"], "unplanned");
}

#[test]
fn missing_route_choice_data_stays_unavailable_instead_of_silently_choosing_a_loaded_branch() {
	let out = run(
		r#"
    guideA.nextChoices={guideB.id,"route/missing"}
    local unchosen=R.GetTurnIn(5)
    P.CharState().routes={[guideA.id]="route/missing"}; P.Fire("ROUTE_CHOSEN")
    local selected=R.GetTurnIn(5)
    P.CharState().routes={[guideA.id]=guideB.id}; P.Fire("ROUTE_CHOSEN")
    emit({unchosen=unchosen,selected=selected,known=R.GetTurnIn(5)})
  "#,
		false,
	);
	assert_eq!(out["unchosen"]["status"], "unloaded");
	assert_eq!(out["selected"]["status"], "unloaded");
	assert_eq!(out["known"]["status"], "later");
}

#[test]
fn same_step_captions_do_not_promise_the_current_npc_or_change_progress() {
	let out = run(
		r#"
    table.insert(guideA.steps[2].goals, 1, {t="turnin",quest=77})
    local result=R.GetTurnIn(2)
    emit({description=R.Describe(result),goal=result.goal,live=live,browsing=P.Engine.GetStepIndex()})
  "#,
		false,
	);
	assert_eq!(out["goal"], 2);
	assert!(is_match(text(&out["description"]), r"Turn in at this step"));
	assert!(!is_match(text(&out["description"]), r"Turn in now"));
	assert_eq!(out["live"], 2);
	assert_eq!(out["browsing"], 4);
}

#[test]
fn step_and_goal_race_faction_filters_and_optional_hand_ins_are_respected() {
	let out = run(
		r#"
    guideA.steps[3].only={races={"Human"}}
    guideA.steps[2].goals[1].only={factions={"Horde"}}
    guideB.steps[1].optional=true
    emit({race=R.GetTurnIn(3),faction=R.GetTurnIn(2),optional=R.Describe(R.GetTurnIn(5))})
  "#,
		false,
	);
	assert_eq!(out["race"]["status"], "unplanned");
	assert_eq!(out["faction"]["status"], "unplanned");
	assert!(is_match(text(&out["optional"]), r"Westfall · step 1 \(optional\)"));
}

#[test]
fn a_unique_applicable_branch_is_followed_and_a_missing_direct_guide_is_unknown() {
	let out = run(
		r#"
    guideA.nextChoices={guideB.id,"route/mage"}
    guides["route/mage"]={id="route/mage",classes={"MAGE"},steps={}}
    local unique=R.GetTurnIn(5)
    guideA.nextChoices=nil; guideA.next="route/missing"; R.Invalidate()
    emit({unique=unique,missing=R.GetTurnIn(5)})
  "#,
		false,
	);
	assert_eq!(out["unique"]["status"], "later");
	assert_eq!(out["missing"]["status"], "unloaded");
}

#[test]
fn registration_and_pack_visibility_events_refresh_cached_route_plans() {
	let out = run(
		r#"
    guides[guideB.id]=nil; local missing=R.GetTurnIn(5)
    guides[guideB.id]=guideB; P.Fire("GUIDES_REGISTERED"); local loaded=R.GetTurnIn(5)
    guides[guideB.id]=nil; P.Fire("PACKS_CHANGED"); local hidden=R.GetTurnIn(5)
    emit({missing=missing,loaded=loaded,hidden=hidden})
  "#,
		false,
	);
	assert_eq!(out["missing"]["status"], "unloaded");
	assert_eq!(out["loaded"]["status"], "later");
	assert_eq!(out["hidden"]["status"], "unloaded");
}

#[test]
fn a_future_occurrence_wins_over_a_skipped_occurrence_and_no_active_guide_is_explicit() {
	let out = run(
		r#"
    guideB.steps[1].goals[1].quest=2
    P.CharState().skipped={[guideA.id]={["2:1"]=true}}
    local future=R.GetTurnIn(2)
    P.Engine.GetGuide=function() return nil end
    emit({future=future,none=R.GetTurnIn(2),description=R.Describe(R.GetTurnIn(2))})
  "#,
		false,
	);
	assert_eq!(out["future"]["status"], "later");
	assert_eq!(out["none"]["status"], "noGuide");
	assert_eq!(out["description"], "Select a guide to see its turn-in plan");
}

#[test]
fn turn_in_captions_use_the_interface_translation_table() {
	let out = run(
		r#"
    P.L["step %d"]="Etape %d"; P.L["Turn in at %s"]="Rendre : %s"
    emit(R.Describe(R.GetTurnIn(3)))
  "#,
		false,
	);
	assert_eq!(out, "Rendre : Etape 3");
}

const QUESTIE: &str = r#"
local row=CreateFrame("Button"); row.label=row:CreateFontString(); row.label:SetFont("font",12); row.label:SetHeight(12); row.label:SetWidth(250)
stub.world.onQuest(3, {{required=1,fulfilled=1}})
P.Set("routePlan.questie",true)
local updates=0
local pool={ AddQuestLine=function() end, UpdateQuestTitleLines=function(fn) if row.mode=="quest" then fn(row) end end,
  GetCurrentLine=function() return row end, GetQuestTitleLine=function(q) row.mode="quest"; row.Quest=q; return row end }
local tracker={Update=function()
 updates=updates+1
 local line=pool.GetQuestTitleLine({Id=3}); line.label:SetHeight(12); line.label:SetText("Ready quest"); line.label:SetWidth(250); line:SetHeight(line.label:GetHeight()+4)
end}
QuestieLoader={ImportModule=function(_,name) if name=="TrackerLinePool" then return pool else return tracker end end}
local I=P.QuestieTurnIns
assert(I.Connect())
tracker:Update()
"#;

fn questie(script: &str) -> Value {
	run(&format!("{QUESTIE}{script}"), true)
}

#[test]
fn questie_captions_reflow_follow_progress_and_clear_when_disabled_or_pooled() {
	let out = questie(
		r#"
    local first=row.label:GetText(); local height=row:GetHeight()
    live=4; I.Refresh(); stub.advance(0.3); local past=row.label:GetText()
    P.Set("routePlan.questie",false); stub.advance(0.3); local disabled=row.label:GetText()
    P.Set("routePlan.questie",true); stub.advance(0.3)
    row.mode="objective"; row.label:SetHeight(10); row.label:SetText("Other objective")
    emit({first=first,height=height,past=past,disabled=disabled,reused=row.label:GetText(),reuseHeight=row.label:GetHeight()})
  "#,
	);
	assert!(is_match(text(&out["first"]), r"Turn in at step 3"));
	assert!(num(&out["height"]) >= 28.0);
	assert!(is_match(text(&out["past"]), r"Earlier turn-in"));
	assert_eq!(out["disabled"], "Ready quest");
	assert_eq!(out["reused"], "Other objective");
	assert_eq!(out["reuseHeight"], 10);
}

#[test]
fn questie_layout_changes_defer_in_combat_and_annotations_disappear_when_no_longer_ready() {
	let out = questie(
		r#"
    local before=updates; stub.inCombat=true; live=4; I.Refresh(); stub.advance(1)
    local during=updates; stub.inCombat=false; stub.world.progress(3,1,0); stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.3)
    emit({before=before,during=during,after=updates,text=row.label:GetText(),height=row.label:GetHeight()})
  "#,
	);
	assert_eq!(out["before"], out["during"]);
	assert!(num(&out["after"]) > num(&out["during"]));
	assert_eq!(out["text"], "Ready quest");
	assert_eq!(out["height"], 12);
}

#[test]
fn questie_final_width_pass_reflows_both_the_caption_and_parent_row_while_preserving_its_padding() {
	let out = questie(
		r#"
    local wide=row:GetHeight()
    -- Questie UpdateFormatting runs this after the title row height was set.
    row.label:SetWidth(80)
    local narrow={label=row.label:GetHeight(),row=row:GetHeight()}
    row.label:SetWidth(250)
    emit({wide=wide,narrow=narrow,restored=row:GetHeight(),text=row.label:GetText()})
  "#,
	);
	assert!(num(&out["narrow"]["row"]) > num(&out["wide"]), "wrapped captions expand the row before the next quest is positioned");
	assert_eq!(num(&out["narrow"]["row"]), num(&out["narrow"]["label"]) + 4.0, "Questie owns the row padding");
	assert_eq!(out["restored"], out["wide"], "widening releases obsolete wrapped height");
	assert!(is_match(text(&out["text"]), r"Polestar: Turn in at step 3"));
}

#[test]
fn a_questie_row_without_a_caption_keeps_the_heights_questie_gives_it() {
	let out = questie(
		r#"
    stub.world.progress(3,1,0); stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.3)
    local cleared=row.label:GetText()
    -- Questie lays the row out itself (a title that wraps), then its final width pass.
    row.label:SetHeight(30); row:SetHeight(34); row.label:SetWidth(80)
    emit({cleared=cleared,label=row.label:GetHeight(),row=row:GetHeight()})
  "#,
	);
	assert_eq!(out["cleared"], "Ready quest");
	assert_eq!(out["label"], 30);
	assert_eq!(out["row"], 34);
}

#[test]
fn unchanged_quest_log_updates_do_not_rebuild_questie_while_changed_captions_still_do() {
	let out = questie(
		r#"
    local initial=updates
    for i=1,5 do stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.3) end
    local unchanged=updates
    live=4; P.Fire("STEP_CHANGED"); stub.advance(0.3)
    local changed=updates
    live=2; P.Fire("STEP_CHANGED"); tracker:Update(); local natural=updates; stub.advance(0.3)
    emit({initial=initial,unchanged=unchanged,changed=changed,natural=natural,after=updates,text=row.label:GetText()})
  "#,
	);
	assert_eq!(out["unchanged"], out["initial"], "quest counts and inventory updates without caption changes do not rebuild");
	assert_eq!(num(&out["changed"]), num(&out["initial"]) + 1.0, "guide progress changes still reflow the tracker");
	assert_eq!(out["after"], out["natural"], "Questie's own update already applied the new caption");
	assert!(is_match(text(&out["text"]), r"Turn in at step 3"));
}

#[test]
fn a_questie_update_dropped_by_its_0_1_s_throttle_is_retried_once_not_polled_and_waits_out_combat_341() {
	let out = questie(
		r#"
    -- Questie 12.1.0: QuestieTracker:Update() returns within 0.1 s of the last one.
    local draw, last = tracker.Update, -1
    tracker.Update=function(self) local now=GetTime(); if now-last<0.1 then return end; last=now; draw(self) end
    local function caught() last=GetTime()+0.2-0.05 end -- Questie redraws 0.05 s before Polestar's pass
    stub.advance(1)
    caught(); live=4; P.Fire("STEP_CHANGED"); stub.advance(0.25)
    local first=row.label:GetText()
    stub.advance(0.25); local retried=row.label:GetText(); local u=updates
    stub.advance(5); local idle=updates
    -- every attempt throttled: one retry, then left to Questie's next redraw
    tracker.Update=function() end
    local calls=0; local inner=tracker.Update; tracker.Update=function(self) calls=calls+1; inner(self) end
    live=2; P.Fire("STEP_CHANGED"); stub.advance(5)
    local bounded=calls
    -- the caption is still stale (step 3 expected); the retry falls in combat
    tracker.Update=function(self) local now=GetTime(); if now-last<0.1 then return end; last=now; draw(self) end
    caught(); P.Fire("STEP_CHANGED"); stub.advance(0.25); stub.inCombat=true; stub.advance(1)
    local inCombat=row.label:GetText(); stub.inCombat=false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.3)
    emit({first=first,retried=retried,u=u,idle=idle,bounded=bounded,inCombat=inCombat,after=row.label:GetText()})
  "#,
	);
	assert!(is_match(text(&out["first"]), r"Turn in at step 3"), "the throttled update left the caption stale");
	assert!(is_match(text(&out["retried"]), r"Earlier turn-in"), "the retry draws it");
	assert_eq!(out["idle"], out["u"], "nothing polls afterwards");
	assert_eq!(out["bounded"], 2, "one update and one retry");
	assert!(is_match(text(&out["inCombat"]), r"Earlier turn-in"), "no update in combat");
	assert!(is_match(text(&out["after"]), r"Turn in at step 3"), "drawn once combat ends");
}

#[test]
fn skipping_a_single_hand_in_refreshes_its_caption_without_changing_the_numbered_step() {
	let out = questie(
		r#"
    live=3; I.Refresh(); stub.advance(0.3)
    local before=row.label:GetText()
    P.CharState().skipped={[guideA.id]={["3:1"]=true}}
    P.Fire("STEP_UPDATED",3); stub.advance(0.3)
    emit({before=before,after=row.label:GetText(),live=live})
  "#,
	);
	assert!(is_match(text(&out["before"]), r"Turn in at this step"));
	assert!(is_match(text(&out["after"]), r"Skipped turn-in"));
	assert_eq!(out["live"], 3);
}

#[test]
fn questie_integration_is_opt_in_and_missing_or_unsupported_modules_are_safe() {
	let out = run(
		r#"
    local imports=0
    QuestieLoader={ImportModule=function() imports=imports+1; error("not available") end}
    local I=P.QuestieTurnIns
    local disabled=I.Connect(); local before=imports
    P.Set("routePlan.questie",true)
    local unavailable=I.Connect()
    QuestieLoader.ImportModule=function() return {} end
    local unsupported=I.Connect()
    QuestieLoader=nil; local absent=I.Connect()
    emit({disabled=disabled,before=before,unavailable=unavailable,unsupported=unsupported,absent=absent})
  "#,
		true,
	);
	assert_eq!(out["disabled"], false);
	assert_eq!(out["before"], 0);
	assert_eq!(out["unavailable"], false);
	assert_eq!(out["unsupported"], false);
	assert_eq!(out["absent"], false);
}

#[test]
fn completed_client_quests_get_captions_without_livecharacter_removed_quests_lose_them() {
	let out = questie(
		r#"
    assert(P.LiveCharacter==nil)
    local before=row.label:GetText()
    stub.world.turnIn(3); stub.advance(0.3)
    emit({before=before,after=row.label:GetText()})
  "#,
	);
	assert!(is_match(text(&out["before"]), r"Turn in at step 3"));
	assert_eq!(out["after"], "Ready quest");
}

#[test]
fn unsupported_or_failed_quest_read_apis_remove_stale_captions_safely() {
	let out = questie(
		r#"
    C_QuestLog.ReadyForTurnIn=function() error("unsupported quest read") end
    I.Refresh(); stub.advance(0.3); local failed=row.label:GetText()
    C_QuestLog=nil; I.Refresh(); stub.advance(0.3)
    emit({failed=failed,missing=row.label:GetText()})
  "#,
	);
	assert_eq!(out["failed"], "Ready quest");
	assert_eq!(out["missing"], "Ready quest");
}

#[test]
fn pooled_title_rows_drop_old_captions_and_retain_questie_title_formatting() {
	let out = questie(
		r#"
    row.label:SetText("|cff00ff00Ready quest|r")
    local formatted=row.label:GetText()
    row.label:SetText(formatted)
    local repeated=row.label:GetText()
    row.Quest={Id=99}; row.label:SetText("Different quest")
    emit({formatted=formatted,repeated=repeated,pooled=row.label:GetText()})
  "#,
	);
	assert!(is_match(text(&out["formatted"]), r"^\|cff00ff00Ready quest\|r\n"));
	assert_eq!(out["repeated"], out["formatted"]);
	assert_eq!(out["pooled"], "Different quest");
}

#[test]
fn unsupported_pooled_rows_are_ignored_without_affecting_normal_rows() {
	let out = questie(
		r#"
    pool.AddQuestLine(3,{label={}})
    pool.UpdateQuestTitleLines=function(fn) fn({mode="quest",label={}}); fn(row) end
    I.Refresh(); stub.advance(0.3)
    emit(row.label:GetText())
  "#,
	);
	assert!(is_match(text(&out), r"Turn in at step 3"));
}

#[test]
fn clearing_the_active_guide_removes_existing_captions() {
	let out = questie(
		r#"
    P.Engine.GetGuide=function() return nil end
    P.Fire("GUIDE_CHANGED"); stub.advance(0.3)
    emit(row.label:GetText())
  "#,
	);
	assert_eq!(out, "Ready quest");
}

#[test]
fn resetting_integration_settings_removes_captions_and_restores_the_opt_in_default() {
	let out = questie(
		r#"
    P.ResetSettings("routePlan"); stub.advance(0.3)
    emit({enabled=P.Get("routePlan.questie"),text=row.label:GetText()})
  "#,
	);
	assert_eq!(out["enabled"], false);
	assert_eq!(out["text"], "Ready quest");
}

#[test]
fn a_next_option_with_when_is_decided_at_the_hand_off_the_plan_waits_unless_the_remembered_choice_is_an_unconditional_option() {
	let out = run(
		r#"
    guides["route/c"]={id="route/c",title="Other",steps={}}
    guideA.nextChoices={guideB.id}; guideA.nextWhen={[guideB.id]={{k="level",op=">=",n=10}}}
    local alone=R.GetTurnIn(5)
    guideA.nextChoices={guideB.id,"route/c"}; guideA.nextWhen={["route/c"]={{k="level",op="<",n=10}}}; P.Fire("ROUTE_CHOSEN")
    local unchosen=R.GetTurnIn(5)
    P.CharState().routes={[guideA.id]=guideB.id}; P.Fire("ROUTE_CHOSEN")
    local chosen=R.GetTurnIn(5)
    P.CharState().routes={[guideA.id]="route/c"}; P.Fire("ROUTE_CHOSEN")
    emit({alone=alone.status,unchosen=unchosen.status,chosen=chosen.status,conditional=R.GetTurnIn(5).status})
  "#,
		false,
	);
	assert_eq!(out, json!({ "alone": "choice", "unchosen": "choice", "chosen": "later", "conditional": "choice" }));
}

// The quest log's room: quests 1 (hand-in passed), 3 (ahead), 5 (next guide) and 77 (no hand-in on the
// route) fill a log of 4; the live step takes quests 10 and 11.
const ROOM: &str = r#"
    local w = stub.world
    w.onQuest(1, {}, "One"); w.onQuest(3, {}, "Three"); w.onQuest(5, {}, "Five"); w.onQuest(77, {}, "Stray")
    local cap = 4
    C_QuestLog.GetMaxNumQuestsCanAccept = function() return cap end
    local accepts = { { t="accept", quest=10, status="active" }, { t="accept", quest=11, status="active" } }
    P.Engine.GetStepView = function(i) if i == live then return { goals = accepts } end end
    local function titles(list) local out = {} for i, d in ipairs(list or {}) do out[i] = d.title end return out end
"#;

#[test]
fn the_route_s_unneeded_quests_are_the_ones_it_never_hands_in_and_none_while_a_choice_is_open() {
	let out = run(
		&format!(
			"{ROOM}{}",
			r#"
    local list = R.Unneeded()
    local open = { titles(list), list[1].status, list[2].status }
    guideA.nextChoices={guideB.id,"route/c"}; guides["route/c"]={id="route/c",title="Other",steps={}}; P.Fire("ROUTE_CHOSEN")
    emit({ open = open, undecided = R.Unneeded() == nil })
  "#
		),
		false,
	);
	assert_eq!(out, json!({ "open": [["One", "Stray"], "missed", "unplanned"], "undecided": true }));
}

#[test]
fn an_accept_step_past_the_log_s_cap_names_what_to_drop_unneeded_first_then_the_latest_hand_in() {
	let out = run(
		&format!(
			"{ROOM}{}",
			r#"
    local full = R.LogOverflow()
    cap = 5
    local one = R.LogOverflow()
    w.abandon(1); w.abandon(77); cap = 3
    local later = R.LogOverflow()
    cap = 6
    local fits = R.LogOverflow()
    emit({ full = { full.take, full.free, titles(full.drop) }, one = titles(one.drop), later = titles(later.drop), fits = fits == nil })
  "#
		),
		false,
	);
	assert_eq!(out, json!({ "full": [2, 0, ["One", "Stray"]], "one": ["One"], "later": ["Five"], "fits": true }));
}
