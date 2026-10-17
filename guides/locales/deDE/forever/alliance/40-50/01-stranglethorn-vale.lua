-- German (deDE): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "Theramore",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} steht nahe dem Gasthaus; {npc:4897}, ein Handwerkswarenhändler ein paar Schritte südlich, verkauft die Gewürze, die Jarl will.",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, für Sumpfauge Jarl",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Folge der Straße nach Nordwesten aus Theramore hinaus zum Wachturm bei {area:503}. Schlammpanzereinbuddler streifen durch den Sumpf darum herum.",

	-- Step 3: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "Zurück in Theramore: Tervosh wartet mit Lady Jaina im Turm von {area:514}.",

	-- Step 4: Swamplight Manor
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "Nimm die Straße nach Norden zum zerstörten Anwesen; Jarl wohnt in der Hütte daneben, und die lockere Erde ist an der Hausecke.",
	["with the spices from Theramore"] = "mit den Gewürzen aus Theramore",

	-- Step 5: Mudrock tortoises
	["Mudrock tortoises"] = "Schlammpanzerschildkröten",
	-- plural, as words: Mudrock Tortoises = {npc:4396} Mudrock Tortoise
	["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Die Schlammpanzerschildkröten und Dornenschlammpanzer sonnen sich am Ufer nordöstlich des Anwesens.",

	-- Step 6: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "Stinki Ignatz",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Stinki wartet westlich des Anwesens, im Sumpf unterhalb von {area:504}. Führ ihn zu seinen Sumpfbohnenblättern und halte die Sumpfkreaturen von ihm fern.",

	-- Step 7: North Point Tower
	-- {npc:4966} Private Hendel
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} hält den Turm mit ein paar Deserteuren. Er wendet sich gegen dich: Schlag ihn, bis er aufgibt.",

	-- Step 8: Darkmist Cavern
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "Die Graunebelspinnen nisten um die Höhle im Nordwesten des Sumpfs; jede Spinne lässt Augen fallen.",

	-- Step 9: Mudcrush Durtfeet
	["Ride south to the giant's hut in the middle of the marsh."] = "Reite nach Süden zur Hütte des Riesen mitten im Sumpf.",

	-- Step 10: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "Das abgebrannte Gasthaus Zur süßen Ruh steht an der Straße nach Westen, Richtung {zone:1413}; die Plakette der Wache liegt in der Asche, und die Hufabdrücke sind im Schlamm neben dem Gasthaus.",

	-- Step 11: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Folge der Straße nach Osten zurück nach Theramore. Tervosh, Lady Jaina und die Offiziere sind im Turm und in {area:514}.",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs der Schlammflossen",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "Die Murlocs der Schlammflossen drängen sich an der Nordküste hinter {area:497}; sammle die restlichen Zungen bei den Schildkröten daneben.",

	-- Step 13: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "nur wenn du einen {item:3853} dabeihast (von Schmieden hergestellt)",

	-- Step 15: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "Die Deserteure lagern südlich der Straße, westlich von {npc:4503}s Hütte.",

	-- Step 17: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "Auf dem Ritt nach Norden nach {area:392} liegt {area:720} vor der {area:391} südlich des Orts: Wate über die Untiefen der Sandbank. {npc:6236} schickt dir nacheinander vier Herausforderer und dann {npc:6238} (Stufe 33) entgegen.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Besiege die Herausforderer und {npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236} bietet als Nächstes Der Windbehüter (1791) an: Die Questreihe um die Waffe für Wirbelwind, mit einem Elite am Ende, steht im Kriegerklassen-Guide „Wirbelwaffe“.",

	-- Step 18: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:16227} Bragok · {area:35} Booty Bay
	["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Reite von Theramore nach Westen über die Straße der Marschen ins {zone:1413} und nach Norden nach {area:392} an der Küste. Hol dir die Flugroute bei {npc:16227}, dann nimm am Steg das Boot nach {area:35}.",
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Boot nach {area:35}",

	-- Step 19: Booty Bay
	-- {object:56910} The Salty Sailor Tavern
	["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} ist das hohe Gebäude über dem Hafen; die meisten Questgeber sind auf seinen Stockwerken oder unten an den Docks.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it"] = "für Stoley in {zone:1446}: Behalte es",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: für {quest:2864} in {zone:1446}, behalte es",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "für {npc:770} beim {area:99}, auf der nördlichen Runde",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, oberstes Stockwerk",
	["Seahorn's next errand goes back to Arathi: skip it."] = "Seehorns nächster Auftrag führt zurück nach Arathi: Überspring ihn.",

	-- Step 20: Bloodsail camp
	["Bloodsail camp"] = "Lager der Blutsegelbukaniere",
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks."] = "Verlass den Ort durch den Tunnel und folge der Küste nach Norden; der Brief liegt im Lager der Blutsegelbukaniere am Strand, wo Schönling Duncan umhergeht.",

	-- Step 21: Booty Bay
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} schwimmt vor der Nordwestküste, auf der nördlichen Runde",

	-- Step 22: Bloodsail pirates
	["Bloodsail pirates"] = "Piraten der Blutsegelbukaniere",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore · {area:35} Booty Bay
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}."] = "Jeder Blutsegelbukanier lässt Schnupftabak fallen, und einer trägt {npc:2493}s Auge; die Schwadroneure gehen gleich nördlich des Orts am Ufer entlang. Die Karten und Befehle liegen im Piratenlager an der {area:43} südlich von {area:35}.",

	-- Step 24: The Bloodsail captains
	["The Bloodsail captains"] = "Die Kapitäne der Blutsegelbukaniere",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon
	["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Die Kapitäne stehen auf den Schiffen vor der {area:43}, jeder mit einer Mannschaft aus Piraten der Stufe 42-45: Stillwasser (45) und Kielhol (46) auf den näheren Decks, {npc:2546} (48) auf dem Flaggschiff. Mit 42 ist das ein Kampf für eine Gruppe oder fürs Ende des Guides; säubere jedes Deck vorher, falls du gehst. Cortellos Schriftrolle liegt auf dem Wrack am Ufer.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "für die {zone:1435} später",

	-- Step 26: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Forscher der Naga",
	["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Die Naga durchkämmen die Strände nördlich des Lagers der Blutsegelbukaniere; sie lassen das Schilf fallen.",

	-- Step 27: Gorilla hills
	["Gorilla hills"] = "Gorillahügel",
	-- {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Reite ins Landesinnere zu den Gorillahügeln im Nebeltal. Alte Nebeltalgorillas lassen die Innereien fallen; {npc:1449} sitzt zwischen ihnen.",

	-- Step 28: Unbagwa's ritual
	["Unbagwa's ritual"] = "Unbagwas Ritual",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Gib die Fangzähne ab und bleib: Drei Wellen Gorillas kommen, {npc:1514} zuletzt. Kämpfe mit voller Gesundheit.",

	-- Step 29: Booty Bay
	["Ride back down to town; Shaky stands at the tunnel mouth."] = "Reite zurück hinab in den Ort; Zitterhand steht am Tunneleingang.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it"] = "für {npc:2616} in Theramore: Behalte es",

	-- Step 30: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} und {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Reite nach Norden in die Hügel westlich der Straße. {npc:2535} und {npc:2536} stehen zusammen gleich nördlich von Zanzils Dorf.",

	-- Step 31: Zanzil's village
	["Zanzil's village"] = "Zanzils Dorf",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Jeder Anhänger von Zanzil kann die Mixtur fallen lassen; {npc:2537} geht im Süden des Lagers umher.",

	-- Step 32: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Folge der Straße nach Nordosten zum Lager der Venture Co. an der {area:310}; Minenarbeiter, Feldmesser und Großknechte lassen die Kristalle fallen.",

	-- Step 33: Skullsplitter ruins
	["Skullsplitter ruins"] = "Ruinen der Skullsplitter",
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Die Skullsplitter-Trolle halten die Ruinen gleich östlich der Mine; jeder von ihnen kann Hauer fallen lassen, ihre Panther immer.",

	-- Step 34: Cold Eye Basilisks
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["Cold Eye Basilisks"] = "Kaltaugenbasilisken",
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["The Cold Eye Basilisks lie on the rocks west of the mine."] = "Die Kaltaugenbasilisken liegen auf den Felsen westlich der Mine.",

	-- Step 35: The north-west coast
	["The north-west coast"] = "Die Nordwestküste",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Reite von der Mine nach Nordwesten zur Bucht an der Nordwestküste. Die Riesenmuscheln liegen auf ihrem Grund und enthalten die Perlen; {npc:2624} schwimmt zwischen ihnen und lässt {item:4034} fallen.",

	-- Step 36: Rebel Camp
	-- {npc:217588} Arbor Tarantula
	["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Reite nach Nordosten an Nesingwarys Lager vorbei und folge der Straße nach Norden zum Lager am oberen Ende des Tals. Unterwegs krabbelt eine {npc:217588} im Dschungel südöstlich von Nesingwarys Lager: Fang eine mit dem Entomologie-Startset und hak sie dann ab.",
	-- {npc:217588} Arbor Tarantula · {quest:93176} My Little Friends
	["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: Fang sie, für {quest:93176}",

	-- Step 37: Booty Bay
	["MacKinley's next task sends you after elite ogres: skip it."] = "MacKinleys nächster Auftrag schickt dich zu Elite-Ogern: Überspring ihn.",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}s nächster Zanzil-Auftrag beginnt in {zone:1441}: Überspring ihn.",

	-- Step 38: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} kocht im {object:2169}; {npc:5384} ist im {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {area:1438} Nethergarde Keep
	["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: für {area:1438}, behalte es",
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}, Königliche Bibliothek in {object:2117}",

	-- Step 39: Riding at 40
	["Riding at 40"] = "Reiten mit 40",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4732} lehrt Menschen in {area:88} im östlichen {zone:1429}, neben den Pferden von {npc:384}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: andere Farben, 20g",

	-- Step 40: Riding at 40
	-- {spell:1285849} Galestrider Riding · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {zone:1453} Stormwind · {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. Es ist kein Reitlehrer der Himmelsgeborenen bekannt; der Forever-Client führt {spell:1285849} unter der einen Reitfertigkeit, also sollte {npc:4732} in {area:88} im östlichen {zone:1429}, der nächste Lehrer bei {zone:1453}, es lehren (unbestätigt). Die Windschreiter verkauft {npc:265756} in {area:16638} auf der Insel Zephras; Sammelobjekte, Reittiere · Stufe 40 listet sie.",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Windschreiter: {npc:265756}, in {area:16638} auf der Insel Zephras.",

	-- Step 41: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4753} lehrt Nachtelfen in {zone:1457}, neben den Säblern von {npc:4730}: das Boot vom {area:17203} nach {area:442}, dann der Flug nach {area:702}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt), etwa bei {npc:4732} in {area:88} im {zone:1429}. Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: andere Farben, 20g",

	-- Step 42: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Paladin: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}, in der Kathedrale des Lichts",

	-- Step 43: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Hexenmeister: {quest:3631}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}, im {object:2164}: {npc:6251} in {area:392} nimmt es am Ende des nächsten Guides an",

	-- Step 44: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:5476} Watcher Biggs
	["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Flieg nach {area:42} und reite nach Osten durch den {zone:1430} in die {zone:1435}; {npc:5476} steht gleich hinter der Grenze an der Straße.",

	-- Step 45: A Soggy Scroll
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "Die Schriftrolle liegt im Sumpf nördlich von Biggs. Die Sumpfwandler nördlich davon können Khadgars Aufsätze fallen lassen.",
	["The riddle's next scroll lies in western Dustwallow: skip it."] = "Die nächste Schriftrolle des Rätsels liegt im Westen der Marschen von Dustwallow: Überspring sie.",

	-- Step 46: The sunken temple
	["The sunken temple"] = "Der versunkene Tempel",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Reite nach Osten; die Wuchernden Schrecken unterwegs lassen auch die Aufsätze fallen. Durchsuche den Rand des {area:74}, wo die Ruinen des Tempels aus dem Wasser ragen.",

	-- Step 47: Misty Reed Strand
	["The driftwood washes up along the eastern shore."] = "Das Treibholz wird am Ostufer angeschwemmt.",

	-- Step 48: Watcher Biggs
	-- {npc:217412} Amaryllis Webb
	["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Reite die Straße zurück nach Westen; {npc:217412} steht ein kurzes Stück nördlich von Biggs.",
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "für {area:1438}: Behalte es",
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: {quest:93176}, aus 30-40/05-arathi-highlands",

	-- Step 49: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "für {npc:5635} in {area:348}: Behalte es",

	-- Step 50: Ironforge
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:1356} Prospector Stormpike · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern · {area:144} Thelsamar
	["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "Nimm die {area:2257} vom {object:28027}. {npc:5637} ist in der Halle der Forscherliga beim {object:32356}, {npc:1356} in der Halle selbst, {npc:2786} im {object:32383}. Der nächste Guide fliegt weiter nach {area:144}.",
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: für {npc:1344} in {zone:1432}, behalte es",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} hat keinen Schamanenlehrer",

	-- Step 51: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4772} lehrt Zwerge in {area:803}, östlich von {area:131} an der Straße nach {zone:1432}, neben den Widdern von {npc:1261}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: andere Farben, 20g",

	-- Step 52: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:7954} lehrt Gnome in {area:189}, gleich östlich von {area:131}, neben den Roboschreitern von {npc:7955}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: andere Farben, 20g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Klannoc bietet als Nächstes Der Windbehüter (1791) an: Die Questreihe um die Waffe für {spell:1680}, mit einem Elite am Ende, steht im Kriegerklassen-Guide „Wirbelwind-Waffe“.",
}
