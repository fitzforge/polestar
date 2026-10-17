-- German (deDE): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "Du wachst in {area:16635} auf, im Norden der Insel. {npc:251362} steht am Pfad, {npc:251361} in der Dorfmitte.",

	-- Step 2: Thendal Grove
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "Lästige Zirrusfliegen und {npc:250873} streifen durch den Hain gleich südöstlich des Dorfs.",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "Zurück nach {area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: eine Notiz von deinem Lehrer",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}: Untersuche {item:282418}",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "sprich mit {npc:257554}",

	-- Step 4: The watchtower
	["The watchtower"] = "Der Wachturm",
	-- {spell:1259416} Walk on Air
	["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "Steig auf den Wachturm im Dorf, spring von oben und benutze {spell:1259416}, um hinabzuschweben.",

	-- Step 5: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "{npc:251361}s Besorgungen",

	-- Step 6: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "Rohe Windsteine",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "Die Rohen Windsteine sind blaue Kristalle an den Hängen rund ums Dorf.",

	-- Step 8: The standing stones
	["The standing stones"] = "Die Menhire",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363} steht bei {area:17678}, östlich des Dorfs. {npc:251143} und Konvertiten der Al'Aketh sammeln sich gleich nördlich von ihr. {object:460001} ist gleich nordöstlich von ihr: Wirk daneben deine Volksfähigkeit {spell:1259686}.",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "Wirke {spell:1259686} nahe {object:460001}",

	-- Step 9: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "Die Königin schwebt am Südostende des Hains, auf deinem Rückweg von den Steinen.",

	-- Step 10: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "Abgaben in {area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: Lies {item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, im Wachturm",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, im Wachturm",
	-- {npc:251374} Windshaper Boro
	["{npc:251374}, at the village centre"] = "{npc:251374}, in der Dorfmitte",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, der Druidenlehrer, im Erdgeschoss des Baums hinter {npc:251361}",

	-- Step 11: Windshaper Boro
	-- {npc:251374} Windshaper Boro
	["{npc:251374} stands in the village."] = "{npc:251374} steht im Dorf.",

	-- Step 12: Scrawny Ursera
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "{npc:250926} streifen über die Hänge südwestlich des Dorfs, auf dem Weg zu {npc:252095}.",

	-- Step 13: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095} wartet in {area:16622}, südwestlich des Dorfs. Das Lager der Al'Aketh liegt gleich hinter ihr; {npc:256935} führt es an.",

	-- Step 14: Signet of Akir
	-- {npc:252095} Hanaa Nightwind
	["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "Die Kultisten der Al'Aketh im Lager hinter {npc:252095} tragen das Siegel.",

	-- Step 15: Urs'anah
	-- {npc:251115} Urs'anah
	["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "Der Bau der Ursera liegt westlich des Dorfs. {npc:251115}, ihre Matriarchin, sitzt an seinem hinteren Ende.",

	-- Step 16: Leaving Thendal Village
	-- {area:16635} Thendal Village
	["Leaving {area:16635}"] = "Abschied von {area:16635}",

	-- Step 17: Call of Earth
	-- {npc:251374} Windshaper Boro · {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374} schickt dich zur {area:16988}, gleich östlich des Dorfs: Trink dort {item:6635}, um {npc:251166} zu sehen, und bring dann {item:6656} zu ihm zurück.",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}: {npc:5873} und dein {item:5175}",

	-- Step 18: Shen'dar Village
	-- {area:16624} Shen'dar Village
	["Follow the road south to {area:16624}, in the middle of the isle."] = "Folge der Straße nach Süden nach {area:16624}, in der Mitte der Insel.",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "sprich mit {npc:251902}",

	-- Step 19: Raan Wildwind's campfire
	-- {npc:263664} Raan Wildwind
	["{npc:263664}'s campfire"] = "{npc:263664}s Lagerfeuer",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest · {npc:251905} Zerril Softbreeze
	["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "Setz dich an {npc:263664}s Lagerfeuer (tippe /sit), bis du den Buff {spell:1229451} bekommst, und such dann {npc:251905} am Kochfeuer.",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "/sit an {npc:263664}s Lagerfeuer, bis du {spell:1229451} bekommst",
	-- {npc:251905} Zerril Softbreeze
	["talk to {npc:251905}"] = "sprich mit {npc:251905}",

	-- Step 20: Welcome to Shen'dar Village
	-- {npc:251902} Illaya Amberwind
	["Talk to {npc:251902}"] = "Sprich mit {npc:251902}",
	-- {npc:254089} Coriella Calmbreeze
	["Talk to {npc:254089}"] = "Sprich mit {npc:254089}",
	["the bounty board"] = "das Kopfgeldbrett",

	-- Step 21: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Rudelkrallen und Windschreiter",
	-- {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "Rudelkrallen und Windschreiter teilen sich die Wiesen südlich des Dorfs. Behalte {item:5469} für {npc:251905}; die Eier kommen später von den Hippogryphen.",

	-- Step 22: High Order Apprentices
	-- plural, as words: High Order Apprentices = {npc:257521} High Order Apprentice
	["High Order Apprentices"] = "Lehrlinge des Hohen Ordens",
	["The apprentices practise north-east of the village."] = "Die Lehrlinge üben nordöstlich des Dorfs.",

	-- Step 23: The highland bandits
	["The highland bandits"] = "Die Hochlandbanditen",
	["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Die Banditenlager liegen nordöstlich des Dorfs; \"Übelwind\" Bennic hält das oberste Lager. Banditen tragen die gestohlenen Windsteine.",

	-- Step 24: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "Abgaben in {area:16624}",

	-- Step 25: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} lauert südlich des Dorfs zwischen den Rudelkrallen. {npc:254589} ist Elite: Such dir am besten eine Gruppe.",

	-- Step 26: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529} liegt südlich von Shen'dar. {npc:257065} trifft dich an seinem Rand; durchsuch den Kleiderschrank im Haus hinter ihm.",
	["search the wardrobe"] = "durchsuch den Kleiderschrank",

	-- Step 27: Constable Aonda
	-- {area:16624} Shen'dar Village
	["Back to {area:16624} with what you found."] = "Zurück nach {area:16624} mit dem, was du gefunden hast.",

	-- Step 28: Havoc in the Highlands
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "Zurück in {quest:92529}: Sturmrufer und {npc:251662} füllen das Dorf, die Vorratskisten stehen zwischen den Häusern und {npc:251966} wartet an seinem Südostende.",

	-- Step 29: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "Geh nach Südwesten zum {area:17674}. {npc:252155} ist oben; {item:254871} liegt neben ihm.",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "sprich mit {npc:252155}",

	-- Step 30: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "Aanders und die gefallenen Wachen liegen gleich südwestlich des Turms. Nimm Raanis Glücksfeder und das Schattensang-Familiensiegel von den Leichen.",

	-- Step 31: Hippogryph nests
	["Hippogryph nests"] = "Hippogryphennester",
	-- {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	-- plural, as words: Small Eggs = {item:6889} Small Egg
	["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "Die Hippogryphennester liegen nordwestlich des Turms, westlich von {quest:92529}; die Matriarchin sitzt am westlichen Ende. {item:263493} liegt um sie herum auf dem Boden, und die Hippogryphen lassen die Kleinen Eier fallen.",

	-- Step 32: Shen'dar Village, last time
	-- {area:16624} Shen'dar Village
	["{area:16624}, last time"] = "{area:16624}, ein letztes Mal",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "Geh nach Norden nach {area:16624}; erledige unterwegs an den Windschreitern das restliche {item:5469}, falls dir welches fehlt.",

	-- Step 33: To Valanaar
	-- {area:16638} Valanaar · {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "Nimm die Straße nach Südosten nach {area:16638}, der Stadt der Himmelsgeborenen an der Südküste. {npc:257006} und {npc:252448} stehen an ihrem Westrand.",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Hör dir die Geschichte von {npc:252448} an",

	-- Step 34: Windsong Crawlers
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers"] = "Windweisenkriecher",
	["The crawlers scuttle along the shore south-west of town."] = "Die Kriecher krabbeln am Ufer südwestlich der Stadt entlang.",

	-- Step 36: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Himmelshüpfer",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "Himmelshüpfer hüpfen über die Felder gleich westlich von Valennia.",

	-- Step 37: Ayessa Dawnsinger
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "sprich mit {npc:251968}",

	-- Step 38: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083} steht in {area:16626} gleich nordwestlich der Stadt.",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "Hör {npc:256083} zu",

	-- Step 39: Wind Hollows and Construct Parts
	-- {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows and {object:616467}"] = "Windhüllen und {object:616467}",
	-- {area:16638} Valanaar · {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "Windhüllen treiben über das Tiefland um {area:16638}. Die ersten {object:616467} liegen westlich der Obstgartenstraße.",

	-- Step 41: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663} liegt westlich von {area:16638} an der Küstenstraße.",
	-- {npc:252800} Aamelia Windfield
	["Talk to {npc:252800}"] = "Sprich mit {npc:252800}",

	-- Step 42: The orchard
	["The orchard"] = "Der Obstgarten",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "Sturmäpfel und Flatterfliegenstaub liegen überall im Obstgarten; Hungrige Banditen plündern ihn. Windschreiter grasen auf den Feldern östlich davon. Das kaputte Konstrukt schwebt am Nordrand des Obstgartens.",

	-- Step 44: Bandit Highwaymen
	["Bandit Highwaymen"] = "Banditenstraßenräuber",
	-- {object:616468} Construct Parts · {area:16638} Valanaar
	["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "Die Straßenräuber halten die Hügel nordöstlich des Obstgartens. Weitere {object:616468} liegen nahe der Straße nach {area:16638}.",

	-- Step 45: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Sag {npc:252800}, dass du bereit bist",

	-- Step 46: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448} und {npc:256083}",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {item:15908} Taming Rod · {npc:254588} Windsong Crawler · {npc:251707} Ornery Galestrider · {npc:250874} Vuldren Alpha · {area:16663} Windfield Orchard · {npc:254411} Quel'dora Quickgale
	["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{npc:252389} in {area:16638} gibt dir dreimal {item:15908}: Zähm {npc:254588} an den Seen nordwestlich der Stadt, {npc:251707} auf den Feldern westlich der Stadt und {npc:250874} bei {area:16663}, und kehr nach jedem zu ihr zurück. {npc:254411} steht neben ihr.",

	-- Step 48: Belathaan Brightwish
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247} wartet auf der Straße nördlich von {area:16638}, Richtung {area:16629}.",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359} steht auf der Ostseite von {area:16638}.",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Reite nach Nordosten zum {area:17675}. Das Lager der Al'Aketh liegt gleich westlich davon, mit {npc:252666} an seinem Nordende. Jeder Kultist kann ein Windsteinamulett der Al'Aketh fallen lassen.",

	-- Step 52: Urs'endris
	-- {npc:255853} Urs'endris
	["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853} wartet an den Fällen gleich nördlich des Wachturms.",

	-- Step 53: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "Zurück nach {area:16638}",

	-- Step 54: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377} steht mitten in {area:16638}.",

	-- Step 55: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382} steht auf der Westseite von {area:16638}.",

	-- Step 56: The turncoat
	["The turncoat"] = "Der Überläufer",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "Das Haus des Überläufers ist in {area:16626} nordwestlich von {area:16638}. {npc:273017} wartet in der Nähe; seine Attentäter lauern ums Haus.",
	["search the dead cultist in the house"] = "durchsuch den toten Kultisten im Haus",

	-- Step 57: Ur'endra
	-- {npc:258443} Ur'endra
	["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443} streift über die Hänge gleich südlich des Hauses des Überläufers.",

	-- Step 58: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "Bring die Fackel der schlafenden Flamme zu {npc:268592} am Schrein der Flammen, südwestlich von {area:16638} in {area:16626}.",

	-- Step 59: Skypriest Faladiel
	-- {area:16638} Valanaar
	["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Faladiel steht auf dem Hügel westlich der Fälle, nördlich von {area:16638}.",

	-- Step 60: Kuramaa
	-- {npc:268592} Olariaan Swiftburn · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Zurück zu {npc:268592}, dann nach Westen in {area:16623}: {npc:268605}s Zuhause ist in den Hügeln südlich der Seen der Windweisenkriecher.",

	-- Step 61: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "Zurück zu {npc:268592}. Warte, bis er {npc:268762} entzündet, und trag die Flamme dann direkt zu {npc:268679} neben {npc:252382} in {area:16638}, bevor der Timer abläuft.",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}: {npc:2523}, dein {item:5176} und {item:263412}",

	-- Step 62: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "sprich mit {npc:252476}",

	-- Step 63: Desperate Times
	-- {npc:252383} Valennia Stormfist
	["Talk to {npc:252383}"] = "Sprich mit {npc:252383}",
	-- {npc:251968} Ayessa Dawnsinger
	["Talk to {npc:251968}"] = "Sprich mit {npc:251968}",
	-- {npc:252383} Valennia Stormfist
	["talk to {npc:252383}"] = "sprich mit {npc:252383}",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris
	["On the way north, back to {npc:255853} by the falls."] = "Auf dem Weg nach Norden zurück zu {npc:255853} an den Fällen.",

	-- Step 65: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629} liegt nördlich von {area:16638}. Kämpf dich durch die Wachen hinauf zu {npc:253576} auf seiner Ostseite.",
	-- {npc:253576} Hyusaa Quickbreeze
	["Talk to {npc:253576}"] = "Sprich mit {npc:253576}",

	-- Step 66: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196} hält {item:263993} auf der Westseite des Schreins.",

	-- Step 67: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "Geh nach Norden in {area:16631}; {npc:257944} lagert an seinem Südrand.",

	-- Step 68: Shadowgale Forest
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105} wächst um {npc:257944}s Lager, und Kreischlinge fliegen darüber. Das Lager der Al'Aketh östlich von ihr enthält {item:265141}.",

	-- Step 69: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "Wieder {npc:257944}",

	-- Step 70: The Al'Aketh camp
	["The Al'Aketh camp"] = "Das Lager der Al'Aketh",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}, {npc:258130} und {npc:258134} sind im Kultlager östlich von {npc:257944}. {npc:254151} steht an seinem Rand. Haalien lässt auch {quest:94490} fallen: Lies ihn, um die nächste Quest zu starten. Für {quest:94489} betrittst du den Nachtfangbau, heilst 7 verletzte Druiden und findest {npc:258130}.",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Finde {npc:258130}",
	["Heal the injured druids in the Nightfang Den"] = "Heile die verletzten Druiden im Nachtfangbau",

	-- Step 71: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "{npc:257944}, ein letztes Mal",

	-- Step 72: Windsong Lake
	-- {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "Die Habseligkeiten der Flüchtlinge liegen am Nordufer von {area:16625}; {npc:259013} ist an seinem Nordwestende.",

	-- Step 73: The Strange Hermit
	-- {area:16625} Windsong Lake · {item:257128} Zephyrseed
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "Der Einsiedler lebt am Westufer von {area:16625}. Zapfen der {item:257128} wachsen südlich von ihm; die Windhüllen treiben östlich des Sees.",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "sprich mit {npc:251684}",

	-- Step 74: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {npc:251968} Ayessa Dawnsinger
	["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "Nimm das Portal hinauf zu {area:16630} und schließ dich {npc:252475} und {npc:251968} gegen die Hohepriesterin an.",

	-- Step 77: The airship
	["The airship"] = "Das Luftschiff",
	-- {area:16638} Valanaar · {zone:1412} Mulgore
	["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "Das Luftschiff der Horde legt am Südwestrand von {area:16638} an. Fahr damit nach Kalimdor; es landet im Norden von {zone:1412}.",
	["Horde airship"] = "Luftschiff der Horde",

	-- Step 78: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "Nördliches {zone:1412}",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "Du verlässt die Insel endgültig. {npc:259119} wartet, wo das Luftschiff landet.",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}: Behalte sie, Thrall in {zone:1454} kommt zwei Guides später",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}, bei der Landestelle: für {npc:3033} in {zone:1456}",

	-- Step 79: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638} liegt neben der Landestelle: Fahr mit einem Aufzug hinauf und hol dir die Flugroute bei {npc:2995}, dem Windreitermeister.",

	-- Step 80: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} will Taurenweihrauch: Kauf seine vier Teile bei {npc:3014}, der Kräuterhändlerin, {npc:3012}, der Händlerin für Verzauberkunstbedarf, {npc:3005}, dem Händler für Lederverarbeitungsbedarf, und {npc:3027}, dem Händler für Kochbedarf, und kombiniere sie dann zu {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, von {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, von {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, von {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, von {npc:3027}",

	-- Step 81: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Benutze {item:278078} an der Zeremonienmatte und dem Räuchergefäß an der Südklippe der {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Verstreu {item:278078} von der {area:1641}",

	-- Step 83: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033} bildet Druiden auf der {area:1639} aus. Er lehrt dich {spell:18960}; der Willkommensgruß von {npc:11802} wartet etwa mit 23 auf deine Reise für {spell:499} (forever/horde/04-the-barrens).",

	-- Step 84: The Crossroads
	-- {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {zone:1413} Barrens · {area:458} Gold Road · {area:380} The Crossroads
	["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Verlass {zone:1456} mit einem Aufzug und folge der Straße nach Süden an {area:222} vorbei und durch den östlichen Pass ins {zone:1413}; nimm vom Pass aus die {area:458} nach Norden nach {area:380}, der Hordestadt mitten im {zone:1413}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, der Windreitermeister",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Kuramaa"] = "Kuramaa",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Verlass {zone:1456} mit einem Aufzug und folge der Straße nach Süden an {area:222} vorbei und durch den östlichen Pass ins {zone:1413}; nimm vom Pass aus die {area:458} nach Norden nach {area:380}, der Hordestadt mitten im {zone:1413}.",
	-- ["Rorian: {quest:92485}"] = "Rorian: {quest:92485}",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "Die Straßenräuber halten die Hügel nordöstlich des Obstgartens. Weitere {object:616466} liegen nahe der Straße nach {area:16638}.",
	-- ["Wind Hollows and {object:616466}"] = "Windhüllen und {object:616466}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "Windhüllen treiben über das Tiefland um {area:16638}. Die ersten {object:616466} liegen westlich der Obstgartenstraße.",
}
