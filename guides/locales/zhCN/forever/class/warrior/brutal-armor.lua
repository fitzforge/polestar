-- Chinese (simplified) (zhCN): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "30级的四件护甲（锁甲、头盔、护手、护腿），途中还有一面盾牌。",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "20级时，{object:172958}的{npc:3354}会让你去找{area:378}的{npc:6394}。",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "20级时，{zone:1456}的战士训练师{npc:3041}会让你去找{area:378}的{npc:6394}。",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "20级时，{zone:1458}的战士训练师{npc:4595}会让你去找{area:378}的{npc:6394}。",

	-- Step 4: Trial at the Field of Giants
	-- {area:378} Camp Taurajo · {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "飞往{area:378}。营地以南的{area:390}散布着异种蝎土丘：那里的异种蝎携带颤抖的触角。",
	["Twitching Antennae from the silithid"] = "从异种蝎身上获得颤抖的触角",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1838} Brutal Armor
	["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878}在{area:380}以东的路边扎营。{quest:1838}是30级任务；你现在就可以接受，并在路上收集所需物品。",

	-- Step 6: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "{area:1717}中的鲁古格",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "鲁古格是{area:1717}中的精英野猪人，那是{zone:1413}南端的地下城；他掉落{item:6841}。{area:1717}是地下城：建议组队。",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}，来自鲁古格",

	-- Step 7: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "{area:2160}位于石爪山脉{area:461}的东端。那里的狗头人掉落烟雾铁锭。",
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["Smoky Iron Ingots from the Windshear kobolds"] = "从风剪狗头人身上获得烟雾铁锭",

	-- Step 8: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "{npc:2269}",
	-- {zone:1424} Hillsbrad Foothills · {item:7127} Powdered Azurite · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "{npc:2269}在{zone:1424}西部的矿洞里工作；他们掉落{item:7127}。从{zone:1454}乘飞艇前往{zone:1420}，然后向南穿过{zone:1421}。",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127} from the Hillsbrad Miners"] = "{item:7127}，来自{npc:2269}",

	-- Step 9: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "铁锭",
	-- {item:2772} Iron Ore · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "矿工用{item:2772}熔炼铁锭（{skill:186} 125）；其他人在{zone:1454}的拍卖行购买。",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "铁锭：{npc:8673}",

	-- Step 10: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "回到{area:380}以东路边的{npc:5878}处。{quest:1848}是第一件；之后他会让你去找三位工匠制作其余部件。",

	-- Step 11: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408}在{zone:1411}海岸的{area:367}。",

	-- Step 12: Satyr Hooves
	-- {area:429} Xavian · {zone:1440} Ashenvale
	["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "{area:429}的萨特在{zone:1440}东部扎营，更西边还有魔草萨特；两者都掉落完整的萨特之蹄。",
	-- {quest:1842} Satyr Hooves
	["Uncloven {quest:1842}"] = "完整的{quest:1842}",

	-- Step 15: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "{npc:6167}在石爪山脉西南部的奇美拉雏兽和奇美拉幼崽附近游荡；她掉落{item:6840}。",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "从{npc:6167}身上获得{item:6840}",

	-- Step 17: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron
	["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "从{zone:1454}乘飞艇前往{zone:1420}；{zone:1458}位于{area:153}之下。",

	-- Step 18: Dragonmaw Shinbones
	-- {zone:1437} Wetlands
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "龙喉兽人在{zone:1437}中部、道路南边扎营；龙喉袭击者、龙喉沼泽行者、龙喉百夫长、龙喉暗影守卫和龙喉白骨守卫都会掉落{item:7134}。",
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Sturdy Dragonmaw Shinbones"] = "{item:7134}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:287} Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "希尔斯布莱德矿工（{area:287}）在{zone:1424}西部的矿洞里干活；他们掉落{item:7127}。从{zone:1454}乘飞艇前往{zone:1420}，再向南骑行穿过{zone:1421}。",
	-- ["{area:287} Miners"] = "希尔斯布莱德矿工（{area:287}）",
	-- ["{item:7127} from the {area:287} Miners"] = "从希尔斯布莱德矿工（{area:287}）身上获得{item:7127}",
}
