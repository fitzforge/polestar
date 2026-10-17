-- Chinese (simplified) (zhCN): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "50级时在安戈洛环形山获得经验和两瓶治疗药水；Forever移除了经典版的物品选择。",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "施放{spell:18960}。{npc:12042}站在{area:2361}；你的职业训练师也提供同样的任务。",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "飞往{area:976}，向西骑到通往{zone:1449}的长坡：{npc:9619}在坡底扎营，位于环形山东南角。",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "格里什钉刺和{item:22434}",
	-- {item:22434} Bloodcap
	-- plural, as words: Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "环形山南部虫巢的格里什异种蝎、格里什工蝎和格里什劫掠者掉落钉刺；产出{item:22434}的血瓣花苗长满环形山西半部。",

	-- Step 5: Toxic Test
	-- {item:22432} Devilsaur Barb · {npc:6498} Devilsaur
	-- plural, as words: Devilsaurs = {npc:6498} Devilsaur
	["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "对一只{npc:6498}使用{item:22432}。魔暴龙是精英（54-55级），在环形山中游荡：建议组队。",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}：用{item:22432}刺它",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion
	["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477}位于{zone:1435}的{area:74}中。{npc:8580}守在神庙底层：这是地下城首领，请带上小队。",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "回到{zone:1449}东南角找{npc:9619}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "施放传送：{zone:1450}。{npc:12042}站在{area:2361}；你的职业训练师也提供同一任务。",
}
