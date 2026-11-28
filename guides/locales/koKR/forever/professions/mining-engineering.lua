-- Korean (koKR): the guide forever/professions/mining-engineering (forever/professions/mining-engineering.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining and Engineering
	-- {skill:186} Mining · {skill:202} Engineering
	["Learn {skill:186} and {skill:202}"] = "",
	-- {skill:202} Engineering · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore · {item:2840} Copper Bar · {item:2901} Mining Pick
	["Apprentice {skill:202} lets you craft up to 75 for 10c, at any character level. Any {skill:202} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} and pair it with {skill:186}: {item:2835} and {item:2770} are the first parts. 1-75 takes about 4s 15c of recipes and 16s 18c of vendor goods, plus 36 {item:2835} and 101 {item:2840} to gather or buy. Learn Apprentice {skill:186} on the same trip: any {skill:186} trainer of your faction teaches it at any level, and the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "",

	-- Step 2: Engineering 1-75: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 1-75: vendor goods"] = "",
	-- {item:2880} Weak Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:1286} Edna Mullby · {npc:5512} Kaita Deepforge
	["Buy the whole bracket's share in one go: 16 {item:2880} (16s) and {item:5956} (a tool: one, kept in your bags, 18c); about 16s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512})."] = "",
	["a tool, keep it in your bags"] = "",

	-- Step 3: Mine Rough Stone (Mining 1-41)
	-- {item:2835} Rough Stone · {skill:186} Mining
	["Mine {item:2835} ({skill:186} 1-41)"] = "",
	-- {item:2835} Rough Stone · {skill:202} Engineering · {spell:3918} Rough Blasting Powder · {skill:186} Mining
	["36 {item:2835} for {skill:202} 1-30: 36 {spell:3918}. Mine 36 {item:2835} ({skill:186} 1 to 41), then craft 33 {spell:3918} ({skill:202} 1 to 30). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 4: Rough Blasting Powder to 30
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 30"] = "",
	-- {spell:3918} Rough Blasting Powder · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["{spell:3918} is orange at 1 (yellow 20, green 30, grey 40): about 33 crafts to 30, up to 36 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2835}. One {item:2835} a craft; {item:2835} comes with the {item:2770} from Copper Veins."] = "",

	-- Step 5: Mining 41-50: Copper & Large Chunk of Amber
	-- {skill:186} Mining · {object:656333} Large Chunk of Amber
	["{skill:186} 41-50: Copper & {object:656333}"] = "",
	-- {skill:186} Mining · {spell:3922} Handful of Copper Bolts · {item:2770} Copper Ore
	["Mine from {skill:186} 41 to 50 for {spell:3922}: this area gives {item:2770}, and the next one the rest from {skill:186} 50. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 6: Mine Copper Ore, smelt Copper Bar
	-- {item:2770} Copper Ore · {item:2840} Copper Bar
	["Mine {item:2770}, smelt {item:2840}"] = "",
	-- {item:2840} Copper Bar · {skill:202} Engineering · {item:2770} Copper Ore · {skill:186} Mining
	["63 {item:2840} for {skill:202} 30-59: 63 Handfuls of Copper Bolts; from your mining on the way: 49 of 63 {item:2770}. Mine 15 {item:2770} ({skill:186} 50), smelt 63 {item:2840} at a forge, then craft 50 Handfuls of Copper Bolts ({skill:202} 30 to 59). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 7: Engineering recipes at 30
	-- {skill:202} Engineering
	["{skill:202} recipes at 30"] = "",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {spell:1230656} Reagent Bot · {spell:3924} Copper Tube · {skill:186} Mining
	["Back to an {skill:202} trainer: {spell:3922} (from 30, 1s 15c). Also learn {spell:1230656} (1s): Forever's {skill:202} camp item, placed at a campsite beside a campfire. It takes a {spell:3922} and a {spell:3924}, which you learn at 30 and 50, so it gives no points. The Camping 101: {skill:202} quest from your starting area's camping guide (after The Great Outdoors) sends you to an engineering trainer who teaches it free. Train Journeyman {skill:186} on this visit too: it raises {skill:186}'s cap to 150, needs {skill:186} 50 and costs 5s (the arrow picks the nearest {skill:186} trainer of your faction)."] = "",

	-- Step 8: Handful of Copper Bolts to 59
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 59"] = "",
	-- {spell:3922} Handful of Copper Bolts · {item:2840} Copper Bar · {item:5956} Blacksmith Hammer
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{spell:3922} is orange at 30 (yellow 45, green 52, grey 60): about 50 crafts to 59, up to 63 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2840}. One {item:2840} a craft. Keep the bolts: Practice Locks and later gadgets take them. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "",

	-- Step 9: Mine Copper Ore, smelt Copper Bar (Mining 50-57)
	-- {item:2770} Copper Ore · {item:2840} Copper Bar · {skill:186} Mining
	["Mine {item:2770}, smelt {item:2840} ({skill:186} 50-57)"] = "",
	-- {item:2840} Copper Bar · {skill:202} Engineering · {item:2770} Copper Ore · {skill:186} Mining
	-- plural, as words: Copper Tubes = {spell:3924} Copper Tube
	["38 {item:2840} for {skill:202} 59-75: 16 Copper Tubes. Mine 38 {item:2770} ({skill:186} 50 to 57), smelt 38 {item:2840} at a forge, then craft 16 Copper Tubes ({skill:202} 59 to 75). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 10: Engineering recipes at 59
	-- {skill:202} Engineering
	["{skill:202} recipes at 59"] = "",
	-- {skill:202} Engineering · {spell:7430} Arclight Spanner · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:7430} (from 50, 1s 50c) and {spell:3924} (from 50, 1s 50c)."] = "",

	-- Step 11: Copper Tube to 75
	-- {spell:3924} Copper Tube
	["{spell:3924} to 75"] = "",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux · {item:6219} Arclight Spanner
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is orange at 59 (yellow 80, green 95, grey 110): about 16 crafts to 75, a point every craft. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. Make the {item:6219} now, while it still gives a point: a later recipe needs it in your bags, so keep it there."] = "",
	["a tool: keep it in your bags"] = "",

	-- Step 12: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "",
	-- {skill:202} Engineering · {npc:1676} Finbus Geargrind · {zone:1431} Duskwood · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:11029} Trixie Quikswitch · {zone:1455} Ironforge · {npc:11031} Franklin Lloyd · {zone:1458} Undercity · {spell:3929} Coarse Blasting Powder · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}) and {npc:11029} ({zone:1455}); Horde {npc:11031} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c). 75-150 takes about 2s 50c of recipes and 45s of vendor goods, plus 47 {item:2836}, 113 {item:2838}, 62 {item:2840}, 63 {item:2841} and 3 {item:2842} to gather or buy."] = "",

	-- Step 13: Engineering 75-150: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 75-150: vendor goods"] = "",
	-- {item:2880} Weak Flux · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 45 {item:2880} (45s); about 45s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286})."] = "",

	-- Step 14: Get Silver Bar
	-- {item:2842} Silver Bar
	["Get {item:2842}"] = "",
	-- {item:2842} Silver Bar · {skill:202} Engineering · {skill:186} Mining · {item:2775} Silver Ore
	-- plural, as words: Big Bronze Bombs = {spell:3950} Big Bronze Bomb
	["3 {item:2842} for {skill:202} 75-150: 9 Big Bronze Bombs. {skill:186}: smelt {item:2775}. Or buy them at the Auction House."] = "",

	-- Step 15: Mining 57-65: Copper & Large Chunk of Amber
	-- {skill:186} Mining · {object:656333} Large Chunk of Amber
	["{skill:186} 57-65: Copper & {object:656333}"] = "",
	-- {skill:186} Mining · {spell:3929} Coarse Blasting Powder · {item:2836} Coarse Stone · {item:2770} Copper Ore · {item:2835} Rough Stone
	["{skill:186} 57 to 65 before {spell:3929}: its {item:2836} come from {skill:186} 65. The area also gives about 35 {item:2770} and 30 {item:2835}: keep them, the next stretches use them. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 16: Mine Coarse Stone (Mining 65-114)
	-- {item:2836} Coarse Stone · {skill:186} Mining
	["Mine {item:2836} ({skill:186} 65-114)"] = "",
	-- {item:2836} Coarse Stone · {skill:202} Engineering · {spell:3929} Coarse Blasting Powder · {skill:186} Mining
	["38 {item:2836} for {skill:202} 75-94: 38 {spell:3929}. Mine 38 {item:2836} ({skill:186} 65 to 114), then craft 30 {spell:3929} ({skill:202} 75 to 94). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 17: Coarse Blasting Powder to 94
	-- {spell:3929} Coarse Blasting Powder
	["{spell:3929} to 94"] = "",
	-- {spell:3929} Coarse Blasting Powder · {item:2836} Coarse Stone
	-- plural, as words: Tin Veins = {object:1732} Tin Vein
	["{spell:3929} is orange at 75 (yellow 85, green 90, grey 95): about 30 crafts to 94, up to 38 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2836}. One {item:2836} a craft (Tin Veins)."] = "",

	-- Step 18: Mine Copper Ore, smelt Copper Bar
	-- {item:2840} Copper Bar · {skill:202} Engineering · {item:2770} Copper Ore · {skill:186} Mining
	-- plural, as words: Copper Tubes = {spell:3924} Copper Tube
	["40 {item:2840} for {skill:202} 94-100: 20 Copper Tubes; from your mining on the way: 40 of 40 {item:2770}. Your bags hold it already, smelt 40 {item:2840} at a forge, then craft 14 Copper Tubes ({skill:202} 94 to 100). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 19: Copper Tube to 100
	-- {spell:3924} Copper Tube
	["{spell:3924} to 100"] = "",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is yellow at 94 (yellow 80, green 95, grey 110): about 14 crafts to 100, up to 20 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. If you got here without learning {spell:3924}, learn it now: an earlier step teaches it."] = "",

	-- Step 20: Smelt Bronze & Smelt Tin
	-- {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["A {skill:186} trainer teaches {spell:2659} ({skill:186} 65, 2s) and {spell:3304} ({skill:186} 65, 50c): the bars of the next stretch are smelted from what you mine."] = "",

	-- Step 21: Mine Copper Ore and Tin Ore, smelt Copper Bar and Bronze Bar
	-- {item:2770} Copper Ore · {item:2771} Tin Ore · {item:2840} Copper Bar · {item:2841} Bronze Bar
	["Mine {item:2770} and {item:2771}, smelt {item:2840} and {item:2841}"] = "",
	-- {item:2840} Copper Bar · {item:2841} Bronze Bar · {skill:202} Engineering · {item:2770} Copper Ore · {item:2771} Tin Ore · {skill:186} Mining
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["22 {item:2840} and 36 {item:2841} for {skill:202} 100-125: 36 Practice Locks; from your mining on the way: 40 of 40 {item:2770} and 18 of 18 {item:2771}. Your bags hold it already, smelt 22 {item:2840} and 36 {item:2841} at a forge, then craft 31 Practice Locks ({skill:202} 100 to 125). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 22: Engineering recipes at 100
	-- {skill:202} Engineering
	["{skill:202} recipes at 100"] = "",
	-- {skill:202} Engineering · {spell:8334} Practice Lock · {spell:3973} Silver Contact · {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["Back to an {skill:202} trainer: {spell:8334} (from 100) and {spell:3973} (from 90). A {skill:186} trainer also teaches {spell:2659} (2s) and {spell:3304} (50c): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 23: Practice Lock to 125
	-- {item:6712} Practice Lock
	["{item:6712} to 125"] = "",
	-- {item:6712} Practice Lock · {item:2841} Bronze Bar · {spell:3922} Handful of Copper Bolts · {item:2880} Weak Flux
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125, up to 36 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 12 {spell:3922} first. Use the 50 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby. If you got here without learning {spell:3922}, learn it now: an earlier step teaches it."] = "",

	-- Step 24: Mining 114-125: Tin
	-- {skill:186} Mining
	["{skill:186} 114-125: Tin"] = "",
	-- {skill:186} Mining · {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone · {item:2770} Copper Ore · {item:2835} Rough Stone · {item:2771} Tin Ore · {item:2836} Coarse Stone
	["{skill:186} 114 to 125 before {spell:3945}: its {item:2838} come from {skill:186} 125. The area also gives about 15 {item:2770}, 10 {item:2835}, 15 {item:2771} and 10 {item:2836}: keep them, the next stretches use them. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 25: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises {skill:186}'s cap to 225, needs {skill:186} 125 and costs 50s (the arrow picks the nearest {skill:186} trainer of your faction); learn {spell:3307} (5s) there too."] = "",

	-- Step 26: Mining 125-155: Iron
	-- {skill:186} Mining
	["{skill:186} 125-155: Iron"] = "",
	-- {skill:186} Mining · {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	["Mine from {skill:186} 125 to 155 for {spell:3945}: this area gives {item:2838}, and the next one the rest from {skill:186} 155. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 27: Mining 155-175: Iron
	-- {skill:186} Mining
	["{skill:186} 155-175: Iron"] = "",
	-- {skill:186} Mining · {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	["Mine from {skill:186} 155 to 175 for {spell:3945}: this area gives {item:2838}, and the next one the rest from {skill:186} 175. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 28: Mining 175-200: Mithril
	-- {skill:186} Mining
	["{skill:186} 175-200: Mithril"] = "",
	-- {skill:186} Mining · {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	["Mine from {skill:186} 175 to 200 for {spell:3945}: this area gives {item:2838}, and the next one the rest from {skill:186} 200. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 29: Smelt Gold
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["A {skill:186} trainer also teaches {spell:3308} (25s): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 30: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "",
	-- {skill:186} Mining
	["Artisan {skill:186} raises {skill:186}'s cap to 300, needs {skill:186} 200 and costs 5g (the arrow picks the nearest {skill:186} trainer of your faction)."] = "",

	-- Step 31: Mine Heavy Stone (Mining 200-213)
	-- {item:2838} Heavy Stone · {skill:186} Mining
	["Mine {item:2838} ({skill:186} 200-213)"] = "",
	-- {item:2838} Heavy Stone · {skill:202} Engineering · {spell:3945} Heavy Blasting Powder · {skill:186} Mining
	["70 {item:2838} for {skill:202} 125-144: 70 {spell:3945}. Mine 70 {item:2838} ({skill:186} 200 to 213), then craft 52 {spell:3945} ({skill:202} 125 to 144). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 32: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} (from 125)."] = "",

	-- Step 33: Heavy Blasting Powder to 144
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 144"] = "",
	-- {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit · Iron Grenades = {item:4390} Iron Grenade
	["{spell:3945} is yellow at 125 (yellow 125, green 135, grey 145): about 52 crafts to 144, up to 70 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2838}. One {item:2838} a craft (Iron Deposits). Keep some: Iron Grenades take one each."] = "",

	-- Step 34: Mine Copper Ore and Tin Ore, smelt Bronze Bar
	-- {item:2770} Copper Ore · {item:2771} Tin Ore · {item:2841} Bronze Bar
	["Mine {item:2770} and {item:2771}, smelt {item:2841}"] = "",
	-- {item:2841} Bronze Bar · {skill:202} Engineering · {item:2770} Copper Ore · {item:2771} Tin Ore · {skill:186} Mining
	-- plural, as words: Big Bronze Bombs = {spell:3950} Big Bronze Bomb
	["27 {item:2841} for {skill:202} 144-150: 9 Big Bronze Bombs; from your mining on the way: 14 of 14 {item:2770} and 14 of 14 {item:2771}. Your bags hold it already, smelt 27 {item:2841} at a forge, then craft 7 Big Bronze Bombs ({skill:202} 144 to 150). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 35: Engineering recipes at 144
	-- {skill:202} Engineering
	["{skill:202} recipes at 144"] = "",
	-- {skill:202} Engineering · {spell:3950} Big Bronze Bomb
	["Back to an {skill:202} trainer: {spell:3950} (from 140)."] = "",

	-- Step 36: Big Bronze Bomb to 150
	-- {spell:3950} Big Bronze Bomb
	["{spell:3950} to 150"] = "",
	-- {spell:3950} Big Bronze Bomb · {item:4377} Heavy Blasting Powder · {item:2841} Bronze Bar · {spell:3973} Silver Contact · {skill:202} Engineering
	["{spell:3950} is yellow at 144 (yellow 140, green 165, grey 190): about 7 crafts to 150, up to 9 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:4377}, 3 {item:2841} and 1 {spell:3973} and makes 3. Make the 10 {spell:3973} (2 crafts) first. Use the 14 {item:4377} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "",

	-- Step 37: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "",
	-- {skill:202} Engineering · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11017} Roxxik · {zone:1454} Orgrimmar · {spell:9271} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:5174} ({zone:1455}); Horde {npc:11017} ({zone:1454}). This route trains it at {npc:5174} ({zone:1455}) for the Alliance and {npc:11017} ({zone:1454}) for the Horde, who also teach the recipes of 150-225: one trainer for every visit. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 25 {item:2319}, 25 {item:2592}, 128 {item:2841}, 6 {item:2842}, 81 {item:3575}, 22 {item:3860} and 390 {item:7912} to gather or buy."] = "",

	-- Step 38: Engineering 150-225: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 150-225: vendor goods"] = "",
	-- {item:6530} Nightcrawlers · {zone:1453} Stormwind City · {npc:5494} Catherine Leland · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 31 {item:6530} (31s); about 31s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5494} and {npc:1286})."] = "",

	-- Step 39: Get Medium Leather
	-- {item:2319} Medium Leather
	["Get {item:2319}"] = "",
	-- {item:2319} Medium Leather · {skill:202} Engineering · {skill:393} Skinning
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["25 {item:2319} for {skill:202} 150-225: 25 Bronze Frameworks. {skill:393}: beasts of level 18-30. The window lists the {skill:393} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them. Or buy them at the Auction House."] = "",

	-- Step 40: Get Wool Cloth
	-- {item:2592} Wool Cloth
	["Get {item:2592}"] = "",
	-- {item:2592} Wool Cloth · {skill:202} Engineering
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["25 {item:2592} for {skill:202} 150-225: 25 Bronze Frameworks. Humanoids of level 15-30 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:2592} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 41: Get Silver Bar
	-- {item:2842} Silver Bar · {skill:202} Engineering · {skill:186} Mining · {item:2775} Silver Ore
	-- plural, as words: Big Iron Bombs = {spell:3967} Big Iron Bomb
	["6 {item:2842} for {skill:202} 150-225: 27 Big Iron Bombs. {skill:186}: smelt {item:2775}. Or buy them at the Auction House."] = "",

	-- Step 42: Mine Coarse Stone, Copper Ore and Tin Ore, smelt Bronze Bar
	-- {item:2836} Coarse Stone · {item:2770} Copper Ore · {item:2771} Tin Ore · {item:2841} Bronze Bar
	["Mine {item:2836}, {item:2770} and {item:2771}, smelt {item:2841}"] = "",
	-- {item:2836} Coarse Stone · {item:2841} Bronze Bar · {skill:202} Engineering · {item:2770} Copper Ore · {item:2771} Tin Ore · {skill:186} Mining
	-- plural, as words: Aquadynamic Fish Attractors = {item:6533} Aquadynamic Fish Attractor
	["9 {item:2836} and 78 {item:2841} for {skill:202} 150-166: 39 Aquadynamic Fish Attractors; from your mining on the way: 9 of 9 {item:2836}, 37 of 39 {item:2770} and 39 of 39 {item:2771}. Mine 3 {item:2770} ({skill:186} 213), smelt 78 {item:2841} at a forge, then craft 31 Aquadynamic Fish Attractors ({skill:202} 150 to 166). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 43: Aquadynamic Fish Attractor to 166
	-- {item:6533} Aquadynamic Fish Attractor
	["{item:6533} to 166"] = "",
	-- {item:6533} Aquadynamic Fish Attractor · {item:2841} Bronze Bar · {item:6530} Nightcrawlers · {spell:3929} Coarse Blasting Powder
	["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166, up to 39 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 1 {spell:3929} first. Use the 30 {spell:3929} you made earlier; the counts above leave them out. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen. If you got here without learning {spell:3929}, learn it now: an earlier step teaches it."] = "",

	-- Step 44: Mine Copper Ore and Tin Ore, smelt Bronze Bar
	-- {item:2841} Bronze Bar · {skill:202} Engineering · {item:2771} Tin Ore · {item:2770} Copper Ore · {skill:186} Mining
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["50 {item:2841} for {skill:202} 166-175: 25 Bronze Frameworks; from your mining on the way: 18 of 25 {item:2771}. Mine 25 {item:2770} and 8 {item:2771} at the areas of {skill:186} 50-65, the richest in it (they give no more points), smelt 50 {item:2841} at a forge, then craft 19 Bronze Frameworks ({skill:202} 166 to 175). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 45: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "",
	-- {spell:3953} Bronze Framework · {item:2841} Bronze Bar · {item:2319} Medium Leather · {item:2592} Wool Cloth
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["{spell:3953} is yellow at 166 (yellow 145, green 170, grey 195): about 19 crafts to 175, up to 25 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:2841}, 1 {item:2319} and 1 {item:2592}. Bronze Frameworks are parts for later gadgets; the extras sell to vendors."] = "",

	-- Step 46: Mining 213-230: Iron & Mithril
	-- {skill:186} Mining
	["{skill:186} 213-230: Iron & Mithril"] = "",
	-- {skill:186} Mining · {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	["Mine from {skill:186} 213 to 230 for {item:10505}: this area gives {item:7912}, and the next one the rest from {skill:186} 230. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 47: Mining 230-245: Mithril & Truesilver
	-- {skill:186} Mining
	["{skill:186} 230-245: Mithril & Truesilver"] = "",
	-- {skill:186} Mining · {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	["Mine from {skill:186} 230 to 245 for {item:10505}: this area gives {item:7912}, and the next one the rest from {skill:186} 245. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 48: Mining 245-275: Small Thorium
	-- {skill:186} Mining
	["{skill:186} 245-275: Small Thorium"] = "",
	-- {skill:186} Mining · {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	["Mine from {skill:186} 245 to 275 for {item:10505}: this area gives {item:7912}, and the next one the rest from {skill:186} 275. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 49: Mine Solid Stone
	-- {item:7912} Solid Stone
	["Mine {item:7912}"] = "",
	-- {item:7912} Solid Stone · {skill:202} Engineering · {item:10505} Solid Blasting Powder · {skill:186} Mining
	["206 {item:7912} for {skill:202} 175-195: 103 {item:10505}; from your mining on the way: 40 of 206 {item:7912}. Mine 166 {item:7912} at the areas of {skill:186} 230-245, the richest in it (they give no more points), then craft 72 {item:10505} ({skill:202} 175 to 195). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 50: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "",
	-- {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11017} Roxxik · {zone:1454} Orgrimmar · {spell:12585} Solid Blasting Powder
	["Back to {npc:5174} ({zone:1455}) (Alliance) or {npc:11017} ({zone:1454}) (Horde): {spell:12585} (from 175)."] = "",

	-- Step 51: Solid Blasting Powder to 195
	-- {item:10505} Solid Blasting Powder
	["{item:10505} to 195"] = "",
	-- {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["{item:10505} is yellow at 175 (yellow 175, green 185, grey 195): about 72 crafts to 195, up to 103 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:7912}. Two {item:7912} a craft (Mithril Deposits). Make plenty: the triggers, slugs and Gyro-Shot all use it."] = "",

	-- Step 52: Mine Heavy Stone and Iron Ore, smelt Iron Bar
	-- {item:2838} Heavy Stone · {item:2772} Iron Ore · {item:3575} Iron Bar
	["Mine {item:2838} and {item:2772}, smelt {item:3575}"] = "",
	-- {item:2838} Heavy Stone · {item:3575} Iron Bar · {skill:202} Engineering · {item:2772} Iron Ore · {skill:186} Mining
	-- plural, as words: Big Iron Bombs = {spell:3967} Big Iron Bomb
	["43 {item:2838} and 81 {item:3575} for {skill:202} 195-210: 27 Big Iron Bombs; from your mining on the way: 17 of 43 {item:2838} and 81 of 81 {item:2772}. Mine 26 {item:2838} at the areas of {skill:186} 125-155, the richest in it (they give no more points), smelt 81 {item:3575} at a forge, then craft 22 Big Iron Bombs ({skill:202} 195 to 210). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 53: Engineering recipes at 195
	-- {skill:202} Engineering
	["{skill:202} recipes at 195"] = "",
	-- {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11017} Roxxik · {zone:1454} Orgrimmar · {spell:3967} Big Iron Bomb
	["Back to {npc:5174} ({zone:1455}) (Alliance) or {npc:11017} ({zone:1454}) (Horde): {spell:3967} (from 190)."] = "",

	-- Step 54: Big Iron Bomb to 210
	-- {spell:3967} Big Iron Bomb
	["{spell:3967} to 210"] = "",
	-- {spell:3967} Big Iron Bomb · {item:3575} Iron Bar · {spell:3945} Heavy Blasting Powder · {spell:3973} Silver Contact · {item:2842} Silver Bar · {item:2838} Heavy Stone · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:4586} Graham Van Talen · {zone:1458} Undercity · {area:392} Ratchet · {spell:20220} Gnomish Engineering · {npc:7944} Tinkmaster Overspark · {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {item:4407} Accurate Scope · {npc:8126} Nixx Sprocketspring · {area:976} Gadgetzan · {item:10507} Solid Dynamite · {npc:2675} Explosive Sheep
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact · Mithril Tubes = {item:10559} Mithril Tube · Big Iron Bombs = {spell:3967} Big Iron Bomb
	["{spell:3967} is yellow at 195 (yellow 190, green 210, grey 230): about 22 crafts to 210, up to 27 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 28 {spell:3945} and 25 {spell:3973} (5 crafts) first. Use the 38 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby. If you got here without learning {spell:3945} and {spell:3973}, learn them now: an earlier step teaches them."] = "",

	-- Step 55: Smelt Mithril
	-- {skill:186} Mining · {spell:10097} Smelt Mithril
	["A {skill:186} trainer teaches {spell:10097} ({skill:186} 175, 50s): the bars of the next stretch are smelted from what you mine."] = "",

	-- Step 56: Mine Mithril Ore, smelt Mithril Bar
	-- {item:3858} Mithril Ore · {item:3860} Mithril Bar
	["Mine {item:3858}, smelt {item:3860}"] = "",
	-- {item:3860} Mithril Bar · {skill:202} Engineering · {item:10512} Hi-Impact Mithril Slugs · {item:3858} Mithril Ore · {skill:186} Mining
	["22 {item:3860} for {skill:202} 210-225: 22 {item:10512}; from your mining on the way: 22 of 22 {item:3858}. Your bags hold it already, smelt 22 {item:3860} at a forge, then craft 19 {item:10512} ({skill:202} 210 to 225). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 57: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "",
	-- {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11017} Roxxik · {zone:1454} Orgrimmar · {spell:12596} Hi-Impact Mithril Slugs
	["Back to {npc:5174} ({zone:1455}) (Alliance) or {npc:11017} ({zone:1454}) (Horde): {spell:12596} (from 210)."] = "",

	-- Step 58: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:202} Engineering
	["{item:10512} is yellow at 210 (yellow 210, green 230, grey 250): about 19 crafts to 225, up to 22 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Use the 19 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "",

	-- Step 59: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {item:3860} Mithril Bar · {item:12359} Thorium Bar · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}); Horde {npc:8736} ({zone:1446}). This route trains it at {npc:8736} ({zone:1446}) for the Alliance and {npc:8736} ({zone:1446}) for the Horde, who also teach the recipes of 225-300: one trainer for every visit. 225-300 takes about 2g 80s of recipes, plus 145 {item:3860}, 174 {item:12359} and 26 {item:14047} to gather or buy."] = "",

	-- Step 60: Schematic: Thorium Widget
	-- {item:16042} Schematic: Thorium Widget · {item:15994} Thorium Widget · {skill:202} Engineering · {npc:5175} Gearcutter Cogspinner · {zone:1455} Ironforge · {npc:3413} Sovik · {zone:1454} Orgrimmar
	["{item:16042} teaches {item:15994} ({skill:202} 260) for 1g 20s. Sold by Alliance: {npc:5175} ({zone:1455}), limited stock; Horde: {npc:3413} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "",

	-- Step 61: Schematic: Thorium Tube
	-- {item:16047} Schematic: Thorium Tube · {item:16000} Thorium Tube · {skill:202} Engineering · {npc:260565} Kor'gar · {zone:2548} Riverglades · {npc:11185} Xizzer Fizzbolt · {zone:1452} Winterspring
	["{item:16047} teaches {item:16000} ({skill:202} 275) for 1g 60s. Sold by Alliance: {npc:260565} ({zone:2548}) and {npc:11185} ({zone:1452}), limited stock; Horde: {npc:11185} ({zone:1452}), limited stock."] = "",

	-- Step 62: Get Runecloth
	-- {item:14047} Runecloth
	["Get {item:14047}"] = "",
	-- {item:14047} Runecloth · {skill:202} Engineering
	-- plural, as words: Thorium Widgets = {item:15994} Thorium Widget
	["26 {item:14047} for {skill:202} 225-300: 26 Thorium Widgets. Humanoids of level 45-60 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14047} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 63: Mine Mithril Ore and Solid Stone, smelt Mithril Bar
	-- {item:3858} Mithril Ore · {item:7912} Solid Stone · {item:3860} Mithril Bar
	["Mine {item:3858} and {item:7912}, smelt {item:3860}"] = "",
	-- {item:3860} Mithril Bar · {item:7912} Solid Stone · {skill:202} Engineering · {item:10512} Hi-Impact Mithril Slugs · {item:3858} Mithril Ore · {skill:186} Mining
	["79 {item:3860} and 52 {item:7912} for {skill:202} 225-245: 79 {item:10512}; from your mining on the way: 79 of 79 {item:3858}. Mine 52 {item:7912} at the areas of {skill:186} 230-245, the richest in it (they give no more points), smelt 79 {item:3860} at a forge, then craft 62 {item:10512} ({skill:202} 225 to 245). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 64: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {item:10561} Mithril Casing
	["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245, up to 79 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 9 {item:10505} first. Use the 53 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. The slow part: the slugs turn green at 230, so 225-245 takes about 60 crafts for 20 points. Nothing in the data is cheaper here ({item:10561} takes three times the Mithril; the rest need Truesilver or parts). Needs an anvil nearby. If you got here without learning {item:10505} and {item:10512}, learn them now: an earlier step teaches them."] = "",

	-- Step 65: Mine Mithril Ore and Solid Stone, smelt Mithril Bar
	-- {item:3860} Mithril Bar · {item:7912} Solid Stone · {skill:202} Engineering · {item:3858} Mithril Ore · {skill:186} Mining
	-- plural, as words: Mithril Gyro-Shots = {item:10513} Mithril Gyro-Shot
	["66 {item:3860} and 132 {item:7912} for {skill:202} 245-265: 33 Mithril Gyro-Shots; from your mining on the way: 66 of 66 {item:3858}. Mine 132 {item:7912} at the areas of {skill:186} 230-245, the richest in it (they give no more points), smelt 66 {item:3860} at a forge, then craft 28 Mithril Gyro-Shots ({skill:202} 245 to 265). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 66: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "",
	-- {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {spell:12621} Mithril Gyro-Shot
	["Back to {npc:8736} ({zone:1446}) (Alliance) or {npc:8736} ({zone:1446}) (Horde): {spell:12621} (from 245)."] = "",

	-- Step 67: Mithril Gyro-Shot to 265
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 265"] = "",
	-- {item:10513} Mithril Gyro-Shot · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:10513} is yellow at 245 (yellow 245, green 265, grey 285): about 28 crafts to 265, up to 33 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:3860} and 2 {item:10505} and makes 200. Make the 56 {item:10505} first. Two Mithril Bars and two {item:10505} a craft. Needs an anvil nearby. If you got here without learning {item:10505}, learn it now: an earlier step teaches it."] = "",

	-- Step 68: Smelt Thorium
	-- {skill:186} Mining · {spell:16153} Smelt Thorium
	["A {skill:186} trainer teaches {spell:16153} ({skill:186} 250, 2g): the bars of the next stretch are smelted from what you mine."] = "",

	-- Step 69: Mining 275-300: Small Thorium & Rich Thorium
	-- {skill:186} Mining
	["{skill:186} 275-300: Small Thorium & Rich Thorium"] = "",
	-- {skill:186} Mining · {item:15994} Thorium Widget · {item:10620} Thorium Ore
	["Mine from {skill:186} 275 to 300 for {item:15994}: this area gives {item:10620}, and the next one the rest from {skill:186} 300. The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it; each keeps to creatures no more than a level above you and away from the other faction's towns."] = "",

	-- Step 70: Mine Thorium Ore, smelt Thorium Bar
	-- {item:10620} Thorium Ore · {item:12359} Thorium Bar
	["Mine {item:10620}, smelt {item:12359}"] = "",
	-- {item:12359} Thorium Bar · {skill:202} Engineering · {item:10620} Thorium Ore · {skill:186} Mining
	-- plural, as words: Thorium Widgets = {item:15994} Thorium Widget
	["78 {item:12359} for {skill:202} 265-287: 26 Thorium Widgets; from your mining on the way: 23 of 78 {item:10620}. Mine 55 {item:10620} at the areas of {skill:186} 275-300, the richest in it (they give no more points), smelt 78 {item:12359} at a forge, then craft 24 Thorium Widgets ({skill:202} 265 to 287). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 71: Thorium Widget to 287
	-- {item:15994} Thorium Widget
	["{item:15994} to 287"] = "",
	-- {item:15994} Thorium Widget · {item:12359} Thorium Bar · {item:14047} Runecloth
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:15994} is orange at 265 (yellow 280, green 290, grey 300): about 24 crafts to 287, up to 26 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {item:12359} and 1 {item:14047}. Three Thorium Bars and a {item:14047} a craft; the widgets are parts for the later Thorium gadgets. Needs an anvil nearby."] = "",
	["from the recipe in your bags"] = "",

	-- Step 72: Mine Thorium Ore, smelt Thorium Bar
	-- {item:12359} Thorium Bar · {skill:202} Engineering · {item:10620} Thorium Ore · {skill:186} Mining
	-- plural, as words: Thorium Tubes = {item:16000} Thorium Tube
	["96 {item:12359} for {skill:202} 287-300: 16 Thorium Tubes. Mine 96 {item:10620} at the areas of {skill:186} 275-300, the richest in it (they give no more points), smelt 96 {item:12359} at a forge, then craft 14 Thorium Tubes ({skill:202} 287 to 300). The window lists the {skill:186} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them."] = "",

	-- Step 73: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "",
	-- {item:16000} Thorium Tube · {item:12359} Thorium Bar · {skill:202} Engineering
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:16000} is orange at 287 (yellow 295, green 305, grey 315): about 14 crafts to 300, up to 16 for 9 players in 10 (the gathered materials above count that many). Each takes 6 {item:12359}. The schematic binds when picked up; six Thorium Bars a craft. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "",
}
