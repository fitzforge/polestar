-- Korean (koKR): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Engineering
	-- {skill:202} Engineering
	["Learn {skill:202}"] = "{skill:202} 배우기",
	-- {skill:202} Engineering · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore · {item:2840} Copper Bar
	["Apprentice {skill:202} lets you craft up to 75 for 10c, at any character level. Any {skill:202} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} and pair it with {skill:186}: {item:2835} and {item:2770} are the first parts. 1-75 takes about 4s 15c of recipes and 18s 18c of vendor goods, plus 46 {item:2835} and 75 {item:2840} to gather or buy."] = "{skill:202} 초급 단계는 10코퍼로 75까지 제작할 수 있게 해 주며, 캐릭터 레벨 제한이 없습니다. 당신 진영의 어떤 {skill:202} 상급자든 가르치며, 화살표가 가장 가까운 이를 가리킵니다. {item:5956}을(를) 사서 {skill:186}과(와) 함께 쓰세요. {item:2835}과(와) {item:2770}이(가) 첫 재료입니다. 1-75에는 제조법 약 4실버 15코퍼와 상인 재료 18실버 18코퍼, 그리고 {item:2835} 46개와(과) {item:2840} 75개를 채집하거나 구매해야 합니다.",

	-- Step 2: Engineering 1-75: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 1-75: vendor goods"] = "{skill:202} 1-75: 상인 재료",
	-- {item:2880} Weak Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:1286} Edna Mullby · {npc:5512} Kaita Deepforge
	-- was: ["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2880} 18개(18실버)와(과) {item:5956}(도구: 하나를 사서 가방에 두세요, 18코퍼). 모두 약 18실버 18코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:5519}, {npc:5514}, {npc:1286})."
	["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:1286} and {npc:5512})."] = "",
	["a tool, keep it in your bags"] = "도구이니 가방에 두세요",

	-- Step 3: Get Rough Stone (Elwynn Forest)
	-- {item:2835} Rough Stone · {zone:1429} Elwynn Forest
	["Get {item:2835} ({zone:1429})"] = "",
	-- {item:2835} Rough Stone · {skill:202} Engineering · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1429} Elwynn Forest
	["You need 46 {item:2835} for {skill:202} 1-75: {spell:3918}. {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked. Or buy them at the Auction House."] = "",

	-- Step 4: Get Rough Stone (Dun Morogh)
	-- {item:2835} Rough Stone · {zone:1426} Dun Morogh
	["Get {item:2835} ({zone:1426})"] = "",
	-- {item:2835} Rough Stone · {skill:202} Engineering · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh
	["You need 46 {item:2835} for {skill:202} 1-75: {spell:3918}. {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked. Or buy them at the Auction House."] = "",

	-- Step 5: Get Rough Stone (Darkshore)
	-- {item:2835} Rough Stone · {zone:1439} Darkshore
	["Get {item:2835} ({zone:1439})"] = "",
	-- {item:2835} Rough Stone · {skill:202} Engineering · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1439} Darkshore
	["You need 46 {item:2835} for {skill:202} 1-75: {spell:3918}. {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked. Or buy them at the Auction House."] = "",

	-- Step 6: Get Rough Stone (Zephras Isle)
	-- {item:2835} Rough Stone · {zone:2521} Zephras Isle
	["Get {item:2835} ({zone:2521})"] = "",
	-- {item:2835} Rough Stone · {skill:202} Engineering · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:2521} Zephras Isle
	["You need 46 {item:2835} for {skill:202} 1-75: {spell:3918}. {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked. Or buy them at the Auction House."] = "",

	-- Step 7: Get Rough Stone (Durotar)
	-- {item:2835} Rough Stone · {zone:1411} Durotar
	["Get {item:2835} ({zone:1411})"] = "",
	-- {item:2835} Rough Stone · {skill:202} Engineering · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1411} Durotar
	["You need 46 {item:2835} for {skill:202} 1-75: {spell:3918}. {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked. Or buy them at the Auction House."] = "",

	-- Step 8: Get Rough Stone (Mulgore)
	-- {item:2835} Rough Stone · {zone:1412} Mulgore
	["Get {item:2835} ({zone:1412})"] = "",
	-- {item:2835} Rough Stone · {skill:202} Engineering · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1412} Mulgore
	["You need 46 {item:2835} for {skill:202} 1-75: {spell:3918}. {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked. Or buy them at the Auction House."] = "",

	-- Step 9: Get Rough Stone (Tirisfal Glades)
	-- {item:2835} Rough Stone · {zone:1420} Tirisfal Glades
	["Get {item:2835} ({zone:1420})"] = "",
	-- {item:2835} Rough Stone · {skill:202} Engineering · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1420} Tirisfal Glades
	["You need 46 {item:2835} for {skill:202} 1-75: {spell:3918}. {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked. Or buy them at the Auction House."] = "",

	-- Step 10: Get Copper Bar (Alliance)
	-- {item:2840} Copper Bar
	["Get {item:2840} (Alliance)"] = "",
	-- {item:2840} Copper Bar · {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {item:6219} Arclight Spanner · {spell:3924} Copper Tube · {object:1731} Copper Vein · {skill:186} Mining · {item:2770} Copper Ore · {zone:1426} Dun Morogh
	["You need 75 {item:2840} for {skill:202} 1-75: {spell:3922}, {item:6219} and {spell:3924}. Mine {object:1731} ({skill:186} 1) for {item:2770} and smelt it at a forge ({skill:186} 1). The densest cluster of {object:1731} in {zone:1426} is marked. Or buy them at the Auction House."] = "",

	-- Step 11: Get Copper Bar (Horde)
	-- {item:2840} Copper Bar
	["Get {item:2840} (Horde)"] = "",
	-- {item:2840} Copper Bar · {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {item:6219} Arclight Spanner · {spell:3924} Copper Tube · {object:1731} Copper Vein · {skill:186} Mining · {item:2770} Copper Ore · {zone:1411} Durotar
	["You need 75 {item:2840} for {skill:202} 1-75: {spell:3922}, {item:6219} and {spell:3924}. Mine {object:1731} ({skill:186} 1) for {item:2770} and smelt it at a forge ({skill:186} 1). The densest cluster of {object:1731} in {zone:1411} is marked. Or buy them at the Auction House."] = "",

	-- Step 12: Rough Blasting Powder to 35
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 35"] = "{spell:3918}: 35까지",
	-- {spell:3918} Rough Blasting Powder · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["{spell:3918} is orange at 1 (yellow 20, green 30, grey 40): about 46 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft; {item:2835} comes with the {item:2770} from Copper Veins."] = "{spell:3918}은(는) 1에 주황색입니다(노란색 20, 초록색 30, 회색 40). 35까지 약 46번 만드세요. 한 번에 {item:2835} 1개. 제작당 {item:2835} 한 개. {item:2835}은(는) 구리 광맥의 {item:2770}과(와) 함께 나옵니다.",

	-- Step 13: Engineering recipes at 35
	-- {skill:202} Engineering
	["{skill:202} recipes at 35"] = "35에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {spell:1230656} Reagent Bot · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3922} (from 30, 1s 15c). Also learn {spell:1230656} (1s): Forever's {skill:202} camp item, placed at a campsite beside a campfire. It takes a {spell:3922} and a {spell:3924}, which you learn at 30 and 50, so it gives no points. The Camping 101: {skill:202} quest from your starting area's camping guide (after The Great Outdoors) sends you to an engineering trainer who teaches it free."] = "{skill:202} 상급자에게 돌아가세요: {spell:3922}(30부터, 1s 15c). {spell:1230656}(1s)도 배우세요. Forever의 {skill:202} 야영 아이템으로, 들고 모닥불 옆 야영지에 설치하면 됩니다. {spell:3922}와 {spell:3924}가 필요하며 각각 30과 50에 배우므로 숙련도를 주지 않습니다. 시작 지역의 야영 가이드에 있는 야영 기초 101: {skill:202} 퀘스트(위대한 야외 다음)가 상급자에게 보내며, 거기서 무료로 가르칩니다.",

	-- Step 14: Handful of Copper Bolts to 57
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 57"] = "{spell:3922}: 57까지",
	-- {spell:3922} Handful of Copper Bolts · {item:2840} Copper Bar · {item:5956} Blacksmith Hammer
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{spell:3922} is orange at 35 (yellow 45, green 52, grey 60): about 33 crafts to 57. Each takes 1 {item:2840}. One {item:2840} a craft. Keep the bolts: Practice Locks and later gadgets take them. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "{spell:3922}은(는) 35에 주황색입니다(노란색 45, 초록색 52, 회색 60). 57까지 약 33번 만드세요. 한 번에 {item:2840} 1개. 제작당 {item:2840} 한 개. 볼트는 간직하세요. 연습용 자물쇠와 이후 도구가 씁니다. 근처에 모루가 필요합니다. {item:5956}은(는) 도구이니 가방에 두세요.",

	-- Step 15: Engineering recipes at 57
	-- {skill:202} Engineering
	["{skill:202} recipes at 57"] = "57에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:7430} Arclight Spanner · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:7430} (from 50, 1s 50c) and {spell:3924} (from 50, 1s 50c)."] = "{skill:202} 상급자에게 돌아가세요: {spell:7430}(50부터, 1실버 50코퍼)과(와) {spell:3924}(50부터, 1실버 50코퍼).",

	-- Step 16: Copper Tube to 75
	-- {spell:3924} Copper Tube
	["{spell:3924} to 75"] = "{spell:3924}: 75까지",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux · {item:6219} Arclight Spanner
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is orange at 57 (yellow 80, green 95, grey 110): about 18 crafts to 75, a point every craft. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. Make the {item:6219} now, while it still gives a point: a later recipe needs it in your bags, so keep it there."] = "{spell:3924}은(는) 57에 주황색입니다(노란색 80, 초록색 95, 회색 110). 75까지 약 18번 만드세요, 매번 포인트가 오릅니다. 한 번에 {item:2840} 2개, {item:2880} 1개. 제작당 구리 주괴 두 개와(과) {item:2880} 한 개(대장기술 및 기술기술 용품 상인). 근처에 모루가 필요합니다. {item:6219}은(는) 지금 만드세요. 아직 포인트를 주고, 이후 제조법이 가방에 그것을 요구하니 거기 두세요.",
	["a tool: keep it in your bags"] = "도구: 가방에 넣어 두세요",

	-- Step 17: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "수습 {skill:202}",
	-- {skill:202} Engineering · {npc:1676} Finbus Geargrind · {zone:1431} Duskwood · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:11029} Trixie Quikswitch · {zone:1455} Ironforge · {npc:11031} Franklin Lloyd · {zone:1458} Undercity · {spell:3929} Coarse Blasting Powder · {spell:3930} Crafted Heavy Shot · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}) and {npc:11029} ({zone:1455}); Horde {npc:11031} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "수습 단계는 5실버(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 75에서 150으로 올립니다. {skill:202} 50과 캐릭터 레벨 10이 필요하므로, 50이 되면 언제 들러도 배울 수 있습니다. 모든 {skill:202} 상급자가 가르치지는 않습니다: 얼라이언스는 {npc:1676}({zone:1431}), {npc:5518}({zone:1453}), {npc:11029}({zone:1455}), 호드는 {npc:11031}({zone:1458})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:3929}(75부터, 2실버 50코퍼), {spell:3930}(75부터, 2실버 50코퍼). 75-150에는 제조법 약 5실버와 상인 재료 약 45실버, 그리고 채집하거나 살 {item:2836} 15개, {item:2838} 27개, {item:2840} 72개, {item:2841} 61개, {item:2842} 2개가 듭니다.",

	-- Step 18: Engineering 75-150: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 75-150: vendor goods"] = "{skill:202} 75-150: 상인 재료",
	-- {item:2880} Weak Flux · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 45 {item:2880} (45s); about 45s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2880} 45개(45실버). 모두 약 45실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:5519}, {npc:5514}, {npc:1286}).",

	-- Step 19: Get Coarse Stone (Westfall)
	-- {item:2836} Coarse Stone · {zone:1436} Westfall
	["Get {item:2836} ({zone:1436})"] = "",
	-- {item:2836} Coarse Stone · {skill:202} Engineering · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1436} Westfall
	["You need 15 {item:2836} for {skill:202} 75-150: {spell:3930}. {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked. Or buy them at the Auction House."] = "",

	-- Step 20: Get Coarse Stone (Loch Modan)
	-- {item:2836} Coarse Stone · {zone:1432} Loch Modan
	["Get {item:2836} ({zone:1432})"] = "",
	-- {item:2836} Coarse Stone · {skill:202} Engineering · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan
	["You need 15 {item:2836} for {skill:202} 75-150: {spell:3930}. {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked. Or buy them at the Auction House."] = "",

	-- Step 21: Get Coarse Stone (Darkshore)
	-- {item:2836} Coarse Stone · {zone:1439} Darkshore
	["Get {item:2836} ({zone:1439})"] = "",
	-- {item:2836} Coarse Stone · {skill:202} Engineering · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1439} Darkshore
	["You need 15 {item:2836} for {skill:202} 75-150: {spell:3930}. {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked. Or buy them at the Auction House."] = "",

	-- Step 22: Get Coarse Stone (The Barrens)
	-- {item:2836} Coarse Stone · {zone:1413} The Barrens
	["Get {item:2836} ({zone:1413})"] = "",
	-- {item:2836} Coarse Stone · {skill:202} Engineering · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens
	["You need 15 {item:2836} for {skill:202} 75-150: {spell:3930}. {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 23: Get Coarse Stone (Silverpine Forest)
	-- {item:2836} Coarse Stone · {zone:1421} Silverpine Forest
	["Get {item:2836} ({zone:1421})"] = "",
	-- {item:2836} Coarse Stone · {skill:202} Engineering · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1421} Silverpine Forest
	["You need 15 {item:2836} for {skill:202} 75-150: {spell:3930}. {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked. Or buy them at the Auction House."] = "",

	-- Step 24: Get Heavy Stone (Arathi Highlands)
	-- {item:2838} Heavy Stone · {zone:1417} Arathi Highlands
	["Get {item:2838} ({zone:1417})"] = "",
	-- {item:2838} Heavy Stone · {skill:202} Engineering · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands
	["You need 27 {item:2838} for {skill:202} 75-150: {spell:3945}. {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked. Or buy them at the Auction House."] = "",

	-- Step 25: Get Heavy Stone (Ashenvale)
	-- {item:2838} Heavy Stone · {zone:1440} Ashenvale
	["Get {item:2838} ({zone:1440})"] = "",
	-- {item:2838} Heavy Stone · {skill:202} Engineering · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1440} Ashenvale
	["You need 27 {item:2838} for {skill:202} 75-150: {spell:3945}. {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked. Or buy them at the Auction House."] = "",

	-- Step 26: Get Heavy Stone (The Barrens)
	-- {item:2838} Heavy Stone · {zone:1413} The Barrens
	["Get {item:2838} ({zone:1413})"] = "",
	-- {item:2838} Heavy Stone · {skill:202} Engineering · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1413} The Barrens
	["You need 27 {item:2838} for {skill:202} 75-150: {spell:3945}. {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 28: Get Copper Bar (Alliance)
	-- {item:2840} Copper Bar · {skill:202} Engineering · {spell:3930} Crafted Heavy Shot · {spell:3924} Copper Tube · {item:6712} Practice Lock · {object:1731} Copper Vein · {skill:186} Mining · {item:2770} Copper Ore · {zone:1426} Dun Morogh
	["You need 72 {item:2840} for {skill:202} 75-150: {spell:3930}, {spell:3924} and {item:6712}. Mine {object:1731} ({skill:186} 1) for {item:2770} and smelt it at a forge ({skill:186} 1). The densest cluster of {object:1731} in {zone:1426} is marked. Or buy them at the Auction House."] = "",

	-- Step 29: Get Copper Bar (Horde)
	-- {item:2840} Copper Bar · {skill:202} Engineering · {spell:3930} Crafted Heavy Shot · {spell:3924} Copper Tube · {item:6712} Practice Lock · {object:1731} Copper Vein · {skill:186} Mining · {item:2770} Copper Ore · {zone:1411} Durotar
	["You need 72 {item:2840} for {skill:202} 75-150: {spell:3930}, {spell:3924} and {item:6712}. Mine {object:1731} ({skill:186} 1) for {item:2770} and smelt it at a forge ({skill:186} 1). The densest cluster of {object:1731} in {zone:1411} is marked. Or buy them at the Auction House."] = "",

	-- Step 30: Get Bronze Bar
	-- {item:2841} Bronze Bar
	["Get {item:2841}"] = "",
	-- {item:2841} Bronze Bar · {skill:202} Engineering · {item:6712} Practice Lock · {spell:3950} Big Bronze Bomb · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["You need 61 {item:2841} for {skill:202} 75-150: {item:6712} and {spell:3950}. {skill:186}: smelt {item:2840} and {item:3576}. Or buy them at the Auction House."] = "",

	-- Step 31: Get Silver Bar
	-- {item:2842} Silver Bar
	["Get {item:2842}"] = "",
	-- {item:2842} Silver Bar · {skill:202} Engineering · {spell:3950} Big Bronze Bomb · {skill:186} Mining · {item:2775} Silver Ore
	["You need 2 {item:2842} for {skill:202} 75-150: {spell:3950}. {skill:186}: smelt {item:2775}. Or buy them at the Auction House."] = "",

	-- Step 32: Crafted Heavy Shot to 94
	-- {spell:3930} Crafted Heavy Shot
	["{spell:3930} to 94"] = "{spell:3930}: 94까지",
	-- {spell:3930} Crafted Heavy Shot · {spell:3929} Coarse Blasting Powder · {item:2840} Copper Bar
	["{spell:3930} is orange at 75 (yellow 85, green 90, grey 95): about 15 crafts to 94. Each takes 1 {spell:3929} and 1 {item:2840} and makes 200. Make the 15 {spell:3929} first: it gives points too while not grey. The {spell:3929} in each gives its own point while it is not grey: two chances a craft. Sell the shot to hunters or a vendor."] = "{spell:3930}은(는) 75에 주황색입니다(노란색 85, 초록색 90, 회색 95). 94까지 약 15번 만드세요. 한 번에 {spell:3929} 1개, {item:2840} 1개. 200개를 만듭니다. 먼저 {spell:3929} 15개를 만드세요. 회색이 아닐 때도 포인트를 줍니다. 각탄에 든 {spell:3929}은(는) 회색이 아니면 자기 포인트를 줍니다. 제작당 두 번의 기회입니다. 탄환은 사냥꾼이나 상인에게 팔으세요.",

	-- Step 33: Copper Tube to 100
	-- {spell:3924} Copper Tube
	["{spell:3924} to 100"] = "{spell:3924}: 100까지",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is yellow at 94 (yellow 80, green 95, grey 110): about 14 crafts to 100. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. If you got here without learning {spell:3924}, learn it now: an earlier step teaches it."] = "{spell:3924}은(는) 94에서 노란색입니다(노란색 80, 초록색 95, 회색 110): 100까지 약 14번 제작. 매번 {item:2840} 2개와 {item:2880} 1개가 필요합니다. 제작마다 구리 주괴 두 개와 {item:2880} 하나(대장기술 및 기계공학 재료 상인). 근처에 모루가 필요합니다. {spell:3924}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 34: Engineering recipes at 100
	-- {skill:202} Engineering
	["{skill:202} recipes at 100"] = "100에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:8334} Practice Lock
	["Back to an {skill:202} trainer: {spell:8334} (from 100)."] = "{skill:202} 상급자에게 돌아가세요: {spell:8334}(100부터).",

	-- Step 35: Practice Lock to 125
	-- {item:6712} Practice Lock
	["{item:6712} to 125"] = "{item:6712}: 125까지",
	-- {item:6712} Practice Lock · {item:2841} Bronze Bar · {spell:3922} Handful of Copper Bolts · {item:2880} Weak Flux
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125. Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 29 {spell:3922} first. Use the 33 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby. If you got here without learning {spell:3922}, learn it now: an earlier step teaches it."] = "{item:6712}은(는) 100에서 주황색입니다(노란색 115, 초록색 122, 회색 130): 125까지 약 31번 제작. 매번 {item:2841} 1개, {spell:3922} 2개, {item:2880} 1개가 필요합니다. 먼저 {spell:3922} 29개를 만드십시오. 앞서 만든 {spell:3922} 33개를 쓰십시오. 위의 수량에는 빠져 있습니다. 연습용 자물쇠는 도적에게 팔거나 직접 여십시오. 근처에 모루가 필요합니다. {spell:3922}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 36: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "125에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} (from 125)."] = "{skill:202} 상급자에게 돌아가세요: {spell:3945}(125부터).",

	-- Step 37: Heavy Blasting Powder to 140
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 140"] = "{spell:3945}: 140까지",
	-- {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit · Iron Grenades = {item:4390} Iron Grenade
	["{spell:3945} is yellow at 125 (yellow 125, green 135, grey 145): about 27 crafts to 140. Each takes 1 {item:2838}. One {item:2838} a craft (Iron Deposits). Keep some: Iron Grenades take one each."] = "{spell:3945}은(는) 125에서 노란색입니다(노란색 125, 초록색 135, 회색 145). 140까지 약 27번 만드세요. 한 번에 {item:2838} 1개. 제작당 {item:2838} 한 개(철 광맥). 일부는 간직하세요. 철제 수류탄이 하나씩 씁니다.",

	-- Step 38: Engineering recipes at 140
	-- {skill:202} Engineering
	["{skill:202} recipes at 140"] = "140에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:3973} Silver Contact · {spell:3950} Big Bronze Bomb
	["Back to an {skill:202} trainer: {spell:3973} (from 90) and {spell:3950} (from 140)."] = "{skill:202} 상급자에게 돌아가세요: {spell:3973}(90부터), {spell:3950}(140부터).",

	-- Step 39: Big Bronze Bomb to 150
	-- {spell:3950} Big Bronze Bomb
	["{spell:3950} to 150"] = "{spell:3950}: 150까지",
	-- {spell:3950} Big Bronze Bomb · {item:4377} Heavy Blasting Powder · {item:2841} Bronze Bar · {spell:3973} Silver Contact · {skill:202} Engineering
	["{spell:3950} is yellow at 140 (yellow 140, green 165, grey 190): about 10 crafts to 150. Each takes 2 {item:4377}, 3 {item:2841} and 1 {spell:3973} and makes 3. Make the 10 {spell:3973} (2 crafts) first. Use the 20 {item:4377} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "{spell:3950}은(는) 140에서 노란색입니다(노란색 140, 초록색 165, 회색 190). 150까지 약 10번 만드세요. 한 번에 {item:4377} 2개, {item:2841} 3개, {spell:3973} 1개. 3개를 만듭니다. 먼저 {spell:3973} 10개를 만드세요(2번 제작). 앞서 만든 {item:4377} 20개를 쓰세요. 위 수량에는 포함되지 않습니다. 상급자가 가르치며, 데이터에서 이 포인트를 지나는 가장 싼 방법입니다. 근처에 모루가 필요합니다. {skill:202} 150은(는) 유산 시스템 이정표입니다.",

	-- Step 40: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "숙련 {skill:202}",
	-- {skill:202} Engineering · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11017} Roxxik · {zone:1454} Orgrimmar · {spell:9271} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:5174} ({zone:1455}); Horde {npc:11017} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912} to gather or buy."] = "숙련 단계는 50실버(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 150에서 225로 올립니다. {skill:202} 125와 캐릭터 레벨 20이 필요하므로, 125가 되면 언제 들러도 배울 수 있습니다. 가르치는 상급자는 몇 명뿐입니다: 얼라이언스는 {npc:5174}({zone:1455}), 호드는 {npc:11017}({zone:1454})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:9271}(150부터), {spell:3953}(145부터). 150-225에는 상인 재료 약 31실버, 그리고 채집하거나 살 {item:2319} 19개, {item:2592} 19개, {item:2836} 31개, {item:2838} 74개, {item:2841} 100개, {item:2842} 6개, {item:3575} 81개, {item:3860} 19개, {item:7912} 62개가 듭니다.",

	-- Step 41: Engineering 150-225: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 150-225: vendor goods"] = "{skill:202} 150-225: 상인 재료",
	-- {item:6530} Nightcrawlers · {zone:1453} Stormwind City · {npc:5494} Catherine Leland · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 31 {item:6530} (31s); about 31s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5494} and {npc:1286})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:6530} 31개(31실버). 모두 약 31실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:5494}, {npc:1286}).",

	-- Step 42: Get Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	-- was: ["{item:2319} (Alliance)"] = "{item:2319} (얼라이언스)"
	["Get {item:2319} (Alliance)"] = "",
	-- {item:2319} Medium Leather · {skill:202} Engineering · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	-- was: ["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "{spell:3953}에 필요한 {item:2319} 19개: {skill:393}: 18-30레벨 야수. 여기서 {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}와(과) {npc:2354}을(를) 무두질하세요(레벨 18-30). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 19 {item:2319} for {skill:202} 150-225: {spell:3953}. {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 43: Get Medium Leather (Horde)
	-- {item:2319} Medium Leather
	-- was: ["{item:2319} (Horde)"] = "{item:2319} (호드)"
	["Get {item:2319} (Horde)"] = "",
	-- {item:2319} Medium Leather · {skill:202} Engineering · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag
	-- was: ["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this."] = "{spell:3953}에 필요한 {item:2319} 19개: {skill:393}: 18-30레벨 야수. 여기서 {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}와(과) {npc:3817}을(를) 무두질하세요(레벨 18-30). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 19 {item:2319} for {skill:202} 150-225: {spell:3953}. {skill:393}: beasts of level 18-30. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 44: Get Wool Cloth
	-- {item:2592} Wool Cloth
	["Get {item:2592}"] = "",
	-- {item:2592} Wool Cloth · {skill:202} Engineering · {spell:3953} Bronze Framework
	["You need 19 {item:2592} for {skill:202} 150-225: {spell:3953}. Humanoids of level 15-30 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:2592} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 45: Get Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	-- was: ["{item:2836} (Alliance)"] = "{item:2836} (얼라이언스)"
	["Get {item:2836} (Alliance)"] = "",
	-- {item:2836} Coarse Stone · {skill:202} Engineering · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	-- was: ["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1432} is marked."] = "{item:6533}에 필요한 {item:2836} 31개: {skill:186}: {object:1732}(숙련도 65) {zone:1432}(10-20), {zone:1440}(18-30)와(과) {zone:1424}(20-30). {zone:1432}(10-20)에서 가장 많이 나는 {object:1732} 지점이 표시됩니다."
	["You need 31 {item:2836} for {skill:202} 150-225: {item:6533}. {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1432} is marked. Or buy them at the Auction House."] = "",

	-- Step 46: Get Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	-- was: ["{item:2836} (Horde)"] = "{item:2836} (호드)"
	["Get {item:2836} (Horde)"] = "",
	-- {item:2836} Coarse Stone · {skill:202} Engineering · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	-- was: ["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1413} is marked."] = "{item:6533}에 필요한 {item:2836} 31개: {skill:186}: {object:1732}(숙련도 65), {zone:1413}(10-25), {zone:1440}(18-30), {zone:1424}(20-30). {zone:1413}에서 {object:1732}이(가) 가장 많은 곳이 표시되어 있습니다."
	["You need 31 {item:2836} for {skill:202} 150-225: {item:6533}. {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 47: Get Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	-- was: ["{item:2838} (Alliance)"] = "{item:2838} (얼라이언스)"
	["Get {item:2838} (Alliance)"] = "",
	-- {item:2838} Heavy Stone · {skill:202} Engineering · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:1443} Desolace
	-- was: ["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "{spell:3967}에 필요한 {item:2838} 74개: {skill:186}: {object:1735}(숙련도 125) {zone:1417}(30-40), {zone:1434}(30-45)와(과) {zone:1443}(30-40). {zone:1417}(30-40)에서 가장 많이 나는 {object:1735} 지점이 표시됩니다."
	["You need 74 {item:2838} for {skill:202} 150-225: {spell:3967}. {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked. Or buy them at the Auction House."] = "",

	-- Step 48: Get Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	-- was: ["{item:2838} (Horde)"] = "{item:2838} (호드)"
	["Get {item:2838} (Horde)"] = "",
	-- {item:2838} Heavy Stone · {skill:202} Engineering · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1441} Thousand Needles · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	-- was: ["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "{spell:3967}에 필요한 {item:2838} 74개: {skill:186}: {object:1735}(숙련도 125) {zone:1441}(25-35), {zone:1417}(30-40)와(과) {zone:1434}(30-45). {zone:1441}(25-35)에서 가장 많이 나는 {object:1735} 지점이 표시됩니다."
	["You need 74 {item:2838} for {skill:202} 150-225: {spell:3967}. {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked. Or buy them at the Auction House."] = "",

	-- Step 49: Get Bronze Bar
	-- {item:2841} Bronze Bar · {skill:202} Engineering · {item:6533} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["You need 100 {item:2841} for {skill:202} 150-225: {item:6533} and {spell:3953}. {skill:186}: smelt {item:2840} and {item:3576}. Or buy them at the Auction House."] = "",

	-- Step 50: Get Silver Bar
	-- {item:2842} Silver Bar · {skill:202} Engineering · {spell:3967} Big Iron Bomb · {skill:186} Mining · {item:2775} Silver Ore
	["You need 6 {item:2842} for {skill:202} 150-225: {spell:3967}. {skill:186}: smelt {item:2775}. Or buy them at the Auction House."] = "",

	-- Step 51: Get Iron Bar (Alliance)
	-- {item:3575} Iron Bar
	["Get {item:3575} (Alliance)"] = "",
	-- {item:3575} Iron Bar · {skill:202} Engineering · {spell:3967} Big Iron Bomb · {object:1735} Iron Deposit · {skill:186} Mining · {item:2772} Iron Ore · {zone:1417} Arathi Highlands
	["You need 81 {item:3575} for {skill:202} 150-225: {spell:3967}. Mine {object:1735} ({skill:186} 125) for {item:2772} and smelt it at a forge ({skill:186} 125). The densest cluster of {object:1735} in {zone:1417} is marked. Or buy them at the Auction House."] = "",

	-- Step 52: Get Iron Bar (Horde)
	-- {item:3575} Iron Bar
	["Get {item:3575} (Horde)"] = "",
	-- {item:3575} Iron Bar · {skill:202} Engineering · {spell:3967} Big Iron Bomb · {object:1735} Iron Deposit · {skill:186} Mining · {item:2772} Iron Ore · {zone:1441} Thousand Needles
	["You need 81 {item:3575} for {skill:202} 150-225: {spell:3967}. Mine {object:1735} ({skill:186} 125) for {item:2772} and smelt it at a forge ({skill:186} 125). The densest cluster of {object:1735} in {zone:1441} is marked. Or buy them at the Auction House."] = "",

	-- Step 53: Get Mithril Bar (Alliance)
	-- {item:3860} Mithril Bar
	["Get {item:3860} (Alliance)"] = "",
	-- {item:3860} Mithril Bar · {skill:202} Engineering · {item:10512} Hi-Impact Mithril Slugs · {object:2040} Mithril Deposit · {skill:186} Mining · {item:3858} Mithril Ore · {zone:1434} Stranglethorn Vale
	["You need 19 {item:3860} for {skill:202} 150-225: {item:10512}. Mine {object:2040} ({skill:186} 175) for {item:3858} and smelt it at a forge ({skill:186} 175). The densest cluster of {object:2040} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 54: Get Mithril Bar (Horde)
	-- {item:3860} Mithril Bar
	["Get {item:3860} (Horde)"] = "",
	-- {item:3860} Mithril Bar · {skill:202} Engineering · {item:10512} Hi-Impact Mithril Slugs · {object:2040} Mithril Deposit · {skill:186} Mining · {item:3858} Mithril Ore · {zone:1443} Desolace
	["You need 19 {item:3860} for {skill:202} 150-225: {item:10512}. Mine {object:2040} ({skill:186} 175) for {item:3858} and smelt it at a forge ({skill:186} 175). The densest cluster of {object:2040} in {zone:1443} is marked. Or buy them at the Auction House."] = "",

	-- Step 55: Get Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	-- was: ["{item:7912} (Alliance)"] = "{item:7912} (얼라이언스)"
	["Get {item:7912} (Alliance)"] = "",
	-- {item:7912} Solid Stone · {skill:202} Engineering · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "{item:10505}에 필요한 {item:7912} 62개: {skill:186}: {object:2040}(숙련도 175) {zone:1434}(30-45), {zone:1425}(40-50)와(과) {zone:1444}(40-50). {zone:1434}(30-45)에서 가장 많이 나는 {object:2040} 지점이 표시됩니다."
	["You need 62 {item:7912} for {skill:202} 150-225: {item:10505}. {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 56: Get Solid Stone (Horde)
	-- {item:7912} Solid Stone
	-- was: ["{item:7912} (Horde)"] = "{item:7912} (호드)"
	["Get {item:7912} (Horde)"] = "",
	-- {item:7912} Solid Stone · {skill:202} Engineering · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "{item:10505}에 필요한 {item:7912} 62개: {skill:186}: {object:2040}(숙련도 175) {zone:1443}(30-40), {zone:1425}(40-50)와(과) {zone:1444}(40-50). {zone:1443}(30-40)에서 가장 많이 나는 {object:2040} 지점이 표시됩니다."
	["You need 62 {item:7912} for {skill:202} 150-225: {item:10505}. {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked. Or buy them at the Auction House."] = "",

	-- Step 57: Aquadynamic Fish Attractor to 166
	-- {item:6533} Aquadynamic Fish Attractor
	["{item:6533} to 166"] = "{item:6533}: 166까지",
	-- {item:6533} Aquadynamic Fish Attractor · {item:2841} Bronze Bar · {item:6530} Nightcrawlers · {spell:3929} Coarse Blasting Powder
	["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166. Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 31 {spell:3929} first. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen. If you got here without learning {spell:3929}, learn it now: an earlier step teaches it."] = "{item:6533}은(는) 150에서 노란색입니다(노란색 150, 초록색 160, 회색 170): 166까지 약 31번 제작. 매번 {item:2841} 2개, {item:6530} 1개, {spell:3929} 1개가 필요하고 3개를 만듭니다. 먼저 {spell:3929} 31개를 만드십시오. {item:6530}은(는) 잡화 상인과 낚시 용품 상인에게서 삽니다. 미끼는 낚시꾼에게 팝니다. {spell:3929}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 58: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953}: 175까지",
	-- {spell:3953} Bronze Framework · {item:2841} Bronze Bar · {item:2319} Medium Leather · {item:2592} Wool Cloth
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["{spell:3953} is yellow at 166 (yellow 145, green 170, grey 195): about 19 crafts to 175. Each takes 2 {item:2841}, 1 {item:2319} and 1 {item:2592}. Bronze Frameworks are parts for later gadgets; the extras sell to vendors."] = "{spell:3953}은(는) 166에서 노란색입니다(노란색 145, 초록색 170, 회색 195). 175까지 약 19번 만드세요. 한 번에 {item:2841} 2개, {item:2319} 1개, {item:2592} 1개. 청동 골격은 이후 도구의 재료이며, 남는 것은 상인에게 팔립니다.",

	-- Step 59: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "175에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder
	["Back to an {skill:202} trainer: {spell:12585} (from 175)."] = "{skill:202} 상급자에게 돌아가세요: {spell:12585}(175부터).",

	-- Step 60: Solid Blasting Powder to 191
	-- {item:10505} Solid Blasting Powder
	["{item:10505} to 191"] = "{item:10505}: 191까지",
	-- {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["{item:10505} is yellow at 175 (yellow 175, green 185, grey 195): about 31 crafts to 191. Each takes 2 {item:7912}. Two {item:7912} a craft (Mithril Deposits). Make plenty: the triggers, slugs and Gyro-Shot all use it."] = "{item:10505}은(는) 175에서 노란색입니다(노란색 175, 초록색 185, 회색 195). 191까지 약 31번 만드세요. 한 번에 {item:7912} 2개. 제작당 {item:7912} 두 개(미스릴 광맥). 넉넉히 만드세요. 방아쇠, 탄환, 회전 사격 장치가 모두 씁니다.",

	-- Step 61: Engineering recipes at 191
	-- {skill:202} Engineering
	["{skill:202} recipes at 191"] = "191에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:3967} Big Iron Bomb
	["Back to an {skill:202} trainer: {spell:3967} (from 190)."] = "{skill:202} 상급자에게 돌아가세요: {spell:3967}(190부터).",

	-- Step 62: Big Iron Bomb to 210
	-- {spell:3967} Big Iron Bomb
	["{spell:3967} to 210"] = "{spell:3967}: 210까지",
	-- {spell:3967} Big Iron Bomb · {item:3575} Iron Bar · {spell:3945} Heavy Blasting Powder · {spell:3973} Silver Contact · {item:2842} Silver Bar · {item:2838} Heavy Stone · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:4586} Graham Van Talen · {zone:1458} Undercity · {area:392} Ratchet · {spell:20220} Gnomish Engineering · {npc:7944} Tinkmaster Overspark · {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {item:4407} Accurate Scope · {npc:8126} Nixx Sprocketspring · {area:976} Gadgetzan · {item:10507} Solid Dynamite · {npc:2675} Explosive Sheep
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact · Mithril Tubes = {item:10559} Mithril Tube · Big Iron Bombs = {spell:3967} Big Iron Bomb
	["{spell:3967} is yellow at 191 (yellow 190, green 210, grey 230): about 27 crafts to 210. Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 74 {spell:3945} and 30 {spell:3973} (6 crafts) first. Use the 7 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby. If you got here without learning {spell:3945} and {spell:3973}, learn them now: an earlier step teaches them."] = "{spell:3967}은(는) 191에서 노란색입니다(노란색 190, 초록색 210, 회색 230): 210까지 약 27번 제작. 매번 {item:3575} 3개, {spell:3945} 3개, {spell:3973} 1개가 필요하고 2개를 만듭니다. 먼저 {spell:3945} 74개와 {spell:3973} 30개(6번 제작)를 만드십시오. 앞서 만든 {spell:3945} 7개를 쓰십시오. 위의 수량에는 빠져 있습니다. {item:2842} 하나로 은 접지 다섯 개를 만듭니다(이제 회색: 숙련도는 오르지 않지만 상인에게 갈 필요도 없습니다). {spell:3945}은(는) {item:2838}(으)로 만듭니다. 제작마다 폭탄 두 개. 전문화(선택): 숙련도 200과 캐릭터 30레벨에 {npc:5174}({zone:1455}), {npc:5518}({zone:1453}), {npc:4586}({zone:1458}) 또는 팅커위즈({area:392})가 {spell:20220}({npc:7944}, {zone:1455}, 또는 {npc:7406}, {area:35}: 미스릴관 6개, {item:4407} 하나, 고급 표적 허수아비 2개) 또는 고블린 기계공학({npc:8126}, {area:976}: 대형 철제 폭탄 20개, {item:10507} 20개, {npc:2675} 5개)(으)로 보냅니다. {item:4407} 설계도는 이제 획득 시 귀속되지만, 퀘스트는 다른 사람이 만든 조준경도 받습니다. 회원 카드는 플레이 시간 14일 동안 유효하며 갱신에 2골드가 듭니다. 하나만 고를 수 있고, 300까지 둘 다 필요 없으며, 베타에서는 시험되지 않았습니다(30레벨에서 멈췄습니다). 근처에 모루가 필요합니다. {spell:3945}와(과) {spell:3973}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 63: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "210에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12596} (from 210)."] = "{skill:202} 상급자에게 돌아가세요: {spell:12596}(210부터).",

	-- Step 64: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512}: 225까지",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:202} Engineering
	["{item:10512} is yellow at 210 (yellow 210, green 230, grey 250): about 19 crafts to 225. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Use the 19 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "{item:10512}은(는) 210에서 노란색입니다(노란색 210, 초록색 230, 회색 250). 225까지 약 19번 만드세요. 한 번에 {item:3860} 1개, {item:10505} 1개. 200개를 만듭니다. 앞서 만든 {item:10505} 19개를 쓰세요. 위 수량에는 포함되지 않습니다. 제작당 {item:3860} 한 개와(과) {item:10505} 한 개. 사냥꾼이 탄환을 삽니다. 근처에 모루가 필요합니다. {skill:202} 225은(는) 유산 시스템 이정표입니다.",

	-- Step 65: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "전문 {skill:202}",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {item:3860} Mithril Bar · {item:7912} Solid Stone · {item:12359} Thorium Bar · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}); Horde {npc:8736} ({zone:1446}). The arrow picks the nearest of your faction. 225-300 takes about 2g 80s of recipes, plus 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047} to gather or buy."] = "전문 단계는 4골드 50실버(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 225에서 300으로 올립니다. {skill:202} 200과 캐릭터 레벨 35가 필요하므로, 200부터 언제 들러도 배울 수 있습니다. 가르치는 상급자는 몇 명뿐입니다: 얼라이언스 {npc:8736}({zone:1446}), 호드 {npc:8736}({zone:1446}). 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 225-300에는 제조법 약 2골드 80실버와 {item:3860} 118개, {item:7912} 212개, {item:12359} 156개, {item:14047} 24개를 채집하거나 구매해야 합니다.",

	-- Step 66: Schematic: Thorium Widget
	-- {item:16042} Schematic: Thorium Widget · {item:15994} Thorium Widget · {skill:202} Engineering · {npc:5175} Gearcutter Cogspinner · {zone:1455} Ironforge · {npc:3413} Sovik · {zone:1454} Orgrimmar
	["{item:16042} teaches {item:15994} ({skill:202} 260) for 1g 20s. Sold by Alliance: {npc:5175} ({zone:1455}), limited stock; Horde: {npc:3413} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:16042}은(는) 1골드 20실버에 {item:15994}({skill:202} 260)을(를) 가르칩니다. 얼라이언스 판매: {npc:5175}({zone:1455}), 수량 제한; 호드 판매: {npc:3413}({zone:1454}), 수량 제한. 판매자는 한두 개를 재고로 두고 판매 후 얼마 지나면 다시 들여놓으며, 경매장에도 자주 있습니다.",

	-- Step 67: Schematic: Thorium Tube
	-- {item:16047} Schematic: Thorium Tube · {item:16000} Thorium Tube · {skill:202} Engineering · {npc:260565} Kor'gar · {zone:2548} Riverglades · {npc:11185} Xizzer Fizzbolt · {zone:1452} Winterspring
	["{item:16047} teaches {item:16000} ({skill:202} 275) for 1g 60s. Sold by {npc:260565} ({zone:2548}) and {npc:11185} ({zone:1452}), limited stock."] = "{item:16047}은(는) 1골드 60실버이며 {item:16000}({skill:202} 275)을(를) 가르쳐 줍니다. {npc:260565}({zone:2548})와(과) {npc:11185}({zone:1452})이(가) 한정 수량으로 팝니다.",

	-- Step 68: Get Mithril Bar (Alliance)
	-- {item:3860} Mithril Bar · {skill:202} Engineering · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {object:2040} Mithril Deposit · {skill:186} Mining · {item:3858} Mithril Ore · {zone:1425} The Hinterlands
	["You need 118 {item:3860} for {skill:202} 225-300: {item:10512} and {item:10513}. Mine {object:2040} ({skill:186} 175) for {item:3858} and smelt it at a forge ({skill:186} 175). The densest cluster of {object:2040} in {zone:1425} is marked. Or buy them at the Auction House."] = "",

	-- Step 69: Get Mithril Bar (Horde)
	-- {item:3860} Mithril Bar · {skill:202} Engineering · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {object:2040} Mithril Deposit · {skill:186} Mining · {item:3858} Mithril Ore · {zone:1443} Desolace
	["You need 118 {item:3860} for {skill:202} 225-300: {item:10512} and {item:10513}. Mine {object:2040} ({skill:186} 175) for {item:3858} and smelt it at a forge ({skill:186} 175). The densest cluster of {object:2040} in {zone:1443} is marked. Or buy them at the Auction House."] = "",

	-- Step 70: Get Solid Stone (Alliance)
	-- {item:7912} Solid Stone · {skill:202} Engineering · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "{item:10512} 및 {item:10513}에 필요한 {item:7912} 212개: {skill:186}: {object:2040}(숙련도 175) {zone:1425}(40-50), {zone:1444}(40-50)와(과) {zone:1447}(45-55). {zone:1425}(40-50)에서 가장 많이 나는 {object:2040} 지점이 표시됩니다."
	["You need 212 {item:7912} for {skill:202} 225-300: {item:10512} and {item:10513}. {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked. Or buy them at the Auction House."] = "",

	-- Step 71: Get Solid Stone (Horde)
	-- {item:7912} Solid Stone · {skill:202} Engineering · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "{item:10512} 및 {item:10513}에 필요한 {item:7912} 212개: {skill:186}: {object:2040}(숙련도 175) {zone:1443}(30-40), {zone:1425}(40-50)와(과) {zone:1444}(40-50). {zone:1443}(30-40)에서 가장 많이 나는 {object:2040} 지점이 표시됩니다."
	["You need 212 {item:7912} for {skill:202} 225-300: {item:10512} and {item:10513}. {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked. Or buy them at the Auction House."] = "",

	-- Step 72: Get Thorium Bar (Alliance)
	-- {item:12359} Thorium Bar
	["Get {item:12359} (Alliance)"] = "",
	-- {item:12359} Thorium Bar · {skill:202} Engineering · {item:15994} Thorium Widget · {item:16000} Thorium Tube · {object:324} Small Thorium Vein · {skill:186} Mining · {item:10620} Thorium Ore · {zone:1419} Blasted Lands
	["You need 156 {item:12359} for {skill:202} 225-300: {item:15994} and {item:16000}. Mine {object:324} ({skill:186} 245) for {item:10620} and smelt it at a forge ({skill:186} 250). The densest cluster of {object:324} in {zone:1419} is marked. Or buy them at the Auction House."] = "",

	-- Step 73: Get Thorium Bar (Horde)
	-- {item:12359} Thorium Bar
	["Get {item:12359} (Horde)"] = "",
	-- {item:12359} Thorium Bar · {skill:202} Engineering · {item:15994} Thorium Widget · {item:16000} Thorium Tube · {object:324} Small Thorium Vein · {skill:186} Mining · {item:10620} Thorium Ore · {zone:1448} Felwood
	["You need 156 {item:12359} for {skill:202} 225-300: {item:15994} and {item:16000}. Mine {object:324} ({skill:186} 245) for {item:10620} and smelt it at a forge ({skill:186} 250). The densest cluster of {object:324} in {zone:1448} is marked. Or buy them at the Auction House."] = "",

	-- Step 74: Get Runecloth
	-- {item:14047} Runecloth
	["Get {item:14047}"] = "",
	-- {item:14047} Runecloth · {skill:202} Engineering · {item:15994} Thorium Widget
	["You need 24 {item:14047} for {skill:202} 225-300: {item:15994}. Humanoids of level 45-60 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14047} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 75: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512}: 245까지",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 50 {item:10505} first. Use the 12 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. If you got here without learning {item:10505} and {item:10512}, learn them now: an earlier step teaches them."] = "{item:10512}은(는) 225에서 노란색입니다(노란색 210, 초록색 230, 회색 250): 245까지 약 62번 제작. 매번 {item:3860} 1개와 {item:10505} 1개가 필요하고 200개를 만듭니다. 먼저 {item:10505} 50개를 만드십시오. 앞서 만든 {item:10505} 12개를 쓰십시오. 위의 수량에는 빠져 있습니다. 제작마다 {item:3860} 하나와 {item:10505} 하나. 탄환은 사냥꾼이 삽니다. 근처에 모루가 필요합니다. {item:10505}와(과) {item:10512}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 76: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "245에서 {skill:202} 제조법",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} (from 245)."] = "{skill:202} 상급자에게 돌아가세요: {spell:12621}(245부터).",

	-- Step 77: Mithril Gyro-Shot to 265
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 265"] = "{item:10513}: 265까지",
	-- {item:10513} Mithril Gyro-Shot · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:10513} is yellow at 245 (yellow 245, green 265, grey 285): about 28 crafts to 265. Each takes 2 {item:3860} and 2 {item:10505} and makes 200. Make the 56 {item:10505} first. Two Mithril Bars and two {item:10505} a craft. Needs an anvil nearby. If you got here without learning {item:10505}, learn it now: an earlier step teaches it."] = "{item:10513}은(는) 245에서 노란색입니다(노란색 245, 초록색 265, 회색 285): 265까지 약 28번 제작. 매번 {item:3860} 2개와 {item:10505} 2개가 필요하고 200개를 만듭니다. 먼저 {item:10505} 56개를 만드십시오. 제작마다 미스릴 주괴 두 개와 {item:10505} 두 개. 근처에 모루가 필요합니다. {item:10505}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 78: Thorium Widget to 287
	-- {item:15994} Thorium Widget
	["{item:15994} to 287"] = "{item:15994}: 287까지",
	-- {item:15994} Thorium Widget · {item:12359} Thorium Bar · {item:14047} Runecloth
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:15994} is orange at 265 (yellow 280, green 290, grey 300): about 24 crafts to 287. Each takes 3 {item:12359} and 1 {item:14047}. Three Thorium Bars and a {item:14047} a craft; the widgets are parts for the later Thorium gadgets. Needs an anvil nearby."] = "{item:15994}은(는) 265에 주황색입니다(노란색 280, 초록색 290, 회색 300). 287까지 약 24번 만드세요. 한 번에 {item:12359} 3개, {item:14047} 1개. 제작당 토륨 주괴 세 개와(과) {item:14047} 한 개. 부품은 이후 토륨 도구의 재료입니다. 근처에 모루가 필요합니다.",
	["from the recipe in your bags"] = "가방에 있는 제조법으로",

	-- Step 79: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000}: 300까지",
	-- {item:16000} Thorium Tube · {item:12359} Thorium Bar · {skill:202} Engineering
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:16000} is orange at 287 (yellow 295, green 305, grey 315): about 14 crafts to 300. Each takes 6 {item:12359}. The schematic binds when picked up; six Thorium Bars a craft. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "{item:16000}은(는) 287에 주황색입니다(노란색 295, 초록색 305, 회색 315). 300까지 약 14번 만드세요. 한 번에 {item:12359} 6개. 도면은 주울 때 귀속됩니다. 제작당 토륨 주괴 여섯 개. 근처에 모루가 필요합니다. {skill:202} 300은(는) 유산 시스템 이정표입니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100 {item:2841} for {item:6533} and {spell:3953}: {skill:186}: smelt {item:2840} and {item:3576}."] = "{item:6533}와(과) {spell:3953}에 쓸 {item:2841} 100개: {skill:186}: {item:2840}와(과) {item:3576} 제련.",
	-- ["118 {item:3860} for {item:10512} and {item:10513}: {skill:186}: smelt {item:3858}."] = "{item:10512}와(과) {item:10513}에 쓸 {item:3860} 118개: {skill:186}: {item:3858} 제련.",
	-- ["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "{spell:3930}에 필요한 {item:2836} 15개: {skill:186}: {object:1732}(숙련도 65). {zone:1413}에서 가장 많이 나는 {object:1732} 지점이 표시됩니다.",
	-- ["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "{spell:3930}에 필요한 {item:2836} 15개: {skill:186}: {object:1732}(숙련도 65). {zone:1421}에서 가장 많이 나는 {object:1732} 지점이 표시됩니다.",
	-- ["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "{spell:3930}에 필요한 {item:2836} 15개: {skill:186}: {object:1732}(숙련도 65). {zone:1432}에서 가장 많이 나는 {object:1732} 지점이 표시됩니다.",
	-- ["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "{spell:3930}에 필요한 {item:2836} 15개: {skill:186}: {object:1732}(숙련도 65). {zone:1436}에서 가장 많이 나는 {object:1732} 지점이 표시됩니다.",
	-- ["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "{spell:3930}에 필요한 {item:2836} 15개: {skill:186}: {object:1732}(숙련도 65). {zone:1439}에서 가장 많이 나는 {object:1732} 지점이 표시됩니다.",
	-- ["156 {item:12359} for {item:15994} and {item:16000}: {skill:186}: smelt {item:10620}."] = "{item:15994}와(과) {item:16000}에 쓸 {item:12359} 156개: {skill:186}: {item:10620} 제련.",
	-- ["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "{spell:3953}에 필요한 {item:2319} 19개: {skill:393}: 18-30레벨 야수. 여기서 {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}와(과) {npc:2354}을(를) 무두질하세요(레벨 18-30). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this."] = "{spell:3953}에 필요한 {item:2319} 19개: {skill:393}: 18-30레벨 야수. 여기서 {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}와(과) {npc:3817}을(를) 무두질하세요(레벨 18-30). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["19 {item:2592} for {spell:3953}: humanoids of level 15-30 drop it. Keep what you loot as you level, or take it from your bank."] = "{spell:3953}에 쓸 {item:2592} 19개: 15-30레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나 은행에서 꺼내세요.",
	-- ["19 {item:3860} for {item:10512}: {skill:186}: smelt {item:3858}."] = "{item:10512}에 쓸 {item:3860} 19개: {skill:186}: {item:3858} 제련.",
	-- ["2 {item:2842} for {spell:3950}: {skill:186}: smelt {item:2775}."] = "{spell:3950}에 쓸 {item:2842} 2개: {skill:186}: {item:2775} 제련.",
	-- ["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "{item:10512} 및 {item:10513}에 필요한 {item:7912} 212개: {skill:186}: {object:2040}(숙련도 175) {zone:1425}(40-50), {zone:1444}(40-50)와(과) {zone:1447}(45-55). {zone:1425}(40-50)에서 가장 많이 나는 {object:2040} 지점이 표시됩니다.",
	-- ["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "{item:10512} 및 {item:10513}에 필요한 {item:7912} 212개: {skill:186}: {object:2040}(숙련도 175) {zone:1443}(30-40), {zone:1425}(40-50)와(과) {zone:1444}(40-50). {zone:1443}(30-40)에서 가장 많이 나는 {object:2040} 지점이 표시됩니다.",
	-- ["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it. Keep what you loot as you level, or take it from your bank."] = "{item:15994}에 쓸 {item:14047} 24개: 45-60레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나 은행에서 꺼내세요.",
	-- ["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "{spell:3945}에 필요한 {item:2838} 27개: {skill:186}: {object:1735}(숙련도 125). {zone:1413}에서 가장 많이 나는 {object:1735} 지점이 표시됩니다.",
	-- ["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "{spell:3945}에 필요한 {item:2838} 27개: {skill:186}: {object:1735}(숙련도 125). {zone:1417}에서 가장 많이 나는 {object:1735} 지점이 표시됩니다.",
	-- ["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "{spell:3945}에 필요한 {item:2838} 27개: {skill:186}: {object:1735}(숙련도 125). {zone:1440}에서 가장 많이 나는 {object:1735} 지점이 표시됩니다.",
	-- ["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1413} is marked."] = "{item:6533}에 필요한 {item:2836} 31개: {skill:186}: {object:1732}(숙련도 65), {zone:1413}(10-25), {zone:1440}(18-30), {zone:1424}(20-30). {zone:1413}에서 {object:1732}이(가) 가장 많은 곳이 표시되어 있습니다.",
	-- ["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1440} is marked."] = "{item:6533}에 필요한 {item:2836} 31개: {skill:186}: {object:1732}(숙련도 65) {zone:1413}(10-25), {zone:1440}(18-30)와(과) {zone:1424}(20-30). {zone:1440}(18-30)에서 가장 많이 나는 {object:1732} 지점이 표시됩니다.",
	-- ["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1432} is marked."] = "{item:6533}에 필요한 {item:2836} 31개: {skill:186}: {object:1732}(숙련도 65) {zone:1432}(10-20), {zone:1440}(18-30)와(과) {zone:1424}(20-30). {zone:1432}(10-20)에서 가장 많이 나는 {object:1732} 지점이 표시됩니다.",
	-- ["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "{spell:3918}에 필요한 {item:2835} 46개: {skill:186}: {object:1731}(숙련도 1). {zone:1411}에서 가장 많이 나는 {object:1731} 지점이 표시됩니다.",
	-- ["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "{spell:3918}에 필요한 {item:2835} 46개: {skill:186}: {object:1731}(숙련도 1). {zone:1412}에서 가장 많이 나는 {object:1731} 지점이 표시됩니다.",
	-- ["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "{spell:3918}에 필요한 {item:2835} 46개: {skill:186}: {object:1731}(숙련도 1). {zone:1420}에서 가장 많이 나는 {object:1731} 지점이 표시됩니다.",
	-- ["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "{spell:3918}에 필요한 {item:2835} 46개: {skill:186}: {object:1731}(숙련도 1). {zone:1426}에서 가장 많이 나는 {object:1731} 지점이 표시됩니다.",
	-- ["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "{spell:3918}에 필요한 {item:2835} 46개: {skill:186}: {object:1731}(숙련도 1). {zone:1429}에서 가장 많이 나는 {object:1731} 지점이 표시됩니다.",
	-- ["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "{spell:3918}에 필요한 {item:2835} 46개: {skill:186}: {object:1731}(숙련도 1). {zone:1439}에서 가장 많이 나는 {object:1731} 지점이 표시됩니다.",
	-- ["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "{spell:3918}에 필요한 {item:2835} 46개: {skill:186}: {object:1731}(숙련도 1). {zone:2521}에서 가장 많이 나는 {object:1731} 지점이 표시됩니다.",
	-- ["6 {item:2842} for {spell:3967}: {skill:186}: smelt {item:2775}."] = "{spell:3967}에 쓸 {item:2842} 6개: {skill:186}: {item:2775} 제련.",
	-- ["61 {item:2841} for {item:6712} and {spell:3950}: {skill:186}: smelt {item:2840} and {item:3576}."] = "{item:6712}와(과) {spell:3950}에 쓸 {item:2841} 61개: {skill:186}: {item:2840}와(과) {item:3576} 제련.",
	-- ["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "{item:10505}에 필요한 {item:7912} 62개: {skill:186}: {object:2040}(숙련도 175) {zone:1434}(30-45), {zone:1425}(40-50)와(과) {zone:1444}(40-50). {zone:1434}(30-45)에서 가장 많이 나는 {object:2040} 지점이 표시됩니다.",
	-- ["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "{item:10505}에 필요한 {item:7912} 62개: {skill:186}: {object:2040}(숙련도 175) {zone:1443}(30-40), {zone:1425}(40-50)와(과) {zone:1444}(40-50). {zone:1443}(30-40)에서 가장 많이 나는 {object:2040} 지점이 표시됩니다.",
	-- ["72 {item:2840} for {spell:3930}, {spell:3924} and {item:6712}: {skill:186}: smelt {item:2770}."] = "{spell:3930}, {spell:3924}, {item:6712}에 쓸 {item:2840} 72개: {skill:186}: {item:2770} 제련.",
	-- ["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "{spell:3967}에 필요한 {item:2838} 74개: {skill:186}: {object:1735}(숙련도 125) {zone:1417}(30-40), {zone:1434}(30-45)와(과) {zone:1443}(30-40). {zone:1417}(30-40)에서 가장 많이 나는 {object:1735} 지점이 표시됩니다.",
	-- ["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "{spell:3967}에 필요한 {item:2838} 74개: {skill:186}: {object:1735}(숙련도 125) {zone:1441}(25-35), {zone:1417}(30-40)와(과) {zone:1434}(30-45). {zone:1441}(25-35)에서 가장 많이 나는 {object:1735} 지점이 표시됩니다.",
	-- ["75 {item:2840} for {spell:3922}, {item:6219} and {spell:3924}: {skill:186}: smelt {item:2770}."] = "{spell:3922}, {item:6219}, {spell:3924}에 쓸 {item:2840} 75개: {skill:186}: {item:2770} 제련.",
	-- ["81 {item:3575} for {spell:3967}: {skill:186}: smelt {item:2772}."] = "{spell:3967}에 쓸 {item:3575} 81개: {skill:186}: {item:2772} 제련.",
	-- ["Apprentice {skill:202}"] = "초급 {skill:202}",
	-- ["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "전문은(는) 캐릭터 레벨 35, {skill:202} 200이(가) 필요하며 최대 숙련도를 300(으)로 올립니다. 225-300 재료는 모두 약 67골드입니다.",
	-- ["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "{skill:202} 상급자에게 돌아가세요. {spell:12590}은(는) {skill:202} 175부터 배울 수 있습니다.",
	-- ["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "{skill:202} 상급자에게 돌아가세요. {spell:3922}은(는) {skill:202} 45부터 배울 수 있습니다.",
	-- ["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "{skill:202} 상급자에게 돌아가세요. {spell:3926}은(는) {skill:202} 95부터 배울 수 있습니다.",
	-- ["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "{skill:202} 상급자에게 돌아가세요. {spell:3942}은(는) {skill:202} 125부터 배울 수 있습니다.",
	-- ["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2880} 18개(18실버)와(과) {item:5956}(도구: 하나를 사서 가방에 두세요, 18코퍼). 모두 약 18실버 18코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:5519}, {npc:5514}, {npc:1286}).",
	-- ["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "숙련은(는) 캐릭터 레벨 20, {skill:202} 125이(가) 필요하며 최대 숙련도를 225(으)로 올립니다. 150-225 재료는 모두 약 15골드입니다.",
	-- ["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "수습은(는) 캐릭터 레벨 10, {skill:202} 50이(가) 필요하며 최대 숙련도를 150(으)로 올립니다. 75-150 재료는 모두 약 3골드 23실버입니다.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Polestar가 레벨과 진영에 맞춰 고른 사냥터에서 이것을 떨어뜨리는 몹을 처치하세요. 경매장도 됩니다.",
	-- ["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "20까지 주황색(만들 때마다 1점), 30까지 노란색, 40까지 초록색입니다.",
	-- ["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "280까지 주황색(만들 때마다 1점), 290까지 노란색, 300까지 초록색입니다. 근처에 모루가 필요합니다.",
	-- ["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "295까지 주황색(만들 때마다 1점), 305까지 노란색, 315까지 초록색입니다. 근처에 모루가 필요합니다. {skill:202} 300은(는) 유산 시스템 단계입니다.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, 무쇠턱거북, {npc:2384}, {npc:2354}의 가죽을 벗기세요(18-30레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817}의 가죽을 벗기세요(18-30레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "무두질, 마력 추출 또는 다른 전문 기술로 얻는 재료입니다. 직접 모으거나 경매장에서 사세요.",
	-- ["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "{item:15994}을(를) 배웁니다({skill:202} 260 필요). 상인이 한정 수량으로 팔며 재입고됩니다. 경매장에도 자주 있습니다.",
	-- ["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "{item:16000}을(를) 배웁니다({skill:202} 275 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",
	-- ["What 1-75 takes that the Auction House sells: 46 {item:2835} and 75 {item:2840}. The counts drop by what your bags, bank and mail hold."] = "1-75 구간에 필요한 것 중 경매장에서 파는 것: {item:2835} 46개, {item:2840} 75개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 150-225 takes that the Auction House sells: 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "150-225 구간에 필요한 것 중 경매장에서 파는 것: {item:2319} 19개, {item:2592} 19개, {item:2836} 31개, {item:2838} 74개, {item:2841} 100개, {item:2842} 6개, {item:3575} 81개, {item:3860} 19개, {item:7912} 62개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 225-300 takes that the Auction House sells: 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047}. The counts drop by what your bags, bank and mail hold."] = "225-300 구간에 필요한 것 중 경매장에서 파는 것: {item:3860} 118개, {item:7912} 212개, {item:12359} 156개, {item:14047} 24개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 75-150 takes that the Auction House sells: 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842}. The counts drop by what your bags, bank and mail hold."] = "75-150 구간에 필요한 것 중 경매장에서 파는 것: {item:2836} 15개, {item:2838} 27개, {item:2840} 72개, {item:2841} 61개, {item:2842} 2개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "110까지 노란색, 125까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",
	-- ["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "130까지 노란색, 155까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",
	-- ["Yellow until 135, green until 145: not every craft gives a point."] = "135까지 노란색, 145까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "150까지 노란색, 175까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다. {skill:202} 150은(는) 유산 시스템 단계입니다.",
	-- ["Yellow until 170, green until 195: not every craft gives a point."] = "170까지 노란색, 195까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "195까지 노란색, 215까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "230까지 노란색, 250까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "230까지 노란색, 250까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다. {skill:202} 225은(는) 유산 시스템 단계입니다.",
	-- ["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "265까지 노란색, 285까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",
	-- ["Yellow until 45, green until 60: not every craft gives a point."] = "45까지 노란색, 60까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "52까지 노란색, 60까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "75까지 노란색, 90까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "75까지 노란색, 90까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다. 75은(는) 초급 최대치입니다.",
	-- ["Yellow until 90, green until 95: not every craft gives a point."] = "90까지 노란색, 95까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "95까지 노란색, 110까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",
	-- ["{item:10498} to 210"] = "{item:10498}: 210까지",
	-- ["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 50 {item:10505} first. Use the 12 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby."] = "{item:10512}은(는) 225에서 노란색입니다(노란색 210, 초록색 230, 회색 250). 245까지 약 62번 만드세요. 한 번에 {item:3860} 1개, {item:10505} 1개. 200개를 만듭니다. 먼저 {item:10505} 50개를 만드세요. 앞서 만든 {item:10505} 12개를 쓰세요. 위 수량에는 포함되지 않습니다. 제작당 {item:3860} 한 개와(과) {item:10505} 한 개. 사냥꾼이 탄환을 삽니다. 근처에 모루가 필요합니다.",
	-- ["{item:10513} is yellow at 245 (yellow 245, green 265, grey 285): about 28 crafts to 265. Each takes 2 {item:3860} and 2 {item:10505} and makes 200. Make the 56 {item:10505} first. Two Mithril Bars and two {item:10505} a craft. Needs an anvil nearby."] = "{item:10513}은(는) 245에서 노란색입니다(노란색 245, 초록색 265, 회색 285). 265까지 약 28번 만드세요. 한 번에 {item:3860} 2개, {item:10505} 2개. 200개를 만듭니다. 먼저 {item:10505} 56개를 만드세요. 제작당 미스릴 주괴 두 개와(과) {item:10505} 두 개. 근처에 모루가 필요합니다.",
	-- ["{item:14047} (Alliance)"] = "{item:14047} (얼라이언스)",
	-- ["{item:14047} (Horde)"] = "{item:14047} (호드)",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (얼라이언스)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (호드)",
	-- ["{item:2592} (Alliance)"] = "{item:2592} (얼라이언스)",
	-- ["{item:2592} (Horde)"] = "{item:2592} (호드)",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (얼라이언스)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (호드)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}은(는) {object:1731} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["{item:2836} (Alliance)"] = "{item:2836} (얼라이언스)",
	-- ["{item:2836} (Horde)"] = "{item:2836} (호드)",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}은(는) {object:1732} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["{item:2838} (Alliance)"] = "{item:2838} (얼라이언스)",
	-- ["{item:2838} (Horde)"] = "{item:2838} (호드)",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}은(는) {object:1735} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: 도구이니 가방에 넣어 두세요",
	-- ["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166. Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 31 {spell:3929} first. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen."] = "{item:6533}은(는) 150에서 노란색입니다(노란색 150, 초록색 160, 회색 170). 166까지 약 31번 만드세요. 한 번에 {item:2841} 2개, {item:6530} 1개, {spell:3929} 1개. 3개를 만듭니다. 먼저 {spell:3929} 31개를 만드세요. {item:6530}은(는) 무역 및 낚시 용품 상인에게서. 끌어당김 장치는 낚시꾼에게 팔립니다.",
	-- ["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125. Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 29 {spell:3922} first. Use the 33 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby."] = "{item:6712}은(는) 100에 주황색입니다(노란색 115, 초록색 122, 회색 130). 125까지 약 31번 만드세요. 한 번에 {item:2841} 1개, {spell:3922} 2개, {item:2880} 1개. 먼저 {spell:3922} 29개를 만드세요. 앞서 만든 {spell:3922} 33개를 쓰세요. 위 수량에는 포함되지 않습니다. 연습용 자물쇠는 도적에게 팔거나 직접 여세요. 근처에 모루가 필요합니다.",
	-- ["{item:7912} (Alliance)"] = "{item:7912} (얼라이언스)",
	-- ["{item:7912} (Horde)"] = "{item:7912} (호드)",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}은(는) {object:2040} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "이곳의 {npc:3263}(19-20레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "이곳의 {npc:6189}(51-52레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "이곳의 {npc:7027}(56-57레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "이곳의 {npc:98}(17-18레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: {item:10620} 제련 (또는 경매장)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: {item:2770} 제련 (또는 경매장)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: {item:2840} 제련 (또는 경매장)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: {item:3575} 제련 (또는 경매장)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: {item:3858} 제련 (또는 경매장)",
	-- ["{skill:202} 1-75: Auction House"] = "{skill:202} 1-75: 경매장",
	-- ["{skill:202} 150-225: Auction House"] = "{skill:202} 150-225: 경매장",
	-- ["{skill:202} 225-300: Auction House"] = "{skill:202} 225-300: 경매장",
	-- ["{skill:202} 75-150: Auction House"] = "{skill:202} 75-150: 경매장",
	-- ["{skill:202} materials for 1-75"] = "{skill:202} 재료(1-75)",
	-- ["{skill:202} materials for 150-225"] = "{skill:202} 재료(150-225)",
	-- ["{skill:202} materials for 225-300"] = "{skill:202} 재료(225-300)",
	-- ["{skill:202} materials for 75-150"] = "{skill:202} 재료(75-150)",
	-- ["{skill:202} recipes at 139"] = "139에서 {skill:202} 제조법",
	-- ["{skill:202} recipes at 95"] = "95에서 {skill:202} 제조법",
	-- ["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202}은(는) 레벨업과 함께 진행합니다. Forever의 유산 시스템은 제작 전문 기술 숙련도 150, 225, 300(수습, 숙련, 전문 최대치)에 보상을 주므로, 각 단계가 중요합니다. 1-75 재료는 모두 약 62실버입니다.",
	-- ["{spell:3920} to 45"] = "{spell:3920}: 45까지",
	-- ["{spell:3923} to 75"] = "{spell:3923}: 75까지",
	-- ["{spell:3923} to 80"] = "{spell:3923}: 80까지",
	-- ["{spell:3924} is yellow at 94 (yellow 80, green 95, grey 110): about 14 crafts to 100. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby."] = "{spell:3924}은(는) 94에서 노란색입니다(노란색 80, 초록색 95, 회색 110). 100까지 약 14번 만드세요. 한 번에 {item:2840} 2개, {item:2880} 1개. 제작당 구리 주괴 두 개와(과) {item:2880} 한 개(대장기술 및 기술기술 용품 상인). 근처에 모루가 필요합니다.",
	-- ["{spell:3926} to 111"] = "{spell:3926}: 111까지",
	-- ["{spell:3929} to 95"] = "{spell:3929}: 95까지",
	-- ["{spell:3937} to 125"] = "{spell:3937}: 125까지",
	-- ["{spell:3942} to 150"] = "{spell:3942}: 150까지",
	-- ["{spell:3967} is yellow at 191 (yellow 190, green 210, grey 230): about 27 crafts to 210. Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 74 {spell:3945} and 30 {spell:3973} (6 crafts) first. Use the 7 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "{spell:3967}은(는) 191에서 노란색입니다(노란색 190, 초록색 210, 회색 230). 210까지 약 27번 만드세요. 한 번에 {item:3575} 3개, {spell:3945} 3개, {spell:3973} 1개. 2개를 만듭니다. 먼저 {spell:3945} 74개와(과) {spell:3973} 30개를 만드세요(6번 제작). 앞서 만든 {spell:3945} 7개를 쓰세요. 위 수량에는 포함되지 않습니다. {item:2842} 하나로 은 접점 다섯 개를 만듭니다(지금은 회색: 포인트는 없지만 상인에 갈 일도 없습니다). {spell:3945}은(는) {item:2838}에서 나옵니다. 제작당 수류탄 두 개입니다. 전문화(선택): 200과 캐릭터 레벨 30에서 {npc:5174}({zone:1455}), {npc:5518}({zone:1453}), {npc:4586}({zone:1458}) 또는 틴커위즈({area:392})가 {spell:20220}({npc:7944}, {zone:1455}, 또는 {npc:7406}, {area:35}: 미스릴 관 6개, {item:4407}, 고급 표적 인형 2개)이나(나) 고블린 기술기술({npc:8126}, {area:976}: 대형 철 폭탄 20개, {item:10507} 20개, {npc:2675} 5개)로 보냅니다. {item:4407} 도면은 이제 주울 때 귀속되지만, 퀘스트는 다른 사람이 만든 조준경을 요구합니다. 회원권은 14일간 유지되고 갱신에 2골드입니다. 하나만 고를 수 있고, 300에는 둘 다 필요하지 않으며, 베타는 레벨 30에서 멈춰 검증되지 않았습니다. 근처에 모루가 필요합니다.",
}
