'use strict';
// The tilt read from a marker the game has pinned to the screen's edge, replayed
// from a recording of the game's own marker frame (wowf 1.60.1): the real painter
// is shown the facing, the marker's place and its clamped flag as they were
// recorded, and has to find the tilts the view really had. The recorded marker
// was a tracked quest's; the painter reads only a map pin Polestar set itself,
// so the replay hands it that marker as such a pin, at the place the recording
// gives it: 1,757 yd off, straight ahead of a view turned to 2.199 rad.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const files = ['Core/Init.lua', 'Nav/WorldTrail.lua', 'Maps/RouteSparkle.lua',
 'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua'];
const recording = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures', 'world-trail', 'pinned-marker-wowf-1.60.1.json'), 'utf8'));

test('replaying the recorded marker: the saved tilt, the tilt down to the view\'s limit and the view turned up are all found', () => {
 const rows = recording.samples.map((s) => '{' + s.join(',') + '}').join(',');
 const [out] = runAddon({
  stubs: ['stub_world_trail.lua'],
  before: `stub.cvars.cameraSavedPitch="${recording.savedPitch}"`,
  addons: [{ name: 'Polestar', files }],
  script: `
 local W=stub.worldTrail; W.install(); stub.login()
 local R=Polestar.WorldTrail.Render
 UIParent:SetSize(${recording.width},${recording.height})
 local rows={${rows}}
 -- t, facing, markerX, markerY, clamped, distance, mouselook: the client's state as the painter reads it.
 local function apply(r)
  W.facing=r[2]; W.center={r[3],r[4]}; W.clamped=r[5]==1; W.distance=r[6]; W.looking=r[7]==1; W.right=r[7]==1
 end
 local gx,gy=W.px+rows[1][6]*math.cos(2.199),W.py+rows[1][6]*math.sin(2.199)
 W.marker=true; W.pin={uiMapID=1,position={x=(200-gy)/400,y=(gx+200)/400}}; apply(rows[1])
 Polestar.Set("nav.worldTrail",true); stub.advance(2.6) -- the recording begins with eight seconds of standing still
 local seen,at={},rows[1][1]
 for i=2,#rows do
  local r=rows[i]
  local dt=r[1]-at; at=r[1]
  apply(r); stub.advance(dt)
  local probe=R.Probe()
  seen[#seen+1]={t=r[1],pitch=math.deg(R.CameraState().pitch),tilt=probe.tilt,why=R.Why() or "",used=R.GroundFrame().used,
   mode=probe.mode,rule=probe.pinRule,exact=probe.exact}
 end
 assert(#Polestar.Errors()==0,"no swallowed renderer errors")
 assert(W.writes==0,"no waypoint writes")
 emit(seen)
 `,
 }).emitted;
 const during = (a, b) => out.filter((s) => s.t >= a && s.t <= b);
 const read = (list) => list.filter((s) => s.tilt === 'read from the pinned marker');
 const spread = (list) => [Math.min(...list.map((s) => s.pitch)), Math.max(...list.map((s) => s.pitch))];

 // Standing still after the reload, the pin behind and to the right: nothing measures
 // the tilt, and the client's saved one stands. The rule, held against it, agrees.
 const still = during(2, 8);
 assert.ok(still.length > 5);
 for (const s of still) {
  assert.ok(Math.abs(s.pitch - recording.savedPitch) < 1e-6, `the saved tilt at ${s.t}: ${s.pitch}`);
  assert.equal(s.tilt, 'assumed'); assert.equal(s.exact, true);
  assert.equal(s.mode, 'pin'); assert.equal(s.rule, 'agreed');
  assert.ok(s.used > 0, 'and the trail is drawn');
 }
 // A full turn with the mouse, the marker pinned round the bottom and both sides: the tilt
 // read from it stays the one the view had (a fast turn runs a few degrees out).
 const turning = read([...during(8.7, 10.5), ...during(11.5, 13.0)]);
 assert.ok(turning.length > 40, `read through the turn: ${turning.length}`);
 const [low, high] = spread(turning);
 assert.ok(low > 12 && high < 30, `the tilt through the turn: ${low} to ${high}`);
 const settled = read(during(13.2, 13.4));
 assert.ok(settled.length > 0);
 for (const s of settled) assert.ok(Math.abs(s.pitch - recording.savedPitch) < 1, `settled after the turn at ${s.pitch}`);
 // Tilted well down, and then as far down as the view goes: followed, the marker on the side edge.
 for (const [a, b, want] of [[21.7, 23.6, 64.8], [31.0, 33.4, 83.0]]) {
  const held = read(during(a, b));
  assert.ok(held.length > 2, `read between ${a} and ${b}`);
  for (const s of held) assert.ok(Math.abs(s.pitch - want) < 1.5, `tilted down to ${want}: ${s.pitch} at ${s.t}`);
 }
 // Turned up at the sky: the marker rests in the bottom corners, and nothing is drawn.
 const up = during(34.3, 35.0);
 assert.ok(up.length > 5);
 for (const s of up) {
  assert.equal(s.used, 0, `nothing drawn at ${s.t}`);
  assert.match(s.why, /turned up/);
 }
 // And back down until the marker is in view again: measured from it, as ever.
 const back = during(40.1, 40.3);
 assert.ok(back.length > 0);
 for (const s of back) {
  assert.equal(s.tilt, 'measured');
  assert.ok(Math.abs(s.pitch - 16.4) < 1, `measured from the marker in view: ${s.pitch}`);
 }
});
