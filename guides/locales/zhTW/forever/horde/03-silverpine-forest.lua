-- Chinese (traditional) (zhTW): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Orgrimmar
	-- {area:1637} Orgrimmar
	["To {area:1637}"] = "前往{area:1637}",
	-- {area:380} Crossroads · {area:1637} Orgrimmar · {npc:3310} Doras · {object:172982} Valley of Strength
	["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "從{area:380}沿著道路向東北前往{area:1637}，從正門走進去。雙足飛龍管理員{npc:3310}站在{object:172982}的塔上。",

	-- Step 2: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "{zone:1454}職業任務",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018}站在城市西側的{object:172961}。",

	-- Step 3: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "飛往{area:1638}：{npc:3033}在{area:1639}為你訓練。天裔精靈：之後飛回{zone:1454}搭飛艇。",

	-- Step 4: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}；{npc:11802}在{area:2361}。神殿靈珠躺在{area:656}的湖底，幾分鐘內就會消失：拿到一個後直接游到西北岸的{area:2362}，在那裡使用它，然後與{npc:11799}交談。",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}：{area:384}，下一份指南",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}，在{area:2362}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {zone:1454} Orgrimmar
	["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{area:2361}的{npc:11798}會載德魯伊飛到那裡；然後繼續飛往{zone:1454}搭飛艇",

	-- Step 5: Zeppelin to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Zeppelin to {zone:1420}"] = "搭飛艇前往{zone:1420}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {object:3202} Grom'gol
	["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "飛艇塔就在{zone:1454}正門外。搭乘前往{zone:1420}的飛艇（另一艘前往{object:3202}）。",
	["Zeppelin tower"] = "飛艇塔",

	-- Step 6: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152}在{area:159}訓練聖騎士，從飛艇塔沿著道路往北走一小段就到。之後沿同一條路回來前往銀松森林。",

	-- Step 7: Into Silverpine
	["Into Silverpine"] = "進入銀松森林",
	-- {area:153} Ruins of Lordaeron · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "飛艇停靠在{area:153}外的塔。沿著道路向西經過廢墟，再往南進入{zone:1421}；沿著道路前往{area:228}。",
	["Road to Silverpine"] = "前往銀松森林的道路",

	-- Step 8: Sepulcher
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228}是森林中央的被遺忘者墓穴城鎮。你需要找的人都站在墓穴入口周圍；蝙蝠管理員{npc:2226}就在入口東邊。",

	-- Step 9: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "沿著道路向南走。{object:1627}在路旁，位於焚木村北邊。",

	-- Step 10: Sepulcher
	-- {area:233} Ambermill
	["{area:233} comes later, on the southern loop"] = "{area:233}稍後在南方路線時前往",

	-- Step 11: The Dead Field
	-- {area:228} Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "在{area:228}北邊。{npc:1983}在{area:240}出沒：殺了它，然後走過整片田地。",

	-- Step 12: Strange Lockbox
	-- {object:177790} Strange Lockbox · {area:240} The Dead Field · {item:15882} Half Pendant of Aquatic Endurance · {quest:30} Trial of the Sea Lion
	["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790}在{area:240}西邊的海岸上。裡面有{quest:30}要的{item:15882}。",

	-- Step 13: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "沿著道路向東北前往{area:238}的尤瑞克家。",

	-- Step 14: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978}在房子東北方等候。護送他回到{npc:1950}那裡；途中會有座狼攻擊。",

	-- Step 16: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "",

	-- Step 17: Hearth to the Sepulcher
	-- {area:228} Sepulcher
	["Hearth to the {area:228}"] = "用爐石回{area:228}",

	-- Step 18: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:228} Sepulcher
	["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593}在{area:228}東邊湖岸的渡口。",

	-- Step 20: Quinn Yorick
	["North again to the Yoricks' house."] = "",

	-- Step 21: Vile Fin murlocs
	["Vile Fin murlocs"] = "",
	-- {area:172} Fenris Isle
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "",

	-- Step 22: Fenris Isle
	-- {area:172} Fenris Isle · {area:235} Fenris Keep
	["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "沿著湖岸向東南走，游到{area:172}。島上滿是腐皮豺狼人；每一種都會掉落膿液。不要進入島北側的{area:235}，除非你要做可選的壁龕任務：那裡的豺狼人是18-22級。",
	-- {item:3317} A Talking Head
	["{item:3317}: a rare drop from the gnolls"] = "{item:3317}：豺狼人的稀有掉落",
	-- {object:1599} Shallow Grave
	["{object:1599}, just east of the keep"] = "{object:1599}，就在城堡東邊",
	-- {object:112888} Dusty Shelf
	["{object:112888}, inside the keep"] = "{object:112888}，在城堡裡",

	-- Step 23: Sepulcher
	-- {area:228} Sepulcher
	["Swim back and follow the road west to the {area:228}."] = "游回去，沿著道路向西前往{area:228}。",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}：{quest:516}，在南方路線",

	-- Step 24: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "沿著道路向東南前往{area:233}。達拉然保衛者守衛外圍，達拉然法師守著城鎮；兩者都會掉落墜飾。達拉然巫師和達拉然衛士在周圍的道路巡邏。不要進入中央，{npc:2120}站在那裡。",

	-- Step 25: Beren's Peril
	-- {quest:516} Beren's Peril
	-- plural, as words: Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "",

	-- Step 27: Lordamere Lake shore
	-- {area:1338} Lordamere Lake
	["{area:1338} shore"] = "{area:1338}湖岸",
	-- {area:237} Decrepit Ferry · {area:228} Sepulcher
	-- plural, as words: Vile Fin Lakestalkers = {npc:1909} Vile Fin Lakestalker
	["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "邪鰭巡湖者和邪鰭智者在{area:237}南邊、{area:228}東邊的湖岸上。",
	-- {npc:1909} Vile Fin Lakestalker · {area:1338} Lordamere Lake · {zone:1421} Silverpine Forest
	["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "在{zone:1421}的{area:1338}擊殺{npc:1909}練等",

	-- Step 28: Apothecary Renferrel
	-- {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["Keep it: {npc:2216} in {area:272}, a later guide"] = "保留此任務：{area:272}的{npc:2216}，之後的指南",

	-- Step 29: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "",

	-- Step 30: Brill
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "沿著道路向北離開銀松森林進入{zone:1420}，繼續前往{area:159}：{npc:246152}在那裡訓練聖騎士。飛艇塔沿著道路往南走一小段就到。",

	-- Step 31: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",
	-- {zone:1420} Tirisfal Glades · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar
	["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "沿著道路向北離開銀松森林進入{zone:1420}，向東前往{area:153}外的飛艇塔。搭乘前往{zone:1454}的飛艇。",

	-- Step 32: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength · {object:173016} Borstan's Firepit
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "從正門走進去。{npc:268701}站在{object:172982}；{object:173016}往北走幾步就到。",

	-- Step 33: Cleft of Shadow
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{object:172960}是{object:172982}下方的峽谷；{npc:3216}站在峽谷盡頭。",

	-- Step 34: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348}和{npc:3347}在the Drag經營煉金店；{npc:11046}在隔壁。",

	-- Step 35: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "香蒲和長矛草沿著the Drag東邊{object:172958}的水邊生長。",

	-- Step 37: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {npc:3310} Doras · {object:172982} Valley of Strength
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684}和{npc:268682}坐在{object:172957}的Grommash Hold後面；光滑巨石就在他們周圍。趁在城裡時訓練（德魯伊和聖騎士在這裡沒有訓練師）。下一份指南從{object:172982}的雙足飛龍管理員{npc:3310}開始。",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}，在Grommash Hold裡",
	-- {area:380} Crossroads
	["Keep it: Thork at the {area:380}"] = "保留此任務：{area:380}的索克",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}：{quest:93739}，拜訪部落各領袖",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "與Grommash Hold裡的{npc:3230}交談",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "與Grommash Hold裡的{npc:10540}交談",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Moonrage Bloodhowlers"] = "月怒血嘯者",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "雜斑座狼在房子周圍的山丘徘徊。然後沿著湖岸向南走：那裡的邪鰭切割者和邪鰭潮行者會掉落魚人眼睛。",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "再次向北前往尤瑞克家。{quest:425}潛伏在房子西邊不遠處。",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "在{area:228}北邊。奈塔拉什在{area:240}出沒：殺了它，然後走過整片田地。",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "在難民的東北方，鴉爪苦工和鴉爪守護者在森林東南部的{quest:516}廢墟出沒。",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "僅限{npc:1938}給了你{quest:98298}時：血嘯者在{area:233}西南方、焚木村東邊的樹林中徘徊；牠們會掉落{item:280375}。",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "病怏怏的難民和憔悴的難民在焚木村南邊、通往{area:230}的道路上蹣跚而行。",
	-- ["The refugees"] = "難民",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790}在{area:240}西邊的海岸上。裡面有{quest:30}要的{item:15882}。",
	-- ["Worgs and murlocs"] = "座狼與魚人",
	-- ["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228}是森林中央的被遺忘者墓穴城鎮。你需要找的人都站在墓穴入口周圍；蝙蝠管理員{npc:2226}就在入口東邊。",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}：如果他提供就接受；它可能接在他的{quest:98298}系列之後，而本路線不做那個系列",
}
