-- Portuguese (Brazil) (ptBR): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {zone:1450} Moonglade
	["Cast Teleport: {zone:1450}"] = "",

	-- Step 2: Aquatic Form
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {item:15885} Pendant of the Sea Lion · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast Teleport: {zone:1450}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885}: junte as duas metades",

	-- Step 4: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine
	["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Pegue o portal até o {area:1658} e depois voe de volta a {area:442}.",

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
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "Ao norte do Entreposto de Maestra, há feixes de plantas em volta das ruínas de {area:411}. Sectários da Linhagem das Trevas ocupam as ruínas logo ao sul deles: qualquer um pode deixar cair a {item:5366}.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, dos feixes de plantas",

	-- Step 17: Astranaar
	-- {npc:3970} Llana · {npc:1480} Caitlin Grassman
	["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide; inside"] = "",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, na estalagem",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 18: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "",

	-- Step 19: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}.\nThe two stand together at the western end of the road."] = "",

	-- Step 20: Ilkrud Magthrull
	-- {npc:3664} Ilkrud Magthrull · {area:412} Ruins of Ordil'Aran
	["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} e seus emissários do caos ocupam as {area:412} ao sul do santuário. Atraia os guardas dele primeiro.",

	-- Step 21: The Zoram Strand
	-- {area:414} The Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Siga a costa para o norte até a {area:414}. {npc:3846} acampa na praia; nagas Iracauda enchem a margem.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, nas ruínas da margem",

	-- Step 23: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} The Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} anda pela ponta norte da {area:414} com guardas Iracauda.",

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
	["The tears glow on the small isle east of {area:415}."] = "As lágrimas brilham na ilhota a leste de {area:415}.",

	-- Step 32: The Foulweald
	["The Foulweald"] = "Os Torpeflora",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Os furbolgs Torpeflora vivem na mata ao sul da estrada, a sudeste de {area:415}. O Vigia do Covil Torpeflora e os Ursinos Torpeflora guardam o covil.",

	-- Step 33: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} fica no {area:420}, na margem leste do {area:421}; {npc:210995} acampa na margem oeste. Elementais da Água Contaminados vagam pelo lago entre eles.",
	["Underwater"] = "",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Mate os elementais por 5 Braçadeiras Elementais Intactas e depois use o {item:5456}",

	-- Step 34: Alonso
	-- {npc:210995} Alonso · {area:1276} The Talondeep Path
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around {area:1276}: the map marks where to look"] = "",

	-- Step 35: The Ruins of Stardust
	["West of Mystral Lake, the stardust bushes grow among the ruins."] = "A oeste do Lago Mistral, os arbustos de poeira estelar crescem entre as ruínas.",

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
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "A Empreendimentos S.A. desmata a floresta do {area:461}. Madeireiros e Desmatadores trabalham por toda parte; os Operadores pilotam os retalhadores e um deles leva as plantas.",

	-- Step 43: Webwinder Path
	["Inside"] = "",

	-- Step 45: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 46: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",

	-- Step 47: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "Até {area:150}",

	-- Step 48: Menethil Harbor
	-- {npc:5082} Vincent Hyal · {npc:1480} Caitlin Grassman · {npc:2094} James Halloran · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1242} Karl Boran
	["{npc:5082}, Mikhail and Tapoke Jahn are all at Menethil's inn; Tapoke fights you when you talk to Mikhail, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn.\n{npc:2094} stands by the north gate.\n{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, no píer ao norte da estalagem",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: para {npc:2104} na fortaleza",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, na estalagem",
	-- {npc:1480} Caitlin Grassman
	["{npc:1480}, inside"] = "",
	-- {npc:2097} Harlo Barnaby
	["{npc:2097}, by the north gate"] = "{npc:2097}, perto do portão norte",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the north gate"] = "{npc:2094}, perto do portão norte",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Para Bolvar Fordragon na {object:2117}: guarde-o",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, perto do portão norte",

	-- Step 49: Sida's Bag on the way
	-- {item:3349} Sida's Bag
	["{item:3349} on the way"] = "",

	-- Step 50: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Pilhas de madeira e de ferro estão em volta da fortaleza e ao longo das muralhas do porto.",

	-- Step 51: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands in {area:2103}."] = "",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "",

	-- Step 52: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Siga a costa para o norte saindo de Menethil. Murlocs Guelrazul enchem o pântano; {npc:1259} anda com um bando no meio dele.",

	-- Step 54: Young crocolisks
	["Young crocolisks"] = "Crocoliscos jovens",
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Siga a estrada para leste. Crocoliscos do Pantanal Jovens espreitam nas poças ao norte do sítio de escavação.",

	-- Step 55: The Bluegill hovels
	["The Bluegill hovels"] = "As choças Guelrazul",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Três recipientes nas choças dos murlocs, de sul a norte: o {object:261}, depois o {object:142151}, depois o {object:259} no extremo norte.",

	-- Step 56: Prospector Whelgar
	["Back south down the road to the excavation site.\nThe excavation site sits on the hill south of the road."] = "",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide; below ground"] = "",
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "",

	-- Step 57: On the way
	["On the way"] = "",
	-- {item:2658} Ados Fragment · {npc:1078} Ormer Ironbraid
	["{item:2658} along the way to {npc:1078}"] = "",
	-- {item:2659} Modr Fragment · {npc:1078} Ormer Ironbraid
	["{item:2659} along the way to {npc:1078}"] = "",
	-- {item:2660} Golm Fragment · {npc:1078} Ormer Ironbraid
	["{item:2660} along the way to {npc:1078}"] = "",
	-- {item:2661} Neru Fragment · {npc:1078} Ormer Ironbraid
	["{item:2661} along the way to {npc:1078}"] = "",

	-- Step 58: Black Channel Marsh: kill these as you meet them
	-- {area:1018} Black Channel Marsh
	["{area:1018}: kill these as you meet them"] = "",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nThe relics lie in the dig itself. Sarltooth, a big Razormaw, prowls the raptor valley just west of it.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "",

	-- Step 60: Raptor valley
	["Raptor valley"] = "Vale dos raptores",
	["The bigger raptors hunt in the valley just west of the dig."] = "Os raptores maiores caçam no vale logo a oeste da escavação.",

	-- Step 61: Ormer Ironbraid
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "",

	-- Step 62: Black Oozes
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes"] = "Gosmas Pretas",
	-- {area:309} Ironbeard's Tomb · {area:205} Dun Modr · {npc:2111} Sida
	-- plural, as words: Monstrous Oozes = {npc:1033} Monstrous Ooze
	["Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag."] = "",

	-- Step 63: Dun Modr
	-- {area:205} Dun Modr · {area:881} Thandol Span · {npc:1071} Longbraid the Grim
	["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Siga a estrada para o norte até {area:205}, ao pé da {area:881}. {npc:1071} fica no acampamento dos anões.",

	-- Step 64: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "",

	-- Step 65: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} acampa junto à estrada; {npc:1244} fica mais a leste, junto ao rio.",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "",

	-- Step 66: The Mosshide gnolls
	["The Mosshide gnolls"] = "Os gnolls Pelemusgo",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Gnolls Pelemusgo e Mestiços ocupam as colinas a sudeste da {area:1025}.",

	-- Step 68: Crude Flint
	-- {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Corre-charcos Pelemusgo e Tecebrumas vagam pelas margens do rio logo a oeste e ao sul de {npc:1244}; quase todos deixam cair pederneira.",

	-- Step 70: The Green Belt: kill these as you meet them
	-- {area:1025} The Green Belt
	["{area:1025}: kill these as you meet them"] = "",
	-- {area:1025} The Green Belt · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw · Fen Creepers = {npc:1040} Fen Creeper
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised.\nFen Creepers hide in the marsh pools north-west of the {area:1025}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "",

	-- Step 72: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Espreitadoras da Caverna e Espreitadoras Sanguessugas enchem {area:1021}, a caverna a sudeste do sítio de escavação.",

	-- Step 73: Hearth to Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["Hearth to {area:2104}"] = "",

	-- Step 75: Menethil
	["Menethil"] = "",
	["For the giant crocolisks of the north coast, on your next visit"] = "Para os crocoliscos gigantes da costa norte, na sua próxima visita",

	-- Step 76: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "",

	-- Step 77: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "",

	-- Step 78: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "",

	-- Step 80: Ironforge
	-- {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan · {zone:1426} Dun Morogh · {area:1537} Ironforge
	["Head east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, na {object:32372}",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Só com o {item:5352} de {zone:1439}: {npc:2786}, na {object:32383}",

	-- Step 81: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn Two-Handed Axes from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 82: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn Two-Handed Maces from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 83: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn Two-Handed Axes from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 84: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Sacerdotes de {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} e {npc:258785} estão no {object:32386}, na {object:32362}.",

	-- Step 85: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 86: Cathedral of Light
	["Cathedral of Light"] = "Catedral da Luz",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Pegue o {area:2257} em {object:171524} até o {object:28027} de {zone:1453}, depois ande até a {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, na Catedral da Luz",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Para {npc:2228} em {area:271}: guarde-o",

	-- Step 87: Cathedral of Light
	-- {npc:1444} Brother Kristoff · {object:2098} Cathedral Square
	["{npc:1444}, in the {object:2098}"] = "{npc:1444}, na {object:2098}",

	-- Step 88: Stormwind Keep
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, in the Royal Library"] = "{npc:1440}, na Biblioteca Real",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Só se você saqueou {quest:337} em {zone:1431}",

	-- Step 90: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter
	["{object:2164} is in the {object:2101}."] = "{object:2164} fica no {object:2101}.",

	-- Step 91: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} e {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, a loja de queijos no {object:2096}",

	-- Step 92: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Próximo: voe até {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "De volta à Catedral da Luz: {npc:928} fica lá dentro.",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Gosmas Pretas rastejam pelo pântano ao norte da estrada da {area:1025}, a oeste do acampamento de {npc:2093}. Qualquer gosma pode ter a bolsa de {npc:2111}.",
	-- ["Dragonmaw camp"] = "Acampamento Presa do Dragão",
	-- ["Escort Kerlonian to {area:413} in {zone:1440}."] = "Escolte Kerlonian até {area:413} em {zone:1440}.",
	-- ["Fen Creepers"] = "Rastejantes do Pântano",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Rastejantes do Pântano se escondem nas poças do pântano a noroeste da {area:1025}.",
	-- ["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Siga a estrada para leste até o {area:419}; {npc:3916} fica junto ao poço lunar.",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "Siga a estrada para sudeste até {area:415}, na ilha do lago.",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "De {area:17203}, pegue o navio até {area:442}; {npc:3649} fica no extremo norte da vila. Depois cavalgue para o sul pela estrada através de {zone:1439}.",
	-- ["Hearth to Menethil"] = "Regressar para Menethil",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "Pedra de Regresso em recarga? Volte para o norte pela {area:1276}.",
	-- ["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "Kerlonian dorme no {area:448}, no sul de {zone:1439}. Use a {item:13536} para acordá-lo e leve-o para o sul pela estrada até {zone:1440}, até {npc:11219} em {area:413}; toque a trombeta de novo sempre que ele adormecer.",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Raptores Mosqueados e Guinchadores vagam pelas colinas a oeste do sítio de escavação.",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Cavalgue para leste pela estrada do {zone:1437}, para o sul por {area:836} até {zone:1432} e para oeste pelo túnel até {zone:1426}, até {area:1537}.",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Cavalgue para o sul, passando o {area:421}, até o túnel da {area:1276}; ele sai no {area:461}, na Cordilheira das Torres de Pedra. {npc:4080} e {npc:4077} acampam na {area:1076}, a sudoeste do penhasco.",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Cavalgue para oeste até a margem do {area:441}. O cadáver de Teronis está entre os murlocs Babassal; qualquer murloc pode deixar cair a {item:5463}.",
	-- ["South of the murlocs, {npc:3585} waits at the {area:416}."] = "Ao sul dos murlocs, {npc:3585} espera no {area:416}.",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Pegue o navio de {area:17203} até {area:442} e voe até {area:702}; {npc:11401} está no Templo da Lua. Depois voe de volta a {area:442}.",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Pegue o navio de {area:17203} até {area:442}. Junte as duas metades do pingente no {item:15885} e lance {spell:18960}: {npc:11802} está em {area:2361}. Depois voe até {area:702} (passando por {area:442}).",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "O acampamento Presa do Dragão fica ao sul da estrada, logo a oeste da {area:1025}: Saqueadores, Corre-brejos e Guarda-ossos. A missão de {npc:2092} em {zone:1426} requer nível 28.",
	-- ["The excavation site sits on the hill south of the road."] = "O sítio de escavação fica na colina ao sul da estrada.",
	-- ["The raptor hills"] = "As colinas dos raptores",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Venture Co. loggers"] = "Madeireiros da Empreendimentos S.A.",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "farme Saqueadores Presa do Dragão e Corre-brejos no acampamento Presa do Dragão, {zone:1437}",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}, perto da fortaleza",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} fica na {area:2103}, a uma curta caminhada de {npc:1242}.",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649}: a resposta de Alexston",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) lidera os gnolls Pelocardo no acampamento ao norte de {area:415}. Elimine os guardas dele primeiro, um de cada vez.",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}, na cabana ao norte deles",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} minera na {area:2160}, no extremo leste do penhasco. Fale com ele e afaste os atacantes da Empreendimentos S.A. enquanto ele minera.",
}
