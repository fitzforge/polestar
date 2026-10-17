-- French (frFR): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Volez jusqu'au {area:378}",
	-- {npc:6791} Innkeeper Wiley
	["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",

	-- Step 2: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Partez vers l'est depuis le {area:378} par la route qui entre dans le marais. {area:403}, incendiée, se dresse au bord de la route juste après la frontière ; le bouclier, l'insigne et les empreintes de sabots sont dans la ruine et à côté.",

	-- Step 3: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "À l'embranchement, prenez la route du nord jusqu'au village ogre de Mur-de-Fougères.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, à l'entrée sud du village, là où arrive la route",

	-- Step 4: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} attend dans {area:2302}, à l'est du village. Suivez-le jusqu'à Reethe et gardez-le en vie pendant le combat qui éclate.",

	-- Step 5: Stinky Ignatz
	["Stinky Ignatz"] = "Ignatz \"Puant\"",
	-- {area:502} Witch Hill
	["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Partez au nord jusqu'à la {area:502}. Ignatz se tient au pied de la colline ; escortez-le pendant qu'il cueille du Trèfle des marais juste au sud.",

	-- Step 6: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs Aileron boueux",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Les murlocs Aileron boueux peuplent la côte à l'est et au nord-est de la {area:502} ; tous laissent tomber des têtes.",

	-- Step 7: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Jarl \"Oeil-des-marais\"",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Jarl vit au {area:497}, au sud-est de la {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, à côté du manoir",

	-- Step 8: Darkfang spiders
	["Darkfang spiders"] = "Araignées Sombrecroc",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator
	["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Retraversez le marais vers l'ouest. Les Crache-venin Sombrecroc des crêtes au nord de Mur-de-Fougères laissent tomber les poches de venin. Des Infiltrateurs de Theramore (35-36) rôdent dans les mêmes bois : ils sont camouflés, regardez bien.",

	-- Step 9: Darkmist Cavern
	["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Les araignées de Sombrebrume grouillent à l'entrée de la caverne au nord-ouest de Mur-de-Fougères ; toutes laissent tomber des yeux.",

	-- Step 11: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Ride east back to the {area:497}."] = "Retournez à l'est jusqu'au {area:497}.",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "seulement si vous avez une {item:3853} ({skill:164} ou Hôtel des ventes)",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, maintenant que {npc:4791} a lu le rapport",

	-- Step 12: Brackenwall Village
	["Ride back west to Brackenwall with the head."] = "Retournez à l'ouest à Mur-de-Fougères avec la tête.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words)
	["For {npc:2519} at {object:3202}, in the next guide"] = "Pour {npc:2519} à {object:3202}, dans le guide suivant",

	-- Step 13: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",

	-- Step 15: Melizza Brimbuzzle
	-- {area:607} Valley of Spears · {npc:12277} Melizza Brimbuzzle
	["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Partez au nord-est jusqu'à la {area:607}. {npc:12277} est retenue dans le camp des centaures maraudine ; libérez-la et escortez-la hors de la vallée, vers l'est.",

	-- Step 16: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} attend au camp gobelin, du côté ouest du {area:596}.",

	-- Step 17: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:602} Mannoroc Coven
	["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "La caravane de {npc:11626} s'arrête sur la route en bordure de {area:602}. Escortez-la vers l'est au-delà du convent ; des démons l'attaquent deux fois.",

	-- Step 18: Scrabblescrew's Camp
	-- {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "La caravane s'arrête au camp de {npc:11596}, du côté est du {area:596}.",

	-- Step 19: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane · {npc:11596} Smeed Scrabblescrew
	["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} et {npc:5412} se tiennent dans le poste juste à l'ouest du camp de {npc:11596}.",

	-- Step 20: Kormek's Hut
	["Ride north up the road to the hut by the road north of the graveyard."] = "Remontez la route vers le nord jusqu'à la hutte au bord de la route, au nord du cimetière.",

	-- Step 21: Kodo bones and ghosts
	["Kodo bones and ghosts"] = "Os de kodo et fantômes",
	-- {item:15848} Crate of Ghost Magnets
	["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Ramassez les os de kodo éparpillés dans le cimetière et utilisez {item:15848} parmi les os : les fantômes qu'elle attire laissent tomber l'ectoplasme.",

	-- Step 24: Thunder Axe Fortress
	-- {area:2407} Kormek's Hut · {item:14523} Demon Pick · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "La Lame ardente tient la forteresse au nord-ouest de la {area:2407}. Utilisez {item:14523} sur {npc:11876} dans la forteresse pour obtenir {item:13542}.",

	-- Step 25: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Partez à l'ouest jusqu'à la tour de {npc:11863} à {area:2405}, sur la côte nord-ouest.",

	-- Step 26: Slitherblade coast
	["Slitherblade coast"] = "Côte des Ondulame",
	-- {area:2405} Ethel Rethor · {area:598} Sar'theris Strand · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Les Nagas Ondulame tiennent la côte au nord de {area:2405}, jusqu'à la {area:598}. {npc:12369} garde {quest:6027} tout au bout de la pointe nord.",

	-- Step 28: Maraudine totems
	["Maraudine totems"] = "Totems maraudine",
	-- {area:2405} Ethel Rethor · {area:607} Valley of Spears · {quest:93225} Carved Centaur Totems
	-- plural, as words: Maraudine Scouts = {npc:4654} Maraudine Scout
	["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Partez au sud depuis {area:2405} jusqu'à la {area:607}. Les Eclaireurs, Querelleurs, Marteleurs, Chasse-vent et Maraudeurs maraudine (36-39) laissent tomber {quest:93225}.",

	-- Step 29: Shadowprey Village
	["Ride on south-west to Shadowprey."] = "Continuez au sud-ouest jusqu'à Proie-de-l'Ombre.",

	-- Step 30: Portals of the Legion
	-- {area:602} Mannoroc Coven
	["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Partez à l'est jusqu'à {area:602}. Utilisez le Rod of Banishing près de chaque portail démoniaque pour en fermer six.",

	-- Step 31: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {area:597} Ghost Walker Post
	["Ride north from the coven to {npc:5412} at {area:597}."] = "Partez au nord du convent jusqu'à {npc:5412}, au {area:597}.",

	-- Step 32: Hearth to Shadowprey
	["Hearth to Shadowprey"] = "Pierre de foyer vers Proie-de-l'Ombre",
	-- {zone:1434} Stranglethorn Vale
	["The next guide takes you back to {zone:1434}."] = "Le guide suivant vous ramène à {zone:1434}.",
}
