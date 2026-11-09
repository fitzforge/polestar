-- Spanish (Spain) (esES): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "",

	-- Step 2: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "",

	-- Step 3: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Los acechadores de la selva (40-41) cazan en la costa al sur de {object:3202}. Están muy por encima de ti: atráelos de uno en uno y descansa entre combates.",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Vuela a {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	["Inside"] = "",

	-- Step 7: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Sal del pueblo por el túnel; la nota está en la cala pirata justo al norte de {area:35}.",

	-- Step 8: Booty Bay
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",

	-- Step 9: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Al sur de Bahía del Botín, los aventureros Velasangre acampan en {area:43}; las cartas y las órdenes están en sus tiendas. Cualquier Velasangre puede llevar tabaco y el Ojo de {npc:2493}, así que sigue matando hasta tener ambos.",

	-- Step 11: The Bloodsail ships
	["The Bloodsail ships"] = "Los barcos Velasangre",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["Optional, and tough at 41: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "para una parada posterior en {zone:1435}",

	-- Step 12: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Toma el camino al norte desde {area:35}; Unbagwa está sentado en una colina en {area:1737}, al este del camino.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "",

	-- Step 13: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas de Velo de Bruma",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Los gorilas deambulan por el valle alrededor de Unbagwa. Los ancianos sueltan las tripas; cualquiera puede soltar un colmillo.",

	-- Step 14: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Dale los colmillos a Unbagwa y quédate a su lado: llama a tres oleadas de gorilas y luego a {npc:1514}. Lucha contra ellos de uno en uno.",

	-- Step 16: Venture Co. mine
	["Venture Co. mine"] = "Mina de Ventura y Cía.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "",

	-- Step 18: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Hemet Decautela",
	["Head north up the road; the hunters camp on the hill above the river."] = "",

	-- Step 20: Zul'Kunda
	["Zul'Kunda"] = "Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {quest:586} Speaking with Gan'zulah · {area:1517} Uldaman
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "",
	-- {quest:586} Speaking with Gan'zulah
	["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "",

	-- Step 21: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "",

	-- Step 22: Jungle stalkers
	["Jungle stalkers"] = "Acechadores de la selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Los acechadores de la selva cazan en la jungla al sur de {object:3202}, hacia la costa oeste.",

	-- Step 23: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Sigue la costa hacia el sur. Los exploradores naga vadean la orilla y llevan los fardos de juncos; {object:759} burbujea en las colinas justo al este.",

	-- Step 24: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "",
	-- {npc:6807} Innkeeper Skindle
	["{npc:6807}, upstairs"] = "",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "",

	-- Step 25: Zanzil's camps
	["Zanzil's camps"] = "Campamentos de Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Al noreste de Velo de Bruma, los seguidores de Zanzil acampan en la jungla; cualquiera de ellos puede llevar la mezcla.",

	-- Step 26: Pirate ghosts
	["Pirate ghosts"] = "Fantasmas piratas",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Los tres piratas fantasmales rondan la jungla al norte de {area:35}, cerca de los campamentos de Zanzil: {npc:2535} y {npc:2536} están juntos, {npc:2537} más al este.",

	-- Step 27: Zul'Mamwe
	["Zul'Mamwe"] = "Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "",
	["Skullsplitter warriors"] = "Guerreros Machacacráneos",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",
	["Below ground"] = "",

	-- Step 28: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "",

	-- Step 29: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "",

	-- Step 31: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "",

	-- Step 32: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basiliscos Quijahierro",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "",

	-- Step 33: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride on north to {object:3202}."] = "",

	-- Step 35: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "",

	-- Step 37: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 38: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 42: Level 42.68
	["Level 42.68"] = "",
	-- {quest:192} Panther Mastery · {quest:195} Raptor Mastery · {area:1517} Uldaman
	["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "",

	-- Step 43: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "",

	-- Step 45: Level 42.74
	["Level 42.74"] = "",
	-- {quest:208} Big Game Hunter · {area:1517} Uldaman
	["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "",

	-- Step 49: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "Hacia {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "",

	-- Step 50: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road. Bind here."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "",
	-- {npc:6930} Innkeeper Karakul
	["{npc:6930}, upstairs"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 51: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Denteserra",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Los crocoliscos se revuelcan en las charcas alrededor del campamento de {npc:5391} y hacia el sur hasta {area:75}; uno de cada cuatro, más o menos, suelta un flanco.",

	-- Step 52: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru el Garrote deambula por el claro al suroeste de {area:76}; su garrote inicia una misión.",

	-- Step 53: Draenethyst crystals
	["Draenethyst crystals"] = "Cristales de draenetista",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Cabalga al noreste hasta {area:76}. Los cristales están a lo largo de la subida hasta la jaula de {npc:5391}.",

	-- Step 54: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} está preso en {area:76}, al noreste del pantano. Libéralo y síguelo, defendiéndolo de las criaturas del pantano que lo persiguen.",

	-- Step 55: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "",

	-- Step 56: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Barco a {area:35}",
	-- ["Fly to {area:392}"] = "Vuela a {area:392}",
	-- ["From {area:2408} fly to {area:392}."] = "Desde {area:2408}, vuela a {area:392}.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Más al norte, los goblins de Ventura y Cía. excavan en la mina al este del camino; mineros, supervisores, peritos y manitas sueltan los cristales.",
	-- ["Hearth to {area:35}"] = "Piedra de hogar a {area:35}",
	-- ["Hearth to {object:3202}"] = "Piedra de hogar a {object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "Su caja fuerte espera en su antiguo campamento al norte de {area:75}.",
	-- ["Into the {area:8}"] = "Hacia {area:8}",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Sigue cabalgando al norte hasta {zone:1431} y luego al este por el camino a través de {zone:1430} hasta el pantano. {npc:1776} espera en {area:657}, el campamento draenei cerca de la entrada desde {zone:1430}.",
	-- ["Naga shore and the {object:759}"] = "Costa de los naga y {object:759}",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Vuelve al este pasando {area:75} y sigue el camino al sureste hasta el pequeño puesto de la Horda en la orilla.",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "Cabalga al este hasta {area:75}, entre los juncos al sur del camino.",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Cabalga al norte hasta las Ruinas de Zul'Mamwe, de los Machacacráneos, al este de la mina de Ventura y Cía.; atrae a los rebanacabezas y rabiosos de uno en uno. {npc:1059} guarda las ruinas del suroeste, y una pila de cráneos trofeo está en el lado norte de las ruinas. Cualquier Machacacráneos puede soltar un colmillo o un collar: los collares son lo lento, así que sigue matando en el campamento de guerreros al norte de las ruinas hasta tenerlos todos.",
	-- ["Ride north up the road to the hunters' camp."] = "Cabalga al norte por el camino hasta el campamento de los cazadores.",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Cabalga al norte por el camino; los cazadores acampan en la colina sobre el río.",
	-- ["Ride north-west to {object:3202}."] = "Cabalga al noroeste hasta {object:3202}.",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Cabalga al sur hasta {area:35}. \"Trémulo\" Phillipe espera en los muelles.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Cabalga al oeste por el camino hasta el campamento draenei de {area:657}, cerca de la entrada desde {zone:1430}.",
	-- ["Ride west to {object:3202}."] = "Cabalga al oeste hasta {object:3202}.",
	-- ["Sawtooth snappers"] = "Sacudidores Denteserra",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "El barco llega al puerto de {area:35}. Los que dan misiones están en las pasarelas alrededor del puerto y en la posada.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "El barco a {area:35} atraca al final del muelle de {area:392}.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Los últimos cráneos están en las ruinas a poca distancia al oeste, de camino de vuelta a {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "La siguiente guía empieza aquí y te lleva a {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Los siguientes cráneos trofeo están en las pequeñas ruinas justo al norte del campamento de guerreros.",
	-- ["The snappers line the strand south of the post."] = "Los sacudidores recorren la playa al sur del puesto.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Los tres barcos están frente a {area:43}. Las tripulaciones son de nivel 42-45, Aguasmansas 45, Sinquilla 46 y {npc:2546} 48: a nivel 41 es un combate para grupo o para el final de la guía. Si vas, nada hasta ellos y atrae a la tripulación a la borda de uno en uno. Un pergamino, {quest:624}, está en la cubierta de los barcos: cógelo.",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "Al oeste de la expedición, los jefes Cabellesangre {npc:1061} y {npc:1062} están juntos en las Ruinas de Zul'Kunda. Limpia antes a sus guardias y luego atráelos.",
	-- ["for Stoley in {zone:1446}"] = "para Stoley en {zone:1446}",
	-- ["for a later stop in the {area:8}"] = "para una parada posterior en {area:8}",
	-- ["for later: the {zone:1425}, around level 48"] = "para más tarde: {zone:1425}, alrededor del nivel 48",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}, junto a {npc:2497}",
	-- ["{area:392} pier"] = "Muelle de {area:392}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: para {quest:2864} en {area:976}",
}
