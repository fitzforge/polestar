-- Spanish (Latin America) (esMX): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:3310} Doras · {object:172982} Valley of Strength · {npc:6929} Innkeeper Gryshka · {npc:268701} Thatog · {zone:1421} Silverpine Forest · {zone:1413} Barrens
	["Walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}; {npc:6929} keeps the inn below it, {npc:268701} stands by the bank. Bind here: the Hearthstone brings you back from {zone:1421} beside the zeppelin towers and the road to the {zone:1413}."] = "Entra por la puerta principal. {npc:3310}, el maestro de jinetes del viento, está en la torre de {object:172982}; {npc:6929} atiende la posada debajo de ella, y {npc:268701} está junto al banco. Vincula aquí tu piedra de hogar: te trae de vuelta desde {zone:1421} junto a las torres del zepelín y el camino a {zone:1413}.",

	-- Step 2: Borstan
	-- {object:173016} Borstan's Firepit
	["{object:173016} is a few steps north."] = "{object:173016} está a unos pasos al norte.",

	-- Step 3: Neeru Fireblade
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:829} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "{object:172960} es el cañón bajo {object:172982}; {quest:829} está al fondo.",
	-- {quest:829} Neeru Fireblade · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["{quest:829}: {quest:809} stands at {area:379}, on the next guide's road to the Crossroads"] = "{quest:829}: {quest:809} está en {area:379}, en el camino de la siguiente guía al Cruce",
	-- {quest:829} Neeru Fireblade · {quest:832} Burning Shadows · {item:4903} Eye of Burning Shadow · {zone:1411} Durotar
	["{quest:829}: {quest:832}, from the {item:4903} in {zone:1411}"] = "{quest:829}: {quest:832}, de {item:4903} en {zone:1411}",

	-- Step 4: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} y {npc:3347} atienden la tienda de alquimia de la calle comercial de la ciudad; {npc:11046} está al lado.",

	-- Step 5: Jandi
	-- {npc:3404} Jandi
	["{npc:3404}, the herbalism trainer, keeps her shop in the Drag."] = "{npc:3404}, la instructora de herboristería, tiene su tienda en la calle comercial de la ciudad.",
	-- {npc:3404} Jandi · {zone:1411} Durotar
	["{npc:3404}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:3404}: Campamento 101, de la fogata de Brakk en {zone:1411}",

	-- Step 6: Jhag
	-- {npc:11066} Jhag
	["{npc:11066}, the enchanting trainer, works in the Drag."] = "{npc:11066}, el instructor de encantamiento, trabaja en la calle comercial de la ciudad.",
	-- {npc:11066} Jhag · {zone:1411} Durotar
	["{npc:11066}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:11066}: Campamento 101, de la fogata de Brakk en {zone:1411}",

	-- Step 7: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Las espadañas y el pasto lanza crecen junto al agua en {object:172958}, al este de la calle comercial de la ciudad.",

	-- Step 8: Thuwd
	-- {npc:7088} Thuwd · {object:172958} Valley of Honor
	["{npc:7088}, the skinning trainer, stands in the {object:172958}."] = "{npc:7088}, el instructor de desuello, está en {object:172958}.",
	-- {npc:7088} Thuwd · {zone:1411} Durotar
	["{npc:7088}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:7088}: Campamento 101, de la fogata de Brakk en {zone:1411}",

	-- Step 9: Karolek
	-- {npc:3365} Karolek · {object:172958} Valley of Honor
	["{npc:3365}, the leatherworking trainer, works in the {object:172958}."] = "{npc:3365}, el instructor de peletería, trabaja en {object:172958}.",
	-- {npc:3365} Karolek · {zone:1411} Durotar
	["{npc:3365}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:3365}: Campamento 101, de la fogata de Brakk en {zone:1411}",

	-- Step 10: Snang
	-- {npc:2855} Snang · {object:172958} Valley of Honor
	["{npc:2855}, the tailoring trainer, is in the {object:172958}."] = "{npc:2855}, el instructor de sastrería, está en {object:172958}.",
	-- {npc:2855} Snang · {zone:1411} Durotar
	["{npc:2855}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:2855}: Campamento 101, de la fogata de Brakk en {zone:1411}",

	-- Step 11: Class trainer
	["Class trainer"] = "Instructor de clase",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5654} Hex of Weakness
	["Train while you are in the city: Druids and Paladins have no trainer here. Troll Priests: train with {npc:6018} in the {object:172961}, who takes {quest:5654}."] = "Entrena mientras estás en la ciudad: los druidas y los paladines no tienen instructor aquí. Sacerdotes trols: entrena con {npc:6018} en {object:172961}, quien recibe {quest:5654}.",

	-- Step 12: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Warrior fastest."] = "Ya que estás aquí: aprende {spell:197} con {npc:11868} ({object:172958}, 10 de plata); las armas de dos manos suben de nivel más rápido a un guerrero.",

	-- Step 13: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Ya que estás aquí: aprende Bastones con {npc:2704} ({object:172958}, 10 de plata); el arma cuerpo a cuerpo de un cazador vale sobre todo por sus estadísticas, y las de dos manos son las que más tienen.",

	-- Step 14: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Ya que estás aquí: aprende Bastones con {npc:2704} ({object:172958}, 10 de plata); un bastón da más estadísticas de hechizo que un arma de una mano mientras subes de nivel.",

	-- Step 17: Whuut
	-- {npc:11046} Whuut · {npc:3348} Kor'geld
	["{npc:11046}, the alchemy trainer, stands next door to {npc:3348}."] = "{npc:11046}, el instructor de alquimia, está al lado de {npc:3348}.",
	-- {npc:11046} Whuut · {zone:1411} Durotar
	["{npc:11046}: Camping 101, from Brakk's campfire in {zone:1411}"] = "{npc:11046}: Campamento 101, de la fogata de Brakk en {zone:1411}",

	-- Step 18: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them."] = "{npc:268684} y {npc:268682} están detrás de la fortaleza de Thrall en {object:172957}; las Rocas lisas están a su alrededor.",

	-- Step 19: Thrall
	-- {npc:4949} Thrall · {quest:98024} Journey to the Crossroads · {quest:93739} Exploring the Horde · {quest:95350} Welcome to Azeroth
	["{npc:4949} stands in Grommash Hold. He offers {quest:98024} and {quest:93739} once {quest:95350} is handed in."] = "{npc:4949} está en la fortaleza de Thrall. Ofrece {quest:98024} y {quest:93739} una vez que entregas {quest:95350}.",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, dentro de la fortaleza de Thrall",
	-- {npc:4949} Thrall · {zone:1413} Barrens
	["{npc:4949}: keep it, Thork at the Crossroads in the {zone:1413} guide"] = "{npc:4949}: guárdala, Thork en el Cruce, en la guía de {zone:1413}",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, un recorrido por los líderes de la Horda",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Habla con {npc:3230}, en la fortaleza de Thrall",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "Habla con {npc:3230}",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Habla con {npc:10540}, en la fortaleza de Thrall",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "Habla con {npc:10540}",

	-- Step 20: Nazgrel
	-- {npc:3230} Nazgrel
	["{npc:3230}, in Grommash Hold"] = "{npc:3230}, en la fortaleza de Thrall",

	-- Step 21: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 22: Brill
	-- {area:159} Brill · {npc:1738} Deathguard Terrence · {npc:1518} Apothecary Johaan · {npc:246152} Shari Stilwell
	["{area:159} is a short walk north up the road from the zeppelin towers: {npc:1738} stands by the road into town, {npc:1518} in the apothecary's house on the west side of the square; Paladins: {npc:246152} trains you in town."] = "{area:159} está a poca distancia al norte por el camino desde las torres de zepelín: {npc:1738} está junto al camino que entra al pueblo, {npc:1518} en la casa del boticario, en el lado oeste de la plaza; paladines: {npc:246152} te entrena en el pueblo.",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "{npc:1518}, adentro",
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152}, in {area:159}"] = "{npc:246152}, en {area:159}",

	-- Step 23: Hadric Harlson
	-- {npc:1495} Deathguard Linnea · {npc:267009} Hadric Harlson
	["Back down the road past the zeppelin towers and east to {npc:1495}'s camp: {npc:267009} stands beside her."] = "De vuelta por el camino, pasando las torres de zepelín, y al este hasta el campamento de {npc:1495}: {npc:267009} está a su lado.",

	-- Step 24: The Cult of the Damned
	-- {npc:267009} Hadric Harlson
	-- plural, as words: Dark Neophytes = {npc:267006} Dark Neophyte · Dark Enforcers = {npc:275437} Dark Enforcer · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["The cultists camp a short walk south-east of {npc:267009}. Dark Neophytes and Dark Enforcers drop the Necrotic Crystal Fragments; more fragments, black crystals, lie on the ground among the tents."] = "Los sectarios acampan a poca distancia al sureste de {npc:267009}. Los neófitos oscuros y los ejecutores oscuros sueltan los Fragmentos de cristal necrótico; hay más fragmentos, cristales negros, en el suelo entre las tiendas.",

	-- Step 27: The Sepulcher
	-- {area:228} The Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} es el pueblo cripta de los Renegados en medio del bosque. Todos los que necesitas están alrededor de la entrada de la cripta; {npc:2226}, el cuidador de murciélagos, está justo al este.",
	-- {npc:2226} Karos Razok · {npc:4556} Gordon Wendham · {zone:1458} Undercity
	["{npc:2226}: {npc:4556} in the {zone:1458}, at the end of this guide; no need to buy the flight"] = "{npc:2226}: {npc:4556} en {zone:1458}, al final de esta guía; no hace falta comprar el vuelo",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "{npc:1952}, bajo tierra",

	-- Step 28: The Sepulcher
	-- {quest:264} Until Death Do Us Part · {object:24776} Yuriv's Tombstone
	["{quest:264} is handed in at {object:24776}, a grave a few steps south of the crypt entrance, not to a person."] = "{quest:264} se entrega en {object:24776}, una tumba a pocos pasos al sur de la entrada de la cripta, no a una persona.",

	-- Step 29: Border Crossings
	-- {object:1627} Dalaran Crate
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood. Careful: Dalaran Apprentices (13) stand around the crate: pull them one at a time before you open it."] = "Sigue el camino al sur. {object:1627} está a un lado, al norte de Aldea Piroleña. Cuidado: hay aprendices de Dalaran (13) alrededor de la caja: atráelos de uno en uno antes de abrirla.",

	-- Step 30: The Dead Field
	-- {area:228} The Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field. Careful: {npc:1983} (14) rises once you have killed rot hide gnolls in the field: fight her with full health."] = "Al norte de {area:228}. {npc:1983} ronda {area:240}: mátalo y luego cruza el campo. Cuidado: {npc:1983} (14) aparece cuando ya mataste gnolls Pellejo Podrido en el campo: enfréntala con la salud completa.",

	-- Step 31: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Sigue el camino al noreste hasta la casa de los Yorick en {area:238}.",

	-- Step 32: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "Huargos jaspeados",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "Los Huargos jaspeados merodean las colinas alrededor de la casa.",

	-- Step 33: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} espera al noreste de la casa. Escóltalo de vuelta con {npc:1950}; los huargos atacan en el camino.",
	-- {npc:1978} Deathstalker Erland
	["{npc:1978}, inside"] = "{npc:1978}, adentro",

	-- Step 36: The Sepulcher
	-- {npc:1938} Dalar Dawnweaver · {area:227} Valgan's Field
	["{npc:1938}: his books lie in the {area:227} farmhouse, on the walk north"] = "{npc:1938}: sus libros están en la granja de {area:227}, en el camino al norte",
	-- {npc:1937} Apothecary Renferrel · {zone:1458} Undercity
	["{npc:1937}: Zinge in the {zone:1458}, on the way to the zeppelin at the end"] = "{npc:1937}: Zinge en {zone:1458}, de camino al zepelín al final",
	-- {area:233} Ambermill
	["{area:233} comes later, down the lake shore"] = "{area:233} viene después, bajando por la orilla del lago",

	-- Step 37: Valgan's Field farmhouse
	-- {area:227} Valgan's Field
	["{area:227} farmhouse"] = "Granja de {area:227}",
	-- {area:227} Valgan's Field · {object:1571} Dusty Spellbooks · {npc:1770} Moonrage Darkrunner
	["On the road north, the farmhouse at {area:227}: go upstairs, the {object:1571} lie on the floor in the back room. Looting them brings a {npc:1770}."] = "En el camino al norte, la granja de {area:227}: sube al piso de arriba; {object:1571} están en el suelo del cuarto del fondo. Al saquearlos aparece un {npc:1770}.",
	-- {object:1571} Dusty Spellbooks
	["{object:1571}; upstairs"] = "{object:1571}; arriba",

	-- Step 38: Quinn Yorick
	["North again to the Yoricks' house."] = "De nuevo al norte, a la casa de los Yorick.",
	-- {npc:1951} Quinn Yorick
	["{npc:1951}, inside"] = "{npc:1951}, adentro",

	-- Step 39: Vile Fin murlocs
	["Vile Fin murlocs"] = "Múrlocs Anca Vil",
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east from the Yoricks' house: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "Sigue la orilla del lago hacia el sureste desde la casa de los Yorick: los Machacadores Anca Vil y Cazamareas Anca Vil de allí sueltan los ojos de múrloc.",

	-- Step 40: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:233} Ambermill
	["Follow the lake shore south from the murlocs: the {object:1593} lies at the ferry landing, on the way to {area:233}."] = "Sigue la orilla del lago al sur desde los múrlocs: {object:1593} está en el embarcadero, de camino a {area:233}.",

	-- Step 41: Ambermill
	-- {area:233} Ambermill · {npc:2540} Dalaran Serpent · {npc:2120} Archmage Ataeric
	["Keep south along the shore from the ferry to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Careful: each Mage (15) fights with a {npc:2540} (15) beside it: pull one Mage at a time from the outskirts. Stay out of the middle, where {npc:2120} (22) stands."] = "Sigue al sur por la orilla desde el embarcadero hasta {area:233}. Los Protectores vigilan las afueras y los Magos el pueblo; ambos sueltan colgantes. Cuidado: cada Mago (15) pelea con un {npc:2540} (15) a su lado: atrae a un Mago a la vez desde las afueras. No entres al centro, donde está {npc:2120} (22).",

	-- Step 42: The Sepulcher
	-- {area:228} The Sepulcher
	["Back north-west up the road to the {area:228}."] = "De vuelta al noroeste por el camino hasta {area:228}.",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937}: para Quinn, en el camino al norte al final",
	-- {npc:1938} Dalar Dawnweaver
	["{npc:1938}, just north of Allister"] = "{npc:1938}, justo al norte de Allister",
	-- {npc:1499} Magistrate Sevren · {area:159} Brill
	["{npc:1499} in {area:159}, on the way to the zeppelin at the end"] = "{npc:1499} en {area:159}, de camino al zepelín al final",

	-- Step 43: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Toma el camino al norte hacia {zone:1420}: la casa de los Yorick en {area:238} está de camino. {quest:425} acecha a poca distancia al oeste.",
	["Inside"] = "Adentro",

	-- Step 45: Magistrate Sevren
	-- {area:159} Brill · {npc:1499} Magistrate Sevren
	["{area:159} is a short walk north up the road from the zeppelin towers; {npc:1499} is in the town hall."] = "{area:159} está a poca distancia al norte por el camino desde las torres de zepelín; {npc:1499} está en el ayuntamiento.",

	-- Step 47: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:2050} Raleigh Andrean · {npc:7683} Alessandro Luca · {npc:11044} Doctor Martin Felben · {npc:5204} Apothecary Zinge · {npc:2055} Master Apothecary Faranell
	["{object:1661} lies under the {area:153}, beside the zeppelin towers. {npc:2050} stands at the inn by the way down; {npc:7683} on the way down to the Apothecarium, where {npc:11044} and {npc:5204} stand beside {npc:2055}."] = "{object:1661} está bajo {area:153}, junto a las torres de zepelín. {npc:2050} está en la posada, de bajada; {npc:7683}, de bajada a la botica real, donde {npc:11044} y {npc:5204} están junto a {npc:2055}.",
	-- {npc:4556} Gordon Wendham
	["{npc:4556}, the weapon merchant beside the bat handler"] = "{npc:4556}, el vendedor de armas junto al cuidador de murciélagos",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "{npc:4551}, el cuidador de murciélagos",
	-- {npc:4551} Michael Garrett · {item:16210} Gordon's Crate · {area:228} The Sepulcher
	["{npc:4551}: keep {item:16210}, Podrig takes it on the next stop at the {area:228}, at 22"] = "{npc:4551}: guarda {item:16210}, Podrig lo recibe en la siguiente parada en {area:228}, a nivel 22",
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}, en la botica real",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, in the Apothecarium"] = "{npc:5204}, en la botica real",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}: Helbrim at the Crossroads, in the next guide"] = "{npc:5204}: Helbrim en el Cruce, en la siguiente guía",
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093}, the {area:1497}'s paladin trainer"] = "{npc:260093}, el instructor de paladines de {area:1497}",

	-- Step 48: Brom Killian
	-- {npc:4598} Brom Killian · {zone:1458} Undercity
	["{npc:4598}, the mining trainer, works in the {zone:1458}."] = "{npc:4598}, el instructor de minería, trabaja en {zone:1458}.",
	-- {npc:4598} Brom Killian · {npc:265812} Eleanor Shackleton
	["{npc:4598}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4598}: Campamento 101, de la fogata de {npc:265812} en Tirisfal",

	-- Step 49: Basil Frye
	-- {npc:4605} Basil Frye · {zone:1458} Undercity
	["{npc:4605}, the blacksmithing trainer, works in the {zone:1458}."] = "{npc:4605}, el instructor de herrería, trabaja en {zone:1458}.",
	-- {npc:4605} Basil Frye · {npc:265812} Eleanor Shackleton
	["{npc:4605}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4605}: Campamento 101, de la fogata de {npc:265812} en Tirisfal",

	-- Step 50: Graham Van Talen
	-- {npc:4586} Graham Van Talen · {zone:1458} Undercity
	["{npc:4586}, the engineering trainer, works in the {zone:1458}."] = "{npc:4586}, el instructor de ingeniería, trabaja en {zone:1458}.",
	-- {npc:4586} Graham Van Talen · {npc:265812} Eleanor Shackleton
	["{npc:4586}: Camping 101, from {npc:265812}'s campfire in Tirisfal"] = "{npc:4586}: Campamento 101, de la fogata de {npc:265812} en Tirisfal",

	-- Step 51: Lady Sylvanas Windrunner
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter
	["{npc:10181} holds court in the {object:36126}."] = "{npc:10181} recibe a su corte en {object:36126}.",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Habla con {npc:10181}, en {object:36126}: {quest:93739}",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "Habla con {npc:10181}",

	-- Step 52: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 53: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "{object:172982} de {zone:1454}",

	-- Step 54: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}."] = "Entra por la puerta principal. {npc:268701} está en {object:172982}.",

	-- Step 57: Neeru Fireblade
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["For your {area:2437} run: the {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end, next to the {area:2437} portal."] = "Para tu recorrido por {area:2437}: {object:172960} es el cañón bajo {object:172982}; {npc:3216} está al fondo, junto al portal de {area:2437}.",

	-- Step 58: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade · {npc:11520} Taragaman the Hungerer · {npc:11518} Jergosh the Invoker · {npc:4949} Thrall
	["{area:2437} is a dungeon for a group of five, about levels 13 to 18, and a full run takes 30 to 45 minutes. Its portal is in the {object:172960}, beside {npc:3216}.\nInside: past Oggleflint and his troggs, {npc:11520} waits in the lava cave and drops his heart. {npc:11518} and Bazzalan, further in, are for {npc:4949}'s Hidden Enemies, which this route leaves out."] = "{area:2437} es una mazmorra para un grupo de cinco, de nivel 13 a 18 más o menos, y un recorrido completo dura de 30 a 45 minutos. Su portal está en {object:172960}, junto a {npc:3216}.\nAdentro: pasando a Oggleflint y sus troggs, {npc:11520} espera en la cueva de lava y suelta su corazón. {npc:11518} y Bazzalan, más adentro, son para “Hidden Enemies” de {npc:4949}, que esta ruta deja fuera.",

	-- Step 59: Neeru Fireblade
	-- {npc:3216} Neeru Fireblade
	["Back out through the portal: {npc:3216} stands beside it."] = "Sal de vuelta por el portal: {npc:3216} está a su lado.",

	-- Step 63: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Paladin fastest."] = "Ya que estás aquí: aprende {spell:197} con {npc:11868} ({object:172958}, 10 de plata); las armas de dos manos suben de nivel más rápido a un paladín.",

	-- Step 65: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {npc:4049} Seereth Stonebreak
	["{npc:4047}: {npc:4049}, on the road into Stonetalon in the next guide"] = "{npc:4047}: {npc:4049}, en el camino hacia Stonetalon, en la siguiente guía",

	-- Step 66: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {area:379} Far Watch Post
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. The next guide walks from here to {area:379} and the Crossroads."] = "{npc:268684} y {npc:268682} están detrás de la fortaleza de Thrall en {object:172957}; las Rocas lisas están a su alrededor. La siguiente guía camina desde aquí hasta {area:379} y el Cruce.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At the {area:2362}"] = "En el {area:2362}",
	-- ["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lanza {spell:18960}; {npc:11802} está en {area:2361}. Los Adornos de altar ({item:15877}) están en el fondo de {area:656} y desaparecen en minutos: nada con uno directo a {area:2362} en la orilla noroeste, úsalo allí y habla con {npc:11799}.",
	-- ["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Vuela a {area:1638}: {npc:3033} te entrena en {area:1639}. Cielonatos: después vuelve volando a {zone:1454} para tomar el zepelín.",
	-- ["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Sigue la orilla del lago al sureste y nada hasta {area:172}. Los gnolls Putrepellejo cubren la isla; todos los tipos sueltan icor. No entres en {area:235}, en el lado norte, salvo que vayas por la opción extra: los gnolls de allí son de nivel 18-22.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Sigue el camino al norte, fuera de Bosque de Argénteos, hacia {zone:1420} y al este hasta las torres de zepelín afuera de {area:153}. Toma el zepelín a {zone:1454}.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Sigue el camino al norte, fuera de Bosque de Argénteos, hacia {zone:1420} y hasta {area:159}: {npc:246152} entrena a los paladines allí. Las torres de zepelín están a poca distancia al sur por el camino.",
	-- ["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "Desde {area:380}, sigue el camino al noreste hasta {area:1637} y entra por la puerta principal. {npc:3310}, el maestro de jinetes del viento, está en la torre de {object:172982}.",
	-- ["Hearth to the {area:228}"] = "Usa tu piedra de hogar para ir a {area:228}",
	-- ["Into Silverpine"] = "Hacia Bosque de Argénteos",
	-- ["Keep it: {npc:2216} in {area:272}, a later guide"] = "Guárdala: {npc:2216} en {area:272}, en una guía posterior",
	-- ["Moonrage Bloodhowlers"] = "Aullasangres Furia Lunar ({npc:1924})",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Los Huargos jaspeados ({npc:1766}) merodean las colinas alrededor de la casa. Luego camina al sur por la orilla del lago: los Machacadores Anca Vil ({npc:1767}) y Cazamareas de allí sueltan los ojos de múrloc.",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "De nuevo al norte, a la casa de los Yorick. {quest:425} acecha a poca distancia al oeste.",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "Al norte de {area:228}. Latipesadilla ronda {area:240}: mátalo y luego cruza el campo.",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Al noreste de los refugiados, los Braceros Corvozarpa ({npc:1974}) y Guardianes rondan las ruinas de {quest:516} en el sureste del bosque.",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Solo si {npc:1938} te dio {quest:98298}: los Aullasangre merodean el bosque al suroeste de {area:233}, al este de Aldea Piroleña; sueltan {item:280375}.",
	-- ["Road to Silverpine"] = "Camino a Bosque de Argénteos",
	-- ["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "Al sureste por el camino hasta {area:233}. Los Protectores vigilan las afueras y los Magos el pueblo; ambos sueltan colgantes. Los Zahoríes y Vigías patrullan los caminos alrededor. No entres al centro, donde está {npc:2120}.",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "Al suroeste de Molino Ámbar, los braceros y guardianes Corvozarpa rondan las ruinas de {quest:516}, en el sureste del bosque.",
	-- ["Take the road north toward {area:85}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Toma el camino al norte hacia {area:85}: la casa de los Yorick en {area:238} está de camino. {quest:425} acecha a poca distancia al oeste.",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Los Refugiados enfermos y demacrados ({npc:2053}) deambulan por el camino al sur de Aldea Piroleña hacia {area:230}.",
	-- ["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Los Acechalagos Anca Vil ({npc:1909}) y Oráculos están en la orilla del lago al sur de {area:237}, al este de {area:228}.",
	-- ["The refugees"] = "Los refugiados",
	-- ["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "El zepelín aterriza en las torres afuera de {area:153}. Camina al oeste por el camino, pasando las ruinas, y al sur hacia {zone:1421}; sigue el camino hasta {area:228}.",
	-- ["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "Las torres de zepelín están justo afuera de la puerta principal de {zone:1454}. Toma el zepelín a {zone:1420} (el otro va a {object:3202}).",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593} está en el embarcadero de la orilla del lago, al este de {area:228}.",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for Trial of the Sea Lion."] = "{object:177790} está en la costa al oeste de {area:240}. Contiene {item:15882} para La prueba del león marino.",
	-- ["To {area:1637}"] = "A {area:1637}",
	-- ["Worgs and murlocs"] = "Huargos y múrlocs",
	-- ["Zeppelin to {zone:1420}"] = "Zepelín a {zone:1420}",
	-- ["Zeppelin tower"] = "Torre del zepelín",
	-- ["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "farmea {npc:1909} en {area:1338}, {zone:1421}",
	-- ["{area:1338} shore"] = "Orilla de {area:1338}",
	-- ["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de un {object:177785} en el lago",
	-- ["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: botín raro de los gnolls",
	-- ["{npc:11066}, the enchanting trainer, works in the Drag."] = "{npc:11066}, el instructor de encantamiento, trabaja en la calle comercial de la ciudad.",
	-- ["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798}, en {area:2361}, lleva volando a los druidas; luego vuela a {zone:1454} para tomar el zepelín",
	-- ["{npc:11799}, at the {area:2362}"] = "{npc:11799}, en {area:2362}",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: acéptala si te la ofrece; puede seguir a su serie {quest:98298}, que la ruta no hace",
	-- ["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, en el circuito sur",
	-- ["{npc:3365}, the leatherworking trainer, works in the {object:172958}."] = "{npc:3365}, el instructor de peletería, trabaja en {object:172958}.",
	-- ["{npc:3404}, the herbalism trainer, keeps her shop in the Drag."] = "{npc:3404}, la instructora de herboristería, tiene su tienda en la calle comercial de la ciudad.",
	-- ["{npc:4551}: keep {item:16210}, Podrig takes it on the ride through the {area:228} at 22"] = "{npc:4551}: guarda {item:16210}, Podrig lo recibe en el viaje por {area:228} a nivel 22",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} está en {object:172961}, en el lado oeste de la ciudad.",
	-- ["{npc:7088}, the skinning trainer, stands in the {object:172958}."] = "{npc:7088}, el instructor de desuello, está en {object:172958}.",
	-- ["{object:112888}, inside the keep"] = "{object:112888}, dentro de la fortaleza",
	-- ["{object:1599}, just east of the keep"] = "{object:1599}, justo al este de la fortaleza",
	-- ["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, siguiente guía",
	-- ["{zone:1454} class quests"] = "Misiones de clase en {zone:1454}",
}
