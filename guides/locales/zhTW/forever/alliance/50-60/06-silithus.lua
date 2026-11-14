-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}、{zone:1448}、{zone:1452}與瘟疫之地",
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring · {zone:1453} Stormwind · {zone:1455} Ironforge · {spell:437801} Light's Hope
	["The main route to 60: {zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands, with the hand-ins in {zone:1453}, {zone:1455} and {spell:437801} on the way."] = "通往60級的主要路線：{zone:1451}、{zone:1448}、{zone:1452}與瘟疫之地，途中在{zone:1453}、{zone:1455}和{spell:437801}繳交任務。",

	-- Step 1: Ratchet
	-- {area:541} Marshal's Refuge · {area:392} Ratchet
	["Fly from {area:541} to {area:392}."] = "從{area:541}飛往{area:392}。",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}，在裡面",

	-- Step 2: Fly to Talrendis Point
	-- {area:3137} Talrendis Point
	["Fly to {area:3137}"] = "飛往{area:3137}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 3: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 4: The Emerald Sanctuary
	-- {area:3137} Talrendis Point · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "從{area:3137}騎進{zone:1448}：{area:2479}是剛越過{zone:1440}邊界後道路旁的德魯伊營地。",
	["Inside"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "稍等一下{npc:9116}",

	-- Step 5: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "{area:1770}的火盆",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "",
	["Angerclaw bears and Felpaw wolves"] = "怒爪熊和魔爪狼",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "",

	-- Step 6: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "",

	-- Step 8: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north.\nCareful: Ancient Irontree Walkers, level 59 elites, stand among the treants in the middle of {area:1767}: take the Stompers on the north side (about 48,21)."] = "沿著道路向北前往{area:1767}。鐵木踐踏者身上帶著心臟；在北邊的怒爪灰熊和魔爪掠奪者身上收集完爪子。\n小心：59級精英遠古鐵木行者站在{area:1767}中部的樹人之間：去北側（約48,21）打鐵木踐踏者。",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "鐵木踐踏者",

	-- Step 9: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598}在{area:1767}等候。護送她走出樹林，並保護她存活。\n小心：護送開始後不久，會有三隻{quest:5086}來伏擊你。",

	-- Step 10: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "向北騎往{area:1769}洞口旁的死木熊怪村莊。",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}：{zone:1452}的{npc:9298}，保留此任務",

	-- Step 11: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {npc:9518} Rakaiah
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber. The succubus {npc:9518} waits on the way, with Trey Lightforge's remains beside her.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "",

	-- Step 12: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "沿著道路向南騎回聖地。",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "保留他還給你的{item:11169}、爪子和心臟",

	-- Step 13: Forest Song
	-- {zone:1448} Felwood · {area:3137} Talrendis Point · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Ride south out of {zone:1448} toward {area:3137}: {npc:3848}'s camp at {area:2358} is just over the {zone:1440} border, on the way."] = "向南騎出{zone:1448}，朝{area:3137}前進：{npc:3848}在{area:2358}的營地就在{zone:1440}邊界的另一側，順路經過。",

	-- Step 15: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飛往{area:442}",
	-- {area:3137} Talrendis Point
	["{area:3137} flight master"] = "",

	-- Step 16: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "搭船前往{area:150}",

	-- Step 17: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飛往{area:1537}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 18: Laris Geardawdle
	["Its jars are filled on the Un'Goro visit"] = "它的罐子會在造訪安戈洛時裝滿",

	-- Step 19: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飛往{area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 21: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飛往{area:976}",
	["Theramore flight master"] = "塞拉摩飛行管理員",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "飛往{area:976}。在這裡的拍賣場購買兩塊瑟銀錠，用於{quest:5801}。",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 23: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "向東騎進山丘。使用{item:11169}召喚{quest:4005}，然後擊敗他取得圖騰。",

	-- Step 24: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "向西南騎往{area:1938}的{npc:7771}營地。",

	-- Step 26: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "沿著道路向西下到環形山中，騎往南部的異種蟲洞穴{area:540}。{npc:10041}在最深處的洞室等著。",

	-- Step 27: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "爬上環形山中央的{area:537}，背包裡帶著兩塊瑟銀錠，在山頂熔岩湖旁使用{item:14644}。在山脊周圍水池中的原生軟泥怪身上裝滿{npc:9616}的純淨樣本瓶。",
	["Use the jars on slain oozes"] = "對被殺死的軟泥怪使用瓶子",

	-- Step 28: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "向北騎往{area:541}。在{npc:10977}旁邊使用{npc:10980}。",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}，在避難營深處",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 29: Fly to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Fly to {area:3425}"] = "",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "{area:541}飛行管理員",

	-- Step 30: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "",

	-- Step 31: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "暮光之錘的挖掘場佔據西北角：石碑碎片散落在地上，灰塵風暴和沙漠奔行者身上也帶著碎片。每個教徒都可能掉落{item:20404}：保留二十份，十份給{npc:15306}，十份稍後給{npc:15194}。",
	["Twilight's Hammer cultists"] = "暮光之錘教徒",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "暮光石碑碎片",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "再十份給{quest:8323}",

	-- Step 32: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080}在西邊的蟲巢{area:2743}外紮營。在附近的紅色間歇泉撿起一塊希利塞斯，帶到他營地的聯盟萃取器。\n小心：如果你上坐騎、潛行、使用{spell:642}、{spell:5384}或消失，就會失去希利塞斯。閃現和{spell:17}不會讓它掉落。",

	-- Step 34: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "向東騎往{area:2738}的廢墟。{object:179565}在毀壞的建築之間，由被折磨的哨兵看守。",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "",

	-- Step 35: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "隱士躲在{area:2738}東南方的岩石間。",
	["Below ground"] = "地下",

	-- Step 36: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "銅鬚營地",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand south-east of the camp, where Deathclasp, an elite scorpid, patrols: grab it while he is away."] = "向西南騎往南部山脈附近的矮人營地，詢問{npc:15171}和{npc:15170}。{npc:15190}的背包在營地東南方的沙地上，精英蠍子死亡彎鉤在那裡巡邏：趁牠走開時拿走背包。",

	-- Step 37: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803}佔據西南角落的教徒營地。",

	-- Step 38: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "沿著西側向北騎往瑪恩納的小營地。",

	-- Step 39: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "哈弗斯的營地就在{area:3425}西邊。",

	-- Step 40: Hermit Ortell
	["Ride back south-east to the hermit."] = "向東南騎回隱士處。",
	["Hand him the ten texts you kept"] = "把你保留的十份文本交給他",

	-- Step 41: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 42: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "飛往{area:976}。",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{zone:1457}的{npc:7740}：保留此任務",

	-- Step 43: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}飛行管理員",

	-- Step 46: Starfall Village
	-- {area:2253} Starfall Village
	["Ride north-west up the road to {area:2253}."] = "沿著道路向西北騎往{area:2253}。",

	-- Step 48: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}的營地",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride back east past {area:2255} and south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 49: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "{npc:10301}的補給物資",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "撿起馬車周圍的補給物資，並從附近的梟獸身上奪回{npc:10301}的護符。",

	-- Step 50: Ranshalla
	-- {npc:10300} Ranshalla · {area:2250} Owl Wing Thicket · {area:2255} Everlook · {object:177404} Altar of Elune
	["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300}在{area:2255}南邊的{area:2250}等候。\n保護{npc:10300}，讓她在前往{object:177404}的路上點燃火炬。",

	-- Step 51: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "依照{npc:9298}的指示前往{area:2256}入口，途中經過霜槌巨人：一次通過一個。",

	-- Step 52: Starfall Village
	-- {area:2255} Everlook · {area:2253} Starfall Village
	["Ride north up the valley, past {area:2255}, to {area:2253}."] = "",

	-- Step 54: Felwood
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "",

	-- Step 55: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "小心：59級精英遠古鐵木行者站在{quest:5086}之間：在營地東北角（約50.6,22.4）一次打一隻恐魔，每次拉怪前先看看附近有沒有行者。",

	-- Step 56: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["{npc:11558} stands just inside the {area:1769} cave: she speaks to you from Neutral with the Timbermaw, which the Winterfall furbolgs you ground in {zone:1452} brought you to."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558}，就在洞口內：會在這附近走動：在地圖上的圓圈內找他",

	-- Step 57: Kernda
	-- {area:1762} Felpaw Village · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "",

	-- Step 58: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth · {zone:1452} Winterspring
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw: the {zone:1452} top-up on the Winterfall furbolgs gets you both."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "",

	-- Step 62: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "",
	-- {spell:5384} Feign Death
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 66: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "從{npc:9298}西邊位於{zone:1452}的入口進入{area:1769}隧道，沿著{area:493}的岔路前往{area:2361}。{npc:11939}在湖岸邊做研究。",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "",

	-- Step 67: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "{npc:11801}的房子在{area:2361}，位於{npc:11939}東邊。",

	-- Step 69: Nighthaven
	-- {area:2361} Nighthaven
	["Learn the flight path in {area:2361}."] = "",

	-- Step 70: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",

	-- Step 71: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "",

	-- Step 73: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "走傳送門上到{zone:1457}。",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}，在月神殿裡",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}，在銀行裡",

	-- Step 75: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}，在{area:1658}頂端",

	-- Step 76: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "傳送門前往{zone:1438}",

	-- Step 77: Fly to Auberdine
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}飛行管理員",

	-- Step 79: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飛往{zone:1453}",

	-- Step 80: Stormwind
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}，在運河邊走動",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "交給{npc:10778}：保留此任務",

	-- Step 81: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}，在軍情七處",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{area:3197}的{quest:6184}：保留此任務",

	-- Step 82: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}，在{object:2096}",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "",

	-- Step 83: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 84: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453}沒有薩滿訓練師",

	-- Step 85: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飛往{area:271}",

	-- Step 89: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}是61級精英",
	-- {quest:6184} Flint Shadowmore · {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["{quest:6184}: the agents' remains lie at the {area:2260} in the {zone:1423}"] = "",

	-- Step 90: Andorhal
	["Andorhal"] = "安多哈爾",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667}在安多哈爾西側的旅店廢墟裡等候，安多哈爾是營地北邊的廢墟城市。{npc:1852}在城鎮中央守著他的護符匣。",
	["Araj is elite: grouping up is advised."] = "阿拉基是精英：建議組隊。",

	-- Step 91: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "{npc:10778}的鬼魂在{area:199}的農舍旁徘徊，位於安多哈爾西邊。田裡喋喋不休的食屍鬼身上帶著護符的另一半：把兩半合起來。",
	["Upstairs"] = "樓上",

	-- Step 92: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "沿著道路向北騎往伐木場，把白蟻桶放在伐木場中央。",

	-- Step 93: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855}（可選）",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855}住在伐木場東北方、邊界河畔的小屋裡。如果你已完成{quest:5781}，就交給他。",

	-- Step 94: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 95: Of Lost Honor
	["Underwater"] = "在水下",

	-- Step 96: Light's Hope Chapel
	["Ride south-east from the lake to the chapel."] = "從湖向東南騎到禮拜堂。",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, keep it"] = "{npc:11038}，在禮拜堂南邊的墳墓旁：{npc:11140}在{area:2627}，先留著",

	-- Step 97: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "天災勇士",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "天災勇士（59級）在{area:2268}北邊的{area:2270}遊蕩。每殺一隻就用{npc:11063}的{item:13156}掃過牠：產生共鳴的頭骨才是他要的。一次只拉一隻。",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}，來自天災勇士",

	-- Step 98: Light's Hope Chapel
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal: keep it"] = "安多哈爾的{npc:10667}：保留此任務",

	-- Step 99: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "向北騎到{area:2277}的東北邊緣。\n小心：通往{area:2273}的路上的食人妖是57-59級。它們血量低時會逃跑並呼救，所以常常會引來更多怪。",

	-- Step 100: Tirion Fordring
	-- {quest:5845} Of Lost Honor
	["{quest:5845}: the route takes it and fetches the Symbol, so its hand-in holds"] = "{quest:5845}：路線會接取它並取回徽記，所以它的繳交步驟會保留",

	-- Step 101: Egan
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {npc:11140} Egan
	["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "渡過{npc:1855}小屋東邊的河進入{area:2627}：{npc:11140}站在奧古斯都殘破的小屋旁。",

	-- Step 102: Level 59.85
	["Level 59.85"] = "",
	-- {npc:11140} Egan · {area:2627} Terrordale · {area:2261} Undercroft · {area:2298} Caer Darrow · {npc:10667} Chromie · {area:3197} Chillwind Camp · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["The Terrordale Spirits haunt the woods around {npc:11140}. Top up here to level 59.85 while you stand in {area:2627}: the hand-ins still to come (the {area:2261}, {area:2298}, {npc:10667} and {area:3197}) take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "在{zone:1423}的{area:2627}擊殺{npc:14564}練等",

	-- Step 103: Marris Stead
	-- {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride south to the {area:2260}, the farm north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it. Coming close enough to see the Blightcaller in front of the house completes the scouting.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "",

	-- Step 104: Undercroft
	-- {area:2261} Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "向西南騎到{area:2261}。土堆就在裡面。{npc:11886}是精英：建議組隊。\n小心：米庫提奧會帶來大約四隻非精英的幫手。牠們是走到墳墓那裡，而不是當場出現。",

	-- Step 106: Chromie
	-- {npc:10667} Chromie · {area:3197} Chillwind Camp
	["{npc:10667} waits upstairs in the ruined inn on the west side of Andorhal, on the way back to {area:3197}."] = "{npc:10667}在安多哈爾西側廢棄旅店的樓上等著，就在回{area:3197}的路上。",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",

	-- Step 108: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "向西南騎回{area:3197}。",
	-- {zone:1453} Stormwind
	["Flint's next task goes to {zone:1453}: you are level 60 now, skip it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "回到{area:1770}：{npc:9861}和{npc:9860}在最深處的洞室守護著{npc:9517}。",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "回程路上，掘泥摧毀者在{area:2743}與{area:3425}之間的沙丘上遊蕩。{npc:15181}要到58級才會提供{quest:8304}。",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "飛往{area:16}的{area:3137}，沿著道路向西騎往剛越過{zone:1440}邊界的{area:2358}。",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "飛往{zone:1447}的{area:3137}，沿著道路向西騎往剛越過{zone:1440}邊界的{area:2358}。",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "沿著道路從山口向西南前往{area:3425}。",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "下到{area:702}，搭船前往{area:442}，再轉船前往{area:17203}。為{npc:14722}準備六十份絲綢、六十份魔紋布和六十份{item:14047}：缺少的到拍賣場購買。",
	-- ["Grind to 58"] = "練到58級",
	-- ["Grind to 59"] = "練到59級",
	-- ["Grind to 60"] = "練到60級",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "使用爐石回到{area:1519}，學習你的60級法術。升級路線到此結束：接下來請看聲望和地城指南。",
	-- ["Into {zone:1451}"] = "進入{zone:1451}",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "繼續沿路向西，前往溫泉旁{npc:9298}的營地。",
	-- ["Level 60"] = "60級",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "騎回{area:3137}，飛往{area:2255}。",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "沿著環形山北面山壁向西騎，前往西北角爬升進入{zone:1451}的山口。",
	-- ["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "組隊打{area:2057}（{area:28}東南部的{area:2298}）或{area:2279}代替練等能更快達到目標。若要單人練等，跳過此步驟。",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "組隊打{area:2057}（{zone:1422}東南部的{area:2298}）或{area:2279}代替練等能更快達到目標。若要單人練等，跳過此步驟。",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "組隊打{zone:1444}的{area:2577}代替練等能更快達到目標。若要單人練等，跳過此步驟。",
	-- ["Shaman training"] = "薩滿訓練",
	-- ["Take the boat from {area:442} to {area:702}."] = "從{area:442}搭船前往{area:702}。",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "在{area:2361}搭乘飛行路線飛往{area:442}。",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "從{npc:9298}西邊位於{area:618}的入口進入{area:1769}隧道，沿著{area:493}的岔路前往{area:2361}。{npc:11939}在湖岸邊做研究。",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "搭乘{area:2257}前往{zone:1455}。{npc:14724}和{npc:14723}各要六十份毛料、六十份絲綢和六十份魔紋布，接著是六十份{item:14047}：每種共120份，從你的背包或拍賣場取得。",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "{npc:7446}熊在{area:2250}南邊的雪谷中遊蕩。",
	-- ["Toward the north-west pass"] = "前往西北山口",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "你從{area:392}開始，上一份指南讓你用爐石回到這裡。飛往{area:415}。",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "在{zone:1451}{area:2743}東邊的沙丘擊殺{npc:11741}練等",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "在{area:139}的{area:2627}擊殺{npc:14564}練等",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "在{zone:1452}{area:2250}南邊的山谷擊殺{npc:7446}練等",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770}是{area:1763}後方、道路西邊的洞穴。在洞裡的四個火盆上使用{item:12906}。擊殺沿途的怒爪熊和魔爪狼以取得{item:11172}。",
	-- ["{area:2057} (optional)"] = "{area:2057}（可選）",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057}適合58到60級；{quest:5505}在下方的{area:3197}繳交。",
	-- ["{area:2577} (optional)"] = "{area:2577}（可選）",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577}適合55到60級；下方擊殺{npc:7446}的練等路線可以讓你單人練到59級。",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}：在{zone:1452}完成，保留此任務",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}，如果你有三十份{quest:6031}",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}，旅店老闆",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}，在聯盟帳篷旁",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}：上一份指南用爐石把你送到這裡，所以這一步通常會立即完成",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}，如果你在{area:618}找到了火酒瓶",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085}：{area:618}的{npc:9298}，保留此任務",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}、{area:361}、{area:618}與瘟疫之地",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453}沒有薩滿訓練師：從{object:28027}搭乘{area:2257}前往{zone:1455}，向{npc:258098}學習你的60級法術。",
}
