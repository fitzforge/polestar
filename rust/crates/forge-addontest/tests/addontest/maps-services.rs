use forge_addontest::codex::{write_codex_pack, CodexOpts};
use forge_addontest::dsl::plain;
use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use forge_data::codex::merge::merge_codex;
use forge_data::codex::{Forever, Inputs};
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

const BEFORE: &str = r#"
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
"#;

// The layer is opt-in with a lean category set (see the defaults test below); most tests turn it and every
// category on, and open the world map, which is when the layer first reads the Codex.
const ALL_FILTERS: &str = "serviceFilters={repair=true,mailbox=true,class=true,weapon=true,auctioneer=true,banker=true,battlemaster=true,spirithealer=true,stablemaster=true,trainer=true,vendor=true}";
const OPEN_MAP: &str = "WorldMapFrame:Show()\nstub.runMapFrame(WorldMapFrame,0)\nstub.advance(0.25)\n";

fn run_opts(script: &str, enabled: Option<bool>, settings: &str) -> Vec<Value> {
	let pins = enabled.map(|e| format!("servicePins={e},")).unwrap_or_default();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: BEFORE.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml"])],
		saved: vec![("Polestar".into(), format!("PolestarDB={{schema=1, settings={{maps={{{pins}{settings}}}}}}}; Polestar.Codex=__codex"))],
		login: true,
		script: format!("stub.advance(0.25)\n{OPEN_MAP}local M,P=Polestar.Maps,Polestar.Pins\n{script}"),
	})
}

fn run(script: &str) -> Value {
	run_opts(script, Some(true), ALL_FILTERS).remove(0)
}

fn run_off(script: &str) -> Value {
	run_opts(script, Some(false), ALL_FILTERS).remove(0)
}

#[test]
fn service_groups_tolerate_missing_mapcanvas_and_install_the_watcher_once_when_it_becomes_available() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Maps/Maps.lua", "Maps/ServiceClusters.lua"])],
		login: true,
		script: r#"
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
      emit({missing=missing,withoutFrame=withoutFrame,calls=calls})"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "missing": true, "withoutFrame": 0, "calls": 1 }));
}

