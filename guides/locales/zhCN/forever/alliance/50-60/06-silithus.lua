-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}、{zone:1448}、{zone:1452}与瘟疫之地",
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands."] = "{zone:1451}、{zone:1448}、{zone:1452}和瘟疫之地。",
	["Takes you all the way to 60"] = "一路带你升到60级",
	["Stays on the main route"] = "位于主线路线上",
	-- {area:493} Moonglade
	["{area:493} flight path on the way"] = "途中开启{area:493}飞行路线",
	["Lots of flying between zones"] = "需要在地区之间频繁飞行",

	-- Step 1: Back from Mount Hyjal
	-- {zone:2482} Mount Hyjal
	["Back from {zone:2482}"] = "",
	-- {zone:1452} Winterspring · {area:392} Ratchet
	["Coming back from Hyjal? Finish the nearby {zone:1452} errands first. Once you reach 60 you can stop; {area:392} and the rest of the guide are still there if you want to finish your quest log."] = "",
	-- {npc:11755} Harlo Wigglesworth · {area:2255} Everlook
	["{npc:11755}, in {area:2255}"] = "",

	-- Step 2: Winterfall Village
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity · {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["{npc:11556}'s {quest:8464} waited for this visit: the furbolg village lies just east of {area:2255}, with Shaman (56-57), Den Watchers (55-56) and Ursa (57-58). Kill the Shaman first, they heal. {npc:10738} in the cave at the back is elite: stay out."] = "{npc:11556}的{quest:8464}就等这次来完成：熊怪村庄在{area:2255}东边不远处，有萨满（56-57级）、巢穴看守者（55-56级）和厄萨（57-58级）。先杀萨满，他们会治疗。后方洞穴里的{npc:10738}是精英：别进去。",

	-- Step 3: Starfall Village
	-- {area:2253} Starfall Village
	["Ride north-west up the road to {area:2253}."] = "沿路向西北骑行到 {area:2253}。",

	-- Step 4: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}的营地",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride back east past {area:2255} and south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "向东骑行返回，经过 {area:2255}，再沿山谷向东南到 {area:2245}：{npc:10301} 的破损箱子就在雪地上，损坏的货车在箱子东边不远处。",

	-- Step 5: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "{npc:10301}的补给",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "拾取马车周围的补给，并从附近的枭兽身上夺回{npc:10301}的护符。",

	-- Step 6: Ranshalla
	-- {npc:10300} Ranshalla · {area:2250} Owl Wing Thicket · {area:2255} Everlook · {object:177404} Altar of Elune
	["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300}在{area:2255}以南的{area:2250}等候。\n护送{npc:10300}前往{object:177404}，保护她沿途点燃火炬。",

	-- Step 9: Donova Snowden
	["Keep this for the next visit to the gorge mouth"] = "",

	-- Step 10: Everlook flight master
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",
	["Maethrya, the Alliance flight master"] = "",

	-- Step 11: Marshal's Refuge flight master
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "{area:541}的飞行管理员",
	["Gryfe, the flight master"] = "",

	-- Step 12: Reach Ratchet
	-- {area:392} Ratchet
	["Reach {area:392}"] = "",
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:16227} Bragok
	["Reach {area:392} by an available route. If your flight master offers Theramore instead, fly there, ride west into the {zone:1413} and follow the road north to {area:392}. Speak to {npc:16227} in town if you still need the flight path."] = "",

	-- Step 13: Ratchet flight master
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 14: Ratchet
	-- {npc:8496} Liv Rizzlefix · {area:392} Ratchet · {zone:1452} Winterspring · {area:2255} Everlook · {area:541} Marshal's Refuge
	["{npc:8496} is in {area:392}. From {zone:1452}, leave by Maethrya in {area:2255}; from Un'Goro, leave by Gryfe at {area:541}."] = "",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}：在屋内",

	-- Step 15: Fly to Talrendis Point
	-- {area:3137} Talrendis Point
	["Fly to {area:3137}"] = "飞往{area:3137}",

	-- Step 16: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 17: The Emerald Sanctuary
	-- {area:3137} Talrendis Point · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "从 {area:3137} 骑行进入 {zone:1448}：{area:2479} 是越过 {zone:1440} 边界后不远处、道路旁的德鲁伊营地。",
	["Inside"] = "在里面",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "稍等{npc:9116}片刻",

	-- Step 18: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "{area:1770}的火盆",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "{area:1770}是{area:1763}深处、道路西侧的洞穴。对洞内四个火盆使用{item:12906}，沿途击杀怒爪熊和魔爪狼，获取{item:11172}。\n注意：洞内遍布53-55级暗影议会成员，经常大群联动，许多怪物会使用昏迷技能。建议2-3名玩家组队。\n洞内的加德纳尔暗法师、加德纳尔术士和加德纳尔执行者会掉落{item:13140}，平均每击杀三十只掉落一把；持续击杀，直到掉落。它能打开关押在洞内的暗夜精灵{npc:11018}的牢房。",
	["Angerclaw bears and Felpaw wolves"] = "怒爪熊和魔爪狼",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "{object:176159}：在地下",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}：在地下",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}：在地下",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}：在地下",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}，在地下的牢房内",

	-- Step 19: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "带她离开{area:1770}，在出洞前确保她存活：先清理回程路上的怪物。",

	-- Step 21: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north.\nCareful: Ancient Irontree Walkers, level 59 elites, stand among the treants in the middle of {area:1767}: take the Stompers on the north side (about 48,21)."] = "沿道路向北到{area:1767}。铁木践踏者携带心脏；在北部的怒爪灰熊和魔爪掠夺者身上收集完爪子。\n小心：59级精英远古铁木行者站在{area:1767}中部的树人之间：去北侧（约48,21）打铁木践踏者。",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "铁木践踏者",

	-- Step 22: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598}在{area:1767}等候，护送她离开树林，确保她存活。\n注意：护送开始不久后，会有三名{quest:5086}伏击。",

	-- Step 23: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "向北骑行到{area:1769}洞口旁的死木熊怪村庄。",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}：{zone:1452}的{npc:9298}，留着",

	-- Step 24: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {npc:9518} Rakaiah
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber. The succubus {npc:9518} waits on the way, with Trey Lightforge's remains beside her.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "再次进入{area:1770}：{npc:9861}和{npc:9860}在最深处的房间守卫{npc:9517}。魅魔{npc:9518}在途中，特雷·莱弗治的残骸就在她旁边。\n注意：三名首领会一起战斗。先清掉附近怪物，避免额外引怪。",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}：在地下",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}：在地下",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}：在地下",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}：在地下",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517}：在地下",

	-- Step 25: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "沿道路向南骑回避难所。",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}：在屋内",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "保留他还给你的{item:11169}、爪子和心脏",

	-- Step 26: Forest Song
	-- {zone:1448} Felwood · {area:3137} Talrendis Point · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Ride south out of {zone:1448} toward {area:3137}: {npc:3848}'s camp at {area:2358} is just over the {zone:1440} border, on the way."] = "从{zone:1448}向南骑往{area:3137}：{npc:3848}在{area:2358}的营地就在{zone:1440}边界另一边，顺路经过。",

	-- Step 28: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飞往{area:976}",
	-- {npc:9616} Laris Geardawdle · {zone:1455} Ironforge · {zone:1452} Winterspring · {area:976} Gadgetzan
	["{npc:9616}'s jars went to {zone:1455} on the {zone:1452} guide's {zone:1455} stop: fly straight to {area:976}."] = "{npc:9616}的罐子已在{zone:1452}指南途经{zone:1455}时送到{zone:1455}：直接飞往{area:976}。",
	-- {area:3137} Talrendis Point
	["{area:3137} flight master"] = "{area:3137}的飞行管理员",

	-- Step 29: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飞往{area:442}",

	-- Step 30: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "乘船前往{area:150}",

	-- Step 31: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飞往{area:1537}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "{area:150}的飞行管理员",

	-- Step 32: Laris Geardawdle
	["Its jars are filled on the Un'Goro visit"] = "采样瓶在去安戈洛时装满",

	-- Step 33: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飞行管理员",

	-- Step 35: Fly to Gadgetzan
	["Theramore flight master"] = "塞拉摩的飞行管理员",

	-- Step 36: Gadgetzan
	-- {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "飞往{area:976}。在这里的拍卖行为{quest:5801}买两块瑟银锭。",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}：在屋内",
	-- {npc:5411} Krinkle Goodsteel · {area:537} Fire Plume Ridge
	["{npc:5411}: take this before {area:537}"] = "",

	-- Step 37: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "向东骑进山丘。使用{item:11169}召唤{quest:4005}，然后击败他获得图腾。",

	-- Step 38: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "向西南骑行到{area:1938}的{npc:7771}营地。",

	-- Step 40: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "沿道路向西下到环形山，骑行到南部的异种虫洞穴{area:540}。{npc:10041}在最深处的房间等候。",

	-- Step 41: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "爬上环形山中央的{area:537}，背包里带着两块瑟银锭，在山顶的熔岩湖旁使用{item:14644}。在山脊周围水池中的原生软泥怪身上装满{npc:9616}的纯净样本瓶。",
	["Use the jars on slain oozes"] = "对被杀的软泥怪使用样本瓶",

	-- Step 42: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "向北骑行到{area:541}。在{npc:10977}旁边使用{npc:10980}。",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}：在地下",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}，在避难所深处",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "用{npc:10980}吓唬{npc:10977}",

	-- Step 43: Fly to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Fly to {area:3425}"] = "飞往{area:3425}",

	-- Step 44: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}站在他所在建筑的楼上：从室内上楼，箭头无法区分楼层。",
	-- {npc:17082} Rifleman Torrig · {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17082}, at the Alliance tents: for {npc:17080} at {area:2743}"] = "{npc:17082}，在联盟帐篷处：交给{area:2743}的{npc:17080}",
	-- {npc:15181} Commander Mar'alith
	["{npc:15181}: Bronzebeard's Encampment comes later, on the way south"] = "{npc:15181}：铜须营地稍后再去，在南下途中",
	-- {npc:15183} Geologist Larksbane
	["{npc:15183}: the tablet fragments come from the Twilight dig"] = "{npc:15183}：石板碎片来自暮光挖掘场",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: his Twilight texts come from the dig after the next stop here"] = "{npc:15306}：他要的暮光密文来自下一站之后的挖掘场",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189}, upstairs"] = "{npc:15189}：在楼上",

	-- Step 45: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}：沿途击杀以下目标",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["From the hold, west into the sands: Dredge Crushers dig there; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "从要塞向西进入沙地：掘泥摧毁者在那里挖掘；石鞭巨钳蝎、剥皮者和石行蜘蛛也在同一片沙地上游荡。",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 46: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "{npc:15190}，在楼上{npc:15189}旁边",

	-- Step 47: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "{area:2742}：沿途击杀以下目标",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell · {area:2742} Hive'Ashi
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Twilight Avengers = {npc:11880} Twilight Avenger · Twilight Flamereavers = {npc:15201} Twilight Flamereaver
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait."] = "暮光之锤的挖掘场占据西北角：石板碎片散落在地上，灰尘风暴和沙漠奔行者也携带碎片。每个信徒都可能掉落{item:20404}：留二十个，十个给{npc:15306}，十个稍后给{npc:15194}。\n注意：从暮光复仇者和地卜师身上获取密文；别碰暮光烈焰掠夺者（60级），也别靠近虫巢入口，{area:2742}的精英（59-60级）守在那里。",
	["Twilight's Hammer cultists"] = "暮光之锤信徒",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "{item:20378}",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "再交十个用于{quest:8323}",

	-- Step 48: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080}在西侧虫巢{area:2743}外扎营。到附近红色喷口拾取一份水晶尘，送到他营地中的联盟萃取器。\n注意：上坐骑、潜行，或使用{spell:642}、{spell:5384}、消失都会使水晶尘掉落；闪现和{spell:17}不会使其掉落。",

	-- Step 50: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "向东骑行到{area:2738}的废墟。{object:179565}在废弃的建筑之间，被折磨的哨兵看守着。",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "{object:179565}：在屋内",

	-- Step 51: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "隐士躲在{area:2738}东南方的岩石间。",
	["Below ground"] = "在地下",

	-- Step 52: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "铜须营地",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand south-east of the camp, where Deathclasp, an elite scorpid, patrols: grab it while he is away."] = "向西南骑行到南部山脉附近的矮人营地，询问{npc:15171}和{npc:15170}。{npc:15190}的背包在营地东南方的沙子里，精英蝎子死亡弯钩在那里巡逻：趁它走开时拿走背包。",

	-- Step 53: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["Careful: the Twilight Keepers are level 60, a level or two over you: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "注意：暮光守护者是60级，比你高一两级：先清掉每个守护者周围的信徒，满血再打守护者。\n{npc:11803}占据西南角远处的信徒营地。",

	-- Step 54: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp.\nCareful: Mayna is level 60: clear her camp first and fight her at full health."] = "沿西侧向北骑行到玛伊娜的小营地。\n注意：玛伊娜是60级：先清理她的营地，满血再打她。",

	-- Step 55: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}.\nCareful: Havunth is level 60: clear his camp first and fight him at full health."] = "哈维斯的营地就在{area:3425}西边。\n注意：哈维斯是60级：先清理他的营地，满血再打他。",

	-- Step 56: Hermit Ortell
	["Ride back south-east to the hermit."] = "向东南骑回隐士处。",
	["Hand him the ten texts you kept"] = "把你留下的十份文本交给他",

	-- Step 57: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190}站在他所在建筑的楼上：从室内上楼，箭头无法区分楼层。",

	-- Step 58: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "飞往{area:976}。",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{zone:1457}的{npc:7740}：留着",

	-- Step 59: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "飞往{area:2255}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}飞行管理员",

	-- Step 68: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Hederine Slayers = {npc:7463} Hederine Slayer · Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Follow {npc:9298}'s directions south to the mouth of {area:2256}. Careful: Frostmaul Giants and Preservers (59-60, elite) stand on both sides of the road just north of it: keep to the road on the east side (about 62,67) and don't stop. The point is at the gorge's mouth: touch it and turn back north. Don't ride into the gorge: Hederine Slayers, Initiates and Manastalkers (57-60, elite) stand from just past the mouth to its far end, and Rabid Shardtooths (59) roam the way in."] = "",
	["The road past the Frostmaul giants"] = "",
	-- {area:2256} Darkwhisper Gorge
	["The road to {area:2256}"] = "",

	-- Step 69: Starfall Village
	-- {area:2255} Everlook · {area:2253} Starfall Village
	["Ride north up the valley, past {area:2255}, to {area:2253}."] = "沿山谷向北骑行，经过 {area:2255}，到达 {area:2253}。",

	-- Step 71: Felwood
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "{quest:5086}",

	-- Step 72: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "小心：59级精英古老铁木行者站在{quest:5086}的目标之间：在营地东北角（约50.6,22.4）一次一只地打恐魔，每次拉怪前都先看看有没有行者。",

	-- Step 73: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["{npc:11558} stands just inside the {area:1769} cave: she speaks to you from Neutral with the Timbermaw, which the Winterfall furbolgs you ground in {zone:1452} brought you to."] = "{npc:11558}就在{area:1769}洞穴入口内。木喉熊怪声望达到中立后，她才会交谈；此前在{zone:1452}刷冬泉熊怪已将声望提升到中立。",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558}在洞口内侧附近走动：在地图圆圈范围内寻找",

	-- Step 74: Kernda
	-- {area:1762} Felpaw Village · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then."] = "从{area:1762}带来的死木图腾，如果当时没交给{npc:11558}。",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}在附近走动：到地图标示的圆圈内寻找",

	-- Step 75: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth · {zone:1452} Winterspring
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw: the {zone:1452} top-up on the Winterfall furbolgs gets you both."] = "{npc:11557}在{npc:11558}旁的洞口内侧，木喉要塞声望达到友善后可向他交付三十块{quest:6031}：此前在{zone:1452}刷冬泉熊怪补等级时，声望和布料都能凑齐。",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557}，在地下",

	-- Step 79: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452}：沿途击杀以下目标",
	-- {spell:5384} Feign Death
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "西侧冬泉熊怪会掉落珠子。\n注意：交任务时会出现三四名 56–57 级冬泉伏击者并攻击你；可以骑乘、潜行或用{spell:5384}脱离。他们随后会聚集在湖边，便可接取下一项任务。",

	-- Step 83: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "从{npc:9298}西边{area:1769}隧道的{zone:1452}入口进入，沿{area:493}分支到{area:2361}。{npc:11939}在湖岸边研究。",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939}在{area:2361}巡逻，请在地图标示的圆圈内寻找",

	-- Step 84: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "{npc:11801}的房子在{area:2361}，{npc:11939}东边。",

	-- Step 87: Sindrayl
	-- {npc:10897} Sindrayl · {area:493} Moonglade · {area:2361} Nighthaven
	["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn."] = "{npc:10897}是{area:493}的飞行管理员，站在湖南边、{area:2361}外面：找他学习飞行路线。{area:2361}里的飞行管理员只通过对话为德鲁伊提供飞行，没有可学的飞行路线。",

	-- Step 88: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飞往{area:702}",

	-- Step 89: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "飞行降落在{area:702}。{npc:7916}站在飞行管理员西北方向不远处。",

	-- Step 91: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "乘传送门上到{zone:1457}。",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}，在月神殿",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}，在银行",

	-- Step 93: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}，在{area:1658}顶上",

	-- Step 94: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "传送至{zone:1438}",

	-- Step 95: Fly to Auberdine
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}的飞行管理员",

	-- Step 97: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",

	-- Step 98: Stormwind
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}，在运河边走动",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "交给{npc:10778}：留着",

	-- Step 99: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}，在军情七处",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{area:3197}的{quest:6184}：留着",

	-- Step 100: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14722} 分别需要六十块丝绸、六十块魔纹布和六十块 {item:14047}：交还随身带的布料（也可以在拍卖行购买），其余的跳过。",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "从背包中交付{item:4306}",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "从背包中交付{item:4338}",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}，在{object:2096}",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "从背包中交付{item:2592}",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "从背包中交付{item:14047}",

	-- Step 101: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁前往{zone:1455}",

	-- Step 102: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "乘{area:2257}前往{zone:1455}。{npc:14724}和{npc:14723}各收取六十个毛料、六十个丝绸和六十个魔纹布，之后各收取六十个{item:14047}。交付随身携带的，或从拍卖行购买；其余任务可跳过。",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453}没有萨满祭司训练师",

	-- Step 103: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飞往{area:271}",

	-- Step 107: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}是61级精英",
	-- {quest:6184} Flint Shadowmore · {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["{quest:6184}: the agents' remains lie at the {area:2260} in the {zone:1423}"] = "{quest:6184}：密探的遗骸在{zone:1423}的{area:2260}",
	-- {npc:11053} High Priestess MacDonnell · {area:201} Gahrron's Withering
	["{npc:11053}: {area:201}'s cauldron, on this loop"] = "{npc:11053}：{area:201}的大锅，在这一轮路线上",

	-- Step 108: Andorhal
	["Andorhal"] = "安多哈尔",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667}在安多哈尔西侧的废弃旅店等候，安多哈尔是营地北边的废墟城市。{npc:1852}在城镇中央守护他的护符匣。",
	["Araj is elite: grouping up is advised."] = "阿拉基是精英：建议组队。",

	-- Step 109: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "{npc:10778}的鬼魂在安多哈尔西边{area:199}的农舍旁游荡。田里的喋喋不休的食尸鬼携带护符的另一半：把两半合在一起。",
	["Upstairs"] = "在楼上",

	-- Step 110: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "沿道路向北骑到伐木场，把白蚁桶放在中央。",

	-- Step 111: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the Northridge lumber camp's edge."] = "{npc:11610}躲在北山伐木场边缘。",

	-- Step 112: Radley and Durgen
	["Radley and Durgen"] = "拉德利和杜尔根",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613}在{npc:11610}东边的北山营地内走动；{npc:11611}看守着{area:190}南部入口处的塔楼。\n小心：塔楼底部有守卫，另有一名绕塔巡逻。与杜根·挽锤交战前先清理这些守卫，免得他们加入战斗。",

	-- Step 113: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610}躲在伐木场边缘。",

	-- Step 114: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "{area:190}瞭望点",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "爬上{area:190}西侧山丘，俯瞰城镇。\n注意：大门处的哨兵能够侦测潜行玩家，镇内也有更多哨兵，附近还有一名精英巡逻。",

	-- Step 115: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1839} Scarlet High Clerist
	-- plural, as words: Scarlet Paladins = {npc:1834} Scarlet Paladin
	["Careful: Scarlet Paladins (55-56) and priests guard {item:12954} inside {area:190}'s town hall. They are elite, and a {npc:1839} (63, elite) stands near the book. Go in with your group; stay out of the Clerist's reach."] = "",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 117: Gahrron's Withering
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath · {item:12955} Redpath's Shield
	["Ride south-east to {area:201}: {npc:11078} guards the cauldron, and {item:12955} lies east of the barn."] = "向东南骑行到{area:201}：{npc:11078}守着大锅，{item:12955}在谷仓东边。",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["For {npc:11053} at {area:3197}, at the end of this guide"] = "交给{area:3197}的{npc:11053}，在本指南末尾",

	-- Step 119: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855}（可选）",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855}住在伐木场东北方边境河边的小屋里。如果完成了{quest:5781}就交还。",

	-- Step 120: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "{quest:5845}所需的湖泊",

	-- Step 121: Of Lost Honor
	["Underwater"] = "在水下",

	-- Step 122: Light's Hope Chapel
	["Ride south-east from the lake to the chapel."] = "从湖边向东南骑往礼拜堂。",

	-- Step 124: Carlin Redpath: the Scourge Champions
	-- {npc:11063} Carlin Redpath
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{npc:11063}: the Scourge Champions"] = "",

	-- Step 125: Caretaker Alen
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, keep it"] = "{npc:11038}，在教堂南面的墓地旁：{npc:11140}在{area:2627}，先留着",

	-- Step 126: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "天灾勇士",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "天灾勇士（59级）在{area:2268}北边的{area:2270}游荡。在你杀死的每一个身上挥动{npc:11063}的{item:13156}：产生共鸣的头骨就是他要的。一次拉一个。",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}，来自天灾勇士",

	-- Step 127: Light's Hope Chapel
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal: keep it"] = "安多哈尔的{npc:10667}：留着",

	-- Step 128: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "向北骑行前往{area:2277}东北边缘。\n注意：通往{area:2273}沿途的巨魔为 57–59 级，低血量时会逃跑求援，经常引来更多敌人。",

	-- Step 129: Tirion Fordring
	-- {quest:5845} Of Lost Honor
	["{quest:5845}: the route takes it and fetches the Symbol, so its hand-in holds"] = "{quest:5845}：路线会接取它并取回徽记，所以它的交还先保留",

	-- Step 130: Egan
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {npc:11140} Egan
	["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "过 {npc:1855} 小屋东侧的河，进入 {area:2627}：{npc:11140} 就站在奥古斯图斯的破屋旁。",

	-- Step 131: Level 59.85
	["Level 59.85"] = "59.85级",
	-- {npc:11140} Egan · {area:2627} Terrordale · {area:2261} Undercroft · {area:2298} Caer Darrow · {npc:10667} Chromie · {area:3197} Chillwind Camp · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["The Terrordale Spirits haunt the woods around {npc:11140}. Top up here to level 59.85 while you stand in {area:2627}: the hand-ins still to come (the {area:2261}, {area:2298}, {npc:10667} and {area:3197}) take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "恐惧谷的灵魂在{npc:11140}周围的树林中游荡。趁还在{area:2627}，先在此刷到59.85级：之后还要交的任务（{area:2261}、{area:2298}、{npc:10667}和{area:3197}）交完即可到60级。也可组队挑战{area:2057}副本或{area:2279}副本。",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "在{zone:1423}的{area:2627}刷{npc:14564}",

	-- Step 132: Marris Stead
	-- {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride south to the {area:2260}, the farm north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it. Coming close enough to see the Blightcaller in front of the house completes the scouting.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "向南骑往{area:2260}，即{area:2262}西北的农场。3名密探的遗骸是地上的人形骨骸：一处在农场南面的路边，一处在房屋东侧的山丘上，还有一处在屋前的土丘上。靠近到能看见屋前的凋零者，即可完成侦察。\n注意：{npc:11878}（62级精英）与他的精英猎犬守在屋前。从侧面拾取土丘上的遗骸，别引到他，无需与他战斗。",

	-- Step 133: Undercroft
	-- {area:2261} Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "向西南骑行前往{area:2261}，土堆位于内部。{npc:11886}是精英，建议组队。\n注意：米库提奥·污血会带来约四名非精英随从，他们会走到墓地，而非原地出现。",

	-- Step 135: Chromie
	-- {npc:10667} Chromie · {area:3197} Chillwind Camp
	["{npc:10667} waits upstairs in the ruined inn on the west side of Andorhal, on the way back to {area:3197}."] = "{npc:10667}在安多哈尔西侧的废弃旅店楼上等候，就在返回{area:3197}的路上。",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}：在楼上",

	-- Step 137: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "向西南骑回{area:3197}。",
	-- {zone:1453} Stormwind
	["Flint's next task goes to {zone:1453}: you are level 60 now, skip it."] = "弗林特·沙多摩尔的下一个任务要去{zone:1453}；现在已经60级了，跳过即可。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "回到{area:1770}：{npc:9861}和{npc:9860}在最深处的房间守护{npc:9517}。",
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "再次进入{area:1770}，{npc:9861}和{npc:9860}在最深处房间守卫{npc:9517}。\n注意：三名首领会一起战斗，先清掉附近怪物，避免额外引怪。",
	-- ["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "过{npc:1855}东边的河进入恐惧谷。{area:2627}的灵魂在那里的树林中游荡。",
	-- ["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "过 {npc:1855} 东侧的河，进入 {area:2627}。恐惧谷的灵魂在那里的树林里游荡。也可组队前往 {area:2057} 副本或 {area:2279} 副本。",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "掘泥摧毁者在{area:2743}和{area:3425}之间的沙丘游荡，就在你返回的路上。{npc:15181}在58级起才提供{quest:8304}。",
	-- ["Fly from {area:541} to {area:392}."] = "从{area:541}飞往{area:392}。",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "飞往{area:16}的{area:3137}，沿道路向西骑行到刚过{zone:1440}边界的{area:2358}。",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "飞往{zone:1447}的{area:3137}，沿道路向西骑行到刚过{zone:1440}边界的{area:2358}。",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "沿道路向西南出山口前往{area:3425}。",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "按照{npc:9298}的指引，经过霜槌巨人前往{area:2256}入口：逐个绕过巨人。",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "回到{area:702}，乘船前往{area:442}，再乘船前往{area:17203}。为{npc:14722}带六十块丝绸、六十块魔纹布和六十块{item:14047}：缺的在拍卖行购买。",
	-- ["Grind to 58"] = "刷到58级",
	-- ["Grind to 59"] = "刷到59级",
	-- ["Grind to 60"] = "刷到60级",
	-- ["Havunth's camp sits just west of {area:3425}."] = "哈弗斯的营地就在{area:3425}西边。",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "用炉石返回{area:1519}，学习60级法术。升级路线到此结束：接下来看看声望和地下城指南。",
	-- ["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "用炉石返回{area:392}，飞往{area:976}。在这里的拍卖行为{quest:5801}买两块瑟银锭。",
	-- ["Into {zone:1451}"] = "进入{zone:1451}",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "沿道路继续向西，到温泉旁{npc:9298}的营地。",
	-- ["Learn the flight path in {area:2361}."] = "在{area:2361}学习飞行路线。",
	-- ["Level 60"] = "60级",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "向北骑回{area:2255}，再沿道路向西前往暗夜精灵村庄。",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "骑回{area:3137}，飞往{area:2255}。",
	-- ["Ride north along the west side to Mayna's small camp."] = "沿西侧向北骑行到玛恩纳的小营地。",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "从{area:415}向北骑行进入{zone:1448}，到刚过边界路旁的德鲁伊营地。",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "向南骑行到{area:2250}。在{npc:10300}前往{object:177404}的路上点燃火把时保护她。",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "沿环形山北壁向西骑行，到西北角爬升进入{zone:1451}的山口。",
	-- ["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "组队打{area:2057}（{area:28}东南部的{area:2298}）或{area:2279}代替刷怪会更快。单人刷怪就跳过此步骤。",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "组队打{area:2057}（{zone:1422}东南部的{area:2298}）或{area:2279}代替刷怪会更快。单人刷怪就跳过此步骤。",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "组队打{zone:1444}的{area:2577}代替刷怪会更快。单人刷怪就跳过此步骤。",
	-- ["Shaman training"] = "萨满祭司训练",
	-- ["Take the boat from {area:442} to {area:702}."] = "从{area:442}乘船前往{area:702}。",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "在{area:2361}搭乘飞行路线飞往{area:442}。",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "从{npc:9298}西边{area:1769}隧道的{area:618}入口进入，沿{area:493}分支到{area:2361}。{npc:11939}在湖岸边研究。",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "乘{area:2257}前往{zone:1455}。{npc:14724}和{npc:14723}各要六十块毛料、六十块丝绸和六十块魔纹布，然后是六十块{item:14047}：每种共120块，来自背包或拍卖行。",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "暮光之锤的挖掘场占据西北角：石板碎片散落在地上，灰尘风暴和沙漠奔行者也携带碎片。每个信徒都可能掉落{item:20404}：留二十个，十个给{npc:15306}，十个稍后给{npc:15194}。",
	-- ["The main route to 60: {zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands, with the hand-ins in {zone:1453}, {zone:1455} and {spell:437801} on the way."] = "通往60级的主线路：{zone:1451}、{zone:1448}、{zone:1452}和瘟疫之地，途中在{zone:1453}、{zone:1455}和{spell:437801}交还任务。",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "{npc:7446}熊在{area:2250}南边的雪谷中游荡。",
	-- ["To {area:392}"] = "前往{area:392}",
	-- ["Toward the north-west pass"] = "前往西北山口",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "你从{area:392}开始，上一份指南让你用炉石回到了这里。飞往{area:415}。",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "在{zone:1451}{area:2743}东边的沙丘刷{npc:11741}",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "在{area:139}的{area:2627}刷{npc:14564}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "在{zone:1452}{area:2250}南边的山谷刷{npc:7446}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770}是{area:1763}后方、道路西边的洞穴。对里面的四个火盆使用{item:12906}。杀死沿途的怒爪熊和魔爪狼获取{item:11172}。",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "{area:1770}是{area:1763}深处、道路西侧的洞穴。对洞内四个火盆使用{item:12906}，沿途击杀怒爪熊和魔爪狼，获取{item:11172}。\n注意：洞内遍布 53–55 级暗影议会成员，经常大群联动，许多怪物会昏迷技能。建议两三名玩家组队。",
	-- ["{area:2057} (optional)"] = "{area:2057}（可选）",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057}适合58-60级；{quest:5505}在下面的{area:3197}交还。",
	-- ["{area:2577} (optional)"] = "{area:2577}（可选）",
	-- ["{area:2577} fits levels 55 to 60; alone, the {area:2627} grind at the end of this guide gets you to 60."] = "{area:2577} 适合 55 至 60 级；单人玩家可在本篇指南末尾到 {area:2627} 刷到 60 级。",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577}适合55-60级；下面刷{npc:7446}可以单人练到59级。",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}：在{zone:1452}结束，留着",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}，如果你有三十个{quest:6031}",
	-- ["{npc:11557}, if you have thirty {quest:6031}; below ground"] = "{npc:11557}在地下，拥有三十个{quest:6031}时再交付",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}，就在洞穴入口内：对木喉熊怪达到中立才行",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw; walks around here: look inside the circle on the map"] = "{npc:11558}就在洞口内侧，木喉声望达到中立后才能交谈；他在附近巡逻，请在地图标示的圆圈内寻找",
	-- ["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803}占据最西南端的信徒营地。",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}，旅店老板",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080}在西部虫巢{area:2743}外扎营。在附近的红色喷泉拾取一块水晶尘，带到他营地的联盟提取器。",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}，在联盟帐篷处",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}：上一份指南用炉石把你送到这里，所以这一步通常会立即完成",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598}在{area:1767}等候。护送她离开树林，保证她存活。",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}，如果你在{area:618}找到了火酒瓶",
	-- ["{object:210335} Fragments"] = "{object:210335}碎片",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085}：{area:618}的{npc:9298}，留着",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}、{area:361}、{area:618}和瘟疫之地",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，找{npc:258098}学习60级法术。",
}
