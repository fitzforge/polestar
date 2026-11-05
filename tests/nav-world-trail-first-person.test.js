'use strict';
// Without a marker, first-person pitch cannot be inferred from character yaw.
// This is a view-local omission, never a persistent mouse-button latch.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('unmeasured first-person view omits the estimate and zooming out immediately restores it', () => {
 const [out] = runAddon({
  stubs: ['stub_world_trail.lua'],
  addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/WorldTrail.lua',
   'Maps/RouteSparkle.lua', 'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua'] }],
  script: `
local W=stub.worldTrail
W.install(); stub.login()
local R=Polestar.WorldTrail.Render
Polestar.Set("nav.worldTrail",true); stub.advance(2.1)
local g=R.GroundFrame()
local out={thirdPerson=g.used}
W.zoom=0; stub.advance(.1)
out.firstPerson=g.used; out.reason=R.Why()
W.right=true; W.looking=true; W.speed=7
for i=1,30 do W.px=W.px+.35; stub.advance(.05) end
out.steeringFirstPerson=g.used
W.right=false; W.looking=false; W.speed=0; stub.advance(.1)
out.releasedFirstPerson=g.used
-- No distant marker or forced recenter is needed to recover third person.
W.zoom=15; stub.advance(.1)
out.zoomedOut=g.used
assert(#Polestar.Errors()==0,"no swallowed renderer errors")
assert(W.writes==0,"no waypoint writes")
emit(out)
`,
 }).emitted;
 assert.ok(out.thirdPerson > 0);
 assert.equal(out.firstPerson, 0, 'no guessed pitch projection in an unmeasured first-person view');
 assert.match(out.reason, /first.person/i);
 assert.equal(out.steeringFirstPerson, 0);
 assert.equal(out.releasedFirstPerson, 0);
 assert.ok(out.zoomedOut > 0, 'no persistent suppression after leaving first person');
});

test('third-person unmeasured skyward motion remains an explicit best-effort limitation', () => {
 const [out] = runAddon({
  stubs: ['stub_world_trail.lua'],
  addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/WorldTrail.lua',
   'Maps/RouteSparkle.lua', 'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua'] }],
  script: `
local W=stub.worldTrail
W.install(); stub.login()
local R=Polestar.WorldTrail.Render
W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.pitch=.3
Polestar.Set("nav.worldTrail",true); stub.advance(2.1)
W.right=true; W.looking=true; W.clamped=true; W.pitch=-1.1
stub.advance(.4)
local out={used=R.GroundFrame().used,error=math.abs(R.CameraState().pitch-W.pitch)}
assert(#Polestar.Errors()==0,"no swallowed renderer errors")
emit(out)
`,
 }).emitted;
 assert.ok(out.used > 0, 'unobservable input is not turned into persistent third-person suppression');
 assert.ok(out.error > 1, 'this test records an unresolved pitch error, NOT correct skyward projection');
});
