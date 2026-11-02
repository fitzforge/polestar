-- Korean (koKR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "",

	-- Step 2: To Ratchet
	-- {area:392} Ratchet
	["To {area:392}"] = "",

	-- Step 4: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "{area:35}행 배",

	-- Step 5: Booty Bay
	-- {area:35} Booty Bay
	["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "배는 {area:35} 항구에 도착합니다. 퀘스트 제공자는 항구 주변 판자길과 여관에 있습니다.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}: for {quest:2864} in {area:976}; upstairs"] = "",
	["Inside"] = "",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}; on the top floor"] = "",

	-- Step 6: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 8: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "",

	-- Step 10: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "터널로 마을을 나가세요. 쪽지는 {area:35} 바로 북쪽의 해적 만에 있습니다.",

	-- Step 13: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",

	-- Step 14: Mistvale Valley: kill these as you meet them
	-- {area:1737} Mistvale Valley
	["{area:1737}: kill these as you meet them"] = "",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye · {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both.\nTake the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "",

	-- Step 16: The Bloodsail ships
	["The Bloodsail ships"] = "붉은해적단 배",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon · {quest:624} Cortello's Riddle
	["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "배 세 척은 {area:43} 앞바다에 있습니다. 선원은 42-45, 스틸워터는 45, 킬하울은 46, {npc:2546}은(는) 48레벨입니다. 41레벨에서는 파티용이거나 가이드 마지막에 할 싸움입니다. 간다면 헤엄쳐 가서 선원을 한 명씩 난간으로 끌어오세요. 배 갑판에 두루마리 {quest:624}이(가) 있습니다. 챙기세요.",
	-- {area:8} Swamp of Sorrows
	["for a later stop in the {area:8}"] = "",

	-- Step 17: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "길을 따라 {area:35}에서 북쪽으로 가세요. 운바그와는 길 동쪽 {area:1737}의 언덕에 앉아 있습니다.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "",

	-- Step 18: Mistvale gorillas
	["Mistvale gorillas"] = "안개계곡고릴라",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "고릴라는 운바그와 주변 골짜기를 돌아다닙니다. 덩치큰 고릴라가 내장을 떨어뜨리고, 모든 고릴라가 송곳니를 떨어뜨릴 수 있습니다.",

	-- Step 19: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "운바그와에게 송곳니를 건네고 곁에 있으세요. 그가 고릴라 세 무리를 부른 뒤 {npc:1514}을(를) 부릅니다. 한 번에 하나씩 싸우세요.",

	-- Step 21: Venture Co. mine
	["Venture Co. mine"] = "투자개발회사 광산",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "",

	-- Step 23: Nesingwary's camp
	["Nesingwary's camp"] = "",

	-- Step 24: Zul'Kunda
	["Zul'Kunda"] = "줄쿤다",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "원정대 서쪽, 줄쿤다의 폐허에 붉은머리부족 족장 {npc:1061}와(과) {npc:1062}이(가) 함께 서 있습니다. 먼저 호위병을 처치한 뒤 끌어오세요.",

	-- Step 25: Hearth to Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp
	["Hearth to {area:117}"] = "",

	-- Step 26: Grom'gol
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}, beside Nimboya"] = "",

	-- Step 27: Jungle stalkers
	["Jungle stalkers"] = "줄무늬정글랩터",
	-- {object:3202} Grom'gol
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "랩터는 {object:3202} 남쪽 정글에서 서쪽 해안 쪽으로 사냥합니다.",

	-- Step 28: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "해안을 따라 남쪽으로 가세요. 나가 탐험가가 물가를 걸어 다니며 갈대 묶음을 지니고 있습니다. {object:759}은(는) 그 바로 동쪽 언덕에서 솟아납니다.",

	-- Step 29: Booty Bay
	-- {area:35} Booty Bay
	["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "남쪽의 {area:35}(으)로 가세요. 겁쟁이 필립이 부두에서 기다립니다.",
	-- {npc:6807} Innkeeper Skindle
	["{npc:6807}, upstairs"] = "",

	-- Step 30: Zanzil's camps
	["Zanzil's camps"] = "잔질의 야영지",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "안개계곡 골짜기 북동쪽 정글에 잔질의 추종자들이 야영하고 있습니다. 누구나 혼합물을 지니고 있을 수 있습니다.",

	-- Step 31: Pirate ghosts
	["Pirate ghosts"] = "해적 유령",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "해적 유령 셋은 {area:35} 북쪽, 잔질의 야영지 근처 정글에 출몰합니다. {npc:2535}와(과) {npc:2536}은(는) 함께 있고, {npc:2537}은(는) 더 동쪽에 있습니다.",

	-- Step 32: Zul'Mamwe
	["Zul'Mamwe"] = "줄맘웨",
	-- {npc:1059} Ana'thek the Cruel
	["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "북쪽으로 투자개발회사 광산 동쪽의 백골가루부족 폐허로 가세요. 인간사냥꾼과 광전사를 한 번에 하나씩 끌어오세요. {npc:1059}은(는) 남서쪽 폐허를 지키고, 전리품 해골 더미 하나는 폐허 북쪽에 있습니다. 백골가루부족은 누구나 엄니나 목걸이를 떨어뜨릴 수 있습니다. 목걸이가 오래 걸리니, 모두 모을 때까지 폐허 북쪽 전사 야영지에서 계속 처치하세요.",
	["Skullsplitter warriors"] = "백골가루부족 전사",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",
	["Below ground"] = "",

	-- Step 33: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "",
	-- {object:3202} Grom'gol
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "",

	-- Step 34: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Ride west to {object:3202}."] = "서쪽의 {object:3202}(으)로 가세요.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",

	-- Step 36: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",

	-- Step 39: Nesingwary's Expedition
	["Ride north up the road to the hunters' camp."] = "길을 따라 북쪽의 사냥꾼 야영지로 가세요.",

	-- Step 41: Into the Swamp of Sorrows
	-- {area:8} Swamp of Sorrows
	["Into the {area:8}"] = "",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "계속 북쪽으로 {zone:1431}에 들어간 뒤, 길을 따라 동쪽으로 {zone:1430}을(를) 지나 늪으로 가세요. {npc:1776}은(는) {zone:1430}에서 들어오는 길 근처의 드레나이 야영지인 {area:657}에서 기다립니다.",

	-- Step 42: Stonard
	-- {area:75} Stonard
	["Ride east to {area:75}, in the reeds south of the road."] = "동쪽으로 길 남쪽 갈대밭의 {area:75}(으)로 가세요.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",

	-- Step 43: Stonard
	-- {area:75} Stonard
	["You start in {area:75}. Bind here: you hearth back after the coast."] = "",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "",
	-- {npc:6930} Innkeeper Karakul
	["{npc:6930}, upstairs"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 44: Monstrous Crawler Leg on the way
	-- {item:6184} Monstrous Crawler Leg
	["{item:6184} on the way"] = "",

	-- Step 45: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "톱니악어",
	-- {npc:5391} Galen Goodward · {area:75} Stonard · {npc:5592} Tok'Kar
	-- plural, as words: Shadow Panthers = {npc:768} Shadow Panther
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank.\nCareful: {npc:5592}'s camp sits by the coast. Along the way to it you pass level 40 spiders that chase a long distance, plus stealthed Shadow Panthers."] = "",

	-- Step 46: Fly to Booty Bay
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 47: Boat to Ratchet
	-- {area:392} Ratchet
	["Boat to {area:392}"] = "",

	-- Step 48: Riding at 40
	["Riding at 40"] = "",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Another race's trainer (Kildar in {zone:1454}) teaches you only once you are Exalted with his city."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "",

	-- Step 50: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "",

	-- Step 51: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "노보루는 {area:76} 남서쪽 빈터를 돌아다닙니다. 그의 곤봉이 퀘스트를 시작합니다.",

	-- Step 52: Draenethyst crystals
	["Draenethyst crystals"] = "드레니시스트 수정",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "북동쪽의 {area:76}(으)로 가세요. 수정은 {npc:5391}의 우리로 올라가는 길을 따라 있습니다.",

	-- Step 53: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391}은(는) 늪 북동쪽 {area:76}에 붙잡혀 있습니다. 풀어 주고 따라가며 그를 쫓는 늪 생물을 물리치세요.",

	-- Step 54: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "길을 따라 서쪽으로 {zone:1430}에서 들어오는 길 근처, {area:657}의 드레나이 야영지로 가세요.",

	-- Step 55: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}."] = "그의 금고는 {area:75} 북쪽의 옛 야영지에 있습니다.",

	-- Step 56: Misty Reed Post
	-- {area:75} Stonard
	["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "동쪽으로 {area:75}을(를) 지나 길을 따라 남동쪽 해안의 작은 호드 주둔지로 가세요.",

	-- Step 57: Sawtooth snappers
	["Sawtooth snappers"] = "무쇠턱 톱니악어",
	["The snappers line the strand south of the post."] = "무쇠턱 톱니악어는 주둔지 남쪽 해변에 늘어서 있습니다.",

	-- Step 58: Misty Reed Post
	-- {zone:1446} Tanaris
	["The next guide starts here and takes you to {zone:1446}.\nThe small Horde post on the southern shore."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:392}"] = "{area:392}(으)로 날아가기",
	-- ["From {area:2408} fly to {area:392}."] = "{area:2408}에서 {area:392}(으)로 날아가세요.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "더 북쪽, 길 동쪽 광산에서 투자개발회사 고블린이 채굴하고 있습니다. 광부, 현장감독, 감시관, 땜장이 모두 수정을 떨어뜨립니다.",
	-- ["Hearth to {area:35}"] = "귀환석으로 {area:35}에 가기",
	-- ["Hearth to {object:3202}"] = "귀환석으로 {object:3202}에 가기",
	-- ["Into the {zone:1435}"] = "{zone:1435}(으)로",
	-- ["Naga shore and the {object:759}"] = "나가 해안과 {object:759}",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "길을 따라 북쪽으로 가세요. 사냥꾼들은 강 위쪽 언덕에 야영하고 있습니다.",
	-- ["Ride north-west to {object:3202}."] = "북서쪽의 {object:3202}(으)로 가세요.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "무법항 남쪽, {area:43}에 붉은해적단 칼잡이가 야영하고 있습니다. 해도와 명령서는 천막 안에 있습니다. 붉은해적단은 누구나 코담배와 {npc:2493}의 눈을 지니고 있을 수 있으니, 둘 다 얻을 때까지 계속 처치하세요.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "{area:35}행 배는 {area:392} 부두 끝에 정박합니다.",
	-- ["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "악어는 {npc:5391}의 야영지 주변 웅덩이와 남쪽 {area:75} 쪽에서 뒹굴고 있습니다. 네 마리 중 한 마리 정도가 옆구리살을 떨어뜨립니다.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "마지막 해골은 {object:3202}(으)로 돌아가는 길에, 조금 서쪽의 폐허에 있습니다.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "다음 가이드는 여기서 시작해 {zone:1446}(으)로 안내합니다.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "다음 전리품 해골은 전사 야영지 바로 북쪽의 작은 폐허에 있습니다.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["for Stoley in {zone:1446}"] = "{zone:1446}의 스톨리에게",
	-- ["for a later stop in the {zone:1435}"] = "나중에 {zone:1435}에 들를 때",
	-- ["for later: the {zone:1425}, around level 48"] = "나중에: 48레벨쯤 {zone:1425}",
	-- ["the {object:2076}, beside {npc:2497}"] = "{npc:2497} 옆의 {object:2076}",
	-- ["{area:392} pier"] = "{area:392} 부두",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: {area:976}의 {quest:2864}에게",
}
