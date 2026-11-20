-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 2: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "在{object:172961}。",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "六十塊{item:14047}",

	-- Step 4: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飛往{area:431}",

	-- Step 5: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 6: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "飛往{area:431}，沿著道路向西北離開{zone:1440}進入{zone:1448}。{area:2479}就是過了邊界不遠的德魯伊營地。",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}，在裡面",
	-- {quest:4084} Silver Heart · {item:11172} Silvery Claws · {item:11173} Irontree Heart · {area:1767} Irontree Woods · {npc:9116} Eridan Bluewind
	["{quest:4084}'s {item:11172} and {item:11173} come from {area:1767} on this guide's ride north; {npc:9116} takes them at the end of the guide, back here."] = "",

	-- Step 7: Rakaiah
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {item:13140} Blood Red Key · {area:1763} Jaedenar
	["Only if {npc:11019} sent you after {npc:9518} (the {item:13140}'s chain): on the ride north, turn west into {area:1763}. {npc:9518} (56) stands by the remains of Trey Lightforge at the edge of the camp, well under you now; Trey's remains go back to {npc:11019} at the end of this guide."] = "",

	-- Step 8: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "沿著道路向北騎，經過{area:1763}，前往{area:1997}。",
	-- {npc:10306} Trull Failbane · {quest:4721} Wild Guardians · {area:2255} Everlook · {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{npc:10306}'s last {quest:4721} are the Berserk Owlbeasts north of {area:2255}, on this guide's {zone:1452} loop; he takes them at the end of the guide, back here."] = "",

	-- Step 9: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors · {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {item:11172} Silvery Claws · {npc:14524} Vartrus the Ancient
	-- plural, as words: Irontree Wanderers = {npc:7138} Irontree Wanderer · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet. The Irontree Wanderers and Stompers (52-53) there carry {npc:9116}'s {item:11173}, the Angerclaw bears and Felpaw wolves his {item:11172}.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "",

	-- Step 11: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "穿過木喉隧道前往{zone:1450}。{npc:11939}在{area:2361}的一間房子裡看書。",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939}在{area:2361}附近走動：看地圖上的圓圈裡",

	-- Step 13: Class trainer
	["Class trainer"] = "職業訓練師",

	-- Step 14: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "{npc:11801}的「魔藤碎片」需要{area:2577}。跳過。",

	-- Step 17: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "回到木喉隧道，從{zone:1452}出口出去；{npc:9298}就在出口外的溫泉旁紮營。",
	["From Krakle in Un'Goro, if you didn't bring it to her earlier"] = "",

	-- Step 18: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "信使三五成群地沿路從{area:1769}往{area:2244}走；在{npc:9298}附近的路邊等著，路過就殺。每人帶一個板條箱。\n注意：交任務會刷出三到四個56-57級的冬泉伏擊者攻擊你；騎馬、潛行或者用{spell:5384}都能甩掉，之後他們會聚在湖邊，方便你接下一個任務。",

	-- Step 19: Salfa
	-- {quest:8464} Winterfall Activity · {area:2255} Everlook · {area:2256} Darkwhisper Gorge
	["{quest:8464}'s village is north-east of {area:2255}, on this guide's way back from {area:2256}."] = "{quest:8464}的村莊在{area:2255}東北方，就在本指南從{area:2256}回來的路上。",

	-- Step 20: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "背包裡有30塊{quest:6031}時：沿著道路向北前往{area:1769}；{npc:11557}就在入口內交易。",
	["Below ground"] = "地下",

	-- Step 21: Kernda
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if you are Neutral with the Timbermaw now (the {area:1769} reputation guide gets you there): {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}在附近巡邏，請在地圖示示的圓圈內尋找",

	-- Step 22: Witch Doctor Mau'ari
	-- {area:2255} Everlook · {npc:11755} Harlo Wigglesworth · {npc:10307} Witch Doctor Mau'ari · {area:2249} Frostwhisper Gorge
	["Ride east along the road to {area:2255}: {npc:11755} sends you to {npc:10307}, who stands in the town, on the way to {area:2249}."] = "",

	-- Step 24: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	-- was: ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向東騎，然後沿著{area:2249}向南走。那裡的霜槌巨人是59級精英：走在中間並持續移動。奇怪的來源在南端的{area:2256}入口。"
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59-60: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "",

	-- Step 25: Frostmaul Shards
	-- {area:2249} Frostwhisper Gorge · {npc:10198} Kashoch the Reaver
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["The shards lie on the ground along the west side of {area:2249}, among the Frostmaul Giants and Preservers. Careful: the giants are elites of 59-60: pick up the shards that lie clear of them, wait for a patrol to pass, and leave {npc:10198} (60, east side) alone."] = "",

	-- Step 26: Level 59.7
	["Level 59.7"] = "",
	-- {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {npc:11556} Salfa · {npc:10306} Trull Failbane · {npc:9116} Eridan Bluewind · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to about level 59.7 before the last hand-ins: Umi, Vizzie, Mau'ari, {area:2244}, {npc:9298}, {npc:11556}, {npc:10306} and {npc:9116} take you the rest of the way to 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "刷{npc:7446}",

	-- Step 27: Ice Thistle yetis
	["Ice Thistle yetis"] = "冰薊雪人",
	-- {area:2255} Everlook · {item:258323} Missing Mail
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["On the ride north to {area:2255}, the Ice Thistle Yetis (55-56) in the hills south-east of the town carry Vizzie's {item:258323}: four pieces."] = "",

	-- Step 28: Are We There, Yeti?
	-- {area:2255} Everlook
	["Ride north to {area:2255}."] = "向北騎往{area:2255}。",
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "用{npc:10980}嚇唬{npc:10978}",

	-- Step 29: Everlook
	-- {npc:11118} Innkeeper Vizzie · {quest:93406} Unfrozen Deliveries
	["{npc:11118}, in the inn: {quest:93406}"] = "",

	-- Step 31: Winterfall Village
	-- {area:2255} Everlook · {quest:5121} High Chief Winterfall
	-- was: ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "熊怪村莊位於{area:2255}東北方的山谷。先殺薩滿；他們會治療。{npc:10738}（59級，精英）和贊迪維斯（62級）在後方的洞穴裡：別進去。"
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {quest:5121} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "",

	-- Step 32: Berserk Owlbeasts
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Berserk Owlbeasts"] = "",
	-- {area:2241} Frostsaber Rock · {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["The Berserk Owlbeasts (58-59) roam the slopes of {area:2241}, north of {area:2255} and west of the furbolg valley. Now and then an owlbeast drops a {item:12558}: use it to start {quest:4882}."] = "",

	-- Step 33: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west along the road to {area:2246}."] = "沿著道路向西騎回{area:2246}。",

	-- Step 34: High Chief Winterfall
	-- {npc:9298} Donova Snowden · {quest:5121} High Chief Winterfall · {area:2244} Winterfall Village · {area:2255} Everlook · {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["A group choice: {npc:9298} sends you after {quest:5121} (59, elite, with his guards) in the cave at the back of {area:2244}, back east past {area:2255}; Xandivious (62) shares the cave: leave him. The High Chief carries a log for {npc:9298}, and her next errand goes to {npc:10920} at the {area:2479}, this guide's last stop."] = "",
	-- {quest:5121} High Chief Winterfall
	["{quest:5121}, in the cave"] = "",
	["the log he carries"] = "",
	-- {npc:9298} Donova Snowden
	["{npc:9298}, back west at the hot springs"] = "",
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["for {npc:10920} at the {area:2479}"] = "",

	-- Step 35: Salfa
	-- {zone:1452} Winterspring
	["North of Donova, at the tunnel's {zone:1452} exit."] = "在多諾瓦北邊，隧道通往{zone:1452}的出口。",

	-- Step 36: Beads for Salfa
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity
	["{npc:11556} takes the beads only once {quest:8464} is handed in: any Winterfall furbolg can carry them, and the camps just south of {npc:11556} are the closest."] = "{npc:11556}要等{quest:8464}繳交後才收珠串：任何冬泉熊怪都可能帶著，{npc:11556}南邊的營地最近。",
	["Frostfire Winterfall camp"] = "冰火溫泉的冬泉營地",

	-- Step 38: Trull Failbane
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post
	["Back through the Timbermaw tunnel and south down the {zone:1448} road to {area:1997}."] = "",

	-- Step 39: Trull Failbane
	-- {quest:4882} Guarding Secrets · {item:12558} Blue-feathered Necklace
	["{quest:4882}, from the {item:12558}"] = "",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["{quest:4882} goes on to {npc:5770} in {zone:1456}, off this route: leave it."] = "",

	-- Step 40: Jessir Moonbow
	-- {area:2479} Emerald Sanctuary · {npc:11019} Jessir Moonbow
	["South along the road to the {area:2479}: {npc:11019}, at its east side, takes Trey Lightforge's remains."] = "",

	-- Step 41: Kelek Skykeeper
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["{npc:10920}, at the {area:2479}, takes the High Chief's words."] = "",

	-- Step 42: Eridan Bluewind
	-- {area:2479} Emerald Sanctuary
	["South along the road to the {area:2479}."] = "",
	-- {npc:9116} Eridan Bluewind · {zone:1446} Tanaris
	["{npc:9116}'s Aquementas leads on to {zone:1446} and Un'Goro: leave it."] = "",
	-- {zone:1454} Orgrimmar · {area:431} Splintertree Post
	["In {zone:1454}: fly from {area:431}"] = "",
	-- {zone:1456} Thunder Bluff
	["In {zone:1456}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "掉了一把{item:13140}：暗影堡的加德納爾執行者、暗織者、術士和軍團士兵偶爾會帶著。使用它開始任務，離開時順便把{npc:11018}從洞穴南端的籠子裡救出來。",
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "任何冬泉熊怪都可能帶著珠串；{npc:11556}南邊的營地最近。",
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "回到木喉隧道，從{area:618}出口出去；{npc:9298}就在出口外的溫泉旁紮營。",
	-- ["Back south to the Sanctuary, a short ride."] = "向南回到聖地，路程很短。",
	-- ["Corrupted Soul Shards from the cultists, {quest:5887}"] = "從教徒身上取得腐化的靈魂碎片，{quest:5887}",
	-- ["Dungeon instead of grinding"] = "以地城代替練等",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "飛往{area:431}，沿著道路向西北離開{zone:1440}進入{area:361}。{area:2479}就是過了邊界不遠的德魯伊營地。",
	-- ["From Krakle in Un'Goro"] = "來自安戈洛的克拉蘭克",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "從{zone:1458}出發，在城外的塔搭飛艇前往{zone:1454}。",
	-- ["Grind to 60"] = "練到60級",
	-- ["In {zone:1454}: fly from {area:2255}"] = "在{zone:1454}：從{area:2255}飛過去",
	-- ["In {zone:1456}: fly from {area:2255}"] = "在{zone:1456}：從{area:2255}飛過去",
	-- ["Level 59.9"] = "59.9級",
	-- ["On the way back south to Greta, {npc:9529} takes the shards on the west side of the Sanctuary."] = "在向南返回葛瑞塔的路上，到聖地西側把碎片交給{npc:9529}。",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "僅限你帶著{quest:5087}時：信使們成小群從{area:1769}沿著道路走向{area:2244}；在{npc:9298}附近的路旁等候，趁他們經過時擊殺。每個信使都帶著一個箱子。",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "僅限{npc:9298}給了你{quest:5086}時：沿著{area:361}的道路向北騎往{area:1767}；{quest:5086}在樹林間蠕動。",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "可選。和小隊打{area:2279}、{area:2057}、黑石塔下層或{area:1584}代替練等，能更快達到目標。",
	-- ["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "可選：有小隊的話，一個55-60級地城可以取代下面的練等。",
	-- ["Ride back west to {area:2246}."] = "向西騎回{area:2246}。",
	-- ["Ride east along the road to {area:2255}."] = "沿著道路向東騎往{area:2255}。",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向東騎，然後沿著{area:2249}向南走。那裡的霜槌巨人是59級精英：走在中間並持續移動。奇怪的來源在南端的{area:2256}入口。",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "向西北騎往{area:1763}。四個火盆位於教徒的建築之間；對每個火盆使用淨化過的水。\n小心：洞穴裡滿是53-55級的暗影議會怪物，常常成群連動，很多會擊暈。建議2-3人組隊。",
	-- ["South to the Sanctuary once more."] = "再次向南前往聖地。",
	-- ["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then: she waits at the tunnel mouth of {area:1769} and speaks to you from Neutral with the Timbermaw, which the Deadwood furbolgs of {zone:1448} brought you to."] = "{area:1762}的死木圖騰，如果當時{npc:11558}沒收：她在{area:1769}的隧道口等著，只要木喉聲望達到中立就會跟你說話——這個聲望是你在{zone:1448}打死木熊怪刷出來的。",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "熊怪村莊位於{area:2255}東北方的山谷。先殺薩滿；他們會治療。{npc:10738}（59級，精英）和贊迪維斯（62級）在後方的洞穴裡：別進去。",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "任務到這裡就沒了。瘋狂的碎齒熊在{area:618}南部、{area:2255}出來的道路南邊的{area:2249}徘徊。",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "任務到這裡就沒了。瘋狂的碎齒熊在{zone:1452}南部、{area:2255}出來的道路南邊的{area:2249}徘徊。",
	-- ["The zeppelin towers"] = "飛艇塔",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "穿過木喉隧道前往{area:493}。{npc:11939}在{area:2361}的一間房子裡看書。",
	-- ["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "在{zone:1452}交任務之前，在這裡補到59.9級：那些任務會把你帶到60級。{area:2249}的狂怒碎牙（59級）就在奇異源頭以北，經驗比{area:1769}邊的熊怪高得多。或者組隊去刷{area:2057}地城或{area:2279}地城。",
	-- ["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "在{area:618}的{area:2249}擊殺{npc:7446}練等",
	-- ["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "在{zone:1452}的{area:2249}擊殺{npc:7446}練等",
	-- ["only if still carried: the {zone:1423} guide hands it in on its way through"] = "只有在還帶著時：{zone:1423}指南會在途中繳交它",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "{npc:10306}接下來的{quest:4741}會讓你從{area:618}跑回這裡。跳過。",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "{npc:10306}接下來的{quest:4741}會讓你從{zone:1452}跑回這裡。跳過。",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "{npc:9116}的「銀爪鐵心」需要{area:361}北部的{item:11173}，還要騎回這裡。跳過。",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "{npc:9116}的「銀爪鐵心」需要{zone:1448}北部的{item:11173}，還要騎回這裡。跳過。",
	-- ["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298}接著會派你去對付洞穴裡的精英{npc:10738}。跳過。",
	-- ["{npc:9529} stands on the west side of the Sanctuary, the way out to {area:1763}. With {quest:4102} done, her {quest:5887} asks for six Corrupted Soul Shards: the Shadow Council cultists in {area:1763} and {area:1770} drop them about one kill in three, and you fight dozens of them for {npc:10922}."] = "{npc:9529}站在聖地西側，也就是前往{area:1763}的出口。完成{quest:4102}後，她的{quest:5887}需要六個腐化的靈魂碎片：{area:1763}和{area:1770}的暗影議會教徒大約每殺三個掉落一個，而你為了{npc:10922}要打上幾十個。",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}、{npc:9860}和{npc:9517}在{area:1763}北部洞穴{area:1770}的深處等候。沿途清理隧道。\n小心：三名首領會一起戰鬥。先殺掉附近的怪，以免多拉到敵人。",
}
