-- Spanish (Latin America) (esMX): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Orgrimmar
	-- {area:1637} Orgrimmar
	["To {area:1637}"] = "A {area:1637}",
	-- {area:380} Crossroads · {area:1637} Orgrimmar · {npc:3310} Doras · {object:172982} Valley of Strength
	["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Desde {area:380}, sigue el camino al noreste hasta {area:1637} y entra por la puerta principal. {npc:3310}, el maestro de jinetes del viento, está en la torre de {object:172982}.",

	-- Step 2: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Misiones de clase en {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} está en {object:172961}, en el lado oeste de la ciudad.",

	-- Step 3: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Vuela a {area:1638}: {npc:3033} te entrena en {area:1639}. Cielonatos: después vuelve volando a {zone:1454} para tomar el zepelín.",

	-- Step 4: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lanza {spell:18960}; {npc:11802} está en {area:2361}. Los Adornos de altar ({item:15877}) están en el fondo de {area:656} y desaparecen en minutos: nada con uno directo a {area:2362} en la orilla noroeste, úsalo allí y habla con {npc:11799}.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, siguiente guía",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, en {area:2362}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {zone:1454} Orgrimmar
	["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798}, en {area:2361}, lleva volando a los druidas; luego vuela a {zone:1454} para tomar el zepelín",

	-- Step 5: Zeppelin to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Zeppelin to {zone:1420}"] = "Zepelín a {zone:1420}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {object:3202} Grom'gol (no name in this language: may be words)
	["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "Las torres de zepelín están justo afuera de la puerta principal de {zone:1454}. Toma el zepelín a {zone:1420} (el otro va a {object:3202}).",
	["Zeppelin tower"] = "Torre del zepelín",

	-- Step 6: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} entrena a los paladines en {area:159}, a poca distancia al norte por el camino desde las torres de zepelín. Regresa por el mismo camino para ir a Bosque de Argénteos.",

	-- Step 7: Into Silverpine
	["Into Silverpine"] = "Hacia Bosque de Argénteos",
	-- {area:153} Ruins of Lordaeron · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "El zepelín aterriza en las torres afuera de {area:153}. Camina al oeste por el camino, pasando las ruinas, y al sur hacia {zone:1421}; sigue el camino hasta {area:228}.",
	["Road to Silverpine"] = "Camino a Bosque de Argénteos",

	-- Step 8: Sepulcher
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} es el pueblo cripta de los Renegados en medio del bosque. Todos los que necesitas están alrededor de la entrada de la cripta; {npc:2226}, el cuidador de murciélagos, está justo al este.",

	-- Step 9: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Sigue el camino al sur. {object:1627} está a un lado, al norte de Aldea Piroleña.",

	-- Step 10: Sepulcher
	-- {area:233} Ambermill
	["{area:233} comes later, on the southern loop"] = "{area:233} viene después, en el circuito sur",

	-- Step 11: The Dead Field
	-- {area:228} Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "Al norte de {area:228}. {npc:1983} ronda {area:240}: mátalo y luego cruza el campo.",

	-- Step 12: Strange Lockbox
	-- {object:177790} Strange Lockbox · {area:240} The Dead Field · {item:15882} Half Pendant of Aquatic Endurance · {quest:30} Trial of the Sea Lion
	["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790} está en la costa al oeste de {area:240}. Contiene {item:15882} para {quest:30}.",

	-- Step 13: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Sigue el camino al noreste hasta la casa de los Yorick en {area:238}.",

	-- Step 14: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} espera al noreste de la casa. Escóltalo de vuelta con {npc:1950}; los huargos atacan en el camino.",

	-- Step 16: Worgs and murlocs
	["Worgs and murlocs"] = "Huargos y múrlocs",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg · Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Los Huargos jaspeados ({npc:1766}) merodean las colinas alrededor de la casa. Luego camina al sur por la orilla del lago: los Machacadores Anca Vil ({npc:1767}) y Cazamareas de allí sueltan los ojos de múrloc.",

	-- Step 17: Hearth to the Sepulcher
	-- {area:228} Sepulcher
	["Hearth to the {area:228}"] = "Usa tu piedra de hogar para ir a {area:228}",

	-- Step 18: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:228} Sepulcher
	["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593} está en el embarcadero de la orilla del lago, al este de {area:228}.",

	-- Step 20: The Ivar Patch
	-- {quest:425} Ivar the Foul
	["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "De nuevo al norte, a la casa de los Yorick. {quest:425} acecha a poca distancia al oeste.",

	-- Step 21: Fenris Isle
	-- {area:172} Fenris Isle · {area:235} Fenris Keep
	["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Sigue la orilla del lago al sureste y nada hasta {area:172}. Los gnolls Putrepellejo cubren la isla; todos los tipos sueltan icor. No entres en {area:235}, en el lado norte, salvo que vayas por la opción extra: los gnolls de allí son de nivel 18-22.",
	-- {item:3317} A Talking Head
	["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: botín raro de los gnolls",
	-- {object:1599} Shallow Grave
	["{object:1599}, just east of the keep"] = "{object:1599}, justo al este de la fortaleza",
	-- {object:112888} Dusty Shelf
	["{object:112888}, inside the keep"] = "{object:112888}, dentro de la fortaleza",

	-- Step 22: Sepulcher
	-- {area:228} Sepulcher
	["Swim back and follow the road west to the {area:228}."] = "Nada de regreso y sigue el camino al oeste hasta {area:228}.",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, en el circuito sur",
	-- {npc:1938} Dalar Dawnweaver · {quest:98298} Arugal's Folly
	["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: acéptala si te la ofrece; puede seguir a su serie {quest:98298}, que la ruta no hace",

	-- Step 23: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "Al sureste por el camino hasta {area:233}. Los Protectores vigilan las afueras y los Magos el pueblo; ambos sueltan colgantes. Los Zahoríes y Vigías patrullan los caminos alrededor. No entres al centro, donde está {npc:2120}.",

	-- Step 24: Moonrage Bloodhowlers
	-- plural, as words: Moonrage Bloodhowlers = {npc:1924} Moonrage Bloodhowler
	["Moonrage Bloodhowlers"] = "Aullasangres Furia Lunar ({npc:1924})",
	-- {npc:1938} Dalar Dawnweaver · {quest:98298} Arugal's Folly · {area:233} Ambermill · {item:280375} Worgen Bits
	["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Solo si {npc:1938} te dio {quest:98298}: los Aullasangre merodean el bosque al suroeste de {area:233}, al este de Aldea Piroleña; sueltan {item:280375}.",

	-- Step 25: The refugees
	["The refugees"] = "Los refugiados",
	-- {area:230} Greymane Wall
	-- plural, as words: Haggard Refugees = {npc:2053} Haggard Refugee
	["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Los Refugiados enfermos y demacrados ({npc:2053}) deambulan por el camino al sur de Aldea Piroleña hacia {area:230}.",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril
	-- plural, as words: Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Al noreste de los refugiados, los Braceros Corvozarpa ({npc:1974}) y Guardianes rondan las ruinas de {quest:516} en el sureste del bosque.",

	-- Step 28: Lordamere Lake shore
	-- {area:1338} Lordamere Lake
	["{area:1338} shore"] = "Orilla de {area:1338}",
	-- {area:237} Decrepit Ferry · {area:228} Sepulcher
	-- plural, as words: Vile Fin Lakestalkers = {npc:1909} Vile Fin Lakestalker
	["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Los Acechalagos Anca Vil ({npc:1909}) y Oráculos están en la orilla del lago al sur de {area:237}, al este de {area:228}.",
	-- {npc:1909} Vile Fin Lakestalker · {area:1338} Lordamere Lake · {zone:1421} Silverpine Forest
	["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "farmea {npc:1909} en {area:1338}, {zone:1421}",

	-- Step 29: Apothecary Renferrel
	-- {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["Keep it: {npc:2216} in {area:272}, a later guide"] = "Guárdala: {npc:2216} en {area:272}, en una guía posterior",

	-- Step 30: Brill
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Sigue el camino al norte, fuera de Bosque de Argénteos, hacia {zone:1420} y hasta {area:159}: {npc:246152} entrena a los paladines allí. Las torres de zepelín están a poca distancia al sur por el camino.",

	-- Step 31: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- {zone:1420} Tirisfal Glades · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar
	["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Sigue el camino al norte, fuera de Bosque de Argénteos, hacia {zone:1420} y al este hasta las torres de zepelín afuera de {area:153}. Toma el zepelín a {zone:1454}.",

	-- Step 32: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength · {object:173016} Borstan's Firepit
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Entra por la puerta principal. {npc:268701} está en {object:172982}; {object:173016} está a unos pasos al norte.",

	-- Step 33: Cleft of Shadow
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{object:172960} es el cañón bajo {object:172982}; {npc:3216} está al fondo.",

	-- Step 34: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} y {npc:3347} atienden la tienda de alquimia de la calle comercial de la ciudad; {npc:11046} está al lado.",

	-- Step 35: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Las espadañas y el pasto lanza crecen junto al agua en {object:172958}, al este de la calle comercial de la ciudad.",

	-- Step 37: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {npc:3310} Doras · {object:172982} Valley of Strength
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} y {npc:268682} están detrás de la fortaleza de Thrall en {object:172957}; las Rocas lisas ({item:277952}) están a su alrededor. Entrena mientras estés en la ciudad (los druidas y paladines no tienen instructor aquí). La siguiente guía empieza con {npc:3310}, el maestro de jinetes del viento en {object:172982}.",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, dentro de la fortaleza de Thrall",
	-- {area:380} Crossroads
	["Keep it: Thork at the {area:380}"] = "Guárdala: Thork en {area:380}",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, un recorrido por los líderes de la Horda",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Habla con {npc:3230}, en la fortaleza de Thrall",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Habla con {npc:10540}, en la fortaleza de Thrall",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "Al norte de {area:228}. Latipesadilla ronda {area:240}: mátalo y luego cruza el campo.",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790} está en la costa al oeste de {area:240}. Contiene {item:15882} para {quest:30}.",
	-- ["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} es el pueblo cripta de los Renegados en medio del bosque. Todos los que necesitas están alrededor de la entrada de la cripta; {npc:2226}, el cuidador de murciélagos, está justo al este.",
}
