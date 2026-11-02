-- Russian (ruRU): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 2: Aquatic Form
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {item:15885} Pendant of the Sea Lion · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885}: соедините две половинки",

	-- Step 4: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine
	["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Поднимитесь через портал сюда: {area:1658}, затем летите обратно сюда: {area:442}.",

	-- Step 6: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 7: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "",

	-- Step 11: Boat to Auberdine
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then head south along the road through {zone:1439}."] = "",
	-- {npc:3649} Thundris Windweaver · {zone:1453} Stormwind
	["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "",

	-- Step 12: Kerlonian Evershade
	-- {area:448} Grove of the Ancients · {zone:1439} Darkshore · {item:13536} Horn of Awakening · {area:331} Ashenvale · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {area:331} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep.\nCareful: Scripted ambushes of three mobs each attack along the road: furbolgs on the {zone:1439} stretch and undead nearer {area:413}."] = "",
	-- {object:176634} Kerlonian's Chest
	["{object:176634}, beside him"] = "",
	-- {area:413} Maestra's Post · {area:331} Ashenvale
	["Escort Kerlonian to {area:413} in {area:331}."] = "",

	-- Step 15: Bathran's Haunt: kill these as you meet them
	-- {area:411} Bathran's Haunt
	["{area:411}: kill these as you meet them"] = "",
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "К северу от Заставы Мейстры вокруг руин ({area:411}) лежат пучки трав. Сектанты из клана Темной Нити удерживают руины чуть южнее: с любого из них может выпасть {item:5366}.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, из пучков трав",

	-- Step 17: Astranaar
	-- {npc:3970} Llana · {npc:1480} Caitlin Grassman
	["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide; inside"] = "",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, в таверне",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 18: Ilkrud Magthrull
	-- {npc:3664} Ilkrud Magthrull · {area:412} Ruins of Ordil'Aran
	["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} и его демоны Бездны удерживают {area:412} к югу от святилища. Сначала выманите его стражей.",

	-- Step 19: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "",
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["The two stand together at the western end of the road.\nSouth of the murlocs, {npc:3585} waits at the {area:416}."] = "",

	-- Step 20: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "",

	-- Step 21: The Zoram Strand
	-- {area:414} The Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Идите вдоль побережья на север к {area:414}. {npc:3846} стоит лагерем на пляже; берег кишит нагами из клана Зловещего Хвоста.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, в руинах на берегу",

	-- Step 23: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} The Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} ходит по северной оконечности {area:414} со стражами из клана Зловещего Хвоста.",

	-- Step 26: Hearth to Astranaar
	-- {area:415} Astranaar
	["Hearth to {area:415}"] = "",

	-- Step 28: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur furbolgs at the camp north of {area:415}. Clear his guards first, one at a time.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "",

	-- Step 29: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn · {area:415} Astranaar
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell.\nThe moonwell lies in the hills north-east of {area:415}."] = "",

	-- Step 30: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "Слезы светятся на маленьком островке к востоку от места {area:415}.",

	-- Step 32: The Foulweald
	["The Foulweald"] = "Гиблая Чаща",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Фурболги из племени Гиблой Чащи живут в лесу к югу от дороги, к юго-востоку (ориентир: {area:415}). Логово охраняют дозорный и ведмеди.",

	-- Step 33: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} стоит здесь: {area:420}, на восточном берегу места {area:421}; {npc:210995} стоит лагерем на западном берегу. Между ними в озере бродят злобные элементали воды.",
	["Underwater"] = "",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Убивайте элементалей ради 5 неповрежденных браслетов элементаля, затем используйте {item:5456}",

	-- Step 34: Alonso
	-- {npc:210995} Alonso · {area:1276} The Talondeep Path
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around {area:1276}: the map marks where to look"] = "",

	-- Step 35: The Ruins of Stardust
	["West of Mystral Lake, the stardust bushes grow among the ruins."] = "К западу от озера Мистраль среди руин растут кусты, покрытые звездной пылью.",

	-- Step 38: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "",
	["Below ground"] = "",

	-- Step 39: Windshear Crag
	-- {area:421} Mystral Lake · {area:1276} The Talondeep Path · {area:461} Windshear Crag · {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "",

	-- Step 40: Webwinder Path
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "",

	-- Step 41: Windshear Crag
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, in the hut north of them; inside"] = "",

	-- Step 42: Windshear Crag: kill these as you meet them
	-- {area:461} Windshear Crag
	["{area:461}: kill these as you meet them"] = "",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "Торговая компания вырубает лес ({area:461}). Лесорубы и лесозаготовители работают повсюду; операторы управляют крошшерами, у одного из них чертежи.",

	-- Step 43: Webwinder Path
	["Inside"] = "",

	-- Step 45: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 46: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Корабль: {area:150}",

	-- Step 47: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "В место {area:150}",

	-- Step 48: Menethil Harbor
	-- {npc:5082} Vincent Hyal · {npc:1480} Caitlin Grassman · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1242} Karl Boran
	["{npc:5082}, Mikhail and Tapoke Jahn are all at Menethil's inn; Tapoke fights you when you talk to Mikhail, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn.\n{npc:2104} stands in {area:2103}, a short walk from {npc:1242}.\n{npc:2104} stands in {area:2103}."] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, на пирсе к северу от таверны",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: для NPC {npc:2104} в крепости",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, в таверне",
	-- {npc:1480} Caitlin Grassman
	["{npc:1480}, inside"] = "",
	-- {npc:2097} Harlo Barnaby
	["{npc:2097}, by the north gate"] = "{npc:2097}, у северных ворот",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Для Верховного лорда Болвара Фордрагона ({object:2117}): сохраните",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep"] = "",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, у северных ворот",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the north gate"] = "{npc:2094}, у северных ворот",

	-- Step 49: Sida's Bag on the way
	-- {item:3349} Sida's Bag
	["{item:3349} on the way"] = "",

	-- Step 50: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Груды бревен и железа лежат вокруг крепости и вдоль стен гавани.",

	-- Step 51: James Halloran
	-- {npc:2094} James Halloran
	["{npc:2094} stands by the north gate."] = "",

	-- Step 52: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Идите вдоль побережья на север из Гавани Менетилов. Болото полно мурлоков из племени Синежабрых; {npc:1259} бродит со стаей посреди него.",

	-- Step 54: Young crocolisks
	["Young crocolisks"] = "Молодые кроколиски",
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Идите по дороге на восток. Молодые болотные кроколиски прячутся в прудах к северу от раскопок.",

	-- Step 55: The Bluegill hovels
	["The Bluegill hovels"] = "Хижины Синежабрых",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Три контейнера в хижинах мурлоков, с юга на север: {object:261}, затем {object:142151}, затем {object:259} в северной части.",

	-- Step 56: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "",
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground"] = "",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "",

	-- Step 57: The raptor hills
	["The raptor hills"] = "",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "",

	-- Step 59: Raptor valley
	["Raptor valley"] = "Долина ящеров",
	["The bigger raptors hunt in the valley just west of the dig."] = "Крупные ящеры охотятся в долине чуть западнее раскопок.",

	-- Step 61: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} стоит лагерем у дороги; {npc:1244} стоит восточнее, у реки.",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "",

	-- Step 62: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Пещерные ловцы и ловцы-кровопийцы заполняют {area:1021}, пещеру к юго-востоку от раскопок.",

	-- Step 63: The Mosshide gnolls
	["The Mosshide gnolls"] = "Гноллы из стаи Мохошкуров",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Гноллы и полукровки из стаи Мохошкуров удерживают холмы к юго-востоку от места {area:1025}.",

	-- Step 65: Wetlands: kill these as you meet them
	-- {zone:1437} Wetlands
	["{zone:1437}: kill these as you meet them"] = "",
	-- {area:309} Ironbeard's Tomb · {area:205} Dun Modr · {npc:2111} Sida · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Monstrous Oozes = {npc:1033} Monstrous Ooze · Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag.\nMosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "",

	-- Step 67: The Green Belt: kill these as you meet them
	-- {area:1025} The Green Belt
	["{area:1025}: kill these as you meet them"] = "",
	-- {area:1025} The Green Belt · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw · Fen Creepers = {npc:1040} Fen Creeper
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised.\nFen Creepers hide in the marsh pools north-west of the {area:1025}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "",

	-- Step 69: Hearth to Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["Hearth to {area:2104}"] = "",

	-- Step 71: Menethil
	["Menethil"] = "",
	["For the giant crocolisks of the north coast, on your next visit"] = "Для огромных болотных кроколисков северного побережья, в следующий раз",

	-- Step 72: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "",

	-- Step 73: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "",

	-- Step 74: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "",

	-- Step 76: Ironforge
	-- {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan · {zone:1426} Dun Morogh · {area:1537} Ironforge
	["Head east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, {object:32372}",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Только если у вас есть {item:5352} из зоны {zone:1439}: {npc:2786}, {object:32383}",

	-- Step 77: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 78: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 79: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 80: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Жрецы: {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} и {npc:258785} находятся здесь: {object:32386} ({object:32362}).",

	-- Step 81: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 82: Cathedral of Light
	["Cathedral of Light"] = "Собор Света",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Сядьте на поезд ({area:2257}) в месте {object:171524} до места {object:28027} ({zone:1453}), затем идите сюда: {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, в Соборе Света",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Для NPC {npc:2228} ({area:271}): сохраните",

	-- Step 83: Cathedral of Light
	-- {npc:1444} Brother Kristoff · {object:2098} Cathedral Square
	["{npc:1444}, in the {object:2098}"] = "{npc:1444}, {object:2098}",

	-- Step 84: Stormwind Keep
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, in the Royal Library"] = "{npc:1440}, в королевской библиотеке",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Только если вы добыли {quest:337} в зоне {zone:1431}",

	-- Step 86: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter
	["{object:2164} is in the {object:2101}."] = "{object:2164} находится здесь: {object:2101}.",

	-- Step 87: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} и {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, сырная лавка ({object:2096})",

	-- Step 88: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Далее: летите сюда: {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "Вернитесь в Собор Света: {npc:928} стоит внутри.",
	-- ["Black Oozes"] = "Черные слизнюки",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Черные слизнюки ползают по болоту к северу от дороги ({area:1025}), к западу от лагеря {npc:2093}. В любом слизнюке может оказаться сумка NPC {npc:2111}.",
	-- ["Dragonmaw camp"] = "Лагерь Драконьей Пасти",
	-- ["Escort Kerlonian to {area:413} in {zone:1440}."] = "Проводите Керлониана сюда: {area:413} ({zone:1440}).",
	-- ["Fen Creepers"] = "Трясинные ползуны",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Трясинные ползуны прячутся в болотных прудах к северо-западу от места {area:1025}.",
	-- ["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Идите вдоль побережья на север сюда: {area:414}. {npc:3846} стоит лагерем на пляже; берег кишит нагами из клана Зловещего Хвоста.",
	-- ["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Идите по дороге на восток сюда: {area:419}; {npc:3916} стоит у лунного колодца.",
	-- ["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Идите по дороге на север сюда: {area:205}, у подножия моста ({area:881}). {npc:1071} стоит в лагере дворфов.",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "Идите по дороге на юго-восток сюда: {area:415}, на остров посреди озера.",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "Из места {area:17203} плывите на корабле сюда: {area:442}; {npc:3649} стоит в северной части деревни. Затем скачите на юг по дороге через зону {zone:1439}.",
	-- ["Hearth to Menethil"] = "Камень возвращения: Гавань Менетилов",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "Камень возвращения еще не готов? Скачите обратно на север через {area:1276}.",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "Керлониан спит здесь: {area:448}, на юге зоны {zone:1439}. Используйте {item:13536}, чтобы разбудить его, и ведите его на юг по дороге в зону {zone:1440} к NPC {npc:11219} ({area:413}); трубите в рог снова каждый раз, когда он засыпает.",
	-- ["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Бегуны топей и туманоплеты из стаи Мохошкуров бродят по берегам реки чуть западнее и южнее {npc:1244}; почти с каждого падает кремень.",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Крапчатые ящеры и крикуны бродят по холмам к западу от раскопок.",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Скачите на восток по дороге ({zone:1437}), на юг через {area:836} в зону {zone:1432} и на запад через туннель в зону {zone:1426} сюда: {area:1537}.",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Скачите на юг мимо места {area:421} в туннель ({area:1276}); он выходит здесь: {area:461} (Когтистые горы). {npc:4080} и {npc:4077} стоят лагерем здесь: {area:1076}, к юго-западу от утеса.",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Скачите на запад к берегу озера ({area:441}). Труп Терониса лежит среди мурлоков из племени Соленой Слюны; с любого мурлока может выпасть {item:5463}.",
	-- ["South of the murlocs, {npc:3585} waits at the {area:416}."] = "К югу от мурлоков {npc:3585} ждет здесь: {area:416}.",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Плывите на корабле из места {area:17203} сюда: {area:442} и летите сюда: {area:702}; {npc:11401} находится в Храме Луны. Затем летите обратно сюда: {area:442}.",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Плывите на корабле: {area:17203} → {area:442}. Соедините две половинки, чтобы получить предмет {item:15885}, и примените {spell:18960}: {npc:11802} находится здесь: {area:2361}. Затем летите сюда: {area:702} (через {area:442}).",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "Лагерь Драконьей Пасти находится к югу от дороги, чуть западнее места {area:1025}: налетчики, болотные бегуны и костостражи. Для задания NPC {npc:2092} ({zone:1426}) нужен 28-й уровень.",
	-- ["The excavation site sits on the hill south of the road."] = "Раскопки находятся на холме к югу от дороги.",
	-- ["The raptor hills"] = "Холмы ящеров",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Venture Co. loggers"] = "Лесорубы Торговой компании",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "убивайте налетчиков и болотных бегунов из клана Драконьей Пасти в их лагере ({zone:1437})",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}, у крепости",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} стоит здесь: {area:2103}, недалеко от NPC {npc:1242}.",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649}: ответ Алекстона",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) возглавляет гноллов из племени Колючего Меха в лагере к северу от места {area:415}. Сначала перебейте его стражей по одному.",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}, в хижине к северу от них",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} добывает руду здесь: {area:2160}, в восточной части утеса. Поговорите с ним и отбивайтесь от налетчиков Торговой компании, пока он работает.",
	-- ["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} ходит по северной оконечности места {area:414} со стражами из клана Зловещего Хвоста.",
}
