-- Spanish (Latin America) (esMX): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "Tu entrenamiento de nivel 40 está en {area:1497}: vuela ahí desde {area:340}, entrena y toma el zepelín desde las torres de afuera de la ciudad hasta {object:3202}.",

	-- Step 2: Genavie Callow
	-- {npc:4486} Genavie Callow · {zone:1417} Arathi Highlands
	["{npc:4486} stands beside the flight master you land at: the Dabyrie heads from the {zone:1417}."] = "{npc:4486} está junto al maestro de vuelo donde aterrizas: las cabezas Dabyrie de {zone:1417}.",
	-- {npc:4486} Genavie Callow
	["{npc:4486}, beside the flight master"] = "{npc:4486}, junto al maestro de vuelo",

	-- Step 3: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instructores de {zone:1458}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Montar requiere nivel 40 y cuesta 100 de oro; al aprenderlo recibes una montura. Cada raza lo aprende con el instructor de su propia raza: el tuyo es {npc:4773} en {area:159}, a poca distancia al norte de las torres del zepelín, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno) a su lado. Vuelve a las torres para el zepelín a {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instructora de equitación",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Caballos esqueléticos: {npc:4731}, junto a {npc:4773} en {area:159}.",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",

	-- Step 6: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Maestro de vuelo de {area:340}",

	-- Step 7: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "{npc:2519}: la leyenda está en Zul'Kunda, adonde va esta guía para {npc:1061}",
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay · {quest:1261} Marg Speaks · {npc:4791} Nazeer Bloodpike · {area:496} Brackenwall Village
	["the {object:2076} beside {npc:2519}: {quest:1261}, for {npc:4791} in {area:496} on the Dustwallow guide, where the crabs drop the pendant"] = "el {object:2076} junto a {npc:2519}: {quest:1261}, para {npc:4791} en {area:496} en la guía de Marjal Revolcafango, donde los cangrejos sueltan el colgante",
	-- {npc:2519} Kin'weelay · {quest:598} Split Bone Necklace
	["{npc:2519}: {quest:598}, the trophy skulls stand in the Skullsplitter ruins, on this guide's second loop"] = "{npc:2519}: {quest:598}, los cráneos trofeo están en las ruinas Machacacráneos, en el segundo recorrido de esta guía",
	-- {npc:2497} Nimboya · {quest:2932} Grim Message · {zone:1425} Hinterlands
	["{npc:2497}: {quest:2932}, for the {zone:1425}, around level 48"] = "{npc:2497}: {quest:2932}, para {zone:1425}, alrededor del nivel 48",

	-- Step 8: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:730} Tethis · {quest:195} Raptor Mastery
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights.\nCareful: {npc:730}, a level 43 elite raptor, roams among the stalkers: leave him for {quest:195}'s group step."] = "Los Acechadores de la selva (40-41) cazan en la costa al sur de {object:3202}. Están muy por encima de ti: atráelos de uno en uno y descansa entre combates.\nCuidado: {npc:730}, un raptor élite de nivel 43, ronda entre los acechadores: déjalo para el paso en grupo de {quest:195}.",

	-- Step 10: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maestro de vuelo de {object:3202}",

	-- Step 11: Drizzlik
	-- {npc:2495} Drizzlik
	["{npc:2495}'s shop is in the building east of the inn."] = "La tienda de {npc:2495} está en el edificio al este de la posada.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495}: las pieles Bocaquebrada que juntaste antes; adentro",

	-- Step 12: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Gringer, el maestro de vuelo, espera en la cubierta superior de {area:35}. Los que dan misiones están en los muelles alrededor del puerto y en la posada.",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}: el {npc:2635} toma el sol en la costa entre Zul'Kunda y {object:3202}, más adelante en este recorrido",

	-- Step 13: Kebok
	-- {npc:737} Kebok
	["{npc:737} stands upstairs, beside the flight master."] = "{npc:737} está en el piso de arriba, junto al maestro de vuelo.",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals from the earlier Stranglethorn guide"] = "{npc:737}: los cristales rodados ({item:4106}) de la guía anterior de Tuercespina",

	-- Step 14: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs, has his next errand now: the Skullsplitter tusks come from the trolls of Zul'Mamwe, later on this loop."] = "{npc:737}, en el piso de arriba, ya tiene su siguiente encargo: los colmillos Machacacráneos vienen de los trols de Zul'Mamwe, más adelante en este recorrido.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, en el piso de arriba",

	-- Step 15: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, en los muelles: la carta de Gazlowe, si la llevas",
	-- {npc:4631} Wharfmaster Lozgil · {quest:97332} Twice Misplaced Trust · {npc:259961} Wharfmaster Whizzbuzz · {area:16727} Powderfuse Port · {zone:2548} Riverglades
	["{npc:4631}: {quest:97332}, after Zimmix's rescue; the package goes to {npc:259961} at {area:16727}, in the {zone:2548} guide"] = "{npc:4631}: {quest:97332}, tras el rescate de Zimmix; el paquete va para {npc:259961} en {area:16727}, en la guía de {zone:2548}",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, en el balcón junto a MacKinley",
	-- {npc:2496} Baron Revilgaz · {area:37} Lake Nazferiti
	["{npc:2496}: Cozzle's footlocker is in his house by {area:37}, on your way north to Nesingwary"] = "{npc:2496}: el baúl de Cozzle está en su casa junto a {area:37}, de camino al norte hacia Nesingwary",
	["Inside"] = "Adentro",

	-- Step 16: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Sal del pueblo por el túnel; la nota está en la cala de los piratas justo al norte de {area:35}.",

	-- Step 18: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas Velo de Bruma",
	-- {quest:348} Stranglethorn Fever
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: if you will take {quest:348} with a group, keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "Los gorilas recorren el valle alrededor de Unbagwa. Los ancianos sueltan las asaduras; cualquiera puede soltar un colmillo: si vas a aceptar {quest:348} con un grupo, guarda diez para Unbagwa, cuyo Mokk (44) espera tu parada en Tuercespina hacia el nivel 45.\nCuidado: los gorilas ancianos del Velo de Bruma (40-41) están muy juntos en el valle: atráelos de uno en uno.",
	-- {quest:348} Stranglethorn Fever
	["Keep fangs from these same elders for Unbagwa ({quest:348}, with a group)."] = "Guarda colmillos de estos mismos ancianos para Unbagwa ({quest:348}, en grupo).",

	-- Step 19: Mistvale giblets
	["Mistvale giblets"] = "Menudillos de Velo de Bruma",

	-- Step 20: Mistvale gorillas at 39
	["Mistvale gorillas at 39"] = "Gorilas Velo de Bruma a nivel 39",
	["Look for lone level 40 elders in this same camp for the sinew and giblets. Leave level 41 gorillas alone; don't stay just for extra fangs."] = "Busca gorilas ancianos de nivel 40 solos en este mismo campamento por el tendón y los menudillos. Deja en paz a los gorilas de nivel 41; no te quedes solo por colmillos extra.",

	-- Step 21: Venture Co. mine
	["Venture Co. mine"] = "Mina de Ventura y Cía.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Más al norte, los goblins de Ventura y Cía. excavan en la mina al este del camino; mineros, capataces, topógrafos y manitas sueltan los cristales.\nCuidado: Panteras Fauceumbría y tigresas de Tuercespina en sigilo rondan la zona alrededor del campamento.",

	-- Step 22: Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Shadowmaw Panthers"] = "Panteras Faucesombría",
	-- {quest:192} Panther Mastery
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["{quest:192} is still open: the Shadowmaw Panthers (37-38) stalk the jungle north of the mine, towards the Mosh'Ogg hills. They use Sneak, so they show only when you are close: pull them one at a time, and leave the Elder Shadowmaw Panthers (42-43) alone."] = "{quest:192} sigue abierto: las Panteras Faucesombría (37-38) acechan en la selva al norte de la mina, hacia las colinas Mosh'Ogg. Usan Sigilo, así que solo se muestran cuando te acercas: atráelas de una en una y deja en paz a las Panteras Faucesombría viejas (42-43).",

	-- Step 24: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "Raptores colazote",
	-- {quest:195} Raptor Mastery · {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:195} is still open: the Lashtail Raptors (35-36) hunt the jungle between {object:3202} and Nesingwary's camp, on your way north."] = "{quest:195} sigue abierto: los raptores colazote (35-36) cazan en la selva entre {object:3202} y el campamento de Nesingwary, de camino al norte.",

	-- Step 25: Foreman Cozzle's house
	-- {npc:4723} Foreman Cozzle
	["{npc:4723}'s house"] = "La casa de {npc:4723}",
	-- {npc:4723} Foreman Cozzle · {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Agents = {npc:260429} Venture Co. Agent
	["On the way north, a short way east of the road: {npc:4723}'s house stands on the north shore of {area:37}. {npc:4723} (38) carries the key to his footlocker, inside the house; the Venture Co. Agents (39) stand in and around it: pull them one at a time. Then on north-west to Nesingwary's camp."] = "De camino al norte, a poca distancia al este del camino: la casa de {npc:4723} está en la orilla norte de {area:37}. {npc:4723} (38) lleva la llave de su baúl, dentro de la casa; los agentes de Ventura y Cía. (39) están dentro y alrededor de ella: atráelos de uno en uno. Luego sigue al noroeste hasta el campamento de Nesingwary.",
	-- {object:20691} Cozzle's Footlocker
	["{object:20691}, inside the house"] = "{object:20691}, dentro de la casa",

	-- Step 26: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Nesingwary",
	["Head north up the road; the hunters camp on the hill above the river."] = "Sube al norte por el camino; los cazadores acampan en la colina sobre el río.",

	-- Step 27: Sin'Dall
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["{npc:729}, the tiger {npc:717} sent you after on your last visit, prowls the hilltop just south-west of the camp."] = "{npc:729}, el tigre que {npc:717} te mandó cazar en tu última visita, merodea por la cima de la colina justo al suroeste del campamento.",

	-- Step 30: Nesingwary's camp
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "No hiciste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.",

	-- Step 31: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716} colecciona las páginas de {quest:338}: los trols del valle las sueltan de vez en cuando. Toma su misión; recibe cada capítulo una vez que tengas todas sus páginas.",

	-- Step 32: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}: tienes en tus bolsas todas las páginas del capítulo I",

	-- Step 33: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}: tienes en tus bolsas todas las páginas del capítulo II",

	-- Step 34: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}: tienes en tus bolsas todas las páginas del capítulo III",

	-- Step 35: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}: tienes en tus bolsas todas las páginas del capítulo IV",

	-- Step 36: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}: los cuatro capítulos",

	-- Step 37: Zul'Kunda
	["Zul'Kunda"] = "Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "Al oeste de la expedición, los jefes Sangrapellejo {npc:1061} y {npc:1062} están juntos en las ruinas de Zul'Kunda. Limpia antes sus guardias y luego atráelos.\nEn la costa entre Zul'Kunda y {object:3202}, un {npc:2635} (élite de nivel 38) comparte los puntos de aparición de los crocoliscos normales: mátalo si está presente y toma su piel para {npc:2495}.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "de {object:52}, en las ruinas",

	-- Step 38: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",
	-- {npc:2519} Kin'weelay
	["{npc:2519}, if you didn't take it on the first stop: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}, si no la tomaste en la primera parada: los cráneos trofeo están en las ruinas Machacacráneos, más adelante en este recorrido",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}: la entrada de la caverna bajo {area:104}, al oeste del campamento",

	-- Step 39: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina son una larga caminata sin ella. Toma el zepelín desde la torre de {object:3202} a {zone:1454}: {npc:4752} enseña a los orcos en el {object:172958}, junto a la perrera de {npc:3362} (lobos a 20 de oro cada uno). Luego el zepelín de vuelta a {object:3202}. ¿Te falta oro? Omite este paso: la guía de {zone:1444} vuelve a pasar por {zone:1454} hacia el nivel 45.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instructor de equitación",

	-- Step 40: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:367} Sen'jin Village · {npc:7953} Xar'Ti · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina son una larga caminata sin ella. Toma el zepelín desde la torre de {object:3202} a {zone:1454} y ve al sur por el camino de {zone:1411} hasta {area:367}: {npc:7953} enseña a los trols ahí, con los raptores de Zjolnir (20 de oro cada uno). Luego vuelve al zepelín hacia {object:3202}. ¿Te falta oro? Omite este paso: la guía de {zone:1444} vuelve a pasar por {zone:1454} hacia el nivel 45.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instructor de equitación",

	-- Step 41: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina son una larga caminata sin ella. Toma el zepelín desde la torre de {object:3202} a {zone:1454}, vuela a {zone:1456} y baja hasta {area:222}: {npc:3690} enseña a los tauren ahí, con los kodos de {npc:3685} (20 de oro cada uno). Luego vuela de vuelta a {zone:1454} para el zepelín de {object:3202}. ¿Te falta oro? Omite este paso: la guía de {zone:1444} vuelve a pasar por {zone:1456} hacia el nivel 45.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instructor de equitación",

	-- Step 42: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes un Zancavientos, y {zone:2548} después de Tuercespina son una larga caminata sin él. Toma el zepelín desde la torre de {object:3202} a {zone:1454} y vuela a {zone:1456}: la nave aérea a {zone:2521} sale de los acantilados al sur de {area:17045}, al norte de {zone:1456}, más o menos cada cinco minutos, y {npc:265756} enseña a los Celestes en {area:17684} de {area:16638}. Luego vuelve a {zone:1454} para el zepelín de {object:3202}. ¿Te falta oro? Omite este paso: la guía de {zone:1444} vuelve a pasar por {zone:1454} hacia el nivel 45.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756}, riding trainer, at the {area:17684} in {area:16638}"] = "{npc:265756}, Instructor de equitación, en {area:17684} de {area:16638}",

	-- Step 43: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity · {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1444} Feralas · {zone:1446} Tanaris
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {zone:1458}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} & {zone:1446} guide passes the {zone:1458} again at about 45."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina son una larga caminata sin ella. Toma el zepelín desde la torre de Grom'gol hasta las torres de {zone:1458}: {npc:4773} enseña a los Renegados en {area:159}, un poco al norte, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno). Luego el zepelín de vuelta a Grom'gol. ¿Te falta oro? Omite este paso: la guía de {zone:1444} y {zone:1446} vuelve a pasar por {zone:1458} hacia el nivel 45.",

	-- Step 44: Your mount at 40
	["Your mount at 40"] = "Tu montura a nivel 40",
	-- {zone:1454} Orgrimmar · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Warlocks don't buy riding: your mount is the Felsteed, from your class quest. Zevrost in {zone:1454}'s {object:172960} starts it and {npc:6251} in {area:392} teaches it, both on the {zone:1444} guide's {zone:1454} stop at about 45."] = "Los brujos no compran la equitación: tu montura es el Corcel vil, de tu misión de clase. Zevrost en el {object:172960} de {zone:1454} la inicia y {npc:6251} en {area:392} la enseña, ambos en la parada en {zone:1454} de la guía de {zone:1444}, alrededor del nivel 45.",
	-- {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Felsteed: Zevrost in {zone:1454}, then {npc:6251} in {area:392}, on the {zone:1444} guide's {zone:1454} stop."] = "Corcel vil: Zevrost en {zone:1454}, luego {npc:6251} en {area:392}, en la parada en {zone:1454} de la guía de {zone:1444}.",

	-- Step 45: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol (no name in this language: may be words) · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}: al oeste de {object:3202}, nada sobre {area:104} y bucea hasta la entrada de la caverna en el arrecife; la misión se completa al encontrarla. Deja la caverna por ahora: los acechadores de la selva están al sur, a lo largo de la costa.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "la entrada de {area:16550}, bajo el agua",

	-- Step 46: Jungle stalkers
	["Jungle stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast.\nCareful: the Jungle Stalkers (40-41) are thick here: pull one at a time and rest between fights."] = "Los raptores acechadores cazan en la jungla al sur de {object:3202}, hacia la costa oeste.\nCuidado: aquí abundan los Acechadores de la selva (40-41): atráelos de a uno y descansa entre combates.",
	["The naga explorers on the coast south of here (43-44) are for Bloads and Mok'thardin: keep both quests for your Stranglethorn stop at about 45."] = "Los exploradores naga de la costa al sur de aquí (43-44) son para Bloads y Mok'thardin: guarda ambas misiones para tu parada en Tuercespina alrededor del nivel 45.",

	-- Step 47: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Ve al sur, hasta {area:35}. Phillipe el Tembloroso espera en los muelles.",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony"] = "{npc:2496}, en el balcón",
	-- {npc:2496} Baron Revilgaz · {area:2240} Mirage Raceway · {zone:1444} Feralas · {zone:1446} Tanaris
	["{npc:2496}: for Pozzik at the {area:2240}, on the {zone:1444} & {zone:1446} guide's way"] = "{npc:2496}: para Pozzik en {area:2240}, de camino en la guía de {zone:1444} y {zone:1446}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "{npc:737}, en el piso de arriba: los colmillos los sueltan los Partecráneos, más adelante en este recorrido",
	["MacKinley: keep it, the ghost pirates (43-44) wait for your Stranglethorn stop at about 45"] = "MacKinley: guárdala, los piratas fantasma (43-44) esperan tu parada en Tuercespina alrededor del nivel 45",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, adentro: {item:4105}",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["{npc:2493}: keep it for the {area:43} at about 45"] = "{npc:2493}: guárdala para {area:43} alrededor del nivel 45",
	-- {npc:2487} Fleet Master Seahorn · {area:43} Wild Shore
	["{npc:2487}: keep it for the {area:43} at about 45"] = "{npc:2487}: guárdala para {area:43} alrededor del nivel 45",
	-- {npc:2488} Deeg · {area:43} Wild Shore
	["{npc:2488}, on the top floor: keep it for the {area:43} at about 45"] = "{npc:2488}, en el piso superior: guárdala para {area:43} alrededor del nivel 45",

	-- Step 48: Whiskey Slim and Fin Fizracket
	-- {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["{npc:2491} and {npc:2486}"] = "{npc:2491} y {npc:2486}",
	-- {npc:2491} Whiskey Slim · {zone:1444} Feralas · {zone:1446} Tanaris · {area:35} Booty Bay
	["{npc:2491}, in the inn, and \"Sea Wolf\" MacKinley, on the top floor, offer these quests from level 40: pick them up now. Under 40, the {zone:1444} & {zone:1446} guide's {area:35} stop offers them again."] = "{npc:2491}, en la posada, y MacKinley «Lobo de Mar», en el piso de arriba, ofrecen estas misiones desde el nivel 40: acéptalas ahora. Por debajo de 40, la parada de {area:35} de la guía de {zone:1444} y {zone:1446} las vuelve a ofrecer.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, en la posada: sus botellas llegan a la costa de {zone:1425}, alrededor del nivel 48",
	-- {quest:2872} Stoley's Debt · {zone:1446} Tanaris
	["MacKinley, on the top floor: {quest:2872}, for Stoley in {zone:1446}"] = "MacKinley, en el piso superior: {quest:2872}, para Stoley en {zone:1446}",

	-- Step 49: Fin Fizracket
	-- {quest:348} Stranglethorn Fever · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["Group quest: {quest:348} ends at {npc:1449} in Mistvale. Hand him ten gorilla fangs and he calls three waves of gorillas (41-42), one after another, then {npc:1514} (44). In players' recordings, 12 of the 27 people who started it died there. Take it if you have a friend or two along."] = "Misión de grupo: {quest:348} termina con {npc:1449} en el Valle del Velo de Bruma. Dale diez colmillos de gorila y llama a tres oleadas de gorilas (41-42), una tras otra, y luego a {npc:1514} (44). En las grabaciones de los jugadores, 12 de las 27 personas que la empezaron murieron allí. Acéptala si vas con un amigo o dos.",
	-- {npc:2486} Fin Fizracket · {zone:1444} Feralas · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2486}, beside the inn: Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}, junto a la posada: la parte de Unbagwa, en la parada de {object:3202} de la guía de {zone:1444}",

	-- Step 50: The Bloodsail ships
	["The Bloodsail ships"] = "Los barcos Velasangre",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["The scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs, with captains of 45-48: take it with a group. Its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "El pergamino, {quest:624}, está en las cubiertas de los tres barcos frente a {area:43}, con tripulaciones de piratas de 42-45 que van en parejas y capitanes de 45-48: hazla en grupo. Su cadena sigue por {zone:1435}, {zone:1445} y {zone:1425}.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "para una parada posterior en {zone:1435}",

	-- Step 51: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly back to {object:3202}: Zul'Mamwe's Skullsplitters are just east of it."] = "Vuela de vuelta a {object:3202}: los Partecráneos de Zul'Mamwe están justo al este.",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maestro de vuelo de {area:35}",

	-- Step 52: Zul'Mamwe
	["Zul'Mamwe"] = "Ruinas de Zul'Mamwe",
	["The warriors in the northern ruins (39-40) drop both tusks and necklaces. Pull from the edge; leave the chief and his two guards to the south alone."] = "Los guerreros de las ruinas del norte (39-40) sueltan tanto colmillos como collares. Atráelos desde el borde; deja en paz al jefe y a sus dos guardias del sur.",

	-- Step 53: Zul'Mamwe and Balia'mah trophy skulls
	["Zul'Mamwe and Balia'mah trophy skulls"] = "Cráneos trofeo de Zul'Mamwe y Balia'mah",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Look for the trophy skulls in the small ruins north of Zul'Mamwe's warriors.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Busca los cráneos trofeo en las pequeñas ruinas al norte de los guerreros de Zul'Mamwe.\nLos últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a Grom'gol.",

	-- Step 54: Kin'weelay
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "Ve al oeste, hasta {object:3202}.",

	-- Step 57: Grom'gol Base Camp
	-- {npc:2464} Commander Aggro'gosh · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {zone:2548} Riverglades
	["{npc:2464}: for {npc:256418} in {area:16743}, the {zone:2548}' Horde fort, in the next guide"] = "{npc:2464}: para {npc:256418} en {area:16743}, el fuerte de la Horda de {zone:2548}, en la próxima guía",
	-- {quest:571} Mok'thardin's Enchantment · {quest:621} Zanzil's Secret · {npc:737} Kebok · {area:35} Booty Bay · {zone:2548} Riverglades
	["Keep {quest:571}, {quest:621} and {npc:737}'s tusks: the Skullsplitter chief, Zanzil's camps, the naga coast and {area:35} come on your Stranglethorn stop at about 45, after the {zone:2548}."] = "Guarda {quest:571}, {quest:621} y los colmillos de {npc:737}: el jefe Partecráneos, los campamentos de Zanzil, la costa naga y {area:35} llegan en tu parada en Tuercespina alrededor del nivel 45, después de {zone:2548}.",

	-- Step 59: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Sube al norte por el camino hasta el campamento de los cazadores.",

	-- Step 61: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:730} es élite de nivel 43: la mayoría de las clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Omítelo si estás solo.",

	-- Step 62: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:728} es élite de nivel 40: la mayoría de las clases lo hacen solas a nivel 42, pero puede que necesites ayuda. Omítelo si estás solo.",

	-- Step 66: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:731} es élite de nivel 43: la mayoría de las clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Omítelo si estás solo.\nCuidado: Tigres y panteras Fauceumbría en sigilo rondan cerca de él. Despéjalos antes de atraerlo. Cuando lo atraes, {npc:731} pide ayuda a las criaturas en 20 m.",

	-- Step 71: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "A {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Sigue el camino al este desde {zone:1431} por {zone:1430} hasta el pantano. {npc:1776} espera en {area:657}, el campamento draenei justo al lado del camino donde entra desde {zone:1430}.",

	-- Step 72: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "Ve al este hasta {area:75}, entre los juncos al sur del camino.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, adentro",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}, en el piso de arriba",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, en el piso superior",

	-- Step 73: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Denteserra",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Los crocoliscos se revuelcan en los charcos alrededor del campamento de {npc:5391} y al sur hacia {area:75}; más o menos uno de cada cuatro suelta un flanco.",

	-- Step 74: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru deambula por el claro al suroeste de {area:76}; su garrote inicia una misión.",

	-- Step 75: Draenethyst crystals
	["Draenethyst crystals"] = "Cristales draenetistas",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Head north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Ve al noreste hasta {area:76}. Los cristales están a lo largo del camino que sube a la jaula de {npc:5391}.",

	-- Step 76: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} está prisionero en {area:76}, en el noreste del pantano. Libéralo y síguelo hacia afuera, rechazando a las criaturas del pantano que lo persiguen.",

	-- Step 77: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "Su caja fuerte espera en su antiguo campamento al norte de {area:75}, de camino de vuelta al oeste.",

	-- Step 78: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Dirígete al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}.",

	-- Step 79: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east along the road, past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}. Only Sawfin Frenzies (38-40) swim there."] = "De vuelta al este por el camino, pasando {area:75}: los artefactos Atal'ai están en el agua y en las orillas de {quest:1424}. Ahí solo nadan dementes Sierraleta (38-40).",

	-- Step 80: Misty Reed Post
	-- {npc:5592} Tok'Kar · {npc:5593} Katar
	["Follow the road south-east to the small Horde post on the shore: {npc:5592} takes the crocolisk flanks, and {npc:5593} stands beside him."] = "Sigue el camino al sureste hasta el pequeño puesto de la Horda en la orilla: {npc:5592} recibe los flancos de crocolisco y {npc:5593} está a su lado.",

	-- Step 81: Sawtooth snappers
	["Sawtooth snappers"] = "Sacudidores Denteserra",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Sawtooth Snappers = {npc:1087} Sawtooth Snapper
	["The Sawtooth Snappers (41-42) line the strand south of the post; nearly every one drops a claw. Leave the murlocs further along the shore for your next swamp visit.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "Los sacudidores Denteserra (41-42) bordean la playa al sur del puesto; casi todos sueltan una pinza. Deja los múrlocs de más adelante en la orilla para tu próxima visita al pantano.\nCuidado: un {npc:272377} (nivel 60) recorre la playa del sureste: mantente bien lejos.",

	-- Step 82: Misty Reed Post
	-- {npc:5593} Katar
	["{npc:5593}: the murlocs (41-44) wait for your next swamp visit"] = "{npc:5593}: los múrlocs (41-44) esperan a tu próxima visita al pantano",

	-- Step 83: Stonard
	-- {area:75} Stonard · {npc:1443} Fel'zerul · {quest:1430} Fresh Meat · {npc:5593} Katar
	["Back north-west along the road to {area:75}: {npc:1443}, on the top floor, takes the artifacts. {quest:1430}'s crawlers and {npc:5593}'s murlocs wait for your next swamp visit."] = "De vuelta al noroeste por el camino hasta {area:75}: {npc:1443}, en el piso superior, recibe los artefactos. Los reptadores de {quest:1430} y los múrlocs de {npc:5593} esperan a tu próxima visita al pantano.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Below ground"] = "Bajo tierra",
	-- ["Boat to {area:35}"] = "Barco a {area:35}",
	-- ["Fly to {area:392}"] = "Vuela a {area:392}",
	-- ["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Sigue la costa al sur. Los expedicionarios naga vadean por la orilla y llevan los fardos de juncos; {object:759} burbujea en las colinas justo al este de ellos.",
	-- ["From {area:2408} fly to {area:392}."] = "Desde {area:2408} vuela a {area:392}.",
	-- ["From {object:3202} head east to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. One pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all. Careful: {npc:1059} (45) walks the south-western ruins with two guards; Speaking with {npc:1061}'s last piece, his Broken Armor, waits for your Stranglethorn stop at about 45."] = "Desde {object:3202} ve al este hasta las ruinas Partecráneos, al este de la mina de Ventura y Cía.; atrae a los cazacabezas y rabiosos de a uno. Un montón de cráneos trofeo está en el lado norte de las ruinas. Todos los Partecráneos pueden soltar un colmillo o un collar: los collares son la parte lenta, así que sigue matando en el campamento de los guerreros al norte de las ruinas hasta tenerlos todos. Cuidado: {npc:1059} (45) recorre las ruinas del suroeste con dos guardias; la última pieza de Hablar con {npc:1061}, su Armadura rota, espera tu parada en Tuercespina alrededor del nivel 45.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Más al norte, los goblins de Ventura y Cía. excavan en la mina al este del camino; los canteros, supervisores, peritos y manitas sueltan los cristales.",
	-- ["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Entrega los colmillos a Unbagwa y quédate a su lado: invoca tres oleadas de gorilas y luego a {npc:1514}. Pelea con ellos de uno en uno.",
	-- ["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Ve al norte hasta las ruinas Partecráneos al este de la mina de Ventura y Cía.; atrae a los cazacabezas y rabiosos de a uno. {npc:1059} custodia las ruinas del suroeste, y una pila de cráneos trofeo está en el lado norte de las ruinas. Cualquier Partecráneos puede soltar un colmillo o un collar: los collares son lo lento, así que sigue matando en el campamento de los guerreros al norte de las ruinas hasta tenerlos todos.",
	-- ["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Ve al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}. {quest:698} va para {npc:5592} en {area:1978} en la próxima visita al pantano: guarda los flancos.",
	-- ["Hearth to {area:35}"] = "Usa la piedra de hogar para ir a {area:35}",
	-- ["Hearth to {object:3202}"] = "Usa la piedra de hogar para ir a {object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "Su caja fuerte espera en su antiguo campamento al norte de {area:75}.",
	-- ["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "Si omitiste {quest:192} o {quest:195}, sube de nivel aquí hasta 42.68 para seguir el plan de la ruta.",
	-- ["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "Si omitiste {quest:208}, sube de nivel aquí hasta 42.74 para seguir el plan de la ruta.",
	-- ["Inside {area:1742}"] = "Dentro de {area:1742}",
	-- ["Into the {area:8}"] = "A {area:8}",
	-- ["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	-- ["Keep fangs from these same elders for Unbagwa."] = "Guarda los colmillos de estos mismos ancianos para Unbagwa.",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Sigue cabalgando al norte hacia {zone:1431} y luego al este por el camino a través de {zone:1430} hasta el pantano. {npc:1776} espera en {area:657}, el campamento draenei cerca de la entrada desde {zone:1430}.",
	-- ["Level 42.68"] = "Nivel 42.68",
	-- ["Level 42.74"] = "Nivel 42.74",
	-- ["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "MacKinley, en el piso superior: para Stoley en {zone:1446}",
	-- ["Naga shore and the {object:759}"] = "Orilla de los nagas y {object:759}",
	-- ["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Al noreste del Velo de Bruma, los seguidores de Zanzil acampan en la jungla; cualquiera de ellos puede llevar la mezcla.",
	-- ["Optional, and tough at 42: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Opcional, y difícil a nivel 42: el pergamino, {quest:624}, está en las cubiertas de los tres barcos frente a {area:43}, con tripulaciones de piratas de 42-45 que van en parejas. Tómala solo si puedes atraer a la tripulación a la borda de a uno, o con un amigo; su cadena sigue por {zone:1435}, {zone:1445} y {zone:1425}.",
	-- ["Pirate ghosts"] = "Piratas fantasma",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Cabalga de vuelta al este pasando {area:75} y sigue el camino al sureste hasta el pequeño puesto de la Horda en la orilla.",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "Cabalga al este hasta {area:75}, entre los juncos al sur del camino.",
	-- ["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "Sal de {area:35} hacia el norte por el camino; los basiliscos toman el sol en las rocas al este del camino, en medio de la selva, de camino de vuelta a {object:3202}. Sus fragmentos caen seguido.",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Cabalga al norte hasta las ruinas Machacacráneos al este de la mina de Ventura y Cía.; atrae a los rebanacabezas y rabiosos de uno en uno. {npc:1059} protege las ruinas del suroeste, y un montón de cráneos trofeo está en el lado norte de las ruinas. Cualquier Machacacráneos puede soltar un colmillo o un collar: los collares son la parte lenta, así que sigue matando en el campamento de guerreros al norte de las ruinas hasta tenerlos todos.",
	-- ["Ride north up the road to the hunters' camp."] = "Cabalga al norte por el camino hasta el campamento de los cazadores.",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Cabalga al norte por el camino; los cazadores acampan en la colina sobre el río.",
	-- ["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Cabalga al noreste hasta {area:76}. Los cristales están a lo largo del camino que sube a la jaula de {npc:5391}.",
	-- ["Ride north-west to {object:3202}."] = "Cabalga al noroeste hasta {object:3202}.",
	-- ["Ride on north to {object:3202}."] = "Sigue al norte hasta {object:3202}.",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Cabalga al sur hasta {area:35}. Phillipe el Trémulo espera en los muelles.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Cabalga al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Ve al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}. {quest:698} va para {npc:5592} en {area:1978} en la próxima visita al pantano: guarda los flancos.",
	-- ["Ride west to {object:3202}."] = "Cabalga al oeste hasta {object:3202}.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {area:1497}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1435} guide passes the {area:1497} again at about 47."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla obtienes una montura, y {zone:2548} después de Tuercespina son una larga caminata sin ella. Toma el zepelín desde la torre de {object:3202} a las torres de {area:1497}: {npc:4773} enseña a los Renegados en {area:159}, un poco al norte, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno). Luego el zepelín de vuelta a {object:3202}. ¿Te falta oro? Omite este paso: la guía de {zone:1435} vuelve a pasar por {area:1497} hacia el nivel 47.",
	-- ["Skullsplitter warriors"] = "Guerreros Machacacráneos",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Al sur de Bahía del Botín, los espadachines Velasangre acampan en {area:43}; las cartas y las órdenes están en sus tiendas y en el bote de remos junto al campamento más grande. Cualquier Velasangre puede llevar tabaco rapé y el ojo de {npc:2493}, así que sigue matando hasta tener ambos.",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Toma el camino al norte desde {area:35}; Unbagwa está en una colina en {area:1737}, al este del camino.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Los Acechadores de la selva (40-41) cazan en la costa al sur de {object:3202}. Están muy por encima de ti: atráelos de uno en uno y descansa entre combates.",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "El barco llega al puerto de {area:35}. Los asignadores de misiones están en los paseos de madera alrededor del puerto y en la posada.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "El barco a {area:35} atraca al final del muelle de {area:392}.",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Los gorilas deambulan por el valle alrededor de Unbagwa. Los ancianos sueltan las menudencias; cualquiera puede soltar un colmillo.",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "Los gorilas recorren el valle alrededor de Unbagwa. Los ancianos sueltan las menudencias; cualquiera puede soltar un colmillo: guarda diez para Unbagwa, cuyo Mokk (44) espera a tu paso por Tuercespina hacia el nivel 45.\nCuidado: los gorilas Velo de Bruma ancianos (40-41) están muy juntos en el valle: atráelos de uno en uno.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Los últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "La siguiente guía empieza aquí y te lleva a {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Los siguientes cráneos trofeo están en las pequeñas ruinas justo al norte del campamento de guerreros.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Los siguientes cráneos trofeo están en las pequeñas ruinas justo al norte del campamento de los guerreros.\nLos últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a {object:3202}.",
	-- ["The snappers line the strand south of the post."] = "Los sacudidores bordean la playa al sur del puesto.",
	-- ["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Los raptores acechadores cazan en la jungla al sur de {object:3202}, hacia la costa oeste.",
	-- ["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Los tres piratas fantasmales rondan la jungla al norte de {area:35}, cerca de los campamentos de Zanzil: {npc:2535} y {npc:2536} están juntos, y {npc:2537}, más al este.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Los tres barcos están frente a {area:43}. Las tripulaciones son de nivel 42-45, Aguasmansas 45, Sinquilla 46 y {npc:2546} 48: a nivel 41 es una pelea para un grupo o para el final de la guía. Si vas, nada hasta allí y atrae a la tripulación a la borda de uno en uno. Un pergamino, {quest:624}, está en las cubiertas de los barcos: tómalo.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:728} es élite de nivel 40: la mayoría de las clases lo hacen solas a nivel 42, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:730} es élite de nivel 43: la mayoría de las clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Son enemigos élite: se recomienda agruparse, busca gente para hacerlo. {npc:731} es élite de nivel 43: la mayoría de las clases lo hacen solas a nivel 45, pero puede que necesites ayuda. Omítelo si estás solo: la ruta te hace recuperar esa experiencia matando enemigos.\nCuidado: Tigres y panteras Fauceumbría en sigilo rondan cerca de él. Despéjalos antes de atraerlo. Cuando lo atraes, {npc:731} pide ayuda a las criaturas en 20 m.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "Al oeste de la expedición, los jefes Sangrapellejo {npc:1061} y {npc:1062} están juntos en las ruinas de Zul'Kunda. Limpia antes sus guardias y luego atráelos.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "Al oeste de la expedición, los jefes Sangrapellejo {npc:1061} y {npc:1062} están juntos en las ruinas de Zul'Kunda. Limpia antes sus guardias y luego atráelos. Quédate con los Sangrapellejo aquí hasta el nivel 41: {quest:586}, en el caldero a continuación, te envía contra Machacacráneos de nivel 41-43.\nEn la costa entre Zul'Kunda y {object:3202}, un {npc:2635} (élite de nivel 38) comparte los puntos de aparición de los crocoliscos normales: mátalo si está presente y toma su piel para {npc:2495}.",
	-- ["Zanzil's camps"] = "Campamentos de Zanzil",
	-- ["for Stoley in {zone:1446}"] = "para Stoley en {zone:1446}",
	-- ["for a later stop in the {area:8}"] = "para una parada posterior en {area:8}",
	-- ["for later: the {zone:1425}, around level 48"] = "para más adelante: {zone:1425}, alrededor del nivel 48",
	-- ["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "sube de nivel con los Sangrapellejo de aquí: {quest:586}, en el caldero a continuación, te manda a por Partecráneos de 41-43",
	-- ["grind on {npc:667}"] = "sube de nivel con {npc:667}",
	-- ["the {object:2076}"] = "{object:2076}",
	-- ["the {object:2076} again: Yenniku's fate"] = "{object:2076} otra vez: el destino de Yenniku",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",
	-- ["{area:127}: kill these as you meet them"] = "{area:127}: mata a estos según te los encuentres",
	-- ["{area:1497} trainers"] = "Instructores de {area:1497}",
	-- ["{area:1577}: kill these as you meet them"] = "{area:1577}: mata a estos según te los encuentres",
	-- ["{area:392} pier"] = "Muelle de {area:392}",
	-- ["{npc:2486}: {quest:348} (offered from 40), Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}: {quest:348} (disponible desde el nivel 40); la parte de Unbagwa va en la parada de {object:3202} de la guía de {zone:1444}",
	-- ["{npc:2486}: {quest:348}, Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}: {quest:348}, la parte de Unbagwa va en la parada de Grom'gol de la guía de {zone:1444}",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}, en el piso superior",
	-- ["{npc:2491}, in the inn, {npc:2486}, beside it, and \"Sea Wolf\" MacKinley, on the top floor, offer these quests from level 40: pick them up now. Under 40, the {zone:1444} & {zone:1446} guide's {area:35} stop offers them again."] = "{npc:2491}, en la posada, {npc:2486}, al lado, y MacKinley \"Lobo de Mar\", en el piso superior, ofrecen estas misiones desde el nivel 40: tómalas ahora. Si tienes menos de 40, la parada en {area:35} de la guía de {zone:1444} y {zone:1446} las vuelve a ofrecer.",
	-- ["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "{npc:2496}, en el balcón junto a MacKinley, tiene un encargo más: los planos del regulador de combustible del baúl de Cozzle van para Pozzik en {area:2240}, de camino a {zone:1446} cerca del nivel 43.",
	-- ["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: para {zone:1425}, alrededor del nivel 48",
	-- ["{npc:2498}, inside"] = "{npc:2498}, adentro",
	-- ["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "{npc:2519}: los basiliscos pastan junto al camino de vuelta desde {area:35}",
	-- ["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}: los cráneos trofeo están en las ruinas Partecráneos, más adelante en este recorrido",
	-- ["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} da vueltas por aquí: búscalo dentro del círculo del mapa",
	-- ["{npc:6807}, upstairs"] = "{npc:6807}, en el piso de arriba",
	-- ["{npc:6930}, upstairs"] = "{npc:6930}, en el piso de arriba",
	-- ["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, en el piso de arriba: para {quest:2864} en {area:976}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: para {quest:2864} en {area:976}",
	-- ["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "{zone:1434} y {zone:1435} a nivel 40-43: {object:3202}, los piratas de {area:35}, las cacerías de Nesingwary y {area:75}.",
}
