-- Chinese (simplified) (zhCN): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- Step 2: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {area:12} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {area:12}."] = "",
	["Level 18 and 20 spells"] = "18级和20级法术",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}：来自{area:442}的桑迪斯的信",
	-- {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Only once {quest:97914} is handed in: for {npc:3649}, back in {area:442} (06-ashenvale)"] = "",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 4: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 5: Stormwind class quests
	-- {zone:1453} Stormwind
	["{zone:1453} class quests"] = "{zone:1453}职业任务",
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:376} High Priestess Laurena
	["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332}在{object:2100}的军情七处，{npc:6122}在{object:2101}{object:2164}的地下室，{npc:376}在光明大教堂。",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}：交给{zone:1436}的{npc:7024}，在{zone:1431}结束时",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}：之后交给{zone:1413}的{npc:6244}",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}：之后交给{zone:1455}的{npc:11406}",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}：之后交给{zone:1455}的{npc:258785}",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}：之后交给{zone:1457}的{npc:11401}",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 7: Shaman training
	["Shaman training"] = "萨满祭司训练",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习，然后乘地铁返回。",

	-- Step 8: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn to Redridge."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}：{object:177790}",

	-- Step 10: Back to Elwynn Forest
	-- {area:12} Elwynn Forest
	["Back to {area:12}"] = "",

	-- Step 13: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "",

	-- Step 15: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker · {zone:1431} Duskwood
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "来自艾尔文森林的道路在{area:1002}进入赤脊山。{npc:464}站在通往赤脊山和{zone:1431}的道路交汇处。",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "",

	-- Step 16: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "沿{area:68}南岸的道路走到狮鹫管理员处。{npc:1070}和{npc:903}站在她旁边的路边。",

	-- Step 17: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "向北过长桥进入镇子。{npc:341}和{npc:382}站在桥的北端，{npc:900}在市政厅，{npc:381}和{npc:266}在码头，{npc:343}在旅店，{npc:342}在镇子西端她的菜园里。",
	-- {npc:266} Wiley the Black
	["{npc:266}, by the docks; upstairs"] = "",
	["Inside"] = "",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "",

	-- Step 18: Spotted Sunfish on the way
	-- {item:1467} Spotted Sunfish
	["{item:1467} on the way"] = "",

	-- Step 19: Sunken Chest
	-- {area:68} Lake Everstill
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "从桥边向东游进{area:68}；箱子在湖底。",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "",

	-- Step 21: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Redridge Thrashers = {npc:712} Redridge Thrasher · Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Dire Condors = {npc:428} Dire Condor · Great Goretusks = {npc:547} Great Goretusk
	["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}：赤脊山鞭笞者",

	-- Step 26: Lakeshire
	-- {npc:341} Foreman Oslow · {quest:89} The Everstill Bridge
	["{npc:341}: after {quest:89}"] = "{npc:341}：在{quest:89}之后",

	-- Step 27: Lake Everstill: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}: kill these as you meet them"] = "",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater · Greater Tarantulas = {npc:505} Greater Tarantula
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin.\nGreater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "",

	-- Step 28: Blackrock camps
	["Blackrock camps"] = "黑石营地",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "",

	-- Step 29: Hearth to Lakeshire
	-- {area:69} Lakeshire
	["Hearth to {area:69}"] = "",

	-- Step 30: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "回到{area:69}",

	-- Step 31: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "从{area:69}向北出发，沿{area:95}上行到{area:997}。黑石勇士在山谷中扎营。",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "",

	-- Step 32: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "基沙恩下士躲在山谷最北端，靠近{zone:1428}边界。护送他下山回到{area:69}；途中会遭到黑石兽人伏击。",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "",

	-- Step 33: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}，在桥南的狮鹫旁",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "下一站是{zone:1431}：沿道路向西到{area:1002}，再向南到{area:42}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "贝利格拉布",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "向东经过伐木场并过河。山谷里到处是暗皮豺狼人；{npc:703}（26级，比你高很多）在山谷北端率领它们：先清掉他的护卫，满血再打他。不要进入南边的{area:2099}：那里的兽人是精英。",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "飞往{area:108}，向西北骑到海岸：{object:177790}在近岸的海底。然后沿道路向东穿过艾尔文森林前往赤脊山。",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "交给{npc:3649}，在返回{area:442}时（06-ashenvale）",
	-- ["Gnolls toward {area:1002}"] = "前往{area:1002}方向的豺狼人",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "巨型狼蛛在湖东北边伐木场周围的山坡上爬行。",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "巨型狼蛛在湖东北伐木场周围的山坡上爬行；黑石叛节者占据着伐木场。",
	-- ["Lake murlocs"] = "湖边的鱼人",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "鱼人食腐者和鱼人招潮者分布在桥东的南岸。它们都可能带有{item:1467}或鳍。",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "混血赤脊山豺狼人和其他豺狼人占据着{area:1002}以东、道路以北的山丘；赤脊山鞭笞者在其中游荡，赤脊山偷猎者在道路以南扎营。恐鹫和巨型血牙野猪也在这片山丘游荡。",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "{npc:423}和其他豺狼人占据着{area:1002}以东、道路以北的山丘；{npc:712}在其中游荡，赤脊山偷猎者在道路南边扎营。掉落{item:2856}和铁铆钉的{npc:426}在更北边的山丘；{npc:428}和{npc:547}在它们东边的山丘游荡。",
	-- ["South down the valley's east side to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "沿山谷东侧向南，前往{area:2099}东边的黑石营地。营地里有黑石叛节者、步兵和前锋；保持在要塞东边，要塞里的兽人都是精英。",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "旅店旁的通缉令：{area:1000}的{npc:703}",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "来自{area:442}的船停靠在{area:17203}。走进城里学习技能并找{npc:1646}，然后从正门离开，沿道路向东穿过{zone:1429}。",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}：任何暗皮豺狼人",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}：任何黑石兽人",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}：磨坊的黑石叛节者",
	-- ["{npc:266}, by the docks"] = "{npc:266}，在码头旁",
	-- ["{npc:344}, in the town hall"] = "{npc:344}，在市政厅",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345}（24级）在{area:69}西边的猪圈里拱来拱去。把他从其他野猪中引出来，满血再打。",
}
