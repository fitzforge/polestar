-- Russian (ruRU): the guide forever/50-60/mount-hyjal (forever/50-60/mount-hyjal.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus
	["About 100 quests in Forever's new endgame zone, 57 to 59, then on to {zone:1451}."] = "Около ста заданий в новой зоне высоких уровней Forever, с 57 по 59, а затем в {zone:1451}.",

	-- Step 1: Into Mount Hyjal
	-- {area:616} Mount Hyjal
	["Into {area:616}"] = "Entrando en {area:616}",
	-- {area:616} Mount Hyjal · {zone:1452} Winterspring · {area:2255} Everlook · {zone:1451} Silithus · {area:541} Marshal's Refuge · {npc:256222} Ketharas · {area:493} Moonglade · {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge · {npc:10201} Lady Hederine
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Hederine Slayers = {npc:7463} Hederine Slayer
	["New in Forever: this guide follows what players did on {area:616}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{area:616} lies south of {zone:1452}. Fly to {area:2255} (coming from {zone:1451}, ride back north through the pass to {area:541}'s flight master first), bind your Hearthstone at the inn (partway through this guide {npc:256222} sends you to {area:493}, and the way there starts in {area:2255}), then ride south down the road through {area:2249} and on through {area:2256}, which leads up into {area:616}.\nCareful: elites stand along the whole way in. Frostmaul Giants and Preservers (59-60) flank the road through {area:2249}, and Hederine Slayers, Initiates and Manastalkers (57-58) line {area:2256} from its mouth to the zone line, with {npc:10201} (61) on its east side. Follow the arrows' line at full speed, never stop or fight on the way, and don't turn off it."] = "Nuevo en Forever: esta guía sigue lo que hicieron los jugadores en {area:616}. Si un paso es erróneo, dinoslo en el Discord o en GitHub de Polestar y nombra el paso.\n{area:616} queda al sur de {zone:1452}. Vuela a {area:2255} (viniendo de {zone:1451}, primero cabalga de vuelta al norte por el paso hasta el maestro de vuelo de {area:541}), vincula tu Piedra de hogar en la posada (a mitad de esta guía {npc:256222} te envía a {area:493}, y el camino empieza en {area:2255}), y luego cabalga al sur por el camino pasando {area:2249} y por {area:2256}, que sube a {area:616}.\nОсторожно: hay élites en todo el camino. Los gigantes y los preservadores de Frostmaul (59-60) flanquean el camino por {area:2249}, y los asesinos, iniciados y cazamanás de Hederine (57-58) se alinean en {area:2256} desde su boca hasta el límite de la zona, con {npc:10201} (61) en su lado este. Sigue la línea de las flechas a toda velocidad, nunca te detengas ni pelees en el camino, y no te desvíes de ella.",
	-- {area:2249} Frostwhisper Gorge
	["The road through {area:2249}"] = "El camino por {area:2249}",
	-- {area:2256} Darkwhisper Gorge
	["The mouth of {area:2256}"] = "La boca de {area:2256}",
	["Turn west here"] = "Gira aquí al oeste",

	-- Step 2: The road in
	["The road in"] = "El camino de entrada",
	-- {npc:266803} Quintus Wainworth · {npc:266802} Thark Gorax
	["{npc:266803} (Alliance) and {npc:266802} (Horde) wait together by the road a little inside the zone."] = "{npc:266803} (Alianza) y {npc:266802} (Horda) esperan juntos junto al camino, un poco dentro de la zona.",
	-- {quest:96833} Venom Maws · {npc:256222} Ketharas
	["{quest:96833}: for {npc:256222}, the hermit"] = "{quest:96833}: para {npc:256222}, el ermitaño",
	-- {quest:96830} Farsight Guided · {npc:244512} Ortak Lomgok · {area:16848} Elderwild
	["{quest:96830}: for {npc:244512} in {area:16848}, later in this guide; keep it"] = "{quest:96830}: para {npc:244512} en {area:16848}, más tarde en esta guía; guárdala",

	-- Step 3: Loose Cog
	-- {npc:256222} Ketharas
	["The cog lies by the path south-west of the camp, on your way to {npc:256222}."] = "El engranaje está junto al sendero al suroeste del campamento, camino de {npc:256222}.",

	-- Step 4: Ketharas
	-- {npc:256222} Ketharas
	["{npc:256222}, the hermit, lives at the Hermit's Abode a little further south-west. He takes the cog too."] = "{npc:256222}, el ermitaño, vive en el Refugio del Ermitaño, un poco más al suroeste. Él también acepta el engranaje.",
	-- {quest:96796} Woods Workshop · {npc:249235} Kaylaena Springwhisper
	["{quest:96796}: for {npc:249235}, on the way"] = "{quest:96796}: para {npc:249235}, en el camino",

	-- Step 5: Seeds and owl eggs
	["Seeds and owl eggs"] = "Semillas y huevos de búho",
	-- {npc:266803} Quintus Wainworth · {npc:266802} Thark Gorax
	["The seeds and the owl eggs lie on the slopes between the Hermit's Abode and the road you came in on: search north-east up towards {npc:266803} and {npc:266802}."] = "Las semillas y los huevos de búho están en las laderas entre el Refugio del Ermitaño y el camino por el que viniste: busca al noreste, hacia {npc:266803} y {npc:266802}.",

	-- Step 7: Kaylaena Springwhisper's workshop
	-- {npc:249235} Kaylaena Springwhisper
	["{npc:249235}'s workshop"] = "El taller de {npc:249235}",
	-- {npc:249235} Kaylaena Springwhisper · {quest:91923} Celastrus the Bitter · {npc:248709} Sunderbark
	["North-west over the shrub field to {npc:249235}'s workshop on the slope above it. {quest:91923}, an elite (level 57), patrols the field, and {npc:248709}, an elite ancient (level 56), stands in its middle: give both room. Ghansurok, an elite chimaera (level 61), prowls around the workshop itself: see where he is before you ride up to {npc:249235}."] = "Al noroeste, por el campo de arbustos, hasta el taller de {npc:249235} en la ladera por encima. {quest:91923}, un élite (nivel 57), patrulla el campo, y {npc:248709}, un antiguo de élite (nivel 56), está en medio: dales espacio a ambos. Ghansurok, una quimera de élite (nivel 61), ronda el propio taller: mira dónde está antes de cabalgar hasta {npc:249235}.",
	-- {quest:92008} Premiere Parts · {npc:228216} Nami · {area:2255} Everlook · {area:493} Moonglade
	["{quest:92008}: for {npc:228216} in {area:2255}; you go there from {area:493} at the end of this guide"] = "{quest:92008}: para {npc:228216} en {area:2255}; vas allí desde {area:493} al final de esta guía",

	-- Step 8: The ancients' outpost
	["The ancients' outpost"] = "El puesto de los ancianos",
	-- {npc:248395} Tainted Shrubbery · {npc:249235} Kaylaena Springwhisper · {npc:260626} Bluebell · {npc:248367} Hyacinth · {npc:265586} Thylaen · {npc:248366} Fraxinus
	["South down the west side of the shrub field to the ancients' outpost: kill the {npc:248395} you pass for {npc:249235}. {npc:260626}, the flight mistress, waits by the outpost; {npc:248367} and {npc:265586} stand with the ancient {npc:248366}."] = "Al sur, por el lado oeste del campo de arbustos, hasta el puesto de los ancianos: mata los {npc:248395} que cruces para {npc:249235}. {npc:260626}, la maestra de vuelo, espera junto al puesto; {npc:248367} y {npc:265586} están con el anciano {npc:248366}.",

	-- Step 9: Celastrus the Bitter
	-- {quest:91923} Celastrus the Bitter
	["{quest:91923} is elite (level 57) and patrols the shrub field: grouping up is advised."] = "{quest:91923} es de élite (nivel 57) y patrulla el campo de arbustos: se recomienda ir en grupo.",

	-- Step 10: Soil and venison
	["Soil and venison"] = "Tierra y venado",
	-- {npc:256222} Ketharas
	-- plural, as words: Hyjal Stags = {npc:248041} Hyjal Stag
	["The untainted soil lies in the fields south and east of the outpost; Hyjal Stags graze there too, and their venison is for {npc:256222}'s stew."] = "La tierra no mancillada está en los campos al sur y al este del puesto; los ciervos del monte pacen también ahí, y su venado es para el estofado de {npc:256222}.",

	-- Step 11: The ruined catapult and flying machine
	["The ruined catapult and flying machine"] = "La catapulta y la máquina voladora en ruinas",
	-- {npc:256222} Ketharas
	["Two of the wrecks {npc:256222} named lie at the east end of the fields: plant one of his seeds beside each."] = "Dos de los restos que nombró {npc:256222} están en el extremo este de los campos: planta una de sus semillas junto a cada uno.",

	-- Step 12: The shrub field
	["The shrub field"] = "El campo de arbustos",
	-- {npc:248395} Tainted Shrubbery · {quest:91923} Celastrus the Bitter · {npc:248709} Sunderbark
	-- plural, as words: Scarlet Dart Tubers = {item:267289} Scarlet Dart Tuber
	["North into the shrub field: the {npc:248395} drop the leaves, and the Scarlet Dart Tubers grow in the open ground, most of them in the field's western half. The ruined ballista stands at the field's north-eastern edge: plant the last seed there. Keep clear of {quest:91923} and {npc:248709}, the field's elites."] = "Al norte, hacia el campo de arbustos: los {npc:248395} sueltan las hojas, y los tubérculos dardo escarlata crecen en el suelo despejado, la mayoría en la mitad oeste del campo. La ballesta en ruinas está en el borde noreste del campo: planta ahí la última semilla. Mantente lejos de {quest:91923} y de {npc:248709}, los élites del campo.",
	-- {npc:262036} Ruined Ballista
	["the {npc:262036}"] = "los {npc:262036}",

	-- Step 13: Celastrus the Bitter
	-- {quest:91923} Celastrus the Bitter
	["{quest:91923} is elite: grouping up is advised. He walks the shrub field."] = "{quest:91923} es de élite: se recomienda ir en grupo. Camina por el campo de arbustos.",

	-- Step 14: Ketharas
	["South-east back to the Hermit's Abode."] = "Al sureste, de vuelta al Refugio del Ermitaño.",

	-- Step 15: Ketharas's shrine
	-- {npc:256222} Ketharas
	["{npc:256222}'s shrine"] = "El altar de {npc:256222}",
	["The shrine is a pair of standing stones west of the Hermit's Abode, on the way back to the outpost: bury the remains there."] = "El altar son un par de piedras en pie al oeste del Refugio del Ermitaño, en el camino de vuelta al puesto: entierra ahí los restos.",

	-- Step 17: The ancients' outpost
	["West to the outpost."] = "Al oeste, hacia el puesto.",
	-- {npc:248366} Fraxinus
	["put the poultice on {npc:248366}"] = "pon la cataplasma sobre {npc:248366}",

	-- Step 19: The Dying Ancients
	-- {npc:248709} Sunderbark
	["{npc:248709} is an elite corrupted ancient (level 56) in the middle of the shrub field, back east: grouping up is advised."] = "{npc:248709} es un antiguo corrupto de élite (nivel 56) en medio del campo de arbustos, al este: se recomienda ir en grupo.",

	-- Step 20: Sunderbark
	-- {npc:248709} Sunderbark
	["{npc:248709} is elite: grouping up is advised."] = "{npc:248709} es de élite: se recomienda ir en grupo.",
	["plant the seed in his remains"] = "planta la semilla en sus restos",

	-- Step 22: The Curious Crow
	-- {npc:257753} Curious Crow
	["The {npc:257753}"] = "El {npc:257753}",
	-- {area:17050} Felblood Scar · {npc:257753} Curious Crow
	["West of the outpost to {area:17050}: the {npc:257753} perches at its southern end."] = "Al oeste del puesto hasta {area:17050}: el {npc:257753} se posa en su extremo sur.",

	-- Step 23: Felflick
	-- {npc:263757} Felflick
	["North to {npc:263757}, a demon caged in the middle of the scar. He stood at the spot marked here every time he was met in the recording, south of where the quest data puts him."] = "Al norte, hacia {npc:263757}, un demonio enjaulado en medio de la cicatriz. Estuvo en el punto marcado aquí cada vez que lo encontraron en la grabación, al sur de donde los datos de la misión lo ponen.",

	-- Step 24: The Ashen camp
	["The Ashen camp"] = "El campamento Cinérico",
	-- plural, as words: Ashen Acolytes = {npc:260422} Ashen Acolyte · Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The Ashen Acolytes hold the camp at the north of the scar. Not every Acolyte carries notes: keep killing them after the twelve kills until you have all twelve notes.\nCareful: Awakened Fel Ash Slimes (58, elite) ooze about the scar: pull the Acolytes away from them."] = "Los acólitos Cineros sostienen el campamento, al norte de la cicatriz. No todos llevan notas: sigue matándolos después de las doce muertes hasta que tengas las doce notas.\nОсторожно: los limos de ceniza vil despiertos (58, élite) se deslizan por la cicatriz: aparta a los acólitos de ellos.",

	-- Step 26: Fel-slime crystals
	["Fel-slime crystals"] = "Cristales de limo vil",
	-- {npc:263757} Felflick · {npc:257753} Curious Crow
	["The crystals grow in the scar west and south of {npc:263757}. The pristine one turned up at the scar's southern end, close to the {npc:257753}, at the spot marked."] = "Los cristales crecen en la cicatriz al oeste y al sur de {npc:263757}. El prístino apareció en el extremo sur de la cicatriz, cerca del {npc:257753}, en el punto marcado.",

	-- Step 27: The Curious Crow
	["The Crow is just south of the pristine crystal."] = "El Cuervo está justo al sur del cristal prístino.",

	-- Step 28: Slime ooze as you go
	["Slime ooze as you go"] = "Deslízate entre limos según vas",
	-- plural, as words: Noxious Slimes = {npc:243509} Noxious Slime · Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The Noxious Slimes crawl all over the scar's southern half, and not every one leaves ooze: kill the ones you pass from here on.\nCareful: Awakened Fel Ash Slimes (elites, 58) ooze among the slimes: leave them be."] = "Los limos nocivos reptan por toda la mitad sur de la cicatriz, y no todos dejan limo: mata los que cruces de aquí en adelante.\nОсторожно: los limos de ceniza vil despiertos (élites, 58) se deslizan entre los limos: déjalos en paz.",

	-- Step 30: The warlocks
	["The warlocks"] = "Los brujos",
	-- {npc:260440} Brashann Grimdark
	-- plural, as words: Awakened Fel Ash Slimes = {npc:264306} Awakened Fel Ash Slime
	["The three warlocks and {npc:260440} are in and around the Ashen camp at the north of the scar.\nCareful: Awakened Fel Ash Slimes (58, elite) ooze about the scar: keep clear of them."] = "Los tres brujos y {npc:260440} están dentro y alrededor del campamento Cinérico, al norte de la cicatriz.\nОсторожно: los limos de ceniza vil despiertos (58, élite) se deslizan por la cicatriz: mantente lejos de ellos.",

	-- Step 32: The bone pile
	["The bone pile"] = "La pila de huesos",
	-- {npc:264306} Awakened Fel Ash Slime
	["West to the bone pile by the slime pools: throw the warlocks' bones on it, then hand the quest in at the pile itself. Handing it in wakes the {npc:264306}, an elite (level 58) that hits hard: unless you are grouped for it, hand in and ride clear at once."] = "Al oeste, hacia la pila de huesos junto a las pozas de limo: arroja los huesos de los brujos sobre ella, y luego entrega la misión en la propia pila. Entregarla despierta al {npc:264306}, un élite (nivel 58) que pega duro: a menos que vengas en grupo, entrega y aléjate al galope de inmediato.",

	-- Step 33: Amalgamated Marrow
	-- {npc:264306} Awakened Fel Ash Slime
	["The bone pile wakes the {npc:264306}, an elite (level 58) that hits hard: grouping up is advised."] = "La pila de huesos despierta al {npc:264306}, un élite (nivel 58) que pega duro: se recomienda ir en grupo.",

	-- Step 34: Prickly pinecones
	["Prickly pinecones"] = "Piñas con pinchos",
	["The pinecones lie under the healthy trees just south of the bone pile, on the scar's south-western rim, and a few east of the Crow."] = "Las piñas están bajo los árboles sanos justo al sur de la pila de huesos, en el borde suroeste de la cicatriz, y unas pocas al este del Cuervo.",

	-- Step 35: Felflick
	-- {npc:263757} Felflick
	["{npc:263757}: decide his fate"] = "{npc:263757}: decide su destino",

	-- Step 36: Finish the slime ooze
	["Finish the slime ooze"] = "Remata el limo vil",
	["The slimes are thickest in the scar's south-western corner."] = "Los limos son más densos en la esquina suroeste de la cicatriz.",

	-- Step 39: The Ashen workstations
	["The Ashen workstations"] = "Los puestos de trabajo Cineros",
	["Four workstations stand in the Ashen camp: throw a pinecone at each, from the south up."] = "Cuatro puestos de trabajo están en el campamento Cinérico: arroja una piña a cada uno, de sur a norte.",
	["Slime Workstation"] = "Puesto de limo",
	["Alchemy Workstation"] = "Puesto de alquimia",
	["Disease Workstation"] = "Puesto de enfermedad",
	["Vessel Workstation"] = "Puesto de vasijas",

	-- Step 40: The Curious Crow
	-- {quest:91881} The Western Post · {npc:244517} Sefira Everbright · {area:16848} Elderwild
	["{quest:91881}: for {npc:244517} in {area:16848}, later in this guide; keep it"] = "{quest:91881}: para {npc:244517} en {area:16848}, más tarde en esta guía; guárdala",
	-- {quest:91881} The Western Post · {npc:244511} Zet'gan · {area:16848} Elderwild
	["{quest:91881}: for {npc:244511} in {area:16848}, later in this guide; keep it"] = "{quest:91881}: para {npc:244511} en {area:16848}, más tarde en esta guía; guárdala",

	-- Step 41: Velician
	-- {npc:278305} Velician
	["West across the slope from the scar: {npc:278305} waits alone."] = "Al oeste, por la ladera desde la cicatriz: {npc:278305} espera solo.",

	-- Step 43: Ketharas
	["East across the foothills to the Hermit's Abode."] = "Al este, por las estribaciones, al Refugio del Ermitaño.",

	-- Step 44: Fly to Moonglade
	-- {area:493} Moonglade
	["Fly to {area:493}"] = "Vuela a {area:493}",
	-- {npc:260626} Bluebell · {area:493} Moonglade · {spell:18960} Teleport: Moonglade · {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {zone:1448} Felwood
	["Back west to {npc:260626} at the ancients' outpost and fly to {area:493}. Druids: {spell:18960} is quicker. (No flight path to {area:493} yet? The road in is {area:1769}'s tunnel, from {zone:1452} or {zone:1448}.)"] = "De vuelta al oeste, hacia {npc:260626} en el puesto de los ancianos, y vuela a {area:493}. Druidas: {spell:18960} es más rápido. (¿Aún no tienes ruta de vuelo a {area:493}? El camino es el túnel de {area:1769}, desde {zone:1452} o {zone:1448}.)",
	-- {npc:260626} Bluebell
	["{npc:260626}, the flight mistress"] = "{npc:260626}, la maestra de vuelo",

	-- Step 45: Fly to Moonglade
	-- {area:493} Moonglade · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Fly to {area:493} from {area:2255}'s flight master. No flight path to {area:493} yet? The way in is the tunnel through {area:1769}, at the western end of {zone:1452}."] = "Vuela a {area:493} desde el maestro de vuelo de {area:2255}. ¿Aún no tienes ruta de vuelo a {area:493}? La entrada es el túnel por {area:1769}, en el extremo oeste de {zone:1452}.",

	-- Step 46: Dendrite Starblaze
	-- {area:2361} Nighthaven · {npc:11802} Dendrite Starblaze
	["North into {area:2361}: {npc:11802} stands in the north-east of the village, upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Al norte, hacia {area:2361}: {npc:11802} está en el noreste de la aldea, en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",

	-- Step 47: Orokai
	-- {npc:216289} Orokai
	["South-west to {npc:216289}, the ancient. Talk to him again when you are ready and watch what he shows you."] = "Al suroeste, hacia {npc:216289}, el anciano. Habla con él de nuevo cuando estés listo y mira lo que te muestra.",
	-- {npc:216289} Orokai
	["{npc:216289}: ready to watch"] = "{npc:216289}: listo para mirar",

	-- Step 48: Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",
	-- {quest:93773} The Pact · {npc:256222} Ketharas
	["{quest:93773}: for {npc:256222}"] = "{quest:93773}: para {npc:256222}",

	-- Step 49: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Летите сюда: {area:2255}",
	-- {area:493} Moonglade · {area:2255} Everlook · {npc:249235} Kaylaena Springwhisper
	["South to {area:493}'s flight master (the Alliance's at the southern end of the valley, the Horde's at its south-western end) and fly to {area:2255} for {npc:249235}'s parts order."] = "Al sur, hacia el maestro de vuelo de {area:493} (el de la Alianza en el extremo sur del valle, el de la Horda en su extremo suroeste) y vuela a {area:2255} por el encargo de piezas de {npc:249235}.",

	-- Step 50: Nami
	-- {npc:228216} Nami · {area:2255} Everlook · {area:16853} Tainted Foothills · {npc:249235} Kaylaena Springwhisper
	["{npc:228216} stands between {area:2255}'s two flight masters. Her crate holds fragile cells that fizzle out in time and when knocked about: fly straight back to the {area:16853} and take it to {npc:249235} without detours or fights (about four minutes in the recording). If it fizzles out anyway, {npc:228216} fills it again."] = "{npc:228216} está entre los dos maestros de vuelo de {area:2255}. Su caja guarda células frágiles que se desvanecen con el tiempo y cuando se golpean: vuela directo de vuelta a {area:16853} y llévala a {npc:249235} sin desvíos ni peleas (unos cuatro minutos en la grabación). Si se desvanece igualmente, {npc:228216} la rellena.",

	-- Step 51: Fly to the Tainted Foothills
	-- {area:16853} Tainted Foothills
	["Fly to the {area:16853}"] = "Vuela a {area:16853}",

	-- Step 52: Kaylaena Springwhisper's workshop
	-- {npc:260626} Bluebell
	["North from {npc:260626} to the workshop, crate first. Watch for Ghansurok, the elite chimaera (level 61) that prowls around the workshop."] = "Al norte, desde {npc:260626}, hacia el taller, la caja primero. Vigila a Ghansurok, la quimera de élite (nivel 61) que ronda el taller.",
	["deliver the crate before it fizzles"] = "entrega la caja antes de que se desvanezca",
	-- {quest:92011} Rubble Rummage · {area:16866} Dae'gun
	["{quest:92011}: in {area:16866}, later in this guide; keep it"] = "{quest:92011}: en {area:16866}, más tarde en esta guía; guárdala",

	-- Step 53: Ketharas
	["South-east to the Hermit's Abode."] = "Al sureste, al Refugio del Ermitaño.",
	-- {quest:96930} The Capricious Corvid · {npc:257753} Curious Crow
	["{quest:96930}: for the {npc:257753}, later in this guide"] = "{quest:96930}: para el {npc:257753}, más tarde en esta guía",
	-- {quest:92171} Taking to New Heights · {npc:254131} Skylord Omnuron
	["{quest:92171}: for {npc:254131}, later in this guide"] = "{quest:92171}: para {npc:254131}, más tarde en esta guía",

	-- Step 54: The Curious Crow
	-- {npc:257753} Curious Crow · {area:17050} Felblood Scar
	["West across the foothills, past the ancients' outpost, to the {npc:257753} at the southern end of {area:17050}."] = "Al oeste, por las estribaciones, pasando el puesto de los ancianos, hacia el {npc:257753} en el extremo sur de {area:17050}.",
	-- {quest:96931} Heading Up the Mountain · {area:17145} Cradle of Tranquility
	["{quest:96931}: for the {area:17145}, later in this guide"] = "{quest:96931}: para el {area:17145}, más tarde en esta guía",

	-- Step 55: Malorne's Retreat
	-- {area:17144} Malorne's Retreat · {npc:249549} Fenwick Togglespring
	["West along the southern slopes to {area:17144}: {npc:249549}, a gnome test pilot, hangs tangled up in a tree. A sturdy branch lies just south of him."] = "Al oeste por las laderas del sur hasta {area:17144}: {npc:249549}, un gnomo piloto de pruebas, cuelga enredado en un árbol. Una rama resistente está justo al sur de él.",
	-- {npc:254501} Tree Branch
	["{npc:254501}, above Fenwick's head"] = "{npc:254501}, sobre la cabeza de Fenwick",

	-- Step 56: Fenwick's survival pack
	["Fenwick's survival pack"] = "El paquete de supervivencia de Fenwick",
	["His pack fell just north of the tree. Open it, then wait half a minute while its safety lock discharges before you open it again."] = "Su paquete cayó justo al norte del árbol. Ábrelo, y luego espera medio minuto mientras se descarga su bloqueo de seguridad antes de abrirlo de nuevo.",

	-- Step 57: Brerufa
	-- {npc:256978} Brerufa
	["North-west to Barkskin Burrow, the furbolgs' den in the hillside: {npc:256978} waits just north of its mouth. The Barkskin furbolgs show as hostile until your standing with them improves, but none of them attacked in the recording: the Deadwood furbolgs in the camps around are the ones to fight. {npc:256978} offers more only once this first quest is handed in."] = "Al noroeste, hacia la Guarida de Corteza, la madriguera de los furbolgs en la ladera: {npc:256978} espera justo al norte de su boca. Los furbolgs de Corteza se muestran hostiles hasta que tu reputación con ellos mejora, pero ninguno atacó en la grabación: los furbolgs del Bosque Muerto de los campamentos de alrededor son los que hay que combatir. {npc:256978} ofrece más solo una vez entregada esta primera misión.",

	-- Step 58: Deadwood Den Guardians
	-- plural, as words: Deadwood Den Guardians = {npc:252063} Deadwood Den Guardian
	["Deadwood Den Guardians"] = "Guardianes de la Guarida del Bosque Muerto",
	-- {npc:256978} Brerufa
	["The Deadwood furbolgs camp on the slopes north and east of {npc:256978}: kill their Den Guardians."] = "Los furbolgs del Bosque Muerto acampan en las laderas al norte y al este de {npc:256978}: mata a sus Guardianes de la Guarida.",

	-- Step 60: Osi Mistpaw
	-- {npc:256646} Osi Mistpaw
	["Inside the burrow: {npc:256646} at the far end."] = "Dentro de la guarida: {npc:256646} al fondo.",

	-- Step 61: Bear berries
	["Bear berries"] = "Bayas de oso",
	-- {npc:256978} Brerufa
	["The bear berries grow on the slopes around the burrow: a few on the hill north of {npc:256978}, most of them east of the burrow.\nCareful: Grimroot, an elite treant (level 60), walks the slopes west of the burrow, around 16-20,58-66: give him room."] = "Las bayas de oso crecen en las laderas alrededor de la guarida: unas pocas en la colina al norte de {npc:256978}, la mayoría al este de la guarida.\nОсторожно: Grimroot, un antiguo de élite (nivel 60), camina por las laderas al oeste de la guarida, alrededor de 16-20,58-66: dale espacio.",

	-- Step 62: Barkskin Burrow
	["Barkskin Burrow"] = "Guarida de Corteza",
	-- {npc:260661} Suma Mossmane · {npc:256660} Thobon Sapclaw · {area:16848} Elderwild · {area:16867} Shrine of Aviana
	["Back to Osi, then the two elders at the back of the burrow. {npc:260661} stands beside Osi, {npc:256660} a little north-west of them, where the recording met him. {npc:260661}'s moss grows around {area:16848}, later in this guide; {npc:256660}'s amulets come from the harpies at the {area:16867}, also later in this guide, and you bring both back here then."] = "De vuelta con Osi, y luego los dos ancianos al fondo de la guarida. {npc:260661} está junto a Osi, {npc:256660} un poco al noroeste de ellos, donde lo encontró la grabación. El musgo de {npc:260661} crece alrededor de {area:16848}, más tarde en esta guía; los amuletos de {npc:256660} salen de las harpías de {area:16867}, también más tarde en esta guía, y entonces traes ambos aquí.",
	-- {quest:93826} Deal Dread to Deadwood
	["{quest:93826}: on your way back here later; keep it"] = "{quest:93826}: de vuelta aquí más tarde; guárdala",

	-- Step 63: The Western Post
	-- {area:16848} Elderwild · {npc:244517} Sefira Everbright · {npc:249968} Hnaz Blunderflame · {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok
	["North up the valley to {area:16848}, where the Alliance outpost ({npc:244517}, {npc:249968}) and the Horde's ({npc:244511}, {npc:244512}) stand next to each other."] = "Al norte, por el valle, hasta {area:16848}, donde el puesto de la Alianza ({npc:244517}, {npc:249968}) y el de la Horda ({npc:244511}, {npc:244512}) están uno junto al otro.",

	-- Step 64: The Western Post
	-- {area:16848} Elderwild · {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok · {npc:265788} Kal'tinzan
	["North up the valley to {area:16848}, where the Horde outpost ({npc:244511}, {npc:244512}, {npc:265788}) and the Alliance's stand next to each other."] = "Al norte, por el valle, hasta {area:16848}, donde el puesto de la Horda ({npc:244511}, {npc:244512}, {npc:265788}) y el de la Alianza están uno junto al otro.",

	-- Step 66: Elderwild
	-- {area:16848} Elderwild
	["The two outposts of {area:16848}."] = "Los dos puestos de {area:16848}.",
	-- {npc:244512} Ortak Lomgok · {quest:96616} Herbs for the Bruised and Weary · {area:16868} Mourning's Rest
	["{npc:244512}: {quest:96616}, on the way back from {area:16868}"] = "{npc:244512}: {quest:96616}, de vuelta de {area:16868}",

	-- Step 67: Final Death
	-- {quest:92591} Final Death · {npc:260148} Scourge Reanimator · {area:16868} Mourning's Rest
	["{quest:92591}'s {npc:260148} is level 59-60: this guide burns its bone pile once you are 58, on one of its two passes through {area:16868}."] = "El {npc:260148} de {quest:92591} es de nivel 59-60: esta guía quema su pila de huesos una vez que llegas a 58, en una de sus dos pasadas por {area:16868}.",

	-- Step 68: Final Death
	-- {npc:260148} Scourge Reanimator · {quest:92591} Final Death
	["A group choice at your level: the {npc:260148} that answers {quest:92591}'s bone pile is level 59-60."] = "Una opción de grupo a tu nivel: el {npc:260148} que responde a la pila de huesos de {quest:92591} es de nivel 59-60.",

	-- Step 69: Final Death
	-- {npc:260148} Scourge Reanimator · {quest:92592} Final Death
	["A group choice at your level: the {npc:260148} that answers {quest:92592}'s bone pile is level 59-60."] = "Una opción de grupo a tu nivel: el {npc:260148} que responde a la pila de huesos de {quest:92592} es de nivel 59-60.",

	-- Step 70: Moonveil Moss
	-- {npc:260661} Suma Mossmane · {area:16848} Elderwild
	["The moss for {npc:260661} grows around {area:16848}: by the outposts and on the slopes north of them."] = "El musgo de {npc:260661} crece alrededor de {area:16848}: junto a los puestos y en las laderas al norte de ellos.",

	-- Step 71: Eluneth
	-- {npc:264089} Eluneth · {area:16868} Mourning's Rest
	["South-east to {npc:264089} on the slope above {area:16868}."] = "Al sureste, hacia {npc:264089} en la ladera sobre {area:16868}.",

	-- Step 72: Owl feathers
	["Owl feathers"] = "Plumas de búho",
	-- {npc:264089} Eluneth · {area:16848} Elderwild
	-- plural, as words: Hyjal Owls = {npc:249053} Hyjal Owl · Death Wailers = {npc:249226} Death Wailer
	["The Hyjal Owls roost on the slopes between {npc:264089} and Barkskin Burrow: their feathers are for {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over the western slopes: give them a wide berth.\nCareful: Grimroot, the elite treant (level 60), walks the western slopes here: pull the owls away from his path."] = "Los búhos de la montaña anidan en las laderas entre {npc:264089} y la Guarida de Corteza: sus plumas son para {area:16848}.\nОсторожно: los Llorones de la Muerte (61, élites raros) se deslizan sobre las laderas del oeste: mantén amplia distancia.\nОсторожно: Grimroot, el antiguo de élite (nivel 60), camina por las laderas del oeste aquí: aparta a los búhos de su camino.",

	-- Step 73: Unmarked Grave
	-- {area:16868} Mourning's Rest
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener
	["At the northern end of {area:16868}: something has dug up the grave. The Fleshflay Raveners around it carry what was taken."] = "En el extremo norte de {area:16868}: algo ha desenterrado la tumba. Los Rapiñadores de Carne a su alrededor llevan lo que se llevó.",

	-- Step 74: Mourning's Rest
	-- {area:16868} Mourning's Rest · {area:16848} Elderwild
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener · Forgotten Soldiers = {npc:249247} Forgotten Soldier · Death Wailers = {npc:249226} Death Wailer
	["The Scourge hold the ruins of {area:16868}, east of {area:16848}: Fleshflay Raveners and Forgotten Soldiers everywhere, Eternal Sentries among them.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way.\nCareful: Grimroot, the elite treant (level 60), walks the slopes on the way in: give him room."] = "La Plaga ocupa las ruinas de {area:16868}, al este de {area:16848}: Rapiñadores de Carne y Soldados Olvidados por todas partes, Centinelas Eternos entre ellos.\nОсторожно: los Llorones de la Muerte (61, élites raros) se deslizan sobre {area:16868}: mantente lejos de ellos.\nОсторожно: Grimroot, el antiguo de élite (nivel 60), camina por las laderas al entrar: dale espacio.",

	-- Step 75: Final Death
	-- {area:16868} Mourning's Rest · {item:274411} Survivor's Torch · {npc:260148} Scourge Reanimator
	["Burn the bone pile at the south-eastern end of {area:16868} with the {item:274411}: the {npc:260148} that answers carries the amulet.\nCareful: the {npc:260148} is level 59-60: burn the bone pile last, at full health, with the ruins around it cleared."] = "Quema la pila de huesos en el extremo sureste de {area:16868} con el {item:274411}: el {npc:260148} que responde lleva el amuleto.\nОсторожно: el {npc:260148} es de nivel 59-60: quema la pila de huesos al final, con la salud llena y las ruinas alrededor limpias.",

	-- Step 76: Final Death
	-- {npc:260148} Scourge Reanimator
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised; alone, this guide comes back past the pile later."] = "Una opción de grupo por debajo del nivel 58: el {npc:260148} que responde a la pila de huesos quemada es de nivel 59-60. Se recomienda ir en grupo; en solitario, esta guía vuelve a pasar por la pila más tarde.",

	-- Step 77: Eluneth and the veteran
	-- {npc:264089} Eluneth
	["{npc:264089} and the veteran"] = "{npc:264089} y el veterano",
	-- {npc:264089} Eluneth · {npc:255009} Veteran of the Third War · {area:16868} Mourning's Rest
	["Back to {npc:264089}, then the ghostly {npc:255009} at {area:16868}'s western edge, where the recording met him, on your way west."] = "De vuelta con {npc:264089}, y luego el {npc:255009} espectral en el borde oeste de {area:16868}, donde lo encontró la grabación, camino del oeste.",

	-- Step 78: Hyjal Silphium
	-- {area:16868} Mourning's Rest · {npc:244512} Ortak Lomgok · {area:16848} Elderwild
	-- plural, as words: Death Wailers = {npc:249226} Death Wailer
	["North-east up the slope from the veteran, north of {area:16868}: {npc:244512}'s silphium grows in the meadows there, where the Horde players in our recordings picked it. Then ride west to {area:16848}.\nCareful: Death Wailers (61, rare elites) drift over these slopes: keep out of their way."] = "Al noreste, subiendo la ladera desde el veterano, al norte de {area:16868}: el silfio de {npc:244512} crece en las praderas de ahí, donde los jugadores de la Horda en nuestras grabaciones lo recogían. Luego cabalga al oeste hasta {area:16848}.\nОсторожно: los Llorones de la Muerte (61, élites raros) se deslizan sobre estas laderas: mantente lejos de ellos.",

	-- Step 79: Elderwild
	["West to the Alliance outpost."] = "Al oeste, hacia el puesto de la Alianza.",

	-- Step 81: To the Summit of Eternity
	-- {quest:91688} To the Summit of Eternity · {npc:254915} Thisalee Crow
	["{quest:91688}: for {npc:254915}, later in this guide; keep it"] = "{quest:91688}: para {npc:254915}, más tarde en esta guía; guárdala",

	-- Step 82: Daythor Brellan and Sefira Everbright
	-- {npc:264521} Daythor Brellan · {npc:244517} Sefira Everbright
	["{npc:264521} and {npc:244517}"] = "{npc:264521} y {npc:244517}",
	-- {npc:244517} Sefira Everbright · {npc:264521} Daythor Brellan
	["The worker {npc:244517} means is a peasant just north of her; {npc:264521} stands between them."] = "El trabajador al que se refiere {npc:244517} es un campesino justo al norte de ella; {npc:264521} está entre ambos.",
	-- {quest:94832} Belle's Ring · {npc:2329} Michelle Belle · {area:87} Goldshire
	["{quest:94832}: {npc:2329} at the Lion's Pride Inn in {area:87}; take it only if you'll pass by"] = "{quest:94832}: {npc:2329} en la Posada Orgullo de León en {area:87}; tómala solo si vas a pasar por ahí",

	-- Step 83: Elderwild
	-- {npc:244511} Zet'gan · {npc:244512} Ortak Lomgok · {npc:265788} Kal'tinzan
	["West to the Horde outpost: {npc:244511}, then {npc:244512} and {npc:265788} beside him."] = "Al oeste, hacia el puesto de la Horda: {npc:244511}, y luego {npc:244512} y {npc:265788} a su lado.",
	-- {npc:265788} Kal'tinzan · {quest:91794} Flags of Our Forebears · {area:16866} Dae'gun
	["{npc:265788}: {quest:91794}: the flag and the heraldry are in {area:16866}, later in this guide; keep it"] = "{npc:265788}: {quest:91794}: la bandera y la heráldica están en {area:16866}, más tarde en esta guía; guárdala",

	-- Step 84: Maruke and Enho Runehoof
	-- {npc:265895} Maruke · {npc:265862} Enho Runehoof
	["{npc:265895} and {npc:265862}"] = "{npc:265895} y {npc:265862}",
	-- {npc:244512} Ortak Lomgok · {npc:265895} Maruke · {area:16848} Elderwild · {npc:265862} Enho Runehoof
	["{npc:244512}'s poultice is for two of the outpost's wounded: {npc:265895} lies at the north end of {area:16848}, {npc:265862} just south of {npc:244512}."] = "La cataplasma de {npc:244512} es para dos de los heridos del puesto: {npc:265895} está en el extremo norte de {area:16848}, {npc:265862} justo al sur de {npc:244512}.",

	-- Step 85: Head Scratcher
	-- {quest:92446} Head Scratcher · {npc:244511} Zet'gan
	["{quest:92446} is elite (level 60 in our data): grouping up is advised. {npc:244511}'s rabbit carcass lures him out in the woods by the Deadwood camps south-east of here, on part 3's way back to Barkskin Burrow; his claws come back here at the end of this guide."] = "{quest:92446} es de élite (nivel 60 en nuestros datos): se recomienda ir en grupo. El cadáver de conejo de {npc:244511} lo atrae en el bosque junto a los campamentos del Bosque Muerto al sureste de aquí, en el camino de vuelta a la Guarida de Corteza de la parte 3; sus garras vuelven aquí al final de esta guía.",

	-- Step 86: The overlook
	["The overlook"] = "El mirador",
	["West to the overlook above the valley: the veteran's old scabbard lies there. Hand his quest in at the scabbard and take the next from it, then use the scabbard in your bags to call his spirit and listen to his story."] = "Al oeste, hasta el mirador sobre el valle: la vieja vaina del veterano está ahí. Entrega su misión en la vaina y toma la siguiente de ella, y luego usa la vaina en tus bolsas para llamar a su espíritu y escuchar su historia.",

	-- Step 87: Shalla'kal and Galvinquam Leafsyre
	-- {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["{npc:255683} and {npc:267109}"] = "{npc:255683} y {npc:267109}",
	-- {area:16868} Mourning's Rest · {area:17145} Cradle of Tranquility · {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["East past {area:16868} into the {area:17145}: {npc:255683}, the great cat, waits by the path, and {npc:267109} rests in the ruins just south of her."] = "Al este, pasando {area:16868}, hacia {area:17145}: {npc:255683}, la gran gata, espera junto al camino, y {npc:267109} descansa en las ruinas justo al sur de ella.",

	-- Step 88: Lisbael Highfeather
	-- {npc:268168} Lisbael Highfeather
	["East across the Cradle to {npc:268168}."] = "Al este, por la Cuna, hacia {npc:268168}.",
	-- {quest:96145} Past Wing and Claw · {npc:260825} Phoebe Highfeather
	["{quest:96145}: for {npc:260825}, later in this guide; keep it"] = "{quest:96145}: para {npc:260825}, más tarde en esta guía; guárdala",

	-- Step 89: Jereman
	-- {npc:267158} Jereman
	["North to the old bridge over the Cradle: touch the crow effigy on it and {npc:267158}, the crow wild god, appears."] = "Al norte, hacia el viejo puente sobre la Cuna: toca el ídolo del cuervo en él y aparece {npc:267158}, el dios salvaje cuervo.",

	-- Step 90: The falls and the first kitten
	["The falls and the first kitten"] = "Las cascadas y el primer gatito",
	-- {npc:267109} Galvinquam Leafsyre · {npc:255683} Shalla'kal
	["Fill {npc:267109}'s gourd at the falls beside the bridge. Solstice, one of {npc:255683}'s kittens, plays just west of the falls: walk up to her."] = "Llena el cuerno de {npc:267109} en las cascadas junto al puente. Solstice, una de las gatitas de {npc:255683}, juega justo al oeste de las cascadas: acércate a ella.",
	["fill the gourd"] = "llena el cuerno",
	["Solstice"] = "Solstice",

	-- Step 91: Johun "Punchy" Dillas's camp
	-- {npc:249234} Johun "Punchy" Dillas
	["{npc:249234}'s camp"] = "El campamento de {npc:249234}",
	-- {npc:249234} Johun "Punchy" Dillas
	["North to {npc:249234} and his crates. Drive the skunks out from behind the crates without attacking them."] = "Al norte, hacia {npc:249234} y sus cajas. Echa a los mapaches de detrás de las cajas sin atacarlos.",

	-- Step 92: Brie
	["Brie"] = "Brie",
	-- {npc:249234} Johun "Punchy" Dillas
	["Brie, the second kitten, plays just west of {npc:249234}'s camp."] = "Brie, la segunda gatita, juega justo al oeste del campamento de {npc:249234}.",

	-- Step 93: Foxes
	["Foxes"] = "Zorros",
	-- {npc:249234} Johun "Punchy" Dillas · {npc:255183} Jezerelle the Swaying
	["The Rustleaf Foxes are thick in the woods around {npc:249234}'s camp.\nCareful: {npc:255183} (61, rare) walks the woods north of the camp: leave her be."] = "Los zorros de Hoja Oxidada son densos en el bosque alrededor del campamento de {npc:249234}.\nОсторожно: {npc:255183} (61, rara) camina por el bosque al norte del campamento: déjala en paz.",

	-- Step 95: Kala'th
	-- {npc:255693} Kala'th
	["West across the Cradle to {npc:255693}, another of the wild gods."] = "Al oeste, por la Cuna, hacia {npc:255693}, otro de los dioses salvajes.",

	-- Step 96: The burnt buildings
	["The burnt buildings"] = "Los edificios quemados",
	-- {npc:255693} Kala'th
	["The burnt buildings stand in the meadows east of {npc:255693}: the nails and brackets lie among the rubble."] = "Los edificios quemados están en las praderas al este de {npc:255693}: los clavos y las escarpias están entre los escombros.",

	-- Step 97: Predatory stags
	["Predatory stags"] = "Ciervos depredadores",
	-- {npc:255693} Kala'th
	-- plural, as words: Predatory Hyjal Stags = {npc:256809} Predatory Hyjal Stag · Spectral Frostwyrms = {npc:255691} Spectral Frostwyrm
	["The Predatory Hyjal Stags roam the same meadows, east of {npc:255693}.\nCareful: Spectral Frostwyrms (61, elites) circle over the western meadows: keep out from under them."] = "Los ciervos depredadores del monte rondan las mismas praderas, al este de {npc:255693}.\nОсторожно: los Vermis de Escarcha Espectrales (61, élites) giran sobre las praderas del oeste: mantente lejos de ellos.",

	-- Step 99: Marrosis
	-- {npc:267113} Marrosis · {area:16868} Mourning's Rest
	["South to {npc:267113}, another wild god, at {area:16868}'s eastern edge."] = "Al sur, hacia {npc:267113}, otro dios salvaje, en el borde este de {area:16868}.",
	-- {quest:92317} Stolen Life · {npc:256222} Ketharas
	["{quest:92317}: for {npc:256222}, later in this guide; keep it"] = "{quest:92317}: para {npc:256222}, más tarde en esta guía; guárdala",

	-- Step 100: Bones and stolen life
	["Bones and stolen life"] = "Huesos y vida robada",
	-- {area:16868} Mourning's Rest
	-- plural, as words: Fleshflay Raveners = {npc:249228} Fleshflay Ravener · Death Wailers = {npc:249226} Death Wailer · Spectral Frostwyrms = {npc:255691} Spectral Frostwyrm
	["The sun-bleached bones lie all over {area:16868}; the Fleshflay Raveners there carry the drop of stolen life.\nCareful: Death Wailers (61, rare elites) drift over {area:16868}: keep out of their way. Spectral Frostwyrms (61, elites) circle over the meadows around it: keep out from under them."] = "Los huesos blanqueados por el sol están por todo {area:16868}; los Rapiñadores de Carne de ahí llevan la gota de vida robada.\nОсторожно: los Llorones de la Muerte (61, élites raros) se deslizan sobre {area:16868}: mantente lejos de ellos. Los Vermis de Escarcha Espectrales (61, élites) giran sobre las praderas alrededor: mantente lejos de ellos.",

	-- Step 101: Final Death
	-- {area:16868} Mourning's Rest · {item:274411} Survivor's Torch · {npc:260148} Scourge Reanimator · {area:16848} Elderwild
	["Burn the bone pile at the south-eastern end of {area:16868} with the {item:274411}: the {npc:260148} that answers carries the amulet. The hand-in waits for the ride back to {area:16848} at the end of this guide.\nCareful: the {npc:260148} is level 59-60: burn the bone pile last, at full health, with the ruins around it cleared."] = "Quema la pila de huesos en el extremo sureste de {area:16868} con el {item:274411}: el {npc:260148} que responde lleva el amuleto. La entrega espera al paseo de vuelta a {area:16848} al final de esta guía.\nОсторожно: el {npc:260148} es de nivel 59-60: quema la pila de huesos al final, con la salud llena y las ruinas alrededor limpias.",

	-- Step 102: Final Death
	-- {npc:260148} Scourge Reanimator · {area:16848} Elderwild
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised. The hand-in waits for the ride back to {area:16848} at the end of this guide."] = "Una opción de grupo por debajo del nivel 58: el {npc:260148} que responde a la pila de huesos quemada es de nivel 59-60. Se recomienda ir en grupo. La entrega espera al paseo de vuelta a {area:16848} al final de esta guía.",

	-- Step 103: Final Death
	-- {npc:260148} Scourge Reanimator · {npc:244511} Zet'gan · {area:16848} Elderwild
	["A group choice below level 58: the {npc:260148} that answers the burnt bone pile is level 59-60. Grouping up is advised. {npc:244511} takes the amulet on the ride back to {area:16848} at the end of this guide."] = "Una opción de grupo por debajo del nivel 58: el {npc:260148} que responde a la pila de huesos quemada es de nivel 59-60. Se recomienda ir en grupo. {npc:244511} recoge el amuleto en el paseo de vuelta a {area:16848} al final de esta guía.",

	-- Step 105: Whisperfur
	["Whisperfur"] = "Susurpelo",
	-- {area:16868} Mourning's Rest
	["The last kitten, Whisperfur, plays at the southern end of {area:16868}."] = "La última gatita, Susurpelo, juega en el extremo sur de {area:16868}.",

	-- Step 106: Shalla'kal and Galvinquam Leafsyre
	-- {npc:255683} Shalla'kal · {npc:267109} Galvinquam Leafsyre
	["North to {npc:255683}, then {npc:267109} in the ruins south of her."] = "Al norte, hacia {npc:255683}, y luego {npc:267109} en las ruinas al sur de ella.",

	-- Step 107: Corrupted Growth
	-- {area:16867} Shrine of Aviana · {npc:260825} Phoebe Highfeather
	["East from the Cradle towards the {area:16867}, where the Wormwing harpies nest: a corrupted growth on the shrine's western slope starts a quest for {npc:260825}."] = "Al este, desde la Cuna, hacia {area:16867}, donde anidan las harpías de Ala Gusano: un crecimiento corrupto en la ladera oeste del altar inicia una misión para {npc:260825}.",
	["remove the corrupted knots on the trees just north-west of the shrine, on your way"] = "quita los nudos corruptos de los árboles al noroeste del altar, en el camino",

	-- Step 108: Skylord Omnuron
	-- {npc:254131} Skylord Omnuron · {npc:260825} Phoebe Highfeather · {area:16867} Shrine of Aviana
	["{npc:254131} and {npc:260825} stand together at the {area:16867}."] = "{npc:254131} y {npc:260825} están juntos en {area:16867}.",
	-- {quest:92500} A Bit of the Sky · {npc:256222} Ketharas
	["{quest:92500}: for {npc:256222}, later in this guide"] = "{quest:92500}: para {npc:256222}, más tarde en esta guía",

	-- Step 110: The Shrine of Aviana
	-- {area:16867} Shrine of Aviana
	["The {area:16867}"] = "El {area:16867}",

	-- Step 111: The harpy grounds
	["The harpy grounds"] = "Las tierras de las harpías",
	-- {npc:256660} Thobon Sapclaw · {object:650219} Jewel of the Horizon (no name in this language: may be words) · {npc:260826} Zarrat Wormwing
	["The Wormwing harpies nest on the slopes north-west of the shrine. They drop the pinfeathers and {npc:256660}'s amulets; the bangles lie in their nests, the {object:650219} in a nest on the western slope, and {npc:260826}, who has Omnuron's spear, is among them. The corrupted knots grow on the trees just north-west of the shrine."] = "Las harpías de Ala Gusano anidan en las laderas al noroeste del altar. Sueltan las plumas de cubierta y los amuletos de {npc:256660}; los brazaletes están en sus nidos, el {object:650219} en un nido de la ladera oeste, y {npc:260826}, que lleva la lanza de Omnuron, está entre ellas. Los nudos corruptos crecen en los árboles al noroeste del altar.",

	-- Step 113: The Deadwood camps
	["The Deadwood camps"] = "Los campamentos del Bosque Muerto",
	-- {quest:92446} Head Scratcher
	["South-west back towards Barkskin Burrow: the Deadwood camps on the slopes east of the burrow hold the Totemics and Fel-Tenders. An elite named {quest:92446} (level 60) may roam the camps' eastern end."] = "Al suroeste, de vuelta hacia la Guarida de Corteza: los campamentos del Bosque Muerto en las laderas al este de la guarida albergan a los Tótems y a los Cuidadores de la Corrupción. Un élite llamado {quest:92446} (nivel 60) puede rondar el extremo este de los campamentos.",

	-- Step 114: Head Scratcher
	-- {quest:92446} Head Scratcher · {npc:244511} Zet'gan
	["{quest:92446} is elite (level 60 in our data): grouping up is advised. Put {npc:244511}'s rabbit carcass down in the woods at the camps' eastern end, where the Horde players in our recordings fought him, and take his claws."] = "{quest:92446} es de élite (nivel 60 en nuestros datos): se recomienda ir en grupo. Deja el cadáver de conejo de {npc:244511} en el bosque, en el extremo este de los campamentos, donde los jugadores de la Horda en nuestras grabaciones lo combatieron, y toma sus garras.",

	-- Step 115: Barkskin Burrow
	-- {npc:260661} Suma Mossmane · {npc:256660} Thobon Sapclaw
	["Into the burrow for the elders, {npc:260661} and {npc:256660}."] = "A la guarida, por los ancianos, {npc:260661} y {npc:256660}.",

	-- Step 116: Galvinquam Leafsyre
	-- {area:17145} Cradle of Tranquility · {npc:267109} Galvinquam Leafsyre · {npc:255683} Shalla'kal
	["North-east into the {area:17145}: {npc:267109} rests in the ruins south of {npc:255683}, on your way."] = "Al noreste, hacia {area:17145}: {npc:267109} descansa en las ruinas al sur de {npc:255683}, en el camino.",
	-- {quest:96991} Trail Assist · {npc:264795} Marn Euhorn · {area:16849} Summit of Eternity
	["{quest:96991}: for {npc:264795} at the {area:16849}, later in this guide"] = "{quest:96991}: para {npc:264795} en {area:16849}, más tarde en esta guía",

	-- Step 117: Jereman
	-- {npc:267158} Jereman
	["On to the old bridge over the Cradle: touch the crow effigy on it and {npc:267158} appears again."] = "Hacia el viejo puente sobre la Cuna: toca el ídolo del cuervo en él y {npc:267158} aparece de nuevo.",
	-- {quest:96964} A Clever Creature · {npc:259695} Renalard · {area:16866} Dae'gun
	["{quest:96964}: for {npc:259695} in {area:16866}, just ahead"] = "{quest:96964}: para {npc:259695} en {area:16866}, justo delante",

	-- Step 118: Johun "Punchy" Dillas
	-- {npc:249234} Johun "Punchy" Dillas · {area:16866} Dae'gun
	["North-east across the Cradle to {npc:249234}'s camp at the edge of {area:16866}."] = "Al noreste, por la Cuna, hasta el campamento de {npc:249234} en el borde de {area:16866}.",

	-- Step 119: Elaena Moonwhisper, Witherbeard and Yashiro
	-- {npc:263406} Elaena Moonwhisper · {npc:249052} Witherbeard · {npc:267121} Yashiro
	["{npc:263406}, {npc:249052} and {npc:267121}"] = "{npc:263406}, {npc:249052} y {npc:267121}",
	-- {area:16866} Dae'gun · {npc:263406} Elaena Moonwhisper · {npc:249052} Witherbeard · {npc:267121} Yashiro
	["Into {area:16866}, north of the Cradle: the ruins of a Horde base, now held by demons. {npc:263406} and {npc:249052} camp at its western edge; {npc:267121}, a blademaster, waits a little east of them. Doomguards (elites, levels 58-59) walk among the demons: pull carefully."] = "A {area:16866}, al norte de la Cuna: las ruinas de una base de la Horda, ahora ocupadas por demonios. {npc:263406} y {npc:249052} acampan en su borde oeste; {npc:267121}, un maestro de espada, espera un poco al este de ellos. Los guardias del Apocalipsis (élites, niveles 58-59) caminan entre los demonios: saca con cuidado.",

	-- Step 120: Renalard
	-- {area:16866} Dae'gun · {npc:259695} Renalard
	["South-east across {area:16866} to {npc:259695}, the wild god, indoors at its south-eastern edge."] = "Al sureste, por {area:16866}, hacia {npc:259695}, el dios salvaje, bajo techo en su borde sureste.",
	-- {quest:92335} Ashes of the Legion Ascent · {npc:256222} Ketharas
	["{quest:92335}: for {npc:256222}, later in this guide"] = "{quest:92335}: para {npc:256222}, más tarde en esta guía",

	-- Step 121: Dae'gun
	-- {area:16866} Dae'gun · {npc:259695} Renalard · {npc:265788} Kal'tinzan · {item:253249} Horde Flag · {object:656786} Troll Remains (no name in this language: may be words) · {quest:96998} Tribal Colors · {npc:267439} Doomguard Xarkul
	-- plural, as words: Felguard Sentinels = {npc:249229} Felguard Sentinel · Defiling Hounds = {npc:249230} Defiling Hound · Legion Hulks = {npc:249238} Legion Hulk
	["Work west back through {area:16866}: the Felguard Sentinels and Defiling Hounds are everywhere, the hounds carry the essence, and the Horde base's rubble (wire, scrap and dung) lies all over it. Light the two bonfires on your way, scout the Horde tower in the middle, take Azgalor's ashes west of the tower, and pick up the abandoned supplies, a few just north-west of {npc:259695} and the rest in the western half: {npc:259695}'s tuft of fur, used on a demon, distracts it while you take them.\nHorde: the demons here also drop the Scraps of Horde Heraldry for {npc:265788}, the old {item:253249} stands in the camp north of the south bonfire, and the {object:656786} at the camp's eastern edge start {quest:96998}.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps: give them room.\nCareful: Doomguards (elites, 58-59) stand among the demons, and {npc:267439} (elite, 61) walks the camp: pull the hounds and sentinels to you, away from them."] = "Trabaja al oeste, de vuelta por {area:16866}: los centinelas Guardia Vil y los perros Profanadores están por todas partes, los perros llevan la esencia, y los escombros de la base de la Horda (alambre, chatarra y estiércol) están por todo el lugar. Enciende los dos fuegos en el camino, reconoce la torre de la Horda en medio, toma las cenizas de Azgalor al oeste de la torre, y recoge los suministros abandonados, unos pocos al noroeste de {npc:259695} y el resto en la mitad oeste: el mechón de pelo de {npc:259695}, usado sobre un demonio, lo distrae mientras los tomas.\nHorda: los demonios de aquí también sueltan los Retazos de Heráldica de la Horda para {npc:265788}, el viejo {item:253249} está en el campamento al norte del fuego del sur, y el {object:656786} en el borde este del campamento inician {quest:96998}.\nОсторожно: los Golems de la Legión (60, élites raros) pisotean los campamentos de {area:16866}: dales espacio.\nОсторожно: los guardias del Apocalipsis (élites, 58-59) están entre los demonios, y {npc:267439} (élite, 61) camina por el campamento: atrae a los perros y a los centinelas hacia ti, lejos de ellos.",
	["Southeast Bonfire"] = "Fuego del sureste",
	["South Bonfire"] = "Fuego del sur",
	["scout the Horde tower"] = "reconoce la torre de la Horda",
	-- {object:656786} Troll Remains (no name in this language: may be words) · {quest:96998} Tribal Colors · {npc:244511} Zet'gan · {area:16848} Elderwild
	["{object:656786}: {quest:96998}, for {npc:244511} in {area:16848}; keep it"] = "{object:656786}: {quest:96998}, para {npc:244511} en {area:16848}; guárdalo",

	-- Step 123: Drawing Down the Malevolent
	-- {npc:263394} Bethra'zel the Feeble · {npc:252457} Mazzogore · {npc:263406} Elaena Moonwhisper
	["A group choice: {npc:263394} and {npc:252457} are level 60 elites until {npc:263406}'s eye drains them. Drain each one first, then fight it; players in our recordings killed both once drained. Grouping up is advised."] = "Una opción de grupo: {npc:263394} y {npc:252457} son élites de nivel 60 hasta que el ojo de {npc:263406} los drena. Drena a cada uno primero, y luego lucha contra él; los jugadores en nuestras grabaciones mataron a ambos una vez drenados. Se recomienda ir en grupo.",

	-- Step 125: Bethra'zel the Feeble
	-- {npc:263394} Bethra'zel the Feeble · {npc:263406} Elaena Moonwhisper · {npc:252457} Mazzogore · {npc:267439} Doomguard Xarkul · {area:16866} Dae'gun
	-- plural, as words: Legion Hulks = {npc:249238} Legion Hulk
	["North-east to {npc:263394}. Drain him first: use {npc:263406}'s eye on him, and only then fight him. Undrained, he and {npc:252457} are level 60 elites. {npc:267439}, an elite (level 61), walks this corner of {area:16866}: keep out of his way.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps: give them room."] = "Al noreste, hacia {npc:263394}. Drena primero: usa el ojo de {npc:263406} sobre él, y solo entonces lucha contra él. Sin drenar, él y {npc:252457} son élites de nivel 60. {npc:267439}, un élite (nivel 61), camina por esta esquina de {area:16866}: mantente lejos de él.\nОсторожно: los Golems de la Legión (60, élites raros) pisotean los campamentos de {area:16866}: dales espacio.",

	-- Step 126: Maerion Thaelemaches
	-- {npc:267097} Maerion Thaelemaches · {area:16866} Dae'gun · {npc:263394} Bethra'zel the Feeble · {npc:267439} Doomguard Xarkul
	-- plural, as words: Felhound Spikes = {item:276100} Felhound Spike · Defiling Hounds = {npc:249230} Defiling Hound · Legion Hulks = {npc:249238} Legion Hulk
	["North-east to {npc:267097}, in the corner of {area:16866} where {npc:263394} stands. His Felhound Spikes come from the Defiling Hounds, and in the first recording about one hound in ten had one: kill the hounds around him while you are here, and leave his quest if the twelve spikes are slow to come.\nCareful: Legion Hulks (60, rare elites) stomp through {area:16866}'s camps, and {npc:267439}, an elite (level 61), walks this corner: give them room."] = "Al noreste, hacia {npc:267097}, en la esquina de {area:16866} donde está {npc:263394}. Sus púas de perro vil salen de los perros Profanadores, y en la primera grabación uno de cada diez perros las tenía: mata a los perros a su alrededor mientras estás aquí, y deja su misión si las doce púas tardan en salir.\nОсторожно: los Golems de la Legión (60, élites raros) pisotean los campamentos de {area:16866}, y {npc:267439}, un élite (nivel 61), camina por esta esquina: dales espacio.",

	-- Step 127: Mazzogore
	-- {npc:263426} Mazzogore the Weak · {area:16866} Dae'gun · {npc:263394} Bethra'zel the Feeble
	["South-west to {npc:263426}, in the middle of {area:16866}: drain him with the eye first, as {npc:263394}, then kill him. Undrained, he is a level 60 elite.\nCareful: Doomguards (elites, 58-59) stand around him: pull him out to you."] = "Al suroeste, hacia {npc:263426}, en medio de {area:16866}: drena primero con el ojo, como a {npc:263394}, y luego mátalo. Sin drenar, es un élite de nivel 60.\nОсторожно: los guardias del Apocalipsis (élites, 58-59) están a su alrededor: sácalo hacia ti.",

	-- Step 128: Elaena Moonwhisper
	-- {quest:96025} As the Crow Flies · {npc:254915} Thisalee Crow
	["{quest:96025}: for {npc:254915} at the Summit"] = "{quest:96025}: para {npc:254915} en la Cima",

	-- Step 129: Renalard
	-- {npc:259695} Renalard
	["South-east to {npc:259695}."] = "Al sureste, hacia {npc:259695}.",

	-- Step 130: The Summit of Eternity
	-- {area:16849} Summit of Eternity
	["The {area:16849}"] = "El {area:16849}",
	-- {area:16849} Summit of Eternity · {npc:41861} Fayran Elthas · {npc:264795} Marn Euhorn · {npc:243855} Toron Rockhoof · {npc:254915} Thisalee Crow · {npc:40833} Tiala Whitemane · {npc:243815} Sebelia
	["East up to the {area:16849}, the druids' camp. {npc:41861}, the flight master, stands at its north end; {npc:264795}, {npc:243855} and {npc:254915} along the path south; {npc:40833} indoors next to Thisalee; {npc:243815}, the innkeeper, at the south-east end."] = "Al este, subiendo, al {area:16849}, el campamento de los druidas. {npc:41861}, el maestro de vuelo, está en su extremo norte; {npc:264795}, {npc:243855} y {npc:254915} junto al camino del sur; {npc:40833} en el interior, junto a Thisalee; {npc:243815}, el tabernero, en el extremo sureste.",
	-- {npc:41861} Fayran Elthas
	["{npc:41861}, at the flight point"] = "{npc:41861}, en el punto de vuelo",
	-- {npc:243815} Sebelia · {quest:93197} Mending Communications · {npc:11118} Innkeeper Vizzie · {area:2255} Everlook
	["{npc:243815}: {quest:93197}: for {npc:11118} in {area:2255}, at the end"] = "{npc:243815}: {quest:93197}: para {npc:11118} en {area:2255}, al final",

	-- Step 132: As the Crow Flies
	-- {npc:254915} Thisalee Crow · {npc:263406} Elaena Moonwhisper
	["{npc:254915}, at the Summit, for {npc:263406}'s message."] = "{npc:254915}, en la Cima, para el mensaje de {npc:263406}.",

	-- Step 133: The Summit's Blackthorne quests
	["The Summit's Blackthorne quests"] = "Las misiones de Blackthorne en la Cima",
	-- {npc:260674} Ve'han Talongrasp
	["A group stop: the Blackthorne camps north-east of the Summit hold elite Outrunners, Priests and a Courier (60) as often as the Cultists and Adepts, with {npc:260674} (60, elite) in the middle and Ghansurok (61, elite) on the ridge. Grouping up is encouraged, look for people to do it with. Skip these if you are alone."] = "Una parada de grupo: los campamentos Blackthorne al noreste de la Cima albergan Exprimidores, Sacerdotes y un Mensajero (60) tan a menudo como a los Cultistas y los Adpetos, con {npc:260674} (60, élite) en medio y Ghansurok (61, élite) en la cresta. Se recomienda ir en grupo, busca gente con quien hacerlo. Sáltatelos si estás solo.",

	-- Step 134: Fly to the Tainted Foothills
	-- {npc:260626} Bluebell · {npc:249235} Kaylaena Springwhisper · {npc:256222} Ketharas
	["Fly down to {npc:260626} for {npc:249235} and {npc:256222}."] = "Vuela abajo, hacia {npc:260626}, por {npc:249235} y {npc:256222}.",

	-- Step 135: Kaylaena Springwhisper's workshop
	["North to the workshop. Turn the two gears and connect the two battery terminals on both sides of her glaive thrower. Ghansurok, the elite chimaera (level 61), prowls around the workshop: watch for him while you work."] = "Al norte, hacia el taller. Gira los dos engranajes y conecta las dos terminales de la batería a ambos lados de su lanzaglivas. Ghansurok, la quimera de élite (nivel 61), ronda el taller: vigílalo mientras trabajas.",

	-- Step 136: Ketharas
	["South-east to the Hermit's Abode with what the wild gods and Omnuron gave you."] = "Al sureste, al Refugio del Ermitaño, con lo que te dieron los dioses salvajes y Omnuron.",

	-- Step 140: Final Death, still not done
	-- {quest:92591} Final Death
	["{quest:92591}, still not done"] = "{quest:92591}, aún sin terminar",
	-- {area:16868} Mourning's Rest · {quest:92591} Final Death
	["Still under 58 after the second pass through {area:16868}? Abandon {quest:92591}: the route doesn't come back for it."] = "¿Sigue por debajo de 58 después de la segunda pasada por {area:16868}? Abandona {quest:92591}: la ruta no vuelve a por ella.",

	-- Step 141: Final Death, still not done
	-- {quest:92592} Final Death
	["{quest:92592}, still not done"] = "{quest:92592}, aún sin terminar",
	-- {area:16868} Mourning's Rest · {quest:92592} Final Death
	["Still under 58 after the second pass through {area:16868}? Abandon {quest:92592}: the route doesn't come back for it."] = "¿Sigue por debajo de 58 después de la segunda pasada por {area:16868}? Abandona {quest:92592}: la ruta no vuelve a por ella.",

	-- Step 142: Back to Elderwild
	-- {area:16848} Elderwild
	["Back to {area:16848}"] = "De vuelta a {area:16848}",
	-- {area:16848} Elderwild · {npc:265788} Kal'tinzan · {npc:244511} Zet'gan
	["Horde: ride west across the foothills and north up the valley to {area:16848}, about four minutes, for {npc:265788}'s flags, {npc:244511}'s amulet and his war paint wrap, then back up to the Summit."] = "Horda: cabalga al oeste por las estribaciones y al norte por el valle hasta {area:16848}, unos cuatro minutos, por las banderas de {npc:265788}, el amuleto de {npc:244511} y su venda de pintura de guerra, y luego de vuelta a la Cima.",
	-- {npc:244511} Zet'gan · {quest:96999} Wrap Return · {npc:3187} Tai'tasi · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:244511}: {quest:96999}, for {npc:3187} in {area:367}, {zone:1411}; take it only if you'll pass by"] = "{npc:244511}: {quest:96999}, para {npc:3187} en {area:367}, {zone:1411}; tómala solo si vas a pasar por ahí",

	-- Step 143: Back to Elderwild
	-- {npc:244517} Sefira Everbright · {area:16848} Elderwild
	["Alliance: the amulet from the second pass goes to {npc:244517}: ride west across the foothills and north up the valley to {area:16848}, about four minutes, then back up to the Summit."] = "Alianza: el amuleto de la segunda pasada va para {npc:244517}: cabalga al oeste por las estribaciones y al norte por el valle hasta {area:16848}, unos cuatro minutos, y luego de vuelta a la Cima.",

	-- Step 145: To the Summit of Eternity
	-- {npc:244517} Sefira Everbright · {npc:254915} Thisalee Crow
	["{npc:244517}: for {npc:254915} at the Summit, next"] = "{npc:244517}: para {npc:254915} en la Cima, siguiente",

	-- Step 146: To the Summit of Eternity
	-- {npc:244511} Zet'gan · {npc:254915} Thisalee Crow
	["{npc:244511}: for {npc:254915} at the Summit, next"] = "{npc:244511}: para {npc:254915} en la Cima, siguiente",

	-- Step 147: Zet'gan
	-- {quest:92446} Head Scratcher
	["{quest:92446}'s claws"] = "las garras de {quest:92446}",

	-- Step 148: Up to the Summit of Eternity
	-- {area:16849} Summit of Eternity
	["Up to the {area:16849}"] = "Subir al {area:16849}",
	-- {area:16849} Summit of Eternity · {npc:260626} Bluebell
	["Back up to the {area:16849}: {npc:260626}, at the ancients' outpost, flies there, and your Hearthstone is bound there."] = "De vuelta al {area:16849}: {npc:260626}, en el puesto de los ancianos, vuela hasta ahí, y tu Piedra de hogar está vinculada ahí.",

	-- Step 149: Tiala Whitemane
	-- {npc:254915} Thisalee Crow
	["Indoors at the Summit, next to {npc:254915}."] = "En el interior de la Cima, junto a {npc:254915}.",

	-- Step 150: Thisalee Crow
	-- {npc:254915} Thisalee Crow · {npc:40833} Tiala Whitemane
	["{npc:254915}, next to {npc:40833} at the Summit."] = "{npc:254915}, junto a {npc:40833} en la Cima.",

	-- Step 152: The Blackthorne camps
	["The Blackthorne camps"] = "Los campamentos Blackthorne",
	-- {npc:260674} Ve'han Talongrasp · {npc:40833} Tiala Whitemane
	["The Blackthorne cultists camp on the slopes north-east of the Summit (level 60, with elite Outrunners, Priests and a Courier among them: pull carefully). {npc:260674}, an elite (level 60) who leads them, stands among them: leave him be. Ghansurok, an elite chimaera (level 61), also roams the ridge north of the camps.\nUse {npc:40833}'s staff on a Pact member to strip its ward, then kill it, ten times: pick Cultists and Adepts, whom Thisalee wants dead too. The Cultists carry the kris and the Adepts the staff; the thorn seeds lie in the woods there, and the hippogryphs and chimaeras roam the slopes all around. Not finished in our recordings yet: if something here is off, tell us."] = "Los cultistas Blackthorne acampan en las laderas al noreste de la Cima (nivel 60, con Exprimidores, Sacerdotes y un Mensajero de élite entre ellos: saca con cuidado). {npc:260674}, un élite (nivel 60) que los lidera, está entre ellos: déjalo en paz. Ghansurok, una quimera de élite (nivel 61), también ronda la cresta al norte de los campamentos.\nUsa el bastón de {npc:40833} sobre un miembro del Pacto para quitarle su guardia, y luego mátalo, diez veces: elige Cultistas y Adpetos, que Thisalee también quiere muertos. Los Cultistas llevan la kris y los Adpetos el bastón; las semillas de espino están en el bosque de ahí, y los hipogrifos y las quimeras rondan las laderas alrededor. Aún sin terminar en nuestras grabaciones: si algo aquí falla, dínoslo.",

	-- Step 153: The Blackthorne camps
	-- {npc:260674} Ve'han Talongrasp
	["The Blackthorne cultists camp on the slopes north-east of the Summit (level 60, with elite Outrunners, Priests and a Courier among them: pull carefully). {npc:260674}, an elite (level 60) who leads them, stands among them: leave him be. Ghansurok, an elite chimaera (level 61), also roams the ridge north of the camps.\nThe Cultists carry the kris and the Adepts the staff; the thorn seeds lie in the woods there, and the hippogryphs and chimaeras roam the slopes all around. Not finished in our recordings yet: if something here is off, tell us."] = "Los cultistas Blackthorne acampan en las laderas al noreste de la Cima (nivel 60, con Exprimidores, Sacerdotes y un Mensajero de élite entre ellos: saca con cuidado). {npc:260674}, un élite (nivel 60) que los lidera, está entre ellos: déjalo en paz. Ghansurok, una quimera de élite (nivel 61), también ronda la cresta al norte de los campamentos.\nLos Cultistas llevan la kris y los Adpetos el bastón; las semillas de espino están en el bosque de ahí, y los hipogrifos y las quimeras rondan las laderas alrededor. Aún sin terminar en nuestras grabaciones: si algo aquí falla, dínoslo.",

	-- Step 156: Fly to Everlook
	-- {npc:41861} Fayran Elthas · {area:2255} Everlook
	["{npc:41861} flies you to {area:2255}."] = "{npc:41861} te vuela a {area:2255}.",

	-- Step 157: Innkeeper Vizzie
	-- {npc:11118} Innkeeper Vizzie · {area:2255} Everlook · {zone:1452} Winterspring
	["{npc:11118} is in {area:2255}'s inn. She has more mail for you in {zone:1452}, outside this guide."] = "{npc:11118} está en la posada de {area:2255}. Tiene más correo para ti en {zone:1452}, fuera de esta guía.",
}
