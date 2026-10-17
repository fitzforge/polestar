-- Chinese (simplified) (zhCN): the guide forever/exploration/eastern-kingdoms-1-30 (forever/exploration/eastern-kingdoms-1-30.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 1-30"] = "探索：{zone:1415} 1-30",

	-- Step 1: Elwynn Forest (1/2)
	-- {zone:1429} Elwynn Forest · {zone:1426} Dun Morogh
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Alliance starts in {zone:1429}; dwarves and gnomes can begin at the {zone:1426} step. 12 areas to discover here, levels 5-10."] = "发现一个区域会获得与其等级相应的经验，所以可以与升级同步进行。联盟从{zone:1429}开始；矮人和侏儒可以从{zone:1426}这一步开始。这里有12个区域待发现，5-10级。",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "在一个角色上探索整张世界地图是一项 Forever 传承挑战（1点账号通用传承点数）。",
	-- {area:9} Northshire Valley · {zone:1429} Elwynn Forest · {area:87} Goldshire
	["{area:9} opens onto {zone:1429}; {area:87} is south down the road."] = "{area:9}通往{zone:1429}；沿路向南就是{area:87}。",

	-- Step 2: Elwynn Forest (2/2)
	["any one of these names counts"] = "以下任意一个名称都算",

	-- Step 3: Westfall (1/2)
	["14 areas to discover here, levels 9-18."] = "这里有14个区域待发现，9-18级。",
	-- {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:120} Westbrook Garrison
	["{zone:1436} borders {zone:1429} to the west: follow the road out past the {area:120}."] = "{zone:1436}在{zone:1429}西边接壤：沿路出去经过{area:120}。",
	-- {area:108} Sentinel Hill
	["Flight path here: {area:108} (Thor)."] = "飞行路线：{area:108}（索尔）。",

	-- Step 5: Duskwood (1/2)
	["13 areas to discover here, levels 10-30."] = "这里有13个区域待发现，10-30级。",
	-- {zone:1431} Duskwood · {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:42} Darkshire
	["{zone:1431} is east of {zone:1436} and south of {zone:1429}. Its road runs east to {area:42}."] = "{zone:1431}在{zone:1436}东边、{zone:1429}南边。它的道路向东通往{area:42}。",
	-- {area:42} Darkshire · {npc:2409} Felicia Maline
	["Flight path here: {area:42} ({npc:2409})."] = "飞行路线：{area:42}（{npc:2409}）。",

	-- Step 7: Redridge Mountains (1/2)
	["11 areas to discover here, levels 15-24."] = "这里有11个区域待发现，15-24级。",
	-- {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood
	["Redridge starts at {area:1002}, where the roads from {zone:1429} and {zone:1431} meet."] = "赤脊山从{area:1002}开始，{zone:1429}和{zone:1431}的道路在那里交汇。",
	-- {area:69} Lakeshire · {npc:931} Ariena Stormfeather
	["Flight path here: {area:69} ({npc:931})."] = "飞行路线：{area:69}（{npc:931}）。",

	-- Step 9: Dun Morogh (1/3)
	["18 areas to discover here, levels 4-12."] = "这里有18个区域待发现，4-12级。",
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind City · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "从{zone:1453}的{object:28027}乘{area:2257}前往{zone:1455}（或飞往{zone:1455}），然后从城门出城。",

	-- Step 12: Loch Modan (1/2)
	["11 areas to discover here, levels 10-18."] = "这里有11个区域待发现，10-18级。",
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:925} Algaz Station
	["Leave {zone:1426} east through the gate tunnel; it opens into {zone:1432} at {area:925}."] = "穿过城门隧道向东离开{zone:1426}；隧道在{area:925}通往{zone:1432}。",
	-- {area:144} Thelsamar · {npc:1572} Thorgrum Borrelson
	["Flight path here: {area:144} ({npc:1572})."] = "飞行路线：{area:144}（{npc:1572}）。",

	-- Step 14: Wetlands (1/2)
	["15 areas to discover here, levels 20-30."] = "这里有15个区域待发现，20-30级。",
	-- {area:925} Algaz Station · {area:836} Dun Algaz · {zone:1437} Wetlands
	["From {area:925}, the road north through the {area:836} pass leads into the {zone:1437}."] = "从{area:925}沿路向北穿过{area:836}山口进入{zone:1437}。",
	-- {area:150} Menethil Harbor · {npc:1571} Shellei Brondir
	["Flight path here: {area:150} ({npc:1571})."] = "飞行路线：{area:150}（{npc:1571}）。",
	-- {area:1038} Dragonmaw Gates · {area:1037} Grim Batol
	["the discovery triggers at the {area:1038}: do not go into {area:1037} itself"] = "在{area:1038}即可触发发现：不要进入{area:1037}本身",

	-- Step 16: Hillsbrad Foothills (1/2)
	["12 areas to discover here, levels 20-31."] = "这里有12个区域待发现，20-31级。",
	-- {area:881} Thandol Span · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {zone:1424} Hillsbrad Foothills
	["Cross the {area:881} in northern {zone:1437} into the {zone:1417} (level 30+ creatures off the road), follow the road west past {area:320} and on into {zone:1424}."] = "穿过{zone:1437}北部的{area:881}进入{zone:1417}（道路外有30级以上的怪物），沿路向西经过{area:320}，继续进入{zone:1424}。",
	-- {area:271} Southshore · {npc:2432} Darla Harris
	["Flight path here: {area:271} ({npc:2432})."] = "飞行路线：{area:271}（{npc:2432}）。",
	-- {area:272} Tarren Mill
	["Horde guards: touch the edge of {area:272} and move on"] = "部落卫兵：碰到{area:272}的边缘就继续前进",

	-- Step 18: Silverpine Forest (1/2)
	["15 areas to discover here, levels 10-20."] = "这里有15个区域待发现，10-20级。",
	-- {area:287} Hillsbrad · {area:285} Southpoint Tower · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["Follow the road west from {area:287} past {area:285} into {zone:1421}, Horde country with Horde guards at the {area:228}."] = "从{area:287}沿路向西经过{area:285}进入{zone:1421}，这是部落的地盘，{area:228}有部落卫兵。",
	-- {area:228} Sepulcher
	["Horde guards: touch the edge of {area:228} and move on"] = "部落卫兵：碰到{area:228}的边缘就继续前进",

	-- Step 20: Tirisfal Glades (1/3)
	["17 areas to discover here, levels 5-10."] = "这里有17个区域待发现，5-10级。",
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {area:154} Deathknell · {zone:1458} Undercity
	["Silverpine's road north leads into {zone:1420}. {area:159}, {area:154} and the {zone:1458} ruins are Horde ground."] = "银松森林的道路向北通往{zone:1420}。{area:159}、{area:154}和{zone:1458}废墟是部落的地盘。",
	-- {area:153} Ruins of Lordaeron
	["Horde guards: touch the edge of {area:153} and move on"] = "部落卫兵：碰到{area:153}的边缘就继续前进",

	-- Step 21: Tirisfal Glades (2/3)
	-- {area:159} Brill
	["Horde guards: touch the edge of {area:159} and move on"] = "部落卫兵：碰到{area:159}的边缘就继续前进",

	-- Step 22: Tirisfal Glades (3/3)
	-- {area:154} Deathknell
	["Horde guards: touch the edge of {area:154} and move on"] = "部落卫兵：碰到{area:154}的边缘就继续前进",

	-- Step 23: Tirisfal Glades (1/3)
	-- {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Horde starts in {zone:1420}; orcs, trolls and tauren arrive by zeppelin from {zone:1454}. 17 areas to discover here, levels 5-10."] = "发现一个区域会获得与其等级相应的经验，所以可以与升级同步进行。部落从{zone:1420}开始；兽人、巨魔和牛头人从{zone:1454}乘飞艇到达。这里有17个区域待发现，5-10级。",
	-- {area:154} Deathknell · {zone:1420} Tirisfal Glades · {area:159} Brill · {zone:1458} Undercity
	["{area:154} opens onto {zone:1420}; {area:159} is east along the road. Orcs, trolls and tauren arrive at the zeppelin tower by the {zone:1458}."] = "{area:154}通往{zone:1420}；沿路向东就是{area:159}。兽人、巨魔和牛头人在{zone:1458}旁的飞艇塔到达。",

	-- Step 26: Silverpine Forest (1/2)
	-- {zone:1421} Silverpine Forest · {zone:1420} Tirisfal Glades · {area:159} Brill
	["{zone:1421} is south of {zone:1420}: follow the road south from {area:159}."] = "{zone:1421}在{zone:1420}南边：从{area:159}沿路向南走。",
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["Flight path here: {area:228} ({npc:2226})."] = "飞行路线：{area:228}（{npc:2226}）。",

	-- Step 28: Hillsbrad Foothills (1/2)
	-- {zone:1424} Hillsbrad Foothills · {area:285} Southpoint Tower · {area:272} Tarren Mill · {area:271} Southshore
	["At the south end of Silverpine the road turns east into {zone:1424} by {area:285}. {area:272} in the north-east is the Horde town; {area:271} is Alliance."] = "在银松森林南端，道路在{area:285}向东转入{zone:1424}。东北部的{area:272}是部落城镇；{area:271}属于联盟。",
	-- {area:272} Tarren Mill
	["Flight path here: {area:272} (Zarise)."] = "飞行路线：{area:272}（扎瑞斯）。",

	-- Step 29: Hillsbrad Foothills (2/2)
	-- {area:271} Southshore
	["Alliance guards: touch the edge of {area:271} and move on"] = "联盟卫兵：碰到{area:271}的边缘就继续前进",

	-- Step 30: Wetlands (1/2)
	-- {area:287} Hillsbrad · {zone:1417} Arathi Highlands · {area:881} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["Walk east from {area:287} into the {zone:1417} (level 30+ creatures off the road), south to the {area:881} bridge, and across it into the {zone:1437}. {area:150} is an Alliance town."] = "从{area:287}向东进入{zone:1417}（道路外有30级以上的怪物），向南到{area:881}大桥，过桥进入{zone:1437}。{area:150}是联盟城镇。",

	-- Step 31: Wetlands (2/2)
	-- {area:150} Menethil Harbor
	["Alliance guards: touch the edge of {area:150} and move on"] = "联盟卫兵：碰到{area:150}的边缘就继续前进",

	-- Step 32: Loch Modan (1/2)
	-- {area:836} Dun Algaz · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:925} Algaz Station
	["The {area:836} pass in south-eastern {zone:1437} leads down into {zone:1432} by {area:925}."] = "{zone:1437}东南部的{area:836}山口向下通往{area:925}旁的{zone:1432}。",

	-- Step 33: Loch Modan (2/2)
	-- {area:144} Thelsamar
	["Alliance guards: touch the edge of {area:144} and move on"] = "联盟卫兵：碰到{area:144}的边缘就继续前进",

	-- Step 34: Dun Morogh (1/3)
	-- {area:925} Algaz Station · {zone:1426} Dun Morogh · {area:131} Kharanos · {zone:1455} Ironforge
	["From {area:925} take the tunnel west into {zone:1426}. {area:131} and {zone:1455}'s gates are Alliance ground."] = "从{area:925}穿过隧道向西进入{zone:1426}。{area:131}和{zone:1455}的城门是联盟的地盘。",

	-- Step 35: Dun Morogh (2/3)
	-- {area:809} Gates of Ironforge
	["Alliance guards: touch the edge of {area:809} and move on; any one of these names counts"] = "联盟卫兵：碰到{area:809}的边缘就继续前进；以下任意一个名称都算",
	-- {area:131} Kharanos
	["Alliance guards: touch the edge of {area:131} and move on"] = "联盟卫兵：碰到{area:131}的边缘就继续前进",

	-- Step 36: Dun Morogh (3/3)
	-- {area:132} Coldridge Valley
	["Alliance guards: touch the edge of {area:132} and move on; any one of these names counts"] = "联盟卫兵：碰到{area:132}的边缘就继续前进；以下任意一个名称都算",

	-- Step 37: Duskwood (1/2)
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:117} Grom'gol Base Camp · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	["Hearth or fly back to the {zone:1458} (or go to {zone:1454}), take the zeppelin to {area:117} in {zone:1434} and walk north along the road into {zone:1431}. Northern Stranglethorn is level 30+ off the road."] = "用炉石或飞回{zone:1458}（或前往{zone:1454}），乘飞艇前往{zone:1434}的{area:117}，然后沿路向北进入{zone:1431}。荆棘谷北部道路外是30级以上区域。",
	-- {area:42} Darkshire
	["Alliance guards: touch the edge of {area:42} and move on"] = "联盟卫兵：碰到{area:42}的边缘就继续前进",

	-- Step 39: Westfall (1/2)
	-- {zone:1436} Westfall · {zone:1431} Duskwood · {area:108} Sentinel Hill
	["{zone:1436} borders {zone:1431} to the west. {area:108} is an Alliance town."] = "{zone:1436}在{zone:1431}西边接壤。{area:108}是联盟城镇。",

	-- Step 40: Westfall (2/2)
	-- {area:108} Sentinel Hill
	["Alliance guards: touch the edge of {area:108} and move on"] = "联盟卫兵：碰到{area:108}的边缘就继续前进",

	-- Step 41: Elwynn Forest (1/2)
	["12 areas to discover here, levels 5-10."] = "这里有12个区域待发现，5-10级。",
	-- {zone:1429} Elwynn Forest · {zone:1436} Westfall · {zone:1431} Duskwood · {area:87} Goldshire · {area:9} Northshire Valley · {zone:1453} Stormwind City
	["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429}在{zone:1436}和{zone:1431}北边。{area:87}、{area:9}和{zone:1453}的城门是有卫兵的联盟地盘。",
	-- {zone:1453} Stormwind City
	["Alliance guards: touch the edge of {zone:1453} and move on; any one of these names counts"] = "联盟卫兵：碰到{zone:1453}的边缘就继续前进；以下任意一个名称都算",
	-- {area:9} Northshire Valley
	["Alliance guards: touch the edge of {area:9} and move on"] = "联盟卫兵：碰到{area:9}的边缘就继续前进",
	-- {area:87} Goldshire
	["Alliance guards: touch the edge of {area:87} and move on"] = "联盟卫兵：碰到{area:87}的边缘就继续前进",

	-- Step 43: Redridge Mountains (1/2)
	-- {zone:1429} Elwynn Forest · {area:1002} Three Corners · {area:69} Lakeshire
	["Go east through {zone:1429} to {area:1002}, where Redridge starts. {area:69} is an Alliance town."] = "向东穿过{zone:1429}到{area:1002}，那里是赤脊山的起点。{area:69}是联盟城镇。",
	-- {area:69} Lakeshire
	["Alliance guards: touch the edge of {area:69} and move on"] = "联盟卫兵：碰到{area:69}的边缘就继续前进",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Flight path here: {area:228} ({npc:2226})."] = "飞行路线：{area:228}（{npc:2226}）。",
	-- ["Horde guards: touch the edge of {area:228} and move on"] = "部落卫兵：碰到{area:228}的边缘就继续前进",
	-- ["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "从{zone:1453}的{object:28027}乘{area:2257}前往{zone:1455}（或飞往{zone:1455}），然后从城门出城。",
	-- ["The {area:228}"] = "{area:228}",
	-- ["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429}在{zone:1436}和{zone:1431}北边。{area:87}、{area:9}和{zone:1453}的城门是有卫兵的联盟地盘。",
}
