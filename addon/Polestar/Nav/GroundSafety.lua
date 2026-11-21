-- Enemy settlements and guarded hubs veto an on-foot segment. Zone levels affect cost, not access.
-- The towns and guard posts are map positions (DangerAreas/DangerHubs: ownership cells kept where builds
-- 70532 and 70959 share the terrain, guard disks from 70532), so they are checked on every client build.
-- A newer client keeps its walks checked rather than refused; the debug log (a report) says the data is older.
local _,ns=...
local D=ns.Nav.danger
local floor,ceil,abs,min,max,byte,huge=math.floor,math.ceil,math.abs,math.min,math.max,string.byte,math.huge
local REVIEWED=70959 -- the newest build the ground data was paired against (the data files' first line)
local _,build=GetBuildInfo()
if not (tonumber(build) and tonumber(build)<=REVIEWED) then
 ns.Log('ground: client build '..tostring(build)..' is newer than the enemy-town data (70532, 70959); walks are still checked')
end
local pad=.55+1e-7 -- include a shoulder exactly on either edge despite world-to-cell rounding
local function finite(x) return type(x)=='number' and x==x and abs(x)<17066.67 end
-- exd: the exempt guard disks (D.Exempt), by their packed centre.
local function intersects(disks,radii,x,y,dx,dy,dd,half,exd)
 if not disks then return false end
 -- Two biased 24-bit coordinates in tenths of a yard, then the padded radius-squared index.
 for i=1,#disks,7 do
  local a,b,c,d,e,f,k=byte(disks,i,i+6)
  local X,Y=(a*256+b)*256+c,(d*256+e)*256+f
  local u,v=(X-8388608)/10-x,(Y-8388608)/10-y
  if half then -- Distance to the square around a stationary centre.
   u,v=max(0,abs(u)-half),max(0,abs(v)-half)
  else
   local t=dd>0 and min(1,max(0,(u*dx+v*dy)/dd)) or 0
   u,v=u-t*dx,v-t*dy
  end
  if u*u+v*v<=radii[k] and not (exd and exd[X*16777216+Y]) then return true end
 end
 return false
end
-- For a walk the bounds cover the segment. For a HUD turn they cover a square
-- around (x,y); zero dx,dy makes the ownership-cell bounds sufficient.
-- exc: the exempt ownership cells (D.Exempt), by row*1024+column.
local function touches(cells,bins,radii,enemy,x,y,dx,dy,dd,lo,hi,le,ri,half,exc,exd)
 for r=floor(lo/128),floor(hi/128) do for c=floor(le/128),floor(ri/128) do
  if intersects(bins[r*512+c],radii,x,y,dx,dy,dd,half,exd) then return true end
 end end
 for r=floor(512-(hi+pad)*.03),floor(512-(lo-pad)*.03) do for c=floor(512-(ri+pad)*.03),floor(512-(le-pad)*.03) do
  local v=cells[floor(r/16)*64+floor(c/16)];if type(v)=='string' then v=byte(v,(r%16)*16+c%16+1) end
  if v and floor(v/64)==enemy and not (exc and exc[r*1024+c]) then
   -- A diagonal can miss an occupied corner even though its bounds overlap.
   local cx,cy=(511.5-r)/.03,(511.5-c)/.03
   if abs((cx-x)*dy-(cy-y)*dx)<=(.5/.03+pad)*(abs(dx)+abs(dy)) then return true end
  end
 end end
 return false
end
-- The check for one exemption (D.Exempt): a new function whenever the exempt ground changes, so the router's
-- and the estimates' remembered answers (keyed by the check itself) are asked again.
local function policy(ex)
 return function(map,x,y,X,Y,profile)
  if profile~='Alliance' and profile~='Horde' then return 'unknown-profile' end
  if not (finite(x) and finite(y) and finite(X) and finite(Y)) then return 'unknown-ground' end
  local cells=D.areaCells and D.areaCells[map];local bins=D.hubBins and D.hubBins[map] and D.hubBins[map][profile]
  local radii=D.hubRadii;if not cells or not bins or not radii then return 'unknown-ground' end
  local e=ex and ex.profile==profile and ex[map];local exc,exd=e and e.cells,e and e.disks
  local enemy=profile=='Alliance' and 2 or 1;local n=max(1,ceil(max(abs(X-x),abs(Y-y))*.03));local dx,dy=(X-x)/n,(Y-y)/n;local dd=dx*dx+dy*dy
  for i=1,n do
   local a,b=x+dx,y+dy;local lo,hi,le,ri=min(x,a),max(x,a),min(y,b),max(y,b)
   if touches(cells,bins,radii,enemy,x,y,dx,dy,dd,lo,hi,le,ri,nil,exc,exd) then return 'opposing-settlement' end
   x,y=a,b
  end
  return nil
 end
end
D.Blocked=policy(nil)

-- #3447: the guide's goal on enemy ground (Hillsbrad Fields for the Horde) is walked to, and the enemy ground the
-- player stands on is walked out of while a recent goal lay in it (the route sent them there): each one's own piece of
-- enemy ground (its ownership cells and guard disks, as far as they touch one another) is left out of the check.
-- Every other town still refuses a walk, one passed on the way in or out too, and so does a town the player walked
-- into on their own. Travel.Replan sets it before each plan.
local CAP=20000 -- pieces of one piece of ground at most (a capital is ~2,000 cells)
local H=.5/.03 -- half an ownership cell, yards
-- A goal this near enemy ground lies in it: its arrival circle (Nav.DEFAULT_RADIUS) reaches in, and the walk's last
-- yards may too (the Horde's Aerie Peak goal in the Hinterlands, 2 yd from the Wildhammer's ground).
local REACH=5
local function piece(map,x,y,profile,into,reach)
 reach=reach or 0
 local cells=D.areaCells and D.areaCells[map];local bins=D.hubBins and D.hubBins[map] and D.hubBins[map][profile]
 local radii=D.hubRadii;if not (cells and bins and radii and finite(x) and finite(y)) then return end
 local enemy=profile=='Alliance' and 2 or 1
 local exc,exd=into.cells,into.disks
 -- low, lowX/lowY: the piece's least cell and disk, the same from wherever in it the search starts.
 local queue,n,low,lowX,lowY={},0,nil,nil,nil
 local function cell(r,c)
  if r<0 or r>1023 or c<0 or c>1023 or exc[r*1024+c] then return end
  local v=cells[floor(r/16)*64+floor(c/16)];if type(v)=='string' then v=byte(v,(r%16)*16+c%16+1) end
  if v and floor(v/64)==enemy and n<CAP then
   exc[r*1024+c]=true;n=n+1;queue[n]={r,c};low=min(low or huge,r*1024+c)
  end
 end
 -- Disks reaching the box x0..x1, y0..y1 (a point when x0==x1, y0==y1), within extra yards of it.
 local function disks(x0,x1,y0,y1,extra)
  for r=floor((x0-extra)/128),floor((x1+extra)/128) do for c=floor((y0-extra)/128),floor((y1+extra)/128) do
   local s=bins[r*512+c]
   if s then for i=1,#s,7 do
    local a,b,cc,d,e,f,k=byte(s,i,i+6)
    local X,Y=(a*256+b)*256+cc,(d*256+e)*256+f
    local key=X*16777216+Y
    if not exd[key] and n<CAP then
     local u,v=(X-8388608)/10,(Y-8388608)/10
     local du,dv=max(0,x0-u,u-x1),max(0,y0-v,v-y1)
     local reach=extra>0 and extra+radii[k]^.5 or nil
     if (reach and du*du+dv*dv<=reach*reach) or (not reach and du*du+dv*dv<=radii[k]) then
      exd[key]=true;n=n+1;queue[n]={u,v,radii[k]^.5}
      if not lowX or key<lowX*16777216+lowY then lowX,lowY=X,Y end
     end
    end
   end end
  end end
 end
 -- The cells and disks at the point itself, with the check's own shoulder, and within reach yards more.
 for r=floor(512-(x+pad+reach)*.03),floor(512-(x-pad-reach)*.03) do for c=floor(512-(y+pad+reach)*.03),floor(512-(y-pad-reach)*.03) do cell(r,c) end end
 disks(x,x,y,y,reach)
 local i=0
 while i<n do
  i=i+1
  local q=queue[i]
  if q[3] then -- a disk: the cells and disks it overlaps
   local u,v,R=q[1],q[2],q[3]
   for r=floor(512-(u+R+H)*.03),floor(512-(u-R-H)*.03) do for c=floor(512-(v+R+H)*.03),floor(512-(v-R-H)*.03) do
    local cx,cy=(511.5-r)/.03,(511.5-c)/.03
    local du,dv=max(0,abs(u-cx)-H),max(0,abs(v-cy)-H)
    if du*du+dv*dv<=R*R then cell(r,c) end
   end end
   disks(u,u,v,v,R)
  else -- a cell: its eight neighbours and the disks over it
   local r,c=q[1],q[2]
   for dr=-1,1 do for dc=-1,1 do cell(r+dr,c+dc) end end
   local cx,cy=(511.5-r)/.03,(511.5-c)/.03
   disks(cx-H,cx+H,cy-H,cy+H,0)
  end
 end
 if n==0 then return nil end
 return tostring(low)..'/'..tostring(lowX)..','..tostring(lowY)
end
local exemptSig=''
local sent,SENT={},4 -- the pieces the last goals lay in ('<profile><map>:<key>'), newest last, at most SENT
-- D.Exempt(goalMap, gx, gy, playerMap, px, py, profile): the guide goal's and the player's own enemy ground (either
-- point may be nil; the player's counts while it is a piece a recent goal lay in). D.Blocked is replaced only when
-- that ground changes.
function D.Exempt(gc,gx,gy,pc,px,py,profile)
 local ex,sig,seen={profile=profile},'',{}
 local function add(map,into,id)
  if seen[id] then return end
  seen[id]=true;sig=sig..id..';'
  local e=ex[map]
  if not e then ex[map]=into;return end
  for k in pairs(into.cells) do e.cells[k]=true end
  for k in pairs(into.disks) do e.disks[k]=true end
 end
 if profile=='Alliance' or profile=='Horde' then
  if gc~=nil then
   local into={cells={},disks={}}
   local key=piece(gc,gx,gy,profile,into,REACH)
   if key then
    local id=profile..gc..':'..key
    add(gc,into,id)
    for i=#sent,1,-1 do if sent[i]==id then table.remove(sent,i) end end
    sent[#sent+1]=id
    if #sent>SENT then table.remove(sent,1) end
   end
  end
  if pc~=nil then
   local into={cells={},disks={}}
   local key=piece(pc,px,py,profile,into)
   local id=key and profile..pc..':'..key
   for i=1,id and #sent or 0 do if sent[i]==id then add(pc,into,id) break end end
  end
 end
 if sig==exemptSig then return end
 exemptSig=sig
 D.Blocked=policy(sig~='' and ex or nil)
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
