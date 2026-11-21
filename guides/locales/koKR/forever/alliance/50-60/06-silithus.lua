-- Korean (koKR): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451}: {area:3425}'s quests, to 60."] = "",

	-- Step 1: Innkeeper Vizzie
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {npc:11118} Innkeeper Vizzie
	["Back from {zone:2482} in {area:2255}: {npc:11118}'s mail went astray in the hills east of town, where the Ice Thistle yetis carry it off."] = "",

	-- Step 2: Missing Mail
	-- {area:2255} Everlook · {item:258323} Missing Mail
	["The Ice Thistle yetis (53-57) in the hills east of {area:2255} carry the {item:258323}: take it from the ones at the edge of the hills."] = "",

	-- Step 4: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:541} Marshal's Refuge · {zone:1449} Un'Goro Crater · {zone:1451} Silithus
	["Fly to {area:541} in {zone:1449}, the way into {zone:1451}."] = "",
	["Maethrya, the Alliance flight master"] = "",

	-- Step 5: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "{zone:1451}(으)로",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Ride west from {area:541} to the crater's north-western pass into {zone:1451}."] = "",

	-- Step 6: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["{npc:13220} stands at {area:3077}, where the pass comes out."] = "",

	-- Step 8: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:17082} Rifleman Torrig · {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17082}, at the Alliance tents: for {npc:17080} at {area:2743}"] = "얼라이언스 천막의 {npc:17082}: {area:2743}의 {npc:17080}에게 가져갑니다",
	-- {npc:15183} Geologist Larksbane
	["{npc:15183}: the tablet fragments come from the Twilight dig"] = "{npc:15183}: 서판 조각은 황혼의 발굴지에서 얻습니다",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: his Twilight texts come from the dig"] = "",

	-- Step 9: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- {npc:15185} Brood of Nozdormu
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around.\nCareful: {npc:15185} (62, elite) guard the Caverns of Time's mouth in the south-west, around 21,82: stay out of there."] = "",

	-- Step 10: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189}, upstairs"] = "{npc:15189}, 위층",

	-- Step 11: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["From the hold, west into the sands: Dredge Crushers dig there; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "요새에서 서쪽 모래밭으로 가세요. 망치미늘벌레가 그곳을 파고 있으며, 돌꼬리집게전갈, 가죽벗기기전갈, 긴다리 바위거미도 같은 모래밭에서 사냥합니다.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",

	-- Step 12: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "",
	-- {npc:15181} Commander Mar'alith
	["{npc:15181} (from level 58): Bronzebeard's Encampment comes later, on the way south"] = "",

	-- Step 13: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell · {area:2742} Hive'Ashi · {quest:8308} Brann Bronzebeard's Lost Letter
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Twilight Avengers = {npc:11880} Twilight Avenger · Twilight Flamereavers = {npc:15201} Twilight Flamereaver
	-- was: ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait."] = "황혼의 망치단 발굴지가 북서쪽 구석을 채우고 있습니다. 서판 조각은 땅바닥에 있고, {npc:11744}와(과) {npc:11746}도 가지고 있습니다. 이교도는 누구나 {item:20404}을(를) 떨어뜨릴 수 있습니다. 20개를 보관하세요. 10개는 {npc:15306}에게, 10개는 나중에 {npc:15194}에게 줍니다.\n주의: 문서는 {npc:11880}와(과) 지배자에게서 얻으세요. {npc:15201}(60)은(는) 피하고, {area:2742} 정예(59-60)가 기다리는 벌집 입구에는 들어가지 마세요."
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait.\nThe {area:2742} silithids sometimes drop {quest:8308}: keep it for Bronzebeard's Encampment in the south."] = "",
	["Twilight's Hammer cultists"] = "황혼의 망치단 이교도",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "{item:20378}",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "{quest:8323}에 10개 더",

	-- Step 14: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080}은(는) 서쪽 벌집인 {area:2743} 바깥에 진을 치고 있습니다. 근처 붉은 간헐천에서 실리시스트를 집어 그의 야영지에 있는 얼라이언스 추출기로 가져가세요.\n주의: 탈것을 타거나, 은신하거나, {spell:642}, {spell:5384}, 소멸을 사용하면 실리시스트를 잃습니다. 점멸과 {spell:17}은(는) 떨어뜨리지 않습니다.",
	["Bring a Silithyst to the Alliance extractor"] = "",

	-- Step 16: Southwind Village
	["The tortured druids and sentinels haunt the ruined village east of the hold."] = "",

	-- Step 17: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride north-east to {npc:13220} at {area:3077}."] = "",

	-- Step 18: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "{area:2742} 탑",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "남서쪽으로 돌아가 {area:2738}의 {area:2742} 탑으로 가세요. 탑에 올라 딱딱한 실리시드 조각을 노리고 나타나는 잠복꾼을 처치하세요.",

	-- Step 19: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {zone:1450} Moonglade
	["{npc:13220}'s next task goes to {zone:1450}: skip it."] = "",

	-- Step 20: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "은둔자는 {area:2738} 남동쪽 바위 사이에 숨어 있습니다.",
	["Below ground"] = "지하",

	-- Step 21: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "브론즈비어드 야영지",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand south-east of the camp, where Deathclasp, an elite scorpid, patrols: grab it while he is away."] = "남서쪽으로 남쪽 산맥 근처의 드워프 야영지에 가서 {npc:15171}와(과) {npc:15170}에게 물어보세요. {npc:15190}의 가방은 야영지 남동쪽 모래 속에 있는데, 그곳에는 정예 전갈 Deathclasp이(가) 순찰합니다. 그가 자리를 비운 사이에 챙기세요.",

	-- Step 22: Brann Bronzebeard's Lost Letter
	-- {area:2742} Hive'Ashi · {npc:15170} Rutgar Glyphshaper
	["From a {area:2742} silithid: for {npc:15170} at Bronzebeard's Encampment"] = "",

	-- Step 24: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	-- was: ["Careful: the Twilight Keepers are level 60, a level or two over you: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "주의: 황혼의 문지기는 60레벨로 1~2레벨 높습니다. 각 문지기 주변의 이교도를 먼저 처리하고 생명력이 가득 찬 상태에서 싸우세요.\n{npc:11803}은(는) 남서쪽 끝의 이교도 야영지를 지키고 있습니다."
	["Careful: the Twilight Keepers are level 60: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "",

	-- Step 25: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp.\nCareful: Mayna is level 60: clear her camp first and fight her at full health."] = "서쪽을 따라 북쪽으로 마이나의 작은 야영지로 가세요.\n주의: 마이나는 60레벨입니다. 야영지를 먼저 정리하고 생명력이 가득 찬 상태에서 싸우세요.",

	-- Step 26: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}.\nCareful: Havunth is level 60: clear his camp first and fight him at full health."] = "하분스의 야영지는 {area:3425} 바로 서쪽에 있습니다.\n주의: 하분스는 60레벨입니다. 야영지를 먼저 정리하고 생명력이 가득 찬 상태에서 싸우세요.",

	-- Step 27: Hermit Ortell
	["Ride back south-east to the hermit."] = "남동쪽으로 은둔자에게 돌아가세요.",
	["Hand him the ten texts you kept"] = "보관해 둔 문서 10개를 그에게 건네세요",

	-- Step 28: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 29: Level 60
	["Level 60"] = "60레벨",
	-- {area:3425} Cenarion Hold · {area:2057} Scholomance · {area:2279} Stratholme · {area:3197} Chillwind Camp · {area:2268} Light's Hope Chapel · {zone:1451} Silithus
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger · Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["{area:3425}'s last hand-ins can leave a player who followed only this route short of 60 (up to about a level for the slowest; most players less).\nWith a group: run the {area:2057} dungeon or the {area:2279} dungeon, in the Plaguelands by {area:3197} and {area:2268}.\nAlone: the Twilight's Hammer camps of {zone:1451}'s north-west (Twilight Avengers 57-59 and Geolords 58-60; leave the Flamereavers, 60) and the Stonelash Flayers and Rock Stalkers (57-59) around {area:3425} are at your level. {area:3425}'s repeatable quests open only at 60."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal"] = "안돌할",
	-- ["Angerclaw bears and Felpaw wolves"] = "성난발톱곰과 악령발늑대",
	-- ["Araj is elite: grouping up is advised."] = "아라즈는 정예이니 파티를 권합니다.",
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "다시 {area:1770}(으)로: 가장 깊은 방에서 {npc:9861}와(과) {npc:9860}이(가) {npc:9517}을(를) 지킵니다.",
	-- ["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",
	-- ["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "주의: 59레벨 정예 Ancient Irontree Walker가 {quest:5086} 사이에 서 있습니다. 야영지 북동쪽 끝(약 50.6,22.4)의 소산물을 하나씩 처치하고, 끌어오기 전마다 보행자가 있는지 살피십시오.",
	-- ["Careful: the Twilight Keepers are level 60, a level or two over you: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "주의: 황혼의 문지기는 60레벨로 1~2레벨 높습니다. 각 문지기 주변의 이교도를 먼저 처리하고 생명력이 가득 찬 상태에서 싸우세요.\n{npc:11803}은(는) 남서쪽 끝의 이교도 야영지를 지키고 있습니다.",
	-- ["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "분화구 한가운데의 {area:537}에 올라, {item:12359} 2개를 가방에 넣은 채 꼭대기 용암 호수 옆에서 {item:14644}을(를) 사용하세요. 마루 주변 웅덩이의 {npc:6557}에게 {npc:9616}의 {item:11953}을(를) 채우세요.",
	-- ["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "{npc:1855}의 오두막 동쪽의 강을 건너 {area:2627}에 들어가세요. {npc:11140}은(는) 아우구스투스의 폐허가 된 오두막 옆에 서 있습니다.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "{npc:11741}은(는) 돌아가는 길의 {area:2743}와(과) {area:3425} 사이 모래언덕을 돌아다닙니다. {npc:15181}은(는) 58레벨부터 {quest:8304}을(를) 줍니다.",
	-- ["Fly from {area:541} to {area:392}."] = "{area:541}에서 {area:392}(으)로 비행하십시오.",
	-- ["Fly to {area:150}"] = "{area:150}(으)로 비행",
	-- ["Fly to {area:1537}"] = "{area:1537}(으)로 비행",
	-- ["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- ["Fly to {area:3137}"] = "{area:3137}(으)로 날아가기",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "{area:16}의 {area:3137}(으)로 날아간 뒤 길을 따라 서쪽으로 {zone:1440} 경계를 막 넘은 {area:2358}까지 가세요.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "{zone:1447}의 {area:3137}(으)로 날아간 뒤 길을 따라 서쪽으로 {zone:1440} 경계를 막 넘은 {area:2358}까지 가세요.",
	-- ["Fly to {area:442}"] = "{area:442}(으)로 비행",
	-- ["Fly to {area:976}"] = "{area:976}(으)로 날아가기",
	-- ["Fly to {area:976}."] = "{area:976}(으)로 날아가세요.",
	-- ["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "{area:976}(으)로 날아가세요. {quest:5801}에 쓸 토륨 주괴 2개를 이곳 경매장에서 사세요.",
	-- ["Fly to {zone:1453}"] = "{zone:1453}로 비행",
	-- ["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north.\nCareful: Ancient Irontree Walkers, level 59 elites, stand among the treants in the middle of {area:1767}: take the Stompers on the north side (about 48,21)."] = "길을 따라 북쪽 {area:1767}(으)로 가세요. 무쇠나무 발구르미가 심장을 가지고 있습니다. 발톱은 북쪽의 성난발톱불곰과 지옥발 약탈자에게서 마저 모으세요.\n주의: 59레벨 정예인 고대 무쇠나무 파수꾼이 {area:1767} 한가운데의 나무정령 사이에 서 있습니다. 발구르미는 북쪽(약 48,21)에서 처치하세요.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "고개에서 길을 따라 남서쪽 {area:3425}(으)로 가세요.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "{npc:9298}의 안내를 따라 서리망치거인들을 지나 {area:2256} 입구로 가세요. 거인은 하나씩 지나가세요.",
	-- ["For {npc:10778}: keep it"] = "{npc:10778}에게 줄 것: 보관하세요",
	-- ["For {npc:11053} at {area:3197}, at the end of this guide"] = "이 가이드 마지막에 {area:3197}의 {npc:11053}에게 가져갑니다",
	-- ["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "{area:3137}에서 {zone:1448}(으)로 들어가세요. {area:2479}은(는) {zone:1440} 경계를 막 지난 길가의 드루이드 야영지입니다.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "{area:702}(으)로 내려가 배를 타고 {area:442}(으)로, 다시 배를 타고 {area:17203}(으)로 가세요. {npc:14722}에게 줄 비단 옷감 60장, 마법 옷감 60장, {item:14047} 60장을 가져가세요. 부족한 것은 경매장에서 사세요.",
	-- ["Grind to 58"] = "58레벨까지 사냥",
	-- ["Grind to 59"] = "59레벨까지 사냥",
	-- ["Grind to 60"] = "60레벨까지 사냥",
	-- ["Havunth's camp sits just west of {area:3425}."] = "하분스의 야영지는 {area:3425} 바로 서쪽에 있습니다.",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "{area:1519}(으)로 귀환해 60레벨 주문을 배우세요. 레벨업 경로는 여기서 끝납니다. 다음으로 평판과 던전 가이드를 보세요.",
	-- ["Irontree Stompers"] = "{npc:7139}",
	-- ["Its jars are filled on the Un'Goro visit"] = "단지는 운고로 방문 때 채웁니다",
	-- ["Keep the {item:11169}, the claws and the heart he hands back"] = "그가 돌려주는 {item:11169}, 발톱, 심장은 보관하세요",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "길을 따라 계속 서쪽으로 온천 옆 {npc:9298}의 야영지로 가세요.",
	-- ["Lots of flying between zones"] = "지역 간 비행이 많음",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "마차 주변의 보급품을 줍고, 근처 올빼미야수에게서 {npc:10301}의 목걸이를 되찾으세요.",
	-- ["Portal to {zone:1438}"] = "{zone:1438}행 차원문",
	-- ["Ride back south along the road to the Sanctuary."] = "길을 따라 남쪽으로 성소에 돌아가세요.",
	-- ["Ride back south-west to {area:3197}."] = "남서쪽으로 {area:3197}에 돌아가세요.",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "{area:3137}(으)로 돌아가 {area:2255}(으)로 날아가세요.",
	-- ["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "동쪽 언덕으로 가세요. {item:11169}을(를) 사용해 {quest:4005}을(를) 소환한 뒤 처치해 토템을 얻으세요.",
	-- ["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "동쪽으로 {area:2738}의 폐허로 가세요. {object:179565}은(는) 무너진 건물 사이에 있으며 {npc:12179}이(가) 지키고 있습니다.",
	-- ["Ride north along the west side to Mayna's small camp."] = "서쪽을 따라 북쪽으로 메이나의 작은 야영지에 가세요.",
	-- ["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "북쪽으로 {area:1769} 동굴 입구 옆 마른가지일족 펄볼그 마을로 가세요.",
	-- ["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "북쪽 {area:2277}의 북동쪽 가장자리로 가십시오.\n주의: {area:2273}(으)로 가는 길의 트롤은 57-59레벨입니다. 생명력이 낮아지면 도망쳐 도움을 청하므로 종종 다른 몹을 끌고 옵니다.",
	-- ["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "북쪽으로 {area:541}까지 가세요. {npc:10977} 옆에서 {npc:10980}을(를) 사용하세요.",
	-- ["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "길을 따라 북쪽의 제재소로 가서 한가운데에 흰개미 통을 내려놓으세요.",
	-- ["Ride north-west up the road to {area:2253}."] = "길을 따라 북서쪽 {area:2253}(으)로 가세요.",
	-- ["Ride south out of {zone:1448} toward {area:3137}: {npc:3848}'s camp at {area:2358} is just over the {zone:1440} border, on the way."] = "{zone:1448}에서 남쪽 {area:3137} 방향으로 가십시오. {npc:3848}의 {area:2358} 야영지는 가는 길, {zone:1440} 경계 바로 너머에 있습니다.",
	-- ["Ride south-east from the lake to the chapel."] = "호수에서 남동쪽 예배당으로 가십시오.",
	-- ["Ride south-east to {area:201}: {npc:11078} guards the cauldron, and {item:12955} lies east of the barn."] = "남동쪽으로 {area:201}까지 가세요. {npc:11078}이(가) 가마솥을 지키고 있고, {item:12955}은(는) 헛간 동쪽에 있습니다.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "남서쪽 {area:2261}(으)로 가십시오. 흙더미는 안에 있습니다. {npc:11886}은(는) 정예이므로 파티를 권장합니다.\n주의: 머큐시오와 함께 정예가 아닌 몹 약 넷이 나옵니다. 그 자리에 나타나지 않고 무덤까지 걸어옵니다.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "남서쪽으로 {area:1938}의 {npc:7771} 야영지로 가세요.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "분화구 북쪽 벽을 따라 서쪽으로 가서, 북서쪽 구석의 {zone:1451}(으)로 올라가는 고개로 가세요.",
	-- ["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "파티라면 사냥 대신 {area:2057}({area:28} 남동쪽 {area:2298})이나 {area:2279}을(를) 도는 편이 더 빠릅니다. 혼자 사냥하려면 이 단계를 건너뛰세요.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "파티라면 사냥 대신 {area:2057}({zone:1422} 남동쪽 {area:2298})이나 {area:2279}을(를) 도는 편이 더 빠릅니다. 혼자 사냥하려면 이 단계를 건너뛰세요.",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "파티라면 사냥 대신 {zone:1444}의 {area:2577}을(를) 도는 편이 더 빠릅니다. 혼자 사냥하려면 이 단계를 건너뛰세요.",
	-- ["Scourge Champions"] = "스컬지 용사",
	-- ["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "{npc:8529}(59)은(는) {area:2268} 북쪽 {area:2270}을(를) 돌아다닙니다. 처치할 때마다 {npc:11063}의 {item:13156}을(를) 갖다 대세요. 공명하는 해골이 그가 원하는 것입니다. 하나씩 끌어오세요.",
	-- ["Shaman training"] = "주술사 수련",
	-- ["Stays on the main route"] = "주요 경로에 머무름",
	-- ["Take the boat from {area:442} to {area:702}."] = "{area:442}에서 배를 타고 {area:702}(으)로 가세요.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "{area:2361}에서 비행 경로를 타고 {area:442}(으)로 날아가세요.",
	-- ["Take the portal up to {zone:1457}."] = "차원문을 타고 {zone:1457}(으)로 올라가세요.",
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "길을 따라 서쪽 분화구로 내려가 남쪽의 실리시드 동굴인 {area:540}으로 가세요. {npc:10041}이(가) 가장 깊은 방에서 기다립니다.",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "{npc:9298} 서쪽의 {area:618} 쪽 입구에서 {area:1769} 터널을 타고 {area:493} 갈림길을 따라 {area:2361}(으)로 가세요. {npc:11939}은(는) 호숫가에서 연구 중입니다.",
	-- ["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "{npc:9298} 서쪽의 {zone:1452} 쪽 입구에서 {area:1769} 터널을 타고 {area:493} 갈림길을 따라 {area:2361}(으)로 가세요. {npc:11939}은(는) 호숫가에서 연구 중입니다.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "{area:2257}을(를) 타고 {zone:1455}(으)로 가세요. {npc:14724}와(과) {npc:14723}은(는) 각각 양모 옷감 60장, 비단 옷감 60장, 마법 옷감 60장, 그다음 {item:14047} 60장을 원합니다. 종류별로 총 120장이며, 가방에 있는 것이나 경매장에서 구하세요.",
	-- ["Takes you all the way to 60"] = "60레벨까지 쭉 진행합니다",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "황혼의 망치단 발굴지가 북서쪽 구석을 채우고 있습니다. 서판 조각은 땅바닥에 있고, {npc:11744}와(과) {npc:11746}도 가지고 있습니다. 이교도는 누구나 {item:20404}을(를) 떨어뜨릴 수 있습니다. 20개를 보관하세요. 10개는 {npc:15306}에게, 10개는 나중에 {npc:15194}에게 줍니다.",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait."] = "황혼의 망치단 발굴지가 북서쪽 구석을 채우고 있습니다. 서판 조각은 땅바닥에 있고, {npc:11744}와(과) {npc:11746}도 가지고 있습니다. 이교도는 누구나 {item:20404}을(를) 떨어뜨릴 수 있습니다. 20개를 보관하세요. 10개는 {npc:15306}에게, 10개는 나중에 {npc:15194}에게 줍니다.\n주의: 문서는 {npc:11880}와(과) 지배자에게서 얻으세요. {npc:15201}(60)은(는) 피하고, {area:2742} 정예(59-60)가 기다리는 벌집 입구에는 들어가지 마세요.",
	-- ["The main route to 60: {zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands, with the hand-ins in {zone:1453}, {zone:1455} and {spell:437801} on the way."] = "60레벨까지의 주 경로: {zone:1451}, {zone:1448}, {zone:1452}와(과) 역병지대이며, 도중에 {zone:1453}, {zone:1455}, {spell:437801}에서 퀘스트를 제출합니다.",
	-- ["The {area:2479}"] = "{area:2479}",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "{npc:7446} 곰은 {area:2250} 남쪽의 눈 덮인 골짜기를 돌아다닙니다.",
	-- ["Theramore flight master"] = "테라모어 섬 비행 조련사",
	-- ["Toward the north-west pass"] = "북서쪽 고개 방향",
	-- ["Underwater"] = "물속",
	-- ["Upstairs"] = "위층",
	-- ["Use the jars on slain oozes"] = "처치한 수액괴물에게 단지를 사용하세요",
	-- ["Wait a moment for {npc:9116}"] = "{npc:9116}을(를) 잠시 기다리세요",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "이전 가이드에서 귀환석으로 돌아온 {area:392}에서 시작합니다. {area:415}(으)로 날아가세요.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "{zone:1451} {area:2743} 동쪽 모래언덕에서 {npc:11741} 사냥",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "{area:139} {area:2627}에서 {npc:14564} 사냥",
	-- ["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "{zone:1423} {area:2627}에서 {npc:14564} 사냥",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "{zone:1452} {area:2250} 남쪽 골짜기에서 {npc:7446} 사냥",
	-- ["{area:1770} braziers"] = "{area:1770} 화로",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770}은(는) 길 서쪽 {area:1763} 안쪽의 동굴입니다. 안에 있는 화로 네 개에 {item:12906}을(를) 사용하세요. 지나가며 만나는 성난발톱곰과 악령발늑대를 처치해 {item:11172}을(를) 모으세요.",
	-- ["{area:190} overlook"] = "{area:190} 전망 지점",
	-- ["{area:2057} (optional)"] = "{area:2057}(선택)",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057}은(는) 58-60레벨에 맞습니다. {quest:5505}은(는) 아래 {area:3197}에서 제출합니다.",
	-- ["{area:2577} (optional)"] = "{area:2577}(선택)",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577}은(는) 55-60레벨에 맞습니다. 아래의 {npc:7446} 사냥만으로도 혼자 59레벨까지 오를 수 있습니다.",
	-- ["{area:493} flight path on the way"] = "가는 길에 {area:493} 비행 경로",
	-- ["{area:541} flight master"] = "{area:541} 비행 조련사",
	-- ["{area:702} flight master"] = "{area:702} 비행 조련사",
	-- ["{area:976} flight master"] = "{area:976} 비행 조련사",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}, {npc:8529}에게서",
	-- ["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300}이(가) {area:2255} 남쪽 {area:2250}에서 기다립니다.\n{npc:10300}이(가) {object:177404}(으)로 가는 길에 횃불을 켜는 동안 그녀를 보호하세요.",
	-- ["{npc:10301}'s camp"] = "{npc:10301}의 야영지",
	-- ["{npc:10301}'s supplies"] = "{npc:10301}의 보급품",
	-- ["{npc:10667} in Andorhal: keep it"] = "안돌할의 {npc:10667}: 보관하세요",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667}은(는) 야영지 북쪽의 폐허 도시 안돌할 서쪽, 무너진 여관에서 기다립니다. {npc:1852}은(는) 마을 한가운데에서 성물함을 지킵니다.",
	-- ["{npc:10667} waits upstairs in the ruined inn on the west side of Andorhal, on the way back to {area:3197}."] = "{npc:10667}은(는) {area:3197}(으)로 돌아가는 길, 안돌할 서쪽의 폐허가 된 여관 위층에서 기다립니다.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "{npc:10778}의 유령은 안돌할 서쪽 {area:199}의 농가 옆을 떠돕니다. 들판의 {npc:10801}이(가) 부적의 나머지 반쪽을 가지고 있습니다. 두 반쪽을 합치세요.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn."] = "{area:493}의 비행 조련사 {npc:10897}은(는) 호수 남쪽, {area:2361} 밖에 있습니다. 그에게서 비행 경로를 배우세요. {area:2361} 안의 비행 조련사는 대화를 통해 드루이드만 태워 주며, 배울 비행 경로가 없습니다.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: {zone:1452}에서 끝납니다, 보관하세요",
	-- ["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, keep it"] = "예배당 남쪽 무덤 옆의 {npc:11038}: {npc:11140}은(는) {area:2627}에 있습니다. 보관하십시오",
	-- ["{npc:11053}: {area:201}'s cauldron, on this loop"] = "{npc:11053}: {area:201}의 가마솥, 이번 경로에서 처리",
	-- ["{npc:11556}'s {quest:8464} waited for this visit: the furbolg village lies just east of {area:2255}, with Shaman (56-57), Den Watchers (55-56) and Ursa (57-58). Kill the Shaman first, they heal. {npc:10738} in the cave at the back is elite: stay out."] = "{npc:11556}의 {quest:8464}은(는) 이번 방문을 위해 남겨 두었습니다. 펄볼그 마을은 {area:2255} 바로 동쪽에 있으며, 주술사(56-57), 동굴 감시자(55-56), 우르사(57-58)가 있습니다. 주술사는 치유하므로 먼저 처치하세요. 안쪽 동굴의 {npc:10738}은(는) 정예이니 들어가지 마세요.",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, {quest:6031} 30장이 있다면",
	-- ["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558}, 동굴 바로 안쪽: 이 주변을 돌아다닙니다. 지도의 원 안을 살펴보세요",
	-- ["{npc:11610} hides at the Northridge lumber camp's edge."] = "{npc:11610}은(는) 북마루 벌목지 가장자리에 숨어 있습니다.",
	-- ["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610}은(는) 벌목지 가장자리에 숨어 있습니다.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613}은(는) {npc:11610} 동쪽의 북마루 벌목지를 돌아다니고, {npc:11611}은(는) {area:190} 남쪽 진입로의 탑을 지킵니다.\n주의: 탑 아래에 경비병이 서 있고, 하나가 더 탑 주위를 순찰합니다. 두르겐과 싸우기 전에 처치해 싸움에 끼어들지 않게 하세요.",
	-- ["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "{npc:11801}의 집은 {area:2361}, {npc:11939}의 동쪽에 있습니다.",
	-- ["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803}이(가) 맨 남서쪽의 이교도 야영지를 지킵니다.",
	-- ["{npc:14722}, in the {object:2096}"] = "{npc:14722}, {object:2096} 안",
	-- ["{npc:15174}, the innkeeper"] = "여관주인 {npc:15174}",
	-- ["{npc:15181}: Bronzebeard's Encampment comes later, on the way south"] = "{npc:15181}: 브론즈비어드 야영지는 나중에 남쪽으로 가는 길에 들릅니다",
	-- ["{npc:15306}: his Twilight texts come from the dig after the next stop here"] = "{npc:15306}: 황혼의 문서는 이곳 다음 목적지인 발굴지에서 얻습니다",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, 얼라이언스 천막",
	-- ["{npc:1852} is a level 61 elite"] = "{npc:1852}은(는) 61레벨 정예입니다",
	-- ["{npc:1855} (optional)"] = "{npc:1855}(선택)",
	-- ["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855}은(는) 벌목지 북동쪽, 경계 강가의 작은 오두막에 삽니다. {quest:5781}을(를) 완료했다면 제출하세요.",
	-- ["{npc:332}, in SI:7"] = "{npc:332}, SI:7 안",
	-- ["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, {area:1658} 꼭대기",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}, 운하를 걸어다님",
	-- ["{npc:4155}, in the bank"] = "{npc:4155}, 은행 안",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: 이전 가이드가 귀환석으로 이곳에 데려오므로 보통 바로 완료됩니다",
	-- ["{npc:7740} in {zone:1457}: keep it"] = "{zone:1457}의 {npc:7740}: 보관하세요",
	-- ["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, 달의 신전 안",
	-- ["{npc:8496}, inside"] = "{npc:8496}, 내부",
	-- ["{npc:8737}, at the back of the refuge"] = "{npc:8737}, 야영지 안쪽",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598}이(가) {area:1767}에서 기다립니다. 숲 밖까지 그녀를 호위하고 살려 두세요.\n주의: 호위가 시작되고 곧 {quest:5086} 셋이 습격합니다.",
	-- ["{npc:9616}'s jars went to {zone:1455} on the {zone:1452} guide's {zone:1455} stop: fly straight to {area:976}."] = "{npc:9616}의 단지는 {zone:1452} 가이드의 {zone:1455} 방문 때 {zone:1455}에 전달했습니다. 바로 {area:976}(으)로 날아가세요.",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}, {area:618}에서 화주 병을 찾았다면",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085}: {area:618}의 {npc:9298}, 보관하세요",
	-- ["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {zone:1452}의 {npc:9298}, 보관하세요",
	-- ["{quest:5845}: the route takes it and fetches the Symbol, so its hand-in holds"] = "{quest:5845}: 경로에서 이 퀘스트를 받고 상징을 가져오므로 제출이 유지됩니다",
	-- ["{quest:6184} at {area:3197}: keep it"] = "{area:3197}의 {quest:6184}: 보관하세요",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}, {area:361}, {area:618}와(과) 역병지대",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452}와(과) 역병지대",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands."] = "{zone:1451}, {zone:1448}, {zone:1452}, 역병지대.",
	-- ["{zone:1453} has no shaman trainer"] = "{zone:1453}에는 주술사 상급자가 없습니다",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453}에는 주술사 상급자가 없습니다. {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 60레벨 주문을 배우세요.",
	-- ["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",
}
