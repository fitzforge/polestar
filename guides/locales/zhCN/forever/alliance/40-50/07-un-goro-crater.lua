-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:6734} Innkeeper Hearthstove
	["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}：上一份指南用炉石把你送到这里，所以这一步通常会立即完成",

	-- Step 2: Gadgetzan
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:976} Gadgetzan · {npc:9619} Torwa Pathfinder
	["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "从{area:144}飞往{area:150}，乘船前往塞拉摩，再飞往{area:976}。{npc:9619}在环形山的第一个任务需要48级：等级不够就在这里练满。",
	-- {area:976} Gadgetzan
	["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "在{area:976}周围刷废土强盗或砂槌食人魔",

	-- Step 3: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "向西骑出{area:976}，到达通往{zone:1449}的长坡道。{npc:9619}在坡道脚下扎营，位于环形山的东南角。",

	-- Step 4: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder
	["The dead Threshadon lies by the water north of {npc:9619}."] = "死去的蛇颈龙躺在{npc:9619}北边的水边。",

	-- Step 6: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "{npc:9683}和木筏",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "拉克维的配偶在{npc:9619}西边的丛林中徘徊。失事的木筏在那里的湖岸上；小背包在它旁边的水里。指南针、地图和钥匙留给{npc:8737}。环形山中任何野兽都可能掉落{item:11116}：右键点击它。",

	-- Step 8: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {object:157936} Un'Goro Dirt Pile
	["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "沿环形山东侧向北骑行到{area:541}，即北面悬崖洞穴中的营地。远离精英魔暴龙和剑龙。从这里开始，沿途遇到的每个能量水晶和{object:157936}都拾取。",
	["Gryfe"] = "格莱菲",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "在{zone:1452}的{npc:9298}处结束：留着",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}，在洞穴深处",

	-- Step 9: Karna Remtravel
	-- {npc:9618} Karna Remtravel
	["{npc:9618} stands just outside the refuge."] = "{npc:9618}站在避难所外面。",

	-- Step 10: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537}和东部丛林",
	-- {area:537} Fire Plume Ridge · {item:11113} Crate of Foodstuffs
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "向南骑到陨石坑中央的{area:537}，然后向东进入东部丛林。水晶簇遍布陨石坑，许多在{area:537}周围：每种颜色多拿几个。{npc:6509}和血瓣花猛击者掉落花瓣；远征队的{item:11113}在东部丛林的一处废弃营地里。",

	-- Step 11: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向北骑行到{area:1943}，机器人站在猩猩中间。别进那里的深洞。",

	-- Step 12: Zul'Farrak (optional)
	-- {area:978} Zul'Farrak
	["{area:978} (optional)"] = "{area:978}（可选）",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "组队打{area:978}代替刷怪会更快。巨魔城市位于{zone:1446}西北部，就在{area:976}北边。",

	-- Step 13: Grind to 50
	["Grind to 50"] = "刷到50级",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "{area:1943}的猩猩成小群出现，目前不会给你掉落任何东西；{npc:9619}的毛皮任务稍后才有。别进最深的洞：{npc:9622}是55级。",
	-- {npc:6514} Un'Goro Gorilla · {area:1943} Ironstone Plateau · {zone:1449} Un'Goro Crater
	["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "在{zone:1449}的{area:1943}刷{npc:6514}",

	-- Step 14: Marshal's Refuge
	["Ride west back to the refuge."] = "向西骑回避难所。",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "交给{zone:1444}的{npc:7775}：留着",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997}旁边的木牌",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}，在避难所入口",

	-- Step 15: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:9998} Shizzle
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "水晶塔立在避难所东边的山坡上。{npc:9166}在周围山坡上盘旋：它们计入{npc:9997}的任务，并掉落{npc:9998}要的鳞片。",

	-- Step 16: The east side
	["The east side"] = "东侧",
	-- {npc:9165} Fledgling Pterrordax · {npc:9998} Shizzle
	-- plural, as words: Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "沿东侧向南骑行。幼双帆龙在东部丛林吃草，{npc:9165}在东部悬崖附近飞行；两者都掉落{npc:9998}要的鳞片。",

	-- Step 17: Eastern Pylon
	["Eastern Pylon"] = "东部水晶塔",
	["The pylon stands on the eastern cliffs."] = "水晶塔立在东部悬崖上。",

	-- Step 18: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "沿东部悬崖向南骑行，到坡道脚下找{npc:9619}。",
	["The pelts come after loop 2, on the gorilla plateau"] = "毛皮在第二圈之后，在猩猩高地上",

	-- Step 19: The Gorishi hive
	["The Gorishi hive"] = "格里什虫巢",
	-- {npc:9619} Torwa Pathfinder · {quest:3764} Un'Goro Soil · {npc:9166} Pterrordax
	["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "从{npc:9619}向西骑行：异种虫巢穴占据环形山南部。对孵化室（挂着幼虫的房间）使用采集瓶。格里什异种蝎和格里什工蝎掉落{quest:3764}；如果还需要击杀，{npc:9166}在南部悬崖筑巢。",

	-- Step 20: Bones and equipment
	["Bones and equipment"] = "骨头和设备",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "恐龙骨头散落在西南部的地面上，在剑龙之间：剑龙是精英，在它们周围捡骨头，其余的从双帆龙身上获取。探险队的{item:11112}在西南部丛林中。",

	-- Step 21: Western Pylon
	["Western Pylon"] = "西部水晶塔",
	-- {npc:9167} Frenzied Pterrordax
	["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "水晶塔立在西部悬崖上。{npc:9167}在整个西侧上空飞行。",

	-- Step 22: Marshal's Refuge
	["Ride north along the western jungle back to the refuge."] = "沿西部丛林向北骑回避难所。",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge's entrance"] = "{npc:9998}，在避难所入口",

	-- Step 23: Spraggle Frock
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9997}的朋友{npc:9999}失踪了。",

	-- Step 24: Ironstone Plateau
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "猩猩生活在{area:541}东边的{area:1943}。毛皮留给{npc:9619}。别进最深的洞：{npc:9622}是55级。",

	-- Step 25: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}坐在环形山中央{area:537}的东南坡上。",

	-- Step 26: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "护送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "带{npc:9999}向北前往{area:541}。他昏倒时，对他使用{item:11804}唤醒他。",

	-- Step 28: Sunken Temple
	-- {area:1417} Sunken Temple
	["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "组队打{area:1417}代替刷怪会更快。单人刷怪就跳过此步骤。",

	-- Step 29: Grind to 51
	["Grind to 51"] = "刷到51级",
	-- {area:982} Noxious Lair · {zone:1446} Tanaris
	["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "森提帕尔异种虫在{zone:1446}西部的{area:982}周围爬行，就在环形山坡道东边。森提帕尔工蝎最容易拉。",
	-- {npc:5458} Centipaar Worker · {area:982} Noxious Lair · {zone:1446} Tanaris
	["grind on {npc:5458} at {area:982}, {zone:1446}"] = "在{zone:1446}的{area:982}刷{npc:5458}",

	-- Step 30: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "沿坡道下到环形山：{npc:9619}在坡道脚下扎营。",

	-- Step 31: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}的巢穴在{npc:9619}北边的丛林中，东部悬崖下方：在那里使用{item:11568}。{npc:9684}是56级：满血开打。",

	-- Step 33: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿东侧向北骑行到猩猩高地。55级的猩猩{npc:9622}坐在最深的洞里：先清理洞口的猩猩。",

	-- Step 34: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "向西经过{area:541}，再沿西侧向南到{area:543}：地精{npc:10302}坐在水边。",

	-- Step 35: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "向东骑行到{area:537}，爬上去，在山顶附近的熔岩喷口使用{npc:10541}。",

	-- Step 37: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "穿过环形山南部，到坡道旁找{npc:9619}。",

	-- Step 39: Ironforge
	-- {area:144} Thelsamar · {area:1537} Ironforge
	["Fly from {area:144} to {area:1537}."] = "从{area:144}飞往{area:1537}。",

	-- Step 41: Tinker Town
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}：软泥怪在{zone:1448}，留着",

	-- Step 42: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "{zone:1447}的四个符文拓片：留着",
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}：交给{zone:1447}的奥汀克，留着",

	-- Step 43: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "阿克瑟努斯站在{object:171709}中麦格尼国王旁边。",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "圣物在{zone:1428}：留着",

	-- Step 44: Bind and train
	["Bind and train"] = "设置炉石并训练",

	-- Step 45: Xiggs Fuselighter
	-- {object:32359} Military Ward
	["Xiggs waits in the {object:32359}."] = "西格斯在{object:32359}等候。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. {item:11316} Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "向南骑行到环形山中央的{area:537}，然后向东进入东部丛林。水晶簇遍布环形山，很多在{area:537}周围：每种颜色多拿几个。{item:11316}鞭笞者和猛击者掉落花瓣；探险队的{item:11113}在东部丛林的一处废弃营地里。",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "在{zone:1446}的{area:982}刷{npc:5458}",
}
