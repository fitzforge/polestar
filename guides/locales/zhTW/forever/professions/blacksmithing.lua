-- Chinese (traditional) (zhTW): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Blacksmithing
	-- {skill:164} Blacksmithing
	["Learn {skill:164}"] = "學習{skill:164}",
	-- {skill:164} Blacksmithing · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	-- was: ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "初級{skill:164}讓你在任何角色等級下花10銅把技能練到75。本陣營任意{skill:164}訓練師都教；箭頭會指向最近的一位。買一個{item:5956}（任何鍛造供應商）並與{skill:186}配合：{item:2835}和{item:2770}來自每個新手區域的銅礦脈。1-75大約花1銀的配方錢，外加286個{item:2835}，需自行採集或購買。"
	["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 195 {item:2835} to gather or buy."] = "",

	-- Step 2: Get Rough Stone
	-- {item:2835} Rough Stone
	["Get {item:2835}"] = "",
	-- {item:2835} Rough Stone · {skill:164} Blacksmithing · {spell:2660} Rough Sharpening Stone · {spell:3320} Rough Grinding Stone · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh · {zone:1429} Elwynn Forest · {zone:2521} Zephras Isle
	["You need 195 {item:2835} for {skill:164} 1-75: {spell:2660} and {spell:3320}. {skill:186}: {object:1731} (skill 1) in {zone:1426} (1-10), {zone:1429} (1-10) and {zone:2521} (1-15). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 3: Rough Sharpening Stone to 35
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 35"] = "{spell:2660}練到35",
	-- {spell:2660} Rough Sharpening Stone · {item:2835} Rough Stone
	["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35, up to 47 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "",

	-- Step 4: Blacksmithing recipes at 35
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 35"] = "{skill:164}35點的配方",
	-- {skill:164} Blacksmithing · {spell:3320} Rough Grinding Stone · {spell:1230171} Sharpening Wheel · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Back to a {skill:164} trainer: {spell:3320} (from 25, 1s). Also learn {spell:1230171} (1s): Forever's {skill:164} camp item, 1 {item:2835} and 1 {item:2840}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:164} quest from your starting area's camping guide (after The Great Outdoors) sends you to a blacksmithing trainer who teaches it free."] = "返回 {skill:164} 訓練師處：學習 {spell:3320}（25起，1銀幣）。同時學習 {spell:1230171}（1銀幣）：這是無限服的 {skill:164} 露營物品，需1塊 {item:2835} 和1塊 {item:2840}，在營地營火旁放置可獲得增益。起始地區露營指南中的“露營 101：{skill:164}”任務（在“廣闊天地”之後）會派你去找鍛造訓練師，可免費學會它。",

	-- Step 5: Rough Grinding Stone to 75
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 75"] = "{spell:3320}練到75",
	-- {spell:3320} Rough Grinding Stone · {item:2835} Rough Stone
	-- was: ["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320}在35時為橙色（45黃、65綠、85灰）：大約64次製作可到75。每次需要2個{item:2835}。每次兩個{item:2835}。磨石是後續圖紙的零件；多出來的賣給商人。"
	["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75, up to 74 for 9 players in 10 (the gathered materials above count that many). Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "",

	-- Step 6: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "中級{skill:164}",
	-- {skill:164} Blacksmithing · {npc:3136} Clarise Gnarltree · {zone:1431} Duskwood · {npc:252479} Daeann Steelwind · {zone:2521} Zephras Isle · {npc:10276} Rotgath Stonebeard · {zone:1455} Ironforge · {npc:5511} Therum Deepforge · {zone:1453} Stormwind City · {npc:276067} Angus Hammerhand · {zone:1420} Tirisfal Glades · {npc:4596} James Van Brunt · {zone:1458} Undercity · {npc:2998} Karn Stonehoof · {zone:1456} Thunder Bluff · {npc:1383} Snarl · {zone:1454} Orgrimmar · {npc:3478} Traugh · {zone:1413} The Barrens · {spell:2666} Runed Copper Belt · {spell:3326} Coarse Grinding Stone · {item:2319} Medium Leather · {item:2836} Coarse Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar
	-- was: ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "中級可將上限從75提高到150，費用5銀；需要{skill:164} 50和角色等級10，所以技能達到50後，任何一次經過都可以學。並非每位{skill:164}訓練師都會教：聯盟有{npc:3136}（{zone:1431}）、{npc:252479}（{zone:2521}）、{npc:10276}（{zone:1455}）和{npc:5511}（{zone:1453}）；部落有{npc:276067}（{zone:1420}）、{npc:252479}（{zone:2521}）、{npc:4596}（{zone:1458}）、{npc:2998}（{zone:1456}）、{npc:1383}（{zone:1454}）和{npc:3478}（{zone:1413}）。箭頭會選擇你陣營最近的一位。現在學習：{spell:2666}（技能45起，2銀）和{spell:3326}（技能50起，2銀50銅）。75-150約需19銀50銅的配方和18銅的商人材料，另需採集或購買256個{item:2836}、28個{item:2838}、210個{item:2840}和320個{item:2841}。"
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 12s of recipes and 5g 18c of vendor goods, plus 25 {item:2319}, 100 {item:2836}, 320 {item:2840} and 325 {item:2841} to gather or buy."] = "",

	-- Step 7: Blacksmithing 75-150: vendor goods
	-- {skill:164} Blacksmithing
	["{skill:164} 75-150: vendor goods"] = "{skill:164} 75-150：商人貨物",
	-- {item:3466} Strong Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:1286} Edna Mullby · {npc:5512} Kaita Deepforge · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {npc:3413} Sovik
	-- was: ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "一次買齊整個階段的用量：{item:5956}（工具：只需一個，留在揹包裡，18銅）；合計約18銅。箭頭會選擇本陣營最近的商人（{zone:1453}：{npc:5519}、{npc:1286}和{npc:5512}；{zone:1454}：{npc:3367}、{npc:5817}和{npc:3413}）。"
	["Buy the whole bracket's share in one go: 25 {item:3466} (5g) and {item:5956} (a tool: one, kept in your bags, 18c); about 5g 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "",
	["a tool, keep it in your bags"] = "一件工具，放在包裡",

	-- Step 8: Get Medium Leather
	-- {item:2319} Medium Leather
	["Get {item:2319}"] = "",
	-- {item:2319} Medium Leather · {skill:164} Blacksmithing · {item:7956} Bronze Warhammer · {skill:393} Skinning
	["You need 25 {item:2319} for {skill:164} 75-150: {item:7956}. {skill:393}: beasts of level 18-30. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 9: Get Coarse Stone
	-- {item:2836} Coarse Stone
	["Get {item:2836}"] = "",
	-- {item:2836} Coarse Stone · {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers · {skill:186} Mining · {object:1732} Tin Vein · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills · {zone:1437} Wetlands
	["You need 100 {item:2836} for {skill:164} 75-150: {spell:2672}. {skill:186}: {object:1732} (skill 65) in {zone:1440} (18-30), {zone:1424} (20-30) and {zone:1437} (20-30). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 10: Get Copper Bar
	-- {item:2840} Copper Bar
	["Get {item:2840}"] = "",
	-- {item:2840} Copper Bar · {skill:164} Blacksmithing · {spell:2666} Runed Copper Belt · {item:2770} Copper Ore · {skill:186} Mining
	["You need 320 {item:2840} for {skill:164} 75-150: {spell:2666}. Mine {item:2770} and smelt it at a forge ({skill:186} 1). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 11: Get Bronze Bar
	-- {item:2841} Bronze Bar
	["Get {item:2841}"] = "",
	-- {item:2841} Bronze Bar · {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers · {item:7956} Bronze Warhammer · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["You need 325 {item:2841} for {skill:164} 75-150: {spell:2672} and {item:7956}. {skill:186}: smelt {item:2840} and {item:3576}. Or buy them at the Auction House."] = "",

	-- Step 12: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666}練到100",
	-- {spell:2666} Runed Copper Belt · {item:2840} Copper Bar · {item:2770} Copper Ore · {item:5956} Blacksmith Hammer
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	-- was: ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666} 在83點時為橙色（85變黃，105變綠，125變灰）：製作約21次可到100。每次需要10塊 {item:2840}。無限服在45點即可學習 {spell:2666}；到85點前一直為橙色。每次製作消耗十塊銅錠：熔鍊你的 {item:2770}。附近需要有鐵砧。{item:5956} 是工具：留在揹包中。"
	["{spell:2666} is orange at 75 (yellow 85, green 105, grey 125): about 29 crafts to 100, up to 32 for 9 players in 10 (the gathered materials above count that many). Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "",

	-- Step 13: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "{skill:164}100點的配方",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s) and {spell:9985} (from 100, 2s 50c)."] = "",

	-- Step 14: Patterned Bronze Bracers to 125
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 125"] = "",
	-- {spell:2672} Patterned Bronze Bracers · {item:2841} Bronze Bar · {spell:3326} Coarse Grinding Stone · {item:2836} Coarse Stone
	-- plural, as words: Coarse Grinding Stones = {spell:3326} Coarse Grinding Stone · Tin Veins = {object:1732} Tin Vein
	["{spell:2672} is orange at 100 (yellow 125, green 140, grey 155): about 25 crafts to 125, a point every craft. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 50 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby."] = "",

	-- Step 15: Bronze Warhammer to 150
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 150"] = "",
	-- {item:7956} Bronze Warhammer · {item:2841} Bronze Bar · {item:3466} Strong Flux · {item:2319} Medium Leather · {skill:164} Blacksmithing
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["{item:7956} is orange at 125 (yellow 155, green 170, grey 185): about 25 crafts to 150, a point every craft. Each takes 8 {item:2841}, 1 {item:3466} and 1 {item:2319}. Eight Bronze Bars, a {item:3466} (blacksmithing suppliers) and a {item:2319} a craft; every Journeyman trainer in the capitals teaches it from 100. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "",

	-- Step 16: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "高級{skill:164}",
	-- {skill:164} Blacksmithing · {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:3501} Green Iron Bracers · {spell:3337} Heavy Grinding Stone · {item:2838} Heavy Stone · {item:3575} Iron Bar · {item:3859} Steel Bar · {item:3860} Mithril Bar · {item:4304} Thick Leather · {item:4338} Mageweave Cloth · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). This route trains it at {npc:4258} ({zone:1455}) for the Alliance and {npc:3355} ({zone:1454}) for the Horde, who also teach the recipes of 150-225: one trainer for every visit. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 60 {item:2838}, 186 {item:3575}, 302 {item:3859}, 230 {item:3860}, 236 {item:4304}, 60 {item:4338} and 144 {item:7912} to gather or buy."] = "",

	-- Step 17: Blacksmithing 150-225: vendor goods
	-- {skill:164} Blacksmithing
	["{skill:164} 150-225: vendor goods"] = "{skill:164} 150-225：商人貨物",
	-- {item:2605} Green Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {item:3859} Steel Bar · {skill:186} Mining · {item:3575} Iron Bar
	-- was: ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "一次買齊這一段所需的全部：28個{item:2605}（28銀）；總共約28銀。箭頭會指向本陣營最近的賣家（{zone:1453}：{npc:1347}、{npc:1286}和{npc:5565}；{zone:1454}：{npc:3364}、{npc:3367}和{npc:5817}）。如果你自己熔鍊那195個{item:3859}（{skill:186} 165：每個需一個{item:3575}和一塊煤），還要買195塊煤（9金75銀，雜貨和鍛造供應商）；若直接買錠則跳過。"
	["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: Borya, {npc:3367} and {npc:5817}). If you smelt the 302 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 302 Coal too (15g 10s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "",

	-- Step 18: Get Heavy Stone
	-- {item:2838} Heavy Stone
	["Get {item:2838}"] = "",
	-- {item:2838} Heavy Stone · {skill:164} Blacksmithing · {item:6040} Golden Scale Bracers · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:2548} Riverglades
	["You need 60 {item:2838} for {skill:164} 150-225: {item:6040}. {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:2548} (38-47). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 19: Get Iron Bar
	-- {item:3575} Iron Bar
	["Get {item:3575}"] = "",
	-- {item:3575} Iron Bar · {skill:164} Blacksmithing · {spell:3501} Green Iron Bracers · {item:2772} Iron Ore · {skill:186} Mining
	["You need 186 {item:3575} for {skill:164} 150-225: {spell:3501}. Mine {item:2772} and smelt it at a forge ({skill:186} 125). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 20: Get Steel Bar
	-- {item:3859} Steel Bar
	["Get {item:3859}"] = "",
	-- {item:3859} Steel Bar · {skill:164} Blacksmithing · {item:6040} Golden Scale Bracers · {item:7922} Steel Plate Helm · {item:2772} Iron Ore · {skill:186} Mining
	["You need 302 {item:3859} for {skill:164} 150-225: {item:6040} and {item:7922}. Smelting makes them from {item:2772} ({skill:186} 165): about 302 {item:2772} for 302. The loops below are for the {item:2772}; the {skill:186} guide's loops give the rest. The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 21: Get Mithril Bar
	-- {item:3860} Mithril Bar
	["Get {item:3860}"] = "",
	-- {item:3860} Mithril Bar · {skill:164} Blacksmithing · {item:7919} Heavy Mithril Gauntlet · {item:7933} Heavy Mithril Boots · {item:3858} Mithril Ore · {skill:186} Mining
	["You need 230 {item:3860} for {skill:164} 150-225: {item:7919} and {item:7933}. Mine {item:3858} and smelt it at a forge ({skill:186} 175). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 22: Get Thick Leather
	-- {item:4304} Thick Leather
	["Get {item:4304}"] = "",
	-- {item:4304} Thick Leather · {skill:164} Blacksmithing · {item:7933} Heavy Mithril Boots · {item:7945} Big Black Mace · {skill:393} Skinning
	["You need 236 {item:4304} for {skill:164} 150-225: {item:7933} and {item:7945} (196 of them for 225-300: get them all now). {skill:393}: beasts of level 38-50. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 23: Get Mageweave Cloth
	-- {item:4338} Mageweave Cloth
	["Get {item:4338}"] = "",
	-- {item:4338} Mageweave Cloth · {skill:164} Blacksmithing · {item:7919} Heavy Mithril Gauntlet
	["You need 60 {item:4338} for {skill:164} 150-225: {item:7919}. Humanoids of level 35-50 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:4338} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 24: Get Solid Stone
	-- {item:7912} Solid Stone
	["Get {item:7912}"] = "",
	-- {item:7912} Solid Stone · {skill:164} Blacksmithing · {item:7922} Steel Plate Helm · {item:7945} Big Black Mace · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["You need 144 {item:7912} for {skill:164} 150-225: {item:7922} and {item:7945} (72 of them for 225-300: get them all now). {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 25: Green Iron Bracers to 175
	-- {spell:3501} Green Iron Bracers
	["{spell:3501} to 175"] = "{spell:3501} 到175",
	-- {spell:3501} Green Iron Bracers · {item:3575} Iron Bar · {item:2605} Green Dye
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	-- was: ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501}在技能150時為橙色（165變黃，177變綠，190變灰）：約製作28次可到175。每次需要6個{item:3575}和1個{item:2605}。也就是每次6塊鐵錠和1個{item:2605}；{item:2605}可向裁縫、制皮及雜貨供應商購買。無限中到165前都是橙色，因此前15次製作每次都漲一點。附近需要有鐵砧。"
	["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175, up to 31 for 9 players in 10 (the gathered materials above count that many). Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "",

	-- Step 26: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "{skill:164}175點的配方",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:7223} Golden Scale Bracers · {spell:9920} Solid Grinding Stone
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:7223} (from 160) and {spell:9920} (from 175)."] = "",

	-- Step 27: Golden Scale Bracers to 185
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 185"] = "",
	-- {item:6040} Golden Scale Bracers · {item:3859} Steel Bar · {spell:3337} Heavy Grinding Stone · {item:3575} Iron Bar · {skill:186} Mining
	-- plural, as words: Steel Bars = {item:3859} Steel Bar · Heavy Grinding Stones = {spell:3337} Heavy Grinding Stone
	["{item:6040} is orange at 175 (yellow 185, green 197, grey 210): about 10 crafts to 185, a point every craft. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 20 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Needs an anvil nearby."] = "",

	-- Step 28: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "{skill:164}185點的配方",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:9928} Heavy Mithril Gauntlet
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:9928} (from 180)."] = "",

	-- Step 29: Heavy Mithril Gauntlet to 200
	-- {item:7919} Heavy Mithril Gauntlet
	["{item:7919} to 200"] = "",
	-- {item:7919} Heavy Mithril Gauntlet · {item:3860} Mithril Bar · {item:4338} Mageweave Cloth · {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:7919} is orange at 185 (yellow 200, green 210, grey 220): about 15 crafts to 200, a point every craft. Each takes 6 {item:3860} and 4 {item:4338}. Six Mithril Bars and four {item:4338} a craft; {npc:4258} ({zone:1455}) and {npc:3355} ({zone:1454}) teach it from 180. Needs an anvil nearby."] = "",

	-- Step 30: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "",
	-- {npc:4258} Bengus Deepforge · {zone:1455} Ironforge · {npc:3355} Saru Steelfury · {zone:1454} Orgrimmar · {spell:9935} Steel Plate Helm
	["Back to {npc:4258} ({zone:1455}) (Alliance) or {npc:3355} ({zone:1454}) (Horde): {spell:9935} (from 190)."] = "",

	-- Step 31: Steel Plate Helm to 215
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 215"] = "",
	-- {item:7922} Steel Plate Helm · {item:3859} Steel Bar · {item:7966} Solid Grinding Stone · {npc:5164} Grumnus Steelshaper · {zone:1455} Ironforge · {npc:11177} Okothos Ironrager · {zone:1454} Orgrimmar · {spell:9788} Armorsmith · {item:7936} Ornate Mithril Boots · {item:7935} Ornate Mithril Breastplate · {npc:11146} Ironus Coldsteel · {npc:11178} Borgosh Corebender · {item:3853} Moonsteel Broadsword · {npc:2482} Zarena Cromwind · {area:35} Booty Bay · {item:3855} Massive Iron Axe
	-- plural, as words: Ornate Mithril Helms = {item:7937} Ornate Mithril Helm · Moonsteel Broadswords = {item:3853} Moonsteel Broadsword · Massive Iron Axes = {item:3855} Massive Iron Axe · Heavy Mithril Axes = {item:7940} Heavy Mithril Axe · Big Black Maces = {item:7945} Big Black Mace
	["{item:7922} is orange at 200 (yellow 210, green 220, grey 230): about 16 crafts to 215, up to 18 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:3859} and 1 {item:7966}. Make the 16 {item:7966} first. The trainer teaches it, and it is the cheapest way through these points in the data. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "",

	-- Step 32: Blacksmithing recipes at 215
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 215"] = "",
	-- {spell:9968} Heavy Mithril Boots · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {skill:164} Blacksmithing
	-- was: ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959}（205起）只有專家級訓練師會教：聯盟{npc:2836}（{zone:1434}）；部落{npc:2836}（{zone:1434}）。如果你已達35級（需要{skill:164} 200），現在就可以在那裡學習專家級，省去225時再跑一趟。"
	["{spell:9968} (from 210) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "",

	-- Step 33: Heavy Mithril Boots to 225
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 225"] = "",
	-- {item:7933} Heavy Mithril Boots · {item:3860} Mithril Bar · {item:4304} Thick Leather · {skill:164} Blacksmithing
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar · Mithril Deposits = {object:2040} Mithril Deposit
	["{item:7933} is orange at 215 (yellow 230, green 240, grey 250): about 10 crafts to 225, a point every craft. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "",

	-- Step 34: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "專家級{skill:164}",
	-- {skill:164} Blacksmithing · {npc:2836} Brikk Keencraft · {zone:1434} Stranglethorn Vale · {spell:16640} Dense Weightstone · {spell:10001} Big Black Mace · {spell:16639} Dense Grinding Stone · {item:1210} Shadowgem · {item:3860} Mithril Bar · {item:7971} Black Pearl · {item:12365} Dense Stone · {npc:11278} Magnus Frostwake · {item:7909} Aquamarine · {item:7910} Star Ruby · {item:8170} Rugged Leather · {item:12359} Thorium Bar · {item:12799} Large Opal · {item:7077} Heart of Fire
	["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). This route trains it at {npc:2836} ({zone:1434}) for the Alliance and {npc:2836} ({zone:1434}) for the Horde, who also teach the recipes of 225-300: one trainer for every visit. Learn now: {spell:16640} (from 225), {spell:10001} (from 205) and {spell:16639} (from 225). 225-300 takes 72 {item:1210}, 848 {item:3860}, 18 {item:7971} and 24 {item:12365} to gather or buy. From 250 the route splits: with {npc:11278}'s plans, about 55 more crafts and 22 {item:7909}, 22 {item:7910}, 212 {item:8170}, 2168 {item:12359}, 808 {item:12365} and 10 {item:12799}; with Auction House plans, about 55 crafts and 196 {item:7077} and 806 {item:12359}."] = "",

	-- Step 35: Get Shadowgem
	-- {item:1210} Shadowgem
	["Get {item:1210}"] = "",
	-- {item:1210} Shadowgem · {skill:164} Blacksmithing · {item:7945} Big Black Mace · {object:1731} Copper Vein · {object:1732} Tin Vein · {object:1733} Silver Vein
	["You need 72 {item:1210} for {skill:164} 225-300: {item:7945}. {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 36: Get Mithril Bar
	-- {item:3860} Mithril Bar · {skill:164} Blacksmithing · {item:7933} Heavy Mithril Boots · {item:7945} Big Black Mace · {item:3858} Mithril Ore · {skill:186} Mining
	["You need 848 {item:3860} for {skill:164} 225-300: {item:7933} and {item:7945}. Mine {item:3858} and smelt it at a forge ({skill:186} 175). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 37: Get Dense Stone
	-- {item:12365} Dense Stone
	["Get {item:12365}"] = "",
	-- {item:12365} Dense Stone · {skill:164} Blacksmithing · {item:12643} Dense Weightstone · {skill:186} Mining · {object:324} Small Thorium Vein · {zone:1448} Felwood · {zone:1451} Silithus · {zone:1452} Winterspring
	["You need 24 {item:12365} for {skill:164} 225-300: {item:12643}. {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 38: Blacksmithing 225-300: Auction House
	-- {skill:164} Blacksmithing
	["{skill:164} 225-300: Auction House"] = "{skill:164} 225-300：拍賣場",
	-- {item:7971} Black Pearl
	["What 225-300 takes that the Auction House sells and no step above farms: 18 {item:7971}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 39: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "{item:12643}練到235",
	-- {item:12643} Dense Weightstone · {item:12365} Dense Stone
	["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235, up to 24 for 9 players in 10 (the gathered materials above count that many). Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "",

	-- Step 40: Heavy Mithril Boots to 247
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 247"] = "{item:7933}練到247",
	-- {item:7933} Heavy Mithril Boots · {item:3860} Mithril Bar · {item:4304} Thick Leather
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar · Mithril Deposits = {object:2040} Mithril Deposit
	["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247, up to 40 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby. If you got here without learning {item:7933}, learn it now: an earlier step teaches it."] = "",

	-- Step 41: Big Black Mace to 250
	-- {item:7945} Big Black Mace
	["{item:7945} to 250"] = "{item:7945} 到250",
	-- {item:7945} Big Black Mace · {item:3860} Mithril Bar · {item:7971} Black Pearl · {item:1210} Shadowgem · {item:7966} Solid Grinding Stone · {item:4304} Thick Leather · {object:1732} Tin Vein
	-- plural, as words: Shadowgems = {item:1210} Shadowgem
	-- was: ["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "{item:7945}在247時為綠色（230變黃，242變綠，255變灰）：約製作11次可升至250。每次需要16個{item:3860}、1個{item:7971}、4個{item:1210}、1個{item:7966}和2個{item:4304}。先製作11個{item:7966}。247-250只需製作約11次，但每次都要四顆暗影石（約一百個{object:1732}出一顆）和一個{item:7971}：除非揹包已有，否則去拍賣行購買。附近需要有鐵砧。{item:7971}（225-300階段需要11個）：{item:7971}是稀有掉落（沒有任何怪物的掉率能達到五十分之一）：去拍賣行買，或留著找到的。"
	["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250, up to 18 for 9 players in 10 (the gathered materials above count that many). Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (18 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find. If you got here without learning {item:7966}, learn it now: an earlier step teaches it."] = "",

	-- Step 42: Blacksmithing 250: Magnus Frostwake's plans
	-- {skill:164} Blacksmithing · {npc:11278} Magnus Frostwake
	["{skill:164} 250: {npc:11278}'s plans"] = "",
	-- {npc:11278} Magnus Frostwake · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:12819} Plans: Ornate Thorium Handaxe · {item:12823} Plans: Huge Thorium Battleaxe · {item:13544} Spectral Essence · {npc:11216} Eva Sarkhoff · {area:2057} Scholomance · {npc:10506} Kirtonos the Herald · {item:12365} Dense Stone
	["From 250 the route has two ways. {npc:11278} in {area:2298} ({zone:1422}) sells {item:12819} and {item:12823} (unlimited stock; they bind when picked up), but he is a ghost you see only with the {item:13544} on (put it on inside {area:2298}): the reward of {npc:11216}'s {area:2057} chain that ends with {npc:10506}, level 55 and a dungeon group. With the battleaxe plans learned, the steps after this take you to 300 on them. Without them, skip this step: the next steps go on with Radiant plans from the Auction House (world drops that do not bind), whose crafts take Hearts of Fire instead of {item:12365}."] = "",

	-- Step 43: Get Aquamarine
	-- {item:7909} Aquamarine
	["Get {item:7909}"] = "",
	-- {item:7909} Aquamarine · {skill:164} Blacksmithing · {quest:7654} Imperial Plate Boots · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	["You need 22 {item:7909} for {skill:164} 250-300: {quest:7654}. {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 44: Get Star Ruby
	-- {item:7910} Star Ruby
	["Get {item:7910}"] = "",
	-- {item:7910} Star Ruby · {skill:164} Blacksmithing · {quest:7654} Imperial Plate Boots · {object:2047} Truesilver Deposit · {object:123309} Ooze Covered Truesilver Deposit
	["You need 22 {item:7910} for {skill:164} 250-300: {quest:7654}. {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 45: Get Rugged Leather
	-- {item:8170} Rugged Leather
	["Get {item:8170}"] = "",
	-- {item:8170} Rugged Leather · {skill:164} Blacksmithing · {item:12773} Ornate Thorium Handaxe · {item:12775} Huge Thorium Battleaxe · {skill:393} Skinning
	["You need 212 {item:8170} for {skill:164} 250-300: {item:12773} and {item:12775}. {skill:393}: beasts of level 48-60. The arrow takes the {skill:393} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 46: Get Thorium Bar
	-- {item:12359} Thorium Bar
	["Get {item:12359}"] = "",
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12773} Ornate Thorium Handaxe · {item:12775} Huge Thorium Battleaxe · {quest:7654} Imperial Plate Boots · {item:10620} Thorium Ore · {skill:186} Mining
	["You need 2168 {item:12359} for {skill:164} 250-300: {item:12773}, {item:12775} and {quest:7654}. Mine {item:10620} and smelt it at a forge ({skill:186} 250). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 47: Get Dense Stone
	-- {item:12365} Dense Stone · {skill:164} Blacksmithing · {item:12773} Ornate Thorium Handaxe · {item:12775} Huge Thorium Battleaxe · {skill:186} Mining · {object:324} Small Thorium Vein · {zone:1448} Felwood · {zone:1451} Silithus · {zone:1452} Winterspring
	["You need 808 {item:12365} for {skill:164} 250-300: {item:12773} and {item:12775}. {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 48: Get Large Opal
	-- {item:12799} Large Opal
	["Get {item:12799}"] = "",
	-- {item:12799} Large Opal · {skill:164} Blacksmithing · {item:12773} Ornate Thorium Handaxe · {object:175404} Rich Thorium Vein · {object:177388} Ooze Covered Rich Thorium Vein · {object:180215} Hakkari Thorium Vein
	-- was: ["10 {item:12799} for {item:12773}: {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining."] = "準備10個{item:12799}製作{item:12773}：大約每143個{object:175404}、{object:177388}或{object:180215}會出現一個{item:12799}：採礦時把找到的留著。"
	["You need 10 {item:12799} for {skill:164} 250-300: {item:12773}. {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining. Or buy them at the Auction House."] = "",

	-- Step 49: Ornate Thorium Handaxe to 255
	-- {item:12773} Ornate Thorium Handaxe
	["{item:12773} to 255"] = "{item:12773} 到255",
	-- {item:12773} Ornate Thorium Handaxe · {item:12359} Thorium Bar · {item:12799} Large Opal · {item:12644} Dense Grinding Stone · {item:8170} Rugged Leather
	-- was: ["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby."] = "{item:12773} 在技能 250 時為橙色（275 變黃、287 變綠、300 變灰）：約製作 5 次可到 255，每次必漲一點。每次需要 20 個 {item:12359}、2 個 {item:12799}、2 個 {item:12644} 和 4 個 {item:8170}。先製作 10 個 {item:12644}。{item:12799} 大約每 130 處瑟銀礦脈才出一個：去拍賣行買十個。只製作五次，到 255 後就能使用戰斧設計圖。附近需要鐵砧。"
	["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby. If you got here without learning {item:12644}, learn it now: an earlier step teaches it."] = "",

	-- Step 50: Huge Thorium Battleaxe to 285
	-- {item:12775} Huge Thorium Battleaxe
	["{item:12775} to 285"] = "{item:12775}練到285",
	-- {item:12775} Huge Thorium Battleaxe · {item:12359} Thorium Bar · {item:12644} Dense Grinding Stone · {item:8170} Rugged Leather · {quest:7654} Imperial Plate Boots
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Dense Grinding Stones = {item:12644} Dense Grinding Stone
	["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285, up to 32 for 9 players in 10 (the gathered materials above count that many). Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Needs an anvil nearby. If you got here without learning {item:12644}, learn it now: an earlier step teaches it."] = "",

	-- Step 51: Plans: Imperial Plate Boots
	-- {npc:14567} Derotain Mudsipper · {zone:1446} Tanaris · {item:12700} Plans: Imperial Plate Boots · {skill:164} Blacksmithing · {item:12359} Thorium Bar · {quest:7654} Imperial Plate Boots · {quest:7652} A Blue Light Bargain
	["{npc:14567} ({zone:1446}) trades {item:12700} ({skill:164} 270) for 40 {item:12359} in {quest:7654}, which needs {skill:164} 265 and character level 50; take {quest:7652} first (it asks for nothing). The plans bind when picked up."] = "{npc:14567}（{zone:1446}）在{quest:7654}中以40個{item:12359}換取{item:12700}（{skill:164} 270），該任務需要{skill:164} 265和角色50級；先接{quest:7652}（它不要求任何東西）。圖紙拾取即繫結。",

	-- Step 52: Imperial Plate Boots to 300
	-- {item:12426} Imperial Plate Boots
	["{item:12426} to 300"] = "{item:12426} 到300",
	-- {item:12426} Imperial Plate Boots · {item:12359} Thorium Bar · {item:7910} Star Ruby · {item:7909} Aquamarine · {npc:14567} Derotain Mudsipper · {skill:164} Blacksmithing
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Huge Thorium Battleaxes = {item:12775} Huge Thorium Battleaxe
	-- was: ["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "{item:12426}在285時為橙色（290變黃，300變綠，310變灰）：約製作19次可升至300。每次需要34個{item:12359}、1個{item:7910}和1個{item:7909}。每次約用34塊瑟銀錠，而戰斧要40塊，還要砂輪；此配方到290前都是橙色。角色等級低於50時，{npc:14567}不會提供任務：改為繼續製作巨型瑟銀戰斧至300（292前為黃色，305變灰：約需兩倍瑟銀錠）。附近需要有鐵砧。{skill:164}300是傳承系統的里程碑。"
	["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300, up to 22 for 9 players in 10 (the gathered materials above count that many). Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "",
	["from the recipe in your bags"] = "使用背包裡的配方",

	-- Step 53: Get Heart of Fire
	-- {item:7077} Heart of Fire
	["Get {item:7077}"] = "",
	-- {item:7077} Heart of Fire · {skill:164} Blacksmithing · {item:12416} Radiant Belt · {item:12419} Radiant Boots · {item:12420} Radiant Leggings · {npc:9878} Entropic Beast · {npc:6520} Scorching Elemental · {npc:5855} Magma Elemental
	["You need 196 {item:7077} for {skill:164} 250-300: {item:12416}, {item:12419} and {item:12420}. {item:7077} drops most from {npc:9878}, {npc:6520} and {npc:5855}, among others. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:7077} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 54: Get Thorium Bar
	-- {item:12359} Thorium Bar · {skill:164} Blacksmithing · {item:12416} Radiant Belt · {item:12419} Radiant Boots · {item:12420} Radiant Leggings · {item:10620} Thorium Ore · {skill:186} Mining
	["You need 806 {item:12359} for {skill:164} 250-300: {item:12416}, {item:12419} and {item:12420}. Mine {item:10620} and smelt it at a forge ({skill:186} 250). The arrow takes the {skill:186} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House."] = "",

	-- Step 55: Blacksmithing 250-300: Auction House
	-- {skill:164} Blacksmithing
	["{skill:164} 250-300: Auction House"] = "",
	-- {item:12685} Plans: Radiant Belt · {item:12697} Plans: Radiant Boots · {item:12713} Plans: Radiant Leggings
	["What 250-300 takes that the Auction House sells and no step above farms: a {item:12685}, a {item:12697} and a {item:12713}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 56: Radiant Belt to 265
	-- {item:12416} Radiant Belt
	["{item:12416} to 265"] = "",
	-- {item:12416} Radiant Belt · {item:12359} Thorium Bar · {item:7077} Heart of Fire · {item:12685} Plans: Radiant Belt
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12416} is orange at 250 (yellow 255, green 265, grey 275): about 19 crafts to 265, up to 22 for 9 players in 10 (the gathered materials above count that many). Each takes 10 {item:12359} and 2 {item:7077}. Its pattern ({item:12685}) drops from mobs all over the world and does not bind: buy it at the Auction House. Ten Thorium Bars and two Hearts of Fire a craft; orange to 255. Needs an anvil nearby."] = "",
	["from the pattern bought at the Auction House"] = "",

	-- Step 57: Radiant Boots to 291
	-- {item:12419} Radiant Boots
	["{item:12419} to 291"] = "",
	-- {item:12419} Radiant Boots · {item:12359} Thorium Bar · {item:7077} Heart of Fire · {item:12697} Plans: Radiant Boots
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:12419} is orange at 265 (yellow 285, green 295, grey 305): about 27 crafts to 291, up to 29 for 9 players in 10 (the gathered materials above count that many). Each takes 14 {item:12359} and 4 {item:7077}. Its pattern ({item:12697}) drops from mobs all over the world and does not bind: buy it at the Auction House. Fourteen Thorium Bars and four Hearts of Fire a craft; orange to 285. Needs an anvil nearby."] = "",

	-- Step 58: Radiant Leggings to 300
	-- {item:12420} Radiant Leggings
	["{item:12420} to 300"] = "",
	-- {item:12420} Radiant Leggings · {item:12359} Thorium Bar · {item:7077} Heart of Fire · {item:12713} Plans: Radiant Leggings · {skill:164} Blacksmithing
	["{item:12420} is orange at 291 (yellow 300, green 310, grey 320): about 9 crafts to 300, a point every craft. Each takes 20 {item:12359} and 4 {item:7077}. Its pattern ({item:12713}) drops from mobs all over the world and does not bind: buy it at the Auction House. The last points: buy the plans when you reach 280; until then the boots carry you. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["10 {item:12799} for {item:12773}: {item:12799} turns up in about one {object:175404}, {object:177388} or {object:180215} in 143: keep the ones you find while mining."] = "準備10個{item:12799}製作{item:12773}：大約每143個{object:175404}、{object:177388}或{object:180215}會出現一個{item:12799}：採礦時把找到的留著。",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "為 {item:7933} 和 {item:7945} 準備 142 個 {item:4304}：透過 {skill:393} 從 38-50 級野獸身上獲取。在這裡剝取 {npc:2729}、{npc:2730}、{npc:2732} 和 {npc:2734}（38-50 級）的皮；{skill:393} 指南會提供路線。",
	-- ["142 {item:4304} for {item:7933} and {item:7945}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "準備142個{item:4304}製作{item:7933}和{item:7945}：{skill:393}：剝取38-50級野獸。在這裡剝取{npc:5292}、{npc:5300}、{npc:5304}、{npc:5272}、{npc:5260}、{npc:5262}、{npc:5268}、{npc:5274}、{npc:5287}、{npc:5286}和{npc:5296}（38-50級）；{skill:393}指南有對應路線。",
	-- ["168 {item:3575} for {spell:3501}: {skill:186}: smelt {item:2772}."] = "準備168個{item:3575}製作{spell:3501}：{skill:186}：熔煉{item:2772}。",
	-- ["19 {item:7909} for {quest:7654}: {item:7909} turns up in about one {object:2047} or {object:123309} in 500: keep the ones you find while mining."] = "準備19個{item:7909}製作{quest:7654}：大約每500個{object:2047}或{object:123309}會出現一個{item:7909}：採礦時把找到的留著。",
	-- ["19 {item:7910} for {quest:7654}: {item:7910} turns up in about one {object:2047} or {object:123309} in 143: keep the ones you find while mining."] = "準備19個{item:7910}製作{quest:7654}：大約每143個{object:2047}或{object:123309}會出現一個{item:7910}：採礦時把找到的留著。",
	-- ["195 {item:3859} for {item:6040}: {skill:186}: smelt {item:3575} and Coal."] = "準備195個{item:3859}製作{item:6040}：{skill:186}：熔煉{item:3575}和煤。",
	-- ["2026 {item:12359} for {item:12773}, {item:12775} and {quest:7654}: {skill:186}: smelt {item:10620}."] = "準備2026個{item:12359}製作{item:12773}、{item:12775}和{quest:7654}：{skill:186}：熔煉{item:10620}。",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "準備 206 個 {item:8170}，用於 {item:12773} 和 {item:12775}：透過 {skill:393} 剝取 48-60 級野獸。在這裡剝取 {npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378} 和 {npc:6377}（48-60 級）；{skill:393} 指南提供對應路線。",
	-- ["206 {item:8170} for {item:12773} and {item:12775}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "準備206個{item:8170}製作{item:12773}和{item:12775}：{skill:393}：剝取48-60級野獸。在這裡剝取{npc:8598}、瘟疫犬和{npc:8596}（48-60級）的皮；{skill:393}指南有對應路線。",
	-- ["210 {item:2840} for {spell:2666}: {skill:186}: smelt {item:2770}."] = "準備210個{item:2840}製作{spell:2666}：{skill:186}：熔煉{item:2770}。",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "為 {item:6040} 準備234塊 {item:2838}：{skill:186}：開採 {zone:1417}（30-40級）、{zone:1434}（30-45級）和 {zone:1443}（30-40級）的 {object:1735}（技能125）。已標記 {zone:1417} 中 {object:1735} 最密集的區域。",
	-- ["234 {item:2838} for {item:6040}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "為{item:6040}準備234個{item:2838}：透過{skill:186}在{zone:1441}（25-35級）、{zone:1417}（30-40級）和{zone:1434}（30-45級）開採{object:1735}（需要技能125）。已標記{zone:1441}中{object:1735}最密集的區域。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "為 {spell:2672} 準備256個 {item:2836}：{skill:186}：開採 {object:1732}（技能65）。已標出 {zone:1413} 中 {object:1732} 最密集的礦點群。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "為 {spell:2672} 準備256個 {item:2836}：{skill:186}：開採 {object:1732}（技能65）。已標出 {zone:1421} 中 {object:1732} 最密集的礦點群。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "為 {spell:2672} 準備256個 {item:2836}：{skill:186}：開採 {object:1732}（技能65）。已標出 {zone:1432} 中 {object:1732} 最密集的礦點群。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "為 {spell:2672} 準備256個 {item:2836}：{skill:186}：開採 {object:1732}（技能65）。已標出 {zone:1436} 中 {object:1732} 最密集的礦點群。",
	-- ["256 {item:2836} for {spell:2672}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "為 {spell:2672} 準備256個 {item:2836}：{skill:186}：開採 {object:1732}（技能65）。已標出 {zone:1439} 中 {object:1732} 最密集的礦點群。",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "為 {spell:2674} 準備 28 個 {item:2838}：透過 {skill:186} 開採 {object:1735}（需要技能 125）。已標記 {zone:1413} 中 {object:1735} 最密集的位置。",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "為 {spell:2674} 準備 28 個 {item:2838}：透過 {skill:186} 開採 {object:1735}（需要技能 125）。已標記 {zone:1417} 中 {object:1735} 最密集的位置。",
	-- ["28 {item:2838} for {spell:2674}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "為 {spell:2674} 準備 28 個 {item:2838}：透過 {skill:186} 開採 {object:1735}（需要技能 125）。已標記 {zone:1440} 中 {object:1735} 最密集的位置。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "為 {spell:2660} 和 {spell:3320} 準備286個 {item:2835}（其中116個用於75-150階段：現在就全部採好）：{skill:186}：開採 {object:1731}（技能1）。已標出 {zone:1411} 中 {object:1731} 最密集的礦點群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "為 {spell:2660} 和 {spell:3320} 準備286個 {item:2835}（其中116個用於75-150階段：現在就全部採好）：{skill:186}：開採 {object:1731}（技能1）。已標出 {zone:1412} 中 {object:1731} 最密集的礦點群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "為 {spell:2660} 和 {spell:3320} 準備286個 {item:2835}（其中116個用於75-150階段：現在就全部採好）：{skill:186}：開採 {object:1731}（技能1）。已標出 {zone:1420} 中 {object:1731} 最密集的礦點群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "為 {spell:2660} 和 {spell:3320} 準備286個 {item:2835}（其中116個用於75-150階段：現在就全部採好）：{skill:186}：開採 {object:1731}（技能1）。已標出 {zone:1426} 中 {object:1731} 最密集的礦點群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "為 {spell:2660} 和 {spell:3320} 準備286個 {item:2835}（其中116個用於75-150階段：現在就全部採好）：{skill:186}：開採 {object:1731}（技能1）。已標出 {zone:1429} 中 {object:1731} 最密集的礦點群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "為 {spell:2660} 和 {spell:3320} 準備286個 {item:2835}（其中116個用於75-150階段：現在就全部採好）：{skill:186}：開採 {object:1731}（技能1）。已標出 {zone:1439} 中 {object:1731} 最密集的礦點群。",
	-- ["286 {item:2835} for {spell:2660} and {spell:3320} (116 of them for 75-150: pick them all now): {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "為 {spell:2660} 和 {spell:3320} 準備286個 {item:2835}（其中116個用於75-150階段：現在就全部採好）：{skill:186}：開採 {object:1731}（技能1）。已標出 {zone:2521} 中 {object:1731} 最密集的礦點群。",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "為 {item:7964} 準備30塊 {item:7912}：{skill:186}：開採 {zone:1434}（30-45級）、{zone:1425}（40-50級）和 {zone:1444}（40-50級）的 {object:2040}（技能175）。已標記 {zone:1434} 中 {object:2040} 最密集的區域。",
	-- ["30 {item:7912} for {item:7964}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "準備30個{item:7912}製作{item:7964}：{skill:186}：在{zone:1443}（30-40級）、{zone:1425}（40-50級）和{zone:1444}（40-50級）採集{object:2040}（技能175）。已標記{zone:1443}中{object:2040}最密集的位置。",
	-- ["320 {item:2841} for {spell:2672}: {skill:186}: smelt {item:2840} and {item:3576}."] = "準備320個{item:2841}製作{spell:2672}：{skill:186}：熔煉{item:2840}和{item:3576}。",
	-- ["320 {item:3860} for {item:7930}: {skill:186}: smelt {item:3858}."] = "準備320個{item:3860}製作{item:7930}：{skill:186}：熔煉{item:3858}。",
	-- ["44 {item:1210} for {item:7945}: {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining."] = "準備44個{item:1210}製作{item:7945}：大約每100個{object:1731}、{object:1732}或{object:1733}會出現一個{item:1210}：採礦時把找到的留著。",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "為 {item:7945} 準備 44 個 {item:7912}：透過 {skill:186} 開採 {zone:1425}（40-50 級）、{zone:1444}（40-50 級）和 {zone:1447}（45-55 級）的 {object:2040}（需要技能 175）。已標記 {zone:1425} 中 {object:2040} 最密集的位置。",
	-- ["44 {item:7912} for {item:7945}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "準備 44 個 {item:7912}，用於 {item:7945}：透過 {skill:186} 開採 {object:2040}（技能 175），產地有 {zone:1443}（30-40 級）、{zone:1425}（40-50 級）和 {zone:1444}（40-50 級）。已標記 {zone:1443} 中 {object:2040} 最密集的區域。",
	-- ["596 {item:3860} for {item:7933} and {item:7945}: {skill:186}: smelt {item:3858}."] = "準備596個{item:3860}製作{item:7933}和{item:7945}：{skill:186}：熔煉{item:3858}。",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1419} (45-55), {zone:1448} (48-55) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1419} is marked."] = "為 {item:12643}、{item:12773} 和 {item:12775} 準備801塊 {item:12365}：{skill:186}：開採 {zone:1419}（45-55級）、{zone:1448}（48-55級）和 {zone:1452}（55-60級）的 {object:324}（技能245）。已標記 {zone:1419} 中 {object:324} 最密集的區域。",
	-- ["801 {item:12365} for {item:12643}, {item:12773} and {item:12775}: {skill:186}: {object:324} (skill 245) in {zone:1448} (48-55), {zone:1451} (55-60) and {zone:1452} (55-60). The densest cluster of {object:324} in {zone:1448} is marked."] = "準備801個{item:12365}製作{item:12643}、{item:12773}和{item:12775}：{skill:186}：在{zone:1448}（48-55級）、{zone:1451}（55-60級）和{zone:1452}（55-60級）採集{object:324}（技能245）。已標記{zone:1448}中{object:324}最密集的位置。",
	-- ["Apprentice {skill:164}"] = "初級{skill:164}",
	-- ["Apprentice {skill:164} lets you craft up to 75 for 10c, at any character level. Any {skill:164} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} (any blacksmithing supplier) and pair it with {skill:186}: {item:2835} and {item:2770} come from the Copper Veins of every starting zone. 1-75 takes about 1s of recipes, plus 286 {item:2835} to gather or buy."] = "初級{skill:164}讓你在任何角色等級下花10銅把技能練到75。本陣營任意{skill:164}訓練師都教；箭頭會指向最近的一位。買一個{item:5956}（任何鍛造供應商）並與{skill:186}配合：{item:2835}和{item:2770}來自每個新手區域的銅礦脈。1-75大約花1銀的配方錢，外加286個{item:2835}，需自行採集或購買。",
	-- ["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "專家級需要角色等級35且{skill:164}200點；上限提高到300。225-300所需材料總價約942金。",
	-- ["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:164} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). The arrow picks the nearest of your faction. Learn now: {spell:16640} (from 225), {spell:9968} (from 210), {spell:9920} (from 175), {spell:10001} (from 205) and {spell:16639} (from 225). 225-300 takes about 3g 60s of recipes, plus 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799} to gather or buy."] = "大師級把上限從225提高到300，收費5金（經典舊世的價格；Forever的價格不在資料中）；它需要{skill:164} 200和角色35級，所以從200起任何一次造訪都能學。只有少數訓練師教：聯盟{npc:2836}（{zone:1434}）；部落{npc:2836}（{zone:1434}）。箭頭會指向本陣營最近的一位。現在學：{spell:16640}（225起）、{spell:9968}（210起）、{spell:9920}（175起）、{spell:10001}（205起）和{spell:16639}（225起）。225-300大約花3金60銀的配方錢，外加44個{item:1210}、596個{item:3860}、142個{item:4304}、19個{item:7909}、19個{item:7910}、44個{item:7912}、11個{item:7971}、206個{item:8170}、2026個{item:12359}、801個{item:12365}和10個{item:12799}，需自行採集或購買。",
	-- ["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "回到{skill:164}訓練師那裡：{spell:16639}在{skill:164}230點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "回到{skill:164}訓練師那裡：{spell:16640}在{skill:164}230點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "回到{skill:164}訓練師那裡：{spell:2666}在{skill:164}80點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "回到{skill:164}訓練師那裡：{spell:2668}在{skill:164}95點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:2672} (from 95, 5s)."] = "回到{skill:164}訓練師那裡：{spell:2672}（95點起，5銀）。",
	-- ["Back to a {skill:164} trainer: {spell:2674} (from 100, 10s)."] = "回到{skill:164}訓練師那裡：{spell:2674}（100點起，10銀）。",
	-- ["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "回到{skill:164}訓練師那裡：{spell:3117}在{skill:164}100點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:7223} (from 160)."] = "回到{skill:164}訓練師那裡：{spell:7223}（160點起）。",
	-- ["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "回到{skill:164}訓練師那裡：{spell:9916}在{skill:164}200點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:9918} (from 175)."] = "回到{skill:164}訓練師那裡：{spell:9918}（175點起）。",
	-- ["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "回到{skill:164}訓練師那裡：{spell:9920}、{spell:9935}在{skill:164}210點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "回到{skill:164}訓練師那裡：{spell:9968}在{skill:164}230點時可學。",
	-- ["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "回到{skill:164}訓練師那裡：{spell:9985}在{skill:164}155點時可學。",
	-- ["Buy the whole bracket's share in one go: 28 {item:2605} (28s); about 28s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817}). If you smelt the 195 {item:3859} yourself ({skill:186} 165: an {item:3575} and a Coal each), buy 195 Coal too (9g 75s, trade and blacksmithing suppliers); skip them if you buy the bars."] = "一次買齊這一段所需的全部：28個{item:2605}（28銀）；總共約28銀。箭頭會指向本陣營最近的賣家（{zone:1453}：{npc:1347}、{npc:1286}和{npc:5565}；{zone:1454}：{npc:3364}、{npc:3367}和{npc:5817}）。如果你自己熔鍊那195個{item:3859}（{skill:186} 165：每個需一個{item:3575}和一塊煤），還要買195塊煤（9金75銀，雜貨和鍛造供應商）；若直接買錠則跳過。",
	-- ["Buy the whole bracket's share in one go: {item:5956} (a tool: one, kept in your bags, 18c); about 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3413})."] = "一次買齊整個階段的用量：{item:5956}（工具：只需一個，留在揹包裡，18銅）；合計約18銅。箭頭會選擇本陣營最近的商人（{zone:1453}：{npc:5519}、{npc:1286}和{npc:5512}；{zone:1454}：{npc:3367}、{npc:5817}和{npc:3413}）。",
	-- ["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "高級需要角色等級20且{skill:164}125點；上限提高到225。150-225所需材料總價約42金。",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:164} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4258} ({zone:1455}); Horde {npc:3355} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3501} (from 140) and {spell:3337} (from 100, 10s). 150-225 takes about 10s of recipes and 28s of vendor goods, plus 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912} to gather or buy."] = "高級將上限從150提高到225，費用50銀（經典版的價格；資料中沒有Forever的價格）；需要{skill:164} 125和角色等級20，所以技能達到125後，任何一次經過都可以學。只有少數訓練師會教：聯盟為{npc:4258}（{zone:1455}）；部落為{npc:3355}（{zone:1454}）。箭頭會選擇你陣營最近的一位。現在學習：{spell:3501}（技能140起）和{spell:3337}（技能100起，10銀）。150-225約需10銀的配方和28銀的商人材料，另需採集或購買234個{item:2838}、168個{item:3575}、195個{item:3859}、320個{item:3860}和30個{item:7912}。",
	-- ["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "中級需要角色等級10且{skill:164}50點；上限提高到150。75-150所需材料總價約9金41銀。",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:164} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:164} trainer teaches it: Alliance {npc:3136} ({zone:1431}), {npc:252479} ({zone:2521}), {npc:10276} ({zone:1455}) and {npc:5511} ({zone:1453}); Horde {npc:276067} ({zone:1420}), {npc:252479} ({zone:2521}), {npc:4596} ({zone:1458}), {npc:2998} ({zone:1456}), {npc:1383} ({zone:1454}) and {npc:3478} ({zone:1413}). The arrow picks the nearest of your faction. Learn now: {spell:2666} (from 45, 2s) and {spell:3326} (from 50, 2s 50c). 75-150 takes about 19s 50c of recipes and 18c of vendor goods, plus 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841} to gather or buy."] = "中級可將上限從75提高到150，費用5銀；需要{skill:164} 50和角色等級10，所以技能達到50後，任何一次經過都可以學。並非每位{skill:164}訓練師都會教：聯盟有{npc:3136}（{zone:1431}）、{npc:252479}（{zone:2521}）、{npc:10276}（{zone:1455}）和{npc:5511}（{zone:1453}）；部落有{npc:276067}（{zone:1420}）、{npc:252479}（{zone:2521}）、{npc:4596}（{zone:1458}）、{npc:2998}（{zone:1456}）、{npc:1383}（{zone:1454}）和{npc:3478}（{zone:1413}）。箭頭會選擇你陣營最近的一位。現在學習：{spell:2666}（技能45起，2銀）和{spell:3326}（技能50起，2銀50銅）。75-150約需19銀50銅的配方和18銅的商人材料，另需採集或購買256個{item:2836}、28個{item:2838}、210個{item:2840}和320個{item:2841}。",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在Polestar依你的等級和陣營挑選的刷怪點擊殺掉落它的怪物。拍賣場也買得到。",
	-- ["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "橙色（每次製造必得1點）到120，黃色到135，綠色到150。附近需要有鐵砧。",
	-- ["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "橙色（每次製造必得1點）到125，黃色到140，綠色到155。附近需要有鐵砧。{skill:164}150是傳承系統的里程碑。",
	-- ["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "橙色（每次製造必得1點）到15，黃色到35，綠色到55。",
	-- ["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "橙色（每次製造必得1點）到260，黃色到270，綠色到280。附近需要有鐵砧。",
	-- ["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "橙色（每次製造必得1點）到280，黃色到292，綠色到305。附近需要有鐵砧。{skill:164}300是傳承系統的里程碑。",
	-- ["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "橙色（每次製造必得1點）到85，黃色到105，綠色到125。附近需要有鐵砧。",
	-- ["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}採集{item:8831}；這裡是資料中最密集的草點。拍賣場也買得到。",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:1815}、{npc:1816}、{npc:1817}的皮（48-60級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、鉗嘴龜、{npc:2384}、{npc:2354}的皮（18-30級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:2729}、{npc:2730}、{npc:2732}、{npc:2734}的皮（38-50級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}的皮（18-30級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:5292}、{npc:5300}、{npc:5304}、{npc:5272}、{npc:5260}、{npc:5262}、{npc:5268}、{npc:5274}、{npc:5287}、{npc:5286}、{npc:5296}的皮（38-50級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在這裡剝{npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378}、{npc:6377}的皮（48-60級的野獸會掉落）；{skill:393}指南有路線。拍賣場也買得到。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剝皮、分解或其他專業製造的材料：自己採集或在拍賣場購買。",
	-- ["Teaches {item:12775} (needs {skill:164} 255)."] = "學會{item:12775}（需要{skill:164}255點）。",
	-- ["Teaches {item:250562} (needs {skill:164} 240)."] = "學會{item:250562}（需要{skill:164}240點）。",
	-- ["What 1-75 takes that the Auction House sells: 286 {item:2835}. The counts drop by what your bags, bank and mail hold."] = "1-75階段所需的材料中，拍賣場有賣的：286個{item:2835}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What 150-225 takes that the Auction House sells: 234 {item:2838}, 168 {item:3575}, 195 {item:3859}, 320 {item:3860} and 30 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "150-225階段所需的材料中，拍賣場有賣的：234個{item:2838}、168個{item:3575}、195個{item:3859}、320個{item:3860}和30個{item:7912}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What 225-300 takes that the Auction House sells: 44 {item:1210}, 596 {item:3860}, 142 {item:4304}, 19 {item:7909}, 19 {item:7910}, 44 {item:7912}, 11 {item:7971}, 206 {item:8170}, 2026 {item:12359}, 801 {item:12365} and 10 {item:12799}. The counts drop by what your bags, bank and mail hold."] = "225-300階段所需的材料中，拍賣場有賣的：44個{item:1210}、596個{item:3860}、142個{item:4304}、19個{item:7909}、19個{item:7910}、44個{item:7912}、11個{item:7971}、206個{item:8170}、2026個{item:12359}、801個{item:12365}和10個{item:12799}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What 75-150 takes that the Auction House sells: 256 {item:2836}, 28 {item:2838}, 210 {item:2840} and 320 {item:2841}. The counts drop by what your bags, bank and mail hold."] = "75-150階段所需的材料中，拍賣場有賣的：256個{item:2836}、28個{item:2838}、210個{item:2840}和320個{item:2841}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["Yellow until 107, green until 115: not every craft gives a point."] = "黃色到107，綠色到115：不是每次製造都會加點。",
	-- ["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "黃色到155，綠色到170：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "黃色到170，綠色到185：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 180, green until 185: not every craft gives a point."] = "黃色到180，綠色到185：不是每次製造都會加點。",
	-- ["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "黃色到197，綠色到210：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "黃色到212，綠色到225：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "黃色到220，綠色到230：不是每次製造都會加點。附近需要有鐵砧。{skill:164}225是傳承系統的里程碑。",
	-- ["Yellow until 232, green until 235: not every craft gives a point."] = "黃色到232，綠色到235：不是每次製造都會加點。",
	-- ["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "黃色到235，綠色到245：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "黃色到240，綠色到250：不是每次製造都會加點。附近需要有鐵砧。",
	-- ["Yellow until 65, green until 85: not every craft gives a point."] = "黃色到65，綠色到85：不是每次製造都會加點。",
	-- ["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "黃色到65，綠色到85：不是每次製造都會加點。75是初級的上限。",
	-- ["{item:12365} (Alliance)"] = "{item:12365}（聯盟）",
	-- ["{item:12365} (Horde)"] = "{item:12365}（部落）",
	-- ["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365}來自{object:324}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:12426} is orange at 285 (yellow 290, green 300, grey 310): about 19 crafts to 300. Each takes 34 {item:12359}, 1 {item:7910} and 1 {item:7909}. About 34 Thorium Bars a craft against the battleaxe's 40 and its grinding stones, orange to 290. Below character level 50 {npc:14567} has no quest for you: keep making Huge Thorium Battleaxes to 300 instead (yellow to 292, grey at 305: about twice the Thorium Bars). Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "{item:12426}在285時為橙色（290變黃，300變綠，310變灰）：約製作19次可升至300。每次需要34個{item:12359}、1個{item:7910}和1個{item:7909}。每次約用34塊瑟銀錠，而戰斧要40塊，還要砂輪；此配方到290前都是橙色。角色等級低於50時，{npc:14567}不會提供任務：改為繼續製作巨型瑟銀戰斧至300（292前為黃色，305變灰：約需兩倍瑟銀錠）。附近需要有鐵砧。{skill:164}300是傳承系統的里程碑。",
	-- ["{item:12643} is orange at 225 (yellow 230, green 232, grey 235): about 17 crafts to 235. Each takes 1 {item:12365}. One {item:12365} a craft (Thorium veins): cheap points at the start of Artisan."] = "{item:12643}在225時為橙色（230黃、232綠、235灰）：大約17次製作可到235。每次需要1個{item:12365}。每次一個{item:12365}（瑟銀礦脈）：大師級開頭便宜的漲點選擇。",
	-- ["{item:12773} is orange at 250 (yellow 275, green 287, grey 300): about 5 crafts to 255, a point every craft. Each takes 20 {item:12359}, 2 {item:12799}, 2 {item:12644} and 4 {item:8170}. Make the 10 {item:12644} first. {item:12799} turns up in about one Thorium vein in 130: buy the ten at the Auction House. Five crafts only, until the battleaxe plans can be used at 255. Needs an anvil nearby."] = "{item:12773} 在技能 250 時為橙色（275 變黃、287 變綠、300 變灰）：約製作 5 次可到 255，每次必漲一點。每次需要 20 個 {item:12359}、2 個 {item:12799}、2 個 {item:12644} 和 4 個 {item:8170}。先製作 10 個 {item:12644}。{item:12799} 大約每 130 處瑟銀礦脈才出一個：去拍賣行買十個。只製作五次，到 255 後就能使用戰斧設計圖。附近需要鐵砧。",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} ({area:2298}, {zone:1422}), unlimited stock, but they bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775}在255時為橙色（280黃、292綠、305灰）：大約31次製作可到285。每次需要40個{item:12359}、6個{item:12644}和6個{item:8170}。先做好那186個{item:12644}。圖紙由{npc:11278}（{zone:1422}的{area:2298}）出售，不限量，但拾取即繫結。每次四十個瑟銀錠和六個緻密磨石：最貴的一段，所以到{quest:7654}接手時就停手。其他路徑：拍賣行的世界掉落圖紙（“光輝”系列：這條路線約需820個瑟銀錠和190個火焰之心），或商人的恩惠套裝。附近需要鐵砧。",
	-- ["{item:12775} is orange at 255 (yellow 280, green 292, grey 305): about 31 crafts to 285. Each takes 40 {item:12359}, 6 {item:12644} and 6 {item:8170}. Make the 186 {item:12644} first. Plans from {npc:11278} in {area:2298} ({zone:1422}): he is a ghost you see only with the {item:13544} trinket on (put it on inside {area:2298}), the reward of {npc:11216}'s {area:2057} chain that ends with {npc:10506} (level 55, a dungeon group). Unlimited stock, but the plans bind when picked up. Forty Thorium Bars and six Dense Grinding Stones a craft: the dearest stretch, so stop where the {quest:7654} take over. Without the trinket, the other ways through: world-drop plans from the Auction House (the Radiant pieces: about 820 Thorium Bars and 190 Hearts of Fire for the Radiant route) or the Merchant's Favor sets. Needs an anvil nearby."] = "{item:12775}在255時為橙色（黃色280，綠色292，灰色305）：大約製作31次到285。每次需要40個{item:12359}、6個{item:12644}和6個{item:8170}。先做186個{item:12644}。圖樣來自{area:2298}（{zone:1422}）的{npc:11278}：他是幽靈，只有戴著{item:13544}飾品時才能看見（在{area:2298}裡面戴上），這是{npc:11216}的{area:2057}任務線的獎勵，該任務線以{npc:10506}結束（55級，地城小隊）。庫存無限，但圖樣拾取後綁定。每次需要四十個瑟銀錠和六個緻密砂輪：最貴的一段，所以在{quest:7654}接手的地方停下。沒有飾品的話，其他途徑：拍賣場上的世界掉落圖樣（光輝系列：光輝路線大約需要820個瑟銀錠和190個火焰之心），或商人之友套裝。需要附近有鐵砧。",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422})."] = "{item:12819}教{item:12773}（{skill:164} 250），售價1金60銀。出售者{npc:11278}（{zone:1422}）。",
	-- ["{item:12819} teaches {item:12773} ({skill:164} 250) for 1g 60s. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12819}教會{item:12773}（{skill:164} 250），價格1金60銀。由{zone:1422}的{npc:11278}出售。{npc:11278}是幽靈：只有戴著{item:13544}時才能看見他（來自{npc:11216}的{area:2057}任務線，55級，需要小隊），沒有它就跳過。",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422})."] = "{item:12823}教{item:12775}（{skill:164} 255），售價2金。出售者{npc:11278}（{zone:1422}）。",
	-- ["{item:12823} teaches {item:12775} ({skill:164} 255) for 2g. Sold by {npc:11278} ({zone:1422}). {npc:11278} is a ghost: you see him only with the {item:13544} on (from {npc:11216}'s {area:2057} chain, level 55, a group), so skip this without it."] = "{item:12823}教會{item:12775}（{skill:164} 255），價格2金。由{zone:1422}的{npc:11278}出售。{npc:11278}是幽靈：只有戴著{item:13544}時才能看見他（來自{npc:11216}的{area:2057}任務線，55級，需要小隊），沒有它就跳過。",
	-- ["{item:2319} (Alliance)"] = "{item:2319}（聯盟）",
	-- ["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- ["{item:250562} to 268"] = "{item:250562}練到268",
	-- ["{item:2835} (Alliance)"] = "{item:2835}（聯盟）",
	-- ["{item:2835} (Horde)"] = "{item:2835}（部落）",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}來自{object:1731}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:2836} (Alliance)"] = "{item:2836}（聯盟）",
	-- ["{item:2836} (Horde)"] = "{item:2836}（部落）",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}來自{object:1732}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:2838} (Alliance)"] = "{item:2838}（聯盟）",
	-- ["{item:2838} (Horde)"] = "{item:2838}（部落）",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}來自{object:1735}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:4304} (Alliance)"] = "{item:4304}（聯盟）",
	-- ["{item:4304} (Horde)"] = "{item:4304}（部落）",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}：工具，放在背包裡",
	-- ["{item:6040} is yellow at 185 (yellow 185, green 197, grey 210): about 39 crafts to 205. Each takes 5 {item:3859} and 2 {spell:3337}. Make the 78 {spell:3337} first. Steel Bars are smelted from an {item:3575} and a Coal ({skill:186} 165; Coal from trade and blacksmithing suppliers), so each bracer is five of each. Each bracer takes two Heavy Grinding Stones: make them first. Specialisation (optional): at 200 and character level 40, {npc:5164} ({zone:1455}) or {npc:11177} ({zone:1454}) starts The Art of the {spell:9788}: 4 Ornate Mithril Helms, 2 {item:7936} and an {item:7935}, whose plans come from a Mithril Order quest chain. {npc:11146} ({zone:1455}) or {npc:11178} ({zone:1454}) starts The Way of the Weaponsmith: 4 Moonsteel Broadswords, 4 Massive Iron Axes, 2 Heavy Mithril Axes and 2 Big Black Maces; on Forever the {item:3853} plans ({npc:2482}, {area:35}) and {item:3855} plans bind when picked up, so buy and use them yourself. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "{item:6040}在技能185時為黃色（185變黃，197變綠，210變灰）：約製作39次可到205。每次需要5個{item:3859}和2個{spell:3337}。先製作78個{spell:3337}。鋼錠由1個{item:3575}和1份煤塊熔鍊而成（需要{skill:186}165；煤塊向雜貨及鍛造供應商購買），所以每副護腕需要鐵錠和煤塊各5份。每副護腕還需2個重砂輪：先做好。專精（可選）：技能200且角色40級時，{npc:5164}（{zone:1455}）或{npc:11177}（{zone:1454}）提供“鑄造護甲的藝術”（{spell:9788}）：需要4個華麗秘銀頭盔、2個{item:7936}和1個{item:7935}，圖紙來自秘銀會任務鏈。{npc:11146}（{zone:1455}）或{npc:11178}（{zone:1454}）提供“武器鑄造師之道”：需要4把月鋼寬劍、4把巨型鐵斧、2把祕銀重斧和2把巨型黑色錘；無限中，{item:3853}圖紙（{area:35}的{npc:2482}出售）和{item:3855}圖紙拾取繫結，必須自己購買並學習。兩種專精只能選一種；升到300均不需要，而且測試版未測試過它們（測試止於30級）。附近需要有鐵砧。",
	-- ["{item:6040} to 205"] = "{item:6040}練到205",
	-- ["{item:7912} (Alliance)"] = "{item:7912}（聯盟）",
	-- ["{item:7912} (Horde)"] = "{item:7912}（部落）",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}來自{object:2040}（{skill:186}）；這裡是資料中最密集的礦點。拍賣場也買得到。",
	-- ["{item:7922} to 225"] = "{item:7922}練到225",
	-- ["{item:7930} is orange at 205 (yellow 225, green 235, grey 245): about 20 crafts to 225, a point every craft. Each takes 16 {item:3860}. Sixteen Mithril Bars a craft and nothing else; orange to 225 on Forever, so a point every craft to the Artisan cap. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "{item:7930} 在技能205時為橙色（225變黃，235變綠，245變灰）：大約製作20次升到225，每次必漲一點。每次需要16塊 {item:3860}。每次只需十六塊秘銀錠，無需其他材料；在無限服中到225前保持橙色，因此直到大師級上限每次都必漲一點。附近需要有鐵砧。{skill:164} 225是傳承系統的一項里程碑。",
	-- ["{item:7930} to 225"] = "{item:7930} 到225",
	-- ["{item:7931} to 230"] = "{item:7931}練到230",
	-- ["{item:7933} is yellow at 235 (yellow 230, green 240, grey 250): about 30 crafts to 247. Each takes 14 {item:3860} and 4 {item:4304}. Mithril Bars from Mithril Deposits; {item:4304} from skinners or the Auction House. Needs an anvil nearby."] = "{item:7933} 在技能235時為黃色（230變黃，240變綠，250變灰）：大約製作30次升到247。每次需要14塊 {item:3860} 和4張 {item:4304}。秘銀錠來自秘銀礦床；{item:4304} 從剝皮玩家或拍賣行獲取。附近需要有鐵砧。",
	-- ["{item:7945} is green at 247 (yellow 230, green 242, grey 255): about 11 crafts to 250. Each takes 16 {item:3860}, 1 {item:7971}, 4 {item:1210}, 1 {item:7966} and 2 {item:4304}. Make the 11 {item:7966} first. Only about 11 crafts to bridge 247-250, but each wants four Shadowgems (about one {object:1732} in a hundred) and a {item:7971}: buy those at the Auction House unless your bags already hold them. Needs an anvil nearby. {item:7971} (11 for 225-300): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find."] = "{item:7945}在247時為綠色（230變黃，242變綠，255變灰）：約製作11次可升至250。每次需要16個{item:3860}、1個{item:7971}、4個{item:1210}、1個{item:7966}和2個{item:4304}。先製作11個{item:7966}。247-250只需製作約11次，但每次都要四顆暗影石（約一百個{object:1732}出一顆）和一個{item:7971}：除非揹包已有，否則去拍賣行購買。附近需要有鐵砧。{item:7971}（225-300階段需要11個）：{item:7971}是稀有掉落（沒有任何怪物的掉率能達到五十分之一）：去拍賣行買，或留著找到的。",
	-- ["{item:7956} to 175"] = "{item:7956}練到175",
	-- ["{item:7963} to 210"] = "{item:7963}練到210",
	-- ["{item:7964} is yellow at 175 (yellow 175, green 180, grey 185): about 30 crafts to 185. Each takes 1 {item:7912}. One {item:7912} a craft (Mithril Deposits): cheap points between the iron and the steel bracers. Use the stones on your weapons or sell them."] = "{item:7964}在175時為黃色（175黃、180綠、185灰）：大約30次製作可到185。每次需要1個{item:7912}。每次一個{item:7912}（秘銀礦床）：在鐵護腕和鋼護腕之間便宜的漲點選擇。把磨石用在武器上，或者賣掉。",
	-- ["{item:7964} to 185"] = "{item:7964}練到185",
	-- ["{item:8170} (Alliance)"] = "{item:8170}（聯盟）",
	-- ["{item:8170} (Horde)"] = "{item:8170}（部落）",
	-- ["{item:8831} (Alliance)"] = "{item:8831}（聯盟）",
	-- ["{item:8831} (Horde)"] = "{item:8831}（部落）",
	-- ["{skill:164} 1-75: Auction House"] = "{skill:164} 1-75：拍賣場",
	-- ["{skill:164} 150-225: Auction House"] = "{skill:164} 150-225：拍賣場",
	-- ["{skill:164} 75-150: Auction House"] = "{skill:164} 75-150：拍賣場",
	-- ["{skill:164} materials for 150-225"] = "{skill:164}150-225的材料",
	-- ["{skill:164} materials for 225-300"] = "{skill:164}225-300的材料",
	-- ["{skill:164} materials for 75-150"] = "{skill:164}75-150的材料",
	-- ["{skill:164} recipes at 113"] = "{skill:164}113點的配方",
	-- ["{skill:164} recipes at 121"] = "{skill:164}121點的配方",
	-- ["{skill:164} recipes at 155"] = "{skill:164}155點的配方",
	-- ["{skill:164} recipes at 205"] = "{skill:164}205點的配方",
	-- ["{skill:164} recipes at 210"] = "{skill:164}210點的配方",
	-- ["{skill:164} recipes at 230"] = "{skill:164}230點的配方",
	-- ["{skill:164} recipes at 268"] = "{skill:164}268點的配方",
	-- ["{skill:164} recipes at 45"] = "{skill:164}45點的配方",
	-- ["{skill:164} recipes at 83"] = "{skill:164}83點的配方",
	-- ["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164}可以邊升級邊練。永恆的傳承系統會在專業技能150、225和300（中級、高級和專家級的上限）時給予製造專業獎勵，所以每個階段都很重要。1-75所需材料總價約17銀。",
	-- ["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}：{item:249410}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}：熔煉{item:10620}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}：熔煉{item:2770}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}：熔煉{item:2775}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}：熔煉{item:2840}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}：熔煉{item:3575}（或在拍賣場購買）",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}：熔煉{item:3858}（或在拍賣場購買）",
	-- ["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}：{item:249432}（或在拍賣場購買）",
	-- ["{skill:393} (or the Auction House)"] = "{skill:393}（或在拍賣場購買）",
	-- ["{spell:2660} is orange at 1 (yellow 15, green 35, grey 55): about 42 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft, a point every craft to 15."] = "{spell:2660}在1時為橙色（15黃、35綠、55灰）：大約42次製作可到35。每次需要1個{item:2835}。每次一個{item:2835}，到15前每次一點。",
	-- ["{spell:2666} is orange at 83 (yellow 85, green 105, grey 125): about 21 crafts to 100. Each takes 10 {item:2840}. Forever teaches {spell:2666} from 45; it stays orange to 85. Ten Copper Bars a craft: smelt your {item:2770}. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:2666} 在83點時為橙色（85變黃，105變綠，125變灰）：製作約21次可到100。每次需要10塊 {item:2840}。無限服在45點即可學習 {spell:2666}；到85點前一直為橙色。每次製作消耗十塊銅錠：熔鍊你的 {item:2770}。附近需要有鐵砧。{item:5956} 是工具：留在揹包中。",
	-- ["{spell:2668} to 121"] = "{spell:2668}練到121",
	-- ["{spell:2672} is orange at 113 (yellow 125, green 140, grey 155): about 64 crafts to 150. Each takes 5 {item:2841} and 2 {spell:3326}. Make the 128 {spell:3326} first. Each bracer takes two Coarse Grinding Stones ({item:2836} from Tin Veins): make them first; they give points too. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "{spell:2672}在113時為橙色（125變黃，140變綠，155變灰）：約製作64次可升至150。每次需要5個{item:2841}和2個{spell:3326}。先製作128個{spell:3326}。每副護腕需要兩個粗製砂輪（{item:2836}來自錫礦脈）：先做好砂輪，它們也能提升技能。附近需要有鐵砧。{skill:164}150是傳承系統的里程碑。",
	-- ["{spell:2672} to 150"] = "{spell:2672}練到150",
	-- ["{spell:2674} is yellow at 100 (yellow 100, green 107, grey 115): about 28 crafts to 113. Each takes 1 {item:2838}. {item:2838} comes from Iron Deposits; one a craft."] = "{spell:2674}在100時為黃色（100黃、107綠、115灰）：大約28次製作可到113。每次需要1個{item:2838}。{item:2838}來自鐵礦脈；每次一個。",
	-- ["{spell:2674} to 113"] = "{spell:2674} 到113",
	-- ["{spell:3117} to 112"] = "{spell:3117}練到112",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320}在75時為綠色（45黃、65綠、85灰）：大約58次製作可到83。每次需要2個{item:2835}。每次兩個{item:2835}。磨石是後續圖紙的零件；多出來的賣給商人。",
	-- ["{spell:3320} is green at 75 (yellow 45, green 65, grey 85): about 58 crafts to 83. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors. If you got here without learning {spell:3320}, learn it now: an earlier step teaches it."] = "{spell:3320}在75時為綠色（黃色45，綠色65，灰色85）：大約製作58次到83。每次需要2個{item:2835}。每次兩個{item:2835}。磨石是後續圖樣的材料；多餘的賣給商人。如果你到這裡還沒學會{spell:3320}，現在就學：之前的步驟會教。",
	-- ["{spell:3320} is orange at 35 (yellow 45, green 65, grey 85): about 64 crafts to 75. Each takes 2 {item:2835}. Two {item:2835} a craft. Grinding stones are parts for later plans; the extras sell to vendors."] = "{spell:3320}在35時為橙色（45黃、65綠、85灰）：大約64次製作可到75。每次需要2個{item:2835}。每次兩個{item:2835}。磨石是後續圖紙的零件；多出來的賣給商人。",
	-- ["{spell:3320} to 83"] = "{spell:3320}練到83",
	-- ["{spell:3333} to 155"] = "{spell:3333}練到155",
	-- ["{spell:3501} is orange at 150 (yellow 165, green 177, grey 190): about 28 crafts to 175. Each takes 6 {item:3575} and 1 {item:2605}. Six Iron Bars and a {item:2605} a craft; {item:2605} comes from tailoring, leatherworking and trade supplies vendors. Orange to 165 on Forever, so a point every craft for the first fifteen. Needs an anvil nearby."] = "{spell:3501}在技能150時為橙色（165變黃，177變綠，190變灰）：約製作28次可到175。每次需要6個{item:3575}和1個{item:2605}。也就是每次6塊鐵錠和1個{item:2605}；{item:2605}可向裁縫、制皮及雜貨供應商購買。無限中到165前都是橙色，因此前15次製作每次都漲一點。附近需要有鐵砧。",
	-- ["{spell:9959} (from 205) is taught only by the Artisan trainers: Alliance {npc:2836} ({zone:1434}); Horde {npc:2836} ({zone:1434}). You can train Artisan there now if you are level 35 (it needs {skill:164} 200), which saves the trip at 225."] = "{spell:9959}（205起）只有專家級訓練師會教：聯盟{npc:2836}（{zone:1434}）；部落{npc:2836}（{zone:1434}）。如果你已達35級（需要{skill:164} 200），現在就可以在那裡學習專家級，省去225時再跑一趟。",
}
