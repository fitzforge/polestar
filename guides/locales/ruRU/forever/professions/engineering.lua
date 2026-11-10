-- Russian (ruRU): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Engineering
	-- {skill:202} Engineering
	["Learn {skill:202}"] = "",
	-- {skill:202} Engineering · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore · {item:2840} Copper Bar
	["Apprentice {skill:202} lets you craft up to 75 for 10c, at any character level. Any {skill:202} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} and pair it with {skill:186}: {item:2835} and {item:2770} are the first parts. 1-75 takes about 4s 15c of recipes and 18s 18c of vendor goods, plus 46 {item:2835} and 75 {item:2840} to gather or buy."] = "",

	-- Step 2: Engineering 1-75: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 1-75: vendor goods"] = "",
	-- {item:2880} Weak Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286}; {zone:1454}: {npc:3367}, Gorina and {npc:5817})."] = "",
	["a tool, keep it in your bags"] = "",

	-- Step 3: Rough Stone (Elwynn Forest)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1429} Elwynn Forest
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1429} is marked."] = "",

	-- Step 4: Rough Stone (Dun Morogh)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1426} is marked."] = "",

	-- Step 5: Rough Stone (Darkshore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1439} Darkshore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1439} is marked."] = "",

	-- Step 6: Rough Stone (Zephras Isle)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:2521} Zephras Isle
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:2521} is marked."] = "",

	-- Step 7: Rough Stone (Durotar)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1411} Durotar
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1411} is marked."] = "",

	-- Step 8: Rough Stone (Mulgore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1412} Mulgore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1412} is marked."] = "",

	-- Step 9: Rough Stone (Tirisfal Glades)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1420} Tirisfal Glades
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1420} is marked."] = "",

	-- Step 10: Rough Blasting Powder to 35
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 35"] = "",
	-- {spell:3918} Rough Blasting Powder · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["{spell:3918} is orange at 1 (yellow 20, green 30, grey 40): about 46 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft; {item:2835} comes with the {item:2770} from Copper Veins."] = "",

	-- Step 11: Engineering recipes at 35
	-- {skill:202} Engineering
	["{skill:202} recipes at 35"] = "",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {spell:1230656} Reagent Bot · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3922} (from 30, 1s 15c). Also learn {spell:1230656} (1s): Forever's {skill:202} camp item, placed at a campsite beside a campfire. It takes a {spell:3922} and a {spell:3924}, which you learn at 30 and 50, so it gives no points. The Camping 101: {skill:202} quest from your starting area's camping guide (after The Great Outdoors) sends you to an engineering trainer who teaches it free."] = "",

	-- Step 12: Handful of Copper Bolts to 57
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 57"] = "",
	-- {spell:3922} Handful of Copper Bolts · {item:2840} Copper Bar · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2770} Copper Ore
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{spell:3922} is orange at 35 (yellow 45, green 52, grey 60): about 33 crafts to 57. Each takes 1 {item:2840}. One {item:2840} a craft. Keep the bolts: Practice Locks and later gadgets take them. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags. {item:2840} (75 for 1-75): {skill:186}: smelt {item:2770}; or the Auction House."] = "",

	-- Step 13: Engineering recipes at 57
	-- {skill:202} Engineering
	["{skill:202} recipes at 57"] = "",
	-- {skill:202} Engineering · {spell:7430} Arclight Spanner · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:7430} (from 50, 1s 50c) and {spell:3924} (from 50, 1s 50c)."] = "",

	-- Step 14: Copper Tube to 75
	-- {spell:3924} Copper Tube
	["{spell:3924} to 75"] = "",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux · {item:6219} Arclight Spanner
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is orange at 57 (yellow 80, green 95, grey 110): about 18 crafts to 75, a point every craft. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. Make the {item:6219} now, while it still gives a point: a later recipe needs it in your bags, so keep it there."] = "",
	["a tool: keep it in your bags"] = "инструмент: держите его в сумке",

	-- Step 15: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "{skill:202}: Подмастерье",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {npc:1676} Finbus Geargrind · {zone:1431} Duskwood · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11029} Trixie Quikswitch · {npc:11031} Franklin Lloyd · {zone:1458} Undercity · {npc:3412} Nogg · {zone:1454} Orgrimmar · {spell:3929} Coarse Blasting Powder · {spell:3930} Crafted Heavy Shot · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) and {npc:11029} ({zone:1455}); Horde {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "Ранг «Подмастерье» поднимает предел с 75 до 150 за 5с (цена Classic; цены Forever нет в данных); нужен навык {skill:202} 50 и уровень персонажа 10, так что его можно взять при любом визите начиная с 50. Учат ему не все учителя ({skill:202}): Альянс – {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) и {npc:11029} ({zone:1455}); Орда – {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) и Роксик ({zone:1454}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:3929} (с 75, 2с 50м) и {spell:3930} (с 75, 2с 50м). На 75-150 уйдет около 5с на рецепты и 45с на товары торговцев, плюс 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} и 2 {item:2842} – добудьте или купите.",

	-- Step 16: Engineering 75-150: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 75-150: vendor goods"] = "",
	-- {item:2880} Weak Flux · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 45 {item:2880} (45s); about 45s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286}; {zone:1454}: {npc:3367}, Gorina and {npc:5817})."] = "",

	-- Step 17: Coarse Stone (Westfall)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1436} Westfall
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1436} is marked."] = "",

	-- Step 18: Coarse Stone (Loch Modan)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "",

	-- Step 19: Coarse Stone (Darkshore)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1439} Darkshore
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1439} is marked."] = "",

	-- Step 20: Coarse Stone (The Barrens)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1413} is marked."] = "",

	-- Step 21: Coarse Stone (Silverpine Forest)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1421} Silverpine Forest
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1421} is marked."] = "",

	-- Step 22: Heavy Stone (Arathi Highlands)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "",

	-- Step 23: Heavy Stone (Ashenvale)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1440} Ashenvale
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1440} is marked."] = "",

	-- Step 24: Heavy Stone (The Barrens)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1413} The Barrens
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1413} is marked."] = "",

	-- Step 26: Crafted Heavy Shot to 94
	-- {spell:3930} Crafted Heavy Shot
	["{spell:3930} to 94"] = "",
	-- {spell:3930} Crafted Heavy Shot · {spell:3929} Coarse Blasting Powder · {item:2840} Copper Bar · {skill:186} Mining · {item:2770} Copper Ore
	["{spell:3930} is orange at 75 (yellow 85, green 90, grey 95): about 15 crafts to 94. Each takes 1 {spell:3929} and 1 {item:2840} and makes 200. Make the 15 {spell:3929} first: it gives points too while not grey. The {spell:3929} in each gives its own point while it is not grey: two chances a craft. Sell the shot to hunters or a vendor. {item:2840} (72 for 75-150): {skill:186}: smelt {item:2770}; or the Auction House."] = "",

	-- Step 27: Copper Tube to 100
	-- {spell:3924} Copper Tube
	["{spell:3924} to 100"] = "",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is yellow at 94 (yellow 80, green 95, grey 110): about 14 crafts to 100. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby."] = "",

	-- Step 28: Engineering recipes at 100
	-- {skill:202} Engineering
	["{skill:202} recipes at 100"] = "",
	-- {skill:202} Engineering · {spell:8334} Practice Lock
	["Back to an {skill:202} trainer: {spell:8334} (from 100)."] = "",

	-- Step 29: Practice Lock to 125
	-- {item:6712} Practice Lock
	["{item:6712} to 125"] = "",
	-- {item:6712} Practice Lock · {item:2841} Bronze Bar · {spell:3922} Handful of Copper Bolts · {item:2880} Weak Flux · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125. Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 29 {spell:3922} first. Use the 33 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby. {item:2841} (61 for 75-150): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House."] = "",

	-- Step 30: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "{skill:202}: рецепты на 125",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} (from 125)."] = "",

	-- Step 31: Heavy Blasting Powder to 140
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 140"] = "",
	-- {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit · Iron Grenades = {item:4390} Iron Grenade
	["{spell:3945} is yellow at 125 (yellow 125, green 135, grey 145): about 27 crafts to 140. Each takes 1 {item:2838}. One {item:2838} a craft (Iron Deposits). Keep some: Iron Grenades take one each."] = "",

	-- Step 32: Engineering recipes at 140
	-- {skill:202} Engineering
	["{skill:202} recipes at 140"] = "",
	-- {skill:202} Engineering · {spell:3973} Silver Contact · {spell:3950} Big Bronze Bomb
	["Back to an {skill:202} trainer: {spell:3973} (from 90) and {spell:3950} (from 140)."] = "",

	-- Step 33: Big Bronze Bomb to 150
	-- {spell:3950} Big Bronze Bomb
	["{spell:3950} to 150"] = "",
	-- {spell:3950} Big Bronze Bomb · {item:4377} Heavy Blasting Powder · {item:2841} Bronze Bar · {spell:3973} Silver Contact · {item:2842} Silver Bar · {skill:186} Mining · {item:2775} Silver Ore · {skill:202} Engineering
	["{spell:3950} is yellow at 140 (yellow 140, green 165, grey 190): about 10 crafts to 150. Each takes 2 {item:4377}, 3 {item:2841} and 1 {spell:3973} and makes 3. Make the 10 {spell:3973} (2 crafts) first. Use the 20 {item:4377} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. Needs an anvil nearby. {item:2842} (2 for 75-150): {skill:186}: smelt {item:2775}; or the Auction House. {skill:202} 150 is a Legacy System milestone."] = "",

	-- Step 34: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "{skill:202}: Умелец",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {zone:1454} Orgrimmar · {spell:9271} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}) and {npc:5174} ({zone:1455}); Horde {npc:8736} ({zone:1446}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912} to gather or buy."] = "Ранг «Умелец» поднимает предел со 150 до 225 за 50с (цена Classic; цены Forever нет в данных); нужен навык {skill:202} 125 и уровень персонажа 20, так что его можно взять при любом визите начиная со 125. Учат ему лишь немногие: Альянс – {npc:8736} ({zone:1446}) и {npc:5174} ({zone:1455}); Орда – {npc:8736} ({zone:1446}) и Роксик ({zone:1454}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:9271} (со 150) и {spell:3953} (со 145). На 150-225 уйдет около 31с на товары торговцев, плюс 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} и 62 {item:7912} – добудьте или купите.",

	-- Step 35: Engineering 150-225: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 150-225: vendor goods"] = "",
	-- {item:6530} Nightcrawlers · {zone:1453} Stormwind City · {npc:5494} Catherine Leland · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3333} Shankys · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 31 {item:6530} (31s); about 31s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5494} and {npc:1286}; {zone:1454}: {npc:3367}, {npc:3333} and {npc:5817})."] = "",

	-- Step 36: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Альянс)",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 37: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Орда)",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 38: Wool Cloth
	-- {item:2592} Wool Cloth · {spell:3953} Bronze Framework
	["19 {item:2592} for {spell:3953}: humanoids of level 15-30 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "",

	-- Step 39: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Альянс)",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "",

	-- Step 40: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Орда)",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30); or the Auction House. The densest cluster of {object:1732} in {zone:1440} is marked."] = "",

	-- Step 41: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Альянс)",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:1443} Desolace
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "",

	-- Step 42: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Орда)",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1441} Thousand Needles · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest cluster of {object:1735} in {zone:1441} is marked."] = "",

	-- Step 43: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Альянс)",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1434} is marked."] = "",

	-- Step 44: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Орда)",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "",

	-- Step 45: Aquadynamic Fish Attractor to 166
	-- {item:6533} Aquadynamic Fish Attractor
	["{item:6533} to 166"] = "",
	-- {item:6533} Aquadynamic Fish Attractor · {item:2841} Bronze Bar · {item:6530} Nightcrawlers · {spell:3929} Coarse Blasting Powder · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166. Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 31 {spell:3929} first. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen. {item:2841} (100 for 150-225): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House."] = "",

	-- Step 46: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953} до 175",
	-- {spell:3953} Bronze Framework · {item:2841} Bronze Bar · {item:2319} Medium Leather · {item:2592} Wool Cloth
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["{spell:3953} is yellow at 166 (yellow 145, green 170, grey 195): about 19 crafts to 175. Each takes 2 {item:2841}, 1 {item:2319} and 1 {item:2592}. Bronze Frameworks are parts for later gadgets; the extras sell to vendors."] = "",

	-- Step 47: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "{skill:202}: рецепты на 175",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder
	["Back to an {skill:202} trainer: {spell:12585} (from 175)."] = "",

	-- Step 48: Solid Blasting Powder to 191
	-- {item:10505} Solid Blasting Powder
	["{item:10505} to 191"] = "",
	-- {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["{item:10505} is yellow at 175 (yellow 175, green 185, grey 195): about 31 crafts to 191. Each takes 2 {item:7912}. Two {item:7912} a craft (Mithril Deposits). Make plenty: the triggers, slugs and Gyro-Shot all use it."] = "",

	-- Step 49: Engineering recipes at 191
	-- {skill:202} Engineering
	["{skill:202} recipes at 191"] = "",
	-- {skill:202} Engineering · {spell:3967} Big Iron Bomb
	["Back to an {skill:202} trainer: {spell:3967} (from 190)."] = "",

	-- Step 50: Big Iron Bomb to 210
	-- {spell:3967} Big Iron Bomb
	["{spell:3967} to 210"] = "",
	-- {spell:3967} Big Iron Bomb · {item:3575} Iron Bar · {spell:3945} Heavy Blasting Powder · {spell:3973} Silver Contact · {item:2842} Silver Bar · {item:2838} Heavy Stone · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:4586} Graham Van Talen · {zone:1458} Undercity · {area:392} Ratchet · {spell:20220} Gnomish Engineering · {npc:7944} Tinkmaster Overspark · {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {item:4407} Accurate Scope · {npc:8126} Nixx Sprocketspring · {area:976} Gadgetzan · {item:10507} Solid Dynamite · {npc:2675} Explosive Sheep · {skill:186} Mining · {item:2775} Silver Ore · {item:2772} Iron Ore
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact · Mithril Tubes = {item:10559} Mithril Tube · Big Iron Bombs = {spell:3967} Big Iron Bomb
	["{spell:3967} is yellow at 191 (yellow 190, green 210, grey 230): about 27 crafts to 210. Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 74 {spell:3945} and 30 {spell:3973} (6 crafts) first. Use the 7 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby. {item:2842} (6 for 150-225): {skill:186}: smelt {item:2775}; or the Auction House. {item:3575} (81 for 150-225): {skill:186}: smelt {item:2772}; or the Auction House."] = "{spell:3967}: желтый на 191 (желтый 190, зеленый 210, серый 230): около 27 изготовлений до 210. Каждое требует 3 {item:3575}, 3 {spell:3945} и 1 {spell:3973} и дает 2 шт. Сначала сделайте 74 {spell:3945} и 30 {spell:3973} (6 изготовлений). Используйте 7 {spell:3945}, сделанных ранее; в подсчете выше они не учтены. Из {item:2842} выходит пять серебряных контактов (уже серые: очков нет, зато не нужно идти к торговцу); {spell:3945} делается из {item:2838}. Каждое изготовление дает две бомбы. Специализация (необязательно): на 200 и уровне персонажа 30 {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) или Оловень ({area:392}) направит вас к {spell:20220} ({npc:7944}, {zone:1455}, или {npc:7406}, {area:35}: 6 мифриловых трубок, {item:4407} и 2 улучшенных тренировочных манекена) или к гоблинской инженерии ({npc:8126}, {area:976}: 20 больших железных бомб, 20 {item:10507} и 5 {npc:2675}). Схема {item:4407} теперь становится персональной при получении, но для задания годится прицел, сделанный другим игроком. Членская карта действует 14 дней игрового времени; продление стоит 2з. Можно выбрать только одну; ни одна не нужна для 300, и на бете их не проверяли (она заканчивалась на уровне 30). Нужна наковальня рядом. {item:2842} (6 на 150-225): {skill:186}: выплавьте из {item:2775}; или аукцион. {item:3575} (81 на 150-225): {skill:186}: выплавьте из {item:2772}; или аукцион.",

	-- Step 51: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "{skill:202}: рецепты на 210",
	-- {skill:202} Engineering · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12596} (from 210)."] = "",

	-- Step 52: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512} до 225",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:186} Mining · {item:3858} Mithril Ore · {skill:202} Engineering
	["{item:10512} is yellow at 210 (yellow 210, green 230, grey 250): about 19 crafts to 225. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Use the 19 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {item:3860} (19 for 150-225): {skill:186}: smelt {item:3858}; or the Auction House. {skill:202} 225 is a Legacy System milestone."] = "",

	-- Step 53: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "{skill:202}: Искусник",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {item:3860} Mithril Bar · {item:7912} Solid Stone · {item:12359} Thorium Bar · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}); Horde {npc:8736} ({zone:1446}). The arrow picks the nearest of your faction. 225-300 takes about 2g 80s of recipes, plus 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047} to gather or buy."] = "",

	-- Step 54: Schematic: Thorium Widget
	-- {item:16042} Schematic: Thorium Widget · {item:15994} Thorium Widget · {skill:202} Engineering · {npc:5175} Gearcutter Cogspinner · {zone:1455} Ironforge · {npc:3413} Sovik · {zone:1454} Orgrimmar
	["{item:16042} teaches {item:15994} ({skill:202} 260) for 1g 20s. Sold by Alliance: {npc:5175} ({zone:1455}), limited stock; Horde: {npc:3413} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "",

	-- Step 55: Schematic: Thorium Tube
	-- {item:16047} Schematic: Thorium Tube · {item:16000} Thorium Tube · {skill:202} Engineering · {npc:260565} Kor'gar · {zone:2548} Riverglades · {npc:11185} Xizzer Fizzbolt · {zone:1452} Winterspring
	["{item:16047} teaches {item:16000} ({skill:202} 275) for 1g 60s. Sold by Alliance: {npc:260565} ({zone:2548}) and {npc:11185} ({zone:1452}), limited stock; Horde: {npc:11185} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 56: Solid Stone (Alliance)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest cluster of {object:2040} in {zone:1425} is marked."] = "",

	-- Step 57: Solid Stone (Horde)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "",

	-- Step 58: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Альянс)",
	-- {item:14047} Runecloth · {item:15994} Thorium Widget · {npc:7027} Blackrock Slayer
	["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "",

	-- Step 59: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Орда)",
	-- {item:14047} Runecloth · {item:15994} Thorium Widget · {npc:11880} Twilight Avenger
	["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "",

	-- Step 60: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512} до 245",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:186} Mining · {item:3858} Mithril Ore
	["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 50 {item:10505} first. Use the 12 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {item:3860} (118 for 225-300): {skill:186}: smelt {item:3858}; or the Auction House."] = "",

	-- Step 61: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "{skill:202}: рецепты на 245",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} (from 245)."] = "",

	-- Step 62: Mithril Gyro-Shot to 265
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 265"] = "",
	-- {item:10513} Mithril Gyro-Shot · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:10513} is yellow at 245 (yellow 245, green 265, grey 285): about 28 crafts to 265. Each takes 2 {item:3860} and 2 {item:10505} and makes 200. Make the 56 {item:10505} first. Two Mithril Bars and two {item:10505} a craft. Needs an anvil nearby."] = "",

	-- Step 63: Thorium Widget to 287
	-- {item:15994} Thorium Widget
	["{item:15994} to 287"] = "",
	-- {item:15994} Thorium Widget · {item:12359} Thorium Bar · {item:14047} Runecloth · {skill:186} Mining · {item:10620} Thorium Ore
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:15994} is orange at 265 (yellow 280, green 290, grey 300): about 24 crafts to 287. Each takes 3 {item:12359} and 1 {item:14047}. Three Thorium Bars and a {item:14047} a craft; the widgets are parts for the later Thorium gadgets. Needs an anvil nearby. {item:12359} (156 for 225-300): {skill:186}: smelt {item:10620}; or the Auction House."] = "",
	["from the recipe in your bags"] = "по рецепту из сумки",

	-- Step 64: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000} до 300",
	-- {item:16000} Thorium Tube · {item:12359} Thorium Bar · {skill:202} Engineering
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:16000} is orange at 287 (yellow 295, green 305, grey 315): about 14 crafts to 300. Each takes 6 {item:12359}. The schematic binds when picked up; six Thorium Bars a craft. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:202}"] = "{skill:202}: Ученик",
	-- ["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "Ранг «Искусник» требует уровня персонажа 35 и навыка {skill:202} 200; предел становится 300. Материалы на 225-300 стоят всего около 67з.",
	-- ["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "Вернитесь к учителю ({skill:202}): {spell:12585}, {spell:12596} – с навыка {skill:202} 210.",
	-- ["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "Вернитесь к учителю ({skill:202}): {spell:12590} – с навыка {skill:202} 175.",
	-- ["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "Вернитесь к учителю ({skill:202}): {spell:12621} – с навыка {skill:202} 245.",
	-- ["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "Вернитесь к учителю ({skill:202}): {spell:3922} – с навыка {skill:202} 45.",
	-- ["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "Вернитесь к учителю ({skill:202}): {spell:3923} – с навыка {skill:202} 60.",
	-- ["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "Вернитесь к учителю ({skill:202}): {spell:3924} – с навыка {skill:202} 80.",
	-- ["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "Вернитесь к учителю ({skill:202}): {spell:3926} – с навыка {skill:202} 95.",
	-- ["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "Вернитесь к учителю ({skill:202}): {spell:3929} – с навыка {skill:202} 85.",
	-- ["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "Вернитесь к учителю ({skill:202}): {spell:3937} – с навыка {skill:202} 105.",
	-- ["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "Вернитесь к учителю ({skill:202}): {spell:3942} – с навыка {skill:202} 125.",
	-- ["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "Вернитесь к учителю ({skill:202}): {spell:3945} – с навыка {skill:202} 125.",
	-- ["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "Ранг «Умелец» требует уровня персонажа 20 и навыка {skill:202} 125; предел становится 225. Материалы на 150-225 стоят всего около 15з.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}) and {npc:5174} ({zone:1455}); Horde {npc:8736} ({zone:1446}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912} to gather or buy."] = "Ранг «Умелец» поднимает предел со 150 до 225 за 50с (цена Classic; цены Forever нет в данных); нужен навык {skill:202} 125 и уровень персонажа 20, так что его можно взять при любом визите начиная со 125. Учат ему лишь немногие: Альянс – {npc:8736} ({zone:1446}) и {npc:5174} ({zone:1455}); Орда – {npc:8736} ({zone:1446}) и Роксик ({zone:1454}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:9271} (со 150) и {spell:3953} (со 145). На 150-225 уйдет около 31с на товары торговцев, плюс 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} и 62 {item:7912} – добудьте или купите.",
	-- ["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "Ранг «Подмастерье» требует уровня персонажа 10 и навыка {skill:202} 50; предел становится 150. Материалы на 75-150 стоят всего около 3з 23с.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) and {npc:11029} ({zone:1455}); Horde {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "Ранг «Подмастерье» поднимает предел с 75 до 150 за 5с (цена Classic; цены Forever нет в данных); нужен навык {skill:202} 50 и уровень персонажа 10, так что его можно взять при любом визите начиная с 50. Учат ему не все учителя ({skill:202}): Альянс – {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) и {npc:11029} ({zone:1455}); Орда – {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) и Роксик ({zone:1454}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:3929} (с 75, 2с 50м) и {spell:3930} (с 75, 2с 50м). На 75-150 уйдет около 5с на рецепты и 45с на товары торговцев, плюс 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} и 2 {item:2842} – добудьте или купите.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Убивайте существ, с которых он падает, в месте, выбранном Polestar для вашего уровня и фракции. Подойдет и аукцион.",
	-- ["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "Оранжевый (очко за каждое изготовление) до 20, желтый до 30, зеленый до 40.",
	-- ["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "Оранжевый (очко за каждое изготовление) до 280, желтый до 290, зеленый до 300. Нужна наковальня рядом.",
	-- ["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 295, желтый до 305, зеленый до 315. Нужна наковальня рядом. {skill:202} 300 – рубеж Системы наследия.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Хрустогрыз, {npc:2384}, {npc:2354} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Снимайте шкуры здесь: {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (звери уровня 18-30); маршрут – в гайде {skill:393}. Подойдет и аукцион.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Снимается со шкур, получается распылением или другой профессией: добудьте сами или купите на аукционе.",
	-- ["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Обучает: {item:15994} (нужно {skill:202} 260). У торговцев – ограниченный запас, который пополняется; часто бывает и на аукционе.",
	-- ["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "Обучает: {item:16000} (нужно {skill:202} 275). У торговцев – ограниченный запас, который пополняется.",
	-- ["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 110, зеленый до 125: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 130, зеленый до 155: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 135, green until 145: not every craft gives a point."] = "Желтый до 135, зеленый до 145: не каждое изготовление дает очко.",
	-- ["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "Желтый до 150, зеленый до 175: не каждое изготовление дает очко. Нужна наковальня рядом. {skill:202} 150 – рубеж Системы наследия.",
	-- ["Yellow until 170, green until 195: not every craft gives a point."] = "Желтый до 170, зеленый до 195: не каждое изготовление дает очко.",
	-- ["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 195, зеленый до 215: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 230, зеленый до 250: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "Желтый до 230, зеленый до 250: не каждое изготовление дает очко. Нужна наковальня рядом. {skill:202} 225 – рубеж Системы наследия.",
	-- ["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 265, зеленый до 285: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 45, green until 60: not every craft gives a point."] = "Желтый до 45, зеленый до 60: не каждое изготовление дает очко.",
	-- ["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 52, зеленый до 60: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 75, зеленый до 90: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "Желтый до 75, зеленый до 90: не каждое изготовление дает очко. Нужна наковальня рядом. 75 – предел ранга «Ученик».",
	-- ["Yellow until 90, green until 95: not every craft gives a point."] = "Желтый до 90, зеленый до 95: не каждое изготовление дает очко.",
	-- ["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "Желтый до 95, зеленый до 110: не каждое изготовление дает очко. Нужна наковальня рядом.",
	-- ["{item:10498} to 210"] = "{item:10498} до 210",
	-- ["{item:10513} to 264"] = "{item:10513} до 264",
	-- ["{item:15994} to 288"] = "{item:15994} до 288",
	-- ["{item:2592} (Alliance)"] = "{item:2592} (Альянс)",
	-- ["{item:2592} (Horde)"] = "{item:2592} (Орда)",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (Альянс)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (Орда)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} добывается из: {object:1731} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} добывается из: {object:1732} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} добывается из: {object:1735} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: инструмент, держите его в сумке",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} добывается из: {object:2040} ({skill:186}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Добыча здесь: {npc:3263} (уровень 19-20). Подойдет и аукцион.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Добыча здесь: {npc:6189} (уровень 51-52). Подойдет и аукцион.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Добыча здесь: {npc:7027} (уровень 56-57). Подойдет и аукцион.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Добыча здесь: {npc:98} (уровень 17-18). Подойдет и аукцион.",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: выплавка – {item:10620} (или аукцион)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: выплавка – {item:2770} (или аукцион)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: выплавка – {item:2840} (или аукцион)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: выплавка – {item:3575} (или аукцион)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: выплавка – {item:3858} (или аукцион)",
	-- ["{skill:202} materials for 1-75"] = "{skill:202}: материалы для 1-75",
	-- ["{skill:202} materials for 150-225"] = "{skill:202}: материалы для 150-225",
	-- ["{skill:202} materials for 225-300"] = "{skill:202}: материалы для 225-300",
	-- ["{skill:202} materials for 75-150"] = "{skill:202}: материалы для 75-150",
	-- ["{skill:202} recipes at 111"] = "{skill:202}: рецепты на 111",
	-- ["{skill:202} recipes at 139"] = "{skill:202}: рецепты на 139",
	-- ["{skill:202} recipes at 45"] = "{skill:202}: рецепты на 45",
	-- ["{skill:202} recipes at 60"] = "{skill:202}: рецепты на 60",
	-- ["{skill:202} recipes at 80"] = "{skill:202}: рецепты на 80",
	-- ["{skill:202} recipes at 85"] = "{skill:202}: рецепты на 85",
	-- ["{skill:202} recipes at 95"] = "{skill:202}: рецепты на 95",
	-- ["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202} качается параллельно с уровнем. Система наследия Forever награждает за профессии производства на навыке 150, 225 и 300 (пределы рангов «Подмастерье», «Умелец» и «Искусник»), так что важен каждый рубеж. Материалы на 1-75 стоят всего около 62с.",
	-- ["{spell:3918} to 37"] = "{spell:3918} до 37",
	-- ["{spell:3920} to 45"] = "{spell:3920} до 45",
	-- ["{spell:3922} to 60"] = "{spell:3922} до 60",
	-- ["{spell:3923} to 75"] = "{spell:3923} до 75",
	-- ["{spell:3923} to 80"] = "{spell:3923} до 80",
	-- ["{spell:3924} to 85"] = "{spell:3924} до 85",
	-- ["{spell:3926} to 111"] = "{spell:3926} до 111",
	-- ["{spell:3929} to 95"] = "{spell:3929} до 95",
	-- ["{spell:3937} to 125"] = "{spell:3937} до 125",
	-- ["{spell:3942} to 150"] = "{spell:3942} до 150",
	-- ["{spell:3945} to 139"] = "{spell:3945} до 139",
}
