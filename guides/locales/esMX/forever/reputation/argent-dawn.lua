-- Spanish (Latin America) (esMX): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Reputación: El Alba Argenta",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "Piedras de la Plaga, {area:2057} y {area:2279}: los encantamientos de resistencia de hombros y una docena de recetas.",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "Recetas para sastres, peleteros, herreros, encantadores y alquimistas desde Honorable y Reverenciado",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Alianza)",
	-- {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10840} stands in {area:3197}, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10840} está en {area:3197}, en el sur de {zone:1422}. {object:2160} empieza en Neutral 200 para todos. Lleva puesto el abalorio de la Comisión mientras peleas contra la Plaga: las piedras de la Plaga solo caen mientras lo llevas. {npc:11039}, en {area:2268}, da la misma Comisión; solo puedes tomar una.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Horda)",
	-- {npc:10839} Argent Officer Garush · {area:152} Bulwark · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10839} stands at the {area:152}, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10839} está en {area:152}, en el camino de {zone:1420} a {zone:1422}. {object:2160} empieza en Neutral 200 para todos. Lleva puesto el abalorio de la Comisión mientras peleas contra la Plaga: las piedras de la Plaga solo caen mientras lo llevas. {npc:11039}, en {area:2268}, da la misma Comisión; solo puedes tomar una.",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "De Neutral a Amistoso: la Plaga de {zone:1422}",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: {area:199} west of Andorhal (skeletons, 50-53), {area:200} north of Andorhal (zombies and ghouls, 52-55), the {area:202} in the south (ghouls, 54-55) and {area:201} in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at {area:3197} asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "Cada muerte de la Plaga en las Tierras de la Peste da 5 de reputación (los que tienen nombre 15), desde los necrófagos y esqueletos de nivel 50 para arriba; a nivel 60 elige los de nivel 53 o más, porque en Classic los enemigos grises dan solo más o menos un quinto. De Neutral a Amistoso son 2.800: unas 560 muertes, menos con las misiones de las Tierras de la Peste por el camino. La Plaga más densa está alrededor de los cuatro calderos de la Plaga: {area:199} al oeste de Andorhal (esqueletos, 50-53), {area:200} al norte de Andorhal (zombis y necrófagos, 52-55), {area:202} en el sur (necrófagos, 54-55) y {area:201} en el este (fantasmas, 56-57). Guarda cada piedra de la Plaga y cada misión que puedas guardar: las entregas nunca dejan de contar, las muertes sí. Las {quest:5510} las sueltan más o menos cuatro de cada diez de estos enemigos de la Plaga, las de invasor más o menos un tercio de los de nivel 56 o más. Si mueres, quítate la Comisión y vuelve a ponértela: puede perder su efecto. Paladines (humanos y enanos): {npc:10838}, en {area:3197}, pide 20 {quest:5510} una vez para Disipar el mal, 100 de reputación en vez de 25. La ventaja Diplomático del Legado suma hasta un 10% a cada ganancia.",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "{quest:5510}: guárdalas",
	-- {area:201} Gahrron's Withering
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at {area:201}; any Scourge counts"] = "Espectros hambrientos en {area:201}; cualquier Plaga cuenta",
	-- {area:202} Writhing Haunt
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the {area:202}"] = "Necrófagos sin alma en {area:202}",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "Misiones de las Tierras de la Peste y los calderos de la Plaga",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {npc:11055} Shadow Priestess Vandis · {area:152} Bulwark · {npc:1852} Araj the Summoner · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {area:201} Gahrron's Withering · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return, then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "Las misiones de las Tierras de la Peste pagan completo a 60 desde el nivel 55 y nunca dejan de contar, unas 1.500 en total; las guías de nivel las recorren. La cadena de los calderos de {npc:11053} en {area:3197} (Horda: {npc:11055} en {area:152}): 150 por caldero con su regreso, y luego ¡Misión cumplida! 200. Ay, Andorhal 150 ({npc:1852}, élite). En {area:2268}, las misiones de {area:2262} de {npc:11063} (Hermano Carlin 50 de Cromi en Andorhal, Villanos de Villa Darrow 100, Merodeadores de Villa Darrow 100) y Tesoros ocultos de {npc:10926} 200 al final de la historia de {area:2262}; {npc:12250} 75 de {npc:11038}. Después de ¡Misión cumplida!, cada caldero acepta una entrega repetible: 25 de reputación cada vez, hasta Exaltado. {npc:11056} en {area:3197} (Horda: {npc:11057} en {area:152}) te da un {item:13370}, sin el cual los componentes nunca caen, y vende aceleradores arcanos por 50 de plata (uno por entrega; se deshace a los 30 minutos, así que cómpralo al final). Cada entrega también pide 4 {item:14047}. Farmea {area:201}: sus fantasmas sueltan un {item:13354} más o menos una vez de cada cuatro, así que unas 16 muertes llenan una entrega; los otros calderos piden 5 o 6 componentes que caen una vez de cada diez o menos. Cuando la Plaga de las Tierras de la Peste deja de contar, esto rinde unas cuatro veces más que sus piedras de la Plaga solas.",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "{npc:11056}: pide un {item:13370}",
	-- {npc:11057} Apothecary Dithers · {area:152} Bulwark · {item:13370} Vitreous Focuser
	["{npc:11057}, at the {area:152}: ask for a {item:13370}"] = "{npc:11057}, en {area:152}: pide un {item:13370}",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "Resonadores ectoplásmicos: los fantasmas alrededor del caldero",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "{item:13320}, 50 de plata",
	-- {area:201} Gahrron's Withering
	["the cauldron at {area:201}: handed in from its window, never in the log"] = "el caldero de {area:201}: se entrega desde su ventana, nunca en el registro",

	-- Step 5: Light's Hope Chapel quests
	-- {area:2268} Light's Hope Chapel
	["{area:2268} quests"] = "Misiones de {area:2268}",
	-- {area:2268} Light's Hope Chapel · {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243252} Leonid Barthalomew · {area:2279} Stratholme · {area:2057} Scholomance · {object:176317} Argent Hold
	["{area:2268}, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243252} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for {area:2279} and {area:2057} (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "{area:2268}, en el lado este de {zone:1423}, es la casa de {faction:529}: {npc:11039}, {npc:11035} y {npc:243252} dan sus misiones de mazmorra, de 100 a 200 de reputación cada una y unas 1.700 en total. Son misiones de grupo para {area:2279} y {area:2057} (nivel 58-60, cinco jugadores): toma las que vaya a hacer tu grupo. La cadena del duque termina en el {object:176317}, un cofre con equipo de {faction:529}.",

	-- Step 6: Stratholme
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["{area:2279} is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "{area:2279} es para un grupo de cinco en el extremo norte de {zone:1423}. Su Plaga da 5 de reputación por muerte hasta el último punto de Honorable, y sus jefes de la Plaga 25 hasta Exaltado ({npc:10440} 50), cada uno con una {item:12843}. Los centinelas de la Guardia Negra junto al Barón dan 5 hasta Exaltado. El lado de la Plaga, por la entrada de servicio, paga mucho más que el lado Escarlata.",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "Muestras de carne apestada: la Plaga de adentro",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "{item:13180}: las cajas de suministros",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "{npc:10811}, lado Escarlata",

	-- Step 7: Scholomance
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; your side's {area:2057} quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "{area:2057} está debajo de {area:2298}, el pueblo isleño del sureste de {zone:1422}; las misiones de {area:2057} de tu bando dan la {item:13704} que la abre. Es la mejor pasada para {faction:529}: sus enemigos dan 5 hasta el último punto de Honorable, y sus trece jefes unos 375 de reputación por pasada completa más unas diez {quest:5508} (unos 250 más). {npc:10508} y {npc:1853} dan 50 cada uno.",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "{quest:5529}, en el criadero",

	-- Step 8: Back at Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back at {area:2268}"] = "De vuelta en {area:2268}",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {area:2279} Stratholme · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {area:1583} Blackrock Spire · {npc:243252} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit · {area:2057} Scholomance
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a {area:2279} ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her {area:1583} quests, sends you to {npc:243252} (75) and on to {npc:11035}'s {item:12368} in {area:2057} (25 and 200)."] = "{quest:5212} lleva a {quest:5213} (los {item:13176} en un zigurat de {area:2279}), que da el {item:13209} o la {item:19812}: mejores abalorios que también hacen caer piedras de la Plaga, así que pueden reemplazar a la Comisión. {quest:5251} lleva a la {item:13250} y a {npc:10440}. Una {item:13920}, un botín raro (más o menos el 6%) de las {quest:5529} una vez hecha {quest:5529}, inicia una misión que vale 50 cada vez: guárdalas hasta Reverenciado. {npc:10267}, en {zone:1428}, al final de sus misiones de {area:1583}, te manda con {npc:243252} (75) y luego a la {item:12368} de {npc:11035} en {area:2057} (25 y 200).",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "De Amistoso a Honorable: piedras y Plaga con nombre",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {area:2057} Scholomance · {area:2279} Stratholme · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {area:3197} Chillwind Camp · {area:152} Bulwark · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {area:2272} Northdale · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the {area:2057} and {area:2279} mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at {area:2268} takes all three kinds, and so do the officers at {area:3197} and the {area:152}. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at {area:2272}, just north of {area:2268}, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "La Plaga normal fuera de las mazmorras deja de dar reputación a mitad de Amistoso (3.000 de 6.000); {npc:10826}, {npc:10821} y {npc:10825} dejan de contar al final de Amistoso. Después solo cuentan Araj, los enemigos de {area:2057} y {area:2279}, las entregas de los calderos y las piedras de la Plaga. Ahora entrega las piedras que guardaste: {npc:11039}, en {area:2268}, acepta los tres tipos, y también los oficiales de {area:3197} y {area:152}. Cada entrega paga 25 y una {item:12844}: guarda 35 fichas para los mantos de Reverenciado y Exaltado. Las {quest:5509} valen el doble por piedra: los adeptos oscuros, magos de las Sombras, tejedores del terror y campeones de la Plaga (nivel 58-60) de {area:2272}, justo al norte de {area:2268}, las sueltan más o menos un tercio de las veces o más, al lado de la entrega. La Plaga con nombre de abajo suelta una {item:12843} la mitad de las veces o más ({npc:1850} dos de cada tres veces, Araj y {npc:10821} la mitad) y da 15 por muerte, Araj hasta Exaltado; {npc:1850} no da reputación, solo la piedra. Amistoso abre las galletas de maná enriquecidas (60 de plata) en los intendentes.",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "{item:12843}: la Plaga con nombre de abajo y los jefes de mazmorra",
	-- {area:2272} Northdale
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage
	["Dark Adepts and Shadowmages at {area:2272}"] = "Adeptos oscuros y magos de las Sombras en {area:2272}",
	-- {npc:1852} Araj the Summoner
	["{npc:1852}, Andorhal"] = "{npc:1852}, Andorhal",
	-- {npc:1850} Putridius · {zone:1422} Western Plaguelands
	["{npc:1850}, {zone:1422}: the stone only"] = "{npc:1850}, {zone:1422}: solo la piedra",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: 20 for 25 reputation"] = "{quest:5510}: 20 por 25 de reputación",
	-- {quest:5509} Invader's Scourgestones
	["{quest:5509}: 10 for 25 reputation"] = "{quest:5509}: 10 por 25 de reputación",
	-- {quest:5508} Corruptor's Scourgestones
	["{quest:5508}: 1 for 25 reputation"] = "{quest:5508}: 1 por 25 de reputación",

	-- Step 10: Honored to Revered: dungeons and stones
	["Honored to Revered: dungeons and stones"] = "De Honorable a Reverenciado: mazmorras y piedras",
	-- {area:2057} Scholomance · {area:2279} Stratholme · {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:10856} Argent Quartermaster Hasana · {area:152} Bulwark · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 {area:2057} and {area:2279} mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at {area:2268}, {npc:10857} at {area:3197}, {npc:10856} at the {area:152}. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "De Honorable a Reverenciado son 12.000: unos 2.400 enemigos de {area:2057} y {area:2279}, menos con sus jefes. Sus enemigos dejan de contar en 11.999 de 12.000 en Honorable; un jefe o una entrega te hace pasar. En solitario solo cuentan las piedras de la Plaga, las entregas de los calderos y Araj: 12.000 son 480 entregas, o 4.800 {quest:5509}. Guarda las piedras que consigas en las mazmorras hasta que sus enemigos dejen de contar. Honorable abre recetas en los tres intendentes: {npc:11536} en {area:2268}, {npc:10857} en {area:3197}, {npc:10856} en {area:152}. También la {item:22014} (133 de oro) para la misión de los Tres Reyes de la Llama.",
	-- {item:19446} Formula: Enchant Bracer - Mana Regeneration
	["{item:19446}, 3 gold"] = "{item:19446}, 3 de oro",
	-- {item:19216} Pattern: Argent Boots · {skill:197} Tailoring
	["{item:19216} ({skill:197}), 2 gold 20 silver"] = "{item:19216} ({skill:197}), 2 de oro 20 de plata",
	-- {item:19328} Pattern: Dawn Treaders · {skill:165} Leatherworking
	["{item:19328} ({skill:165}), 2 gold 20 silver"] = "{item:19328} ({skill:165}), 2 de oro 20 de plata",
	-- {item:19203} Plans: Girdle of the Dawn · {skill:164} Blacksmithing
	["{item:19203} ({skill:164}), 2 gold 20 silver"] = "{item:19203} ({skill:164}), 2 de oro 20 de plata",
	-- {item:13482} Recipe: Transmute Air to Fire · {skill:171} Alchemy
	["{item:13482} ({skill:171}), 1 gold 50 silver"] = "{item:13482} ({skill:171}), 1 de oro 50 de plata",
	-- {item:19442} Formula: Powerful Anti-Venom · {skill:129} First Aid
	["{item:19442} ({skill:129}), 10 gold"] = "{item:19442} ({skill:129}), 10 de oro",

	-- Step 11: Mantles of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5504} Mantles of the Dawn · {faction:529} Argent Dawn · {item:18173} Shadow Mantle of the Dawn · {item:13810} Blessed Sunfruit
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Revered, {npc:11536} takes 10 Argent Dawn Valor Tokens for {quest:5504} (100 reputation). After it, any {faction:529} quartermaster sells the five shoulder enchants for 10 gold each: Flame, Frost, Arcane, Nature and {item:18173}, +5 to that resistance. Revered also opens the {item:13810} and its juice (60 silver) and the Revered recipes."] = "En Reverenciado, {npc:11536} acepta 10 fichas de valor del Alba Argenta para {quest:5504} (100 de reputación). Después, cualquier intendente de {faction:529} vende los cinco encantamientos de hombros por 10 de oro cada uno: Llama, Escarcha, Arcano, Naturaleza y {item:18173}, +5 a esa resistencia. Reverenciado también abre el {item:13810} y su jugo (60 de plata) y las recetas de Reverenciado.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens, from the stone turn-ins"] = "Fichas de valor del Alba Argenta, de las entregas de piedras",
	-- {item:18170} Frost Mantle of the Dawn
	["{item:18170}: pick the resistance you need, 10 gold"] = "{item:18170}: elige la resistencia que necesites, 10 de oro",
	-- {item:19447} Formula: Enchant Bracer - Healing
	["{item:19447}, 6 gold"] = "{item:19447}, 6 de oro",
	-- {item:19217} Pattern: Argent Shoulders · {skill:197} Tailoring
	["{item:19217} ({skill:197}), 4 gold"] = "{item:19217} ({skill:197}), 4 de oro",
	-- {item:19329} Pattern: Golden Mantle of the Dawn · {skill:165} Leatherworking
	["{item:19329} ({skill:165}), 4 gold"] = "{item:19329} ({skill:165}), 4 de oro",
	-- {item:19205} Plans: Gloves of the Dawn · {skill:164} Blacksmithing
	["{item:19205} ({skill:164}), 4 gold"] = "{item:19205} ({skill:164}), 4 de oro",

	-- Step 12: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {quest:5508} Corruptor's Scourgestones · {area:2057} Scholomance · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full {area:2057} clear is about 600). Turn in every stone and {item:13920} you saved."] = "De Reverenciado a Exaltado son 21.000: 840 entregas de piedras de la Plaga o de calderos, o los jefes de mazmorra con sus {quest:5508} (una pasada completa de {area:2057} son unos 600). Entrega cada piedra y {item:13920} que guardaste.",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "En Exaltado, {npc:11536} acepta 25 fichas de valor del Alba Argenta por {quest:5517} (150 de reputación): +5 a todas las resistencias, en tus hombros. Después, los intendentes venden más por 40 de oro cada uno.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "Fichas de valor del Alba Argenta",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Corruptor's Scourgestones and dungeons to Revered"] = "Piedras de la Plaga del corruptor y calabozos hasta Reverenciado",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Los Adeptos oscuros y Magos oscuros (nivel 58-60) sueltan aquí Piedras de la Plaga del invasor, además de piedras del esbirro y {item:14047}. Entrega las del invasor de 10 en 10 y las del esbirro de 20 en 20 a {npc:11039} en {area:2268}. En Classic ambas dejan de dar reputación en Honorable.",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "Desde Honorable, las Piedras de la Plaga del corruptor (una por entrega) y matar Plaga en {area:2279} y {area:2057} dan la reputación. Las piedras del corruptor caen de los jefes de la Plaga de allí ({npc:1853}, {npc:10433}, Vectus) y de {npc:1852} y Putridus en {zone:1422}. Muchas incursiones en calabozos rinden más rápido que cualquier farmeo al aire libre.",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Los necrófagos y esqueletos de todo {zone:1422} sueltan Piedras de la Plaga del esbirro aproximadamente la mitad de las veces; este grupo es denso. Entrégalas de 20 en 20 a cualquier Oficial Argenta (Purocorazón en {area:3197}, Garush en {area:152}, {npc:11039} en {area:2268}). Cada entrega también da una {item:12844} para los intendentes Argenta.",
	-- ["Invader's Scourgestones to Honored"] = "Piedras de la Plaga del invasor hasta Honorable",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Sigue haciendo {area:2279} y {area:2057} y entregando cada {item:12843} en {area:2268} hasta Exaltado.",
	-- ["Minion's Scourgestones to Friendly"] = "Piedras de la Plaga del esbirro hasta Amistoso",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Haz {area:2279} (ambas alas) y {area:2057}, matando a toda la Plaga que encuentres.",
	-- ["{faction:529} to Exalted"] = "{faction:529} hasta Exaltado",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} empieza en Neutral. Toma la comisión de {npc:10839} en {area:152} y llévala equipada: en Classic, las Piedras de la Plaga solo caen mientras tienes equipado el abalorio {quest:5401}. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} empieza en Neutral. Toma la comisión de {npc:10840} en {area:3197} y llévala equipada: en Classic, las Piedras de la Plaga solo caen mientras tienes equipado el abalorio {quest:5401}. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
}
