-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "他在{area:200}东南的{area:202}旁扎营。",
	["Inside"] = "在里面",

	-- Step 2: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River · {zone:1423} Eastern Plaguelands
	["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "沿东边的山丘向北骑行；{npc:1855}住在{area:2619}旁的一间小房子里，就在与{zone:1423}的交界处。",
	-- {npc:1855} Tirion Fordring · {zone:1423} Eastern Plaguelands
	["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}的狩猎任务在{zone:1423}：留到之后。",

	-- Step 3: Kirsta Deepshadow
	-- {area:192} Northridge Lumber Camp · {npc:11610} Kirsta Deepshadow
	["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "向西骑往{area:192}；{npc:11610}躲在它东北的山上。",

	-- Step 4: Level 52.63
	["Level 52.63"] = "等级 52.63",
	-- {area:200} Dalson's Tears · {npc:11610} Kirsta Deepshadow · {quest:6004} Unfinished Business · {area:1417} Sunken Temple · {area:2100} Maraudon
	-- plural, as words: Scarlet Mages = {npc:1826} Scarlet Mage
	["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Scarlet Mages and Knights here count for {npc:11610}'s {quest:6004}. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "先在此刷到 52.63 级，再去 {area:200} 交任务，交完即可到 53 级。这里的血色法师和血色骑士计入 {npc:11610} 的 {quest:6004}。也可组队前往 {area:1417} 副本或 {area:2100} 副本。",
	-- {npc:1826} Scarlet Mage
	["grind on {npc:1826}"] = "击杀{npc:1826}刷经验",

	-- Step 5: Diseased Wolves
	["Diseased Wolves"] = "生病的狼",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "狼在安多哈尔、{area:200}和{area:202}之间的田野里游荡。向东骑回去的路上把它们杀完。",

	-- Step 6: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "{area:200}的农舍",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "日记在农舍里，柜子在屋里，厕所在屋后。一个{npc:10816}带着厕所钥匙；打开厕所时{npc:10836}会出来，他带着柜子钥匙。",
	-- {object:175924} Locked Cabinet
	["{object:175924}, inside"] = "{object:175924}，在室内",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "{quest:5058}：在屋内",

	-- Step 8: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",
	-- {area:202} Writhing Haunt · {area:1417} Sunken Temple · {area:1584} Blackrock Depths
	["The bears roam the hills north and east of the {area:202}. Below level 53.02, keep hunting them after the eighth: the hand-ins at the {area:202} take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "",
	-- {npc:1816} Diseased Grizzly
	["grind on {npc:1816}"] = "击杀{npc:1816}刷经验",

	-- Step 9: Mulgris Deepriver
	-- {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["Keep the branch: {npc:5770} is in {zone:1456}."] = "留着树枝：{npc:5770}在{zone:1456}。",

	-- Step 10: Scarlet Crusade
	["Scarlet Crusade"] = "血色十字军",
	-- {area:192} Northridge Lumber Camp
	["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "血色骑士和血色占星师在{area:192}干活；血色医护员和血色猎人在它南边扎营。",
	-- {npc:10605} Scarlet Medic
	["grind on {npc:10605}"] = "击杀{npc:10605}刷经验",

	-- Step 12: The Bulwark
	-- {area:152} The Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "向西南骑过费尔斯通农场，沿道路向西回到{area:152}。",
	-- {npc:11615} Mickey Levine
	["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "德灵顿的哨塔、范蒂丝的瘟疫之锅和{npc:11615}的木桶留到之后再来时完成：留着它们。",

	-- Step 13: Level 53.34
	["Level 53.34"] = "等级 53.34",
	-- {area:1763} Jaedenar · {area:1417} Sunken Temple · {area:1584} Blackrock Depths
	["Top up here to level 53.34 before the hand-ins at {area:1763}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "先在此刷到 53.34 级，再去 {area:1763} 交任务，交完即可到 54 级。也可组队前往 {area:1417} 副本或 {area:1584} 副本。",

	-- Step 15: Paladin trainer
	["Paladin trainer"] = "圣骑士训练师",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152}在{zone:1420}；{zone:1454}没有圣骑士训练师",

	-- Step 16: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 17: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 18: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 19: Druid trainer
	["Druid trainer"] = "德鲁伊训练师",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} 在 {zone:1412}；{zone:1454} 没有德鲁伊训练师",

	-- Step 20: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飞往{area:431}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 22: Emerald Sanctuary
	["The druids' camp is just past the border."] = "德鲁伊的营地就在边界过去一点。",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}，在营地南缘",

	-- Step 23: Deadwood Village
	-- {area:1769} Timbermaw Hold · {area:1763} Jaedenar · {area:1417} Sunken Temple · {area:1584} Blackrock Depths
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "死木熊怪的村庄就在翡翠圣地南边不远处。每击杀一个死木熊怪也会提升 {area:1769} 声望；留着死木头饰羽毛。继续击杀，直到 53.92 级：翡翠圣地接下来的交任务环节和 {area:1763} 的路线需要达到这个进度。也可组队前往 {area:1417} 副本或 {area:1584} 副本。",
	-- {npc:7153} Deadwood Warrior
	["grind on {npc:7153}"] = "反复击杀{npc:7153}补足经验",

	-- Step 24: Emerald Sanctuary
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, just west of the camp"] = "{npc:9529}，在营地正西",

	-- Step 25: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "{area:1763}南部",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "沿道路向西北。{area:1763}南部那口被腐化的月亮井周围被暗影议会的加德纳尔祭司、加德纳尔精兵、卫兵和恶犬占据。",

	-- Step 26: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "",

	-- Step 27: Captured Arko'narin
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, below ground"] = "{npc:11016}：在地下",

	-- Step 29: Rescue From Jaedenar
	-- {npc:11018} Arko'narin · {area:1770} Shadow Hold
	["Walk {npc:11018} out of {area:1770} and keep her alive until she is out of the cave."] = "",
	-- {npc:11018} Arko'narin
	["{npc:11018}, below ground"] = "",

	-- Step 30: Jessir Moonbow
	-- {area:2479} Emerald Sanctuary
	["Back at the {area:2479}."] = "",

	-- Step 32: Emerald Sanctuary
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Only with 5 Deadwood Headdress Feathers"] = "仅当你有5根死木头饰羽毛时",

	-- Step 33: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "{area:1763}的月亮井",
	-- {area:1763} Jaedenar · {npc:10922} Greta Mosshoof
	["Back north to {area:1763}. Fill {npc:10922}'s canteen at the corrupted moonwell in the middle of the southern camp."] = "向北回到{area:1763}。在南部营地中央被腐化的月亮井装满{npc:10922}的水壶。",

	-- Step 34: Rakaiah
	-- {npc:9518} Rakaiah · {area:1763} Jaedenar · {npc:11020} Remains of Trey Lightforge
	["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "",
	["Below ground"] = "在地下",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}：在地下",

	-- Step 36: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "{area:1763}正北的部落营地。",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}：枭兽在{zone:1452}",

	-- Step 37: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "在血毒岗哨东边，是{npc:9878}和热能恐兽游荡的坑洼山谷。每种各杀两只，然后走到三个邪能水坑的每一个那里。",
	["Southern crater"] = "南部水坑",
	["Western crater"] = "西部水坑",
	["Northern crater"] = "北部水坑",

	-- Step 38: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber · {area:1997} Bloodvenom Post · {area:2479} Emerald Sanctuary · {area:1584} Blackrock Depths · {area:1417} Sunken Temple
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:8957} Angerclaw Grizzly
	["grind on {npc:8957}"] = "击杀{npc:8957}刷经验",

	-- Step 39: Irontree Woods
	-- {npc:7101} Warpwood Shredder
	["grind on {npc:7101}"] = "击杀{npc:7101}刷经验",

	-- Step 40: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "隧道正西的死木熊怪村庄。{npc:9462}（56级）站在它们中间。{npc:11557}是一个友善的熊怪，坐在村庄北端。",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}：为他留着 30 个 {quest:6031}；木喉声望达到中立后才肯交易；在地下",

	-- Step 41: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "道路的尽头是{npc:15395}，就在遥远东北的{area:1769}隧道外。",

	-- Step 42: Felpaw Village
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold · {area:2479} Emerald Sanctuary · {area:1584} Blackrock Depths · {area:1417} Sunken Temple
	["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nBelow level 54.54, keep fighting the Deadwood here after {npc:15395}'s count: the hand-ins at {area:1769} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:7156} Deadwood Den Watcher
	["grind on {npc:7156}"] = "击杀{npc:7156}刷经验",

	-- Step 43: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "留着{quest:8465}去{zone:1452}。",

	-- Step 44: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}，稀有掉落",

	-- Step 45: Emerald Sanctuary
	-- {zone:1448} Felwood
	["Ride the road south through {zone:1448} to the Sanctuary."] = "沿道路向南穿过{zone:1448}前往翡翠圣地。",

	-- Step 47: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "洛尔站在{area:1761}最南端。",

	-- Step 48: Emerald Sanctuary
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}，在翡翠圣地西侧",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "留着{quest:5158}：{npc:5901}在{zone:1413}。",

	-- Step 49: Level 54.7
	["Level 54.7"] = "等级 54.7",
	-- {area:1997} Bloodvenom Post · {area:1584} Blackrock Depths · {area:1417} Sunken Temple
	["Top up here to level 54.7 before the hand-ins at {area:1997} : they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.7 级，再去 {area:1997} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- {npc:7155} Deadwood Pathfinder
	["grind on {npc:7155}"] = "反复击杀{npc:7155}补足经验",

	-- Step 50: The Jadefire moonwell
	["The Jadefire moonwell"] = "碧火月亮井",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "向南骑过{area:1763}，前往碧火萨特那口被腐化的月亮井，在那里装满{npc:9996}的小瓶。",

	-- Step 51: Bloodvenom Post
	["Ride north up the road again."] = "再次沿道路向北骑行。",

	-- Step 52: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}的小猫",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "把小猫带到同一口月亮井并在那里放出它；它变成{npc:10042}后，把它带回{npc:9996}那里，点击它交给她。",
	["Jadefire moonwell"] = "碧火月亮井",

	-- Step 55: Level 54.87
	["Level 54.87"] = "等级 54.87",
	-- {zone:1452} Winterspring · {area:1584} Blackrock Depths · {area:1417} Sunken Temple
	["Top up here to level 54.87 before the hand-ins in {zone:1452}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:7125} Jaedenar Hound
	["grind on {npc:7125}"] = "反复击杀{npc:7125}补足经验",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "回到{area:1762}，死木熊怪（53-54级）就在隧道附近，每杀一个都会提升你的木喉要塞声望。",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "小心：洞穴守卫为 53-54 级，生命值低于 50% 时会呼叫 25 码内的同伴援助，低于 15% 时还会逃跑求援。",
	-- ["Diseased Grizzlies"] = "生病的灰熊",
	-- ["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- ["Fly to {area:272}"] = "飞往{area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "沿道路向东北前往{area:1767}。树林东侧的曲木食苔者和曲木撕裂者各带着一块{item:11503}；怒爪灰熊和魔爪掠夺者在同一片树林里游荡，是塔罗要的。",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "从{area:2268}的飞行管理员处飞往{area:1497}。",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "保留“小帕米拉”：帕米拉在 {area:2262}，稍后还会再去。",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "留着包裹：{npc:10781}在{area:1497}。",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "离开{area:1497}，沿道路向东穿过{zone:1420}，经过{area:152}。费尔斯通农场是路边的第一座农场；{npc:10778}在房子里等候。",
	-- ["Level 53.02"] = "等级 53.02",
	-- ["Level 53.2"] = "等级 53.2",
	-- ["Level 54.1"] = "等级 54.1",
	-- ["Level 54.45"] = "等级 54.45",
	-- ["Level 54.54"] = "等级 54.54",
	-- ["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "仅当掉落了{item:13140}时：使用它开始任务，然后到{area:1763}北端的洞穴{area:1770}里，把笼子里的{npc:11018}救出来，并护送她出去。",
	-- ["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "仅当你救出了{npc:11018}时：魅魔{npc:9518}在{area:1763}中部，就在{npc:11020}旁边等候。",
	-- ["Radley and Durgen"] = "莱德雷和杜尔根",
	-- ["Ride back south-east to the Sanctuary."] = "向东南骑回翡翠圣地。",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "骑回{area:1497}，乘飞艇前往{zone:1454}，飞往{area:431}。沿道路向西离开碎木岗哨，在岔路口向北进入{zone:1448}。",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "向西北骑进安多哈尔。{npc:10667}在城镇西侧被毁的旅店里等候；里面的骷髅是54-57级，所以沿着边缘走。",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "向南骑过{area:202}前往{area:197}；{npc:10927}的房子在路旁，{npc:10936}的纪念碑在房后的墓地里。路上把在田野里遇到的生病的狼都杀掉。",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "沿道路向南穿过{area:361}前往翡翠圣地。",
	-- ["Scarlet forward camp"] = "血色十字军前线营地",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "达隆郡的历史就在安多哈尔市政厅里的发霉的书籍中间；一本本打开，直到找到正确的那本。",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "死木熊怪的村庄就在翡翠圣地正南。每杀一个死木熊怪也会提升你在{area:1769}的声望；留着死木头饰羽毛。",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "血色十字军的帐篷在{area:199}和{area:200}之间。用{object:176092}点燃指挥帐篷，并插上天灾战旗。",
	-- ["The bears roam the hills north and east of the {area:202}."] = "熊在{area:202}北边和东边的山丘上游荡。",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "穿过{area:1769}",
	-- ["To {zone:1448}"] = "前往{zone:1448}",
	-- ["Top up here to level 53.02 before the hand-ins at {area:202}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "先在此刷到 53.02 级，再去 {area:202} 交任务，交完即可到 54 级。也可组队前往 {area:1417} 副本或 {area:1584} 副本。",
	-- ["Top up here to level 53.2 before the hand-ins at {area:152}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "先在此刷到 53.2 级，再去 {area:152} 交任务，交完即可到 54 级。也可组队前往 {area:1417} 副本或 {area:1584} 副本。",
	-- ["Top up here to level 54.1 before the hand-ins at {area:361}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.1 级，再去 {area:361} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Top up here to level 54.45 before the hand-ins at {area:1769}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.45 级，再去 {area:1769} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Top up here to level 54.54 before the hand-ins at {area:2479}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.54 级，再去 {area:2479} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Top up here to level 54.87 before the hand-ins at {area:2255}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.87 级，再去 {area:2255} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Upstairs"] = "在楼上",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "走进{npc:15395}旁边的{area:1769}隧道，千万别攻击里面的木喉熊怪。隧道出口在{zone:1452}；沿道路向东前往地精城镇{area:2255}，下一个指南从那里开始。",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "在{zone:1448}的{area:1762}刷死木复仇者",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "在{zone:1422}的{area:192}刷血色骑士",
	-- ["grind on {npc:1817}"] = "击杀{npc:1817}刷经验",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "{area:190}的血色十字军是58-60级。骑到地图上标记的高处，俯瞰城镇，然后离开。",
	-- ["{area:2268} flight master"] = "{area:2268}的飞行管理员",
	-- ["{npc:10840} stands at the south end of the {area:197} graveyard, where the road from {area:272} comes in."] = "{npc:10840} 站在 {area:197} 墓地南端，来自 {area:272} 的道路入口处。",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}，在墓地南端",
	-- ["{npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it."] = "{npc:10927} 的房子在路旁，{npc:10936} 的纪念碑在屋后的墓地里。",
	-- ["{npc:10927}, upstairs"] = "{npc:10927}：在楼上",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}：为他留30块{quest:6031}；他只在木喉要塞声望达到中立时才交易",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}，在隧道口",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}的最后一个任务需要53级。在她西南不远的伐木场干活的血色骑士和血色占星师（54-55级）是最近的刷怪点。",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613}站在伐木场东边；{npc:11611}守着{npc:11610}东北、通往{area:190}的道路。",
	-- ["{object:175894}, beside the house"] = "{object:175894}，在房子旁边",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210}要前往{area:2268}：留到之后。",
}
