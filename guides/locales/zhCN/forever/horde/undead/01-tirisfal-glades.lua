-- Chinese (simplified) (zhCN): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "你在{area:154}南端的墓穴中苏醒。{npc:1568}就在外面等候。",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "沿小路向北进入{area:154}；暗影牧师萨维斯站在教堂前。",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "{npc:1501}",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "僵尸在墓地和教堂东边的房屋周围蹒跚游荡。",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church"] = "{npc:1661}，在教堂旁",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer"] = "{npc:2119}，战士训练师",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "{npc:2122}，潜行者训练师",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "{npc:2123}，教堂里的牧师训练师",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "{npc:2124}，法师训练师，在教堂里",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "{npc:2126}，术士训练师",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "{area:154}的训练师站在教堂周围",

	-- Step 5: Aramis Hammerhand and Venya Marthand
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667}"] = "{npc:244808}和{npc:5667}",
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808}和{npc:5667}站在教堂旁。",
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}：给{npc:244808}的卷轴",

	-- Step 6: Rattlecages, scavengers and duskbats
	["Rattlecages, scavengers and duskbats"] = "骷髅、食腐狼和夜行蝙蝠",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "{npc:1890}在{area:154}北半部的废弃房屋里游荡。{npc:1508}和夜行蝙蝠在村子周围游荡；{npc:1509}和{npc:1513}在村子东侧。",

	-- Step 7: Rattlecage skulls
	["Rattlecage skulls"] = "骷髅的头骨",
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "废弃房屋里的{npc:1890}掉落头骨。",

	-- Step 8: Back to the church
	["Back to the church"] = "返回教堂",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}，在教堂里",

	-- Step 9: Aramis Hammerhand and Venya Marthand
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "圣骑士：用{spell:635}治疗教堂周围的五名{npc:259377}后，{quest:90902}即完成。",

	-- Step 10: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662}在{area:154}北部的废弃房屋旁。",

	-- Step 11: Night Web's Hollow
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "向西前往洞穴。{npc:1504}在洞外；{npc:1505}和被网住的被遗忘者在洞内。",
	-- {npc:244808} Aramis Hammerhand
	["Free six Webbed Victims inside the cave for {npc:244808}"] = "为{npc:244808}解救洞内六名被网住的被遗忘者",
	["Webbed Victims"] = "被网住的被遗忘者",

	-- Step 12: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "返回{area:154}",

	-- Step 13: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin
	["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}：{npc:246143}逃进了教堂西边的山丘。",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "向{npc:246143}提供帮助",

	-- Step 14: The Scarlet farm
	["The Scarlet farm"] = "血色农场",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "{npc:1506}和血色新兵占据着{area:154}东边的农场。{npc:1919}在农舍之间游荡：他的遗骸用于{quest:6395}。",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}，来自{npc:1919}",

	-- Step 15: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090}在教堂旁的{area:154}墓地里。",

	-- Step 17: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667}站在血色农场南端。",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "沿东北方的道路离开{area:154}。{npc:6784}站在{area:156}的农舍旁。",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}是一个巨大的憎恶，在稍往东的路上巡逻。{item:12737}生长在他周围的路旁。",

	-- Step 21: Brill
	-- {area:159} Brill · {npc:10665} Junior Apothecary Holland · {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "沿道路向东到{area:159}。{npc:10665}站在镇子西北边缘；{area:2119}是镇中央的大旅店，{npc:1515}站在旅店前。",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}，圣骑士训练师",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "向{npc:1496}索取报告",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "{area:159}的训练师在旅店内外",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "对镇子周围五名闲着的亡灵卫兵使用{item:286176}",

	-- Step 23: Doom Weed
	-- {quest:5482} Doom Weed · {area:159} Brill
	["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482}生长在{area:159}北边的墓地田野里。",

	-- Step 25: Dry Branches
	["Dry Branches"] = "干枯的树枝",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "干枯的树枝散落在{area:159}西南边缘的地上。",

	-- Step 26: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "埃莉诺·沙克尔顿在镇子西南方不远处扎营。",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "在她的营火旁/sit，直到获得{spell:1229451}",

	-- Step 27: Fields west of Brill
	-- {area:159} Brill
	["Fields west of {area:159}"] = "{area:159}西边的田野",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525}和{npc:1526}在{area:159}西边的田野里蹒跚游荡；黑暗犬在更西边、靠近{npc:10666}的地方游荡。",

	-- Step 28: Gordo
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "向{npc:10666}索取报告",

	-- Step 29: Calvin Montague
	-- {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer · {npc:6784} Calvin Montague
	["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "继续向西走到{area:156}。{npc:1519}站在农场里；农舍旁的{npc:6784}想和你决斗：和他对话。",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "在决斗中击败{npc:6784}",

	-- Step 30: Hearth to Brill
	-- {area:159} Brill
	["Hearth to {area:159}"] = "用炉石返回{area:159}",

	-- Step 31: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan"] = "{npc:2132}，在药剂师乔汉旁",
	["in the inn: ask him about cooking"] = "在旅店里：向他询问烹饪",
	-- {npc:265944} William Pickman
	["Talk to {npc:265944}"] = "与{npc:265944}交谈",
	["The Wanted poster by the inn"] = "旅店旁的通缉布告",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}，在城镇大厅里",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}，在旅店里",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "从{npc:2118}处购买{item:2320}，交给格莉丝·戴玛",

	-- Step 32: Greater Duskbats
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats"] = "{npc:1553}",
	-- {area:159} Brill
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "{npc:1553}在{area:159}周围的田野上空和北边的道路沿线飞行。",

	-- Step 33: Rot Hide graveyards
	["Rot Hide graveyards"] = "腐皮豺狼人墓地",
	-- {area:159} Brill
	-- plural, as words: Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber
	["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "{npc:1941}在{area:159}北边的墓地里挖掘；所有腐皮豺狼人都会掉落脓液。",

	-- Step 34: Maggot Eye
	-- {npc:1753} Maggot Eye
	-- plural, as words: Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "{npc:1675}占据着更北边的山丘。{npc:1753}（11级）站在海岸南边山丘上的营地里：先清理他周围的豺狼人。",

	-- Step 35: Vile Fin murlocs
	["Vile Fin murlocs"] = "邪鳍鱼人",
	["The Vile Fin murlocs line the north shore."] = "邪鳍鱼人遍布北部海岸。",

	-- Step 36: Brill
	-- {area:159} Brill
	["Follow the road south back to {area:159}."] = "沿道路向南返回{area:159}。",

	-- Step 37: Deathguard Linnea
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "沿道路从{area:159}向东南经过飞艇塔。亡灵卫兵林奈、亡灵卫兵克里斯托弗和{npc:3549}在路旁扎营。",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "向{npc:251001}索取报告",

	-- Step 38: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "沿道路返回{area:159}。",

	-- Step 39: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "沿道路向西北到{area:157}。{npc:1657}在磨坊南边的墓地里游荡；妮萨·阿加曼德、格里高·阿加曼德和{npc:1656}在磨坊里出没。断骨士兵和{npc:1523}掉落肋骨，{npc:1522}掉落头骨，其中任何一个都可能掉落{item:2839}。从这里开始，击杀路过的夜行蝙蝠和黑暗犬：{npc:3549}需要它们的翅膀和皮。",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}，稀有掉落",
	["Only if the letter dropped"] = "仅当信件已掉落",

	-- Step 40: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "{object:375}",
	["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "从磨坊向西南走：南瓜生长在索利丹农场西北方、血色十字军占据的田里。",

	-- Step 41: Crusader's Outpost
	["Crusader's Outpost"] = "十字军前哨",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "{npc:1535}守卫着南瓜田西边不远处的前哨。{npc:275954}被关在里面：和他交谈，一直跟着他直到他离开。",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "护送{npc:275954}离开前哨",

	-- Step 42: Vile Fin shore
	["Vile Fin shore"] = "邪鳍海岸",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "前哨北边的海岸上还有更多邪鳍鱼人。",

	-- Step 43: Paladin: Whispering Forest
	-- {area:16616} Whispering Forest
	["Paladin: {area:16616}"] = "圣骑士：{area:16616}",
	-- {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "向西进入{area:16616}；{npc:246389}和{npc:259190}在森林边缘扎营。",

	-- Step 44: Shadowvale
	-- {area:16881} Shadowvale · {item:286269} Glowing Crystal Fragment
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881}是林地西缘的洼地。{npc:260428}和影谷秘法师掉落骨头；瓶子散落在它们中间的地上，{item:286269}在南端。",

	-- Step 47: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}，在旅店里",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "{npc:1931}，在城镇大厅的地下室",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}：交给{zone:1458}的{npc:4568}",

	-- Step 48: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}站在{area:159}。{npc:6390}在镇子北边山丘上的陵墓里等候：打开大门与他战斗。",

	-- Step 49: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "从{area:159}向南走到{area:153}，再往下进入{zone:1458}。{npc:5675}站在{object:36082}。血色营地就在废墟西边。",

	-- Step 50: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "从{area:159}向南走到{area:153}，再往下进入{zone:1458}。{npc:4568}站在{object:36082}。血色营地就在废墟西边。",

	-- Step 51: The Scarlet camp
	["The Scarlet camp"] = "血色营地",
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "沿道路从{area:159}向西南到血色十字军营地。{npc:1662}站在营地南端；那里的每个血色十字军都可能掉落戒指。",

	-- Step 52: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098}在营地南端的{npc:1662}旁边。",

	-- Step 54: Deathguard Terrence
	-- {area:159} Brill
	["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "沿东南方的道路离开{area:159}；亡灵卫兵特伦斯站在飞艇塔之前的路上。",

	-- Step 55: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009}站在{npc:1495}的营地。",

	-- Step 56: Balnir Farmstead
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897}占据着营地东南方不远处的农场。{item:275851}散落在教徒中间的地上，教徒身上也带着一些。",

	-- Step 57: Balnir graves
	["Balnir graves"] = "巴尼尔墓地",
	-- {quest:99142} Tomb Weed
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "沿道路向东。{npc:1529}和{npc:1532}在农场东侧的墓地里出没，{quest:99142}也生长在那里。",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}，在农场的花园里",

	-- Step 58: Captain Vachon
	-- {npc:1664} Captain Vachon
	-- plural, as words: Scarlet Friars = {npc:1538} Scarlet Friar
	["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "{npc:1538}在墓地东北方不远处扎营；{npc:1664}站在他们中间。",

	-- Step 59: Vicious Night Web Spiders
	-- plural, as words: Vicious Night Web Spiders = {npc:1555} Vicious Night Web Spider
	["Vicious Night Web Spiders"] = "{npc:1555}",
	["The spiders lurk in the woods at the far east end of the glades."] = "蜘蛛潜伏在林地最东端的树林里。",

	-- Step 60: Hides for the Forsaken
	-- plural, as words: Duskbats = {npc:1512} Duskbat
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "夜行蝙蝠和黑暗犬在向西返回的道路沿线游荡；顺路收集完翅膀和皮。",

	-- Step 61: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "{npc:1495}的营地",

	-- Step 62: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "{npc:2211}，在城镇大厅的地下室",

	-- Step 63: Captain Melrache
	-- {area:159} Brill · {area:162} Brightwater Lake · {npc:1665} Captain Melrache · {area:459} Scarlet Watch Post
	-- plural, as words: Scarlet Bodyguards = {npc:1660} Scarlet Bodyguard
	["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "沿道路从{area:159}向东北经过{area:162}。{npc:1665}和他的两名{npc:1660}占据着{area:459}北边、东北海岸上的血色瞭望塔：先拉保镖。",

	-- Step 64: Executor Zygand
	-- {area:159} Brill
	["Back to {area:159}."] = "返回{area:159}。",

	-- Step 65: Leonid Barthalomew
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "沿道路向西经过{area:157}到{area:16616}。莱尼德·巴萨罗梅站在{npc:246389}营地北边不远处。",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "听莱尼德·巴萨罗梅和{npc:246378}说话，然后再次与他交谈",

	-- Step 67: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661}在{area:153}下方，飞艇塔旁边。{npc:5675}在{object:36082}：在他旁边的召唤法阵上使用{item:6284}，击败虚空行者。{npc:4606}在{object:36070}。{npc:4568}也在{object:36082}。",

	-- Step 68: Zeppelin to Durotar
	-- {zone:1411} Durotar
	["Zeppelin to {zone:1411}"] = "乘飞艇前往{zone:1411}",
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "从{area:159}向东南走到{area:153}外的飞艇塔，登上前往{zone:1454}的飞艇（另一艘前往{object:3202}）。",
	["Zeppelin tower"] = "飞艇塔",

	-- Step 69: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:815} Southfury River · {area:379} Far Watch Post · {area:380} The Crossroads
	["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "飞艇停靠在{zone:1454}正门东北方的塔上。沿道路向南进入{zone:1411}，从{area:379}下方过{area:815}的桥，然后沿道路向西到{area:380}。",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}，双足飞龙管理员",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "南瓜生长在索利丹农场西北方、血色十字军占据的田里。",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "蜘蛛潜伏在林地最东端的树林里。{npc:276020}是一个失控的憎恶，在它们西北方不远处游荡。{npc:276020}是精英：建议组队。",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "飞艇停靠在{zone:1454}正门东北方的塔上。沿道路向南进入{zone:1411}，从{area:379}下方过{area:815}的桥，然后沿道路向西到{area:380}。",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "继续向西走到{npc:6784}处并与他交谈：他想和你决斗。",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "向西南走到{area:156}；亡灵卫兵希米尔站在农场里。",
	-- ["{item:286326}, from {npc:276020}"] = "{item:286326}，来自{npc:276020}",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}：{npc:276020}，东边的一个精英憎恶",
}
