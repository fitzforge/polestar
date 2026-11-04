-- Korean (koKR): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 5: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {npc:3310} Doras · {object:172982} Valley of Strength
	["From the {area:380}, follow the road north-east to {zone:1454} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "",

	-- Step 6: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 7: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 8: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 10: The Sepulcher
	-- {area:228} The Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it.\nSwim back and follow the road west to the {area:228}."] = "",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "",

	-- Step 12: Moonrage Whitescalp on the way
	-- {npc:1769} Moonrage Whitescalp
	["{npc:1769} on the way"] = "",

	-- Step 14: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",

	-- Step 16: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 17: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "{area:1638}(으)로 날아가세요. {npc:3033}이(가) {area:1639}에서 훈련시켜 줍니다. 스카이본: 그 후 비행선을 타러 {zone:1454}(으)로 날아 돌아가세요.",

	-- Step 18: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 19: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, 다음 가이드",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "호수 속 {object:177785}에서 얻는 {item:15877}",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "{area:2362}에서",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, {area:2362}에서",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {zone:1454} Orgrimmar
	["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{area:2361}의 {npc:11798}이(가) 드루이드를 그곳으로 태워 줍니다. 그 후 비행선을 타러 {zone:1454}(으)로 날아가세요",

	-- Step 20: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152}은(는) 비행선 탑에서 길을 따라 북쪽으로 조금 걸어가면 나오는 {area:159}에서 성기사를 훈련시킵니다. 은빛소나무 숲으로 가려면 같은 길로 다시 내려오세요.",

	-- Step 21: Back to Silverpine Forest
	-- {area:130} Silverpine Forest
	["Back to {area:130}"] = "",

	-- Step 22: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",

	-- Step 25: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "길을 따라 남쪽으로 가세요. {object:1627}은(는) 장작나무 마을 북쪽 길가에 있습니다.",

	-- Step 26: The Dead Field
	-- {area:228} The Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "{area:228} 북쪽입니다. {npc:1983}이(가) {area:240}에 출몰합니다. 처치한 뒤 들판을 가로지르세요.",

	-- Step 27: Strange Lockbox
	-- {object:177790} Strange Lockbox · {area:240} The Dead Field · {item:15882} Half Pendant of Aquatic Endurance · {quest:30} Trial of the Sea Lion
	["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790}은(는) {area:240} 서쪽 해안에 있습니다. 그 안에 {quest:30}을(를) 위한 {item:15882}이(가) 들어 있습니다.",

	-- Step 28: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "길을 따라 북동쪽으로 {area:238}의 요릭 가족 집까지 가세요.",

	-- Step 29: Level 16.51
	["Level 16.51"] = "",
	-- {area:239} The Ivar Patch
	["Top up here to level 16.51 before the hand-ins at {area:239}: they take you to level 17."] = "",
	-- {npc:1983} Nightlash
	["grind on {npc:1983}"] = "",

	-- Step 30: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "점박이 검은늑대",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "점박이 검은늑대가 집 주변 언덕을 배회합니다.",

	-- Step 31: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978}은(는) 집 북동쪽에서 기다립니다. 그를 {npc:1950}에게 호위하세요. 가는 길에 늑대가 공격합니다.",
	-- {npc:1978} Deathstalker Erland
	["{npc:1978}, inside"] = "",

	-- Step 34: The Sepulcher
	-- {area:233} Ambermill
	["{area:233} comes later, on the southern loop"] = "{area:233}은(는) 나중에, 남쪽 순환로에서",

	-- Step 35: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:228} The Sepulcher
	["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593}은(는) {area:228} 동쪽 호숫가의 나루터에 있습니다.",

	-- Step 36: The Sepulcher
	-- {npc:1499} Magistrate Sevren · {area:159} Brill
	["{npc:1499} in {area:159}, on the way to the zeppelin at 19"] = "",

	-- Step 37: Quinn Yorick
	["North again to the Yoricks' house."] = "다시 북쪽으로 요릭 가족 집에 가세요.",
	-- {npc:1951} Quinn Yorick
	["{npc:1951}, inside"] = "",

	-- Step 38: Vile Fin murlocs
	["Vile Fin murlocs"] = "썩은지느러미멀록",
	-- {area:172} Fenris Isle
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "호숫가를 따라 남동쪽 {area:172} 방향으로 가세요. 그 길의 썩은지느러미멀록 갈퀴잡이와 썩은지느러미멀록 바다사냥꾼이 멀록 눈알을 떨어뜨립니다.",

	-- Step 39: Fenris Isle
	-- {area:172} Fenris Isle · {area:235} Fenris Keep
	["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "호숫가를 따라 남동쪽으로 가서 {area:172}까지 헤엄쳐 가세요. 썩은가죽 놀이 섬을 뒤덮고 있으며, 모든 종류가 체액을 떨어뜨립니다. 선택 사항인 벽감에 가는 게 아니라면 섬 북쪽의 {area:235}에는 들어가지 마세요. 그곳의 놀은 18-22레벨입니다.",
	-- {item:3317} A Talking Head
	["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: 놀에게서 드물게 떨어짐",
	-- {object:1599} Shallow Grave
	["{object:1599}, just east of the keep"] = "{object:1599}, 성채 바로 동쪽",
	-- {object:112888} Dusty Shelf
	["{object:112888}, inside the keep; upstairs"] = "",
	-- {npc:1940} Rot Hide Plague Weaver
	["grind on {npc:1940}"] = "",

	-- Step 40: Hearth to The Sepulcher
	-- {area:228} The Sepulcher
	["Hearth to {area:228}"] = "",

	-- Step 41: The Sepulcher
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937}: 퀸을 위해, 마지막에 북쪽 길에서",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, 남쪽 순환로에서",

	-- Step 42: Dalaran Pendant on the way
	-- {item:3354} Dalaran Pendant
	["{item:3354} on the way"] = "",
	-- {item:3354} Dalaran Pendant · {area:228} The Sepulcher
	["{item:3354} along the way to the {area:228}"] = "",

	-- Step 43: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "길을 따라 남동쪽으로 {area:233}까지 내려가세요. 수호병이 외곽을, 마법사가 마을을 지키며 둘 다 펜던트를 떨어뜨립니다. 마술사와 파수꾼은 주변 길을 순찰합니다. {npc:2120}이(가) 서 있는 한가운데에는 들어가지 마세요.",
	-- {npc:1914} Dalaran Mage
	["grind on {npc:1914}"] = "",

	-- Step 44: Silverpine Forest: kill these as you meet them
	-- {area:130} Silverpine Forest
	["{area:130}: kill these as you meet them"] = "",
	-- {quest:516} Beren's Peril
	-- plural, as words: Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest.\nCareful: The cave passages are narrow, so it is easy to pull extra mobs. Three mobs guard the entrance, and one of them walks a short patrol away from the other two."] = "",
	["Below ground"] = "",
	-- {npc:1888} Dalaran Watcher
	["grind on {npc:1888}"] = "",

	-- Step 45: the The Sepulcher
	-- {area:228} The Sepulcher
	["the {area:228}"] = "",

	-- Step 46: Lordamere Lake shore
	-- {area:1338} Lordamere Lake
	["{area:1338} shore"] = "{area:1338} 기슭",
	-- {area:237} Decrepit Ferry · {area:228} The Sepulcher
	-- plural, as words: Vile Fin Lakestalkers = {npc:1909} Vile Fin Lakestalker
	["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "썩은지느러미멀록 술사와 점쟁이가 {area:228} 동쪽, {area:237} 남쪽 호숫가에 있습니다.",
	-- {npc:1909} Vile Fin Lakestalker · {area:1338} Lordamere Lake · {area:130} Silverpine Forest
	["grind on {npc:1909} at {area:1338}, {area:130}"] = "",

	-- Step 47: Apothecary Renferrel
	-- {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["Keep it: {npc:2216} in {area:272}, a later guide"] = "보관하세요: {area:272}의 {npc:2216}, 이후 가이드",

	-- Step 48: The Ivar Patch
	-- {area:85} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {area:85}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "",
	["Inside"] = "",

	-- Step 50: Magistrate Sevren
	-- {area:159} Brill · {npc:1499} Magistrate Sevren
	["{area:159} is a short walk north up the road from the zeppelin towers; {npc:1499} is in the town hall."] = "",

	-- Step 53: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}."] = "",

	-- Step 56: Valley of Strength
	-- {object:173016} Borstan's Firepit · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:829} Neeru Fireblade
	["{object:173016} is a few steps north.\nThe {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "",

	-- Step 59: Class trainer
	["Class trainer"] = "",

	-- Step 60: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 61: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "",

	-- Step 62: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348}와(과) {npc:3347}은(는) 골목길의 연금술 상점을 운영합니다. {npc:11046}은(는) 그 옆집에 있습니다.",

	-- Step 63: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "부들과 창풀은 골목길 동쪽, {object:172958}의 물가를 따라 자랍니다.",

	-- Step 65: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {npc:3310} Doras · {object:172982} Valley of Strength
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "",
	-- {area:380} Crossroads
	["Keep it: Thork at the {area:380}"] = "보관하세요: {area:380}의 톨크",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, 호드 지도자 순방",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "{npc:3230}에게 말을 거세요, 그롬마쉬 요새 안",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "{npc:10540}에게 말을 거세요, 그롬마쉬 요새 안",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "",

	-- Step 66: Valley of Wisdom
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, 그롬마쉬 요새 안",

	-- Step 69: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. 제단 구슬은 {area:656} 바닥에 있으며 몇 분 안에 사라집니다. 하나를 들고 곧장 북서쪽 기슭의 {area:2362}까지 헤엄쳐 가서 사용하고 {npc:11799}에게 말을 거세요.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "길을 따라 북쪽으로 은빛소나무 숲을 나가 {zone:1420}에 들어간 뒤, 동쪽으로 {area:153} 밖의 비행선 탑까지 가세요. {zone:1454}행 비행선을 타세요.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "길을 따라 북쪽으로 은빛소나무 숲을 나가 {zone:1420}에 들어간 뒤 {area:159}까지 가세요. 그곳에서 {npc:246152}이(가) 성기사를 훈련시킵니다. 비행선 탑은 길을 따라 남쪽으로 조금 걸어가면 있습니다.",
	-- ["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "{area:380}에서 길을 따라 북동쪽으로 {area:1637}까지 가서 정문으로 들어가세요. 와이번 조련사 {npc:3310}은(는) {object:172982}의 탑 위에 서 있습니다.",
	-- ["Hearth to the {area:228}"] = "{area:228}(으)로 귀환",
	-- ["Into Silverpine"] = "은빛소나무 숲으로",
	-- ["Moonrage Bloodhowlers"] = "달의분노일족 혈투사",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "점박이 검은늑대가 집 주변 언덕을 배회합니다. 그런 다음 호숫가를 따라 남쪽으로 가세요. 그곳의 썩은지느러미멀록 갈퀴잡이와 바다사냥꾼이 멀록 눈알을 떨어뜨립니다.",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "다시 북쪽으로 요릭 가족 집에 가세요. {quest:425}은(는) 그 서쪽으로 조금 걸어간 곳에 숨어 있습니다.",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "{area:228} 북쪽입니다. 나이트래쉬가 {area:240}에 출몰합니다. 처치한 뒤 들판을 가로지르세요.",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "피난민 북동쪽, 숲 남동쪽에 있는 {quest:516} 폐허에 까마귀발톱 노역꾼과 수호병이 출몰합니다.",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "{npc:1938}이(가) {quest:98298}을(를) 준 경우에만: 혈투사는 {area:233} 남서쪽, 장작나무 마을 동쪽 숲을 배회하며 {item:280375}을(를) 떨어뜨립니다.",
	-- ["Road to Silverpine"] = "은빛소나무 숲으로 가는 길",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "앰버밀 남서쪽, 숲 남동부의 {quest:516} 폐허에 까마귀발톱 노역꾼과 수호병이 출몰합니다.",
	-- ["Swim back and follow the road west to the {area:228}."] = "헤엄쳐 돌아와 길을 따라 서쪽으로 {area:228}까지 가세요.",
	-- ["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "{zone:1420} 방향으로 길을 따라 북쪽으로 가세요. {area:238}의 요릭 가족 집이 가는 길에 있습니다. {quest:425}은(는) 그 서쪽으로 조금 걸어간 곳에 숨어 있습니다.",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "병든 피난민과 초췌한 피난민이 장작나무 마을 남쪽 길을 따라 {area:230} 쪽으로 비틀거리며 걸어갑니다.",
	-- ["The refugees"] = "피난민",
	-- ["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "비행선은 {area:153} 밖의 탑에 내립니다. 길을 따라 서쪽으로 폐허를 지나 남쪽으로 {zone:1421}에 들어간 뒤, 길을 따라 {area:228}까지 가세요.",
	-- ["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "비행선 탑은 {zone:1454} 정문 바로 밖에 있습니다. {zone:1420}행 비행선을 타세요(다른 하나는 {object:3202}(으)로 갑니다).",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{object:172960}은(는) {object:172982} 아래의 협곡입니다. {npc:3216}은(는) 그 맨 끝에 서 있습니다.",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790}은(는) {area:240} 서쪽 해안에 있습니다. 그 안에 {quest:30}을(를) 위한 {item:15882}이(가) 들어 있습니다.",
	-- ["To {area:1637}"] = "{area:1637}(으)로",
	-- ["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "정문으로 들어가세요. {npc:268701}은(는) {object:172982}에 서 있고, {object:173016}은(는) 몇 걸음 북쪽에 있습니다.",
	-- ["Worgs and murlocs"] = "늑대와 멀록",
	-- ["Zeppelin to {zone:1420}"] = "{zone:1420}행 비행선",
	-- ["Zeppelin tower"] = "비행선 탑",
	-- ["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "{zone:1421}의 {area:1338}에서 {npc:1909}을(를) 사냥하세요",
	-- ["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228}은(는) 숲 한가운데에 있는 포세이큰의 지하묘지 마을입니다. 필요한 사람은 모두 지하묘지 입구 주변에 서 있습니다. 박쥐 조련사 {npc:2226}은(는) 그 바로 동쪽에 있습니다.",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: 제안하면 받으세요. 경로에서 진행하지 않는 그의 {quest:98298} 연계 퀘스트 다음에 나올 수 있습니다",
	-- ["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684}와(과) {npc:268682}은(는) {object:172957}의 그롬마쉬 요새 뒤에 앉아 있고, 매끈한 바위가 그 주변에 놓여 있습니다. 도시에 있는 동안 훈련을 받으세요(드루이드와 성기사는 이곳에 상급자가 없습니다). 다음 가이드는 {object:172982}의 와이번 조련사 {npc:3310}에게서 시작합니다.",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018}은(는) 도시 서쪽의 {object:172961}에 서 있습니다.",
	-- ["{object:112888}, inside the keep"] = "{object:112888}, 성채 안",
	-- ["{zone:1454} class quests"] = "{zone:1454} 직업 퀘스트",
}
