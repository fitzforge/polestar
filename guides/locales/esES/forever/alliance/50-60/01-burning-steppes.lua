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
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Opcional: {npc:8395} quiere dos plumas de hipogrifo sin estropear ({item:10450}) de los hipogrifos alrededor de su campamento. Los datos no indican experiencia para ella.",
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
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nada hasta la islita frente al extremo sur de {zone:1447}: {npc:8392} espera junto al monumento.",

	-- Step 24: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 25: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 27: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus está junto al rey Magni en {object:171709}.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Las reliquias están en {zone:1428}: guárdala",

	-- Step 28: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 29: Wildkin feathers
	["Wildkin feathers"] = "Plumas de lechúcico",
	-- {zone:1425} Hinterlands · {area:348} Aerie Peak
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "",

	-- Step 30: The Super Snapper FX
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 32: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 33: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "",

	-- Step 34: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "",

	-- Step 35: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 36: Chillwind Camp
	["Ride back south to the camp."] = "Vuelve al sur hasta el campamento.",

	-- Step 37: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "El fantasma de {npc:10778} vaga junto a la casa de {area:199}, al oeste de {area:200}; su paquete está dentro.",
	["Upstairs"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Para {zone:1453}: guárdala",

	-- Step 38: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Caldera de {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} protege la caldera de {area:199}, al oeste de Andorhal.",

	-- Step 40: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 41: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "",

	-- Step 42: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "Los ogros Pirontraña ocupan la gran roca al norte de la Vigilia, con los toscos en su lado este.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "",
	-- {npc:7033} Firegut Ogre · {npc:9177} Oralius · {quest:4283} FIFTY! YEP!
	["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "",

	-- Step 43: Morgan's Vigil
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: los orcos Roca Negra sueltan los medallones, mantenla abierta por todas las Estepas",

	-- Step 44: Level 52
	["Level 52"] = "",
	-- {area:249} Dreadmaul Rock · {area:251} Flame Crest · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["grind on {npc:7034}"] = "",

	-- Step 45: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Sigue el camino al oeste y luego sube al norte hasta el campamento goblin en {area:251}.",

	-- Step 46: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {object:147516} Dark Iron · {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "",

	-- Step 47: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Termina con {quest:4808} en {area:2255}, {zone:1452}: guárdala",

	-- Step 48: Cyrus Therepentous
	["Below ground"] = "",

	-- Step 49: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 51: Level 52.08
	["Level 52.08"] = "",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple · {area:2100} Maraudon
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "",

	-- Step 52: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling."] = "",
	-- {item:11467} Blackrock Medallion
	["{item:11467}; inside"] = "",

	-- Step 53: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Vuelve al este por el camino hasta la Vigilia.",

	-- Step 54: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Sube a la cima de {area:249} y planta la cabeza en el montículo de tierra blanda.",

	-- Step 56: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "",
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "",

	-- Step 57: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear (no name in this language: may be words) · {spell:10854} Flames of Chaos
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%."] = "",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "",

	-- Step 65: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",

	-- Step 67: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 68: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Los lechúcicos están en {zone:1452}: guárdala",

	-- Step 69: Druid training
	["Druid training"] = "Entrenamiento de druida",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} no tiene instructor de druidas: toma el portal para subir a {zone:1457} y entrena en el {area:1658}; luego vuelve a bajar a {area:702}.",

	-- Step 70: Back to Teldrassil
	-- {zone:1438} Teldrassil
	["Back to {zone:1438}"] = "",

	-- Step 71: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Vuelve a subir hasta {npc:8405} en {area:1224}, sobre las ruinas.",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Vuela de {zone:1455} a {area:150} y toma el barco a {area:442}.",
	-- ["Fly from {zone:1455} to {area:69}."] = "Vuela de {zone:1455} a {area:69}.",
	-- ["Fly to {area:1438}."] = "Vuela a {area:1438}.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Vuela a {area:150} y toma el barco a {area:442}; luego, el barco a {area:702}.",
	-- ["From the {area:442} dock, fly to {area:415}."] = "Desde el muelle de {area:442}, vuela a {area:415}.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Opcional: el fantasma de {npc:8888} está sobre su tumba en la gran cadena dentro de la {area:254}, y solo los muertos pueden verlo. Si mueres cerca de la montaña de todas formas, lleva a tu espíritu hasta él antes de resucitar.",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Lee la tablilla del campamento {object:147516} entre las ruinas, al suroeste de {area:251}, para copiar la transcripción.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Vuelve a {area:1438} y vuela a {area:348}. Las plumas de lechúcico ({item:10819}) están por el suelo de {zone:1425}, al sur y al este de {area:348}, donde rondan los lechúcicos; los bichos de aquí ya son de nivel muy inferior al tuyo.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Cabalga al este por el camino que sale de {zone:1440} hacia {zone:1447} hasta el campamento de las centinelas en {area:3137}.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Cabalga al norte desde {area:69} por el paso hasta {zone:1428}; {area:2418} está arriba, en el sureste de las Estepas.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "Nada hasta la islita frente al extremo sur de {area:16}: {npc:8392} espera junto al monumento.",
	-- ["Thaurissan Relics"] = "Reliquias Thaurissan ({object:153556})",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Las reliquias son las piedras talladas repartidas por las {area:250} alrededor de {area:251}: haz clic en ellas hasta recuperar la información.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "El santuario está en la esquina suroeste de {area:16}, al sur de {area:3137}.",
	-- ["The {quest:4296}"] = "La {quest:4296}",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Usa el {item:12284} en un {npc:7047} de las laderas al este de {area:251} justo antes de que muera y despoja la esencia que deja.",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} espera en el {area:2517}, la colina al suroeste del castillo. Los bichos de {zone:1419} del camino sueltan los fragmentos draenetistas imperfectos ({item:10593}); llévale los que tengas.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} y los orcos Roca Negra ocupan los campamentos y el bastión al pie de la {area:254}, al oeste de {area:251}. Atráelos de uno en uno; cualquier orco o huargo puede soltar un medallón, así que mátalos hasta tener cincuenta.",
}
