'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const BEFORE = String.raw`
stub.maps.useWorld()
stub.maps.place(0, 0)
stub.world.faction = "Alliance"
stub.menus = {}
Menu = { ModifyMenu = function(tag, fn)
  stub.menus[tag] = stub.menus[tag] or {}
  table.insert(stub.menus[tag], fn)
end }
__reads, __spawns = 0, 0
__npcs = {
  [1] = { name="Smith", subName="Weaponsmith", faction="A", roles={"vendor","repair"}, points={{40,50},{40,50},{-1,20},{0,0},{101,5}} },
  [2] = { name="Enemy", faction="H", roles={"vendor"}, points={{41,50}} },
  [3] = { name="Neutral", faction="AH", roles={"innkeeper","vendor"}, points={{42,50}} },
  [4] = { name="Mage", subName="Mage Trainer", faction="A", roles={"trainer","class:MAGE"}, points={{43,50}} },
  [5] = { name="Warrior", subName="Warrior Trainer", faction="A", roles={"trainer","class:WARRIOR"}, points={{44,50}} },
  [6] = { name="Alchemist", subName="Alchemy Trainer", faction="A", roles={"trainer","trainer:171"}, points={{45,50}} },
  [7] = { name="Master", subName="Weapon Master", faction="A", roles={"trainer","weapon"}, points={{46,50}} },
  [8] = { name="Mob", roles={}, points={{47,50}} },
  [9] = { name="Hostile vendor", roles={"vendor"}, points={{48,50}} },
}
for id,npc in pairs(__npcs) do
  npc.id,npc.spawns=id,{}
  for _,p in ipairs(npc.points) do npc.spawns[#npc.spawns+1]={map=9000,x=p[1],y=p[2],f="l"} end
end
__objects={
  [1]={id=1,name="Mailbox",mailbox=true,faction="A",spawns={{map=9000,x=48,y=50,f="l"}}},
  [2]={id=2,name="Chest",spawns={{map=9000,x=49,y=50,f="l"}}},
}
__codex={
  IsLoaded=function() return true end,
  WithRole=function(role)
    local ids={}
    for id,npc in pairs(__npcs) do
      for _,r in ipairs(npc.roles) do if r==role then ids[#ids+1]=id; break end end
    end
    table.sort(ids); return ids
  end,
  Npc=function(id) __reads=__reads+1; return __npcs[id] end,
  Each=function(kind,fn) for id,obj in pairs(__objects) do fn(id,obj.name) end end,
  Object=function(id) return __objects[id] end,
}
LibQuestieDB=setmetatable({},{__index=function() error("POIs must not read QuestieDB") end})
`;

// The layer is opt-in with a lean category set (see the defaults test below);
// most tests turn it and every category on, and open the world map, which is
// when the layer first reads the Codex.
const ALL_FILTERS = 'serviceFilters={repair=true,mailbox=true,class=true,weapon=true,auctioneer=true,banker=true,battlemaster=true,spirithealer=true,stablemaster=true,trainer=true,vendor=true}';
const OPEN_MAP = 'WorldMapFrame:Show()\nstub.runMapFrame(WorldMapFrame,0)\nstub.advance(0.25)\n';

function run(script, { enabled = true, before = '', settings = ALL_FILTERS, open = true } = {}) {
  return runAddon({
    stubs: ['stub_world.lua', 'stub_maps.lua'], before: BEFORE + before,
    addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.xml'] }],
    saved: { Polestar: `PolestarDB={schema=1, settings={maps={${enabled === null ? '' : `servicePins=${enabled},`}${settings}}}}; Polestar.Codex=__codex` }, login: true,
    script: 'stub.advance(0.25)\n' + (open ? OPEN_MAP : '') + 'local M,P=Polestar.Maps,Polestar.Pins\n' + script,
  }).emitted;
}

test('service groups tolerate missing MapCanvas and install the watcher once when it becomes available', () => {
  const [out] = runAddon({
    stubs: ['stub_world.lua'],
    addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Maps/Maps.lua', 'Maps/ServiceClusters.lua'] }],
    login: true,
    script: `
      local missing=Polestar.MapCanvas==nil
      stub.addonLoaded("Blizzard_WorldMap")
      local frame,calls=WorldMapFrame,0
      WorldMapFrame=nil
      Polestar.MapCanvas={Watch=function(map) assert(map==frame); calls=calls+1; return {} end}
      stub.addonLoaded("Blizzard_WorldMap")
      local withoutFrame=calls
      WorldMapFrame=frame
      stub.addonLoaded("Blizzard_WorldMap")
      stub.addonLoaded("Blizzard_WorldMap")
      emit({missing=missing,withoutFrame=withoutFrame,calls=calls})`,
  }).emitted;
  assert.deepEqual(out, { missing: true, withoutFrame: 0, calls: 1 });
});

test('services use Codex alone with live coordinates, reject hostile NPCs and invalid spawns, leave inns to the travel layer, and distinguish mailbox IDs', () => {
  const [out] = run(`
    local out={}
    for _,p in ipairs(P.GetLayer("maps.services") or {}) do
      out[#out+1]={id=p.id,kind=p.kind,category=p.category,map=p.map,x=p.x,y=p.y,f=p.f}
    end
    emit(out)
  `);
  assert.deepEqual(out, [
    { id: 1, kind: 'npc', category: 'repair', map: 9000, x: 40, y: 50, f: 'l' },
    { id: 1, kind: 'npc', category: 'repair', map: 9000, x: 0, y: 0, f: 'l' },
    { id: 5, kind: 'npc', category: 'class', map: 9000, x: 44, y: 50, f: 'l' },
    { id: 6, kind: 'npc', category: 'trainer', map: 9000, x: 45, y: 50, f: 'l' },
    { id: 7, kind: 'npc', category: 'weapon', map: 9000, x: 46, y: 50, f: 'l' },
    { id: 1, kind: 'object', category: 'mailbox', map: 9000, x: 48, y: 50, f: 'l' },
  ]);
});

test('category toggles update immediately without rereading the DB or misclassifying class and weapon trainers', () => {
  const [out] = run(`
    local reads=__reads
    Polestar.Set("maps.serviceFilters.repair",false)
    Polestar.Set("maps.serviceFilters.weapon",false)
    local found={}
    for _,p in ipairs(P.GetLayer("maps.services")) do found[p.category]=(found[p.category] or 0)+1 end
    Polestar.Set("maps.servicePins",false)
    local hidden=P.GetLayer("maps.services")==nil
    Polestar.Set("maps.servicePins",true)
    emit({categories=found,hidden=hidden,readsSame=__reads==reads,restored=#P.GetLayer("maps.services")})
  `);
  assert.deepEqual(out, { categories: { vendor: 2, class: 1, trainer: 1, mailbox: 1 }, hidden: true, readsSame: true, restored: 5 });
});

test('tooltips expose all NPC services and a click routes to the exact spawn and frame', () => {
  const [out] = run(`
    local pin=P.GetLayer("maps.services")[1]
    local lines={}
    pin.tooltip({SetText=function(_,s) lines[#lines+1]=s end,AddLine=function(_,s) lines[#lines+1]=s end})
    local target
    Polestar.Nav.SetTarget=function(...) target={...} end
    pin.onClick("RightButton")
    local right=target==nil
    pin.onClick("LeftButton")
    emit({lines=lines,target=target,right=right})
  `);
  assert.deepEqual(out.lines, ['Smith', 'Weaponsmith', 'Repair · Vendors', '40.0, 50.0', 'Click to set a waypoint']);
  assert.deepEqual(out.target, [9000, 40, 50, 'Smith', 'l', 'npc']);
  assert.equal(out.right, true);
});

test('explicitly disabled services read no DB; combat defers the scan and one driver handles rapid toggles', () => {
  const [out] = run(`
    local initial=__reads
    stub.inCombat=true
    Polestar.Set("maps.servicePins",true)
    local combatReads=__reads
    stub.inCombat=false
    stub.fire("PLAYER_REGEN_ENABLED")
    for i=1,10 do Polestar.Set("maps.serviceFilters.vendor",i%2==0) end
    stub.advance(1)
    emit({initial=initial,combatReads=combatReads,reads=__reads,pins=#P.GetLayer("maps.services")})
  `, { enabled: false });
  assert.deepEqual(out, { initial: 0, combatReads: 0, reads: 8, pins: 6 });
});

test('batched work pauses in combat, resumes, and retries after a missing database is enabled', () => {
  const [out] = run(`
    for id=10,500 do __npcs[id]={name="Unfriendly vendor",roles={"vendor"}} end
    local db=Polestar.Codex
    Polestar.Codex=nil
    Polestar.Set("maps.servicePins",true)
    local missing=P.GetLayer("maps.services")==nil
    Polestar.Codex=db
    stub.addonLoaded("Polestar_Codex")
    local first=__reads
    stub.inCombat=true; stub.advance(0.1)
    local paused=__reads==first
    stub.inCombat=false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(1)
    emit({missing=missing,paused=paused,first=first,reads=__reads,pins=#P.GetLayer("maps.services")})
  `, { enabled: false });
  assert.equal(out.missing, true);
  assert.equal(out.paused, true);
  assert.equal(out.first, 100);
  assert.equal(out.reads, 499);
  assert.equal(out.pins, 6);
});

test('tracking menus offer persistent categories and minimap opt-in', () => {
  const [out] = run(`
    local function node(text)
      local n={text=text,kids={}}
      function n:CreateButton(t) local k=node(t); self.kids[#self.kids+1]=k; return k end
      function n:CreateCheckbox(t,selected,fn) local k=self:CreateButton(t); k.selected,k.fn=selected,fn; return k end
      function n:CreateDivider() end
      return n
    end
    local root=node("root")
    M.AddServiceMenu(nil,root)
    local sub=root.kids[1]
    local repair=sub.kids[3]
    local before=repair.selected()
    repair.fn()
    sub.kids[2].fn()
    stub.advance(0.1)
    emit({title=sub.text,count=#sub.kids,before=before,after=repair.selected(),minimap=Polestar.Get("maps.serviceMinimap"),
      hooks=#stub.menus.MENU_WORLD_MAP_TRACKING,frames=#P.GetMinimapFrames("maps.services")})
  `);
  assert.equal(out.title, 'Polestar: NPC services');
  assert.equal(out.count, 13);
  assert.equal(out.before, true);
  assert.equal(out.after, false);
  assert.equal(out.minimap, true);
  assert.ok(out.frames > 0);
  assert.equal(out.hooks, 2, 'the existing Nearby services menu remains registered');
});

test('a synchronous Codex load event selects the Codex once, without a second scan', () => {
  const [out] = run(`
    local loaded,loads,reads=false,0,0
    Polestar.Codex={
      IsLoaded=function() return loaded end,
      Load=function() loads=loads+1; loaded=true; Polestar.Fire("CODEX_LOADED"); return true end,
      WithRole=function(role) return role=="vendor" and {21} or {} end,
      Npc=function(id) reads=reads+1; return {id=id,name="Codex vendor",faction="A",roles={"vendor"},spawns={{map=9000,x=50,y=50,f="e"}}} end,
    }
    Polestar.Set("maps.servicePins",true); stub.advance(0.2)
    local pins=P.GetLayer("maps.services")
    emit({loads=loads,reads=reads,id=pins[1].id,frame=pins[1].f})
  `, { enabled: false });
  assert.deepEqual(out, { loads: 1, reads: 1, id: 21, frame: 'e' });
});

test('nearby mailbox observations merge across object IDs while separate physical mailboxes keep their original coordinates', () => {
  const [out] = run(`
    M.ServiceMailboxSource=function()
      return { ids={1,2,3},read=function(id)
        local x=({48,48.2,52})[id]
        return {id=id,kind="object",name="Mailbox",roles={"mailbox"},spawns={{map=9000,x=x,y=50,f="l"}}}
      end }
    end
    Polestar.Set("maps.servicePins",true); stub.advance(0.2)
    local out={}
    for _,p in ipairs(P.GetLayer("maps.services")) do if p.kind=="object" then out[#out+1]={id=p.id,x=p.x} end end
    emit(out)
  `, { enabled: false });
  assert.deepEqual(out, [{ id: 1, x: 48 }, { id: 3, x: 52 }]);
});

test('nearby observations of one service NPC share a pin without merging different NPCs or distant spawns', () => {
  const [out] = run(`
    local records={}
    for _,role in ipairs({"vendor","repair","banker","auctioneer","trainer","weapon","battlemaster","spirithealer","stablemaster","class:WARRIOR"}) do
      records[#records+1]={id=#records+1,name=role,roles={role},spawns={
        {map=9000,x=40,y=50,f="l"},{map=9000,x=40.2,y=50.2,f="l"},
        {map=9000,x=42.5,y=50,f="l"},{map=9000,x=45,y=50,f="l"},
      }}
    end
    local before=records[1].spawns[1]
    local pins=M.BuildServicePins(records)
    local counts={}
    for _,p in ipairs(pins) do counts[p.category]=(counts[p.category] or 0)+1 end
    local p=pins[1]
    p.onClick("LeftButton")
    local target=Polestar.Nav.GetTarget()
    emit({count=#pins,categories=counts,first={id=p.id,x=p.x,y=p.y,f=p.f},
      second={id=pins[2].id,x=pins[2].x},target={map=target.map,x=target.x,y=target.y,f=target.f},
      unchanged=records[1].spawns[1]==before and #records[1].spawns==4})
  `);
  assert.deepEqual(out, {
    count: 20,
    categories: Object.fromEntries(['vendor','repair','banker','auctioneer','trainer','weapon','battlemaster','spirithealer','stablemaster','class'].map(k => [k,2])),
    first: { id:1, x:40, y:50, f:'l' }, second: { id:1, x:45 },
    target: { map:9000, x:40, y:50, f:'l' }, unchanged:true,
  });
});

test('service observations compare world positions across maps and keep map/frame groups without world conversion', () => {
  const [out] = run(`
    stub.world.addMap(9100,{c=0,left=1000,right=-1000,top=1000,bottom=-1000})
    stub.world.addMap(9101,{c=1,left=1000,right=-1000,top=1000,bottom=-1000})
    local saved=Polestar.MapFrames.era[9100]
    Polestar.MapFrames.era[9100]={c=0,left=2000,right=0,top=1000,bottom=-1000}
    local pins=M.BuildServicePins({{id=101,name="Service",roles={"repair"},spawns={
      {map=9000,x=40,y=50,f="l"},{map=9100,x=40.2,y=50,f="l"},
      {map=9100,x=90,y=50,f="e"},{map=9100,x=40.2,y=50,f="e"},
      {map=9101,x=40,y=50,f="l"},
      {map=9199,x=40,y=50,f="l"},{map=9199,x=40,y=50,f="l"},
      {map=9199,x=40,y=50,f="e"},{map=9199,x=40.2,y=50,f="l"},
      {map=9199,x=40.3,y=50},{map=9199,x=45,y=50},
    }}})
    local rows={}
    for _,p in ipairs(pins) do rows[#rows+1]={map=p.map,x=p.x,f=p.f} end
    Polestar.MapFrames.era[9100]=saved
    emit(rows)
  `);
  assert.deepEqual(out, [
    {map:9000,x:40,f:'l'}, {map:9100,x:40.2,f:'e'}, {map:9101,x:40,f:'l'},
    {map:9199,x:40,f:'l'}, {map:9199,x:40,f:'e'}, {map:9199,x:45},
  ]);
});

test('the reported Gishah observations produce one original Undercity waypoint', () => {
  const [out] = run(`
    stub.world.addMap(1458,{c=0,left=873.193,right=-86.182,top=1877.945,bottom=1237.841})
    local spawns={}
    for _,xy in ipairs({{64.4,38.4},{64.4,38.6},{64.6,38.6},{64.8,38.2},{65.6,38.4},{65.6,38.6}}) do
      spawns[#spawns+1]={map=1458,x=xy[1],y=xy[2]}
    end
    local pins=M.BuildServicePins({{id=214098,name="Gishah",roles={"vendor"},spawns=spawns}})
    emit({count=#pins,x=pins[1].x,y=pins[1].y,observations=#spawns})
  `);
  assert.deepEqual(out, {count:1,x:64.4,y:38.4,observations:6});
});

test('Zephras repair and vendor observations share original locations even without world bounds', () => {
  const [out] = run(`
    local records={
      {id=251364,name="Destin Thriceforged",roles={"repair","vendor"},points={
        {42.5,23.4},{42.8,23.5},{43,24.2},{43.1,23.4},{43.1,23.5},{43.2,23.8},
        {43.2,23.2},{43.2,23.6},{43.3,23.6},{43.4,23.6},{43.4,23.4}}},
      {id=251365,name="Jolee Brightmeadows",roles={"repair","vendor"},points={
        {43.2,23.4},{43.2,23.5},{43.2,23.8},{43.3,23.2},{43.3,23.8},{43.5,23.6}}},
      {id=252449,name="Iallion Featherfall",roles={"vendor"},points={
        {58.4,74.6},{58.6,76.1},{58.8,75.2},{58.9,75.5}}},
    }
    for _,r in ipairs(records) do
      r.spawns={}
      for _,p in ipairs(r.points) do r.spawns[#r.spawns+1]={map=2521,x=p[1],y=p[2]} end
    end
    local function summary()
      local out={}
      for _,p in ipairs(M.BuildServicePins(records)) do out[#out+1]={id=p.id,x=p.x,y=p.y} end
      return out
    end
    local unknown=summary()
    -- Synthetic large bounds exercise the world-conversion path too; these are not Zephras measurements.
    stub.world.addMap(2521,{c=0,left=5000,right=-5000,top=5000,bottom=-5000})
    local known=summary()
    local pin=M.BuildServicePins(records)[1]
    local target
    Polestar.Nav.SetTarget=function(...) target={...} end
    pin.onClick("LeftButton")
    emit({unknown=unknown,known=known,target=target,raw=#records[1].spawns+#records[2].spawns+#records[3].spawns})
  `);
  const points = [{id:251364,x:42.5,y:23.4},{id:251365,x:43.2,y:23.4},{id:252449,x:58.4,y:74.6}];
  assert.deepEqual(out, {unknown:points,known:points,target:{1:2521,2:42.5,3:23.4,4:'Destin Thriceforged',6:'npc'},raw:21});
});

test('the records kept for filter changes are slim and friendly only', () => {
  const [out] = run(`
    __npcs[1].loot,__npcs[1].level={5},30
    __objects[3]={id=3,name="Mailbox",mailbox=true,faction="H",loot={},spawns={{map=9000,x=60,y=50,f="l"}}}
    local npcs,boxes=M.ServiceSource(),M.ServiceMailboxSource()
    local smith=npcs.read(1)
    emit({fields=(function() local k={} for f in pairs(smith) do k[#k+1]=f end table.sort(k) return k end)(),
      shared=smith==__npcs[1],enemy=npcs.read(2)==nil,hostileBox=boxes.read(3)==nil,box=boxes.read(1).kind})
  `);
  assert.deepEqual(out, { fields: ['faction', 'id', 'name', 'roles', 'spawns', 'subName'], shared: false, enemy: true, hostileBox: true, box: 'object' });
});

test('services are opt-in with a lean category set, leave flight masters and inns to the travel layers, and use the vendor gossip icon and a distinct chest for bankers', () => {
  const [out, weapon] = run(`
    local icons,on={},{}
    for _,category in ipairs(M.ServiceCategories) do
      icons[category.key]=category.icon
      if Polestar.Get("maps.serviceFilters."..category.key) then on[#on+1]=category.key end
    end
    emit({enabled=Polestar.Get("maps.servicePins"),on=on,inn=icons.innkeeper==nil,flight=icons.flightmaster==nil,
      vendor=icons.vendor,banker=icons.banker,reads=__reads})
    emit(icons.weapon)
  `, { enabled: null, settings: '' });
  assert.ok(weapon.includes('AddOns') && weapon.endsWith('icon-train'));
  assert.deepEqual(out, {
    enabled: false,
    on: ['mailbox', 'class'],
    inn: true,
    flight: true,
    vendor: 'Interface\\GossipFrame\\VendorGossipIcon',
    banker: 'Interface\\Icons\\INV_Misc_TreasureChest01a',
    reads: 0,
  });
});

const CITY_MAP = String.raw`
M.RegisterZoneLevels({[9000]={1,10,50,50}})
stub.world.addMap(9002,{name="Test City",mapType=3,parent=9000,c=0,top=200,bottom=-200,left=200,right=-200})
stub.world.addMap(9003,{name="Other City",mapType=3,parent=9000,c=0,top=200,bottom=-200,left=900,right=700})
C_Map.IsCityMap=function(map) return map==9002 or map==9003 end
local opened={}
C_Map.OpenWorldMap=function(map)
  opened[#opened+1]=map
  stub.worldMapID=map
  stub.runMapFrame(WorldMapFrame,0)
end
local pins=M.BuildServicePins({
  {id=101,name="City Smith",roles={"repair"},spawns={{map=9002,x=30,y=50,f="l"}}},
  {id=102,name="City Banker",roles={"banker"},spawns={{map=9002,x=50,y=50,f="l"}}},
  {id=103,name="City Vendor",roles={"vendor"},spawns={{map=9002,x=70,y=50,f="l"}}},
  {id=104,name="Country Vendor 1",roles={"vendor"},spawns={{map=9000,x=40,y=50,f="l"}}},
  {id=105,name="Country Vendor 2",roles={"vendor"},spawns={{map=9000,x=40.1,y=50,f="l"}}},
  {id=106,name="Country Vendor 3",roles={"vendor"},spawns={{map=9000,x=40.2,y=50,f="l"}}},
})
P.SetLayer("maps.services",pins,{worldLayout=M.LayoutServicePins,minMapType=3,minimap=true})
local canvas=WorldMapFrame:GetCanvas()
canvas:SetSize(1000,1000)
stub.worldMapID=9000
WorldMapFrame:Show()
stub.runMapFrame(WorldMapFrame,0)
local function groupFrame()
  for _,f in ipairs(P.GetWorldFrames()) do if f.data.pin.members then return f end end
end
`;

test('only city services share a region-map stack; nearby country services, quests and minimap pins remain individual', () => {
  const [out] = run(CITY_MAP + `
    P.SetLayer("quests",{{map=9000,x=50,y=50,icon="icon-quest"}},{minimap=false})
    local f=groupFrame()
    local lines={}
    f.data.pin.tooltip({SetText=function(_,s) lines[#lines+1]=s end,AddLine=function(_,s) lines[#lines+1]=s end})
    local out={frames=#P.GetWorldFrames(),city=f.data.pin.city,count=f.data.pin.count,
      icons=#f.data.pin.stack,badge=f.count~=nil,raw=#P.GetLayer("maps.services"),
      minimap=#P.GetMinimapFrames("maps.services"),lines=lines}
    WorldMapFrame.ScrollContainer.currentScale=6
    WorldMapFrame.ScrollContainer.zoomPercent=1
    stub.runMapFrame(WorldMapFrame,0)
    out.regionZoomed=#P.GetWorldFrames()
    stub.worldMapID=9002; stub.runMapFrame(WorldMapFrame,0)
    out.cityFrames=#P.GetWorldFrames()
    out.cityGroup=groupFrame()~=nil
    out.decorationsHidden=not f.stackIcons[1]:IsShown()
    emit(out)
  `);
  assert.deepEqual([out.frames,out.city,out.count,out.icons,out.badge,out.raw,out.minimap], [5,9002,3,3,false,6,6]);
  assert.equal(out.lines[0],'Test City');
  assert.ok(out.lines.includes('3 service points'));
  assert.ok(out.lines.includes('Click to expand'));
  assert.equal(out.regionZoomed,5,'a city summary persists while viewing the region');
  assert.equal(out.cityFrames,7,'six individual services and the separate quest pin in the city view');
  assert.equal(out.cityGroup,false);
  assert.equal(out.decorationsHidden,true);
});

test('a region city pile lists NPCs with coordinates and routes to the selected spawn, without opening another map', () => {
  const [out] = run(CITY_MAP + `
    local records={}
    for id=1,23 do records[#records+1]={id=id,name=("Vendor %02d"):format(id),roles={"vendor"},
      spawns={{map=9002,x=40+id/100,y=50,f="l"}}} end
    P.SetLayer("maps.services",M.BuildServicePins(records),{worldLayout=M.LayoutServicePins,minimap=false,minMapType=3})
    local f=groupFrame()
    local target
    Polestar.Nav.SetTarget=function(...) target={...} end
    f.data.pin.onClick("RightButton",f)
    local right=PolestarMenu==nil
    stub.RunScript(f,"OnEnter")
    stub.fire("GLOBAL_MOUSE_DOWN","LeftButton")
    stub.fire("GLOBAL_MOUSE_UP","LeftButton")
    stub.RunScript(f,"OnLeave")
    local category=PolestarMenu.rows[1].Text:GetText()
    PolestarMenu.rows[1]:Click()
    local rows=0
    for _,r in ipairs(PolestarMenu.rows) do if r:IsShown() then rows=rows+1 end end
    for _,r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText()=="Next" then r:Click(); break end end
    local name=PolestarMenu.rows[2].Text:GetText()
    PolestarMenu.rows[2]:Click()
    emit({right=right,category=category,rows=rows,name=name,target=target,
      opened=#opened,map=stub.worldMapID,closed=not PolestarMenu:IsShown()})
  `);
  assert.equal(out.right,true);
  assert.match(out.category,/Vendors \(23\)/);
  assert.equal(out.rows,12);
  assert.match(out.name,/Vendor 11.*40\.1, 50\.0/);
  assert.deepEqual(out.target,[9002,40.11,50,'Vendor 11','l','npc']);
  assert.equal(out.opened,0);
  assert.equal(out.map,9000);
  assert.equal(out.closed,true);
});

test('the NPC menu survives unrelated redraws and closes on detail-map or filter changes', () => {
  const [out] = run(CITY_MAP + `
    local f=groupFrame()
    f.data.pin.onClick("LeftButton",f)
    P.SetLayer("quests",{{map=9000,x=10,y=10}},{minimap=false})
    P.GetWorldFrames()
    local kept=PolestarMenu:IsShown()
    stub.worldMapID=9002; stub.runMapFrame(WorldMapFrame,0)
    local detailClosed=not PolestarMenu:IsShown()
    stub.worldMapID=9000; stub.runMapFrame(WorldMapFrame,0)
    f=groupFrame(); f.data.pin.onClick("LeftButton",f)
    Polestar.Set("maps.servicePins",false)
    emit({kept=kept,detailClosed=detailClosed,filterClosed=not PolestarMenu:IsShown()})
  `);
  assert.deepEqual(out,{kept:true,detailClosed:true,filterClosed:true});
});

test('detail maps group by their region hierarchy even without city flags; detail views keep individual pins', () => {
  const [out] = run(CITY_MAP + `
    stub.world.addMap(9004,{name="City Basement",mapType=5,parent=9002,c=0,top=200,bottom=-200,left=200,right=-200})
    local projected={}
    for i=1,9 do
      local map=i<=3 and 9004 or i<=6 and 9003 or 9000
      projected[#projected+1]={x=50,y=50,pin={map=map,x=50,y=50,name="Vendor "..i,category="vendor",icon="bag"}}
    end
    local function layout(map) return M.LayoutServicePins(projected,{mapID=map}) end
    C_Map.IsCityMap=function() return false end
    local arranged=layout(9000)
    local cities={}
    for _,d in ipairs(arranged) do if d.pin.city then cities[#cities+1]={city=d.pin.city,count=d.pin.count} end end
    local city=#layout(9002)
    local submap=#layout(9004)
    stub.world.maps[9000].mapType=2
    local continent=#layout(9000)
    stub.world.maps[9000].mapType=3
    C_Map.IsCityMap=nil
    local withoutCityAPI=#layout(9000)
    C_Map.IsCityMap=function(map) return map==9002 or map==9003 end
    Polestar.GamepadUI=function() return true end
    local gamepad=#layout(9000)
    local getInfo=C_Map.GetMapInfo
    C_Map.GetMapInfo=nil
    local unsupported=#layout(9000)
    C_Map.GetMapInfo=getInfo
    emit({count=#arranged,cities=cities,city=city,submap=submap,continent=continent,withoutCityAPI=withoutCityAPI,unsupported=unsupported,gamepad=gamepad})
  `);
  assert.deepEqual(out,{count:5,cities:[{city:9002,count:3},{city:9003,count:3}],city:9,submap:9,continent:9,withoutCityAPI:5,unsupported:9,gamepad:5});
});


test('the built-in region catalog includes Tirisfal and Forever regions, while capital maps stay detailed', () => {
  const [out] = run(`
    emit({tirisfal=M.GetZoneLevels(1420)~=nil,zephras=M.GetZoneLevels(2521)~=nil,
      undercity=M.GetZoneLevels(1458)~=nil,stormwind=M.GetZoneLevels(1453)~=nil})
  `);
  assert.deepEqual(out,{tirisfal:true,zephras:true,undercity:false,stormwind:false});
});

test('native clickable detail areas group even when the city and region are siblings under a continent', () => {
  const [out] = run(CITY_MAP + `
    stub.world.addMap(9005,{name="Continent",mapType=2})
    stub.world.maps[9000].parent=9005
    stub.world.maps[9002].parent=9005
    C_Map.IsCityMap=function() return false end
    local hitCalls=0
    C_Map.GetMapInfoAtPosition=function(map,x,y)
      hitCalls=hitCalls+1
      if map==9000 and x>=0.45 and x<=0.55 and y>=0.4 and y<=0.6 then return C_Map.GetMapInfo(9002) end
      return C_Map.GetMapInfo(map)
    end
    stub.world.addMap(9004,{name="Basement",mapType=5,parent=9002,c=0,top=200,bottom=-200,left=200,right=-200})
    local basement={}
    for i=1,3 do basement[i]={x=50,y=50,pin={map=9004,x=50,y=50,name="Vendor "..i,category="vendor",icon="bag"}} end
    local direct=M.LayoutServicePins(basement,{mapID=9002})
    local directIndividual=#direct==3 and direct[1].pin.members==nil
    P.SetLayer("maps.services",pins,{worldLayout=M.LayoutServicePins,minMapType=3,minimap=true})
    local f=groupFrame()
    local count=f and f.data.pin.count or 0
    stub.worldMapID=9002; stub.runMapFrame(WorldMapFrame,0)
    emit({count=count,hitCalls=hitCalls>0,detailCount=#P.GetWorldFrames(),detailGroup=groupFrame()~=nil,directIndividual=directIndividual})
  `);
  assert.deepEqual(out,{count:3,hitCalls:true,detailCount:6,detailGroup:false,directIndividual:true});
});

test('Codex weapon masters use the existing NPC index without changing shared records or object IDs', () => {
  const [out] = run(`
    local npc={id=11867,name="Woo Ping",faction="A",roles={"trainer"},spawns={{map=9000,x=50,y=50,f="l"}}}
    Polestar.Codex={IsLoaded=function() return true end,
      WithRole=function(role) return role=="trainer" and {11867} or {} end,
      Npc=function() return npc end}
    M.ServiceMailboxSource=function() return nil end
    Polestar.Set("maps.servicePins",true); stub.advance(0.2)
    local category=P.GetLayer("maps.services")[1].category
    Polestar.Set("maps.serviceFilters.trainer",false)
    local withoutProfession=#P.GetLayer("maps.services")
    Polestar.Set("maps.serviceFilters.weapon",false)
    local withoutWeapon=#P.GetLayer("maps.services")
    Polestar.Set("maps.serviceFilters.trainer",true)
    local professionOnly=#P.GetLayer("maps.services")
    local object=M.BuildServicePins({{id=11867,kind="object",name="Mailbox",roles={"mailbox"},spawns=npc.spawns}})
    emit({category=category,withoutProfession=withoutProfession,withoutWeapon=withoutWeapon,
      professionOnly=professionOnly,roles=npc.roles,object=object[1].category})
  `, {enabled:false});
  assert.deepEqual(out,{category:'weapon',withoutProfession:1,withoutWeapon:0,professionOnly:0,roles:['trainer'],object:'mailbox'});
});

test('a fresh install leaves the Codex unloaded until the layer is on and the world map opens, then reads service NPCs and faction-safe mailboxes from it with no QuestieDB', () => {
  const { mergeCodex } = require('../tools/lib/codex/build');
  const { writeCodexPack } = require('./helpers/codex');
  const place = { 9000: { f: 'l', pts: [[40,50],[40.1,50.1]] } };
  const codex = mergeCodex({ forever: {
    zones: { 9000: { id: 9000, name: 'Test Zone' } },
    npcs: {
      101: { id: 101, name: 'Smith', subName: 'Weaponsmith', faction: 'A', roles: ['vendor','repair'], spawns: place },
      102: { id: 102, name: 'Mage', subName: 'Mage Trainer', faction: 'A', roles: ['trainer'], spawns: place },
      103: { id: 103, name: 'Warrior', subName: 'Warrior Trainer', faction: 'A', roles: ['trainer'], spawns: place },
    },
    objects: Object.fromEntries(['A','H','AH',null].map((faction,i) => [101+i,
      { id:101+i, name:i===0?'Postal box':'Mailbox', roles:['mailbox'], faction, spawns:{9000:{f:'l',pts:[[50+i*10,50]]}} } ])),
  } });
  const pack = writeCodexPack(codex);
  try {
    const [out] = runAddon({
      stubs: ['stub_world.lua','stub_maps.lua'],
      before: pack.stubLua + '\nstub.maps.useWorld(); stub.maps.place(0,0); stub.world.faction="Alliance"; LibQuestieDB=nil',
      addons: [{ name:'Polestar', files:['Core/Core.xml','Theme/Theme.xml','Nav/Nav.xml','Lookup/Codex.lua','Maps/Maps.xml'] }],
      saved: { Polestar:'PolestarDB={schema=1,settings={}}' }, login:true,
      script: `stub.advance(1)
        local atLogin=Polestar.Codex.IsLoaded()
        Polestar.Set("maps.servicePins",true)
        stub.advance(1)
        local beforeMap=Polestar.Codex.IsLoaded()
        WorldMapFrame:Show(); stub.runMapFrame(WorldMapFrame,0); stub.advance(1)
        local out={atLogin=atLogin,beforeMap=beforeMap,loaded=Polestar.Codex.IsLoaded(),questie=LibQuestieDB~=nil,npcs={},boxes={}}
        for _,p in ipairs(Polestar.Pins.GetLayer("maps.services")) do
          local list=p.kind=="object" and out.boxes or out.npcs
          list[#list+1]={id=p.id,category=p.category,x=p.x,y=p.y}
        end
        emit(out)`,
    }).emitted;
    assert.equal(out.atLogin,false,'the Codex stays unloaded at login');
    assert.equal(out.beforeMap,false,'turning the layer on reads nothing until the world map opens');
    assert.equal(out.loaded,true);
    assert.equal(out.questie,false);
    // The lean default set: class trainers and mailboxes; the repair vendor stays opt-in.
    assert.deepEqual(out.npcs,[{id:103,category:'class',x:40,y:50}]);
    assert.deepEqual(out.boxes,[{id:101,category:'mailbox',x:50,y:50},{id:103,category:'mailbox',x:70,y:50}]);
  } finally { pack.cleanup(); }
});
