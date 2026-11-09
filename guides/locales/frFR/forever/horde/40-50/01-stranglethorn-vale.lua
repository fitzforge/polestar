-- French (frFR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vol pour {object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Maître de vol de {area:340}",

	-- Step 2: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "",

	-- Step 3: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Traqueurs de la jungle",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Les Traqueurs de la jungle (40-41) chassent sur la côte au sud de Grom'gol. Ils sont bien au-dessus de vous : attirez-les un par un et reposez-vous entre les combats.",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maître de vol de Grom'gol",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495} : les peaux de Gueule d'acier ramassées plus tôt ; à l'intérieur",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",
	["Inside"] = "À l'intérieur",

	-- Step 7: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Quittez la ville par le tunnel ; la note se trouve dans la crique des pirates juste au nord de {area:35}.",

	-- Step 8: Booty Bay
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}, au dernier étage",

	-- Step 9: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Au sud de Baie-du-Butin, les bretteurs de la Voile sanglante campent sur {area:43} ; les cartes et les ordres se trouvent dans leurs tentes. Tout pirate de la Voile sanglante peut porter le tabac et l'œil de {npc:2493} : continuez jusqu'à avoir les deux.",

	-- Step 11: The Bloodsail ships
	["The Bloodsail ships"] = "Les navires de la Voile sanglante",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["Optional, and tough at 41: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "pour une étape ultérieure dans {zone:1435}",

	-- Step 12: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Prenez la route vers le nord hors de {area:35} ; Unbagwa est assis sur une colline de {area:1737}, à l'est de la route.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "Dans {area:1742}",

	-- Step 13: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilles de Valbrume",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Les gorilles parcourent la vallée autour d'Unbagwa. Les anciens laissent tomber les abats ; tous peuvent laisser tomber un croc.",

	-- Step 14: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Donnez les crocs à Unbagwa et restez près de lui : il appelle trois vagues de gorilles, puis {npc:1514}. Combattez-les un par un.",

	-- Step 16: Venture Co. mine
	["Venture Co. mine"] = "Mine de la KapitalRisk",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Plus au nord, les gobelins de la KapitalRisk creusent dans la mine à l'est de la route ; mineurs, contremaîtres, géomètres et bricoleurs lâchent tous les cristaux.\nAttention : des Panthères Ombregueule camouflées et des Tigresses de Strangleronce parcourent les environs du camp.",

	-- Step 18: Nesingwary's camp
	["Nesingwary's camp"] = "Camp de Nesingwary",
	["Head north up the road; the hunters camp on the hill above the river."] = "Remontez la route vers le nord ; les chasseurs campent sur la colline au-dessus de la rivière.",

	-- Step 20: Zul'Kunda
	["Zul'Kunda"] = "Ruines de Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {quest:586} Speaking with Gan'zulah · {area:1517} Uldaman
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "",
	-- {quest:586} Speaking with Gan'zulah
	["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "",

	-- Step 21: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "le {object:2076}, à côté de {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "",

	-- Step 22: Jungle stalkers
	["Jungle stalkers"] = "Traqueurs de la jungle",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Les raptors traqueurs chassent dans la jungle au sud de {object:3202}, vers la côte ouest.",

	-- Step 23: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577} : tuez-les au passage",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Suivez la côte vers le sud. Les explorateurs nagas pataugent le long du rivage et portent les bottes de roseaux ; {object:759} bouillonne dans les collines juste à l'est.",

	-- Step 24: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Allez vers le sud jusqu'à {area:35}. Shaky Phillipe attend sur les quais.",
	-- {npc:6807} Innkeeper Skindle
	["{npc:6807}, upstairs"] = "{npc:6807}, à l'étage",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "",

	-- Step 25: Zanzil's camps
	["Zanzil's camps"] = "Les camps de Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Au nord-est de Valbrume, les disciples de Zanzil campent dans la jungle ; chacun d'eux peut porter le mélange.",

	-- Step 26: Pirate ghosts
	["Pirate ghosts"] = "Pirates fantômes",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Les trois pirates fantômes hantent la jungle au nord de {area:35}, près des camps de Zanzil : {npc:2535} et {npc:2536} se tiennent ensemble, {npc:2537} plus à l'est.",

	-- Step 27: Zul'Mamwe
	["Zul'Mamwe"] = "Ruines de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Allez vers le nord jusqu'aux ruines Skullsplitter, à l'est de la mine de la KapitalRisk ; attirez les chasseurs de têtes et les berserkers un par un. {npc:1059} garde les ruines du sud-ouest, et un tas de crânes trophées se trouve du côté nord des ruines. Chaque Skullsplitter peut lâcher une défense ou un collier : les colliers sont la partie lente, alors continuez à tuer dans le camp des guerriers au nord des ruines jusqu'à les avoir tous.",
	["Skullsplitter warriors"] = "Guerriers Skullsplitter",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} se promène par ici : cherchez dans le cercle sur la carte",
	["Below ground"] = "Sous terre",

	-- Step 28: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "{area:127} : tuez-les au passage",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "",

	-- Step 29: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "Allez vers l'ouest jusqu'à Grom'gol.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "le {object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "",

	-- Step 31: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, à l'intérieur",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, à l'étage",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "",

	-- Step 32: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basilics gueule de fer",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "",

	-- Step 33: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride on north to {object:3202}."] = "",

	-- Step 35: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Remontez la route vers le nord jusqu'au camp des chasseurs.",

	-- Step 37: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:730} est un élite de niveau 43 : la plupart des classes le tuent seules au niveau 45, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",

	-- Step 38: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:728} est un élite de niveau 40 : la plupart des classes le tuent seules au niveau 42, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",

	-- Step 42: Level 42.68
	["Level 42.68"] = "Niveau 42.68",
	-- {quest:192} Panther Mastery · {quest:195} Raptor Mastery · {area:1517} Uldaman
	["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "tuez en boucle : {npc:667}",

	-- Step 43: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. Le {npc:731} est un élite de niveau 43 : la plupart des classes le tuent seules au niveau 45, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.\nAttention : des tigres et des panthères Ombregueule camouflées rôdent près de lui. Éliminez-les avant de l'attirer. Une fois attiré, le {npc:731} appelle à l'aide les créatures à moins de 20 m.",

	-- Step 45: Level 42.74
	["Level 42.74"] = "Niveau 42.74",
	-- {quest:208} Big Game Hunter · {area:1517} Uldaman
	["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "",

	-- Step 49: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "Vers {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "",

	-- Step 50: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road. Bind here."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, à l'intérieur",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}, à l'étage",
	-- {npc:6930} Innkeeper Karakul
	["{npc:6930}, upstairs"] = "{npc:6930}, à l'étage",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, au dernier étage",

	-- Step 51: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocilisques Dents-de-scie",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Les crocilisques se vautrent dans les mares autour du camp de {npc:5391} et vers le sud jusqu'à {area:75} ; environ un sur quatre laisse tomber un flanc.",

	-- Step 52: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru erre dans la clairière au sud-ouest de {area:76} ; son gourdin lance une quête.",

	-- Step 53: Draenethyst crystals
	["Draenethyst crystals"] = "Cristaux de draenéthyste",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Chevauchez vers le nord-est jusqu'à {area:76}. Les cristaux se dressent le long du chemin qui monte vers la cage de {npc:5391}.",

	-- Step 54: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} est retenu à {area:76}, dans le nord-est du marais. Libérez-le et suivez-le dehors en repoussant les créatures du marais qui le poursuivent.",

	-- Step 55: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "",

	-- Step 56: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Bateau pour {area:35}",
	-- ["Boat to {area:392}"] = "Bateau pour {area:392}",
	-- ["Fly to {area:392}"] = "Vol pour {area:392}",
	-- ["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- ["From {area:2408} fly to {area:392}."] = "Depuis {area:2408}, prenez un vol pour {area:392}.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Plus au nord, les gobelins de la KapitalRisk creusent la mine à l'est de la route ; mineurs, contremaîtres, géomètres et bricoleurs laissent tous tomber les cristaux.",
	-- ["Head east to {area:75}, in the reeds south of the road."] = "Allez vers l'est jusqu'à {area:75}, dans les roseaux au sud de la route.",
	-- ["Hearth to {area:117}"] = "Pierre de foyer vers {area:117}",
	-- ["Hearth to {area:35}"] = "Pierre de foyer vers {area:35}",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["Hearth to {object:3202}"] = "Pierre de foyer vers {object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "Son coffre attend à son ancien camp au nord de {area:75}.",
	-- ["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "Si vous avez passé {quest:192} ou {quest:195}, tuez des monstres ici jusqu'au niveau 42.68 pour rester dans le plan de la route.",
	-- ["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "Si vous avez passé {quest:208}, tuez des monstres ici jusqu'au niveau 42.74 pour rester dans le plan de la route.",
	-- ["Into the {area:8}"] = "Vers le {area:8}",
	-- ["Keep going north into {area:10}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Continuez vers le nord jusqu'au {area:10}, puis vers l'est par la route à travers le {zone:1430} jusqu'au marais. {npc:1776} attend à {area:657}, le camp draeneï près de l'entrée depuis le {zone:1430}.",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Continuez vers le nord jusqu'à {zone:1431}, puis vers l'est par la route à travers {zone:1430} jusqu'au marais. {npc:1776} attend à {area:657}, le camp draeneï près de l'entrée depuis {zone:1430}.",
	-- ["Naga shore and the {object:759}"] = "Rivage des nagas et {object:759}",
	-- ["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptors : Zjolnir, à côté de {npc:7953}, à {area:367}.",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Revenez vers l'est après {area:75} et suivez la route vers le sud-est jusqu'au petit poste de la Horde sur le rivage.",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "Chevauchez vers l'est jusqu'à {area:75}, dans les roseaux au sud de la route.",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Chevauchez vers le nord jusqu'aux ruines Skullsplitter à l'est de la mine de la KapitalRisk ; attirez les chasseurs de têtes et les berserkers un par un. {npc:1059} garde les ruines du sud-ouest, et un tas de crânes trophées se trouve au nord des ruines. Tout Skullsplitter peut laisser tomber une défense ou un collier : les colliers sont la partie lente, alors continuez à tuer dans le camp des guerriers au nord des ruines jusqu'à les avoir tous.",
	-- ["Ride north up the road to the hunters' camp."] = "Remontez la route vers le nord jusqu'au camp des chasseurs.",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Remontez la route vers le nord ; les chasseurs campent sur la colline au-dessus de la rivière.",
	-- ["Ride north-west to {object:3202}."] = "Chevauchez vers le nord-ouest jusqu'à {object:3202}.",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Chevauchez vers le sud jusqu'à {area:35}. Phillippe le Chancelant attend sur les quais.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Chevauchez vers l'ouest le long de la route jusqu'au camp draeneï de {area:657}, près de l'entrée depuis {zone:1430}.",
	-- ["Ride west to {object:3202}."] = "Chevauchez vers l'ouest jusqu'à {object:3202}.",
	-- ["Riding at 40"] = "La monte au niveau 40",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Another race's trainer (Kildar in {zone:1454}) teaches you only once you are Exalted with his city."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. Chaque race l'apprend auprès de son propre maître : le vôtre est {npc:7953}, à {area:367}, sur la côte de {zone:1411}, avec les raptors de Zjolnir (20 pièces d'or chacun) à côté de lui. Le maître d'une autre race (Kildar à {zone:1454}) ne vous l'enseigne qu'une fois Exalté auprès de sa ville.",
	-- ["Sawtooth snappers"] = "Mordeurs Dents-de-scie",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both.\nTake the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Au sud de Baie-du-Butin, les bretteurs de la Voile sanglante campent sur {area:43} ; les cartes et les ordres sont dans leurs tentes. Tout membre de la Voile sanglante peut porter du tabac à priser et l'œil de {npc:2493} : continuez à tuer jusqu'à avoir les deux.\nPrenez la route vers le sud en direction de {area:35}. Les Anciens gorilles de Valbrume (40-41) vivent dans {area:1737}, à l'est de la route ; environ un sur vingt porte un tendon vieilli.",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Le bateau accoste dans le port de {area:35}. Les donneurs de quête se tiennent sur les passerelles autour du port et dans l'auberge.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Le bateau pour {area:35} accoste au bout du ponton de {area:392}.",
	-- ["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank.\nCareful: {npc:5592}'s camp sits by the coast. Along the way to it you pass level 40 spiders that chase a long distance, plus stealthed Shadow Panthers."] = "Les crocilisques se vautrent dans les mares autour du camp de {npc:5391} et au sud vers {area:75} ; environ un sur quatre lâche un flanc.\nAttention : le camp de {npc:5592} se trouve près de la côte. En chemin, vous passez près d'araignées de niveau 40 qui poursuivent loin, ainsi que de Panthères des ombres camouflées.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Les derniers crânes sont dans les ruines un peu à l'ouest, sur le chemin du retour vers {object:3202}.",
	-- ["The next guide flies you north to {area:272} and into the {zone:1417}."] = "Le prochain guide vous fait voler vers le nord jusqu'à {area:272} et dans les {zone:1417}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "Le guide suivant commence ici et vous emmène en {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Les crânes trophées suivants se trouvent dans les petites ruines juste au nord du camp des guerriers.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Les crânes trophées suivants se trouvent dans les petites ruines juste au nord du camp des guerriers.\nLes derniers crânes sont dans les ruines un peu plus à l'ouest, sur le chemin du retour vers Grom'gol.",
	-- ["The snappers line the strand south of the post."] = "Les mordeurs bordent la grève au sud du poste.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Les trois navires sont au large de {area:43}. Les équipages sont de niveau 42-45, Stillwater 45, Keelhaul 46 et {npc:2546} 48 : au niveau 41, c'est un combat pour un groupe, ou pour la fin du guide. Si vous y allez, nagez jusqu'aux navires et attirez l'équipage au bastingage un par un. Un parchemin, {quest:624}, se trouve sur le pont des navires : prenez-le.",
	-- ["The {area:657}"] = "{area:657}",
	-- ["To {area:392}"] = "Vers {area:392}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "À l'ouest de l'expédition, les chefs Bloodscalp {npc:1061} et {npc:1062} se tiennent ensemble dans les Ruines de Zul'Kunda. Éliminez d'abord leurs gardes, puis attirez-les.",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Vous commencez à {area:75}. Faites de cette auberge votre foyer : vous y reviendrez avec la pierre de foyer après la côte.",
	-- ["for Stoley in {zone:1446}"] = "pour Stoley en {zone:1446}",
	-- ["for Stoley in {zone:1446}; on the top floor"] = "pour Stoley en {zone:1446} ; au dernier étage",
	-- ["for a later stop in the {area:8}"] = "pour un arrêt plus tard dans {area:8}",
	-- ["for later: the {zone:1425}, around level 48"] = "pour plus tard : {zone:1425}, vers le niveau 48",
	-- ["the {object:2076}, beside Nimboya"] = "le {object:2076}, à côté de Nimboya",
	-- ["the {object:2076}, beside {npc:2497}"] = "le {object:2076}, à côté de {npc:2497}",
	-- ["{area:1737}: kill these as you meet them"] = "{area:1737} : tuez-les au passage",
	-- ["{area:35} flight master"] = "Maître de vol de {area:35}",
	-- ["{area:392} pier"] = "Ponton de {area:392}",
	-- ["{area:75} flight master"] = "Maître de vol de {area:75}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773} : pour {quest:2864} à {area:976}",
	-- ["{npc:773}: for {quest:2864} in {area:976}; upstairs"] = "{npc:773} : pour {quest:2864} à {area:976} ; à l'étage",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, maître de monte",
}
