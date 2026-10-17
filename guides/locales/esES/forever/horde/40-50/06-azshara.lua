-- Spanish (Spain) (esES): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- {area:3317} Revantusk Village · {area:1497} Undercity
	["From {area:3317}'s flight master, fly to the {area:1497}."] = "Con el maestro de vuelo de {area:3317}, vuela a {area:1497}.",

	-- Step 2: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} está en {object:36082}.",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:431} Splintertree Post
	["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Toma el zepelín a {zone:1454} en la torre a las afueras de {zone:1458} y luego vuela a {area:431}.",

	-- Step 4: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Entra en {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Cabalga hacia el este por el camino desde el Puesto del Hachazo. {npc:11548} espera en {area:1235}, junto al camino, a pocos pasos al oeste de {area:3137}, de la Alianza: llega desde el oeste y evita a los Centinelas de Azshara y a Jarrodenus (élite).",

	-- Step 5: Highborne and Haldarr satyrs
	["Highborne and Haldarr satyrs"] = "Apariciones de Altonato y sátiros Haldarr",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Las apariciones de Altonato rondan las ruinas justo al norte del santuario; los sátiros Haldarr acampan un poco más al norte.",

	-- Step 6: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Vuelve con {npc:11548} al santuario; mantente al oeste de los guardias de {area:3137}.",

	-- Step 7: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Sigue el camino hacia el norte hasta {area:1237}, el campamento de la Horda.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, en el borde este del campamento: no da experiencia, solo un teletransporte a la torre de Azshara",

	-- Step 8: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Plumas de hipogrifo sin estropear",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Los hipogrifos tronadores vuelan sobre las colinas justo al sur de {area:1237}.",

	-- Step 10: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Cabalga al noreste hasta el campamento del goblin en los acantilados sobre {area:1227}.",

	-- Step 11: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "El campamento de los elfos de sangre está justo al sur de {npc:8420}. Sus cuatro piezas de equipo están en las cajas alrededor del campamento.",

	-- Step 13: Ruins of Eldarath
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Cabalga al suroeste hasta las ruinas. Las cuatro tablillas están entre las ruinas, custodiadas por nagas Látigo de Ira; cualquier sirena o mirmidón Látigo de Ira puede llevar la runa de {npc:8420}.",

	-- Step 14: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Vuelve al noreste con {npc:8420}.",

	-- Step 15: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Cabalga de vuelta al oeste, a {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Guarda las entregas para {npc:4046}, {npc:8659} y {npc:6522}: pasarás por {zone:1456}, {zone:1454} y {zone:1458} más adelante.",

	-- Step 16: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "La torre del Archimago Xylem está en el acantilado justo al norte de {area:1237}; el sendero sube serpenteando por su lado norte.",

	-- Step 18: To Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["To {object:3202}"] = "A {object:3202}",
	-- {area:1237} Valormok · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Vuela de {area:1237} a {zone:1454}, sal por la puerta principal hasta las torres de los zepelines y toma el zepelín a {object:3202}.",

	-- Step 19: Grom'gol Base Camp
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay
	["The {object:2076} beside {npc:2519}"] = "{object:2076} junto a {npc:2519}",

	-- Step 20: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Sigue el camino hacia el sur; los basiliscos toman el sol en las rocas al este, en medio de la selva. Sus fragmentos caen a menudo.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "Sigue al sur hasta {area:35}. {npc:7406} tiene su taller en el anillo superior de la bahía.",
	["Only once all three robots are home"] = "Solo cuando los tres robots estén en casa",

	-- Step 22: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "De vuelta a {object:3202}",

	-- Step 23: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Take the zeppelin back to {zone:1454}."] = "Toma el zepelín de vuelta a {zone:1454}.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, La Calle Mayor",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Guarda el pago de {npc:8659} y {quest:3504} de Ag'tor Puñosangre: se entregan en {area:1237} en una visita posterior.",

	-- Step 24: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {area:1638}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Vuela a {area:1638}; está de camino a {area:1099}. ¿Aún no tienes esa ruta de vuelo? Vuela a {area:378} y cabalga al oeste por {zone:1412}. Hamuul Runatótem y {npc:4046} están en {area:1639}; los druidas y paladines entrenan aquí ({npc:3033}, {npc:246344}).",
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} se reúne en la siguiente guía; el pago de {npc:4046} se entrega a {npc:8587} más adelante.",

	-- Step 25: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: los osos están en {zone:1448}",
	-- {area:1417} Sunken Temple · {npc:7771} Marvon Rivetseeker · {zone:1446} Tanaris
	["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Guarda {area:1417} para {npc:7771} en {zone:1446}.",

	-- Step 26: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Hipogrifos Plumavieja",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Los hipogrifos anidan en las colinas al suroeste del campamento. Mata uno y usa la Vasija de muisek hipogrifo sobre su cuerpo.",

	-- Step 28: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Duendes dardo",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Los dragones feéricos revolotean por el bosque justo al oeste del campamento. Usa la vasija sobre cada uno que mates.",

	-- Step 30: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Caminabosques deambulantes",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Los antárboles deambulan por los caminos del bosque entre el campamento y el centro de {zone:1444}; hay pocos, así que búscalos por los senderos.",

	-- Step 32: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Cabalga al noroeste hasta {area:1108}; {npc:14637} espera en el muelle.",

	-- Step 33: Zapped giants
	["Zapped giants"] = "Gigantes encogidos",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Los caminantes de la tierra y los gigantes del risco recorren las colinas al norte del muelle. Primero, dispara a cada uno con {item:18904}: encogidos, ya no son élite. Cada gigante encogido suelta residuo; usa también la Vasija de muisek gigante de montaña sobre su cuerpo.",

	-- Step 34: Sea elementals
	["Sea elementals"] = "Elementales marinos",
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Los elementales marinos y los rocíos del mar recorren la orilla alrededor del muelle.",

	-- Step 36: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "De vuelta a {area:1099}",

	-- Step 37: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, junto al maestro de jinetes del viento",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "El alquitrán de {npc:7876} y las muestras del Alquimista Morterozugg vienen de {zone:1449}.",

	-- Step 38: Broken Pillar
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Cabalga hacia el sur por el camino hasta {area:1938}; {npc:7771} acampa al lado. Desde aquí, el camino hacia el oeste baja a {zone:1449}, donde empieza la siguiente guía.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Guarda {quest:3444}: el cofre de {npc:7771} se abre en una visita posterior.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:6986}, the {object:172959}"] = "{npc:6986}, {object:172959}",
}
