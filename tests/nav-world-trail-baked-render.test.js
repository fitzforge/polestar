'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const files = ['Core/Init.lua', 'Nav/WorldTrail.lua', 'Maps/RouteSparkle.lua',
 'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua'];
function runtime(script) {
 const result = runAddon({stubs:['stub_world_trail.lua'], addons:[{name:'Polestar',files}], script:`
 local W=stub.worldTrail; W.install()
 local NS=Polestar.WorldTrail; local T,R=NS.Trail,NS.Render
 local function near(a,b,note) assert(type(a)=='number' and math.abs(a-b)<1e-6,(note or 'mismatch')..': '..tostring(a)..' vs '..b) end
 local function snapshot(slope)
  local s={c=0,n=3,m=101,stripYd=2,xs={0,100,200},ys={0,0,0},zs={900,900,900},
   distances={0,100,200},strip={},trimOffset=3.25,generation=1,tail=70}
  for i=1,s.m do s.strip[i]=100+(i-1)*2*slope end
  return s
 end
 local accepted=snapshot(.1); local progress={sourceAlong=10.75,along=7.5,off=0,generation=1}
 local getterCalls=0
 Polestar.Nav.walk={WorldTrail=function() getterCalls=getterCalls+1; return accepted,progress end,Floor=function() return nil end}
 Polestar.Nav.BakedLeg=function() error('renderer must not decode a leg') end
 stub.login()
 Polestar.Set('nav.worldTrail',true); Polestar.Set('nav.worldTrailFlow',0)
 Polestar.Set('nav.worldTrailWidth',0); Polestar.Set('nav.worldTrailSight',false)
 local function frame(dt) stub.advance(dt or .05) end
 local projected={}; local project=T.Project
 T.Project=function(cam,x,y,z) projected[#projected+1]={x=x,y=y,z=z}; return project(cam,x,y,z) end
 `+script+`
 assert(#Polestar.Errors()==0,'no swallowed runtime errors'); emit(true)
 `}).emitted;
 assert.equal(result[0],true);
}
test('baked sight retains its settled reach when terrain temporarily becomes unavailable', () => runtime(`
 accepted=snapshot(0); for i=1,accepted.m do accepted.strip[i]=0 end
 progress.sourceAlong=10; NS.db.groundSight=true; NS.db.groundLength=50
 local wall=false
 local function cellX(x) return math.floor((x+29.5*1600/3)/(1600/3/128)) end
 W.engine(function(c,x,y,out)
  if wall and cellX(x)>=cellX(35) and cellX(x)<=cellX(44) then return 0 end
  out[1],out[-1]=0,0; return 1
 end)
 frame(2.5); local s=R.Sight(); near(s.drawn,50)
 wall=true; NS.Terrain.Reset(); frame(4)
 assert(s.drawn<40 and s.drawn>=12,'real LOS shrinks toward wall')
 local held=s.drawn
 Polestar_NavEngine=nil; NS.Terrain.Reset(); frame(1)
 assert(s.drawn and math.abs(s.drawn-held)<.1,'temporary unknown keeps settled LOS reach')
`));

test('strip sampling has exact bounds in the decoded 2D domain with no tail or rescale', () => runtime(`
 local s=snapshot(.1); s.m=8; s.distances={0,4,13.3}; s.xs={0,4,13.3}
 local p=T.BakedPath(s)
 near(p.coverage,13.3); near(T.BakedHeight(p,0),100)
 near(T.BakedHeight(p,3.25),100.325); near(T.BakedHeight(p,13.3),101.33)
 assert(T.BakedHeight(p,-.01)==nil and T.BakedHeight(p,13.31)==nil)
 s=snapshot(.1); s.m=8; p=T.BakedPath(s)
 near(p.coverage,14); near(T.BakedHeight(p,14),101.4)
 assert(T.BakedHeight(p,14.01)==nil,'no lastZ or endpoint-tail extension')
 for _,bad in ipairs({0,-1,math.huge,0/0}) do s.stripYd=bad; assert(T.BakedPath(s)==nil) end
`));

