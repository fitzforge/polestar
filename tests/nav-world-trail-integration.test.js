'use strict';
// Real decoder -> accepted Walk path -> follower -> renderer, with client mocks only.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const B = require('../tools/lib/nav/bake');
const { runAddon } = require('./helpers/lua');
const encoded = B.encodeLeg({ pts: [[0, 0, 10], [0, -200, 30]], cls: [0], floor: [0], tail: 0,
 strip: Array.from({ length: 100 }, (_, i) => 10 + i * 0.25) });

test('native accepted baked route paints and a real dynamic replacement drops its old height strip', () => {
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
local guide={id="t/integration",legs={[1]=${JSON.stringify(encoded)}}}
Polestar.Engine.GetGuide=function() return guide end
nav.engine.views[1]={goals={{map=9000,x=60,y=50}}}
W.facing=-math.pi/2; nav.facing=W.facing
nav.place(0,-20)
local m,x,y=nav.mapPoint(0,-200)
N.SetTarget(m,x,y,"Target"); N.Sample()
local accepted=N.walk.WorldTrail()
assert(accepted,"native navigation accepted the baked route")
Polestar.Set("nav.worldTrailSight",false)
local writes=#nav.userWaypoints
Polestar.Set("nav.worldTrail",true)
stub.advance(2.1); N.Sample(); stub.advance(.05)
local out={source=R.Probe().heightSource,along=R.Probe().sourceAlong,used=R.GroundFrame().used,searches=#fake.calls}
assert(#nav.userWaypoints==writes,"enabling/painting does not write navigation pins")
nav.place(40,-40); N.Sample()
local j=fake.calls[#fake.calls]
assert(j,"off-route native search queued")
assert(N.walk.WorldTrail()==nil,"pending search retires the actual baked binding")
j.callback({{x=40,y=-40},{x=0,y=-90},{x=0,y=-200}})
N.Sample(); stub.advance(.05)
out.replaced=R.Probe().heightSource
out.noOldHeight=R.HeightsAhead()==nil and R.Probe().floor==nil
out.fallbackUsed=R.GroundFrame().used
assert(accepted.strip[2]==10.25,"rendering/replacement did not mutate retained strip")
assert(#Polestar.Errors()==0,"no swallowed integration errors")
emit(out)
`,
 }).emitted;
 assert.equal(out.source, 'baked-strip');
 assert.ok(Math.abs(out.along - 20) < 1e-6);
 assert.ok(out.used > 0, 'actual native accepted route paints');
 assert.equal(out.searches, 0, 'baked acceptance requires no dynamic search');
 assert.equal(out.replaced, 'camera-estimate');
 assert.equal(out.noOldHeight, true);
 assert.ok(out.fallbackUsed > 0, 'dynamic replacement retains visible estimate');
});
