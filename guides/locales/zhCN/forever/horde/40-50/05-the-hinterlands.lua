-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Tarren Mill
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["Fly to {object:1772}"] = "",
	["Thorium Point flight master"] = "",

	-- Step 3: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "{npc:7801}的营地",
	-- {object:1772} Tarren Mill (no name in this language: may be words) · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser
	["Ride north-east from {object:1772} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' Quel'Danil Lodge."] = "",

	-- Step 4: Highvale
	["Highvale"] = "高原精灵",
	-- {npc:7780} Rin'ji
	["The Highvale elves camp around Quel'Danil Lodge. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way.\nCareful: Groups of about three elves ambush the escort, usually twice."] = "",

	-- Step 5: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "在村庄东边，紫色水生菇生长在山丘上。",
	["Underwater"] = "",

	-- Step 6: Revantusk Village
	["Revantusk Village"] = "",
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "沿道路向东穿过{zone:1425}，前往东海岸的巨魔村庄。",

	-- Step 8: Revantusk Village
	-- {quest:7849} Separation Anxiety · {quest:7845} Kidnapped Elder Torntusk! · {quest:7850} Dark Vessels · {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{quest:7849}, {quest:7845} and {quest:7850} are group quests: they send you into Jintha'Alor, whose trolls are elite (46-50). Take them with a group of three or more; skip them if you are alone, the route has you grind the experience back.\n{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 9: The Overlook Cliffs: kill these as you meet them
	["The Overlook Cliffs: kill these as you meet them"] = "",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "大海龟沿着村庄北边的海滩爬行。{npc:2491}的酒瓶也在这些海滩上，但他的任务不在本路线上。钳嘴龟可能掉落OOX-09/HL定位器，但很少见：留着它。",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}，稀有掉落",

	-- Step 10: The Overlook Cliffs: kill these as you meet them
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} is a level 48 elite: most classes solo it at level 50, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 11: Rin'ji's Secret
	["The secret lies on the Overlook Cliffs, above the beach."] = "",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "交给{zone:1458}的{npc:7825}，大约50级时",

	-- Step 12: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "{npc:14731}的午餐",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "沿海岸向北，{npc:14731}的午餐篮在小岛上；一个{npc:14748}守着它。",

	-- Step 14: Shaol'watha: kill these as you meet them
	["Shaol'watha: kill these as you meet them"] = "",
	-- {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko · {npc:2925} Silvermane Howler
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["West of the island, the Vilebranch scalpers hold the temples of Agol'watha and Shaol'watha. Slagtree's tools lie at one of the temples.\nThe Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and Skulk Rock. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message.\nCareful: Silvermane Stalkers are level 47-48 and stay stealthed while out of combat. Up close they use Infected Bite. When a {npc:2925} falls to 50% health or lower, it calls for help from anything within 25 yd."] = "",

	-- Step 15: Skulk Rock
	["Skulk Rock"] = "",
	-- {item:8684} Hinterlands Honey Ripple
	["The crates of {item:8684} lie around the abandoned Horde camp at Skulk Rock, among the oozes."] = "",

	-- Step 16: Wildkin Muisek
	["Careful: Stealthed wolves and griffons roam the Valorwind Lake area."] = "",

	-- Step 17: The Altar of Zul: kill these as you meet them
	["The Altar of Zul: kill these as you meet them"] = "",
	-- {npc:8636} Morta'gya the Keeper
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west of the lake, the Vilebranch soothsayers hold the Altar of Zul, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps.\nSouth-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "",

	-- Step 18: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["Only with the distress beacon: the robot sits at the head of the river west of Skulk Rock. Escort it east to the shore beyond the Overlook Cliffs; its reward waits with Oglethorpe in {object:3204}.\nCareful: Two ambushes spawn during the escort: first three wildkin owlbeasts, then three trolls. Before each, the robot halts and announces it senses danger. Oozes, stealthed wolves and a large turtle along the path can join fights, and they respawn even if cleared beforehand."] = "",

	-- Step 19: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "交给{zone:1454}的{npc:6986}，大约50级时",

	-- Step 20: Highvale
	["Back west to Quel'Danil Lodge; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "",

	-- Step 21: Jintha'Alor
	["Jintha'Alor"] = "",
	-- {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of Jintha'Alor. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. The trolls inside are elite: stay with your group and keep to the paths."] = "",
	-- {npc:14757} Elder Torntusk
	["{npc:14757}, at the top of Jintha'Alor"] = "",
	["His next request, going on to the Altar of Zul, is for a group."] = "",

	-- Step 22: Revantusk Village
	-- {npc:14731} Lard
	["{npc:14731}, inside"] = "",

	-- Step 23: Revantusk Village
	-- {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "{npc:14736}站在旅店的屋顶上，在{npc:14731}上方：走上去，箭头无法区分上下层。",

	-- Step 25: Level 49.02
	["Level 49.02"] = "",
	-- {quest:7816} Gammerita, Mon!
	["If you skipped {quest:7816} or the Jintha'Alor group quests, grind here to level 49.02 to stay on the route's plan. Or, with a group, run the Maraudon dungeon instead."] = "",
	-- {npc:2505} Saltwater Snapjaw
	["grind on {npc:2505}"] = "",

	-- Step 26: The Atal'ai Exile
	["South-west again, the exile hides by the ruins of Shadra'Alor."] = "",

	-- Step 28: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "在旅舍南边，枯木巨魔占据着他们的村庄。他们每个都携带头皮：收集到二十个后，使用{item:15002}做成尼姆布亚的长矛，然后把它插在村子里。",

	-- Step 29: Aerie Peak
	["Aerie Peak"] = "",
	["Ride all the way west to the Wildhammer town of Aerie Peak and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "",
	["Aerie Peak well"] = "",

	-- Step 31: Fly to Stonard
	["Fly to Stonard"] = "",
	["Revantusk Village flight master"] = "",

	-- Step 32: Fel'zerul
	["On the top floor"] = "",

	-- Step 33: The bloodmages
	["The bloodmages"] = "血法师",
	-- {zone:1419} Blasted Lands
	["Ride west out of Stonard and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "",

	-- Step 34: Serpent's Coil: kill these as you meet them
	["Serpent's Coil: kill these as you meet them"] = "",
	-- {npc:5982} Black Slayer · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills.\nEast of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south.\nCareful: Scorpok Stingers use Venom Sting; {npc:8301} adds Knockdown."] = "",

	-- Step 35: The bloodmages
	["Ride back north to the bloodmages."] = "向北骑回血法师那里。",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "他们的后续任务又要同样的部件，换取一件增益物品，而且不给经验：别接。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "向西回到{area:350}；高原游侠和高原神射手待在旅舍附近，高原斥候和高原前锋在旅舍南边的山坡上。",
	-- ["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "在道路东边，灰鬃野猪和格朗特在红石蜥蜴旁的山坡上拱土。远离更南边52级的地狱野猪。",
	-- ["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- ["Fly to {area:272}"] = "飞往{area:272}",
	-- ["Fly to {area:75}"] = "飞往{area:75}",
	-- ["Follow the roads east across the {area:47} to the troll village on the eastern coast. {npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "沿道路向东穿过{area:47}，前往东海岸的巨魔村庄。{npc:14736}站在旅店的屋顶上，在{npc:14731}上方：走上去，箭头无法区分上下层。",
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "沿道路向东穿过{zone:1425}，前往东海岸的巨魔村庄。",
	-- ["From {area:1446}'s flight master."] = "从{area:1446}的飞行管理员处出发。",
	-- ["Grind to 48"] = "刷到48级",
	-- ["His next request, going on to the {area:355}, is for a group."] = "他的下一个请求要前往{area:355}，需要组队。",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "猎户莫克霍尔的颅骨在邪枝废墟下方的一堆骨头上，他的骨头在{area:354}脚下的一堆上。污染之血容器放在下层平台上，{npc:14757}被关在最顶上。沿着小路走：里面的巨魔都是精英。",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "猎户莫克霍尔的颅骨在邪枝废墟下方的一堆骨头上，他的骨头在{area:354}脚下的一堆上。{spell:19478}容器放在下层平台上，{npc:14757}被关在最顶上。沿着小路走：里面的巨魔都是精英。",
	-- ["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "在东返途中，邪枝占卜者占据着中部山丘南边的巨魔神殿{area:355}。奇尔加和{npc:8636}（精英，50级）站在神殿顶上：只打下层台阶上的占卜者。",
	-- ["Only if you are not level 48 yet."] = "仅当你还没到48级时。",
	-- ["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "仅当你有定位器时：机器人在{area:351}西边的河流源头处。护送它向东前往{area:307}另一边的海岸；它的奖励在{area:35}的奥格索普那里。",
	-- ["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "一路向西骑到蛮锤矮人的城镇{area:348}，把警告放在镇中央的水井旁。镇上全是联盟守卫：进去，放好，然后离开。",
	-- ["Ride north back to {area:75} and fly to the {area:1497}."] = "向北骑回{area:75}，飞往{area:1497}。",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "从{area:272}向东北骑进{zone:1425}，再沿道路向东；{npc:7801}在精灵的{area:350}南边的山上扎营。",
	-- ["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "从{area:75}向西出发，再向南穿过峡谷进入{zone:1419}；两位血法师就站在入口不远处的路旁。",
	-- ["Saltwater Snapjaws"] = "海水钳嘴龟",
	-- ["Silvermane Howlers"] = "银鬃嗥狼",
	-- ["South-west again, the exile hides by the ruins of {area:353}."] = "再次向西南，流放者躲在{area:353}的废墟旁。",
	-- ["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "在西南，银鬃嗥狼在枯木村庄东边的山丘上游荡。",
	-- ["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "高原精灵在{area:350}周围扎营。烧掉他们营地里的高原精灵报告、高原精灵信件和高原精灵记录。{npc:7780}被关在旅舍里：带他出来，并在路上击退伏击。",
	-- ["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "银鬃捕猎者、野蛮的枭兽和翱翔的锋喙狮鹫共处于神殿与{area:351}之间的山丘上。对你杀死的枭兽使用{item:9618}。锋喙狮鹫还会掉落细长的狮鹫羽毛：留十根给{npc:14738}的第二个口信用。",
	-- ["The Vilebranch temples"] = "邪枝神殿",
	-- ["The central hills"] = "中部山丘",
	-- ["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "一箱箱{item:8684}散落在{area:351}被遗弃的部落营地周围，混在软泥怪中间。",
	-- ["The eastern slopes"] = "东部山坡",
	-- ["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "这五个任务需要的是同样的部件：一趟全部收集齐。在道路西边，{npc:5982}秃鹫、饥饿的弯牙土狼、厚甲毒刺蝎和死眼蜥蜴共处于山丘上。",
	-- ["The next guide starts here, at {area:3317}."] = "下一个指南从这里开始，在{area:3317}。",
	-- ["The northern beasts"] = "北部的野兽",
	-- ["The secret lies on the {area:307}, above the beach."] = "林吉的秘密在海滩上方的{area:307}。",
	-- ["Vilebranch soothsayers"] = "邪枝占卜者",
	-- ["Vulture hills"] = "秃鹫山丘",
	-- ["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "在小岛西边，邪枝割颅者占据着{area:1884}和{area:1917}的神殿。斯拉提的工具在其中一座神殿里。",
	-- ["grind on {npc:5982} at the northern hills, {zone:1419}"] = "在{zone:1419}北部山丘刷{npc:5982}",
	-- ["{area:348} well"] = "{area:348}水井",
	-- ["{npc:14757}, at the top of {area:354}"] = "{npc:14757}，在{area:354}顶上",
	-- ["{npc:2926} on the way"] = "顺路击杀{npc:2926}",
	-- ["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}：交给{zone:1456}，大约50级时",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}，在{object:36126}",
}
