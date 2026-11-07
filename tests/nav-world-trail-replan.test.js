'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const B = require('../tools/lib/nav/bake');
const { runAddon } = require('./helpers/lua');
const encoded = B.encodeLeg({ pts: [[0, 0, 10], [0, -200, 30]], cls: [0], floor: [0], tail: 0,
 strip: Array.from({ length: 100 }, (_, i) => 10 + i * 0.25) });
test('same-destination native Replan preserves usable heights of the retained baked walking path', () => {
 const [out] = runAddon({
  stubs: ['stub_world_trail.lua', 'stub_nav.lua'],
  before: `fake={calls={}}
Polestar_NavEngine={
 Find=function(map,from,to,callback,opts)
  local j={map=map,from=from,to=to,callback=callback,opts=opts}
  fake.calls[#fake.calls+1]=j; return j
 end,
 Cancel=function(j) j.cancelled=true end,
 Busy=function() return false end, Available=function() return true end,
}`,
  addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml',
   'Maps/RouteSparkle.lua', 'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua'] }],
  login: true,
  script: `
local N,nav,W=Polestar.Nav,stub.nav,stub.worldTrail
local R=Polestar.WorldTrail.Render
local guide={id="t/replan-probe",legs={[1]=${JSON.stringify(encoded)}}}
Polestar.Engine.GetGuide=function() return guide end
nav.engine.views[1]={goals={{map=9000,x=60,y=50}}}
W.facing=-math.pi/2; nav.facing=W.facing
nav.place(0,-20)
local m,x,y=nav.mapPoint(0,-200)
N.SetTarget(m,x,y,"Target"); N.Sample()
local accepted=N.walk.WorldTrail()
assert(accepted,"native navigation accepted the baked route")
Polestar.Set("nav.worldTrailSight",false)
Polestar.Set("nav.worldTrail",true)
stub.advance(2.1); N.Sample(); stub.advance(.05)
local before=R.Probe().heightSource
local legs,ci=N.GetRoute(); local oldLeg=legs[ci]
nav.place(0,-80); N.Sample()
N.travel.Replan(); N.Sample(); stub.advance(.05)
legs,ci=N.GetRoute()
local out={before=before,after=R.Probe().heightSource,
 retained=N.walk.WorldTrail()~=nil, newLeg=legs[ci]~=oldLeg,searches=#fake.calls}
N.Sample(); stub.advance(.5); N.Sample(); stub.advance(.05)
out.later=R.Probe().heightSource
assert(#Polestar.Errors()==0,"no swallowed integration errors")
emit(out)
`,
 }).emitted;
 console.log(JSON.stringify(out));
 assert.equal(out.before,'baked-strip');
 assert.equal(out.newLeg,true);
 assert.equal(out.searches,0);
 assert.equal(out.after,'baked-strip','valid retained baked path must not lose its heights merely because Travel replanned');
 assert.equal(out.later,'baked-strip');
});

function scenario(body, coverage = '') {
 return runAddon({
  stubs: ['stub_world_trail.lua', 'stub_nav.lua'],
  before: `fake={calls={}}
Polestar_NavEngine={
 Find=function(map,from,to,callback,opts)
  local j={map=map,from=from,to=to,callback=callback,opts=opts}
  fake.calls[#fake.calls+1]=j; return j
 end,
 Cancel=function(j) j.cancelled=true end,
 Busy=function() return false end, Available=function() return true end,
}`,
  addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml',
   'Maps/RouteSparkle.lua', 'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua'] }],
  login: true,
  script: `
local N,nav,W=Polestar.Nav,stub.nav,stub.worldTrail
local R=Polestar.WorldTrail.Render
local guide={id="t/replan-probe",legs={[1]=${JSON.stringify(encoded)}}}
Polestar.Engine.GetGuide=function() return guide end
nav.engine.views[1]={goals={{map=9000,x=60,y=50}}}
W.facing=-math.pi/2; nav.facing=W.facing
nav.place(0,-20)
local m,x,y=nav.mapPoint(0,-200)
N.SetTarget(m,x,y,"Target"); N.Sample()

${coverage}
local accepted, initial = N.walk.WorldTrail()
assert(accepted and initial, "accepted native baked path")
local function absent() return N.walk.WorldTrail() == nil end
local function replace() N.travel.Replan() end
local function forbidden() error("unexpected decoder or terrain work") end
N.BakedLeg = forbidden
Polestar.WorldTrail.Terrain.Sample = forbidden
${body}
assert(#Polestar.Errors()==0,"no swallowed integration errors")
`,
 }).emitted[0];
}

