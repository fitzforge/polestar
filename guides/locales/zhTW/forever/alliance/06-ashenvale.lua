-- Chinese (traditional) (zhTW): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aquatic Form
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {item:15885} Pendant of the Sea Lion · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "從{area:17203}搭船到{area:442}。把兩半墜飾合成{item:15885}，施放{spell:18960}：{npc:11802}在{area:2361}。然後飛往{area:702}（途經{area:442}）。",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885}：合成兩半",

	-- Step 2: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine
	["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "搭傳送門上到{area:1658}，然後飛回{area:442}。",

	-- Step 3: Elune's Grace
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:11401} Priestess Alathea
	["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "從{area:17203}搭船到{area:442}，飛往{area:702}；{npc:11401}在Temple of the Moon。然後飛回{area:442}。",

	-- Step 4: Boat to Auberdine
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "從{area:17203}搭船到{area:442}；{npc:3649}站在村子北端。然後沿道路向南騎過{zone:1439}。",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}: Alexston's reply"] = "{npc:3649}：巴洛斯·艾力克斯頓的回信",

	-- Step 5: Kerlonian Evershade
	-- {area:448} Grove of the Ancients · {zone:1439} Darkshore · {item:13536} Horn of Awakening · {zone:1440} Ashenvale · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "克羅尼亞·恒影睡在{zone:1439}南部的{area:448}。使用{item:13536}叫醒他，沿道路向南帶他進入{zone:1440}，到{area:413}找{npc:11219}；每當他睡著就再吹一次號角。",
	-- {area:413} Maestra's Post · {zone:1440} Ashenvale
	["Escort Kerlonian to {area:413} in {zone:1440}."] = "護送克羅尼亞·恒影到{zone:1440}的{area:413}。",

	-- Step 7: Bathran's Haunt
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "在邁斯特拉崗哨北邊，植物束散落在{area:411}廢墟周圍。暗灘祭司佔據其南邊不遠的廢墟：任何一個都可能掉落{item:5366}。",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}，從植物束取得",

	-- Step 9: Astranaar
	-- {area:415} Astranaar
	["Follow the road south-east to {area:415}, on the island in the lake."] = "沿道路向東南前往湖中島上的{area:415}。",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}，在旅店裡",

	-- Step 10: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "向西騎到{area:441}的岸邊。泰洛尼斯的屍體躺在鹽沫魚人之間；任何魚人都可能掉落{item:5463}。",

	-- Step 11: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "在魚人南邊，{npc:3585}在{area:416}等著。",

	-- Step 12: Ilkrud Magthrull
	-- {npc:3664} Ilkrud Magthrull · {area:412} Ruins of Ordil'Aran
	["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664}和他的虛無行者佔據神殿南邊的{area:412}。先拉他的守衛。",

	-- Step 13: The Zoram Strand
	-- {area:414} The Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "沿海岸向北前往{area:414}。{npc:3846}在海灘上紮營；怒尾納迦遍布海岸。",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}，在海岸上的廢墟裡",

	-- Step 15: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} The Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009}帶著怒尾守衛在{area:414}的北端走動。",

	-- Step 19: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987}（25級）率領{area:415}北邊營地的薊皮熊怪。先一個一個清掉他的守衛。",

	-- Step 20: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "淚珠在{area:415}東邊的小島上發光。",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "沿道路向東前往{area:419}；{npc:3916}站在月井旁。",

	-- Step 23: The Foulweald
	["The Foulweald"] = "汙林熊怪",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "汙林熊怪住在道路南邊、{area:415}東南方的樹林中。汙林衛兵和汙林巨熊怪守護巢穴。",

	-- Step 24: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885}站在{area:421}東岸的{area:420}；{npc:210995}在湖的西岸紮營。污濁的水元素在兩者之間的湖中涉水。",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "擊殺元素取得5個完整的元素護腕，然後使用{item:5456}",

	-- Step 25: The Ruins of Stardust
	["West of Mystral Lake, the stardust bushes grow among the ruins."] = "在密斯特拉湖西邊，星塵灌木生長在廢墟之間。",

	-- Step 27: Windshear Crag
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "向南騎過{area:421}進入{area:1276}隧道；出口在石爪山脈的{area:461}。{npc:4080}和{npc:4077}在峭壁西南方的{area:1076}紮營。",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, in the hut north of them"] = "{npc:4201}，在他們北邊的小屋裡",

	-- Step 28: Venture Co. loggers
	["Venture Co. loggers"] = "風險投資公司樵夫",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "風險投資公司正在砍伐{area:461}的森林。樵夫和砍樹工到處工作；操作員駕駛伐木機，其中一人帶著藍圖。",

	-- Step 29: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276}在峭壁東端的{area:2160}採礦。和他交談，在他採礦時擊退風險投資公司的襲擊者。",

	-- Step 31: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "前往{area:150}",
	-- {area:1276} Talondeep Path
	["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "爐石在冷卻中？向北騎回去穿過{area:1276}。",
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "搭船前往{area:150}",

	-- Step 32: Menethil Harbor
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}，在旅店北邊的碼頭上",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}，在旅店裡",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep"] = "{npc:2086}，在城堡旁",
	-- {npc:2097} Harlo Barnaby
	["{npc:2097}, by the north gate"] = "{npc:2097}，在北門旁",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the north gate"] = "{npc:2094}，在北門旁",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}，在北門旁",

	-- Step 33: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "木材和鐵堆放在城堡周圍和港口的城牆邊。",

	-- Step 35: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "沿海岸向北離開米奈希爾港。藍腮魚人遍布沼澤；{npc:1259}帶著一群魚人在中間走動。",

	-- Step 37: The Bluegill hovels
	["The Bluegill hovels"] = "藍腮魚人小屋",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "魚人小屋中的三個容器，由南到北：{object:261}，然後是{object:142151}，最後是北端的{object:259}。",

	-- Step 38: Karl Boran
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}：給城堡裡的{npc:2104}",

	-- Step 39: Captain Stoutfist
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1242} Karl Boran
	["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104}站在{area:2103}，離{npc:1242}不遠。",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "給{object:2117}的伯瓦爾·弗塔根公爵：先留著",

	-- Step 40: Young crocolisks
	["Young crocolisks"] = "小鱷魚",
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "沿道路向東。小濕地鱷魚潛伏在挖掘場北邊的水池中。",

	-- Step 41: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "挖掘場在道路南邊的山丘上。",

	-- Step 42: The raptor hills
	["The raptor hills"] = "迅猛龍丘陵",
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor
	["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "雜斑迅猛龍和雜斑尖嘯龍在挖掘場西邊的丘陵遊蕩。",

	-- Step 44: Raptor valley
	["Raptor valley"] = "迅猛龍山谷",
	["The bigger raptors hunt in the valley just west of the dig."] = "體型更大的迅猛龍在挖掘場西邊不遠的山谷中狩獵。",

	-- Step 46: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "洞穴捕獵者和吸血捕獵者遍布挖掘場東南方的洞穴{area:1021}。",

	-- Step 47: Black Oozes
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes"] = "黑色軟泥怪",
	-- {area:1025} Green Belt · {npc:2093} Einar Stonegrip · {npc:2111} Sida
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "黑色軟泥怪在{area:1025}道路北邊、{npc:2093}營地西邊的沼澤中爬行。任何軟泥怪都可能帶著{npc:2111}的袋子。",

	-- Step 48: Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093}在路邊紮營；{npc:1244}站在更東邊的河邊。",

	-- Step 49: The Mosshide gnolls
	["The Mosshide gnolls"] = "蘚皮豺狼人",
	-- {area:1025} Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "蘚皮豺狼人和混血蘚皮豺狼人佔據{area:1025}東南方的丘陵。",

	-- Step 51: Crude Flint
	-- {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "蘚皮沼澤行者和蘚皮織霧者在{npc:1244}西邊和南邊不遠的河岸遊蕩；幾乎每一隻都會掉落燧石。",

	-- Step 53: Fen Creepers
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers"] = "沼澤爬行者",
	-- {area:1025} Green Belt
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "沼澤爬行者躲在{area:1025}西北方的沼澤水池中。",

	-- Step 54: Dun Modr
	-- {area:205} Dun Modr · {area:881} Thandol Span · {npc:1071} Longbraid the Grim
	["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "沿道路向北前往{area:881}山腳下的{area:205}。{npc:1071}站在矮人營地裡。",

	-- Step 56: Dragonmaw camp
	["Dragonmaw camp"] = "龍喉營地",
	-- {area:1025} Green Belt · {npc:2092} Pilot Longbeard · {zone:1426} Dun Morogh
	["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "龍喉營地在道路南邊、{area:1025}西邊不遠處：有龍喉襲擊者、龍喉沼澤行者和龍喉白骨守衛。{npc:2092}在{zone:1426}的任務需要28級。",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Raiders = {npc:1034} Dragonmaw Raider
	["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "在{zone:1437}的龍喉營地刷龍喉襲擊者和龍喉沼澤行者",

	-- Step 57: Hearth to Menethil
	["Hearth to Menethil"] = "用爐石回到米奈希爾港",
	["For the giant crocolisks of the north coast, on your next visit"] = "北海岸的巨型鱷魚，下次來時再打",

	-- Step 58: Ironforge
	-- {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan · {zone:1426} Dun Morogh · {area:1537} Ironforge
	["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "沿{zone:1437}的道路向東騎，向南穿過{area:836}進入{zone:1432}，再向西穿過隧道進入{zone:1426}，前往{area:1537}。",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}，在{object:32372}",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "只有在持有{zone:1439}的{item:5352}時：{npc:2786}，{object:32383}",

	-- Step 59: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "{zone:1455}的牧師",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406}和{npc:258785}在{object:32362}的{object:32386}。",

	-- Step 60: Cathedral of Light
	["Cathedral of Light"] = "光明大教堂",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "從{object:171524}搭乘{area:2257}前往{zone:1453}的{object:28027}，然後走到{object:2098}。",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}，在光明大教堂內",
	-- {npc:1444} Brother Kristoff · {object:2098} Cathedral Square
	["{npc:1444}, in the {object:2098}"] = "{npc:1444}，在{object:2098}",

	-- Step 61: Stormwind Keep
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, in the Royal Library"] = "{npc:1440}，在皇家圖書館",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "只有在{zone:1431}拾取了{quest:337}時",

	-- Step 62: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "回到光明大教堂：{npc:928}站在裡面。",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "給{area:271}的{npc:2228}：先留著",

	-- Step 63: Mage Quarter
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter
	["{object:2164} is in the {object:2101}."] = "{object:2164}在{object:2101}。",

	-- Step 64: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959}與{npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}，{object:2096}的乳酪店",

	-- Step 65: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "下一步：飛往{area:42}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "沿海岸向北前往{area:414}。{npc:3846}在海灘上紮營；怒尾納迦遍布海岸。",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009}帶著怒尾守衛在{area:414}的北端走動。",
}
