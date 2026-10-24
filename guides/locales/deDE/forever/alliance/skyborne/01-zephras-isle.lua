-- German (deDE): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "Du erwachst im {area:16622}. {npc:251362} steht neben dir; {npc:251361} ist ein paar Schritte westlich, {npc:251368} am Südrand des Hains.",

	-- Step 2: Vuldren and Cirrusflies
	["Vuldren and Cirrusflies"] = "Vuldren und Zirrusfliegen",
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
	-- {spell:1259416} Walk on Air · {npc:251361} Rorian the Dayseeker
	["Jump off the top of the watchtower and use {spell:1259416} to float down to {npc:251361}, west of the tower."] = "Spring von der Spitze des Wachturms und benutze {spell:1259416}, um zu {npc:251361} westlich des Turms hinabzuschweben.",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: die {item:4100}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, im Wachturm",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: eine Notiz von deinem Lehrer",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: Lies die {item:9547}",
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

	-- Step 6: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363} hält östlich des Hains Wache. {npc:251143} und Konvertiten der Al'Aketh sammeln sich direkt nördlich von ihr; die Leylinie erhebt sich weiter nördlich: Wirk dort deine Volksfähigkeit {spell:1259705}.",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "Wirk {spell:1259705} auf die Leylinie",

	-- Step 7: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "{area:16622}: Quests abgeben",
	["Level 4 spells"] = "Zauber der Stufe 4",

	-- Step 8: Scrawny Ursera and Urs'anah
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	["{npc:250926} and {npc:251115}"] = "{npc:250926} und {npc:251115}",
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926} streifen durch den Wald direkt westlich des Hains; die Urseraplünderer hausen weiter westlich, mit {npc:251115}, der Matriarchin, hinten im Bau.",

	-- Step 9: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095} lagert südlich des Urserabaus. Die Schläger der Al'Aketh halten das Lager südwestlich von ihr; {npc:256935} steht in der Mitte.",

	-- Step 10: Aetheen of the Gales
	["Level 6 spells"] = "Zauber der Stufe 6",

	-- Step 11: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "Folge der Straße nach Süden nach {area:16624}. {npc:263664} lagert am Feuer westlich des Dorfes; {npc:251523} und {npc:251903} stehen in der Dorfmitte.",
	-- {npc:251903} Rathiril Sunlance · {npc:254089} Coriella Calmbreeze
	["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "Sprich mit {npc:251903} und {npc:254089}, nordwestlich des Dorfes",

	-- Step 12: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "/sit an {npc:263664}s Lagerfeuer, bis du {spell:1229451} bekommst",

	-- Step 13: Village quests
	["Village quests"] = "Dorfquests",
	["The bounty board"] = "Das Kopfgeldbrett",

	-- Step 14: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Rudelkrallen und Windschreiter",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "Rudelkrallen und Windschreiter streifen durch das Grasland südlich des Dorfes. Windschreiter lassen sowohl die Eier als auch das Fleisch fallen.",

	-- Step 15: Back to Shen'dar
	["Back to Shen'dar"] = "Zurück nach Shen'dar",

	-- Step 16: The Highlands bandits
	["The Highlands bandits"] = "Die Hochlandbanditen",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "Die Hochlandbanditen lagern nordöstlich des Dorfes. „Übelwind“ Bennic wartet am äußersten Nordende ihres Lagers.",

	-- Step 17: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "Shen'dar: Quests abgeben",

	-- Step 18: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065} wartet am Eingang von {quest:92529}, südlich von Shen'dar. Mit {spell:1254832} kannst du dich unter die Gläubigen mischen.",
	["Search the wardrobe"] = "Durchsuche den Kleiderschrank",

	-- Step 20: Havoc in Falaath
	["Havoc in Falaath"] = "Chaos in Falaath",
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "Zurück in {quest:92529}: Sturmrufer der Al'Aketh und {npc:251662} füllen das Dorf, die Sturmrufer tragen die gestohlenen Vorräte, und {npc:251966} steht am Südende.",

	-- Step 21: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155} hält die westliche Wacht, südwestlich von Falaath. {npc:256966} und die gefallenen Wachen liegen direkt südlich von ihr.",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "Die {item:254871}",

	-- Step 22: The hippogryph roost
	["The hippogryph roost"] = "Der Hippogryphenhorst",
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "Geh nach Nordwesten zu den Hippogryphennestern an den westlichen Klippen. {item:263493} liegen rund um die Nester; die Hippogryphenmatriarchin patrouilliert zwischen ihnen.",

	-- Step 23: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} lauert auf dem Rückweg in den Hügeln südwestlich des Dorfes. {npc:254589} ist Elite: Eine Gruppe wird empfohlen.",

	-- Step 24: Windshaper Novice Seers
	-- plural, as words: Windshaper Novice Seers = {npc:257532} Windshaper Novice Seer
	["Windshaper Novice Seers"] = "Sehernovizen der Windformer",
	["The Novice Seers practise in the clearing west of Shen'dar."] = "Die Sehernovizen üben auf der Lichtung westlich von Shen'dar.",

	-- Step 25: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "Wieder nach {area:16624}",

	-- Step 26: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "Die Straße nach {area:16638}",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "Nimm die Straße nach Südosten. {npc:257006} und {npc:252448} stehen an der Straße westlich von {area:16638}; Windweisenkriecher säumen weiter westlich das Ufer, bei 51,70.",

	-- Step 27: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383} und {npc:252476} stehen am Nordende von {area:16638}, {npc:252475} und {npc:253204} am Südende.",

	-- Step 28: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Himmelshüpfer",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "Himmelshüpfer schwärmen über die Felder westlich von {area:16638}.",

	-- Step 29: The missing scholar
	["The missing scholar"] = "Der vermisste Gelehrte",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "Der {object:581822} liegt am Weg westlich von {area:16638}; Fillions Lager ist nordwestlich davon, und die Kreischlingmatriarchinnen nisten direkt westlich des Lagers.",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "Der {object:581822}",
	["Find Fillion and his bedroll"] = "Finde Fillion und seine Deckenrolle",

	-- Step 30: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800} bewirtschaftet den Hof im südwestlichen Tiefland.",

	-- Step 31: The Windfield farm
	["The Windfield farm"] = "Der Hof der Windfields",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "Reife Sturmäpfel und Hungrige Banditen findest du im Obstgarten beim Hof, {quest:92683} auf den Feldern nordöstlich davon, Störrische Windschreiter überall ringsum. Das {npc:250929} steht auf dem Feld nordöstlich des Hofs.",

	-- Step 32: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "Wieder zu {npc:252800}",

	-- Step 33: Bandit Highwaymen
	["Bandit Highwaymen"] = "Banditenstraßenräuber",
	["The Bandit Highwaymen hold the hills north of the farm."] = "Die Banditenstraßenräuber halten die Hügel nördlich des Hofs.",

	-- Step 34: Standing our ground
	["Standing our ground"] = "Standhalten",
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Sag {npc:252800}, dass du bereit bist",

	-- Step 35: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "{area:16638}: Quests abgeben",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377}: {npc:257196} wartet am {area:16629}",
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "{npc:252373}, der Magierlehrer",

	-- Step 36: Taming the Beast
	-- {item:15908} Taming Rod · {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler · Vuldren Alphas = {npc:250874} Vuldren Alpha · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "Jede Quest von Quel'ana gibt dir eine {item:15908}: Benutze sie am genannten Wildtier und bring die Rute dann zu ihr nach {area:16638} zurück. Windweisenkriecher säumen das Ufer westlich der Stadt; Vuldrenalphas und Störrische Windschreiter streifen im Gebiet {area:16626} rund um den Hof der Windfields. Ihre Schwester {npc:254411} steht neben ihr.",
	-- {npc:254588} Windsong Crawler · {item:15908} Taming Rod
	["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588}: Zähme ihn mit der {item:15908}",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Zähme {npc:254588}",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Zähme es mit der {item:15908}",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Zähme {npc:251707}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Zähme {npc:250874}",

	-- Step 37: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Die Windsteinformationen",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "Die Windsteinformationen stehen auf der Anhöhe westlich von Fillions Lager.",
	-- {item:262668} Wind-Infused Bough · {quest:92529} Falaath Village
	["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668}: am Windschrein südlich von {quest:92529}",

	-- Step 39: The eastern watchtower
	["The eastern watchtower"] = "Der östliche Wachturm",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378} hält den Wachturm nördlich von {area:16638}. Das Lager der Al'Aketh liegt direkt westlich des Turms, die Heiler bei 65,68 und 65,65; {npc:252666} steht am Nordende. Die Al'Aketh dort lassen Windsteinamulette der Al'Aketh fallen.",

	-- Step 40: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}, der Verräter",

	-- Step 41: Urs'endris
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853} wartet an den Wasserfällen nordöstlich von {area:16638}. {npc:258443} streift im Gebiet {area:16623} westlich von {area:16638} umher, an der Straße, die du als Nächstes nimmst.",

	-- Step 42: The dead cultist
	["The dead cultist"] = "Der tote Kultist",
	-- {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "Nordwestlich von Valanaar an der Straße: {npc:273017} beobachtet die {quest:98512}; der tote Kultist liegt direkt nördlich von ihm.",
	["Search the dead cultist"] = "Durchsuche den toten Kultisten",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "{npc:258443}, im Hochland südwestlich des Kultisten",

	-- Step 43: Desperate times
	["Desperate times"] = "Verzweifelte Zeiten",
	-- {npc:251968} Ayessa Dawnsinger · {npc:252475} Elaadrin Evengale
	["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "Sammle Valennia, {npc:251968} (westlich der Stadt) und {npc:252475}",
	["Meet Valennia at the gate"] = "Triff Valennia am Tor",

	-- Step 44: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "Zurück zu {npc:255853} an den Wasserfällen nordöstlich von {area:16638}, auf dem Weg nach Norden zum Schrein.",

	-- Step 45: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "Der {area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "Kämpf dich nach Norden zum {area:16629} durch. Wächter, Geisterrufer und Klingenmeister halten den Zugang; {npc:253576} wartet an der Tür des Schreins, {npc:253590} im inneren Sanktum.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum"] = "{npc:253590}, im Sanktum",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993}: {npc:257196}, westlich des Zugangs zum Schrein",

	-- Step 46: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "Geh nach Norden in den {area:16631}. {npc:257944} lagert im Osten.",

	-- Step 47: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "Sturmjäger und Fußsoldaten der Al'Aketh lagern direkt nördlich von {npc:257944} und lassen das Erbstück fallen; die Schattenwindkreischlinge westlich von ihr lassen die Federn und Krallen fallen; das {item:265105} wächst am Bach westlich von ihr.",

	-- Step 48: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "Wieder zu {npc:257944}",

	-- Step 49: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:254151}, {npc:258130} und {npc:258134} sind nordöstlich von {npc:257944}; {npc:253622} steht östlich von ihnen. Haalien lässt außerdem {quest:94490} fallen. Für {quest:94489} betritt den Nachtfangbau, heile 7 verletzte Druiden und finde {npc:258130}.",
	["Heal the injured druids in the Nightfang Den"] = "Heile die verletzten Druiden im Nachtfangbau",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Finde {npc:258130}",

	-- Step 50: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}, das Schreiben",

	-- Step 51: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159} lebt westlich von {npc:257944}. Die Zephyrzapfen liegen im Wald zwischen seiner Hütte und {npc:257944}.",

	-- Step 52: The refugees' camp
	["The refugees' camp"] = "Das Flüchtlingslager",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "Nördlich der Zapfen: Die Windhüllen treiben um das Flüchtlingslager, die {item:266433} liegt zwischen den Zelten, und {npc:259013} liegt am Nordende.",

	-- Step 53: Back to the Hermit
	["Back to the Hermit"] = "Zurück zum Einsiedler",

	-- Step 54: High Priestess Lorthuna
	-- {area:16629} Shrine of Akir
	["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "Lorthuna wartet am Ostufer der Insel, östlich des {area:16629}.",

	-- Step 55: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}, das Schicksal von Zephras",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475}: {npc:259084} wartet beim Portal der Himmelsgeborenen",

	-- Step 56: The skycutter
	["The skycutter"] = "Der Himmelssegler",
	-- {area:16638} Valanaar · {area:279} Dalaran
	["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "Der Himmelssegler legt am Turm südlich von {area:16638} ab. Er landet beim Lager der Kirin Tor am Seeufer westlich von {area:279}.",
	-- {area:279} Dalaran
	["Skycutter to {area:279}"] = "Himmelssegler nach {area:279}",

	-- Step 57: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084} steht neben dem Portal der Himmelsgeborenen, wo der Zeppelin landet. Das Portal bringt dich nach {zone:1453}.",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:270459}, neben {npc:259084}: für {npc:5504} in {zone:1453}",

	-- Step 58: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "Bolvar Fordragon steht im Thronsaal von {object:2117}, am Nordende der Stadt. Verlass die Stadt dann durch das Haupttor nach {zone:1436}.",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "Für {npc:234} auf der {area:108}",

	-- Step 59: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{npc:5504}, der Druidenlehrer von {zone:1453}, lehrt dich {spell:18960}. Der Willkommensgruß von {npc:11802} wartet am Ende von {zone:1439} auf deine Reise für {spell:499}.",

	-- Step 60: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} steht im Magiersanktum, dem Turm im Gebiet {object:2101}; sie gibt dir ein Fläschchen für den Wasserfall am {quest:1861}.",

	-- Step 61: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Verlass {zone:1453} durch das Haupttor. Der Wasserfall am {quest:1861} liegt südwestlich der Tore, auf dem Weg nach Westen nach {zone:1436}: Fülle {item:7207} an seinem Fuß.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Read Ley Line at the {object:460002}"] = "Lies {object:460002} mit deiner Volksfähigkeit",
	-- ["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "Heile 7 Druiden im Nightfang Den und finde dann {npc:258130}",
	-- ["Rorian: {quest:92485}"] = "Rorian: {quest:92485}",
	-- ["Stand with {npc:252800} against {npc:252863}"] = "Kämpfe an {npc:252800}s Seite gegen {npc:252863}",
	-- ["Use {spell:1259416}"] = "Benutze {spell:1259416}",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363} hält östlich des Hains Wache. {npc:251143} und Konvertiten der Al'Aketh sammeln sich direkt nördlich von ihr; {object:460002} erhebt sich weiter nördlich: Wirk dort deine Volksfähigkeit zum Lesen von Leylinien.",
	-- ["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}, {npc:258130} und {npc:258134} sind nordöstlich von {npc:257944}; {npc:253622} steht östlich von ihnen. Haalien lässt auch ein {quest:94490} fallen.",
}
