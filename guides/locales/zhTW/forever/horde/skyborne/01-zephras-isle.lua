-- Chinese (traditional) (zhTW): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "你在島嶼北部的{area:16635}醒來。{npc:251362}站在小徑旁，{npc:251361}在村莊中央。",

	-- Step 2: Thendal Grove
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "討厭的捲雲蜂和{npc:250873}在村莊東南方的樹林中遊蕩。",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "返回{area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}：{item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}：訓練師留給你的字條",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}：檢查{item:282418}",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "與{npc:257554}交談",

	-- Step 4: The watchtower
	["The watchtower"] = "瞭望塔",
	-- {spell:1259416} Walk on Air
	["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "爬上村裡的瞭望塔，從塔頂跳下，使用{spell:1259416}飄落地面。",

	-- Step 5: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "{npc:251361}的差事",

	-- Step 6: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "原始風石",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "原始風石是村莊周圍山坡上的藍色水晶。",

	-- Step 8: The standing stones
	["The standing stones"] = "立石",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363}站在村莊東邊的{area:17678}。{npc:251143}和奧拉凱斯皈依者聚集在她北邊不遠處。{object:460001}就在她的東北方：在它旁邊施放你的種族技能{spell:1259686}。",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "在{object:460001}附近施放{spell:1259686}",

	-- Step 9: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "蜂后在樹林的東南端盤旋，就在你從立石回來的路上。",

	-- Step 10: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "{area:16635}繳交任務",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}：閱讀{item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}，在瞭望塔內",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}，在瞭望塔內",
	-- {npc:251374} Windshaper Boro
	["{npc:251374}, at the village centre"] = "{npc:251374}，在村莊中央",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "德魯伊訓練師{npc:251373}，在{npc:251361}身後那棵樹的底層",

	-- Step 11: Windshaper Boro
	-- {npc:251374} Windshaper Boro
	["{npc:251374} stands in the village."] = "{npc:251374}站在村莊裡。",

	-- Step 12: Scrawny Ursera
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "{npc:250926}在村莊西南方的山坡上徘徊，就在前往{npc:252095}的路上。",

	-- Step 13: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095}在村莊西南方的{area:16622}等你。奧拉凱斯營地就在她後方；由{npc:256935}率領。",

	-- Step 14: Signet of Akir
	-- {npc:252095} Hanaa Nightwind
	["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "{npc:252095}後方營地裡的奧拉凱斯教徒身上帶著徽記。",

	-- Step 15: Urs'anah
	-- {npc:251115} Urs'anah
	["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "熊獸巢穴在村莊西邊。牠們的族母{npc:251115}坐在巢穴最深處。",

	-- Step 16: Leaving Thendal Village
	-- {area:16635} Thendal Village
	["Leaving {area:16635}"] = "離開{area:16635}",

	-- Step 17: Call of Earth
	-- {npc:251374} Windshaper Boro · {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374}派你前往村莊東邊不遠的{area:16988}：在那裡喝下{item:6635}以看見{npc:251166}，然後把{item:6656}帶回給他。",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}：{npc:5873}和你的{item:5175}",

	-- Step 18: Shen'dar Village
	-- {area:16624} Shen'dar Village
	["Follow the road south to {area:16624}, in the middle of the isle."] = "沿道路向南前往島嶼中部的{area:16624}。",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "與{npc:251902}交談",

	-- Step 19: Raan Wildwind's campfire
	-- {npc:263664} Raan Wildwind
	["{npc:263664}'s campfire"] = "{npc:263664}的營火",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest · {npc:251905} Zerril Softbreeze
	["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "坐在{npc:263664}的營火旁（輸入 /sit），直到獲得{spell:1229451}增益效果，然後到烹飪火堆旁找{npc:251905}。",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "在{npc:263664}的營火旁 /sit，直到獲得{spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["talk to {npc:251905}"] = "與{npc:251905}交談",

	-- Step 20: Welcome to Shen'dar Village
	-- {npc:251902} Illaya Amberwind
	["Talk to {npc:251902}"] = "與{npc:251902}交談",
	-- {npc:254089} Coriella Calmbreeze
	["Talk to {npc:254089}"] = "與{npc:254089}交談",
	["the bounty board"] = "懸賞告示板",

	-- Step 21: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "群爪與逐風者",
	-- {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "群爪和逐風者共同分布在村莊南邊的草地上。把{item:5469}留給{npc:251905}；蛋稍後從角鷹獸身上取得。",

	-- Step 22: High Order Apprentices
	-- plural, as words: High Order Apprentices = {npc:257521} High Order Apprentice
	["High Order Apprentices"] = "高天盟學徒",
	["The apprentices practise north-east of the village."] = "學徒們在村莊東北方練習。",

	-- Step 23: The highland bandits
	["The highland bandits"] = "高地強盜",
	["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "強盜營地在村莊東北方；『惡風』班尼克佔據最高處的營地。強盜身上帶著被偷的風石。",

	-- Step 24: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "{area:16624}繳交任務",

	-- Step 25: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589}潛伏在村莊南邊的群爪之間。{npc:254589}是精英：建議組隊。",

	-- Step 26: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529}在申德村南邊。{npc:257065}在村子邊緣與你會面；搜查他身後房子裡的衣櫃。",
	["search the wardrobe"] = "搜查衣櫃",

	-- Step 27: Constable Aonda
	-- {area:16624} Shen'dar Village
	["Back to {area:16624} with what you found."] = "帶著你找到的東西返回{area:16624}。",

	-- Step 28: Havoc in the Highlands
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "回到{quest:92529}：奧拉凱斯風暴召喚者和{npc:251662}遍布村莊，補給貯藏箱放在房屋之間，{npc:251966}在村莊東南端等著。",

	-- Step 29: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "向西南前往{area:17674}。{npc:252155}在塔頂；{item:254871}就在他身旁。",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "與{npc:252155}交談",

	-- Step 30: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "天空祭司安德斯和陣亡的守衛就在塔的西南方不遠處。從屍體上取得菈妮的幸運羽毛和影歌家族徽記。",

	-- Step 31: Hippogryph nests
	["Hippogryph nests"] = "角鷹獸巢穴",
	-- {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	-- plural, as words: Small Eggs = {item:6889} Small Egg
	["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "角鷹獸巢穴在塔的西北方、{quest:92529}西邊；角鷹獸族母在最西端。{item:263493}散落在巢穴周圍的地上，角鷹獸會掉落小蛋。",

	-- Step 32: Shen'dar Village, last time
	-- {area:16624} Shen'dar Village
	["{area:16624}, last time"] = "最後一次前往{area:16624}",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "向北走到{area:16624}；如果{item:5469}不夠，沿途擊殺逐風者補齊。",

	-- Step 33: To Valanaar
	-- {area:16638} Valanaar · {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "沿道路向東南前往南岸的天裔精靈城鎮{area:16638}。{npc:257006}和{npc:252448}站在城鎮西緣。",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "聆聽{npc:252448}的故事",

	-- Step 34: Windsong Crawlers
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers"] = "風歌蟹",
	["The crawlers scuttle along the shore south-west of town."] = "風歌蟹在城鎮西南方的海岸邊爬行。",

	-- Step 36: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "空躍者",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "空躍者在維菈妮雅西邊不遠的田野中跳來跳去。",

	-- Step 37: Ayessa Dawnsinger
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "與{npc:251968}交談",

	-- Step 38: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083}站在城鎮西北方不遠的{area:16626}。",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "聆聽{npc:256083}",

	-- Step 39: Wind Hollows and Construct Parts
	-- {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows and {object:616467}"] = "風之空靈與{object:616467}",
	-- {area:16638} Valanaar · {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "風之空靈在{area:16638}周圍的低地上飄蕩。第一批{object:616467}在果園道路的西邊。",

	-- Step 41: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663}在{area:16638}西邊，沿海岸道路前往。",
	-- {npc:252800} Aamelia Windfield
	["Talk to {npc:252800}"] = "與{npc:252800}交談",

	-- Step 42: The orchard
	["The orchard"] = "果園",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "熟透的風暴蘋果和振翼蝶粉末散落在果園各處；飢餓的強盜正在洗劫果園。逐風者在果園東邊的田野吃草。損壞的構造體漂浮在果園北緣。",

	-- Step 44: Bandit Highwaymen
	["Bandit Highwaymen"] = "強盜路霸",
	-- {object:616468} Construct Parts · {area:16638} Valanaar
	["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "強盜路霸佔據果園東北方的丘陵。更多{object:616468}在通往{area:16638}的道路附近。",

	-- Step 45: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "告訴{npc:252800}你準備好了",

	-- Step 46: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448}與{npc:256083}",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {item:15908} Taming Rod · {npc:254588} Windsong Crawler · {npc:251707} Ornery Galestrider · {npc:250874} Vuldren Alpha · {area:16663} Windfield Orchard · {npc:254411} Quel'dora Quickgale
	["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{area:16638}的{npc:252389}會三次交給你{item:15908}：馴服城鎮西北方湖邊的一隻{npc:254588}、城鎮西邊田野中的一隻{npc:251707}，以及{area:16663}的一隻{npc:250874}，每次完成後回去找她。{npc:254411}站在她身旁。",

	-- Step 48: Belathaan Brightwish
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247}在{area:16638}北邊、通往{area:16629}的路上等著。",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359}站在{area:16638}的東側。",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "向東北騎往{area:17675}。奧拉凱斯營地就在它西邊，{npc:252666}在營地北端。每個教徒都可能掉落風石符咒。",

	-- Step 52: Urs'endris
	-- {npc:255853} Urs'endris
	["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853}在瞭望塔北邊不遠的瀑布旁等著。",

	-- Step 53: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "返回{area:16638}",

	-- Step 54: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377}站在{area:16638}中央。",

	-- Step 55: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382}站在{area:16638}的西側。",

	-- Step 56: The turncoat
	["The turncoat"] = "叛徒",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "叛徒的房子在{area:16638}西北方的{area:16626}。{npc:273017}在附近等著；他的刺客潛伏在房子周圍。",
	["search the dead cultist in the house"] = "搜查房子裡死去的教徒",

	-- Step 57: Ur'endra
	-- {npc:258443} Ur'endra
	["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443}在叛徒房子南邊不遠的山坡上遊蕩。",

	-- Step 58: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "把眠炎火炬帶給{area:16638}西南方{area:16626}中、Shrine of Flames的{npc:268592}。",

	-- Step 59: Skypriest Faladiel
	-- {area:16638} Valanaar
	["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "天空祭司法拉迪爾站在{area:16638}北邊、瀑布西側的山丘上。",

	-- Step 60: Kuramaa
	-- {npc:268592} Olariaan Swiftburn · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "回去找{npc:268592}，然後向西進入{area:16623}：{npc:268605}的家在風歌蟹所在湖泊南邊的丘陵中。",

	-- Step 61: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "回去找{npc:268592}。等他點燃{npc:268762}，然後在計時結束前把火焰直接帶到{area:16638}中{npc:252382}身旁的{npc:268679}。",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 62: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "與{npc:252476}交談",

	-- Step 63: Desperate Times
	-- {npc:252383} Valennia Stormfist
	["Talk to {npc:252383}"] = "與{npc:252383}交談",
	-- {npc:251968} Ayessa Dawnsinger
	["Talk to {npc:251968}"] = "與{npc:251968}交談",
	-- {npc:252383} Valennia Stormfist
	["talk to {npc:252383}"] = "與{npc:252383}交談",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris
	["On the way north, back to {npc:255853} by the falls."] = "向北的路上，回到瀑布旁找{npc:255853}。",

	-- Step 65: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629}在{area:16638}北邊。一路殺穿守衛，前往東側的{npc:253576}。",
	-- {npc:253576} Hyusaa Quickbreeze
	["Talk to {npc:253576}"] = "與{npc:253576}交談",

	-- Step 66: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196}在神殿西側持有{item:263993}。",

	-- Step 67: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "向北進入{area:16631}；{npc:257944}在森林南緣紮營。",

	-- Step 68: Shadowgale Forest
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105}生長在{npc:257944}營地周圍，影風始祖鳥在上空飛翔。她東邊的奧拉凱斯營地裡有{item:265141}。",

	-- Step 69: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "再次找{npc:257944}",

	-- Step 70: The Al'Aketh camp
	["The Al'Aketh camp"] = "奧拉凱斯營地",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}、{npc:258130}和{npc:258134}在{npc:257944}東邊的教派營地。{npc:254151}站在營地邊緣。哈利安也會掉落{quest:94490}：閱讀它以開始下一個任務。{quest:94489}：進入Nightfang Den，治療7名受傷的德魯伊並找到{npc:258130}。",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "找到{npc:258130}",
	["Heal the injured druids in the Nightfang Den"] = "在Nightfang Den治療受傷的德魯伊",

	-- Step 71: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "最後一次找{npc:257944}",

	-- Step 72: Windsong Lake
	-- {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "難民的財物散落在{area:16625}北岸；{npc:259013}在湖的西北端。",

	-- Step 73: The Strange Hermit
	-- {area:16625} Windsong Lake · {item:257128} Zephyrseed
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "隱士住在{area:16625}西岸。{item:257128}毬果生長在他南邊；風之空靈在湖的東邊飄蕩。",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "與{npc:251684}交談",

	-- Step 74: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {npc:251968} Ayessa Dawnsinger
	["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "搭乘傳送門上到{area:16630}，與{npc:252475}和{npc:251968}一起對抗高階女祭司洛舒娜。",

	-- Step 77: The airship
	["The airship"] = "飛艇",
	-- {area:16638} Valanaar · {zone:1412} Mulgore
	["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "部落飛艇停靠在{area:16638}西南緣。搭乘它前往卡林多；它會降落在{zone:1412}北部。",
	["Horde airship"] = "部落飛艇",

	-- Step 78: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "{zone:1412}北部",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "你將永遠離開這座島。{npc:259119}在飛艇降落處等著。",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}：先留著，{zone:1454}的索爾要再過兩份指南才會用到",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "降落處旁的{npc:259118}：給{zone:1456}的{npc:3033}",

	-- Step 79: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638}就在降落處旁：搭升降梯上去，向雙足飛龍管理員{npc:2995}學習飛行路線。",

	-- Step 80: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068}想要牛頭人的薰香：向草藥商{npc:3014}、附魔供應商{npc:3012}、製皮供應商{npc:3005}和烹飪供應商{npc:3027}購買四種材料，然後合成{item:278078}。",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}，向{npc:3014}購買",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}，向{npc:3012}購買",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}，向{npc:3005}購買",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}，向{npc:3027}購買",

	-- Step 81: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "在{area:1641}朝南的懸崖上，對儀式墊和香爐使用{item:278078}。",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "在{area:1641}撒下{item:278078}",

	-- Step 83: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033}在{area:1639}訓練德魯伊。他會教你{spell:18960}；約23級進行{spell:499}之旅時，{npc:11802}的歡迎在等著你（forever/horde/04-the-barrens）。",

	-- Step 84: The Crossroads
	-- {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {zone:1413} Barrens · {area:458} Gold Road · {area:380} The Crossroads
	["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "搭升降梯離開{zone:1456}，沿道路向南經過{area:222}，穿過東邊的山口進入{zone:1413}；從山口沿{area:458}向北前往{area:380}，即{zone:1413}中央的部落城鎮。",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "雙足飛龍管理員{npc:3615}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Kuramaa"] = "庫拉瑪",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "搭升降梯離開{zone:1456}，沿道路向南經過{area:222}，穿過東邊的山口進入{zone:1413}；從山口沿{area:458}向北前往{area:380}，即{zone:1413}中央的部落城鎮。",
	-- ["Rorian: {quest:92485}"] = "羅里安：{quest:92485}",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "強盜路霸佔據果園東北方的丘陵。更多{object:616466}在通往{area:16638}的道路附近。",
	-- ["Wind Hollows and {object:616466}"] = "風之空靈與{object:616466}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "風之空靈在{area:16638}周圍的低地上飄蕩。第一批{object:616466}在果園道路的西邊。",
}
