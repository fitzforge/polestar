'use strict';
// A route that changes or ends: the trail it drew stays where it lay and fades
// out while the new one fades in. The real painter over the client mocks.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const files = ['Core/Init.lua', 'Nav/WorldTrail.lua', 'Maps/RouteSparkle.lua',
 'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua'];
function runtime(script) {
 const result = runAddon({stubs:['stub_world_trail.lua'], addons:[{name:'Polestar',files}], script:`
 local W=stub.worldTrail; W.install()
 local NS=Polestar.WorldTrail; local T,R=NS.Trail,NS.Render
 local function near(a,b,note,eps) assert(type(a)=='number' and math.abs(a-b)<=(eps or 1e-6),(note or 'mismatch')..': '..tostring(a)..' vs '..tostring(b)) end
 stub.login()
 Polestar.Set('nav.worldTrail',true); Polestar.Set('nav.worldTrailFlow',0); Polestar.Set('nav.worldTrailWidth',0)
 -- A steady sparkle: how strongly it shows is its fade alone.
 T.Sparkle=function(id,t,style,fade) return fade,1,0,0 end
 local function frame(dt) stub.advance(dt or .05) end
 local FADE=.6
 local function eased(u) if u<=0 then return 0 elseif u>=1 then return 1 end return u*u*(3-2*u) end
 local function route(pts) W.route=pts and {legs={{kind='walk',current=true,pts=pts}}} or nil; Polestar.Fire('NAV_ROUTE_GEOMETRY') end
 local AHEAD={{0,0,0},{0,200,0}}  -- the mock's first route: straight on from the player at (10, 0)
 local ASIDE={{0,10,0},{0,150,80}} -- another, off to the left
 local function aside(y) return {{0,10,0},{0,150,y}} end
 local g
 local function sprites(from,to)
  local out={}
  for i=from or 1,to or g.used do local t=g.stars[i]; out[#out+1]={x=t.points[1].x,y=t.points[1].y,a=t:GetAlpha()} end
  return out
 end
 local function total(list) local s=0; for _,v in ipairs(list) do s=s+v.a end; return s end
 frame(2.1); frame(.5); g=R.GroundFrame()
 `+script+`
 assert(#Polestar.Errors()==0,'no swallowed runtime errors'); emit(true)
 `}).emitted;
 assert.equal(result[0],true);
}

test('a route that changes: its trail stays where it lay and fades out while the new one fades in', () => runtime(`
 local old=sprites(); local was=total(old)
 assert(#old>8 and was>1,'a trail ahead: '..#old)
 route(ASIDE); frame()
 assert(#R.Fades()==1 and R.Probe().fadingOut==1,'the trail it replaces is kept, to fade out')
 local nNew=g.used-#old
 assert(nNew>3,'the new trail is drawn with it: '..nNew)
 local now=sprites(nNew+1)
 for i,s in ipairs(old) do near(now[i].x,s.x,'where it lay'); near(now[i].y,s.y,'where it lay'); near(now[i].a,s.a,'as it showed') end
 near(total(sprites(1,nNew)),0,'the new one starts from nothing')
 local seen={}
 for k=1,11 do
  frame()
  seen[k]={old=g.used>nNew and total(sprites(nNew+1)) or 0,new=total(sprites(1,nNew))}
  near(R.Probe().fadeIn,eased(k*.05/FADE),'the fade-in is reported')
 end
 frame(.2)
 assert(#R.Fades()==0 and g.used==nNew and R.Probe().fadeIn==nil,'the old trail is gone and the new one in')
 local full=total(sprites())
 for k,s in ipairs(seen) do
  local u=k*.05/FADE
  -- (a sparkle fainter than a hundredth is not drawn, so the old trail's sum runs a little under)
  near(s.old/was,1-eased(u),'the old trail fades out, paint '..k,.03)
  near(s.new/full,eased(u),'the new one fades in, paint '..k)
  assert(k==1 or s.old<seen[k-1].old and s.new>seen[k-1].new,'steadily')
 end
 near(W.writes,0)
`));

