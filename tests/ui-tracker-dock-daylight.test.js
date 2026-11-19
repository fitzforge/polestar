'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
function run(script, { enabled = true, delay = false, standalone = false } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		before: `
C_Texture={GetAtlasInfo=function() return {} end}
C_AddOns.DoesAddOnExist=function(name) return name=='Polestar' or (${standalone} and name=='Polestartrackerdock') end
stub.addons={{name='Polestar'}${standalone ? ",{name='Polestartrackerdock'}" : ''}}
stub.addonMeta.Polestartrackerdock={['X-Polestar-Native-Dock']='1',Version='1.0.6'}
ObjectiveTrackerFrame=CreateFrame('Frame',nil,UIParent)
ObjectiveTrackerFrame:SetSize(260,600);ObjectiveTrackerFrame.HeaderMenu=false;ObjectiveTrackerFrame.Header=false
ObjectiveTrackerFrame:SetAlpha(0)
`,
		addons: [
			{ name: 'DaylightUI_Quests', files: ['../../tests/lua/stub_daylight.lua'] },
			{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'QoL/QoL.xml', 'UI/UI.xml'] },
		],
		saved: {
			DaylightUI_Quests: `stub.daylight.tracker.built=${!delay}`,
			Polestar: `PolestarDB={schema=1,settings={ui={shown=true,trackerDock=${enabled}}}}`,
		},
		script: `uistub.install();stub.login();stub.advance(0.5)
local p,d=Polestar,stub.daylight
local function tabs() local f=PolestarDaylightDockTabs;assert(f,'no Daylight tabs');return f:GetChildren() end
local quests,guide
${script}`,
	}).emitted;
}

test('Daylight uses a persistent heading row and hides quest controls and sibling scrollbar', () => {
	const [out] = run(`
quests,guide=tabs();assert(PolestarDaylightDockTabs:IsShown() and not d.tracker.controls:IsShown())
local font,size,flags=guide.label:GetFont();assert(font=='daylight-quest-font.ttf' and size==12 and flags=='OUTLINE')
assert(quests.label:GetText()=='QUESTS' and guide.label:GetText()=='POLESTAR')
guide:Click();assert(p.UI.GuideFrame.frame:IsVisible() and not d.view:IsShown() and not d.items:IsShown() and not d.bar:IsShown())
assert(not PolestarTrackerDockTabs,'duplicate dock')
d.hover=true;d.tracker.Render();d.parts.Scroll.Paint()
assert(not d.tracker.controls:IsShown() and not d.items:IsShown() and not d.bar:IsShown())
quests:Click();assert(d.view:IsShown() and d.items:IsShown() and d.bar:IsShown())
assert(d.tracker.controls:IsShown() and d.parts.Scroll.offset==120)
d.hover=false;d.tracker.Hovered();stub.advance(0.3)
assert(PolestarDaylightDockTabs:IsShown() and not d.tracker.controls:IsShown())
assert(ObjectiveTrackerFrame:GetAlpha()==0)
emit({ok=true})`);
	assert.deepEqual(out, {ok:true});
});

test('Daylight guide height follows the guide up to the host limit, with live style and scale', () => {
	const [out] = run(`
quests,guide=tabs();guide:Click()
d.cfg.maxHeight=450;d.root:SetScale(1.3);d.cfg.colors.header={0.1,0.3,0.9};d.cfg.box=true
d.header.label:SetFont('changed-font.ttf',15,'');stub.advance(0.3)
local font,size=guide.label:GetFont();assert(font=='changed-font.ttf' and size==15)
local r,g,b=guide.label:GetTextColor();assert(r==0.1 and g==0.3 and b==0.9)
local panel=PolestarDaylightDockContent
assert(panel.daylightSkin and panel:GetScale()==1.3)
assert(p.UI.GuideFrame.dock.available>440 and p.UI.GuideFrame.dock.available<451)
local gf=p.UI.GuideFrame
local layout=gf.Layout
for _,height in ipairs({200,400}) do
 gf.Layout=function() gf.frame:SetHeight(height) end;stub.advance(0.3)
 assert(math.abs(panel:GetHeight()-height*gf.frame:GetScale())<0.1)
end
gf.Layout=layout;quests:Click();assert(d.tracker.box:IsShown())
emit({ok=true})`);
	assert.deepEqual(out, {ok:true});
});

test('Daylight combat switches wait; hidden tracker floats the guide and restores it safely', () => {
	const [out] = run(`
quests,guide=tabs();guide:Click();stub.inCombat=true;quests:Click()
assert(PolestarDaylightDockContent:IsShown())
stub.inCombat=false;stub.fire('PLAYER_REGEN_ENABLED');assert(d.view:IsShown())
guide:Click();d.root:Hide();stub.advance(0.3)
assert(not PolestarDaylightDockTabs:IsShown() and p.UI.GuideFrame.frame:GetParent()==p.UIParent)
assert(p.UI.GuideFrame.frame:IsShown())
d.root:Show();stub.advance(0.3)
assert(PolestarDaylightDockTabs:IsShown() and PolestarDaylightDockContent:IsShown() and not d.view:IsShown())
d.afk=true;stub.advance(0.3);assert(not PolestarDaylightDockTabs:IsShown())
d.afk=false;stub.advance(0.3);assert(PolestarDaylightDockContent:IsShown())
d.enabled=false;stub.advance(0.5);assert(not PolestarDaylightDockTabs:IsShown() and not PolestarTrackerDockTabs)
emit({ok=true})`);
	assert.deepEqual(out, {ok:true});
});

test('Daylight waits for its tracker instead of docking to the emptied Blizzard tracker', () => {
	const [out] = run(`
assert(not PolestarDaylightDockTabs and not PolestarTrackerDockTabs)
d.tracker.built=true;stub.advance(0.3);tabs();emit({ok=true})`, {delay:true});
	assert.deepEqual(out, {ok:true});
});

test('Daylight docking stays off by default', () => {
	const [out] = run(`assert(not PolestarDaylightDockTabs and d.view:IsShown());emit({ok=true})`, {enabled:false});
	assert.deepEqual(out, {ok:true});
});

test('the released standalone Daylight host retains ownership without duplicate native tabs', () => {
	const [out] = run(`assert(not PolestarDaylightDockTabs and not p.UI.TrackerDock.DaylightHost);emit({ok=true})`, {standalone:true});
	assert.deepEqual(out, {ok:true});
});

test('Daylight dock surfaces belong to Polestar visibility and hiding restores the external quest list', () => {
	const [out] = run(`
quests,guide=tabs();guide:Click()
assert(PolestarDaylightDockTabs:GetParent()==p.UIParent)
assert(PolestarDaylightDockContent:GetParent()==p.UIParent)
p.SetHidden(true);stub.advance(0.3)
assert(not PolestarDaylightDockTabs:IsVisible() and not PolestarDaylightDockContent:IsVisible())
assert(d.view:IsVisible() and d.bar:IsVisible(),'external quest list not restored')
p.SetHidden(false);stub.advance(0.3)
assert(PolestarDaylightDockTabs:IsVisible())
emit({ok=true})`);
	assert.deepEqual(out, {ok:true});
});
