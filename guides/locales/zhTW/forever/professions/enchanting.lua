-- Chinese (traditional) (zhTW): the guide forever/professions/enchanting (forever/professions/enchanting.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Enchanting
	-- {skill:333} Enchanting
	["Apprentice {skill:333}"] = "初級{skill:333}",
	-- {skill:333} Enchanting
	["{skill:333} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 4g 3s in all."] = "{skill:333}可以邊升級邊練。永恆的傳承系統會在專業技能150、225和300（中級、高級和專家級的上限）時給予製造專業獎勵，所以每個階段都很重要。1-75所需材料總價約4金3銀。",

	-- Step 2: Enchant Bracer - Inferior Stamina to 25
	-- {spell:7418} Enchant Bracer - Inferior Stamina
	["{spell:7418} to 25"] = "{spell:7418}練到25",
	["Orange (a point every craft) until 20, yellow until 22, green until 25. Enchant your own gear: any item for that slot will do."] = "橙色（每次製造必得1點）到20，黃色到22，綠色到25。附魔自己的裝備：該部位任何物品都可以。",
	["a tool: keep it in your bags"] = "工具：放在背包裡",

	-- Step 3: Enchant Bracer - Minor Deflect to 75
	-- {spell:7428} Enchant Bracer - Minor Deflect
	["{spell:7428} to 75"] = "{spell:7428}練到75",
	["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do. 75 is the Apprentice cap."] = "橙色（每次製造必得1點）到80，黃色到100，綠色到120。附魔自己的裝備：該部位任何物品都可以。75是初級的上限。",

	-- Step 4: Journeyman Enchanting
	-- {skill:333} Enchanting
	["Journeyman {skill:333}"] = "中級{skill:333}",
	-- {skill:333} Enchanting
	["Journeyman needs character level 10 and {skill:333} 50; it raises the cap to 150. Materials for 75-150 are worth about 7g 51s in all."] = "中級需要角色等級10且{skill:333}50點；上限提高到150。75-150所需材料總價約7金51銀。",

	-- Step 5: Formula: Enchant Cloak - Minor Agility
	-- {spell:13419} Enchant Cloak - Minor Agility · {skill:333} Enchanting
	["Teaches {spell:13419} (needs {skill:333} 110). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "學會{spell:13419}（需要{skill:333}110點）。商人限量販售，會補貨；拍賣場也常有。",

	-- Step 6: Shadowgem (Alliance)
	-- {item:1210} Shadowgem
	["{item:1210} (Alliance)"] = "{item:1210}（聯盟）",
	-- {item:1210} Shadowgem · {object:1731} Copper Vein · {skill:186} Mining
	["{item:1210} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:1210}來自{object:1731}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",

	-- Step 7: Shadowgem (Horde)
	-- {item:1210} Shadowgem
	["{item:1210} (Horde)"] = "{item:1210}（部落）",

	-- Step 8: Enchanting materials for 75-150
	-- {skill:333} Enchanting
	["{skill:333} materials for 75-150"] = "{skill:333}75-150的材料",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剝皮、分解或其他專業製造的材料：自己採集或在拍賣場購買。",
	-- {skill:164} Blacksmithing · {item:6338} Silver Rod
	["{skill:164}: {item:6338} (or the Auction House)"] = "{skill:164}：{item:6338}（或在拍賣場購買）",
	-- {skill:333} Enchanting
	["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}：分解優秀（綠色）裝備（或在拍賣場購買）",

	-- Step 9: Enchant Bracer - Minor Deflect to 90
	-- {spell:7428} Enchant Bracer - Minor Deflect
	["{spell:7428} to 90"] = "{spell:7428}練到90",
	["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do."] = "橙色（每次製造必得1點）到80，黃色到100，綠色到120。附魔自己的裝備：該部位任何物品都可以。",

	-- Step 10: Enchanting recipes at 90
	-- {skill:333} Enchanting
	["{skill:333} recipes at 90"] = "{skill:333}90點的配方",
	-- {skill:333} Enchanting · {spell:7426} Enchant Chest - Minor Absorption
	["Back to an {skill:333} trainer: {spell:7426} is taught from {skill:333} 90."] = "回到{skill:333}訓練師那裡：{spell:7426}在{skill:333}90點時可學。",

	-- Step 11: Enchant Chest - Minor Absorption to 120
	-- {spell:7426} Enchant Chest - Minor Absorption
	["{spell:7426} to 120"] = "{spell:7426}練到120",
	["Yellow until 110, green until 130: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到110，綠色到130：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",

	-- Step 12: Enchanting recipes at 120
	-- {skill:333} Enchanting
	["{skill:333} recipes at 120"] = "{skill:333}120點的配方",
	-- {skill:333} Enchanting · {spell:7788} Enchant Weapon - Minor Striking
	["Back to an {skill:333} trainer: {spell:7788} is taught from {skill:333} 120."] = "回到{skill:333}訓練師那裡：{spell:7788}在{skill:333}120點時可學。",

	-- Step 13: Enchant Weapon - Minor Striking to 130
	-- {spell:7788} Enchant Weapon - Minor Striking
	["{spell:7788} to 130"] = "{spell:7788}練到130",
	["Yellow until 140, green until 160: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到140，綠色到160：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",

	-- Step 14: Enchanting recipes at 130
	-- {skill:333} Enchanting
	["{skill:333} recipes at 130"] = "{skill:333}130點的配方",
	-- {skill:333} Enchanting · {spell:7795} Runed Silver Rod
	["Back to an {skill:333} trainer: {spell:7795} is taught from {skill:333} 130."] = "回到{skill:333}訓練師那裡：{spell:7795}在{skill:333}130點時可學。",

	-- Step 15: Enchant Cloak - Minor Agility to 150
	-- {spell:13419} Enchant Cloak - Minor Agility
	["{spell:13419} to 150"] = "{spell:13419}練到150",
	-- {skill:333} Enchanting
	["Orange (a point every craft) until 135, yellow until 155, green until 175. Enchant your own gear: any item for that slot will do. {skill:333} 150 is a Legacy System milestone."] = "橙色（每次製造必得1點）到135，黃色到155，綠色到175。附魔自己的裝備：該部位任何物品都可以。{skill:333}150是傳承系統的里程碑。",
	["from the recipe in your bags"] = "使用背包裡的配方",

	-- Step 16: Expert Enchanting
	-- {skill:333} Enchanting
	["Expert {skill:333}"] = "高級{skill:333}",
	-- {skill:333} Enchanting
	["Expert needs character level 20 and {skill:333} 125; it raises the cap to 225. Materials for 150-225 are worth about 13s in all."] = "高級需要角色等級20且{skill:333}125點；上限提高到225。150-225所需材料總價約13銀。",

	-- Step 17: Iridescent Pearl (Alliance)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Alliance)"] = "{item:5500}（聯盟）",
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Open Giant Clams here. The Auction House works too."] = "在這裡打開巨型蚌殼。拍賣場也買得到。",

	-- Step 18: Iridescent Pearl (Horde)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Horde)"] = "{item:5500}（部落）",

	-- Step 19: Enchanting materials for 150-225
	-- {skill:333} Enchanting
	["{skill:333} materials for 150-225"] = "{skill:333}150-225的材料",
	-- {skill:171} Alchemy · {item:6371} Fire Oil
	["{skill:171}: {item:6371} (or the Auction House)"] = "{skill:171}：{item:6371}（或在拍賣場購買）",
	-- {skill:164} Blacksmithing · {item:11128} Golden Rod
	["{skill:164}: {item:11128} (or the Auction House)"] = "{skill:164}：{item:11128}（或在拍賣場購買）",

	-- Step 20: Enchant Cloak - Lesser Fire Resistance to 155
	-- {spell:7861} Enchant Cloak - Lesser Fire Resistance
	["{spell:7861} to 155"] = "{spell:7861}練到155",
	["Yellow until 170, green until 190: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到170，綠色到190：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",

	-- Step 21: Enchanting recipes at 155
	-- {skill:333} Enchanting
	["{skill:333} recipes at 155"] = "{skill:333}155點的配方",
	-- {skill:333} Enchanting · {spell:13501} Enchant Bracer - Lesser Stamina
	["Back to an {skill:333} trainer: {spell:13501} is taught from {skill:333} 155."] = "回到{skill:333}訓練師那裡：{spell:13501}在{skill:333}155點時可學。",

	-- Step 22: Enchant Bracer - Lesser Stamina to 180
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 180"] = "{spell:13501}練到180",
	["Yellow until 175, green until 195: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到175，綠色到195：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",

	-- Step 23: Enchanting recipes at 180
	-- {skill:333} Enchanting
	["{skill:333} recipes at 180"] = "{skill:333}180點的配方",
	-- {skill:333} Enchanting · {spell:13628} Runed Golden Rod · {spell:13637} Enchant Boots - Lesser Agility
	["Back to an {skill:333} trainer: {spell:13628}, {spell:13637} are taught from {skill:333} 180."] = "回到{skill:333}訓練師那裡：{spell:13628}、{spell:13637}在{skill:333}180點時可學。",

	-- Step 24: Enchant Boots - Lesser Agility to 200
	-- {spell:13637} Enchant Boots - Lesser Agility
	["{spell:13637} to 200"] = "{spell:13637}練到200",
	["Yellow until 200, green until 220: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到200，綠色到220：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",

	-- Step 25: Enchanting recipes at 200
	-- {skill:333} Enchanting
	["{skill:333} recipes at 200"] = "{skill:333}200點的配方",
	-- {skill:333} Enchanting · {spell:13661} Enchant Bracer - Strength
	["Back to an {skill:333} trainer: {spell:13661} is taught from {skill:333} 200."] = "回到{skill:333}訓練師那裡：{spell:13661}在{skill:333}200點時可學。",

	-- Step 26: Enchant Bracer - Strength to 225
	-- {spell:13661} Enchant Bracer - Strength
	["{spell:13661} to 225"] = "{spell:13661}練到225",
	-- {skill:333} Enchanting
	["Yellow until 220, green until 240: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 225 is a Legacy System milestone."] = "黃色到220，綠色到240：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。{skill:333}225是傳承系統的里程碑。",

	-- Step 27: Artisan Enchanting
	-- {skill:333} Enchanting
	["Artisan {skill:333}"] = "專家級{skill:333}",
	-- {skill:333} Enchanting
	["Artisan needs character level 35 and {skill:333} 200; it raises the cap to 300. Materials for 225-300 are worth about 30s in all."] = "專家級需要角色等級35且{skill:333}200點；上限提高到300。225-300所需材料總價約30銀。",
	-- {npc:11073} Annora · {skill:333} Enchanting · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group"] = "{npc:11073}在{area:1517}地城（{zone:1418}）裡教授專家級{skill:333}；請組隊前往",

	-- Step 28: Black Pearl (Alliance)
	-- {item:7971} Black Pearl
	["{item:7971} (Alliance)"] = "{item:7971}（聯盟）",
	-- {npc:922} Silt Crawler
	["{npc:922} (level 40-41) drop it here. The Auction House works too."] = "{npc:922}（40-41級）在這裡掉落。拍賣場也買得到。",

	-- Step 29: Black Pearl (Horde)
	-- {item:7971} Black Pearl
	["{item:7971} (Horde)"] = "{item:7971}（部落）",
	-- {npc:5431} Surf Glider
	["{npc:5431} (level 48-50) drop it here. The Auction House works too."] = "{npc:5431}（48-50級）在這裡掉落。拍賣場也買得到。",

	-- Step 30: Wildvine (Alliance)
	-- {item:8153} Wildvine
	["{item:8153} (Alliance)"] = "{item:8153}（聯盟）",
	-- {item:8153} Wildvine · {item:8831} Purple Lotus · {skill:182} Herbalism
	["{item:8153} comes from {item:8831} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:8153}來自{item:8831}（{skill:182}）；這裡是資料中最密集的草點。拍賣場也買得到。",

	-- Step 31: Wildvine (Horde)
	-- {item:8153} Wildvine
	["{item:8153} (Horde)"] = "{item:8153}（部落）",

	-- Step 32: Enchanting materials for 225-300
	-- {skill:333} Enchanting
	["{skill:333} materials for 225-300"] = "{skill:333}225-300的材料",
	-- {skill:164} Blacksmithing · {item:11144} Truesilver Rod
	["{skill:164}: {item:11144} (or the Auction House)"] = "{skill:164}：{item:11144}（或在拍賣場購買）",

	-- Step 33: Enchant Cloak - Greater Defense to 255
	-- {spell:13746} Enchant Cloak - Greater Defense
	["{spell:13746} to 255"] = "{spell:13746}練到255",
	["Yellow until 245, green until 265: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到245，綠色到265：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",

	-- Step 34: Enchanting recipes at 255
	-- {skill:333} Enchanting
	["{skill:333} recipes at 255"] = "{skill:333}255點的配方",
	-- {skill:333} Enchanting · {spell:13935} Enchant Boots - Agility
	["Back to an {skill:333} trainer: {spell:13935} is taught from {skill:333} 255."] = "回到{skill:333}訓練師那裡：{spell:13935}在{skill:333}255點時可學。",

	-- Step 35: Enchant Boots - Agility to 292
	-- {spell:13935} Enchant Boots - Agility
	["{spell:13935} to 292"] = "{spell:13935}練到292",
	["Yellow until 275, green until 295: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到275，綠色到295：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",

	-- Step 36: Enchanting recipes at 292
	-- {skill:333} Enchanting
	["{skill:333} recipes at 292"] = "{skill:333}292點的配方",
	-- {skill:333} Enchanting · {spell:13948} Enchant Gloves - Minor Haste
	["Back to an {skill:333} trainer: {spell:13948} is taught from {skill:333} 270."] = "回到{skill:333}訓練師那裡：{spell:13948}在{skill:333}270點時可學。",

	-- Step 37: Enchant Gloves - Minor Haste to 300
	-- {spell:13948} Enchant Gloves - Minor Haste
	["{spell:13948} to 300"] = "{spell:13948}練到300",
	-- {skill:333} Enchanting
	["Yellow until 290, green until 310: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 300 is a Legacy System milestone."] = "黃色到290，綠色到310：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。{skill:333}300是傳承系統的里程碑。",
}
