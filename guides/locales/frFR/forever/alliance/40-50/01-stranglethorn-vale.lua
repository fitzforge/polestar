-- French (frFR): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "Theramore",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} se tient près de l'auberge ; {npc:4897}, une marchande à quelques pas au sud, vend les épices que veut Jarl.",
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "{quest:1260}, à l'intérieur",
	-- {npc:4964} Commander Samaul · {area:514} Foothold Citadel
	["{npc:4964}, on the top floor of {area:514}"] = "{npc:4964}, au dernier étage de {area:514}",
	-- {npc:271167} Guard Jameson · {quest:98233} Sword in the Slime
	["{npc:271167}: {quest:98233}, from the oozes on the way back east"] = "{npc:271167} : {quest:98233}, sur les limons en revenant vers l'est",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, pour « Œil-des-marais » Jarl",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point · {npc:4967} Archmage Tervosh
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it.\n{npc:4967} waits at the foot of the tower: once you have looked around, hand the quest in to him there, not in Theramore."] = "Suivez la route vers le nord-ouest en sortant de Theramore jusqu'à la tour de guet de {area:503}. Des Creuseuses Rochefange parcourent le marais alentour.\n{npc:4967} attend au pied de la tour : une fois que vous avez regardé autour, rendez-lui la quête sur place, pas à Theramore.",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the tower"] = "{npc:4967}, à la tour",

	-- Step 3: Swamplight Manor
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house. Jarl wants three {quest:1218}: if you passed {npc:4897}, buy them from her in Theramore first."] = "Prenez la route vers le nord jusqu'au manoir en ruine ; Jarl vit dans la cabane voisine et la terre meuble se trouve à l'angle de la maison. Jarl veut trois {quest:1218} : si vous êtes passé chez {npc:4897}, achetez-les-lui d'abord à Theramore.",
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["{quest:1218}: {npc:4897} in Theramore, if you left without them"] = "{quest:1218} : {npc:4897} à Theramore, si vous êtes parti sans elles",
	["with the spices from Theramore"] = "avec les épices de Theramore",

	-- Step 4: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "Ignatz \"Puant\"",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Puant attend à l'ouest du manoir, dans le marais sous {area:504}. Menez-le à ses feuilles de fève des marais et tenez les créatures du marais à l'écart.",

	-- Step 5: North Point Tower
	-- {npc:4966} Private Hendel · {npc:4967} Archmage Tervosh · {npc:4968} Lady Jaina Proudmoore
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders.\n{npc:4967} and {npc:4968} wait beside the tower: once he yields, hand in to both on the spot."] = "{npc:4966} tient la tour avec quelques déserteurs. Il se retourne contre vous : battez-le jusqu'à ce qu'il se rende.\nAttention : Hendel a deux gardes qui se joignent au combat quand il devient hostile. Les gardes s'enfuient dès qu'il se rend.\n{npc:4967} et {npc:4968} attendent à côté de la tour : une fois qu'il s'est rendu, rendez les quêtes aux deux sur place.",

	-- Step 6: Darkmist Cavern
	-- plural, as words: Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Les araignées Sombrebrume nichent autour de la caverne au nord-ouest du marais ; toutes lâchent des yeux.\nAttention : les Rôdeuses de Sombrebrume se déplacent camouflées et empoisonnent une fois en combat. Les araignées se tiennent près les unes des autres, les renforts sont donc fréquents ; attirer des cibles isolées depuis la bordure les limite.",

	-- Step 7: Mudcrush Durtfeet
	["Head south to the giant's hut in the middle of the marsh."] = "Dirigez-vous vers le sud jusqu'à la hutte du géant au milieu du marais.",

	-- Step 8: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes."] = "L'auberge incendiée se trouve sur la route vers l'ouest, en direction de {zone:1413} ; l'insigne du garde est dans les cendres.",

	-- Step 9: Corrosive Swamp Oozes
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze
	["Corrosive Swamp Oozes"] = "Limons des marais corrosifs",
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze · Elder Daggermaws = {npc:272384} Elder Daggermaw · Bubbling Swamp Oozes = {npc:4394} Bubbling Swamp Ooze
	["On the way back east, the Corrosive Swamp Oozes (38-40) creep through the marsh south of the road, between the middle of the marsh and Theramore: one of them carries Jameson's training sword. Careful: Elder Daggermaws (48-49) lurk in the water among them, and the larger Bubbling Swamp Oozes (39-40) are elite: leave both alone."] = "En revenant vers l'est, les Limons des marais corrosifs (38-40) rampent dans le marais au sud de la route, entre le milieu du marais et Theramore : l'un d'eux porte l'épée d'entraînement de Jameson. Attention : des Anciens Gueule-dague (48-49) rôdent dans l'eau parmi eux, et les Limons des marais bouillonnants (39-40), plus gros, sont élites : évitez les deux.",

	-- Step 10: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. The officers are in {area:514}."] = "Suivez la route vers l'est pour revenir à Theramore. Les officiers sont à {area:514}.",
	["On the top floor"] = "Au dernier étage",
	-- {npc:4948} Adjutant Tesoran
	["{npc:4948}, on the top floor"] = "{npc:4948}, au dernier étage",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, à l'intérieur",
	-- {npc:4794} Morgan Stern · {zone:1435} Swamp of Sorrows
	["{npc:4794}: the crawlers are on the {zone:1435} shore, keep it"] = "{npc:4794} : les rampants sont sur la rive du {zone:1435}, gardez-la",

	-- Step 11: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs Aileron boueux",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}."] = "Les murlocs Aileron boueux se pressent sur la côte nord après {area:497}.",

	-- Step 12: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "seulement si vous avez une {item:3853} (fabriquée par un forgeron)",

	-- Step 14: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "Les déserteurs campent au sud de la route, à l'ouest de la hutte de {npc:4503}.",

	-- Step 16: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the way north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "En remontant vers {area:392}, {area:720} se trouve au large de {area:391}, au sud de la ville : traversez à gué les hauts-fonds du banc de sable. {npc:6236} vous envoie quatre adversaires puis {npc:6238} (niveau 33), un à la fois.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Vainquez les adversaires et {npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236} propose ensuite La Vigie des vents (1791) : la suite de l'arme Tourbillon, avec un élite à la fin, se trouve dans le guide de classe Guerrier Arme Tourbillon.",

	-- Step 17: Foothold Citadel
	-- {npc:4944} Captain Garran Vimes · {area:514} Foothold Citadel
	["The boat leaves from Theramore: report to {npc:4944} on the top floor of {area:514} on the way to the docks."] = "Le bateau part de Theramore : présentez-vous à {npc:4944} au dernier étage de {area:514} en allant vers les quais.",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}, au dernier étage",

	-- Step 18: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 19: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Prendre un vol pour {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maître de vol du {area:150}",

	-- Step 21: Riding at 40
	["Riding at 40"] = "Monte au niveau 40",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Au niveau 40, avec 100 po, vous pouvez apprendre à monter, et l'apprendre vous donne une monture. {npc:4732} l'enseigne aux humains à {area:88}, dans l'est de {zone:1429}, à côté des chevaux de {npc:384}. Forever permet peut-être à toutes les races d'apprendre auprès de n'importe quel maître de monte (non confirmé). Collection, Montures · Niveau 40 liste toutes les couleurs.",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384} : autres couleurs, 20 po",

	-- Step 22: Riding at 40
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:279} Dalaran
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. Skyborne learn it from {npc:265756}, the stablemaster and riding trainer at the {area:17684} in {area:16638} on Zephras Isle, who also sells the Galestriders: the skyboat to the isle leaves the north side of {area:279} about every five minutes. Collectibles, Mounts · Level 40 lists the Galestriders."] = "Au niveau 40, avec 100 pièces d'or, vous pouvez apprendre la monte, ce qui vous donne une monture. Les Éolides l'apprennent auprès de {npc:265756}, maître des écuries et maître de monte aux {area:17684} à {area:16638}, sur l'île de Zéphras, qui vend aussi les Trotteurs des trombes : l'aéronef pour l'île part du côté nord de {area:279} toutes les cinq minutes environ. Objets de collection, Montures · Niveau 40 liste les Trotteurs des trombes.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Monte et Trotteurs des trombes : {npc:265756}, aux {area:17684} à {area:16638}, sur l'île de Zéphras.",
	-- {area:279} Dalaran
	["Skyboat to Zephras Isle: the north side of {area:279}, about every five minutes."] = "Aéronef pour l'île de Zéphras : côté nord de {area:279}, toutes les cinq minutes environ.",

	-- Step 23: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Bateau pour {area:35}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {area:35} Booty Bay
	["Head north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "Dirigez-vous vers le nord-ouest dans {zone:1413} et remontez la côte jusqu'à {area:392} : le bateau pour {area:35} part de son quai, et le maître des griffons de {area:392} se tient juste au-dessus.",

	-- Step 24: Boat to Booty Bay
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["Level 40 with 100 gold later on? {npc:4732} teaches riding at {area:88} in {zone:1429}: Collectibles, Mounts · Level 40 has the trip."] = "Niveau 40 avec 100 pièces d'or plus tard ? {npc:4732} enseigne la monte au {area:88}, dans {zone:1429} : Collections, Montures · Niveau 40 contient le trajet.",

	-- Step 26: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "Maître de vol de {area:42}",

	-- Step 27: Booty Bay
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, à l'étage",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "pour {npc:770} à {area:99}, lors de la boucle nord",
	-- {npc:2494} Privateer Bloads · {area:35} Booty Bay
	["{npc:2494}: keep it, its naga (43-44) wait for the level-48 {area:35} stop"] = "{npc:2494} : gardez-la, ses nagas (43-44) attendent le passage à {area:35} au niveau 48",
	-- {npc:2487} Fleet Master Seahorn · {quest:669} Sunken Treasure · {area:327} Faldir's Cove
	["{npc:2487}, top floor: {quest:669}, if you did {area:327} with a group"] = "{npc:2487}, dernier étage : {quest:669}, si vous avez fait {area:327} en groupe",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the Skullsplitter trolls, on the northern loop"] = "{npc:737}, à l'étage : les trolls Fendcrâne, sur la boucle nord",
	-- {npc:2498} Crank Fizzlebub · {area:35} Booty Bay
	["{npc:2498}, inside: keep it, Zanzil's village (43-44) waits for the level-48 {area:35} stop"] = "{npc:2498}, à l'intérieur : gardez-la, le village de Zanzil (43-44) attend le passage à {area:35} au niveau 48",
	["Seahorn's next errand goes back to Arathi: skip it."] = "La course suivante de Seahorn ramène en Arathi : passez-la.",
	-- {npc:2542} Catelyn the Blade
	["{npc:2542}, upstairs"] = "{npc:2542}, à l'étage",
	["Upstairs"] = "À l'étage",

	-- Step 28: Bloodsail camp
	["Bloodsail camp"] = "Camp de la Voile sanglante",
	-- plural, as words: Bloodsail Mages = {npc:1562} Bloodsail Mage
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks.\nCareful: the Bloodsail Mages and Warlocks here are level 40-43 and cast from range: pull one at a time and fight with your back to the open beach."] = "Quittez la ville par le tunnel et suivez la côte vers le nord ; la lettre se trouve dans le camp de la Voile sanglante sur la plage, où se promène Duncan \"le Beau garçon\".\nAttention : les Mages et les Démonistes de la Voile sanglante sont ici de niveau 40-43 et lancent leurs sorts à distance : attirez-les un par un et combattez dos à la plage dégagée.",

	-- Step 29: Booty Bay
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["keep it: the {area:43} camp's charts and Swashbucklers (41-43) wait for the level-48 {area:35} stop"] = "gardez-la : les cartes du camp de {area:43} et les Bretteurs (41-43) attendent l'arrêt à {area:35} au niveau 48",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}, au dernier étage",
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} nage au large de la côte nord-ouest, lors de la boucle nord",

	-- Step 30: Bloodsail pirates: kill these as you meet them
	["Bloodsail pirates: kill these as you meet them"] = "Pirates de la Voile sanglante : tuez-les au passage",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye: take them from the Raiders and Mages (39-41) at the Bloodsail camp on the beach just north of town, where you found the letter. Leave the {area:43} camp south of town (Warlocks and Swashbucklers 41-43) for the level-48 visit."] = "Chaque pirate de la Voile sanglante lâche du tabac à priser et l'un d'eux porte l'œil de {npc:2493} : prenez-les sur les Écumeurs et les Mages (39-41) du camp de la Voile sanglante, sur la plage juste au nord de la ville, là où vous avez trouvé la lettre. Laissez le camp de {area:43} au sud de la ville (Démonistes et Bretteurs 41-43) pour la visite au niveau 48.",

	-- Step 31: Booty Bay
	-- {npc:2486} Fin Fizracket · {npc:1514} Mokk the Savage · {area:35} Booty Bay
	["{npc:2486}'s Stranglethorn Fever ({npc:1514}) waits for the level-48 {area:35} stop: leave it for now."] = "La Fièvre de Strangleronce de {npc:2486} ({npc:1514}) attend l'arrêt à {area:35} au niveau 48 : laissez-la pour l'instant.",
	-- {area:35} Booty Bay · {area:43} Wild Shore
	["Seahorn's Bloodsail Buccaneers: keep it for the level-48 {area:35} stop, with the {area:43} camp."] = "Les Boucaniers de la Voile sanglante de Seahorn : gardez-la pour l'arrêt à {area:35} au niveau 48, avec le camp de {area:43}.",

	-- Step 32: Booty Bay
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Vous avez manqué ceci lors du passage précédent de l'itinéraire ici : cela passe d'abord maintenant. C'est rapide et cela ouvre les quêtes qui suivent.",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",

	-- Step 33: Gorilla hills
	["Gorilla hills"] = "Collines des gorilles",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Head inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets."] = "Dirigez-vous vers l'intérieur jusqu'aux collines des gorilles de Valbrume. Les Anciens gorilles de Valbrume lâchent les abats.",

	-- Step 34: Booty Bay
	["Head back down to town; Shaky stands at the tunnel mouth."] = "Redescendez en ville ; Phillippe le Chancelant se tient à l'entrée du tunnel.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it; on the top floor"] = "pour Stoley à {zone:1446} : gardez-le ; au dernier étage",
	-- {area:35} Booty Bay
	["\"Sea Wolf\" MacKinley: keep it, for the level-48 {area:35} stop, with Zanzil's village"] = "\"Loup de mer\" MacKinley : gardez-la pour l'arrêt à {area:35} au niveau 48, avec le village de Zanzil",

	-- Step 35: Cortello's scroll
	["Cortello's scroll"] = "Le parchemin de Cortello",
	-- {area:35} Booty Bay
	["Optional: Cortello's scroll lies inside one of the three Bloodsail ships anchored off the coast just south of {area:35}, on a middle or lower deck, and is not always on the same ship. Their crews are 42-45 pirates: clear your way from the edge, one at a time, and leave the captains (45-48), whom the route comes back for at 48."] = "Facultatif : le parchemin de Cortello se trouve dans l'un des trois navires de la Voile sanglante ancrés au large, juste au sud de {area:35}, sur un pont intermédiaire ou inférieur, et pas toujours sur le même navire. Leurs équipages sont des pirates de niveau 42-45 : frayez-vous un chemin depuis le bord, un à la fois, et laissez les capitaines (45-48), pour lesquels l'itinéraire revient au niveau 48.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "pour {zone:1435}, plus tard",

	-- Step 36: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Traqueurs de la jungle",
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers roam the slopes west of the mine."] = "Les Traqueurs de la jungle parcourent les pentes à l'ouest de la mine.",

	-- Step 37: Zul'Mamwe's Mystics and the Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Zul'Mamwe's Mystics and the Shadowmaw Panthers"] = "Les Mystiques de Zul'Mamwe et les Panthères Ombregueule",
	-- {npc:739} Brother Nimetz
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["East from the stalkers' slopes to the ruins of Zul'Mamwe: the Skullsplitter Mystics (39-40) in its northern half carry {npc:739}'s fetishes. Careful: the Witch Doctors, Berserkers and Headhunters (41-44) hold the ruins' southern half: stay north. Then north-west toward the coast: the Shadowmaw Panthers (37-38) prowl the jungle west of the ruins, often stealthed."] = "À l'est des pentes des traqueurs jusqu'aux ruines de Zul'Mamwe : les Mystiques Skullsplitter (39-40) de la moitié nord portent les fétiches de {npc:739}. Attention : les Sorciers-docteurs, Berserkers et Chasseurs de têtes (41-44) tiennent la moitié sud des ruines : restez au nord. Puis vers le nord-ouest en direction de la côte : les Panthères Ombregueule (37-38) rôdent dans la jungle à l'ouest des ruines, souvent camouflées.",
	-- {item:2466} Skullsplitter Fetish
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic
	["{item:2466}, from the Skullsplitter Mystics"] = "{item:2466}, sur les Mystiques Skullsplitter",

	-- Step 38: The north-west coast
	["The north-west coast"] = "La côte nord-ouest",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Go on north-west to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Continuez vers le nord-ouest jusqu'à la baie de la côte nord-ouest. Les Palourdes géantes reposent au fond et contiennent les perles ; {npc:2624} nage parmi elles et lâche la {item:4034}.",
	-- {item:4611} Blue Pearl
	["{item:4611}; underwater"] = "{item:4611} ; sous l'eau",

	-- Step 39: Sin'Dall
	-- {npc:729} Sin'Dall
	["North-east from the bay toward Nesingwary's camp: {npc:729}, the great tiger (37), lairs on the hilltop just south-west of the camp."] = "Au nord-est de la baie, vers le camp de Nesingwary : {npc:729}, le grand tigre (37), a son repaire au sommet de la colline juste au sud-ouest du camp.",

	-- Step 40: Hemet Nesingwary
	-- {npc:718} Sir S. J. Erlgadin
	["{npc:718}, beside him"] = "{npc:718}, à côté de lui",
	-- {npc:717} Ajeck Rouack
	["{npc:717}, beside them"] = "{npc:717}, à côté d'eux",

	-- Step 43: Arbor Tarantula
	-- {npc:217588} Arbor Tarantula · {area:99} Rebel Camp · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Une {npc:217588} rampe dans la jungle au sud-est du camp de Nesingwary, sur le chemin vers {area:99} : attrapez-en une avec l'outil du {item:213565} de {npc:217412}.",

	-- Step 44: Rebel Camp
	["Head north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "Dirigez-vous vers le nord-est en passant le camp de Nesingwary et suivez la route vers le nord jusqu'au camp en haut de la vallée.",

	-- Step 45: Brother Nimetz
	-- {npc:739} Brother Nimetz · {area:301} Savage Coast · {npc:2277} Loremaster Dibbs · {area:271} Southshore · {zone:1418} Badlands · {zone:1425} Hinterlands
	["{npc:739}: the {area:301} report bundle for {npc:2277} in {area:271}, on the {zone:1418} & {zone:1425} guide: keep it"] = "{npc:739} : le paquet de rapports de la {area:301} pour {npc:2277} à {area:271}, sur le guide {zone:1418} et {zone:1425} : gardez-la",

	-- Step 46: Kurzen's Compound
	-- {area:99} Rebel Camp · {area:101} Kurzen's Compound · {npc:218230} Wendel Mathers · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Subchiefs = {npc:978} Kurzen Subchief
	["East from the {area:99} to {area:101}: {npc:218230} is caged at its western edge. The Kurzen Subchiefs (35-36) and Elites (36-37) carry his cage key; the fighter's uniform lies in a supply crate in the compound's eastern part.\nCareful: {npc:813}, an elite of 39-40, stands at the compound's north end beside three of the Subchiefs: take the key from the Subchiefs and Elites further south and leave him be."] = "À l'est du {area:99} jusqu'à {area:101} : {npc:218230} est en cage à sa bordure ouest. Les Lieutenants de Kurzen (35-36) et les Élites (36-37) portent la clé de sa cage ; l'uniforme de combattant se trouve dans une caisse de ravitaillement dans la partie est de la base.\nAttention : {npc:813}, un élite de niveau 39-40, se tient à l'extrémité nord de la base à côté de trois Lieutenants : prenez la clé sur les Lieutenants et les Élites plus au sud et laissez-le tranquille.",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage, if you didn't take it on the 30-40 loop"] = "{npc:218230}, dans sa cage, si vous ne l'avez pas prise pendant la boucle 30-40",
	-- {item:216616} Compound Cage Key
	["{item:216616}, from the Subchiefs (or the Elites)"] = "{item:216616}, sur les Lieutenants (ou les Élites)",
	-- {item:216617} Kurzen Fighter's Uniform
	["{item:216617}, in the supply crate"] = "{item:216617}, dans la caisse de ravitaillement",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, back at his cage on the way out"] = "{npc:218230}, de retour à sa cage en sortant",
	-- {npc:218229} Captain Aransas · {area:35} Booty Bay
	["For {npc:218229} in {area:35}, at the end of the jungle loop"] = "Pour {npc:218229} à {area:35}, à la fin de la boucle dans la jungle",

	-- Step 47: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:728} est un élite de niveau 40 : la plupart des classes le battent seules au niveau 42, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 48: Ruins of Zul'Mamwe: kill these as you meet them
	-- {area:103} Ruins of Zul'Mamwe
	["{area:103}: kill these as you meet them"] = "{area:103} : tuez-les au passage",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do.\nFollow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Les trolls Fendcrâne tiennent les ruines juste à l'est de la mine ; n'importe lequel peut lâcher des défenses, leurs panthères en lâchent toujours.\nSuivez la route vers le nord-est jusqu'au camp de la KapitalRisk à la {area:310} ; les mineurs, les géomètres et les contremaîtres lâchent les cristaux.\nAttention : des Panthères Ombregueule camouflées et des Tigresses de Strangleronce rôdent autour du camp.",
	-- {item:1524} Skullsplitter Tusk
	["{item:1524}, from the trolls of the ruins"] = "",

	-- Step 49: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:730} est un élite de niveau 43 : la plupart des classes le battent seules au niveau 45, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 53: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:731} est un élite de niveau 43 : la plupart des classes le battent seules au niveau 45, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.\nAttention : des tigres et des panthères Ombregueule camouflées rôdent près de lui. Éliminez-les avant de l'attirer. Quand vous l'attirez, {npc:731} appelle à l'aide les créatures dans un rayon de 20 m.",

	-- Step 55: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road south to {area:35}."] = "Suivez la route vers le sud jusqu'à {area:35}.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, à l'étage",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773} : pour {quest:2864} en {zone:1446}, gardez-la",

	-- Step 56: Fly to Stormwind
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 57: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} cuisine au {object:2169} ; {npc:5384} est dans {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {npc:5464} Watchmaster Sorigal · {area:42} Darkshire
	["{npc:5694}: for {npc:5464} in {area:42}, on the way to the swamp"] = "{npc:5694} : pour {npc:5464} à {area:42}, sur le chemin du marais",

	-- Step 58: Stormwind
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}, la bibliothèque royale de {object:2117}",

	-- Step 60: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Paladin : {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}, dans la cathédrale de la Lumière",

	-- Step 61: Stormwind City
	["Stormwind City"] = "Cité de Hurlevent",

	-- Step 62: Warlock: Summon Felsteed
	-- {quest:4488} Summon Felsteed
	["Warlock: {quest:4488}"] = "Démoniste : {quest:4488}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}, à {object:2164} : {npc:6251} à {area:392} la prend à la fin du guide suivant",

	-- Step 64: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- Step 67: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "Au niveau 40, avec 100 po, vous pouvez apprendre à monter, et l'apprendre vous donne une monture. {npc:4753} l'enseigne aux elfes de la nuit à {zone:1457}, à côté des sabres de {npc:4730} : le bateau de {area:17203} pour {area:442}, puis le vol pour {area:702}. Forever permet peut-être à toutes les races d'apprendre auprès de n'importe quel maître de monte (non confirmé), comme {npc:4732} à {area:88}, dans {zone:1429}. Collection, Montures · Niveau 40 liste toutes les couleurs.",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730} : autres couleurs, 20 po",

	-- Step 69: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maître de vol du {area:702}",

	-- Step 70: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Bateau pour {area:17203}",

	-- Step 71: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Prendre un vol pour {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 72: Darkshire
	-- {npc:5464} Watchmaster Sorigal
	["{npc:5464}, by the flight master"] = "{npc:5464}, près du maître de vol",

	-- Step 74: Misty Valley
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "Le parchemin se trouve dans le marais au nord de Biggs. Les Maraistreurs au nord peuvent laisser tomber les essais de Khadgar.",

	-- Step 76: Cortello's Riddle
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412} : {quest:93176}, depuis 30-40/05-arathi-highlands",

	-- Step 77: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["{npc:5476} stands by the road junction in the west of the swamp."] = "{npc:5476} se tient près du carrefour à l'ouest du marais.",

	-- Step 78: The sunken temple
	["The sunken temple"] = "Le temple englouti",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Head east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Allez vers l'est ; les Horreurs enchevêtrées en chemin laissent aussi tomber les essais. Fouillez le bord de {area:74}, là où les ruines du temple émergent de l'eau.",

	-- Step 79: Misty Reed Strand
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler · Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Silt Crawlers (40-41) crowd the north end of the eastern shore, and the driftwood washes up along it from there.\nCareful: the big Monstrous Crawlers (43-44) further south on the shore are over you: take the legs at the north end and pick up the driftwood without pulling them."] = "Les Clampants des vases (40-41) se pressent au nord de la rive est, et le bois flotté s'échoue le long de la rive à partir de là.\nAttention : les gros Clampants monstrueux (43-44) plus au sud sur la rive sont trop forts pour vous : prenez les pattes au nord et ramassez le bois flotté sans les attirer.",
	-- {item:5938} Pristine Crawler Leg
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler
	["{item:5938}, from the Silt Crawlers"] = "{item:5938}, sur les Clampants des vases",

	-- Step 80: Watcher Biggs
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "pour {area:1438} : gardez-la",

	-- Step 83: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "pour {npc:5635} à {area:348} : gardez-la",

	-- Step 84: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 87: Ironforge
	-- {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["{npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:2786} in the {object:32383}."] = "{npc:5637} se trouve dans la salle des Récupérateurs près de {object:32356}, {npc:2786} dans {object:32383}.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} n'a pas de maître des chamans",

	-- Step 89: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Au niveau 40, avec 100 po, vous pouvez apprendre à monter, et l'apprendre vous donne une monture. {npc:4772} l'enseigne aux nains à {area:803}, à l'est de {area:131} sur la route du {zone:1432}, à côté des béliers de {npc:1261}. Forever permet peut-être à toutes les races d'apprendre auprès de n'importe quel maître de monte (non confirmé). Collection, Montures · Niveau 40 liste toutes les couleurs.",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261} : autres couleurs, 20 po",

	-- Step 91: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Au niveau 40, avec 100 po, vous pouvez apprendre à monter, et l'apprendre vous donne une monture. {npc:7954} l'enseigne aux gnomes à {area:189}, juste à l'est de {area:131}, à côté des mécanotrotteurs de {npc:7955}. Forever permet peut-être à toutes les races d'apprendre auprès de n'importe quel maître de monte (non confirmé). Collection, Montures · Niveau 40 liste toutes les couleurs.",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955} : autres couleurs, 20 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alone, you skip Nesingwary's three elite hunts: take their experience from the Skullsplitter trolls of Zul'Mamwe instead, just east of the mine, so every kill also counts for {npc:737}'s tusks. Or, with a group, run the {area:1517} dungeon instead."] = "Seul, vous passez les trois chasses d'élites de Nesingwary : prenez plutôt leur expérience sur les trolls Fendcrâne de Zul'Mamwe, juste à l'est de la mine, pour que chaque victime compte aussi pour les défenses de {npc:737}. Ou, en groupe, faites plutôt le donjon {area:1517}.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "Au niveau 40, avec 100 pièces d'or, vous pouvez apprendre la monte, et l'apprendre vous donne une monture. Aucun maître de monte céleste n'est connu ; le client Forever range {spell:1285849} sous la seule compétence de monte, donc {npc:4732} à {area:88}, dans l'est de {zone:1429}, le maître le plus proche de {zone:1453}, devrait l'enseigner (non confirmé). Les trotteurs des trombes sont vendus par {npc:265756} à {area:16638}, sur l'Île de Zéphras ; Collections, Montures · Niveau 40 les liste.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {area:12}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Au niveau 40, avec 100 pièces d'or, vous pouvez apprendre la monte, ce qui vous donne une monture. {npc:4732} l'enseigne aux Humains au {area:88}, dans l'est de la {area:12}, à côté des chevaux de {npc:384}. Forever permet peut-être à toutes les races d'apprendre auprès de n'importe quel maître de monte (non confirmé). Objets de collection, Montures · Niveau 40 liste toutes les couleurs.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {area:12}. Collectibles, Mounts · Level 40 lists every colour."] = "Au niveau 40, avec 100 pièces d'or, vous pouvez apprendre la monte, ce qui vous donne une monture. {npc:4753} l'enseigne aux Elfes de la nuit à {zone:1457}, à côté des sabres de {npc:4730} : le bateau du {area:17203} pour {area:442}, puis le vol pour le {area:702}. Forever permet peut-être à toutes les races d'apprendre auprès de n'importe quel maître de monte (non confirmé), comme {npc:4732} au {area:88}, dans la {area:12}. Objets de collection, Montures · Niveau 40 liste toutes les couleurs.",
	-- ["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "De retour à Theramore : Tervosh attend avec Dame Jaina dans la tour de {area:514}.",
	-- ["Bloodsail pirates"] = "Pirates de la Voile sanglante",
	-- ["Cold Eye Basilisks"] = "Basilics Oeil-de-glace",
	-- ["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}.\nCareful: the {area:43} camp's Warlocks and Swashbucklers are level 41-43, a level or more above you, and stand close together: pull them singly from the edge."] = "Tous les pirates de la Voile sanglante laissent tomber du Tabac à priser et l'un d'eux porte l'œil de {npc:2493} ; les Bretteurs arpentent le rivage juste au nord de la ville. Les cartes et les ordres se trouvent dans le camp pirate de {area:43}, au sud de {area:35}.\nAttention : les Démonistes et les Bretteurs du camp de {area:43} sont de niveau 41-43, au moins un niveau au-dessus de vous, et se tiennent serrés : attirez-les un par un depuis le bord.",
	-- ["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Tout disciple de Zanzil peut laisser tomber le mélange ; {npc:2537} arpente le sud du camp.",
	-- ["Fly to {area:144}"] = "Prendre un vol pour {area:144}",
	-- ["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- ["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Prenez un vol pour {area:42} et chevauchez vers l'est à travers {zone:1430} jusqu'à {zone:1435} ; {npc:5476} se tient au bord de la route juste après la frontière.",
	-- ["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Suivez la route vers l'est pour revenir à Theramore. Tervosh, Dame Jaina et les officiers sont dans la tour et à {area:514}.",
	-- ["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Suivez la route vers le nord-est jusqu'au camp de la KapitalRisk de {area:310} ; les mineurs, géomètres et contremaîtres laissent tomber les cristaux.",
	-- ["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Suivez la route vers le nord-ouest en sortant de Theramore jusqu'à la tour de guet de {area:503}. Des Creuseuses Rochefange parcourent le marais alentour.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Trotteurs des trombes : {npc:265756}, à {area:16638} sur l'Île de Zéphras.",
	-- ["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Rendez les crocs et restez : trois vagues de gorilles arrivent, {npc:1514} en dernier. Combattez avec toute votre vie.",
	-- ["Hearth to {area:35}"] = "Pierre de foyer vers {area:35}",
	-- ["Hearth to {area:513}"] = "Pierre de foyer vers {area:513}",
	-- ["If you skipped {quest:193}, grind here to level 42.23 to stay on the route's plan."] = "Si vous avez passé {quest:193}, tuez des monstres ici jusqu'au niveau 42.23 pour suivre le plan de l'itinéraire.",
	-- ["If you skipped {quest:196}, grind here to level 42.27 to stay on the route's plan."] = "Si vous avez passé {quest:196}, tuez des monstres ici jusqu'au niveau 42.27 pour suivre le plan de l'itinéraire.",
	-- ["If you skipped {quest:208}, grind here to level 42.33 to stay on the route's plan."] = "Si vous avez passé {quest:208}, tuez des monstres ici jusqu'au niveau 42.33 pour suivre le plan de l'itinéraire.",
	-- ["If you skipped {quest:543}, grind here to level 42.46 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Si vous avez passé {quest:543}, tuez des monstres ici jusqu'au niveau 42.46 pour suivre le plan de l'itinéraire. Ou, en groupe, faites plutôt le donjon {area:1517}.",
	-- ["Inside"] = "À l'intérieur",
	-- ["Into {area:10}"] = "Vers le {area:10}",
	-- ["Into {area:12}"] = "Vers la {area:12}",
	-- ["Into {area:8}"] = "Vers le {area:8}",
	-- ["Into {zone:1430}"] = "Vers le {zone:1430}",
	-- ["Into {zone:1453}"] = "Vers {zone:1453}",
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Klannoc propose ensuite La Vigie des vents (1791) : la suite de l'arme {spell:1680}, avec un élite à la fin, est dans le guide de classe Guerrier Arme Tourbillon.",
	-- ["Level 42.16"] = "Niveau 42.16",
	-- ["Level 42.16 at Zul'Mamwe"] = "Niveau 42.16 à Zul'Mamwe",
	-- ["Level 42.27"] = "Niveau 42.27",
	-- ["Level 42.33"] = "Niveau 42.33",
	-- ["Level 42.46"] = "Niveau 42.46",
	-- ["MacKinley's next task sends you after elite ogres: skip it."] = "La tâche suivante de MacKinley vous envoie contre des ogres élites : passez-la.",
	-- ["Mudrock tortoises"] = "Tortues Rochefange",
	-- ["Naga Explorers"] = "Explorateurs nagas",
	-- ["No flight path to {area:144} yet: ride out of {zone:1455}'s gates, east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "Pas encore de trajet aérien vers {area:144} : sortez par les portes de {zone:1455}, allez à l'est à travers {zone:1426} et le tunnel jusqu'au {zone:1432}, puis suivez la route jusqu'à {area:144}.",
	-- ["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "En remontant vers {area:392}, {area:720} se trouve au large de {area:391}, au sud de la ville : traversez à gué les hauts-fonds du banc de sable. {npc:6236} vous envoie quatre adversaires puis {npc:6238} (niveau 33), un à la fois.",
	-- ["Ride back down to town; Shaky stands at the tunnel mouth."] = "Redescendez en ville ; Phillippe le Chancelant se tient à l'entrée du tunnel.",
	-- ["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Revenez vers l'ouest le long de la route ; {npc:217412} se tient un peu au nord de Biggs.",
	-- ["Ride east out of {zone:1426} through the tunnel into {zone:1432} and on along the road to {area:144}."] = "Chevauchez vers l'est pour quitter {zone:1426} par le tunnel jusqu'au {zone:1432}, puis suivez la route jusqu'à {area:144}.",
	-- ["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Chevauchez vers l'est ; les Horreurs enchevêtrées en chemin laissent aussi tomber les essais. Fouillez le bord de {area:74}, là où les ruines du temple émergent de l'eau.",
	-- ["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Depuis Theramore, chevauchez vers l'ouest sur la route d'Âprefange jusqu'à {zone:1413}, puis vers le nord jusqu'à {area:392} sur la côte. Apprenez le trajet aérien auprès de {npc:16227}, puis prenez le bateau pour {area:35} au quai.",
	-- ["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Chevauchez vers l'intérieur jusqu'aux collines des gorilles de Valbrume. Les Anciens gorilles de Valbrume laissent tomber les abats ; {npc:1449} est assis parmi eux.",
	-- ["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Chevauchez vers le nord jusqu'aux collines à l'ouest de la route. {npc:2535} et {npc:2536} se tiennent ensemble juste au nord du village de Zanzil.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "Chevauchez vers le nord-est en passant le camp de Nesingwary et suivez la route vers le nord jusqu'au camp en haut de la vallée.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Chevauchez vers le nord-est après le camp de Nesingwary et suivez la route vers le nord jusqu'au camp en haut de la vallée. En chemin, une {npc:217588} rampe dans la jungle au sud-est du camp de Nesingwary : attrapez-en une avec le Kit d’entomologiste novice, puis cochez-la.",
	-- ["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Chevauchez vers le nord-ouest depuis la mine jusqu'à la baie de la côte nord-ouest. Les Palourdes géantes reposent au fond et contiennent les perles ; {npc:2624} nage parmi elles et laisse tomber la {item:4034}.",
	-- ["Ride north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "Chevauchez vers le nord-ouest dans {zone:1413} et remontez la côte jusqu'à {area:392} : le bateau pour {area:35} part de son quai, et le maître des griffons de {area:392} se tient juste au-dessus.",
	-- ["Ride south down the road to {area:35}."] = "Descendez la route vers le sud jusqu'à {area:35}.",
	-- ["Ride south out of {zone:1432} through the pass into the {area:3}; {npc:2860} camps at the dig."] = "Chevauchez vers le sud hors du {zone:1432}, par le col, jusqu'aux {area:3} ; {npc:2860} campe au site de fouilles.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Partez au sud hors du {zone:1432}, par le col, jusqu'aux {zone:1418} ; {npc:2860} campe sur le site de fouilles.",
	-- ["Ride south to the giant's hut in the middle of the marsh."] = "Chevauchez vers le sud jusqu'à la hutte du géant au milieu du marais.",
	-- ["Seahorn now offers {quest:604}: leave it. Its three captains are level 45-48 with crews around them, and the route brings you back to Seahorn at 48 for it."] = "Seahorn propose maintenant {quest:604} : laissez-la. Ses trois capitaines sont de niveau 45-48, entourés de leurs équipages, et l'itinéraire vous ramène auprès de Seahorn au niveau 48 pour elle.",
	-- ["Skullsplitter ruins"] = "Ruines Skullsplitter",
	-- ["Still short of level 42.16 after the hunts you did? Make up the rest on the Cold Eye Basilisks by the {area:310}, on your way south to {area:35}. Or, with a group, run the {area:1517} dungeon instead."] = "Toujours pas au niveau 42.16 après les chasses que vous avez faites ? Complétez sur les basilics Cold Eye près de la {area:310}, en descendant vers le sud jusqu'à {area:35}. Ou, en groupe, faites plutôt le donjon {area:1517}.",
	-- ["The Bloodsail captains"] = "Les capitaines de la Voile sanglante",
	-- ["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "Les araignées de Sombrebrume nichent autour de la caverne, dans le nord-ouest du marais ; chaque araignée laisse tomber des yeux.",
	-- ["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "Les murlocs Aileron boueux se pressent sur la côte nord après {area:497} ; finissez les langues sur les tortues voisines.",
	-- ["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Les Tortues et Épineuses Rochefange se chauffent au soleil sur la rive au nord-est du manoir.",
	-- ["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Les trolls Skullsplitter tiennent les ruines juste à l'est de la mine ; chacun peut laisser tomber des défenses, leurs panthères toujours.",
	-- ["The burned inn stands on the road west, toward the {area:17}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "L'auberge incendiée se trouve sur la route à l'ouest, vers les {area:17} ; l'insigne du garde est dans les cendres et les empreintes de sabots dans la boue à côté de l'auberge.",
	-- ["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "L'auberge incendiée se trouve sur la route vers l'ouest, en direction de {zone:1413} ; l'insigne du garde est dans les cendres et les traces de sabots dans la boue à côté de l'auberge.",
	-- ["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Les capitaines se tiennent sur les navires ancrés au large de {area:43}, chacun avec un équipage de pirates de niveau 42-45 : Stillwater (45) et Keelhaul (46) sur les ponts les plus proches, {npc:2546} (48) sur le vaisseau amiral. Au niveau 42, c'est un combat pour un groupe ou pour la fin du guide ; si vous y allez, nettoyez d'abord chaque pont. La devinette de Cortello se trouve sur l'épave près du rivage.",
	-- ["The driftwood washes up along the eastern shore."] = "Le bois flotté s'échoue le long de la rive est.",
	-- ["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Les nagas fouillent les plages au nord du camp de la Voile sanglante ; ils laissent tomber les roseaux.",
	-- ["The riddle's next scroll lies in western Dustwallow: skip it."] = "Le parchemin suivant de l'énigme se trouve dans l'ouest d'Âprefange : passez-le.",
	-- ["Unbagwa's ritual"] = "Le rituel d'Unbagwa",
	-- ["Warlock: {quest:3631}"] = "Démoniste : {quest:3631}",
	-- ["Zanzil's village"] = "Le village de Zanzil",
	-- ["for Stoley in {zone:1446}: keep it"] = "pour Stoley en {zone:1446} : gardez-la",
	-- ["for the flight back to {npc:6251} at 43"] = "pour le vol de retour vers {npc:6251} au niveau 43",
	-- ["for the {area:8} later"] = "pour le {area:8}, plus tard",
	-- ["for {npc:2616} in Theramore: keep it"] = "pour {npc:2616} à Theramore : gardez-la",
	-- ["grind on {npc:667}"] = "tuez en boucle : {npc:667}",
	-- ["grind on {npc:690}"] = "tuez en boucle : {npc:690}",
	-- ["grind on {npc:766}"] = "tuez en boucle : {npc:766}",
	-- ["{area:108} flight master"] = "Maître de vol de {area:108}",
	-- ["{area:144} flight master"] = "Maître de vol de {area:144}",
	-- ["{area:43}: kill these as you meet them"] = "{area:43} : tuez-les au passage",
	-- ["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, pour Jarl \"Oeil-des-marais\"",
	-- ["{item:3919} on the way"] = "{item:3919} en chemin",
	-- ["{item:5938}, from the Silt Crawlers on the same shore"] = "{item:5938}, sur les Silt Crawlers de la même rive",
	-- ["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356} : pour {npc:1344} au {zone:1432}, gardez-la",
	-- ["{npc:1449}, inside {area:1742}"] = "{npc:1449}, à l'intérieur de {area:1742}",
	-- ["{npc:1470} is below ground in {area:144}, by the inn. His mushrooms grow in the {area:1517} dig in the {zone:1418}; the next guide takes you there and back through {area:144}."] = "{npc:1470} se trouve sous terre à {area:144}, près de l'auberge. Ses champignons poussent sur le site de fouilles d'{area:1517}, dans les {zone:1418} ; le guide suivant vous y emmène puis vous ramène par {area:144}.",
	-- ["{npc:1470}, below ground"] = "{npc:1470}, sous terre",
	-- ["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588} : attrapez-la, pour {quest:93176}",
	-- ["{npc:2487}, top floor"] = "{npc:2487}, dernier étage",
	-- ["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "La course suivante de {npc:2498} concernant Zanzil commence à {zone:1441} : passez-la.",
	-- ["{npc:2535} and {npc:2536}"] = "{npc:2535} et {npc:2536}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} campe seul dans {area:1898}, au sud-est du site de fouilles.",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} tient la tour avec quelques déserteurs. Il se retourne contre vous : battez-le jusqu'à ce qu'il se rende.",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders."] = "{npc:4966} tient la tour avec quelques déserteurs. Il se retourne contre vous : battez-le jusqu'à ce qu'il se rende.\nAttention : Hendel a deux gardes qui se joignent au combat quand il devient hostile. Les gardes s'enfuient dès qu'il se rend.",
	-- ["{npc:4967}, upstairs"] = "{npc:4967}, à l'étage",
	-- ["{npc:4968}, on the top floor"] = "{npc:4968}, au dernier étage",
	-- ["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694} : pour {area:1438}, gardez-la",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236} : Posture berserker",
	-- ["{npc:687} on the way"] = "{npc:687} en chemin",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} est le grand bâtiment qui domine le port ; la plupart des donneurs de quête sont à ses étages ou sur les quais en dessous.",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}, pour « Œil-des-marais » Jarl",
	-- ["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} se tient près de l'auberge ; {npc:4897}, une fournisseuse de métiers quelques pas au sud, vend les épices que veut Jarl.",
	-- ["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706} : son {item:4612} est un butin rare, donc le travail et le rendu sont facultatifs eux aussi",
	-- ["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",
}
