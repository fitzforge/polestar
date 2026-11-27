-- Russian (ruRU): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Blacksmithing
	-- {skill:164} Blacksmithing
	["Learn {skill:164}"] = "Изучите: {skill:164}",
	-- {skill:164} Blacksmithing · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore · {item:2836} Coarse Stone
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	-- was: ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "Подмастерье по {skill:164} позволяет создавать предметы до 75 навыка за 10c на любом уровне персонажа; обучит любой наставник {skill:164} вашей фракции, а стрелка укажет ближайшего. Купите {item:5956} у любого поставщика кузнечных припасов и начните с {skill:186}: {item:2835} и {item:2770} дают медные жилы каждой стартовой зоны. На 1-75 уйдёт примерно 1s рецептов, плюс 286 {item:2835}, которые нужно собрать или купить."
	["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 2s 50c of recipes, plus 111 {item:2835} and 114 {item:2836} to gather or buy."] = "",

	-- Step 2: Get Rough Stone
	-- {item:2835} Rough Stone
	["Get {item:2835}"] = "",
	-- {item:2835} Rough Stone · {skill:164} Blacksmithing · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh · {zone:1429} Elwynn Forest · {zone:2521} Zephras Isle
	-- plural, as words: Rough Sharpening Stones = {spell:2660} Rough Sharpening Stone
	["111 {item:2835} for {skill:164} 1-75: 111 Rough Sharpening Stones. {skill:186}: {object:1731} (skill 1) in {zone:1426} (1-10), {zone:1429} (1-10) and {zone:2521} (1-15). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 3: Get Coarse Stone
	-- {item:2836} Coarse Stone
	["Get {item:2836}"] = "",
	-- {item:2836} Coarse Stone · {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining · {object:1732} Tin Vein · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills · {zone:1437} Wetlands
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone
	["114 {item:2836} for {skill:164} 1-75: 46 Coarse Grinding Stones and 25 {spell:2672} (22 of them for 75-150: get them all now). {skill:186}: {object:1732} (skill 65) in {zone:1440} (18-30), {zone:1424} (20-30) and {zone:1437} (20-30). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 4: Rough Sharpening Stone to 50
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 50"] = "",
	-- {spell:2660} Rough Sharpening Stone · {item:2835} Rough Stone
	["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 94 crafts to 50, up to 111 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "",

	-- Step 5: Blacksmithing recipes at 50
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 50"] = "",
	-- {skill:164} Blacksmithing · {spell:3326} Coarse Grinding Stone · {spell:1230171} Sharpening Wheel · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Back to a {skill:164} trainer: {spell:3326} (from 50, 2s 50c). Also learn {spell:1230171} (1s): Forever's {skill:164} camp item, 1 {item:2835} and 1 {item:2840}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:164} quest from your starting area's camping guide (after The Great Outdoors) sends you to a blacksmithing trainer who teaches it free."] = "",

	-- Step 6: Coarse Grinding Stone to 75
	-- {spell:3326} Coarse Grinding Stone
	["{spell:3326} to 75"] = "",
	-- {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone
	["{spell:3326} is yellow at 50 (yellow 50, green 70, grey 90): about 39 crafts to 75, up to 46 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:2836}. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 7: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "{skill:164}: Подмастерье",
	-- {skill:164} Blacksmithing · {npc:3136} Clarise Gnarltree · {zone:1431} Duskwood · {npc:252479} Daeann Steelwind · {zone:2521} Zephras Isle · {npc:10276} Rotgath Stonebeard · {zone:1455} Ironforge · {npc:5511} Therum Deepforge · {zone:1453} Stormwind City · {npc:276067} Angus Hammerhand · {zone:1420} Tirisfal Glades · {npc:4596} James Van Brunt · {zone:1458} Undercity · {npc:2998} Karn Stonehoof · {zone:1456} Thunder Bluff · {npc:1383} Snarl · {zone:1454} Orgrimmar · {npc:3478} Traugh · {zone:1413} The Barrens · {spell:2666} Runed Copper Belt · {item:2319} Medium Leather · {item:2840} Copper Bar · {item:2841} Bronze Bar
	-- was: ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Ранг «Подмастерье» поднимает предел с 75 до 150 за 5с; нужен навык {skill:164} 50 и уровень персонажа 10, так что его можно взять при любом визите начиная с 50. Учат ему не все учителя ({skill:164}): Альянс – {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) и {npc:5511} ({zone:1453}); Орда – {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) и {npc:3478} ({zone:1413}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:2666} (с 45, 2с) и {spell:3326} (с 50, 2с 50м). На 75-150 уйдет около 19с 50м на рецепты и 18м на товары торговцев, плюс 256 {item:2836}, 28 {item:2838}, 210 {item:2840} и 320 {item:2841} – добудьте или купите."
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s). 75-150 takes about 9s 50c of recipes and 5g 18c of vendor goods, plus 25 {item:2319}, 320 {item:2840} and 325 {item:2841} to gather or buy."] = "",

	-- Step 8: Blacksmithing 75-150: vendor goods
	-- {skill:164} Blacksmithing
	["{skill:164} 75-150: vendor goods"] = "{skill:164} 75-150: товары торговцев",
	-- {item:3466} Strong Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:1286} Edna Mullby · {npc:5512} Kaita Deepforge · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {npc:3413} Sovik
	-- was: ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "Купите сразу все для этого этапа: {item:5956} (инструмент: один, держите в сумках, 18м); всего около 18м. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:5519}, {npc:1286} и {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} и {npc:3413})."
	["Buy the whole bracket's share in one go: 25 {item:3466} (5g) and {item:5956} (a tool: one, kept in your bags, 18c); about 5g 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "",
	["a tool, keep it in your bags"] = "инструмент, держите его в сумках",

	-- Step 9: Get Medium Leather
	-- {item:2319} Medium Leather
	["Get {item:2319}"] = "",
	-- {item:2319} Medium Leather · {skill:164} Blacksmithing · {skill:393} Skinning
	-- plural, as words: Bronze Warhammers = {item:7956} Bronze Warhammer
	["25 {item:2319} for {skill:164} 75-150: 25 Bronze Warhammers. {skill:393}: beasts of level 18-30. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 10: Get Copper Bar
	-- {item:2840} Copper Bar
	["Get {item:2840}"] = "",
	-- {item:2840} Copper Bar · {skill:164} Blacksmithing · {item:2770} Copper Ore · {skill:186} Mining
	-- plural, as words: Runed Copper Belts = {spell:2666} Runed Copper Belt
	["320 {item:2840} for {skill:164} 75-150: 32 Runed Copper Belts. Mine {item:2770} and smelt it at a forge ({skill:186} 1). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 11: Get Bronze Bar
	-- {item:2841} Bronze Bar
	["Get {item:2841}"] = "",
	-- {item:2841} Bronze Bar · {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	-- plural, as words: Bronze Warhammers = {item:7956} Bronze Warhammer
	["325 {item:2841} for {skill:164} 75-150: 25 {spell:2672} and 25 Bronze Warhammers. {skill:186}: smelt {item:2840} and {item:3576}. Or buy them at the Auction House."] = "",

	-- Step 12: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666} до 100",
	-- {spell:2666} Runed Copper Belt · {item:2840} Copper Bar · {item:2770} Copper Ore · {item:5956} Blacksmith Hammer
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	-- was: ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666}: оранжевый на 83 (желтый 85, зеленый 105, серый 125): около 21 изготовлений до 100. Каждое требует 10 {item:2840}. Forever обучает {spell:2666} с 45; оранжевый до 85. Десять медных слитков на изготовление: плавьте свой {item:2770}. Нужна наковальня рядом. {item:5956} – инструмент: держите его в сумках."
	["{spell:2666} is orange at 75 (yellow 85, green 105, grey 125): about 29 crafts to 100, up to 32 for 9 players in 10 (the gathered materials above count that many). Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "",

	-- Step 13: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "{skill:164}: рецепты на 100",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s) and {spell:9985} (from 100, 2s 50c)."] = "",

	-- Step 14: Patterned Bronze Bracers to 125
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 125"] = "",
	-- {spell:2672} Patterned Bronze Bracers · {item:2841} Bronze Bar · {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone · Tin Veins = {object:1732} Tin Vein
	["{spell:2672} is orange at 100 (yellow 125, green 140, grey 155): about 25 crafts to 125, a point every craft. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 11 {spell:3326} first. Use the 39 {spell:3326} you made earlier; the counts above leave them out. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. If you got here without learning {spell:3326}, learn it now: an earlier step teaches it."] = "",

	-- Step 15: Bronze Warhammer to 150
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 150"] = "",
	-- {item:7956} Bronze Warhammer · {item:2841} Bronze Bar · {item:3466} Strong Flux · {item:2319} Medium Leather · {skill:164} Blacksmithing
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["{item:7956} is orange at 125 (yellow 155, green 170, grey 185): about 25 crafts to 150, a point every craft. Each takes 8 {item:2841}, 1 {item:3466} and 1 {item:2319}. Eight Bronze Bars, a {item:3466} (blacksmithing suppliers) and a {item:2319} a craft; every Journeyman trainer in the capitals teaches it from 100. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "",

	-- Step 16: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "{skill:164}: Умелец",
	-- {skill:164} Blacksmithing · {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:3501} Green Iron Bracers · {spell:3337} Heavy Grinding Stone · {item:2838} Heavy Stone · {item:3575} Iron Bar · {item:3859} Steel Bar · {item:3860} Mithril Bar · {item:4304} Thick Leather · {item:4338} Mageweave Cloth · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). This route trains it at {npc:4258} ({zone:1455}) for the Alliance and {npc:3355} ({zone:1454}) for the Horde, who also teach the recipes of 150-225: one trainer for every visit. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 60 {item:2838}, 186 {item:3575}, 302 {item:3859}, 230 {item:3860}, 84 {item:4304}, 60 {item:4338} and 72 {item:7912} to gather or buy."] = "",

	-- Step 17: Blacksmithing 150-225: vendor goods
	-- {skill:164} Blacksmithing
	["{skill:164} 150-225: vendor goods"] = "{skill:164} 150-225: товары торговцев",
	-- {item:2605} Green Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {item:3859} Steel Bar · {skill:186} Mining · {item:3575} Iron Bar
	-- was: ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "Купите сразу все для этого этапа: 28 {item:2605} (28с); всего около 28с. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:1347}, {npc:1286} и {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} и {npc:5817}). Если вы сами плавите 195 {item:3859} ({skill:186} 165: по одному {item:3575} и углю), купите еще 195 углей (9з 75с, у торговцев и кузнецов); пропустите их, если покупаете слитки."
	["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: Borya, {npc:3367} and {npc:5817}). If you smelt the 302 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 302 Coal too (15g 10s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "",

	-- Step 18: Get Heavy Stone
	-- {item:2838} Heavy Stone
	["Get {item:2838}"] = "",
	-- {item:2838} Heavy Stone · {skill:164} Blacksmithing · {item:6040} Golden Scale Bracers · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:2548} Riverglades
	["60 {item:2838} for {skill:164} 150-225: 10 {item:6040}. {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:2548} (38-47). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 19: Get Iron Bar
	-- {item:3575} Iron Bar
	["Get {item:3575}"] = "",
	-- {item:3575} Iron Bar · {skill:164} Blacksmithing · {spell:3501} Green Iron Bracers · {item:2772} Iron Ore · {skill:186} Mining
	["186 {item:3575} for {skill:164} 150-225: 31 {spell:3501}. Mine {item:2772} and smelt it at a forge ({skill:186} 125). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 20: Get Steel Bar
	-- {item:3859} Steel Bar
	["Get {item:3859}"] = "",
	-- {item:3859} Steel Bar · {skill:164} Blacksmithing · {item:6040} Golden Scale Bracers · {item:2772} Iron Ore · {skill:186} Mining
	-- plural, as words: Steel Plate Helms = {item:7922} Steel Plate Helm
	["302 {item:3859} for {skill:164} 150-225: 10 {item:6040} and 18 Steel Plate Helms. Smelting makes them from {item:2772} ({skill:186} 165): about 302 {item:2772} for 302. The loops below are for the {item:2772}; the {skill:186} guide's loops give the rest. The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 21: Get Mithril Bar
	-- {item:3860} Mithril Bar
	["Get {item:3860}"] = "",
	-- {item:3860} Mithril Bar · {skill:164} Blacksmithing · {item:7933} Heavy Mithril Boots · {item:3858} Mithril Ore · {skill:186} Mining
	-- plural, as words: Heavy Mithril Gauntlets = {item:7919} Heavy Mithril Gauntlet
	["230 {item:3860} for {skill:164} 150-225: 15 Heavy Mithril Gauntlets and 10 {item:7933}. Mine {item:3858} and smelt it at a forge ({skill:186} 175). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 22: Get Thick Leather
	-- {item:4304} Thick Leather
	["Get {item:4304}"] = "",
	-- {item:4304} Thick Leather · {skill:164} Blacksmithing · {item:7933} Heavy Mithril Boots · {skill:393} Skinning
	["84 {item:4304} for {skill:164} 150-225: 21 {item:7933} (44 of them for 225-300: get them all now). {skill:393}: beasts of level 38-50. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 23: Get Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get {item:4338}"] = "",
	-- {item:4338} Mageweave Cloth · {skill:164} Blacksmithing
	-- plural, as words: Heavy Mithril Gauntlets = {item:7919} Heavy Mithril Gauntlet
	["60 {item:4338} for {skill:164} 150-225: 15 Heavy Mithril Gauntlets. Humanoids of level 35-50 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:4338} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 24: Get Solid Stone
	-- {item:7912} Solid Stone
	["Get {item:7912}"] = "",
	-- {item:7912} Solid Stone · {skill:164} Blacksmithing · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- plural, as words: Steel Plate Helms = {item:7922} Steel Plate Helm
	["72 {item:7912} for {skill:164} 150-225: 18 Steel Plate Helms. {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 25: Green Iron Bracers to 175
	-- {spell:3501} Green Iron Bracers
	["{spell:3501} to 175"] = "{spell:3501} до 175",
	-- {spell:3501} Green Iron Bracers · {item:3575} Iron Bar · {item:2605} Green Dye
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	-- was: ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501}: оранжевый на 150 (желтый 165, зеленый 177, серый 190): около 28 изготовлений до 175. Каждое требует 6 {item:3575} и 1 {item:2605}. Шесть железных слитков и {item:2605} на изготовление; {item:2605} продается у портных, кожевников и торговцев припасами. В Forever оранжевый до 165, так что первые пятнадцать дают по очку. Нужна наковальня рядом."
	["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175, up to 31 for 9 players in 10 (the gathered materials above count that many). Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "",

	-- Step 26: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "{skill:164}: рецепты на 175",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:7223} Golden Scale Bracers · {spell:9920} Solid Grinding Stone
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:7223} (from 160) and {spell:9920} (from 175)."] = "",

	-- Step 27: Golden Scale Bracers to 185
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 185"] = "",
	-- {item:6040} Golden Scale Bracers · {item:3859} Steel Bar · {spell:3337} Heavy Grinding Stone · {item:3575} Iron Bar · {skill:186} Mining
	-- plural, as words: Steel Bars = {item:3859} Steel Bar · Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone
	["{item:6040} is orange at 175 (yellow 185, green 197, grey 210): about 10 crafts to 185, a point every craft. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 20 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Needs an anvil nearby."] = "",

	-- Step 28: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "{skill:164}: рецепты на 185",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:9928} Heavy Mithril Gauntlet
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:9928} (from 180)."] = "",

	-- Step 29: Heavy Mithril Gauntlet to 200
	-- {item:7919} Heavy Mithril Gauntlet
	["{item:7919} to 200"] = "",
	-- {item:7919} Heavy Mithril Gauntlet · {item:3860} Mithril Bar · {item:4338} Mageweave Cloth · {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:7919} is orange at 185 (yellow 200, green 210, grey 220): about 15 crafts to 200, a point every craft. Each takes 6 {item:3860} and 4 {item:4338}. Six Mithril Bars and four {item:4338} a craft; {npc:4258} ({zone:1455}) and {npc:3355} ({zone:1454}) teach it from 180. Needs an anvil nearby."] = "",

	-- Step 30: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:9935} Steel Plate Helm
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:9935} (from 190)."] = "",

	-- Step 31: Steel Plate Helm to 215
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 215"] = "",
	-- {item:7922} Steel Plate Helm · {item:3859} Steel Bar · {item:7966} Solid Grinding Stone · {npc:5164} Grumnus Steelshaper · {zone:1455} Ironforge · {npc:11177} Okothos Ironrager · {zone:1454} Orgrimmar · {spell:9788} Armorsmith · {item:7936} Ornate Mithril Boots · {item:7935} Ornate Mithril Breastplate · {npc:11146} Ironus Coldsteel · {npc:11178} Borgosh Corebender · {item:3853} Moonsteel Broadsword · {npc:2482} Zarena Cromwind · {area:35} Booty Bay · {item:3855} Massive Iron Axe
	-- plural, as words: Ornate Mithril Helms = {item:7937} Ornate Mithril Helm · Moonsteel Broadswords = {item:3853} Moonsteel Broadsword · Massive Iron Axes = {item:3855} Massive Iron Axe · Heavy Mithril Axes = {item:7940} Heavy Mithril Axe · Big Black Maces = {item:7945} Big Black Mace
	["{item:7922} is orange at 200 (yellow 210, green 220, grey 230): about 16 crafts to 215, up to 18 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:3859} and 1 {item:7966}. Make the 16 {item:7966} first. The trainer teaches it, and it is the cheapest way through these points in the data. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "",

	-- Step 32: Blacksmithing recipes at 215
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 215"] = "",
	-- {spell:9968} Heavy Mithril Boots · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {skill:164} Blacksmithing
	-- was: ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959} (от 205) обучают только учителя ранга «Искусник»: Альянс – {npc:2836} ({zone:1434}); Орда – {npc:2836} ({zone:1434}). Если у вас 35-й уровень, можно уже сейчас обучиться там рангу «Искусник» (нужен навык {skill:164} 200): это избавит от поездки на 225."
	["{spell:9968} (from 210) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "",

	-- Step 33: Heavy Mithril Boots to 225
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 225"] = "",
	-- {item:7933} Heavy Mithril Boots · {item:3860} Mithril Bar · {item:4304} Thick Leather · {skill:164} Blacksmithing
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar · Mithril Deposits = {object:2040} Mithril Deposit
	["{item:7933} is orange at 215 (yellow 230, green 240, grey 250): about 10 crafts to 225, a point every craft. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "",

	-- Step 34: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "{skill:164}: Искусник",
	-- {skill:164} Blacksmithing · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {spell:16640} Dense Weightstone · {item:3860} Mithril Bar · {item:7909} Aquamarine · {item:7910} Star Ruby · {item:8170} Rugged Leather · {item:12359} Thorium Bar · {item:12365} Dense Stone · {item:7077} Heart of Fire · {npc:14567} Derotain Mudsipper
	["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). This route trains it at {npc:2836} ({zone:1434}) for the Alliance and {npc:2836} ({zone:1434}) for the Horde, who also teach the recipes of 225-300: one trainer for every visit. Learn now: {spell:16640} (from 225). 225-300 takes 154 {item:3860}, 5 {item:7909}, 20 {item:7910}, 30 {item:8170}, 550 {item:12359} and 24 {item:12365} to gather or buy. From 265 the route splits: with Radiant plans, about 36 more crafts and 152 {item:7077} and 586 {item:12359}; with {npc:14567}'s plans, about 40 crafts and 37 {item:7909}, 45 {item:7910} and 1458 {item:12359}."] = "",

	-- Step 35: Get Mithril Bar
	-- {item:3860} Mithril Bar · {skill:164} Blacksmithing · {item:7933} Heavy Mithril Boots · {item:3858} Mithril Ore · {skill:186} Mining
	["154 {item:3860} for {skill:164} 225-300: 11 {item:7933}. Mine {item:3858} and smelt it at a forge ({skill:186} 175). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 36: Get Aquamarine
	-- {item:7909} Aquamarine
	["Get {item:7909}"] = "",
	-- {item:7909} Aquamarine · {skill:164} Blacksmithing · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["5 {item:7909} for {skill:164} 225-300: 5 Imperial Plate Belts. {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 37: Get Star Ruby
	-- {item:7910} Star Ruby
	["Get {item:7910}"] = "",
	-- {item:7910} Star Ruby · {skill:164} Blacksmithing · {item:12425} Imperial Plate Bracers · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	["20 {item:7910} for {skill:164} 225-300: 20 {item:12425}. {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 38: Get Rugged Leather
	-- {item:8170} Rugged Leather
	["Get {item:8170}"] = "",
	-- {item:8170} Rugged Leather · {skill:164} Blacksmithing · {skill:393} Skinning
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["30 {item:8170} for {skill:164} 225-300: 5 Imperial Plate Belts. {skill:393}: beasts of level 48-60. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 39: Get Thorium Bar
	-- {item:12359} Thorium Bar
	["Get {item:12359}"] = "",
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12425} Imperial Plate Bracers · {item:10620} Thorium Ore · {skill:186} Mining
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["550 {item:12359} for {skill:164} 225-300: 5 Imperial Plate Belts and 20 {item:12425}. Mine {item:10620} and smelt it at a forge ({skill:186} 250). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 40: Get Dense Stone
	-- {item:12365} Dense Stone
	["Get {item:12365}"] = "",
	-- {item:12365} Dense Stone · {skill:164} Blacksmithing · {skill:186} Mining · {object:324} Small Thorium Vein · {zone:1448} Felwood · {zone:1451} Silithus · {zone:1452} Winterspring
	-- plural, as words: Dense Weightstones = {item:12643} Dense Weightstone
	["24 {item:12365} for {skill:164} 225-300: 24 Dense Weightstones. {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 41: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	-- was: ["{item:12643} to 235"] = "{item:12643} до 235"
	["{item:12643} to 235"] = "",
	-- {item:12643} Dense Weightstone · {item:12365} Dense Stone
	["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235, up to 24 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:12365}. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 42: Heavy Mithril Boots to 240
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 240"] = "",
	-- {item:7933} Heavy Mithril Boots · {item:3860} Mithril Bar · {item:4304} Thick Leather
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar · Mithril Deposits = {object:2040} Mithril Deposit
	["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 8 crafts to 240, up to 11 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby. If you got here without learning {item:7933}, learn it now: an earlier step teaches it."] = "",

	-- Step 43: Plans: Imperial Plate Belt and Plans: Imperial Plate Bracers
	-- {item:12688} Plans: Imperial Plate Belt · {item:12690} Plans: Imperial Plate Bracers
	["{item:12688} and {item:12690}"] = "",
	-- {npc:14567} Derotain Mudsipper · {zone:1446} Tanaris · {item:12688} Plans: Imperial Plate Belt · {skill:164} Blacksmithing · {item:12359} Thorium Bar · {quest:7653} Imperial Plate Belt · {item:12690} Plans: Imperial Plate Bracers · {quest:7655} Imperial Plate Bracer · {quest:7652} A Blue Light Bargain · {item:12425} Imperial Plate Bracers
	["{npc:14567} ({zone:1446}) trades {item:12688} ({skill:164} 240) for 20 {item:12359} in {quest:7653} and {item:12690} ({skill:164} 245) for 20 {item:12359} in {quest:7655}, which need {skill:164} 240 and character level 50; take {quest:7652} first (it asks for nothing). The plans bind when picked up. Take the {item:12690} now too: they wait in your bags until 245 for {item:12425}, and it saves a trip back."] = "",

	-- Step 44: Imperial Plate Belt to 245
	-- {item:12424} Imperial Plate Belt
	["{item:12424} to 245"] = "",
	-- {item:12424} Imperial Plate Belt · {item:12359} Thorium Bar · {item:8170} Rugged Leather · {item:7909} Aquamarine
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12424} is orange at 240 (yellow 260, green 270, grey 280): about 5 crafts to 245, a point every craft. Each takes 22 {item:12359}, 6 {item:8170} and 1 {item:7909}. Twenty-two Thorium Bars, six {item:8170} and an {item:7909} a craft, orange from 240: five points, until the bracers plans can be learned at 245. Needs an anvil nearby."] = "",
	["from the recipe in your bags"] = "по рецепту из сумки",

	-- Step 45: Imperial Plate Bracers to 265
	-- {item:12425} Imperial Plate Bracers
	["{item:12425} to 265"] = "",
	-- {item:12425} Imperial Plate Bracers · {item:12359} Thorium Bar · {item:7910} Star Ruby · {npc:14567} Derotain Mudsipper
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12425} is orange at 245 (yellow 265, green 275, grey 285): about 20 crafts to 265, a point every craft. Each takes 20 {item:12359} and 1 {item:7910}. Twenty Thorium Bars and a {item:7910} a craft, orange to 265: the fewest Thorium Bars a point {npc:14567}'s plans give. Needs an anvil nearby."] = "",

	-- Step 46: Blacksmithing 265: Plans: Radiant Boots
	-- {item:12697} Plans: Radiant Boots · {item:12713} Plans: Radiant Leggings · {spell:16656} Radiant Boots · {item:12420} Radiant Leggings · {npc:14567} Derotain Mudsipper · {quest:7654} Imperial Plate Boots
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["From 265 the route has two ways. {item:12697} and {item:12713} drop from mobs all over the world and do not bind, so the Auction House often lists them: with them, {spell:16656} (orange to 285) and then {item:12420} take you to 300 on about half the Thorium Bars, with Hearts of Fire. No plans for sale? Skip this step: the next steps go on with {npc:14567}'s {quest:7654}, about 34 Thorium Bars a craft. Buy the boots plans whenever they turn up."] = "",

	-- Step 47: Get Heart of Fire
	-- {item:7077} Heart of Fire
	["Get {item:7077}"] = "",
	-- {item:7077} Heart of Fire · {skill:164} Blacksmithing · {item:12419} Radiant Boots · {item:12420} Radiant Leggings · {npc:9878} Entropic Beast · {npc:6520} Scorching Elemental · {npc:5855} Magma Elemental
	["152 {item:7077} for {skill:164} 265-300: 29 {item:12419} and 9 {item:12420}. {item:7077} drops most from {npc:9878}, {npc:6520} and {npc:5855}, among others. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:7077} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 48: Get Thorium Bar
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12419} Radiant Boots · {item:12420} Radiant Leggings · {item:10620} Thorium Ore · {skill:186} Mining
	["586 {item:12359} for {skill:164} 265-300: 29 {item:12419} and 9 {item:12420}. Mine {item:10620} and smelt it at a forge ({skill:186} 250). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 49: Blacksmithing 265-300: Auction House
	-- {skill:164} Blacksmithing
	["{skill:164} 265-300: Auction House"] = "",
	-- {item:12713} Plans: Radiant Leggings
	["What 265-300 takes that the Auction House sells and no step above farms: a {item:12713}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 50: Radiant Boots to 291
	-- {item:12419} Radiant Boots
	["{item:12419} to 291"] = "",
	-- {item:12419} Radiant Boots · {item:12359} Thorium Bar · {item:7077} Heart of Fire · {item:12697} Plans: Radiant Boots
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12419} is orange at 265 (yellow 285, green 295, grey 305): about 27 crafts to 291, up to 29 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:12359} and 4 {item:7077}. Its pattern ({item:12697}) drops from mobs all over the world and does not bind: buy it at the Auction House. Fourteen Thorium Bars and four Hearts of Fire a craft; orange to 285. Needs an anvil nearby."] = "",

	-- Step 51: Radiant Leggings to 300
	-- {item:12420} Radiant Leggings
	["{item:12420} to 300"] = "",
	-- {item:12420} Radiant Leggings · {item:12359} Thorium Bar · {item:7077} Heart of Fire · {item:12713} Plans: Radiant Leggings · {skill:164} Blacksmithing
	["{item:12420} is orange at 291 (yellow 300, green 310, grey 320): about 9 crafts to 300, a point every craft. Each takes 20 {item:12359} and 4 {item:7077}. Its pattern ({item:12713}) drops from mobs all over the world and does not bind: buy it at the Auction House. The last points: buy the plans when you reach 280; until then the boots carry you. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "",
	["from the pattern bought at the Auction House"] = "из выкройки, купленной на аукционе",

	-- Step 52: Get Aquamarine
	-- {item:7909} Aquamarine · {skill:164} Blacksmithing · {quest:7654} Imperial Plate Boots · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	["37 {item:7909} for {skill:164} 265-300: 37 {quest:7654}. {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 53: Get Star Ruby
	-- {item:7910} Star Ruby · {skill:164} Blacksmithing · {item:12425} Imperial Plate Bracers · {quest:7654} Imperial Plate Boots · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	["45 {item:7910} for {skill:164} 265-300: 8 {item:12425} and 37 {quest:7654}. {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 54: Get Thorium Bar
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12425} Imperial Plate Bracers · {quest:7654} Imperial Plate Boots · {item:10620} Thorium Ore · {skill:186} Mining
	["1458 {item:12359} for {skill:164} 265-300: 8 {item:12425} and 37 {quest:7654}. Mine {item:10620} and smelt it at a forge ({skill:186} 250). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 55: Imperial Plate Bracers to 270
	-- {item:12425} Imperial Plate Bracers
	["{item:12425} to 270"] = "",
	-- {item:12425} Imperial Plate Bracers · {item:12359} Thorium Bar · {item:7910} Star Ruby
	["{item:12425} is yellow at 265 (yellow 265, green 275, grey 285): about 6 crafts to 270, up to 8 for 9 players in 10 (the gathered materials above count that many). Each takes 20 {item:12359} and 1 {item:7910}. Yellow from 265, so not every craft gives a point; five more points, until the boots plans can be used at 270. Needs an anvil nearby. If you got here without learning {item:12425}, learn it now: an earlier step teaches it."] = "",

	-- Step 56: Plans: Imperial Plate Boots
	-- {npc:14567} Derotain Mudsipper · {zone:1446} Tanaris · {item:12700} Plans: Imperial Plate Boots · {skill:164} Blacksmithing · {item:12359} Thorium Bar · {quest:7654} Imperial Plate Boots
	["{npc:14567} ({zone:1446}) trades {item:12700} ({skill:164} 270) for 40 {item:12359} in {quest:7654}, which needs {skill:164} 240 and character level 50. The plans bind when picked up."] = "",

	-- Step 57: Imperial Plate Boots to 300
	-- {item:12426} Imperial Plate Boots
	["{item:12426} to 300"] = "{item:12426} до 300",
	-- {item:12426} Imperial Plate Boots · {item:12359} Thorium Bar · {item:7910} Star Ruby · {item:7909} Aquamarine · {skill:164} Blacksmithing
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12426} is orange at 270 (yellow 290, green 300, grey 310): about 34 crafts to 300, up to 37 for 9 players in 10 (the gathered materials above count that many). Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. Thirty-four Thorium Bars, a {item:7910} and an {item:7909} a craft, orange to 290: the plans you can always get past 270. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["10 {item:12799} for {item:12773}: {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining."] = "10 {item:12799} для {item:12773}: {item:12799} попадается примерно в одной жиле из 143 ({object:175404}, {object:177388} или {object:180215}): сохраняйте найденные при добыче.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "{item:4304} 142 для {item:7933} и {item:7945}: {skill:393}: звери 38-50 уровня. Снимайте шкуры с {npc:2729}, {npc:2730}, {npc:2732} и {npc:2734} здесь (38-50 уровня); маршрут ведет гайд {skill:393}.",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "{item:4304} 142 для {item:7933} и {item:7945}: {skill:393}: звери 38-50 уровня. Снимайте шкуры с {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} и {npc:5296} здесь (38-50 уровня); маршрут ведет гайд {skill:393}.",
	-- ["168 {item:3575} for {spell:3501}: {skill:186}: smelt {item:2772}."] = "168 {item:3575} для {spell:3501}: {skill:186}: выплавьте из {item:2772}.",
	-- ["19 {item:7909} for {quest:7654}: {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining."] = "19 {item:7909} для {quest:7654}: {item:7909} попадается примерно в одной жиле из 500 ({object:2047} или {object:123309}): сохраняйте найденные при добыче.",
	-- ["19 {item:7910} for {quest:7654}: {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining."] = "19 {item:7910} для {quest:7654}: {item:7910} попадается примерно в одной жиле из 143 ({object:2047} или {object:123309}): сохраняйте найденные при добыче.",
	-- ["195 {item:3859} for {item:6040}: {skill:186}: smelt {item:3575} and Coal."] = "195 {item:3859} для {item:6040}: {skill:186}: выплавьте из {item:3575} и угля.",
	-- ["2026 {item:12359} for {item:12773}, {item:12775} and {quest:7654}: {skill:186}: smelt {item:10620}."] = "2026 {item:12359} для {item:12773}, {item:12775} и {quest:7654}: {skill:186}: выплавьте из {item:10620}.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "{item:8170} 206 для {item:12773} и {item:12775}: {skill:393}: звери 48-60 уровня. Снимайте шкуры с {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} и {npc:6377} здесь (48-60 уровня); маршрут ведет гайд {skill:393}.",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "206 {item:8170} для {item:12773} и {item:12775}: {skill:393}: звери 48-60 уровня. Снимайте шкуры здесь: {npc:8598}, Чумной пес и {npc:8596} (уровень 48-60); маршрут – в гайде {skill:393}.",
	-- ["210 {item:2840} for {spell:2666}: {skill:186}: smelt {item:2770}."] = "210 {item:2840} для {spell:2666}: {skill:186}: выплавьте из {item:2770}.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "{item:2838} 234 для {item:6040}: {skill:186}: {object:1735} (навык 125) в {zone:1417} (30-40), {zone:1434} (30-45) и {zone:1443} (30-40). В {zone:1417} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "{item:2838} 234 для {item:6040}: {skill:186}: {object:1735} (навык 125) в {zone:1441} (25-35), {zone:1417} (30-40) и {zone:1434} (30-45). В {zone:1441} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1413} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1421} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1432} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1436} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "{item:2836} 256 для {spell:2672}: {skill:186}: {object:1732} (навык 65). В {zone:1439} отмечено место, где {object:1732} встречается чаще всего.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "{item:2838} 28 для {spell:2674}: {skill:186}: {object:1735} (навык 125). В {zone:1413} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "{item:2838} 28 для {spell:2674}: {skill:186}: {object:1735} (навык 125). В {zone:1417} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "{item:2838} 28 для {spell:2674}: {skill:186}: {object:1735} (навык 125). В {zone:1440} отмечено место, где {object:1735} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1411} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1412} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1420} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1426} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1429} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:1439} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "{item:2835} 286 для {spell:2660} и {spell:3320} (116 из них на 75-150: соберите все сейчас): {skill:186}: {object:1731} (навык 1). В {zone:2521} отмечено место, где {object:1731} встречается чаще всего.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "{item:7912} 30 для {item:7964}: {skill:186}: {object:2040} (навык 175) в {zone:1434} (30-45), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1434} отмечено место, где {object:2040} встречается чаще всего.",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "{item:7912} 30 для {item:7964}: {skill:186}: {object:2040} (навык 175) в {zone:1443} (30-40), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1443} отмечено место, где {object:2040} встречается чаще всего.",
	-- ["320 {item:2841} for {spell:2672}: {skill:186}: smelt {item:2840} and {item:3576}."] = "320 {item:2841} для {spell:2672}: {skill:186}: выплавьте из {item:2840} и {item:3576}.",
	-- ["320 {item:3860} for {item:7930}: {skill:186}: smelt {item:3858}."] = "320 {item:3860} для {item:7930}: {skill:186}: выплавьте из {item:3858}.",
	-- ["44 {item:1210} for {item:7945}: {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining."] = "44 {item:1210} для {item:7945}: {item:1210} попадается примерно в одной жиле из 100 ({object:1731}, {object:1732} или {object:1733}): сохраняйте найденные при добыче.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "{item:7912} 44 для {item:7945}: {skill:186}: {object:2040} (навык 175) в {zone:1425} (40-50), {zone:1444} (40-50) и {zone:1447} (45-55). В {zone:1425} отмечено место, где {object:2040} встречается чаще всего.",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "{item:7912} 44 для {item:7945}: {skill:186}: {object:2040} (навык 175) в {zone:1443} (30-40), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1443} отмечено место, где {object:2040} встречается чаще всего.",
	-- ["596 {item:3860} for {item:7933} and {item:7945}: {skill:186}: smelt {item:3858}."] = "596 {item:3860} для {item:7933} и {item:7945}: {skill:186}: выплавьте из {item:3858}.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1419} (45-55), {zone:1448} (48-55) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1419} is marked."] = "{item:12365} 801 для {item:12643}, {item:12773} и {item:12775}: {skill:186}: {object:324} (навык 245) в {zone:1419} (45-55), {zone:1448} (48-55) и {zone:1452} (55-60). В {zone:1419} отмечено место, где {object:324} встречается чаще всего.",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1448} is marked."] = "{item:12365} 801 для {item:12643}, {item:12773} и {item:12775}: {skill:186}: {object:324} (навык 245) в {zone:1448} (48-55), {zone:1451} (55-60) и {zone:1452} (55-60). В {zone:1448} отмечено место, где {object:324} встречается чаще всего.",
	-- ["Apprentice {skill:164}"] = "{skill:164}: Ученик",
	-- ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "Подмастерье по {skill:164} позволяет создавать предметы до 75 навыка за 10c на любом уровне персонажа; обучит любой наставник {skill:164} вашей фракции, а стрелка укажет ближайшего. Купите {item:5956} у любого поставщика кузнечных припасов и начните с {skill:186}: {item:2835} и {item:2770} дают медные жилы каждой стартовой зоны. На 1-75 уйдёт примерно 1s рецептов, плюс 286 {item:2835}, которые нужно собрать или купить.",
	-- ["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Ранг «Искусник» требует уровня персонажа 35 и навыка {skill:164} 200; предел становится 300. Материалы на 225-300 стоят всего около 942з.",
	-- ["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:16639} – с навыка {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:16640} – с навыка {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Вернитесь к учителю ({skill:164}): {spell:2666} – с навыка {skill:164} 80.",
	-- ["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Вернитесь к учителю ({skill:164}): {spell:2668} – с навыка {skill:164} 95.",
	-- ["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s)."] = "Вернитесь к учителю ({skill:164}): {spell:2672} (с 95, 5 с).",
	-- ["Back to a {skill:164} trainer: {spell:2674} (from 100, 10s)."] = "Вернитесь к учителю ({skill:164}): {spell:2674} (с 100, 10 с).",
	-- ["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Вернитесь к учителю ({skill:164}): {spell:3117} – с навыка {skill:164} 100.",
	-- ["Back to a {skill:164} trainer: {spell:7223} (from 160)."] = "Вернитесь к учителю ({skill:164}): {spell:7223} (с 160).",
	-- ["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Вернитесь к учителю ({skill:164}): {spell:9916} – с навыка {skill:164} 200.",
	-- ["Back to a {skill:164} trainer: {spell:9918} (from 175)."] = "Вернитесь к учителю ({skill:164}): {spell:9918} (с 175).",
	-- ["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Вернитесь к учителю ({skill:164}): {spell:9920}, {spell:9935} – с навыка {skill:164} 210.",
	-- ["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Вернитесь к учителю ({skill:164}): {spell:9968} – с навыка {skill:164} 230.",
	-- ["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Вернитесь к учителю ({skill:164}): {spell:9985} – с навыка {skill:164} 155.",
	-- ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "Купите сразу все для этого этапа: 28 {item:2605} (28с); всего около 28с. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:1347}, {npc:1286} и {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} и {npc:5817}). Если вы сами плавите 195 {item:3859} ({skill:186} 165: по одному {item:3575} и углю), купите еще 195 углей (9з 75с, у торговцев и кузнецов); пропустите их, если покупаете слитки.",
	-- ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "Купите сразу все для этого этапа: {item:5956} (инструмент: один, держите в сумках, 18м); всего около 18м. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:5519}, {npc:1286} и {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} и {npc:3413}).",
	-- ["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Ранг «Умелец» требует уровня персонажа 20 и навыка {skill:164} 125; предел становится 225. Материалы на 150-225 стоят всего около 42з.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "Ранг «Умелец» поднимает предел со 150 до 225 за 50с (цена Classic; цены Forever нет в данных); нужен навык {skill:164} 125 и уровень персонажа 20, так что его можно взять при любом визите начиная со 125. Учат ему лишь немногие: Альянс – {npc:4258} ({zone:1455}); Орда – {npc:3355} ({zone:1454}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:3501} (со 140) и {spell:3337} (со 100, 10с). На 150-225 уйдет около 10с на рецепты и 28с на товары торговцев, плюс 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} и 30 {item:7912} – добудьте или купите.",
	-- ["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Ранг «Подмастерье» требует уровня персонажа 10 и навыка {skill:164} 50; предел становится 150. Материалы на 75-150 стоят всего около 9з 41с.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Ранг «Подмастерье» поднимает предел с 75 до 150 за 5с; нужен навык {skill:164} 50 и уровень персонажа 10, так что его можно взять при любом визите начиная с 50. Учат ему не все учителя ({skill:164}): Альянс – {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) и {npc:5511} ({zone:1453}); Орда – {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) и {npc:3478} ({zone:1413}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:2666} (с 45, 2с) и {spell:3326} (с 50, 2с 50м). На 75-150 уйдет около 19с 50м на рецепты и 18м на товары торговцев, плюс 256 {item:2836}, 28 {item:2838}, 210 {item:2840} и 320 {item:2841} – добудьте или купите.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Snarl ({zone:1454}) and Traugh ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "Ранг «Подмастерье» поднимает предел с 75 до 150 за 5с; он требует навыка {skill:164} 50 и уровня персонажа 10, так что его можно взять при любом визите начиная с 50. Не каждый учитель ({skill:164}) обучает ему: Альянс – {npc:4258} ({zone:1455}), {npc:2836} ({zone:1434}), {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) и {npc:5511} ({zone:1453}); Орда – {npc:2836} ({zone:1434}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:3355} ({zone:1454}), Рык ({zone:1454}) и Трауг ({zone:1413}). Стрелка выбирает ближайшего учителя вашей фракции. Изучите сейчас: {spell:2666} (с 45, 2с) и {spell:3326} (с 50, 2с 50м). На 75-150 нужно около 19с 50м на рецепты и 18м на товары торговцев, а также добыть или купить: {item:2836} – 256, {item:2838} – 28, {item:2840} – 210 и {item:2841} – 320.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Убивайте существ, с которых он падает, в месте, выбранном Polestar для вашего уровня и фракции. Подойдет и аукцион.",
	-- ["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 120, желтый до 135, зеленый до 150. Нужна наковальня рядом.",
	-- ["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 125, желтый до 140, зеленый до 155. Нужна наковальня рядом. {skill:164} 150 – рубеж Системы наследия.",
	-- ["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Оранжевый (очко за каждое изготовление) до 15, желтый до 35, зеленый до 55.",
	-- ["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 260, желтый до 270, зеленый до 280. Нужна наковальня рядом.",
	-- ["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 280, желтый до 292, зеленый до 305. Нужна наковальня рядом. {skill:164} 300 – рубеж Системы наследия.",
	-- ["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 85, желтый до 105, зеленый до 125. Нужна наковальня рядом.",
	-- ["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:8831}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:1815}, {npc:1816}, {npc:1817} (звери уровня 48-60); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Хрустогрыз, {npc:2384}, {npc:2354} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} (звери уровня 38-50); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} (звери уровня 38-50); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (звери уровня 48-60); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Снимается со шкур, получается распылением или другой профессией: добудьте сами или купите на аукционе.",
	-- ["Teaches {item:12775} (needs {skill:164} 255)."] = "Обучает: {item:12775} (нужно {skill:164} 255).",
	-- ["Teaches {item:250562} (needs {skill:164} 240)."] = "Обучает: {item:250562} (нужно {skill:164} 240).",
	-- ["What 1-75 takes that the Auction House sells: 286 {item:2835}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 1-75 и продается на аукционе: 286 {item:2835}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 150-225 takes that the Auction House sells: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 150-225 и продается на аукционе: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} и 30 {item:7912}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 225-300 takes that the Auction House sells: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 225-300 и продается на аукционе: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} и 10 {item:12799}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 75-150 takes that the Auction House sells: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 75-150 и продается на аукционе: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} и 320 {item:2841}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["Yellow until 107, green until 115: not every craft gives a point."] = "Желтый до 107, зеленый до 115: не каждое изготовление дает очко.",
	-- ["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 155, зеленый до 170: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 170, зеленый до 185: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 180, green until 185: not every craft gives a point."] = "Желтый до 180, зеленый до 185: не каждое изготовление дает очко.",
	-- ["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 197, зеленый до 210: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 212, зеленый до 225: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Желтый до 220, зеленый до 230: не каждое изготовление дает очко. Нужна наковальня рядом. {skill:164} 225 – рубеж Системы наследия.",
	-- ["Yellow until 232, green until 235: not every craft gives a point."] = "Желтый до 232, зеленый до 235: не каждое изготовление дает очко.",
	-- ["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 235, зеленый до 245: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 240, зеленый до 250: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 65, green until 85: not every craft gives a point."] = "Желтый до 65, зеленый до 85: не каждое изготовление дает очко.",
	-- ["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Желтый до 65, зеленый до 85: не каждое изготовление дает очко. 75 – предел ранга «Ученик».",
	-- ["{item:12365} (Alliance)"] = "{item:12365} (Альянс)",
	-- ["{item:12365} (Horde)"] = "{item:12365} (Орда)",
	-- ["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} добывается из: {object:324} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "{item:12426}: оранжевый на 285 (желтый 290, зеленый 300, серый 310): около 19 изготовлений до 300. Каждое требует 34 {item:12359}, 1 {item:7910} и 1 {item:7909}. Около 34 ториевых слитков на изготовление против 40 у топора и его точильных камней, оранжевый до 290. Ниже 50-го уровня персонажа {npc:14567} не даст вам задания: продолжайте делать огромные ториевые боевые топоры до 300 (желтый до 292, серый на 305: примерно вдвое больше ториевых слитков). Нужна наковальня рядом. {skill:164} 300 – веха системы Наследия.",
	-- ["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235. Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "{item:12643}: оранжевый на 225 (желтый 230, зеленый 232, серый 235): около 17 изготовлений до 235. Каждое требует 1 {item:12365}. По одному {item:12365} на изготовление (ториевые жилы): дешевые очки в начале Искусника.",
	-- ["{item:12643} to 235"] = "{item:12643} до 235",
	-- ["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby."] = "{item:12773}: оранжевый на 250 (желтый 275, зеленый 287, серый 300): около 5 изготовлений до 255, по очку за каждое. Каждое требует 20 {item:12359}, 2 {item:12799}, 2 {item:12644} и 4 {item:8170}. Сначала сделайте 10 {item:12644}. {item:12799} попадается примерно в одной ториевой жиле из 130: купите десять на аукционе. Всего пять изготовлений, пока на 255 не откроются выкройки топора. Нужна наковальня рядом.",
	-- ["{item:12773} to 255"] = "{item:12773} до 255",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} ({area:2298}, {zone:1422}), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775}: оранжевый на 255 (желтый 280, зеленый 292, серый 305): около 31 изготовлений до 285. Каждое требует 40 {item:12359}, 6 {item:12644} и 6 {item:8170}. Сначала сделайте 186 {item:12644}. Выкройки у {npc:11278} ({area:2298}, {zone:1422}), запасы без ограничений, но они становятся персональными при получении. Сорок ториевых слитков и шесть массивных шлифовальных камней на изготовление: самый дорогой отрезок, так что остановитесь там, где его подхватит {quest:7654}. Другие пути: выкройки общего дропа с аукциона (части Сияющего: около 820 ториевых слитков и 190 сердец огня на маршрут Сияющего) или комплекты «Услуга торговца». Нужна наковальня рядом.",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} in {area:2298} ({zone:1422}): he is a ghost you see only with the {item:13544} trinket on (put it on inside {area:2298}), the reward of {npc:11216}'s {area:2057} chain that ends with {npc:10506} (level 55, a dungeon group). Unlimited stock, but the plans bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Without the trinket, the other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775}: оранжевый на 255 (желтый 280, зеленый 292, серый 305): около 31 изготовления до 285. Каждое требует 40 {item:12359}, 6 {item:12644} и 6 {item:8170}. Сначала сделайте 186 {item:12644}. Чертеж у NPC {npc:11278} в месте {area:2298} ({zone:1422}): это призрак, видимый только с аксессуаром {item:13544} (наденьте его внутри места {area:2298}), наградой цепочки NPC {npc:11216} в месте {area:2057}, которая заканчивается на {npc:10506} (55-й уровень, группа для подземелья). Запас не ограничен, но чертеж становится персональным при получении. Сорок ториевых слитков и шесть плотных точильных камней на изготовление: самый дорогой отрезок, так что остановитесь там, где начинаются {quest:7654}. Без аксессуара другие пути: мировые чертежи с аукциона (сияющие предметы: около 820 ториевых слитков и 190 сердец огня для сияющего пути) или комплекты «Благосклонности торговцев». Нужна наковальня рядом.",
	-- ["{item:12775} to 285"] = "{item:12775} до 285",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12819} учит рецепту {item:12773} ({skill:164} 250) за 1з 60с. Продает {npc:11278} ({zone:1422}). {npc:11278} – призрак: вы видите его только с {item:13544} (из цепочки NPC {npc:11216} в месте {area:2057}, 55-й уровень, группа), так что без него пропустите это.",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12823} учит рецепту {item:12775} ({skill:164} 255) за 2з. Продает {npc:11278} ({zone:1422}). {npc:11278} – призрак: вы видите его только с {item:13544} (из цепочки NPC {npc:11216} в месте {area:2057}, 55-й уровень, группа), так что без него пропустите это.",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Альянс)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Орда)",
	-- ["{item:250562} to 268"] = "{item:250562} до 268",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (Альянс)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (Орда)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} добывается из: {object:1731} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:2836} (Alliance)"] = "{item:2836} (Альянс)",
	-- ["{item:2836} (Horde)"] = "{item:2836} (Орда)",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} добывается из: {object:1732} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:2838} (Alliance)"] = "{item:2838} (Альянс)",
	-- ["{item:2838} (Horde)"] = "{item:2838} (Орда)",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} добывается из: {object:1735} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:4304} (Alliance)"] = "{item:4304} (Альянс)",
	-- ["{item:4304} (Horde)"] = "{item:4304} (Орда)",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: инструмент, держите его в сумке",
	-- ["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "{item:6040}: желтый на 185 (желтый 185, зеленый 197, серый 210): около 39 изготовлений до 205. Каждое требует 5 {item:3859} и 2 {spell:3337}. Сначала сделайте 78 {spell:3337}. Стальные слитки плавятся из {item:3575} и угля ({skill:186} 165; уголь у торговцев и кузнецов), так что на каждый наруч нужно пять того и другого. Каждому наручу нужны два тяжелых точильных камня: сделайте их заранее. Специализация (необязательно): на 200 и уровне персонажа 40 {npc:5164} ({zone:1455}) или {npc:11177} ({zone:1454}) начнет «Искусство {spell:9788}»: 4 изысканных мифриловых шлема, 2 {item:7936} и {item:7935}; их выкройки дают по цепочке заданий Мифрилового ордена. {npc:11146} ({zone:1455}) или {npc:11178} ({zone:1454}) начнет «Путь оружейника»: 4 лунно-стальных палаша, 4 массивных железных топора, 2 тяжелых мифриловых топора и 2 больших черных палицы; в Forever выкройки {item:3853} ({npc:2482}, {area:35}) и {item:3855} становятся персональными при получении, так что покупайте и используйте их сами. Выбрать можно только одну; для 300 ни одна не нужна, и на бете их не проверяли (она заканчивалась на 30-м уровне). Нужна наковальня рядом.",
	-- ["{item:6040} to 205"] = "{item:6040} до 205",
	-- ["{item:7912} (Alliance)"] = "{item:7912} (Альянс)",
	-- ["{item:7912} (Horde)"] = "{item:7912} (Орда)",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} добывается из: {object:2040} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:7922} to 225"] = "{item:7922} до 225",
	-- ["{item:7930} is orange at 205 (yellow 225, green 235, grey 245): about 20 crafts to 225, a point every craft. Each takes 16 {item:3860}. Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "{item:7930}: оранжевый на 205 (желтый 225, зеленый 235, серый 245): около 20 изготовлений до 225, по очку за каждое. Каждое требует 16 {item:3860}. Шестнадцать мифриловых слитков на изготовление и ничего больше; в Forever оранжевый до 225, так что по очку до предела Искусника. Нужна наковальня рядом. {skill:164} 225 – веха системы Наследия.",
	-- ["{item:7930} to 225"] = "{item:7930} до 225",
	-- ["{item:7931} to 230"] = "{item:7931} до 230",
	-- ["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby."] = "{item:7933}: желтый на 235 (желтый 230, зеленый 240, серый 250): около 30 изготовлений до 247. Каждое требует 14 {item:3860} и 4 {item:4304}. Мифриловые слитки – из мифриловых залежей; {item:4304} – от кожевников или с аукциона. Нужна наковальня рядом.",
	-- ["{item:7933} to 247"] = "{item:7933} до 247",
	-- ["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "{item:7945}: зеленый на 247 (желтый 230, зеленый 242, серый 255): около 11 изготовлений до 250. Каждое требует 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} и 2 {item:4304}. Сначала сделайте 11 {item:7966}. На мост 247-250 нужно всего около 11 изготовлений, но каждое требует четыре камня теней (примерно один {object:1732} из ста) и {item:7971}: купите их на аукционе, если в сумках их нет. Нужна наковальня рядом. {item:7971} (11 на 225-300): {item:7971} – редкая добыча (ни один моб не дает его чаще одного раза из 50): купите на аукционе или сохраняйте найденные.",
	-- ["{item:7945} to 250"] = "{item:7945} до 250",
	-- ["{item:7956} to 175"] = "{item:7956} до 175",
	-- ["{item:7963} to 210"] = "{item:7963} до 210",
	-- ["{item:7964} is yellow at 175 (yellow 175, green 180, grey 185): about 30 crafts to 185. Each takes 1 {item:7912}. One {item:7912} a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them."] = "{item:7964}: желтый на 175 (желтый 175, зеленый 180, серый 185): около 30 изготовлений до 185. Каждое требует 1 {item:7912}. По одному {item:7912} на изготовление (мифриловые залежи): дешевые очки между железными и стальными наручами. Применяйте камни к своему оружию или продавайте их.",
	-- ["{item:7964} to 185"] = "{item:7964} до 185",
	-- ["{item:8170} (Alliance)"] = "{item:8170} (Альянс)",
	-- ["{item:8170} (Horde)"] = "{item:8170} (Орда)",
	-- ["{item:8831} (Alliance)"] = "{item:8831} (Альянс)",
	-- ["{item:8831} (Horde)"] = "{item:8831} (Орда)",
	-- ["{skill:164} 1-75: Auction House"] = "{skill:164} 1-75: аукцион",
	-- ["{skill:164} 150-225: Auction House"] = "{skill:164} 150-225: аукцион",
	-- ["{skill:164} 225-300: Auction House"] = "{skill:164} 225-300: аукцион",
	-- ["{skill:164} 75-150: Auction House"] = "{skill:164} 75-150: аукцион",
	-- ["{skill:164} materials for 150-225"] = "{skill:164}: материалы для 150-225",
	-- ["{skill:164} materials for 225-300"] = "{skill:164}: материалы для 225-300",
	-- ["{skill:164} materials for 75-150"] = "{skill:164}: материалы для 75-150",
	-- ["{skill:164} recipes at 113"] = "{skill:164}: рецепты на 113",
	-- ["{skill:164} recipes at 121"] = "{skill:164}: рецепты на 121",
	-- ["{skill:164} recipes at 155"] = "{skill:164}: рецепты на 155",
	-- ["{skill:164} recipes at 205"] = "{skill:164}: рецепты на 205",
	-- ["{skill:164} recipes at 210"] = "{skill:164}: рецепты на 210",
	-- ["{skill:164} recipes at 230"] = "{skill:164}: рецепты на 230",
	-- ["{skill:164} recipes at 268"] = "{skill:164}: рецепты на 268",
	-- ["{skill:164} recipes at 35"] = "{skill:164}: рецепты на 35",
	-- ["{skill:164} recipes at 45"] = "{skill:164}: рецепты на 45",
	-- ["{skill:164} recipes at 83"] = "{skill:164}: рецепты на 83",
	-- ["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} качается параллельно с уровнем. Система наследия Forever награждает за профессии производства на навыке 150, 225 и 300 (пределы рангов «Подмастерье», «Умелец» и «Искусник»), так что важен каждый рубеж. Материалы на 1-75 стоят всего около 17с.",
	-- ["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (или аукцион)",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: выплавка – {item:10620} (или аукцион)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: выплавка – {item:2770} (или аукцион)",
	-- ["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: выплавка – {item:2775} (или аукцион)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: выплавка – {item:2840} (или аукцион)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: выплавка – {item:3575} (или аукцион)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: выплавка – {item:3858} (или аукцион)",
	-- ["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (или аукцион)",
	-- ["{skill:393} (or the Auction House)"] = "{skill:393} (или аукцион)",
	-- ["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "{spell:2660}: оранжевый на 1 (желтый 15, зеленый 35, серый 55): около 42 изготовлений до 35. Каждое требует 1 {item:2835}. По одному {item:2835} на изготовление, по очку до 15.",
	-- ["{spell:2660} to 35"] = "{spell:2660} до 35",
	-- ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666}: оранжевый на 83 (желтый 85, зеленый 105, серый 125): около 21 изготовлений до 100. Каждое требует 10 {item:2840}. Forever обучает {spell:2666} с 45; оранжевый до 85. Десять медных слитков на изготовление: плавьте свой {item:2770}. Нужна наковальня рядом. {item:5956} – инструмент: держите его в сумках.",
	-- ["{spell:2668} to 121"] = "{spell:2668} до 121",
	-- ["{spell:2672} is orange at 113 (yellow 125, green 140, grey 155): about 64 crafts to 150. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 128 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "{spell:2672}: оранжевый на 113 (желтый 125, зеленый 140, серый 155): около 64 изготовлений до 150. Каждое требует 5 {item:2841} и 2 {spell:3326}. Сначала сделайте 128 {spell:3326}. Каждому наручу нужны два грубых точильных камня ({item:2836} из оловянных жил): сделайте их заранее, они тоже дают очки. Нужна наковальня рядом. {skill:164} 150 – веха системы Наследия.",
	-- ["{spell:2672} to 150"] = "{spell:2672} до 150",
	-- ["{spell:2674} is yellow at 100 (yellow 100, green 107, grey 115): about 28 crafts to 113. Each takes 1 {item:2838}. {item:2838} comes from Iron Deposits; one a craft."] = "{spell:2674}: желтый на 100 (желтый 100, зеленый 107, серый 115): около 28 изготовлений до 113. Каждое требует 1 {item:2838}. {item:2838} добывается в залежах железа; по одному на изготовление.",
	-- ["{spell:2674} to 113"] = "{spell:2674} до 113",
	-- ["{spell:3117} to 112"] = "{spell:3117} до 112",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320}: зеленый на 75 (желтый 45, зеленый 65, серый 85): около 58 изготовлений до 83. Каждое требует 2 {item:2835}. По два {item:2835} на изготовление. Точильные камни – детали для более поздних планов; лишние продаются торговцам.",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors. If you got here without learning {spell:3320}, learn it now: an earlier step teaches it."] = "{spell:3320}: зеленый на 75 (желтый 45, зеленый 65, серый 85): около 58 изготовлений до 83. Каждое требует 2 {item:2835}. По два {item:2835} на изготовление. Точильные камни – детали для более поздних чертежей; лишние продаются торговцам. Если вы дошли сюда, не выучив {spell:3320}, выучите сейчас: его учит один из прошлых шагов.",
	-- ["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320}: оранжевый на 35 (желтый 45, зеленый 65, серый 85): около 64 изготовлений до 75. Каждое требует 2 {item:2835}. По два {item:2835} на изготовление. Точильные камни – детали для более поздних планов; лишние продаются торговцам.",
	-- ["{spell:3320} to 75"] = "{spell:3320} до 75",
	-- ["{spell:3320} to 83"] = "{spell:3320} до 83",
	-- ["{spell:3333} to 155"] = "{spell:3333} до 155",
	-- ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501}: оранжевый на 150 (желтый 165, зеленый 177, серый 190): около 28 изготовлений до 175. Каждое требует 6 {item:3575} и 1 {item:2605}. Шесть железных слитков и {item:2605} на изготовление; {item:2605} продается у портных, кожевников и торговцев припасами. В Forever оранжевый до 165, так что первые пятнадцать дают по очку. Нужна наковальня рядом.",
	-- ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959} (от 205) обучают только учителя ранга «Искусник»: Альянс – {npc:2836} ({zone:1434}); Орда – {npc:2836} ({zone:1434}). Если у вас 35-й уровень, можно уже сейчас обучиться там рангу «Искусник» (нужен навык {skill:164} 200): это избавит от поездки на 225.",
}
