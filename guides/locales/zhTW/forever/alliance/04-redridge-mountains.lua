-- Chinese (traditional) (zhTW): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- Step 2: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {area:12} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {area:12}."] = "",
	["Level 18 and 20 spells"] = "18級和20級法術",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}：來自{area:442}的桑迪斯的信",
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
	["{zone:1453} class quests"] = "{zone:1453}職業任務",
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:376} High Priestess Laurena
	["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332}在{object:2100}的軍情七處，{npc:6122}在{object:2101}的{object:2164}地下室，{npc:376}在光明大教堂。",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}：由{zone:1436}的{npc:7024}接收，在{zone:1431}的結尾",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}：由{zone:1413}的{npc:6244}接收，稍後",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}：由{zone:1455}的{npc:11406}接收，稍後",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}：由{zone:1455}的{npc:258785}接收，稍後",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}：由{zone:1457}的{npc:11401}接收，稍後",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 7: Shaman training
	["Shaman training"] = "薩滿訓練",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453}沒有薩滿訓練師：從{object:28027}搭乘{area:2257}前往{zone:1455}，向{npc:258098}學習，然後搭地鐵回來。",

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
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "從艾爾文森林來的道路在{area:1002}進入赤脊山。{npc:464}站在通往赤脊山和{zone:1431}的道路交會處。",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "",

	-- Step 16: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "沿著{area:68}南岸的道路前往獅鷲管理員處。{npc:1070}和{npc:903}站在她旁邊的路旁。",

	-- Step 17: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "向北走過長橋進入城鎮。{npc:341}和{npc:382}站在橋的北端，{npc:900}在市政廳，{npc:381}和{npc:266}在碼頭，{npc:343}在旅店，{npc:342}在西端她的花園裡。",
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
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "從橋向東游進{area:68}；箱子在湖底。",
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
	["{npc:341}: after {quest:89}"] = "{npc:341}：在{quest:89}之後",

	-- Step 27: Lake Everstill: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}: kill these as you meet them"] = "",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater · Greater Tarantulas = {npc:505} Greater Tarantula
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin.\nGreater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "",

	-- Step 28: Blackrock camps
	["Blackrock camps"] = "",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "",

	-- Step 29: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "返回{area:69}",

	-- Step 30: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "向北離開{area:69}，沿著{area:95}前往{area:997}。黑石勇士在山谷中紮營。",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "",

	-- Step 31: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "基沙恩躲在山谷最北端、{zone:1428}邊界旁。護送他下到{area:69}；途中黑石獸人會伏擊你。",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "",

	-- Step 32: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}，在橋南邊的獅鷲旁",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "下一站是{zone:1431}：沿著道路向西前往{area:1002}，再向南前往{area:42}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "貝利格拉布",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "向東經過伐木場並渡河。暗皮豺狼人遍布山谷；{npc:703}（26級，遠高於你）在北端帶領他們：先清掉他的護衛，滿血再打他。不要進入南邊的{area:2099}：那裡的獸人是精英。",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "飛往{area:108}，向西北騎往海岸：{object:177790}在岸外的海底。然後沿著道路向東穿過艾爾文森林前往赤脊山。",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "給{npc:3649}，在回到{area:442}時（06-ashenvale）",
	-- ["Gnolls toward {area:1002}"] = "前往{area:1002}方向的豺狼人",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "巨型狼蛛在湖東北方伐木場周圍的山坡上爬行；黑石叛節者佔據伐木場本身。",
	-- ["Lake murlocs"] = "湖邊魚人",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "魚人食腐者和魚人招潮者分布在橋東邊的南岸。他們每一個都可能帶著{item:1467}或魚鰭。",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "混血赤脊山豺狼人和其他豺狼人佔據{area:1002}東邊、道路北側的山丘；赤脊山鞭笞者在牠們之間徘徊，赤脊山偷獵者在道路南側紮營。恐鷲和巨型血牙野豬在同樣的山丘上遊蕩。",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "旅店旁的通緝告示：{npc:703}，在{area:1000}",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "{area:442}的船停靠在{area:17203}。走進城裡學習技能並找{npc:1646}，然後從正門離開，沿著道路向東穿過{zone:1429}。",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}：任何暗皮豺狼人",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}：任何黑石獸人",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}：磨坊的黑石叛節者",
	-- ["{npc:266}, by the docks"] = "{npc:266}，在碼頭旁",
	-- ["{npc:344}, in the town hall"] = "{npc:344}，在市政廳",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345}（24級）在{area:69}西邊不遠處的豬圈裡拱土。把牠從其他野豬旁拉開，滿血再戰。",
}
