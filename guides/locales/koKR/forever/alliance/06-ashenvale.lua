-- Korean (koKR): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
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
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "마에스트라 주둔지 북쪽, {area:411} 폐허 주변에 식물 꾸러미가 놓여 있습니다. 암흑이교도는 그 바로 남쪽 폐허를 차지하고 있으며, 누구든 {item:5366}을(를) 떨어뜨릴 수 있습니다.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, 식물 꾸러미에서",

	-- Step 6: Astranaar
	-- {area:413} Maestra's Post · {npc:3845} Shindrell Swiftfire · {npc:4079} Sentinel Thenysil · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["The road from {area:413} comes in by the flight master: {npc:3845} and {npc:4079} stand there, {npc:3691} in the inn, {npc:3894} inside the building beyond it."] = "",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, 여관 안",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {area:442} Auberdine
	["{npc:3691}: {quest:990}, from {area:442}"] = "",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 7: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "",

	-- Step 8: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "멀록들 남쪽, {area:416}에서 {npc:3585}이(가) 기다립니다.",

	-- Step 9: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "눈물은 {area:415} 동쪽의 작은 섬에서 빛납니다.",

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
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "투자개발회사가 {area:461}의 숲을 베어내고 있습니다. 나무꾼과 벌채꾼이 곳곳에서 일하고, 운전수가 벌목기를 몰며 그중 하나가 설계도를 지니고 있습니다.",

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
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885}은(는) {area:421} 동쪽 기슭의 {area:420}에 서 있고, {npc:210995}은(는) 서쪽 기슭에 진을 치고 있습니다. 타락한 물의 정령이 그 사이 호수를 걸어다닙니다.",
	["Underwater"] = "",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "정령을 처치해 {item:12220} 5개를 모은 뒤 {item:5456}을(를) 사용하세요",

	-- Step 21: The Foulweald
	["The Foulweald"] = "썩은나무 숲",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "썩은나무일족 펄볼그는 길 남쪽, {area:415} 남동쪽 숲에 삽니다. 썩은나무일족 보초와 썩은나무일족 펄볼그가 굴을 지킵니다.",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "길을 따라 동쪽으로 {area:419}까지 가세요. {npc:3916}은(는) 달샘 옆에 서 있습니다.",

	-- Step 23: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur furbolgs at the camp north of {area:415}. Clear his guards first, one at a time.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "",

	-- Step 24: Ilkrud Magthrull
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar · {area:412} Ruins of Ordil'Aran · {npc:3664} Ilkrud Magthrull
	["From {npc:3987}'s camp head south-west past {area:415} (its hand-ins wait for the way back) to the {area:412} south of the shrine: {npc:3664} and his voidwalkers hold them. Pull his guards first."] = "",

	-- Step 25: The Zoram Strand
	-- {area:414} Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "해안을 따라 북쪽으로 {area:414}까지 가세요. {npc:3846}은(는) 해변에 진을 치고 있고, 해안에는 성난지느러미일족 나가가 가득합니다.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, 해안의 폐허 안",
	-- {item:5490} Wrathtail Head
	["{item:5490}: any Wrathtail naga on the strand"] = "",

	-- Step 27: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009}은(는) 성난지느러미일족 경비병과 함께 {area:414}의 북쪽 끝을 돌아다닙니다.",

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
	["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",

	-- Step 33: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "{area:150}(으)로",

	-- Step 34: Menethil Harbor
	-- {npc:1242} Karl Boran · {npc:2094} James Halloran · {npc:2086} Valstag Ironjaw · {npc:1239} First Mate Fitzsimmons · {npc:1480} Caitlin Grassman · {npc:2111} Sida · {npc:2096} Tarrel Rockweaver
	["Off the boat, walk up the pier: {npc:1242} on the pier, {npc:2094} by the docks to the north, {npc:2086} in the keep, the inn ({npc:1239}) east of it with {npc:1480} and {npc:2111} beside it, {npc:2096} by the north gate on the way out east."] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, 여관 북쪽 부두 위",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, 여관 안",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, 북문 옆",

	-- Step 35: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "목재와 철 더미가 성채 주변과 항구 성벽을 따라 놓여 있습니다.",

	-- Step 36: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "해안을 따라 북쪽으로 메네실 항구를 나가세요. 푸른아가미멀록이 늪에 가득하고, {npc:1259}은(는) 그 한가운데에서 무리와 함께 돌아다닙니다.",

	-- Step 37: Young crocolisks
	["Young crocolisks"] = "새끼 악어",
	-- {zone:1437} Wetlands
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["From the marsh head east across the {zone:1437}. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "",

	-- Step 38: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "발굴 현장은 길 남쪽 언덕 위에 있습니다.",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "",

	-- Step 39: The raptor hills
	["The raptor hills"] = "랩터 언덕",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "",

	-- Step 40: Ormer Ironbraid
	-- {npc:1078} Ormer Ironbraid · {zone:1437} Wetlands
	["{npc:1078}: the bigger raptors in the valley west of the dig are for your next {zone:1437} visit, at about 27"] = "",

	-- Step 41: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093}은(는) 길가에 진을 치고 있고, {npc:1244}은(는) 더 동쪽 강가에 서 있습니다.",

	-- Step 42: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "긴다리동굴거미와 긴다리흡혈거미가 발굴 현장 남동쪽 동굴인 {area:1021}에 가득합니다.",

	-- Step 43: The Mosshide gnolls
	["The Mosshide gnolls"] = "이끼가죽 놀",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "이끼가죽 놀과 이끼가죽일족 싸움꾼이 {area:1025} 남동쪽 언덕을 차지하고 있습니다.",

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
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:4081} Lomac Gearstrip · {object:171524} Tinker Town · {area:2257} Deeprun Tram
	["The gryphons land in the {object:32372}. {npc:4081} stands in {object:171524}, east of it, by the {area:2257}."] = "",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "{zone:1439}에서 얻은 {item:5352}이(가) 있을 때만: {npc:2786}, {object:32383}",

	-- Step 49: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 50: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 51: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 52: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 53: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston
	["The tram comes in at the {object:28027}; walk west to the {object:2098}: {npc:1646} stands at its east side. (The route hands his letter in at the end of 03-loch-modan; this is for a character still carrying it.)"] = "",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: {area:442}에서 온 툰드리스의 편지",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, back in {area:442} (06-wetlands)"] = "",

	-- Step 54: Cathedral Square
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:376} High Priestess Laurena
	["The tram comes in at the {object:28027}; walk west to the {object:2098}. {npc:376} is in the Cathedral of Light."] = "",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {zone:1455}의 {npc:11406}에게 제출합니다. 나중에",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {zone:1455}의 {npc:258785}에게 제출합니다. 나중에",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {zone:1457}의 {npc:11401}에게 제출합니다. 나중에",

	-- Step 55: Master Mathias Shaw
	-- {object:2100} Old Town
	["Mathias Shaw is at SI:7 in {object:2100}, south of the Keep."] = "",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}'s second loop"] = "",

	-- Step 56: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{object:2164} is in the {object:2101}. Warlocks: {npc:6122} is in its cellar."] = "",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {zone:1413}의 {npc:6244}에게 제출합니다. 나중에",

	-- Step 57: Trade District
	-- {zone:1453} Stormwind · {zone:1431} Duskwood
	["Next: training in {zone:1453}, then the road east through Elwynn and south to {zone:1431}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "빛의 대성당으로 돌아가세요. {npc:928}이(가) 안에 서 있습니다.",
	-- ["Black Oozes"] = "검은 수액괴물",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "검은 수액괴물은 {area:1025} 길 북쪽, {npc:2093}의 야영지 서쪽 늪을 기어다닙니다. 어느 수액괴물이든 {npc:2111}의 가방을 지니고 있을 수 있습니다.",
	-- ["Cathedral of Light"] = "빛의 대성당",
	-- ["Dragonmaw camp"] = "용아귀부족 야영지",
	-- ["Escort Kerlonian to {area:413} in {zone:1440}."] = "케를로니안을 {zone:1440}의 {area:413}까지 호위하세요.",
	-- ["Fen Creepers"] = "수렁이끼괴물",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "수렁이끼괴물은 {area:1025} 북서쪽 늪 웅덩이에 숨어 있습니다.",
	-- ["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "길을 따라 동쪽으로 가세요. {npc:1417}은(는) 발굴 현장 북쪽 웅덩이에 숨어 있습니다.",
	-- ["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "길을 따라 북쪽으로 {area:881} 기슭의 {area:205}까지 가세요. {npc:1071}은(는) 드워프 야영지에 서 있습니다.",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "길을 따라 남동쪽으로 호수 섬에 있는 {area:415}까지 가세요.",
	-- ["For Bolvar Fordragon in {object:2117}: keep it"] = "{object:2117}의 볼바르 폴드라곤에게: 보관하세요",
	-- ["For the giant crocolisks of the north coast, on your next visit"] = "북쪽 해안의 거대한 습지악어는 다음 방문 때",
	-- ["For {npc:2228} in {area:271}: keep it"] = "{area:271}의 {npc:2228}에게: 보관하세요",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "{area:17203}에서 배를 타고 {area:442}(으)로 가세요. {npc:3649}은(는) 마을 북쪽 끝에 서 있습니다. 그런 다음 길을 따라 남쪽으로 {zone:1439}을(를) 지나가세요.",
	-- ["Hearth to Menethil"] = "메네실로 귀환",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "귀환석이 재사용 대기 중인가요? {area:1276}을(를) 지나 북쪽으로 돌아가세요.",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "케를로니안은 {zone:1439} 남부의 {area:448}에서 잠들어 있습니다. {item:13536}을(를) 사용해 그를 깨우고, 길을 따라 남쪽으로 {zone:1440}에 들어가 {area:413}의 {npc:11219}에게 데려가세요. 그가 잠들 때마다 뿔피리를 다시 부세요.",
	-- ["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "이끼가죽일족 길잡이와 안개마술사가 {npc:1244} 바로 서쪽과 남쪽 강둑을 돌아다닙니다. 거의 모두가 부싯돌을 떨어뜨립니다.",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "줄무늬랩터와 긴송곳니 줄무늬랩터가 발굴 현장 서쪽 언덕을 돌아다닙니다.",
	-- ["Next: fly to {area:42}."] = "다음: {area:42}(으)로 날아가세요.",
	-- ["Only if you looted {quest:337} in {zone:1431}"] = "{zone:1431}에서 {quest:337}을(를) 획득한 경우에만",
	-- ["Raptor valley"] = "랩터 계곡",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "{zone:1437} 길을 따라 동쪽으로 가서 남쪽으로 {area:836}을(를) 지나 {zone:1432}에 들어간 뒤, 서쪽 굴을 지나 {zone:1426}의 {area:1537}(으)로 가세요.",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "{area:421}을(를) 지나 남쪽으로 {area:1276} 굴에 들어가세요. 굴은 돌발톱 산맥의 {area:461}(으)로 이어집니다. {npc:4080}와(과) {npc:4077}은(는) 바위산 남서쪽 {area:1076}에 진을 치고 있습니다.",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "서쪽으로 {area:441} 기슭까지 가세요. 테로니스는 소금거품멀록들 사이에 쓰러져 있습니다. 어느 멀록이든 {item:5463}을(를) 떨어뜨릴 수 있습니다.",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "{area:17203}에서 배를 타고 {area:442}(으)로 간 뒤 {area:702}(으)로 날아가세요. {npc:11401}은(는) 달의 신전에 있습니다. 그런 다음 {area:442}(으)로 날아 돌아오세요.",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "{area:17203}에서 배를 타고 {area:442}(으)로 가세요. 반쪽 펜던트 두 개를 합쳐 {item:15885}을(를) 만들고 {spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. 그런 다음 ({area:442}을(를) 거쳐) {area:702}(으)로 날아가세요.",
	-- ["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "차원문을 타고 {area:1658}(으)로 올라간 뒤, {area:442}(으)로 날아 돌아오세요.",
	-- ["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "{object:171524}에서 {area:2257}을(를) 타고 {zone:1453}의 {object:28027}(으)로 간 뒤, {object:2098}까지 걸어가세요.",
	-- ["The Bluegill hovels"] = "푸른아가미 오두막",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "용아귀부족 야영지는 {area:1025} 바로 서쪽, 길 남쪽에 있습니다. 약탈자, 늪길잡이, 해골감시자가 있습니다. {zone:1426}에서 {npc:2092}의 퀘스트는 28레벨이 필요합니다.",
	-- ["The bigger raptors hunt in the valley just west of the dig."] = "더 큰 랩터는 발굴지 바로 서쪽 계곡에서 사냥합니다.",
	-- ["The excavation site sits on the hill south of the road."] = "발굴 현장은 길 남쪽 언덕 위에 있습니다.",
	-- ["The raptor hills"] = "랩터 언덕",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "멀록 오두막의 상자 세 개, 남쪽에서 북쪽 순서: {object:261}, 그다음 {object:142151}, 그다음 북쪽 끝의 {object:259}.",
	-- ["Venture Co. loggers"] = "투자개발회사 나무꾼",
	-- ["West of Mystral Lake, the stardust bushes grow among the ruins."] = "미스트랄 호수 서쪽, 폐허 사이에 별가루 덤불이 자랍니다.",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "{zone:1437}의 용아귀부족 야영지에서 용아귀부족 약탈자와 늪길잡이를 사냥하세요",
	-- ["{item:15885}: join the two halves"] = "{item:15885}: 반쪽 두 개를 합치기",
	-- ["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406}와(과) {npc:258785}은(는) {object:32362}의 {object:32386}에 있습니다.",
	-- ["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: 성채 안의 {npc:2104}에게",
	-- ["{npc:1440}, in the Royal Library"] = "{npc:1440}, 왕실 도서관 안",
	-- ["{npc:1444}, in the {object:2098}"] = "{npc:1444}, {object:2098}",
	-- ["{npc:1573}, in the {object:32372}"] = "{npc:1573}, {object:32372} 안",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: {area:442}에서 온 툰드리스의 편지",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}, 성채 옆",
	-- ["{npc:2094}, by the north gate"] = "{npc:2094}, 북문 옆",
	-- ["{npc:2097}, by the north gate"] = "{npc:2097}, 북문 옆",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104}은(는) {npc:1242}에게서 조금 걸어가면 나오는 {area:2103}에 서 있습니다.",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649}: 알렉스톤의 답장",
	-- ["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664}와(과) 그의 공허방랑자들은 성소 남쪽의 {area:412}을(를) 차지하고 있습니다. 경비병을 먼저 끌어오세요.",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987}(25레벨)이 {area:415} 북쪽 야영지에서 엉겅퀴일족 놀을 이끕니다. 경비병을 하나씩 먼저 처치하세요.",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}, 그들 북쪽의 오두막 안",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276}은(는) 바위산 동쪽 끝의 {area:2160}에서 채광합니다. 그에게 말을 걸고, 그가 채광하는 동안 투자개발회사 습격자를 막아내세요.",
	-- ["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, {object:2096}의 치즈 가게",
	-- ["{npc:4959} and {npc:482}"] = "{npc:4959}와(과) {npc:482}",
	-- ["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, 빛의 대성당 안",
	-- ["{object:2164} is in the {object:2101}."] = "{object:2164}은(는) {object:2101}에 있습니다.",
	-- ["{zone:1455} priests"] = "{zone:1455} 사제",
}
