'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const TRACKER = `
C_Texture = { GetAtlasInfo = function() return {} end }
local createFrame=CreateFrame
function CreateFrame(kind,name,parent,template,...)
	local frame=createFrame(kind,name,parent,template,...)
	if type(template)=="string" and template:find("SecureActionButtonTemplate") then
		frame.secure=true
		if parent and parent:GetName()=="PolestarTrackerDockReload" then parent.secure=true end
	end
	return frame
end
for _,method in ipairs({"Show","Hide","SetPoint","SetSize","SetAttribute"}) do
	local original=stub.Methods[method]
	stub.Methods[method]=function(self,...)
		if self.secure and stub.inCombat then error("protected reload control changed in combat: "..method) end
		return original(self,...)
	end
end
local drivers={}
function RegisterStateDriver(frame,state,condition)
	assert(not stub.inCombat,"state driver registration during combat")
	assert(state=="visibility" and condition=="[combat] hide; show")
	drivers[frame]=true
	frame:Show()
end
function UnregisterStateDriver(frame,state)
	assert(not stub.inCombat,"state driver removal during combat")
	drivers[frame]=nil
end
function setDockCombat(combat)
	stub.inCombat=combat
	for frame in pairs(drivers) do frame.shown=not combat end
	stub.fire(combat and "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED")
end
function ReloadUI() error("insecure ReloadUI call") end

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
function run(script, { enabled = true, before = '', hideTracker = false, withQoL = false } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'], before: TRACKER + before,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', ...(withQoL ? ['QoL/QoL.xml'] : []), 'UI/UI.xml'] }],
		saved: { Polestar: `PolestarDB={schema=1,settings={ui={trackerDock=${enabled},pos={100,200},scale=1.2,growUp=true,maxHeight=0.3},qol={hideQuestTracker=${hideTracker}}}}` },
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

test('the docking toggle asks for reload and does not reparent the guide mid-session', () => {
	const [out]=run(`
	Polestar.Set("ui.trackerDock",true)
	emit({prompt=PolestarTrackerDockReload and PolestarTrackerDockReload:IsShown(),attached=GF.dock~=nil})`,{enabled:false});
	assert.deepEqual(out,{prompt:true,attached:false});
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

for (const keyDown of [false,true]) {
	test(`reload confirmation executes the secure macro once on release (${keyDown})`,()=>{
		const [out]=run(`
		stub.cvars.ActionButtonUseKeyDown=${keyDown ? '"1"' : '"0"'}
		Polestar.Set("ui.trackerDock",true)
		local prompt=PolestarTrackerDockReload
		local actions={}
		stub.mouseClick(prompt.Reload,actions)
		emit({actions=actions,closed=not prompt:IsShown(),saved=Polestar.Get("ui.trackerDock")})`,{enabled:false});
		assert.deepEqual(out,{actions:[['macro','/reload']],closed:true,saved:true});
	});
}

test('reload prompt waits for combat and Later keeps the setting without reloading',()=>{
	const [out]=run(`
	setDockCombat(true)
	Polestar.Set("ui.trackerDock",true)
	local deferred=PolestarTrackerDockReload==nil
	setDockCombat(false)
	local prompt=PolestarTrackerDockReload
	local opened=prompt:IsShown()
	setDockCombat(true)
	local hiddenInCombat=not prompt:IsShown()
	setDockCombat(false)
	prompt.Later:Click()
	emit({deferred=deferred,opened=opened,hiddenInCombat=hiddenInCombat,closed=not prompt:IsShown(),saved=Polestar.Get("ui.trackerDock")})`,{enabled:false});
	assert.deepEqual(out,{deferred:true,opened:true,hiddenInCombat:true,closed:true,saved:true});
});

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

test('hiding Polestar in combat dismisses the secure reload prompt after combat',()=>{
	const [out]=run(`
	Polestar.Set("ui.trackerDock",true)
	setDockCombat(true)
	Polestar.SetHidden(true)
	setDockCombat(false)
	emit({closed=not PolestarTrackerDockReload:IsShown(),hidden=Polestar.Hidden()})`,{enabled:false});
	assert.deepEqual(out,{closed:true,hidden:true});
});

test('a saved configuration with docking and hide-tracker enabled keeps a visible floating guide',()=>{
	const [out]=run(`
	Polestar.UI.ShowOptions("integrations")
	local disabled=not Polestar.UI.Options.Controls("integrations")["ui.trackerDock"]:IsEnabled()
	emit({enabled=dock.Enabled(),floating=GF.dock==nil and GF.frame:IsVisible(),
		trackerHidden=not ObjectiveTrackerFrame:IsShown(),shown=Polestar.Get("ui.shown"),disabled=disabled})`,
		{hideTracker:true,withQoL:true});
	assert.deepEqual(out,{enabled:false,floating:true,trackerHidden:true,shown:true,disabled:true});
});

test('the hide-tracker control is unavailable while docking is active',()=>{
	const [out]=run(`
	Polestar.UI.ShowOptions("qualityoflife")
	Polestar.UI.Options.Select("qualityoflife","Quests")
	local control=Polestar.UI.Options.Controls("qualityoflife","Quests")["qol.hideQuestTracker"]
	emit({docked=GF.dock~=nil,disabled=control~=nil and not control:IsEnabled()})`,{withQoL:true});
	assert.deepEqual(out,{docked:true,disabled:true});
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
