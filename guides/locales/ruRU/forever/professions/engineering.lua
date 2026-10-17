-- Russian (ruRU): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Engineering
	-- {skill:202} Engineering
	["Apprentice {skill:202}"] = "{skill:202}: Ученик",
	-- {skill:202} Engineering
	["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202} качается параллельно с уровнем. Система наследия Forever награждает за профессии производства на навыке 150, 225 и 300 (пределы рангов «Подмастерье», «Умелец» и «Искусник»), так что важен каждый рубеж. Материалы на 1-75 стоят всего около 62с.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: инструмент, держите его в сумке",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Убивайте существ, с которых он падает, в месте, выбранном Polestar для вашего уровня и фракции. Подойдет и аукцион.",

	-- Step 3: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Альянс)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} добывается из: {object:1731} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 4: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Орда)",

	-- Step 5: Engineering materials for 1-75
	-- {skill:202} Engineering
	["{skill:202} materials for 1-75"] = "{skill:202}: материалы для 1-75",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Снимается со шкур, получается распылением или другой профессией: добудьте сами или купите на аукционе.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: выплавка – {item:2770} (или аукцион)",

	-- Step 6: Rough Blasting Powder to 37
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 37"] = "{spell:3918} до 37",
	["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "Оранжевый (очко за каждое изготовление) до 20, желтый до 30, зеленый до 40.",

	-- Step 7: Crafted Light Shot to 45
	-- {spell:3920} Crafted Light Shot
	["{spell:3920} to 45"] = "{spell:3920} до 45",
	["Yellow until 45, green until 60: not every craft gives a point."] = "Желтый до 45, зеленый до 60: не каждое изготовление дает очко.",

	-- Step 8: Engineering recipes at 45
	-- {skill:202} Engineering
	["{skill:202} recipes at 45"] = "{skill:202}: рецепты на 45",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts
	["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "Вернитесь к учителю ({skill:202}): {spell:3922} – с навыка {skill:202} 45.",

	-- Step 9: Handful of Copper Bolts to 60
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 60"] = "{spell:3922} до 60",
	["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 52, зеленый до 60: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 10: Engineering recipes at 60
	-- {skill:202} Engineering
	["{skill:202} recipes at 60"] = "{skill:202}: рецепты на 60",
	-- {skill:202} Engineering · {spell:3923} Rough Copper Bomb
	["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "Вернитесь к учителю ({skill:202}): {spell:3923} – с навыка {skill:202} 60.",

	-- Step 11: Rough Copper Bomb to 75
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 75"] = "{spell:3923} до 75",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "Желтый до 75, зеленый до 90: не каждое изготовление дает очко. Нужна наковальня рядом. 75 – предел ранга «Ученик».",

	-- Step 12: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "{skill:202}: Подмастерье",
	-- {skill:202} Engineering
	["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "Ранг «Подмастерье» требует уровня персонажа 10 и навыка {skill:202} 50; предел становится 150. Материалы на 75-150 стоят всего около 3з 23с.",

	-- Step 14: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Альянс)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Добыча здесь: {npc:98} (уровень 17-18). Подойдет и аукцион.",

	-- Step 15: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Орда)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Добыча здесь: {npc:3263} (уровень 19-20). Подойдет и аукцион.",

	-- Step 18: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Альянс)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} добывается из: {object:1732} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 19: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Орда)",

	-- Step 20: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Альянс)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} добывается из: {object:1735} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 21: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Орда)",

	-- Step 22: Engineering materials for 75-150
	-- {skill:202} Engineering
	["{skill:202} materials for 75-150"] = "{skill:202}: материалы для 75-150",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: выплавка – {item:2840} (или аукцион)",

	-- Step 23: Rough Copper Bomb to 80
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 80"] = "{spell:3923} до 80",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 75, зеленый до 90: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 24: Engineering recipes at 80
	-- {skill:202} Engineering
	["{skill:202} recipes at 80"] = "{skill:202}: рецепты на 80",
	-- {skill:202} Engineering · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "Вернитесь к учителю ({skill:202}): {spell:3924} – с навыка {skill:202} 80.",

	-- Step 25: Copper Tube to 85
	-- {spell:3924} Copper Tube
	["{spell:3924} to 85"] = "{spell:3924} до 85",
	["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 95, зеленый до 110: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 26: Engineering recipes at 85
	-- {skill:202} Engineering
	["{skill:202} recipes at 85"] = "{skill:202}: рецепты на 85",
	-- {skill:202} Engineering · {spell:3929} Coarse Blasting Powder
	["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "Вернитесь к учителю ({skill:202}): {spell:3929} – с навыка {skill:202} 85.",

	-- Step 27: Coarse Blasting Powder to 95
	-- {spell:3929} Coarse Blasting Powder
	["{spell:3929} to 95"] = "{spell:3929} до 95",
	["Yellow until 90, green until 95: not every craft gives a point."] = "Желтый до 90, зеленый до 95: не каждое изготовление дает очко.",

	-- Step 28: Engineering recipes at 95
	-- {skill:202} Engineering
	["{skill:202} recipes at 95"] = "{skill:202}: рецепты на 95",
	-- {skill:202} Engineering · {spell:3926} Copper Modulator
	["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "Вернитесь к учителю ({skill:202}): {spell:3926} – с навыка {skill:202} 95.",

	-- Step 29: Copper Modulator to 111
	-- {spell:3926} Copper Modulator
	["{spell:3926} to 111"] = "{spell:3926} до 111",
	["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 110, зеленый до 125: не каждое изготовление дает очко. Нужна наковальня рядом.",
	["a tool: keep it in your bags"] = "инструмент: держите его в сумке",

	-- Step 30: Engineering recipes at 111
	-- {skill:202} Engineering
	["{skill:202} recipes at 111"] = "{skill:202}: рецепты на 111",
	-- {skill:202} Engineering · {spell:3937} Large Copper Bomb
	["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "Вернитесь к учителю ({skill:202}): {spell:3937} – с навыка {skill:202} 105.",

	-- Step 31: Large Copper Bomb to 125
	-- {spell:3937} Large Copper Bomb
	["{spell:3937} to 125"] = "{spell:3937} до 125",
	["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 130, зеленый до 155: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 32: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "{skill:202}: рецепты на 125",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "Вернитесь к учителю ({skill:202}): {spell:3945} – с навыка {skill:202} 125.",

	-- Step 33: Heavy Blasting Powder to 139
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 139"] = "{spell:3945} до 139",
	["Yellow until 135, green until 145: not every craft gives a point."] = "Желтый до 135, зеленый до 145: не каждое изготовление дает очко.",

	-- Step 34: Engineering recipes at 139
	-- {skill:202} Engineering
	["{skill:202} recipes at 139"] = "{skill:202}: рецепты на 139",
	-- {skill:202} Engineering · {spell:3942} Whirring Bronze Gizmo
	["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "Вернитесь к учителю ({skill:202}): {spell:3942} – с навыка {skill:202} 125.",

	-- Step 35: Whirring Bronze Gizmo to 150
	-- {spell:3942} Whirring Bronze Gizmo
	["{spell:3942} to 150"] = "{spell:3942} до 150",
	-- {skill:202} Engineering
	["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "Желтый до 150, зеленый до 175: не каждое изготовление дает очко. Нужна наковальня рядом. {skill:202} 150 – рубеж Системы наследия.",

	-- Step 36: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "{skill:202}: Умелец",
	-- {skill:202} Engineering
	["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "Ранг «Умелец» требует уровня персонажа 20 и навыка {skill:202} 125; предел становится 225. Материалы на 150-225 стоят всего около 15з.",

	-- Step 37: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Альянс)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Хрустогрыз, {npc:2384}, {npc:2354} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 38: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Орда)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 40: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Альянс)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} добывается из: {object:2040} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 41: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Орда)",

	-- Step 42: Engineering materials for 150-225
	-- {skill:202} Engineering
	["{skill:202} materials for 150-225"] = "{skill:202}: материалы для 150-225",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: выплавка – {item:3575} (или аукцион)",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: выплавка – {item:3858} (или аукцион)",

	-- Step 43: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953} до 175",
	["Yellow until 170, green until 195: not every craft gives a point."] = "Желтый до 170, зеленый до 195: не каждое изготовление дает очко.",

	-- Step 44: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "{skill:202}: рецепты на 175",
	-- {skill:202} Engineering · {spell:12590} Gyromatic Micro-Adjustor
	["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "Вернитесь к учителю ({skill:202}): {spell:12590} – с навыка {skill:202} 175.",

	-- Step 45: Gyromatic Micro-Adjustor to 210
	-- {item:10498} Gyromatic Micro-Adjustor
	["{item:10498} to 210"] = "{item:10498} до 210",
	["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 195, зеленый до 215: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 46: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "{skill:202}: рецепты на 210",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "Вернитесь к учителю ({skill:202}): {spell:12585}, {spell:12596} – с навыка {skill:202} 210.",

	-- Step 47: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512} до 225",
	-- {skill:202} Engineering
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "Желтый до 230, зеленый до 250: не каждое изготовление дает очко. Нужна наковальня рядом. {skill:202} 225 – рубеж Системы наследия.",

	-- Step 48: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "{skill:202}: Искусник",
	-- {skill:202} Engineering
	["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "Ранг «Искусник» требует уровня персонажа 35 и навыка {skill:202} 200; предел становится 300. Материалы на 225-300 стоят всего около 67з.",

	-- Step 49: Schematic: Thorium Widget
	-- {item:15994} Thorium Widget · {skill:202} Engineering
	["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Обучает: {item:15994} (нужно {skill:202} 260). У торговцев – ограниченный запас, который пополняется; часто бывает и на аукционе.",

	-- Step 50: Schematic: Thorium Tube
	-- {item:16000} Thorium Tube · {skill:202} Engineering
	["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "Обучает: {item:16000} (нужно {skill:202} 275). У торговцев – ограниченный запас, который пополняется.",

	-- Step 53: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Альянс)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Добыча здесь: {npc:7027} (уровень 56-57). Подойдет и аукцион.",

	-- Step 54: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Орда)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Добыча здесь: {npc:6189} (уровень 51-52). Подойдет и аукцион.",

	-- Step 55: Engineering materials for 225-300
	-- {skill:202} Engineering
	["{skill:202} materials for 225-300"] = "{skill:202}: материалы для 225-300",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: выплавка – {item:10620} (или аукцион)",

	-- Step 56: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512} до 245",
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 230, зеленый до 250: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 57: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "{skill:202}: рецепты на 245",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "Вернитесь к учителю ({skill:202}): {spell:12621} – с навыка {skill:202} 245.",

	-- Step 58: Mithril Gyro-Shot to 264
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 264"] = "{item:10513} до 264",
	["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 265, зеленый до 285: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 59: Thorium Widget to 288
	-- {item:15994} Thorium Widget
	["{item:15994} to 288"] = "{item:15994} до 288",
	["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 280, желтый до 290, зеленый до 300. Нужна наковальня рядом.",
	["from the recipe in your bags"] = "по рецепту из сумки",

	-- Step 60: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000} до 300",
	-- {skill:202} Engineering
	["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 295, желтый до 305, зеленый до 315. Нужна наковальня рядом. {skill:202} 300 – рубеж Системы наследия.",
}
