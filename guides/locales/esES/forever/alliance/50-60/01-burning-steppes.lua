-- Spanish (Spain) (esES): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "Hacia {zone:1447}",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "Desde {area:415}, cabalga al este por el camino, más allá de {area:2358}, hasta {zone:1447}: {area:1235} está justo al cruzar la frontera, en la esquina suroeste de {zone:1447}.",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "Al este por el camino hasta {area:1235}",

	-- Step 2: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "El santuario está en la esquina suroeste de {zone:1447}, al sur de {area:3137}.",

	-- Step 3: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "Justo al noreste del santuario: {npc:239822} y {npc:240482} están en el campamento de la Alianza de {area:3137}.",

	-- Step 4: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "Corredores Pezuñamusgo",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "Los Corredores Pezuñamusgo (45-47) pastan en las colinas al norte de {area:3137}, de camino a los sátiros.",

	-- Step 5: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "Los fantasmas altonatos rondan las ruinas alrededor del santuario; los sátiros Haldarr ocupan el campamento justo al norte. {npc:222478} está cautiva en el campamento de los sátiros: libérala y sácala de allí.",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478}, en el campamento",
	["Help her escape the camp"] = "Ayúdala a escapar del campamento",

	-- Step 6: The western shore
	["The western shore"] = "La costa oeste",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "Los Guerreros (46-47) y Chilladores (47-48) Látigo de Ira ocupan la costa oeste, al noreste de los sátiros.",

	-- Step 7: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "Vuelve al suroeste a {area:3137}.",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822}: {quest:88809}; las reliquias las sueltan los nagas de la subida de nivel siguiente",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822}: {quest:92345}, para {npc:4217} en {zone:1457}; guárdala",

	-- Step 10: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Cabalga al noreste desde el santuario: {npc:8405} acampa en {area:1224}, en las colinas sobre el camino.",

	-- Step 11: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "",

	-- Step 12: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "Las {area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "Las nagas Látigo de Ira de {area:1221} llevan {item:13815}. Las runas de {npc:8507} están entre las ruinas: usa su {item:10445} en cada una. Estas nagas son las que pide el ajuste de nivel de abajo, así que estas muertes cuentan para él.",

	-- Step 14: Level 51.3 on the way north
	["Level 51.3 on the way north"] = "Nivel 51.3 de camino al norte",
	-- {npc:8395} Sanath Lim-yo · {npc:8420} Kim'jael · {area:1417} Sunken Temple
	-- plural, as words: Spitelash Myrmidons = {npc:6196} Spitelash Myrmidon
	["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "Sube hasta el nivel 51.3 con los Mirmidones Látigo de Ira (50-51) de las ruinas entre el campamento de {npc:8395} y el norte: los elfos de sangre del campamento de {npc:8420} son de nivel 51-53. O, con un grupo, haz la mazmorra de {area:1417}.",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "",

	-- Step 15: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "Las nagas Látigo de Ira de estas ruinas sueltan Reliquias de Eldarath para Truesong, subas de nivel aquí o no. {npc:239939} (52) está en las ruinas de Eldarath, al suroeste de los mirmidones: atráelo solo.",

	-- Step 16: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903} acampa junto al camino al norte hacia {npc:8420}: sus sátiros están en el campamento de {npc:8420}.",

	-- Step 17: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Maledictores Pezuñamusgo ({npc:8761})",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "Los Trotadores Pezuñamusgo más cercanos pastan en las colinas al noreste de {area:1224}, hacia {area:1219}; una manada mayor recorre el terreno abierto del sur.\nCuidado: los Trotadores Pezuñamusgo son de nivel 52-53, uno o dos por encima de ti aquí: atráelos de uno en uno desde el borde de la manada.",

	-- Step 20: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420} acampa en {area:1219}, en el norte; su equipo está repartido por {area:1220}, justo al sureste de él.\nCuidado: los Peritos elfos de sangre son de nivel 51-52 y los reclamadores de 52-53, con {npc:6647} (53) entre ellos: coge el equipo desde el borde del campamento y atrae a los elfos de uno en uno.\nLos sátiros, pícaros e invocadores infernales (51-53) de {npc:235903} son los Legashi alrededor del campamento de {npc:8420}; los Robaalmas, Alzainfiernos y Guardias negros Legashi (53) más al este no cuentan: mantente al oeste de ellos.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "",

	-- Step 23: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "En el camino de vuelta al sur, {npc:235903} se lleva los sátiros.",

	-- Step 24: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: los {npc:7864}, un 10 % aprox.",

	-- Step 25: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 27: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "",

	-- Step 28: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "",

	-- Step 30: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "Nada hasta la islita frente al extremo sur de {zone:1447}. Si {npc:8392} no está allí, dispara tu {item:10444} para avisarle y espera a que aterrice.",

	-- Step 31: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back to Truesong at {area:3137} before you hearth."] = "Vuelve con Truesong en {area:3137} antes de usar la piedra de hogar.",

	-- Step 32: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "A {zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "Tu piedra de hogar está vinculada a {zone:1455} (la guía de {zone:1425} la vincula allí): vuelve con ella a la posada.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "Posada de {zone:1455}",

	-- Step 34: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus está junto al rey Magni en {object:171709}.",

	-- Step 35: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:3701} es una misión de grupo a este nivel: sus reliquias están entre Atracadores de guerra y Caminafuegos de nivel 53-55, con {npc:8978} (57) cerca, de dos a cinco niveles por encima de ti, y la ruta no vuelve después a {zone:1428}. Se recomienda agruparse, busca gente con quien hacerla. Sáltala si vas solo.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Las reliquias están en {zone:1428}: guárdala",

	-- Step 36: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",

	-- Step 37: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",

	-- Step 38: The Super Snapper FX
	-- {npc:7977} Gammerita · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "Son bichos élite: se recomienda agruparse, busca gente con quien hacerlo. {npc:7977} (élite de nivel 48) requiere un grupo de 2. Sáltatela si vas solo: la ruta te hace recuperar la experiencia matando bichos.\n{npc:7977} recorre la orilla de {zone:1425} bajo {area:307}, desde la flecha al sur hasta aprox. 75,66 y al norte hasta aprox. 82,52: si no está en la flecha, sigue la orilla.",

	-- Step 39: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 40: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "Cabalga al norte desde {area:271} hasta Alterac y al oeste hasta las murallas de {area:279}: {npc:34365} está fuera de ellas. Su misión se entrega a {npc:266524} en {area:1438}, adonde esta guía vuela más tarde.",

	-- Step 41: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "",

	-- Step 42: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "",

	-- Step 43: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 44: Chillwind Camp
	["Ride back south to the camp."] = "Vuelve al sur hasta el campamento.",
	-- {area:199} Felstone Field · {zone:1452} Winterspring
	["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "guárdala: el caldero de {area:199} espera a la parada en Vientofrío de la guía de {zone:1452}, hacia el nivel 55",

	-- Step 45: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "El fantasma de {npc:10778} vaga junto a la casa de {area:199}, al oeste de {area:200}; su paquete está dentro.",
	["Upstairs"] = "Piso de arriba",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Para {zone:1453}: guárdala",

	-- Step 46: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 47: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Vuela a {area:69}",

	-- Step 48: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "Cabalga al este desde {area:69} y sube por el paso hasta {zone:1428}: {area:2418} está en lo alto.",

	-- Step 49: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "",

	-- Step 50: Level 52 at Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Level 52 at {area:249}"] = "Nivel 52 en {area:249}",
	-- {area:249} Dreadmaul Rock · {area:1417} Sunken Temple
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre
	["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "Primero sube hasta el nivel 52 con los Ogros Pirontraña (50-51) del lado cercano de {area:249}, al norte de la Vigilia: los toscos de su lado este son de nivel 52-53. O, con un grupo, haz la mazmorra de {area:1417}.",
	-- {npc:7033} Firegut Ogre
	["grind on {npc:7033}"] = "sube de nivel matando {npc:7033}",

	-- Step 51: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	-- plural, as words: Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "Los ogros Pirontraña ocupan la gran roca al norte de la Vigilia, con los toscos en su lado este.\nCuidado: los Canes del Núcleo fugados (nivel 60) deambulan por las Estepas, algunos en las laderas al oeste y al sur de {area:249}: atrae a los ogros en la misma roca y mira alrededor antes de atraer a cada uno.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "",

	-- Step 52: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "Las siguientes tareas de {npc:9177} ({npc:9176} y cincuenta Medallones Roca Negra) te mandan entre los orcos Roca Negra de nivel 55-58 al pie de {area:254}: sáltalas.",

	-- Step 53: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Sigue el camino al oeste y luego sube al norte hasta el campamento goblin en {area:251}.",

	-- Step 54: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "Usa el {item:12284} en una {npc:7047} en las laderas al este de {area:251} justo antes de que muera y luego despoja la esencia que deja.\nCuidado: un {npc:8981} (nivel 56, raro) recorre las laderas junto a las estirpes, y los {npc:7040} y vástagos dragón de alrededor son élite: usa el Incarcinatrix en una estirpe del borde y mira alrededor antes de cada atracción.",

	-- Step 55: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "Las reliquias son las piedras talladas repartidas por {area:250} alrededor de {area:251}: haz clic en ellas hasta recuperar la información. Coge las del borde sur de las ruinas, las más cercanas a {area:251}.\nCuidado: los Atracadores de guerra y Caminafuegos Thaurissan de las ruinas son de nivel 53-55, y {npc:8978} (57) ocupa el campamento {object:147516} al suroeste de {area:251}: coge las reliquias del borde de las ruinas, atrae de uno en uno y mantente lejos del campamento.",

	-- Step 56: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Termina con {quest:4808} en {area:2255}, {zone:1452}: guárdala",

	-- Step 57: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "Abre el {item:10569} de {zone:1427} para sacar su {item:10575} y luego dile a {npc:9459} que traes pruebas de tus hazañas: no hay que luchar contra ningún dragón.",
	["Below ground"] = "Bajo tierra",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, del tesoro",

	-- Step 59: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 61: Level 52.08
	["Level 52.08"] = "",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "",

	-- Step 62: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Vuelve al este por el camino hasta la Vigilia.",

	-- Step 63: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "Vuela a {area:1438}",

	-- Step 64: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "Ardalan está dentro de {area:1438}.",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546}: {quest:87295}, las escamas salen de los basiliscos de más adelante",

	-- Step 65: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "Cabalga al norte desde {zone:1419} hasta {zone:1435}: el {npc:10996} está junto al camino que viene de {zone:1419}. Mantente alejado de {area:75}, el pueblo de la Horda al noreste.",

	-- Step 66: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "Escucha su historia y luego vuelve al sur hasta Kum'isha.",

	-- Step 67: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "De vuelta a {zone:1419}",
	["Bloodmages' camp"] = "Campamento de los magos de sangre",

	-- Step 68: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Vuelve al sur hasta {zone:1419} a por las bestias de los magos de sangre: las Hienas risitas hambrientas deambulan por las colinas secas al sur del campamento de los magos de sangre, los Aguijoneros Scorpok corretean por el centro del norte y los buitres {npc:5982} sobrevuelan toda la zona. Los Jabalíes Cenicrín y los Basiliscos Rocarroja comparten las laderas al suroeste del bastión.\nCuidado: aquí deambulan dos élites: {npc:221740} (50) en el centro de la zona hacia 44,34, y {npc:247015} (55) en la cresta hacia 39,32. Si ves uno, caza en otra parte.",

	-- Step 70: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "Kum'isha espera en {area:2517}, la colina al suroeste del bastión. Los bichos de {zone:1419} del camino sueltan los Fragmentos draenetistas imperfectos; llévale los que tengas. Ve a su colina directamente desde el bastión, por el camino, y vuelve por el mismo sitio.\nCuidado: Felcular, {npc:7664} e Ilifar son élites de nivel 60. Razelikh lanza {spell:2691}, {spell:8255} y Diezmar, y a medida que pierde salud añade {object:141891}, {spell:10854} y luego Enfurecer al 15%.\nCuidado: {npc:247015}, élite de nivel 55, está junto a la colina de Kum'isha (aprox. 50,35) y al oeste (aprox. 39,32), y los campamentos Machacamiedo y Juramento Oscuro de alrededor son de nivel 53-55: consigue los fragmentos de los bichos del camino desde el bastión, no a su lado.",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "",

	-- Step 71: The bloodmages
	["The bloodmages"] = "",
	-- {zone:1419} Blasted Lands
	["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "Cabalga al norte hasta el campamento de los magos de sangre junto al camino que entra en {zone:1419}.",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "La segunda ronda de los magos de sangre paga las mismas partes con un objeto de mejora y sin experiencia: omítela.",

	-- Step 72: Bernie Heisten
	-- {npc:3546} Bernie Heisten · {area:1438} Nethergarde Keep
	["Back to {npc:3546} in {area:1438} before you hearth."] = "Vuelve con {npc:3546} en {area:1438} antes de usar la piedra de hogar.",

	-- Step 73: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "Vuelve con la piedra de hogar a la posada de {zone:1455}.",

	-- Step 74: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Vuela a {area:144}",

	-- Step 77: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maestro de vuelo de {area:144}",

	-- Step 80: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "Archesonus está junto al rey Magni en {object:171709}: las reliquias que leíste en las Estepas son suyas.",

	-- Step 81: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Vuela a {area:150}",

	-- Step 83: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 84: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Los lechúcicos están en {zone:1452}: guárdala",

	-- Step 87: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "El portal de {area:702} sube a {zone:1457}: {npc:9047} espera en el {area:1658}, en el norte de la ciudad.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, en el {area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} no tiene instructor de druidas",

	-- Step 88: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217} está en el piso de arriba del edificio de los druidas de {area:1658}: entra por su puerta sur.",
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, arriba",

	-- Step 89: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740} está junto a Tyrande en el Templo de la Luna, al sur de la ciudad.",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, de {area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1422} Western Plaguelands
	["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "Para {npc:5594} en {area:976}, en la guía de {zone:1422}: guárdalo",

	-- Step 90: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal a {zone:1438}",

	-- Step 91: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} está en el piso de arriba, encima de {npc:7916}: sube por dentro, la flecha no distingue los pisos.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Class trainer"] = "Instructor de clase",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Vuelve a subir hasta {npc:8405} en {area:1224}, sobre las ruinas.",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Sube a la cima de {area:249} y planta la cabeza en el montículo de tierra blanda.",
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
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Los fantasmas altonatos rondan las ruinas alrededor del santuario; los sátiros Haldarr ocupan el campamento justo al norte.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Las nagas Látigo de Ira de las {area:1221} llevan {item:13815}. Las cuatro runas de {npc:8507} están entre las ruinas: usa su {item:10445} en cada una.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Los maledictores Pezuñamusgo ({npc:8761}) más cercanos pastan en las colinas al noreste de {area:1224}, hacia {area:1219}; una manada mayor recorre el terreno abierto del sur.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "Las reliquias son las piedras talladas repartidas por las {area:250} alrededor de {area:251}: haz clic en ellas hasta recuperar la información.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "El santuario está en la esquina suroeste de {area:16}, al sur de {area:3137}.",
	-- ["The {quest:4296}"] = "La {quest:4296}",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Usa el {item:12284} en un {npc:7047} de las laderas al este de {area:251} justo antes de que muera y despoja la esencia que deja.",
	-- ["Wildkin feathers"] = "Plumas de lechúcico",
	-- ["{area:199} cauldron"] = "Caldera de {area:199}",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} protege la caldera de {area:199}, al oeste de Andorhal.",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363} espera en el {area:2517}, la colina al suroeste del castillo. Los bichos de {zone:1419} del camino sueltan los fragmentos draenetistas imperfectos ({item:10593}); llévale los que tengas.",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395} quiere dos plumas de hipogrifo sin estropear de los hipogrifos Cabeza de Trueno alrededor de su campamento, los mismos con los que subes de nivel aquí: aproximadamente uno de cada tres lleva una.",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} acampa en {area:1219}, en el norte; su equipo está repartido por todo el {area:1220}, justo al sureste de él.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176} y los orcos Roca Negra ocupan los campamentos y el bastión al pie de la {area:254}, al oeste de {area:251}. Atráelos de uno en uno; cualquier orco o huargo puede soltar un medallón, así que mátalos hasta tener cincuenta.\nCuidado: {npc:9176} tiene un guardia vinculado que se une al combate, y un segundo soldado patrulla cerca; acaba con la patrulla antes de atraerlo.\nCuidado: los Juraescamas, elementales de fuego de nivel 60, deambulan por las Estepas, algunos entre los campamentos Roca Negra: mira antes de cada ataque y déjalos pasar.",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: los orcos Roca Negra sueltan los medallones, mantenla abierta por todas las Estepas",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} no tiene instructor de druidas: toma el portal para subir a {zone:1457} y entrena en el {area:1658}; luego vuelve a bajar a {area:702}.",
}
