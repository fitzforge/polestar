'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml'];
const FIXTURE = `
local E, R, w = Polestar.Engine, Polestar.CombinedRoute, stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "test/main", pack = "test", title = "Leveling", faction = "Alliance", steps = {
	{ title = "Main work", zone = "Elwynn Forest", goals = { { t = "interact", object = 1, objName = "Test object", text = "Main task", map = 1429, x = 60, y = 80 } } },
	{ title = "Next work", zone = "Elwynn Forest", goals = { { t = "interact", object = 1, objName = "Test object", text = "Next task", map = 1429, x = 70, y = 80 } } },
} })
Polestar.RegisterGuide({ id = "test/class", pack = "test", title = "Class quest", category = "Class", steps = {
	{ title = "Class work", zone = "Elwynn Forest", goals = { { t = "interact", object = 1, objName = "Test object", text = "Class task", map = 1429, x = 40, y = 80 } } },
	{ title = "Later class", zone = "Elwynn Forest", goals = { { t = "interact", object = 1, objName = "Test object", text = "Do not do this early", map = 1429, x = 41, y = 80 } } },
} })
stub.login()
assert(Polestar.Guides.Get("test/main"), "main guide registered: " .. table.concat(stub.messages,"|"))
assert(E.OpenTab("test/main"), "main tab opened")
E.OpenTab("test/class", false)
Polestar.Nav = Polestar.Nav or {}
Polestar.Nav.EstimateTravel = function(a, b) return math.abs((a and a.x or 20) - b.x) end
function settle() for i = 1, 80 do stub.advance(.05) end end
`;

function run(script, files = FILES, extra = {}) {
	return runAddon({ stubs: ['stub_world.lua'], addons: [{ name: 'Polestar', files }], script: FIXTURE + script, ...extra }).emitted;
}

test('combined route weaves a class objective without activating its tab and preserves independent progress', () => {
	const [out] = run(`
	R.SetMain("test/main"); R.Add("test/class"); settle()
	local p = R.View()
	local wp = E.GetWaypoint()
	local first = p.rows[1]
	local guide = E.GetGuide().id
	E.CombinedAction(first.ref, "toggle"); settle()
	emit({ first = first.title, target = wp.guideId, guide = guide, nextGuide = E.GetGuide().id,
			mainStep = E.GetTabs()[1].stepIndex, classStep = E.GetTabs()[2].stepIndex,
			source = first.ref.guideId, count = #p.rows })
	`);
	assert.equal(out.first, 'Class quest');
	assert.equal(out.target, 'test/class');
	assert.equal(out.guide, 'test/main');
	assert.equal(out.nextGuide, 'test/main');
	assert.equal(out.mainStep, 1);
	assert.equal(out.classStep, 2);
	assert.equal(out.source, 'test/class');
});

test('tab browsing preserves route ownership; manual aiming pauses and resume restores it', () => {
	const [out] = run(`
	R.SetMain("test/main"); R.Add("test/class"); settle()
	local first = E.GetWaypoint().guideId
	E.SelectTab(2); settle()
	local browsed = E.GetWaypoint().guideId
	E.CombinedAction(R.View().rows[1].ref, "aim"); settle()
	local paused = R.State().paused
	R.Resume(); settle()
	emit({ first = first, browsed = browsed, paused = paused, resumed = not R.State().paused, main = R.State().main })
	`);
	assert.deepEqual(out, { first: 'test/class', browsed: 'test/class', paused: true, resumed: true, main: 'test/main' });
});

const PURE = `
local R = Polestar.CombinedRoute
local function row(key, x, main, semantic)
	return { key = key, ref = { guideId = key }, title = key, semantic = semantic, main = main, ready = true, waypoint = { map = 1, x = x, y = 0 } }
end
local function cost(a,b) return math.abs((a and a.x or 0) - b.x) end
`;
function pure(script) {
	return runAddon({ addons: [{ name: 'Polestar', files: FILES }], script: PURE + script }).emitted[0];
}

