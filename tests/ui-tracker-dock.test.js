'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const TRACKER = `
C_Texture = { GetAtlasInfo = function() return {} end }
function ReloadUI() error("docking changes must not reload automatically") end

C_AddOns.DoesAddOnExist = function(name)
	for _, addon in ipairs(stub.addons) do if addon.name == name then return true end end
	return false
end
ObjectiveTrackerFrame = CreateFrame("Frame", nil, UIParent)
ObjectiveTrackerFrame.HeaderMenu = false
ObjectiveTrackerFrame:SetSize(260, 600)
ObjectiveTrackerFrame.y = 300
ObjectiveTrackerFrame.Header = CreateFrame("Frame", nil, ObjectiveTrackerFrame)
local header = ObjectiveTrackerFrame.Header
header.Background = header:CreateTexture(nil, "BACKGROUND")
header.Background:SetSize(280, 32)
header.Text = header:CreateFontString(nil, "OVERLAY")
header.Text:SetFont("native-font", 16, "")
local M = stub.Methods
local getTop, getWidth = M.GetTop, M.GetWidth
function M.GetTop(self)
	if self:GetName() == "PolestarTrackerDockContent" then return 900 end
	return getTop(self)
end
function M.GetWidth(self)
	if self:GetName() == "PolestarTrackerDockContent" then return 295 end
	return getWidth(self)
end
`;
function run(script, { enabled = true, before = '', hideTracker = false, withQoL = false, savedTab = 'quests', shown = true } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'], before: TRACKER + before,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', ...(withQoL ? ['QoL/QoL.xml'] : []), 'UI/UI.xml'] }],
		saved: { Polestar: `PolestarDB={schema=1,settings={ui={trackerDock=${enabled},shown=${shown},pos={100,200},scale=1.2,growUp=true,maxHeight=0.3},qol={hideQuestTracker=${hideTracker}}}};PolestarCharDB={trackerDockTab=${JSON.stringify(savedTab)}}` },
		script: `uistub.install();stub.login();stub.advance(0.3)
