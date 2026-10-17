-- German (deDE): the guide forever/horde/orc-troll/01-durotar (forever/horde/orc-troll/01-durotar.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, wo du startest",

	-- Step 2: Gornek
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} wartet im Höhlenbau, dem Gebäude gleich westlich von {npc:10176}.",

	-- Step 3: Training weapons and boars
	["Training weapons and boars"] = "Übungswaffen und Eber",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "Die Waffen liegen um den Höhlenbau und den Übungsplatz; die Scheckigen Eber streifen über den ganzen Talboden.",

	-- Step 4: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} steht gleich hinter dem Höhleneingang; {npc:3159} hinten in der Höhle hinter ihm.",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave"] = "{npc:3159}, hinten in der Höhle",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}, der Hexenmeisterlehrer hinten in der Höhle",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}, der Schurkenlehrer im Höhlenbau",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}, der Kriegerlehrer neben dem Höhlenbau",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}, der Jägerlehrer neben dem Höhlenbau",
	-- {npc:3707} Ken'jai
	["{npc:3707}, the priest trainer at the Den"] = "{npc:3707}, der Priesterlehrer am Höhlenbau",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}, der Schamanenlehrer neben dem Höhlenbau",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}, die Magierlehrerin, am Eingang zum Höhlenbau",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, am Kochfeuer",

	-- Step 5: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} liegt verwundet am Fuß der Hügel nordwestlich des Höhlenbaus.",

	-- Step 6: Sarkoth
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way."] = "{quest:790}, ein großer Skorpid, streift zwischen den Skorpidarbeitern über den Hang südlich von {npc:3287}; pflück unterwegs die Kaktusäpfel an den Kakteen.",

	-- Step 8: Back to the Den
	["Back to the Den"] = "Zurück zum Höhlenbau",

	-- Step 9: Foreman Thazz'ril
	["The foreman stands at the lumber pile east of the Den."] = "Der Großknecht steht am Holzstapel östlich des Höhlenbaus.",

	-- Step 10: Lazy Peons
	-- {item:16114} Foreman's Blackjack
	["Hit the sleeping peons north of the Den with the {item:16114}."] = "Schlag die schlafenden Peons nördlich des Höhlenbaus mit {item:16114}.",
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Weck {quest:5441} mit {item:16114}",

	-- Step 12: North end of the valley
	["North end of the valley"] = "Nordende des Tals",
	-- {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "{quest:792} schwärmen über den Hang unterhalb des {area:365}, der Höhle auf der Nordseite des Tals.",

	-- Step 13: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "Geh in der Höhle an der ersten Gabelung geradeaus, dann rechts, und folge dem Bach zu deiner Linken bis zum Wasserfall: Die Hacke leuchtet am Wasser, hinter einer Felssäule.",

	-- Step 14: Back at the Den
	["Back at the Den"] = "Zurück am Höhlenbau",

	-- Step 15: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller
	["{npc:5887} stands just outside the Den."] = "{npc:5887} steht gleich vor dem Höhlenbau.",

	-- Step 17: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "Halte dich in der Höhle immer an der rechten Wand, über den Bach: {npc:3183} wartet am Ende.",

	-- Step 18: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "{npc:3102}-Hufe",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Teufelspirscher streifen über den Hang unterhalb der Höhle, auf der Nordseite des Tals.",

	-- Step 19: Zureetha Fargaze
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "{object:654925} neben ihr auf dem Boden",

	-- Step 20: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} steht vor dem Höhlenbau. {area:639} ist der Hügel gleich südlich davon: Trink dort {item:6635}, um {npc:5891} zu sehen, und bring dann {item:6656} zurück zu {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, auf dem {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} und dein {item:5175}",

	-- Step 21: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} steht auf der Straße am östlichen Ausgang des Tals.",

	-- Step 22: Sen'jin Village
	-- {area:367} Sen'jin Village
	["Follow the road east out of the valley to {area:367} on the coast."] = "Folge der Straße nach Osten aus dem Tal nach {area:367} an der Küste.",

	-- Step 23: Ridgeshade spiders
	["Ridgeshade spiders"] = "Kammschattenspinnen",
	-- {area:362} Razor Hill
	["The spiders lurk in the hills along the road north toward {area:362}."] = "Die Spinnen lauern in den Hügeln an der Straße nach Norden Richtung {area:362}.",

	-- Step 24: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "Lagerfeuer von {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "{npc:265809} lagert gleich südlich von {area:362}. Setz dich an sein Lagerfeuer (/sit), bis der Buff {spell:1229451} erscheint.",

	-- Step 25: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town"] = "{npc:266940}, auf der Ostseite des Orts",
	-- {npc:3191} Cook Torka
	["Talk to {npc:3191}"] = "Sprich mit {npc:3191}",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, im Wachturm",

	-- Step 26: Prickly pears
	["Prickly pears"] = "Kaktusfeigen",
	["The prickly pears grow among the quilboar huts just west of town."] = "Die Kaktusfeigen wachsen zwischen den Hütten der Stacheleber gleich westlich des Orts.",

	-- Step 28: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Stacheleber und Späher halten die Hütten westlich des Orts; Staubläufer und Schlachtwachen halten die Lager weiter westlich.",

	-- Step 30: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "Die Burg steht an der Küste südöstlich von {area:362}. Axt, Bogen und Schild der Räuber liegen an ihrem Rand. Matrosen und Marinesoldaten lassen {item:4870} fallen. {npc:3192} wartet oben in der Burg; sein Schlüssel öffnet die Truhe neben ihm, in der {item:4881} liegt.",

	-- Step 32: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Follow the road north toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "Folge der Straße nach Norden Richtung {zone:1454}. {npc:3293} lagert daneben; die gestohlenen Säcke liegen an der Straße südlich von ihm.",

	-- Step 33: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}."] = "Wilde und Sturmhexen der Staubschwingen nisten in {area:370}, östlich von {npc:3293}. Eine Sturmhexe lässt {item:277661} fallen.",

	-- Step 35: Thunder lizards
	["Thunder lizards"] = "Donnerechsen",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}."] = "Donnerechsen und Blitzechsen grasen auf dem {area:369}, gleich westlich und südwestlich von {npc:3293}.",

	-- Step 37: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "Mishas Hütte steht südlich der Echsen. Die Krokilisken am {area:814} im Westen tragen {item:4891}.",

	-- Step 38: The wreckage
	["The wreckage"] = "Das Wrack",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin."] = "Die Gnomen-Werkzeugkästen liegen in den Trümmern am Ufer östlich und südöstlich von {area:362}. Folge dem Ufer nach Süden nach Sen'jin.",

	-- Step 39: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: nur für Verzauberer, die Rückstände werden aus Verhexten Anhängern ({item:275724}) entzaubert",

	-- Step 40: Makrura and crawlers
	["Makrura and crawlers"] = "Makrura und Kriecher",
	["Makrura and surf crawlers line the beaches north-east of Sen'jin."] = "Makrura und Brandungskriecher säumen die Strände nordöstlich von Sen'jin.",

	-- Step 41: Bloodtalon Matriarch
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there."] = "Wate hinüber zur nördlichen Echoinsel. Die Matriarchin streift dort zwischen den Raptoren umher.",

	-- Step 42: Echo Isles
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "Geh nach Süden über die Inseln. Die Loa-Götzen liegen überall auf den südlichen Inseln; Voodootrolle und Verhexte Trolle halten sie und lassen die Verhexten Anhänger ({item:275724}) fallen. {quest:826} und Minshinas Käfig sind auf der südlichsten Insel.",

	-- Step 43: South-east shore
	["South-east shore"] = "Südostufer",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade back west to the shore south of Sen'jin. Durotar Tigers roam it and the Taillasher eggs sit in nests along the beach."] = "Wate zurück nach Westen zum Ufer südlich von Sen'jin. Durotar-Tiger streifen dort umher, und die Schwanzpeitscher-Eier liegen in Nestern am Strand.",

	-- Step 45: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366} liegt westlich von Sen'jin. Die drei Angriffspläne liegen zwischen den Zentaurenzelten auf dem Boden. {npc:275811} wird ebenfalls am Felsen festgehalten.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Befrei {npc:275811} und bring sie sicher aus dem Felsen",

	-- Step 47: Razor Hill
	-- {area:362} Razor Hill
	["Follow the road north to {area:362}."] = "Folge der Straße nach Norden nach {area:362}.",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, beim Gasthaus",
	-- {npc:3706} Tai'jin · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["{npc:3706}, for {npc:6018} in {zone:1454}: keep it"] = "{npc:3706}, für {npc:6018} in {zone:1454}: behalte sie",

	-- Step 48: Fizzle Darkstorm
	-- {area:369} Thunder Ridge · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	["Fizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way."] = "Fizzle hält das Lager der Burning Blade auf dem {area:369}, nordwestlich von {area:362}. Jäger: Zähm unterwegs einen {npc:3099} mit {item:15908}.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Zähm ihn mit {item:15908}",

	-- Step 50: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} steht am Ufer östlich von {area:362}. Dreizack, Banner und Dolch liegen um ihn herum am Strand.",

	-- Step 51: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} lagert auf dem Hügel westlich des Nagastrands, südlich von {quest:827}.",

	-- Step 52: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "Das Haupttor von {zone:1454} liegt gleich westlich von {area:817}. {npc:5875} steht in {object:172960}, der Schlucht unter dem {object:172982}.",

	-- Step 53: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Eingang von {area:817}",

	-- Step 54: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Kultisten der Burning Blade halten die Höhlen von {quest:827}; jeder lässt {item:4871} fallen. {npc:3204}, ein Hexenmeister der Stufe 14, steht tief drinnen und lässt {item:4903} fallen.",

	-- Step 55: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595} steht in {area:817}, zwischen den Kultisten, die du gerade bekämpft hast.",

	-- Step 56: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "Zurück zu {npc:5875} in {object:172960}. Benutze dort {item:7464} am Beschwörungskreis und besiege den Leerwandler, um ihn zu binden.",

	-- Step 58: Razor Hill
	-- {area:362} Razor Hill
	["Back south to {area:362}."] = "Zurück nach Süden nach {area:362}.",

	-- Step 59: Spitelash naga
	["Spitelash naga"] = "Naga der Grollflossen",
	-- {npc:275657} Heglan Shadeeye · {area:370} Drygulch Ravine · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "Zurück nach Osten zum Ufer nördlich von {npc:275657}. Späher und Bedienstete der Grollflossen halten den Strand unterhalb von {area:370}. Jäger: Zähm am Strand einen {npc:3107}.",

	-- Step 60: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "Zurück nach {area:362}.",
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, ein Elite-Meeresriese",

	-- Step 61: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "{npc:275666}, ein junger Meeresriese, läuft an der Nordküste von {zone:1411} entlang, nördlich des Nagastrands. {npc:275666} ist Elite: Such dir am besten eine Gruppe.",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, zurück in {area:362}",

	-- Step 62: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Gepanzerte Skorpide kriechen über die Ebenen westlich von {area:362}. Zähm einen und kehr dann zu {npc:3171} zurück.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "{npc:3171}: {npc:3352} in {zone:1454} lehrt {spell:5149}",

	-- Step 63: Ormak Grimshot
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:362} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Folge der Straße von {area:362} nach Norden zum Haupttor von {zone:1454}, gleich westlich von {area:817}. {npc:3352} steht bei den Jägerlehrern im {object:172958}.",

	-- Step 64: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} Barrens
	["Follow the road west from {area:362} over the {area:814} bridge; {area:379} sits just above it on the {zone:1413} side."] = "Folge der Straße von {area:362} nach Westen über die Brücke am {area:814}; {area:379} liegt gleich darüber auf der Seite des {zone:1413}.",

	-- Step 65: Thunder lizards across the river
	["Thunder lizards across the river"] = "Donnerechsen jenseits des Flusses",
	-- {area:369} Thunder Ridge · {item:6486} Singed Scale
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Donnerechsen und Blitzechsen grasen jenseits der Brücke auf dem {area:369}; jede kann {item:6486} fallen lassen.",

	-- Step 67: The Crossroads
	-- {area:379} Far Watch Post · {area:380} The Crossroads · {zone:1413} Barrens
	["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Folge der Straße von {area:379} nach Südwesten nach {area:380}. Hier beginnt der Guide für {zone:1413}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Folge der Straße von {area:379} nach Südwesten nach {area:380}. Hier beginnt der Guide für das {zone:1413}.",
	-- ["{area:364}'s cave mouth"] = "Höhleneingang von {area:364}",
}
