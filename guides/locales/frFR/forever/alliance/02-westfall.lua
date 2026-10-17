-- French (frFR): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} et {npc:821} se tiennent au sommet de la tour de pierre. {npc:491} est dans la tour, {npc:878} sur le flanc sud de la colline, près de l'auberge et de {npc:523}, le maître des griffons.",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523} ; ignorez le vol gratuit proposé",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, à côté de {npc:878}",

	-- Step 2: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Suivez la route vers le nord. {npc:233} se tient dehors, {npc:235} dans la maison, {npc:253395} dans la grange à l'ouest.",

	-- Step 3: The Jansen Stead
	["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Plus au nord sur la route. Les Furlbrow sont assis près de leur ferme incendiée. En chemin, ramassez l'avoine des Sacs d'avoine dans les champs.",
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Seulement si vous avez ramassé un {item:1972} dans la forêt d'Elwynn : faites un clic droit dessus",
	["Fill the vial at the well"] = "Remplissez la fiole au puits",
	["Sacks of Oats"] = "Sacs d'avoine",

	-- Step 4: Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Des Jeunes Broche-tripes et des Déchireurs parcourent les champs autour de la ferme : commencez les foies et la viande du ragoût au retour.",

	-- Step 5: Molsen Farm
	-- {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "À l'ouest de chez Saldean. Des Gardiens des moissons et des Golems des moissons travaillent les champs ; ils lâchent les isoressorts, les gyrostabiliseurs, du {item:732} et parfois un {item:255155}. {npc:573}, un rare de niveau 20, rôde ici : laissez-le tranquille. Continuez à tuer des Broche-tripes et des Déchireurs à chaque étape de cette boucle.",
	["Fill the vial at the farm's well"] = "Remplissez la fiole au puits de la ferme",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Gardiens des moissons",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729} : Déchireurs",

	-- Step 6: Jangolode Mine
	-- {object:290} Furlbrow's Wardrobe
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "Au nord de la ferme des Molsen. Des Trappeurs défias et des Contrebandiers défias campent devant la mine. {object:290} se trouve près de la maison en ruine à l'est de la mine.",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153} : tous les Défias en lâchent",

	-- Step 7: The north coast
	["The north coast"] = "La côte nord",
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Des Cours-la-côte murlocs et des Ecumeurs murlocs bordent la plage au nord de la mine. Ils fuient quand ils sont blessés : attirez-les un par un.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Branchies de Murloc de Longrivage",

	-- Step 8: The gnoll hills
	["The gnoll hills"] = "Les collines des gnolls",
	-- {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Des Gnolls Rivepatte et des Eclaireurs Rivepatte parcourent les collines entre la côte et la {area:916}.",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Pattes de gnoll",

	-- Step 12: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "Retournez au nord au-delà de {area:918} jusqu'à la mine : des Terrassiers kobolds travaillent à l'intérieur.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Terrassiers kobolds",

	-- Step 13: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "Au sud-ouest vers la côte, à l'ouest de {area:918}. Des Mineurs Rivepatte travaillent dans la carrière.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineurs Rivepatte",

	-- Step 14: The western farms
	["The western farms"] = "Les fermes de l'ouest",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Des Pilleurs défias et des Pillards défias tiennent les fermes à l'ouest de {area:108}, entre la route côtière et {area:20}.",

	-- Step 16: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} et les collines des Défias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Des Eclaireurs défias et des Truands défias arpentent {area:20} ; des Malandrins défias (niveau 17) patrouillent par deux dans les collines au sud et à l'est : séparez-les. L'entrée de {area:1581}, dans la forge, mène à un donjon de groupe.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, dans les caisses autour de {area:20}",

	-- Step 17: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "Retour à {area:108}",
	["Hearthstone on cooldown? Follow the road north-east."] = "Pierre de foyer en recharge ? Suivez la route vers le nord-est.",
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Pour {npc:266} à {area:69}, dans les Carmines",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Pour {npc:11026} dans {object:28027} de {zone:1453}",

	-- Step 18: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Rendez-vous à {zone:1453} en vol ou à cheval. {npc:5480} entraîne les guerriers dans {object:2100} ; {npc:6089} et {npc:6090} s'y tiennent ensemble près de {object:2152}. {npc:6090} vous affronte pour sa chope.",

	-- Step 19: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Rendez-vous à {zone:1453} en vol ou à cheval. {npc:376} est dans la cathédrale de la Lumière.",

	-- Step 20: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Rendez-vous à {zone:1453}. La ville n'a pas de maître des chamans : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour le bateau.",

	-- Step 21: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter
	["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), le parc (druides).",
	["Level 12, 14 and 16 spells"] = "Sorts des niveaux 12, 14 et 16",
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} pour Rassembler les ingrédients du remède (6123) à {zone:1439} : {npc:1313}, Fournitures d'alchimie ; les herboristes la cueillent plutôt là-bas",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, au sanctum des mages : {quest:1861}",

	-- Step 22: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vend des articles de pêche le long du canal, juste à l'ouest de {object:2096} ; {npc:267118} pêche au port, sur le chemin du bateau.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, chez {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defensive Stance"] = "Posture défensive",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), le parc (druides). {npc:11026} travaille dans {object:28027}, {npc:279} dans {object:2096}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:23299} (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), {object:23299} (druides). {npc:11026} travaille dans {object:28027}, {npc:279} dans {object:2096}.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Plus au nord sur la route. Les Furlbrow sont assis près de leur ferme incendiée. En chemin, ramassez l'avoine des Sacs d'avoine dans les champs et remplissez la fiole au puits de la ferme.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Au nord de la ferme des Molsen. Des Trappeurs défias et des Contrebandiers défias campent devant la mine, des Terrassiers kobolds travaillent à l'intérieur. {object:290} se trouve près de la maison en ruine à l'est de la mine.",
	-- ["Only if he takes the isosprings alone"] = "Seulement s'il prend les isoressorts seuls",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Des Gnolls Rivepatte et des Eclaireurs Rivepatte parcourent les collines entre la côte et {area:916}.",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "À l'ouest de la ferme des Molsen, vers la côte. Des Mineurs Rivepatte travaillent dans la carrière.",
	-- ["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, {skill:171} Supplies; herbalists pick it there instead"] = "{item:2449} pour Rassembler les ingrédients du remède (6123) à {zone:1439} : {npc:1313}, fournitures d'{skill:171} ; les herboristes la cueillent plutôt sur place",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} et {npc:821} se tiennent au sommet de la tour de pierre. {npc:491} est dans la tour, {npc:878} et {npc:253092} sur le flanc sud de la colline, près de l'auberge et de {npc:523}, le maître des griffons.",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089} : Posture défensive",
}
