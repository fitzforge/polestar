-- French (frFR): the guide forever/alliance/03-darkshore (forever/alliance/03-darkshore.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Le bateau accoste à l'ouest du village. Le maître de vol se tient sur la colline au sud de l'auberge ; les donneurs de quêtes sont répartis le long de la rue principale.",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, by the inn"] = "{npc:3666}, près de l'auberge",
	["The WANTED poster outside the inn"] = "L'affiche AVIS DE RECHERCHE devant l'auberge",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, sur la jetée",
	-- {npc:10216} Gubber Blump · {skill:356} Fishing
	["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216}, sur la jetée : uniquement avec {skill:356}",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, au nord du village",

	-- Step 2: The beach
	["The beach"] = "La plage",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Les Clampants des marées grouillent sur la côte en contrebas du village ; {quest:983} se trouve sur la plage juste au sud des quais. Les Batteurs de Sombrivage nagent dans les hauts-fonds. La {object:175207} gît sur la côte juste au sud du village.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg
	["Crawler Legs"] = "Pattes de clampant",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes"] = "Yeux de batteur",
	-- {item:12238} Darkshore Grouper
	["{item:12238}: fish from the pier"] = "{item:12238} : à pêcher depuis la jetée",

	-- Step 4: The skeletal turtle
	["The skeletal turtle"] = "La tortue squelettique",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks"] = "{item:12289}, sur la plage à l'ouest des quais",

	-- Step 5: Plagued bears
	["Plagued bears"] = "Les ours pestiférés",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {quest:2139} on one and lead it back to him."] = "Les Ours des chardons enragés errent dans les collines juste à l'est d'{area:442}. Utilisez {quest:2139} sur l'un d'eux et ramenez-le-lui.",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Les ours et le camp Noirbois",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "Tuez des Ours des chardons enragés dans les collines à l'est d'{area:442}, puis montez jusqu'au camp de furbolgs au sud-est : rien à tuer pour l'instant.",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} se tient à la lisière nord des ruines. Des Bien-nés maudits, des Bien-nés frémissants et des {npc:2178} les hantent ; le fantôme d'{npc:3667} erre parmi eux, la chouette {npc:270196} tournoie à l'est. Les deux tablettes se trouvent dans les ruines ; une {quest:4722} gît sur la côte à l'ouest.",
	["Read both tablets"] = "Lisez les deux tablettes",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Reliques de bien-Né",

	-- Step 8: The red crystal
	["The red crystal"] = "Le cristal rouge",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Escaladez les montagnes à l'est d'{area:447} ; le {object:175524} repose sur une corniche.",

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins."] = "Au nord, le long des collines. {npc:3650} attend dans les ruines de {quest:954} ; des Grells sauvages et des Fées viles les peuplent, des Satyres Deth'ryll en occupent la lisière est. {quest:1001} se trouve près de la route à l'ouest des ruines.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Boucles d'oreille de grell",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338} : Satyres Deth'ryll",

	-- Step 10: The Tower of Althalaxx
	-- {quest:954} Bashal'Aran · {quest:1002} Buzzbox 323
	["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower."] = "Des Traquelunes rôdent dans les collines entre {quest:954} et la tour. {quest:1002} se trouve sur la colline à l'ouest de la tour.",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "Crocs de traquelune",

	-- Step 11: Hearth to Auberdine
	-- {area:442} Auberdine
	["Hearth to {area:442}"] = "Pierre de foyer vers {area:442}",
	["Fill the tube at the moonwell in the village"] = "Remplissez le tube au puits de lune du village",

	-- Step 12: A Lesson to Learn
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Fly from {area:442} to {area:702} and take the portal up to {npc:4217} in the {area:1658}."] = "Volez d'{area:442} au {area:702} et prenez le portail pour monter jusqu'à {npc:4217} dans l'{area:1658}.",

	-- Step 13: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {area:442} Auberdine
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. Then fly back to {area:442} from {area:2361}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire ({item:15877}) se trouvent dans les conteneurs au fond du {area:656}, en contrebas de {area:2361} : apportez-en un au {area:2362} au nord-ouest, utilisez-le là-bas et parlez à {npc:11799}. Puis revenez en vol à {area:442} depuis {area:2361}.",
	-- {quest:6122} The Principal Source · {area:445} Cliffspring Falls
	["{quest:6122}: fill the sampler at {area:445}"] = "{quest:6122} : remplissez l'échantillonneur aux {area:445}",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, dans un {object:177785} au fond du lac",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Au {area:2362}",
	-- {zone:1439} Darkshore · {zone:1436} Westfall
	["The half pendants lie in {zone:1439} and {zone:1436}: later on the route"] = "Les demi-pendentifs se trouvent en {zone:1439} et en {zone:1436} : plus tard sur l'itinéraire",

	-- Step 14: Blackwood furbolgs
	["Blackwood furbolgs"] = "Les furbolgs Noirbois",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Des Guides Noirbois et des Messagers du Vent Noirbois tiennent le camp au sud-est d'{area:442}.",

	-- Step 15: The Ancient Flame
	-- {object:16393} Ancient Flame
	["The {object:16393}"] = "{object:16393}",
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "La flamme brûle au sud d'{area:447}.",

	-- Step 16: The southern beaches
	["The southern beaches"] = "Les plages du sud",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}."] = "Suivez la côte vers le sud au-delà d'{area:447} : une {quest:4728} gît sur la côte à l'ouest du Bosquet des Anciens, une autre plus au sud près de l'{area:450}.",

	-- Step 17: The Grove of the Ancients
	-- {area:448} Grove of the Ancients
	["The {area:448}"] = "{area:448}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "Des Vieux ours des chardons errent dans les collines autour du Bosquet ; {quest:1003} se trouve à l'ouest, parmi eux.",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "Scalps vieillis",

	-- Step 18: The red crystal
	["Back north-east into the mountains to the crystal."] = "Retournez au nord-est dans les montagnes jusqu'au cristal.",

	-- Step 19: Cliffspring Falls
	-- {area:456} Cliffspring River · {area:443} Ruins of Mathystra · {quest:954} Bashal'Aran
	["Follow the hills north to the {area:456} and up to the falls. Three more beached remains lie on the north shore: near the {area:443}, north of {quest:954} and west of {quest:954}."] = "Suivez les collines vers le nord jusqu'à la {area:456} et remontez jusqu'aux chutes. Trois autres restes échoués gisent sur la côte nord : près des {area:443}, au nord de {quest:954} et à l'ouest de {quest:954}.",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}, à la cascade",
	-- {item:15845} Filled Cliffspring Falls Sampler
	["{item:15845}: at the mouth of the cave by the falls"] = "{item:15845} : à l'entrée de la grotte près des chutes",

	-- Step 21: Auberdine
	["The WANTED poster"] = "L'affiche AVIS DE RECHERCHE",

	-- Step 22: The bay wrecks
	["The bay wrecks"] = "Les épaves de la baie",
	-- {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore."] = "Deux épaves reposent au fond de la baie au nord d'{area:442} ; chacune contient un coffret. Des Clampants des récifs et des Clampants des marées incrustés longent cette côte.",

	-- Step 23: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins; Stormscale Beastmistresses walk the shore. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} se cache sur le petit îlot au large des ruines ; des Maîtresses des bêtes tempécaille arpentent la côte. Les morceaux de clé tombent des Trotteurs des forêts géants (haut), des murlocs Grisebrume (milieu) et des Clampants des récifs enragés (bas).",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883} : l'{object:177792} sous l'eau au large de la côte nord, à l'ouest des ruines",

	-- Step 24: The Tower of Althalaxx
	-- {npc:3661} Balthule Shadowstrike · {zone:1440} Ashenvale
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "{npc:3661} se cache au pied de la tour parmi les Fanatiques de la Rive noire. Gardez sa lettre pour Delgren le Purificateur en {zone:1440}.",
	-- {item:5348} Worn Parchment
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{item:5348}: Dark Strand Fanatics"] = "{item:5348} : Fanatiques de la Rive noire",

	-- Step 25: The cave and the Den Mother
	-- {npc:6788} Den Mother
	["The cave and the {npc:6788}"] = "La grotte et la {npc:6788}",
	-- {item:5270} Death Cap · {npc:6788} Den Mother · {object:177624} Xabraxxis' Demon Bag
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "La grotte se trouve au sud des chutes : des Pédoncules d'amanite ({item:5271}) poussent partout à l'intérieur, {item:5270} tout au fond. {npc:6788} a son repaire dans les collines au sud des chutes ; {object:177624} se trouve au camp des satyres au nord de celle-ci.",
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["Scaber Stalks"] = "Pédoncules d'amanite",
	-- {item:12355} Talisman of Corruption · {object:177624} Xabraxxis' Demon Bag
	["{item:12355}, in {object:177624}"] = "{item:12355}, dans le {object:177624}",

	-- Step 27: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} et {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "Les Floraisons fongiques lunaires poussent dans les grottes des séléniens, dans les collines juste à l'est d'{area:442} ; les Séléniens y sont irritables. La {item:2449} demande la compétence {skill:182} : les herboristes en cueillent partout en {zone:1439}, les autres l'apportent de {zone:1453} ({npc:1313}) ou de l'hôtel des ventes.",

	-- Step 28: The Grove of the Ancients
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["Follow the road south. {quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "Suivez la route vers le sud. {quest:948} est l'ancien du Bosquet des Anciens ; {npc:270269} et {npc:11218} dorment à côté de lui.",
	-- {npc:11218} Kerlonian Evershade · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:11218}: his escort to {area:413} is done on the {zone:1440} leg"] = "{npc:11218} : son escorte jusqu'au {area:413} se fait lors du passage en {zone:1440}",

	-- Step 29: The Master's Glaive
	-- {object:10076} Scrying Bowl · {object:12666} Twilight Tome · {npc:3584} Therylune
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "Des Géniteurs traquelunes rôdent dans les bois autour du glaive. Le {object:10076} et le {object:12666} se trouvent au fond du cratère ; {npc:3584} se tient sur son flanc nord.",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "Belles peaux de traquelune",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279} : Disciples du crépuscule et Nervis du crépuscule",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "Seulement si un Disciple ou un Nervi a laissé tomber {item:5352} : clic droit dessus",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "Escortez-la hors du glaive ; Therysil prend le rendu de quête en {zone:1440}",

	-- Step 30: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "La plage de {npc:10323}",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches south of {area:450}."] = "{npc:10323} campe sur la plage à l'ouest du glaive : tuez les murlocs autour du feu de camp ; il arrive à la troisième vague avec son chien. Trois restes échoués gisent sur les plages au sud de l'{area:450}.",

	-- Step 31: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil."] = "L'{area:450} se trouve sur la côte au sud de la plage de {npc:10323}. Protégez le prospecteur pendant qu'il cherche le fossile.",

	-- Step 33: Auberdine
	["Follow the road north."] = "Suivez la route vers le nord.",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "Elle vous donne le {item:15826}",

	-- Step 34: The naga
	["The naga"] = "Les nagas",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them."] = "Suivez la côte au nord-est jusqu'aux {area:443}. Les {quest:951} se trouvent parmi les ruines ; des Myrmidons Tempécaille, des Ensorceleuses Tempécaille et des Guerriers Tempécaille les gardent.",

	-- Step 35: Back south
	["Back south"] = "Retour au sud",
	["Hearthstone on cooldown? Follow the coast road back south."] = "Pierre de foyer en recharge ? Suivez la route côtière vers le sud.",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}, au Bosquet des Anciens",

	-- Step 36: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out."] = "{npc:3692} se cache dans les collines à l'est du {area:449}. Aidez-le à regagner la route ; il se bat en chemin.",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298} : utilisez le {item:15826} sur eux ; ils errent dans tout {zone:1439}",

	-- Step 37: Auberdine
	-- {npc:3694} Sentinel Selarin · {npc:3691} Raene Wolfrunner · {area:415} Astranaar · {zone:1440} Ashenvale
	["{npc:3694}: for {npc:3691} in {area:415}, on the later {zone:1440} leg"] = "{npc:3694} : pour {npc:3691} à {area:415}, lors du passage ultérieur en {zone:1440}",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}"] = "{npc:3649} : pour {npc:1646} à {zone:1453}",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "Bateau pour {zone:1453}",

	-- Step 38: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "Les Elfes de la nuit volent d'{area:442} au {area:702} ; les Éolides prennent le bateau au quai d'{area:442} et y apprennent la route aérienne de Rut'theran. Prenez le portail pour monter jusqu'à {npc:4217} dans l'{area:1658}.",

	-- Step 39: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361} ; apprenez-y le trajet aérien si vous ne l'avez pas.",
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802}: the welcome from Sheldras"] = "{npc:11802} : le message de bienvenue de Sheldras Moontree",

	-- Step 40: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Les reliques du Refuge des saisons",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (Elfes de la nuit) et l'{npc:272054} (Éolides) attendent au sud de {area:493}. Les trois reliques se trouvent dans les {area:2363}, à l'est. D'après les retours des premières semaines, une relique ne donne rien pendant qu'un autre joueur la fouille : attendez un instant et réessayez.",

	-- Step 41: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Retour auprès de {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village · {area:442} Auberdine
	["Back to {npc:11802} in {area:2361}, then fly to {area:702} (by way of {area:442})."] = "Retournez voir {npc:11802} à {area:2361}, puis volez jusqu'au {area:702} (en passant par {area:442}).",

	-- Step 42: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1453} Stormwind
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the boat to {zone:1453}."] = "Prenez le portail pour monter jusqu'à {npc:4217}, puis revolez à {area:442} pour le bateau vers {zone:1453}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. {area:364} Mother lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "La grotte se trouve au sud des chutes : des Pédoncules d'amanite poussent partout à l'intérieur, l'{item:5270} tout au fond. La Mère de la {area:364} niche dans les collines au sud des chutes ; le {object:177624} se trouve au camp des satyres au nord de son repaire.",
	-- ["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {quest:4723} lies on the shore just south of the village."] = "Des Clampants des marées ({npc:2232}) rôdent sur le rivage sous le village ; {quest:983} se dresse sur la plage juste au sud des quais. Des Batteurs de Sombrivage ({npc:2185}) nagent dans les hauts-fonds. {quest:4723} gît sur le rivage juste au sud du village.",
	-- ["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. {zone:1439} Threshers swim in the shallows. The {quest:4723} lies on the shore just south of the village."] = "Les Clampants des marées grouillent sur la côte en contrebas du village ; {quest:983} se trouve sur la plage juste au sud des quais. Les Batteurs de {zone:1439} nagent dans les hauts-fonds. La {quest:4723} gît sur la côte juste au sud du village.",
	-- ["{item:15883}: the {object:177790} under the water off the north coast, west of the ruins"] = "{item:15883} : le {object:177790} sous l'eau au large de la côte nord, à l'ouest des ruines",
	-- ["{npc:4217}: Cat Form"] = "{npc:4217} : Forme de félin",
	-- ["{npc:4217}: Cure Poison"] = "{npc:4217} : Guérison du poison",
	-- ["{quest:1003} stands west of the Grove."] = "{quest:1003} se trouve à l'ouest du Bosquet des Anciens.",
}
