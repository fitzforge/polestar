-- German (deDE): the guide forever/reputation/brood-of-nozdormu (forever/reputation/brood-of-nozdormu.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Brood of Nozdormu Reputation"] = "Ruf: Brood of Nozdormu",
	["The Bronze Dragonflight's ring, upgraded at every standing; a long climb from Hated, mostly in raids."] = "Der Ring des Bronzenen Drachenschwarms, bei jedem Ruf aufgewertet; ein langer Weg von Hasserfüllt, meist in Schlachtzügen.",
	-- {item:21175} The Scepter of the Shifting Sands
	["{item:21175} quest chain"] = "Questreihe {item:21175}",

	-- Step 1: Baristolth in Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Baristolth in {area:3425}"] = "Baristolth in {area:3425}",
	-- {faction:910} Brood of Nozdormu · {npc:15192} Anachronos · {npc:15180} Baristolth of the Shifting Sands · {area:3425} Cenarion Hold · {area:2677} Blackwing Lair · {area:16076} Temple of Ahn'Qiraj
	["The {faction:910} is not in your reputation list until you meet {npc:15192}. {npc:15180}, in the main building of {area:3425}, sends you to him. Meeting him sets you at Hated, 0 of 36,000: Neutral is 42,000 reputation away, and almost all of it comes from raids. {area:2677} and the {area:16076} are not among the first raids Blizzard has announced for Forever: until one of them opens, the 100 from Baristolth's first quest is all the Brood reputation there is. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{faction:910} erscheint erst in deiner Rufliste, wenn du {npc:15192} getroffen hast. {npc:15180} im Hauptgebäude von {area:3425} schickt dich zu ihm. Die Begegnung setzt dich auf Hasserfüllt, 0 von 36.000: Neutral ist 42.000 Ruf entfernt, und fast alles davon kommt aus Schlachtzügen. {area:2677} und der {area:16076} gehören nicht zu den ersten Schlachtzügen, die Blizzard für Forever angekündigt hat: Bis einer davon öffnet, sind die 100 aus Baristolths erster Quest der gesamte Ruf beim Brood. Der Vermächtnis-Vorteil „Diplomat“ fügt jedem Gewinn bis zu 10% hinzu; die Zahlen in diesem Guide verstehen sich ohne ihn.",

	-- Step 2: Anachronos at the Caverns of Time
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["{npc:15192} at the {area:2300}"] = "{npc:15192} an den {area:2300}",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["{npc:15192}, a bronze dragon in elf form, stands at the mouth of the {area:2300} in eastern {zone:1446}, south-east of {area:976}. Walk up to him."] = "{npc:15192}, ein bronzener Drache in Elfengestalt, steht am Eingang der {area:2300} im Osten von {zone:1446}, südöstlich von {area:976}. Geh zu ihm.",
	-- {npc:15192} Anachronos
	["Meet {npc:15192}"] = "Triff {npc:15192}",

	-- Step 3: Back to Baristolth
	["Back to Baristolth"] = "Zurück zu Baristolth",
	-- {quest:8288} Only One May Rise · {npc:12017} Broodlord Lashlayer · {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {quest:8286} What Tomorrow Brings
	["{quest:8288} wants the head of {npc:12017}, the third boss of {area:2677} (a 40-player raid in {area:254}). Everything after it needs the head, the fragment turn-ins included: until you have it, {quest:8286} is all the Brood reputation there is, solo or not."] = "{quest:8288} verlangt den Kopf von {npc:12017}, dem dritten Boss von {area:2677} (ein Schlachtzug für 40 Spieler in {area:254}). Alles danach braucht den Kopf, auch die Abgaben der Fragmente: Bis du ihn hast, ist {quest:8286} der gesamte Ruf beim Brood, ob allein oder nicht.",

	-- Step 4: Broodlord Lashlayer
	-- {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {npc:12017} Broodlord Lashlayer
	["{area:2677} is a 40-player raid at the top of {area:254}. {npc:12017} always drops his head."] = "{area:2677} ist ein Schlachtzug für 40 Spieler an der Spitze von {area:254}. {npc:12017} lässt seinen Kopf immer fallen.",
	-- {item:20383} Head of the Broodlord Lashlayer
	["{item:20383}: raid of 40"] = "{item:20383}: Schlachtzug mit 40 Spielern",

	-- Step 5: The Path of the Righteous
	-- {quest:8301} The Path of the Righteous · {area:3425} Cenarion Hold · {area:2743} Hive'Zora · {area:2744} Hive'Regal
	-- plural, as words: Silithid Carapace Fragments = {item:20384} Silithid Carapace Fragment · Hive'Ashi Workers = {npc:11721} Hive'Ashi Worker
	["{quest:8301} wants 200 Silithid Carapace Fragments. Every hive silithid drops one to three on most kills: the Hive'Ashi Workers, Stingers, Swarmers and Defenders north and north-west of {area:3425}, and those of {area:2743} in the west and {area:2744} in the south. Almost all of them are elites of level 57 to 60: one at a time solo, faster in a group."] = "{quest:8301} verlangt 200 Silithid Carapace Fragments. Jeder Stockinsektoid lässt bei den meisten Kills ein bis drei fallen: die Hive'Ashi Workers, Stingers, Swarmers und Defenders nördlich und nordwestlich von {area:3425} und die von {area:2743} im Westen und {area:2744} im Süden. Fast alle sind Elites der Stufen 57 bis 60: allein einer nach dem anderen, in der Gruppe schneller.",

	-- Step 6: Hated to Neutral
	["Hated to Neutral"] = "Von Hasserfüllt bis Neutral",
	-- {quest:8302} The Hand of the Righteous · {area:16076} Temple of Ahn'Qiraj · {item:21230} Ancient Qiraji Artifact · {item:21229} Qiraji Lord's Insignia
	["After The Path, Baristolth takes 200 more fragments for {quest:8302}: 200 reputation, again and again, but only until Neutral. From Hated 500 that is 208 turn-ins, 41,600 fragments, 20,000 to 30,000 elite kills: the only way without the Temple, and a very long one. With the {area:16076} open (a 40-player raid) it is far quicker: every Temple trash mob gives 100 until 2,999 of 3,000 Neutral, about 9,500 a full clear, so four to five clears reach Neutral. Save every {item:21230} and {item:21229} you loot until the trash stops counting: they pay the same later."] = "Nach The Path nimmt Baristolth weitere 200 Fragmente für {quest:8302} an: 200 Ruf, immer wieder, aber nur bis Neutral. Von Hasserfüllt 500 sind das 208 Abgaben, 41.600 Fragmente, 20.000 bis 30.000 Elite-Kills: der einzige Weg ohne den Tempel, und ein sehr langer. Mit offenem {area:16076} (ein Schlachtzug für 40 Spieler) geht es viel schneller: Jeder Trash-Mob im Tempel gibt 100 bis 2.999 von 3.000 Neutral, bei einem vollen Clear etwa 9.500, vier bis fünf Clears reichen also bis Neutral. Behalte jeden {item:21230} und jedes {item:21229}, das du erbeutest, bis der Trash nicht mehr zählt: Sie zahlen später genauso viel.",
	-- {quest:8302} The Hand of the Righteous
	["{quest:8302}: 200 fragments, 200"] = "{quest:8302}: 200 Fragmente, 200",

	-- Step 7: Anachronos's quests
	-- {quest:8303} Anachronos
	["{quest:8303}'s quests"] = "Quests von {quest:8303}",
	-- {quest:8303} Anachronos
	["Neutral opens the rest of the Scepter of the Shifting Sands chain. Baristolth sends you back to {quest:8303}."] = "Neutral schaltet den Rest der Questreihe Scepter of the Shifting Sands frei. Baristolth schickt dich zurück zu {quest:8303}.",

	-- Step 9: The Crystalline Tear
	-- {object:180633} Crystalline Tear
	["The {object:180633}"] = "Die {object:180633}",
	-- {object:180633} Crystalline Tear · {area:3428} Ahn'Qiraj · {zone:1451} Silithus
	["The {object:180633} is a small red crystal on the ground just outside the gates of {area:3428}, in the far south-west of {zone:1451}. Click it, then stay and watch the vision of the War of the Shifting Sands to its end. If it is cut short, abandon the quest and click the Tear again."] = "Die {object:180633} ist ein kleiner roter Kristall am Boden direkt vor den Toren von {area:3428}, im äußersten Südwesten von {zone:1451}. Klicke ihn an und bleibe, um die Vision vom Krieg der Shifting Sands bis zum Ende zu sehen. Wird sie vorzeitig abgebrochen, brich die Quest ab und klicke die Träne erneut an.",
	["Watch the vision"] = "Sieh dir die Vision an",

	-- Step 10: The Charge of the Dragonflights
	-- {npc:15192} Anachronos · {item:21200} Signet Ring of the Bronze Dragonflight · {quest:8555} The Charge of the Dragonflights
	["{npc:15192} now offers the {item:21200} in three kinds: the Path of the Protector (tanks), of the Conqueror (melee fighters) or of the Invoker (casters). Take one: the other two close. Each standing from Friendly to Exalted brings an upgrade of the same ring, 100 reputation each. {quest:8555} sends you after the three shards of the Scepter of the Shifting Sands."] = "{npc:15192} bietet jetzt den {item:21200} in drei Arten an: den Pfad des Beschützers (Tanks), des Eroberers (Nahkämpfer) oder des Beschwörers (Zauberwirker). Nimm einen: Die anderen beiden schließen sich. Jeder Ruf von Freundlich bis Ehrfürchtig bringt eine Aufwertung desselben Rings, je 100 Ruf. {quest:8555} schickt dich nach den drei Splittern des Scepter of the Shifting Sands.",
	["Pick one: The Path of the Protector, the Conqueror or the Invoker, 100"] = "Wähle einen: den Pfad des Beschützers, des Eroberers oder des Beschwörers, 100",

	-- Step 11: The red shard: Vaelastrasz
	["The red shard: Vaelastrasz"] = "Der rote Splitter: Vaelastrasz",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair · {quest:8730} Nefarius's Corruption · {item:21138} Red Scepter Shard
	["The red shard: {npc:13020}, the second boss of {area:2677}, gives {quest:8730} before his fight; Nefarian, the last boss, drops the {item:21138} for one raider on the quest each kill. The quest lasts five hours."] = "Der rote Splitter: {npc:13020}, der zweite Boss von {area:2677}, gibt {quest:8730} vor seinem Kampf; Nefarian, der letzte Boss, lässt bei jedem Kill den {item:21138} für einen Schlachtzügler mit der Quest fallen. Die Quest läuft fünf Stunden.",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair
	["{npc:13020}, {area:2677}: raid of 40"] = "{npc:13020}, {area:2677}: Schlachtzug mit 40 Spielern",
	-- {item:21138} Red Scepter Shard
	["{item:21138}, Nefarian"] = "{item:21138}, Nefarian",

	-- Step 12: The blue shard: Azuregos's ledger
	["The blue shard: Azuregos's ledger"] = "Der blaue Splitter: Azuregos' Logbuch",
	-- {npc:15481} Spirit of Azuregos · {zone:1447} Azshara · {npc:11811} Narain Soothfancy · {zone:1446} Tanaris
	["The {npc:15481} stands on the south coast of {zone:1447}. His ledger starts {npc:11811}'s long chain in {zone:1446}."] = "Der {npc:15481} steht an der Südküste von {zone:1447}. Sein Logbuch beginnt die lange Questreihe von {npc:11811} in {zone:1446}.",

	-- Step 13: Narain Soothfancy
	-- {npc:11811} Narain Soothfancy · {area:976} Gadgetzan · {zone:1421} Silverpine Forest · {zone:1446} Tanaris · {npc:8125} Dirge Quikcleave
	["{npc:11811}, a goblin seer, lives in a hut north-east of {area:976}. He sends you three ways at once: to Stewvul's crate in {zone:1421}, to an island off the south coast of {zone:1446}, and to {npc:8125} in {area:976}."] = "{npc:11811}, ein Goblin-Seher, lebt in einer Hütte nordöstlich von {area:976}. Er schickt dich gleich in drei Richtungen: zu Stewvuls Kiste in {zone:1421}, zu einer Insel vor der Südküste von {zone:1446} und zu {npc:8125} in {area:976}.",

	-- Step 14: Stewvul's crate
	["Stewvul's crate"] = "Stewvuls Kiste",
	-- {object:180642} Inconspicuous Crate · {area:230} Greymane Wall · {zone:1421} Silverpine Forest
	["The {object:180642} leans on the {area:230} at the south end of {zone:1421}, left of the closed gate."] = "Die {object:180642} lehnt an der {area:230} am Südende von {zone:1421}, links vom geschlossenen Tor.",

	-- Step 15: Meridith the Mermaiden
	-- {object:180652} Freshly Dug Dirt · {area:987} Land's End Beach · {npc:15526} Meridith the Mermaiden · {quest:8599} Love Song for Narain
	["The {object:180652} lies on the farther of two islands south of {area:987}, past the fatigue line. {npc:15526}, on the sea floor south of the beach's crashed gyrocopter, gives {quest:8599} and a three-minute swim-speed blessing that gets you across."] = "Die {object:180652} liegt auf der weiter entfernten von zwei Inseln südlich von {area:987}, hinter der Erschöpfungslinie. {npc:15526}, auf dem Meeresboden südlich des abgestürzten Gyrokopters am Strand, gibt {quest:8599} und einen dreiminütigen Segen für Schwimmgeschwindigkeit, der dich hinüberbringt.",

	-- Step 16: The island off Land's End Beach
	-- {area:987} Land's End Beach
	["The island off {area:987}"] = "Die Insel vor {area:987}",

	-- Step 17: Back to Narain Soothfancy
	-- {npc:11811} Narain Soothfancy
	["Back to {npc:11811}"] = "Zurück zu {npc:11811}",
	-- {quest:8606} Decoy! · {npc:11811} Narain Soothfancy · {area:2255} Everlook · {zone:1452} Winterspring · {npc:15554} Number Two
	["{quest:8606} sends you, disguised with {npc:11811}'s turban, to a drop-off point south of {area:2255} in {zone:1452}. Leave the bag of gold there: {npc:15554}, a level 61 elite, comes for it (group of 3 to 5)."] = "{quest:8606} schickt dich, verkleidet mit dem Turban von {npc:11811}, zu einem Übergabepunkt südlich von {area:2255} in {zone:1452}. Lass den Goldbeutel dort liegen: {npc:15554}, eine Elite der Stufe 61, kommt, um ihn zu holen (Gruppe mit 3 bis 5).",

	-- Step 18: Decoy!
	-- {npc:15554} Number Two
	["{npc:15554}, elite: group of 3 to 5"] = "{npc:15554}, Elite: Gruppe mit 3 bis 5",

	-- Step 19: Dirge Quikcleave
	-- {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {area:1121} Isle of Dread · {zone:1444} Feralas
	["{npc:8125} cooks in {area:976}. He sends you to the {area:1121} off southern {zone:1444} for a Chimaerok feast."] = "{npc:8125} kocht in {area:976}. Er schickt dich zur {area:1121} vor dem Süden von {zone:1444} für ein Chimaerok-Festmahl.",

	-- Step 20: The Isle of Dread
	-- {area:1121} Isle of Dread
	["The {area:1121}"] = "Die {area:1121}",
	-- {npc:12803} Lord Lakmaeran · {area:1121} Isle of Dread
	["{npc:12803} and the Chimaerok on the {area:1121} are elites of level 60 to 62 that respawn every ten minutes: a raid's work. The Chimaerok drop a tenderloin about half the time, Lakmaeran two to four now and then."] = "{npc:12803} und die Chimaerok auf der {area:1121} sind Elites der Stufen 60 bis 62, die alle zehn Minuten wieder erscheinen: Arbeit für einen Schlachtzug. Die Chimaerok lassen etwa bei jedem zweiten Mal ein Lendenstück fallen, Lakmaeran ab und zu zwei bis vier.",
	-- {item:21027} Lakmaeran's Carcass · {npc:12803} Lord Lakmaeran
	["{item:21027}, {npc:12803}: raid"] = "{item:21027}, {npc:12803}: Schlachtzug",

	-- Step 21: Draconic for Dummies, Volume II
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}, Volume II"] = "{quest:8597}, Band II",
	-- {quest:8620} The Only Prescription · {quest:8597} Draconic for Dummies · {npc:15552} Doctor Weavil · {area:2079} Alcaz Island · {zone:1419} Blasted Lands · {area:2255} Everlook · {zone:1458} Undercity · {npc:11811} Narain Soothfancy
	-- plural, as words: Felguard Elites = {npc:8717} Felguard Elite · Doomguard Commanders = {npc:12396} Doomguard Commander
	["{quest:8620} needs the eight chapters of {quest:8597}, Volume II: from {npc:15552} in his house on {area:2079} (a level 63 elite with guards, raid), the Felguard Elites, Doomguard Commanders and Dreadlords of the {zone:1419}, the Hederine south of {area:2255}, and a book in the {zone:1458}. {npc:11811} hands out the binding when you accept."] = "{quest:8620} braucht die acht Kapitel von {quest:8597}, Band II: von {npc:15552} in seinem Haus auf {area:2079} (eine Elite der Stufe 63 mit Wachen, Schlachtzug), den Felguard Elites, Doomguard Commanders und Schreckenslords der {zone:1419}, der Hederine südlich von {area:2255} und einem Buch in der {zone:1458}. {npc:11811} gibt dir beim Annehmen den Einband.",
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}: Volume II"] = "{quest:8597}: Band II",

	-- Step 22: Dirge Quikcleave's Chops
	-- {npc:8125} Dirge Quikcleave
	["{npc:8125}'s Chops"] = "Koteletts von {npc:8125}",
	-- {npc:8125} Dirge Quikcleave · {item:9061} Goblin Rocket Fuel · {item:8150} Deeprock Salt · {npc:11811} Narain Soothfancy · {item:18562} Elementium Ore · {item:21136} Arcanite Buoy · {object:180669} Swirling Maelstrom (no name in this language: may be words) · {zone:1447} Azshara · {area:1227} Bay of Storms · {npc:15571} Maws · {item:21137} Blue Scepter Shard
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar · Azerothian Diamonds = {item:12800} Azerothian Diamond · Blue Sapphires = {item:12361} Blue Sapphire
	["{npc:8125} wants 20 {item:9061} and 20 {item:8150} with the meat. {npc:11811} then wants 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds and 10 Blue Sapphires, and gives you an {item:21136}: placed at the {object:180669} in {zone:1447}'s {area:1227}, it calls up {npc:15571}, a level 63 boss for a raid. {npc:15571} drops the {item:21137} for one raider on the quest each kill."] = "{npc:8125} will 20 {item:9061} und 20 {item:8150} zum Fleisch. {npc:11811} will dann 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds und 10 Blue Sapphires und gibt dir eine {item:21136}: Am {object:180669} in der {area:1227} von {zone:1447} aufgestellt, ruft sie {npc:15571} herbei, einen Boss der Stufe 63 für einen Schlachtzug. {npc:15571} lässt bei jedem Kill den {item:21137} für einen Schlachtzügler mit der Quest fallen.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: Alchemists, or the auction house"] = "{item:12360}: Alchemisten oder das Auktionshaus",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}: {area:2677}, or the auction house"] = "{item:18562}: {area:2677} oder das Auktionshaus",

	-- Step 23: Maws
	-- {item:21137} Blue Scepter Shard · {npc:15571} Maws
	["{item:21137}, {npc:15571}: raid"] = "{item:21137}, {npc:15571}: Schlachtzug",

	-- Step 24: The green shard: Eranikus
	["The green shard: Eranikus"] = "Der grüne Splitter: Eranikus",
	-- {npc:15362} Malfurion Stormrage · {npc:5709} Shade of Eranikus · {area:1477} Temple of Atal'Hakkar · {npc:15624} Forest Wisp · {zone:1457} Darnassus · {npc:11832} Keeper Remulos · {zone:1450} Moonglade
	["{npc:15362} appears beside the {npc:5709} at the bottom of the {area:1477} (a five-player dungeon). He sends you to a {npc:15624} outside {zone:1457} (Horde players walk past the city's guards), then to {npc:11832} in {zone:1450}."] = "{npc:15362} erscheint neben dem {npc:5709} am Grund des {area:1477} (ein Dungeon für fünf Spieler). Er schickt dich zu einem {npc:15624} vor {zone:1457} (Spieler der Horde laufen an den Wachen der Stadt vorbei), dann zu {npc:11832} in {zone:1450}.",
	-- {npc:15362} Malfurion Stormrage · {area:1477} Temple of Atal'Hakkar
	["{npc:15362}, inside the {area:1477}"] = "{npc:15362}, im {area:1477}",

	-- Step 25: The Forest Wisp
	-- {npc:15624} Forest Wisp
	["The {npc:15624}"] = "Der {npc:15624}",
	-- {npc:15624} Forest Wisp
	["{npc:15624}: 25 (and 25 Cenarion Circle)"] = "{npc:15624}: 25 (und 25 Zirkel des Cenarius)",

	-- Step 26: Keeper Remulos
	-- {quest:8735} The Nightmare's Corruption · {zone:1440} Ashenvale · {zone:1444} Feralas · {zone:1425} Hinterlands · {npc:15625} Twilight Corrupter · {zone:1431} Duskwood
	["{quest:8735} wants a fragment from each of the four Dragons of Nightmare portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "{quest:8735} verlangt ein Fragment von jedem der vier Portale der Drachen des Alptraums: Elite-Drachkin an den Portalen in {zone:1440}, {zone:1444} und {zone:1425} (je 5%) und der {npc:15625} in {zone:1431}. Schlachtzug-Inhalt.",
	["10 (and 100 Cenarion Circle)"] = "10 (und 100 Zirkel des Cenarius)",

	-- Step 27: The Ashenvale portal
	-- {zone:1440} Ashenvale
	["The {zone:1440} portal"] = "Das Portal in {zone:1440}",
	["The four dream portals sit in groves guarded by elite dragonkin of level 60 to 62 that respawn every 30 minutes; each drops the portal's fragment one time in twenty. Raid content."] = "Die vier Traumportale liegen in Hainen, die von Elite-Drachkin der Stufen 60 bis 62 bewacht werden und alle 30 Minuten wieder erscheinen; jeder lässt das Fragment des Portals bei einem von zwanzig Kills fallen. Schlachtzug-Inhalt.",

	-- Step 28: The Duskwood portal
	-- {zone:1431} Duskwood
	["The {zone:1431} portal"] = "Das Portal in {zone:1431}",
	-- {npc:15625} Twilight Corrupter
	["The {npc:15625} (level 63 boss) always drops its fragment."] = "Der {npc:15625} (Boss der Stufe 63) lässt sein Fragment immer fallen.",

	-- Step 29: The Feralas portal
	-- {zone:1444} Feralas
	["The {zone:1444} portal"] = "Das Portal in {zone:1444}",

	-- Step 30: Hinterlands portal
	-- {zone:1425} Hinterlands
	["{zone:1425} portal"] = "Portal in {zone:1425}",

	-- Step 31: The Nightmare Manifests
	-- {npc:11832} Keeper Remulos · {area:2361} Nighthaven
	["A raid event: follow {npc:11832} toward {area:2361} and keep him alive against Eranikus and his nightmare adds until Tyrande arrives and redeems Eranikus. Do not kill Eranikus."] = "Ein Schlachtzug-Ereignis: Folge {npc:11832} in Richtung {area:2361} und halte ihn gegen Eranikus und seine Alptraum-Adds am Leben, bis Tyrande eintrifft und Eranikus erlöst. Töte Eranikus nicht.",
	["100 (and 100 Cenarion Circle)"] = "100 (und 100 Zirkel des Cenarius)",
	["The Redemption of Eranikus: raid"] = "The Redemption of Eranikus: Schlachtzug",
	["200 (and 200 Cenarion Circle)"] = "200 (und 200 Zirkel des Cenarius)",

	-- Step 32: The Scepter of the Shifting Sands
	-- {npc:15192} Anachronos · {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj
	["With the three shards, {npc:15192} makes the Scepter of the Shifting Sands. In Classic its first holder rings the {object:180717} once for the whole realm, opening the gates of {area:3428}, and those who finish within ten hours earn the black qiraji crystal mount; whether Forever's realms get that event is not known."] = "Mit den drei Splittern fertigt {npc:15192} das Scepter of the Shifting Sands an. In Classic läutet sein erster Besitzer den {object:180717} einmal für den ganzen Realm und öffnet damit die Tore von {area:3428}; wer innerhalb von zehn Stunden fertig wird, erhält das schwarze Qiraji-Kristall-Reittier. Ob die Realms von Forever dieses Ereignis bekommen, ist nicht bekannt.",

	-- Step 33: Scarab Gong
	-- {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj · {npc:15693} Jonathan the Revelator · {quest:8745} Treasure of the Timeless One
	["{object:180717} hangs before the gates of {area:3428}. {npc:15693} appears beside it once the gong has been rung, with {quest:8745}: a weapon and 200 reputation."] = "Der {object:180717} hängt vor den Toren von {area:3428}. {npc:15693} erscheint daneben, sobald der Gong geläutet wurde, mit {quest:8745}: einer Waffe und 200 Ruf.",

	-- Step 34: Neutral to Friendly in the Temple
	["Neutral to Friendly in the Temple"] = "Von Neutral bis Freundlich im Tempel",
	-- {area:16076} Temple of Ahn'Qiraj · {area:2737} Scarab Wall · {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {area:3454} Ruins of Ahn'Qiraj
	["Neutral to Friendly is 3,000 reputation. Every trash mob of the {area:16076} (a 40-player raid behind the {area:2737}) gives 100, and the Twin Emperors 210 each, until 2,999 of 3,000 Neutral, one point short of Friendly; there they stop. Then hand in one saved {item:21230} (1,000, to {npc:15502}) or {item:21229} (500, to {npc:15503}) to tip you over. The shoulder and boot exchanges of the Temple's tier set need no standing: the token, two idols and ten scarabs to {npc:15502} (shoulders) or {npc:15503} (boots) pay 200 each. The {area:3454} (20 players) give a little from bosses: Kurinnaxx, Moam, Buru and Ayamiss 50 each, Rajaxx 34, Ossirian 100, to Exalted."] = "Von Neutral bis Freundlich sind es 3.000 Ruf. Jeder Trash-Mob im {area:16076} (ein Schlachtzug für 40 Spieler hinter der {area:2737}) gibt 100, die Twin Emperors je 210, bis 2.999 von 3.000 Neutral, einen Punkt vor Freundlich; dort hören sie auf. Gib dann einen aufgesparten {item:21230} (1.000, an {npc:15502}) oder ein {item:21229} (500, an {npc:15503}) ab, um darüberzukommen. Die Schulter- und Stiefeltausche des Tier-Sets des Tempels brauchen keinen Ruf: Die Marke, zwei Idole und zehn Skarabäen an {npc:15502} (Schultern) oder {npc:15503} (Stiefel) zahlen je 200. Die {area:3454} (20 Spieler) geben ein wenig von Bossen: Kurinnaxx, Moam, Buru und Ayamiss je 50, Rajaxx 34, Ossirian 100, bis Ehrfürchtig.",
	-- {item:21229} Qiraji Lord's Insignia
	["{item:21229}, Temple bosses"] = "{item:21229}, Bosse des Tempels",

	-- Step 35: The ring at Friendly
	["The ring at Friendly"] = "Der Ring bei Freundlich",
	-- {npc:15192} Anachronos
	["At Friendly, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "Bei Freundlich wertet {npc:15192} den Ring des Pfades auf, den du gewählt hast: den Pfad des Beschützers, Eroberers oder Beschwörers. Bring den Ring mit, den du trägst; 100 Ruf.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Friendly ring quest of your path"] = "{npc:15192}: die Ring-Quest für Freundlich deines Pfades",

	-- Step 36: Friendly to Honored: the turn-ins
	["Friendly to Honored: the turn-ins"] = "Von Freundlich bis Wohlwollend: die Abgaben",
	-- {item:21230} Ancient Qiraji Artifact · {quest:8784} Secrets of the Qiraji · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {quest:8595} Mortal Champions · {npc:15727} C'Thun
	["Now hand in what you saved. Each {item:21230} (any Temple trash, 1% to 9%) starts {quest:8784}: 1,000 reputation from {npc:15502}, one of the three bronze dragons inside the Temple. Each {item:21229} (nearly every Temple boss) goes to {npc:15503} for {quest:8595}: 500 here and 100 Cenarion Circle. {npc:15727} gives 2,500, to Exalted. Friendly to Honored is 6,000: six artifacts or twelve insignias. Friendly also opens the helm and leg exchanges of the Temple's tier set (200 reputation each) at {npc:15502} and {npc:15503}."] = "Gib jetzt ab, was du aufgespart hast. Jeder {item:21230} (jeder Trash des Tempels, 1% bis 9%) startet {quest:8784}: 1.000 Ruf von {npc:15502}, einem der drei Bronzedrachen im Tempel. Jedes {item:21229} (fast jeder Boss des Tempels) geht an {npc:15503} für {quest:8595}: hier 500 und 100 Zirkel des Cenarius. {npc:15727} gibt 2.500, bis Ehrfürchtig. Von Freundlich bis Wohlwollend sind es 6.000: sechs Artefakte oder zwölf Insignien. Freundlich schaltet außerdem die Helm- und Beintausche des Tier-Sets des Tempels (je 200 Ruf) bei {npc:15502} und {npc:15503} frei.",
	-- {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos
	["{item:21230}: right-click it, then {npc:15502}"] = "{item:21230}: Rechtsklick, dann {npc:15502}",
	-- {quest:8595} Mortal Champions
	["{quest:8595}: 1 insignia, 500"] = "{quest:8595}: 1 Insignie, 500",

	-- Step 37: The ring at Honored
	["The ring at Honored"] = "Der Ring bei Wohlwollend",
	-- {npc:15192} Anachronos
	["At Honored, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "Bei Wohlwollend wertet {npc:15192} den Ring des Pfades auf, den du gewählt hast: den Pfad des Beschützers, Eroberers oder Beschwörers. Bring den Ring mit, den du trägst; 100 Ruf.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Honored ring quest of your path"] = "{npc:15192}: die Ring-Quest für Wohlwollend deines Pfades",

	-- Step 38: Honored to Revered
	["Honored to Revered"] = "Von Wohlwollend bis Respektvoll",
	-- {npc:15727} C'Thun · {quest:8595} Mortal Champions · {quest:8789} Imperial Qiraji Armaments · {npc:15380} Arygos · {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["Honored to Revered is 12,000: twelve artifacts, 24 insignias, or a mix with {npc:15727} (2,500). After the first, each insignia is the repeatable {quest:8595}. Every Temple boss sometimes drops an {quest:8789} or Regalia (about one time in twenty): {npc:15380} and {npc:15378}, inside the Temple once {npc:15727} is dead, take it with 3 {item:18562} for 200 and a weapon. Honored opens the chest exchange of the tier set (200)."] = "Von Wohlwollend bis Respektvoll sind es 12.000: zwölf Artefakte, 24 Insignien oder eine Mischung mit {npc:15727} (2.500). Nach der ersten ist jede Insignie die wiederholbare {quest:8595}. Jeder Boss des Tempels lässt manchmal ein {quest:8789} oder Regalia fallen (etwa bei einem von zwanzig): {npc:15380} und {npc:15378}, im Tempel, sobald {npc:15727} tot ist, nehmen es mit 3 {item:18562} für 200 und eine Waffe an. Wohlwollend schaltet den Brustplatten-Tausch des Tier-Sets frei (200).",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}, {area:2677} or the auction house"] = "{item:18562}, {area:2677} oder das Auktionshaus",
	-- {npc:15380} Arygos · {item:18562} Elementium Ore
	["{npc:15380}: Armaments and 3 {item:18562}, 200"] = "{npc:15380}: Armaments und 3 {item:18562}, 200",
	-- {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["{npc:15378}: Regalia and 3 {item:18562}, 200"] = "{npc:15378}: Regalia und 3 {item:18562}, 200",

	-- Step 39: The ring at Revered
	["The ring at Revered"] = "Der Ring bei Respektvoll",
	-- {npc:15192} Anachronos
	["At Revered, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "Bei Respektvoll wertet {npc:15192} den Ring des Pfades auf, den du gewählt hast: den Pfad des Beschützers, Eroberers oder Beschwörers. Bring den Ring mit, den du trägst; 100 Ruf.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Revered ring quest of your path"] = "{npc:15192}: die Ring-Quest für Respektvoll deines Pfades",

	-- Step 40: Revered to Exalted
	["Revered to Exalted"] = "Von Respektvoll bis Ehrfürchtig",
	-- {npc:15727} C'Thun · {quest:8801} C'Thun's Legacy · {npc:15379} Caelestrasz
	["Revered to Exalted is 21,000: 21 artifacts or 42 insignias, with {npc:15727}'s 2,500 a week. {npc:15727}'s eye starts {quest:8801} for {npc:15379} (200, and 200 Cenarion Circle). At Exalted Anachronos gives the last ring: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000: 21 Artefakte oder 42 Insignien, mit den 2.500 von {npc:15727} pro Woche. Das Auge von {npc:15727} startet {quest:8801} für {npc:15379} (200, und 200 Zirkel des Cenarius). Bei Ehrfürchtig gibt Anachronos den letzten Ring: The Protector of Kalimdor, The Qiraji Conqueror oder The Grand Invoker.",

	-- Step 41: The Exalted ring
	["The Exalted ring"] = "Der Ring bei Ehrfürchtig",
	-- {npc:15192} Anachronos
	["At Exalted, {npc:15192} gives the last ring of your path: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker. Bring the Revered ring; 100 reputation."] = "Bei Ehrfürchtig gibt {npc:15192} den letzten Ring deines Pfades: The Protector of Kalimdor, The Qiraji Conqueror oder The Grand Invoker. Bring den Ring für Respektvoll mit; 100 Ruf.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Exalted ring quest of your path"] = "{npc:15192}: die Ring-Quest für Ehrfürchtig deines Pfades",
}
