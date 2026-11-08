-- Chinese (simplified) (zhCN): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Starts now at 20 at your trainer; four armor pieces at 30 (hauberk, helm, gauntlets, legguards), a shield on the way."] = "",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "20级时，{object:172958}的{npc:3354}会让你去找{area:378}的{npc:6394}。",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "20级时，{zone:1456}的战士训练师{npc:3041}会让你去找{area:378}的{npc:6394}。",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "20级时，{zone:1458}的战士训练师{npc:4595}会让你去找{area:378}的{npc:6394}。",

	-- Step 4: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Fly to {area:378}. {npc:6394} stands in the hut with the leatherworking and tailoring trainers."] = "飞往 {area:378}。{npc:6394} 站在制皮和裁缝训练师所在的小屋内。",

	-- Step 5: Trial at the Field of Giants
	-- {item:7119} Twitching Antenna · {area:390} Field of Giants · {area:378} Camp Taurajo · {item:7120} Ruga's Bulwark
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["You have 30 minutes, and each {item:7119} rots 15 minutes after you loot it, so take the quest only when ready (logging out does not stop the clock). The Silithid Mounds dot the {area:390} south of {area:378}; every silithid drops an antenna. Creepers (level 20-21) and Grubs are the easiest: Swarmers (21-22) call small swarms and Creepers lay eggs that hatch adds. The eastern part of the field has plenty of Creepers. {item:7120}, a shield, is the reward."] = "你有30分钟，而且每份 {item:7119} 都会在拾取后15分钟腐烂，所以准备好后再接任务（下线不会暂停计时）。{area:378} 南面的 {area:390} 散布着异种蝎土丘；每只异种蝎都掉落一根触角。爬行者（20—21级）和格拉布最容易对付：异种群居蝎（21—22级）会召来小虫群，爬行者 会产卵并孵出额外敌人。田地东部有很多 爬行者。奖励是盾牌 {item:7120}。",
	-- {item:7119} Twitching Antenna
	["{item:7119}, from the silithid"] = "{item:7119}，由异种虫掉落",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1838} Brutal Armor · {item:7587} Thun'grim's Instructions
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads: climb the broad ridge on the north or east side. {quest:1838} is a level 30 quest; take it now and gather on the way. {item:7587} list where each material comes from."] = "{npc:5878}的小屋在十字路口东边的{area:1699}顶部：从北侧或东侧宽阔的山脊爬上去。{quest:1838}是30级任务；现在先接取，沿途收集。{item:7587}列出了各项材料的来源。",

	-- Step 7: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "{area:1717}中的鲁古格",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, his guards come with him. Inside take the left path at the first fork, cross the vine bridge over the pig pens, go past the room with the big cauldron: he waits in the room on the right. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "鲁古格是 {area:1717} 内的一名精英野猪人（28 级），该地下城位于 {zone:1413} 最南端；这是五人地下城，需要五人小队，他的守卫会一起进入战斗。进去后第一个岔路走左边，跨过猪圈上方的藤桥，经过有大锅的房间：他在右侧房间里等着。他会施放 {spell:403}，并召唤地行者。药瓶必定掉落。",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}，来自鲁古格",

	-- Step 8: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {spell:116} Frostbolt
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["You need 15 Smoky Iron Ingots. The {area:2160} lies at the east end of {area:461}, east of {area:460}; every Windshear kobold (level 19-23) drops an ingot four kills in five. Stonecutters, Geomancers and Overlords run for help when low; Geomancers cast {spell:116}."] = "需要15块烟雾铁锭。{area:2160} 位于 {area:461} 东端、{area:460} 以东；所有风剪狗头人（19—23级）都有约五分之四的概率掉落一块锭。切石者、地卜师和监工生命值低时会逃跑求援；地卜师会施放 {spell:116}。",
	-- {item:7126} Smoky Iron Ingot
	["{item:7126}, from the Windshear kobolds"] = "{item:7126}，由风剪狗头人掉落",

	-- Step 9: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "{npc:2269}",
	-- {item:7127} Powdered Azurite · {area:271} Southshore · {spell:71} Defensive Stance · {area:272} Tarren Mill
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["You need 10 {item:7127}. The Hillsbrad Miners (level 26-27) work the mine in the hills west of {area:271} and drop the azurite four kills in five; they fight in {spell:71}, sunder your armor and run for help at 30% health. Fly to {area:272} and head south-west."] = "你需要 10 个 {item:7127}。希尔斯布莱德矿工（26-27 级）在 {area:271} 西边山中的矿洞工作，碧蓝石掉率约为五分之四；它们以 {spell:71} 战斗，会破甲，并在生命值降到 30% 时逃跑求援。飞到 {area:272} 后向西南走。",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127}, from the Hillsbrad Miners"] = "{item:7127}，由希尔斯布莱德矿工掉落",

	-- Step 10: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "铁锭",
	-- {item:2772} Iron Ore · {spell:3307} Smelt Iron · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["You need 10 Iron Bars. Miners smelt them from {item:2772} (one ore a bar, {spell:3307} at {skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "你需要10块铁锭。矿工可用{item:2772}熔炼（一块矿石熔成一块锭，{skill:186}达到125后学习{spell:3307}）；其他人可在{zone:1454}拍卖行购买。",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "铁锭：{npc:8673}",

	-- Step 11: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} on {area:1699}. {quest:1848} is the first piece; he then sends you to three crafters, one per piece: take all three."] = "回到{area:1699}的{npc:5878}处。{quest:1848}是第一件装备；之后他会让你去找三名工匠，每人负责一件：三个任务全接。",

	-- Step 12: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast. He wants 7 Uncloven Satyr Hooves."] = "{npc:6408} 位于 {zone:1411} 海岸的 {area:367}。他需要 7 个完整的萨特之蹄。",

	-- Step 13: Satyr Hooves
	-- {area:430} Satyrnaar · {area:431} Splintertree Post · {area:429} Xavian · {spell:6925} Gift of the Xavian
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The satyrs of {area:430}, north-east of {area:431} ({area:429}, level 28-30), and the Felmusk satyrs north-west of the post (25-27) drop a hoof four kills in five. A {area:429} satyr at 15% health may cast {spell:6925} and heal to full: finish it fast or stun it. Hellcallers throw Fireballs from 40 yards; Felmusk satyrs reek in melee and run for help at 15%."] = "{area:431}东北方{area:430}的萨特（{area:429}，28-30级），以及哨站西北方的魔草萨特（25-27级）掉蹄子的概率为五只出四个。{area:429}的萨特在生命值降至15%时可能施放{spell:6925}，恢复满血：尽快击杀或将其击昏。地狱召唤者会在40码外施放火球术；魔草萨特会在近战中散发恶臭，并在生命值降至15%时逃跑求援。",

	-- Step 15: Orm Stonehoof
	-- {npc:6410} Orm Stonehoof · {zone:1456} Thunder Bluff
	["{npc:6410} works on {zone:1456}'s lowest level, close to the blacksmith."] = "{npc:6410} 在 {zone:1456} 的最底层、铁匠附近工作。",

	-- Step 16: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {area:465} Charred Vale · {zone:1443} Desolace · {item:6840} Galvanized Horn · {spell:3396} Corrosive Poison
	["The {npc:6167} (level 28, not elite, larger than the young ones around her) roams the south edge of the {area:465} in south-west Stonetalon, near the road to {zone:1443}. She is the only one: she returns 5 minutes after dying and drops the {item:6840} four kills in five. She spits {spell:3396} from 30 yards."] = "{npc:6167}（28级，非精英，体型比周围的幼崽大）在石爪山脉西南部{area:465}的南缘游荡，靠近通往{zone:1443}的道路。只有这一只：死亡后5分钟刷新，{item:6840}掉落概率为五分之四。她会从30码外喷吐{spell:3396}。",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}，来自{npc:6167}",

	-- Step 18: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {npc:6411} Velora Nitely · {zone:1458} Undercity · {object:36078} Trade Quarter
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Take the zeppelin from {zone:1454} to {zone:1420}; {npc:6411} works in the {zone:1458}'s {object:36078}. She wants 8 Sturdy Dragonmaw Shinbones."] = "搭乘飞艇从 {zone:1454} 前往 {zone:1420}；{npc:6411} 在 {zone:1458} 的 {object:36078} 工作。她需要8根结实的龙喉胫骨。",

	-- Step 19: Dragonmaw Shinbones
	-- {zone:1437} Wetlands · {area:321} Hammerfall · {area:881} Thandol Span · {area:150} Menethil Harbor · {item:7131} Dragonmaw Shinbone · {spell:686} Shadow Bolt
	["The Dragonmaw orcs (level 26-30) camp in the middle of the {zone:1437}; from {area:321} in Arathi head south over the {area:881} ({area:150} is Alliance). Every Raider, Swamprunner, Centurion, Shadowwarder and Bonewarder drops a {item:7131}: right-click it to test it, and about one in four comes out sturdy, the rest break, so expect 30 or more kills for 8. You can test while moving or fighting. The orcs run for help at 15%; Raiders net you, Centurions shield-bash, Shadowwarders cast {spell:686}, Bonewarders raise skeletons."] = "龙喉兽人（26-30 级）驻扎在 {zone:1437} 中部；从阿拉希的 {area:321} 向南跨过 {area:881} 前往（{area:150} 属于联盟）。袭击者、沼泽行者、百夫长、暗影守卫和白骨守卫每只都会掉落一个 {item:7131}：右键点击测试，大约四分之一是结实的，其余会碎掉，所以凑齐 8 个预计要杀 30 只以上。移动或战斗中也能测试。兽人在生命值降至 15% 时会逃跑求援；袭击者会撒网，百夫长会盾击，暗影守卫会施放 {spell:686}，白骨守卫会召起骷髅。",
	["from the Dragonmaw orcs: right-click to test it"] = "从龙喉兽人身上获得：右键点击进行测试",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "回到{area:380}以东路边的{npc:5878}处。{quest:1848}是第一件；之后他会让你去找三位工匠制作其余部件。",
	-- ["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "飞往{area:378}。营地以南的{area:390}散布着异种蝎土丘：那里的异种蝎携带颤抖的触角。",
	-- ["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "30级的四件护甲（锁甲、头盔、护手、护腿），途中还有一面盾牌。",
	-- ["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "矿工用{item:2772}熔炼铁锭（{skill:186} 125）；其他人在{zone:1454}的拍卖行购买。",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "鲁古格是{area:1717}中的精英野猪人，那是{zone:1413}南端的地下城；他掉落{item:6841}。{area:1717}是地下城：建议组队。",
	-- ["Smoky Iron Ingots from the Windshear kobolds"] = "从风剪狗头人身上获得烟雾铁锭",
	-- ["Sturdy Dragonmaw Shinbones"] = "{item:7134}",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "从{zone:1454}乘飞艇前往{zone:1420}；{zone:1458}位于{area:153}之下。",
	-- ["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "龙喉兽人在{zone:1437}中部、道路南边扎营；龙喉袭击者、龙喉沼泽行者、龙喉百夫长、龙喉暗影守卫和龙喉白骨守卫都会掉落{item:7134}。",
	-- ["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "{npc:2269}在{zone:1424}西部的矿洞里工作；他们掉落{item:7127}。从{zone:1454}乘飞艇前往{zone:1420}，然后向南穿过{zone:1421}。",
	-- ["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "{area:2160}位于石爪山脉{area:461}的东端。那里的狗头人掉落烟雾铁锭。",
	-- ["The {area:287} Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "希尔斯布莱德矿工（{area:287}）在{zone:1424}西部的矿洞里干活；他们掉落{item:7127}。从{zone:1454}乘飞艇前往{zone:1420}，再向南骑行穿过{zone:1421}。",
	-- ["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "{area:429}的萨特在{zone:1440}东部扎营，更西边还有魔草萨特；两者都掉落完整的萨特之蹄。",
	-- ["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "{npc:6167}在石爪山脉西南部的奇美拉雏兽和奇美拉幼崽附近游荡；她掉落{item:6840}。",
	-- ["Twitching Antennae from the silithid"] = "从异种蝎身上获得颤抖的触角",
	-- ["Uncloven {quest:1842}"] = "完整的{quest:1842}",
	-- ["{area:287} Miners"] = "希尔斯布莱德矿工（{area:287}）",
	-- ["{item:6840} from the {npc:6167}"] = "从{npc:6167}身上获得{item:6840}",
	-- ["{item:7127} from the Hillsbrad Miners"] = "{item:7127}，来自{npc:2269}",
	-- ["{item:7127} from the {area:287} Miners"] = "从希尔斯布莱德矿工（{area:287}）身上获得{item:7127}",
	-- ["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878}在{area:380}以东的路边扎营。{quest:1838}是30级任务；你现在就可以接受，并在路上收集所需物品。",
	-- ["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408}在{zone:1411}海岸的{area:367}。",
}
