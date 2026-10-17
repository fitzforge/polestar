-- French (frFR): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} est votre base pour ce guide. Tous ceux dont vous avez besoin se tiennent à quelques pas de l'auberge.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, le maître des coursiers du vent",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449} : les harpies viendront plus tard, dans {area:383}",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Trotteurs des plaines et raptors",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Les Trotteurs des plaines et les raptors solécaille parcourent les plaines tout autour de la {area:380}, surtout au nord.",

	-- Step 4: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "Les Messagers zhévra paissent au nord et à l'est de la ville.",
	["Zhevra"] = "Zhévras",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Camp Tranchecrin",
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Les Rôdeurs des savanes chassent dans les plaines entre la ville et le camp Tranchecrin à l'est. Dans le camp, les Sourciers et les Tisseuses d’épines tiennent la moitié ouest, les Chasseurs le centre ; les caisses de ravitaillement se trouvent à l'extrémité est.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} se tient sur la crête au nord du camp Tranchecrin.",

	-- Step 8: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Suivez la route vers l'est jusqu'à l'avant-poste au-dessus de {area:814}.",

	-- Step 9: Thunder lizards across the river
	["Thunder lizards across the river"] = "Lézards-tonnerre de l'autre côté de la rivière",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Les Lézards-tonnerre et les Foudroyants paissent juste de l'autre côté du pont, sous {area:379}.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} attend sur la berge au sud de {area:379}, de l'autre côté du pont.",

	-- Step 12: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Sectateurs de {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Les Sectateurs de la Lame ardente tiennent {area:1898}, dans le nord de {zone:1411} ; ils laissent tomber la {item:6652}. Le {item:5026} vient des Tranchecrin lors de votre prochaine visite à leur camp.",

	-- Step 13: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} campe au bord de la route de la {area:380} à {area:392}. Le {object:58369} se trouve dans le sud du camp Tranchecrin, juste au nord de lui.",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Suivez la route vers le sud-est jusqu'à {area:392}, sur la côte.",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442} : la console est dans {area:382}, plus tard",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, sur le quai",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Plage des Mers du sud",
	-- {area:392} Ratchet
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Les pirates campent sur la plage au sud de {area:392}. Les tas de pièces compliquées se trouvent dans le sable parmi eux.",

	-- Step 17: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Redescendez la plage après le camp pirate : la caisse de bottes et la caisse fragile avec la lentille se trouvent à son extrémité sud.",

	-- Step 19: The Crossroads
	-- {area:380} The Crossroads
	["Walk back west along the road to the {area:380}."] = "Revenez vers l'ouest par la route jusqu'à la {area:380}.",

	-- Step 20: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Retour au camp Tranchecrin. Les Géomanciennes et les Défenseurs tiennent sa moitié est ; {npc:3438} se promène parmi eux.",

	-- Step 21: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} fabrique le {item:6636} avec le goudron et la bourse. Utilisez-le près du brasero à côté de lui pour révéler la {npc:5893}, tuez-la pour obtenir la {item:6655}, puis placez la braise dans le brasero.",

	-- Step 22: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907} : {npc:2523}, votre {item:5176} et le {item:263412}",

	-- Step 23: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, un lion blanc, rôde dans les plaines au nord du camp Tranchecrin.",

	-- Step 24: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "La {object:4141} se trouve sur le site de recherche de la KapitalRisk à l'ouest de {area:382}. Fermez les trois vannes autour du foreur, utilisez de nouveau la console, puis prenez la {item:5089} sur {npc:3471}, à côté.",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} à {area:392} : plus tard, en chemin",

	-- Step 25: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "À l'ouest vers {area:383}. Les harpies Ensorçaile y nichent partout ; chacune peut laisser tomber une serre. {quest:819} se trouve dans leurs collines.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "Au sud vers le poste de guet de {npc:3389}, à la frontière kolkar.",

	-- Step 27: The Forgotten Pools
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Les bassins se trouvent juste au nord de {npc:3389}. Entrez dans l'eau pour les explorer ; les Champignons chargés pour Helbrim poussent autour. Tuez chaque kolkar sur votre passage pour les brassards.",

	-- Step 28: Kolkar camps
	["Kolkar camps"] = "Camps kolkar",
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Kolkar Wranglers = {npc:3272} Kolkar Wrangler
	["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Les Querelleurs et les Légions-tempête kolkar tiennent les camps au sud de {npc:3389}.",

	-- Step 31: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Au sud-est de la {area:380}. Testez les graines à la fissure bouillonnante sur la rive est de l'oasis.",

	-- Step 32: Raptor nests
	["Raptor nests"] = "Nids de raptors",
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Les trois nids se trouvent ensemble à {area:1697}, au sud-ouest de l'oasis ; des Faucheurs solécaille les gardent.",

	-- Step 33: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "À l'est vers {area:392}, sur la côte.",

	-- Step 34: The Crossroads
	["Back west along the road."] = "Revenez vers l'ouest par la route.",

	-- Step 35: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Les Gueules d'acier des oasis rampent autour de {area:387}, au sud-ouest de la {area:380}, et autour de {area:388}.",

	-- Step 36: The Crossroads
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301} : {area:228} en {zone:1421}, guide suivant",

	-- Step 37: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Les Tueuses Ensorçaile tiennent l'ouest de {area:383} ; elles portent les anneaux.",

	-- Step 38: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "À l'est vers {area:1703} ; {npc:9316} se tient au camp juste au sud.",

	-- Step 39: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Les seaux à outils avec les rondelles se trouvent autour du site de forage de la KapitalRisk, dans {area:382}, à l'est de {npc:9316}.",

	-- Step 40: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar
	["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Gardez-la : {quest:3923} se tient devant {zone:1454} ; un guide ultérieur la rend",

	-- Step 41: The Crossroads
	-- {area:380} The Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Revenez vers le sud jusqu'à la {area:380}. Le guide suivant commence ici et vous emmène à {zone:1454} et au zeppelin pour {zone:1420}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Les Gueules d'acier des oasis rampent autour de {area:387}, au sud-ouest de {area:380}, et autour de {area:388}.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Les Trotteurs des plaines et les raptors solécaille parcourent les plaines tout autour de {area:380}, surtout au nord.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Au sud-est de {area:380}. Testez les graines à la fissure bouillonnante sur la rive est de l'oasis.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Thun'grim campe au bord de la route de {area:380} à {area:392}. Le {object:58369} se trouve dans le sud du camp Tranchecrin, juste au nord de lui.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Revenez vers le sud jusqu'à {area:380}. Le guide suivant commence ici et vous emmène à {zone:1454} et au zeppelin pour {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Revenez vers l'ouest par la route jusqu'à {area:380}.",
}