test('insertion budget is cumulative and unknown estimates defer work', () => {
	const out = pure(`
	local s = { row("main", 100, true), row("a", -40), row("b", -70) }
	local p = R.Build(s, cost, 100, 0)
	local u = R.Build({row("main", 100, true),row("unknown", 30)}, function() return nil end, 300, 0)
	emit({ first = p.rows[1].key, added = p.addedTravel, last = p.rows[3].reason, unknown = u.rows[2].reason })
	`);
	assert.equal(out.first, 'a');
	assert.equal(out.added, 80);
	assert.equal(out.last, 'Outside added-travel budget');
	assert.equal(out.unknown, 'Travel estimate unavailable');
});

test('shared quest objectives are displayed once and retain every source reference', () => {
	const out = pure(`
	local p = R.Build({ row("main", 100, true, "783:kill:1"), row("class", 100, false, "783:kill:1") }, cost, 300, 0)
	emit({ count = #p.rows, sources = #p.rows[1].refs, titles = p.rows[1].titles })
	`);
	assert.deepEqual(out, { count: 1, sources: 2, titles: ['main', 'class'] });
});

test('a selected destination remains stable when another nearby choice becomes cheaper', () => {
	const out = pure(`
	local p = R.Build({ row("main", 100, true), row("a", 30), row("b", 40) }, cost, 300, 0, "b")
	emit(p.rows[1].key)
	`);
	assert.equal(out, 'b');
});

test('closing the main guide disables combined routing without altering other progress', () => {
	const [out] = run(`R.SetMain("test/main"); R.Add("test/class"); settle(); E.CloseTab(1); settle(); emit({ enabled = R.Enabled() or false, guide = E.GetGuide().id })`);
	assert.deepEqual(out, { enabled: false, guide: 'test/class' });
});

const COMMITMENTS = `
Polestar.RegisterGuide({ id = "test/escort", pack = "test", title = "Escort", category = "Class", steps = {
	{ goals = { { t = "accept", quest = 783, title = "Escort test", npc = 1, npcName = "Test", escort = true, map = 1429, x = 30, y = 80 } } },
	{ goals = { { t = "complete", quest = 783, title = "Escort test", escort = true, map = 1429, x = 31, y = 80 } } },
} })
Polestar.RegisterGuide({ id = "test/timed", pack = "test", title = "Timed", steps = {
	{ goals = { { t = "accept", quest = 7, title = "Timed test", npc = 2, npcName = "Test", limit = 60, map = 1429, x = 32, y = 80 } } },
} })
Polestar.RegisterGuide({ id = "test/dungeon", pack = "test", title = "Dungeon", category = "Dungeons", steps = {
	{ goals = { { t = "goto", entrance = true, text = "Enter dungeon", map = 1429, x = 33, y = 80 } } },
} })
E.OpenTab("test/escort", false); E.OpenTab("test/timed", false); E.OpenTab("test/dungeon", false)
R.SetMain("test/main"); R.Add("test/escort"); R.Add("test/timed"); R.Add("test/dungeon"); settle()
`;

test('escort, timed and dungeon activities require explicit confirmation and cannot auto-accept in the background', () => {
	const [out] = run(COMMITMENTS + `
	local gates = {}
	for _, row in ipairs(R.View().rows) do if row.commitment then gates[#gates+1] = { ready = row.ready, reason = row.reason, key = row.commitment } end end
	local before = E.WantsQuest("accept", 783)
	R.Confirm("escort:783", true); settle()
	local after = E.WantsQuest("accept", 783)
	emit({ gates = gates, before = before, after = after })
	`);
	assert.equal(out.before, false);
	assert.equal(out.after, true);
	assert.equal(out.gates.length, 3);
	assert.ok(out.gates.every(g => !g.ready && g.reason === 'Confirm before starting this activity'));
});

test('declining a commitment keeps leveling active; resuming permits asking again', () => {
	const [out] = run(COMMITMENTS + `
	R.Confirm("escort:783", false); settle()
	local reason
	for _, row in ipairs(R.View().rows) do if row.commitment == "escort:783" then reason = row.reason end end
	R.Resume(); settle()
	emit({ reason = reason, target = E.GetWaypoint().guideId, declined = R.Declined("escort:783") })
	`);
	assert.equal(out.reason, 'Activity deferred');
	assert.equal(out.target, 'test/main');
	assert.equal(out.declined, false);
});

