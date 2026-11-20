-- Chinese (traditional) (zhTW): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {zone:1429} Elwynn Forest · {quest:174} Look to the Stars · {area:42} Darkshire · {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {object:2096} Trade District
	["Train, then leave by the main gate and follow the road east through {zone:1429}.\n{quest:174} in {area:42} needs a {item:4371}. Its vendors keep only one or two, and {npc:3133} in {area:42} is nearly always sold out: buy one at the Auction House in the {object:2096} on your way out. An engineer can make one too."] = "訓練完，從正門出城，沿路向東穿過{zone:1429}。\n{area:42}的{quest:174}需要一個{item:4371}。商人只備一兩個，而{area:42}的{npc:3133}幾乎總是賣光：出門時在{object:2096}的拍賣行買一個。工程學也能做一個。",
	["Your new spells"] = "你的新法術",
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {area:42} Darkshire
	["{item:4371}: the Auction House, for {quest:174} in {area:42}"] = "{item:4371}：拍賣行，用於{area:42}的{quest:174}",

	-- Step 2: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "趁在這裡：向{npc:11867}學習長柄武器（{object:2096}，1金）；雙手武器讓戰士練級最快。",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "趁在這裡：向{npc:11867}學習長柄武器（{object:2096}，1金）；獵人的近戰武器主要提供屬性，雙手武器的屬性最多。",

	-- Step 4: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "飛往{area:108}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飛行管理員",

	-- Step 5: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn."] = "飛往{area:108}，向西北前往海岸：{object:177790}在岸外的海底。然後沿著道路向東穿過艾爾文森林。",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}：{object:177790}",

	-- Step 6: Elwynn Forest
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",

	-- Step 7: Theocritus
	["On the top floor"] = "頂層",

	-- Step 8: Henze Faulk
	-- {area:91} Tower of Azora · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the {area:91}, head north from the bridge to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "沿路向東，經過{area:91}後從橋邊向北到{area:86}。{npc:6172}躺在湖的南邊：對他使用{item:6866}。他周圍的迪菲亞流氓巫師帶著{item:6846}。",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "對{npc:6172}使用{item:6866}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}：迪菲亞流浪巫師",

	-- Step 9: Three Corners
	-- {area:1002} Three Corners · {zone:1431} Duskwood
	["The road east through Elwynn crosses into Redridge at {area:1002}, where the roads to Redridge, {zone:1431} and Elwynn meet: south to {zone:1431} first."] = "向東穿過艾爾文森林的道路在{area:1002}進入赤脊山，通往赤脊山、{zone:1431}和艾爾文森林的道路在那裡交會：先往南前往{zone:1431}。",

	-- Step 11: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "沿著道路從{area:1002}向南進入{zone:1431}；{area:42}位於森林東側。",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}，在城鎮北端",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "{npc:265}，在旅店旁她的房子裡；室內",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}，室內",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}，在旅店",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}，在市政廳裡",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}，在市政廳裡",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}，在市政廳後面的房子裡",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "{npc:633}，在小鎮南端；室內",
	-- {npc:633} Elaine Carevin · {npc:288} Jitters · {quest:163} Raven Hill
	["{npc:633}: {npc:288}, at {quest:163}"] = "{npc:633}：{npc:288}，在{quest:163}",

	-- Step 12: Viktori Prism'Antras
	-- {npc:276} Viktori Prism'Antras · {quest:174} Look to the Stars · {item:4371} Bronze Tube
	["{npc:276} is in her house at the east end of town. {quest:174} needs a {item:4371}, so this step shows only while you carry one: without a tube the guide passes {npc:276} and her chain."] = "{npc:276}在城鎮東端她的房子裡。{quest:174}需要一個{item:4371}，所以只有你身上帶著一個時才會顯示這個步驟：沒有銅管的話，指南會略過{npc:276}和她的任務鏈。",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}，室內",

	-- Step 13: Viktori Prism'Antras
	-- {npc:302} Blind Mary
	["For {npc:302}, on the hill south-east of town"] = "交給{npc:302}，在鎮子東南方的山上",

	-- Step 14: Councilman Millstipe
	-- {area:717} Stockade · {zone:1453} Stormwind · {npc:270} Councilman Millstipe
	["For your {area:717} run, in {zone:1453} at about 29: {npc:270} is in the town hall. Keep it until then."] = "為了你約29級時在{zone:1453}的{area:717}之行：{npc:270}在市政廳。在那之前先留著它。",

	-- Step 15: Tranquil Gardens Cemetery: kill these as you meet them
	-- {area:121} Tranquil Gardens Cemetery
	["{area:121}: kill these as you meet them"] = "{area:121}：遇到就殺",
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "骷髏戰士和骷髏法師在{area:42}東南側的墓地遊蕩，就在山丘上{npc:302}房屋的下方。{zone:1431}的所有骷髏都有機率掉落{item:2378}。\n注意：骷髏站位密集，直接衝進去容易同時引到多個敵人。",

	-- Step 16: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888}站在道路南邊的{area:245}。",

	-- Step 17: Raven Hill
	-- {quest:163} Raven Hill · {object:673515} Memory of Valor · {npc:288} Jitters
	["Continue west to {quest:163}. The {object:673515} glows by the ruined house south of the road; {npc:288} hides in the house at the west end of the village."] = "繼續向西到{quest:163}。{object:673515}在道路南邊的廢棄房屋旁發光；{npc:288}藏在村子西端的房子裡。",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}，來自{object:673515}",
	-- {npc:272} Chef Grual · {area:42} Darkshire
	["for {npc:272} in {area:42}"] = "交給{area:42}的{npc:272}",

	-- Step 18: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "沿著道路向西北經過墓地，前往森林最西緣的{npc:311}營地。{npc:893}站在{npc:311}旁邊。",

	-- Step 19: The Hushed Bank: kill these as you meet them
	-- {area:1097} The Hushed Bank
	["{area:1097}: kill these as you meet them"] = "{area:1097}：遇到就殺",
	-- {npc:289} Abercrombie · {area:1097} The Hushed Bank · {quest:163} Raven Hill · {npc:311} Sven Yorgen · {zone:1436} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders are the small spiders, and few: most crawl along the {area:1097} west of {quest:163}, fewer up north towards {npc:311}'s camp; they drop the venom too. Every ghoul of the cemetery's northern half can drop a fang. Wolves and the bigger spiders share the {zone:1436} border, so pull with care."] = "狂躁兇狼在墓地和{npc:289}周圍的森林遊蕩，飢餓兇狼在他東北的山丘。小毒網蜘蛛就是那些小蜘蛛，數量不多：多數沿{quest:163}以西的{area:1097}爬行，往北到{npc:311}營地一帶更少；它們也掉毒液。墓地北半部的每個食屍鬼都可能掉落獠牙。狼和較大的蜘蛛共處{zone:1436}邊界一帶，引怪要小心。",
	-- {item:1130} Vial of Spider Venom
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Venom Web Spiders = {npc:217} Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "{item:1130}：小型結網毒蜘蛛、結網毒蜘蛛和綠色隱士蛛",
	-- {item:2251} Gooey Spider Leg · {npc:272} Chef Grual · {area:42} Darkshire
	["{item:2251}: keep the ones these spiders drop, for {npc:272} in {area:42}"] = "{item:2251}：這些蜘蛛掉的就留著，交給{area:42}的{npc:272}",

	-- Step 20: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "隱士的小屋在{area:492}東北方的樹林裡。",

	-- Step 21: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492}：遇到就殺",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend · Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Fetid Corpses = {npc:1270} Fetid Corpse
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends (23-25) walk its southern half and carry the fingers; for the fangs, Flesh Eaters (24-25) drop the most, so leave the Bone Chewers, Plague Spreaders and Fetid Corpses (26-30) further in alone. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: Eliza, a level 31 elite, rises from her grave at the cemetery's north end: keep away from it."] = "墓地在村子北邊。恐怖骷髏和骷髏魔（23-25級）在南半部遊走，身上帶著手指；獠牙則是食腐者（24-25級）掉最多，所以別理會更深處的噬骨者、瘟疫食屍鬼和惡臭的食屍鬼（26-30級）。精英{npc:522}在墳墓間遊蕩：離他遠一點。\n小心：31級精英伊莉莎會從墓地北端的墳墓中出現：離那裡遠一點。",

	-- Step 22: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Head back east along the road to the {area:245}."] = "沿路向東回到{area:245}。",

	-- Step 23: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "鬆土堆在農舍南邊的老樹樁旁。",

	-- Step 24: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "{npc:268}，室內",
	-- {npc:272} Chef Grual
	["{npc:272}, in the Scarlet Raven Tavern"] = "{npc:272}，在猩紅渡鴉酒館裡",
	-- {npc:272} Chef Grual · {zone:1431} Duskwood
	-- plural, as words: Gooey Spider Legs = {item:2251} Gooey Spider Leg
	["{npc:272}: six Gooey Spider Legs, which {zone:1431}'s spiders drop even without the quest"] = "{npc:272}：六條黏稠的蜘蛛腿，{zone:1431}的蜘蛛沒接任務也會掉",
	["Already carrying six? Hand them in now"] = "已經帶了六條？現在就交",
	-- {npc:288} Jitters · {quest:163} Raven Hill · {zone:1431} Duskwood
	["For {npc:288}, at {quest:163} on the next {zone:1431} loop"] = "交給{npc:288}，在下一趟{zone:1431}環線做{quest:163}時",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}，在市政廳旁",

	-- Step 26: Redridge Mountains
	-- {area:42} Darkshire · {area:69} Lakeshire · {area:1002} Three Corners
	["Fly from {area:42} to {area:69} if you know the flight path. On foot, take the north road to {area:1002}."] = "",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "{area:69}飛行管理員",

	-- Step 27: Lakeridge Highway
	-- {npc:903} Guard Howe · {area:1002} Three Corners
	["{npc:903} stands by the gryphon master, south of the bridge. From {area:1002}, follow the road east along the lake."] = "",

	-- Step 28: Lake Everstill's murlocs: kill these as you meet them
	-- {area:68} Lake Everstill
	["{area:68}'s murlocs: kill these as you meet them"] = "{area:68}的魚人：遇到就殺",
	-- {area:68} Lake Everstill
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore of {area:68}, just east of the gryphons and the bridge. Any of them can carry a fin."] = "魚人食腐者和魚人招潮者分布在{area:68}的南岸，就在獅鷲和橋的東邊。他們每一個都可能帶著魚鰭。",

	-- Step 29: Lakeshire
	-- {npc:381} Dockmaster Baren · {npc:900} Bailiff Conacher · {npc:342} Martie Jainrose · {npc:382} Marshal Marris · {npc:341} Foreman Oslow · {quest:98386} Alther's Mill
	["Cross the long bridge north into town: {npc:381} on the docks, {npc:900} in the town hall, {npc:342} in her garden at the west end. {npc:382} and {npc:341} stand at the north end of the bridge: the Blackrock camps' quests and {quest:98386} are worked on this visit's loop east of the lake."] = "向北走過長橋進入城鎮：{npc:381}在碼頭，{npc:900}在市政廳，{npc:342}在西端她的花園裡。{npc:382}和{npc:341}站在橋的北端：黑石營地的任務和{quest:98386}要在這次湖東邊的環線中完成。",
	-- {npc:415} Verner Osgood
	["{npc:415}, by the road at the north end of the bridge"] = "{npc:415}，在橋北端的路邊",
	-- {npc:382} Marshal Marris
	["{npc:382}, at the north end of the bridge"] = "{npc:382}，在橋的北端",
	-- {npc:341} Foreman Oslow
	["{npc:341}, beside him"] = "{npc:341}，在他旁邊",
	-- {npc:900} Bailiff Conacher
	["{npc:900}, in the town hall"] = "{npc:900}，在城鎮大廳裡",
	["The Wanted poster by the inn"] = "旅店旁的通緝告示",

	-- Step 30: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire · {npc:342} Martie Jainrose
	["{npc:345} (level 24) roots around the pen just west of {area:69}, beside {npc:342}'s garden. Pull him away from the other boars and fight at full health."] = "{npc:345}（24級）在{area:69}西邊不遠處的豬圈裡拱土，就在{npc:342}的花園旁。把牠從其他野豬旁拉開，滿血再戰。",

	-- Step 31: Martie Jainrose
	-- {npc:342} Martie Jainrose
	["{npc:342}'s garden is at the west end of town."] = "{npc:342}的花園在鎮子西端。",

	-- Step 32: Lakeshire
	-- {npc:342} Martie Jainrose
	["Back east through town from {npc:342}'s garden: two Wanted posters hang on the town hall doorway."] = "從{npc:342}的花園向東穿回鎮上：市政廳門口掛著兩張通緝佈告。",
	["The Wanted poster on the town hall doorway"] = "市政廳門口的通緝佈告",
	["The Wanted poster beside it"] = "它旁邊的通緝佈告",

	-- Step 33: Alther's Mill
	-- {quest:98386} Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Tarantula Eggs = {object:673101} Tarantula Egg
	["Greater Tarantulas crawl on the slopes around {quest:98386}, north-east of the lake; their Tarantula Eggs lie on the ground among them: click six."] = "巨型狼蛛在湖東北方{quest:98386}周圍的山坡上爬行；牠們的狼蛛卵散落在牠們之間的地上：點擊六顆。",

	-- Step 34: Blackrock camps
	["Blackrock camps"] = "黑石營地",
	-- {area:1000} Galardell Valley · {area:2099} Stonewatch Keep
	["South-east from the mill, west of {area:1000}'s gnolls, to the Blackrock camps east of {area:2099}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite. Weapon racks and swords lie about the camps; meat haunches, grain sacks and water barrels hold the supplies."] = "從磨坊向東南，到{area:1000}豺狼人以西，再到{area:2099}以東的黑石營地。營地裡滿是叛徒、步兵和先鋒；待在要塞以東，那裡面的獸人是精英。武器架和長劍散落在營地各處；補給放在腿肉、糧袋和水桶裡。",
	-- {item:280841} Stolen Weapon
	["{item:280841}: weapon racks and swords on the ground"] = "{item:280841}：地上的武器架和長劍",
	-- {item:280839} Blackrock Supplies
	["{item:280839}: meat haunches, grain sacks, water barrels"] = "{item:280839}：腿肉、糧袋、水桶",

	-- Step 35: Incinerator Gar'im
	["Gar'im keeps to the cave at the camps' south end with his imp and two orcs. Elite: group up if you can; solo, pull the orcs at the mouth first and interrupt his fire cast."] = "加里姆待在營地南端的洞穴裡，帶著他的小鬼和兩名獸人。精英：能組隊就組隊；單刷的話，先拉洞口的獸人，並打斷他的火焰施法。",

	-- Step 36: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["North up the valley's east side. Shadowhide gnolls fill it; {npc:703} (26) and his two guards stand at its north end: clear the gnolls around him first and fight at full health. Stay out of {area:2099} to the west until the watch tower: its orcs are elite."] = "沿山谷東側向北。影皮豺狼人遍佈谷中；{npc:703}（26級）和兩名守衛站在谷北端：先清掉他周圍的豺狼人，滿血再打。西邊的{area:2099}在到瞭望塔前別進去：那裡的獸人是精英。",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}：任何暗皮豺狼人",

	-- Step 37: A Watchful Eye
	-- {object:31} Old Lion Statue
	["The {object:31} stands at the valley's east edge."] = "{object:31}立在山谷東緣。",

	-- Step 38: Looking Further
	-- {area:2099} Stonewatch Keep
	["West to the intact watch tower beside {area:2099}: climb it and leave the Glyph in the empty jar at the top."] = "向西到{area:2099}旁完好的瞭望塔：爬上去，把符文放進塔頂的空罐裡。",

	-- Step 39: Stonewatch Keep
	-- {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The keep stands beside the tower. {npc:334} (elite) waits in the keep's top room with two guards and a dragon; Blackrock Shadowcasters (elite) and Sentries stand on its west side, so pull one at a time on the way in, and hug the right wall as you enter his room so you don't pull him at once. Elite: group up if you can."] = "要塞就在塔旁。{npc:334}（精英）帶著兩名守衛和一條龍守在要塞頂層的房間裡；黑石暗影施法者（精英）和哨兵站在要塞西側，進去時一次只拉一隻，進他房間時貼著右牆走，免得一下子把他拉過來。精英：能組隊就組隊。",

	-- Step 40: Yowler
	-- {area:95} Redridge Canyons · {area:997} Render's Valley · {npc:518} Yowler
	-- plural, as words: Redridge Alphas = {npc:445} Redridge Alpha
	["From the keep head back west along the lake's north shore and north up the {area:95}. Just south of {area:997}, {npc:518}, a level 25 gnoll, walks among the Redridge Alphas and Mystics."] = "從要塞沿湖的北岸向西回走，再向北走{area:95}。{area:997}正南，25級的豺狼人{npc:518}在赤脊阿爾法和赤脊秘法師中間走動。",

	-- Step 41: Render's Valley
	-- {area:95} Redridge Canyons · {area:997} Render's Valley · {area:69} Lakeshire
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["From the keep head back west along the lake's north shore and north up the {area:95} to {area:997}; {area:69}'s hand-ins wait for Keeshan's escort, which ends there. Blackrock Champions camp in the valley."] = "從要塞沿湖北岸向西折回，再向北沿{area:95}上行到{area:997}；{area:69}的待交任務要等基沙恩的護送，護送就在那裡結束。黑石勇士在山谷裡紮營。",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "{npc:435}，地下",

	-- Step 42: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "基沙恩躲在山谷最北端、{zone:1428}邊界旁。護送他下到{area:69}；途中黑石獸人會伏擊你。",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "{npc:349}，地下",

	-- Step 43: Magistrate Solomon: Gath'Ilzogg
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}，在市政廳",

	-- Step 45: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "返回{area:69}",
	-- {area:69} Lakeshire · {npc:900} Bailiff Conacher · {npc:344} Magistrate Solomon · {npc:382} Marshal Marris · {npc:341} Foreman Oslow · {npc:903} Guard Howe
	["Into {area:69} from the north with Keeshan: {npc:900} and {npc:344} in the town hall, {npc:382} and {npc:341} at the north end of the bridge, then over the bridge to {npc:903} and the gryphons."] = "帶著基沙恩從北邊進入{area:69}：{npc:900}和{npc:344}在市政廳，{npc:382}和{npc:341}在橋北端，然後過橋到{npc:903}和獅鷲那裡。",
	-- {npc:415} Verner Osgood
	["{npc:415}, by the road on the way to the bridge"] = "{npc:415}，在去橋的路上路邊",
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}，在橋南邊的獅鷲旁",
	-- {area:42} Darkshire · {zone:1431} Duskwood
	["Next: the gryphon to {area:42} for {zone:1431}'s second loop (05-duskwood)."] = "接下來：乘獅鷲前往{area:42}，開始{zone:1431}的第二輪路線（05-duskwood）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north along the road from {area:42} to {area:1002}."] = "沿路向北，從{area:42}回到{area:1002}。",
	-- ["Bellygrub"] = "貝利格拉布",
	-- ["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "向北走過長橋進入城鎮。{npc:341}和{npc:382}站在橋的北端，{npc:900}在市政廳，{npc:381}和{npc:266}在碼頭，{npc:343}在旅店，{npc:342}在西端她的花園裡。",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "向東經過伐木場並渡河。暗皮豺狼人遍布山谷；{npc:703}（26級，遠高於你）在北端帶領他們：先清掉他的護衛，滿血再打他。不要進入南邊的{area:2099}：那裡的獸人是精英。",
	-- ["Follow the road along the south shore of {area:68} to the gryphon master. {npc:903} stands by the road next to her."] = "沿著{area:68}南岸的道路前往獅鷲管理員處。{npc:903}站在她旁邊的路旁。",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "給{npc:3649}，在回到{area:442}時（06-ashenvale）",
	-- ["Gnolls toward {area:1002}"] = "前往{area:1002}方向的豺狼人",
	-- ["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "向北離開{area:69}，沿著{area:95}前往{area:997}。黑石勇士在山谷中紮營。",
	-- ["Lake murlocs"] = "湖邊魚人",
	-- ["Level 18 and 20 spells"] = "18級和20級法術",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "混血赤脊山豺狼人和其他豺狼人佔據{area:1002}東邊、道路北側的山丘；赤脊山鞭笞者在牠們之間徘徊，赤脊山偷獵者在道路南側紮營。恐鷲和巨型血牙野豬在同樣的山丘上遊蕩。",
	-- ["Shaman training"] = "薩滿訓練",
	-- ["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "從橋向東游進{area:68}；箱子在湖底。",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "旅店旁的通緝告示：{npc:703}，在{area:1000}",
	-- ["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "墓地在村莊北邊。恐怖骸骨和骸骨魔在墓地南半部走動。精英{npc:522}在墓地之間遊蕩：遠離他。",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "{area:442}的船停靠在{area:17203}。走進城裡學習技能並找{npc:1646}，然後從正門離開，沿著道路向東穿過{zone:1429}。",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}：任何暗皮豺狼人",
	-- ["{item:280911}: Redridge Thrashers"] = "{item:280911}：赤脊山鞭笞者",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}：任何黑石獸人",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}：磨坊的黑石叛節者",
	-- ["{item:4371}, from {npc:3133}, if you have none"] = "如果你沒有，向{npc:3133}購買{item:4371}",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}：來自{area:442}的桑迪斯的信",
	-- ["{npc:266}, by the docks"] = "{npc:266}，在碼頭旁",
	-- ["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332}在{object:2100}的軍情七處，{npc:6122}在{object:2101}的{object:2164}地下室，{npc:376}在光明大教堂。",
	-- ["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}：由{zone:1436}的{npc:7024}接收，在{zone:1431}的結尾",
	-- ["{npc:341}: after {quest:89}"] = "{npc:341}：在{quest:89}之後",
	-- ["{npc:344}, in the town hall"] = "{npc:344}，在市政廳",
	-- ["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}：由{zone:1457}的{npc:11401}接收，稍後",
	-- ["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}：由{zone:1455}的{npc:11406}接收，稍後",
	-- ["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}：由{zone:1455}的{npc:258785}接收，稍後",
	-- ["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}：由{zone:1413}的{npc:6244}接收，稍後",
	-- ["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "下一站是{zone:1431}：沿著道路向西前往{area:1002}，再向南前往{area:42}。",
	-- ["{zone:1453} class quests"] = "{zone:1453}職業任務",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453}沒有薩滿訓練師：從{object:28027}搭乘{area:2257}前往{zone:1455}，向{npc:258098}學習，然後搭地鐵回來。",
}
