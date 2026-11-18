-- Only client/native-route mocks. The production renderer and terrain stay real.
-- wow_stub stores anchors but does not solve layout. Model UIParent fill.
local create = CreateFrame
function CreateFrame(...)
 local f = create(...)
 local all = f.SetAllPoints
 function f:SetAllPoints(other)
  all(self,other)
  local parent = other or self:GetParent()
  if parent then self:SetSize(parent:GetWidth(),parent:GetHeight()) end
 end
 return f
end
local W = { px=10, py=0, facing=0, zoom=15, pitch=0.42, yaw=0, marker=false,
 route={legs={{kind="walk", current=true, pts={{0,0,0},{0,200,0}}}}}, writes=0 }
stub.worldTrail = W
function W.install()
 local P=Polestar
 -- W.pin is a map pin Polestar set itself (Nav/Bridges.lua's, the game's waypoint switched on), unless
 -- W.foreignPin says it is the player's own or another addon's.
 P.Nav={GetRouteGeometry=function() return W.route end,
  bridges={OwnsPin=function() return W.pin~=nil and not W.foreignPin end}}
 P.Compat={GetPlayerWorldPosition=function() return 0,W.px,W.py end,
 IsSecret=function(v) return W.secret~=nil and v==W.secret end,
 MapToWorld=function(map,x,y) if map==947 then return nil end return 0,y*4-200,200-x*4 end}
end
GetPlayerFacing=function() return W.facing end
GetCameraZoom=function() return W.zoom end
IsMouseButtonDown=function(b) return W.left and b=="LeftButton" or W.right and b=="RightButton" end
IsMouselooking=function() return W.looking end
-- W.cursor = {dx, dy}: the cursor's travel each frame; unset, the client reports none.
GetCursorDelta=function() if W.cursor then return W.cursor[1], W.cursor[2] end end
GetUnitSpeed=function() return W.speed or 0 end
-- W.falling: in the air. W.jumpKey: the key bound to jump (unset, the keys cannot be read); W.keys[name]: held.
IsFalling=function() return W.falling and true or false end
local bindingKey=GetBindingKey
GetBindingKey=function(action) if action=="JUMP" then return W.jumpKey end if bindingKey then return bindingKey(action) end end
IsKeyDown=function(key) return W.keys and W.keys[key] or false end
IsIndoors=function() return W.indoors end
UnitOnTaxi=function() return W.taxi end
-- The marker stands at world (200, 0), or at W.markerAt = {x, y} (a pin that
-- has moved, once its marker follows), W.markerZ above the player's feet.
-- W.engineClamp models a game that pins an off-screen marker to the screen's
-- edge itself: "wowf" as wowf 1.60.1 was recorded doing it (below); "axis" or
-- "radial" as a client might that clamps each axis on its own or toward the
-- centre. Without it W.clamped only raises the flag, as the older tests do.
local function projected()
 local T=Polestar.WorldTrail.Trail
 local w,h=UIParent:GetWidth(),UIParent:GetHeight()
 local at=W.markerAt
 -- W.focalScale: a game whose view is that much wider or narrower than the painter takes it to be.
 local x,y=T.Project(T.Camera(W.yaw,W.pitch,W.zoom,T.Focal(90,h)*(W.focalScale or 1),w,h),(at and at[1] or 200)-W.px,(at and at[2] or 0)-W.py,W.markerZ or 0)
 return x,y,w,h
end
local function offScreen()
 local x,y,w,h=projected()
 return not x or x<0 or y<0 or x>w or y>h
