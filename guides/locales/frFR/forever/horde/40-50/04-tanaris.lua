-- French (frFR): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- {area:1099} Camp Mojache
	["From {area:1099}'s flight master."] = "Depuis le maître de vol de {area:1099}.",

	-- Step 2: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, à côté du maître des coursiers du vent",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "l'{object:150075} sur la place",

	-- Step 3: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "À l'ouest de Gadgetzan, utilisez le {item:8584} près du point d'eau du camp troll.",

	-- Step 5: Caliph Scorpidsting
	-- {npc:7847} Caliph Scorpidsting
	["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "Au sud-est de Gadgetzan, les bandits Bat-le-désert campent dans les dunes ; {npc:7847} se tient dans le camp est.",

	-- Step 6: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "À l'ouest, le long de la route du sud ; {npc:7771} campe près des ruines : {area:1938}. Équipez son {item:9978} : il montre les ornements enterrés, ici et autour de {area:983}.",

	-- Step 7: The Noxious Lair
	["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "À l'ouest, les insectes Centipaar grouillent autour de leurs ruches ; n'importe lequel lâche les pièces.",

	-- Step 8: Dunemaul Compound
	-- {area:982} The Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "Au sud du {area:982}, les ogres Cognedune tiennent leur camp, avec {npc:12046} à son extrémité est. Déterrez des ornements ({quest:3161}) entre les combats.",

	-- Step 9: Thistleshrub Valley
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "À l'ouest du camp, les créatures cactus remplissent la vallée ; seuls les Chardonniers collecteurs de rosée portent une glande de rosée. La plupart des monstres de {zone:1446} peuvent lâcher, rarement, la Balise de détresse OOX-17/TN : gardez-la si vous en trouvez une.",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, butin rare",

	-- Step 10: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Escorte de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} attend dans la vallée. Accompagnez-le jusqu'à sa femme {npc:6015} à {area:977}, au nord-est à travers le désert : restez près de lui, ralentissez pour lui et repoussez ce qui l'attaque. Ne montez pas en selle et n'utilisez pas votre pierre de foyer hors de sa portée. {npc:8579} se tient aussi dans le port.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride south-west to {area:976}."] = "Chevauchez vers le sud-ouest jusqu'à {area:976}.",
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "la {item:8526} pousse dans {zone:1425}, vers le niveau 48",

	-- Step 12: Marvon Rivetseeker
	["South down the road again."] = "Redescendez la route vers le sud.",

	-- Step 13: Scrimshank's gear
	["Scrimshank's gear"] = "Équipement d'analyse de Scrimshank",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Plus au sud, l'Équipement d'analyse de Scrimshank se trouve à l'entrée d'une ruche Centipaar.",

	-- Step 14: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "Seulement avec la balise de détresse : OOX-17/TN se trouve au sud-est de la ruche de Scrimshank. Escortez-le vers le nord jusqu'à {area:977} ; sa récompense attend auprès d'Oglethorpe à {area:35}.",

	-- Step 15: Gadgetzan
	-- {npc:7010} Zilzibin Drumlore · {area:1637} Orgrimmar
	["for {npc:7010} in {area:1637}, around level 50"] = "pour {npc:7010} à {area:1637}, vers le niveau 50",

	-- Step 16: Orgrimmar
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {area:392} Ratchet
	["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "Prenez un vol pour {area:1637} et entraînez-vous : la prochaine étape d'entraînement du guide suivant est {zone:1458}, sans maître des chasseurs ni des chamans. Puis prenez un vol pour {area:392}.",

	-- Step 17: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:392} Ratchet
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "Prenez un vol pour {area:1638} et entraînez-vous auprès de {npc:3033} sur {area:1639}, puis prenez un vol pour {area:392}.",

	-- Step 18: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Prendre un vol pour {area:392}",

	-- Step 19: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Bateau pour {area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "Le bateau pour {area:35} accoste au quai de {area:392}, sous la colline du maître de vol.",
	-- {area:392} Ratchet
	["{area:392} pier"] = "Quai de {area:392}",

	-- Step 20: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Prendre un vol pour {area:340}",
	-- {area:35} Booty Bay
	["From the {area:35} flight master, above the harbour."] = "Depuis le maître de vol de {area:35}, au-dessus du port.",

	-- Step 21: The Grimesilt Dig Site
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Prenez le col à l'ouest de {area:340} pour entrer dans la {zone:1427}, puis chevauchez vers le sud-ouest jusqu'au site de fouilles. {object:173265} se dresse à son extrémité sud ; les Géologues Sombrefer ({npc:5839}) creusent juste au nord. Apportez 15 {item:4306} (l'hôtel des ventes en vend).",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "les {object:173265}",

	-- Step 22: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Chevauchez au nord-ouest à travers la gorge ; {area:1446} est le camp aux échafaudages au nord-ouest.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Le panneau {object:179827}",

	-- Step 23: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "Kalaran se tient seul au sud de {area:1446}, au bord du Chaudron. Écoutez son histoire.",

	-- Step 24: The Cauldron
	-- {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster
	["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Les Golems de guerre lourds ({npc:5854}) patrouillent dans le Chaudron sous Velarok et lâchent l'huile ; les Elémentaires de magma et flamboyants ({npc:5850}) qui dérivent parmi eux lâchent les cœurs. Les Sous-chefs Sombrefer ({npc:5846}) et les Esclavagistes mènent les esclaves sur les chemins ; un Esclavagiste peut lâcher {item:11818} : gardez-la.",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, butin rare",

	-- Step 26: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "Les fourneaux des Forge-vapeur",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Les Forge-vapeur Sombrefer ({npc:5840}) travaillent aux fourneaux au milieu du Chaudron ; la moitié porte une {item:10551}, un sur dix {item:18959}. Esclaves, Esclavagistes et Sous-chefs portent aussi des dagues.",

	-- Step 27: Kalaran Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "Sa demande suivante exige le {item:10552} sur des cultistes élites : laissez-la.",

	-- Step 28: The Slag Pit
	-- {area:1443} The Slag Pit
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} s'ouvre au nord du Chaudron. Les Incendosaures nagent dans ses bassins de lave : attirez-les au bord. Les plans secrets sont sur la corniche supérieure de la fosse.",

	-- Step 29: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Grandes araignées de lave",
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Les Grandes araignées de lave rôdent sur les plateaux et autour des bassins de lave au sud-ouest de la gorge.",

	-- Step 30: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Guetteurs Sombrefer ({npc:8566})",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Les Guetteurs Sombrefer ({npc:8566}) se tiennent sur les crêtes autour des tours de guet au sud du Chaudron ; environ un sur dix porte {item:18960}.",

	-- Step 31: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "Seulement avec la {item:11818} : retournez à l'est jusqu'aux {object:173265} du site de fouilles.",

	-- Step 32: Thorium Point
	-- {area:1446} Thorium Point · {area:75} Stonard
	["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Revenez au nord jusqu'à {area:1446}. Restez ici : le guide suivant commence par le vol pour {area:75}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The {object:147516} Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Les Golems de guerre lourds patrouillent dans le Chaudron sous Kalaran et lâchent l'huile ; les Élémentaires de magma et les Élémentaires flamboyants qui errent parmi eux lâchent les cœurs. Les Sous-chefs et les Esclavagistes {object:147516} mènent les esclaves sur les chemins ; un Esclavagiste peut lâcher la {item:11818} : gardez-la.",
	-- ["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "Au sud de {area:982}, les ogres Cognedune tiennent leur camp, avec {npc:12046} à son extrémité est. Déterrez des ornements ({quest:3161}) entre les combats.",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the {object:147516} Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Prenez le col à l'ouest de {area:340} vers {zone:1427}, puis chevauchez au sud-ouest jusqu'au site de fouilles. Les {object:173265} se trouvent à son extrémité sud ; les Géologues {object:147516} creusent juste au nord. Apportez 15 {item:4306} (l'hôtel des ventes en vend).",
	-- ["The {object:147516} Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Les Guetteurs {object:147516} se tiennent sur les crêtes autour des tours de guet au sud du Chaudron ; environ un sur dix porte la {item:18960}.",
	-- ["The {object:147516} Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Les Forge-vapeur {object:147516} travaillent aux fourneaux au centre du Chaudron ; la moitié porte une {item:10551}, un sur dix la {item:18959}. Les esclaves, les Esclavagistes et les Sous-chefs portent aussi des dagues.",
	-- ["{object:147516} Lookouts"] = "Guetteurs {object:147516}",
}
