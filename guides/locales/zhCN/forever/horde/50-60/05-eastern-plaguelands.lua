-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "飞往{area:2268}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "{area:272}的飞行管理员",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "{quest:5168}要的物品在之后的瘟疫之地地区：留着它。",

	-- Step 3: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}：沿途击杀以下目标",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "瘟疫犬和瘟疫犬幼崽在礼拜堂西南方的湖岸游荡，瘟疫蝙蝠和腐肉虫也在同一带活动。\n破碎的剑在湖泊西北方的地面上。",

	-- Step 4: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}的勇士占据着{area:2261}北边{area:2260}的农舍。",

	-- Step 5: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "瘟疫幼犬和瘟疫蝙蝠在{area:2260}北边的山丘上游荡，腐肉虫在它们中间爬行；一路向北朝{area:2627}推进。",

	-- Step 6: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "鬼魂{npc:11140}站在西北角{area:2627}的一间小屋旁。",
	["Inside"] = "在里面",

	-- Step 7: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}：沿途击杀以下目标",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "狂怒的瘟疫犬和巨型瘟疫蝙蝠共处于{area:2273}南边、{area:2272}和{area:2271}周围的田野上。",

	-- Step 8: Eastern Plaguelands: kill these as you meet them
	-- {area:2275} Northpass Tower · {area:2622} Pestilent Scar
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Blighted Horrors = {npc:8521} Blighted Horror
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "高等精灵游侠、巡路者和伐木工守卫着{area:2275}旁的小屋；登记册在屋内。游侠最高60级：逐个引怪。途中田野上空有毒性瘟疫蝙蝠飞过。\n头骨在{area:2622}，周围有荒芜水元素和瘟疫畸兽。",
	["Underwater"] = "在水下",

	-- Step 9: Pathstrider
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565}在{area:2276}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 10: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant
	["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "从小屋沿道路向南骑往{area:2264}。{item:15447}十分钟内就会变质：快速杀死镇上的天灾军团，然后立刻用{item:15454}把七块研磨好。\n小心：隐形仆从血量降到40%时会呼叫25码内的同伴求援。脱离战斗时它们还会用{spell:10228}隐形。如果在镇子里触发求援，大量怪物可能加入战斗。在镇子外围战斗可以降低这种风险。",

	-- Step 11: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "向西骑往{area:2260}。",

	-- Step 13: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英怪：建议组队，找人一起做。{npc:11897} 是 60 级精英：多数职业在 62 级能单人击败，但你可能需要帮助。独自一人就跳过：路线会让你打怪补回这部分经验。",

	-- Step 15: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "飞往{area:1497}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "{area:2268}的飞行管理员",

	-- Step 16: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 17: Orgrimmar
	-- {npc:10880} Warcaller Gorlach · {npc:7776} Talo Thornhoof · {quest:7492} Camp Mojache
	["{npc:10880}, outside the front gate on the way in: for {npc:7776} at {quest:7492}, at the end of this guide"] = "",

	-- Step 18: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "飞往{area:1997}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 19: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飞往{area:1638}",

	-- Step 20: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033}（德鲁伊）在{area:1639}提供训练，{npc:246344}（圣骑士）也在城里。",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}的{npc:3033}；{npc:246344}",

	-- Step 21: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 23: Deadwood Cauldron
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 24: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "仅当你掉落了{quest:8471}时：{npc:11558}在{area:1769}的{zone:1448}入口处等候，只有你在木喉要塞声望达到中立时才会和你说话。",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 26: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "穿过{area:1769}，走隧道通往{zone:1450}的岔路。{npc:11801}在{area:2361}。",

	-- Step 27: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 28: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "两个任务都通往{zone:1451}：留着它们。",

	-- Step 30: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "穿过隧道回去，走{zone:1452}出口，然后向南骑往{area:2246}。",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "",

	-- Step 31: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "月光枭兽",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "向东骑往{area:2255}，再从那里向北出去；月光枭兽在{area:2241}南坡的山丘上游荡。一次引一只。",

	-- Step 33: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飞往{area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "{area:2255}的飞行管理员",

	-- Step 34: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299}是{area:976}正北墓地里的一个鬼魂；明显的墓碑在它南边、城墙外面。",

	-- Step 35: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "对{area:976}的地精女孩{npc:7583}使用{item:12928}。{npc:10977}和{npc:10978}在路线后面再吓唬。",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "",

	-- Step 36: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "{object:142071}机器",

	-- Step 37: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914}要交还给安戈洛的{npc:8737}：留着它。",

	-- Step 38: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771}在{area:976}南边通往{area:1336}的路旁扎营。",

	-- Step 39: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飞往{area:1099}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}的飞行管理员",

	-- Step 40: Camp Mojache
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}, a few steps from the flight master"] = "",
	-- {area:2577} Dire Maul
	["His next task is for the {area:2577} dungeon: leave it."] = "",

	-- Step 41: Ruins of Isildien
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "飞往{area:1099}。角鹰兽的巢在{zone:1444}南部；每个巢里都有一个蛋，用于{object:142071}。",

	-- Step 42: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "飞往{area:541}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "{area:1099}的飞行管理员",

	-- Step 43: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "",
	-- {quest:3941} A Gnome's Assistance · {npc:9117} J.D. Collie · {area:541} Marshal's Refuge
	["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "",

	-- Step 44: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "从安戈洛环形山出来的山口通往{area:3077}，那是{zone:1451}东北部的墓地。{npc:13220}站在坟墓之间。",

	-- Step 45: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {quest:1123} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "一张破损的卷轴在{area:2260}南边的墓穴{area:2261}的入口处。",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "穿过隧道回去，走{area:618}出口，然后向南骑往{area:2246}。",
	-- ["Back to {area:1638}"] = "返回{area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "飞往{zone:1458}，乘飞艇前往{zone:1454}，再继续飞往{area:1638}。",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "飞往{area:541}，然后向西南穿过安戈洛环形山，前往进入{zone:1451}的山口。下一个指南从山口出口处的{area:3077}开始。",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "穿过{area:1769}，走隧道通往{area:493}的岔路。{npc:11801}在{area:2361}。",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "哈米亚躲在东北角{area:2273}的烂苔巨魔中间。",
	-- ["Hameya's mound"] = "哈米亚的土堆",
	-- ["Hameya's scroll"] = "哈米亚的卷轴",
	-- ["Hippogryph eggs"] = "角鹰兽蛋",
	-- ["On to {zone:1451}"] = "继续前往{zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "在{area:1641}。把毛料、丝绸和魔纹布带在背包里。",
	-- ["Only if you found a {item:12820} flask in {area:618}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "仅当你在{area:618}找到了一瓶{item:12820}时：沿道路向北骑行。大锅在{area:1769}西南不远的{area:1762}；那里的死木熊怪是敌对的。",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "瘟疫犬和瘟疫幼犬在教堂西南的湖岸上游荡。",
	-- ["Ride east out of the {area:1497} along the road; the {area:152} guards the way into the {area:28}."] = "沿道路向东骑出{area:1497}；{area:152}守卫着进入{area:28}的通道。",
	-- ["Sword of Marduk"] = "马杜克的破碎之剑",
	-- ["The flight from {area:1997} lands in {zone:1456}: {npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "从{area:1997}起飞的航班降落在{zone:1456}：{npc:3033}（德鲁伊）在{area:1639}训练，{npc:246344}（圣骑士）也在城里。",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "高等精灵游侠、巡路者和护林者守卫着{area:2275}旁的奎尔林斯小屋；奎尔萨拉斯名册就在小屋里。游侠最高60级：一次引一个。路上的田野上空有毒性瘟疫蝙蝠飞过。",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "马杜克的破碎之剑就躺在湖西北的地上。",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "头骨就在{area:2622}里，周围是荒芜水元素和瘟疫水元素。",
	-- ["The western hills"] = "西部山丘",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675}就在{area:2261}后面。",
	-- ["Upstairs"] = "在楼上",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447}十分钟内就会变质：快速杀死镇上的天灾军团，然后立刻用{item:15454}把七块研磨好。",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "{npc:10778}的农场是{area:152}以东第一座农场。农场里的喋喋不休的食尸鬼携带她护符的另一半；{npc:11075}守着田里的大锅。\n小心：通常有一两只亡灵与他并肩战斗，使用大锅后还可能有更多护锅者来袭。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "{npc:15193}的勇士占据着{area:2260}的农舍。",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "{object:1661}的飞行管理员在{object:36078}城墙外的西塔上。",
	-- ["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086}在{zone:1448}，之后那一趟再去：如果你有就留着。",
}