test('the route built again along the same line is no change; the way ahead moving is', () => runtime(`
 local before=sprites()
 local function unchanged(pts,note)
  route(pts); frame()
  assert(#R.Fades()==0 and R.Probe().fadeIn==nil,note..': nothing fades')
  near(total(sprites()),total(before),note..': still fully shown',.5)
 end
 route({{0,0,0},{0,200,0}}); frame()
 assert(#R.Fades()==0 and R.Probe().fadeIn==nil,'the same points again: nothing fades')
 local after=sprites(); assert(#after==#before)
 for i,s in ipairs(before) do near(after[i].x,s.x); near(after[i].y,s.y); near(after[i].a,s.a,'still fully shown') end
 unchanged({{0,0,0},{0,50,0},{0,120,0},{0,200,0}},'the same line through other points')
 unchanged({{0,10,.5},{0,200,0}},'a straight line drawn again from where the player now stands')
 unchanged({{0,0,0},{0,200,2}},'a line a little to one side further on')
 unchanged({{0,0,0},{0,60,0},{0,100,60}},'a line that turns off beyond the trail\\'s reach')
 unchanged({{0,-40,0},{0,400,0}},'the same road, from further back to further on')
 W.px=15; unchanged({{0,0,0},{0,200,0}},'the player five yards on in the same paint (their place on a path lags a rider)')
 W.px=10; frame()
 route({{0,0,0},{0,30,0},{0,60,30}}); frame()
 assert(#R.Fades()==1 and R.Probe().fadeIn~=nil,'a line that turns off twenty yards ahead is another way')
 frame(1)
 -- The way back along the road just walked lies on the old route's line, behind the player: another way.
 route(AHEAD); frame(1); assert(#R.Fades()==0)
 W.px=100; frame(.2)
 W.zoom=30; W.facing=math.pi; frame(.2)
 route({{0,100,0},{0,0,0}}); frame()
 assert(#R.Fades()==1,'turning back along the same road is a change')
 frame(1)
 -- A route that now ends ten yards ahead, on the same line: its far end is gone.
 W.facing=0; route(AHEAD); frame(1); assert(#R.Fades()==0)
 route({{0,0,0},{0,110,0}}); frame()
 assert(#R.Fades()==1,'the same line ending short is a change')
`));

test('a route that ends fades out, and painting stops when it has', () => runtime(`
 local was=total(sprites())
 route(nil)
 assert(g:GetScript('OnUpdate'),'painting goes on')
 frame(); near(total(sprites()),was,'all of it is still there as the route goes')
 assert(R.Probe().fadingOut==1 and R.Why()=='no Polestar route')
 frame(.3); near(total(sprites())/was,.5,'half way out',.03)
 frame(.35)
 assert(g.used==0 and not g:GetScript('OnUpdate'),'out: nothing left to paint')
 route(AHEAD); frame(.4)
 near(total(sprites()),was,'a route after that shows as any new route does')
 -- A route arriving while the last one is still fading out fades in over the same time.
 route(nil); frame(); frame(.1)
 route(ASIDE); frame()
 assert(#R.Fades()==1 and R.Probe().fadeIn~=nil,'the new route fades in as the old one goes')
 frame(.7); assert(#R.Fades()==0 and g.used>0 and g:GetScript('OnUpdate'))
`));

test('a route found in stages: one replaced before it showed is dropped, and the faintest gives way', () => runtime(`
 route(ASIDE); frame()
 route(aside(-80)); frame()
 assert(#R.Fades()==1 and R.Fades()[1].level==1,'only the trail that was showing fades')
 frame(1)
 -- Four lines, each replaced a little way into its fade-in.
 route(aside(120)); frame(); frame(.1)
 route(aside(40)); frame(); frame(.1)
 assert(#R.Fades()==2)
 route(aside(-40)); frame(); frame(.1)
 assert(#R.Fades()==3)
 route(aside(-120)); frame()
 local fades=R.Fades()
 assert(#fades==3,'no more than three fade at once')
 assert(fades[3].level==1,'the trail that had been showing is kept: the faintest gave way')
 assert(fades[1].level<.1 and fades[2].level<.1)
 frame(1); assert(#R.Fades()==0)
 -- The trails fading out use at most one more Max sparkles between them.
 Polestar.Set('nav.worldTrailMax',10); frame(1)
 assert(g.used==10,'the trail at its limit: '..g.used)
 route(aside(90)); frame(); frame(.1)
 route(aside(30)); frame()
 assert(#R.Fades()==2 and g.used>10 and g.used<=20,'both fading trails within the limit: '..g.used)
`));

