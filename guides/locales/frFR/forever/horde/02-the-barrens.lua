-- French (frFR): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zargh
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3448} at the south gate."] = "",

	-- Step 3: The Crossroads
	-- {npc:3464} Gazrog · {area:380} The Crossroads · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["Helbrim and {npc:3464} by the north gate. {area:380} is your base for this guide. Everyone you need stands within a few steps of the inn.\n{npc:3429} and {npc:3449} on the tower platform."] = "",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449} : les harpies viendront plus tard, dans {area:383}",

	-- Step 4: On the way
	["On the way"] = "",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} campe au bord de la route à l'est, vers {area:392}.",

	-- Step 12: Razormane camp
	["Razormane camp"] = "Camp Tranchecrin",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "",

	-- Step 14: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine, as at 10. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "",

	-- Step 15: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907} : {npc:2523}, votre {item:5176} et le {item:263412}",

	-- Step 18: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Suivez la route vers le sud-est jusqu'à {area:392}, sur la côte.",

	-- Step 20: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} est votre base pour ce guide. Tous ceux dont vous avez besoin se tiennent à quelques pas de l'auberge.",

	-- Step 21: Razormane Water Seeker on the way
	-- {npc:3267} Razormane Water Seeker
	["{npc:3267} on the way"] = "",

	-- Step 22: The Barrens: kill these as you meet them
	-- {area:17} The Barrens
	["{area:17}: kill these as you meet them"] = "",
	-- {area:380} The Crossroads
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north.\nCareful: Sunscale Screechers call nearby allies within 30 yd once below 30% health, so dense packs can pull extra raptors."] = "",

	-- Step 24: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "Les Messagers zhévra paissent au nord et à l'est de la ville.",
	["Zhevra"] = "Zhévras",

	-- Step 26: Razormane camp
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Les Rôdeurs des savanes chassent dans les plaines entre la ville et le camp Tranchecrin à l'est. Dans le camp, les Sourciers et les Tisseuses d’épines tiennent la moitié ouest, les Chasseurs le centre ; les caisses de ravitaillement se trouvent à l'extrémité est.",

	-- Step 30: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} se tient sur la crête au nord du camp Tranchecrin.",

	-- Step 31: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Suivez la route vers l'est jusqu'à l'avant-poste au-dessus de {area:814}.",

	-- Step 33: Thunder lizards across the river
	["Thunder lizards across the river"] = "Lézards-tonnerre de l'autre côté de la rivière",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Les Lézards-tonnerre et les Foudroyants paissent juste de l'autre côté du pont, sous {area:379}.",

	-- Step 35: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} attend sur la berge au sud de {area:379}, de l'autre côté du pont.",

	-- Step 36: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Sectateurs de {area:1898}",
	-- {area:1898} Dustwind Gulch · {area:14} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "",

	-- Step 39: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} campe au bord de la route de la {area:380} à {area:392}. Le {object:58369} se trouve dans le sud du camp Tranchecrin, juste au nord de lui.",

	-- Step 41: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442} : la console est dans {area:382}, plus tard",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, sur le quai",

	-- Step 42: Intact Raptor Horn on the way
	-- {item:5055} Intact Raptor Horn
	["{item:5055} on the way"] = "",

	-- Step 43: The Barrens: kill these as you meet them
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them.\nThe pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "",

	-- Step 45: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Redescendez la plage après le camp pirate : la caisse de bottes et la caisse fragile avec la lentille se trouvent à son extrémité sud.",

	-- Step 47: Fly to The Crossroads
	-- {area:380} The Crossroads
	["Fly to {area:380}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 49: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "Au sud vers le poste de guet de {npc:3389}, à la frontière kolkar.",

	-- Step 50: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Les bassins se trouvent juste au nord de {npc:3389}. Entrez dans l'eau pour les explorer ; les Champignons chargés pour Helbrim poussent autour. Tuez chaque kolkar sur votre passage pour les brassards.",

	-- Step 52: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	-- plural, as words: Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "",

	-- Step 53: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "",
	["Inside"] = "",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} à {area:392} : plus tard, en chemin",

	-- Step 54: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn."] = "",

	-- Step 55: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "",

	-- Step 56: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "À l'est vers {area:392}, sur la côte.",

	-- Step 57: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Retour au camp Tranchecrin. Les Géomanciennes et les Défenseurs tiennent sa moitié est ; {npc:3438} se promène parmi eux.",

	-- Step 59: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} fabrique le {item:6636} avec le goudron et la bourse. Utilisez-le près du brasero à côté de lui pour révéler la {npc:5893}, tuez-la pour obtenir la {item:6655}, puis placez la braise dans le brasero.",

	-- Step 63: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Au sud-est de la {area:380}. Testez les graines à la fissure bouillonnante sur la rive est de l'oasis.",
	["Underwater"] = "",

	-- Step 64: The Crossroads
	["Back west along the road."] = "Revenez vers l'ouest par la route.",

	-- Step 65: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "À l'est vers {area:1703} ; {npc:9316} se tient au camp juste au sud.",

	-- Step 66: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Les seaux à outils avec les rondelles se trouvent autour du site de forage de la KapitalRisk, dans {area:382}, à l'est de {npc:9316}.",

	-- Step 67: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "",

	-- Step 68: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the next guide's {zone:1454} visit"] = "",

	-- Step 69: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "",

	-- Step 71: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Les Gueules d'acier des oasis rampent autour de {area:387}, au sud-ouest de la {area:380}, et autour de {area:388}.",

	-- Step 72: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "",
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301} : {area:228} en {zone:1421}, guide suivant",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Les Sectateurs de la Lame ardente tiennent {area:1898}, dans le nord de {zone:1411} ; ils laissent tomber la {item:6652}. Le {item:5026} vient des Tranchecrin lors de votre prochaine visite à leur camp.",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Gardez-la : {quest:3923} se tient devant {zone:1454} ; un guide ultérieur la rend",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Les Querelleurs et les Légions-tempête kolkar tiennent les camps au sud de {npc:3389}.",
	-- ["Kolkar camps"] = "Camps kolkar",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Les Gueules d'acier des oasis rampent autour de {area:387}, au sud-ouest de {area:380}, et autour de {area:388}.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Les Trotteurs des plaines et les raptors solécaille parcourent les plaines tout autour de la {area:380}, surtout au nord.",
	-- ["Plainstriders and raptors"] = "Trotteurs des plaines et raptors",
	-- ["Raptor nests"] = "Nids de raptors",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Au sud-est de {area:380}. Testez les graines à la fissure bouillonnante sur la rive est de l'oasis.",
	-- ["Southsea beach"] = "Plage des Mers du sud",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Les Tueuses Ensorçaile tiennent l'ouest de {area:383} ; elles portent les anneaux.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Les pirates campent sur la plage au sud de {area:392}. Les tas de pièces compliquées se trouvent dans le sable parmi eux.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Les trois nids se trouvent ensemble à {area:1697}, au sud-ouest de l'oasis ; des Faucheurs solécaille les gardent.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "La {object:4141} se trouve sur le site de recherche de la KapitalRisk à l'ouest de {area:382}. Fermez les trois vannes autour du foreur, utilisez de nouveau la console, puis prenez la {item:5089} sur {npc:3471}, à côté.",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Thun'grim campe au bord de la route de {area:380} à {area:392}. Le {object:58369} se trouve dans le sud du camp Tranchecrin, juste au nord de lui.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Revenez vers le sud jusqu'à la {area:380}. Le guide suivant commence ici et vous emmène à {zone:1454} et au zeppelin pour {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Revenez vers l'ouest par la route jusqu'à la {area:380}.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "À l'ouest vers {area:383}. Les harpies Ensorçaile y nichent partout ; chacune peut laisser tomber une serre. {quest:819} se trouve dans leurs collines.",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, le maître des coursiers du vent",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, un lion blanc, rôde dans les plaines au nord du camp Tranchecrin.",
}
