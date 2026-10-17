-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ironforge
	-- {npc:5111} Innkeeper Firebrew
	["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: la guía anterior te vincula aquí, así que esto suele marcarse de inmediato",

	-- Step 2: Menethil Harbor
	-- {zone:1455} Ironforge · {area:150} Menethil Harbor · {area:442} Auberdine
	["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Vuela de {zone:1455} a {area:150} y toma el barco a {area:442}.",

	-- Step 3: Auberdine
	-- {area:442} Auberdine · {area:415} Astranaar
	["From the {area:442} dock, fly to {area:415}."] = "Desde el muelle de {area:442}, vuela a {area:415}.",

	-- Step 4: Talrendis Point
	-- {zone:1440} Ashenvale · {zone:1447} Azshara · {area:3137} Talrendis Point
	["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Cabalga al este por el camino desde {zone:1440} hacia {zone:1447} hasta el campamento de las centinelas en {area:3137}.",

	-- Step 5: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "El santuario está en la esquina suroeste de {zone:1447}, al sur de {area:3137}.",

	-- Step 6: Haldarr Encampment
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Los fantasmas altonato rondan las ruinas alrededor del santuario; los sátiros Haldarr ocupan el campamento justo al norte.",

	-- Step 8: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Cabalga al noreste desde el santuario: {npc:8405} acampa en {area:1224}, en las colinas sobre el camino.",

	-- Step 9: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Trotadores Pezuñamusgo",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Los trotadores Pezuñamusgo más cercanos pastan en las colinas al noreste de {area:1224}, hacia {area:1219}; una manada mayor deambula por el terreno abierto del sur.",

	-- Step 11: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Opcional: {npc:8395} quiere dos plumas de hipogrifo sin estropear de los hipogrifos alrededor de su campamento. Los datos no indican experiencia para ella.",

	-- Step 12: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} acampa en {area:1219}, en el norte; su equipo está por todo {area:1220}, justo al sureste de él.",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Los nagas Látigo de Ira de {area:1221} llevan {item:13815}. Las cuatro runas de {npc:8507} están entre las ruinas: usa su {item:10445} en cada una.",
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, cerca del 10%",

	-- Step 14: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Sube de vuelta con {npc:8405} en {area:1224}, sobre las ruinas.",

	-- Step 16: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nada hasta la islita frente a la punta sur de {zone:1447}: {npc:8392} espera junto al monumento.",

	-- Step 18: Lakeshire
	-- {zone:1455} Ironforge · {area:69} Lakeshire
	["Fly from {zone:1455} to {area:69}."] = "Vuela de {zone:1455} a {area:69}.",

	-- Step 19: Morgan's Vigil
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Cabalga al norte desde {area:69} por el paso hacia {zone:1428}; {area:2418} está en lo alto, en el sureste de las Estepas.",
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: los orcos Roca Negra sueltan los medallones; tenla abierta por todas las Estepas",

	-- Step 20: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "Los ogros Pirontraña ocupan la gran roca al norte de la Vigilia, con los toscos en su lado este.",

	-- Step 22: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Sigue el camino al oeste y luego sube al norte hasta el campamento goblin en {area:251}.",

	-- Step 23: Thaurissan Relics
	-- plural, as words: Thaurissan Relics = {object:153556} Thaurissan Relic
	["Thaurissan Relics"] = "Reliquias Thaurissan",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Las reliquias son las piedras talladas dispersas por {area:250} alrededor de {area:251}: haz clic en ellas hasta recuperar la información.",

	-- Step 24: The Tablet of the Seven
	-- {quest:4296} Tablet of the Seven
	["The {quest:4296}"] = "{quest:4296}",
	-- {object:147516} Dark Iron (no name in this language: may be words) · {area:251} Flame Crest
	["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Lee la tablilla en el campamento {object:147516} entre las ruinas, al suroeste de {area:251}, para copiar la transcripción.",

	-- Step 25: Broodling Essence
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Usa {item:12284} en una {npc:7047} en las laderas al este de {area:251} justo antes de que muera, y luego saquea la esencia que deja.",

	-- Step 26: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Termina con {quest:4808} en {area:2255}, {zone:1452}: guárdala",

	-- Step 27: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} y los orcos Roca Negra ocupan los campamentos y el bastión al pie de {area:254}, al oeste de {area:251}. Atráelos de uno en uno; cualquier orco o huargo puede soltar un medallón, así que mátalos hasta tener cincuenta.",

	-- Step 28: Franclorn Forgewright
	-- {npc:8888} Franclorn Forgewright · {area:254} Blackrock Mountain
	["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Opcional: el fantasma de {npc:8888} está sobre su tumba en la gran cadena dentro de {area:254}, y solo los muertos pueden verlo. Si de todos modos mueres cerca de la montaña, lleva tu espíritu hasta él antes de resucitar.",

	-- Step 29: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Cabalga de vuelta al este por el camino hasta la Vigilia.",

	-- Step 30: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Sube a lo alto de {area:249} y planta la cabeza en el montón de tierra blanda.",

	-- Step 32: Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}."] = "Vuela a {area:1438}.",

	-- Step 33: Kum'isha the Collector
	-- {npc:7363} Kum'isha the Collector · {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} espera en {area:2517}, la colina al suroeste de la fortaleza. Los enemigos de {zone:1419} del camino sueltan los trozos draenetistas imperfectos; llévale los que tengas.",

	-- Step 34: Wildkin feathers
	["Wildkin feathers"] = "Plumas de lechúcico salvaje",
	-- {area:1438} Nethergarde Keep · {area:348} Aerie Peak · {zone:1425} Hinterlands
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Cabalga de vuelta a {area:1438} y vuela a {area:348}. Las plumas de lechúcico salvaje están en el suelo por {zone:1425}, al sur y al este de {area:348}, donde deambulan las lechubestias; los enemigos de aquí ya están muy por debajo de tu nivel.",

	-- Step 36: Menethil Harbor
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Vuela a {area:150} y toma el barco a {area:442}, y luego el barco a {area:702}.",

	-- Step 37: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Los lechúcicos salvajes están en {zone:1452}: guárdala",

	-- Step 38: Druid training
	["Druid training"] = "Entrenamiento de druida",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} no tiene instructor de druidas: toma el portal para subir a {zone:1457} y entrena en {area:1658}; luego baja de vuelta a {area:702}.",
}
