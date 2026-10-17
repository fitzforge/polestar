-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:484} Freewind Post · {area:1637} Orgrimmar
	["From {area:484}, fly to {area:1637}."] = "从{area:484}飞往{area:1637}。",

	-- Step 2: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639}在暗巷区等候；{npc:5640}站在城西侧的{object:172961}。天裔：{npc:4949}在{object:172957}的格罗玛什要塞里等候。",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}，在格罗玛什要塞，如果你带着它",

	-- Step 3: Train
	["Train"] = "训练",
	["Train your new spells."] = "训练你的新法术。",

	-- Step 4: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:460} Sun Rock Retreat
	["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "你的训练师在{area:1638}，飞一次即到：{area:1639}的{npc:3033}（德鲁伊），{npc:246344}（圣骑士）。然后从那里飞往{area:460}。",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "{zone:1454}职业任务",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892}站在{object:172957}。",

	-- Step 6: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "飞往{area:392}。{npc:5901}在城镇南边不远的海岸上扎营。",

	-- Step 7: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "飞往{area:484}。{npc:5905}躲在哨站东北峡谷崖壁上的一个小山洞里。",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}：你的{item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905}还会开始元素援助（{area:1717}），这是通往风暴武器的33-40级任务线：见萨满祭司职业指南“空气的召唤和风暴武器（部落）”。",

	-- Step 8: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "飞往{area:460}",

	-- Step 9: Gizelton caravan
	["Gizelton caravan"] = "基泽尔顿商队",
	-- {zone:1443} Desolace · {area:608} Nijel's Point · {npc:11625} Cork Gizelton · {area:609} Kolkar Village
	["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "沿道路向西南离开烈日石居进入{zone:1443}，继续向南经过{area:608}。{npc:11625}的科多兽商队在{area:609}北边的路旁等候；如果它已经出发，就继续骑行。",

	-- Step 10: Bodyguard for Hire
	-- {area:609} Kolkar Village · {npc:11625} Cork Gizelton · {area:2617} Scrabblescrew's Camp · {area:597} Ghost Walker Post
	["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "商队向南经过{area:609}。科卡尔袭击者会一波波伏击商队：在他们接近{npc:11625}之前杀死他们。商队停在{area:597}东边的{area:2617}旁。",

	-- Step 12: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395}站在哨站里；{npc:5641}和{npc:4498}在哨站西边的高地上等候，俯瞰{area:596}。",

	-- Step 13: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "对坟场里的老迈的科多兽、濒死的科多兽或{npc:4702}使用{npc:11596}的{item:13892}，把驯服的科多兽带回{npc:11596}那里。共五头，一次一头。",

	-- Step 14: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "向东北骑往{area:609}。{quest:1365}（35级）带着一两个科卡尔队长（32-33级）在东侧的帐篷间走动：先清理他周围，然后在满血时单独引他。",

	-- Step 15: Sargeron
	-- {area:603} Sargeron
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "沿东边的山丘向北，萨特占据着{area:603}的废墟。怨怒巡影者隐形行走；你需要的四种萨特则不会。",

	-- Step 16: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "向西骑往{area:599}。把一个火刃氏族信徒打到残血，在它死前对它使用{item:6436}，充满一个{item:6435}。他们偶尔也会掉落{item:20310}（1-5%）；如果掉了，就阅读它。",

	-- Step 17: Ghost Walker Post
	["Ride back south to the post."] = "向南骑回哨站。",
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "{npc:5641}的下一个任务{quest:1431}让你白跑一趟{zone:1454}：别接。",

	-- Step 18: Kolkar ears
	["Kolkar ears"] = "半人马的耳朵",
	-- {area:609} Kolkar Village
	["Back at {area:609}, every Kolkar can drop an ear."] = "回到{area:609}，每个科卡尔半人马都可能掉落耳朵。",

	-- Step 19: Shadowstalker scalp
	["Shadowstalker scalp"] = "巡影者的头皮",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "{area:603}的怨怒巡影者在攻击前都是隐形的；大约三分之一带着头皮。",

	-- Step 21: Shadowprey Village
	-- {area:606} Gelkis Village
	["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "向西南骑往海岸边的巨魔村庄，途中避开{area:606}。",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877}：交给荆棘谷的{npc:715}",

	-- Step 22: Clam beds
	["Clam beds"] = "蚌床",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "沿海岸向北骑行。巨型软壳蚌躺在浅水里，狂怒的暗礁蟹在海滩上走动；在背包里打开每个蚌取出软壳蚌肉。",

	-- Step 23: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "滑刃智者",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "继续向北前往{area:598}。滑刃智者站在北端的其他纳迦中间；一次引一只。",

	-- Step 24: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863}在内陆东南方{area:2405}的废塔里等候。",

	-- Step 25: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "火刃先知站在{area:599}南侧，{area:2405}东边。先清掉它周围的信徒。",

	-- Step 26: Ethel Rethor
	["His next errand is not on this route."] = "他的下一个差事不在本路线上。",

	-- Step 27: Ghost Walker Post
	["Ride south-east to the post."] = "向东南骑往哨站。",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "{npc:5641}的下一个差事要你去对付一个带着精英护卫的恶魔领主：跳过它。",

	-- Step 28: Gelkis Village
	["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "向西南朝葬影村骑行。村庄周围的吉尔吉斯半人马（32-35级）很适合刷；打到32级为止。",
	-- {area:606} Gelkis Village · {zone:1443} Desolace
	-- plural, as words: Gelkis Stampers = {npc:4648} Gelkis Stamper
	["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "在{zone:1443}的{area:606}刷吉尔吉斯践踏者和吉尔吉斯逐风者",

	-- Step 30: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "从葬影村飞往{area:1638}，在{area:1639}找{npc:3033}训练，然后继续飞往{zone:1454}。",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飞行管理员",

	-- Step 32: Zeppelin to the Undercity
	-- {area:1497} Undercity
	["Zeppelin to the {area:1497}"] = "乘飞艇前往{area:1497}",
	-- {zone:1454} Orgrimmar · {area:1497} Undercity
	["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "从正门离开{zone:1454}；飞艇塔就在大门东北边。乘坐前往{area:1497}的飞艇。",
	["Zeppelin tower"] = "飞艇塔",

	-- Step 33: Garen Largo
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093}在{area:1497}训练圣骑士。",

	-- Step 34: Brazier of Everfount
	-- {area:1497} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "先在{area:1497}采购，然后飞往{area:228}。{object:113791}在它西南边的小山上：击败旁边的堕落水之魂，把它的护腕放进火盆，与{npc:5895}交谈，留着{item:7813}交给{npc:5901}。然后从{area:228}继续飞往{area:272}。",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "交给{npc:5901}：从荆棘谷前往，见下一个指南",

	-- Step 35: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515}需要一瓶{item:3388}，这是{skill:171}物品：如果可以，在这里的拍卖行买一瓶（或找炼金术士）。没有药水：跳过{area:287}的药剂步骤。",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}：拍卖行或炼金术士，用于{quest:515}。",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "{npc:4551}，蝙蝠管理员",

	-- Step 36: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}，交给{npc:2333}",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770}：交给阿拉希高地的{area:321}，路线后面会去",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229}：交给{zone:1413}，路线后面会去",

	-- Step 37: Daggerspine naga
	["Daggerspine naga"] = "刺脊纳迦",
	-- {area:271} Southshore
	["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "向南骑行，从{area:271}东边下到海岸。刺脊纳迦分布在城镇东南的海岸上。",
	["Daggerspine shore"] = "刺脊海岸",

	-- Step 38: Torn Fin murlocs
	["Torn Fin murlocs"] = "碎鳍鱼人",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "沿海岸向西经过{area:271}的海湾；碎鳍鱼人在海湾另一边的海滩上扎营。",
	["Torn Fin beach"] = "碎鳍海滩",

	-- Step 39: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Ride back north to {area:272}, keeping west of {area:271}."] = "向北骑回{area:272}，从{area:271}西边绕过。",

	-- Step 40: Shindigger keg
	["Shindigger keg"] = "矿工烈酒酒桶",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "酒桶和另外几个酒桶一起放在{area:287}东南海岸的辛迪加营地里。",

	-- Step 41: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "返回{area:272}",
	["Hearth back (or ride north if it is on cooldown)."] = "用炉石回去（如果炉石在冷却，就向北骑回去）。",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn"] = "把{object:1729}放在旅店旁的{object:1728}上",

	-- Step 42: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "沿道路向北离开{area:272}，进入奥特兰克山麓。{quest:535}在辛迪加营地旁等候；把南海镇烈酒交给他。",

	-- Step 43: Syndicate missives
	["Syndicate missives"] = "辛迪加信件",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "道路西边营地周围的辛迪加劫匪和辛迪加窃贼（32-33级）携带信件；大约三分之一会掉落。",

	-- Step 44: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "在西南，洞穴雪人和凶恶的雪人（30-31级）占满了{area:272}西边山丘里的洞穴；大约十六分之一带着魔棒。",

	-- Step 45: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "{area:279}的叛徒",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "沿山脚向西前往{area:279}的紫色穹顶。{npc:2411}、{npc:2412}和{npc:2413}（33-34级）一起站在陨坑东缘内侧，{npc:2414}（35级）在他们西边不远处；每人携带一块血石。他们周围的达拉然持盾守卫和达拉然法师（31-32级）掉落{item:3714}。",

	-- Step 46: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back east to {area:272}."] = "向东骑回{area:272}。",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "塞万德的下一个任务在{area:271}的墓地结束，而那位魔导师提供的是一个地下城差事：两个都别接。",

	-- Step 47: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "向北骑过{quest:535}的营地，前往辛迪加占据的村庄{area:280}（35-37级）。{npc:2431}携带{item:3704}；{quest:503}被关在北侧房子的笼子里。",

	-- Step 48: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back south to {area:272}."] = "向南骑回{area:272}。",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- {area:1497} Undercity · {object:3202} Grom'gol
	["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "下一个指南从{area:1497}的{object:3202}飞艇处开始。",
}
