-- Korean (koKR): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "비행선 타고 {zone:1454}(으)로",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "{zone:1458}에서 도시 밖 탑의 비행선을 타고 {zone:1454}(으)로 가세요.",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "{area:431}(으)로 날아간 뒤 길을 따라 북서쪽으로 달려 {zone:1440}에서 {zone:1448}(으)로 가세요. {area:2479}은(는) 경계를 막 지난 곳의 드루이드 야영지입니다.",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "{npc:9116}의 은색 심장은 {zone:1448} 북쪽의 {item:11173}을(를) 가지고 여기로 돌아와야 합니다. 건너뛰세요.",

	-- Step 3: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "북서쪽 {area:1763}(으)로 가세요. 화로 네 개가 어둠의 의회 건물들 사이에 있습니다. 각 화로에 정화된 물을 사용하세요.",

	-- Step 4: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "남쪽 성소로 돌아가세요. 금방입니다.",

	-- Step 5: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860}, {npc:9517}은(는) {area:1763} 북쪽 동굴인 {area:1770} 안쪽 끝에 있습니다. 가는 길에 통로를 정리하세요.",

	-- Step 6: Greta Mosshoof
	["South to the Sanctuary once more."] = "다시 남쪽 성소로 가세요.",

	-- Step 7: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "길을 따라 북쪽으로 {area:1763}을(를) 지나 {area:1997}(으)로 가세요.",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "{npc:10306}의 다음 퀘스트 {quest:4741}은(는) {zone:1452}에서 여기로 다시 와야 합니다. 건너뛰세요.",

	-- Step 8: Toxic Horrors
	-- {npc:9298} Donova Snowden · {quest:5086} Toxic Horrors · {zone:1448} Felwood · {area:1767} Irontree Woods
	["Only if {npc:9298} gave you {quest:5086}: ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees."] = "{npc:9298}에게 {quest:5086}을(를) 받았을 때만: {zone:1448} 길을 따라 북쪽 {area:1767}(으)로 가세요. {quest:5086}이(가) 나무 사이를 떠돕니다.",

	-- Step 9: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "{quest:6031} 30개가 있고 나무구렁일족과 중립일 때만: 길을 따라 북쪽 {area:1769}(으)로 가세요. {npc:11557}이(가) 입구 바로 안에서 거래합니다.",

	-- Step 10: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "나무구렁일족 동굴을 지나 {zone:1450}(으)로 가세요. {npc:11939}은(는) {area:2361}의 한 집에서 책을 읽고 있습니다.",

	-- Step 11: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "{npc:11801}의 악령덩굴 조각은 {area:2577}이(가) 필요합니다. 건너뛰세요.",

	-- Step 13: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "다시 나무구렁일족 동굴로 들어가 {zone:1452} 쪽 출구로 나가세요. {npc:9298}은(는) 바로 밖 온천 옆에 있습니다.",

	-- Step 14: Winterfall Runners
	-- {quest:5087} Winterfall Runners · {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden
	["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "{quest:5087}이(가) 있을 때만: 정찰꾼들이 작은 무리로 {area:1769}에서 {area:2244}(으)로 길을 걷습니다. {npc:9298} 근처 길가에서 기다렸다가 지나갈 때 처치하세요. 각자 상자를 하나씩 들고 있습니다.",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298}은(는) 다음으로 동굴 속 정예인 {npc:10738}을(를) 처치하라고 보냅니다. 건너뛰세요.",

	-- Step 15: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "길을 따라 동쪽 {area:2255}(으)로 가세요.",

	-- Step 16: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "사냥 대신 던전",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "선택 사항. 사냥 대신 파티로 {area:2279}, {area:2057}, 검은바위 첨탑 하층, {area:1584}을(를) 돌면 더 빨리 도달합니다.",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "선택 사항: 파티가 있으면 55-60 던전으로 아래 사냥을 대신하세요.",

	-- Step 17: Grind to 60
	["Grind to 60"] = "60까지 사냥",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "여기서 퀘스트가 끝납니다. 광포한 톱니이빨곰이 {zone:1452} 남쪽, {area:2255}에서 오는 길 남쪽의 {area:2249}을(를) 돌아다닙니다.",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "{zone:1452}, {area:2249}에서 {npc:7446} 사냥",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "{zone:1454}에서: {area:2255}에서 비행",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "{zone:1456}에서: {area:2255}에서 비행",
}
