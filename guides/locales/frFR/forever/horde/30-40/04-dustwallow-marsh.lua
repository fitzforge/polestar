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

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar · {zone:1445} Dustwallow Marsh
	["The {zone:1454} and Crossroads stops are on the way for players coming from the previous guide; opened with none of its quests in the log, the guide starts in {zone:1445}."] = "Les arrêts à {zone:1454} et à la Croisée sont sur le chemin des joueurs venant du guide précédent ; ouvert sans aucune de ses quêtes dans le journal, le guide commence en {zone:1445}.",
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "Le centre d'{zone:1454}",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, pour « Œil-des-marais » Jarl",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "{npc:3354}, {object:172958} : pour {area:720}, plus loin dans ce guide (proposée à partir du niveau 30)",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "Vol pour la Croisée",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} se tient à côté du maître de vol de la Croisée.",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "pour {npc:4485} à {zone:1454}, à la fin de ce guide",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Volez jusqu'au {area:378}",
	["Crossroads flight master"] = "Maître de vol de la Croisée",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Allez vers l'est depuis le {area:378} par la route qui entre dans le marais. Les ruines incendiées de {area:403} se dressent au bord, juste après la frontière ; le bouclier, l'insigne et les empreintes de sabots sont dans la ruine et à côté.",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "À l'embranchement, prenez la route du nord jusqu'au village ogre de Mur-de-Fougères.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, à l'entrée sud du village, là où arrive la route",

	-- Step 11: Stinky Ignatz
	["Stinky Ignatz"] = "Ignatz \"Puant\"",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Allez vers le nord jusqu'à {area:502}. Stinky se tient au pied de la colline ; escortez-le pendant qu'il ramasse des feuilles de fève des marais juste au sud.",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs Aileron boueux",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Les murlocs Aileron boueux peuplent la côte à l'est et au nord-est de la {area:502} ; tous laissent tomber des têtes.",

	-- Step 13: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Jarl \"Oeil-des-marais\"",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Jarl vit au {area:497}, au sud-est de la {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, à côté du manoir",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "{quest:1218}, si vous ne les avez pas achetées à {zone:1454}",

	-- Step 14: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "{area:496} : tuez-les au passage",
	-- plural, as words: Darkfang Lurkers = {npc:4411} Darkfang Lurker · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Lurkers (36-37) and Venomspitters (37-38) on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes. Work its outer edge, where the Spiders and Recluses (35-37) stand: the Lurkers and Silkspinners (37-39) deeper in are two or three over you.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Retraversez le marais vers l'ouest. Les Rôdeuses Sombrecroc (36-37) et les Crache-venin (37-38), sur les crêtes au nord de Mur-de-Fougères, lâchent les poches de venin. Les Infiltrateurs de Theramore (35-36) se faufilent dans les mêmes bois : ils sont camouflés, regardez bien.\nLes araignées de Sombrebrume grouillent à l'entrée de la caverne au nord-ouest de Mur-de-Fougères ; toutes lâchent des yeux. Restez sur le bord extérieur, où se trouvent les Araignées et les Recluses (35-37) : les Rôdeuses et les Tisseuses (37-39) plus au fond ont deux ou trois niveaux de plus que vous.\nAttention : les Rôdeuses Sombrecroc (niveau 36-37) se camouflent hors combat et lancent Poison une fois en combat.\nAttention : des araignées camouflées dans la même zone vous attaquent à vue.\nAttention : les Rôdeuses de Sombrebrume se déplacent camouflées et utilisent du poison en combat. Les araignées sont serrées les unes contre les autres, les monstres en plus sont donc fréquents ; attirer des cibles isolées depuis le bord extérieur les limite.",
	-- plural, as words: Giant Darkfang Spiders = {npc:4415} Giant Darkfang Spider
	["Every Darkfang spider drops them: Lurkers, Spiders, Venomspitters and the Giant Darkfang Spiders"] = "Chaque araignée Darkfang les laisse tomber : rôdeurs, araignées, Venomspitters et les araignées Darkfang géantes",

	-- Step 16: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire · {npc:5045} Private Hallan
	-- plural, as words: Theramore Skirmishers = {npc:5044} Theramore Skirmisher
	["On the way east, {npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out: {npc:5045} and Theramore Skirmishers (36) join it."] = "En allant vers l'est, {npc:4983} attend dans {area:2302}, à l'est du village. Suivez-le jusqu'à Reethe et gardez-le en vie pendant le combat qui éclate : le {npc:5045} et des Tirailleurs de Theramore (36) s'y joignent.",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["On east to the {area:497}."] = "Continuez vers l'est jusqu'au {area:497}.",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, maintenant que {npc:4791} a lu le rapport",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "seulement si vous avez une {item:3853} ({skill:164} ou Hôtel des ventes)",

	-- Step 18: The Theramore Docks
	-- {area:513} Theramore Isle · {object:20925} Captain's Footlocker
	-- plural, as words: Young Murk Threshers = {npc:4388} Young Murk Thresher
	["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer. Young Murk Threshers (40-41) circle in the water around the docks: grab the footlocker and swim straight out."] = "Au sud-est du manoir jusqu'à {area:513} : {object:20925} gît au fond de la mer au large des quais, sur la côte est de l'île. Entrez et sortez à la nage et tenez-vous à l'écart des jetées et de la ville : les gardes de Theramore sont de niveau 53-57, et une mort ici vous coûte une longue course depuis le gardien des âmes. Des Jeunes batteurs des boues (40-41) tournent dans l'eau autour des quais : prenez la cantine et repartez droit vers le large.",
	["Underwater"] = "Sous l'eau",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike · {npc:4926} Krog
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} and {npc:4926} in the village."] = "Retournez vers l'ouest à Mur-de-Fougères avec la tête : {npc:4503} se tient à la lisière sud du village, là où arrive la route, {npc:4791} et {npc:4926} dans le village.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows
	["For {npc:2519} at {object:3202}, in the {zone:1434} & {zone:1435} guide"] = "",

	-- Step 20: Level 36
	["Level 36"] = "Niveau 36",
	-- {zone:1443} Desolace
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["{zone:1443}'s last quests are 36-39. Still below 36 after Brackenwall's hand-ins? The Drywallow Crocolisks (35-36) along the river east of the village are the closest at your level: kill them until level 36."] = "Les dernières quêtes de {zone:1443} sont de niveau 36-39. Toujours sous le niveau 36 après avoir rendu les quêtes de Mur-de-Fougères ? Les Crocilisques Sèchefange (35-36) le long de la rivière à l'est du village sont les plus proches à votre niveau : tuez-les jusqu'au niveau 36.",
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["Drywallow Crocolisks"] = "Crocilisques Sèchefange",
	-- {npc:4341} Drywallow Crocolisk
	["grind on {npc:4341}"] = "tuez en boucle : {npc:4341}",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "Maître de vol de {area:496}",

	-- Step 22: Ratchet
	-- {npc:3446} Mebok Mizzyrix
	["{npc:3446} stands below Gazlowe's house by the flight master, towards the docks."] = "{npc:3446} se tient sous la maison de Gazlowe, près du maître de vol, en direction des quais.",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Descendez la côte vers le sud depuis {area:392} jusqu'à {area:720}. {npc:6236} se tient près de l'arène : marchez sur la grille pour lancer le combat ; les adversaires arrivent un par un, puis {npc:6238} (33).",

	-- Step 24: Ratchet flight master
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",
	-- {area:392} Ratchet
	["Back north along the coast to {area:392}'s flight master."] = "Remontez la côte vers le nord jusqu'au Maître de vol de {area:392}.",

	-- Step 25: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "Prendre un vol pour {area:2408}",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["Fly to {area:2408} from the flight master you are next to: {area:392}'s, or Brackenwall's if you had no errand in {area:392}."] = "Prenez un vol pour {area:2408} depuis le Maître de vol le plus proche : celui de {area:392}, ou celui de Mur-de-Fougères si vous n'aviez rien à faire à {area:392}.",

	-- Step 26: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {npc:12340} Drulzegar Skraghook
	["{npc:11624} and {npc:12340} stand in the village."] = "{npc:11624} et {npc:12340} se tiennent dans le village.",
	-- {npc:12340} Drulzegar Skraghook · {area:599} Thunder Axe Fortress
	["{npc:12340}: the Slitherblade of Sar'theris Strand, on the way back from {area:599}"] = "{npc:12340} : les Ondulame du rivage de Sar'theris, au retour de {area:599}",
	-- {npc:11624} Taiga Wisemane · {quest:5381} Hand of Iruxos · {area:599} Thunder Axe Fortress
	["{npc:11624}: the {quest:5381}, at {area:599} later on this visit"] = "{npc:11624} : {quest:5381}, à {area:599} plus tard lors de ce passage",

	-- Step 27: Aka'rai
	-- {npc:268705} Aka'rai · {area:2408} Shadowprey Village · {area:603} Sargeron · {area:599} Thunder Axe Fortress
	["{npc:268705} stands by the path out of {area:2408}, on your way east: her Hatefury satyrs are at {area:603}, past {area:599} later on this visit."] = "",

	-- Step 28: Ghost Walker Post
	-- {area:597} Ghost Walker Post · {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["East along the road to {area:597}; {npc:5412} stands beside {npc:5395}."] = "Suivez la route vers l'est jusqu'à {area:597} ; {npc:5412} se tient à côté de {npc:5395}.",
	-- {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["{npc:5395}: his {quest:1366}, from the same Maraudine as Gurda's totems"] = "{npc:5395} : sa {quest:1366}, sur les mêmes Maraudine que les totems de Gurda",

	-- Step 29: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty · {npc:5402} Khan Hratha
	-- plural, as words: Rock Worms = {npc:11788} Rock Worm
	["West of the post, the Maraudine centaurs hold the {area:607}; every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Scouts and Wranglers (36-38) at the valley's eastern edge; the Maulers and Windchasers (38-39) a little further in are up to two over you at 37: pull them one at a time.\nCareful: {npc:5402} and the Rock Worms (41-42, elite) hold the valley's north-western end with the Khan Guards and Marauders (39-40), and the Magram's village in the south-east has Necromancers (42-43): keep east of the arrow."] = "À l'ouest du poste, les centaures Maraudine tiennent la {area:607} ; chaque Maraudine peut laisser tomber un {item:254432} et une oreille pour {quest:1366} de {npc:5395}. Restez sur les Éclaireurs et les Dresseurs (36-38) au bord est de la vallée ; les Écorcheurs et les Chasse-vent (38-39) un peu plus loin ont jusqu'à deux niveaux de plus que vous au niveau 37 : attirez-les un par un.\nAttention : {npc:5402} et les Vers des rochers (41-42, élites) tiennent l'extrémité nord-ouest de la vallée avec les Gardes du khan et les Maraudeurs (39-40), et le village Magram au sud-est abrite des Nécromanciens (42-43) : restez à l'est de la flèche.",

	-- Step 30: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: six centaurs attack during the escort, and you can't clear them beforehand: they appear only during the escort and come linked. In players' recordings 14 of 30 people who took it failed at least once. Bring a friend, or skip it if you are alone. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} est retenue au camp maraudine à l'extrémité ouest de la vallée ; libérez-la et escortez-la hors de la vallée vers l'est.\nAttention : six centaures attaquent pendant l'escorte, et vous ne pouvez pas les éliminer avant : ils n'apparaissent que pendant l'escorte et arrivent liés. Dans les enregistrements des joueurs, 14 des 30 personnes qui l'ont prise ont échoué au moins une fois. Venez avec un ami, ou passez-la si vous êtes seul. Éliminer les centaures normaux sur le chemin avant de commencer aide.",

	-- Step 31: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} attend au camp gobelin, du côté ouest du {area:596}.",
	-- {npc:6019} Hornizz Brimbuzzle · {area:602} Mannoroc Coven
	["{npc:6019}: the ghost-o-plasm, after {area:602} at the end of this visit"] = "{npc:6019} : l'ectoplasme, après {area:602} à la fin de cette visite",

	-- Step 33: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["North up the road to {area:599}. Clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}. The Burning Blade around it are well under you now."] = "Remontez la route vers le nord jusqu'à {area:599}. Nettoyez le centre du plus grand bâtiment, puis utilisez la {item:14523} sur le {object:176581} rouge qui s'y trouve. Un {npc:11876} (37) en sort : tuez-le pour obtenir la {item:13542}. Les membres de la Lame ardente autour sont désormais bien en dessous de votre niveau.",
	-- {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal
	["{item:14523}, on the {object:176581}"] = "{item:14523}, sur le {object:176581}",

	-- Step 34: Sargeron
	-- {area:603} Sargeron
	["East from the fortress to {area:603}, the Hatefury satyrs' ruins in the north-east (32-33, well under you now): two of each kind."] = "",

	-- Step 35: Sar'theris Strand
	-- {area:598} Sar'theris Strand
	-- plural, as words: Slitherblade Myrmidons = {npc:4714} Slitherblade Myrmidon
	-- was: ["West from the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "À l'ouest de la forteresse, jusqu'à la côte à {area:598} : les Myrmidons, Nagas et Ensorceleuses Ondulame tiennent la plage. Attirez-les un par un ; les Sorcières des mers et les Oracles (34-36) lancent des sorts à distance."
	["West past the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "",

	-- Step 36: Shadowprey Village
	-- {npc:268705} Aka'rai · {npc:11624} Taiga Wisemane · {area:602} Mannoroc Coven · {npc:12340} Drulzegar Skraghook
	-- was: ["South down the coast to Shadowprey: {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "Descendez la côte vers le sud jusqu'à Mort-Bois : {npc:11624} prend la boîte et vous envoie avec à {area:602} ; {npc:12340} prend les nagas."
	["South down the coast to Shadowprey: {npc:268705} first, on the path into the village; {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "",

	-- Step 37: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "Allez vers l'est jusqu'à {area:602}. Avec le {quest:5381} de {npc:11624} dans vos sacs, ouvrez l'anneau d'un portail démoniaque : un {npc:11937} (38-39) en sort ; tuez-le pour fermer ce portail. Six portails. Attention : des Infernaux, des Gardes funestes et des Invocateurs de la Lame ardente circulent près de nombreux portails et peuvent se joindre au combat ; tuez d'abord les monstres proches ou éloignez le gardien, par exemple vers le lac central du cercle.",

	-- Step 38: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {zone:1443} Desolace · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["South-east of the coven, the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge: keep south of the Magram's village on the way. Use the {item:15848} at the arrow to draw the Magrami Spectres (38-39): they come in numbers, so fight them with your back to the valley's edge. They drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "Au sud-est du cercle, les champs d'ossements de la {area:2657}, où rôdent des Ravageurs morts-vivants, à la limite sud de {zone:1443} : en chemin, restez au sud du village Magram. Utilisez la {item:15848} à la flèche pour attirer les Spectres magrami (38-39) : ils arrivent nombreux, alors combattez-les dos au bord de la vallée. Ils laissent tomber l'ectoplasme.\nAttention : des Nécrokhans magram et des Mange-cadavres (45, élites) parcourent les champs d'ossements juste à l'ouest de la flèche, bien au-dessus de vous : utilisez la caisse à la flèche, du côté est de la vallée, et attirez les spectres loin d'eux.",

	-- Step 39: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard · {area:602} Mannoroc Coven
	["North-west to the goblin camp on the west side of the {area:596}, back past {area:602}: keep west of the Magram's village."] = "Au nord-ouest jusqu'au camp gobelin, du côté ouest du {area:596}, en repassant par {area:602} : restez à l'ouest du village Magram.",

	-- Step 40: Shadowprey
	["Shadowprey"] = "Proie-de-l'Ombre",
	["Hearth to Shadowprey: your hearthstone is still bound there."] = "Pierre de foyer vers Mort-Bois : elle y est toujours liée.",

	-- Step 41: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "Prenez un vol de {area:2408} pour {area:1638} et allez vous entraîner auprès de {npc:3033} sur {area:1639} ; de là, continuez en vol jusqu'à {zone:1454}.",

	-- Step 42: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maître de vol de {area:2408}",

	-- Step 43: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "Retour à {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 44: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "{npc:4485} se tient dans la {object:172958}.",

	-- Step 45: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "L'atelier de {npc:3412} se trouve dans la {object:172958}, à côté de {npc:4485} : rendez {quest:2841} si vous avez fait {area:133}.",

	-- Step 46: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "Maîtres d'{zone:1454}",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "Entraînez-vous pendant que vous êtes en ville ; toutes les autres classes s'entraînent à {zone:1458}, ensuite.",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "Le prochain guide prend le zeppelin pour {zone:1458} depuis la tour devant la porte principale.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:496}"] = "Retour à {area:496}",
	-- ["Darkfang spiders"] = "Araignées Sombrecroc",
	-- ["Darkmist cavern"] = "Caverne Sombrebrume",
	-- ["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "Pour {npc:2519} à {object:3202}, dans forever/horde/40-50/01-stranglethorn-vale",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "Pour {npc:2519} à {object:3202}, dans le guide suivant",
	-- ["Head back west to Brackenwall with the head."] = "Retournez vers l'ouest jusqu'à Fougeraie avec la tête.",
	-- ["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "Retournez vers l'ouest à Mur-de-Fougères avec la tête : {npc:4503} se tient à la lisière sud du village, là où arrive la route, {npc:4791} dans le village.",
	-- ["Head east back to the {area:497}."] = "Retournez vers l'est jusqu'à {area:497}.",
	-- ["Head north to {npc:5412} at {area:597}."] = "Allez vers le nord jusqu'à {npc:5412}, à {area:597}.",
	-- ["Head north up the road to the hut by the road north of the graveyard."] = "Remontez la route vers le nord jusqu'à la hutte au bord de la route, au nord du cimetière.",
	-- ["Head on south-west to Shadowprey."] = "Continuez vers le sud-ouest jusqu'à Proie-de-l'Ombre.",
	-- ["Head south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Allez vers le sud depuis {area:2405} jusqu'à {area:607}. Les Éclaireurs, Dresseurs, Écharpeurs, Chasse-vent et Maraudeurs maraudine (36-39) lâchent {quest:93225}.",
	-- ["Head south-east from the coven to the bone fields of the {area:2657}, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "Allez vers le sud-est depuis le cercle jusqu'aux champs d'ossements de {area:2657}, où rôdent des Ravageurs morts-vivants. Tout au sud-est, utilisez la {item:15848} pour attirer les Spectres magrami : ils lâchent l'ectoplasme.",
	-- ["Head south-east to the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge. Use the {item:15848} at the arrow to draw the Magrami Spectres: they drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "Allez vers le sud-est jusqu'aux champs d'ossements de {area:2657}, où rôdent des Ravageurs morts-vivants, à la limite sud de {zone:1443}. Utilisez la {item:15848} à la flèche pour attirer les Spectres magrami : ils laissent tomber l'ectoplasme.\nAttention : des Nécrokhans magram et des Mange-cadavres (45, élites) parcourent les champs d'ossements juste à l'ouest de la flèche, bien au-dessus de vous : utilisez la caisse à la flèche, du côté est de la vallée, et attirez les spectres loin d'eux.",
	-- ["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Retraversez le marais vers l'ouest. Les Crache-venin Sombrecroc, sur les crêtes au nord de Fougeraie, lâchent les poches de venin. Les Infiltrateurs de Theramore (35-36) se faufilent dans les mêmes bois : ils sont camouflés, regardez bien.\nLes araignées de Sombrebrume grouillent à l'entrée de la caverne au nord-ouest de Fougeraie ; toutes lâchent des yeux.\nAttention : les Rôdeuses Sombrecroc (niveau 36-37) se camouflent hors combat et lancent Poison une fois en combat.\nAttention : des araignées camouflées dans la même zone vous attaquent à vue.\nAttention : les Rôdeuses de Sombrebrume se déplacent camouflées et utilisent du poison en combat. Les araignées sont serrées les unes contre les autres, les monstres en plus sont donc fréquents ; attirer des cibles isolées depuis le bord extérieur les limite.",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["His next errand is not on this route."] = "Sa course suivante ne fait pas partie de cette route.",
	-- ["Kodo bones"] = "Os de kodo",
	-- ["Kodo bones and ghosts"] = "Os de kodo et fantômes",
	-- ["Level 37.5"] = "Niveau 37.5",
	-- ["Maraudine totems"] = "Totems maraudine",
	-- ["North to the goblin camp on the west side of the {area:596}."] = "Au nord jusqu'au camp gobelin, du côté ouest du {area:596}.",
	-- ["North to the post; {npc:5412} stands beside {npc:5395}."] = "Vers le nord jusqu'au poste ; {npc:5412} se tient à côté de {npc:5395}.",
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
	-- ["South down the coast to Shadowprey: {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "Descendez la côte vers le sud jusqu'à Mort-Bois : {npc:11624} prend la boîte et vous envoie avec à {area:602} ; {npc:12340} prend les nagas.",
	-- ["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer."] = "Au sud-est du manoir jusqu'à {area:513} : {object:20925} gît au fond de la mer au large des quais, sur la côte est de l'île. Entrez et sortez à la nage et tenez-vous à l'écart des jetées et de la ville : les gardes de Theramore sont de niveau 53-57, et une mort ici vous coûte une longue course depuis le gardien des âmes.",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "La Lame ardente tient la forteresse au nord-ouest de la {area:2407}. Utilisez {item:14523} sur {npc:11876} dans la forteresse pour obtenir {item:13542}.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Les araignées de Sombrebrume grouillent à l'entrée de la caverne au nord-ouest de Mur-de-Fougères ; toutes laissent tomber des yeux.",
	-- ["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "Le Voyant se tient du côté sud de {area:599}, à l'est de {area:2405}. Éliminez d'abord les sectateurs autour.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Les Nagas Ondulame tiennent la côte au nord de {area:2405}, jusqu'à la {area:598}. {npc:12369} garde {quest:6027} tout au bout de la pointe nord.",
	-- ["The next guide takes you back to {zone:1434}."] = "Le guide suivant vous ramène à {zone:1434}.",
	-- ["West from the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "À l'ouest de la forteresse, jusqu'à la côte à {area:598} : les Myrmidons, Nagas et Ensorceleuses Ondulame tiennent la plage. Attirez-les un par un ; les Sorcières des mers et les Oracles (34-36) lancent des sorts à distance.",
	-- ["West of the post, the Maraudine centaurs hold the {area:607}. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Maraudine (36-39) in the valley: the Magram's village in the south-east has the same drops, but its Necromancers (42-43) and Guardians (39-41) are well above you."] = "À l'ouest du poste, les centaures maraudine tiennent la {area:607}. Chaque Maraudine peut laisser tomber un {item:254432} et une oreille pour la {quest:1366} de {npc:5395}. Restez avec les Maraudine (36-39) de la vallée : le village des Magram, au sud-est, donne les mêmes butins, mais ses Nécromanciens (42-43) et ses Gardiens (39-41) sont bien au-dessus de vous.",
	-- ["West to Shadowprey."] = "À l'ouest vers Proie-de-l'Ombre.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and head west through {zone:1412}), then on to {area:496}."] = "Votre maître est aux {area:1638} : volez-y (pas encore de trajet aérien ? volez jusqu'au {area:378} et allez vers l'ouest à travers {zone:1412}), puis jusqu'à {area:496}.",
	-- ["grind on {npc:4377}"] = "tuez en boucle : {npc:4377}",
	-- ["{npc:11624} stands in the village."] = "{npc:11624} se tient dans le village.",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "La caravane de {npc:11626} s'arrête sur la route en bordure de {area:602}. Escortez-la vers l'est au-delà du convent ; des démons l'attaquent deux fois.",
	-- ["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} est retenue dans le camp Maraudine, à l'extrémité ouest de la vallée ; libérez-la et escortez-la hors de la vallée, vers l'est.\nAttention : les groupes scénarisés sont liés et n'apparaissent que pendant l'escorte, vous ne pouvez donc pas les éliminer à l'avance ni les attirer un par un. Éliminer avant de commencer les centaures normaux sur le chemin aide quand même.",
	-- ["{npc:3391}: for {npc:4631} in {area:35}, on the first {area:35} stop of 40-50"] = "{npc:3391} : pour {npc:4631} à {area:35}, lors du premier passage à {area:35} du guide 40-50",
	-- ["{npc:4501}, below ground"] = "{npc:4501}, sous terre",
	-- ["{npc:4711} walks around {area:598}: look inside the circle on the map"] = "{npc:4711} se promène autour de {area:598} : cherchez dans le cercle sur la carte",
	-- ["{npc:4714} walks around {area:598}: look inside the circle on the map"] = "{npc:4714} se promène autour de {area:598} : cherchez dans le cercle sur la carte",
	-- ["{npc:4834} along the way to {area:496}"] = "{npc:4834} sur le chemin de {area:496}",
	-- ["{npc:4834} on the way"] = "{npc:4834} en chemin",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} attend dans {area:2302}, à l'est du village. Suivez-le jusqu'à Reethe et gardez-le en vie pendant le combat qui éclate.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of Smeed's camp."] = "{npc:5395} et {npc:5412} se tiennent dans le poste juste à l'ouest du camp de Smeed.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} et {npc:5412} se tiennent dans le poste juste à l'ouest du camp de {npc:11596}.",
	-- ["{npc:5395}: his {quest:1366}, from the same Maraudine"] = "{npc:5395} : sa {quest:1366}, sur les mêmes Maraudine",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236} : Posture berserker",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}, pour « Swamp Eye » Jarl",
	-- ["{zone:1443}'s last quests and Alterac are 38-41. Still below 37.5 after Brackenwall's hand-ins? The Darkmist spiders and Lurkers (35-38) by the cavern north-west of the village are the closest: kill them until level 37.5."] = "Les dernières quêtes de {zone:1443} et Alterac sont de niveau 38-41. Toujours en dessous de 37.5 après avoir rendu les quêtes de Mur-de-Fougères ? Les araignées Sombrebrume et les Rôdeurs (35-38) près de la caverne au nord-ouest du village sont les plus proches : tuez-les jusqu'au niveau 37.5.",
}
