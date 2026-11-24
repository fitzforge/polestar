-- Korean (koKR): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1470} Ghak Healtouch · {area:144} Thelsamar · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:1470} is below ground in {area:144}, by the inn, where the flight lands. His mushrooms grow in the {area:1517} dig at the {zone:1418}' northern edge, on this guide's loop back north."] = "{npc:1470}은(는) 비행 경로가 도착하는 {area:144}의 여관 옆 지하에 있습니다. 그의 버섯은 {zone:1418} 북쪽 끝의 {area:1517} 발굴지에서 자라며, 이 가이드에서 북쪽으로 돌아오는 길에 들르게 됩니다.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, 지하",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "남쪽 고개를 지나 {zone:1432}에서 {zone:1418}(으)로 가십시오. {npc:2860}은(는) 발굴 현장에 야영하고 있습니다.",
	-- {quest:706} Fiery Blaze Enchantments · {item:4612} Black Drake's Heart
	["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}: {item:4612}은(는) 드물게 떨어지므로, 작업과 제출도 선택 사항입니다",

	-- Step 4: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888}은(는) 발굴 현장 남동쪽 {area:1898}에 홀로 야영하고 있습니다.",

	-- Step 5: Agmond's End
	-- {npc:269577} Dorgaron · {item:278404} Pristine Mattock · {quest:739} Murdaloc
	["{npc:269577}'s {item:278404} lies in the middle of the Stonevault trogg camp, where {quest:739} walks."] = "{npc:269577}의 {item:278404}은(는) {quest:739}이(가) 돌아다니는 돌무덤 트로그 야영지 한가운데에 있습니다.",

	-- Step 6: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "{npc:2817}: 가시덤불 골짜기의 푸른 진주",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "{npc:2817}의 다음 퀘스트는 경험치를 주지 않으니 건너뛰십시오.",

	-- Step 7: Boss Tho'grun
	-- {npc:2944} Boss Tho'grun · {area:342} Camp Boff · {zone:1418} Badlands
	["{npc:2944} does not stay at {area:342}: he walks a long loop around the {zone:1418} with his guards, from the camp in the west along the south of the zone to about 61,69, north to about 49,49 and back west to the camp. The arrow follows his loop west from here until you meet him."] = "{npc:2944}은(는) {area:342}에 머물러 있지 않습니다. 호위병들과 함께 {zone:1418}을(를) 크게 돌며, 서쪽 야영지에서 지역 남쪽을 따라 약 61,69까지, 북쪽으로 약 49,49까지 간 뒤 다시 서쪽 야영지로 돌아옵니다. 화살표는 그를 만날 때까지 여기서부터 서쪽으로 그의 경로를 따라갑니다.",

	-- Step 8: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "동쪽 {area:1898}(으)로 돌아가십시오.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "{npc:2888}의 다음 임무는 정예 사냥이니 건너뛰십시오.",

	-- Step 9: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "화염의 새끼비룡은 {npc:2888} 동쪽 협곡에 둥지를 틀고 있습니다. 화염의 수호비룡(정예)은 건드리지 마십시오. {item:4612}은(는) 드물게 떨어지니 사냥 중에 나오면 챙기십시오.",

	-- Step 11: Dorgaron
	-- {npc:269577} Dorgaron · {zone:1432} Loch Modan
	["{npc:269577} camps at the foot of the pass into {zone:1432}, on the way north."] = "{npc:269577}은(는) 북쪽으로 가는 길, {zone:1432}(으)로 이어지는 고갯길 기슭에 야영하고 있습니다.",

	-- Step 12: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "{zone:1432}(으)로",

	-- Step 13: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "",

	-- Step 14: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "{zone:1418}(으)로",

	-- Step 15: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "{area:1517} 발굴지",

	-- Step 16: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "",

	-- Step 17: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "",

	-- Step 18: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "북쪽 아이언밴드의 발굴현장으로 돌아가십시오.",

	-- Step 19: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144} 비행 조련사",

	-- Step 21: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "{npc:3980}, 위층",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "랄레이의 다음 심부름은 {area:796}에 있으니 건너뛰십시오.",

	-- Step 22: Loremaster Dibbs
	-- {npc:2277} Loremaster Dibbs · {area:271} Southshore
	["{npc:2277} stands in {area:271}, by the inn."] = "{npc:2277}은(는) {area:271}의 여관 옆에 있습니다.",

	-- Step 24: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "길을 따라 북동쪽으로 {area:271}을(를) 빠져나가 {zone:1425}로 가십시오. {area:348}은(는) 경계 바로 너머에 있습니다. {npc:5635}은(는) 꼭대기에, {quest:1450}은(는) 그리핀 둥지에, {npc:7884}은(는) 여관 옆에 있습니다.",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "{quest:1450}, 내부",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}, 내부",

	-- Step 25: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634}은(는) {area:348} 동쪽 길가에 야영하고 있습니다.",

	-- Step 26: Witherbark villages
	["Witherbark villages"] = "마른나무껍질 마을",
	-- {npc:5634} Rhapsody Shindigger · {npc:270772} Witch Doctor Ti'ik
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace.\nCareful: {npc:270772} (49) and his Hexed Larvae (45) keep to the huts of the western village, around 25,64: take the necklaces from the trolls outside."] = "처음 두 우리는 {npc:5634} 남쪽 마른나무껍질 마을에 함께 있고, 세 번째는 동쪽의 다음 마을에 있습니다. 모든 마른나무껍질 트롤이 목걸이를 떨어뜨릴 수 있습니다.\n주의: {npc:270772}(49)와(과) 그의 저주받은 애벌레(45)는 서쪽 마을의 오두막, 약 25,64 근처에 머뭅니다. 목걸이는 바깥의 트롤에게서 얻으세요.",

	-- Step 27: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "{npc:5636}, 꼭대기의 비행 조련사 옆, 안",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "탈론액스의 다음 임무는 이후 {zone:1425} 가이드에서 합니다.",

	-- Step 28: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "{area:150}(으)로 비행",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348} 비행 조련사",

	-- Step 30: Theramore
	["Theramore"] = "테라모어 섬",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "",

	-- Step 31: Morgan Stern
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, 내부",

	-- Step 32: Mudsprocket
	["Mudsprocket"] = "진흙톱니",
	-- {area:511} Wyrmbog · {npc:270723} Drazzit Dripvalve · {npc:270727} Gizzix Grimegurgle
	["Take the road south-west out of Theramore to Mudsprocket, the goblin camp at the edge of the {area:511}. {npc:270723} and {npc:270727} stand together in the camp."] = "테라모어에서 남서쪽 길을 따라 {area:511} 가장자리의 고블린 야영지인 진흙톱니로 가십시오. {npc:270723}와(과) {npc:270727}은(는) 야영지에 함께 있습니다.",

	-- Step 33: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {item:280092} Wyrmtail
	-- plural, as words: Searing Hatchlings = {npc:4323} Searing Hatchling · Firemane Scalebanes = {npc:4328} Firemane Scalebane
	["The {item:280092} grows in the bog east of the camp: gather it first. Then the Searing Hatchlings and Whelps (41-43) and the Firemane dragonkin nest in the bog north and west of Mudsprocket, on the way back; all of them drop the shed scales.\nCareful: the Firemane Scalebanes and Flamecallers are 43-44 and cast fire: pull them one at a time."] = "{item:280092}은(는) 야영지 동쪽 늪에서 자랍니다: 먼저 채집하십시오. 그런 다음 돌아오는 길에 진흙톱니 북쪽과 서쪽 늪에 둥지를 튼 갓 부화한 화염 새끼용과 새끼용(41-43), 화염갈기혈족 용족을 처치하십시오. 모두 허물 비늘을 떨어뜨립니다.\n주의: 화염갈기혈족 맹독전사와 화염술사는 43-44레벨이며 화염 주문을 씁니다: 하나씩 끌어오십시오.",

	-- Step 34: Mudsprocket
	["Then ride back north-east to Theramore's flight master."] = "그런 다음 북동쪽으로 돌아가 테라모어의 비행 조련사에게 가십시오.",

	-- Step 35: Theramore flight master
	["Theramore flight master"] = "테라모어 섬 비행 조련사",

	-- Step 37: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "흑마법사: {quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "{area:392}(으)로 비행하십시오. {npc:6251}은(는) 은행 옆 집에서 가르칩니다. 이후 테라모어 섬으로 돌아오십시오.",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "{area:608}(으)로 비행한 뒤 남쪽으로 {zone:1443}을(를) 지나 {zone:1444}(으)로 가서 {area:1108}의 부두까지 길을 따라가십시오. 배가 {area:1116}(으)로 건너가며, 그곳에서 다음 가이드가 시작합니다.",
	-- ["On to Feathermoon"] = "페더문 요새로",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "북쪽 {area:144}(으)로 가서 {area:271}(으)로 비행하십시오. {npc:3980}은(는) 여관 옆에서 설교합니다.",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "길을 따라 북동쪽으로 {area:271}을(를) 빠져나가 {area:47}로 가십시오. {area:348}은(는) 경계 바로 너머에 있습니다. {npc:5635}은(는) 꼭대기에, {quest:1450}은(는) 그리핀 둥지에, {npc:7884}은(는) 여관 옆에 있습니다.",
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "길을 따라 북동쪽으로 {area:271}을(를) 빠져나가 {zone:1425}(으)로 가십시오. {area:348}은(는) 경계 바로 너머에 있습니다. 폴스타트 와일드해머는 꼭대기에, {quest:1450}은(는) 그리핀 둥지에, {npc:7884}은(는) 여관 옆에 있습니다.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "남쪽 고개를 지나 {zone:1432}에서 {zone:1418}(으)로 가십시오. {npc:2860}은(는) 발굴 현장에 야영하고 있습니다.",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "{area:3}을(를) 가로질러 서쪽 {area:342}의 먼지목도리 야영지로 가십시오. {npc:2944}은(는) 그 한가운데에 있으며 주위에 먼지목도리일족 고룡사냥꾼과 먼지목도리일족 싸움꾼이 있습니다.",
	-- ["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "{zone:1418}을(를) 가로질러 서쪽 {area:342}의 먼지목도리 야영지로 가십시오. {npc:2944}은(는) 그 한가운데에 있으며 주위에 먼지목도리일족 고룡사냥꾼과 먼지목도리일족 싸움꾼이 있습니다.",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "서쪽 {zone:1418} 한가운데의 {area:1877}(으)로 가십시오. {npc:2817}은(는) 망명자 마르텍 옆에 야영하고 있습니다.",
	-- ["Take the boat to Theramore from the far pier."] = "가장 먼 부두에서 테라모어 섬행 배를 타십시오.",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "탈론액스의 다음 임무는 이후 {area:47} 가이드에서 합니다.",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "부서진 해골은 바위동굴일족 트로그 야영지 가장자리에 있습니다. 아그몬드를 죽인 {quest:739}은(는) 바위동굴일족 뼈다귀싸움꾼들 사이를 걷습니다.",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "{zone:1418} {area:339}에서 {npc:2725} 사냥",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",
	-- ["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616}은(는) 배가 도착하는 부두에 있습니다.",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888}은(는) 발굴 현장 남동쪽 {area:1898}에 홀로 야영하고 있습니다.",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "{npc:5634}의 칵테일에는 칼림도어의 재료가 필요하니 건너뛰십시오.",
	-- ["{npc:7744}; below ground"] = "{npc:7744}, 지하",
	-- ["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884}은(는) 목걸이를 계속 받습니다. 남는 것은 제출하십시오",
}
