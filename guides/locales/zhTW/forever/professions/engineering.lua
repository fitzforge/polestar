-- Chinese (traditional) (zhTW): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
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
	-- {item:2880} Weak Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286})."] = "",
	["a tool, keep it in your bags"] = "",

	-- Step 3: Engineering 1-75: Auction House
	-- {skill:202} Engineering
	["{skill:202} 1-75: Auction House"] = "{skill:202} 1-75：拍賣場",
	-- {item:2835} Rough Stone · {item:2840} Copper Bar
	["What 1-75 takes that the Auction House sells: 46 {item:2835} and 75 {item:2840}. The counts drop by what your bags, bank and mail hold."] = "1-75階段所需的材料中，拍賣場有賣的：46個{item:2835}和75個{item:2840}。數量會扣除你背包、銀行和郵件中已有的。",

	-- Step 4: Rough Stone (Elwynn Forest)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1429} Elwynn Forest
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "",

	-- Step 5: Rough Stone (Dun Morogh)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "",

	-- Step 6: Rough Stone (Darkshore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1439} Darkshore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "",

	-- Step 7: Rough Stone (Zephras Isle)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:2521} Zephras Isle
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "",

	-- Step 8: Rough Stone (Durotar)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1411} Durotar
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "",

	-- Step 9: Rough Stone (Mulgore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1412} Mulgore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "",

	-- Step 10: Rough Stone (Tirisfal Glades)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1420} Tirisfal Glades
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "",

	-- Step 11: Copper Bar
	-- {item:2840} Copper Bar · {spell:3922} Handful of Copper Bolts · {item:6219} Arclight Spanner · {spell:3924} Copper Tube · {skill:186} Mining · {item:2770} Copper Ore
	["75 {item:2840} for {spell:3922}, {item:6219} and {spell:3924}: {skill:186}: smelt {item:2770}."] = "準備75個{item:2840}製作{spell:3922}、{item:6219}和{spell:3924}：{skill:186}：熔煉{item:2770}。",

	-- Step 12: Rough Blasting Powder to 35
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 35"] = "{spell:3918}練到 35",
	-- {spell:3918} Rough Blasting Powder · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["{spell:3918} is orange at 1 (yellow 20, green 30, grey 40): about 46 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft; {item:2835} comes with the {item:2770} from Copper Veins."] = "",

	-- Step 13: Engineering recipes at 35
	-- {skill:202} Engineering
	["{skill:202} recipes at 35"] = "{skill:202} 35 配方",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {spell:1230656} Reagent Bot · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3922} (from 30, 1s 15c). Also learn {spell:1230656} (1s): Forever's {skill:202} camp item, placed at a campsite beside a campfire. It takes a {spell:3922} and a {spell:3924}, which you learn at 30 and 50, so it gives no points. The Camping 101: {skill:202} quest from your starting area's camping guide (after The Great Outdoors) sends you to an engineering trainer who teaches it free."] = "",

	-- Step 14: Handful of Copper Bolts to 57
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 57"] = "{spell:3922}練到 57",
	-- {spell:3922} Handful of Copper Bolts · {item:2840} Copper Bar · {item:5956} Blacksmith Hammer
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{spell:3922} is orange at 35 (yellow 45, green 52, grey 60): about 33 crafts to 57. Each takes 1 {item:2840}. One {item:2840} a craft. Keep the bolts: Practice Locks and later gadgets take them. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "",

	-- Step 15: Engineering recipes at 57
	-- {skill:202} Engineering
	["{skill:202} recipes at 57"] = "{skill:202} 57 配方",
	-- {skill:202} Engineering · {spell:7430} Arclight Spanner · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:7430} (from 50, 1s 50c) and {spell:3924} (from 50, 1s 50c)."] = "",

	-- Step 16: Copper Tube to 75
	-- {spell:3924} Copper Tube
	["{spell:3924} to 75"] = "{spell:3924}練到 75",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux · {item:6219} Arclight Spanner
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is orange at 57 (yellow 80, green 95, grey 110): about 18 crafts to 75, a point every craft. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. Make the {item:6219} now, while it still gives a point: a later recipe needs it in your bags, so keep it there."] = "",
	["a tool: keep it in your bags"] = "工具：請留在背包中",

	-- Step 17: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "中級{skill:202}",
	-- {skill:202} Engineering · {npc:1676} Finbus Geargrind · {zone:1431} Duskwood · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:11029} Trixie Quikswitch · {zone:1455} Ironforge · {npc:11031} Franklin Lloyd · {zone:1458} Undercity · {spell:3929} Coarse Blasting Powder · {spell:3930} Crafted Heavy Shot · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}) and {npc:11029} ({zone:1455}); Horde {npc:11031} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "中級將上限從75提高到150，費用5銀（經典版的價格；資料中沒有Forever的價格）；需要{skill:202} 50和角色等級10，所以技能達到50後，任何一次經過都可以學。並非每位{skill:202}訓練師都會教：聯盟有{npc:1676}（{zone:1431}）、{npc:5518}（{zone:1453}）和{npc:11029}（{zone:1455}）；部落有{npc:11031}（{zone:1458}）。箭頭會選擇你陣營最近的一位。現在學習：{spell:3929}（技能75起，2銀50銅）和{spell:3930}（技能75起，2銀50銅）。75-150約需5銀的配方和45銀的商人材料，另需採集或購買15個{item:2836}、27個{item:2838}、72個{item:2840}、61個{item:2841}和2個{item:2842}。",

	-- Step 18: Engineering 75-150: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 75-150: vendor goods"] = "",
	-- {item:2880} Weak Flux · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 45 {item:2880} (45s); about 45s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286})."] = "",

	-- Step 19: Engineering 75-150: Auction House
	-- {skill:202} Engineering
	["{skill:202} 75-150: Auction House"] = "{skill:202} 75-150：拍賣場",
	-- {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["What 75-150 takes that the Auction House sells: 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842}. The counts drop by what your bags, bank and mail hold."] = "75-150階段所需的材料中，拍賣場有賣的：15個{item:2836}、27個{item:2838}、72個{item:2840}、61個{item:2841}和2個{item:2842}。數量會扣除你背包、銀行和郵件中已有的。",

	-- Step 20: Coarse Stone (Westfall)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1436} Westfall
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "",

	-- Step 21: Coarse Stone (Loch Modan)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "",

	-- Step 22: Coarse Stone (Darkshore)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1439} Darkshore
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "",

	-- Step 23: Coarse Stone (The Barrens)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "",

	-- Step 24: Coarse Stone (Silverpine Forest)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1421} Silverpine Forest
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "",

	-- Step 25: Heavy Stone (Arathi Highlands)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "",

	-- Step 26: Heavy Stone (Ashenvale)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1440} Ashenvale
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "",

	-- Step 27: Heavy Stone (The Barrens)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1413} The Barrens
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "",

	-- Step 29: Copper Bar
	-- {item:2840} Copper Bar · {spell:3930} Crafted Heavy Shot · {spell:3924} Copper Tube · {item:6712} Practice Lock · {skill:186} Mining · {item:2770} Copper Ore
	["72 {item:2840} for {spell:3930}, {spell:3924} and {item:6712}: {skill:186}: smelt {item:2770}."] = "準備72個{item:2840}製作{spell:3930}、{spell:3924}和{item:6712}：{skill:186}：熔煉{item:2770}。",

	-- Step 30: Bronze Bar
	-- {item:2841} Bronze Bar · {item:6712} Practice Lock · {spell:3950} Big Bronze Bomb · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["61 {item:2841} for {item:6712} and {spell:3950}: {skill:186}: smelt {item:2840} and {item:3576}."] = "準備61個{item:2841}製作{item:6712}和{spell:3950}：{skill:186}：熔煉{item:2840}和{item:3576}。",

	-- Step 31: Silver Bar
	-- {item:2842} Silver Bar · {spell:3950} Big Bronze Bomb · {skill:186} Mining · {item:2775} Silver Ore
	["2 {item:2842} for {spell:3950}: {skill:186}: smelt {item:2775}."] = "準備2個{item:2842}製作{spell:3950}：{skill:186}：熔煉{item:2775}。",

	-- Step 32: Crafted Heavy Shot to 94
	-- {spell:3930} Crafted Heavy Shot
	["{spell:3930} to 94"] = "",
	-- {spell:3930} Crafted Heavy Shot · {spell:3929} Coarse Blasting Powder · {item:2840} Copper Bar
	["{spell:3930} is orange at 75 (yellow 85, green 90, grey 95): about 15 crafts to 94. Each takes 1 {spell:3929} and 1 {item:2840} and makes 200. Make the 15 {spell:3929} first: it gives points too while not grey. The {spell:3929} in each gives its own point while it is not grey: two chances a craft. Sell the shot to hunters or a vendor."] = "",

	-- Step 33: Copper Tube to 100
	-- {spell:3924} Copper Tube
	["{spell:3924} to 100"] = "",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is yellow at 94 (yellow 80, green 95, grey 110): about 14 crafts to 100. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby."] = "",

	-- Step 34: Engineering recipes at 100
	-- {skill:202} Engineering
	["{skill:202} recipes at 100"] = "{skill:202} 100 配方",
	-- {skill:202} Engineering · {spell:8334} Practice Lock
	["Back to an {skill:202} trainer: {spell:8334} (from 100)."] = "回到{skill:202}訓練師處：{spell:8334}（100起）。",

	-- Step 35: Practice Lock to 125
	-- {item:6712} Practice Lock
	["{item:6712} to 125"] = "",
	-- {item:6712} Practice Lock · {item:2841} Bronze Bar · {spell:3922} Handful of Copper Bolts · {item:2880} Weak Flux
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125. Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 29 {spell:3922} first. Use the 33 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby."] = "",

	-- Step 36: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "{skill:202} 125 配方",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} (from 125)."] = "回到{skill:202}訓練師處：{spell:3945}（125起）。",

	-- Step 37: Heavy Blasting Powder to 140
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 140"] = "{spell:3945}練到 140",
	-- {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit · Iron Grenades = {item:4390} Iron Grenade
	["{spell:3945} is yellow at 125 (yellow 125, green 135, grey 145): about 27 crafts to 140. Each takes 1 {item:2838}. One {item:2838} a craft (Iron Deposits). Keep some: Iron Grenades take one each."] = "",

	-- Step 38: Engineering recipes at 140
	-- {skill:202} Engineering
	["{skill:202} recipes at 140"] = "{skill:202} 140 配方",
	-- {skill:202} Engineering · {spell:3973} Silver Contact · {spell:3950} Big Bronze Bomb
	["Back to an {skill:202} trainer: {spell:3973} (from 90) and {spell:3950} (from 140)."] = "回到{skill:202}訓練師處：{spell:3973}（90起）和{spell:3950}（140起）。",

	-- Step 39: Big Bronze Bomb to 150
	-- {spell:3950} Big Bronze Bomb
	["{spell:3950} to 150"] = "",
	-- {spell:3950} Big Bronze Bomb · {item:4377} Heavy Blasting Powder · {item:2841} Bronze Bar · {spell:3973} Silver Contact · {skill:202} Engineering
	["{spell:3950} is yellow at 140 (yellow 140, green 165, grey 190): about 10 crafts to 150. Each takes 2 {item:4377}, 3 {item:2841} and 1 {spell:3973} and makes 3. Make the 10 {spell:3973} (2 crafts) first. Use the 20 {item:4377} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "",

	-- Step 40: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "高級{skill:202}",
	-- {skill:202} Engineering · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11017} Roxxik · {zone:1454} Orgrimmar · {spell:9271} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:5174} ({zone:1455}); Horde {npc:11017} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912} to gather or buy."] = "高級將上限從150提高到225，費用50銀（經典版的價格；資料中沒有Forever的價格）；需要{skill:202} 125和角色等級20，所以技能達到125後，任何一次經過都可以學。只有少數訓練師會教：聯盟為{npc:5174}（{zone:1455}）；部落為{npc:11017}（{zone:1454}）。箭頭會選擇你陣營最近的一位。現在學習：{spell:9271}（技能150起）和{spell:3953}（技能145起）。150-225約需31銀的商人材料，另需採集或購買19個{item:2319}、19個{item:2592}、31個{item:2836}、74個{item:2838}、100個{item:2841}、6個{item:2842}、81個{item:3575}、19個{item:3860}和62個{item:7912}。",

	-- Step 41: Engineering 150-225: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 150-225: vendor goods"] = "",
	-- {item:6530} Nightcrawlers · {zone:1453} Stormwind City · {npc:5494} Catherine Leland · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 31 {item:6530} (31s); about 31s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5494} and {npc:1286})."] = "",

	-- Step 42: Engineering 150-225: Auction House
	-- {skill:202} Engineering
	["{skill:202} 150-225: Auction House"] = "{skill:202} 150-225：拍賣場",
	-- {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["What 150-225 takes that the Auction House sells: 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "150-225階段所需的材料中，拍賣場有賣的：19個{item:2319}、19個{item:2592}、31個{item:2836}、74個{item:2838}、100個{item:2841}、6個{item:2842}、81個{item:3575}、19個{item:3860}和62個{item:7912}。數量會扣除你背包、銀行和郵件中已有的。",

	-- Step 43: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319}（聯盟）",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 44: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 45: Wool Cloth
	-- {item:2592} Wool Cloth · {spell:3953} Bronze Framework
	["19 {item:2592} for {spell:3953}: humanoids of level 15-30 drop it. Keep what you loot as you level, or take it from your bank."] = "為{spell:3953}準備19個{item:2592}：15-30級的人型生物會掉落。練等時把撿到的留著，或從銀行取出。",

	-- Step 46: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836}（聯盟）",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1432} is marked."] = "",

	-- Step 47: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836}（部落）",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1440} is marked."] = "",

	-- Step 48: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838}（聯盟）",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:1443} Desolace
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "",

	-- Step 49: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838}（部落）",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1441} Thousand Needles · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "",

	-- Step 50: Bronze Bar
	-- {item:2841} Bronze Bar · {item:6533} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["100 {item:2841} for {item:6533} and {spell:3953}: {skill:186}: smelt {item:2840} and {item:3576}."] = "準備100個{item:2841}製作{item:6533}和{spell:3953}：{skill:186}：熔煉{item:2840}和{item:3576}。",

	-- Step 51: Silver Bar
	-- {item:2842} Silver Bar · {spell:3967} Big Iron Bomb · {skill:186} Mining · {item:2775} Silver Ore
	["6 {item:2842} for {spell:3967}: {skill:186}: smelt {item:2775}."] = "準備6個{item:2842}製作{spell:3967}：{skill:186}：熔煉{item:2775}。",

	-- Step 52: Iron Bar
	-- {item:3575} Iron Bar · {spell:3967} Big Iron Bomb · {skill:186} Mining · {item:2772} Iron Ore
	["81 {item:3575} for {spell:3967}: {skill:186}: smelt {item:2772}."] = "準備81個{item:3575}製作{spell:3967}：{skill:186}：熔煉{item:2772}。",

	-- Step 53: Mithril Bar
	-- {item:3860} Mithril Bar · {item:10512} Hi-Impact Mithril Slugs · {skill:186} Mining · {item:3858} Mithril Ore
	["19 {item:3860} for {item:10512}: {skill:186}: smelt {item:3858}."] = "準備19個{item:3860}製作{item:10512}：{skill:186}：熔煉{item:3858}。",

	-- Step 54: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912}（聯盟）",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "",

	-- Step 55: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912}（部落）",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "",

	-- Step 56: Aquadynamic Fish Attractor to 166
	-- {item:6533} Aquadynamic Fish Attractor
	["{item:6533} to 166"] = "",
	-- {item:6533} Aquadynamic Fish Attractor · {item:2841} Bronze Bar · {item:6530} Nightcrawlers · {spell:3929} Coarse Blasting Powder
	["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166. Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 31 {spell:3929} first. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen."] = "",

	-- Step 57: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953}練到 175",
	-- {spell:3953} Bronze Framework · {item:2841} Bronze Bar · {item:2319} Medium Leather · {item:2592} Wool Cloth
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["{spell:3953} is yellow at 166 (yellow 145, green 170, grey 195): about 19 crafts to 175. Each takes 2 {item:2841}, 1 {item:2319} and 1 {item:2592}. Bronze Frameworks are parts for later gadgets; the extras sell to vendors."] = "",

	-- Step 58: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "{skill:202} 175 配方",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder
	["Back to an {skill:202} trainer: {spell:12585} (from 175)."] = "回到{skill:202}訓練師處：{spell:12585}（175起）。",

	-- Step 59: Solid Blasting Powder to 191
	-- {item:10505} Solid Blasting Powder
	["{item:10505} to 191"] = "",
	-- {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["{item:10505} is yellow at 175 (yellow 175, green 185, grey 195): about 31 crafts to 191. Each takes 2 {item:7912}. Two {item:7912} a craft (Mithril Deposits). Make plenty: the triggers, slugs and Gyro-Shot all use it."] = "",

	-- Step 60: Engineering recipes at 191
	-- {skill:202} Engineering
	["{skill:202} recipes at 191"] = "{skill:202} 191 配方",
	-- {skill:202} Engineering · {spell:3967} Big Iron Bomb
	["Back to an {skill:202} trainer: {spell:3967} (from 190)."] = "回到{skill:202}訓練師處：{spell:3967}（190起）。",

	-- Step 61: Big Iron Bomb to 210
	-- {spell:3967} Big Iron Bomb
	["{spell:3967} to 210"] = "",
	-- {spell:3967} Big Iron Bomb · {item:3575} Iron Bar · {spell:3945} Heavy Blasting Powder · {spell:3973} Silver Contact · {item:2842} Silver Bar · {item:2838} Heavy Stone · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:4586} Graham Van Talen · {zone:1458} Undercity · {area:392} Ratchet · {spell:20220} Gnomish Engineering · {npc:7944} Tinkmaster Overspark · {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {item:4407} Accurate Scope · {npc:8126} Nixx Sprocketspring · {area:976} Gadgetzan · {item:10507} Solid Dynamite · {npc:2675} Explosive Sheep
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact · Mithril Tubes = {item:10559} Mithril Tube · Big Iron Bombs = {spell:3967} Big Iron Bomb
	["{spell:3967} is yellow at 191 (yellow 190, green 210, grey 230): about 27 crafts to 210. Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 74 {spell:3945} and 30 {spell:3973} (6 crafts) first. Use the 7 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "",

	-- Step 62: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "{skill:202} 210 配方",
	-- {skill:202} Engineering · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12596} (from 210)."] = "回到{skill:202}訓練師處：{spell:12596}（210起）。",

	-- Step 63: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512}練到 225",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:202} Engineering
	["{item:10512} is yellow at 210 (yellow 210, green 230, grey 250): about 19 crafts to 225. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Use the 19 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "",

	-- Step 64: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "專家級{skill:202}",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {item:3860} Mithril Bar · {item:7912} Solid Stone · {item:12359} Thorium Bar · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}); Horde {npc:8736} ({zone:1446}). The arrow picks the nearest of your faction. 225-300 takes about 2g 80s of recipes, plus 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047} to gather or buy."] = "",

	-- Step 65: Schematic: Thorium Widget
	-- {item:16042} Schematic: Thorium Widget · {item:15994} Thorium Widget · {skill:202} Engineering · {npc:5175} Gearcutter Cogspinner · {zone:1455} Ironforge · {npc:3413} Sovik · {zone:1454} Orgrimmar
	["{item:16042} teaches {item:15994} ({skill:202} 260) for 1g 20s. Sold by Alliance: {npc:5175} ({zone:1455}), limited stock; Horde: {npc:3413} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "",

	-- Step 66: Schematic: Thorium Tube
	-- {item:16047} Schematic: Thorium Tube · {item:16000} Thorium Tube · {skill:202} Engineering · {npc:260565} Kor'gar · {zone:2548} Riverglades · {npc:11185} Xizzer Fizzbolt · {zone:1452} Winterspring
	["{item:16047} teaches {item:16000} ({skill:202} 275) for 1g 60s. Sold by {npc:260565} ({zone:2548}) and {npc:11185} ({zone:1452}), limited stock."] = "{item:16047}可學會{item:16000}（需要{skill:202} 275），售價1金60銀。由{npc:260565}（{zone:2548}）和{npc:11185}（{zone:1452}）出售，數量有限。",

	-- Step 67: Engineering 225-300: Auction House
	-- {skill:202} Engineering
	["{skill:202} 225-300: Auction House"] = "{skill:202} 225-300：拍賣場",
	-- {item:3860} Mithril Bar · {item:7912} Solid Stone · {item:12359} Thorium Bar · {item:14047} Runecloth
	["What 225-300 takes that the Auction House sells: 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047}. The counts drop by what your bags, bank and mail hold."] = "225-300階段所需的材料中，拍賣場有賣的：118個{item:3860}、212個{item:7912}、156個{item:12359}和24個{item:14047}。數量會扣除你背包、銀行和郵件中已有的。",

	-- Step 68: Mithril Bar
	-- {item:3860} Mithril Bar · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {item:3858} Mithril Ore
	["118 {item:3860} for {item:10512} and {item:10513}: {skill:186}: smelt {item:3858}."] = "準備118個{item:3860}製作{item:10512}和{item:10513}：{skill:186}：熔煉{item:3858}。",

	-- Step 69: Solid Stone (Alliance)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "",

	-- Step 70: Solid Stone (Horde)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "",

	-- Step 71: Thorium Bar
	-- {item:12359} Thorium Bar · {item:15994} Thorium Widget · {item:16000} Thorium Tube · {skill:186} Mining · {item:10620} Thorium Ore
	["156 {item:12359} for {item:15994} and {item:16000}: {skill:186}: smelt {item:10620}."] = "準備156個{item:12359}製作{item:15994}和{item:16000}：{skill:186}：熔煉{item:10620}。",

	-- Step 72: Runecloth
	-- {item:14047} Runecloth · {item:15994} Thorium Widget
	["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it. Keep what you loot as you level, or take it from your bank."] = "為{item:15994}準備24個{item:14047}：45-60級的人型生物會掉落。練等時把撿到的留著，或從銀行取出。",

	-- Step 73: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512}練到 245",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 50 {item:10505} first. Use the 12 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby."] = "",

	-- Step 74: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "{skill:202} 245 配方",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} (from 245)."] = "回到{skill:202}訓練師處：{spell:12621}（245起）。",

	-- Step 75: Mithril Gyro-Shot to 265
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 265"] = "{item:10513}練到 265",
	-- {item:10513} Mithril Gyro-Shot · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:10513} is yellow at 245 (yellow 245, green 265, grey 285): about 28 crafts to 265. Each takes 2 {item:3860} and 2 {item:10505} and makes 200. Make the 56 {item:10505} first. Two Mithril Bars and two {item:10505} a craft. Needs an anvil nearby."] = "",

	-- Step 76: Thorium Widget to 287
	-- {item:15994} Thorium Widget
	["{item:15994} to 287"] = "{item:15994}練到 287",
	-- {item:15994} Thorium Widget · {item:12359} Thorium Bar · {item:14047} Runecloth
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:15994} is orange at 265 (yellow 280, green 290, grey 300): about 24 crafts to 287. Each takes 3 {item:12359} and 1 {item:14047}. Three Thorium Bars and a {item:14047} a craft; the widgets are parts for the later Thorium gadgets. Needs an anvil nearby."] = "",
	["from the recipe in your bags"] = "使用背包中的配方",

	-- Step 77: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000}練到 300",
	-- {item:16000} Thorium Tube · {item:12359} Thorium Bar · {skill:202} Engineering
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:16000} is orange at 287 (yellow 295, green 305, grey 315): about 14 crafts to 300. Each takes 6 {item:12359}. The schematic binds when picked up; six Thorium Bars a craft. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:202}"] = "初級{skill:202}",
	-- ["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "專家級需要角色等級 35 且{skill:202} 200；上限提高到 300。225-300 的材料總值約 67g。",
	-- ["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "回到{skill:202}訓練師處：{skill:202} 175 起可學{spell:12590}。",
	-- ["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "回到{skill:202}訓練師處：{skill:202} 45 起可學{spell:3922}。",
	-- ["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "回到{skill:202}訓練師處：{skill:202} 95 起可學{spell:3926}。",
	-- ["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "回到{skill:202}訓練師處：{skill:202} 125 起可學{spell:3942}。",
	-- ["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "高級需要角色等級 20 且{skill:202} 125；上限提高到 225。150-225 的材料總值約 15g。",
	-- ["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "中級需要角色等級 10 且{skill:202} 50；上限提高到 150。75-150 的材料總值約 3g 23s。",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在 Polestar 依你的等級和陣營挑選的刷怪點擊殺會掉落它的怪物。也可以在拍賣場購買。",
	-- ["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "橙色（每次製造加 1 點）到 20，黃色到 30，綠色到 40。",
	-- ["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "橙色（每次製造加 1 點）到 280，黃色到 290，綠色到 300。附近需要鐵砧。",
	-- ["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "橙色（每次製造加 1 點）到 295，黃色到 305，綠色到 315。附近需要鐵砧。{skill:202} 300 是傳承系統的里程碑。",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝皮：{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、鉗嘴龜、{npc:2384}、{npc:2354}（等級 18-30 的野獸會出產）；{skill:393}指南有規劃此路線。也可以在拍賣場購買。",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝皮：{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}（等級 18-30 的野獸會出產）；{skill:393}指南有規劃此路線。也可以在拍賣場購買。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "由剝皮、分解或其他專業製造取得：自行收集或在拍賣場購買。",
	-- ["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "教你{item:15994}（需要{skill:202} 260）。商人限量販售並會補貨；拍賣場也常有。",
	-- ["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "教你{item:16000}（需要{skill:202} 275）。商人限量販售並會補貨。",
	-- ["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "黃色到 110，綠色到 125：並非每次製造都會加點。附近需要鐵砧。",
	-- ["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "黃色到 130，綠色到 155：並非每次製造都會加點。附近需要鐵砧。",
	-- ["Yellow until 135, green until 145: not every craft gives a point."] = "黃色到 135，綠色到 145：並非每次製造都會加點。",
	-- ["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "黃色到 150，綠色到 175：並非每次製造都會加點。附近需要鐵砧。{skill:202} 150 是傳承系統的里程碑。",
	-- ["Yellow until 170, green until 195: not every craft gives a point."] = "黃色到 170，綠色到 195：並非每次製造都會加點。",
	-- ["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "黃色到 195，綠色到 215：並非每次製造都會加點。附近需要鐵砧。",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "黃色到 230，綠色到 250：並非每次製造都會加點。附近需要鐵砧。",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "黃色到 230，綠色到 250：並非每次製造都會加點。附近需要鐵砧。{skill:202} 225 是傳承系統的里程碑。",
	-- ["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "黃色到 265，綠色到 285：並非每次製造都會加點。附近需要鐵砧。",
	-- ["Yellow until 45, green until 60: not every craft gives a point."] = "黃色到 45，綠色到 60：並非每次製造都會加點。",
	-- ["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "黃色到 52，綠色到 60：並非每次製造都會加點。附近需要鐵砧。",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "黃色到 75，綠色到 90：並非每次製造都會加點。附近需要鐵砧。",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "黃色到 75，綠色到 90：並非每次製造都會加點。附近需要鐵砧。75 是初級上限。",
	-- ["Yellow until 90, green until 95: not every craft gives a point."] = "黃色到 90，綠色到 95：並非每次製造都會加點。",
	-- ["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "黃色到 95，綠色到 110：並非每次製造都會加點。附近需要鐵砧。",
	-- ["{item:10498} to 210"] = "{item:10498}練到 210",
	-- ["{item:14047} (Alliance)"] = "{item:14047}（聯盟）",
	-- ["{item:14047} (Horde)"] = "{item:14047}（部落）",
	-- ["{item:2592} (Alliance)"] = "{item:2592}（聯盟）",
	-- ["{item:2592} (Horde)"] = "{item:2592}（部落）",
	-- ["{item:2835} (Alliance)"] = "{item:2835}（聯盟）",
	-- ["{item:2835} (Horde)"] = "{item:2835}（部落）",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}來自{object:1731}（{skill:186}）；這是資料中最密集的區域。也可以在拍賣場購買。",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}來自{object:1732}（{skill:186}）；這是資料中最密集的區域。也可以在拍賣場購買。",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}來自{object:1735}（{skill:186}）；這是資料中最密集的區域。也可以在拍賣場購買。",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}：工具，請留在背包中",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}來自{object:2040}（{skill:186}）；這是資料中最密集的區域。也可以在拍賣場購買。",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "這裡的{npc:3263}（等級 19-20）會掉落。也可以在拍賣場購買。",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "這裡的{npc:6189}（等級 51-52）會掉落。也可以在拍賣場購買。",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "這裡的{npc:7027}（等級 56-57）會掉落。也可以在拍賣場購買。",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "這裡的{npc:98}（等級 17-18）會掉落。也可以在拍賣場購買。",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}：熔煉{item:10620}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}：熔煉{item:2770}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}：熔煉{item:2840}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}：熔煉{item:3575}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}：熔煉{item:3858}（或在拍賣場購買）",
	-- ["{skill:202} materials for 1-75"] = "{skill:202} 1-75 材料",
	-- ["{skill:202} materials for 150-225"] = "{skill:202} 150-225 材料",
	-- ["{skill:202} materials for 225-300"] = "{skill:202} 225-300 材料",
	-- ["{skill:202} materials for 75-150"] = "{skill:202} 75-150 材料",
	-- ["{skill:202} recipes at 139"] = "{skill:202} 139 配方",
	-- ["{skill:202} recipes at 95"] = "{skill:202} 95 配方",
	-- ["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202}可與升級同步進行。Forever 的傳承系統會在技能 150、225 和 300（中級、高級和專家級的上限）時獎勵製造專業，因此每個檢查點都很重要。1-75 的材料總值約 62s。",
	-- ["{spell:3920} to 45"] = "{spell:3920}練到 45",
	-- ["{spell:3923} to 75"] = "{spell:3923}練到 75",
	-- ["{spell:3923} to 80"] = "{spell:3923}練到 80",
	-- ["{spell:3926} to 111"] = "{spell:3926}練到 111",
	-- ["{spell:3929} to 95"] = "{spell:3929}練到 95",
	-- ["{spell:3937} to 125"] = "{spell:3937}練到 125",
	-- ["{spell:3942} to 150"] = "{spell:3942}練到 150",
}
