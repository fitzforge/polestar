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
 P.Nav={GetRouteGeometry=function() return W.route end}
 P.Compat={GetPlayerWorldPosition=function() return 0,W.px,W.py end,
 IsSecret=function(v) return W.secret~=nil and v==W.secret end,
 MapToWorld=function(map,x,y) if map==947 then return nil end return 0,y*4-200,200-x*4 end}
end
GetPlayerFacing=function() return W.facing end
GetCameraZoom=function() return W.zoom end
IsMouseButtonDown=function(b) return W.left and b=="LeftButton" or W.right and b=="RightButton" end
IsMouselooking=function() return W.looking end
GetUnitSpeed=function() return W.speed or 0 end
IsIndoors=function() return W.indoors end
UnitOnTaxi=function() return W.taxi end
local marker={IsShown=function() return W.marker end, GetEffectiveScale=function() return W.scale or 1 end,
 GetCenter=function()
  if W.center then return unpack(W.center) end
  local T=Polestar.WorldTrail.Trail
  return T.Project(T.Camera(W.yaw,W.pitch,W.zoom,T.Focal(90,UIParent:GetHeight()),UIParent:GetWidth(),UIParent:GetHeight()),200-W.px,-W.py,0)
 end}
C_Navigation={GetFrame=function() return marker end, GetDistance=function() return W.distance or (200-W.px) end,
 WasClampedToScreen=function() return W.clamped end}
C_Map=C_Map or {}
C_Map.GetUserWaypoint=function() return W.pin end
local function forbidden() W.writes=W.writes+1; error("world trail must not write a waypoint") end
C_Map.SetUserWaypoint=forbidden; C_Map.ClearUserWaypoint=forbidden
C_SuperTrack={IsSuperTrackingUserWaypoint=function() return W.pin~=nil end,SetSuperTrackedUserWaypoint=forbidden}
function W.engine(fn)
 Polestar_NavEngine=fn and {HasData=function() return true end, SurfacesAt=fn,
  ReleaseSurfaces=function() error("must not release shared tile") end, Prefetch=function() error("must not prefetch") end} or nil
 PolestarPathData=fn and {[0]={cx0=-29.5,cy0=-13.5,nx=42,ny=23,cells=128}} or nil
 Polestar.WorldTrail.Terrain.Reset(); Polestar.WorldTrail.Render.ResetGround()
end
