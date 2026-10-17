-- Chinese (simplified) (zhCN): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Orgrimmar
	-- {area:1637} Orgrimmar
	["To {area:1637}"] = "前往{area:1637}",
	-- {area:380} Crossroads · {area:1637} Orgrimmar · {npc:3310} Doras · {object:172982} Valley of Strength
	["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "从{area:380}沿道路向东北前往{area:1637}，从正门进城。双足飞龙管理员{npc:3310}站在{object:172982}的塔上。",

	-- Step 2: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "{zone:1454}职业任务",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018}在城西侧的{object:172961}。",

	-- Step 3: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "飞往{area:1638}：{npc:3033}在{area:1639}训练你。天裔：之后飞回{zone:1454}乘坐飞艇。",

	-- Step 4: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}；{npc:11802}在{area:2361}。神殿灵珠躺在{area:656}的湖底，几分钟内就会消失：拿到一个后直接游到西北岸的{area:2362}，在那里使用它并与{npc:11799}交谈。",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}：{area:384}，见下一个指南",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}，在{area:2362}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {zone:1454} Orgrimmar
	["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{area:2361}的{npc:11798}载德鲁伊飞往那里；然后继续飞往{zone:1454}乘坐飞艇",

	-- Step 5: Zeppelin to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Zeppelin to {zone:1420}"] = "乘飞艇前往{zone:1420}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {object:3202} Grom'gol
	["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "飞艇塔就在{zone:1454}正门外。乘坐前往{zone:1420}的飞艇（另一艘去{object:3202}）。",
	["Zeppelin tower"] = "飞艇塔",

	-- Step 6: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152}在{area:159}训练圣骑士，从飞艇塔沿道路向北步行不远即到。之后沿同一条路回来，前往银松森林。",

	-- Step 7: Into Silverpine
	["Into Silverpine"] = "进入银松森林",
	-- {area:153} Ruins of Lordaeron · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "飞艇降落在{area:153}外的塔上。沿道路向西经过废墟，再向南进入{zone:1421}；沿道路前往{area:228}。",
	["Road to Silverpine"] = "通往银松森林的道路",

	-- Step 8: Sepulcher
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228}是森林中央的被遗忘者墓穴小镇。你要找的人都站在墓穴入口周围；蝙蝠管理员{npc:2226}就在入口东边。",

	-- Step 9: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "沿道路向南。{object:1627}就在路边，焚木村北边。",

	-- Step 10: Sepulcher
	-- {area:233} Ambermill
	["{area:233} comes later, on the southern loop"] = "{area:233}稍后在南线环路中前往",

	-- Step 11: The Dead Field
	-- {area:228} Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "在{area:228}北边。{npc:1983}在{area:240}出没：杀死它，然后穿过田野。",

	-- Step 12: Strange Lockbox
	-- {object:177790} Strange Lockbox · {area:240} The Dead Field · {item:15882} Half Pendant of Aquatic Endurance · {quest:30} Trial of the Sea Lion
	["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790}位于{area:240}西边的海岸上。里面装着{quest:30}所需的{item:15882}。",

	-- Step 13: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "沿道路向东北前往{area:238}的尤瑞克家。",

	-- Step 14: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978}在房子东北边等候。护送他回到{npc:1950}那里；途中会有座狼袭击。",

	-- Step 16: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "",

	-- Step 17: Hearth to the Sepulcher
	-- {area:228} Sepulcher
	["Hearth to the {area:228}"] = "用炉石回到{area:228}",

	-- Step 18: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:228} Sepulcher
	["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593}停在{area:228}东边湖岸的渡口。",

	-- Step 20: Quinn Yorick
	["North again to the Yoricks' house."] = "",

	-- Step 21: Vile Fin murlocs
	["Vile Fin murlocs"] = "",
	-- {area:172} Fenris Isle
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "",

	-- Step 22: Fenris Isle
	-- {area:172} Fenris Isle · {area:235} Fenris Keep
	["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "沿湖岸向东南走，游到{area:172}。岛上到处是腐皮豺狼人；每种都会掉落脓液。除非你要做可选的额外内容，否则别进入岛北侧的{area:235}：那里的豺狼人是18-22级。",
	-- {item:3317} A Talking Head
	["{item:3317}: a rare drop from the gnolls"] = "{item:3317}：豺狼人的稀有掉落",
	-- {object:1599} Shallow Grave
	["{object:1599}, just east of the keep"] = "{object:1599}，就在城堡东边",
	-- {object:112888} Dusty Shelf
	["{object:112888}, inside the keep"] = "{object:112888}，在城堡里",

	-- Step 23: Sepulcher
	-- {area:228} Sepulcher
	["Swim back and follow the road west to the {area:228}."] = "游回去，沿道路向西前往{area:228}。",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}：{quest:516}，在南线环路中完成",

	-- Step 24: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "沿道路向东南前往{area:233}。达拉然保卫者守卫外围，达拉然法师守在镇里；两者都会掉落坠饰。达拉然巫师和达拉然卫士在周围的道路上巡逻。别进入镇中心，{npc:2120}就站在那里。",

	-- Step 25: Beren's Peril
	-- {quest:516} Beren's Peril
	-- plural, as words: Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "",

	-- Step 27: Lordamere Lake shore
	-- {area:1338} Lordamere Lake
	["{area:1338} shore"] = "{area:1338}湖岸",
	-- {area:237} Decrepit Ferry · {area:228} Sepulcher
	-- plural, as words: Vile Fin Lakestalkers = {npc:1909} Vile Fin Lakestalker
	["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "邪鳍巡湖者和邪鳍智者在{area:237}南边、{area:228}东边的湖岸上。",
	-- {npc:1909} Vile Fin Lakestalker · {area:1338} Lordamere Lake · {zone:1421} Silverpine Forest
	["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "在{zone:1421}的{area:1338}刷{npc:1909}",

	-- Step 28: Apothecary Renferrel
	-- {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["Keep it: {npc:2216} in {area:272}, a later guide"] = "留着它：交给{area:272}的{npc:2216}，在之后的指南中",

	-- Step 29: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "",

	-- Step 30: Brill
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "沿道路向北离开银松森林进入{zone:1420}，继续前往{area:159}：{npc:246152}在那里训练圣骑士。飞艇塔沿道路向南步行不远即到。",

	-- Step 31: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",
	-- {zone:1420} Tirisfal Glades · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar
	["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "沿道路向北离开银松森林进入{zone:1420}，再向东前往{area:153}外的飞艇塔。乘坐前往{zone:1454}的飞艇。",

	-- Step 32: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength · {object:173016} Borstan's Firepit
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "从正门进城。{npc:268701}站在{object:172982}；{object:173016}就在北边几步远。",

	-- Step 33: Cleft of Shadow
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{object:172960}是{object:172982}下方的峡谷；{npc:3216}站在它的尽头。",

	-- Step 34: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348}和{npc:3347}在暗巷区经营炼金商店；{npc:11046}就在隔壁。",

	-- Step 35: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "香蒲和矛草长在暗巷区东边{object:172958}的水边。",

	-- Step 37: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {npc:3310} Doras · {object:172982} Valley of Strength
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684}和{npc:268682}坐在{object:172957}的格罗玛什要塞后面；光滑的巨石就在他们周围。趁在城里时训练（德鲁伊和圣骑士在这里没有训练师）。下一个指南从{object:172982}的双足飞龙管理员{npc:3310}开始。",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}，在格罗玛什要塞里",
	-- {area:380} Crossroads
	["Keep it: Thork at the {area:380}"] = "留着它：交给{area:380}的索克",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}：{quest:93739}，游览部落各位领袖",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "与格罗玛什要塞里的{npc:3230}交谈",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "与格罗玛什要塞里的{npc:10540}交谈",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Moonrage Bloodhowlers"] = "月怒血啸者",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "杂斑座狼在房子周围的山丘上游荡。然后沿湖岸向南走：那里的邪鳍切割者和邪鳍潮行者会掉落鱼人的眼球。",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "再次向北前往尤瑞克家。{quest:425}潜伏在房子西边不远处。",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "在{area:228}北边。奈塔拉什在{area:240}出没：杀死它，然后穿过田野。",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "在难民东北边，鸦爪苦工和鸦爪守护者在森林东南部的{quest:516}废墟中出没。",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "仅当{npc:1938}给了你{quest:98298}时：血啸者在{area:233}西南、焚木村东边的林中游荡；它们掉落{item:280375}。",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "病怏怏的难民和哈迦德难民沿着焚木村南边通往{area:230}的道路蹒跚而行。",
	-- ["The refugees"] = "难民",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790}位于{area:240}西边的海岸上。里面装着{quest:30}所需的{item:15882}。",
	-- ["Worgs and murlocs"] = "座狼和鱼人",
	-- ["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228}是森林中央的被遗忘者墓穴小镇。你要找的人都站在墓穴入口周围；蝙蝠管理员{npc:2226}就在入口东边。",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}：如果他提供就接受；它可能接在他的{quest:98298}系列之后，而本路线不做该系列",
}
