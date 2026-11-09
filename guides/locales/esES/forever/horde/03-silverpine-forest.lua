-- Spanish (Spain) (esES): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:3310} Doras · {object:172982} Valley of Strength · {npc:268701} Thatog
	["Walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}; {npc:268701} by the bank below it."] = "",

	-- Step 2: Borstan
	-- {object:173016} Borstan's Firepit
	["{object:173016} is a few steps north."] = "",

	-- Step 3: Neeru Fireblade
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:829} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "{object:172960} es el cañón bajo {object:172982}; {quest:829} está en su extremo.",

	-- Step 4: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} y {npc:3347} llevan la tienda de alquimia de La Calle Mayor; {npc:11046} está al lado.",

	-- Step 5: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Las espadañas y la hierba lanza crecen junto al agua en {object:172958}, al este de La Calle Mayor.",

	-- Step 6: Class trainer
	["Class trainer"] = "",
	["Train while you are in the city: Druids and Paladins have no trainer here."] = "",

	-- Step 7: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 8: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 9: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 12: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them."] = "",

	-- Step 13: Thrall
	-- {npc:4949} Thrall · {quest:98024} Journey to the Crossroads · {quest:93739} Exploring the Horde · {quest:95350} Welcome to Azeroth
	["{npc:4949} stands in Grommash Hold. He offers {quest:98024} and {quest:93739} once {quest:95350} is handed in."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, dentro del Fuerte Grommash",
	-- {npc:4949} Thrall · {zone:1413} Barrens
	["{npc:4949}: keep it, Thork at the Crossroads in the {zone:1413} guide"] = "",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, una visita a los líderes de la Horda",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Habla con {npc:3230}, en el Fuerte Grommash",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Habla con {npc:10540}, en el Fuerte Grommash",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "",

	-- Step 14: Nazgrel
	-- {npc:3230} Nazgrel
	["{npc:3230}, in Grommash Hold"] = "",

	-- Step 15: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 16: Brill
	-- {area:159} Brill · {npc:1738} Deathguard Terrence · {npc:1518} Apothecary Johaan
	["{area:159} is a short walk north up the road from the zeppelin towers: {npc:1738} stands by the road into town, {npc:1518} in the apothecary's house on the west side of the square."] = "",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "",

	-- Step 17: Hadric Harlson
	-- {npc:1495} Deathguard Linnea · {npc:267009} Hadric Harlson
	["Back down the road past the zeppelin towers and east to {npc:1495}'s camp: {npc:267009} stands beside her."] = "",

	-- Step 18: The Cult of the Damned
	-- {npc:267009} Hadric Harlson
	-- plural, as words: Dark Neophytes = {npc:267006} Dark Neophyte · Dark Enforcers = {npc:275437} Dark Enforcer · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["The cultists camp a short walk south-east of {npc:267009}. Dark Neophytes and Dark Enforcers drop the Necrotic Crystal Fragments; more fragments, black crystals, lie on the ground among the tents."] = "",

	-- Step 20: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} entrena a los paladines en {area:159}, a poca distancia al norte por el camino desde las torres de zepelín. Vuelve por el mismo camino para ir al Bosque de Argénteos.",

	-- Step 22: The Sepulcher
	-- {area:228} The Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} es el pueblo-cripta de los Renegados en medio del bosque. Todos los que necesitas están alrededor de la entrada de la cripta; {npc:2226}, el cuidador de murciélagos, está justo al este.",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "",

	-- Step 24: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Sigue el camino al sur. {object:1627} está junto a él, al norte de la Aldea Piroleña.",

	-- Step 25: The Dead Field
	-- {area:228} The Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "Al norte de {area:228}. {npc:1983} ronda {area:240}: mátalo y luego cruza el campo.",

	-- Step 26: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Sigue el camino al noreste hasta la casa de los Yorick, en {area:238}.",

	-- Step 27: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "Lupos jaspeados",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "Los Lupos jaspeados merodean por las colinas alrededor de la casa.",

	-- Step 28: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} espera al noreste de la casa. Escóltalo de vuelta hasta {npc:1950}; los huargos atacan por el camino.",
	-- {npc:1978} Deathstalker Erland
	["{npc:1978}, inside"] = "",

	-- Step 31: The Sepulcher
	-- {npc:1938} Dalar Dawnweaver · {area:227} Valgan's Field
	["{npc:1938}: his books lie in the {area:227} farmhouse, on the walk north"] = "",
	-- {npc:1937} Apothecary Renferrel · {zone:1458} Undercity
	["{npc:1937}: Zinge in the {zone:1458}, on the way to the zeppelin at the end"] = "",
	-- {area:233} Ambermill
	["{area:233} comes later, down the lake shore"] = "",

	-- Step 32: Valgan's Field farmhouse
	-- {area:227} Valgan's Field
	["{area:227} farmhouse"] = "",
	-- {area:227} Valgan's Field · {object:1571} Dusty Spellbooks · {npc:1770} Moonrage Darkrunner
	["On the road north, the farmhouse at {area:227}: go upstairs, the {object:1571} lie on the floor in the back room. Looting them brings a {npc:1770}."] = "",
	-- {object:1571} Dusty Spellbooks
	["{object:1571}; upstairs"] = "",

	-- Step 33: Quinn Yorick
	["North again to the Yoricks' house."] = "De nuevo al norte, a la casa de los Yorick.",
	-- {npc:1951} Quinn Yorick
	["{npc:1951}, inside"] = "",

	-- Step 34: Vile Fin murlocs
	["Vile Fin murlocs"] = "Múrlocs Anca Vil",
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east from the Yoricks' house: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "",

	-- Step 35: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:233} Ambermill
	["Follow the lake shore south from the murlocs: the {object:1593} lies at the ferry landing, on the way to {area:233}."] = "",

	-- Step 36: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["Keep south along the shore from the ferry to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Stay out of the middle, where {npc:2120} stands."] = "",

	-- Step 37: The Sepulcher
	-- {area:228} The Sepulcher
	["Back north-west up the road to the {area:228}."] = "",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937}: para Quinn, en el camino al norte al final",
	-- {npc:1938} Dalar Dawnweaver
	["{npc:1938}, just north of Allister"] = "",
	-- {npc:1499} Magistrate Sevren · {area:159} Brill
	["{npc:1499} in {area:159}, on the way to the zeppelin at the end"] = "",

	-- Step 38: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Toma el camino al norte hacia {zone:1420}: la casa de los Yorick en {area:238} está de camino. {quest:425} acecha a poca distancia al oeste.",
	["Inside"] = "",

	-- Step 40: Magistrate Sevren
	-- {area:159} Brill · {npc:1499} Magistrate Sevren
	["{area:159} is a short walk north up the road from the zeppelin towers; {npc:1499} is in the town hall."] = "",

	-- Step 42: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:2050} Raleigh Andrean · {npc:7683} Alessandro Luca · {npc:11044} Doctor Martin Felben · {npc:5204} Apothecary Zinge · {npc:2055} Master Apothecary Faranell
	["{object:1661} lies under the {area:153}, beside the zeppelin towers. {npc:2050} stands at the inn by the way down; {npc:7683} on the way down to the Apothecarium, where {npc:11044} and {npc:5204} stand beside {npc:2055}."] = "",
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}, en El Apothecarium",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, in the Apothecarium"] = "",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}: Helbrim at the Crossroads, in the next guide"] = "",
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093}, the {area:1497}'s paladin trainer"] = "",

	-- Step 43: Lady Sylvanas Windrunner
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter
	["{npc:10181} holds court in the {object:36126}."] = "",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Habla con {npc:10181}, en {object:36126}: {quest:93739}",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "",

	-- Step 44: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 45: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- Step 46: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}."] = "",

	-- Step 52: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 54: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {area:379} Far Watch Post
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide walks from here to {area:379} and the Crossroads."] = "",

	-- Step 55: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {npc:4049} Seereth Stonebreak
	["{npc:4047}: {npc:4049}, on the road into Stonetalon in the next guide"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At the {area:2362}"] = "En el {area:2362}",
	-- ["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lanza {spell:18960}; {npc:11802} está en {area:2361}. Los Adornos de altar están en el fondo de {area:656} y se desvanecen en pocos minutos: nada con uno directamente hasta {area:2362}, en la orilla noroeste, úsalo allí y habla con {npc:11799}.",
	-- ["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Vuela a {area:1638}: {npc:3033} te entrena en {area:1639}. Cielonato: después vuelve volando a {zone:1454} para el zepelín.",
	-- ["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Sigue la orilla del lago al sureste y nada hasta {area:172}. Los gnolls Putrepellejo cubren la isla; todos sueltan icor. No entres en {area:235}, en el lado norte, salvo que vayas a por el nicho opcional: los gnolls de allí son de nivel 18-22.",
	-- ["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "Sigue la orilla del lago hacia el sureste, hacia {area:172}: los Machacadores y Cazamareas Anca Vil de allí sueltan los ojos de múrloc.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Sigue el camino al norte, sal del Bosque de Argénteos hacia {zone:1420} y ve al este hasta las torres de zepelín de fuera de {area:153}. Toma el zepelín a {zone:1454}.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Sigue el camino al norte, sal del Bosque de Argénteos hacia {zone:1420} y continúa hasta {area:159}: allí {npc:246152} entrena a los paladines. Las torres de zepelín están a poca distancia al sur por el camino.",
	-- ["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Desde {area:380}, sigue el camino al noreste hasta {area:1637} y entra por la puerta principal. {npc:3310}, el maestro de jinetes del viento, está en la torre de {object:172982}.",
	-- ["Hearth to the {area:228}"] = "Usa la piedra de hogar para ir a {area:228}",
	-- ["Into Silverpine"] = "Hacia el Bosque de Argénteos",
	-- ["Keep it: Thork at the {area:380}"] = "Guárdala: Thork, en {area:380}",
	-- ["Keep it: {npc:2216} in {area:272}, a later guide"] = "Guárdala: {npc:2216}, en {area:272}, en una guía posterior",
	-- ["Moonrage Bloodhowlers"] = "Aullasangres Furia Lunar",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Los Lupos jaspeados merodean por las colinas alrededor de la casa. Luego ve al sur por la orilla del lago: los Machacadores y Cazamareas Anca Vil de allí sueltan los ojos de múrloc.",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "De nuevo al norte, a la casa de los Yorick. {quest:425} acecha a poca distancia al oeste.",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "Al norte de {area:228}. Latipesadilla ronda {area:240}: mátalo y luego cruza el campo.",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Al noreste de los refugiados, los Esclavos y Guardianes Corvozarpa rondan las ruinas de {quest:516}, en el sureste del bosque.",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Solo si {npc:1938} te dio {quest:98298}: los Aullasangre merodean por los bosques al suroeste de {area:233}, al este de la Aldea Piroleña; sueltan {item:280375}.",
	-- ["Road to Silverpine"] = "Camino al Bosque de Argénteos",
	-- ["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "Al sureste por el camino hasta {area:233}. Los Protectores Dalaran vigilan las afueras y los Magos Dalaran el pueblo; ambos sueltan colgantes. Los Zahoríes y Vigilantes Dalaran patrullan los caminos de alrededor. No te metas en el centro, donde está {npc:2120}.",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Al suroeste de Molino Ámbar, los esclavos y guardianes Corvozarpa rondan las ruinas de {quest:516}, en el sureste del bosque.",
	-- ["Swim back and follow the road west to the {area:228}."] = "Vuelve nadando y sigue el camino al oeste hasta {area:228}.",
	-- ["Take the road north toward {area:85}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Toma el camino al norte hacia {area:85}: la casa de los Yorick en {area:238} está de camino. {quest:425} acecha a poca distancia al oeste.",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Los Refugiados enfermos y Refugiados Haggard deambulan por el camino al sur de la Aldea Piroleña hacia {area:230}.",
	-- ["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Los Acechalagos y Oráculos Anca Vil están en la orilla del lago, al sur de {area:237}, al este de {area:228}.",
	-- ["The refugees"] = "Los refugiados",
	-- ["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "El zepelín aterriza en las torres de fuera de {area:153}. Ve al oeste por el camino, pasa las ruinas y sigue al sur hasta {zone:1421}; sigue el camino hasta {area:228}.",
	-- ["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "Las torres de zepelín están justo fuera de la puerta principal de {zone:1454}. Toma el zepelín a {zone:1420} (el otro va a {object:3202}).",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593} está en el embarcadero de la orilla del lago, al este de {area:228}.",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for Trial of the Sea Lion."] = "{object:177790} está en la costa al oeste de {area:240}. Contiene {item:15882} para La prueba del león marino.",
	-- ["To {area:1637}"] = "A {area:1637}",
	-- ["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Entra por la puerta principal. {npc:268701} está en {object:172982}; {object:173016} está unos pasos al norte.",
	-- ["Worgs and murlocs"] = "Huargos y múrlocs",
	-- ["Zeppelin to {zone:1420}"] = "Zepelín a {zone:1420}",
	-- ["Zeppelin tower"] = "Torre de zepelín",
	-- ["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "mata {npc:1909} en {area:1338}, {zone:1421}",
	-- ["{area:1338} shore"] = "Orilla de {area:1338}",
	-- ["{area:233} comes later, on the southern loop"] = "{area:233} viene más tarde, en el circuito del sur",
	-- ["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de un {object:177785} del lago",
	-- ["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: botín raro de los gnolls",
	-- ["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798}, en {area:2361}, lleva allí a los druidas; luego sigue volando a {zone:1454} para el zepelín",
	-- ["{npc:11799}, at the {area:2362}"] = "{npc:11799}, en {area:2362}",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: acéptala si te la ofrece; puede seguir a su serie {quest:98298}, que esta ruta no hace",
	-- ["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, en el circuito del sur",
	-- ["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} y {npc:268682} están detrás del Fuerte Grommash, en {object:172957}; las Rocas suaves están a su alrededor. Entrena mientras estés en la ciudad (druidas y paladines no tienen instructor aquí). La siguiente guía empieza con {npc:3310}, el maestro de jinetes del viento de {object:172982}.",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} está en {object:172961}, en el lado oeste de la ciudad.",
	-- ["{object:112888}, inside the keep"] = "{object:112888}, dentro del castillo",
	-- ["{object:1599}, just east of the keep"] = "{object:1599}, justo al este del castillo",
	-- ["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, en la siguiente guía",
	-- ["{zone:1454} class quests"] = "Misiones de clase en {zone:1454}",
}
