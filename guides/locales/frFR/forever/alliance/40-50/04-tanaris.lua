-- French (frFR): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Mirage Raceway
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {npc:4454} Fizzle Brassbolts
	["The {area:2240} lies on the {area:439} in south-east {zone:1441}: {npc:4454} is in the gnomes' camp beside the track, Zamek by the goblin camp."] = "{area:2240} se trouve sur les {area:439}, dans le sud-est des {zone:1441} : {npc:4454} est dans le camp des gnomes à côté de la piste, Zamek près du camp gobelin.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454} : {quest:1137}, de la part de Martek dans les {zone:1418}",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Chevauchez au sud-est hors des {area:439} jusqu'en {zone:1446}. {area:976} est juste après la frontière.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, au nord de la ville",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, près du château d'eau",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, à côté de lui",
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763} : sa caisse va au {area:702}, plus tard",

	-- Step 5: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7407} Chief Engineer Bilgewhizzle · {quest:2768} Divino-matic Rod
	["For your {area:978} run, later in this guide: {quest:2864} wants scarab shells, {npc:7407}, by the water tower, his {quest:2768} back, and Trenton Lighthammer Troll Temper from the Sandfury trolls."] = "Pour votre expédition dans {area:978}, plus loin dans ce guide : {quest:2864} veut des carapaces de scarabée, {npc:7407}, près du château d'eau, veut récupérer sa {quest:2768}, et Trenton Lighthammer veut de la Trempe de troll des trolls Furie-des-sables.",

	-- Step 6: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Chevauchez vers l'est à travers les dunes jusqu'au Port Gentepression sur la côte nord-est.",
	["The Wanted poster beside him"] = "L'affiche Avis de recherche à côté de lui",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "La même affiche : {npc:7847} vient bien plus tard, après {area:976}",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, à l'intérieur",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern; inside"] = "{npc:7881}, dans la taverne du port ; à l'intérieur",

	-- Step 7: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937} : tuez-les au passage",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Retournez vers l'ouest en direction de {area:976}. Les bandits et les larrons Bat-le-désert tiennent les dunes sur le chemin ; n'importe lequel peut porter une outre d'eau.\nAttention : les Voleurs Bat-le-désert (niveau 43-44) se déplacent camouflés et peuvent donc approcher sans être vus.",

	-- Step 9: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp."] = "Les voleurs, mages de l'ombre et assassins Bat-le-désert plus coriaces campent au sud-est de {area:976}, au sud des bandits. Laissez {npc:7847}, au milieu du camp sud, pour plus tard.\nAttention : les Voleurs Bat-le-désert restent camouflés hors combat : des voleurs cachés peuvent se joindre à un combat que vous engagez dans un camp.",

	-- Step 10: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336} : tuez-les au passage",
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Suivez la côte vers le sud jusqu'à la crique des pirates. Les pirates des Mers du Sud envahissent la plage et les bateaux : progressez par le bord et attirez-les un par un. {npc:7883} se tient de l'autre côté ; la cargaison volée de {npc:7881} se trouve dans le camp.\nAttention : deux ou trois pirates se tiennent avec {npc:7883}, et beaucoup d'autres pirates de la ville se joignent au combat dès qu'il commence.",
	-- {quest:2873} Stoley's Shipment
	["{quest:2873}; upstairs"] = "{quest:2873} ; à l'étage",

	-- Step 11: Steamwheedle Port
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, à l'intérieur",
	-- {area:35} Booty Bay · {zone:1425} Hinterlands
	["\"Sea Wolf\" MacKinley in {area:35}: the route takes you there at the end of the {zone:1425} guide, keep it"] = "« Loup de mer » MacKinley à {area:35} : l'itinéraire vous y emmène à la fin du guide des {zone:1425}, gardez-la",

	-- Step 12: Noonshade Ruins
	["Careful: Thieves cast Disarm. Rogues stay hidden with Sneak. Assassins use Execute when your health is at 20% or lower."] = "Attention : les Larrons lancent Désarmement. Les Voleurs restent cachés grâce à Camouflage. Les Assassins utilisent Exécution quand votre vie est à 20 % ou moins.",

	-- Step 14: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "Le bassin près de {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Chevauchez au nord-ouest jusqu'au camp des trolls Sandfury à {area:979}. Utilisez le {item:8584} au bord de son bassin ; les trolls sont proches, attirez d'abord le plus près.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Donne le {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Bassin près de {area:979}",

	-- Step 15: Zul'Farrak
	-- {area:978} Zul'Farrak · {quest:3042} Troll Temper · {npc:7604} Sergeant Bly · {quest:2768} Divino-matic Rod
	["{area:978} is a dungeon for a group of five; its quests here are level 45 to 47. Its gate lies about 400 yards north of the pool.\nInside: the Scarabs drop the shells, every Sandfury troll can drop {quest:3042}, and {npc:7604} carries the {quest:2768}."] = "{area:978} est un donjon pour un groupe de cinq ; ses quêtes d'ici sont de niveau 45 à 47. Son entrée se trouve à environ 400 mètres au nord du bassin.\nÀ l'intérieur : les Scarabées lâchent les carapaces, n'importe quel troll Furie-des-sables peut lâcher la {quest:3042}, et {npc:7604} porte la {quest:2768}.",
	-- {quest:2865} Scarab Shells
	["{quest:2865}: the Scarabs, inside"] = "{quest:2865} : les Scarabées, à l'intérieur",
	-- {quest:3042} Troll Temper
	["{quest:3042}: the Sandfury trolls, inside"] = "{quest:3042} : les trolls Furie-des-sables, à l'intérieur",
	-- {quest:2768} Divino-matic Rod · {npc:7604} Sergeant Bly
	["{quest:2768}: {npc:7604}, inside"] = "{quest:2768} : {npc:7604}, à l'intérieur",

	-- Step 17: Tran'rek
	-- {area:978} Zul'Farrak · {npc:7876} Tran'rek
	["Your {area:978} scarab shells: {npc:7876}, on the north side of town."] = "Vos carapaces de scarabée de {area:978} : {npc:7876}, dans le nord de la ville.",

	-- Step 18: Chief Engineer Bilgewhizzle
	-- {quest:2768} Divino-matic Rod · {npc:7407} Chief Engineer Bilgewhizzle
	["The {quest:2768}: {npc:7407}, by the water tower."] = "La {quest:2768} : {npc:7407}, près du château d'eau.",

	-- Step 19: Trenton Lighthammer
	-- {quest:3042} Troll Temper · {npc:7804} Trenton Lighthammer
	["The {quest:3042}: {npc:7804}, in town."] = "La {quest:3042} : {npc:7804}, en ville.",

	-- Step 20: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Chevauchez vers le sud jusqu'au camp de fouilles du {area:1938}. {npc:7771} Rivetseeker vous remet un casque détecteur : portez-le pour voir les monticules de {quest:3161}, nombreux dans le sable autour du camp et au sud-ouest vers les ogres.",

	-- Step 22: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "Chevauchez vers le nord-ouest jusqu'à la ruche Centipaar dans les dunes. N'importe quel Centipaar peut lâcher des morceaux d'insecte.\nAttention : les Traînards Centipaar lancent {npc:4196} en combat comme hors combat, ce qui fait venir de petits renforts qui vous interrompent.",

	-- Step 23: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager · {quest:3362} Thistleshrub Valley
	-- plural, as words: Dunemaul Ogres = {npc:5471} Dunemaul Ogre
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first.\nWhy the grind to 47: the {quest:3362} comes next, with mobs of 48-50 and quests of level 50. Grind it on the Dunemaul Ogres (45-46) at the compound's south end, the safer camp, not on the Brutes."] = "Chevauchez au sud-ouest jusqu'à la Base des Cognedunes. Des Brutes Cognedune et des Massacreurs Cognedune (46-48) la remplissent ; {npc:12046} (49) se tient au centre entouré de gardes : éliminez-les d'abord.\nPourquoi monter au niveau 47 : {quest:3362} vient ensuite, avec des monstres de niveau 48-50 et des quêtes de niveau 50. Montez-le sur les Ogres Cognedune (45-46) au sud de la base, le camp le plus sûr, pas sur les Brutes.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}, sous terre",
	-- {npc:5471} Dunemaul Ogre
	["grind on {npc:5471}, at the compound's south end"] = "tuez des {npc:5471} en boucle, au sud de la base",

	-- Step 24: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362} : tuez-les au passage",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "Chevauchez vers le sud jusqu'à {quest:3362}. Les Chardonniers collecteurs de rosée lâchent les glandes ; seules certaines sont remplies, gardez donc celles-là. Les Chardonniers noueux et les Chardonniers taille-racines partagent la vallée. Les Chardonniers noueux sont de niveau 48-50, au-dessus du vôtre : attirez-les un par un.\nAttention : les autres chardonniers du secteur sont de niveau 49-50 et errent beaucoup : vous pouvez facilement en attirer d'autres.",

	-- Step 25: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "L'escorte de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "La petite tortue {npc:5955} se cache à l'extrémité nord de la vallée. Ramenez-la chez sa femme {npc:6015}, au bord de l'eau juste à l'est de {area:977} : elle avance lentement et les bêtes du désert l'attaquent, gardez-la en vie.",

	-- Step 26: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back west to {area:976}: {npc:11758} stands on the east side of town, where you come in."] = "Revenez vers l'ouest jusqu'à {area:976} : {npc:11758} se tient du côté est de la ville, là où vous entrez.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",

	-- Step 27: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "Chevauchez vers le sud-est jusqu'au {area:985}. {npc:7847} se tient au milieu du camp sud des Bat-le-désert : faites d'abord le ménage autour de lui.\nAttention : deux Voleurs Bat-le-désert camouflés l'accompagnent partout où il va. À son camp d'apparition, deux mages de l'ombre et leurs serviteurs sont assez proches pour se joindre au combat. Près des tours, vous pouvez l'affronter sans eux.",

	-- Step 28: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Chevauchez vers le sud après le {area:1938} jusqu'au {area:981}, les tunnels Hazzali ; l'équipement de Scrimshank se trouve tout au fond.\nAttention : un insecte garde l'équipement. De nombreux insectes patrouillent dans les tunnels, certains de niveau 50, et les combats attirent souvent des renforts.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593} ; sous terre",

	-- Step 29: Gadgetzan
	-- {zone:1457} Darnassus
	["for {zone:1457}, next"] = "pour {zone:1457}, ensuite",

	-- Step 30: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {zone:1457} Darnassus · {npc:7763} Curgle Cranklehop · {area:442} Auberdine · {area:150} Menethil Harbor · {area:348} Aerie Peak
	["{zone:1457} first, while you are on this side of the sea: Troyas' answer, {npc:7763}'s crate, Tyrande and the soil errand, then the boat from {area:442} to {area:150} and the gryphon to {area:348}."] = "{zone:1457} d'abord, tant que vous êtes de ce côté de la mer : la réponse de Troyas, la caisse de {npc:7763}, Tyrande et la mission de la terre, puis le bateau d'{area:442} pour {area:150} et le griffon pour {area:348}.",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maître de vol de {area:976}",

	-- Step 31: Teldrassil
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:3838} Vesprystus
	["Take the boat from {area:442}'s dock to {area:702}; {npc:3838}, the hippogryph master, stands on the rise just east of the landing: learn the flight path on the way up to the village."] = "Prenez le bateau au quai d'{area:442} jusqu'au {area:702} ; {npc:3838}, le maître des hippogriffes, se tient sur la butte juste à l'est du débarcadère : apprenez le trajet aérien en montant vers le village.",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maître de vol du {area:702}",

	-- Step 32: Rut'theran Village
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} se tient à l'étage, au-dessus de {npc:7916} : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "La mission suivante de {npc:7907} mène à {zone:1446} : passez-la.",
	-- {npc:7916} Erelas Ambersky · {zone:1425} Hinterlands
	["{npc:7916}: the feathers lie in the {zone:1425}, next"] = "{npc:7916} : les plumes se trouvent dans les {zone:1425}, ensuite",
	["the book on her table"] = "le livre sur sa table",

	-- Step 34: Temple of the Moon
	["Temple of the Moon"] = "Temple de la Lune",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Passez le portail pour entrer dans {zone:1457}. Le temple de la Lune se trouve dans le sud de la ville.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, à côté d'elle",

	-- Step 38: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, au sommet de l'arbre",

	-- Step 39: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 40: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "la terre vient de {zone:1449}, plus tard",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portail pour {zone:1438}",

	-- Step 43: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 44: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "Prendre un vol pour {area:348}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maître de vol du {area:150}",

	-- Step 45: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vol pour {area:271}",

	-- Step 46: Hinterlands
	-- {area:348} Aerie Peak · {area:271} Southshore · {zone:1425} Hinterlands
	["No flight path to {area:348} yet: ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border."] = "Pas encore de trajet aérien vers {area:348} : chevauchez vers le nord-est en sortant d'{area:271} par la route jusqu'aux {zone:1425} ; {area:348} se trouve juste après la frontière.",

	-- Step 47: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master"] = "{npc:5636}, à côté du maître de vol",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}, à l'intérieur",

	-- Step 50: Sprinkle's Secret Ingredient
	["Underwater"] = "Sous l'eau",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Volez de {area:976} à Theramore, prenez le bateau pour {area:150} et volez jusqu'à {area:1537}. Entraînez-vous.",
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "Volez jusqu'à {area:348}. Le guide des {zone:1425} commence ici.",
	-- ["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "Suivez la côte vers le sud jusqu'à la Crique des Gréements. Des Pirates des Mers du sud envahissent la plage et les bateaux : progressez par les bords et attirez-les un par un. {npc:7883} se tient de l'autre côté ; la cargaison volée de {npc:7881} se trouve dans le camp.",
	-- ["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "Depuis le quai de la {area:1108}, prenez le bateau pour le Bastion de Pennelune et volez jusqu'à {area:489}, puis chevauchez vers l'est à travers {zone:1441} jusqu'au {area:2240} sur les {area:439}. {npc:4454} et {npc:4630} sont dans les camps près de la piste ; {npc:4709} se tient près du camp gobelin.",
	-- ["He runs off to keep Rizzle busy"] = "Il s'éloigne pour occuper Rizzle Brassbolts",
	-- ["Hearth to {area:976}"] = "Pierre de foyer vers {area:976}",
	-- ["Hearth to {area:976}."] = "Pierre de foyer vers {area:976}.",
	-- ["Ride back west to {area:976}."] = "Revenez vers l'ouest jusqu'à {area:976}.",
	-- ["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "Revenez vers l'ouest en direction de {area:976}. Des Bandits Bat-le-désert et des Larrons Bat-le-désert tiennent les dunes en chemin ; chacun d'eux peut porter une Outre de Bat-le-désert.",
	-- ["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Chevauchez au nord-ouest jusqu'au Repaire nuisible, la ruche Centipaar dans les dunes. Tout Centipaar peut laisser tomber des Morceaux d'insecte Centipaar.",
	-- ["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "Chevauchez vers le sud dans la {quest:3362}. Les Chardonniers collecteurs de rosée laissent tomber les glandes ; seules certaines sont pleines, gardez la Glande de rosée remplie. Les Chardonniers noueux et les Chardonniers taille-racine partagent la vallée. Les Chardonniers noueux sont de niveau 48-50, au-dessus de vous : attirez-les un par un.",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Chevauchez vers le sud au-delà du {area:1938} jusqu'au {area:981}, les tunnels Hazzali ; l'équipement d'analyse de Scrimshank se trouve tout au fond.",
	-- ["Ride south-east off the {area:439} into {area:440}. {area:976} is just inside the border."] = "Chevauchez vers le sud-est en quittant les {area:439} pour entrer en {area:440}. {area:976} se trouve juste après la frontière.",
	-- ["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Chevauchez au sud-est jusqu'au {area:985}. {npc:7847} se tient au centre du camp Bat-le-désert sud : nettoyez autour de lui d'abord.",
	-- ["Rizzle's plans"] = "Les Plans de Rizzle",
	-- ["The Wanted poster by {npc:7882}"] = "L'affiche Avis de recherche près de {npc:7882}",
	-- ["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "Les Voleurs Bat-le-désert, Mages de l'ombre Bat-le-désert et Assassins Bat-le-désert, plus coriaces, campent au sud-est de {area:976}, au sud des bandits. Laissez {npc:7847} au centre du camp sud pour plus tard.",
	-- ["The {area:2240} lies on the {area:439} in south-east {area:400}. {npc:4454} and {npc:4630} are in the camps beside the track.\n{npc:4709} stands by the goblin camp.\nWhile {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "{area:2240} se trouve sur les {area:439}, dans le sud-est des {area:400}. {npc:4454} et {npc:4630} sont dans les camps à côté de la piste.\n{npc:4709} se tient près du camp gobelin.\nPendant que {npc:4709} occupe Rizzle, ses plans sont sans surveillance dans le camp gnome de l'autre côté de la piste.",
	-- ["Wastewander bandits"] = "Les bandits Bat-le-désert",
	-- ["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Pendant que {npc:4709} retient Rizzle Brassbolts, ses plans sont laissés sans surveillance dans le camp gnome de l'autre côté de la piste.",
	-- ["for {zone:1457}: the route takes you there at 47"] = "pour {zone:1457} : l'itinéraire vous y mène au niveau 47",
	-- ["grind on {npc:5474}"] = "tuez en boucle : {npc:5474}",
	-- ["{item:8483} on the way"] = "{item:8483} en chemin",
	-- ["{npc:11758}, on the east side of town"] = "{npc:11758}, à l'est de la ville",
	-- ["{npc:7583}'s next ingredient grows in the {area:47}, and the route never brings it back: skip it."] = "L'ingrédient suivant de {npc:7583} pousse dans les {area:47}, et l'itinéraire n'y revient jamais : passez-le.",
	-- ["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "L'ingrédient suivant de {npc:7583} pousse dans les {zone:1425}, et l'itinéraire n'y revient jamais : passez-le.",
	-- ["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "La livraison suivante de {npc:7881} retourne à {area:35} : passez-la.",
	-- ["{npc:7881}, in the port's tavern"] = "{npc:7881}, dans la taverne du port",
	-- ["{object:20805}, inside"] = "{object:20805}, à l'intérieur",
}
