-- Spanish (Spain) (esES): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands
	["Western & {zone:1423}"] = "",

	-- Step 1: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",

	-- Step 2: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "",
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}' next task sends you back to Ranshalla in {zone:1452}, behind the route now: skip it."] = "",

	-- Step 4: Herald Moonstalker
	-- {npc:10878} Herald Moonstalker
	["{npc:10878} stands by the Temple of the Moon."] = "",

	-- Step 6: Arch Druid Fandral Staghelm
	-- {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building of the {area:1658}; {npc:4217}, next, is lower down inside it."] = "",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "",

	-- Step 8: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, arriba",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade · {zone:2482} Mount Hyjal
	["{quest:6762} in {zone:1450}: {zone:2482}'s {zone:1450} errand takes you to her, in the next guide; keep it"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} no tiene instructor de druidas",

	-- Step 9: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal a {zone:1438}",

	-- Step 10: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Vuela a {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maestro de vuelo de {area:702}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",

	-- Step 12: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 13: Ironforge
	-- {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["{npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:15187} Cenarion Emissary Jademoon · {npc:15191} Windcaller Proudhorn · {zone:1451} Silithus
	["{npc:15187}, by the flight master where you land: for {npc:15191} in {zone:1451}, on the last guide; keep it"] = "",
	-- {npc:9616} Laris Geardawdle
	["{npc:9616}' next task fills his jars in Un'Goro, behind the route now: skip it."] = "",
	-- {npc:13843} Lieutenant Rotimer · {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13843}: for {npc:13841}, on the way to {area:3197}"] = "",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "",

	-- Step 14: Courier Hammerfall
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10877} Courier Hammerfall · {zone:1455} Ironforge · {npc:10838} Commander Ashlam Valorfist
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10877} walks the ring of {zone:1455} and sends you to {npc:10838}, whose camp this guide visits next. Chillwind's chain starts with it."] = "",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",

	-- Step 16: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them."] = "",

	-- Step 17: Lieutenant Haggerdin
	-- {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13841} camps beside the road north to {area:3197}."] = "",

	-- Step 18: Chillwind Camp: Clear the Way
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10838} Commander Ashlam Valorfist · {quest:5092} Clear the Way
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10838} stands in the middle of the camp. His {quest:5092} opens the camp's chain."] = "",

	-- Step 19: Sorrow Hill: Clear the Way
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls (50) roam the fields just north of the camp.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled."] = "",

	-- Step 20: Chillwind Camp: the cauldrons
	-- {area:3197} Chillwind Camp
	["{area:3197}: the cauldrons"] = "",
	-- {npc:11053} High Priestess MacDonnell
	["Back to the camp: Valorfist, then {npc:11053} beside him."] = "",
	-- {area:199} Felstone Field
	["{area:199}'s cauldron, later in this guide"] = "",

	-- Step 21: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Puracorazón, Dumah, Puño de Valor y MacDonnell están por el centro del campamento, junto al maestro de vuelo.",
	-- {npc:11616} Nathaniel Dumah · {area:2277} Plaguewood
	-- was: ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: las termitas vienen más tarde, en {area:2627}"
	["{npc:11616}: the termites come later, in the {area:2277}"] = "",
	-- {npc:10838} Commander Ashlam Valorfist · {area:199} Felstone Field
	["{npc:10838}: the watchtowers stand around Andorhal, on the way to {area:199}"] = "",

	-- Step 22: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission
	["No {quest:5401} yet? Pureheart gives you one here: the scourgestone quests need it."] = "",

	-- Step 23: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Las atalayas de Andorhal",
	-- {item:12815} Beacon Torch · {area:199} Felstone Field · {npc:7572} Fallen Hero of the Horde
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	-- was: ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Usa la {item:12815} al pie de cada una de las cuatro atalayas del borde de Andorhal, al norte del campamento.\nCuidado: Señores de la guerra esqueléticos y Gólems de carne (57, élites) recorren las calles de Andorhal, y el {npc:7572} (59, élite) deambula entre Andorhal y Cresta Norte: quédate en las torres del borde del pueblo y déjalos pasar."
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp, on the way to {area:199}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca la {npc:10902} con la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca la {npc:10903} con la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca la {npc:10904} con la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca la {npc:10905} con la {item:12815}",

	-- Step 24: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Caldera de {area:199}",
	-- {area:199} Felstone Field · {npc:11075} Cauldron Lord Bilemaw · {npc:10778} Janice Felstone · {zone:1453} Stormwind
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["West of Andorhal to {area:199}: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54).\n{npc:10778}'s ghost wanders by the farmhouse at the field's edge, upstairs; her parcel lies inside the house: take it for {zone:1453}, at the end of this guide."] = "",
	-- {npc:10778} Janice Felstone
	["{npc:10778}, upstairs in the farmhouse"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Para {zone:1453}: guárdala",

	-- Step 25: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Back to {area:3197}."] = "",
	-- {area:200} Dalson's Tears
	["The cauldron is at {area:200}"] = "",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} es élite de nivel 61",

	-- Step 26: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	-- was: ["{area:1943}: kill these as you meet them"] = "{area:1943}: mata a estos según los encuentres"
	["{area:197}: kill these as you meet them"] = "",
	-- {quest:5401} Argent Dawn Commission · {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones while you wear the {quest:5401} (equip it as a trinket first).\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Los Despellejadores esqueléticos y los Necrófagos esclavizantes merodean por los campos al norte del campamento; toda la Plaga de aquí suelta Piedras de la Plaga mientras lleves la {quest:5401} (equípala antes como abalorio).\nCuidado: estos no-muertos te detectan desde muy lejos, y otros no-muertos cercanos se unen al combate cuando atraes a uno.\nCuidado: el {npc:10411} (3 apariciones, reaparece en 15 min) se vuelve invisible fuera de combate y llama a Gárgolas Ventorroca en cuanto empieza el combate.",

	-- Step 27: Marlene Redpath
	-- {area:3197} Chillwind Camp · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {quest:5142} Little Pamela · {area:2262} Darrowshire
	["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the ghost in {area:2262}, the next stop."] = "",
	-- {npc:10927} Marlene Redpath · {area:2262} Darrowshire
	["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: guárdalo para {area:2262}",

	-- Step 28: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",
	-- {zone:1422} Western Plaguelands
	["Follow the southern road east out of the {zone:1422}."] = "",

	-- Step 29: Pamela Redpath
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["The ruins of {area:2262} lie south of the road. {npc:10926}'s ghost plays by the ruined house at the south end."] = "",

	-- Step 30: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "La muñeca de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Las tres piezas de la muñeca están en las casas en ruinas de {area:2262}; al recoger una pueden aparecer fantasmas. Combínalas para formar la muñeca.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "",

	-- Step 31: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, back in the {zone:1422}: keep it"] = "",
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["{npc:11063} at {area:2268}, on this guide's second ride east: keep it"] = "",

	-- Step 32: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride back west along the road to {npc:10927}'s farmhouse; {npc:10936}'s monument is just north of it."] = "",
	["Upstairs"] = "",
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal, later on this loop: keep it"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, en el monumento",

	-- Step 33: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {npc:10927} Marlene Redpath
	["{npc:10739} stands by the farm at the {area:202}, north of {npc:10927}."] = "",
	["Inside"] = "",

	-- Step 34: Writhing Haunt: kill these as you meet them
	-- {area:202} Writhing Haunt
	-- was: ["{area:1943}: kill these as you meet them"] = "{area:1943}: mata a estos según los encuentres"
	["{area:202}: kill these as you meet them"] = "",
	-- {item:12841} Invader's Scourgestone · {quest:5401} Argent Dawn Commission
	["{item:12841}: wear the {quest:5401} while you kill"] = "{item:12841}: lleva puesta la {quest:5401} mientras matas",

	-- Step 36: Diseased Grizzlies
	["Diseased Grizzlies"] = "Griseznos malsanos",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The Diseased Grizzlies (55-56) roam the woods around the {area:202}, east and north of {npc:10739}."] = "",

	-- Step 37: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {zone:1457} Darnassus
	["{npc:10739}' next task goes to the druids of {zone:1457}, behind the route now: skip it."] = "",

	-- Step 38: Dalson's Tears
	-- {npc:10836} Farmer Dalson · {npc:11152} The Scourge Cauldron
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key. {npc:11152} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924}, en la casa de la granja; dentro",

	-- Step 39: Argent Officer Pureheart
	-- {area:3197} Chillwind Camp
	["Ride back south to {area:3197}."] = "",

	-- Step 41: Chillwind Camp
	-- {area:200} Dalson's Tears
	["Ride back south from {area:200} to the camp."] = "",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} (from level 55)"] = "",
	["The skeletons of Andorhal, next on this guide"] = "",

	-- Step 42: Chromie
	-- {npc:10667} Chromie
	["North to {npc:10667} in the ruined inn on the west side of Andorhal."] = "",

	-- Step 43: Andorhal
	["Andorhal"] = "Andorhal",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments · {npc:1852} Araj the Summoner
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	-- was: ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "Usa el {item:12627} junto a los silos de grano para hacer salir Parásitos temporales. {quest:5154} es uno de los tomos mohosos del ayuntamiento. Todos los esqueletos del pueblo sueltan {quest:5537}.\nCuidado: los Parásitos temporales son de nivel 55-57, y Señores de la guerra esqueléticos y Gólems de carne (57, élites) recorren las calles: haz salir a los parásitos junto a los silos, de uno en uno, y deja pasar a los élites."
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass.\n{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "",

	-- Step 44: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, en {area:2268}: guárdala",

	-- Step 45: Sorrow Hill: kill these as you meet them
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 47: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Caldera de {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	-- was: ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "La caldera está en {area:202}, junto a la granja de {npc:10739}."
	["The cauldron sits at the {area:202}, by {npc:10739}' farm, east of Andorhal."] = "",

	-- Step 48: Chillwind Camp
	-- {area:201} Gahrron's Withering
	["{area:201}'s cauldron, on this guide's ride north-east"] = "",
	-- {area:976} Gadgetzan
	["Arbington's next task goes to {area:976}, behind the route now: skip it."] = "",

	-- Step 49: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone
	["Fly to {zone:1453} for Highlord Bolvar's errand for SI:7 and {npc:10778}'s parcel, then straight back."] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 50: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, en IV:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}, on the flight back"] = "",

	-- Step 51: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, que pasea por los canales",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, out of the way now: skip it."] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, en el {object:2096}",

	-- Step 52: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "Vuela a {area:3197}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 53: Flint Shadowmore
	-- {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["The agents' remains lie at the {area:2260} in the {zone:1423}, on this guide's ride east"] = "",

	-- Step 54: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Cabalga al norte por el camino hasta el Aserradero Crestanorte; {npc:11610} se esconde en el borde del campamento.",

	-- Step 55: The Scarlet Crusade
	["The Scarlet Crusade"] = "La Cruzada Escarlata",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Los médicos, cazadores, caballeros y magos escarlata patrullan el aserradero y el camino hacia {area:190}.",

	-- Step 57: Radley and Durgen
	["Radley and Durgen"] = "Radley y Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	-- was: ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} recorre el aserradero Crestanorte al este de {npc:11610}; {npc:11611} protege la torre del acceso sur de {area:190}.\nCuidado: hay guardias en la base de la torre y otro más patrulla a su alrededor. Acaba con ellos antes de enfrentarte a Durgen para que no se unan al combate."
	["{npc:11613} (56) walks the Northridge camp east of {npc:11610}; {npc:11611} (57) guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 58: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} se esconde al borde del campamento maderero.",

	-- Step 59: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Mirador de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 61: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2277} Plaguewood · {area:2627} Terrordale
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank. His hunts are in the {area:2277} and {area:2627}, at the end of this guide's ride east."] = "",

	-- Step 62: Gahrron's Withering
	-- {npc:1855} Tirion Fordring · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south from {npc:1855}'s hut to {area:201}. {npc:11078} (58) guards the cauldron.\nCareful: Soulwrath is level 58, a level over you here: clear the ghouls around the cauldron first and pull him alone."] = "",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["For {npc:11053} at {area:3197}, at the end of this guide"] = "Para la {npc:11053} en {area:3197}, al final de esta guía",

	-- Step 63: Marris Stead
	-- {zone:1423} Eastern Plaguelands · {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride east into the {zone:1423}: the {area:2260} is the farm north of the southern road, north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "",
	["Close enough to see the Blightcaller in front of the house"] = "",

	-- Step 64: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	-- was: ["{area:1943}: kill these as you meet them"] = "{area:1943}: mata a estos según los encuentres"
	["{zone:1423}: kill these as you meet them"] = "",
	-- {zone:1423} Eastern Plaguelands · {area:2268} Light's Hope Chapel
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Gargantuan Plaguebats = {npc:272342} Gargantuan Plaguebat
	["Ride east along the southern road across the {zone:1423} to {area:2268}: Plaguehound Runts and Plaguebats roam beside it.\nCareful: Gargantuan Plaguebats (60) fly among the smaller bats near the western border: take the Plaguebats of your level."] = "",

	-- Step 65: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath · {area:2264} Corin's Crossing
	["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "La siguiente tarea de {npc:11063}, en {area:2264}, está entre la Plaga de nivel 57-60: sáltala.",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, at the end of this ride: keep it"] = "",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast · {area:2261} Undercroft
	["{npc:11038}'s {npc:12250} is a group quest in the {area:2261} (a level 54 elite)."] = "",

	-- Step 66: Carlin Redpath: Heroes of Darrowshire
	-- {area:190} Hearthglen · {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	-- plural, as words: Haunting Visions = {npc:4472} Haunting Vision
	["The libram is inside {area:190} among elite Scarlet guards, and {item:12955} among Haunting Visions at {area:201}: a group quest."] = "",

	-- Step 67: Villains of Darrowshire
	-- {area:2623} Infectis Scar · {area:2624} Blackwood Lake
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["West into the middle of the zone: Marduk's sword lies in the {area:2623} and Horgus' skull at {area:2624}, north of it, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 68: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath
	["Back east to {npc:11063} at the chapel."] = "",

	-- Step 69: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Cabalga al noroeste hasta {area:2276}, en el borde de {area:2277}.",

	-- Step 70: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	-- was: ["{area:1943}: kill these as you meet them"] = "{area:1943}: mata a estos según los encuentres"
	["{area:2277}: kill these as you meet them"] = "",
	-- {area:2277} Plaguewood · {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Carrion Devourers = {npc:8605} Carrion Devourer
	["West through the {area:2277} to {area:2627}: fill the {item:15042} at the big termite mounds, and kill the Frenzied Plaguehounds and the Carrion Devourers on the way.\nCareful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "",

	-- Step 71: Augustus the Touched
	-- {npc:12384} Augustus the Touched · {area:2627} Terrordale · {npc:11140} Egan
	["{npc:12384} lives in the ruined hut in {area:2627}, and his receipt book lies in the ruined inn nearby. {npc:11140} stands by {npc:12384}' hut."] = "",

	-- Step 73: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {area:2626} Terrorweb Tunnel
	-- plural, as words: Crypt Fiends = {npc:8555} Crypt Fiend
	["Cross the river west to {npc:1855}'s hut.\nCareful: the short way from {area:2627} to {npc:1855} is the {area:2626}, whose south mouth opens by his hut: Crypt Fiends, Walkers, Horrors and Slayers (53-58) stand close together inside. Pull them one at a time, or ride round by the road outside it."] = "",

	-- Step 75: Tirion Fordring
	["Listen to his story"] = "Escucha su historia",

	-- Step 76: Tirion Fordring: Of Forgotten Memories
	-- {quest:5781} Of Forgotten Memories · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["{quest:5781} is a group quest: {npc:11886} (57, elite) and his adds in the {area:2261}."] = "",

	-- Step 77: Undercroft
	-- {area:2261} Undercroft
	["Cross the river south-east to the {area:2261}, the crypt in the south-west of the zone.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886} (57, elite)"] = "",

	-- Step 78: Tirion Fordring
	-- {quest:5845} Of Lost Honor · {area:2277} Plaguewood · {area:3197} Chillwind Camp
	["{quest:5845}'s symbol lies in the lake south of the {area:2277}: your group fetches it before the ride back to {area:3197}."] = "",

	-- Step 79: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1839} Scarlet High Clerist
	-- plural, as words: Scarlet Paladins = {npc:1834} Scarlet Paladin
	["Careful: Scarlet Paladins (55-56) and priests guard {item:12954} inside {area:190}'s town hall. They are elite, and a {npc:1839} (63, elite) stands near the book. Go in with your group; stay out of the Clerist's reach."] = "",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 80: Redpath's Shield
	-- {area:201} Gahrron's Withering
	["The shield lies east of the barn at {area:201}. Take your group around the barn to reach it."] = "",

	-- Step 81: Carlin Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["Back to {npc:11063} at {area:2268} with your group."] = "",

	-- Step 82: Eastern Plaguelands
	-- {area:2277} Plaguewood · {area:2268} Light's Hope Chapel
	["Ride to the lake south of the {area:2277}, north-west of {area:2268}."] = "",
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 83: Of Lost Honor
	["Underwater"] = "Bajo el agua",

	-- Step 84: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:3197} Chillwind Camp
	["West across the zone to {npc:1855}'s hut on the way back to {area:3197}."] = "",

	-- Step 85: Western Plaguelands
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp
	["Ride south-west through the {zone:1422} to {area:3197}."] = "",

	-- Step 86: Chillwind Camp
	["Dumah's next task sets a barrel down at Northridge, behind you now: skip it."] = "",

	-- Step 87: Flint Shadowmore
	-- {zone:1453} Stormwind
	["Highlord Bolvar in {zone:1453}, on the way out of this guide"] = "",

	-- Step 89: Stormwind City
	["Stormwind City"] = "",
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:1748}, in {object:2117}"] = "",

	-- Step 90: Stormwind
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone · {npc:10782} Royal Factor Bathrilor · {object:2096} Trade District · {npc:3520} Ol' Emma · {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["Without the flight to {zone:1453} at 56 earlier in this guide: {npc:10778}'s parcel goes to {npc:10782} in the {object:2096}, then {npc:3520} takes her own errand on the canals. {npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, behind you now: skip it."] = "",

	-- Step 91: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Vuela a {area:150}",

	-- Step 92: Boat to Theramore
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook
	["Take the boat to Theramore: {zone:2482}, the next guide, starts with the flight to {area:2255}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["After the farm's keys: the {object:177289} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "Tras las llaves de la granja: {object:177289} está justo al suroeste de la casa de labranza, y su señor de la caldera, a su lado, lleva la llave.",
	-- ["Andorhal Watches"] = "Relojes de Andorhal",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Vuelve al norte a {area:202}: ahora la caldera ofrece su propia tarea. Los necrófagos cercanos sueltan intensificadores somáticos.",
	-- ["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one, and {npc:9299} in {area:976} shows himself only to someone who has drunk one."] = "Vuelve al campamento de {npc:7775}, justo al sureste de {npc:7765}: la {item:11242} te da tres Elixires de Videre. Guárdalos: {npc:9298} se queda uno, y {npc:9299} en {area:976} solo se muestra a quien haya bebido uno.",
	-- ["Below ground"] = "Bajo tierra",
	-- ["Bones and equipment"] = "Huesos y equipo",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Compra un {item:13320} a {npc:11056} para la caldera de Piedramácula justo antes de ir: los aceleradores desaparecen a los 30 minutos.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Compra dos aceleradores arcanos más para las calderas de {area:202} y de Dalson, y ve directo: desaparecen a los 30 minutos.",
	-- ["Careful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "Cuidado: los Canes de peste demenciados son de nivel 57-58: atráelos de uno en uno.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Sube a la colina al oeste de {area:190} para ver el pueblo desde arriba.",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Cruza el río hacia el este hasta {area:2261}, la cripta del suroeste de la zona. El {object:177667} está dentro: la llave la lleva {npc:12248}, en el extremo noreste, que se hace en la siguiente guía.\nCuidado: con Mercutio vienen unos cuatro refuerzos no élite. Van caminando hasta la tumba en lugar de aparecer allí mismo.",
	-- ["Cross the river west to {npc:1855}'s hut."] = "Cruza el río hacia el oeste hasta la cabaña de {npc:1855}.",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Cruza el sur del cráter hasta {npc:9619}, junto a la rampa.",
	-- ["Diseased Wolves"] = "Lobos malsanos",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Los trituradores de arrastre excavan más al oeste; los tenazarios Latigosólido, cazadores Latigosólido y acechadores de piedra cazan en las mismas arenas.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Los artilleros de arrastre excavan en las dunas al noroeste del fuerte; los escórpidos Latigosólido y los arácnidos de arena deambulan por todas partes.",
	-- ["Eastern Pylon and the crate"] = "Torre oriental y el cajón",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Termina con {npc:9298} en {area:618}: guárdala",
	-- ["Ends with {npc:9298} in {zone:1452}: keep it"] = "Termina con {npc:9298} en {zone:1452}: guárdala",
	-- ["Escort {npc:9999}"] = "Escolta a {npc:9999}",
	-- ["Fly from {area:976} to {area:541}. {npc:8737} stands at the back of the refuge; {npc:9117} is in the cave behind him.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "Vuela de {area:976} a {area:541}. {npc:8737} está al fondo del refugio; {npc:9117} está en la cueva detrás de él.\n{npc:9999}, amigo de {npc:9997}, ha desaparecido.",
	-- ["Fly to Theramore"] = "Vuela a Theramore",
	-- ["Fly to {area:2268}"] = "Vuela a {area:2268}",
	-- ["Fly to {area:392}"] = "Vuela a {area:392}",
	-- ["Fly to {area:392}."] = "Vuela a {area:392}.",
	-- ["Fly to {area:976}"] = "Vuela a {area:976}",
	-- ["For the druids of {zone:1457}: keep it"] = "Para los druidas de {zone:1457}: guárdala",
	-- ["For {area:1377}: keep it"] = "Para {area:1377}: guárdala",
	-- ["For {area:3197}: keep it"] = "Para {area:3197}: guárdala",
	-- ["For {zone:1448}: keep it"] = "Para {zone:1448}: guárdala",
	-- ["For {zone:1451}: keep it"] = "Para {zone:1451}: guárdala",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Desde {area:392}, vuela a {area:2255} y cabalga al sur hasta {area:2250}.",
	-- ["From {area:702}, fly to {area:1116}."] = "Desde {area:702}, vuela a {area:1116}.",
	-- ["Hearth to {area:392} (bound there earlier on this guide), then fly on to {area:976}."] = "Usa la piedra de hogar para ir a {area:392} (la vinculaste antes en esta guía) y luego vuela a {area:976}.",
	-- ["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "El cráneo de Horgus está en {area:2624} y la espada de Marduk en {area:2623}, cada uno donde luchan fantasmas; los canes de la Peste adultos cazan en las llanuras de en medio.",
	-- ["Into {zone:1451}"] = "Hacia {zone:1451}",
	-- ["MacDonnell's next task, {area:201}'s cauldron, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "La siguiente tarea de MacDonnell, el caldero de {area:201}, espera a la etapa de las Tierras de la Peste de la guía de {zone:1451}: cógela entonces.",
	-- ["More watches"] = "Más relojes",
	-- ["North to the refuge, for the quests the first Un'Goro visit left: {npc:9618} stands just outside and {npc:9117} in the cave at the back; the expedition's other three wait for your next stop here."] = "Al norte hasta el refugio, para las misiones que dejó la primera visita a Un'Goro: {npc:9618} está justo fuera y {npc:9117} en la cueva del fondo; los otros tres de la expedición esperan a tu próxima parada aquí.",
	-- ["Northern Pylon"] = "La Torre del Norte",
	-- ["On {npc:7583}"] = "Con {npc:7583}",
	-- ["Ranshalla in {zone:1452}: keep it"] = "Ranshalla en {zone:1452}: guárdala",
	-- ["Ride back south to the camp."] = "Vuelve al sur hasta el campamento.",
	-- ["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Cabalga de vuelta al suroeste hasta la torre de {area:2742} en {area:2738}; súbela y mata a los emboscadores que surgen por el objeto incrustado.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Vuelve a {area:3197} y vuela a {area:150}, toma el barco a {area:442} y vuela a {area:702}; el portal sube a {zone:1457}.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Baja por la rampa al cráter: {npc:9619} acampa al pie.",
	-- ["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Cabalga al este hasta el río de la frontera: {npc:1855} vive en una cabaña pequeña en la orilla.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Cabalga al este hasta la torre de {area:2742} en {area:2738}; súbela y mata a los emboscadores que surgen por el objeto incrustado.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Cabalga al este hasta {area:1943}, donde el robot está entre los gorilas. No entres en la cueva profunda de allí.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Cabalga al este hasta {area:537}, súbela y usa {npc:10541} en las grietas de lava cerca de la cima.",
	-- ["Ride east to {npc:13220}."] = "Cabalga al este hasta {npc:13220}.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Cabalga al norte por el lado este hasta la meseta de los gorilas. {npc:9622}, un gorila de nivel 55, está en su cueva más profunda: limpia primero los gorilas de la entrada.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cabalga al norte hasta {area:2627}. {npc:12384} vive en la choza en ruinas y su libro de recibos está en la posada en ruinas cercana.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\nCareful: the Frenzied Plaguehounds north-east of the hut are 57-58, a level or two over you: pull them one at a time."] = "Cabalga al norte hasta {area:2627}. {npc:12384} vive en la choza en ruinas y su libro de recibos está en la posada en ruinas cercana.\nCuidado: los Canes de peste demenciados al noreste de la choza son de nivel 57-58, uno o dos niveles por encima de ti: atráelos de uno en uno.",
	-- ["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Cabalga al noroeste hasta la granja de Dalson. El diario está en el granero; un esqueleto errante lleva la llave del retrete, y {npc:10836} espera en el retrete con la llave del armario.",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Cabalga al sur hasta {area:201}, donde {npc:11078} protege la caldera.",
	-- ["Ride south-west to the camp."] = "Cabalga al suroeste hasta el campamento.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Cabalga al suroeste hasta el campamento de {npc:7771} en el {area:1938}.",
	-- ["Ride west along the road to the hot springs."] = "Cabalga al oeste por el camino hasta las fuentes termales.",
	-- ["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Cabalga al oeste hasta las Ruinas de Viento Cuervo: {npc:7774} se esconde en el pequeño edificio redondo del fondo. Abre el cofre junto a ella para obtener {item:9189}: dura 15 minutos, igual que la misión.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Cabalga al oeste pasando {area:541} y baja al sur por el lado oeste hasta {area:543}: el goblin {npc:10302} está junto al agua.",
	-- ["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Cabalga al oeste hasta {area:2627}. Los cachorros de can de la Peste ({npc:8596}), los murcipestes ({npc:8600}) y las larvas carroñeras ({npc:8603}) rondan sus bosques; llena la {item:15042} en los grandes termiteros y mata a los canes de la Peste demenciados ({npc:8598}) más al norte.",
	-- ["Scare {npc:7583} with {item:12928}"] = "Asusta a {npc:7583} con {item:12928}",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Los despellejadores esqueléticos y los necrófagos esclavizantes rondan los campos al norte del campamento; toda la Plaga de aquí suelta piedras de la Plaga.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Hay pequeñas cajas fuertes entre los escombros de todo Andorhal; cada una tiene un reloj.",
	-- ["Take the boat to the mainland and ride north-east past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "Coge el barco hasta el continente y cabalga al noreste dejando atrás {area:1119} hasta el campamento de {npc:7775}. Prepara el {item:11243} a partir de una {item:11242}: acepta su encargo para conseguir uno.",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Toma el barco al continente y cabalga al noreste hasta el campamento de {npc:14637} junto a {area:1119}.",
	-- ["Temple of the Moon"] = "Templo de la Luna",
	-- ["Ten {item:11040} from the {item:11020}"] = "Diez {item:11040} de la {item:11020}",
	-- ["The Gorishi hive"] = "La colmena Gorishi",
	-- ["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Las bestias de alquitrán y los señores del alquitrán se revuelcan en {area:538}, al sur del refugio, en la bajada al cráter.",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Ahora la caldera ofrece su propia tarea; los esqueletos de alrededor sueltan agitadores óseos.",
	-- ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "La caldera está en {area:202}, junto a la granja de {npc:10739}.",
	-- ["The crater"] = "El cráter",
	-- ["The fields"] = "Los campos",
	-- ["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Los gorilas viven en {area:1943}, justo al este de la torre: consigue ahora las pieles para {npc:9619}, ya que estás aquí arriba. No entres en la cueva más profunda: {npc:9622} es de nivel 55.\nCuidado: los gorilas de Un'Goro (nivel 50-51) piden ayuda a los aliados en un radio de 20 m cuando bajan al 25% de salud. Hay una cueva llena de simios en la zona, y luchar allí atrae a muchos enemigos.",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "La siguiente guía empieza aquí, en {area:392}, y vuela a {area:976}.",
	-- ["The pelts come from the gorillas on {area:1943}"] = "Las pieles salen de los gorilas de {area:1943}",
	-- ["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "La torre está en los acantilados del este, sobre la guarida de {npc:9684}; el {item:11113} de la expedición está en el campamento abandonado de la jungla oriental.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}."] = "La torre está en la ladera al este del refugio. Los {npc:9166} sobrevuelan las laderas de alrededor: cuentan para {npc:9997}.",
	-- ["The pylon stands on the western cliffs."] = "La torre está en los acantilados del oeste.",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Los gigantes encogidos rondan {area:1119}; los elementales marinos vadean la costa al oeste.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Los druidas y centinelas torturados rondan el poblado en ruinas al suroeste de {npc:13220}.",
	-- ["The wooden sign beside {npc:9997}"] = "El cartel de madera junto a {npc:9997}",
	-- ["The {area:2742} tower"] = "La torre de {area:2742}",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "La {item:11242} crece dentro de un edificio en ruinas al norte de {npc:7765}: entra por la brecha de su muro desde la cornisa de al lado.",
	-- ["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "El {item:280417} está a poca distancia al oeste del campamento de {npc:9619}.",
	-- ["Umber in {area:493}: keep it"] = "Umber en {area:493}: guárdala",
	-- ["Umber in {zone:1450}: keep it"] = "Umber en {zone:1450}: guárdala",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Usa el {item:12627} junto a los silos de grano para hacer salir parásitos temporales. {quest:5154} es uno de los tomos mohosos del ayuntamiento. Todos los esqueletos del pueblo sueltan {quest:5537}.",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "Usa el {item:12627} junto a los silos de grano para hacer salir Parásitos temporales. {quest:5154} es uno de los tomos mohosos del ayuntamiento. Todos los esqueletos del pueblo sueltan {quest:5537}.\nCuidado: los Parásitos temporales son de nivel 55-57, y Señores de la guerra esqueléticos y Gólems de carne (57, élites) recorren las calles: haz salir a los parásitos junto a los silos, de uno en uno, y deja pasar a los élites.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Usa la {item:12815} al pie de cada una de las cuatro atalayas del borde de Andorhal, al norte del campamento.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Usa la {item:12815} al pie de cada una de las cuatro atalayas del borde de Andorhal, al norte del campamento.\nCuidado: Señores de la guerra esqueléticos y Gólems de carne (57, élites) recorren las calles de Andorhal, y el {npc:7572} (59, élite) deambula entre Andorhal y Cresta Norte: quédate en las torres del borde del pueblo y déjalos pasar.",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Entra en {area:1769} y toma el ramal del túnel de {area:493} hasta {area:2361}.",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Entra en {area:1769} y toma el ramal del túnel de {zone:1450} hasta {area:2361}.",
	-- ["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Al oeste cruzando el sur del cráter: hay huesos de dinosaurio en el suelo del suroeste, entre los estegodontes: son élite, así que recoge los huesos a su alrededor y consigue el resto de los diemetradones. El {item:11112} de la expedición está en la jungla del suroeste.",
	-- ["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "Al oeste por el sur del cráter: lo llena la colmena Gorishi. Usa el vial de raspado en un criadero, una cámara con larvas colgando.",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Te perdiste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.",
	-- ["Zapped giants and sea elementals"] = "Gigantes machacados y elementales marinos",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "mata a {npc:1796} en {area:202}, {zone:1422}",
	-- ["their trainers are in {zone:1457} too"] = "sus instructores también están en {zone:1457}",
	-- ["{area:1943}: kill these as you meet them"] = "{area:1943}: mata a estos según los encuentres",
	-- ["{area:200} cauldron"] = "Caldera de {area:200}",
	-- ["{area:201} cauldron"] = "Caldera de {area:201}",
	-- ["{area:976} flight master"] = "Maestro de vuelo de {area:976}",
	-- ["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "El {item:12954} está en el ayuntamiento de {area:190}, al oeste de {npc:1855}: los guardias escarlata están muy juntos.",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "El {item:12955} está al este del granero de {area:201}.",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}, de {npc:11056}",
	-- ["{item:14613}, from {npc:11886} (57, elite): grouping up is advised"] = "{item:14613}, de {npc:11886} (57, élite): se recomienda ir en grupo",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: su escolta llega más adelante en la ruta",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} espera en la posada en ruinas del lado oeste de Andorhal.",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} está junto a la granja de {area:202}, al noreste de los campos.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "El fantasma de {npc:10778} vaga junto a la casa de {area:199}, al oeste de {area:200}; su paquete está dentro.",
	-- ["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} y {npc:7740} están junto al Templo de la Luna; llena el {item:11682} en el pozo de la luna de dentro.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path now; the {zone:2482} guide flies to {area:493}, and the {zone:1451} guide comes back here."] = "{npc:10897}, el maestro de vuelo de {area:493}, está al sur del lago, fuera de {area:2361}: aprende ahora la ruta de vuelo; la guía de {zone:2482} vuela a {area:493} y la guía de {zone:1451} vuelve aquí.",
	-- ["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "La granja de {npc:10927} está en la colina al este del campamento; el monumento de {npc:10936} está justo al norte.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, junto a las tumbas al sur de la capilla",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} protege la caldera de {area:199}, al oeste de Andorhal.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} está junto a la cabaña de Augustus en {area:2627}.",
	-- ["{npc:11610}'s next task, {npc:11613} and {npc:11611}, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "La siguiente tarea de {npc:11610}, {npc:11613} y {npc:11611}, espera a la etapa de las Tierras de la Peste de la guía de {zone:1451}: cógela entonces.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} recorre el aserradero Crestanorte al este de {npc:11610}; {npc:11611} protege la torre del acceso sur de {area:190}.\nCuidado: hay guardias en la base de la torre y otro más patrulla a su alrededor. Acaba con ellos antes de enfrentarte a Durgen para que no se unan al combate.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: las termitas vienen más tarde, en {area:2627}",
	-- ["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} es élite: conviene ir en grupo",
	-- ["{npc:15189}'s and {npc:15191}'s next tasks (the Stonelash scorpids and the Dredge Crushers) wait for the {zone:1451} guide's {area:3425} stop: take them then."] = "Las siguientes tareas de {npc:15189} y {npc:15191} (los escórpidos Latigopétreo y los trituradores de arrastre) esperan a la parada en {area:3425} de la guía de {zone:1451}: acéptalas entonces.",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, en las tiendas de la Alianza",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} es élite: conviene ir en grupo. Protege su filacteria en el centro de Andorhal.",
	-- ["{npc:5411} in {area:976}: keep it"] = "{npc:5411} en {area:976}: guárdala",
	-- ["{npc:5901}, on the coast north of town"] = "{npc:5901}, en la costa al norte del pueblo",
	-- ["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: guárdala para {area:976}",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "El campamento de {npc:7775} está al norte de {area:1119}. Prepara el {item:11243} a partir de una {item:11242}: acepta su encargo para conseguir uno.",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "El campamento de {npc:7775} está al norte de {area:1119}. Vende el {item:11243} cuando tiene su cebo.",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: guárdala para {area:440}",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: guárdala para {zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496}: guárdala para Un'Goro; dentro",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}, en {area:1658}",
	-- ["{npc:9299} in {area:976}: keep it"] = "{npc:9299} en {area:976}: guárdala",
	-- ["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} es un fantasma en el cementerio justo al este del pueblo: bebe un {item:11243} allí, lo que te mata, libera tu espíritu y habla con él como fantasma. Luego corre de vuelta a tu cuerpo para resucitar: la lápida está cerca.",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} espera en el cementerio justo al este del pueblo; la lápida está cerca.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "La guarida de {npc:9684} está en la jungla al norte de {npc:9619}, bajo los acantilados del este: usa {item:11568} allí. {npc:9684} es de nivel 56: empieza con la salud al máximo.",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado en la ladera sureste de {area:537}, en el centro del cráter.",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} está en {area:392}",
	-- ["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, si aún la llevas de la primera visita",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} en {area:493}: guárdala",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} en {zone:1450}: guárdala",
	-- ["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, si un ravasaurio ha soltado la escama desde la primera visita",
	-- ["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, donde se entrena en la siguiente guía, no tiene instructor de druidas",
}
