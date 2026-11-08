-- Chinese (simplified) (zhCN): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {zone:1429} Elwynn Forest
	["Train, then leave by the main gate and follow the road east through {zone:1429}."] = "",
	["Level 18 and 20 spells"] = "18级和20级法术",

	-- Step 2: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 4: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁前往{zone:1455}",

	-- Step 5: Shaman training
	["Shaman training"] = "萨满祭司训练",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the Deeprun Tram from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "",

	-- Step 6: Fly to Sentinel Hill
	-- {object:81} Sentinel Hill (no name in this language: may be words)
	["Fly to {object:81}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飞行管理员",

	-- Step 7: Half Pendant of Aquatic Endurance
	-- {object:81} Sentinel Hill (no name in this language: may be words) · {object:177790} Strange Lockbox
	["Fly to {object:81} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}：{object:177790}",

	-- Step 8: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "",

	-- Step 10: Theocritus
	["On the top floor"] = "",

	-- Step 11: Henze Faulk
	-- {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the Tower of Azora, head north from the bridge to Stone Cairn Lake. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "对{npc:6172}使用{item:6866}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}：{npc:474}",

	-- Step 12: Three Corners
	["Three Corners"] = "",
	-- {zone:1431} Duskwood
	["The road east through Elwynn crosses into Redridge at Three Corners, where the roads to Redridge, {zone:1431} and Elwynn meet: south to {zone:1431} first."] = "",

	-- Step 14: Darkshire
	["Darkshire"] = "",
	-- {zone:1431} Duskwood · {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {object:1162} Menethil Harbor (no name in this language: may be words)
	["Follow the road south from Three Corners into {zone:1431}; Darkshire lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {object:1162} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}，在镇子北端",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}，Scarlet Raven Tavern",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}，在市政厅",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}，在市政厅",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}，在市政厅后面的房子里",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "",
	-- {npc:633} Elaine Carevin · {npc:288} Jitters · {quest:163} Raven Hill
	["{npc:633}: {npc:288}, at {quest:163}"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "如果没有{item:4371}，向{npc:3133}购买",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "",
	-- {npc:302} Blind Mary
	["For {npc:302}, on the hill south-east of town"] = "交给{npc:302}，在镇子东南方的山上",

	-- Step 15: Tranquil Gardens Cemetery: kill these as you meet them
	["Tranquil Gardens Cemetery: kill these as you meet them"] = "",
	-- {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of Darkshire, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "",

	-- Step 16: Watcher Dodds
	-- {npc:888} Watcher Dodds
	["{npc:888} stands south of the road, at the Yorgen Farmstead."] = "",

	-- Step 17: Raven Hill
	-- {quest:163} Raven Hill · {object:673515} Memory of Valor (no name in this language: may be words) · {npc:288} Jitters
	["Continue west to {quest:163}. The {object:673515} glows by the ruined house south of the road; {npc:288} hides in the house at the west end of the village."] = "",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor (no name in this language: may be words)
	["{item:281046}, from the {object:673515}"] = "{item:281046}，来自{object:673515}",
	-- {npc:272} Chef Grual
	["for {npc:272} in Darkshire"] = "",

	-- Step 18: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "沿道路向西北经过墓地，前往森林最西缘的{npc:311}营地。{npc:893}站在{npc:311}旁边。",

	-- Step 19: The Hushed Bank: kill these as you meet them
	["The Hushed Bank: kill these as you meet them"] = "",
	-- {npc:289} Abercrombie · {quest:163} Raven Hill · {npc:311} Sven Yorgen · {zone:1436} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders are the small spiders, and few: most crawl along the Hushed Bank west of {quest:163}, fewer up north towards {npc:311}'s camp; they drop the venom too. Every ghoul of the cemetery's northern half can drop a fang. Wolves and the bigger spiders share the {zone:1436} border, so pull with care."] = "",
	-- {item:1130} Vial of Spider Venom
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Venom Web Spiders = {npc:217} Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "{item:1130}：小型结网毒蜘蛛、结网毒蜘蛛和绿色隐士蛛",

	-- Step 20: Abercrombie
	["The hermit's shack stands in the woods north-east of the Raven Hill Cemetery."] = "",

	-- Step 21: Raven Hill Cemetery: kill these as you meet them
	["Raven Hill Cemetery: kill these as you meet them"] = "",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "墓地位于村子北边。恐怖骸骨和骸骨魔在墓地南半部游荡。精英{npc:522}在墓地间徘徊：离他远点。",

	-- Step 22: Watcher Dodds
	["Head back east along the road to the Yorgen Farmstead."] = "",

	-- Step 23: Yorgen Farmstead
	["Yorgen Farmstead"] = "",
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "松土堆在农舍南边的老树桩旁。",

	-- Step 24: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "",
	-- {npc:272} Chef Grual
	["{npc:272}, in the Scarlet Raven Tavern"] = "",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}，在市政厅旁",

	-- Step 26: Redridge Mountains
	["Back north along the road from Darkshire to Three Corners."] = "",

	-- Step 27: Lakeridge Highway
	["Lakeridge Highway"] = "",
	-- {npc:903} Guard Howe
	["Follow the road along the south shore of Lake Everstill to the gryphon master. {npc:903} stands by the road next to her."] = "",

	-- Step 28: Lake Everstill's murlocs: kill these as you meet them
	["Lake Everstill's murlocs: kill these as you meet them"] = "",
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore of Lake Everstill, just east of the gryphons and the bridge. Any of them can carry a fin."] = "",

	-- Step 29: Lakeshire
	["Lakeshire"] = "",
	-- {npc:381} Dockmaster Baren · {npc:900} Bailiff Conacher · {npc:342} Martie Jainrose · {npc:382} Marshal Marris · {quest:98386} Alther's Mill
	["Cross the long bridge north into town: {npc:381} on the docks, {npc:900} in the town hall, the innkeeper in the inn, {npc:342} in her garden at the west end. {npc:382}'s Blackrock quests and {quest:98386} came with you from your first Redridge visit."] = "",
	-- {npc:900} Bailiff Conacher
	["{npc:900}, in the town hall"] = "",
	["The Wanted poster by the inn"] = "旅店旁的通缉布告",

	-- Step 30: Bellygrub
	-- {npc:345} Bellygrub · {npc:342} Martie Jainrose
	["{npc:345} (level 24) roots around the pen just west of Lakeshire, beside {npc:342}'s garden. Pull him away from the other boars and fight at full health."] = "",

	-- Step 31: Martie Jainrose
	-- {npc:342} Martie Jainrose
	["{npc:342}'s garden is at the west end of town."] = "",

	-- Step 32: Lakeshire
	-- {npc:342} Martie Jainrose
	["Back east through town from {npc:342}'s garden: two Wanted posters hang on the town hall doorway."] = "",
	["The Wanted poster on the town hall doorway"] = "",
	["The Wanted poster beside it"] = "",

	-- Step 33: Lake Everstill: kill these as you meet them
	["Lake Everstill: kill these as you meet them"] = "",
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula
	["Greater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "巨型狼蛛在湖东北边伐木场周围的山坡上爬行。",

	-- Step 34: Blackrock camps
	["Blackrock camps"] = "黑石营地",
	-- {object:116} Stonewatch Keep (no name in this language: may be words)
	["South-east from the mill, west of Galardell Valley's gnolls, to the Blackrock camps east of {object:116}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite. Weapon racks and swords lie about the camps; meat haunches, grain sacks and water barrels hold the supplies."] = "",
	-- {item:280841} Stolen Weapon
	["{item:280841}: weapon racks and swords on the ground"] = "",
	-- {item:280839} Blackrock Supplies
	["{item:280839}: meat haunches, grain sacks, water barrels"] = "",

	-- Step 35: Incinerator Gar'im
	["Gar'im keeps to the cave at the camps' south end with his imp and two orcs. Elite: group up if you can; solo, pull the orcs at the mouth first and interrupt his fire cast."] = "",

	-- Step 36: Galardell Valley
	["Galardell Valley"] = "",
	-- {npc:703} Lieutenant Fangore · {object:116} Stonewatch Keep (no name in this language: may be words)
	["North up the valley's east side. Shadowhide gnolls fill it; {npc:703} (26) and his two guards stand at its north end: clear the gnolls around him first and fight at full health. Stay out of {object:116} to the west until the watch tower: its orcs are elite."] = "",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}：任何暗皮豺狼人",

	-- Step 37: A Watchful Eye
	-- {object:31} Old Lion Statue
	["The {object:31} stands at the valley's east edge."] = "",

	-- Step 38: Looking Further
	-- {object:116} Stonewatch Keep (no name in this language: may be words)
	["West to the intact watch tower beside {object:116}: climb it and leave the Glyph in the empty jar at the top."] = "",

	-- Step 39: Stonewatch Keep
	-- {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The keep stands beside the tower. {npc:334} (elite) waits in the keep's top room with two guards and a dragon; Blackrock Shadowcasters (elite) and Sentries stand on its west side, so pull one at a time on the way in, and hug the right wall as you enter his room so you don't pull him at once. Elite: group up if you can."] = "",

	-- Step 40: Render's Valley
	["Render's Valley"] = "",
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["From the keep head back west along the lake's north shore and north up the Redridge Canyons to Render's Valley; Lakeshire's hand-ins wait for Keeshan's escort, which ends there. Blackrock Champions camp in the valley."] = "",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "",

	-- Step 41: Corporal Keeshan
	-- {zone:1428} Burning Steppes
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to Lakeshire; Blackrock orcs ambush you on the way."] = "",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "",

	-- Step 42: Back to Lakeshire
	["Back to Lakeshire"] = "",
	-- {npc:900} Bailiff Conacher · {npc:344} Magistrate Solomon · {npc:382} Marshal Marris · {npc:341} Foreman Oslow · {npc:903} Guard Howe
	["Into Lakeshire from the north with Keeshan: {npc:900} and {npc:344} in the town hall, {npc:382} and {npc:341} at the north end of the bridge, then over the bridge to {npc:903} and the gryphons."] = "",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}，在市政厅",
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}，在桥南的狮鹫旁",
	-- {zone:1431} Duskwood
	["Next: the gryphon to Darkshire for {zone:1431}'s second loop (05-duskwood)."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:69}"] = "回到{area:69}",
	-- ["Bellygrub"] = "贝利格拉布",
	-- ["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "向北过长桥进入镇子。{npc:341}和{npc:382}站在桥的北端，{npc:900}在市政厅，{npc:381}和{npc:266}在码头，{npc:343}在旅店，{npc:342}在镇子西端她的菜园里。",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "向东经过伐木场并过河。山谷里到处是暗皮豺狼人；{npc:703}（26级，比你高很多）在山谷北端率领它们：先清掉他的护卫，满血再打他。不要进入南边的{area:2099}：那里的兽人是精英。",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "飞往{area:108}，向西北骑到海岸：{object:177790}在近岸的海底。然后沿道路向东穿过艾尔文森林前往赤脊山。",
	-- ["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "沿{area:68}南岸的道路走到狮鹫管理员处。{npc:1070}和{npc:903}站在她旁边的路边。",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "交给{npc:3649}，在返回{area:442}时（06-ashenvale）",
	-- ["Gnolls toward {area:1002}"] = "前往{area:1002}方向的豺狼人",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "巨型狼蛛在湖东北边伐木场周围的山坡上爬行。",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "巨型狼蛛在湖东北伐木场周围的山坡上爬行；黑石叛节者占据着伐木场。",
	-- ["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "从{area:69}向北出发，沿{area:95}上行到{area:997}。黑石勇士在山谷中扎营。",
	-- ["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "基沙恩下士躲在山谷最北端，靠近{zone:1428}边界。护送他下山回到{area:69}；途中会遭到黑石兽人伏击。",
	-- ["Lake murlocs"] = "湖边的鱼人",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "鱼人食腐者和鱼人招潮者分布在桥东的南岸。它们都可能带有{item:1467}或鳍。",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "混血赤脊山豺狼人和其他豺狼人占据着{area:1002}以东、道路以北的山丘；赤脊山鞭笞者在其中游荡，赤脊山偷猎者在道路以南扎营。恐鹫和巨型血牙野猪也在这片山丘游荡。",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Redridge Brutes, for the Iron Pikes and Rivets, hold the hills further north; Dire Condors and Great Goretusks roam the hills east of them."] = "{npc:423}和其他豺狼人占据着{area:1002}以东、道路以北的山丘；{npc:712}在其中游荡，赤脊山偷猎者在道路南边扎营。掉落{item:2856}和铁铆钉的{npc:426}在更北边的山丘；{npc:428}和{npc:547}在它们东边的山丘游荡。",
	-- ["South down the valley's east side to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite."] = "沿山谷东侧向南，前往{area:2099}东边的黑石营地。营地里有黑石叛节者、步兵和前锋；保持在要塞东边，要塞里的兽人都是精英。",
	-- ["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "从桥边向东游进{area:68}；箱子在湖底。",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "旅店旁的通缉令：{area:1000}的{npc:703}",
	-- ["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "来自艾尔文森林的道路在{area:1002}进入赤脊山。{npc:464}站在通往赤脊山和{zone:1431}的道路交汇处。",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "来自{area:442}的船停靠在{area:17203}。走进城里学习技能并找{npc:1646}，然后从正门离开，沿道路向东穿过{zone:1429}。",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}：任何暗皮豺狼人",
	-- ["{item:280911}: Redridge Thrashers"] = "{item:280911}：赤脊山鞭笞者",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}：任何黑石兽人",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}：磨坊的黑石叛节者",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}：来自{area:442}的桑迪斯的信",
	-- ["{npc:266}, by the docks"] = "{npc:266}，在码头旁",
	-- ["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332}在{object:2100}的军情七处，{npc:6122}在{object:2101}{object:2164}的地下室，{npc:376}在光明大教堂。",
	-- ["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}：交给{zone:1436}的{npc:7024}，在{zone:1431}结束时",
	-- ["{npc:341}: after {quest:89}"] = "{npc:341}：在{quest:89}之后",
	-- ["{npc:344}, in the town hall"] = "{npc:344}，在市政厅",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345}（24级）在{area:69}西边的猪圈里拱来拱去。把他从其他野猪中引出来，满血再打。",
	-- ["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}：之后交给{zone:1457}的{npc:11401}",
	-- ["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}：之后交给{zone:1455}的{npc:11406}",
	-- ["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}：之后交给{zone:1455}的{npc:258785}",
	-- ["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}：之后交给{zone:1413}的{npc:6244}",
	-- ["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "下一站是{zone:1431}：沿道路向西到{area:1002}，再向南到{area:42}。",
	-- ["{zone:1453} class quests"] = "{zone:1453}职业任务",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习，然后乘地铁返回。",
}
