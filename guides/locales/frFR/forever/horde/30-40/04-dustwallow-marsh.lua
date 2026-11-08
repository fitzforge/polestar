-- French (frFR): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, pour « Œil-des-marais » Jarl",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor
	["{npc:3354}, {object:172958}: for Fray Island, later in this guide (offered from level 30)"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "",

	-- Step 6: Fly to Camp Taurajo
	["Fly to Camp Taurajo"] = "",
	["Crossroads flight master"] = "",

	-- Step 8: Shady Rest Inn
	-- {object:21077} Shady Rest Inn (no name in this language: may be words)
	["Head east from Camp Taurajo along the road into the marsh. The burned-out {object:21077} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "À l'embranchement, prenez la route du nord jusqu'au village ogre de Mur-de-Fougères.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, à l'entrée sud du village, là où arrive la route",

	-- Step 11: Questioning Reethe
	-- {npc:4983} Ogron
	["{npc:4983} waits in the Quagmire east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "Ignatz \"Puant\"",
	["Head north to Witch Hill. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs Aileron boueux",
	["The Mirefin murlocs crowd the coast east and north-east of Witch Hill; every kind drops heads."] = "",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Jarl \"Oeil-des-marais\"",
	["Jarl lives in the Swamplight Manor south-east of Witch Hill."] = "",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, à côté du manoir",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "",

	-- Step 15: Brackenwall Village: kill these as you meet them
	-- {object:21082} Brackenwall Village (no name in this language: may be words)
	["{object:21082}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Retraversez le marais vers l'ouest. Les Crache-venin Sombrecroc, sur les crêtes au nord de Fougeraie, lâchent les poches de venin. Les Infiltrateurs de Theramore (35-36) se faufilent dans les mêmes bois : ils sont camouflés, regardez bien.\nLes araignées de Sombrebrume grouillent à l'entrée de la caverne au nord-ouest de Fougeraie ; toutes lâchent des yeux.\nAttention : les Rôdeuses Sombrecroc (niveau 36-37) se camouflent hors combat et lancent Poison une fois en combat.\nAttention : des araignées camouflées dans la même zone vous attaquent à vue.\nAttention : les Rôdeuses de Sombrebrume se déplacent camouflées et utilisent du poison en combat. Les araignées sont serrées les unes contre les autres, les monstres en plus sont donc fréquents ; attirer des cibles isolées depuis le bord extérieur les limite.",

	-- Step 17: Swamp Eye Jarl
	["Head east back to the Swamplight Manor."] = "",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, maintenant que {npc:4791} a lu le rapport",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "seulement si vous avez une {item:3853} ({skill:164} ou Hôtel des ventes)",

	-- Step 18: The Theramore Docks
	["Underwater"] = "Sous l'eau",

	-- Step 19: Level 37.5
	["Level 37.5"] = "",
	-- {zone:1443} Desolace
	["{zone:1443}'s last quests and Alterac are 38-41. Below 37.5? Keep killing the Mirefin murlocs along the north-east coast, past Witch Hill, until level 37.5. Or, with a group, run the Razorfen Downs dungeon or the Scarlet Monastery dungeon (Armory) instead."] = "",
	-- {npc:4362} Mirefin Coastrunner
	["grind on {npc:4362}"] = "",

	-- Step 20: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words)
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "",

	-- Step 21: Fly to Ratchet
	["Fly to Ratchet"] = "",
	-- {object:21082} Brackenwall Village (no name in this language: may be words)
	["{object:21082} flight master"] = "",

	-- Step 22: Ratchet
	["Ratchet"] = "",
	-- {npc:3391} Gazlowe · {npc:3446} Mebok Mizzyrix
	["{npc:3391} waits upstairs in the house by the flight master; {npc:3446} stands below it, towards the docks."] = "",
	-- {npc:3391} Gazlowe · {object:3204} Booty Bay (no name in this language: may be words)
	["{npc:3391}'s next errand takes you to {object:3204}, off this part of the route: leave it."] = "",

	-- Step 23: The Affray
	-- {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from Ratchet to Fray Island. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236}: Berserker Stance"] = "{npc:6236} : Posture berserker",

	-- Step 24: Fly to Shadowprey Village
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["Fly to {object:176946}"] = "",
	["Ratchet flight master"] = "",

	-- Step 25: Shadowprey Village
	-- {npc:11624} Taiga Wisemane
	["{npc:11624} stands in the village."] = "",

	-- Step 26: Portals of the Legion
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to Mannoroc Coven. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",
	["Mannoroc Coven"] = "",

	-- Step 27: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["North to the post; {npc:5412} stands beside {npc:5395}."] = "",

	-- Step 28: Valley of Spears
	["Valley of Spears"] = "",
	-- {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["West of the post, the Maraudine centaurs hold the Valley of Spears. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}."] = "",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle
	["{npc:6019} waits at the goblin camp on the west side of the Kodo Graveyard."] = "",

	-- Step 31: The Valley of Bones
	["The Valley of Bones"] = "",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east to the bone fields of the Valley of Bones, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "",

	-- Step 32: Hornizz Brimbuzzle
	["North to the goblin camp on the west side of the Kodo Graveyard."] = "",

	-- Step 34: Shadowprey
	["Shadowprey"] = "Proie-de-l'Ombre",
	["West to Shadowprey."] = "",

	-- Step 35: Thunder Bluff
	-- {object:176946} Shadowprey Village (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {zone:1454} Orgrimmar
	["Fly from {object:176946} to {zone:1456} and train with {npc:3033} on {object:50507}; fly on to {zone:1454} from there."] = "",

	-- Step 36: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["{object:176946} flight master"] = "",

	-- Step 37: Back to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Back to {zone:1454}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 38: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars
	["{npc:3412}, in the {object:172958} beside {npc:4485}: {quest:2841}, if you ran Gnomeregan"] = "",

	-- Step 39: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:496}"] = "Retour à {area:496}",
	-- ["Darkfang spiders"] = "Araignées Sombrecroc",
	-- ["Fly to {area:2408}"] = "Prendre un vol pour {area:2408}",
	-- ["Fly to {area:378}"] = "Volez jusqu'au {area:378}",
	-- ["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "Pour {npc:2519} à {object:3202}, dans le guide suivant",
	-- ["Head back west to Brackenwall with the head."] = "Retournez vers l'ouest jusqu'à Fougeraie avec la tête.",
	-- ["Head east back to the {area:497}."] = "Retournez vers l'est jusqu'à {area:497}.",
	-- ["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Allez vers l'est depuis le {area:378} par la route qui entre dans le marais. Les ruines incendiées de {area:403} se dressent au bord, juste après la frontière ; le bouclier, l'insigne et les empreintes de sabots sont dans la ruine et à côté.",
	-- ["Head east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "Allez vers l'est jusqu'à {area:602}. Utilisez le Bâtonnet de bannissement près de chaque portail démoniaque pour en fermer six.\nAttention : des Infernaux, des Gardes funestes et des Invocateurs de la Lame ardente circulent près de nombreux portails et peuvent se joindre au combat ; tuez d'abord les monstres proches ou éloignez le gardien, par exemple vers le lac central du cercle.",
	-- ["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Allez vers le nord jusqu'à {area:502}. Stinky se tient au pied de la colline ; escortez-le pendant qu'il ramasse des feuilles de fève des marais juste au sud.",
	-- ["Head north to {npc:5412} at {area:597}."] = "Allez vers le nord jusqu'à {npc:5412}, à {area:597}.",
	-- ["Head north up the road to the hut by the road north of the graveyard."] = "Remontez la route vers le nord jusqu'à la hutte au bord de la route, au nord du cimetière.",
	-- ["Head north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "Allez vers le nord-est jusqu'à {area:607}. {npc:12277} est retenue dans le camp des centaures Maraudine ; libérez-la et escortez-la hors de la vallée, vers l'est.\nAttention : les groupes scénarisés sont liés et n'apparaissent que pendant l'escorte, vous ne pouvez donc pas les éliminer à l'avance ni les attirer un par un. Éliminer avant de commencer les centaures normaux sur le chemin aide quand même.",
	-- ["Head on south-west to Shadowprey."] = "Continuez vers le sud-ouest jusqu'à Proie-de-l'Ombre.",
	-- ["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Descendez la côte vers le sud depuis {area:392} jusqu'à {area:720}. {npc:6236} se tient près de l'arène : marchez sur la grille pour lancer le combat ; les adversaires arrivent un par un, puis {npc:6238} (33).",
	-- ["Head south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Allez vers le sud depuis {area:2405} jusqu'à {area:607}. Les Éclaireurs, Dresseurs, Écharpeurs, Chasse-vent et Maraudeurs maraudine (36-39) lâchent {quest:93225}.",
	-- ["Head south-east from the coven to the bone fields of the {area:2657}, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "Allez vers le sud-est depuis le cercle jusqu'aux champs d'ossements de {area:2657}, où rôdent des Ravageurs morts-vivants. Tout au sud-est, utilisez la {item:15848} pour attirer les Spectres magrami : ils lâchent l'ectoplasme.",
	-- ["Hearth to Shadowprey"] = "Pierre de foyer vers Proie-de-l'Ombre",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["His next errand is not on this route."] = "Sa course suivante ne fait pas partie de cette route.",
	-- ["Jarl lives in the {area:497} south-east of {area:502}."] = "Jarl vit au {area:497}, au sud-est de la {area:502}.",
	-- ["Kodo bones"] = "Os de kodo",
	-- ["Kodo bones and ghosts"] = "Os de kodo et fantômes",
	-- ["Maraudine totems"] = "Totems maraudine",
	-- ["On the top floor"] = "Au dernier étage",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Ramassez les os de kodo éparpillés dans le cimetière et utilisez {item:15848} parmi les os : les fantômes qu'elle attire laissent tomber l'ectoplasme.",
	-- ["Pick up the kodo bones scattered across the graveyard."] = "Ramassez les os de kodo éparpillés dans le cimetière.",
	-- ["Ride back west to Brackenwall with the head."] = "Retournez à l'ouest à Mur-de-Fougères avec la tête.",
	-- ["Ride east back to the {area:497}."] = "Retournez à l'est jusqu'au {area:497}.",
	-- ["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Partez vers l'est depuis le {area:378} par la route qui entre dans le marais. {area:403}, incendiée, se dresse au bord de la route juste après la frontière ; le bouclier, l'insigne et les empreintes de sabots sont dans la ruine et à côté.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Partez à l'est jusqu'à {area:602}. Utilisez le Rod of Banishing près de chaque portail démoniaque pour en fermer six.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "Partez au nord du convent jusqu'à {npc:5412}, au {area:597}.",
	-- ["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Partez au nord jusqu'à la {area:502}. Ignatz se tient au pied de la colline ; escortez-le pendant qu'il cueille du Trèfle des marais juste au sud.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "Remontez la route vers le nord jusqu'à la hutte au bord de la route, au nord du cimetière.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Partez au nord-est jusqu'à la {area:607}. {npc:12277} est retenue dans le camp des centaures maraudine ; libérez-la et escortez-la hors de la vallée, vers l'est.",
	-- ["Ride on south-west to Shadowprey."] = "Continuez au sud-ouest jusqu'à Proie-de-l'Ombre.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Partez au sud depuis {area:2405} jusqu'à la {area:607}. Les Eclaireurs, Querelleurs, Marteleurs, Chasse-vent et Maraudeurs maraudine (36-39) laissent tomber {quest:93225}.",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Retraversez le marais vers l'ouest. Les Crache-venin Sombrecroc des crêtes au nord de Mur-de-Fougères laissent tomber les poches de venin. Des Infiltrateurs de Theramore (35-36) rôdent dans les mêmes bois : ils sont camouflés, regardez bien.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Partez à l'ouest jusqu'à la tour de {npc:11863} à {area:2405}, sur la côte nord-ouest.",
	-- ["Slitherblade coast"] = "Côte des Ondulame",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "La Lame ardente tient la forteresse au nord-ouest de la {area:2407}. Utilisez {item:14523} sur {npc:11876} dans la forteresse pour obtenir {item:13542}.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Les araignées de Sombrebrume grouillent à l'entrée de la caverne au nord-ouest de Mur-de-Fougères ; toutes laissent tomber des yeux.",
	-- ["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Les murlocs Aileron boueux peuplent la côte à l'est et au nord-est de la {area:502} ; tous laissent tomber des têtes.",
	-- ["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "Le Voyant se tient du côté sud de {area:599}, à l'est de {area:2405}. Éliminez d'abord les sectateurs autour.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Les Nagas Ondulame tiennent la côte au nord de {area:2405}, jusqu'à la {area:598}. {npc:12369} garde {quest:6027} tout au bout de la pointe nord.",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "La caravane s'arrête au camp de {npc:11596}, du côté est du {area:596}.",
	-- ["The next guide takes you back to {zone:1434}."] = "Le guide suivant vous ramène à {zone:1434}.",
	-- ["The {area:2657}"] = "{area:2657}",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and head west through {zone:1412}), then on to {area:496}."] = "Votre maître est aux {area:1638} : volez-y (pas encore de trajet aérien ? volez jusqu'au {area:378} et allez vers l'ouest à travers {zone:1412}), puis jusqu'à {area:496}.",
	-- ["{area:380} flight master"] = "Maître de vol de la {area:380}",
	-- ["{area:392} flight master"] = "Maître de vol de {area:392}",
	-- ["{area:496} flight master"] = "Maître de vol de {area:496}",
	-- ["{area:496}: kill these as you meet them"] = "{area:496} : tuez-les au passage",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "La caravane de {npc:11626} s'arrête sur la route en bordure de {area:602}. Escortez-la vers l'est au-delà du convent ; des démons l'attaquent deux fois.",
	-- ["{npc:4501}, below ground"] = "{npc:4501}, sous terre",
	-- ["{npc:4711} walks around {area:598}: look inside the circle on the map"] = "{npc:4711} se promène autour de {area:598} : cherchez dans le cercle sur la carte",
	-- ["{npc:4714} walks around {area:598}: look inside the circle on the map"] = "{npc:4714} se promène autour de {area:598} : cherchez dans le cercle sur la carte",
	-- ["{npc:4834} along the way to {area:496}"] = "{npc:4834} sur le chemin de {area:496}",
	-- ["{npc:4834} on the way"] = "{npc:4834} en chemin",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} attend dans {area:2302}, à l'est du village. Suivez-le jusqu'à Reethe et gardez-le en vie pendant le combat qui éclate.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of Smeed's camp."] = "{npc:5395} et {npc:5412} se tiennent dans le poste juste à l'ouest du camp de Smeed.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} et {npc:5412} se tiennent dans le poste juste à l'ouest du camp de {npc:11596}.",
	-- ["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} attend au camp gobelin, du côté ouest du {area:596}.",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}, pour « Swamp Eye » Jarl",
}