local GF=Polestar.UI.GuideFrame
local dock=Polestar.UI.TrackerDock
${script}`,
	}).emitted;
}

test('docking is opt-in; the floating guide keeps its position and settings', () => {
	const [out] = run(`emit({enabled=dock.Enabled(),attached=GF.dock~=nil,pos=Polestar.Get("ui.pos"),scale=Polestar.Get("ui.scale")})`, { enabled: false });
	assert.deepEqual(out, { enabled: false, attached: false, pos: [100,200], scale: 1.2 });
});

test('docked guide follows tracker bounds, keeps floating settings, and hides its resize grip', () => {
	const [out] = run(`
	assert(GF.dock)
	local adapter=GF.dock
	adapter:SetSelected(true,true)
	adapter:Layout(ObjectiveTrackerFrame,false,false)
	GF.ApplyLock();GF.ApplyPosition();GF.ApplyScale();GF.SavePosition()
	local point,rel=GF.frame:GetPoint()
	emit({attached=GF.frame:GetParent()==adapter.pane,positioned=point=="TOPLEFT" and rel==adapter.pane,
		grip=GF.grip:IsShown(),pos=Polestar.Get("ui.pos"),scale=Polestar.Get("ui.scale"),
		grow=Polestar.Get("ui.growUp"),maxHeight=Polestar.Get("ui.maxHeight"),
		cap=GF.CapHeight()*GF.frame:GetEffectiveScale()/adapter.holder:GetEffectiveScale(),
		available=adapter.available,bare=GF.frame.psBare})`);
	assert.equal(out.attached, true);
	assert.equal(out.positioned, true);
	assert.equal(out.grip, false);
	assert.equal(out.bare, true);
	assert.deepEqual(out.pos,[100,200]);
	assert.equal(out.scale,1.2);
	assert.equal(out.grow,true);
	assert.equal(out.maxHeight,0.3);
	assert.equal(out.available,596);
	assert.ok(Math.abs(out.cap-out.available)<0.01);
});

for (const loaded of [false,true]) {
	test(`the standalone addon owns docking when enabled, including before its files load (${loaded})`, () => {
		const [out]=run('emit({enabled=dock.Enabled(),attached=GF.dock~=nil,tabs=PolestarTrackerDockTabs~=nil})', {
			before: `stub.addons={{name="Polestartrackerdock",loaded=${loaded}}}`,
		});
		assert.deepEqual(out,{enabled:false,attached:false,tabs:false});
	});
}

test('a disabled standalone addon does not block built-in docking', () => {
	const [out]=run('emit({enabled=dock.Enabled(),attached=GF.dock~=nil})',{
		before:'stub.addons={{name="Polestartrackerdock",reason="DISABLED",enabled=false}}',
	});
	assert.deepEqual(out,{enabled:true,attached:true});
});

test('an updated standalone addon yields to the built-in option before its files load',()=>{
	const [out]=run(`
	Polestar.UI.ShowOptions("integrations")
	emit({enabled=dock.Enabled(),attached=GF.dock~=nil,
		option=Polestar.UI.Options.Controls("integrations")["ui.trackerDock"]:IsEnabled()})`,{
		before:`stub.addons={{name="Polestartrackerdock",loaded=false}}
	stub.addonMeta.Polestartrackerdock={["X-Polestar-Native-Dock"]="1"}`,
	});
	assert.deepEqual(out,{enabled:true,attached:true,option:true});
});

test('FTA hosts the Polestar tab once and the built-in dock creates no second row', () => {
	const [out]=run(`emit({registrations=hostRegistrations,ownTabs=PolestarTrackerDockTabs~=nil})`,{
		before:`hostRegistrations=0
	FTAEllesmereTrackerDock={CanDock=function() return true end,
	RegisterGuide=function(key,label,getGuide,attach)
		assert(key=="polestar" and label=="Polestar" and type(getGuide)=="function" and type(attach)=="function")
		hostRegistrations=hostRegistrations+1
	end}`,
	});
	assert.deepEqual(out,{registrations:1,ownTabs:false});
});

test('the docking toggle uses the existing Options reload button and does not reparent mid-session', () => {
	const [out]=run(`
	Polestar.UI.ShowOptions("integrations")
	Polestar.Set("ui.trackerDock",true)
	local reload=false
	for _,button in ipairs(PolestarOptions.footerButtons.left) do
		if button.Label:GetText()=="Reload UI" and button:IsShown() then reload=true end
	end
	emit({extraPrompt=PolestarTrackerDockReload~=nil,reload=reload,attached=GF.dock~=nil,saved=Polestar.Get("ui.trackerDock")})`,{enabled:false});
	assert.deepEqual(out,{extraPrompt:false,reload:true,attached:false,saved:true});
});

for (const standalone of [false,true]) {
	test(`the docking toggle is under Integrations and respects standalone ownership (${standalone})`, () => {
		const [out]=run(`
		Polestar.UI.ShowOptions("integrations")
		local controls=Polestar.UI.Options.Controls("integrations")
		local toggle=controls["ui.trackerDock"]
		emit({found=toggle~=nil,enabled=toggle and toggle:IsEnabled()})`,{
			enabled:false,
			before:standalone?'stub.addons={{name="Polestartrackerdock"}}':'',
		});
		assert.deepEqual(out,{found:true,enabled:!standalone});
	});
}

test('switching tabs restores quest opacity and queues a selection made in combat', () => {
	const [out]=run(`
	local tabs=PolestarTrackerDockTabs
	local quests,guide
	for _,button in ipairs({tabs:GetChildren()}) do
		if button.label and button.label:GetText()=="Quests" then quests=button end
		if button.label and button.label:GetText()=="Polestar" then guide=button end
	end
	guide:Click()
	local selected=GF.dock.pane:IsShown() and ObjectiveTrackerFrame:GetAlpha()==0
	ObjectiveTrackerFrame:SetAlpha(0.65)
	stub.inCombat=true
	quests:Click()
	local queued=GF.dock.pane:IsShown() and ObjectiveTrackerFrame:GetAlpha()==0
	stub.inCombat=false
	stub.fire("PLAYER_REGEN_ENABLED")
	emit({selected=selected,queued=queued,restored=ObjectiveTrackerFrame:GetAlpha(),closed=not GF.dock.pane:IsShown()})`);
	assert.deepEqual(out,{selected:true,queued:true,restored:0.65,closed:true});
});

for (const custom of [false,true]) {
	test(`Ellesmere docking uses its style and configured height (${custom})`, () => {
		const [out]=run(`
		local adapter=GF.dock
		adapter:Layout(${custom ? 'EUI_CustomQuestTracker' : 'ObjectiveTrackerFrame'},${custom},true)
		emit({attached=adapter~=nil,line=PolestarTrackerDockTabs.line:IsShown(),available=adapter.available})`,{
			before:`EllesmereUI={GetAccentColor=function() return 0,0.8,0.6 end,GetFontPath=function() return "eui-font" end}
	EllesmereUIQuestTracker={Blizz=function() return false end,DB=function() return {customMaxHeight=650} end}
	${custom ? 'EUI_CustomQuestTracker=CreateFrame("Frame",nil,UIParent);EUI_CustomQuestTracker:SetSize(295,120);EUI_CustomQuestTracker.y=780;EUI_CustomQuestTracker.bg=EUI_CustomQuestTracker:CreateTexture(nil,"BACKGROUND");EUI_CustomQuestTracker.topLine=EUI_CustomQuestTracker:CreateTexture(nil,"OVERLAY")' : 'EllesmereUIQTBackground=CreateFrame("Frame",nil,UIParent);EllesmereUIQTBackground:SetSize(295,120);EllesmereUIQTBackground._tex=EllesmereUIQTBackground:CreateTexture(nil,"BACKGROUND");EllesmereUIQTBackground._divider=EllesmereUIQTBackground:CreateTexture(nil,"OVERLAY")'}`,
		});
		assert.equal(out.attached,true);
		assert.equal(out.line,true);
		assert.equal(out.available,custom?646:596);
	});
}


test('hiding Polestar restores quests, hides the dock and stops its update loop',()=>{
	const [out]=run(`
	local tabs=PolestarTrackerDockTabs
	for _,button in ipairs({tabs:GetChildren()}) do
		if button.label and button.label:GetText()=="Polestar" then button:Click() end
	end
	local updater
	for _,frame in ipairs(stub.frames) do
		if frame:GetParent()==Polestar.UIParent and frame:GetScript("OnUpdate") and frame:GetScript("OnEvent") then updater=frame end
	end
	assert(updater)
	local ticks=0
	updater:HookScript("OnUpdate",function() ticks=ticks+1 end)
	Polestar.SetHidden(true)
	local hidden=not tabs:IsVisible() and not GF.frame:IsVisible()
	local quests=ObjectiveTrackerFrame:GetAlpha()
	stub.advance(0.5)
	local stopped=ticks==0
	Polestar.SetHidden(false)
	emit({hidden=hidden,quests=quests,stopped=stopped,restored=tabs:IsVisible() and GF.frame:IsVisible(),selected=ObjectiveTrackerFrame:GetAlpha()==0})`);
	assert.deepEqual(out,{hidden:true,quests:1,stopped:true,restored:true,selected:true});
});


test('the selected guide tab survives a fresh session and switching back saves Quests',()=>{
	const [saved]=run(`
	for _,button in ipairs({PolestarTrackerDockTabs:GetChildren()}) do
		if button.label:GetText()=="Polestar" then button:Click() end
	end
	emit(Polestar.CharState().trackerDockTab)`);
	assert.equal(saved,'polestar');
	const [restored]=run(`
	local visible=GF.dock.pane:IsShown() and GF.frame:IsVisible()
	for _,button in ipairs({PolestarTrackerDockTabs:GetChildren()}) do
		if button.label:GetText()=="Quests" then button:Click() end
	end
	emit({visible=visible,saved=Polestar.CharState().trackerDockTab})`,{savedTab:saved});
	assert.deepEqual(restored,{visible:true,saved:'quests'});
	const [quests]=run('emit({visible=GF.dock.pane:IsShown(),saved=Polestar.CharState().trackerDockTab})',{savedTab:restored.saved});
	assert.deepEqual(quests,{visible:false,saved:'quests'});
});

test('an unavailable saved tab and a hidden guide fall back to Quests',()=>{
	for (const options of [{savedTab:'removed-guide'},{savedTab:'polestar',shown:false}]) {
		const [out]=run('emit({visible=GF.dock.pane:IsShown(),saved=Polestar.CharState().trackerDockTab})',options);
		assert.deepEqual(out,{visible:false,saved:'quests'});
	}
});

for (const savedTab of ['polestar','fta']) {
	test(`a shared FTA row restores its saved tab after the host initializes (${savedTab})`,()=>{
		const [out]=run(`
	local holder=Polestar.CreateFrameUnder("Frame",nil,Polestar.UIParent)
	holder:SetSize(300,500)
	sharedAdapter=sharedAttach(holder,function() end,function() end)
	FTAEllesmereTrackerDock.Select("quests")
	stub.advance(0.1)
	emit({selected=sharedSelected,saved=Polestar.CharState().trackerDockTab})`,{
			savedTab,
			before:`FTAEllesmereTrackerDock={CanDock=function() return true end,
	RegisterGuide=function(_,_,_,attach) sharedAttach=attach end,
	Select=function(tab)
		sharedSelected=tab
		sharedAdapter:SetSelected(tab=="polestar",tab~="quests")
	end}`,
		});
		assert.deepEqual(out,{selected:savedTab,saved:savedTab});
	});
}

test('a saved configuration with docking and hide-tracker enabled keeps a visible floating guide',()=>{
	const [out]=run(`
	Polestar.UI.ShowOptions("integrations")
	local disabled=not Polestar.UI.Options.Controls("integrations")["ui.trackerDock"]:IsEnabled()
	emit({enabled=dock.Enabled(),floating=GF.dock==nil and GF.frame:IsVisible(),
		trackerHidden=not ObjectiveTrackerFrame:IsShown(),shown=Polestar.Get("ui.shown"),disabled=disabled})`,
		{hideTracker:true,withQoL:true});
	assert.deepEqual(out,{enabled:false,floating:true,trackerHidden:true,shown:true,disabled:true});
});

test('hiding the tracker switches docking off and waits for reload before hiding its guide',()=>{
	const [out]=run(`
	Polestar.UI.ShowOptions("qualityoflife")
	Polestar.UI.Options.Select("qualityoflife","Quests")
	local control=Polestar.UI.Options.Controls("qualityoflife","Quests")["qol.hideQuestTracker"]
	assert(control and control:IsEnabled())
	assert(not rawget(control,"HelpNotice"))
	control:Click()
	stub.advance(0.3)
	Polestar.UI.ShowOptions("integrations")
	local toggle=Polestar.UI.Options.Controls("integrations")["ui.trackerDock"]
	emit({docked=GF.dock~=nil,active=dock.Enabled(),trackerVisible=ObjectiveTrackerFrame:IsShown(),
		hide=Polestar.Get("qol.hideQuestTracker"),savedDock=Polestar.Get("ui.trackerDock"),
		disabled=not toggle:IsEnabled(),notice=toggle.HelpNotice:GetText(),modal=Polestar.Widgets.ModalShown()})`,{withQoL:true});
	assert.deepEqual(out,{docked:true,active:true,trackerVisible:true,hide:true,savedDock:false,disabled:true,
		notice:'Reload required\nDocking is unavailable while the quest tracker is hidden.',modal:false});
	const [reloaded]=run(`emit({docked=GF.dock~=nil,floating=GF.frame:IsVisible(),
		hidden=not ObjectiveTrackerFrame:IsShown(),savedDock=Polestar.Get("ui.trackerDock")})`,
		{withQoL:true,hideTracker:out.hide,enabled:out.savedDock});
	assert.deepEqual(reloaded,{docked:false,floating:true,hidden:true,savedDock:false});
});

test('the hidden-tracker restriction is conditional and its saved docking switch remains off',()=>{
	const [hidden,visible]=run(`
	Polestar.UI.ShowOptions("integrations")
	local toggle=Polestar.UI.Options.Controls("integrations")["ui.trackerDock"]
	emit({savedDock=Polestar.Get("ui.trackerDock"),disabled=not toggle:IsEnabled(),notice=toggle.HelpNotice:GetText()})
	Polestar.Set("qol.hideQuestTracker",false)
	Polestar.UI.ShowOptions("integrations")
	emit({savedDock=Polestar.Get("ui.trackerDock"),disabled=not toggle:IsEnabled(),notice=toggle.HelpNotice:GetText()})`,
		{hideTracker:true,withQoL:true});
	assert.deepEqual(hidden,{savedDock:false,disabled:true,notice:'Reload required\nDocking is unavailable while the quest tracker is hidden.'});
	assert.deepEqual(visible,{savedDock:false,disabled:false,notice:'Reload required'});
});

test('the gamepad interface leaves docking inactive and the guide floating',()=>{
	const [out]=run(`
	Polestar.UI.ShowOptions("integrations")
	emit({gamepad=Polestar.GamepadUI(),enabled=dock.Enabled(),floating=GF.dock==nil and GF.frame:IsVisible(),
		trackerAlpha=ObjectiveTrackerFrame:GetAlpha(),tabs=PolestarTrackerDockTabs~=nil,
		disabled=not Polestar.UI.Options.Controls("integrations")["ui.trackerDock"]:IsEnabled()})`,{
		before:'Enum.InputDeviceInterfaceType={Mkb=0,Gamepad=1};C_InputInterfaceStyle={GetCurrentStyle=function() return 1 end}',
	});
	assert.deepEqual(out,{gamepad:true,enabled:false,floating:true,trackerAlpha:1,tabs:false,disabled:true});
});

const QUESTIE = `
Questie={db={profile={trackerEnabled=true,TrackerHeight=600,trackerHeightRatio=0.5,
	trackerBackdropEnabled=true,trackerBackdropColor={r=0.1,g=0.2,b=0.3,a=0.4}}}}
