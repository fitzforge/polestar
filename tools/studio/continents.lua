-- The client's map tree for the studio's maps (loaded before the session
-- adds them): the two continents as continent-type maps (uiMapType 2), every
-- zone map of instance 0 or 1 a child of its continent, so C_Map.GetMapInfo's
-- parentMapID chain finds the continent as in game.
local CONTINENT = { [0] = 1415, [1] = 1414 }
local w = stub.world
local addMap = w.addMap
function w.addMap(id, b)
	addMap(id, b)
	local m = w.maps[id]
	if id == 1414 or id == 1415 then
		m.mapType = 2
	elseif CONTINENT[m.c] and not m.parent then
		m.parent = CONTINENT[m.c]
	end
end

-- GetFileIDFromPath, as the client answers it: a file ID for a path the
-- client has (here: the art cache's files), nil for one it does not.
if not GetFileIDFromPath then
	function GetFileIDFromPath(p)
		if type(p) ~= "string" or not STUDIO_FILES then return nil end
		return STUDIO_FILES[(p:lower():gsub("/", "\\"):gsub("%.blp$", ""))]
	end
end
