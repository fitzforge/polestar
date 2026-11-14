-- Korean (koKR): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Mirage Raceway
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {npc:4454} Fizzle Brassbolts
	["The {area:2240} lies on the {area:439} in south-east {zone:1441}: {npc:4454} is in the gnomes' camp beside the track, Zamek by the goblin camp."] = "{area:2240}은(는) {zone:1441} 남동쪽의 {area:439}에 있습니다. {npc:4454}은(는) 경주로 옆 노움 야영지에, 자멕은 고블린 야영지 옆에 있습니다.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "{area:439}에서 남동쪽 {zone:1446}(으)로 가십시오. {area:976}은(는) 경계 바로 안쪽에 있습니다.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, 마을 북쪽",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, 급수탑 옆",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, 그의 옆",
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: 그의 상자는 나중에 {area:702}(으)로 갑니다",

	-- Step 5: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7407} Chief Engineer Bilgewhizzle · {quest:2768} Divino-matic Rod
	["For your {area:978} run, later in this guide: {quest:2864} wants scarab shells, {npc:7407}, by the water tower, his {quest:2768} back, and Trenton Lighthammer Troll Temper from the Sandfury trolls."] = "{area:978} 공략용(이 가이드 후반): {quest:2864}은(는) 풍뎅이 껍질을, 급수탑 옆의 {npc:7407}은(는) 자신의 {quest:2768}을(를), 트렌턴 라이트해머는 성난모래부족 트롤의 Troll Temper를 원합니다.",

	-- Step 6: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "모래언덕을 건너 동쪽, 북동쪽 해안의 고블린 항구(스팀휘들 항구)로 가십시오.",
	["The Wanted poster beside him"] = "그 옆의 현상수배 포스터",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "같은 현상수배 전단: {npc:7847}은(는) 훨씬 나중, {area:976} 이후에 나옵니다",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern; inside"] = "{npc:7881}, 항구의 선술집, 안",

	-- Step 7: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "서쪽 {area:976} 쪽으로 돌아가십시오. 가는 길의 모래언덕에는 사막유랑단 약탈자와 사막유랑단 좀도둑이 있고, 누구든 사막유랑단 물주머니를 지니고 있을 수 있습니다.\n주의: 사막유랑단 도적(43-44레벨)은 은신한 채 움직이므로 보이지 않게 다가올 수 있습니다.",

	-- Step 9: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp."] = "더 강한 사막유랑단 도적, 사막유랑단 어둠마법사, 사막유랑단 암살자는 {area:976} 남동쪽, 약탈자들 남쪽에 진을 치고 있습니다. 남쪽 야영지 한가운데의 {npc:7847}은(는) 나중으로 미루십시오.\n주의: 사막유랑단 도적은 전투 밖에서 은신을 유지하므로, 야영지에서 시작한 싸움에 숨어 있던 도적이 합류할 수 있습니다.",

	-- Step 10: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "해안을 따라 남쪽 해적단 소굴로 가십시오. 남쪽바다해적단이 해변과 배에 우글거립니다: 가장자리부터 하나씩 끌어내십시오. {npc:7883}은(는) 반대편에 서 있고, {npc:7881}의 도둑맞은 화물은 야영지에 있습니다.\n주의: {npc:7883} 곁에는 해적 두세 명이 서 있고, 싸움이 시작되면 마을의 해적이 훨씬 더 많이 합류합니다.",
	-- {quest:2873} Stoley's Shipment
	["{quest:2873}; upstairs"] = "",

	-- Step 11: Steamwheedle Port
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",
	-- {area:35} Booty Bay · {zone:1425} Hinterlands
	["\"Sea Wolf\" MacKinley in {area:35}: the route takes you there at the end of the {zone:1425} guide, keep it"] = "",

	-- Step 12: Noonshade Ruins
	["Careful: Thieves cast Disarm. Rogues stay hidden with Sneak. Assassins use Execute when your health is at 20% or lower."] = "",

	-- Step 14: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "{area:979} 옆 웅덩이",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "북서쪽 {area:979}의 성난모래부족 트롤 야영지로 가십시오. 웅덩이 가장자리에서 {item:8584}을(를) 사용하십시오. 트롤들이 가까이 있으니 가장 가까운 것부터 끌어내십시오.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "{item:8585}을(를) 줍니다",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "{area:979} 옆 웅덩이",

	-- Step 15: Zul'Farrak
	-- {area:978} Zul'Farrak · {quest:3042} Troll Temper · {npc:7604} Sergeant Bly · {quest:2768} Divino-matic Rod
	["{area:978} is a dungeon for a group of five; its quests here are level 45 to 47. Its gate lies about 400 yards north of the pool.\nInside: the Scarabs drop the shells, every Sandfury troll can drop {quest:3042}, and {npc:7604} carries the {quest:2768}."] = "{area:978}은(는) 5인 파티용 던전이며, 이곳의 퀘스트는 45~47레벨입니다. 입구는 웅덩이에서 북쪽으로 약 400야드 떨어져 있습니다.\n내부: 풍뎅이가 껍질을 떨어뜨리고, 모든 성난모래부족 트롤이 {quest:3042}을(를) 떨어뜨릴 수 있으며, {npc:7604}이(가) {quest:2768}을(를) 가지고 있습니다.",
	-- {quest:2865} Scarab Shells
	["{quest:2865}: the Scarabs, inside"] = "{quest:2865}: 풍뎅이, 내부",
	-- {quest:3042} Troll Temper
	["{quest:3042}: the Sandfury trolls, inside"] = "{quest:3042}: 성난모래부족 트롤, 내부",
	-- {quest:2768} Divino-matic Rod · {npc:7604} Sergeant Bly
	["{quest:2768}: {npc:7604}, inside"] = "{quest:2768}: {npc:7604}, 내부",

	-- Step 17: Tran'rek
	-- {area:978} Zul'Farrak · {npc:7876} Tran'rek
	["Your {area:978} scarab shells: {npc:7876}, on the north side of town."] = "{area:978}의 풍뎅이 껍질: 마을 북쪽의 {npc:7876}.",

	-- Step 18: Chief Engineer Bilgewhizzle
	-- {quest:2768} Divino-matic Rod · {npc:7407} Chief Engineer Bilgewhizzle
	["The {quest:2768}: {npc:7407}, by the water tower."] = "{quest:2768}: 급수탑 옆의 {npc:7407}.",

	-- Step 19: Trenton Lighthammer
	-- {quest:3042} Troll Temper · {npc:7804} Trenton Lighthammer
	["The {quest:3042}: {npc:7804}, in town."] = "{quest:3042}: 마을 안의 {npc:7804}.",

	-- Step 20: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "남쪽 {area:1938}의 발굴 야영지로 가십시오. {npc:7771}이(가) 탐지 투구를 줍니다: 착용하면 {quest:3161} 흙더미가 보이며, 야영지 주변과 남서쪽 오우거 쪽 모래에 많이 있습니다.",

	-- Step 22: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "",

	-- Step 23: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager · {quest:3362} Thistleshrub Valley
	-- plural, as words: Dunemaul Ogres = {npc:5471} Dunemaul Ogre
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first.\nWhy the grind to 47: the {quest:3362} comes next, with mobs of 48-50 and quests of level 50. Grind it on the Dunemaul Ogres (45-46) at the compound's south end, the safer camp, not on the Brutes."] = "남서쪽 모래망치 주둔지로 가십시오. 모래망치일족 투사와 모래망치일족 집행자(46-48)가 가득하고, {npc:12046}(49)은(는) 경비병에 둘러싸여 한가운데에 서 있습니다: 경비병부터 처치하십시오.\n47레벨까지 사냥하는 이유: 다음은 48-50레벨 몹과 50레벨 퀘스트가 있는 {quest:3362}입니다. 투사가 아니라, 더 안전한 주둔지 남쪽 끝의 모래망치일족 오우거(45-46)를 사냥하십시오.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "",
	-- {npc:5471} Dunemaul Ogre
	["grind on {npc:5471}, at the compound's south end"] = "주둔지 남쪽 끝에서 {npc:5471} 사냥",

	-- Step 24: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "남쪽 {quest:3362}(으)로 가십시오. 이슬먹는 덤불나무괴물이 이슬샘을 떨어뜨리는데 일부만 가득 차 있으니 가득 찬 이슬샘을 챙기십시오. 옹이진 덤불나무괴물과 억센뿌리 덤불나무괴물도 골짜기에 있습니다. 덤불나무괴물은 48-50레벨로 당신보다 높으니 하나씩 끌어내십시오.\n주의: 이 지역의 다른 덤불나무괴물은 49-50레벨이며 많이 돌아다니므로 몹을 더 끌어오기 쉽습니다.",

	-- Step 25: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "{npc:5955} 호위",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "작은 거북 {npc:5955}은(는) 골짜기 북쪽 끝에 숨어 있습니다. {area:977} 바로 동쪽 물가에 있는 아내 {npc:6015}에게 데려다주십시오: 느리게 걷고 사막의 야수들이 노리니 살려 두십시오.",

	-- Step 26: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back west to {area:976}: {npc:11758} stands on the east side of town, where you come in."] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 27: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 28: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "남쪽으로 {area:1938}을(를) 지나 하잘리 굴인 {area:981}으로 가십시오. 슈섕크의 측량 장비는 깊숙한 곳에 있습니다.\n주의: 벌레 하나가 장비를 지킵니다. 많은 벌레가 굴을 순찰하며 일부는 50레벨이라, 싸우면 몹이 추가로 끌려오는 경우가 많습니다.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "",

	-- Step 29: Gadgetzan
	-- {zone:1457} Darnassus
	["for {zone:1457}, next"] = "다음에 {zone:1457}(으)로",

	-- Step 30: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "{area:442}(으)로 비행",
	-- {zone:1457} Darnassus · {npc:7763} Curgle Cranklehop · {area:442} Auberdine · {area:150} Menethil Harbor · {area:348} Aerie Peak
	["{zone:1457} first, while you are on this side of the sea: Troyas' answer, {npc:7763}'s crate, Tyrande and the soil errand, then the boat from {area:442} to {area:150} and the gryphon to {area:348}."] = "바다 이쪽에 있는 동안 {zone:1457}부터 들르십시오: 트로야스의 답신, {npc:7763}의 상자, 티란데와 흙 심부름. 그런 다음 {area:442}에서 배를 타고 {area:150}(으)로 가서 그리폰을 타고 {area:348}(으)로 가십시오.",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976} 비행 조련사",

	-- Step 31: Teldrassil
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:3838} Vesprystus
	["Take the boat from {area:442}'s dock to {area:702}; {npc:3838}, the hippogryph master, stands on the rise just east of the landing: learn the flight path on the way up to the village."] = "{area:442} 부두에서 배를 타고 {area:702}(으)로 가십시오. 히포그리프 조련사 {npc:3838}은(는) 선착장 바로 동쪽 언덕에 서 있습니다. 마을로 올라가는 길에 비행 경로를 익히십시오.",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702} 비행 조련사",

	-- Step 32: Rut'theran Village
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}은(는) {npc:7916} 위층에 서 있습니다. 건물 안에서 올라가십시오. 화살표는 층을 구분하지 못합니다.",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}의 다음 심부름은 {zone:1446}(으)로 이어집니다. 건너뛰십시오.",
	-- {npc:7916} Erelas Ambersky · {zone:1425} Hinterlands
	["{npc:7916}: the feathers lie in the {zone:1425}, next"] = "{npc:7916}: 깃털은 다음 {zone:1425}에 있습니다",
	["the book on her table"] = "그녀의 탁자 위에 있는 책",

	-- Step 34: Temple of the Moon
	["Temple of the Moon"] = "달의 신전",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "차원문을 지나 {zone:1457}(으)로 가십시오. 달의 신전은 도시 남쪽에 있습니다.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, 그녀의 옆",

	-- Step 38: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, 나무 꼭대기",

	-- Step 39: Class trainer
	["Class trainer"] = "직업 상급자",

	-- Step 40: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "흙은 나중에 {zone:1449}에서 얻습니다",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "{zone:1438}행 차원문",

	-- Step 43: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",

	-- Step 44: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 45: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 비행",

	-- Step 46: Hinterlands
	-- {area:348} Aerie Peak · {area:271} Southshore · {zone:1425} Hinterlands
	["No flight path to {area:348} yet: ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border."] = "아직 {area:348} 비행 경로가 없다면: {area:271}에서 북동쪽 길을 따라 {zone:1425}(으)로 가십시오. {area:348}은(는) 경계 바로 너머에 있습니다.",

	-- Step 47: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master"] = "",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "",

	-- Step 50: Sprinkle's Secret Ingredient
	["Underwater"] = "물속",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "{area:976}에서 테라모어 섬으로 날아가, 배를 타고 {area:150}(으)로 간 다음 {area:1537}(으)로 날아가십시오. 기술을 배우십시오.",
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "{area:348}(으)로 날아가십시오. {zone:1425} 가이드는 여기서 시작합니다.",
	-- ["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "{area:1108} 부두에서 배를 타고 페더문 요새로 가서 {area:489}(으)로 날아간 다음, {zone:1441}을(를) 지나 동쪽 {area:439}의 {area:2240}까지 가십시오. {npc:4454}와(과) {npc:4630}은(는) 경주로 옆 야영지에 있고, {npc:4709}은(는) 고블린 야영지 옆에 서 있습니다.",
	-- ["He runs off to keep Rizzle busy"] = "그는 리즐 브라스볼츠의 주의를 끌러 달려갑니다",
	-- ["Hearth to {area:976}."] = "귀환석으로 {area:976}에 가십시오.",
	-- ["Ride back west to {area:976}."] = "서쪽 {area:976}(으)로 돌아가십시오.",
	-- ["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "북서쪽 모래언덕의 센티파르 둥지(맹독의 둥지)로 가십시오. 어느 센티파르든 센티파르 곤충 기관을 떨어뜨릴 수 있습니다.",
	-- ["Ride south-east off the {area:439} into {area:440}. {area:976} is just inside the border."] = "{area:439}에서 남동쪽 {area:440}(으)로 가십시오. {area:976}은(는) 경계 바로 안쪽에 있습니다.",
	-- ["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "남동쪽 {area:985}(으)로 가십시오. {npc:7847}은(는) 남쪽 사막유랑단 야영지 한가운데에 서 있습니다: 주변부터 정리하십시오.",
	-- ["Rizzle's plans"] = "아무도 지키지 않는 리즐의 설계도",
	-- ["The Wanted poster by {npc:7882}"] = "{npc:7882} 옆의 현상수배 포스터",
	-- ["Wastewander bandits"] = "사막유랑단 약탈자",
	-- ["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "{npc:4709}이(가) 리즐 브라스볼츠와 이야기하는 동안, 경주로 건너편 노움 야영지의 설계도는 무방비 상태입니다.",
	-- ["for {zone:1457}: the route takes you there at 47"] = "{zone:1457}용: 경로상 47레벨에 그곳에 갑니다",
	-- ["{npc:11758}, on the east side of town"] = "{npc:11758}, 마을 동쪽",
	-- ["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "{npc:7583}의 다음 재료는 {zone:1425}에서 자라고, 경로상 다시 가져오지 않습니다: 건너뛰십시오.",
	-- ["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "{npc:7881}의 다음 배달은 {area:35}(으)로 돌아갑니다: 건너뛰십시오.",
}
