-- Chinese (traditional) (zhTW): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Alchemy
	-- {skill:171} Alchemy
	["Learn {skill:171}"] = "學習{skill:171}",
	-- {skill:171} Alchemy · {skill:182} Herbalism · {item:2447} Peacebloom · {item:765} Silverleaf
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Apprentice {skill:171} lets you craft up to 75 for 10c, at any character level. Any {skill:171} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:182}: {item:2447} and {item:765} grow in every starting zone, and Empty Vials cost 4c at any alchemy or trade supplies vendor. 1-75 takes about 3s 28c of vendor goods, plus 82 {item:765} and 110 {item:2447} to gather or buy."] = "初級{skill:171}讓你在任何角色等級下花10銅把技能練到75。本陣營任意{skill:171}訓練師都教；箭頭會指向最近的一位。配合{skill:182}：{item:2447}和{item:765}在每個新手地區都有生長，空瓶在任何鍊金或雜貨供應商處賣4銅。1-75大約花3銀28銅的商人貨物，外加82個{item:765}和110個{item:2447}，需自行採集或購買。",

	-- Step 2: Alchemy 1-75: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 1-75: vendor goods"] = "{skill:171} 1-75：商人貨物",
	-- {item:3371} Empty Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 82 {item:3371} (3s 28c); about 3s 28c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "一次買齊本階段的用量：82個 {item:3371}（3銀28銅）；總計約3銀28銅。箭頭會指向本陣營最近的商人（{zone:1453}：{npc:1286}、{npc:5503} 和 {npc:1325}；{zone:1454}：{npc:3367}、{npc:3348} 和 {npc:3334}）。",

	-- Step 3: Get Silverleaf (Elwynn Forest)
	-- {item:765} Silverleaf · {zone:1429} Elwynn Forest
	["Get {item:765} ({zone:1429})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1429} is marked. Or buy them at the Auction House."] = "",

	-- Step 4: Get Silverleaf (Dun Morogh)
	-- {item:765} Silverleaf · {zone:1426} Dun Morogh
	["Get {item:765} ({zone:1426})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1426} is marked. Or buy them at the Auction House."] = "",

	-- Step 5: Get Silverleaf (Teldrassil)
	-- {item:765} Silverleaf · {zone:1438} Teldrassil
	["Get {item:765} ({zone:1438})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1438} Teldrassil
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1438} is marked. Or buy them at the Auction House."] = "",

	-- Step 6: Get Silverleaf (Zephras Isle)
	-- {item:765} Silverleaf · {zone:2521} Zephras Isle
	["Get {item:765} ({zone:2521})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:2521} is marked. Or buy them at the Auction House."] = "",

	-- Step 7: Get Silverleaf (Durotar)
	-- {item:765} Silverleaf · {zone:1411} Durotar
	["Get {item:765} ({zone:1411})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1411} Durotar
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1411} is marked. Or buy them at the Auction House."] = "",

	-- Step 8: Get Silverleaf (Mulgore)
	-- {item:765} Silverleaf · {zone:1412} Mulgore
	["Get {item:765} ({zone:1412})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1412} Mulgore
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1412} is marked. Or buy them at the Auction House."] = "",

	-- Step 9: Get Silverleaf (Tirisfal Glades)
	-- {item:765} Silverleaf · {zone:1420} Tirisfal Glades
	["Get {item:765} ({zone:1420})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1420} is marked. Or buy them at the Auction House."] = "",

	-- Step 10: Get Peacebloom (Elwynn Forest)
	-- {item:2447} Peacebloom · {zone:1429} Elwynn Forest
	["Get {item:2447} ({zone:1429})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1429} is marked. Or buy them at the Auction House."] = "",

	-- Step 11: Get Peacebloom (Dun Morogh)
	-- {item:2447} Peacebloom · {zone:1426} Dun Morogh
	["Get {item:2447} ({zone:1426})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1426} is marked. Or buy them at the Auction House."] = "",

	-- Step 12: Get Peacebloom (Teldrassil)
	-- {item:2447} Peacebloom · {zone:1438} Teldrassil
	["Get {item:2447} ({zone:1438})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1438} Teldrassil
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1438} is marked. Or buy them at the Auction House."] = "",

	-- Step 13: Get Peacebloom (Zephras Isle)
	-- {item:2447} Peacebloom · {zone:2521} Zephras Isle
	["Get {item:2447} ({zone:2521})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:2521} is marked. Or buy them at the Auction House."] = "",

	-- Step 14: Get Peacebloom (Durotar)
	-- {item:2447} Peacebloom · {zone:1411} Durotar
	["Get {item:2447} ({zone:1411})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1411} Durotar
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1411} is marked. Or buy them at the Auction House."] = "",

	-- Step 15: Get Peacebloom (Mulgore)
	-- {item:2447} Peacebloom · {zone:1412} Mulgore
	["Get {item:2447} ({zone:1412})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1412} Mulgore
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1412} is marked. Or buy them at the Auction House."] = "",

	-- Step 16: Get Peacebloom (Tirisfal Glades)
	-- {item:2447} Peacebloom · {zone:1420} Tirisfal Glades
	["Get {item:2447} ({zone:1420})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1420} is marked. Or buy them at the Auction House."] = "",

	-- Step 17: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997}練到75",
	-- {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom · {item:3371} Empty Vial
	["{item:5997} is orange at 1 (yellow 55, green 75, grey 95): about 82 crafts to 75. Each takes 1 {item:765}, 1 {item:2447} and 1 {item:3371}. Known from the start and the cheapest way through the Apprentice range. Keep the elixirs (armour while you level) or sell them."] = "{item:5997}在1時為橙色（55黃、75綠、95灰）：大約82次製作可到75。每次需要1個{item:765}、1個{item:2447}和1個{item:3371}。一開始就會，是衝過初級段最便宜的辦法。留著這些藥劑（練級時加護甲），或者賣掉。",

	-- Step 18: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "中級{skill:171}",
	-- {skill:171} Alchemy · {npc:4900} Alchemist Narett · {zone:1445} Dustwallow Marsh · {npc:2837} Jaxin Chong · {zone:1434} Stranglethorn Vale · {npc:3964} Kylanna · {zone:1440} Ashenvale · {npc:5499} Lilyssia Nightbreeze · {zone:1453} Stormwind City · {npc:11042} Sylvanna Forestmoon · {zone:1457} Darnassus · {npc:5177} Tally Berryfizz · {zone:1455} Ironforge · {npc:3009} Bena Winterhoof · {zone:1456} Thunder Bluff · {npc:4609} Doctor Marsh · {zone:1458} Undercity · {npc:2391} Serge Hinott · {zone:1424} Hillsbrad Foothills · {npc:3347} Yelmak · {zone:1454} Orgrimmar · {spell:2331} Minor Mana Potion · {spell:1230564} Mana Well · {item:2447} Peacebloom · {item:3371} Empty Vial · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed
	["Journeyman raises the cap from 75 to 150 for 4s 50c (Classic's price; Forever's is not in the data); it needs {skill:171} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:171} trainer teaches it: Alliance {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) and {npc:5177} ({zone:1455}); Horde {npc:3009} ({zone:1456}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:2391} ({zone:1424}) and {npc:3347} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:2331} (from 25, 1s). Also learn {spell:1230564} (1s): Forever's {skill:171} camp item, 1 {item:2447} and 1 {item:3371}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:171} quest from your starting area's camping guide (after The Great Outdoors) sends you to an alchemy trainer who teaches it free. 75-150 takes about 1s of recipes and 9s 8c of vendor goods, plus 77 {item:785}, 152 {item:2450} and 54 {item:2453} to gather or buy."] = "中級訓練將技能上限從75提高到150，費用4銀50銅（經典版的價格；資料中沒有Forever的價格）；需要{skill:171} 50和角色等級10，所以技能達到50後，任何一次經過都可以學。並非每位{skill:171}訓練師都會教：聯盟有{npc:4900}（{zone:1445}）、{npc:2837}（{zone:1434}）、{npc:3964}（{zone:1440}）、{npc:5499}（{zone:1453}）、{npc:11042}（{zone:1457}）和{npc:5177}（{zone:1455}）；部落有{npc:3009}（{zone:1456}）、{npc:4609}（{zone:1458}）、{npc:2837}（{zone:1434}）、{npc:2391}（{zone:1424}）和{npc:3347}（{zone:1454}）。箭頭會選擇你陣營最近的一位。現在學習：{spell:2331}（技能25起，1銀）。也學習{spell:1230564}（1銀）：這是Forever的{skill:171}紮營物品，需要1個{item:2447}和1個{item:3371}，放在營地的營火旁可獲得增益效果。起始地區的紮營嚮導（完成「戶外真好」後）提供的「紮營入門指南：{skill:171}」任務，會讓你去找免費教授它的煉金術訓練師。75-150約需1銀的配方和9銀8銅的商人材料，另需採集或購買77個{item:785}、152個{item:2450}和54個{item:2453}。",

	-- Step 19: Alchemy 75-150: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 75-150: vendor goods"] = "{skill:171} 75-150：商人貨物",
	-- {item:3371} Empty Vial · {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 77 {item:3371} (3s 8c) and 15 {item:3372} (6s); about 9s 8c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "一次買齊整個技能階段所需的份量：77 個 {item:3371}（3 銀 8 銅）和 15 個 {item:3372}（6 銀）；合計約 9 銀 8 銅。箭頭會選擇離你最近的本陣營商人（{zone:1453}：{npc:1286}、{npc:5503} 和 {npc:1325}；{zone:1454}：{npc:3367}、{npc:3348} 和 {npc:3334}）。",

	-- Step 20: Get Mageroyal (Westfall)
	-- {item:785} Mageroyal · {zone:1436} Westfall
	["Get {item:785} ({zone:1436})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1436} Westfall
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1436} is marked. Or buy them at the Auction House."] = "",

	-- Step 21: Get Mageroyal (Loch Modan)
	-- {item:785} Mageroyal · {zone:1432} Loch Modan
	["Get {item:785} ({zone:1432})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1432} Loch Modan
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1432} is marked. Or buy them at the Auction House."] = "",

	-- Step 22: Get Mageroyal (Teldrassil)
	-- {item:785} Mageroyal · {zone:1438} Teldrassil
	["Get {item:785} ({zone:1438})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1438} Teldrassil
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1438} is marked. Or buy them at the Auction House."] = "",

	-- Step 23: Get Mageroyal (Zephras Isle)
	-- {item:785} Mageroyal · {zone:2521} Zephras Isle
	["Get {item:785} ({zone:2521})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:2521} is marked. Or buy them at the Auction House."] = "",

	-- Step 24: Get Mageroyal (The Barrens)
	-- {item:785} Mageroyal · {zone:1413} The Barrens
	["Get {item:785} ({zone:1413})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1413} The Barrens
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 25: Get Mageroyal (Silverpine Forest)
	-- {item:785} Mageroyal · {zone:1421} Silverpine Forest
	["Get {item:785} ({zone:1421})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1421} is marked. Or buy them at the Auction House."] = "",

	-- Step 26: Get Briarthorn (Westfall)
	-- {item:2450} Briarthorn · {zone:1436} Westfall
	["Get {item:2450} ({zone:1436})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1436} is marked. Or buy them at the Auction House."] = "",

	-- Step 27: Get Briarthorn (Loch Modan)
	-- {item:2450} Briarthorn · {zone:1432} Loch Modan
	["Get {item:2450} ({zone:1432})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1432} is marked. Or buy them at the Auction House."] = "",

	-- Step 28: Get Briarthorn (Darkshore)
	-- {item:2450} Briarthorn · {zone:1439} Darkshore
	["Get {item:2450} ({zone:1439})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1439} is marked. Or buy them at the Auction House."] = "",

	-- Step 29: Get Briarthorn (The Barrens)
	-- {item:2450} Briarthorn · {zone:1413} The Barrens
	["Get {item:2450} ({zone:1413})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 30: Get Briarthorn (Silverpine Forest)
	-- {item:2450} Briarthorn · {zone:1421} Silverpine Forest
	["Get {item:2450} ({zone:1421})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1421} is marked. Or buy them at the Auction House."] = "",

	-- Step 31: Get Bruiseweed (Westfall)
	-- {item:2453} Bruiseweed · {zone:1436} Westfall
	["Get {item:2453} ({zone:1436})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1436} is marked. Or buy them at the Auction House."] = "",

	-- Step 32: Get Bruiseweed (Loch Modan)
	-- {item:2453} Bruiseweed · {zone:1432} Loch Modan
	["Get {item:2453} ({zone:1432})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1432} is marked. Or buy them at the Auction House."] = "",

	-- Step 33: Get Bruiseweed (Darkshore)
	-- {item:2453} Bruiseweed · {zone:1439} Darkshore
	["Get {item:2453} ({zone:1439})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1439} is marked. Or buy them at the Auction House."] = "",

	-- Step 34: Get Bruiseweed (The Barrens)
	-- {item:2453} Bruiseweed · {zone:1413} The Barrens
	["Get {item:2453} ({zone:1413})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 35: Get Bruiseweed (Silverpine Forest)
	-- {item:2453} Bruiseweed · {zone:1421} Silverpine Forest
	["Get {item:2453} ({zone:1421})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1421} is marked. Or buy them at the Auction House."] = "",

	-- Step 36: Minor Mana Potion to 90
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 90"] = "{spell:2331}練到90",
	-- {spell:2331} Minor Mana Potion · {item:785} Mageroyal · {item:2447} Peacebloom · {item:3371} Empty Vial · {spell:3171} Elixir of Wisdom
	["{spell:2331} is yellow at 75 (yellow 65, green 85, grey 105): about 28 crafts to 90. Each takes 1 {item:785}, 1 {item:2447} and 1 {item:3371}. The trainer teaches it from 25. It is yellow already, so count on about two crafts a point until {spell:3171} takes over at 90. {item:785} grows in the 10-25 zones."] = "{spell:2331}在75時為黃色（65黃、85綠、105灰）：大約28次製作可到90。每次需要1個{item:785}、1個{item:2447}和1個{item:3371}。訓練師從25起教它。它已經是黃色，所以每漲一點約需兩次製作，直到90時由{spell:3171}接手。{item:785}生長在10-25地區。",

	-- Step 37: Alchemy recipes at 90
	-- {skill:171} Alchemy
	["{skill:171} recipes at 90"] = "{skill:171}90的配方",
	-- {skill:171} Alchemy · {spell:3171} Elixir of Wisdom
	["Back to an {skill:171} trainer: {spell:3171} (from 90)."] = "回到{skill:171}訓練師：{spell:3171}（90起）。",

	-- Step 38: Elixir of Wisdom to 135
	-- {spell:3171} Elixir of Wisdom
	["{spell:3171} to 135"] = "{spell:3171} 到135",
	-- {spell:3171} Elixir of Wisdom · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3371} Empty Vial
	["{spell:3171} is orange at 90 (yellow 120, green 140, grey 160): about 49 crafts to 135. Each takes 1 {item:785}, 2 {item:2450} and 1 {item:3371}. Two {item:2450} and a {item:785} a craft, both from the 10-25 zones; orange to 120."] = "{spell:3171}在90時為橙色（120黃、140綠、160灰）：大約49次製作可到135。每次需要1個{item:785}、2個{item:2450}和1個{item:3371}。每次兩個{item:2450}和一個{item:785}，兩者都來自10-25地區；到120前都是橙色。",

	-- Step 39: Alchemy recipes at 135
	-- {skill:171} Alchemy
	["{skill:171} recipes at 135"] = "{skill:171}135的配方",
	-- {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir
	["Back to an {skill:171} trainer: {spell:3176} (from 125)."] = "回到{skill:171}訓練師處：{spell:3176}（125起）。",

	-- Step 40: Lesser Troll's Blood Elixir to 150
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 150"] = "{spell:3176} 到150",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial · {skill:171} Alchemy
	["{spell:3176} is orange at 135 (yellow 150, green 170, grey 190): about 15 crafts to 150, a point every craft. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. {skill:171} 150 is a Legacy System milestone."] = "{spell:3176}在135時為橙色（150黃、170綠、190灰）：大約15次製作可到150，每次一點。每次需要2個{item:2453}、2個{item:2450}和1個{item:3372}。每次兩個{item:2453}和兩個{item:2450}；{item:2453}生長在15-30地區。{skill:171} 150是傳承系統里程碑。",

	-- Step 41: Alchemy 150-225: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 150-225: vendor goods"] = "{skill:171} 150-225：商人貨物",
	-- {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 83 {item:3372} (33s 20c); about 33s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "一次買齊本階段所需：83個{item:3372}（33銀20銅）；總計約33銀20銅。箭頭指向本陣營最近的出售者（{zone:1453}：{npc:1286}、{npc:5503}和{npc:1325}；{zone:1454}：{npc:3367}、{npc:3348}和{npc:3334}）。",

	-- Step 42: Get Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	-- was: ["{item:3355} (Alliance)"] = "{item:3355}（聯盟）"
	["Get {object:1623} (Alliance)"] = "",
	-- {object:1623} Wild Steelbloom · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	-- was: ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked."] = "為 {item:8951} 準備 40 個 {object:1623}（其中 8 個用於 225-300 階段：現在一併採齊）：透過 {skill:182} 在 {zone:1442}（15-27 級）、{zone:1417}（30-40 級）和 {zone:1434}（30-45 級）採集 {object:1623}（技能 115）。已標記 {zone:1434} 中 {object:1623} 最密集的區域。"
	["You need 40 {object:1623} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 43: Get Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	-- was: ["{item:3355} (Horde)"] = "{item:3355}（部落）"
	["Get {object:1623} (Horde)"] = "",
	-- {object:1623} Wild Steelbloom · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	-- was: ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked."] = "為 {item:8951} 準備 40 個 {object:1623}（其中 8 個用於 225-300 階段：現在一併採齊）：透過 {skill:182} 在 {zone:1442}（15-27 級）、{zone:1417}（30-40 級）和 {zone:1434}（30-45 級）採集 {object:1623}（技能 115）。已標記 {zone:1442} 中 {object:1623} 最密集的區域。"
	["You need 40 {object:1623} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked. Or buy them at the Auction House."] = "",

	-- Step 44: Get Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["Get {item:3356} (Alliance)"] = "",
	-- {item:3356} Kingsblood · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1440} Ashenvale · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale
	-- was: ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked."] = "為 {spell:3452} 準備 39 個 {item:3356}：透過 {skill:182} 採集 {zone:1440}（18-30 級）、{zone:1437}（20-30 級）和 {zone:1434}（30-45 級）的 {item:3356}（需要技能 125）。已標記 {zone:1434} 中 {item:3356} 最密集的區域。"
	["You need 39 {item:3356} for {skill:171} 150-225: {spell:3452}. {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 45: Get Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["Get {item:3356} (Horde)"] = "",
	-- {item:3356} Kingsblood · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1434} Stranglethorn Vale
	-- was: ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked."] = "準備 39 個 {item:3356}，用於 {spell:3452}：透過 {skill:182} 採集 {item:3356}（技能 125），產地有 {zone:1413}（10-25 級）、{zone:1440}（18-30 級）和 {zone:1434}（30-45 級）。已標記 {zone:1413} 中 {item:3356} 最密集的區域。"
	["You need 39 {item:3356} for {skill:171} 150-225: {spell:3452}. {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 46: Get Stranglekelp (Alliance)
	-- {object:2045} Stranglekelp
	["Get {object:2045} (Alliance)"] = "",
	-- {object:2045} Stranglekelp · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	-- was: ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked."] = "準備 39 個 {object:2045}，用於 {spell:3452}：透過 {skill:182} 採集 {object:2045}（技能 85），產地有 {zone:1437}（20-30 級）、{zone:1434}（30-45 級）和 {zone:1425}（40-50 級）。已標記 {zone:1434} 中 {object:2045} 最密集的區域。"
	["You need 39 {object:2045} for {skill:171} 150-225: {spell:3452}. {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 47: Get Stranglekelp (Horde)
	-- {object:2045} Stranglekelp
	["Get {object:2045} (Horde)"] = "",
	-- {object:2045} Stranglekelp · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	-- was: ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked."] = "為 {spell:3452} 準備39株 {object:2045}：{skill:182}：在 {zone:1413}（10-25級）、{zone:1434}（30-45級）和 {zone:1425}（40-50級）採集 {object:2045}（技能85）。已標出 {zone:1413} 中 {object:2045} 最密集的區域。"
	["You need 39 {object:2045} for {skill:171} 150-225: {spell:3452}. {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 48: Get Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["Get {object:2046} (Alliance)"] = "",
	-- {object:2046} Goldthorn · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked."] = "為 {item:8951} 準備 40 個 {object:2046}（其中 8 個用於 225-300 階段：現在一併採齊）：透過 {skill:182} 在 {zone:1417}（30-40 級）、{zone:1425}（40-50 級）和 {zone:1444}（40-50 級）採集 {object:2046}（技能 170）。已標記 {zone:1417} 中 {object:2046} 最密集的區域。"
	["You need 40 {object:2046} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked. Or buy them at the Auction House."] = "",

	-- Step 49: Get Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["Get {object:2046} (Horde)"] = "",
	-- {object:2046} Goldthorn · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked."] = "為 {item:8951} 準備 40 個 {object:2046}（其中 8 個用於 225-300 階段：現在一併採齊）：透過 {skill:182} 在 {zone:1417}（30-40 級）、{zone:1425}（40-50 級）和 {zone:1444}（40-50 級）採集 {object:2046}（技能 170）。已標記 {zone:1444} 中 {object:2046} 最密集的區域。"
	["You need 40 {object:2046} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked. Or buy them at the Auction House."] = "",

	-- Step 50: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "高級{skill:171}",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {object:2045} Stranglekelp · {object:2046} Goldthorn · {spell:3452} Mana Potion · {item:8951} Elixir of Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4160} ({zone:1457}); Horde {npc:4611} ({zone:1458}). The arrow picks the nearest of your faction. 150-225 takes about 33s 20c of vendor goods, plus 40 {object:1623}, 39 {item:3356}, 39 {object:2045} and 40 {object:2046} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:3452} (from 160) and {item:8951} (from 195), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "高級將技能上限從150提高到225，費用50銀（經典版的價格；資料中沒有Forever的價格）；需要{skill:171} 125和角色等級20，所以技能達到125後，任何一次經過都可以學。只有少數訓練師會教：聯盟為{npc:4160}（{zone:1457}）；部落為{npc:4611}（{zone:1458}）。箭頭會選擇你陣營最近的一位。150-225約需33銀20銅的商人材料，另需採集或購買40個{object:1623}、39個{item:3356}、39個{object:2045}和40個{object:2046}。把這些全部帶在背包裡再來（按上面的步驟收集，其餘從拍賣場購買）：這些訓練師也教{spell:3452}（技能160起）和{item:8951}（技能195起），而且製作不需要工作台，可以就在這裡製作，技能一到就學新配方。只要跑一趟，不用跑3趟。",

	-- Step 51: Lesser Troll's Blood Elixir to 160
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 160"] = "{spell:3176} 到160",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial
	["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. If you got here without learning {spell:3176}, learn it now: an earlier step teaches it."] = "{spell:3176}在150時為黃色（黃色150，綠色170，灰色190）：大約製作12次到160。每次需要2個{item:2453}、2個{item:2450}和1個{item:3372}。每次兩個{item:2453}和兩個{item:2450}；{item:2453}生長在15-30級地區。如果你到這裡還沒學會{spell:3176}，現在就學：之前的步驟會教。",

	-- Step 52: Alchemy recipes at 160
	-- {skill:171} Alchemy
	["{skill:171} recipes at 160"] = "{skill:171}160的配方",
	-- {spell:3452} Mana Potion
	["Still at the Expert trainer: {spell:3452} (from 160)."] = "仍在高階訓練師處：{spell:3452}（160起）。",

	-- Step 53: Mana Potion to 195
	-- {spell:3452} Mana Potion
	["{spell:3452} to 195"] = "{spell:3452} 到195",
	-- {spell:3452} Mana Potion · {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3372} Leaded Vial
	["{spell:3452} is orange at 160 (yellow 180, green 200, grey 220): about 39 crafts to 195. Each takes 1 {item:3820}, 1 {item:3356} and 1 {item:3372}. {item:3820} grows under water along the coasts: bring a water breathing elixir or come up for air. {item:3356} grows in the 20-40 zones."] = "{spell:3452}在160時為橙色（180黃、200綠、220灰）：大約39次製作可到195。每次需要1個{item:3820}、1個{item:3356}和1個{item:3372}。{item:3820}生長在沿海水下：帶上水下呼吸藥劑，或者浮上來換氣。{item:3356}生長在20-40地區。",

	-- Step 54: Alchemy recipes at 195
	-- {skill:171} Alchemy
	["{skill:171} recipes at 195"] = "{skill:171}195的配方",
	-- {spell:11450} Elixir of Defense
	["Still at the Expert trainer: {spell:11450} (from 195)."] = "仍在高階訓練師處：{spell:11450}（195起）。",

	-- Step 55: Elixir of Defense to 225
	-- {item:8951} Elixir of Defense
	["{item:8951} to 225"] = "{item:8951}練到225",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands · {skill:171} Alchemy
	["{item:8951} is orange at 195 (yellow 215, green 235, grey 255): about 32 crafts to 225. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). {skill:171} 225 is a Legacy System milestone."] = "{item:8951}在195時為橙色（215黃、235綠、255灰）：大約32次製作可到225。每次需要1個{item:3355}、1個{item:3821}和1個{item:3372}。{item:3355}和{item:3821}是30-45地區的草藥（荊棘谷、阿拉希、{zone:1418}）。{skill:171} 225是傳承系統里程碑。",

	-- Step 56: Alchemy 225-300: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 225-300: vendor goods"] = "{skill:171} 225-300：商人貨物",
	-- {item:3372} Leaded Vial · {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 51 {item:3372} (20s 40c) and 86 {item:8925} (4g 30s); about 4g 50s 40c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "一次買齊整個階段的用量：51個{item:3372}（20銀40銅）和86個{item:8925}（4金30銀）；合計約4金50銀40銅。箭頭會選擇本陣營最近的商人（{zone:1453}：{npc:1286}、{npc:5503}和{npc:1325}；{zone:1454}：{npc:3367}、{npc:3348}和{npc:3334}）。",

	-- Step 57: Recipe: Elixir of Superior Defense
	-- {item:13478} Recipe: Elixir of Superior Defense · {item:13445} Elixir of Greater Defense · {skill:171} Alchemy · {npc:5178} Soolie Berryfizz · {zone:1455} Ironforge · {npc:3348} Kor'geld · {zone:1454} Orgrimmar
	["{item:13478} teaches {item:13445} ({skill:171} 265) for 1g 30s. Sold by Alliance: {npc:5178} ({zone:1455}), limited stock; Horde: {npc:3348} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:13478}教{item:13445}（{skill:171} 265），售價1金30銀。出售者：聯盟{npc:5178}（{zone:1455}），限量；部落{npc:3348}（{zone:1454}），限量。賣家每次只備一兩個，售出後過段時間補貨；拍賣行也常有的賣。",

	-- Step 58: Get Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	-- was: ["{item:8836} (Alliance)"] = "{item:8836}（聯盟）"
	["Get {item:8836} (Alliance)"] = "",
	-- {item:8836} Arthas' Tears · {skill:171} Alchemy · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	-- was: ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked."] = "為 {item:9154} 準備 43 個 {item:8836}：透過 {skill:182} 在 {zone:1448}（48-55 級）、{zone:1422}（51-58 級）和 {zone:1423}（53-60 級）採集 {item:8836}（技能 220）。已標記 {zone:1422} 中 {item:8836} 最密集的區域。"
	["You need 43 {item:8836} for {skill:171} 225-300: {item:9154}. {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked. Or buy them at the Auction House."] = "",

	-- Step 59: Get Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	-- was: ["{item:8836} (Horde)"] = "{item:8836}（部落）"
	["Get {item:8836} (Horde)"] = "",
	-- {item:8836} Arthas' Tears · {skill:171} Alchemy · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	-- was: ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked."] = "為 {item:9154} 準備 43 個 {item:8836}：透過 {skill:182} 在 {zone:1448}（48-55 級）、{zone:1422}（51-58 級）和 {zone:1423}（53-60 級）採集 {item:8836}（技能 220）。已標記 {zone:1448} 中 {item:8836} 最密集的區域。"
	["You need 43 {item:8836} for {skill:171} 225-300: {item:9154}. {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked. Or buy them at the Auction House."] = "",

	-- Step 60: Get Sungrass (Alliance)
	-- {item:8838} Sungrass
	["Get {item:8838} (Alliance)"] = "",
	-- {item:8838} Sungrass · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked."] = "為 {item:13445} 準備 43 個 {item:8838}：透過 {skill:182} 在 {zone:1425}（40-50 級）、{zone:1444}（40-50 級）和 {zone:1447}（45-55 級）採集 {item:8838}（技能 230）。已標記 {zone:1425} 中 {item:8838} 最密集的區域。"
	["You need 43 {item:8838} for {skill:171} 225-300: {item:13445}. {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked. Or buy them at the Auction House."] = "",

	-- Step 61: Get Sungrass (Horde)
	-- {item:8838} Sungrass
	["Get {item:8838} (Horde)"] = "",
	-- {item:8838} Sungrass · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked."] = "為 {item:13445} 準備 43 個 {item:8838}：透過 {skill:182} 在 {zone:1425}（40-50 級）、{zone:1444}（40-50 級）和 {zone:1447}（45-55 級）採集 {item:8838}（技能 230）。已標記 {zone:1444} 中 {item:8838} 最密集的區域。"
	["You need 43 {item:8838} for {skill:171} 225-300: {item:13445}. {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked. Or buy them at the Auction House."] = "",

	-- Step 62: Get Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	-- was: ["{item:13422} (Alliance)"] = "{item:13422}（聯盟）"
	["Get {item:13422} (Alliance)"] = "",
	-- {item:13422} Stonescale Eel · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {object:180712} Stonescale Eel Swarm
	["You need 43 {item:13422} for {skill:171} 225-300: {item:13445}. Fish them from the {object:180712} pools at the marked spot. Or buy them at the Auction House."] = "",

	-- Step 63: Get Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	-- was: ["{item:13422} (Horde)"] = "{item:13422}（部落）"
	["Get {item:13422} (Horde)"] = "",

	-- Step 64: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "專家級{skill:171}",
	-- {skill:171} Alchemy · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:13422} Stonescale Eel · {item:9154} Draught of Detect Undead · {item:13423} Stonescale Oil
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:7948} ({zone:1444}); Horde {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 225-300 takes about 1g 30s of recipes and 4g 50s 40c of vendor goods, plus 43 {item:8836}, 43 {item:8838} and 43 {item:13422} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9154} (from 230) and {item:13423} (from 250), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "大師級將技能上限從 225 提高到 300，費用為 4 金幣 50 銀幣（經典舊世價格；資料中沒有無限服的價格）；需要 {skill:171} 200 和角色等級 35，因此達到 200 後，任意一次來訪都可學習。只有少數訓練師教授：聯盟為 {npc:7948}（{zone:1444}）；部落為 {npc:1386}（{zone:1435}）。箭頭會指向你所屬陣營最近的一位。225-300 階段約需 1 金幣 30 銀幣的配方和 4 金幣 50 銀幣 40 銅幣的商人材料，另需採集或購買 43 個 {item:8836}、43 個 {item:8838} 和 43 個 {item:13422}。來之前把材料全部備齊放進揹包（按上方步驟收集，其餘從拍賣行購買）：這些訓練師還教授 {item:9154}（技能 230 起）和 {item:13423}（技能 250 起），且製作無需工作臺，可直接在此製作，達到相應技能點就學習配方。這樣只需跑一趟，無需跑 3 趟。",

	-- Step 65: Elixir of Defense to 230
	-- {item:8951} Elixir of Defense
	["{item:8951} to 230"] = "{item:8951}練到230",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands
	["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). If you got here without learning {item:8951}, learn it now: an earlier step teaches it."] = "{item:8951}在225時為黃色（黃色215，綠色235，灰色255）：大約製作8次到230。每次需要1個{item:3355}、1個{item:3821}和1個{item:3372}。{item:3355}和{item:3821}是30-45級地區的草藥（荊棘谷、阿拉希、{zone:1418}）。如果你到這裡還沒學會{item:8951}，現在就學：之前的步驟會教。",

	-- Step 66: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "{skill:171}230的配方",
	-- {spell:11460} Draught of Detect Undead
	["Still at the Artisan trainer: {spell:11460} (from 230)."] = "仍在專家級訓練師那裡：{spell:11460}（230起）。",

	-- Step 67: Draught of Detect Undead to 265
	-- {item:9154} Draught of Detect Undead
	["{item:9154} to 265"] = "{item:9154}練到265",
	-- {item:9154} Draught of Detect Undead · {item:8836} Arthas' Tears · {item:8925} Crystal Vial · {zone:1448} Felwood · {skill:182} Herbalism
	-- plural, as words: Crystal Vials = {item:8925} Crystal Vial
	["{item:9154} is orange at 230 (yellow 245, green 265, grey 285): about 43 crafts to 265. Each takes 1 {item:8836} and 1 {item:8925}. {item:8836} grow in the Plaguelands and {zone:1448} ({skill:182} 220); Crystal Vials come from alchemy vendors."] = "{item:9154}在230時為橙色（245黃、265綠、285灰）：大約43次製作可到265。每次需要1個{item:8836}和1個{item:8925}。{item:8836}生長在瘟疫之地和{zone:1448}（{skill:182} 220）；水晶瓶來自鍊金供應商。",

	-- Step 68: Alchemy recipes at 265
	-- {skill:171} Alchemy
	["{skill:171} recipes at 265"] = "{skill:171}265的配方",
	-- {spell:17551} Stonescale Oil
	["Still at the Artisan trainer: {spell:17551} (from 250)."] = "仍在專家級訓練師那裡：{spell:17551}（250起）。",

	-- Step 69: Elixir of Greater Defense to 300
	-- {item:13445} Elixir of Greater Defense
	["{item:13445} to 300"] = "{item:13445}練到300",
	-- {item:13445} Elixir of Greater Defense · {item:13423} Stonescale Oil · {item:8838} Sungrass · {item:8925} Crystal Vial · {item:13422} Stonescale Eel · {skill:171} Alchemy
	["{item:13445} is orange at 265 (yellow 280, green 300, grey 320): about 43 crafts to 300. Each takes 2 {item:13423}, 1 {item:8838} and 1 {item:8925}. Make the 86 {item:13423} (43 crafts) first. {item:13422} comes from the {item:13422} schools on the coasts of the 40-55 zones, or the Auction House (fishers sell them in stacks). {item:8838} grows in the 40-55 zones. {skill:171} 300 is a Legacy System milestone."] = "{item:13445}在265時為橙色（280黃、300綠、320灰）：大約43次製作可到300。每次需要2個{item:13423}、1個{item:8838}和1個{item:8925}。先做好那86個{item:13423}（43次製作）。{item:13422}來自40-55地區海岸的{item:13422}魚群，或拍賣行（漁夫成組出售）。{item:8838}生長在40-55地區。{skill:171} 300是傳承系統里程碑。",
	["from the recipe in your bags"] = "使用背包中的配方",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1411} is marked."] = "準備 110 個 {item:2447}，用於 {item:5997} 和 {spell:2331}（75-150 階段需要其中 28 個，現在一併採齊）：透過 {skill:182} 採集 {item:2447}（技能 1）。已標記 {zone:1411} 中 {item:2447} 最密集的區域。",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1412} is marked."] = "準備 110 個 {item:2447}，用於 {item:5997} 和 {spell:2331}（75-150 階段需要其中 28 個，現在一併採齊）：透過 {skill:182} 採集 {item:2447}（技能 1）。已標記 {zone:1412} 中 {item:2447} 最密集的區域。",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1420} is marked."] = "準備 110 個 {item:2447}，用於 {item:5997} 和 {spell:2331}（75-150 階段需要其中 28 個，現在一併採齊）：透過 {skill:182} 採集 {item:2447}（技能 1）。已標記 {zone:1420} 中 {item:2447} 最密集的區域。",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1426} is marked."] = "準備 110 個 {item:2447}，用於 {item:5997} 和 {spell:2331}（75-150 階段需要其中 28 個，現在一併採齊）：透過 {skill:182} 採集 {item:2447}（技能 1）。已標記 {zone:1426} 中 {item:2447} 最密集的區域。",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1429} is marked."] = "準備 110 個 {item:2447}，用於 {item:5997} 和 {spell:2331}（75-150 階段需要其中 28 個，現在一併採齊）：透過 {skill:182} 採集 {item:2447}（技能 1）。已標記 {zone:1429} 中 {item:2447} 最密集的區域。",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1438} is marked."] = "準備 110 個 {item:2447}，用於 {item:5997} 和 {spell:2331}（75-150 階段需要其中 28 個，現在一併採齊）：透過 {skill:182} 採集 {item:2447}（技能 1）。已標記 {zone:1438} 中 {item:2447} 最密集的區域。",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:2521} is marked."] = "準備 110 個 {item:2447}，用於 {item:5997} 和 {spell:2331}（75-150 階段需要其中 28 個，現在一併採齊）：透過 {skill:182} 採集 {item:2447}（技能 1）。已標記 {zone:2521} 中 {item:2447} 最密集的區域。",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1413} is marked."] = "為{spell:3171}和{spell:3176}準備152個{item:2450}（其中24個用於150-225階段：現在一次採齊）：透過{skill:182}採集{item:2450}（需要技能70）。已標記{zone:1413}中{item:2450}最密集的區域。",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1421} is marked."] = "為{spell:3171}和{spell:3176}準備152個{item:2450}（其中24個用於150-225階段：現在一次採齊）：透過{skill:182}採集{item:2450}（需要技能70）。已標記{zone:1421}中{item:2450}最密集的區域。",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1432} is marked."] = "為{spell:3171}和{spell:3176}準備152個{item:2450}（其中24個用於150-225階段：現在一次採齊）：透過{skill:182}採集{item:2450}（需要技能70）。已標記{zone:1432}中{item:2450}最密集的區域。",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1436} is marked."] = "為{spell:3171}和{spell:3176}準備152個{item:2450}（其中24個用於150-225階段：現在一次採齊）：透過{skill:182}採集{item:2450}（需要技能70）。已標記{zone:1436}中{item:2450}最密集的區域。",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1439} is marked."] = "為{spell:3171}和{spell:3176}準備152個{item:2450}（其中24個用於150-225階段：現在一次採齊）：透過{skill:182}採集{item:2450}（需要技能70）。已標記{zone:1439}中{item:2450}最密集的區域。",
	-- ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked."] = "準備 39 個 {item:3356}，用於 {spell:3452}：透過 {skill:182} 採集 {item:3356}（技能 125），產地有 {zone:1413}（10-25 級）、{zone:1440}（18-30 級）和 {zone:1434}（30-45 級）。已標記 {zone:1413} 中 {item:3356} 最密集的區域。",
	-- ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked."] = "為 {spell:3452} 準備 39 個 {item:3356}：透過 {skill:182} 採集 {zone:1440}（18-30 級）、{zone:1437}（20-30 級）和 {zone:1434}（30-45 級）的 {item:3356}（需要技能 125）。已標記 {zone:1434} 中 {item:3356} 最密集的區域。",
	-- ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked."] = "為 {spell:3452} 準備39株 {object:2045}：{skill:182}：在 {zone:1413}（10-25級）、{zone:1434}（30-45級）和 {zone:1425}（40-50級）採集 {object:2045}（技能85）。已標出 {zone:1413} 中 {object:2045} 最密集的區域。",
	-- ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked."] = "準備 39 個 {object:2045}，用於 {spell:3452}：透過 {skill:182} 採集 {object:2045}（技能 85），產地有 {zone:1437}（20-30 級）、{zone:1434}（30-45 級）和 {zone:1425}（40-50 級）。已標記 {zone:1434} 中 {object:2045} 最密集的區域。",
	-- ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked."] = "為 {item:8951} 準備 40 個 {object:1623}（其中 8 個用於 225-300 階段：現在一併採齊）：透過 {skill:182} 在 {zone:1442}（15-27 級）、{zone:1417}（30-40 級）和 {zone:1434}（30-45 級）採集 {object:1623}（技能 115）。已標記 {zone:1434} 中 {object:1623} 最密集的區域。",
	-- ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked."] = "為 {item:8951} 準備 40 個 {object:1623}（其中 8 個用於 225-300 階段：現在一併採齊）：透過 {skill:182} 在 {zone:1442}（15-27 級）、{zone:1417}（30-40 級）和 {zone:1434}（30-45 級）採集 {object:1623}（技能 115）。已標記 {zone:1442} 中 {object:1623} 最密集的區域。",
	-- ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked."] = "為 {item:8951} 準備 40 個 {object:2046}（其中 8 個用於 225-300 階段：現在一併採齊）：透過 {skill:182} 在 {zone:1417}（30-40 級）、{zone:1425}（40-50 級）和 {zone:1444}（40-50 級）採集 {object:2046}（技能 170）。已標記 {zone:1417} 中 {object:2046} 最密集的區域。",
	-- ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked."] = "為 {item:8951} 準備 40 個 {object:2046}（其中 8 個用於 225-300 階段：現在一併採齊）：透過 {skill:182} 在 {zone:1417}（30-40 級）、{zone:1425}（40-50 級）和 {zone:1444}（40-50 級）採集 {object:2046}（技能 170）。已標記 {zone:1444} 中 {object:2046} 最密集的區域。",
	-- ["43 {item:13422} for {item:13445}: {skill:356}. Fish {object:180712} here."] = "為 {item:13445} 準備 43 個 {item:13422}：透過 {skill:356} 獲取。在此處的 {object:180712} 中垂釣。",
	-- ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked."] = "為 {item:9154} 準備 43 個 {item:8836}：透過 {skill:182} 在 {zone:1448}（48-55 級）、{zone:1422}（51-58 級）和 {zone:1423}（53-60 級）採集 {item:8836}（技能 220）。已標記 {zone:1422} 中 {item:8836} 最密集的區域。",
	-- ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked."] = "為 {item:9154} 準備 43 個 {item:8836}：透過 {skill:182} 在 {zone:1448}（48-55 級）、{zone:1422}（51-58 級）和 {zone:1423}（53-60 級）採集 {item:8836}（技能 220）。已標記 {zone:1448} 中 {item:8836} 最密集的區域。",
	-- ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked."] = "為 {item:13445} 準備 43 個 {item:8838}：透過 {skill:182} 在 {zone:1425}（40-50 級）、{zone:1444}（40-50 級）和 {zone:1447}（45-55 級）採集 {item:8838}（技能 230）。已標記 {zone:1425} 中 {item:8838} 最密集的區域。",
	-- ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked."] = "為 {item:13445} 準備 43 個 {item:8838}：透過 {skill:182} 在 {zone:1425}（40-50 級）、{zone:1444}（40-50 級）和 {zone:1447}（45-55 級）採集 {item:8838}（技能 230）。已標記 {zone:1444} 中 {item:8838} 最密集的區域。",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1413} is marked."] = "為 {spell:3176} 準備54株 {item:2453}（其中24株用於150-225階段：現在就全部採好）：{skill:182}：採集 {item:2453}（技能100）。已標出 {zone:1413} 中 {item:2453} 最密集的區域。",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1421} is marked."] = "為 {spell:3176} 準備54株 {item:2453}（其中24株用於150-225階段：現在就全部採好）：{skill:182}：採集 {item:2453}（技能100）。已標出 {zone:1421} 中 {item:2453} 最密集的區域。",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1432} is marked."] = "為 {spell:3176} 準備54株 {item:2453}（其中24株用於150-225階段：現在就全部採好）：{skill:182}：採集 {item:2453}（技能100）。已標出 {zone:1432} 中 {item:2453} 最密集的區域。",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1436} is marked."] = "為 {spell:3176} 準備54株 {item:2453}（其中24株用於150-225階段：現在就全部採好）：{skill:182}：採集 {item:2453}（技能100）。已標出 {zone:1436} 中 {item:2453} 最密集的區域。",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1439} is marked."] = "為 {spell:3176} 準備54株 {item:2453}（其中24株用於150-225階段：現在就全部採好）：{skill:182}：採集 {item:2453}（技能100）。已標出 {zone:1439} 中 {item:2453} 最密集的區域。",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1413} is marked."] = "為 {spell:2331} 和 {spell:3171} 準備77份 {item:785}：{skill:182}：採集 {item:785}（技能50）。已標記 {zone:1413} 中 {item:785} 最密集的區域。",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1421} is marked."] = "為 {spell:2331} 和 {spell:3171} 準備77份 {item:785}：{skill:182}：採集 {item:785}（技能50）。已標記 {zone:1421} 中 {item:785} 最密集的區域。",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1432} is marked."] = "為 {spell:2331} 和 {spell:3171} 準備77份 {item:785}：{skill:182}：採集 {item:785}（技能50）。已標記 {zone:1432} 中 {item:785} 最密集的區域。",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1436} is marked."] = "為 {spell:2331} 和 {spell:3171} 準備77份 {item:785}：{skill:182}：採集 {item:785}（技能50）。已標記 {zone:1436} 中 {item:785} 最密集的區域。",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1438} is marked."] = "為 {spell:2331} 和 {spell:3171} 準備77份 {item:785}：{skill:182}：採集 {item:785}（技能50）。已標記 {zone:1438} 中 {item:785} 最密集的區域。",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:2521} is marked."] = "為 {spell:2331} 和 {spell:3171} 準備77份 {item:785}：{skill:182}：採集 {item:785}（技能50）。已標記 {zone:2521} 中 {item:785} 最密集的區域。",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1411} is marked."] = "準備82個{item:765}製作{item:5997}：{skill:182}：採集{item:765}（技能1）。已標記{zone:1411}中{item:765}最密集的位置。",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1412} is marked."] = "準備82個{item:765}製作{item:5997}：{skill:182}：採集{item:765}（技能1）。已標記{zone:1412}中{item:765}最密集的位置。",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1420} is marked."] = "準備82個{item:765}製作{item:5997}：{skill:182}：採集{item:765}（技能1）。已標記{zone:1420}中{item:765}最密集的位置。",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1426} is marked."] = "準備82個{item:765}製作{item:5997}：{skill:182}：採集{item:765}（技能1）。已標記{zone:1426}中{item:765}最密集的位置。",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1429} is marked."] = "準備82個{item:765}製作{item:5997}：{skill:182}：採集{item:765}（技能1）。已標記{zone:1429}中{item:765}最密集的位置。",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1438} is marked."] = "準備82個{item:765}製作{item:5997}：{skill:182}：採集{item:765}（技能1）。已標記{zone:1438}中{item:765}最密集的位置。",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:2521} is marked."] = "準備82個{item:765}製作{item:5997}：{skill:182}：採集{item:765}（技能1）。已標記{zone:2521}中{item:765}最密集的位置。",
	-- ["Apprentice {skill:171}"] = "初級{skill:171}",
	-- ["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "專家級需要角色等級35和{skill:171}200；上限提高到300。225-300的材料總價約7金80銀。",
	-- ["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "回到{skill:171}訓練師：{skill:171}190起可學{spell:11447}。",
	-- ["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "回到{skill:171}訓練師：{skill:171}85起可學{spell:1244645}。",
	-- ["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "回到{skill:171}訓練師：{skill:171}175起可學{spell:1244647}。",
	-- ["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "回到{skill:171}訓練師：{skill:171}230起可學{spell:1244648}。",
	-- ["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "回到{skill:171}訓練師：{skill:171}165起可學{spell:7845}。",
	-- ["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "高級需要角色等級20和{skill:171}125；上限提高到225。150-225的材料總價約3金65銀。",
	-- ["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "在{object:180582}釣魚；資料中這裡最多。拍賣場也買得到。",
	-- ["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "在{object:180657}釣魚；資料中這裡最多。拍賣場也買得到。",
	-- ["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "在{object:180712}釣魚；資料中這裡最多。拍賣場也買得到。",
	-- ["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "中級需要角色等級10和{skill:171}50；上限提高到150。75-150的材料總價約1金44銀。",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在Polestar依你的等級和陣營選定的地點擊殺掉落它的怪物。拍賣場也買得到。",
	-- ["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "130前為橘色（每次製作都加點），150前為黃色，170前為綠色。{skill:171}150是傳承系統的里程碑。",
	-- ["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "280前為橘色（每次製作都加點），300前為黃色，320前為綠色。{skill:171}300是傳承系統的里程碑。",
	-- ["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "55前為橘色（每次製作都加點），75前為黃色，95前為綠色。75是初級的上限。",
	-- ["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:2447}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:2450}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:2453}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:3355}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:3356}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:3357}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:3821}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:765}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:785}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:8836}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:8838}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{object:1623}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{object:2046}；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "學會{item:6051}（需要{skill:171}100）。商人限量販售，會補貨。",
	-- ["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "學會{item:8951}（需要{skill:171}265）。商人限量販售，會補貨；拍賣場也常有。",
	-- ["What 1-75 takes that the Auction House sells: 82 {item:765} and 110 {item:2447}. The counts drop by what your bags, bank and mail hold."] = "1-75階段所需的材料中，拍賣場有賣的：82個{item:765}和110個{item:2447}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What 150-225 takes that the Auction House sells: 40 {item:3355}, 39 {item:3356}, 39 {item:3820} and 40 {item:3821}. The counts drop by what your bags, bank and mail hold."] = "150-225階段所需的材料中，拍賣場有賣的：40個{item:3355}、39個{item:3356}、39個{item:3820}和40個{item:3821}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What 225-300 takes that the Auction House sells: 43 {item:8836}, 43 {item:8838} and 43 {item:13422}. The counts drop by what your bags, bank and mail hold."] = "225-300階段所需的材料中，拍賣場有賣的：43個{item:8836}、43個{item:8838}和43個{item:13422}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What 75-150 takes that the Auction House sells: 77 {item:785}, 152 {item:2450} and 54 {item:2453}. The counts drop by what your bags, bank and mail hold."] = "75-150階段所需的材料中，拍賣場有賣的：77個{item:785}、152個{item:2450}和54個{item:2453}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["Yellow until 105, green until 125: not every craft gives a point."] = "105前為黃色，125前為綠色：不是每次製作都加點。",
	-- ["Yellow until 160, green until 170: not every craft gives a point."] = "160前為黃色，170前為綠色：不是每次製作都加點。",
	-- ["Yellow until 185, green until 205: not every craft gives a point."] = "185前為黃色，205前為綠色：不是每次製作都加點。",
	-- ["Yellow until 195, green until 215: not every craft gives a point."] = "195前為黃色，215前為綠色：不是每次製作都加點。",
	-- ["Yellow until 210, green until 230: not every craft gives a point."] = "210前為黃色，230前為綠色：不是每次製作都加點。",
	-- ["Yellow until 235, green until 255: not every craft gives a point."] = "235前為黃色，255前為綠色：不是每次製作都加點。",
	-- ["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "235前為黃色，255前為綠色：不是每次製作都加點。{skill:171}225是傳承系統的里程碑。",
	-- ["Yellow until 250, green until 270: not every craft gives a point."] = "250前為黃色，270前為綠色：不是每次製作都加點。",
	-- ["Yellow until 255, green until 260: not every craft gives a point."] = "255前為黃色，260前為綠色：不是每次製作都加點。",
	-- ["Yellow until 265, green until 285: not every craft gives a point."] = "265前為黃色，285前為綠色：不是每次製作都加點。",
	-- ["Yellow until 85, green until 105: not every craft gives a point."] = "85前為黃色，105前為綠色：不是每次製作都加點。",
	-- ["{item:13422} (Alliance)"] = "{item:13422}（聯盟）",
	-- ["{item:13422} (Horde)"] = "{item:13422}（部落）",
	-- ["{item:13423} to 259"] = "{item:13423}練到259",
	-- ["{item:2447} (Alliance)"] = "{item:2447}（聯盟）",
	-- ["{item:2447} (Horde)"] = "{item:2447}（部落）",
	-- ["{item:2450} (Alliance)"] = "{item:2450}（聯盟）",
	-- ["{item:2450} (Horde)"] = "{item:2450}（部落）",
	-- ["{item:2452} (Alliance)"] = "{item:2452}（聯盟）",
	-- ["{item:2452} (Horde)"] = "{item:2452}（部落）",
	-- ["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452}來自{item:2450}採集點（{skill:182}）；這是資料中最密集的區域。拍賣場也買得到。",
	-- ["{item:2453} (Alliance)"] = "{item:2453}（聯盟）",
	-- ["{item:2453} (Horde)"] = "{item:2453}（部落）",
	-- ["{item:247239} to 100"] = "{item:247239}練到100",
	-- ["{item:247241} to 200"] = "{item:247241}練到200",
	-- ["{item:247242} to 250"] = "{item:247242}練到250",
	-- ["{item:3355} (Alliance)"] = "{item:3355}（聯盟）",
	-- ["{item:3355} (Horde)"] = "{item:3355}（部落）",
	-- ["{item:3356} (Alliance)"] = "{item:3356}（聯盟）",
	-- ["{item:3356} (Horde)"] = "{item:3356}（部落）",
	-- ["{item:3357} (Alliance)"] = "{item:3357}（聯盟）",
	-- ["{item:3357} (Horde)"] = "{item:3357}（部落）",
	-- ["{item:3821} (Alliance)"] = "{item:3821}（聯盟）",
	-- ["{item:3821} (Horde)"] = "{item:3821}（部落）",
	-- ["{item:6051} to 150"] = "{item:6051}練到150",
	-- ["{item:6358} (Alliance)"] = "{item:6358}（聯盟）",
	-- ["{item:6358} (Horde)"] = "{item:6358}（部落）",
	-- ["{item:6359} (Alliance)"] = "{item:6359}（聯盟）",
	-- ["{item:6359} (Horde)"] = "{item:6359}（部落）",
	-- ["{item:6371} to 165"] = "{item:6371}練到165",
	-- ["{item:730} (Alliance)"] = "{item:730}（聯盟）",
	-- ["{item:730} (Horde)"] = "{item:730}（部落）",
	-- ["{item:765} (Alliance)"] = "{item:765}（聯盟）",
	-- ["{item:765} (Horde)"] = "{item:765}（部落）",
	-- ["{item:785} (Alliance)"] = "{item:785}（聯盟）",
	-- ["{item:785} (Horde)"] = "{item:785}（部落）",
	-- ["{item:8836} (Alliance)"] = "{item:8836}（聯盟）",
	-- ["{item:8836} (Horde)"] = "{item:8836}（部落）",
	-- ["{item:8838} (Alliance)"] = "{item:8838}（聯盟）",
	-- ["{item:8838} (Horde)"] = "{item:8838}（部落）",
	-- ["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418})."] = "{item:8951}在225時為黃色（215黃、235綠、255灰）：大約8次製作可到230。每次需要1個{item:3355}、1個{item:3821}和1個{item:3372}。{item:3355}和{item:3821}是30-45地區的草藥（荊棘谷、阿拉希、{zone:1418}）。",
	-- ["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "{npc:1958}（等級17-18）在這裡掉落。拍賣場也買得到。",
	-- ["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "{npc:513}（等級14-15）在這裡掉落。拍賣場也買得到。",
	-- ["{object:1623} (Alliance)"] = "{object:1623}（聯盟）",
	-- ["{object:1623} (Horde)"] = "{object:1623}（部落）",
	-- ["{object:2045} (Alliance)"] = "{object:2045}（聯盟）",
	-- ["{object:2045} (Horde)"] = "{object:2045}（部落）",
	-- ["{object:2046} (Alliance)"] = "{object:2046}（聯盟）",
	-- ["{object:2046} (Horde)"] = "{object:2046}（部落）",
	-- ["{skill:171} 1-75: Auction House"] = "{skill:171} 1-75：拍賣場",
	-- ["{skill:171} 150-225: Auction House"] = "{skill:171} 150-225：拍賣場",
	-- ["{skill:171} 225-300: Auction House"] = "{skill:171} 225-300：拍賣場",
	-- ["{skill:171} 75-150: Auction House"] = "{skill:171} 75-150：拍賣場",
	-- ["{skill:171} recipes at 259"] = "{skill:171}259的配方",
	-- ["{skill:171} recipes at 85"] = "{skill:171}85的配方",
	-- ["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171}可以邊升級邊練。Forever的傳承系統會在技能150、225和300（中級、高級和專家級的上限）獎勵製造專業，所以每個關卡都很重要。1-75的材料總價約68銀。",
	-- ["{spell:11447} to 215"] = "{spell:11447}練到215",
	-- ["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones."] = "{spell:3176}在150時為黃色（150黃、170綠、190灰）：大約12次製作可到160。每次需要2個{item:2453}、2個{item:2450}和1個{item:3372}。每次兩個{item:2453}和兩個{item:2450}；{item:2453}生長在15-30地區。",
	-- ["{spell:7845} to 175"] = "{spell:7845}練到175",
}
