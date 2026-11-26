-- French (frFR): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands
	["Western & {zone:1423}"] = "Maleterres de l’ouest & {zone:1423}",

	-- Step 1: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- {zone:1457} Darnassus · {zone:1450} Moonglade · {zone:1455} Ironforge · {area:3197} Chillwind Camp
	["The {zone:1457}, {zone:1450} and {zone:1455} stops are for players coming from the previous guides with their quests; opened with none of those quests in the log, the guide starts at {area:3197}."] = "Les arrêts {zone:1457}, {zone:1450} et {zone:1455} sont pour les joueurs qui viennent des guides précédents avec leurs quêtes ; ouvert sans aucune de ces quêtes dans le journal, le guide commence à {area:3197}.",

	-- Step 2: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "Le vol atterrit au {area:702}. {npc:7916} se tient à quelques pas au nord-ouest du maître de vol.",
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
	["{npc:4217}, upstairs"] = "{npc:4217}, à l'étage",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade · {zone:2482} Mount Hyjal
	["{quest:6762} in {zone:1450}: {zone:2482}'s {zone:1450} errand takes you to her, in the next guide; keep it"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} n'a pas de maître des druides",

	-- Step 9: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portail vers {zone:1438}",

	-- Step 10: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maître de vol du {area:702}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 12: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 13: Laris Geardawdle
	-- {npc:9616} Laris Geardawdle
	["{npc:9616}' next task fills his jars in Un'Goro, behind the route now: skip it."] = "",

	-- Step 14: Ironforge
	-- {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["{npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:15187} Cenarion Emissary Jademoon · {npc:15191} Windcaller Proudhorn · {zone:1451} Silithus
	["{npc:15187}, by the flight master where you land: for {npc:15191} in {zone:1451}, on the last guide; keep it"] = "",
	-- {npc:13843} Lieutenant Rotimer · {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13843}: for {npc:13841}, on the way to {area:3197}"] = "",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "{item:2592}, depuis vos sacs",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "{item:4306}, depuis vos sacs",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "{item:4338}, depuis vos sacs",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "{item:14047}, depuis vos sacs",

	-- Step 15: Courier Hammerfall
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10877} Courier Hammerfall · {zone:1455} Ironforge · {npc:10838} Commander Ashlam Valorfist
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10877} walks the ring of {zone:1455} and sends you to {npc:10838}, whose camp this guide visits next. Chillwind's chain starts with it."] = "",

	-- Step 16: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prendre un vol pour {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 17: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them."] = "",

	-- Step 18: Lieutenant Haggerdin
	-- {npc:13841} Lieutenant Haggerdin · {area:3197} Chillwind Camp
	["{npc:13841} camps beside the road north to {area:3197}."] = "",

	-- Step 19: Chillwind Camp: Clear the Way
	-- {zone:1428} Burning Steppes · {area:3197} Chillwind Camp · {npc:10838} Commander Ashlam Valorfist · {quest:5092} Clear the Way
	["Without the {zone:1428} guide's {area:3197} quests: {npc:10838} stands in the middle of the camp. His {quest:5092} opens the camp's chain."] = "",

	-- Step 20: Sorrow Hill: Clear the Way
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls (50) roam the fields just north of the camp.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled."] = "",

	-- Step 21: Chillwind Camp: the cauldrons
	-- {area:3197} Chillwind Camp
	["{area:3197}: the cauldrons"] = "",
	-- {npc:11053} High Priestess MacDonnell
	["Back to the camp: Valorfist, then {npc:11053} beside him."] = "",
	-- {area:199} Felstone Field
	["{area:199}'s cauldron, later in this guide"] = "",

	-- Step 22: Chillwind Camp
	["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Pureheart, Dumah, Valorfist et MacDonnell se tiennent vers le centre du camp, près du maître de vol.",
	-- {npc:11616} Nathaniel Dumah · {area:2277} Plaguewood
	-- was: ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616} : les termites viendront plus tard, à {area:2627}"
	["{npc:11616}: the termites come later, in the {area:2277}"] = "",
	-- {npc:10838} Commander Ashlam Valorfist · {area:199} Felstone Field
	["{npc:10838}: the watchtowers stand around Andorhal, on the way to {area:199}"] = "",

	-- Step 23: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission
	["No {quest:5401} yet? Pureheart gives you one here: the scourgestone quests need it."] = "",

	-- Step 24: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Les tours de guet d'Andorhal",
	-- {item:12815} Beacon Torch · {area:199} Felstone Field · {npc:7572} Fallen Hero of the Horde
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	-- was: ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Utilisez la {item:12815} au pied de chacune des quatre tours de guet en bordure d'Andorhal, au nord du camp.\nAttention : des Chefs de guerre squelettes et des Golems de chair (57, élites) arpentent les rues d'Andorhal, et le {npc:7572} (59, élite) erre entre Andorhal et Northridge : restez près des tours en bordure de la ville et laissez-les passer."
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp, on the way to {area:199}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marquer {npc:10902} avec la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marquer {npc:10903} avec la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marquer {npc:10904} avec la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marquer {npc:10905} avec la {item:12815}",

	-- Step 25: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Chaudron de {area:199}",
	-- {area:199} Felstone Field · {npc:11075} Cauldron Lord Bilemaw · {npc:10778} Janice Felstone · {zone:1453} Stormwind
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["West of Andorhal to {area:199}: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54).\n{npc:10778}'s ghost wanders by the farmhouse at the field's edge, upstairs; her parcel lies inside the house: take it for {zone:1453}, at the end of this guide."] = "",
	-- {npc:10778} Janice Felstone
	["{npc:10778}, upstairs in the farmhouse"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "{object:175894}, à l'intérieur",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Pour {zone:1453} : gardez-la",

	-- Step 26: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Back to {area:3197}."] = "",
	-- {area:200} Dalson's Tears
	["The cauldron is at {area:200}"] = "",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} est un élite de niveau 61",

	-- Step 27: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197} : tuez-les au passage",
	-- {quest:5401} Argent Dawn Commission · {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones while you wear the {quest:5401} (equip it as a trinket first).\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Des Écorcheurs squelettes et des Goules écumantes parcourent les champs au nord du camp ; tout le Fléau ici lâche des Pierres du Fléau tant que vous portez le {quest:5401} (équipez-le d'abord comme bijou).\nAttention : ces morts-vivants vous repèrent de loin, et les autres morts-vivants proches se joignent au combat quand vous en attirez un.\nAttention : l'{npc:10411} (3 apparitions, réapparition en 15 min) devient invisible hors combat et appelle des Gargouilles Aile-de-roc dès qu'un combat commence.",

	-- Step 28: Marlene Redpath
	-- {area:3197} Chillwind Camp · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {quest:5142} Little Pamela · {area:2262} Darrowshire
	["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the ghost in {area:2262}, the next stop."] = "",
	-- {npc:10927} Marlene Redpath · {area:2262} Darrowshire
	["{npc:10927}: keep it for {area:2262}"] = "{npc:10927} : gardez-la pour {area:2262}",

	-- Step 29: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Vers {zone:1423}",
	-- {zone:1422} Western Plaguelands
	["Follow the southern road east out of the {zone:1422}."] = "",

	-- Step 30: Pamela Redpath
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["The ruins of {area:2262} lie south of the road. {npc:10926}'s ghost plays by the ruined house at the south end."] = "",

	-- Step 31: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "Poupée de {npc:10926}",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Les trois morceaux de la poupée sont dans les maisons en ruine de {area:2262} ; en ramasser un peut faire surgir des fantômes. Assemblez-les pour obtenir la poupée.",
	-- {item:12886} Pamela's Doll's Head
	["{item:12886}; inside"] = "{item:12886} ; à l'intérieur",
	-- {item:12888} Pamela's Doll's Right Side
	["{item:12888}; inside"] = "{item:12888} ; à l'intérieur",

	-- Step 32: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, back in the {zone:1422}: keep it"] = "",
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["{npc:11063} at {area:2268}, on this guide's second ride east: keep it"] = "",

	-- Step 33: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["Ride back west along the road to {npc:10927}'s farmhouse; {npc:10936}'s monument is just north of it."] = "",
	["Upstairs"] = "À l'étage",
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal, later on this loop: keep it"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, au monument",

	-- Step 34: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {npc:10927} Marlene Redpath
	["{npc:10739} stands by the farm at the {area:202}, north of {npc:10927}."] = "",
	["Inside"] = "À l'intérieur",

	-- Step 35: Writhing Haunt: kill these as you meet them
	-- {area:202} Writhing Haunt
	["{area:202}: kill these as you meet them"] = "{area:202} : tuez-les au passage",
	-- {item:12841} Invader's Scourgestone · {quest:5401} Argent Dawn Commission
	["{item:12841}: wear the {quest:5401} while you kill"] = "{item:12841} : portez le {quest:5401} pendant que vous tuez",

	-- Step 37: Diseased Grizzlies
	["Diseased Grizzlies"] = "Grizzlys malades",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The Diseased Grizzlies (55-56) roam the woods around the {area:202}, east and north of {npc:10739}."] = "",

	-- Step 38: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {zone:1457} Darnassus
	["{npc:10739}' next task goes to the druids of {zone:1457}, behind the route now: skip it."] = "",

	-- Step 39: Dalson's Tears
	-- {npc:10836} Farmer Dalson · {npc:11152} The Scourge Cauldron
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key. {npc:11152} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924}, dans la ferme ; à l'intérieur",

	-- Step 40: Argent Officer Pureheart
	-- {area:3197} Chillwind Camp
	["Ride back south to {area:3197}."] = "",

	-- Step 42: Chillwind Camp
	-- {area:200} Dalson's Tears
	["Ride back south from {area:200} to the camp."] = "",
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} (from level 55)"] = "",
	["The skeletons of Andorhal, next on this guide"] = "",

	-- Step 43: Chromie
	-- {npc:10667} Chromie
	["North to {npc:10667} in the ruined inn on the west side of Andorhal."] = "",

	-- Step 44: Andorhal
	["Andorhal"] = "Andorhal",
	-- {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments · {npc:1852} Araj the Summoner
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["{quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk the streets: let them pass.\n{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{quest:5154} est l'un des tomes moisis de l'hôtel de ville. Chaque squelette de la ville lâche {quest:5537}.\nAttention : des seigneurs de guerre squelettes ({npc:1788}) et des golems de chair ({npc:1805}) (57, élites) arpentent les rues : laissez-les passer.\n{npc:1852} est élite : il est conseillé de grouper. Il garde son phylactère au centre d'Andorhal.",

	-- Step 45: Andorhal's grain silos
	["Andorhal's grain silos"] = "Les silos à grain d'Andorhal",
	-- {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord · Flesh Golems = {npc:1805} Flesh Golem
	["Use the {item:12627} by each grain silo on the north side of town to draw out Temporal Parasites, one silo after another.\nCareful: the Temporal Parasites are 55-57: draw them out one silo at a time, away from the Skeletal Warlords and Flesh Golems (57, elites) in the streets."] = "Utilisez {item:12627} près de chaque silo à grain au nord de la ville pour faire sortir des parasites temporels ({npc:10717}), un silo après l'autre.\nAttention : les parasites temporels sont 55-57 : faites-les sortir un silo à la fois, loin des seigneurs de guerre squelettes ({npc:1788}) et des golems de chair ({npc:1805}) (57, élites) dans les rues.",

	-- Step 46: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, à {area:2268} : gardez-la",

	-- Step 47: Sorrow Hill: kill these as you meet them
	-- was: ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "{npc:1852} est élite : mieux vaut être en groupe. Il garde son phylactère au milieu d'Andorhal.\nDe petits coffrets reposent dans les décombres partout dans Andorhal ; chacun contient une montre.\nAttention : des goules et des squelettes se tiennent souvent près des coffrets et attaquent quand vous approchez. Les goules brûlantes blessent aussi tout ce qui est à proximité et rompent le camouflage."
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 49: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Chaudron de {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	-- was: ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Le chaudron se trouve à {area:202}, près de la ferme de {npc:10739}."
	["The cauldron sits at the {area:202}, by {npc:10739}' farm, east of Andorhal."] = "",

	-- Step 50: Chillwind Camp
	-- {area:201} Gahrron's Withering
	["{area:201}'s cauldron, on this guide's ride north-east"] = "",
	-- {area:976} Gadgetzan
	["Arbington's next task goes to {area:976}, behind the route now: skip it."] = "",

	-- Step 51: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone
	["Fly to {zone:1453} for Highlord Bolvar's errand for SI:7 and {npc:10778}'s parcel, then straight back."] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Maître de vol de {area:3197}",

	-- Step 52: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, au SI:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}, on the flight back"] = "",

	-- Step 53: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14722} prend soixante Étoffes de soie, soixante Étoffes de tisse-mage et soixante {item:14047} : rendez ce que vous portez (ou achetez à l'hôtel des ventes), laissez le reste.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, qui se promène le long des canaux",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, out of the way now: skip it."] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, dans {object:2096}",

	-- Step 54: Fly to Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Fly to {area:3197}"] = "Prendre un vol pour {area:3197}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 55: Flint Shadowmore
	-- {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["The agents' remains lie at the {area:2260} in the {zone:1423}, on this guide's ride east"] = "",

	-- Step 56: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Remontez la route vers le nord jusqu'au Camp de bûcherons de la Crête du nord ; {npc:11610} se cache en bordure du camp.",

	-- Step 57: The Scarlet Crusade
	["The Scarlet Crusade"] = "La Croisade écarlate",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Les Médecins, Chasseurs, Chevaliers et Mages écarlates patrouillent dans le camp de bûcherons et sur la route de {area:190}.",

	-- Step 59: Radley and Durgen
	["Radley and Durgen"] = "Radley et Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	-- was: ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} parcourt le camp de Crête-du-Nord à l'est de {npc:11610} ; {npc:11611} garde la tour à l'approche sud de {area:190}.\nAttention : des gardes se tiennent au pied de la tour et un autre en fait le tour en patrouille. Éliminez-les avant d'engager Durgen pour qu'ils ne se joignent pas au combat."
	["{npc:11613} (56) walks the Northridge camp east of {npc:11610}; {npc:11611} (57) guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 60: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} se cache en bordure du camp de bûcherons.",

	-- Step 61: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Surplomb de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Montez sur la colline à l'ouest de {area:190} pour dominer la ville.\nAttention : les sentinelles postées à la porte peuvent détecter les joueurs camouflés. D'autres sentinelles se trouvent dans la ville, et un élite patrouille à proximité.",

	-- Step 63: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2277} Plaguewood · {area:2627} Terrordale
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank. His hunts are in the {area:2277} and {area:2627}, at the end of this guide's ride east."] = "",

	-- Step 64: Gahrron's Withering
	-- {npc:1855} Tirion Fordring · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south from {npc:1855}'s hut to {area:201}. {npc:11078} (58) guards the cauldron.\nCareful: Soulwrath is level 58, a level over you here: clear the ghouls around the cauldron first and pull him alone."] = "",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["For {npc:11053} at {area:3197}, at the end of this guide"] = "Pour la {npc:11053} au {area:3197}, à la fin de ce guide",

	-- Step 65: Marris Stead
	-- {zone:1423} Eastern Plaguelands · {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride east into the {zone:1423}: the {area:2260} is the farm north of the southern road, north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "",
	["Close enough to see the Blightcaller in front of the house"] = "",

	-- Step 66: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423} : tuez-les au passage",
	-- {zone:1423} Eastern Plaguelands · {area:2268} Light's Hope Chapel
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Gargantuan Plaguebats = {npc:272342} Gargantuan Plaguebat
	["Ride east along the southern road across the {zone:1423} to {area:2268}: Plaguehound Runts and Plaguebats roam beside it.\nCareful: Gargantuan Plaguebats (60) fly among the smaller bats near the western border: take the Plaguebats of your level."] = "",

	-- Step 67: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath · {area:2264} Corin's Crossing
	["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "La tâche suivante de {npc:11063}, à {area:2264}, se déroule au milieu du Fléau de niveau 57-60 : passez-la.",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, at the end of this ride: keep it"] = "",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast · {area:2261} Undercroft
	["{npc:11038}'s {npc:12250} is a group quest in the {area:2261} (a level 54 elite)."] = "",

	-- Step 68: Carlin Redpath: Heroes of Darrowshire
	-- {area:190} Hearthglen · {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	-- plural, as words: Haunting Visions = {npc:4472} Haunting Vision
	["The libram is inside {area:190} among elite Scarlet guards, and {item:12955} among Haunting Visions at {area:201}: a group quest."] = "",

	-- Step 69: Villains of Darrowshire
	-- {area:2623} Infectis Scar · {area:2624} Blackwood Lake
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["West into the middle of the zone: Marduk's sword lies in the {area:2623} and Horgus' skull at {area:2624}, north of it, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "{item:12956} ; sous l'eau",

	-- Step 70: Light's Hope Chapel
	-- {npc:11063} Carlin Redpath
	["Back east to {npc:11063} at the chapel."] = "",

	-- Step 71: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Allez au nord-ouest jusqu'à {area:2276}, en bordure de {area:2277}.",

	-- Step 72: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277} : tuez-les au passage",
	-- {area:2277} Plaguewood · {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Carrion Devourers = {npc:8605} Carrion Devourer
	["West through the {area:2277} to {area:2627}: fill the {item:15042} at the big termite mounds, and kill the Frenzied Plaguehounds and the Carrion Devourers on the way.\nCareful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "",

	-- Step 73: Augustus the Touched
	-- {npc:12384} Augustus the Touched · {area:2627} Terrordale · {npc:11140} Egan · {npc:16184} Nerubian Overseer · {area:2626} Terrorweb Tunnel
	["{npc:12384} lives in the ruined hut in {area:2627}, and his receipt book lies in the ruined inn nearby. {npc:11140} stands by {npc:12384}' hut.\nCareful: a {npc:16184} (60, elite) walks {area:2627} and the {area:2626} south-west of it. Look for him before you ride in, and wait for him to pass."] = "",

	-- Step 75: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {area:2626} Terrorweb Tunnel
	-- plural, as words: Crypt Fiends = {npc:8555} Crypt Fiend
	["Cross the river west to {npc:1855}'s hut.\nCareful: the short way from {area:2627} to {npc:1855} is the {area:2626}, whose south mouth opens by his hut: Crypt Fiends, Walkers, Horrors and Slayers (53-58) stand close together inside. Pull them one at a time, or ride round by the road outside it."] = "",

	-- Step 77: Tirion Fordring
	["Listen to his story"] = "Écouter son histoire",

	-- Step 78: Tirion Fordring: Of Forgotten Memories
	-- {quest:5781} Of Forgotten Memories · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["{quest:5781} is a group quest: {npc:11886} (57, elite) and his adds in the {area:2261}."] = "",

	-- Step 79: Undercroft
	-- {area:2261} Undercroft
	["Cross the river south-east to the {area:2261}, the crypt in the south-west of the zone.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886} (57, elite)"] = "",

	-- Step 80: Tirion Fordring
	-- {quest:5845} Of Lost Honor · {area:2277} Plaguewood · {area:3197} Chillwind Camp
	["{quest:5845}'s symbol lies in the lake south of the {area:2277}: your group fetches it before the ride back to {area:3197}."] = "",

	-- Step 81: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1839} Scarlet High Clerist
	-- plural, as words: Scarlet Paladins = {npc:1834} Scarlet Paladin
	["Careful: Scarlet Paladins (55-56) and priests guard {item:12954} inside {area:190}'s town hall. They are elite, and a {npc:1839} (63, elite) stands near the book. Go in with your group; stay out of the Clerist's reach."] = "",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "{item:12954} ; à l'intérieur",

	-- Step 82: Redpath's Shield
	-- {area:201} Gahrron's Withering
	["The shield lies east of the barn at {area:201}. Take your group around the barn to reach it."] = "",

	-- Step 83: Carlin Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["Back to {npc:11063} at {area:2268} with your group."] = "",

	-- Step 84: Eastern Plaguelands
	-- {area:2277} Plaguewood · {area:2268} Light's Hope Chapel
	["Ride to the lake south of the {area:2277}, north-west of {area:2268}."] = "",
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "Le lac pour {quest:5845}",

	-- Step 85: Of Lost Honor
	["Underwater"] = "Sous l'eau",

	-- Step 86: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:3197} Chillwind Camp
	["West across the zone to {npc:1855}'s hut on the way back to {area:3197}."] = "",

	-- Step 87: Western Plaguelands
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp
	["Ride south-west through the {zone:1422} to {area:3197}."] = "",

	-- Step 88: Chillwind Camp
	["Dumah's next task sets a barrel down at Northridge, behind you now: skip it."] = "",

	-- Step 89: Flint Shadowmore
	-- {zone:1453} Stormwind
	["Highlord Bolvar in {zone:1453}, on the way out of this guide"] = "",

	-- Step 91: Stormwind City
	["Stormwind City"] = "Cité de Hurlevent",
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:1748}, in {object:2117}"] = "",

	-- Step 92: Stormwind
	-- {zone:1453} Stormwind · {npc:10778} Janice Felstone · {npc:10782} Royal Factor Bathrilor · {object:2096} Trade District · {npc:3520} Ol' Emma · {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["Without the flight to {zone:1453} at 56 earlier in this guide: {npc:10778}'s parcel goes to {npc:10782} in the {object:2096}, then {npc:3520} takes her own errand on the canals. {npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["Emma's charm goes back to {npc:10778} in the {zone:1422}, behind you now: skip it."] = "",

	-- Step 93: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",

	-- Step 94: Boat to Theramore
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook
	["Take the boat to Theramore: {zone:2482}, the next guide, starts with the flight to {area:2255}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["After the farm's keys: the {object:177289} stands just south-west of the farmhouse, and its Cauldron Lord beside it carries the key."] = "Après les clés de la ferme : le {object:177289} se trouve juste au sud-ouest de la ferme, et son Seigneur du Chaudron, à côté, porte la clé.",
	-- ["Andorhal Watches"] = "Montres d'Andorhal",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Retournez au nord à {area:202} : le chaudron propose maintenant sa propre tâche. Les goules alentour lâchent des Intensificateurs somatiques.",
	-- ["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one, and {npc:9299} in {area:976} shows himself only to someone who has drunk one."] = "Retournez au camp de {npc:7775}, juste au sud-est de {npc:7765} : la {item:11242} vous rapporte trois Élixirs de Videre. Gardez-les : {npc:9298} en prend un, et {npc:9299} à {area:976} ne se montre qu'à qui en a bu un.",
	-- ["Below ground"] = "Sous terre",
	-- ["Boat to {area:1108}"] = "Bateau pour {area:1108}",
	-- ["Bones and equipment"] = "Os et équipement",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Achetez un {item:13320} à {npc:11056} pour le chaudron de Felstone, juste avant de partir : les catalyseurs disparaissent au bout de 30 minutes.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Achetez deux autres Catalyseurs des arcanes pour les chaudrons de {area:202} et des Dalson, et allez-y directement : ils disparaissent au bout de 30 minutes.",
	-- ["Careful: the Frenzied Plaguehounds are 57-58: pull them one at a time."] = "Attention : les Chiens pestiférés frénétiques sont 57-58 : attirez-les un par un.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Montez sur la colline à l'ouest de {area:190} pour observer la ville.",
	-- ["Collie is up the hill behind it."] = "Collie est en haut de la colline derrière.",
	-- ["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "En arrivant de {zone:1451}, {area:543} se trouve juste à l'entrée du cratère : le gobelin {npc:10302} est assis au bord de l'eau.",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Traversez la rivière vers l'est jusqu'au {area:2261}, la crypte au sud-ouest de la zone. {object:177667} est à l'intérieur : sa clé est sur {npc:12248}, tout au nord-est, à faire dans le guide suivant.\nAttention : environ quatre renforts non élites accompagnent Mercutio. Ils marchent jusqu'à la tombe au lieu d'apparaître sur place.",
	-- ["Cross the river west to {npc:1855}'s hut."] = "Traversez la rivière vers l'ouest jusqu'à la cabane de {npc:1855}.",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Traversez le sud du cratère jusqu'à {npc:9619}, près de la rampe.",
	-- ["Diseased Wolves"] = "Loups malades",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Les Écraseurs térébrants creusent plus à l'ouest ; les Pinceurs Cinglepierre, Écorcheurs Cinglepierre et Traqueuses des rochers chassent sur les mêmes sables.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Les Frappeurs térébrants creusent les dunes au nord-ouest du fort ; les Scorpides Cinglepierre et les Glisseuses du sable rôdent tout autour.",
	-- ["Eastern Pylon and the crate"] = "Pylône est et la caisse",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Se termine auprès de {npc:9298} au {area:618} : gardez-la",
	-- ["Ends with {npc:9298} in {zone:1452}: keep it"] = "Se termine auprès de {npc:9298} au {zone:1452} : gardez-la",
	-- ["Escort {npc:9999}"] = "Escorter {npc:9999}",
	-- ["Fly from {area:976} to {area:541}. {npc:8737} stands at the back of the refuge; {npc:9117} is in the cave behind him.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "Prenez un vol de {area:976} pour {area:541}. {npc:8737} se tient au fond du refuge ; {npc:9117} est dans la grotte derrière lui.\nL'ami de {npc:9997}, {npc:9999}, a disparu.",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; J.D.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "Prenez un vol de {area:976} pour {area:541}. La hutte de {npc:8737} se trouve aux {area:538}, à l'ouest du refuge ; J.D.\nL'ami de {npc:9997}, {npc:9999}, a disparu.",
	-- ["Fly to Theramore"] = "Volez jusqu'à Theramore",
	-- ["Fly to {area:2255}"] = "Prendre un vol pour {area:2255}",
	-- ["Fly to {area:2268}"] = "Prendre un vol pour {area:2268}",
	-- ["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- ["Fly to {area:392}."] = "Volez jusqu'à {area:392}.",
	-- ["Fly to {area:541}"] = "Prendre un vol pour {area:541}",
	-- ["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Suivez la route vers le sud-ouest à la sortie du col jusqu'à {area:3425}.",
	-- ["For the druids of {zone:1457}: keep it"] = "Pour les druides de {zone:1457} : gardez-la",
	-- ["For {area:1377}: keep it"] = "Pour {area:1377} : gardez-la",
	-- ["For {area:3197}: keep it"] = "Pour {area:3197} : gardez-la",
	-- ["For {zone:1448}: keep it"] = "Pour {zone:1448} : gardez-la",
	-- ["For {zone:1451}: keep it"] = "Pour {zone:1451} : gardez-la",
	-- ["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "Depuis Theramore, chevauchez vers l'ouest dans {zone:1413}, puis vers le nord le long de la côte jusqu'à {area:392}.",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Depuis {area:392}, volez jusqu'à {area:2255} puis allez au sud jusqu'à {area:2250}.",
	-- ["From {area:702}, fly to {area:1116}."] = "Depuis {area:702}, volez jusqu'à {area:1116}.",
	-- ["Gaeriyan in {area:976}: keep it"] = "Gaeriyan à {area:976} : gardez-la",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["Hearth to {area:392} (bound there earlier on this guide), then fly on to {area:976}."] = "Utilisez votre Pierre de foyer pour {area:392} (liée plus tôt dans ce guide), puis prenez un vol pour {area:976}.",
	-- ["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Le crâne d'Horgus se trouve à {area:2624} et l'épée de Marduk dans {area:2623}, chacun là où des fantômes se battent ; des Chiens pestiférés adultes chassent dans les plaines entre les deux.",
	-- ["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan."] = "Si vous avez sauté la quête du {item:9328}, tuez des monstres ici jusqu'au niveau 56.89 pour rester dans le plan de la route.",
	-- ["Into {zone:1451}"] = "Vers {zone:1451}",
	-- ["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "Ramenez {npc:7774} jusqu'à {npc:7765} au pas : elle s'éloigne, alors sonnez la cloche pour la rappeler (pas en combat), et éliminez les harpies sur le chemin avant qu'elle ne les atteigne.",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Menez {npc:9999} vers le nord jusqu'à {area:541}. Quand il s'évanouit, utilisez la {item:11804} sur lui pour le réveiller.",
	-- ["Level 56.89"] = "Niveau 56.89",
	-- ["MacDonnell's next task, {area:201}'s cauldron, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "La tâche suivante de MacDonnell, le chaudron de {area:201}, attend l'étape des Maleterres du guide de {zone:1451} : prenez-la à ce moment-là.",
	-- ["More watches"] = "Encore des montres",
	-- ["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "Pas encore de {quest:5401} ({spell:437801} vous la donne au passage dans le guide de {zone:1452}) ? Pureheart vous en donne une ici : les quêtes de Pierres du Fléau en ont besoin.",
	-- ["North to the refuge, for the quests the first Un'Goro visit left: {npc:9618} stands just outside and {npc:9117} in the cave at the back; the expedition's other three wait for your next stop here."] = "Allez au nord jusqu'au refuge, pour les quêtes laissées par la première visite d'Un'Goro : {npc:9618} se tient juste devant et {npc:9117} dans la grotte au fond ; les trois autres membres de l'expédition attendent votre prochain passage ici.",
	-- ["Northern Pylon"] = "Le Pylône nord",
	-- ["On {npc:7583}"] = "Sur {npc:7583}",
	-- ["Ranshalla in {zone:1452}: keep it"] = "Ranshalla au {zone:1452} : gardez-la",
	-- ["Ride back south to the camp."] = "Retournez au camp, au sud.",
	-- ["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Revenez vers le sud-ouest jusqu'à la tour de {area:2742} à {area:2738} ; gravissez-la et tuez les embusqués qui surgissent pour l'objet incrusté.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Retournez à {area:3197} et volez jusqu'à {area:150}, prenez le bateau pour {area:442} et volez jusqu'à {area:702} ; le portail mène à {zone:1457}.",
	-- ["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Revenez au {area:3425}. {npc:15189} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Descendez la rampe dans le cratère : {npc:9619} campe à son pied.",
	-- ["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Allez à l'est jusqu'à la rivière frontalière : {npc:1855} vit dans une petite cabane sur la rive.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Chevauchez vers l'est jusqu'à la tour de {area:2742} à {area:2738} ; gravissez-la et tuez les embusqués qui surgissent pour l'objet incrusté.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Chevauchez vers l'est jusqu'à {area:1943}, où le robot se tient parmi les gorilles. N'entrez pas dans la grotte profonde.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Chevauchez vers l'est jusqu'à {area:537}, gravissez-la et utilisez {npc:10541} sur les évents de lave près du sommet.",
	-- ["Ride east to {npc:13220}."] = "Chevauchez vers l'est jusqu'à {npc:13220}.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Chevauchez vers le nord par le côté est jusqu'au plateau des gorilles. {npc:9622}, un gorille de niveau 55, se tient dans sa grotte la plus profonde : éliminez d'abord les gorilles de l'entrée.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Chevauchez vers le nord jusqu'à {area:2627}. {npc:12384} vit dans la cabane en ruine, et son livre de reçus est dans l'auberge en ruine voisine.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\nCareful: the Frenzied Plaguehounds north-east of the hut are 57-58, a level or two over you: pull them one at a time."] = "Chevauchez vers le nord jusqu'à {area:2627}. {npc:12384} vit dans la cabane en ruine, et son livre de reçus est dans l'auberge en ruine voisine.\nAttention : les Chiens pestiférés frénétiques au nord-est de la cabane sont 57-58, un niveau ou deux au-dessus de vous : attirez-les un par un.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\n{npc:11140} stands by {npc:12384}' hut in {area:2627}."] = "Chevauchez vers le nord jusqu'à {area:2627}. {npc:12384} vit dans la hutte en ruine, et son livre de reçus se trouve dans l'auberge en ruine voisine.\n{npc:11140} se tient près de la hutte de {npc:12384}, à {area:2627}.",
	-- ["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Allez au nord-ouest jusqu'à la ferme des Dalson. Le journal est dans la grange ; un squelette errant porte la clé des latrines, et {npc:10836} attend dans les latrines avec la clé de l'armoire.",
	-- ["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Continuez vers l'ouest jusqu'au {area:3425}. {npc:15189} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- ["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}."] = "Sortez du cratère par le col nord-ouest jusqu'en {area:1377}, puis continuez jusqu'à {area:3425}.",
	-- ["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "Sortez du cratère par le col nord-ouest pour entrer en {zone:1451} : {npc:13220} se tient au {area:3077}, là où débouche le col.",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Allez au sud jusqu'à {area:201}, où {npc:11078} garde le chaudron.",
	-- ["Ride south-west to the camp."] = "Retournez au camp, au sud-ouest.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Chevauchez vers le sud-ouest jusqu'au camp de {npc:7771}, à {area:1938}.",
	-- ["Ride west along the road to the hot springs."] = "Suivez la route vers l'ouest jusqu'aux sources chaudes.",
	-- ["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Chevauchez vers l'ouest jusqu'aux ruines de Ravenwind : {npc:7774} se cache dans le petit bâtiment rond au fond. Ouvrez le coffre à côté d'elle pour obtenir {item:9189} : elle dure 15 minutes, comme la quête.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Chevauchez vers l'ouest après {area:541}, puis vers le sud par le côté ouest jusqu'à {area:543} : {npc:10302}, le gobelin, est assis au bord de l'eau.",
	-- ["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Chevauchez vers l'ouest jusqu'à {area:2627}. Chiens pestiférés chétifs ({npc:8596}), Chauves-souris pestiférées ({npc:8600}) et Larves putrides ({npc:8603}) parcourent ses bois ; remplissez {item:15042} aux grandes termitières et tuez les Chiens pestiférés frénétiques ({npc:8598}) plus au nord.",
	-- ["Scare {npc:7583} with {item:12928}"] = "Effrayez {npc:7583} avec {item:12928}",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Les Écorcheurs squelettes et les Goules écumantes errent dans les champs au nord du camp ; tous les membres du Fléau ici lâchent des Pierres du Fléau.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Des Écorcheurs squelettes et des Goules écumantes parcourent les champs au nord du camp ; tout le Fléau ici laisse tomber des Pierres du Fléau.\nAttention : ces morts-vivants vous repèrent de loin, et les autres morts-vivants proches se joignent au combat quand vous en attirez un.\nAttention : l'{npc:10411} (3 apparitions, réapparition en 15 min) devient invisible hors combat et appelle des Gargouilles Aile-de-roc dès qu'un combat commence.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "De petits coffrets jonchent les décombres dans tout Andorhal ; chacun contient une montre.",
	-- ["Take the boat to the mainland and ride north-east past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "Prenez le bateau pour le continent et chevauchez vers le nord-est au-delà de {area:1119} jusqu'au camp de {npc:7775}. Il prépare l'{item:11243} à partir d'une {item:11242} : acceptez sa course pour en obtenir une.",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Prenez le bateau pour le continent et allez au nord-est jusqu'au camp de {npc:14637}, près de {area:1119}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Les Bêtes du goudron se vautrent dans les {area:538} ; les élémentaires de feu de la {area:537}, au centre, portent la cendre ; les guêpes Gorishi de la {area:540}, au sud, portent la glande. Toutes les créatures du cratère peuvent laisser tomber de la {item:11018}.\nAttention : les Ouvriers Gorishi qui passent sous 45 % de vie ont 50 % de chances d'appeler à l'aide leurs alliés à moins de 25 m.",
	-- ["Temple of the Moon"] = "Temple de la Lune",
	-- ["Ten {item:11040} from the {item:11020}"] = "Dix {item:11040} tirées de la {item:11020}",
	-- ["The Gorishi hive"] = "La ruche Gorishi",
	-- ["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Les Bêtes du goudron et les Seigneurs du goudron se vautrent dans les {area:538}, au sud du refuge, sur le chemin qui descend dans le cratère.",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Le chaudron propose maintenant sa propre tâche ; les squelettes alentour lâchent des Agitateurs osseux.",
	-- ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Le chaudron se trouve à {area:202}, près de la ferme de {npc:10739}.",
	-- ["The crater"] = "Le cratère",
	-- ["The fields"] = "Les champs",
	-- ["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "Le géant {npc:7765} est assis juste au nord-ouest du camp de {npc:7775}.",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Les gorilles vivent sur le {area:1943}, à l'est de {area:541}. Gardez leurs peaux pour {npc:9619}. Évitez la grotte la plus profonde : {npc:9622} est de niveau 55.\nAttention : les Gorilles d'Un'Goro (niveau 50-51) appellent à l'aide leurs alliés à moins de 20 m dès qu'ils tombent à 25 % de vie. Il y a dans la zone une grotte pleine de singes, et y combattre attire beaucoup de renforts.",
	-- ["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Les gorilles vivent sur le {area:1943}, juste à l'est du pylône : prenez dès maintenant les peaux pour {npc:9619}, tant que vous êtes là-haut. Évitez la grotte la plus profonde : {npc:9622} est de niveau 55.\nAttention : les Gorilles d'Un'Goro (niveau 50-51) appellent à l'aide leurs alliés à moins de 20 m dès qu'ils tombent à 25 % de vie. Il y a dans la zone une grotte pleine de singes, et y combattre attire beaucoup de renforts.",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "Le guide suivant commence ici à {area:392} et continue en vol jusqu'à {area:976}.",
	-- ["The pelts come from the gorillas on {area:1943}"] = "Les peaux viennent des gorilles de {area:1943}",
	-- ["The portal in {area:702} leads up to {zone:1457}."] = "Le portail du {area:702} mène à {zone:1457}.",
	-- ["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "Le pylône se dresse sur les falaises est au-dessus du repaire de {npc:9684} ; la {item:11113} de l'expédition se trouve au camp abandonné dans la jungle est.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}."] = "Le pylône se dresse sur la pente à l'est du refuge. Les {npc:9166} tournent au-dessus des pentes alentour : ils comptent pour {npc:9997}.",
	-- ["The pylon stands on the western cliffs."] = "Le pylône se dresse sur les falaises ouest.",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Les géants rétrécis errent autour de {area:1119} ; les élémentaires des mers longent la côte à l'ouest.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Les Druides torturés et les Sentinelles torturées hantent le village en ruine au sud-ouest de {npc:13220}.",
	-- ["The wooden sign beside {npc:9997}"] = "Le panneau en bois à côté de {npc:9997}",
	-- ["The {area:2742} tower"] = "La tour de {area:2742}",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "La {item:11242} pousse dans un bâtiment en ruine au nord de {npc:7765} : entrez par la brèche de son mur depuis la corniche voisine.",
	-- ["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "Le {item:280417} se trouve à courte distance à l'ouest du camp de {npc:9619}.",
	-- ["Umber in {area:493}: keep it"] = "Umber à {area:493} : gardez-la",
	-- ["Umber in {zone:1450}: keep it"] = "Umber à {zone:1450} : gardez-la",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Utilisez le {item:12627} près des silos à grain pour faire sortir les Parasites temporels. {quest:5154} est l'un des vieux tomes de l'hôtel de ville. Tous les squelettes de la ville lâchent des {quest:5537}.",
	-- ["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}.\nCareful: the Temporal Parasites are 55-57, and Skeletal Warlords and Flesh Golems (57, elites) walk the streets: draw the parasites out by the silos, one at a time, and let the elites pass."] = "Utilisez le {item:12627} près des silos à grain pour faire sortir les Parasites temporels. {quest:5154} est l'un des vieux tomes de l'hôtel de ville. Tous les squelettes de la ville lâchent des {quest:5537}.\nAttention : les Parasites temporels sont 55-57, et des Chefs de guerre squelettes et des Golems de chair (57, élites) arpentent les rues : faites sortir les parasites près des silos, un à la fois, et laissez passer les élites.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Utilisez la {item:12815} au pied de chacune des quatre tours de guet en bordure d'Andorhal, au nord du camp.",
	-- ["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp.\nCareful: Skeletal Warlords and Flesh Golems (57, elites) walk Andorhal's streets, and the {npc:7572} (59, elite) wanders between Andorhal and Northridge: keep to the towers at the town's edge and let them pass."] = "Utilisez la {item:12815} au pied de chacune des quatre tours de guet en bordure d'Andorhal, au nord du camp.\nAttention : des Chefs de guerre squelettes et des Golems de chair (57, élites) arpentent les rues d'Andorhal, et le {npc:7572} (59, élite) erre entre Andorhal et Northridge : restez près des tours en bordure de la ville et laissez-les passer.",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Entrez dans {area:1769} et prenez la branche du tunnel vers {area:493} jusqu'à {area:2361}.",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Entrez dans {area:1769} et prenez la branche du tunnel vers {zone:1450} jusqu'à {area:2361}.",
	-- ["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Traversez le sud du cratère vers l'ouest : des Os de dinosaure jonchent le sol au sud-ouest, parmi les stégodons : ceux-ci sont élites, ramassez les os autour d'eux et prenez le reste sur les Diémétradons. L'{item:11112} de l'expédition se trouve dans la jungle sud-ouest.",
	-- ["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "Allez vers l'ouest le long du sud du cratère : la ruche gorishi l'occupe. Utilisez la fiole à grattage sur un couvoir, une salle aux larves suspendues.",
	-- ["Western Pylon"] = "Pylône ouest",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Vous avez manqué ceci lors du passage précédent de l'itinéraire ici : cela passe d'abord maintenant. C'est rapide et cela ouvre les quêtes qui suivent.",
	-- ["Zapped giants and sea elementals"] = "Géants rétrécis et élémentaires des mers",
	-- ["grind on {npc:11740}"] = "tuez en boucle : {npc:11740}",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "tuez des {npc:1796} à {area:202}, {zone:1422}",
	-- ["their trainers are in {zone:1457} too"] = "leurs maîtres sont aussi à {zone:1457}",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108} : tuez-les au passage",
	-- ["{area:1377}: kill these as you meet them"] = "{area:1377} : tuez-les au passage",
	-- ["{area:139}: kill these as you meet them"] = "{area:139} : tuez-les au passage",
	-- ["{area:1942}: kill these as you meet them"] = "{area:1942} : tuez-les au passage",
	-- ["{area:1943}: kill these as you meet them"] = "{area:1943} : tuez-les au passage",
	-- ["{area:200} cauldron"] = "Chaudron de {area:200}",
	-- ["{area:201} cauldron"] = "Chaudron de {area:201}",
	-- ["{area:348} flight master"] = "Maître de vol de {area:348}",
	-- ["{area:392} flight master"] = "Maître de vol de {area:392}",
	-- ["{area:442} flight master"] = "Maître de vol d'{area:442}",
	-- ["{area:489} flight master"] = "Maître de vol de {area:489}",
	-- ["{area:538}: kill these as you meet them"] = "{area:538} : tuez-les au passage",
	-- ["{area:976} flight master"] = "Maître de vol de {area:976}",
	-- ["{item:11478}; below ground"] = "{item:11478} ; sous terre",
	-- ["{item:11479}; below ground"] = "{item:11479} ; sous terre",
	-- ["{item:11480}; below ground"] = "{item:11480} ; sous terre",
	-- ["{item:11834} on the way"] = "{item:11834} en chemin",
	-- ["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} se trouve dans l'hôtel de ville de {area:190}, à l'ouest de {npc:1855} : les gardes écarlates sont très rapprochés.",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} se trouve à l'est de la grange de {area:201}.",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}, auprès de {npc:11056}",
	-- ["{item:13853} on the way"] = "{item:13853} en chemin",
	-- ["{item:14613}, from {npc:11886} (57, elite): grouping up is advised"] = "{item:14613}, sur {npc:11886} (57, élite) : il est conseillé de former un groupe",
	-- ["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} à {zone:1452} : gardez-la",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300} : son escorte viendra plus tard sur l'itinéraire",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} attend dans l'auberge en ruine, à l'ouest d'Andorhal.",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} se tient près de la ferme de {area:202}, au nord-est des champs.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Le fantôme de {npc:10778} erre près de la ferme de {area:199}, à l'ouest de {area:200} ; son colis est à l'intérieur.",
	-- ["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} et {npc:7740} se tiennent près du temple de la Lune ; remplissez {item:11682} au puits de lune à l'intérieur.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path now; the {zone:2482} guide flies to {area:493}, and the {zone:1451} guide comes back here."] = "{npc:10897}, le Maître de vol de {area:493}, se tient au sud du lac, à l'extérieur de {area:2361} : apprenez le Trajet aérien maintenant ; le guide de {zone:2482} vole jusqu'à {area:493}, et le guide de {zone:1451} revient ici.",
	-- ["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "La ferme de {npc:10927} se dresse sur la colline à l'est du camp ; le monument de {npc:10936} est juste au nord.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, près des tombes au sud de la chapelle",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} garde le chaudron de {area:199}, à l'ouest d'Andorhal.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} se tient près de la cabane d'Augustus à {area:2627}.",
	-- ["{npc:11610}'s next task, {npc:11613} and {npc:11611}, waits for the {zone:1451} guide's Plaguelands leg: take it then."] = "La tâche suivante de {npc:11610}, {npc:11613} et {npc:11611}, attend l'étape des Maleterres du guide de {zone:1451} : prenez-la à ce moment-là.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} arpente le camp de la Crête du nord, à l'est de {npc:11610} ; {npc:11611} garde la tour sur l'accès sud de {area:190}.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} parcourt le camp de Crête-du-Nord à l'est de {npc:11610} ; {npc:11611} garde la tour à l'approche sud de {area:190}.\nAttention : des gardes se tiennent au pied de la tour et un autre en fait le tour en patrouille. Éliminez-les avant d'engager Durgen pour qu'ils ne se joignent pas au combat.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616} : les termites viendront plus tard, à {area:2627}",
	-- ["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741} se promène par ici : cherchez dans le cercle sur la carte",
	-- ["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} est un élite : mieux vaut être en groupe",
	-- ["{npc:15189}'s and {npc:15191}'s next tasks (the Stonelash scorpids and the Dredge Crushers) wait for the {zone:1451} guide's {area:3425} stop: take them then."] = "Les tâches suivantes de {npc:15189} et de {npc:15191} (les scorpides Cinglepierre et les Ecraseurs térébrants) attendent l'étape de {area:3425} du guide de {zone:1451} : acceptez-les à ce moment-là.",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, aux tentes de l'Alliance",
	-- ["{npc:1833} along the way to {npc:11610}"] = "{npc:1833} sur le chemin de {npc:11610}",
	-- ["{npc:1833} on the way"] = "{npc:1833} en chemin",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} est un élite : mieux vaut être en groupe. Il garde son phylactère au centre d'Andorhal.",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "{npc:1852} est élite : mieux vaut être en groupe. Il garde son phylactère au milieu d'Andorhal.\nDe petits coffrets reposent dans les décombres partout dans Andorhal ; chacun contient une montre.\nAttention : des goules et des squelettes se tiennent souvent près des coffrets et attaquent quand vous approchez. Les goules brûlantes blessent aussi tout ce qui est à proximité et rompent le camouflage.",
	-- ["{npc:5411} in {area:976}: keep it"] = "{npc:5411} à {area:976} : gardez-la",
	-- ["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",
	-- ["{npc:5901}, on the coast north of town"] = "{npc:5901}, sur la côte au nord de la ville",
	-- ["{npc:7740}: keep it for {area:976}"] = "{npc:7740} : gardez-la pour {area:976}",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "Le camp de {npc:7775} est au nord de {area:1119}. Il prépare l'{item:11243} à partir d'une {item:11242} : acceptez sa course pour en obtenir une.",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "Le camp de {npc:7775} est au nord de {area:1119}. Il vend l'{item:11243} une fois qu'il a son appât.",
	-- ["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "{npc:7876}, côté nord de la ville : le goudron est à Un'Goro, gardez-la",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900} : gardez-la pour {area:440}",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900} : gardez-la pour {zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496} : gardez-la pour le Cratère d'Un'Goro",
	-- ["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496} : gardez-la pour Un'Goro ; à l'intérieur",
	-- ["{npc:8598} on the way"] = "{npc:8598} en chemin",
	-- ["{npc:8598}, 170 yd north-east"] = "{npc:8598}, à 170 mètres au nord-est",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}, dans {area:1658}",
	-- ["{npc:9117}, below ground"] = "{npc:9117}, sous terre",
	-- ["{npc:9299} in {area:976}: keep it"] = "{npc:9299} à {area:976} : gardez-la",
	-- ["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} est un fantôme au cimetière juste à l'est de la ville : buvez-y un {item:11243}, qui vous tue, libérez votre esprit et parlez-lui sous forme de fantôme. Ensuite, retournez à votre corps pour revenir à la vie : la pierre tombale se trouve tout près.",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} attend au cimetière juste à l'est de la ville ; la pierre tombale se trouve à proximité.",
	-- ["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619} campe au pied de la rampe qui descend dans le cratère.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Le repaire de {npc:9684} se trouve dans la jungle au nord de {npc:9619}, sous les falaises est : utilisez-y la {item:11568}. {npc:9684} est de niveau 56 : commencez avec toute votre vie.",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} est assis sur la pente sud-est de {area:537}, au milieu du cratère.",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}, dans la ferme",
	-- ["{object:177667}, below ground"] = "{object:177667}, sous terre",
	-- ["{object:179565}; inside"] = "{object:179565} ; à l'intérieur",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} se trouve à {area:392}",
	-- ["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, si vous l'avez encore depuis la première visite",
	-- ["{quest:5058}, inside"] = "{quest:5058}, à l'intérieur",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} à {area:493} : gardez-la",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} à {zone:1450} : gardez-la",
	-- ["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, si un ravasaure a laissé tomber l'écaille depuis la première visite",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449} : tuez-les au passage",
	-- ["{zone:1451}: kill these as you meet them"] = "{zone:1451} : tuez-les au passage",
	-- ["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, où le guide suivant passe chez les maîtres, n'a pas de maître druide",
}
