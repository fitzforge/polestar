-- French (frFR): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Maître de vol de {area:1099}",

	-- Step 3: Gadgetzan
	-- {npc:7876} Tran'rek · {area:979} Sandsorrow Watch
	["The flight lands beside {npc:7876}. Take the town's quests before riding west to {area:979}."] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, à côté du maître des coursiers du vent",

	-- Step 5: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "À l'ouest de Gadgetzan, utilisez le {item:8584} près du point d'eau du camp troll.",

	-- Step 6: Senior Surveyor Fizzledowser
	-- {area:976} Gadgetzan · {npc:7771} Marvon Rivetseeker
	["Back east to Fizzledowser on the west side of {area:976}; {npc:7771} is south from there."] = "",

	-- Step 7: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "À l'ouest, le long de la route du sud ; {npc:7771} campe près des ruines : {area:1938}. Équipez son {item:9978} : il montre les ornements enterrés, ici et autour de {area:983}.",

	-- Step 8: Broken Pillar: kill these as you meet them
	-- {area:1938} Broken Pillar
	["{area:1938}: kill these as you meet them"] = "{area:1938} : tuez-les au passage",
	-- {area:982} Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "Au sud du {area:982}, les ogres Cognedune tiennent leur camp, avec {npc:12046} à son extrémité est. Déterrez des ornements ({quest:3161}) entre les combats.",
	["Below ground"] = "Sous terre",

	-- Step 9: Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["West, the Centipaar insects swarm around their hives; any of them drops the parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "À l'ouest, les insectes Centipaar grouillent autour de leurs ruches ; n'importe lequel lâche les pièces.\nAttention : les Traînards Centipaar lancent {npc:4196} en combat comme hors combat, ce qui fait venir de petits monstres qui vous interrompent.",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362} : tuez-les au passage",
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "À l'ouest de l'enceinte, les créatures cactus remplissent la vallée ; seuls les Collecteurs de rosée portent une glande à rosée. La plupart des monstres de {zone:1446} peuvent lâcher, rarement, la balise de détresse d'OOX-17/TN : gardez-la si vous en voyez une.\nAttention : les autres chardonniers de la zone sont de niveau 49-50 et se déplacent beaucoup, il est donc facile d'attirer des monstres en plus.",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, butin rare",

	-- Step 11: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Escorte de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} attend dans la vallée. Accompagnez-le jusqu'à sa femme {npc:6015} à {area:977}, au nord-est à travers le désert : restez près de lui, ralentissez pour lui et repoussez ce qui l'attaque. Ne montez pas en selle et n'utilisez pas votre pierre de foyer hors de sa portée. {npc:8579} se tient aussi dans le port.",

	-- Step 13: Slake That Thirst
	-- {spell:686} Shadow Bolt
	["Careful: Shadow Mages (level 42-43) call a Voidwalker while out of combat and attack with Immolate and {spell:686}. Thieves can Disarm you, Rogues move around in Sneak, and Assassins use Execute once you are at 20% health or less."] = "Attention : les Mages des ombres (niveau 42-43) invoquent un Marcheur du Vide hors combat et attaquent avec Immolation et {spell:686}. Les Malandrins peuvent vous désarmer, les Voleurs se déplacent camouflés, et les Assassins utilisent Exécution une fois que vous êtes à 20 % de vie ou moins.",

	-- Step 14: Gadgetzan
	["Use the Model 4711-FTZ Power Source Bilgewhizzle gave you: a two-hour timer starts"] = "",

	-- Step 15: Gadgetzan
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "la {item:8526} pousse dans {zone:1425}, vers le niveau 48",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",

	-- Step 16: Tanaris Field Sampling
	-- {area:976} Gadgetzan
	-- plural, as words: Blisterpaw Hyenas = {npc:5426} Blisterpaw Hyena · Glasshide Basilisks = {npc:5419} Glasshide Basilisk · Scorpid Hunters = {npc:5422} Scorpid Hunter
	["Just south of {area:976} the Blisterpaw Hyenas, Glasshide Basilisks and Scorpid Hunters share the dunes. Each can drop an untested sample: use it, and it either passes as an acceptable one or is lost. Keep killing until you have eight of each."] = "",

	-- Step 18: Scrimshank's gear
	["Scrimshank's gear"] = "Équipement d'analyse de Scrimshank",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Plus au sud, l'équipement du géomètre débutant Scrimshank se trouve à l'entrée d'une ruche Centipaar.\nAttention : un insecte garde l'équipement. De nombreux insectes patrouillent dans les tunnels, certains de niveau 50, les combats attirent donc souvent des monstres en plus.",

	-- Step 19: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}.\nCareful: The escort has two ambushes. Three level 47 scorpids attack near the start. Near the end, by the beach, three Wastewander humans attack: one mage and two assassins, around level 44."] = "Seulement avec la balise de détresse : OOX-17/TN se trouve au sud-est de la ruche de Scrimshank. Escortez-le vers le nord jusqu'à {area:977} ; sa récompense vous attend auprès d'Oglethorpe, à {area:35}.\nAttention : l'escorte comporte deux embuscades. Trois scorpides de niveau 47 attaquent près du départ. Vers la fin, près de la plage, trois humains Bat-le-désert attaquent : un mage et deux assassins, autour du niveau 44.",

	-- Step 20: Gadgetzan
	-- {npc:5204} Apothecary Zinge · {zone:1458} Undercity
	["for {npc:5204} in the {zone:1458}, around level 52"] = "",
	-- {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["for {npc:7010} in {zone:1454}, around level 50"] = "pour {npc:7010} à {zone:1454}, vers le niveau 50",

	-- Step 21: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Bateau pour {area:16727}",

	-- Step 22: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "Vers la {zone:1427}",

	-- Step 23: Searing Gorge
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",

	-- Step 24: The Grimesilt Dig Site
	-- {area:16727} Powderfuse Port · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:16727}, ride into the {zone:1427} by its eastern pass, then west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "les {object:173265}",

	-- Step 26: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Traversez la gorge vers le nord-ouest ; {area:1446} est le camp entouré d'échafaudages au nord-ouest.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Le panneau {object:179827}",

	-- Step 27: The Cauldron's slavers and golems
	-- {area:246} The Cauldron
	["{area:246}'s slavers and golems"] = "",
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	-- plural, as words: Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Heavy War Golems = {npc:5854} Heavy War Golem
	["Ride south from {area:1446} into the Cauldron: the Dark Iron Taskmasters and Slavers drive the slaves on the paths, and the Heavy War Golems patrol the floor below {npc:8479}."] = "",

	-- Step 28: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "",

	-- Step 31: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427} : tuez-les au passage",
	-- {npc:8479} Velarok Windblade · {item:11818} Grimesilt Outhouse Key · {area:1443} The Slag Pit
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Greater Lava Spiders = {npc:5858} Greater Lava Spider · Incendosaurs = {npc:9318} Incendosaur · Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Heavy War Golems patrol the Cauldron below {npc:8479} and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, butin rare",

	-- Step 33: Thorium Point
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	["Ride back north to {area:1446}, just past {npc:8479}."] = "",

	-- Step 34: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "Les fourneaux des Forge-vapeur",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Les Forge-vapeur Sombrefer travaillent aux fourneaux au milieu du Chaudron ; la moitié d'entre eux portent une {item:10551}, un sur dix la {item:18959}. Les Esclaves, les Esclavagistes et les Sous-chefs portent aussi des dagues.",

	-- Step 35: Velarok Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "Sa demande suivante exige le {item:10552} sur des cultistes élites : laissez-la.",

	-- Step 37: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Guetteurs Sombrefer",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Les Guetteurs Sombrefer se tiennent sur les crêtes autour des tours de guet au sud du Chaudron ; environ un sur dix porte la {item:18960}.",

	-- Step 38: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "Seulement avec la {item:11818} : retournez à l'est jusqu'aux {object:173265} du site de fouilles.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Bateau pour {area:35}",
	-- ["Dark Iron Lookouts"] = "Guetteurs Sombrefer ({npc:8566})",
	-- ["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "Prenez un vol pour {area:1637} et entraînez-vous : la prochaine étape d'entraînement du guide suivant est {zone:1458}, sans maître des chasseurs ni des chamans. Puis prenez un vol pour {area:392}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "Prenez un vol pour {area:1638} et entraînez-vous auprès de {npc:3033} sur {area:1639}, puis prenez un vol pour {area:392}.",
	-- ["Fly to {area:340}"] = "Prendre un vol pour {area:340}",
	-- ["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- ["From the {area:35} flight master, above the harbour."] = "Depuis le maître de vol de {area:35}, au-dessus du port.",
	-- ["From {area:1099}'s flight master."] = "Depuis le maître de vol de {area:1099}.",
	-- ["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Plus au sud, l'Équipement d'analyse de Scrimshank se trouve à l'entrée d'une ruche Centipaar.",
	-- ["Greater Lava Spiders"] = "Grandes araignées de lave",
	-- ["Hearth to {area:976}"] = "Pierre de foyer vers {area:976}",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Les Golems de guerre lourds ({npc:5854}) patrouillent dans le Chaudron sous Velarok et lâchent l'huile ; les Elémentaires de magma et flamboyants ({npc:5850}) qui dérivent parmi eux lâchent les cœurs. Les Sous-chefs Sombrefer ({npc:5846}) et les Esclavagistes mènent les esclaves sur les chemins ; un Esclavagiste peut lâcher {item:11818} : gardez-la.",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Les Golems de guerre lourds patrouillent dans le Chaudron sous Kalaran et lâchent l'huile ; les Élémentaires de magma et les Élémentaires flamboyants qui errent parmi eux lâchent les cœurs. Les Sous-chefs et les Esclavagistes Sombrefer mènent les esclaves sur les chemins ; un Esclavagiste peut lâcher la {item:11818} : gardez-la.\nLes Araignées de lave incendiaires parcourent les plateaux et les mares de lave au sud-ouest de la gorge.\n{area:1443} s'ouvre au nord du Chaudron. Des Incendosaures nagent dans ses mares de lave : attirez-les vers le bord. Les plans secrets se trouvent sur la corniche supérieure de la fosse.\nAttention : les Esclavagistes Sombrefer (niveau 45-46) appellent à l'aide les alliés à moins de 15 m quand ils sont attirés, lancent Filet jusqu'à 15 m et utilisent Pourfendre au corps à corps.",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The {object:147516} Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Les Golems de guerre lourds patrouillent dans le Chaudron sous Kalaran et lâchent l'huile ; les Élémentaires de magma et les Élémentaires flamboyants qui errent parmi eux lâchent les cœurs. Les Sous-chefs et les Esclavagistes {object:147516} mènent les esclaves sur les chemins ; un Esclavagiste peut lâcher la {item:11818} : gardez-la.",
	-- ["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "Kalaran se tient seul au sud de {area:1446}, au bord du Chaudron. Écoutez son histoire.",
	-- ["On the way"] = "En chemin",
	-- ["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "Seulement avec la balise de détresse : OOX-17/TN se trouve au sud-est de la ruche de Scrimshank. Escortez-le vers le nord jusqu'à {area:977} ; sa récompense attend auprès d'Oglethorpe à {area:35}.",
	-- ["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Revenez au nord jusqu'à {area:1446}. Restez ici : le guide suivant commence par le vol pour {area:75}.",
	-- ["Ride south-west to {area:976}."] = "Chevauchez vers le sud-ouest jusqu'à {area:976}.",
	-- ["South down the road again."] = "Redescendez la route vers le sud.",
	-- ["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "Au sud-est de Gadgetzan, les bandits Bat-le-désert campent dans les dunes ; {npc:7847} se tient dans le camp est.",
	-- ["Take the pass out of {area:340}'s west side into the {area:51}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Prenez le col qui part du côté ouest de {area:340} pour entrer dans la {area:51}, puis allez vers le sud-ouest jusqu'au site de fouilles. Les {object:173265} se trouvent à son extrémité sud ; les Géologues Sombrefer creusent juste au nord. Apportez 15 {item:4306} (l'hôtel des ventes en vend).",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Prenez le col à l'ouest de {area:340} pour entrer dans la {zone:1427}, puis chevauchez vers le sud-ouest jusqu'au site de fouilles. {object:173265} se dresse à son extrémité sud ; les Géologues Sombrefer ({npc:5839}) creusent juste au nord. Apportez 15 {item:4306} (l'hôtel des ventes en vend).",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the {object:147516} Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Prenez le col à l'ouest de {area:340} vers {zone:1427}, puis chevauchez au sud-ouest jusqu'au site de fouilles. Les {object:173265} se trouvent à son extrémité sud ; les Géologues {object:147516} creusent juste au nord. Apportez 15 {item:4306} (l'hôtel des ventes en vend).",
	-- ["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Les Guetteurs Sombrefer ({npc:8566}) se tiennent sur les crêtes autour des tours de guet au sud du Chaudron ; environ un sur dix porte {item:18960}.",
	-- ["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Les Forge-vapeur Sombrefer ({npc:5840}) travaillent aux fourneaux au milieu du Chaudron ; la moitié porte une {item:10551}, un sur dix {item:18959}. Esclaves, Esclavagistes et Sous-chefs portent aussi des dagues.",
	-- ["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Les Grandes araignées de lave rôdent sur les plateaux et autour des bassins de lave au sud-ouest de la gorge.",
	-- ["The Steamsmiths' furnaces"] = "Les fourneaux des Forge-vapeur",
	-- ["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "Le bateau pour {area:35} accoste au quai de {area:392}, sous la colline du maître de vol.",
	-- ["The {object:147516} Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Les Guetteurs {object:147516} se tiennent sur les crêtes autour des tours de guet au sud du Chaudron ; environ un sur dix porte la {item:18960}.",
	-- ["The {object:147516} Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Les Forge-vapeur {object:147516} travaillent aux fourneaux au centre du Chaudron ; la moitié porte une {item:10551}, un sur dix la {item:18959}. Les esclaves, les Esclavagistes et les Sous-chefs portent aussi des dagues.",
	-- ["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "À l'ouest du camp, les créatures cactus remplissent la vallée ; seuls les Chardonniers collecteurs de rosée portent une glande de rosée. La plupart des monstres de {zone:1446} peuvent lâcher, rarement, la Balise de détresse OOX-17/TN : gardez-la si vous en trouvez une.",
	-- ["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "À l'ouest, les insectes Centipaar grouillent autour de leurs ruches ; n'importe lequel lâche les pièces.",
	-- ["for {npc:7010} in {area:1637}, around level 50"] = "pour {npc:7010} à {area:1637}, vers le niveau 50",
	-- ["the {object:150075} in the square"] = "l'{object:150075} sur la place",
	-- ["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} s'ouvre au nord du Chaudron. Les Incendosaures nagent dans ses bassins de lave : attirez-les au bord. Les plans secrets sont sur la corniche supérieure de la fosse.",
	-- ["{area:392} pier"] = "Quai de {area:392}",
	-- ["{npc:5844} along the way to {area:1446}"] = "{npc:5844} sur le chemin de {area:1446}",
	-- ["{npc:5846} along the way to {area:1446}"] = "{npc:5846} sur le chemin de {area:1446}",
	-- ["{npc:5854} along the way to {area:1446}"] = "{npc:5854} sur le chemin de {area:1446}",
	-- ["{npc:5858} on the way"] = "{npc:5858} en chemin",
	-- ["{object:147516} Lookouts"] = "Guetteurs {object:147516}",
}
