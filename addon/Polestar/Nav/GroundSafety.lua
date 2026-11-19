-- Enemy settlements and guarded hubs veto an on-foot segment. Zone levels affect cost, not access.
local _,ns=...
local D=ns.Nav.danger
local floor,ceil,abs,min,max,byte=math.floor,math.ceil,math.abs,math.min,math.max,string.byte
local _,build=GetBuildInfo();build=tonumber(build)
local function finite(x) return type(x)=='number' and x==x and abs(x)<17066.67 end
local function intersects(disks,x,y,dx,dy,dd)
 if not disks then return false end
 for i=1,#disks,3 do
  local u,v=disks[i]-x,disks[i+1]-y;local t=dd>0 and min(1,max(0,(u*dx+v*dy)/dd)) or 0
  u,v=u-t*dx,v-t*dy;if u*u+v*v<=disks[i+2] then return true end
 end
 return false
end
function D.Blocked(map,x,y,X,Y,profile)
 if profile~='Alliance' and profile~='Horde' then return 'unknown-profile' end
 if (build~=70532 and build~=70959) or not (finite(x) and finite(y) and finite(X) and finite(Y)) then return 'unknown-ground' end
 local cells=D.areaCells and D.areaCells[map];local bins=D.hubBins and D.hubBins[map] and D.hubBins[map][profile]
 if not cells or not bins then return 'unknown-ground' end
 local enemy=profile=='Alliance' and 2 or 1;local n=max(1,ceil(max(abs(X-x),abs(Y-y))*.03));local dx,dy=(X-x)/n,(Y-y)/n;local dd=dx*dx+dy*dy
 for i=1,n do
  local a,b=x+dx,y+dy;local lo,hi,le,ri=min(x,a),max(x,a),min(y,b),max(y,b)
  -- Bins already include the player's shoulders. Test the actual line against each disk, not just its ends.
  for r=floor(lo/128),floor(hi/128) do for c=floor(le/128),floor(ri/128) do
   if intersects(bins[r*512+c],x,y,dx,dy,dd) then return 'opposing-settlement' end
  end end
  for r=floor(512-(hi+.55)*.03),floor(512-(lo-.55)*.03) do for c=floor(512-(ri+.55)*.03),floor(512-(le-.55)*.03) do
   local v=cells[floor(r/16)*64+floor(c/16)];if type(v)=='string' then v=byte(v,(r%16)*16+c%16+1) end
   if not v or v==0 then return 'unknown-area' end
   if floor(v/64)==enemy then return 'opposing-settlement' end
  end end
  x,y=a,b
 end
 return nil
end