test('a trail drawn at known heights fades out at those heights; the same walk drawn another way does not fade', () => runtime(`
 -- The walk straight on, with its heights: a tenth of a yard up for every yard.
 local function snapshot()
  local s={c=0,n=3,m=101,stripYd=2,xs={0,100,200},ys={0,0,0},distances={0,100,200},strip={},generation=1}
  for i=1,s.m do s.strip[i]=100+(i-1)*.2 end
  return s
 end
 local accepted,progress=snapshot(),{sourceAlong=10,off=0,generation=1}
 Polestar.Nav.walk={WorldTrail=function() return accepted,progress end,Floor=function() return nil end}
 local live,drawn,ghosts=false,{},{}
 local emitTrail=T.Emit
 T.Emit=function(...) live=true; local n=emitTrail(...); live=false; return n end
 local project=T.Project
 T.Project=function(cam,x,y,z) local list=live and drawn or ghosts; list[#list+1]=z; return project(cam,x,y,z) end
 local function paint() drawn,ghosts={},{}; frame() end
 -- The strip and the route's own points are the same line: taking up one for the other is no change.
 paint()
 assert(R.Probe().heightSource=='baked-strip' and #R.Fades()==0 and #ghosts==0,'the strip taken up: nothing fades')
 for _,z in ipairs(drawn) do assert(z>.25 and z<3.1,'drawn at the strip\\'s heights: '..z) end
 accepted=nil; paint()
 assert(R.Probe().heightSource=='camera-estimate' and #R.Fades()==0 and #ghosts==0,'the strip let go: nothing fades')
 for _,z in ipairs(drawn) do near(z,0,'the estimate at once, with nothing of the strip left') end
 accepted=snapshot(); paint(); frame(.3)
 assert(R.Probe().heightSource=='baked-strip' and #R.Fades()==0)
 -- Another way altogether: the strip's trail fades out at the heights it was drawn with.
 accepted=nil; route(ASIDE); paint()
 assert(#R.Fades()==1 and #ghosts>8,'the replaced trail fades out')
 for _,z in ipairs(ghosts) do assert(z>.25 and z<3.1,'at its own heights: '..z) end
 for _,z in ipairs(drawn) do near(z,0,'while the new one is drawn by the estimate') end
 frame(.7); assert(#R.Fades()==0)
`));

test('where the trail is hidden outright it goes at once, and nothing of it comes back', () => runtime(`
 for _,hide in ipairs({'indoors','flight','off','loading','guide'}) do
  route(AHEAD); frame(1)
  route(ASIDE); frame(); frame(.1)
  assert(#R.Fades()==1 and g.used>0,hide..': a trail is fading')
  if hide=='indoors' then W.indoors=true
  elseif hide=='flight' then W.taxi=true
  elseif hide=='off' then Polestar.Set('nav.worldTrail',false)
  elseif hide=='loading' then stub.fire('LOADING_SCREEN_ENABLED')
  else Polestar.Set('ui.shown',false) end
  frame()
  assert(g.used==0 and #R.Fades()==0,hide..': gone at once, nothing kept')
  W.indoors,W.taxi=nil,nil
  if hide=='off' then Polestar.Set('nav.worldTrail',true)
  elseif hide=='loading' then stub.fire('LOADING_SCREEN_DISABLED')
  elseif hide=='guide' then Polestar.Set('ui.shown',true) end
  frame(2.5)
  assert(g.used>0 and #R.Fades()==0 and R.Probe().fadeIn==nil,hide..': back, with no trail fading')
 end
`));

test('a trail that was not on screen when its route changed is not faded out', () => runtime(`
 -- The camera swung away with the left button: nothing is drawn.
 W.left=true; frame(.05); frame(.3)
 assert(g.used==0,'hidden')
 route(ASIDE); frame()
 assert(#R.Fades()==0,'nothing to fade')
 W.left=false; W.looking=true; frame(); W.looking=false; frame(.3)
 assert(g.used>0 and #R.Fades()==0,'the new route shows, with nothing of the old')
 -- A trail wholly out of view when its route changes: nothing was drawn of it.
 route(AHEAD); frame(1)
 W.facing,W.zoom=math.pi,2; frame(.1)
 assert(g.used==0,'looking away from the route, the camera close in: all of it is behind the view')
 route(ASIDE); frame()
 assert(#R.Fades()==0)
`));

