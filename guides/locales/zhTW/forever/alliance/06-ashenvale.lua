-- Chinese (traditional) (zhTW): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kerlonian Evershade
	-- {area:442} Auberdine · {area:448} Grove of the Ancients · {npc:11218} Kerlonian Evershade · {item:13536} Horn of Awakening · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Back north from the glaive (Druids: south along the road from {area:442}) to the {area:448}, where {npc:11218} sleeps beside Arbal. Take his quest, open his chest for the {item:13536}, use it to wake him and lead him south along the road to his bag at the southern edge of {zone:1439}; blow the horn again whenever he falls asleep. Then go on to {npc:11219} at {area:413}.\nCareful: Scripted ambushes of three mobs each attack along the road."] = "",
	-- {object:176634} Kerlonian's Chest
	["{object:176634}, beside him"] = "",
	-- {npc:11218} Kerlonian Evershade · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Escort {npc:11218} south along the road to his bag at the southern edge of {zone:1439}, then go on to {npc:11219} at {area:413}."] = "",

	-- Step 4: Bathran's Haunt: kill these as you meet them
	-- {area:411} Bathran's Haunt
	["{area:411}: kill these as you meet them"] = "",
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "在邁斯特拉崗哨北邊，植物束散落在{area:411}廢墟周圍。暗灘祭司佔據其南邊不遠的廢墟：任何一個都可能掉落{item:5366}。",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}，從植物束取得",

	-- Step 6: Astranaar
	-- {area:413} Maestra's Post · {npc:3845} Shindrell Swiftfire · {npc:4079} Sentinel Thenysil · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["The road from {area:413} comes in by the flight master: {npc:3845} and {npc:4079} stand there, {npc:3691} in the inn, {npc:3894} inside the building beyond it."] = "",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}，在旅店裡",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {area:442} Auberdine
	["{npc:3691}: {quest:990}, from {area:442}"] = "",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 7: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "",

	-- Step 8: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "在魚人南邊，{npc:3585}在{area:416}等著。",

	-- Step 9: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "淚珠在{area:415}東邊的小島上發光。",

	-- Step 11: Stonetalon Mountains
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {area:2160} Windshear Mine
	["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}, north of the {area:2160}."] = "",

	-- Step 12: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} at the east end of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "",
	["Below ground"] = "",
	-- {npc:4276} Piznik
	["Keep {npc:4276} alive while he mines, below ground"] = "",

	-- Step 13: Windshear Crag
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["{npc:4080} and {npc:4077} camp on the {area:1076}, south-west of the mine."] = "",

	-- Step 14: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle
	["His hut stands just north of {npc:4080} and {npc:4077}."] = "",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "",

	-- Step 16: Windshear Crag: kill these as you meet them
	-- {area:461} Windshear Crag
	["{area:461}: kill these as you meet them"] = "",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "風險投資公司正在砍伐{area:461}的森林。樵夫和砍樹工到處工作；操作員駕駛伐木機，其中一人帶著藍圖。",

	-- Step 17: Webwinder Path
	["Inside"] = "",

	-- Step 18: The Ruins of Stardust
	-- {area:1276} Talondeep Path · {area:421} Mystral Lake
	["Back north through the {area:1276}: west of {area:421}, the stardust bushes grow among the ruins."] = "",

	-- Step 19: Alonso
	-- {npc:210995} Alonso · {area:1276} Talondeep Path
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around {area:1276}: the map marks where to look"] = "",

	-- Step 20: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885}站在{area:421}東岸的{area:420}；{npc:210995}在湖的西岸紮營。污濁的水元素在兩者之間的湖中涉水。",
	["Underwater"] = "",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "擊殺元素取得5個完整的元素護腕，然後使用{item:5456}",

	-- Step 21: The Foulweald
	["The Foulweald"] = "汙林熊怪",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "汙林熊怪住在道路南邊、{area:415}東南方的樹林中。汙林衛兵和汙林巨熊怪守護巢穴。",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "沿道路向東前往{area:419}；{npc:3916}站在月井旁。",

	-- Step 23: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur furbolgs at the camp north of {area:415}. Clear his guards first, one at a time.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "",

	-- Step 24: Ilkrud Magthrull
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar · {area:412} Ruins of Ordil'Aran · {npc:3664} Ilkrud Magthrull
	["From {npc:3987}'s camp head south-west past {area:415} (its hand-ins wait for the way back) to the {area:412} south of the shrine: {npc:3664} and his voidwalkers hold them. Pull his guards first."] = "",

	-- Step 25: The Zoram Strand
	-- {area:414} Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "沿海岸向北前往{area:414}。{npc:3846}在海灘上紮營；怒尾納迦遍布海岸。",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}，在海岸上的廢墟裡",
	-- {item:5490} Wrathtail Head
	["{item:5490}: any Wrathtail naga on the strand"] = "",

	-- Step 27: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009}帶著怒尾守衛在{area:414}的北端走動。",

	-- Step 29: Maestra's Post
	-- {npc:3663} Delgren the Purifier · {zone:1440} Ashenvale
	["{npc:3663}: its circles are for your next {zone:1440} visit, at about 28"] = "",

	-- Step 30: Astranaar
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3845} Shindrell Swiftfire · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["Follow the road south-east from {area:413} back to {area:415}: {npc:3845} by the flight master, {npc:3691} in the inn, {npc:3894} inside."] = "",

	-- Step 31: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 32: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "搭船前往{area:150}",

	-- Step 33: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "前往{area:150}",

	-- Step 34: Menethil Harbor
	-- {npc:1242} Karl Boran · {npc:2094} James Halloran · {npc:2086} Valstag Ironjaw · {npc:1239} First Mate Fitzsimmons · {npc:1480} Caitlin Grassman · {npc:2111} Sida · {npc:2096} Tarrel Rockweaver
	["Off the boat, walk up the pier: {npc:1242} on the pier, {npc:2094} by the docks to the north, {npc:2086} in the keep, the inn ({npc:1239}) east of it with {npc:1480} and {npc:2111} beside it, {npc:2096} by the north gate on the way out east."] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}，在旅店北邊的碼頭上",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}，在旅店裡",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}，在北門旁",

	-- Step 35: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "木材和鐵堆放在城堡周圍和港口的城牆邊。",

	-- Step 36: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "沿海岸向北離開米奈希爾港。藍腮魚人遍布沼澤；{npc:1259}帶著一群魚人在中間走動。",

	-- Step 37: Young crocolisks
	["Young crocolisks"] = "小鱷魚",
	-- {zone:1437} Wetlands
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["From the marsh head east across the {zone:1437}. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "",

	-- Step 38: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "挖掘場在道路南邊的山丘上。",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "",

	-- Step 39: The raptor hills
	["The raptor hills"] = "迅猛龍丘陵",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "",

	-- Step 40: Ormer Ironbraid
	-- {npc:1078} Ormer Ironbraid · {zone:1437} Wetlands
	["{npc:1078}: the bigger raptors in the valley west of the dig are for your next {zone:1437} visit, at about 27"] = "",

	-- Step 41: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093}在路邊紮營；{npc:1244}站在更東邊的河邊。",

	-- Step 42: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "洞穴捕獵者和吸血捕獵者遍布挖掘場東南方的洞穴{area:1021}。",

	-- Step 43: The Mosshide gnolls
	["The Mosshide gnolls"] = "蘚皮豺狼人",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "蘚皮豺狼人和混血蘚皮豺狼人佔據{area:1025}東南方的丘陵。",

	-- Step 44: Rethiel the Greenwarden
	-- {area:309} Ironbeard's Tomb · {npc:1244} Rethiel the Greenwarden · {zone:1437} Wetlands
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Its flint comes from the Mosshide Fenrunners on the way to {area:309}; {npc:1244} takes it on your next {zone:1437} visit"] = "",

	-- Step 45: Ironbeard's Tomb
	-- {npc:1244} Rethiel the Greenwarden · {area:309} Ironbeard's Tomb · {area:205} Dun Modr · {npc:2111} Sida
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner · Monstrous Oozes = {npc:1033} Monstrous Ooze
	["North-west from {npc:1244}: Mosshide Fenrunners and Mistweavers roam the riverbanks on the way, and almost every one drops flint. Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag."] = "",
	-- {item:2611} Crude Flint
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["{item:2611}: Mosshide Fenrunners and Mistweavers"] = "",

	-- Step 46: Menethil
	["Menethil"] = "",
	-- {npc:2096} Tarrel Rockweaver · {npc:2111} Sida · {npc:1480} Caitlin Grassman · {npc:2086} Valstag Ironjaw · {npc:2094} James Halloran · {npc:1242} Karl Boran
	["Back west along the road into Menethil: {npc:2096} by the road in, {npc:2111} and {npc:1480} at the inn, {npc:2086} in the keep, {npc:2094} on the west side by the docks, {npc:1242} on the pier north of the inn."] = "",
	-- {npc:1480} Caitlin Grassman
	["{npc:1480}, inside"] = "",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, in the keep"] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier"] = "",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn: you have both flight paths since your first trip east."] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 48: Ironforge
	-- {object:32372} Great Forge · {npc:4081} Lomac Gearstrip · {object:171524} Tinker Town · {area:2257} Deeprun Tram
	["The gryphons land in the {object:32372}. {npc:4081} stands in {object:171524}, east of it, by the {area:2257}."] = "",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "只有在持有{zone:1439}的{item:5352}時：{npc:2786}，{object:32383}",

	-- Step 49: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 50: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 51: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 52: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 53: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston
	["The tram comes in at the {object:28027}; walk west to the {object:2098}: {npc:1646} stands at its east side. (The route hands his letter in at the end of 03-loch-modan; this is for a character still carrying it.)"] = "",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}：來自{area:442}的桑迪斯的信",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, back in {area:442} (06-wetlands)"] = "",

	-- Step 54: Cathedral Square
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:376} High Priestess Laurena
	["The tram comes in at the {object:28027}; walk west to the {object:2098}. {npc:376} is in the Cathedral of Light."] = "",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}：由{zone:1455}的{npc:11406}接收，稍後",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}：由{zone:1455}的{npc:258785}接收，稍後",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}：由{zone:1457}的{npc:11401}接收，稍後",

	-- Step 55: Master Mathias Shaw
	-- {object:2100} Old Town
	["Mathias Shaw is at SI:7 in {object:2100}, south of the Keep."] = "",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}'s second loop"] = "",

	-- Step 56: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{object:2164} is in the {object:2101}. Warlocks: {npc:6122} is in its cellar."] = "",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}：由{zone:1413}的{npc:6244}接收，稍後",

	-- Step 57: Trade District
	-- {zone:1453} Stormwind · {zone:1431} Duskwood
	["Next: training in {zone:1453}, then the road east through Elwynn and south to {zone:1431}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "回到光明大教堂：{npc:928}站在裡面。",
	-- ["Black Oozes"] = "黑色軟泥怪",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "黑色軟泥怪在{area:1025}道路北邊、{npc:2093}營地西邊的沼澤中爬行。任何軟泥怪都可能帶著{npc:2111}的袋子。",
	-- ["Cathedral of Light"] = "光明大教堂",
	-- ["Dragonmaw camp"] = "龍喉營地",
	-- ["Escort Kerlonian to {area:413} in {zone:1440}."] = "護送克羅尼亞·恒影到{zone:1440}的{area:413}。",
	-- ["Fen Creepers"] = "沼澤爬行者",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "沼澤爬行者躲在{area:1025}西北方的沼澤水池中。",
	-- ["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "沿道路向東。小濕地鱷魚潛伏在挖掘場北邊的水池中。",
	-- ["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "沿道路向北前往{area:881}山腳下的{area:205}。{npc:1071}站在矮人營地裡。",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "沿道路向東南前往湖中島上的{area:415}。",
	-- ["For Bolvar Fordragon in {object:2117}: keep it"] = "給{object:2117}的伯瓦爾·弗塔根公爵：先留著",
	-- ["For the giant crocolisks of the north coast, on your next visit"] = "北海岸的巨型鱷魚，下次來時再打",
	-- ["For {npc:2228} in {area:271}: keep it"] = "給{area:271}的{npc:2228}：先留著",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "從{area:17203}搭船到{area:442}；{npc:3649}站在村子北端。然後沿道路向南騎過{zone:1439}。",
	-- ["Hearth to Menethil"] = "用爐石回到米奈希爾港",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "爐石在冷卻中？向北騎回去穿過{area:1276}。",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "克羅尼亞·恒影睡在{zone:1439}南部的{area:448}。使用{item:13536}叫醒他，沿道路向南帶他進入{zone:1440}，到{area:413}找{npc:11219}；每當他睡著就再吹一次號角。",
	-- ["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "蘚皮沼澤行者和蘚皮織霧者在{npc:1244}西邊和南邊不遠的河岸遊蕩；幾乎每一隻都會掉落燧石。",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "雜斑迅猛龍和雜斑尖嘯龍在挖掘場西邊的丘陵遊蕩。",
	-- ["Next: fly to {area:42}."] = "下一步：飛往{area:42}。",
	-- ["Only if you looted {quest:337} in {zone:1431}"] = "只有在{zone:1431}拾取了{quest:337}時",
	-- ["Raptor valley"] = "迅猛龍山谷",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "沿{zone:1437}的道路向東騎，向南穿過{area:836}進入{zone:1432}，再向西穿過隧道進入{zone:1426}，前往{area:1537}。",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "向南騎過{area:421}進入{area:1276}隧道；出口在石爪山脈的{area:461}。{npc:4080}和{npc:4077}在峭壁西南方的{area:1076}紮營。",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "向西騎到{area:441}的岸邊。泰洛尼斯的屍體躺在鹽沫魚人之間；任何魚人都可能掉落{item:5463}。",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "從{area:17203}搭船到{area:442}，飛往{area:702}；{npc:11401}在Temple of the Moon。然後飛回{area:442}。",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "從{area:17203}搭船到{area:442}。把兩半墜飾合成{item:15885}，施放{spell:18960}：{npc:11802}在{area:2361}。然後飛往{area:702}（途經{area:442}）。",
	-- ["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "搭傳送門上到{area:1658}，然後飛回{area:442}。",
	-- ["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "從{object:171524}搭乘{area:2257}前往{zone:1453}的{object:28027}，然後走到{object:2098}。",
	-- ["The Bluegill hovels"] = "藍腮魚人小屋",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "龍喉營地在道路南邊、{area:1025}西邊不遠處：有龍喉襲擊者、龍喉沼澤行者和龍喉白骨守衛。{npc:2092}在{zone:1426}的任務需要28級。",
	-- ["The bigger raptors hunt in the valley just west of the dig."] = "體型更大的迅猛龍在挖掘場西邊不遠的山谷中狩獵。",
	-- ["The excavation site sits on the hill south of the road."] = "挖掘場在道路南邊的山丘上。",
	-- ["The raptor hills"] = "迅猛龍丘陵",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "魚人小屋中的三個容器，由南到北：{object:261}，然後是{object:142151}，最後是北端的{object:259}。",
	-- ["Venture Co. loggers"] = "風險投資公司樵夫",
	-- ["West of Mystral Lake, the stardust bushes grow among the ruins."] = "在密斯特拉湖西邊，星塵灌木生長在廢墟之間。",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "在{zone:1437}的龍喉營地刷龍喉襲擊者和龍喉沼澤行者",
	-- ["{item:15885}: join the two halves"] = "{item:15885}：合成兩半",
	-- ["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406}和{npc:258785}在{object:32362}的{object:32386}。",
	-- ["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}：給城堡裡的{npc:2104}",
	-- ["{npc:1440}, in the Royal Library"] = "{npc:1440}，在皇家圖書館",
	-- ["{npc:1444}, in the {object:2098}"] = "{npc:1444}，在{object:2098}",
	-- ["{npc:1573}, in the {object:32372}"] = "{npc:1573}，在{object:32372}",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}：來自{area:442}的桑迪斯的信",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}，在城堡旁",
	-- ["{npc:2094}, by the north gate"] = "{npc:2094}，在北門旁",
	-- ["{npc:2097}, by the north gate"] = "{npc:2097}，在北門旁",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104}站在{area:2103}，離{npc:1242}不遠。",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649}：巴洛斯·艾力克斯頓的回信",
	-- ["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664}和他的虛無行者佔據神殿南邊的{area:412}。先拉他的守衛。",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987}（25級）率領{area:415}北邊營地的薊皮熊怪。先一個一個清掉他的守衛。",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}，在他們北邊的小屋裡",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276}在峭壁東端的{area:2160}採礦。和他交談，在他採礦時擊退風險投資公司的襲擊者。",
	-- ["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}，{object:2096}的乳酪店",
	-- ["{npc:4959} and {npc:482}"] = "{npc:4959}與{npc:482}",
	-- ["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}，在光明大教堂內",
	-- ["{object:2164} is in the {object:2101}."] = "{object:2164}在{object:2101}。",
	-- ["{zone:1455} priests"] = "{zone:1455}的牧師",
}
