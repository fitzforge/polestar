-- French (frFR): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "Vous commencez au pied d'{area:256}, le grand arbre de {area:188}.",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "{npc:2077}, près du chemin",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "{npc:1992}, au sud de l'arbre",

	-- Step 2: Shadowglen: kill these as you meet them
	-- {area:188} Shadowglen
	["{area:188}: kill these as you meet them"] = "{area:188} : tuez-les au passage",
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "Les Jeunes sabres-de-nuit et les Jeunes sangliers des chardons rôdent autour d'{area:256}. Les Grells portent de la {item:3297} dans les bois à l'ouest de l'arbre, où se dressent les Totems pin-tordu.",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "Retour à {area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079} : un sceau pour {npc:3596}",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}, sur la rampe de l'arbre",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp; upstairs"] = "{npc:3595} : entrez par l'entrée principale de l'arbre et montez la rampe ; à l'étage",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979} : lancez {spell:1259799} et Camouflage dans l'ombre, puis rendez-la à {npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}, à l'est de l'arbre",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "Au nord vers {area:257}",
	-- {area:256} Aldrassil · {npc:1994} Githyiss the Vile · {npc:8584} Iverron
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:1994} sits deep inside. {npc:8584} waits in the trees west of the cave mouth."] = "",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders; below ground"] = "Araignées Tissebois ; sous terre",

	-- Step 5: Aldrassil
	-- {area:256} Aldrassil · {npc:3593} Alyissia · {npc:3594} Frahun Shadewhisper · {npc:3595} Shanda · {npc:3596} Ayanna Everstride · {npc:3597} Mardant Strongoak
	["The trainers stand upstairs inside {area:256}, along the ramp that winds up the tree: {npc:3593} and {npc:3594} on the first level, {npc:3595} above them, {npc:3596} and {npc:3597} at the top. The arrow cannot tell the levels apart."] = "",
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer; inside"] = "{npc:3593}, la maîtresse des guerriers ; à l'intérieur",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}, la maîtresse des chasseurs",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}, le maître des voleurs",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "{npc:3595}, la maîtresse des prêtres : entrez par l'entrée principale de l'arbre et montez la rampe",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}, le maître des druides à {area:256}",

	-- Step 6: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917} et l'antidote",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "Les {object:4406} se trouvent au fond de {area:257} : prenez le chemin central, puis à gauche à l'embranchement, jusqu'à la haute corniche. Les Champignons jacinthe tombent des Grells, les Lys pétale de lune poussent près des étangs au nord d'{area:256}.",
	["Grells"] = "",

	-- Step 8: Shadowglen
	["Below ground"] = "Sous terre",
	-- {quest:97236} Fang of Githyiss
	["{quest:97236}; below ground"] = "{quest:97236} ; sous terre",

	-- Step 9: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}, au sommet de l'arbre",

	-- Step 10: The moonwell and Iverron
	-- {npc:8584} Iverron
	["The moonwell and {npc:8584}"] = "Le puits de lune et {npc:8584}",
	-- {area:256} Aldrassil
	["The moonwell sits north of {area:256}."] = "Le puits de lune se trouve au nord d'{area:256}.",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "Utilisez la {item:5185} au puits de lune",

	-- Step 11: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "Retour au sommet d'{area:256}. Le {object:654846} se trouve à côté de lui.",
	["Upstairs"] = "À l'étage",
	-- {object:654846} Lost Journal
	["{object:654846}, upstairs"] = "{object:654846}, à l'étage",

	-- Step 12: Iverron's Antidote
	-- {npc:8583} Dirania Silvershine · {area:256} Aldrassil · {npc:8584} Iverron
	["Take the antidote from {npc:8583} at the foot of {area:256} only now, on the way down: it lasts five minutes. {npc:8584} waits north-west, by the cave: go straight on to him."] = "",

	-- Step 13: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "Quittez {area:188} par le chemin au sud-est d'{area:256} : {npc:6780} se tient à côté, là où il descend vers la route de {area:186}.",

	-- Step 14: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "Suivez la route vers le sud-ouest hors de {area:188}. {npc:2150} est assis au bord, juste à l'est de {area:186}.",

	-- Step 15: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}, près du feu de camp",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "/sit près du feu de camp de {npc:265811} jusqu'à obtenir {spell:1229451}",
	-- {npc:6286} Zarrin
	["{npc:6286}, south of the inn: Camping 101 asks you to learn it"] = "{npc:6286}, au sud de l'auberge : Camping 101 vous demande de l'apprendre",

	-- Step 17: Dolanaar
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}, au sud de l'auberge",
	-- {npc:3608} Aldia
	["{npc:3608}, upstairs"] = "{npc:3608}, à l'étage",
	-- {npc:3567} Tallonkai Swiftroot
	["{npc:3567}, upstairs"] = "{npc:3567}, à l'étage",
	-- {npc:3600} Laurna Morninglight
	["{npc:3600}, inside"] = "{npc:3600}, à l'intérieur",

	-- Step 18: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151} patrouille sur la route à l'ouest du village : si elle n'est pas à la flèche, suivez la route jusqu'à la croiser.",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}, sur la route à l'ouest du village",

	-- Step 19: Teldrassil: kill these as you meet them
	-- {quest:940} Teldrassil
	["{quest:940}: kill these as you meet them"] = "{quest:940} : tuez-les au passage",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}."] = "Des sabres-de-nuit, des Hiboux Strigid et des Rôdeuses Tissebois parcourent tous les environs de {area:186} et la route vers l'est ; les rôdeuses laissent aussi tomber les pattes d'araignée de la recette. Le puits de lune se trouve à la lisière ouest du {area:260}.",
	["Nightsabers"] = "Sabres-de-nuit sauvages",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "Rôdeuses Tissebois",

	-- Step 20: Zenn Foulhoof
	-- {npc:2150} Zenn Foulhoof · {area:186} Dolanaar · {area:260} Starbreeze Village
	["{npc:2150} sits by the road just east of {area:186}, between {area:186} and {area:260}."] = "",

	-- Step 21: Starbreeze Village
	-- {npc:2107} Gaerolas Talvethren · {object:126158} Tallonkai's Dresser
	["{npc:2107} stands upstairs in a house in the village, east of the moonwell: go up inside, the arrow cannot tell the floors apart. {object:126158} is in the house on the hill at the east end of the village."] = "",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "Utilisez la {item:5619} au puits de lune",
	-- {object:126158} Tallonkai's Dresser
	["{object:126158}; inside"] = "{object:126158} ; à l'intérieur",

	-- Step 22: Lake Al'Ameth
	-- {npc:2150} Zenn Foulhoof · {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-west of Starbreeze, south of {npc:2150}. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "Au sud-ouest de Brise-d'étoiles, au sud de {npc:2150}. {npc:2080} soigne ses jeunes arbres sur la rive ; des Jeunes pousses de flagellant et des Sylvains errent autour de lui, et les {quest:919} poussent parmi eux.",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080} : {quest:922} à {zone:1457} la prend",

	-- Step 24: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "Entrée de {area:258}",

	-- Step 25: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038} attend dans la grotte, en bas ou en haut sur la corniche ; gardez la droite.",
	-- {npc:2038} Lord Melenas
	["{npc:2038}; below ground"] = "{npc:2038} ; sous terre",

	-- Step 26: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "La route de {zone:1457}",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "Les Embusqués Pin-tordu se cachent le long de la route à l'ouest de {area:258}.",

	-- Step 27: Sentinel Shayla Nightbreeze
	-- {area:261} Gnarlpine Hold
	["West along the road to the city gate: Shayla stands beside it. Every Gnarlpine furbolg drops fangs: the ambushers on this road, the barrow's and {area:261}'s all count."] = "",

	-- Step 28: Darnassus
	-- {quest:922} Rellian Greenspyre · {area:1658} Cenarion Enclave · {npc:7316} Sister Aquinne · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade · {item:279378} Lunar Pendant
	["Into the city through the gate. {quest:922} is just south of the {area:1658} at the north end, {npc:7316} in the west, {npc:7313} and {npc:8396} in the Temple of the Moon at the south end. On the way back out, use Dalia's {item:279378} at the bank and at the city gate; the other two owls wait for your last visit."] = "",
	-- {npc:7313} Priestess A'moora
	["{npc:7313}, in the Temple of the Moon"] = "",
	-- {npc:8396} Sentinel Dalia Sunblade
	["{npc:8396}, beside her"] = "",
	-- {item:279378} Lunar Pendant
	["{item:279378}: the bank, on the way out"] = "",
	["the city gate"] = "",

	-- Step 29: Ban'ethil Barrow Den's entrance
	-- {area:262} Ban'ethil Barrow Den
	["{area:262}'s entrance"] = "",

	-- Step 30: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms. Its furbolgs drop Shayla's fangs."] = "",
	-- {item:5220} Gnarlpine Fang
	["{item:5220}: any Gnarlpine furbolg"] = "",
	-- {npc:7317} Oben Rageclaw
	["{npc:7317}, below ground"] = "{npc:7317}, sous terre",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "Chamans Pin-tordu",
	-- {npc:7318} Rageclaw · {area:736} Ban'ethil Hollow
	["{npc:7318}, in the den; walks around {area:736}: look inside the circle on the map"] = "{npc:7318}, dans la tanière ; se promène autour de {area:736} : cherchez à l'intérieur du cercle sur la carte",

	-- Step 31: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "Escortez {npc:275744} hors du refuge ; {npc:2081} à {area:186} reçoit le rapport.",
	["Walk Lynessa out and keep her alive"] = "Accompagnez Lynessa dehors et gardez-la en vie",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}, devant le refuge",

	-- Step 32: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "Au sud-ouest du refuge. Le puits de lune se trouve près des bassins.",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "Utilisez la {item:5621} au puits de lune",

	-- Step 33: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs."] = "",

	-- Step 35: Seek Redemption!
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {npc:7234} Ferocitas the Dream Eater
	-- plural, as words: Fel Cones = {object:1673} Fel Cone
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}: pick them up on the road east and hand them to {npc:2150} on the way to {npc:7234}."] = "Les Gangrenoix gisent sous les arbres tout autour de {area:186} et de {npc:2150} : ramassez-les sur la route vers l'est et remettez-les à {npc:2150} en chemin vers {npc:7234}.",

	-- Step 36: Ferocitas the Dream Eater
	-- {npc:7234} Ferocitas the Dream Eater · {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and {npc:7234} camp north-east of {area:260}. {npc:7234} drops the {item:8049}: open it for the jewel.\nCareful: {npc:7234} waits near the camp fire with mystics around him, so pulling him without adds is hard."] = "Des Mystiques Pin-tordu et {npc:7234} campent au nord-est du {area:260}. {npc:7234} laisse tomber le {item:8049} : ouvrez-le pour obtenir le joyau.\nAttention : {npc:7234} attend près du feu de camp entouré de mystiques, il est donc difficile de l'attirer seul.",
	-- {item:8049} Gnarlpine Necklace · {npc:7234} Ferocitas the Dream Eater
	["{item:8049}, from {npc:7234}"] = "{item:8049}, sur {npc:7234}",

	-- Step 37: Dolanaar
	-- {area:264} Oracle Glade · {area:186} Dolanaar · {npc:3567} Tallonkai Swiftroot
	["The road west to the {area:264} runs through {area:186}: hand {npc:3567} the jewel on the way."] = "",

	-- Step 38: Sentinel Shayla Nightbreeze
	-- {area:186} Dolanaar
	["West along the road from {area:186}: Shayla still stands beside it, before the turn north to the glade."] = "",

	-- Step 39: The Wellspring River
	-- {area:265} Wellspring River
	["The {area:265}"] = "",
	-- {area:265} Wellspring River
	-- plural, as words: Mossy Tumors = {item:5170} Mossy Tumor
	["North from the road the path to the glade crosses the {area:265}: the timberlings along it drop the Mossy Tumors."] = "",
	-- {item:5170} Mossy Tumor
	["{item:5170}: timberlings"] = "",

	-- Step 40: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "Le puits de lune se trouve au milieu de la clairière. La {object:6752} pousse à son extrémité nord.",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}, près du puits de lune",
	-- {item:18152} Amethyst Phial
	["Use the {item:18152} at the moonwell"] = "Utilisez la {item:18152} au puits de lune",

	-- Step 41: Bloodfeather harpies
	["Bloodfeather harpies"] = "Harpies Plumesang",
	-- {quest:938} Mist
	["The Bloodfeather harpies nest on the slopes west and north of the glade. {quest:938}, an injured sabercat, lies by the glade's west wall among them: lead her back to Sentinel Arynia at the moonwell before her time runs out.\nCareful: The harpies stand packed together, so extra ones often join a fight. Casters are mixed in among them."] = "",
	-- {quest:938} Mist
	["{quest:938}, by the west wall"] = "",
	-- {quest:938} Mist
	["Lead {quest:938} to the moonwell"] = "",

	-- Step 42: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "Retour au puits de lune.",

	-- Step 43: The named harpies
	["The named harpies"] = "Les harpies nommées",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034} et {npc:272044} volent juste à l'ouest du puits de lune, {npc:272046} plus au nord.",

	-- Step 44: Lady Sathrah
	-- {object:6752} Strange Fronded Plant · {npc:272046} Witchmother Arysa · {area:266} Wellspring Lake · {npc:7319} Lady Sathrah
	["The {object:6752} grows at the glade's north end, on the way: then north of {npc:272046}, along the island's northern edge by {area:266}, {npc:7319}, a level 12 spider, lurks."] = "",

	-- Step 45: Sentinel Arynia again
	["Sentinel Arynia again"] = "De nouveau la sentinelle Arynia",
	-- {object:673378} Oracle Tree Bark
	["{object:673378}, just west of the moonwell"] = "{object:673378}, juste à l'ouest du puits de lune",
	-- {object:673378} Oracle Tree Bark · {zone:1457} Darnassus
	["the same {object:673378}: Fandral in {zone:1457} takes it"] = "le même {object:673378} : Fandral, à {zone:1457}, le prend",

	-- Step 46: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}.\nCareful: Gnarlpine of roughly level 9-12 crowd the camp and sit close together, so it is easy to pull several at once. Take them on singly before you engage Ursal."] = "Longez le côté ouest de l'île vers le sud. Ursal rôde à l'extrême sud, en contrebas des {area:478}.\nAttention : des Pin-tordu de niveau 9-12 environ se pressent dans le camp, serrés les uns contre les autres, il est donc facile d'en attirer plusieurs à la fois. Affrontez-les un par un avant d'engager Ursal.",

	-- Step 47: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "Au nord-est depuis l'antre d'Ursal, retour à {area:186}.",
	-- {npc:6094} Byancie
	["{npc:6094}, inside"] = "{npc:6094}, à l'intérieur",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "{item:3371} chez {npc:3614}, à côté de {npc:6094}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600} : {npc:11401} à {zone:1457} la prend",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "{item:159} chez {npc:6736}, pour {npc:6094}",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "Fandral à {zone:1457} la prend",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602} : {npc:4217} à {zone:1457} la prend",
	-- {npc:3598} Kyra Windblade · {quest:1684} Elanaria · {zone:1457} Darnassus
	["{npc:3598}, the warrior trainer: {quest:1684} in {zone:1457} takes it"] = "{npc:3598}, la maîtresse des guerriers : {quest:1684}, à {zone:1457}, la prend",

	-- Step 48: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "Au sud-est de Dolanaar, vers {npc:2080}. Les Jeunes pousses de flagellant errent autour de lui sur la rive.",
	-- {object:7510} Sprouted Frond
	["{object:7510}, beside him"] = "{object:7510}, à côté de lui",

	-- Step 49: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "De nouveau {area:186}",
	-- {npc:6094} Byancie · {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr
	["{npc:6094} takes a {item:159} with the fronds and the vial: if you drank yours, buy another from {npc:6736} in this inn before you hand in."] = "{npc:6094} prend une {item:159} avec les frondes et la fiole : si vous avez bu la vôtre, achetez-en une autre à {npc:6736} dans cette auberge avant de rendre la quête.",

	-- Step 50: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Chaque quête de Dazalar vous remet un {item:15908} : utilisez-le sur la bête qu'il nomme, puis rapportez-lui le bâton à {area:186}. Les Rôdeuses Tissebois rampent autour du village, les Rôdeurs sabre-de-nuit et les Hurleurs Strigid parcourent les bois au sud.",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998} : apprivoisez-la avec le {item:15908}",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043} : apprivoisez-le avec le {item:15908}",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996} : apprivoisez-le avec le {item:15908}",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "{npc:4146} à {zone:1457} la prend",

	-- Step 51: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "Reprenez la route vers le nord-ouest depuis {area:186} ; elle gît toujours au bord de la route, en direction de {zone:1457}.",

	-- Step 52: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "Entrez dans {zone:1457}",
	-- {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace
	["{npc:4241}, on the {area:1659} just inside the city"] = "",

	-- Step 54: Elanaria
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}, just inside the city."] = "{quest:1684} se tient sur la {area:1660}, juste à l'entrée de la ville.",

	-- Step 55: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:736} Ban'ethil Hollow · {quest:1684} Elanaria
	["Back out of the city gate and east along the road: {quest:1683} stands south of it, by {area:736}. Bring his horn back to {quest:1684}."] = "Ressortez par la porte de la ville et suivez la route vers l'est : {quest:1683} se tient au sud de celle-ci, près de {area:736}. Rapportez sa corne à {quest:1684}.",

	-- Step 57: Darnassus
	-- {zone:1457} Darnassus · {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace · {area:3425} Cenarion Hold · {npc:4241} Mydrannul · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade
	["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "",
	-- {npc:4088} Elanaria · {area:1660} Warrior's Terrace · {spell:71} Defensive Stance
	["{npc:4088}, on the {area:1660}: {spell:71}"] = "{npc:4088}, sur la {area:1660} : {spell:71}",
	-- {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace
	["{item:279378}: the inn on the {area:1659}"] = "",

	-- Step 59: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}, à {area:1658}",

	-- Step 60: Cenarion Enclave
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}, à {area:1658} : {spell:5149}",

	-- Step 62: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}, à {area:1658}",
	-- {area:3425} Cenarion Hold
	["the tunnel mouth below {area:3425}, on the way south"] = "",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}, dans le Temple de la Lune",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}, au-dessus de {npc:4092}",
	-- {quest:2520} Sathrah's Sacrifice
	["{quest:2520}, standing in the temple's central fountain"] = "",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}, dans le Temple de la Lune : Eclats stellaires",

	-- Step 63: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Tant que vous y êtes : apprenez les Bâtons auprès de {npc:11866} ({area:1660}, 10 pièces d'argent) ; l'arme de mêlée d'un chasseur compte surtout pour ses caractéristiques, et les armes à deux mains en portent le plus.",

	-- Step 64: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Tant que vous y êtes : apprenez les Bâtons auprès de {npc:11866} ({area:1660}, 10 pièces d'argent) ; un bâton porte plus de caractéristiques de sorts qu'une arme à une main pendant la montée de niveau.",

	-- Step 65: Portal to Teldrassil
	-- {quest:940} Teldrassil
	["Portal to {quest:940}"] = "Portail vers {quest:940}",

	-- Step 66: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine · {area:442} Auberdine · {npc:4200} Laird
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs. Once you have {quest:6342}, talk to {npc:3838} again and choose the flight to {area:442}: it is free and lands beside {npc:4200}. If the flight map opens instead, close it and talk to him again holding Shift."] = "Prenez le portail pour descendre au {area:702}. {npc:10118} se tient sur le quai, {npc:3838} près des hippogriffes. Une fois {quest:6342} en poche, parlez de nouveau à {npc:3838} et choisissez le vol pour {area:442} : il est gratuit et se pose à côté de {npc:4200}. Si la carte des vols s'ouvre à la place, fermez-la et parlez-lui de nouveau en maintenant Maj.",
	-- {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine
	["talk to {npc:3838} again: free with {quest:6342}"] = "parlez de nouveau à {npc:3838} : gratuit avec {quest:6342}",

	-- Step 67: Auberdine
	-- {npc:3841} Caylais Moonfeather · {npc:4200} Laird
	["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Apprenez le trajet aérien auprès de {npc:3841}, là où vous atterrissez. L'étal de poissons de {npc:4200} se trouve juste au nord d'elle, près des quais.\nLe bateau accoste à l'ouest du village. La maîtresse de vol se tient sur la colline au sud de l'auberge ; les donneurs de quêtes sont répartis le long de la rue principale.",
	["The WANTED poster outside the inn"] = "L'affiche AVIS DE RECHERCHE devant l'auberge",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart"] = "",

	-- Step 68: Return to Nessa
	-- {area:702} Rut'theran Village · {npc:3841} Caylais Moonfeather · {item:16263} Laird's Response · {npc:10118} Nessa Shadowsong · {area:442} Auberdine
	["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442}."] = "",

	-- Step 69: The Long Wash
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Les Clampants des marées grouillent sur la côte en contrebas du village ; {quest:983} se trouve sur la plage juste au sud des quais. Les Batteurs de Sombrivage nagent dans les hauts-fonds. La {object:175207} gît sur la côte juste au sud du village.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "",

	-- Step 70: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, au nord du village",

	-- Step 71: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Parlez à l'{quest:5929}",

	-- Step 73: Back to Darnassus
	-- {npc:10118} Nessa Shadowsong · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:10118} stands on the Rut'theran dock where you land. Then take the portal up to {npc:4217} in the {area:1658}."] = "{npc:10118} se tient sur le quai de Rut'theran, là où vous atterrissez. Prenez ensuite le portail pour monter jusqu'à {npc:4217}, dans {area:1658}.",

	-- Step 76: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Redescendez à {area:702} et prenez un vol pour {area:442}. La {object:177525} se dresse dans les collines juste à l'est du village : utilisez-y la {item:15208}, vainquez Lunegriffe et parlez à l'{npc:12144}.",

	-- Step 77: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {zone:1453}"] = "Bateau pour {zone:1453}",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}, no flight path needed."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361} ; {quest:5929} se trouve dans les bois au nord-ouest. Ensuite, {npc:11800}, à {area:2361}, emmène les druides directement au {area:702}, pas besoin du trajet aérien.",
	-- ["Defensive Stance"] = "Posture défensive",
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Chaque quête de {npc:3601} vous remet un {item:15908} : utilisez-le sur la bête qu'il nomme, puis rapportez-lui le bâton à {area:186}. Les Rôdeuses Tissebois rampent autour du village, les Rôdeurs sabre-de-nuit et les Hurleurs Strigid parcourent les bois au sud.",
	-- ["East to {area:260}"] = "À l'est vers {area:260}",
	-- ["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "Les Gangrenoix jonchent le sol sous les arbres tout autour de {area:186} et de {npc:2150}. Les Sabres-de-nuit sauvages et les Rôdeuses Tissebois parcourent toujours la route vers l'est. {object:126158} est dans la maison sur la colline, à l'extrémité est du village.",
	-- ["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442} for the boat."] = "Reprenez un vol pour le {area:702} auprès de {npc:3841}, remettez la {item:16263} à {npc:10118} sur le quai, puis revenez en vol à {area:442} pour le bateau.",
	-- ["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "Reprenez un vol pour {area:702} et le portail pour monter voir {npc:4217}, puis revenez en vol à {area:442} pour le bateau.",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "Suivez la route vers le sud-ouest hors de {area:188} jusqu'à {area:186}.",
	-- ["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "Suivez la route vers l'ouest jusqu'à {zone:1457}. {npc:4241} se tient sur {area:1659}, juste à l'entrée de la ville. {npc:3516} est à {area:1658}, à l'extrémité nord de la ville, {quest:922} juste au sud ; {npc:4092} et {npc:7999} sont dans le Temple de la Lune, à l'extrémité sud. {npc:7316} est dans l'ouest de la ville, sur le chemin du portail rose qui descend à Rut'theran.",
	-- ["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "Depuis le port, rendez-vous dans {object:2100}. {npc:5480} y entraîne les guerriers ; {npc:6089} et {npc:6090} se tiennent ensemble près de {object:2152}. {npc:6090} vous affronte pour sa chope.",
	-- ["From {area:17203}, head through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "Depuis {area:17203}, passez les portes de la ville pour entrer dans {zone:1429} et suivez la route vers l'ouest jusqu'en {zone:1436}.",
	-- ["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "Depuis {area:17203}, passez les portes de la ville jusqu'en {zone:1429} et suivez la route vers l'ouest jusqu'en {zone:1436}.",
	-- ["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "Les Mystiques Pin-tordu et Ferocitas campent au nord-est de {area:260}. Ferocitas laisse tomber le {item:8049} : ouvrez-le pour obtenir le joyau.",
	-- ["Hearth to {area:186}"] = "Pierre de foyer vers {area:186}",
	-- ["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "Apprenez le trajet aérien d'{area:442} sur la colline au sud de l'auberge, puis lancez {spell:18960}. {npc:11802} est à {area:2361} ; {quest:5929} se trouve dans les bois au nord-ouest. Apprenez le trajet aérien de {area:493} à {area:2361} et volez jusqu'à {area:702} (en passant par {area:442}).",
	-- ["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:1994} sits deep inside."] = "Des Sabres-de-nuit galeux et des Sangliers des chardons parcourent le nord d'{area:256}, sur le chemin de la grotte. {npc:1994} se tient tout au fond.",
	-- ["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "Les Sabres-de-nuit galeux et les Sangliers des chardons rôdent au nord d'{area:256}, sur le chemin de la grotte. {npc:8584} attend dans les arbres à l'ouest de l'entrée de la grotte ; {npc:1994} se tient au fond.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "Les Sabres-de-nuit sauvages, les Hiboux Strigid et les Rôdeuses Tissebois vivent le long de la route vers l'est. Le puits de lune se trouve à la limite ouest de {area:260}.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east. The moonwell is at the west edge of {area:260}."] = "Les Sabres-de-nuit sauvages, les Hiboux Strigid et les Rôdeuses Tissebois rôdent tout autour de {area:186} et le long de la route vers l'est. Le puits de lune se trouve à la limite ouest de {area:260}.",
	-- ["North from the lake to {npc:2150}, on the road back to {area:186}."] = "Vers le nord depuis le lac jusqu'à {npc:2150}, sur la route du retour vers {area:186}.",
	-- ["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "Au sud de Zenn. {npc:2080} soigne ses jeunes arbres sur la rive ; les Jeunes pousses de flagellant et les Sylvains errent autour de lui, et les {quest:919} poussent parmi eux.",
	-- ["South of the pools. The {object:6751} grows by the Hold."] = "Au sud des bassins. La {object:6751} pousse près du Camp des Pins-tordus.",
	-- ["Speak with {npc:6286}, south of the inn"] = "Parlez à {npc:6286}, au sud de l'auberge",
	-- ["Take the boat to {zone:1453} from {area:442}'s docks."] = "Prenez le bateau pour {zone:1453} depuis les quais d'{area:442}.",
	-- ["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "Prenez le portail qui descend à {area:702}. {npc:10118} se tient sur le quai, {npc:3838} près des hippogryphes.",
	-- ["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "Prenez le portail depuis {area:702} pour monter voir {npc:4217} à {area:1658}.",
	-- ["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "Prenez la route vers le nord-ouest depuis {area:186} en direction de {area:264} ; elle gît blessée au bord de la route.",
	-- ["Tame Beast"] = "Apprivoiser une bête",
	-- ["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "Les harpies Plumesang nichent sur les pentes à l'ouest et au nord de la clairière.",
	-- ["The Bloodfeather harpies nest on the slopes west and north of the glade.\nCareful: The harpies stand packed together, so extra ones often join a fight. Casters are mixed in among them."] = "Les harpies Plumesang nichent sur les pentes à l'ouest et au nord de la clairière.\nAttention : les harpies se tiennent serrées, alors d'autres se joignent souvent au combat. Des lanceuses de sorts sont mêlées à elles.",
	-- ["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "Le refuge se trouve au sud de la route. {npc:275744} y est retenue, {npc:7317} dort dans ses profondeurs, et les quatre coffres à reliques se trouvent dans les salles inférieures.",
	-- ["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "Le puits de lune se trouve au nord d'{area:256} ; {npc:8584} est un peu plus au nord-ouest. {quest:3522} dure cinq minutes : remplissez la fiole et allez directement le voir.",
	-- ["The {area:264}"] = "{area:264}",
	-- ["Tide Crawlers scuttle along the shore below the village; {object:17182} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Des Clampants des marées courent le long du rivage sous le village ; {object:17182} se dresse sur la plage juste au sud des quais. Des Batteurs de Sombrivage nagent dans les hauts-fonds. La {object:175207} repose sur le rivage juste au sud du village.",
	-- ["Use the {item:5623} at the moonwell"] = "Utilisez la {item:5623} au puits de lune",
	-- ["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "Marchez vers le sud le long du côté ouest de l'île. Ursal rôde à l'extrême sud, sous {area:478}.",
	-- ["Webwood Spiders"] = "Araignées Tissebois",
	-- ["{area:186} quests"] = "Quêtes de {area:186}",
	-- ["{item:10639} along the way to {area:256}"] = "{item:10639} sur le chemin de {area:256}",
	-- ["{item:10639} on the way"] = "{item:10639} en chemin",
	-- ["{item:10641} on the way"] = "{item:10641} en chemin",
	-- ["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216}, sur la jetée : uniquement avec {skill:356}",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "{npc:11401}, dans le temple de la Lune : {spell:10797}",
	-- ["{npc:1984} along the way to Back at {area:256}"] = "{npc:1984} en chemin, en retournant à {area:256}",
	-- ["{npc:1984} on the way"] = "{npc:1984} en chemin",
	-- ["{npc:2107} stands in the village, east of the moonwell. {object:126158} is in the house on the hill at the east end of the village."] = "{npc:2107} se tient dans le village, à l'est du puits de lune. {object:126158} se trouve dans la maison sur la colline, à l'extrémité est du village.",
	-- ["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150} est assis au bord de la route juste à l'est de {area:186}, en direction de {area:260}.",
	-- ["{npc:2150}, on the way back"] = "{npc:2150}, sur le chemin du retour",
	-- ["{npc:3567}, back in {area:186}"] = "{npc:3567}, de retour à {area:186}",
	-- ["{npc:3567}, back in {area:186}; upstairs"] = "{npc:3567}, de retour à {area:186} ; à l'étage",
	-- ["{npc:3593}, the warrior trainer"] = "{npc:3593}, la maîtresse des guerriers",
	-- ["{npc:3595}, inside the tree"] = "{npc:3595}, dans l'arbre",
	-- ["{npc:3595}, the priest trainer, inside the tree"] = "{npc:3595}, la maîtresse des prêtres, dans l'arbre",
	-- ["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "L'étal de poisson de {npc:4200} est près des quais. Prenez ensuite le bateau pour {zone:1453}.",
	-- ["{npc:4217}: Bear Form"] = "{npc:4217} : Forme d'ours",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089} : Posture défensive",
	-- ["{npc:7318}, in the den"] = "{npc:7318}, dans le refuge",
	-- ["{npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "{npc:8584} est un peu plus au nord-ouest. {quest:3522} dure cinq minutes : remplissez la fiole et allez directement le voir.",
	-- ["{npc:8584} waits in the trees west of the cave mouth."] = "{npc:8584} attend dans les arbres à l'ouest de l'entrée de la grotte.",
	-- ["{quest:488} and the Starbreeze moonwell"] = "{quest:488} et le puits de lune de la Brise-étoilée",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979} : lancez {spell:1259799} et {spell:20580}, puis rendez-la à {npc:3595}",
}