Questie_BaseFrame=CreateFrame("Frame",nil,UIParent)
Questie_BaseFrame:SetSize(300,200)
Questie_BaseFrame.y=700
Questie_HeaderFrame={trackedQuests={label={GetFont=function() return "questie-font",14,"OUTLINE" end}}}
ObjectiveTrackerFrame:Hide()
`;

test('Questie hosts the tabs when it replaces the Blizzard tracker, using its font and height limits',()=>{
	const [out]=run(`
	local tabs=PolestarTrackerDockTabs
	local _,anchor,_,x=PolestarTrackerDockNativeAnchor:GetPoint(1)
	local quests,guide
	for _,button in ipairs({tabs:GetChildren()}) do
		if button.label:GetText()=="Quests" then quests=button else guide=button end
	end
	local font,size,flags=guide.label:GetFont()
	guide:Click()
	local manual=GF.dock.available
	local selected=GF.dock.pane:IsShown() and Questie_BaseFrame:GetAlpha()==0
	Questie.db.profile.TrackerHeight=0
	stub.advance(0.3)
	local automatic=GF.dock.available
	Questie_BaseFrame:Hide();stub.advance(0.3)
	local hidden=not tabs:IsShown()
	Questie_BaseFrame:Show();stub.advance(0.3)
	quests:Click()
	emit({questieAnchor=anchor==Questie_BaseFrame,x=x,font=font,size=size,flags=flags,
		manual=manual,automatic=automatic,selected=selected,hidden=hidden,shown=tabs:IsShown(),
		restored=Questie_BaseFrame:GetAlpha()==1,blizzardHidden=not ObjectiveTrackerFrame:IsShown()})`,{before:QUESTIE});
	assert.deepEqual(out,{questieAnchor:true,x:0,font:'questie-font',size:14,flags:'OUTLINE',manual:596,
		automatic:536,selected:true,hidden:true,shown:true,restored:true,blizzardHidden:true});
});

test('Questie initialization is awaited instead of binding to the tracker it hides',()=>{
	const [out]=run(`
	local waited=PolestarTrackerDockTabs==nil
	Questie_BaseFrame=waitingQuestie
	Questie_BaseFrame:SetWidth(25);stub.advance(0.3)
	local sizing=PolestarTrackerDockTabs==nil
	Questie_BaseFrame:SetWidth(300);stub.advance(0.3)
	emit({waited=waited,sizing=sizing,attached=GF.dock~=nil})`,{
		before:QUESTIE+'waitingQuestie=Questie_BaseFrame;Questie_BaseFrame=nil',
	});
	assert.deepEqual(out,{waited:true,sizing:true,attached:true});
});

for (const supported of [false,true]) {
	test(`shared Questie tabs require an FTA host with Questie support (${supported})`,()=>{
		const [out]=run(`emit({registered=hostRegistrations,ownTabs=PolestarTrackerDockTabs~=nil})`,{
			before:QUESTIE+`hostRegistrations=0
	FTAEllesmereTrackerDock={SupportsQuestie=${supported},CanDock=function() return true end,
	RegisterGuide=function() hostRegistrations=hostRegistrations+1 end}`,
		});
		assert.deepEqual(out,{registered:supported?1:0,ownTabs:!supported});
	});
}

const FOREVER_SETUP = `
local holder=GF.dock.holder
holder.x=1400
function holder:GetBottom() return 900-self:GetHeight() end
local column=Polestar.CreateFrameUnder("Frame",nil,Polestar.UIParent)
column:SetSize(300,100)
ForeverTrackerCompanion=column
local attached=true
ForeverCore={TrackerHost={IsAttachedToQuestTracker=function() return attached end}}
local restored=0
function column:MarkDirty()
 restored=restored+1
 self:ClearAllPoints();self:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",25,600)
