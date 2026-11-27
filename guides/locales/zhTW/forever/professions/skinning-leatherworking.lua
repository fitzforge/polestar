-- Chinese (traditional) (zhTW): the guide forever/professions/skinning-leatherworking (forever/professions/skinning-leatherworking.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Skinning and Leatherworking
	-- {skill:393} Skinning · {skill:165} Leatherworking
	["Learn {skill:393} and {skill:165}"] = "",
	-- {skill:165} Leatherworking · {npc:1632} Adele Fielder · {zone:1429} Elwynn Forest · {npc:11083} Darianna · {zone:1457} Darnassus · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {npc:1466} Gretta Finespindle · {zone:1455} Ironforge · {npc:251993} Indari Sunseam · {npc:3605} Nadyia Maneweaver · {zone:1438} Teldrassil · {npc:11096} Randal Worth · {zone:1453} Stormwind City · {npc:3069} Chaw Stronghide · {zone:1412} Mulgore · {npc:223} Dan Golthas · {zone:1458} Undercity · {npc:5811} Kamari · {zone:1454} Orgrimmar · {npc:3008} Mak · {zone:1456} Thunder Bluff · {npc:3549} Shelene Rhobart · {zone:1420} Tirisfal Glades · {skill:393} Skinning · {item:2318} Light Leather · {item:2320} Coarse Thread · {item:2934} Ruined Leather Scraps · {item:7005} Skinning Knife
	["Apprentice {skill:165} lets you craft up to 75 for 10c, at any character level. Not every {skill:165} trainer teaches it: Alliance {npc:1632} ({zone:1429}), {npc:11083} ({zone:1457}), {npc:252376} ({zone:2521}), {npc:1466} ({zone:1455}), {npc:251993} ({zone:2521}), {npc:3605} ({zone:1438}) and {npc:11096} ({zone:1453}); Horde {npc:3069} ({zone:1412}), {npc:223} ({zone:1458}), {npc:252376} ({zone:2521}), {npc:251993} ({zone:2521}), {npc:5811} ({zone:1454}), {npc:3008} ({zone:1456}) and {npc:3549} ({zone:1420}). The arrow picks the nearest of your faction. Pair it with {skill:393}: {item:2318} comes from the beasts of every starting zone. {item:2320} and Salt are sold by leatherworking and trade supplies vendors. 1-75 takes about 1s 50c of recipes and 5s of vendor goods, plus 352 {item:2318} and 57 {item:2934} to gather or buy. Learn Apprentice {skill:393} on the same trip: any {skill:393} trainer of your faction teaches it at any level, and the arrow picks the nearest. Buy a {item:7005} from a trade goods or general vendor: keep it in your bags, you cannot skin without it."] = "",

	-- Step 2: Leatherworking 1-75: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 1-75: vendor goods"] = "",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 50 {item:2320} (5s); about 5s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 3: Skin Ruined Leather Scraps (Skinning 1-47)
	-- {item:2934} Ruined Leather Scraps · {skill:393} Skinning
	["Skin {item:2934} ({skill:393} 1-47)"] = "",
	-- {item:2934} Ruined Leather Scraps · {skill:165} Leatherworking · {item:2318} Light Leather · {skill:393} Skinning
	["57 {item:2934} for {skill:165} 1-20: 19 {item:2318}. Skin 57 {item:2934} ({skill:393} 1 to 47), then craft 19 {item:2318} ({skill:165} 1 to 20). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 4: Light Leather to 20
	-- {item:2318} Light Leather
	["{item:2318} to 20"] = "",
	-- {item:2318} Light Leather · {item:2934} Ruined Leather Scraps
	["{item:2318} is orange at 1 (yellow 20, green 30, grey 40): about 19 crafts to 20, a point every craft. Each takes 3 {item:2934}. Three {item:2934} a craft: the beasts of the starting zones give them as you skin. Orange to 20, and the {item:2318} goes into the kits next."] = "",

	-- Step 5: Skinning 47-50: Beasts 1-4
	-- {skill:393} Skinning
	["{skill:393} 47-50: Beasts 1-4"] = "",
	-- {skill:393} Skinning · {spell:2152} Light Armor Kit · {item:2318} Light Leather
	["Skin from {skill:393} 47 to 50 for {spell:2152}: this loop gives {item:2318}, and the next one the rest from {skill:393} 50. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 6: Skin Light Leather (Skinning 50-72)
	-- {item:2318} Light Leather · {skill:393} Skinning
	["Skin {item:2318} ({skill:393} 50-72)"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {skill:393} Skinning
	-- plural, as words: Light Armor Kits = {spell:2152} Light Armor Kit
	["34 {item:2318} for {skill:165} 20-51: 53 Light Armor Kits. Skin 34 {item:2318} ({skill:393} 50 to 72), then craft 45 Light Armor Kits ({skill:165} 20 to 51). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 7: Light Armor Kit to 51
	-- {spell:2152} Light Armor Kit
	["{spell:2152} to 51"] = "",
	-- {spell:2152} Light Armor Kit · {item:2318} Light Leather
	["{spell:2152} is orange at 20 (yellow 30, green 45, grey 60): about 45 crafts to 51, up to 53 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2318}. Use the 19 {item:2318} you made earlier; the counts above leave them out. One {item:2318} a craft; the kits sell to vendors."] = "",

	-- Step 8: Skinning 72-75: Beasts 1-15
	-- {skill:393} Skinning
	["{skill:393} 72-75: Beasts 1-15"] = "",
	-- {skill:393} Skinning · {spell:3756} Embossed Leather Gloves · {item:2318} Light Leather
	["Skin from {skill:393} 72 to 75 for {spell:3756}: this loop gives {item:2318}, and the next one the rest from {skill:393} 75. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 9: Journeyman Skinning
	-- {skill:393} Skinning
	["Journeyman {skill:393}"] = "",
	-- {skill:393} Skinning
	["Journeyman {skill:393} raises {skill:393}'s cap to 150, needs {skill:393} 50 and costs 5s (the arrow picks the nearest {skill:393} trainer of your faction)."] = "",

	-- Step 10: Skinning 75-100: Beasts 5-17
	-- {skill:393} Skinning
	["{skill:393} 75-100: Beasts 5-17"] = "",
	-- {skill:393} Skinning · {spell:3756} Embossed Leather Gloves · {item:2318} Light Leather
	["Skin from {skill:393} 75 to 100 for {spell:3756}: this loop gives {item:2318}, and the next one the rest from {skill:393} 100. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 11: Skin Light Leather (Skinning 100-121)
	-- {item:2318} Light Leather · {skill:393} Skinning
	["Skin {item:2318} ({skill:393} 100-121)"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {spell:3756} Embossed Leather Gloves · {skill:393} Skinning
	["78 {item:2318} for {skill:165} 51-75: 26 {spell:3756}. Skin 78 {item:2318} ({skill:393} 100 to 121), then craft 25 {spell:3756} ({skill:165} 51 to 75). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 12: Leatherworking recipes at 51
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 51"] = "",
	-- {skill:165} Leatherworking · {spell:3756} Embossed Leather Gloves · {spell:1229432} Camp Tent · {item:2318} Light Leather
	["Back to a {skill:165} trainer: {spell:3756} (from 40, 1s 50c). Also learn {spell:1229432} (1s): Forever's {skill:165} camp item, 5 {item:2318}, placed at a campsite beside a campfire. The Camping 101: {skill:165} quest from your starting area's camping guide (after The Great Outdoors) sends you to a leatherworking trainer who teaches it free."] = "",

	-- Step 13: Embossed Leather Gloves to 75
	-- {spell:3756} Embossed Leather Gloves
	["{spell:3756} to 75"] = "",
	-- {spell:3756} Embossed Leather Gloves · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3756} is orange at 51 (yellow 70, green 85, grey 100): about 25 crafts to 75, up to 26 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {item:2318} and 2 {item:2320}. Forever teaches {spell:3756} from 40."] = "",

	-- Step 14: Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Journeyman {skill:165}"] = "",
	-- {skill:165} Leatherworking · {npc:3967} Aayndia Floralwind · {zone:1440} Ashenvale · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {npc:11081} Faldron · {zone:1457} Darnassus · {npc:5127} Fimble Finespindle · {zone:1455} Ironforge · {npc:5564} Simon Tanner · {zone:1453} Stormwind City · {npc:4588} Arthur Moore · {zone:1458} Undercity · {npc:1385} Brawn · {zone:1434} Stranglethorn Vale · {npc:3365} Karolek · {zone:1454} Orgrimmar · {npc:3703} Krulmoo Fullmoon · {zone:1413} The Barrens · {npc:8153} Narv Hidecrafter · {zone:1443} Desolace · {npc:11084} Tarn · {zone:1456} Thunder Bluff · {spell:3763} Fine Leather Belt · {item:2319} Medium Leather · {item:2457} Elixir of Minor Agility · {item:4234} Heavy Leather · {item:4235} Heavy Hide
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:165} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:165} trainer teaches it: Alliance {npc:3967} ({zone:1440}), {npc:252376} ({zone:2521}), {npc:11081} ({zone:1457}), {npc:5127} ({zone:1455}) and {npc:5564} ({zone:1453}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}) and {npc:11084} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3763} (from 55, 3s). 75-150 takes about 20s 50c of recipes and 67s 50c of vendor goods, plus 150 {item:2319}, 25 {item:2457}, 281 {item:4234} and 24 {item:4235} to gather or buy."] = "",

	-- Step 15: Leatherworking 75-150: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 75-150: vendor goods"] = "",
	-- {item:2320} Coarse Thread · {item:2321} Fine Thread · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {npc:3366} Tamar
	["Buy the whole bracket's share in one go: 70 {item:2320} (7s), 35 {item:2321} (35s) and 51 Salt (25s 50c); about 67s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286} and {npc:5565}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3366})."] = "",

	-- Step 16: Get Elixir of Minor Agility
	-- {item:2457} Elixir of Minor Agility
	["Get {item:2457}"] = "",
	-- {item:2457} Elixir of Minor Agility · {skill:165} Leatherworking · {item:7285} Nimble Leather Gloves · {skill:171} Alchemy
	["25 {item:2457} for {skill:165} 75-150: 25 {item:7285}. {skill:171}: {item:2457}. Or buy them at the Auction House."] = "",

	-- Step 17: Get Heavy Hide (Alterac Mountains)
	-- {item:4235} Heavy Hide · {zone:1416} Alterac Mountains
	["Get {item:4235} ({zone:1416})"] = "",
	-- {item:4235} Heavy Hide · {skill:165} Leatherworking · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti
	-- plural, as words: Cured Heavy Hides = {spell:3818} Cured Heavy Hide
	["24 {item:4235} for {skill:165} 75-150: 19 Cured Heavy Hides and 15 {item:5966} (5 of them for 150-225: get them all now). {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 18: Get Heavy Hide (Thousand Needles)
	-- {item:4235} Heavy Hide · {zone:1441} Thousand Needles
	["Get {item:4235} ({zone:1441})"] = "",
	-- {item:4235} Heavy Hide · {skill:165} Leatherworking · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise
	-- plural, as words: Cured Heavy Hides = {spell:3818} Cured Heavy Hide
	["24 {item:4235} for {skill:165} 75-150: 19 Cured Heavy Hides and 15 {item:5966} (5 of them for 150-225: get them all now). {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 21: Skinning 121-125: Beasts 11-20
	-- {skill:393} Skinning
	["{skill:393} 121-125: Beasts 11-20"] = "",
	-- {skill:393} Skinning · {spell:3763} Fine Leather Belt · {item:2318} Light Leather
	["Skin from {skill:393} 121 to 125 for {spell:3763}: this loop gives {item:2318}, and the next one the rest from {skill:393} 125. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 22: Skinning 125-150: Beasts 21-25
	-- {skill:393} Skinning
	["{skill:393} 125-150: Beasts 21-25"] = "",
	-- {skill:393} Skinning · {spell:3763} Fine Leather Belt · {item:2318} Light Leather
	["Skin from {skill:393} 125 to 150 for {spell:3763}: this loop gives {item:2318}, and the next one the rest from {skill:393} 150. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 23: Skin Light Leather
	-- {item:2318} Light Leather
	["Skin {item:2318}"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {skill:393} Skinning
	-- plural, as words: Fine Leather Belts = {spell:3763} Fine Leather Belt
	["240 {item:2318} for {skill:165} 75-102: 40 Fine Leather Belts. Skin 240 {item:2318} at the loops of {skill:393} 100-125, the richest in it (they give no more points), then craft 35 Fine Leather Belts ({skill:165} 75 to 102). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 24: Fine Leather Belt to 102
	-- {spell:3763} Fine Leather Belt
	["{spell:3763} to 102"] = "",
	-- {spell:3763} Fine Leather Belt · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3763} is orange at 75 (yellow 85, green 100, grey 115): about 35 crafts to 102, up to 40 for 9 players in 10 (the gathered materials above count that many). Each takes 6 {item:2318} and 2 {item:2320}. Forever teaches {spell:3763} from 55."] = "",

	-- Step 25: Expert Skinning
	-- {skill:393} Skinning
	["Expert {skill:393}"] = "",
	-- {skill:393} Skinning
	["Expert {skill:393} raises {skill:393}'s cap to 225, needs {skill:393} 125 and costs 50s (the arrow picks the nearest {skill:393} trainer of your faction)."] = "",

	-- Step 26: Skinning 150-175: Beasts 27-30
	-- {skill:393} Skinning
	["{skill:393} 150-175: Beasts 27-30"] = "",
	-- {skill:393} Skinning · {item:7285} Nimble Leather Gloves · {item:2319} Medium Leather
	["Skin from {skill:393} 150 to 175 for {item:7285}: this loop gives {item:2319}, and the next one the rest from {skill:393} 175. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 27: Skinning 175-200: Beasts 25-35
	-- {skill:393} Skinning
	["{skill:393} 175-200: Beasts 25-35"] = "",
	-- {skill:393} Skinning · {item:7285} Nimble Leather Gloves · {item:2319} Medium Leather
	["Skin from {skill:393} 175 to 200 for {item:7285}: this loop gives {item:2319}, and the next one the rest from {skill:393} 200. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 28: Skin Medium Leather
	-- {item:2319} Medium Leather
	["Skin {item:2319}"] = "",
	-- {item:2319} Medium Leather · {skill:165} Leatherworking · {item:7285} Nimble Leather Gloves · {skill:393} Skinning
	["150 {item:2319} for {skill:165} 102-125: 25 {item:7285}; from your skinning on the way: 78 of 150 {item:2319}. Skin 73 {item:2319} at the loops of {skill:393} 150-175, the richest in it (they give no more points), then craft 24 {item:7285} ({skill:165} 102 to 125). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 29: Leatherworking recipes at 102
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 102"] = "",
	-- {skill:165} Leatherworking · {spell:9074} Nimble Leather Gloves · {skill:393} Skinning
	["Back to a {skill:165} trainer: {spell:9074} (from 95, 5s). Train Artisan {skill:393} on this visit too: it raises {skill:393}'s cap to 300, needs {skill:393} 200 and costs 5g (the arrow picks the nearest {skill:393} trainer of your faction)."] = "",

	-- Step 30: Nimble Leather Gloves to 125
	-- {item:7285} Nimble Leather Gloves
	["{item:7285} to 125"] = "",
	-- {item:7285} Nimble Leather Gloves · {item:2457} Elixir of Minor Agility · {item:2319} Medium Leather · {item:2321} Fine Thread · {item:2452} Swiftthistle · {item:765} Silverleaf · {spell:3763} Fine Leather Belt · {item:2316} Dark Leather Cloak · {item:4340} Gray Dye
	["{item:7285} is orange at 102 (yellow 120, green 132, grey 145): about 24 crafts to 125, up to 25 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2457}, 6 {item:2319} and 1 {item:2321}. Each takes an {item:2457}: an alchemist makes it from a {item:2452} and a {item:765}, and the Auction House has it cheap. With no elixirs, take {spell:3763} on to 105 and {item:2316} (from 85: 8 {item:2319}, a {item:4340} and a {item:2321}) to 125: about 28 cloaks, 224 {item:2319} in all."] = "",

	-- Step 31: Leatherworking recipes at 125
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 125"] = "",
	-- {skill:165} Leatherworking · {spell:3818} Cured Heavy Hide · {spell:3780} Heavy Armor Kit
	["Back to a {skill:165} trainer: {spell:3818} (from 125, 5s) and {spell:3780} (from 125, 7s 50c)."] = "",

	-- Step 32: Cured Heavy Hide to 140
	-- {spell:3818} Cured Heavy Hide
	["{spell:3818} to 140"] = "",
	-- {spell:3818} Cured Heavy Hide · {item:4235} Heavy Hide
	["{spell:3818} is orange at 125 (yellow 135, green 140, grey 145): about 17 crafts to 140, up to 19 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:4235} and 3 Salt. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 33: Skinning 200-225: Beasts 38-40
	-- {skill:393} Skinning
	["{skill:393} 200-225: Beasts 38-40"] = "",
	-- {skill:393} Skinning · {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather
	["Skin from {skill:393} 200 to 225 for {spell:3780}: this loop gives {item:4234}, and the next one the rest from {skill:393} 225. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 34: Skinning 225-250: Beasts 41-45
	-- {skill:393} Skinning
	["{skill:393} 225-250: Beasts 41-45"] = "",
	-- {skill:393} Skinning · {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather
	["Skin from {skill:393} 225 to 250 for {spell:3780}: this loop gives {item:4234}, and the next one the rest from {skill:393} 250. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 35: Skin Heavy Leather
	-- {item:4234} Heavy Leather
	["Skin {item:4234}"] = "",
	-- {item:4234} Heavy Leather · {skill:165} Leatherworking · {skill:393} Skinning
	-- plural, as words: Heavy Armor Kits = {spell:3780} Heavy Armor Kit
	["65 {item:4234} for {skill:165} 140-150: 13 Heavy Armor Kits; from your skinning on the way: 31 of 65 {item:4234}. Skin 35 {item:4234} at the loops of {skill:393} 200-225, the richest in it (they give no more points), then craft 11 Heavy Armor Kits ({skill:165} 140 to 150). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 36: Heavy Armor Kit to 150
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 150"] = "",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread · {skill:165} Leatherworking
	["{spell:3780} is orange at 140 (yellow 145, green 155, grey 165): about 11 crafts to 150, up to 13 for 9 players in 10 (the gathered materials above count that many). Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. {skill:165} 150 is a Legacy System milestone."] = "",

	-- Step 37: Leatherworking 150-225: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 150-225: vendor goods"] = "",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {npc:3366} Tamar
	["Buy the whole bracket's share in one go: 29 {item:2321} (29s), 15 Salt (7s 50c) and 145 {item:4291} (7g 25s); about 7g 61s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286} and {npc:5565}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3366})."] = "",

	-- Step 38: Expert Leatherworking
	-- {skill:165} Leatherworking
	["Expert {skill:165}"] = "",
	-- {skill:165} Leatherworking · {npc:4212} Telonis · {zone:1457} Darnassus · {npc:3007} Una · {zone:1456} Thunder Bluff · {spell:7151} Barbaric Shoulders · {item:4304} Thick Leather · {item:8193} Nightscape Pants
	["Expert raises the cap from 150 to 225; it needs {skill:165} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4212} ({zone:1457}); Horde {npc:3007} ({zone:1456}). This route trains it at {npc:4212} ({zone:1457}) for the Alliance and {npc:3007} ({zone:1456}) for the Horde, who also teach the recipes of 150-225: one trainer for every visit. Learn now: {spell:7151} (from 150). 150-225 takes about 7g 61s 50c of vendor goods, plus 398 {item:4304} to gather or buy. The gathering steps below come between the visits: learn each recipe when you are back for it. {item:8193} (from 205) takes a second trip, to other trainers (below)."] = "",

	-- Step 39: Skin Heavy Leather
	-- {item:4234} Heavy Leather · {skill:165} Leatherworking · {skill:393} Skinning
	-- plural, as words: Heavy Armor Kits = {spell:3780} Heavy Armor Kit
	["100 {item:4234} for {skill:165} 150-158: 20 Heavy Armor Kits. Skin 100 {item:4234} at the loops of {skill:393} 200-225, the richest in it (they give no more points), then craft 15 Heavy Armor Kits ({skill:165} 150 to 158). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 40: Heavy Armor Kit to 158
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 158"] = "",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread
	["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 15 crafts to 158, up to 20 for 9 players in 10 (the gathered materials above count that many). Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. If you got here without learning {spell:3780}, learn it now: an earlier step teaches it."] = "",

	-- Step 41: Skin Heavy Leather
	-- {item:4234} Heavy Leather · {skill:165} Leatherworking · {item:5964} Barbaric Shoulders · {skill:393} Skinning
	["56 {item:4234} for {skill:165} 158-165: 7 {item:5964}. Skin 56 {item:4234} at the loops of {skill:393} 200-225, the richest in it (they give no more points), then craft 7 {item:5964} ({skill:165} 158 to 165). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 42: Barbaric Shoulders to 165
	-- {item:5964} Barbaric Shoulders
	["{item:5964} to 165"] = "",
	-- {item:5964} Barbaric Shoulders · {item:4234} Heavy Leather · {item:4236} Cured Heavy Hide · {item:2321} Fine Thread
	["{item:5964} is orange at 158 (yellow 170, green 180, grey 190): about 7 crafts to 165, a point every craft. Each takes 8 {item:4234}, 1 {item:4236} and 2 {item:2321}. Use the 7 {item:4236} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 43: Skin Heavy Leather
	-- {item:4234} Heavy Leather · {skill:165} Leatherworking · {item:5966} Guardian Gloves · {skill:393} Skinning
	["60 {item:4234} for {skill:165} 165-180: 15 {item:5966}. Skin 60 {item:4234} at the loops of {skill:393} 200-225, the richest in it (they give no more points), then craft 15 {item:5966} ({skill:165} 165 to 180). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 44: Leatherworking recipes at 165
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 165"] = "",
	-- {spell:7156} Guardian Gloves
	["Back to the Expert trainer: {spell:7156} (from 165)."] = "",

	-- Step 45: Guardian Gloves to 180
	-- {item:5966} Guardian Gloves
	["{item:5966} to 180"] = "",
	-- {item:5966} Guardian Gloves · {item:4234} Heavy Leather · {spell:3818} Cured Heavy Hide · {item:4291} Silken Thread
	["{item:5966} is orange at 165 (yellow 185, green 195, grey 205): about 15 crafts to 180, a point every craft. Each takes 4 {item:4234}, 1 {spell:3818} and 1 {item:4291}. Make the 5 {spell:3818} first. Use the 10 {spell:3818} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. If you got here without learning {spell:3818}, learn it now: an earlier step teaches it."] = "",

	-- Step 46: Skinning 250-275: Beasts 46-49
	-- {skill:393} Skinning
	["{skill:393} 250-275: Beasts 46-49"] = "",
	-- {skill:393} Skinning · {item:8176} Nightscape Headband · {item:4304} Thick Leather
	["Skin from {skill:393} 250 to 275 for {item:8176}: this loop gives {item:4304}, and the next one the rest from {skill:393} 275. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 47: Skin Thick Leather
	-- {item:4304} Thick Leather
	["Skin {item:4304}"] = "",
	-- {item:4304} Thick Leather · {skill:165} Leatherworking · {skill:393} Skinning
	-- plural, as words: Nightscape Headbands = {item:8176} Nightscape Headband
	["230 {item:4304} for {skill:165} 180-213: 46 Nightscape Headbands; from your skinning on the way: 108 of 230 {item:4304}. Skin 123 {item:4304} at the loops of {skill:393} 250-275, the richest in it (they give no more points), then craft 41 Nightscape Headbands ({skill:165} 180 to 213). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 48: Leatherworking recipes at 180
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 180"] = "",
	-- {spell:10507} Nightscape Headband
	["Back to the Expert trainer: {spell:10507} (from 180)."] = "",

	-- Step 49: Nightscape Headband to 213
	-- {item:8176} Nightscape Headband
	["{item:8176} to 213"] = "",
	-- {item:8176} Nightscape Headband · {item:4304} Thick Leather · {item:4291} Silken Thread
	["{item:8176} is orange at 180 (yellow 200, green 210, grey 220): about 41 crafts to 213, up to 46 for 9 players in 10 (the gathered materials above count that many). Each takes 5 {item:4304} and 2 {item:4291}. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 50: Skin Thick Leather
	-- {item:4304} Thick Leather · {skill:165} Leatherworking · {item:8193} Nightscape Pants · {skill:393} Skinning
	["168 {item:4304} for {skill:165} 213-225: 12 {item:8193}. Skin 168 {item:4304} at the loops of {skill:393} 250-275, the richest in it (they give no more points), then craft 12 {item:8193} ({skill:165} 213 to 225). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 51: Leatherworking recipes at 213
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 213"] = "",
	-- {spell:10548} Nightscape Pants · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {skill:165} Leatherworking
	["{spell:10548} (from 205) is taught only by the Artisan trainers: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). You can train Artisan there now if you are level 35 (it needs {skill:165} 200), which saves the trip at 225."] = "",

	-- Step 52: Nightscape Pants to 225
	-- {item:8193} Nightscape Pants
	["{item:8193} to 225"] = "",
	-- {item:8193} Nightscape Pants · {item:4304} Thick Leather · {item:4291} Silken Thread · {skill:165} Leatherworking
	["{item:8193} is orange at 213 (yellow 225, green 235, grey 245): about 12 crafts to 225, a point every craft. Each takes 14 {item:4304} and 4 {item:4291}. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:165} 225 is a Legacy System milestone."] = "",

	-- Step 53: Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Artisan {skill:165}"] = "",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {spell:19058} Rugged Armor Kit · {item:8170} Rugged Leather · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300; it needs {skill:165} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). This route trains it at {npc:11097} ({zone:1425}) for the Alliance and {npc:11098} ({zone:1444}) for the Horde, who also teach the recipes of 225-300: one trainer for every visit. Learn now: {spell:19058} (from 225). 225-300 takes about 3g 40s of recipes and 44g 90s of vendor goods, plus 1205 {item:8170} and 500 {item:14047} to gather or buy."] = "",

	-- Step 54: Leatherworking 225-300: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 225-300: vendor goods"] = "",
	-- {item:2325} Black Dye · {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3366} Tamar
	["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347} and {npc:5565}; {zone:1454}: {npc:3364} and {npc:3366})."] = "",

	-- Step 55: Pattern: Wicked Leather Gauntlets
	-- {item:15725} Pattern: Wicked Leather Gauntlets · {item:15083} Wicked Leather Gauntlets · {skill:165} Leatherworking · {npc:12942} Leonard Porter · {zone:1422} Western Plaguelands · {npc:12943} Werg Thickblade
	["{item:15725} teaches {item:15083} ({skill:165} 235) for 1g 20s. Sold by Alliance: {npc:12942} ({zone:1422}), limited stock; Horde: {npc:12943} ({zone:1422}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 56: Pattern: Runic Leather Headband
	-- {item:15756} Pattern: Runic Leather Headband · {item:15094} Runic Leather Headband · {skill:165} Leatherworking · {npc:12941} Jase Farlane · {zone:1423} Eastern Plaguelands
	["{item:15756} teaches {item:15094} ({skill:165} 265) for 2g 20s. Sold by {npc:12941} ({zone:1423}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 57: Get Runecloth
	-- {item:14047} Runecloth
	["Get {item:14047}"] = "",
	-- {item:14047} Runecloth · {skill:165} Leatherworking
	-- plural, as words: Runic Leather Headbands = {item:15094} Runic Leather Headband
	["500 {item:14047} for {skill:165} 225-300: 50 Runic Leather Headbands. Humanoids of level 45-60 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14047} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 58: Skinning 275-300: Beasts 48-54
	-- {skill:393} Skinning
	["{skill:393} 275-300: Beasts 48-54"] = "",
	-- {skill:393} Skinning · {item:15564} Rugged Armor Kit · {item:8170} Rugged Leather
	["Skin from {skill:393} 275 to 300 for {item:15564}: this loop gives {item:8170}, and the next one the rest from {skill:393} 300. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 59: Skin Rugged Leather
	-- {item:8170} Rugged Leather
	["Skin {item:8170}"] = "",
	-- {item:8170} Rugged Leather · {skill:165} Leatherworking · {skill:393} Skinning
	-- plural, as words: Rugged Armor Kits = {item:15564} Rugged Armor Kit
	["145 {item:8170} for {skill:165} 225-239: 29 Rugged Armor Kits; from your skinning on the way: 104 of 145 {item:8170}. Skin 41 {item:8170} at the loops of {skill:393} 275-300, the richest in it (they give no more points), then craft 23 Rugged Armor Kits ({skill:165} 225 to 239). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 60: Rugged Armor Kit to 239
	-- {item:15564} Rugged Armor Kit
	["{item:15564} to 239"] = "",
	-- {item:15564} Rugged Armor Kit · {item:8170} Rugged Leather · {npc:7866} Peter Galen · {zone:1447} Azshara · {npc:7867} Thorkaf Dragoneye · {zone:1418} Badlands · {item:8204} Tough Scorpid Gloves · {zone:1446} Tanaris · {item:8165} Worn Dragonscale · {npc:7868} Sarah Tanner · {zone:1427} Searing Gorge · {npc:7869} Brumn Winterhoof · {zone:1417} Arathi Highlands · {item:7077} Heart of Fire · {item:7079} Globe of Water · {item:7075} Core of Earth · {item:7081} Breath of Wind · {npc:7870} Caryssia Moonhunter · {zone:1444} Feralas · {npc:7871} Se'Jib · {zone:1434} Stranglethorn Vale · {item:8211} Wild Leather Vest · {npc:7852} Pratt McGrubben · {npc:7854} Jangdor Swiftstrider · {item:279941} Tanning Rack
	-- plural, as words: Tough Scorpid Breastplates = {item:8203} Tough Scorpid Breastplate
	["{item:15564} is yellow at 225 (yellow 225, green 235, grey 245): about 23 crafts to 239, up to 29 for 9 players in 10 (the gathered materials above count that many). Each takes 5 {item:8170}. Five {item:8170} a craft. Specialisation (optional): at 225 and character level 40. Dragonscale: {npc:7866} ({zone:1447}) or {npc:7867} ({zone:1418}) wants 2 Tough Scorpid Breastplates, 2 {item:8204} (patterns drop from the Wastewander bandits in {zone:1446}) and 10 {item:8165}. Elemental: {npc:7868} ({zone:1427}) or {npc:7869} ({zone:1417}) wants 2 each of {item:7077}, {item:7079}, {item:7075} and {item:7081}. Tribal (also from 225, as Forever's quest data asks): {npc:7870} ({zone:1444}) or {npc:7871} ({zone:1434}) wants a {item:8211} and Helmet, after the Wild Leather quests from {npc:7852} or {npc:7854} in {zone:1444}. On Forever the specialisation patterns need a {item:279941}. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30)."] = "",

	-- Step 61: Skin Rugged Leather
	-- {item:8170} Rugged Leather · {skill:165} Leatherworking · {item:15083} Wicked Leather Gauntlets · {skill:393} Skinning
	["360 {item:8170} for {skill:165} 239-269: 45 {item:15083}. Skin 360 {item:8170} at the loops of {skill:393} 275-300, the richest in it (they give no more points), then craft 39 {item:15083} ({skill:165} 239 to 269). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 62: Wicked Leather Gauntlets to 269
	-- {item:15083} Wicked Leather Gauntlets
	["{item:15083} to 269"] = "",
	-- {item:15083} Wicked Leather Gauntlets · {item:8170} Rugged Leather · {item:2325} Black Dye · {item:14341} Rune Thread
	["{item:15083} is orange at 239 (yellow 255, green 265, grey 275): about 39 crafts to 269, up to 45 for 9 players in 10 (the gathered materials above count that many). Each takes 8 {item:8170}, 1 {item:2325} and 1 {item:14341}. Eight {item:8170} a craft; {item:2325} and {item:14341} from leatherworking or tailoring vendors."] = "",
	["from the recipe in your bags"] = "",

	-- Step 63: Skin Rugged Leather
	-- {item:8170} Rugged Leather · {skill:165} Leatherworking · {skill:393} Skinning
	-- plural, as words: Runic Leather Headbands = {item:15094} Runic Leather Headband
	["700 {item:8170} for {skill:165} 269-300: 50 Runic Leather Headbands. Skin 700 {item:8170} at the loops of {skill:393} 275-300, the richest in it (they give no more points), then craft 43 Runic Leather Headbands ({skill:165} 269 to 300). The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 64: Runic Leather Headband to 300
	-- {item:15094} Runic Leather Headband
	["{item:15094} to 300"] = "",
	-- {item:15094} Runic Leather Headband · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14341} Rune Thread · {skill:165} Leatherworking
	["{item:15094} is orange at 269 (yellow 285, green 295, grey 305): about 43 crafts to 300, up to 50 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:8170}, 10 {item:14047} and 1 {item:14341}. 14 {item:8170} and 10 {item:14047} a craft: the dearest stretch. {skill:165} 300 is a Legacy System milestone."] = "",
}
