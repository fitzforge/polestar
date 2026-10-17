-- Spanish (Latin America) (esMX): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["From {area:2408} fly to {area:392}."] = "Desde {area:2408} vuela a {area:392}.",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco a {area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at the end of {area:392}'s pier."] = "El barco a {area:35} atraca al final del muelle de {area:392}.",
	-- {area:392} Ratchet
	["{area:392} pier"] = "Muelle de {area:392}",

	-- Step 3: Booty Bay
	-- {area:35} Booty Bay
	["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "El barco llega al puerto de {area:35}. Los asignadores de misiones están en los paseos de madera alrededor del puerto y en la posada.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}"] = "para Stoley en {zone:1446}",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: para {quest:2864} en {area:976}",

	-- Step 4: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Sal del pueblo por el túnel; la nota está en la cala de los piratas justo al norte de {area:35}.",

	-- Step 6: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Al sur de Bahía del Botín, los espadachines Velasangre acampan en {area:43}; las cartas y las órdenes están en sus tiendas. Cualquier Velasangre puede llevar tabaco rapé y el ojo de {npc:2493}, así que sigue matando hasta tener ambos.",

	-- Step 8: The Bloodsail ships
	["The Bloodsail ships"] = "Los barcos Velasangre",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon · {quest:624} Cortello's Riddle
	["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Los tres barcos están frente a {area:43}. Las tripulaciones son de nivel 42-45, Aguasmansas 45, Sinquilla 46 y {npc:2546} 48: a nivel 41 es una pelea para un grupo o para el final de la guía. Si vas, nada hasta allí y atrae a la tripulación a la borda de uno en uno. Un pergamino, {quest:624}, está en las cubiertas de los barcos: tómalo.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "para una parada posterior en {zone:1435}",

	-- Step 10: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Toma el camino al norte desde {area:35}; Unbagwa está en una colina en {area:1737}, al este del camino.",

	-- Step 11: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas Velo de Bruma",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Los gorilas deambulan por el valle alrededor de Unbagwa. Los ancianos sueltan las menudencias; cualquiera puede soltar un colmillo.",

	-- Step 12: Mokk the Savage
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Entrega los colmillos a Unbagwa y quédate a su lado: invoca tres oleadas de gorilas y luego a {npc:1514}. Pelea con ellos de uno en uno.",

	-- Step 13: Zanzil's camps
	["Zanzil's camps"] = "Campamentos de Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Al noreste del Velo de Bruma, los seguidores de Zanzil acampan en la jungla; cualquiera de ellos puede llevar la mezcla.",

	-- Step 14: Venture Co. mine
	["Venture Co. mine"] = "Mina de Ventura y Cía.",
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Más al norte, los goblins de Ventura y Cía. excavan en la mina al este del camino; los canteros, supervisores, peritos y manitas sueltan los cristales.",

	-- Step 15: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride north-west to {object:3202}."] = "Cabalga al noroeste hasta {object:3202}.",
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "para más adelante: {zone:1425}, alrededor del nivel 48",

	-- Step 16: Nesingwary's Expedition
	["Ride north up the road; the hunters camp on the hill above the river."] = "Cabalga al norte por el camino; los cazadores acampan en la colina sobre el río.",

	-- Step 17: Zul'Kunda
	["Zul'Kunda"] = "Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "Al oeste de la expedición, los jefes Sangrapellejo {npc:1061} y {npc:1062} están juntos en las ruinas de Zul'Kunda. Limpia antes sus guardias y luego atráelos.",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Hearth to {object:3202}"] = "Usa la piedra de hogar para ir a {object:3202}",
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",

	-- Step 19: Jungle stalkers
	["Jungle stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Los raptores acechadores cazan en la jungla al sur de {object:3202}, hacia la costa oeste.",

	-- Step 20: Naga shore and the Holy Spring
	-- {object:759} Holy Spring
	["Naga shore and the {object:759}"] = "Orilla de los nagas y {object:759}",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Sigue la costa al sur. Los expedicionarios naga vadean por la orilla y llevan los fardos de juncos; {object:759} burbujea en las colinas justo al este de ellos.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Cabalga al sur hasta {area:35}. Phillipe el Trémulo espera en los muelles.",

	-- Step 22: Pirate ghosts
	["Pirate ghosts"] = "Piratas fantasma",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Los tres piratas fantasmales rondan la jungla al norte de {area:35}, cerca de los campamentos de Zanzil: {npc:2535} y {npc:2536} están juntos, y {npc:2537}, más al este.",

	-- Step 23: Zul'Mamwe
	["Zul'Mamwe"] = "Ruinas de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Cabalga al norte hasta las ruinas Machacacráneos al este de la mina de Ventura y Cía.; atrae a los rebanacabezas y rabiosos de uno en uno. {npc:1059} protege las ruinas del suroeste, y un montón de cráneos trofeo está en el lado norte de las ruinas. Cualquier Machacacráneos puede soltar un colmillo o un collar: los collares son la parte lenta, así que sigue matando en el campamento de guerreros al norte de las ruinas hasta tenerlos todos.",
	["Skullsplitter warriors"] = "Guerreros Machacacráneos",

	-- Step 24: Balia'mah Ruins
	["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Los siguientes cráneos trofeo están en las pequeñas ruinas justo al norte del campamento de guerreros.",

	-- Step 25: Ziata'jai Ruins
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Los últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a {object:3202}.",

	-- Step 26: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride west to {object:3202}."] = "Cabalga al oeste hasta {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",

	-- Step 27: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Usa la piedra de hogar para ir a {area:35}",

	-- Step 28: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",

	-- Step 29: Nesingwary's Expedition
	["Ride north up the road to the hunters' camp."] = "Cabalga al norte por el camino hasta el campamento de los cazadores.",

	-- Step 30: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "A {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Sigue cabalgando al norte hacia {zone:1431} y luego al este por el camino a través de {zone:1430} hasta el pantano. {npc:1776} espera en {area:657}, el campamento draenei cerca de la entrada desde {zone:1430}.",

	-- Step 31: Stonard
	-- {area:75} Stonard
	["Ride east to {area:75}, in the reeds south of the road."] = "Cabalga al este hasta {area:75}, entre los juncos al sur del camino.",

	-- Step 32: Draenethyst crystals
	["Draenethyst crystals"] = "Cristales draenetistas",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Cabalga al noreste hasta {area:76}. Los cristales están a lo largo del camino que sube a la jaula de {npc:5391}.",

	-- Step 33: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} está prisionero en {area:76}, en el noreste del pantano. Libéralo y síguelo hacia afuera, rechazando a las criaturas del pantano que lo persiguen.",

	-- Step 34: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru deambula por el claro al suroeste de {area:76}; su garrote inicia una misión.",

	-- Step 35: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}."] = "Su caja fuerte espera en su antiguo campamento al norte de {area:75}.",

	-- Step 36: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Denteserra",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Los crocoliscos se revuelcan en los charcos alrededor del campamento de {npc:5391} y al sur hacia {area:75}; más o menos uno de cada cuatro suelta un flanco.",

	-- Step 37: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Cabalga al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}.",

	-- Step 38: Misty Reed Post
	-- {area:75} Stonard
	["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Cabalga de vuelta al este pasando {area:75} y sigue el camino al sureste hasta el pequeño puesto de la Horda en la orilla.",

	-- Step 39: Sawtooth snappers
	["Sawtooth snappers"] = "Sacudidores Denteserra",
	["The snappers line the strand south of the post."] = "Los sacudidores bordean la playa al sur del puesto.",

	-- Step 40: Misty Reed Post
	-- {zone:1446} Tanaris
	["The next guide starts here and takes you to {zone:1446}."] = "La siguiente guía empieza aquí y te lleva a {zone:1446}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:657}"] = "{area:657}",
}
