'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const setup = `
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
`;
function run(script, ui = false) {
  return runAddon({ stubs:['stub_world.lua'], addons:[{ name:'Polestar', files: ui ? ['Core/Core.xml','UI/QuestieTurnIns.lua'] : ['Core/Core.xml'] }], login:true, script:setup+script }).emitted;
}

test('turn-in plans use live progress, follow next, and exclude other classes', () => {
  const [out] = run(`emit({past=R.GetTurnIn(1),now=R.GetTurnIn(2),future=R.GetTurnIn(3),other=R.GetTurnIn(4),later=R.GetTurnIn(5),absent=R.GetTurnIn(99)})`);
  assert.equal(out.past.status,'missed'); assert.equal(out.now.status,'now');
  assert.equal(out.future.status,'future'); assert.equal(out.other.status,'unplanned');
  assert.equal(out.later.status,'later'); assert.equal(out.later.title,'Westfall'); assert.equal(out.absent.status,'unplanned');
});
test('skipped hand-ins and completed chapters are not promised as future work', () => {
  const [out] = run(`P.CharState().skipped={ [guideA.id]={ [3]=true } }; local skipped=R.GetTurnIn(3); live=nil; emit({skipped=skipped,done=R.GetTurnIn(2)})`);
  assert.equal(out.skipped.status,'skipped'); assert.equal(out.done.status,'missed');
});
test('a previous chapter hand-in is flagged while unrelated tabs are excluded', () => {
  const [out] = run(`P.Engine.GetGuide=function() return guideB end; live=1; guides.extra={id="extra",steps={{goals={{t="turnin",quest=99}}}}}; emit({past=R.GetTurnIn(3),absent=R.GetTurnIn(99)})`);
  assert.equal(out.past.status,'missed'); assert.equal(out.absent.status,'unplanned');
});
test('route choices require selection and update without reloading', () => {
  const [out] = run(`
    guideA.nextChoices={guideB.id,"route/c"}; guides["route/c"]={id="route/c",title="Other",steps={}}
    local before=R.GetTurnIn(5)
    P.CharState().routes={[guideA.id]=guideB.id}; P.Fire("ROUTE_CHOSEN",guideA.id,guideB.id)
    emit({before=before,after=R.GetTurnIn(5)})
  `);
  assert.equal(out.before.status,'choice'); assert.equal(out.after.status,'later');
});

test('a direct next link to another class does not promise that guide\'s hand-ins', () => {
  const [out] = run(`guideB.classes={"MAGE"}; emit(R.GetTurnIn(5))`);
  assert.equal(out.status,'unplanned');
});

test('missing route-choice data stays unavailable instead of silently choosing a loaded branch', () => {
  const [out] = run(`
    guideA.nextChoices={guideB.id,"route/missing"}
    local unchosen=R.GetTurnIn(5)
    P.CharState().routes={[guideA.id]="route/missing"}; P.Fire("ROUTE_CHOSEN")
    local selected=R.GetTurnIn(5)
    P.CharState().routes={[guideA.id]=guideB.id}; P.Fire("ROUTE_CHOSEN")
    emit({unchosen=unchosen,selected=selected,known=R.GetTurnIn(5)})
  `);
  assert.equal(out.unchosen.status,'unloaded'); assert.equal(out.selected.status,'unloaded');
  assert.equal(out.known.status,'later');
});

test('same-step captions do not promise the current NPC or change progress', () => {
  const [out] = run(`
    table.insert(guideA.steps[2].goals, 1, {t="turnin",quest=77})
    local result=R.GetTurnIn(2)
    emit({description=R.Describe(result),goal=result.goal,live=live,browsing=P.Engine.GetStepIndex()})
  `);
  assert.equal(out.goal,2);
  assert.match(out.description,/Turn in at this step/);
  assert.doesNotMatch(out.description,/Turn in now/);
  assert.equal(out.live,2); assert.equal(out.browsing,4);
});

test('step and goal race/faction filters and optional hand-ins are respected', () => {
  const [out] = run(`
    guideA.steps[3].only={races={"Human"}}
    guideA.steps[2].goals[1].only={factions={"Horde"}}
    guideB.steps[1].optional=true
    emit({race=R.GetTurnIn(3),faction=R.GetTurnIn(2),optional=R.Describe(R.GetTurnIn(5))})
  `);
  assert.equal(out.race.status,'unplanned'); assert.equal(out.faction.status,'unplanned');
  assert.match(out.optional,/Westfall · step 1 \(optional\)/);
});

test('a unique applicable branch is followed and a missing direct guide is unknown', () => {
  const [out] = run(`
    guideA.nextChoices={guideB.id,"route/mage"}
    guides["route/mage"]={id="route/mage",classes={"MAGE"},steps={}}
    local unique=R.GetTurnIn(5)
    guideA.nextChoices=nil; guideA.next="route/missing"; R.Invalidate()
    emit({unique=unique,missing=R.GetTurnIn(5)})
  `);
  assert.equal(out.unique.status,'later'); assert.equal(out.missing.status,'unloaded');
});

test('registration and pack visibility events refresh cached route plans', () => {
  const [out] = run(`
    guides[guideB.id]=nil; local missing=R.GetTurnIn(5)
    guides[guideB.id]=guideB; P.Fire("GUIDES_REGISTERED"); local loaded=R.GetTurnIn(5)
    guides[guideB.id]=nil; P.Fire("PACKS_CHANGED"); local hidden=R.GetTurnIn(5)
    emit({missing=missing,loaded=loaded,hidden=hidden})
  `);
  assert.equal(out.missing.status,'unloaded'); assert.equal(out.loaded.status,'later'); assert.equal(out.hidden.status,'unloaded');
});

test('a future occurrence wins over a skipped occurrence and no active guide is explicit', () => {
  const [out] = run(`
    guideB.steps[1].goals[1].quest=2
    P.CharState().skipped={[guideA.id]={["2:1"]=true}}
    local future=R.GetTurnIn(2)
    P.Engine.GetGuide=function() return nil end
    emit({future=future,none=R.GetTurnIn(2),description=R.Describe(R.GetTurnIn(2))})
  `);
  assert.equal(out.future.status,'later'); assert.equal(out.none.status,'noGuide');
  assert.equal(out.description,'Select a guide to see its turn-in plan');
});

test('turn-in captions use the interface translation table', () => {
  const [out] = run(`
    P.L["step %d"]="Etape %d"; P.L["Turn in at %s"]="Rendre : %s"
    emit(R.Describe(R.GetTurnIn(3)))
  `);
  assert.equal(out,'Rendre : Etape 3');
});

const questie = `
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
`;
test('Questie captions reflow, follow progress, and clear when disabled or pooled', () => {
  const [out] = run(questie+`
    local first=row.label:GetText(); local height=row:GetHeight()
    live=4; I.Refresh(); stub.advance(0.3); local past=row.label:GetText()
    P.Set("routePlan.questie",false); stub.advance(0.3); local disabled=row.label:GetText()
    P.Set("routePlan.questie",true); stub.advance(0.3)
    row.mode="objective"; row.label:SetHeight(10); row.label:SetText("Other objective")
    emit({first=first,height=height,past=past,disabled=disabled,reused=row.label:GetText(),reuseHeight=row.label:GetHeight()})
  `,true);
  assert.match(out.first,/Turn in at step 3/); assert.ok(out.height>=28);
  assert.match(out.past,/Earlier turn-in/); assert.equal(out.disabled,'Ready quest');
  assert.equal(out.reused,'Other objective'); assert.equal(out.reuseHeight,10);
});
test('Questie layout changes defer in combat and annotations disappear when no longer ready', () => {
  const [out] = run(questie+`
    local before=updates; stub.inCombat=true; live=4; I.Refresh(); stub.advance(1)
    local during=updates; stub.inCombat=false; stub.world.progress(3,1,0); stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.3)
    emit({before=before,during=during,after=updates,text=row.label:GetText(),height=row.label:GetHeight()})
  `,true);
  assert.equal(out.before,out.during); assert.ok(out.after>out.during);
  assert.equal(out.text,'Ready quest'); assert.equal(out.height,12);
});

test('Questie final width pass reflows both the caption and parent row while preserving its padding', () => {
  const [out] = run(questie+`
    local wide=row:GetHeight()
    -- Questie UpdateFormatting runs this after the title row height was set.
    row.label:SetWidth(80)
    local narrow={label=row.label:GetHeight(),row=row:GetHeight()}
    row.label:SetWidth(250)
    emit({wide=wide,narrow=narrow,restored=row:GetHeight(),text=row.label:GetText()})
  `,true);
  assert.ok(out.narrow.row>out.wide, 'wrapped captions expand the row before the next quest is positioned');
  assert.equal(out.narrow.row,out.narrow.label+4, 'Questie owns the row padding');
  assert.equal(out.restored,out.wide, 'widening releases obsolete wrapped height');
  assert.match(out.text,/Polestar: Turn in at step 3/);
});

test('a Questie row without a caption keeps the heights Questie gives it', () => {
  const [out] = run(questie+`
    stub.world.progress(3,1,0); stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.3)
    local cleared=row.label:GetText()
    -- Questie lays the row out itself (a title that wraps), then its final width pass.
    row.label:SetHeight(30); row:SetHeight(34); row.label:SetWidth(80)
    emit({cleared=cleared,label=row.label:GetHeight(),row=row:GetHeight()})
  `,true);
  assert.equal(out.cleared,'Ready quest');
  assert.equal(out.label,30); assert.equal(out.row,34);
});

test('unchanged quest-log updates do not rebuild Questie while changed captions still do', () => {
  const [out] = run(questie+`
    local initial=updates
    for i=1,5 do stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.3) end
    local unchanged=updates
    live=4; P.Fire("STEP_CHANGED"); stub.advance(0.3)
    local changed=updates
    live=2; P.Fire("STEP_CHANGED"); tracker:Update(); local natural=updates; stub.advance(0.3)
    emit({initial=initial,unchanged=unchanged,changed=changed,natural=natural,after=updates,text=row.label:GetText()})
  `,true);
  assert.equal(out.unchanged,out.initial, 'quest counts and inventory updates without caption changes do not rebuild');
  assert.equal(out.changed,out.initial+1, 'guide progress changes still reflow the tracker');
  assert.equal(out.after,out.natural, 'Questie\'s own update already applied the new caption');
  assert.match(out.text,/Turn in at step 3/);
});

test('skipping a single hand-in refreshes its caption without changing the numbered step', () => {
  const [out] = run(questie+`
    live=3; I.Refresh(); stub.advance(0.3)
    local before=row.label:GetText()
    P.CharState().skipped={[guideA.id]={["3:1"]=true}}
    P.Fire("STEP_UPDATED",3); stub.advance(0.3)
    emit({before=before,after=row.label:GetText(),live=live})
  `,true);
  assert.match(out.before,/Turn in at this step/);
  assert.match(out.after,/Skipped turn-in/);
  assert.equal(out.live,3);
});

test('Questie integration is opt-in and missing or unsupported modules are safe', () => {
  const [out] = run(`
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
  `,true);
  assert.equal(out.disabled,false); assert.equal(out.before,0);
  assert.equal(out.unavailable,false); assert.equal(out.unsupported,false); assert.equal(out.absent,false);
});

test('completed client quests get captions without LiveCharacter; removed quests lose them', () => {
  const [out] = run(questie+`
    assert(P.LiveCharacter==nil)
    local before=row.label:GetText()
    stub.world.turnIn(3); stub.advance(0.3)
    emit({before=before,after=row.label:GetText()})
  `,true);
  assert.match(out.before,/Turn in at step 3/); assert.equal(out.after,'Ready quest');
});

test('unsupported or failed quest-read APIs remove stale captions safely', () => {
  const [out] = run(questie+`
    C_QuestLog.ReadyForTurnIn=function() error("unsupported quest read") end
    I.Refresh(); stub.advance(0.3); local failed=row.label:GetText()
    C_QuestLog=nil; I.Refresh(); stub.advance(0.3)
    emit({failed=failed,missing=row.label:GetText()})
  `,true);
  assert.equal(out.failed,'Ready quest'); assert.equal(out.missing,'Ready quest');
});

test('pooled title rows drop old captions and retain Questie title formatting', () => {
  const [out] = run(questie+`
    row.label:SetText("|cff00ff00Ready quest|r")
    local formatted=row.label:GetText()
    row.label:SetText(formatted)
    local repeated=row.label:GetText()
    row.Quest={Id=99}; row.label:SetText("Different quest")
    emit({formatted=formatted,repeated=repeated,pooled=row.label:GetText()})
  `,true);
  assert.match(out.formatted,/^\|cff00ff00Ready quest\|r\n/);
  assert.equal(out.repeated,out.formatted); assert.equal(out.pooled,'Different quest');
});

test('unsupported pooled rows are ignored without affecting normal rows', () => {
  const [out] = run(questie+`
    pool.AddQuestLine(3,{label={}})
    pool.UpdateQuestTitleLines=function(fn) fn({mode="quest",label={}}); fn(row) end
    I.Refresh(); stub.advance(0.3)
    emit(row.label:GetText())
  `,true);
  assert.match(out,/Turn in at step 3/);
});

test('clearing the active guide removes existing captions', () => {
  const [out] = run(questie+`
    P.Engine.GetGuide=function() return nil end
    P.Fire("GUIDE_CHANGED"); stub.advance(0.3)
    emit(row.label:GetText())
  `,true);
  assert.equal(out,'Ready quest');
});

test('resetting integration settings removes captions and restores the opt-in default', () => {
  const [out] = run(questie+`
    P.ResetSettings("routePlan"); stub.advance(0.3)
    emit({enabled=P.Get("routePlan.questie"),text=row.label:GetText()})
  `,true);
  assert.equal(out.enabled,false); assert.equal(out.text,'Ready quest');
});
