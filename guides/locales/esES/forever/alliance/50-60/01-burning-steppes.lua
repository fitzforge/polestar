-- Spanish (Spain) (esES): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "El santuario está en la esquina suroeste de {zone:1447}, al sur de {area:3137}.",

	-- Step 2: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "",
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Los fantasmas altonatos rondan las ruinas alrededor del santuario; los sátiros Haldarr ocupan el campamento justo al norte.",

	-- Step 5: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Cabalga al noreste desde el santuario: {npc:8405} acampa en {area:1224}, en las colinas sobre el camino.",

	-- Step 6: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Maledictores Pezuñamusgo ({npc:8761})",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Los maledictores Pezuñamusgo ({npc:8761}) más cercanos pastan en las colinas al noreste de {area:1224}, hacia {area:1219}; una manada mayor recorre el terreno abierto del sur.",

	-- Step 9: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395} quiere dos plumas de hipogrifo sin estropear de los hipogrifos Cabeza de Trueno alrededor de su campamento, los mismos con los que subes de nivel aquí: aproximadamente uno de cada tres lleva una.",
	-- {npc:6375} Thunderhead Hippogryph
	["grind on {npc:6375}"] = "",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "",

	-- Step 11: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "",

	-- Step 12: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} acampa en {area:1219}, en el norte; su equipo está repartido por todo el {area:1220}, justo al sureste de él.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "Las {area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Las nagas Látigo de Ira de las {area:1221} llevan {item:13815}. Las cuatro runas de {npc:8507} están entre las ruinas: usa su {item:10445} en cada una.",

	-- Step 17: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: los {npc:7864}, un 10 % aprox.",

	-- Step 18: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 20: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "",

	-- Step 21: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "",

	-- Step 23: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "Nada hasta la islita frente al extremo sur de {zone:1447}. Si {npc:8392} no está allí, dispara tu {item:10444} para avisarle y espera a que aterrice.",

	-- Step 24: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "A {zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Tu piedra de hogar está vinculada a {zone:1455} (la guía de {zone:1425} la vincula allí): vuelve con ella a la posada.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Posada de {zone:1455}",

	-- Step 26: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus está junto al rey Magni en {object:171709}.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Las reliquias están en {zone:1428}: guárdala",

	-- Step 27: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 28: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",

	-- Step 29: The Super Snapper FX
	-- {npc:7977} Gammerita · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "Son bichos élite: se recomienda agruparse, busca gente con quien hacerlo. {npc:7977} (élite de nivel 48) requiere un grupo de 2. Sáltatela si vas solo: la ruta te hace recuperar la experiencia matando bichos.\n{npc:7977} recorre la orilla de {zone:1425} bajo {area:307}, desde la flecha al sur hasta aprox. 75,66 y al norte hasta aprox. 82,52: si no está en la flecha, sigue la orilla.",

	-- Step 30: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 31: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "",

	-- Step 32: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "",

	-- Step 33: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 34: Chillwind Camp
	["Ride back south to the camp."] = "Vuelve al sur hasta el campamento.",

	-- Step 35: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "El fantasma de {npc:10778} vaga junto a la casa de {area:199}, al oeste de {area:200}; su paquete está dentro.",
	["Upstairs"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Para {zone:1453}: guárdala",

	-- Step 36: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Caldera de {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} protege la caldera de {area:199}, al oeste de Andorhal.",

	-- Step 38: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 39: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Vuela a {area:69}",

	-- Step 40: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "Cabalga al este desde {area:69} y sube por el paso hasta {zone:1428}: {area:2418} está en lo alto.",

	-- Step 41: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "",

	-- Step 42: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	-- plural, as words: Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "Los ogros Pirontraña ocupan la gran roca al norte de la Vigilia, con los toscos en su lado este.\nCuidado: los Canes del Núcleo fugados (nivel 60) deambulan por las Estepas, algunos en las laderas al oeste y al sur de {area:249}: atrae a los ogros en la misma roca y mira alrededor antes de atraer a cada uno.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "",
	-- {npc:7033} Firegut Ogre · {npc:9177} Oralius · {quest:4283} FIFTY! YEP!
	["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "",

	-- Step 43: Morgan's Vigil
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: los orcos Roca Negra sueltan los medallones, mantenla abierta por todas las Estepas",

	-- Step 44: Level 52
	["Level 52"] = "",
	-- {area:249} Dreadmaul Rock · {area:251} Flame Crest · {area:1417} Sunken Temple
	["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon instead."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["grind on {npc:7034}"] = "",

	-- Step 45: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Sigue el camino al oeste y luego sube al norte hasta el campamento goblin en {area:251}.",

	-- Step 46: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {object:147516} Dark Iron · {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "",

	-- Step 47: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Termina con {quest:4808} en {area:2255}, {zone:1452}: guárdala",

	-- Step 48: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "Abre el {item:10569} de {zone:1427} para sacar su {item:10575} y luego dile a {npc:9459} que traes pruebas de tus hazañas: no hay que luchar contra ningún dragón.",
	["Below ground"] = "Bajo tierra",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, del tesoro",

	-- Step 50: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 52: Level 52.08
	["Level 52.08"] = "",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "",

	-- Step 53: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176} y los orcos Roca Negra ocupan los campamentos y el bastión al pie de la {area:254}, al oeste de {area:251}. Atráelos de uno en uno; cualquier orco o huargo puede soltar un medallón, así que mátalos hasta tener cincuenta.\nCuidado: {npc:9176} tiene un guardia vinculado que se une al combate, y un segundo soldado patrulla cerca; acaba con la patrulla antes de atraerlo.\nCuidado: los Juraescamas, elementales de fuego de nivel 60, deambulan por las Estepas, algunos entre los campamentos Roca Negra: mira antes de cada ataque y déjalos pasar.",
	-- {item:11467} Blackrock Medallion
	["{item:11467}; inside"] = "",

	-- Step 54: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Vuelve al este por el camino hasta la Vigilia.",

	-- Step 55: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Sube a la cima de {area:249} y planta la cabeza en el montículo de tierra blanda.",

	-- Step 57: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "Vuela a {area:1438}",

	-- Step 58: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "Ardalan está dentro de {area:1438}.",

	-- Step 59: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "Cabalga al norte desde {zone:1419} hasta {zone:1435}: el {npc:10996} está junto al camino que viene de {zone:1419}. Mantente alejado de {area:75}, el pueblo de la Horda al noreste.",

	-- Step 60: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "Escucha su historia y luego vuelve al sur hasta Kum'isha.",

	-- Step 62: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear (no name in this language: may be words) · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32): take the fragments from the mobs on the way from the keep, not beside him."] = "",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "",

	-- Step 63: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "Vuelve con la piedra de hogar a la posada de {zone:1455}.",

	-- Step 64: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Vuela a {area:144}",

	-- Step 67: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maestro de vuelo de {area:144}",

	-- Step 70: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "Archesonus está junto al rey Magni en {object:171709}: las reliquias que leíste en las Estepas son suyas.",

	-- Step 71: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",

	-- Step 73: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 74: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Los lechúcicos están en {zone:1452}: guárdala",

	-- Step 77: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "El portal de {area:702} sube a {zone:1457}: {npc:9047} espera en el {area:1658}, en el norte de la ciudad.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, en el {area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} no tiene instructor de druidas",

	-- Step 78: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal a {zone:1438}",

	-- Step 79: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Class trainer"] = "Instructor de clase",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Vuelve a subir hasta {npc:8405} en {area:1224}, sobre las ruinas.",
	-- ["Druid training"] = "Entrenamiento de druida",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Vuela de {zone:1455} a {area:150} y toma el barco a {area:442}.",
	-- ["Fly from {zone:1455} to {area:69}."] = "Vuela de {zone:1455} a {area:69}.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Vuela a {area:150} y toma el barco a {area:442}; luego, el barco a {area:702}.",
	-- ["From the {area:442} dock, fly to {area:415}."] = "Desde el muelle de {area:442}, vuela a {area:415}.",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Opcional: {npc:8395} quiere dos plumas de hipogrifo sin estropear ({item:10450}) de los hipogrifos alrededor de su campamento. Los datos no indican experiencia para ella.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Opcional: el fantasma de {npc:8888} está sobre su tumba en la gran cadena dentro de la {area:254}, y solo los muertos pueden verlo. Si mueres cerca de la montaña de todas formas, lleva a tu espíritu hasta él antes de resucitar.",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "Los sacerdotes y los magos ya entrenaron aquí al final de la guía de Un'Goro",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Lee la tablilla del campamento {object:147516} entre las ruinas, al suroeste de {area:251}, para copiar la transcripción.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Vuelve a {area:1438} y vuela a {area:348}. Las plumas de lechúcico ({item:10819}) están por el suelo de {zone:1425}, al sur y al este de {area:348}, donde rondan los lechúcicos; los bichos de aquí ya son de nivel muy inferior al tuyo.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Cabalga al este por el camino que sale de {zone:1440} hacia {zone:1447} hasta el campamento de las centinelas en {area:3137}.",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "Cabalga al norte desde {zone:1419} hasta {zone:1435}: el {npc:10996} está junto al camino que viene de {zone:1419}. Mantente alejado de {area:75}, el pueblo de la Horda al noreste. Escucha su historia y luego vuelve al sur hasta Kum'isha.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Cabalga al norte desde {area:69} por el paso hasta {zone:1428}; {area:2418} está arriba, en el sureste de las Estepas.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "Nada hasta la islita frente al extremo sur de {area:16}: {npc:8392} espera junto al monumento.",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nada hasta la islita frente al extremo sur de {zone:1447}: {npc:8392} espera junto al monumento.",
	-- ["Thaurissan Relics"] = "Reliquias Thaurissan ({object:153556})",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Las reliquias son las piedras talladas repartidas por las {area:250} alrededor de {area:251}: haz clic en ellas hasta recuperar la información.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "El santuario está en la esquina suroeste de {area:16}, al sur de {area:3137}.",
	-- ["The {quest:4296}"] = "La {quest:4296}",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Usa el {item:12284} en un {npc:7047} de las laderas al este de {area:251} justo antes de que muera y despoja la esencia que deja.",
	-- ["Wildkin feathers"] = "Plumas de lechúcico",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} espera en el {area:2517}, la colina al suroeste del castillo. Los bichos de {zone:1419} del camino sueltan los fragmentos draenetistas imperfectos ({item:10593}); llévale los que tengas.",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} no tiene instructor de druidas: toma el portal para subir a {zone:1457} y entrena en el {area:1658}; luego vuelve a bajar a {area:702}.",
}
