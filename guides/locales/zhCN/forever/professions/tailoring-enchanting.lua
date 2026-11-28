-- Chinese (simplified) (zhCN): the guide forever/professions/tailoring-enchanting (forever/professions/tailoring-enchanting.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Tailoring
	-- {skill:197} Tailoring
	["Learn {skill:197}"] = "",
	-- {skill:197} Tailoring · {item:2589} Linen Cloth · {item:2592} Wool Cloth
	["Apprentice {skill:197} lets you craft up to 75 for 10c, at any character level. Any {skill:197} trainer of your faction teaches it; the arrow picks the nearest. Keep every {item:2589} you loot: humanoids of level 5-20 drop it. 1-75 takes about 1s 50c of recipes and 4s 10c of vendor goods, plus 84 {item:2589} and 69 {item:2592} to gather or buy."] = "",

	-- Step 2: Tailoring 1-75: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 1-75: vendor goods"] = "",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 41 {item:2320} (4s 10c); about 4s 10c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 3: Get Linen Cloth
	-- {item:2589} Linen Cloth
	["Get {item:2589}"] = "",
	-- {item:2589} Linen Cloth · {skill:197} Tailoring
	-- plural, as words: Linen Belts = {item:7026} Linen Belt
	["84 {item:2589} for {skill:197} 1-75: 14 Bolts of Linen Cloth and 42 Linen Belts. Humanoids of level 5-20 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:2589} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 4: Get Wool Cloth
	-- {item:2592} Wool Cloth
	["Get {item:2592}"] = "",
	-- {item:2592} Wool Cloth · {skill:197} Tailoring
	["69 {item:2592} for {skill:197} 1-75: 23 Bolts of Woolen Cloth. Humanoids of level 15-30 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:2592} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 5: Bolt of Linen Cloth to 15
	-- {spell:2963} Bolt of Linen Cloth
	["{spell:2963} to 15"] = "",
	-- {spell:2963} Bolt of Linen Cloth · {item:2589} Linen Cloth
	-- plural, as words: Linen Belts = {item:7026} Linen Belt
	["{spell:2963} is orange at 1 (yellow 25, green 37, grey 50): about 14 crafts to 15, a point every craft. Each takes 2 {item:2589}. Keep the bolts: the Linen Belts from 15 take one each."] = "",

	-- Step 6: Tailoring recipes at 15
	-- {skill:197} Tailoring
	["{skill:197} recipes at 15"] = "",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} (from 15, 50c)."] = "",

	-- Step 7: Linen Belt to 55
	-- {item:7026} Linen Belt
	["{item:7026} to 55"] = "",
	-- {item:7026} Linen Belt · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{item:7026} is orange at 15 (yellow 50, green 67, grey 85): about 41 crafts to 55, up to 42 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {spell:2963} and 1 {item:2320}. Make the 27 {spell:2963} first: it gives points too while not grey. Use the 14 {spell:2963} you made earlier; the counts above leave them out. Each belt takes one bolt; the belts sell to vendors."] = "",

	-- Step 8: Tailoring recipes at 55
	-- {skill:197} Tailoring
	["{skill:197} recipes at 55"] = "",
	-- {skill:197} Tailoring · {spell:2964} Bolt of Woolen Cloth · {spell:1229504} Faction Banner · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["Back to a {skill:197} trainer: {spell:2964} (from 55, 1s). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free."] = "",

	-- Step 9: Bolt of Woolen Cloth to 75
	-- {spell:2964} Bolt of Woolen Cloth
	["{spell:2964} to 75"] = "",
	-- {spell:2964} Bolt of Woolen Cloth · {item:2592} Wool Cloth
	-- plural, as words: Woolen Capes = {spell:2402} Woolen Cape
	["{spell:2964} is orange at 55 (yellow 70, green 77, grey 85): about 21 crafts to 75, up to 23 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {item:2592}. Keep the bolts: the Woolen Capes from 75 take one each, so these points cost no extra {item:2592}."] = "",

	-- Step 10: Learn Enchanting
	-- {skill:333} Enchanting
	["Learn {skill:333}"] = "",
	-- {skill:333} Enchanting · {npc:3606} Alanna Raveneye · {zone:1438} Teldrassil · {npc:11068} Betty Quin · {zone:1453} Stormwind City · {npc:257004} Eaysaa Brightgust · {npc:11070} Lalina Summermoon · {zone:1457} Darnassus · {npc:257020} Nasalanna Windsinger · {npc:11065} Thonys Pillarstone · {zone:1455} Ironforge · {npc:11066} Jhag · {zone:1454} Orgrimmar · {npc:11067} Malcomb Wynn · {zone:1458} Undercity · {npc:11071} Mot Dawnstrider · {zone:1456} Thunder Bluff · {npc:266881} Pa'zula · {zone:1411} Durotar · {npc:5695} Vance Undergloom · {zone:1420} Tirisfal Glades · {item:6217} Copper Rod · {item:247786} Mote of Magic · {npc:11072} Kitta Firewind · {area:91} Tower of Azora · {zone:1429} Elwynn Forest · {area:367} Sen'jin Village · {item:10940} Strange Dust
	["Apprentice {skill:333} lets you craft up to 75 for 10c, at any character level. Not every {skill:333} trainer teaches it: Alliance {npc:3606} ({zone:1438}), {npc:11068} ({zone:1453}), {npc:257004} (Zephras Isle), {npc:11070} ({zone:1457}), {npc:257020} (Zephras Isle) and {npc:11065} ({zone:1455}); Horde {npc:257004} (Zephras Isle), {npc:11066} ({zone:1454}), {npc:11067} ({zone:1458}), {npc:11071} ({zone:1456}), {npc:257020} (Zephras Isle), {npc:266881} ({zone:1411}) and {npc:5695} ({zone:1420}). The arrow picks the nearest of your faction. Buy a {item:6217} and {item:247786} from an enchanting supplies vendor (in the capitals and on Zephras Isle; the starting-area trainers have none beside them, and the next step's arrow picks the nearest). From now on, disenchant every green you do not wear: that is where the dust and essences come from. Two starter quests teach Disenchant on a quest item: An Enchanting Lesson from {npc:11072} ({area:91}, {zone:1429}) and A Pain in the Neck from {npc:266881} ({area:367}, {zone:1411}). 1-75 takes about 50c of recipes and 4s 44c of vendor goods, plus 52 {item:10940} to gather or buy."] = "",

	-- Step 11: Enchanting 1-75: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 1-75: vendor goods"] = "",
	-- {item:6217} Copper Rod · {item:247786} Mote of Magic · {zone:1453} Stormwind City · {npc:1318} Jessara Cordell · {zone:1454} Orgrimmar · {npc:3346} Kithas
	["Buy the whole bracket's share in one go: 1 {item:6217} (1s 24c) and 32 {item:247786} (3s 20c); about 4s 44c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1318}; {zone:1454}: {npc:3346})."] = "",

	-- Step 12: Get Strange Dust · Disenchant: Professions tab (K by default)
	-- {item:10940} Strange Dust
	["Get {item:10940} · Disenchant: Professions tab (K by default)"] = "",
	-- {item:10940} Strange Dust · {skill:333} Enchanting · {spell:7420} Enchant Chest - Inferior Stamina
	["52 {item:10940} for {skill:333} 1-75: 52 {spell:7420}. {skill:333}: disenchant green armour that requires level 1-20. Or buy them at the Auction House."] = "",

	-- Step 13: Enchant Bracer - Inferior Stamina to 25
	-- {spell:7418} Enchant Bracer - Inferior Stamina
	["{spell:7418} to 25"] = "",
	-- {spell:7418} Enchant Bracer - Inferior Stamina · {item:247786} Mote of Magic · {item:6218} Runed Copper Rod
	["{spell:7418} is orange at 1 (yellow 20, green 22, grey 25): about 31 crafts to 25, up to 38 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:247786}. One {item:247786} (10c) a craft; grey at 25 on Forever. Make the {item:6218} first: the recipe needs it in your bags, so keep it there. Enchant any item for that slot in your bags, even a grey one."] = "",
	["a tool: keep it in your bags"] = "",

	-- Step 14: Enchanting recipes at 25
	-- {skill:333} Enchanting
	["{skill:333} recipes at 25"] = "",
	-- {skill:333} Enchanting · {spell:7420} Enchant Chest - Inferior Stamina · {spell:1230643} Enchanted Lute · {item:4470} Simple Wood · {item:10940} Strange Dust
	["Back to an {skill:333} trainer: {spell:7420} (from 15, 50c). Also learn {spell:1230643} (1s): Forever's {skill:333} camp item, 1 {item:4470} and 1 {item:10940}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:333} quest from your starting area's camping guide (after The Great Outdoors) sends you to an enchanting trainer who teaches it free."] = "",

	-- Step 15: Enchant Chest - Inferior Stamina to 75
	-- {spell:7420} Enchant Chest - Inferior Stamina
	["{spell:7420} to 75"] = "",
	-- {spell:7420} Enchant Chest - Inferior Stamina · {item:10940} Strange Dust · {item:10938} Lesser Magic Essence · {spell:7423} Minor Absorption
	["{spell:7420} is orange at 25 (yellow 70, green 90, grey 110): about 51 crafts to 75, up to 52 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 16: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "",
	-- {skill:197} Tailoring · {npc:251972} Charles Worth · {zone:1416} Alterac Mountains · {npc:2627} Grarnik Goodstitch · {zone:1434} Stranglethorn Vale · {npc:5153} Jormund Stonebrow · {zone:1455} Ironforge · {npc:4159} Me'lynn · {zone:1457} Darnassus · {npc:252380} Othesia Evengale · {npc:5567} Sellandus · {zone:1453} Stormwind City · {npc:251991} Taleen Shimmerthread · {npc:3363} Magar · {zone:1454} Orgrimmar · {npc:3704} Mahani · {zone:1413} The Barrens · {npc:11049} Rhiannon Davis · {zone:1458} Undercity · {npc:3004} Tepa · {zone:1456} Thunder Bluff · {spell:2402} Woolen Cape · {item:2592} Wool Cloth · {item:4306} Silk Cloth · {skill:333} Enchanting
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:251972} ({zone:1416}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), {npc:5567} ({zone:1453}) and {npc:251991} (Zephras Isle); Horde {npc:2627} ({zone:1434}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and {npc:3004} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2402} (from 55, 2s 50c). 75-150 takes about 13s 50c of recipes and 93s 50c of vendor goods, plus 57 {item:2592} and 424 {item:4306} to gather or buy. Train Journeyman {skill:333} on the same trip (it needs {skill:333} 50 and character level 10; the arrow picks the nearest {skill:333} trainer who teaches it): the {skill:333} steps below need it."] = "",

	-- Step 17: Tailoring 75-150: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 75-150: vendor goods"] = "",
	-- {item:2321} Fine Thread · {item:2324} Bleach · {item:6260} Blue Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 68 {item:2321} (68s), 34 {item:2324} (8s 50c) and 34 {item:6260} (17s); about 93s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347} and {npc:1286}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 18: Get Wool Cloth
	-- {item:2592} Wool Cloth · {skill:197} Tailoring
	-- plural, as words: Woolen Capes = {spell:2402} Woolen Cape
	["57 {item:2592} for {skill:197} 75-150: 40 Woolen Capes. Humanoids of level 15-30 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:2592} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 19: Get Silk Cloth
	-- {item:4306} Silk Cloth
	["Get {item:4306}"] = "",
	-- {item:4306} Silk Cloth · {skill:197} Tailoring
	-- plural, as words: Formal White Shirts = {spell:3871} Formal White Shirt
	["424 {item:4306} for {skill:197} 75-150: 55 Bolts of Silk Cloth and 19 Formal White Shirts. Humanoids of level 25-45 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:4306} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 20: Woolen Cape to 100
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 100"] = "",
	-- {spell:2402} Woolen Cape · {spell:2964} Bolt of Woolen Cloth · {item:2321} Fine Thread
	["{spell:2402} is orange at 75 (yellow 80, green 97, grey 115): about 34 crafts to 100, up to 40 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {spell:2964} and 1 {item:2321}. Make the 13 {spell:2964} first: it gives points too while not grey. Use the 21 {spell:2964} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. If you got here without learning {spell:2964}, learn it now: an earlier step teaches it."] = "",

	-- Step 21: Tailoring recipes at 100
	-- {skill:197} Tailoring
	["{skill:197} recipes at 100"] = "",
	-- {skill:197} Tailoring · {spell:3839} Bolt of Silk Cloth
	["Back to a {skill:197} trainer: {spell:3839} (from 100, 5s)."] = "",

	-- Step 22: Bolt of Silk Cloth to 120
	-- {spell:3839} Bolt of Silk Cloth
	["{spell:3839} to 120"] = "",
	-- {spell:3839} Bolt of Silk Cloth · {item:4306} Silk Cloth
	["{spell:3839} is orange at 100 (yellow 110, green 115, grey 120): about 40 crafts to 120, up to 55 for 9 players in 10 (the gathered materials above count that many). Each takes 4 {item:4306}. {item:4306} drops from humanoids of level 25-45. Keep every bolt: the hoods and shirts to 150 take them, so these points cost no extra {item:4306}."] = "",

	-- Step 23: Tailoring recipes at 120
	-- {skill:197} Tailoring
	["{skill:197} recipes at 120"] = "",
	-- {skill:197} Tailoring · {spell:8760} Azure Silk Hood
	["Back to a {skill:197} trainer: {spell:8760} (from 120, 6s)."] = "",

	-- Step 24: Azure Silk Hood to 135
	-- {item:7048} Azure Silk Hood
	["{item:7048} to 135"] = "",
	-- {item:7048} Azure Silk Hood · {item:4305} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7048} is orange at 120 (yellow 130, green 135, grey 140): about 17 crafts to 135, up to 19 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:4305}, 2 {item:6260} and 1 {item:2321}. Use the 34 {item:4305} you made earlier; the counts above leave them out. Two silk bolts and two {item:6260} a hood: orange to 130, a point every craft."] = "",

	-- Step 25: Tailoring recipes at 135
	-- {skill:197} Tailoring
	["{skill:197} recipes at 135"] = "",
	-- {skill:197} Tailoring · {spell:3871} Formal White Shirt
	["Back to a {skill:197} trainer: {spell:3871} (from 135)."] = "",

	-- Step 26: Formal White Shirt to 150
	-- {spell:3871} Formal White Shirt
	["{spell:3871} to 150"] = "",
	-- {spell:3871} Formal White Shirt · {spell:3839} Bolt of Silk Cloth · {item:2324} Bleach · {item:2321} Fine Thread · {skill:197} Tailoring
	["{spell:3871} is orange at 135 (yellow 145, green 150, grey 155): about 17 crafts to 150, up to 19 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {spell:3839}, 2 {item:2324} and 1 {item:2321}. Make the 45 {spell:3839} first. Use the 6 {spell:3839} you made earlier; the counts above leave them out. {item:2324} from tailoring and trade supplies vendors. {skill:197} 150 is a Legacy System milestone."] = "",

	-- Step 27: Journeyman Enchanting
	-- {skill:333} Enchanting
	["Journeyman {skill:333}"] = "",
	-- {skill:197} Tailoring · {skill:333} Enchanting · {item:10940} Strange Dust · {item:11083} Soul Dust · {item:10939} Greater Magic Essence · {item:11082} Greater Astral Essence · {item:10978} Small Glimmering Shard · {npc:5157} Gimble Thistlefuzz · {zone:1455} Ironforge · {npc:1317} Lucan Cordell · {zone:1453} Stormwind City · {npc:4213} Taladan · {zone:1457} Darnassus · {npc:7949} Xylinnia Starshine · {zone:1444} Feralas · {npc:3345} Godan · {zone:1454} Orgrimmar · {npc:4616} Lavinia Crowe · {zone:1458} Undercity · {npc:3011} Teg Dawnstrider · {zone:1456} Thunder Bluff · {spell:7771} Enchant Cloak - Minor Protection · {item:1210} Shadowgem · {item:6338} Silver Rod · {item:10938} Lesser Magic Essence
	-- plural, as words: Woolen Capes = {spell:2402} Woolen Cape · Azure Silk Hoods = {item:7048} Azure Silk Hood
	["Disenchant the green armour you made for {skill:197} 75-150: 34 Woolen Capes and 17 Azure Silk Hoods (item level 29, from {skill:333} 50) give about 64 {item:10940}, 19 {item:11083}, 10 {item:10939}, 5 {item:11082} and 2 {item:10978}. Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:333} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:333} trainer teaches it: Alliance {npc:5157} ({zone:1455}), {npc:1317} ({zone:1453}), {npc:4213} ({zone:1457}) and {npc:7949} ({zone:1444}); Horde {npc:3345} ({zone:1454}), {npc:4616} ({zone:1458}) and {npc:3011} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:7771} (from 70, 2s). 75-150 takes about 2s of recipes, plus 1 {item:1210}, 1 {item:6338}, 4 {item:10938}, 136 {item:10940} and 20 {item:11083} to gather or buy."] = "",

	-- Step 28: Enchanting 75-150: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 75-150: vendor goods"] = "",
	-- {item:10938} Lesser Magic Essence
	["Buy the whole bracket's share in one go: 4 {item:10938} (32s). The arrow picks the nearest seller of your faction. {item:10938}: no vendor of the other faction sells it; that side gathers or buys it at the Auction House (next steps)."] = "",

	-- Step 29: Get Shadowgem
	-- {item:1210} Shadowgem
	["Get {item:1210}"] = "",
	-- {item:1210} Shadowgem · {skill:333} Enchanting · {item:6339} Runed Silver Rod · {object:1731} Copper Vein · {object:1732} Tin Vein · {object:1733} Silver Vein
	["1 {item:1210} for {skill:333} 75-150: {item:6339}. {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining. Or buy it at the Auction House."] = "",

	-- Step 30: Get Silver Rod
	-- {item:6338} Silver Rod
	["Get {item:6338}"] = "",
	-- {item:6338} Silver Rod · {skill:333} Enchanting · {item:6339} Runed Silver Rod · {skill:164} Blacksmithing
	["1 {item:6338} for {skill:333} 75-150: {item:6339}. {skill:164}: {item:6338}. Or buy it at the Auction House."] = "",

	-- Step 31: Get Strange Dust · Disenchant: Professions tab (K by default)
	-- {item:10940} Strange Dust · {skill:333} Enchanting · {spell:7420} Enchant Chest - Inferior Stamina · {spell:7771} Enchant Cloak - Minor Protection · {item:6339} Runed Silver Rod · {skill:197} Tailoring
	["136 {item:10940} for {skill:333} 75-150: 27 {spell:7420}, 53 {spell:7771} and {item:6339}. Disenchanting your {skill:197} crafts of this bracket gives about 64 of them (see Journeyman {skill:333}); the other 72 come from greens you loot or the Auction House. {skill:333}: disenchant green armour that requires level 1-20. Or buy them at the Auction House."] = "",

	-- Step 32: Get Soul Dust · Disenchant: Professions tab (K by default)
	-- {item:11083} Soul Dust
	["Get {item:11083} · Disenchant: Professions tab (K by default)"] = "",
	-- {item:11083} Soul Dust · {skill:333} Enchanting · {spell:13501} Enchant Bracer - Lesser Stamina · {skill:197} Tailoring
	["20 {item:11083} for {skill:333} 75-150: 20 {spell:13501}. Disenchanting your {skill:197} crafts of this bracket gives about 19 of them (see Journeyman {skill:333}); the other 1 come from greens you loot or the Auction House. {skill:333}: disenchant green armour that requires level 21-30. Or buy them at the Auction House."] = "",

	-- Step 33: Enchanting 75-150: Auction House
	-- {skill:333} Enchanting
	["{skill:333} 75-150: Auction House"] = "",
	-- {item:10938} Lesser Magic Essence
	["What 75-150 takes that the Auction House sells and no step above farms: 4 {item:10938}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 34: Enchant Chest - Inferior Stamina to 90
	-- {spell:7420} Enchant Chest - Inferior Stamina
	["{spell:7420} to 90"] = "",
	-- {spell:7420} Enchant Chest - Inferior Stamina · {item:10940} Strange Dust · {item:10938} Lesser Magic Essence · {spell:7423} Minor Absorption
	["{spell:7420} is yellow at 75 (yellow 70, green 90, grey 110): about 22 crafts to 90, up to 27 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. Enchant any item for that slot in your bags, even a grey one. If you got here without learning {spell:7420}, learn it now: an earlier step teaches it."] = "",

	-- Step 35: Enchant Cloak - Minor Protection to 130
	-- {spell:7771} Enchant Cloak - Minor Protection
	["{spell:7771} to 130"] = "",
	-- {spell:7771} Enchant Cloak - Minor Protection · {item:10940} Strange Dust
	["{spell:7771} is orange at 90 (yellow 110, green 130, grey 150): about 48 crafts to 130, up to 53 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:10940}. Two {item:10940} a craft (the trainer teaches it from 70 for 2s); keep disenchanting the greens of the 10-20 zones. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 36: Enchanting recipes at 130
	-- {skill:333} Enchanting
	["{skill:333} recipes at 130"] = "",
	-- {skill:333} Enchanting · {spell:7795} Runed Silver Rod · {spell:13501} Enchant Bracer - Lesser Stamina
	["Back to an {skill:333} trainer: {spell:7795} (from 100) and {spell:13501} (from 130)."] = "",

	-- Step 37: Enchant Bracer - Lesser Stamina to 150
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 150"] = "",
	-- {spell:13501} Enchant Bracer - Lesser Stamina · {item:11083} Soul Dust · {item:6339} Runed Silver Rod · {item:10938} Lesser Magic Essence · {skill:333} Enchanting
	["{spell:13501} is orange at 130 (yellow 155, green 175, grey 195): about 20 crafts to 150, a point every craft. Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:6339} first: the recipe needs it in your bags, so keep it there. {item:10938} (4 for 75-150): Alliance: {skill:333}: disenchant green armour that requires level 1-10; or the Auction House. Enchant any item for that slot in your bags, even a grey one. {skill:333} 150 is a Legacy System milestone."] = "",

	-- Step 38: Tailoring 150-225: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 150-225: vendor goods"] = "",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {item:6260} Blue Dye · {item:8343} Heavy Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 44 {item:2321} (44s), 108 {item:4291} (5g 40s), 44 {item:6260} (22s) and 74 {item:8343} (14g 80s); about 20g 86s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 39: Pattern: Azure Silk Cloak
	-- {item:7089} Pattern: Azure Silk Cloak · {item:7053} Azure Silk Cloak · {skill:197} Tailoring · {npc:6576} Brienna Starglow · {zone:1444} Feralas · {npc:251997} Norvin Alderman · {zone:1416} Alterac Mountains · {npc:6574} Jun'ha · {zone:1417} Arathi Highlands
	["{item:7089} teaches {item:7053} ({skill:197} 140) for 15s. Sold by Alliance: {npc:6576} ({zone:1444}), limited stock and {npc:251997} ({zone:1416}); Horde: {npc:6574} ({zone:1417}), limited stock and {npc:251997} ({zone:1416})."] = "",

	-- Step 40: Get Silk Cloth
	-- {item:4306} Silk Cloth · {skill:197} Tailoring
	-- plural, as words: Azure Silk Cloaks = {item:7053} Azure Silk Cloak
	["300 {item:4306} for {skill:197} 150-225: 25 Azure Silk Cloaks. Humanoids of level 25-45 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:4306} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 41: Get Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get {item:4338}"] = "",
	-- {item:4338} Mageweave Cloth · {skill:197} Tailoring
	-- plural, as words: Black Mageweave Vests = {item:9998} Black Mageweave Vest · Black Mageweave Headbands = {item:10024} Black Mageweave Headband
	["1060 {item:4338} for {skill:197} 150-225: 40 Black Mageweave Vests and 44 Black Mageweave Headbands. Humanoids of level 35-50 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:4338} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 42: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "",
	-- {skill:197} Tailoring · {npc:251972} Charles Worth · {zone:1416} Alterac Mountains · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {spell:3865} Bolt of Mageweave · {item:4306} Silk Cloth · {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["Expert raises the cap from 150 to 225; it needs {skill:197} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:251972} ({zone:1416}) and {npc:1346} ({zone:1453}); Horde {npc:4576} ({zone:1458}). This route trains it at {npc:1346} ({zone:1453}) for the Alliance and {npc:4576} ({zone:1458}) for the Horde, who also teach the recipes of 150-225: one trainer for every visit. Learn now: {spell:3865} (from 140). 150-225 takes about 15s of recipes and 20g 86s of vendor goods, plus 300 {item:4306} and 1060 {item:4338} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9998} (from 170), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 2. {item:10024} (from 200) takes a second trip, to other trainers (below)."] = "",

	-- Step 43: Azure Silk Cloak to 170
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 170"] = "",
	-- {item:7053} Azure Silk Cloak · {spell:3839} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7053} is orange at 150 (yellow 160, green 175, grey 190): about 22 crafts to 170, up to 25 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {spell:3839}, 2 {item:6260} and 2 {item:2321}. Make the 66 {spell:3839} first. Its recipe is the one bought above; it is the cheapest way through these points in the data. If you got here without learning {spell:3839}, learn it now: an earlier step teaches it."] = "",
	["from the recipe in your bags"] = "",

	-- Step 44: Tailoring recipes at 170
	-- {skill:197} Tailoring
	["{skill:197} recipes at 170"] = "",
	-- {spell:12048} Black Mageweave Vest
	["Still at the Expert trainer: {spell:12048} (from 170)."] = "",

	-- Step 45: Black Mageweave Vest to 200
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 200"] = "",
	-- {item:9998} Black Mageweave Vest · {spell:3865} Bolt of Mageweave · {item:4291} Silken Thread
	["{item:9998} is orange at 170 (yellow 185, green 200, grey 215): about 36 crafts to 200, up to 40 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {spell:3865} and 3 {item:4291}. Make the 72 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 46: Tailoring recipes at 200
	-- {skill:197} Tailoring
	["{skill:197} recipes at 200"] = "",
	-- {spell:12072} Black Mageweave Headband · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {skill:197} Tailoring
	["{spell:12072} (from 200) is taught only by the Artisan trainers: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). You can train Artisan there now if you are level 35 (it needs {skill:197} 200), which saves the trip at 225."] = "",

	-- Step 47: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "",
	-- {item:10024} Black Mageweave Headband · {spell:3865} Bolt of Mageweave · {item:8343} Heavy Silken Thread · {skill:197} Tailoring
	["{item:10024} is orange at 200 (yellow 205, green 220, grey 235): about 37 crafts to 225, up to 44 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {spell:3865} and 2 {item:8343}. Make the 111 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:197} 225 is a Legacy System milestone."] = "",

	-- Step 48: Get Iridescent Pearl (Alliance)
	-- {item:5500} Iridescent Pearl
	["Get {item:5500} (Alliance)"] = "",
	-- {item:5500} Iridescent Pearl · {skill:333} Enchanting · {item:11130} Runed Golden Rod
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["1 {item:5500} for {skill:333} 150-225: {item:11130}. Open the Giant Clams at the marked spot. Or buy it at the Auction House."] = "",

	-- Step 49: Get Iridescent Pearl (Horde)
	-- {item:5500} Iridescent Pearl
	["Get {item:5500} (Horde)"] = "",

	-- Step 50: Get Greater Astral Essence · Disenchant: Professions tab (K by default)
	-- {item:11082} Greater Astral Essence
	["Get {item:11082} · Disenchant: Professions tab (K by default)"] = "",
	-- {item:11082} Greater Astral Essence · {skill:333} Enchanting · {item:11130} Runed Golden Rod
	["1 {item:11082} for {skill:333} 150-225: {item:11130}. {skill:333}: disenchant green armour that requires level 21-25. Or buy it at the Auction House."] = "",

	-- Step 51: Get Soul Dust · Disenchant: Professions tab (K by default)
	-- {item:11083} Soul Dust · {skill:333} Enchanting · {item:11130} Runed Golden Rod · {spell:13501} Enchant Bracer - Lesser Stamina · {spell:13637} Enchant Boots - Lesser Agility · {skill:197} Tailoring
	["55 {item:11083} for {skill:333} 150-225: {item:11130}, 12 {spell:13501} and 42 {spell:13637}. Disenchanting your {skill:197} crafts of this bracket gives about 55 of them (see Expert {skill:333}); that covers them. {skill:333}: disenchant green armour that requires level 21-30. Or buy them at the Auction House."] = "",

	-- Step 52: Get Golden Rod
	-- {item:11128} Golden Rod
	["Get {item:11128}"] = "",
	-- {item:11128} Golden Rod · {skill:333} Enchanting · {item:11130} Runed Golden Rod · {skill:164} Blacksmithing
	["1 {item:11128} for {skill:333} 150-225: {item:11130}. {skill:164}: {item:11128}. Or buy it at the Auction House."] = "",

	-- Step 53: Get Lesser Mystic Essence · Disenchant: Professions tab (K by default)
	-- {item:11134} Lesser Mystic Essence
	["Get {item:11134} · Disenchant: Professions tab (K by default)"] = "",
	-- {item:11134} Lesser Mystic Essence · {skill:333} Enchanting · {spell:13663} Enchant Chest - Greater Intellect · {skill:197} Tailoring
	["10 {item:11134} for {skill:333} 150-225: 10 {spell:13663}. Disenchanting your {skill:197} crafts of this bracket gives about 7 of them (see Expert {skill:333}); the other 3 come from greens you loot or the Auction House. {skill:333}: disenchant green armour that requires level 26-30. Or buy them at the Auction House."] = "",

	-- Step 54: Get Greater Mystic Essence · Disenchant: Professions tab (K by default)
	-- {item:11135} Greater Mystic Essence
	["Get {item:11135} · Disenchant: Professions tab (K by default)"] = "",
	-- {item:11135} Greater Mystic Essence · {skill:333} Enchanting · {item:11145} Runed Truesilver Rod
	["1 {item:11135} for {skill:333} 150-225: {item:11145}. {skill:333}: disenchant green armour that requires level 31-35. Or buy it at the Auction House."] = "",

	-- Step 55: Get Vision Dust · Disenchant: Professions tab (K by default)
	-- {item:11137} Vision Dust
	["Get {item:11137} · Disenchant: Professions tab (K by default)"] = "",
	-- {item:11137} Vision Dust · {skill:333} Enchanting · {item:11145} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense · {skill:197} Tailoring
	["21 {item:11137} for {skill:333} 150-225: {item:11145} and 20 {spell:13746}. Disenchanting your {skill:197} crafts of this bracket gives about 21 of them (see Expert {skill:333}); that covers them. {skill:333}: disenchant green armour that requires level 31-40. Or buy them at the Auction House."] = "",

	-- Step 56: Get Truesilver Rod
	-- {item:11144} Truesilver Rod
	["Get {item:11144}"] = "",
	-- {item:11144} Truesilver Rod · {skill:333} Enchanting · {item:11145} Runed Truesilver Rod · {skill:164} Blacksmithing
	["1 {item:11144} for {skill:333} 150-225: {item:11145}. {skill:164}: {item:11144}. Or buy it at the Auction House."] = "",

	-- Step 57: Enchanting 150-225: Auction House
	-- {skill:333} Enchanting
	["{skill:333} 150-225: Auction House"] = "",
	-- {item:7971} Black Pearl
	["What 150-225 takes that the Auction House sells and no step above farms: 1 {item:7971}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 58: Expert Enchanting
	-- {skill:333} Enchanting
	["Expert {skill:333}"] = "",
	-- {skill:197} Tailoring · {skill:333} Enchanting · {item:11137} Vision Dust · {item:11083} Soul Dust · {item:11176} Dream Dust · {item:11175} Greater Nether Essence · {item:11174} Lesser Nether Essence · {item:11134} Lesser Mystic Essence · {item:11178} Large Radiant Shard · {item:11177} Small Radiant Shard · {item:11138} Small Glowing Shard · {npc:11072} Kitta Firewind · {zone:1429} Elwynn Forest · {npc:11074} Hgarth · {zone:1442} Stonetalon Mountains · {spell:13628} Runed Golden Rod · {item:5500} Iridescent Pearl · {item:7971} Black Pearl · {item:11082} Greater Astral Essence · {item:11128} Golden Rod · {item:11135} Greater Mystic Essence · {item:11144} Truesilver Rod · {spell:13637} Enchant Boots - Lesser Agility · {spell:13663} Enchant Chest - Greater Intellect · {item:11145} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	-- plural, as words: Azure Silk Cloaks = {item:7053} Azure Silk Cloak · Black Mageweave Vests = {item:9998} Black Mageweave Vest · Black Mageweave Headbands = {item:10024} Black Mageweave Headband
	["Disenchant the green armour you made for {skill:197} 150-225: 22 Azure Silk Cloaks (item level 35, from {skill:333} 75), 36 Black Mageweave Vests (item level 41, from {skill:333} 125) and 37 Black Mageweave Headbands (item level 46, from {skill:333} 150) give about 95 {item:11137}, 58 {item:11083}, 42 {item:11176}, 11 {item:11175}, 11 {item:11174}, 7 {item:11134}, 2 {item:11178}, 2 {item:11177} and 1 {item:11138}. Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:333} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:11072} ({zone:1429}); Horde {npc:11074} ({zone:1442}). This route trains it at {npc:11072} ({zone:1429}) for the Alliance and {npc:11074} ({zone:1442}) for the Horde, who also teach the recipes of 150-225: one trainer for every visit. Learn now: {spell:13628} (from 150). 150-225 takes 1 {item:5500}, 1 {item:7971}, 1 {item:11082}, 55 {item:11083}, 1 {item:11128}, 10 {item:11134}, 1 {item:11135}, 21 {item:11137} and 1 {item:11144} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:13637} (from 160), {spell:13663} (from 185), {item:11145} (from 200) and {spell:13746} (from 205), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 4."] = "",

	-- Step 59: Enchant Bracer - Lesser Stamina to 160
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 160"] = "",
	-- {spell:13501} Enchant Bracer - Lesser Stamina · {item:11083} Soul Dust · {item:11130} Runed Golden Rod
	["{spell:13501} is orange at 150 (yellow 155, green 175, grey 195): about 11 crafts to 160, up to 12 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:11130} now, while it still gives a point: a later recipe needs it in your bags, so keep it there. Enchant any item for that slot in your bags, even a grey one. If you got here without learning {spell:13501}, learn it now: an earlier step teaches it."] = "",

	-- Step 60: Enchanting recipes at 160
	-- {skill:333} Enchanting
	["{skill:333} recipes at 160"] = "",
	-- {spell:13637} Enchant Boots - Lesser Agility
	["Still at the Expert trainer: {spell:13637} (from 160)."] = "",

	-- Step 61: Enchant Boots - Lesser Agility to 195
	-- {spell:13637} Enchant Boots - Lesser Agility
	["{spell:13637} to 195"] = "",
	-- {spell:13637} Enchant Boots - Lesser Agility · {item:11083} Soul Dust
	["{spell:13637} is orange at 160 (yellow 180, green 200, grey 220): about 39 crafts to 195, up to 42 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:11083}. {item:11083} again. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 62: Enchanting recipes at 195
	-- {skill:333} Enchanting
	["{skill:333} recipes at 195"] = "",
	-- {spell:13663} Enchant Chest - Greater Intellect
	["Still at the Expert trainer: {spell:13663} (from 185)."] = "",

	-- Step 63: Enchant Chest - Greater Intellect to 205
	-- {spell:13663} Enchant Chest - Greater Intellect
	["{spell:13663} to 205"] = "",
	-- {spell:13663} Enchant Chest - Greater Intellect · {item:11134} Lesser Mystic Essence
	["{spell:13663} is orange at 195 (yellow 205, green 225, grey 245): about 10 crafts to 205, a point every craft. Each takes 1 {item:11134}. One {item:11134} a craft (weapons of level 31-40 break into essences); orange to 205, a point every craft. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 64: Enchanting recipes at 205
	-- {skill:333} Enchanting
	["{skill:333} recipes at 205"] = "",
	-- {spell:13702} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	["Still at the Expert trainer: {spell:13702} (from 200) and {spell:13746} (from 205)."] = "",

	-- Step 65: Enchant Cloak - Greater Defense to 225
	-- {spell:13746} Enchant Cloak - Greater Defense
	["{spell:13746} to 225"] = "",
	-- {spell:13746} Enchant Cloak - Greater Defense · {item:11137} Vision Dust · {item:11145} Runed Truesilver Rod · {item:7971} Black Pearl · {skill:333} Enchanting
	["{spell:13746} is orange at 205 (yellow 225, green 245, grey 265): about 20 crafts to 225, a point every craft. Each takes 1 {item:11137}. One {item:11137} a craft (level 31-40 greens). Make the {item:11145} first: the recipe needs it in your bags, so keep it there. {item:7971} (1 for 150-225): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find. Enchant any item for that slot in your bags, even a grey one. {skill:333} 225 is a Legacy System milestone."] = "",

	-- Step 66: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "",
	-- {skill:197} Tailoring · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {spell:18401} Bolt of Runecloth · {spell:18402} Runecloth Belt · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14504} Pattern: Runecloth Shoulders · {item:14227} Ironweb Spider Silk
	["Artisan raises the cap from 225 to 300; it needs {skill:197} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). This route trains it at {npc:11052} ({zone:1445}) for the Alliance and {npc:2399} ({zone:1424}) for the Horde, who also teach the recipes of 225-300: one trainer for every visit. Learn now: {spell:18401} (from 205) and {spell:18402} (from 210). 225-300 takes about 1g 60s of recipes and 27g of vendor goods, plus 200 {item:8170} and 1195 {item:14047} to gather or buy. From 265 the route splits: with {item:14504}, about 62 more crafts and 296 {item:8170}, 2590 {item:14047} and 148 {item:14227}; without the pattern, about 100 crafts and 588 {item:8170}, 2940 {item:14047} and 294 {item:14227} (to 280)."] = "",

	-- Step 67: Tailoring 225-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 225-300: vendor goods"] = "",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3366} Tamar
	["Buy the whole bracket's share in one go: 54 {item:14341} (27g); about 27g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347} and {npc:5565}; {zone:1454}: {npc:3364} and {npc:3366})."] = "",

	-- Step 68: Pattern: Runecloth Gloves
	-- {item:14481} Pattern: Runecloth Gloves · {item:13863} Runecloth Gloves · {skill:197} Tailoring · {npc:11189} Qia · {zone:1452} Winterspring
	["{item:14481} teaches {item:13863} ({skill:197} 230) for 1g 60s. Sold by {npc:11189} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 69: Get Rugged Leather
	-- {item:8170} Rugged Leather
	["Get {item:8170}"] = "",
	-- {item:8170} Rugged Leather · {skill:197} Tailoring · {item:13863} Runecloth Gloves · {skill:393} Skinning
	["200 {item:8170} for {skill:197} 225-300: 50 {item:13863}. {skill:393}: beasts of level 48-60. The window lists the {skill:393} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them. Or buy them at the Auction House."] = "",

	-- Step 70: Get Runecloth
	-- {item:14047} Runecloth
	["Get {item:14047}"] = "",
	-- {item:14047} Runecloth · {skill:197} Tailoring · {item:13863} Runecloth Gloves
	-- plural, as words: Runecloth Belts = {item:13856} Runecloth Belt
	["1195 {item:14047} for {skill:197} 225-300: 13 Runecloth Belts and 50 {item:13863}. Humanoids of level 45-60 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14047} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 71: Runecloth Belt to 234
	-- {item:13856} Runecloth Belt
	["{item:13856} to 234"] = "",
	-- {item:13856} Runecloth Belt · {item:14048} Bolt of Runecloth · {item:14341} Rune Thread
	["{item:13856} is yellow at 225 (yellow 225, green 240, grey 255): about 11 crafts to 234, up to 13 for 9 players in 10 (the gathered materials above count that many). Each takes 3 {item:14048} and 1 {item:14341}. Make the 33 {item:14048} first. {item:14341} from tailoring vendors."] = "",

	-- Step 72: Runecloth Gloves to 265
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 265"] = "",
	-- {item:13863} Runecloth Gloves · {item:14048} Bolt of Runecloth · {item:8170} Rugged Leather · {item:14341} Rune Thread · {npc:11189} Qia · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{item:13863} is orange at 234 (yellow 245, green 260, grey 275): about 43 crafts to 265, up to 50 for 9 players in 10 (the gathered materials above count that many). Each takes 4 {item:14048}, 4 {item:8170} and 1 {item:14341}. Make the 172 {item:14048} first. {npc:11189} in {area:2255} keeps one pattern at a time; the {area:1769} tunnel from {zone:1448} is the road in, so never kill Timbermaw furbolgs on the way."] = "",

	-- Step 73: Artisan Enchanting
	-- {skill:333} Enchanting
	["Artisan {skill:333}"] = "",
	-- {skill:197} Tailoring · {skill:333} Enchanting · {item:13863} Runecloth Gloves · {item:11176} Dream Dust · {item:16202} Lesser Eternal Essence · {item:14343} Small Brilliant Shard · {npc:11073} Annora · {area:1517} Uldaman · {zone:1418} Badlands · {spell:13815} Enchant Gloves - Agility · {item:8831} Purple Lotus · {item:11137} Vision Dust
	-- plural, as words: Runecloth Belts = {item:13856} Runecloth Belt
	["Disenchant the green armour you made for {skill:197} 225-300: 11 Runecloth Belts (item level 51, from {skill:333} 175) and 43 {item:13863} (item level 55, from {skill:333} 175) give about 142 {item:11176}, 16 {item:16202} and 3 {item:14343}. Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:333} 200 and character level 35, so you can take it on any visit from 200. {npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group. Learn now: {spell:13815} (from 210). 225-300 takes about 2g 20s of recipes and 1g 70s of vendor goods, plus 41 {item:8831}, 45 {item:11137} and 233 {item:11176} to gather or buy."] = "",

	-- Step 74: Enchanting 225-300: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 225-300: vendor goods"] = "",
	-- {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 34 {item:8925} (1g 70s); about 1g 70s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "",

	-- Step 75: Formula: Lesser Mana Oil
	-- {item:20754} Formula: Lesser Mana Oil · {item:20747} Lesser Mana Oil · {skill:333} Enchanting · {npc:15419} Kania · {zone:1451} Silithus
	["{item:20754} teaches {item:20747} ({skill:333} 250) for 1g. Sold by {npc:15419} ({zone:1451})."] = "",

	-- Step 76: Formula: Enchant Shield - Greater Stamina
	-- {item:16217} Formula: Enchant Shield - Greater Stamina · {spell:20017} Enchant Shield - Greater Stamina · {skill:333} Enchanting · {npc:4229} Mythrin'dir · {zone:1457} Darnassus · {npc:4561} Daniel Bartlett · {zone:1458} Undercity
	["{item:16217} teaches {spell:20017} ({skill:333} 265) for 1g 20s. Sold by Alliance: {npc:4229} ({zone:1457}), limited stock; Horde: {npc:4561} ({zone:1458}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 77: Get Purple Lotus
	-- {item:8831} Purple Lotus
	["Get {item:8831}"] = "",
	-- {item:8831} Purple Lotus · {skill:333} Enchanting · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- plural, as words: Lesser Mana Oils = {item:20747} Lesser Mana Oil
	["41 {item:8831} for {skill:333} 225-300: 41 Lesser Mana Oils. {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The window lists the {skill:182} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them. Or buy them at the Auction House."] = "",

	-- Step 78: Get Vision Dust · Disenchant: Professions tab (K by default)
	-- {item:11137} Vision Dust · {skill:333} Enchanting · {spell:13815} Enchant Gloves - Agility
	["45 {item:11137} for {skill:333} 225-300: 45 {spell:13815}. {skill:333}: disenchant green armour that requires level 31-40. Or buy them at the Auction House."] = "",

	-- Step 79: Get Dream Dust · Disenchant: Professions tab (K by default)
	-- {item:11176} Dream Dust
	["Get {item:11176} · Disenchant: Professions tab (K by default)"] = "",
	-- {item:11176} Dream Dust · {skill:333} Enchanting · {spell:20017} Enchant Shield - Greater Stamina · {skill:197} Tailoring
	-- plural, as words: Lesser Mana Oils = {item:20747} Lesser Mana Oil
	["233 {item:11176} for {skill:333} 225-300: 41 Lesser Mana Oils and 32 {spell:20017}. Disenchanting your {skill:197} crafts of this bracket gives about 142 of them (see Artisan {skill:333}); the other 91 come from greens you loot or the Auction House. {skill:333}: disenchant green armour that requires level 41-50. Or buy them at the Auction House."] = "",

	-- Step 80: Enchant Gloves - Agility to 253
	-- {spell:13815} Enchant Gloves - Agility
	["{spell:13815} to 253"] = "",
	-- {spell:13815} Enchant Gloves - Agility · {item:11137} Vision Dust · {npc:11073} Annora
	["{spell:13815} is orange at 225 (yellow 230, green 250, grey 270): about 39 crafts to 253, up to 45 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:11137}. {npc:11073} teaches it with Artisan: learn it on that visit. {item:11137} again; bring about 40. Enchant any item for that slot in your bags, even a grey one."] = "",

	-- Step 81: Lesser Mana Oil to 275
	-- {item:20747} Lesser Mana Oil
	["{item:20747} to 275"] = "",
	-- {item:20747} Lesser Mana Oil · {item:11176} Dream Dust · {item:8831} Purple Lotus · {item:8925} Crystal Vial · {npc:15419} Kania · {area:3425} Cenarion Hold · {zone:1451} Silithus
	["{item:20747} is orange at 253 (yellow 260, green 270, grey 280): about 34 crafts to 275, up to 41 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:11176}, 1 {item:8831} and 1 {item:8925}. One {item:11176} (level 41-50 greens) and one {item:8831} (herbalists) a craft; the oil sells well. {npc:15419} sells the formula at the inn of {area:3425} ({zone:1451}): fly there, the mobs around it are level 55 and up."] = "",

	-- Step 82: Enchant Shield - Greater Stamina to 300
	-- {spell:20017} Enchant Shield - Greater Stamina
	["{spell:20017} to 300"] = "",
	-- {spell:20017} Enchant Shield - Greater Stamina · {item:11176} Dream Dust · {skill:333} Enchanting
	["{spell:20017} is orange at 275 (yellow 285, green 305, grey 325): about 29 crafts to 300, up to 32 for 9 players in 10 (the gathered materials above count that many). Each takes 6 {item:11176}. Six {item:11176} a craft: the dearest stretch, so disenchant every level 41-50 green you find. Enchant any item for that slot in your bags, even a grey one. {skill:333} 300 is a Legacy System milestone."] = "",

	-- Step 83: Tailoring 265: Pattern: Runecloth Shoulders
	-- {item:14504} Pattern: Runecloth Shoulders · {spell:18449} Runecloth Shoulders · {item:13864} Runecloth Boots
	["From 265 the route has two ways. {item:14504} drops from mobs all over the world and does not bind, so the Auction House often lists it: with it, {spell:18449} (orange to 275, yellow to 290) takes you to 300. No pattern for sale? Skip this step: the next steps go on with {item:13864}, from a vendor pattern, to 280, and say what is left after that. Buy the shoulders pattern whenever it turns up: it gives points to 305."] = "",

	-- Step 84: Tailoring 265-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 265-300: vendor goods"] = "",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3366} Tamar
	["Buy the whole bracket's share in one go: 62 {item:14341} (31g); about 31g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347} and {npc:5565}; {zone:1454}: {npc:3364} and {npc:3366})."] = "",

	-- Step 85: Get Rugged Leather
	-- {item:8170} Rugged Leather · {skill:197} Tailoring · {item:13867} Runecloth Shoulders · {skill:393} Skinning
	["296 {item:8170} for {skill:197} 265-300: 74 {item:13867}. {skill:393}: beasts of level 48-60. The window lists the {skill:393} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them. Or buy them at the Auction House."] = "",

	-- Step 86: Get Runecloth
	-- {item:14047} Runecloth · {skill:197} Tailoring · {item:13867} Runecloth Shoulders
	["2590 {item:14047} for {skill:197} 265-300: 74 {item:13867}. Humanoids of level 45-60 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14047} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 87: Get Ironweb Spider Silk
	-- {item:14227} Ironweb Spider Silk
	["Get {item:14227}"] = "",
	-- {item:14227} Ironweb Spider Silk · {skill:197} Tailoring · {item:13867} Runecloth Shoulders · {npc:1824} Plague Lurker · {npc:11739} Rock Stalker · {npc:5857} Searing Lava Spider
	["148 {item:14227} for {skill:197} 265-300: 74 {item:13867}. {item:14227} drops most from {npc:1824}, {npc:11739} and {npc:5857}, among others. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14227} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 88: Runecloth Shoulders to 300
	-- {item:13867} Runecloth Shoulders
	["{item:13867} to 300"] = "",
	-- {item:13867} Runecloth Shoulders · {item:14048} Bolt of Runecloth · {item:14227} Ironweb Spider Silk · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:14504} Pattern: Runecloth Shoulders · {zone:1422} Western Plaguelands · {zone:1451} Silithus · {skill:197} Tailoring
	["{item:13867} is orange at 265 (yellow 275, green 290, grey 305): about 62 crafts to 300, up to 74 for 9 players in 10 (the gathered materials above count that many). Each takes 7 {item:14048}, 2 {item:14227}, 4 {item:8170} and 1 {item:14341}. Make the 434 {item:14048} first. Its pattern ({item:14504}) drops from mobs all over the world and does not bind: buy it at the Auction House. Seven bolts, two {item:14227} and four {item:8170} a craft: the dearest stretch. The spiders of {zone:1422} and {zone:1451} drop the silk (the marked spots), or the Auction House. {skill:197} 300 is a Legacy System milestone. If you got here without learning {item:14048}, learn it now: an earlier step teaches it."] = "",

	-- Step 89: Tailoring 265-300: vendor goods
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3366} Tamar
	["Buy the whole bracket's share in one go: 100 {item:14341} (50g); about 50g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347} and {npc:5565}; {zone:1454}: {npc:3364} and {npc:3366})."] = "",

	-- Step 90: Pattern: Runecloth Boots
	-- {item:14488} Pattern: Runecloth Boots · {item:13864} Runecloth Boots · {skill:197} Tailoring · {npc:7940} Darnall · {zone:1450} Moonglade
	["{item:14488} teaches {item:13864} ({skill:197} 235) for 2g. Sold by {npc:7940} ({zone:1450}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 91: Get Rugged Leather
	-- {item:8170} Rugged Leather · {skill:197} Tailoring · {item:13864} Runecloth Boots · {skill:393} Skinning
	["588 {item:8170} for {skill:197} 265-300: 147 {item:13864}. {skill:393}: beasts of level 48-60. The window lists the {skill:393} areas for your level, best first: the arrow leads to the one you pick and rests there until your bags hold them. Or buy them at the Auction House."] = "",

	-- Step 92: Get Runecloth
	-- {item:14047} Runecloth · {skill:197} Tailoring · {item:13864} Runecloth Boots
	["2940 {item:14047} for {skill:197} 265-300: 147 {item:13864}. Humanoids of level 45-60 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14047} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 93: Get Ironweb Spider Silk
	-- {item:14227} Ironweb Spider Silk · {skill:197} Tailoring · {item:13864} Runecloth Boots · {npc:1824} Plague Lurker · {npc:11739} Rock Stalker · {npc:5857} Searing Lava Spider
	["294 {item:14227} for {skill:197} 265-300: 147 {item:13864}. {item:14227} drops most from {npc:1824}, {npc:11739} and {npc:5857}, among others. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14227} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 94: Runecloth Boots to 280
	-- {item:13864} Runecloth Boots
	["{item:13864} to 280"] = "",
	-- {item:13864} Runecloth Boots · {item:14048} Bolt of Runecloth · {item:14227} Ironweb Spider Silk · {item:8170} Rugged Leather · {item:14341} Rune Thread
	["{item:13864} is green at 265 (yellow 250, green 265, grey 280): about 100 crafts to 280, up to 147 for 9 players in 10 (the gathered materials above count that many). Each takes 4 {item:14048}, 2 {item:14227}, 4 {item:8170} and 1 {item:14341}. Make the 400 {item:14048} first. Four Bolts of Runecloth, four {item:8170} and two {item:14227} a craft, and green the whole way: the long way, but its pattern can always be bought. If you got here without learning {item:14048}, learn it now: an earlier step teaches it."] = "",

	-- Step 95: Tailoring 280-300
	-- {skill:197} Tailoring · {item:13867} Runecloth Shoulders · {item:14112} Felcloth Shoulders · {item:14106} Felcloth Robe · {item:14130} Wizardweave Turban · {item:13866} Runecloth Headband · {item:14111} Felcloth Hood · {item:279943} Spinning Wheel · {npc:248202} Jim'bek · {npc:256735} Mivin Shadowweave · {npc:246017} Unstable Sentinel · {item:14342} Mooncloth · {npc:11189} Qia · {npc:11188} Evie Whirlbrew · {area:2255} Everlook · {item:14256} Felcloth
	["Past 280 no pattern you can always get gives {skill:197} points on Forever without a camp station. The world-drop patterns come from the Auction House: check it again, as {item:13867}, {item:14112}, {item:14106} and {item:14130} each finish the route ({item:13866} and {item:14111} give points to 290-295). The {item:279943} patterns (Merchant's Favor sandals and waistcords from {npc:248202} or {npc:256735}) need the camp wheel, whose blueprint drops from the {npc:246017} in the City of Dalaran. {item:14342} ({npc:11189} or {npc:11188} in {area:2255}; 2 {item:14256} at a Moonwell, yellow to 285) can be made once every four days: about a month for the five points it gives here."] = "",
}
