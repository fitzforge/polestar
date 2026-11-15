-- Spanish (Latin America) (esMX): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["{item:268484} and {item:267369} (Forsaken)"] = "{item:268484} y {item:267369} (Renegados)",
	-- {quest:91862} Lumina Windsinger · {quest:95140} Old Fire-Eye
	["The Forsaken paladin's two-handed sword: rescue {quest:91862}, gather three parts, slay {quest:95140}."] = "La espada de dos manos del paladín renegado: rescata a {quest:91862}, junta tres partes y mata a {quest:95140}.",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["At 18 {npc:246378}, inside {area:16602} on the bluffs north-west of the {area:156}, sends you south to the {area:228} in {zone:1421}."] = "A nivel 18, {npc:246378}, dentro de {area:16602}, en los riscos al noroeste de {area:156}, te manda al sur a {area:228}, en {zone:1421}.",

	-- Step 2: Sepulcher
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {npc:259611} Deathguard Baldren
	["{npc:248840} stands in the lower part of the {area:228}, below the surface; {npc:259611} keeps watch near the town's entrance."] = "{npc:248840} está en la parte baja de {area:228}, bajo la superficie; {npc:259611} vigila cerca de la entrada del pueblo.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "La pira de {area:172}",
	-- {area:172} Fenris Isle · {area:228} Sepulcher · {object:566037} Charred Remains
	["{area:172} lies in the lake north-east of the {area:228}. The gnolls' pyre, with the {object:566037}, is on its shore: click the remains to hand in, and click them again for the next quest. The body is a tauren's, not the elf's."] = "{area:172} está en el lago al noreste de {area:228}. La pira de los gnolls, con {object:566037}, está en su orilla: haz clic en los restos para entregar, y vuelve a hacer clic para la siguiente misión. El cuerpo es de un tauren, no de la elfa.",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "de {object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep · {item:267412} Fenris Isle Key · {npc:1944} Rot Hide Bruiser
	["{quest:91862} is caged in the basement of {area:235}, at the north end of the isle. The Rot Hide gnolls (level 18-19) fill the keep: they pull in big groups across floors and players report very fast respawns, so clear a path and keep moving. Any of them can carry the {item:267412} (often the first kill); the rare {npc:1944} (22) and Snarlmane (23) can too. If her cage is empty, another player is escorting her: wait for her to come back."] = "{quest:91862} está enjaulada en el sótano de {area:235}, en el extremo norte de la isla. Los gnolls Pellejo Podrido (nivel 18-19) llenan el castillo: se atraen en grupos grandes entre pisos y los jugadores dicen que reaparecen muy rápido, así que abre un camino y no te detengas. Cualquiera puede llevar {item:267412} (muchas veces el primero que matas); el raro {npc:1944} (22) y Melenagruñona (23) también. Si su jaula está vacía, otro jugador la está escoltando: espera a que vuelva.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}, de los gnolls Putrepellejo",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Libera a {npc:248755}",
	-- {npc:248755} Lumina Windsinger · {area:228} Sepulcher
	["Hand in the key first: starting the escort before that gives the key quest no credit. Then open the cage: {npc:248755} walks out through the keep and its courtyard while the gnolls attack, then runs for the dock and makes her own way back to the {area:228}. Stay close and keep her alive; if she dies, take the quest again when she is back in her cage."] = "Entrega primero la llave: empezar la escolta antes no le da crédito a la misión de la llave. Luego abre la jaula: {npc:248755} sale caminando por el castillo y su patio mientras los gnolls atacan, luego corre hacia el muelle y vuelve sola a {area:228}. Quédate cerca y mantenla con vida; si muere, vuelve a tomar la misión cuando esté otra vez en su jaula.",

	-- Step 6: Back to the Sepulcher
	-- {area:228} Sepulcher
	["Back to the {area:228}"] = "Regresa a {area:228}",
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {quest:95034} The Debt
	["Lumina waits beside {npc:248840} in the {area:228} (a different Lumina from the one you escorted). For {quest:95034}, click through every line of her story."] = "Lumina espera junto a {npc:248840} en {area:228} (una Lumina distinta de la que escoltaste). Para {quest:95034}, recorre cada línea de su historia.",
	-- {npc:248755} Lumina Windsinger · {area:228} Sepulcher
	["{npc:248755}, the {area:228}"] = "{npc:248755}, {area:228}",
	-- {npc:248755} Lumina Windsinger
	["{npc:248755}: hear her story to the end"] = "{npc:248755}: escucha su historia hasta el final",

	-- Step 7: A Moon-Kissed Blade
	-- {npc:259620} Lumina Windsinger · {quest:95140} Old Fire-Eye · {npc:248840} Trevan Rol
	["At 20 {npc:259620} asks for a blade that can kill {quest:95140}. Talk to {npc:248840} beside her for his Weapon Notes, which list the parts, and keep them: he wants them back with the parts. Three parts, in any order: two from dungeons (a group of five each) and a gem from elite naga outside a third."] = "A nivel 20, {npc:259620} pide una hoja que pueda matar a {quest:95140}. Habla con {npc:248840}, a su lado, por sus notas de arma, que listan las partes, y guárdalas: las quiere de vuelta con las partes. Tres partes, en cualquier orden: dos de mazmorras (un grupo de cinco cada una) y una gema de nagas élite afuera de una tercera.",
	-- {item:267454} Trevan's Weapon Notes · {npc:248840} Trevan Rol
	["{item:267454}: talk to {npc:248840}"] = "{item:267454}: habla con {npc:248840}",

	-- Step 8: The Enchanted Silver Ingot
	-- {item:267361} Enchanted Silver Ingot
	["The {item:267361}"] = "{item:267361}",
	-- {area:236} Shadowfang Keep · {npc:4275} Archmage Arugal
	["{area:236} is the dungeon in south Silverpine, for a group of five in the low to mid 20s. The ingot sits on the table next to {npc:4275} at the very end. A friend's cleared instance works: walk in and run to the table."] = "{area:236} es la mazmorra del sur de Bosque de Argénteos, para un grupo de cinco de nivel 20 a 25 más o menos. El lingote está en la mesa al lado de {npc:4275}, al final de todo. Sirve una instancia ya despejada de un amigo: entra y corre hasta la mesa.",
	-- {item:267361} Enchanted Silver Ingot
	["{item:267361}, on Arugal's table"] = "{item:267361}, en la mesa de Arugal",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {zone:1436} Westfall · {zone:1458} Undercity · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} lies under {area:20} in {zone:1436}, Alliance land: a group of five at about 17-24. From the {zone:1458} take the zeppelin to {object:3202} in {zone:1434} and go north through {zone:1431} into {zone:1436}. The way in is the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in Sneed's mast room drop the lumber every time."] = "{area:1581} está debajo de {area:20}, en {zone:1436}, tierra de la Alianza: un grupo de cinco de nivel 17-24 más o menos. Desde {zone:1458} toma el zepelín a {object:3202}, en {zone:1434}, y ve al norte por {zone:1431} hasta {zone:1436}. La entrada es la mina de {area:20}. Los tallistas goblin (élite, nivel 18-19) de la sala del mástil de Sneed sueltan la madera siempre.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, en la mina de {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Talladores de madera goblin, dentro",

	-- Step 10: Ulric Frostveil
	-- {npc:259649} Ulric Frostveil · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["{npc:259649} waits at {area:2897} on {zone:1440}'s west coast: take the zeppelin from {object:3202} (or the {zone:1458}) to {zone:1454}, then go north through the {zone:1413} into {zone:1440} and west along the road. Andruk, the outpost's wind rider master, saves you the walk next time. Take {npc:259649}'s quest before you hunt the naga: the Kor Gem only drops while you have it."] = "{npc:259649} espera en {area:2897}, en la costa oeste de {zone:1440}: toma el zepelín desde {object:3202} (o {zone:1458}) a {zone:1454}, luego ve al norte por {zone:1413} hasta {zone:1440} y al oeste por el camino. Andruk, el maestro de jinetes del viento del puesto, te ahorra la caminata la próxima vez. Toma la misión de {npc:259649} antes de cazar a los nagas: la gema Kor solo cae mientras la tienes.",

	-- Step 11: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The naga stand in the flooded ruins and passages around the {area:2797} entrance, just north of Zoram'gar: you do not need to enter the instance (its first naga drop the gem too). Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24) drop the {item:6995}, one in two. All are elite: grouping up is encouraged. Players solo them one at a time, with difficulty; a group of three makes it easy. They heal themselves, run for help at low health, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "Los nagas están en las ruinas inundadas y pasajes alrededor de la entrada de {area:2797}, justo al norte de Zoram'gar: no hace falta entrar a la instancia (sus primeros nagas también sueltan la gema). Las sacerdotisas de las mareas (nivel 20-21), oráculos (21-22) y brujas del mar (23-24) sueltan {item:6995}, una de cada dos veces. Todos son élite: se recomienda agruparse. Los jugadores los hacen solos de a uno, con dificultad; un grupo de tres lo hace fácil. Se curan solos, huyen a pedir ayuda con poca salud, y las brujas del mar lanzan {spell:122} de cerca. Algunos jugadores dicen que no cae estando en un grupo de banda.",

	-- Step 12: The Purified Kor Gem
	-- {item:272448} Purified Kor Gem
	["The {item:272448}"] = "{item:272448}",
	-- {npc:259649} Ulric Frostveil · {item:272448} Purified Kor Gem · {npc:248840} Trevan Rol
	["Back to {npc:259649} at Zoram'gar: he cleanses the gem. Keep the {item:272448} for {npc:248840}."] = "De vuelta con {npc:259649} en Zoram'gar: purifica la gema. Guarda {item:272448} para {npc:248840}.",

	-- Step 13: Trevan Rol
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268192} Bundle of Blacksmithing Materials · {area:272} Tarren Mill
	["Bring the lumber, the ingot and the gem to {npc:248840} in the {area:228}. He gives you a {item:268192} for a smith in {area:272}: keep it in your bags."] = "Lleva la madera, el lingote y la gema a {npc:248840} en {area:228}. Te da un {item:268192} para un herrero de {area:272}: guárdalo en tus bolsas.",

	-- Step 14: Ott
	-- {npc:3539} Ott · {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {quest:95125} Ott's Masterwork
	["{npc:3539}, the weaponsmith, stands just south of {area:272} in {zone:1424}. Accepting {quest:95125} starts the forging: step back and wait near him until he is done."] = "{npc:3539}, el armero, está justo al sur de {area:272}, en {zone:1424}. Aceptar {quest:95125} empieza la forja: aléjate un poco y espera cerca de él hasta que termine.",
	-- {npc:3539} Ott
	["Watch {npc:3539} forge the blade"] = "Mira a {npc:3539} forjar la hoja",
	-- {npc:3539} Ott · {quest:95125} Ott's Masterwork
	["{npc:3539} gives you {quest:95125}"] = "{npc:3539} te da {quest:95125}",

	-- Step 15: The Moonsilver Blade
	-- {npc:248840} Trevan Rol · {area:228} Sepulcher · {item:268484} Moonsilver Blade
	["Back to {npc:248840} in the {area:228}'s lower part: he hands you the {item:268484}, a two-handed sword."] = "De vuelta con {npc:248840} en la parte baja de {area:228}: te da {item:268484}, una espada de dos manos.",

	-- Step 16: Two-Handed Swords
	-- {npc:11870} Archibald · {zone:1458} Undercity · {object:36070} War Quarter · {spell:202} Two-Handed Swords
	["The blade is a two-handed sword, and you need the skill to hit a level 25 elite with it. {npc:11870}, the weapon master in the {zone:1458}'s {object:36070}, teaches {spell:202} for a small fee; then swing it on easy mobs until the skill is near its cap (five points per level)."] = "La hoja es una espada de dos manos, y necesitas la habilidad para acertarle con ella a un élite de nivel 25. {npc:11870}, el maestro de armas en {object:36070} de {zone:1458}, enseña {spell:202} por un pequeño pago; luego úsala con enemigos fáciles hasta que la habilidad esté cerca de su tope (cinco puntos por nivel).",

	-- Step 17: Old Fire-Eye
	-- {item:268484} Moonsilver Blade · {quest:95140} Old Fire-Eye · {area:228} Sepulcher · {area:17065} Gilneas
	["Equip the {item:268484}. {quest:95140}, the great worgen, roams the woods south of the {area:228} toward the gates of {area:17065}. He is elite (level 25): the guide waits for level 22 first, and grouping up is encouraged; players have killed him from 22 up, one needed a second, another soloed him at 25. A purple shield guards him until your first swing with the blade lands: a message tells you it broke."] = "Equípate el {item:268484}. {quest:95140}, el gran huargen, recorre los bosques al sur de {area:228} hacia las puertas de {area:17065}. Es élite (nivel 25): la guía espera primero al nivel 22, y se recomienda ir en grupo; algunos jugadores lo han matado desde el 22: uno necesitó a un segundo jugador y otro lo mató solo a nivel 25. Un escudo morado lo protege hasta que conectes tu primer golpe con el filo: un mensaje te avisa que se rompió.",
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",
	-- {quest:95140} Old Fire-Eye · {item:268484} Moonsilver Blade
	["{quest:95140}, with the {item:268484} equipped"] = "{quest:95140}, con {item:268484} equipada",

	-- Step 18: Wolfsbane
	-- {npc:259620} Lumina Windsinger · {area:228} Sepulcher · {item:268484} Moonsilver Blade · {item:267369} Wolfsbane
	["Back to {npc:259620} in the {area:228} with the {item:268484} (the quest asks for it): she takes it and blesses it with the magic of her people into {item:267369}."] = "De vuelta con {npc:259620} en {area:228} con {item:268484} (la misión la pide): la toma y la bendice con la magia de su pueblo, convirtiéndola en {item:267369}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Free her with the key, then stay close while she fights her way out of the keep."] = "Libérala con la llave y quédate cerca mientras se abre paso para salir del castillo.",
	-- ["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Aún sin objeto: una historia de rescate para paladines Renegados; su continuación, {item:268484}, todavía no se puede terminar.",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Cuando sale de {area:235}, Lumina te espera en {area:228}. Habla de nuevo con ella para saber qué pasó en realidad en el camino.",
	-- ["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Cuando sale de {area:235}, {npc:259620} te espera en {area:228}. Habla de nuevo con ella para saber qué pasó en realidad en el camino.",
	-- ["Rescuing {quest:91862}"] = "Rescate de {quest:91862}",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Cabalga al sur por {zone:1421} hasta {area:228}. {npc:248840} está en el pueblo; {npc:259611} vigila cerca de la entrada.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} está en el lago al este de {area:228}. Los restos calcinados están en su orilla.",
	-- ["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} dirige a los Paladines de la Guardia de Tyr desde el interior de {area:16602}, en los riscos al noroeste de {area:156}.",
	-- ["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} está enjaulada dentro de {area:235}, en el extremo norte de la isla. Los gnolls Putrepellejo a su alrededor llevan la llave.",
	-- ["{zone:1458} and Earthen Ring reputation"] = "Reputación con {zone:1458} y el Anillo de la Tierra",
}
