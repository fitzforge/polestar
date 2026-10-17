-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飛往{area:1497}",
	-- {area:2268} Light's Hope Chapel · {area:1497} Undercity
	["From {area:2268}'s flight master, fly to the {area:1497}."] = "從{area:2268}的飛行管理員處飛往{area:1497}。",

	-- Step 2: Janice Felstone
	-- {area:1497} Undercity · {zone:1420} Tirisfal Glades · {area:152} Bulwark · {npc:10778} Janice Felstone
	["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "離開{area:1497}，沿著道路向東穿過{zone:1420}，經過{area:152}。費爾斯通農場是道路旁的第一座農場；{npc:10778}在屋裡等候。",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house"] = "{object:175894}，在房子旁邊",
	-- {npc:10781} Royal Overseer Bauhaus · {area:1497} Undercity
	["Keep the parcel: {npc:10781} is in the {area:1497}."] = "保留包裹：{npc:10781}在{area:1497}。",

	-- Step 3: Scarlet forward camp
	["Scarlet forward camp"] = "血色十字軍前進營地",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "血色十字軍的帳篷位於{area:199}和{area:200}之間。用{object:176092}燒掉指揮帳篷，並插上天災戰旗。",

	-- Step 4: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "{area:200}農舍",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "日記在農舍裡，櫃子在屋內，廁所在屋後。一隻{npc:10816}帶著廁所鑰匙；打開廁所時{npc:10836}會出來，他身上帶著櫃子鑰匙。",

	-- Step 5: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "他在{area:200}東南方的{area:202}旁紮營。",

	-- Step 6: Sorrow Hill
	-- {area:202} Writhing Haunt · {area:197} Sorrow Hill · {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "向南騎過{area:202}前往{area:197}；{npc:10927}的房子在路旁，{npc:10936}的紀念碑在房子後面的墓地裡。沿途擊殺田野中遇到的生病的狼。",
	-- {npc:10840} Argent Officer Pureheart
	["{npc:10840}, at the graveyard's south end"] = "{npc:10840}，在墓地南端",
	-- {quest:5142} Little Pamela · {area:2262} Darrowshire
	["Keep {quest:5142}: Pamela is in {area:2262}, visited again later."] = "保留{quest:5142}：帕米拉在{area:2262}，之後會再去。",

	-- Step 7: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "向西北騎進安多哈爾。{npc:10667}在城鎮西側的廢墟旅店裡等候；裡面的骷髏是54-57級，所以沿著邊緣走。",

	-- Step 8: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "歷史書在安多哈爾市政廳的發黴的書籍之中；逐一打開直到找到正確的那本。",

	-- Step 9: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210}要交到{area:2268}：先保留。",

	-- Step 10: Diseased Wolves
	["Diseased Wolves"] = "生病的狼",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "狼群在安多哈爾、{area:200}和{area:202}之間的田野遊蕩。在往東騎回去的路上把牠們殺完。",

	-- Step 12: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",
	-- {area:202} Writhing Haunt
	["The bears roam the hills north and east of the {area:202}."] = "熊在{area:202}北邊和東邊的山丘遊蕩。",

	-- Step 13: Mulgris Deepriver
	-- {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["Keep the branch: {npc:5770} is in {zone:1456}."] = "保留樹枝：{npc:5770}在{zone:1456}。",

	-- Step 14: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River · {zone:1423} Eastern Plaguelands
	["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "沿著東側山丘向北騎；{npc:1855}住在{area:2619}旁的一間小屋，位於與{zone:1423}的邊界。",
	-- {npc:1855} Tirion Fordring · {zone:1423} Eastern Plaguelands
	["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}的狩獵任務在{zone:1423}：先保留。",

	-- Step 15: Kirsta Deepshadow
	-- {area:192} Northridge Lumber Camp · {npc:11610} Kirsta Deepshadow
	["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "向西騎往{area:192}；{npc:11610}躲在它東北方的山丘上。",

	-- Step 16: Scarlet Crusade
	["Scarlet Crusade"] = "血色十字軍",
	-- {area:192} Northridge Lumber Camp
	["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "血色騎士和血色法師在{area:192}工作；血色醫護員和血色獵人在它南邊紮營。",

	-- Step 18: Radley and Durgen
	["Radley and Durgen"] = "萊德雷與杜爾根",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613}站在伐木場東邊；{npc:11611}守衛著{npc:11610}東北方、通往{area:190}的道路。",

	-- Step 20: Northridge Lumber Camp
	-- {npc:11610} Kirsta Deepshadow
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}的最後一個任務需要等級53。在她西南方伐木場工作的血色騎士和血色法師（54-55級）是最近的營地。",
	-- {area:192} Northridge Lumber Camp · {zone:1422} Western Plaguelands
	-- plural, as words: Scarlet Knights = {npc:1833} Scarlet Knight
	["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "在{zone:1422}的{area:192}擊殺血色騎士練等",

	-- Step 22: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "{area:190}的血色十字軍是58-60級。騎進去到地圖上標示的高處，俯瞰城鎮，然後離開。",

	-- Step 24: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "向西南騎過費爾斯通農場，沿著道路向西回到{area:152}。",
	-- {npc:11615} Mickey Levine
	["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "德靈頓的瞭望塔、范蒂絲的大鍋和{npc:11615}的木桶會在之後造訪時完成：先保留。",

	-- Step 25: To Felwood
	-- {zone:1448} Felwood
	["To {zone:1448}"] = "前往{zone:1448}",
	-- {area:1497} Undercity · {zone:1454} Orgrimmar · {area:431} Splintertree Post · {zone:1448} Felwood
	["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "騎回{area:1497}，搭飛艇前往{zone:1454}，再飛往{area:431}。沿著道路向西離開碎木崗哨，在岔路往北進入{zone:1448}。",

	-- Step 26: Emerald Sanctuary
	["The druids' camp is just past the border."] = "德魯伊的營地就在邊界過去一點。",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, just west of the camp"] = "{npc:9529}，就在營地西邊",

	-- Step 27: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "{area:1763}南部",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "沿著道路向西北走。{area:1763}南部的腐化月井周圍，由加德納爾祭司、加德納爾精兵、加德納爾守護者和加德納爾惡犬佔據。",

	-- Step 28: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "只有在掉落了{item:13140}時：用它開始任務，然後到{area:1763}北端的洞穴{area:1770}，釋放籠子裡的{npc:11018}，並護送她出來。",

	-- Step 29: Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "騎回東南方的聖地。",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}，在營地南緣",

	-- Step 30: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "死木熊怪村莊就在聖地南邊。每擊殺一個死木熊怪也會提升你的{area:1769}聲望；保留頭飾羽毛。",

	-- Step 31: Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Only with 5 Deadwood Headdress Feathers"] = "僅限擁有5根死木頭飾羽毛時",

	-- Step 32: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "{area:1763}月井",
	-- {area:1763} Jaedenar · {npc:10922} Greta Mosshoof
	["Back north to {area:1763}. Fill {npc:10922}'s canteen at the corrupted moonwell in the middle of the southern camp."] = "向北回到{area:1763}。在南方營地中央的腐化月井裝滿{npc:10922}的水壺。",

	-- Step 33: Rakaiah
	-- {npc:11018} Arko'narin · {npc:9518} Rakaiah · {area:1763} Jaedenar · {npc:11020} Remains of Trey Lightforge
	["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "僅限你救出了{npc:11018}時：魅魔{npc:9518}在{area:1763}中央，{npc:11020}旁邊等候。",

	-- Step 34: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "{area:1763}北邊的部落營地。",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}：梟獸在{zone:1452}",

	-- Step 35: The Jadefire moonwell
	["The Jadefire moonwell"] = "碧火月井",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "向南騎回去經過{area:1763}，前往碧火薩特的腐化月井，在那裡裝滿{npc:9996}的小瓶。",

	-- Step 37: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}的小貓",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "把小貓帶到同一個月井並在那裡放出牠；牠變成{npc:10042}後，把牠帶回給{npc:9996}，點擊牠來交給她。",
	["Jadefire moonwell"] = "碧火月井",

	-- Step 39: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "在血毒崗哨東邊，熱能野獸和熱能恐獸遊蕩的坑窪山谷。各擊殺兩隻，然後走到三個魔化水坑的每一個。",
	["Southern crater"] = "南方坑洞",
	["Western crater"] = "西方坑洞",
	["Northern crater"] = "北方坑洞",

	-- Step 40: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "沿著道路向東北前往{area:1767}。樹林東側的曲木食苔者和曲木撕裂者各帶有一個{item:11503}；怒爪灰熊和魔爪掠奪者在同一片樹林遊蕩，是塔羅的任務目標。",

	-- Step 41: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "道路盡頭是{npc:15395}，在東北角的{area:1769}隧道外。",

	-- Step 42: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "就在隧道西邊的死木熊怪村莊。{npc:9462}（56級）站在牠們之中。友善的熊怪{npc:11557}坐在村莊北端。",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}：為他保留30塊{quest:6031}；他只在木喉聲望達到中立時才交易",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}，稀有掉落",

	-- Step 43: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "保留{quest:8465}，留到{zone:1452}。",

	-- Step 44: Emerald Sanctuary
	-- {zone:1448} Felwood
	["Ride the road south through {zone:1448} to the Sanctuary."] = "沿著道路向南穿過{zone:1448}前往聖地。",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}，在聖地西側",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "保留{quest:5158}：{npc:5901}在{zone:1413}。",

	-- Step 45: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "洛爾站在{area:1761}的最南端。",

	-- Step 46: Bloodvenom Post
	["Ride north up the road again."] = "再次沿著道路向北騎。",

	-- Step 47: Felpaw Village
	-- {area:1762} Felpaw Village
	["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "回到{area:1762}，死木熊怪（53-54級）就在隧道附近，每次擊殺都會提升你的木喉聲望。",
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "在{zone:1448}的{area:1762}擊殺死木復仇者練等",
	-- {npc:11558} Kernda
	["{npc:11558}, at the tunnel mouth"] = "{npc:11558}，在隧道口",

	-- Step 48: Through Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Through {area:1769}"] = "穿過{area:1769}",
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien · {zone:1452} Winterspring · {area:2255} Everlook
	["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "走進{npc:15395}旁邊的{area:1769}隧道，絕對不要攻擊裡面的木喉熊怪。隧道通往{zone:1452}；沿著道路向東前往哥布林城鎮{area:2255}，下一份指南從那裡開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:152}"] = "{area:152}",
}
