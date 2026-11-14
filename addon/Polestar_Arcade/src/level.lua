-- Level loading (p_setup.c): decodes the map lumps shipped in FreedoomArcade_E? addons.
local D = FreedoomArcade
local ReadS16, ReadU16, ReadName = D.ReadS16, D.ReadU16, D.ReadName
local floor = math.floor

D.BOXTOP, D.BOXBOTTOM, D.BOXLEFT, D.BOXRIGHT = 1, 2, 3, 4
local BOXTOP, BOXBOTTOM, BOXLEFT, BOXRIGHT = 1, 2, 3, 4

-- linedef flags
D.ML_BLOCKING = 1
D.ML_BLOCKMONSTERS = 2
D.ML_TWOSIDED = 4
D.ML_DONTPEGTOP = 8
D.ML_DONTPEGBOTTOM = 16
D.ML_SECRET = 32
D.ML_SOUNDBLOCK = 64
D.ML_DONTDRAW = 128
D.ML_MAPPED = 256

D.ST_HORIZONTAL, D.ST_VERTICAL, D.ST_POSITIVE, D.ST_NEGATIVE = 0, 1, 2, 3

D.MAPBLOCKUNITS = 128
D.MAXRADIUS = 32

local L = {} -- current level
D.level = L

local function decodeLump(m, name)
	return D.Base64Decode(m[name])
end

function D.EpisodeAddon(mapname)
	local e = mapname:match("^E(%d)M%d$")
	if e then return "FreedoomArcade_E" .. e end
end

function D.EnsureMapLoaded(mapname)
	if D.MAPS[mapname] then return true end
	local addon = D.EpisodeAddon(mapname)
	if not addon then return false end
	local loader = (C_AddOns and C_AddOns.LoadAddOn) or LoadAddOn
	local ok, reason = loader(addon)
	if not D.MAPS[mapname] then
		D.Print("could not load " .. addon .. ": " .. tostring(reason))
		return false
	end
	return true
end

local function M_ClearBox(box)
	box[BOXTOP] = -1e30
	box[BOXRIGHT] = -1e30
	box[BOXBOTTOM] = 1e30
	box[BOXLEFT] = 1e30
end
local function M_AddToBox(box, x, y)
	if x < box[BOXLEFT] then box[BOXLEFT] = x end
	if x > box[BOXRIGHT] then box[BOXRIGHT] = x end
	if y < box[BOXBOTTOM] then box[BOXBOTTOM] = y end
	if y > box[BOXTOP] then box[BOXTOP] = y end
end
D.M_ClearBox, D.M_AddToBox = M_ClearBox, M_AddToBox