test('an escort that has started retains navigation until the game completes it', () => {
	const [out] = run(COMMITMENTS + `
	R.Confirm("escort:783", true); settle()
	w.accept(783, {{ text="Escort", type="event", cur=0, max=1 }}, "Escort test"); settle()
	emit({ guide = E.GetWaypoint().guideId, quest = E.GetWaypoint().quest })
	`);
	assert.deepEqual(out, { guide: 'test/escort', quest: 783 });
});

test('source references reject replaced packs and quest-item consumers use the navigation source', () => {
	const [out] = run(`
	R.SetMain("test/main"); R.Add("test/class"); settle()
	local ref = R.View().rows[1].ref
	local v, raw = E.NavigationStep()
	local source = raw[1] == E.ResolveObjective(ref)
	local replacement = {}; for k,x in pairs(ref) do replacement[k]=x end
	replacement.raw = {}
	emit({ source = source, stale = E.CombinedAction(replacement, "toggle") or false, count = #v.goals })
	`);
	assert.deepEqual(out, { source: true, stale: false, count: 1 });
});

test('disabled mode leaves the save and ordinary single-guide navigation untouched', () => {
	const [out] = run(`emit({ saved = R.State() ~= nil, waypoint = E.GetWaypoint().label, active = E.GetGuide().id })`);
	assert.equal(out.saved, false);
	assert.equal(out.active, 'test/main');
	assert.ok(out.waypoint);
});

