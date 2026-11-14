-- FreedoomArcade core: shared namespace, math helpers, random, binary decoding.
-- Doom's 16.16 fixed point is replaced by plain Lua numbers in map units;
-- angles stay in Doom's BAM convention (0 .. 2^32) so game code ports directly.
FreedoomArcade = FreedoomArcade or {}
local D = FreedoomArcade

D.ADDON_PATH = "Interface\\AddOns\\FreedoomArcade\\"
D.MAPS = D.MAPS or {}

local floor = math.floor
local atan2 = math.atan2 or math.atan
local pi = math.pi

D.TICRATE = 35
D.ANG45 = 536870912
D.ANG90 = 1073741824
D.ANG180 = 2147483648
D.ANG270 = 3221225472
D.ANGMAX = 4294967296
D.FINEANGLES = 8192
D.ANGLETOFINE = 524288 -- 2^19
D.MAXINT = 2147483647
D.MININT = -2147483648

local ANGMAX = D.ANGMAX

-- finesine with 10240 entries (finecosine = finesine offset by 2048), like tables.c
local finesine = {}
for i = 0, 10239 do
	finesine[i] = math.sin((i + 0.5) * 2 * pi / 8192)
end
D.finesine = finesine
local finecosine = {}
for i = 0, 8191 do finecosine[i] = finesine[i + 2048] end
D.finecosine = finecosine

function D.AngNorm(a)
	return a % ANGMAX
end

-- fine angle index of a BAM angle (any sign)
function D.Fine(a)
	return floor((a % ANGMAX) / 524288)
end

local BAM_PER_RAD = 2147483648 / pi
D.BAM_PER_RAD = BAM_PER_RAD

function D.PointToAngle2(x1, y1, x2, y2)
	local dx, dy = x2 - x1, y2 - y1
	if dx == 0 and dy == 0 then return 0 end
	return (atan2(dy, dx) * BAM_PER_RAD) % ANGMAX
end

function D.AproxDistance(dx, dy)
	if dx < 0 then dx = -dx end
	if dy < 0 then dy = -dy end
	if dx < dy then
		return dx + dy - dx * 0.5
	end
	return dx + dy - dy * 0.5
end

-- truncate toward zero (C integer division semantics)
function D.Trunc(x)
	if x >= 0 then return floor(x) end
	return -floor(-x)
end

------------------------------------------------------------------------ random
local rndtable = {
	0, 8, 109, 220, 222, 241, 149, 107, 75, 248, 254, 140, 16, 66,
	74, 21, 211, 47, 80, 242, 154, 27, 205, 128, 161, 89, 77, 36,
	95, 110, 85, 48, 212, 140, 211, 249, 22, 79, 200, 50, 28, 188,
	52, 140, 202, 120, 68, 145, 62, 70, 184, 190, 91, 197, 152, 224,
	149, 104, 25, 178, 252, 182, 202, 182, 141, 197, 4, 81, 181, 242,
	145, 42, 39, 227, 156, 198, 225, 193, 219, 93, 122, 175, 249, 0,
	175, 143, 70, 239, 46, 246, 163, 53, 163, 109, 168, 135, 2, 235,
	25, 92, 20, 145, 138, 77, 69, 166, 78, 176, 173, 212, 166, 113,
	94, 161, 41, 50, 239, 49, 111, 164, 70, 60, 2, 37, 171, 75,
	136, 156, 11, 56, 42, 146, 138, 229, 73, 146, 77, 61, 98, 196,
	135, 106, 63, 197, 195, 86, 96, 203, 113, 101, 170, 247, 181, 113,
	80, 250, 108, 7, 255, 237, 129, 226, 79, 107, 112, 166, 103, 241,
	24, 223, 239, 120, 198, 58, 60, 82, 128, 3, 184, 66, 143, 224,
	145, 224, 81, 206, 163, 45, 63, 90, 168, 114, 59, 33, 159, 95,
	28, 139, 123, 98, 125, 196, 15, 70, 194, 253, 54, 14, 109, 226,
	71, 17, 161, 93, 186, 87, 244, 138, 20, 52, 123, 251, 26, 36,
	17, 46, 52, 231, 232, 76, 31, 221, 84, 37, 216, 165, 212, 106,
	197, 242, 98, 43, 39, 175, 254, 145, 190, 84, 118, 222, 187, 136,
	120, 163, 236, 249,
}
local prndindex, rndindex = 0, 0
function D.P_Random()
	prndindex = (prndindex + 1) % 256
	return rndtable[prndindex + 1]
end
function D.M_Random()
	rndindex = (rndindex + 1) % 256
	return rndtable[rndindex + 1]
end
function D.GetRandomState() return prndindex, rndindex end
function D.SetRandomState(p, r) prndindex, rndindex = p, r end
function D.ClearRandom()
	prndindex, rndindex = 0, 0
end

------------------------------------------------------------------------ base64 + binary
local b64 = {}
do
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	for i = 1, 64 do b64[chars:byte(i)] = i - 1 end
end

function D.Base64Decode(s)
	local out = {}
	local n = 0
	local byte, char = string.byte, string.char
	local len = #s
	local chunk = {}
	local ci = 0
	for i = 1, len, 4 do
		local a, b, c, d = byte(s, i, i + 3)
		local va, vb = b64[a], b64[b]
		local vc, vd = b64[c], b64[d]
		local v = va * 262144 + vb * 4096 + (vc or 0) * 64 + (vd or 0)
		local x1 = floor(v / 65536)
		local x2 = floor(v / 256) % 256
		local x3 = v % 256
		ci = ci + 1
		if vd then
			chunk[ci] = char(x1, x2, x3)
		elseif vc then
			chunk[ci] = char(x1, x2)
		else
			chunk[ci] = char(x1)
		end
		if ci >= 4096 then
			n = n + 1
			out[n] = table.concat(chunk, "", 1, ci)
			ci = 0
		end
	end
	n = n + 1
	out[n] = table.concat(chunk, "", 1, ci)
	return table.concat(out)
end

-- little-endian readers; pos is 0-based byte offset
local byte = string.byte
function D.ReadS16(s, pos)
	local a, b = byte(s, pos + 1, pos + 2)
	local v = a + b * 256
	if v >= 32768 then v = v - 65536 end
	return v
end
function D.ReadU16(s, pos)
	local a, b = byte(s, pos + 1, pos + 2)
	return a + b * 256
end
function D.ReadName(s, pos)
	local name = s:sub(pos + 1, pos + 8)
	local z = name:find("\0", 1, true)
	if z then name = name:sub(1, z - 1) end
	return name:upper()
end

------------------------------------------------------------------------ misc
D.debugLog = {}
function D.Print(...)
	local msg = table.concat({ ... }, " ")
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage("|cffff4040Freedoom Arcade:|r " .. msg)
	else
		print("Freedoom Arcade: " .. msg)
	end
end

-- bit operations (WoW and LuaJIT both provide 'bit')
local bit = bit or bit32
D.band = bit.band
D.bor = bit.bor
D.bnot = bit.bnot
D.bxor = bit.bxor

function D.HasFlag(v, f)
	return D.band(v, f) ~= 0
end
