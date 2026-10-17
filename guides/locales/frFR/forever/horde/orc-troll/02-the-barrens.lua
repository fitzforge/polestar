-- French (frFR): the guide forever/horde/orc-troll/02-the-barrens (forever/horde/orc-troll/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3464} Gazrog · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3429} and {npc:3449} on the tower platform; Helbrim and {npc:3464} by the north gate; {npc:3448} at the south gate."] = "Vous arrivez depuis {area:379}. {npc:3338} se tient près de l'auberge ; {npc:3429} et {npc:3449} sur la plateforme de la tour ; Helbrim et {npc:3464} près de la porte nord ; {npc:3448} à la porte sud.",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Trotteurs des plaines et raptors",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Les Trotteurs des plaines et les raptors solécaille parcourent les plaines tout autour de la {area:380}.",

	-- Step 4: Zhevra and raptors
	["Zhevra and raptors"] = "Zhévras et raptors",
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze on the same plains; finish the raptor heads as you go."] = "Les Messagers zhévras paissent dans les mêmes plaines ; terminez les têtes de raptor en chemin.",

	-- Step 5: The Crossroads
	-- {npc:3449} Darsok Swiftdagger
	["{npc:3449}, on the tower platform: needs level 12"] = "{npc:3449}, sur la plateforme de la tour : niveau 12 requis",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} campe au bord de la route à l'est, vers {area:392}.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {area:380} The Crossroads
	["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} se tient sur la crête au nord du camp Tranchecrin, à l'est de la {area:380}.",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {zone:1411} Durotar · {area:814} Southfury River
	["{npc:5900} waits on the {zone:1411} bank of the {area:814}, east of the Razormane camp."] = "{npc:5900} attend sur la rive de {area:814} côté {zone:1411}, à l'est du camp Tranchecrin.",

	-- Step 9: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Sectateurs de {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {area:370} Drygulch Ravine · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}, by {area:370}; they drop the {item:6652}."] = "Les Sectateurs de la Lame ardente tiennent {area:1898}, dans le nord de {zone:1411}, près de {area:370} ; ils laissent tomber la {item:6652}.",

	-- Step 10: Razormane camp
	["Razormane camp"] = "Camp Tranchecrin",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Les Sourciers, Tisseuses d'épines et Chasseurs Tranchecrin tiennent le camp à l'est de la {area:380}. Les caisses de ravitaillement sont à son extrémité est. Guerriers : le {object:58369} se trouve dans le camp. Chamans : les huran laissent tomber le {item:5026}. Tuez les Rôdeurs des savanes que vous croisez pour leurs griffes.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} prépare le {item:6636} avec le goudron et la bourse. Utilisez-le près du brasero à côté de lui pour révéler la {npc:5893}, tuez-la pour obtenir la {item:6655}, puis placez la braise dans le brasero.",

	-- Step 12: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907} : {npc:2523}, votre {item:5176} et le {item:263412}",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Suivez la route au sud-est jusqu'à {area:392}, sur la côte.",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, sur le quai",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Plage des Mers du sud",
	-- {area:392} Ratchet
	["The pirates camp along the beach south of {area:392}. The piles of complicated parts lie in and around their camp."] = "Les pirates campent le long de la plage au sud de {area:392}. Les tas de pièces compliquées se trouvent dans leur camp et autour.",

	-- Step 17: Stolen Booty
	-- {object:3767} Drizzlik's Emporium
	["Back to the pirate camp: the boots are in the crate marked {object:3767} at the camp's south end, the lens in the Fragile crate just east of it."] = "Retournez au camp des pirates : les bottes sont dans la caisse marquée {object:3767} à l'extrémité sud du camp, la lentille dans la caisse Fragile juste à l'est.",

	-- Step 19: Back to the The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}"] = "Retour à la {area:380}",
	-- {area:380} The Crossroads
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Remontez la route jusqu'à la {area:380}. Les Rôdeurs des savanes chassent le long de celle-ci et dans les plaines à l'ouest de la ville : terminez les griffes avant de les rendre.",

	-- Step 20: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} The Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} se tient au poste de guet face aux Kolkar, juste à l'ouest de la {area:380}.",

	-- Step 21: Kolkar camps and the Forgotten Pools
	-- {area:386} Forgotten Pools
	["Kolkar camps and the {area:386}"] = "Camps kolkar et {area:386}",
	-- {npc:3389} Regthar Deathgate · {quest:855} Centaur Bracers · {area:386} Forgotten Pools
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Kolkar camps spread north-west of {npc:3389}; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Les camps kolkar s'étendent au nord-ouest de {npc:3389} ; chaque Kolkar peut laisser tomber {quest:855}. {area:386} se trouvent en leur milieu, avec des Champignons chargés autour de l'eau. Les Rôdeurs des savanes parcourent les mêmes plaines.",
	["Wade into the pools to explore them"] = "Entrez dans les bassins pour les explorer",

	-- Step 23: Witchwing harpies
	["Witchwing harpies"] = "Harpies Ensorçaile",
	-- {area:383} Dry Hills · {area:386} Forgotten Pools
	["The harpies nest in the {area:383} north-west of the {area:386}; any of them can drop a talon."] = "Les harpies nichent dans {area:383}, au nord-ouest de {area:386} ; chacune peut laisser tomber une serre.",

	-- Step 24: The Sludge Fen
	-- {area:382} The Sludge Fen · {object:4141} Control Console · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Allez à l'est jusqu'au site de recherche de la KapitalRisk, à l'ouest de la {area:382}. Utilisez la {object:4141}, fermez les trois vannes autour de la foreuse, réutilisez la console, puis prenez la {item:5089} sur {npc:3471}.",

	-- Step 25: Echeyakee
	-- {quest:881} Echeyakee · {area:382} The Sludge Fen · {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {area:392} Ratchet
	["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn {npc:3338} gave you there to call the white lion out. Then hearth to {area:392}."] = "L'antre d'{quest:881} se trouve au sud de la {area:382}, au nord-est de la {area:380}. Utilisez-y la corne que {npc:3338} vous a donnée pour faire sortir le lion blanc. Puis utilisez votre Pierre de foyer pour aller à {area:392}.",

	-- Step 27: The Disruption Ends
	-- {area:380} The Crossroads · {npc:3438} Kreenig Snarlsnout
	["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "En revenant vers la {area:380}, repassez par le camp Tranchecrin : les Géomanciennes et les Défenseurs Tranchecrin tiennent sa moitié est ; {npc:3438} circule parmi eux.",

	-- Step 29: The Stagnant Oasis
	-- {area:380} The Crossroads
	["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "L'oasis se trouve au sud-est de la {area:380}. Testez les graines à la fissure bouillonnante au milieu de l'eau.",

	-- Step 30: Raptor Grounds
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The {area:1697} lie south-west of the oasis. Sunscale Scytheclaws drop the feathers you use on the three nests."] = "{area:1697} se trouvent au sud-ouest de l'oasis. Les Faucheurs solécaille laissent tomber les plumes à utiliser sur les trois nids.",

	-- Step 32: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Les Gueules d'acier des oasis peuplent l'eau de {area:387}, au sud-ouest de la {area:380}.",

	-- Step 34: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["Follow the road north to the {area:1703}; {npc:9316} stands just south of it."] = "Suivez la route au nord jusqu'à {area:1703} ; {npc:9316} se tient juste au sud.",

	-- Step 35: Nugget Slugs
	-- {area:382} The Sludge Fen · {npc:9316} Wenikee Boltbucket
	-- plural, as words: Tool Buckets = {object:161752} Tool Bucket
	["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of {npc:9316}."] = "Les Seaux d'outils sont posés autour du camp de la KapitalRisk dans la {area:382}, à l'est de {npc:9316}.",

	-- Step 37: Witchwing Slayers
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Witchwing Slayers"] = "Tueuses Ensorçaile",
	-- {area:383} Dry Hills
	["The Slayers hold the western end of the {area:383}, past the harpies you fought before; they drop the rings."] = "Les Tueuses tiennent l'extrémité ouest de {area:383}, au-delà des harpies déjà combattues ; elles laissent tomber les anneaux.",
	-- {area:383} Dry Hills · {zone:1413} The Barrens
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["grind on Witchwing Slayers at the {area:383}, {zone:1413}"] = "tuez des Tueuses Ensorçaile dans {area:383}, {zone:1413}",

	-- Step 38: The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}; the next guide starts here."] = "Retournez à la {area:380} ; le guide suivant commence ici.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:380}"] = "Retour à {area:380}",
	-- ["Back to the {area:380}; the next guide starts here."] = "Retournez à {area:380} ; le guide suivant commence ici.",
	-- ["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Allez à l'est jusqu'au site de recherche de la KapitalRisk, à l'ouest de {area:382}. Utilisez la {object:4141}, fermez les trois vannes autour de la foreuse, réutilisez la console, puis prenez la {item:5089} sur {npc:3471}.",
	-- ["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Les Gueules d'acier des oasis peuplent l'eau de {area:387}, au sud-ouest de {area:380}.",
	-- ["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "En revenant vers {area:380}, repassez par le camp Tranchecrin : les Géomanciennes et les Défenseurs Tranchecrin tiennent sa moitié est ; {npc:3438} circule parmi eux.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Les Trotteurs des plaines et les raptors solécaille parcourent les plaines tout autour de {area:380}.",
	-- ["Regthar stands at the Kolkar watch post just west of the {area:380}."] = "Regthar se tient au poste de guet face aux Kolkar, juste à l'ouest de {area:380}.",
	-- ["The Kolkar camps spread north-west of Regthar; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Les camps kolkar s'étendent au nord-ouest de Regthar ; chaque Kolkar peut laisser tomber {quest:855}. {area:386} se trouvent en leur milieu, avec des Champignons chargés autour de l'eau. Les Rôdeurs des savanes parcourent les mêmes plaines.",
	-- ["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of Wenikee."] = "Les Seaux d'outils sont posés autour du camp de la KapitalRisk dans {area:382}, à l'est de Wenikee.",
	-- ["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "L'oasis se trouve au sud-est de {area:380}. Testez les graines à la fissure bouillonnante au milieu de l'eau.",
	-- ["The {area:386}"] = "{area:386}",
	-- ["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Remontez la route jusqu'à {area:380}. Les Rôdeurs des savanes chassent le long de celle-ci et dans les plaines à l'ouest de la ville : terminez les griffes avant de les rendre.",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Les Sourciers, Tisseuses d'épines et Chasseurs Tranchecrin tiennent le camp à l'est de {area:380}. Les caisses de ravitaillement sont à son extrémité est. Guerriers : le {object:58369} se trouve dans le camp. Chamans : les huran laissent tomber le {item:5026}. Tuez les Rôdeurs des savanes que vous croisez pour leurs griffes.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} se tient sur la crête au nord du camp Tranchecrin, à l'est de {area:380}.",
	-- ["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn Sergra gave you there to call the white lion out. Then hearth to {area:392}."] = "L'antre d'{quest:881} se trouve au sud de {area:382}, au nord-est de {area:380}. Utilisez-y la corne que Sergra vous a donnée pour faire sortir le lion blanc. Puis utilisez votre Pierre de foyer pour aller à {area:392}.",
}
