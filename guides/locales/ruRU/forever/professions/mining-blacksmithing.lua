-- Russian (ruRU): the guide forever/professions/mining-blacksmithing (forever/professions/mining-blacksmithing.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining and Blacksmithing
	-- {skill:186} Mining · {skill:164} Blacksmithing
	["Learn {skill:186} and {skill:164}"] = "",
	-- {skill:164} Blacksmithing · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore · {item:2836} Coarse Stone · {item:2901} Mining Pick
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 2s 50c of recipes, plus 111 {item:2835} and 114 {item:2836} to gather or buy. Learn Apprentice {skill:186} on the same trip: any {skill:186} trainer of your faction teaches it at any level, and the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "",

	-- Step 2: Mining 1-50: Chunk of Amber & Poor Copper
	-- {skill:186} Mining · {object:656332} Chunk of Amber
	["{skill:186} 1-50: {object:656332} & Poor Copper"] = "",
	-- {skill:186} Mining · {spell:2660} Rough Sharpening Stone · {item:2835} Rough Stone
	["Mine from {skill:186} 1 to 50 for {spell:2660}: this loop gives {item:2835}, and the next one the rest from {skill:186} 50. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 3: Mine Rough Stone (Mining 50-61)
	-- {item:2835} Rough Stone · {skill:186} Mining
	["Mine {item:2835} ({skill:186} 50-61)"] = "",
	-- {item:2835} Rough Stone · {skill:164} Blacksmithing · {skill:186} Mining
	-- plural, as words: Rough Sharpening Stones = {spell:2660} Rough Sharpening Stone
	["111 {item:2835} for {skill:164} 1-50: 111 Rough Sharpening Stones. Mine 111 {item:2835} ({skill:186} 50 to 61), then craft 94 Rough Sharpening Stones ({skill:164} 1 to 50). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 4: Rough Sharpening Stone to 50
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 50"] = "",
	-- {spell:2660} Rough Sharpening Stone · {item:2835} Rough Stone
	["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 94 crafts to 50, up to 111 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "",

	-- Step 5: Mining 61-65: Chunk of Amber & Poor Copper
	-- {skill:186} Mining · {object:656332} Chunk of Amber
	["{skill:186} 61-65: {object:656332} & Poor Copper"] = "",
	-- {skill:186} Mining · {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone · {item:2770} Copper Ore · {item:2835} Rough Stone
	["{skill:186} 61 to 65 before {spell:3326}: its {item:2836} come from {skill:186} 65. The loop also gives about 20 {item:2770} and 15 {item:2835}: keep them, the next stretches use them. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 6: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "",
	-- {skill:186} Mining
	["Journeyman {skill:186} raises {skill:186}'s cap to 150, needs {skill:186} 50 and costs 5s (the arrow picks the nearest {skill:186} trainer of your faction)."] = "",

	-- Step 7: Smelt Bronze & Smelt Tin
	-- {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["A {skill:186} trainer also teaches {spell:2659} (2s) and {spell:3304} (50c): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 8: Mining 65-125: Tin
	-- {skill:186} Mining
	["{skill:186} 65-125: Tin"] = "",
	-- {skill:186} Mining · {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone
	["Mine from {skill:186} 65 to 125 for {spell:3326}: this loop gives {item:2836}, and the next one the rest from {skill:186} 125. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 9: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises {skill:186}'s cap to 225, needs {skill:186} 125 and costs 50s (the arrow picks the nearest {skill:186} trainer of your faction); learn {spell:3307} (5s) there too."] = "",

	-- Step 10: Mining 125-155: Iron
	-- {skill:186} Mining
	["{skill:186} 125-155: Iron"] = "",
	-- {skill:186} Mining · {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone
	["Mine from {skill:186} 125 to 155 for {spell:3326}: this loop gives {item:2836}, and the next one the rest from {skill:186} 155. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 11: Mine Coarse Stone
	-- {item:2836} Coarse Stone
	["Mine {item:2836}"] = "",
	-- {item:2836} Coarse Stone · {skill:164} Blacksmithing · {skill:186} Mining
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone
	["92 {item:2836} for {skill:164} 50-75: 46 Coarse Grinding Stones. Mine 92 {item:2836} at the loops of {skill:186} 65-125, the richest in it (they give no more points), then craft 39 Coarse Grinding Stones ({skill:164} 50 to 75). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 12: Blacksmithing recipes at 50
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 50"] = "",
	-- {skill:164} Blacksmithing · {spell:3326} Coarse Grinding Stone · {spell:1230171} Sharpening Wheel · {item:2835} Rough Stone · {item:2840} Copper Bar · {skill:186} Mining · {spell:3308} Smelt Gold
	["Back to a {skill:164} trainer: {spell:3326} (from 50, 2s 50c). Also learn {spell:1230171} (1s): Forever's {skill:164} camp item, 1 {item:2835} and 1 {item:2840}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:164} quest from your starting area's camping guide (after The Great Outdoors) sends you to a blacksmithing trainer who teaches it free. A {skill:186} trainer also teaches {spell:3308} (25s): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 13: Coarse Grinding Stone to 75
	-- {spell:3326} Coarse Grinding Stone
	["{spell:3326} to 75"] = "",
	-- {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone
	["{spell:3326} is yellow at 50 (yellow 50, green 70, grey 90): about 39 crafts to 75, up to 46 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:2836}. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 14: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "",
	-- {skill:164} Blacksmithing · {npc:3136} Clarise Gnarltree · {zone:1431} Duskwood · {npc:252479} Daeann Steelwind · {zone:2521} Zephras Isle · {npc:10276} Rotgath Stonebeard · {zone:1455} Ironforge · {npc:5511} Therum Deepforge · {zone:1453} Stormwind City · {npc:276067} Angus Hammerhand · {zone:1420} Tirisfal Glades · {npc:4596} James Van Brunt · {zone:1458} Undercity · {npc:2998} Karn Stonehoof · {zone:1456} Thunder Bluff · {npc:1383} Snarl · {zone:1454} Orgrimmar · {npc:3478} Traugh · {zone:1413} The Barrens · {spell:2666} Runed Copper Belt · {item:2319} Medium Leather · {item:2840} Copper Bar · {item:2841} Bronze Bar
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s). 75-150 takes about 9s 50c of recipes and 5g 18c of vendor goods, plus 25 {item:2319}, 320 {item:2840} and 325 {item:2841} to gather or buy."] = "",

	-- Step 15: Blacksmithing 75-150: vendor goods
	-- {skill:164} Blacksmithing
	["{skill:164} 75-150: vendor goods"] = "",
	-- {item:3466} Strong Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:1286} Edna Mullby · {npc:5512} Kaita Deepforge · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {npc:3413} Sovik
	["Buy the whole bracket's share in one go: 25 {item:3466} (5g) and {item:5956} (a tool: one, kept in your bags, 18c); about 5g 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "",
	["a tool, keep it in your bags"] = "",

	-- Step 16: Get Medium Leather
	-- {item:2319} Medium Leather
	["Get {item:2319}"] = "",
	-- {item:2319} Medium Leather · {skill:164} Blacksmithing · {skill:393} Skinning
	-- plural, as words: Bronze Warhammers = {item:7956} Bronze Warhammer
	["25 {item:2319} for {skill:164} 75-150: 25 Bronze Warhammers. {skill:393}: beasts of level 18-30. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 17: Mine Copper Ore, smelt Copper Bar
	-- {item:2770} Copper Ore · {item:2840} Copper Bar
	["Mine {item:2770}, smelt {item:2840}"] = "",
	-- {item:2840} Copper Bar · {skill:164} Blacksmithing · {item:2770} Copper Ore · {skill:186} Mining
	-- plural, as words: Runed Copper Belts = {spell:2666} Runed Copper Belt
	["320 {item:2840} for {skill:164} 75-100: 32 Runed Copper Belts; from your mining on the way: 236 of 320 {item:2770}. Mine 85 {item:2770} at the loops of {skill:186} 1-50, the richest in it (they give no more points), smelt 320 {item:2840} at a forge, then craft 29 Runed Copper Belts ({skill:164} 75 to 100). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 18: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "",
	-- {spell:2666} Runed Copper Belt · {item:2840} Copper Bar · {item:2770} Copper Ore · {item:5956} Blacksmith Hammer
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:2666} is orange at 75 (yellow 85, green 105, grey 125): about 29 crafts to 100, up to 32 for 9 players in 10 (the gathered materials above count that many). Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "",

	-- Step 19: Mine Coarse Stone, Copper Ore and Tin Ore, smelt Bronze Bar
	-- {item:2836} Coarse Stone · {item:2770} Copper Ore · {item:2771} Tin Ore · {item:2841} Bronze Bar
	["Mine {item:2836}, {item:2770} and {item:2771}, smelt {item:2841}"] = "",
	-- {item:2836} Coarse Stone · {item:2841} Bronze Bar · {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers · {item:2771} Tin Ore · {item:2770} Copper Ore · {skill:186} Mining
	["22 {item:2836} and 125 {item:2841} for {skill:164} 100-125: 25 {spell:2672}; from your mining on the way: 63 of 63 {item:2771}. Mine 22 {item:2836} and 63 {item:2770} at the loops of {skill:186} 1-50, the richest in it (they give no more points), smelt 125 {item:2841} at a forge, then craft 25 {spell:2672} ({skill:164} 100 to 125). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 20: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s) and {spell:9985} (from 100, 2s 50c)."] = "",

	-- Step 21: Patterned Bronze Bracers to 125
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 125"] = "",
	-- {spell:2672} Patterned Bronze Bracers · {item:2841} Bronze Bar · {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone · Tin Veins = {object:1732} Tin Vein
	["{spell:2672} is orange at 100 (yellow 125, green 140, grey 155): about 25 crafts to 125, a point every craft. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 11 {spell:3326} first. Use the 39 {spell:3326} you made earlier; the counts above leave them out. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. If you got here without learning {spell:3326}, learn it now: an earlier step teaches it."] = "",

	-- Step 22: Mine Copper Ore and Tin Ore, smelt Bronze Bar
	-- {item:2770} Copper Ore · {item:2771} Tin Ore · {item:2841} Bronze Bar
	["Mine {item:2770} and {item:2771}, smelt {item:2841}"] = "",
	-- {item:2841} Bronze Bar · {skill:164} Blacksmithing · {item:2770} Copper Ore · {item:2771} Tin Ore · {skill:186} Mining
	-- plural, as words: Bronze Warhammers = {item:7956} Bronze Warhammer
	["200 {item:2841} for {skill:164} 125-150: 25 Bronze Warhammers; from your mining on the way: 27 of 100 {item:2770} and 100 of 100 {item:2771}. Mine 73 {item:2770} at the loops of {skill:186} 1-50, the richest in it (they give no more points), smelt 200 {item:2841} at a forge, then craft 25 Bronze Warhammers ({skill:164} 125 to 150). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 23: Bronze Warhammer to 150
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 150"] = "",
	-- {item:7956} Bronze Warhammer · {item:2841} Bronze Bar · {item:3466} Strong Flux · {item:2319} Medium Leather · {skill:164} Blacksmithing
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["{item:7956} is orange at 125 (yellow 155, green 170, grey 185): about 25 crafts to 150, a point every craft. Each takes 8 {item:2841}, 1 {item:3466} and 1 {item:2319}. Eight Bronze Bars, a {item:3466} (blacksmithing suppliers) and a {item:2319} a craft; every Journeyman trainer in the capitals teaches it from 100. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "",

	-- Step 24: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "",
	-- {skill:164} Blacksmithing · {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:3501} Green Iron Bracers · {spell:3337} Heavy Grinding Stone · {item:2838} Heavy Stone · {item:3575} Iron Bar · {item:3859} Steel Bar · {item:3860} Mithril Bar · {item:4304} Thick Leather · {item:4338} Mageweave Cloth · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). This route trains it at {npc:4258} ({zone:1455}) for the Alliance and {npc:3355} ({zone:1454}) for the Horde, who also teach the recipes of 150-225: one trainer for every visit. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 60 {item:2838}, 186 {item:3575}, 302 {item:3859}, 230 {item:3860}, 84 {item:4304}, 60 {item:4338} and 72 {item:7912} to gather or buy."] = "",

	-- Step 25: Blacksmithing 150-225: vendor goods
	-- {skill:164} Blacksmithing
	["{skill:164} 150-225: vendor goods"] = "",
	-- {item:2605} Green Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {item:3859} Steel Bar · {skill:186} Mining · {item:3575} Iron Bar
	["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: Borya, {npc:3367} and {npc:5817}). If you smelt the 302 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 302 Coal too (15g 10s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "",

	-- Step 26: Get Thick Leather
	-- {item:4304} Thick Leather
	["Get {item:4304}"] = "",
	-- {item:4304} Thick Leather · {skill:164} Blacksmithing · {item:7933} Heavy Mithril Boots · {skill:393} Skinning
	["84 {item:4304} for {skill:164} 150-225: 21 {item:7933} (44 of them for 225-300: get them all now). {skill:393}: beasts of level 38-50. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 27: Get Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get {item:4338}"] = "",
	-- {item:4338} Mageweave Cloth · {skill:164} Blacksmithing
	-- plural, as words: Heavy Mithril Gauntlets = {item:7919} Heavy Mithril Gauntlet
	["60 {item:4338} for {skill:164} 150-225: 15 Heavy Mithril Gauntlets. Humanoids of level 35-50 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:4338} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 28: Mining 155-175: Iron
	-- {skill:186} Mining
	["{skill:186} 155-175: Iron"] = "",
	-- {skill:186} Mining · {spell:3501} Green Iron Bracers · {item:2772} Iron Ore
	["Mine from {skill:186} 155 to 175 for {spell:3501}: this loop gives {item:2772}, and the next one the rest from {skill:186} 175. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 29: Mining 175-200: Mithril
	-- {skill:186} Mining
	["{skill:186} 175-200: Mithril"] = "",
	-- {skill:186} Mining · {spell:3501} Green Iron Bracers · {item:2772} Iron Ore
	["Mine from {skill:186} 175 to 200 for {spell:3501}: this loop gives {item:2772}, and the next one the rest from {skill:186} 200. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 30: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "",
	-- {skill:186} Mining
	["Artisan {skill:186} raises {skill:186}'s cap to 300, needs {skill:186} 200 and costs 5g (the arrow picks the nearest {skill:186} trainer of your faction)."] = "",

	-- Step 31: Mining 200-230: Mithril
	-- {skill:186} Mining
	["{skill:186} 200-230: Mithril"] = "",
	-- {skill:186} Mining · {spell:3501} Green Iron Bracers · {item:2772} Iron Ore
	["Mine from {skill:186} 200 to 230 for {spell:3501}: this loop gives {item:2772}, and the next one the rest from {skill:186} 230. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 32: Mine Iron Ore, smelt Iron Bar
	-- {item:2772} Iron Ore · {item:3575} Iron Bar
	["Mine {item:2772}, smelt {item:3575}"] = "",
	-- {item:3575} Iron Bar · {skill:164} Blacksmithing · {spell:3501} Green Iron Bracers · {item:2772} Iron Ore · {skill:186} Mining
	["186 {item:3575} for {skill:164} 150-175: 31 {spell:3501}; from your mining on the way: 28 of 186 {item:2772}. Mine 158 {item:2772} at the loops of {skill:186} 155-175, the richest in it (they give no more points), smelt 186 {item:3575} at a forge, then craft 28 {spell:3501} ({skill:164} 150 to 175). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 33: Green Iron Bracers to 175
	-- {spell:3501} Green Iron Bracers
	["{spell:3501} to 175"] = "",
	-- {spell:3501} Green Iron Bracers · {item:3575} Iron Bar · {item:2605} Green Dye
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175, up to 31 for 9 players in 10 (the gathered materials above count that many). Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "",

	-- Step 34: Smelt Steel
	-- {skill:186} Mining · {spell:3569} Smelt Steel
	["A {skill:186} trainer teaches {spell:3569} ({skill:186} 165, 25s): the bars of the next stretch are smelted from what you mine."] = "",

	-- Step 35: Mine Heavy Stone and Iron Ore, smelt Steel Bar
	-- {item:2838} Heavy Stone · {item:2772} Iron Ore · {item:3859} Steel Bar
	["Mine {item:2838} and {item:2772}, smelt {item:3859}"] = "",
	-- {item:2838} Heavy Stone · {item:3859} Steel Bar · {skill:164} Blacksmithing · {item:6040} Golden Scale Bracers · {item:2772} Iron Ore · {skill:186} Mining
	["60 {item:2838} and 50 {item:3859} for {skill:164} 175-185: 10 {item:6040}; from your mining on the way: 60 of 60 {item:2838}. Mine 50 {item:2772} at the loops of {skill:186} 155-175, the richest in it (they give no more points), smelt 50 {item:3859} at a forge, then craft 10 {item:6040} ({skill:164} 175 to 185). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 36: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:7223} Golden Scale Bracers · {spell:9920} Solid Grinding Stone
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:7223} (from 160) and {spell:9920} (from 175)."] = "",

	-- Step 37: Golden Scale Bracers to 185
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 185"] = "",
	-- {item:6040} Golden Scale Bracers · {item:3859} Steel Bar · {spell:3337} Heavy Grinding Stone · {item:3575} Iron Bar · {skill:186} Mining
	-- plural, as words: Steel Bars = {item:3859} Steel Bar · Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone
	["{item:6040} is orange at 175 (yellow 185, green 197, grey 210): about 10 crafts to 185, a point every craft. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 20 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Needs an anvil nearby."] = "",

	-- Step 38: Smelt Mithril
	-- {skill:186} Mining · {spell:10097} Smelt Mithril
	["A {skill:186} trainer teaches {spell:10097} ({skill:186} 175, 50s): the bars of the next stretch are smelted from what you mine."] = "",

	-- Step 39: Mine Mithril Ore, smelt Mithril Bar (Mining 230-237)
	-- {item:3858} Mithril Ore · {item:3860} Mithril Bar · {skill:186} Mining
	["Mine {item:3858}, smelt {item:3860} ({skill:186} 230-237)"] = "",
	-- {item:3860} Mithril Bar · {skill:164} Blacksmithing · {item:3858} Mithril Ore · {skill:186} Mining
	-- plural, as words: Heavy Mithril Gauntlets = {item:7919} Heavy Mithril Gauntlet
	["90 {item:3860} for {skill:164} 185-200: 15 Heavy Mithril Gauntlets; from your mining on the way: 68 of 90 {item:3858}. Mine 23 {item:3858} ({skill:186} 230 to 237), smelt 90 {item:3860} at a forge, then craft 15 Heavy Mithril Gauntlets ({skill:164} 185 to 200). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 40: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:9928} Heavy Mithril Gauntlet
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:9928} (from 180)."] = "",

	-- Step 41: Heavy Mithril Gauntlet to 200
	-- {item:7919} Heavy Mithril Gauntlet
	["{item:7919} to 200"] = "",
	-- {item:7919} Heavy Mithril Gauntlet · {item:3860} Mithril Bar · {item:4338} Mageweave Cloth · {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:7919} is orange at 185 (yellow 200, green 210, grey 220): about 15 crafts to 200, a point every craft. Each takes 6 {item:3860} and 4 {item:4338}. Six Mithril Bars and four {item:4338} a craft; {npc:4258} ({zone:1455}) and {npc:3355} ({zone:1454}) teach it from 180. Needs an anvil nearby."] = "",

	-- Step 42: Mine Iron Ore and Solid Stone, smelt Steel Bar
	-- {item:2772} Iron Ore · {item:7912} Solid Stone · {item:3859} Steel Bar
	["Mine {item:2772} and {item:7912}, smelt {item:3859}"] = "",
	-- {item:3859} Steel Bar · {item:7912} Solid Stone · {skill:164} Blacksmithing · {item:2772} Iron Ore · {skill:186} Mining
	-- plural, as words: Steel Plate Helms = {item:7922} Steel Plate Helm
	["252 {item:3859} and 72 {item:7912} for {skill:164} 200-215: 18 Steel Plate Helms; from your mining on the way: 72 of 72 {item:7912}. Mine 252 {item:2772} at the loops of {skill:186} 155-175, the richest in it (they give no more points), smelt 252 {item:3859} at a forge, then craft 16 Steel Plate Helms ({skill:164} 200 to 215). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 43: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:9935} Steel Plate Helm
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:9935} (from 190)."] = "",

	-- Step 44: Steel Plate Helm to 215
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 215"] = "",
	-- {item:7922} Steel Plate Helm · {item:3859} Steel Bar · {item:7966} Solid Grinding Stone · {npc:5164} Grumnus Steelshaper · {zone:1455} Ironforge · {npc:11177} Okothos Ironrager · {zone:1454} Orgrimmar · {spell:9788} Armorsmith · {item:7936} Ornate Mithril Boots · {item:7935} Ornate Mithril Breastplate · {npc:11146} Ironus Coldsteel · {npc:11178} Borgosh Corebender · {item:3853} Moonsteel Broadsword · {npc:2482} Zarena Cromwind · {area:35} Booty Bay · {item:3855} Massive Iron Axe
	-- plural, as words: Ornate Mithril Helms = {item:7937} Ornate Mithril Helm · Moonsteel Broadswords = {item:3853} Moonsteel Broadsword · Massive Iron Axes = {item:3855} Massive Iron Axe · Heavy Mithril Axes = {item:7940} Heavy Mithril Axe · Big Black Maces = {item:7945} Big Black Mace
	["{item:7922} is orange at 200 (yellow 210, green 220, grey 230): about 16 crafts to 215, up to 18 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:3859} and 1 {item:7966}. Make the 16 {item:7966} first. The trainer teaches it, and it is the cheapest way through these points in the data. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "",

	-- Step 45: Mining 237-245: Mithril & Dark Iron
	-- {skill:186} Mining · {object:147516} Dark Iron
	["{skill:186} 237-245: Mithril & {object:147516}"] = "",
	-- {skill:186} Mining · {item:7933} Heavy Mithril Boots · {item:3858} Mithril Ore
	["Mine from {skill:186} 237 to 245 for {item:7933}: this loop gives {item:3858}, and the next one the rest from {skill:186} 245. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 46: Mine Mithril Ore, smelt Mithril Bar
	-- {item:3858} Mithril Ore · {item:3860} Mithril Bar
	["Mine {item:3858}, smelt {item:3860}"] = "",
	-- {item:3860} Mithril Bar · {skill:164} Blacksmithing · {item:7933} Heavy Mithril Boots · {item:3858} Mithril Ore · {skill:186} Mining
	["140 {item:3860} for {skill:164} 215-225: 10 {item:7933}. Mine 140 {item:3858} at the loops of {skill:186} 230-245, the richest in it (they give no more points), smelt 140 {item:3860} at a forge, then craft 10 {item:7933} ({skill:164} 215 to 225). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 47: Blacksmithing recipes at 215
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 215"] = "",
	-- {spell:9968} Heavy Mithril Boots · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {skill:164} Blacksmithing
	["{spell:9968} (from 210) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "",

	-- Step 48: Heavy Mithril Boots to 225
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 225"] = "",
	-- {item:7933} Heavy Mithril Boots · {item:3860} Mithril Bar · {item:4304} Thick Leather · {skill:164} Blacksmithing
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar · Mithril Deposits = {object:2040} Mithril Deposit
	["{item:7933} is orange at 215 (yellow 230, green 240, grey 250): about 10 crafts to 225, a point every craft. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "",

	-- Step 49: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "",
	-- {skill:164} Blacksmithing · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {spell:16640} Dense Weightstone · {item:3860} Mithril Bar · {item:7909} Aquamarine · {item:7910} Star Ruby · {item:8170} Rugged Leather · {item:12359} Thorium Bar · {item:12365} Dense Stone · {item:7077} Heart of Fire · {npc:14567} Derotain Mudsipper
	["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). This route trains it at {npc:2836} ({zone:1434}) for the Alliance and {npc:2836} ({zone:1434}) for the Horde, who also teach the recipes of 225-300: one trainer for every visit. Learn now: {spell:16640} (from 225). 225-300 takes 154 {item:3860}, 5 {item:7909}, 20 {item:7910}, 30 {item:8170}, 550 {item:12359} and 24 {item:12365} to gather or buy. From 265 the route splits: with Radiant plans, about 36 more crafts and 152 {item:7077} and 586 {item:12359}; with {npc:14567}'s plans, about 40 crafts and 37 {item:7909}, 45 {item:7910} and 1458 {item:12359}."] = "",

	-- Step 50: Get Aquamarine
	-- {item:7909} Aquamarine
	["Get {item:7909}"] = "",
	-- {item:7909} Aquamarine · {skill:164} Blacksmithing · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["5 {item:7909} for {skill:164} 225-300: 5 Imperial Plate Belts. {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 51: Get Star Ruby
	-- {item:7910} Star Ruby
	["Get {item:7910}"] = "",
	-- {item:7910} Star Ruby · {skill:164} Blacksmithing · {item:12425} Imperial Plate Bracers · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	["20 {item:7910} for {skill:164} 225-300: 20 {item:12425}. {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 52: Get Rugged Leather
	-- {item:8170} Rugged Leather
	["Get {item:8170}"] = "",
	-- {item:8170} Rugged Leather · {skill:164} Blacksmithing · {skill:393} Skinning
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["30 {item:8170} for {skill:164} 225-300: 5 Imperial Plate Belts. {skill:393}: beasts of level 48-60. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 53: Mine Dense Stone (Mining 245-272)
	-- {item:12365} Dense Stone · {skill:186} Mining
	["Mine {item:12365} ({skill:186} 245-272)"] = "",
	-- {item:12365} Dense Stone · {skill:164} Blacksmithing · {skill:186} Mining
	-- plural, as words: Dense Weightstones = {item:12643} Dense Weightstone
	["24 {item:12365} for {skill:164} 225-235: 24 Dense Weightstones. Mine 24 {item:12365} ({skill:186} 245 to 272), then craft 17 Dense Weightstones ({skill:164} 225 to 235). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 54: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "",
	-- {item:12643} Dense Weightstone · {item:12365} Dense Stone
	["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235, up to 24 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:12365}. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 55: Mine Mithril Ore, smelt Mithril Bar
	-- {item:3860} Mithril Bar · {skill:164} Blacksmithing · {item:7933} Heavy Mithril Boots · {item:3858} Mithril Ore · {skill:186} Mining
	["154 {item:3860} for {skill:164} 235-240: 11 {item:7933}; from your mining on the way: 10 of 154 {item:3858}. Mine 144 {item:3858} at the loops of {skill:186} 230-245, the richest in it (they give no more points), smelt 154 {item:3860} at a forge, then craft 8 {item:7933} ({skill:164} 235 to 240). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 56: Heavy Mithril Boots to 240
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 240"] = "",
	-- {item:7933} Heavy Mithril Boots · {item:3860} Mithril Bar · {item:4304} Thick Leather
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar · Mithril Deposits = {object:2040} Mithril Deposit
	["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 8 crafts to 240, up to 11 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby. If you got here without learning {item:7933}, learn it now: an earlier step teaches it."] = "",

	-- Step 57: Smelt Thorium
	-- {skill:186} Mining · {spell:16153} Smelt Thorium
	["A {skill:186} trainer teaches {spell:16153} ({skill:186} 250, 2g): the bars of the next stretch are smelted from what you mine."] = "",

	-- Step 58: Mining 272-275: Small Thorium
	-- {skill:186} Mining
	["{skill:186} 272-275: Small Thorium"] = "",
	-- {skill:186} Mining · {quest:7653} Imperial Plate Belt · {item:10620} Thorium Ore
	["Mine from {skill:186} 272 to 275 for {quest:7653}: this loop gives {item:10620}, and the next one the rest from {skill:186} 275. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 59: Mining 275-300: Small Thorium & Rich Thorium
	-- {skill:186} Mining
	["{skill:186} 275-300: Small Thorium & Rich Thorium"] = "",
	-- {skill:186} Mining · {quest:7653} Imperial Plate Belt · {item:10620} Thorium Ore
	["Mine from {skill:186} 275 to 300 for {quest:7653}: this loop gives {item:10620}, and the next one the rest from {skill:186} 300. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 60: Mine Thorium Ore, smelt Thorium Bar
	-- {item:10620} Thorium Ore · {item:12359} Thorium Bar
	["Mine {item:10620}, smelt {item:12359}"] = "",
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:10620} Thorium Ore · {skill:186} Mining
	-- plural, as words: Imperial Plate Belts = {quest:7653} Imperial Plate Belt
	["130 {item:12359} for {skill:164} 240-245: 5 Imperial Plate Belts; from your mining on the way: 25 of 130 {item:10620}. Mine 105 {item:10620} at the loops of {skill:186} 275-300, the richest in it (they give no more points), smelt 130 {item:12359} at a forge, then craft 5 Imperial Plate Belts ({skill:164} 240 to 245). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 61: Plans: Imperial Plate Belt and Plans: Imperial Plate Bracers
	-- {item:12688} Plans: Imperial Plate Belt · {item:12690} Plans: Imperial Plate Bracers
	["{item:12688} and {item:12690}"] = "",
	-- {npc:14567} Derotain Mudsipper · {zone:1446} Tanaris · {item:12688} Plans: Imperial Plate Belt · {skill:164} Blacksmithing · {item:12359} Thorium Bar · {quest:7653} Imperial Plate Belt · {item:12690} Plans: Imperial Plate Bracers · {quest:7655} Imperial Plate Bracer · {quest:7652} A Blue Light Bargain · {item:12425} Imperial Plate Bracers
	["{npc:14567} ({zone:1446}) trades {item:12688} ({skill:164} 240) for 20 {item:12359} in {quest:7653} and {item:12690} ({skill:164} 245) for 20 {item:12359} in {quest:7655}, which need {skill:164} 240 and character level 50; take {quest:7652} first (it asks for nothing). The plans bind when picked up. Take the {item:12690} now too: they wait in your bags until 245 for {item:12425}, and it saves a trip back."] = "",

	-- Step 62: Imperial Plate Belt to 245
	-- {item:12424} Imperial Plate Belt
	["{item:12424} to 245"] = "",
	-- {item:12424} Imperial Plate Belt · {item:12359} Thorium Bar · {item:8170} Rugged Leather · {item:7909} Aquamarine
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12424} is orange at 240 (yellow 260, green 270, grey 280): about 5 crafts to 245, a point every craft. Each takes 22 {item:12359}, 6 {item:8170} and 1 {item:7909}. Twenty-two Thorium Bars, six {item:8170} and an {item:7909} a craft, orange from 240: five points, until the bracers plans can be learned at 245. Needs an anvil nearby."] = "",
	["from the recipe in your bags"] = "",

	-- Step 63: Mine Thorium Ore, smelt Thorium Bar
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12425} Imperial Plate Bracers · {item:10620} Thorium Ore · {skill:186} Mining
	["420 {item:12359} for {skill:164} 245-265: 20 {item:12425}. Mine 420 {item:10620} at the loops of {skill:186} 275-300, the richest in it (they give no more points), smelt 420 {item:12359} at a forge, then craft 20 {item:12425} ({skill:164} 245 to 265). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 64: Imperial Plate Bracers to 265
	-- {item:12425} Imperial Plate Bracers
	["{item:12425} to 265"] = "",
	-- {item:12425} Imperial Plate Bracers · {item:12359} Thorium Bar · {item:7910} Star Ruby · {npc:14567} Derotain Mudsipper
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12425} is orange at 245 (yellow 265, green 275, grey 285): about 20 crafts to 265, a point every craft. Each takes 20 {item:12359} and 1 {item:7910}. Twenty Thorium Bars and a {item:7910} a craft, orange to 265: the fewest Thorium Bars a point {npc:14567}'s plans give. Needs an anvil nearby."] = "",

	-- Step 65: Blacksmithing 265: Plans: Radiant Boots
	-- {item:12697} Plans: Radiant Boots · {item:12713} Plans: Radiant Leggings · {spell:16656} Radiant Boots · {item:12420} Radiant Leggings · {npc:14567} Derotain Mudsipper · {quest:7654} Imperial Plate Boots
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["From 265 the route has two ways. {item:12697} and {item:12713} drop from mobs all over the world and do not bind, so the Auction House often lists them: with them, {spell:16656} (orange to 285) and then {item:12420} take you to 300 on about half the Thorium Bars, with Hearts of Fire. No plans for sale? Skip this step: the next steps go on with {npc:14567}'s {quest:7654}, about 34 Thorium Bars a craft. Buy the boots plans whenever they turn up."] = "",

	-- Step 66: Get Heart of Fire
	-- {item:7077} Heart of Fire
	["Get {item:7077}"] = "",
	-- {item:7077} Heart of Fire · {skill:164} Blacksmithing · {item:12419} Radiant Boots · {item:12420} Radiant Leggings · {npc:9878} Entropic Beast · {npc:6520} Scorching Elemental · {npc:5855} Magma Elemental
	["152 {item:7077} for {skill:164} 265-300: 29 {item:12419} and 9 {item:12420}. {item:7077} drops most from {npc:9878}, {npc:6520} and {npc:5855}, among others. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:7077} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 67: Blacksmithing 265-300: Auction House
	-- {skill:164} Blacksmithing
	["{skill:164} 265-300: Auction House"] = "",
	-- {item:12713} Plans: Radiant Leggings
	["What 265-300 takes that the Auction House sells and no step above farms: a {item:12713}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 68: Mine Thorium Ore, smelt Thorium Bar
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12419} Radiant Boots · {item:10620} Thorium Ore · {skill:186} Mining
	["406 {item:12359} for {skill:164} 265-291: 29 {item:12419}. Mine 406 {item:10620} at the loops of {skill:186} 275-300, the richest in it (they give no more points), smelt 406 {item:12359} at a forge, then craft 27 {item:12419} ({skill:164} 265 to 291). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 69: Radiant Boots to 291
	-- {item:12419} Radiant Boots
	["{item:12419} to 291"] = "",
	-- {item:12419} Radiant Boots · {item:12359} Thorium Bar · {item:7077} Heart of Fire · {item:12697} Plans: Radiant Boots
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12419} is orange at 265 (yellow 285, green 295, grey 305): about 27 crafts to 291, up to 29 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:12359} and 4 {item:7077}. Its pattern ({item:12697}) drops from mobs all over the world and does not bind: buy it at the Auction House. Fourteen Thorium Bars and four Hearts of Fire a craft; orange to 285. Needs an anvil nearby."] = "",

	-- Step 70: Mine Thorium Ore, smelt Thorium Bar
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12420} Radiant Leggings · {item:10620} Thorium Ore · {skill:186} Mining
	["180 {item:12359} for {skill:164} 291-300: 9 {item:12420}. Mine 180 {item:10620} at the loops of {skill:186} 275-300, the richest in it (they give no more points), smelt 180 {item:12359} at a forge, then craft 9 {item:12420} ({skill:164} 291 to 300). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 71: Radiant Leggings to 300
	-- {item:12420} Radiant Leggings
	["{item:12420} to 300"] = "",
	-- {item:12420} Radiant Leggings · {item:12359} Thorium Bar · {item:7077} Heart of Fire · {item:12713} Plans: Radiant Leggings · {skill:164} Blacksmithing
	["{item:12420} is orange at 291 (yellow 300, green 310, grey 320): about 9 crafts to 300, a point every craft. Each takes 20 {item:12359} and 4 {item:7077}. Its pattern ({item:12713}) drops from mobs all over the world and does not bind: buy it at the Auction House. The last points: buy the plans when you reach 280; until then the boots carry you. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "",
	["from the pattern bought at the Auction House"] = "",

	-- Step 72: Get Aquamarine
	-- {item:7909} Aquamarine · {skill:164} Blacksmithing · {quest:7654} Imperial Plate Boots · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	["37 {item:7909} for {skill:164} 265-300: 37 {quest:7654}. {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 73: Get Star Ruby
	-- {item:7910} Star Ruby · {skill:164} Blacksmithing · {item:12425} Imperial Plate Bracers · {quest:7654} Imperial Plate Boots · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	["45 {item:7910} for {skill:164} 265-300: 8 {item:12425} and 37 {quest:7654}. {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 74: Mine Thorium Ore, smelt Thorium Bar
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12425} Imperial Plate Bracers · {item:10620} Thorium Ore · {skill:186} Mining
	["160 {item:12359} for {skill:164} 265-270: 8 {item:12425}. Mine 160 {item:10620} at the loops of {skill:186} 275-300, the richest in it (they give no more points), smelt 160 {item:12359} at a forge, then craft 6 {item:12425} ({skill:164} 265 to 270). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 75: Imperial Plate Bracers to 270
	-- {item:12425} Imperial Plate Bracers
	["{item:12425} to 270"] = "",
	-- {item:12425} Imperial Plate Bracers · {item:12359} Thorium Bar · {item:7910} Star Ruby
	["{item:12425} is yellow at 265 (yellow 265, green 275, grey 285): about 6 crafts to 270, up to 8 for 9 players in 10 (the gathered materials above count that many). Each takes 20 {item:12359} and 1 {item:7910}. Yellow from 265, so not every craft gives a point; five more points, until the boots plans can be used at 270. Needs an anvil nearby. If you got here without learning {item:12425}, learn it now: an earlier step teaches it."] = "",

	-- Step 76: Mine Thorium Ore, smelt Thorium Bar
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {quest:7654} Imperial Plate Boots · {item:10620} Thorium Ore · {skill:186} Mining
	["1298 {item:12359} for {skill:164} 270-300: 37 {quest:7654}. Mine 1298 {item:10620} at the loops of {skill:186} 275-300, the richest in it (they give no more points), smelt 1298 {item:12359} at a forge, then craft 34 {quest:7654} ({skill:164} 270 to 300). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 77: Plans: Imperial Plate Boots
	-- {npc:14567} Derotain Mudsipper · {zone:1446} Tanaris · {item:12700} Plans: Imperial Plate Boots · {skill:164} Blacksmithing · {item:12359} Thorium Bar · {quest:7654} Imperial Plate Boots
	["{npc:14567} ({zone:1446}) trades {item:12700} ({skill:164} 270) for 40 {item:12359} in {quest:7654}, which needs {skill:164} 240 and character level 50. The plans bind when picked up."] = "",

	-- Step 78: Imperial Plate Boots to 300
	-- {item:12426} Imperial Plate Boots
	["{item:12426} to 300"] = "",
	-- {item:12426} Imperial Plate Boots · {item:12359} Thorium Bar · {item:7910} Star Ruby · {item:7909} Aquamarine · {skill:164} Blacksmithing
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12426} is orange at 270 (yellow 290, green 300, grey 310): about 34 crafts to 300, up to 37 for 9 players in 10 (the gathered materials above count that many). Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. Thirty-four Thorium Bars, a {item:7910} and an {item:7909} a craft, orange to 290: the plans you can always get past 270. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "",
}