test('the fading trail stays put in the world as you move, and on the ground through a jump', () => runtime(`
 local live,ghosts=false,{}
 local emitTrail=T.Emit
 T.Emit=function(...) live=true; local n=emitTrail(...); live=false; return n end
 local project=T.Project
 T.Project=function(cam,x,y,z) if not live then ghosts[#ghosts+1]={x=x,y=y,z=z} end; return project(cam,x,y,z) end
 local function paint() ghosts={}; frame(); return ghosts end
 route(ASIDE)
 local first=paint()
 assert(#first>8,'the replaced trail is drawn')
 for _,q in ipairs(first) do near(q.y,0,'along the old line'); near(q.z,0,'on the ground') end
 -- Two yards on and one to the side: each sparkle is two yards nearer and one to the other side.
 W.px,W.py=W.px+2,W.py+1
 local moved=paint()
 assert(#moved==#first)
 for i,q in ipairs(moved) do near(q.x,first[i].x-2,'where it lay in the world'); near(q.y,-1) end
 -- In the air (the keys cannot be read here: leaving the ground is a jump) the ground falls away under the feet.
 W.falling=true
 local up=7.9555*.025-19.2911*.025^2/2
 for _,q in ipairs(paint()) do near(q.z,-up,'a jump does not lift it') end
`));

test('a route that ends with a waypoint marker about fades out all the same', () => runtime(`
 local PIN={uiMapID=1,position={x=.5,y=1}}       -- a pin the game can place: world (200, 0)
 local NOWHERE={uiMapID=947,position={x=.5,y=1}} -- one it cannot
 for _,case in ipairs({{PIN},{NOWHERE},{PIN,'clamped'},{NOWHERE,'clamped'},{nil}}) do
  route(AHEAD); W.marker=true; W.pin=case[1]; W.clamped=nil; frame(1)
  local was=total(sprites()); assert(was>1)
  W.clamped=case[2] and true or nil
  route(nil); frame()
  near(total(sprites()),was,'still there as the route goes',was*.02)
  assert(R.Probe().fadingOut==1)
  frame(.3); assert(g.used>0,'half way out, the camera worked out with no route')
  frame(.4); assert(g.used==0 and not g:GetScript('OnUpdate'),'out')
 end
 near(W.writes,0)
`));

test('a pin that has just moved is not solved against a marker still at its old place', () => runtime(`
 local PIN={uiMapID=1,position={x=.5,y=1}}     -- a pin the game can place: world (200, 0), where the mock's marker stands
 local MOVED={uiMapID=1,position={x=.25,y=.9}} -- another: world (160, 100), off to the left
 W.marker=true; W.pin=PIN; W.yaw=.1; W.facing=.1; frame(.3)
 near(R.CameraState().yaw,.1,'measured from the marker',1e-3); assert(R.CameraState().source=='marker')
 local before=sprites()
 -- The route and its pin move; this paint the game's marker still shows the old place.
 W.pin=MOVED; route({{0,10,0},{0,160,100}}); frame()
 near(R.CameraState().yaw,.1,'the view is not swung round',1e-3)
 assert(R.CameraState().source:find('as it was'),'the camera as it was: '..R.CameraState().source)
 assert(#R.Fades()==1,'the old trail fades from where it lay')
 local now=sprites(g.used-#before+1)
 for i,s in ipairs(before) do near(now[i].x,s.x,'not thrown across the screen',1e-3); near(now[i].y,s.y,'nor up or down it',1e-3) end
 -- The marker follows: it measures the camera again, and agrees.
 W.markerAt={160,100}; frame()
 assert(R.CameraState().source=='marker'); near(R.CameraState().yaw,.1,'measured again',1e-3)
 -- A marker that never follows is believed again after a moment, as it always was.
 W.pin=PIN; frame(); assert(R.CameraState().source:find('as it was'))
 frame(.4); assert(R.CameraState().source=='marker','the wait is a short one')
 near(W.writes,0)
`));