end
-- wowf 1.60.1: the marker is pinned W.pinInset (15) inside the screen, and goes
-- round that rectangle evenly with the place's bearing from straight ahead.
-- Tilted down by p: the top edge up to p, the side edge for the next quarter
-- turn, the bottom edge from there to straight behind. Turned up: a place
-- ahead sits along the bottom where it would show, anything else in a bottom
-- corner (crossing within two degrees of straight behind).
-- The recorded place was a mile off, where its bearing from the character and from the camera behind it
-- are one; which of the two the game goes by for a place near by is not recorded. W.pinFromCamera: a
-- client that goes by the camera's, which stands W.zoom behind the character along the view.
local function pinnedAt(w,h)
 local at=W.markerAt
 local back=W.pinFromCamera and (W.zoom or 0)*math.cos(W.pitch) or 0
 local toward=math.atan2((at and at[2] or 0)-(W.py-back*math.sin(W.yaw)),(at and at[1] or 200)-(W.px-back*math.cos(W.yaw)))
 local b=(W.yaw-toward+math.pi)%(2*math.pi)-math.pi -- round to the right of the view
 local a,p=math.deg(math.abs(b)),math.deg(W.pitch)
 -- W.pinByHeight: a client that pins by where the place is in the view, its height included. A place below
 -- the player is then pinned as a level one would be in a view tilted that much less. Whether wowf does is
 -- not recorded (the recorded marker's place was about level); the painter has to cope with both.
 if W.pinByHeight and W.markerZ then
  local flat=math.sqrt(((at and at[1] or 200)-W.px)^2+((at and at[2] or 0)-W.py)^2)
  p=p-math.deg(math.atan2(-W.markerZ,flat))
 end
 local inset=W.pinInset or 15
 local hx,hy=w/2-inset,h/2-inset
 local dx,dy
 if p>=0 then
  if a<p then dx,dy=hx*a/p,hy
  elseif a<=90+p then dx,dy=hx,hy*(1-(a-p)/45)
  else dx,dy=hx*(180-a)/math.max(90-p,.01),-hy end
 elseif a<90 then
  local focal=Polestar.WorldTrail.Trail.Focal(90,h)
  dx,dy=math.min(hx,focal*math.tan(math.rad(a))/math.cos(W.pitch)),-hy
 else
  dx,dy=math.min(hx,hx*(180-a)/2),-hy
 end
 return w/2+(b<0 and -dx or dx),h/2+dy
end
local marker={IsShown=function() return W.marker end, GetEffectiveScale=function() return W.scale or 1 end,
 GetCenter=function()
  if W.center then return unpack(W.center) end
  local x,y,w,h=projected()
  if W.engineClamp=="wowf" then
   if offScreen() then return pinnedAt(w,h) end
   return x,y
  end
  if not (W.engineClamp and x and offScreen()) then return x,y end
  if W.engineClamp=="axis" then return math.max(0,math.min(w,x)),math.max(0,math.min(h,y)) end
  local dx,dy=x-w/2,y-h/2
  local k=math.min(dx~=0 and w/2/math.abs(dx) or math.huge,dy~=0 and h/2/math.abs(dy) or math.huge)
  return w/2+dx*k,h/2+dy*k
 end}
-- W.noFrame: the game tracks nothing, and has no marker frame at all.
C_Navigation={GetFrame=function() if W.noFrame then return nil end return marker end,
 GetDistance=function()
  local at=W.markerAt
  return W.distance or math.sqrt(((at and at[1] or 200)-W.px)^2+((at and at[2] or 0)-W.py)^2)
 end,
 WasClampedToScreen=function() if W.engineClamp then return offScreen() end return W.clamped end,
 HasValidScreenPosition=function() return W.validScreen~=false end}
C_Map=C_Map or {}
C_Map.GetUserWaypoint=function() return W.pin end
local function forbidden() W.writes=W.writes+1; error("world trail must not write a waypoint") end
C_Map.SetUserWaypoint=forbidden; C_Map.ClearUserWaypoint=forbidden
-- W.quest: the id of the quest the game tracks (unset: a client that does not say).
C_SuperTrack={IsSuperTrackingUserWaypoint=function() return W.pin~=nil end,SetSuperTrackedUserWaypoint=forbidden,
 GetSuperTrackedQuestID=function() return W.quest end}
-- W.sight(map, x1, y1, z1, x2, y2): the router's straight-walk check, true or false; unset, it cannot tell (nil).
function W.engine(fn)
 Polestar_NavEngine=fn and {HasData=function() return true end, SurfacesAt=fn,
  Sight=function(...) if W.sight then return W.sight(...) end end,
  ReleaseSurfaces=function() error("must not release shared tile") end, Prefetch=function() error("must not prefetch") end} or nil
 PolestarPathData=fn and {[0]={cx0=-29.5,cy0=-13.5,nx=42,ny=23,cells=128}} or nil
 Polestar.WorldTrail.Terrain.Reset(); Polestar.WorldTrail.Render.ResetGround()
end