test('curve drawing uses original arrays and native progress rather than smoothing or global nearest', () => runtime(`
 accepted.xs={0,30,30}; accepted.ys={0,0,100}; accepted.distances={0,30,130}
 W.route={legs={{kind='walk',current=true,pts={{0,0,0},{0,30,0},{0,30,100}}}}}
 T.Smooth=function() error('baked paths must not be Chaikin smoothed') end
 T.Nearest=function() error('baked paths must not reproject progress') end
 local emitPath,from; local emitted={}; local emitBase=T.Emit
 T.Emit=function(p,a,spacing,phase,limit,fn)
  emitPath,from=p,a
  return emitBase(p,a,spacing,phase,limit,function(x,y,...) emitted[#emitted+1]={x=x,y=y}; return fn(x,y,...) end)
 end
 frame(2.1)
 assert(emitPath.xs==accepted.xs and emitPath.cum==accepted.distances,'read-only original-array adapter')
 near(from,progress.sourceAlong+NS.db.groundAhead)
 local turned=false
 for _,v in ipairs(emitted) do
  if v.y>0 then turned=true; near(v.x,30,'original vertical leg before approximate lateral scatter') end
 end
 assert(turned,'emission reaches original corner')
 near(accepted.xs[2],30); near(accepted.ys[2],0); near(accepted.distances[2],30)
 near(accepted.strip[2],100.2); near(accepted.trimOffset,3.25)
`));

test('U-turn and fresh progress keep follower branch and cache only the snapshot adapter', () => runtime(`
 accepted.xs={0,200,200,0}; accepted.ys={0,0,5,5}; accepted.n=4
 accepted.distances={0,200,205,405}; accepted.m=204
 for i=1,accepted.m do accepted.strip[i]=100+(i-1)*.2 end
 W.px=20; W.py=4; progress.sourceAlong=20; progress.off=4
 local raw=T.BakedPath(accepted)
 assert(T.Nearest(raw,0,W.px,W.py)>300,'global nearest would jump to the return branch')
 local builds=0; local build=T.BakedPath
 T.BakedPath=function(s) builds=builds+1; return build(s) end
 frame(2.1); near(R.Probe().sourceAlong,20); near(builds,1)
 local n=getterCalls; progress={sourceAlong=21.25,off=4,generation=1}; frame()
 assert(getterCalls>n,'getter rechecked each paint'); near(builds,1)
 near(R.Probe().sourceAlong,21.25); near(R.Probe().floor,102.125)
 accepted=snapshot(.2); progress={sourceAlong=10.75,off=0,generation=1}; frame()
 near(builds,2); near(R.Probe().floor,102.15)
`));

test('lost eligibility, missing strips and uncovered progress immediately use visible unstale fallback', () => runtime(`
 frame(2.1); local good=accepted
 local function fallback(note)
  projected={}; frame()
  assert(R.GroundFrame().used>0,note..' stays visible')
  assert(R.Probe().heightSource=='camera-estimate',note..' source')
  assert(R.Probe().floor==nil and R.HeightsAhead()==nil and R.HeightsRise()==nil,note..' no stale heights')
  for _,v in ipairs(projected) do near(v.z,NS.db.groundLift,'fallback is not old strip Z') end
 end
 accepted=nil; fallback('dynamic/split/pending getter rejection')
 accepted=snapshot(.1); accepted.m=0; accepted.strip={}; fallback('no strip')
 accepted=snapshot(.1); accepted.m=4; fallback('past coverage')
 accepted=good; progress.generation=2; fallback('mismatched progress')
 progress.generation=1; frame(); assert(R.Probe().heightSource=='baked-strip','fresh metadata recovers')
 near(W.writes,0)
`));

