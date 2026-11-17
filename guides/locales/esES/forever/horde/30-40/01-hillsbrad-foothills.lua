-- Spanish (Spain) (esES): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:527} Battle of Hillsbrad · {area:272} Tarren Mill
	["For characters of 29 to 31: the {quest:527}, {area:272}'s errands and the gnolls of the foothills, all at or under your level."] = "Para personajes de nivel 29 a 31: {quest:527}, los encargos de {area:272} y los gnolls de las laderas, todo a tu nivel o por debajo.",

	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 7: Korran
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows · {zone:1454} Orgrimmar
	["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29; below it, the next guide's {zone:1454} stop takes it."] = "{npc:3428} está junto al maestro de vuelo de El Cruce. {quest:1145} está disponible desde el nivel 29; si no llegas, la parada en {zone:1454} de la siguiente guía la recoge.",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	["Crossroads flight master"] = "Maestro de vuelo del Cruce",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Fuerte Grommash, si la llevas",

	-- Step 10: Train
	["Train"] = "Entrena",
	["Train your new spells."] = "Entrena tus nuevos hechizos.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 13: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "",

	-- Step 14: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 15: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "",

	-- Step 16: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "",

	-- Step 18: Tarren Mill
	-- {quest:567} Dangerous! · {npc:2216} Apothecary Lydon · {npc:2393} Christoph Jeffcoat
	["The {quest:567} poster hangs by the inn; {npc:2216} stands inside it. {npc:2393}, the cook by the inn, wants turtle meat and sells the spices for it."] = "El cartel de {quest:567} cuelga junto a la posada; {npc:2216} está dentro. {npc:2393}, el cocinero junto a la posada, quiere carne de tortuga y vende las especias para ella.",
	-- {quest:567} Dangerous!
	["{quest:567}, the poster by the inn"] = "{quest:567}, el cartel junto a la posada",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",
	-- {npc:2393} Christoph Jeffcoat · {quest:7321} Soothing Turtle Bisque
	["{npc:2393}: {quest:7321}, the Snapjaws of the river south of town"] = "{npc:2393}: {quest:7321}, las Bocadientes del río al sur del pueblo",
	-- {item:3713} Soothing Spices · {npc:2393} Christoph Jeffcoat
	["{item:3713}, from {npc:2393}"] = "{item:3713}, de {npc:2393}",

	-- Step 19: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "Te perdiste los primeros encargos de Darthalia, de la guía de {area:287} 22-25: ahora van primero. Están unos niveles por debajo de ti y son rápidos, y abren el resto de {quest:527} en esta guía.",

	-- Step 20: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275}."] = "{npc:2229} quiere que liberes a sus dos exploradores de {area:275}.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",

	-- Step 21: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "Al oeste, pasadas las colinas, hasta las granjas al este del pueblo de {area:287}. {npc:232} trabaja el campo junto a la casa de labranza del norte, y {npc:2403}, el que está más al sureste; hay Mozos de labranza y Granjeros por todas partes.\nCuidado: los guardias del Kirin Tor (55) patrullan los campos y caminos de {area:287} y atacan a la Horda: vigílalos y apártate de su camino.",

	-- Step 22: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "",

	-- Step 23: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "Campesinos de Trabalomas",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "Vuelve a los campos: los Campesinos trabajan al sur de las casas de labranza. Cuidado: un campesino que huye y llega al ayuntamiento puede volver con refuerzos; las ralentizaciones o los enraizamientos impiden que escapen.",

	-- Step 26: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "Al sureste del Molino Tarren. Drull y {npc:2238} están encadenados en los edificios del patio de la fortaleza: {npc:2427} lleva la {item:3467} y {npc:2428}, la {item:3499}, ambos dentro de la fortaleza. Mátalos y luego abre ambos candados.",
	["Drull's ball and chain"] = "La bola y cadena de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "La bola y cadena de {npc:2238}",

	-- Step 27: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "Vuelve a {area:272}.",

	-- Step 28: The river south of Tarren Mill: kill these as you meet them
	-- {area:272} Tarren Mill
	["The river south of {area:272}: kill these as you meet them"] = "El río al sur de {area:272}: mátalos según te los encuentres",
	-- {area:272} Tarren Mill · {area:271} Southshore · {item:3712} Turtle Meat
	["South from {area:272} along the river: Snapjaws (29) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "Al sur de {area:272}, siguiendo el río: las Bocadientes (29) toman el sol en sus orillas hasta las colinas sobre {area:271}. Algunas llevan {item:3712}.",
	-- {item:3712} Turtle Meat
	["{item:3712}, from the Snapjaws"] = "{item:3712}, de las Bocadientes",

	-- Step 29: Mudsnout Blossoms
	-- {area:290} Dun Garok
	["South of the river's bend, the Mudsnout gnolls (26-28) camp in the hills above {area:290}; the blossoms grow among their tents. The Shamans heal and call their friends: pull them first."] = "Al sur del recodo del río, los gnolls Morrobarro (26-28) acampan en las colinas sobre {area:290}; las flores crecen entre sus tiendas. Los chamanes curan y llaman a sus compañeros: atráelos primero.",

	-- Step 30: North of Southshore
	["North of Southshore"] = "Al norte de Costasur",
	-- {area:287} Hillsbrad · {area:271} Southshore
	["From the blossoms, back north along the river and then west to {area:287} town, well north of {area:271} (its guards are 55)."] = "Desde las flores, vuelve al norte por el río y luego al oeste hasta el pueblo de {area:287}, bastante al norte de {area:271} (sus guardias son de nivel 55).",

	-- Step 31: The smithy
	["The smithy"] = "La herrería",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes · {npc:2451} Farmer Kalaba
	-- was: ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "Al oeste por las laderas hasta el pueblo de {area:287}: la herrería está en el centro. {npc:2404} y sus aprendices trabajan en la forja; el {object:1736} está apilado a su lado. {npc:2449} pasea junto a la herrería; {npc:2451} trabaja el campo al sureste del pueblo."
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the west side of the town; {npc:2451} works the field south-east of the town."] = "",
	["Inside"] = "",
	-- {npc:2449} Citizen Wilkes
	["{npc:2449}, on the west side of the town"] = "",

	-- Step 32: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["for {npc:2055}, on the {zone:1458} stop at the end of this guide"] = "para el {npc:2055}, en la parada en {zone:1458} al final de esta guía",
	-- {npc:2429} Novice Thaivand · {item:3708} Helcular's Rod
	["{npc:2429}, in the town: {item:3708}, from the yetis on the way to the town hall"] = "{npc:2429}, en el pueblo: {item:3708}, de los yetis de camino al ayuntamiento",

	-- Step 33: Helcular's Rod
	-- {area:277} Foothill Caverns
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["West of Tarren Mill, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but they hit hard and come in pairs."] = "Al oeste del Molino Tarren, los Yetis de cuevas y los Yetis feroces (30-32) llenan {area:277}, en las colinas; más o menos uno de cada dieciséis lleva la vara. Quédate en estas cavernas: los Yetis monteses y Yetis gigantes (32-34) de la cueva más al norte también la llevan, pero pegan fuerte y van en parejas.",

	-- Step 34: Town hall
	["Town hall"] = "Ayuntamiento",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "",

	-- Step 35: Tarren Mill
	-- {area:271} Southshore
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["Thaivand's next errand, the flames, sends you among the Mountain and Giant Yetis (32-34) and to Helcular's grave inside {area:271}: leave it."] = "El siguiente encargo de Thaivand, las llamas, te manda entre los Yetis monteses y Yetis gigantes (32-34) y a la tumba de Helcular dentro de {area:271}: sáltalo.",

	-- Step 36: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "Para tu incursión en la Ciudad de Dalaran, más adelante en esta guía: {npc:2278} está en {area:272}, a poca distancia al este de {npc:2410}.",

	-- Step 37: City of Dalaran
	["City of Dalaran"] = "Ciudad de Dalaran",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "La Ciudad de Dalaran es una mazmorra para un grupo de cinco, de nivel 28 a 33 más o menos, bajo la cúpula violeta. Sin la {item:277507}, entra por la tubería de la alcantarilla al noroeste del cráter: la flecha te lleva allí.\nDentro: {npc:247126} es para {npc:2278}. {npc:268743}, en la alcantarilla, da Opportunistic Education y la recoge allí mismo.",
	-- {quest:96986} The Grave Knight · {npc:247126} Atrexis the Grave Knight
	["{quest:96986}: {npc:247126}, inside"] = "{quest:96986}: {npc:247126}, dentro",

	-- Step 39: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south-west past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Ve al suroeste, pasado el pueblo de {area:287}, hasta {area:288}. Hay mineros trabajando en los túneles; {npc:2305} (30) y {npc:2450} (29) están al fondo.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "",

	-- Step 40: Level 30
	["Level 30"] = "",
	-- {npc:2410} Magus Wordeen Voidglare · {area:272} Tarren Mill · {zone:1454} Orgrimmar · {area:288} Azurelode Mine · {zone:1437} Wetlands
	-- plural, as words: Torn Fin Muckdwellers = {npc:2374} Torn Fin Muckdweller
	["{npc:2410}'s quests on the next {area:272} stop and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Short of 30? The Torn Fin Muckdwellers and Coastrunners (28-30) crowd the coast south of the {area:288}, a short walk: kill them until level 30. Their Oracles (30-31) cast from the shore further east. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "Las misiones de {npc:2410} en la próxima parada en {area:272} y Alliance Relations en {zone:1454}, la primera parada de la siguiente guía, se ofrecen desde el nivel 30. ¿No llegas a 30? Los Habitabostas Rompeanca y los Correcostas (28-30) abarrotan la costa al sur de {area:288}, a poca distancia: mátalos hasta el nivel 30. Sus Oráculos (30-31) lanzan hechizos desde la orilla más al este. O, con grupo, haz en su lugar la mazmorra Excavation Site (en {zone:1437}).",
	["Torn Fin murlocs"] = "Múrlocs Rompeanca",
	-- {npc:2375} Torn Fin Coastrunner
	["grind on {npc:2375}"] = "farmea a los {npc:2375}",

	-- Step 41: Finish the Turtle Meat
	-- {item:3712} Turtle Meat
	["Finish the {item:3712}"] = "Termina de conseguir la {item:3712}",
	-- {item:3712} Turtle Meat · {area:272} Tarren Mill
	["Still short of ten {item:3712}? The Snapjaws line the river east of {area:272}, on your way back from the mine."] = "¿Aún no tienes diez de {item:3712}? Los Snapjaws bordean el río al este de {area:272}, de vuelta de la mina.",

	-- Step 42: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["North-east back to {area:272}, passing well north of {area:271} (its guards are 55)."] = "Vuelve al noreste a {area:272}, pasando bien al norte de {area:271} (sus guardias son de nivel 55).",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215}: su siguiente {quest:539} y la espada de {npc:2419} son misiones de grupo élite en {area:290}: acéptalas solo si tienes grupo",
	-- {npc:2229} Krusk
	["{npc:2229}, inside: Infiltration, worked on the 38-39 visit (its Syndicate are 32-35)"] = "{npc:2229}, dentro: Infiltration, para la visita de 38-39 (su Sindicato es de nivel 32-35)",
	-- {area:272} Tarren Mill
	["Keep Infiltration in your log: its Syndicate (32-35) are over you now, and the 38-39 guide (Alterac and Arathi) works it on its first {area:272} loop."] = "Guarda Infiltration en tu registro: su Sindicato (32-35) está por encima de ti ahora, y la guía de 38-39 (Alterac y Arathi) la hace en su primera vuelta por {area:272}.",

	-- Step 43: Voidglare, Bel'varil and Tallow
	-- {npc:2770} Tallow
	["Voidglare, Bel'varil and {npc:2770}"] = "Vacuamirada, Bel'varil y {npc:2770}",
	-- {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow · {area:272} Tarren Mill
	["{npc:2410} and {npc:2437} are inside the inn, {npc:2770} just outside it. Their quests are offered from level 30; below it, the 38-39 guide's first {area:272} stop takes them."] = "{npc:2410} y {npc:2437} están dentro de la posada, y {npc:2770} justo fuera. Sus misiones se ofrecen desde el nivel 30; por debajo, la primera parada en {area:272} de la guía de 38-39 las recoge.",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:544} Prison Break In · {area:279} Dalaran
	["{npc:2410}, inside: {quest:544}, for the 38-39 visit (the {area:279} crater's traitors are 33-35)"] = "{npc:2410}, dentro: {quest:544}, para la visita de 38-39 (los traidores del cráter de {area:279} son de nivel 33-35)",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {quest:544} Prison Break In
	["{npc:2410}: {quest:93680}, with {quest:544} on the 38-39 visit"] = "{npc:2410}: {quest:93680}, junto con {quest:544} en la visita de 38-39",
	-- {npc:2437} Keeper Bel'varil · {quest:556} Stone Tokens
	["{npc:2437}, inside: {quest:556}, with the crater on the 38-39 visit"] = "{npc:2437}, dentro: {quest:556}, junto con el cráter en la visita de 38-39",
	-- {npc:2770} Tallow
	["{npc:2770}, outside the inn: the Boulderfist ogres (32-34) on the 38-39 Arathi visit"] = "{npc:2770}, fuera de la posada: los ogros Puño de Roca (32-34) en la visita a Arathi de 38-39",
	-- {area:272} Tarren Mill · {area:321} Hammerfall
	["Keep these in your log: their camps are two to four levels over you now, and the 38-39 guide works them on its first {area:272} loop and in {area:321}."] = "Guarda estas en tu registro: sus campamentos están de dos a cuatro niveles por encima de ti ahora, y la guía de 38-39 las hace en su primera vuelta por {area:272} y en {area:321}.",

	-- Step 44: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "{quest:96986} de tu incursión en la Ciudad de Dalaran: {npc:2278}, a poca distancia al este de {npc:2410}.",

	-- Step 45: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "",

	-- Step 46: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "",

	-- Step 47: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "",

	-- Step 48: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "",

	-- Step 50: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 51: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell · {object:36126} Royal Quarter
	["{npc:2055} stands in the Apothecarium, in the {object:36126}."] = "{npc:2055} está en el Apothecarium, en {object:36126}.",
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["Faranell's next {quest:513} needs a {item:3388} ({skill:171}) and the {area:287} coast: leave it."] = "La siguiente misión de Faranell, {quest:513}, requiere un {item:3388} ({skill:171}) y la costa de {area:287}: déjala.",

	-- Step 52: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "",

	-- Step 53: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038} está en el Apothecarium. Su {quest:97985} es para Stormheart, un élite de nivel 30 que recorre el cañón al este de {area:484}, en el camino de la siguiente guía hacia {area:439}.",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038}: vuelve con él en la próxima parada en {zone:1458}, hacia el nivel 38",

	-- Step 54: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instructores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Entrena mientras estés en {zone:1458}: los instructores están en {object:36070}, {object:36073} y {object:36082} (paladines: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:272}"] = "De vuelta a {area:272}",
	-- ["Below ground"] = "Bajo tierra",
	-- ["Boulderfist camp"] = "Campamento Puño de Roca",
	-- ["Daggerspine naga"] = "Nagas Espinadaga",
	-- ["Daggerspine shore"] = "Orilla Espinadaga",
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Sigue el camino al norte desde {area:272} hacia las laderas de las Montañas de Alterac. {quest:535} espera junto al campamento del Sindicato; dale la cerveza.",
	-- ["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "Para personajes de nivel 29 a 33, pero la mayoría de las misiones de aquí son de nivel 32-34, y algunas de hasta 36: a propósito, por su experiencia. El Sindicato, los guardias de {area:279} y los ogros Puño de Roca son de nivel 31-35, así que atráelos de uno en uno.",
	-- ["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "Desde {area:271}, ve al norte pasando {area:272} y sigue el camino hasta las estribaciones de Alterac. {quest:535} espera junto al campamento del Sindicato. Solo ofrece su encargo mientras lleves «Infiltración» de {npc:2229}: dale la cerveza enseguida, y su recompensa es la Misiva de la Hermandad que quiere Krusk. Una misiva del Sindicato de aquí sirve igual: con una en tus bolsas, la guía se salta a {quest:535}.",
	-- ["Head back south down the road to {area:272}."] = "Vuelve al sur por el camino hasta {area:272}.",
	-- ["North of Southshore's graveyard"] = "Al norte del cementerio de Costasur",
	-- ["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "Solo si no conseguiste la misiva de {quest:535}: los Asaltantes de caminos y Ladrones del Sindicato (32-34) de los campamentos al oeste del camino también llevan misivas; más o menos uno de cada tres suelta una. Cuidado: a nivel 31-32 siguen por encima de ti y están muy juntos, con Zahoríes (34-35) entre ellos: atráelos de uno en uno desde el borde del campamento.",
	-- ["Shindigger keg"] = "Barril Machacacanillas",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "Al suroeste, los Yetis de cuevas y los Yetis feroces (30-32) llenan {area:277}, en las colinas al oeste de {area:272}; más o menos uno de cada dieciséis lleva la vara. Quédate en estas cavernas: los Yetis monteses y Yetis gigantes (32-34) de la cueva más al norte también la llevan, pero a nivel 29-30 pegan fuerte y van en parejas.",
	-- ["Syndicate missives"] = "Misivas del Sindicato",
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Los Asaltantes de caminos y Ladrones del Sindicato (32-33) de los campamentos al oeste del camino llevan las misivas; más o menos uno de cada tres suelta una.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "El barril está con otros en el campamento del Sindicato de la costa sureste de {area:287}.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "La fortaleza orca al final del camino por el este. {npc:2851}, la maestra de jinetes del viento, está junto a la puerta.",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "La tercera llama arde en la cueva más pequeña, arriba en las colinas al norte de las cavernas.\nCuidado: Yetis gigantes y Yetis monteses (32-34) rodean la llama, a menudo en parejas, y Faucehielo, un yeti raro (37), deambula cerca. A nivel 30-31 están por encima de tu nivel: atrae a los yetis de uno en uno desde la boca de la cueva antes de usar la Vara, y localiza a Faucehielo antes de entrar.",
	-- ["The {area:279} crater's eastern rim"] = "El borde oriental del cráter de {area:279}",
	-- ["Torn Fin beach"] = "Playa Rompeanca",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "Al oeste por las laderas hasta el pueblo de {area:287}: la herrería está en el centro. {npc:2404} y sus aprendices trabajan en la forja; el {object:1736} está apilado a su lado.",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "Al oeste por las laderas hasta el pueblo de {area:287}: la herrería está en el centro. {npc:2404} y sus aprendices trabajan en la forja; el {object:1736} está apilado a su lado. {npc:2449} pasea junto a la herrería; {npc:2451} trabaja el campo al sureste del pueblo.",
	-- ["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "Con un {item:3388} en tus bolsas, {npc:2055} ofrece {quest:513} en el Apothecarium; {npc:2216} recoge el elixir en {area:272}.",
	-- ["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388}: casa de subastas o un alquimista, para {quest:513}.",
	-- ["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",
	-- ["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229} quiere que liberes a sus dos exploradores de {area:275} antes de confiarte «Infiltración».",
	-- ["{npc:2792}, by the gate"] = "{npc:2792}, junto a la puerta",
}
