-- Testshire's ground belongs to the authored test maps, not to the live world
-- at the same numeric coordinates. Outside those maps the policy stays unknown.
return function(scene, d, maps)
	local areas, hubs, radii = d.areaCells, d.hubBins, d.hubRadii
	function scene.useGameGround()
		d.areaCells, d.hubBins, d.hubRadii = areas, hubs, radii
	end
	d.areaCells, d.hubBins, d.hubRadii = {}, {}, {}
	local function coordinate(v)
		local i = v * 10 + 8388608
		return string.char(math.floor(i / 65536), math.floor(i / 256) % 256, i % 256)
	end
	function scene.groundDisk(x, y, radius)
		local k = #d.hubRadii + 1
		d.hubRadii[k] = radius * radius
		return coordinate(x) .. coordinate(y) .. string.char(k)
	end
	function scene.addGround(map, top, bottom, left, right)
		local cells = d.areaCells[map]
		if not cells then
			cells = {}
			d.areaCells[map] = cells
			d.hubBins[map] = { Alliance = {}, Horde = {} }
		end
		for r = math.floor((512 - top * .03) / 16), math.floor((512 - bottom * .03) / 16) do
			for c = math.floor((512 - left * .03) / 16), math.floor((512 - right * .03) / 16) do
				cells[r * 64 + c] = 1
			end
		end
	end
	for _, b in pairs(maps) do scene.addGround(b.c, b.top, b.bottom, b.left, b.right) end
end
