-- Spanish (Latin America) (esMX): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Alliance)"] = "{spell:71} y un arma (Alianza)",
	-- {spell:71} Defensive Stance · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{spell:71} at 10 and a one-hand weapon of your choice from {zone:1453}, {zone:1455} or {zone:1457}."] = "{spell:71} a nivel 10 y un arma de una mano a elección de {zone:1453}, {zone:1455} o {zone:1457}.",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{npc:252377} en {area:16638}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "A nivel 10, {npc:252377} está con los instructores junto a la puerta oeste de {area:16638}. Un sectario, {npc:257196}, tiene el escudo de su familia en {area:16629}.",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "Ve al noroeste desde {area:16638} hasta {area:16629}. {npc:257196} está al oeste de la subida al santuario, entre los guardianes, clamaespíritus y maestros de espadas del culto: atráelos de a uno antes de enfrentarlo. Suelta {item:263993}.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}, de {npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:6090} Bartleby · {zone:1453} Stormwind
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:6090}'s road below still gives a weapon, once you reach {zone:1453}."] = "De vuelta con {npc:252377} en {area:16638}. Te enseña {spell:71} y te da {item:275290}, un escudo para usarla. El camino de {npc:6090}, más abajo, igual te da un arma cuando llegues a {zone:1453}.",

	-- Step 4: Muren Stormpike
	-- {npc:1229} Granis Swiftaxe · {area:131} Kharanos · {quest:1679} Muren Stormpike · {zone:1455} Ironforge · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:1229}, the warrior trainer in {area:131}, sends you to {quest:1679} in {zone:1455}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} is the quickest stance (one fight in a tavern), with a Haggard's weapon after it."] = "A nivel 10, {npc:1229}, el instructor de guerreros en {area:131}, te manda con {quest:1679} en {zone:1455}. Cualquier guerrero de la Alianza puede tomar uno de los tres caminos, nunca dos: ¿igual vas a estar en {zone:1453} a nivel 10? {quest:1638} de {npc:5480} es la actitud más rápida (una pelea en una taberna), con un arma de Haggard después.",

	-- Step 5: Muren Stormpike in Ironforge
	-- {quest:1679} Muren Stormpike · {zone:1455} Ironforge
	["{quest:1679} in {zone:1455}"] = "{quest:1679} en {zone:1455}",
	-- {quest:1679} Muren Stormpike · {object:32390} Hall of Arms (no name in this language: may be words) · {object:32359} Military Ward (no name in this language: may be words)
	["{quest:1679} stands in the {object:32390} in the {object:32359}."] = "{quest:1679} está en {object:32390}, en {object:32359}.",

	-- Step 6: Vejrek
	-- {quest:1678} Vejrek · {area:135} Frostmane Hold · {spell:71} Defensive Stance · {spell:6343} Thunder Clap
	["{quest:1678} (level 11, a lone troll) waits at his hut on a hill south of {area:135}, near the mountains at the top of a short ramp, with no other trolls around; the hut at the front of {area:135} is the wrong one. He fights in {spell:71} and sunders your armor; {spell:6343} slows him. His head always drops; he returns about 8 minutes after dying."] = "{quest:1678} (nivel 11, un trol solitario) espera en su choza en una colina al sur de {area:135}, cerca de las montañas, al final de una rampa corta, sin otros trols alrededor; la choza del frente de {area:135} no es. Pelea en {spell:71} y te hiende la armadura; {spell:6343} lo ralentiza. Su cabeza siempre cae; vuelve unos 8 minutos después de morir.",

	-- Step 7: Tormus Deepforge
	-- {npc:6114} Muren Stormpike · {spell:71} Defensive Stance · {quest:1680} Tormus Deepforge · {object:32372} Great Forge (no name in this language: may be words) · {zone:1455} Ironforge
	["Back to {npc:6114} for {spell:71}, then to {quest:1680} at the {object:32372} in the middle of {zone:1455}."] = "De vuelta con {npc:6114} para {spell:71}, y luego con {quest:1680} en {object:32372}, en el centro de {zone:1455}.",

	-- Step 8: Ironband's Compound
	-- {quest:1681} Ironband's Compound · {zone:1426} Dun Morogh · {area:212} Helm's Bed Lake · {object:85562} Ironband's Strongbox · {npc:6124} Captain Beld
	["{quest:1681} lies in eastern {zone:1426}, below {area:212} on its south side. Dark Iron Spies (level 8-10) stand along the way, far enough apart to pull one at a time. {object:85562} is in the basement of the southernmost house; {npc:6124} (level 11) stands by it and charges on sight. The box always holds the ore and refills 15 minutes after opening."] = "{quest:1681} está en el este de {zone:1426}, debajo de {area:212} por su lado sur. Hay espías Hierro Negro (nivel 8-10) a lo largo del camino, lo bastante separados para atraerlos de a uno. {object:85562} está en el sótano de la casa más al sur; {npc:6124} (nivel 11) está a su lado y carga en cuanto te ve. La caja siempre tiene el mineral y se rellena 15 minutos después de abrirla.",
	-- {item:6800} Umbral Ore · {object:85562} Ironband's Strongbox
	["{item:6800}, from {object:85562}"] = "{item:6800}, de {object:85562}",

	-- Step 10: Elanaria
	-- {npc:3598} Kyra Windblade · {area:186} Dolanaar · {npc:2151} Moon Priestess Amara · {quest:1684} Elanaria · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:3598}, the warrior trainer in {area:186}, or {npc:2151}, who patrols the road west of {area:186}, sends you to {quest:1684} on the {area:1660} in {zone:1457}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} teaches the same stance after one fight in a tavern."] = "A nivel 10, {npc:3598}, la instructora de guerreros en {area:186}, o {npc:2151}, que patrulla el camino al oeste de {area:186}, te manda con {quest:1684} en {area:1660}, en {zone:1457}. Cualquier guerrero de la Alianza puede tomar uno de los tres caminos, nunca dos: ¿igual vas a estar en {zone:1453} a nivel 10? {quest:1638} de {npc:5480} enseña la misma actitud después de una pelea en una taberna.",

	-- Step 11: Elanaria in Darnassus
	-- {quest:1684} Elanaria · {zone:1457} Darnassus
	["{quest:1684} in {zone:1457}"] = "{quest:1684} en {zone:1457}",
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}."] = "{quest:1684} está en {area:1660}.",

	-- Step 12: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:186} Dolanaar
	["{quest:1683} (level 10, a satyr) stands at a hidden moonwell up a hillside west of {area:186}. The trail is hard to spot: it starts behind a Gnarlpine camp and climbs in switchbacks lined with lamp posts. The furbolgs below can come in groups. His horn always drops; he returns 5 minutes after dying."] = "{quest:1683} (nivel 10, un sátiro) está en un pozo de luna escondido, subiendo una ladera al oeste de {area:186}. El sendero cuesta verlo: empieza detrás de un campamento Tuercepino y sube en zigzag con faroles a los lados. Los fúrbolgs de abajo pueden venir en grupo. Su cuerno siempre cae; vuelve 5 minutos después de morir.",

	-- Step 14: Elunite under Auberdine
	-- {area:442} Auberdine
	["Elunite under {area:442}"] = "Elunita debajo de {area:442}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {npc:6133} Shade of Elura
	["Take the boat from {area:702} to {area:442}. The wreck lies underwater just south of {area:442}'s southern pier, where the Menethil boat docks. Open Crates of Elunite on the sea floor around the wreck, by a huge sunken turtle, toward the beach and under the pier until you have eight; every crate holds ore and comes back in 3-5 minutes. The grey {npc:6133} (level 11) drifts around the middle of the wreck and always drops the medallion: target it when you see it, so you can find it after surfacing for air. Watch your breath; Threshers can join in."] = "Toma el barco de {area:702} a {area:442}. El naufragio está bajo el agua justo al sur del muelle sur de {area:442}, donde atraca el barco de Menethil. Abre las Cajas de elunita del fondo del mar alrededor del naufragio, junto a una enorme tortuga hundida, hacia la playa y debajo del muelle, hasta tener ocho; cada caja tiene mineral y vuelve en 3-5 minutos. La {npc:6133} gris (nivel 11) flota por el centro del naufragio y siempre suelta el medallón: selecciónala cuando la veas para poder encontrarla después de salir a respirar. Cuida tu aliento; los trilladores pueden unirse.",
	-- {item:6808} Elunite Ore
	["{item:6808}, from Crates of Elunite"] = "{item:6808}, de las Cajas de elunita",
	-- {item:6809} Elura's Medallion · {npc:6133} Shade of Elura
	["{item:6809}, from the {npc:6133}"] = "{item:6809}, de la {npc:6133}",

	-- Step 15: Smith Mathiel
	-- {area:1660} Warrior's Terrace · {npc:4088} Elanaria · {item:6812} Case of Elunite · {npc:6142} Mathiel
	["Back on the {area:1660}: {npc:4088} hands you the {item:6812}; {npc:6142} works on the far, south side of the same terrace, easy to miss."] = "De vuelta en {area:1660}: {npc:4088} te da {item:6812}; {npc:6142} trabaja en el lado sur, al otro extremo de la misma terraza, fácil de pasar por alto.",

	-- Step 16: A Warrior's Training
	-- {npc:913} Lyria Du Lac · {area:87} Goldshire · {npc:6089} Harry Burlguard · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town
	["At 10, {npc:913}, the warrior trainer by the inn in {area:87}, sends you to {npc:6089} in {zone:1453}; {npc:5480}, the warrior trainer in {zone:1453}'s {object:2100}, offers it too."] = "A nivel 10, {npc:913}, la instructora de guerreros junto a la posada de {area:87}, te manda con {npc:6089} en {zone:1453}; {npc:5480}, la instructora de guerreros en {object:2100} de {zone:1453}, también la ofrece.",

	-- Step 17: Bartleby
	-- {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2100} Old Town · {quest:1638} A Warrior's Training · {npc:5480} Ilsa Corbin · {zone:1453} Stormwind
	["{npc:6089} and {npc:6090} are in the Pig and Whistle tavern in {object:2100}; {npc:6090} is the drunk at the far end of the bar. {npc:6090} (level 10) hits harder than his level, so start at full health; he gives up at low health instead of dying. If he wins, he disappears for about three minutes: keep the quest and talk to him again when he is back. A Dwarf, Gnome or Night Elf who took {quest:1638} from {npc:5480} instead of their home road is led through {zone:1453} from here."] = "{npc:6089} y {npc:6090} están en la taberna El Cerdo y el Silbato, en {object:2100}; {npc:6090} es el borracho al fondo de la barra. {npc:6090} (nivel 10) pega más fuerte de lo que dice su nivel, así que empieza con la salud al máximo; se rinde con poca salud en vez de morir. Si gana, desaparece unos tres minutos: quédate con la misión y vuelve a hablarle cuando regrese. Un enano, gnomo o elfo de la noche que tomó {quest:1638} de {npc:5480} en vez de su camino de origen sigue por {zone:1453} desde aquí.",

	-- Step 18: Marshal Haggard
	-- {npc:294} Marshal Haggard · {area:88} Eastvale Logging Camp
	["{npc:294}'s manor stands at the south-east edge of the {area:88} in eastern Elwynn, at the end of a short road that does not join the main one."] = "La mansión de {npc:294} está en el borde sureste de {area:88}, en el este de Elwynn, al final de un camino corto que no se une al principal.",

	-- Step 19: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {item:6783} Dead-tooth's Key · {object:85563} Dead-tooth's Strongbox · {item:6782} Marshal Haggard's Badge
	["{npc:6093} (level 11) camps in the far south-east of Elwynn. A guard stands beside him and Defias and wolves are spread around the camp (now and then a rarer guard too): clear them one at a time, then kill Jack. He always drops {item:6783}; open {object:85563} in the crates by him for {item:6782}. Jack returns 3 minutes after dying, the box 1 minute after opening."] = "{npc:6093} (nivel 11) acampa en el extremo sureste de Elwynn. Un guardia está a su lado y hay Defias y lobos repartidos por el campamento (a veces también un guardia más raro): despéjalos de a uno y luego mata a Jack. Siempre suelta {item:6783}; abre {object:85563} entre las cajas a su lado para conseguir {item:6782}. Jack vuelve 3 minutos después de morir, y la caja 1 minuto después de abrirla.",
	-- {npc:6093} Dead-Tooth Jack
	["from {npc:6093}"] = "de {npc:6093}",
	-- {item:6782} Marshal Haggard's Badge · {object:85563} Dead-tooth's Strongbox
	["{item:6782}, from {object:85563}"] = "{item:6782}, de {object:85563}",

	-- Step 20: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "Vuelve con {npc:294}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Haggard's Weapons"] = "Las armas de Haggard",
	-- ["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "La casa de {npc:294} está en el este de {zone:1429}, al sur del camino de {zone:1453} a Montañas Crestagrana.",
	-- ["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480} entrena guerreros en {object:2100}; {npc:6089} y {npc:6090} están juntos junto a {object:2152} de ahí. {npc:6090} pelea contigo por su jarra.",
	-- ["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093} acampa en el extremo sureste de {zone:1429}, al sureste de {npc:294}. Lleva la llave del cofre de su campamento.",
	-- ["{npc:6093}: his key opens the strongbox"] = "{npc:6093}: su llave abre el cofre",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} y un arma de una mano a tu elección a nivel 10.",
}
