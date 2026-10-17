-- French (frFR): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Prendre un vol pour {area:2268}",
	-- {object:1661} The Undercity · {object:36078} Trade Quarter
	["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Le maître de vol de {object:1661} se trouve dans la tour ouest de {object:36078}, hors des murs.",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Les objets de {quest:5168} se trouvent dans les zones des Maleterres visitées plus tard : gardez-la.",

	-- Step 3: Lake Mereldar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Les Chiens pestiférés et les Chiens pestiférés chétifs rôdent sur les rives du lac au sud-ouest de la chapelle.",

	-- Step 4: Sword of Marduk
	["Sword of Marduk"] = "Epée brisée de Marduk",
	["The shattered sword lies on the ground north-west of the lake."] = "L'Epée brisée de Marduk gît au sol au nord-ouest du lac.",

	-- Step 5: The Pestilent Scar
	-- {area:2622} Pestilent Scar
	["The {area:2622}"] = "{area:2622}",
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Le crâne se trouve dans {area:2622}, parmi les Horreurs corrompues et les Monstruosités de la peste.",

	-- Step 6: Hameya's scroll
	["Hameya's scroll"] = "Le parchemin d'Hameya",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Un Parchemin déchiré se trouve à l'entrée de {area:2261}, la crypte au sud de {area:2260}.",

	-- Step 7: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead
	["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Le champion de {npc:15193} occupe la ferme de {area:2260}.",

	-- Step 8: The western hills
	["The western hills"] = "Les collines de l'ouest",
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Les Chiens pestiférés chétifs ({npc:8596}) et les Chauves-souris pestiférées ({npc:8600}) parcourent les collines au nord de {area:2260}, des Larves putrides ({npc:8603}) rampent parmi eux ; progressez vers le nord en direction de {area:2627}.",

	-- Step 9: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Le fantôme {npc:11140} se tient près d'une cabane à {area:2627}, dans le coin nord-ouest.",

	-- Step 10: Quel'Lithien Lodge
	-- {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Les hauts-elfes Forestiers, Eclaireurs et Bûcherons gardent le Gîte de Quel'Lithien près de {area:2275} ; le Registre de Quel'Thalas est à l'intérieur. Les Forestiers atteignent le niveau 60 : attirez-les un par un. Des Chauves-souris pestiférées nuisibles survolent les champs en chemin.",

	-- Step 11: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "L'Infiltrateur Hameya se cache parmi les trolls Mossflayer de {area:2273}, dans le coin nord-est.",

	-- Step 12: Northdale
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Les Chiens pestiférés frénétiques et les Chauves-souris pestiférées monstrueuses se partagent les champs autour de {area:2272} et de {area:2271}, au sud de {area:2273}.",

	-- Step 13: Corin's Crossing
	-- {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "La {item:15447} se gâte en dix minutes : tuez vite le Fléau de la ville et broyez aussitôt les sept morceaux avec le {item:15454}.",

	-- Step 14: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Allez à l'ouest jusqu'à {area:2260}.",

	-- Step 15: Hameya's mound
	["Hameya's mound"] = "Le monticule d'Hameya",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just behind the {area:2261}."] = "Le {object:177675} se trouve juste derrière {area:2261}.",

	-- Step 17: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Prendre un vol pour {area:1638}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:1638} Thunder Bluff
	["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Prenez un vol pour {zone:1458}, le zeppelin pour {zone:1454}, puis un vol pour {area:1638}.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} sur {area:1639} ; {npc:246344}",

	-- Step 18: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Sur {area:1641}. Ayez l'Etoffe de laine, l'Etoffe de soie et l'Etoffe de tisse-mage dans vos sacs.",

	-- Step 20: Deadwood Cauldron
	-- {item:12820} Winterfall Firewater · {zone:1452} Winterspring · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Seulement si vous avez trouvé une flasque d'{item:12820} à {zone:1452} : remontez la route vers le nord. Le chaudron se trouve à {area:1762}, juste au sud-ouest de {area:1769} ; les furbolgs Mort-bois y sont hostiles.",

	-- Step 21: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Seulement si l'objet de la quête {quest:8471} est tombé pour vous : {npc:11558} attend à l'entrée de {area:1769} côté {zone:1448}, et ne vous parle qu'au niveau Neutre auprès des Grumegueules.",

	-- Step 22: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Traversez {area:1769} et prenez l'embranchement du tunnel vers {zone:1450}. {npc:11801} Saturna se trouve à {area:2361}.",
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Les deux quêtes mènent à {zone:1451} : gardez-les.",

	-- Step 23: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Repassez par le tunnel et prenez la sortie vers {zone:1452}, puis allez au sud jusqu'à {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "Les cibles de {quest:5086} sont à {zone:1448}, lors d'un passage ultérieur : gardez la quête si vous l'avez.",

	-- Step 24: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Chouettards lunaires",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Allez à l'est jusqu'à {area:2255} et sortez-en par le nord ; les Chouettards lunaires rôdent dans les collines des pentes sud de {area:2241}. Attirez-les un par un.",

	-- Step 25: Back to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Back to {area:1638}"] = "Retour à {area:1638}",

	-- Step 26: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "La machine {object:142071}",

	-- Step 27: Sprinkle
	-- {npc:10980} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {npc:10980} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Utilisez {npc:10980} sur {npc:7583}, la petite gobeline de {area:976}. {npc:10977} et {npc:10978} seront effrayés plus loin dans l'itinéraire.",

	-- Step 28: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} est un fantôme au cimetière juste au nord de {area:976} ; Une tombe ostentatoire se trouve au sud, hors du mur de la ville.",
	-- {quest:3914} Linken's Sword
	["{quest:3914} goes back to Linken in Un'Goro: keep it."] = "{quest:3914} se rend à Linken, dans le Cratère d'Un'Goro : gardez-la.",

	-- Step 29: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} Rivetseeker campe près de la route de {area:1336}, au sud de {area:976}.",

	-- Step 30: Hippogryph eggs
	["Hippogryph eggs"] = "Oeufs d'hippogryphe",
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Prenez un vol pour {area:1099}. Les nids d'hippogryphes sont dans le sud de {zone:1444} ; chacun contient un Oeuf d'hippogryphe pour l'{object:142071}.",

	-- Step 31: On to Silithus
	-- {zone:1451} Silithus
	["On to {zone:1451}"] = "En route pour {zone:1451}",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus · {area:3077} Valor's Rest
	["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Prenez un vol pour {area:541}, puis traversez le Cratère d'Un'Goro vers le sud-ouest jusqu'au col menant à {zone:1451}. Le guide suivant commence à {area:3077}, à la sortie du col.",
}
