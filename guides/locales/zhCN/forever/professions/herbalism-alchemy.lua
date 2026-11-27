-- Chinese (simplified) (zhCN): the guide forever/professions/herbalism-alchemy (forever/professions/herbalism-alchemy.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Herbalism and Alchemy
	-- {skill:182} Herbalism · {skill:171} Alchemy
	["Learn {skill:182} and {skill:171}"] = "",
	-- {skill:171} Alchemy · {npc:1215} Alchemist Mallory · {zone:1429} Elwynn Forest · {npc:3603} Cyndra Kindwhisper · {zone:1438} Teldrassil · {npc:1470} Ghak Healtouch · {zone:1432} Loch Modan · {npc:253004} Iaadaria Bitterwind · {zone:2521} Zephras Isle · {npc:11041} Milla Fairancora · {zone:1457} Darnassus · {npc:257019} Nyassa Swiftdraught · {npc:5500} Tel'Athir · {zone:1453} Stormwind City · {npc:257005} Valiena Swiftgale · {npc:1246} Vosur Brakthel · {zone:1455} Ironforge · {npc:2132} Carolai Anise · {zone:1420} Tirisfal Glades · {npc:11044} Doctor Martin Felben · {zone:1458} Undercity · {npc:11047} Kray · {zone:1456} Thunder Bluff · {npc:3184} Miao'zan · {zone:1411} Durotar · {npc:11046} Whuut · {zone:1454} Orgrimmar · {skill:182} Herbalism · {item:2447} Peacebloom · {item:765} Silverleaf
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Apprentice {skill:171} lets you craft up to 75 for 10c, at any character level. Not every {skill:171} trainer teaches it: Alliance {npc:1215} ({zone:1429}), {npc:3603} ({zone:1438}), {npc:1470} ({zone:1432}), {npc:253004} ({zone:2521}), {npc:11041} ({zone:1457}), {npc:257019} ({zone:2521}), {npc:5500} ({zone:1453}), {npc:257005} ({zone:2521}) and {npc:1246} ({zone:1455}); Horde {npc:2132} ({zone:1420}), {npc:11044} ({zone:1458}), {npc:11047} ({zone:1456}), {npc:3184} ({zone:1411}), {npc:257019} ({zone:2521}), {npc:257005} ({zone:2521}) and {npc:11046} ({zone:1454}). The arrow picks the nearest of your faction. Pair it with {skill:182}: {item:2447} and {item:765} grow in every starting zone, and Empty Vials cost 4c at any alchemy or trade supplies vendor. 1-75 takes about 3s 28c of vendor goods, plus 87 {item:765} and 110 {item:2447} to gather or buy. Learn Apprentice {skill:182} on the same trip: any {skill:182} trainer of your faction teaches it at any level, and the arrow picks the nearest."] = "",

	-- Step 2: Alchemy 1-75: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 1-75: vendor goods"] = "",
	-- {item:3371} Empty Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 82 {item:3371} (3s 28c); about 3s 28c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "",

	-- Step 3: Herbalism 1-15: Stunted Silverleaf & Wilted Peacebloom
	-- {skill:182} Herbalism · {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom
	["Pick from {skill:182} 1 to 15 for {item:5997}: this loop gives {item:765} and {item:2447}, and the next one the rest from {skill:182} 15. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 4: Herbalism 15-50: Peacebloom & Stunted Silverleaf
	-- {skill:182} Herbalism · {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom
	["Pick from {skill:182} 15 to 50 for {item:5997}: this loop gives {item:765} and {item:2447}, and the next one the rest from {skill:182} 50. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 5: Herbalism 50-70: Mageroyal
	-- {skill:182} Herbalism · {item:5997} Elixir of Minor Defense · {item:765} Silverleaf
	["Pick from {skill:182} 50 to 70 for {item:5997}: this loop gives {item:765}, and the next one the rest from {skill:182} 70. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 6: Journeyman Herbalism
	-- {skill:182} Herbalism
	["Journeyman {skill:182}"] = "",
	-- {skill:182} Herbalism
	["Journeyman {skill:182} raises {skill:182}'s cap to 150, needs {skill:182} 50 and costs 5s (the arrow picks the nearest {skill:182} trainer of your faction)."] = "",

	-- Step 7: Herbalism 70-100: Mageroyal & Briarthorn
	-- {skill:182} Herbalism · {item:5997} Elixir of Minor Defense · {item:765} Silverleaf
	["Pick from {skill:182} 70 to 100 for {item:5997}: this loop gives {item:765}, and the next one the rest from {skill:182} 100. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 8: Pick Silverleaf and Peacebloom
	-- {item:765} Silverleaf · {item:2447} Peacebloom
	["Pick {item:765} and {item:2447}"] = "",
	-- {item:765} Silverleaf · {item:2447} Peacebloom · {skill:171} Alchemy · {skill:182} Herbalism
	["87 {item:765} and 87 {item:2447} for {skill:171} 1-75: 87 Elixirs of Minor Defense. Pick 87 {item:765} and 87 {item:2447} ({skill:182} 100), then craft 82 Elixirs of Minor Defense ({skill:171} 1 to 75). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 9: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "",
	-- {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom · {item:3371} Empty Vial
	["{item:5997} is orange at 1 (yellow 55, green 75, grey 95): about 82 crafts to 75, up to 87 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:765}, 1 {item:2447} and 1 {item:3371}. Known from the start and the cheapest way through the Apprentice range. Keep the elixirs (armour while you level) or sell them."] = "",

	-- Step 10: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "",
	-- {skill:171} Alchemy · {npc:4900} Alchemist Narett · {zone:1445} Dustwallow Marsh · {npc:2837} Jaxin Chong · {zone:1434} Stranglethorn Vale · {npc:3964} Kylanna · {zone:1440} Ashenvale · {npc:5499} Lilyssia Nightbreeze · {zone:1453} Stormwind City · {npc:11042} Sylvanna Forestmoon · {zone:1457} Darnassus · {npc:5177} Tally Berryfizz · {zone:1455} Ironforge · {npc:3009} Bena Winterhoof · {zone:1456} Thunder Bluff · {npc:4609} Doctor Marsh · {zone:1458} Undercity · {npc:2391} Serge Hinott · {zone:1424} Hillsbrad Foothills · {npc:3347} Yelmak · {zone:1454} Orgrimmar · {spell:2334} Elixir of Minor Fortitude · {spell:1230564} Mana Well · {item:2447} Peacebloom · {item:3371} Empty Vial · {item:785} Mageroyal · {item:2449} Earthroot · {item:2450} Briarthorn · {item:2453} Bruiseweed
	["Journeyman raises the cap from 75 to 150 for 4s 50c (Classic's price; Forever's is not in the data); it needs {skill:171} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:171} trainer teaches it: Alliance {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) and {npc:5177} ({zone:1455}); Horde {npc:3009} ({zone:1456}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:2391} ({zone:1424}) and {npc:3347} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:2334} (from 50, 2s 50c). Also learn {spell:1230564} (1s): Forever's {skill:171} camp item, 1 {item:2447} and 1 {item:3371}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:171} quest from your starting area's camping guide (after The Great Outdoors) sends you to an alchemy trainer who teaches it free. 75-150 takes about 2s 50c of recipes and 8s 68c of vendor goods, plus 50 {item:785}, 46 {item:2449}, 158 {item:2450} and 58 {item:2453} to gather or buy."] = "",

	-- Step 11: Alchemy 75-150: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 75-150: vendor goods"] = "",
	-- {item:3371} Empty Vial · {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 67 {item:3371} (2s 68c) and 15 {item:3372} (6s); about 8s 68c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "",

	-- Step 12: Pick Peacebloom and Earthroot
	-- {item:2447} Peacebloom · {item:2449} Earthroot
	["Pick {item:2447} and {item:2449}"] = "",
	-- {item:2447} Peacebloom · {item:2449} Earthroot · {skill:171} Alchemy · {skill:182} Herbalism
	["23 {item:2447} and 46 {item:2449} for {skill:171} 75-92: 23 Elixirs of Minor Fortitude; from your herbalism on the way: 44 of 46 {item:2449}. Pick 23 {item:2447} and 3 {item:2449} at the loops of {skill:182} 1-15, the richest in it (they give no more points), then craft 20 Elixirs of Minor Fortitude ({skill:171} 75 to 92). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 13: Elixir of Minor Fortitude to 92
	-- {spell:2334} Elixir of Minor Fortitude
	["{spell:2334} to 92"] = "",
	-- {spell:2334} Elixir of Minor Fortitude · {item:2449} Earthroot · {item:2447} Peacebloom · {item:3371} Empty Vial
	["{spell:2334} is orange at 75 (yellow 80, green 100, grey 120): about 20 crafts to 92, up to 23 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:2449}, 1 {item:2447} and 1 {item:3371}. Two {item:2449} and a {item:2447} a craft, herbs of the starting zones and the 10-20 zones; orange to 80."] = "",

	-- Step 14: Herbalism 100-115: Stranglekelp & Bruiseweed
	-- {skill:182} Herbalism · {spell:3171} Elixir of Wisdom · {item:2450} Briarthorn
	["Pick from {skill:182} 100 to 115 for {spell:3171}: this loop gives {item:2450}, and the next one the rest from {skill:182} 115. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 15: Herbalism 115-125: Stranglekelp & Bruiseweed
	-- {skill:182} Herbalism · {spell:3171} Elixir of Wisdom · {item:2450} Briarthorn
	["Pick from {skill:182} 115 to 125 for {spell:3171}: this loop gives {item:2450}, and the next one the rest from {skill:182} 125. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 16: Herbalism 125-150: Bruiseweed & Kingsblood
	-- {skill:182} Herbalism · {spell:3171} Elixir of Wisdom · {item:2450} Briarthorn
	["Pick from {skill:182} 125 to 150 for {spell:3171}: this loop gives {item:2450}, and the next one the rest from {skill:182} 150. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 17: Expert Herbalism
	-- {skill:182} Herbalism
	["Expert {skill:182}"] = "",
	-- {skill:182} Herbalism
	["Expert {skill:182} raises {skill:182}'s cap to 225, needs {skill:182} 125 and costs 50s (the arrow picks the nearest {skill:182} trainer of your faction)."] = "",

	-- Step 18: Herbalism 150-160: Kingsblood & Liferoot
	-- {skill:182} Herbalism · {spell:3171} Elixir of Wisdom · {item:2450} Briarthorn
	["Pick from {skill:182} 150 to 160 for {spell:3171}: this loop gives {item:2450}, and the next one the rest from {skill:182} 160. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 19: Pick Mageroyal and Briarthorn
	-- {item:785} Mageroyal · {item:2450} Briarthorn
	["Pick {item:785} and {item:2450}"] = "",
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {skill:171} Alchemy · {skill:182} Herbalism
	["50 {item:785} and 100 {item:2450} for {skill:171} 92-135: 50 Elixirs of Wisdom; from your herbalism on the way: 50 of 50 {item:785} and 29 of 100 {item:2450}. Pick 71 {item:2450} at the loops of {skill:182} 70-100, the richest in it (they give no more points), then craft 47 Elixirs of Wisdom ({skill:171} 92 to 135). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 20: Alchemy recipes at 92
	-- {skill:171} Alchemy
	["{skill:171} recipes at 92"] = "",
	-- {skill:171} Alchemy · {spell:3171} Elixir of Wisdom
	["Back to an {skill:171} trainer: {spell:3171} (from 90)."] = "",

	-- Step 21: Elixir of Wisdom to 135
	-- {spell:3171} Elixir of Wisdom
	["{spell:3171} to 135"] = "",
	-- {spell:3171} Elixir of Wisdom · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3371} Empty Vial
	["{spell:3171} is orange at 92 (yellow 120, green 140, grey 160): about 47 crafts to 135, up to 50 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:785}, 2 {item:2450} and 1 {item:3371}. Two {item:2450} and a {item:785} a craft, both from the 10-25 zones; orange to 120."] = "",

	-- Step 22: Pick Briarthorn and Bruiseweed
	-- {item:2450} Briarthorn · {item:2453} Bruiseweed
	["Pick {item:2450} and {item:2453}"] = "",
	-- {item:2450} Briarthorn · {item:2453} Bruiseweed · {skill:171} Alchemy · {skill:182} Herbalism
	-- plural, as words: Lesser Troll's Blood Elixirs = {spell:3176} Lesser Troll's Blood Elixir
	["30 {item:2450} and 30 {item:2453} for {skill:171} 135-150: 15 Lesser Troll's Blood Elixirs; from your herbalism on the way: 30 of 30 {item:2453}. Pick 30 {item:2450} at the loops of {skill:182} 70-100, the richest in it (they give no more points), then craft 15 Lesser Troll's Blood Elixirs ({skill:171} 135 to 150). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 23: Alchemy recipes at 135
	-- {skill:171} Alchemy
	["{skill:171} recipes at 135"] = "",
	-- {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir
	["Back to an {skill:171} trainer: {spell:3176} (from 125)."] = "",

	-- Step 24: Lesser Troll's Blood Elixir to 150
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 150"] = "",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial · {skill:171} Alchemy
	["{spell:3176} is orange at 135 (yellow 150, green 170, grey 190): about 15 crafts to 150, a point every craft. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. {skill:171} 150 is a Legacy System milestone."] = "",

	-- Step 25: Alchemy 150-225: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 150-225: vendor goods"] = "",
	-- {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 83 {item:3372} (33s 20c); about 33s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "",

	-- Step 26: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {object:2045} Stranglekelp · {object:2046} Goldthorn
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4160} ({zone:1457}); Horde {npc:4611} ({zone:1458}). This route trains it at {npc:4160} ({zone:1457}) for the Alliance and {npc:4611} ({zone:1458}) for the Horde, who also teach the recipes of 150-225: one trainer for every visit. 150-225 takes about 33s 20c of vendor goods, plus 45 {object:1623}, 42 {item:3356}, 42 {object:2045} and 45 {object:2046} to gather or buy. The gathering steps below come between the visits: learn each recipe when you are back for it."] = "",

	-- Step 27: Pick Briarthorn and Bruiseweed
	-- {item:2450} Briarthorn · {item:2453} Bruiseweed · {skill:171} Alchemy · {skill:182} Herbalism
	-- plural, as words: Lesser Troll's Blood Elixirs = {spell:3176} Lesser Troll's Blood Elixir
	["28 {item:2450} and 28 {item:2453} for {skill:171} 150-160: 14 Lesser Troll's Blood Elixirs; from your herbalism on the way: 26 of 28 {item:2453}. Pick 28 {item:2450} and 3 {item:2453} at the loops of {skill:182} 70-100, the richest in it (they give no more points), then craft 12 Lesser Troll's Blood Elixirs ({skill:171} 150 to 160). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 28: Lesser Troll's Blood Elixir to 160
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 160"] = "",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial
	["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160, up to 14 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. If you got here without learning {spell:3176}, learn it now: an earlier step teaches it."] = "",

	-- Step 29: Pick Kingsblood and Stranglekelp (Herbalism 160-169)
	-- {item:3356} Kingsblood · {object:2045} Stranglekelp · {skill:182} Herbalism
	["Pick {item:3356} and {object:2045} ({skill:182} 160-169)"] = "",
	-- {item:3356} Kingsblood · {object:2045} Stranglekelp · {skill:171} Alchemy · {skill:182} Herbalism
	-- plural, as words: Mana Potions = {spell:3452} Mana Potion
	["42 {item:3356} and 42 {object:2045} for {skill:171} 160-195: 42 Mana Potions; from your herbalism on the way: 36 of 42 {item:3356} and 18 of 42 {object:2045}. Pick 7 {item:3356} and 24 {object:2045} ({skill:182} 160 to 169) at the loops of {skill:182} 100-115, the richest in it (they give no more points), then craft 39 Mana Potions ({skill:171} 160 to 195). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 30: Alchemy recipes at 160
	-- {skill:171} Alchemy
	["{skill:171} recipes at 160"] = "",
	-- {spell:3452} Mana Potion
	["Back to the Expert trainer: {spell:3452} (from 160)."] = "",

	-- Step 31: Mana Potion to 195
	-- {spell:3452} Mana Potion
	["{spell:3452} to 195"] = "",
	-- {spell:3452} Mana Potion · {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3372} Leaded Vial
	["{spell:3452} is orange at 160 (yellow 180, green 200, grey 220): about 39 crafts to 195, up to 42 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:3820}, 1 {item:3356} and 1 {item:3372}. {item:3820} grows under water along the coasts: bring a water breathing elixir or come up for air. {item:3356} grows in the 20-40 zones."] = "",

	-- Step 32: Herbalism 169-170: Kingsblood & Liferoot
	-- {skill:182} Herbalism · {item:8951} Elixir of Defense · {object:2046} Goldthorn
	["{skill:182} 169 to 170 before {item:8951}: its {object:2046} come from {skill:182} 170. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 33: Herbalism 170-185: Liferoot & Goldthorn
	-- {skill:182} Herbalism · {item:8951} Elixir of Defense · {object:2046} Goldthorn
	["Pick from {skill:182} 170 to 185 for {item:8951}: this loop gives {object:2046}, and the next one the rest from {skill:182} 185. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 34: Herbalism 185-200: Goldthorn & Khadgar's Whisker
	-- {skill:182} Herbalism · {item:8951} Elixir of Defense · {object:2046} Goldthorn
	["Pick from {skill:182} 185 to 200 for {item:8951}: this loop gives {object:2046}, and the next one the rest from {skill:182} 200. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 35: Herbalism 200-210: Goldthorn & Khadgar's Whisker
	-- {skill:182} Herbalism · {item:8951} Elixir of Defense · {object:2046} Goldthorn
	["Pick from {skill:182} 200 to 210 for {item:8951}: this loop gives {object:2046}, and the next one the rest from {skill:182} 210. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 36: Artisan Herbalism
	-- {skill:182} Herbalism
	["Artisan {skill:182}"] = "",
	-- {skill:182} Herbalism
	["Artisan {skill:182} raises {skill:182}'s cap to 300, needs {skill:182} 200 and costs 5g (the arrow picks the nearest {skill:182} trainer of your faction)."] = "",

	-- Step 37: Pick Wild Steelbloom and Goldthorn (Herbalism 210-227)
	-- {item:3355} Wild Steelbloom · {object:2046} Goldthorn · {skill:182} Herbalism
	["Pick {item:3355} and {object:2046} ({skill:182} 210-227)"] = "",
	-- {item:3355} Wild Steelbloom · {object:2046} Goldthorn · {skill:171} Alchemy · {skill:182} Herbalism
	["34 {item:3355} and 34 {object:2046} for {skill:171} 195-225: 34 Elixirs of Defense; from your herbalism on the way: 24 of 34 {item:3355}. Pick 11 {item:3355} and 34 {object:2046} ({skill:182} 210 to 227), then craft 32 Elixirs of Defense ({skill:171} 195 to 225). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 38: Alchemy recipes at 195
	-- {skill:171} Alchemy
	["{skill:171} recipes at 195"] = "",
	-- {spell:11450} Elixir of Defense
	["Back to the Expert trainer: {spell:11450} (from 195)."] = "",

	-- Step 39: Elixir of Defense to 225
	-- {item:8951} Elixir of Defense
	["{item:8951} to 225"] = "",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands · {skill:171} Alchemy
	["{item:8951} is orange at 195 (yellow 215, green 235, grey 255): about 32 crafts to 225, up to 34 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). {skill:171} 225 is a Legacy System milestone."] = "",

	-- Step 40: Alchemy 225-300: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 225-300: vendor goods"] = "",
	-- {item:3372} Leaded Vial · {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 51 {item:3372} (20s 40c) and 86 {item:8925} (4g 30s); about 4g 50s 40c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "",

	-- Step 41: Recipe: Elixir of Superior Defense
	-- {item:13478} Recipe: Elixir of Superior Defense · {item:13445} Elixir of Greater Defense · {skill:171} Alchemy · {npc:5178} Soolie Berryfizz · {zone:1455} Ironforge · {npc:3348} Kor'geld · {zone:1454} Orgrimmar
	["{item:13478} teaches {item:13445} ({skill:171} 265) for 1g 30s. Sold by Alliance: {npc:5178} ({zone:1455}), limited stock; Horde: {npc:3348} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "",

	-- Step 42: Get Stonescale Eel
	-- {item:13422} Stonescale Eel
	["Get {item:13422}"] = "",
	-- {item:13422} Stonescale Eel · {skill:171} Alchemy · {object:180712} Stonescale Eel Swarm
	["48 {item:13422} for {skill:171} 225-300: 48 Elixirs of Greater Defense. Fish them from the {object:180712} pools at the marked spot. Or buy them at the Auction House."] = "",

	-- Step 43: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "",
	-- {skill:171} Alchemy · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:259585} Master Mycologist Shurome · {zone:1448} Felwood · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {item:8831} Purple Lotus · {item:8838} Sungrass · {item:13422} Stonescale Eel
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:7948} ({zone:1444}) and {npc:259585} ({zone:1448}); Horde {npc:259585} ({zone:1448}) and {npc:1386} ({zone:1435}). This route trains it at {npc:7948} ({zone:1444}) for the Alliance and {npc:1386} ({zone:1435}) for the Horde, who also teach the recipes of 225-300: one trainer for every visit. 225-300 takes about 1g 30s of recipes and 4g 50s 40c of vendor goods, plus 144 {item:8831}, 48 {item:8838} and 48 {item:13422} to gather or buy. The gathering steps below come between the visits: learn each recipe when you are back for it."] = "",

	-- Step 44: Herbalism 227-230: Khadgar's Whisker & Purple Lotus
	-- {skill:182} Herbalism · {item:8951} Elixir of Defense · {object:2046} Goldthorn
	["Pick from {skill:182} 227 to 230 for {item:8951}: this loop gives {object:2046}, and the next one the rest from {skill:182} 230. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 45: Pick Wild Steelbloom and Goldthorn
	-- {object:1623} Wild Steelbloom · {item:3821} Goldthorn
	["Pick {object:1623} and {item:3821}"] = "",
	-- {object:1623} Wild Steelbloom · {item:3821} Goldthorn · {skill:171} Alchemy · {skill:182} Herbalism
	["11 {object:1623} and 11 {item:3821} for {skill:171} 225-230: 11 Elixirs of Defense. Pick 11 {object:1623} and 11 {item:3821} at the loops of {skill:182} 150-160, the richest in it (they give no more points), then craft 8 Elixirs of Defense ({skill:171} 225 to 230). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 46: Elixir of Defense to 230
	-- {item:8951} Elixir of Defense
	["{item:8951} to 230"] = "",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands
	["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230, up to 11 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). If you got here without learning {item:8951}, learn it now: an earlier step teaches it."] = "",

	-- Step 47: Herbalism 230-260: Purple Lotus & Sungrass
	-- {skill:182} Herbalism · {item:12190} Dreamless Sleep Potion · {item:8831} Purple Lotus
	["Pick from {skill:182} 230 to 260 for {item:12190}: this loop gives {item:8831}, and the next one the rest from {skill:182} 260. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 48: Pick Purple Lotus
	-- {item:8831} Purple Lotus
	["Pick {item:8831}"] = "",
	-- {item:8831} Purple Lotus · {skill:171} Alchemy · {skill:182} Herbalism
	-- plural, as words: Dreamless Sleep Potions = {item:12190} Dreamless Sleep Potion
	["144 {item:8831} for {skill:171} 230-265: 48 Dreamless Sleep Potions; from your herbalism on the way: 26 of 144 {item:8831}. Pick 119 {item:8831} at the loops of {skill:182} 210-230, the richest in it (they give no more points), then craft 43 Dreamless Sleep Potions ({skill:171} 230 to 265). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 49: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "",
	-- {spell:15833} Dreamless Sleep Potion
	["Back to the Artisan trainer: {spell:15833} (from 230)."] = "",

	-- Step 50: Dreamless Sleep Potion to 265
	-- {item:12190} Dreamless Sleep Potion
	["{item:12190} to 265"] = "",
	-- {item:12190} Dreamless Sleep Potion · {item:8831} Purple Lotus · {item:8925} Crystal Vial · {skill:182} Herbalism · {zone:1425} Hinterlands · {zone:1444} Feralas · {item:8838} Sungrass
	["{item:12190} is orange at 230 (yellow 245, green 265, grey 285): about 43 crafts to 265, up to 48 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {item:8831} and 1 {item:8925}. Three {item:8831} a craft ({skill:182} 210: the {zone:1425} and {zone:1444}, mobs of level 44-47) and a {item:8925} from an alchemy vendor. The {skill:182} guide's loops there give {item:8838} for the last stretch too."] = "",

	-- Step 51: Pick Sungrass
	-- {item:8838} Sungrass
	["Pick {item:8838}"] = "",
	-- {item:8838} Sungrass · {skill:171} Alchemy · {skill:182} Herbalism
	["48 {item:8838} for {skill:171} 265-300: 48 Elixirs of Greater Defense; from your herbalism on the way: 45 of 48 {item:8838}. Pick 4 {item:8838} at the loops of {skill:182} 230-260, the richest in it (they give no more points), then craft 43 Elixirs of Greater Defense ({skill:171} 265 to 300). The arrow takes the {skill:182} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 52: Herbalism 260-285: Blindweed & Gromsblood
	-- {skill:182} Herbalism · {skill:171} Alchemy · {item:8838} Sungrass · {item:8831} Purple Lotus · {object:2046} Goldthorn · {item:13464} Golden Sansam
	["{skill:182} 260 to 285 before the last stretch: the guide ends with {skill:171}, so finish {skill:182} here. The loop also gives about 15 {item:8838}, 5 {item:8831}, 5 {object:2046} and 5 {item:13464}: keep them, the next stretches use them. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 53: Herbalism 285-300: Mountain Silversage & Plaguebloom
	-- {skill:182} Herbalism · {skill:171} Alchemy · {item:8831} Purple Lotus · {item:13465} Mountain Silversage · {item:13464} Golden Sansam · {item:13463} Dreamfoil
	["{skill:182} 285 to 300 before the last stretch: the guide ends with {skill:171}, so finish {skill:182} here. The loop also gives about 10 {item:8831}, 5 {item:13465}, 5 {item:13464} and 5 {item:13463}: keep them, the next stretches use them. The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap."] = "",

	-- Step 54: Alchemy recipes at 265
	-- {skill:171} Alchemy
	["{skill:171} recipes at 265"] = "",
	-- {spell:17551} Stonescale Oil
	["Back to the Artisan trainer: {spell:17551} (from 250)."] = "",

	-- Step 55: Elixir of Greater Defense to 300
	-- {item:13445} Elixir of Greater Defense
	["{item:13445} to 300"] = "",
	-- {item:13445} Elixir of Greater Defense · {item:13423} Stonescale Oil · {item:8838} Sungrass · {item:8925} Crystal Vial · {item:13422} Stonescale Eel · {skill:171} Alchemy
	["{item:13445} is orange at 265 (yellow 280, green 300, grey 320): about 43 crafts to 300, up to 48 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:13423}, 1 {item:8838} and 1 {item:8925}. Make the 86 {item:13423} (43 crafts) first. {item:13422} comes from the {item:13422} schools on the coasts of the 40-55 zones, or the Auction House (fishers sell them in stacks). {item:8838} grows in the 40-55 zones. {skill:171} 300 is a Legacy System milestone."] = "",
	["from the recipe in your bags"] = "",
}
