-- Chinese (traditional) (zhTW): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "30級時的四件護甲（鎖甲、頭盔、護手、護腿），途中還有一面盾牌。",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "20級時，{object:172958}的{npc:3354}會派你去找{area:378}的{npc:6394}。",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "20級時，{zone:1456}的戰士訓練師{npc:3041}會派你去找{area:378}的{npc:6394}。",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "20級時，{zone:1458}的戰士訓練師{npc:4595}會派你去找{area:378}的{npc:6394}。",

	-- Step 4: Trial at the Field of Giants
	-- {area:378} Camp Taurajo · {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "飛往{area:378}。營地南邊的{area:390}散布著異種蠍土丘：那裡的異種蠍帶著顫抖的觸角。",
	["Twitching Antennae from the silithid"] = "從異種蠍身上取得顫抖的觸角",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1838} Brutal Armor
	["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878}在{area:380}東邊的路旁紮營。{quest:1838}是30級任務；你可以現在接下，順路收集材料。",

	-- Step 6: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "{area:1717}的魯古格",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "魯古格是{area:1717}裡的精英野豬人，那是{zone:1413}南端的地城；他會掉落{item:6841}。{area:1717}是地城：建議組隊。",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}，來自魯古格",

	-- Step 7: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "{area:2160}位於石爪山脈{area:461}的東端。那裡的狗頭人會掉落煙霧鐵錠。",
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["Smoky Iron Ingots from the Windshear kobolds"] = "從風剪狗頭人身上取得煙霧鐵錠",

	-- Step 8: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "希爾斯布萊德礦工",
	-- {zone:1424} Hillsbrad Foothills · {item:7127} Powdered Azurite · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "希爾斯布萊德礦工在{zone:1424}西部的礦坑工作；他們會掉落{item:7127}。從{zone:1454}搭飛艇前往{zone:1420}，再向南騎過{zone:1421}。",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127} from the Hillsbrad Miners"] = "從希爾斯布萊德礦工身上取得{item:7127}",

	-- Step 9: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "鐵錠",
	-- {item:2772} Iron Ore · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "礦工可用{item:2772}熔煉鐵錠（{skill:186}125）；其他人在{zone:1454}的拍賣場購買。",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "鐵錠：{npc:8673}",

	-- Step 10: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "回到{area:380}東邊路旁的{npc:5878}那裡。{quest:1848}是第一件；接著他會派你去找三位工匠製作其餘部件。",

	-- Step 11: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408}在{zone:1411}海岸的{area:367}。",

	-- Step 12: Satyr Hooves
	-- {area:429} Xavian · {zone:1440} Ashenvale
	["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "{area:429}的薩特在{zone:1440}東部紮營，魔草薩特在更西邊；兩者都會掉落完整的薩特之蹄。",
	-- {quest:1842} Satyr Hooves
	["Uncloven {quest:1842}"] = "完整的{quest:1842}",

	-- Step 15: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "{npc:6167}在石爪山脈西南部、奇美拉雛獸和小奇美拉附近遊蕩；她會掉落{item:6840}。",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "從{npc:6167}身上取得{item:6840}",

	-- Step 17: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron
	["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "從{zone:1454}搭飛艇前往{zone:1420}；{zone:1458}位於{area:153}下方。",

	-- Step 18: Dragonmaw Shinbones
	-- {zone:1437} Wetlands
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "龍喉獸人在{zone:1437}中部、道路南邊紮營；龍喉襲擊者、龍喉沼澤行者、龍喉百夫長、龍喉暗影守衛和龍喉白骨守衛都會掉落結實的龍喉脛骨。",
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Sturdy Dragonmaw Shinbones"] = "結實的龍喉脛骨",
}