end
local function selectTab(label)
 for _,button in ipairs({PolestarTrackerDockTabs:GetChildren()}) do
  if button.label and button.label:GetText()==label then button:Click() end
 end
end
`;
for (const scale of [1,1.5]) {
	test(`attached Forever sections follow the guide without reducing its height and restore on Quests (${scale})`,()=>{
		const [out]=run(FOREVER_SETUP+`
	column:SetScale(${scale})
	selectTab("Polestar");stub.advance(0.3)
	local _,relative,relativePoint,x,y=column:GetPoint()
	local follows=relative==UIParent and relativePoint=="BOTTOMLEFT"
	 and math.abs(x-holder:GetLeft()/column:GetEffectiveScale())<0.01
	 and math.abs(y-(holder:GetBottom()-8)/column:GetEffectiveScale())<0.01
	local cap=GF.dock.available
	column:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",0,0)
	local _,_,_,_,reapplied=column:GetPoint()
	selectTab("Quests")
	local _,_,_,backX,backY=column:GetPoint()
	selectTab("Polestar")
	attached=false;stub.advance(0.3)
	local _,_,_,detachedX,detachedY=column:GetPoint()
	emit({follows=follows,stable=math.abs(reapplied-y)<0.01,cap=cap,
	 restored=restored>=1,quests=backX==25 and backY==600,detached=detachedX==25 and detachedY==600})`);
		assert.deepEqual(out,{follows:true,stable:true,cap:596,restored:true,quests:true,detached:true});
	});
}

test('Forever sections use the side when the full columns cannot fit below one another',()=>{
	const [out]=run(FOREVER_SETUP+`
	function holder:GetBottom() return 20 end
	column:SetHeight(200)
	selectTab("Polestar");stub.advance(0.3)
	local _,_,_,x,y=column:GetPoint()
	emit({beside=x==1092,aligned=y==900})`);
	assert.deepEqual(out,{beside:true,aligned:true});
});

test('hiding Polestar restores Forever placement and combat defers companion moves',()=>{
	const [out]=run(FOREVER_SETUP+`
	selectTab("Polestar");stub.advance(0.3)
	local _,_,_,x,y=column:GetPoint()
	stub.inCombat=true
	column:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",70,500)
	stub.advance(0.3)
	local _,_,_,combatX,combatY=column:GetPoint()
	stub.inCombat=false;stub.fire("PLAYER_REGEN_ENABLED");stub.advance(0.3)
	local _,_,_,backX,backY=column:GetPoint()
	Polestar.SetHidden(true)
	local _,_,_,hiddenX,hiddenY=column:GetPoint()
	emit({combat=combatX==70 and combatY==500,resumed=math.abs(backX-x)<0.01 and math.abs(backY-y)<0.01,
	 hidden=hiddenX==25 and hiddenY==600})`);
	assert.deepEqual(out,{combat:true,resumed:true,hidden:true});
});

test('native docking measures new goal rows during combat completion animations',()=>{
	const [out]=run(`
	uistub.setGuide(uistub.elwynn,3)
	Polestar.Set("ui.wholeStep",false)
	GF.dock:SetSelected(true,true)
	stub.advance(0.3)
	stub.inCombat=true
	local step=uistub.guides[uistub.elwynn].steps[3]
	step.goals={}
	for i=1,20 do
	 step.goals[i]={t="collect",verb="Collect",subject="Test item "..i,subjectKind="item",item=1000+i,
	  status="active",progress={cur=0,max=10,kind="count"}}
	end
	uistub.update();step.goals[1].status="done";uistub.update();stub.advance(1)
	emit({rows=#GF.CardItems()})`,{savedTab:'polestar'});
	assert.ok(out.rows>=20,JSON.stringify(out));
});
