-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- {area:2268} Light's Hope Chapel · {area:1497} Undercity
	["From {area:2268}'s flight master, fly to the {area:1497}."] = "从{area:2268}的飞行管理员处飞往{area:1497}。",

	-- Step 2: Janice Felstone
	-- {area:1497} Undercity · {zone:1420} Tirisfal Glades · {area:152} Bulwark · {npc:10778} Janice Felstone
	["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "离开{area:1497}，沿道路向东穿过{zone:1420}，经过{area:152}。费尔斯通农场是路边的第一座农场；{npc:10778}在房子里等候。",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house"] = "{object:175894}，在房子旁边",
	-- {npc:10781} Royal Overseer Bauhaus · {area:1497} Undercity
	["Keep the parcel: {npc:10781} is in the {area:1497}."] = "留着包裹：{npc:10781}在{area:1497}。",

	-- Step 3: Scarlet forward camp
	["Scarlet forward camp"] = "血色十字军前线营地",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "血色十字军的帐篷在{area:199}和{area:200}之间。用{object:176092}点燃指挥帐篷，并插上天灾战旗。",

	-- Step 4: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "{area:200}的农舍",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "日记在农舍里，柜子在屋里，厕所在屋后。一个{npc:10816}带着厕所钥匙；打开厕所时{npc:10836}会出来，他带着柜子钥匙。",

	-- Step 5: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "他在{area:200}东南的{area:202}旁扎营。",

	-- Step 6: Sorrow Hill
	-- {area:202} Writhing Haunt · {area:197} Sorrow Hill · {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "向南骑过{area:202}前往{area:197}；{npc:10927}的房子在路旁，{npc:10936}的纪念碑在房后的墓地里。路上把在田野里遇到的生病的狼都杀掉。",
	-- {npc:10840} Argent Officer Pureheart
	["{npc:10840}, at the graveyard's south end"] = "{npc:10840}，在墓地南端",
	-- {quest:5142} Little Pamela · {area:2262} Darrowshire
	["Keep {quest:5142}: Pamela is in {area:2262}, visited again later."] = "留着{quest:5142}：帕米拉在{area:2262}，之后会再去。",

	-- Step 7: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "向西北骑进安多哈尔。{npc:10667}在城镇西侧被毁的旅店里等候；里面的骷髅是54-57级，所以沿着边缘走。",

	-- Step 8: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "达隆郡的历史就在安多哈尔市政厅里的发霉的书籍中间；一本本打开，直到找到正确的那本。",

	-- Step 9: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210}要前往{area:2268}：留到之后。",

	-- Step 10: Diseased Wolves
	["Diseased Wolves"] = "生病的狼",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "狼在安多哈尔、{area:200}和{area:202}之间的田野里游荡。向东骑回去的路上把它们杀完。",

	-- Step 12: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",
	-- {area:202} Writhing Haunt
	["The bears roam the hills north and east of the {area:202}."] = "熊在{area:202}北边和东边的山丘上游荡。",

	-- Step 13: Mulgris Deepriver
	-- {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["Keep the branch: {npc:5770} is in {zone:1456}."] = "留着树枝：{npc:5770}在{zone:1456}。",

	-- Step 14: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River · {zone:1423} Eastern Plaguelands
	["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "沿东边的山丘向北骑行；{npc:1855}住在{area:2619}旁的一间小房子里，就在与{zone:1423}的交界处。",
	-- {npc:1855} Tirion Fordring · {zone:1423} Eastern Plaguelands
	["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}的狩猎任务在{zone:1423}：留到之后。",

	-- Step 15: Kirsta Deepshadow
	-- {area:192} Northridge Lumber Camp · {npc:11610} Kirsta Deepshadow
	["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "向西骑往{area:192}；{npc:11610}躲在它东北的山上。",

	-- Step 16: Scarlet Crusade
	["Scarlet Crusade"] = "血色十字军",
	-- {area:192} Northridge Lumber Camp
	["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "血色骑士和血色占星师在{area:192}干活；血色医护员和血色猎人在它南边扎营。",

	-- Step 18: Radley and Durgen
	["Radley and Durgen"] = "莱德雷和杜尔根",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613}站在伐木场东边；{npc:11611}守着{npc:11610}东北、通往{area:190}的道路。",

	-- Step 20: Northridge Lumber Camp
	-- {npc:11610} Kirsta Deepshadow
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}的最后一个任务需要53级。在她西南不远的伐木场干活的血色骑士和血色占星师（54-55级）是最近的刷怪点。",
	-- {area:192} Northridge Lumber Camp · {zone:1422} Western Plaguelands
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "在{zone:1422}的{area:192}刷血色骑士",

	-- Step 22: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "{area:190}的血色十字军是58-60级。骑到地图上标记的高处，俯瞰城镇，然后离开。",

	-- Step 24: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "向西南骑过费尔斯通农场，沿道路向西回到{area:152}。",
	-- {npc:11615} Mickey Levine
	["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "德灵顿的哨塔、范蒂丝的瘟疫之锅和{npc:11615}的木桶留到之后再来时完成：留着它们。",

	-- Step 25: To Felwood
	-- {zone:1448} Felwood
	["To {zone:1448}"] = "前往{zone:1448}",
	-- {area:1497} Undercity · {zone:1454} Orgrimmar · {area:431} Splintertree Post · {zone:1448} Felwood
	["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "骑回{area:1497}，乘飞艇前往{zone:1454}，飞往{area:431}。沿道路向西离开碎木岗哨，在岔路口向北进入{zone:1448}。",

	-- Step 26: Emerald Sanctuary
	["The druids' camp is just past the border."] = "德鲁伊的营地就在边界过去一点。",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, just west of the camp"] = "{npc:9529}，在营地正西",

	-- Step 27: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "{area:1763}南部",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "沿道路向西北。{area:1763}南部那口被腐化的月亮井周围被暗影议会的加德纳尔祭司、加德纳尔精兵、卫兵和恶犬占据。",

	-- Step 28: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "仅当掉落了{item:13140}时：使用它开始任务，然后到{area:1763}北端的洞穴{area:1770}里，把笼子里的{npc:11018}救出来，并护送她出去。",

	-- Step 29: Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "向东南骑回翡翠圣地。",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}，在营地南缘",

	-- Step 30: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "死木熊怪的村庄就在翡翠圣地正南。每杀一个死木熊怪也会提升你在{area:1769}的声望；留着死木头饰羽毛。",

	-- Step 31: Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Only with 5 Deadwood Headdress Feathers"] = "仅当你有5根死木头饰羽毛时",

	-- Step 32: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "{area:1763}的月亮井",
	-- {area:1763} Jaedenar · {npc:10922} Greta Mosshoof
	["Back north to {area:1763}. Fill {npc:10922}'s canteen at the corrupted moonwell in the middle of the southern camp."] = "向北回到{area:1763}。在南部营地中央被腐化的月亮井装满{npc:10922}的水壶。",

	-- Step 33: Rakaiah
	-- {npc:11018} Arko'narin · {npc:9518} Rakaiah · {area:1763} Jaedenar · {npc:11020} Remains of Trey Lightforge
	["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "仅当你救出了{npc:11018}时：魅魔{npc:9518}在{area:1763}中部，就在{npc:11020}旁边等候。",

	-- Step 34: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "{area:1763}正北的部落营地。",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}：枭兽在{zone:1452}",

	-- Step 35: The Jadefire moonwell
	["The Jadefire moonwell"] = "碧火月亮井",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "向南骑过{area:1763}，前往碧火萨特那口被腐化的月亮井，在那里装满{npc:9996}的小瓶。",

	-- Step 37: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}的小猫",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "把小猫带到同一口月亮井并在那里放出它；它变成{npc:10042}后，把它带回{npc:9996}那里，点击它交给她。",
	["Jadefire moonwell"] = "碧火月亮井",

	-- Step 39: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "在血毒岗哨东边，是{npc:9878}和热能恐兽游荡的坑洼山谷。每种各杀两只，然后走到三个邪能水坑的每一个那里。",
	["Southern crater"] = "南部水坑",
	["Western crater"] = "西部水坑",
	["Northern crater"] = "北部水坑",

	-- Step 40: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "沿道路向东北前往{area:1767}。树林东侧的曲木食苔者和曲木撕裂者各带着一块{item:11503}；怒爪灰熊和魔爪掠夺者在同一片树林里游荡，是塔罗要的。",

	-- Step 41: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "道路的尽头是{npc:15395}，就在遥远东北的{area:1769}隧道外。",

	-- Step 42: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "隧道正西的死木熊怪村庄。{npc:9462}（56级）站在它们中间。{npc:11557}是一个友善的熊怪，坐在村庄北端。",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}：为他留30块{quest:6031}；他只在木喉要塞声望达到中立时才交易",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}，稀有掉落",

	-- Step 43: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "留着{quest:8465}去{zone:1452}。",

	-- Step 44: Emerald Sanctuary
	-- {zone:1448} Felwood
	["Ride the road south through {zone:1448} to the Sanctuary."] = "沿道路向南穿过{zone:1448}前往翡翠圣地。",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}，在翡翠圣地西侧",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "留着{quest:5158}：{npc:5901}在{zone:1413}。",

	-- Step 45: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "洛尔站在{area:1761}最南端。",

	-- Step 46: Bloodvenom Post
	["Ride north up the road again."] = "再次沿道路向北骑行。",

	-- Step 47: Felpaw Village
	-- {area:1762} Felpaw Village
	["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "回到{area:1762}，死木熊怪（53-54级）就在隧道附近，每杀一个都会提升你的木喉要塞声望。",
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "在{zone:1448}的{area:1762}刷死木复仇者",
	-- {npc:11558} Kernda
	["{npc:11558}, at the tunnel mouth"] = "{npc:11558}，在隧道口",

	-- Step 48: Through Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Through {area:1769}"] = "穿过{area:1769}",
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien · {zone:1452} Winterspring · {area:2255} Everlook
	["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "走进{npc:15395}旁边的{area:1769}隧道，千万别攻击里面的木喉熊怪。隧道出口在{zone:1452}；沿道路向东前往地精城镇{area:2255}，下一个指南从那里开始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:152}"] = "{area:152}",
}