// With the real router and walker (no painter-side mocks of the route): a
// re-plan of the same walk and a new target, as the game brings them.
const B = require('../tools/lib/nav/bake');
const encoded = B.encodeLeg({ pts: [[0, 0, 10], [0, -200, 30]], cls: [0], floor: [0], tail: 0,
 strip: Array.from({ length: 100 }, (_, i) => 10 + i * 0.25) });
test('with the real router: re-planning the same walk fades nothing; a new target fades the old trail out and the new one in', () => {
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
local guide={id="t/route-change",legs={[1]=${JSON.stringify(encoded)}}}
Polestar.Engine.GetGuide=function() return guide end
nav.engine.views[1]={goals={{map=9000,x=60,y=50}}}
W.facing=-math.pi/2; nav.facing=W.facing
nav.place(0,-20)
local m,x,y=nav.mapPoint(0,-200)
N.SetTarget(m,x,y,"Target"); N.Sample()
assert(N.walk.WorldTrail(),"native navigation accepted the baked route")
Polestar.Set("nav.worldTrailSight",false); Polestar.Set("nav.worldTrail",true)
stub.advance(2.1); N.Sample(); stub.advance(.5)
local g=R.GroundFrame()
local out={before=R.Probe().heightSource,shown=g.used}
-- The walk planned again, twice, on the way: the trail is painted while the plan is replaced and after.
local most,closed,windows=0,0,0
for _,at in ipairs({-60,-80}) do
 nav.place(0,at); N.Sample(); stub.advance(.05)
 N.travel.Replan()
 if N.walk.WorldTrail()==nil then closed=closed+1 end
 for i=1,6 do
  -- The first paint comes before the arrow next takes its aim: the strip is not vouched for yet.
  local aim=N.walk.Aim
  if i==1 then N.walk.Aim=function() end end
  stub.advance(.05); most=math.max(most,#R.Fades())
  N.walk.Aim=aim
  if i==1 and R.Probe().heightSource=="camera-estimate" then windows=windows+1 end
  if i==2 then N.Sample() end
 end
end
out.replanClosed,out.replanFades,out.afterReplan,out.fadeInOnReplan=closed,most,R.Probe().heightSource,R.Probe().fadeIn
out.replanWindows=windows
-- Another target, off to the side: no baked leg ends there, so the walk is searched.
local searches=#fake.calls
local m2,x2,y2=nav.mapPoint(150,-80)
N.SetTarget(m2,x2,y2,"Elsewhere"); stub.advance(.05)
out.targetFades=#R.Fades()
N.Sample(); stub.advance(.2)
out.searched=#fake.calls>searches
fake.calls[#fake.calls].callback({{x=0,y=-80},{x=60,y=-60},{x=150,y=-80}})
stub.advance(.05); N.Sample(); stub.advance(.05)
out.pathFades,out.fadingIn=#R.Fades(),R.Probe().fadeIn~=nil
N.Sample(); stub.advance(1.2)
out.endFades,out.endShown,out.endFadeIn=#R.Fades(),g.used,R.Probe().fadeIn
assert(#Polestar.Errors()==0,"no swallowed integration errors")
emit(out)
`,
 }).emitted;
 console.log(JSON.stringify(out));
 assert.equal(out.before, 'baked-strip');
 assert.ok(out.shown > 0);
 assert.equal(out.replanClosed, 2, 'each re-plan closes the strip for a moment');
 assert.equal(out.replanWindows, 2, 'and the trail is painted from the route\'s own points meanwhile');
 assert.equal(out.replanFades, 0, 'a re-plan of the same walk must not fade the trail');
 assert.equal(out.fadeInOnReplan, undefined);
 assert.equal(out.afterReplan, 'baked-strip');
 assert.ok(out.targetFades >= 1, 'the old target\'s trail fades out when the target changes');
 assert.equal(out.searched, true);
 assert.ok(out.pathFades >= 1 && out.fadingIn, 'the searched path fades in while what it replaced fades out');
 assert.equal(out.endFades, 0);
 assert.ok(out.endShown > 0);
 assert.equal(out.endFadeIn, undefined);
});
