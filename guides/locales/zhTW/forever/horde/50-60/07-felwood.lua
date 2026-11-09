-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tirisfal Glades
	["The zeppelin towers"] = "",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 4: Zeppelin to Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "從{zone:1458}出發，在城外的塔搭飛艇前往{zone:1454}。",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "",

	-- Step 6: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "",

	-- Step 7: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 8: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "飛往{area:431}，沿著道路向西北離開{zone:1440}進入{zone:1448}。{area:2479}就是過了邊界不遠的德魯伊營地。",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "{npc:9116}的「銀爪鐵心」需要{zone:1448}北部的{item:11173}，還要騎回這裡。跳過。",

	-- Step 9: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "",
	["Below ground"] = "",

	-- Step 10: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "向南回到聖地，路程很短。",

	-- Step 11: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "沿著道路向北騎，經過{area:1763}，前往{area:1997}。",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "{npc:10306}接下來的{quest:4741}會讓你從{zone:1452}跑回這裡。跳過。",

	-- Step 12: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",

	-- Step 13: Greta Mosshoof
	["South to the Sanctuary once more."] = "再次向南前往聖地。",

	-- Step 14: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet."] = "",

	-- Step 16: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "穿過木喉隧道前往{zone:1450}。{npc:11939}在{area:2361}的一間房子裡看書。",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "",

	-- Step 18: Class trainer
	["Class trainer"] = "",

	-- Step 19: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "{npc:11801}的「魔藤碎片」需要{area:2577}。跳過。",

	-- Step 22: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "回到木喉隧道，從{zone:1452}出口出去；{npc:9298}就在出口外的溫泉旁紮營。",
	["From Krakle in Un'Goro"] = "來自安戈洛的克拉蘭克",

	-- Step 23: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 25: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "任何冬泉熊怪都可能帶著珠串；{npc:11556}南邊的營地最近。",
	["Frostfire Winterfall camp"] = "冰火溫泉的冬泉營地",

	-- Step 27: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "",

	-- Step 28: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only at Neutral with the Timbermaw: {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 30: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向東騎，然後沿著{area:2249}向南走。那裡的霜槌巨人是59級精英：走在中間並持續移動。奇怪的來源在南端的{area:2256}入口。",

	-- Step 31: Level 59.9
	["Level 59.9"] = "",
	-- {zone:1452} Winterspring · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "",

	-- Step 32: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "向西騎回{area:2246}。",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298}接著會派你去對付洞穴裡的精英{npc:10738}。跳過。",

	-- Step 33: Are We There, Yeti?
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "",

	-- Step 34: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "沿著道路向東騎往{area:2255}。",

	-- Step 35: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "以地城代替練等",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "可選。和小隊打{area:2279}、{area:2057}、黑石塔下層或{area:1584}代替練等，能更快達到目標。",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "可選：有小隊的話，一個55-60級地城可以取代下面的練等。",

	-- Step 36: Grind to 60
	["Grind to 60"] = "練到60級",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "任務到這裡就沒了。瘋狂的碎齒熊在{zone:1452}南部、{area:2255}出來的道路南邊的{area:2249}徘徊。",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "在{zone:1452}的{area:2249}擊殺{npc:7446}練等",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "在{zone:1454}：從{area:2255}飛過去",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "在{zone:1456}：從{area:2255}飛過去",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "回到木喉隧道，從{area:618}出口出去；{npc:9298}就在出口外的溫泉旁紮營。",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "飛往{area:431}，沿著道路向西北離開{zone:1440}進入{area:361}。{area:2479}就是過了邊界不遠的德魯伊營地。",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "從{zone:1458}出發，在城外的塔搭飛艇前往{zone:1454}。",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "僅限你帶著{quest:5087}時：信使們成小群從{area:1769}沿著道路走向{area:2244}；在{npc:9298}附近的路旁等候，趁他們經過時擊殺。每個信使都帶著一個箱子。",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "僅限{npc:9298}給了你{quest:5086}時：沿著{area:361}的道路向北騎往{area:1767}；{quest:5086}在樹林間蠕動。",
	-- ["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "僅限持有30塊{quest:6031}，且木喉聲望為中立時：沿著道路向北前往{area:1769}；{npc:11557}就在入口內交易。",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "向西北騎往{area:1763}。四個火盆位於教徒的建築之間；對每個火盆使用淨化過的水。",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "任務到這裡就沒了。瘋狂的碎齒熊在{area:618}南部、{area:2255}出來的道路南邊的{area:2249}徘徊。",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "穿過木喉隧道前往{area:493}。{npc:11939}在{area:2361}的一間房子裡看書。",
	-- ["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "在{area:618}的{area:2249}擊殺{npc:7446}練等",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "{npc:10306}接下來的{quest:4741}會讓你從{area:618}跑回這裡。跳過。",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "{npc:9116}的「銀爪鐵心」需要{area:361}北部的{item:11173}，還要騎回這裡。跳過。",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}、{npc:9860}和{npc:9517}在{area:1763}北部洞穴{area:1770}的深處等候。沿途清理隧道。",
}
