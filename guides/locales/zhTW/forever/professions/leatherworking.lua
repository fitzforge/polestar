-- Chinese (traditional) (zhTW): the guide forever/professions/leatherworking (forever/professions/leatherworking.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Leatherworking
	-- {skill:165} Leatherworking
	["Apprentice {skill:165}"] = "初級{skill:165}",
	-- {skill:165} Leatherworking
	["{skill:165} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 18s in all."] = "{skill:165}可以邊升級邊練。Forever的傳承系統會在技能150、225和300（中級、高級和專家級的上限）獎勵製造專業，所以每個關卡都很重要。1-75所需材料總價約1金18銀。",

	-- Step 2: Light Leather (Alliance)
	-- {item:2318} Light Leather
	["{item:2318} (Alliance)"] = "{item:2318}（聯盟）",
	-- {npc:1125} Crag Boar · {npc:1127} Elder Crag Boar · {npc:1196} Ice Claw Bear · {npc:1199} Juvenile Snow Leopard · {npc:1126} Large Crag Boar · {npc:1689} Scarred Crag Boar · {npc:1201} Snow Leopard · {npc:1138} Snow Tracker Wolf · {npc:1131} Winter Wolf · {npc:1128} Young Black Bear · {skill:393} Skinning
	["Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:1125}、{npc:1127}、{npc:1196}、{npc:1199}、{npc:1126}、{npc:1689}、{npc:1201}、{npc:1138}、{npc:1131}、{npc:1128}的皮（5-20級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 3: Light Leather (Horde)
	-- {item:2318} Light Leather
	["{item:2318} (Horde)"] = "{item:2318}（部落）",
	-- {npc:3126} Armored Scorpid · {npc:3123} Bloodtalon Scythemaw · {npc:3122} Bloodtalon Taillasher · {npc:3125} Clattering Scorpid · {npc:3099} Dire Mottled Boar · {npc:3110} Dreadmaw Crocolisk · {npc:3121} Durotar Tiger · {npc:3100} Elder Mottled Boar · {npc:3130} Thunder Lizard · {npc:3127} Venomtail Scorpid · {skill:393} Skinning
	["Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:3126}、{npc:3123}、{npc:3122}、{npc:3125}、{npc:3099}、{npc:3110}、{npc:3121}、{npc:3100}、{npc:3130}、{npc:3127}的皮（5-20級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 4: Light Armor Kit to 55
	-- {spell:2152} Light Armor Kit
	["{spell:2152} to 55"] = "{spell:2152}練到55",
	["Orange (a point every craft) until 30, yellow until 45, green until 60."] = "橙色（每次製造必得1點）到30，黃色到45，綠色到60。",

	-- Step 5: Leatherworking recipes at 55
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 55"] = "{skill:165}55點的配方",
	-- {skill:165} Leatherworking · {spell:9062} Small Leather Ammo Pouch
	["Back to a {skill:165} trainer: {spell:9062} is taught from {skill:165} 55."] = "回到{skill:165}訓練師那裡：{spell:9062}在{skill:165}55點時可學。",

	-- Step 6: Small Leather Ammo Pouch to 75
	-- {item:7279} Small Leather Ammo Pouch
	["{item:7279} to 75"] = "{item:7279}練到75",
	["Yellow until 70, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "黃色到70，綠色到85：不是每次製造都會得到點數。75是初級的上限。",

	-- Step 7: Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Journeyman {skill:165}"] = "中級{skill:165}",
	-- {skill:165} Leatherworking
	["Journeyman needs character level 10 and {skill:165} 50; it raises the cap to 150. Materials for 75-150 are worth about 11g in all."] = "中級需要角色等級10且{skill:165}50點；上限提高到150。75-150所需材料總價約11金。",

	-- Step 8: Light Hide (Alliance)
	-- {item:783} Light Hide
	["{item:783} (Alliance)"] = "{item:783}（聯盟）",

	-- Step 9: Light Hide (Horde)
	-- {item:783} Light Hide
	["{item:783} (Horde)"] = "{item:783}（部落）",

	-- Step 12: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319}（聯盟）",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、鉗嘴龜、{npc:2384}、{npc:2354}的皮（18-30級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 13: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}的皮（18-30級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 14: Medium Hide (Alliance)
	-- {item:4232} Medium Hide
	["{item:4232} (Alliance)"] = "{item:4232}（聯盟）",

	-- Step 15: Medium Hide (Horde)
	-- {item:4232} Medium Hide
	["{item:4232} (Horde)"] = "{item:4232}（部落）",

	-- Step 16: Leatherworking materials for 75-150
	-- {skill:165} Leatherworking
	["{skill:165} materials for 75-150"] = "{skill:165}75-150所需材料",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剝皮、分解或由其他專業製造：自己收集或在拍賣場購買。",
	-- {skill:171} Alchemy · {item:2457} Elixir of Minor Agility
	["{skill:171}: {item:2457} (or the Auction House)"] = "{skill:171}：{item:2457}（或拍賣場）",

	-- Step 17: Embossed Leather Gloves to 85
	-- {spell:3756} Embossed Leather Gloves
	["{spell:3756} to 85"] = "{spell:3756}練到85",
	["Yellow until 85, green until 100: not every craft gives a point."] = "黃色到85，綠色到100：不是每次製造都會得到點數。",

	-- Step 18: Leatherworking recipes at 85
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 85"] = "{skill:165}85點的配方",
	-- {skill:165} Leatherworking · {spell:3763} Fine Leather Belt
	["Back to a {skill:165} trainer: {spell:3763} is taught from {skill:165} 85."] = "回到{skill:165}訓練師那裡：{spell:3763}在{skill:165}85點時可學。",

	-- Step 19: Fine Leather Belt to 105
	-- {spell:3763} Fine Leather Belt
	["{spell:3763} to 105"] = "{spell:3763}練到105",
	["Yellow until 100, green until 115: not every craft gives a point."] = "黃色到100，綠色到115：不是每次製造都會得到點數。",

	-- Step 20: Leatherworking recipes at 105
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 105"] = "{skill:165}105點的配方",
	-- {skill:165} Leatherworking · {spell:9068} Light Leather Pants
	["Back to a {skill:165} trainer: {spell:9068} is taught from {skill:165} 100."] = "回到{skill:165}訓練師那裡：{spell:9068}在{skill:165}100點時可學。",

	-- Step 21: Light Leather Pants to 120
	-- {item:7282} Light Leather Pants
	["{item:7282} to 120"] = "{item:7282}練到120",
	["Yellow until 115, green until 130: not every craft gives a point."] = "黃色到115，綠色到130：不是每次製造都會得到點數。",

	-- Step 22: Leatherworking recipes at 120
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 120"] = "{skill:165}120點的配方",
	-- {skill:165} Leatherworking · {spell:9074} Nimble Leather Gloves
	["Back to a {skill:165} trainer: {spell:9074} is taught from {skill:165} 120."] = "回到{skill:165}訓練師那裡：{spell:9074}在{skill:165}120點時可學。",

	-- Step 23: Nimble Leather Gloves to 130
	-- {item:7285} Nimble Leather Gloves
	["{item:7285} to 130"] = "{item:7285}練到130",
	["Yellow until 132, green until 145: not every craft gives a point."] = "黃色到132，綠色到145：不是每次製造都會得到點數。",

	-- Step 24: Leatherworking recipes at 130
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 130"] = "{skill:165}130點的配方",
	-- {skill:165} Leatherworking · {spell:3817} Cured Medium Hide · {spell:3768} Hillman's Shoulders
	["Back to a {skill:165} trainer: {spell:3817}, {spell:3768} are taught from {skill:165} 130."] = "回到{skill:165}訓練師那裡：{spell:3817}、{spell:3768}在{skill:165}130點時可學。",

	-- Step 25: Hillman's Shoulders to 150
	-- {spell:3768} Hillman's Shoulders
	["{spell:3768} to 150"] = "{spell:3768}練到150",
	-- {skill:165} Leatherworking
	["Yellow until 142, green until 155: not every craft gives a point. {skill:165} 150 is a Legacy System milestone."] = "黃色到142，綠色到155：不是每次製造都會得到點數。{skill:165}150是傳承系統的里程碑。",

	-- Step 26: Expert Leatherworking
	-- {skill:165} Leatherworking
	["Expert {skill:165}"] = "高級{skill:165}",
	-- {skill:165} Leatherworking
	["Expert needs character level 20 and {skill:165} 125; it raises the cap to 225. Materials for 150-225 are worth about 61g in all."] = "高級需要角色等級20且{skill:165}125點；上限提高到225。150-225所需材料總價約61金。",

	-- Step 27: Pattern: Mystic Heavy Armor Kit
	-- {item:252452} Mystic Heavy Armor Kit · {skill:165} Leatherworking
	["Teaches {item:252452} (needs {skill:165} 135)."] = "學會{item:252452}（需要{skill:165}135點）。",

	-- Step 28: Pattern: Forceful Thick Armor Kit
	-- {item:252463} Forceful Thick Armor Kit · {skill:165} Leatherworking
	["Teaches {item:252463} (needs {skill:165} 185)."] = "學會{item:252463}（需要{skill:165}185點）。",

	-- Step 29: Heavy Leather (Alliance)
	-- {item:4234} Heavy Leather
	["{item:4234} (Alliance)"] = "{item:4234}（聯盟）",
	-- {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Snapjaw here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:2248}、{npc:2249}、{npc:2251}、{npc:2407}、{npc:2406}、{npc:2250}、鉗嘴龜的皮（28-40級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 30: Heavy Leather (Horde)
	-- {item:4234} Heavy Leather
	["{item:4234} (Horde)"] = "{item:4234}（部落）",
	-- {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise · {skill:393} Skinning
	["Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:4107}、{npc:4147}、{npc:4140}、{npc:4139}、{npc:4143}、{npc:4142}的皮（28-40級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 31: Heavy Hide (Alliance)
	-- {item:4235} Heavy Hide
	["{item:4235} (Alliance)"] = "{item:4235}（聯盟）",

	-- Step 32: Heavy Hide (Horde)
	-- {item:4235} Heavy Hide
	["{item:4235} (Horde)"] = "{item:4235}（部落）",

	-- Step 33: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304}（聯盟）",
	-- {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {skill:393} Skinning
	["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:2729}、{npc:2730}、{npc:2732}、{npc:2734}的皮（38-50級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 34: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304}（部落）",
	-- {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti · {skill:393} Skinning
	["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:5292}、{npc:5300}、{npc:5304}、{npc:5272}、{npc:5260}、{npc:5262}、{npc:5268}、{npc:5274}、{npc:5287}、{npc:5286}、{npc:5296}的皮（38-50級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 35: Deeprock Salt (Alliance)
	-- {item:8150} Deeprock Salt
	["{item:8150} (Alliance)"] = "{item:8150}（聯盟）",
	-- {npc:92} Rock Elemental
	["{npc:92} (level 39-40) drop it here. The Auction House works too."] = "這裡的{npc:92}（39-40級）會掉落。拍賣場也買得到。",

	-- Step 36: Deeprock Salt (Horde)
	-- {item:8150} Deeprock Salt
	["{item:8150} (Horde)"] = "{item:8150}（部落）",
	-- {npc:11746} Desert Rumbler
	["{npc:11746} (level 56-58) drop it here. The Auction House works too."] = "這裡的{npc:11746}（56-58級）會掉落。拍賣場也買得到。",

	-- Step 37: Thick Hide (Alliance)
	-- {item:8169} Thick Hide
	["{item:8169} (Alliance)"] = "{item:8169}（聯盟）",

	-- Step 38: Thick Hide (Horde)
	-- {item:8169} Thick Hide
	["{item:8169} (Horde)"] = "{item:8169}（部落）",

	-- Step 39: Leatherworking materials for 150-225
	-- {skill:165} Leatherworking
	["{skill:165} materials for 150-225"] = "{skill:165}150-225所需材料",
	-- {skill:171} Alchemy · {spell:3188} Elixir of Ogre Strength
	["{skill:171}: {spell:3188} (or the Auction House)"] = "{skill:171}：{spell:3188}（或拍賣場）",
	-- {skill:171} Alchemy · {item:3389} Elixir of Defense
	["{skill:171}: {item:3389} (or the Auction House)"] = "{skill:171}：{item:3389}（或拍賣場）",
	-- {skill:333} Enchanting
	["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}：分解優秀（綠色）裝備（或拍賣場）",

	-- Step 40: Mystic Heavy Armor Kit to 170
	-- {item:252452} Mystic Heavy Armor Kit
	["{item:252452} to 170"] = "{item:252452}練到170",
	["Orange (a point every craft) until 155, yellow until 165, green until 175."] = "橙色（每次製造必得1點）到155，黃色到165，綠色到175。",
	["from the recipe in your bags"] = "使用背包裡的配方",

	-- Step 41: Leatherworking recipes at 170
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 170"] = "{skill:165}170點的配方",
	-- {skill:165} Leatherworking · {spell:7151} Barbaric Shoulders
	["Back to a {skill:165} trainer: {spell:7151} is taught from {skill:165} 170."] = "回到{skill:165}訓練師那裡：{spell:7151}在{skill:165}170點時可學。",

	-- Step 42: Barbaric Shoulders to 175
	-- {item:5964} Barbaric Shoulders
	["{item:5964} to 175"] = "{item:5964}練到175",
	["Yellow until 180, green until 190: not every craft gives a point."] = "黃色到180，綠色到190：不是每次製造都會得到點數。",

	-- Step 43: Leatherworking recipes at 175
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 175"] = "{skill:165}175點的配方",
	-- {skill:165} Leatherworking · {spell:3776} Green Leather Bracers
	["Back to a {skill:165} trainer: {spell:3776} is taught from {skill:165} 175."] = "回到{skill:165}訓練師那裡：{spell:3776}在{skill:165}175點時可學。",

	-- Step 44: Green Leather Bracers to 185
	-- {spell:3776} Green Leather Bracers
	["{spell:3776} to 185"] = "{spell:3776}練到185",
	["Yellow until 185, green until 195: not every craft gives a point."] = "黃色到185，綠色到195：不是每次製造都會得到點數。",

	-- Step 45: Leatherworking recipes at 185
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 185"] = "{skill:165}185點的配方",
	-- {skill:165} Leatherworking · {spell:7156} Guardian Gloves
	["Back to a {skill:165} trainer: {spell:7156} is taught from {skill:165} 185."] = "回到{skill:165}訓練師那裡：{spell:7156}在{skill:165}185點時可學。",

	-- Step 46: Guardian Gloves to 195
	-- {item:5966} Guardian Gloves
	["{item:5966} to 195"] = "{item:5966}練到195",
	["Yellow until 195, green until 205: not every craft gives a point."] = "黃色到195，綠色到205：不是每次製造都會得到點數。",

	-- Step 47: Leatherworking recipes at 195
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 195"] = "{skill:165}195點的配方",
	-- {skill:165} Leatherworking · {spell:10487} Thick Armor Kit
	["Back to a {skill:165} trainer: {spell:10487} is taught from {skill:165} 195."] = "回到{skill:165}訓練師那裡：{spell:10487}在{skill:165}195點時可學。",

	-- Step 48: Forceful Thick Armor Kit to 220
	-- {item:252463} Forceful Thick Armor Kit
	["{item:252463} to 220"] = "{item:252463}練到220",
	["Orange (a point every craft) until 205, yellow until 215, green until 225."] = "橙色（每次製造必得1點）到205，黃色到215，綠色到225。",

	-- Step 49: Leatherworking recipes at 220
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 220"] = "{skill:165}220點的配方",
	-- {skill:165} Leatherworking · {spell:10482} Cured Thick Hide · {spell:14932} Thick Leather Ammo Pouch
	["Back to a {skill:165} trainer: {spell:10482}, {spell:14932} are taught from {skill:165} 220."] = "回到{skill:165}訓練師那裡：{spell:10482}、{spell:14932}在{skill:165}220點時可學。",

	-- Step 50: Thick Leather Ammo Pouch to 225
	-- {item:8218} Thick Leather Ammo Pouch
	["{item:8218} to 225"] = "{item:8218}練到225",
	-- {skill:165} Leatherworking
	["Yellow until 230, green until 240: not every craft gives a point. {skill:165} 225 is a Legacy System milestone."] = "黃色到230，綠色到240：不是每次製造都會得到點數。{skill:165}225是傳承系統的里程碑。",

	-- Step 51: Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Artisan {skill:165}"] = "專家級{skill:165}",
	-- {skill:165} Leatherworking
	["Artisan needs character level 35 and {skill:165} 200; it raises the cap to 300. Materials for 225-300 are worth about 312g in all."] = "專家級需要角色等級35且{skill:165}200點；上限提高到300。225-300所需材料總價約312金。",

	-- Step 52: Pattern: Wicked Leather Gauntlets
	-- {item:15083} Wicked Leather Gauntlets · {skill:165} Leatherworking
	["Teaches {item:15083} (needs {skill:165} 235). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "學會{item:15083}（需要{skill:165}235點）。商人限量出售，會補貨；拍賣場也常有。",

	-- Step 53: Pattern: Runic Leather Headband
	-- {item:15094} Runic Leather Headband · {skill:165} Leatherworking
	["Teaches {item:15094} (needs {skill:165} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "學會{item:15094}（需要{skill:165}265點）。商人限量出售，會補貨；拍賣場也常有。",

	-- Step 54: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170}（聯盟）",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:1815}、{npc:1816}、{npc:1817}的皮（48-60級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 55: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170}（部落）",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝取{npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378}、{npc:6377}的皮（48-60級的野獸會產出）；{skill:393}指南有安排路線。拍賣場也買得到。",

	-- Step 56: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047}（聯盟）",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "這裡的{npc:7027}（56-57級）會掉落。拍賣場也買得到。",

	-- Step 57: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047}（部落）",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "這裡的{npc:6189}（51-52級）會掉落。拍賣場也買得到。",

	-- Step 58: Rugged Armor Kit to 236
	-- {item:15564} Rugged Armor Kit
	["{item:15564} to 236"] = "{item:15564}練到236",
	["Yellow until 235, green until 245: not every craft gives a point."] = "黃色到235，綠色到245：不是每次製造都會得到點數。",

	-- Step 59: Wicked Leather Gauntlets to 267
	-- {item:15083} Wicked Leather Gauntlets
	["{item:15083} to 267"] = "{item:15083}練到267",
	["Orange (a point every craft) until 255, yellow until 265, green until 275."] = "橙色（每次製造必得1點）到255，黃色到265，綠色到275。",

	-- Step 60: Runic Leather Headband to 300
	-- {item:15094} Runic Leather Headband
	["{item:15094} to 300"] = "{item:15094}練到300",
	-- {skill:165} Leatherworking
	["Orange (a point every craft) until 285, yellow until 295, green until 305. {skill:165} 300 is a Legacy System milestone."] = "橙色（每次製造必得1點）到285，黃色到295，綠色到305。{skill:165}300是傳承系統的里程碑。",
}
