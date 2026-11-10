-- Chinese (traditional) (zhTW): the guide forever/professions/enchanting (forever/professions/enchanting.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Enchanting
	-- {skill:333} Enchanting
	["Learn {skill:333}"] = "",
	-- {skill:333} Enchanting · {npc:3606} Alanna Raveneye · {zone:1438} Teldrassil · {npc:11068} Betty Quin · {zone:1453} Stormwind City · {npc:257004} Eaysaa Brightgust · {npc:5157} Gimble Thistlefuzz · {zone:1455} Ironforge · {npc:11072} Kitta Firewind · {zone:1429} Elwynn Forest · {npc:11070} Lalina Summermoon · {zone:1457} Darnassus · {npc:1317} Lucan Cordell · {npc:257020} Nasalanna Windsinger · {npc:4213} Taladan · {npc:11065} Thonys Pillarstone · {npc:5158} Tilli Thistlefuzz · {npc:7949} Xylinnia Starshine · {zone:1444} Feralas · {npc:3345} Godan · {zone:1454} Orgrimmar · {npc:11074} Hgarth · {zone:1442} Stonetalon Mountains · {npc:4616} Lavinia Crowe · {zone:1458} Undercity · {npc:11067} Malcomb Wynn · {npc:11071} Mot Dawnstrider · {zone:1456} Thunder Bluff · {npc:3011} Teg Dawnstrider · {npc:5695} Vance Undergloom · {zone:1420} Tirisfal Glades · {item:6217} Copper Rod · {item:247786} Mote of Magic · {area:91} Tower of Azora · {npc:266881} Pa'zula · {area:367} Sen'jin Village · {zone:1411} Durotar · {item:10940} Strange Dust
	["Apprentice {skill:333} lets you craft up to 75 for 10c, at any character level. Not every {skill:333} trainer teaches it: Alliance {npc:3606} ({zone:1438}), {npc:11068} ({zone:1453}), {npc:257004} (Zephras Isle), {npc:5157} ({zone:1455}), {npc:11072} ({zone:1429}), {npc:11070} ({zone:1457}), {npc:1317} ({zone:1453}), {npc:257020} (Zephras Isle), {npc:4213} ({zone:1457}), {npc:11065} ({zone:1455}), {npc:5158} ({zone:1455}) and {npc:7949} ({zone:1444}); Horde {npc:257004} (Zephras Isle), {npc:3345} ({zone:1454}), {npc:11074} ({zone:1442}), Jhag ({zone:1454}), {npc:4616} ({zone:1458}), {npc:11067} ({zone:1458}), {npc:11071} ({zone:1456}), {npc:257020} (Zephras Isle), {npc:3011} ({zone:1456}) and {npc:5695} ({zone:1420}). The arrow picks the nearest of your faction. Buy a {item:6217} and {item:247786} from an enchanting supplies vendor (in the capitals and on Zephras Isle; the starting-area trainers have none beside them, and the next step's arrow picks the nearest). From now on, disenchant every green you do not wear: that is where the dust and essences come from. Two starter quests teach Disenchant on a quest item: An Enchanting Lesson from {npc:11072} ({area:91}, {zone:1429}) and A Pain in the Neck from {npc:266881} ({area:367}, {zone:1411}). 1-75 takes about 50c of recipes and 4s 44c of vendor goods, plus 51 {item:10940} to gather or buy."] = "",

	-- Step 2: Enchanting 1-75: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 1-75: vendor goods"] = "",
	-- {item:6217} Copper Rod · {item:247786} Mote of Magic · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1318} Jessara Cordell · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3346} Kithas · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 1 {item:6217} (1s 24c) and 32 {item:247786} (3s 20c); about 4s 44c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286} and {npc:1318}; {zone:1454}: {npc:3367}, {npc:3346} and {npc:5817})."] = "",

	-- Step 3: Enchant Bracer - Inferior Stamina to 25
	-- {spell:7418} Enchant Bracer - Inferior Stamina
	["{spell:7418} to 25"] = "{spell:7418}練到25",
	-- {spell:7418} Enchant Bracer - Inferior Stamina · {item:247786} Mote of Magic · {item:6218} Runed Copper Rod
	["{spell:7418} is orange at 1 (yellow 20, green 22, grey 25): about 31 crafts to 25. Each takes 1 {item:247786}. One {item:247786} (10c) a craft; grey at 25 on Forever. Make the {item:6218} first: the recipe needs it in your bags, so keep it there. Enchant any item for that slot in your bags, even a grey one."] = "",
	["a tool: keep it in your bags"] = "工具：放在背包裡",

	-- Step 4: Enchanting recipes at 25
	-- {skill:333} Enchanting
	["{skill:333} recipes at 25"] = "",
	-- {skill:333} Enchanting · {spell:7420} Enchant Chest - Inferior Stamina · {spell:1230643} Enchanted Lute · {item:4470} Simple Wood · {item:10940} Strange Dust
	["Back to an {skill:333} trainer: {spell:7420} (from 15, 50c). Also learn {spell:1230643} (1s): Forever's {skill:333} camp item, 1 {item:4470} and 1 {item:10940}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:333} quest from your starting area's camping guide (after The Great Outdoors) sends you to an enchanting trainer who teaches it free."] = "",

	-- Step 5: Enchant Chest - Inferior Stamina to 75
	-- {spell:7420} Enchant Chest - Inferior Stamina
	["{spell:7420} to 75"] = "",
	-- {spell:7420} Enchant Chest - Inferior Stamina · {item:10940} Strange Dust · {item:10938} Lesser Magic Essence · {spell:7423} Minor Absorption · {skill:333} Enchanting
	["{spell:7420} is orange at 25 (yellow 70, green 90, grey 110): about 51 crafts to 75. Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. {item:10940} (51 for 1-75): {skill:333}: disenchant green items of item level 5-20; or the Auction House. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 6: Journeyman Enchanting
	-- {skill:333} Enchanting
	["Journeyman {skill:333}"] = "中級{skill:333}",
	-- {skill:333} Enchanting · {npc:5157} Gimble Thistlefuzz · {zone:1455} Ironforge · {npc:11072} Kitta Firewind · {zone:1429} Elwynn Forest · {npc:1317} Lucan Cordell · {zone:1453} Stormwind City · {npc:4213} Taladan · {zone:1457} Darnassus · {npc:7949} Xylinnia Starshine · {zone:1444} Feralas · {npc:3345} Godan · {zone:1454} Orgrimmar · {npc:11074} Hgarth · {zone:1442} Stonetalon Mountains · {npc:4616} Lavinia Crowe · {zone:1458} Undercity · {npc:3011} Teg Dawnstrider · {zone:1456} Thunder Bluff · {spell:7771} Enchant Cloak - Minor Protection · {item:1210} Shadowgem · {item:6338} Silver Rod · {item:10938} Lesser Magic Essence · {item:10940} Strange Dust · {item:11083} Soul Dust
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:333} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:333} trainer teaches it: Alliance {npc:5157} ({zone:1455}), {npc:11072} ({zone:1429}), {npc:1317} ({zone:1453}), {npc:4213} ({zone:1457}) and {npc:7949} ({zone:1444}); Horde {npc:3345} ({zone:1454}), {npc:11074} ({zone:1442}), {npc:4616} ({zone:1458}) and {npc:3011} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:7771} (from 70, 2s). 75-150 takes about 2s of recipes, plus 1 {item:1210}, 1 {item:6338}, 4 {item:10938}, 121 {item:10940} and 20 {item:11083} to gather or buy."] = "",

	-- Step 7: Enchant Chest - Inferior Stamina to 90
	-- {spell:7420} Enchant Chest - Inferior Stamina
	["{spell:7420} to 90"] = "",
	-- {spell:7420} Enchant Chest - Inferior Stamina · {item:10940} Strange Dust · {item:10938} Lesser Magic Essence · {spell:7423} Minor Absorption · {skill:333} Enchanting
	["{spell:7420} is yellow at 75 (yellow 70, green 90, grey 110): about 22 crafts to 90. Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. {item:10940} (121 for 75-150): {skill:333}: disenchant green items of item level 5-20; or the Auction House. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 8: Enchant Cloak - Minor Protection to 130
	-- {spell:7771} Enchant Cloak - Minor Protection
	["{spell:7771} to 130"] = "",
	-- {spell:7771} Enchant Cloak - Minor Protection · {item:10940} Strange Dust
	["{spell:7771} is orange at 90 (yellow 110, green 130, grey 150): about 48 crafts to 130. Each takes 2 {item:10940}. Two {item:10940} a craft (the trainer teaches it from 70 for 2s); keep disenchanting the greens of the 10-20 zones. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 9: Enchanting recipes at 130
	-- {skill:333} Enchanting
	["{skill:333} recipes at 130"] = "{skill:333}130點的配方",
	-- {skill:333} Enchanting · {spell:7795} Runed Silver Rod · {spell:13501} Enchant Bracer - Lesser Stamina
	["Back to an {skill:333} trainer: {spell:7795} (from 100) and {spell:13501} (from 130)."] = "",

	-- Step 10: Enchant Bracer - Lesser Stamina to 150
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 150"] = "",
	-- {spell:13501} Enchant Bracer - Lesser Stamina · {item:11083} Soul Dust · {item:6339} Runed Silver Rod · {item:1210} Shadowgem · {object:1731} Copper Vein · {object:1732} Tin Vein · {object:1733} Silver Vein · {item:6338} Silver Rod · {skill:164} Blacksmithing · {item:10938} Lesser Magic Essence · {skill:333} Enchanting
	["{spell:13501} is orange at 130 (yellow 155, green 175, grey 195): about 20 crafts to 150, a point every craft. Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:6339} first: the recipe needs it in your bags, so keep it there. {item:1210} (1 for 75-150): {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: buy it at the Auction House, or keep the ones you find while mining. {item:6338} (1 for 75-150): {skill:164}: {item:6338}; or the Auction House. {item:10938} (4 for 75-150): {skill:333}: disenchant green items of item level 5-15; or the Auction House. {item:11083} (20 for 75-150): {skill:333}: disenchant green items of item level 21-30; or the Auction House. Enchant any item for that slot in your bags, even a grey one. {skill:333} 150 is a Legacy System milestone."] = "",

	-- Step 11: Iridescent Pearl (Alliance)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Alliance)"] = "{item:5500}（聯盟）",
	-- {item:5500} Iridescent Pearl · {item:11130} Runed Golden Rod
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["1 {item:5500} for {item:11130}: open the Giant Clams at the marked spot, or buy it at the Auction House."] = "",

	-- Step 12: Iridescent Pearl (Horde)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Horde)"] = "{item:5500}（部落）",

	-- Step 13: Expert Enchanting
	-- {skill:333} Enchanting
	["Expert {skill:333}"] = "高級{skill:333}",
	-- {skill:333} Enchanting · {npc:11072} Kitta Firewind · {zone:1429} Elwynn Forest · {npc:11074} Hgarth · {zone:1442} Stonetalon Mountains · {spell:13628} Runed Golden Rod · {item:5500} Iridescent Pearl · {item:7971} Black Pearl · {item:11082} Greater Astral Essence · {item:11083} Soul Dust · {item:11128} Golden Rod · {item:11135} Greater Mystic Essence · {item:11137} Vision Dust · {item:11144} Truesilver Rod · {spell:13637} Enchant Boots - Lesser Agility · {item:11145} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:333} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:11072} ({zone:1429}); Horde {npc:11074} ({zone:1442}). The arrow picks the nearest of your faction. Learn now: {spell:13628} (from 150). 150-225 takes 1 {item:5500}, 1 {item:7971}, 1 {item:11082}, 71 {item:11083}, 1 {item:11128}, 1 {item:11135}, 21 {item:11137} and 1 {item:11144} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:13637} (from 160), {item:11145} (from 200) and {spell:13746} (from 205), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "",

	-- Step 14: Enchant Bracer - Lesser Stamina to 160
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 160"] = "",
	-- {spell:13501} Enchant Bracer - Lesser Stamina · {item:11083} Soul Dust · {item:11130} Runed Golden Rod · {item:11082} Greater Astral Essence · {skill:333} Enchanting · {item:11128} Golden Rod · {skill:164} Blacksmithing
	["{spell:13501} is orange at 150 (yellow 155, green 175, grey 195): about 11 crafts to 160. Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:11130} now, while it still gives a point: a later recipe needs it in your bags, so keep it there. {item:11082} (1 for 150-225): {skill:333}: disenchant green items of item level 16-25; or the Auction House. {item:11083} (71 for 150-225): {skill:333}: disenchant green items of item level 21-30; or the Auction House. {item:11128} (1 for 150-225): {skill:164}: {item:11128}; or the Auction House. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 15: Enchanting recipes at 160
	-- {skill:333} Enchanting
	["{skill:333} recipes at 160"] = "",
	-- {spell:13637} Enchant Boots - Lesser Agility
	["Still at the Expert trainer: {spell:13637} (from 160)."] = "",

	-- Step 16: Enchant Boots - Lesser Agility to 205
	-- {spell:13637} Enchant Boots - Lesser Agility
	["{spell:13637} to 205"] = "",
	-- {spell:13637} Enchant Boots - Lesser Agility · {item:11083} Soul Dust
	["{spell:13637} is orange at 160 (yellow 180, green 200, grey 220): about 59 crafts to 205. Each takes 1 {item:11083}. {item:11083} again. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 17: Enchanting recipes at 205
	-- {skill:333} Enchanting
	["{skill:333} recipes at 205"] = "",
	-- {spell:13702} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	["Still at the Expert trainer: {spell:13702} (from 200) and {spell:13746} (from 205)."] = "",

	-- Step 18: Enchant Cloak - Greater Defense to 225
	-- {spell:13746} Enchant Cloak - Greater Defense
	["{spell:13746} to 225"] = "",
	-- {spell:13746} Enchant Cloak - Greater Defense · {item:11137} Vision Dust · {item:11145} Runed Truesilver Rod · {item:7971} Black Pearl · {item:11135} Greater Mystic Essence · {skill:333} Enchanting · {item:11144} Truesilver Rod · {skill:164} Blacksmithing
	["{spell:13746} is orange at 205 (yellow 225, green 245, grey 265): about 20 crafts to 225, a point every craft. Each takes 1 {item:11137}. One {item:11137} a craft (level 31-40 greens). Make the {item:11145} first: the recipe needs it in your bags, so keep it there. {item:7971} (1 for 150-225): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find. {item:11135} (1 for 150-225): {skill:333}: disenchant green items of item level 26-35; or the Auction House. {item:11137} (21 for 150-225): {skill:333}: disenchant green items of item level 31-40; or the Auction House. {item:11144} (1 for 150-225): {skill:164}: {item:11144}; or the Auction House. Enchant any item for that slot in your bags, even a grey one. {skill:333} 225 is a Legacy System milestone."] = "",

	-- Step 19: Artisan Enchanting
	-- {skill:333} Enchanting
	["Artisan {skill:333}"] = "專家級{skill:333}",
	-- {skill:333} Enchanting · {npc:11073} Annora · {area:1517} Uldaman · {zone:1418} Badlands · {spell:13815} Enchant Gloves - Agility · {item:8831} Purple Lotus · {item:11137} Vision Dust · {item:11176} Dream Dust
	["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:333} 200 and character level 35, so you can take it on any visit from 200. {npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group. Learn now: {spell:13815} (from 210). 225-300 takes about 2g 20s of recipes and 1g 70s of vendor goods, plus 34 {item:8831}, 39 {item:11137} and 208 {item:11176} to gather or buy."] = "",

	-- Step 20: Enchanting 225-300: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 225-300: vendor goods"] = "",
	-- {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 34 {item:8925} (1g 70s); about 1g 70s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "",

	-- Step 21: Formula: Lesser Mana Oil
	-- {item:20754} Formula: Lesser Mana Oil · {item:20747} Lesser Mana Oil · {skill:333} Enchanting · {npc:15419} Kania · {zone:1451} Silithus
	["{item:20754} teaches {item:20747} ({skill:333} 250) for 1g. Sold by {npc:15419} ({zone:1451})."] = "",

	-- Step 22: Formula: Enchant Shield - Greater Stamina
	-- {item:16217} Formula: Enchant Shield - Greater Stamina · {spell:20017} Enchant Shield - Greater Stamina · {skill:333} Enchanting · {npc:4229} Mythrin'dir · {zone:1457} Darnassus · {npc:4561} Daniel Bartlett · {zone:1458} Undercity
	["{item:16217} teaches {spell:20017} ({skill:333} 265) for 1g 20s. Sold by Alliance: {npc:4229} ({zone:1457}), limited stock; Horde: {npc:4561} ({zone:1458}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 23: Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	["{item:8831} (Alliance)"] = "{item:8831}（聯盟）",
	-- {item:8831} Purple Lotus · {item:20747} Lesser Mana Oil · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["34 {item:8831} for {item:20747}: {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8831} in {zone:1425} is marked."] = "",

	-- Step 24: Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	["{item:8831} (Horde)"] = "{item:8831}（部落）",
	-- {item:8831} Purple Lotus · {item:20747} Lesser Mana Oil · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["34 {item:8831} for {item:20747}: {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8831} in {zone:1444} is marked."] = "",

	-- Step 25: Enchant Gloves - Agility to 253
	-- {spell:13815} Enchant Gloves - Agility
	["{spell:13815} to 253"] = "",
	-- {spell:13815} Enchant Gloves - Agility · {item:11137} Vision Dust · {npc:11073} Annora · {skill:333} Enchanting
	["{spell:13815} is orange at 225 (yellow 230, green 250, grey 270): about 39 crafts to 253. Each takes 1 {item:11137}. {npc:11073} teaches it with Artisan: learn it on that visit. {item:11137} again; bring about 40. {item:11137} (39 for 225-300): {skill:333}: disenchant green items of item level 31-40; or the Auction House. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 26: Lesser Mana Oil to 275
	-- {item:20747} Lesser Mana Oil
	["{item:20747} to 275"] = "",
	-- {item:20747} Lesser Mana Oil · {item:11176} Dream Dust · {item:8831} Purple Lotus · {item:8925} Crystal Vial · {npc:15419} Kania · {area:3425} Cenarion Hold · {zone:1451} Silithus · {skill:333} Enchanting
	["{item:20747} is orange at 253 (yellow 260, green 270, grey 280): about 34 crafts to 275. Each takes 1 {item:11176}, 1 {item:8831} and 1 {item:8925}. One {item:11176} (level 41-50 greens) and one {item:8831} (herbalists) a craft; the oil sells well. {npc:15419} sells the formula at the inn of {area:3425} ({zone:1451}): fly there, the mobs around it are level 55 and up. {item:11176} (208 for 225-300): {skill:333}: disenchant green items of item level 41-50; or the Auction House."] = "",
	["from the recipe in your bags"] = "使用背包裡的配方",

	-- Step 27: Enchant Shield - Greater Stamina to 300
	-- {spell:20017} Enchant Shield - Greater Stamina
	["{spell:20017} to 300"] = "",
	-- {spell:20017} Enchant Shield - Greater Stamina · {item:11176} Dream Dust · {skill:333} Enchanting
	["{spell:20017} is orange at 275 (yellow 285, green 305, grey 325): about 29 crafts to 300. Each takes 6 {item:11176}. Six {item:11176} a craft: the dearest stretch, so disenchant every level 41-50 green you find. Enchant any item for that slot in your bags, even a grey one. {skill:333} 300 is a Legacy System milestone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:333}"] = "初級{skill:333}",
	-- ["Artisan needs character level 35 and {skill:333} 200; it raises the cap to 300. Materials for 225-300 are worth about 30s in all."] = "專家級需要角色等級35且{skill:333}200點；上限提高到300。225-300所需材料總價約30銀。",
	-- ["Back to an {skill:333} trainer: {spell:13501} is taught from {skill:333} 155."] = "回到{skill:333}訓練師那裡：{spell:13501}在{skill:333}155點時可學。",
	-- ["Back to an {skill:333} trainer: {spell:13628}, {spell:13637} are taught from {skill:333} 180."] = "回到{skill:333}訓練師那裡：{spell:13628}、{spell:13637}在{skill:333}180點時可學。",
	-- ["Back to an {skill:333} trainer: {spell:13661} is taught from {skill:333} 200."] = "回到{skill:333}訓練師那裡：{spell:13661}在{skill:333}200點時可學。",
	-- ["Back to an {skill:333} trainer: {spell:13935} is taught from {skill:333} 255."] = "回到{skill:333}訓練師那裡：{spell:13935}在{skill:333}255點時可學。",
	-- ["Back to an {skill:333} trainer: {spell:13948} is taught from {skill:333} 270."] = "回到{skill:333}訓練師那裡：{spell:13948}在{skill:333}270點時可學。",
	-- ["Back to an {skill:333} trainer: {spell:7426} is taught from {skill:333} 90."] = "回到{skill:333}訓練師那裡：{spell:7426}在{skill:333}90點時可學。",
	-- ["Back to an {skill:333} trainer: {spell:7788} is taught from {skill:333} 120."] = "回到{skill:333}訓練師那裡：{spell:7788}在{skill:333}120點時可學。",
	-- ["Back to an {skill:333} trainer: {spell:7795} is taught from {skill:333} 130."] = "回到{skill:333}訓練師那裡：{spell:7795}在{skill:333}130點時可學。",
	-- ["Expert needs character level 20 and {skill:333} 125; it raises the cap to 225. Materials for 150-225 are worth about 13s in all."] = "高級需要角色等級20且{skill:333}125點；上限提高到225。150-225所需材料總價約13銀。",
	-- ["Journeyman needs character level 10 and {skill:333} 50; it raises the cap to 150. Materials for 75-150 are worth about 7g 51s in all."] = "中級需要角色等級10且{skill:333}50點；上限提高到150。75-150所需材料總價約7金51銀。",
	-- ["Open Giant Clams here. The Auction House works too."] = "在這裡打開巨型蚌殼。拍賣場也買得到。",
	-- ["Orange (a point every craft) until 135, yellow until 155, green until 175. Enchant your own gear: any item for that slot will do. {skill:333} 150 is a Legacy System milestone."] = "橙色（每次製造必得1點）到135，黃色到155，綠色到175。附魔自己的裝備：該部位任何物品都可以。{skill:333}150是傳承系統的里程碑。",
	-- ["Orange (a point every craft) until 20, yellow until 22, green until 25. Enchant your own gear: any item for that slot will do."] = "橙色（每次製造必得1點）到20，黃色到22，綠色到25。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do."] = "橙色（每次製造必得1點）到80，黃色到100，綠色到120。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do. 75 is the Apprentice cap."] = "橙色（每次製造必得1點）到80，黃色到100，綠色到120。附魔自己的裝備：該部位任何物品都可以。75是初級的上限。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剝皮、分解或其他專業製造的材料：自己採集或在拍賣場購買。",
	-- ["Teaches {spell:13419} (needs {skill:333} 110). Vendors sell it in limited stock that restocks."] = "學會{spell:13419}（需要{skill:333}110點）。商人限量販售，會補貨。",
	-- ["Yellow until 110, green until 130: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到110，綠色到130：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Yellow until 140, green until 160: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到140，綠色到160：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Yellow until 170, green until 190: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到170，綠色到190：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Yellow until 175, green until 195: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到175，綠色到195：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Yellow until 200, green until 220: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到200，綠色到220：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Yellow until 220, green until 240: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 225 is a Legacy System milestone."] = "黃色到220，綠色到240：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。{skill:333}225是傳承系統的里程碑。",
	-- ["Yellow until 245, green until 265: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到245，綠色到265：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Yellow until 275, green until 295: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "黃色到275，綠色到295：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。",
	-- ["Yellow until 290, green until 310: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 300 is a Legacy System milestone."] = "黃色到290，綠色到310：不是每次製造都會加點。附魔自己的裝備：該部位任何物品都可以。{skill:333}300是傳承系統的里程碑。",
	-- ["{item:1210} (Alliance)"] = "{item:1210}（聯盟）",
	-- ["{item:1210} (Horde)"] = "{item:1210}（部落）",
	-- ["{item:1210} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:1210}來自{object:1731}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:7971} (Alliance)"] = "{item:7971}（聯盟）",
	-- ["{item:7971} (Horde)"] = "{item:7971}（部落）",
	-- ["{item:8153} (Alliance)"] = "{item:8153}（聯盟）",
	-- ["{item:8153} (Horde)"] = "{item:8153}（部落）",
	-- ["{item:8153} comes from {item:8831} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:8153}來自{item:8831}（{skill:182}）；這裡是資料中最密集的草點。拍賣場也買得到。",
	-- ["{npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group"] = "{npc:11073}在{area:1517}地城（{zone:1418}）裡教授專家級{skill:333}；請組隊前往",
	-- ["{npc:5431} (level 48-50) drop it here. The Auction House works too."] = "{npc:5431}（48-50級）在這裡掉落。拍賣場也買得到。",
	-- ["{npc:922} (level 40-41) drop it here. The Auction House works too."] = "{npc:922}（40-41級）在這裡掉落。拍賣場也買得到。",
	-- ["{skill:164}: {item:11128} (or the Auction House)"] = "{skill:164}：{item:11128}（或在拍賣場購買）",
	-- ["{skill:164}: {item:11144} (or the Auction House)"] = "{skill:164}：{item:11144}（或在拍賣場購買）",
	-- ["{skill:164}: {item:6338} (or the Auction House)"] = "{skill:164}：{item:6338}（或在拍賣場購買）",
	-- ["{skill:171}: {item:6371} (or the Auction House)"] = "{skill:171}：{item:6371}（或在拍賣場購買）",
	-- ["{skill:333} materials for 150-225"] = "{skill:333}150-225的材料",
	-- ["{skill:333} materials for 225-300"] = "{skill:333}225-300的材料",
	-- ["{skill:333} materials for 75-150"] = "{skill:333}75-150的材料",
	-- ["{skill:333} recipes at 120"] = "{skill:333}120點的配方",
	-- ["{skill:333} recipes at 155"] = "{skill:333}155點的配方",
	-- ["{skill:333} recipes at 180"] = "{skill:333}180點的配方",
	-- ["{skill:333} recipes at 200"] = "{skill:333}200點的配方",
	-- ["{skill:333} recipes at 255"] = "{skill:333}255點的配方",
	-- ["{skill:333} recipes at 292"] = "{skill:333}292點的配方",
	-- ["{skill:333} recipes at 90"] = "{skill:333}90點的配方",
	-- ["{skill:333} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 4g 3s in all."] = "{skill:333}可以邊升級邊練。永恆的傳承系統會在專業技能150、225和300（中級、高級和專家級的上限）時給予製造專業獎勵，所以每個階段都很重要。1-75所需材料總價約4金3銀。",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}：分解優秀（綠色）裝備（或在拍賣場購買）",
	-- ["{spell:13419} to 150"] = "{spell:13419}練到150",
	-- ["{spell:13501} to 180"] = "{spell:13501}練到180",
	-- ["{spell:13637} to 200"] = "{spell:13637}練到200",
	-- ["{spell:13661} to 225"] = "{spell:13661}練到225",
	-- ["{spell:13746} to 255"] = "{spell:13746}練到255",
	-- ["{spell:13935} to 292"] = "{spell:13935}練到292",
	-- ["{spell:13948} to 300"] = "{spell:13948}練到300",
	-- ["{spell:7426} to 120"] = "{spell:7426}練到120",
	-- ["{spell:7428} to 75"] = "{spell:7428}練到75",
	-- ["{spell:7428} to 90"] = "{spell:7428}練到90",
	-- ["{spell:7788} to 130"] = "{spell:7788}練到130",
	-- ["{spell:7861} to 155"] = "{spell:7861}練到155",
}
