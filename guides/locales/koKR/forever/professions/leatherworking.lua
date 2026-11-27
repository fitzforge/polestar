-- Korean (koKR): the guide forever/professions/leatherworking (forever/professions/leatherworking.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Leatherworking
	-- {skill:165} Leatherworking
	["Learn {skill:165}"] = "{skill:165} 배우기",
	-- {skill:165} Leatherworking · {npc:1632} Adele Fielder · {zone:1429} Elwynn Forest · {npc:11083} Darianna · {zone:1457} Darnassus · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {npc:1466} Gretta Finespindle · {zone:1455} Ironforge · {npc:251993} Indari Sunseam · {npc:3605} Nadyia Maneweaver · {zone:1438} Teldrassil · {npc:11096} Randal Worth · {zone:1453} Stormwind City · {npc:3069} Chaw Stronghide · {zone:1412} Mulgore · {npc:223} Dan Golthas · {zone:1458} Undercity · {npc:5811} Kamari · {zone:1454} Orgrimmar · {npc:3008} Mak · {zone:1456} Thunder Bluff · {npc:3549} Shelene Rhobart · {zone:1420} Tirisfal Glades · {skill:393} Skinning · {item:2318} Light Leather · {item:2320} Coarse Thread
	["Apprentice {skill:165} lets you craft up to 75 for 10c, at any character level. Not every {skill:165} trainer teaches it: Alliance {npc:1632} ({zone:1429}), {npc:11083} ({zone:1457}), {npc:252376} ({zone:2521}), {npc:1466} ({zone:1455}), {npc:251993} ({zone:2521}), {npc:3605} ({zone:1438}) and {npc:11096} ({zone:1453}); Horde {npc:3069} ({zone:1412}), {npc:223} ({zone:1458}), {npc:252376} ({zone:2521}), {npc:251993} ({zone:2521}), {npc:5811} ({zone:1454}), {npc:3008} ({zone:1456}) and {npc:3549} ({zone:1420}). The arrow picks the nearest of your faction. Pair it with {skill:393}: {item:2318} comes from the beasts of every starting zone. {item:2320} and Salt are sold by leatherworking and trade supplies vendors. 1-75 takes about 1s 50c of recipes and 5s of vendor goods, plus 349 {item:2318} to gather or buy."] = "초급 {skill:165}은(는) 10코퍼로 75까지 제작할 수 있게 해 주며, 캐릭터 레벨 제한이 없습니다. 모든 {skill:165} 상급자가 가르치지는 않습니다: 얼라이언스는 {npc:1632}({zone:1429}), {npc:11083}({zone:1457}), {npc:252376}({zone:2521}), {npc:1466}({zone:1455}), {npc:251993}({zone:2521}), {npc:3605}({zone:1438}), {npc:11096}({zone:1453}), 호드는 {npc:3069}({zone:1412}), {npc:223}({zone:1458}), {npc:252376}({zone:2521}), {npc:251993}({zone:2521}), {npc:5811}({zone:1454}), {npc:3008}({zone:1456}), {npc:3549}({zone:1420})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. {skill:393}와(과) 함께 배우세요. {item:2318}은(는) 모든 시작 지역의 야수에게서 나옵니다. {item:2320}와(과) 소금은 가죽세공 재료 상인과 잡화 상인이 팝니다. 1-75에는 제조법 약 1실버 50코퍼와 상인 재료 약 5실버, 그리고 채집하거나 살 {item:2318} 349개가 듭니다.",

	-- Step 2: Leatherworking 1-75: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 1-75: vendor goods"] = "{skill:165} 1-75: 상인 재료",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 50 {item:2320} (5s); about 5s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2320} 50개(5실버). 모두 약 5실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367}, {npc:5817}).",

	-- Step 3: Get Light Leather (Elwynn Forest)
	-- {item:2318} Light Leather · {zone:1429} Elwynn Forest
	["Get {item:2318} ({zone:1429})"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1922} Gray Forest Wolf · {npc:524} Rockhide Boar · {npc:113} Stonetusk Boar · {npc:822} Young Forest Bear
	-- was: ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1922}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756}, {spell:3763}에 필요한 {item:2318} 349개(그중 210개는 75-150용: 지금 모두 모으십시오): {skill:393}: 5-20레벨 짐승. 여기서 {npc:1922}, 배회하는 짐승, {npc:524}, {npc:113}, {npc:822}의 가죽을 벗기십시오(5-20레벨). {skill:393} 가이드가 경로를 안내합니다."
	["You need 349 {item:2318} for {skill:165} 1-75: {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: get them all now). {skill:393}: beasts of level 5-20. Skin {npc:1922}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 4: Get Light Leather (Dun Morogh)
	-- {item:2318} Light Leather · {zone:1426} Dun Morogh
	["Get {item:2318} ({zone:1426})"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1125} Crag Boar · {npc:1127} Elder Crag Boar · {npc:1196} Ice Claw Bear · {npc:1199} Juvenile Snow Leopard · {npc:1126} Large Crag Boar · {npc:1689} Scarred Crag Boar · {npc:1201} Snow Leopard · {npc:1138} Snow Tracker Wolf · {npc:1131} Winter Wolf · {npc:1128} Young Black Bear
	-- was: ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} and {npc:1128} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}와(과) {npc:1128}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 349 {item:2318} for {skill:165} 1-75: {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: get them all now). {skill:393}: beasts of level 5-20. Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} and {npc:1128} here (level 5-20); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 5: Get Light Leather (Teldrassil)
	-- {item:2318} Light Leather · {zone:1438} Teldrassil
	["Get {item:2318} ({zone:1438})"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2033} Elder Nightsaber · {npc:2043} Nightsaber Stalker
	-- was: ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:2033}, Nightsaber and {npc:2043} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:2033}, Nightsaber와(과) {npc:2043}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 349 {item:2318} for {skill:165} 1-75: {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: get them all now). {skill:393}: beasts of level 5-20. Skin {npc:2033}, Nightsaber and {npc:2043} here (level 5-20); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 6: Get Light Leather (Zephras Isle)
	-- {item:2318} Light Leather · {zone:2521} Zephras Isle
	["Get {item:2318} ({zone:2521})"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:250928} Highlands Ursera · {npc:251284} Hippogryph Protector · {npc:251291} Hippogryph Youth · {npc:251707} Ornery Galestrider · {npc:256092} Shadowgale Shriekling · {npc:253282} Shriekling Fledgling · {npc:250874} Vuldren Alpha · {npc:254588} Windsong Crawler
	-- was: ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} and {npc:254588} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874}와(과) {npc:254588}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 349 {item:2318} for {skill:165} 1-75: {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: get them all now). {skill:393}: beasts of level 5-20. Skin Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} and {npc:254588} here (level 5-20); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 7: Get Light Leather (Durotar)
	-- {item:2318} Light Leather · {zone:1411} Durotar
	["Get {item:2318} ({zone:1411})"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:3126} Armored Scorpid · {npc:3123} Bloodtalon Scythemaw · {npc:3122} Bloodtalon Taillasher · {npc:3125} Clattering Scorpid · {npc:3099} Dire Mottled Boar · {npc:3110} Dreadmaw Crocolisk · {npc:3121} Durotar Tiger · {npc:3100} Elder Mottled Boar · {npc:3130} Thunder Lizard · {npc:3127} Venomtail Scorpid
	-- was: ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} and {npc:3127} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}와(과) {npc:3127}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 349 {item:2318} for {skill:165} 1-75: {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: get them all now). {skill:393}: beasts of level 5-20. Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} and {npc:3127} here (level 5-20); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 8: Get Light Leather (Mulgore)
	-- {item:2318} Light Leather · {zone:1412} Mulgore
	["Get {item:2318} ({zone:1412})"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2956} Adult Plainstrider · {npc:2957} Elder Plainstrider · {npc:3035} Flatland Cougar · {npc:3566} Flatland Prowler · {npc:2972} Kodo Calf · {npc:2959} Prairie Stalker · {npc:2958} Prairie Wolf · {npc:2960} Prairie Wolf Alpha
	-- was: ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} and {npc:2960} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958}와(과) {npc:2960}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 349 {item:2318} for {skill:165} 1-75: {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: get them all now). {skill:393}: beasts of level 5-20. Skin {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} and {npc:2960} here (level 5-20); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 9: Get Light Leather (Tirisfal Glades)
	-- {item:2318} Light Leather · {zone:1420} Tirisfal Glades
	["Get {item:2318} ({zone:1420})"] = "",
	-- {item:2318} Light Leather · {skill:165} Leatherworking · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1548} Cursed Darkhound · {npc:1547} Decrepit Darkhound · {npc:1553} Greater Duskbat · {npc:1549} Ravenous Darkhound · {npc:1554} Vampiric Duskbat
	-- was: ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} and {npc:1554} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549}와(과) {npc:1554}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 349 {item:2318} for {skill:165} 1-75: {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: get them all now). {skill:393}: beasts of level 5-20. Skin {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} and {npc:1554} here (level 5-20); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 10: Light Armor Kit to 51
	-- {spell:2152} Light Armor Kit
	["{spell:2152} to 51"] = "{spell:2152}: 51까지",
	-- {spell:2152} Light Armor Kit · {item:2318} Light Leather
	["{spell:2152} is orange at 1 (yellow 30, green 45, grey 60): about 64 crafts to 51. Each takes 1 {item:2318}. One {item:2318} a craft; the kits sell to vendors."] = "{spell:2152}은(는) 1에 주황색입니다(노란색 30, 초록색 45, 회색 60). 51까지 약 64번 만드세요. 한 번에 {item:2318} 1개. 제작당 {item:2318} 한 개. 키트는 상인에게 팔립니다.",

	-- Step 11: Leatherworking recipes at 51
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 51"] = "51에서 {skill:165} 제조법",
	-- {skill:165} Leatherworking · {spell:3756} Embossed Leather Gloves · {spell:1229432} Camp Tent · {item:2318} Light Leather
	["Back to a {skill:165} trainer: {spell:3756} (from 40, 1s 50c). Also learn {spell:1229432} (1s): Forever's {skill:165} camp item, 5 {item:2318}, placed at a campsite beside a campfire. The Camping 101: {skill:165} quest from your starting area's camping guide (after The Great Outdoors) sends you to a leatherworking trainer who teaches it free."] = "{skill:165} 상급자에게 돌아가세요: {spell:3756}(40부터, 1s 50c). {spell:1229432}(1s)도 배우세요. Forever의 {skill:165} 야영 아이템으로, {item:2318} 5개를 들고 모닥불 옆 야영지에 설치하면 됩니다. 시작 지역의 야영 가이드에 있는 야영 기초 101: {skill:165} 퀘스트(위대한 야외 다음)가 상급자에게 보내며, 거기서 무료로 가르칩니다.",

	-- Step 12: Embossed Leather Gloves to 75
	-- {spell:3756} Embossed Leather Gloves
	["{spell:3756} to 75"] = "{spell:3756}: 75까지",
	-- {spell:3756} Embossed Leather Gloves · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3756} is orange at 51 (yellow 70, green 85, grey 100): about 25 crafts to 75. Each takes 3 {item:2318} and 2 {item:2320}. Forever teaches {spell:3756} from 40."] = "{spell:3756}은(는) 51에 주황색입니다(노란색 70, 초록색 85, 회색 100). 75까지 약 25번 만드세요. 한 번에 {item:2318} 3개, {item:2320} 2개. Forever는 {spell:3756}을(를) 40에서 가르칩니다.",

	-- Step 13: Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Journeyman {skill:165}"] = "수습 {skill:165}",
	-- {skill:165} Leatherworking · {npc:3967} Aayndia Floralwind · {zone:1440} Ashenvale · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {npc:11081} Faldron · {zone:1457} Darnassus · {npc:5127} Fimble Finespindle · {zone:1455} Ironforge · {npc:5564} Simon Tanner · {zone:1453} Stormwind City · {npc:4588} Arthur Moore · {zone:1458} Undercity · {npc:1385} Brawn · {zone:1434} Stranglethorn Vale · {npc:3365} Karolek · {zone:1454} Orgrimmar · {npc:3703} Krulmoo Fullmoon · {zone:1413} The Barrens · {npc:8153} Narv Hidecrafter · {zone:1443} Desolace · {npc:11084} Tarn · {zone:1456} Thunder Bluff · {spell:3763} Fine Leather Belt · {item:2319} Medium Leather · {item:2457} Elixir of Minor Agility · {item:4234} Heavy Leather
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:165} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:165} trainer teaches it: Alliance {npc:3967} ({zone:1440}), {npc:252376} ({zone:2521}), {npc:11081} ({zone:1457}), {npc:5127} ({zone:1455}) and {npc:5564} ({zone:1453}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}) and {npc:11084} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3763} (from 55, 3s). 75-150 takes about 15s 50c of recipes and 57s of vendor goods, plus 144 {item:2319}, 24 {item:2457} and 321 {item:4234} to gather or buy."] = "수습 단계는 5실버로 최대 숙련도를 75에서 150으로 올립니다. {skill:165} 50과 캐릭터 레벨 10이 필요하므로, 50이 되면 언제 들러도 배울 수 있습니다. 모든 {skill:165} 상급자가 가르치지는 않습니다: 얼라이언스는 {npc:3967}({zone:1440}), {npc:252376}({zone:2521}), {npc:11081}({zone:1457}), {npc:5127}({zone:1455}), {npc:5564}({zone:1453}), 호드는 {npc:4588}({zone:1458}), {npc:1385}({zone:1434}), {npc:252376}({zone:2521}), {npc:3365}({zone:1454}), {npc:3703}({zone:1413}), {npc:8153}({zone:1443}), {npc:11084}({zone:1456})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:3763}(55부터, 3실버). 75-150에는 제조법 약 15실버 50코퍼와 상인 재료 약 57실버, 그리고 채집하거나 살 {item:2319} 144개, {item:2457} 24개, {item:4234} 321개가 듭니다.",

	-- Step 14: Leatherworking 75-150: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 75-150: vendor goods"] = "{skill:165} 75-150: 상인 재료",
	-- {item:2320} Coarse Thread · {item:2321} Fine Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 70 {item:2320} (7s) and 50 {item:2321} (50s); about 57s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2320} 70개(7실버)와(과) {item:2321} 50개(50실버). 모두 약 57실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367}, {npc:5817}).",

	-- Step 15: Get Medium Leather (Hillsbrad Foothills)
	-- {item:2319} Medium Leather · {zone:1424} Hillsbrad Foothills
	["Get {item:2319} ({zone:1424})"] = "",
	-- {item:2319} Medium Leather · {skill:165} Leatherworking · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	-- was: ["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "{item:7285}에 필요한 {item:2319} 144개: {skill:393}: 18-30레벨 야수. 여기서 {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}와(과) {npc:2354}을(를) 무두질하세요(레벨 18-30). {skill:393} 가이드가 이 루트를 안내합니다."
	["You need 144 {item:2319} for {skill:165} 75-150: {item:7285}. {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 16: Get Medium Leather (Darkshore)
	-- {item:2319} Medium Leather · {zone:1439} Darkshore
	["Get {item:2319} ({zone:1439})"] = "",
	-- {item:2319} Medium Leather · {skill:165} Leatherworking · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3823} Ghostpaw Runner · {npc:2071} Moonstalker Matriarch
	["You need 144 {item:2319} for {skill:165} 75-150: {item:7285}. {skill:393}: beasts of level 18-30. Skin {npc:3823} and {npc:2071} here (level 18-30); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 17: Get Medium Leather (The Barrens)
	-- {item:2319} Medium Leather · {zone:1413} The Barrens
	["Get {item:2319} ({zone:1413})"] = "",
	-- {item:2319} Medium Leather · {skill:165} Leatherworking · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3236} Barrens Kodo
	["You need 144 {item:2319} for {skill:165} 75-150: {item:7285}. {skill:393}: beasts of level 18-30. Skin {npc:3236} and Thunderhead here (level 18-30); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 19: Get Elixir of Minor Agility
	-- {item:2457} Elixir of Minor Agility
	["Get {item:2457}"] = "",
	-- {item:2457} Elixir of Minor Agility · {skill:165} Leatherworking · {item:7285} Nimble Leather Gloves · {skill:171} Alchemy
	["You need 24 {item:2457} for {skill:165} 75-150: {item:7285}. {skill:171}: {item:2457}. Or buy them at the Auction House."] = "",

	-- Step 20: Get Heavy Leather (Alterac Mountains)
	-- {item:4234} Heavy Leather · {zone:1416} Alterac Mountains
	["Get {item:4234} ({zone:1416})"] = "",
	-- {item:4234} Heavy Leather · {skill:165} Leatherworking · {spell:3780} Heavy Armor Kit · {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti
	-- was: ["321 {item:4234} for {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "{spell:3780}, {item:5964}, {item:5966}에 쓸 {item:4234} 321개(그중 191개는 150-225용이니 지금 모두 모으세요): {skill:393}: 28-40레벨 야수. 여기서 {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, 무쇠턱거북의 가죽을 벗기세요(28-40레벨). {skill:393} 가이드에 경로가 있습니다."
	["You need 321 {item:4234} for {skill:165} 75-150: {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: get them all now). {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 21: Get Heavy Leather (Thousand Needles)
	-- {item:4234} Heavy Leather · {zone:1441} Thousand Needles
	["Get {item:4234} ({zone:1441})"] = "",
	-- {item:4234} Heavy Leather · {skill:165} Leatherworking · {spell:3780} Heavy Armor Kit · {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise
	-- was: ["321 {item:4234} for {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "{spell:3780}, {item:5964}, {item:5966}에 쓸 {item:4234} 321개(그중 191개는 150-225용이니 지금 모두 모으세요): {skill:393}: 28-40레벨 야수. 여기서 {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142}의 가죽을 벗기세요(28-40레벨). {skill:393} 가이드에 경로가 있습니다."
	["You need 321 {item:4234} for {skill:165} 75-150: {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: get them all now). {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 24: Fine Leather Belt to 102
	-- {spell:3763} Fine Leather Belt
	["{spell:3763} to 102"] = "{spell:3763}: 102까지",
	-- {spell:3763} Fine Leather Belt · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3763} is orange at 75 (yellow 85, green 100, grey 115): about 35 crafts to 102. Each takes 6 {item:2318} and 2 {item:2320}. Forever teaches {spell:3763} from 55."] = "{spell:3763}은(는) 75에 주황색입니다(노란색 85, 초록색 100, 회색 115). 102까지 약 35번 만드세요. 한 번에 {item:2318} 6개, {item:2320} 2개. Forever는 {spell:3763}을(를) 55에서 가르칩니다.",

	-- Step 25: Leatherworking recipes at 102
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 102"] = "102에서 {skill:165} 제조법",
	-- {skill:165} Leatherworking · {spell:9074} Nimble Leather Gloves
	["Back to a {skill:165} trainer: {spell:9074} (from 95, 5s)."] = "{skill:165} 상급자에게 돌아가세요: {spell:9074}(95부터, 5실버).",

	-- Step 26: Nimble Leather Gloves to 125
	-- {item:7285} Nimble Leather Gloves
	["{item:7285} to 125"] = "{item:7285}: 125까지",
	-- {item:7285} Nimble Leather Gloves · {item:2457} Elixir of Minor Agility · {item:2319} Medium Leather · {item:2321} Fine Thread · {item:2452} Swiftthistle · {item:765} Silverleaf · {spell:3763} Fine Leather Belt · {item:2316} Dark Leather Cloak · {item:4340} Gray Dye
	["{item:7285} is orange at 102 (yellow 120, green 132, grey 145): about 24 crafts to 125. Each takes 1 {item:2457}, 6 {item:2319} and 1 {item:2321}. Each takes an {item:2457}: an alchemist makes it from a {item:2452} and a {item:765}, and the Auction House has it cheap. With no elixirs, take {spell:3763} on to 105 and {item:2316} (from 85: 8 {item:2319}, a {item:4340} and a {item:2321}) to 125: about 28 cloaks, 224 {item:2319} in all."] = "{item:7285}은(는) 102에 주황색입니다(노란색 120, 초록색 132, 회색 145). 125까지 약 24번 만드세요. 한 번에 {item:2457} 1개, {item:2319} 6개, {item:2321} 1개. {item:2457}이(가) 필요합니다. 연금술사가 {item:2452}와(과) {item:765}로 만들고 경매장에서 저렴합니다. 영약이 없다면 {spell:3763}을(를) 105까지, {item:2316}(85부터: {item:2319} 8개, {item:4340}, {item:2321})을(를) 125까지 이어가세요. 망토 약 28개, {item:2319} 224개입니다.",

	-- Step 27: Leatherworking recipes at 125
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 125"] = "125에서 {skill:165} 제조법",
	-- {skill:165} Leatherworking · {spell:3780} Heavy Armor Kit
	["Back to a {skill:165} trainer: {spell:3780} (from 125, 7s 50c)."] = "{skill:165} 상급자에게 돌아가세요: {spell:3780}(125부터, 7실버 50코퍼).",

	-- Step 28: Heavy Armor Kit to 150
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 150"] = "{spell:3780}: 150까지",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread · {skill:165} Leatherworking
	["{spell:3780} is orange at 125 (yellow 145, green 155, grey 165): about 26 crafts to 150. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. {skill:165} 150 is a Legacy System milestone."] = "{spell:3780}은(는) 125에 주황색입니다(노란색 145, 초록색 155, 회색 165). 150까지 약 26번 만드세요. 한 번에 {item:4234} 5개, {item:2321} 1개. 제작당 {item:4234} 다섯 개(28-40레벨 야수). 키트는 상인에게 팔립니다. {skill:165} 150은(는) 유산 시스템 이정표입니다.",

	-- Step 29: Leatherworking 150-225: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 150-225: vendor goods"] = "{skill:165} 150-225: 상인 재료",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra · {npc:3366} Tamar
	-- was: ["Buy the whole bracket's share in one go: 29 {item:2321} (29s), 66 Salt (33s) and 145 {item:4291} (7g 25s); about 7g 87s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2321} 29개(29실버), 소금 66개(33실버), {item:4291} 145개(7골드 25실버), 모두 약 7골드 87실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}, {zone:1454}: {npc:3364}, {npc:3367}, {npc:5817})."
	["Buy the whole bracket's share in one go: 29 {item:2321} (29s), 66 Salt (33s) and 145 {item:4291} (7g 25s); about 7g 87s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286} and {npc:5565}; {zone:1454}: {npc:3367}, {npc:5817} and {npc:3366})."] = "",

	-- Step 30: Get Heavy Hide (Alliance)
	-- {item:4235} Heavy Hide
	-- was: ["{item:4235} (Alliance)"] = "{item:4235} (얼라이언스)"
	["Get {item:4235} (Alliance)"] = "",
	-- {item:4235} Heavy Hide · {skill:165} Leatherworking · {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti
	-- was: ["22 {item:4235} for {item:5964} and {item:5966}: {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "{item:5964}와(과) {item:5966}에 쓸 {item:4235} 22개: {skill:393}: 28-40레벨 야수. 여기서 {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, 무쇠턱거북의 가죽을 벗기세요(28-40레벨). {skill:393} 가이드에 경로가 있습니다."
	["You need 22 {item:4235} for {skill:165} 150-225: {item:5964} and {item:5966}. {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 31: Get Heavy Hide (Horde)
	-- {item:4235} Heavy Hide
	-- was: ["{item:4235} (Horde)"] = "{item:4235} (호드)"
	["Get {item:4235} (Horde)"] = "",
	-- {item:4235} Heavy Hide · {skill:165} Leatherworking · {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise
	-- was: ["22 {item:4235} for {item:5964} and {item:5966}: {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "{item:5964}와(과) {item:5966}에 쓸 {item:4235} 22개: {skill:393}: 28-40레벨 야수. 여기서 {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142}의 가죽을 벗기세요(28-40레벨). {skill:393} 가이드에 경로가 있습니다."
	["You need 22 {item:4235} for {skill:165} 150-225: {item:5964} and {item:5966}. {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 32: Get Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	-- was: ["{item:4304} (Alliance)"] = "{item:4304} (얼라이언스)"
	["Get {item:4304} (Alliance)"] = "",
	-- {item:4304} Thick Leather · {skill:165} Leatherworking · {item:8176} Nightscape Headband · {item:8193} Nightscape Pants · {skill:393} Skinning · {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch
	-- was: ["373 {item:4304} for {item:8176} and {item:8193}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "{item:8176}와(과) {item:8193}에 쓸 {item:4304} 373개: {skill:393}: 38-50레벨 야수. 여기서 {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734}의 가죽을 벗기세요(38-50레벨). {skill:393} 가이드에 경로가 있습니다."
	["You need 373 {item:4304} for {skill:165} 150-225: {item:8176} and {item:8193}. {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 33: Get Thick Leather (Horde)
	-- {item:4304} Thick Leather
	-- was: ["{item:4304} (Horde)"] = "{item:4304} (호드)"
	["Get {item:4304} (Horde)"] = "",
	-- {item:4304} Thick Leather · {skill:165} Leatherworking · {item:8176} Nightscape Headband · {item:8193} Nightscape Pants · {skill:393} Skinning · {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti
	-- was: ["373 {item:4304} for {item:8176} and {item:8193}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "{item:8176}와(과) {item:8193}에 쓸 {item:4304} 373개: {skill:393}: 38-50레벨 야수. 여기서 {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296}의 가죽을 벗기세요(38-50레벨). {skill:393} 가이드에 경로가 있습니다."
	["You need 373 {item:4304} for {skill:165} 150-225: {item:8176} and {item:8193}. {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 34: Expert Leatherworking
	-- {skill:165} Leatherworking
	["Expert {skill:165}"] = "숙련 {skill:165}",
	-- {skill:165} Leatherworking · {npc:4212} Telonis · {zone:1457} Darnassus · {npc:3007} Una · {zone:1456} Thunder Bluff · {spell:3818} Cured Heavy Hide · {spell:7151} Barbaric Shoulders · {item:4235} Heavy Hide · {item:4304} Thick Leather · {item:5966} Guardian Gloves · {item:8176} Nightscape Headband · {item:8193} Nightscape Pants
	["Expert raises the cap from 150 to 225; it needs {skill:165} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4212} ({zone:1457}); Horde {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3818} (from 125, 5s) and {spell:7151} (from 150). 150-225 takes about 5s of recipes and 7g 87s of vendor goods, plus 22 {item:4235} and 373 {item:4304} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:5966} (from 165) and {item:8176} (from 180), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3. {item:8193} (from 210) takes a second trip, to other trainers (below)."] = "숙련 단계는 최대 숙련도를 150에서 225로 올립니다. {skill:165} 125와 캐릭터 레벨 20이 필요하므로, 125가 되면 언제 들러도 배울 수 있습니다. 가르치는 상급자는 몇 명뿐입니다: 얼라이언스는 {npc:4212}({zone:1457}), 호드는 {npc:3007}({zone:1456})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:3818}(125부터, 5실버), {spell:7151}(150부터). 150-225에는 제조법 약 5실버와 상인 재료 약 7골드 87실버, 그리고 채집하거나 살 {item:4235} 22개, {item:4304} 373개가 듭니다. 모든 재료를 가방에 챙겨서 오세요(위 단계에서 모으고, 나머지는 경매장에서). 이 상급자들은 {item:5966}(165부터), {item:8176}(180부터)도 가르치며, 제작에 작업대가 필요 없으므로 바로 여기서 만들고 숙련도에 도달할 때마다 제조법을 배우세요. 세 번 올 것을 한 번에 끝냅니다. {item:8193}(210부터)은(는) 다른 상급자에게 두 번째로 가야 합니다(아래 참조).",

	-- Step 35: Heavy Armor Kit to 158
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 158"] = "{spell:3780}: 158까지",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread
	["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 15 crafts to 158. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. If you got here without learning {spell:3780}, learn it now: an earlier step teaches it."] = "{spell:3780}은(는) 150에서 노란색입니다(노란색 145, 초록색 155, 회색 165): 158까지 약 15번 제작. 매번 {item:4234} 5개와 {item:2321} 1개가 필요합니다. 제작마다 {item:4234} 다섯 개(28-40레벨 짐승). 키트는 상인에게 팝니다. {spell:3780}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 36: Barbaric Shoulders to 165
	-- {item:5964} Barbaric Shoulders
	["{item:5964} to 165"] = "{item:5964}: 165까지",
	-- {item:5964} Barbaric Shoulders · {item:4234} Heavy Leather · {spell:3818} Cured Heavy Hide · {item:2321} Fine Thread
	["{item:5964} is orange at 158 (yellow 170, green 180, grey 190): about 7 crafts to 165, a point every craft. Each takes 8 {item:4234}, 1 {spell:3818} and 2 {item:2321}. Make the 7 {spell:3818} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:5964}은(는) 158에서 주황색입니다(노란색 170, 녹색 180, 회색 190). 165까지 약 7번 만들며, 만들 때마다 1포인트씩 오릅니다. 한 번에 {item:4234} 8개, {spell:3818} 1개, {item:2321} 2개가 듭니다. {spell:3818} 7개를 먼저 만드세요. 상급자가 가르쳐 주며, 데이터상 이 구간을 지나는 가장 싼 방법입니다.",

	-- Step 37: Leatherworking recipes at 165
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 165"] = "165에서 {skill:165} 제조법",
	-- {spell:7156} Guardian Gloves
	["Still at the Expert trainer: {spell:7156} (from 165)."] = "계속 숙련 상급자에게서: {spell:7156}(165부터).",

	-- Step 38: Guardian Gloves to 180
	-- {item:5966} Guardian Gloves
	["{item:5966} to 180"] = "{item:5966}: 180까지",
	-- {item:5966} Guardian Gloves · {item:4234} Heavy Leather · {spell:3818} Cured Heavy Hide · {item:4291} Silken Thread
	["{item:5966} is orange at 165 (yellow 185, green 195, grey 205): about 15 crafts to 180, a point every craft. Each takes 4 {item:4234}, 1 {spell:3818} and 1 {item:4291}. Make the 15 {spell:3818} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:5966}은(는) 165에서 주황색입니다(노란색 185, 녹색 195, 회색 205). 180까지 약 15번 만들며, 만들 때마다 1포인트씩 오릅니다. 한 번에 {item:4234} 4개, {spell:3818} 1개, {item:4291} 1개가 듭니다. {spell:3818} 15개를 먼저 만드세요. 상급자가 가르쳐 주며, 데이터상 이 구간을 지나는 가장 싼 방법입니다.",

	-- Step 39: Leatherworking recipes at 180
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 180"] = "180에서 {skill:165} 제조법",
	-- {spell:10507} Nightscape Headband
	["Still at the Expert trainer: {spell:10507} (from 180)."] = "계속 숙련 상급자에게서: {spell:10507}(180부터).",

	-- Step 40: Nightscape Headband to 213
	-- {item:8176} Nightscape Headband
	["{item:8176} to 213"] = "{item:8176}: 213까지",
	-- {item:8176} Nightscape Headband · {item:4304} Thick Leather · {item:4291} Silken Thread
	["{item:8176} is orange at 180 (yellow 200, green 210, grey 220): about 41 crafts to 213. Each takes 5 {item:4304} and 2 {item:4291}. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:8176}은(는) 180에서 주황색입니다(노란색 200, 녹색 210, 회색 220). 213까지 약 41번 만듭니다. 한 번에 {item:4304} 5개와 {item:4291} 2개가 듭니다. 상급자가 가르쳐 주며, 데이터상 이 구간을 지나는 가장 싼 방법입니다.",

	-- Step 41: Leatherworking recipes at 213
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 213"] = "213에서 {skill:165} 제조법",
	-- {spell:10548} Nightscape Pants · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {skill:165} Leatherworking
	["{spell:10548} (from 210) is taught only by the Artisan trainers: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). You can train Artisan there now if you are level 35 (it needs {skill:165} 200), which saves the trip at 225."] = "{spell:10548}(210부터)은(는) 전문 상급자만 가르칩니다: 얼라이언스 {npc:11097}({zone:1425}), 호드 {npc:11098}({zone:1444}). 35레벨이라면 지금 그곳에서 전문 단계를 배울 수 있으며({skill:165} 200 필요), 225에 다시 찾아갈 필요가 없어집니다.",

	-- Step 42: Nightscape Pants to 225
	-- {item:8193} Nightscape Pants
	["{item:8193} to 225"] = "{item:8193}: 225까지",
	-- {item:8193} Nightscape Pants · {item:4304} Thick Leather · {item:4291} Silken Thread · {skill:165} Leatherworking
	["{item:8193} is orange at 213 (yellow 225, green 235, grey 245): about 12 crafts to 225, a point every craft. Each takes 14 {item:4304} and 4 {item:4291}. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:165} 225 is a Legacy System milestone."] = "{item:8193}은(는) 213에서 주황색입니다(노란색 225, 녹색 235, 회색 245). 225까지 약 12번 만들며, 만들 때마다 1포인트씩 오릅니다. 한 번에 {item:4304} 14개와 {item:4291} 4개가 듭니다. 상급자가 가르쳐 주며, 데이터상 이 구간을 지나는 가장 싼 방법입니다. {skill:165} 225는 유산 시스템의 이정표입니다.",

	-- Step 43: Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Artisan {skill:165}"] = "전문 {skill:165}",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {spell:19058} Rugged Armor Kit · {item:8170} Rugged Leather · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300; it needs {skill:165} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). The arrow picks the nearest of your faction. Learn now: {spell:19058} (from 225). 225-300 takes about 3g 40s of recipes and 44g 90s of vendor goods, plus 1029 {item:8170} and 430 {item:14047} to gather or buy."] = "전문 단계는 최대 숙련도를 225에서 300으로 올립니다. {skill:165} 200과 캐릭터 레벨 35가 필요하므로, 200이 되면 언제 들러도 배울 수 있습니다. 가르치는 상급자는 몇 명뿐입니다: 얼라이언스는 {npc:11097}({zone:1425}), 호드는 {npc:11098}({zone:1444})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:19058}(225부터). 225-300에는 제조법 약 3골드 40실버와 상인 재료 약 44골드 90실버, 그리고 채집하거나 살 {item:8170} 1029개, {item:14047} 430개가 듭니다.",

	-- Step 44: Leatherworking 225-300: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 225-300: vendor goods"] = "{skill:165} 225-300: 상인 재료",
	-- {item:2325} Black Dye · {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3366} Tamar
	-- was: ["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2325} 39개(3골드 90실버)와(과) {item:14341} 82개(41골드). 모두 약 44골드 90실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367}, {npc:5817})."
	["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347} and {npc:5565}; {zone:1454}: {npc:3364} and {npc:3366})."] = "",

	-- Step 45: Pattern: Wicked Leather Gauntlets
	-- {item:15725} Pattern: Wicked Leather Gauntlets · {item:15083} Wicked Leather Gauntlets · {skill:165} Leatherworking · {npc:12942} Leonard Porter · {zone:1422} Western Plaguelands · {npc:12943} Werg Thickblade
	["{item:15725} teaches {item:15083} ({skill:165} 235) for 1g 20s. Sold by Alliance: {npc:12942} ({zone:1422}), limited stock; Horde: {npc:12943} ({zone:1422}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15725}은(는) 1골드 20실버에 {item:15083}({skill:165} 235)을(를) 가르칩니다. 얼라이언스 판매: {npc:12942}({zone:1422}), 수량 제한; 호드 판매: {npc:12943}({zone:1422}), 수량 제한. 판매자는 한두 개를 재고로 두고 판매 후 얼마 지나면 다시 들여놓습니다. 주울 때 귀속되므로 경매장에는 절대 없습니다.",

	-- Step 46: Pattern: Runic Leather Headband
	-- {item:15756} Pattern: Runic Leather Headband · {item:15094} Runic Leather Headband · {skill:165} Leatherworking · {npc:12941} Jase Farlane · {zone:1423} Eastern Plaguelands
	["{item:15756} teaches {item:15094} ({skill:165} 265) for 2g 20s. Sold by {npc:12941} ({zone:1423}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15756}은(는) 2골드 20실버에 {item:15094}({skill:165} 265)을(를) 가르칩니다. {npc:12941}({zone:1423})이(가) 수량 제한으로 팝니다. 판매자는 한두 개를 재고로 두고 판매 후 얼마 지나면 다시 들여놓습니다. 주울 때 귀속되므로 경매장에는 절대 없습니다.",

	-- Step 47: Get Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	-- was: ["{item:8170} (Alliance)"] = "{item:8170} (얼라이언스)"
	["Get {item:8170} (Alliance)"] = "",
	-- {item:8170} Rugged Leather · {skill:165} Leatherworking · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:8598} Frenzied Plaguehound · {npc:8596} Plaguehound Runt
	-- was: ["1029 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "{item:15564}, {item:15083}, {item:15094}에 쓸 {item:8170} 1029개: {skill:393}: 48-60레벨 야수. 여기서 {npc:8598}, 역병사냥개, {npc:8596}의 가죽을 벗기세요(48-60레벨). {skill:393} 가이드에 경로가 있습니다."
	["You need 1029 {item:8170} for {skill:165} 225-300: {item:15564}, {item:15083} and {item:15094}. {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 48: Get Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	-- was: ["{item:8170} (Horde)"] = "{item:8170} (호드)"
	["Get {item:8170} (Horde)"] = "",
	-- {item:8170} Rugged Leather · {skill:165} Leatherworking · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	-- was: ["1029 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "{item:15564}, {item:15083}, {item:15094}에 쓸 {item:8170} 1029개: {skill:393}: 48-60레벨 야수. 여기서 {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377}의 가죽을 벗기세요(48-60레벨). {skill:393} 가이드에 경로가 있습니다."
	["You need 1029 {item:8170} for {skill:165} 225-300: {item:15564}, {item:15083} and {item:15094}. {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this. Or buy them at the Auction House."] = "",

	-- Step 49: Get Runecloth
	-- {item:14047} Runecloth
	["Get {item:14047}"] = "",
	-- {item:14047} Runecloth · {skill:165} Leatherworking · {item:15094} Runic Leather Headband
	["You need 430 {item:14047} for {skill:165} 225-300: {item:15094}. Humanoids of level 45-60 drop it, and what you loot as you level counts. The arrow takes you to the best farm for your level: mobs at or below it first, then the most {item:14047} per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 50: Rugged Armor Kit to 239
	-- {item:15564} Rugged Armor Kit
	["{item:15564} to 239"] = "{item:15564}: 239까지",
	-- {item:15564} Rugged Armor Kit · {item:8170} Rugged Leather · {npc:7866} Peter Galen · {zone:1447} Azshara · {npc:7867} Thorkaf Dragoneye · {zone:1418} Badlands · {item:8204} Tough Scorpid Gloves · {zone:1446} Tanaris · {item:8165} Worn Dragonscale · {npc:7868} Sarah Tanner · {zone:1427} Searing Gorge · {npc:7869} Brumn Winterhoof · {zone:1417} Arathi Highlands · {item:7077} Heart of Fire · {item:7079} Globe of Water · {item:7075} Core of Earth · {item:7081} Breath of Wind · {npc:7870} Caryssia Moonhunter · {zone:1444} Feralas · {npc:7871} Se'Jib · {zone:1434} Stranglethorn Vale · {item:8211} Wild Leather Vest · {npc:7852} Pratt McGrubben · {npc:7854} Jangdor Swiftstrider · {item:279941} Tanning Rack
	-- plural, as words: Tough Scorpid Breastplates = {item:8203} Tough Scorpid Breastplate
	["{item:15564} is yellow at 225 (yellow 225, green 235, grey 245): about 23 crafts to 239. Each takes 5 {item:8170}. Five {item:8170} a craft. Specialisation (optional): at 225 and character level 40. Dragonscale: {npc:7866} ({zone:1447}) or {npc:7867} ({zone:1418}) wants 2 Tough Scorpid Breastplates, 2 {item:8204} (patterns drop from the Wastewander bandits in {zone:1446}) and 10 {item:8165}. Elemental: {npc:7868} ({zone:1427}) or {npc:7869} ({zone:1417}) wants 2 each of {item:7077}, {item:7079}, {item:7075} and {item:7081}. Tribal (from 235): {npc:7870} ({zone:1444}) or {npc:7871} ({zone:1434}) wants a {item:8211} and Helmet, after the Wild Leather quests from {npc:7852} or {npc:7854} in {zone:1444}. On Forever the specialisation patterns need a {item:279941}. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30)."] = "{item:15564}은(는) 225에서 노란색입니다(노란색 225, 녹색 235, 회색 245). 239까지 약 23번 만듭니다. 한 번에 {item:8170} 5개가 듭니다. 한 번에 {item:8170} 5개입니다. 전문화(선택): 225, 캐릭터 레벨 40에 가능합니다. 용비늘 가죽세공: {npc:7866}({zone:1447}) 또는 {npc:7867}({zone:1418})이(가) 단단한 전갈 흉갑 2개, {item:8204} 2개({zone:1446}의 사막유랑단 약탈자가 도안을 떨어뜨립니다), {item:8165} 10개를 원합니다. 원소 가죽세공: {npc:7868}({zone:1427}) 또는 {npc:7869}({zone:1417})이(가) {item:7077}, {item:7079}, {item:7075}, {item:7081}을(를) 2개씩 원합니다. 전통 가죽세공(235부터): {zone:1444}의 {npc:7852} 또는 {npc:7854}의 야생 가죽 퀘스트를 마친 뒤, {npc:7870}({zone:1444}) 또는 {npc:7871}({zone:1434})이(가) {item:8211}와(과) 야생 가죽 투구를 원합니다. Forever에서는 전문화 도안에 {item:279941}이(가) 필요합니다. 하나만 고를 수 있으며, 300까지 가는 데는 필요 없고, 베타에서는 시험된 적이 없습니다(베타는 30레벨에서 멈췄습니다).",

	-- Step 51: Wicked Leather Gauntlets to 269
	-- {item:15083} Wicked Leather Gauntlets
	["{item:15083} to 269"] = "{item:15083}: 269까지",
	-- {item:15083} Wicked Leather Gauntlets · {item:8170} Rugged Leather · {item:2325} Black Dye · {item:14341} Rune Thread
	["{item:15083} is orange at 239 (yellow 255, green 265, grey 275): about 39 crafts to 269. Each takes 8 {item:8170}, 1 {item:2325} and 1 {item:14341}. Eight {item:8170} a craft; {item:2325} and {item:14341} from leatherworking or tailoring vendors."] = "{item:15083}은(는) 239에 주황색입니다(노란색 255, 초록색 265, 회색 275). 269까지 약 39번 만드세요. 한 번에 {item:8170} 8개, {item:2325} 1개, {item:14341} 1개. 제작당 {item:8170} 여덟 개. {item:2325}과(와) {item:14341}은(는) 가죽세공이나 재봉술 상인에게서.",
	["from the recipe in your bags"] = "가방에 있는 제조법으로",

	-- Step 52: Runic Leather Headband to 300
	-- {item:15094} Runic Leather Headband
	["{item:15094} to 300"] = "{item:15094}: 300까지",
	-- {item:15094} Runic Leather Headband · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14341} Rune Thread · {skill:165} Leatherworking
	["{item:15094} is orange at 269 (yellow 285, green 295, grey 305): about 43 crafts to 300. Each takes 14 {item:8170}, 10 {item:14047} and 1 {item:14341}. 14 {item:8170} and 10 {item:14047} a craft: the dearest stretch. {skill:165} 300 is a Legacy System milestone."] = "{item:15094}은(는) 269에 주황색입니다(노란색 285, 초록색 295, 회색 305). 300까지 약 43번 만드세요. 한 번에 {item:8170} 14개, {item:14047} 10개, {item:14341} 1개. 제작당 {item:8170} 14개와(과) {item:14047} 10개. 가장 비싼 구간입니다. {skill:165} 300은(는) 유산 시스템 이정표입니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["1029 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "{item:15564}, {item:15083}, {item:15094}에 쓸 {item:8170} 1029개: {skill:393}: 48-60레벨 야수. 여기서 {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377}의 가죽을 벗기세요(48-60레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["1029 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "{item:15564}, {item:15083}, {item:15094}에 쓸 {item:8170} 1029개: {skill:393}: 48-60레벨 야수. 여기서 {npc:8598}, 역병사냥개, {npc:8596}의 가죽을 벗기세요(48-60레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "{item:7285}에 필요한 {item:2319} 144개: {skill:393}: 18-30레벨 야수. 여기서 {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}와(과) {npc:2354}을(를) 무두질하세요(레벨 18-30). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30. Skin {npc:3236} and Thunderhead here (level 18-30); the {skill:393} guide routes this."] = "{item:7285}에 필요한 {item:2319} 144개: {skill:393}: 18-30레벨 야수. 여기서 {npc:3236}와(과) Thunderhead을(를) 무두질하세요(레벨 18-30). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30. Skin {npc:3823} and {npc:2071} here (level 18-30); the {skill:393} guide routes this."] = "{item:7285}에 필요한 {item:2319} 144개: {skill:393}: 18-30레벨 야수. 여기서 {npc:3823}와(과) {npc:2071}을(를) 무두질하세요(레벨 18-30). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["22 {item:4235} for {item:5964} and {item:5966}: {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "{item:5964}와(과) {item:5966}에 쓸 {item:4235} 22개: {skill:393}: 28-40레벨 야수. 여기서 {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, 무쇠턱거북의 가죽을 벗기세요(28-40레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["22 {item:4235} for {item:5964} and {item:5966}: {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "{item:5964}와(과) {item:5966}에 쓸 {item:4235} 22개: {skill:393}: 28-40레벨 야수. 여기서 {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142}의 가죽을 벗기세요(28-40레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["24 {item:2457} for {item:7285}: {skill:171}: {item:2457}."] = "{item:7285}에 쓸 {item:2457} 24개: {skill:171}: {item:2457}.",
	-- ["321 {item:4234} for {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "{spell:3780}, {item:5964}, {item:5966}에 쓸 {item:4234} 321개(그중 191개는 150-225용이니 지금 모두 모으세요): {skill:393}: 28-40레벨 야수. 여기서 {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, 무쇠턱거북의 가죽을 벗기세요(28-40레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["321 {item:4234} for {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "{spell:3780}, {item:5964}, {item:5966}에 쓸 {item:4234} 321개(그중 191개는 150-225용이니 지금 모두 모으세요): {skill:393}: 28-40레벨 야수. 여기서 {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142}의 가죽을 벗기세요(28-40레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} and {npc:254588} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874}와(과) {npc:254588}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} and {npc:1128} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}와(과) {npc:1128}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} and {npc:1554} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549}와(과) {npc:1554}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1922}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756}, {spell:3763}에 필요한 {item:2318} 349개(그중 210개는 75-150용: 지금 모두 모으십시오): {skill:393}: 5-20레벨 짐승. 여기서 {npc:1922}, 배회하는 짐승, {npc:524}, {npc:113}, {npc:822}의 가죽을 벗기십시오(5-20레벨). {skill:393} 가이드가 경로를 안내합니다.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:1922}, {npc:525}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:1922}, {npc:525}, Prowler, {npc:524}, {npc:113}와(과) {npc:822}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:2033}, Nightsaber and {npc:2043} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:2033}, Nightsaber와(과) {npc:2043}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} and {npc:2960} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958}와(과) {npc:2960}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20. Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} and {npc:3127} here (level 5-20); the {skill:393} guide routes this."] = "{spell:2152}, {spell:3756} 및 {spell:3763}에 필요한 {item:2318} 349개(75-150에 210개: 지금 모두 채집하세요): {skill:393}: 5-20레벨 야수. 여기서 {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}와(과) {npc:3127}을(를) 무두질하세요(레벨 5-20). {skill:393} 가이드가 이 루트를 안내합니다.",
	-- ["373 {item:4304} for {item:8176} and {item:8193}: {skill:393}: beasts of level 38-50. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "{item:8176}와(과) {item:8193}에 쓸 {item:4304} 373개: {skill:393}: 38-50레벨 야수. 여기서 {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734}의 가죽을 벗기세요(38-50레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["373 {item:4304} for {item:8176} and {item:8193}: {skill:393}: beasts of level 38-50. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "{item:8176}와(과) {item:8193}에 쓸 {item:4304} 373개: {skill:393}: 38-50레벨 야수. 여기서 {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296}의 가죽을 벗기세요(38-50레벨). {skill:393} 가이드에 경로가 있습니다.",
	-- ["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it. Keep what you loot as you level, or take it from your bank."] = "{item:15094}에 쓸 {item:14047} 430개: 45-60레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나 은행에서 꺼내세요.",
	-- ["Artisan needs character level 35 and {skill:165} 200; it raises the cap to 300. Materials for 225-300 are worth about 312g in all."] = "전문은(는) 캐릭터 레벨 35, {skill:165} 200이(가) 필요하며 최대 숙련도를 300(으)로 올립니다. 225-300 재료는 모두 약 312골드입니다.",
	-- ["Back to a {skill:165} trainer: {spell:10482}, {spell:14932} are taught from {skill:165} 220."] = "{skill:165} 상급자에게 돌아가세요. {spell:10482}, {spell:14932}은(는) {skill:165} 220부터 배울 수 있습니다.",
	-- ["Back to a {skill:165} trainer: {spell:10487} is taught from {skill:165} 195."] = "{skill:165} 상급자에게 돌아가세요. {spell:10487}은(는) {skill:165} 195부터 배울 수 있습니다.",
	-- ["Back to a {skill:165} trainer: {spell:3763} is taught from {skill:165} 85."] = "{skill:165} 상급자에게 돌아가세요. {spell:3763}은(는) {skill:165} 85부터 배울 수 있습니다.",
	-- ["Back to a {skill:165} trainer: {spell:3817}, {spell:3768} are taught from {skill:165} 130."] = "{skill:165} 상급자에게 돌아가세요. {spell:3817}, {spell:3768}은(는) {skill:165} 130부터 배울 수 있습니다.",
	-- ["Back to a {skill:165} trainer: {spell:7151} is taught from {skill:165} 170."] = "{skill:165} 상급자에게 돌아가세요. {spell:7151}은(는) {skill:165} 170부터 배울 수 있습니다.",
	-- ["Back to a {skill:165} trainer: {spell:7156} is taught from {skill:165} 185."] = "{skill:165} 상급자에게 돌아가세요. {spell:7156}은(는) {skill:165} 185부터 배울 수 있습니다.",
	-- ["Back to a {skill:165} trainer: {spell:9062} is taught from {skill:165} 55."] = "{skill:165} 상급자에게 돌아가세요. {spell:9062}은(는) {skill:165} 55부터 배울 수 있습니다.",
	-- ["Back to a {skill:165} trainer: {spell:9068} is taught from {skill:165} 100."] = "{skill:165} 상급자에게 돌아가세요. {spell:9068}은(는) {skill:165} 100부터 배울 수 있습니다.",
	-- ["Buy the whole bracket's share in one go: 29 {item:2321} (29s), 66 Salt (33s) and 145 {item:4291} (7g 25s); about 7g 87s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2321} 29개(29실버), 소금 66개(33실버), {item:4291} 145개(7골드 25실버), 모두 약 7골드 87실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}, {zone:1454}: {npc:3364}, {npc:3367}, {npc:5817}).",
	-- ["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:2325} 39개(3골드 90실버)와(과) {item:14341} 82개(41골드). 모두 약 44골드 90실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1347}, {npc:1286}, {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367}, {npc:5817}).",
	-- ["Expert needs character level 20 and {skill:165} 125; it raises the cap to 225. Materials for 150-225 are worth about 61g in all."] = "숙련은(는) 캐릭터 레벨 20, {skill:165} 125이(가) 필요하며 최대 숙련도를 225(으)로 올립니다. 150-225 재료는 모두 약 61골드입니다.",
	-- ["Journeyman needs character level 10 and {skill:165} 50; it raises the cap to 150. Materials for 75-150 are worth about 11g in all."] = "수습은(는) 캐릭터 레벨 10, {skill:165} 50이(가) 필요하며 최대 숙련도를 150(으)로 올립니다. 75-150 재료는 모두 약 11골드입니다.",
	-- ["Orange (a point every craft) until 155, yellow until 165, green until 175."] = "155까지 주황색(만들 때마다 1점), 165까지 노란색, 175까지 초록색입니다.",
	-- ["Orange (a point every craft) until 205, yellow until 215, green until 225."] = "205까지 주황색(만들 때마다 1점), 215까지 노란색, 225까지 초록색입니다.",
	-- ["Orange (a point every craft) until 255, yellow until 265, green until 275."] = "255까지 주황색(만들 때마다 1점), 265까지 노란색, 275까지 초록색입니다.",
	-- ["Orange (a point every craft) until 285, yellow until 295, green until 305. {skill:165} 300 is a Legacy System milestone."] = "285까지 주황색(만들 때마다 1점), 295까지 노란색, 305까지 초록색입니다. {skill:165} 300은(는) 유산 시스템 단계입니다.",
	-- ["Orange (a point every craft) until 30, yellow until 45, green until 60."] = "30까지 주황색(만들 때마다 1점), 45까지 노란색, 60까지 초록색입니다.",
	-- ["Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128}의 가죽을 벗기세요(5-20레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:1815}, {npc:1816}, {npc:1817}의 가죽을 벗기세요(48-60레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Snapjaw here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, 무쇠턱거북의 가죽을 벗기세요(28-40레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, 무쇠턱거북, {npc:2384}, {npc:2354}의 가죽을 벗기세요(18-30레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734}의 가죽을 벗기세요(38-50레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127}의 가죽을 벗기세요(5-20레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817}의 가죽을 벗기세요(18-30레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142}의 가죽을 벗기세요(28-40레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296}의 가죽을 벗기세요(38-50레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377}의 가죽을 벗기세요(48-60레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "무두질, 마력 추출 또는 다른 전문 기술로 얻는 재료입니다. 직접 모으거나 경매장에서 사세요.",
	-- ["Still at the Expert trainer: {spell:10548} (from 210)."] = "계속 숙련 상급자에게서: {spell:10548}(210부터).",
	-- ["Teaches {item:15083} (needs {skill:165} 235). Vendors sell it in limited stock that restocks."] = "{item:15083}을(를) 배웁니다({skill:165} 235 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",
	-- ["Teaches {item:15094} (needs {skill:165} 265). Vendors sell it in limited stock that restocks."] = "{item:15094}을(를) 배웁니다({skill:165} 265 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",
	-- ["Teaches {item:252452} (needs {skill:165} 135)."] = "{item:252452}을(를) 배웁니다({skill:165} 135 필요).",
	-- ["Teaches {item:252463} (needs {skill:165} 185)."] = "{item:252463}을(를) 배웁니다({skill:165} 185 필요).",
	-- ["What 1-75 takes that the Auction House sells: 349 {item:2318}. The counts drop by what your bags, bank and mail hold."] = "1-75 구간에 필요한 것 중 경매장에서 파는 것: {item:2318} 349개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 150-225 takes that the Auction House sells: 22 {item:4235} and 373 {item:4304}. The counts drop by what your bags, bank and mail hold."] = "150-225 구간에 필요한 것 중 경매장에서 파는 것: {item:4235} 22개, {item:4304} 373개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 225-300 takes that the Auction House sells: 1029 {item:8170} and 430 {item:14047}. The counts drop by what your bags, bank and mail hold."] = "225-300 구간에 필요한 것 중 경매장에서 파는 것: {item:8170} 1029개, {item:14047} 430개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 75-150 takes that the Auction House sells: 144 {item:2319}, 24 {item:2457} and 321 {item:4234}. The counts drop by what your bags, bank and mail hold."] = "75-150 구간에 필요한 것 중 경매장에서 파는 것: {item:2319} 144개, {item:2457} 24개, {item:4234} 321개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["Yellow until 100, green until 115: not every craft gives a point."] = "100까지 노란색, 115까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 115, green until 130: not every craft gives a point."] = "115까지 노란색, 130까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 132, green until 145: not every craft gives a point."] = "132까지 노란색, 145까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 142, green until 155: not every craft gives a point. {skill:165} 150 is a Legacy System milestone."] = "142까지 노란색, 155까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. {skill:165} 150은(는) 유산 시스템 단계입니다.",
	-- ["Yellow until 180, green until 190: not every craft gives a point."] = "180까지 노란색, 190까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 185, green until 195: not every craft gives a point."] = "185까지 노란색, 195까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 195, green until 205: not every craft gives a point."] = "195까지 노란색, 205까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 230, green until 240: not every craft gives a point. {skill:165} 225 is a Legacy System milestone."] = "230까지 노란색, 240까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. {skill:165} 225은(는) 유산 시스템 단계입니다.",
	-- ["Yellow until 235, green until 245: not every craft gives a point."] = "235까지 노란색, 245까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 70, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "70까지 노란색, 85까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 75은(는) 초급 최대치입니다.",
	-- ["Yellow until 85, green until 100: not every craft gives a point."] = "85까지 노란색, 100까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["{item:14047} (Alliance)"] = "{item:14047} (얼라이언스)",
	-- ["{item:14047} (Horde)"] = "{item:14047} (호드)",
	-- ["{item:2318} (Alliance)"] = "{item:2318} (얼라이언스)",
	-- ["{item:2318} (Horde)"] = "{item:2318} (호드)",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (얼라이언스)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (호드)",
	-- ["{item:252452} to 170"] = "{item:252452}: 170까지",
	-- ["{item:252463} to 220"] = "{item:252463}: 220까지",
	-- ["{item:4232} (Alliance)"] = "{item:4232} (얼라이언스)",
	-- ["{item:4232} (Horde)"] = "{item:4232} (호드)",
	-- ["{item:4234} (Alliance)"] = "{item:4234} (얼라이언스)",
	-- ["{item:4234} (Horde)"] = "{item:4234} (호드)",
	-- ["{item:4235} (Alliance)"] = "{item:4235} (얼라이언스)",
	-- ["{item:4235} (Horde)"] = "{item:4235} (호드)",
	-- ["{item:4304} (Alliance)"] = "{item:4304} (얼라이언스)",
	-- ["{item:4304} (Horde)"] = "{item:4304} (호드)",
	-- ["{item:5964} to 175"] = "{item:5964}: 175까지",
	-- ["{item:5966} to 195"] = "{item:5966}: 195까지",
	-- ["{item:7279} to 75"] = "{item:7279}: 75까지",
	-- ["{item:7282} to 120"] = "{item:7282}: 120까지",
	-- ["{item:783} (Alliance)"] = "{item:783} (얼라이언스)",
	-- ["{item:783} (Horde)"] = "{item:783} (호드)",
	-- ["{item:8150} (Alliance)"] = "{item:8150} (얼라이언스)",
	-- ["{item:8150} (Horde)"] = "{item:8150} (호드)",
	-- ["{item:8169} (Alliance)"] = "{item:8169} (얼라이언스)",
	-- ["{item:8169} (Horde)"] = "{item:8169} (호드)",
	-- ["{item:8170} (Alliance)"] = "{item:8170} (얼라이언스)",
	-- ["{item:8170} (Horde)"] = "{item:8170} (호드)",
	-- ["{item:8218} to 225"] = "{item:8218}: 225까지",
	-- ["{npc:11746} (level 56-58) drop it here. The Auction House works too."] = "이곳의 {npc:11746}(56-58레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "이곳의 {npc:6189}(51-52레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "이곳의 {npc:7027}(56-57레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:92} (level 39-40) drop it here. The Auction House works too."] = "이곳의 {npc:92}(39-40레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{skill:165} 1-75: Auction House"] = "{skill:165} 1-75: 경매장",
	-- ["{skill:165} 150-225: Auction House"] = "{skill:165} 150-225: 경매장",
	-- ["{skill:165} 225-300: Auction House"] = "{skill:165} 225-300: 경매장",
	-- ["{skill:165} 75-150: Auction House"] = "{skill:165} 75-150: 경매장",
	-- ["{skill:165} materials for 150-225"] = "{skill:165} 재료(150-225)",
	-- ["{skill:165} materials for 75-150"] = "{skill:165} 재료(75-150)",
	-- ["{skill:165} recipes at 130"] = "130에서 {skill:165} 제조법",
	-- ["{skill:165} recipes at 170"] = "170에서 {skill:165} 제조법",
	-- ["{skill:165} recipes at 175"] = "175에서 {skill:165} 제조법",
	-- ["{skill:165} recipes at 185"] = "185에서 {skill:165} 제조법",
	-- ["{skill:165} recipes at 195"] = "195에서 {skill:165} 제조법",
	-- ["{skill:165} recipes at 220"] = "220에서 {skill:165} 제조법",
	-- ["{skill:165} recipes at 85"] = "85에서 {skill:165} 제조법",
	-- ["{skill:165} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 18s in all."] = "{skill:165}은(는) 레벨업과 함께 진행합니다. Forever의 유산 시스템은 제작 전문 기술 숙련도 150, 225, 300(수습, 숙련, 전문 최대치)에 보상을 주므로, 각 단계가 중요합니다. 1-75 재료는 모두 약 1골드 18실버입니다.",
	-- ["{skill:171}: {item:2457} (or the Auction House)"] = "{skill:171}: {item:2457} (또는 경매장)",
	-- ["{skill:171}: {item:3389} (or the Auction House)"] = "{skill:171}: {item:3389} (또는 경매장)",
	-- ["{skill:171}: {spell:3188} (or the Auction House)"] = "{skill:171}: {spell:3188} (또는 경매장)",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: 고급(녹색) 장비 마력 추출 (또는 경매장)",
	-- ["{spell:3768} to 150"] = "{spell:3768}: 150까지",
	-- ["{spell:3776} to 185"] = "{spell:3776}: 185까지",
	-- ["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 15 crafts to 158. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors."] = "{spell:3780}은(는) 150에서 노란색입니다(노란색 145, 녹색 155, 회색 165). 158까지 약 15번 만듭니다. 한 번에 {item:4234} 5개와 {item:2321} 1개가 듭니다. 한 번에 {item:4234} 5개(28-40레벨 야수)이며, 키트는 상인에게 팔 수 있습니다.",
}
