-- Korean (koKR): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:279} Dalaran
	["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "29~33레벨 캐릭터용이지만, 여기 퀘스트 대부분은 32-34레벨이고 몇 개는 36레벨까지입니다. 경험치를 위해 일부러 넣었습니다. 비밀결사대, {area:279}의 경비병, 돌주먹 오우거는 31-35레벨이니 하나씩 끌어오세요.",

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
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	["Crossroads flight master"] = "",

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
	["Zeppelin to {zone:1458}"] = "",

	-- Step 13: The Undercity
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:513} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). The quest text says Strong, but it takes a {item:3388}. No elixir: skip the Elixir steps in {area:287}."] = "",
	-- {item:3388} Lesser Troll's Blood Elixir · {quest:513} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388}: {quest:513}을(를) 위해 경매장이나 연금술사에게서",

	-- Step 14: Master Apothecary Faranell
	-- {item:3388} Lesser Troll's Blood Elixir · {npc:2055} Master Apothecary Faranell · {quest:513} Elixir of Agony · {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "가방에 {item:3388}이(가) 있으면 연금술 실험실의 {npc:2055}이(가) {quest:513}을(를) 줍니다. 비약은 {area:272}의 {npc:2216}이(가) 받습니다.",

	-- Step 15: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "",

	-- Step 16: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 17: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "",

	-- Step 18: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "{area:272}(으)로 날아가기",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "",

	-- Step 20: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "22-25레벨 {area:287} 가이드에 있던 다살리아의 첫 심부름을 놓쳤습니다. 지금 그것부터 합니다. 레벨이 조금 낮고 금방 끝나며, 이 가이드에 있는 나머지 {quest:527}을(를) 열어 줍니다.",

	-- Step 21: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229}은(는) '침투'를 맡기기 전에 {area:275}에서 정찰병 두 명을 풀어 주기를 원합니다.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",

	-- Step 22: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "언덕을 지나 서쪽으로, {area:287} 마을 동쪽의 농장으로 가세요. {npc:232}은(는) 북쪽 농가 옆 밭에서, {npc:2403}은(는) 더 남동쪽 밭에서 일합니다. 농노와 농부는 곳곳에 있습니다.\n주의: 키린 토 경비병(55)이 {area:287}의 밭과 길을 순찰하며 호드를 공격합니다. 잘 살피고 그들의 길을 피하세요.",

	-- Step 23: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "",

	-- Step 24: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "힐스브래드 소작농",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "다시 밭으로 가세요. 소작농은 농가 남쪽에서 일합니다. 주의: 도망치는 소작농이 마을 회관에 닿으면 적을 더 데려올 수 있습니다. 감속이나 이동 불가 효과로 도망가지 못하게 하세요.",

	-- Step 26: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "타렌 밀농장 남동쪽입니다. 드럴과 {npc:2238}은(는) 요새 안뜰 건물에 사슬로 묶여 있습니다. {npc:2427}이(가) {item:3467}을(를), {npc:2428}이(가) {item:3499}을(를) 가지고 있으며, 둘 다 요새 안에 있습니다. 둘을 처치한 다음 자물쇠 두 개를 모두 여세요.",
	["Drull's ball and chain"] = "드럴의 족쇄",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "{npc:2238}의 족쇄",

	-- Step 27: The smithy
	["The smithy"] = "대장간",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "구릉지를 가로질러 서쪽의 {area:287} 마을로 가세요. 대장간은 마을 한가운데에 있습니다. {npc:2404}와(과) 견습생들이 대장간 화로에서 일하고, {object:1736}은(는) 그 옆에 쌓여 있습니다.",
	["Inside"] = "",

	-- Step 28: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "{area:272}(으)로 돌아가세요.",

	-- Step 30: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{npc:2333}에게 줄 {item:3703}",

	-- Step 31: Helcular's Rod
	-- {area:277} Foothill Caverns · {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "남서쪽, {area:272} 서쪽 언덕의 {area:277}에는 동굴 설인과 사나운 설인(30-32)이 가득합니다. 열여섯 마리 중 한 마리꼴로 마법봉을 지니고 있습니다. 이 동굴에만 머무르세요. 더 북쪽 동굴의 산악 설인과 거대한 설인(32-34)도 마법봉을 지니지만, 29-30레벨에서는 세게 때리고 짝을 지어 다닙니다.",

	-- Step 32: Level 30
	["Level 30"] = "",
	-- {area:272} Tarren Mill · {quest:544} Prison Break In · {quest:556} Stone Tokens · {quest:676} The Hammer May Fall
	["{area:272}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the City of Dalaran dungeon instead."] = "",
	-- {npc:2248} Cave Yeti
	["grind on {npc:2248}"] = "",

	-- Step 33: Town hall
	["Town hall"] = "마을 회관",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "",

	-- Step 34: Tarren Mill
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside: offered from level 30"] = "",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside: offered from level 30"] = "",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide (from level 30)"] = "",

	-- Step 35: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "달라란 시 공략용(이 가이드 후반): {npc:2278}은(는) {area:272}에서 {npc:2410} 동쪽으로 조금 걸어가면 서 있습니다.",

	-- Step 36: Foothill Caverns
	-- {area:272} Tarren Mill · {item:3710} Rod of Helcular · {object:1768} Flame of Azel · {object:1769} Flame of Veraz
	["Back into the yeti caves west of {area:272} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "",

	-- Step 37: Flame of Uzel
	-- plural, as words: Mountain Yetis = {npc:2250} Mountain Yeti
	["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "세 번째 불꽃은 동굴들 북쪽 언덕 위의 작은 동굴에서 타오릅니다.\n주의: 거대한 설인과 산악 설인(32-34)이 불꽃 주변에 서 있는데 종종 짝을 지어 있고, 희귀 설인 서리갈기 설인(37)이 근처를 돌아다닙니다. 30-31레벨에서는 나보다 레벨이 높으니, 마법봉을 쓰기 전에 동굴 입구에서 설인을 하나씩 끌어오고, 들어가기 전에 서리갈기 설인을 살피세요.",

	-- Step 38: Alterac Mountains
	-- {area:279} Dalaran
	["The {area:279} crater's eastern rim"] = "{area:279} 분화구 동쪽 가장자리",

	-- Step 39: The Dalaran crater
	-- {area:279} Dalaran
	["The {area:279} crater"] = "",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens. Careful: Many guards stand in linked pairs and others patrol alone around the camp. Arcane Sentries (55, elite) and Kirin Tor Guards (55) stand around the violet dome itself: keep to the camp below the rim."] = "",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "",

	-- Step 40: City of Dalaran
	["City of Dalaran"] = "달라란 시",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "달라란 시는 보랏빛 돔 아래에 있는 약 28~33레벨 5인 파티용 던전입니다. {item:277507}이(가) 없다면 분화구 북서쪽의 하수관으로 들어가십시오. 화살표가 그곳으로 안내합니다.\n내부: {npc:247126}은(는) {npc:2278}의 퀘스트 대상입니다. 하수도의 {npc:268743}이(가) 'Opportunistic Education'을 주며, 그곳에서 다시 받습니다.",
	-- {quest:96986} The Grave Knight · {npc:247126} Atrexis the Grave Knight
	["{quest:96986}: {npc:247126}, inside"] = "{quest:96986}: {npc:247126}, 내부",

	-- Step 42: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "",

	-- Step 43: Torn Fin murlocs
	["Torn Fin murlocs"] = "너덜지느러미멀록",
	-- {area:271} Southshore
	["The Torn Fin murlocs camp on the beaches south-west of {area:271}'s bay, below the mine."] = "",
	["Torn Fin beach"] = "너덜지느러미멀록 해변",

	-- Step 44: Helcular's Grave
	-- {area:271} Southshore
	-- plural, as words: Southshore Guards = {npc:2386} Southshore Guard
	["Head east to {area:271}'s graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north, down the slope above the town. Southshore Guards (55) stand at the graveyard's north-west corner and south-east of the grave: walk in between them, hand the quest in and leave the way you came."] = "",
	["North of Southshore's graveyard"] = "사우스쇼어 묘지 북쪽",

	-- Step 45: Daggerspine naga
	["Daggerspine naga"] = "비수가시일족 나가",
	["The Daggerspine naga line the shore south-east of the town."] = "",
	["Daggerspine shore"] = "비수가시일족 해안",

	-- Step 46: Henchman Valik
	-- {area:271} Southshore · {area:272} Tarren Mill · {quest:535} Valik · {npc:2229} Krusk
	["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "{area:271}에서 북쪽으로 {area:272}을(를) 지나, 길을 따라 알터랙 산기슭으로 계속 가세요. {quest:535}은(는) 비밀결사대 야영지 옆에서 기다립니다. 그는 {npc:2229}의 '침투'를 지니고 있을 때만 심부름을 줍니다. 바로 맥주를 건네면 보상으로 크루스크가 원하는 비밀결사대 신서를 줍니다. 이곳 비밀결사대에게서 얻은 신서도 마찬가지입니다. 가방에 하나 있으면 가이드는 {quest:535}을(를) 건너뜁니다.",

	-- Step 47: Syndicate missives
	["Syndicate missives"] = "비밀결사대 서신",
	-- {quest:535} Valik
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "{quest:535}의 신서를 얻지 못했을 때만: 길 서쪽 야영지 주변의 비밀결사대 노상강도와 도둑(32-34)도 신서를 지니고 있으며, 세 마리 중 한 마리꼴로 떨어뜨립니다. 주의: 31-32레벨에서는 아직 나보다 높고 서로 가까이 서 있으며, 그 사이에 마술사(34-35)도 있습니다. 야영지 가장자리에서 하나씩 끌어오세요.",

	-- Step 48: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back south down the road to {area:272}."] = "길을 따라 남쪽으로 {area:272}에 돌아가세요.",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215}: 그녀의 다음 퀘스트인 {quest:539}와(과) {npc:2419}의 검은 {area:290}의 정예 파티 퀘스트입니다. 파티가 있을 때만 받으십시오",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	-- {npc:2229} Krusk · {npc:2316} Gol'dir · {area:272} Tarren Mill
	["{npc:2229} now offers {npc:2316} (level 36), Bel'varil Bracers of Binding and Voidglare Dalaran Patrols: leave them for the 38-39 visit, which takes them on its first {area:272} stop."] = "",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",

	-- Step 49: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "달라란 시 공략에서 얻은 {quest:96986}: {npc:2410}에서 동쪽으로 조금 걸어가면 있는 {npc:2278}.",

	-- Step 50: Elixir of Agony with a group
	-- {quest:515} Elixir of Agony
	["{quest:515} with a group"] = "",
	-- {area:290} Dun Garok · {area:271} Southshore
	["Lydon's next errand is a keg of Shindigger Stout from the cellar of {area:290}, the elite dwarven keep south-east of {area:271}: take it only if you go there with a group."] = "",

	-- Step 51: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "",

	-- Step 52: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "",

	-- Step 53: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "",

	-- Step 54: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "",

	-- Step 56: Shindigger keg
	["Shindigger keg"] = "신디거 흑맥주 통",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["The Kegs of Shindigger Stout stand in the cellar of {area:290}, the dwarven keep south-east of {area:271}, beside {npc:2304} (32); every dwarf there is elite (28-32)."] = "",
	["Below ground"] = "지하",

	-- Step 57: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "{area:272}(으)로 돌아가기",
	-- {area:272} Tarren Mill
	["Head back north to {area:272}."] = "",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "",

	-- Step 58: Arathi Highlands
	["Boulderfist camp"] = "돌주먹일족 야영지",

	-- Step 59: Boulderfist camp
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "",

	-- Step 60: Level 31
	["Level 31"] = "",
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["{area:321}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the City of Dalaran dungeon instead."] = "",
	-- {npc:2562} Boulderfist Ogre
	["grind on {npc:2562}"] = "",

	-- Step 61: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, 성문 옆",
	-- {npc:2706} Tor'gan · {area:272} Tarren Mill
	["{npc:2706}: its Syndicate are by the road in from {area:272}, on the 38-39 visit"] = "",

	-- Step 62: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "",

	-- Step 63: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "",

	-- Step 64: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}."] = "",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "",
	-- {npc:2706} Tor'gan · {npc:2771} Drum Fel · {quest:677} Call to Arms
	["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "",

	-- Step 65: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:321} Hammerfall
	["{area:321} flight master"] = "",

	-- Step 66: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "",

	-- Step 67: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038}은(는) 연금술 실험실에 서 있습니다. 그의 {quest:97985}은(는) Stormheart가 대상입니다. 30레벨 정예로, 다음 가이드에서 {area:439}(으)로 가는 길, {area:484} 동쪽 협곡을 걸어 다닙니다.",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038}: 다음 {zone:1458} 방문 때(약 38레벨) 그에게 돌아갑니다",

	-- Step 68: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458} 상급자",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "{zone:1458}에 있는 동안 기술을 배우세요. 상급자는 {object:36070}, {object:36073}, {object:36082}에 있습니다(성기사: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "길을 따라 {area:272}에서 북쪽으로 알터랙 산기슭으로 가세요. {quest:535}은(는) 비밀결사대 야영지 옆에서 기다립니다. 흑맥주를 건네세요.",
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "길 서쪽 야영지 주변의 비밀결사대 노상강도와 도둑(32-33)이 서신을 지니고 있습니다. 세 명 중 한 명 정도가 떨어뜨립니다.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "맥주 통은 {area:287} 남동쪽 해안의 비밀결사대 야영지에 다른 통 몇 개와 함께 있습니다.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "길 동쪽 끝의 오크 요새입니다. 윈드라이더 조련사 {npc:2851}는 정문 옆에 서 있습니다.",
}
