-- Korean (koKR): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:527} Battle of Hillsbrad · {area:272} Tarren Mill
	["For characters of 29 to 31: the {quest:527}, {area:272}'s errands and the gnolls of the foothills, all at or under your level."] = "29~31레벨 캐릭터용: {quest:527}, {area:272}의 심부름, 구릉지의 놀, 모두 자신의 레벨 이하입니다.",

	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 7: Korran
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows · {zone:1454} Orgrimmar
	["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29; below it, the next guide's {zone:1454} stop takes it."] = "{npc:3428}은(는) 십자로 비행 조련사 옆에 있습니다. {quest:1145}은(는) 29레벨부터 받을 수 있습니다. 그보다 낮다면 다음 가이드의 {zone:1454} 방문 때 받습니다.",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	["Crossroads flight master"] = "크로스로드 비행 조련사",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "그롬마쉬 요새의 {npc:4949}, 가지고 있다면",

	-- Step 10: Train
	["Train"] = "기술 배우기",
	["Train your new spells."] = "새 주문을 배우세요.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "{zone:1458}행 비행선",

	-- Step 13: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "",

	-- Step 14: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 15: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "",

	-- Step 16: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "{area:272}(으)로 날아가기",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "",

	-- Step 18: Tarren Mill
	-- {quest:567} Dangerous! · {npc:2216} Apothecary Lydon · {npc:2393} Christoph Jeffcoat
	["The {quest:567} poster hangs by the inn; {npc:2216} stands inside it. {npc:2393}, the cook by the inn, wants turtle meat and sells the spices for it."] = "{quest:567} 게시물은 여관 옆에 걸려 있고, {npc:2216}은(는) 여관 안에 있습니다. 여관 옆의 요리사 {npc:2393}은(는) 거북이 고기를 원하며, 그에 필요한 양념을 팝니다.",
	-- {quest:567} Dangerous!
	["{quest:567}, the poster by the inn"] = "여관 옆 게시물의 {quest:567}",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",
	-- {npc:2393} Christoph Jeffcoat · {quest:7321} Soothing Turtle Bisque
	["{npc:2393}: {quest:7321}, the Snapjaws of the river south of town"] = "{npc:2393}: {quest:7321}, 마을 남쪽 강의 무쇠턱거북",
	-- {item:3713} Soothing Spices · {npc:2393} Christoph Jeffcoat
	["{item:3713}, from {npc:2393}"] = "{npc:2393}에게서 사는 {item:3713}",

	-- Step 19: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "22-25레벨 {area:287} 가이드에 있던 다살리아의 첫 심부름을 놓쳤습니다. 지금 그것부터 합니다. 레벨이 조금 낮고 금방 끝나며, 이 가이드에 있는 나머지 {quest:527}을(를) 열어 줍니다.",

	-- Step 20: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275}."] = "{npc:2229}은(는) {area:275}에서 정찰병 두 명을 풀어 주기를 원합니다.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",

	-- Step 21: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "언덕을 지나 서쪽으로, {area:287} 마을 동쪽의 농장으로 가세요. {npc:232}은(는) 북쪽 농가 옆 밭에서, {npc:2403}은(는) 더 남동쪽 밭에서 일합니다. 농노와 농부는 곳곳에 있습니다.\n주의: 키린 토 경비병(55)이 {area:287}의 밭과 길을 순찰하며 호드를 공격합니다. 잘 살피고 그들의 길을 피하세요.",

	-- Step 22: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "",

	-- Step 23: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "힐스브래드 소작농",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "다시 밭으로 가세요. 소작농은 농가 남쪽에서 일합니다. 주의: 도망치는 소작농이 마을 회관에 닿으면 적을 더 데려올 수 있습니다. 감속이나 이동 불가 효과로 도망가지 못하게 하세요.",

	-- Step 24: Hillsbrad Human Skulls
	-- plural, as words: Hillsbrad Human Skulls = {item:3692} Hillsbrad Human Skull
	["Hillsbrad Human Skulls"] = "",
	-- {quest:546} Souvenirs of Death
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Still carrying {quest:546}? Gather the skulls from Hillsbrad Peasants in the southern fields. Stay away from the town hall and the guards on the road."] = "",

	-- Step 28: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings, and each lock needs its key: {npc:2427} carries the {item:3467} for Drull's, {npc:2428} the {item:3499} for {npc:2238}'s, both in the keep. Kill them first, then open both locks."] = "",
	-- {item:3467} Dull Iron Key · {npc:2427} Jailor Eston
	["{item:3467}, from {npc:2427}"] = "",
	-- {item:3499} Burnished Gold Key · {npc:2428} Jailor Marlgen
	["{item:3499}, from {npc:2428}"] = "",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "{npc:2238}의 족쇄",
	["Drull's ball and chain"] = "드럴의 족쇄",

	-- Step 29: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "{area:272}(으)로 돌아가세요.",

	-- Step 30: The river south of Tarren Mill: kill these as you meet them
	-- {area:272} Tarren Mill
	["The river south of {area:272}: kill these as you meet them"] = "{area:272} 남쪽 강: 마주치는 대로 처치하세요",
	-- {area:272} Tarren Mill · {area:271} Southshore · {item:3712} Turtle Meat
	["South from {area:272} along the river: Snapjaws (29) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "{area:272}에서 강을 따라 남쪽으로: 무쇠턱거북(29)이 {area:271} 위 언덕까지 강둑 곳곳에서 햇볕을 쬐고 있습니다. 그중 일부가 {item:3712}을(를) 가지고 있습니다.",
	-- {item:3712} Turtle Meat
	["{item:3712}, from the Snapjaws"] = "무쇠턱거북에게서 얻는 {item:3712}",

	-- Step 31: Mudsnout Blossoms
	-- {area:290} Dun Garok
	["South of the river's bend, the Mudsnout gnolls (26-28) camp in the hills above {area:290}; the blossoms grow among their tents. The Shamans heal and call their friends: pull them first."] = "강이 굽어지는 곳 남쪽, {area:290} 위 언덕에 진흙주둥이 놀(26-28)이 야영하고 있으며, 꽃은 그들의 천막 사이에서 자랍니다. 주술사는 치유하고 동료를 부르니 먼저 끌어내세요.",

	-- Step 32: North of Southshore
	["North of Southshore"] = "사우스쇼어 북쪽",
	-- {area:287} Hillsbrad · {area:271} Southshore
	["From the blossoms, back north along the river and then west to {area:287} town, well north of {area:271} (its guards are 55)."] = "꽃이 있는 곳에서 강을 따라 다시 북쪽으로 간 뒤, 서쪽의 {area:287} 마을로 가세요. {area:271}에서 한참 북쪽에 있습니다(경비병은 55레벨).",

	-- Step 33: The smithy
	["The smithy"] = "대장간",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes · {npc:2451} Farmer Kalaba
	-- was: ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "구릉지를 가로질러 서쪽의 {area:287} 마을로 가세요. 대장간은 마을 한가운데에 있습니다. {npc:2404}와(과) 견습생들이 대장간 화로에서 일하고, {object:1736}은(는) 그 옆에 쌓여 있습니다. {npc:2449}은(는) 대장간 근처를 걸어 다니고, {npc:2451}은(는) 마을 남동쪽 밭에서 일합니다."
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the west side of the town; {npc:2451} works the field south-east of the town."] = "",
	["Inside"] = "",
	-- {npc:2449} Citizen Wilkes
	["{npc:2449}, on the west side of the town"] = "",

	-- Step 34: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["for {npc:2055}, on the {zone:1458} stop at the end of this guide"] = "이 가이드 마지막의 {zone:1458} 방문 때 {npc:2055}에게 제출합니다",
	-- {npc:2429} Novice Thaivand · {item:3708} Helcular's Rod
	["{npc:2429}, in the town: {item:3708}, from the yetis on the way to the town hall"] = "마을의 {npc:2429}: {item:3708}, 마을 회관으로 가는 길의 설인에게서 얻습니다",

	-- Step 35: Helcular's Rod
	-- {area:277} Foothill Caverns
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["West of Tarren Mill, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but they hit hard and come in pairs."] = "타렌 밀농장 서쪽, 언덕의 {area:277}에는 동굴 설인과 사나운 설인(30-32)이 가득합니다. 열여섯 마리 중 한 마리꼴로 마법봉을 지니고 있습니다. 이 동굴에만 머무르세요. 더 북쪽 동굴의 산악 설인과 거대한 설인(32-34)도 마법봉을 지니지만, 세게 때리고 짝을 지어 다닙니다.",

	-- Step 36: Town hall
	["Town hall"] = "마을 회관",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "",

	-- Step 37: Tarren Mill
	-- {area:271} Southshore
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["Thaivand's next errand, the flames, sends you among the Mountain and Giant Yetis (32-34) and to Helcular's grave inside {area:271}: leave it."] = "사이반드의 다음 심부름인 불꽃 퀘스트는 산악 설인과 거대한 설인(32-34) 사이와 {area:271} 안의 헬쿨라 무덤으로 보냅니다. 받지 마세요.",

	-- Step 38: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "달라란 시 공략용(이 가이드 후반): {npc:2278}은(는) {area:272}에서 {npc:2410} 동쪽으로 조금 걸어가면 서 있습니다.",

	-- Step 39: City of Dalaran
	["City of Dalaran"] = "달라란 시",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "달라란 시는 보랏빛 돔 아래에 있는 약 28~33레벨 5인 파티용 던전입니다. {item:277507}이(가) 없다면 분화구 북서쪽의 하수관으로 들어가십시오. 화살표가 그곳으로 안내합니다.\n내부: {npc:247126}은(는) {npc:2278}의 퀘스트 대상입니다. 하수도의 {npc:268743}이(가) 'Opportunistic Education'을 주며, 그곳에서 다시 받습니다.",
	-- {quest:96986} The Grave Knight · {npc:247126} Atrexis the Grave Knight
	["{quest:96986}: {npc:247126}, inside"] = "{quest:96986}: {npc:247126}, 내부",

	-- Step 41: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south-west past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:287} 마을을 지나 남서쪽의 {area:288}(으)로 가세요. 광부들이 갱도에서 일하고, {npc:2305}(30)와(과) {npc:2450}(29)은(는) 깊숙한 곳에 있습니다.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "",

	-- Step 42: Level 30
	["Level 30"] = "",
	-- {npc:2410} Magus Wordeen Voidglare · {area:272} Tarren Mill · {zone:1454} Orgrimmar · {area:288} Azurelode Mine · {zone:1437} Wetlands
	-- plural, as words: Torn Fin Muckdwellers = {npc:2374} Torn Fin Muckdweller
	["{npc:2410}'s quests on the next {area:272} stop and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Short of 30? The Torn Fin Muckdwellers and Coastrunners (28-30) crowd the coast south of the {area:288}, a short walk: kill them until level 30. Their Oracles (30-31) cast from the shore further east. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "다음 {area:272} 방문 때의 {npc:2410} 퀘스트와 다음 가이드의 첫 방문지인 {zone:1454}의 'Alliance Relations'는 30레벨부터 받을 수 있습니다. 30레벨이 안 되나요? 너덜지느러미멀록 땅꾼과 길잡이(28-30)가 {area:288} 남쪽 해안에 몰려 있으니 조금만 걸어가 30레벨까지 처치하세요. 예언자(30-31)는 더 동쪽 해안에서 주문을 겁니다. 또는 파티가 있다면 대신 발굴 현장 던전({zone:1437})을 도세요.",
	["Torn Fin murlocs"] = "너덜지느러미멀록",
	-- {npc:2375} Torn Fin Coastrunner
	["grind on {npc:2375}"] = "{npc:2375} 사냥",

	-- Step 43: Finish the Turtle Meat
	-- {item:3712} Turtle Meat
	["Finish the {item:3712}"] = "{item:3712} 마저 모으기",
	-- {item:3712} Turtle Meat · {area:272} Tarren Mill
	["Still short of ten {item:3712}? The Snapjaws line the river east of {area:272}, on your way back from the mine."] = "아직 {item:3712} 10개가 안 되나요? 광산에서 돌아오는 길, {area:272} 동쪽 강가에 무쇠턱거북이 줄지어 있습니다.",

	-- Step 44: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["North-east back to {area:272}, passing well north of {area:271} (its guards are 55)."] = "북동쪽 {area:272}(으)로 돌아가십시오. {area:271}의 경비병은 55레벨이니 그 북쪽으로 멀찍이 돌아서 가십시오.",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215}: 그녀의 다음 퀘스트인 {quest:539}와(과) {npc:2419}의 검은 {area:290}의 정예 파티 퀘스트입니다. 파티가 있을 때만 받으십시오",
	-- {npc:2229} Krusk
	["{npc:2229}, inside: Infiltration, worked on the 38-39 visit (its Syndicate are 32-35)"] = "{npc:2229}, 내부: 'Infiltration', 38-39레벨 방문 때 진행합니다(신디케이트는 32-35레벨)",
	-- {area:272} Tarren Mill
	["Keep Infiltration in your log: its Syndicate (32-35) are over you now, and the 38-39 guide (Alterac and Arathi) works it on its first {area:272} loop."] = "'Infiltration'은 퀘스트 목록에 남겨 두세요. 신디케이트(32-35)는 지금 레벨보다 높으며, 38-39레벨 가이드(알터랙과 아라시)의 첫 {area:272} 순회에서 진행합니다.",

	-- Step 45: Voidglare, Bel'varil and Tallow
	-- {npc:2770} Tallow
	["Voidglare, Bel'varil and {npc:2770}"] = "보이드글레어, 벨바릴, {npc:2770}",
	-- {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow · {area:272} Tarren Mill
	["{npc:2410} and {npc:2437} are inside the inn, {npc:2770} just outside it. Their quests are offered from level 30; below it, the 38-39 guide's first {area:272} stop takes them."] = "{npc:2410}와(과) {npc:2437}은(는) 여관 안에, {npc:2770}은(는) 여관 바로 밖에 있습니다. 이들의 퀘스트는 30레벨부터 받을 수 있으며, 그보다 낮다면 38-39레벨 가이드의 첫 {area:272} 방문 때 받습니다.",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:544} Prison Break In · {area:279} Dalaran
	["{npc:2410}, inside: {quest:544}, for the 38-39 visit (the {area:279} crater's traitors are 33-35)"] = "{npc:2410}, 내부: {quest:544}, 38-39레벨 방문 때 진행({area:279} 분화구의 배신자는 33-35레벨)",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {quest:544} Prison Break In
	["{npc:2410}: {quest:93680}, with {quest:544} on the 38-39 visit"] = "{npc:2410}: {quest:93680}, 38-39레벨 방문 때 {quest:544}와(과) 함께 진행",
	-- {npc:2437} Keeper Bel'varil · {quest:556} Stone Tokens
	["{npc:2437}, inside: {quest:556}, with the crater on the 38-39 visit"] = "{npc:2437}, 내부: {quest:556}, 38-39레벨 방문 때 분화구와 함께 진행",
	-- {npc:2770} Tallow
	["{npc:2770}, outside the inn: the Boulderfist ogres (32-34) on the 38-39 Arathi visit"] = "여관 밖의 {npc:2770}: 바위주먹 오우거(32-34), 38-39레벨 아라시 방문 때 진행",
	-- {area:272} Tarren Mill · {area:321} Hammerfall
	["Keep these in your log: their camps are two to four levels over you now, and the 38-39 guide works them on its first {area:272} loop and in {area:321}."] = "이 퀘스트들은 퀘스트 목록에 남겨 두세요. 해당 진영은 지금 레벨보다 2~4레벨 높으며, 38-39 가이드의 첫 {area:272} 순회와 {area:321}에서 처리합니다.",

	-- Step 46: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "달라란 시 공략에서 얻은 {quest:96986}: {npc:2410}에서 동쪽으로 조금 걸어가면 있는 {npc:2278}.",

	-- Step 47: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "",

	-- Step 48: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "",

	-- Step 49: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "",

	-- Step 50: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "",

	-- Step 52: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 53: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell · {object:36126} Royal Quarter
	["{npc:2055} stands in the Apothecarium, in the {object:36126}."] = "{npc:2055}은(는) {object:36126}의 연금술 실험실에 서 있습니다.",
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["Faranell's next {quest:513} needs a {item:3388} ({skill:171}) and the {area:287} coast: leave it."] = "파라넬의 다음 퀘스트인 {quest:513}에는 {item:3388}({skill:171})과(와) {area:287} 해안이 필요합니다. 그냥 두세요.",

	-- Step 54: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "",

	-- Step 55: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038}은(는) 연금술 실험실에 서 있습니다. 그의 {quest:97985}은(는) Stormheart가 대상입니다. 30레벨 정예로, 다음 가이드에서 {area:439}(으)로 가는 길, {area:484} 동쪽 협곡을 걸어 다닙니다.",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038}: 다음 {zone:1458} 방문 때(약 38레벨) 그에게 돌아갑니다",

	-- Step 56: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458} 상급자",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "{zone:1458}에 있는 동안 기술을 배우세요. 상급자는 {object:36070}, {object:36073}, {object:36082}에 있습니다(성기사: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:272}"] = "{area:272}(으)로 돌아가기",
	-- ["Below ground"] = "지하",
	-- ["Boulderfist camp"] = "돌주먹일족 야영지",
	-- ["Daggerspine naga"] = "비수가시일족 나가",
	-- ["Daggerspine shore"] = "비수가시일족 해안",
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "길을 따라 {area:272}에서 북쪽으로 알터랙 산기슭으로 가세요. {quest:535}은(는) 비밀결사대 야영지 옆에서 기다립니다. 흑맥주를 건네세요.",
	-- ["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "29~33레벨 캐릭터용이지만, 여기 퀘스트 대부분은 32-34레벨이고 몇 개는 36레벨까지입니다. 경험치를 위해 일부러 넣었습니다. 비밀결사대, {area:279}의 경비병, 돌주먹 오우거는 31-35레벨이니 하나씩 끌어오세요.",
	-- ["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "{area:271}에서 북쪽으로 {area:272}을(를) 지나, 길을 따라 알터랙 산기슭으로 계속 가세요. {quest:535}은(는) 비밀결사대 야영지 옆에서 기다립니다. 그는 {npc:2229}의 '침투'를 지니고 있을 때만 심부름을 줍니다. 바로 맥주를 건네면 보상으로 크루스크가 원하는 비밀결사대 신서를 줍니다. 이곳 비밀결사대에게서 얻은 신서도 마찬가지입니다. 가방에 하나 있으면 가이드는 {quest:535}을(를) 건너뜁니다.",
	-- ["Head back south down the road to {area:272}."] = "길을 따라 남쪽으로 {area:272}에 돌아가세요.",
	-- ["North of Southshore's graveyard"] = "사우스쇼어 묘지 북쪽",
	-- ["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "{quest:535}의 신서를 얻지 못했을 때만: 길 서쪽 야영지 주변의 비밀결사대 노상강도와 도둑(32-34)도 신서를 지니고 있으며, 세 마리 중 한 마리꼴로 떨어뜨립니다. 주의: 31-32레벨에서는 아직 나보다 높고 서로 가까이 서 있으며, 그 사이에 마술사(34-35)도 있습니다. 야영지 가장자리에서 하나씩 끌어오세요.",
	-- ["Shindigger keg"] = "신디거 흑맥주 통",
	-- ["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "타렌 밀농장 남동쪽입니다. 드럴과 {npc:2238}은(는) 요새 안뜰 건물에 사슬로 묶여 있습니다. {npc:2427}이(가) {item:3467}을(를), {npc:2428}이(가) {item:3499}을(를) 가지고 있으며, 둘 다 요새 안에 있습니다. 둘을 처치한 다음 자물쇠 두 개를 모두 여세요.",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "남서쪽, {area:272} 서쪽 언덕의 {area:277}에는 동굴 설인과 사나운 설인(30-32)이 가득합니다. 열여섯 마리 중 한 마리꼴로 마법봉을 지니고 있습니다. 이 동굴에만 머무르세요. 더 북쪽 동굴의 산악 설인과 거대한 설인(32-34)도 마법봉을 지니지만, 29-30레벨에서는 세게 때리고 짝을 지어 다닙니다.",
	-- ["Syndicate missives"] = "비밀결사대 서신",
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "길 서쪽 야영지 주변의 비밀결사대 노상강도와 도둑(32-33)이 서신을 지니고 있습니다. 세 명 중 한 명 정도가 떨어뜨립니다.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "맥주 통은 {area:287} 남동쪽 해안의 비밀결사대 야영지에 다른 통 몇 개와 함께 있습니다.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "길 동쪽 끝의 오크 요새입니다. 윈드라이더 조련사 {npc:2851}는 정문 옆에 서 있습니다.",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "세 번째 불꽃은 동굴들 북쪽 언덕 위의 작은 동굴에서 타오릅니다.\n주의: 거대한 설인과 산악 설인(32-34)이 불꽃 주변에 서 있는데 종종 짝을 지어 있고, 희귀 설인 서리갈기 설인(37)이 근처를 돌아다닙니다. 30-31레벨에서는 나보다 레벨이 높으니, 마법봉을 쓰기 전에 동굴 입구에서 설인을 하나씩 끌어오고, 들어가기 전에 서리갈기 설인을 살피세요.",
	-- ["The {area:279} crater's eastern rim"] = "{area:279} 분화구 동쪽 가장자리",
	-- ["Torn Fin beach"] = "너덜지느러미멀록 해변",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "구릉지를 가로질러 서쪽의 {area:287} 마을로 가세요. 대장간은 마을 한가운데에 있습니다. {npc:2404}와(과) 견습생들이 대장간 화로에서 일하고, {object:1736}은(는) 그 옆에 쌓여 있습니다.",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "구릉지를 가로질러 서쪽의 {area:287} 마을로 가세요. 대장간은 마을 한가운데에 있습니다. {npc:2404}와(과) 견습생들이 대장간 화로에서 일하고, {object:1736}은(는) 그 옆에 쌓여 있습니다. {npc:2449}은(는) 대장간 근처를 걸어 다니고, {npc:2451}은(는) 마을 남동쪽 밭에서 일합니다.",
	-- ["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "가방에 {item:3388}이(가) 있으면 연금술 실험실의 {npc:2055}이(가) {quest:513}을(를) 줍니다. 비약은 {area:272}의 {npc:2216}이(가) 받습니다.",
	-- ["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388}: {quest:513}을(를) 위해 경매장이나 연금술사에게서",
	-- ["{item:3703}, for {npc:2333}"] = "{npc:2333}에게 줄 {item:3703}",
	-- ["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229}은(는) '침투'를 맡기기 전에 {area:275}에서 정찰병 두 명을 풀어 주기를 원합니다.",
	-- ["{npc:2792}, by the gate"] = "{npc:2792}, 성문 옆",
}
