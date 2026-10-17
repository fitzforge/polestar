-- Spanish (Latin America) (esMX): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "Te levantas en la cripta del extremo sur de {area:154}. {npc:1568} espera justo afuera.",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "Sigue el sendero al norte hacia {area:154}; Sarvis está frente a la iglesia.",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Zombis descerebrados ({npc:1501})",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Los zombis deambulan por el cementerio y las casas justo al este de la iglesia.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church"] = "{npc:1661}, junto a la iglesia",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer"] = "{npc:2119}, el instructor de guerreros",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "{npc:2122}, el instructor de pícaros",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "{npc:2123}, el instructor de sacerdotes en la iglesia",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "{npc:2124}, la instructora de magos, en la iglesia",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "{npc:2126}, el instructor de brujos",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "Los instructores de {area:154} están alrededor de la iglesia",

	-- Step 5: Aramis Hammerhand and Venya Marthand
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667}"] = "{npc:244808} y {npc:5667}",
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} y {npc:5667} están junto a la iglesia.",
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: el pergamino para {npc:244808}",

	-- Step 6: Rattlecages, scavengers and duskbats
	["Rattlecages, scavengers and duskbats"] = "Armadóseos, carroñeros y murciumbríos",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Los Esqueletos armadóseos ({npc:1890}) deambulan por las casas en ruinas de la mitad norte de {area:154}. Los Carroñeros jóvenes ({npc:1508}) y los Murciumbríos recorren todo el pueblo; los Carroñeros pulgosos ({npc:1509}) y los Murciumbríos sarnosos ({npc:1513}) están en su lado este.",

	-- Step 7: Rattlecage skulls
	["Rattlecage skulls"] = "Cráneos de armadóseo",
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Los Esqueletos armadóseos ({npc:1890}) de las casas en ruinas sueltan los cráneos.",

	-- Step 8: Back to the church
	["Back to the church"] = "De vuelta a la iglesia",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, en la iglesia",

	-- Step 9: Aramis Hammerhand and Venya Marthand
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Paladines: {quest:90902} se completa cuando hayas curado a cinco {npc:259377} alrededor de la iglesia con {spell:635}.",

	-- Step 10: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662} están junto a las casas en ruinas del norte de {area:154}.",

	-- Step 11: Night Web's Hollow
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Ve al oeste hasta la cueva. Las Nocturácnidas jóvenes ({npc:1504}) están afuera; las Arañas nocturácnidas ({npc:1505}) y las víctimas envueltas en telaraña están adentro.",
	-- {npc:244808} Aramis Hammerhand
	["Free six Webbed Victims inside the cave for {npc:244808}"] = "Libera a seis víctimas envueltas en telaraña dentro de la cueva para {npc:244808}",
	["Webbed Victims"] = "Víctimas envueltas en telaraña",

	-- Step 12: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "De vuelta a {area:154}",

	-- Step 13: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin
	["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: el {npc:246143} huyó a las colinas justo al oeste de la iglesia.",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Ofrece ayuda al {npc:246143}",

	-- Step 14: The Scarlet farm
	["The Scarlet farm"] = "La granja Escarlata",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Los Conversos Escarlata ({npc:1506}) y los Iniciados ocupan la granja al este de {area:154}. {npc:1919} deambula entre las casas de la granja: sus restos son para {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, de {npc:1919}",

	-- Step 15: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090} está en el cementerio de {area:154}, junto a la iglesia.",

	-- Step 17: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} está en el extremo sur de la granja Escarlata.",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Sal de {area:154} por el camino del noreste. {npc:6784} está junto a la casa de {area:156}.",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, la gran abominación, recorre el camino un poco más al este. {item:12737} crece a lo largo del camino a su alrededor.",

	-- Step 21: Brill
	-- {area:159} Brill · {npc:10665} Junior Apothecary Holland · {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Sigue el camino al este hasta {area:159}. {npc:10665} está en el borde noroeste del pueblo; {area:2119} es la gran posada del centro, con {npc:1515} enfrente.",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, la instructora de paladines",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Pídele su informe a {npc:1496}",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "Los instructores de {area:159} están dentro y alrededor de la posada",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Usa {item:286176} en cinco Guardias de la Muerte ociosos por el pueblo",

	-- Step 23: Doom Weed
	-- {quest:5482} Doom Weed · {area:159} Brill
	["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482} crece en los campos del cementerio justo al norte de {area:159}.",

	-- Step 25: Dry Branches
	["Dry Branches"] = "Ramas secas",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Las ramas secas están en el suelo alrededor del borde suroeste de {area:159}.",

	-- Step 26: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Eleanor acampa justo al suroeste del pueblo.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "Usa /sentarse junto a su fogata hasta obtener {spell:1229451}",

	-- Step 27: Fields west of Brill
	-- {area:159} Brill
	["Fields west of {area:159}"] = "Campos al oeste de {area:159}",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} y los Cuerpos devastados ({npc:1526}) deambulan por los campos justo al oeste de {area:159}; los canes oscuros recorren la zona un poco más al oeste, hacia {npc:10666}.",

	-- Step 28: Gordo
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Pídele su informe a {npc:10666}",

	-- Step 29: Calvin Montague
	-- {npc:6784} Calvin Montague
	["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Sigue caminando al oeste hasta {npc:6784} y habla con él: quiere un duelo.",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Vence a {npc:6784} en el duelo",

	-- Step 30: Hearth to Brill
	-- {area:159} Brill
	["Hearth to {area:159}"] = "Usa tu piedra de hogar para ir a {area:159}",

	-- Step 31: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan"] = "{npc:2132}, junto a Johaan",
	["in the inn: ask him about cooking"] = "en la posada: pregúntale por la cocina",
	-- {npc:265944} William Pickman
	["Talk to {npc:265944}"] = "Habla con {npc:265944}",
	["The Wanted poster by the inn"] = "El cartel de Se busca junto a la posada",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, en el ayuntamiento",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, en la posada",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} de {npc:2118}, para Gretchen",

	-- Step 32: Greater Duskbats
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats"] = "Murciumbríos superiores ({npc:1553})",
	-- {area:159} Brill
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Los Murciumbríos superiores ({npc:1553}) vuelan sobre los campos alrededor de {area:159} y a lo largo del camino al norte.",

	-- Step 33: Rot Hide graveyards
	["Rot Hide graveyards"] = "Cementerios Putrepellejo",
	-- {area:159} Brill
	-- plural, as words: Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber
	["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Los Asaltatumbas Putrepellejo ({npc:1941}) excavan en los cementerios al norte de {area:159}; todos los Putrepellejo sueltan el icor.",

	-- Step 34: Maggot Eye
	-- {npc:1753} Maggot Eye
	-- plural, as words: Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Los Bastardos Putrepellejo ({npc:1675}) ocupan las colinas más al norte. {npc:1753} (nivel 11) está en su campamento, en la colina al sur de la orilla: primero acaba con los gnolls a su alrededor.",

	-- Step 35: Vile Fin murlocs
	["Vile Fin murlocs"] = "Múrlocs Anca Vil",
	["The Vile Fin murlocs line the north shore."] = "Los múrlocs Anca Vil se alinean en la orilla norte.",

	-- Step 36: Brill
	-- {area:159} Brill
	["Follow the road south back to {area:159}."] = "Sigue el camino al sur de vuelta a {area:159}.",

	-- Step 37: Deathguard Linnea
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Sigue el camino al sureste desde {area:159} pasando las torres de zepelín. Linnea, Kristof y {npc:3549} acampan junto al camino.",
	-- {npc:1495} Deathguard Linnea · {npc:276020} Riptear
	["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: {npc:276020}, una abominación élite en el este",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Pídele su informe a {npc:251001}",

	-- Step 38: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "De vuelta por el camino a {area:159}.",

	-- Step 39: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Sigue el camino al noroeste hasta {area:157}. {npc:1657} recorre el cementerio al sur de los molinos; Nissa, Gregor y {npc:1656} rondan los molinos. Los Soldados armadóseos y los Soldados testapartida ({npc:1523}) sueltan las costillas, los Tirahuesos Ojosombra ({npc:1522}) los cráneos, y cualquiera puede soltar {item:2839}. De aquí en adelante, mata a los murciumbríos y canes oscuros que encuentres: {npc:3549} quiere sus alas y pellejos.",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, botín raro",
	["Only if the letter dropped"] = "Solo si te salió la carta",

	-- Step 40: Deathguard Simmer
	-- {area:156} Solliden Farmstead
	["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Camina al suroeste hasta {area:156}; Simmer está en la granja.",

	-- Step 41: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Calabazas de Tirisfal ({object:375})",
	["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Las calabazas crecen en los campos tomados por la Cruzada Escarlata, al noroeste de Solliden.",

	-- Step 42: Crusader's Outpost
	["Crusader's Outpost"] = "Avanzada de los Cruzados",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Los Guerreros Escarlata ({npc:1535}) custodian la avanzada justo al oeste de los campos de calabazas. {npc:275954} está cautivo adentro: habla con él y quédate a su lado hasta que salga.",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Escolta a {npc:275954} fuera de la avanzada",

	-- Step 43: Vile Fin shore
	["Vile Fin shore"] = "Orilla Anca Vil",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "Más múrlocs Anca Vil recorren la orilla justo al norte de la avanzada.",

	-- Step 44: Paladin: Whispering Forest
	-- {area:16616} Whispering Forest
	["Paladin: {area:16616}"] = "Paladín: {area:16616}",
	-- {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Ve al oeste hacia {area:16616}; {npc:246389} y {npc:259190} acampan en su borde.",

	-- Step 45: Shadowvale
	-- {area:16881} Shadowvale · {item:286269} Glowing Crystal Fragment
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} es la hondonada del borde oeste de los claros. Los Merodeadores vallesombra ({npc:260428}) y los Místicos sueltan los huesos; las botellas están en el suelo entre ellos y {item:286269} está en el extremo sur.",

	-- Step 48: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, en la posada",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "El {npc:1931}, en el sótano del ayuntamiento",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {npc:4568} en {zone:1458} la recibe",

	-- Step 49: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} está en {area:159}. {npc:6390} espera en el mausoleo de la colina justo al norte del pueblo: abre la reja y pelea con él.",

	-- Step 50: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Camina al sur desde {area:159} hasta {area:153} y baja a {zone:1458}. {npc:5675} está en {object:36082}. El campamento Escarlata está justo al oeste de las ruinas.",

	-- Step 51: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Camina al sur desde {area:159} hasta {area:153} y baja a {zone:1458}. {npc:4568} está en {object:36082}. El campamento Escarlata está justo al oeste de las ruinas.",

	-- Step 52: The Scarlet camp
	["The Scarlet camp"] = "El campamento Escarlata",
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Sigue el camino al suroeste desde {area:159} hasta el campamento de la Cruzada Escarlata. {npc:1662} está en su extremo sur; cualquier Escarlata de allí puede soltar un anillo.",

	-- Step 53: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098} está junto a {npc:1662}, en el extremo sur del campamento.",

	-- Step 55: Deathguard Terrence
	-- {area:159} Brill
	["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Toma el camino al sureste desde {area:159}; Terrence está en él, antes de las torres de zepelín.",

	-- Step 56: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} está en el campamento de {npc:1495}.",

	-- Step 57: Balnir Farmstead
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} ocupa la granja justo al sureste del campamento. Los fragmentos de cristal necrótico ({item:275851}) están en el suelo entre los sectarios, y los sectarios también llevan algunos.",

	-- Step 58: Balnir graves
	["Balnir graves"] = "Tumbas de Balnir",
	-- {quest:99142} Tomb Weed
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Sigue el camino al este. Los Horrores sangrantes ({npc:1529}) y los Espíritus deambulantes ({npc:1532}) rondan las tumbas del lado este de la hacienda, donde crece {quest:99142}.",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, en el huerto de la hacienda",

	-- Step 59: Captain Vachon
	-- {npc:1664} Captain Vachon
	-- plural, as words: Scarlet Friars = {npc:1538} Scarlet Friar
	["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Los Frailes Escarlata ({npc:1538}) acampan justo al noreste de las tumbas; {npc:1664} está entre ellos.",

	-- Step 60: Vicious Night Web Spiders
	-- plural, as words: Vicious Night Web Spiders = {npc:1555} Vicious Night Web Spider
	["Vicious Night Web Spiders"] = "Nocturácnidas sañosas ({npc:1555})",
	-- {npc:276020} Riptear
	["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "Las arañas acechan en el bosque del extremo este de los claros. {npc:276020}, una abominación descontrolada, deambula justo al noroeste. {npc:276020} es élite: se recomienda ir en grupo.",
	-- {item:286326} Riptear's Heart · {npc:276020} Riptear
	["{item:286326}, from {npc:276020}"] = "{item:286326}, de {npc:276020}",

	-- Step 61: Hides for the Forsaken
	-- plural, as words: Duskbats = {npc:1512} Duskbat
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Los murciumbríos y canes oscuros recorren todo el camino de regreso al oeste; termina las alas y pellejos en el camino.",

	-- Step 62: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Campamento de {npc:1495}",

	-- Step 63: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "El {npc:2211}, en el sótano del ayuntamiento",

	-- Step 64: Captain Melrache
	-- {area:159} Brill · {area:162} Brightwater Lake · {npc:1665} Captain Melrache · {area:459} Scarlet Watch Post
	-- plural, as words: Scarlet Bodyguards = {npc:1660} Scarlet Bodyguard
	["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Sigue el camino al noreste desde {area:159} pasando {area:162}. {npc:1665} y sus dos Guardaespaldas Escarlata ({npc:1660}) ocupan la torre de vigilancia Escarlata en la costa noreste, al norte de {area:459}: atrae primero a los guardaespaldas.",

	-- Step 65: Executor Zygand
	-- {area:159} Brill
	["Back to {area:159}."] = "De vuelta a {area:159}.",

	-- Step 66: Leonid Barthalomew
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Sigue el camino al oeste pasando {area:157} hasta {area:16616}. Leonid está justo al norte del campamento de {npc:246389}.",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Escucha a Leonid y a {npc:246378}; luego habla con él de nuevo",

	-- Step 68: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} está bajo {area:153}, junto a las torres de zepelín. {npc:5675} está en {object:36082}: usa {item:6284} en el círculo de invocación a su lado y derrota al abisario. {npc:4606} está en {object:36070}. {npc:4568} también está en {object:36082}.",

	-- Step 69: Zeppelin to Durotar
	-- {zone:1411} Durotar
	["Zeppelin to {zone:1411}"] = "Zepelín a {zone:1411}",
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Camina al sureste desde {area:159} hasta las torres de zepelín afuera de {area:153} y sube al zepelín a {zone:1454} (el otro va a {object:3202}).",
	["Zeppelin tower"] = "Torre del zepelín",

	-- Step 70: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:815} Southfury River · {area:379} Far Watch Post · {area:380} The Crossroads
	["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "El zepelín aterriza en la torre justo al noreste de la puerta principal de {zone:1454}. Sigue el camino al sur hacia {zone:1411}, cruza el puente sobre {area:815} bajo {area:379} y sigue el camino al oeste hasta {area:380}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, el maestro de jinetes del viento",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "El zepelín aterriza en la torre justo al noreste de la puerta principal de {zone:1454}. Sigue el camino al sur hacia {zone:1411}, cruza el puente sobre {area:815} bajo {area:379} y sigue el camino al oeste hasta {area:380}.",
}