test('fresh native progress alone rebinds retained path; getter remains fail closed and read only', () => {
 const r = scenario(`
local legs,ci=N.GetRoute(); local old=legs[ci]
nav.place(0,-80); N.Sample()
local _,before=N.walk.WorldTrail()
replace()
local closed=absent()
local steps=0; local step=N.follow.Step
N.follow.Step=function(...) steps=steps+1; return step(...) end
N.Sample()
local s,p=N.walk.WorldTrail()
local calls=steps
N.follow.Step=forbidden
local again,q=N.walk.WorldTrail()
emit({closed=closed,same=s==accepted,origin=s and s.trimOffset,
 source=p and p.sourceAlong,along=p and p.along,native=N.walk.Progress(0,0,-200),
 fresh=p and p.at==GetTime(),readonly=steps==calls and again==s,
 unchanged=p and p.sourceAlong==before.sourceAlong,searches=#fake.calls,steps=calls})`);
 assert.equal(r.closed,true); assert.equal(r.same,true); assert.equal(r.origin,20);
 assert.equal(r.source,80); assert.equal(r.along,r.native); assert.equal(r.fresh,true);
 assert.equal(r.readonly,true); assert.equal(r.unchanged,true); assert.equal(r.searches,0);
 assert.equal(r.steps,1);
});

test('timed native Refresh with crossing coverage replaces the leg without losing baked heights', () => {
 const r = scenario(`
stub.now = stub.now + 31; N.Sample()
local legs,ci=N.GetRoute(); local old=legs[ci]
nav.place(0,-80); N.Sample()
N.travel:Refresh()
legs,ci=N.GetRoute()
local closed=absent()
N.Sample()
Polestar.Set("nav.worldTrailSight",false); Polestar.Set("nav.worldTrail",true)
stub.advance(2.1); N.Sample(); stub.advance(.05)
local s,p=N.walk.WorldTrail()
emit({replaced=legs[ci]~=old,closed=closed,same=s==accepted,
 source=p and p.sourceAlong,height=R.Probe().heightSource,searches=#fake.calls})`, `
-- Synthetic complete coverage on the fixture continent; the route stays in
-- one zone, while the real movedAway timer still applies to that continent.
N.RegisterCrossings({complete=true,zones={
 [9000]={name="Fixture",c=0,top=1000,bottom=-1000,left=1000,right=-1000},
 [9001]={name="Neighbor",c=0,top=3000,bottom=1000,left=1000,right=-1000}},
 open={9000,9001,0}})
`);
 assert.equal(r.replaced,true); assert.equal(r.closed,true); assert.equal(r.same,true);
 assert.equal(r.source,80); assert.equal(r.height,'baked-strip'); assert.equal(r.searches,0);
});

test('replacement cannot revive changed identity, pending, dynamic or completed provenance', () => {
 for (const change of [
  'local m,x,y=nav.mapPoint(0,-200); N.SetTarget(m,x,y,"New object")',
  'N.GetTarget().x=N.GetTarget().x+.01',
  'nav.engine.step=2',
  'guide={id=guide.id,legs=guide.legs}',
  'nav.place(100,-80); N.Sample()',
  'nav.place(100,-80); N.Sample(); fake.calls[#fake.calls].callback({{x=100,y=-80},{x=0,y=-200}})',
  'nav.place(0,-201); N.Sample()',
 ]) {
  const r=scenario(`
${change}
replace()
local closed=absent()
N.Sample()
emit({closed=closed,after=absent()})`);
  assert.equal(r.closed,true,change); assert.equal(r.after,true,change);
 }
});

test('replaced binding remains unavailable while progress is stale', () => {
 const r=scenario(`
replace()
N.Sample()
local fresh=not absent()
-- Advance the clock without frame ticks, which would refresh native Aim.
stub.now = stub.now + 2.1
emit({fresh=fresh,stale=absent()})`);
 assert.equal(r.fresh,true); assert.equal(r.stale,true);
});
