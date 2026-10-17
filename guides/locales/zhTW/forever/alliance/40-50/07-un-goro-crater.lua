-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Gadgetzan
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:976} Gadgetzan · {npc:9619} Torwa Pathfinder
	["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "從{area:144}飛往{area:150}，搭船到塞拉摩，再飛往{area:976}。{npc:9619}在環形山的第一個任務需要等級48：若等級不足，先在這裡練完這一級。",
	-- {area:976} Gadgetzan
	["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "在{area:976}周圍擊殺廢土強盜或砂槌巨魔練等",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "從{area:976}向西出發，前往通往{zone:1449}的長坡道。{npc:9619}在坡道底部紮營，位於環形山東南角。",

	-- Step 3: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder
	["The dead Threshadon lies by the water north of {npc:9619}."] = "死去的蛇頸龍躺在{npc:9619}北邊的水邊。",

	-- Step 5: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "拉克維的配偶與木筏",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "拉克維的配偶在{npc:9619}西邊的叢林中徘徊。破碎的木筏在那裡的湖岸上；小包就在旁邊的水裡。把指南針、地圖和鑰匙留給{npc:8737}。環形山的任何野獸都可能掉落{item:11116}：右鍵點擊它。",

	-- Step 7: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {object:157936} Un'Goro Dirt Pile
	["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "沿著環形山東側向北騎往{area:541}，也就是北面懸崖洞穴中的營地。遠離精英魔暴龍和劍龍。從現在起，拾取沿途經過的每一個能量水晶和{object:157936}。",
	["Gryfe"] = "葛萊夫",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "在{zone:1452}的{npc:9298}處完成：保留此任務",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}，在洞穴深處",

	-- Step 8: Karna Remtravel
	-- {npc:9618} Karna Remtravel
	["{npc:9618} stands just outside the refuge."] = "{npc:9618}就站在避難營外。",

	-- Step 9: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537}與東部叢林",
	-- {area:537} Fire Plume Ridge · {item:11113} Crate of Foodstuffs
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "向南騎往環形山中央的{area:537}，然後向東進入東部叢林。水晶簇遍布整個環形山，許多在{area:537}周圍：每種顏色多拿幾個。血瓣花鞭笞者和血瓣花猛擊者會掉落花瓣；探險隊的{item:11113}在東部叢林中一處廢棄的營地裡。",

	-- Step 10: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向北騎往{area:1943}，機器人站在猩猩群中。不要進入那裡的深洞。",

	-- Step 11: Zul'Farrak (optional)
	-- {area:978} Zul'Farrak
	["{area:978} (optional)"] = "{area:978}（可選）",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "組隊打{area:978}代替練等能更快達到目標。這座食人妖城市位於{zone:1446}西北部，就在{area:976}北邊。",

	-- Step 12: Grind to 50
	["Grind to 50"] = "練到50級",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "{area:1943}的猩猩成小群出現，目前還不會為你掉落任何東西；{npc:9619}的毛皮任務稍後才有。不要進入最深的洞穴：{npc:9622}是55級。",
	-- {npc:6514} Un'Goro Gorilla · {area:1943} Ironstone Plateau · {zone:1449} Un'Goro Crater
	["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "在{zone:1449}的{area:1943}擊殺{npc:6514}練等",

	-- Step 13: Marshal's Refuge
	["Ride west back to the refuge."] = "向西騎回避難營。",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "交給{zone:1444}的{npc:7775}：保留此任務",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997}旁邊的木牌",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}，在避難營入口",

	-- Step 14: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:9998} Shizzle
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "水晶塔位於避難營東邊的山坡上。{npc:9166}在周圍山坡盤旋：擊殺牠們算入{npc:9997}的任務，並會掉落{npc:9998}要的鱗片。",

	-- Step 15: The east side
	["The east side"] = "東側",
	-- {npc:9165} Fledgling Pterrordax · {npc:9998} Shizzle
	-- plural, as words: Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "沿東側向南騎。幼雙帆龍在東部叢林覓食，{npc:9165}在東面懸崖附近飛行；兩者都會掉落{npc:9998}要的鱗片。",

	-- Step 16: Eastern Pylon
	["Eastern Pylon"] = "東部水晶塔",
	["The pylon stands on the eastern cliffs."] = "水晶塔位於東面懸崖上。",

	-- Step 17: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "沿東面懸崖向南騎往坡道底部的{npc:9619}。",
	["The pelts come after loop 2, on the gorilla plateau"] = "毛皮在第二輪之後，到猩猩高地取得",

	-- Step 18: The Gorishi hive
	["The Gorishi hive"] = "格里什蟲巢",
	-- {npc:9619} Torwa Pathfinder · {quest:3764} Un'Goro Soil · {npc:9166} Pterrordax
	["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "從{npc:9619}向西騎：異種蟲巢穴佔據環形山南部。在孵化室（掛著幼蟲的洞室）使用未使用的採集瓶。格里什異種蠍和格里什工蠍會掉落{quest:3764}；若還需要擊殺數，{npc:9166}在南面懸崖築巢。",

	-- Step 19: Bones and equipment
	["Bones and equipment"] = "骨頭與裝備",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "恐龍骨頭散落在西南部的劍龍群中：劍龍是精英，在牠們周圍撿骨頭，其餘的從雙帆龍身上取得。探險隊的{item:11112}在西南部叢林。",

	-- Step 20: Western Pylon
	["Western Pylon"] = "西部水晶塔",
	-- {npc:9167} Frenzied Pterrordax
	["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "水晶塔位於西面懸崖上。{npc:9167}在整個西側上空飛行。",

	-- Step 21: Marshal's Refuge
	["Ride north along the western jungle back to the refuge."] = "沿西部叢林向北騎回避難營。",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge's entrance"] = "{npc:9998}，在避難營入口",

	-- Step 22: Spraggle Frock
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9997}的朋友{npc:9999}失蹤了。",

	-- Step 23: Ironstone Plateau
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "猩猩住在{area:541}東邊的{area:1943}。把牠們的毛皮留給{npc:9619}。不要進入最深的洞穴：{npc:9622}是55級。",

	-- Step 24: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}坐在環形山中央{area:537}的東南坡上。",

	-- Step 25: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "護送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "帶{npc:9999}向北前往{area:541}。他昏倒時，對他使用{item:11804}把他叫醒。",

	-- Step 27: Sunken Temple
	-- {area:1417} Sunken Temple
	["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "組隊打{area:1417}代替練等能更快達到目標。單人練等請跳過此步驟。",

	-- Step 28: Grind to 51
	["Grind to 51"] = "練到51級",
	-- {area:982} Noxious Lair · {zone:1446} Tanaris
	["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "森提帕爾異種蟲在{zone:1446}西部的{area:982}周圍爬行，就在環形山坡道東邊。工蠍最容易拉。",
	-- {npc:5458} Centipaar Worker · {area:982} Noxious Lair · {zone:1446} Tanaris
	["grind on {npc:5458} at {area:982}, {zone:1446}"] = "在{zone:1446}的{area:982}擊殺{npc:5458}練等",

	-- Step 29: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "沿坡道騎下環形山：{npc:9619}在坡道底部紮營。",

	-- Step 30: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}的巢穴位於{npc:9619}北邊的叢林，在東面懸崖下方：在那裡使用{item:11568}。{npc:9684}是56級：滿血再開打。",

	-- Step 32: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿東側向北騎往猩猩高地。55級的猩猩{npc:9622}在最深的洞穴裡：先清掉洞口的猩猩。",

	-- Step 33: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "向西經過{area:541}，再沿西側向南前往{area:543}：哥布林{npc:10302}坐在水邊。",

	-- Step 34: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "向東騎往{area:537}，爬上去，在山頂附近的熔岩噴口使用{npc:10541}。",

	-- Step 36: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "穿越環形山南部，前往坡道旁的{npc:9619}。",

	-- Step 38: Ironforge
	-- {area:144} Thelsamar · {area:1537} Ironforge
	["Fly from {area:144} to {area:1537}."] = "從{area:144}飛往{area:1537}。",

	-- Step 40: Tinker Town
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}：軟泥怪在{zone:1448}，保留此任務",

	-- Step 41: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "在{zone:1447}拓印四個符文：保留此任務",
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}：交給{zone:1447}的奧汀克，保留此任務",

	-- Step 42: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "阿克瑟努斯站在{object:171709}的國王麥格尼身旁。",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "聖物在{zone:1428}：保留此任務",

	-- Step 43: Bind and train
	["Bind and train"] = "綁定爐石並訓練",

	-- Step 44: Xiggs Fuselighter
	-- {object:32359} Military Ward
	["Xiggs waits in the {object:32359}."] = "希格斯在{object:32359}等候。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "在{zone:1446}的{area:982}擊殺{npc:5458}練等",
}
