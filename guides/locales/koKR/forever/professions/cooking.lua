-- Korean (koKR): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "{skill:185} 배우기",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (any character level, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "진영의 모든 {skill:185} 상급자가 초급 {skill:185}을(를) 가르칩니다(캐릭터 레벨 제한 없음, 1실버). 화살표가 가장 가까운 상급자를 가리킵니다. Forever: 모든 요리사는 {object:29784}을(를) 압니다. {item:279981}은(는) {item:4470} 1개(38코퍼)와 {item:4471}(1실버 35코퍼, 가방에 남음)을(를) 써서 만들며, 키트를 놓으면 어디서든 요리용 불을 피울 수 있습니다. 몇 개 미리 만들어 두세요(5분마다 한 번 사용). 처음 만드는 키트로 {skill:185}도 약 5까지 오릅니다. 시작 지역 야영지의 '야영 입문: {skill:185}' 퀘스트가 이 상급자에게 보내 줍니다.",

	-- Step 2: Get Stringy Wolf Meat
	-- {item:2672} Stringy Wolf Meat
	["Get {item:2672}"] = "",
	-- {item:2672} Stringy Wolf Meat · {spell:2538} Charred Wolf Meat · {npc:118} Prowler · {zone:1429} Elwynn Forest
	["You need 50 {item:2672} for {spell:2538} (1-50). It drops from {npc:118} (86%) in {zone:1429}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 3: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2538}은(는) 1부터 주황색입니다(노란색 45, 초록색 65, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요: 마을 화로나 직접 피운 {object:29784}.",

	-- Step 4: Get Chunk of Boar Meat
	-- {item:769} Chunk of Boar Meat
	["Get {item:769}"] = "",
	-- {item:769} Chunk of Boar Meat · {spell:2540} Roasted Boar Meat · {npc:1126} Large Crag Boar · {npc:1125} Crag Boar · {zone:1426} Dun Morogh
	["You need 50 {item:769} for {spell:2540} (1-50). It drops from {npc:1126} (36%), {npc:1125} (34%) in {zone:1426}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 5: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire
	["{spell:2540} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2540}은(는) 1부터 주황색입니다(노란색 45, 초록색 65, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요: 마을 화로나 직접 피운 {object:29784}.",

	-- Step 6: Herb Baked Egg: shopping
	-- {item:6888} Herb Baked Egg
	["{item:6888}: shopping"] = "{item:6888}: 구매",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 50 {item:2678} (1s)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:2678} 50개(1실버)가 필요합니다.",

	-- Step 7: Get Small Egg
	-- {item:6889} Small Egg
	["Get {item:6889}"] = "",
	-- {item:6889} Small Egg · {item:6888} Herb Baked Egg · {npc:1995} Strigid Owl · {zone:1438} Teldrassil
	["You need 50 {item:6889} for {item:6888} (1-50). It drops from {npc:1995} (58%) in {zone:1438}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 8: Herb Baked Egg (1-50)
	-- {item:6888} Herb Baked Egg · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2678} Mild Spices · {zone:1438} Teldrassil · {item:6889} Small Egg · {zone:1439} Darkshore · {item:6290} Brilliant Smallfish · {npc:6286} Zarrin · {area:186} Dolanaar · {item:5472} Kaldorei Spider Kabob
	-- plural, as words: Small Spider Legs = {item:5465} Small Spider Leg
	["{item:6888} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. {item:6888} comes with {skill:185} (the client teaches it with the skill); {item:2678} are a cooking vendor's. The Strigid owls of {zone:1438} drop a {item:6889} more often than not, and {zone:1439}'s moonkin drop them too. Fishers can cook {item:6290} (recipe 40c) from Rut'theran's waters instead, and {npc:6286} in {area:186} gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for {item:5472}, orange from 10 to 50."] = "{item:6888}은(는) 1부터 주황색입니다(노랑 45, 초록 65, 회색 85). 50까지 약 50번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. {item:6888}은(는) {skill:185}와(과) 함께 옵니다(클라이언트가 기술과 함께 가르침). {item:2678}은(는) 요리 상인의 것입니다. {zone:1438}의 스트리기드 올빼미는 {item:6889}을(를) 자주 떨어뜨리고, {zone:1439}의 달빛야수도 떨어뜨립니다. 낚시꾼은 대신 루테란 마을 앞 바다에서 {item:6290}(제조법 40코퍼)을 만들 수 있고, {area:186}의 {npc:6286}은(는) 칼도레의 제조법(웹우드 거미에게서 작은 거미 다리 일곱 개)로 {item:5472}를(을) 주며 10에서 50까지 주황색입니다.",

	-- Step 9: Get Stringy Wolf Meat
	-- {item:2672} Stringy Wolf Meat · {spell:2538} Charred Wolf Meat · {npc:250873} Juvenile Vuldren
	["You need 50 {item:2672} for {spell:2538} (1-50). It drops from {npc:250873} in Zephras Isle. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 10: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {item:2672} Stringy Wolf Meat
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. The Vuldren of Zephras Isle drop {item:2672}."] = "{spell:2538}은(는) 1부터 주황색입니다(노랑 45, 초록 65, 회색 85). 50까지 약 50번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. 제프라스 섬의 불드렌이 {item:2672}를(을) 떨어뜨립니다.",

	-- Step 11: Get Chunk of Boar Meat
	-- {item:769} Chunk of Boar Meat · {spell:2540} Roasted Boar Meat · {npc:3099} Dire Mottled Boar · {zone:1411} Durotar
	["You need 50 {item:769} for {spell:2540} (1-50). It drops from {npc:3099} (99%) in {zone:1411}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 13: Get Stringy Wolf Meat
	-- {item:2672} Stringy Wolf Meat · {spell:2538} Charred Wolf Meat · {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["You need 50 {item:2672} for {spell:2538} (1-50). It drops from {npc:2960} (82%), {npc:2959} (77%) in {zone:1412}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 15: Get Stringy Wolf Meat
	-- {item:2672} Stringy Wolf Meat · {spell:2538} Charred Wolf Meat · {npc:1547} Decrepit Darkhound · {npc:1548} Cursed Darkhound · {zone:1420} Tirisfal Glades
	["You need 50 {item:2672} for {spell:2538} (1-50). It drops from {npc:1547} (72%), {npc:1548} (33%) in {zone:1420}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 17: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "수습 {skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and no character level: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "수습 {skill:185}은(는) 최대 숙련도를 150으로 올립니다. 숙련도 50이 필요하고 캐릭터 레벨 제한은 없습니다. 화살표가 진영의 가장 가까운 {skill:185} 상급자를 가리킵니다. 훈련 비용은 5실버입니다.",

	-- Step 18: Get Coyote Meat
	-- {item:2673} Coyote Meat
	["Get {item:2673}"] = "",
	-- {item:2673} Coyote Meat · {spell:2541} Coyote Steak · {npc:833} Coyote Packleader · {zone:1436} Westfall
	["You need 40 {item:2673} for {spell:2541} (50-90). It drops from Coyote (54%), {npc:833} (51%) in {zone:1436}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 19: Coyote Steak (50-90)
	-- {spell:2541} Coyote Steak · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {npc:235} Salma Saldean · {area:108} Sentinel Hill · {item:733} Westfall Stew · {item:724} Goretusk Liver Pie
	["{spell:2541} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. Coyotes roam the middle of {zone:1436}; {npc:235} on the farm north of {area:108} also gives {item:733} and {item:724} quests that use what you loot here."] = "{spell:2541}은(는) 50부터 주황색입니다(노랑 90, 초록 110, 회색 130). 90까지 약 40번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. 어떤 {skill:185} 상급자든 50에서 1실버에 가르칩니다. 코요테가 {zone:1436} 중앙을 돌아다니고, {area:108} 북쪽 농가의 {npc:235}도(도) 여기서 훔친 것을 쓰는 {item:733}와(과) {item:724} 퀘스트를 줍니다.",

	-- Step 20: Crab Cake: shopping
	-- {spell:2544} Crab Cake
	["{spell:2544}: shopping"] = "{spell:2544}: 구매",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 44 {item:2678} (90c)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:2678} 44개(90c)가 필요합니다.",

	-- Step 21: Get Crawler Meat
	-- {item:2674} Crawler Meat
	["Get {item:2674}"] = "",
	-- {item:2674} Crawler Meat · {spell:2544} Crab Cake · {npc:830} Sand Crawler · {zone:1436} Westfall
	["You need 44 {item:2674} for {spell:2544} (90-130). It drops from {npc:830} (43%) in {zone:1436}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 22: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1436} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544}은(는) 90부터 주황색입니다(노랑 115, 초록 135, 회색 155). 130까지 약 44번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. 어떤 {skill:185} 상급자든 75에서 2실버에 가르칩니다. 게가 {zone:1436} 해안 전체에 있습니다. 130까지 만들면 {spell:3376}이(가) 이어받습니다.",

	-- Step 23: Smoked Bear Meat: shopping
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: shopping"] = "{item:6890}: 구매",
	["The arrow picks the nearest vendor of your faction for each item."] = "화살표가 아이템마다 진영의 가장 가까운 상인을 가리킵니다.",

	-- Step 24: Get Bear Meat
	-- {item:3173} Bear Meat
	["Get {item:3173}"] = "",
	-- {item:3173} Bear Meat · {item:6890} Smoked Bear Meat · {npc:1189} Black Bear Patriarch · {zone:1432} Loch Modan
	["You need 30 {item:3173} for {item:6890} (50-80). It drops from {npc:1189} (39%) in {zone:1432}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 25: Smoked Bear Meat (50-80)
	-- {item:6890} Smoked Bear Meat · {object:29784} Basic Campfire · {item:6892} Recipe: Smoked Bear Meat · {zone:1432} Loch Modan
	["{item:6890} is orange from 50 (yellow at 80, green at 100, grey at 120): about 30 crafts to 80. Cook at any fire: a town hearth or your own {object:29784}. {item:6892} costs 2s 50c at its vendor; the arrow picks the nearest one of your faction. Black bears roam the hills of {zone:1432}."] = "{item:6890}은(는) 50부터 주황색입니다(노랑 80, 초록 100, 회색 120). 80까지 약 30번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. {item:6892}은(는) 상인에게 2실버 50코퍼이며, 화살표가 당신 진영의 가장 가까운 상인을 가리킵니다. 흰곰이 {zone:1432}의 언덕을 돌아다닙니다.",

	-- Step 26: Dry Pork Ribs: shopping
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: shopping"] = "{spell:2546}: 구매",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2678} (1s 10c)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:2678} 52개(1실버 10코퍼)가 필요합니다.",

	-- Step 27: Get Boar Ribs
	-- {item:2677} Boar Ribs
	["Get {item:2677}"] = "",
	-- {item:2677} Boar Ribs · {spell:2546} Dry Pork Ribs · {npc:1191} Mangy Mountain Boar · {zone:1432} Loch Modan
	["You need 52 {item:2677} for {spell:2546} (80-130). It drops from {npc:1191} (31%) in {zone:1432}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 28: Dry Pork Ribs (80-130)
	-- {spell:2546} Dry Pork Ribs · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1432} Loch Modan · {spell:3376} Curiously Tasty Omelet
	["{spell:2546} is orange from 80 (yellow at 120, green at 140, grey at 160): about 52 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 80 for 1s 50c. Mountain boars roam all of {zone:1432}. Cook it to 130, where {spell:3376} takes over."] = "{spell:2546}은(는) 80부터 주황색입니다(노랑 120, 초록 140, 회색 160). 130까지 약 52번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. 어떤 {skill:185} 상급자든 80에서 1실버 50코퍼에 가르칩니다. 산돼지가 {zone:1432} 전체를 돌아다닙니다. 130까지 만들면 {spell:3376}이(가) 이어받습니다.",

	-- Step 29: Boiled Clams: shopping
	-- {item:5525} Boiled Clams
	["{item:5525}: shopping"] = "{item:5525}: 구매",
	-- {item:159} Refreshing Spring Water
	["The arrow picks the nearest vendor of your faction for each item. You need 40 {item:159} (2s)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:159} 40개(2실버)가 필요합니다.",

	-- Step 30: Get Clam Meat
	-- {item:5503} Clam Meat
	["Get {item:5503}"] = "",
	-- {item:5503} Clam Meat · {item:5525} Boiled Clams · {npc:3812} Clattering Crawler · {npc:3814} Spined Crawler · {npc:3944} Wrathtail Priestess · {zone:1439} Darkshore
	-- plural, as words: Small Barnacled Clams = {item:5523} Small Barnacled Clam
	["You need 40 {item:5503} for {item:5525} (50-90). It comes in Small Barnacled Clams, which {npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439} drop: open each one. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice."] = "",

	-- Step 31: Boiled Clams (50-90)
	-- {item:5525} Boiled Clams · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2674} Crawler Meat · {spell:2544} Crab Cake
	["{item:5525} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. The same coastal crawlers drop {item:2674} for {spell:2544} next: keep it."] = "{item:5525}은(는) 50부터 주황색입니다(노랑 90, 초록 110, 회색 130). 90까지 약 40번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. 어떤 {skill:185} 상급자든 50에서 1실버에 가르칩니다. 같은 해안 게가 다음 {spell:2544}에 쓰는 {item:2674}를(을) 떨어뜨립니다. 간직하세요.",

	-- Step 33: Get Crawler Meat
	-- {item:2674} Crawler Meat · {spell:2544} Crab Cake · {npc:3814} Spined Crawler · {npc:3812} Clattering Crawler · {zone:1439} Darkshore
	["You need 44 {item:2674} for {spell:2544} (90-130). It drops from {npc:3814} (42%), {npc:3812} (40%) in {zone:1439}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 34: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1439} Darkshore · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1439} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544}은(는) 90부터 주황색입니다(노랑 115, 초록 135, 회색 155). 130까지 약 44번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. 어떤 {skill:185} 상급자든 75에서 2실버에 가르칩니다. 게가 {zone:1439} 해안 전체에 있습니다. 130까지 만들면 {spell:3376}이(가) 이어받습니다.",

	-- Step 35: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477}: 구매",
	-- {item:4536} Shiny Red Apple
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:4536} (2s 75c)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:4536} 52개(2실버 75코퍼)가 필요합니다.",

	-- Step 36: Get Strider Meat
	-- {item:5469} Strider Meat
	["Get {item:5469}"] = "",
	-- {item:5469} Strider Meat · {item:5477} Strider Stew · {npc:3246} Fleeting Plainstrider · {zone:1413} The Barrens
	["You need 52 {item:5469} for {item:5477} (50-100). It drops from {npc:3246} (32%) in {zone:1413}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 37: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {item:5486} Recipe: Strider Stew
	["{item:5477} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100. Cook at any fire: a town hearth or your own {object:29784}. {item:5486} costs 4s 40c at its vendor; the arrow picks the nearest one of your faction."] = "{item:5477}은(는) 50부터 주황색입니다(노란색 90, 초록색 110, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요: 마을 화로나 직접 피운 {object:29784}. {item:5486}은(는) 상인에게서 4실버 40코퍼에 팝니다. 화살표가 진영의 가장 가까운 상인을 가리킵니다.",

	-- Step 38: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479}: 구매",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 30 {item:2692} (12s)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:2692} 30개(12실버)가 필요합니다.",

	-- Step 39: Get Thunder Lizard Tail
	-- {item:5470} Thunder Lizard Tail
	["Get {item:5470}"] = "",
	-- {item:5470} Thunder Lizard Tail · {item:5479} Crispy Lizard Tail · {npc:3239} Thunderhead · {zone:1413} The Barrens
	["You need 30 {item:5470} for {item:5479} (100-130). It drops from {npc:3239} (59%), Owatanka (35%) in {zone:1413}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 40: Crispy Lizard Tail (100-130)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {item:5488} Recipe: Crispy Lizard Tail · {npc:3489} Zargh · {item:3735} Recipe: Hot Lion Chops
	["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the Crossroads, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "{item:5479}은(는) 100부터 주황색입니다(노랑 140, 초록 160, 회색 180). 130까지 약 30번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. {item:5488}은(는) 상인에게 4실버이며, 화살표가 당신 진영의 가장 가까운 상인을 가리킵니다. 십자로 그 상인 옆 정육점 {npc:3489}이(가) 전문가 다음 제조법 {item:3735}(18실버)를(을) 팝니다. 지금 사세요.",

	-- Step 41: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "숙련 {skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072} (1g); the arrow picks its nearest seller for your faction. Buy it and read it."] = "숙련 {skill:185}은(는) 최대 숙련도를 225로 올립니다. 숙련도 125, 캐릭터 레벨 20이 필요합니다. 책 {item:16072}(1골드)(으)로 배우며, 화살표가 진영의 가장 가까운 판매 상인을 가리킵니다. 사서 읽으세요.",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "{item:16072} 사서 읽기 (숙련 {skill:185})",

	-- Step 42: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376}: 구매",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 46 {item:2692} (18s 40c)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:2692} 46개(18실버 40코퍼)가 필요합니다.",

	-- Step 43: Get Raptor Egg
	-- {item:3685} Raptor Egg
	["Get {item:3685}"] = "",
	-- {item:3685} Raptor Egg · {spell:3376} Curiously Tasty Omelet · {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["You need 46 {item:3685} for {spell:3376} (130-175). It drops from {npc:1018} (72%), {npc:1019} (67%) in {zone:1437}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 44: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {item:3682} Recipe: Curiously Tasty Omelet · {zone:1437} Wetlands · {item:3685} Raptor Egg · {npc:340} Kendor Kabonka · {zone:1453} Stormwind
	["{spell:3376} is orange from 130 (yellow at 170, green at 190, grey at 210): about 46 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3682} costs 16s at its vendor; the arrow picks the nearest one of your faction. The raptors of the {zone:1437} drop a {item:3685} about two kills in three. {npc:340} in {zone:1453} sells the recipe."] = "{spell:3376}은(는) 130부터 주황색입니다(노랑 170, 초록 190, 회색 210). 175까지 약 46번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. {item:3682}은(는) 상인에게 16실버이며, 화살표가 당신 진영의 가장 가까운 상인을 가리킵니다. {zone:1437}의 랩터는 세 마리 중 두 마리에서 {item:3685}를(을) 떨어뜨립니다. {zone:1453}의 {npc:340}이(가) 제조법을 팝니다.",

	-- Step 45: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398}: 구매",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 45 {item:2692} (18s)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:2692} 45개(18실버)가 필요합니다.",

	-- Step 46: Get Lion Meat
	-- {item:3731} Lion Meat
	["Get {item:3731}"] = "",
	-- {item:3731} Lion Meat · {spell:3398} Hot Lion Chops · {npc:2384} Starving Mountain Lion · {zone:1424} Hillsbrad Foothills
	["You need 45 {item:3731} for {spell:3398} (130-175). It drops from {npc:2384} (42%) in {zone:1424}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 47: Hot Lion Chops (130-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {item:3735} Recipe: Hot Lion Chops · {item:3731} Lion Meat
	-- plural, as words: Hulking Mountain Lions = {npc:2407} Hulking Mountain Lion
	["{spell:3398} is orange from 130 (yellow at 175, green at 195, grey at 215): about 45 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3735} costs 18s at its vendor; the arrow picks the nearest one of your faction. The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop {item:3731} more often than the Starving ones."] = "{spell:3398}은(는) 130부터 주황색입니다(노랑 175, 초록 195, 회색 215). 175까지 약 45번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. {item:3735}은(는) 상인에게 18실버이며, 화살표가 당신 진영의 가장 가까운 상인을 가리킵니다. 힐스브래드 구릿길의 야생 산사자와 덩치큰 산사자가 굶주린 산사자보다 {item:3731}을(를) 더 자주 떨어뜨립니다.",

	-- Step 48: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210}: 구매",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2692} (20s 80c)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:2692} 52개(20실버 80코퍼)가 필요합니다.",

	-- Step 49: Get Raptor Flesh
	-- {item:12184} Raptor Flesh
	["Get {item:12184}"] = "",
	-- {item:12184} Raptor Flesh · {item:12210} Roast Raptor · {npc:2560} Highland Thrasher · {zone:1417} Arathi Highlands
	["You need 52 {item:12184} for {item:12210} (175-225). It drops from {npc:2560} (38%) in {zone:1417}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 50: Roast Raptor (175-225)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {item:12228} Recipe: Roast Raptor · {zone:1417} Arathi Highlands · {npc:2810} Hammon Karwn · {area:320} Refuge Pointe · {npc:2821} Keena · {area:321} Hammerfall · {item:2692} Hot Spices · {item:17222} Spider Sausage · {item:12205} White Spider Meat
	["{item:12210} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225. Cook at any fire: a town hearth or your own {object:29784}. {item:12228} costs 50s at its vendor; the arrow picks the nearest one of your faction. {zone:1417}: {npc:2810} at {area:320} (Alliance) and {npc:2821} at {area:321} (Horde) sell the recipe and {item:2692} beside the raptors. {item:17222} (any trainer from 200, 40s) is the alternative, but it takes two {item:12205} a craft and Dustwallow's spiders drop one about two kills in five."] = "{item:12210}은(는) 175부터 주황색입니다(노랑 215, 초록 235, 회색 255). 225까지 약 52번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. {item:12228}은(는) 상인에게 50실버이며, 화살표가 당신 진영의 가장 가까운 상인을 가리킵니다. {zone:1417}: {area:320}의 {npc:2810}(얼라이언스)과(와) {area:321}의 {npc:2821}(호드)이(가) 랩터 옆에서 제조법과 {item:2692}를(을) 팝니다. {item:17222}(200부터 어떤 상급자든, 40실버)가 대안이지만 제작당 {item:12205} 두 개가 들고, 더스트왈로의 거미가 다섯 마리 중 두 마리에서 떨어뜨립니다.",

	-- Step 51: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "전문 {skill:185}은(는) {area:976}({zone:1446})의 {npc:8125}에게 배웁니다. {zone:1455}의 요리 상급자가 보내 줍니다. 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 52: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "전문 {skill:185}은(는) {area:976}({zone:1446})의 {npc:8125}에게 배웁니다. {zone:1454}의 요리 상급자가 보내 줍니다. 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 53: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "거대한 알",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast · {item:12218} Monster Omelet
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%). {item:12218} takes about 120 more after Artisan: farm them now too if you like."] = "{quest:6610}은(는) 거대한 알 12개, {item:7974} 10개, {item:8932} 20개를 요구합니다. {zone:1446}에 가기 전에 세 가지를 모두 가져오세요. 한 번의 여행으로 끝내기 위해서입니다. 거대한 알은 {zone:1425}의 올빼미야수에게서 떨어집니다: {npc:2929}(54%). 전문 단계 이후 {item:12218}은(는) 약 120개가 더 필요합니다. 원한다면 지금도 모으세요.",

	-- Step 54: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "여관주인과 음식 상인이 {item:8932}을(를) 팝니다. 화살표가 가장 가까운 이를 가리킵니다.",

	-- Step 55: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974}은(는) 큰입조개에게서 나옵니다. 하나씩 열으세요. 모든 조개가 하나씩 담고 있습니다. 테라모어 남서쪽 {zone:1445} 해안의 먹물집게는 열 마리 중 일곱 마리에서 조개를 떨어뜨리니 열 개는 약 열다섯 마리를 잡는 것으로, {zone:1446}에 가는 길에 하세요. {zone:1446} 동쪽 해안의 강철 무쇠턱거북은 세 마리 중 한 마리에서 떨어뜨립니다.",

	-- Step 56: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "전문 {skill:185}",

	-- Step 57: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218}: 구매",
	-- {item:3713} Soothing Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 240 {item:3713} (3g 84s)."] = "화살표가 각 아이템마다 당신 진영의 가장 가까운 상인을 가리킵니다. {item:3713} 240개(3골드 84실버)가 필요합니다.",

	-- Step 58: Get Giant Egg
	-- {item:12207} Giant Egg
	["Get {item:12207}"] = "",
	-- {item:12207} Giant Egg · {item:12218} Monster Omelet · {npc:2929} Savage Owlbeast · {zone:1425} The Hinterlands
	["You need 120 {item:12207} for {item:12218} (225-300). It drops from {npc:2929} (54%) in {zone:1425}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 59: Monster Omelet (225-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {item:16110} Recipe: Monster Omelet · {item:13931} Nightfin Soup · {npc:8137} Gikkix · {area:977} Steamwheedle Port · {item:13932} Poached Sunscale Salmon · {item:279982} Iron Oven
	["{item:12218} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300. Cook at any fire: a town hearth or your own {object:29784}. {item:16110} costs 1g 20s at its vendor; the arrow picks the nearest one of your faction. {item:12218} is orange to 265 and green from 285, yet it still carries you to 300. Fishers can finish on {item:13931} ({npc:8137}, {area:977}; yellow to 310) instead; {item:13932} needs an {item:279982} on Forever."] = "{item:12218}은(는) 225부터 주황색입니다(노랑 265, 초록 285, 회색 305). 300까지 약 120번 만드세요 아무 불에서나 요리하세요. 마을 화로나 직접 만든 {object:29784}이(가) 있습니다. {item:16110}은(는) 상인에게 1골드 20실버이며, 화살표가 당신 진영의 가장 가까운 상인을 가리킵니다. {item:12218}은(는) 265까지 주황색이고 285부터 초록색이지만 그래도 300까지 갑니다. 낚시꾼은 대신 {item:13931}({npc:8137}, {area:977}; 310까지 노란색)로 끝낼 수 있습니다. {item:13932}은(는) Forever에서 {item:279982}이(가) 필요합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "진영의 모든 {skill:185} 상급자가 초급 {skill:185}을(를) 가르칩니다(캐릭터 레벨 5). 화살표가 가장 가까운 곳을 가리킵니다.",
	-- ["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "이곳에서 낚시로 {item:6291} 약 50개를 잡으세요({skill:356} 가이드 참고).",
	-- ["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "이곳에서 낚시로 {item:6361} 약 68개를 잡으세요({skill:356} 가이드 참고).",
	-- ["Coyote (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}의 코요테 (54%), {npc:833} (51%), 또는 화살표가 가리키는 곳",
	-- ["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "거대한 알은 {zone:1448}의 무쇠부리 올빼미가 떨어뜨립니다.",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "수습 {skill:185}은(는) 최대 숙련도를 150으로 올립니다. 숙련도 50, 캐릭터 레벨 10이 필요합니다. 화살표가 진영의 가장 가까운 {skill:185} 상급자를 가리킵니다.",
	-- ["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "{zone:1429}의 굶주린 늑대 (86%), 또는 화살표가 가리키는 곳",
	-- ["Vuldren, {npc:250874} in Zephras Isle, or wherever the arrow points"] = "제프라스 섬의 벌드렌, {npc:250874}, 또는 화살표가 가리키는 곳",
	-- ["What {item:12210} takes that the Auction House sells: 52 {item:12184}. The counts drop by what your bags, bank and mail hold."] = "{item:12210}에 필요한 것 중 경매장에서 파는 것: {item:12184} 52개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {item:12218} takes that the Auction House sells: 120 {item:12207}. The counts drop by what your bags, bank and mail hold."] = "{item:12218}에 필요한 것 중 경매장에서 파는 것: {item:12207} 120개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {item:5477} takes that the Auction House sells: 52 {item:5469}. The counts drop by what your bags, bank and mail hold."] = "{item:5477}에 필요한 것 중 경매장에서 파는 것: {item:5469} 52개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {item:5479} takes that the Auction House sells: 30 {item:5470}. The counts drop by what your bags, bank and mail hold."] = "{item:5479}에 필요한 것 중 경매장에서 파는 것: {item:5470} 30개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {item:6888} takes that the Auction House sells: 50 {item:6889}. The counts drop by what your bags, bank and mail hold."] = "{item:6888}에 필요한 것 중 경매장에서 파는 것: {item:6889} 50개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {item:6890} takes that the Auction House sells: 30 {item:3173}. The counts drop by what your bags, bank and mail hold."] = "{item:6890}에 필요한 것 중 경매장에서 파는 것: {item:3173} 30개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {spell:2538} takes that the Auction House sells: 50 {item:2672}. The counts drop by what your bags, bank and mail hold."] = "{spell:2538}에 필요한 것 중 경매장에서 파는 것: {item:2672} 50개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {spell:2540} takes that the Auction House sells: 50 {item:769}. The counts drop by what your bags, bank and mail hold."] = "{spell:2540}에 필요한 것 중 경매장에서 파는 것: {item:769} 50개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {spell:2541} takes that the Auction House sells: 40 {item:2673}. The counts drop by what your bags, bank and mail hold."] = "{spell:2541}에 필요한 것 중 경매장에서 파는 것: {item:2673} 40개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {spell:2544} takes that the Auction House sells: 44 {item:2674}. The counts drop by what your bags, bank and mail hold."] = "{spell:2544}에 필요한 것 중 경매장에서 파는 것: {item:2674} 44개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {spell:2546} takes that the Auction House sells: 52 {item:2677}. The counts drop by what your bags, bank and mail hold."] = "{spell:2546}에 필요한 것 중 경매장에서 파는 것: {item:2677} 52개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {spell:3376} takes that the Auction House sells: 46 {item:3685}. The counts drop by what your bags, bank and mail hold."] = "{spell:3376}에 필요한 것 중 경매장에서 파는 것: {item:3685} 46개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What {spell:3398} takes that the Auction House sells: 45 {item:3731}. The counts drop by what your bags, bank and mail hold."] = "{spell:3398}에 필요한 것 중 경매장에서 파는 것: {item:3731} 45개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["{area:442} docks"] = "{area:442} 부두",
	-- ["{area:702} docks"] = "{area:702} 부두",
	-- ["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210}은(는) 175부터 주황색입니다(노란색 215, 회색 255). 215까지 약 40번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:12210}: Auction House"] = "{item:12210}: 경매장",
	-- ["{item:12210}: ingredients"] = "{item:12210}: 재료",
	-- ["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}은(는) 215부터 주황색입니다(노란색 240, 회색 280). 225까지 약 10번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}은(는) 225부터 주황색입니다(노란색 240, 회색 280). 240까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:12215}: ingredients"] = "{item:12215}: 재료",
	-- ["{item:12215}: shopping"] = "{item:12215}: 구매",
	-- ["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218}은(는) 240부터 주황색입니다(노란색 265, 회색 305). 300까지 약 105번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:12218}: Auction House"] = "{item:12218}: 경매장",
	-- ["{item:12218}: ingredients"] = "{item:12218}: 재료",
	-- ["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 110까지 약 68번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다. {area:442} 부두에서 {skill:356}을(를) 하면 {item:6361}이(가) 낚입니다.",
	-- ["{item:5095}: ingredients"] = "{item:5095}: 재료",
	-- ["{item:5095}: shopping"] = "{item:5095}: 구매",
	-- ["{item:5477}: Auction House"] = "{item:5477}: 경매장",
	-- ["{item:5477}: ingredients"] = "{item:5477}: 재료",
	-- ["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}은(는) 100부터 주황색입니다(노란색 140, 회색 180). 125까지 약 25번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}은(는) 125부터 주황색입니다(노란색 140, 회색 180). 140까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5479}: Auction House"] = "{item:5479}: 경매장",
	-- ["{item:5479}: ingredients"] = "{item:5479}: 재료",
	-- ["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}은(는) 110부터 주황색입니다(노란색 150, 회색 190). 125까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}은(는) 125부터 주황색입니다(노란색 150, 회색 190). 150까지 약 25번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5480}: ingredients"] = "{item:5480}: 재료",
	-- ["{item:5480}: shopping"] = "{item:5480}: 구매",
	-- ["{item:5525}: ingredients"] = "{item:5525}: 재료",
	-- ["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290}은(는) 1부터 주황색입니다(노란색 45, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다. {item:6291}은(는) {zone:1438} 물가에서 흔히 낚입니다.",
	-- ["{item:6290}: ingredients"] = "{item:6290}: 재료",
	-- ["{item:6290}: shopping"] = "{item:6290}: 구매",
	-- ["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:6316}: ingredients"] = "{item:6316}: 재료",
	-- ["{item:6316}: shopping"] = "{item:6316}: 구매",
	-- ["{item:6888}: Auction House"] = "{item:6888}: 경매장",
	-- ["{item:6888}: ingredients"] = "{item:6888}: 재료",
	-- ["{item:6890}: Auction House"] = "{item:6890}: 경매장",
	-- ["{item:6890}: ingredients"] = "{item:6890}: 재료",
	-- ["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:724}: ingredients"] = "{item:724}: 재료",
	-- ["{item:724}: shopping"] = "{item:724}: 구매",
	-- ["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974}은(는) 획득 데이터가 없습니다. 가젯잔 경매장({npc:8125} 옆)에서 사거나, 해안 생물에게서 얻은 조개를 여세요.",
	-- ["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{zone:1437}의 {npc:1018} (72%), {npc:1019} (67%), 또는 화살표가 가리키는 곳",
	-- ["{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, or wherever the arrow points"] = "{zone:1426}의 {npc:1126} (36%), {npc:1125} (34%), 또는 화살표가 가리키는 곳",
	-- ["{npc:1189} (39%) in {zone:1432}, or wherever the arrow points"] = "{zone:1432}의 {npc:1189} (39%), 또는 화살표가 가리키는 곳",
	-- ["{npc:1191} (31%) in {zone:1432}, or wherever the arrow points"] = "{zone:1432}의 {npc:1191} (31%), 또는 화살표가 가리키는 곳",
	-- ["{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, or wherever the arrow points"] = "{zone:1420}의 {npc:1547} (72%), {npc:1548} (33%), 또는 화살표가 가리키는 곳",
	-- ["{npc:1995} (58%) in {zone:1438}, or wherever the arrow points"] = "{zone:1438}의 {npc:1995} (58%), 또는 화살표가 가리키는 곳",
	-- ["{npc:2384} (42%) in {zone:1424}, or wherever the arrow points"] = "{zone:1424}의 {npc:2384} (42%), 또는 화살표가 가리키는 곳",
	-- ["{npc:250873} in Zephras Isle, or wherever the arrow points"] = "제프라스 섬의 {npc:250873}, 아니면 화살표가 가리키는 곳",
	-- ["{npc:2560} (38%) in {zone:1417}, or wherever the arrow points"] = "{zone:1417}의 {npc:2560}(38%), 아니면 화살표가 가리키는 곳",
	-- ["{npc:2929} (54%) in {zone:1425}, or wherever the arrow points"] = "{zone:1425}의 {npc:2929}(54%), 아니면 화살표가 가리키는 곳",
	-- ["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{zone:1412}의 {npc:2960} (82%), {npc:2959} (77%), 또는 화살표가 가리키는 곳",
	-- ["{npc:3099} (99%) in {zone:1411}, or wherever the arrow points"] = "{zone:1411}의 {npc:3099} (99%), 또는 화살표가 가리키는 곳",
	-- ["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}의 {npc:3239} (59%), 오와탄카 (35%), 또는 화살표가 가리키는 곳",
	-- ["{npc:3246} (32%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}의 {npc:3246} (32%), 또는 화살표가 가리키는 곳",
	-- ["{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, or wherever the arrow points; open each {item:5523} for its {item:5503}"] = "{zone:1439}의 {npc:3812}(42%), {npc:3814}(42%), {npc:3944}(42%), 아니면 화살표가 가리키는 곳. {item:5523}을(를) 열어 {item:5503}을(를) 얻으세요.",
	-- ["{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, or wherever the arrow points"] = "{zone:1439}의 {npc:3814} (42%), {npc:3812} (40%), 또는 화살표가 가리키는 곳",
	-- ["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{zone:1443}의 {npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%), 또는 화살표가 가리키는 곳",
	-- ["{npc:830} (43%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}의 {npc:830} (43%), 또는 화살표가 가리키는 곳",
	-- ["{npc:834} (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}의 {npc:834} (54%), {npc:833} (51%), 또는 화살표가 가리키는 곳",
	-- ["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610}에는 {item:8932} 20개가 필요합니다(퀘스트 목록 확인). 여관주인과 음식 상인이 팔며, 화살표가 가장 가까운 곳을 가리킵니다.",
	-- ["{spell:2538}: Auction House"] = "{spell:2538}: 경매장",
	-- ["{spell:2538}: ingredients"] = "{spell:2538}: 재료",
	-- ["{spell:2540}: Auction House"] = "{spell:2540}: 경매장",
	-- ["{spell:2540}: ingredients"] = "{spell:2540}: 재료",
	-- ["{spell:2541}: Auction House"] = "{spell:2541}: 경매장",
	-- ["{spell:2541}: ingredients"] = "{spell:2541}: 재료",
	-- ["{spell:2544}: Auction House"] = "{spell:2544}: 경매장",
	-- ["{spell:2544}: ingredients"] = "{spell:2544}: 재료",
	-- ["{spell:2546}: Auction House"] = "{spell:2546}: 경매장",
	-- ["{spell:2546}: ingredients"] = "{spell:2546}: 재료",
	-- ["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}은(는) 100부터 주황색입니다(노란색 120, 회색 160). 125까지 약 26번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}은(는) 125부터 노란색입니다(노란색 120, 회색 160). 130까지 약 7번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3370}: ingredients"] = "{spell:3370}: 재료",
	-- ["{spell:3370}: shopping"] = "{spell:3370}: 구매",
	-- ["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}은(는) 130부터 주황색입니다(노란색 170, 회색 210). 175까지 약 46번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}은(는) 150부터 주황색입니다(노란색 170, 회색 210). 175까지 약 26번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3376}: Auction House"] = "{spell:3376}: 경매장",
	-- ["{spell:3376}: ingredients"] = "{spell:3376}: 재료",
	-- ["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398}은(는) 140부터 주황색입니다(노란색 175, 회색 215). 175까지 약 35번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3398}: Auction House"] = "{spell:3398}: 경매장",
	-- ["{spell:3398}: ingredients"] = "{spell:3398}: 재료",
}
