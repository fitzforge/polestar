-- Spanish (Latin America) (esMX): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["Inside"] = "Adentro",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Zombis descerebrados ({npc:1501})",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Los zombis deambulan por el cementerio y las casas justo al este de la iglesia.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: el pergamino para {npc:244808}",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church; inside"] = "{npc:1661}, junto a la iglesia; adentro",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer; inside"] = "{npc:2119}, el instructor de guerreros; adentro",
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

	-- Step 5: Injured Deathguard
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["{quest:90902}: the {npc:259377} lie around the church. Heal five of them with {spell:635}."] = "{quest:90902}: los {npc:259377} están alrededor de la iglesia. Cura a cinco de ellos con {spell:635}.",

	-- Step 6: Deathknell: kill these as you meet them
	-- {area:154} Deathknell
	["{area:154}: kill these as you meet them"] = "{area:154}: mata a estos según te los encuentres",
	-- {area:154} Deathknell · {npc:1661} Novice Elreth
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side. {npc:1661} wants their paws and wings: kill them as you meet them while you clear the skeletons."] = "Los esqueletos Jaularraída deambulan por las casas en ruinas de la mitad norte de {area:154}. Los carroñeros jóvenes y los murciélagos crepusculares recorren toda la aldea; los carroñeros harapientos y los murciélagos crepusculares sarnosos están en el lado este. {npc:1661} quiere sus zarpas y alas: mátalos según te los encuentres mientras despejas a los esqueletos.",

	-- Step 7: Back to the church
	["Back to the church"] = "De vuelta a la iglesia",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, inside"] = "{npc:1661}, adentro",
	-- {npc:244808} Aramis Hammerhand · {spell:635} Holy Light · {npc:259377} Injured Deathguard
	["{npc:244808}: {spell:635}, once five {npc:259377} are healed"] = "{npc:244808}: {spell:635}, una vez curados cinco {npc:259377}",
	-- {npc:1569} Shadow Priest Sarvis
	["{npc:1569}, inside"] = "{npc:1569}, adentro",
	-- {npc:244808} Aramis Hammerhand
	["{npc:244808}, inside"] = "{npc:244808}, adentro",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, en la iglesia",

	-- Step 8: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662} están junto a las casas en ruinas del norte de {area:154}.",

	-- Step 9: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "De vuelta a {area:154}",

	-- Step 10: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin · {area:155} Night Web's Hollow
	["{quest:91208}: the {npc:246143} fled into the hills west of the church, on the way to {area:155}."] = "{quest:91208}: el {npc:246143} huyó a las colinas al oeste de la iglesia, de camino a {area:155}.",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Ofrece ayuda al {npc:246143}",

	-- Step 11: Night Web's Hollow
	-- {npc:271961} Webbed Forsaken
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the cocooned {npc:271961} are inside.\nCareful: A low-level character can die quickly if it pulls several Night Web Spiders in the cave at the same time."] = "Ve al oeste hasta la cueva. Las arañas Red Nocturna jóvenes están afuera; las arañas Red Nocturna y los {npc:271961} envueltos en capullos están adentro.\nCuidado: Un personaje de nivel bajo puede morir rápido si atrae a varias arañas Red Nocturna en la cueva al mismo tiempo.",
	["Below ground"] = "Bajo tierra",
	["attack the cocoons inside the cave to free them; below ground"] = "ataca los capullos dentro de la cueva para liberarlos; bajo tierra",
	-- {npc:271961} Webbed Forsaken
	["Free the {npc:271961}"] = "Libera a los {npc:271961}",

	-- Step 13: The Scarlet farm
	["The Scarlet farm"] = "La granja Escarlata",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Los Conversos Escarlata ({npc:1506}) y los Iniciados ocupan la granja al este de {area:154}. {npc:1919} deambula entre las casas de la granja: sus restos son para {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, de {npc:1919}",

	-- Step 14: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090} está en el cementerio de {area:154}, junto a la iglesia.",

	-- Step 16: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm.\nCareful: He is flanked by two Scarlet guards, one a convert and the other an initiate, who may join the fight."] = "{npc:1667} está en el extremo sur de la granja Escarlata.\nCuidado: Lo flanquean dos guardias Escarlata, un converso y un iniciado, que pueden unirse a la pelea.",

	-- Step 18: Dark Cleric Duesten
	-- {npc:2123} Dark Cleric Duesten · {npc:2129} Dark Cleric Beryl · {area:159} Brill · {spell:613} Lesser Heal
	["{npc:2123}, the priest trainer in the church, sends you to {npc:2129} in {area:159}. Train {spell:613} (Rank 2) from him now: the wounded guard Beryl sends you to needs it."] = "{npc:2123}, el instructor de sacerdotes en la iglesia, te envía con {npc:2129} en {area:159}. Aprende ahora {spell:613} (rango 2) con él: el guardia herido al que te envía Beryl lo necesita.",
	-- {npc:2123} Dark Cleric Duesten · {npc:2129} Dark Cleric Beryl · {area:159} Brill
	["{npc:2123}: for {npc:2129} in {area:159}"] = "{npc:2123}: para {npc:2129} en {area:159}",

	-- Step 19: Solliden Farmstead
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}; {npc:1519} stands by the road just past it."] = "Sal de {area:154} por el camino al noreste. {npc:6784} está junto a la granja de {area:156}; {npc:1519} está junto al camino, justo más allá.",

	-- Step 20: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Calabazas de Tirisfal ({object:375})",
	["The pumpkins grow in the Scarlet-held fields just north-west of the farmhouse.\nCareful: Farmers stand close to the pumpkins, so you can pull more than one at once. Scarlet mobs are found around the edges of the farm and a bit to the northwest."] = "Las calabazas crecen en los campos en manos de los Escarlata, justo al noroeste de la granja.\nCuidado: Los granjeros están cerca de las calabazas, así que puedes atraer a más de uno a la vez. Hay enemigos Escarlata en los bordes de la granja y un poco al noroeste.",

	-- Step 21: Gordo
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road from here east past {area:166} almost to {area:159}, and back: if he isn't at the arrow, follow the road east until you meet him. The {item:12737} grows along the road around him."] = "{npc:10666}, la gran abominación, recorre el camino desde aquí al este pasando {area:166} casi hasta {area:159}, y de vuelta: si no está donde marca la flecha, sigue el camino al este hasta encontrarlo. {item:12737} crece a lo largo del camino a su alrededor.",

	-- Step 22: Deathguard Dillinger
	-- {npc:1496} Deathguard Dillinger · {npc:1742} Deathguard Bartholomew · {area:159} Brill
	["{npc:1496} and {npc:1742} stand at the west end of {area:159}, where the road from Solliden comes in."] = "{npc:1496} y {npc:1742} están en el extremo oeste de {area:159}, donde entra el camino desde Solliden.",
	-- {npc:1742} Deathguard Bartholomew
	["{npc:1742}, beside Dillinger"] = "{npc:1742}, junto a Dillinger",

	-- Step 23: Junior Apothecary Holland
	-- {area:159} Brill
	["Holland walks around the north side of {area:159}, a few steps from Dillinger."] = "Holland da vueltas por el lado norte de {area:159}, a pocos pasos de Dillinger.",
	-- {npc:10665} Junior Apothecary Holland · {area:159} Brill
	["{npc:10665} walks around {area:159}: look inside the circle on the map"] = "{npc:10665} da vueltas por {area:159}: búscalo dentro del círculo del mapa",

	-- Step 24: Dry Branches
	["Dry Branches"] = "Ramas secas",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Las ramas secas están en el suelo alrededor del borde suroeste de {area:159}.",

	-- Step 25: Eleanor Shackleton
	-- {area:159} Brill · {zone:1458} Undercity
	["Eleanor camps just south-west of town. With a profession learned, she also offers its Camping 101, which its trainer takes: in {area:159}, at Linnea's camp, or in the {zone:1458} in the next guide."] = "Eleanor acampa justo al suroeste del pueblo. Si aprendiste una profesión, también ofrece su misión de Campamento 101, que recibe su instructor: en {area:159}, en el campamento de Linnea o en {zone:1458}, en la siguiente guía.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "Usa /sentarse junto a su fogata hasta obtener {spell:1229451}",

	-- Step 26: Camping 101: First Aid
	-- {npc:5759} Nurse Neela
	["Eleanor: for {npc:5759}"] = "Eleanor: para {npc:5759}",

	-- Step 27: Camping 101: Enchanting
	-- {npc:5695} Vance Undergloom
	["Eleanor: for {npc:5695}"] = "Eleanor: para {npc:5695}",

	-- Step 28: Camping 101: Herbalism
	-- {npc:2114} Faruza
	["Eleanor: for {npc:2114}"] = "Eleanor: para {npc:2114}",

	-- Step 29: Camping 101: Alchemy
	-- {npc:2132} Carolai Anise
	["Eleanor: for {npc:2132}"] = "Eleanor: para {npc:2132}",

	-- Step 30: Camping 101: Skinning
	-- {npc:6289} Rand Rhobart
	["Eleanor: for {npc:6289}"] = "Eleanor: para {npc:6289}",

	-- Step 31: Camping 101: Leatherworking
	-- {npc:3549} Shelene Rhobart
	["Eleanor: for {npc:3549}"] = "Eleanor: para {npc:3549}",

	-- Step 32: Camping 101: Tailoring
	-- {npc:3523} Bowen Brisboise
	["Eleanor: for {npc:3523}"] = "Eleanor: para {npc:3523}",

	-- Step 33: Camping 101: Mining
	-- {npc:4598} Brom Killian
	["Eleanor: for {npc:4598}"] = "Eleanor: para {npc:4598}",

	-- Step 34: Camping 101: Blacksmithing
	-- {npc:4605} Basil Frye
	["Eleanor: for {npc:4605}"] = "Eleanor: para {npc:4605}",

	-- Step 35: Camping 101: Engineering
	-- {npc:4586} Graham Van Talen
	["Eleanor: for {npc:4586}"] = "Eleanor: para {npc:4586}",

	-- Step 36: Brill
	-- {npc:1518} Apothecary Johaan · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren
	["{npc:1518} is in the apothecary's house on the west side of the square, {npc:1515} in front of the inn with the Wanted poster beside him, {npc:1499} in the town hall on the square's north side. The inn comes last, in one go."] = "{npc:1518} está en la casa del boticario, en el lado oeste de la plaza, {npc:1515} frente a la posada con el cartel de Se busca a su lado, y {npc:1499} en el ayuntamiento, en el lado norte de la plaza. La posada va al final, de una vez.",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "{npc:1518}, adentro",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, la instructora de paladines",
	-- {npc:1515} Executor Zygand
	["{npc:1515}, in front of the inn"] = "{npc:1515}, frente a la posada",
	["The Wanted poster by the inn"] = "El cartel de Se busca junto a la posada",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, en el ayuntamiento",

	-- Step 37: Faruza
	-- {npc:2114} Faruza · {quest:97957} Camping 101: Herbalism
	["{npc:2114}, beside Johaan: {quest:97957}"] = "{npc:2114}, junto a Johaan: {quest:97957}",

	-- Step 38: Carolai Anise
	-- {npc:2132} Carolai Anise · {quest:97951} Camping 101: Alchemy
	["{npc:2132}, beside Johaan: {quest:97951}"] = "{npc:2132}, junto a Johaan: {quest:97951}",

	-- Step 39: Carolai Anise
	-- {npc:2132} Carolai Anise · {area:159} Brill
	["From level 7 {npc:2132}, beside Johaan in the apothecary's house, offers her elixir quest; below 7 it waits for the next {area:159} visit."] = "Desde el nivel 7, {npc:2132}, junto a Johaan en la casa del boticario, ofrece su misión del elixir; por debajo de 7, espera a la próxima visita a {area:159}.",
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan; inside"] = "{npc:2132}, junto a Johaan; adentro",

	-- Step 40: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Usa {item:286176} en cinco Guardias de la Muerte ociosos por el pueblo",

	-- Step 42: Gallows' End Tavern
	-- {npc:5688} Innkeeper Renee · {npc:265944} William Pickman · {npc:1931} Captured Scarlet Zealot · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Everything here is inside the inn, through its door on the south side: {npc:5688} at the bar, {npc:265944} at the north end of the ground floor, the {npc:1931} in the cellar under that end, and {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) upstairs: take the stairs inside, the arrow cannot tell the floors apart."] = "Todo aquí está dentro de la posada, por su puerta del lado sur: {npc:5688} en la barra, {npc:265944} en el extremo norte de la planta baja, {npc:1931} en el sótano debajo de ese extremo, y {npc:2128} (magos), {npc:2129} (sacerdotes), {npc:2127} (brujos) y {npc:2130} (pícaros) en el piso de arriba: sube por la escalera de adentro, la flecha no distingue los pisos.",
	-- {npc:265944} William Pickman
	["{npc:265944}, at the inn's north end: Camping 101 asks you to learn it"] = "{npc:265944}, en el extremo norte de la posada: Campamento 101 te pide aprenderla",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the inn's cellar"] = "{npc:1931}, en el sótano de la posada",
	-- {area:159} Brill · {npc:2131} Austil de Mon · {npc:246152} Shari Stilwell
	["The {area:159} trainers are in the inn ({npc:2131} downstairs, the rest upstairs); {npc:246152}, the Paladin trainer, by the square"] = "Los instructores de {area:159} están en la posada ({npc:2131} abajo, el resto arriba); {npc:246152}, la instructora de paladines, junto a la plaza",
	-- {npc:2129} Dark Cleric Beryl
	["{npc:2129}, upstairs"] = "{npc:2129}, en el piso de arriba",

	-- Step 43: Nurse Neela
	-- {npc:5759} Nurse Neela · {quest:97955} Camping 101: First Aid
	["{npc:5759}, by the bar: {quest:97955}"] = "{npc:5759}, junto a la barra: {quest:97955}",

	-- Step 45: Coleman Farthing and Gretchen Dedmar
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar
	["{npc:1500} and {npc:1521}"] = "{npc:1500} y {npc:1521}",
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar · {area:159} Brill
	["Still in the inn: from level 7 {npc:1500} on the ground floor and {npc:1521} upstairs offer their quests; below 7 they wait for the next {area:159} visit."] = "Todavía en la posada: desde el nivel 7, {npc:1500} en la planta baja y {npc:1521} arriba ofrecen sus misiones; por debajo de 7, esperan a la próxima visita a {area:159}.",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, en la posada",
	-- {npc:1521} Gretchen Dedmar
	["{npc:1521}, upstairs"] = "{npc:1521}, en el piso de arriba",

	-- Step 46: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Campamento de {npc:1495}",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Sigue el camino al sureste desde {area:159} pasando las torres de zepelín. Linnea, Kristof y {npc:3549} acampan junto al camino.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Pídele su informe a {npc:251001}",

	-- Step 47: Rand Rhobart
	-- {npc:6289} Rand Rhobart · {npc:3549} Shelene Rhobart · {quest:97960} Camping 101: Skinning
	["{npc:6289}, beside {npc:3549}: {quest:97960}"] = "{npc:6289}, junto a {npc:3549}: {quest:97960}",

	-- Step 49: Deathguard Dillinger
	-- {area:159} Brill
	["Back up the road and through {area:159} to its west end."] = "Vuelve por el camino y cruza {area:159} hasta su extremo oeste.",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Pídele su informe a {npc:1496}",

	-- Step 50: Cold Hearth Manor: kill these as you meet them
	-- {area:166} Cold Hearth Manor
	["{area:166}: kill these as you meet them"] = "{area:166}: mata a estos según te los encuentres",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo · {npc:3549} Shelene Rhobart
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse · Decrepit Darkhounds = {npc:1547} Decrepit Darkhound
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Decrepit Darkhounds roam there and on west along the road toward {npc:10666}. Johaan wants their blood, {npc:3549} their hides."] = "{npc:1525} y los cadáveres destrozados se arrastran por los campos justo al oeste de {area:159}; los canes oscuros decrépitos rondan ahí y más al oeste por el camino hacia {npc:10666}. Johaan quiere su sangre, {npc:3549} sus pieles.",

	-- Step 51: Bowen Brisboise
	-- {npc:3523} Bowen Brisboise · {area:159} Brill · {quest:97961} Camping 101: Tailoring
	["{npc:3523}, by the road west of {area:159}: {quest:97961}"] = "{npc:3523}, junto al camino al oeste de {area:159}: {quest:97961}",

	-- Step 52: Gordo
	-- {npc:10666} Gordo · {area:159} Brill · {area:166} Cold Hearth Manor
	["{npc:10666} walks the long road west of {area:159}, past {area:166}, and back: the arrow follows his road west until you meet him."] = "{npc:10666} recorre el largo camino al oeste de {area:159}, pasando {area:166}, y de vuelta: la flecha sigue su camino al oeste hasta que lo encuentres.",
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Pídele su informe a {npc:10666}",

	-- Step 53: Calvin Montague
	-- {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["{npc:6784} stands by the farmhouse at the {area:156}, on the way to the Crusader's Outpost."] = "{npc:6784} está junto a la granja de {area:156}, de camino al Puesto de los Cruzados.",
	-- {npc:6784} Calvin Montague · {npc:5688} Innkeeper Renee
	["{npc:6784}, by the farmhouse: talk to him for the duel; he offers it once {npc:5688} has his letter"] = "{npc:6784}, junto a la granja: habla con él para el duelo; lo ofrece una vez que {npc:5688} tiene su carta",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Vence a {npc:6784} en el duelo",

	-- Step 54: Crusader's Outpost
	["Crusader's Outpost"] = "Avanzada de los Cruzados",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost north-west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out.\nCareful: Scarlet Warriors are level 6-7 and not elite. Once their health falls to 15% they run off to bring help, so more of them may join the fight."] = "Los guerreros Escarlata custodian el puesto al noroeste de los campos de calabazas. {npc:275954} está retenido adentro: habla con él y quédate a su lado hasta que salga.\nCuidado: Los guerreros Escarlata son de nivel 6-7 y no son élite. Cuando bajan al 15 % de salud huyen a buscar ayuda, así que más pueden unirse a la pelea.",
	-- {npc:275954} Bareth Dawnstone
	["{npc:275954}, on the top floor"] = "{npc:275954}, en el piso superior",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Escolta a {npc:275954} fuera de la avanzada",

	-- Step 55: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back east along the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "De vuelta al este por el camino hasta {area:159}. {npc:2128} (magos), {npc:2129} (sacerdotes), {npc:2127} (brujos) y {npc:2130} (pícaros) están en el piso de arriba de la posada: sube por la escalera de adentro, la flecha no distingue los pisos.",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} de {npc:2118}, para Gretchen",

	-- Step 56: Deathguard Kel
	-- {npc:12428} Deathguard Kel · {area:159} Brill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12428} kneels by the north gate of {area:159}'s graveyard, on your way north. Cast {spell:613} (Rank 2) on him, then {spell:1243}: Fortitude first does not count."] = "{npc:12428} está arrodillado junto a la puerta norte del cementerio de {area:159}, de camino al norte. Lánzale {spell:613} (rango 2) y luego {spell:1243}: si lanzas Entereza primero, no cuenta.",
	-- {npc:12428} Deathguard Kel
	["Heal and fortify {npc:12428}"] = "Cura y fortalece a {npc:12428}",

	-- Step 57: Tirisfal Glades: kill these as you meet them
	-- {zone:1420} Tirisfal Glades
	["{zone:1420}: kill these as you meet them"] = "{zone:1420}: mata a estos según te los encuentres",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart · {quest:5482} Doom Weed · {npc:1753} Maggot Eye
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat · Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber · Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["Greater Duskbats fly over the fields around {area:159} and along the road north: Gretchen wants their pelts, {npc:3549} their wings.\nThe {quest:5482} grows in the graveyard fields just north of {area:159}, where the Rot Hide Graverobbers dig; all the Rot Hides drop the ichor.\nThe Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first.\nCareful: Gnoll guards stand outside the hut and can join the fight. If you slip past them and fight him inside, he fights alone.\nThe Vile Fin murlocs line the north shore: they all drop the scales, and the Minor Oracles and Muckdwellers the skins for {npc:3549}."] = "Los murciélagos crepusculares mayores sobrevuelan los campos alrededor de {area:159} y a lo largo del camino al norte: Gretchen quiere sus pieles, {npc:3549} sus alas.\n{quest:5482} crece en los campos del cementerio justo al norte de {area:159}, donde excavan los ladrones de tumbas Pellejo Podrido; todos los Pellejo Podrido sueltan el icor.\nLos chuchos Pellejo Podrido ocupan las colinas más al norte. {npc:1753} (nivel 11) está en su campamento, en la colina al sur de la orilla: despeja primero a los gnolls a su alrededor.\nCuidado: Hay guardias gnoll afuera de la choza que pueden unirse a la pelea. Si pasas sin que te vean y lo enfrentas adentro, pelea solo.\nLos múrlocs Aleta Vil ocupan la orilla norte: todos sueltan las escamas, y los oráculos menores y los moradores del fango, las pieles para {npc:3549}.",
	-- {npc:1675} Rot Hide Mongrel · {area:164} Garren's Haunt
	["{npc:1675} walks around {area:164}: look inside the circle on the map"] = "{npc:1675} da vueltas por {area:164}: búscalo dentro del círculo del mapa",
	-- {item:3635} Maggot Eye's Paw
	["{item:3635}; inside"] = "{item:3635}; adentro",

	-- Step 58: Brill
	-- {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["{npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:2128} (magos), {npc:2129} (sacerdotes), {npc:2127} (brujos) y {npc:2130} (pícaros) están en el piso de arriba de la posada: sube por la escalera de adentro, la flecha no distingue los pisos.",
	-- {npc:246152} Shari Stilwell · {quest:91282} A Second Home · {quest:96899} Bandarion Keep
	["{npc:246152}, the Paladin trainer: {quest:91282}, to {quest:96899}"] = "{npc:246152}, la instructora de paladines: {quest:91282}, hacia {quest:96899}",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, inside"] = "{npc:1499}, adentro",
	-- {npc:2129} Dark Cleric Beryl · {item:16607} Acolyte's Sacrificial Robes
	["{npc:2129}, upstairs: the {item:16607}"] = "{npc:2129}, en el piso de arriba: {item:16607}",

	-- Step 59: Deathguard Terrence
	-- {npc:1738} Deathguard Terrence · {quest:96895} The Argent Emissary · {npc:267009} Hadric Harlson · {area:159} Brill · {area:157} Agamand Mills
	["From level 10 {npc:1738} offers {quest:96895}: {npc:267009} waits at Linnea's camp, the next stop. Below 10 it waits for the {area:159} visit after {area:157}."] = "Desde el nivel 10, {npc:1738} ofrece {quest:96895}: {npc:267009} espera en el campamento de Linnea, la próxima parada. Por debajo de 10, espera a la visita a {area:159} después de {area:157}.",

	-- Step 60: Deathguard Linnea's camp
	-- {area:159} Brill
	["Follow the road south-east from {area:159} past the zeppelin towers."] = "Sigue el camino al sureste desde {area:159}, pasando las torres del zepelín.",

	-- Step 61: Hadric Harlson
	-- {npc:267009} Hadric Harlson
	["{npc:267009} stands at the camp beside Linnea."] = "{npc:267009} está en el campamento, junto a Linnea.",

	-- Step 62: Magistrate Sevren
	-- {area:159} Brill · {area:157} Agamand Mills
	["Back up the road to {area:159}, on the way north-west to {area:157}."] = "Vuelve por el camino hasta {area:159}, de camino al noroeste hacia {area:157}.",

	-- Step 63: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}.\nCareful: Rotting undead and Darkeye Bonecasters near the Agamands can join a fight as adds."] = "Sigue el camino al noroeste hasta {area:157}. {npc:1657} recorre el cementerio al sur de los molinos; Nissa, Gregor y {npc:1656} rondan los molinos. Los soldados Jaularraída y Cráneo Rajado sueltan las costillas, los lanzahuesos Ojoscuro los cráneos, y cualquiera puede soltar {item:2839}.\nCuidado: Los no-muertos podridos y los lanzahuesos Ojoscuro cerca de los Agamand pueden unirse a una pelea.",
	-- {npc:1655} Nissa Agamand
	["{npc:1655}; upstairs"] = "{npc:1655}; en el piso de arriba",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, botín raro",
	["Only if the letter dropped"] = "Solo si te salió la carta",

	-- Step 64: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, en la posada",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {npc:4568} en {zone:1458} la recibe",
	-- {npc:5724} Ageron Kargal · {npc:5675} Carendin Halgar · {zone:1458} Undercity
	["{npc:5724}: {npc:5675} in the {zone:1458} takes it"] = "{npc:5724}: {npc:5675} en {zone:1458} la recibe",
	-- {npc:1738} Deathguard Terrence · {area:159} Brill
	["{npc:1738}, if you were below 10 on the last {area:159} visit"] = "{npc:1738}, si estabas por debajo de 10 en la última visita a {area:159}",

	-- Step 65: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:6390} espera en el mausoleo de la colina justo al norte del pueblo: abre la reja y pelea con él.",

	-- Step 66: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Camina al sur desde {area:159} hasta {area:153} y baja a {zone:1458}. {npc:5675} está en {object:36082}. El campamento Escarlata está justo al oeste de las ruinas.",
	-- {npc:5675} Carendin Halgar · {quest:1473} Creature of the Void
	["{npc:5675}: he offers {quest:1473} only once this is handed in"] = "{npc:5675}: solo ofrece {quest:1473} cuando hayas entregado esta",

	-- Step 67: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Camina al sur desde {area:159} hasta {area:153} y baja a {zone:1458}. {npc:4568} está en {object:36082}. El campamento Escarlata está justo al oeste de las ruinas.",

	-- Step 68: Back to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Back to {zone:1420}"] = "De vuelta a {zone:1420}",
	["The Scarlet camp"] = "El campamento Escarlata",

	-- Step 69: Tirisfal Glades: kill these as you meet them
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Sigue el camino al suroeste desde {area:159} hasta el campamento de la Cruzada Escarlata. {npc:1662} está en su extremo sur; cualquier Escarlata de allí puede soltar un anillo.",
	-- {npc:1537} Scarlet Zealot
	["{npc:1537} walks around here: look inside the circle on the map"] = "{npc:1537} da vueltas por aquí: búscalo dentro del círculo del mapa",

	-- Step 70: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098} está junto a {npc:1662}, en el extremo sur del campamento.",

	-- Step 72: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp, on the road to the cult's farm."] = "{npc:267009} está en el campamento de {npc:1495}, en el camino a la granja del culto.",

	-- Step 73: Tirisfal Glades: kill these as you meet them
	-- {npc:1495} Deathguard Linnea
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["Follow the road south-east past {npc:1495}'s camp: the Cult of the Damned holds the farm just south-east of it. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "Sigue el camino al sureste pasando el campamento de {npc:1495}: el Culto de los Malditos ocupa la granja justo al sureste. Los Fragmentos de cristal necrótico están en el suelo entre los sectarios, y los sectarios también llevan algunos.",

	-- Step 74: Balnir Farmstead: kill these as you meet them
	-- {area:165} Balnir Farmstead
	["{area:165}: kill these as you meet them"] = "{area:165}: mata a estos según te los encuentres",
	-- {quest:99142} Tomb Weed · {npc:1664} Captain Vachon
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit · Scarlet Friars = {npc:1538} Scarlet Friar
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows: Linnea wants eight of each.\nThe Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them.\nThe spiders lurk in the woods at the far east end of the glades."] = "Sigue el camino al este. Los horrores sangrantes y los espíritus errantes rondan las tumbas en el lado este de la granja, donde crece {quest:99142}: Linnea quiere ocho de cada uno.\nLos frailes Escarlata acampan justo al noreste de las tumbas; {npc:1664} está entre ellos.\nLas arañas acechan en el bosque del extremo este de los claros.",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, en el huerto de la hacienda",

	-- Step 76: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back up the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "Vuelve por el camino hasta {area:159}. {npc:2128} (magos), {npc:2129} (sacerdotes), {npc:2127} (brujos) y {npc:2130} (pícaros) están en el piso de arriba de la posada: sube por la escalera de adentro, la flecha no distingue los pisos.",
	-- {npc:1518} Apothecary Johaan · {area:228} Sepulcher
	["{npc:1518}: for Renferrel at the {area:228}"] = "{npc:1518}: para Renferrel en {area:228}",
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the inn's cellar"] = "{npc:2211}, en el sótano de la posada",

	-- Step 77: Leonid Barthalomew the Revered
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {area:16881} Shadowvale
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Every class can take both quests once {quest:96896} is handed in (level 10). They send you into the cellar under {area:16881}, the next stop."] = "Sigue el camino al oeste pasando {area:157} hasta {area:16616}. Leonid está justo al norte del campamento de {npc:246389}.\n{npc:246389} y {npc:259190} acampan en el borde del bosque, justo al sur de Leonid. Todas las clases pueden tomar ambas misiones una vez entregada {quest:96896} (nivel 10). Te mandan al sótano debajo de {area:16881}, la próxima parada.",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Escucha a Leonid y a {npc:246378}; luego habla con él de nuevo",

	-- Step 78: Paladin: Bandarion Keep
	-- {quest:96899} Bandarion Keep
	["Paladin: {quest:96899}"] = "Paladín: {quest:96899}",
	-- {npc:246349} Breton Samuels
	["{npc:246349} waits at the keep's gate beside Leonid."] = "{npc:246349} espera en la puerta del bastión, junto a Leonid.",

	-- Step 79: Paladin: Murlocs at the Gates
	-- {quest:91285} Murlocs at the Gates
	["Paladin: {quest:91285}"] = "Paladín: {quest:91285}",
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs lurk on the bluffs just east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "Los múrlocs Aleta Vil acechan en los riscos justo al este del bastión y en los campamentos alrededor del lago al suroeste, de camino bajando a {area:16881}.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Atacantes Anca Vil",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Videntes Anca Vil",

	-- Step 80: Shadowvale
	-- {area:16881} Shadowvale · {area:16616} Whispering Forest
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades, south-west of the {area:16616}. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "{area:16881} es la hondonada en el borde oeste de los claros, al suroeste de {area:16616}. Baja al gran sótano debajo de la casa en ruinas (solo queda un piso y unos pilares, no la casa de dos plantas): las botellas están en el suelo entre los tambaleantes y místicos de Valle Umbrío.",
	["the basement under the ruined house"] = "el sótano debajo de la casa en ruinas",
	-- {item:286269} Glowing Crystal Fragment
	["the {item:286269}, at the basement's south end"] = "{item:286269}, en el extremo sur del sótano",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["the Shadowvale Lurchers and Mystics drop the bones; below ground"] = "los tambaleantes y místicos de Valle Umbrío sueltan los huesos; bajo tierra",

	-- Step 81: Hilda the Breaker and Ephram Barbaro
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190}"] = "{npc:246389} y {npc:259190}",
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Back up to the forest's edge south of the keep's gate: {npc:246389} and {npc:259190} take the bones and the crystal."] = "Vuelve a subir al borde del bosque al sur de la puerta del bastión: {npc:246389} y {npc:259190} reciben los huesos y el cristal.",

	-- Step 82: Paladin: Bandarion Keep
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker · {npc:246349} Breton Samuels · {npc:246393} Jorin Croge · {npc:246394} Ander Solliden · {npc:246378} Danitha Morr
	["{npc:259190} and {npc:246389} at the forest's edge, {npc:246349} at the gate, {npc:246393} and {npc:246394} nearby, {npc:246378} inside."] = "{npc:259190} y {npc:246389} en el borde del bosque, {npc:246349} en la puerta, {npc:246393} y {npc:246394} cerca, y {npc:246378} adentro.",
	-- {npc:246378} Danitha Morr
	["{npc:246378}, inside the keep"] = "{npc:246378}, dentro del bastión",

	-- Step 83: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} está bajo {area:153}, junto a las torres de zepelín. {npc:5675} está en {object:36082}: usa {item:6284} en el círculo de invocación a su lado y derrota al abisario. {npc:4606} está en {object:36070}. {npc:4568} también está en {object:36082}.",

	-- Step 85: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, inside"] = "{npc:2132}, adentro",
	-- {area:159} Brill · {zone:1421} Silverpine Forest
	["The next guide walks south from {area:159} into {zone:1421}."] = "La siguiente guía va caminando al sur desde {area:159} hacia {zone:1421}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:159}."] = "De vuelta a {area:159}.",
	-- ["Back up the road to {area:159}."] = "De vuelta por el camino a {area:159}.",
	-- ["Balnir graves"] = "Tumbas de Balnir",
	-- ["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Los murciumbríos y canes oscuros recorren todo el camino de regreso al oeste; termina las alas y pellejos en el camino.",
	-- ["Eleanor camps just south-west of town."] = "Eleanor acampa justo al suroeste del pueblo.",
	-- ["Fields west of {area:159}"] = "Campos al oeste de {area:159}",
	-- ["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Sigue el camino al este hasta {area:159}. {npc:10665} está en el borde noroeste del pueblo; {area:2119} es la gran posada del centro, con {npc:1515} enfrente.",
	-- ["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Sigue el camino al este. Los Horrores sangrantes ({npc:1529}) y los Espíritus deambulantes ({npc:1532}) rondan las tumbas del lado este de la hacienda, donde crece {quest:99142}.",
	-- ["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Sigue el camino al noreste desde {area:159} pasando {area:162}. {npc:1665} y sus dos Guardaespaldas Escarlata ({npc:1660}) ocupan la torre de vigilancia Escarlata en la costa noreste, al norte de {area:459}: atrae primero a los guardaespaldas.",
	-- ["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Sigue el camino al noroeste hasta {area:157}. {npc:1657} recorre el cementerio al sur de los molinos; Nissa, Gregor y {npc:1656} rondan los molinos. Los Soldados armadóseos y los Soldados testapartida ({npc:1523}) sueltan las costillas, los Tirahuesos Ojosombra ({npc:1522}) los cráneos, y cualquiera puede soltar {item:2839}. De aquí en adelante, mata a los murciumbríos y canes oscuros que encuentres: {npc:3549} quiere sus alas y pellejos.",
	-- ["Follow the road south back to {area:159}."] = "Sigue el camino al sur de vuelta a {area:159}.",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Sigue el camino al oeste pasando {area:157} hasta {area:16616}. Leonid está justo al norte del campamento de {npc:246389}.",
	-- ["Free six Webbed Victims inside the cave for {npc:244808}"] = "Libera a seis víctimas envueltas en telaraña dentro de la cueva para {npc:244808}",
	-- ["Greater Duskbats"] = "Murciumbríos superiores ({npc:1553})",
	-- ["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Los Murciumbríos superiores ({npc:1553}) vuelan sobre los campos alrededor de {area:159} y a lo largo del camino al norte.",
	-- ["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Ve al oeste hacia {area:16616}; {npc:246389} y {npc:259190} acampan en su borde.",
	-- ["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Ve al oeste hasta la cueva. Las Nocturácnidas jóvenes ({npc:1504}) están afuera; las Arañas nocturácnidas ({npc:1505}) y las víctimas envueltas en telaraña están adentro.",
	-- ["Hearth to {area:159}"] = "Usa tu piedra de hogar para ir a {area:159}",
	-- ["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Sal de {area:154} por el camino del noreste. {npc:6784} está junto a la casa de {area:156}.",
	-- ["More Vile Fin murlocs walk the shore just north of the outpost."] = "Más múrlocs Anca Vil recorren la orilla justo al norte de la avanzada.",
	-- ["Paladin: {area:16616}"] = "Paladín: {area:16616}",
	-- ["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Paladines: {quest:90902} se completa cuando hayas curado a cinco {npc:259377} alrededor de la iglesia con {spell:635}.",
	-- ["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Los Esqueletos armadóseos ({npc:1890}) deambulan por las casas en ruinas de la mitad norte de {area:154}. Los Carroñeros jóvenes ({npc:1508}) y los Murciumbríos recorren todo el pueblo; los Carroñeros pulgosos ({npc:1509}) y los Murciumbríos sarnosos ({npc:1513}) están en su lado este.",
	-- ["Rattlecage skulls"] = "Cráneos de armadóseo",
	-- ["Rattlecages, scavengers and duskbats"] = "Armadóseos, carroñeros y murciumbríos",
	-- ["Rot Hide graveyards"] = "Cementerios Putrepellejo",
	-- ["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Los Guerreros Escarlata ({npc:1535}) custodian la avanzada justo al oeste de los campos de calabazas. {npc:275954} está cautivo adentro: habla con él y quédate a su lado hasta que salga.",
	-- ["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Toma el camino al sureste desde {area:159}; Terrence está en él, antes de las torres de zepelín.",
	-- ["Talk to {npc:265944}"] = "Habla con {npc:265944}",
	-- ["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Los Esqueletos armadóseos ({npc:1890}) de las casas en ruinas sueltan los cráneos.",
	-- ["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Los Asaltatumbas Putrepellejo ({npc:1941}) excavan en los cementerios al norte de {area:159}; todos los Putrepellejo sueltan el icor.",
	-- ["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Los Bastardos Putrepellejo ({npc:1675}) ocupan las colinas más al norte. {npc:1753} (nivel 11) está en su campamento, en la colina al sur de la orilla: primero acaba con los gnolls a su alrededor.",
	-- ["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Los Frailes Escarlata ({npc:1538}) acampan justo al noreste de las tumbas; {npc:1664} está entre ellos.",
	-- ["The Vile Fin murlocs line the north shore."] = "Los múrlocs Anca Vil se alinean en la orilla norte.",
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Las calabazas crecen en los campos tomados por la Cruzada Escarlata, al noroeste de Solliden.",
	-- ["The spiders lurk in the woods at the far east end of the glades."] = "Las arañas acechan en el bosque del extremo este de los claros.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "Las arañas acechan en el bosque del extremo este de los claros. {npc:276020}, una abominación descontrolada, deambula justo al noroeste. {npc:276020} es élite: se recomienda ir en grupo.",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "El zepelín aterriza en la torre justo al noreste de la puerta principal de {zone:1454}. Sigue el camino al sur hacia {zone:1411}, cruza el puente sobre {area:815} bajo {area:379} y sigue el camino al oeste hasta {area:380}.",
	-- ["The {area:159} trainers are in and around the inn"] = "Los instructores de {area:159} están dentro y alrededor de la posada",
	-- ["The {npc:1931}, in the town hall basement"] = "El {npc:1931}, en el sótano del ayuntamiento",
	-- ["The {npc:2211}, in the town hall basement"] = "El {npc:2211}, en el sótano del ayuntamiento",
	-- ["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482} crece en los campos del cementerio justo al norte de {area:159}.",
	-- ["Vicious Night Web Spiders"] = "Nocturácnidas sañosas ({npc:1555})",
	-- ["Vile Fin murlocs"] = "Múrlocs Anca Vil",
	-- ["Vile Fin shore"] = "Orilla Anca Vil",
	-- ["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "Sigue caminando al oeste hasta {area:156}. {npc:1519} está en la granja; {npc:6784}, junto a la casa, quiere un duelo: habla con él.",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Sigue caminando al oeste hasta {npc:6784} y habla con él: quiere un duelo.",
	-- ["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Camina al sureste desde {area:159} hasta las torres de zepelín afuera de {area:153} y sube al zepelín a {zone:1454} (el otro va a {object:3202}).",
	-- ["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Camina al suroeste desde los molinos: las calabazas crecen en los campos tomados por la Cruzada Escarlata, al noroeste de Solliden.",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Camina al suroeste hasta {area:156}; Simmer está en la granja.",
	-- ["Webbed Victims"] = "Víctimas envueltas en telaraña",
	-- ["With {skill:129} learned, Eleanor also offers its Camping 101: {npc:5759} in the {area:159} inn takes it."] = "Con {skill:129} aprendido, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:5759}, en la posada de {area:159}.",
	-- ["With {skill:164} learned, Eleanor also offers its Camping 101: {npc:4605} in the {zone:1458} (next guide) takes it."] = "Con {skill:164} aprendida, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:4605}, en {zone:1458} (siguiente guía).",
	-- ["With {skill:165} learned, Eleanor also offers its Camping 101: {npc:3549} at {npc:1495}'s camp takes it."] = "Con {skill:165} aprendida, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:3549}, en el campamento de {npc:1495}.",
	-- ["With {skill:171} learned, Eleanor also offers its Camping 101: {npc:2132} in {area:159} takes it."] = "Con {skill:171} aprendida, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:2132}, en {area:159}.",
	-- ["With {skill:182} learned, Eleanor also offers its Camping 101: {npc:2114} in {area:159} takes it."] = "Con {skill:182} aprendida, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:2114}, en {area:159}.",
	-- ["With {skill:186} learned, Eleanor also offers its Camping 101: {npc:4598} in the {zone:1458} (next guide) takes it."] = "Con {skill:186} aprendida, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:4598}, en {zone:1458} (siguiente guía).",
	-- ["With {skill:197} learned, Eleanor also offers its Camping 101: {npc:3523} on the road west of {area:159} takes it."] = "Con {skill:197} aprendida, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:3523}, junto al camino al oeste de {area:159}.",
	-- ["With {skill:202} learned, Eleanor also offers its Camping 101: {npc:4586} in the {zone:1458} (next guide) takes it."] = "Con {skill:202} aprendida, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:4586}, en {zone:1458} (siguiente guía).",
	-- ["With {skill:333} learned, Eleanor also offers its Camping 101: {npc:5695} in the {area:159} inn takes it."] = "Con {skill:333} aprendido, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:5695}, en la posada de {area:159}.",
	-- ["With {skill:393} learned, Eleanor also offers its Camping 101: {npc:6289} at {npc:1495}'s camp takes it."] = "Con {skill:393} aprendido, Eleanor también ofrece su misión de Campamento 101: la recibe {npc:6289}, en el campamento de {npc:1495}.",
	-- ["Zeppelin to {zone:1411}"] = "Zepelín a {zone:1411}",
	-- ["Zeppelin tower"] = "Torre del zepelín",
	-- ["in the inn: ask him about cooking"] = "en la posada: pregúntale por la cocina",
	-- ["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} es la hondonada del borde oeste de los claros. Los Merodeadores vallesombra ({npc:260428}) y los Místicos sueltan los huesos; las botellas están en el suelo entre ellos y {item:286269} está en el extremo sur.",
	-- ["{item:286326}, from {npc:276020}"] = "{item:286326}, de {npc:276020}",
	-- ["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, la gran abominación, recorre el camino un poco más al este. {item:12737} crece a lo largo del camino a su alrededor.",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: {npc:276020}, una abominación élite en el este",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} está en {area:159}. {npc:6390} espera en el mausoleo de la colina justo al norte del pueblo: abre la reja y pelea con él.",
	-- ["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} y los Cuerpos devastados ({npc:1526}) deambulan por los campos justo al oeste de {area:159}; los canes oscuros recorren la zona un poco más al oeste, hacia {npc:10666}.",
	-- ["{npc:1661}, beside the church"] = "{npc:1661}, junto a la iglesia",
	-- ["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} está en el extremo sur de la granja Escarlata.",
	-- ["{npc:2119}, the warrior trainer"] = "{npc:2119}, el instructor de guerreros",
	-- ["{npc:2132}, beside Johaan"] = "{npc:2132}, junto a Johaan",
	-- ["{npc:244808} and {npc:5667}"] = "{npc:244808} y {npc:5667}",
	-- ["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} y {npc:5667} están junto a la iglesia.",
	-- ["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} está en el campamento de {npc:1495}.",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, el maestro de jinetes del viento",
	-- ["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: el {npc:246143} huyó a las colinas justo al oeste de la iglesia.",
	-- ["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} ocupa la granja justo al sureste del campamento. Los fragmentos de cristal necrótico ({item:275851}) están en el suelo entre los sectarios, y los sectarios también llevan algunos.",
}