test('terrain is visibility-only and every disabled or disallowed LOS entry is avoided', () => runtime(`
 local Tr=NS.Terrain; local calls={begin=0,sees=0}; local inTerrain=0
 local begin,sees,cell=Tr.Begin,Tr.Sees,Tr.Cell
 Tr.Cell=function(...) assert(inTerrain>0,'no renderer height Cell'); return cell(...) end
 for _,name in ipairs({'Seed','Nearest','Closest','Indoor'}) do Tr[name]=function() error('no renderer terrain height '..name) end end
 Tr.Begin=function(...) calls.begin=calls.begin+1; inTerrain=inTerrain+1; local r=begin(...); inTerrain=inTerrain-1; return r end
 Tr.Sees=function(...) calls.sees=calls.sees+1; inTerrain=inTerrain+1; local r=sees(...); inTerrain=inTerrain-1; return r end
 W.engine(function(c,x,y,out) out[1],out[-1]=100,0; return 1 end)
 frame(2.1); near(calls.begin,0); near(calls.sees,0)
 Polestar.Nav.walk.Floor=function(c,x,y) near(c,0); near(x,W.px); return 100.5 end
 NS.db.groundSight=true; frame(.3)
 assert(calls.begin>0 and calls.sees>0,'LOS uses existing Begin and Sees')
 near(R.Probe().floor,100.5); assert(R.Probe().floorSource=='observed-walk-floor')
 local function blocked(note)
  calls.begin,calls.sees=0,0; frame(.3); near(calls.begin,0,note); near(calls.sees,0,note)
 end
 NS.db.groundSight=false; blocked('LOS disabled')
 NS.db.groundSight=true; Polestar.Set('nav.arrow',false); blocked('arrow disabled')
 Polestar.Set('nav.arrow',true); progress.off=26; blocked('off route')
 progress.off=0; accepted=nil; blocked('fallback has no route Z baseline')
 near(W.writes,0)
`));

test('invalid strip metadata falls back visibly rather than claiming coverage across a hole', () => runtime(`
 accepted.strip[20]=nil
 frame(2.1)
 assert(R.GroundFrame().used>0,'unusable strip must preserve visible fallback')
 assert(R.Probe().heightSource=='camera-estimate','hole is not complete baked coverage')
 assert(R.HeightsAhead()==nil and R.HeightsRise()==nil,'no fabricated coverage')
`));

test('observed floor updates settle without a four-yard sprite jump', () => runtime(`
 local floorZ=100
 Polestar.Nav.walk.Floor=function() return floorZ end
 frame(2.1)
 projected={}; frame(.05)
 local before=projected[1].z
 floorZ=104
 projected={}; frame(.05)
 local delta=before-projected[1].z
 assert(delta>0 and delta<1,'observed cell change eases the drawn baseline: '..delta)
 near(R.Probe().floor,104,'diagnostics retain the observed floor')
 near(accepted.strip[2],100.2,'no mutation of baked heights')
`));

test('accepted strip visibly rises using fractional native progress, not endpoint Z', () => runtime(`
 frame(2.1)
 assert(R.GroundFrame().used>0,'baked route draws')
 local p=R.Probe()
 assert(p.heightSource=='baked-strip','accepted strip must be the height source')
 assert(p.floorSource=='baked-strip estimate','unknown floor uses an explicit estimate')
 near(p.floor,101.075); near(p.ahead,189.25); near(p.rise,18.925)
 assert(getterCalls>0,'fresh acceptance queried')
 local raised=false
 for _,v in ipairs(projected) do if v.z>NS.db.groundLift+1 then raised=true end end
 assert(raised,'actual projected sprites rise')
 local pool=#R.GroundFrame().stars; frame(); near(#R.GroundFrame().stars,pool,'pool reused')
 Polestar.Set('nav.worldTrailMax',10); frame(); assert(R.GroundFrame().used<=10)
 near(W.writes,0)
`));
