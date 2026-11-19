-- Testshire's ground belongs to the authored test maps, not to the live world
-- at the same numeric coordinates. Outside those maps the policy stays unknown.
return function(scene, d, maps)
	local areas, hubs, creatures = d.areaCells, d.hubBins, d.creatureThreatData
	function scene.useGameGround()
		d.areaCells, d.hubBins, d.creatureThreatData = areas, hubs, creatures
	end
	d.areaCells, d.hubBins = {}, {}
	d.creatureThreatData = { version = 1, blocks = {}, maps = {} }
	function scene.addGround(map, top, bottom, left, right)
		local cells = d.areaCells[map]
		if not cells then
			cells = {}
			d.areaCells[map] = cells
			d.hubBins[map] = { Alliance = {}, Horde = {} }
			d.creatureThreatData.maps[map] = {}
		end
		for r = math.floor((512 - top * .03) / 16), math.floor((512 - bottom * .03) / 16) do
			for c = math.floor((512 - left * .03) / 16), math.floor((512 - right * .03) / 16) do
				cells[r * 64 + c] = 1
			end
		end
	end
	for _, b in pairs(maps) do scene.addGround(b.c, b.top, b.bottom, b.left, b.right) end
end
