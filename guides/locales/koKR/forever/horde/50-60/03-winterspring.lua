-- Korean (koKR): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255}은(는) 골짜기 동쪽의 고블린 마을입니다.",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "그레고르와 하를로의 퀘스트는 다른 지역으로 이어집니다. 보관하세요.",

	-- Step 2: Ice Thistle yetis
	["Ice Thistle yetis"] = "얼음엉겅퀴설인",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "설인 언덕은 {area:2255} 바로 남동쪽에서 시작합니다. 모든 설인이 털가죽을 떨어뜨리지만, 뿔은 맹렬한 설인과 덩치큰 설인만 떨어뜨리므로 완료 후를 위해 남겨 두세요.",

	-- Step 4: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "온전한 설인 뿔",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "맹렬한 설인과 덩치큰 설인은 세게 때립니다. 한 번에 한 마리씩 끌어오세요.",

	-- Step 5: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "우미의 세 번째 장난은 {area:976}와(과) 운고로 분화구의 고블린을 노립니다. 나중을 위해 보관하세요.",

	-- Step 6: Chillwind chimaeras
	["Chillwind chimaeras"] = "서리바람 키메라",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "키메라는 {area:2255} 남쪽과 서쪽의 설원을 돌아다닙니다. {area:2245} 동굴은 피하세요. 그곳의 푸른 용족은 정예입니다.",

	-- Step 8: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "흉포한 올빼미야수",
	-- {area:2251} Lake Kel'Theril
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "길을 따라 서쪽으로 {area:2251}을(를) 지나가세요. 흉포한 올빼미야수는 그 북쪽 언덕을 돌아다닙니다.",

	-- Step 9: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298}은(는) 골짜기 서쪽, {area:2246}의 김이 오르는 웅덩이 사이에 야영하고 있습니다.",
	["From Krakle in Un'Goro"] = "운고로 분화구의 크래클에게서",
	["Linken's letter"] = "링쿠의 편지",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909}은(는) 이 가이드 후반에 {zone:1444}의 {npc:7775}에게서 받습니다.",

	-- Step 10: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556}은(는) 온천 북쪽, {area:1769} 터널의 {zone:1452} 쪽 출구 옆에 서 있습니다.",

	-- Step 11: Frostfire Winterfall camps
	["Frostfire Winterfall camps"] = "얼음불꽃 눈사태일족 야영지",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "길잡이, 보초, 토템술사가 온천 주변 털보숭이 야영지에 함께 있고, 털복숭이 올빼미야수가 그 사이 비탈을 돌아다닙니다. 토템술사를 먼저 처치하세요. 얻는 {item:14047}은(는) 모두 메일로쉬를 위해 모아 두세요.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop from the Winterfall furbolgs"] = "눈사태일족 털보숭이가 드물게 떨어뜨리는 {item:12771}",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "눈사태일족 털보숭이가 드물게 떨어뜨리는 {quest:8471}",

	-- Step 12: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084}은(는) 나중에 {zone:1448}에 갈 때 {object:176091}에서 완료합니다.",

	-- Step 13: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "동쪽으로 간 뒤 남쪽으로 {area:2249}을(를) 내려가세요. 그곳의 서리망치거인은 59레벨 정예입니다. 가운데로 다니며 멈추지 마세요. 이상한 근원은 남쪽 끝, {area:2256} 입구에 있습니다.",

	-- Step 14: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "털보숭이 마을이 {area:2255} 북동쪽 골짜기를 가득 메우고 있습니다. 치유하는 주술사를 먼저 처치하세요. 안쪽 동굴의 {npc:10738}은(는) 정예입니다. 들어가지 마세요.",

	-- Step 15: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "서쪽의 {area:2246}(으)로 돌아가세요.",

	-- Step 17: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "눈사태일족 털보숭이는 누구나 구슬을 지니고 있을 수 있습니다. {npc:11556} 바로 남쪽 야영지가 가장 가깝습니다.",
	["Frostfire Winterfall camp"] = "얼음불꽃 눈사태일족 야영지",

	-- Step 19: Back to Everlook
	-- {area:2255} Everlook
	["Back to {area:2255}"] = "{area:2255}(으)로 돌아가기",

	-- Step 20: Grind to 55
	["Grind to 55"] = "55레벨까지 사냥",
	-- {npc:7440} Winterfall Den Watcher · {area:2244} Winterfall Village · {zone:1452} Winterspring
	["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "{zone:1452} {area:2244}에서 {npc:7440} 사냥",

	-- Step 21: A Little Luck
	-- {npc:10307} Witch Doctor Mau'ari
	["{npc:10307}, beside him"] = "그 옆의 {npc:10307}",

	-- Step 22: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "{area:1099}(으)로 날아가기",

	-- Step 23: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "드워프 {npc:7775}은(는) {area:1099} 북서쪽 {area:1137}에 야영하고 있습니다. 그가 비약을 가지고 있습니다.",

	-- Step 24: Talo Thornhoof
	-- {area:1099} Camp Mojache
	["Back at {area:1099}."] = "{area:1099}에 돌아왔습니다.",

	-- Step 25: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "{area:1638}(으)로 날아가기",

	-- Step 26: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "그는 {area:1641}에 서 있습니다. 기부마다 가방 속 옷감이 필요합니다. 나중에 경로 중 옷감이 모이면 건네세요.",

	-- Step 28: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}의 {npc:3033}, {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123}은(는) {zone:1450}에서 기다립니다. 나중을 위해 보관하세요.",

	-- Step 29: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil
	["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087}은(는) {quest:3761}(으)로 기른 {item:11040}을(를) 삽니다.",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",

	-- Step 31: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "{object:172961}에 있습니다.",

	-- Step 32: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "{object:172958}에 있습니다.",
}
