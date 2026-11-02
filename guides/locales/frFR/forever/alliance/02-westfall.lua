-- French (frFR): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Jansen Stead
	-- {area:40} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {area:40}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237} ; les Humains l'ont pris à {npc:963} à Elwynn",

	-- Step 3: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Seulement si vous avez ramassé un {item:1972} dans la forêt d'Elwynn : faites un clic droit dessus",

	-- Step 4: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "Au sud de la route, après l'embranchement. {npc:233} se tient dehors, {npc:235} dans la maison, {npc:253395} dans la grange à l'ouest. De jeunes Défenses et Écorcheurs rôdent dans les champs autour de la ferme : commencez par les foies et la viande du ragoût en chemin.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "",

	-- Step 5: Goretusk Snout on the way
	-- {item:731} Goretusk Snout
	["{item:731} on the way"] = "",

	-- Step 6: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} et {npc:821} se tiennent au sommet de la tour de pierre. {npc:491} est dans la tour, {npc:878} sur le flanc sud de la colline, près de l'auberge et de {npc:523}, le maître des griffons.",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523} ; ignorez le vol gratuit proposé",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, à côté de {npc:878}",

	-- Step 8: Westfall: kill these as you meet them
	-- {area:40} Westfall
	["{area:40}: kill these as you meet them"] = "",
	-- {object:290} Furlbrow's Wardrobe · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Harvest Watchers = {npc:114} Harvest Watcher
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine.\nWest of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Gardiens des moissons",

	-- Step 10: The Jansen Stead
	["Fill the vial at the well"] = "Remplissez la fiole au puits",

	-- Step 11: Westfall: kill these as you meet them
	["Fill the vial at the farm's well"] = "Remplissez la fiole au puits de la ferme",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729} : Déchireurs",

	-- Step 12: Furlbrow's Pumpkin Farm: kill these as you meet them
	-- {area:109} Furlbrow's Pumpkin Farm
	["{area:109}: kill these as you meet them"] = "",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll · Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nMurloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer.\nCareful: Two Defias stand guard inside the house, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153} : tous les Défias en lâchent",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Pattes de gnoll",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Branchies de Murloc de Longrivage",

	-- Step 13: Handful of Oats
	["Sacks of Oats in the fields around the farm"] = "",

	-- Step 15: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Pour {npc:266} à {area:69}, dans les Carmines",

	-- Step 16: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "Retournez au nord au-delà de {area:918} jusqu'à la mine : des Terrassiers kobolds travaillent à l'intérieur.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Terrassiers kobolds",

	-- Step 17: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "Au sud-ouest vers la côte, à l'ouest de {area:918}. Des Mineurs Rivepatte travaillent dans la carrière.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineurs Rivepatte",

	-- Step 18: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "",

	-- Step 20: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} et les collines des Défias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, dans les caisses autour de {area:20}",

	-- Step 21: Hearth to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Hearth to {area:108}"] = "",

	-- Step 22: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "Retour à {area:108}",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Pour {npc:11026} dans {object:28027} de {zone:1453}",

	-- Step 26: Defensive Stance
	["Defensive Stance"] = "",
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Volez ou marchez jusqu'à {zone:1453}. {npc:5480} entraîne les guerriers dans {object:2100} ; {npc:6089} et {npc:6090} se tiennent ensemble près de {object:2152} là-bas. {npc:6090} vous combat pour sa chope.",
	-- {npc:6089} Harry Burlguard
	["{npc:6089}: Defensive Stance"] = "",

	-- Step 28: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Volez ou marchez jusqu'à {zone:1453}. {npc:376} est dans la Cathédrale de la Lumière.",

	-- Step 30: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "",

	-- Step 32: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 33: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Allez à {zone:1453}. Il n'y a pas de formateur chaman : prenez le {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous avec {npc:258098}, puis reprenez le tram pour le bateau.",

	-- Step 34: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter
	["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Volez ou marchez jusqu'à {zone:1453}. Formateurs : {object:2100} (Guerriers, Voleurs), la Cathédrale (Paladins, Prêtres), {object:2101} (Mages, Démonistes), le Parc (Druides).",
	["Level 12, 14 and 16 spells"] = "Sorts des niveaux 12, 14 et 16",

	-- Step 35: Back to Stormwind City
	-- {area:1519} Stormwind City
	["Back to {area:1519}"] = "",

	-- Step 37: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} pour Rassembler les ingrédients du remède (6123) à {zone:1439} : {npc:1313}, Fournitures d'alchimie ; les herboristes la cueillent plutôt là-bas",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, au sanctum des mages : {quest:1861}",

	-- Step 39: Stormwind City
	["Stormwind City"] = "",

	-- Step 40: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 41: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 42: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 43: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 44: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 46: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vend des articles de pêche le long du canal, juste à l'ouest de {object:2096} ; {npc:267118} pêche au port, sur le chemin du bateau.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, chez {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defensive Stance"] = "Posture défensive",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Des Eclaireurs défias et des Truands défias arpentent {area:20} ; des Malandrins défias (niveau 17) patrouillent par deux dans les collines au sud et à l'est : séparez-les. L'entrée de {area:1581}, dans la forge, mène à un donjon de groupe.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Des Pilleurs défias et des Pillards défias tiennent les fermes à l'ouest de {area:108}, entre la route côtière et {area:20}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), le parc (druides).",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), le parc (druides). {npc:11026} travaille dans {object:28027}, {npc:279} dans {object:2096}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:23299} (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), {object:23299} (druides). {npc:11026} travaille dans {object:28027}, {npc:279} dans {object:2096}.",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Rendez-vous à {zone:1453} en vol ou à cheval. {npc:376} est dans la cathédrale de la Lumière.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Rendez-vous à {zone:1453} en vol ou à cheval. {npc:5480} entraîne les guerriers dans {object:2100} ; {npc:6089} et {npc:6090} s'y tiennent ensemble près de {object:2152}. {npc:6090} vous affronte pour sa chope.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "Suivez la route depuis Elwynn vers {zone:1436} : les Furlbrow sont assis près de leur ferme brûlée, la première sur la route. Ramassez l'avoine dans les Sacs d'avoine des champs en chemin.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Suivez la route vers le nord. {npc:233} se tient dehors, {npc:235} dans la maison, {npc:253395} dans la grange à l'ouest.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Plus au nord sur la route. Les Furlbrow sont assis près de leur ferme incendiée. En chemin, ramassez l'avoine des Sacs d'avoine dans les champs et remplissez la fiole au puits de la ferme.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Plus au nord sur la route. Les Furlbrow sont assis près de leur ferme incendiée. En chemin, ramassez l'avoine des Sacs d'avoine dans les champs.",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "Pierre de foyer en recharge ? Suivez la route vers le nord-est.",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Des Cours-la-côte murlocs et des Ecumeurs murlocs bordent la plage au nord de la mine. Ils fuient quand ils sont blessés : attirez-les un par un.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Au nord de la ferme des Molsen. Des Trappeurs défias et des Contrebandiers défias campent devant la mine, des Terrassiers kobolds travaillent à l'intérieur. {object:290} se trouve près de la maison en ruine à l'est de la mine.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "Au nord de la ferme des Molsen. Des Trappeurs défias et des Contrebandiers défias campent devant la mine. {object:290} se trouve près de la maison en ruine à l'est de la mine.",
	-- ["Only if he takes the isosprings alone"] = "Seulement s'il prend les isoressorts seuls",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Rendez-vous à {zone:1453}. La ville n'a pas de maître des chamans : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour le bateau.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "Les Gnolls et éclaireurs de la Patte-de-rivière (niveau 11-13) rôdent dans les collines au sud de la côte, de au-dessus de {area:111} vers l'est jusqu'au {area:916}. Les gnolls plus au sud et à l'ouest sont de niveau 13-19 : restez dans les collines nord.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Des Gnolls Rivepatte et des Eclaireurs Rivepatte parcourent les collines entre la côte et la {area:916}.",
	-- ["Sacks of Oats"] = "Sacs d'avoine",
	-- ["The gnoll hills"] = "Les collines des gnolls",
	-- ["The north coast"] = "La côte nord",
	-- ["The western farms"] = "Les fermes de l'ouest",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "À l'ouest de la ferme des Molsen, vers la côte. Des Mineurs Rivepatte travaillent dans la carrière.",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "À l'ouest de chez Saldean. Des Gardiens des moissons et des Golems des moissons travaillent les champs ; ils lâchent les isoressorts, les gyrostabiliseurs, du {item:732} et parfois un {item:255155}. {npc:573}, un rare de niveau 20, rôde ici : laissez-le tranquille. Continuez à tuer des Broche-tripes et des Déchireurs à chaque étape de cette boucle.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Des Jeunes Broche-tripes et des Déchireurs parcourent les champs autour de la ferme : commencez les foies et la viande du ragoût au retour.",
	-- ["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, {skill:171} Supplies; herbalists pick it there instead"] = "{item:2449} pour Rassembler les ingrédients du remède (6123) à {zone:1439} : {npc:1313}, fournitures d'{skill:171} ; les herboristes la cueillent plutôt sur place",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} et {npc:821} se tiennent au sommet de la tour de pierre. {npc:491} est dans la tour, {npc:878} et {npc:253092} sur le flanc sud de la colline, près de l'auberge et de {npc:523}, le maître des griffons.",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089} : Posture défensive",
}
