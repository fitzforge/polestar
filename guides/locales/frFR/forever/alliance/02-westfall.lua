-- French (frFR): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Goldshire
	-- {zone:1453} Stormwind · {zone:1436} Westfall · {area:87} Goldshire · {npc:241} Remy "Two Times" · {npc:240} Marshal Dughan · {quest:40} A Fishy Peril · {quest:35} Further Concerns · {quest:109} Report to Gryan Stoutmantle
	["On the road from {zone:1453} to {zone:1436}, {area:87} is the first stop: {npc:241} stands outside the inn, {npc:240} beside him. {npc:241}'s {quest:40} goes straight to Dughan, who then gives {quest:35}; his {quest:109} goes with you to {zone:1436}."] = "",
	-- {npc:240} Marshal Dughan · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:240}: for {npc:234} at {area:108}"] = "",

	-- Step 2: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "La {area:91}",
	-- {area:18} Crystal Lake · {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["East along the road past {area:18}: {npc:248242} and {npc:248248} stand at the foot of the tower."] = "",

	-- Step 3: The bridge
	["The bridge"] = "Le pont",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	-- plural, as words: Prowlers = {npc:118} Prowler
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it. His tools and Thomas's Prowlers and bears are south of the bridge, on the way back."] = "",

	-- Step 4: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "Le {area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "Le camp se trouve au nord-est du pont. Les Fagots de bois traînent autour du camp et dans les bois au nord de celui-ci.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "{npc:278}, à l'intérieur",

	-- Step 5: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Il gît près de la rivière, au nord-ouest du camp de bûcherons.",

	-- Step 6: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Les Sorciers-voleurs défias campent sur les rives du {area:86} ; ils laissent aussi tomber les Masques rouges en lin. Le {object:56} gît dans le village murloc de la rive nord-est.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Masques rouges en lin",

	-- Step 7: The gnoll camps
	["The gnoll camps"] = "Les camps gnolls",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Les gnolls Rivepatte campent dans les collines à l'ouest du {area:86} ; les {quest:91725} se trouvent dans leurs camps.",

	-- Step 8: The Jasperlode Mine's entrance
	-- {area:54} Jasperlode Mine
	["The {area:54}'s entrance"] = "",

	-- Step 9: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "{area:54} : tuez-les au passage",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "La mine se trouve au sud-ouest des camps gnolls. Les {item:247816} traînent près de l'entrée ; les Géomanciens kobolds occupent les tunnels.",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "{npc:476} se promène autour de {area:54} : cherchez dans le cercle sur la carte",

	-- Step 10: The Tower of Azora
	["Follow the hills south to the tower."] = "Suivez les collines vers le sud jusqu'à la tour.",

	-- Step 11: Downstream
	-- {item:247813} Waterlogged Saw
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["East along the road, then into the river south of the bridge: the {item:247813}, Axe and Toolbox lie in it. Prowlers and Young Forest Bears roam its banks."] = "",

	-- Step 14: Goldshire
	-- {area:87} Goldshire · {zone:1436} Westfall · {npc:240} Marshal Dughan
	["Follow the road west to {area:87}, on the way to {zone:1436}: {npc:240} stands outside the inn."] = "",

	-- Step 15: The Jansen Stead
	-- {zone:1436} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "Suivez la route depuis la forêt d'Elwynn jusqu'à {zone:1436} : les Furlbrow sont assis près de leur ferme incendiée, la première sur la route. Ramassez de l'avoine sur chaque {object:2724} que vous croisez pendant la boucle : le reste se ramasse dans les champs d'ici, au retour.",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237} ; les Humains l'ont pris à {npc:963} à Elwynn",

	-- Step 17: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Seulement si vous avez ramassé un {item:1972} dans la forêt d'Elwynn : faites un clic droit dessus",

	-- Step 18: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "Au sud de la route, après l'embranchement. {npc:233} se tient dehors, {npc:235} dans la maison, {npc:253395} dans la grange à l'ouest. De jeunes Défenses et Écorcheurs rôdent dans les champs autour de la ferme : commencez par les foies et la viande du ragoût en chemin.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "{npc:235}, à l'intérieur",

	-- Step 19: Goretusk Snouts
	-- plural, as words: Goretusk Snouts = {item:731} Goretusk Snout
	["Goretusk Snouts"] = "",
	-- {area:108} Sentinel Hill
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks root in the fields along the road south from Saldean's to {area:108}: take their snouts on the way."] = "",

	-- Step 20: Sentinel Hill's tower and Thor
	-- {area:108} Sentinel Hill · {npc:523} Thor
	["{area:108}'s tower and {npc:523}"] = "",
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:523} Thor · {npc:878} Scout Galiaan · {npc:1323} Osric Strang · {zone:1453} Stormwind · {npc:279} Morgan Pestle · {object:2096} Trade District · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town · {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {npc:352} Dungar Longdrink
	["{npc:234} and {npc:821} stand at the top of the stone tower, {npc:491} inside it, {npc:523} the gryphon master on the south side of the hill with {npc:878} beside him. {npc:523} gives you Lewis' note for {npc:1323} with a free flight to {zone:1453}: take it now. In {zone:1453}, {npc:279}'s shop is in the {object:2096} by the gryphons, {npc:1323}'s shop, {object:2156}, in {object:2100}; {npc:1646} stands in {object:2098} on the way back to {npc:352}, the gryphon master."] = "",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "{npc:491}, à l'intérieur",
	-- {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:878}, beside {npc:523}"] = "",
	-- {npc:523} Thor · {zone:1453} Stormwind
	["{npc:523}: the free flight he offers goes to {zone:1453}"] = "",

	-- Step 21: Osric Strang
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, {object:2096}, by the gryphons"] = "",
	-- {npc:1323} Osric Strang · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town
	["{npc:1323}, {object:2156} in {object:2100}"] = "",
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646}, {object:2098}: his compass is in his old house in {zone:1436}"] = "",
	-- {npc:352} Dungar Longdrink
	["{npc:352}, the gryphon master"] = "",

	-- Step 22: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} et {npc:821} se tiennent au sommet de la tour de pierre. {npc:491} est dans la tour, {npc:878} sur le flanc sud de la colline, près de l'auberge et de {npc:523}, le maître des griffons.",
	-- {npc:234} Gryan Stoutmantle · {npc:963} Deputy Rainer
	["{npc:234}: from {npc:963} at Westbrook"] = "",
	-- {npc:491} Quartermaster Lewis · {zone:1453} Stormwind
	["{npc:491}, inside: back from {zone:1453}"] = "",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, à côté de {npc:878}",

	-- Step 24: Goretusk Livers as you go
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Goretusk Livers as you go"] = "",
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Goretusks and Young Goretusks root along every leg of this loop: kill the ones you pass for the pie's livers."] = "",

	-- Step 25: Stringy Vulture Meat as you go
	-- {item:729} Stringy Vulture Meat
	["{item:729} as you go"] = "",
	["Fleshrippers circle the fields along this loop: kill the ones you pass for the stew's meat."] = "",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729} : Déchireurs",

	-- Step 26: Red Leather Bandanas as you go
	-- {quest:153} Red Leather Bandanas
	["{quest:153} as you go"] = "",
	-- {item:829} Red Leather Bandana · {object:290} Furlbrow's Wardrobe
	["Every Defias on this loop can drop a {item:829}: the Trappers and Smugglers, and the guards at {object:290}."] = "",

	-- Step 27: Defias Trappers and Smugglers
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Defias Trappers and Smugglers"] = "",
	-- {area:108} Sentinel Hill · {area:918} Molsen Farm
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North-west from {area:108} toward {area:918}: Defias Trappers and Smugglers camp in the fields between them."] = "",

	-- Step 28: Molsen Farm's well
	-- {area:918} Molsen Farm
	["{area:918}'s well"] = "",
	["Fill the vial at the farm's well"] = "Remplissez la fiole au puits de la ferme",

	-- Step 29: Molsen Farm's Harvest Watchers
	-- {area:918} Molsen Farm
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["{area:918}'s Harvest Watchers"] = "",
	-- {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers and Golems work the fields around {area:918}; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone."] = "",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Gardiens des moissons",

	-- Step 30: The gnoll hills
	["The gnoll hills"] = "Les collines des gnolls",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["North to the hills above {area:111}: Riverpaw Gnolls and Scouts (level 11-13) roam there, east toward the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer."] = "",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Pattes de gnoll",

	-- Step 31: The Longshore murlocs
	-- {area:2} Longshore
	["The {area:2} murlocs"] = "",
	-- {area:916} The Jansen Stead
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the north coast from above the mine east toward the {area:916}: work along the beach eastward. They flee at low health: pull one at a time."] = "",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Branchies de Murloc de Longrivage",

	-- Step 32: Furlbrow's Wardrobe
	-- {object:290} Furlbrow's Wardrobe · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	["{object:290} stands in the ruined house east of the mine, on the way to the {area:916}.\nCareful: Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "{object:290} ; à l'intérieur",

	-- Step 33: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "Sacs d'avoine dans les champs autour de la ferme",
	["Fill the vial at the well"] = "Remplissez la fiole au puits",

	-- Step 34: Finish the Goretusk Livers
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Finish the Goretusk Livers"] = "",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Still short of eight? Young Goretusks root in the fields just west of {area:107}."] = "",

	-- Step 35: Finish the Stringy Vulture Meat
	-- {item:729} Stringy Vulture Meat
	["Finish the {item:729}"] = "",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Fleshrippers = {npc:199} Young Fleshripper
	["Still short of three? Young Fleshrippers circle the fields north-west of {area:107}."] = "",

	-- Step 37: Finish the Red Leather Bandanas
	-- {quest:153} Red Leather Bandanas
	["Finish the {quest:153}"] = "",
	-- {area:108} Sentinel Hill
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Still short of fifteen? Defias Trappers camp in the fields just west of {area:108}."] = "",

	-- Step 38: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Pour {npc:266} à {area:69}, dans les Carmines",

	-- Step 39: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "Retournez au nord au-delà de {area:918} jusqu'à la mine : des Terrassiers kobolds travaillent à l'intérieur.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Terrassiers kobolds",

	-- Step 40: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "Au sud-ouest vers la côte, à l'ouest de {area:918}. Des Mineurs Rivepatte travaillent dans la carrière.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineurs Rivepatte",

	-- Step 41: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "{area:20} : tuez-les au passage",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {object:1166} Alexston's Chest · {area:219} Alexston Farmstead · {npc:1646} Baros Alexston · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}. {object:1166} stands in the farmhouse at the {area:219}, among them: {npc:1646}' compass is inside.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "",
	-- {item:2998} A Simple Compass · {object:1166} Alexston's Chest
	["{item:2998}, from {object:1166}"] = "",

	-- Step 44: Defensive Stance
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "",

	-- Step 46: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "",

	-- Step 48: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "{npc:6171} et {npc:6173} sont dans la Cathédrale de la Lumière ; {npc:6174} se tient dans {object:2096} et demande dix {item:2589} (les humanoïdes en lâchent, l'hôtel des ventes en vend).",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "Faites un clic droit sur le {item:6775} qu'il vous donne",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "{npc:6172}, près de {area:86} dans la forêt d'Elwynn, sur la route des Carmines",

	-- Step 49: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 50: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 51: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Allez à {zone:1453}. Il n'y a pas de formateur chaman : prenez le {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous avec {npc:258098}, puis reprenez le tram pour le bateau.",

	-- Step 52: Stormwind
	-- {area:1519} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Walk to {area:1519}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters), the Park (Druids)."] = "",
	["In through the main gate (already done if you are in the city)"] = "",
	["Level 12, 14 and 16 spells"] = "Sorts des niveaux 12, 14 et 16",

	-- Step 53: Back to Stormwind
	-- {zone:1453} Stormwind
	["Back to {zone:1453}"] = "Retour à {zone:1453}",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back: it comes out in {zone:1453}'s {object:28027}, where the errands below start."] = "",

	-- Step 54: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} pour Rassembler les ingrédients du remède (6123) à {zone:1439} : {npc:1313}, Fournitures d'alchimie ; les herboristes la cueillent plutôt là-bas",
	-- {npc:7232} Borgus Steelhand · {object:28027} Dwarven District · {area:442} Auberdine
	["{npc:7232}, {object:28027}: for his brother in {area:442}"] = "",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, au sanctum des mages : {quest:1861}",

	-- Step 56: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 57: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; les armes à deux mains font progresser un Paladin le plus vite.",

	-- Step 58: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Pendant que vous y êtes : apprenez le maniement des bâtons auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; l'arme de mêlée d'un Chasseur vaut surtout par ses caractéristiques, et les armes à deux mains en portent le plus.",

	-- Step 59: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Pendant que vous y êtes : apprenez le maniement des épées auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; une épée en main droite fait progresser un Voleur régulièrement.",

	-- Step 60: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Pendant que vous y êtes : apprenez le maniement des bâtons auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; un bâton apporte plus de caractéristiques de sorts qu'une arme à une main pendant la progression.",

	-- Step 62: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vend des articles de pêche le long du canal, juste à l'ouest de {object:2096} ; {npc:267118} pêche au port, sur le chemin du bateau.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, chez {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:108}"] = "Retour à {area:108}",
	-- ["Defensive Stance"] = "Posture défensive",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Des Eclaireurs défias et des Truands défias arpentent {area:20} ; des Malandrins défias (niveau 17) patrouillent par deux dans les collines au sud et à l'est : séparez-les. L'entrée de {area:1581}, dans la forge, mène à un donjon de groupe.",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "Des Éclaireurs défias et des Truands défias arpentent {area:20} ; des Malandrins défias (niveau 17) patrouillent par deux dans les collines au sud et à l'est : séparez-les. L'entrée de {area:1581}, dans la forge, mène à un donjon de groupe.\nAttention : les camps des collines abritent des groupes mêlés de Défias : il est facile d'en attirer plus d'un à la fois si votre niveau est bas.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Des Pilleurs défias et des Pillards défias tiennent les fermes à l'ouest de {area:108}, entre la route côtière et {area:20}.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "Des Pilleurs défias et des Pillards défias tiennent les fermes à l'ouest de {area:108}, entre la route côtière et {area:20}.\nAttention : la grotte de {area:113} abrite de nombreux Défias serrés les uns contre les autres : il est facile d'en attirer plusieurs à la fois.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), le parc (druides).",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), le parc (druides). {npc:11026} travaille dans {object:28027}, {npc:279} dans {object:2096}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:23299} (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Rendez-vous à {zone:1453} en vol ou à cheval. Maîtres : {object:2100} (guerriers, voleurs), la cathédrale (paladins, prêtres), {object:2101} (mages, démonistes), {object:23299} (druides). {npc:11026} travaille dans {object:28027}, {npc:279} dans {object:2096}.",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Rendez-vous à {zone:1453} en vol ou à cheval. {npc:376} est dans la cathédrale de la Lumière.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Rendez-vous à {zone:1453} en vol ou à cheval. {npc:5480} entraîne les guerriers dans {object:2100} ; {npc:6089} et {npc:6090} s'y tiennent ensemble près de {object:2152}. {npc:6090} vous affronte pour sa chope.",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Volez ou marchez jusqu'à {zone:1453}. Formateurs : {object:2100} (Guerriers, Voleurs), la Cathédrale (Paladins, Prêtres), {object:2101} (Mages, Démonistes), le Parc (Druides).",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Volez ou marchez jusqu'à {zone:1453}. {npc:376} est dans la Cathédrale de la Lumière.",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Volez ou marchez jusqu'à {zone:1453}. {npc:5480} entraîne les guerriers dans {object:2100} ; {npc:6089} et {npc:6090} se tiennent ensemble près de {object:2152} là-bas. {npc:6090} vous combat pour sa chope.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "Suivez la route depuis Elwynn vers {zone:1436} : les Furlbrow sont assis près de leur ferme brûlée, la première sur la route. Ramassez l'avoine dans les Sacs d'avoine des champs en chemin.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Suivez la route vers le nord. {npc:233} se tient dehors, {npc:235} dans la maison, {npc:253395} dans la grange à l'ouest.",
	-- ["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Pour {npc:11026} dans {object:28027} de {zone:1453}",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Plus au nord sur la route. Les Furlbrow sont assis près de leur ferme incendiée. En chemin, ramassez l'avoine des Sacs d'avoine dans les champs et remplissez la fiole au puits de la ferme.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Plus au nord sur la route. Les Furlbrow sont assis près de leur ferme incendiée. En chemin, ramassez l'avoine des Sacs d'avoine dans les champs.",
	-- ["Hearth to {area:108}"] = "Pierre de foyer vers {area:108}",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "Pierre de foyer en recharge ? Suivez la route vers le nord-est.",
	-- ["Inside"] = "À l'intérieur",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Des Cours-la-côte murlocs et des Ecumeurs murlocs bordent la plage au nord de la mine. Ils fuient quand ils sont blessés : attirez-les un par un.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Au nord de la ferme des Molsen. Des Trappeurs défias et des Contrebandiers défias campent devant la mine, des Terrassiers kobolds travaillent à l'intérieur. {object:290} se trouve près de la maison en ruine à l'est de la mine.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "Au nord de la ferme des Molsen. Des Trappeurs défias et des Contrebandiers défias campent devant la mine. {object:290} se trouve près de la maison en ruine à l'est de la mine.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine.\nWest of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "Au nord de la ferme des Molsen. Des Trappeurs défias et des Contrebandiers défias campent devant la mine. {object:290} se trouve près de la maison en ruine à l'est de la mine.\nÀ l'ouest de chez Saldean. Des Gardiens des moissons et des Golems des moissons travaillent les champs ; ils lâchent les isoressorts, les gyrostabiliseurs, du {item:732} et parfois un {item:255155}. {npc:573}, un rare de niveau 20, rôde ici : laissez-le tranquille. Continuez à tuer des Broche-tripes et des Déchireurs à chaque étape de cette boucle.",
	-- ["Only if he takes the isosprings alone"] = "Seulement s'il prend les isoressorts seuls",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Rendez-vous à {zone:1453}. La ville n'a pas de maître des chamans : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455}, entraînez-vous auprès de {npc:258098}, puis reprenez le tram pour le bateau.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "Les Gnolls et éclaireurs de la Patte-de-rivière (niveau 11-13) rôdent dans les collines au sud de la côte, de au-dessus de {area:111} vers l'est jusqu'au {area:916}. Les gnolls plus au sud et à l'ouest sont de niveau 13-19 : restez dans les collines nord.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nMurloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer.\nCareful: Two Defias stand guard inside the house, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "Des Gnolls Rivepatte et des Éclaireurs Rivepatte (niveau 11-13) parcourent les collines au sud de la côte, d'au-dessus de {area:111} vers l'est jusqu'à {area:916}. Les gnolls plus au sud et à l'ouest sont de niveau 13-19 : restez dans les collines du nord.\nDes Cours-la-côte murlocs et des Écumeurs murlocs bordent la plage au nord de la mine. Ils fuient quand ils sont blessés : attirez-les un par un.\nAttention : les gnolls proches les uns des autres ont tendance à rejoindre un combat en groupe. Les attirer un par un est plus sûr.\nAttention : deux Défias montent la garde dans la maison, dont {npc:502}, de niveau 15. Ils sont liés : attaquer l'un attire les deux.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Des Gnolls Rivepatte et des Eclaireurs Rivepatte parcourent les collines entre la côte et la {area:916}.",
	-- ["Sacks of Oats"] = "Sacs d'avoine",
	-- ["Stormwind City"] = "Cité de Hurlevent",
	-- ["The gnoll hills"] = "Les collines des gnolls",
	-- ["The north coast"] = "La côte nord",
	-- ["The western farms"] = "Les fermes de l'ouest",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "À l'ouest de la ferme des Molsen, vers la côte. Des Mineurs Rivepatte travaillent dans la carrière.",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "À l'ouest de chez Saldean. Des Gardiens des moissons et des Golems des moissons travaillent les champs ; ils lâchent les isoressorts, les gyrostabiliseurs, du {item:732} et parfois un {item:255155}. {npc:573}, un rare de niveau 20, rôde ici : laissez-le tranquille. Continuez à tuer des Broche-tripes et des Déchireurs à chaque étape de cette boucle.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Des Jeunes Broche-tripes et des Déchireurs parcourent les champs autour de la ferme : commencez les foies et la viande du ragoût au retour.",
	-- ["{area:109}: kill these as you meet them"] = "{area:109} : tuez-les au passage",
	-- ["{area:20} and the Defias hills"] = "{area:20} et les collines des Défias",
	-- ["{area:40}: kill these as you meet them"] = "{area:40} : tuez-les au passage",
	-- ["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, {skill:171} Supplies; herbalists pick it there instead"] = "{item:2449} pour Rassembler les ingrédients du remède (6123) à {zone:1439} : {npc:1313}, fournitures d'{skill:171} ; les herboristes la cueillent plutôt sur place",
	-- ["{item:254676}, from the crates around {area:20}"] = "{item:254676}, dans les caisses autour de {area:20}",
	-- ["{item:731} on the way"] = "{item:731} en chemin",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} et {npc:821} se tiennent au sommet de la tour de pierre. {npc:491} est dans la tour, {npc:878} et {npc:253092} sur le flanc sud de la colline, près de l'auberge et de {npc:523}, le maître des griffons.",
	-- ["{npc:523}; skip the free flight it offers"] = "{npc:523} ; ignorez le vol gratuit proposé",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089} : Posture défensive",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153} : tous les Défias en lâchent",
}
