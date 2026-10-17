-- Korean (koKR): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",
	-- {area:1978} Misty Reed Post · {area:75} Stonard · {object:3202} Grom'gol
	["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "{area:1978}에서 북서쪽의 {area:75}(으)로 돌아가 {object:3202}(으)로 날아가세요.",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "{zone:1454}행 비행선은 {object:3202} 옆의 탑에서 출발하며, {zone:1454} 정문 바로 밖에 도착합니다.",
	["Zeppelin tower"] = "비행선 탑",

	-- Step 4: Riding at 40
	["Riding at 40"] = "40레벨 탈것 타기",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "탈것 타기는 40레벨이 필요하고 100골드가 듭니다. 배우면 탈것을 하나 받습니다. {npc:4752}은(는) {object:172958}의 {npc:3362} 우리 옆에서 오크에게 가르칩니다. 스카이본 탈것 타기 상급자는 알려진 바가 없으니, 스카이본도 {npc:4752}에게 시도해 보세요. 종족의 다른 탈것은 각각 20골드입니다: 수집품, 탈것 · 40레벨에 각각의 가이드가 있습니다.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "탈것 타기 상급자 {npc:4752}",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "늑대: {npc:4752} 옆의 {npc:3362}",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "돌풍타조: 제프라스 섬 {area:16638}의 {npc:265756}",

	-- Step 5: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "탈것 타기는 40레벨이 필요하고 100골드가 듭니다. 배우면 탈것을 하나 받습니다. 클래식에서는 각 종족이 자기 종족의 상급자에게서 배웁니다. 당신의 상급자는 {zone:1411} 해안 {area:367}의 {npc:7953}이며, 그 옆에서 졸니르가 랩터(각 20골드)를 팝니다. Forever에서는 어느 종족이든 아무 탈것 타기 상급자에게서 배울 수 있을지도 모릅니다(확인되지 않음). 가장 가까운 {zone:1454} {object:172958}의 {npc:4752}에게 먼저 시도하고, 그가 가르쳐 주면 이 단계는 건너뛰세요.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "탈것 타기 상급자 {npc:7953}",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "랩터: {area:367}의 {npc:7953} 옆의 졸니르",

	-- Step 6: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "탈것 타기는 40레벨이 필요하고 100골드가 듭니다. 배우면 탈것을 하나 받습니다. 클래식에서는 각 종족이 자기 종족의 상급자에게서 배웁니다. 당신의 상급자는 {area:222}의 {npc:3690}이며, 그 옆에서 {npc:3685}이(가) 코도(각 20골드)를 팝니다. Forever에서는 어느 종족이든 아무 탈것 타기 상급자에게서 배울 수 있을지도 모릅니다(확인되지 않음). 가장 가까운 {zone:1454} {object:172958}의 {npc:4752}에게 먼저 시도하고, 그가 가르쳐 주면 이 단계는 건너뛰세요.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "탈것 타기 상급자 {npc:3690}",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "코도: {area:222}의 {npc:3690} 옆의 {npc:3685}",

	-- Step 7: Riding at 40
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "탈것 타기는 40레벨이 필요하고 100골드가 듭니다. 배우면 탈것을 하나 받습니다. 클래식에서는 각 종족이 자기 종족의 상급자에게서 배웁니다. 당신의 상급자는 {area:159}의 {npc:4773}이며, 그 옆에서 {npc:4731}이(가) 해골마(각 20골드)를 팝니다. Forever에서는 어느 종족이든 아무 탈것 타기 상급자에게서 배울 수 있을지도 모릅니다(확인되지 않음). 가장 가까운 {zone:1454} {object:172958}의 {npc:4752}에게 먼저 시도하고, 그가 가르쳐 주면 이 단계는 건너뛰세요.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "탈것 타기 상급자 {npc:4773}",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "해골마: {area:159}의 {npc:4773} 옆의 {npc:4731}",

	-- Step 8: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {zone:1454} Orgrimmar · {area:484} Freewind Post
	["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "직업 상급자는 {area:1638}에 있습니다: {area:1639}의 {npc:3033}(드루이드), {npc:246344}(성기사). {zone:1454}에서 그곳으로 날아간 뒤 {area:484}(으)로 날아가세요.",

	-- Step 9: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "지옥마를 위해 {area:392}(으)로",

	-- Step 10: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "{area:484}(으)로 날아가기",
	-- {area:484} Freewind Post · {zone:1446} Tanaris
	["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "{area:484}(으)로 날아가 주둔지 동쪽 승강기를 타고 내려간 뒤, 소금 평원을 가로질러 남쪽 {zone:1446}(으)로 가세요.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976}은(는) {zone:1446} 경계를 막 지나서 있는 담장 두른 고블린 마을입니다.",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "광장의 {object:150075}",

	-- Step 12: Eastern Wastewander camps
	["Eastern Wastewander camps"] = "동쪽 사막유랑단 야영지",
	-- {area:976} Gadgetzan
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "약탈자와 좀도둑은 {area:976} 동쪽 모래언덕에 야영하고 있습니다. 사막유랑단은 누구나 물주머니를 지니고 있을 수 있습니다. 루글룬켓의 현상금 퀘스트 두 개에 다섯 개씩, 열 개를 보관하세요.",
	["water pouches in your bags"] = "가방 속 물주머니",

	-- Step 14: Southern Wastewander camps
	["Southern Wastewander camps"] = "남쪽 사막유랑단 야영지",
	-- {area:976} Gadgetzan
	["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "어둠마법사, 도적, 암살자는 {area:976} 남동쪽에 야영하고 있습니다.",

	-- Step 15: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "북동쪽 해안의 고블린 항구로 가세요.",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: 날카로운비명은 {zone:1444}에 삽니다",

	-- Step 16: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "해안을 따라 남쪽으로 가면 남쪽바다해적단이 만을 차지하고 있습니다. {npc:7883}와(과) 도난당한 화물은 만 맨 끝 부두에 있습니다. 해적은 누구나 모자를 떨어뜨릴 수 있으며, 납치범이 가장 자주 떨어뜨립니다.",

	-- Step 17: Steamwheedle Port
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "50레벨쯤 {area:35}에서",

	-- Step 18: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "서쪽의 {area:976}(으)로 돌아가세요.",

	-- Step 19: Fly to Freewind Post
	-- {area:484} Freewind Post · {area:2237} Whitereach Post · {zone:1444} Feralas · {area:1099} Camp Mojache
	["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "{area:484}(으)로 날아간 뒤 서쪽으로 협곡을 지나 {area:2237}을(를) 지나가세요. 길은 {zone:1444} 정글로 올라가 {area:1099}까지 이어집니다.",

	-- Step 20: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: 45레벨쯤 {zone:1454}에서",

	-- Step 21: Woodpaw north camp
	["Woodpaw north camp"] = "덩굴발일족 북쪽 야영지",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "덩굴발일족 놀은 모자케 야영지 바로 북서쪽 언덕에 야영하고 있습니다. 누구나 갈기를 떨어뜨릴 수 있습니다.",

	-- Step 22: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "놀 북쪽에서 오우거들이 언덕 위 전초기지를 차지하고 있습니다. 오우거 마법사는 끌어와서 처치하세요. 코발트는 전초기지 주변 흙더미에 있고, 두루마리는 그 안의 땅에 있습니다.",

	-- Step 23: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: 지금부터 한 시간",

	-- Step 24: Sprite darters and Woodpaw alphas
	["Sprite darters and Woodpaw alphas"] = "화살요정용과 덩굴발일족 우두머리",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "화살요정용은 모자케 야영지 바로 서쪽 숲 위를 날아다닙니다. 거의 모두 날개를 떨어뜨립니다. 덩굴발일족 우두머리는 그 남서쪽 야영지를 이끌고 있습니다. 한 시간 안에 처치하세요.",

	-- Step 26: Grimtotem camp
	["Grimtotem camp"] = "그림토템부족 야영지",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "그림토템부족 타우렌은 화살요정용의 숲 옆에 야영하고 있습니다. 침략자, 식물학자, 주술사 모두 뿔을 지니고 있습니다.",

	-- Step 27: Woodpaw battle map
	["Woodpaw battle map"] = "덩굴발일족 전투 지도",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "전투 지도는 모자케 야영지 남쪽의 덩굴발일족 야영지에 있습니다.",

	-- Step 28: Southern Gordunni ruins
	["Southern Gordunni ruins"] = "남쪽 골두니 폐허",
	-- {area:1105} Feral Scar Vale
	["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "남서쪽으로 {area:1105} 아래의 오우거 폐허로 가세요. 주술사, 흑마법사, 싸움꾼이 가득하며, 남쪽 끝의 대마법사가 구슬을 지니고 있습니다.",

	-- Step 29: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "45레벨쯤 {zone:1454}에서",

	-- Step 30: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "주크애쉬 벌집은 야영지 남동쪽 언덕 속으로 파고들어 있습니다. {quest:7731}은(는) 가장 깊은 방에서 기다립니다.",

	-- Step 32: Rogue Vale screechers
	["Rogue Vale screechers"] = "도적의 골짜기 날카로운비명",
	-- {zone:1444} Feralas · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "서쪽으로 {zone:1444} 한가운데로 가세요. {npc:5308}을(를) 처치하고 시체에 {item:10699}을(를) 사용한 뒤, 떠오르는 영혼을 처치하세요.",

	-- Step 33: The Forgotten Coast
	-- plural, as words: Coast Crawl Deepseers = {npc:5328} Coast Crawl Deepseer
	["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "계속 서쪽 해안으로 가세요. 해변의 점쟁이 바다마크루라와 집게발 바다마크루라는 마흔 마리에 한 번꼴로 OOX-22/FE 조난 탐지기를 떨어뜨립니다. 얻으면 사용해 퀘스트를 시작하세요.",

	-- Step 34: Homing Robot OOX-22/FE
	-- {area:1105} Feral Scar Vale · {area:1108} The Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "조난 탐지기가 있을 때만: 로봇은 {area:1105} 북쪽의 작은 동굴에 있습니다. {area:1108}의 부두까지 호위하세요. 가는 길에 설인과 고릴라가 습격합니다. 보상은 나중에 {area:35}에 들를 때 받습니다.",

	-- Step 35: Hearth to Camp Mojache
	-- {area:1099} Camp Mojache
	["Hearth to {area:1099}"] = "귀환석으로 {area:1099}에 가기",

	-- Step 36: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "{area:1637}(으)로 날아가세요. 드로퍼스 형제는 골목길에서 상점을 운영합니다.",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "48레벨쯤 {zone:1425}에서",

	-- Step 37: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "{object:3202}행 비행선",
	-- {object:3202} Grom'gol · {zone:1454} Orgrimmar
	["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "{object:3202}행 비행선은 {zone:1454} 정문 바로 북동쪽의 탑에서 출발합니다.",

	-- Step 38: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "{area:75}(으)로 날아가기",
	-- {area:75} Stonard
	["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "비행 조련사 시스타는 비행선 탑 바로 동쪽에 서 있습니다. {area:75}(으)로 날아가세요. 다음 가이드는 그곳에서 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "조난 탐지기가 있을 때만: 로봇은 {area:1105} 북쪽의 작은 동굴에 있습니다. {area:1108}의 부두까지 호위하세요. 가는 길에 설인과 고릴라가 습격합니다. 보상은 나중에 {area:35}에 들를 때 받습니다.",
}