test('merged UI renders source labels in compact and transparent layouts', () => {
	const [out] = run(`
	R.SetMain("test/main"); R.Add("test/class"); settle()
	local GF = Polestar.UI.GuideFrame
	local normal = GF.rows[1].Sub:GetText()
	Polestar.Set("ui.compact", true); Polestar.Set("ui.width", 260)
	Polestar.Set("ui.style", "transparent"); GF.Render()
	emit({ normal = normal, compact = GF.rows[1]:IsShown(), source = GF.rows[1].psGoal.combinedRef.guideId, text = GF.rows[1].Sub:GetText() })
	`, ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml']);
	assert.match(out.normal, /Class quest.*Current destination/);
	assert.equal(out.compact, true);
	assert.equal(out.source, 'test/class');
	assert.match(out.text, /Class quest/);
});

test('later authored class work remains upcoming and manual skips update the correct source', () => {
	const [out] = run(`
	R.SetMain("test/main"); R.Add("test/class"); settle()
	local later, first
	for _, row in ipairs(R.View().rows) do
		if row.ref.guideId == "test/class" and row.ref.step == 2 then later = row.ready end
		if row.ref.guideId == "test/class" and row.ref.step == 1 then first = row.ref end
	end
	E.CombinedAction(first, "toggle"); settle()
	emit({ laterReady = later, main = E.GetTabs()[1].stepIndex, companion = E.GetTabs()[2].stepIndex })
	`);
	assert.deepEqual(out, { laterReady: false, main: 1, companion: 2 });
});

test('level-gated class quests are visible as deferred and do not take navigation', () => {
	const [out] = run(`
	Polestar.RegisterGuide({id="test/gated",pack="test",title="Level 20 class quest",category="Class",minLevel=20,steps={
		{goals={{t="accept",quest=7,title="Gated",minLevel=20,npc=1,npcName="Trainer",map=1429,x=25,y=80}}}
	}})
	E.OpenTab("test/gated",false); R.SetMain("test/main"); R.Add("test/gated"); settle()
	local gated
	for _, row in ipairs(R.View().rows) do if row.ref.guideId=="test/gated" then gated={ready=row.ready,reason=row.reason} end end
	emit({gated=gated,target=E.GetWaypoint().guideId})
	`);
	assert.equal(out.target, 'test/main');
	assert.equal(out.gated.ready, false);
	assert.ok(out.gated.reason);
});

test('saved selections, budget and pause state restore without storing transient confirmations', () => {
	const [out] = run(`
	settle()
	emit({main=R.State().main, budget=R.State().budget, paused=R.State().paused, member=R.State().members["test/class"], confirmed=R.Approved("escort:783")})
	`, FILES, { saved: { Polestar: 'PolestarCharDB = {schema=1,tabs={"test/main","test/class"},activeTab=1,guide="test/main", combinedRoute={enabled=true,main="test/main",members={["test/class"]=true},budget=120,paused=true}}' } });
	assert.deepEqual(out, {main: 'test/main', budget:120, paused:true, member:true, confirmed:false});
});

test('six open guides bound snapshot size and planning work', t => {
	const [out] = run(`
	R.SetMain("test/main"); R.Add("test/class")
	for n=1,4 do
		local steps={}
		for s=1,20 do steps[s]={zone="Elwynn Forest",goals={{t="interact",object=n,objName="Work",map=1429,x=30+n,y=80}}} end
		local id="test/extra"..n
		Polestar.RegisterGuide({id=id,pack="test",title=id,steps=steps})
		E.OpenTab(id,false); R.Add(id)
	end
	local calls=0
	Polestar.Nav.EstimateTravel=function(a,b) calls=calls+1; return math.abs((a and a.x or 20)-b.x) end
	local start=os.clock(); settle()
	emit({rows=#R.View().rows, snapshots=#E.CombinedSnapshot(), calls=calls, seconds=os.clock()-start, tabs=#E.GetTabs()})
	`);
	assert.equal(out.tabs,6);
	assert.ok(out.rows<=64);
	assert.ok(out.snapshots<=64);
	assert.ok(out.calls<=100, `bounded estimate calls: ${out.calls}`);
	assert.ok(out.seconds<1, `test-client CPU seconds: ${out.seconds}`);
	t.diagnostic(`Six guides: ${out.snapshots} objectives, ${out.calls} travel estimates, ${(out.seconds*1000).toFixed(1)} ms test-client CPU.`);
});

test('the real navigation layer receives a companion target with its guide identity', () => {
	const [out] = run(`
	R.SetMain("test/main"); R.Add("test/class"); settle()
	emit({source=Polestar.Nav.GetTarget().guideId,ref=Polestar.Nav.GetTarget().objective.guideId})
	`, ['Core/Core.xml','Theme/Theme.xml','Nav/Nav.xml']);
	assert.deepEqual(out,{source:'test/class',ref:'test/class'});
});

const MENUS = `
local GF=Polestar.UI.GuideFrame
local function pick(text)
	for _,row in ipairs(PolestarMenu.rows) do if row:IsShown() and row.Text:GetText()==text then row:Click(); return row end end
	error("missing menu item: "..text)
end
`;
test('guide menu controls select companions, change budget, pause, resume and disable', () => {
	const [out] = run(MENUS+`
	GF.menuButton:Click(); pick("Use as main guide"); settle()
	E.SelectTab(2); GF.menuButton:Click(); pick("Add to combined route"); settle()
	GF.menuButton:Click(); pick("Added travel budget: 2 min (estimate)"); settle()
	local budget=R.State().budget
	GF.menuButton:Click(); pick("Pause combined route"); local paused=R.State().paused
	GF.menuButton:Click(); pick("Resume combined route"); settle()
	local resumed=not R.State().paused
	GF.menuButton:Click(); pick("Disable combined route"); settle()
	emit({budget=budget,paused=paused,resumed=resumed,enabled=R.Enabled(),target=E.GetWaypoint().label})
	`,['Core/Core.xml','Theme/Theme.xml','UI/UI.xml']);
	assert.equal(out.budget,120);
	assert.equal(out.paused,true);
	assert.equal(out.resumed,true);
	assert.equal(out.enabled,false);
	assert.ok(out.target);
});

test('activity confirmation is available from its merged row and requires the confirming click', () => {
	const [out] = run(COMMITMENTS+MENUS+`
	local row
	for _,r in ipairs(GF.rows) do if r.psGoal and r.psGoal.t=="accept" and r.psGoal.combinedCommitment=="escort:783" then row=r; break end end
	row:Click()
	local button=pick("Start this activity")
	local armed=R.Approved("escort:783")
	button:Click(); settle()
	emit({armed=armed,confirmed=R.Approved("escort:783"),wanted=E.WantsQuest("accept",783)})
	`,['Core/Core.xml','Theme/Theme.xml','UI/UI.xml']);
	assert.deepEqual(out,{armed:false,confirmed:true,wanted:true});
});

test('navigation disabling restores the ordinary target immediately', () => {
	const [out] = run(`
	R.SetMain("test/main"); R.Add("test/class"); settle()
	local before=Polestar.Nav.GetTarget().guideId
	R.Disable()
	emit({before=before,after=Polestar.Nav.GetTarget().label,engine=E.GetWaypoint().label})
	`,['Core/Core.xml','Theme/Theme.xml','Nav/Nav.xml']);
	assert.equal(out.before,'test/class');
	assert.equal(out.after,out.engine);
});

test('an in-progress detour ledger survives reload and prevents spending the budget again', () => {
	const [out] = run(`
	Polestar.Nav.EstimateTravel=function() return 30 end
	settle()
	assert(R.View(),table.concat(Polestar.DebugLog()," | "))
	local reason
	for _,row in ipairs(R.View().rows) do if row.ref.guideId=="test/class" and row.ref.step==1 then reason=row.reason end end
	local wp=E.GetWaypoint()
	emit({source=wp and wp.guideId,reason=reason,paused=R.State().paused,ledger=R.State().ledger})
	`,FILES,{saved:{Polestar:'PolestarCharDB={schema=1,tabs={"test/main","test/class"},activeTab=1,guide="test/main",combinedRoute={enabled=true,main="test/main",members={["test/class"]=true},budget=300,ledger={anchor="test/main:1:1",spent=285,charged={}}}}'}});
	assert.equal(out.source,'test/main',JSON.stringify(out));
	assert.equal(out.reason,'Outside added-travel budget');
});

test('a chapter handoff transfers the main role and companion choices', () => {
	const [out] = run(`
	Polestar.RegisterGuide({id="test/next",pack="test",title="Next chapter",steps={{goals={{t="interact",object=2,objName="Next",map=1429,x=65,y=80}}}}})
	E.OpenTab("test/next",false)
	R.SetMain("test/main"); R.Add("test/class"); settle()
	Polestar.Fire("GUIDE_CONTINUED","test/main","test/next"); settle()
	emit({main=R.State().main,companion=R.State().members["test/class"],enabled=R.Enabled()})
	`);
	assert.deepEqual(out,{main:'test/next',companion:true,enabled:true});
});

test('a companion pickup that closes another quest waits for an explicit choice', () => {
	const [out] = run(`
	Polestar.RegisterGuide({id="test/breadcrumb",pack="test",title="Breadcrumb",steps={{goals={{t="accept",quest=783,title="Breadcrumb",closedBy={7},npc=1,npcName="Giver",map=1429,x=30,y=80}}}}})
	Polestar.RegisterGuide({id="test/closing",pack="test",title="Closing quest",steps={{goals={{t="accept",quest=7,title="Closing quest",npc=2,npcName="Giver",map=1429,x=31,y=80}}}}})
	E.OpenTab("test/breadcrumb",false); E.OpenTab("test/closing",false)
	R.SetMain("test/main"); R.Add("test/breadcrumb"); R.Add("test/closing"); settle()
	local gate
	for _,row in ipairs(R.View().rows) do if row.view.quest==7 then gate=row.commitment end end
	emit({gate=gate,wanted=E.WantsQuest("accept",7)})
	`);
	assert.deepEqual(out,{gate:'closing:7',wanted:false});
});

test('repeating profession activities stay visible without taking over leveling', () => {
	const [out] = run(`
	w.learnSkill(393,"Skinning",1,75)
	Polestar.RegisterGuide({id="test/prof",pack="test",title="Skinning",category="Professions",steps={{goals={{t="skill",skillLine=393,skill="Skinning",level=50,map=1429,x=30,y=80}}}}})
	E.OpenTab("test/prof",false); R.SetMain("test/main"); R.Add("test/prof"); settle()
	local reason
	for _,row in ipairs(R.View().rows) do if row.ref.guideId=="test/prof" then reason=row.reason end end
	emit({source=E.GetWaypoint().guideId,reason=reason})
	`);
	assert.deepEqual(out,{source:'test/main',reason:'Optional activity: follow this guide separately'});
});

test('dungeon preparation advances normally and entry waits for confirmation', () => {
	const [out] = run(`
	Polestar.RegisterGuide({id="test/pickup",pack="test",title="Dungeon preparation",category="Dungeons",steps={
		{goals={{t="accept",quest=7,title="Dungeon quest",npc=1,npcName="Giver",map=1429,x=30,y=80}}},
		{goals={{t="goto",entrance=true,text="Enter the dungeon",map=1429,x=31,y=80}}}
	}})
	E.OpenTab("test/pickup",false); R.SetMain("test/main"); R.Add("test/pickup"); settle()
	local pickup=E.WantsQuest("accept",7)
	w.accept(7,{{text="Dungeon task",type="monster",cur=0,max=1}},"Dungeon quest"); settle()
	local gate
	for _,row in ipairs(R.View().rows) do if row.ref.guideId=="test/pickup" then gate={commitment=row.commitment,ready=row.ready} end end
	emit({pickup=pickup,gate=gate,target=E.GetWaypoint().guideId})
	`);
	assert.equal(out.pickup,true);
	assert.deepEqual(out.gate,{commitment:'dungeon:test/pickup',ready:false});
	assert.equal(out.target,'test/main');
});

test('shared quest progress credits both source guides while remaining one merged objective', () => {
	const [out] = run(`
	w.accept(783,{{text="Shared work",type="monster",cur=0,max=1}},"Shared quest")
	for n=1,2 do
		Polestar.RegisterGuide({id="test/shared"..n,pack="test",title="Shared "..n,steps={{goals={{t="kill",target="Shared mob",quest=783,oi=1,npc=1,npcName="Shared mob",count=1,map=1429,x=30,y=80}}}}})
		E.OpenTab("test/shared"..n,false)
	end
	R.SetMain("test/main"); R.Add("test/shared1"); R.Add("test/shared2"); settle()
	local count,refs=0,0
	for _,row in ipairs(R.View().rows) do if row.view.quest==783 then count=count+1; refs=#row.refs end end
	w.progress(783,1,1); settle()
	local completed=0
	for _,tab in ipairs(E.GetTabs()) do if tab.guideId:find("test/shared",1,true) and tab.complete then completed=completed+1 end end
	emit({count=count,refs=refs,completed=completed,main=E.GetTabs()[1].stepIndex})
	`);
	assert.deepEqual(out,{count:1,refs:2,completed:2,main:1});
});

test('temporary death suspends automatic weaving without losing selected guides', () => {
	const [out] = run(COMMITMENTS+`
	R.Confirm("escort:783",true); settle()
	UnitIsDeadOrGhost=function() return true end
	local dead=R.OwnsNavigation() or false
	local wanted=E.WantsQuest("accept",783)
	UnitIsDeadOrGhost=function() return false end
	R.Invalidate(); settle()
	emit({dead=dead,wanted=wanted,resumed=R.OwnsNavigation(),main=R.State().main})
	`);
	assert.deepEqual(out,{dead:false,wanted:false,resumed:true,main:'test/main'});
});

test('abandoning an escort requires a fresh confirmation before accepting again', () => {
	const [out] = run(COMMITMENTS+`
	R.Confirm("escort:783",true); settle()
	w.accept(783,{{text="Escort",type="event",cur=0,max=1}},"Escort test"); settle()
	w.abandon(783); settle()
	emit({approved=R.Approved("escort:783"),wanted=E.WantsQuest("accept",783)})
	`);
	assert.deepEqual(out,{approved:false,wanted:false});
});
