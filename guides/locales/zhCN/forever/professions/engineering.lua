-- Chinese (simplified) (zhCN): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Engineering
	-- {skill:202} Engineering
	["Apprentice {skill:202}"] = "初级{skill:202}",
	-- {skill:202} Engineering
	["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202}可以边升级边练。Forever 的传承系统会在制造专业技能达到 150、225 和 300（中级、高级和专家级的上限）时给予奖励，所以每个节点都很重要。1-75 的材料总价约 62 银币。",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}：工具，放在背包里",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在 Polestar 按你的等级和阵营选出的刷材料地点击杀掉落它的怪物。也可以去拍卖行购买。",

	-- Step 3: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835}（联盟）",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}来自{object:1731}（{skill:186}）；这里是数据中最密集的矿点。也可以去拍卖行购买。",

	-- Step 4: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835}（部落）",

	-- Step 5: Engineering materials for 1-75
	-- {skill:202} Engineering
	["{skill:202} materials for 1-75"] = "{skill:202} 1-75 所需材料",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剥皮、分解或其他专业制造所得：自己收集，或在拍卖行购买。",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}：熔炼{item:2770}（或去拍卖行购买）",

	-- Step 6: Rough Blasting Powder to 37
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 37"] = "将{spell:3918}做到 37",
	["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "20 前为橙色（每次制造都加点），30 前为黄色，40 前为绿色。",

	-- Step 7: Crafted Light Shot to 45
	-- {spell:3920} Crafted Light Shot
	["{spell:3920} to 45"] = "将{spell:3920}做到 45",
	["Yellow until 45, green until 60: not every craft gives a point."] = "45 前为黄色，60 前为绿色：不是每次制造都加点。",

	-- Step 8: Engineering recipes at 45
	-- {skill:202} Engineering
	["{skill:202} recipes at 45"] = "{skill:202} 45 级配方",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts
	["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "回到{skill:202}训练师处：{spell:3922}在{skill:202} 45 时可学。",

	-- Step 9: Handful of Copper Bolts to 60
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 60"] = "将{spell:3922}做到 60",
	["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "52 前为黄色，60 前为绿色：不是每次制造都加点。需要在铁砧附近。",

	-- Step 10: Engineering recipes at 60
	-- {skill:202} Engineering
	["{skill:202} recipes at 60"] = "{skill:202} 60 级配方",
	-- {skill:202} Engineering · {spell:3923} Rough Copper Bomb
	["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "回到{skill:202}训练师处：{spell:3923}在{skill:202} 60 时可学。",

	-- Step 11: Rough Copper Bomb to 75
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 75"] = "将{spell:3923}做到 75",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "75 前为黄色，90 前为绿色：不是每次制造都加点。需要在铁砧附近。75 是初级上限。",

	-- Step 12: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "中级{skill:202}",
	-- {skill:202} Engineering
	["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "中级需要角色等级 10 且{skill:202}达到 50；会将上限提高到 150。75-150 的材料总价约 3 金币 23 银币。",

	-- Step 14: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592}（联盟）",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "这里的{npc:98}（等级 17-18）会掉落它。也可以去拍卖行购买。",

	-- Step 15: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592}（部落）",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "这里的{npc:3263}（等级 19-20）会掉落它。也可以去拍卖行购买。",

	-- Step 18: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836}（联盟）",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}来自{object:1732}（{skill:186}）；这里是数据中最密集的矿点。也可以去拍卖行购买。",

	-- Step 19: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836}（部落）",

	-- Step 20: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838}（联盟）",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}来自{object:1735}（{skill:186}）；这里是数据中最密集的矿点。也可以去拍卖行购买。",

	-- Step 21: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838}（部落）",

	-- Step 22: Engineering materials for 75-150
	-- {skill:202} Engineering
	["{skill:202} materials for 75-150"] = "{skill:202} 75-150 所需材料",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}：熔炼{item:2840}（或去拍卖行购买）",

	-- Step 23: Rough Copper Bomb to 80
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 80"] = "将{spell:3923}做到 80",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "75 前为黄色，90 前为绿色：不是每次制造都加点。需要在铁砧附近。",

	-- Step 24: Engineering recipes at 80
	-- {skill:202} Engineering
	["{skill:202} recipes at 80"] = "{skill:202} 80 级配方",
	-- {skill:202} Engineering · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "回到{skill:202}训练师处：{spell:3924}在{skill:202} 80 时可学。",

	-- Step 25: Copper Tube to 85
	-- {spell:3924} Copper Tube
	["{spell:3924} to 85"] = "将{spell:3924}做到 85",
	["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "95 前为黄色，110 前为绿色：不是每次制造都加点。需要在铁砧附近。",

	-- Step 26: Engineering recipes at 85
	-- {skill:202} Engineering
	["{skill:202} recipes at 85"] = "{skill:202} 85 级配方",
	-- {skill:202} Engineering · {spell:3929} Coarse Blasting Powder
	["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "回到{skill:202}训练师处：{spell:3929}在{skill:202} 85 时可学。",

	-- Step 27: Coarse Blasting Powder to 95
	-- {spell:3929} Coarse Blasting Powder
	["{spell:3929} to 95"] = "将{spell:3929}做到 95",
	["Yellow until 90, green until 95: not every craft gives a point."] = "90 前为黄色，95 前为绿色：不是每次制造都加点。",

	-- Step 28: Engineering recipes at 95
	-- {skill:202} Engineering
	["{skill:202} recipes at 95"] = "{skill:202} 95 级配方",
	-- {skill:202} Engineering · {spell:3926} Copper Modulator
	["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "回到{skill:202}训练师处：{spell:3926}在{skill:202} 95 时可学。",

	-- Step 29: Copper Modulator to 111
	-- {spell:3926} Copper Modulator
	["{spell:3926} to 111"] = "将{spell:3926}做到 111",
	["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "110 前为黄色，125 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	["a tool: keep it in your bags"] = "工具：放在背包里",

	-- Step 30: Engineering recipes at 111
	-- {skill:202} Engineering
	["{skill:202} recipes at 111"] = "{skill:202} 111 级配方",
	-- {skill:202} Engineering · {spell:3937} Large Copper Bomb
	["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "回到{skill:202}训练师处：{spell:3937}在{skill:202} 105 时可学。",

	-- Step 31: Large Copper Bomb to 125
	-- {spell:3937} Large Copper Bomb
	["{spell:3937} to 125"] = "将{spell:3937}做到 125",
	["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "130 前为黄色，155 前为绿色：不是每次制造都加点。需要在铁砧附近。",

	-- Step 32: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "{skill:202} 125 级配方",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "回到{skill:202}训练师处：{spell:3945}在{skill:202} 125 时可学。",

	-- Step 33: Heavy Blasting Powder to 139
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 139"] = "将{spell:3945}做到 139",
	["Yellow until 135, green until 145: not every craft gives a point."] = "135 前为黄色，145 前为绿色：不是每次制造都加点。",

	-- Step 34: Engineering recipes at 139
	-- {skill:202} Engineering
	["{skill:202} recipes at 139"] = "{skill:202} 139 级配方",
	-- {skill:202} Engineering · {spell:3942} Whirring Bronze Gizmo
	["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "回到{skill:202}训练师处：{spell:3942}在{skill:202} 125 时可学。",

	-- Step 35: Whirring Bronze Gizmo to 150
	-- {spell:3942} Whirring Bronze Gizmo
	["{spell:3942} to 150"] = "将{spell:3942}做到 150",
	-- {skill:202} Engineering
	["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "150 前为黄色，175 前为绿色：不是每次制造都加点。需要在铁砧附近。{skill:202} 150 是传承系统的里程碑。",

	-- Step 36: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "高级{skill:202}",
	-- {skill:202} Engineering
	["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "高级需要角色等级 20 且{skill:202}达到 125；会将上限提高到 225。150-225 的材料总价约 15 金币。",

	-- Step 37: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319}（联盟）",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里对{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、钳嘴龟、{npc:2384}、{npc:2354}剥皮（18-30 级的野兽会产出它）；{skill:393}指南有相应路线。也可以去拍卖行购买。",

	-- Step 38: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里对{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}剥皮（18-30 级的野兽会产出它）；{skill:393}指南有相应路线。也可以去拍卖行购买。",

	-- Step 40: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912}（联盟）",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}来自{object:2040}（{skill:186}）；这里是数据中最密集的矿点。也可以去拍卖行购买。",

	-- Step 41: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912}（部落）",

	-- Step 42: Engineering materials for 150-225
	-- {skill:202} Engineering
	["{skill:202} materials for 150-225"] = "{skill:202} 150-225 所需材料",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}：熔炼{item:3575}（或去拍卖行购买）",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}：熔炼{item:3858}（或去拍卖行购买）",

	-- Step 43: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "将{spell:3953}做到 175",
	["Yellow until 170, green until 195: not every craft gives a point."] = "170 前为黄色，195 前为绿色：不是每次制造都加点。",

	-- Step 44: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "{skill:202} 175 级配方",
	-- {skill:202} Engineering · {spell:12590} Gyromatic Micro-Adjustor
	["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "回到{skill:202}训练师处：{spell:12590}在{skill:202} 175 时可学。",

	-- Step 45: Gyromatic Micro-Adjustor to 210
	-- {item:10498} Gyromatic Micro-Adjustor
	["{item:10498} to 210"] = "将{item:10498}做到 210",
	["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "195 前为黄色，215 前为绿色：不是每次制造都加点。需要在铁砧附近。",

	-- Step 46: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "{skill:202} 210 级配方",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "回到{skill:202}训练师处：{spell:12585}、{spell:12596}在{skill:202} 210 时可学。",

	-- Step 47: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "将{item:10512}做到 225",
	-- {skill:202} Engineering
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "230 前为黄色，250 前为绿色：不是每次制造都加点。需要在铁砧附近。{skill:202} 225 是传承系统的里程碑。",

	-- Step 48: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "专家级{skill:202}",
	-- {skill:202} Engineering
	["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "专家级需要角色等级 35 且{skill:202}达到 200；会将上限提高到 300。225-300 的材料总价约 67 金币。",

	-- Step 49: Schematic: Thorium Widget
	-- {item:15994} Thorium Widget · {skill:202} Engineering
	["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "学会{item:15994}（需要{skill:202} 260）。商人限量出售并会补货；拍卖行也常有。",

	-- Step 50: Schematic: Thorium Tube
	-- {item:16000} Thorium Tube · {skill:202} Engineering
	["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "学会{item:16000}（需要{skill:202} 275）。商人限量出售并会补货；拍卖行也常有。",

	-- Step 53: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047}（联盟）",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "这里的{npc:7027}（等级 56-57）会掉落它。也可以去拍卖行购买。",

	-- Step 54: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047}（部落）",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "这里的{npc:6189}（等级 51-52）会掉落它。也可以去拍卖行购买。",

	-- Step 55: Engineering materials for 225-300
	-- {skill:202} Engineering
	["{skill:202} materials for 225-300"] = "{skill:202} 225-300 所需材料",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}：熔炼{item:10620}（或去拍卖行购买）",

	-- Step 56: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "将{item:10512}做到 245",
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "230 前为黄色，250 前为绿色：不是每次制造都加点。需要在铁砧附近。",

	-- Step 57: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "{skill:202} 245 级配方",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "回到{skill:202}训练师处：{spell:12621}在{skill:202} 245 时可学。",

	-- Step 58: Mithril Gyro-Shot to 264
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 264"] = "将{item:10513}做到 264",
	["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "265 前为黄色，285 前为绿色：不是每次制造都加点。需要在铁砧附近。",

	-- Step 59: Thorium Widget to 288
	-- {item:15994} Thorium Widget
	["{item:15994} to 288"] = "将{item:15994}做到 288",
	["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "280 前为橙色（每次制造都加点），290 前为黄色，300 前为绿色。需要在铁砧附近。",
	["from the recipe in your bags"] = "使用背包里的配方",

	-- Step 60: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "将{item:16000}做到 300",
	-- {skill:202} Engineering
	["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "295 前为橙色（每次制造都加点），305 前为黄色，315 前为绿色。需要在铁砧附近。{skill:202} 300 是传承系统的里程碑。",
}
