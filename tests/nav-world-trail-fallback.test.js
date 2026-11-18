'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('camera-estimate fallback retains its nearby branch at a returning fold', () => {
 const [out] = runAddon({
  stubs: ['stub_world_trail.lua'],
  addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/WorldTrail.lua',
   'Maps/RouteSparkle.lua', 'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua'] }],
  script: `
local W=stub.worldTrail
W.install(); stub.login()
local NS=Polestar.WorldTrail
local T,R=NS.Trail,NS.Render
W.route={legs={{kind="walk",current=true,pts={{0,0,0},{0,200,0},{0,200,5},{0,0,5}}}}}
W.px=20; W.py=0
-- Existing fallback had a nearest-point hint whenever terrain was available.
-- The new fallback must preserve that continuity without any height reads.
W.engine(function(c,x,y,out) out[1],out[-1]=0,0; return 1 end)
local lastAlong
local nearest=T.Nearest
T.Nearest=function(...) local a,d=nearest(...); lastAlong=a; return a,d end
Polestar.Set("nav.worldTrail",true); stub.advance(2.1)
local out={initial=lastAlong}
W.py=4; stub.advance(.05)
out.next=lastAlong
assert(#Polestar.Errors()==0,"no swallowed renderer errors")
assert(W.writes==0,"no waypoint writes")
emit(out)
`,
 }).emitted;
 assert.ok(out.initial < 50, 'initial projection is the outgoing branch');
 assert.ok(out.next < 50, `fallback must not jump to returning branch: ${out.next}`);
});
