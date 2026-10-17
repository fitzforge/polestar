-- Korean (koKR): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mirage Raceway
	-- {area:1108} Forgotten Coast · {area:489} Thalanaar · {zone:1441} Thousand Needles · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "{area:1108} 부두에서 배를 타고 페더문 요새로 가서 {area:489}(으)로 날아간 다음, {zone:1441}을(를) 지나 동쪽 {area:439}의 {area:2240}까지 가십시오. {npc:4454}와(과) {npc:4630}은(는) 경주로 옆 야영지에 있고, {npc:4709}은(는) 고블린 야영지 옆에 서 있습니다.",
	["He runs off to keep Rizzle busy"] = "그는 리즐 브라스볼츠의 주의를 끌러 달려갑니다",

	-- Step 2: Rizzle's plans
	["Rizzle's plans"] = "아무도 지키지 않는 리즐의 설계도",
	-- {npc:4709} Zamek
	["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "{npc:4709}이(가) 리즐 브라스볼츠와 이야기하는 동안, 경주로 건너편 노움 야영지의 설계도는 무방비 상태입니다.",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "{area:439}에서 남동쪽 {zone:1446}(으)로 가십시오. {area:976}은(는) 경계 바로 안쪽에 있습니다.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, 마을 북쪽",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, 급수탑 옆",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, 그의 옆",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "모래언덕을 건너 동쪽, 북동쪽 해안의 고블린 항구(스팀휘들 항구)로 가십시오.",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern"] = "{npc:7881}, 항구의 선술집 안",
	["The Wanted poster beside him"] = "그 옆의 현상수배 포스터",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "같은 현상수배 전단: {npc:7847}은(는) 훨씬 나중, {area:976} 이후에 나옵니다",

	-- Step 6: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "해안을 따라 남쪽 해적단 소굴로 가십시오. 남쪽바다해적단이 해변과 배에 우글거립니다: 가장자리부터 하나씩 끌어내십시오. {npc:7883}은(는) 반대편에 서 있고, {npc:7881}의 도둑맞은 화물은 야영지에 있습니다.",

	-- Step 7: Steamwheedle Port
	-- {npc:7881} Stoley · {area:35} Booty Bay
	["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "{npc:7881}의 다음 배달은 {area:35}(으)로 돌아갑니다: 건너뛰십시오.",

	-- Step 8: Wastewander bandits
	["Wastewander bandits"] = "사막유랑단 약탈자",
	-- {area:976} Gadgetzan
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "서쪽 {area:976} 쪽으로 돌아가십시오. 가는 길의 모래언덕에는 사막유랑단 약탈자와 사막유랑단 좀도둑이 있고, 누구든 사막유랑단 물주머니를 지니고 있을 수 있습니다.",

	-- Step 10: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "더 강한 사막유랑단 도적, 사막유랑단 어둠마법사, 사막유랑단 암살자는 {area:976} 남동쪽, 약탈자들 남쪽에 진을 치고 있습니다. 남쪽 야영지 한가운데의 {npc:7847}은(는) 나중으로 미루십시오.",

	-- Step 11: Gadgetzan
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: 그의 상자는 나중에 {area:702}(으)로 갑니다",

	-- Step 12: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "{area:979} 옆 웅덩이",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "북서쪽 {area:979}의 성난모래부족 트롤 야영지로 가십시오. 웅덩이 가장자리에서 {item:8584}을(를) 사용하십시오. 트롤들이 가까이 있으니 가장 가까운 것부터 끌어내십시오.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "{item:8585}을(를) 줍니다",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "{area:979} 옆 웅덩이",

	-- Step 14: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "남쪽 {area:1938}의 발굴 야영지로 가십시오. {npc:7771}이(가) 탐지 투구를 줍니다: 착용하면 {quest:3161} 흙더미가 보이며, 야영지 주변과 남서쪽 오우거 쪽 모래에 많이 있습니다.",

	-- Step 15: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "남서쪽 모래망치 주둔지로 가십시오. 모래망치일족 투사와 모래망치일족 집행자(46-48)가 가득하고, {npc:12046}(49)은(는) 경비병에 둘러싸여 한가운데에 서 있습니다: 경비병부터 처치하십시오.",

	-- Step 16: The Noxious Lair
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "북서쪽 모래언덕의 센티파르 둥지(맹독의 둥지)로 가십시오. 어느 센티파르든 센티파르 곤충 기관을 떨어뜨릴 수 있습니다.",

	-- Step 17: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "남쪽 {quest:3362}(으)로 가십시오. 이슬먹는 덤불나무괴물이 이슬샘을 떨어뜨리는데 일부만 가득 차 있으니 가득 찬 이슬샘을 챙기십시오. 옹이진 덤불나무괴물과 억센뿌리 덤불나무괴물도 골짜기에 있습니다. 덤불나무괴물은 48-50레벨로 당신보다 높으니 하나씩 끌어내십시오.",

	-- Step 18: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "{npc:5955} 호위",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "작은 거북 {npc:5955}은(는) 골짜기 북쪽 끝에 숨어 있습니다. {area:977} 바로 동쪽 물가에 있는 아내 {npc:6015}에게 데려다주십시오: 느리게 걷고 사막의 야수들이 노리니 살려 두십시오.",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "서쪽 {area:976}(으)로 돌아가십시오.",
	-- {npc:11758} Andi Lynn
	["{npc:11758}, on the east side of town"] = "{npc:11758}, 마을 동쪽",
	-- {npc:7583} Sprinkle · {zone:1425} Hinterlands
	["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "{npc:7583}의 다음 재료는 {zone:1425}에서 자라고, 경로상 다시 가져오지 않습니다: 건너뛰십시오.",

	-- Step 20: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "남동쪽 {area:985}(으)로 가십시오. {npc:7847}은(는) 남쪽 사막유랑단 야영지 한가운데에 서 있습니다: 주변부터 정리하십시오.",

	-- Step 21: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "남쪽으로 {area:1938}을(를) 지나 하잘리 굴인 {area:981}으로 가십시오. 슈섕크의 측량 장비는 깊숙한 곳에 있습니다.",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}."] = "귀환석으로 {area:976}에 가십시오.",
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "{zone:1457}용: 경로상 47레벨에 그곳에 갑니다",

	-- Step 23: Ironforge
	-- {area:976} Gadgetzan · {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "{area:976}에서 테라모어 섬으로 날아가, 배를 타고 {area:150}(으)로 간 다음 {area:1537}(으)로 날아가십시오. 기술을 배우십시오.",

	-- Step 24: Aerie Peak
	-- {area:348} Aerie Peak · {zone:1425} Hinterlands
	["Fly to {area:348}. {zone:1425} guide starts here."] = "{area:348}(으)로 날아가십시오. {zone:1425} 가이드는 여기서 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "{area:348}(으)로 날아가십시오. {zone:1425} 가이드는 여기서 시작합니다.",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "남쪽으로 {area:1938}을(를) 지나 하잘리 굴인 {area:981}(으)로 가십시오. 슈섕크의 측량 장비는 깊숙한 곳에 있습니다.",
	-- ["The Wanted poster by {npc:7882}"] = "{npc:7882} 옆의 현상수배 포스터",
}