#[test]
fn services_use_codex_alone_with_live_coordinates_reject_hostile_npcs_and_invalid_spawns_leave_inns_to_the_travel_layer_and_distinguish_mailbox_ids() {
	let out = run(r#"
    local out={}
    for _,p in ipairs(P.GetLayer("maps.services") or {}) do
      out[#out+1]={id=p.id,kind=p.kind,category=p.category,map=p.map,x=p.x,y=p.y,f=p.f}
    end
    emit(out)
  "#);
	assert_eq!(
		out,
		json!([
			{ "id": 1, "kind": "npc", "category": "repair", "map": 9000, "x": 40, "y": 50, "f": "l" },
			{ "id": 1, "kind": "npc", "category": "repair", "map": 9000, "x": 0, "y": 0, "f": "l" },
			{ "id": 5, "kind": "npc", "category": "class", "map": 9000, "x": 44, "y": 50, "f": "l" },
			{ "id": 6, "kind": "npc", "category": "trainer", "map": 9000, "x": 45, "y": 50, "f": "l" },
			{ "id": 7, "kind": "npc", "category": "weapon", "map": 9000, "x": 46, "y": 50, "f": "l" },
			{ "id": 1, "kind": "object", "category": "mailbox", "map": 9000, "x": 48, "y": 50, "f": "l" },
		])
	);
}

#[test]
fn category_toggles_update_immediately_without_rereading_the_db_or_misclassifying_class_and_weapon_trainers() {
	let out = run(r#"
    local reads=__reads
    Polestar.Set("maps.serviceFilters.repair",false)
    Polestar.Set("maps.serviceFilters.weapon",false)
    local found={}
    for _,p in ipairs(P.GetLayer("maps.services")) do found[p.category]=(found[p.category] or 0)+1 end
    Polestar.Set("maps.servicePins",false)
    local hidden=P.GetLayer("maps.services")==nil
    Polestar.Set("maps.servicePins",true)
    emit({categories=found,hidden=hidden,readsSame=__reads==reads,restored=#P.GetLayer("maps.services")})
  "#);
	assert_eq!(out, json!({ "categories": { "vendor": 2, "class": 1, "trainer": 1, "mailbox": 1 }, "hidden": true, "readsSame": true, "restored": 5 }));
}

#[test]
fn tooltips_expose_all_npc_services_and_a_click_routes_to_the_exact_spawn_and_frame() {
	let out = run(r#"
    local pin=P.GetLayer("maps.services")[1]
    local lines={}
    pin.tooltip({SetText=function(_,s) lines[#lines+1]=s end,AddLine=function(_,s) lines[#lines+1]=s end})
    local target
    Polestar.Nav.SetTarget=function(...) target={...} end
    pin.onClick("RightButton")
    local right=target==nil
    pin.onClick("LeftButton")
    emit({lines=lines,target=target,right=right})
  "#);
	assert_eq!(out["lines"], json!(["Smith", "Weaponsmith", "Repair \u{b7} Vendors", "40.0, 50.0", "Click to set a waypoint"]));
	assert_eq!(out["target"], json!([9000, 40, 50, "Smith", "l", "npc"]));
	assert_eq!(out["right"], true);
}

#[test]
fn explicitly_disabled_services_read_no_db_combat_defers_the_scan_and_one_driver_handles_rapid_toggles() {
	let out = run_off(
		r#"
    local initial=__reads
    stub.inCombat=true
    Polestar.Set("maps.servicePins",true)
    local combatReads=__reads
    stub.inCombat=false
    stub.fire("PLAYER_REGEN_ENABLED")
    for i=1,10 do Polestar.Set("maps.serviceFilters.vendor",i%2==0) end
    stub.advance(1)
    emit({initial=initial,combatReads=combatReads,reads=__reads,pins=#P.GetLayer("maps.services")})
  "#,
	);
	assert_eq!(out, json!({ "initial": 0, "combatReads": 0, "reads": 8, "pins": 6 }));
}

#[test]
fn batched_work_pauses_in_combat_resumes_and_retries_after_a_missing_database_is_enabled() {
	let out = run_off(
		r#"
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
  "#,
	);
	assert_eq!(out["missing"], true);
	assert_eq!(out["paused"], true);
	assert_eq!(out["first"], 100);
	assert_eq!(out["reads"], 499);
	assert_eq!(out["pins"], 6);
}

#[test]
fn tracking_menus_offer_persistent_categories_and_minimap_opt_in() {
	let out = run(r#"
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
  "#);
	assert_eq!(out["title"], "Polestar: NPC services");
	assert_eq!(out["count"], 13);
	assert_eq!(out["before"], true);
	assert_eq!(out["after"], false);
	assert_eq!(out["minimap"], true);
	assert!(out["frames"].as_f64().unwrap() > 0.0);
	assert_eq!(out["hooks"], 2, "the existing Nearby services menu remains registered");
}

#[test]
fn a_synchronous_codex_load_event_selects_the_codex_once_without_a_second_scan() {
	let out = run_off(
		r#"
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
  "#,
	);
	assert_eq!(out, json!({ "loads": 1, "reads": 1, "id": 21, "frame": "e" }));
}

#[test]
fn nearby_mailbox_observations_merge_across_object_ids_while_separate_physical_mailboxes_keep_their_original_coordinates() {
	let out = run_off(
		r#"
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
  "#,
	);
	assert_eq!(out, json!([{ "id": 1, "x": 48 }, { "id": 3, "x": 52 }]));
}

#[test]
fn nearby_observations_of_one_service_npc_share_a_pin_without_merging_different_npcs_or_distant_spawns() {
	let out = run(r#"
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
  "#);
	assert_eq!(
		out,
		json!({
			"count": 20,
			"categories": {"vendor":2,"repair":2,"banker":2,"auctioneer":2,"trainer":2,"weapon":2,"battlemaster":2,"spirithealer":2,"stablemaster":2,"class":2},
			"first": {"id":1,"x":40,"y":50,"f":"l"}, "second": {"id":1,"x":45},
			"target": {"map":9000,"x":40,"y":50,"f":"l"}, "unchanged": true,
		})
	);
}

#[test]
fn service_observations_compare_world_positions_across_maps_and_keep_map_frame_groups_without_world_conversion() {
	let out = run(r#"
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
  "#);
	assert_eq!(
		out,
		json!([
			{"map":9000,"x":40,"f":"l"}, {"map":9100,"x":40.2,"f":"e"}, {"map":9101,"x":40,"f":"l"},
			{"map":9199,"x":40,"f":"l"}, {"map":9199,"x":40,"f":"e"}, {"map":9199,"x":45},
		])
	);
}

#[test]
fn the_reported_gishah_observations_produce_one_original_undercity_waypoint() {
	let out = run(r#"
    stub.world.addMap(1458,{c=0,left=873.193,right=-86.182,top=1877.945,bottom=1237.841})
    local spawns={}
    for _,xy in ipairs({{64.4,38.4},{64.4,38.6},{64.6,38.6},{64.8,38.2},{65.6,38.4},{65.6,38.6}}) do
      spawns[#spawns+1]={map=1458,x=xy[1],y=xy[2]}
    end
    local pins=M.BuildServicePins({{id=214098,name="Gishah",roles={"vendor"},spawns=spawns}})
    emit({count=#pins,x=pins[1].x,y=pins[1].y,observations=#spawns})
  "#);
	assert_eq!(out, json!({"count":1,"x":64.4,"y":38.4,"observations":6}));
}

#[test]
fn zephras_repair_and_vendor_observations_share_original_locations_even_without_world_bounds() {
	let out = run(r#"
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
  "#);
	assert_eq!(
		out,
		json!({
			"unknown": [{"id":251364,"x":42.5,"y":23.4},{"id":251365,"x":43.2,"y":23.4},{"id":252449,"x":58.4,"y":74.6}],
			"known": [{"id":251364,"x":42.5,"y":23.4},{"id":251365,"x":43.2,"y":23.4},{"id":252449,"x":58.4,"y":74.6}],
			"target": {"1":2521,"2":42.5,"3":23.4,"4":"Destin Thriceforged","6":"npc"}, "raw": 21,
		})
	);
}

#[test]
fn the_records_kept_for_filter_changes_are_slim_and_friendly_only() {
	let out = run(r#"
    __npcs[1].loot,__npcs[1].level={5},30
    __objects[3]={id=3,name="Mailbox",mailbox=true,faction="H",loot={},spawns={{map=9000,x=60,y=50,f="l"}}}
    local npcs,boxes=M.ServiceSource(),M.ServiceMailboxSource()
    local smith=npcs.read(1)
    emit({fields=(function() local k={} for f in pairs(smith) do k[#k+1]=f end table.sort(k) return k end)(),
      shared=smith==__npcs[1],enemy=npcs.read(2)==nil,hostileBox=boxes.read(3)==nil,box=boxes.read(1).kind})
  "#);
	assert_eq!(out, json!({ "fields": ["faction", "id", "name", "roles", "spawns", "subName"], "shared": false, "enemy": true, "hostileBox": true, "box": "object" }));
}

#[test]
fn services_are_opt_in_with_a_lean_category_set_leave_flight_masters_and_inns_to_the_travel_layers_and_give_each_category_its_own_map_glyph() {
	let res = run_opts(
		r#"
    local icons,on={},{}
    for _,category in ipairs(M.ServiceCategories) do
      icons[category.key]=category.mark
      if Polestar.Get("maps.serviceFilters."..category.key) then on[#on+1]=category.key end
    end
    emit({enabled=Polestar.Get("maps.servicePins"),on=on,inn=icons.innkeeper==nil,flight=icons.flightmaster==nil,
      vendor=icons.vendor,banker=icons.banker,reads=__reads})
    emit(M.ServiceCategories[4].icon)
  "#,
		None,
		"",
	);
	let (out, weapon) = (&res[0], text(&res[1]));
	assert!(weapon.contains("AddOns") && weapon.ends_with("icon-trainer-weapon"), "{weapon}");
	assert_eq!(
		*out,
		json!({
			"enabled": false,
			"on": ["mailbox", "class"],
			"inn": true,
			"flight": true,
			"vendor": "map:vendor",
			"banker": "map:bank",
			"reads": 0,
		})
	);
}

const CITY_MAP: &str = r#"
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
"#;

fn run_city(script: &str) -> Value {
	run(&format!("{CITY_MAP}{script}"))
}

#[test]
fn only_city_services_share_a_region_map_stack_nearby_country_services_quests_and_minimap_pins_remain_individual() {
	let out = run_city(
		r#"
    P.SetLayer("quests",{{map=9000,x=50,y=50,icon="icon-quest"}},{minimap=false})
    local f=groupFrame()
    local lines={}
    f.data.pin.tooltip({SetText=function(_,s) lines[#lines+1]=s end,AddLine=function(_,s) lines[#lines+1]=s end})
    local out={frames=#P.GetWorldFrames(),city=f.data.pin.city,count=f.data.pin.count,
      icons=#f.data.pin.stack,badge=f.data.pin.badge,raw=#P.GetLayer("maps.services"),
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
  "#,
	);
	let got: Vec<Value> = ["frames", "city", "count", "icons", "badge", "raw", "minimap"].iter().map(|k| out[*k].clone()).collect();
	assert_eq!(Value::from(got), json!([5, 9002, 3, 3, 3, 6, 6]));
	assert_eq!(out["lines"][0], "Test City");
	let lines = out["lines"].as_array().unwrap();
	assert!(lines.contains(&json!("3 service points")));
	assert!(lines.contains(&json!("Click to expand")));
	assert_eq!(out["regionZoomed"], 5, "a city summary persists while viewing the region");
	assert_eq!(out["cityFrames"], 7, "six individual services and the separate quest pin in the city view");
	assert_eq!(out["cityGroup"], false);
	assert_eq!(out["decorationsHidden"], true);
}

#[test]
fn a_region_city_pile_lists_npcs_with_coordinates_and_routes_to_the_selected_spawn_without_opening_another_map() {
	let out = run_city(
		r#"
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
  "#,
	);
	assert_eq!(out["right"], true);
	assert!(is_match(text(&out["category"]), r"Vendors \(23\)"));
	assert_eq!(out["rows"], 12);
	assert!(is_match(text(&out["name"]), r"Vendor 11.*40\.1, 50\.0"));
	assert_eq!(out["target"], json!([9002, 40.11, 50, "Vendor 11", "l", "npc"]));
	assert_eq!(out["opened"], 0);
	assert_eq!(out["map"], 9000);
	assert_eq!(out["closed"], true);
}

#[test]
fn the_npc_menu_survives_unrelated_redraws_and_closes_on_detail_map_or_filter_changes() {
	let out = run_city(
		r#"
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
  "#,
	);
	assert_eq!(out, json!({ "kept": true, "detailClosed": true, "filterClosed": true }));
}

#[test]
fn detail_maps_group_by_their_region_hierarchy_even_without_city_flags_detail_views_keep_individual_pins() {
	let out = run_city(
		r#"
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
  "#,
	);
	assert_eq!(
		out,
		json!({ "count": 5, "cities": [{ "city": 9002, "count": 3 }, { "city": 9003, "count": 3 }], "city": 9, "submap": 9, "continent": 9, "withoutCityAPI": 5, "unsupported": 9, "gamepad": 5 })
	);
}

#[test]
fn the_built_in_region_catalog_includes_tirisfal_and_forever_regions_while_capital_maps_stay_detailed() {
	let out = run(r#"
    emit({tirisfal=M.GetZoneLevels(1420)~=nil,zephras=M.GetZoneLevels(2521)~=nil,
      undercity=M.GetZoneLevels(1458)~=nil,stormwind=M.GetZoneLevels(1453)~=nil})
  "#);
	assert_eq!(out, json!({ "tirisfal": true, "zephras": true, "undercity": false, "stormwind": false }));
}

#[test]
fn native_clickable_detail_areas_group_even_when_the_city_and_region_are_siblings_under_a_continent() {
	let out = run_city(
		r#"
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
  "#,
	);
	assert_eq!(out, json!({ "count": 3, "hitCalls": true, "detailCount": 6, "detailGroup": false, "directIndividual": true }));
}

#[test]
fn codex_weapon_masters_use_the_existing_npc_index_without_changing_shared_records_or_object_ids() {
	let out = run_off(
		r#"
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
  "#,
	);
	assert_eq!(out, json!({ "category": "weapon", "withoutProfession": 1, "withoutWeapon": 0, "professionOnly": 0, "roles": ["trainer"], "object": "mailbox" }));
}

#[test]
fn a_fresh_install_leaves_the_codex_unloaded_until_the_layer_is_on_and_the_world_map_opens_then_reads_service_npcs_and_faction_safe_mailboxes_from_it_with_no_questiedb() {
	let v = |j: Value| parse_json(&j.to_string()).unwrap();
	let place = json!({ "9000": { "f": "l", "pts": [[40, 50], [40.1, 50.1]] } });
	let mut objects = serde_json::Map::new();
	for (i, faction) in [json!("A"), json!("H"), json!("AH"), Value::Null].into_iter().enumerate() {
		let id = 101 + i;
		objects.insert(
			id.to_string(),
			json!({ "id": id, "name": if i == 0 { "Postal box" } else { "Mailbox" }, "roles": ["mailbox"], "faction": faction, "spawns": { "9000": { "f": "l", "pts": [[50 + i * 10, 50]] } } }),
		);
	}
	let inputs = Inputs {
		forever: Forever {
			items: V::Null,
			npcs: v(json!({
				"101": { "id": 101, "name": "Smith", "subName": "Weaponsmith", "faction": "A", "roles": ["vendor", "repair"], "spawns": place },
				"102": { "id": 102, "name": "Mage", "subName": "Mage Trainer", "faction": "A", "roles": ["trainer"], "spawns": place },
				"103": { "id": 103, "name": "Warrior", "subName": "Warrior Trainer", "faction": "A", "roles": ["trainer"], "spawns": place },
			})),
			objects: v(Value::Object(objects)),
			quests: V::Null,
			zones: v(json!({ "9000": { "id": 9000, "name": "Test Zone" } })),
			factions: V::Null,
			professions: V::Null,
			trainers: V::Null,
			map_frames: V::Null,
			meta: V::Null,
			instances: V::Null,
			dungeons: V::Null,
		},
		atlasloot: None,
		rarescanner: None,
		local_extras: false,
		flbis: None,
		client: None,
		web: None,
		curated: Vec::new(),
		curated_gates: V::Null,
		entrances: Vec::new(),
		entrance_table: V::Null,
		rep_table: V::Null,
		attunement_table: V::Null,
		journal_quests: Vec::new(),
		warnings: Vec::new(),
	};
	let m = merge_codex(&inputs);
	let codex = json!({
		"items": plain(&V::Obj(m.items)),
		"npcs": plain(&V::Obj(m.npcs)),
		"objects": plain(&V::Obj(m.objects)),
		"quests": plain(&V::Obj(m.quests)),
		"instances": plain(&V::Obj(m.instances)),
		"zones": plain(&V::Obj(m.zones)),
		"factions": plain(&V::Obj(m.factions)),
		"spells": plain(&V::Obj(m.spells)),
		"frames": plain(&V::Obj(m.frames)),
	});
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: pack.stub_lua.clone() + "\nstub.maps.useWorld(); stub.maps.place(0,0); stub.world.faction=\"Alliance\"; LibQuestieDB=nil",
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Lookup/Codex.lua", "Maps/Maps.xml"])],
		saved: vec![("Polestar".into(), "PolestarDB={schema=1,settings={}}".into())],
		login: true,
		script: r#"stub.advance(1)
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
        emit(out)"#
			.into(),
	})
	.remove(0);
	assert_eq!(out["atLogin"], false, "the Codex stays unloaded at login");
	assert_eq!(out["beforeMap"], false, "turning the layer on reads nothing until the world map opens");
	assert_eq!(out["loaded"], true);
	assert_eq!(out["questie"], false);
	// The lean default set: class trainers and mailboxes; the repair vendor stays opt-in.
	assert_eq!(out["npcs"], json!([{ "id": 103, "category": "class", "x": 40, "y": 50 }]));
	assert_eq!(out["boxes"], json!([{ "id": 101, "category": "mailbox", "x": 50, "y": 50 }, { "id": 103, "category": "mailbox", "x": 70, "y": 50 }]));
	drop(pack);
}
