-- Enemy settlements and guarded hubs veto an on-foot segment. Zone levels affect cost, not access.
-- The towns and guard posts are map positions (DangerAreas/DangerHubs: ownership cells kept where builds
-- 70532 and 70959 share the terrain, guard disks from 70532), so they are checked on every client build.
-- A newer client keeps its walks checked rather than refused; the debug log (a report) says the data is older.
local _,ns=...
local D=ns.Nav.danger
local floor,ceil,abs,min,max,byte=math.floor,math.ceil,math.abs,math.min,math.max,string.byte
local REVIEWED=70959 -- the newest build the ground data was paired against (the data files' first line)
local _,build=GetBuildInfo()
if not (tonumber(build) and tonumber(build)<=REVIEWED) then
 ns.Log('ground: client build '..tostring(build)..' is newer than the enemy-town data (70532, 70959); walks are still checked')
end
local pad=.55+1e-7 -- include a shoulder exactly on either edge despite world-to-cell rounding
local function finite(x) return type(x)=='number' and x==x and abs(x)<17066.67 end
local function intersects(disks,radii,x,y,dx,dy,dd,half)
 if not disks then return false end
 -- Two biased 24-bit coordinates in tenths of a yard, then the padded radius-squared index.
 for i=1,#disks,7 do
  local a,b,c,d,e,f,k=byte(disks,i,i+6)
  local u,v=((a*256+b)*256+c-8388608)/10-x,((d*256+e)*256+f-8388608)/10-y
  if half then -- Distance to the square around a stationary centre.
   u,v=max(0,abs(u)-half),max(0,abs(v)-half)
  else
   local t=dd>0 and min(1,max(0,(u*dx+v*dy)/dd)) or 0
   u,v=u-t*dx,v-t*dy
  end
  if u*u+v*v<=radii[k] then return true end
 end
 return false
end
-- For a walk the bounds cover the segment. For a HUD turn they cover a square
-- around (x,y); zero dx,dy makes the ownership-cell bounds sufficient.
local function touches(cells,bins,radii,enemy,x,y,dx,dy,dd,lo,hi,le,ri,half)
 for r=floor(lo/128),floor(hi/128) do for c=floor(le/128),floor(ri/128) do
  if intersects(bins[r*512+c],radii,x,y,dx,dy,dd,half) then return true end
 end end
 for r=floor(512-(hi+pad)*.03),floor(512-(lo-pad)*.03) do for c=floor(512-(ri+pad)*.03),floor(512-(le-pad)*.03) do
  local v=cells[floor(r/16)*64+floor(c/16)];if type(v)=='string' then v=byte(v,(r%16)*16+c%16+1) end
  if v and floor(v/64)==enemy then
   -- A diagonal can miss an occupied corner even though its bounds overlap.
   local cx,cy=(511.5-r)/.03,(511.5-c)/.03
   if abs((cx-x)*dy-(cy-y)*dx)<=(.5/.03+pad)*(abs(dx)+abs(dy)) then return true end
  end
 end end
 return false
end
function D.Blocked(map,x,y,X,Y,profile)
 if profile~='Alliance' and profile~='Horde' then return 'unknown-profile' end
 if not (finite(x) and finite(y) and finite(X) and finite(Y)) then return 'unknown-ground' end
 local cells=D.areaCells and D.areaCells[map];local bins=D.hubBins and D.hubBins[map] and D.hubBins[map][profile]
 local radii=D.hubRadii;if not cells or not bins or not radii then return 'unknown-ground' end
 local enemy=profile=='Alliance' and 2 or 1;local n=max(1,ceil(max(abs(X-x),abs(Y-y))*.03));local dx,dy=(X-x)/n,(Y-y)/n;local dd=dx*dx+dy*dy
 for i=1,n do
  local a,b=x+dx,y+dy;local lo,hi,le,ri=min(x,a),max(x,a),min(y,b),max(y,b)
  if touches(cells,bins,radii,enemy,x,y,dx,dy,dd,lo,hi,le,ri) then return 'opposing-settlement' end
  x,y=a,b
 end
 return nil
end

-- Only called after the walk was admitted. Next to enemy ground show the
-- checked bearing instead of easing through unchecked intermediate headings.
-- Cache one 4-yard square; another 2 yards on each side covers the next strides.
local lastCells,lastBins,lastX,lastY,lastNear
function D.NearEnemyGround(map,x,y,profile)
 local cells,bins=D.areaCells[map],D.hubBins[map][profile]
 local i,j=floor(x/4),floor(y/4)
 if lastCells~=cells or lastBins~=bins or lastX~=i or lastY~=j then
  local cx,cy=i*4+2,j*4+2
  lastNear=touches(cells,bins,D.hubRadii,profile=='Alliance' and 2 or 1,cx,cy,0,0,0,cx-4,cx+4,cy-4,cy+4,4)
  lastCells,lastBins,lastX,lastY=cells,bins,i,j
 end
 return lastNear
end
