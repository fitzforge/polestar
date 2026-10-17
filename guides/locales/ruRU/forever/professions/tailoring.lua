-- Russian (ruRU): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Tailoring
	-- {skill:197} Tailoring
	["Apprentice {skill:197}"] = "{skill:197}: Ученик",
	-- {skill:197} Tailoring
	["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197} качается параллельно с уровнем. Система наследия Forever награждает за профессии производства на навыке 150, 225 и 300 (пределы рангов «Подмастерье», «Умелец» и «Искусник»), так что важен каждый рубеж. Материалы на 1-75 стоят всего около 1з 8с.",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Убивайте существ, с которых он падает, в месте, выбранном Polestar для вашего уровня и фракции. Подойдет и аукцион.",

	-- Step 3: Simple Linen Pants to 50
	-- {item:10045} Simple Linen Pants
	["{item:10045} to 50"] = "{item:10045} до 50",
	["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "Оранжевый (очко за каждое изготовление) до 40, желтый до 50, зеленый до 60.",

	-- Step 4: Tailoring recipes at 50
	-- {skill:197} Tailoring
	["{skill:197} recipes at 50"] = "{skill:197}: рецепты на 50",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "Вернитесь к учителю ({skill:197}): {spell:8776} – с навыка {skill:197} 50.",

	-- Step 5: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026} до 75",
	["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Желтый до 67, зеленый до 85: не каждое изготовление дает очко. 75 – предел ранга «Ученик».",

	-- Step 6: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "{skill:197}: Подмастерье",
	-- {skill:197} Tailoring
	["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "Ранг «Подмастерье» требует уровня персонажа 10 и навыка {skill:197} 50; предел становится 150. Материалы на 75-150 стоят всего около 17з.",

	-- Step 8: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Альянс)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Добыча здесь: {npc:98} (уровень 17-18). Подойдет и аукцион.",

	-- Step 9: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Орда)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Добыча здесь: {npc:3263} (уровень 19-20). Подойдет и аукцион.",

	-- Step 10: Tailoring materials for 75-150
	-- {skill:197} Tailoring
	["{skill:197} materials for 75-150"] = "{skill:197}: материалы для 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Снимается со шкур, получается распылением или другой профессией: добудьте сами или купите на аукционе.",
	-- {skill:171} Alchemy · {item:3383} Elixir of Wisdom
	["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}: {item:3383} (или аукцион)",

	-- Step 11: Linen Belt to 80
	-- {item:7026} Linen Belt
	["{item:7026} to 80"] = "{item:7026} до 80",
	["Yellow until 67, green until 85: not every craft gives a point."] = "Желтый до 67, зеленый до 85: не каждое изготовление дает очко.",

	-- Step 12: Tailoring recipes at 80
	-- {skill:197} Tailoring
	["{skill:197} recipes at 80"] = "{skill:197}: рецепты на 80",
	-- {skill:197} Tailoring · {spell:2402} Woolen Cape
	["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "Вернитесь к учителю ({skill:197}): {spell:2402} – с навыка {skill:197} 80.",

	-- Step 13: Woolen Cape to 110
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 110"] = "{spell:2402} до 110",
	["Yellow until 97, green until 115: not every craft gives a point."] = "Желтый до 97, зеленый до 115: не каждое изготовление дает очко.",

	-- Step 14: Tailoring recipes at 110
	-- {skill:197} Tailoring
	["{skill:197} recipes at 110"] = "{skill:197}: рецепты на 110",
	-- {skill:197} Tailoring · {spell:3848} Double-stitched Woolen Shoulders
	["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "Вернитесь к учителю ({skill:197}): {spell:3848} – с навыка {skill:197} 110.",

	-- Step 15: Double-stitched Woolen Shoulders to 125
	-- {spell:3848} Double-stitched Woolen Shoulders
	["{spell:3848} to 125"] = "{spell:3848} до 125",
	["Yellow until 127, green until 145: not every craft gives a point."] = "Желтый до 127, зеленый до 145: не каждое изготовление дает очко.",

	-- Step 16: Tailoring recipes at 125
	-- {skill:197} Tailoring
	["{skill:197} recipes at 125"] = "{skill:197}: рецепты на 125",
	-- {skill:197} Tailoring · {spell:3852} Gloves of Meditation
	["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "Вернитесь к учителю ({skill:197}): {spell:3852} – с навыка {skill:197} 125.",

	-- Step 17: Gloves of Meditation to 150
	-- {spell:3852} Gloves of Meditation
	["{spell:3852} to 150"] = "{spell:3852} до 150",
	-- {skill:197} Tailoring
	["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "Желтый до 140, зеленый до 155: не каждое изготовление дает очко. {skill:197} 150 – рубеж Системы наследия.",

	-- Step 18: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "{skill:197}: Умелец",
	-- {skill:197} Tailoring
	["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "Ранг «Умелец» требует уровня персонажа 20 и навыка {skill:197} 125; предел становится 225. Материалы на 150-225 стоят всего около 135з.",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7053} Azure Silk Cloak · {skill:197} Tailoring
	["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Обучает: {item:7053} (нужно {skill:197} 140). У торговцев – ограниченный запас, который пополняется; часто бывает и на аукционе.",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338} (Альянс)",
	-- {npc:6006} Shadowsworn Adept
	["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "Добыча здесь: {npc:6006} (уровень 52-53). Подойдет и аукцион.",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338} (Орда)",
	-- {npc:5472} Dunemaul Enforcer
	["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "Добыча здесь: {npc:5472} (уровень 46-47). Подойдет и аукцион.",

	-- Step 23: Azure Silk Cloak to 180
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 180"] = "{item:7053} до 180",
	["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "Оранжевый (очко за каждое изготовление) до 160, желтый до 175, зеленый до 190.",
	["from the recipe in your bags"] = "по рецепту из сумки",

	-- Step 24: Tailoring recipes at 180
	-- {skill:197} Tailoring
	["{skill:197} recipes at 180"] = "{skill:197}: рецепты на 180",
	-- {skill:197} Tailoring · {spell:8799} Crimson Silk Pantaloons
	["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "Вернитесь к учителю ({skill:197}): {spell:8799} – с навыка {skill:197} 180.",

	-- Step 25: Crimson Silk Pantaloons to 185
	-- {item:7062} Crimson Silk Pantaloons
	["{item:7062} to 185"] = "{item:7062} до 185",
	["Yellow until 190, green until 200: not every craft gives a point."] = "Желтый до 190, зеленый до 200: не каждое изготовление дает очко.",

	-- Step 26: Tailoring recipes at 185
	-- {skill:197} Tailoring
	["{skill:197} recipes at 185"] = "{skill:197}: рецепты на 185",
	-- {skill:197} Tailoring · {spell:12048} Black Mageweave Vest
	["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "Вернитесь к учителю ({skill:197}): {spell:12048} – с навыка {skill:197} 185.",

	-- Step 27: Black Mageweave Vest to 205
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 205"] = "{item:9998} до 205",
	["Yellow until 200, green until 215: not every craft gives a point."] = "Желтый до 200, зеленый до 215: не каждое изготовление дает очко.",

	-- Step 28: Tailoring recipes at 205
	-- {skill:197} Tailoring
	["{skill:197} recipes at 205"] = "{skill:197}: рецепты на 205",
	-- {skill:197} Tailoring · {spell:12072} Black Mageweave Headband
	["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "Вернитесь к учителю ({skill:197}): {spell:12072} – с навыка {skill:197} 205.",

	-- Step 29: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024} до 225",
	-- {skill:197} Tailoring
	["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "Желтый до 220, зеленый до 235: не каждое изготовление дает очко. {skill:197} 225 – рубеж Системы наследия.",

	-- Step 30: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "{skill:197}: Искусник",
	-- {skill:197} Tailoring
	["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "Ранг «Искусник» требует уровня персонажа 35 и навыка {skill:197} 200; предел становится 300. Материалы на 225-300 стоят всего около 845з.",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:13863} Runecloth Gloves · {skill:197} Tailoring
	["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Обучает: {item:13863} (нужно {skill:197} 230). У торговцев – ограниченный запас, который пополняется; часто бывает и на аукционе.",

	-- Step 32: Pattern: Runecloth Cuffs
	-- {item:254123} Runecloth Cuffs · {skill:197} Tailoring
	["Teaches {item:254123} (needs {skill:197} 250)."] = "Обучает: {item:254123} (нужно {skill:197} 250).",

	-- Step 33: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Альянс)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:1815}, {npc:1816}, {npc:1817} (звери уровня 48-60); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 34: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Орда)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (звери уровня 48-60); маршрут – в гайде {skill:393}. Подойдет и аукцион.",

	-- Step 35: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Альянс)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Добыча здесь: {npc:7027} (уровень 56-57). Подойдет и аукцион.",

	-- Step 36: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Орда)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Добыча здесь: {npc:6189} (уровень 51-52). Подойдет и аукцион.",

	-- Step 37: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (Альянс)",
	-- {npc:1824} Plague Lurker
	["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "Добыча здесь: {npc:1824} (уровень 54-55). Подойдет и аукцион.",

	-- Step 38: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (Орда)",
	-- {npc:11739} Rock Stalker
	["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "Добыча здесь: {npc:11739} (уровень 57-59). Подойдет и аукцион.",

	-- Step 39: Runecloth Belt to 236
	-- {item:13856} Runecloth Belt
	["{item:13856} to 236"] = "{item:13856} до 236",
	["Yellow until 240, green until 255: not every craft gives a point."] = "Желтый до 240, зеленый до 255: не каждое изготовление дает очко.",

	-- Step 40: Runecloth Gloves to 251
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 251"] = "{item:13863} до 251",
	["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "Оранжевый (очко за каждое изготовление) до 245, желтый до 260, зеленый до 275.",

	-- Step 41: Runecloth Cuffs to 295
	-- {item:254123} Runecloth Cuffs
	["{item:254123} to 295"] = "{item:254123} до 295",
	["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "Оранжевый (очко за каждое изготовление) до 265, желтый до 280, зеленый до 295.",

	-- Step 42: Tailoring 295-300
	-- {skill:197} Tailoring · {item:14342} Mooncloth · {item:14137} Mooncloth Leggings · {item:279943} Spinning Wheel · {item:14155} Mooncloth Bag · {item:14128} Wizardweave Robe · {item:19047} Wisdom of the Timbermaw
	["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "В Forever ни один рецепт от учителя или от торговцев обеих фракций не дает очков навыка {skill:197} после 295, поэтому у Polestar нет маршрута для последних очков. Рецепты, которые еще дают: {item:14342} (нужен лунный колодец), {item:14137} (нужно: {item:279943}), {item:14155} (рецепт – добыча), {item:14128} (рецепт – добыча), {item:19047} (нужно: {item:279943}).",
}
