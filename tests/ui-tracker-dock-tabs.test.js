'use strict';
const {test} = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const {runAddon} = require('./helpers/lua');
const P = require('../tools/commands/preview');
const {ROOT} = require('../tools/lib/paths');
const metrics = P.metricsLua(P.loadFonts());

for (const scale of [0.64, 1, 1.5]) {
	test(`docked tabs keep their native placement and remain inside the scroll viewport at scale ${scale}`, () => {
		const [out] = runAddon({
			stubs:['stub_ui.lua'],
			before:`${P.panelBefore({}, metrics)}
local savedEmit=emit
dofile(${JSON.stringify(path.join(ROOT,'tools/play/driver.lua'))})
emit=savedEmit
C_Texture={GetAtlasInfo=function() return {} end}
UIParent:SetScale(${scale})
ObjectiveTrackerFrame=CreateFrame('Frame',nil,UIParent)
ObjectiveTrackerFrame:SetSize(300,650)
ObjectiveTrackerFrame:SetPoint('TOPLEFT',UIParent,'TOPLEFT',500,-100)
ObjectiveTrackerFrame.HeaderMenu=false;ObjectiveTrackerFrame.Header=false`,
			addons:[{name:'Polestar',files:['Core/Core.xml','Theme/Theme.xml','UI/UI.xml']}],
			saved:{Polestar:"PolestarDB={schema=1,settings={ui={trackerDock=true,shown=true}}};PolestarCharDB={trackerDockTab='polestar'}"},
			script:`
uistub.install();stub.login();stub.advance(0.5)
uistub.openTabs({{uistub.elwynn,3},{uistub.tailoring,2}},1);stub.advance(0.5)
local GF=Polestar.UI.GuideFrame
local d=GF.dock
local function rect(f) local x,y,w,h=play.rectOf(f);return x,y,x+w,y+h end
local function within(f,outer)
 local l,t,r,b=rect(f);local ol,ot,orr,ob=rect(outer)
 assert(l>=ol-1 and b<=ob+1 and r<=orr+1 and t>=ot-1,'tab clipped: '..tostring(GF.TabStyle()))
end
local checked=0
for _,style in ipairs({'default','strip','edge','switcher','underline','strip'}) do
 Polestar.Set('guideWindow.tabStyle',style~='default' and style or nil)
 Polestar.Set('ui.compact',checked==5)
 stub.advance(0.4)
 local kind=GF.TabStyle()
 local own=GF.TabStyleFrames()
 local external=kind=='strip' and own.side or kind=='edge' and own.edge
 local fl,fb,fr,ft=rect(GF.frame)
 local hl,hb,hr,ht=rect(d.holder)
 assert(math.abs(fl-hl)<1 and math.abs(fr-hr)<1,'guide shifted or shrunk '..style..' '..fl..' '..hl..' '..fr..' '..hr)
 if external then
  within(external,d.pane)
  for _,button in ipairs(external.tabs) do if button:IsShown() then within(button,d.pane) end end
  within(external.Add,d.pane)
  if kind=='strip' then local l=rect(external);assert(l<fl-10,'left tabs moved inside guide') end
  if kind=='edge' then
   local _,top=rect(external)
   local _,_,_,rowBottom=rect(PolestarTrackerDockTabs)
   assert(rowBottom<=top+1,'edge tabs overlap tracker heading')
  end
  external.tabs[2]:Click('LeftButton');stub.advance(0.3)
  local _,active=Polestar.Engine.GetTabs();assert(active==2,'tab not clickable')
  external.tabs[1]:Click('LeftButton');stub.advance(0.3)
 end
 assert(d.holder:GetHeight()<=d.available+0.5,'dock exceeds tracker maximum')
 checked=checked+1
end
assert(#play.errors==0,play.errors[1] and play.errors[1].msg or '')
emit({checked=checked})`,
		}).emitted;
		assert.deepEqual(out,{checked:6});
	});
}
