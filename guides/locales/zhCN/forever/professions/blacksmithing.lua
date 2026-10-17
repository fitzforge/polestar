-- Chinese (simplified) (zhCN): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Blacksmithing
	-- {skill:164} Blacksmithing
	["Apprentice {skill:164}"] = "初级{skill:164}",
	-- {skill:164} Blacksmithing
	["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164}与升级同步进行。Forever的传承系统会在专业技能达到150、225和300（中级、高级和专家级上限）时奖励制造专业，所以每个节点都很重要。1-75的材料总价约17银。",

	-- Step 2: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835}（联盟）",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}来自{object:1731}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",

	-- Step 3: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835}（部落）",

	-- Step 4: Rough Sharpening Stone to 45
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 45"] = "{spell:2660}练到45",
	["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "橙色（每次制作必得一点）到15，黄色到35，绿色到55。",

	-- Step 5: Blacksmithing recipes at 45
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 45"] = "45点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:3320} Rough Grinding Stone
	["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "回到{skill:164}训练师处：{spell:3320}在{skill:164}达到45时可学。",

	-- Step 6: Rough Grinding Stone to 75
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 75"] = "{spell:3320}练到75",
	["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "黄色到65，绿色到85：并非每次制作都会加点。75是初级上限。",

	-- Step 7: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "中级{skill:164}",
	-- {skill:164} Blacksmithing
	["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "中级需要角色等级10和{skill:164} 50，可将上限提高到150。75-150的材料总价约9金41银。",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}：工具，放在背包里",

	-- Step 10: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836}（联盟）",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}来自{object:1732}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",

	-- Step 11: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836}（部落）",

	-- Step 12: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838}（联盟）",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}来自{object:1735}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",

	-- Step 13: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838}（部落）",

	-- Step 14: Blacksmithing materials for 75-150
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 75-150"] = "{skill:164} 75-150所需材料",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剥皮、分解或由其他专业制作：自己收集，或在拍卖行购买。",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}：熔炼{item:2770}（或去拍卖行）",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}：熔炼{item:2840}（或去拍卖行）",

	-- Step 15: Rough Grinding Stone to 83
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 83"] = "{spell:3320}练到83",
	["Yellow until 65, green until 85: not every craft gives a point."] = "黄色到65，绿色到85：并非每次制作都会加点。",

	-- Step 16: Blacksmithing recipes at 83
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 83"] = "83点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:2666} Runed Copper Belt
	["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "回到{skill:164}训练师处：{spell:2666}在{skill:164}达到80时可学。",

	-- Step 17: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666}练到100",
	["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "橙色（每次制作必得一点）到85，黄色到105，绿色到125。需要附近有铁砧。",

	-- Step 18: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "100点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:3117} Heavy Weightstone
	["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "回到{skill:164}训练师处：{spell:3117}在{skill:164}达到100时可学。",

	-- Step 19: Heavy Weightstone to 112
	-- {spell:3117} Heavy Weightstone
	["{spell:3117} to 112"] = "{spell:3117}练到112",
	["Yellow until 107, green until 115: not every craft gives a point."] = "黄色到107，绿色到115：并非每次制作都会加点。",

	-- Step 20: Blacksmithing recipes at 112
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 112"] = "112点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:2668} Rough Bronze Leggings
	["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "回到{skill:164}训练师处：{spell:2668}在{skill:164}达到95时可学。",

	-- Step 21: Rough Bronze Leggings to 121
	-- {spell:2668} Rough Bronze Leggings
	["{spell:2668} to 121"] = "{spell:2668}练到121",
	["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "橙色（每次制作必得一点）到120，黄色到135，绿色到150。需要附近有铁砧。",

	-- Step 22: Blacksmithing recipes at 121
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 121"] = "121点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers
	["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "回到{skill:164}训练师处：{spell:2672}在{skill:164}达到120时可学。",

	-- Step 23: Patterned Bronze Bracers to 150
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 150"] = "{spell:2672}练到150",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "橙色（每次制作必得一点）到125，黄色到140，绿色到155。需要附近有铁砧。{skill:164} 150是传承系统的里程碑。",

	-- Step 24: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "高级{skill:164}",
	-- {skill:164} Blacksmithing
	["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "高级需要角色等级20和{skill:164} 125，可将上限提高到225。150-225的材料总价约42金。",

	-- Step 25: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319}（联盟）",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、钳嘴龟、{npc:2384}、{npc:2354}（18-30级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",

	-- Step 26: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}（18-30级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",

	-- Step 31: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912}（联盟）",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}来自{object:2040}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",

	-- Step 32: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912}（部落）",

	-- Step 33: Blacksmithing materials for 150-225
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 150-225"] = "{skill:164} 150-225所需材料",
	-- {skill:186} Mining · {item:2775} Silver Ore
	["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}：熔炼{item:2775}（或去拍卖行）",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}：熔炼{item:3575}（或去拍卖行）",

	-- Step 34: Silvered Bronze Gauntlets to 155
	-- {spell:3333} Silvered Bronze Gauntlets
	["{spell:3333} to 155"] = "{spell:3333}练到155",
	["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "黄色到155，绿色到170：并非每次制作都会加点。需要附近有铁砧。",

	-- Step 35: Blacksmithing recipes at 155
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 155"] = "155点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "回到{skill:164}训练师处：{spell:9985}在{skill:164}达到155时可学。",

	-- Step 36: Bronze Warhammer to 175
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 175"] = "{item:7956}练到175",
	["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "黄色到170，绿色到185：并非每次制作都会加点。需要附近有铁砧。",

	-- Step 37: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "175点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:9918} Solid Sharpening Stone
	["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "回到{skill:164}训练师处：{spell:9918}在{skill:164}达到175时可学。",

	-- Step 38: Solid Sharpening Stone to 185
	-- {item:7964} Solid Sharpening Stone
	["{item:7964} to 185"] = "{item:7964}练到185",
	["Yellow until 180, green until 185: not every craft gives a point."] = "黄色到180，绿色到185：并非每次制作都会加点。",

	-- Step 39: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "185点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:7223} Golden Scale Bracers
	["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "回到{skill:164}训练师处：{spell:7223}在{skill:164}达到185时可学。",

	-- Step 40: Golden Scale Bracers to 200
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 200"] = "{item:6040}练到200",
	["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "黄色到197，绿色到210：并非每次制作都会加点。需要附近有铁砧。",

	-- Step 41: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "200点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:9916} Steel Breastplate
	["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "回到{skill:164}训练师处：{spell:9916}在{skill:164}达到200时可学。",

	-- Step 42: Steel Breastplate to 210
	-- {item:7963} Steel Breastplate
	["{item:7963} to 210"] = "{item:7963}练到210",
	["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "黄色到212，绿色到225：并非每次制作都会加点。需要附近有铁砧。",

	-- Step 43: Blacksmithing recipes at 210
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 210"] = "210点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:9920} Solid Grinding Stone · {spell:9935} Steel Plate Helm
	["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "回到{skill:164}训练师处：{spell:9920}、{spell:9935}在{skill:164}达到210时可学。",

	-- Step 44: Steel Plate Helm to 225
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 225"] = "{item:7922}练到225",
	-- {skill:164} Blacksmithing
	["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "黄色到220，绿色到230：并非每次制作都会加点。需要附近有铁砧。{skill:164} 225是传承系统的里程碑。",

	-- Step 45: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "专家级{skill:164}",
	-- {skill:164} Blacksmithing
	["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "专家级需要角色等级35和{skill:164} 200，可将上限提高到300。225-300的材料总价约942金。",

	-- Step 46: Plans: Sentinel's Sabatons
	-- {item:250562} Sentinel's Sabatons · {skill:164} Blacksmithing
	["Teaches {item:250562} (needs {skill:164} 240)."] = "教授{item:250562}（需要{skill:164} 240）。",

	-- Step 47: Plans: Huge Thorium Battleaxe
	-- {item:12775} Huge Thorium Battleaxe · {skill:164} Blacksmithing
	["Teaches {item:12775} (needs {skill:164} 255)."] = "教授{item:12775}（需要{skill:164} 255）。",

	-- Step 48: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304}（联盟）",
	-- {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {skill:393} Skinning
	["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:2729}、{npc:2730}、{npc:2732}、{npc:2734}（38-50级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",

	-- Step 49: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304}（部落）",
	-- {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti · {skill:393} Skinning
	["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:5292}、{npc:5300}、{npc:5304}、{npc:5272}、{npc:5260}、{npc:5262}、{npc:5268}、{npc:5274}、{npc:5287}、{npc:5286}、{npc:5296}（38-50级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",

	-- Step 50: Mageweave Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在Polestar根据你的等级和阵营选择的刷怪点击杀掉落它的怪物。拍卖行也能买到。",

	-- Step 53: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170}（联盟）",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:1815}、{npc:1816}、{npc:1817}（48-60级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",

	-- Step 54: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170}（部落）",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里剥皮{npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378}、{npc:6377}（48-60级的野兽会掉落）；{skill:393}指南会安排路线。拍卖行也能买到。",

	-- Step 55: Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	["{item:8831} (Alliance)"] = "{item:8831}（联盟）",
	-- {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:8831}；这里是数据中最密集的草点。拍卖行也能买到。",

	-- Step 56: Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	["{item:8831} (Horde)"] = "{item:8831}（部落）",

	-- Step 57: Dense Stone (Alliance)
	-- {item:12365} Dense Stone
	["{item:12365} (Alliance)"] = "{item:12365}（联盟）",
	-- {item:12365} Dense Stone · {object:324} Small Thorium Vein · {skill:186} Mining
	["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365}来自{object:324}（{skill:186}）；这里是数据中最密集的矿点。拍卖行也能买到。",

	-- Step 58: Dense Stone (Horde)
	-- {item:12365} Dense Stone
	["{item:12365} (Horde)"] = "{item:12365}（部落）",

	-- Step 59: Blacksmithing materials for 225-300
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 225-300"] = "{skill:164} 225-300所需材料",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}：熔炼{item:3858}（或去拍卖行）",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}：熔炼{item:10620}（或去拍卖行）",
	-- {skill:171} Alchemy · {item:249410} Sulfuric Acid
	["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}：{item:249410}（或去拍卖行）",
	-- {skill:393} Skinning
	["{skill:393} (or the Auction House)"] = "{skill:393}（或去拍卖行）",
	-- {skill:202} Engineering · {item:249432} Sandpaper
	["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}：{item:249432}（或去拍卖行）",

	-- Step 60: Mithril Coif to 230
	-- {item:7931} Mithril Coif
	["{item:7931} to 230"] = "{item:7931}练到230",
	["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "黄色到235，绿色到245：并非每次制作都会加点。需要附近有铁砧。",

	-- Step 61: Blacksmithing recipes at 230
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 230"] = "230点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:16640} Dense Weightstone
	["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "回到{skill:164}训练师处：{spell:16640}在{skill:164}达到230时可学。",

	-- Step 62: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "{item:12643}练到235",
	["Yellow until 232, green until 235: not every craft gives a point."] = "黄色到232，绿色到235：并非每次制作都会加点。",

	-- Step 63: Blacksmithing recipes at 235
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 235"] = "235点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:9968} Heavy Mithril Boots
	["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "回到{skill:164}训练师处：{spell:9968}在{skill:164}达到230时可学。",

	-- Step 64: Heavy Mithril Boots to 244
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 244"] = "{item:7933}练到244",
	["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "黄色到240，绿色到250：并非每次制作都会加点。需要附近有铁砧。",

	-- Step 65: Sentinel's Sabatons to 268
	-- {item:250562} Sentinel's Sabatons
	["{item:250562} to 268"] = "{item:250562}练到268",
	["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "橙色（每次制作必得一点）到260，黄色到270，绿色到280。需要附近有铁砧。",
	["from the recipe in your bags"] = "使用背包里的配方",

	-- Step 66: Blacksmithing recipes at 268
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 268"] = "268点的{skill:164}配方",
	-- {skill:164} Blacksmithing · {spell:16639} Dense Grinding Stone
	["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "回到{skill:164}训练师处：{spell:16639}在{skill:164}达到230时可学。",

	-- Step 67: Huge Thorium Battleaxe to 300
	-- {item:12775} Huge Thorium Battleaxe
	["{item:12775} to 300"] = "{item:12775}练到300",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "橙色（每次制作必得一点）到280，黄色到292，绿色到305。需要附近有铁砧。{skill:164} 300是传承系统的里程碑。",
}
