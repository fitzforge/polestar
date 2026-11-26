-- Spanish (Spain) (esES): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:392} Ratchet · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{area:392}, {zone:1454} and the {zone:1458}, then into the Plaguelands."] = "{area:392}, {zone:1454} y {zone:1458}, luego a las Tierras de la Peste.",

	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",

	-- Step 2: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "El taller de Liv está en el extremo norte de los muelles de {area:392}; {object:149036} está dentro.",
	["Inside"] = "Dentro",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just south of {area:392}, at the water's edge."] = "",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "El agua purificada se entrega en {area:2479}, en {zone:1448}: guárdala para más adelante.",

	-- Step 4: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maestro de vuelo de {area:392}",

	-- Step 5: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 6: Orgrimmar
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172982} Valley of Strength · {zone:1451} Silithus
	["{npc:15188}, {object:172982}: keep it for {zone:1451}"] = "",

	-- Step 7: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} works in the Drag."] = "{npc:7010} trabaja en La Calle Mayor.",

	-- Step 8: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {area:976} Gadgetzan · {zone:1451} Silithus · {zone:2482} Mount Hyjal
	["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1451} guide's first stop, after {zone:2482}."] = "",

	-- Step 9: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "En el {object:172961}. Cada donación toma sesenta lana, seda o paño de mago de tus bolsas: entrega lo que lleves, sáltate el resto.",

	-- Step 10: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "En {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "Ambas donaciones de {item:14047} se entregan más tarde en la ruta: guarda sesenta {item:14047} para cada una si las quieres.",

	-- Step 11: Paladin trainer
	["Paladin trainer"] = "Instructor de paladines",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} en {zone:1456}; {zone:1454} no tiene instructor de paladines",

	-- Step 12: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "Vuela a {zone:1454} y entrena.",

	-- Step 13: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "Hacia {zone:1411}",

	-- Step 14: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 15: Chemist Cuely
	-- {npc:8390} Chemist Cuely
	["{npc:8390} works in the Apothecarium."] = "{npc:8390} trabaja en el Apothecarium.",

	-- Step 16: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "{npc:8390} y {npc:8393} trabajan en el Apotecarium.",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, a su lado",

	-- Step 17: Andron Gant
	-- {npc:6522} Andron Gant · {object:36126} Royal Quarter
	["{npc:6522} stands just outside the Apothecarium, on the way to the {object:36126}."] = "",

	-- Step 18: The Undercity
	-- {object:36126} Royal Quarter
	["Lady Sylvanas holds the {object:36126}."] = "Lady Sylvanas está en {object:36126}.",

	-- Step 19: Royal Quarter
	-- {npc:10781} Royal Overseer Bauhaus · {object:36078} Trade Quarter
	["{npc:10781} keeps the census in the {object:36078}, beside the guild and tabard registrars near the bank."] = "",

	-- Step 21: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, cerca",

	-- Step 22: Jeremiah Payson
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} se entrega a {npc:10778} en {zone:1422}: guárdala.",

	-- Step 23: Royal Quarter
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386759} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "Solo con el {quest:79095} de la tienda de alquimia de {area:159} en las bolsas (la guía de libros de la biblioteca)",

	-- Step 25: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "Cabalga al este desde el {zone:1458} por la carretera; el {area:152} guarda el camino hacia el {zone:1422}.",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: the termites are in {area:2627}, on the next guide"] = "{npc:11615}: las termitas están en {area:2627}, en la siguiente guía",

	-- Step 27: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- was: ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "La granja de {npc:10778} es la primera al este del {area:152}. Los necrófagos farfullantes de la granja llevan la otra mitad de su amuleto; {npc:11075} guarda el caldero del campo.\nCuidado: uno o dos no muertos suelen luchar a su lado, y más señores del caldero pueden atacar tras usar el caldero."
	["{npc:10778}'s farm is the first one east of the {area:152}. {npc:11075} guards the cauldron in the field. Careful: one or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "",

	-- Step 28: Janice Felstone
	["Upstairs"] = "Piso de arriba",

	-- Step 30: Good Luck Other-Half-Charm
	-- {item:12722} Good Luck Other-Half-Charm · {item:12723} Good Luck Charm · {npc:10778} Janice Felstone
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["Jabbering Ghouls on Felstone Farm carry the {item:12722}: kill them until one drops it, then right-click the halves in your bags to join them into the {item:12723}, and take it to {npc:10778} upstairs."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north to {npc:8420} with the rune, then south-west along the road."] = "Vuelve al norte con {npc:8420} con la runa y luego ve al suroeste por el camino.",
	-- ["Back north-west to {npc:8420}."] = "Vuelve al noroeste con {npc:8420}.",
	-- ["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Vuelve al Tomo sin'dorei: entrega los sellos y úsalo para invocar a {npc:8578}.\nCuidado: el cristal vinculado a Rimtori es aleatorio. Cada uno de los otros dos invoca un infernal hostil.",
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Las dos donaciones de {item:14047} se entregan más adelante en la ruta: empieza a guardar {item:14047}.",
	-- ["Crossroads flight master"] = "Maestro de vuelo del Cruce",
	-- ["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Cada uno de los tres oficiales del campamento (53) lleva un sello: {npc:247006} en el centro del campamento, {npc:247013} en su extremo este y {npc:246991}, que patrulla su mitad oeste: enfréntate a él en el lado este de su recorrido, donde apunta la Flecha.\nCuidado: el {npc:250023}, élite de nivel 55-57, está en el borde oeste del campamento, cerca del extremo del recorrido de Hawkhelm: espera a que Hawkhelm vuelva al este.",
	-- ["Fly to the {area:380}"] = "Vuela a {area:380}",
	-- ["Fly to {area:1237}"] = "Vuela a {area:1237}",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "Vuela a {zone:1454}; {npc:4485} está en {object:172958}; {npc:3326} y {npc:8659}, en {object:172960}.",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "Vuela a {zone:1454}; {npc:4485} está en {object:172958}.",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "En {object:172961}. Lleva el paño de lana, el paño de seda y la tela de paño mágico en las bolsas.",
	-- ["Keep the deliveries for {npc:8659}, {npc:6522}, {npc:4485} and {npc:3326}: you pass {zone:1454} and the {zone:1458} next. Magatha's, in {zone:1456}, is off this route: leave it."] = "Guarda las entregas para {npc:8659}, {npc:6522}, {npc:4485} y {npc:3326}: pasarás por {zone:1454} y {zone:1458} a continuación. La de Magatha, en {zone:1456}, queda fuera de esta ruta: déjala.",
	-- ["Makrinni Burrowers"] = "Excavadores Makrinni",
	-- ["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Sigue al noreste cruzando el centro de {zone:1447}: {npc:235903} acampa junto al camino.",
	-- ["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1423} guide's way to Un'Goro."] = "Solo si aún no has hecho {quest:4494}: {npc:7010} trabaja en La Calle Mayor. Pestlezugg la recoge en {area:976}, de camino a Un'Goro en la Guía de {zone:1423}.",
	-- ["Open {object:149036} for the {item:10556}"] = "Abre {object:149036} para coger {item:10556}",
	-- ["Ride back west to {area:1237}."] = "Vuelve al oeste a {area:1237}.",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Ve al este, a las ruinas de la costa. Llena los cuatro viales del químico Cuely en las pozas de marea de la orilla; los naga Látigo de Ira patrullan entre ellas.",
	-- ["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Cabalga al este hasta las ruinas de la costa. Las cuatro tablillas están entre las ruinas, custodiadas por nagas Látigo de Ira (52-55): atráelos de uno en uno.",
	-- ["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "Cabalga al norte por el camino hasta el Cruce; {npc:256386} está allí. Abre cada caja que te dé y llévale lo que haya dentro. Desde el Cruce, sigue volando a {area:1237}.",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Cabalga al noreste hasta el campamento del goblin en los acantilados sobre {area:1227}, justo al norte de los elfos de sangre.",
	-- ["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Ve al sur hasta el borde norte de {area:1221}. Las Sirenas y los Mirmidones Látigo de Ira (50-52) de allí llevan la runa de {npc:8420}; no cae a menudo, así que recorre el borde hasta que salga.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "El campamento de Rimtori está en el extremo este del campamento base. Lee {object:151286} allí y luego mata al Magus.\nCuidado: el cristal vinculado a Rimtori es aleatorio. Cada uno de los otros dos invoca en su lugar un infernal hostil.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "El campamento de Rimtori está en el extremo este del campamento base. Lee el {object:151286} que hay allí: en Forever, el Tomo Sin'dorei de al lado pide entonces los sellos de los tres oficiales del campamento.",
	-- ["South-west along the road: {npc:235903} takes the satyrs."] = "Al suroeste por el camino: {npc:235903} recibe los sátiros.",
	-- ["The Legashi satyrs"] = "Los sátiros Legashi",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Los sátiros Legashi (51-52) ocupan las colinas al norte del campamento de los elfos de sangre: {npc:235903} quiere cinco de cada tipo.",
	-- ["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Los Excavadores Makrinni (50-51) cavan en la arena justo al este de las ruinas, de camino al noreste; ellos y los alijos enterrados allí dan los Fragmentos de tesoro de los Altonato.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Los elfos de sangre acampan en los acantilados del noreste, junto a {area:1227}.\nCuidado: un {npc:250023}, élite de nivel 55-57, está en el borde oeste del campamento: enfréntate a los elfos de sangre desde su lado este.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Los elfos de sangre acampan en los acantilados del noreste, junto a {area:1227}. Las cuatro piezas de equipo de {npc:8420} están en las cajas alrededor del campamento; los Arcanistas elfos de sangre llevan la varita de {npc:247473}.\nCuidado: un {npc:250023}, élite de nivel 55-57, está en el borde oeste del campamento: enfréntate a los elfos de sangre desde su lado este.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "La torre del zepelín está justo al noreste de la puerta principal de {zone:1454}; toma el zepelín a {zone:1458}.",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "La torre de Xylem está en el acantilado justo al norte de {area:1237}: {npc:8395}, en {area:1237}, te teletransporta arriba gratis (habla con él); si no, el camino sube serpenteando por su lado norte.",
	-- ["Zeppelin tower"] = "Torre del zepelín",
	-- ["{area:1221}: kill these as you meet them"] = "{area:1221}: mátalos según te los encuentres",
	-- ["{area:1237} flight master"] = "Maestro de vuelo de {area:1237}",
	-- ["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, de los Arcanistas elfos de sangre",
	-- ["{item:246721}, from {npc:246991}"] = "{item:246721}, de {npc:246991}",
	-- ["{item:246722}, from {npc:247013}"] = "{item:246722}, de {npc:247013}",
	-- ["{item:246725}, from {npc:247006}"] = "{item:246725}, de {npc:247006}",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "La granja de {npc:10778} es la primera al este del {area:152}. Los necrófagos farfullantes de la granja llevan la otra mitad de su amuleto; {npc:11075} guarda el caldero del campo.\nCuidado: uno o dos no muertos suelen luchar a su lado, y más señores del caldero pueden atacar tras usar el caldero.",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}, en El Apothecarium",
	-- ["{npc:11044}, in the {object:36072}"] = "{npc:11044}, en {object:36072}",
	-- ["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957}: guárdala para {zone:1451}",
	-- ["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, los sátiros al norte del campamento de los elfos de sangre",
	-- ["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, una varita de los arcanistas elfos de sangre",
	-- ["{npc:256386}'s crates"] = "Las cajas de {npc:256386}",
	-- ["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",
	-- ["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} acampa en la orilla, justo al norte de {area:392}.",
	-- ["{npc:6522} stands in the {object:36073}."] = "{npc:6522} está en {object:36073}.",
	-- ["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, para {npc:4485} en {zone:1454}",
	-- ["{npc:8578}'s camp"] = "Campamento de {npc:8578}",
	-- ["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: el tomo se entrega a {npc:3326} en {zone:1454}",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050} se entrega a {npc:10778} en {area:28}: guárdala.",
	-- ["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: para {npc:8587} en {area:1237}",
	-- ["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",
	-- ["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",
}
