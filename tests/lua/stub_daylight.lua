local ADDON, ns = ...
local root = CreateFrame('Frame','DaylightUIQuestTracker',UIParent)
root:SetSize(226,160);root:SetFrameStrata('LOW');root:SetFrameLevel(4);root.y=600
local view=CreateFrame('ScrollFrame',nil,root)
view:SetSize(226,100);view:SetPoint('TOPRIGHT',root,'TOPRIGHT');view.y=600
-- The base UI stub records anchors but does not solve them. Model the
-- fixed top/width of these anchored frames, independently of content height.
view.GetTop=function() return root:GetTop() end
local getTop,getWidth=stub.Methods.GetTop,stub.Methods.GetWidth
function stub.Methods.GetTop(self)
 if self:GetName()=='PolestarDaylightDockContent' then
  return view:GetTop()*view:GetEffectiveScale()/self:GetEffectiveScale()
 end
 return getTop(self)
end
function stub.Methods.GetWidth(self)
 if self:GetName()=='PolestarDaylightDockContent' then return view:GetWidth() end
 return getWidth(self)
end
local content=CreateFrame('Frame',nil,view);content:SetSize(226,100);view:SetScrollChild(content)
local box=CreateFrame('Frame',nil,root);box:Hide()
local controls=CreateFrame('Frame',nil,root);controls:Hide()
local items=CreateFrame('Frame',nil,UIParent)
local header=CreateFrame('Frame',nil,content)
header.label=header:CreateFontString();header.label:SetFont('daylight-quest-font.ttf',12,'OUTLINE');header.label:SetText('Quests')
local cfg={width=226,maxHeight=560,sizes={header=12},colors={headerMode='custom',header={0.9,0.8,0.7},headerLineMode='custom',headerLine={0.3,0.4,0.5}},box=false}
stub.daylight={cfg=cfg,enabled=true,wanted=true,root=root,view=view,items=items,header=header}
local function get(path)
 local value=cfg
 for key in path:gmatch('[^.]+') do value=type(value)=='table' and value[key] or nil end
 return value
end
DaylightUI={API={major=1,minor=11},Style={},Gradients={},On=function() end,Get=function(_,scope,path) return get(path) end,
 IsSecret=function() return false end,MEDIA='daylight-media/',Win={Parts={}}}
DaylightUI.Style.Accent=function() return 0.2,0.8,0.6 end
DaylightUI.Style.ClassTextColor=function() return 0.8,0.3,0.7 end
DaylightUI.Style.ClassColor=DaylightUI.Style.ClassTextColor
DaylightUI.Style.Upper=function(s) return s:upper() end
DaylightUI.Style.PaintAccent=function(tex,a) tex:SetVertexColor(0.2,0.8,0.6,a) end
DaylightUI.GetModule=function() return {ns=ns,db=cfg} end
DaylightUI.L=setmetatable({}, {__index=function(_,k) return k end})
local api=DaylightUI.API
api.GetFrame=function(key) if key=='questtracker' then return root end end
api.GetSetting=function(scope,path) return get(path) end
api.IsModuleEnabled=function() return stub.daylight.enabled end
api.IsAfkScreen=function() return stub.daylight.afk end
api.Font=function() return 'daylight-font.ttf' end
api.Colors=function() return {OFF={0.4,0.4,0.45}} end
api.Text=function(parent,size,justify)
 local f=parent:CreateFontString();f:SetFont(api.Font(),12,'');f:SetJustifyH(justify or 'LEFT');return f
end
api.Skin=function(frame,opts) frame.daylightSkin=opts end
api.For=function(name) return {Hook=function(tbl,key,fn)
 assert(tbl~=root and tbl~=view and tbl~=items,'frame method hook forbidden')
 local original=tbl[key];assert(type(original)=='function',key)
 tbl[key]=function(...) original(...);fn(...) end
end} end
ns.Blizzard={starved=true};ns.Bridge={Loaded=function() return false end}
ns.Items={holder=items,Follow=function() items:Show() end}
-- Daylight's bar is a sibling of the ScrollFrame, so view:Hide() cannot hide it.
local bar=CreateFrame('Frame',nil,root);bar:SetHeight(560)
ns.Scroll={bar=bar,offset=120,Paint=function() bar:SetAlpha(0.8) end}
stub.daylight.bar=bar
-- A small host contract fixture. Daylight's licensed source is not bundled.
ns.Look={
 Get=function(db) return {c=db.colors,s=db.sizes} end,
 PaintText=function(label,look,key,text) label:SetText(text);label:SetTextColor(unpack(look.c[key])) end,
 PaintTexture=function(tex,look,key,alpha) tex:SetVertexColor(look.c[key][1],look.c[key][2],look.c[key][3],alpha) end,
}
ns.Tracker={}
local t=ns.Tracker
local wanted=function() return ns.Blizzard.starved end
t.Wanted=function() return stub.daylight.wanted and wanted() end
t.mod={db=cfg};t.built=true;t.holder=root;t.view=view;t.box=box;t.controls=controls;t.frames={['section:quests']=header}
t.Look=function() return ns.Look.Get(cfg) end
t.FitBox=function() box:SetShown(cfg.box) end
t.Hovered=function() controls:SetShown(stub.daylight.hover==true) end
t.Render=function() t.FitBox();t.Hovered();ns.Items.Follow() end
stub.daylight.tracker=t;stub.daylight.parts=ns
