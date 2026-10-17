-- Russian (ruRU): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Blacksmithing
	-- {skill:164} Blacksmithing
	["Apprentice {skill:164}"] = "{skill:164}: Ученик",
	-- {skill:164} Blacksmithing
	["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} качается параллельно с уровнем. Система наследия Forever награждает за профессии производства на навыке 150, 225 и 300 (пределы рангов «Подмастерье», «Умелец» и «Искусник»), так что важен каждый рубеж. Материалы на 1-75 стоят всего около 17с.",

	-- Step 2: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Альянс)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} добывается из: {object:1731} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 3: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Орда)",

	-- Step 4: Rough Sharpening Stone to 45
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 45"] = "{spell:2660} до 45",
	["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Оранжевый (очко за каждое изготовление) до 15, желтый до 35, зеленый до 55.",

	-- Step 5: Blacksmithing recipes at 45
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 45"] = "{skill:164}: рецепты на 45",
	-- {skill:164} Blacksmithing · {spell:3320} Rough Grinding Stone
	["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "Вернитесь к учителю ({skill:164}): {spell:3320} – с навыка {skill:164} 45.",

	-- Step 6: Rough Grinding Stone to 75
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 75"] = "{spell:3320} до 75",
	["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Желтый до 65, зеленый до 85: не каждое изготовление дает очко. 75 – предел ранга «Ученик».",

	-- Step 7: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "{skill:164}: Подмастерье",
	-- {skill:164} Blacksmithing
	["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Ранг «Подмастерье» требует уровня персонажа 10 и навыка {skill:164} 50; предел становится 150. Материалы на 75-150 стоят всего около 9з 41с.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: инструмент, держите его в сумке",

	-- Step 10: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Альянс)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} добывается из: {object:1732} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 11: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Орда)",

	-- Step 12: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Альянс)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} добывается из: {object:1735} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 13: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Орда)",

	-- Step 14: Blacksmithing materials for 75-150
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 75-150"] = "{skill:164}: материалы для 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Снимается со шкур, получается распылением или другой профессией: добудьте сами или купите на аукционе.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: выплавка – {item:2770} (или аукцион)",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: выплавка – {item:2840} (или аукцион)",

	-- Step 15: Rough Grinding Stone to 83
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 83"] = "{spell:3320} до 83",
	["Yellow until 65, green until 85: not every craft gives a point."] = "Желтый до 65, зеленый до 85: не каждое изготовление дает очко.",

	-- Step 16: Blacksmithing recipes at 83
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 83"] = "{skill:164}: рецепты на 83",
	-- {skill:164} Blacksmithing · {spell:2666} Runed Copper Belt
	["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Вернитесь к учителю ({skill:164}): {spell:2666} – с навыка {skill:164} 80.",

	-- Step 17: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666} до 100",
	["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 85, желтый до 105, зеленый до 125. Нужна наковальня рядом.",

	-- Step 18: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "{skill:164}: рецепты на 100",
	-- {skill:164} Blacksmithing · {spell:3117} Heavy Weightstone
	["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Вернитесь к учителю ({skill:164}): {spell:3117} – с навыка {skill:164} 100.",

	-- Step 19: Heavy Weightstone to 112
	-- {spell:3117} Heavy Weightstone
	["{spell:3117} to 112"] = "{spell:3117} до 112",
	["Yellow until 107, green until 115: not every craft gives a point."] = "Желтый до 107, зеленый до 115: не каждое изготовление дает очко.",

	-- Step 20: Blacksmithing recipes at 112
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 112"] = "{skill:164}: рецепты на 112",
	-- {skill:164} Blacksmithing · {spell:2668} Rough Bronze Leggings
	["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Вернитесь к учителю ({skill:164}): {spell:2668} – с навыка {skill:164} 95.",

	-- Step 21: Rough Bronze Leggings to 121
	-- {spell:2668} Rough Bronze Leggings
	["{spell:2668} to 121"] = "{spell:2668} до 121",
	["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 120, желтый до 135, зеленый до 150. Нужна наковальня рядом.",

	-- Step 22: Blacksmithing recipes at 121
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 121"] = "{skill:164}: рецепты на 121",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers
	["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "Вернитесь к учителю ({skill:164}): {spell:2672} – с навыка {skill:164} 120.",

	-- Step 23: Patterned Bronze Bracers to 150
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 150"] = "{spell:2672} до 150",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 125, желтый до 140, зеленый до 155. Нужна наковальня рядом. {skill:164} 150 – рубеж Системы наследия.",

	-- Step 24: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "{skill:164}: Умелец",
	-- {skill:164} Blacksmithing
	["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Ранг «Умелец» требует уровня персонажа 20 и навыка {skill:164} 125; предел становится 225. Материалы на 150-225 стоят всего около 42з.",

	-- Step 25: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Альянс)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Хрустогрыз, {npc:2384}, {npc:2354} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 26: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Орда)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 31: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Альянс)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} добывается из: {object:2040} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 32: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Орда)",

	-- Step 33: Blacksmithing materials for 150-225
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 150-225"] = "{skill:164}: материалы для 150-225",
	-- {skill:186} Mining · {item:2775} Silver Ore
	["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: выплавка – {item:2775} (или аукцион)",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: выплавка – {item:3575} (или аукцион)",

	-- Step 34: Silvered Bronze Gauntlets to 155
	-- {spell:3333} Silvered Bronze Gauntlets
	["{spell:3333} to 155"] = "{spell:3333} до 155",
	["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 155, зеленый до 170: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 35: Blacksmithing recipes at 155
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 155"] = "{skill:164}: рецепты на 155",
	-- {skill:164} Blacksmithing · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Вернитесь к учителю ({skill:164}): {spell:9985} – с навыка {skill:164} 155.",

	-- Step 36: Bronze Warhammer to 175
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 175"] = "{item:7956} до 175",
	["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 170, зеленый до 185: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 37: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "{skill:164}: рецепты на 175",
	-- {skill:164} Blacksmithing · {spell:9918} Solid Sharpening Stone
	["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "Вернитесь к учителю ({skill:164}): {spell:9918} – с навыка {skill:164} 175.",

	-- Step 38: Solid Sharpening Stone to 185
	-- {item:7964} Solid Sharpening Stone
	["{item:7964} to 185"] = "{item:7964} до 185",
	["Yellow until 180, green until 185: not every craft gives a point."] = "Желтый до 180, зеленый до 185: не каждое изготовление дает очко.",

	-- Step 39: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "{skill:164}: рецепты на 185",
	-- {skill:164} Blacksmithing · {spell:7223} Golden Scale Bracers
	["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "Вернитесь к учителю ({skill:164}): {spell:7223} – с навыка {skill:164} 185.",

	-- Step 40: Golden Scale Bracers to 200
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 200"] = "{item:6040} до 200",
	["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 197, зеленый до 210: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 41: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "{skill:164}: рецепты на 200",
	-- {skill:164} Blacksmithing · {spell:9916} Steel Breastplate
	["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Вернитесь к учителю ({skill:164}): {spell:9916} – с навыка {skill:164} 200.",

	-- Step 42: Steel Breastplate to 210
	-- {item:7963} Steel Breastplate
	["{item:7963} to 210"] = "{item:7963} до 210",
	["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 212, зеленый до 225: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 43: Blacksmithing recipes at 210
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 210"] = "{skill:164}: рецепты на 210",
	-- {skill:164} Blacksmithing · {spell:9920} Solid Grinding Stone · {spell:9935} Steel Plate Helm
	["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Вернитесь к учителю ({skill:164}): {spell:9920}, {spell:9935} – с навыка {skill:164} 210.",

	-- Step 44: Steel Plate Helm to 225
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 225"] = "{item:7922} до 225",
	-- {skill:164} Blacksmithing
	["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Желтый до 220, зеленый до 230: не каждое изготовление дает очко. Нужна наковальня рядом. {skill:164} 225 – рубеж Системы наследия.",

	-- Step 45: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "{skill:164}: Искусник",
	-- {skill:164} Blacksmithing
	["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Ранг «Искусник» требует уровня персонажа 35 и навыка {skill:164} 200; предел становится 300. Материалы на 225-300 стоят всего около 942з.",

	-- Step 46: Plans: Sentinel's Sabatons
	-- {item:250562} Sentinel's Sabatons · {skill:164} Blacksmithing
	["Teaches {item:250562} (needs {skill:164} 240)."] = "Обучает: {item:250562} (нужно {skill:164} 240).",

	-- Step 47: Plans: Huge Thorium Battleaxe
	-- {item:12775} Huge Thorium Battleaxe · {skill:164} Blacksmithing
	["Teaches {item:12775} (needs {skill:164} 255)."] = "Обучает: {item:12775} (нужно {skill:164} 255).",

	-- Step 48: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (Альянс)",
	-- {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {skill:393} Skinning
	["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} (звери уровня 38-50); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 49: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (Орда)",
	-- {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti · {skill:393} Skinning
	["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} (звери уровня 38-50); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 50: Mageweave Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Убивайте существ, с которых он падает, в месте, выбранном Polestar для вашего уровня и фракции. Подойдет и аукцион.",

	-- Step 53: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Альянс)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:1815}, {npc:1816}, {npc:1817} (звери уровня 48-60); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 54: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Орда)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (звери уровня 48-60); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 55: Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	["{item:8831} (Alliance)"] = "{item:8831} (Альянс)",
	-- {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:8831}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 56: Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	["{item:8831} (Horde)"] = "{item:8831} (Орда)",

	-- Step 57: Dense Stone (Alliance)
	-- {item:12365} Dense Stone
	["{item:12365} (Alliance)"] = "{item:12365} (Альянс)",
	-- {item:12365} Dense Stone · {object:324} Small Thorium Vein · {skill:186} Mining
	["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} добывается из: {object:324} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 58: Dense Stone (Horde)
	-- {item:12365} Dense Stone
	["{item:12365} (Horde)"] = "{item:12365} (Орда)",

	-- Step 59: Blacksmithing materials for 225-300
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 225-300"] = "{skill:164}: материалы для 225-300",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: выплавка – {item:3858} (или аукцион)",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: выплавка – {item:10620} (или аукцион)",
	-- {skill:171} Alchemy · {item:249410} Sulfuric Acid
	["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (или аукцион)",
	-- {skill:393} Skinning
	["{skill:393} (or the Auction House)"] = "{skill:393} (или аукцион)",
	-- {skill:202} Engineering · {item:249432} Sandpaper
	["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (или аукцион)",

	-- Step 60: Mithril Coif to 230
	-- {item:7931} Mithril Coif
	["{item:7931} to 230"] = "{item:7931} до 230",
	["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 235, зеленый до 245: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 61: Blacksmithing recipes at 230
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 230"] = "{skill:164}: рецепты на 230",
	-- {skill:164} Blacksmithing · {spell:16640} Dense Weightstone
	["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:16640} – с навыка {skill:164} 230.",

	-- Step 62: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "{item:12643} до 235",
	["Yellow until 232, green until 235: not every craft gives a point."] = "Желтый до 232, зеленый до 235: не каждое изготовление дает очко.",

	-- Step 63: Blacksmithing recipes at 235
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 235"] = "{skill:164}: рецепты на 235",
	-- {skill:164} Blacksmithing · {spell:9968} Heavy Mithril Boots
	["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:9968} – с навыка {skill:164} 230.",

	-- Step 64: Heavy Mithril Boots to 244
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 244"] = "{item:7933} до 244",
	["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 240, зеленый до 250: не каждое изготовление дает очко. Нужна наковальня рядом.",

	-- Step 65: Sentinel's Sabatons to 268
	-- {item:250562} Sentinel's Sabatons
	["{item:250562} to 268"] = "{item:250562} до 268",
	["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 260, желтый до 270, зеленый до 280. Нужна наковальня рядом.",
	["from the recipe in your bags"] = "по рецепту из сумки",

	-- Step 66: Blacksmithing recipes at 268
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 268"] = "{skill:164}: рецепты на 268",
	-- {skill:164} Blacksmithing · {spell:16639} Dense Grinding Stone
	["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:16639} – с навыка {skill:164} 230.",

	-- Step 67: Huge Thorium Battleaxe to 300
	-- {item:12775} Huge Thorium Battleaxe
	["{item:12775} to 300"] = "{item:12775} до 300",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 280, желтый до 292, зеленый до 305. Нужна наковальня рядом. {skill:164} 300 – рубеж Системы наследия.",
}
