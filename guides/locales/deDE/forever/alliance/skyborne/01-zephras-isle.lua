-- German (deDE): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "Du erwachst im {area:16622}. {npc:251362} steht neben dir; {npc:251361} ist ein paar Schritte westlich, {npc:251368} am Südrand des Hains.",

	-- Step 2: Thendal Grove: kill these as you meet them
	-- {area:16622} Thendal Grove
	["{area:16622}: kill these as you meet them"] = "{area:16622}: Töte diese, sobald du ihnen begegnest",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873} und Lästige Zirrusfliegen streifen über die Wiese südöstlich des Hains.",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "Zurück zum {area:16622}",
	-- {npc:257554} Halaan Hawk-Eye · {npc:263113} Myriaal Mistwake · {npc:251368} Elatrell Featherlight
	["{npc:257554} and {npc:263113} stand at the top of the watchtower, a few steps north-east of {npc:251368}."] = "{npc:257554} und {npc:263113} stehen oben auf dem Wachturm, ein paar Schritte nordöstlich von {npc:251368}.",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "Hör {npc:257554} zu",

	-- Step 4: Rorian the Dayseeker
	-- {npc:251361} Rorian the Dayseeker
	["Jump off the top of the watchtower and use Walk on Air to float down to {npc:251361}, west of the tower."] = "Spring von der Spitze des Wachturms und benutze Luftwandeln, um zu {npc:251361} westlich des Turms hinabzuschweben.",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: die {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: eine Notiz von deinem Lehrer",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: Lies die {item:9547}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, im Wachturm",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, im Wachturm",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "{npc:251379}, die Magierlehrerin: Lies zuerst den {item:282416}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, der Druidenlehrer, im Erdgeschoss des Baumes hinter {npc:251361}",
	["The class trainers stand together in the grove"] = "Die Klassenlehrer stehen zusammen im Hain",

	-- Step 5: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "Rohe Windsteine und die {npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "Die Rohen Windsteine glitzern auf dem Boden direkt südlich des Hains. {quest:92463} schwebt weiter östlich über der Wiese, auf dem Weg zu {npc:249363}.",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "{area:16622}: Quests abgeben",

	-- Step 7: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words)
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Leyline racial ability at it."] = "{npc:249363} hält östlich des Hains Wache. {npc:251143} und Al'Aketh Converts sammeln sich knapp nördlich von ihr; {object:460002} ragt weiter nördlich auf: Wirke deine Volksfähigkeit Read Leyline darauf.",
	-- {object:460002} Ley Line (no name in this language: may be words)
	["Cast Read Leyline at the {object:460002}"] = "Wirke Read Leyline auf {object:460002}",

	-- Step 9: Thendal Grove turn-ins
	["Level 4 spells"] = "Zauber der Stufe 4",

	-- Step 10: Thendal Grove: kill these as you meet them
	-- {npc:251115} Urs'anah · {npc:250926} Scrawny Ursera
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["The Ursera Scavengers den west of the grove, with {npc:251115}, the matriarch, at the back of the den; {npc:250926} prowl the woods between the den and the grove."] = "Die Ursera Scavengers hausen in einer Höhle westlich des Hains, mit {npc:251115}, der Matriarchin, ganz hinten in der Höhle; {npc:250926} streifen durch die Wälder zwischen der Höhle und dem Hain.",
	["Below ground"] = "Unter der Erde",
	-- {item:252665} Head of Urs'anah
	["{item:252665}; below ground"] = "{item:252665}; unter der Erde",

	-- Step 11: Aetheen of the Gales
	["Back east out of the den to the grove."] = "Zurück nach Osten aus der Höhle zum Hain.",

	-- Step 12: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south-west of the grove, south of the Ursera den, on the way south to Shen'dar. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle.\nCareful: {npc:256935} casts shocks; drag him clear of the other cultists before fighting so they don't join in."] = "{npc:252095} lagert südwestlich des Hains, südlich der Ursera-Höhle, auf dem Weg nach Süden nach Shen'dar. Die Al'Aketh-Schläger halten das Lager südwestlich von ihr; {npc:256935} steht in dessen Mitte.\nVorsicht: {npc:256935} wirkt Schocks; zieh ihn vor dem Kampf von den anderen Kultisten weg, damit sie nicht eingreifen.",

	-- Step 13: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "Folge der Straße nach Süden nach {area:16624}. {npc:263664} lagert am Feuer westlich des Dorfes; {npc:251523} und {npc:251903} stehen in der Dorfmitte.",

	-- Step 14: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {area:16624} Shen'dar Village
	["With a profession learned, {npc:263664} also offers its Camping 101, which its trainer in {area:16624} takes on the village round."] = "Hast du einen Beruf erlernt, bietet {npc:263664} auch das zugehörige Camping 101 an, das du bei seinem Lehrer in {area:16624} auf der Dorfrunde abgibst.",
	-- {npc:263664} Raan Wildwind
	["/sit by {npc:263664}'s campfire until you get Boosted Rest"] = "Mit /sit am Lagerfeuer von {npc:263664} sitzen, bis du Verbesserter Ruhebonus bekommst",

	-- Step 15: Camping 101: Alchemy
	-- {npc:263664} Raan Wildwind · {npc:257019} Nyassa Swiftdraught
	["{npc:263664}: for {npc:257019}"] = "{npc:263664}: für {npc:257019}",

	-- Step 16: Camping 101: Blacksmithing
	-- {npc:263664} Raan Wildwind · {npc:251913} Aedi Thriceforged
	["{npc:263664}: for {npc:251913}"] = "{npc:263664}: für {npc:251913}",

	-- Step 17: Camping 101: First Aid
	-- {npc:263664} Raan Wildwind · {npc:257018} Naleeia Tattermend
	["{npc:263664}: for {npc:257018}"] = "{npc:263664}: für {npc:257018}",

	-- Step 18: Camping 101: Fishing
	-- {npc:263664} Raan Wildwind · {npc:251992} Fenn Fairweather
	["{npc:263664}: for {npc:251992}"] = "{npc:263664}: für {npc:251992}",

	-- Step 19: Camping 101: Leatherworking
	-- {npc:263664} Raan Wildwind · {npc:251993} Indari Sunseam
	["{npc:263664}: for {npc:251993}"] = "{npc:263664}: für {npc:251993}",

	-- Step 20: Camping 101: Mining
	-- {npc:263664} Raan Wildwind · {npc:257022} Messana Crestwind
	["{npc:263664}: for {npc:257022}"] = "{npc:263664}: für {npc:257022}",

	-- Step 21: Camping 101: Skinning
	-- {npc:263664} Raan Wildwind · {npc:257024} Mendalass Tattermend
	["{npc:263664}: for {npc:257024}"] = "{npc:263664}: für {npc:257024}",

	-- Step 22: Camping 101: Tailoring
	-- {npc:263664} Raan Wildwind · {npc:251991} Taleen Shimmerthread
	["{npc:263664}: for {npc:251991}"] = "{npc:263664}: für {npc:251991}",

	-- Step 23: Camping 101: Enchanting
	-- {npc:263664} Raan Wildwind · {npc:257020} Nasalanna Windsinger
	["{npc:263664}: for {npc:257020}"] = "{npc:263664}: für {npc:257020}",

	-- Step 24: Zerril Softbreeze
	-- {npc:251905} Zerril Softbreeze
	["{npc:251905}: Camping 101 asks you to learn it"] = "{npc:251905}: Camping 101 verlangt, dass du es lernst",

	-- Step 25: Village quests
	["Village quests"] = "Dorfquests",

	-- Step 27: Messana Crestwind
	-- {npc:257022} Messana Crestwind · {npc:251993} Indari Sunseam
	["{npc:257022}, beside {npc:251993}"] = "{npc:257022}, neben {npc:251993}",

	-- Step 30: Aedi Thriceforged
	-- {npc:251913} Aedi Thriceforged · {npc:251991} Taleen Shimmerthread
	["{npc:251913}, beside {npc:251991}"] = "{npc:251913}, neben {npc:251991}",

	-- Step 32: Nyassa Swiftdraught
	-- {npc:257019} Nyassa Swiftdraught · {npc:251905} Zerril Softbreeze
	["{npc:257019}, west of {npc:251905}"] = "{npc:257019}, westlich von {npc:251905}",

	-- Step 35: Naleeia Tattermend
	-- {npc:257018} Naleeia Tattermend
	["{npc:257018}, at the south side of the village"] = "{npc:257018}, auf der Südseite des Dorfes",

	-- Step 36: Fenn Fairweather
	-- {npc:251992} Fenn Fairweather
	["{npc:251992}, on the south edge of the village"] = "{npc:251992}, am Südrand des Dorfes",

	-- Step 37: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Rudelkrallen und Windschreiter",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands around the village. Galestriders drop both the eggs and the meat: most players get the eggs from the ones just west of the village."] = "Prideclaws und Galestriders streifen durch das Grasland rund um das Dorf. Galestriders lassen sowohl die Eier als auch das Fleisch fallen: Die meisten Spieler holen die Eier bei denen westlich des Dorfes.",

	-- Step 38: Village quests
	["The bounty board"] = "Das Kopfgeldbrett",

	-- Step 40: Shen'dar Highlands: kill these as you meet them
	-- {area:16623} Shen'dar Highlands
	["{area:16623}: kill these as you meet them"] = "{area:16623}: Töte diese, sobald du ihnen begegnest",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "Die Hochlandbanditen lagern nordöstlich des Dorfes. „Übelwind“ Bennic wartet am äußersten Nordende ihres Lagers.",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["Highlands Bandits"] = "Highlands Bandits",
	["\"Badwind\" Bennic, below ground"] = "„Badwind“ Bennic, unter der Erde",

	-- Step 41: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "Shen'dar: Quests abgeben",

	-- Step 42: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 43: Paladin trainer
	["Paladin trainer"] = "Paladinlehrer",
	-- {npc:5148} Beldruk Doombrow · {zone:1455} Ironforge · {area:16624} Shen'dar Village
	["{npc:5148} in {zone:1455}; {area:16624} has no paladin trainer"] = "{npc:5148} in {zone:1455}; {area:16624} hat keinen Paladinlehrer",

	-- Step 44: Priest trainer
	["Priest trainer"] = "Priesterlehrer",
	-- {zone:1438} Teldrassil · {area:16624} Shen'dar Village
	["Lariia in {zone:1438}; {area:16624} has no priest trainer"] = "Lariia in {zone:1438}; {area:16624} hat keinen Priesterlehrer",

	-- Step 45: Shaman trainer
	["Shaman trainer"] = "Schamanenlehrer",
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {area:16624} Shen'dar Village
	["{npc:258098} in {zone:1455}; {area:16624} has no shaman trainer"] = "{npc:258098} in {zone:1455}; {area:16624} hat keinen Schamanenlehrer",

	-- Step 46: Warlock trainer
	["Warlock trainer"] = "Hexenmeisterlehrer",
	-- {item:2450} Briarthorn · {zone:1455} Ironforge · {area:16624} Shen'dar Village
	["{item:2450} in {zone:1455}; {area:16624} has no warlock trainer"] = "{item:2450} in {zone:1455}; {area:16624} hat keinen Hexenmeisterlehrer",

	-- Step 47: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The Mark of Akir lets you walk in among the faithful."] = "{npc:257065} wartet am Eingang von {quest:92529}, südlich von Shen'dar. Das Mal von Akir (Mark of Akir) lässt dich unter die Gläubigen treten.",
	["Search the wardrobe"] = "Durchsuche den Kleiderschrank",

	-- Step 48: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} lauert auf dem Rückweg in den Hügeln südwestlich des Dorfes. {npc:254589} ist Elite: Eine Gruppe wird empfohlen.",

	-- Step 50: Shen'dar Highlands: kill these as you meet them
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "Zurück in {quest:92529}: Sturmrufer der Al'Aketh und {npc:251662} füllen das Dorf, die Sturmrufer tragen die gestohlenen Vorräte, und {npc:251966} steht am Südende.",

	-- Step 51: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155} hält die westliche Wacht, südwestlich von Falaath. {npc:256966} und die gefallenen Wachen liegen direkt südlich von ihr.",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "Die {item:254871}",

	-- Step 52: Shen'dar Highlands: kill these as you meet them
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them.\nThe Novice Seers practise in the clearing west of Shen'dar, on the way back to the village."] = "Geh nach Nordwesten zu den Hippogryphennestern auf den westlichen Klippen. {item:263493} liegt rund um die Nester; die Matriarchin patrouilliert zwischen ihnen.\nDie Novice Seers üben auf der Lichtung westlich von Shen'dar, auf dem Rückweg ins Dorf.",

	-- Step 53: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "Wieder nach {area:16624}",

	-- Step 55: Fendaal Windstone
	-- {area:16638} Valanaar · {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["On the road south-east to {area:16638}, {npc:273017} watches the {quest:98512} just north of him."] = "Auf der Straße nach Südosten nach {area:16638} beobachtet {npc:273017} die {quest:98512} direkt nördlich von ihm.",

	-- Step 56: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}, der Verräter",

	-- Step 57: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383} und {npc:252476} stehen am Nordende von {area:16638}, {npc:252475} und {npc:253204} am Südende.",
	-- {npc:252476} Talaanis Shadowsong
	["{npc:252476}, upstairs"] = "{npc:252476}, oben",
	-- {npc:252383} Valennia Stormfist
	["{npc:252383}, upstairs"] = "{npc:252383}, oben",

	-- Step 59: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Himmelshüpfer",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "Himmelshüpfer schwärmen über die Felder westlich von {area:16638}.",

	-- Step 60: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "Die Straße nach {area:16638}",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar · {npc:252377} Seena Skybreaker · {npc:252389} Quel'ana Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["{npc:257006} and {npc:252448} stand on {area:16638}'s west side, beside the inn; {npc:252377} and {npc:252389} train just west of {npc:257006}. Windsong Crawlers line the shore further west, around 51,70."] = "{npc:257006} und {npc:252448} stehen an der Westseite von {area:16638}, neben dem Gasthaus; {npc:252377} und {npc:252389} lehren direkt westlich von {npc:257006}. Windsong Crawlers säumen das Ufer weiter westlich, um 51,70.",
	-- {npc:252377} Seena Skybreaker · {npc:257006} Nyalah Brightfire · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}, beside {npc:257006}: {npc:257196} holds the Bulwark at the {area:16629}"] = "{npc:252377}, neben {npc:257006}: {npc:257196} hält das Bollwerk bei {area:16629}",
	-- {npc:252389} Quel'ana Quickgale · {npc:257006} Nyalah Brightfire · {item:15908} Taming Rod
	["{npc:252389}, beside {npc:257006}: the first {item:15908}"] = "{npc:252389}, neben {npc:257006}: der erste {item:15908}",
	-- {npc:255940} Donaal Downbreeze
	["Innkeeper {npc:255940}, by the west gate"] = "Gastwirt {npc:255940}, am Westtor",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Hör dir die Geschichte von {npc:252448} an",
	-- {npc:257006} Nyalah Brightfire
	["{npc:257006}, inside"] = "{npc:257006}, drinnen",

	-- Step 62: The missing scholar
	["The missing scholar"] = "Der vermisste Gelehrte",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	["The {object:581822} lies by the path west of {area:16638}."] = "{object:581822} liegt am Pfad westlich von {area:16638}.",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "Der {object:581822}",

	-- Step 63: Gustberry Lowlands
	-- {npc:254588} Windsong Crawler · {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:254588}, among the crabs: tame one with {npc:252389}'s first {item:15908} while you are there"] = "{npc:254588}, bei den Krabben: Zähme eine mit {npc:252389}s erstem {item:15908}, solange du hier bist",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Zähme {npc:254588}",
	["Underwater"] = "Unter Wasser",

	-- Step 64: The missing scholar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "Fillions Lager liegt nordwestlich davon, und die Shriekling Matriarchs nisten direkt westlich des Lagers.",
	-- {item:257107} Shriekling Matriarch's Head
	["{item:257107}; below ground"] = "{item:257107}; unter der Erde",

	-- Step 65: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800} bewirtschaftet den Hof im südwestlichen Tiefland.",

	-- Step 66: Gustberry Lowlands: kill these as you meet them
	-- {area:16626} Gustberry Lowlands
	["{area:16626}: kill these as you meet them"] = "{area:16626}: Töte diese, sobald du ihnen begegnest",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "Reife Sturmäpfel und Hungrige Banditen findest du im Obstgarten beim Hof, {quest:92683} auf den Feldern nordöstlich davon, Störrische Windschreiter überall ringsum. Das {npc:250929} steht auf dem Feld nordöstlich des Hofs.",

	-- Step 67: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "Wieder zu {npc:252800}",
	-- {npc:252800} Aamelia Windfield
	["Back to {npc:252800} at the farmhouse."] = "Zurück zu {npc:252800} im Bauernhaus.",

	-- Step 68: Bandit Highwaymen
	["Bandit Highwaymen"] = "Banditenstraßenräuber",
	["The Bandit Highwaymen hold the hills north of the farm."] = "Die Banditenstraßenräuber halten die Hügel nördlich des Hofs.",

	-- Step 69: Standing our ground
	["Standing our ground"] = "Standhalten",
	-- {npc:252800} Aamelia Windfield
	["{npc:252800}, at the farmhouse"] = "{npc:252800}, im Bauernhaus",
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Sag {npc:252800}, dass du bereit bist",

	-- Step 70: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "{area:16638}: Quests abgeben",
	-- {npc:252359} Lotheluum Starbreeze · {quest:94006} The Great Ursera Spirit
	["{npc:252359}, between the west gate and Valennia's house: {quest:94006}"] = "{npc:252359}, zwischen dem Westtor und Valennias Haus: {quest:94006}",

	-- Step 71: Valanaar turn-ins
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373}, der Magierlehrer",

	-- Step 72: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider · Vuldren Alphas = {npc:250874} Vuldren Alpha
	["{npc:252389} takes back the first {item:15908} and hands you two more, one at a time: Ornery Galestriders and Vuldren Alphas roam the fields just north of her. Tame each with its rod and bring the rod back to her. {npc:254411}, beside her, teaches Beast Training."] = "{npc:252389} nimmt den ersten {item:15908} zurück und gibt dir zwei weitere, einen nach dem anderen: Ornery Galestriders und Vuldren Alphas streifen über die Felder direkt nördlich von ihr. Zähme jeweils eins mit seinem Stab und bring den Stab zu ihr zurück. {npc:254411}, neben ihr, lehrt Wildtierausbildung.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Zähme es mit der {item:15908}",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Zähme {npc:251707}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Zähme {npc:250874}",
	["Tame Beast"] = "Wildtier zähmen",
	-- {npc:254411} Quel'dora Quickgale
	["{npc:254411}: Beast Training"] = "{npc:254411}: Wildtierausbildung",

	-- Step 73: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Die Windsteinformationen",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "Die Windsteinformationen stehen auf der Anhöhe westlich von Fillions Lager.",
	-- {item:262668} Wind-Infused Bough
	["{item:262668}: by the formations"] = "{item:262668}: bei den Formationen",

	-- Step 75: The eastern watchtower
	["The eastern watchtower"] = "Der östliche Wachturm",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378} hält den Wachturm nördlich von {area:16638}. Das Lager der Al'Aketh liegt direkt westlich des Turms, die Heiler bei 65,68 und 65,65; {npc:252666} steht am Nordende. Die Al'Aketh dort lassen Windsteinamulette der Al'Aketh fallen.",

	-- Step 76: Urs'endris
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16638} Valanaar
	["{npc:255853} waits by the falls just north of the watchtower. {npc:258443} prowls the {area:16623} south-west of the dead cultist, where you go after {area:16638}."] = "{npc:255853} wartet an den Fällen direkt nördlich des Wachturms. {npc:258443} streift durch {area:16623} südwestlich des toten Kultisten, wohin du nach {area:16638} gehst.",

	-- Step 78: The dead cultist
	["The dead cultist"] = "Der tote Kultist",
	-- {npc:273017} Fendaal Windstone
	["North-west of Valanaar along the road, past {npc:273017}: the dead cultist lies just north of him."] = "Nordwestlich von Valanaar die Straße entlang, an {npc:273017} vorbei: Der tote Kultist liegt direkt nördlich von ihm.",
	["Search the dead cultist"] = "Durchsuche den toten Kultisten",
	["Inside"] = "Drinnen",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443}, im Hochland südwestlich des Kultisten",

	-- Step 79: Desperate times
	["Desperate times"] = "Verzweifelte Zeiten",
	["Upstairs"] = "Oben",

	-- Step 81: Paladin trainer
	-- {npc:5148} Beldruk Doombrow · {zone:1455} Ironforge · {area:16638} Valanaar
	["{npc:5148} in {zone:1455}; {area:16638} has no paladin trainer"] = "{npc:5148} in {zone:1455}; {area:16638} hat keinen Paladinlehrer",

	-- Step 82: Priest trainer
	-- {npc:5141} Theodrus Frostbeard · {zone:1455} Ironforge · {area:16638} Valanaar
	["{npc:5141} in {zone:1455}; {area:16638} has no priest trainer"] = "{npc:5141} in {zone:1455}; {area:16638} hat keinen Priesterlehrer",

	-- Step 83: Shaman trainer
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {area:16638} Valanaar
	["{npc:258098} in {zone:1455}; {area:16638} has no shaman trainer"] = "{npc:258098} in {zone:1455}; {area:16638} hat keinen Schamanenlehrer",

	-- Step 84: Warlock trainer
	-- {item:2450} Briarthorn · {zone:1455} Ironforge · {area:16638} Valanaar
	["{item:2450} in {zone:1455}; {area:16638} has no warlock trainer"] = "{item:2450} in {zone:1455}; {area:16638} hat keinen Hexenmeisterlehrer",

	-- Step 85: Desperate times
	-- {npc:253844} Valennia Stormfist
	["Meet {npc:253844} at the gate"] = "Triff {npc:253844} am Tor",
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["{npc:255853}, by the falls north-east of {area:16638}, on the way north: Bear Form"] = "{npc:255853}, an den Fällen nordöstlich von {area:16638}, auf dem Weg nach Norden: Bärengestalt",

	-- Step 86: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "Geh nach Norden in den {area:16631}. {npc:257944} lagert im Osten.",

	-- Step 87: Shadowgale Forest: kill these as you meet them
	-- {area:16631} Shadowgale Forest
	["{area:16631}: kill these as you meet them"] = "{area:16631}: Töte diese, sobald du ihnen begegnest",
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "Sturmjäger und Fußsoldaten der Al'Aketh lagern direkt nördlich von {npc:257944} und lassen das Erbstück fallen; die Schattenwindkreischlinge westlich von ihr lassen die Federn und Krallen fallen; das {item:265105} wächst am Bach westlich von ihr.",

	-- Step 88: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "Wieder zu {npc:257944}",

	-- Step 89: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:254151}, {npc:258130} und {npc:258134} sind nordöstlich von {npc:257944}; {npc:253622} steht östlich von ihnen. Haalien lässt außerdem {quest:94490} fallen. Für {quest:94489} betritt den Nachtfangbau, heile 7 verletzte Druiden und finde {npc:258130}.",
	["Heal the injured druids in the Nightfang Den"] = "Heile die verletzten Druiden im Nachtfangbau",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Finde {npc:258130}",
	-- {item:258771} Al'Aketh Cultist's Ear · {npc:254151} Vayn Moongaze
	["{item:258771}: the Stormchasers and Footsoldiers around {npc:254151}'s camp"] = "{item:258771}: die Stormchasers und Footsoldiers rund um das Lager von {npc:254151}",

	-- Step 90: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}, das Schreiben",

	-- Step 91: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159} lebt westlich von {npc:257944}. Die Zephyrzapfen liegen im Wald zwischen seiner Hütte und {npc:257944}.",

	-- Step 92: Ruins of Ban'aethal: kill these as you meet them
	-- {area:16833} Ruins of Ban'aethal
	["{area:16833}: kill these as you meet them"] = "{area:16833}: Töte diese, sobald du ihnen begegnest",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "Nördlich der Zapfen: Die Windhüllen treiben um das Flüchtlingslager, die {item:266433} liegt zwischen den Zelten, und {npc:259013} liegt am Nordende.",

	-- Step 93: Back to the Hermit
	["Back to the Hermit"] = "Zurück zum Einsiedler",

	-- Step 94: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "Der {area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "Kämpf dich nach Norden zum {area:16629} durch. Wächter, Geisterrufer und Klingenmeister halten den Zugang; {npc:253576} wartet an der Tür des Schreins, {npc:253590} im inneren Sanktum.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196} holds it, west of the shrine's approach; defeat him for it on the way in"] = "{item:263993}: {npc:257196} hält es, westlich des Zugangs zum Schrein; besiege ihn dafür auf dem Weg hinein",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum; upstairs"] = "{npc:253590}, im Heiligtum; oben",

	-- Step 95: Portal to Rohashi Spires
	-- {area:16630} Rohashi Spires
	["Portal to {area:16630}"] = "Portal nach {area:16630}",

	-- Step 96: High Priestess Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {object:617084} Portal to Valanaar (no name in this language: may be words)
	["Lorthuna waits up on the {area:16630}, east of the shrine: take the Portal to {area:16630} in the inner sanctum, beside Valennia, and cross the heights east to {npc:252475}. When she falls, the {object:617084} beside her takes you back to town."] = "Lorthuna wartet oben auf {area:16630}, östlich des Schreins: Nimm das Portal nach {area:16630} im inneren Heiligtum, neben Valennia, und überquere die Höhen nach Osten zu {npc:252475}. Wenn sie fällt, bringt dich {object:617084} neben ihr zurück in die Stadt.",

	-- Step 97: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}, das Schicksal von Zephras",
	-- {object:617084} Portal to Valanaar (no name in this language: may be words) · {npc:252475} Elaadrin Evengale · {npc:252476} Talaanis Shadowsong · {npc:259012} Ealaane Nimbuswalker
	["The {object:617084} sets you down beside {npc:252475} at the south end of the town. {npc:252476} is at the north end, {npc:259012} a few steps north-west of her."] = "{object:617084} setzt dich neben {npc:252475} am Südende der Stadt ab. {npc:252476} ist am Nordende, {npc:259012} ein paar Schritte nordwestlich von ihr.",

	-- Step 99: Valanaar, the fate of Zephras
	-- {npc:252377} Seena Skybreaker
	["{npc:252377}: Defensive Stance"] = "{npc:252377}: Verteidigungshaltung",

	-- Step 100: Elaadrin Evengale
	-- {npc:252475} Elaadrin Evengale · {area:279} Dalaran · {area:16638} Valanaar · {npc:259084} Denaaris Stargale
	["{npc:252475} sends you on to {area:279}. Take the skycutter from the dock tower just south of {area:16638}: it lands by the Kirin Tor camp west of {area:279}, beside {npc:259084} and the Skyborne Portal."] = "{npc:252475} schickt dich weiter nach {area:279}. Nimm den Skycutter vom Dockturm direkt südlich von {area:16638}: Er landet am Lager des Kirin Tor westlich von {area:279}, neben {npc:259084} und dem Portal der Himmelsgeborenen.",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475}: {npc:259084} wartet beim Portal der Himmelsgeborenen",

	-- Step 101: Leave Zephras Isle to Alterac Mountains
	-- {zone:2521} Zephras Isle · {zone:1416} Alterac Mountains
	["Leave {zone:2521} to {zone:1416}"] = "Verlasse {zone:2521} nach {zone:1416}",

	-- Step 102: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal, where the skycutter lands by the Kirin Tor camp west of {area:279}. The portal takes you to {zone:1453}."] = "{npc:259084} steht neben dem Portal der Himmelsgeborenen, wo der Skycutter am Lager des Kirin Tor westlich von {area:279} landet. Das Portal bringt dich nach {zone:1453}.",
	-- {npc:259084} Denaaris Stargale
	["{npc:259084}, inside"] = "{npc:259084}, drinnen",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459}, neben {npc:259084}: für {npc:5504} in {zone:1453}",
	-- {object:631299} Skyborne Portal to Stormwind
	["{object:631299}, inside"] = "{object:631299}, drinnen",

	-- Step 103: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 104: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "Bolvar Fordragon steht im Thronsaal von {object:2117}, am Nordende der Stadt. Verlass die Stadt dann durch das Haupttor nach {zone:1436}.",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "Für {npc:234} auf der {area:108}",

	-- Step 105: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646} stands in {object:2098}, on the way from the Keep to the main gate: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646} steht in {object:2098}, auf dem Weg von der Burg zum Haupttor: Sein Kompass liegt in seinem alten Haus in {zone:1436}, auf dem Weg.",

	-- Step 106: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Wenn du schon hier bist: Lerne Zweihandschwerter bei {npc:11867} ({object:2096}, 10 Silber); Zweihandwaffen leveln einen Krieger am schnellsten.",

	-- Step 107: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Wenn du schon hier bist: Lerne Stäbe bei {npc:11867} ({object:2096}, 10 Silber); die Nahkampfwaffe eines Jägers besteht vor allem aus ihren Werten, und Zweihandwaffen haben davon am meisten.",

	-- Step 108: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Wenn du schon hier bist: Lerne Schwerter bei {npc:11867} ({object:2096}, 10 Silber); ein Schwert in der Haupthand levelt einen Schurken zuverlässig.",

	-- Step 110: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {quest:94914} Moonglade · {npc:11802} Dendrite Starblaze · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you Teleport: {quest:94914}. {npc:11802}'s welcome waits for your Cat Form trip at the end of {zone:1439}."] = "{npc:5504}, der Druidenlehrer von {zone:1453}, bringt dir Teleportation bei: {quest:94914}. Der Empfang von {npc:11802} wartet auf deine Katzengestalt-Reise am Ende von {zone:1439}.",

	-- Step 112: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} steht im Magiersanktum, dem Turm im Gebiet {object:2101}; sie gibt dir ein Fläschchen für den Wasserfall am {quest:1861}.",

	-- Step 113: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Verlass {zone:1453} durch das Haupttor. Der Wasserfall am {quest:1861} liegt südwestlich der Tore, auf dem Weg nach Westen nach {zone:1436}: Fülle {item:7207} an seinem Fuß.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "/sit an {npc:263664}s Lagerfeuer, bis du {spell:1229451} bekommst",
	-- ["Back to Shen'dar"] = "Zurück nach Shen'dar",
	-- ["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "Zurück zu {npc:255853} an den Wasserfällen nordöstlich von {area:16638}, auf dem Weg nach Norden zum Schrein.",
	-- ["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {area:40}."] = "Bolvar Fordragon steht im Thronsaal von {object:2117}, am Nordende der Stadt. Verlass die Stadt dann durch das Haupttor nach {area:40}.",
	-- ["Cast Read Ley Line at the {object:460002}"] = "Lies {object:460002} mit deiner Volksfähigkeit",
	-- ["Cast {spell:1259705} at the {object:460002}"] = "Wirk {spell:1259705} auf die Leylinie",
	-- ["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "Jede Quest von Quel'ana gibt dir eine {item:15908}: Benutze sie am genannten Wildtier und bring die Rute dann zu ihr nach {area:16638} zurück. Windweisenkriecher säumen das Ufer westlich der Stadt; Vuldrenalphas und Störrische Windschreiter streifen im Gebiet {area:16626} rund um den Hof der Windfields. Ihre Schwester {npc:254411} steht neben ihr.",
	-- ["Find Fillion and his bedroll"] = "Finde Fillion und seine Deckenrolle",
	-- ["Havoc in Falaath"] = "Chaos in Falaath",
	-- ["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "Geh nach Nordwesten zu den Hippogryphennestern an den westlichen Klippen. {item:263493} liegen rund um die Nester; die Hippogryphenmatriarchin patrouilliert zwischen ihnen.",
	-- ["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "Heile 7 Druiden im Nightfang Den und finde dann {npc:258130}",
	-- ["Jump off the top of the watchtower and use {spell:1259416} to float down to {npc:251361}, west of the tower."] = "Spring von der Spitze des Wachturms und benutze {spell:1259416}, um zu {npc:251361} westlich des Turms hinabzuschweben.",
	-- ["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {area:40}: fill {item:7207} at its base."] = "Verlass {zone:1453} durch das Haupttor. Der Wasserfall am {quest:1861} liegt südwestlich der Tore, auf dem Weg nach Westen nach {area:40}: Füll {item:7207} an seinem Fuß.",
	-- ["Level 6 spells"] = "Zauber der Stufe 6",
	-- ["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "Lorthuna wartet am Ostufer der Insel, östlich des {area:16629}.",
	-- ["Meet Valennia at the gate"] = "Triff Valennia am Tor",
	-- ["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "Nordwestlich von Valanaar an der Straße: {npc:273017} beobachtet die {quest:98512}; der tote Kultist liegt direkt nördlich von ihm.",
	-- ["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "Rudelkrallen und Windschreiter streifen durch das Grasland südlich des Dorfes. Windschreiter lassen sowohl die Eier als auch das Fleisch fallen.",
	-- ["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "Sammle Valennia, {npc:251968} (westlich der Stadt) und {npc:252475}",
	-- ["Rorian: {quest:92485}"] = "Rorian: {quest:92485}",
	-- ["Skycutter to {area:279}"] = "Himmelssegler nach {area:279}",
	-- ["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "Sprich mit {npc:251903} und {npc:254089}, nordwestlich des Dorfes",
	-- ["Stand with {npc:252800} against {npc:252863}"] = "Kämpfe an {npc:252800}s Seite gegen {npc:252863}",
	-- ["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "Nimm die Straße nach Südosten. {npc:257006} und {npc:252448} stehen an der Straße westlich von {area:16638}; Windweisenkriecher säumen weiter westlich das Ufer, bei 51,70.",
	-- ["The Highlands bandits"] = "Die Hochlandbanditen",
	-- ["The Novice Seers practise in the clearing west of Shen'dar."] = "Die Sehernovizen üben auf der Lichtung westlich von Shen'dar.",
	-- ["The Windfield farm"] = "Der Hof der Windfields",
	-- ["The hippogryph roost"] = "Der Hippogryphenhorst",
	-- ["The refugees' camp"] = "Das Flüchtlingslager",
	-- ["The skycutter"] = "Der Himmelssegler",
	-- ["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "Der Himmelssegler legt am Turm südlich von {area:16638} ab. Er landet beim Lager der Kirin Tor am Seeufer westlich von {area:279}.",
	-- ["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "Der {object:581822} liegt am Weg westlich von {area:16638}; Fillions Lager ist nordwestlich davon, und die Kreischlingmatriarchinnen nisten direkt westlich des Lagers.",
	-- ["Use {spell:1259416}"] = "Benutze {spell:1259416}",
	-- ["Vuldren and Cirrusflies"] = "Vuldren und Zirrusfliegen",
	-- ["Windshaper Novice Seers"] = "Sehernovizen der Windformer",
	-- ["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668}: am Windschrein südlich von {quest:92529}",
	-- ["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993}: {npc:257196}, westlich des Zugangs zum Schrein",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363} hält östlich des Hains Wache. {npc:251143} und Konvertiten der Al'Aketh sammeln sich direkt nördlich von ihr; {object:460002} erhebt sich weiter nördlich: Wirk dort deine Volksfähigkeit zum Lesen von Leylinien.",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363} hält östlich des Hains Wache. {npc:251143} und Konvertiten der Al'Aketh sammeln sich direkt nördlich von ihr; die Leylinie erhebt sich weiter nördlich: Wirk dort deine Volksfähigkeit {spell:1259705}.",
	-- ["{npc:250926} and {npc:251115}"] = "{npc:250926} und {npc:251115}",
	-- ["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926} streifen durch den Wald direkt westlich des Hains; die Urseraplünderer hausen weiter westlich, mit {npc:251115}, der Matriarchin, hinten im Bau.",
	-- ["{npc:251913}, beside her: Camping 101, blacksmiths"] = "{npc:251913}, neben ihr: Camping 101, Schmiede",
	-- ["{npc:251991}: Camping 101, tailors"] = "{npc:251991}: Camping 101, Schneider",
	-- ["{npc:251992}, on the south edge of the village: Camping 101, fishers"] = "{npc:251992}, am Südrand des Dorfes: Camping 101, Angler",
	-- ["{npc:251993}: Camping 101, leatherworkers"] = "{npc:251993}: Camping 101, Lederer",
	-- ["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095} lagert südlich des Urserabaus. Die Schläger der Al'Aketh halten das Lager südwestlich von ihr; {npc:256935} steht in der Mitte.",
	-- ["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377}: {npc:257196} wartet am {area:16629}",
	-- ["{npc:253590}, in the sanctum"] = "{npc:253590}, im Sanktum",
	-- ["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}, {npc:258130} und {npc:258134} sind nordöstlich von {npc:257944}; {npc:253622} steht östlich von ihnen. Haalien lässt auch ein {quest:94490} fallen.",
	-- ["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588}: Zähme ihn mit der {item:15908}",
	-- ["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853} wartet an den Wasserfällen nordöstlich von {area:16638}. {npc:258443} streift im Gebiet {area:16623} westlich von {area:16638} umher, an der Straße, die du als Nächstes nimmst.",
	-- ["{npc:257018}, at the south side of the village: Camping 101, {skill:129}"] = "{npc:257018}, auf der Südseite des Dorfes: Camping 101, {skill:129}",
	-- ["{npc:257019}, west of {npc:251905}: Camping 101, alchemists"] = "{npc:257019}, westlich von {npc:251905}: Camping 101, Alchemisten",
	-- ["{npc:257020}: Camping 101, enchanters"] = "{npc:257020}: Camping 101, Verzauberer",
	-- ["{npc:257022}, beside her: Camping 101, miners"] = "{npc:257022}, neben ihr: Camping 101, Bergleute",
	-- ["{npc:257024}: Camping 101, skinners"] = "{npc:257024}: Camping 101, Kürschner",
	-- ["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065} wartet am Eingang von {quest:92529}, südlich von Shen'dar. Mit {spell:1254832} kannst du dich unter die Gläubigen mischen.",
	-- ["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084} steht neben dem Portal der Himmelsgeborenen, wo der Zeppelin landet. Das Portal bringt dich nach {zone:1453}.",
	-- ["{npc:263664}, alchemists: for {npc:257019}"] = "{npc:263664}, Alchemisten: für {npc:257019}",
	-- ["{npc:263664}, blacksmiths: for {npc:251913}"] = "{npc:263664}, Schmiede: für {npc:251913}",
	-- ["{npc:263664}, enchanters: for {npc:257020}"] = "{npc:263664}, Verzauberer: für {npc:257020}",
	-- ["{npc:263664}, fishers: for {npc:251992}"] = "{npc:263664}, Angler: für {npc:251992}",
	-- ["{npc:263664}, leatherworkers: for {npc:251993}"] = "{npc:263664}, Lederer: für {npc:251993}",
	-- ["{npc:263664}, miners: for {npc:257022}"] = "{npc:263664}, Bergleute: für {npc:257022}",
	-- ["{npc:263664}, skinners: for {npc:257024}"] = "{npc:263664}, Kürschner: für {npc:257024}",
	-- ["{npc:263664}, tailors: for {npc:251991}"] = "{npc:263664}, Schneider: für {npc:251991}",
	-- ["{npc:263664}, {skill:129}: for {npc:257018}"] = "{npc:263664}, {skill:129}: für {npc:257018}",
	-- ["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{npc:5504}, der Druidenlehrer von {zone:1453}, lehrt dich {spell:18960}. Der Willkommensgruß von {npc:11802} wartet am Ende von {zone:1439} auf deine Reise für {spell:499}.",
}
