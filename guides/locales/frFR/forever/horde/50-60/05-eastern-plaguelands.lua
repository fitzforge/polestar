-- French (frFR): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "La ferme de {npc:10778} est la première à l'est de {area:152}. Les Goules jacassantes de la ferme portent l'autre moitié de son porte-bonheur ; {npc:11075} garde le chaudron dans le champ.\nAttention : un ou deux morts-vivants combattent généralement à ses côtés, et d'autres seigneurs du chaudron peuvent attaquer après que vous avez utilisé le chaudron.",
	["Upstairs"] = "À l'étage",

	-- Step 3: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Prendre un vol pour {area:2268}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Maître de vol de {area:272}",

	-- Step 4: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Les objets de {quest:5168} se trouvent dans les zones des Maleterres visitées plus tard : gardez-la.",

	-- Step 5: Plaguebat on the way
	-- {npc:8600} Plaguebat
	["{npc:8600} on the way"] = "{npc:8600} en chemin",

	-- Step 6: Slab of Carrion Worm Meat on the way
	-- {item:13853} Slab of Carrion Worm Meat
	["{item:13853} on the way"] = "{item:13853} en chemin",

	-- Step 7: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423} : tuez-les au passage",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel.\nThe shattered sword lies on the ground north-west of the lake."] = "Les Chiens pestiférés et leurs petits parcourent les rives du lac au sud-ouest de la chapelle.\nL'épée brisée gît au sol au nord-ouest du lac.",

	-- Step 8: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Le champion de {npc:15193} occupe la ferme de {area:2260}, au nord de {area:2261}.",

	-- Step 9: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Les Chiens pestiférés chétifs et les Chauves-souris pestiférées parcourent les collines au nord de {area:2260}, et des Larves putrides rampent parmi eux ; progressez vers le nord en direction de {area:2627}.",

	-- Step 10: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Le fantôme {npc:11140} se tient près d'une cabane à {area:2627}, dans le coin nord-ouest.",
	["Inside"] = "À l'intérieur",

	-- Step 11: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277} : tuez-les au passage",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Les Chiens pestiférés frénétiques et les Chauves-souris pestiférées monstrueuses se partagent les champs autour de {area:2272} et de {area:2271}, au sud de {area:2273}.",

	-- Step 12: Eastern Plaguelands: kill these as you meet them
	-- {area:2275} Northpass Tower · {area:2622} Pestilent Scar
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Blighted Horrors = {npc:8521} Blighted Horror
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Les Forestiers, Éclaireurs et Bûcherons hauts-elfes gardent le pavillon près de {area:2275} ; le registre se trouve à l'intérieur. Les Forestiers montent jusqu'au niveau 60 : attirez-les un par un. Des Chauves-souris pestiférées nuisibles survolent les champs en chemin.\nLe crâne se trouve dans {area:2622}, parmi les Horreurs corrompues et les Monstruosités de la peste.",
	["Underwater"] = "Sous l'eau",

	-- Step 13: Pathstrider
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} se promène autour de {area:2276} : cherchez dans le cercle sur la carte",

	-- Step 14: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Allez à l'ouest jusqu'à {area:2260}.",

	-- Step 15: Corin's Crossing
	-- {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant
	["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "{item:15447} se gâte en dix minutes : tuez vite le Fléau de la ville et broyez aussitôt les sept morceaux avec {item:15454}.\nAttention : les Serviteurs invisibles appellent à l'aide à moins de 25 m dès qu'ils tombent à 40 % de vie. Hors combat, ils deviennent aussi invisibles avec {spell:10228}. Si un appel à l'aide a lieu dans la ville, un grand nombre de monstres peut rejoindre le combat. Combattre en périphérie réduit ce risque.",

	-- Step 18: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:11897} est un élite de niveau 60 : la plupart des classes en viennent à bout seules au niveau 62, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : le parcours vous fait regagner cette expérience en tuant des monstres.",

	-- Step 19: Hearth to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Hearth to {area:2268}"] = "Pierre de foyer vers {area:2268}",

	-- Step 21: Light's Hope Chapel
	["Ride east across the plaguelands to the chapel."] = "Chevauchez vers l'est à travers les Maleterres jusqu'à la chapelle.",

	-- Step 22: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Prendre un vol pour {area:1497}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "Maître de vol de {area:2268}",

	-- Step 23: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 25: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "Prendre un vol pour {area:1997}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 26: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Prendre un vol pour {area:1638}",

	-- Step 27: Fly to Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Fly to {zone:1456}"] = "Prendre un vol pour {zone:1456}",
	-- {area:1497} Undercity · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff
	["Fly to the {area:1497}, take the zeppelin to {zone:1454} and fly on to {zone:1456}."] = "Volez jusqu'à {area:1497}, prenez le zeppelin pour {zone:1454} puis volez jusqu'à {zone:1456}.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} sur {area:1639} ; {npc:246344}",

	-- Step 28: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["On {area:1641}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Sur {area:1641}. Chaque don prend soixante étoffes de laine, de soie ou de tisse-mage dans vos sacs : rendez celles que vous avez sur vous, ignorez les autres.",

	-- Step 29: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol : {zone:1456}",

	-- Step 31: Deadwood Cauldron
	-- {item:12820} Winterfall Firewater · {area:618} Winterspring · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Only if you found a {item:12820} flask in {area:618}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Seulement si vous avez trouvé une flasque d'{item:12820} au {area:618} : remontez la route vers le nord. Le chaudron se trouve au {area:1762}, juste au sud-ouest du {area:1769} ; les furbolgs Mort-bois y sont hostiles.",

	-- Step 32: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Seulement si l'objet de la quête {quest:8471} est tombé pour vous : {npc:11558} attend à l'entrée de {area:1769} côté {zone:1448}, et ne vous parle qu'au niveau Neutre auprès des Grumegueules.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} se promène par ici : cherchez dans le cercle sur la carte",

	-- Step 34: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Traversez {area:1769} et prenez la branche du tunnel vers {area:493}. {npc:11801} se trouve à {area:2361}.",

	-- Step 35: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 36: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Les deux quêtes mènent à {zone:1451} : gardez-les.",

	-- Step 38: Donova Snowden
	-- {area:618} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Revenez par le tunnel et prenez la sortie vers {area:618}, puis chevauchez vers le sud jusqu'à {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "Les cibles de {quest:5086} sont à {zone:1448}, lors d'un passage ultérieur : gardez la quête si vous l'avez.",

	-- Step 39: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Chouettards lunaires",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Allez à l'est jusqu'à {area:2255} et sortez-en par le nord ; les Chouettards lunaires rôdent dans les collines des pentes sud de {area:2241}. Attirez-les un par un.",

	-- Step 41: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Maître de vol de {area:2255}",

	-- Step 42: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} est un fantôme au cimetière juste au nord de {area:976} ; Une tombe ostentatoire se trouve au sud, hors du mur de la ville.",

	-- Step 43: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Utilisez {item:12928} sur {npc:7583}, la petite gobeline de {area:976}. {npc:10977} et {npc:10978} seront effrayés plus loin dans le parcours.",

	-- Step 44: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "La machine {object:142071}",

	-- Step 45: Gaeriyan
	-- {quest:3914} Linken's Sword
	["{quest:3914} goes back to Linken in Un'Goro: keep it."] = "{quest:3914} se rend à Linken, dans le Cratère d'Un'Goro : gardez-la.",

	-- Step 46: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} Rivetseeker campe près de la route de {area:1336}, au sud de {area:976}.",

	-- Step 47: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Prendre un vol pour {area:1099}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maître de vol de {area:976}",

	-- Step 48: Ruins of Isildien
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Prenez un vol pour {area:1099}. Les nids d'hippogryphes sont dans le sud de {zone:1444} ; chacun contient un Oeuf d'hippogryphe pour l'{object:142071}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Un Parchemin déchiré se trouve à l'entrée de {area:2261}, la crypte au sud de {area:2260}.",
	-- ["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Repassez par le tunnel et prenez la sortie vers {zone:1452}, puis allez au sud jusqu'à {area:2246}.",
	-- ["Back to {area:1638}"] = "Retour à {area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Prenez un vol pour {zone:1458}, le zeppelin pour {zone:1454}, puis un vol pour {area:1638}.",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Prenez un vol pour {area:541}, puis traversez le Cratère d'Un'Goro vers le sud-ouest jusqu'au col menant à {zone:1451}. Le guide suivant commence à {area:3077}, à la sortie du col.",
	-- ["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Traversez {area:1769} et prenez l'embranchement du tunnel vers {zone:1450}. {npc:11801} Saturna se trouve à {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "L'Infiltrateur Hameya se cache parmi les trolls Mossflayer de {area:2273}, dans le coin nord-est.",
	-- ["Hameya's mound"] = "Le monticule d'Hameya",
	-- ["Hameya's scroll"] = "Le parchemin d'Hameya",
	-- ["Hippogryph eggs"] = "Oeufs d'hippogryphe",
	-- ["On to {zone:1451}"] = "En route pour {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Sur {area:1641}. Ayez l'Etoffe de laine, l'Etoffe de soie et l'Etoffe de tisse-mage dans vos sacs.",
	-- ["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Seulement si vous avez trouvé une flasque d'{item:12820} à {zone:1452} : remontez la route vers le nord. Le chaudron se trouve à {area:1762}, juste au sud-ouest de {area:1769} ; les furbolgs Mort-bois y sont hostiles.",
	-- ["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Les Chiens pestiférés chétifs ({npc:8596}) et les Chauves-souris pestiférées ({npc:8600}) parcourent les collines au nord de {area:2260}, des Larves putrides ({npc:8603}) rampent parmi eux ; progressez vers le nord en direction de {area:2627}.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Les Chiens pestiférés et les Chiens pestiférés chétifs rôdent sur les rives du lac au sud-ouest de la chapelle.",
	-- ["Sword of Marduk"] = "Epée brisée de Marduk",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Les hauts-elfes Forestiers, Eclaireurs et Bûcherons gardent le Gîte de Quel'Lithien près de {area:2275} ; le Registre de Quel'Thalas est à l'intérieur. Les Forestiers atteignent le niveau 60 : attirez-les un par un. Des Chauves-souris pestiférées nuisibles survolent les champs en chemin.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "L'Epée brisée de Marduk gît au sol au nord-ouest du lac.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Le crâne se trouve dans {area:2622}, parmi les Horreurs corrompues et les Monstruosités de la peste.",
	-- ["The western hills"] = "Les collines de l'ouest",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "Le {object:177675} se trouve juste derrière {area:2261}.",
	-- ["Use {npc:10980} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Utilisez {npc:10980} sur {npc:7583}, la petite gobeline de {area:976}. {npc:10977} et {npc:10978} seront effrayés plus loin dans l'itinéraire.",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "La {item:15447} se gâte en dix minutes : tuez vite le Fléau de la ville et broyez aussitôt les sept morceaux avec le {item:15454}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Le champion de {npc:15193} occupe la ferme de {area:2260}.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Le maître de vol de {object:1661} se trouve dans la tour ouest de {object:36078}, hors des murs.",
}