function D.LoadLevelGeometry(mapname)
	local m = D.MAPS[mapname]
	for k in pairs(L) do L[k] = nil end
	L.name = mapname

	-- vertexes
	local s = decodeLump(m, "VERTEXES")
	local vertexes = {}
	for i = 0, #s / 4 - 1 do
		vertexes[i] = { x = ReadS16(s, i * 4), y = ReadS16(s, i * 4 + 2) }
	end
	L.vertexes = vertexes

	-- sectors
	s = decodeLump(m, "SECTORS")
	local sectors = {}
	local numsectors = #s / 26
	for i = 0, numsectors - 1 do
		local p = i * 26
		sectors[i] = {
			id = i,
			floorheight = ReadS16(s, p),
			ceilingheight = ReadS16(s, p + 2),
			floorpic = ReadName(s, p + 4),
			ceilingpic = ReadName(s, p + 12),
			lightlevel = ReadS16(s, p + 20),
			special = ReadS16(s, p + 22),
			tag = ReadS16(s, p + 24),
			soundtraversed = 0,
			soundtarget = nil,
			validcount = 0,
			thinglist = nil,
			specialdata = nil,
			linecount = 0,
			lines = {},
			blockbox = {},
			soundorg = { x = 0, y = 0, z = 0 },
		}
	end
	L.sectors, L.numsectors = sectors, numsectors

	-- sidedefs
	s = decodeLump(m, "SIDEDEFS")
	local sides = {}
	for i = 0, #s / 30 - 1 do
		local p = i * 30
		local function tex(name)
			if name == "-" or name == "" then return false end
			return name
		end
		sides[i] = {
			textureoffset = ReadS16(s, p),
			rowoffset = ReadS16(s, p + 2),
			toptexture = tex(ReadName(s, p + 4)),
			bottomtexture = tex(ReadName(s, p + 12)),
			midtexture = tex(ReadName(s, p + 20)),
			sector = sectors[ReadS16(s, p + 28)],
		}
		local sd = sides[i]
		sd.orig = { sd.textureoffset, sd.rowoffset, sd.toptexture, sd.bottomtexture, sd.midtexture }
	end
	L.sides = sides

	-- linedefs
	s = decodeLump(m, "LINEDEFS")
	local lines = {}
	local numlines = #s / 14
	for i = 0, numlines - 1 do
		local p = i * 14
		local v1 = vertexes[ReadU16(s, p)]
		local v2 = vertexes[ReadU16(s, p + 2)]
		local ld = {
			id = i,
			v1 = v1, v2 = v2,
			flags = ReadS16(s, p + 4),
			special = ReadS16(s, p + 6),
			tag = ReadS16(s, p + 8),
			sidenum = { [0] = ReadS16(s, p + 10), [1] = ReadS16(s, p + 12) },
			dx = v2.x - v1.x, dy = v2.y - v1.y,
			bbox = {},
			validcount = 0,
		}
		ld.ospecial, ld.oflags = ld.special, ld.flags
		if ld.dx == 0 then
			ld.slopetype = D.ST_VERTICAL
		elseif ld.dy == 0 then
			ld.slopetype = D.ST_HORIZONTAL
		elseif ld.dy / ld.dx > 0 then
			ld.slopetype = D.ST_POSITIVE
		else
			ld.slopetype = D.ST_NEGATIVE
		end
		if v1.x < v2.x then
			ld.bbox[BOXLEFT], ld.bbox[BOXRIGHT] = v1.x, v2.x
		else
			ld.bbox[BOXLEFT], ld.bbox[BOXRIGHT] = v2.x, v1.x
		end
		if v1.y < v2.y then
			ld.bbox[BOXBOTTOM], ld.bbox[BOXTOP] = v1.y, v2.y
		else
			ld.bbox[BOXBOTTOM], ld.bbox[BOXTOP] = v2.y, v1.y
		end
		ld.frontsector = ld.sidenum[0] ~= -1 and sides[ld.sidenum[0]] and sides[ld.sidenum[0]].sector or nil
		ld.backsector = ld.sidenum[1] ~= -1 and sides[ld.sidenum[1]] and sides[ld.sidenum[1]].sector or nil
		lines[i] = ld
	end
	L.lines, L.numlines = lines, numlines

	-- segs
	s = decodeLump(m, "SEGS")
	local segs = {}
	for i = 0, #s / 12 - 1 do
		local p = i * 12
		local ldef = lines[ReadS16(s, p + 6)]
		local side = ReadS16(s, p + 8)
		local sd = sides[ldef.sidenum[side]]
		local seg = {
			v1 = vertexes[ReadU16(s, p)],
			v2 = vertexes[ReadU16(s, p + 2)],
			angle = (ReadS16(s, p + 4) * 65536) % D.ANGMAX,
			offset = ReadS16(s, p + 10),
			linedef = ldef,
			sidedef = sd,
			frontsector = sd.sector,
		}
		if D.band(ldef.flags, D.ML_TWOSIDED) ~= 0 then
			local other = sides[ldef.sidenum[1 - side]]
			seg.backsector = other and other.sector or nil
		end
		segs[i] = seg
	end
	L.segs = segs

	-- subsectors
	s = decodeLump(m, "SSECTORS")
	local subsectors = {}
	for i = 0, #s / 4 - 1 do
		local p = i * 4
		local ss = { numlines = ReadS16(s, p), firstline = ReadS16(s, p + 2) }
		ss.sector = segs[ss.firstline].sidedef.sector
		subsectors[i] = ss
	end
	L.subsectors, L.numsubsectors = subsectors, #s / 4

	-- nodes
	s = decodeLump(m, "NODES")
	local nodes = {}
	local numnodes = #s / 28
	for i = 0, numnodes - 1 do
		local p = i * 28
		local n = {
			x = ReadS16(s, p), y = ReadS16(s, p + 2),
			dx = ReadS16(s, p + 4), dy = ReadS16(s, p + 6),
			bbox = {
				[0] = { ReadS16(s, p + 8), ReadS16(s, p + 10), ReadS16(s, p + 12), ReadS16(s, p + 14) },
				[1] = { ReadS16(s, p + 16), ReadS16(s, p + 18), ReadS16(s, p + 20), ReadS16(s, p + 22) },
			},
			children = { [0] = ReadU16(s, p + 24), [1] = ReadU16(s, p + 26) },
		}
		nodes[i] = n
	end
	L.nodes, L.numnodes = nodes, numnodes

	-- blockmap
	s = decodeLump(m, "BLOCKMAP")
	local bml = {}
	for i = 0, #s / 2 - 1 do
		bml[i] = ReadS16(s, i * 2)
	end
	L.blockmaplump = bml
	L.bmaporgx, L.bmaporgy = bml[0], bml[1]
	L.bmapwidth, L.bmapheight = bml[2], bml[3]
	local blocklinks = {}
	for i = 0, L.bmapwidth * L.bmapheight - 1 do blocklinks[i] = false end
	L.blocklinks = blocklinks

	-- reject
	L.rejectmatrix = decodeLump(m, "REJECT")

	-- things (spawned later by game code)
	s = decodeLump(m, "THINGS")
	local things = {}
	for i = 0, #s / 10 - 1 do
		local p = i * 10
		things[#things + 1] = {
			x = ReadS16(s, p), y = ReadS16(s, p + 2), angle = ReadS16(s, p + 4),
			type = ReadS16(s, p + 6), options = ReadS16(s, p + 8),
		}
	end
	L.mapthings = things

	-- P_GroupLines
	for i = 0, numlines - 1 do
		local li = lines[i]
		local fs = li.frontsector
		fs.lines[#fs.lines + 1] = li
		if li.backsector and li.backsector ~= fs then
			local bs = li.backsector
			bs.lines[#bs.lines + 1] = li
		end
	end
	local bbox = {}
	local MAXRADIUS = D.MAXRADIUS
	for i = 0, numsectors - 1 do
		local sector = sectors[i]
		sector.linecount = #sector.lines
		M_ClearBox(bbox)
		for _, li in ipairs(sector.lines) do
			M_AddToBox(bbox, li.v1.x, li.v1.y)
			M_AddToBox(bbox, li.v2.x, li.v2.y)
		end
		sector.soundorg.x = (bbox[BOXRIGHT] + bbox[BOXLEFT]) / 2
		sector.soundorg.y = (bbox[BOXTOP] + bbox[BOXBOTTOM]) / 2
		local bb = sector.blockbox
		local block = floor((bbox[BOXTOP] - L.bmaporgy + MAXRADIUS) / 128)
		bb[BOXTOP] = block >= L.bmapheight and L.bmapheight - 1 or block
		block = floor((bbox[BOXBOTTOM] - L.bmaporgy - MAXRADIUS) / 128)
		bb[BOXBOTTOM] = block < 0 and 0 or block
		block = floor((bbox[BOXRIGHT] - L.bmaporgx + MAXRADIUS) / 128)
		bb[BOXRIGHT] = block >= L.bmapwidth and L.bmapwidth - 1 or block
		block = floor((bbox[BOXLEFT] - L.bmaporgx - MAXRADIUS) / 128)
		bb[BOXLEFT] = block < 0 and 0 or block
	end
	return L
end

-- R_PointInSubsector
function D.PointInSubsector(x, y)
	local nodes = L.nodes
	if L.numnodes == 0 then return L.subsectors[0] end
	local nodenum = L.numnodes - 1
	while nodenum < 32768 do
		local node = nodes[nodenum]
		local side
		-- R_PointOnSide
		if node.dx == 0 then
			if x <= node.x then side = node.dy > 0 and 1 or 0 else side = node.dy < 0 and 1 or 0 end
		elseif node.dy == 0 then
			if y <= node.y then side = node.dx < 0 and 1 or 0 else side = node.dx > 0 and 1 or 0 end
		else
			local dx, dy = x - node.x, y - node.y
			side = (dy * node.dx >= node.dy * dx) and 1 or 0
		end
		nodenum = node.children[side]
	end
	return L.subsectors[nodenum - 32768]
end
