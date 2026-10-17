-- German (deDE): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aquatic Form
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {item:15885} Pendant of the Sea Lion · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Nimm das Schiff vom {area:17203} nach {area:442}. Füge die beiden Anhängerhälften zu {item:15885} zusammen und wirke {spell:18960}: {npc:11802} ist in {area:2361}. Flieg dann nach {area:702} (über {area:442}).",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885}: Füge die beiden Hälften zusammen",

	-- Step 2: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine
	["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Nimm das Portal hinauf nach {area:1658} und flieg dann zurück nach {area:442}.",

	-- Step 3: Elune's Grace
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:11401} Priestess Alathea
	["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Nimm das Schiff vom {area:17203} nach {area:442} und flieg nach {area:702}; {npc:11401} ist im Tempel des Mondes. Flieg dann zurück nach {area:442}.",

	-- Step 4: Boat to Auberdine
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "Nimm vom {area:17203} das Schiff nach {area:442}; {npc:3649} steht am Nordende des Dorfes. Reite dann auf der Straße nach Süden durch {zone:1439}.",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}: Alexston's reply"] = "{npc:3649}: Alexstons Antwort",

	-- Step 5: Kerlonian Evershade
	-- {area:448} Grove of the Ancients · {zone:1439} Darkshore · {item:13536} Horn of Awakening · {zone:1440} Ashenvale · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "Kerlonian schläft bei {area:448} im Süden von {zone:1439}. Benutze {item:13536}, um ihn zu wecken, und führe ihn auf der Straße nach Süden nach {zone:1440} zu {npc:11219} bei {area:413}; blas erneut ins Horn, wann immer er einschläft.",
	-- {area:413} Maestra's Post · {zone:1440} Ashenvale
	["Escort Kerlonian to {area:413} in {zone:1440}."] = "Eskortiere Kerlonian zu {area:413} in {zone:1440}.",

	-- Step 7: Bathran's Haunt
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "Nördlich von Maestras Posten liegen Pflanzenbündel um die Ruinen von {area:411}. Kultisten des dunklen Strangs halten die Ruinen gleich südlich davon: Jeder von ihnen kann {item:5366} fallen lassen.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, von den Pflanzenbündeln",

	-- Step 9: Astranaar
	-- {area:415} Astranaar
	["Follow the road south-east to {area:415}, on the island in the lake."] = "Folge der Straße nach Südosten nach {area:415}, auf der Insel im See.",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, im Gasthaus",

	-- Step 10: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Reite nach Westen ans Ufer von {area:441}. Teronis liegt zwischen den Murlocs der Salzflossen; jeder Murloc kann {item:5463} fallen lassen.",

	-- Step 11: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "Südlich der Murlocs wartet {npc:3585} bei {area:416}.",

	-- Step 12: Ilkrud Magthrull
	-- {npc:3664} Ilkrud Magthrull · {area:412} Ruins of Ordil'Aran
	["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} und seine Leerwandler halten {area:412} südlich des Schreins. Lock zuerst seine Wachen.",

	-- Step 13: The Zoram Strand
	-- {area:414} The Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Folge der Küste nach Norden zum {area:414}. {npc:3846} lagert am Strand; Naga der Rächerflossen bevölkern das Ufer.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, in den Ruinen am Ufer",

	-- Step 15: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} The Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} streift mit Wachen der Rächerflossen über die Nordspitze des {area:414}s.",

	-- Step 19: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) führt die Gnolle der Distelfelle im Lager nördlich von {area:415} an. Räum zuerst seine Wachen weg, eine nach der anderen.",

	-- Step 20: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "Die Tränen leuchten auf der kleinen Insel östlich von {area:415}.",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Folge der Straße nach Osten zu {area:419}; {npc:3916} steht am Mondbrunnen.",

	-- Step 23: The Foulweald
	["The Foulweald"] = "Die Fäulnisklauen",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Die Furbolgs der Fäulnisklauen leben in den Wäldern südlich der Straße, südöstlich von {area:415}. Der Höhlenbehüter und die Ursas bewachen die Höhle.",

	-- Step 24: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} steht bei {area:420} am Ostufer von {area:421}; {npc:210995} lagert an dessen Westufer. Beschmutzte Wasserelementare waten im See dazwischen.",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Töte die Elementare für 5 intakte Elementararmschienen und benutze dann {item:5456}",

	-- Step 25: The Ruins of Stardust
	["West of Mystral Lake, the stardust bushes grow among the ruins."] = "Westlich vom Mystralsee wachsen die Sternenstaubbüsche zwischen den Ruinen.",

	-- Step 27: Windshear Crag
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Reite nach Süden an {area:421} vorbei in den Tunnel {area:1276}; er führt im Steinkrallengebirge bei {area:461} heraus. {npc:4080} und {npc:4077} lagern am {area:1076} südwestlich der Klippe.",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, in the hut north of them"] = "{npc:4201}, in der Hütte nördlich von ihnen",

	-- Step 28: Venture Co. loggers
	["Venture Co. loggers"] = "Holzarbeiter der Venture Co.",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "Die Venture Co. rodet den Wald von {area:461}. Holzarbeiter und Roder arbeiten überall; die Maschinenführer steuern die Schredder, und einer trägt die Baupläne.",

	-- Step 29: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} schürft in der {area:2160} am Ostende der Klippe. Sprich mit ihm und wehre die Angreifer der Venture Co. ab, während er schürft.",

	-- Step 31: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "Nach {area:150}",
	-- {area:1276} Talondeep Path
	["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "Ruhestein noch nicht bereit? Reite nach Norden zurück durch {area:1276}.",
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",

	-- Step 32: Menethil Harbor
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, auf dem Pier nördlich des Gasthauses",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, im Gasthaus",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep"] = "{npc:2086}, bei der Burg",
	-- {npc:2097} Harlo Barnaby
	["{npc:2097}, by the north gate"] = "{npc:2097}, beim Nordtor",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the north gate"] = "{npc:2094}, beim Nordtor",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, beim Nordtor",

	-- Step 33: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Holz- und Eisenstapel liegen um die Burg und entlang der Hafenmauern.",

	-- Step 35: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Folge der Küste von Menethil aus nach Norden. Murlocs der Blaukiemen füllen den Sumpf; {npc:1259} zieht mit einer Gruppe mitten hindurch.",

	-- Step 37: The Bluegill hovels
	["The Bluegill hovels"] = "Die Hütten der Blaukiemen",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Drei Behälter in den Murlochütten, von Süden nach Norden: {object:261}, dann {object:142151}, dann {object:259} am Nordende.",

	-- Step 38: Karl Boran
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: für {npc:2104} in der Burg",

	-- Step 39: Captain Stoutfist
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1242} Karl Boran
	["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} steht in {area:2103}, ein kurzes Stück von {npc:1242} entfernt.",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Für Bolvar Fordragon in {object:2117}: behalte sie",

	-- Step 40: Young crocolisks
	["Young crocolisks"] = "Junge Krokilisken",
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Folge der Straße nach Osten. Junge Sumpflandkrokilisken lauern in den Tümpeln nördlich der Ausgrabungsstätte.",

	-- Step 41: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "Die Ausgrabungsstätte liegt auf dem Hügel südlich der Straße.",

	-- Step 42: The raptor hills
	["The raptor hills"] = "Die Raptorenhügel",
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor
	["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Scheckige Raptoren und Scheckige Kreischer streifen durch die Hügel westlich der Ausgrabungsstätte.",

	-- Step 44: Raptor valley
	["Raptor valley"] = "Raptorental",
	["The bigger raptors hunt in the valley just west of the dig."] = "Die größeren Raptoren jagen im Tal gleich westlich der Ausgrabung.",

	-- Step 46: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Höhlenpirscher und Egelpirscher füllen {area:1021}, die Höhle südöstlich der Ausgrabungsstätte.",

	-- Step 47: Black Oozes
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes"] = "Schwarze Brühschlammer",
	-- {area:1025} Green Belt · {npc:2093} Einar Stonegrip · {npc:2111} Sida
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Schwarze Brühschlammer kriechen durch den Sumpf nördlich der Straße durch {area:1025}, westlich von {npc:2093}s Lager. Jeder Schlammer kann den Beutel von {npc:2111} haben.",

	-- Step 48: Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} lagert an der Straße; {npc:1244} steht weiter östlich am Fluss.",

	-- Step 49: The Mosshide gnolls
	["The Mosshide gnolls"] = "Die Gnolle der Moosfelle",
	-- {area:1025} Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Gnolle der Moosfelle und Bastarde der Moosfelle halten die Hügel südöstlich von {area:1025}.",

	-- Step 51: Crude Flint
	-- {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Moorläufer der Moosfelle und Nebelwirker der Moosfelle streifen an den Flussufern gleich westlich und südlich von {npc:1244} umher; fast jeder lässt Feuerstein fallen.",

	-- Step 53: Fen Creepers
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers"] = "Moorkrabbler",
	-- {area:1025} Green Belt
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Moorkrabbler verstecken sich in den Sumpftümpeln nordwestlich von {area:1025}.",

	-- Step 54: Dun Modr
	-- {area:205} Dun Modr · {area:881} Thandol Span · {npc:1071} Longbraid the Grim
	["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Folge der Straße nach Norden nach {area:205}, am Fuß von {area:881}. {npc:1071} steht im Lager der Zwerge.",

	-- Step 56: Dragonmaw camp
	["Dragonmaw camp"] = "Lager der Dragonmaw",
	-- {area:1025} Green Belt · {npc:2092} Pilot Longbeard · {zone:1426} Dun Morogh
	["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "Das Lager der Dragonmaw liegt südlich der Straße, gleich westlich von {area:1025}: Räuber, Sumpfläufer und Knochenwärter der Dragonmaw. Die Quest von {npc:2092} in {zone:1426} erfordert Stufe 28.",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Raiders = {npc:1034} Dragonmaw Raider
	["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "grinde Räuber und Sumpfläufer der Dragonmaw im Lager der Dragonmaw, {zone:1437}",

	-- Step 57: Hearth to Menethil
	["Hearth to Menethil"] = "Ruhestein nach Menethil",
	["For the giant crocolisks of the north coast, on your next visit"] = "Für die Riesigen Sumpflandkrokilisken der Nordküste, bei deinem nächsten Besuch",

	-- Step 58: Ironforge
	-- {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan · {zone:1426} Dun Morogh · {area:1537} Ironforge
	["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Reite auf der Straße durch {zone:1437} nach Osten, nach Süden durch {area:836} nach {zone:1432} und nach Westen durch den Tunnel nach {zone:1426} bis {area:1537}.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, bei {object:32372}",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Nur mit {item:5352} aus {zone:1439}: {npc:2786}, {object:32383}",

	-- Step 59: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Priester in {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} und {npc:258785} sind in {object:32386}, in {object:32362}.",

	-- Step 60: Cathedral of Light
	["Cathedral of Light"] = "Kathedrale des Lichts",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Nimm {area:2257} von {object:171524} zu {object:28027} in {zone:1453} und geh dann zu {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, in der Kathedrale des Lichts",
	-- {npc:1444} Brother Kristoff · {object:2098} Cathedral Square
	["{npc:1444}, in the {object:2098}"] = "{npc:1444}, auf {object:2098}",

	-- Step 61: Stormwind Keep
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, in the Royal Library"] = "{npc:1440}, in der Königlichen Bibliothek",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Nur wenn du {quest:337} in {zone:1431} erbeutet hast",

	-- Step 62: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "Zurück zur Kathedrale des Lichts: {npc:928} steht drinnen.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Für {npc:2228} in {area:271}: behalte es",

	-- Step 63: Mage Quarter
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter
	["{object:2164} is in the {object:2101}."] = "{object:2164} ist in {object:2101}.",

	-- Step 64: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} und {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, der Käseladen in {object:2096}",

	-- Step 65: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Als Nächstes: Flieg nach {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Folge der Küste nach Norden zu {area:414}. {npc:3846} lagert am Strand; Naga der Rächerflossen bevölkern das Ufer.",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} streift mit Wachen der Rächerflossen über die Nordspitze von {area:414}.",
}
