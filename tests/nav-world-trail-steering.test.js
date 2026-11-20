'use strict';
// Player-visible invariant: ordinary right-mouse steering must not latch the trail off.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const cases = {
 missing: '',
 near: 'W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.px=150',
 offscreen: 'W.marker=true; W.clamped=true; W.pin={uiMapID=947,position={x=.5,y=.5}}',
};
for (const [name, setup] of Object.entries(cases)) {
 test(`ordinary moving right-mouse steering keeps the trail with a ${name} waypoint`, () => {
  const [out] = runAddon({
   stubs: ['stub_world_trail.lua'],
   addons: [{ name: 'Polestar', files: [
    'Core/Init.lua', 'Nav/WorldTrail.lua', 'Maps/RouteSparkle.lua',
    'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua',
   ] }],
   script: `
local W=stub.worldTrail
W.install(); stub.login()
${setup}
local R=Polestar.WorldTrail.Render
local function run(seconds, walking)
 W.speed=walking and 7 or 0
 for i=1,math.floor(seconds/.05+.5) do
  if walking then W.px=W.px+7*.05 end
  stub.advance(.05)
 end
end
Polestar.Set("nav.worldTrail",true); run(2.1)
local g=R.GroundFrame()
local out={before=g.used, startX=W.px}
W.looking=true; W.right=true; run(1.5,true)
out.steering=g.used
W.looking=false; W.right=false; run(2,true)
out.released=g.used; out.endX=W.px
-- Stop before arrival, so an empty trail cannot be mistaken for arriving.
run(10,false); out.idle=g.used
assert(W.px<200,"fixture stays before destination")
assert(W.writes==0,"steering test never writes a waypoint")
assert(#Polestar.Errors()==0,"no swallowed renderer errors")
emit(out)
`,
  }).emitted;
  assert.ok(out.endX > out.startX + 20, 'fixture actually moves while steering and afterward');
  for (const phase of ['before', 'steering', 'released', 'idle']) {
   assert.ok(out[phase] > 0, `${name}: trail visible ${phase}, got ${out[phase]}`);
  }
 });
}
