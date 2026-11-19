-- Forever placed-creature evidence, in world yards (x north, y west). A nil
-- answer means no known veto, never that the server currently has no enemies.
-- The version 1 index includes each capsule in every tile touched by its padded
-- bounds. These are horizontal envelopes: an unobserved floor is not clearance.
local _, ns = ...
local D = ns.Nav.danger
local floor, min, max, byte = math.floor, math.min, math.max, string.byte
local reasons = {"hostile creature", "enemy faction creature", "unresolved creature standing",
	"unknown creature reaction", "unknown creature level"}

local function pointNear(px, py, ax, ay, dx, dy, len2, r2)
	local ox, oy = px - ax, py - ay
	local t = ox * dx + oy * dy
	if t > 0 and len2 > 0 then
		t = min(t / len2, 1)
		ox, oy = ox - t * dx, oy - t * dy
	end
	return ox * ox + oy * oy <= r2
end

-- Two closed segments within radius: either they cross in their interiors
-- or an endpoint of one is within radius of the other (also handles points).
local function near(ax, ay, bx, by, dx, dy, len2, px, py, sx, sy, r)
	local qx, qy = px + sx, py + sy
	if max(ax,bx) < min(px,qx)-r or min(ax,bx) > max(px,qx)+r or
		max(ay,by) < min(py,qy)-r or min(ay,by) > max(py,qy)+r then return false end
	local r2 = r * r
	if pointNear(px, py, ax, ay, dx, dy, len2, r2) then return true end
	if sx == 0 and sy == 0 then return false end
	local ux, uy = px - ax, py - ay
	local det = dx * sy - dy * sx
	if det ~= 0 then
		local t, u = (ux * sy - uy * sx) / det, (ux * dy - uy * dx) / det
		if t >= 0 and t <= 1 and u >= 0 and u <= 1 then return true end
	end
	local plen2 = sx * sx + sy * sy
	return pointNear(qx, qy, ax, ay, dx, dy, len2, r2) or
		pointNear(ax, ay, px, py, sx, sy, plen2, r2) or pointNear(bx, by, px, py, sx, sy, plen2, r2)
end

local function valid(v)
	return type(v) == "number" and v >= -32768 and v < 32768
end

function D.CreatureBlocked(map, x, y, X, Y, profile, level)
	local data = D.creatureThreatData
	if not data or data.version ~= 1 then return "unknown creature data" end
	local tiles = data.maps[map]
	if not tiles then return "unknown creature map" end
	local side
	if profile == "Alliance" then side = 1 elseif profile == "Horde" then side = 2 else return "unknown faction" end
	if type(level) ~= "number" or not (level >= 1 and level <= 60 and level == floor(level)) then return "unknown level" end
	if not (valid(x) and valid(y) and valid(X) and valid(Y)) then return "unknown creature coordinates" end
	-- Identical traversal/answer for A->B and B->A, including exact tile boundaries.
	if x > X or (x == X and y > Y) then x, y, X, Y = X, Y, x, y end
	local dx, dy = X - x, Y - y
	local len2, first, last = dx*dx + dy*dy, floor(x/128), floor(X/128)
	local y0 = y
	for ix = first, last do
		local y1 = Y
		if ix < last then y1 = y + dy * (((ix+1)*128 - x) / dx) end
		local base = ix * 512
		for iy = floor(min(y0,y1)/128), floor(max(y0,y1)/128) do
			local refs = tiles[base + iy]
			if refs and byte(refs, side) >= level then
				for i = 3, #refs, 3 do
					local a,b,c = byte(refs,i,i+2)
					local idx = a + b*256 + c*65536
					local s = data.blocks[floor(idx/256)+1]
					local k = (idx%256)*10+1
					if byte(s,k+side-1) >= level then
						local kind,lx,hx,ly,hy,sx,sy,r = byte(s,k+2,k+9)
						if near(x,y,X,Y,dx,dy,len2,lx+hx*256-32768,ly+hy*256-32768,sx-64,sy-64,r+0.46) then
							return reasons[side == 1 and kind%8 or floor(kind/8)]
						end
					end
				end
			end
		end
		y0 = y1
	end
end
