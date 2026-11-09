-- Spanish (Latin America) (esMX): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Crossroads
	["Fly to Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 2: The road west
	["The road west"] = "",
	["The road west past Seereth's camp"] = "",

	-- Step 3: Malaka'jin
	-- {npc:3995} Witch Doctor Jin'Zil · {area:2539} Malaka'jin · {area:1076} Webwinder Path
	["Follow the road west past Regthar's bunkers and Seereth's camp into Stonetalon: {npc:3995} waits below ground in {area:2539}, at the foot of the {area:1076}."] = "",
	-- {npc:3995} Witch Doctor Jin'Zil
	["{npc:3995}, below ground"] = "",

	-- Step 4: Sun Rock Retreat
	-- {area:1076} Webwinder Path · {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["Up the {area:1076} past {npc:4201} and west to {area:460}."] = "",
	-- {npc:11862} Tsunaman · {npc:12736} Je'neu Sancrea
	["{npc:11862}: {npc:12736} at Zoram'gar, next guide"] = "",
	-- {npc:11860} Maggran Earthbinder · {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["{npc:11860}: {npc:12576} is at the {area:1718}, later in this guide"] = "",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: piedrasoles relumbrantes de las arpías Furia Sangrienta",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, fuera de la puerta",

	-- Step 5: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Semillas de Gaia",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "",

	-- Step 6: Stonetalon Mountains: kill these as you meet them
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442}: kill these as you meet them"] = "",
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Sigue el camino al norte hacia {area:467}. Los trotadores cornamentados pastan por el camino; las bestias de savia, los corredores Crepusculares y los dragones hada deambulan por el bosque bajo el Pico, y los druidas Cenarion ocupan la arboleda de allí.",

	-- Step 7: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "La siguiente misión de {npc:4198}, Ordanus, está en el lado de la Alianza de {zone:1440}. Omítela.",

	-- Step 8: The Charred Vale: kill these as you meet them
	-- {area:465} The Charred Vale
	["{area:465}: kill these as you meet them"] = "",
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Al suroeste del Refugio Roca del Sol está {area:465}, quemada. Planta las semillas de Gaia ({item:16205}) en los montones de tierra del fondo del valle; los elementales de fuego sueltan {item:16312}. Las arpías y emboscadoras Furia Sangrienta anidan en el lado norte; las destripadoras y malaplumas, al sur.",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, de cualquier arpía Furia Sangrienta",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Túmulos de Gaia",

	-- Step 9: Sun Rock Retreat
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, junto a {npc:11862}",
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, arriba en la cornisa",

	-- Step 10: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Head back down the {area:1076} to {area:2539}."] = "",

	-- Step 11: To Camp Taurajo
	-- {area:378} Camp Taurajo
	["To {area:378}"] = "",

	-- Step 12: Camp Taurajo
	-- {area:2539} Malaka'jin · {area:378} Camp Taurajo
	["From {area:2539} follow the road east to Seereth's camp, then south-east across the plains to {area:378}."] = "",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, en el borde norte del campamento",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, en la jaula",

	-- Step 13: Grunt Logmar
	-- {npc:5911} Grunt Logmar · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["{npc:5911} stands by the flight master. His {npc:268623} (23) is elite: grouping up is advised; the two Encroaching Soldiers are not."] = "",
	-- {npc:5911} Grunt Logmar · {npc:3341} Gann Stonespire
	["{npc:5911}: the soldiers and the pillager camp just east of {npc:3341}, on the way south"] = "",

	-- Step 15: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "La choza de {npc:5899} está en la cresta sobre el abrevadero de los jabaespines, al sur de {area:378}, camino a {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: el odre rojo de {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: el odre azul se llena en {zone:1440}, en la siguiente guía",

	-- Step 16: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan · {npc:14242} Sulhasa
	["{npc:3341} walks the road south toward {area:359}, between about 46,75 and 46,81: if he isn't at the arrow, follow the road until you meet him. {npc:14242} sits up in the tree just east of the road at 47.9,77.5."] = "",
	-- {npc:3341} Gann Stonespire · {area:1701} Blackthorn Ridge
	["{npc:3341} walks around {area:1701}: look inside the circle on the map"] = "",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, arriba en el árbol justo al este de {npc:3341}",

	-- Step 17: Wrongly Blamed, Justly Corrected
	-- {npc:14242} Sulhasa · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["A few steps east of {npc:14242}'s tree, a small camp: two Encroaching Soldiers and the {npc:268623} for Logmar. The {npc:268623} is elite: grouping up is advised."] = "",

	-- Step 18: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone.\nCareful: Excavators (level 21-22) and Foremen (level 22-23) run off for help once they fall to 15% health, so more dwarves can join the fight."] = "",
	-- {npc:3375} Bael'dun Foreman · {area:359} Bael Modan
	["{npc:3375} walks around {area:359}: look inside the circle on the map"] = "",

	-- Step 19: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {quest:885} Washte Pawne · {spell:1752} Sinister Strike
	-- plural, as words: Razormane Stalkers = {npc:3457} Razormane Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "",

	-- Step 20: Field to Clear
	-- {npc:3341} Gann Stonespire · {npc:3238} Stormhide
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["On the way back east to {npc:3341}: Hecklefang Stalkers and {npc:3238} lizards roam the plain between the ridge and his camp."] = "",
	-- {npc:4128} Hecklefang Stalker · {area:1156} Southern Barrens
	["{npc:4128} walks around {area:1156}: look inside the circle on the map"] = "",

	-- Step 22: Bael'dun fortress
	["Bael'dun fortress"] = "Fortaleza de Bael'dun",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them.\nCareful: Riflemen (level 24-25) Shoot from 5-30 yd, so nearby ones can join a fight from range."] = "",

	-- Step 24: The flying machine
	["The flying machine"] = "La máquina voladora",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "La máquina voladora de los enanos está en su plataforma dentro de la excavación.",

	-- Step 26: Great Lift
	-- {area:1718} Great Lift
	["The top of the {area:1718}"] = "",

	-- Step 27: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "",

	-- Step 28: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "{area:1718}",
	-- {npc:10079} Brave Moonhorn · {area:1718} Great Lift · {npc:12576} Grish Longrunner
	["{npc:10079} stands at the top of the {area:1718}, beside {npc:12576}."] = "",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, en lo alto del elevador",

	-- Step 31: Grunt Logmar
	-- {npc:5911} Grunt Logmar
	["{npc:5911}, beside the flight master"] = "",

	-- Step 32: Fly to Crossroads
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "",

	-- Step 33: The Crossroads
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, en lo alto de la torre",

	-- Step 34: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",
	["Crossroads flight master"] = "",

	-- Step 35: Merchant Coast
	-- {quest:874} Mahren Skyseer · {area:392} Ratchet
	["{quest:874} camps on the shore just north of {area:392}'s flight master."] = "",

	-- Step 36: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, un gran trillanodonte, nada en las aguas poco profundas frente a {area:391}, al este de {npc:3388}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Ayuda a {npc:261366}: quédate a su lado cuando {npc:261367} y los marines de {area:21} suban por la loma",
	-- ["Back to the {area:380}"] = "De vuelta a {area:380}",
	-- ["Bristleback camps"] = "Campamentos Lomopelo",
	-- ["Bruuz"] = "Bruuz",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Lanza {spell:18960}. Taurens: unan las dos mitades del colgante en {area:2362}, en la orilla noroeste del lago, antes de ver a {npc:11802} en {area:2361}.",
	-- ["Dogran is chained up in the quilboar camp west of the road."] = "Dogran está encadenado en el campamento de jabaespines al oeste del camino.",
	-- ["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Doras, el maestro de jinetes del viento, está en la torre de {object:172982}.",
	-- ["Down the {area:458} to {area:378} again."] = "Baja otra vez por {area:458} hasta {area:378}.",
	-- ["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Al este a través de las llanuras hacia la costa: la plata robada está en un nido de raptores al noroeste de {area:385}.",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "Al este, hasta {area:382}. {npc:3439} está dentro del campamento de Ventura y Cía.; {npc:3445} lleva la llave.",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "Llena {item:7766} en el abrevadero de los jabaespines",
	-- ["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Fizzule dirige el campamento de Ventura y Cía. en el extremo este de {area:382}. Ataca a los desconocidos: selecciónalo y haz /salute antes de que lo haga.",
	-- ["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Vuela de vuelta a {area:380}. La siguiente guía empieza aquí y toma el camino al norte hacia {area:1703} y {zone:1440}.",
	-- ["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Vuela a {area:1637} para entrenar tus rangos de nivel 20. {npc:3354} está en {object:172958}; {npc:5892}, en {object:172957}.",
	-- ["Fly to {area:1637} to train."] = "Vuela a {area:1637} para entrenar.",
	-- ["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Vuela a {area:1638} y entrena tus rangos de nivel 20: {npc:3033} está en {area:1639}.",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Vuela a {area:1638} para entrenar: {npc:3033} está en {area:1639}.",
	-- ["Follow the {area:458} south to {area:378}."] = "Sigue {area:458} hacia el sur hasta {area:378}.",
	-- ["He gives you the {item:15826}"] = "Te da {item:15826}",
	-- ["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Después ofrece {quest:1838} (1838, nivel 30): requiere {area:1717} y te envía por todo Kalimdor y los Reinos del Este. La guía de clase de guerrero {quest:1838} la cubre.",
	-- ["Hearth to the {area:380}"] = "Usa la piedra de hogar para ir a {area:380}",
	-- ["Keep it: the {object:107045} is beside {area:272}"] = "Guárdala: {object:107045} está junto a {area:272}",
	-- ["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Guárdala: {npc:12696} en {zone:1440}, siguiente guía",
	-- ["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Guárdala: {npc:5875} en {zone:1454}, al final de esta guía",
	-- ["Level 20"] = "Nivel 20",
	-- ["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Al norte, hasta {area:383}. {npc:3682} acampa al pie de las colinas; {npc:261366}, el ermitaño de la loma detrás de él, solo tiene trabajo para ti cuando {npc:3682} te envía arriba.",
	-- ["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "De regreso por {area:458} hacia {area:378}: los Asaltantes Crines de Acero entre los campamentos Lomopelo, a ambos lados del camino al norte del campamento, llevan {item:277277}. Entrégalos a {npc:3432} en tu última parada en {area:380}.",
	-- ["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Cabalga hacia el norte desde {area:380} hasta {area:384} y llena {item:15842} en {object:19464}; luego regresa con {npc:3448} en {area:380}. ¿Sin {skill:182}? {npc:3490}, a su lado, vende {item:2449}, de tres en tres hasta que reabastece.",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Los Patriarcas de la sabana recorren las llanuras al este de las colinas, y las Trampas activadas están entre ellos. {quest:876} dirige a las arpías Alabruja en las colinas del oeste.",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "Al sur de Campamento Taurajo, los Montículos de silítidos ({object:3685}) salpican {area:390}; los huevos están en ellos, y los Enjambristas silítidos ({npc:3252}) salen a defenderlos. Los Cosechadores silítidos ({npc:3253}) son raros: si ves uno, mátalo para obtener su cabeza.",
	-- ["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "Al sur de Gann, los enanos de Bael'dun excavan en {area:359}. Los Excavadores y los Supervisores trabajan en el foso; {npc:3392} (26) lleva el diario: atráelo solo.",
	-- ["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Mantente en sigilo: {npc:7287} lleva la llave de la torre; Gallywix y su cofre están en lo alto. Gallywix es de élite: se recomienda ir en grupo.",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Los Segadores Solescama cazan en las llanuras al sur de {area:380}, alrededor de {area:1697}; sueltan los cuernos. Entrégalos la próxima vez que pases por {area:392}.",
	-- ["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Tauren: {npc:11957} espera en la colina sur, sobre el puente. Cielonatos: {npc:272054} está al sur de los puentes gemelos. Luego, las guaridas al este del lago: sal de tu forma, haz clic en la estatua de la entrada para obtener cinco minutos de sigilo, mantente lejos de los espíritus de adentro y toma una reliquia de cada tipo; {item:280680} está al pie de la estatua del gato blanco.",
	-- ["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Los Soldados, Fusileros y Oficiales Bael'dun defienden la fortaleza en el lado este de la excavación; los tres objetos los sueltan ellos.",
	-- ["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Los campamentos de jabaespines Lomopelo se extienden por las llanuras al norte de {area:378}, a ambos lados de {area:458}. Cada Lomopelo suelta un colmillo; la esposa de {npc:3432} yace en el borde norte. Guarda un {item:5075}. {quest:883}, un kodo gris, a veces deambula por aquí: su pezuña inicia una misión.",
	-- ["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Los Sobrestantes y los Déspotas de Ventura y Cía. de la mina en la esquina noreste de la zona sueltan {item:5097}.",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "Las antenas desaparecen quince minutos después de soltarse, así que recógelas ahora, de regreso al norte: mata Enjambristas silítidos y Trepadores silítidos en los montículos de {area:390} hasta tener cinco y luego usa la piedra de hogar para ir a {area:378} de inmediato.",
	-- ["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "Las misiones de clase de nivel 20 en {zone:1454} ({npc:3354}, {npc:5892}, los instructores de brujos y pícaros) solo se ofrecen desde el nivel 20, así que termina el nivel aquí antes de volar. Las Proles de Halcón Trueno (18) de las llanuras al suroeste de {area:380} y los Kolkar (14-15) de {area:388} son los enemigos más cercanos que vale la pena matar; necesitas bastante menos de un nivel.",
	-- ["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Los piratas acampan en la playa al sur de {area:392}; {npc:3467} está en su extremo sur.",
	-- ["The {area:2363}"] = "{area:2363}",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} es el cañón bajo {object:172982}.",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790} está en el borde norte de {area:382}, junto a la torre de Ventura y Cía. Contiene {item:15883} para {quest:30}.",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} está en el borde norte de {area:382}, junto a la torre de Ventura y Cía. Contiene {item:15883} para {quest:30}.",
	-- ["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Los Desechanubes Halcón Trueno sobrevuelan las mismas llanuras al sur del campamento.",
	-- ["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Los Tronatestas pastan en las llanuras justo al sur de {area:378}. {quest:884}, un lagarto del trueno azul, deambula entre ellos: su púa caudal inicia una misión.",
	-- ["Twitching Antennae"] = "Antenas temblorosas",
	-- ["Twitching Antennae from the silithid"] = "Antenas temblorosas de los silítidos",
	-- ["Venture Co. tower"] = "Torre de Ventura y Cía.",
	-- ["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "Al oeste de {npc:3341}, los Crines de Acero ocupan {area:1701}. {npc:3436} está en el lado este, {npc:3434} al sur y {npc:3435} en el extremo oeste. Lok (25) y los Dementes bélicos (24-25) te superan por unos niveles; {npc:5859}, un élite raro, a veces recorre la cresta: déjalo. Los Abrecaminos y los Acechadores sueltan el apuñalador; los Videntes, la varita; los Dementes bélicos, el escudo de guerra. Los lagartos {npc:3238} y los Acechadores Dentecenado recorren la llanura entre Gann y la cresta. {quest:885}, un raro serpiente alada roja, sobrevuela la cresta: su pluma inicia una misión.",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Rabiaire saca su machacador del campamento: quédate con él y mata lo que lo ataque. {npc:3442} la recibe en {area:392}.",
	-- ["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "caza Proles de Halcón Trueno al suroeste de {area:380}",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, en la costa, más al sur. Los Marinos de Theramore y los Presertores de Theramonte (15-16) sueltan las medallas; {npc:3393} (20) y los dos cañoneros (19) están en la fortaleza y en sus murallas, y por ellos el bastión espera hasta ahora.",
	-- ["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: Kodos de Los Baldíos perdidos ({npc:3234}) en las llanuras alrededor del campamento Kolkar",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: usa una mitad en {area:2362}",
	-- ["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} de {npc:3490}; los herboristas la recogen en las llanuras",
	-- ["{item:2449}: herbalists pick it here"] = "{item:2449}: los herboristas la recogen aquí",
	-- ["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798}, en {area:2361}, lleva volando a los druidas ahí",
	-- ["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: la bienvenida de {npc:3033}",
	-- ["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: usa {item:15826} en ellas; recorren las llanuras alrededor de {area:380}",
	-- ["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} nada en el puerto, justo frente a los muelles de {area:392}. {npc:209797} es de élite: se recomienda ir en grupo.",
	-- ["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391}, en {area:272}, enseña Venenos: guárdala",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{npc:2391}, en {area:272}, enseña {spell:2842}: guárdala",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} instruye a los paladines en {area:1638}. Aún no tienes ruta de vuelo ahí: vuela a {area:378}, cabalga hacia el oeste por {zone:1412}, sube por un elevador y consigue la ruta de vuelo de {npc:2995} en la meseta central.",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} y sus marinos defienden la caravana destrozada al sur de {npc:261366}.",
	-- ["{npc:3033}: Cat Form"] = "{npc:3033}: Cat Form",
	-- ["{npc:3033}: Cure Poison"] = "{npc:3033}: Cure Poison",
	-- ["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, en la llanura entre {npc:3341} y la cresta",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} espera en un pequeño campamento más al sur, en el camino hacia {area:359}.",
	-- ["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} está en el puesto de vigilancia de los Kolkar, justo al oeste de {area:380}.",
	-- ["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} está en el campamento Kolkar al noroeste de {npc:3389}.",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} camina entre los Kolkar de {area:388}, al sureste de {area:380}.",
	-- ["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} dirige a los Kolkar en la orilla oeste de {area:387}, al sur de {npc:3389}. Entrega su cabeza a {npc:3389} en tu última parada en {area:380}.",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} está en {object:172960}. Selecciónalo y escribe /salute para terminar {quest:2460}.",
	-- ["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: los huevos están en {area:390}, más adelante",
	-- ["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Guárdala: Kadrak en {area:1703}, siguiente guía",
	-- ["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} ofrece {quest:95774} una vez entregada {quest:4921}",
	-- ["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, junto al maestro de jinetes del viento. Guárdala: {quest:1483} está en Sierra Espolón, más adelante",
	-- ["{npc:3453}, on the dock"] = "{npc:3453}, en el muelle",
	-- ["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} está encadenado dentro del bastión. Habla con él para iniciar la escolta y mantente cerca: los soldados de Theramore atacan en la salida. Te acompaña de vuelta a {area:392}.",
	-- ["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vive en {area:2539}, la aldea trol justo al entrar en Sierra Espolón, al final del camino hacia el oeste desde {npc:3389}.",
	-- ["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} está en {object:172960}. Usa {item:6626} en el círculo de invocación de ahí y derrota a la súcubo para vincularla.",
	-- ["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} acampa junto al camino al este de {area:380}.",
	-- ["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, justo al oeste de {npc:3341}",
	-- ["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} espera en la colina al sur de {area:392}, de camino al norte.",
	-- ["{npc:5909}, a few steps away"] = "{npc:5909}, a unos pasos",
	-- ["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} está en {object:172961}, en el lado oeste de la ciudad.",
	-- ["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} en {zone:1458}, dos guías más adelante",
	-- ["{object:3972} poster"] = "Cartel de {object:3972}",
	-- ["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {npc:7233}, junto a {area:382}",
	-- ["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, un gran raptor Solescama, caza en las llanuras al norte del camino de {area:392} a {area:380}.",
}
