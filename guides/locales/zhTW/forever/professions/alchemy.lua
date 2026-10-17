-- Chinese (traditional) (zhTW): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Alchemy
	-- {skill:171} Alchemy
	["Apprentice {skill:171}"] = "初級{skill:171}",
	-- {skill:171} Alchemy
	["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171}可以邊升級邊練。Forever的傳承系統會在技能150、225和300（中級、高級和專家級的上限）獎勵製造專業，所以每個關卡都很重要。1-75的材料總價約68銀。",

	-- Step 2: Silverleaf (Alliance)
	-- {item:765} Silverleaf
	["{item:765} (Alliance)"] = "{item:765}（聯盟）",
	-- {item:765} Silverleaf · {skill:182} Herbalism
	["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:765}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 3: Silverleaf (Horde)
	-- {item:765} Silverleaf
	["{item:765} (Horde)"] = "{item:765}（部落）",

	-- Step 4: Peacebloom (Alliance)
	-- {item:2447} Peacebloom
	["{item:2447} (Alliance)"] = "{item:2447}（聯盟）",
	-- {item:2447} Peacebloom · {skill:182} Herbalism
	["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:2447}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 5: Peacebloom (Horde)
	-- {item:2447} Peacebloom
	["{item:2447} (Horde)"] = "{item:2447}（部落）",

	-- Step 6: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997}練到75",
	["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "55前為橘色（每次製作都加點），75前為黃色，95前為綠色。75是初級的上限。",

	-- Step 7: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "中級{skill:171}",
	-- {skill:171} Alchemy
	["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "中級需要角色等級10和{skill:171}50；上限提高到150。75-150的材料總價約1金44銀。",

	-- Step 8: Recipe: Holy Protection Potion
	-- {item:6051} Holy Protection Potion · {skill:171} Alchemy
	["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "學會{item:6051}（需要{skill:171}100）。商人限量販售，會補貨；拍賣場也常有。",

	-- Step 9: Murloc Eye (Alliance)
	-- {item:730} Murloc Eye
	["{item:730} (Alliance)"] = "{item:730}（聯盟）",
	-- {npc:513} Murloc Netter
	["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "{npc:513}（等級14-15）在這裡掉落。拍賣場也買得到。",

	-- Step 10: Murloc Eye (Horde)
	-- {item:730} Murloc Eye
	["{item:730} (Horde)"] = "{item:730}（部落）",
	-- {npc:1958} Vile Fin Tidecaller
	["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "{npc:1958}（等級17-18）在這裡掉落。拍賣場也買得到。",

	-- Step 11: Mageroyal (Alliance)
	-- {item:785} Mageroyal
	["{item:785} (Alliance)"] = "{item:785}（聯盟）",
	-- {item:785} Mageroyal · {skill:182} Herbalism
	["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:785}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 12: Mageroyal (Horde)
	-- {item:785} Mageroyal
	["{item:785} (Horde)"] = "{item:785}（部落）",

	-- Step 15: Briarthorn (Alliance)
	-- {item:2450} Briarthorn
	["{item:2450} (Alliance)"] = "{item:2450}（聯盟）",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:2450}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 16: Briarthorn (Horde)
	-- {item:2450} Briarthorn
	["{item:2450} (Horde)"] = "{item:2450}（部落）",

	-- Step 17: Swiftthistle (Alliance)
	-- {item:2452} Swiftthistle
	["{item:2452} (Alliance)"] = "{item:2452}（聯盟）",
	-- {item:2452} Swiftthistle · {item:2450} Briarthorn · {skill:182} Herbalism
	["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452}來自{item:2450}採集點（{skill:182}）；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 18: Swiftthistle (Horde)
	-- {item:2452} Swiftthistle
	["{item:2452} (Horde)"] = "{item:2452}（部落）",

	-- Step 19: Bruiseweed (Alliance)
	-- {item:2453} Bruiseweed
	["{item:2453} (Alliance)"] = "{item:2453}（聯盟）",
	-- {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:2453}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 20: Bruiseweed (Horde)
	-- {item:2453} Bruiseweed
	["{item:2453} (Horde)"] = "{item:2453}（部落）",

	-- Step 21: Minor Mana Potion to 85
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 85"] = "{spell:2331}練到85",
	["Yellow until 85, green until 105: not every craft gives a point."] = "85前為黃色，105前為綠色：不是每次製作都加點。",

	-- Step 22: Alchemy recipes at 85
	-- {skill:171} Alchemy
	["{skill:171} recipes at 85"] = "{skill:171}85的配方",
	-- {skill:171} Alchemy · {spell:1244645} Lesser Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "回到{skill:171}訓練師：{skill:171}85起可學{spell:1244645}。",

	-- Step 23: Lesser Discolored Healing Potion to 100
	-- {item:247239} Lesser Discolored Healing Potion
	["{item:247239} to 100"] = "{item:247239}練到100",
	["Yellow until 105, green until 125: not every craft gives a point."] = "105前為黃色，125前為綠色：不是每次製作都加點。",

	-- Step 24: Holy Protection Potion to 150
	-- {item:6051} Holy Protection Potion
	["{item:6051} to 150"] = "{item:6051}練到150",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "130前為橘色（每次製作都加點），150前為黃色，170前為綠色。{skill:171}150是傳承系統的里程碑。",
	["from the recipe in your bags"] = "使用背包中的配方",

	-- Step 25: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "高級{skill:171}",
	-- {skill:171} Alchemy
	["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "高級需要角色等級20和{skill:171}125；上限提高到225。150-225的材料總價約3金65銀。",

	-- Step 26: Murloc Eye
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在Polestar依你的等級和陣營選定的地點擊殺掉落它的怪物。拍賣場也買得到。",

	-- Step 27: Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Alliance)"] = "{object:1623}（聯盟）",
	-- {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{object:1623}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 28: Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Horde)"] = "{object:1623}（部落）",

	-- Step 29: Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["{item:3356} (Alliance)"] = "{item:3356}（聯盟）",
	-- {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:3356}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 30: Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["{item:3356} (Horde)"] = "{item:3356}（部落）",

	-- Step 31: Liferoot (Alliance)
	-- {item:3357} Liferoot
	["{item:3357} (Alliance)"] = "{item:3357}（聯盟）",
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:3357}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 32: Liferoot (Horde)
	-- {item:3357} Liferoot
	["{item:3357} (Horde)"] = "{item:3357}（部落）",

	-- Step 33: Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["{object:2046} (Alliance)"] = "{object:2046}（聯盟）",
	-- {object:2046} Goldthorn · {skill:182} Herbalism
	["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{object:2046}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 34: Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["{object:2046} (Horde)"] = "{object:2046}（部落）",

	-- Step 35: Oily Blackmouth (Alliance)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Alliance)"] = "{item:6358}（聯盟）",
	-- {object:180582} Oily Blackmouth School
	["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "在{object:180582}釣魚；資料中這裡最多。拍賣場也買得到。",

	-- Step 36: Oily Blackmouth (Horde)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Horde)"] = "{item:6358}（部落）",

	-- Step 37: Firefin Snapper (Alliance)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Alliance)"] = "{item:6359}（聯盟）",
	-- {object:180657} Firefin Snapper School
	["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "在{object:180657}釣魚；資料中這裡最多。拍賣場也買得到。",

	-- Step 38: Firefin Snapper (Horde)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Horde)"] = "{item:6359}（部落）",

	-- Step 39: Fire Oil to 165
	-- {item:6371} Fire Oil
	["{item:6371} to 165"] = "{item:6371}練到165",
	["Yellow until 160, green until 170: not every craft gives a point."] = "160前為黃色，170前為綠色：不是每次製作都加點。",

	-- Step 40: Alchemy recipes at 165
	-- {skill:171} Alchemy
	["{skill:171} recipes at 165"] = "{skill:171}165的配方",
	-- {skill:171} Alchemy · {spell:7845} Elixir of Fire Power
	["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "回到{skill:171}訓練師：{skill:171}165起可學{spell:7845}。",

	-- Step 41: Elixir of Fire Power to 175
	-- {spell:7845} Elixir of Fire Power
	["{spell:7845} to 175"] = "{spell:7845}練到175",
	["Yellow until 185, green until 205: not every craft gives a point."] = "185前為黃色，205前為綠色：不是每次製作都加點。",

	-- Step 42: Alchemy recipes at 175
	-- {skill:171} Alchemy
	["{skill:171} recipes at 175"] = "{skill:171}175的配方",
	-- {skill:171} Alchemy · {spell:1244647} Greater Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "回到{skill:171}訓練師：{skill:171}175起可學{spell:1244647}。",

	-- Step 43: Greater Discolored Healing Potion to 200
	-- {item:247241} Greater Discolored Healing Potion
	["{item:247241} to 200"] = "{item:247241}練到200",
	["Yellow until 195, green until 215: not every craft gives a point."] = "195前為黃色，215前為綠色：不是每次製作都加點。",

	-- Step 44: Alchemy recipes at 200
	-- {skill:171} Alchemy
	["{skill:171} recipes at 200"] = "{skill:171}200的配方",
	-- {skill:171} Alchemy · {spell:11447} Draught of Water Walking
	["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "回到{skill:171}訓練師：{skill:171}190起可學{spell:11447}。",

	-- Step 45: Draught of Water Walking to 215
	-- {spell:11447} Draught of Water Walking
	["{spell:11447} to 215"] = "{spell:11447}練到215",
	["Yellow until 210, green until 230: not every craft gives a point."] = "210前為黃色，230前為綠色：不是每次製作都加點。",

	-- Step 46: Alchemy recipes at 215
	-- {skill:171} Alchemy
	["{skill:171} recipes at 215"] = "{skill:171}215的配方",
	-- {skill:171} Alchemy · {spell:11450} Elixir of Defense
	["Back to an {skill:171} trainer: {spell:11450} is taught from {skill:171} 215."] = "回到{skill:171}訓練師：{skill:171}215起可學{spell:11450}。",

	-- Step 47: Elixir of Defense to 225
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 225"] = "{spell:11450}練到225",
	-- {skill:171} Alchemy
	["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "235前為黃色，255前為綠色：不是每次製作都加點。{skill:171}225是傳承系統的里程碑。",

	-- Step 48: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "專家級{skill:171}",
	-- {skill:171} Alchemy
	["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "專家級需要角色等級35和{skill:171}200；上限提高到300。225-300的材料總價約7金80銀。",

	-- Step 49: Recipe: Elixir of Superior Defense
	-- {item:8951} Elixir of Greater Defense · {skill:171} Alchemy
	["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "學會{item:8951}（需要{skill:171}265）。商人限量販售，會補貨；拍賣場也常有。",

	-- Step 55: Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Alliance)"] = "{item:8836}（聯盟）",
	-- {item:8836} Arthas' Tears · {skill:182} Herbalism
	["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:8836}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 56: Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Horde)"] = "{item:8836}（部落）",

	-- Step 57: Sungrass (Alliance)
	-- {item:8838} Sungrass
	["{item:8838} (Alliance)"] = "{item:8838}（聯盟）",
	-- {item:8838} Sungrass · {skill:182} Herbalism
	["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:8838}；這是資料中最密集的區域。拍賣場也買得到。",

	-- Step 58: Sungrass (Horde)
	-- {item:8838} Sungrass
	["{item:8838} (Horde)"] = "{item:8838}（部落）",

	-- Step 59: Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Alliance)"] = "{item:13422}（聯盟）",
	-- {object:180712} Stonescale Eel Swarm
	["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "在{object:180712}釣魚；資料中這裡最多。拍賣場也買得到。",

	-- Step 60: Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Horde)"] = "{item:13422}（部落）",

	-- Step 61: Elixir of Defense to 230
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 230"] = "{spell:11450}練到230",
	["Yellow until 235, green until 255: not every craft gives a point."] = "235前為黃色，255前為綠色：不是每次製作都加點。",

	-- Step 62: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "{skill:171}230的配方",
	-- {skill:171} Alchemy · {spell:1244648} Superior Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "回到{skill:171}訓練師：{skill:171}230起可學{spell:1244648}。",

	-- Step 63: Superior Discolored Healing Potion to 250
	-- {item:247242} Superior Discolored Healing Potion
	["{item:247242} to 250"] = "{item:247242}練到250",
	["Yellow until 250, green until 270: not every craft gives a point."] = "250前為黃色，270前為綠色：不是每次製作都加點。",

	-- Step 64: Alchemy recipes at 250
	-- {skill:171} Alchemy
	["{skill:171} recipes at 250"] = "{skill:171}250的配方",
	-- {skill:171} Alchemy · {spell:17551} Stonescale Oil
	["Back to an {skill:171} trainer: {spell:17551} is taught from {skill:171} 250."] = "回到{skill:171}訓練師：{skill:171}250起可學{spell:17551}。",

	-- Step 65: Stonescale Oil to 259
	-- {item:13423} Stonescale Oil
	["{item:13423} to 259"] = "{item:13423}練到259",
	["Yellow until 255, green until 260: not every craft gives a point."] = "255前為黃色，260前為綠色：不是每次製作都加點。",

	-- Step 66: Alchemy recipes at 259
	-- {skill:171} Alchemy
	["{skill:171} recipes at 259"] = "{skill:171}259的配方",
	-- {skill:171} Alchemy · {spell:11460} Draught of Detect Undead
	["Back to an {skill:171} trainer: {spell:11460} is taught from {skill:171} 245."] = "回到{skill:171}訓練師：{skill:171}245起可學{spell:11460}。",

	-- Step 67: Draught of Detect Undead to 265
	-- {spell:11460} Draught of Detect Undead
	["{spell:11460} to 265"] = "{spell:11460}練到265",
	["Yellow until 265, green until 285: not every craft gives a point."] = "265前為黃色，285前為綠色：不是每次製作都加點。",

	-- Step 68: Elixir of Greater Defense to 300
	-- {spell:17554} Elixir of Greater Defense
	["{spell:17554} to 300"] = "{spell:17554}練到300",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "280前為橘色（每次製作都加點），300前為黃色，320前為綠色。{skill:171}300是傳承系統的里程碑。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:3355}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:3821}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["{item:3355} (Alliance)"] = "{item:3355}（聯盟）",
	-- ["{item:3355} (Horde)"] = "{item:3355}（部落）",
	-- ["{item:3821} (Alliance)"] = "{item:3821}（聯盟）",
	-- ["{item:3821} (Horde)"] = "{item:3821}（部落）",
}
