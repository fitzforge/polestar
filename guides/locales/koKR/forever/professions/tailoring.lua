-- Korean (koKR): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
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
	["Buy the whole bracket's share in one go: 72 {item:2320} (7s 20c); about 7s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2320} 72개(7실버 20코퍼), 모두 약 7실버 20코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}, {zone:1454}: {npc:3364}, 펠리카, {npc:5817}).",

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
	["{item:7026} to 75"] = "{item:7026}: 75까지",
	-- {item:7026} Linen Belt · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{item:7026} is orange at 15 (yellow 50, green 67, grey 85): about 65 crafts to 75. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 65 {spell:2963} first: it gives points too while not grey. Each belt takes one bolt; the belts sell to vendors."] = "",

	-- Step 8: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "수습 {skill:197}",
	-- {skill:197} Tailoring · {npc:2627} Grarnik Goodstitch · {zone:1434} Stranglethorn Vale · {npc:5153} Jormund Stonebrow · {zone:1455} Ironforge · {npc:4159} Me'lynn · {zone:1457} Darnassus · {npc:252380} Othesia Evengale · {npc:5567} Sellandus · {zone:1453} Stormwind City · {npc:251991} Taleen Shimmerthread · {npc:3363} Magar · {zone:1454} Orgrimmar · {npc:3704} Mahani · {zone:1413} The Barrens · {npc:11049} Rhiannon Davis · {zone:1458} Undercity · {npc:3004} Tepa · {zone:1456} Thunder Bluff · {spell:2964} Bolt of Woolen Cloth · {spell:2402} Woolen Cape · {spell:1229504} Faction Banner · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread · {item:2592} Wool Cloth · {item:4306} Silk Cloth
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), {npc:5567} ({zone:1453}) and {npc:251991} (Zephras Isle); Horde {npc:2627} ({zone:1434}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and {npc:3004} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "수습 단계는 5실버로 최대 숙련도를 75에서 150으로 올립니다. {skill:197} 50과 캐릭터 레벨 10이 필요하므로, 50이 되면 언제 들러도 배울 수 있습니다. 모든 {skill:197} 상급자가 가르치지는 않습니다: 얼라이언스는 {npc:2627}({zone:1434}), {npc:5153}({zone:1455}), {npc:4159}({zone:1457}), {npc:252380}(제프라스 섬), {npc:5567}({zone:1453}), {npc:251991}(제프라스 섬), 호드는 {npc:2627}({zone:1434}), {npc:3363}({zone:1454}), {npc:3704}({zone:1413}), {npc:252380}(제프라스 섬), {npc:11049}({zone:1458}), {npc:251991}(제프라스 섬), {npc:3004}({zone:1456})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:2964}(55부터, 1실버), {spell:2402}(55부터, 2실버 50코퍼). {spell:1229504}(1실버)도 배우세요. Forever의 {skill:197} 야영 아이템으로, {spell:2963} 1개와 {item:2320} 1개가 들며, 진영마다 따로 있습니다. 시작 지역의 야영 안내인이 ('드넓은 야외' 이후) 주는 '야영 입문: {skill:197}' 퀘스트는 이것을 무료로 가르쳐 주는 재봉술 상급자에게 보내 줍니다. 75-150에는 제조법 약 11실버와 상인 재료 약 1골드 65실버 50코퍼, 그리고 채집하거나 살 {item:2592} 567개, {item:4306} 204개가 듭니다.",

	-- Step 9: Tailoring 75-150: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 75-150: vendor goods"] = "",
	-- {item:2321} Fine Thread · {item:2324} Bleach · {item:2604} Red Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) and 98 {item:2604} (49s); about 1g 65s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2321} 108개(1골드 8실버), {item:2324} 34개(8실버 50코퍼), {item:2604} 98개(49실버), 모두 약 1골드 65실버 50코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}, {zone:1454}: {npc:3364}, 펠리카, {npc:5817}).",

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
	["Buy the whole bracket's share in one go: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) and 80 {item:8343} (16g); about 21g 16s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2321} 44개(44실버), {item:4291} 90개(4골드 50실버), {item:6260} 44개(22실버), {item:8343} 80개(16골드), 모두 약 21골드 16실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}, {zone:1454}: {npc:3364}, 펠리카, {npc:5817}).",

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
	["Expert {skill:197}"] = "숙련 {skill:197}",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {spell:3865} Bolt of Mageweave · {item:4306} Silk Cloth · {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["Expert raises the cap from 150 to 225; it needs {skill:197} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:1346} ({zone:1453}); Horde {npc:4576} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3865} (from 140). 150-225 takes about 15s of recipes and 21g 16s of vendor goods, plus 264 {item:4306} and 900 {item:4338} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9998} (from 170) and {item:10024} (from 190), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "숙련 단계는 최대 숙련도를 150에서 225로 올립니다. {skill:197} 125와 캐릭터 레벨 20이 필요하므로, 125가 되면 언제 들러도 배울 수 있습니다. 가르치는 상급자는 몇 명뿐입니다: 얼라이언스는 {npc:1346}({zone:1453}), 호드는 {npc:4576}({zone:1458})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:3865}(140부터). 150-225에는 제조법 약 15실버와 상인 재료 약 21골드 16실버, 그리고 채집하거나 살 {item:4306} 264개, {item:4338} 900개가 듭니다. 모든 재료를 가방에 챙겨서 오세요(위 단계에서 모으고, 나머지는 경매장에서). 이 상급자들은 {item:9998}(170부터)와(과) {item:10024}(190부터)도 가르치며, 제작에 작업대가 필요 없으므로 바로 여기서 만들고 숙련도에 도달할 때마다 제조법을 배우세요. 세 번 올 것을 한 번에 끝냅니다.",

	-- Step 24: Azure Silk Cloak to 170
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 170"] = "",
	-- {item:7053} Azure Silk Cloak · {spell:3839} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7053} is orange at 150 (yellow 160, green 175, grey 190): about 22 crafts to 170. Each takes 3 {spell:3839}, 2 {item:6260} and 2 {item:2321}. Make the 66 {spell:3839} first. Its recipe is the one bought above; it is the cheapest way through these points in the data."] = "",
	["from the recipe in your bags"] = "가방에 있는 제조법으로",

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
	["{item:10024} to 225"] = "{item:10024}: 225까지",
	-- {item:10024} Black Mageweave Headband · {spell:3865} Bolt of Mageweave · {item:8343} Heavy Silken Thread · {skill:197} Tailoring
	["{item:10024} is orange at 197 (yellow 205, green 220, grey 235): about 40 crafts to 225. Each takes 3 {spell:3865} and 2 {item:8343}. Make the 120 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:197} 225 is a Legacy System milestone."] = "",

	-- Step 29: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "전문 {skill:197}",
	-- {skill:197} Tailoring · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {spell:18401} Bolt of Runecloth · {spell:18402} Runecloth Belt · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14227} Ironweb Spider Silk
	["Artisan raises the cap from 225 to 300; it needs {skill:197} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). The arrow picks the nearest of your faction. Learn now: {spell:18401} (from 205) and {spell:18402} (from 210). 225-300 takes about 1g 60s of recipes and 58g of vendor goods, plus 420 {item:8170}, 3195 {item:14047} and 124 {item:14227} to gather or buy."] = "",

	-- Step 30: Tailoring 225-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 225-300: vendor goods"] = "",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 116 {item:14341} (58g); about 58g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:14341} 116개(58골드), 모두 약 58골드. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}, {zone:1454}: {npc:3364}, 펠리카, {npc:5817}).",

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
	["{item:8170} (Alliance)"] = "{item:8170} (얼라이언스)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:8598} Frenzied Plaguehound · {npc:8596} Plaguehound Runt
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 34: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (호드)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 35: Runecloth
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 36: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (얼라이언스)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:1824} Plague Lurker
	["124 {item:14227} for {item:13867}: it drops from {npc:1824} (level 54-55) at the marked spot."] = "",

	-- Step 37: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (호드)",
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
	-- ["144 {item:2589} for {spell:2387} and {item:7026}: humanoids of level 5-20 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "{spell:2387}와(과) {item:7026}에 쓸 {item:2589} 144개: 5-20레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나, 은행에서 꺼내거나, 경매장에서 사세요.",
	-- ["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "{spell:3871}에 쓸 {item:4306} 204개: 25-45레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나, 은행에서 꺼내거나, 경매장에서 사세요.",
	-- ["264 {item:4306} for {item:7053}: humanoids of level 25-45 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "{item:7053}에 쓸 {item:4306} 264개: 25-45레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나, 은행에서 꺼내거나, 경매장에서 사세요.",
	-- ["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "{item:13856}, {item:13863}, {item:13867}에 쓸 {item:14047} 3195개: 45-60레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나, 은행에서 꺼내거나, 경매장에서 사세요.",
	-- ["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "{item:13863}와(과) {item:13867}에 쓸 {item:8170} 420개: {skill:393}: 48-60레벨 야수, 또는 경매장. 여기서 {npc:8598}, 역병사냥개, {npc:8596}의 가죽을 벗기세요(48-60레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "{spell:2402}와(과) {spell:3866}에 쓸 {item:2592} 567개: 15-30레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나, 은행에서 꺼내거나, 경매장에서 사세요.",
	-- ["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "{item:9998}와(과) {item:10024}에 쓸 {item:4338} 900개: 35-50레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나, 은행에서 꺼내거나, 경매장에서 사세요.",
	-- ["Apprentice {skill:197}"] = "초급 {skill:197}",
	-- ["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "전문은(는) 캐릭터 레벨 35, {skill:197} 200이(가) 필요하며 최대 숙련도를 300(으)로 올립니다. 225-300 재료는 모두 약 845골드입니다.",
	-- ["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "{skill:197} 상급자에게 돌아가세요. {spell:12048}은(는) {skill:197} 185부터 배울 수 있습니다.",
	-- ["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "{skill:197} 상급자에게 돌아가세요. {spell:12072}은(는) {skill:197} 205부터 배울 수 있습니다.",
	-- ["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "{skill:197} 상급자에게 돌아가세요. {spell:2402}은(는) {skill:197} 80부터 배울 수 있습니다.",
	-- ["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "{skill:197} 상급자에게 돌아가세요. {spell:3848}은(는) {skill:197} 110부터 배울 수 있습니다.",
	-- ["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "{skill:197} 상급자에게 돌아가세요. {spell:3852}은(는) {skill:197} 125부터 배울 수 있습니다.",
	-- ["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "{skill:197} 상급자에게 돌아가세요. {spell:8776}은(는) {skill:197} 50부터 배울 수 있습니다.",
	-- ["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "{skill:197} 상급자에게 돌아가세요. {spell:8799}은(는) {skill:197} 180부터 배울 수 있습니다.",
	-- ["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "숙련은(는) 캐릭터 레벨 20, {skill:197} 125이(가) 필요하며 최대 숙련도를 225(으)로 올립니다. 150-225 재료는 모두 약 135골드입니다.",
	-- ["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "수습은(는) 캐릭터 레벨 10, {skill:197} 50이(가) 필요하며 최대 숙련도를 150(으)로 올립니다. 75-150 재료는 모두 약 17골드입니다.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Polestar가 레벨과 진영에 맞춰 고른 사냥터에서 이것을 떨어뜨리는 몹을 처치하세요. 경매장도 됩니다.",
	-- ["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "Forever에서는 상급자가 가르치거나 양 진영 상인이 파는 제조법 중 295 이후 {skill:197} 점수를 주는 것이 없어, Polestar에는 마지막 점수를 위한 경로가 없습니다. 아직 점수를 주는 제조법: {item:14342}(달샘 필요), {item:14137}({item:279943} 필요), {item:14155}(제조법은 획득), {item:14128}(제조법은 획득), {item:19047}({item:279943} 필요).",
	-- ["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "160까지 주황색(만들 때마다 1점), 175까지 노란색, 190까지 초록색입니다.",
	-- ["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "245까지 주황색(만들 때마다 1점), 260까지 노란색, 275까지 초록색입니다.",
	-- ["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "265까지 주황색(만들 때마다 1점), 280까지 노란색, 295까지 초록색입니다.",
	-- ["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "40까지 주황색(만들 때마다 1점), 50까지 노란색, 60까지 초록색입니다.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:1815}, {npc:1816}, {npc:1817}의 가죽을 벗기세요(48-60레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377}의 가죽을 벗기세요(48-60레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "무두질, 마력 추출 또는 다른 전문 기술로 얻는 재료입니다. 직접 모으거나 경매장에서 사세요.",
	-- ["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "{item:13863}을(를) 배웁니다({skill:197} 230 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",
	-- ["Teaches {item:254123} (needs {skill:197} 250)."] = "{item:254123}을(를) 배웁니다({skill:197} 250 필요).",
	-- ["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "{item:7053}을(를) 배웁니다({skill:197} 140 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",
	-- ["Yellow until 127, green until 145: not every craft gives a point."] = "127까지 노란색, 145까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "140까지 노란색, 155까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. {skill:197} 150은(는) 유산 시스템 단계입니다.",
	-- ["Yellow until 190, green until 200: not every craft gives a point."] = "190까지 노란색, 200까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 200, green until 215: not every craft gives a point."] = "200까지 노란색, 215까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "220까지 노란색, 235까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. {skill:197} 225은(는) 유산 시스템 단계입니다.",
	-- ["Yellow until 240, green until 255: not every craft gives a point."] = "240까지 노란색, 255까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 67, green until 85: not every craft gives a point."] = "67까지 노란색, 85까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "67까지 노란색, 85까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 75은(는) 초급 최대치입니다.",
	-- ["Yellow until 97, green until 115: not every craft gives a point."] = "97까지 노란색, 115까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["{item:10045} to 50"] = "{item:10045}: 50까지",
	-- ["{item:13856} to 236"] = "{item:13856}: 236까지",
	-- ["{item:13863} to 251"] = "{item:13863}: 251까지",
	-- ["{item:14047} (Alliance)"] = "{item:14047} (얼라이언스)",
	-- ["{item:14047} (Horde)"] = "{item:14047} (호드)",
	-- ["{item:254123} to 295"] = "{item:254123}: 295까지",
	-- ["{item:2592} (Alliance)"] = "{item:2592} (얼라이언스)",
	-- ["{item:2592} (Horde)"] = "{item:2592} (호드)",
	-- ["{item:4338} (Alliance)"] = "{item:4338} (얼라이언스)",
	-- ["{item:4338} (Horde)"] = "{item:4338} (호드)",
	-- ["{item:7026} to 80"] = "{item:7026}: 80까지",
	-- ["{item:7053} to 180"] = "{item:7053}: 180까지",
	-- ["{item:7062} to 185"] = "{item:7062}: 185까지",
	-- ["{item:9998} to 205"] = "{item:9998}: 205까지",
	-- ["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "이곳의 {npc:11739}(57-59레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "이곳의 {npc:1824}(54-55레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "이곳의 {npc:3263}(19-20레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "이곳의 {npc:5472}(46-47레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "이곳의 {npc:6006}(52-53레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "이곳의 {npc:6189}(51-52레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "이곳의 {npc:7027}(56-57레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "이곳의 {npc:98}(17-18레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}: {item:3383} (또는 경매장)",
	-- ["{skill:197} materials for 75-150"] = "{skill:197} 재료(75-150)",
	-- ["{skill:197} recipes at 110"] = "110에서 {skill:197} 제조법",
	-- ["{skill:197} recipes at 125"] = "125에서 {skill:197} 제조법",
	-- ["{skill:197} recipes at 180"] = "180에서 {skill:197} 제조법",
	-- ["{skill:197} recipes at 185"] = "185에서 {skill:197} 제조법",
	-- ["{skill:197} recipes at 205"] = "205에서 {skill:197} 제조법",
	-- ["{skill:197} recipes at 50"] = "50에서 {skill:197} 제조법",
	-- ["{skill:197} recipes at 80"] = "80에서 {skill:197} 제조법",
	-- ["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197}은(는) 레벨업과 함께 진행합니다. Forever의 유산 시스템은 제작 전문 기술 숙련도 150, 225, 300(수습, 숙련, 전문 최대치)에 보상을 주므로, 각 단계가 중요합니다. 1-75 재료는 모두 약 1골드 8실버입니다.",
	-- ["{spell:2402} to 110"] = "{spell:2402}: 110까지",
	-- ["{spell:3848} to 125"] = "{spell:3848}: 125까지",
	-- ["{spell:3852} to 150"] = "{spell:3852}: 150까지",
}
