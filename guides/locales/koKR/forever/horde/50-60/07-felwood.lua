-- Korean (koKR): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 2: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "{object:172961}에 있습니다.",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "",

	-- Step 4: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "{area:431}(으)로 날아가기",

	-- Step 5: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 6: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "{area:431}(으)로 날아간 뒤 길을 따라 북서쪽으로 달려 {zone:1440}에서 {zone:1448}(으)로 가세요. {area:2479}은(는) 경계를 막 지난 곳의 드루이드 야영지입니다.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, 내부",
	-- {quest:4084} Silver Heart · {item:11172} Silvery Claws · {item:11173} Irontree Heart · {area:1767} Irontree Woods · {npc:9116} Eridan Bluewind
	["{quest:4084}'s {item:11172} and {item:11173} come from {area:1767} on this guide's ride north; {npc:9116} takes them at the end of the guide, back here."] = "",

	-- Step 7: Rakaiah
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {item:13140} Blood Red Key · {area:1763} Jaedenar · {area:1770} Shadow Hold
	["Only if {npc:11019} sent you after {npc:9518} (the {item:13140}'s chain): on the ride north, turn west into {area:1763} and go into {area:1770}, the cave at the back of the camp. {npc:9518} (56) and the remains of Trey Lightforge are inside: kill her first, then the remains take her quest and give the next, which goes back to {npc:11019} at the end of this guide."] = "",

	-- Step 9: Trull Failbane
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "길을 따라 북쪽으로 {area:1763}을(를) 지나 {area:1997}(으)로 가세요.",

	-- Step 10: Bloodvenom Post
	-- {npc:10306} Trull Failbane · {quest:4721} Wild Guardians · {area:2255} Everlook · {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{npc:10306}'s last {quest:4721} are the Berserk Owlbeasts north of {area:2255}, on this guide's {zone:1452} loop; he takes them at the end of the guide, back here."] = "",

	-- Step 11: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors · {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {item:11172} Silvery Claws · {npc:14524} Vartrus the Ancient
	-- plural, as words: Irontree Wanderers = {npc:7138} Irontree Wanderer · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet. The Irontree Wanderers and Stompers (52-53) there carry {npc:9116}'s {item:11173}, the Angerclaw bears and Felpaw wolves his {item:11172}.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "",

	-- Step 13: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "나무구렁일족 동굴을 지나 {zone:1450}(으)로 가세요. {npc:11939}은(는) {area:2361}의 한 집에서 책을 읽고 있습니다.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939}이(가) {area:2361} 주변을 돌아다닙니다: 지도에서 원 안을 보세요",

	-- Step 15: Class trainer
	["Class trainer"] = "직업 전문가",

	-- Step 16: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "{npc:11801}의 악령덩굴 조각은 {area:2577}이(가) 필요합니다. 건너뛰세요.",

	-- Step 19: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "다시 나무구렁일족 동굴로 들어가 {zone:1452} 쪽 출구로 나가세요. {npc:9298}은(는) 바로 밖 온천 옆에 있습니다.",
	["From Krakle in Un'Goro, if you didn't bring it to her earlier"] = "",

	-- Step 20: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 21: Salfa
	-- {quest:8464} Winterfall Activity · {area:2255} Everlook · {area:2256} Darkwhisper Gorge
	["{quest:8464}'s village is north-east of {area:2255}, on this guide's way back from {area:2256}."] = "{quest:8464}의 마을은 {area:2255} 북동쪽, 이 가이드에서 {area:2256}에서 돌아오는 길에 있습니다.",

	-- Step 22: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "가방에 {quest:6031} 30개가 있다면: 길을 따라 북쪽 {area:1769}(으)로 가세요. {npc:11557}이(가) 입구 바로 안에서 거래합니다.",
	["Below ground"] = "지하",

	-- Step 23: Kernda
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if you are Neutral with the Timbermaw now (the {area:1769} reputation guide gets you there): {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}이(가) 이 주변을 배회합니다. 지도 원 안을 살펴보세요.",

	-- Step 24: Witch Doctor Mau'ari
	-- {area:2255} Everlook · {npc:11755} Harlo Wigglesworth · {npc:10307} Witch Doctor Mau'ari · {area:2249} Frostwhisper Gorge
	["Ride east along the road to {area:2255}: {npc:11755} sends you to {npc:10307}, who stands in the town, on the way to {area:2249}."] = "",

	-- Step 26: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	-- was: ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "동쪽으로 간 뒤 남쪽으로 {area:2249}을(를) 내려가세요. 그곳의 서리망치거인은 59레벨 정예입니다. 가운데로 다니며 멈추지 마세요. 이상한 근원은 남쪽 끝, {area:2256} 입구에 있습니다."
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59-60: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "",

	-- Step 27: Frostmaul Shards
	-- {area:2249} Frostwhisper Gorge · {npc:10198} Kashoch the Reaver
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["The shards lie on the ground along the west side of {area:2249}, among the Frostmaul Giants and Preservers. Careful: the giants are elites of 59-60: pick up the shards that lie clear of them, wait for a patrol to pass, and leave {npc:10198} (60, east side) alone."] = "",

	-- Step 28: Level 59.7
	["Level 59.7"] = "",
	-- {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {npc:11556} Salfa · {npc:10306} Trull Failbane · {npc:9116} Eridan Bluewind · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to about level 59.7 before the last hand-ins: Umi, Vizzie, Mau'ari, {area:2244}, {npc:9298}, {npc:11556}, {npc:10306} and {npc:9116} take you the rest of the way to 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "{npc:7446} 사냥",

	-- Step 29: Ice Thistle yetis
	["Ice Thistle yetis"] = "얼음엉겅퀴설인",
	-- {area:2255} Everlook · {item:258323} Missing Mail
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["On the ride north to {area:2255}, the Ice Thistle Yetis (55-56) in the hills south-east of the town carry Vizzie's {item:258323}: four pieces."] = "",

	-- Step 30: Are We There, Yeti?
	-- {area:2255} Everlook
	["Ride north to {area:2255}."] = "북쪽 {area:2255}(으)로 가세요.",
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "",

	-- Step 31: Everlook
	-- {npc:11118} Innkeeper Vizzie · {quest:93406} Unfrozen Deliveries
	["{npc:11118}, in the inn: {quest:93406}"] = "",

	-- Step 33: Winterfall Village
	-- {area:2255} Everlook · {quest:5121} High Chief Winterfall
	-- was: ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "털보숭이 마을은 {area:2255} 북동쪽 골짜기에 있습니다. 치유하는 주술사를 먼저 처치하세요. {npc:10738}(59, 정예)과 잔디비우스(62)는 안쪽 동굴에 있으니 들어가지 마세요."
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {quest:5121} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "",

	-- Step 34: Berserk Owlbeasts
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Berserk Owlbeasts"] = "",
	-- {area:2241} Frostsaber Rock · {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["The Berserk Owlbeasts (58-59) roam the slopes of {area:2241}, north of {area:2255} and west of the furbolg valley. Now and then an owlbeast drops a {item:12558}: use it to start {quest:4882}."] = "",

	-- Step 35: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west along the road to {area:2246}."] = "길을 따라 서쪽 {area:2246}(으)로 돌아가세요.",

	-- Step 36: High Chief Winterfall
	-- {npc:9298} Donova Snowden · {quest:5121} High Chief Winterfall · {area:2244} Winterfall Village · {area:2255} Everlook · {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["A group choice: {npc:9298} sends you after {quest:5121} (59, elite, with his guards) in the cave at the back of {area:2244}, back east past {area:2255}; Xandivious (62) shares the cave: leave him. The High Chief carries a log for {npc:9298}, and her next errand goes to {npc:10920} at the {area:2479}, this guide's last stop."] = "",
	-- {quest:5121} High Chief Winterfall
	["{quest:5121}, in the cave"] = "",
	["the log he carries"] = "",
	-- {npc:9298} Donova Snowden
	["{npc:9298}, back west at the hot springs"] = "",
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["for {npc:10920} at the {area:2479}"] = "",

	-- Step 37: Salfa
	-- {zone:1452} Winterspring
	["North of Donova, at the tunnel's {zone:1452} exit."] = "도노바 북쪽, 동굴의 {zone:1452} 출구에 있습니다.",

	-- Step 38: Beads for Salfa
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity
	["{npc:11556} takes the beads only once {quest:8464} is handed in: any Winterfall furbolg can carry them, and the camps just south of {npc:11556} are the closest."] = "{npc:11556}은(는) {quest:8464}을(를) 제출한 뒤에야 구슬을 받습니다. 눈사태일족 털보숭이는 누구나 구슬을 지니고 있을 수 있으며, {npc:11556} 바로 남쪽 야영지가 가장 가깝습니다.",
	["Frostfire Winterfall camp"] = "얼음불꽃 눈사태일족 야영지",

	-- Step 40: Trull Failbane
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post
	["Back through the Timbermaw tunnel and south down the {zone:1448} road to {area:1997}."] = "",

	-- Step 41: Trull Failbane
	-- {quest:4882} Guarding Secrets · {item:12558} Blue-feathered Necklace
	["{quest:4882}, from the {item:12558}"] = "",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["{quest:4882} goes on to {npc:5770} in {zone:1456}, off this route: leave it."] = "",

	-- Step 42: Jessir Moonbow
	-- {area:2479} Emerald Sanctuary · {npc:11019} Jessir Moonbow
	["South along the road to the {area:2479}: {npc:11019}, at its east side, takes Trey Lightforge's remains."] = "",

	-- Step 43: Kelek Skykeeper
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["{npc:10920}, at the {area:2479}, takes the High Chief's words."] = "",

	-- Step 44: Eridan Bluewind
	-- {area:2479} Emerald Sanctuary
	["South along the road to the {area:2479}."] = "",
	-- {npc:9116} Eridan Bluewind · {zone:1446} Tanaris
	["{npc:9116}'s Aquementas leads on to {zone:1446} and Un'Goro: leave it."] = "",
	-- {zone:1454} Orgrimmar · {area:431} Splintertree Post
	["In {zone:1454}: fly from {area:431}"] = "",
	-- {zone:1456} Thunder Bluff
	["In {zone:1456}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "{item:13140}이(가) 나왔습니다. 그림자 요새의 자에데나르 집행자, 암흑술사, 흑마법사, 군단병이 가끔 지니고 있습니다. 사용해서 퀘스트를 시작한 뒤, 나가는 길에 동굴 남쪽 끝 우리에서 {npc:11018}을(를) 풀어 주세요.",
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "눈사태일족 털보숭이는 누구나 구슬을 지니고 있을 수 있습니다. {npc:11556} 바로 남쪽 야영지가 가장 가깝습니다.",
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "다시 나무구렁일족 동굴로 들어가 {area:618} 쪽 출구로 나가세요. {npc:9298}은(는) 바로 밖 온천 옆에 있습니다.",
	-- ["Back south to the Sanctuary, a short ride."] = "남쪽 성소로 돌아가세요. 금방입니다.",
	-- ["Corrupted Soul Shards from the cultists, {quest:5887}"] = "사교도에게서 오염된 영혼석 조각, {quest:5887}",
	-- ["Dungeon instead of grinding"] = "사냥 대신 던전",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "{area:431}(으)로 날아간 뒤 길을 따라 북서쪽으로 달려 {zone:1440}에서 {area:361}(으)로 가세요. {area:2479}은(는) 경계를 막 지난 곳의 드루이드 야영지입니다.",
	-- ["From Krakle in Un'Goro"] = "운고로 분화구의 크래클에게서",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "{zone:1458}에서 도시 밖 탑의 비행선을 타고 {zone:1454}(으)로 가세요.",
	-- ["Grind to 60"] = "60까지 사냥",
	-- ["In {zone:1454}: fly from {area:2255}"] = "{zone:1454}에서: {area:2255}에서 비행",
	-- ["In {zone:1456}: fly from {area:2255}"] = "{zone:1456}에서: {area:2255}에서 비행",
	-- ["On the way back south to Greta, {npc:9529} takes the shards on the west side of the Sanctuary."] = "남쪽의 그레타에게 돌아가는 길에 성소 서쪽의 {npc:9529}에게 조각을 건네세요.",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "{quest:5087}이(가) 있을 때만: 정찰꾼들이 작은 무리로 {area:1769}에서 {area:2244}(으)로 길을 걷습니다. {npc:9298} 근처 길가에서 기다렸다가 지나갈 때 처치하세요. 각자 상자를 하나씩 들고 있습니다.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "{npc:9298}에게 {quest:5086}을(를) 받았을 때만: {area:361} 길을 따라 북쪽 {area:1767}(으)로 가세요. {quest:5086}이(가) 나무 사이를 떠돕니다.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "선택 사항. 사냥 대신 파티로 {area:2279}, {area:2057}, 검은바위 첨탑 하층, {area:1584}을(를) 돌면 더 빨리 도달합니다.",
	-- ["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "선택 사항: 파티가 있으면 55-60 던전으로 아래 사냥을 대신하세요.",
	-- ["Ride back west to {area:2246}."] = "서쪽의 {area:2246}(으)로 돌아가세요.",
	-- ["Ride east along the road to {area:2255}."] = "길을 따라 동쪽 {area:2255}(으)로 가세요.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "동쪽으로 간 뒤 남쪽으로 {area:2249}을(를) 내려가세요. 그곳의 서리망치거인은 59레벨 정예입니다. 가운데로 다니며 멈추지 마세요. 이상한 근원은 남쪽 끝, {area:2256} 입구에 있습니다.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "북서쪽 {area:1763}(으)로 가세요. 화로 네 개가 어둠의 의회 건물들 사이에 있습니다. 각 화로에 정화된 물을 사용하세요.\n주의: 53-55레벨 어둠의 의회 몹이 동굴에 가득하며, 연결된 큰 무리로 오는 경우가 많고 기절 기술을 쓰는 몹도 많습니다. 2-3인 파티를 권장합니다.",
	-- ["South to the Sanctuary once more."] = "다시 남쪽 성소로 가세요.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "털보숭이 마을은 {area:2255} 북동쪽 골짜기에 있습니다. 치유하는 주술사를 먼저 처치하세요. {npc:10738}(59, 정예)과 잔디비우스(62)는 안쪽 동굴에 있으니 들어가지 마세요.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "여기서 퀘스트가 끝납니다. 광포한 톱니이빨곰이 {area:618} 남쪽, {area:2255}에서 오는 길 남쪽의 {area:2249}을(를) 돌아다닙니다.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "여기서 퀘스트가 끝납니다. 광포한 톱니이빨곰이 {zone:1452} 남쪽, {area:2255}에서 오는 길 남쪽의 {area:2249}을(를) 돌아다닙니다.",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "나무구렁일족 동굴을 지나 {area:493}(으)로 가세요. {npc:11939}은(는) {area:2361}의 한 집에서 책을 읽고 있습니다.",
	-- ["Trey Lightforge's remains lie at the edge of the {area:1763} camp, west of the road: they go back to {npc:11019} at the end of this guide."] = "트레이 라이트포지의 유해는 길 서쪽 {area:1763} 야영지 가장자리에 있습니다: 이 가이드가 끝날 때 {npc:11019}에게 돌아갑니다.",
	-- ["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "{area:618}, {area:2249}에서 {npc:7446} 사냥",
	-- ["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "{zone:1452}, {area:2249}에서 {npc:7446} 사냥",
	-- ["only if still carried: the {zone:1423} guide hands it in on its way through"] = "아직 가지고 있을 때만: {zone:1423} 가이드가 지나가는 길에 제출합니다",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "{npc:10306}의 다음 퀘스트 {quest:4741}은(는) {area:618}에서 여기로 다시 와야 합니다. 건너뛰세요.",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "{npc:10306}의 다음 퀘스트 {quest:4741}은(는) {zone:1452}에서 여기로 다시 와야 합니다. 건너뛰세요.",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, 지하",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "{npc:9116}의 은색 심장은 {area:361} 북쪽의 {item:11173}을(를) 가지고 여기로 돌아와야 합니다. 건너뛰세요.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "{npc:9116}의 은색 심장은 {zone:1448} 북쪽의 {item:11173}을(를) 가지고 여기로 돌아와야 합니다. 건너뛰세요.",
	-- ["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298}은(는) 다음으로 동굴 속 정예인 {npc:10738}을(를) 처치하라고 보냅니다. 건너뛰세요.",
	-- ["{npc:9529} stands on the west side of the Sanctuary, the way out to {area:1763}. With {quest:4102} done, her {quest:5887} asks for six Corrupted Soul Shards: the Shadow Council cultists in {area:1763} and {area:1770} drop them about one kill in three, and you fight dozens of them for {npc:10922}."] = "{npc:9529}은(는) 성소 서쪽, {area:1763}(으)로 나가는 길목에 서 있습니다. {quest:4102}을(를) 완료했다면 그녀의 {quest:5887}에서 오염된 영혼석 조각 여섯 개를 요구합니다. {area:1763}와(과) {area:1770}의 어둠의 의회 사교도가 대략 세 마리에 하나꼴로 떨어뜨리며, {npc:10922}의 퀘스트를 위해 어차피 수십 마리를 상대하게 됩니다.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}, {npc:9860}, {npc:9517}은(는) {area:1763} 북쪽 동굴인 {area:1770} 안쪽 끝에 있습니다. 가는 길에 통로를 정리하세요.\n주의: 세 우두머리는 함께 싸웁니다. 몹을 더 끌어오지 않도록 근처 몹부터 처치하세요.",
}
