-- Korean (koKR): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "{area:2268}(으)로 날아가기",
	-- {object:1661} The Undercity · {object:36078} Trade Quarter
	["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "{object:1661}의 비행 조련사는 성벽 밖, {object:36078}의 서쪽 탑에 있습니다.",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "{quest:5168}의 물품은 나중의 역병지대 지역에 있습니다. 보관하세요.",

	-- Step 3: Lake Mereldar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "역병사냥개와 새끼 역병사냥개는 예배당 남서쪽 호숫가를 돌아다닙니다.",

	-- Step 4: Sword of Marduk
	["Sword of Marduk"] = "마르두크의 검",
	["The shattered sword lies on the ground north-west of the lake."] = "부서진 검은 호수 북서쪽 땅바닥에 있습니다.",

	-- Step 5: The Pestilent Scar
	-- {area:2622} Pestilent Scar
	["The {area:2622}"] = "{area:2622}",
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "해골은 {area:2622}의 황폐의 그림자와 역병의 괴수 사이에 있습니다.",

	-- Step 6: Hameya's scroll
	["Hameya's scroll"] = "하메야의 두루마리",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "찢어진 두루마리는 {area:2260} 남쪽의 납골당인 {area:2261} 입구에 있습니다.",

	-- Step 7: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead
	["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "{npc:15193}의 용사가 {area:2260} 농가를 차지하고 있습니다.",

	-- Step 8: The western hills
	["The western hills"] = "서쪽 언덕",
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "새끼 역병사냥개와 역병박쥐는 {area:2260} 북쪽 언덕을 돌아다니고, 청소부구더기가 그 사이를 기어다닙니다. 북쪽 {area:2627} 방향으로 나아가세요.",

	-- Step 9: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "유령 {npc:11140}은(는) 북서쪽 구석, {area:2627}의 오두막 옆에 서 있습니다.",

	-- Step 10: Quel'Lithien Lodge
	-- {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "하이 엘프 순찰자, 길잡이, 수렵꾼이 {area:2275} 옆의 오두막을 지키고 있으며, 명부는 그 안에 있습니다. 순찰자는 60레벨까지 됩니다. 한 번에 한 명씩 끌어오세요. 가는 길에 맹독 역병박쥐가 들판 위를 날아다닙니다.",

	-- Step 11: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "하메야는 북동쪽 구석, {area:2273}의 이끼껍질부족 트롤 사이에 숨어 있습니다.",

	-- Step 12: Northdale
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "광포한 역병사냥개와 기괴한 역병박쥐는 {area:2273} 남쪽, {area:2272}와(과) {area:2271} 주변 들판에 함께 있습니다.",

	-- Step 13: Corin's Crossing
	-- {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447}은(는) 10분 안에 상합니다. 마을의 스컬지를 빨리 처치하고, 일곱 조각을 바로 {item:15454}(으)로 빻으세요.",

	-- Step 14: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "서쪽의 {area:2260}(으)로 가세요.",

	-- Step 15: Hameya's mound
	["Hameya's mound"] = "하메야의 흙더미",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just behind the {area:2261}."] = "{object:177675}은(는) {area:2261} 바로 뒤에 있습니다.",

	-- Step 17: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "{area:1638}(으)로 날아가기",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:1638} Thunder Bluff
	["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "{zone:1458}(으)로 날아가 {zone:1454}행 비행선을 탄 뒤 {area:1638}(으)로 날아가세요.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}의 {npc:3033}, {npc:246344}",

	-- Step 18: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "{area:1641}에 있습니다. 양모 옷감, 비단 옷감, 마법 옷감을 가방에 넣어 두세요.",

	-- Step 20: Deadwood Cauldron
	-- {item:12820} Winterfall Firewater · {zone:1452} Winterspring · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "{zone:1452}에서 {item:12820} 병을 찾았을 때만: 길을 따라 북쪽으로 가세요. 가마솥은 {area:1769} 바로 남서쪽의 {area:1762}에 있습니다. 그곳의 마른가지일족 털보숭이는 적대적입니다.",

	-- Step 21: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "{quest:8471}을(를) 얻었을 때만: {npc:11558}은(는) {area:1769}의 {zone:1448} 쪽 입구에서 기다리며, 나무구렁 평판이 중립일 때만 말을 겁니다.",

	-- Step 22: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "{area:1769}을(를) 지나 터널의 {zone:1450} 갈래로 가세요. {npc:11801}은(는) {area:2361}에 있습니다.",
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "두 퀘스트 모두 {zone:1451}(으)로 이어집니다. 보관하세요.",

	-- Step 23: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "터널로 돌아가 {zone:1452} 출구로 나간 뒤, 남쪽의 {area:2246}(으)로 가세요.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086}은(는) 나중에 {zone:1448}에 갈 때 처리합니다. 가지고 있다면 보관하세요.",

	-- Step 24: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "달빛 깃든 올빼미야수",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "동쪽의 {area:2255}(으)로 가서 북쪽으로 나가세요. 달빛 깃든 올빼미야수는 {area:2241} 남쪽 비탈의 언덕을 돌아다닙니다. 한 번에 한 마리씩 끌어오세요.",

	-- Step 25: Back to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Back to {area:1638}"] = "{area:1638}(으)로 돌아가기",

	-- Step 26: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "{object:142071} 기계",

	-- Step 27: Sprinkle
	-- {npc:10980} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {npc:10980} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "{area:976}의 고블린 소녀 {npc:7583}에게 {npc:10980}을(를) 사용하세요. {npc:10977}와(과) {npc:10978}은(는) 나중에 경로 중 놀래 줍니다.",

	-- Step 28: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299}은(는) {area:976} 바로 북쪽 묘지의 유령입니다. 눈에 띄는 묘비는 그 남쪽, 마을 성벽 밖에 있습니다.",
	-- {quest:3914} Linken's Sword
	["{quest:3914} goes back to Linken in Un'Goro: keep it."] = "{quest:3914}은(는) 운고로 분화구의 링쿠에게 돌아갑니다. 보관하세요.",

	-- Step 29: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771}은(는) {area:976} 남쪽, {area:1336}(으)로 가는 길가에 야영하고 있습니다.",

	-- Step 30: Hippogryph eggs
	["Hippogryph eggs"] = "히포그리프 알",
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "{area:1099}(으)로 날아가세요. 히포그리프 둥지는 {zone:1444} 남부에 있으며, 둥지마다 {object:142071}에 쓸 알이 하나씩 있습니다.",

	-- Step 31: On to Silithus
	-- {zone:1451} Silithus
	["On to {zone:1451}"] = "{zone:1451}(으)로",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus · {area:3077} Valor's Rest
	["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "{area:541}(으)로 날아간 뒤, 남서쪽으로 운고로 분화구를 지나 {zone:1451}(으)로 가는 고갯길로 가세요. 다음 가이드는 고갯길이 끝나는 {area:3077}에서 시작합니다.",
}
