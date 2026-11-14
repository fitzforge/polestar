-- Chinese (traditional) (zhTW): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Tailoring
	-- {skill:197} Tailoring
	["Learn {skill:197}"] = "",
	-- {skill:197} Tailoring · {item:2589} Linen Cloth
	["Apprentice {skill:197} lets you craft up to 75 for 10c, at any character level. Any {skill:197} trainer of your faction teaches it; the arrow picks the nearest. Keep every {item:2589} you loot: humanoids of level 5-20 drop it. 1-75 takes about 50c of recipes and 7s 20c of vendor goods, plus 144 {item:2589} to gather or buy."] = "",

	-- Step 2: Tailoring 1-75: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 1-75: vendor goods"] = "",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 72 {item:2320} (7s 20c); about 7s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "一次買齊這個階段的用量：72個{item:2320}（7銀20銅）；總計約7銀20銅。箭頭會指向你陣營最近的賣家（{zone:1453}：{npc:1347}、{npc:1286}和{npc:5565}；{zone:1454}：{npc:3364}、菲利卡和{npc:5817}）。",

	-- Step 3: Tailoring 1-75: Auction House
	-- {skill:197} Tailoring
	["{skill:197} 1-75: Auction House"] = "",
	-- {item:2589} Linen Cloth
	["What 1-75 takes that the Auction House sells: 144 {item:2589}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 4: Linen Cloth
	-- {item:2589} Linen Cloth · {spell:2387} Linen Cloak · {item:7026} Linen Belt
	["144 {item:2589} for {spell:2387} and {item:7026}: humanoids of level 5-20 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 5: Linen Cloak to 15
	-- {spell:2387} Linen Cloak
	["{spell:2387} to 15"] = "",
	-- {spell:2387} Linen Cloak · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{spell:2387} is orange at 1 (yellow 35, green 47, grey 60): about 7 crafts to 15, a point every craft. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 7 {spell:2963} first: it gives points too while not grey. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 6: Tailoring recipes at 15
	-- {skill:197} Tailoring
	["{skill:197} recipes at 15"] = "",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} (from 15, 50c)."] = "",

	-- Step 7: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026}練到 75",
	-- {item:7026} Linen Belt · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{item:7026} is orange at 15 (yellow 50, green 67, grey 85): about 65 crafts to 75. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 65 {spell:2963} first: it gives points too while not grey. Each belt takes one bolt; the belts sell to vendors."] = "",

	-- Step 8: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "中級{skill:197}",
	-- {skill:197} Tailoring · {npc:2627} Grarnik Goodstitch · {zone:1434} Stranglethorn Vale · {npc:5153} Jormund Stonebrow · {zone:1455} Ironforge · {npc:4159} Me'lynn · {zone:1457} Darnassus · {npc:252380} Othesia Evengale · {npc:5567} Sellandus · {zone:1453} Stormwind City · {npc:251991} Taleen Shimmerthread · {npc:3363} Magar · {zone:1454} Orgrimmar · {npc:3704} Mahani · {zone:1413} The Barrens · {npc:11049} Rhiannon Davis · {zone:1458} Undercity · {npc:3004} Tepa · {zone:1456} Thunder Bluff · {spell:2964} Bolt of Woolen Cloth · {spell:2402} Woolen Cape · {spell:1229504} Faction Banner · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread · {item:2592} Wool Cloth · {item:4306} Silk Cloth
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), {npc:5567} ({zone:1453}) and {npc:251991} (Zephras Isle); Horde {npc:2627} ({zone:1434}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and {npc:3004} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "中級將上限從75提高到150，費用5銀；需要{skill:197} 50和角色等級10，所以技能達到50後，任何一次經過都可以學。並非每位{skill:197}訓練師都會教：聯盟有{npc:2627}（{zone:1434}）、{npc:5153}（{zone:1455}）、{npc:4159}（{zone:1457}）、{npc:252380}（微風島）、{npc:5567}（{zone:1453}）和{npc:251991}（微風島）；部落有{npc:2627}（{zone:1434}）、{npc:3363}（{zone:1454}）、{npc:3704}（{zone:1413}）、{npc:252380}（微風島）、{npc:11049}（{zone:1458}）、{npc:251991}（微風島）和{npc:3004}（{zone:1456}）。箭頭會選擇你陣營最近的一位。現在學習：{spell:2964}（技能55起，1銀）和{spell:2402}（技能55起，2銀50銅）。也學習{spell:1229504}（1銀）：這是Forever的{skill:197}紮營物品，需要一份{spell:2963}和一個{item:2320}；每個陣營各有自己的版本。起始地區紮營嚮導（完成「戶外真好」後）提供的「紮營入門指南：{skill:197}」任務，會讓你去找免費教授它的裁縫訓練師。75-150約需11銀的配方和1金65銀50銅的商人材料，另需採集或購買567份{item:2592}和204份{item:4306}。",

	-- Step 9: Tailoring 75-150: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 75-150: vendor goods"] = "",
	-- {item:2321} Fine Thread · {item:2324} Bleach · {item:2604} Red Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) and 98 {item:2604} (49s); about 1g 65s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "一次買齊這個階段的用量：108個{item:2321}（1金8銀）、34個{item:2324}（8銀50銅）和98個{item:2604}（49銀）；總計約1金65銀50銅。箭頭會指向你陣營最近的賣家（{zone:1453}：{npc:1347}、{npc:1286}和{npc:5565}；{zone:1454}：{npc:3364}、菲利卡和{npc:5817}）。",

	-- Step 10: Tailoring 75-150: Auction House
	-- {skill:197} Tailoring
	["{skill:197} 75-150: Auction House"] = "",
	-- {item:2592} Wool Cloth · {item:4306} Silk Cloth
	["What 75-150 takes that the Auction House sells: 567 {item:2592} and 204 {item:4306}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 11: Wool Cloth
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 12: Silk Cloth
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 13: Woolen Cape to 104
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 104"] = "",
	-- {spell:2402} Woolen Cape · {spell:2964} Bolt of Woolen Cloth · {item:2321} Fine Thread
	["{spell:2402} is orange at 75 (yellow 80, green 97, grey 115): about 42 crafts to 104. Each takes 1 {spell:2964} and 1 {item:2321}. Make the 42 {spell:2964} first: it gives points too while not grey. {spell:2964} is taught from 55 on Forever."] = "",

	-- Step 14: Tailoring recipes at 104
	-- {skill:197} Tailoring
	["{skill:197} recipes at 104"] = "",
	-- {skill:197} Tailoring · {spell:3866} Stylish Red Shirt
	["Back to a {skill:197} trainer: {spell:3866} (from 85, 2s 50c)."] = "",

	-- Step 15: Stylish Red Shirt to 135
	-- {spell:3866} Stylish Red Shirt
	["{spell:3866} to 135"] = "",
	-- {spell:3866} Stylish Red Shirt · {spell:2964} Bolt of Woolen Cloth · {item:2604} Red Dye · {item:2321} Fine Thread · {item:2592} Wool Cloth
	["{spell:3866} is orange at 104 (yellow 110, green 127, grey 145): about 49 crafts to 135. Each takes 3 {spell:2964}, 2 {item:2604} and 1 {item:2321}. Make the 147 {spell:2964} first. Three woolen bolts and two {item:2604} a shirt; {item:2592} drops from humanoids of level 15-30."] = "",

	-- Step 16: Tailoring recipes at 135
	-- {skill:197} Tailoring
	["{skill:197} recipes at 135"] = "",
	-- {skill:197} Tailoring · {spell:3839} Bolt of Silk Cloth · {spell:3871} Formal White Shirt
	["Back to a {skill:197} trainer: {spell:3839} (from 100, 5s) and {spell:3871} (from 135)."] = "",

	-- Step 17: Formal White Shirt to 150
	-- {spell:3871} Formal White Shirt
	["{spell:3871} to 150"] = "",
	-- {spell:3871} Formal White Shirt · {spell:3839} Bolt of Silk Cloth · {item:2324} Bleach · {item:2321} Fine Thread · {item:4306} Silk Cloth · {skill:197} Tailoring
	["{spell:3871} is orange at 135 (yellow 145, green 150, grey 155): about 17 crafts to 150. Each takes 3 {spell:3839}, 2 {item:2324} and 1 {item:2321}. Make the 51 {spell:3839} first. Silk bolts from here on: {item:4306} drops from humanoids of level 25-45. {item:2324} from tailoring and trade supplies vendors. {skill:197} 150 is a Legacy System milestone."] = "",

	-- Step 18: Tailoring 150-225: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 150-225: vendor goods"] = "",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {item:6260} Blue Dye · {item:8343} Heavy Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) and 80 {item:8343} (16g); about 21g 16s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "一次買齊這個階段的用量：44個{item:2321}（44銀）、90個{item:4291}（4金50銀）、44個{item:6260}（22銀）和80個{item:8343}（16金）；總計約21金16銀。箭頭會指向你陣營最近的賣家（{zone:1453}：{npc:1347}、{npc:1286}和{npc:5565}；{zone:1454}：{npc:3364}、菲利卡和{npc:5817}）。",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7089} Pattern: Azure Silk Cloak · {item:7053} Azure Silk Cloak · {skill:197} Tailoring · {npc:6576} Brienna Starglow · {zone:1444} Feralas · {npc:251997} Norvin Alderman · {zone:1416} Alterac Mountains · {npc:6574} Jun'ha · {zone:1417} Arathi Highlands
	["{item:7089} teaches {item:7053} ({skill:197} 140) for 15s. Sold by Alliance: {npc:6576} ({zone:1444}), limited stock and {npc:251997} ({zone:1416}); Horde: {npc:6574} ({zone:1417}), limited stock and {npc:251997} ({zone:1416})."] = "",

	-- Step 20: Tailoring 150-225: Auction House
	-- {skill:197} Tailoring
	["{skill:197} 150-225: Auction House"] = "",
	-- {item:4306} Silk Cloth · {item:4338} Mageweave Cloth
	["What 150-225 takes that the Auction House sells: 264 {item:4306} and 900 {item:4338}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 21: Silk Cloth
	-- {item:4306} Silk Cloth · {item:7053} Azure Silk Cloak
	["264 {item:4306} for {item:7053}: humanoids of level 25-45 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 22: Mageweave Cloth
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 23: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "高級{skill:197}",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {spell:3865} Bolt of Mageweave · {item:4306} Silk Cloth · {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["Expert raises the cap from 150 to 225; it needs {skill:197} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:1346} ({zone:1453}); Horde {npc:4576} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3865} (from 140). 150-225 takes about 15s of recipes and 21g 16s of vendor goods, plus 264 {item:4306} and 900 {item:4338} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9998} (from 170) and {item:10024} (from 190), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "高級將上限從150提高到225；需要{skill:197} 125和角色等級20，所以技能達到125後，任何一次經過都可以學。只有少數訓練師會教：聯盟為{npc:1346}（{zone:1453}）；部落為{npc:4576}（{zone:1458}）。箭頭會選擇你陣營最近的一位。現在學習：{spell:3865}（技能140起）。150-225約需15銀的配方和21金16銀的商人材料，另需採集或購買264份{item:4306}和900份{item:4338}。把這些全部帶在背包裡再來（按上面的步驟收集，其餘從拍賣場購買）：這些訓練師也教{item:9998}（技能170起）和{item:10024}（技能190起），而且製作不需要工作台，可以就在這裡製作，技能一到就學新配方。只要跑一趟，不用跑3趟。",

	-- Step 24: Azure Silk Cloak to 170
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 170"] = "",
	-- {item:7053} Azure Silk Cloak · {spell:3839} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7053} is orange at 150 (yellow 160, green 175, grey 190): about 22 crafts to 170. Each takes 3 {spell:3839}, 2 {item:6260} and 2 {item:2321}. Make the 66 {spell:3839} first. Its recipe is the one bought above; it is the cheapest way through these points in the data."] = "",
	["from the recipe in your bags"] = "使用背包中的配方",

	-- Step 25: Tailoring recipes at 170
	-- {skill:197} Tailoring
	["{skill:197} recipes at 170"] = "",
	-- {spell:12048} Black Mageweave Vest
	["Still at the Expert trainer: {spell:12048} (from 170)."] = "",

	-- Step 26: Black Mageweave Vest to 197
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 197"] = "",
	-- {item:9998} Black Mageweave Vest · {spell:3865} Bolt of Mageweave · {item:4291} Silken Thread
	["{item:9998} is orange at 170 (yellow 185, green 200, grey 215): about 30 crafts to 197. Each takes 2 {spell:3865} and 3 {item:4291}. Make the 60 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 27: Tailoring recipes at 197
	-- {skill:197} Tailoring
	["{skill:197} recipes at 197"] = "",
	-- {spell:12072} Black Mageweave Headband
	["Still at the Expert trainer: {spell:12072} (from 190)."] = "",

	-- Step 28: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024}練到 225",
	-- {item:10024} Black Mageweave Headband · {spell:3865} Bolt of Mageweave · {item:8343} Heavy Silken Thread · {skill:197} Tailoring
	["{item:10024} is orange at 197 (yellow 205, green 220, grey 235): about 40 crafts to 225. Each takes 3 {spell:3865} and 2 {item:8343}. Make the 120 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:197} 225 is a Legacy System milestone."] = "",

	-- Step 29: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "專家級{skill:197}",
	-- {skill:197} Tailoring · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {spell:18401} Bolt of Runecloth · {spell:18402} Runecloth Belt · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14227} Ironweb Spider Silk
	["Artisan raises the cap from 225 to 300; it needs {skill:197} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). The arrow picks the nearest of your faction. Learn now: {spell:18401} (from 205) and {spell:18402} (from 210). 225-300 takes about 1g 60s of recipes and 58g of vendor goods, plus 420 {item:8170}, 3195 {item:14047} and 124 {item:14227} to gather or buy."] = "",

	-- Step 30: Tailoring 225-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 225-300: vendor goods"] = "",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 116 {item:14341} (58g); about 58g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "一次買齊這個階段的用量：116個{item:14341}（58金）；總計約58金。箭頭會指向你陣營最近的賣家（{zone:1453}：{npc:1347}、{npc:1286}和{npc:5565}；{zone:1454}：{npc:3364}、菲利卡和{npc:5817}）。",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:14481} Pattern: Runecloth Gloves · {item:13863} Runecloth Gloves · {skill:197} Tailoring · {npc:11189} Qia · {zone:1452} Winterspring
	["{item:14481} teaches {item:13863} ({skill:197} 230) for 1g 60s. Sold by {npc:11189} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "",

	-- Step 32: Tailoring 225-300: Auction House
	-- {skill:197} Tailoring
	["{skill:197} 225-300: Auction House"] = "",
	-- {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14227} Ironweb Spider Silk · {item:14504} Pattern: Runecloth Shoulders
	["What 225-300 takes that the Auction House sells: 420 {item:8170}, 3195 {item:14047}, 124 {item:14227} and a {item:14504}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 33: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170}（聯盟）",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:8598} Frenzied Plaguehound · {npc:8596} Plaguehound Runt
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 34: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170}（部落）",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 35: Runecloth
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 36: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227}（聯盟）",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:1824} Plague Lurker
	["124 {item:14227} for {item:13867}: it drops from {npc:1824} (level 54-55) at the marked spot."] = "",

	-- Step 37: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227}（部落）",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:11738} Sand Skitterer
	["124 {item:14227} for {item:13867}: it drops from {npc:11738} (level 55-56) at the marked spot."] = "",

	-- Step 38: Runecloth Belt to 234
	-- {item:13856} Runecloth Belt
	["{item:13856} to 234"] = "",
	-- {item:13856} Runecloth Belt · {item:14048} Bolt of Runecloth · {item:14341} Rune Thread
	["{item:13856} is yellow at 225 (yellow 225, green 240, grey 255): about 11 crafts to 234. Each takes 3 {item:14048} and 1 {item:14341}. Make the 33 {item:14048} first. {item:14341} from tailoring vendors."] = "",

	-- Step 39: Runecloth Gloves to 265
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 265"] = "",
	-- {item:13863} Runecloth Gloves · {item:14048} Bolt of Runecloth · {item:8170} Rugged Leather · {item:14341} Rune Thread · {npc:11189} Qia · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{item:13863} is orange at 234 (yellow 245, green 260, grey 275): about 43 crafts to 265. Each takes 4 {item:14048}, 4 {item:8170} and 1 {item:14341}. Make the 172 {item:14048} first. {npc:11189} in {area:2255} keeps one pattern at a time; the {area:1769} tunnel from {zone:1448} is the road in, so never kill Timbermaw furbolgs on the way."] = "",

	-- Step 40: Runecloth Shoulders to 300
	-- {item:13867} Runecloth Shoulders
	["{item:13867} to 300"] = "",
	-- {item:13867} Runecloth Shoulders · {item:14048} Bolt of Runecloth · {item:14227} Ironweb Spider Silk · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:14504} Pattern: Runecloth Shoulders · {zone:1422} Western Plaguelands · {zone:1451} Silithus · {item:13863} Runecloth Gloves · {item:13864} Runecloth Boots · {npc:7940} Darnall · {zone:1450} Moonglade · {item:14342} Mooncloth · {npc:11189} Qia · {npc:11188} Evie Whirlbrew · {area:2255} Everlook · {item:14256} Felcloth · {item:279943} Spinning Wheel · {npc:248202} Jim'bek · {npc:256735} Mivin Shadowweave · {npc:246017} Unstable Sentinel · {item:254123} Runecloth Cuffs · {zone:2482} Mount Hyjal · {skill:197} Tailoring
	["{item:13867} is orange at 265 (yellow 275, green 290, grey 305): about 62 crafts to 300. Each takes 7 {item:14048}, 2 {item:14227}, 4 {item:8170} and 1 {item:14341}. Make the 434 {item:14048} first. Its pattern ({item:14504}) drops from mobs all over the world and does not bind: buy it at the Auction House. Seven bolts, two {item:14227} and four {item:8170} a craft: the dearest stretch. The spiders of {zone:1422} and {zone:1451} drop the silk (the marked spots), or the Auction House. No pattern on the Auction House? {item:13863} still give a point now and then to 275, and {item:13864} ({npc:7940}, {zone:1450}) to 280, at 4 bolts a craft. {item:14342} (pattern from {npc:11189} or {npc:11188} in {area:2255}; 2 {item:14256} at a Moonwell) stays orange to 270 and yellow to 285, but it can be made once every four days. The {item:279943} patterns (Merchant's Favor sandals and waistcords from {npc:248202} or {npc:256735}; the wheel's blueprint drops from the {npc:246017} in the City of Dalaran) and {item:254123} (Pexmit in {zone:2482}, 10g; we could not confirm that vendor yet) are the other ways on. {skill:197} 300 is a Legacy System milestone."] = "",
	["from the pattern bought at the Auction House"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["144 {item:2589} for {spell:2387} and {item:7026}: humanoids of level 5-20 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "為{spell:2387}和{item:7026}準備144個{item:2589}：5-20級的人型生物會掉落。練等時把撿到的留著，從銀行取出，或在拍賣場購買。",
	-- ["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "為{spell:3871}準備204個{item:4306}：25-45級的人型生物會掉落。練等時把撿到的留著，從銀行取出，或在拍賣場購買。",
	-- ["264 {item:4306} for {item:7053}: humanoids of level 25-45 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "為{item:7053}準備264個{item:4306}：25-45級的人型生物會掉落。練等時把撿到的留著，從銀行取出，或在拍賣場購買。",
	-- ["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "為{item:13856}、{item:13863}和{item:13867}準備3195個{item:14047}：45-60級的人型生物會掉落。練等時把撿到的留著，從銀行取出，或在拍賣場購買。",
	-- ["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "為{item:13863}和{item:13867}準備420張{item:8170}：{skill:393}：剝取48-60級野獸；或從拍賣場購買。在這裡剝取{npc:8598}、瘟疫犬和{npc:8596}（48-60級）的皮；{skill:393}指南有對應路線。",
	-- ["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "為{spell:2402}和{spell:3866}準備567個{item:2592}：15-30級的人型生物會掉落。練等時把撿到的留著，從銀行取出，或在拍賣場購買。",
	-- ["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "為{item:9998}和{item:10024}準備900個{item:4338}：35-50級的人型生物會掉落。練等時把撿到的留著，從銀行取出，或在拍賣場購買。",
	-- ["Apprentice {skill:197}"] = "初級{skill:197}",
	-- ["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "專家級需要角色等級 35 且{skill:197} 200；上限提高到 300。225-300 的材料總值約 845g。",
	-- ["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "回到{skill:197}訓練師處：{skill:197} 185 起可學{spell:12048}。",
	-- ["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "回到{skill:197}訓練師處：{skill:197} 205 起可學{spell:12072}。",
	-- ["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "回到{skill:197}訓練師處：{skill:197} 80 起可學{spell:2402}。",
	-- ["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "回到{skill:197}訓練師處：{skill:197} 110 起可學{spell:3848}。",
	-- ["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "回到{skill:197}訓練師處：{skill:197} 125 起可學{spell:3852}。",
	-- ["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "回到{skill:197}訓練師處：{skill:197} 50 起可學{spell:8776}。",
	-- ["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "回到{skill:197}訓練師處：{skill:197} 180 起可學{spell:8799}。",
	-- ["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "高級需要角色等級 20 且{skill:197} 125；上限提高到 225。150-225 的材料總值約 135g。",
	-- ["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "中級需要角色等級 10 且{skill:197} 50；上限提高到 150。75-150 的材料總值約 17g。",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在 Polestar 依你的等級和陣營挑選的刷怪點擊殺會掉落它的怪物。也可以在拍賣場購買。",
	-- ["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "在 Forever 中，訓練師教授或雙方陣營商人販售的配方在 295 之後都不再提升{skill:197}，因此 Polestar 沒有最後幾點的路線。仍可加點的配方：{item:14342}（需要月井）、{item:14137}（需要{item:279943}）、{item:14155}（配方為掉落物）、{item:14128}（配方為掉落物）、{item:19047}（需要{item:279943}）。",
	-- ["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "橙色（每次製造加 1 點）到 160，黃色到 175，綠色到 190。",
	-- ["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "橙色（每次製造加 1 點）到 245，黃色到 260，綠色到 275。",
	-- ["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "橙色（每次製造加 1 點）到 265，黃色到 280，綠色到 295。",
	-- ["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "橙色（每次製造加 1 點）到 40，黃色到 50，綠色到 60。",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝皮：{npc:1815}、{npc:1816}、{npc:1817}（等級 48-60 的野獸會出產）；{skill:393}指南有規劃此路線。也可以在拍賣場購買。",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝皮：{npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378}、{npc:6377}（等級 48-60 的野獸會出產）；{skill:393}指南有規劃此路線。也可以在拍賣場購買。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "由剝皮、分解或其他專業製造取得：自行收集或在拍賣場購買。",
	-- ["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "教你{item:13863}（需要{skill:197} 230）。商人限量販售並會補貨。",
	-- ["Teaches {item:254123} (needs {skill:197} 250)."] = "教你{item:254123}（需要{skill:197} 250）。",
	-- ["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "教你{item:7053}（需要{skill:197} 140）。商人限量販售並會補貨。",
	-- ["Yellow until 127, green until 145: not every craft gives a point."] = "黃色到 127，綠色到 145：並非每次製造都會加點。",
	-- ["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "黃色到 140，綠色到 155：並非每次製造都會加點。{skill:197} 150 是傳承系統的里程碑。",
	-- ["Yellow until 190, green until 200: not every craft gives a point."] = "黃色到 190，綠色到 200：並非每次製造都會加點。",
	-- ["Yellow until 200, green until 215: not every craft gives a point."] = "黃色到 200，綠色到 215：並非每次製造都會加點。",
	-- ["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "黃色到 220，綠色到 235：並非每次製造都會加點。{skill:197} 225 是傳承系統的里程碑。",
	-- ["Yellow until 240, green until 255: not every craft gives a point."] = "黃色到 240，綠色到 255：並非每次製造都會加點。",
	-- ["Yellow until 67, green until 85: not every craft gives a point."] = "黃色到 67，綠色到 85：並非每次製造都會加點。",
	-- ["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "黃色到 67，綠色到 85：並非每次製造都會加點。75 是初級上限。",
	-- ["Yellow until 97, green until 115: not every craft gives a point."] = "黃色到 97，綠色到 115：並非每次製造都會加點。",
	-- ["{item:10045} to 50"] = "{item:10045}練到 50",
	-- ["{item:13856} to 236"] = "{item:13856}練到 236",
	-- ["{item:13863} to 251"] = "{item:13863}練到 251",
	-- ["{item:14047} (Alliance)"] = "{item:14047}（聯盟）",
	-- ["{item:14047} (Horde)"] = "{item:14047}（部落）",
	-- ["{item:254123} to 295"] = "{item:254123}練到 295",
	-- ["{item:2592} (Alliance)"] = "{item:2592}（聯盟）",
	-- ["{item:2592} (Horde)"] = "{item:2592}（部落）",
	-- ["{item:4338} (Alliance)"] = "{item:4338}（聯盟）",
	-- ["{item:4338} (Horde)"] = "{item:4338}（部落）",
	-- ["{item:7026} to 80"] = "{item:7026}練到 80",
	-- ["{item:7053} to 180"] = "{item:7053}練到 180",
	-- ["{item:7062} to 185"] = "{item:7062}練到 185",
	-- ["{item:9998} to 205"] = "{item:9998}練到 205",
	-- ["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "這裡的{npc:11739}（等級 57-59）會掉落。也可以在拍賣場購買。",
	-- ["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "這裡的{npc:1824}（等級 54-55）會掉落。也可以在拍賣場購買。",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "這裡的{npc:3263}（等級 19-20）會掉落。也可以在拍賣場購買。",
	-- ["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "這裡的{npc:5472}（等級 46-47）會掉落。也可以在拍賣場購買。",
	-- ["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "這裡的{npc:6006}（等級 52-53）會掉落。也可以在拍賣場購買。",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "這裡的{npc:6189}（等級 51-52）會掉落。也可以在拍賣場購買。",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "這裡的{npc:7027}（等級 56-57）會掉落。也可以在拍賣場購買。",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "這裡的{npc:98}（等級 17-18）會掉落。也可以在拍賣場購買。",
	-- ["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}：{item:3383}（或在拍賣場購買）",
	-- ["{skill:197} materials for 75-150"] = "{skill:197} 75-150 材料",
	-- ["{skill:197} recipes at 110"] = "{skill:197} 110 配方",
	-- ["{skill:197} recipes at 125"] = "{skill:197} 125 配方",
	-- ["{skill:197} recipes at 180"] = "{skill:197} 180 配方",
	-- ["{skill:197} recipes at 185"] = "{skill:197} 185 配方",
	-- ["{skill:197} recipes at 205"] = "{skill:197} 205 配方",
	-- ["{skill:197} recipes at 50"] = "{skill:197} 50 配方",
	-- ["{skill:197} recipes at 80"] = "{skill:197} 80 配方",
	-- ["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197}可與升級同步進行。Forever 的傳承系統會在技能 150、225 和 300（中級、高級和專家級的上限）時獎勵製造專業，因此每個檢查點都很重要。1-75 的材料總值約 1g 8s。",
	-- ["{spell:2402} to 110"] = "{spell:2402}練到 110",
	-- ["{spell:3848} to 125"] = "{spell:3848}練到 125",
	-- ["{spell:3852} to 150"] = "{spell:3852}練到 150",
}
