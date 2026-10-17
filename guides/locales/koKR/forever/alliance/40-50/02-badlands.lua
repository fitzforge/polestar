-- Korean (koKR): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",

	-- Step 2: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "남쪽 고개를 지나 {zone:1432}에서 {zone:1418}(으)로 가십시오. {npc:2860}은(는) 발굴 현장에 야영하고 있습니다.",

	-- Step 3: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888}은(는) 발굴 현장 남동쪽 {area:1898}에 홀로 야영하고 있습니다.",

	-- Step 4: Agmond's End
	-- {quest:739} Murdaloc
	["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "부서진 해골은 바위동굴일족 트로그 야영지 가장자리에 있습니다. 아그몬드를 죽인 {quest:739}은(는) 바위동굴일족 뼈다귀싸움꾼들 사이를 걷습니다.",

	-- Step 5: Rigglefuzz
	-- {area:1877} Valley of Fangs · {zone:1418} Badlands · {npc:2817} Rigglefuzz
	["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "서쪽 {zone:1418} 한가운데의 {area:1877}(으)로 가십시오. {npc:2817}은(는) 망명자 마르텍 옆에 야영하고 있습니다.",
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["Blue Pearls from Stranglethorn"] = "가시덤불 골짜기의 푸른 진주",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "{npc:2817}의 다음 퀘스트는 경험치를 주지 않으니 건너뛰십시오.",

	-- Step 6: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "{zone:1418}을(를) 가로질러 서쪽 {area:342}의 먼지목도리 야영지로 가십시오. {npc:2944}은(는) 그 한가운데에 있으며 주위에 먼지목도리일족 고룡사냥꾼과 먼지목도리일족 싸움꾼이 있습니다.",

	-- Step 7: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "동쪽 {area:1898}(으)로 돌아가십시오.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "{npc:2888}의 다음 임무는 정예 사냥이니 건너뛰십시오.",

	-- Step 8: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "화염의 새끼비룡은 {npc:2888} 동쪽 협곡에 둥지를 틀고 있습니다. 화염의 수호비룡(정예)은 건드리지 마십시오. {item:4612}은(는) 드물게 떨어지니 사냥 중에 나오면 챙기십시오.",
	-- {npc:2725} Scalding Whelp · {area:339} Lethlor Ravine · {zone:1418} Badlands
	["grind on {npc:2725} at {area:339}, {zone:1418}"] = "{zone:1418} {area:339}에서 {npc:2725} 사냥",

	-- Step 10: Southshore
	-- {area:144} Thelsamar · {area:271} Southshore · {npc:3980} Raleigh the Devout
	["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "북쪽 {area:144}(으)로 가서 {area:271}(으)로 비행하십시오. {npc:3980}은(는) 여관 옆에서 설교합니다.",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "랄레이의 다음 심부름은 {area:796}에 있으니 건너뛰십시오.",

	-- Step 11: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "길을 따라 북동쪽으로 {area:271}을(를) 빠져나가 {zone:1425}로 가십시오. {area:348}은(는) 경계 바로 너머에 있습니다. {npc:5635}은(는) 꼭대기에, {quest:1450}은(는) 그리핀 둥지에, {npc:7884}은(는) 여관 옆에 있습니다.",

	-- Step 12: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634}은(는) {area:348} 동쪽 길가에 야영하고 있습니다.",
	-- {npc:5634} Rhapsody Shindigger
	["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "{npc:5634}의 칵테일에는 칼림도어의 재료가 필요하니 건너뛰십시오.",

	-- Step 13: Witherbark villages
	["Witherbark villages"] = "마른나무껍질 마을",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "처음 두 우리는 {npc:5634} 남쪽 마른나무껍질 마을에 함께 있고, 세 번째는 동쪽의 다음 마을에 있습니다. 모든 마른나무껍질 트롤이 목걸이를 떨어뜨릴 수 있습니다.",

	-- Step 14: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884}은(는) 목걸이를 계속 받습니다. 남는 것은 제출하십시오",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, 꼭대기의 비행 조련사 옆",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "탈론액스의 다음 임무는 이후 {zone:1425} 가이드에서 합니다.",

	-- Step 15: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "가장 먼 부두에서 테라모어 섬행 배를 타십시오.",

	-- Step 16: Theramore
	["Theramore"] = "테라모어 섬",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616}은(는) 배가 도착하는 부두에 있습니다.",

	-- Step 17: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "흑마법사: {quest:3631}",
	-- {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "{area:392}(으)로 비행하십시오. {npc:6251}은(는) 은행 옆 집에서 가르칩니다. 이후 테라모어 섬으로 돌아오십시오.",

	-- Step 18: On to Feathermoon
	["On to Feathermoon"] = "페더문 요새로",
	-- {area:608} Nijel's Point · {zone:1443} Desolace · {zone:1444} Feralas · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "{area:608}(으)로 비행한 뒤 남쪽으로 {zone:1443}을(를) 지나 {zone:1444}(으)로 가서 {area:1108}의 부두까지 길을 따라가십시오. 배가 {area:1116}(으)로 건너가며, 그곳에서 다음 가이드가 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "길을 따라 북동쪽으로 {area:271}을(를) 빠져나가 {zone:1425}(으)로 가십시오. {area:348}은(는) 경계 바로 너머에 있습니다. 폴스타트 와일드해머는 꼭대기에, {quest:1450}은(는) 그리핀 둥지에, {npc:7884}은(는) 여관 옆에 있습니다.",
	-- ["Talonaxe's next task waits for a later {zone:1425} guide."] = "탈론액스의 다음 임무는 이후 {zone:1425} 가이드에서 합니다.",
}
