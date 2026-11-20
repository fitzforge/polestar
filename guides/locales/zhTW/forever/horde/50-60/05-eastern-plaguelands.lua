-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "進入{zone:1423}",

	-- Step 2: Tirion Fordring
	-- {zone:1423} Eastern Plaguelands · {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east along the road into the {zone:1423}. {npc:1855} lives in a small house by the {area:2619}, just north of the road at the border; his three hunts are on this guide's ground."] = "沿道路向東騎進{zone:1423}。{npc:1855}住在{area:2619}旁的小屋，就在邊界處道路北邊不遠；他的三個狩獵任務都在本指南的範圍內。",

	-- Step 4: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "沿著道路從{zone:1422}向東走，過河並穿越整個{zone:1423}，抵達最東邊{object:92525}的禮拜堂。",

	-- Step 5: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}的鬼魂站在西南方{area:2262}的廢墟中。",

	-- Step 6: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "娃娃的頭和兩側身體散落在{npc:10926}周圍的房屋裡；在背包中把它們組合起來。",
	["Inside"] = "在裡面",

	-- Step 7: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "給{area:2268}的{npc:11063}的口信",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "保留{quest:5152}：{npc:10927}住在{zone:1422}的{area:197}。",

	-- Step 8: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "被放逐者札爾達爾潛伏在{area:2262}西邊不遠處。",
	["Below ground"] = "地下",

	-- Step 9: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "小心：{npc:10411}脫離戰鬥時會隱形，戰鬥一開始就會召喚石翼石像鬼。總共只有3隻，每15分鐘重生一次。",

	-- Step 10: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "返回{area:2268}",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "{quest:5211}的靈魂會在本指南稍後前往{area:2264}時處理：先留著。",

	-- Step 11: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飛往{area:272}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "{area:2268}飛行管理員",

	-- Step 12: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "前往{area:197}",

	-- Step 13: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "從{area:272}沿道路向北騎。{npc:10927}的房子在{area:197}的路旁，{npc:10936}的紀念碑在房子後面的墓地裡。",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}，在樓上",

	-- Step 14: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "向西北騎進安多哈爾。{npc:10667}在城鎮西側的旅店廢墟裡等著；裡面的骷髏是54-57級，所以沿著邊緣走。",
	["Upstairs"] = "樓上",

	-- Step 15: The Annals of Darrowshire
	-- {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room."] = "編年史在安多哈爾市政廳的發黴的書籍之間；逐一打開直到找到正確的那本。\n小心：58-59級的精英{npc:10996}可能出現在安多哈爾，{zone:1422}的許多其他地點也一樣：和它保持距離。",

	-- Step 17: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "飛往{area:2268}",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "向南騎回{area:272}，再飛往{area:2268}。",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "{area:272}飛行管理員",

	-- Step 18: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "{quest:5168}的物品在之後的瘟疫之地區域：先留著。",

	-- Step 19: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}：遇到這些就殺",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. Careful: the biggest Plaguehounds are 56, pull them one at a time.\nThe shattered sword lies on the ground north-west of the lake."] = "瘟疫犬和牠們的幼犬在禮拜堂西南方的湖岸遊蕩；瘟疫蝙蝠和腐肉蟲也在同一區域。小心：最大的瘟疫犬是56級，一次只拉一隻。\n破碎的劍在湖的西北方地上。",

	-- Step 20: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft · {npc:8564} Ranger
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His {npc:8564} hunt, in the north of the zone, waits for the next guide's Plaguelands trip."] = "{npc:15193}的勇士守在{area:2261}北邊的{area:2260}農舍。他的{npc:8564}狩獵任務在地區北部，留到下一份指南再去瘟疫之地時處理。",
	-- plural, as words: Rangers = {npc:8564} Ranger
	["keep it: the Rangers (59-60) wait for the next guide's second ride into the north"] = "先留著：遊俠（59-60級）留到下一份指南第二次北上時處理",

	-- Step 21: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "瘟疫幼犬和瘟疫蝙蝠在{area:2260}北邊的丘陵遊蕩，腐肉蟲在牠們之間爬行；一路向北往{area:2627}推進。",

	-- Step 22: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut."] = "鬼魂{npc:11140}站在西北角{area:2627}的一間小屋旁；{npc:12384}坐在小屋裡。",
	-- {npc:12384} Augustus the Touched
	["{npc:12384}, inside"] = "{npc:12384}，在裡面",

	-- Step 23: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}：遇到就擊殺",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound · Ziggurat Protectors = {npc:12262} Ziggurat Protector
	["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass.\nCareful: Ziggurat Protectors (58, elite) stand by the ziggurats east and north-east of the town: take the mounds nearer the town and stay clear of them."] = "書在{area:2627}的旅店廢墟裡；鎮上的不死生物是54-56級，所以一次只拉一隻。\n大白蟻丘遍布{area:2627}東邊的丘陵。經過每個蟻丘時都使用{item:15042}。\n小心：通靈塔保衛者（58級精英）站在城鎮東邊和東北邊的通靈塔旁：選靠近城鎮的蟻丘，離它們遠一點。",
	-- {quest:5510} Minion's Scourgestones · {area:2627} Terrordale · {item:12846} Argent Dawn Commission
	["{quest:5510}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5510}：裝備{item:12846}時，{area:2627}的不死生物會掉落",

	-- Step 24: Augustus the Touched
	-- {npc:11615} Mickey Levine · {area:813} Bulwark · {zone:1422} Western Plaguelands
	["Keep the termites: {npc:11615} at the {area:813} takes them on the next guide's ride into the {zone:1422}."] = "留著白蟻：下一份指南前往{zone:1422}時，交給{area:813}的{npc:11615}。",

	-- Step 25: Nathanos Blightcaller's bats
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}'s bats"] = "",
	-- {npc:11878} Nathanos Blightcaller · {area:2272} Northdale
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["East of Terrordale, the Noxious Plaguebats (54-56) count for {npc:11878}. Take the ones in the open fields; leave the Monstrous Plaguebats near {area:2272} for later."] = "",

	-- Step 26: Before Northdale
	-- {area:2272} Northdale
	["Before {area:2272}"] = "",
	-- {quest:5543} Blood Tinged Skies · {quest:5544} Carrion Grubbage · {npc:1855} Tirion Fordring · {area:2627} Terrordale · {area:2272} Northdale
	-- plural, as words: Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["The next hunt is too high. At 55, if you still have {quest:5543} or {quest:5544}, the ordinary Plaguebats and Carrion Grubs on the western hills count for {npc:1855}. No need to stay and farm bats. Resume at 56 on the road east from {area:2627} for the {area:2272} hunt."] = "",

	-- Step 27: Level 56
	["Level 56"] = "等級56",
	-- {area:2627} Terrordale
	-- plural, as words: Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["Almost 56? The Noxious Plaguebats (54-56) in the open fields east of {area:2627} can finish the level. If you'd rather quest, other XP counts too; a group can also run Lower Blackrock Spire."] = "",
	-- {npc:8601} Noxious Plaguebat
	["grind on {npc:8601}"] = "刷{npc:8601}",

	-- Step 28: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}：遇到這些就殺",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	-- was: ["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "狂怒的瘟疫犬分布在{area:2273}南邊的{area:2272}和{area:2271}周圍田野；毒性瘟疫蝙蝠在北部田野上空飛行，巨型瘟疫蝙蝠則在{area:2272}和{area:2271}附近。小心：瘟疫犬是57-58級，最大的巨型瘟疫蝙蝠是58級：一次只拉一隻。"
	["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time.\nStill 56? Take level 57 hounds and level 56-57 bats; leave the level 58s."] = "",

	-- Step 29: Eastern Plaguelands: kill these as you meet them
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "頭骨在{area:2622}，周圍有荒蕪水元素和瘟疫水元素。",
	["Underwater"] = "在水下",

	-- Step 30: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "沿道路向南騎到{area:2264}。{item:15447}十分鐘內就會腐壞：快速擊殺鎮上的天譴軍團，並立刻用{item:15454}磨碎七份。\n小心：無影僕從的生命值降到40%時，會向25碼內的同伴求救。脫離戰鬥時，牠們還會用{spell:10228}隱形。如果在鎮內發生求救，可能會有大量怪物加入戰鬥。在城鎮外圍戰鬥可以降低這個風險。\n如果任務日誌中有{quest:5211}（來自本指南開頭的{npc:11063}），鎮子周圍的天譴軍團會留下達隆郡居民的靈魂：和每一個交談來解放它們。在開始收集{item:15447}之前先解放它們。",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "解放達隆郡之魂：和它們交談",

	-- Step 31: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "向西騎到{area:2260}。",

	-- Step 33: Class trainer
	["Class trainer"] = "職業訓練師",
	-- {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- was: ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "用爐石回{zone:1454}：爐石仍是{zone:1447}指南時綁定在那裡的（法師可以傳送）。起飛前先學習技能。"
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1413} guide (Mages teleport). Train before the flight."] = "",

	-- Step 34: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "飛往{area:1997}",
	-- {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- was: ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "用爐石回{zone:1454}：爐石仍是{zone:1447}指南時綁定在那裡的（法師可以傳送）。然後找飛行管理員。"
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1413} guide (Mages teleport). Then the flight master."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 35: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- was: ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "用爐石回{zone:1454}：爐石仍是{zone:1447}指南時綁定在那裡的。然後找飛行管理員。"
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1413} guide. Then the flight master."] = "",

	-- Step 36: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033}（德魯伊）在{area:1639}訓練，{npc:246344}（聖騎士）也在城裡。",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}的{npc:3033}；{npc:246344}",

	-- Step 37: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飛行管理員",

	-- Step 39: Deadwood Cauldron
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "沿道路向北騎。大鍋在{area:1769}西南方不遠的{area:1762}；那裡的死木熊怪是敵對的。",

	-- Step 40: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "只有在掉落了{quest:8471}時：{npc:11558}在{area:1769}的{zone:1448}入口等著，而且只有在你對木喉熊怪為中立時才會和你交談。",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}在這裡一帶走動：看地圖圓圈內",

	-- Step 41: Faustron
	-- {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:12740} Faustron
	["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:12740}, the Horde's flight master, stands by the tunnel's {area:493} exit: take his flight path on the way past."] = "",

	-- Step 43: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["{npc:11801} is in {area:2361}, the village in the middle of the valley."] = "",

	-- Step 44: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "兩個任務都通往{zone:1451}：先留著。",

	-- Step 46: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["From the tunnel's {zone:1452} exit, ride south to {area:2246}."] = "從隧道的{zone:1452}出口向南騎到{area:2246}。",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086}在{zone:1448}，之後的行程再去：先留著。",

	-- Step 47: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "月光梟獸",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	-- was: ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "向東騎到{area:2255}再向北出城；月光梟獸在{area:2241}南坡的丘陵遊蕩。小心：牠們是57-58級：一次只拉一隻。\n小心：60級精英Hailspite聚集在{area:2255}東南方的雪原上，那裡也有少數月光梟獸遊蕩：待在城鎮北邊的山坡上。"
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town.\nAt 56, take the level 57 owlbeasts rather than the 58s."] = "",

	-- Step 48: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "完美的雪人角",
	-- {area:2255} Everlook
	-- was: ["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "烏米的角，延續上次在{area:2255}接的任務：雪人丘陵就在{area:2255}東南方不遠。只有女族長和族長會掉角，而族長最高58級：一次只拉一隻。"
	["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time.\nAt 56, stick to yetis no higher than 57."] = "",

	-- Step 49: Umi Rumplesnicker
	-- {area:976} Gadgetzan · {area:2255} Everlook
	["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it for later."] = "烏米的第三個惡作劇目標是{area:976}、安戈洛和{area:2255}的哥布林：先留著之後再做。",
	-- {area:2255} Everlook · {zone:1451} Silithus · {area:976} Gadgetzan · {zone:2482} Mount Hyjal
	["{area:2255} is this guide's last stop. The {zone:1451} guide flies on to {area:976}; choose {zone:2482} only if you have help crossing the gorge south of town. Elites line the road."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "一張撕破的卷軸在{area:2260}南邊的地穴{area:2261}入口。",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "回到隧道，走{area:618}出口，然後向南騎到{area:2246}。",
	-- ["Back through the tunnel and take the {zone:1452} exit: {npc:11556} stands right where it comes out."] = "回到隧道，走{zone:1452}出口：{npc:11556}就站在出口處。",
	-- ["Back to {area:1638}"] = "返回{area:1638}",
	-- ["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "在{area:976}東邊不遠的墓地喝下{item:11243}：你會死亡，只有變成鬼魂才看得到{npc:9299}，他在墓地正北方丘陵的岩縫裡。在那裡和他交談，然後跑回屍體復活：他要你去找的顯眼的墓碑就在那座墓地裡。",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "飛往{zone:1458}，搭飛艇到{zone:1454}，再飛往{area:1638}。",
	-- ["Fly to {area:1099}"] = "飛往{area:1099}",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "飛往{area:1099}。角鷹獸巢在{zone:1444}南部；每個巢都有一顆蛋可放進{object:142071}。",
	-- ["Fly to {area:541}"] = "飛往{area:541}",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "飛往{area:541}，然後向西南騎過安戈洛環形山，穿過山口進入{zone:1451}。下一份指南從山口出口的{area:3077}開始。",
	-- ["Fly to {area:976}"] = "飛往{area:976}",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "狂怒的瘟疫犬和巨型瘟疫蝙蝠共同分布在{area:2273}南邊、{area:2272}和{area:2271}周圍的田野。",
	-- ["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "狂怒的瘟疫犬分布在{area:2273}南邊的{area:2272}和{area:2271}周圍田野；毒性瘟疫蝙蝠在北部田野上空飛行，巨型瘟疫蝙蝠則在{area:2272}和{area:2271}附近。小心：瘟疫犬是57-58級，最大的巨型瘟疫蝙蝠是58級：一次只拉一隻。",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "穿過{area:1769}，走隧道通往{area:493}的支線。{npc:11801}在{area:2361}。",
	-- ["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "穿過{area:1769}，走隧道通往{zone:1450}的支線。{npc:11801}在{area:2361}。",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "滲透者哈米亞躲在東北角{area:2273}的爛苔食人妖之間。",
	-- ["Hameya's mound"] = "哈米亞的土堆",
	-- ["Hameya's scroll"] = "哈米亞的卷軸",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "用爐石回{zone:1454}：爐石仍是{zone:1447}指南時綁定在那裡的（法師可以傳送）。然後找飛行管理員。",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "用爐石回{zone:1454}：爐石仍是{zone:1447}指南時綁定在那裡的（法師可以傳送）。起飛前先學習技能。",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "用爐石回{zone:1454}：爐石仍是{zone:1447}指南時綁定在那裡的。然後找飛行管理員。",
	-- ["Hippogryph eggs"] = "角鷹獸蛋",
	-- ["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "在裡面：{quest:4493}，如果你在{zone:1447}指南時於{zone:1454}接了它",
	-- ["On to {zone:1451}"] = "前往{zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "在{area:1641}。背包裡要帶著毛料、絲綢和魔紋布。",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "只有在你仍帶著{quest:2741}時：從{area:1099}往南騎；角鷹獸巢在{zone:1444}南部，每個巢都有一顆蛋可放進超級蛋蛋機。",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "瘟疫犬和瘟疫幼犬在禮拜堂西南方的湖岸邊遊蕩。",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "向東騎到{area:2255}再向北出城；月光梟獸在{area:2241}南坡的丘陵遊蕩。小心：牠們是57-58級：一次只拉一隻。\n小心：60級精英Hailspite聚集在{area:2255}東南方的雪原上，那裡也有少數月光梟獸遊蕩：待在城鎮北邊的山坡上。",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "向東騎到{area:2255}再向北出城；月光梟獸在{area:2241}南坡的丘陵遊蕩。一次只拉一隻。\n小心：60級精英Hailspite聚集在{area:2255}東南方的雪原上，那裡也有少數月光梟獸遊蕩：待在城鎮北邊的山坡上。",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "從小屋沿道路向南騎到{area:2264}。{item:15447}十分鐘內就會腐壞：快速擊殺鎮上的天譴軍團，並立刻用{item:15454}磨碎七份。\n小心：隱形僕從的生命值降到40%時，會向25碼內的同伴求救。脫離戰鬥時，牠們還會用{spell:10228}隱形。如果在鎮內發生求救，可能會有大量怪物加入戰鬥。在城鎮外圍戰鬥可以降低這個風險。\n如果任務日誌中有{quest:5211}（來自安戈洛指南結尾的{npc:11063}），鎮子周圍的天譴軍團會留下達隆郡之魂：和每一個交談來解放它們。在開始收集{item:15447}之前先解放它們。",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "從小屋沿道路向南騎到{area:2264}。{item:15447}十分鐘內就會腐壞：快速擊殺鎮上的天譴軍團，並立刻用{item:15454}磨碎七份。\n小心：隱形僕從的生命值降到40%時，會向25碼內的同伴求救。脫離戰鬥時，牠們還會用{spell:10228}隱形。如果在鎮內發生求救，可能會有大量怪物加入戰鬥。在城鎮外圍戰鬥可以降低這個風險。\n如果任務日誌中有{quest:5211}（來自本指南開頭的{npc:11063}），鎮子周圍的天譴軍團會留下達隆郡之魂：和每一個交談來解放它們。在開始收集{item:15447}之前先解放它們。",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "從{area:1099}往南騎：角鷹獸巢在{zone:1444}南部；每個巢都有一顆蛋可放進{object:142071}。",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "向西南騎到{area:2738}的廢墟。{quest:1123}要的{object:179565}在其中一間破屋裡。",
	-- ["Scare {npc:7583} with {item:12928}"] = "用{item:12928}嚇唬{npc:7583}",
	-- ["Sword of Marduk"] = "馬杜克的破碎之劍",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "編年史在安多哈爾市政廳的發霉的書本之間；逐一打開直到找到正確的那本。",
	-- ["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "飛行點在{area:541}降落：{npc:9997}站在飛行管理員旁，{npc:8737}在幾步外的洞穴旁。{npc:9997}的活在安戈洛，下一篇指南往北回來時做。",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "高等精靈遊俠、巡路者和護林者守衛著{area:2275}旁的小屋；名冊在屋內。遊俠最高60級：一次只拉一隻。途中田野上空有毒性瘟疫蝙蝠飛行。\n頭骨在{area:2622}，周圍有荒蕪恐魔和瘟疫憎惡。",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "從安戈洛來的山道出口在{area:3077}，也就是{zone:1451}東北部的墓地。{npc:13220}站在墳墓之間。",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "破碎的劍躺在湖的西北方地上。",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "頭骨在{area:2622}，周圍有荒蕪水元素和瘟疫水元素。",
	-- ["The western hills"] = "西部丘陵",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "{object:142071}機器",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675}就在{area:2261}後面。",
	-- ["Top up here to level 56 before the Frenzied Plaguehounds of Northdale (57-58): the Noxious Plaguebats (54-56) over the fields on the way east are at your level, and {npc:11878} wants twenty of them. Or, with a group, run the {area:1583} dungeon (Lower) instead."] = "在對上北谷的狂怒的瘟疫犬（57-58級）之前，先在這裡升到56級：往東路上田野上空的毒性瘟疫蝙蝠（54-56級）跟你等級相當，而且{npc:11878}要你殺二十隻。或者有小隊的話，改打{area:1583}地城（下層）。",
	-- ["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "烏米的角，延續上次在{area:2255}接的任務：雪人丘陵就在{area:2255}東南方不遠。只有女族長和族長會掉角，而族長最高58級：一次只拉一隻。",
	-- ["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "對{area:976}的哥布林女孩{npc:7583}使用{item:12928}。{npc:10977}和{npc:10978}會在路線後段被嚇到。",
	-- ["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",
	-- ["{area:2255} flight master"] = "{area:2255}飛行管理員",
	-- ["{area:976} flight master"] = "{area:976}飛行管理員",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447}十分鐘內就會腐壞：快速擊殺鎮上的天譴軍團，並立刻用{item:15454}磨碎七份。",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880}在{object:172982}及其周邊街道走動：前往飛行管理員塔的路上留意他；地圖上的圓圈是他的巡行路線。",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}：交給{quest:7492}的{npc:7776}，在本指南結尾",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "鬼魂{npc:11140}站在西北角{area:2627}的一間小屋旁。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}的勇士守在{area:2261}北邊的{area:2260}農舍。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "{npc:15193}的勇士佔據{area:2260}的農舍。",
	-- ["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771}在{area:976}南邊、通往{area:1336}的路旁紮營。",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299}是{area:976}北邊墓地的鬼魂；明顯的墓碑在它南邊、城牆外。",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "{object:1661}的飛行管理員在{object:36078}城牆外的西塔。",
	-- ["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914}要交回安戈洛環形山的{npc:8737}：先留著。",
	-- ["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "{quest:3941}要交給這裡洞穴裡的{npc:9117}，下一篇指南回到{area:541}時：留著它。",
}
