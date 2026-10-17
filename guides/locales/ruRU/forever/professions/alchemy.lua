-- Russian (ruRU): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Alchemy
	-- {skill:171} Alchemy
	["Apprentice {skill:171}"] = "{skill:171}: Ученик",
	-- {skill:171} Alchemy
	["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171} качается параллельно с уровнем. Система наследия Forever награждает за профессии производства на навыке 150, 225 и 300 (пределы рангов «Подмастерье», «Умелец» и «Искусник»), так что важен каждый рубеж. Материалы на 1-75 стоят всего около 68с.",

	-- Step 2: Silverleaf (Alliance)
	-- {item:765} Silverleaf
	["{item:765} (Alliance)"] = "{item:765} (Альянс)",
	-- {item:765} Silverleaf · {skill:182} Herbalism
	["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:765}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 3: Silverleaf (Horde)
	-- {item:765} Silverleaf
	["{item:765} (Horde)"] = "{item:765} (Орда)",

	-- Step 4: Peacebloom (Alliance)
	-- {item:2447} Peacebloom
	["{item:2447} (Alliance)"] = "{item:2447} (Альянс)",
	-- {item:2447} Peacebloom · {skill:182} Herbalism
	["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:2447}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 5: Peacebloom (Horde)
	-- {item:2447} Peacebloom
	["{item:2447} (Horde)"] = "{item:2447} (Орда)",

	-- Step 6: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997} до 75",
	["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "Оранжевый (очко за каждое изготовление) до 55, желтый до 75, зеленый до 95. 75 – предел ранга «Ученик».",

	-- Step 7: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "{skill:171}: Подмастерье",
	-- {skill:171} Alchemy
	["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "Ранг «Подмастерье» требует уровня персонажа 10 и навыка {skill:171} 50; предел становится 150. Материалы на 75-150 стоят всего около 1з 44с.",

	-- Step 8: Recipe: Holy Protection Potion
	-- {item:6051} Holy Protection Potion · {skill:171} Alchemy
	["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Обучает: {item:6051} (нужно {skill:171} 100). У торговцев – ограниченный запас, который пополняется; часто бывает и на аукционе.",

	-- Step 9: Murloc Eye (Alliance)
	-- {item:730} Murloc Eye
	["{item:730} (Alliance)"] = "{item:730} (Альянс)",
	-- {npc:513} Murloc Netter
	["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "Добыча здесь: {npc:513} (уровень 14-15). Подойдет и аукцион.",

	-- Step 10: Murloc Eye (Horde)
	-- {item:730} Murloc Eye
	["{item:730} (Horde)"] = "{item:730} (Орда)",
	-- {npc:1958} Vile Fin Tidecaller
	["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "Добыча здесь: {npc:1958} (уровень 17-18). Подойдет и аукцион.",

	-- Step 11: Mageroyal (Alliance)
	-- {item:785} Mageroyal
	["{item:785} (Alliance)"] = "{item:785} (Альянс)",
	-- {item:785} Mageroyal · {skill:182} Herbalism
	["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:785}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 12: Mageroyal (Horde)
	-- {item:785} Mageroyal
	["{item:785} (Horde)"] = "{item:785} (Орда)",

	-- Step 15: Briarthorn (Alliance)
	-- {item:2450} Briarthorn
	["{item:2450} (Alliance)"] = "{item:2450} (Альянс)",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:2450}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 16: Briarthorn (Horde)
	-- {item:2450} Briarthorn
	["{item:2450} (Horde)"] = "{item:2450} (Орда)",

	-- Step 17: Swiftthistle (Alliance)
	-- {item:2452} Swiftthistle
	["{item:2452} (Alliance)"] = "{item:2452} (Альянс)",
	-- {item:2452} Swiftthistle · {item:2450} Briarthorn · {skill:182} Herbalism
	["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452} добывается из: {item:2450} ({skill:182}) – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 18: Swiftthistle (Horde)
	-- {item:2452} Swiftthistle
	["{item:2452} (Horde)"] = "{item:2452} (Орда)",

	-- Step 19: Bruiseweed (Alliance)
	-- {item:2453} Bruiseweed
	["{item:2453} (Alliance)"] = "{item:2453} (Альянс)",
	-- {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:2453}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 20: Bruiseweed (Horde)
	-- {item:2453} Bruiseweed
	["{item:2453} (Horde)"] = "{item:2453} (Орда)",

	-- Step 21: Minor Mana Potion to 85
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 85"] = "{spell:2331} до 85",
	["Yellow until 85, green until 105: not every craft gives a point."] = "Желтый до 85, зеленый до 105: не каждое изготовление дает очко.",

	-- Step 22: Alchemy recipes at 85
	-- {skill:171} Alchemy
	["{skill:171} recipes at 85"] = "{skill:171}: рецепты на 85",
	-- {skill:171} Alchemy · {spell:1244645} Lesser Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "Вернитесь к учителю ({skill:171}): {spell:1244645} – с навыка {skill:171} 85.",

	-- Step 23: Lesser Discolored Healing Potion to 100
	-- {item:247239} Lesser Discolored Healing Potion
	["{item:247239} to 100"] = "{item:247239} до 100",
	["Yellow until 105, green until 125: not every craft gives a point."] = "Желтый до 105, зеленый до 125: не каждое изготовление дает очко.",

	-- Step 24: Holy Protection Potion to 150
	-- {item:6051} Holy Protection Potion
	["{item:6051} to 150"] = "{item:6051} до 150",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 130, желтый до 150, зеленый до 170. {skill:171} 150 – рубеж Системы наследия.",
	["from the recipe in your bags"] = "по рецепту из сумки",

	-- Step 25: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "{skill:171}: Умелец",
	-- {skill:171} Alchemy
	["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "Ранг «Умелец» требует уровня персонажа 20 и навыка {skill:171} 125; предел становится 225. Материалы на 150-225 стоят всего около 3з 65с.",

	-- Step 26: Murloc Eye
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Убивайте существ, с которых он падает, в месте, выбранном Polestar для вашего уровня и фракции. Подойдет и аукцион.",

	-- Step 27: Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Alliance)"] = "{object:1623} (Альянс)",
	-- {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{object:1623}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 28: Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Horde)"] = "{object:1623} (Орда)",

	-- Step 29: Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["{item:3356} (Alliance)"] = "{item:3356} (Альянс)",
	-- {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:3356}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 30: Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["{item:3356} (Horde)"] = "{item:3356} (Орда)",

	-- Step 31: Liferoot (Alliance)
	-- {item:3357} Liferoot
	["{item:3357} (Alliance)"] = "{item:3357} (Альянс)",
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:3357}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 32: Liferoot (Horde)
	-- {item:3357} Liferoot
	["{item:3357} (Horde)"] = "{item:3357} (Орда)",

	-- Step 33: Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["{object:2046} (Alliance)"] = "{object:2046} (Альянс)",
	-- {object:2046} Goldthorn · {skill:182} Herbalism
	["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{object:2046}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 34: Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["{object:2046} (Horde)"] = "{object:2046} (Орда)",

	-- Step 35: Oily Blackmouth (Alliance)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Alliance)"] = "{item:6358} (Альянс)",
	-- {object:180582} Oily Blackmouth School
	["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "Ловите рыбу: {object:180582} – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 36: Oily Blackmouth (Horde)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Horde)"] = "{item:6358} (Орда)",

	-- Step 37: Firefin Snapper (Alliance)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Alliance)"] = "{item:6359} (Альянс)",
	-- {object:180657} Firefin Snapper School
	["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "Ловите рыбу: {object:180657} – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 38: Firefin Snapper (Horde)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Horde)"] = "{item:6359} (Орда)",

	-- Step 39: Fire Oil to 165
	-- {item:6371} Fire Oil
	["{item:6371} to 165"] = "{item:6371} до 165",
	["Yellow until 160, green until 170: not every craft gives a point."] = "Желтый до 160, зеленый до 170: не каждое изготовление дает очко.",

	-- Step 40: Alchemy recipes at 165
	-- {skill:171} Alchemy
	["{skill:171} recipes at 165"] = "{skill:171}: рецепты на 165",
	-- {skill:171} Alchemy · {spell:7845} Elixir of Fire Power
	["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "Вернитесь к учителю ({skill:171}): {spell:7845} – с навыка {skill:171} 165.",

	-- Step 41: Elixir of Fire Power to 175
	-- {spell:7845} Elixir of Fire Power
	["{spell:7845} to 175"] = "{spell:7845} до 175",
	["Yellow until 185, green until 205: not every craft gives a point."] = "Желтый до 185, зеленый до 205: не каждое изготовление дает очко.",

	-- Step 42: Alchemy recipes at 175
	-- {skill:171} Alchemy
	["{skill:171} recipes at 175"] = "{skill:171}: рецепты на 175",
	-- {skill:171} Alchemy · {spell:1244647} Greater Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "Вернитесь к учителю ({skill:171}): {spell:1244647} – с навыка {skill:171} 175.",

	-- Step 43: Greater Discolored Healing Potion to 200
	-- {item:247241} Greater Discolored Healing Potion
	["{item:247241} to 200"] = "{item:247241} до 200",
	["Yellow until 195, green until 215: not every craft gives a point."] = "Желтый до 195, зеленый до 215: не каждое изготовление дает очко.",

	-- Step 44: Alchemy recipes at 200
	-- {skill:171} Alchemy
	["{skill:171} recipes at 200"] = "{skill:171}: рецепты на 200",
	-- {skill:171} Alchemy · {spell:11447} Draught of Water Walking
	["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "Вернитесь к учителю ({skill:171}): {spell:11447} – с навыка {skill:171} 190.",

	-- Step 45: Draught of Water Walking to 215
	-- {spell:11447} Draught of Water Walking
	["{spell:11447} to 215"] = "{spell:11447} до 215",
	["Yellow until 210, green until 230: not every craft gives a point."] = "Желтый до 210, зеленый до 230: не каждое изготовление дает очко.",

	-- Step 46: Alchemy recipes at 215
	-- {skill:171} Alchemy
	["{skill:171} recipes at 215"] = "{skill:171}: рецепты на 215",
	-- {skill:171} Alchemy · {spell:11450} Elixir of Defense
	["Back to an {skill:171} trainer: {spell:11450} is taught from {skill:171} 215."] = "Вернитесь к учителю ({skill:171}): {spell:11450} – с навыка {skill:171} 215.",

	-- Step 47: Elixir of Defense to 225
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 225"] = "{spell:11450} до 225",
	-- {skill:171} Alchemy
	["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "Желтый до 235, зеленый до 255: не каждое изготовление дает очко. {skill:171} 225 – рубеж Системы наследия.",

	-- Step 48: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "{skill:171}: Искусник",
	-- {skill:171} Alchemy
	["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "Ранг «Искусник» требует уровня персонажа 35 и навыка {skill:171} 200; предел становится 300. Материалы на 225-300 стоят всего около 7з 80с.",

	-- Step 49: Recipe: Elixir of Superior Defense
	-- {item:8951} Elixir of Greater Defense · {skill:171} Alchemy
	["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Обучает: {item:8951} (нужно {skill:171} 265). У торговцев – ограниченный запас, который пополняется; часто бывает и на аукционе.",

	-- Step 55: Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Alliance)"] = "{item:8836} (Альянс)",
	-- {item:8836} Arthas' Tears · {skill:182} Herbalism
	["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:8836}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 56: Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Horde)"] = "{item:8836} (Орда)",

	-- Step 57: Sungrass (Alliance)
	-- {item:8838} Sungrass
	["{item:8838} (Alliance)"] = "{item:8838} (Альянс)",
	-- {item:8838} Sungrass · {skill:182} Herbalism
	["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:8838}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",

	-- Step 58: Sungrass (Horde)
	-- {item:8838} Sungrass
	["{item:8838} (Horde)"] = "{item:8838} (Орда)",

	-- Step 59: Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Alliance)"] = "{item:13422} (Альянс)",
	-- {object:180712} Stonescale Eel Swarm
	["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "Ловите рыбу: {object:180712} – по данным, здесь их больше всего. Подойдет и аукцион.",

	-- Step 60: Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Horde)"] = "{item:13422} (Орда)",

	-- Step 61: Elixir of Defense to 230
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 230"] = "{spell:11450} до 230",
	["Yellow until 235, green until 255: not every craft gives a point."] = "Желтый до 235, зеленый до 255: не каждое изготовление дает очко.",

	-- Step 62: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "{skill:171}: рецепты на 230",
	-- {skill:171} Alchemy · {spell:1244648} Superior Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "Вернитесь к учителю ({skill:171}): {spell:1244648} – с навыка {skill:171} 230.",

	-- Step 63: Superior Discolored Healing Potion to 250
	-- {item:247242} Superior Discolored Healing Potion
	["{item:247242} to 250"] = "{item:247242} до 250",
	["Yellow until 250, green until 270: not every craft gives a point."] = "Желтый до 250, зеленый до 270: не каждое изготовление дает очко.",

	-- Step 64: Alchemy recipes at 250
	-- {skill:171} Alchemy
	["{skill:171} recipes at 250"] = "{skill:171}: рецепты на 250",
	-- {skill:171} Alchemy · {spell:17551} Stonescale Oil
	["Back to an {skill:171} trainer: {spell:17551} is taught from {skill:171} 250."] = "Вернитесь к учителю ({skill:171}): {spell:17551} – с навыка {skill:171} 250.",

	-- Step 65: Stonescale Oil to 259
	-- {item:13423} Stonescale Oil
	["{item:13423} to 259"] = "{item:13423} до 259",
	["Yellow until 255, green until 260: not every craft gives a point."] = "Желтый до 255, зеленый до 260: не каждое изготовление дает очко.",

	-- Step 66: Alchemy recipes at 259
	-- {skill:171} Alchemy
	["{skill:171} recipes at 259"] = "{skill:171}: рецепты на 259",
	-- {skill:171} Alchemy · {spell:11460} Draught of Detect Undead
	["Back to an {skill:171} trainer: {spell:11460} is taught from {skill:171} 245."] = "Вернитесь к учителю ({skill:171}): {spell:11460} – с навыка {skill:171} 245.",

	-- Step 67: Draught of Detect Undead to 265
	-- {spell:11460} Draught of Detect Undead
	["{spell:11460} to 265"] = "{spell:11460} до 265",
	["Yellow until 265, green until 285: not every craft gives a point."] = "Желтый до 265, зеленый до 285: не каждое изготовление дает очко.",

	-- Step 68: Elixir of Greater Defense to 300
	-- {spell:17554} Elixir of Greater Defense
	["{spell:17554} to 300"] = "{spell:17554} до 300",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 280, желтый до 300, зеленый до 320. {skill:171} 300 – рубеж Системы наследия.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:3355}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:3821}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["{item:3355} (Alliance)"] = "{item:3355} (Альянс)",
	-- ["{item:3355} (Horde)"] = "{item:3355} (Орда)",
	-- ["{item:3821} (Alliance)"] = "{item:3821} (Альянс)",
	-- ["{item:3821} (Horde)"] = "{item:3821} (Орда)",
}
